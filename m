Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 41590C7115B
	for <qemu-devel@archiver.kernel.org>; Mon, 23 Jun 2025 12:23:47 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uTg8q-0001Jp-6M; Mon, 23 Jun 2025 08:19:16 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1uTg8n-0001Iv-9T
 for qemu-devel@nongnu.org; Mon, 23 Jun 2025 08:19:13 -0400
Received: from mail-wm1-x32e.google.com ([2a00:1450:4864:20::32e])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1uTg8l-0000ST-5P
 for qemu-devel@nongnu.org; Mon, 23 Jun 2025 08:19:12 -0400
Received: by mail-wm1-x32e.google.com with SMTP id
 5b1f17b1804b1-451dbe494d6so47691665e9.1
 for <qemu-devel@nongnu.org>; Mon, 23 Jun 2025 05:19:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1750681148; x=1751285948; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=LDQM9sk8xLoIDxyTCgc//1G3alM8o04T+fdq/t3mMdE=;
 b=R+2WfNtRk1CAxJ7DwUKLdNlJVU9K9STWmmg+bZ10jVMxfsXz3Ezk86d8MwVRSke/ix
 cdG5Eg4AcFP8IOeau3IGuuiVxy/QiF1C0byp4aFchexTt7sve8rengM9mGwkUgYZCGJc
 VhxCmWuZfwdXzorkOB0jNBHulEqMs5m7Dk4AqBAw0RTaOvdVryl2CUyDFwZqS65ssZ+s
 HrY9vjnt0IcwlKyVFV04V2NNnGjVADlGxuW/JBRydBNH5/ubwzpqIxlZ0cUMIpx9+XU1
 NhDbTde+232NYMe3yzl/H0d7KbAM+Aodb+byYsfYb+O5xP9DyBwwicvIBR9YrFa5f0RC
 Oh9A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1750681148; x=1751285948;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=LDQM9sk8xLoIDxyTCgc//1G3alM8o04T+fdq/t3mMdE=;
 b=hvXw1GYd6azonYlxmq38rVYh2s3wvm0Bwvaq6HEs4xg3iHa139xGRS1hEPRZ//kOfi
 3NJaLLHHAni/PQI+o5f1E1y7dTDrv/NkaIUsNUj/temSHIARm1LJbYNyHNKPvhyt/dEs
 CXblb/zJpQP16N1J+Y4M/rGl/w5wDa7jA4SEmlqvwPU5X5tuyk6L+nYMgg76eZv7CSGk
 7TGuMrPvkm3ZS6AAEqlS7Z5jc0JwEZa7u/DxTI7nAxB+x9nK0fNMmUYTwI5EUXudyRUg
 /ufz0kbLyvvCBh7u0UGbcARMCkGzwkxo6EnGdMynv8E1TtcWXC0B/gBZ1IUNV8F+z8br
 s52g==
X-Gm-Message-State: AOJu0YwebJCVxr0p3C7dhJ42jnpL/sBdz6I9vxtum+UBTY2T9rcWoQx0
 nd1bWxPhnIY+1xCSnWLmITo5XKQrq96nNdu2RToV7fArre3uyh2J74R3DAt901q2nh4Phs+cAJW
 iKG4c
X-Gm-Gg: ASbGncsbLQgzDB3YlN8ZT5TXLvmgQ5J3niR0JYmkbideYpzcmFuthr6L/P3CBhiLSSF
 09eJB72ATpz0CgwIVi6bMDBqNWFC6gwN37nQz3G4gWmlQZuP1FwcZsWt4znZqASrEyuafshgleU
 3B8Y8/vBg11yQODFwUa03hIPpR499Jl3cP/vWr+tBlACwifDekTBwC1Cg0KmFTIZO5lvYXPH2lt
 PBosoM0nEh4tXwckXuIzj4bkMsexPY9Z7+Z8JGIpcUKRK1lfWHriOUB0L23vwUDT7okpOsH6wUF
 1mIWW204XZA5iSeB1PI8cTLh5RJTWW2EyfqB1SNDAnqjK22sPPzcWcINkJUMfYiaIgMtxMuIuui
 4w2cc2bKjN8biv080R1XzOzKEc9F1QRQRSjY0
X-Google-Smtp-Source: AGHT+IEEGQ2yizNQOBV9T6BfrGjeWcpsEH+4yJg0Dp41EHihRocLWjYUthkP7XbX59/zuaabZ4ahQw==
X-Received: by 2002:a05:600c:c172:b0:442:f4d4:522 with SMTP id
 5b1f17b1804b1-453660d7e3fmr109375695e9.5.1750681148220; 
 Mon, 23 Jun 2025 05:19:08 -0700 (PDT)
Received: from localhost.localdomain (88-187-86-199.subs.proxad.net.
 [88.187.86.199]) by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-453646fd7aasm108543505e9.20.2025.06.23.05.19.06
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Mon, 23 Jun 2025 05:19:07 -0700 (PDT)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
To: qemu-devel@nongnu.org
Cc: Leif Lindholm <leif.lindholm@oss.qualcomm.com>, qemu-arm@nongnu.org,
 =?UTF-8?q?Daniel=20P=2E=20Berrang=C3=A9?= <berrange@redhat.com>,
 Roman Bolshakov <rbolshakov@ddn.com>, Paolo Bonzini <pbonzini@redhat.com>,
 Alexander Graf <agraf@csgraf.de>, Bernhard Beschow <shentey@gmail.com>,
 John Snow <jsnow@redhat.com>, Thomas Huth <thuth@redhat.com>,
 =?UTF-8?q?Marc-Andr=C3=A9=20Lureau?= <marcandre.lureau@redhat.com>,
 kvm@vger.kernel.org, Eric Auger <eric.auger@redhat.com>,
 Peter Maydell <peter.maydell@linaro.org>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Cameron Esfahani <dirty@apple.com>, Cleber Rosa <crosa@redhat.com>,
 Radoslaw Biernacki <rad@semihalf.com>,
 Phil Dennis-Jordan <phil@philjordan.eu>,
 Richard Henderson <richard.henderson@linaro.org>,
 =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>
Subject: [PATCH v3 04/26] target/arm/hvf: Simplify GIC hvf_arch_init_vcpu()
Date: Mon, 23 Jun 2025 14:18:23 +0200
Message-ID: <20250623121845.7214-5-philmd@linaro.org>
X-Mailer: git-send-email 2.49.0
In-Reply-To: <20250623121845.7214-1-philmd@linaro.org>
References: <20250623121845.7214-1-philmd@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::32e;
 envelope-from=philmd@linaro.org; helo=mail-wm1-x32e.google.com
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

Only update the ID_AA64PFR0_EL1 register when a GIC is provided.

Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
Reviewed-by: Richard Henderson <richard.henderson@linaro.org>
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


