Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2D5B4C19F32
	for <qemu-devel@archiver.kernel.org>; Thu, 27 Feb 2025 14:33:47 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tnerv-0006I7-Lt; Thu, 27 Feb 2025 09:28:07 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1tnerm-0005QF-1H
 for qemu-devel@nongnu.org; Thu, 27 Feb 2025 09:27:58 -0500
Received: from mail-wr1-x42e.google.com ([2a00:1450:4864:20::42e])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1tnerj-0004vE-B6
 for qemu-devel@nongnu.org; Thu, 27 Feb 2025 09:27:57 -0500
Received: by mail-wr1-x42e.google.com with SMTP id
 ffacd0b85a97d-390dd3403fdso820514f8f.0
 for <qemu-devel@nongnu.org>; Thu, 27 Feb 2025 06:27:52 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1740666471; x=1741271271; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
 :reply-to; bh=bBTqTkCG2mdnnfefXGlINhtGqt3fpl8EJ4NhuP7TlgE=;
 b=ZbdKsjwilmoZKMi29fpz2olgtlExlSzC6mm3ZkjmPUonBf2eX2WDvZ2eMqo+yjzUW2
 vVa4pEtZNQO1OEiNGW4MkNfPyVny+jZGi4fGe4KCGdC+MXgPJOMu2wkCXHMvbt+7p63x
 4xM2Zz9MSQO5cFh2ryrZC4JRxEmpiB5etktJne/1Mrt0+KOXSYTKAQkVgIUJPkXFXaLW
 1aXwA2ZDpYOk9VoV8io3bcM/f17yWwSpceNAziu34pnXEJnMBHSWiQsC5vmrNJ8nQZqK
 +zYtfroDO5CYSsjBOiyOxsiYiLU5iqshx6cc4dcZVas4TqfQ8W6BBB8nBOr/cy6LxJBf
 f0SQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1740666471; x=1741271271;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=bBTqTkCG2mdnnfefXGlINhtGqt3fpl8EJ4NhuP7TlgE=;
 b=Y+IEoOkxURk+aYUsCan8dYfpFYgEptpjrIk//z5map8pEYF+lUJhwsP47AKLsvNM3T
 6PFpK5wAl4ZWEo2c99nQZTMSXt+j5VzZiTYUptaCHm163XHNnGoIroPbJAW9/R6itINo
 sVo/22TZ1mu5GnLmxAKNRVp5hGTP39uuyl+sj2hdaXWf8C7kF2/urbW/EnxvH78ajw5w
 tayOG0aJ3ebLAXfsJvN/F+rTroCIXZSk96awUNVcTnED1K5tYwTM81QO+twNQD+11iBu
 2CVAtpdOhfiBIjJgxyM9EY7IC/gCfYXVcit3XiHOfUv/uQ42WArOI+ELLR4h4FGXfUyL
 wmBA==
X-Forwarded-Encrypted: i=1;
 AJvYcCX1wYXKIvIR1FtZTPCktwqA1gYDqv+mxVPZOHu48u22oIpy11mwLg0F+gd/umKFn7/QQgmWjmatlK94@nongnu.org
X-Gm-Message-State: AOJu0YybkF3OfsbPotVraBKy+FzQB1wYomWv+45mHlcjwDMKiZn2dzOx
 zRQPXbq/ShM5s47WF/e8SfDb+P8yQU9XlqTG6xbJBWmlEdJA7G+b9T+6xd6Bsq0=
X-Gm-Gg: ASbGnct6uKN5QAMFUnl9rTneW9T/K1vJnX672Bos22hS5vqT6rcMWX8hjsJOiV1lItj
 gZ+KdcUdSogOUZrPDqZFXge15dWoL/vrS7OaNR4GAy66W75RmjmmAqWR2O6HZg9ASz8ssUR0R3K
 2ewRuNg2u52b8+qE5XZHMNpjrAvf58pxFHF6z8y+RFAsMmR/ROHqkhA2+zJMVb/u75/Wfk725/L
 /aNHoXwFH1uQrQSQug3r16A5ih9wpzORqK4Llv033bjIZ8d7XbDaskmisSNO1HbVAjXIdvZaStZ
 qM4bEb32ZreQAhCsJamhI5bgKpus0S+G
X-Google-Smtp-Source: AGHT+IEL/EcvBY5mxvmNRof0znHQFzgKXwE+SvIJyVHPciYeDbymFxvFdPGCv3NX6OxQCn9R+ytbrg==
X-Received: by 2002:a5d:47a3:0:b0:385:fc70:7f6 with SMTP id
 ffacd0b85a97d-390d4f377eemr6243064f8f.7.1740666471076; 
 Thu, 27 Feb 2025 06:27:51 -0800 (PST)
Received: from orth.archaic.org.uk (orth.archaic.org.uk. [2001:8b0:1d0::2])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-43aba532b8dsm55968335e9.14.2025.02.27.06.27.50
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 27 Feb 2025 06:27:50 -0800 (PST)
From: Peter Maydell <peter.maydell@linaro.org>
To: qemu-arm@nongnu.org,
	qemu-devel@nongnu.org
Subject: [PATCH 3/3] target/arm: Drop unused address_offset from op_addr_{rr,
 ri}_post()
Date: Thu, 27 Feb 2025 14:27:46 +0000
Message-ID: <20250227142746.1698904-4-peter.maydell@linaro.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20250227142746.1698904-1-peter.maydell@linaro.org>
References: <20250227142746.1698904-1-peter.maydell@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::42e;
 envelope-from=peter.maydell@linaro.org; helo=mail-wr1-x42e.google.com
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

All the callers of op_addr_rr_post() and op_addr_ri_post() now pass in
zero for the address_offset, so we can remove that argument.

Signed-off-by: Peter Maydell <peter.maydell@linaro.org>
---
 target/arm/tcg/translate.c | 26 +++++++++++++-------------
 1 file changed, 13 insertions(+), 13 deletions(-)

diff --git a/target/arm/tcg/translate.c b/target/arm/tcg/translate.c
index 2020d18f019..bd3838d68e3 100644
--- a/target/arm/tcg/translate.c
+++ b/target/arm/tcg/translate.c
@@ -4941,7 +4941,7 @@ static TCGv_i32 op_addr_rr_pre(DisasContext *s, arg_ldst_rr *a)
 }
 
 static void op_addr_rr_post(DisasContext *s, arg_ldst_rr *a,
-                            TCGv_i32 addr, int address_offset)
+                            TCGv_i32 addr)
 {
     if (!a->p) {
         TCGv_i32 ofs = load_reg(s, a->rm);
@@ -4954,7 +4954,6 @@ static void op_addr_rr_post(DisasContext *s, arg_ldst_rr *a,
     } else if (!a->w) {
         return;
     }
-    tcg_gen_addi_i32(addr, addr, address_offset);
     store_reg(s, a->rn, addr);
 }
 
@@ -4974,7 +4973,7 @@ static bool op_load_rr(DisasContext *s, arg_ldst_rr *a,
      * Perform base writeback before the loaded value to
      * ensure correct behavior with overlapping index registers.
      */
-    op_addr_rr_post(s, a, addr, 0);
+    op_addr_rr_post(s, a, addr);
     store_reg_from_load(s, a->rt, tmp);
     return true;
 }
@@ -4999,7 +4998,7 @@ static bool op_store_rr(DisasContext *s, arg_ldst_rr *a,
     gen_aa32_st_i32(s, tmp, addr, mem_idx, mop);
     disas_set_da_iss(s, mop, issinfo);
 
-    op_addr_rr_post(s, a, addr, 0);
+    op_addr_rr_post(s, a, addr);
     return true;
 }
 
@@ -5053,7 +5052,7 @@ static bool trans_LDRD_rr(DisasContext *s, arg_ldst_rr *a)
     do_ldrd_load(s, addr, a->rt, a->rt + 1);
 
     /* LDRD w/ base writeback is undefined if the registers overlap.  */
-    op_addr_rr_post(s, a, addr, 0);
+    op_addr_rr_post(s, a, addr);
     return true;
 }
 
@@ -5101,7 +5100,7 @@ static bool trans_STRD_rr(DisasContext *s, arg_ldst_rr *a)
 
     do_strd_store(s, addr, a->rt, a->rt + 1);
 
-    op_addr_rr_post(s, a, addr, 0);
+    op_addr_rr_post(s, a, addr);
     return true;
 }
 
@@ -5137,13 +5136,14 @@ static TCGv_i32 op_addr_ri_pre(DisasContext *s, arg_ldst_ri *a)
 }
 
 static void op_addr_ri_post(DisasContext *s, arg_ldst_ri *a,
-                            TCGv_i32 addr, int address_offset)
+                            TCGv_i32 addr)
 {
+    int address_offset = 0;
     if (!a->p) {
         if (a->u) {
-            address_offset += a->imm;
+            address_offset = a->imm;
         } else {
-            address_offset -= a->imm;
+            address_offset = -a->imm;
         }
     } else if (!a->w) {
         return;
@@ -5168,7 +5168,7 @@ static bool op_load_ri(DisasContext *s, arg_ldst_ri *a,
      * Perform base writeback before the loaded value to
      * ensure correct behavior with overlapping index registers.
      */
-    op_addr_ri_post(s, a, addr, 0);
+    op_addr_ri_post(s, a, addr);
     store_reg_from_load(s, a->rt, tmp);
     return true;
 }
@@ -5193,7 +5193,7 @@ static bool op_store_ri(DisasContext *s, arg_ldst_ri *a,
     gen_aa32_st_i32(s, tmp, addr, mem_idx, mop);
     disas_set_da_iss(s, mop, issinfo);
 
-    op_addr_ri_post(s, a, addr, 0);
+    op_addr_ri_post(s, a, addr);
     return true;
 }
 
@@ -5206,7 +5206,7 @@ static bool op_ldrd_ri(DisasContext *s, arg_ldst_ri *a, int rt2)
     do_ldrd_load(s, addr, a->rt, rt2);
 
     /* LDRD w/ base writeback is undefined if the registers overlap.  */
-    op_addr_ri_post(s, a, addr, 0);
+    op_addr_ri_post(s, a, addr);
     return true;
 }
 
@@ -5235,7 +5235,7 @@ static bool op_strd_ri(DisasContext *s, arg_ldst_ri *a, int rt2)
 
     do_strd_store(s, addr, a->rt, rt2);
 
-    op_addr_ri_post(s, a, addr, 0);
+    op_addr_ri_post(s, a, addr);
     return true;
 }
 
-- 
2.43.0


