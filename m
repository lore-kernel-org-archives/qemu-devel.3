Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id AC245FB44A9
	for <qemu-devel@archiver.kernel.org>; Fri, 24 Apr 2026 04:31:42 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wG8C2-0006nt-Jh; Fri, 24 Apr 2026 00:31:06 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1wG8C0-0006gO-Cu
 for qemu-devel@nongnu.org; Fri, 24 Apr 2026 00:31:04 -0400
Received: from mail-oa1-x34.google.com ([2001:4860:4864:20::34])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1wG8By-0002kc-ML
 for qemu-devel@nongnu.org; Fri, 24 Apr 2026 00:31:03 -0400
Received: by mail-oa1-x34.google.com with SMTP id
 586e51a60fabf-41576c5c01cso5010358fac.3
 for <qemu-devel@nongnu.org>; Thu, 23 Apr 2026 21:31:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1777005061; x=1777609861; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=bB3Celgz6ONoUj0JAK8UxtldJtL9rndv5ruwK3rAIow=;
 b=b4WIrDA/IoUDDtOmxcnr6kZsjX0+YPIWcWjlxpD9pTX/fvlsP0uXYywF3uM4g6lR2s
 bVpVWy1PWie7CiWsmntYOyFQoRSd7tHekYVmARjLkLuTbhdcI/yIMdmXZVWkIsL/BHe7
 1ROUY6E4KakKd2E0UpCtKfdJGODa24+D3JHBapXCJl0kA96DtqR+pCI5mhkiIRiTRDtb
 3tR1PoFp7YReT9jFpO7YhaimRU5MURmKBHxyJNdqhFCQJ1pNCcPAk7cyvYMMlKbSGi6k
 ButmtpIL4jgaGX5b5qf+BhJIRDBsxIGawLqnneDmFVNaeYaKOlc8RAKYp+s/sbRuUgH8
 EFiQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1777005061; x=1777609861;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=bB3Celgz6ONoUj0JAK8UxtldJtL9rndv5ruwK3rAIow=;
 b=NRckQ7MyodatJuXuGGbR+q6aaVRD/PTylNxwR9q8vVcxvZLjCCPFXT5VOR8jRtc1IY
 BOdERZL0YrkRs99GQLykmRjxuaNefxhI/tjwkrTmK6S0Tv3WrlXstAVvFws0nUjNoZAG
 Yn5I1CtNpf4loZr0Mv7z9U8kCDlLs9XrctublcVH4FURU7I4p1g/YK3h3rAvlLFSnkwe
 cxLLIxldWTqD7xeW0OHEE1df3AYvDwVvQx3Aiwp023ZUfji3w8TtEFOlbXvbBTOsELiL
 fp8UixIZRW8PDP8i7jn3Cr42zMZGqH8Wfgt9DoESHao1kYICmB4r0HwWm5aofq+aPVG8
 O7Ng==
X-Gm-Message-State: AOJu0Yz7a6jiezPV/MH1nR2Iw3Ps4TRNKv/eTm7pYYS8uJ2Np8PFXNhk
 8WIPFOWrBCauSGyRBG4njb0BobtsQGX2a58tcE6yH828fPm9ov+hKOeH/zfdqvKBW2jaqXJLuWZ
 bpY+5XZA=
X-Gm-Gg: AeBDieuHoJKi78EwyCNcBGbrBDk4sxXn9WIm0VWgUjmqmgM+CVkUTIrakE59XyTjgGS
 wPBme/ZUuvFYGBACuoR8xFPaf5svB35/mzdsvsgcvdvh5VmOsactZCXC7eufJwqofDN2+DDjHsF
 h49qWR/WJoRzl3K6WzFAqOOqjzt0jBYxVjwIOOmhjtERPHfIv83PxAQEIy2igKcHAlitrHX2s0O
 Ksb24EhLJb0wpx8rm4l8A67OYMu3vtXpZSy2kIVvCStdBYfjnPcho9M3yMamGXHm/8d0zxI0K+y
 XVzKD8nUsZCsOfztSTFgw7xqk+L4LJD2FwglYdT+oQw8xOIMHv95ivOA+VrJ2MFu20MmG6Pk7Mh
 pgOq0DbVc3s/rlSItNL22JMi7hn8ENy14xuVOudlVkeFdXx7dbEAynSCuYG5LKH6zVHQ33XUqoh
 maHRJg+0enpmtSFhVN9vEhI0rugg4AizfOQ0UT7P01fSJHJNy2OmhhwCu+/SUU4XylY+5a/kkY
X-Received: by 2002:a05:6870:d6a4:b0:417:4888:328b with SMTP id
 586e51a60fabf-42aded08882mr18711325fac.20.1777005061437; 
 Thu, 23 Apr 2026 21:31:01 -0700 (PDT)
Received: from stoup.. ([172.58.183.19]) by smtp.gmail.com with ESMTPSA id
 586e51a60fabf-42b9ac54ec5sm18880864fac.13.2026.04.23.21.30.57
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 23 Apr 2026 21:31:01 -0700 (PDT)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Cc: qemu-arm@nongnu.org
Subject: [PATCH v2 09/40] target/arm: Update SCTLR bits for FEAT_FPMR
Date: Fri, 24 Apr 2026 14:29:43 +1000
Message-ID: <20260424043014.46305-10-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260424043014.46305-1-richard.henderson@linaro.org>
References: <20260424043014.46305-1-richard.henderson@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2001:4860:4864:20::34;
 envelope-from=richard.henderson@linaro.org; helo=mail-oa1-x34.google.com
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

Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
---
 target/arm/cpu.h | 1 +
 1 file changed, 1 insertion(+)

diff --git a/target/arm/cpu.h b/target/arm/cpu.h
index 38deea01bc..deab811ba4 100644
--- a/target/arm/cpu.h
+++ b/target/arm/cpu.h
@@ -1459,6 +1459,7 @@ void pmu_init(ARMCPU *cpu);
 #define SCTLR_DSSBS_32 (1U << 31) /* v8.5, AArch32 only */
 #define SCTLR_CMOW    (1ULL << 32) /* FEAT_CMOW */
 #define SCTLR_MSCEN   (1ULL << 33) /* FEAT_MOPS */
+#define SCTLR_EnFPM   (1ULL << 34) /* FEAT_FPMR */
 #define SCTLR_BT0     (1ULL << 35) /* v8.5-BTI */
 #define SCTLR_BT1     (1ULL << 36) /* v8.5-BTI */
 #define SCTLR_ITFSB   (1ULL << 37) /* v8.5-MemTag */
-- 
2.43.0


