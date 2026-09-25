Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 67922C9832A
	for <qemu-devel@archiver.kernel.org>; Fri, 25 Sep 2026 21:52:05 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xADot-0008E0-KC; Fri, 25 Sep 2026 17:51:03 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1xADoI-0007mv-6T
 for qemu-devel@nongnu.org; Fri, 25 Sep 2026 17:50:27 -0400
Received: from mail-pf1-x42f.google.com ([2607:f8b0:4864:20::42f])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1xADoF-0007oe-Ef
 for qemu-devel@nongnu.org; Fri, 25 Sep 2026 17:50:25 -0400
Received: by mail-pf1-x42f.google.com with SMTP id
 d2e1a72fcca58-880cb967dffso409519b3a.1
 for <qemu-devel@nongnu.org>; Fri, 25 Sep 2026 14:50:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1790373021; x=1790977821; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=C+cdoJ81YNEf4q3G5tKQRS1Ej9pjuy+FmmxI+jro6EY=;
 b=DQJ5kP0sgpe5doq+b6dM8qf79zLntWEkHMB6VEIMjfFmQaZ+n2ImtpBWpV0r+4mT+E
 azXB/ZTRQKJ1EFKgeJtd+VGUgHUOF/qKiejNv6Srqp3L7AbHHSUWkkYVZ0aCy4Qx/AGC
 hRHGbhfkdlQP8RtuH7inY7T8nSzLF5Ppe+0VweDhjtm+YUZ2CcokV8LzFAtAAdPK8YTI
 4XElKpSFYN8615RcwMKXaWbhIRbFmB2hfpYo0rfbOUHAl+eElqDdarX8MESHycgTYUOQ
 /r6jAC5FXKjnUQb/2Hqfqmp3/rnqPNa4tgDgLWcM7dFPR+UipsX7A91yTMTom0pKUb+b
 Wc2A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1790373021; x=1790977821;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to:content-type;
 bh=C+cdoJ81YNEf4q3G5tKQRS1Ej9pjuy+FmmxI+jro6EY=;
 b=rOpefurs90w3K1RcRNSt2LGb+SNmo8iv9Cg9ngSUJjQdjZp3em98djMeQsPR2mV21B
 HjVh7T4TBpyEkBt5Q4+nZOdotFadqT47kUw7g7rs7KpUpwO3Uvn9NOb97YY1tS9gMxIa
 06oW6Vgqh2xsl/pObXtrw2eX1IGJVj6bV3tT9Sf7uwC8XQDQUJ383myGPBGEVf5Wq8Cx
 Eb941yFRX6jgU64berOU/edaP1K6ut4pSUeSSowATbt0gq8T0TryxQcXbGXuQUAw3Vjg
 uAjnh10CyLKP80qQriyeflOpevoh1stOylK+qAXWeigicAtl+PX4mLEc/wQE3PtcKWoc
 6yZw==
X-Gm-Message-State: AFuF++mwQT2jevljIAY9QMs9xAANx/5ReEaAaJDAr4Ect4HYV9H6vEkb
 lRHWaO132T5DOte0F3yM3V6TczZbKLYAIFkdnhN6c7Fn4qkybfBHKmIAGDGBrS5lZJeZAtdRYUs
 V4Pbb
X-Gm-Gg: AYBFou1DtN3+7d+wTei9GBkutvna7pQjDMXJWb32bLIs5YgA2+L+JTfCyjIXbLf8eh5
 rFYQ/mLKUsZrYCOxIEWKuAoloXMOGGWXCvmfW1nn024fjU6kQqFI2v9Co12jHJkg2ti/C5RfiaY
 rdyyH2XFUcFlJYyB4Tnhu7J3W/O4P2JDFBFI3OOK3LWUxMUrO+tYAg5A5p32yo/6An0z2ouOitX
 55HTbEk0zv/UoSdZtS/Y0qg0J+1Slq52GeAR0UddoXvo/EwDjf/dgafwiTB+pcowaTVE8g7JnyV
 srA4ZgVsV5alqUtDstCfVFUv0QZjBHsvo42e3vIiMdhnWkS5/oT5uN61S5NDzf1tavxEndyyT9Q
 d6GrXBwqKxZLOPCyCLaWKIYK21W99LkJ27eXrtJwb+UFKMpBs20WVsSnILLDyU325H7oQ2O3Qd8
 5maZt7XQ/rPwKIVx8uxWwexVM4d+vZD0KFvQMh1TkVMgKAU8KqIWfminIvrmGJerfzLpDUqPWsj
 ekNp6kji76mz+k7iRqvvW5njHmCGWyRpqCGR6tT
X-Received: by 2002:a05:6a00:2e91:b0:881:236b:748e with SMTP id
 d2e1a72fcca58-881236b753bmr551959b3a.0.1790373020951; 
 Fri, 25 Sep 2026 14:50:20 -0700 (PDT)
Received: from stoup (174-21-68-150.tukw.qwest.net. [174.21.68.150])
 by smtp.gmail.com with ESMTPSA id
 d2e1a72fcca58-87fea1940ecsm1725256b3a.13.2026.09.25.14.50.19
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 25 Sep 2026 14:50:20 -0700 (PDT)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Cc: qemu-arm@nongnu.org,
	Peter Maydell <peter.maydell@linaro.org>
Subject: [PATCH v2 14/14] target/arm: Enable FEAT_UINJ for -cpu max-v9
Date: Fri, 25 Sep 2026 14:50:04 -0700
Message-ID: <20260925215004.456336-15-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260925215004.456336-1-richard.henderson@linaro.org>
References: <20260925215004.456336-1-richard.henderson@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::42f;
 envelope-from=richard.henderson@linaro.org; helo=mail-pf1-x42f.google.com
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

Reviewed-by: Peter Maydell <peter.maydell@linaro.org>
Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
---
 docs/system/arm/emulation.rst | 1 +
 target/arm/tcg/cpu64.c        | 1 +
 2 files changed, 2 insertions(+)

diff --git a/docs/system/arm/emulation.rst b/docs/system/arm/emulation.rst
index 34b63f9867f..3bd5c42a664 100644
--- a/docs/system/arm/emulation.rst
+++ b/docs/system/arm/emulation.rst
@@ -223,6 +223,7 @@ the following architecture extensions:
 - FEAT_TTL (Translation Table Level)
 - FEAT_TTST (Small translation tables)
 - FEAT_UAO (Unprivileged Access Override control)
+- FEAT_UINJ (Injection of Undefined Instruction exceptions)
 - FEAT_VHE (Virtualization Host Extensions)
 - FEAT_VMID16 (16-bit VMID)
 - FEAT_WFxT (WFE and WFI instructions with timeout)
diff --git a/target/arm/tcg/cpu64.c b/target/arm/tcg/cpu64.c
index affd87a3ae5..aecee55ef77 100644
--- a/target/arm/tcg/cpu64.c
+++ b/target/arm/tcg/cpu64.c
@@ -1457,6 +1457,7 @@ void aarch64_max_v9_tcg_initfn(Object *obj)
     SET_IDREG(isar, ID_AA64PFR1, t);
 
     t = GET_IDREG(isar, ID_AA64PFR2);
+    t = FIELD_DP64(t, ID_AA64PFR2, UINJ, 1);      /* v9.0: FEAT_UINJ */
     t = FIELD_DP64(t, ID_AA64PFR2, FPMR, 1);      /* v9.2: FEAT_FPMR */
     SET_IDREG(isar, ID_AA64PFR2, t);
 
-- 
2.53.0


