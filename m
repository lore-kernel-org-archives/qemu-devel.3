Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7A8F0C19F4E
	for <qemu-devel@archiver.kernel.org>; Thu, 25 Apr 2024 00:08:48 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rzmYK-0008RZ-Aw; Wed, 24 Apr 2024 20:01:28 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1rzmXz-0008Jm-Gy
 for qemu-devel@nongnu.org; Wed, 24 Apr 2024 20:01:07 -0400
Received: from mail-pl1-x62e.google.com ([2607:f8b0:4864:20::62e])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1rzmXx-0006Jw-LE
 for qemu-devel@nongnu.org; Wed, 24 Apr 2024 20:01:07 -0400
Received: by mail-pl1-x62e.google.com with SMTP id
 d9443c01a7336-1e36b7e7dd2so3451775ad.1
 for <qemu-devel@nongnu.org>; Wed, 24 Apr 2024 17:01:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1714003262; x=1714608062; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
 :reply-to; bh=03YkZQCWlVOksTPNxrPCbb3bwvJD4b/91KoJpuBrF7U=;
 b=qY7HYRJ3FEPxKKt5807lXFWOWnyqU66BlZRTCTIp65DO6SVsSUfhQsvkWO/N/q11AK
 3AUmjPrnGHEQIXgZg1hlJubbLnkZEM9P4+vw60J6lTC/DoidMdzbGBWh+0fOx+E0X+YP
 sM0fmlLcsxamh7vBwBjG7ZTmr/7AaxJYyEe1Fa3Pnz6kLPl8n7ebnancEko9asCO56V0
 BM29mlrQWGcrZyBHPFqJgCmoSJPAC+kbhpfUHsfMwIXifuwRSlMiuVbkcqWboilp1SsU
 Vr6lYHOsyYAh/Nlo2v1y3tBsco4VtJIczSbCfH07ZQUERZRlKF8XVOb3FCwRm8YnFz2G
 GOdg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1714003262; x=1714608062;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=03YkZQCWlVOksTPNxrPCbb3bwvJD4b/91KoJpuBrF7U=;
 b=QNnF8NsPignzci5biTNkl7hmOwXfxkjucEsx5ppukY7ev9pt3pmAwZhNbZ5SI/Osec
 ayRrLLHKWMN5wdCcyuhudtKjiM8eY8nkZ42qR85xiAyfvjBHiMUT2dFohE2278hoGYT9
 rz6Qaz9JJKfMpKhCxz7wmdD2+lGM0du05JZAw/QRg4pQLEia2ZFfP8H3/iOQGSe4moHK
 tSUKCYvL9X3CgDHgp+KuqFlAOpPIw1QKnWSUZVo2/JuERlR0rO09M2ttpu4uGN2ZOkRb
 rJ6sZ6zxfIEEzLWKmdBr7n6mWfCJHZ+/3x9i35rLpLgsll6EthEHJk2N6GullItSVAvo
 WQmw==
X-Gm-Message-State: AOJu0YzB3hjstwko/XIoZjym6jKx+JnpxbIQUrEhKRzLB48PhRSJkfv6
 HHPJlyS3+wKYHuZHPei4aVCXJZCtEGwRe5ZnG2y2ffnENnnEt2Ue7N/Rn2w/Re6Cz9iDX93fiIR
 z
X-Google-Smtp-Source: AGHT+IECc+zEBpRl+ibKSwuBiW8GM7VWyacwp1mGysRZXFTy30mlBFiuxFKRrgFKtUMVkEw4Sn6rbw==
X-Received: by 2002:a17:902:e54d:b0:1e2:6165:8086 with SMTP id
 n13-20020a170902e54d00b001e261658086mr5257851plf.61.1714003261779; 
 Wed, 24 Apr 2024 17:01:01 -0700 (PDT)
Received: from stoup.. ([156.19.246.23]) by smtp.gmail.com with ESMTPSA id
 t6-20020a170902e84600b001e604438791sm12465715plg.156.2024.04.24.17.01.01
 for <qemu-devel@nongnu.org>
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 24 Apr 2024 17:01:01 -0700 (PDT)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Subject: [PATCH 38/45] target/hppa: Implement PSW_X
Date: Wed, 24 Apr 2024 17:00:16 -0700
Message-Id: <20240425000023.1002026-39-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240425000023.1002026-1-richard.henderson@linaro.org>
References: <20240425000023.1002026-1-richard.henderson@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::62e;
 envelope-from=richard.henderson@linaro.org; helo=mail-pl1-x62e.google.com
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

Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
---
 target/hppa/mem_helper.c | 46 +++++++++++++++++++++++-----------------
 1 file changed, 27 insertions(+), 19 deletions(-)

diff --git a/target/hppa/mem_helper.c b/target/hppa/mem_helper.c
index 84785b5a5c..5eca5e8a1e 100644
--- a/target/hppa/mem_helper.c
+++ b/target/hppa/mem_helper.c
@@ -295,30 +295,38 @@ int hppa_get_physical_address(CPUHPPAState *env, vaddr addr, int mmu_idx,
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


