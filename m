Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 71C85C61DBC
	for <qemu-devel@archiver.kernel.org>; Tue, 25 Aug 2026 07:08:16 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wylGP-0007nd-Kf; Tue, 25 Aug 2026 03:08:05 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mjt@tls.msk.ru>)
 id 1wylGG-0007hl-5a; Tue, 25 Aug 2026 03:07:57 -0400
Received: from isrv.corpit.ru ([212.248.84.144])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mjt@tls.msk.ru>)
 id 1wylGC-00060L-U2; Tue, 25 Aug 2026 03:07:54 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=tls.msk.ru; s=202602;
 t=1787641596; bh=oAdFlTdHGmfLnIpJ/Q3sjwmZB5CCL70Rv0f6oSGohxk=;
 h=From:To:Cc:Subject:Date:In-Reply-To:References;
 b=m+fulfzmfpK1D7uE5oZBW/WLv9/9KeLXP9E2THG5shAmCwWL/h7O1FmwiTHjb3MTv
 fSse+2EzaNS+THlLbtuuY61eGzPkHN4wMAmjl61KW9+n5CPOWSKTQ+Oi1GQyAoBrbq
 7QOsh5ULWwwBLCyC7OZd9vk/aE4aXE9UKlPniLY39xfdY8Y5LvDBWCzN0XwftP4r1t
 xF6eaGNO2jQN5rJJHNQ+1YV1z3E2Hv0U0gxu7p5LyPF4+tldPhcyRhfjYzlaEbLLdQ
 yFA9ysNQReI0t+BdTY/SEvEf8ekMtj8m6TcQZz+Ds1E6NZaML1wFMm+n9sN7TEoxIv
 pHuwi2AI7ihKQ==
Received: from tsrv.corpit.ru (tsrv.tls.msk.ru [192.168.177.2])
 by isrv.corpit.ru (Postfix) with ESMTP id 1F7971CE21B;
 Tue, 25 Aug 2026 10:06:36 +0300 (MSK)
Received: from gandalf.tls.msk.ru (mjt.wg.tls.msk.ru [192.168.177.130])
 by tsrv.corpit.ru (Postfix) with ESMTP id D7F87415F96;
 Tue, 25 Aug 2026 10:07:12 +0300 (MSK)
Received: by gandalf.tls.msk.ru (Postfix, from userid 1000)
 id 84EBA32416; Tue, 25 Aug 2026 10:06:35 +0300 (MSK)
From: Michael Tokarev <mjt@tls.msk.ru>
To: qemu-devel@nongnu.org
Cc: qemu-stable@nongnu.org, Richard Henderson <richard.henderson@linaro.org>,
 Yogesh Vyas <yvyas1991@gmail.com>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@oss.qualcomm.com>,
 Michael Tokarev <mjt@tls.msk.ru>
Subject: [Stable-11.1.1 v2 54/91] tcg: Return success from
 tcg_region_alloc__locked
Date: Tue, 25 Aug 2026 10:05:26 +0300
Message-ID: <20260825070619.174584-12-mjt@tls.msk.ru>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <qemu-stable-11.1.1-20260825100540@cover.tls.msk.ru>
References: <qemu-stable-11.1.1-20260825100540@cover.tls.msk.ru>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=212.248.84.144; envelope-from=mjt@tls.msk.ru;
 helo=isrv.corpit.ru
X-Spam_score_int: -19
X-Spam_score: -2.0
X-Spam_bar: --
X-Spam_report: (-2.0 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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

From: Richard Henderson <richard.henderson@linaro.org>

Invert the sense of the boolean result from 'error' to 'success'.

Tested-by: Yogesh Vyas <yvyas1991@gmail.com>
Reviewed-by: Yogesh Vyas <yvyas1991@gmail.com>
Reviewed-by: Philippe Mathieu-Daudé <philmd@oss.qualcomm.com>
Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
(cherry picked from commit e131c28b6eb24c0b7f7f21591b2b2c7568267337)
Signed-off-by: Michael Tokarev <mjt@tls.msk.ru>

diff --git a/tcg/region.c b/tcg/region.c
index 5d4be1453b0..2161d961d98 100644
--- a/tcg/region.c
+++ b/tcg/region.c
@@ -360,11 +360,11 @@ static void tcg_region_assign(TCGContext *s, size_t curr_region)
 static bool tcg_region_alloc__locked(TCGContext *s)
 {
     if (region.current == region.n) {
-        return true;
+        return false;
     }
     tcg_region_assign(s, region.current);
     region.current++;
-    return false;
+    return true;
 }
 
 /*
@@ -373,17 +373,17 @@ static bool tcg_region_alloc__locked(TCGContext *s)
  */
 bool tcg_region_alloc(TCGContext *s)
 {
-    bool err;
+    bool ok;
     /* read the region size now; alloc__locked will overwrite it on success */
     size_t size_full = s->code_gen_buffer_size;
 
     qemu_mutex_lock(&region.lock);
-    err = tcg_region_alloc__locked(s);
-    if (!err) {
+    ok = tcg_region_alloc__locked(s);
+    if (ok) {
         region.agg_size_full += size_full - TCG_HIGHWATER;
     }
     qemu_mutex_unlock(&region.lock);
-    return err;
+    return !ok;
 }
 
 /*
@@ -392,8 +392,8 @@ bool tcg_region_alloc(TCGContext *s)
  */
 static void tcg_region_initial_alloc__locked(TCGContext *s)
 {
-    bool err = tcg_region_alloc__locked(s);
-    g_assert(!err);
+    bool ok = tcg_region_alloc__locked(s);
+    g_assert(ok);
 }
 
 void tcg_region_initial_alloc(TCGContext *s)
-- 
2.47.3


