Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 481D8F588C9
	for <qemu-devel@archiver.kernel.org>; Tue, 21 Apr 2026 05:19:00 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wF3Rx-0008IL-47; Tue, 21 Apr 2026 01:15:05 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1wF3RE-0007xn-Jc
 for qemu-devel@nongnu.org; Tue, 21 Apr 2026 01:14:28 -0400
Received: from mail-pl1-x62d.google.com ([2607:f8b0:4864:20::62d])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1wF3RB-0006N2-9w
 for qemu-devel@nongnu.org; Tue, 21 Apr 2026 01:14:19 -0400
Received: by mail-pl1-x62d.google.com with SMTP id
 d9443c01a7336-2b4583f0a1aso23520295ad.3
 for <qemu-devel@nongnu.org>; Mon, 20 Apr 2026 22:14:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1776748456; x=1777353256; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=CKmMywFawCK57VzKvKaE3Fm1cw6vdHmu9uE7XMxBtQ8=;
 b=Z1rAiTvyxCtLBemxG0mVrPyrEqbKi+6xF2WmT68/P0CCX8QbRpzRU8DzYcFdbvFSK1
 y9rFJsswMQycCQsxcIKXqKpN+eJofCIslZl6c/DRJhljATITukN29SRzm+o/DOZVWlUQ
 SwrKlOfHd0cJdtJBPjVb7LYM1zH91awnYuc6kKOa3XszF1il1Z6k75848Ng5ph2Ta5rW
 VcFwAMXwaJ9s+H/+2EjMCQUtyrexWGPRJzfUfA8QaZxYF0R2pHjkR5qB9mGX3m+Dzmrg
 I7FoQzoWwrYU47edLafo1nI0Gwu4OQRU0QRwAj2DCLFcTOsSMAL0Wb2/jKz9tWq5l65R
 r22w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1776748456; x=1777353256;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=CKmMywFawCK57VzKvKaE3Fm1cw6vdHmu9uE7XMxBtQ8=;
 b=NpfYJGfErhy8MA50NkB8jJksTlhODE1cIjb2r86YEMaNSN6mxBCxF+6bScNuWKoraF
 8gC16mljuRaSHjmY9mee11RErVovw8tFe5EijE2/7N7EW0oiM3c6fbSkwvgWEiisPTtd
 YzU1qCLChw0Dq2yEGuws+1n9XRKhB12KSktOYOW2FM+F3Rk4hX2gp6RufVUzF/nSTf3D
 bVvI83v3rVCSACLf+OiKW6Fad9zwfmUWwpABvUrT84/l8lgTxZ4yckErk2ELjNl/bqr6
 BTerSlJK/tSHsv63Jn0LOYTUoRNpKU9MVgPbYbHQbOZneOjt+JnROnl0lhLMU4TTFd3O
 bW6g==
X-Gm-Message-State: AOJu0YzZ3CgHp1uNIC1Nn63ETYmdJWl41/JagJkyo32/cXEslGrom22l
 WXEhyGqc5ifWCMQQ6ScJMfnr5efSkDO/EVHcy10aOA3dCwnbrNQE/kMhpcwqBROrmDegxGRek/Q
 GHE4L+qA=
X-Gm-Gg: AeBDiesWDqu/SlZ8ZsaHr523TeqIFfKTDlgkTXqfouxE4ntFMD0QWF+BwdCxyZacOfP
 9sHfqNCBZs6vlF2hQNNuYYA7O6rsYWSk38S4G7WepJ1ksN3gGpN5Lf6XDv8uVkXYWSyGg5Hoosd
 kicOc8+1rnNvyfXHNqTH/l/XFuwuxt/ruUNqA4Ys/ktZaLRGW9lfRQCvotPHdXxvomixbHwcJcI
 MIZgakcPH5y8X1eU9jCa73ao6+p5h3evtAk6WyjkKCRIAXwvdPtUxyVV4waM/skZC4F/PUIgRLV
 PvsN0icPnd0wultIQ4QJkd+poVLJxgBIoctGXngqM4IVGpzqz8affd1n7QTkIxItqlj6hZ+Anfx
 ZaiHKDsWpn43JsplYwW6NFINYJbU7+uFeeJECXbQidPOA+E4AiUPTyQRD4OFzcKGOfQ8FjBW9UH
 HcFFdHu1Ujy27/HmSMIuRrcjiVIA+720Sa6oiUDArn
X-Received: by 2002:a17:902:da89:b0:2b0:ba14:fc55 with SMTP id
 d9443c01a7336-2b5f9fa70camr183057305ad.29.1776748455649; 
 Mon, 20 Apr 2026 22:14:15 -0700 (PDT)
Received: from stoup.. ([180.233.125.15]) by smtp.gmail.com with ESMTPSA id
 d9443c01a7336-2b5fab0cddfsm174631715ad.49.2026.04.20.22.14.13
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 20 Apr 2026 22:14:15 -0700 (PDT)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Cc: qemu-arm@nongnu.org
Subject: [PATCH 10/37] target/arm: Enable EnFPM bits for FEAT_FPMR
Date: Tue, 21 Apr 2026 15:13:19 +1000
Message-ID: <20260421051346.41106-11-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260421051346.41106-1-richard.henderson@linaro.org>
References: <20260421051346.41106-1-richard.henderson@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::62d;
 envelope-from=richard.henderson@linaro.org; helo=mail-pl1-x62d.google.com
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

Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
---
 target/arm/helper.c | 9 +++++++++
 1 file changed, 9 insertions(+)

diff --git a/target/arm/helper.c b/target/arm/helper.c
index 1a0673a343..06b5fbbe55 100644
--- a/target/arm/helper.c
+++ b/target/arm/helper.c
@@ -787,6 +787,9 @@ static void scr_write(CPUARMState *env, const ARMCPRegInfo *ri, uint64_t value)
         if (cpu_isar_feature(aa64_mec, cpu)) {
             valid_mask |= SCR_MECEN;
         }
+        if (cpu_isar_feature(aa64_fpmr, cpu)) {
+            valid_mask |= SCR_ENFPM;
+        }
     } else {
         valid_mask &= ~(SCR_RW | SCR_ST);
         if (cpu_isar_feature(aa32_ras, cpu)) {
@@ -4030,6 +4033,9 @@ static void hcrx_write(CPUARMState *env, const ARMCPRegInfo *ri,
     if (cpu_isar_feature(aa64_gcs, cpu)) {
         valid_mask |= HCRX_GCSEN;
     }
+    if (cpu_isar_feature(aa64_fpmr, cpu)) {
+        valid_mask |= HCRX_ENFPM;
+    }
 
     /* Clear RES0 bits.  */
     env->cp15.hcrx_el2 = value & valid_mask;
@@ -4103,6 +4109,9 @@ uint64_t arm_hcrx_el2_eff(CPUARMState *env)
         if (cpu_isar_feature(aa64_gcs, cpu)) {
             hcrx |= HCRX_GCSEN;
         }
+        if (cpu_isar_feature(aa64_fpmr, cpu)) {
+            hcrx |= HCRX_ENFPM;
+        }
         return hcrx;
     }
     if (arm_feature(env, ARM_FEATURE_EL3) && !(env->cp15.scr_el3 & SCR_HXEN)) {
-- 
2.43.0


