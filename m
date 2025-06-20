Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9DA64C7115C
	for <qemu-devel@archiver.kernel.org>; Fri, 20 Jun 2025 13:14:29 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uSbUO-0004zK-2b; Fri, 20 Jun 2025 09:09:04 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1uSbUM-0004qz-4r
 for qemu-devel@nongnu.org; Fri, 20 Jun 2025 09:09:02 -0400
Received: from mail-wm1-x32d.google.com ([2a00:1450:4864:20::32d])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1uSbUK-0004rM-HF
 for qemu-devel@nongnu.org; Fri, 20 Jun 2025 09:09:01 -0400
Received: by mail-wm1-x32d.google.com with SMTP id
 5b1f17b1804b1-453643020bdso7372055e9.1
 for <qemu-devel@nongnu.org>; Fri, 20 Jun 2025 06:09:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1750424939; x=1751029739; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=CoTleeCUcvYndolgWSxVbjuEBw5fGt+mb1nmRFlbWPU=;
 b=mBg6BDuSLoM/9bBw8W1CXSnhPh94g99ThxjB5mnc+Uue+cN52rZKqTcHP232JtvVHL
 Vp6OqGteV4WRshLbylhOoEbGMc4Fb6gTevp1ADD7goLBIRcQMB3zHIoZki5vAtbcXIGn
 mK+hKGkl/OxTZJHR1Uniw70Khpm7t+a/ORtEPe8gAsU3zLfWRMrdFELsAzggiuXlcc9E
 zJkegCUbnBH+ZMeak7AxASlTjSlhlTnYzuusJhYby8Gcb+pv6lg8S51isL5j3mD+X9j2
 1hjRkTebsV9h80TnPxSr/bYcwmzRevluSwvWB+QPnGquWp9cQ5aKTy1C5I3pn71aBd+Y
 El6A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1750424939; x=1751029739;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=CoTleeCUcvYndolgWSxVbjuEBw5fGt+mb1nmRFlbWPU=;
 b=ovrLOYR1EVDs+jiTtv8uvaL2sICWrSimezjuuYcsbIzd1rCRGp6FwuCyP5ukWWsuA6
 x9AQ1z81Up//VF72GlWxV6qwTfXtPBdeRHsZWq23wOEACl82w3Wk4efcf0Tnc3Z0ovzF
 WYf1wOjY80ySwRBq9rDmBAWwZRS1Jcmqe/ifFzRv82aaMCDEdh21ImF08CtW4E0mtDLC
 6OYixA2VPPhUMpvXPcRoA/091fiBSYpFkSJ3RojiXHJFrVBZkWRQzDQusP6zABKjWvzZ
 SRwVBZAHcARwvL6+HIjk1OlDKKaFtc0FKfnh/lpbnVta6cgKtMO1NDAeFKuNI8b/Vqr3
 BIQA==
X-Gm-Message-State: AOJu0YzGwH/cvA8Y5AByfFn4F3Eo4HrC7Yx9M6jXMensOeZgaTWweWHN
 HMOHRXbhpdOSUDKM9AiK9w48bQMppnD+DDgDxr+IQdDkyHk7oRlj6ZYnn0+6fByfEU5i0l184Xj
 CJBe80n4=
X-Gm-Gg: ASbGnctwIXI2QNipMl0XSyNeRhoJ2RXty1Uax68nEc+NjpguUrVbsdxpn9ba5QGfI4j
 +COqrvh9BtuYseX1HSo8Dd6Sa4wJ5IxHl++1IKgUbEFXzhC0CFqgsOQy7O3HbkExag7Im3qnteG
 YoMRQgmMg9W3HJcnr6jEfgJTw7UwIKsGnql3nS8GeVg5tJnt9Ls03JWTJh4EneOnpySPLjNXo3O
 UMKqRTmJkTJSfa8K91GmwPcnvUtT3GHMjAF0sBCxB0qYcQFqDOOrnSvIx7BFjX5O2qkiTqOhmKb
 yv+Ch9wCcByEtt6lXh9/6WjRfFFPz3uhnZqnrtV7DMdGWAp1lvGGT0n2tn3kRMcjWoqwheEwK7a
 8Saem1h+A0nuAgOgXqIgFZcKQXHrckXdJFxl//mDmZphm7Ko=
X-Google-Smtp-Source: AGHT+IGuIbYoqiAUyyTvRzRx4XiSdr/lFqQmEELQqzVAO0UNUSoo47/0fUF0+MkjrXr0XzUJRZQK0w==
X-Received: by 2002:a05:6000:3103:b0:3a5:58a5:6a83 with SMTP id
 ffacd0b85a97d-3a6d13013eemr2649039f8f.13.1750424938708; 
 Fri, 20 Jun 2025 06:08:58 -0700 (PDT)
Received: from localhost.localdomain (88-187-86-199.subs.proxad.net.
 [88.187.86.199]) by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-3a6d1192680sm2076203f8f.95.2025.06.20.06.08.57
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Fri, 20 Jun 2025 06:08:58 -0700 (PDT)
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
Subject: [PATCH v2 19/26] hw/arm/virt: Only require TCG || QTest to use
 TrustZone
Date: Fri, 20 Jun 2025 15:07:02 +0200
Message-ID: <20250620130709.31073-20-philmd@linaro.org>
X-Mailer: git-send-email 2.49.0
In-Reply-To: <20250620130709.31073-1-philmd@linaro.org>
References: <20250620130709.31073-1-philmd@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::32d;
 envelope-from=philmd@linaro.org; helo=mail-wm1-x32d.google.com
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


