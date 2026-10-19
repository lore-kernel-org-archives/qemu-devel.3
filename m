Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id DE762CCA490
	for <qemu-devel@archiver.kernel.org>; Mon, 19 Oct 2026 01:33:53 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xIcFn-00046T-20; Sun, 18 Oct 2026 21:33:31 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <daejun7.park@samsung.com>)
 id 1xIcFb-00044u-Vz
 for qemu-devel@nongnu.org; Sun, 18 Oct 2026 21:33:21 -0400
Received: from mailout4.samsung.com ([203.254.224.34])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <daejun7.park@samsung.com>)
 id 1xIcFY-0005XL-55
 for qemu-devel@nongnu.org; Sun, 18 Oct 2026 21:33:19 -0400
Received: from epcas2p2.samsung.com (unknown [182.195.41.54])
 by mailout4.samsung.com (KnoxPortal) with ESMTP id
 20261019013309epoutp044acbce4d185a08981477294581c36f92~fykh0MOe80890608906epoutp04Y
 for <qemu-devel@nongnu.org>; Mon, 19 Oct 2026 01:33:09 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout4.samsung.com
 20261019013309epoutp044acbce4d185a08981477294581c36f92~fykh0MOe80890608906epoutp04Y
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
 s=mail20170921; t=1792373589;
 bh=z+kKkpNDuheUAiw9xRSS/lVFIdaqT0DhbO83DgC18Ng=;
 h=Subject:Reply-To:From:To:CC:In-Reply-To:Date:References:From;
 b=VV+yOF1YS85YkdymxUA0SpXQ5nRQ5Ih1gKLUVSOs3Zj9O/lTcRIFW5EpraewdKpzV
 fzG83lid15oLuZCAZ5jICpVsuntL3Ihv7+bFcZSvAPkcmIX3QMwJUI5et7GATXCnmp
 KSulNhyTcnZk32G/+z/282AgQqbM5DGZzG3f+pO0=
Received: from epsnrtp04.localdomain (unknown [182.195.42.156]) by
 epcas2p3.samsung.com (KnoxPortal) with ESMTPS id
 20261019013308epcas2p344c515c86c13201e7dc115c6879909e5~fykhhEReg2392023920epcas2p3i;
 Mon, 19 Oct 2026 01:33:08 +0000 (GMT)
Received: from epcas2p1.samsung.com (unknown [182.195.38.201]) by
 epsnrtp04.localdomain (Postfix) with ESMTP id 4j7J2r4BBXz6B9m5; Mon, 19 Oct
 2026 01:33:08 +0000 (GMT)
Mime-Version: 1.0
Subject: RE:(2) [PATCH v2 3/6] hw/ufs: Limit data transfers to the transfer
 length of the CDB
From: Daejun Park <daejun7.park@samsung.com>
To: Stanley Jhu <stanleyjhu@google.com>, "qemu-devel@nongnu.org"
 <qemu-devel@nongnu.org>
CC: Jeuk Kim <jeuk20.kim@samsung.com>, "farosas@suse.de" <farosas@suse.de>,
 "lvivier@redhat.com" <lvivier@redhat.com>, "pbonzini@redhat.com"
 <pbonzini@redhat.com>, "kwolf@redhat.com" <kwolf@redhat.com>,
 "hreitz@redhat.com" <hreitz@redhat.com>, "qemu-block@nongnu.org"
 <qemu-block@nongnu.org>, "pierrick.bouvier@oss.qualcomm.com"
 <pierrick.bouvier@oss.qualcomm.com>, Daejun Park <daejun7.park@samsung.com>
X-Priority: 3
X-Content-Kind-Code: NORMAL
In-Reply-To: <20261016115434.2658500-1-stanleyjhu@google.com>
X-CPGS-Detection: blocking_info_exchange
X-Drm-Type: N,general
X-Msg-Generator: Mail
X-Msg-Type: PERSONAL
X-Reply-Demand: N
Message-ID: <20261019013307epcms2p14049cf5797cbe5332877ddeb950f18bc@epcms2p1>
Date: Mon, 19 Oct 2026 10:33:07 +0900
X-CMS-MailID: 20261019013307epcms2p14049cf5797cbe5332877ddeb950f18bc
Content-Transfer-Encoding: 7bit
Content-Type: text/plain; charset="utf-8"
X-Sendblock-Type: AUTO_CONFIDENTIAL
CMS-TYPE: 102P
X-CPGSPASS: Y
X-CPGSPASS: Y
cpgsPolicy: CPGSC10-223,Y
X-CFilter-Loop: Reflected
X-CMS-RootMailID: 20261016115443epcas2p1a0e9a64b6bb3eaceb606461b5f90033b
References: <20261016115434.2658500-1-stanleyjhu@google.com>
 <20261016092423epcms2p83f80a8dd8f7c1ddc3a94541e0771c306@epcms2p8>
 <20261016093109epcms2p4a1f77d99f9f4fd50fa786eeb79fe1cf5@epcms2p4>
 <CGME20261016115443epcas2p1a0e9a64b6bb3eaceb606461b5f90033b@epcms2p1>
Received-SPF: pass client-ip=203.254.224.34;
 envelope-from=daejun7.park@samsung.com; helo=mailout4.samsung.com
X-Spam_score_int: -47
X-Spam_score: -4.8
X-Spam_bar: ----
X-Spam_report: (-4.8 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.34,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_MED=-2.3, RCVD_IN_MSPIKE_H3=-0.01, RCVD_IN_MSPIKE_WL=-0.01,
 SPF_HELO_PASS=-0.001, SPF_NONE=0.001 autolearn=unavailable autolearn_force=no
X-Spam_action: no action
X-BeenThere: qemu-devel@nongnu.org
X-Mailman-Version: 2.1.29
Precedence: list
List-Id: qemu development <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <https://lists.nongnu.org/archive/html/qemu-devel>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=subscribe>
Reply-To: daejun7.park@samsung.com
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org

On Fri, 16 Oct 2026 19:54:34 +0800, Stanley Jhu wrote:
> On Fri, 16 Oct 2026 18:31:09 +0900, Daejun Park wrote:
>> +    if (req->sg && req->sg->size > scsi_req->cmd.xfer) {
>> +        ufs_limit_sg_list(req, scsi_req->cmd.xfer);
>> +    }
>
> This handles a PRDT that is larger than the CDB. Does a PRDT that is
> smaller than the CDB need to be handled as well? If so, could that be
> done on the host controller side instead of in the LU?

Thanks, yes. Today scsi-hd moves only what the SG list holds and
completes with GOOD, and on a zoned LU the write pointer moves past
blocks that were not written.

UFSHCI reports a data buffer that is too small with OCS MISMATCH DATA
BUFFER SIZE, so the status belongs to ufs.c. ufs.c does not parse the
CDB, though; the LU does, in scsi_req_new(). In v3 the LU would pass
the transfer length to ufs.c, and ufs.c would fail the request with
that OCS when the PRDT is smaller, before scsi-hd sees it and with the
write pointer unchanged. Would that split work for you?

Daejun

