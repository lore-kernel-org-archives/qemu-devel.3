Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9290CCD5BB1
	for <qemu-devel@archiver.kernel.org>; Tue, 26 May 2026 11:04:49 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wRpZ6-0002hY-A5; Tue, 26 May 2026 07:03:16 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1wRpYp-0002b9-Jh
 for qemu-devel@nongnu.org; Tue, 26 May 2026 07:03:00 -0400
Received: from mail-wm1-x32a.google.com ([2a00:1450:4864:20::32a])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1wRpYj-0005ya-72
 for qemu-devel@nongnu.org; Tue, 26 May 2026 07:02:58 -0400
Received: by mail-wm1-x32a.google.com with SMTP id
 5b1f17b1804b1-48984d29fe3so109814825e9.0
 for <qemu-devel@nongnu.org>; Tue, 26 May 2026 04:02:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1779793367; x=1780398167; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=hIvv2yywKmXxgoMC/wymZCVbJXllNhQN0iVhJkfnoVw=;
 b=Bz17q9zR1LmEncxaGFAebpSrS62GktDFaPx07fLkxya5/IpxNKHh2nGVAT2eGx6wRd
 lPMr+4KDWKgBCxMpNQLBpksT6P7Y7tnEuKQ+Whc1BvwGGKi8STGYxlMtWbmrKPRGiJnZ
 yOJiq/x78BMXXmMXd3wLXok+g1FZ6IKkl1eZi3C5gfPP0niunvVstsJB+IUeB8dL2D9P
 Iz+FgFLm03FAFEDTUdZupOt4MuNFkpOWDTWwEXebDtrV//nQ0CpGhYznV16TY4tmgTPC
 sLY7tYo6Y8H01AlF9sLirgHjJyw0xYp17Ylh1xNe3b5BWshhWfJTLZayZEIPSz9cpS/Z
 aEbA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1779793367; x=1780398167;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=hIvv2yywKmXxgoMC/wymZCVbJXllNhQN0iVhJkfnoVw=;
 b=sL2BCQzFoOxCAzV5KK7Az4CBN5YTyC6np1mCUZ9UYNkOdVJOuHnyU3N7i0WlENBTfS
 ukoE95PvR10FBRxxellOuZa7Nix9Ev2wOrX6Lt2BaMBcn2mcHNH1/TLShcCVoJ6bQ/bu
 0cvSQHfnaca/xbaamCyAE5Qq8+sKQzhS+smSJpAy0pnXPmdIq0z8zLMXFkZ88jLDYuX7
 J50y0qCMSv1Xecmr1mJ4rHH5ER7ag+dah7gDkQ6PnarUEBO1ZPsuBnuwV1My3bLz2H5R
 8Jln1YQONdocWBeAoDklrEaSANZ3i4FT8eg8iLYrAXSpsTyhbbgVS9opibgX36wdOuBF
 wWYg==
X-Gm-Message-State: AOJu0YyONWuSkWJVy00g2fYlxiqEfWEbBFmkscMZNHrVsrrs1yuPVaWa
 qEN6diDiVXoCNj1jb+jojo/zSf5dXYNHIE4dKT107LUYCvnLh5FIZknimOOWQazRNZg=
X-Gm-Gg: Acq92OHmuhuDOiYPnSXiKvXZEGbMalWuWe5Dx2b6kg56MZR+8xMvWIsZ5cNi/H/JWM8
 qdbBZO+2WvAn0pWXrgYDacakpdWeg7mFQVqBd7V2c1w9zu4bxoquD4wY5dDAD6H4ESWpOECgAJh
 grWYU0VQwPBrVQ+S3u5ys5slchUSOahSD4WBKuidxE4yGXNXXGPNsd6D4NKR9SOSRv6JKqYibRw
 euN44gUmpD72JYPaTnsnj8BVyjpJpWXyrgHaTNnkZpoxXZxmwCEwInQdckO0ceHayBoxxPlK8hS
 tP0UJ9VtX5iQ0Gtb0tyiUdQXyavKMImMrS3tZ92u86Qd2tFoxqYnmXOk7BV7BKbEx0UjF3rGaCw
 oLu9KG2fMwHWi+HGjcNYVFYF/GnZRYXcRC3p4mkC3drW+5kNyvlRVTb3Qas7nLpvgiqDYXr/3sq
 UasmEWOjzp1JM0+fWIND/SshU=
X-Received: by 2002:a05:600c:a49:b0:490:6889:202 with SMTP id
 5b1f17b1804b1-4906889026emr116669285e9.29.1779793366875; 
 Tue, 26 May 2026 04:02:46 -0700 (PDT)
Received: from draig.lan ([185.124.0.195]) by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-490424aa561sm150585235e9.5.2026.05.26.04.02.44
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 26 May 2026 04:02:44 -0700 (PDT)
Received: from draig.lan (localhost [IPv6:::1])
 by draig.lan (Postfix) with ESMTP id E046D5F8CC;
 Tue, 26 May 2026 12:02:43 +0100 (BST)
From: =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>
To: qemu-devel@nongnu.org
Cc: Brad Smith <brad@comstyle.com>, Thomas Huth <thuth@redhat.com>,
 Cleber Rosa <crosa@redhat.com>,
 Pierrick Bouvier <pierrick.bouvier@linaro.org>,
 Fabiano Rosas <farosas@suse.de>, Kyle Evans <kevans@freebsd.org>,
 Thomas Huth <th.huth+qemu@posteo.eu>,
 =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>,
 John Snow <jsnow@redhat.com>,
 =?UTF-8?q?Daniel=20P=2E=20Berrang=C3=A9?= <berrange@redhat.com>,
 Max Filippov <jcmvbkbc@gmail.com>, Peter Xu <peterx@redhat.com>,
 Paolo Bonzini <pbonzini@redhat.com>,
 Brian Cain <brian.cain@oss.qualcomm.com>, Song Gao <gaosong@loongson.cn>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Peter Maydell <peter.maydell@linaro.org>,
 Richard Henderson <richard.henderson@linaro.org>,
 Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>, qemu-arm@nongnu.org,
 Warner Losh <imp@bsdimp.com>
Subject: [PATCH v3 04/14] accel/tcg: move jit thread manipulation into
 do_tb_phys_invalidate
Date: Tue, 26 May 2026 12:02:32 +0100
Message-ID: <20260526110243.470002-5-alex.bennee@linaro.org>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <20260526110243.470002-1-alex.bennee@linaro.org>
References: <20260526110243.470002-1-alex.bennee@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::32a;
 envelope-from=alex.bennee@linaro.org; helo=mail-wm1-x32a.google.com
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


