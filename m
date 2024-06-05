Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 53D06C25B76
	for <qemu-devel@archiver.kernel.org>; Wed,  5 Jun 2024 21:17:36 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sExzC-0000jD-3Z; Wed, 05 Jun 2024 17:15:58 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1sExz2-0000fw-VE
 for qemu-devel@nongnu.org; Wed, 05 Jun 2024 17:15:48 -0400
Received: from mail-pf1-x431.google.com ([2607:f8b0:4864:20::431])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1sExys-0003Rh-Th
 for qemu-devel@nongnu.org; Wed, 05 Jun 2024 17:15:48 -0400
Received: by mail-pf1-x431.google.com with SMTP id
 d2e1a72fcca58-703ed5d37acso209639b3a.0
 for <qemu-devel@nongnu.org>; Wed, 05 Jun 2024 14:15:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1717622136; x=1718226936; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=Chtdl64sSN7t9wuikeNXRUJv7hjmKkzPpF45qIUWzPg=;
 b=UvnZ7sm//ZBM+OB38VIHn88VIEujWtVEM+OZpQmDdnA1KkTXyx4KAEEbz4ZQsHNCth
 eDOwSPcc90f0cZ4uqo02tAiiSwxDTuBmpoBMnoU0RWr85/ji1iJCsPGAZEsoUquTd7Kd
 Bxxw6mHvMCsqhVTUsbg4BnitaPtiPWGg7uVdqWsEKaxGif0j7Vnnsnw5sijz7VMVoDrU
 iLDNYscu39rZp6kOSSrY4S0DQAB8sF7UNtvLvMJc4mN465foarfkXgTxoNEdHIjzfjZk
 To2sYJcW9uRNsZuyAjewVjIVeb48hnY/TlyIsjXIGxv1OPgSZuPBQfPFwd7D32ik03xL
 5N2g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1717622136; x=1718226936;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=Chtdl64sSN7t9wuikeNXRUJv7hjmKkzPpF45qIUWzPg=;
 b=ZppCoa3O41TyDcFrjoGB46pQcZqfijP1WEb2nt0WWNAG8L9Z7oQ302GXNfXyOl/uL8
 1SMS996gUw/p8GAhNamidJTgYI93ypf1ekcHy0kBFaePM/E2QIqZp7nbng9mGjRunNIe
 I8MhEkWW5MHXx44UCcFeILInYWYt0MCH7anshtbkFq94HU1z85QrmhyxB+h1TmZXWixV
 +uDxl9DY+elEIOXeNGMvSf9M1QULw2zfy0Ri6DELckM2J/IOu63aSvDGD5RM4smfxWMq
 1U+Yj+mW8NHIqkNGXcDgzl0P0d2Gkju9QGmJKpEqAx4w0hekEibrAqSpzBj+x5iXJfgP
 u7pQ==
X-Gm-Message-State: AOJu0YxWMyx+bc047QY+jrO8HxsOwzNPwG8yKzV29K2LjFDXF40x179K
 NS0Z2gJpzulntQbQIdiRJ+gt3BOT5TgMHuaCYi5tPhIXN/9S4yy8W3IXbYA1GikikxIx+llGLkX
 H
X-Google-Smtp-Source: AGHT+IGC3pApWPCWzkjB3FysAD6FZie0MrCVes8jNFtM0lWzZVkcI6I99uHT21o3TEXZE9DKZ9miXQ==
X-Received: by 2002:a05:6a00:330e:b0:702:6dc7:2368 with SMTP id
 d2e1a72fcca58-703e59b05fdmr3970041b3a.12.1717622136356; 
 Wed, 05 Jun 2024 14:15:36 -0700 (PDT)
Received: from stoup.. ([71.212.132.216]) by smtp.gmail.com with ESMTPSA id
 d2e1a72fcca58-70242aec7d0sm9347538b3a.99.2024.06.05.14.15.35
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 05 Jun 2024 14:15:35 -0700 (PDT)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Cc: Pierrick Bouvier <pierrick.bouvier@linaro.org>
Subject: [PULL 15/16] disas/microblaze: Split get_field_special
Date: Wed,  5 Jun 2024 14:15:20 -0700
Message-Id: <20240605211521.577094-16-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240605211521.577094-1-richard.henderson@linaro.org>
References: <20240605211521.577094-1-richard.henderson@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::431;
 envelope-from=richard.henderson@linaro.org; helo=mail-pf1-x431.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
 T_SCC_BODY_TEXT_LINE=-0.01 autolearn=ham autolearn_force=no
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

Extract the raw special index and a function to lookup a name.

Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
Reviewed-by: Pierrick Bouvier <pierrick.bouvier@linaro.org>
Message-Id: <20240412073346.458116-21-richard.henderson@linaro.org>
---
 disas/microblaze.c | 142 +++++++++++++++++++--------------------------
 1 file changed, 61 insertions(+), 81 deletions(-)

diff --git a/disas/microblaze.c b/disas/microblaze.c
index 24febfdea9..197327fae4 100644
--- a/disas/microblaze.c
+++ b/disas/microblaze.c
@@ -564,8 +564,6 @@ static const struct op_code_struct {
 
 /* prefix for register names */
 #define register_prefix "r"
-static const char pvr_register_prefix[] = "rpvr";
-
 
 /* #defines for valid immediate range */
 #define MIN_IMM  ((int) 0x80000000)
@@ -580,6 +578,7 @@ static const char pvr_register_prefix[] = "rpvr";
 
 #define PRIreg    register_prefix "%ld"
 #define PRIrfsl   register_prefix "fsl%ld"
+#define PRIpvr    register_prefix "pvr%d"
 #define PRIimm    "%d"
 
 #define get_field_rd(instr)      ((instr & RD_MASK) >> RD_LOW)
@@ -593,83 +592,48 @@ static const char pvr_register_prefix[] = "rpvr";
 #define get_int_field_imm(instr) ((instr & IMM_MASK) >> IMM_LOW)
 #define get_int_field_r1(instr) ((instr & RA_MASK) >> RA_LOW)
 
-/*
-  char *
-  get_field_special (instr) 
-  long instr;
-  {
-  char tmpstr[25];
-  
-  snprintf(tmpstr, sizeof(tmpstr), "%s%s", register_prefix,
-          (((instr & IMM_MASK) >> IMM_LOW) & REG_MSR_MASK) == 0 ? "pc" : "msr");
-  
-  return(strdup(tmpstr));
-  }
-*/
-
-static char *
-get_field_special(long instr, const struct op_code_struct *op)
+static int get_field_special(long instr, const struct op_code_struct *op)
 {
-   char tmpstr[25];
-   char spr[6];
+    return ((instr & IMM_MASK) >> IMM_LOW) ^ op->immval_mask;
+}
 
-   switch ( (((instr & IMM_MASK) >> IMM_LOW) ^ op->immval_mask) ) {
-
-   case REG_MSR_MASK :
-      strcpy(spr, "msr");
-      break;
-   case REG_PC_MASK :
-      strcpy(spr, "pc");
-      break;
-   case REG_EAR_MASK :
-      strcpy(spr, "ear");
-      break;
-   case REG_ESR_MASK :
-      strcpy(spr, "esr");
-      break;
-   case REG_FSR_MASK :
-      strcpy(spr, "fsr");
-      break;
-   case REG_BTR_MASK :
-      strcpy(spr, "btr");
-      break;      
-   case REG_EDR_MASK :
-      strcpy(spr, "edr");
-      break;
-   case REG_PID_MASK :
-      strcpy(spr, "pid");
-      break;
-   case REG_ZPR_MASK :
-      strcpy(spr, "zpr");
-      break;
-   case REG_TLBX_MASK :
-      strcpy(spr, "tlbx");
-      break;
-   case REG_TLBLO_MASK :
-      strcpy(spr, "tlblo");
-      break;
-   case REG_TLBHI_MASK :
-      strcpy(spr, "tlbhi");
-      break;
-   case REG_TLBSX_MASK :
-      strcpy(spr, "tlbsx");
-      break;
-   default :
-     {
-       if ( ((((instr & IMM_MASK) >> IMM_LOW) ^ op->immval_mask) & 0xE000) == REG_PVR_MASK) {
-          snprintf(tmpstr, sizeof(tmpstr), "%s%u", pvr_register_prefix,
-                 (unsigned short)(((instr & IMM_MASK) >> IMM_LOW) ^
-                                  op->immval_mask) ^ REG_PVR_MASK);
-	 return(strdup(tmpstr));
-       } else {
-	 strcpy(spr, "pc");
-       }
-     }
-     break;
-   }
-   
-   snprintf(tmpstr, sizeof(tmpstr), "%s%s", register_prefix, spr);
-   return(strdup(tmpstr));
+/* Returns NULL for PVR registers, which should be rendered differently. */
+static const char *get_special_name(int special)
+{
+    switch (special) {
+    case REG_MSR_MASK:
+        return register_prefix "msr";
+    case REG_PC_MASK:
+        return register_prefix "pc";
+    case REG_EAR_MASK:
+        return register_prefix "ear";
+    case REG_ESR_MASK:
+        return register_prefix "esr";
+    case REG_FSR_MASK:
+        return register_prefix "fsr";
+    case REG_BTR_MASK:
+        return register_prefix "btr";
+    case REG_EDR_MASK:
+        return register_prefix "edr";
+    case REG_PID_MASK:
+        return register_prefix "pid";
+    case REG_ZPR_MASK:
+        return register_prefix "zpr";
+    case REG_TLBX_MASK:
+        return register_prefix "tlbx";
+    case REG_TLBLO_MASK:
+        return register_prefix "tlblo";
+    case REG_TLBHI_MASK:
+        return register_prefix "tlbhi";
+    case REG_TLBSX_MASK:
+        return register_prefix "tlbsx";
+    default:
+        if ((special & 0xE000) == REG_PVR_MASK) {
+            /* pvr register */
+            return NULL;
+        }
+        return register_prefix "pc";
+    }
 }
 
 static unsigned long
@@ -739,6 +703,8 @@ print_insn_microblaze(bfd_vma memaddr, struct disassemble_info *info)
     static bfd_vma prev_insn_addr = -1; /*init the prev insn addr */
     static int prev_insn_vma = -1;  /*init the prev insn vma */
     int curr_insn_vma = info->buffer_vma;
+    int special;
+    const char *special_name;
 
     info->bytes_per_chunk = 4;
 
@@ -799,12 +765,26 @@ print_insn_microblaze(bfd_vma memaddr, struct disassemble_info *info)
                      op->name, get_field_r1(inst), get_field_rfsl(inst));
         break;
     case INST_TYPE_RD_SPECIAL:
-        fprintf_func(stream, "%s\t" PRIreg ", %s",
-                     op->name, get_field_rd(inst), get_field_special(inst, op));
+        special = get_field_special(inst, op);
+        special_name = get_special_name(special);
+        if (special_name) {
+            fprintf_func(stream, "%s\t" PRIreg ", %s",
+                         op->name, get_field_rd(inst), special_name);
+        } else {
+            fprintf_func(stream, "%s\t" PRIreg ", " PRIpvr,
+                         op->name, get_field_rd(inst), special ^ REG_PVR_MASK);
+        }
         break;
     case INST_TYPE_SPECIAL_R1:
-        fprintf_func(stream, "%s\t%s, " PRIreg,
-                     op->name, get_field_special(inst, op), get_field_r1(inst));
+        special = get_field_special(inst, op);
+        special_name = get_special_name(special);
+        if (special_name) {
+            fprintf_func(stream, "%s\t%s, " PRIreg,
+                         op->name, special_name, get_field_r1(inst));
+        } else {
+            fprintf_func(stream, "%s\t" PRIpvr ", " PRIreg,
+                         op->name, special ^ REG_PVR_MASK, get_field_r1(inst));
+        }
         break;
     case INST_TYPE_RD_R1:
         fprintf_func(stream, "%s\t" PRIreg ", " PRIreg,
-- 
2.34.1


