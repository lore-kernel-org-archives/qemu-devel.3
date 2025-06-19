Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id CBB3BC7115B
	for <qemu-devel@archiver.kernel.org>; Thu, 19 Jun 2025 13:15:24 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uSF5C-0003WR-0D; Thu, 19 Jun 2025 09:13:34 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1uSF5A-0003W0-4k
 for qemu-devel@nongnu.org; Thu, 19 Jun 2025 09:13:32 -0400
Received: from mail-wm1-x32b.google.com ([2a00:1450:4864:20::32b])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1uSF58-0003qk-Hl
 for qemu-devel@nongnu.org; Thu, 19 Jun 2025 09:13:31 -0400
Received: by mail-wm1-x32b.google.com with SMTP id
 5b1f17b1804b1-451d3f72391so7801675e9.3
 for <qemu-devel@nongnu.org>; Thu, 19 Jun 2025 06:13:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1750338809; x=1750943609; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=2Ev+863iqOIDDV0R/dWNRsZfcIc6LEpbTT/XvBynDLs=;
 b=lGpn58AqjflM/mSD8chw41Y3tco2iQ8oVATA+os40i0D0bG6ltiO4zCErSYqepii/d
 hn/UL0Mvz+WiUuI9W3YyeVw0mnz1WzkOR60F10d3ZO8m/pUq1AG0IgSS4gfxt/DpbPp0
 EdHdtx0l+U6N74LakmdWN9w80cB3eQIms6XbJZfGx6+9ABuhIFtUwMDi2AbH9BCfle2k
 n/RumQcdnobkgJrTTjKSa2AxkQ+7DPht10p/2zgFagrfou6n0wDHHDbhQGuEcdz3MVU8
 atmVgb17qQXHdnhK1u3XrS7/w29wU1CNvwFgbeK9MY9ZPaPbW57ddElREX8Y6hi3QD/U
 Ebtw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1750338809; x=1750943609;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=2Ev+863iqOIDDV0R/dWNRsZfcIc6LEpbTT/XvBynDLs=;
 b=MvMHfHVRcG0l5rd68OZQEpUfW7dOCxFXPhzzTdTeLtii7O601VVs49rzQlVhVI62hH
 JRimoWUsFdtQUMDAaMoOF0WQabrpOibpzPTarhXv5bljSrwTcjT3ToDqQMUxJ5jV74ZW
 /VFU+o7DX+IGN9m9n7Ttk/O+oVQJRIg80bfehSDgiDs8nuJMe9O0+B+3Y0J819fCNptq
 anoUvgOETCj9Jj8r6187z8UtOTC/2TdI2gKnPY1pWbnoDI/LRVgPiEKylCJGPfn5N3UZ
 3Z9MC+1noutNjOijWMDriYO+j69c4XI0E7l5ho/Du/HPnZqz+dPt062RH92+75bfGcmi
 5JOg==
X-Gm-Message-State: AOJu0YzQkq5wDhSfgTgOjnK3V0OXedA27r5NRmHc0eKvPaPWwXBZeHfK
 NvuiwdW+/SREkdqkLzvQsuqIsB4CAKPST+mcKUuQ3OEDgH2cTjV8LaRmRN5ZkpEM1GgfBWuPOrc
 9kYmekdA=
X-Gm-Gg: ASbGncsLnzGlUtKwaBKmE3yEeuPAy/8aBwgnWGvDPG+EGWHK3Rpet/wSEgFB3GEzBAM
 8v+SS7JA4WOzK4HW8Ng1KU3AQbnE8RanjTWrTYsbHO6eGJgIBlcmdWN96CxHGnZ2pikG5QppBx7
 aFrldoZQsFsjkZawC3WBL3iyPHUfA4Dy/tbe1+RrqzxP4+ZZAvEs0/MP5gb4KsdNqx9zgFRtAqX
 pp8v2n2i1C91rQSD2sdMjYWUhX3pe304Ew0MQeKRuMeopAlOr1YD8D4iBsVNdWgErs/K5zp156A
 JAuC9hcf6w2eVRo7WVr3ZokxTH+rgOBXVQ0BUAFGtWkgQ8iwbBpzrSEzHH5EXEsLhyb3ecbuRxE
 3wNxUrVTCaXx6hzb537kLfPbAD1Rcys9Wftr2yghWnixAiZU=
X-Google-Smtp-Source: AGHT+IFkouH7GB8jjz46Cjjpk91VPjUcSA7l4wGoEJYpu2Gq89Z3Iw8lW1b02HE7V1gEJ16AcP6NmQ==
X-Received: by 2002:a05:6000:4284:b0:3a4:eb7a:2cda with SMTP id
 ffacd0b85a97d-3a5723a2c2fmr15063840f8f.30.1750338808615; 
 Thu, 19 Jun 2025 06:13:28 -0700 (PDT)
Received: from localhost.localdomain (88-187-86-199.subs.proxad.net.
 [88.187.86.199]) by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-3a5896356eesm7143238f8f.49.2025.06.19.06.13.27
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Thu, 19 Jun 2025 06:13:28 -0700 (PDT)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
To: qemu-devel@nongnu.org
Cc: Cameron Esfahani <dirty@apple.com>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Julian Armistead <julian.armistead@linaro.org>,
 Radoslaw Biernacki <rad@semihalf.com>,
 =?UTF-8?q?Marc-Andr=C3=A9=20Lureau?= <marcandre.lureau@redhat.com>,
 Phil Dennis-Jordan <phil@philjordan.eu>,
 =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>,
 =?UTF-8?q?Daniel=20P=2E=20Berrang=C3=A9?= <berrange@redhat.com>,
 Paolo Bonzini <pbonzini@redhat.com>,
 Peter Maydell <peter.maydell@linaro.org>,
 Leif Lindholm <leif.lindholm@oss.qualcomm.com>,
 Pierrick Bouvier <pierrick.bouvier@linaro.org>,
 Richard Henderson <richard.henderson@linaro.org>, qemu-arm@nongnu.org,
 Roman Bolshakov <rbolshakov@ddn.com>, Alexander Graf <agraf@csgraf.de>
Subject: [PATCH 01/20] target/arm: Remove arm_handle_psci_call() stub
Date: Thu, 19 Jun 2025 15:13:00 +0200
Message-ID: <20250619131319.47301-2-philmd@linaro.org>
X-Mailer: git-send-email 2.49.0
In-Reply-To: <20250619131319.47301-1-philmd@linaro.org>
References: <20250619131319.47301-1-philmd@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::32b;
 envelope-from=philmd@linaro.org; helo=mail-wm1-x32b.google.com
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

Since commit 0c1aaa66c24 ("target/arm: wrap psci call with
tcg_enabled") the arm_handle_psci_call() call is elided
when TCG is disabled.

Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
---
 target/arm/internals.h | 6 +-----
 1 file changed, 1 insertion(+), 5 deletions(-)

diff --git a/target/arm/internals.h b/target/arm/internals.h
index 3360de9150f..5ed25d33208 100644
--- a/target/arm/internals.h
+++ b/target/arm/internals.h
@@ -650,16 +650,12 @@ static inline bool arm_is_psci_call(ARMCPU *cpu, int excp_type)
 {
     return false;
 }
-static inline void arm_handle_psci_call(ARMCPU *cpu)
-{
-    g_assert_not_reached();
-}
 #else
 /* Return true if the r0/x0 value indicates that this SMC/HVC is a PSCI call. */
 bool arm_is_psci_call(ARMCPU *cpu, int excp_type);
+#endif
 /* Actually handle a PSCI call */
 void arm_handle_psci_call(ARMCPU *cpu);
-#endif
 
 /**
  * arm_clear_exclusive: clear the exclusive monitor
-- 
2.49.0


