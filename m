Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id F2869CD5BC8
	for <qemu-devel@archiver.kernel.org>; Tue, 26 May 2026 20:39:54 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wRyYp-0003RL-Tp; Tue, 26 May 2026 16:39:36 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1wRyYi-00038W-IX
 for qemu-devel@nongnu.org; Tue, 26 May 2026 16:39:29 -0400
Received: from mail-wr1-x436.google.com ([2a00:1450:4864:20::436])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1wRyYg-00083i-O1
 for qemu-devel@nongnu.org; Tue, 26 May 2026 16:39:28 -0400
Received: by mail-wr1-x436.google.com with SMTP id
 ffacd0b85a97d-441209fb77eso6845112f8f.1
 for <qemu-devel@nongnu.org>; Tue, 26 May 2026 13:39:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1779827964; x=1780432764; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=FwX4TVNJjORfo35og2hvhoAxKst8+SezncN2NkLhWnk=;
 b=pWS7fULhh4JuX5GNL5hinZlFjcmdeRSUSv2G7tdG35Ux1YuAfAAD427cQOfdU/kOnr
 rv0jdls8cm7/0fQgboyjtCtXyCkqtkv1DuSU7Y+6aBYQ5nMwStCJL0x+DRLV7nqmnE63
 tcJ0G/+R+IB4GgG7fhrPMYibKhpjUQhMAgWsSq9kXSos9shmNnK9yn1v/Czc8RdxLwXu
 PN7zlYSwlts3McMaC68j8j/WAKkxQS+XebML6JBCrdm70FIAIMcy5d9MGPMSQukMjYzq
 cCw8clnTvaYVQO4eFAK71sw/TrIyU5mKg7MOUVpTlIM9tdvTio7AysCBqrFuC09A4nrz
 OpqQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1779827964; x=1780432764;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=FwX4TVNJjORfo35og2hvhoAxKst8+SezncN2NkLhWnk=;
 b=e7Fvnry0epplH0YLOfIT+gbVGh16y311J2uGLtnJMZ+COxzTZBjeKUZ3SfB/VBieKm
 JHQOSeB9yRsyCIyQWAG8+2o0rKNt7lP32GIRC45LYc0N98tP+7el4bhCNP/4UV5BwlAK
 0EFq4byNBNX2afs+prhi9UeA6rh1A5yoeJno9IO/BvcTBs14PCFXckSscBa0iSZl3Ion
 dN73iXTvihMHkUg+H10SIsivR9PAhzfCSiu/xCX57soeyatJLYtApQkJSTfwbCRQOlA2
 kUPEKH998UwDVIYGO7Ogq1YCnjC9Wn1Oaiq/Kdvxw8ubT2ULJC+ES2E6Mi1BNKvEItds
 rrlQ==
X-Gm-Message-State: AOJu0YzCUcrO+ii0ryEig1RNZeDFzi0+67GQyBYHFJ0GRyoh3dkWufcJ
 cnY7ZrsKCJfK/sYGIoG0yEDGdkNe5RR9uHhlHQQ6UwrcEo4nkB7w/TIr4aqYDSy6fcAEl+0Bs4o
 yrfUi/z8ixw==
X-Gm-Gg: Acq92OHVZhzNRygFacCtDWVCmCfWdqy4eSlSdKfaFzezlE57/xv6bGI2LOYRKGRsjQ8
 LUhXLWtUwrRcRW8Kwcp4ex0S/yGTNu+vY9fOV1u4tuht+4SmpHLA+q14VQFfOexIbjRfaglilqP
 ThO9D3DDwGOCMiqgVNTTcDj8MjlyX0obxU89Nerh4TUPV5q6/SoouGqTf/ZE8by6xNQSG73UdXl
 gAgDjTFNR3cevkq4tIRkMxPBzmx3idZRv87j7S25nkM48oXFpvuanbh4efC0Hnso6TMAhhcR4d6
 Btzi69LYUK0wWQ28K25zpo1+WR7zDWBaiPo8Dm6ZSHdxzO7ASf8bW3Si8gnIAbp+30fYFeHPyFi
 DHUdGUWC0oxR35k9e5jEsD0pxwYtP4CO8lhSDvwSqlcZ6XGPBVBHCmKeXN9UPvtKpfeyE7ET0UP
 q1YnY5mlm5FDP9z6hkKrSTZDYuaNJ7yhtwMZy5dITjx5tEGQrLESDCg7mxB+yUIP98jQ==
X-Received: by 2002:a05:6000:2f89:b0:45e:7792:6e6d with SMTP id
 ffacd0b85a97d-45eb3123abbmr32460019f8f.13.1779827964252; 
 Tue, 26 May 2026 13:39:24 -0700 (PDT)
Received: from m17.home (88-187-86-199.subs.proxad.net. [88.187.86.199])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-45edb558dd0sm768005f8f.16.2026.05.26.13.39.23
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Tue, 26 May 2026 13:39:23 -0700 (PDT)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
To: qemu-devel@nongnu.org
Cc: qemu-arm@nongnu.org
Subject: [PATCH v9 17/17] target/arm: Build cpu-max.c once
Date: Tue, 26 May 2026 22:37:22 +0200
Message-ID: <20260526203722.79463-18-philmd@linaro.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260526203722.79463-1-philmd@linaro.org>
References: <20260526203722.79463-1-philmd@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::436;
 envelope-from=philmd@linaro.org; helo=mail-wr1-x436.google.com
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

Call TargetInfo::target_aarch64() at runtime, allowing to
remove the target-specific TARGET_AARCH64 definition and
build cpu-max.c once as common object.

Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
Reviewed-by: Manos Pitsidianakis <manos.pitsidianakis@linaro.org>
Reviewed-by: Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>
Acked-by: Peter Maydell <peter.maydell@linaro.org>
---
 target/arm/cpu-max.c   | 8 ++------
 target/arm/meson.build | 2 +-
 2 files changed, 3 insertions(+), 7 deletions(-)

diff --git a/target/arm/cpu-max.c b/target/arm/cpu-max.c
index 8cf8edc6535..d38bdfcf811 100644
--- a/target/arm/cpu-max.c
+++ b/target/arm/cpu-max.c
@@ -8,6 +8,7 @@
 
 #include "qemu/osdep.h"
 #include "qemu/units.h"
+#include "qemu/target-info.h"
 #include "system/hw_accel.h"
 #include "system/kvm.h"
 #include "system/qtest.h"
@@ -190,12 +191,7 @@ void aa32_max_features(ARMCPU *cpu)
 static void cpu_max_initfn(Object *obj)
 {
     ARMCPU *cpu = ARM_CPU(obj);
-
-#ifdef TARGET_AARCH64
-    const bool aarch64_enabled = true;
-#else
-    const bool aarch64_enabled = false;
-#endif /* !TARGET_AARCH64 */
+    const bool aarch64_enabled = target_aarch64();
 
     if (hwaccel_enabled()) {
         assert(aarch64_enabled);
diff --git a/target/arm/meson.build b/target/arm/meson.build
index 3e02941d0d5..9408131d178 100644
--- a/target/arm/meson.build
+++ b/target/arm/meson.build
@@ -9,7 +9,6 @@ arm_user_ss = ss.source_set()
 arm_common_system_ss.add(files('gdbstub.c'))
 arm_user_ss.add(files('gdbstub.c'))
 
-arm_ss.add(files('cpu-max.c'))
 arm_ss.add(when: 'TARGET_AARCH64', if_true: files(
   'cpu64.c',
 ))
@@ -20,6 +19,7 @@ arm_common_ss.add(files(
 arm_common_user_system_ss.add(files(
   'cpregs-gcs.c',
   'cpregs-pmu.c',
+  'cpu-max.c',
   'debug_helper.c',
   'helper.c',
   'vfp_fpscr.c',
-- 
2.53.0


