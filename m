Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 21E50CD5BB7
	for <qemu-devel@archiver.kernel.org>; Thu, 21 May 2026 13:21:10 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wQ3I4-0004H2-6Y; Thu, 21 May 2026 09:18:20 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1wQ3Hi-000448-Ma
 for qemu-devel@nongnu.org; Thu, 21 May 2026 09:17:58 -0400
Received: from mail-wm1-x32e.google.com ([2a00:1450:4864:20::32e])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1wQ3He-0008Qv-UB
 for qemu-devel@nongnu.org; Thu, 21 May 2026 09:17:58 -0400
Received: by mail-wm1-x32e.google.com with SMTP id
 5b1f17b1804b1-48d146705b4so67800805e9.3
 for <qemu-devel@nongnu.org>; Thu, 21 May 2026 06:17:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1779369463; x=1779974263; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=hIvv2yywKmXxgoMC/wymZCVbJXllNhQN0iVhJkfnoVw=;
 b=nGf2DvuPx9GzKKl1HCK+nD6R77lqsL/IJGhTuz2wZ4eql6jhfpTTmaIVe7XMe3FBrk
 1U9OzVQNVv2jqihrCgjt/JLORGNvIAzQqICP3v4Hv3rqrFfYxvACvmkQ3kK1+a/Xg6jB
 cCMqGBd5ZnBiWJt6ugZeu30yz5c2Vb/EWZOkIXdDtBx8pR+rTBt6tMVvzSQGps4ejfQU
 WIRAixFfOEMHmY07g9RmyqxeYpDHidO2WIfUYvDcY9yiHgtajw73Bt7t+alO41dOlRA4
 sBdvxg0fhJlWbSEeaKhPxhz8uIrDX4wszPeblj20k6xbMDc8RrMRPrEbPq/0NbQKeQkU
 SLWQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1779369463; x=1779974263;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=hIvv2yywKmXxgoMC/wymZCVbJXllNhQN0iVhJkfnoVw=;
 b=Oh0Ovi55tNbzwgiBWfSjd0iqB5M0kPZxaUAHvK5aaj4p0CaNDsLMFO7ZaB/eBrE311
 ahE0PZdGCME+E0Mhk58q2N3nKHJDuXQ9nvI05spK5ZMPGCCTUt83ylDkPbVLjNc4HPex
 Pq8Ph/CuDCHleTbrgQB0f9PiVoFNYGPcLcQXVgpcqXS6M3VaGurDiNBAYTFiXkde35jv
 IAdIaUEkyv/S6AFQ6ROrZ6ZNm94Lfcu8gwQYGPyW+SKymaOvVIENtRuRnN7JHpasQTgI
 dU3dqHH+t2pyW0ZZG7J1bzOVML3LS5rMe6A7IESMMY2NY1GWRsFioEpqehW9070pKq/m
 d3pA==
X-Gm-Message-State: AOJu0YwVyyjxg3UqbZT1cxCVoG1IV4bGugENq+is2qU7mNJpRNbW1FwH
 +KV1nWQlm+VG5sj4dUCDy8LyUz8RMghXIenGQv0/vbAbOqSS5tqUpk7Q7kSTQWqTYQE=
X-Gm-Gg: Acq92OGscEHSYVB/aBAWw57NmCICP92jMUiZwYOelQa/oRFrLSReVGUHhczNS7l5o6M
 oVZdcvArLilr/8Bfpl8AusCz9MBLh4rKQVVqPTvjkvcjQDO5KG5JaJLlpPlbOv83S2zvYHxSnMN
 TQe29rWVTulOW1Qxs2kNkaTwCcND+JnMlREM6iCZZe2ymlLUvs1wwNFUIENjQ84EcovHl3Jim3E
 F8RKpBfNoW474SZ+U/kJpZeCgNd3ZJCfjDTGnx1rg+trq6SM2PoR3XP5p/I5cWo5J4OUw152RGP
 KL0dd1bAwBuPvdGobaolG97Bh7SuEHmT5DXSXSJXI2xyIP5DFqn8hx0fPIU0tJSmfkz03QgKh0L
 zcJ2qnVu1cOOglSHkUq1EYFUIS5x9rgdzM390VotwciDNgkQ8LTpIk4Dl7S9Ly8pAKGAQsmbA3i
 AJ6dAX0sXWn6UST0GxjGVYgK8=
X-Received: by 2002:a05:600c:46d4:b0:490:3c96:892a with SMTP id
 5b1f17b1804b1-4903c96a2b8mr25019915e9.22.1779369463217; 
 Thu, 21 May 2026 06:17:43 -0700 (PDT)
Received: from draig.lan ([185.124.0.195]) by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-49033cdcc01sm73201565e9.0.2026.05.21.06.17.40
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 21 May 2026 06:17:41 -0700 (PDT)
Received: from draig.lan (localhost [IPv6:::1])
 by draig.lan (Postfix) with ESMTP id 9A57F5FA6F;
 Thu, 21 May 2026 14:17:39 +0100 (BST)
From: =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>
To: qemu-devel@nongnu.org
Cc: Peter Xu <peterx@redhat.com>,
 =?UTF-8?q?Daniel=20P=2E=20Berrang=C3=A9?= <berrange@redhat.com>,
 Thomas Huth <th.huth+qemu@posteo.eu>, Song Gao <gaosong@loongson.cn>,
 John Snow <jsnow@redhat.com>,
 Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Kyle Evans <kevans@freebsd.org>,
 Pierrick Bouvier <pierrick.bouvier@linaro.org>,
 Cleber Rosa <crosa@redhat.com>, Warner Losh <imp@bsdimp.com>,
 Brad Smith <brad@comstyle.com>, Thomas Huth <thuth@redhat.com>,
 Paolo Bonzini <pbonzini@redhat.com>,
 =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>,
 Max Filippov <jcmvbkbc@gmail.com>,
 Brian Cain <brian.cain@oss.qualcomm.com>, Fabiano Rosas <farosas@suse.de>,
 Peter Maydell <peter.maydell@linaro.org>,
 Richard Henderson <richard.henderson@linaro.org>, qemu-arm@nongnu.org
Subject: [PATCH v2 04/16] accel/tcg: move jit thread manipulation into
 do_tb_phys_invalidate
Date: Thu, 21 May 2026 14:17:26 +0100
Message-ID: <20260521131739.540157-5-alex.bennee@linaro.org>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <20260521131739.540157-1-alex.bennee@linaro.org>
References: <20260521131739.540157-1-alex.bennee@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::32e;
 envelope-from=alex.bennee@linaro.org; helo=mail-wm1-x32e.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=unavailable autolearn_force=no
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

To invalidate a TB on MacOS we need to enable write access to the JIT
buffer. We were doing this for tb_phys_invalidate__locked but that is
not the only path into do_tb_phys_invalidate. Move the manipulation
into the shared function that does the work.

As a result we can drop the tb_phys_invalidate__locked function and
update the calls directly.

This enables watchpoints to work in MacOS TCG guests.

Resolves: https://gitlab.com/qemu-project/qemu/-/work_items/3444
Signed-off-by: Alex Bennée <alex.bennee@linaro.org>

---
v2
  - make everyone call do_tb_phys_invalidate
  - tweak the if statement so we don't miss unlocking on an early return
---
 accel/tcg/tb-maint.c | 43 +++++++++++++++++++------------------------
 1 file changed, 19 insertions(+), 24 deletions(-)

diff --git a/accel/tcg/tb-maint.c b/accel/tcg/tb-maint.c
index cd7c32361bb..0c7ac5a72c0 100644
--- a/accel/tcg/tb-maint.c
+++ b/accel/tcg/tb-maint.c
@@ -925,6 +925,7 @@ static void do_tb_phys_invalidate(TranslationBlock *tb, bool rm_from_page_list)
     uint32_t orig_cflags = tb_cflags(tb);
 
     assert_memory_lock();
+    qemu_thread_jit_write();
 
     /* make sure no further incoming jumps will be chained to this TB */
     qemu_spin_lock(&tb->jmp_lock);
@@ -935,33 +936,27 @@ static void do_tb_phys_invalidate(TranslationBlock *tb, bool rm_from_page_list)
     phys_pc = tb_page_addr0(tb);
     h = tb_hash_func(phys_pc, (orig_cflags & CF_PCREL ? 0 : tb->pc),
                      tb->flags, tb->cs_base, orig_cflags);
-    if (!qht_remove(&tb_ctx.htable, tb, h)) {
-        return;
-    }
+    if (qht_remove(&tb_ctx.htable, tb, h)) {
 
-    /* remove the TB from the page list */
-    if (rm_from_page_list) {
-        tb_remove(tb);
-    }
+        /* remove the TB from the page list */
+        if (rm_from_page_list) {
+            tb_remove(tb);
+        }
 
-    /* remove the TB from the hash list */
-    tb_jmp_cache_inval_tb(tb);
+        /* remove the TB from the hash list */
+        tb_jmp_cache_inval_tb(tb);
 
-    /* suppress this TB from the two jump lists */
-    tb_remove_from_jmp_list(tb, 0);
-    tb_remove_from_jmp_list(tb, 1);
+        /* suppress this TB from the two jump lists */
+        tb_remove_from_jmp_list(tb, 0);
+        tb_remove_from_jmp_list(tb, 1);
 
-    /* suppress any remaining jumps to this TB */
-    tb_jmp_unlink(tb);
+        /* suppress any remaining jumps to this TB */
+        tb_jmp_unlink(tb);
 
-    qatomic_set(&tb_ctx.tb_phys_invalidate_count,
-                tb_ctx.tb_phys_invalidate_count + 1);
-}
+        qatomic_set(&tb_ctx.tb_phys_invalidate_count,
+                    tb_ctx.tb_phys_invalidate_count + 1);
+    }
 
-static void tb_phys_invalidate__locked(TranslationBlock *tb)
-{
-    qemu_thread_jit_write();
-    do_tb_phys_invalidate(tb, true);
     qemu_thread_jit_execute();
 }
 
@@ -1030,7 +1025,7 @@ void tb_invalidate_phys_range(CPUState *cpu, tb_page_addr_t start,
     assert_memory_lock();
 
     PAGE_FOR_EACH_TB(start, last, unused, tb, n) {
-        tb_phys_invalidate__locked(tb);
+        do_tb_phys_invalidate(tb, true);
     }
 }
 
@@ -1091,7 +1086,7 @@ bool tb_invalidate_phys_page_unwind(CPUState *cpu, tb_page_addr_t addr,
             current_tb_modified = true;
             cpu_restore_state_from_tb(cpu, current_tb, pc);
         }
-        tb_phys_invalidate__locked(tb);
+        do_tb_phys_invalidate(tb, true);
     }
 
     if (current_tb_modified) {
@@ -1156,7 +1151,7 @@ tb_invalidate_phys_page_range__locked(CPUState *cpu,
                 current_tb_modified = true;
                 cpu_restore_state_from_tb(cpu, current_tb, retaddr);
             }
-            tb_phys_invalidate__locked(tb);
+            do_tb_phys_invalidate(tb, true);
         }
     }
 
-- 
2.47.3


