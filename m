Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E6337CCD193
	for <qemu-devel@archiver.kernel.org>; Thu, 23 Oct 2025 04:18:02 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vBmk0-00017c-NW; Thu, 23 Oct 2025 00:15:56 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alistair23@gmail.com>)
 id 1vBmjx-00015i-6N
 for qemu-devel@nongnu.org; Thu, 23 Oct 2025 00:15:53 -0400
Received: from mail-pj1-x1035.google.com ([2607:f8b0:4864:20::1035])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <alistair23@gmail.com>)
 id 1vBmjr-0007NF-1m
 for qemu-devel@nongnu.org; Thu, 23 Oct 2025 00:15:52 -0400
Received: by mail-pj1-x1035.google.com with SMTP id
 98e67ed59e1d1-33bafd5d2adso360653a91.3
 for <qemu-devel@nongnu.org>; Wed, 22 Oct 2025 21:15:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1761192944; x=1761797744; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=epTAxD5qTIBr78ty+Lt7XQcrxEgeR2/1ctmBBVhqSCg=;
 b=eMfSEPF1BvTxu5xHqDgDCPX7f6Z8LhfaweBWr5DMcHxRHyeVyKgB/+PxO+7UFP4R+/
 f9zCEz+xwBXBGfPXKJFaqYFFHA7X0Mvq8/Ss/FYecxdgFcVDPWSX0S+ACWcn9sZ6zRY0
 ynHZAxEDnkH9gg3utFdgrfh0pepgX68fijBQDrqGp7uwIP2V3zN/Em0ptiNUmXUHJy/N
 h/Mi1nkDjOD4BKCkCPd+ZjG8ZqgRH93hwKI8iZ++WIJFp24v8fMVZg+dZr7kQ0FbPgxr
 Dt1DASQP32coQNWpYky9fWhaaTfaaRbnBhuaARtG95J2PnTCgK1ugb2ltxbzVguufww7
 yl9w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1761192944; x=1761797744;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=epTAxD5qTIBr78ty+Lt7XQcrxEgeR2/1ctmBBVhqSCg=;
 b=H6BNl67vilLAScDtViKdPrPlvVgKxRpBfhHUKnV0AB6D+2LNUipJttAKvk3WvAUzej
 QyLh4eMURWjrvQ3/MKrvFPcfnQYycL0q0payaDwP78OUhpUjEqNVdTtpUF9NDnZ6p666
 qZy1ctiQnmOa2Lvz90wcLwyNkiqydiPXERGXGWI0trtjLUVu+5ILo2QIFftfq3vYfBoT
 v5vSP6QF0+U7pyl6ko3KgkaXAaULFAoE6lXUrSzPzatu8o9xqeFtgEKNZTJ7LcJgVybp
 5Ah7QRc/J7q8TZIyvSBy+qf+op90TujA3upJqIaoUiPOJ+rYpcQ5yGtv/+DbXKmThJgl
 Wdng==
X-Gm-Message-State: AOJu0YxPq9mhruCXf4UmZC6tqkwiuf4ejw8ACO9eD2sxbRZZdi+p8vwZ
 OqtOJGtVIW9a8RL1EeDoEz2VcDnxr+AKtzdWZMh0kw1x72I8lyKb9LFlrEGvMw==
X-Gm-Gg: ASbGnct+V8SXVGYsPbkyEA52XodEs/tM3i7piqfZM0ZGzHEBsg9D81GDe+IgT+b/uXI
 16u1hlb+sSUueMvLr2iIt+OKWC++k8yIPlwrTtvWNkI9Mtlc2WViSPO64KVusG//EsPvfUTb/bZ
 dABTPVnJB4NZA/BVnKvr6fKFwoG9B3c+rz98a0L/9uquq+PxLSViWPdroOt2pQ6WHHSBtRpiOnX
 Mo++XlpG+5os4K7jnz3J/l+VeM9M+0lMSB7x07dbyN2JqsP2c+lR/rAGdcGZQUcpHGAE0rRkS5D
 pUPlc1V9+xO07VHsVZlvPWSKJQtFaNJ0CvYgXnrPuNpHTS6B05RIM2jWeVKOuNP/IsXLLer0NNY
 PRJ/GlNU+T+mZfOVuVVrxeZYzk5Kox+UeM8sCWTCqmg2rdxJEwY8ubIlG6UxjVfrIK6eBqVZKfM
 GYH56xcXtICxvexY46IJp9VBjXyvskf9pDQ5vLBX8XDzqyw/UnP4u4RGClwwy5KfO14uYEA9L7a
 oZCRfPH+fJ+meXmhaYI
X-Google-Smtp-Source: AGHT+IEM1tu9ciJ40IrL8FLd5iIlwX64ckTx4UuV0QP6wR++j1/7JiOfoJGF9AH/4uWvXHDeNcAe6Q==
X-Received: by 2002:a17:90b:5291:b0:33b:cbb2:31ed with SMTP id
 98e67ed59e1d1-33bcec1b599mr28324363a91.0.1761192944123; 
 Wed, 22 Oct 2025 21:15:44 -0700 (PDT)
Received: from toolbx.alistair23.me
 (2403-580b-97e8-0-82ce-f179-8a79-69f4.ip6.aussiebb.net.
 [2403:580b:97e8:0:82ce:f179:8a79:69f4])
 by smtp.gmail.com with ESMTPSA id
 d2e1a72fcca58-7a274abe5f0sm961640b3a.34.2025.10.22.21.15.41
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 22 Oct 2025 21:15:43 -0700 (PDT)
From: alistair23@gmail.com
X-Google-Original-From: alistair.francis@wdc.com
To: qemu-devel@nongnu.org
Cc: alistair23@gmail.com, Guenter Roeck <linux@roeck-us.net>,
 Alistair Francis <alistair.francis@wdc.com>
Subject: [PULL 17/37] microchip icicle: Enable PCS on Cadence Ethernet
Date: Thu, 23 Oct 2025 14:14:15 +1000
Message-ID: <20251023041435.1775208-18-alistair.francis@wdc.com>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <20251023041435.1775208-1-alistair.francis@wdc.com>
References: <20251023041435.1775208-1-alistair.francis@wdc.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::1035;
 envelope-from=alistair23@gmail.com; helo=mail-pj1-x1035.google.com
X-Spam_score_int: -17
X-Spam_score: -1.8
X-Spam_bar: -
X-Spam_report: (-1.8 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 FREEMAIL_ENVFROM_END_DIGIT=0.25, FREEMAIL_FROM=0.001,
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

From: Guenter Roeck <linux@roeck-us.net>

PCS needs to be enabled for SGMII to be supported by the Linux kernel.

Signed-off-by: Guenter Roeck <linux@roeck-us.net>
Acked-by: Alistair Francis <alistair.francis@wdc.com>
Message-ID: <20251004200049.871646-5-linux@roeck-us.net>
Signed-off-by: Alistair Francis <alistair.francis@wdc.com>
---
 hw/riscv/microchip_pfsoc.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/hw/riscv/microchip_pfsoc.c b/hw/riscv/microchip_pfsoc.c
index 9fbfba8ece..4c939d8e96 100644
--- a/hw/riscv/microchip_pfsoc.c
+++ b/hw/riscv/microchip_pfsoc.c
@@ -415,6 +415,7 @@ static void microchip_pfsoc_soc_realize(DeviceState *dev, Error **errp)
     object_property_set_int(OBJECT(&s->gem0), "revision", GEM_REVISION, errp);
     object_property_set_int(OBJECT(&s->gem0), "phy-addr", 8, errp);
     object_property_set_bool(OBJECT(&s->gem0), "phy-connected", false, errp);
+    object_property_set_bool(OBJECT(&s->gem0), "pcs-enabled", true, errp);
 
     sysbus_realize(SYS_BUS_DEVICE(&s->gem0), errp);
     sysbus_mmio_map(SYS_BUS_DEVICE(&s->gem0), 0,
@@ -426,6 +427,7 @@ static void microchip_pfsoc_soc_realize(DeviceState *dev, Error **errp)
     object_property_set_int(OBJECT(&s->gem1), "phy-addr", 9, errp);
     object_property_set_link(OBJECT(&s->gem1), "phy-consumer",
                              OBJECT(&s->gem0), errp);
+    object_property_set_bool(OBJECT(&s->gem1), "pcs-enabled", true, errp);
     sysbus_realize(SYS_BUS_DEVICE(&s->gem1), errp);
     sysbus_mmio_map(SYS_BUS_DEVICE(&s->gem1), 0,
                     memmap[MICROCHIP_PFSOC_GEM1].base);
-- 
2.51.0


