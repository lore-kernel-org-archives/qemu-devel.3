Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7942BC87FCB
	for <qemu-devel@archiver.kernel.org>; Tue, 12 Aug 2025 17:29:34 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1ulso3-0004Bd-T5; Tue, 12 Aug 2025 13:29:03 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1ulsnx-000487-OU
 for qemu-devel@nongnu.org; Tue, 12 Aug 2025 13:28:57 -0400
Received: from mail-wm1-x32b.google.com ([2a00:1450:4864:20::32b])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1ulsnr-0003UD-8J
 for qemu-devel@nongnu.org; Tue, 12 Aug 2025 13:28:57 -0400
Received: by mail-wm1-x32b.google.com with SMTP id
 5b1f17b1804b1-455fdfb5d04so29353335e9.2
 for <qemu-devel@nongnu.org>; Tue, 12 Aug 2025 10:28:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1755019726; x=1755624526; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=5Gx01KlGJnh6U0DX4MaOA7JQNq9Sq+XdhCp2GXJJ2aM=;
 b=OIgfbL/ZethhyXS9sOqXPWgnY1IG2yI8Xz0jQaR4/VCM/Owx2XT36YBlPs6+ic+EzN
 QKdUGluPJNfCz6Medvtsqgx8GcsFibbPBwNHIeTDldc0hMlLsGjEn6Jv98PfPDdLjuJT
 WPKVOvo17bSz1tpShyFR/4WmKdX1v5tz+89xoVVb3HemkraP6ZXO+Z/XVsQ4P6ZBPOhS
 VEUlviUn0MwgpWqDqf++bQGCbIcNNcAXevYoEbr8fi4kNVcq7O4dA52RzeQLOZhE/vXm
 H9ATb6bX2GMfwWbS9YUNBKUURPa7t1EC8Kkb1dCleAPtNqwzGpVRXciBXt4q2wPs6JjF
 E37A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1755019726; x=1755624526;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=5Gx01KlGJnh6U0DX4MaOA7JQNq9Sq+XdhCp2GXJJ2aM=;
 b=KNEWUbQn6rRMCKogSvGNKBuwJyKdhrgTahAPL6ZKvBoARzbgVdCgmS63Y5tR5NGFl+
 tgyMPY8h3ZLxo1k4DmNAGlplGZFmvqGLH4KCxEuHPJJBEb2nyIMIg/2EQDJlLJDjnCaG
 wSUZ+jxPiCrCxt60p5JFc5nSweSwR6Wpd69fNGpEdYsE1NbTd2B2jz0rijjQXzi1G500
 VCPL1jngxWuJrnbjbgL56n+kdYlMRCTFOcT0KvJKop6Jg9O9iU4T/zpAofXM6+FhhUwa
 1OEKBodlfHNSRymYshjExx63iTTwha+49xnMtbepl1ZO9NAQdjgPjiSQgd3SJfURw2bT
 vsdw==
X-Gm-Message-State: AOJu0YzhZsur3BmghYi1oYPTGhdarv4y64ti6fEox5rJWy2WqKqQpKdA
 8G81aCROYKAx1TMDCqYmCDSqogS/jA2w87kd5l/PPpDACny47E1CK1jck/4bK9IlN8q1Hg6Hsts
 vHwVe
X-Gm-Gg: ASbGncttSutz/Di6opHT6C5+Svbe9Xu8WlRSjK88WR+eU+wg+OfNYwiBk9zPdGo+JkQ
 25q3Rs0lmo3p5+3uRl0SyChFXDYl14H+g47z8CuzdOBosIisqPD6jzrXYTEpO0kiPhstNQs12Jq
 iWG4goJFO1lQvXdnt3TYRv+162tSOSymp9STVekBxgWc4w4hf1kjaA5GPYhebNTXfrdjlPcDvMx
 kafxbJCOCZbaOL/iG/KlHX/RAXWTGOFHczIatqZKHCtxwAYkqfTvSPkUzEFjF/9U2ZS3YR1L2H7
 GlcxFpFdbz4d60KyIc11+nzmqbodsJCNbHNZN6904NukFTNQacnAB5e+uUYWrJtKfCZD7TK4IYQ
 mIYZJ7Ovt81UUEo7UEk2NXKOwhvKTDLV1Dcv6QosYd7xDvl21obL/td9Ie8+blFXrScng7R8H
X-Google-Smtp-Source: AGHT+IEZ2BdB+DDDUDUmqAGCaLdS1J0twMRD6GrR7y46Lkn0qIPsngqJjPbgGbfbHEgD6hhro3LQXw==
X-Received: by 2002:a05:600c:548f:b0:458:bfe1:4a82 with SMTP id
 5b1f17b1804b1-45a165e430fmr31995e9.16.1755019726154; 
 Tue, 12 Aug 2025 10:28:46 -0700 (PDT)
Received: from localhost.localdomain (88-187-86-199.subs.proxad.net.
 [88.187.86.199]) by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-3b9163ae600sm918558f8f.5.2025.08.12.10.28.44
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Tue, 12 Aug 2025 10:28:45 -0700 (PDT)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
To: qemu-devel@nongnu.org
Cc: Claudio Fontana <cfontana@suse.de>, Cameron Esfahani <dirty@apple.com>,
 Mohamed Mediouni <mohamed@unpredictable.fr>,
 Alexander Graf <agraf@csgraf.de>, Paolo Bonzini <pbonzini@redhat.com>,
 kvm@vger.kernel.org, Eric Auger <eric.auger@redhat.com>,
 qemu-arm@nongnu.org, Mads Ynddal <mads@ynddal.dk>,
 Richard Henderson <richard.henderson@linaro.org>,
 =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>,
 Peter Maydell <peter.maydell@linaro.org>,
 Miguel Luis <miguel.luis@oracle.com>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
Subject: [PATCH v2 04/10] target/arm: Factor hvf_psci_get_target_el() out
Date: Tue, 12 Aug 2025 19:28:16 +0200
Message-ID: <20250812172823.86329-5-philmd@linaro.org>
X-Mailer: git-send-email 2.49.0
In-Reply-To: <20250812172823.86329-1-philmd@linaro.org>
References: <20250812172823.86329-1-philmd@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::32b;
 envelope-from=philmd@linaro.org; helo=mail-wm1-x32b.google.com
X-Spam_score_int: -16
X-Spam_score: -1.7
X-Spam_bar: -
X-Spam_report: (-1.7 / 5.0 requ) BAYES_00=-1.9, DKIM_INVALID=0.1,
 DKIM_SIGNED=0.1, RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=no autolearn_force=no
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

From: Mohamed Mediouni <mohamed@unpredictable.fr>

Factor hvf_psci_get_target_el() out so it will be easier
to allow switching to other EL later.

Signed-off-by: Mohamed Mediouni <mohamed@unpredictable.fr>
Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
Reviewed-by: Richard Henderson <richard.henderson@linaro.org>
---
 target/arm/hvf/hvf.c | 7 +++++--
 1 file changed, 5 insertions(+), 2 deletions(-)

diff --git a/target/arm/hvf/hvf.c b/target/arm/hvf/hvf.c
index 47b0cd3a351..48e86e62945 100644
--- a/target/arm/hvf/hvf.c
+++ b/target/arm/hvf/hvf.c
@@ -1107,6 +1107,10 @@ static void hvf_psci_cpu_off(ARMCPU *arm_cpu)
     assert(ret == QEMU_ARM_POWERCTL_RET_SUCCESS);
 }
 
+static int hvf_psci_get_target_el(CPUARMState *env)
+{
+    return 1;
+}
 /*
  * Handle a PSCI call.
  *
@@ -1128,7 +1132,6 @@ static bool hvf_handle_psci_call(CPUState *cpu)
     CPUState *target_cpu_state;
     ARMCPU *target_cpu;
     target_ulong entry;
-    int target_el = 1;
     int32_t ret = 0;
 
     trace_hvf_psci_call(param[0], param[1], param[2], param[3],
@@ -1182,7 +1185,7 @@ static bool hvf_handle_psci_call(CPUState *cpu)
         entry = param[2];
         context_id = param[3];
         ret = arm_set_cpu_on(mpidr, entry, context_id,
-                             target_el, target_aarch64);
+                             hvf_psci_get_target_el(env), target_aarch64);
         break;
     case QEMU_PSCI_0_1_FN_CPU_OFF:
     case QEMU_PSCI_0_2_FN_CPU_OFF:
-- 
2.49.0


