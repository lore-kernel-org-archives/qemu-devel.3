Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B95E5C282EC
	for <qemu-devel@archiver.kernel.org>; Tue, 18 Mar 2025 13:10:58 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tuWiW-0008Pd-Ng; Tue, 18 Mar 2025 09:10:49 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <corvin.koehne@gmail.com>)
 id 1tuWiE-00083h-Gy; Tue, 18 Mar 2025 09:10:41 -0400
Received: from mail-ej1-x636.google.com ([2a00:1450:4864:20::636])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <corvin.koehne@gmail.com>)
 id 1tuWiB-0003f9-3C; Tue, 18 Mar 2025 09:10:30 -0400
Received: by mail-ej1-x636.google.com with SMTP id
 a640c23a62f3a-ac25d2b2354so956551266b.1; 
 Tue, 18 Mar 2025 06:10:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1742303424; x=1742908224; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=mggqB81grCqRlFJug6lfjJdqHWYTQWBu9Z0EKFmQF74=;
 b=Da2N9IWkV5mD4hbrTGHJGRlb2qWphmlol0ymnU0pEBCy3tGaVLt4RXYe/dwPHCOVNB
 w5cGQedJvsuo/4ANxSZzTv2QO9fhltI3S8dXVTL9LEhfgS0/N8PVNeFagx1M3npPkaOT
 QDCBNO31zLXh597UT4UUKhE3IXhi/fZXHrRSisbQPolevJ+FvGKaapWrOvOq3DFhfjpx
 SczLKrPs3jfQkrGQqYPadcnUeC3pJ7NCg9gcr/ETBMqTIQCy+zcYQTl6NbKpeZLOHLiq
 m3/TM/aTIw3W++4eg6QUijjJKK2289UXbz+xSJGvimAe4htCtK6UDW+zMUzDdcwY6EKD
 gIRA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1742303424; x=1742908224;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=mggqB81grCqRlFJug6lfjJdqHWYTQWBu9Z0EKFmQF74=;
 b=ERffCxemPuFF5t98FmQOuXNYlJo/OTJS4Bmsa4ZJfNQKUzv/ix4SGq+fhhh8nV3dnK
 zPAwDMD90o+N9cMC8h2uMwuTpjQdAdesBmB+uRRFCr9zAduqAbmOMHJV0zybpxm3G/bo
 4D25m30YSkukDrEPkIgTlx0rv/tXrDK7GMyb+wvG/+lWyuiJU+C0S156IF7t0SFl/wXs
 BCrx7KsFYhpz4vO9i2G2KzRImdioBcWpaU8U0x6W1jsjvabHR0z19uQIfaKAeBf1+p68
 ywor5FG4onY/omQaCcj75SAyUPeXcS06IogeO3nNRV91Go+Oc1eULirYLEiSafSI6egk
 7GpA==
X-Forwarded-Encrypted: i=1;
 AJvYcCVsbU7fGbwoI0+oHelcX8pnKVavmhOhVzgIPyGOUEEb8bI6P8LMwgp6vE6Q9yPtFa2HJZ2dB22mAA==@nongnu.org
X-Gm-Message-State: AOJu0YxYRavG/BFb6TDhj6GBT9uC7Er8EkdWeopJFPQCPdVVA6vnoKpF
 rbNtxyWEXymVLZtKa44T3DrBa/g8U0MKN7+JG0yHjc4F++NpUvsLd6cJ/hJe
X-Gm-Gg: ASbGncuzxxZnau1+V/QQpRKITb0mWkACD7hZKBDbm2dAeT/YsrwL3QSIQ8SCjv0nkAb
 cqW4x62syqFXYMPlcesWygV5bZSCIAnjsNMScRRcI8CoPgP37LmPEZtQVZqVdyz+NHhdX/x/4p/
 QHs+qgy8Jci9ueLvsEYpMmFYIuJkSQVDkrSqkbIzDlU/wiS6opQ00VXlIkVNLhd9l+KzbZ/YXW0
 vhYQWRXpZ751xf5h3kwqjAT+Jp4kfV+ZZXyqaxFgQk189rw2xG6hC1UFZz+7MxSLyAFctMGojly
 SElBR9EPR9JpzEKNXG3SF3iNE66q+aVr1TfloLXKT1NDkXdaX7gx/EegUh8evg7wMVk=
X-Google-Smtp-Source: AGHT+IHUto3hASebI0ih7GIScn07BWDKs+1MsLnPSfAv/i4vvmVCgQ0ZCM7sCnVcGga+InEB3EV1+Q==
X-Received: by 2002:a17:906:6a0b:b0:ac3:4489:7910 with SMTP id
 a640c23a62f3a-ac344897c1fmr1423080466b.49.1742303400739; 
 Tue, 18 Mar 2025 06:10:00 -0700 (PDT)
Received: from corvink-nb.beckhoff.com ([195.226.174.194])
 by smtp.gmail.com with ESMTPSA id
 a640c23a62f3a-ac3147f3101sm850678066b.69.2025.03.18.06.09.57
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 18 Mar 2025 06:09:57 -0700 (PDT)
From: =?UTF-8?q?Corvin=20K=C3=B6hne?= <corvin.koehne@gmail.com>
To: qemu-devel@nongnu.org,
	qemu-arm@nongnu.org
Cc: =?UTF-8?q?Yannick=20Vo=C3=9Fen?= <y.vossen@beckhoff.com>,
 "Edgar E. Iglesias" <edgar.iglesias@gmail.com>,
 Peter Maydell <peter.maydell@linaro.org>,
 Alistair Francis <alistair@alistair23.me>,
 =?UTF-8?q?Corvin=20K=C3=B6hne?= <c.koehne@beckhoff.com>,
 Paolo Bonzini <pbonzini@redhat.com>, YannickV <Y.Vossen@beckhoff.com>
Subject: [PATCH 04/21] hw/arm/zynq-devcfg: Prevent unintended unlock during
 initialization
Date: Tue, 18 Mar 2025 14:07:55 +0100
Message-ID: <20250318130817.119636-5-corvin.koehne@gmail.com>
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

During the emulation startup, all registers are reset, which triggers the
`r_unlock_post_write` function with a value of 0. This led to an
unintended memory access disable, making the devcfg unusable.

To address this, a property 'is_initialized' is introduced. It is set
to false during reset and updated to true once the initialization is
complete. The unlock function is simply ignored while 'is_initialized'
is false.

I have no idea how this ever worked. Nevertheless, this restores the
correct behavior.

Signed-off-by: Yannick Voßen <y.vossen@beckhoff.com>
---
 hw/dma/xlnx-zynq-devcfg.c         | 6 +++++-
 include/hw/dma/xlnx-zynq-devcfg.h | 2 ++
 2 files changed, 7 insertions(+), 1 deletion(-)

diff --git a/hw/dma/xlnx-zynq-devcfg.c b/hw/dma/xlnx-zynq-devcfg.c
index b838c1c0d0..03b5280228 100644
--- a/hw/dma/xlnx-zynq-devcfg.c
+++ b/hw/dma/xlnx-zynq-devcfg.c
@@ -143,9 +143,11 @@ static void xlnx_zynq_devcfg_reset(DeviceState *dev)
     XlnxZynqDevcfg *s = XLNX_ZYNQ_DEVCFG(dev);
     int i;
 
+    s->is_initialized = false;
     for (i = 0; i < XLNX_ZYNQ_DEVCFG_R_MAX; ++i) {
         register_reset(&s->regs_info[i]);
     }
+    s->is_initialized = true;
 }
 
 static void xlnx_zynq_devcfg_dma_go(XlnxZynqDevcfg *s)
@@ -221,7 +223,9 @@ static void r_unlock_post_write(RegisterInfo *reg, uint64_t val)
 {
     XlnxZynqDevcfg *s = XLNX_ZYNQ_DEVCFG(reg->opaque);
     const char *device_prefix = object_get_typename(OBJECT(s));
-
+    if (!s->is_initialized) {
+        return;
+    }
     if (val == R_UNLOCK_MAGIC) {
         DB_PRINT("successful unlock\n");
         s->regs[R_CTRL] |= R_CTRL_PCAP_PR_MASK;
diff --git a/include/hw/dma/xlnx-zynq-devcfg.h b/include/hw/dma/xlnx-zynq-devcfg.h
index e4cf085d70..2ab054e598 100644
--- a/include/hw/dma/xlnx-zynq-devcfg.h
+++ b/include/hw/dma/xlnx-zynq-devcfg.h
@@ -55,6 +55,8 @@ struct XlnxZynqDevcfg {
     XlnxZynqDevcfgDMACmd dma_cmd_fifo[XLNX_ZYNQ_DEVCFG_DMA_CMD_FIFO_LEN];
     uint8_t dma_cmd_fifo_num;
 
+    bool is_initialized;
+
     uint32_t regs[XLNX_ZYNQ_DEVCFG_R_MAX];
     RegisterInfo regs_info[XLNX_ZYNQ_DEVCFG_R_MAX];
 };
-- 
2.49.0


