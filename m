Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id CEC05C77B7C
	for <qemu-devel@archiver.kernel.org>; Wed,  2 Jul 2025 13:05:57 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uWwff-0007Vn-DK; Wed, 02 Jul 2025 08:34:39 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1uWwfc-0007U6-Jh
 for qemu-devel@nongnu.org; Wed, 02 Jul 2025 08:34:36 -0400
Received: from mail-oa1-x2c.google.com ([2001:4860:4864:20::2c])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1uWwfS-0000wv-7y
 for qemu-devel@nongnu.org; Wed, 02 Jul 2025 08:34:36 -0400
Received: by mail-oa1-x2c.google.com with SMTP id
 586e51a60fabf-2eaf96c7579so2845326fac.3
 for <qemu-devel@nongnu.org>; Wed, 02 Jul 2025 05:34:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1751459664; x=1752064464; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=4U0q/GIZDIM1qKxpzjtQMthSMqQD0Hh4uuMO2n3mIoY=;
 b=r9zsSJ1YhuIFVe0BeebACNg2jJT55JkVFKFcYh1flTU/vjZ5wZK5IK6GtTdHw+s2je
 W259k3IiU+hu3FofFu71OVT1ZzByi9w1Apipx9Y1VCRkBpmWZz0bWiI5NcIvpHDprbSY
 1lH8+10HijNEhU7tpp4+3YJqljrPuvk3Z17rU2lWyXYoNzShVheeWjCEz7SILwJi6wH3
 xE57h2hBM0zM3Br2klMMSze8aFMKTpaFEuXiXfIDpGwoJfVzFNjaYiDfUJ3Cv8rB5BR+
 iOWIH9gLyYwncx3IGd5TJ/x1clPIrw2+x1lVGLOPjXXNI+bO51Vg4oVX4NZyITia/XtS
 iW1A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1751459664; x=1752064464;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=4U0q/GIZDIM1qKxpzjtQMthSMqQD0Hh4uuMO2n3mIoY=;
 b=eIANIEgkDBKRpyaUL8ny9+gXNcA3HD/au7bilscEnHlQYucz54EeVM0oBFX+E19E/S
 41sfUH9qNfeEkOVvu8yc/RHuJNV7qu0sMhM3UE+67lgS+edzniUh4ejXtXJbfZMoXhgJ
 VrAm0yMkg+efyDSJzoYObMip1orb6ZQvaLUjKhwili+RZr1w+IrQrN9FFsFpCMqRadDJ
 lr8Nfe83HZog0ZT7pO3iFg6Q+BWunx/FsWJpfdp3YTXJw6nxTjwPrjzNTvn6/d1Iu+u2
 ReSf6FDQLltg+psFL2ivEvRDvtoW5v4r5xjZ9U4C/VJ37vXOXri2SSSXb5hYll0sUpy8
 I8bQ==
X-Gm-Message-State: AOJu0YycMcIsGxDS8Z6xMnINDcGIaN4FHaKjypmaGmEs11FFHx75kz0T
 QS58FXAF4hSicFgHoBo/b5Lvt0fClRi73pcNEV7XLMtXSQbtwzdwd3syF4ZseHIhptS6ayhs4qI
 GV3dZW7k=
X-Gm-Gg: ASbGnctdoPyh+ISOG4G/tEgGC7PqgH0HQuIPD+5x+TT/apeSdjcMiUpEx2CKfa/3I0d
 V7Kap/A66w0iet23xCatICTybOX7IQypoJVwuH+MJq/zs2Vp81YpdeaZATa7pHhEgjwTQ5eTOM4
 LwevYhijSrA/FKt+l0/HoIC2oDpizffM0TiTyQmOSM7g0TWHgdOoMuUkI/BJkwyV3XypHJjklKh
 2nOoj1wTim4MwVC2aGn9shx4OHyp+FpiyIPXw6sG5My/UJrb+xmGP3e2jnWMPDWxCgXlyNuw0G2
 MTgj0rY21z0vpf+gNeGasRk2xLlQoMXwYm+sjHpKH+mY5jfRItkFj+yWZiv2pSM6lfMQDA==
X-Google-Smtp-Source: AGHT+IHYDv8BX2jK3hdE1A7ld87Sc8+dNqL7xfJVFAWFf+iRalege0HpYagMuVvsgi/qd2fDPGw1Dw==
X-Received: by 2002:a05:6870:9e9b:b0:2d5:2955:aa58 with SMTP id
 586e51a60fabf-2f588624709mr1919076fac.0.1751459663909; 
 Wed, 02 Jul 2025 05:34:23 -0700 (PDT)
Received: from stoup.. ([187.210.107.185]) by smtp.gmail.com with ESMTPSA id
 586e51a60fabf-2efd50b1b2fsm3864281fac.32.2025.07.02.05.34.23
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 02 Jul 2025 05:34:23 -0700 (PDT)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Cc: qemu-arm@nongnu.org,
	peter.maydell@linaro.org
Subject: [PATCH v3 09/97] target/arm: Implement SME2 LDR/STR ZT0
Date: Wed,  2 Jul 2025 06:32:42 -0600
Message-ID: <20250702123410.761208-10-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20250702123410.761208-1-richard.henderson@linaro.org>
References: <20250702123410.761208-1-richard.henderson@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2001:4860:4864:20::2c;
 envelope-from=richard.henderson@linaro.org; helo=mail-oa1-x2c.google.com
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

Reviewed-by: Peter Maydell <peter.maydell@linaro.org>
Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
---
 target/arm/tcg/translate-sme.c | 13 +++++++++++++
 target/arm/tcg/sme.decode      |  6 ++++++
 2 files changed, 19 insertions(+)

diff --git a/target/arm/tcg/translate-sme.c b/target/arm/tcg/translate-sme.c
index 1dbd0199af..9f25273992 100644
--- a/target/arm/tcg/translate-sme.c
+++ b/target/arm/tcg/translate-sme.c
@@ -292,6 +292,19 @@ static bool do_ldst_r(DisasContext *s, arg_ldstr *a, GenLdStR *fn)
 TRANS_FEAT(LDR, aa64_sme, do_ldst_r, a, gen_sve_ldr)
 TRANS_FEAT(STR, aa64_sme, do_ldst_r, a, gen_sve_str)
 
+static bool do_ldst_zt0(DisasContext *s, arg_ldstzt0 *a, GenLdStR *fn)
+{
+    if (sme2_zt0_enabled_check(s)) {
+        fn(s, tcg_env, offsetof(CPUARMState, za_state.zt0),
+           sizeof_field(CPUARMState, za_state.zt0), a->rn, 0,
+           s->align_mem ? MO_ALIGN_16 : MO_UNALN);
+    }
+    return true;
+}
+
+TRANS_FEAT(LDR_zt0, aa64_sme2, do_ldst_zt0, a, gen_sve_ldr)
+TRANS_FEAT(STR_zt0, aa64_sme2, do_ldst_zt0, a, gen_sve_str)
+
 static bool do_adda(DisasContext *s, arg_adda *a, MemOp esz,
                     gen_helper_gvec_4 *fn)
 {
diff --git a/target/arm/tcg/sme.decode b/target/arm/tcg/sme.decode
index dd1f983941..cef49c3b29 100644
--- a/target/arm/tcg/sme.decode
+++ b/target/arm/tcg/sme.decode
@@ -55,6 +55,12 @@ LDST1           1110000 111     st:1 rm:5 v:1 .. pg:3 rn:5 0 za_imm:4  \
 LDR             1110000 100 0 000000 .. 000 ..... 0 ....        @ldstr
 STR             1110000 100 1 000000 .. 000 ..... 0 ....        @ldstr
 
+&ldstzt0        rn
+@ldstzt0        ....... ... . ...... .. ... rn:5  .....         &ldstzt0
+
+LDR_zt0         1110000 100 0 111111 00 000 ..... 00000         @ldstzt0
+STR_zt0         1110000 100 1 111111 00 000 ..... 00000         @ldstzt0
+
 ### SME Add Vector to Array
 
 &adda           zad zn pm pn
-- 
2.43.0


