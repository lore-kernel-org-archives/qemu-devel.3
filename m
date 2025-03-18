Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id F1AB8C28B28
	for <qemu-devel@archiver.kernel.org>; Tue, 18 Mar 2025 13:14:25 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tuWlv-0005ux-CK; Tue, 18 Mar 2025 09:14:20 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <corvin.koehne@gmail.com>)
 id 1tuWjl-0002VA-B0; Tue, 18 Mar 2025 09:12:05 -0400
Received: from mail-ej1-x633.google.com ([2a00:1450:4864:20::633])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <corvin.koehne@gmail.com>)
 id 1tuWjh-0003x0-PO; Tue, 18 Mar 2025 09:12:03 -0400
Received: by mail-ej1-x633.google.com with SMTP id
 a640c23a62f3a-ac29fd22163so988631466b.3; 
 Tue, 18 Mar 2025 06:12:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1742303519; x=1742908319; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=ufr+Ojap1d/6dhqxl/dlT+APPSOlWATmZs8iR5dzTzY=;
 b=OzWRk/7/O2o781aCa9rj0eDHeghw1PRDR/wEbv4YwG2X3NqrHTEV634qJwZgi6J6KF
 8Uo0UKZqgZ4JFLZIEwnBNc8Mk3WaxyEWxSoGdC0S71YUueu786kaxlXBUccrcBoTtlGG
 50PcQtqG8rIgqcyw1oPwMLFe9ZtHovp1BCEPQiy1KlIYD5LHk09ZQ6ZFJaSm6iSSmZ6r
 rPW87bwSu3ndTGjAvzQa1VCsTkkN29ud6+THSEUl15Jc7lrES69q/0B643mOJAkHGnyb
 nSCTsZ5Us+pBJH/DIK+UQYhxcRk6Ly3CeTiVvcFtDIzNJfyTCnLKKLrdG52fmN/qb7uP
 iUZg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1742303519; x=1742908319;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=ufr+Ojap1d/6dhqxl/dlT+APPSOlWATmZs8iR5dzTzY=;
 b=aA0+h8/vhkiPnqF+d44Ii4jjyCl5J+JjMRJ6T9p3hCGN4R+kMjALMsP9BU8xzM6+gc
 /yGUvvVtb6NOJ8k2xmGFSQ1jWKyUbHEvhWJ94FCpA3nQUdZ7s0PZLrf2D0ukWjPGWH21
 pu4B1ZlHTy0drhutSomyUYzJ9E08v5DJWp+iEQdroXkz0QUPeHHH3tR/DkHtWo8MZc4j
 9Enhf6Fgsoil7f/RCAJ35MIeeSsOR3GL6m7aJlRvCpuhZQXM1qxHycQaubmTdC5JDzoN
 p9AX4wPy8ROhd2HMytMCTlW46jaOtNVfgG+zcM7bv4rSuZT76DKXv5ng7DRgNVxk8HT+
 dswA==
X-Forwarded-Encrypted: i=1;
 AJvYcCUJhVC7bkhxuIu2eJCxfMK/aaBU/nZucpcR1wArzotpincOwG0qHCBggh0bTGGYdfaBjPlFucuFUg==@nongnu.org
X-Gm-Message-State: AOJu0YxBlW3bOgnBd6upNmwgcFVz3jQsYxOCMV0Aj6ZkaPuNwDhfo3wf
 EqsLKSOvLv0aQ4BjDiqF9URdehnFJhYEWVetEtJHvcOCQFJnw7qINTwcOh35
X-Gm-Gg: ASbGncuvRsYPwvsQ9fKWnHdCTfGBqGXrdM6Ejp1wZSvwPub31wl7RuQXHIz13zDBM6H
 HBoFdfVj4yEvjoY/IGKXTrksn5L9S5SmjZYQvXpLHOFZC1Yu6bYEfVXRxDmp1xexDIR3ookA4nl
 xoHgbIqz0ZZi5Tv4xhjlXO6d1v0meSUTC6mYi4eN4ijZvx9OVbMgitU+j4KZuLqrxNwreLd1Rz2
 vQObtXfwFGajv523LwZct8jgtWLUf3ZcfSlpscdrqegYUmpw4gGSokj++o0copYdSVS8O5ql+rs
 9dkBmkIcGu+Vn2XU6eBwYvoIz/Stb6VF2blRO6BSovREpQ+foh+S1rAT/+A++bnrb9U=
X-Google-Smtp-Source: AGHT+IELz1TJGTUEpUm+D0f9KQFhnwz6W7BK3gJ9L8xaGrpyZ/JSL1mZK1kpWzpgJef+yrdyULmUQg==
X-Received: by 2002:a17:906:6a0a:b0:ac1:ed96:56d9 with SMTP id
 a640c23a62f3a-ac330445091mr1695805166b.40.1742303517481; 
 Tue, 18 Mar 2025 06:11:57 -0700 (PDT)
Received: from corvink-nb.beckhoff.com ([195.226.174.194])
 by smtp.gmail.com with ESMTPSA id
 a640c23a62f3a-ac3147f3101sm850678066b.69.2025.03.18.06.11.56
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 18 Mar 2025 06:11:56 -0700 (PDT)
From: =?UTF-8?q?Corvin=20K=C3=B6hne?= <corvin.koehne@gmail.com>
To: qemu-devel@nongnu.org,
 =?UTF-8?q?Corvin=20K=C3=B6hne?= <c.koehne@beckhoff.com>,
 qemu-arm@nongnu.org
Cc: =?UTF-8?q?Yannick=20Vo=C3=9Fen?= <y.vossen@beckhoff.com>,
 "Edgar E. Iglesias" <edgar.iglesias@gmail.com>,
 Peter Maydell <peter.maydell@linaro.org>,
 Alistair Francis <alistair@alistair23.me>,
 Paolo Bonzini <pbonzini@redhat.com>, YannickV <Y.Vossen@beckhoff.com>
Subject: [PATCH 17/21] hw/arm/beckhoff_CX7200: Remove unimplemented devices
Date: Tue, 18 Mar 2025 14:08:08 +0100
Message-ID: <20250318130817.119636-18-corvin.koehne@gmail.com>
X-Mailer: git-send-email 2.49.0
In-Reply-To: <20250318130817.119636-1-corvin.koehne@gmail.com>
References: <20250318130817.119636-1-corvin.koehne@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::633;
 envelope-from=corvin.koehne@gmail.com; helo=mail-ej1-x633.google.com
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

Some unimplemented devices do not exist for the CX7200. All
unimplemented devices have been removed for better overview
and the fact that they are not necessary for a CX7200 emulation.

Signed-off-by: Yannick Voßen <y.vossen@beckhoff.com>
---
 hw/arm/beckhoff_CX7200.c | 69 ----------------------------------------
 1 file changed, 69 deletions(-)

diff --git a/hw/arm/beckhoff_CX7200.c b/hw/arm/beckhoff_CX7200.c
index efce3be395..a3f4045560 100644
--- a/hw/arm/beckhoff_CX7200.c
+++ b/hw/arm/beckhoff_CX7200.c
@@ -357,75 +357,6 @@ static void beckhoff_cx7200_init(MachineState *machine)
     sysbus_connect_irq(busdev, 0, pic[40 - IRQ_OFFSET]);
     sysbus_mmio_map(busdev, 0, 0xF8007000);
 
-    /*
-     * Refer to the ug585-Zynq-7000-TRM manual B.3 (Module Summary) and
-     * the zynq-7000.dtsi. Add placeholders for unimplemented devices.
-     */
-    create_unimplemented_device("zynq.i2c0", 0xE0004000, 4 * KiB);
-    create_unimplemented_device("zynq.i2c1", 0xE0005000, 4 * KiB);
-    create_unimplemented_device("zynq.can0", 0xE0008000, 4 * KiB);
-    create_unimplemented_device("zynq.can1", 0xE0009000, 4 * KiB);
-    create_unimplemented_device("zynq.gpio", 0xE000A000, 4 * KiB);
-    create_unimplemented_device("zynq.smcc", 0xE000E000, 4 * KiB);
-
-    /* Direct Memory Access Controller, PL330, Non-Secure Mode */
-    create_unimplemented_device("zynq.dma_ns", 0xF8004000, 4 * KiB);
-
-    /* System Watchdog Timer Registers */
-    create_unimplemented_device("zynq.swdt", 0xF8005000, 4 * KiB);
-
-    /* DDR memory controller */
-    create_unimplemented_device("zynq.ddrc", 0xF8006000, 4 * KiB);
-
-    /* AXI_HP Interface (AFI) */
-    create_unimplemented_device("zynq.axi_hp0", 0xF8008000, 0x28);
-    create_unimplemented_device("zynq.axi_hp1", 0xF8009000, 0x28);
-    create_unimplemented_device("zynq.axi_hp2", 0xF800A000, 0x28);
-    create_unimplemented_device("zynq.axi_hp3", 0xF800B000, 0x28);
-
-    create_unimplemented_device("zynq.efuse", 0xF800d000, 0x20);
-
-    /* Embedded Trace Buffer */
-    create_unimplemented_device("zynq.etb", 0xF8801000, 4 * KiB);
-
-    /* Cross Trigger Interface, ETB and TPIU */
-    create_unimplemented_device("zynq.cti_etb_tpiu", 0xF8802000, 4 * KiB);
-
-    /* Trace Port Interface Unit */
-    create_unimplemented_device("zynq.tpiu", 0xF8803000, 4 * KiB);
-
-    /* CoreSight Trace Funnel */
-    create_unimplemented_device("zynq.funnel", 0xF8804000, 4 * KiB);
-
-    /* Instrumentation Trace Macrocell */
-    create_unimplemented_device("zynq.itm", 0xF8805000, 4 * KiB);
-
-    /* Cross Trigger Interface, FTM */
-    create_unimplemented_device("zynq.cti_ftm", 0xF8809000, 4 * KiB);
-
-    /* Fabric Trace Macrocell */
-    create_unimplemented_device("zynq.ftm", 0xF880B000, 4 * KiB);
-
-    /* Cortex A9 Performance Monitoring Unit, CPU */
-    create_unimplemented_device("cortex-a9.pmu0", 0xF8891000, 4 * KiB);
-    create_unimplemented_device("cortex-a9.pmu1", 0xF8893000, 4 * KiB);
-
-    /* Cross Trigger Interface, CPU */
-    create_unimplemented_device("zynq.cpu_cti0", 0xF8898000, 4 * KiB);
-    create_unimplemented_device("zynq.cpu_cti1", 0xF8899000, 4 * KiB);
-
-    /* CoreSight PTM-A9, CPU */
-    create_unimplemented_device("cortex-a9.ptm0", 0xF889c000, 4 * KiB);
-    create_unimplemented_device("cortex-a9.ptm1", 0xF889d000, 4 * KiB);
-
-    /* AMBA NIC301 TrustZone */
-    create_unimplemented_device("zynq.trustZone", 0xF8900000, 0x20);
-
-    /* AMBA Network Interconnect Advanced Quality of Service (QoS-301) */
-    create_unimplemented_device("zynq.qos301_cpu", 0xF8946000, 0x130);
-    create_unimplemented_device("zynq.qos301_dmac", 0xF8947000, 0x130);
-    create_unimplemented_device("zynq.qos301_iou", 0xF8948000, 0x130);
-
     beckhoff_cx7200_binfo.ram_size = machine->ram_size;
     beckhoff_cx7200_binfo.board_id = 0xd32;
     beckhoff_cx7200_binfo.loader_start = 0;
-- 
2.49.0


