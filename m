Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3EBE8C71155
	for <qemu-devel@archiver.kernel.org>; Fri, 20 Jun 2025 13:08:05 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uSbT2-0002O3-O1; Fri, 20 Jun 2025 09:07:40 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1uSbT0-0002Mw-Cp
 for qemu-devel@nongnu.org; Fri, 20 Jun 2025 09:07:38 -0400
Received: from mail-wr1-x431.google.com ([2a00:1450:4864:20::431])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1uSbSy-0004WZ-QT
 for qemu-devel@nongnu.org; Fri, 20 Jun 2025 09:07:38 -0400
Received: by mail-wr1-x431.google.com with SMTP id
 ffacd0b85a97d-3a375e72473so862902f8f.0
 for <qemu-devel@nongnu.org>; Fri, 20 Jun 2025 06:07:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1750424854; x=1751029654; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=i7X9qE0A0zkH5gg9YDfRhHn13dFLj9D3tYtyAnJR94U=;
 b=RriqMD/7m9gtm3lFIfhojDFxFLhIvvtHSX8TKcO/jpQmHX7brYioAzj7WxlHNYNzUT
 GG9VUtZbLYYXzWsl3v0eyylhe+s7KZgqrDeVWmYodc26h4LIv8QJ3qr6owflIfJye8OO
 prK6aFGSYE6mwjyENP/adObTInGfxW6zOizt3S28CAgCk1VGcpeA/jNeTCEbYzhVUCNl
 CtF35ywrtn73UGMD9Dyv5JeIaEE9cywQqLhoJXFnoo8Bn3Y9IW0jwr5IqrQE4AZzjrgl
 BH5sxeRGm7UWEWidv39NI97arNy0EY3gv96zvINpU2pLBGPXhMCnM0hPwi8Hn676Jmwq
 Z+MQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1750424854; x=1751029654;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=i7X9qE0A0zkH5gg9YDfRhHn13dFLj9D3tYtyAnJR94U=;
 b=WHyMqjHgV/TOvFCSiHAvmBfCmdEvHjZbJ6g53N6ZkbopRp+wrYzH0WQUdx93W5Pkbv
 RfTX7uK+L6VQr5vzYmlFY/4XfKPCOMBk4bTkRTKiiE+ARvUSZ55tDL5i3jnQol6k4l/r
 EaqoEiTCiqmPNSKwsyhDnZZEBvqyfwb4QuRQ5Yu6LYC2u4pKG/4jcXDuOSg/fxiaBBs/
 z/q7oakXrWDXWG6Eeo3E4Z0P0EGm9R0D+qVfspk3VLwnkPzWGk8U+eYt7aBJRJuU+SQy
 NcI4o3bjyxi+IUy4e+Un7eK0KkdTFqe80pILxXHtiu44T/Ocx/NXMTc4SsvYQmFJhT87
 idiA==
X-Gm-Message-State: AOJu0YyVAnJFXvYOEEZg9mu4mlkBsQK5Mj2HMJ3hU/ek+9upa9OLiUnx
 t+ooJzjnyBdPUi7F1V0HX8wMUuDg6JtGYPN2HKPGvQg+q4EFZVbUPbkLliueqVHB8p6/SXy8nww
 Q3lh3wTc=
X-Gm-Gg: ASbGncsFLxdnoQH3hugXhwuY9sSn2gb02whP7EtXr+JdZp1yqIbA1jVTo4iSiEIYYEJ
 xgInC7x8n8FIHS70p9nTsA7x0owyIUM1+3kp5scwxS9S2jgfJf2Kygk6w1m8hYNVrFPsxS1z03i
 LQ2oWgklkgq3wL3wZQw5fF6oCKvt26xJzLKiupzh5a+VFC0q6EvdvXihXCP8+WTMWg4f3YRq4Vk
 +7L+89D13+qp8P08TgwKzLAkIhgtxBftAZkAtiThMHD1MNS2MELd9uIX0gRSISfHl3eDNQ1csRg
 xp/yEZdax7rCv26ciBxdVy7rO4stZ/Dnv0t6cqBbfivHQiKcO3ZUci0bPP3dVY7CdO4KzOqWkcQ
 2zDnOHnjzXecxIPW3ywRDMk6ED4ecEzn6NATqFwj0dGfwOQA=
X-Google-Smtp-Source: AGHT+IG8MOa1mgx5GRJT2pi7G8sTIbJ7uQF1KFg+Pl8xxcjdSw3j34E0kQi1ej0Od+hgqLrB/UqKrg==
X-Received: by 2002:a05:6000:4715:b0:3a5:2923:7ffa with SMTP id
 ffacd0b85a97d-3a6d1193fd2mr2532616f8f.7.1750424854370; 
 Fri, 20 Jun 2025 06:07:34 -0700 (PDT)
Received: from localhost.localdomain (88-187-86-199.subs.proxad.net.
 [88.187.86.199]) by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-45364703f1esm25142395e9.32.2025.06.20.06.07.32
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Fri, 20 Jun 2025 06:07:33 -0700 (PDT)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
To: qemu-devel@nongnu.org
Cc: Leif Lindholm <leif.lindholm@oss.qualcomm.com>,
 Richard Henderson <richard.henderson@linaro.org>,
 Radoslaw Biernacki <rad@semihalf.com>, Alexander Graf <agraf@csgraf.de>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Paolo Bonzini <pbonzini@redhat.com>,
 =?UTF-8?q?Marc-Andr=C3=A9=20Lureau?= <marcandre.lureau@redhat.com>,
 Phil Dennis-Jordan <phil@philjordan.eu>,
 =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>,
 Bernhard Beschow <shentey@gmail.com>, Cleber Rosa <crosa@redhat.com>,
 Peter Maydell <peter.maydell@linaro.org>,
 Cameron Esfahani <dirty@apple.com>, kvm@vger.kernel.org,
 qemu-arm@nongnu.org, Eric Auger <eric.auger@redhat.com>,
 =?UTF-8?q?Daniel=20P=2E=20Berrang=C3=A9?= <berrange@redhat.com>,
 Thomas Huth <thuth@redhat.com>, Roman Bolshakov <rbolshakov@ddn.com>,
 John Snow <jsnow@redhat.com>
Subject: [PATCH v2 04/26] target/arm/hvf: Simplify GIC hvf_arch_init_vcpu()
Date: Fri, 20 Jun 2025 15:06:47 +0200
Message-ID: <20250620130709.31073-5-philmd@linaro.org>
X-Mailer: git-send-email 2.49.0
In-Reply-To: <20250620130709.31073-1-philmd@linaro.org>
References: <20250620130709.31073-1-philmd@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::431;
 envelope-from=philmd@linaro.org; helo=mail-wr1-x431.google.com
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

Only update the ID_AA64PFR0_EL1 register when a GIC is provided.

Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
---
 target/arm/hvf/hvf.c | 14 +++++++++-----
 1 file changed, 9 insertions(+), 5 deletions(-)

diff --git a/target/arm/hvf/hvf.c b/target/arm/hvf/hvf.c
index 42258cc2d88..c1ed8b510db 100644
--- a/target/arm/hvf/hvf.c
+++ b/target/arm/hvf/hvf.c
@@ -1057,11 +1057,15 @@ int hvf_arch_init_vcpu(CPUState *cpu)
                               arm_cpu->mp_affinity);
     assert_hvf_ok(ret);
 
-    ret = hv_vcpu_get_sys_reg(cpu->accel->fd, HV_SYS_REG_ID_AA64PFR0_EL1, &pfr);
-    assert_hvf_ok(ret);
-    pfr |= env->gicv3state ? (1 << 24) : 0;
-    ret = hv_vcpu_set_sys_reg(cpu->accel->fd, HV_SYS_REG_ID_AA64PFR0_EL1, pfr);
-    assert_hvf_ok(ret);
+    if (env->gicv3state) {
+        ret = hv_vcpu_get_sys_reg(cpu->accel->fd,
+                                  HV_SYS_REG_ID_AA64PFR0_EL1, &pfr);
+        assert_hvf_ok(ret);
+        pfr = FIELD_DP64(pfr, ID_AA64PFR0, GIC, 1);
+        ret = hv_vcpu_set_sys_reg(cpu->accel->fd,
+                                  HV_SYS_REG_ID_AA64PFR0_EL1, pfr);
+        assert_hvf_ok(ret);
+    }
 
     /* We're limited to underlying hardware caps, override internal versions */
     ret = hv_vcpu_get_sys_reg(cpu->accel->fd, HV_SYS_REG_ID_AA64MMFR0_EL1,
-- 
2.49.0


