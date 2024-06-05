Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 68397C25B76
	for <qemu-devel@archiver.kernel.org>; Wed,  5 Jun 2024 21:17:25 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sExzC-0000jb-QR; Wed, 05 Jun 2024 17:15:58 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1sExz4-0000gS-Gp
 for qemu-devel@nongnu.org; Wed, 05 Jun 2024 17:15:51 -0400
Received: from mail-pf1-x429.google.com ([2607:f8b0:4864:20::429])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1sExyt-0003RL-L4
 for qemu-devel@nongnu.org; Wed, 05 Jun 2024 17:15:50 -0400
Received: by mail-pf1-x429.google.com with SMTP id
 d2e1a72fcca58-70249faa853so185264b3a.3
 for <qemu-devel@nongnu.org>; Wed, 05 Jun 2024 14:15:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1717622135; x=1718226935; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=WG33VLZJC75PnOwvnc92vEocKZlB7Ym1PixDIRSe3h0=;
 b=MeCgxm/dwyzn8ly/hvJE2AixVt40RUVBP4Zij5nbGVTzsKbEjDDMmpL99l4uzgBft3
 0NFNtBAI/i/BlmlgbNnElLKbNNo/SsL0hnud0NIRIXsbmnPYCeO7dyAHTDPXYmLpkkK9
 zKZZi8T2J8p2JD6JyY60M6eRD6cIcfkvWxhRkyX9bsWYKvzHfpOcRLZwLeeS6kziEme1
 cOIsAR3eWIhvIBUv66DeuQzgeakIF5AuhVWDjjlZNsH77CI9Jz9N8lIa3KeiTZTpRgxr
 0dN2aNBeT+ZcpSWkaVmtzm0GNOVn6p/dDH13sJ4094r/PSTfFutciuqMnyr3TN1o+EzF
 O+Kw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1717622135; x=1718226935;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=WG33VLZJC75PnOwvnc92vEocKZlB7Ym1PixDIRSe3h0=;
 b=JKjDZ7Y6IYRShqnm+ImfpQeIZokuFu2LGkch9yGPN0mgs3gYgFNi4d6gNcQj5MPCxg
 U9vyLGS2VU7hhEABMIKJVaQj+BYZ4UJg1N79m8D120IuFp/QIUoqrnjZjL3SHbRlM0mi
 gZgkKyICaoHfpUoRVQnnCJ5LQuk54Plw68uzsT10IR8dRN3kz5h0cWmF95a7pt1S5XoR
 E9yc4THHOw635VjopPVAulB7tAnU0XvBUeYHvc2Ou57ekGcYAXj04ClnP/iAGdv59pGE
 Th3aOTP7bn+sKFLlnskv8XHCxR+9jNOWexnJpMVyiEDqaAUTkjOgBWyXoNFH/GTeUsMa
 xvSA==
X-Gm-Message-State: AOJu0YxmnxMFU0AVKvCAHCj4H3r/yE/IcsahTRxJ6AaMs6Ay6CdvYdHK
 BcaLIn5JHXEBfD5YdZrV6DzmYrxqTF9QMRQz5dvXF40nl2dd6pXFt6N763XeUPhTyooduOWiwCA
 E
X-Google-Smtp-Source: AGHT+IGy4hgu0nwFlunPA6OOmL4kdhFw0nm2EwoAcG2FHwPa+D6HYgvmMO8IAm8fLYV8ICK/4JIXjA==
X-Received: by 2002:a05:6a20:f39c:b0:1a9:ffa0:d007 with SMTP id
 adf61e73a8af0-1b2b71c805bmr3812989637.58.1717622134556; 
 Wed, 05 Jun 2024 14:15:34 -0700 (PDT)
Received: from stoup.. ([71.212.132.216]) by smtp.gmail.com with ESMTPSA id
 d2e1a72fcca58-70242aec7d0sm9347538b3a.99.2024.06.05.14.15.33
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 05 Jun 2024 14:15:34 -0700 (PDT)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Cc: Pierrick Bouvier <pierrick.bouvier@linaro.org>
Subject: [PULL 13/16] disas/microblaze: Print immediates directly with PRIimm
Date: Wed,  5 Jun 2024 14:15:18 -0700
Message-Id: <20240605211521.577094-14-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240605211521.577094-1-richard.henderson@linaro.org>
References: <20240605211521.577094-1-richard.henderson@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::429;
 envelope-from=richard.henderson@linaro.org; helo=mail-pf1-x429.google.com
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

Use a printf format instead of sprintf into a buffer.

Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
Reviewed-by: Pierrick Bouvier <pierrick.bouvier@linaro.org>
Message-Id: <20240412073346.458116-19-richard.henderson@linaro.org>
---
 disas/microblaze.c | 61 +++++++++-------------------------------------
 1 file changed, 11 insertions(+), 50 deletions(-)

diff --git a/disas/microblaze.c b/disas/microblaze.c
index c12968f3b9..390f98c0a3 100644
--- a/disas/microblaze.c
+++ b/disas/microblaze.c
@@ -580,40 +580,21 @@ static const char pvr_register_prefix[] = "rpvr";
 #include "disas/dis-asm.h"
 
 #define PRIreg    register_prefix "%ld"
+#define PRIimm    "%d"
 
 #define get_field_rd(instr)      ((instr & RD_MASK) >> RD_LOW)
 #define get_field_r1(instr)      ((instr & RA_MASK) >> RA_LOW)
 #define get_field_r2(instr)      ((instr & RB_MASK) >> RB_LOW)
+#define get_field_imm(instr)     ((int16_t)instr)
+#define get_field_imm5(instr)    ((int)instr & IMM5_MASK)
+#define get_field_imm15(instr)   ((int)instr & IMM15_MASK)
+
 #define get_int_field_imm(instr) ((instr & IMM_MASK) >> IMM_LOW)
 #define get_int_field_r1(instr) ((instr & RA_MASK) >> RA_LOW)
 
 /* Local function prototypes. */
 
-static char * get_field_imm (long instr);
-static char * get_field_imm5 (long instr);
 static char * get_field_rfsl (long instr);
-static char * get_field_imm15 (long instr);
-#if 0
-static char * get_field_unsigned_imm (long instr);
-#endif
-
-static char *
-get_field_imm (long instr)
-{
-  char tmpstr[25];
-  snprintf(tmpstr, sizeof(tmpstr), "%d",
-           (short)((instr & IMM_MASK) >> IMM_LOW));
-  return(strdup(tmpstr));
-}
-
-static char *
-get_field_imm5 (long instr)
-{
-  char tmpstr[25];
-  snprintf(tmpstr, sizeof(tmpstr), "%d",
-           (short)((instr & IMM5_MASK) >> IMM_LOW));
-  return(strdup(tmpstr));
-}
 
 static char *
 get_field_rfsl (long instr)
@@ -624,26 +605,6 @@ get_field_rfsl (long instr)
   return(strdup(tmpstr));
 }
 
-static char *
-get_field_imm15 (long instr)
-{
-  char tmpstr[25];
-  snprintf(tmpstr, sizeof(tmpstr), "%d",
-           (short)((instr & IMM15_MASK) >> IMM_LOW));
-  return(strdup(tmpstr));
-}
-
-#if 0
-static char *
-get_field_unsigned_imm (long instr)
-{
-  char tmpstr[25];
-  snprintf(tmpstr, sizeof(tmpstr), "%d",
-           (int)((instr & IMM_MASK) >> IMM_LOW));
-  return(strdup(tmpstr));
-}
-#endif
-
 /*
   char *
   get_field_special (instr) 
@@ -829,7 +790,7 @@ print_insn_microblaze(bfd_vma memaddr, struct disassemble_info *info)
                      get_field_r2(inst));
         break;
     case INST_TYPE_RD_R1_IMM:
-        fprintf_func(stream, "%s\t" PRIreg ", " PRIreg ", %s",
+        fprintf_func(stream, "%s\t" PRIreg ", " PRIreg ", " PRIimm,
                      op->name, get_field_rd(inst), get_field_r1(inst),
                      get_field_imm(inst));
         if (get_int_field_r1(inst) == 0) {
@@ -837,7 +798,7 @@ print_insn_microblaze(bfd_vma memaddr, struct disassemble_info *info)
         }
         break;
     case INST_TYPE_RD_R1_IMM5:
-        fprintf_func(stream, "%s\t" PRIreg ", " PRIreg ", %s",
+        fprintf_func(stream, "%s\t" PRIreg ", " PRIreg ", " PRIimm,
                      op->name, get_field_rd(inst), get_field_r1(inst),
                      get_field_imm5(inst));
         break;
@@ -866,7 +827,7 @@ print_insn_microblaze(bfd_vma memaddr, struct disassemble_info *info)
                      op->name, get_field_r1(inst), get_field_r2(inst));
         break;
     case INST_TYPE_R1_IMM:
-        fprintf_func(stream, "%s\t" PRIreg ", %s",
+        fprintf_func(stream, "%s\t" PRIreg ", " PRIimm,
                      op->name, get_field_r1(inst), get_field_imm(inst));
         /*
          * The non-pc relative instructions are returns,
@@ -877,14 +838,14 @@ print_insn_microblaze(bfd_vma memaddr, struct disassemble_info *info)
         }
         break;
     case INST_TYPE_RD_IMM:
-        fprintf_func(stream, "%s\t" PRIreg ", %s",
+        fprintf_func(stream, "%s\t" PRIreg ", " PRIimm,
                      op->name, get_field_rd(inst), get_field_imm(inst));
         print_immval_addr(info, immfound, immval, inst,
                           op->inst_offset_type == INST_PC_OFFSET
                           ? memaddr : 0);
         break;
     case INST_TYPE_IMM:
-        fprintf_func(stream, "%s\t%s",
+        fprintf_func(stream, "%s\t" PRIimm,
                      op->name, get_field_imm(inst));
         if (op->instr != imm) {
             print_immval_addr(info, immfound, immval, inst,
@@ -909,7 +870,7 @@ print_insn_microblaze(bfd_vma memaddr, struct disassemble_info *info)
                      op->name, get_field_rd(inst), get_field_r2(inst));
         break;
     case INST_TYPE_RD_IMM15:
-        fprintf_func(stream, "%s\t" PRIreg ", %s",
+        fprintf_func(stream, "%s\t" PRIreg ", " PRIimm,
                      op->name, get_field_rd(inst), get_field_imm15(inst));
         break;
         /* For tuqula instruction */
-- 
2.34.1


