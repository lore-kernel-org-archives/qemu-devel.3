Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C4017D59F60
	for <qemu-devel@archiver.kernel.org>; Wed,  6 Nov 2024 18:47:18 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1t8l3A-00008x-SM; Wed, 06 Nov 2024 13:46:40 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1t8l39-0008Sb-N4
 for qemu-devel@nongnu.org; Wed, 06 Nov 2024 13:46:39 -0500
Received: from mail-ej1-x62c.google.com ([2a00:1450:4864:20::62c])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1t8l37-0000wM-So
 for qemu-devel@nongnu.org; Wed, 06 Nov 2024 13:46:39 -0500
Received: by mail-ej1-x62c.google.com with SMTP id
 a640c23a62f3a-a9acafdb745so35863766b.0
 for <qemu-devel@nongnu.org>; Wed, 06 Nov 2024 10:46:37 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1730918796; x=1731523596; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=YsFK2U3XFqb/vEljmH+2siHctjoVhJmmiNdlJHfI0/4=;
 b=hQ3ZYRKeM9RAz5rhZfvn6iN87PgTvsn886yZGBDiHPXycfDLPXac9nom/2TlwaY8w7
 H2hQIDgE19jHgXGirJBejG/SocHvYHya80hAZKTpn/YDCOkm4VExxbI49SBKAiVTNahe
 rVD6haCZiKt7IKVeTibTlCOK1kZS/haq4mdUiEwWxvnNiof4bmgZesYSMuh0d4/G4DKS
 MvI0T2KWc5YxLWV4qauxcX/nT/fuYD3kD6krs7khZDb8CuuHbdcoo/HC9e7SGdZMOhzw
 zA2TzNGM7G/s3sdMsl8d7WvXRoyMq4SVJw82Xk93iab5LNaNLfOv76AgUAj06psASqUa
 pRvw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1730918796; x=1731523596;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=YsFK2U3XFqb/vEljmH+2siHctjoVhJmmiNdlJHfI0/4=;
 b=n4JP25EBpM7gCtsOzDvxj72LTiA6LRjgcxpVUOaSJQiy8fWA1PePpurGlKnt5Tcuc1
 yk0xN2duRcMR/Tu4vQbIKeKdDdxMKPqLHWwU8vttWvGFqC7i1wRyHtX6bWoDEdEaIuIZ
 nOnmrjW8qDRlLQvjApzffjVvBLHuLsudOL0Gi1jkJYaHCChVrT2O8WkGQPskfJpxEL7O
 8DEp0LdiuA4cNKlBkP9mOHSBDjl7NxB+gKWqPB8rFQMUwxfXq2BXZePHwPAUhP8rwf+t
 5wKg10TjFD+YEF/6v+vqZfVSqnyVO97RohtpKNRq/iIRIAmJbUQ9pvOzzNe8hqHS8T34
 n7XA==
X-Gm-Message-State: AOJu0YwHpwHvKj5vYXsVfSk+uwGRaM6P5Ye/LaDjXmX91Q+7/YuIGddL
 0Rhs+cNpQQh8RHMtQkGACO7uIjkvtLT7fD6vSaumbX7LyBkts3mdtsyHfrWN6fvNBzs4DS6OZTD
 R
X-Google-Smtp-Source: AGHT+IE+L+yQyHT39fSRf4/OhKcpAqJYHinN1o/h9Nj2ZuOUgW78Lq2jC2oQuBoUyZL+R29YcaV+GA==
X-Received: by 2002:a17:907:7f90:b0:a9e:670f:9485 with SMTP id
 a640c23a62f3a-a9ed51c6ed6mr17121666b.30.1730918795914; 
 Wed, 06 Nov 2024 10:46:35 -0800 (PST)
Received: from localhost.localdomain ([89.101.134.25])
 by smtp.gmail.com with ESMTPSA id
 a640c23a62f3a-a9eb16d9d68sm317330266b.72.2024.11.06.10.46.34
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Wed, 06 Nov 2024 10:46:35 -0800 (PST)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
To: qemu-devel@nongnu.org
Cc: Artyom Tarasenko <atar4qemu@gmail.com>,
 Stefano Stabellini <sstabellini@kernel.org>,
 Richard Henderson <richard.henderson@linaro.org>,
 xen-devel@lists.xenproject.org, Paolo Bonzini <pbonzini@redhat.com>,
 Marcel Apfelbaum <marcel.apfelbaum@gmail.com>,
 "Edgar E. Iglesias" <edgar.iglesias@gmail.com>,
 Bastian Koppelmann <kbastian@mail.uni-paderborn.de>,
 Anthony PERARD <anthony@xenproject.org>,
 Eduardo Habkost <eduardo@habkost.net>, Thomas Huth <huth@tuxfamily.org>,
 Jia Liu <proljc@gmail.com>, Stafford Horne <shorne@gmail.com>,
 Paul Durrant <paul@xen.org>,
 Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>,
 "Michael S. Tsirkin" <mst@redhat.com>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
Subject: [PATCH 4/5] hw/openrisc: Mark devices as big-endian
Date: Wed,  6 Nov 2024 18:46:11 +0000
Message-ID: <20241106184612.71897-5-philmd@linaro.org>
X-Mailer: git-send-email 2.45.2
In-Reply-To: <20241106184612.71897-1-philmd@linaro.org>
References: <20241106184612.71897-1-philmd@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::62c;
 envelope-from=philmd@linaro.org; helo=mail-ej1-x62c.google.com
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

These devices are only used by the OpenRISC target, which is
only built as big-endian. Therefore the DEVICE_NATIVE_ENDIAN
definition expand to DEVICE_BIG_ENDIAN (besides, the
DEVICE_LITTLE_ENDIAN case isn't tested). Simplify directly
using DEVICE_BIG_ENDIAN.

Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
---
 hw/openrisc/openrisc_sim.c | 2 +-
 hw/openrisc/virt.c         | 2 +-
 2 files changed, 2 insertions(+), 2 deletions(-)

diff --git a/hw/openrisc/openrisc_sim.c b/hw/openrisc/openrisc_sim.c
index 9fb63515ef..794c175bdb 100644
--- a/hw/openrisc/openrisc_sim.c
+++ b/hw/openrisc/openrisc_sim.c
@@ -266,7 +266,7 @@ static void openrisc_sim_serial_init(Or1ksimState *state, hwaddr base,
     }
     serial_mm_init(get_system_memory(), base, 0, serial_irq, 115200,
                    serial_hd(OR1KSIM_UART_COUNT - uart_idx - 1),
-                   DEVICE_NATIVE_ENDIAN);
+                   DEVICE_BIG_ENDIAN);
 
     /* Add device tree node for serial. */
     nodename = g_strdup_printf("/serial@%" HWADDR_PRIx, base);
diff --git a/hw/openrisc/virt.c b/hw/openrisc/virt.c
index 47d2c9bd3c..ede57fe391 100644
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
2.45.2


