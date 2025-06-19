Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7687BC7115A
	for <qemu-devel@archiver.kernel.org>; Thu, 19 Jun 2025 13:17:32 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uSF6D-00046h-J7; Thu, 19 Jun 2025 09:14:37 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1uSF6B-00042O-Ed
 for qemu-devel@nongnu.org; Thu, 19 Jun 2025 09:14:35 -0400
Received: from mail-wr1-x42e.google.com ([2a00:1450:4864:20::42e])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1uSF69-00042G-NE
 for qemu-devel@nongnu.org; Thu, 19 Jun 2025 09:14:35 -0400
Received: by mail-wr1-x42e.google.com with SMTP id
 ffacd0b85a97d-3a528243636so517959f8f.3
 for <qemu-devel@nongnu.org>; Thu, 19 Jun 2025 06:14:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1750338872; x=1750943672; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=Fteu42QoSrS1hfDvjcW70gOANYEhePCaBpCVcvmvL2M=;
 b=Do/GVJU71G8EFl0Vy02iQOZvxSQGd57JvVjKg0GJHfPVReyqmIGHNhJEtHUrTl3kHz
 D9kMKr4JBfuBmo94v3P68fLoEQ7Ue4aTczJvKCoJmJ0IAHqlTXml5h7AYsbBbWRgEi6h
 MTlYGckeIPR8dFGb57P170Cq9fI8rSK3NO8hHDe6HkCOuOV6HFlzK6TEhEc7y3hSSsk3
 pUedIlj7y7QV+00iJJqBYa0pAv0DtJSGk75AMg8I2jCUgifCrpZnPzAtNxmcQlHsDEK4
 t1a7r1yCCiXiSB9uWsMEn5V7HW8T+0R9ykwihovxK1ZRbjb5P1QWzwE+nS1Xq2oMZ1RW
 1MTQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1750338872; x=1750943672;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=Fteu42QoSrS1hfDvjcW70gOANYEhePCaBpCVcvmvL2M=;
 b=r69L8zmmbIHSqnsPPca8qhjEjJsk8LQSwqJUVoxFMPFOdEsOUzctUC03Rjm7a+Rr+t
 sV6suswROjulMXJyKgSk0DJ1/ktww9vJJEiZFUnWvuHdtiqG0olPJTci2fn4lBspsUIK
 A0OH3r4fowcV/jcrnMINGBs9v3Kf9QEc6xKceo9bUxFUdvLgAde2DJdJ23/RjGu4SBce
 wSv7MVl9NvbAqMsSM3xuTFhxMoDduSxiWpEhxoC1PRVKg4CNSiUTg9v4SzF9k9D7Hvtj
 dp995tUHeF2h2lqegp3/ayLuyglSGs2k7jQx4WpegLs0zeYCSP6cVluTwszEJ0ZrFkJA
 AlXw==
X-Gm-Message-State: AOJu0YzonC+CCAd1ouX8RK2Qi6Vt0mzPUQlNNqz2YE5sSVlom3/VPtpB
 /rM1ywq4YweudoJBnKnIdDrGfwxO50duWevJsQVbWC2dDmxUnTnRTApb7N95V+98swxJ9mhik+p
 NLxXWyCw=
X-Gm-Gg: ASbGncsSc0SF6rsxLh1lW1bDFKZlkXI1kAUuosqU8KRY4KRfTzPx/95g6d2UXFvXmlg
 CBYo40lu6WgZ3BPZxxT0/g4OzhBzmxmV0KA0tu/M/WoRc4Anp2+/DvWNt0PhO+7EfDritvmGDfG
 ceMigm7kV/qbDAN/iHxbRlrgIrgNYAc0zFEH4qxcadKWNYzyxBEcUCiy32TMBTEiRDmVw6twbgc
 VuqFf2wlnW+gbKrYsfs0byiRcNijalEfj1qAuVkqoOvnS/CGYR0ig0Z/IKbH9qxP39XoAkA12E9
 tb8m7SGRDKcs6BDqc3fy1SUPJqUAJITWkKAcHp0BNz3fX7JKvk+nWae7Lnj+cgfmTBFb6JhYs4g
 wK6D96YF2Bu01UyslH5XyirzIa2mAeca3pCxx
X-Google-Smtp-Source: AGHT+IGFsjyeXWntOOT6DxV4WwpLZcxrPw3Vv2X9REiOSlt/evxYNtcIXAR3/IHz9oPPkw1DpS+h9g==
X-Received: by 2002:a05:6000:402a:b0:3a5:27ba:47ba with SMTP id
 ffacd0b85a97d-3a572e925c6mr18063847f8f.44.1750338871833; 
 Thu, 19 Jun 2025 06:14:31 -0700 (PDT)
Received: from localhost.localdomain (88-187-86-199.subs.proxad.net.
 [88.187.86.199]) by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-3a568b1bc97sm19654066f8f.68.2025.06.19.06.14.30
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Thu, 19 Jun 2025 06:14:31 -0700 (PDT)
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
Subject: [PATCH 13/20] accel: Introduce AccelOpsClass::cpu_target_realize()
 hook
Date: Thu, 19 Jun 2025 15:13:12 +0200
Message-ID: <20250619131319.47301-14-philmd@linaro.org>
X-Mailer: git-send-email 2.49.0
In-Reply-To: <20250619131319.47301-1-philmd@linaro.org>
References: <20250619131319.47301-1-philmd@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::42e;
 envelope-from=philmd@linaro.org; helo=mail-wr1-x42e.google.com
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

Allow accelerators to set vCPU properties before its realization.

Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
---
 include/system/accel-ops.h | 1 +
 accel/accel-common.c       | 3 +++
 2 files changed, 4 insertions(+)

diff --git a/include/system/accel-ops.h b/include/system/accel-ops.h
index 44b37592d02..a863fe59388 100644
--- a/include/system/accel-ops.h
+++ b/include/system/accel-ops.h
@@ -35,6 +35,7 @@ struct AccelOpsClass {
     void (*ops_init)(AccelClass *ac);
 
     bool (*cpus_are_resettable)(void);
+    bool (*cpu_target_realize)(CPUState *cpu, Error **errp);
     void (*cpu_reset_hold)(CPUState *cpu);
 
     void (*create_vcpu_thread)(CPUState *cpu); /* MANDATORY NON-NULL */
diff --git a/accel/accel-common.c b/accel/accel-common.c
index 56d88940f92..55d21b63a48 100644
--- a/accel/accel-common.c
+++ b/accel/accel-common.c
@@ -105,6 +105,9 @@ bool accel_cpu_common_realize(CPUState *cpu, Error **errp)
     if (acc->cpu_common_realize && !acc->cpu_common_realize(cpu, errp)) {
         return false;
     }
+    if (acc->ops->cpu_target_realize && !acc->ops->cpu_target_realize(cpu, errp)) {
+        return false;
+    }
 
     return true;
 }
-- 
2.49.0


