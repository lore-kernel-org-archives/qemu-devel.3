Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D595CE77188
	for <qemu-devel@archiver.kernel.org>; Tue, 31 Dec 2024 20:26:53 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tSilq-0002h5-Pk; Tue, 31 Dec 2024 15:23:18 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1tSilp-0002dZ-F2
 for qemu-devel@nongnu.org; Tue, 31 Dec 2024 15:23:17 -0500
Received: from mail-wm1-x333.google.com ([2a00:1450:4864:20::333])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1tSiln-0000rG-Vz
 for qemu-devel@nongnu.org; Tue, 31 Dec 2024 15:23:17 -0500
Received: by mail-wm1-x333.google.com with SMTP id
 5b1f17b1804b1-43626213fffso66375075e9.1
 for <qemu-devel@nongnu.org>; Tue, 31 Dec 2024 12:23:15 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1735676594; x=1736281394; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=x7T+GlWRYF0Ex9ElHkkhY2T3uL+OJyFZhB0eOR+pvv0=;
 b=kvBkjxFPAymMmQI0UqRCBCZ+rF/O4AWH1THWFE6q4ufDnDWR+K9WRV9NpIP+iv4kiM
 7TU3DjaGL7ZSsj2DBIDtuKFedeCkA5JkpiBDx8HDuVIg2ezp+1wK4TAOrc1M6UC8LbwO
 SiMlfs7Vun7adxdVAiRdxLmwhQV618VxQHQ3dCMfTcgs9pRI3+e4TkuhJxpcsdG/5K+1
 P0RX5deySXrTJj4Qs+SsH8fp7TAZl2T3YWvKzvYiAcH5bMinPZ8kppoSeDmxSCkJCxpx
 tIcrpgW9/k+m5c7nL5dOsGyQ9dsm3sQ9Wq0XJ6ZOLWyHqTpi+V9F/Dmcm4+i/Dua1WTw
 HfOA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1735676594; x=1736281394;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=x7T+GlWRYF0Ex9ElHkkhY2T3uL+OJyFZhB0eOR+pvv0=;
 b=HfC4xBcUWa4b9z+tiaxy6lv4tt4nnPSbovBGuNsH4P4oPuOilwFYaf6CyRVUnRkYmX
 0puxlrWMC4fNP4pP3taWN77K7GopCimzDO/fuUvcmzFLfpYOg8geOES+0k/KlGqvIrHg
 bNykmUehpKaRwqHXGEGugOH+oqd9gn2cmdujM4/JtUFc1oPnzWeaXqNpRDE94XtK7rnh
 X/9npCwZ+iDvhAVeAB61cZEEBwyQf0NQC2i2rRWMqW87bpTfGf0L7nGEu02ClTvEGm7Y
 3QV46sY65SYr8KvEaVQ+rhsqvs033ocz/blW1uFFp3MllNKJVaSmVd2yRUywBlhsA6wd
 EiJg==
X-Gm-Message-State: AOJu0Yyji9Qc873B2qRQsuhVkq2EfyimI/lpbDDQ6I8jCZhXyHTjleqp
 aKhkC9xuc0VdFmCMYL8H3pnTZuctoe4qq0ZY+CR29QRceGOcqRQpojKgNMfD1XnIJ6X0jQ0NHar
 XF2o=
X-Gm-Gg: ASbGnctuz6zI8mdYW3LD7/2Izf63+IxdBYHQLbsdWAwikrKboJYCZvDBnUpPI0gkKBp
 Ujbtch2ihUSfpDQXRCAZNkMIU1t6XMiHZSuV9EIILjX1/uQHi1/5DIUuzbYmK+5eJNLiFTmOE8c
 9Xo01+S2SQTAa2OdN5yF8B2KMtnmtrGz04YqxDW6ZK319SyhUo/43fzAypUxAIGYcCxLSxNy6TZ
 Z6wp1bn3sMJrUoDvzXwwO9L90XV5uQU2fyT4En0Zz0vC1TyCfKwEvj99ZCdraVTc0gjfw9dPadA
 jdm79PPKr/o4zjWe4W+XmcaVsnKq0oU=
X-Google-Smtp-Source: AGHT+IHL114FAhfFUNkRuOEuvK9TTQ8k13DyHJtBlturwxFsOtJZVF/va0SlGN0Cz1yU19XxGfIWXA==
X-Received: by 2002:a05:600c:1c20:b0:436:76bf:51cc with SMTP id
 5b1f17b1804b1-43676bf5382mr290252255e9.12.1735676593933; 
 Tue, 31 Dec 2024 12:23:13 -0800 (PST)
Received: from localhost.localdomain (88-187-86-199.subs.proxad.net.
 [88.187.86.199]) by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-43661219a7csm396013175e9.24.2024.12.31.12.23.13
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Tue, 31 Dec 2024 12:23:13 -0800 (PST)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
To: qemu-devel@nongnu.org
Cc: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Richard Henderson <richard.henderson@linaro.org>,
 Thomas Huth <huth@tuxfamily.org>
Subject: [PULL 09/29] hw/openrisc: Mark devices as big-endian
Date: Tue, 31 Dec 2024 21:22:08 +0100
Message-ID: <20241231202228.28819-10-philmd@linaro.org>
X-Mailer: git-send-email 2.47.1
In-Reply-To: <20241231202228.28819-1-philmd@linaro.org>
References: <20241231202228.28819-1-philmd@linaro.org>
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

The openrisc little-endian control is in a control register:
SR[LEE] (which we do not implement at present).

These devices are only used by the OpenRISC target, which is
only built as big-endian. Therefore the DEVICE_NATIVE_ENDIAN
definition expand to DEVICE_BIG_ENDIAN (besides, the
DEVICE_LITTLE_ENDIAN case isn't tested). Simplify directly
using DEVICE_BIG_ENDIAN.

Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
Reviewed-by: Richard Henderson <richard.henderson@linaro.org>
Reviewed-by: Thomas Huth <huth@tuxfamily.org>
Message-Id: <20241106184612.71897-5-philmd@linaro.org>
---
 hw/openrisc/openrisc_sim.c | 2 +-
 hw/openrisc/virt.c         | 2 +-
 2 files changed, 2 insertions(+), 2 deletions(-)

diff --git a/hw/openrisc/openrisc_sim.c b/hw/openrisc/openrisc_sim.c
index 87f9cbc3001..e0da4067ba3 100644
--- a/hw/openrisc/openrisc_sim.c
+++ b/hw/openrisc/openrisc_sim.c
@@ -266,7 +266,7 @@ static void openrisc_sim_serial_init(Or1ksimState *state, hwaddr base,
     }
     serial_mm_init(get_system_memory(), base, 0, serial_irq, 115200,
                    serial_hd(uart_idx),
-                   DEVICE_NATIVE_ENDIAN);
+                   DEVICE_BIG_ENDIAN);
 
     /* Add device tree node for serial. */
     nodename = g_strdup_printf("/serial@%" HWADDR_PRIx, base);
diff --git a/hw/openrisc/virt.c b/hw/openrisc/virt.c
index 22ae057992e..7b60bf85094 100644
--- a/hw/openrisc/virt.c
+++ b/hw/openrisc/virt.c
@@ -236,7 +236,7 @@ static void openrisc_virt_serial_init(OR1KVirtState *state, hwaddr base,
     qemu_irq serial_irq = get_per_cpu_irq(cpus, num_cpus, irq_pin);
 
     serial_mm_init(get_system_memory(), base, 0, serial_irq, 115200,
-                   serial_hd(0), DEVICE_NATIVE_ENDIAN);
+                   serial_hd(0), DEVICE_BIG_ENDIAN);
 
     /* Add device tree node for serial. */
     nodename = g_strdup_printf("/serial@%" HWADDR_PRIx, base);
-- 
2.47.1


