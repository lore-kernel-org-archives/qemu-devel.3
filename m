Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id BAEB7C61DD3
	for <qemu-devel@archiver.kernel.org>; Thu,  3 Sep 2026 05:53:34 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1x20NM-0006Vs-Ru; Thu, 03 Sep 2026 01:52:40 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <joel.stan@gmail.com>)
 id 1x20NK-0006UF-Kd
 for qemu-devel@nongnu.org; Thu, 03 Sep 2026 01:52:38 -0400
Received: from mail-pg1-x52a.google.com ([2607:f8b0:4864:20::52a])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <joel.stan@gmail.com>)
 id 1x20NI-0006Fl-Lz
 for qemu-devel@nongnu.org; Thu, 03 Sep 2026 01:52:38 -0400
Received: by mail-pg1-x52a.google.com with SMTP id
 41be03b00d2f7-cc1bc88a20eso2610042a12.3
 for <qemu-devel@nongnu.org>; Wed, 02 Sep 2026 22:52:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1788414748; x=1789019548; darn=nongnu.org;
 h=content-transfer-encoding:content-type:mime-version:references
 :in-reply-to:message-id:date:subject:cc:to:from:sender:from:to:cc
 :subject:date:message-id:reply-to:content-type;
 bh=sEf0pnR2YMWUNR1E9QteSUNz7ULUPAOBGN/IIXi/q0U=;
 b=UW0ujbnAxlZeXN1G3yVo55LVctCOvMIWA24TRLjMLzVRPY9EQhG3O8AlNEOG4QwL6j
 Fkt59XhDQCRb4lmjoeXYPfuTrTXYiyMQ8FAXaZrgAGP3yDly9da5v0GY5pTnKzJtPv37
 qZM2cyyRteO5uK7h0M14xDELvOr8CNH+XaMm7OI1/7W1q2XV4g8MxRpZDoch3MSpI5YJ
 mDtEQiWIZw2T/vVDnBH5DhZVYoqtzkAguXNSwRjPcRFuDASIdKzBD6+MmTtc6Glg7e/o
 x3ACLfFkKMDDZTI+LeBaEKftOOUq00S/Mfwizg98xDvAO0jNy3Z0D7EYL1LI7oZrPIla
 0wAw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1788414748; x=1789019548;
 h=content-transfer-encoding:content-type:mime-version:references
 :in-reply-to:message-id:date:subject:cc:to:from:sender:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=sEf0pnR2YMWUNR1E9QteSUNz7ULUPAOBGN/IIXi/q0U=;
 b=R9MqTHHeqB1XnU6QTnknepUetBkr3iCJQGHb8/07W3EVrxOCfxVt56QIitHZIMM6GY
 vNUyjTVXKxBG+RdNhAEMfKGJ4E0DPNlOLMp4MgPVYlbH/Y1SlhRa1zdX186kmq95CK3i
 9fjpBA6M5Q0OgFromGcF87eGUOVkd20cfkl87CQIT2vC0QsQR26Y3eViDQrM0WoXC4z2
 fSz5+yz29l6nu1CBDSqJgGq4USRZhvk9P+0ADrLpH0r/iMpwap//SSJFEPVUMQAbU4hS
 4E4DorwwqH3kQJ++SJsMjEbkwfvqmJJwRiDI58+ezLtBVS6OjnRhGtAAexOSnXNV3fyX
 MbrA==
X-Forwarded-Encrypted: i=1;
 AKwUvByVH/NYMoLwvW+IEFvq58A4hRXlunwxLoL5ppvS4ZO6BzKs7/B2HaTWWjvmitmpPe8AuXSqGShNZGTE@nongnu.org
X-Gm-Message-State: AFuF++lQM51WkA+tM0XQF5cBP1lFvqkAr6SdEZisXI0cvIMQtnuNzzH/
 i10zcprnPihFleB+78tCkKgEXHUuRdMIjWhPZ20ah4RogL46t6Upppra
X-Gm-Gg: AYBFou2joB7H5yOsyLjnzRtvFbrbLzNpXmYjUr9EdXbAqp9IxxGDQxzBm0jwNheLaxF
 XcFMWKQkto6TWt9zoiBA2M+r3Q+xEPzLnEcdUqaWH50QXWgcM4S79bFps2fweELkyvRS/58bHtR
 7cthMfnKFIOWjqeXBJm3XxvUy7QXNlpdOFIrckT8iN1OWDVQ5c1qi5WzseYehpYAJajmAiR6rUS
 1gb13YzCER4wpRlvxqSbpjQEylYp3A0UHjy3gn/rHZ3j5Y5n1sL91v7j1UgO31QzV3vE4/jgfFQ
 01lbr8lefpCTyY5H2ewDKm5CMiSeezjUkHUSfTo1GsJl5Q+dL7Bgpo5/hWCf/+QdA/O0WIGoZxS
 HuHQeSKVGkSM8xBZl3lfdP5pSFwiiWeHFIeISo/sDKPJHSsLU3GE0bs1lo+jLaDfEwwcS+6FAH+
 Oy4Gl5InTmOpp27lbYKTAu/DAFONZ+lDLeG2nTICHvYEcSxn6gid3JTJIu1iwcYKlsqplA2jPtP
 XRSYI0owwExW24jOrK12xDNkfVEiiWGkH+uszAIhGKfNOrEP08y0WsQggejqd9oSpeHvogOg4ho
 m5GwqwTfcs6ui/cI/OFT
X-Received: by 2002:a05:6a21:6004:b0:3d0:88f5:f813 with SMTP id
 adf61e73a8af0-3d9b05238admr16697934637.11.1788414747753; 
 Wed, 02 Sep 2026 22:52:27 -0700 (PDT)
Received: from donnager-debian.. ([180.150.112.50])
 by smtp.gmail.com with ESMTPSA id
 a92af1059eb24-1431990a39bsm2770619c88.3.2026.09.02.22.52.22
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 02 Sep 2026 22:52:26 -0700 (PDT)
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
 qemu-riscv@nongnu.org, qemu-devel@nongnu.org,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@oss.qualcomm.com>
Subject: [PATCH v3 01/16] hw/riscv/aia: Take a MemoryRegion for the created
 devices
Date: Thu,  3 Sep 2026 15:21:15 +0930
Message-ID: <20260903055131.257903-2-joel@jms.id.au>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <20260903055131.257903-1-joel@jms.id.au>
References: <20260903055131.257903-1-joel@jms.id.au>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
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

Reviewed-by: Daniel Henrique Barboza <daniel.barboza@oss.qualcomm.com>
Reviewed-by: Alistair Francis <alistair.francis@wdc.com>
Reviewed-by: Philippe Mathieu-Daudé <philmd@oss.qualcomm.com>
Signed-off-by: Joel Stanley <joel@jms.id.au>
---
 hw/riscv/aia.h         | 3 ++-
 hw/riscv/aia.c         | 3 ++-
 hw/riscv/tt_atlantis.c | 3 ++-
 hw/riscv/virt.c        | 3 ++-
 4 files changed, 8 insertions(+), 4 deletions(-)

diff --git a/hw/riscv/aia.h b/hw/riscv/aia.h
index 3b6d7f962506..5df3292610e9 100644
--- a/hw/riscv/aia.h
+++ b/hw/riscv/aia.h
@@ -13,7 +13,8 @@
 
 uint32_t imsic_num_bits(uint32_t count);
 
-DeviceState *riscv_create_aia(bool msimode, int aia_guests,
+DeviceState *riscv_create_aia(MemoryRegion *container,
+                             bool msimode, int aia_guests,
                              uint32_t m_imsic_stride,
                              uint32_t s_imsic_stride,
                              uint16_t num_sources,
diff --git a/hw/riscv/aia.c b/hw/riscv/aia.c
index c1a5982856c5..e11382e512da 100644
--- a/hw/riscv/aia.c
+++ b/hw/riscv/aia.c
@@ -24,7 +24,8 @@ uint32_t imsic_num_bits(uint32_t count)
     return ret;
 }
 
-DeviceState *riscv_create_aia(bool msimode, int aia_guests,
+DeviceState *riscv_create_aia(MemoryRegion *container,
+                             bool msimode, int aia_guests,
                              uint32_t m_imsic_stride,
                              uint32_t s_imsic_stride,
                              uint16_t num_sources,
diff --git a/hw/riscv/tt_atlantis.c b/hw/riscv/tt_atlantis.c
index 812051a11fd4..f395236d88ab 100644
--- a/hw/riscv/tt_atlantis.c
+++ b/hw/riscv/tt_atlantis.c
@@ -498,7 +498,8 @@ static void tt_atlantis_machine_init(MachineState *machine)
                             &error_abort);
     sysbus_realize(SYS_BUS_DEVICE(&s->soc), &error_fatal);
 
-    s->irqchip = riscv_create_aia(true, TT_IMSIC_GUESTS,
+    s->irqchip = riscv_create_aia(system_memory,
+                                  true, TT_IMSIC_GUESTS,
                                   TT_IMSIC_STRIDE,
                                   TT_IMSIC_STRIDE,
                                   TT_IRQCHIP_NUM_SOURCES,
diff --git a/hw/riscv/virt.c b/hw/riscv/virt.c
index de7b99c6a51e..6480a3f0a9c0 100644
--- a/hw/riscv/virt.c
+++ b/hw/riscv/virt.c
@@ -809,8 +809,9 @@ static void virt_machine_init(MachineState *machine)
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


