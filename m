Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5A8DEC7115B
	for <qemu-devel@archiver.kernel.org>; Mon, 23 Jun 2025 12:23:20 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uTgA9-0002q6-Ge; Mon, 23 Jun 2025 08:20:37 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1uTg9y-0002K4-BR
 for qemu-devel@nongnu.org; Mon, 23 Jun 2025 08:20:26 -0400
Received: from mail-wm1-x333.google.com ([2a00:1450:4864:20::333])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1uTg9u-0000xb-Gu
 for qemu-devel@nongnu.org; Mon, 23 Jun 2025 08:20:26 -0400
Received: by mail-wm1-x333.google.com with SMTP id
 5b1f17b1804b1-453647147c6so30958585e9.2
 for <qemu-devel@nongnu.org>; Mon, 23 Jun 2025 05:20:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1750681220; x=1751286020; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=CoTleeCUcvYndolgWSxVbjuEBw5fGt+mb1nmRFlbWPU=;
 b=T22vsVJtPH2TQZHCJLNniO58sS4ILvl5t8W0ISHEHsySk4n3cbNxzFC13HTVuTAtbf
 Eep8YdccSSRcOwFpaGUlO8cRuKfdsGMjKDs+rgxpdQVzv81ylQV+n+VRZCwL2s9HbUQp
 wHqrlmYrTWcFy0l2vRqgQEwJxyyLSimKp+ygQmjT2smSRh1LG8sNGEC887+ZAL7xkp6h
 VJAN4fpw9I0vdApbWrRitJJx69/RI/3qfqcwmQ1mSLOP30libozLuQKeSAxIxhlS4LXy
 bOCvFTGxiClCNYUVBAYXi/UFxcxBBR1pynEDgSGJOrEpcBjyLaCSqxADkleykbF5qHGX
 jH/A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1750681220; x=1751286020;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=CoTleeCUcvYndolgWSxVbjuEBw5fGt+mb1nmRFlbWPU=;
 b=EBQtYrRwuhbrnTFGeFB2CZQylB5TfAajJV8DiRsFOka12Gt2oDAeqcF2h1GGXDk6Ir
 EGqLcVqv04TwkzDXGkkoDSYcM2An3G4Nnz2HYkyL7vQYJW30ZQR69mC0VGN7PkgG5QyR
 njQ0oT/heNsM1+P4OMQKJLQVH7heQc3QuReu9PetvpvyUE8wL4XVv/RPUj7bilXbObb4
 dViyXTdE2Xkg3cmj5v5x9TvzS634IwjPflaLxci9OWmPmiO+wWZvpmHkzU3E6GzZqgQu
 WD7T+wfwPFqlgkJzVCL4HNV1moLMXUQIktXb0b8BNkTUngShLbdh9w2EDk/yh32kmVqA
 LNcQ==
X-Gm-Message-State: AOJu0YwJ/Njkz178YJL9fv2RZUoUz0C6m7PV0w9qx824B2PYdYZjS2/5
 WtUAGl31X1HIZBREaDde3J7lL52RfefbGIQYbMJ6XLGnksP5QbmZgKjsyk8rYY72U/+vnbjLAEj
 sLUQl
X-Gm-Gg: ASbGncsr9bt+saqGVE5Q7ArDVkZ9g06ylbvNlE4qXN1IcCP6jHGvm55pl/eXs0x8Y4m
 WIDSOigxez9pB5Kfz+mxfhLK2QTrxp+GYZgMyD7TxW//AWVnjUBqgrLaISH1c+NR//Mf+UuVpEB
 JYt49+YUzCRJpNVoPPlhb/fp/WitXG4zKHxuRM7u7+XNMcUwjeaMdQBWjMclAJ7a1g3VD5X7x4e
 9+YIntnUlk4CZQFp2np+1m+Hu/5PTBagqdYA4DtALMDN8VWOHzw+m3C2fv8rEK1yIw8gz4z5Xcr
 WzU6fw2YJZyZQg507+7mZoTubu+8St/3ItP1CFJk0Kj9P/uHLylAlqdbpTWR46e2ZC9RPusTU3a
 j84DhtZujGVayPdRndSsdQVBhAlDFTZJeZd0pM8L98k8Yju8=
X-Google-Smtp-Source: AGHT+IFBHJwLkEEc6nlf5I87v2Hc8Cpzzh5zV8wh3kfSp+SDxvF8pOTvTMZ84BVKQcVmti0UNd5Jng==
X-Received: by 2002:a05:600c:a345:b0:453:58e8:a445 with SMTP id
 5b1f17b1804b1-453654cb7bemr101468665e9.11.1750681219792; 
 Mon, 23 Jun 2025 05:20:19 -0700 (PDT)
Received: from localhost.localdomain (88-187-86-199.subs.proxad.net.
 [88.187.86.199]) by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-453647071f4sm109685435e9.34.2025.06.23.05.20.18
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Mon, 23 Jun 2025 05:20:19 -0700 (PDT)
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
Subject: [PATCH v3 18/26] hw/arm/virt: Only require TCG || QTest to use
 TrustZone
Date: Mon, 23 Jun 2025 14:18:37 +0200
Message-ID: <20250623121845.7214-19-philmd@linaro.org>
X-Mailer: git-send-email 2.49.0
In-Reply-To: <20250623121845.7214-1-philmd@linaro.org>
References: <20250623121845.7214-1-philmd@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::333;
 envelope-from=philmd@linaro.org; helo=mail-wm1-x333.google.com
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

We only need TCG (or QTest) to use TrustZone, whether
KVM or HVF are used is not relevant.

Reported-by: Alex Bennée <alex.bennee@linaro.org>
Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
Reviewed-by: Richard Henderson <richard.henderson@linaro.org>
---
 hw/arm/virt.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/hw/arm/virt.c b/hw/arm/virt.c
index 99fde5836c9..b49d8579161 100644
--- a/hw/arm/virt.c
+++ b/hw/arm/virt.c
@@ -2203,7 +2203,7 @@ static void machvirt_init(MachineState *machine)
         exit(1);
     }
 
-    if (vms->secure && (kvm_enabled() || hvf_enabled())) {
+    if (vms->secure && !tcg_enabled() && !qtest_enabled()) {
         error_report("mach-virt: %s does not support providing "
                      "Security extensions (TrustZone) to the guest CPU",
                      current_accel_name());
-- 
2.49.0


