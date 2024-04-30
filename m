Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3090AC10F16
	for <qemu-devel@archiver.kernel.org>; Tue, 30 Apr 2024 16:49:25 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1s1qf3-0002OX-41; Tue, 30 Apr 2024 12:48:58 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1s1qf1-0002Lq-O2
 for qemu-devel@nongnu.org; Tue, 30 Apr 2024 12:48:55 -0400
Received: from mail-lj1-x22e.google.com ([2a00:1450:4864:20::22e])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1s1qev-0005cT-MX
 for qemu-devel@nongnu.org; Tue, 30 Apr 2024 12:48:55 -0400
Received: by mail-lj1-x22e.google.com with SMTP id
 38308e7fff4ca-2e01d666c88so30611061fa.2
 for <qemu-devel@nongnu.org>; Tue, 30 Apr 2024 09:48:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1714495728; x=1715100528; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
 :reply-to; bh=YAE2Z85EDqslfi/H8Lhz9sH1xLHpAncNnbrwHz0FrVY=;
 b=q0mHB3aviro4nIIByUz3/Tz6waAHuG/YfEs/1bMryFgGZwURhW/knlIQvE4Y4z4D3q
 rnqLjc3WkLHzzw3Zp7iebaUygdhhhCzKf7XlkTD2rNIBc5PosgLqtdu8jzzJglMVXPjm
 lwPq+0gPuD1cqhHwKMNQJWdfBjFjHbRg90txY4tfjco+8eBazIYy48KxSHQBzxH2RCJW
 NBna05jPMA6LgoJNykFSnbqeMFBONboUoy2c8IP5b2D+GsuHOytYuTjqqR6uzKqko8vV
 lq9xHEP0Nkwadszk298MjzHiuowEN7RFHCrinhMHaZjU3yPs/WB7lvcXRkxyVXJqodSO
 rgEA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1714495728; x=1715100528;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=YAE2Z85EDqslfi/H8Lhz9sH1xLHpAncNnbrwHz0FrVY=;
 b=VDnYBlm41Vm2NxC1QxlFCUe8b9wQnZESFCrjdg2DPt7IFXpe706Bymf2x9r0K2I/JB
 ty0YjkvsldC25Rgl5LiYslh827cfUkX2xMYMpTuAd7dSuccnrVsKdF3KgQqBLaSQ3Dn5
 HdLMvdlBCLfpZCM+LLmfHzp+8gsTxk2bFV+6TXo0cRqijUwt/RxekbZsA2ZNsz5aDAX8
 48AIidLGrC4Ohy3M6/LPD99M+URHGtAAe9jqEUvWY/kbRtBnXKNoJKnSPwro/sdrM6AZ
 JYEntt6AROiPGWNy5qN8Gc1/Vtm6KUE32Dlk0iaQlbADBVfV/5Hop38XeHEgiKKip9wB
 pD2g==
X-Gm-Message-State: AOJu0YxLow9QEB8SSQ6N7X8IHyW1is7Yr6oPq6Rzt96DjVGePEHtQhdb
 amr1pUvIur8gqNw1Mja2BR0GEI692JnPSpnVbJp7BGztxjApz6os+gcsiXuRwBYEnugyncj5Ax2
 P
X-Google-Smtp-Source: AGHT+IF0SDXgHJx2ynA87F4cZDdEUVIW6flC/hLFqCXfkcKzlr7RdQ0E97eHRfzbf0LLDyunsoB2JQ==
X-Received: by 2002:a2e:9602:0:b0:2d8:5a5e:7c5e with SMTP id
 v2-20020a2e9602000000b002d85a5e7c5emr184167ljh.22.1714495728082; 
 Tue, 30 Apr 2024 09:48:48 -0700 (PDT)
Received: from orth.archaic.org.uk (orth.archaic.org.uk. [2001:8b0:1d0::2])
 by smtp.gmail.com with ESMTPSA id
 b6-20020a05600c4e0600b0041be3383a2fsm12920384wmq.19.2024.04.30.09.48.47
 for <qemu-devel@nongnu.org>
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 30 Apr 2024 09:48:47 -0700 (PDT)
From: Peter Maydell <peter.maydell@linaro.org>
To: qemu-devel@nongnu.org
Subject: [PULL 08/21] target/arm: Enable FEAT_Spec_FPACC for -cpu max
Date: Tue, 30 Apr 2024 17:48:29 +0100
Message-Id: <20240430164842.4074734-9-peter.maydell@linaro.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240430164842.4074734-1-peter.maydell@linaro.org>
References: <20240430164842.4074734-1-peter.maydell@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::22e;
 envelope-from=peter.maydell@linaro.org; helo=mail-lj1-x22e.google.com
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

FEAT_Spec_FPACC is a feature describing speculative behaviour in the
event of a PAC authontication failure when FEAT_FPACCOMBINE is
implemented.  FEAT_Spec_FPACC means that the speculative use of
pointers processed by a PAC Authentication is not materially
different in terms of the impact on cached microarchitectural state
(caches, TLBs, etc) between passing and failing of the PAC
Authentication.

QEMU doesn't do speculative execution, so we can advertise
this feature.

Signed-off-by: Peter Maydell <peter.maydell@linaro.org>
Reviewed-by: Richard Henderson <richard.henderson@linaro.org>
Reviewed-by: Philippe Mathieu-Daudé <philmd@linaro.org>
Message-id: 20240418152004.2106516-6-peter.maydell@linaro.org
---
 docs/system/arm/emulation.rst | 1 +
 target/arm/tcg/cpu64.c        | 4 ++++
 2 files changed, 5 insertions(+)

diff --git a/docs/system/arm/emulation.rst b/docs/system/arm/emulation.rst
index 307539cff91..7fcea54d8db 100644
--- a/docs/system/arm/emulation.rst
+++ b/docs/system/arm/emulation.rst
@@ -61,6 +61,7 @@ the following architecture extensions:
 - FEAT_FP16 (Half-precision floating-point data processing)
 - FEAT_FPAC (Faulting on AUT* instructions)
 - FEAT_FPACCOMBINE (Faulting on combined pointer authentication instructions)
+- FEAT_FPACC_SPEC (Speculative behavior of combined pointer authentication instructions)
 - FEAT_FRINTTS (Floating-point to integer instructions)
 - FEAT_FlagM (Flag manipulation instructions v2)
 - FEAT_FlagM2 (Enhancements to flag manipulation instructions)
diff --git a/target/arm/tcg/cpu64.c b/target/arm/tcg/cpu64.c
index ebb585afd85..443cffe3a85 100644
--- a/target/arm/tcg/cpu64.c
+++ b/target/arm/tcg/cpu64.c
@@ -1217,6 +1217,10 @@ void aarch64_max_tcg_initfn(Object *obj)
     t = FIELD_DP64(t, ID_AA64MMFR2, E0PD, 1);     /* FEAT_E0PD */
     cpu->isar.id_aa64mmfr2 = t;
 
+    t = cpu->isar.id_aa64mmfr3;
+    t = FIELD_DP64(t, ID_AA64MMFR3, SPEC_FPACC, 1); /* FEAT_FPACC_SPEC */
+    cpu->isar.id_aa64mmfr3 = t;
+
     t = cpu->isar.id_aa64zfr0;
     t = FIELD_DP64(t, ID_AA64ZFR0, SVEVER, 1);
     t = FIELD_DP64(t, ID_AA64ZFR0, AES, 2);       /* FEAT_SVE_PMULL128 */
-- 
2.34.1


