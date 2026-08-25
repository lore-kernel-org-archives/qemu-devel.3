Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A91B4C61DBE
	for <qemu-devel@archiver.kernel.org>; Tue, 25 Aug 2026 11:14:58 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wyp70-00018z-7c; Tue, 25 Aug 2026 07:14:38 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mjt@tls.msk.ru>)
 id 1wyp6z-00012l-3J; Tue, 25 Aug 2026 07:14:37 -0400
Received: from isrv.corpit.ru ([212.248.84.144])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mjt@tls.msk.ru>)
 id 1wyp6x-0008PG-FB; Tue, 25 Aug 2026 07:14:36 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=tls.msk.ru; s=202602;
 t=1787656396; bh=13ApjLDwn3OH2B5fPK5kGELiktq655jOi/qpx+/Xk9o=;
 h=From:To:Cc:Subject:Date:In-Reply-To:References;
 b=egNWdkJWmAAPGad+nTzjt7nQa2hQcB4jdsJ9kkNp3KsEbugM96vk++cOEVkJ94Wp6
 mFnda7SDfew6LxS4DpLrnCLgwnJjWTYxwf4PgtV9CXjhX4ljrGbe/Fbu0DCNv/+GT/
 P3JuySrpzPKg/9/c4DacS7pBt2Mwfvln+fPLDKuId5n+magd6TRlp+8LgBUd9h+Qnj
 /bQPXa6g7j9eCVTXvo3WVc6Q+JWSfuOox6EtmvIro+2WTb3cZiuPLFz8mVSJQMVl1m
 z2UXWRfe5YgITDs02IKmp3k839iyC5rIown3+QFHt4duhII1kc8M1YWV7xtHVFGc+9
 xDSVJ2z39odPg==
Received: from tsrv.corpit.ru (tsrv.tls.msk.ru [192.168.177.2])
 by isrv.corpit.ru (Postfix) with ESMTP id 3AB441CE4AF;
 Tue, 25 Aug 2026 14:13:16 +0300 (MSK)
Received: from gandalf.tls.msk.ru (mjt.wg.tls.msk.ru [192.168.177.130])
 by tsrv.corpit.ru (Postfix) with ESMTP id 535DA41627B;
 Tue, 25 Aug 2026 14:13:53 +0300 (MSK)
Received: by gandalf.tls.msk.ru (Postfix, from userid 1000)
 id 85655325A1; Tue, 25 Aug 2026 14:13:15 +0300 (MSK)
From: Michael Tokarev <mjt@tls.msk.ru>
To: qemu-devel@nongnu.org
Cc: qemu-stable@nongnu.org, Richard Henderson <richard.henderson@linaro.org>,
 Yogesh Vyas <yvyas1991@gmail.com>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@oss.qualcomm.com>,
 Michael Tokarev <mjt@tls.msk.ru>
Subject: [Stable-10.0.13 v3 147/166] tcg: Return success from tcg_region_alloc
Date: Tue, 25 Aug 2026 14:11:43 +0300
Message-ID: <20260825111206.482723-13-mjt@tls.msk.ru>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <qemu-stable-10.0.13-20260825141147@cover.tls.msk.ru>
References: <qemu-stable-10.0.13-20260825141147@cover.tls.msk.ru>
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
(cherry picked from commit fcdbc78ad4dea4b6baac581be5f7350ce47dc218)
Signed-off-by: Michael Tokarev <mjt@tls.msk.ru>

diff --git a/tcg/region.c b/tcg/region.c
index 3721a7a7e16..087e47f40d2 100644
--- a/tcg/region.c
+++ b/tcg/region.c
@@ -369,7 +369,7 @@ static bool tcg_region_alloc__locked(TCGContext *s)
 
 /*
  * Request a new region once the one in use has filled up.
- * Returns true on error.
+ * Returns true on success.
  */
 bool tcg_region_alloc(TCGContext *s)
 {
@@ -383,7 +383,7 @@ bool tcg_region_alloc(TCGContext *s)
         region.agg_size_full += size_full - TCG_HIGHWATER;
     }
     qemu_mutex_unlock(&region.lock);
-    return !ok;
+    return ok;
 }
 
 /*
diff --git a/tcg/tcg.c b/tcg/tcg.c
index b1a7465df28..d2e5cfd9077 100644
--- a/tcg/tcg.c
+++ b/tcg/tcg.c
@@ -1575,7 +1575,7 @@ TranslationBlock *tcg_tb_alloc(TCGContext *s)
     next = (void *)ROUND_UP((uintptr_t)(tb + 1), align);
 
     if (unlikely(next > s->code_gen_highwater)) {
-        if (tcg_region_alloc(s)) {
+        if (!tcg_region_alloc(s)) {
             return NULL;
         }
         goto retry;
-- 
2.47.3


