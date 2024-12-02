Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B4C61D78322
	for <qemu-devel@archiver.kernel.org>; Mon,  2 Dec 2024 13:40:01 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tI6Uf-00029i-Mg; Mon, 02 Dec 2024 08:29:42 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1tI6Gl-0002bv-1V
 for qemu-devel@nongnu.org; Mon, 02 Dec 2024 08:15:23 -0500
Received: from mail-wm1-x332.google.com ([2a00:1450:4864:20::332])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1tI6GU-0003UD-P4
 for qemu-devel@nongnu.org; Mon, 02 Dec 2024 08:15:13 -0500
Received: by mail-wm1-x332.google.com with SMTP id
 5b1f17b1804b1-43494a20379so34266495e9.0
 for <qemu-devel@nongnu.org>; Mon, 02 Dec 2024 05:14:49 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1733145288; x=1733750088; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=vygoGC00xfYC/uInMNcn40F6CC96Rh4moS0oHLIBbXA=;
 b=ERypsltw8lLUWYHz7vw0lyBDboowStiR6nmRXWuIPpQ+8O9blOZayfrFU92SQdKhOK
 XPcqKEEZoTmggjFFPVJ9NwcdbGnnQQRf8HH6mhEiuOznoLCg5N+xHg/3Dgcwxs3TptqO
 CwS9nlGljXRNel0nBFl72DwKDYyimYLfjp9JHR6+71MD7BABz8mQTq334hmg1PAA0WF4
 UW5OAYOWPQwh5affbp+yaTFh5rkzF5bySGrSn6o9gZd/SOC6GLiPnEmBxhn/jaW9cg2n
 yE5X4vQEpZffZsZfKAMLFFcIskce6Tf+54rcZeHrQNwhlIDpg65uSosL5CoNAczbovKN
 ciKA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1733145288; x=1733750088;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=vygoGC00xfYC/uInMNcn40F6CC96Rh4moS0oHLIBbXA=;
 b=qDhwGijfpFaqLCMfl/i7spEDJEq7gQCUWG5Q+thLPakjQ3wdKdRrgs4DDPHbrpxMFb
 sNNJvPrll4CTlf7OOIIgAG+hiJNtlTii9yh70bbRk6L5RJ9VJQI8y92Ihnuq5ml/QGec
 Z7TLr5NPDcc+P6jXJeQqVW6KoLHB5oI6FK8duy9zvzhghdnr8kxzv4XTrAq1l1/xNDpE
 vFQb2SDTAEb6EhbWR8oyPgFnwdF1eqHDlbu8KinvJwefTiI3l1P4vsBuTWbzh6PwJMWq
 T5S4Kfz8a6E9H1lsxGb2/8Z6CVCtwMxsViZHCoCdxqlMDetW/dtrSdxuC8p7moUMDzdR
 Q3zQ==
X-Gm-Message-State: AOJu0Yxvr9MneN7ucOizSI0u9nnj0FGc98hPBQV/cEuQcwN0eAOKRz5E
 sgUc/6/zGx/zkBKkSsPjNpKu49PkpIM1Gejv/wATC8GJauWrLGc9BcBcbPSyXMJKwJpR6MdAcLB
 7
X-Gm-Gg: ASbGncsn9mR9iV6naG8xAoV9j1ZYuaDiMErk1CR0d1gAxLrx+MAGbdXaVT4VOHOti3n
 oyMZhJ4ipznHfTWDhjTD7PWWHv2MiwjBhGx6hxiTM4dN/a+CyFBhDOcMDDwxHELft+lryQFFcZb
 cPs8/u6CrwmTqbpQRv8VqVUNn2j0yh0WqyIbtDlOylT9czdY27VY6VyXCRB5vxiWdcMSwvaZxLt
 ndC/A/rhWgD3bEVyzPU2jRkVdK8Ca5J9ZT+xOwngfwOqYHAB1p/E5Y=
X-Google-Smtp-Source: AGHT+IHdUF2LtH6AI9ENX2DDk4Q1y9wiIXG/PfUs/1Qp2CqVtbJMKv9t9Hc11c+RWxXGdhxqR/Yb+w==
X-Received: by 2002:a05:600c:4686:b0:434:a962:2a8c with SMTP id
 5b1f17b1804b1-434a9df6af9mr189221625e9.22.1733145288636; 
 Mon, 02 Dec 2024 05:14:48 -0800 (PST)
Received: from orth.archaic.org.uk (orth.archaic.org.uk. [2001:8b0:1d0::2])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-385dea1e4ebsm10160157f8f.1.2024.12.02.05.14.47
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 02 Dec 2024 05:14:48 -0800 (PST)
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
Subject: [PATCH v2 for-10.0 43/54] target/mips: Set default NaN pattern
 explicitly
Date: Mon,  2 Dec 2024 13:13:36 +0000
Message-Id: <20241202131347.498124-44-peter.maydell@linaro.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20241202131347.498124-1-peter.maydell@linaro.org>
References: <20241202131347.498124-1-peter.maydell@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::332;
 envelope-from=peter.maydell@linaro.org; helo=mail-wm1-x332.google.com
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

Set the default NaN pattern explicitly for MIPS. Note that this
is our only target which currently changes the default NaN
at runtime (which it was previously doing indirectly when it
changed the snan_bit_is_one setting).

Signed-off-by: Peter Maydell <peter.maydell@linaro.org>
---
 target/mips/fpu_helper.h | 7 +++++++
 target/mips/msa.c        | 3 +++
 2 files changed, 10 insertions(+)

diff --git a/target/mips/fpu_helper.h b/target/mips/fpu_helper.h
index 8ca0ca7ea39..6ad1e466cfd 100644
--- a/target/mips/fpu_helper.h
+++ b/target/mips/fpu_helper.h
@@ -47,6 +47,13 @@ static inline void restore_snan_bit_mode(CPUMIPSState *env)
     set_float_infzeronan_rule(izn_rule, &env->active_fpu.fp_status);
     nan3_rule = nan2008 ? float_3nan_prop_s_cab : float_3nan_prop_s_abc;
     set_float_3nan_prop_rule(nan3_rule, &env->active_fpu.fp_status);
+    /*
+     * With nan2008, the default NaN value has the sign bit clear and the
+     * frac msb set; with the older mode, the sign bit is clear, and all
+     * frac bits except the msb are set.
+     */
+    set_float_default_nan_pattern(nan2008 ? 0b01000000 : 0b00111111,
+                                  &env->active_fpu.fp_status);
 
 }
 
diff --git a/target/mips/msa.c b/target/mips/msa.c
index 93a9a87d76d..fc77bfc7b9a 100644
--- a/target/mips/msa.c
+++ b/target/mips/msa.c
@@ -81,4 +81,7 @@ void msa_reset(CPUMIPSState *env)
     /* Inf * 0 + NaN returns the input NaN */
     set_float_infzeronan_rule(float_infzeronan_dnan_never,
                               &env->active_tc.msa_fp_status);
+    /* Default NaN: sign bit clear, frac msb set */
+    set_float_default_nan_pattern(0b01000000,
+                                  &env->active_tc.msa_fp_status);
 }
-- 
2.34.1


