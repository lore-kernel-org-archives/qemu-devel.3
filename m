Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 42535C7115C
	for <qemu-devel@archiver.kernel.org>; Thu, 19 Jun 2025 13:17:33 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uSF60-0003qo-7E; Thu, 19 Jun 2025 09:14:24 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1uSF5w-0003ij-Ng
 for qemu-devel@nongnu.org; Thu, 19 Jun 2025 09:14:20 -0400
Received: from mail-wm1-x331.google.com ([2a00:1450:4864:20::331])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1uSF5v-0003yA-16
 for qemu-devel@nongnu.org; Thu, 19 Jun 2025 09:14:20 -0400
Received: by mail-wm1-x331.google.com with SMTP id
 5b1f17b1804b1-451d41e1ad1so5832835e9.1
 for <qemu-devel@nongnu.org>; Thu, 19 Jun 2025 06:14:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1750338856; x=1750943656; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=t+CQZzgXVaIFNKsZoeAwh6dF99jW8fzr897tIFidOds=;
 b=mR6efAwiLn384XoRsq/AkktFKwhUCNCK8k1M0BFhvoJd543HC15PAOfsNVv8r348vO
 tvbDNHonDclg0NdawGzc2HphF1Wj//8QqGTKI18H2opTVSJGR0XPrMYSLN1+8V6dPYjl
 yjL1u9OUCX/2FZ8fEtk8NlFSNzJQEG26ltEY474VmJJO8JDEN/lxYQ6a9K8e1AB3bSll
 JKnixVW0VYy7LIy8x+viw5sAirfBvKgTd5FzfPoMJ2cUStjQn8V5OUmgz3CUdlSjlWe/
 trIzZDLgMfKIiaOH+watcPnnGAopswHhr0Ul5sFNcD5+EhoX2rQkibaejqBdlI6V8MTv
 z6kQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1750338856; x=1750943656;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=t+CQZzgXVaIFNKsZoeAwh6dF99jW8fzr897tIFidOds=;
 b=WZNOskfCJoQO1H/HTeGgEMuN6umIPKDeMTCGxGa1UOdb6jnGHhRR+FNPO7Dz4SMDf1
 Bb/Maz6Dau2Peaix1NnPgysmhXs2MIXuJlFoicgsarDMn+xWMhQAePFNW4ioYKuB7MVZ
 MZW7aek0OF8GXiFqreGHaN9rRGhptJQEOyVrEFgTZHnENA6okLPp2Y7mg279A5PeqHUn
 BZ9/8XdF9rJ0psc3sjUvUKQkwiYi8cnJUdqLrzTp/wltep9M8GU7XABeZbZ4teZMJ4x5
 2SuhTmUfIPZiwb0WALF/MYpJgNCenDQiSnooKfOPii6+yXDsQaM/5ahLynn8X9f7GhE+
 y9sA==
X-Gm-Message-State: AOJu0Yw6b9/GtbUEHCYg0rmdbfuPqkD4CHNXARgkyzo+SklBX6bRzR1U
 Kao0TL0vl2KfhiuM6hoc3vSGLz7oEW/0GP3upjgHyPZnt0i+gq0Xkudzoh6Av6Op4iji9WIzqyl
 wOYWbNCI=
X-Gm-Gg: ASbGncta+GXhTcgWLcRfddatbUppf1fZpeDgEKezYOvK5+i/SvENowScdB35DShBCl9
 muKWOokAknVy1jSICV5fkORvYGN2acnXEgZ34jDogQJfufD2T2ql3wXgX4fBgu7ytSSpbAI7qO1
 IQ+GUdE6oH7zNkjTpZcUtHNDrcZOdpR5PGmZlUmhlEDXn2S0iZL4Q2QsOp46xQcXGLWoLS1LpdF
 kK5SZUr2K8I3ae0gFhgWKYwEws+5e3kVlVb7wyVGLTqaoLHsZK1N0Cz0tGI2WriQbo1rR1xtozg
 yIV20JG/+m4SYKuvOqh6VnUW053FMBXgL2iLb2anQAUv7+Pq/aCdhHPmw5Kp5Lww5KD4f0yRnc/
 lr1tRnvkPF5JzM6+tTS+ZX5xPGLEdbtK0/mbmal5pZI4w1Rk=
X-Google-Smtp-Source: AGHT+IHxWwthlICtEPbyo/liZr0Yr5cAjas25sh5+S0g5y1XPaawtH+KxbOYIqw/ohgJip5mJzHstg==
X-Received: by 2002:a05:600c:1e09:b0:43d:fa58:81d3 with SMTP id
 5b1f17b1804b1-4533cac558emr191965565e9.32.1750338856135; 
 Thu, 19 Jun 2025 06:14:16 -0700 (PDT)
Received: from localhost.localdomain (88-187-86-199.subs.proxad.net.
 [88.187.86.199]) by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-4535e97ac0fsm29779685e9.3.2025.06.19.06.14.14
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Thu, 19 Jun 2025 06:14:15 -0700 (PDT)
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
Subject: [PATCH 10/20] target/arm: Restrict system register properties to
 system binary
Date: Thu, 19 Jun 2025 15:13:09 +0200
Message-ID: <20250619131319.47301-11-philmd@linaro.org>
X-Mailer: git-send-email 2.49.0
In-Reply-To: <20250619131319.47301-1-philmd@linaro.org>
References: <20250619131319.47301-1-philmd@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::331;
 envelope-from=philmd@linaro.org; helo=mail-wm1-x331.google.com
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

Do not expose system-specific properties on user-mode binaries.

Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
---
 target/arm/cpu.c | 4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

diff --git a/target/arm/cpu.c b/target/arm/cpu.c
index eb0639de719..c99981d88f8 100644
--- a/target/arm/cpu.c
+++ b/target/arm/cpu.c
@@ -1500,6 +1500,7 @@ static void arm_cpu_initfn(Object *obj)
  * 0 means "unset, use the default value". That default might vary depending
  * on the CPU type, and is set in the realize fn.
  */
+#ifndef CONFIG_USER_ONLY
 static const Property arm_cpu_gt_cntfrq_property =
             DEFINE_PROP_UINT64("cntfrq", ARMCPU, gt_cntfrq_hz, 0);
 
@@ -1509,7 +1510,6 @@ static const Property arm_cpu_reset_cbar_property =
 static const Property arm_cpu_reset_hivecs_property =
             DEFINE_PROP_BOOL("reset-hivecs", ARMCPU, reset_hivecs, false);
 
-#ifndef CONFIG_USER_ONLY
 static const Property arm_cpu_has_el2_property =
             DEFINE_PROP_BOOL("has_el2", ARMCPU, has_el2, true);
 
@@ -1532,6 +1532,7 @@ static const Property arm_cpu_has_neon_property =
 static const Property arm_cpu_has_dsp_property =
             DEFINE_PROP_BOOL("dsp", ARMCPU, has_dsp, true);
 
+#ifndef CONFIG_USER_ONLY
 static const Property arm_cpu_has_mpu_property =
             DEFINE_PROP_BOOL("has-mpu", ARMCPU, has_mpu, true);
 
@@ -1544,6 +1545,7 @@ static const Property arm_cpu_pmsav7_dregion_property =
             DEFINE_PROP_UNSIGNED_NODEFAULT("pmsav7-dregion", ARMCPU,
                                            pmsav7_dregion,
                                            qdev_prop_uint32, uint32_t);
+#endif
 
 static bool arm_get_pmu(Object *obj, Error **errp)
 {
-- 
2.49.0


