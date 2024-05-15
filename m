Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1A412C25B78
	for <qemu-devel@archiver.kernel.org>; Wed, 15 May 2024 09:42:56 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1s7B8Q-00074x-Ia; Wed, 15 May 2024 05:41:18 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1s7B8O-0006vz-23
 for qemu-devel@nongnu.org; Wed, 15 May 2024 05:41:16 -0400
Received: from mail-wm1-x330.google.com ([2a00:1450:4864:20::330])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1s7B8L-0001it-B3
 for qemu-devel@nongnu.org; Wed, 15 May 2024 05:41:15 -0400
Received: by mail-wm1-x330.google.com with SMTP id
 5b1f17b1804b1-41ffad2426eso49840455e9.3
 for <qemu-devel@nongnu.org>; Wed, 15 May 2024 02:41:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1715766072; x=1716370872; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=8eoH9KfOs+hCN0P8TyHxNIpq+Yw+C+KsTM42MvAgaJI=;
 b=sy7w0d4el29HGKs63RRAzzvX7YCVekXy6Klz0Fr2BR7f8aFnNb3OA2wRBEpchcpiTG
 emCqhutPCs1paDIXxWoT8i/d+t5WMQAsmAVI2z0kpcSzRQKiyS/9ZVT3Azfe3rBSzYYO
 XoZffeddls59ABfy+njkjEXaiPe+k38ryTKOWIv92Z3ImuEL7j/9Nclj7MRYvvVke9tH
 clkxMs2qlFwL5QIrXi22474NX5aq/F8DCt233id6VCqUpJ/qJSOkwLJReS2gSJC4kyA3
 AOdzzWha9dEqCNpqsXxqqdwZFbJz56MIwuB5e5y/nFapr0DvNDMt5n+WDOypZVJNk4oU
 i1BQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1715766072; x=1716370872;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=8eoH9KfOs+hCN0P8TyHxNIpq+Yw+C+KsTM42MvAgaJI=;
 b=SDTY48IhS0k9rR9MYwTWgQQQZpFb/aTvwVUwHGieCTs82IJ4Z5R1gqym2aJnNr9t32
 Z32Zy6N4SJyxkBRUXUUkQummt1p0j6wYkwf4HulBVrAtk5j5sSJ2uE7O1J8CvIAkc2Ow
 XY+6TtS1U9WBeJ+Wc5yiDRikvDiIKl2LJKDMh8UYjs5sr/u2wyXB+xCwIw8C2zkgvMKk
 eLhCXXI78oUEDYn6J2klvYg1BjqvkYNo8x1j2ShVkjMJ7mXOSQNQZy/reQboZoGjNnqw
 gMm/Aw6WDYUHW5WHMkeVsu4t2CA2Owz2IiHS7/vaKtDZKY9GPlpo6PYxdUL0YfK59YQ0
 HPYg==
X-Gm-Message-State: AOJu0Yz3QyR58LIxppYLYpEYPL8YCkm5F6doTk4NTAP2K2eCVwgZPdh4
 mjvfeU80LZ7Bir1sbkTX3/Rs/MqdSwu6dUXxhkmFlEiEM1jbYogPhlTjWvqSFXV+0Hd5j8a9PPf
 gr5E=
X-Google-Smtp-Source: AGHT+IE+adxq4Vtk4edhMl4inGokot4L54yFTZ0++JAuZlG1VMQsQIUczn2YYXS5PIIrWip+Xm42Kg==
X-Received: by 2002:a05:600c:5116:b0:41b:fa34:9e48 with SMTP id
 5b1f17b1804b1-41feac55e26mr141475575e9.30.1715766071841; 
 Wed, 15 May 2024 02:41:11 -0700 (PDT)
Received: from stoup.. ([149.14.240.163]) by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-3502bbbbefdsm15897058f8f.94.2024.05.15.02.41.11
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 15 May 2024 02:41:11 -0700 (PDT)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Cc: Helge Deller <deller@gmx.de>
Subject: [PULL 38/43] target/hppa: Implement PSW_X
Date: Wed, 15 May 2024 11:40:38 +0200
Message-Id: <20240515094043.82850-39-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240515094043.82850-1-richard.henderson@linaro.org>
References: <20240515094043.82850-1-richard.henderson@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::330;
 envelope-from=richard.henderson@linaro.org; helo=mail-wm1-x330.google.com
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

Use PAGE_WRITE_INV to temporarily enable write permission
on for a given page, driven by PSW_X being set.

Reviewed-by: Helge Deller <deller@gmx.de>
Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
---
 target/hppa/mem_helper.c | 46 +++++++++++++++++++++++-----------------
 1 file changed, 27 insertions(+), 19 deletions(-)

diff --git a/target/hppa/mem_helper.c b/target/hppa/mem_helper.c
index d09877afd7..ca7bbe0a7c 100644
--- a/target/hppa/mem_helper.c
+++ b/target/hppa/mem_helper.c
@@ -296,30 +296,38 @@ int hppa_get_physical_address(CPUHPPAState *env, vaddr addr, int mmu_idx,
         goto egress;
     }
 
-    /* In reverse priority order, check for conditions which raise faults.
-       As we go, remove PROT bits that cover the condition we want to check.
-       In this way, the resulting PROT will force a re-check of the
-       architectural TLB entry for the next access.  */
-    if (unlikely(!ent->d)) {
-        if (type & PAGE_WRITE) {
-            /* The D bit is not set -- TLB Dirty Bit Fault.  */
-            ret = EXCP_TLB_DIRTY;
-        }
-        prot &= PAGE_READ | PAGE_EXEC;
-    }
-    if (unlikely(ent->b)) {
-        if (type & PAGE_WRITE) {
-            /* The B bit is set -- Data Memory Break Fault.  */
-            ret = EXCP_DMB;
-        }
-        prot &= PAGE_READ | PAGE_EXEC;
-    }
+    /*
+     * In priority order, check for conditions which raise faults.
+     * Remove PROT bits that cover the condition we want to check,
+     * so that the resulting PROT will force a re-check of the
+     * architectural TLB entry for the next access.
+     */
     if (unlikely(ent->t)) {
+        prot &= PAGE_EXEC;
         if (!(type & PAGE_EXEC)) {
             /* The T bit is set -- Page Reference Fault.  */
             ret = EXCP_PAGE_REF;
         }
-        prot &= PAGE_EXEC;
+    } else if (!ent->d) {
+        prot &= PAGE_READ | PAGE_EXEC;
+        if (type & PAGE_WRITE) {
+            /* The D bit is not set -- TLB Dirty Bit Fault.  */
+            ret = EXCP_TLB_DIRTY;
+        }
+    } else if (unlikely(ent->b)) {
+        prot &= PAGE_READ | PAGE_EXEC;
+        if (type & PAGE_WRITE) {
+            /*
+             * The B bit is set -- Data Memory Break Fault.
+             * Except when PSW_X is set, allow this single access to succeed.
+             * The write bit will be invalidated for subsequent accesses.
+             */
+            if (env->psw_xb & PSW_X) {
+                prot |= PAGE_WRITE_INV;
+            } else {
+                ret = EXCP_DMB;
+            }
+        }
     }
 
  egress:
-- 
2.34.1


