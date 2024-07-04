Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 083DAC3271F
	for <qemu-devel@archiver.kernel.org>; Thu,  4 Jul 2024 21:03:55 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sPTZs-0006rY-T2; Thu, 04 Jul 2024 17:01:17 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mjt@tls.msk.ru>)
 id 1sPTZr-0006qC-7y; Thu, 04 Jul 2024 17:01:15 -0400
Received: from isrv.corpit.ru ([86.62.121.231])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mjt@tls.msk.ru>)
 id 1sPTZp-0004L3-MF; Thu, 04 Jul 2024 17:01:14 -0400
Received: from tsrv.corpit.ru (tsrv.tls.msk.ru [192.168.177.2])
 by isrv.corpit.ru (Postfix) with ESMTP id C142577564;
 Fri,  5 Jul 2024 00:00:50 +0300 (MSK)
Received: from tls.msk.ru (mjt.wg.tls.msk.ru [192.168.177.130])
 by tsrv.corpit.ru (Postfix) with SMTP id D4147FEC9E;
 Fri,  5 Jul 2024 00:00:55 +0300 (MSK)
Received: (nullmailer pid 1507733 invoked by uid 1000);
 Thu, 04 Jul 2024 21:00:55 -0000
From: Michael Tokarev <mjt@tls.msk.ru>
To: qemu-devel@nongnu.org
Cc: qemu-stable@nongnu.org, Anton Johansson <anjo@rev.ng>,
 Manos Pitsidianakis <manos.pitsidianakis@linaro.org>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>,
 Richard Henderson <richard.henderson@linaro.org>,
 Michael Tokarev <mjt@tls.msk.ru>
Subject: [Stable-9.0.2 07/22] accel/tcg: Fix typo causing tb->page_addr[1] to
 not be recorded
Date: Fri,  5 Jul 2024 00:00:37 +0300
Message-Id: <20240704210055.1507652-7-mjt@tls.msk.ru>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <qemu-stable-9.0.2-20240704162154@cover.tls.msk.ru>
References: <qemu-stable-9.0.2-20240704162154@cover.tls.msk.ru>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=86.62.121.231; envelope-from=mjt@tls.msk.ru;
 helo=isrv.corpit.ru
X-Spam_score_int: -68
X-Spam_score: -6.9
X-Spam_bar: ------
X-Spam_report: (-6.9 / 5.0 requ) BAYES_00=-1.9, RCVD_IN_DNSWL_HI=-5,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org

From: Anton Johansson <anjo@rev.ng>

For TBs crossing page boundaries, the 2nd page will never be
recorded/removed, as the index of the 2nd page is computed from the
address of the 1st page. This is due to a typo, fix it.

Cc: qemu-stable@nongnu.org
Fixes: deba78709a ("accel/tcg: Always lock pages before translation")
Signed-off-by: Anton Johansson <anjo@rev.ng>
Reviewed-by: Manos Pitsidianakis <manos.pitsidianakis@linaro.org>
Reviewed-by: Philippe Mathieu-Daudé <philmd@linaro.org>
Reviewed-by: Alex Bennée <alex.bennee@linaro.org>
Message-Id: <20240612133031.15298-1-anjo@rev.ng>
Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
(cherry picked from commit 3b279f73fa37bec8d3ba04a15f5153d6491cffaf)
Signed-off-by: Michael Tokarev <mjt@tls.msk.ru>

diff --git a/accel/tcg/tb-maint.c b/accel/tcg/tb-maint.c
index da39a43bd8..653397eca3 100644
--- a/accel/tcg/tb-maint.c
+++ b/accel/tcg/tb-maint.c
@@ -712,7 +712,7 @@ static void tb_record(TranslationBlock *tb)
     tb_page_addr_t paddr0 = tb_page_addr0(tb);
     tb_page_addr_t paddr1 = tb_page_addr1(tb);
     tb_page_addr_t pindex0 = paddr0 >> TARGET_PAGE_BITS;
-    tb_page_addr_t pindex1 = paddr0 >> TARGET_PAGE_BITS;
+    tb_page_addr_t pindex1 = paddr1 >> TARGET_PAGE_BITS;
 
     assert(paddr0 != -1);
     if (unlikely(paddr1 != -1) && pindex0 != pindex1) {
@@ -744,7 +744,7 @@ static void tb_remove(TranslationBlock *tb)
     tb_page_addr_t paddr0 = tb_page_addr0(tb);
     tb_page_addr_t paddr1 = tb_page_addr1(tb);
     tb_page_addr_t pindex0 = paddr0 >> TARGET_PAGE_BITS;
-    tb_page_addr_t pindex1 = paddr0 >> TARGET_PAGE_BITS;
+    tb_page_addr_t pindex1 = paddr1 >> TARGET_PAGE_BITS;
 
     assert(paddr0 != -1);
     if (unlikely(paddr1 != -1) && pindex0 != pindex1) {
-- 
2.39.2


