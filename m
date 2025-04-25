Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E5BB9C369D1
	for <qemu-devel@archiver.kernel.org>; Fri, 25 Apr 2025 22:29:18 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1u8RBY-0005Wx-AJ; Fri, 25 Apr 2025 18:06:16 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1u8RB1-0003ig-2N
 for qemu-devel@nongnu.org; Fri, 25 Apr 2025 18:05:44 -0400
Received: from mail-pf1-x42c.google.com ([2607:f8b0:4864:20::42c])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1u8RAz-0001tB-6x
 for qemu-devel@nongnu.org; Fri, 25 Apr 2025 18:05:42 -0400
Received: by mail-pf1-x42c.google.com with SMTP id
 d2e1a72fcca58-7369ce5d323so2262828b3a.1
 for <qemu-devel@nongnu.org>; Fri, 25 Apr 2025 15:05:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1745618740; x=1746223540; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=/ZwWSUplvMwPT8KnwYC3zLGw2kdgG0DFLwYG/Wrux7k=;
 b=Scn3Ix3jS8+6kp2i6RoTazuupvr0nb6HuYVXsA6lhOocQUHASwHp/7T91A9Rynev6p
 E9lHKtnaZy8SgNUTAzilKxgWM9AJR2fmpAQ8K0Qgol+j+042yEE+xuzlqa0jYNRemFga
 e5qyMKhmb1kB8RfanhIZa//OElF2u8Uhv2FArfYtNaM6zpP58bWOV87gjEa+s3Tq08i9
 DwoXS6clTG6EyoEW31VHluCFnivTk2EpjN1XPU/YEN7j/9iCnsXELpEEHhCnHn+LWhGR
 6I9UpYS9tcVC8M/QSRkBaFULlLjOq/bQ0xOu6RMHR3sxuscnOlPelca0c9XpLvFoWDJ+
 eQWw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1745618740; x=1746223540;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=/ZwWSUplvMwPT8KnwYC3zLGw2kdgG0DFLwYG/Wrux7k=;
 b=ZKCG1S88OZ7xXhQ8zvQsSGs9IeHJ95Xoa6U5exIWLUTC03rDEDBZ7NH/NuaqfIT6+e
 06YlT+cZ8seC1+SJ0sjLit+9FJ30017MVAhuLM95EOKkHeIzFlV0yy0EAnoToTB4SOTW
 JVjWYhPOgKkutdrBIe0Mj/SsV/uK08pYLowWaOeaui6nRBVxYwPqirAfWvxPczNFznV0
 ZmeHNrObxWOZWf7c8UiOlIb/FLi1Ijn4wMteBu1P4N8miBjEtN194c/zVbG5egjEL/eL
 uJHPdTsFKktQ5jly4rh7BITcil0HOH+slMJy1DdgHVz4KLfrbLS+B5btuuPlQlbUKBdx
 C9JA==
X-Gm-Message-State: AOJu0Yy5khWskt7ECnSDSO6sllUhCGfomcLVs01tm2mBe1FewxLvO84U
 r4xRJxkv5MVaiq9hnXcyFJsk6FDRnh+HQJqnXoZNF8VmBg5CvGUqIhTA6QxkRvDRxHewEQ1p/LN
 9
X-Gm-Gg: ASbGncuWsPcGu8LNSkncRLhtWb4FjhBKkAjSlB093Ra7cdjNeonIoVx1gruZ8mE3bnn
 H27xsINNx08IdDZkAm9wBGLsYC0MXpWjyRHjLIHJT5fCh2z7owbDC2uHy5P9+pAw5xv0os/7AtY
 zv/ed5Roc1qGFltZij3gs4icITfWMVmlQHxl7wE7MvWt6m5EHPC7u24uVptvQlZ1OReLspp35+K
 i+AsJI9Sr0Tq95EBgpobNxSTPGEWvgn1P2HVgJVJYmIjID6qcjvEf3uiR1g7ypNIObnsicwNC7v
 T1Ya64qrMbmRXsKSbxhmcmUWei/Z0jVVxRfQsJlPtyXrnND8urT7SLlB9NCBSDBdjogkinsnNpx
 8EcZisg0PyA==
X-Google-Smtp-Source: AGHT+IE6xmF9FIEtwuPYA40NynC1SU8wkfq2Oube1+jKZX/iEsHTIR333UbQKxjgWZFRI9znH6xDXA==
X-Received: by 2002:a05:6a00:b92:b0:736:450c:fa54 with SMTP id
 d2e1a72fcca58-73fd6fddccamr5155805b3a.6.1745618739856; 
 Fri, 25 Apr 2025 15:05:39 -0700 (PDT)
Received: from stoup.. (71-212-47-143.tukw.qwest.net. [71.212.47.143])
 by smtp.gmail.com with ESMTPSA id
 d2e1a72fcca58-73e25a6a49esm3796573b3a.106.2025.04.25.15.05.39
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 25 Apr 2025 15:05:39 -0700 (PDT)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Cc: Pierrick Bouvier <pierrick.bouvier@linaro.org>
Subject: [PULL 142/159] tcg/s390x: Use ADD LOGICAL WITH SIGNED IMMEDIATE
Date: Fri, 25 Apr 2025 14:54:36 -0700
Message-ID: <20250425215454.886111-143-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20250425215454.886111-1-richard.henderson@linaro.org>
References: <20250425215454.886111-1-richard.henderson@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::42c;
 envelope-from=richard.henderson@linaro.org; helo=mail-pf1-x42c.google.com
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

Reviewed-by: Pierrick Bouvier <pierrick.bouvier@linaro.org>
Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
---
 tcg/s390x/tcg-target.c.inc | 22 +++++++++++++++++++++-
 1 file changed, 21 insertions(+), 1 deletion(-)

diff --git a/tcg/s390x/tcg-target.c.inc b/tcg/s390x/tcg-target.c.inc
index 67179de848..09c7ca5b44 100644
--- a/tcg/s390x/tcg-target.c.inc
+++ b/tcg/s390x/tcg-target.c.inc
@@ -135,6 +135,9 @@ typedef enum S390Opcode {
     RIEc_CLGIJ   = 0xec7d,
     RIEc_CLIJ    = 0xec7f,
 
+    RIEd_ALHSIK  = 0xecda,
+    RIEd_ALGHSIK = 0xecdb,
+
     RIEf_RISBG   = 0xec55,
 
     RIEg_LOCGHI  = 0xec46,
@@ -682,8 +685,16 @@ static void tcg_out_insn_RI(TCGContext *s, S390Opcode op, TCGReg r1, int i2)
     tcg_out32(s, (op << 16) | (r1 << 20) | (i2 & 0xffff));
 }
 
+static void tcg_out_insn_RIEd(TCGContext *s, S390Opcode op,
+                              TCGReg r1, TCGReg r3, int i2)
+{
+    tcg_out16(s, (op & 0xff00) | (r1 << 4) | r3);
+    tcg_out16(s, i2);
+    tcg_out16(s, op & 0xff);
+}
+
 static void tcg_out_insn_RIEg(TCGContext *s, S390Opcode op, TCGReg r1,
-                             int i2, int m3)
+                              int i2, int m3)
 {
     tcg_out16(s, (op & 0xff00) | (r1 << 4) | m3);
     tcg_out32(s, (i2 << 16) | (op & 0xff));
@@ -2276,6 +2287,15 @@ static void tgen_addco_rrr(TCGContext *s, TCGType type,
 static void tgen_addco_rri(TCGContext *s, TCGType type,
                            TCGReg a0, TCGReg a1, tcg_target_long a2)
 {
+    if (a2 == (int16_t)a2) {
+        if (type == TCG_TYPE_I32) {
+            tcg_out_insn(s, RIEd, ALHSIK, a0, a1, a2);
+        } else {
+            tcg_out_insn(s, RIEd, ALGHSIK, a0, a1, a2);
+        }
+        return;
+    }
+
     tcg_out_mov(s, type, a0, a1);
     if (type == TCG_TYPE_I32) {
         tcg_out_insn(s, RIL, ALFI, a0, a2);
-- 
2.43.0


