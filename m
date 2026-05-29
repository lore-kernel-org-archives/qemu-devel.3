Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 98F7ECD5BD2
	for <qemu-devel@archiver.kernel.org>; Fri, 29 May 2026 05:41:49 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wSpx7-00022D-3U; Fri, 29 May 2026 01:40:13 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1wSpwc-0001qg-6U
 for qemu-devel@nongnu.org; Fri, 29 May 2026 01:39:46 -0400
Received: from mail-wm1-x32d.google.com ([2a00:1450:4864:20::32d])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1wSpwa-000256-BJ
 for qemu-devel@nongnu.org; Fri, 29 May 2026 01:39:41 -0400
Received: by mail-wm1-x32d.google.com with SMTP id
 5b1f17b1804b1-4893940bb5eso72726655e9.3
 for <qemu-devel@nongnu.org>; Thu, 28 May 2026 22:39:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1780033179; x=1780637979; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=79P13JhrVnu+uI6HWVYMbcoYr8sDIQXmGwPixsdUhYs=;
 b=AuAXggYJTNFnoeQbUWMGz+L+YDG9kaI/ujyotUUM9wztUQt/sdRLEKMcSqQYqYrSW9
 o5wXJvC2TSZFF4QeTXXom2EwgTDjuIHLsPfU9Eflsmm6CE6GpBcH6MYw/6LeDR73HyfP
 /jnTCbMqHcVRuatjHpcc7d715ppjD77G/+fJouYEqU0wHssu6hNmgQm3uhHfdta/QRn9
 W/LiGYLDAlz5MxaOmFbgoLCLD0Jl/ijrmxbg/Qu72J0QtFeKbtp0xwr05NZEAQZv/wZ5
 hP8fKZY0bu9Nc8K5foKsacTTJmn79KwsmtRwPCeWnvVp9wrdNIB2H0QEzKioDpGlrpfj
 8/WA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1780033179; x=1780637979;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=79P13JhrVnu+uI6HWVYMbcoYr8sDIQXmGwPixsdUhYs=;
 b=QnivHNoYzNLWo988rzAwCYb98alyDUO03xU3yOrVyChAleQfWZWUjeiOExaUtqLulv
 Zd17mh+WsobKPvUnROK0v/qQTtf+sSNU+2C1TeFZlw47D0AQJdZNbtBK/cio7o+M1ydO
 Z6UEqqRawYFlJd6cDqh/rWISEhary4fAdfXB4fBGyC1uN8/bu55gtT4a/byFjMS/loyl
 T7h/UTdhBcxB30klafxMha3IXHrroSGaFwfLYrnDDmak7JRI+BU+sGPEVxbWb1uBFD08
 de1ONOvQT1EI3/IebSCq1Lh/mQpWkGTdKQs8bNqOND7WATreNFZBj2dln2e0XILPuNbC
 qShg==
X-Gm-Message-State: AOJu0YztI/fvB7fGr6aLJAoQ0I4p4Lz+I5eIozMEACXjtwr0R+hDjkxl
 FGawOymx/QoIcQxYtJ8po48eugTnQ8aajmFUbJvH7AjV6raIUj8j9soc+uExZMwJNMQ=
X-Gm-Gg: Acq92OFzz7IEpSnyoEkiWNuuRpAQ7lnvTFgfvTtIqtw1apAsm+tr6sTZ+LaXKbrS4ck
 6kLHvp7dkgIT6C1hVCKZyLLEtdfG3BuooJLL0ialXF0eWEFryiVkjw953gDZOLhALNaqnTO5qas
 hEk4EdJQexkvIHaglBsLrn/V1x7C3zlPfQezV3egvFSYXopGAI+1UeRB9WIIRvG050QNw5HAcsF
 w6PHrSVL7qW+LxZzVQk/vLxbQA1mq/uqTQvjtNYg02Cn/8DJ4H+2YBzN78S0/rtkEIqBlWLY0zm
 fged40CFHkoMxQi3ODfDxuB3iGTrcUHOQWhVxY8uqNcnmg3tIdK4S7hqKJEo3bt/RNNqawI2cGm
 4lwrsp04ekH24GYlWjJyws7bSm1SkHUQukObW6bPqVpSrJX7QJQiZr1BihuDeYGNLGayAwJ9Qqv
 JBBY/RI5fJOYXBCyKBjKJ6EHYYrSauim5Qgg==
X-Received: by 2002:a05:600c:643:b0:490:53d3:4767 with SMTP id
 5b1f17b1804b1-4909c0787b1mr14472665e9.7.1780033178850; 
 Thu, 28 May 2026 22:39:38 -0700 (PDT)
Received: from draig.lan ([185.124.0.195]) by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-4909ca65f54sm20695955e9.5.2026.05.28.22.39.32
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 28 May 2026 22:39:34 -0700 (PDT)
Received: from draig.lan (localhost [IPv6:::1])
 by draig.lan (Postfix) with ESMTP id 493FD602E1;
 Fri, 29 May 2026 06:39:32 +0100 (BST)
From: =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>
To: qemu-devel@nongnu.org
Cc: =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>,
 Richard Henderson <richard.henderson@linaro.org>,
 Paolo Bonzini <pbonzini@redhat.com>
Subject: [PULL 04/13] accel/tcg: move jit thread manipulation into
 do_tb_phys_invalidate
Date: Fri, 29 May 2026 06:39:22 +0100
Message-ID: <20260529053931.283970-5-alex.bennee@linaro.org>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <20260529053931.283970-1-alex.bennee@linaro.org>
References: <20260529053931.283970-1-alex.bennee@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::32d;
 envelope-from=alex.bennee@linaro.org; helo=mail-wm1-x32d.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
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

To invalidate a TB on MacOS we need to enable write access to the JIT
buffer. We were doing this for tb_phys_invalidate__locked but that is
not the only path into do_tb_phys_invalidate. Move the manipulation
into the shared function that does the work.

As a result we can drop the tb_phys_invalidate__locked function and
update the calls directly.

This enables watchpoints to work in MacOS TCG guests.

Resolves: https://gitlab.com/qemu-project/qemu/-/work_items/3444
Reviewed-by: Richard Henderson <richard.henderson@linaro.org>
Message-ID: <20260526110243.470002-5-alex.bennee@linaro.org>
Signed-off-by: Alex Bennée <alex.bennee@linaro.org>

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


