Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 52783CD343B
	for <qemu-devel@archiver.kernel.org>; Wed,  6 May 2026 14:13:01 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wKcuB-0006dh-NS; Wed, 06 May 2026 10:07:16 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1wKct0-0005TH-K4
 for qemu-devel@nongnu.org; Wed, 06 May 2026 10:06:04 -0400
Received: from mail-wm1-x332.google.com ([2a00:1450:4864:20::332])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1wKcsy-0001k6-Og
 for qemu-devel@nongnu.org; Wed, 06 May 2026 10:06:02 -0400
Received: by mail-wm1-x332.google.com with SMTP id
 5b1f17b1804b1-488ad135063so61615775e9.0
 for <qemu-devel@nongnu.org>; Wed, 06 May 2026 07:05:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1778076357; x=1778681157; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
 :reply-to; bh=XEy5qmOgT5jPONcPwspPTaFki8owjZYQ9y+oaKY0q6Q=;
 b=ai9i8S7CtdKGIkKeTmuAz6twmcYjXhRjTZq00OaCvkeoSCcSPWoFPm1r4KawfLIdJS
 RGo0teaBYc65MDCLKc4soZJpj5+n4++c2j6lSa5Y2fvayWwW4xryem8GLcJ/wZh171fU
 icmSpW+6pmtPtb41APukJRsN9TS2JRr75reo4JKFsPx8WvBZs8fW8Iw3mB2JEiHA4uHr
 cm80xk/nwGT9M4gTJAhldWa9hY60G7JRI38H9E12w40ICWJ7r1vw+URJFUYzI8xzx1h2
 R6bR30UMEmEBYverzhJsUtdso6XjqPH3ScHWUppW8C5eG6BP5z9/YtbBmij+BT8WCNj1
 5HMQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1778076357; x=1778681157;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:x-gm-gg:x-gm-message-state:from:to
 :cc:subject:date:message-id:reply-to;
 bh=XEy5qmOgT5jPONcPwspPTaFki8owjZYQ9y+oaKY0q6Q=;
 b=q0hjusSilF41cTO510eEZgB9P9WoYJfwnmZHZpFLM2rLRDAa4AU5gpMsAKp04A1g/m
 IGK9OgTpr6yqHqwEqzt1xG3HvG67L2XBX3ZNXyVbTUS7/xFhXy2l1XcYhqgbfGOvNNDY
 geo0T+nMhFZj2PFAwOAZ2Dbkrd7gr5YtmezJsHvqCXswsCuoFosXUhH/CYajf7GcVoEw
 DPVSCB+B+z58g7exTtVMzRiVi09inEtqC25e8ZUcRsFWOT7Nh3mEmL7w8Wek29xAgmEX
 rm35kHhFaYg53VLXiQak0amulR2BR16u2tHdTqH3/ivvQZntLaw1cYQgufc0gj5faDkQ
 bRqA==
X-Gm-Message-State: AOJu0YxaZFaDgVnlf62ntQnfopOT/nFIewj2Ozbv1Bh3APm662eWgA5N
 ixT2SrF3JWOLtenSTThv3cND1o6a9Ji2qfhxAGZptprsOK7e3zHMqygHaIGbWdl2In+q7AQYNvQ
 jLJiePMQ=
X-Gm-Gg: AeBDieta22bxCF+E07yx9E46iT6DSV0DaDCnQ/NoHvUhEU2Aj20q3o/YlNJTthUmUzJ
 USR5FktN4EqasrVzVbfVHzSUVBJJ5KnVC3NK90B2rFZFAlans0QNW72mioyG6YuDvzRK3utEjrQ
 KYX7tjtGT62iau05+WJs0iKNcDZdvt94m93OGeldwzpviU+rBq+LmA9vqq106A7zK71zjIJt12A
 eu7aVlXswZNdMtLmf580+gjiALNeMtDggZBRxfYRGKjYpxvTHzURq+KQosVNwe+tgFD0N8Y6Vuc
 4V+O5okyzONHjNrar9uO4apEKCFMfg4+GmMzATzAtRXNpnPf1uADCxAQYTy+W5d40HetZLabP6K
 pW8qLyCilkUyQL4tlWUMt6m2S0uyng11kE83BnrY8WdnH6Kv4kPv0gqanZF9iyVm6+J0F3lXB6V
 r2xULEpHz8HqsZ7HCv03dOuew1C1ao0FVmxtvk0/Vw+WCm3utIdySF7dqiEFT/VF4kc6DSvui27
 0ETBpQfrR4=
X-Received: by 2002:a05:600c:354b:b0:486:f634:ef1 with SMTP id
 5b1f17b1804b1-48e51f32a7amr64175305e9.17.1778076356583; 
 Wed, 06 May 2026 07:05:56 -0700 (PDT)
Received: from localhost.localdomain (88-187-86-199.subs.proxad.net.
 [88.187.86.199]) by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-48e530b212esm23820875e9.1.2026.05.06.07.05.54
 for <qemu-devel@nongnu.org>
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Wed, 06 May 2026 07:05:55 -0700 (PDT)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
To: qemu-devel@nongnu.org
Subject: [PULL 080/110] target/arm: define stub library
Date: Wed,  6 May 2026 15:54:52 +0200
Message-ID: <20260506135524.20617-81-philmd@linaro.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260506135524.20617-1-philmd@linaro.org>
References: <20260506135524.20617-1-philmd@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::332;
 envelope-from=philmd@linaro.org; helo=mail-wm1-x332.google.com
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

From: Pierrick Bouvier <pierrick.bouvier@linaro.org>

We use the mechanic introduced in previous commit to define a arm stubs
library. With this, we are able to eliminate symbol conflicts when
linking arm and aarch64 targets, and get one step closer to having a
single-binary.

Signed-off-by: Pierrick Bouvier <pierrick.bouvier@linaro.org>
Reviewed-by: Philippe Mathieu-Daudé <philmd@linaro.org>
Message-Id: <20260424230103.1579600-3-pierrick.bouvier@oss.qualcomm.com>
Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
---
 target/arm/meson.build     | 8 +++-----
 target/arm/tcg/meson.build | 2 +-
 2 files changed, 4 insertions(+), 6 deletions(-)

diff --git a/target/arm/meson.build b/target/arm/meson.build
index 192ac7c31ee..4723f9f170a 100644
--- a/target/arm/meson.build
+++ b/target/arm/meson.build
@@ -2,6 +2,7 @@ arm_ss = ss.source_set()
 arm_common_ss = ss.source_set()
 arm_common_system_ss = ss.source_set()
 arm_system_ss = ss.source_set()
+arm_stubs_ss = ss.source_set()
 arm_user_ss = ss.source_set()
 
 arm_common_system_ss.add(files('gdbstub.c'))
@@ -23,9 +24,7 @@ arm_system_ss.add(when: 'CONFIG_KVM', if_true: files('hyp_gdbstub.c', 'kvm.c'))
 arm_system_ss.add(when: 'CONFIG_HVF', if_true: files('hyp_gdbstub.c'))
 
 arm_user_ss.add(files('cpu.c'))
-arm_user_ss.add(when: 'TARGET_AARCH64', if_false: files(
-  'cpu32-stubs.c',
-))
+arm_stubs_ss.add(files('cpu32-stubs.c'))
 arm_user_ss.add(files(
   'cpregs-gcs.c',
   'cpregs-pmu.c',
@@ -39,8 +38,6 @@ arm_user_ss.add(when: 'CONFIG_ARM_COMPATIBLE_SEMIHOSTING',
 		        if_true: files('common-semi-target.c'))
 
 arm_common_system_ss.add(files('cpu.c'))
-arm_common_system_ss.add(when: 'TARGET_AARCH64', if_false: files(
-  'cpu32-stubs.c'))
 arm_common_system_ss.add(when: 'CONFIG_KVM', if_false: files('kvm-stub.c'))
 arm_common_system_ss.add(when: 'CONFIG_ARM_COMPATIBLE_SEMIHOSTING',
 		                 if_true: files('common-semi-target.c'))
@@ -73,3 +70,4 @@ target_system_arch += {'arm': arm_system_ss}
 target_user_arch += {'arm': arm_user_ss}
 target_common_arch += {'arm': arm_common_ss}
 target_common_system_arch += {'arm': arm_common_system_ss}
+target_stubs_arch += {'arm': arm_stubs_ss}
diff --git a/target/arm/tcg/meson.build b/target/arm/tcg/meson.build
index 02774409e56..d2364aa39c4 100644
--- a/target/arm/tcg/meson.build
+++ b/target/arm/tcg/meson.build
@@ -28,7 +28,7 @@ translate32_d = [
 ]
 
 arm_ss.add(when: 'TARGET_AARCH64', if_true: gen_a64)
-arm_ss.add(when: 'TARGET_AARCH64', if_false: files('stubs32.c'))
+arm_stubs_ss.add(files('stubs32.c'))
 
 arm_ss.add(files(
   'cpu32.c',
-- 
2.53.0


