Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9C825C27C52
	for <qemu-devel@archiver.kernel.org>; Wed,  5 Jun 2024 17:24:32 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sEuMH-0006F0-Lf; Wed, 05 Jun 2024 13:23:33 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1sEuMG-0006Dm-Ap
 for qemu-devel@nongnu.org; Wed, 05 Jun 2024 13:23:32 -0400
Received: from mail-pj1-x1030.google.com ([2607:f8b0:4864:20::1030])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1sEuME-0003yL-LG
 for qemu-devel@nongnu.org; Wed, 05 Jun 2024 13:23:32 -0400
Received: by mail-pj1-x1030.google.com with SMTP id
 98e67ed59e1d1-2c210d3dc6cso46453a91.3
 for <qemu-devel@nongnu.org>; Wed, 05 Jun 2024 10:23:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1717608209; x=1718213009; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=KRSONPc2DGnaPERH9Q3QmRlRviTZJDZC0RtDsaFgyb8=;
 b=RV1HFd8642VfVKYPDl5sOjj5CJ0uCwjd7M/Pg7Iebgn79sJCQg4GUDHWT7lVrFNy+v
 eY4FRnynJHx8uqPG7MO1jPp84f7TlrqSkFKdy7S2SHKWEXCtpUHLwyJxa1Hy9YN6cV3r
 5Ghps9LUNt9zvHuIMBi0r5HqtOaPkOADaMnlcpdtiIcmdzIIHDr4Bm14BE6El6QQjbXi
 n2oTM2XGu7Za8IwAmUl0KGbsdOxB2MsCzMNtynVt/Ca1u9uNHstvCm1/lsTJ5ZmYQTdh
 qPSAgjxaeIVfZAs4+Bhv/XfMFtesFM6HuhQa5h4OcSDInV2FgfTt7A671BgrwL0MPrzX
 sozQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1717608209; x=1718213009;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=KRSONPc2DGnaPERH9Q3QmRlRviTZJDZC0RtDsaFgyb8=;
 b=tMegKUE8a9Jv6BF7OsfEidJ9gsKcUV2Y6DQl/148OCBbtKaBb3TYztIpvwhsZ9l5Qf
 c0wb6FtB7ul3YEpYdqnc9QVPI8bgYVFkPZrKEZaEHiaM4xl/MArTchIKyPCPAA+0NGNz
 T14pJRMvz3E+Ruu97xrajpjcDuDAIpIWbze/XyWRWKNdjofXBo+GARcI6DUD/CHQjMhk
 4MCH+YOdZI0PiwYQwFyUiwDUQxfxDLxaAeNuLpUxD1wvwDpHVW5eXQaFZvc+//Gp25V0
 MhatJy/U3TGPRBJCTRCCvmoyG1jEcdGMLibwP/UYOXwTpSMnkrki7veCejQqfiD5qXE8
 oDyQ==
X-Gm-Message-State: AOJu0YxrIK3moHX8F2i+f6oYB5N0mbbAU208YyebA05O1j3EvyGFxiP1
 RT2zYZFi8AyfxsKYY6XLixlmwhUcg7AXj8gZDWIQlr0ZAKlIY/KcNUqXkBhXtfN4G/Rggpx4kR1
 F
X-Google-Smtp-Source: AGHT+IFa6wt3tkWjgjjSC/yHU0+EJRvb9rlI8S0WBg+xVNOAMfu/vVF3jCmCl//1gtLQsZDR93fveA==
X-Received: by 2002:a17:90a:b013:b0:2c2:792c:b618 with SMTP id
 98e67ed59e1d1-2c27db4acb0mr3267310a91.33.1717608209448; 
 Wed, 05 Jun 2024 10:23:29 -0700 (PDT)
Received: from stoup.. ([71.212.132.216]) by smtp.gmail.com with ESMTPSA id
 98e67ed59e1d1-2c28066d511sm1720915a91.9.2024.06.05.10.23.28
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 05 Jun 2024 10:23:29 -0700 (PDT)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Cc: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
Subject: [PULL 37/38] target/sparc: Implement monitor ASIs
Date: Wed,  5 Jun 2024 10:22:52 -0700
Message-Id: <20240605172253.356302-38-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240605172253.356302-1-richard.henderson@linaro.org>
References: <20240605172253.356302-1-richard.henderson@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::1030;
 envelope-from=richard.henderson@linaro.org; helo=mail-pj1-x1030.google.com
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

Ignore the "monitor" portion and treat them the same
as their base ASIs.

Reviewed-by: Philippe Mathieu-Daudé <philmd@linaro.org>
Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
---
 target/sparc/asi.h         | 4 ++++
 target/sparc/ldst_helper.c | 4 ++++
 target/sparc/translate.c   | 8 ++++++++
 3 files changed, 16 insertions(+)

diff --git a/target/sparc/asi.h b/target/sparc/asi.h
index a66829674b..14ffaa3842 100644
--- a/target/sparc/asi.h
+++ b/target/sparc/asi.h
@@ -144,6 +144,8 @@
  * ASIs, "(4V)" designates SUN4V specific ASIs.  "(NG4)" designates SPARC-T4
  * and later ASIs.
  */
+#define ASI_MON_AIUP            0x12 /* (VIS4) Primary, user, monitor   */
+#define ASI_MON_AIUS            0x13 /* (VIS4) Secondary, user, monitor */
 #define ASI_REAL                0x14 /* Real address, cacheable          */
 #define ASI_PHYS_USE_EC		0x14 /* PADDR, E-cacheable		*/
 #define ASI_REAL_IO             0x15 /* Real address, non-cacheable      */
@@ -257,6 +259,8 @@
 #define ASI_UDBL_CONTROL_R	0x7f /* External UDB control regs rd low*/
 #define ASI_INTR_R		0x7f /* IRQ vector dispatch read	*/
 #define ASI_INTR_DATAN_R	0x7f /* (III) In irq vector data reg N	*/
+#define ASI_MON_P               0x84 /* (VIS4) Primary, monitor         */
+#define ASI_MON_S               0x85 /* (VIS4) Secondary, monitor       */
 #define ASI_PIC			0xb0 /* (NG4) PIC registers		*/
 #define ASI_PST8_P		0xc0 /* Primary, 8 8-bit, partial	*/
 #define ASI_PST8_S		0xc1 /* Secondary, 8 8-bit, partial	*/
diff --git a/target/sparc/ldst_helper.c b/target/sparc/ldst_helper.c
index 7bdf99e0c0..2d48e98bf4 100644
--- a/target/sparc/ldst_helper.c
+++ b/target/sparc/ldst_helper.c
@@ -1395,6 +1395,10 @@ uint64_t helper_ld_asi(CPUSPARCState *env, target_ulong addr,
     case ASI_TWINX_PL: /* Primary, twinx, LE */
     case ASI_TWINX_S:  /* Secondary, twinx */
     case ASI_TWINX_SL: /* Secondary, twinx, LE */
+    case ASI_MON_P:
+    case ASI_MON_S:
+    case ASI_MON_AIUP:
+    case ASI_MON_AIUS:
         /* These are always handled inline.  */
         g_assert_not_reached();
 
diff --git a/target/sparc/translate.c b/target/sparc/translate.c
index 6d0ad38fd5..113639083b 100644
--- a/target/sparc/translate.c
+++ b/target/sparc/translate.c
@@ -1607,6 +1607,7 @@ static DisasASI resolve_asi(DisasContext *dc, int asi, MemOp memop)
         case ASI_BLK_AIUP_L_4V:
         case ASI_BLK_AIUP:
         case ASI_BLK_AIUPL:
+        case ASI_MON_AIUP:
             mem_idx = MMU_USER_IDX;
             break;
         case ASI_AIUS:  /* As if user secondary */
@@ -1617,6 +1618,7 @@ static DisasASI resolve_asi(DisasContext *dc, int asi, MemOp memop)
         case ASI_BLK_AIUS_L_4V:
         case ASI_BLK_AIUS:
         case ASI_BLK_AIUSL:
+        case ASI_MON_AIUS:
             mem_idx = MMU_USER_SECONDARY_IDX;
             break;
         case ASI_S:  /* Secondary */
@@ -1630,6 +1632,7 @@ static DisasASI resolve_asi(DisasContext *dc, int asi, MemOp memop)
         case ASI_FL8_SL:
         case ASI_FL16_S:
         case ASI_FL16_SL:
+        case ASI_MON_S:
             if (mem_idx == MMU_USER_IDX) {
                 mem_idx = MMU_USER_SECONDARY_IDX;
             } else if (mem_idx == MMU_KERNEL_IDX) {
@@ -1647,6 +1650,7 @@ static DisasASI resolve_asi(DisasContext *dc, int asi, MemOp memop)
         case ASI_FL8_PL:
         case ASI_FL16_P:
         case ASI_FL16_PL:
+        case ASI_MON_P:
             break;
         }
         switch (asi) {
@@ -1664,6 +1668,10 @@ static DisasASI resolve_asi(DisasContext *dc, int asi, MemOp memop)
         case ASI_SL:
         case ASI_P:
         case ASI_PL:
+        case ASI_MON_P:
+        case ASI_MON_S:
+        case ASI_MON_AIUP:
+        case ASI_MON_AIUS:
             type = GET_ASI_DIRECT;
             break;
         case ASI_TWINX_REAL:
-- 
2.34.1


