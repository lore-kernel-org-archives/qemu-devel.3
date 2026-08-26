Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E28A7C5DF97
	for <qemu-devel@archiver.kernel.org>; Wed, 26 Aug 2026 22:07:13 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wzLlG-0005D9-VH; Wed, 26 Aug 2026 18:06:23 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <joel.stan@gmail.com>)
 id 1wzLlE-0005B0-Sc
 for qemu-devel@nongnu.org; Wed, 26 Aug 2026 18:06:20 -0400
Received: from mail-pg1-x52b.google.com ([2607:f8b0:4864:20::52b])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <joel.stan@gmail.com>)
 id 1wzLlD-0004jU-D5
 for qemu-devel@nongnu.org; Wed, 26 Aug 2026 18:06:20 -0400
Received: by mail-pg1-x52b.google.com with SMTP id
 41be03b00d2f7-cc1cc97b84bso58250a12.1
 for <qemu-devel@nongnu.org>; Wed, 26 Aug 2026 15:06:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1787781978; x=1788386778; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:sender:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=5s/MHm9pZEMHdIBltCKmL5mdgHKUgYmEicbJN9o3MIY=;
 b=kPnJWTtrSOWXHBUK3CcFj+Y477DBb+O39wVwTevmwj6zK5r6iU11X/9tzcqIAT53AF
 pNYJqn5yEc/rE8ycUGRRV+g3eHK+PyPixbRgJ6VHCuT24A7/4rRnxgBXcnDuEtvfUK5E
 7gpaMzrSJjm9cwlXue98YOfe3S3qHhQv0QJzMH5REserP9csJGhrP03BYxuKS6g9yTcl
 iPoNk5xpb0IO9qDRR+IHU/5h+L5LJiVy0ZJbrL/6cj6zaNvkMvVEvxfuCO5M9lsZEg5e
 9jQ/OzFaMlEvqDv3ho0IqsnEXxnBz1m7EBEliCIoVRHHNR2MViyVBcLYIz6ifQyQ+Ihb
 Xz2w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1787781978; x=1788386778;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:sender:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=5s/MHm9pZEMHdIBltCKmL5mdgHKUgYmEicbJN9o3MIY=;
 b=qN9Bot8kVMEjWRtwj7/cwgQoMqwfba/YFS1kkl+wc9InfUhgu6I3+RgctG9pTbkspO
 Vxxp3h5sMuSZViFbJW1KyCrs2phHcge4Q37rmAgatmcbAaZKLK8WLSqppgYG3XibcFmw
 o3kdDtWAHn1YbD6PUlvFQs9nlb4Xoo07labhSAlTDUcGu95CbvbAovBMMcGYnyf+Wq19
 YhL5/bRsfRp6eXAZBQxJUxX4hwJIdYzu2MG8UexDBQXjwwiq+pfVIvBfPRhllPQZfKrk
 sfPGNChBj7EWZJt8owLs/lRH23m3Le6wqeZ0swtcwxbZiBbb7RjBW/goPGtAavF9L8Lh
 3Okw==
X-Forwarded-Encrypted: i=1;
 AHgh+RqGpmkOk0rTUJoT+fKozZgEcW3TPl8WvPM2NC6GbgaYMa0pGhihm2aT+KL/DTMHgAuglTP/232fKarY@nongnu.org
X-Gm-Message-State: AFuF++mXlPaD4+G3ZYGiYGZtwFUPii6v6GEJJ8tLWWhkK7d6jQwLEnkS
 GyoUeCvwXnKYPNAfA3/oFlDRSdygKkGE6o+0eBW+BN5F7MwhvWDdZrdv
X-Gm-Gg: AR+sD13WpWUAGc3BtavpXj1Gu02ZQh4M3jLxzi5ARMuG9f0MSkhulsPrcn5QF0IbwNX
 RVW6LrZ0h+lWM+lmev7+iWFX6QNoRqCE4dNYUwqSThn7zac9WeDkPCiUGUpDn7w3yx8HdXJ4Tg2
 w2vKUAjKy/4tmXJZ++mCMVXaB396pamirER70JSuoY5cdQ756T1UGM5vZoIE9K/ja2lBGOnl2Uz
 NyX0T/ztwiRdQ2Z8xdp9hwAW5wzJ+oKPhlMl5DA9gE2WmQ2SrRXDUmbXjb5zwv43jJrTHP3CF59
 VbrKf2/+93y7vn+7vJD/JzDrGciyboNjNIebc5lU7EQv9aBv7T9HuZyX1ysDpozM4nQs+gOwZ/s
 Bh6PTnCgNrlO9yhuHQjI2bUrOC+eNKlyUNEw4y3ApzGXs87dQuojm8PGHHOhPDPCPAHIQvcqTJy
 7sQUTfJYYqMoFBQSrSCbKe/EsGIB8DIhD8tk5oGvjvIX4BDYbWtfrrM9NqYzIxYWjZkJ6zaQliD
 4GnUijRXnSDhhtAPXXPDRTCZulcn4YMOOH1yOpIacFgktcnir6QzIXtoiivrkJVgc45cjce7V3t
 RCXTREkSwY9htxBWwIF+
X-Received: by 2002:a17:90b:4d0d:b0:396:5cdc:4bea with SMTP id
 98e67ed59e1d1-3966d457015mr16838564a91.5.1787781978020; 
 Wed, 26 Aug 2026 15:06:18 -0700 (PDT)
Received: from donnager-debian.. ([180.150.112.50])
 by smtp.gmail.com with ESMTPSA id
 98e67ed59e1d1-39668a573a1sm5789956a91.14.2026.08.26.15.06.13
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 26 Aug 2026 15:06:17 -0700 (PDT)
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
Subject: [PATCH 06/16] hw/riscv/cps: Map interrupt controllers in SoC container
Date: Thu, 27 Aug 2026 07:35:16 +0930
Message-ID: <20260826220528.54516-7-joel@jms.id.au>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <20260826220528.54516-1-joel@jms.id.au>
References: <20260826220528.54516-1-joel@jms.id.au>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::52b;
 envelope-from=joel.stan@gmail.com; helo=mail-pg1-x52b.google.com
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

The CPS device maps some devices into a container region, but the
ACLINT and APLIC were mapped directly to system_memory.

Pass the container memory region to the interrupt controller helpers so
all CPS devices live in the container. The location of devices in memory
for the boston-aia machine is unchanged.

Signed-off-by: Joel Stanley <joel@jms.id.au>
---
 hw/riscv/cps.c | 8 ++++----
 1 file changed, 4 insertions(+), 4 deletions(-)

diff --git a/hw/riscv/cps.c b/hw/riscv/cps.c
index d2fd9638a08d..21daaf4943d8 100644
--- a/hw/riscv/cps.c
+++ b/hw/riscv/cps.c
@@ -135,7 +135,7 @@ static void riscv_cps_realize(DeviceState *dev, Error **errp)
     for (i = 0; i < num_of_clusters; i++) {
         uint64_t cm_base = GLOBAL_CM_BASE + (CM_SIZE * i);
         uint32_t hartid_base = i << MHARTID_CLUSTER_SHIFT;
-        s->aplic = riscv_aplic_create(get_system_memory(),
+        s->aplic = riscv_aplic_create(&s->container,
                                       cm_base + AIA_PLIC_M_OFFSET,
                                       AIA_PLIC_M_SIZE,
                                       hartid_base, /* hartid_base */
@@ -143,7 +143,7 @@ static void riscv_cps_realize(DeviceState *dev, Error **errp)
                                       APLIC_NUM_SOURCES,
                                       APLIC_NUM_PRIO_BITS,
                                       false, true, NULL);
-        riscv_aplic_create(get_system_memory(),
+        riscv_aplic_create(&s->container,
                            cm_base + AIA_PLIC_S_OFFSET,
                            AIA_PLIC_S_SIZE,
                            hartid_base, /* hartid_base */
@@ -153,10 +153,10 @@ static void riscv_cps_realize(DeviceState *dev, Error **errp)
                            false, false, s->aplic);
         /* PLIC changes msi_nonbroken to ture. We revert the change. */
         msi_nonbroken = false;
-        riscv_aclint_swi_create(get_system_memory(),
+        riscv_aclint_swi_create(&s->container,
                                 cm_base + AIA_CLINT_OFFSET,
                                 hartid_base, MAX_HARTS, false);
-        riscv_aclint_mtimer_create(get_system_memory(),
+        riscv_aclint_mtimer_create(&s->container,
                                    cm_base + AIA_CLINT_OFFSET +
                                    RISCV_ACLINT_SWI_SIZE,
                                    RISCV_ACLINT_DEFAULT_MTIMER_SIZE,
-- 
2.47.3


