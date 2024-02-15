Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4B1B1C4829E
	for <qemu-devel@archiver.kernel.org>; Thu, 15 Feb 2024 17:38:01 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rafew-0000XT-M3; Thu, 15 Feb 2024 12:36:30 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1rafeO-00082N-LT
 for qemu-devel@nongnu.org; Thu, 15 Feb 2024 12:35:56 -0500
Received: from mail-wm1-x329.google.com ([2a00:1450:4864:20::329])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1rafeI-0003zZ-Vv
 for qemu-devel@nongnu.org; Thu, 15 Feb 2024 12:35:56 -0500
Received: by mail-wm1-x329.google.com with SMTP id
 5b1f17b1804b1-411fc50e4e9so8887515e9.0
 for <qemu-devel@nongnu.org>; Thu, 15 Feb 2024 09:35:50 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1708018549; x=1708623349; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
 :reply-to; bh=a87RueZW0PDoF8ZbDKzC++JXSZcqUh/P88llxuBUZWg=;
 b=Ozuj3CX/NQEyoDK4hhAPjRQjIZFNr0I9tHnbQOYCJ7xh0x9FmUqCwR0b/ji6bn09Zv
 TuX6bZ5dQOHGwnPjX8HIxawKDV5oxQ0tgrtfeTW++bNai31x5judqVeIxOdvaJrDL1vp
 Zmuqg8fUYHFJt7c5gyR+Wwjn0J2n7qUjjel3z5iXRKoVgu68y681VJWX+I8GVkM352h6
 27CSUDcHGH913UeThciNOsU5P2D/Q2JQv0KqbGTeBlqB3E1Vnjh1p02zgATxHrNeb3J/
 ZrwPkaT2lJwaHwjKVaC1GlC9ez6SfNxqrXjG9wf8gUs1Ocr8gQcWWkftQPMpu+GWgAdr
 onSw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1708018549; x=1708623349;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=a87RueZW0PDoF8ZbDKzC++JXSZcqUh/P88llxuBUZWg=;
 b=N23GGUI8ci2qyTPW6GJdQClf9sEj/A2QkhK7gmSqTya17czGVQk6gXjOVGRBMwem2v
 tvVnmUoHeM0rxf4U/CjLuAPzWzUo+1TGdbEcLQlMugWkgRs2Qg0ydQniJ7BA+j2lcPua
 3LtX57duMzcxGn0P1ljQDZkbrT7Pha5+Klw7KNJn5j9seXIDtOKhXtU85lttS6X6lRpq
 rXMqEJAlk8SB+EbBg3RKzXgWK/ar2Y27Dc5JQ6eh2i1WsybgyLejiS8IDoS0SmXO84Gk
 jf02VJUGuuQUCQfGjmyntDUn3Rja+v8X5OGjMDF2/gFU0ovo0X+flhtSTReHLi3TokKK
 VTkQ==
X-Gm-Message-State: AOJu0Yy47C+hpP1PrOpBfAdxBiazdsTIetHOmGQiZh0pIxnpjvxa0LAS
 Gv//LfI/TPaF6x7cdumTWLP8J8JpCV3J12tTrm4WI58QFSCxEtl8jdzmbhiorx/UWCWRQ3Q3pIN
 Q
X-Google-Smtp-Source: AGHT+IGaUwTDUB1EG2Mol3h5UT+GjVEURwpApjEDKLk8AmmhymCJdr9albgVSXIJCSXak1ivLRBeXA==
X-Received: by 2002:a05:600c:198e:b0:412:adb:504b with SMTP id
 t14-20020a05600c198e00b004120adb504bmr2343067wmq.11.1708018549583; 
 Thu, 15 Feb 2024 09:35:49 -0800 (PST)
Received: from orth.archaic.org.uk (orth.archaic.org.uk. [2001:8b0:1d0::2])
 by smtp.gmail.com with ESMTPSA id
 q16-20020adfea10000000b0033cfa00e497sm2384129wrm.64.2024.02.15.09.35.49
 for <qemu-devel@nongnu.org>
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 15 Feb 2024 09:35:49 -0800 (PST)
From: Peter Maydell <peter.maydell@linaro.org>
To: qemu-devel@nongnu.org
Subject: [PULL 23/35] target/arm: Use new CBAR encoding for all v8 CPUs,
 not all aarch64 CPUs
Date: Thu, 15 Feb 2024 17:35:26 +0000
Message-Id: <20240215173538.2430599-24-peter.maydell@linaro.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240215173538.2430599-1-peter.maydell@linaro.org>
References: <20240215173538.2430599-1-peter.maydell@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::329;
 envelope-from=peter.maydell@linaro.org; helo=mail-wm1-x329.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
 T_SCC_BODY_TEXT_LINE=-0.01 autolearn=ham autolearn_force=no
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

We support two different encodings for the AArch32 IMPDEF
CBAR register -- older cores like the Cortex A9, A7, A15
have this at 4, c15, c0, 0; newer cores like the
Cortex A35, A53, A57 and A72 have it at 1 c15 c0 0.

When we implemented this we picked which encoding to
use based on whether the CPU set ARM_FEATURE_AARCH64.
However this isn't right for three cases:
 * the qemu-system-arm 'max' CPU, which is supposed to be
   a variant on a Cortex-A57; it ought to use the same
   encoding the A57 does and which the AArch64 'max'
   exposes to AArch32 guest code
 * the Cortex-R52, which is AArch32-only but has the CBAR
   at the newer encoding (and where we incorrectly are
   not yet setting ARM_FEATURE_CBAR_RO anyway)
 * any possible future support for other v8 AArch32
   only CPUs, or for supporting "boot the CPU into
   AArch32 mode" on our existing cores like the A57 etc

Make the decision of the encoding be based on whether
the CPU implements the ARM_FEATURE_V8 flag instead.

This changes the behaviour only for the qemu-system-arm
'-cpu max'. We don't expect anybody to be relying on the
old behaviour because:
 * it's not what the real hardware Cortex-A57 does
   (and that's what our ID register claims we are)
 * we don't implement the memory-mapped GICv3 support
   which is the only thing that exists at the peripheral
   base address pointed to by the register

Signed-off-by: Peter Maydell <peter.maydell@linaro.org>
Reviewed-by: Richard Henderson <richard.henderson@linaro.org>
Message-id: 20240206132931.38376-2-peter.maydell@linaro.org
---
 target/arm/helper.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/target/arm/helper.c b/target/arm/helper.c
index 7c531ee9cff..90c4fb72ce4 100644
--- a/target/arm/helper.c
+++ b/target/arm/helper.c
@@ -9528,7 +9528,7 @@ void register_cp_regs_for_features(ARMCPU *cpu)
          * AArch64 cores we might need to add a specific feature flag
          * to indicate cores with "flavour 2" CBAR.
          */
-        if (arm_feature(env, ARM_FEATURE_AARCH64)) {
+        if (arm_feature(env, ARM_FEATURE_V8)) {
             /* 32 bit view is [31:18] 0...0 [43:32]. */
             uint32_t cbar32 = (extract64(cpu->reset_cbar, 18, 14) << 18)
                 | extract64(cpu->reset_cbar, 32, 12);
-- 
2.34.1


