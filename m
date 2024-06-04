Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 63593C25B78
	for <qemu-devel@archiver.kernel.org>; Tue,  4 Jun 2024 09:57:52 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sEQua-0005ZY-8D; Tue, 04 Jun 2024 05:57:00 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1sEQuY-0005Z3-SO
 for qemu-devel@nongnu.org; Tue, 04 Jun 2024 05:56:58 -0400
Received: from mail-wr1-x42e.google.com ([2a00:1450:4864:20::42e])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1sEQuW-000261-TH
 for qemu-devel@nongnu.org; Tue, 04 Jun 2024 05:56:58 -0400
Received: by mail-wr1-x42e.google.com with SMTP id
 ffacd0b85a97d-35dcd5377c4so4442046f8f.2
 for <qemu-devel@nongnu.org>; Tue, 04 Jun 2024 02:56:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1717495015; x=1718099815; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=vkD3w3/QnVGpH+/ZIlaZduOawYbzu0aNROx1qgMgywQ=;
 b=Bil//0OEsxsi3lJxCzD/CQy/kMLOEWmdTK4Sb56Hh4jH1rfKudFg8dPYwK6c49ggXN
 k4WAVSyy8+1SxT2vVIhYG0upm2007afc1BMBUwcALs3mX4ZdRcLzzTz4pcQDnE0ALT6s
 7VBCr3xcm2A3FgE6y4eNFevxebPLC0CCu7XKqeuYyOCDXvsRAgx7oHNt0ZyJUTYiIotN
 J3p6LQ+N+rn6AvuQs4JuG04jvd06ia/SA0KJ0hn47p8Xpej+qB0BB8EcG2cHQMOuDyur
 vH/mDex5DZ4Z9WG5a+KFCXFvWL0FjizuCUIlA4DoPPm1MFCMv/KHJkT0zQFFQbcPz5Z1
 xkwg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1717495015; x=1718099815;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=vkD3w3/QnVGpH+/ZIlaZduOawYbzu0aNROx1qgMgywQ=;
 b=r26JDxFYeOYCvEvVdm+d1XIAonN5h14WW8gzvPxmFX16eKPpbFptbZ2wLpRgKlxGM9
 QdoqrMyp/D615SMQXaQDRa1Ie4yzJISdRh5iVMCSmx1y22SlyBqnXKRfRNWq7PQZKfk3
 T6cRf1cji/Qs+a2yy5bX4NEve8dVMK9F0aLN1eNdNbaV2SP2EQunR2zpFtkSGl5HKcQe
 2I3qIn0KhZSX9/HFxDiTurHVha2IkBQLnQTyPSVB8e2AHszWDPHL2Bb1tHa+cjx3QPFK
 f4pQ4iEt6P8W5qtcvoZlnAohhUAMsnpGazZ85yA3Wfz3Zgvn8lHydq5zghhBXg2ISlDh
 aAlg==
X-Gm-Message-State: AOJu0Ywc00+NC0cAy+tZyRjEQwmN++NF3biASGzC8QQrB0vKeo9rwMCD
 autmz33Vg3LmMQD+wiQuTGajOsgSHM0hRTWYEdQwpnB+m0nUml60bXsflU+6wfc5XLKSpvd2RHM
 Q
X-Google-Smtp-Source: AGHT+IF3905Eq57FpvlfP0N2hoGm5y4O+6V7XarkSYN030TNRFD4wsfMnD/RZfWk85H4PmmHa8DqsA==
X-Received: by 2002:a5d:484f:0:b0:354:e22d:c7da with SMTP id
 ffacd0b85a97d-35e0f2a9ab0mr8195900f8f.39.1717495015110; 
 Tue, 04 Jun 2024 02:56:55 -0700 (PDT)
Received: from m1x-phil.lan ([176.176.159.34])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-35dd066b47asm10972385f8f.112.2024.06.04.02.56.54
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Tue, 04 Jun 2024 02:56:54 -0700 (PDT)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
To: qemu-devel@nongnu.org
Cc: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 "Edgar E . Iglesias" <edgar.iglesias@amd.com>,
 Richard Henderson <richard.henderson@linaro.org>
Subject: [PULL 08/32] disas/microblaze: Replace sprintf() by snprintf()
Date: Tue,  4 Jun 2024 11:55:44 +0200
Message-ID: <20240604095609.12285-9-philmd@linaro.org>
X-Mailer: git-send-email 2.41.0
In-Reply-To: <20240604095609.12285-1-philmd@linaro.org>
References: <20240604095609.12285-1-philmd@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::42e;
 envelope-from=philmd@linaro.org; helo=mail-wr1-x42e.google.com
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

sprintf() is deprecated on Darwin since macOS 13.0 / XCode 14.1,
resulting in painful developper experience. Use snprintf() instead.

Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
Reviewed-by: Edgar E. Iglesias <edgar.iglesias@amd.com>
Message-Id: <20240411104340.6617-3-philmd@linaro.org>
Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
---
 disas/microblaze.c | 25 ++++++++++++++++---------
 1 file changed, 16 insertions(+), 9 deletions(-)

diff --git a/disas/microblaze.c b/disas/microblaze.c
index 0b89b9c4fa..49a4c0fd40 100644
--- a/disas/microblaze.c
+++ b/disas/microblaze.c
@@ -600,7 +600,8 @@ static char *
 get_field (long instr, long mask, unsigned short low)
 {
   char tmpstr[25];
-  sprintf(tmpstr, "%s%d", register_prefix, (int)((instr & mask) >> low));
+  snprintf(tmpstr, sizeof(tmpstr), "%s%d", register_prefix,
+           (int)((instr & mask) >> low));
   return(strdup(tmpstr));
 }
 
@@ -608,7 +609,8 @@ static char *
 get_field_imm (long instr)
 {
   char tmpstr[25];
-  sprintf(tmpstr, "%d", (short)((instr & IMM_MASK) >> IMM_LOW));
+  snprintf(tmpstr, sizeof(tmpstr), "%d",
+           (short)((instr & IMM_MASK) >> IMM_LOW));
   return(strdup(tmpstr));
 }
 
@@ -616,7 +618,8 @@ static char *
 get_field_imm5 (long instr)
 {
   char tmpstr[25];
-  sprintf(tmpstr, "%d", (short)((instr & IMM5_MASK) >> IMM_LOW));
+  snprintf(tmpstr, sizeof(tmpstr), "%d",
+           (short)((instr & IMM5_MASK) >> IMM_LOW));
   return(strdup(tmpstr));
 }
 
@@ -624,7 +627,8 @@ static char *
 get_field_rfsl (long instr)
 {
   char tmpstr[25];
-  sprintf(tmpstr, "%s%d", fsl_register_prefix, (short)((instr & RFSL_MASK) >> IMM_LOW));
+  snprintf(tmpstr, sizeof(tmpstr), "%s%d", fsl_register_prefix,
+           (short)((instr & RFSL_MASK) >> IMM_LOW));
   return(strdup(tmpstr));
 }
 
@@ -632,7 +636,8 @@ static char *
 get_field_imm15 (long instr)
 {
   char tmpstr[25];
-  sprintf(tmpstr, "%d", (short)((instr & IMM15_MASK) >> IMM_LOW));
+  snprintf(tmpstr, sizeof(tmpstr), "%d",
+           (short)((instr & IMM15_MASK) >> IMM_LOW));
   return(strdup(tmpstr));
 }
 
@@ -641,7 +646,8 @@ static char *
 get_field_unsigned_imm (long instr)
 {
   char tmpstr[25];
-  sprintf(tmpstr, "%d", (int)((instr & IMM_MASK) >> IMM_LOW));
+  snprintf(tmpstr, sizeof(tmpstr), "%d",
+           (int)((instr & IMM_MASK) >> IMM_LOW));
   return(strdup(tmpstr));
 }
 #endif
@@ -653,7 +659,8 @@ get_field_unsigned_imm (long instr)
   {
   char tmpstr[25];
   
-  sprintf(tmpstr, "%s%s", register_prefix, (((instr & IMM_MASK) >> IMM_LOW) & REG_MSR_MASK) == 0 ? "pc" : "msr");
+  snprintf(tmpstr, sizeof(tmpstr), "%s%s", register_prefix,
+          (((instr & IMM_MASK) >> IMM_LOW) & REG_MSR_MASK) == 0 ? "pc" : "msr");
   
   return(strdup(tmpstr));
   }
@@ -709,7 +716,7 @@ get_field_special(long instr, const struct op_code_struct *op)
    default :
      {
        if ( ((((instr & IMM_MASK) >> IMM_LOW) ^ op->immval_mask) & 0xE000) == REG_PVR_MASK) {
-	  sprintf(tmpstr, "%s%u", pvr_register_prefix,
+          snprintf(tmpstr, sizeof(tmpstr), "%s%u", pvr_register_prefix,
                  (unsigned short)(((instr & IMM_MASK) >> IMM_LOW) ^
                                   op->immval_mask) ^ REG_PVR_MASK);
 	 return(strdup(tmpstr));
@@ -720,7 +727,7 @@ get_field_special(long instr, const struct op_code_struct *op)
      break;
    }
    
-   sprintf(tmpstr, "%s%s", register_prefix, spr);
+   snprintf(tmpstr, sizeof(tmpstr), "%s%s", register_prefix, spr);
    return(strdup(tmpstr));
 }
 
-- 
2.41.0


