Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C210CC27C52
	for <qemu-devel@archiver.kernel.org>; Wed,  5 Jun 2024 21:18:55 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sExz6-0000gj-84; Wed, 05 Jun 2024 17:15:52 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1sExz0-0000ef-Jo
 for qemu-devel@nongnu.org; Wed, 05 Jun 2024 17:15:47 -0400
Received: from mail-pf1-x42d.google.com ([2607:f8b0:4864:20::42d])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1sExys-0003RX-TW
 for qemu-devel@nongnu.org; Wed, 05 Jun 2024 17:15:46 -0400
Received: by mail-pf1-x42d.google.com with SMTP id
 d2e1a72fcca58-702508bf0a9so216624b3a.0
 for <qemu-devel@nongnu.org>; Wed, 05 Jun 2024 14:15:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1717622135; x=1718226935; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=9ILfcAsPqRhnr4sSxUgoQKpIDcJ0mZe41RgVmdO69OU=;
 b=AaOZDN0yCNLi5u/+tRV8i+SsIbW47qvnsEqfvrN+5wHqzabQQMp4a4EJ8DpSycvVVt
 tXfSIUraUvaXy6jcUFR2xEhtksukQhMkYdZGiAN2mkssdqoXFOdSUTnZMusHMfmZEsAP
 +AokTYImaTFoA08Zv8Wtm/Gm2hxLamS54sQXMJSEcNKyE0kJ4i837aV0iYnkcUcRzSxp
 c0zb/lGYyl/oMb84I/kSSxckue3KU7lRq6aoAYTbuon30ln/nYC0HBU0tcFTD70YsRb5
 ze3tzI3BSJzrQg/mzbBZXzReqNRJYSRB9YCQSp+jRl9UilqkSWsA5LYYk/eNHFTi+pX5
 paCA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1717622135; x=1718226935;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=9ILfcAsPqRhnr4sSxUgoQKpIDcJ0mZe41RgVmdO69OU=;
 b=MkuGYElfx3JiV/oiEsYlKYDfUwIzYIOwGRVlaNZjL4VuvjLjKAMyOL6PlgJ1FtKWlc
 gZoHQcbqxJ7dJ+CURPiidvtEEfhFpP1e3A85hdceUySNguMR83oQ4lVKYqvyBWbOnxqW
 kjfiTgYbXzO8PX+3UXBlpNqNtao3KgLA0FRDwNts/NykL7By50z652ZwN6vLB7IyjJQL
 mt830XpSt1SPQtnnOSQ4njF2qXRgUIZKguE+xWyb1vt8GF5IOjoP1wl3j3pV2Hd5yjjb
 /JJ5E/ZzN79rNYmg6LCBAJSYiFQK0u+ryIP5J+4NOcDyrEV/Zao5Kq/pYKn8WMAgZF5h
 kM2w==
X-Gm-Message-State: AOJu0YwCo+O2E1/DRZtYrvREHarzjbYbisio2VJ0qwbabSaN7BaKJBsY
 XxOZjBLAV7ToDO/3dfq0GtVgvz2OTBcLsLP7pVcXGvpvmALiwFfAbShITQHDPegAcBBMPECsaPv
 L
X-Google-Smtp-Source: AGHT+IGN7dN0U2L5QM1XvOhTGCfT8GLQ9fV9sC3A/vllHvSZzqGKbQJKQt2UHWaw1kTUnAEY9DpbNQ==
X-Received: by 2002:a05:6a00:99d:b0:6f3:ecdc:220e with SMTP id
 d2e1a72fcca58-703e5a249e0mr4497949b3a.24.1717622135494; 
 Wed, 05 Jun 2024 14:15:35 -0700 (PDT)
Received: from stoup.. ([71.212.132.216]) by smtp.gmail.com with ESMTPSA id
 d2e1a72fcca58-70242aec7d0sm9347538b3a.99.2024.06.05.14.15.34
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 05 Jun 2024 14:15:35 -0700 (PDT)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Cc: Pierrick Bouvier <pierrick.bouvier@linaro.org>
Subject: [PULL 14/16] disas/microblaze: Print registers directly with PRIrfsl
Date: Wed,  5 Jun 2024 14:15:19 -0700
Message-Id: <20240605211521.577094-15-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240605211521.577094-1-richard.henderson@linaro.org>
References: <20240605211521.577094-1-richard.henderson@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::42d;
 envelope-from=richard.henderson@linaro.org; helo=mail-pf1-x42d.google.com
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
Message-Id: <20240412073346.458116-20-richard.henderson@linaro.org>
---
 disas/microblaze.c | 22 +++++-----------------
 1 file changed, 5 insertions(+), 17 deletions(-)

diff --git a/disas/microblaze.c b/disas/microblaze.c
index 390f98c0a3..24febfdea9 100644
--- a/disas/microblaze.c
+++ b/disas/microblaze.c
@@ -564,7 +564,6 @@ static const struct op_code_struct {
 
 /* prefix for register names */
 #define register_prefix "r"
-static const char fsl_register_prefix[] = "rfsl";
 static const char pvr_register_prefix[] = "rpvr";
 
 
@@ -580,11 +579,13 @@ static const char pvr_register_prefix[] = "rpvr";
 #include "disas/dis-asm.h"
 
 #define PRIreg    register_prefix "%ld"
+#define PRIrfsl   register_prefix "fsl%ld"
 #define PRIimm    "%d"
 
 #define get_field_rd(instr)      ((instr & RD_MASK) >> RD_LOW)
 #define get_field_r1(instr)      ((instr & RA_MASK) >> RA_LOW)
 #define get_field_r2(instr)      ((instr & RB_MASK) >> RB_LOW)
+#define get_field_rfsl(instr)    (instr & RFSL_MASK)
 #define get_field_imm(instr)     ((int16_t)instr)
 #define get_field_imm5(instr)    ((int)instr & IMM5_MASK)
 #define get_field_imm15(instr)   ((int)instr & IMM15_MASK)
@@ -592,19 +593,6 @@ static const char pvr_register_prefix[] = "rpvr";
 #define get_int_field_imm(instr) ((instr & IMM_MASK) >> IMM_LOW)
 #define get_int_field_r1(instr) ((instr & RA_MASK) >> RA_LOW)
 
-/* Local function prototypes. */
-
-static char * get_field_rfsl (long instr);
-
-static char *
-get_field_rfsl (long instr)
-{
-  char tmpstr[25];
-  snprintf(tmpstr, sizeof(tmpstr), "%s%d", fsl_register_prefix,
-           (short)((instr & RFSL_MASK) >> IMM_LOW));
-  return(strdup(tmpstr));
-}
-
 /*
   char *
   get_field_special (instr) 
@@ -803,11 +791,11 @@ print_insn_microblaze(bfd_vma memaddr, struct disassemble_info *info)
                      get_field_imm5(inst));
         break;
     case INST_TYPE_RD_RFSL:
-        fprintf_func(stream, "%s\t" PRIreg ", %s",
+        fprintf_func(stream, "%s\t" PRIreg ", " PRIrfsl,
                      op->name, get_field_rd(inst), get_field_rfsl(inst));
         break;
     case INST_TYPE_R1_RFSL:
-        fprintf_func(stream, "%s\t" PRIreg ", %s",
+        fprintf_func(stream, "%s\t" PRIreg ", " PRIrfsl,
                      op->name, get_field_r1(inst), get_field_rfsl(inst));
         break;
     case INST_TYPE_RD_SPECIAL:
@@ -879,7 +867,7 @@ print_insn_microblaze(bfd_vma memaddr, struct disassemble_info *info)
                      op->name, get_field_rd(inst));
         break;
     case INST_TYPE_RFSL:
-        fprintf_func(stream, "%s\t%s",
+        fprintf_func(stream, "%s\t" PRIrfsl,
                      op->name, get_field_rfsl(inst));
         break;
     default:
-- 
2.34.1


