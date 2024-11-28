Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D6E5ED690F8
	for <qemu-devel@archiver.kernel.org>; Thu, 28 Nov 2024 10:48:57 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tGc0k-0003Yj-UN; Thu, 28 Nov 2024 05:44:39 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1tGbzu-0002AQ-RU
 for qemu-devel@nongnu.org; Thu, 28 Nov 2024 05:43:49 -0500
Received: from mail-wm1-x32f.google.com ([2a00:1450:4864:20::32f])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1tGbzc-0000dH-WD
 for qemu-devel@nongnu.org; Thu, 28 Nov 2024 05:43:37 -0500
Received: by mail-wm1-x32f.google.com with SMTP id
 5b1f17b1804b1-43497839b80so3819875e9.2
 for <qemu-devel@nongnu.org>; Thu, 28 Nov 2024 02:43:28 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1732790607; x=1733395407; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=bWS/GNsFs6Pu4pBOarLJaqHWrc7CmHsdY5ILX0uFeec=;
 b=qSlcYqIdLutkhsSMfs+9qzz3lUqqPcL0bxd3YAvW5EVxOJk+oGOEme538Sz1PArV8G
 aE10a27kBDZmS3pP8tLfXsjPM7rBCQMR7jdEFpiooUBYfLVXnXWDlFURrkz6LXrsts9w
 3n1vU5snljTxDxRd4UgV65x/SfZLMDJQE9iqNr0A2oJUJZ+rZddoXmHV18iaqiZOyVdG
 wUWkGQmkPIlbWqVFcALJOlBCFjSd03YalXw5Qod7Jsnz27o2wSNkFP/62Kkn4lCULRvG
 fcNtanW4haGyXUYpmiAAWoSQoBmDSOJgHRJOpUAwQb5XU8OjVlcPNgpH7PdDNflsAQaQ
 tzqw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1732790607; x=1733395407;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=bWS/GNsFs6Pu4pBOarLJaqHWrc7CmHsdY5ILX0uFeec=;
 b=pXc80NWlT0M4d8Nm06Bm0fyvWtsoNE9z124y3Xhc9UqICi+GAhLudDPod4gSr7tSe/
 vAA128S9/mhbHL9723qLcROTmyeuoGg1WjwdFSQkiHPYh8+gmDWIpjYzHK4kDAQopXsO
 rizxnjTLaHlsQdw5u3Ubp8GkFLAha0EnKBgUh4kj6zelTJ7frTFosKah+ZFn1Sk1QmPT
 PNJov+c3CQ2eEu+Z7CM0Bq3e/+7WtERXK1PiAGI37+0WhOHQIM8Sta89iiIlMkyAUBSw
 eGDO4JrYQUikLx39jPJY004WcA+sSujwpqE7otmSesywjvbZ1AUSiyAOtLFbwCEUTvYF
 Mpiw==
X-Gm-Message-State: AOJu0YzufOMQeT2RvTRk5Ot9lLIgv4SKi0zdejUsvdZu2hJ8IposHRmA
 ZNwbYK8cRwXA6DfZmleYcIk4z7YAgx7rsyfbPTsDBbFJmd0cg718hHKEYDKajdnpIiXX3cs8kXZ
 N
X-Gm-Gg: ASbGncurU+N6uy9gaiMY+jFekyBSJy5US/WILCW4TAUPJlCBfNuU3vhtcE324cEr0qr
 9u48fBVf2+bhjDvvbDA8FSVhEdBpulsisKrMEezpvktAyYz8p3kCJNTYRm+sSRU5iVX+edelyWe
 cu1MwLj4ghWfRbvVbiPK+9P7tOmWLWs9ghzgexzX6iBOpIS39bkDVssIx6VURukl66Jw9uDVuEJ
 cKmI+hS4oDd3Oa31oRN03eHV6qNG57L19JhzGmWWh5z8z38VSZRKyc=
X-Google-Smtp-Source: AGHT+IGyNWzgLyZWnKL8/dUfy9pyTYenNBT+T45tCtsyt5xK6UxFlG0jFs6wCg5GyXMMCyWimSPO1g==
X-Received: by 2002:a05:6000:1fad:b0:382:4b83:d4c0 with SMTP id
 ffacd0b85a97d-385c6eb7aacmr5799987f8f.3.1732790607241; 
 Thu, 28 Nov 2024 02:43:27 -0800 (PST)
Received: from orth.archaic.org.uk (orth.archaic.org.uk. [2001:8b0:1d0::2])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-385ccd68958sm1292959f8f.67.2024.11.28.02.43.26
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 28 Nov 2024 02:43:26 -0800 (PST)
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
Subject: [PATCH for-10.0 16/25] target/arm: Set Float3NaNPropRule explicitly
Date: Thu, 28 Nov 2024 10:43:01 +0000
Message-Id: <20241128104310.3452934-17-peter.maydell@linaro.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20241128104310.3452934-1-peter.maydell@linaro.org>
References: <20241128104310.3452934-1-peter.maydell@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::32f;
 envelope-from=peter.maydell@linaro.org; helo=mail-wm1-x32f.google.com
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

Set the Float3NaNPropRule explicitly for Arm, and remove the
ifdef from pickNaNMulAdd().

Signed-off-by: Peter Maydell <peter.maydell@linaro.org>
---
 target/arm/cpu.c               | 5 +++++
 fpu/softfloat-specialize.c.inc | 8 +-------
 2 files changed, 6 insertions(+), 7 deletions(-)

diff --git a/target/arm/cpu.c b/target/arm/cpu.c
index ead39793985..c81f6df3fca 100644
--- a/target/arm/cpu.c
+++ b/target/arm/cpu.c
@@ -173,6 +173,10 @@ void arm_register_el_change_hook(ARMCPU *cpu, ARMELChangeHookFn *hook,
  *  * tininess-before-rounding
  *  * 2-input NaN propagation prefers SNaN over QNaN, and then
  *    operand A over operand B (see FPProcessNaNs() pseudocode)
+ *  * 3-input NaN propagation prefers SNaN over QNaN, and then
+ *    operand C over A over B (see FPProcessNaNs3() pseudocode,
+ *    but note that for QEMU muladd is a * b + c, whereas for
+ *    the pseudocode function the arguments are in the order c, a, b.
  *  * 0 * Inf + NaN returns the default NaN if the input NaN is quiet,
  *    and the input NaN if it is signalling
  */
@@ -180,6 +184,7 @@ static void arm_set_default_fp_behaviours(float_status *s)
 {
     set_float_detect_tininess(float_tininess_before_rounding, s);
     set_float_2nan_prop_rule(float_2nan_prop_s_ab, s);
+    set_float_3nan_prop_rule(float_3nan_prop_s_cab, s);
     set_float_infzeronan_rule(float_infzeronan_dnan_if_qnan, s);
 }
 
diff --git a/fpu/softfloat-specialize.c.inc b/fpu/softfloat-specialize.c.inc
index d7c0c90ea65..9b5243c9529 100644
--- a/fpu/softfloat-specialize.c.inc
+++ b/fpu/softfloat-specialize.c.inc
@@ -502,13 +502,7 @@ static int pickNaNMulAdd(FloatClass a_cls, FloatClass b_cls, FloatClass c_cls,
     }
 
     if (rule == float_3nan_prop_none) {
-#if defined(TARGET_ARM)
-        /*
-         * This looks different from the ARM ARM pseudocode, because the ARM ARM
-         * puts the operands to a fused mac operation (a*b)+c in the order c,a,b
-         */
-        rule = float_3nan_prop_s_cab;
-#elif defined(TARGET_MIPS)
+#if defined(TARGET_MIPS)
         if (snan_bit_is_one(status)) {
             rule = float_3nan_prop_s_abc;
         } else {
-- 
2.34.1


