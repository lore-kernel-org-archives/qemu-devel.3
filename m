Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9808D10FCAC9
	for <qemu-devel@archiver.kernel.org>; Wed,  1 Apr 2026 19:23:28 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1w8186-0006gY-98; Wed, 01 Apr 2026 15:21:30 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@linaro.org>)
 id 1w8182-0006aL-RM
 for qemu-devel@nongnu.org; Wed, 01 Apr 2026 15:21:26 -0400
Received: from mail-pj1-x1032.google.com ([2607:f8b0:4864:20::1032])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@linaro.org>)
 id 1w8181-00033P-44
 for qemu-devel@nongnu.org; Wed, 01 Apr 2026 15:21:26 -0400
Received: by mail-pj1-x1032.google.com with SMTP id
 98e67ed59e1d1-35c238f1063so41618a91.1
 for <qemu-devel@nongnu.org>; Wed, 01 Apr 2026 12:21:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1775071283; x=1775676083; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=jvjSLIEXvBvChupp9bEDs+PcKLfymPb67QO+8GQ5aqk=;
 b=rQ1SpfE0FcSq+A7Swm9SUJcA1eLx4yTQdyplG0sSGV7Ap2YdiZZcCyquDXzqyynMBR
 MonOLgwzAQ9Egj9t+Uc9RWzzWcuEQFHQXIxS3PfA4XXNG3ahhiZlAI6m1ER80pfi+hPX
 kssNg3rFqpAWdiOcEisyf4sdML63/WlsqMLzcJuSqJuJj6OtZ6yzJKC1C+4wlJNKEIWv
 0IqrgdFtl3o89Z00g2M4jGgr+2TDSdOCmCqOJIAh6Vs6zGNzf0aVcy3caEKDsEGTOMFX
 yoxQydl6893iNhJOTQ+U+zXcCVOQ4LM4ElwBg/XDM81lsDz4hh1FtLUuq/1WvzFGNS+w
 ToYA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1775071283; x=1775676083;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=jvjSLIEXvBvChupp9bEDs+PcKLfymPb67QO+8GQ5aqk=;
 b=Us+3XiHgVZFMxJNR/sh7p+mL3EFmf7tv6cfyI4JkrXE/wR4vO5sp99r2u9zEANxDL2
 5XX01M/+beYb7qe+KUCm5gAQnbfPaHPtimHv7IrYOMKB0jhaXlnHmECFfSMZVWrxQ5rc
 6thPz9otL218bZRVtaDAcziuBElEIGF5OACuUpDJhUXK4UM5/jE8rDcWR+cS9aVeaAZk
 GIb5hDw5Y9p7os3JSaDKh8XW2BH34RhekV57D/IUGOXBHS/ww5O4ybEo/hHciJGm0BYu
 e4Mnp1Spll3cM5EjJcgiGpBVY8fv9p4ikIvS3Qto3BRiXzTMn44F69Nel8DbV5I7nvoz
 bb+A==
X-Gm-Message-State: AOJu0Yz17/oKnygjj980RoCsFg/nEAE8BqDUWMBZ6vxOyg3la14z6Fo2
 fgBp8JguGtNEOq5CM+THcEkY+q0uWaoxwyII/kwNDivUoazcuRkNl9YODsGI+3zBljsWQxqOxvC
 +SlZLyqAwXw==
X-Gm-Gg: ATEYQzz1q+qEJ6cZimSjU98MewKj4/pwQp4B7t/YMWiwtFymj6M96e19w8kYhnvZrYf
 qsH5xOZEZXApk6+4yr7Q48t8aV/HcPR91wXewIg4shiUIA2PPgR5p9O1Cl8d5Ze7/Z5L1yT5EAh
 Z6W3SKaQxOlyqOW2zOmJUbclbfc+KWeqwJob1BMiGDGfjPmWDH5AQOSifzOIb+H2d3BRsnvPK/v
 5wWRKBFDaSltMTwEEPyFrzMuhlVT23freomWaMrHPEMTcMrMyiUfqJ8OZKsGo1ve53hHGI5DCCf
 La61y9u/Nj89rNnB84MpFOM6w8fhW9lnVggSNxinomt8BwCTivUTaKttw6RALZFRRwhvoraXn1r
 QM+MOAZhjzvu2anY05REduHSjn3RhCUz1Se10jKjJxGqzQFXHXkrp+0UowzO5YCqpYMJOv7WJwF
 NxpM71d3IFMp8O67H6Er36fYDXBQPzqNL1GHfUqttYyhtkNcXpojZ0LwO1+Jt2V5tvUofLxW5bJ
 oSO3dZsZvExgtU=
X-Received: by 2002:a17:90b:3d4f:b0:35b:9958:4edd with SMTP id
 98e67ed59e1d1-35dc7039e84mr4323267a91.30.1775071282737; 
 Wed, 01 Apr 2026 12:21:22 -0700 (PDT)
Received: from pc.taild8403c.ts.net (216-71-219-44.dyn.novuscom.net.
 [216.71.219.44]) by smtp.gmail.com with ESMTPSA id
 98e67ed59e1d1-35dbe41b11fsm5633113a91.0.2026.04.01.12.21.22
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 01 Apr 2026 12:21:22 -0700 (PDT)
From: Pierrick Bouvier <pierrick.bouvier@linaro.org>
To: qemu-devel@nongnu.org
Cc: Peter Maydell <peter.maydell@linaro.org>, qemu-arm@nongnu.org,
 jim.macarthur@linaro.org, Richard Henderson <richard.henderson@linaro.org>,
 philmd@linaro.org, Paolo Bonzini <pbonzini@redhat.com>,
 Pierrick Bouvier <pierrick.bouvier@linaro.org>
Subject: [PATCH v6 12/12] target/arm/tcg/translate.c: replace target_ulong
 with uint32_t
Date: Wed,  1 Apr 2026 12:20:57 -0700
Message-ID: <20260401192057.1182724-13-pierrick.bouvier@linaro.org>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <20260401192057.1182724-1-pierrick.bouvier@linaro.org>
References: <20260401192057.1182724-1-pierrick.bouvier@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::1032;
 envelope-from=pierrick.bouvier@linaro.org; helo=mail-pj1-x1032.google.com
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

Reviewed-by: Richard Henderson <richard.henderson@linaro.org>
Reviewed-by: Philippe Mathieu-Daudé <philmd@linaro.org>
Signed-off-by: Pierrick Bouvier <pierrick.bouvier@linaro.org>
---
 target/arm/tcg/translate.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/target/arm/tcg/translate.c b/target/arm/tcg/translate.c
index 4546bbeeeff..204f9657993 100644
--- a/target/arm/tcg/translate.c
+++ b/target/arm/tcg/translate.c
@@ -6450,7 +6450,7 @@ static void arm_tr_insn_start(DisasContextBase *dcbase, CPUState *cpu)
      * fields here.
      */
     uint32_t condexec_bits;
-    target_ulong pc_arg = dc->base.pc_next;
+    uint32_t pc_arg = dc->base.pc_next;
 
     if (tb_cflags(dcbase->tb) & CF_PCREL) {
         pc_arg &= ~TARGET_PAGE_MASK;
@@ -6612,7 +6612,7 @@ static void thumb_tr_translate_insn(DisasContextBase *dcbase, CPUState *cpu)
     bool is_16bit;
     /* TCG op to rewind to if this turns out to be an invalid ECI state */
     TCGOp *insn_eci_rewind = NULL;
-    target_ulong insn_eci_pc_save = -1;
+    uint32_t insn_eci_pc_save = -1;
 
     /* Misaligned thumb PC is architecturally impossible. */
     assert((dc->base.pc_next & 1) == 0);
-- 
2.47.3


