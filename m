Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 30330D690F7
	for <qemu-devel@archiver.kernel.org>; Thu, 28 Nov 2024 10:47:43 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tGc2J-0005k5-7y; Thu, 28 Nov 2024 05:46:15 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1tGbzv-0002Bv-27
 for qemu-devel@nongnu.org; Thu, 28 Nov 2024 05:43:49 -0500
Received: from mail-wr1-x432.google.com ([2a00:1450:4864:20::432])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1tGbzq-0000kE-3O
 for qemu-devel@nongnu.org; Thu, 28 Nov 2024 05:43:46 -0500
Received: by mail-wr1-x432.google.com with SMTP id
 ffacd0b85a97d-37ed3bd6114so459294f8f.2
 for <qemu-devel@nongnu.org>; Thu, 28 Nov 2024 02:43:36 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1732790615; x=1733395415; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=F2oqqTya9ndnAhX2EgcTjocy//tVGNyIvLMPGaZkvBQ=;
 b=Jvat3IMy63elzVQvxQg3R/uS6uERdC4dz2oCiMLqXnVg4oATbRXxl7+prfry4GJOAs
 3rnlCwsJ8Kcc6LD/wGPvE9ucDD4AfZ03YEy3DzFbDmtsiLjYcZFKHbvBCgP6oKl3tBUA
 anKNTF5UsE24iMmFBBC9mPMUs6Nyaxk4SqnOrrsR91onr6yfVNLoV3Jl4akVLfhNz22S
 S/hx2hM+PZFfTJdGMyeJD5dHNIkvkrlIZJU5MqYas3/RcAq812vGOPJuFnJRgHIQ9MKV
 asi7Slw30+NCdUTEd7ZczaW00f+rteMKZHwRYn7ykNxcMO7XoGV5VhZbbPpQQRXrGE2Z
 ZrjQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1732790615; x=1733395415;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=F2oqqTya9ndnAhX2EgcTjocy//tVGNyIvLMPGaZkvBQ=;
 b=uZ1+hbhxoSqbgqvzg5/6lNFlasebDVi/VVGx8HLuY+E3Mcf23/xHv+fMMK88XD7lFK
 K1i/Hb9hXLcDzBlUzCnc3FZI1Vck+xZBgcYerl5PgwBXpjGu3eSuWhZm8BdPETvDpOJ0
 1/z4DfYoTyJMw/Zzdt2p2EbobDz55yamk9ePxyaCR2YS0QW6PNdXTGmj+MJyHMSVLC5Z
 BuSLqDCcK5jCHZZzClGDSUlODZBxrAFijuVX6BnW38bECYMhzgd2WncLOT2oQzQXTv+T
 hrD1KvjHH4n6bw+q2E+SAjeo/jk+cugGs0gVzrtxCHJT9xE9mkj2SNhTyFE4SKELIz6B
 KmzA==
X-Gm-Message-State: AOJu0Yz5F9qobeAEaIv1dRpV+f9feBpuxhppv5PfyVnR2tPJiUAfRH3e
 m6Tr3R9ow5yRxJS486ADaS7D2F1bLfpMUHId1mBP/DbHFFZQbq8E6qmwU2LbophKFGQtYScSVne
 e
X-Gm-Gg: ASbGncuGF0FnIFaBUuzul4QsG04XZDCeGspm8Mqezt8qbZLrWFtjGXb81bsVLKX+cVv
 7eIJGVsLzF9NpeUDRt/gxISn+yIqkG4tzur57sYUUTqWiGHJWtyeBQ3OjLdAzRb7hrW7I1Bq0sV
 KhyvCmeXKL/AFOf3YGbH2HB3wmZgVQUOdmV4ep0sUvX1lg54ynlI+qcELX9X/TdQw+5Jt4Cr3yn
 WbuYMTz1mfYCoKIt+zX2IJKSHYDyIRJtHcp8RzMDFWA9Xunh6qzxO4=
X-Google-Smtp-Source: AGHT+IEo+dfcu/Vo4YpEDMGS2gBKZqqG6BX3v7Ouawokf1TkgNmuIfcGW6fjcLGWf4H3GpgGyJk+WQ==
X-Received: by 2002:a05:6000:4708:b0:37d:4fe9:b6a4 with SMTP id
 ffacd0b85a97d-385c6edc3f2mr5257871f8f.50.1732790615204; 
 Thu, 28 Nov 2024 02:43:35 -0800 (PST)
Received: from orth.archaic.org.uk (orth.archaic.org.uk. [2001:8b0:1d0::2])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-385ccd68958sm1292959f8f.67.2024.11.28.02.43.34
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 28 Nov 2024 02:43:34 -0800 (PST)
From: Peter Maydell <peter.maydell@linaro.org>
To: qemu-devel@nongnu.org
Cc: qemu-arm@nongnu.org, qemu-ppc@nongnu.org, qemu-s390x@nongnu.org,
 =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>,
 Richard Henderson <richard.henderson@linaro.org>,
 Paolo Bonzini <pbonzini@redhat.com>, Eduardo Habkost <eduardo@habkost.net>,
 Song Gao <gaosong@loongson.cn>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Jiaxun Yang <jiaxun.yang@flygoat.com>,
 Aleksandar Rikalo <arikalo@gmail.com>, Nicholas Piggin <npiggin@gmail.com>,
 Daniel Henrique Barboza <danielhb413@gmail.com>,
 David Hildenbrand <david@redhat.com>, Ilya Leoshkevich <iii@linux.ibm.com>,
 Thomas Huth <thuth@redhat.com>,
 Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>,
 Artyom Tarasenko <atar4qemu@gmail.com>, Max Filippov <jcmvbkbc@gmail.com>
Subject: [PATCH for-10.0 22/25] target/xtensa: Set Float3NaNPropRule explicitly
Date: Thu, 28 Nov 2024 10:43:07 +0000
Message-Id: <20241128104310.3452934-23-peter.maydell@linaro.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20241128104310.3452934-1-peter.maydell@linaro.org>
References: <20241128104310.3452934-1-peter.maydell@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::432;
 envelope-from=peter.maydell@linaro.org; helo=mail-wr1-x432.google.com
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

Set the Float3NaNPropRule explicitly for xtensa, and remove the
ifdef from pickNaNMulAdd().

Signed-off-by: Peter Maydell <peter.maydell@linaro.org>
---
 target/xtensa/fpu_helper.c     | 2 ++
 fpu/softfloat-specialize.c.inc | 8 --------
 2 files changed, 2 insertions(+), 8 deletions(-)

diff --git a/target/xtensa/fpu_helper.c b/target/xtensa/fpu_helper.c
index f2d212d05df..4b1b021d824 100644
--- a/target/xtensa/fpu_helper.c
+++ b/target/xtensa/fpu_helper.c
@@ -62,6 +62,8 @@ void xtensa_use_first_nan(CPUXtensaState *env, bool use_first)
     set_use_first_nan(use_first, &env->fp_status);
     set_float_2nan_prop_rule(use_first ? float_2nan_prop_ab : float_2nan_prop_ba,
                              &env->fp_status);
+    set_float_3nan_prop_rule(use_first ? float_3nan_prop_abc : float_3nan_prop_cba,
+                             &env->fp_status);
 }
 
 void HELPER(wur_fpu2k_fcr)(CPUXtensaState *env, uint32_t v)
diff --git a/fpu/softfloat-specialize.c.inc b/fpu/softfloat-specialize.c.inc
index 2d029de7baa..60de68012e1 100644
--- a/fpu/softfloat-specialize.c.inc
+++ b/fpu/softfloat-specialize.c.inc
@@ -502,15 +502,7 @@ static int pickNaNMulAdd(FloatClass a_cls, FloatClass b_cls, FloatClass c_cls,
     }
 
     if (rule == float_3nan_prop_none) {
-#if defined(TARGET_XTENSA)
-        if (status->use_first_nan) {
-            rule = float_3nan_prop_abc;
-        } else {
-            rule = float_3nan_prop_cba;
-        }
-#else
         rule = float_3nan_prop_abc;
-#endif
     }
 
     switch (rule) {
-- 
2.34.1


