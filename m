Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 649BAE7717D
	for <qemu-devel@archiver.kernel.org>; Wed, 11 Dec 2024 16:26:00 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tLPSL-0000YZ-Et; Wed, 11 Dec 2024 11:20:57 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1tLPSK-0000Tm-0t
 for qemu-devel@nongnu.org; Wed, 11 Dec 2024 11:20:56 -0500
Received: from mail-wm1-x32a.google.com ([2a00:1450:4864:20::32a])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1tLPSI-0007mR-9t
 for qemu-devel@nongnu.org; Wed, 11 Dec 2024 11:20:55 -0500
Received: by mail-wm1-x32a.google.com with SMTP id
 5b1f17b1804b1-43622267b2eso1762885e9.0
 for <qemu-devel@nongnu.org>; Wed, 11 Dec 2024 08:20:53 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1733934053; x=1734538853; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
 :reply-to; bh=0hVwJ7PhWgaa1nanKp9sPo09AWgYuiJDE+Q3tkgukF8=;
 b=jTM8UaFk+YYbnx302Iyyb8Ca9z0sKEc2LNLLf11EMk716N8eJYua8FQmnomQT0pA+6
 Z5BKgz9ER3U+S9AlXJW65g+2NSls0F5D61B29n88xjJ/W2ZOJsWIdiv88joZg60daUNE
 bIHcvTFJ2wnQgzrqzKCymUZW6a/uhK2P3Dk9eaDmrQqdjwCtPHKG1ZTFfgvpHdUjvfYQ
 V11WzPoQ2TBYVB3w8VaBA224vlF4syMZgOXwmHG2gzQrfIuUgwquGbqL1GXtKDoYi46s
 HpNzC3iYlqYRt+bmhCbm423EcRpREJHYgDJsy9ZI1etjZdwttATq+cDOBVQAlW2JBoYV
 gY/w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1733934053; x=1734538853;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=0hVwJ7PhWgaa1nanKp9sPo09AWgYuiJDE+Q3tkgukF8=;
 b=X0CSRJpINUYzp0vCHXajLTYzPbO0Jqen+juGU/KcfsVoZLDvvegSQUJLcj00dqsjoh
 LQ/xFeZhekBvQ1CfdscTt85QrO+tk8c+6AylIpQt2wE+zZ1wKLS4wTpghcauWIY+OPVa
 R1+5L4ShhN6EHpWe8xvmUBH4PnET/eY2Kv4eNU9j8q+YuzNVnyzOlaBV0UCTuhD0WwiX
 FsZEzLtSoSMUEIRUFHCFq4T8P+n/0uBnPZgSKXjVQuxKZY911uyP6/7M+5WRY3se48a5
 sEbsKp90PYH3EU9FsCD5Hl97EAg9C4eNu98AWPM0sGVPApj+mqZR7sf2v3LpIzbeQ+h3
 Ds3w==
X-Gm-Message-State: AOJu0YxZMNawmbSiyGFmBaOr4Dl2T3abyhXcaNIOO3T53pAGDp2+ZKwb
 esy+4FSRlOhqcB9COuTiyzAAU3bNvNo7hqpawQCG5m9Gb/xIR+eckVlmtff2rZpr0ELyoSmcKKU
 7
X-Gm-Gg: ASbGncue4WlUabmuvyBu9b5o9+StZCW1Lz7WmPV73HeiU5iE5oS24/u/R2gtctJuktx
 XRe579GEWPFk6QcYZrDu2Lu9vDZ5fIoIiNYknmkWSPVLm97UsW0nojum9Lyl+x7QGhvwdVL3ipa
 26OR54qqWpfZXja+9SHaLT2GPH0jdIlW4vFW7QBr65Qq7eGugQYw+rizMXG++M7J91Nn8e/Tw25
 4KsxVoToDAneQLdry6uyZjUqB03+ybWsaTqbUnipq1M9STx9rk1dP9yjkAv
X-Google-Smtp-Source: AGHT+IF5CcG0bjD68FvO5pJZdYKWWSFxhbSN+FQR+p1QriUsNZQYX2UJuRDOIx5TcJyjFG1UqJZiPA==
X-Received: by 2002:a05:600c:5101:b0:434:ffb2:f9df with SMTP id
 5b1f17b1804b1-4361c3a6550mr30727475e9.17.1733934052743; 
 Wed, 11 Dec 2024 08:20:52 -0800 (PST)
Received: from orth.archaic.org.uk (orth.archaic.org.uk. [2001:8b0:1d0::2])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-434f4dfdcdfsm121460595e9.39.2024.12.11.08.20.51
 for <qemu-devel@nongnu.org>
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 11 Dec 2024 08:20:51 -0800 (PST)
From: Peter Maydell <peter.maydell@linaro.org>
To: qemu-devel@nongnu.org
Subject: [PULL 39/72] target/arm: Copy entire float_status in is_ebf
Date: Wed, 11 Dec 2024 16:19:31 +0000
Message-Id: <20241211162004.2795499-40-peter.maydell@linaro.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20241211162004.2795499-1-peter.maydell@linaro.org>
References: <20241211162004.2795499-1-peter.maydell@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::32a;
 envelope-from=peter.maydell@linaro.org; helo=mail-wm1-x32a.google.com
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

Now that float_status has a bunch of fp parameters,
it is easier to copy an existing structure than create
one from scratch.  Begin by copying the structure that
corresponds to the FPSR and make only the adjustments
required for BFloat16 semantics.

Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
Reviewed-by: Philippe Mathieu-Daudé <philmd@linaro.org>
Reviewed-by: Peter Maydell <peter.maydell@linaro.org>
Message-id: 20241203203949.483774-2-richard.henderson@linaro.org
Signed-off-by: Peter Maydell <peter.maydell@linaro.org>
---
 target/arm/tcg/vec_helper.c | 20 +++++++-------------
 1 file changed, 7 insertions(+), 13 deletions(-)

diff --git a/target/arm/tcg/vec_helper.c b/target/arm/tcg/vec_helper.c
index e825d501a22..ad6f26545ac 100644
--- a/target/arm/tcg/vec_helper.c
+++ b/target/arm/tcg/vec_helper.c
@@ -2813,25 +2813,19 @@ bool is_ebf(CPUARMState *env, float_status *statusp, float_status *oddstatusp)
      * no effect on AArch32 instructions.
      */
     bool ebf = is_a64(env) && env->vfp.fpcr & FPCR_EBF;
-    *statusp = (float_status){
-        .tininess_before_rounding = float_tininess_before_rounding,
-        .float_rounding_mode = float_round_to_odd_inf,
-        .flush_to_zero = true,
-        .flush_inputs_to_zero = true,
-        .default_nan_mode = true,
-    };
+
+    *statusp = env->vfp.fp_status;
+    set_default_nan_mode(true, statusp);
 
     if (ebf) {
-        float_status *fpst = &env->vfp.fp_status;
-        set_flush_to_zero(get_flush_to_zero(fpst), statusp);
-        set_flush_inputs_to_zero(get_flush_inputs_to_zero(fpst), statusp);
-        set_float_rounding_mode(get_float_rounding_mode(fpst), statusp);
-
         /* EBF=1 needs to do a step with round-to-odd semantics */
         *oddstatusp = *statusp;
         set_float_rounding_mode(float_round_to_odd, oddstatusp);
+    } else {
+        set_flush_to_zero(true, statusp);
+        set_flush_inputs_to_zero(true, statusp);
+        set_float_rounding_mode(float_round_to_odd_inf, statusp);
     }
-
     return ebf;
 }
 
-- 
2.34.1


