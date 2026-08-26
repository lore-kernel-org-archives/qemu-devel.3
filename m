Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id F13A2C61DC4
	for <qemu-devel@archiver.kernel.org>; Wed, 26 Aug 2026 22:06:34 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wzLkr-00056B-Dv; Wed, 26 Aug 2026 18:05:57 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <joel.stan@gmail.com>)
 id 1wzLkp-00055Q-Uc
 for qemu-devel@nongnu.org; Wed, 26 Aug 2026 18:05:55 -0400
Received: from mail-pg1-x52a.google.com ([2607:f8b0:4864:20::52a])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <joel.stan@gmail.com>)
 id 1wzLkn-0004h9-SB
 for qemu-devel@nongnu.org; Wed, 26 Aug 2026 18:05:55 -0400
Received: by mail-pg1-x52a.google.com with SMTP id
 41be03b00d2f7-cc1bc88a20eso1648780a12.3
 for <qemu-devel@nongnu.org>; Wed, 26 Aug 2026 15:05:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1787781952; x=1788386752; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:sender:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=ciIuJKjZ6j1nR/uMT+7qHvjI8S/CyEwP7dM8aiHQmjM=;
 b=IDQN7MjjnF6HL760fUyjlW5AWDGFTRxLq2DAjnuBzt9p3y1cfg/EscZFIhzYbERzzn
 YEx5/1VRqgXjQjEtb8LH0GOFlyWAr7C2YeOQQFgzOjLLAbNFTCDr2oMlLGfoyJC4NKa/
 v0l9/j2eYEymCGpYcTKr2/Q25EY51IjLegWZtgRpVDThc3BRSgdMSW/bcmtaMpjhSmTS
 oodf/diG404x/vGItGc6BlBJpYHUtQfH2iFwwiKlnAmxNhw8o/z7Lzh9teByw+X/fVxu
 VygDws09xauArO2JSujctbzj+WkbPRzqBbc/sUTu9/pq5UU5qV3VNs181NsyQO3PXVSc
 dMiA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1787781952; x=1788386752;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:sender:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=ciIuJKjZ6j1nR/uMT+7qHvjI8S/CyEwP7dM8aiHQmjM=;
 b=cmc6ToTZOoeSj0aAERPTzwcWD6P7GNN43hu18mNk5CqMQ2Q3s0NplFNfZrdTXM+ulE
 NKMY93XkeUdVz5uzpwgg5ee8h8yYxZRVg1mx+19I1WMbsJtj8XhpURc31Qm9U9+vaP/q
 pcph3SF33QTvsCzfjhTEUhYuXRXbjLlRAvQCETajaWeueh8zEJZfqPwCOYBCX/cHsa0E
 n5cam8m9Eh03kElh0A7GI/G2sj8kJzmzBYcB84JPb82HhzBFytsy7PG8jIq1574LGNzH
 ejhPgUJxJKiM/1TZ9cpWVlBNqp3Who8+I4F02Ef//8FPCkPtFwrQShlQpnBsmdqIh8Lb
 2Dfw==
X-Forwarded-Encrypted: i=1;
 AHgh+RpUceW6JXUlsdMWWjtIeldV3COCseiIFG3CqCCawPwjI4Z1AjTZhtiGT71A5MFKYUfL2AHCFolJeD8v@nongnu.org
X-Gm-Message-State: AFuF++kT6e/EdCOSCsXGQl0TvoNaHNVkCxfI0Beqa2nvNCrkj4xLmamB
 vI0SrVSCoo430j2xywb1V+sDJABxNjC6J8zGrWXIHLw+pGcknOLSRnWPcwErw/0p
X-Gm-Gg: AR+sD13n+VAA4g+WAilZqe49CGzCt0Boh0wHx9aHqD1tJ6xVblxjcVsuLkmQPVccOWY
 PhFGety5Dqy1jHy6L8qYruQ4RsORYIfirOJGNcU4Co499sSnpY/NHmfoaSqz8QCujRfV4P+E+PA
 njipSnZ2McGSd7dJ+8ESGpAsxuypxv1trGoxQp5iznHUfrNS1hPk5Km6R1carrFTcRNmBoII1wo
 lodKHOpVKP/ZutAFyHgkh4x9JUVM2YW8ETKCvWrj1q9GAIdmfi7/oKSm0uKxJLJ51QoJ0AS7ccn
 P3AtkgVM+8lIX9z+wMBzWJcXiEfJgicJ0O0AlDGSfxWovF9V/gNLh7+9FdDG95MNq/pii45SxfI
 OGiGaNQEjtk6RnIiH/8/L28e/MpEawcUF4tce54Ev0B7N4Wa/k0S2z7llqoW5ropIZIlQpqJAFL
 pqjexAcgMUOGwAYD4CctxAi8KLFiwXQwyCkOpF0Fm/6NUblqYM/PhAK0gEwH2r+0AtoTmX6BUTW
 VvXZ30PLTn0b1o1IwlV+nDSFGSe3GIYY4eT9rBRz2YZhnSunVgvkyD78EaFYArjU444b+Zjsg+Z
 vM3cRlYlRWkEVxbNjJtAmQUSfHHC8ww=
X-Received: by 2002:a17:90b:48c9:b0:36d:b424:4f17 with SMTP id
 98e67ed59e1d1-3966d3690e2mr22183984a91.1.1787781952429; 
 Wed, 26 Aug 2026 15:05:52 -0700 (PDT)
Received: from donnager-debian.. ([180.150.112.50])
 by smtp.gmail.com with ESMTPSA id
 98e67ed59e1d1-39668a573a1sm5789956a91.14.2026.08.26.15.05.47
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 26 Aug 2026 15:05:51 -0700 (PDT)
From: Joel Stanley <joel@jms.id.au>
To: Alistair Francis <alistair.francis@wdc.com>,
 Daniel Henrique Barboza <daniel.barboza@oss.qualcomm.com>
Cc: Weiwei Li <liwei1518@gmail.com>, Liu Zhiwei <zhiwei_liu@linux.alibaba.com>,
 Chao Liu <chao.liu@processmission.com>,
 Nicholas Piggin <npiggin@gmail.com>,
 Anirudh Srinivasan <asrinivasan@oss.tenstorrent.com>,
 Michael Ellerman <mpe@kernel.org>,
 Portia Stephens <portias@oss.tenstorrent.com>,
 =?UTF-8?q?C=C3=A9dric=20Le=20Goater?= <clg@kaod.org>,
 qemu-riscv@nongnu.org, qemu-devel@nongnu.org
Subject: [PATCH 01/16] hw/riscv/aia: Take a MemoryRegion for the created
 devices
Date: Thu, 27 Aug 2026 07:35:11 +0930
Message-ID: <20260826220528.54516-2-joel@jms.id.au>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <20260826220528.54516-1-joel@jms.id.au>
References: <20260826220528.54516-1-joel@jms.id.au>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::52a;
 envelope-from=joel.stan@gmail.com; helo=mail-pg1-x52a.google.com
X-Spam_score_int: -16
X-Spam_score: -1.7
X-Spam_bar: -
X-Spam_report: (-1.7 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_EF=-0.1, FREEMAIL_FORGED_FROMDOMAIN=0.001,
 FREEMAIL_FROM=0.001, HEADER_FROM_DIFFERENT_DOMAINS=0.25,
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

Add a MemoryRegion parameter to riscv_create_aia(), to be passed on to
the IMSIC and APLIC helpers so a SoC can have the controllers mapped
into its own memory container. Both callers pass system_memory, so there
is no change in behaviour.

As the controllers don't yet take a MemoryRegion the parameter is not
yet passed on. Changing riscv_create_aia first avoids churn in the
intermediate commits.

Signed-off-by: Joel Stanley <joel@jms.id.au>
---
 hw/riscv/aia.h         | 2 +-
 hw/riscv/aia.c         | 2 +-
 hw/riscv/tt_atlantis.c | 3 ++-
 hw/riscv/virt.c        | 3 ++-
 4 files changed, 6 insertions(+), 4 deletions(-)

diff --git a/hw/riscv/aia.h b/hw/riscv/aia.h
index 3b6d7f962506..82ab601bf188 100644
--- a/hw/riscv/aia.h
+++ b/hw/riscv/aia.h
@@ -13,7 +13,7 @@
 
 uint32_t imsic_num_bits(uint32_t count);
 
-DeviceState *riscv_create_aia(bool msimode, int aia_guests,
+DeviceState *riscv_create_aia(MemoryRegion *mr, bool msimode, int aia_guests,
                              uint32_t m_imsic_stride,
                              uint32_t s_imsic_stride,
                              uint16_t num_sources,
diff --git a/hw/riscv/aia.c b/hw/riscv/aia.c
index c1a5982856c5..651552c8f970 100644
--- a/hw/riscv/aia.c
+++ b/hw/riscv/aia.c
@@ -24,7 +24,7 @@ uint32_t imsic_num_bits(uint32_t count)
     return ret;
 }
 
-DeviceState *riscv_create_aia(bool msimode, int aia_guests,
+DeviceState *riscv_create_aia(MemoryRegion *mr, bool msimode, int aia_guests,
                              uint32_t m_imsic_stride,
                              uint32_t s_imsic_stride,
                              uint16_t num_sources,
diff --git a/hw/riscv/tt_atlantis.c b/hw/riscv/tt_atlantis.c
index babce2b680f2..d69851df0a01 100644
--- a/hw/riscv/tt_atlantis.c
+++ b/hw/riscv/tt_atlantis.c
@@ -496,7 +496,8 @@ static void tt_atlantis_machine_init(MachineState *machine)
                             &error_abort);
     sysbus_realize(SYS_BUS_DEVICE(&s->soc), &error_fatal);
 
-    s->irqchip = riscv_create_aia(true, TT_IMSIC_GUESTS,
+    s->irqchip = riscv_create_aia(system_memory,
+                                  true, TT_IMSIC_GUESTS,
                                   TT_IMSIC_STRIDE,
                                   TT_IMSIC_STRIDE,
                                   TT_IRQCHIP_NUM_SOURCES,
diff --git a/hw/riscv/virt.c b/hw/riscv/virt.c
index 329ccdb5a7b6..22a607ed10bf 100644
--- a/hw/riscv/virt.c
+++ b/hw/riscv/virt.c
@@ -1411,8 +1411,9 @@ static void virt_machine_init(MachineState *machine)
             s->irqchip[i] = virt_create_plic(s->memmap, i,
                                              base_hartid, hart_count);
         } else {
+            bool msimode = s->aia_type == VIRT_AIA_TYPE_APLIC_IMSIC;
             int imsic_bits = imsic_num_bits(s->aia_guests + 1);
-            s->irqchip[i] = riscv_create_aia(s->aia_type == VIRT_AIA_TYPE_APLIC_IMSIC,
+            s->irqchip[i] = riscv_create_aia(system_memory, msimode,
                                              s->aia_guests,
                                              IMSIC_HART_SIZE(0),
                                              IMSIC_HART_SIZE(imsic_bits),
-- 
2.47.3


