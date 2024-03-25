Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 85E54C54E58
	for <qemu-devel@archiver.kernel.org>; Mon, 25 Mar 2024 13:35:36 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rokSE-0002dm-P3; Mon, 25 Mar 2024 09:33:35 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1rokS8-0002Z6-Ql
 for qemu-devel@nongnu.org; Mon, 25 Mar 2024 09:33:29 -0400
Received: from mail-wm1-x329.google.com ([2a00:1450:4864:20::329])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1rokS6-0007MV-1p
 for qemu-devel@nongnu.org; Mon, 25 Mar 2024 09:33:28 -0400
Received: by mail-wm1-x329.google.com with SMTP id
 5b1f17b1804b1-4148c607f31so627475e9.0
 for <qemu-devel@nongnu.org>; Mon, 25 Mar 2024 06:33:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1711373601; x=1711978401; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=vr/+Morh4LGFnprtkK6/DvsiuzOF19rNj0hIhqL5OAo=;
 b=xm5WvVT86UmmiSruPKgvLpQVLZ5a3Tjk95kVLYdHenbXU7tQQo2fDmzpIarGQ3TcCE
 xK//4Aw3cLSQXwx9omv2xCZffOlomtXeC6Aq+Oft8Qsmfi1Q68KEgV38x27NTxHKD/uw
 au/E3rwOUC82tbBdcho+97rPb+LUJJy721rFqowZ3xRjgrUi1Xz+gEkH6FREOj1hYvHe
 MnzKTzodMpp/66bGxM1ifhNaVp3IOSQMrpg4SebTBYlh4OOhIeu3CDk8o2e8sCpTm868
 fIEEHv/G1mB5m6fAqal5S9aRIxiPAfVRDD8gvg7MegdV+qzkdr6uWzQUJ2eaZ5KVJlEi
 4CfA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1711373601; x=1711978401;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=vr/+Morh4LGFnprtkK6/DvsiuzOF19rNj0hIhqL5OAo=;
 b=FiDTi1l+fpLjKxlV/+0WKdHso/vBmEJm05blI4FMgwaUJi1MCKEy7FEKerdINUYe04
 PR+mdDjvrkTrh+kcr4TwqjQ+NtKo9ak1TtPqyqkd33u/dFdIKDohzvpP5C/2OGDYfO3v
 fmKIn+Ytv8RGLk3TvUDVhiMlMQNsXS1q1c9ezZyUs7V6ha45D+cbjlZP14RhxbiNOWLJ
 X/GDPCwo+hhdlq5K2S4nN6xxReYtXwvzp0Q/Ul3TqtqpiFJblmsJgn1MhFUiicTqt75W
 uvcEgOqIOmkYvsYbQZ7ZnAw75FMC3Yri9T/p3dWFNX3ZBIKZOnmfRhbtBHZefPoFiTLJ
 tvdQ==
X-Gm-Message-State: AOJu0YxC+Aw627jrtGZpD8kRKdf/sScBIWXE0nmL0f4O3d+zpanoah/L
 J5UkZMaoBSMM6xVwbPhiDlAzmSw19MQyjP5793JJ8eJdDGg9RPe8QXxXleZvH9RDrgK0/RzhP09
 6zdU=
X-Google-Smtp-Source: AGHT+IHLrDX/f70I7ieYuVUXsWtRYe4M2VbmiiIjJv2RHwqlDdHuNwVpWqwk8W0KZ1mkCbKSgT+8cg==
X-Received: by 2002:a05:600c:56ca:b0:412:f572:5318 with SMTP id
 ju10-20020a05600c56ca00b00412f5725318mr5388419wmb.11.1711373601371; 
 Mon, 25 Mar 2024 06:33:21 -0700 (PDT)
Received: from m1x-phil.lan ([176.187.208.214])
 by smtp.gmail.com with ESMTPSA id
 g14-20020a05600c310e00b004147ec48845sm8405542wmo.26.2024.03.25.06.33.20
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Mon, 25 Mar 2024 06:33:20 -0700 (PDT)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
To: qemu-devel@nongnu.org
Cc: =?UTF-8?q?In=C3=A8s=20Varhol?= <ines.varhol@telecom-paris.fr>,
 Arnaud Minier <arnaud.minier@telecom-paris.fr>,
 Damien Hedde <damien.hedde@dahe.fr>, qemu-arm@nongnu.org,
 Peter Maydell <peter.maydell@linaro.org>,
 Alistair Francis <alistair@alistair23.me>, Luc Michel <luc@lmichel.fr>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
Subject: [PATCH-for-9.0? v2 3/8] hw/clock: Pass optional &bool argument to
 clock_set_ns()
Date: Mon, 25 Mar 2024 14:32:53 +0100
Message-ID: <20240325133259.57235-4-philmd@linaro.org>
X-Mailer: git-send-email 2.41.0
In-Reply-To: <20240325133259.57235-1-philmd@linaro.org>
References: <20240325133259.57235-1-philmd@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::329;
 envelope-from=philmd@linaro.org; helo=mail-wm1-x329.google.com
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

Pass optional &bool argument to clock_set_ns().
Since all callers ignore the return value, have
them use NULL.

Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
---
 docs/devel/clocks.rst | 2 +-
 include/hw/clock.h    | 8 ++------
 hw/arm/stellaris.c    | 2 +-
 3 files changed, 4 insertions(+), 8 deletions(-)

diff --git a/docs/devel/clocks.rst b/docs/devel/clocks.rst
index c4d14bde04..3360e5616d 100644
--- a/docs/devel/clocks.rst
+++ b/docs/devel/clocks.rst
@@ -298,7 +298,7 @@ object during device instance init. For example:
     clk = qdev_init_clock_in(DEVICE(dev), "clk-in", clk_in_callback,
                              dev, ClockUpdate);
     /* set initial value to 10ns / 100MHz */
-    clock_set_ns(clk, 10);
+    clock_set_ns(clk, 10, NULL);
 
 To enforce that the clock is wired up by the board code, you can
 call ``clock_has_source()`` in your device's realize method:
diff --git a/include/hw/clock.h b/include/hw/clock.h
index 474bbc07fe..94ed5ba6e6 100644
--- a/include/hw/clock.h
+++ b/include/hw/clock.h
@@ -195,13 +195,9 @@ static inline bool clock_set_hz(Clock *clk, unsigned hz)
     return changed;
 }
 
-static inline bool clock_set_ns(Clock *clk, unsigned ns)
+static inline void clock_set_ns(Clock *clk, unsigned ns, bool *changed)
 {
-    bool changed = false;
-
-    clock_set(clk, CLOCK_PERIOD_FROM_NS(ns), &changed);
-
-    return changed;
+    clock_set(clk, CLOCK_PERIOD_FROM_NS(ns), changed);
 }
 
 /**
diff --git a/hw/arm/stellaris.c b/hw/arm/stellaris.c
index a2f998bf9e..d4381beeb7 100644
--- a/hw/arm/stellaris.c
+++ b/hw/arm/stellaris.c
@@ -279,7 +279,7 @@ static void ssys_calculate_system_clock(ssys_state *s, bool propagate_clock)
     } else {
         period_ns = 5 * (((s->rcc >> 23) & 0xf) + 1);
     }
-    clock_set_ns(s->sysclk, period_ns);
+    clock_set_ns(s->sysclk, period_ns, NULL);
     if (propagate_clock) {
         clock_propagate(s->sysclk);
     }
-- 
2.41.0


