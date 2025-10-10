Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3E9F0CCD185
	for <qemu-devel@archiver.kernel.org>; Fri, 10 Oct 2025 13:20:04 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1v7CrK-0001Cg-C5; Fri, 10 Oct 2025 09:08:34 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1v7Cqj-0007wf-JQ
 for qemu-devel@nongnu.org; Fri, 10 Oct 2025 09:08:01 -0400
Received: from mail-wr1-x433.google.com ([2a00:1450:4864:20::433])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1v7Cpe-000431-9X
 for qemu-devel@nongnu.org; Fri, 10 Oct 2025 09:07:56 -0400
Received: by mail-wr1-x433.google.com with SMTP id
 ffacd0b85a97d-3f0308469a4so1246697f8f.0
 for <qemu-devel@nongnu.org>; Fri, 10 Oct 2025 06:06:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1760101604; x=1760706404; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
 :reply-to; bh=TF65G3i+OSdDNp3jFlEARrikEV90DADSGLPTxX7n7ks=;
 b=igpnoJaJOssqcfSKqpxCyVeXIIodIuuKrkluHkhnBXS770LUCfsB1+AgwcSvnqPMPP
 u2iDWr/+lUeIQYGT3Aqoh/pWHFOvhpCGarQLfHGRgFMvIHA0EDsvlI3pSPqdoOaZYWYc
 fkExgNxV1F/YMXvj6Ys1/TCDevjA8jzDVGnBbGcmti9xWJg/cLaoYpaiYCX+UPbSSYem
 O0oz4d9SrJ9PEYF4nTr3UrKXFdNK5HPjHl3u6kZLUKvVszjyBCVbXVAm3tAGWEYBvt0m
 GoT9VevDVwGeTb2bQYJ96gFtOSqRNga0sWDeEY2ZhjBeNfzQBwa8cO2hGkXa69e4Bdwi
 2d+Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1760101604; x=1760706404;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=TF65G3i+OSdDNp3jFlEARrikEV90DADSGLPTxX7n7ks=;
 b=edv8HdbSSCB8GJfemJTUY6sjnekVaTWVPA6VeAeTA/H9yegPhblLRQQ0s7WERdt2Cc
 53IISJL2p2QC7ttQyWYoIssLQvr5m/045UoE/4ajiDHmlHzpge3OcdxlrZP87nWmHP0F
 3BPJSsQjM7q1aZtOGjOoh7vi/Qvg9UEzZlABG2Pwamu6nIqruR6gSVz/sEvcwh1u0TYv
 B8uBT8FzV6sDg5gPyOaugFzjFsDrjW/F6rbnf5efacngr5e5G5uyj2mW6kIcQoZ3McLD
 e7Nyw0U2m9xCicW7BrTQDjTNgI34IkFSg5hZVkaU2X7HS3sgQOp2KHSVpONMwsb/sUkl
 HFGQ==
X-Gm-Message-State: AOJu0YxHmsNv+HfXlwoJTZRGLWkMKjMmFKDQgD9JJ1S0jJ0mGSMKv4dm
 Q+AcryD5HBH+81dI3nrnAJtUmQGedj7yi+ibOH9sqkWgxrGX0Zc4l6lYjIMksL1mAc2i9i3k2uc
 bgBOO
X-Gm-Gg: ASbGncsTm8VlWHFbmPjpweaxncHBAVw8JbjlEakfvwpje3Mcr0KyGfU+BlOcEn8WiYq
 cA13XLtvI1DuCCf13bbG7X8vUissnWLBSncrZTr3chz6OpWLTJrOH7Hjv1U/+iX16foBO2WVTbR
 jjT/ev10NjbfLCr+ZledFEIKU55PaiN2Fyb4812o562Wi36Ay3hwWOkhxldXk6u0oeraH6L9Vrn
 RcCFm4GA1KLfBPOwt9a9tzvkgNIKO/Yev8AfdDiNDakRj3gBoHl0RJW131dTTlgWJ8ck2NN7v2j
 cHZ8rTKEbnE42BfJYrsC2VO92EjWeoYC5K+PapC3EFb45YutbIvOJvcsF6P2mJiATsqaVdCO1bV
 hnazOfkpmOaybswmW2eKo6IpFeqV/exvVXe0JakwavSGB8wsTu38fmETJFQNe9w==
X-Google-Smtp-Source: AGHT+IHzc5C7YHNwfvFNe62ugdE5V3AYJtmbKEtslRO5AimcP0Uf+Tk7BAKaQ5fxZtHn3CyDlOpAkA==
X-Received: by 2002:a05:6000:4313:b0:3e0:c28a:abbb with SMTP id
 ffacd0b85a97d-42666ac39a2mr7035373f8f.13.1760101604014; 
 Fri, 10 Oct 2025 06:06:44 -0700 (PDT)
Received: from orth.archaic.org.uk (orth.archaic.org.uk. [2001:8b0:1d0::2])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-426ce583316sm4221657f8f.20.2025.10.10.06.06.43
 for <qemu-devel@nongnu.org>
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 10 Oct 2025 06:06:43 -0700 (PDT)
From: Peter Maydell <peter.maydell@linaro.org>
To: qemu-devel@nongnu.org
Subject: [PULL 67/76] target/arm: Enable GCSPR_EL0 for read in user-mode
Date: Fri, 10 Oct 2025 14:05:18 +0100
Message-ID: <20251010130527.3921602-68-peter.maydell@linaro.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20251010130527.3921602-1-peter.maydell@linaro.org>
References: <20251010130527.3921602-1-peter.maydell@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::433;
 envelope-from=peter.maydell@linaro.org; helo=mail-wr1-x433.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 T_SPF_TEMPERROR=0.01 autolearn=ham autolearn_force=no
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

Reviewed-by: Pierrick Bouvier <pierrick.bouvier@linaro.org>
Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
Message-id: 20251008215613.300150-68-richard.henderson@linaro.org
Signed-off-by: Peter Maydell <peter.maydell@linaro.org>
---
 target/arm/cpu.c | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/target/arm/cpu.c b/target/arm/cpu.c
index cbb00c3db33..11e7c10cef5 100644
--- a/target/arm/cpu.c
+++ b/target/arm/cpu.c
@@ -311,6 +311,10 @@ static void arm_cpu_reset_hold(Object *obj, ResetType type)
         env->cp15.mdscr_el1 |= 1 << 12;
         /* Enable FEAT_MOPS */
         env->cp15.sctlr_el[1] |= SCTLR_MSCEN;
+        /* For Linux, GCSPR_EL0 is always readable. */
+        if (cpu_isar_feature(aa64_gcs, cpu)) {
+            env->cp15.gcscr_el[0] = GCSCRE0_NTR;
+        }
 #else
         /* Reset into the highest available EL */
         if (arm_feature(env, ARM_FEATURE_EL3)) {
-- 
2.43.0


