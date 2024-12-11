Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id BCE95E7717D
	for <qemu-devel@archiver.kernel.org>; Wed, 11 Dec 2024 16:25:35 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tLPRs-0000CV-FT; Wed, 11 Dec 2024 11:20:28 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1tLPRr-0000Bl-Cl
 for qemu-devel@nongnu.org; Wed, 11 Dec 2024 11:20:27 -0500
Received: from mail-wm1-x330.google.com ([2a00:1450:4864:20::330])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1tLPRp-0007fn-7S
 for qemu-devel@nongnu.org; Wed, 11 Dec 2024 11:20:27 -0500
Received: by mail-wm1-x330.google.com with SMTP id
 5b1f17b1804b1-434a1fe2b43so69473975e9.2
 for <qemu-devel@nongnu.org>; Wed, 11 Dec 2024 08:20:24 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1733934024; x=1734538824; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
 :reply-to; bh=NzL75CnGj5vekrbIr9hglljRLm1m2p+xEVNazCq4Ld4=;
 b=cHL8z/LUrCRtD9qa0YyEZx75V3wFAfjqb30uAJUBG8FJCEFuMUGl+RpLUEnnksbbrI
 9vB5nq019YnsggiONu+46s4e603pyXeoM5/KBlPZMiJFhhwpHDIlYd2nhfAG5y4k6Y0h
 +yumFy2FuAeqeXDkzU4c0d+HDQeJncp/msyWIq958Nx9LIBgVFfDPEqk/+X+pciOE3OM
 n9iIwNs0een0ngQffnArU9akaTutqaxw05Q4KFVDadjggop7qhFfTThyJZvWQ4KTiZGg
 pp2yPSA8bez8JgcsnOw8b+FtqkJqwO0n+IMRoctFl4yX1761POvZG6ypd/Gy0VXvZnWl
 EcBw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1733934024; x=1734538824;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=NzL75CnGj5vekrbIr9hglljRLm1m2p+xEVNazCq4Ld4=;
 b=Vk1nWbTr2WhabZz4Be0Qn35QSE93Qbr4p63Kot/eumoCqtdJig1pxqMrToHtfeu2he
 B0W2YV9d7dRkGiiROLbH2NB/vu7zBXYcLm+Guwww3JKufR1IyTgrvPWeA5F/vfgLsm4Q
 tE6HoKvImdKgL3sNYlupZuOeqTiIXV0+Gy1FzDTrGWlB8RALgYe9O19Z1/CC+Ct5/n6U
 BSfQuGyvfW+qYM0TqGkyt1g0UaagtWQGD47qFSEkhp3/tTQZV/CDunwDU9nOthCToj7S
 8DYQMnx/KRBuD9gWJk/7YMXmqyC7vhzo7lfSsHe39BkPdNpuWtCKsKiUd2AiTbsYdYbK
 oS6Q==
X-Gm-Message-State: AOJu0YxpnYRN7I3xh54r1nkQ+P3Ag22lOMKT9qDYc+safRKYdDUuEbOZ
 1yjppmzHsvuoDpoy35v/PxbGwhCo6qr/IShefdXuqKvLGIR8wLpBPrv6QmB1LEhtxRXAqkBbqR0
 t
X-Gm-Gg: ASbGncuBm6Hg4tc/j2vTUrChNSEQMCa+3SV+lsvB3drz+PBPmaVJxPH+x2ohQSPnn0H
 vl8kuwXoZWSgmMKvCxH2P2wDdZmI5pcIprlYhd25SSISWmzFjDMzpmo7y+G8V+9mqz9IkRrDNKp
 3VsXFYtkYDiZUG8BIeZ7BpHEGH6AFMCty+3WGhkbyqgFPCDc47yUOY+DLrcUYnN4RP2aMr4EMKO
 0rj+49KBzFVa2RCyQT89ap+0j65tUVSmwO1+yLTs6ylEGv9d4DMy7Z5Q5IK
X-Google-Smtp-Source: AGHT+IHTiwk9eU+nrzUPzCgj8K0EAwb9ioBxTaxU05mzYZC5W0u8HurII+kNgURYVzbEyXD5iY8H2A==
X-Received: by 2002:a05:6000:a04:b0:386:42a6:21f2 with SMTP id
 ffacd0b85a97d-38787685148mr237671f8f.10.1733934023671; 
 Wed, 11 Dec 2024 08:20:23 -0800 (PST)
Received: from orth.archaic.org.uk (orth.archaic.org.uk. [2001:8b0:1d0::2])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-434f4dfdcdfsm121460595e9.39.2024.12.11.08.20.22
 for <qemu-devel@nongnu.org>
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 11 Dec 2024 08:20:23 -0800 (PST)
From: Peter Maydell <peter.maydell@linaro.org>
To: qemu-devel@nongnu.org
Subject: [PULL 12/72] target/ppc: Set FloatInfZeroNaNRule explicitly
Date: Wed, 11 Dec 2024 16:19:04 +0000
Message-Id: <20241211162004.2795499-13-peter.maydell@linaro.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20241211162004.2795499-1-peter.maydell@linaro.org>
References: <20241211162004.2795499-1-peter.maydell@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::330;
 envelope-from=peter.maydell@linaro.org; helo=mail-wm1-x330.google.com
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

Set the FloatInfZeroNaNRule explicitly for the PPC target,
so we can remove the ifdef from pickNaNMulAdd().

Signed-off-by: Peter Maydell <peter.maydell@linaro.org>
Reviewed-by: Richard Henderson <richard.henderson@linaro.org>
Message-id: 20241202131347.498124-8-peter.maydell@linaro.org
---
 target/ppc/cpu_init.c          | 7 +++++++
 fpu/softfloat-specialize.c.inc | 7 +------
 2 files changed, 8 insertions(+), 6 deletions(-)

diff --git a/target/ppc/cpu_init.c b/target/ppc/cpu_init.c
index efcb80d1c25..f18908a643a 100644
--- a/target/ppc/cpu_init.c
+++ b/target/ppc/cpu_init.c
@@ -7270,6 +7270,13 @@ static void ppc_cpu_reset_hold(Object *obj, ResetType type)
      */
     set_float_2nan_prop_rule(float_2nan_prop_ab, &env->fp_status);
     set_float_2nan_prop_rule(float_2nan_prop_ab, &env->vec_status);
+    /*
+     * For PPC, the (inf,zero,qnan) case sets InvalidOp, but we prefer
+     * to return an input NaN if we have one (ie c) rather than generating
+     * a default NaN
+     */
+    set_float_infzeronan_rule(float_infzeronan_dnan_never, &env->fp_status);
+    set_float_infzeronan_rule(float_infzeronan_dnan_never, &env->vec_status);
 
     for (i = 0; i < ARRAY_SIZE(env->spr_cb); i++) {
         ppc_spr_t *spr = &env->spr_cb[i];
diff --git a/fpu/softfloat-specialize.c.inc b/fpu/softfloat-specialize.c.inc
index db914ddbb1c..2023b2bd632 100644
--- a/fpu/softfloat-specialize.c.inc
+++ b/fpu/softfloat-specialize.c.inc
@@ -503,18 +503,13 @@ static int pickNaNMulAdd(FloatClass a_cls, FloatClass b_cls, FloatClass c_cls,
              */
             rule = float_infzeronan_dnan_never;
         }
-#elif defined(TARGET_PPC) || defined(TARGET_SPARC) || \
+#elif defined(TARGET_SPARC) || \
     defined(TARGET_XTENSA) || defined(TARGET_HPPA) || \
     defined(TARGET_I386) || defined(TARGET_LOONGARCH)
         /*
          * For LoongArch systems that conform to IEEE754-2008, the (inf,zero,nan)
          * case sets InvalidOp and returns the input value 'c'
          */
-        /*
-         * For PPC, the (inf,zero,qnan) case sets InvalidOp, but we prefer
-         * to return an input NaN if we have one (ie c) rather than generating
-         * a default NaN
-         */
         rule = float_infzeronan_dnan_never;
 #endif
     }
-- 
2.34.1


