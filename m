Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5F367C41513
	for <qemu-devel@archiver.kernel.org>; Thu, 23 May 2024 23:13:08 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sAHa4-0004pf-Ch; Thu, 23 May 2024 19:10:40 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <npiggin@gmail.com>)
 id 1sAHZt-0003on-CN; Thu, 23 May 2024 19:10:29 -0400
Received: from mail-pf1-x433.google.com ([2607:f8b0:4864:20::433])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <npiggin@gmail.com>)
 id 1sAHZr-0006CO-4p; Thu, 23 May 2024 19:10:28 -0400
Received: by mail-pf1-x433.google.com with SMTP id
 d2e1a72fcca58-6f6911d16b4so3371973b3a.3; 
 Thu, 23 May 2024 16:10:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1716505825; x=1717110625; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=lbuMqArijPah/JHN3K7DT5Fm7sQv+gbrEinFPcFcrTg=;
 b=f3dMw4QUmL4oot11Uz6L5iz6n6zUtRf0hDMpaknjt4lUh7FjtJ2dtIdBFjCPoqG84B
 /UJX/Dqx6JlY4KiIcSH8DGY7iH/JG9+F9B4rRTj8AOVc4RgngbsrcYG5it61BSqPX313
 eBoI0n/JJLG/Jp8Phg7w5PRll/fp0gt/RGHh2VUGk/mlD76MysRyYE8PmPRe8Xl+ch7m
 189YPPwEVSX6IjGyy/lmbq4OTDnwyJqk0CtC01nKSKOrl22gDjrSNVmJxNHo6KhgFo5c
 QN2/ckT2rvv6ZxQEt21s7DUfkPah0Zxct51Dv1AejOQnekB/xyVqHOMYfsjlh7juVEIW
 tcNA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1716505825; x=1717110625;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=lbuMqArijPah/JHN3K7DT5Fm7sQv+gbrEinFPcFcrTg=;
 b=MZq1WgG5goDwVP341oistfNbWxWPyteos0XPcWVLDczdL1pWKUzgo1Ab/b2bZeIfaO
 7YPoQfqOXrgExUX8/YlC6YPQ3COtlaJ7Cp2crewRoNRGuhwqYr/omDBhR8Ydizk4U2+J
 pakJ+xnStG9BLqfnac7W6z0IaGJ2OZKKp1vbhdopixB24HDyr8WXIdVHFlxMVyuobPk2
 6heTQWw1tEG/gNtCC0lx/H5FlPz5kZNG6cvxVAvRLlRm9P0P6n8mG66YGS/uaJ++9dYH
 BkeHeQgH4nFQD8YXb3w/0x2ceAE5G8tkdxj3Sw6ZbVwjacWNnA84zDLfHRCjeprD/y93
 MD+g==
X-Forwarded-Encrypted: i=1;
 AJvYcCU/CbQa9LzJkJcBILqWkQVrOtDTTw0uEB/cFV4iPeOCFQdWHKwEmY1oavH0qrPVEI8kchFEgEI/+KswLDOlz+dG/PGI
X-Gm-Message-State: AOJu0YzFW0HbVq04kg7UUWTz+xoQmv4SZ4+ZPlrfm5wtY29rwAbvVvUW
 /jJ34Qdf9RfZGY4/ixPo8TFuUnknLXhvHuWXczjU5eC2pFySyGaZCj9n7w==
X-Google-Smtp-Source: AGHT+IGXPrzpQwu9nsObc2dhfPnwNv9pH0aPi6dFQHGwpXlIXB5GMBwQVAAMnmtWh4CpKboZvWFxBw==
X-Received: by 2002:a05:6a20:7f93:b0:1b1:ed9d:f92e with SMTP id
 adf61e73a8af0-1b212e144d2mr1133483637.38.1716505824920; 
 Thu, 23 May 2024 16:10:24 -0700 (PDT)
Received: from wheely.local0.net (110-175-65-7.tpgi.com.au. [110.175.65.7])
 by smtp.gmail.com with ESMTPSA id
 41be03b00d2f7-682227f1838sm87041a12.46.2024.05.23.16.10.22
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 23 May 2024 16:10:24 -0700 (PDT)
From: Nicholas Piggin <npiggin@gmail.com>
To: qemu-devel@nongnu.org
Cc: Nicholas Piggin <npiggin@gmail.com>, qemu-ppc@nongnu.org,
 BALATON Zoltan <balaton@eik.bme.hu>
Subject: [PULL 48/72] target/ppc/mmu_common.c: Eliminate ret from
 mmu6xx_get_physical_address()
Date: Fri, 24 May 2024 09:07:21 +1000
Message-ID: <20240523230747.45703-49-npiggin@gmail.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240523230747.45703-1-npiggin@gmail.com>
References: <20240523230747.45703-1-npiggin@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::433;
 envelope-from=npiggin@gmail.com; helo=mail-pf1-x433.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, FREEMAIL_FROM=0.001,
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

From: BALATON Zoltan <balaton@eik.bme.hu>

Return directly, which is simpler than dragging a return value through
multpile if and else blocks.

Reviewed-by: Nicholas Piggin <npiggin@gmail.com>
Signed-off-by: BALATON Zoltan <balaton@eik.bme.hu>
Signed-off-by: Nicholas Piggin <npiggin@gmail.com>
---
 target/ppc/mmu_common.c | 84 +++++++++++++++++++----------------------
 1 file changed, 39 insertions(+), 45 deletions(-)

diff --git a/target/ppc/mmu_common.c b/target/ppc/mmu_common.c
index 89bfd9aa45..03d9e6bfda 100644
--- a/target/ppc/mmu_common.c
+++ b/target/ppc/mmu_common.c
@@ -386,7 +386,6 @@ static int mmu6xx_get_physical_address(CPUPPCState *env, mmu_ctx_t *ctx,
     target_ulong vsid, sr, pgidx;
     int ds, target_page_bits;
     bool pr;
-    int ret;
 
     /* First try to find a BAT entry if there are any */
     if (env->nb_BATs && get_bat_6xx_tlb(env, ctx, eaddr, access_type) == 0) {
@@ -419,7 +418,6 @@ static int mmu6xx_get_physical_address(CPUPPCState *env, mmu_ctx_t *ctx,
     qemu_log_mask(CPU_LOG_MMU,
             "pte segment: key=%d ds %d nx %d vsid " TARGET_FMT_lx "\n",
             ctx->key, ds, ctx->nx, vsid);
-    ret = -1;
     if (!ds) {
         /* Check if instruction fetch is allowed, if needed */
         if (type == ACCESS_CODE && ctx->nx) {
@@ -436,51 +434,47 @@ static int mmu6xx_get_physical_address(CPUPPCState *env, mmu_ctx_t *ctx,
         /* Initialize real address with an invalid value */
         ctx->raddr = (hwaddr)-1ULL;
         /* Software TLB search */
-        ret = ppc6xx_tlb_check(env, ctx, eaddr, access_type);
-    } else {
-        qemu_log_mask(CPU_LOG_MMU, "direct store...\n");
-        /* Direct-store segment : absolutely *BUGGY* for now */
-
-        switch (type) {
-        case ACCESS_INT:
-            /* Integer load/store : only access allowed */
-            break;
-        case ACCESS_CODE:
-            /* No code fetch is allowed in direct-store areas */
-            return -4;
-        case ACCESS_FLOAT:
-            /* Floating point load/store */
-            return -4;
-        case ACCESS_RES:
-            /* lwarx, ldarx or srwcx. */
-            return -4;
-        case ACCESS_CACHE:
-            /*
-             * dcba, dcbt, dcbtst, dcbf, dcbi, dcbst, dcbz, or icbi
-             *
-             * Should make the instruction do no-op.  As it already do
-             * no-op, it's quite easy :-)
-             */
-            ctx->raddr = eaddr;
-            return 0;
-        case ACCESS_EXT:
-            /* eciwx or ecowx */
-            return -4;
-        default:
-            qemu_log_mask(CPU_LOG_MMU, "ERROR: instruction should not need "
-                          "address translation\n");
-            return -4;
-        }
-        if ((access_type == MMU_DATA_STORE || ctx->key != 1) &&
-            (access_type == MMU_DATA_LOAD || ctx->key != 0)) {
-            ctx->raddr = eaddr;
-            ret = 2;
-        } else {
-            ret = -2;
-        }
+        return ppc6xx_tlb_check(env, ctx, eaddr, access_type);
     }
 
-    return ret;
+    /* Direct-store segment : absolutely *BUGGY* for now */
+    qemu_log_mask(CPU_LOG_MMU, "direct store...\n");
+    switch (type) {
+    case ACCESS_INT:
+        /* Integer load/store : only access allowed */
+        break;
+    case ACCESS_CODE:
+        /* No code fetch is allowed in direct-store areas */
+        return -4;
+    case ACCESS_FLOAT:
+        /* Floating point load/store */
+        return -4;
+    case ACCESS_RES:
+        /* lwarx, ldarx or srwcx. */
+        return -4;
+    case ACCESS_CACHE:
+        /*
+         * dcba, dcbt, dcbtst, dcbf, dcbi, dcbst, dcbz, or icbi
+         *
+         * Should make the instruction do no-op.  As it already do
+         * no-op, it's quite easy :-)
+         */
+        ctx->raddr = eaddr;
+        return 0;
+    case ACCESS_EXT:
+        /* eciwx or ecowx */
+        return -4;
+    default:
+        qemu_log_mask(CPU_LOG_MMU, "ERROR: instruction should not need address"
+                                   " translation\n");
+        return -4;
+    }
+    if ((access_type == MMU_DATA_STORE || ctx->key != 1) &&
+        (access_type == MMU_DATA_LOAD || ctx->key != 0)) {
+        ctx->raddr = eaddr;
+        return 2;
+    }
+    return -2;
 }
 
 /* Generic TLB check function for embedded PowerPC implementations */
-- 
2.43.0


