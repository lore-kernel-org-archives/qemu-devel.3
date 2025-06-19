Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5FC0CC7115B
	for <qemu-devel@archiver.kernel.org>; Thu, 19 Jun 2025 13:18:27 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uSF5x-0003iy-0j; Thu, 19 Jun 2025 09:14:21 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1uSF5v-0003i3-7i
 for qemu-devel@nongnu.org; Thu, 19 Jun 2025 09:14:19 -0400
Received: from mail-wm1-x330.google.com ([2a00:1450:4864:20::330])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1uSF5p-0003wq-Ol
 for qemu-devel@nongnu.org; Thu, 19 Jun 2025 09:14:18 -0400
Received: by mail-wm1-x330.google.com with SMTP id
 5b1f17b1804b1-45310223677so6860385e9.0
 for <qemu-devel@nongnu.org>; Thu, 19 Jun 2025 06:14:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1750338851; x=1750943651; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=z/Q0SIuMdB5kC3di/CRNsGxXg4ReG9T7xi6w1cajMnM=;
 b=eBj8t8vv5b2ANWyKZEywvyib+LOp4FdcprNZN3nBrE26+NawCS+mK31zc9QpKDM+t4
 2HAD/rWIPwVC6e4Jh0uajoivmhyMpvXilLGORSGuD5WXxqIwecmSMCgFOA6mIknO88Ha
 jV8wH745cybTjW72jurHecsV4JV2/B/rtoSDt8iIbda22CrEAWnNvFFib39stJK79Vsw
 cqUdGC2vcK+oZQj8QYfEta2yJ/kxmJHKWOPTQuRbcstoZyjD4Y/T+ckkhkb3RnWAf8n8
 4pL+nZaRVP8UmAhDnQSlfuaahWCCLquXL3371ktiW/b1T7KFvpDlzu8Xi+yFQkkbEGGi
 4Orw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1750338851; x=1750943651;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=z/Q0SIuMdB5kC3di/CRNsGxXg4ReG9T7xi6w1cajMnM=;
 b=gP6nk+QiWOuQZZiDXKQqUajZ81DK0SBqZlaAnRTHs38Um2oH5QBD59V08BQIDdVjJc
 0RsAauUUajUQdD6BeH4jn7CI+45A6GAm6B9tKSdr3MUpRhA5lcoZEIDsa/idtHm68GAm
 nruV35NW3MKQ56SH3vLanqgqiYIfUWRlXVAZ08K6xg5RIyKieETz2VogCB9CxDjJ6Oo5
 5EjEPYhItEt7ACkUSE8tyK2Zrcz+h8a+KQNragJVkHr+EExz2SJZ1fV0800KX7dKtggT
 p1LNKZ/E6G0x1OaXSzP31nhj3mgEqYZkjnjFS6QE5GLxgJ4/SjmAgkGyvg5xE2J8zvpf
 vsQA==
X-Gm-Message-State: AOJu0YyIi/aiMdwKMgq2ylakXld9ZTy4rW4wfBsaZyr/f6N+znhI1Wz/
 WjHOZDeA0brQuIF3w5nbCxuzTNAY5My6Ywl6esxCB5B1mCsvtVvLGTUXjfaslAE4mWS4Tj1gC4L
 U70lEt0U=
X-Gm-Gg: ASbGnctIZcLbS1GJfLKQ92LUlMy8hPdLNIxW/fdD5lDbeQ3OtqDAU4MmWeMeqKq2D1C
 bDRWn1y0idT2AwEKDqbQVwCQpBKqrw3WCgytRtCSM4JuewHSZ8tsakrMQI65TPDMZv9uPi+ZdzC
 CPvsRa28ppYD93faNjiOg7bBRxfJBJ1pquD+zT4ovz54Uww0ZlDxzL5v0GBwqM+L+QxRMOmEKQ8
 STj0UDra4dxeGYSGpf7xahegwIQcPoIrKmdNZycM0zC2IGMXoO0MGUtEezXMi4UbvTA1vy2KYjD
 Jaygx84eZeHYXXv6y+6v6VfaDw6+5KdK3mSAtjQFyy9mGXWJALFLZoiJ0DIHsaZoDh/pEGh+5+H
 Pn0UMO/zbOYT9fxJJiZ8SrD9ksAUQyiLztBK/
X-Google-Smtp-Source: AGHT+IEMesaFDUXPkq9vBoDM2hPTxmREKnLlDZqzwkocsesMeu1920AjGfkyio/UWMmuivmVqCXHzw==
X-Received: by 2002:a05:6000:18a5:b0:3a4:fbaf:664a with SMTP id
 ffacd0b85a97d-3a572e6ba5bmr17438618f8f.29.1750338850782; 
 Thu, 19 Jun 2025 06:14:10 -0700 (PDT)
Received: from localhost.localdomain (88-187-86-199.subs.proxad.net.
 [88.187.86.199]) by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-45360b1ffacsm14079235e9.36.2025.06.19.06.14.09
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Thu, 19 Jun 2025 06:14:10 -0700 (PDT)
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
Subject: [PATCH 09/20] target/arm/hvf: Correct dtb_compatible value
Date: Thu, 19 Jun 2025 15:13:08 +0200
Message-ID: <20250619131319.47301-10-philmd@linaro.org>
X-Mailer: git-send-email 2.49.0
In-Reply-To: <20250619131319.47301-1-philmd@linaro.org>
References: <20250619131319.47301-1-philmd@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::330;
 envelope-from=philmd@linaro.org; helo=mail-wm1-x330.google.com
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

Linux kernel knows how to parse "arm,armv8", not "arm,arm-v8".

Fixes: 585df85efea ("hvf: arm: Implement -cpu host")
Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
---
 target/arm/hvf/hvf.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/target/arm/hvf/hvf.c b/target/arm/hvf/hvf.c
index ccdadce4766..1fbfdaed59f 100644
--- a/target/arm/hvf/hvf.c
+++ b/target/arm/hvf/hvf.c
@@ -879,7 +879,7 @@ static bool hvf_arm_get_host_cpu_features(ARMHostCPUFeatures *ahcf)
     hv_vcpu_exit_t *exit;
     int i;
 
-    ahcf->dtb_compatible = "arm,arm-v8";
+    ahcf->dtb_compatible = "arm,armv8";
     ahcf->features = (1ULL << ARM_FEATURE_V8) |
                      (1ULL << ARM_FEATURE_NEON) |
                      (1ULL << ARM_FEATURE_AARCH64) |
-- 
2.49.0


