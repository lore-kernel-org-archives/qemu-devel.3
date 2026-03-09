Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 159CDEFCD92
	for <qemu-devel@archiver.kernel.org>; Mon,  9 Mar 2026 10:32:49 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vzXuV-00067H-V0; Mon, 09 Mar 2026 06:32:28 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from
 <bounce-md_30504962.69ae9dc7.v1-a1a9f8af29314422bd95843cc0b24db1@bounce.vates.tech>)
 id 1vzXuR-00064X-7T
 for qemu-devel@nongnu.org; Mon, 09 Mar 2026 06:32:25 -0400
Received: from mail132-19.atl131.mandrillapp.com ([198.2.132.19])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from
 <bounce-md_30504962.69ae9dc7.v1-a1a9f8af29314422bd95843cc0b24db1@bounce.vates.tech>)
 id 1vzXuO-0006Z1-8P
 for qemu-devel@nongnu.org; Mon, 09 Mar 2026 06:32:22 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=mandrillapp.com;
 s=mte1; t=1773051336; x=1773321336;
 bh=WT0SylEBpMCEz50mi1VO5bCYNnAqM2EjVLiN1Dm+TEQ=;
 h=From:Subject:To:Cc:Message-Id:In-Reply-To:References:Feedback-ID:
 Date:MIME-Version:Content-Type:Content-Transfer-Encoding:CC:Date:
 Subject:From;
 b=aZX++omEOKKqpVdTcO/RRlUI1KpMdaauorNzlyiGnrRWs4XEoJkA7Gh27BR5/KvJY
 q9DRdgYQcneSz+d5nJteTAILr5jiXZ/NvZOlO+4gVuT3dfOwtNDfjpZNDDmngpXpb2
 yyZNRSuX/biH0vb6/JrNXJmN0J4Dp67MOImk37ZNLnXM/N/9Yx8JdeiWh/16a7De2C
 OLasNPhnzR0qkUMMrtjoaY32dqeelFugcOCWjookFcwY/IJkUIYgoB6IlHw+pymAKN
 lFw+fmwFYzHtAYi1O1Ivb6RBiCLYewWxgBPDIAPp0Sfsd5sP4tddItmFyvf3dl5z6o
 f+xYZALpO0PGQ==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=vates.tech; s=mte1;
 t=1773051336; x=1773311836; i=anthony.perard@vates.tech;
 bh=WT0SylEBpMCEz50mi1VO5bCYNnAqM2EjVLiN1Dm+TEQ=;
 h=From:Subject:To:Cc:Message-Id:In-Reply-To:References:Feedback-ID:
 Date:MIME-Version:Content-Type:Content-Transfer-Encoding:CC:Date:
 Subject:From;
 b=qOPwUBg7MWmvmqRLB7QSMXRSsmMDbt/YmSenijqsRW048REtvsPQRECzmxw9QP8jD
 32qiMWwIwfm6AATo497UigHQjMl5H2pxUWjjzO61BR/ClJZxBnbyRFe5umpG/emhiY
 3U1XiT7KVTZDN59QNq69OzuYorBd0znFXHRVHHH4m0mfhLYU2FGGuj4w424DYQDV/P
 Fxka+89jXc9//ziCvNjwhMuXTqHLcMvDWz78y4fO00amAZzmM+jYFuLIcPwg7ajwDi
 dOpNenHzjDqZJFKRD7HnpUh+gISKauRJEqLLVAwS4wRjgombi7wjCdgxACojcR32Vn
 RGqSGh5tMfZCA==
Received: from pmta09.mandrill.prod.atl01.rsglab.com (localhost [127.0.0.1])
 by mail132-19.atl131.mandrillapp.com (Mailchimp) with ESMTP id 4fTtF40dYzz1y4
 for <qemu-devel@nongnu.org>; Mon,  9 Mar 2026 10:15:36 +0000 (GMT)
From: "Anthony PERARD" <anthony.perard@vates.tech>
Subject: =?utf-8?Q?[PULL=202/3]=20xen-hvm:=20Handle=20framebuffer=20relocation?=
Received: from [37.26.189.201] by mandrillapp.com id
 a1a9f8af29314422bd95843cc0b24db1; Mon, 09 Mar 2026 10:15:35 +0000
X-Mailer: git-send-email 2.47.3
X-Bm-Disclaimer: Yes
X-Bm-Milter-Handled: 4ffbd6c1-ee69-4e1b-aabd-f977039bd3e2
X-Bm-Transport-Timestamp: 1773051335462
To: qemu-devel@nongnu.org
Cc: "Anthony PERARD" <anthony.perard@vates.tech>
Message-Id: <20260309101529.25695-7-anthony.perard@vates.tech>
In-Reply-To: <20260309101529.25695-5-anthony.perard@vates.tech>
References: <20260309101529.25695-5-anthony.perard@vates.tech>
X-Native-Encoded: 1
X-Report-Abuse: =?UTF-8?Q?Please=20forward=20a=20copy=20of=20this=20message,
 =20including=20all=20headers,
 =20to=20abuse@mandrill.com.=20You=20can=20also=20report=20abuse=20here:=20https://mandrillapp.com/contact/abuse=3Fid=3D30504962.a1a9f8af29314422bd95843cc0b24db1?=
X-Mandrill-User: md_30504962
Feedback-ID: 30504962:30504962.20260309:md
Date: Mon, 09 Mar 2026 10:15:35 +0000
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=198.2.132.19;
 envelope-from=bounce-md_30504962.69ae9dc7.v1-a1a9f8af29314422bd95843cc0b24db1@bounce.vates.tech;
 helo=mail132-19.atl131.mandrillapp.com
X-Spam_score_int: -3
X-Spam_score: -0.4
X-Spam_bar: /
X-Spam_report: (-0.4 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_MED=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_VALIDITY_RPBL_BLOCKED=0.819,
 RCVD_IN_VALIDITY_SAFE_BLOCKED=0.903, SPF_HELO_PASS=-0.001,
 SPF_PASS=-0.001 autolearn=no autolearn_force=no
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
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org

From: Ross Lagerwall <ross.lagerwall@citrix.com>

It is possible for a guest to relocate the linear framebuffer by writing
to the VGA device's BAR. This causes QEMU to report an error and if the
VM is migrated, the destination QEMU hits an assertion.
The problem is that updating the BAR causes the PCI core code to call
the del region callback followed by the add region callback but the
xen-hvm code ignores the del region call and therefore the subsequent
call to xen_relocate_memory() during the add region callback fails
because the source address is not correct.

Fix it by calling in to xen_remove_from_physmap() in response to a
del region callback for the linear framebuffer so that the subsequent
add region callback succeeds.

Signed-off-by: Ross Lagerwall <ross.lagerwall@citrix.com>
Reviewed-by: Anthony PERARD <anthony.perard@vates.tech>
Message-ID: <20260108132514.1862552-1-ross.lagerwall@citrix.com>
Signed-off-by: Anthony PERARD <anthony.perard@vates.tech>
---
 hw/i386/xen/xen-hvm.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/hw/i386/xen/xen-hvm.c b/hw/i386/xen/xen-hvm.c
index a6e1683885..fd7ef56bdb 100644
--- a/hw/i386/xen/xen-hvm.c
+++ b/hw/i386/xen/xen-hvm.c
@@ -720,7 +720,8 @@ void arch_xen_set_memory(XenIOState *state, MemoryRegionSection *section,
         return;
     }
 
-    if (log_dirty != add) {
+    if (log_dirty != add &&
+        !(section->mr == framebuffer && start_addr > 0xbffff)) {
         return;
     }
 


--
Anthony Perard | Vates XCP-ng Developer

XCP-ng & Xen Orchestra - Vates solutions

web: https://vates.tech


