Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B62B4D35163
	for <qemu-devel@archiver.kernel.org>; Wed,  1 Apr 2026 09:12:59 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1w7rWm-0004K0-Rn; Wed, 01 Apr 2026 05:06:20 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jaemyung.lee@samsung.com>)
 id 1w7rVh-0003Tf-3G
 for qemu-devel@nongnu.org; Wed, 01 Apr 2026 05:05:16 -0400
Received: from mailout1.samsung.com ([203.254.224.24])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jaemyung.lee@samsung.com>)
 id 1w7rVc-0002jT-BA
 for qemu-devel@nongnu.org; Wed, 01 Apr 2026 05:05:12 -0400
Received: from epcas2p2.samsung.com (unknown [182.195.41.54])
 by mailout1.samsung.com (KnoxPortal) with ESMTP id
 20260401090458epoutp0193e08b723ba83a65606ff9aaabda2abf~iMEow2ffs0798807988epoutp011
 for <qemu-devel@nongnu.org>; Wed,  1 Apr 2026 09:04:58 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout1.samsung.com
 20260401090458epoutp0193e08b723ba83a65606ff9aaabda2abf~iMEow2ffs0798807988epoutp011
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
 s=mail20170921; t=1775034298;
 bh=kIz0bFQ8TwpvCyO3hTsN2pEoYJ9o8hX32z22kwgp+zU=;
 h=Subject:Reply-To:From:To:CC:Date:References:From;
 b=MVYjJJyvCPw6mOt78QiLUQgvfs4DNi5Fucgn12d6b8Omv/gJJT0CM9CUcr+ltCqWR
 IP6Az4YI3YfAmOx4QezFEnRTawSWGHm4dxnoiS2GB8DvZ0Gd3j1Xz618+5FJtnl4Z6
 lMeXHmKQiA1Ff97M5JIgcpOrQ15OMVIr3v2d6FdQ=
Received: from epsnrtp04.localdomain (unknown [182.195.42.156]) by
 epcas2p3.samsung.com (KnoxPortal) with ESMTPS id
 20260401090458epcas2p337ec79d40fc32bc73a098c12c191d21d~iMEogw8lr1966619666epcas2p3Q;
 Wed,  1 Apr 2026 09:04:58 +0000 (GMT)
Received: from epcas2p3.samsung.com (unknown [182.195.38.205]) by
 epsnrtp04.localdomain (Postfix) with ESMTP id 4flzZx5b3Pz6B9mH; Wed,  1 Apr
 2026 09:04:57 +0000 (GMT)
Mime-Version: 1.0
Subject: [PATCH RESEND 0/5] hw/ufs: Add Write Booster Support on UFS
From: Jaemyung Lee <jaemyung.lee@samsung.com>
To: "qemu-devel@nongnu.org" <qemu-devel@nongnu.org>
CC: Jeuk Kim <jeuk20.kim@samsung.com>, "kwolf@redhat.com"
 <kwolf@redhat.com>, "hreitz@redhat.com" <hreitz@redhat.com>,
 "qemu-block@nongnu.org" <qemu-block@nongnu.org>, "farosas@suse.de"
 <farosas@suse.de>, "lvivier@redhat.com" <lvivier@redhat.com>,
 "pbonzini@redhat.com" <pbonzini@redhat.com>
X-Priority: 3
X-Content-Kind-Code: NORMAL
X-CPGS-Detection: blocking_info_exchange
X-Drm-Type: N,general
X-Msg-Generator: Mail
X-Msg-Type: PERSONAL
X-Reply-Demand: N
Message-ID: <20260401090457epcms2p2368a82c8b794d8591aa62a421db9e8f7@epcms2p2>
Date: Wed, 01 Apr 2026 18:04:57 +0900
X-CMS-MailID: 20260401090457epcms2p2368a82c8b794d8591aa62a421db9e8f7
Content-Transfer-Encoding: 7bit
Content-Type: text/plain; charset="utf-8"
X-Sendblock-Type: AUTO_CONFIDENTIAL
CMS-TYPE: 102P
cpgsPolicy: CPGSC10-223,Y
X-CFilter-Loop: Reflected
X-CMS-RootMailID: 20260330112748epcms2p1717e93009f7fb87a8156ee07a9400502
References: <CGME20260330112748epcms2p1717e93009f7fb87a8156ee07a9400502@epcms2p2>
Received-SPF: pass client-ip=203.254.224.24;
 envelope-from=jaemyung.lee@samsung.com; helo=mailout1.samsung.com
X-Spam_score_int: -13
X-Spam_score: -1.4
X-Spam_bar: -
X-Spam_report: (-1.4 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.54,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_LOW=-0.7, RCVD_IN_MSPIKE_H3=-0.01, RCVD_IN_MSPIKE_WL=-0.01,
 RCVD_IN_VALIDITY_CERTIFIED_BLOCKED=1, RCVD_IN_VALIDITY_RPBL_BLOCKED=1,
 SPF_HELO_PASS=-0.001, SPF_PASS=-0.001 autolearn=no autolearn_force=no
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
Reply-To: jaemyung.lee@samsung.com
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org

Currently, the QEMU-UFS emulation is implemented based on the JEDEC UFS
4.0 Specification and does not support the operation related to UFS Extended
Features which is defined with latest UFS Specifications.

This series modifies the UFS core implementation to align with the JEDEC
UFS 4.1 Specification[1], and adds a Write Booster UFS Extended Feature
supportability.

Tested: x86-64 KVM, upstream QEMU with Debian GNU/Linux 10
Resending: Fix corrupted plain-text

[1]
https://jedec.org/standards-documents/focus/flash/universal-flash-storage-ufs

Jaemyung Lee (5):
  hw/ufs: Apply UFS 4.1 Specification
  hw/ufs: Modify flag handling operation
  hw/ufs: Add IDLE operation
  hw/ufs: Add UFS Write Booster Support
  tests/qtest: Add UFS Write Booster QTest

 hw/ufs/lu.c            |  85 ++++++
 hw/ufs/ufs.c           | 569 ++++++++++++++++++++++++++++++++++++++---
 hw/ufs/ufs.h           |  42 +++
 include/block/ufs.h    | 110 +++++++-
 tests/qtest/ufs-test.c | 176 +++++++++++++
 5 files changed, 938 insertions(+), 44 deletions(-)

--
2.34.1

