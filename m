Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A7880C27C65
	for <qemu-devel@archiver.kernel.org>; Tue, 11 Jun 2024 21:57:34 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sH9U3-00014H-C4; Tue, 11 Jun 2024 17:56:51 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <anjo@rev.ng>) id 1sH9U1-00013q-FJ
 for qemu-devel@nongnu.org; Tue, 11 Jun 2024 17:56:49 -0400
Received: from rev.ng ([5.9.113.41])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <anjo@rev.ng>) id 1sH9Ty-00018g-1N
 for qemu-devel@nongnu.org; Tue, 11 Jun 2024 17:56:47 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=rev.ng;
 s=dkim; h=Content-Transfer-Encoding:MIME-Version:Message-ID:Date:Subject:Cc:
 To:From:Sender:Reply-To:Content-Type:Content-ID:Content-Description:
 Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
 In-Reply-To:References:List-Id:List-Help:List-Unsubscribe:List-Subscribe:
 List-Post:List-Owner:List-Archive:List-Unsubscribe:List-Unsubscribe-Post:
 List-Help; bh=oKDTPBET8p0wOImu4AZfN2i8Wdw/jJf6Q2xtseUs4Lw=; b=ob7WdofJs5c7aFf
 FBil9eo6/gIf8ky6LVh/IvxhU/R7ySBVFopswZgouBMarLVDn9qIB6HDhRZNT6gpDs7F47vSKfvW1
 qqG2rRtRlCgY4wTdrCchQ2IwI/4DI5aa5ypT0Vwh69lYyRP42FCL8jnaFy7uKZuSF/DRCENpxaU/3
 6c=;
To: qemu-devel@nongnu.org
Cc: richard.henderson@linaro.org
Subject: [PATCH] accel/tcg: Fix typo causing tb->page_addr[1] to not be
 recorded
Date: Tue, 11 Jun 2024 23:58:14 +0200
Message-ID: <20240611215814.32752-1-anjo@rev.ng>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=5.9.113.41; envelope-from=anjo@rev.ng; helo=rev.ng
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, SPF_HELO_PASS=-0.001,
 SPF_PASS=-0.001, T_SCC_BODY_TEXT_LINE=-0.01 autolearn=ham autolearn_force=no
X-Spam_action: no action
X-BeenThere: qemu-devel@nongnu.org
X-Mailman-Version: 2.1.29
Precedence: list
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <https://lists.nongnu.org/archive/html/qemu-devel>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=subscribe>
Reply-to:  Anton Johansson <anjo@rev.ng>
From:  Anton Johansson via <qemu-devel@nongnu.org>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org

For TBs crossing page boundaries, the 2nd page will never be
recorded/removed, as the index of the 2nd page is computed from the
address of the 1st page. This is due to a typo, fix it.

Signed-off-by: Anton Johansson <anjo@rev.ng>
---
 accel/tcg/tb-maint.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/accel/tcg/tb-maint.c b/accel/tcg/tb-maint.c
index 19ae6793f3..cc0f5afd47 100644
--- a/accel/tcg/tb-maint.c
+++ b/accel/tcg/tb-maint.c
@@ -713,7 +713,7 @@ static void tb_record(TranslationBlock *tb)
     tb_page_addr_t paddr0 = tb_page_addr0(tb);
     tb_page_addr_t paddr1 = tb_page_addr1(tb);
     tb_page_addr_t pindex0 = paddr0 >> TARGET_PAGE_BITS;
-    tb_page_addr_t pindex1 = paddr0 >> TARGET_PAGE_BITS;
+    tb_page_addr_t pindex1 = paddr1 >> TARGET_PAGE_BITS;
 
     assert(paddr0 != -1);
     if (unlikely(paddr1 != -1) && pindex0 != pindex1) {
@@ -745,7 +745,7 @@ static void tb_remove(TranslationBlock *tb)
     tb_page_addr_t paddr0 = tb_page_addr0(tb);
     tb_page_addr_t paddr1 = tb_page_addr1(tb);
     tb_page_addr_t pindex0 = paddr0 >> TARGET_PAGE_BITS;
-    tb_page_addr_t pindex1 = paddr0 >> TARGET_PAGE_BITS;
+    tb_page_addr_t pindex1 = paddr1 >> TARGET_PAGE_BITS;
 
     assert(paddr0 != -1);
     if (unlikely(paddr1 != -1) && pindex0 != pindex1) {
-- 
2.45.0


