Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 16A82C43327
	for <qemu-devel@archiver.kernel.org>; Tue, 30 Jun 2026 02:51:47 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1weOYW-0004Fc-1z; Mon, 29 Jun 2026 22:50:36 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <joel.stan@gmail.com>)
 id 1weOYU-0004Ev-Ly
 for qemu-devel@nongnu.org; Mon, 29 Jun 2026 22:50:34 -0400
Received: from mail-pj1-x1035.google.com ([2607:f8b0:4864:20::1035])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <joel.stan@gmail.com>)
 id 1weOYT-0002Le-0t
 for qemu-devel@nongnu.org; Mon, 29 Jun 2026 22:50:34 -0400
Received: by mail-pj1-x1035.google.com with SMTP id
 98e67ed59e1d1-37e0a189b0bso2112191a91.1
 for <qemu-devel@nongnu.org>; Mon, 29 Jun 2026 19:50:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1782787831; x=1783392631; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:sender:from:to:cc:subject:date
 :message-id:reply-to;
 bh=skdYhJTqd6ST5O5dhp4YffIjdJRjr5no/Dx8UOIavo8=;
 b=M0MZicOVTMIgWmua6tYVIC2/Oh52TN0i2LLvgCLthYvCKM97Iw1f1bzQwQxMs+pSYS
 rb80SFYm8mKzuR3w7rEtHWgLDhGxDHft/jtCKsPfsUk54hXaeW3nmXancJow+lismd1j
 t/qsuLSSyQWrEtB+tgROfxfynSB4Fq4DTds6F0jBKRshVtheJmaCJ/g8p8Uw42/p2poP
 QO/Ik/AimcGfhNjP5mJHlCyIVZIdDVfCz4WKup6HH4tepilt2Y4GjXHXGL8xPy5vFbrR
 5RdIh9FgU9S3bI8YzJ+fikLnBoaGnM4LaQOAUjjpBuoX+Lv3YKUTcBLvD/sg1P0Gxdc/
 Vm8g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1782787831; x=1783392631;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:sender:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=skdYhJTqd6ST5O5dhp4YffIjdJRjr5no/Dx8UOIavo8=;
 b=ZFESgF7LzNz3DnpJNe525Bw5N4LECvOqKHA8uEEQXfaZAtTR/HLWPtXQT6CcX9wwV4
 bUsUX1xKMte0WILvi8eB6N5s5p+pouFuCKybTz26uzJmT7OYBxK0bHyPM8QS1M0schPK
 A9k0eAnul+6a3Xoa33TyYdYvlR40GOKxxlD/7ZYRCiQyZOZh3CCnWyQuk1vR34yB2v70
 H2Cr1Vl4f4GcSS8rYsj/qSnt8Nxn0qFz1rLQSA4M5do90MeEvdpkVvOZFM74WFYHOcQn
 6Fi3HcPbNTwLilf6FOAAecPn+ptU8WFQZOY70f2yWElt6XjToMi+aRXAwfED/H/hFmD2
 C2OA==
X-Forwarded-Encrypted: i=1;
 AHgh+RrpFhFcfA8IsZpZXS+V1zUSbarlXkBiaud9T5iHaUppXlVL2vff6nJEUku4qQizOO3JIir3fzkD2nSH@nongnu.org
X-Gm-Message-State: AOJu0YxuIKfOLVm075D84wgAMi86vXapc5nJM/3yQ6mtFhFXUhh4Dey1
 FuGH9jYTYRctGeZgDz1lIMZTa/HaeV8E6GlG0X2hjNyhaBOA0zzM/zcE
X-Gm-Gg: AfdE7cknDPg3MxqGr5wWehTkO1riKM+dFUHX93HQdaAYyNO2FvSst6oAE6oMTQmNJfO
 Vev76YQILgoZqLyChL4IVMM1mGC02YwbPiRdPgDV1Z5u3X9H/4ApySjJkv1snuI2N607snm+qMa
 C3S5jB+tB7sOeaQvMW9lqZoIeMnqETuYBo0UY3PChLfWtMOUmSyeFlybF8noV9ee4msh/oYwL4s
 VNt0uI7sAfBp3kfUIM4ZyNZVizbBwkhiOjN6NQ0hUoXqNE4Kj7zut3SgX8QMvooESHDGx6O46Zp
 lFPn5W7AkCf5ofPI9qf8c1ROTksLYFTDJPHSKwYKcYr62cieR/o2tkMOAAGSqaZuvrCVD51lXEz
 3dZGkdhfgeawbHe8sJaWju/94J5RVmMGuJyGX39vY5YurNqcucGdSzGy1QO8XmZ7gkRKhySsL6b
 eER+b/tmWuMhORTC3RdDHdmaUK2AD2IYpvLY1IFx/p+ZNgecbpYrmGuTPPtLwnPUmJfViD7PRrP
 awsMxpCsqD3xFsvHl5FF28BezFmYK5wu3eFzNw8yEw=
X-Received: by 2002:a17:90b:554f:b0:37f:9cdf:f038 with SMTP id
 98e67ed59e1d1-380527a8ea4mr1175010a91.27.1782787831251; 
 Mon, 29 Jun 2026 19:50:31 -0700 (PDT)
Received: from donnager-debian.. ([45.124.203.15])
 by smtp.gmail.com with ESMTPSA id
 98e67ed59e1d1-38052f32661sm704545a91.9.2026.06.29.19.50.25
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 29 Jun 2026 19:50:30 -0700 (PDT)
From: Joel Stanley <joel@jms.id.au>
To: Alistair Francis <alistair.francis@wdc.com>
Cc: Nicholas Piggin <npiggin@gmail.com>,
 Andrew Jones <andrew.jones@oss.qualcomm.com>,
 Daniel Henrique Barboza <daniel.barboza@oss.qualcomm.com>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@mailo.com>,
 Chao Liu <chao.liu.zevorn@gmail.com>, Michael Ellerman <mpe@kernel.org>,
 Joel Stanley <jms@oss.tenstorrent.com>,
 Anirudh Srinivasan <asrinivasan@oss.tenstorrent.com>,
 Portia Stephens <portias@oss.tenstorrent.com>, qemu-riscv@nongnu.org,
 qemu-devel@nongnu.org
Subject: [PATCH v10 05/12] hw/riscv/aia: Configure stride for the M-mode IMSIC
Date: Tue, 30 Jun 2026 12:19:43 +0930
Message-ID: <20260630024952.1520546-6-joel@jms.id.au>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <20260630024952.1520546-1-joel@jms.id.au>
References: <20260630024952.1520546-1-joel@jms.id.au>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::1035;
 envelope-from=joel.stan@gmail.com; helo=mail-pj1-x1035.google.com
X-Spam_score_int: -16
X-Spam_score: -1.7
X-Spam_bar: -
X-Spam_report: (-1.7 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_EF=-0.1, FREEMAIL_FORGED_FROMDOMAIN=0.001,
 FREEMAIL_FROM=0.001, HEADER_FROM_DIFFERENT_DOMAINS=0.249,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=no autolearn_force=no
X-Spam_action: no action
X-BeenThere: qemu-devel@nongnu.org
X-Mailman-Version: 2.1.29
Precedence: list
List-Id: qemu development <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <https://lists.nongnu.org/archive/html/qemu-devel>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=subscribe>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org

riscv_create_aia() currently hard-codes the M-IMSIC at one 4 KiB page
per hart and gives callers no way to widen it.

Add an m_imsic_stride parameter that supplies the per hart byte
stride directly. The virt machine passes IMSIC_HART_SIZE(0)
(= 4 KiB), preserving its existing compact layout.

The parameter only changes how the slots are spaced, with the rest of
each slot reserved. This allows future platforms that have different
layouts to control the stride.

Reviewed-by: Philippe Mathieu-Daudé <philmd@mailo.com>
Reviewed-by: Alistair Francis <alistair.francis@wdc.com>
Signed-off-by: Joel Stanley <joel@jms.id.au>
---
 hw/riscv/aia.h  | 1 +
 hw/riscv/aia.c  | 3 ++-
 hw/riscv/virt.c | 1 +
 3 files changed, 4 insertions(+), 1 deletion(-)

diff --git a/hw/riscv/aia.h b/hw/riscv/aia.h
index 5ad0a902be0d..565f91accc09 100644
--- a/hw/riscv/aia.h
+++ b/hw/riscv/aia.h
@@ -14,6 +14,7 @@
 uint32_t imsic_num_bits(uint32_t count);
 
 DeviceState *riscv_create_aia(bool msimode, int aia_guests,
+                             uint32_t m_imsic_stride,
                              uint16_t num_sources,
                              const MemMapEntry *aplic_m,
                              const MemMapEntry *aplic_s,
diff --git a/hw/riscv/aia.c b/hw/riscv/aia.c
index 82ea9d48ea75..ed8916002945 100644
--- a/hw/riscv/aia.c
+++ b/hw/riscv/aia.c
@@ -25,6 +25,7 @@ uint32_t imsic_num_bits(uint32_t count)
 }
 
 DeviceState *riscv_create_aia(bool msimode, int aia_guests,
+                             uint32_t m_imsic_stride,
                              uint16_t num_sources,
                              const MemMapEntry *aplic_m,
                              const MemMapEntry *aplic_s,
@@ -47,7 +48,7 @@ DeviceState *riscv_create_aia(bool msimode, int aia_guests,
             /* Per-socket M-level IMSICs */
             addr = imsic_m->base + socket * (1U << IMSIC_MMIO_GROUP_MIN_SHIFT);
             for (i = 0; i < hart_count; i++) {
-                riscv_imsic_create(addr + i * IMSIC_HART_SIZE(0),
+                riscv_imsic_create(addr + i * m_imsic_stride,
                                    base_hartid + i, true, 1,
                                    num_msis);
             }
diff --git a/hw/riscv/virt.c b/hw/riscv/virt.c
index 8f80c0607b92..b68067cfddd4 100644
--- a/hw/riscv/virt.c
+++ b/hw/riscv/virt.c
@@ -1401,6 +1401,7 @@ static void virt_machine_init(MachineState *machine)
         } else {
             s->irqchip[i] = riscv_create_aia(s->aia_type == VIRT_AIA_TYPE_APLIC_IMSIC,
                                              s->aia_guests,
+                                             IMSIC_HART_SIZE(0),
                                              s->num_sources,
                                              &s->memmap[VIRT_APLIC_M],
                                              &s->memmap[VIRT_APLIC_S],
-- 
2.47.3


