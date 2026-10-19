Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A6CF4CCA490
	for <qemu-devel@archiver.kernel.org>; Mon, 19 Oct 2026 01:33:29 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xIcF8-00042t-RQ; Sun, 18 Oct 2026 21:32:51 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <daejun7.park@samsung.com>)
 id 1xIcF6-00042L-Br
 for qemu-devel@nongnu.org; Sun, 18 Oct 2026 21:32:48 -0400
Received: from mailout3.samsung.com ([203.254.224.33])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <daejun7.park@samsung.com>)
 id 1xIcF1-0005QR-Nv
 for qemu-devel@nongnu.org; Sun, 18 Oct 2026 21:32:48 -0400
Received: from epcas2p4.samsung.com (unknown [182.195.41.56])
 by mailout3.samsung.com (KnoxPortal) with ESMTP id
 20261019013233epoutp03b0237a1d765ebd79edf4be2248db0314~fykAKtvWJ2793727937epoutp03d
 for <qemu-devel@nongnu.org>; Mon, 19 Oct 2026 01:32:33 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout3.samsung.com
 20261019013233epoutp03b0237a1d765ebd79edf4be2248db0314~fykAKtvWJ2793727937epoutp03d
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
 s=mail20170921; t=1792373553;
 bh=yUSNrpaR/gqi659mVqzvoV5x4SFVRMLgQKV8W82DQr0=;
 h=Subject:Reply-To:From:To:CC:In-Reply-To:Date:References:From;
 b=ajYZY0cYs9HfeFe+DuvP8HOXFDcB+NCftuzdLBNExTz+M1Ro6mBbzgy+pcqQELOdR
 WXMIRCGDT/46/1oAoCG62dppsdbCnO1zqpw/7BK+HxtOgzpdwaRJz1mYLthGc/ZNUh
 bzVfoUItO/dtJoWuZaazmeGLeGt/1zzvbCn/hlgg=
Received: from epsnrtp02.localdomain (unknown [182.195.42.154]) by
 epcas2p4.samsung.com (KnoxPortal) with ESMTPS id
 20261019013232epcas2p442217c62fdc048ea2e71ef4e63a5327c~fyj-zLjTo1667716677epcas2p47;
 Mon, 19 Oct 2026 01:32:32 +0000 (GMT)
Received: from epcas2p1.samsung.com (unknown [182.195.38.206]) by
 epsnrtp02.localdomain (Postfix) with ESMTP id 4j7J282hTBz2SSKm; Mon, 19 Oct
 2026 01:32:32 +0000 (GMT)
Mime-Version: 1.0
Subject: RE:(2) [PATCH v2 5/6] hw/ufs: Support for Zoned UFS
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
In-Reply-To: <20261016115436.2659347-1-stanleyjhu@google.com>
X-CPGS-Detection: blocking_info_exchange
X-Drm-Type: N,general
X-Msg-Generator: Mail
X-Msg-Type: PERSONAL
X-Reply-Demand: N
Message-ID: <20261019013231epcms2p40fbdbb2afdaf0cd29381c768e8963f03@epcms2p4>
Date: Mon, 19 Oct 2026 10:32:31 +0900
X-CMS-MailID: 20261019013231epcms2p40fbdbb2afdaf0cd29381c768e8963f03
Content-Transfer-Encoding: 7bit
Content-Type: text/plain; charset="utf-8"
X-Sendblock-Type: AUTO_CONFIDENTIAL
CMS-TYPE: 102P
X-CPGSPASS: Y
X-CPGSPASS: Y
cpgsPolicy: CPGSC10-223,Y
X-CFilter-Loop: Reflected
X-CMS-RootMailID: 20261016115442epcas2p424720f88a9ba204e23c5b498f01ed35e
References: <20261016115436.2659347-1-stanleyjhu@google.com>
 <20261016092423epcms2p83f80a8dd8f7c1ddc3a94541e0771c306@epcms2p8>
 <20261016093343epcms2p8d5801bd57384c44d5120ae0b7c4eb206@epcms2p8>
 <CGME20261016115442epcas2p424720f88a9ba204e23c5b498f01ed35e@epcms2p4>
Received-SPF: pass client-ip=203.254.224.33;
 envelope-from=daejun7.park@samsung.com; helo=mailout3.samsung.com
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

On Fri, 16 Oct 2026 19:54:36 +0800, Stanley Jhu wrote:
> On Fri, 16 Oct 2026 18:33:43 +0900, Daejun Park wrote:
>> +    case WRITE_SAME_10:
>
> As far as I can see, JESD220H does not list WRITE SAME among the UFS
> commands. Would it make sense to reject WRITE SAME(10/16) on a zoned
> LU?

Thanks, agreed. Linux ufshcd sets no_write_same on every UFS logical
unit, so Linux guests do not depend on it.

v3 will fail WRITE SAME(10) and WRITE SAME(16) on a zoned LU with
INVALID COMMAND OPERATION CODE, as it does UNMAP. This also removes a
case where the write pointer runs ahead of the data: scsi-hd completes
a WRITE SAME with NDOB=1 with GOOD without writing anything, after the
zone check has moved the write pointer.

Regular LUs keep passing WRITE SAME to scsi-hd as today; if they
should reject it too, I can send that as a separate patch.

Daejun

