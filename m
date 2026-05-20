Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 56E36CD4F3D
	for <qemu-devel@archiver.kernel.org>; Wed, 20 May 2026 18:34:59 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wPlZK-0007l0-4T; Wed, 20 May 2026 14:22:58 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1wPlZ9-0007L2-AN
 for qemu-devel@nongnu.org; Wed, 20 May 2026 14:22:47 -0400
Received: from mail-pj1-x1032.google.com ([2607:f8b0:4864:20::1032])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1wPlYt-0000a4-Qe
 for qemu-devel@nongnu.org; Wed, 20 May 2026 14:22:46 -0400
Received: by mail-pj1-x1032.google.com with SMTP id
 98e67ed59e1d1-3697c35eab7so2991009a91.0
 for <qemu-devel@nongnu.org>; Wed, 20 May 2026 11:22:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1779301350; x=1779906150; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=VvhMkH32psM3D8lph3Pv20uEhqe8qrK6g7LCI4lgg/I=;
 b=fnxSPWu1T2vIv6FJYKjASW2fNwKG/bg6Utdo2y2BaA//bAkh1kQyPucE0ZfgwmSaA5
 lTa7v40Ei6qE91Ra5ssmSj/5iQ3zXYWBuoJmQPCBX516MAFeinR4iinhbk0CM+JsAc9Z
 kaEaAT0CCu9Ztp0vhMXCB4ZPOMPc2Jb/Cjj/0n7UaTAypTCbeEj7RGRFeZDfSOKAJ0zC
 40biqPQouH4odBi2Iq52DNKb3k3UiJ8jIOC+OGwl09Fit9MxPIz+C/J/DmYAfQ0r5E59
 nBpROYV4awbDrgKRUKp9ozfZbKue54TuRDt0KBIbJircZ1ELlqQ8U4+S8ua66TV71eJu
 fbdw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1779301350; x=1779906150;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=VvhMkH32psM3D8lph3Pv20uEhqe8qrK6g7LCI4lgg/I=;
 b=cFhKzOfuD5tCUU2wvkeajV32hoAJhRo+6LzqLAFryq8Ui0tDaR7b6UYwYSqCkuTBCU
 nP1tYsUGXFi0Tlz8VgqmVTQXUXRDUgtsSu5Z5OllxbeguADI7XDNo0mU/YgpocxbCSCt
 BppXc0mRlY/upB6Q+MSzYrMp4CVSLYUNo2qviOLjYOu32IR1c66uqAmtLS9KounSwGV7
 4EUfyCT7WuY+EK74pMmIfPPqikOq6IQJ4hUqQst4PfKzYWrvnwx4iQY3Yyl6mzJpa9hO
 CazvB+2fTSZFpUuuovx4RpTFeCqGi6tiPB8kTktOrpSc58EvQJPzZRCeEqCmRSGv9o+f
 /xVg==
X-Gm-Message-State: AOJu0Yw5HONNV7vSod53QyiPNrlzbEvrg2XS1YqMe7ZHSFnDmie6X+t3
 PTYL622ucrKQqIfx8DubvHK5Dk/mMYjacNSiFLmhqfymC1BHzC6Fddweg0QXtq27uctxaSKCU44
 ZNNpD268=
X-Gm-Gg: Acq92OE9LOFjENfZipf1rjWCu/BmbkQl9u+u5TGW83FwLAe9kIQTy2H3AQDwpULdiab
 v9qBaD/OqBoBpVeGIKuJ+VVRvrtIZb2aqZjhrbRtdtdMStVRBUkLOpzqy+fIDMQphmM4oJWysBt
 OWSAmnNvSQaOrLX2XMdk6PfZJBwvt2gszLvmAUEmJAnh4iZ6svv6DqdYKwJWnNIOqOB0hnz1hpe
 xcSK86Zd3Z/o00QSDSIo9aQ1j374kqlGuhl/7oobwtH0AcUPzanFkJSF2ZRR06F5mJk6dYraH+c
 S9op9x+DOwGhE+BZffzk8YVvNUxnlZqYUr9liIKx2eWFYZJIW1T1d1SinMDiBQ1TUg5rKCfL4lY
 v1YZ+yiiFvhgE4R8YznuK3JejQC5pKIa4Z13LN0qXOyVlo5sxrkocVSBFF83vcM5f8povwAgTFR
 za71hdD2LXlC5APYWf0hM35TpVHTL8lmdlw7Ng3bNhMRv7k6ONzQ==
X-Received: by 2002:a17:90b:1344:b0:366:4f8a:9847 with SMTP id
 98e67ed59e1d1-36951b711dcmr24214420a91.17.1779301349815; 
 Wed, 20 May 2026 11:22:29 -0700 (PDT)
Received: from stoup.. ([71.212.142.33]) by smtp.gmail.com with ESMTPSA id
 98e67ed59e1d1-36a3d210b4esm274764a91.17.2026.05.20.11.22.29
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 20 May 2026 11:22:29 -0700 (PDT)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Cc: qemu-arm@nongnu.org,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
Subject: [PATCH v6 22/64] target/arm: Move vectors_overlap to vec_internal.h
Date: Wed, 20 May 2026 11:21:31 -0700
Message-ID: <20260520182213.872945-23-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260520182213.872945-1-richard.henderson@linaro.org>
References: <20260520182213.872945-1-richard.henderson@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::1032;
 envelope-from=richard.henderson@linaro.org; helo=mail-pj1-x1032.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=unavailable autolearn_force=no
X-Spam_action: no action
X-BeenThere: qemu-devel@nongnu.org
X-Mailman-Version: 2.1.29
Precedence: list
List-Id: qemu development <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <https://lists.nongnu.org/archive/html/qemu-devel>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=subscribe>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org

We will shortly need this outside of sme_helper.c.

Reviewed-by: Philippe Mathieu-Daudé <philmd@linaro.org>
Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
---
 target/arm/tcg/vec_internal.h | 8 ++++++++
 target/arm/tcg/sme_helper.c   | 6 ------
 2 files changed, 8 insertions(+), 6 deletions(-)

diff --git a/target/arm/tcg/vec_internal.h b/target/arm/tcg/vec_internal.h
index b647399b18..dbc098d49a 100644
--- a/target/arm/tcg/vec_internal.h
+++ b/target/arm/tcg/vec_internal.h
@@ -21,6 +21,7 @@
 #define TARGET_ARM_VEC_INTERNAL_H
 
 #include "fpu/softfloat.h"
+#include "vector-type.h"
 
 typedef struct CPUArchState CPUARMState;
 
@@ -461,6 +462,13 @@ static inline void depositn(uint64_t *p, unsigned pos,
     }
 }
 
+/* Determine if [x, x+nx) overlaps [y, y+ny). */
+static inline bool vectors_overlap(ARMVectorReg *x, unsigned nx,
+                                   ARMVectorReg *y, unsigned ny)
+{
+    return !(x + nx <= y || y + ny <= x);
+}
+
 #define DO_3OP(NAME, FUNC, TYPE) \
 void HELPER(NAME)(void *vd, void *vn, void *vm,                            \
                   float_status * stat, uint32_t desc)                      \
diff --git a/target/arm/tcg/sme_helper.c b/target/arm/tcg/sme_helper.c
index ab5999c592..0055e97a2b 100644
--- a/target/arm/tcg/sme_helper.c
+++ b/target/arm/tcg/sme_helper.c
@@ -33,12 +33,6 @@
 #define HELPER_H "tcg/helper-sme-defs.h"
 #include "exec/helper-info.c.inc"
 
-static bool vectors_overlap(ARMVectorReg *x, unsigned nx,
-                            ARMVectorReg *y, unsigned ny)
-{
-    return !(x + nx <= y || y + ny <= x);
-}
-
 void helper_set_svcr(CPUARMState *env, uint32_t val, uint32_t mask)
 {
     aarch64_set_svcr(env, val, mask);
-- 
2.43.0


