Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 64865C28B2F
	for <qemu-devel@archiver.kernel.org>; Tue, 18 Mar 2025 13:14:18 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tuWlf-0004Wb-Er; Tue, 18 Mar 2025 09:14:04 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <corvin.koehne@gmail.com>)
 id 1tuWjl-0002XK-QM; Tue, 18 Mar 2025 09:12:06 -0400
Received: from mail-ej1-x636.google.com ([2a00:1450:4864:20::636])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <corvin.koehne@gmail.com>)
 id 1tuWjj-0003xc-9x; Tue, 18 Mar 2025 09:12:05 -0400
Received: by mail-ej1-x636.google.com with SMTP id
 a640c23a62f3a-ac34257295dso185621066b.2; 
 Tue, 18 Mar 2025 06:12:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1742303520; x=1742908320; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=T+tDlwyJFEbqxfK75xzMM9/mAoGlGGtJAk6xVwXL1q0=;
 b=I6iaX4HiuxTb1I/nTl9stZHwEuUQHCDSAm15uL+dld8VmDMXgZd1lg72MH6BpgcpFC
 cGND4EZcMVFn7zKQaRKrVG470+HFBAh3L73SBMWc/O5nXaaffwCOPrJzY/zysUYJfBuX
 Vj5MAmThRPyHU26DeZWXm+lX5bujvVQMHy2pqBLt7/4jfFXM8n5xlYlTSLLh+zvnstsH
 OU45Ix/7wv4g/pX/2BdunkUK4Fx+oscRG1kEJICArb13M+91dA/LJWkrtxuYbCKDdfu3
 +ld4jOZqcOoBoYHY1WxE3gnIUV7iRyh0BXN4pqmPitG4cQyf+4DWTh/0G0Rsk+JqGrqm
 bj9w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1742303520; x=1742908320;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=T+tDlwyJFEbqxfK75xzMM9/mAoGlGGtJAk6xVwXL1q0=;
 b=rHgC1goaDLQh+tAqmmInB8E7uRbuAyqZDEdfbi9r0940fbBhOIcAOZmNNFcmiy240V
 B0C/TnfxIMFLQAG0z5v0uERS4Bfcy+EBW+g3q3MXgPXC4HTRad2mwi7ezNIeiol0lQ3a
 8JBi+IC7I41wUhSRN6HRPiXbe9V+ZShvJW7qoSyohlWywKCgciZQAD0lyA1LkyvdsUk0
 E2DtWdY/uwcbjJYe0PRZVL298EsTjb3HJrsYq9RE/Eztgss3JikKtyR053B06Qh0sNwH
 caFvT1eOTugT2Ch052xgNRPpmK6uoZvZEyco5K/CFucibj56Fxx+N/Yt4KYNdKv4H+rD
 ZCFQ==
X-Forwarded-Encrypted: i=1;
 AJvYcCW4OGtWJDo+gGpnl62rzrdvtywippvErb/FEqK+Km8qqCzXdxjEVXvvlaClT0m3+ZukM5SyKmmYCg==@nongnu.org
X-Gm-Message-State: AOJu0Yx/eGBF0Zr710EBIsRHD17kEsxSqM/4zR89MHKAtlI2R0Q01KNb
 cOfHF3dkIDYrzj+ictvl/xQOvwJPpvKZ8r+PAV7iUcIaaNbE5csThZhbEYfe
X-Gm-Gg: ASbGncul/cx5HRbStw7og0Zv8zrc29T/efPycDnDfTS/NuoXK+HmJLyEsAQWRVlPT1M
 OOErXAeWM5GJZ2kAiuNGkuJoGS8FIxOpvkMjRX3edwjlwBBDsAfsrJ1OWvLrX8f4ELdt7TdyIsl
 EEKH2EmsZ2cKqo1pzvDOWuuu/1eU5Ir0Kye5TlAe7MpMiNsWec/UAWPNFTMSi6CXlqfXT0HuOez
 dj9IQZ4dOMDKaibnjAT4tQBH4imX7lQVa0YTmIBuPmXQnvDGw+jwA7oCQ1ImVkC/A6B+jO75fKo
 bvcVLyFKu+oupn16zxcJ6DGCNsQuSgKp7w6/EGgaUTzB8EQ/6HvX9ty0OoxC1viLakawH2rNW44
 KXQ==
X-Google-Smtp-Source: AGHT+IEY7u6OTvhW2V7FFeYjo6xgg7GibW+G21Kdhp5ZE5mvBgnFWw/YSvsyKPGpgf+M22TGazndzw==
X-Received: by 2002:a17:907:c02:b0:ac3:4227:139c with SMTP id
 a640c23a62f3a-ac342271ebdmr1525780566b.24.1742303520261; 
 Tue, 18 Mar 2025 06:12:00 -0700 (PDT)
Received: from corvink-nb.beckhoff.com ([195.226.174.194])
 by smtp.gmail.com with ESMTPSA id
 a640c23a62f3a-ac3147f3101sm850678066b.69.2025.03.18.06.11.59
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 18 Mar 2025 06:11:59 -0700 (PDT)
From: =?UTF-8?q?Corvin=20K=C3=B6hne?= <corvin.koehne@gmail.com>
To: qemu-devel@nongnu.org,
 =?UTF-8?q?Corvin=20K=C3=B6hne?= <c.koehne@beckhoff.com>,
 qemu-arm@nongnu.org
Cc: =?UTF-8?q?Yannick=20Vo=C3=9Fen?= <y.vossen@beckhoff.com>,
 "Edgar E. Iglesias" <edgar.iglesias@gmail.com>,
 Peter Maydell <peter.maydell@linaro.org>,
 Alistair Francis <alistair@alistair23.me>,
 Paolo Bonzini <pbonzini@redhat.com>, YannickV <Y.Vossen@beckhoff.com>
Subject: [PATCH 18/21] hw/arm/beckhoff_CX7200: Set CPU frequency and PERIPHCLK
 period
Date: Tue, 18 Mar 2025 14:08:09 +0100
Message-ID: <20250318130817.119636-19-corvin.koehne@gmail.com>
X-Mailer: git-send-email 2.49.0
In-Reply-To: <20250318130817.119636-1-corvin.koehne@gmail.com>
References: <20250318130817.119636-1-corvin.koehne@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::636;
 envelope-from=corvin.koehne@gmail.com; helo=mail-ej1-x636.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, FREEMAIL_FROM=0.001,
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

From: YannickV <Y.Vossen@beckhoff.com>

The CPU frequency for the CX7200 is set to 720 MHz, with the
peripheral clock running at half of the CPU frequency. That
is why the PERIPHCLK_PERIOD is set to two. These values are
forwarded to the A9 global timer, watchdog timer and MP Timer.

Signed-off-by: Yannick Voßen <y.vossen@beckhoff.com>
---
 hw/arm/beckhoff_CX7200.c | 10 ++++++++++
 1 file changed, 10 insertions(+)

diff --git a/hw/arm/beckhoff_CX7200.c b/hw/arm/beckhoff_CX7200.c
index a3f4045560..0f99cbf554 100644
--- a/hw/arm/beckhoff_CX7200.c
+++ b/hw/arm/beckhoff_CX7200.c
@@ -47,6 +47,9 @@ OBJECT_DECLARE_SIMPLE_TYPE(CX7200MachineState, CX7200_MACHINE)
 /* board base frequency: 33.333333 MHz */
 #define PS_CLK_FREQUENCY (100 * 1000 * 1000 / 3)
 
+#define PERIPHCLK_PERIOD 2
+#define PS7_CPU_CLK_FREQUENCY 720000000
+
 #define NUM_SPI_FLASHES 0
 #define NUM_QSPI_FLASHES 1
 #define NUM_QSPI_BUSSES 1
@@ -254,6 +257,13 @@ static void beckhoff_cx7200_init(MachineState *machine)
 
     dev = qdev_new(TYPE_A9MPCORE_PRIV);
     qdev_prop_set_uint32(dev, "num-cpu", smp_cpus);
+    A9MPPrivState *a9mp_priv_state = A9MPCORE_PRIV(dev);
+    a9mp_priv_state->gtimer.cpu_clk_freq_hz = PS7_CPU_CLK_FREQUENCY;
+    a9mp_priv_state->gtimer.periphclk_period = PERIPHCLK_PERIOD;
+    a9mp_priv_state->mptimer.clk_freq_hz = PS7_CPU_CLK_FREQUENCY;
+    a9mp_priv_state->mptimer.periphclk_period = PERIPHCLK_PERIOD;
+    a9mp_priv_state->wdt.clk_freq_hz = PS7_CPU_CLK_FREQUENCY;
+    a9mp_priv_state->wdt.periphclk_period = PERIPHCLK_PERIOD;
     busdev = SYS_BUS_DEVICE(dev);
     sysbus_realize_and_unref(busdev, &error_fatal);
     sysbus_mmio_map(busdev, 0, MPCORE_PERIPHBASE);
-- 
2.49.0


