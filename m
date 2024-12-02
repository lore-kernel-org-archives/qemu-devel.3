Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 409B4D7831B
	for <qemu-devel@archiver.kernel.org>; Mon,  2 Dec 2024 13:22:01 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tI6Ku-0006zM-0L; Mon, 02 Dec 2024 08:19:40 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1tI6GE-0001xQ-Jt
 for qemu-devel@nongnu.org; Mon, 02 Dec 2024 08:14:49 -0500
Received: from mail-wm1-x331.google.com ([2a00:1450:4864:20::331])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1tI6G1-0003KO-QD
 for qemu-devel@nongnu.org; Mon, 02 Dec 2024 08:14:37 -0500
Received: by mail-wm1-x331.google.com with SMTP id
 5b1f17b1804b1-434a2f3bae4so39689385e9.3
 for <qemu-devel@nongnu.org>; Mon, 02 Dec 2024 05:14:33 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1733145272; x=1733750072; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=e3mx5QSLs3F08ZGNoyI8psAl3Pzx9Z5IpdlAACesozc=;
 b=i2lfPV4xGjJzTBX14HOMqXC3JdSmMcQPhQSyGt/3MswppJ7lzAr9JYPE3+joGDEp58
 Xr+4xKXHpyYuhB0Ic/73RfS89njqXQijf/lUsnQvA3Q+HNhPWL8wRG8FMZVngF4nk6yF
 wKXTn2/83FkbQzxnrAHmdu22E7maMshJjIh+w9vJjb00WSrCMwWXcKsSt3otb26HmML9
 Jj8z9Cq95bnO0iODWGiSieMcMOeJrF2SipkJFekiqQqgfTKbOs3zjrMm2lGxt9S6+oxb
 EsLwyhjNpAYYIDvsFqzzVdKZzk/aA8FlEGTxGSsr6+4LRSawfARp27+U1AZsHy6aF6VU
 za1w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1733145272; x=1733750072;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=e3mx5QSLs3F08ZGNoyI8psAl3Pzx9Z5IpdlAACesozc=;
 b=Qwmg22t0+FcR1N1OUdonRs2tdYEaVlCB3eLd02M6v+iCW2UbYGPfrh3W+aaZqH5Lr8
 C6OixIhd3CLSYsSOSKXu4XGKVq7Rl3Pal6P3vOuFb8tfeQEvCGJmcQQfl+SwVN4VFLmH
 2XuZeTo1Duhxk9r9y9YnP5gRZPbN13OrtjarJjxTxmTCmeFmFrx1q4u8KiGtsGzQUDyP
 DoWCN+a2J4+RGWjE2WjYIsrVm7l4jQ6vkvgweX10XB/pbcCPguUZADTFm62HKfhlbNdR
 rrPbFwAZB9aiAwbY7mco6hMR021MNHb/y77lrQ4p2j8DtgC31DRjZ4moZBPfD0mWuhof
 dAVw==
X-Gm-Message-State: AOJu0YzJsLGAx1vCfsvcDkSRWZuhw1X4xFYZoYY4ChWE+s8aV5I8btgS
 /4JROGozT5xBJ0D225o4hlkFen0iDqQqZFRkOJ3K/4xYiJXB1TcqEjw3EMNoxuWaOMKGIqYyTSH
 z
X-Gm-Gg: ASbGncsgaHaxaWBcKoouqZgxiY9dZKT0woHXKTeDqwd6hP2l2wWkGka9e41SKXr3E9n
 pNcj+yWa79wtefc9Fa/nHyuCEbUEIyl6n/EeCNBfVTtN8nJz9yvC51ze+ZywD1t0pzmqZqNusH9
 iLpP1QO0CRVPinGyjw1cu4IeAItsaibAVuT9PvxH9f2tOk1GXuTxiOawsoIoTK9DxJpboaLTHFO
 HUHXT01xluW4JB033oezKo5Pt6HBQXlY5lmgTYBnNM5y65uxsrz2X4=
X-Google-Smtp-Source: AGHT+IHo5qXo80fvKVDN2QJ+mr7r2kre4mQEoU2bb76IiltLkjwknMLbk2u95ylvKm0zOC8wXnfN/g==
X-Received: by 2002:a05:600c:154f:b0:434:a706:c0fd with SMTP id
 5b1f17b1804b1-434a9db8386mr204248585e9.2.1733145272313; 
 Mon, 02 Dec 2024 05:14:32 -0800 (PST)
Received: from orth.archaic.org.uk (orth.archaic.org.uk. [2001:8b0:1d0::2])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-385dea1e4ebsm10160157f8f.1.2024.12.02.05.14.31
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 02 Dec 2024 05:14:32 -0800 (PST)
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
Subject: [PATCH v2 for-10.0 25/54] target/hppa: Set Float3NaNPropRule
 explicitly
Date: Mon,  2 Dec 2024 13:13:18 +0000
Message-Id: <20241202131347.498124-26-peter.maydell@linaro.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20241202131347.498124-1-peter.maydell@linaro.org>
References: <20241202131347.498124-1-peter.maydell@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::331;
 envelope-from=peter.maydell@linaro.org; helo=mail-wm1-x331.google.com
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

Set the Float3NaNPropRule explicitly for HPPA, and remove the
ifdef from pickNaNMulAdd().

HPPA is the only target that was using the default branch of the
ifdef ladder (other targets either do not use muladd or set
default_nan_mode), so we can remove the ifdef fallback entirely now
(allowing the "rule not set" case to fall into the default of the
switch statement and assert).

We add a TODO note that the HPPA rule is probably wrong; this is
not a behavioural change for this refactoring.

Signed-off-by: Peter Maydell <peter.maydell@linaro.org>
Reviewed-by: Richard Henderson <richard.henderson@linaro.org>
---
 target/hppa/fpu_helper.c       | 8 ++++++++
 fpu/softfloat-specialize.c.inc | 4 ----
 2 files changed, 8 insertions(+), 4 deletions(-)

diff --git a/target/hppa/fpu_helper.c b/target/hppa/fpu_helper.c
index 393cae33bf9..69c4ce37835 100644
--- a/target/hppa/fpu_helper.c
+++ b/target/hppa/fpu_helper.c
@@ -55,6 +55,14 @@ void HELPER(loaded_fr0)(CPUHPPAState *env)
      * HPPA does note implement a CPU reset method at all...
      */
     set_float_2nan_prop_rule(float_2nan_prop_s_ab, &env->fp_status);
+    /*
+     * TODO: The HPPA architecture reference only documents its NaN
+     * propagation rule for 2-operand operations. Testing on real hardware
+     * might be necessary to confirm whether this order for muladd is correct.
+     * Not preferring the SNaN is almost certainly incorrect as it diverges
+     * from the documented rules for 2-operand operations.
+     */
+    set_float_3nan_prop_rule(float_3nan_prop_abc, &env->fp_status);
     /* For inf * 0 + NaN, return the input NaN */
     set_float_infzeronan_rule(float_infzeronan_dnan_never, &env->fp_status);
 }
diff --git a/fpu/softfloat-specialize.c.inc b/fpu/softfloat-specialize.c.inc
index 67428dab98a..5fbc953e71e 100644
--- a/fpu/softfloat-specialize.c.inc
+++ b/fpu/softfloat-specialize.c.inc
@@ -504,10 +504,6 @@ static int pickNaNMulAdd(FloatClass a_cls, FloatClass b_cls, FloatClass c_cls,
         }
     }
 
-    if (rule == float_3nan_prop_none) {
-        rule = float_3nan_prop_abc;
-    }
-
     assert(rule != float_3nan_prop_none);
     if (have_snan && (rule & R_3NAN_SNAN_MASK)) {
         /* We have at least one SNaN input and should prefer it */
-- 
2.34.1


