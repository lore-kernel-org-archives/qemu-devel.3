Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0986CCA0FF2
	for <qemu-devel@archiver.kernel.org>; Wed,  3 Sep 2025 10:16:22 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1utkX6-0008TB-Os; Wed, 03 Sep 2025 06:16:04 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1utkX2-0008Rj-Jx
 for qemu-devel@nongnu.org; Wed, 03 Sep 2025 06:16:03 -0400
Received: from mail-ej1-x634.google.com ([2a00:1450:4864:20::634])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1utkWv-0002fp-LE
 for qemu-devel@nongnu.org; Wed, 03 Sep 2025 06:15:55 -0400
Received: by mail-ej1-x634.google.com with SMTP id
 a640c23a62f3a-b042cc3954fso484351066b.0
 for <qemu-devel@nongnu.org>; Wed, 03 Sep 2025 03:15:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1756894551; x=1757499351; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=hBqK3PCTcJsYs4YDyMLp+uvoaCcL2zuVRl4bWVmO6DI=;
 b=k8suWKvpMC/u9/lyJU3iywXZZSIVG7H8+y8yELh55b6jK81YOMpEeM1UQ093Y5ilbt
 ktBOOlg1bGkHGRra//ZGRPbGJWu3O+OvFUFOIK8shBcQ5zMyNMJY9PVpg0NQ+SA4cgPL
 Oe/Uhb6I90WYv8AVqmy/z9c8ok/DFWnWKtPyshA62KBgxO3iHhlvLBTrNWiZljlmkT5/
 3Y9ReP0jpZzITGDUJz4O4KmLRCr4OndmRoAQRgza3tlXkf9xauad7OZyEJIL4YdeZO6X
 2YEmcPZ/7+nlAj/8LuGjqGyjpcK0c23dg3c2h3nE1/s3VSBVwNkEmpLAPkXLT7gW9M66
 CVJg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1756894551; x=1757499351;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=hBqK3PCTcJsYs4YDyMLp+uvoaCcL2zuVRl4bWVmO6DI=;
 b=YIgCU27HIVTr/dmq2h5jd0jNIs/OHnOSU13KX7J+NKI1zx8mjcX6/n6mWUw4R4ORMH
 b5S5vfW99hKHga3t9cx6GnwhF6sX/Do+dqIbyZjYzwvblooDd28OZknOi6hB50CeAv6F
 UYsIi6pqJHhCIiKFDUVddCoeMgvGh5WhHAohJDRA5EvGBP8JI4EYQPvGkG0XHI/CWxH4
 txsWDdAphwz0t5tpNX2Rl6MQMuqtAnHAqR9hco96rRW+xO7KrmUvlXjGRt3kY0kmKZDE
 9U4thgYsZQRINKZXtebC+/hjT+CRXzgVmzbRlsqkqsRthaDBzC39tXy8LyGJMVKuXP+L
 YDFQ==
X-Gm-Message-State: AOJu0Yy/ge2zsHHrafa4C5rWFtp9ULxgcgxQN856z65L4uednyvQzBVe
 MNt3r04fiu384/Gh9MtIrPa5Ot3FdeFUFFv0qCIvo8uhyNJeXVHvZdXpR9CJLzAloYQ+DyHnV/7
 04428Xjg=
X-Gm-Gg: ASbGncvL5tFVKwsp76Hi5gb8VRhtVOQ5ba3bFo0u7OwGr7U1vdraRvaGFsplp1b0UWE
 DMzSu6vETLKI1vMDRzvUuTnsSa/i/Cl9DpHdrDRlcN9fkOPYAKyckmp3MGf/EQs5g4PwjwW+ZfX
 CfcjOQCYYVeYhjozqCL+we2KUhl6OmIGWDOkczsr9W4LWptrKvkbfxm2CINn+g2Okch22W0c16C
 GSBg4lLIZx2zTb/bcLCIEZ+HEbDCZ98qfnpdSoGE/gnt0VZn/+5cJWfzrNdDPNeM3NGCTbg1DKN
 poMLr8etXYQelaEQducdPX60/CFExynrvtoBpahwLs4UzA5LFnsJ6ZLMhSgh8qIQbGrcQVHpcfX
 iYKRI6+RrAbKkIPdRfftFplOGUyLO9uKhp1x74lvkdDydQQAlW9XETswOLVpxvHD9G4NRYcEGA1
 iKZc3uiEQR+Hi56VkO
X-Google-Smtp-Source: AGHT+IEXvE2yxE0eDhnAD6kxIdMImk21KxggNU91CQLDrZPd5R3xnOfh9naqqPreTPYWWMr0eKNeaw==
X-Received: by 2002:a05:6000:1a8e:b0:3dd:26b7:2838 with SMTP id
 ffacd0b85a97d-3dd26b72bd7mr1317336f8f.4.1756894121345; 
 Wed, 03 Sep 2025 03:08:41 -0700 (PDT)
Received: from localhost.localdomain (98.red-88-29-180.dynamicip.rima-tde.net.
 [88.29.180.98]) by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-3cf33fb9cebsm22884059f8f.46.2025.09.03.03.08.39
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Wed, 03 Sep 2025 03:08:40 -0700 (PDT)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
To: qemu-devel@nongnu.org
Cc: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Alexander Graf <agraf@csgraf.de>,
 Richard Henderson <richard.henderson@linaro.org>, qemu-arm@nongnu.org,
 Mohamed Mediouni <mohamed@unpredictable.fr>,
 Peter Maydell <peter.maydell@linaro.org>, Mads Ynddal <mads@ynddal.dk>,
 Phil Dennis-Jordan <phil@philjordan.eu>,
 Stefan Hajnoczi <stefanha@redhat.com>, Cameron Esfahani <dirty@apple.com>,
 Roman Bolshakov <rbolshakov@ddn.com>, Paolo Bonzini <pbonzini@redhat.com>
Subject: [PATCH 09/24] target/arm/hvf: Mention hvf_sync_vtimer() must run on
 vCPU thread
Date: Wed,  3 Sep 2025 12:06:45 +0200
Message-ID: <20250903100702.16726-10-philmd@linaro.org>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <20250903100702.16726-1-philmd@linaro.org>
References: <20250903100702.16726-1-philmd@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::634;
 envelope-from=philmd@linaro.org; helo=mail-ej1-x634.google.com
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

Since hvf_sync_vtimer() calls hv_vcpu_get_sys_reg(),
which must run on a vCPU, it also must. Mention it.

Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
---
 target/arm/hvf/hvf.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/target/arm/hvf/hvf.c b/target/arm/hvf/hvf.c
index 05fc591b523..a7e4b869b04 100644
--- a/target/arm/hvf/hvf.c
+++ b/target/arm/hvf/hvf.c
@@ -1889,6 +1889,7 @@ static void hvf_wfi(CPUState *cpu)
     hvf_wait_for_ipi(cpu, &ts);
 }
 
+/* Must be called by the owning thread */
 static void hvf_sync_vtimer(CPUState *cpu)
 {
     ARMCPU *arm_cpu = ARM_CPU(cpu);
-- 
2.51.0


