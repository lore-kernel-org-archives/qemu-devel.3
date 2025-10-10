Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 49FBDCCD185
	for <qemu-devel@archiver.kernel.org>; Fri, 10 Oct 2025 13:16:09 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1v7Cpm-0006TR-Ck; Fri, 10 Oct 2025 09:06:58 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1v7Cpk-0006Ra-1A
 for qemu-devel@nongnu.org; Fri, 10 Oct 2025 09:06:57 -0400
Received: from mail-wm1-x329.google.com ([2a00:1450:4864:20::329])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1v7Cp4-0003vG-PD
 for qemu-devel@nongnu.org; Fri, 10 Oct 2025 09:06:55 -0400
Received: by mail-wm1-x329.google.com with SMTP id
 5b1f17b1804b1-46e491a5b96so11250645e9.2
 for <qemu-devel@nongnu.org>; Fri, 10 Oct 2025 06:06:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1760101567; x=1760706367; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
 :reply-to; bh=6acoF10IgwOQIq+Rlh6sImEcjn84PPUAbsidN28sb/k=;
 b=otUm29Zi/8kl9ZSYMLJYbBdDQtPoU8SaZpN5y0/iwHX1peItOJ5CS1E/tkgXrKABHp
 rFNWgmesHi+qdEt84RGg/s0KRrn+q6Gh9AFwTMHepcOXdhOkuOntBavk+VtuwlBmb/oL
 ih6qpbM4DN/nbc5+dmXfp0urooMELE1EAGKSqKZAIaYJ/TwshYJfTSeK46W69sfdfpVS
 qX6N/5jZaMeiFeMbJwiUoIhl56tikFp7S+P7tOSJViUQM7YGJ2xIO0mTy5RjMa9m4l7v
 gw7B25ydzbachxfQ4SIBVnSGPggzfJtfCv/QDdEwmEswQenbSwOWLRNYW3kQB1JH6I+d
 1rUA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1760101567; x=1760706367;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=6acoF10IgwOQIq+Rlh6sImEcjn84PPUAbsidN28sb/k=;
 b=WQ7/HwH9YmpePPLgLvB0G4whYvnAg9IiaMGrOXrk7iOtzhfTZM/L3GilIC+9HuAESq
 9zCmkB08x9pV8fxrTmsB3K9Qv603SScH/GK6zZUBOGHyFkJMLwsIW6XhzVqETJBqXsoL
 EjfglY/XFwuMDi71DmofjSo7z6CO0LtnZDoItcCKbNbetn6wY9MqTTgAce8KTBlpwNwt
 t4UOofUr3yDLgJ1kkeplVDPcAVfLqrO7snXlmhwiUdZ+LYCeoWwVAkTGQaxVLOOiu/e5
 v0qbK0QrwY/BEWcaAUq/QB80wxan6xT1a7sjsD6eriW8k17B7t/X5EqnVp+tQlA/ngTX
 0yiA==
X-Gm-Message-State: AOJu0Yxlj51LkMpldM5aSiJnphsi4uO3yOoIUF4kZG5CkfxYGjSSqRhv
 2OrB6GE3dYivpBABUQ3pIlyDuoavahOOk34nADnOtG47/EtW3DH5pgwY1tP3RyqLmuj+UsHRtkA
 clGL/
X-Gm-Gg: ASbGncsDcejDh9QR67KfsVCQmmuKnYeFbSO5tUpiP9H+7X7hVR8TjM7EONCaaSJ2D1S
 5huaguh50xc3paBvuHqqeGEoblCp0S0WsDCL8iBzBREF3kELIKO5dt/NX4vgr0glhDpZyYGhBLj
 5vgmA8UDWrhmbUaiW+TBQ5Zk/Le0ecmEAvud1h0fuDWQxcjkyQDWT0EaUcZ7wlUM5HcPrWkVdfO
 ljj9Tje61mZ6d0gyAZd7n87MuKq+KvF4YIj0MhSRZCSkWq1K080FQhL+Og9QL92PAYn6eYnVy2/
 LQ0RFin4AfUVFDGZ0RT15RzAU8+PM675tf1OUrxDQsbQvH8OSidntqh5Rwuh/o6YnUKDASAZKNV
 3TGeDXsy3sEr8HAbSLIC0vLooIFF4/281lIULuVfEUwQHMktNxxY=
X-Google-Smtp-Source: AGHT+IGUnbEU97fO2dCyMNBE1sMJKvBAQXDL+RP4tgEdc7/TZkjn0+xvfVltOcCnxoK5IwrZPDZavg==
X-Received: by 2002:a05:600c:4752:b0:46e:3dad:31ea with SMTP id
 5b1f17b1804b1-46fa9af8fb0mr84401155e9.17.1760101567149; 
 Fri, 10 Oct 2025 06:06:07 -0700 (PDT)
Received: from orth.archaic.org.uk (orth.archaic.org.uk. [2001:8b0:1d0::2])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-426ce583316sm4221657f8f.20.2025.10.10.06.06.06
 for <qemu-devel@nongnu.org>
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 10 Oct 2025 06:06:06 -0700 (PDT)
From: Peter Maydell <peter.maydell@linaro.org>
To: qemu-devel@nongnu.org
Subject: [PULL 33/76] target/arm: Implement FEAT_CHK
Date: Fri, 10 Oct 2025 14:04:44 +0100
Message-ID: <20251010130527.3921602-34-peter.maydell@linaro.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20251010130527.3921602-1-peter.maydell@linaro.org>
References: <20251010130527.3921602-1-peter.maydell@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::329;
 envelope-from=peter.maydell@linaro.org; helo=mail-wm1-x329.google.com
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

From: Richard Henderson <richard.henderson@linaro.org>

This feature contains only the CHKFEAT instruction.  It has
no ID enable, being back-allocated into the hint nop space.

Reviewed-by: Gustavo Romero <gustavo.romero@linaro.org>
Reviewed-by: Pierrick Bouvier <pierrick.bouvier@linaro.org>
Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
Message-id: 20251008215613.300150-34-richard.henderson@linaro.org
Signed-off-by: Peter Maydell <peter.maydell@linaro.org>
---
 docs/system/arm/emulation.rst  |  1 +
 target/arm/tcg/a64.decode      |  1 +
 target/arm/tcg/translate-a64.c | 14 ++++++++++++++
 3 files changed, 16 insertions(+)

diff --git a/docs/system/arm/emulation.rst b/docs/system/arm/emulation.rst
index c779a50570a..68d9a4e7342 100644
--- a/docs/system/arm/emulation.rst
+++ b/docs/system/arm/emulation.rst
@@ -28,6 +28,7 @@ the following architecture extensions:
 - FEAT_BF16 (AArch64 BFloat16 instructions)
 - FEAT_BTI (Branch Target Identification)
 - FEAT_CCIDX (Extended cache index)
+- FEAT_CHK (Check Feature Status)
 - FEAT_CMOW (Control for cache maintenance permission)
 - FEAT_CRC32 (CRC32 instructions)
 - FEAT_Crypto (Cryptographic Extension)
diff --git a/target/arm/tcg/a64.decode b/target/arm/tcg/a64.decode
index 55ff6c504f1..8283a9c83d9 100644
--- a/target/arm/tcg/a64.decode
+++ b/target/arm/tcg/a64.decode
@@ -256,6 +256,7 @@ ERETA           1101011 0100 11111 00001 m:1 11111 11111 &reta  # ERETAA, ERETAB
     AUTIASP     1101 0101 0000 0011 0010 0011 101 11111
     AUTIBZ      1101 0101 0000 0011 0010 0011 110 11111
     AUTIBSP     1101 0101 0000 0011 0010 0011 111 11111
+    CHKFEAT     1101 0101 0000 0011 0010 0101 000 11111
   ]
   # The canonical NOP has CRm == op2 == 0, but all of the space
   # that isn't specifically allocated to an instruction must NOP
diff --git a/target/arm/tcg/translate-a64.c b/target/arm/tcg/translate-a64.c
index 693eab1c012..78b2881a155 100644
--- a/target/arm/tcg/translate-a64.c
+++ b/target/arm/tcg/translate-a64.c
@@ -2124,6 +2124,20 @@ static bool trans_AUTIBSP(DisasContext *s, arg_AUTIBSP *a)
     return true;
 }
 
+static bool trans_CHKFEAT(DisasContext *s, arg_CHKFEAT *a)
+{
+    uint64_t feat_en = 0;
+
+    if (s->gcs_en) {
+        feat_en |= 1 << 0;
+    }
+    if (feat_en) {
+        TCGv_i64 x16 = cpu_reg(s, 16);
+        tcg_gen_andi_i64(x16, x16, ~feat_en);
+    }
+    return true;
+}
+
 static bool trans_CLREX(DisasContext *s, arg_CLREX *a)
 {
     tcg_gen_movi_i64(cpu_exclusive_addr, -1);
-- 
2.43.0


