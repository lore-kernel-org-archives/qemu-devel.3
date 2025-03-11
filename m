Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5293AC282EC
	for <qemu-devel@archiver.kernel.org>; Tue, 11 Mar 2025 13:13:56 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1trzKO-0007Py-LP; Tue, 11 Mar 2025 09:07:24 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <npiggin@gmail.com>)
 id 1trzFD-0006Gz-S6; Tue, 11 Mar 2025 09:02:08 -0400
Received: from mail-pj1-x1030.google.com ([2607:f8b0:4864:20::1030])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <npiggin@gmail.com>)
 id 1trzFB-0000NK-2c; Tue, 11 Mar 2025 09:02:03 -0400
Received: by mail-pj1-x1030.google.com with SMTP id
 98e67ed59e1d1-2f9b9c0088fso9069439a91.0; 
 Tue, 11 Mar 2025 06:01:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1741698115; x=1742302915; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=s/hwfz8W3nE/NCo2dN8T5chquYKvDoTqUnc1wA+QdPA=;
 b=O/QuBAJs56ueGZj4zD8MuKojOmWcrp5l6QXRuxnZn/nTAyXUs1wjd6APbuyiNjdRQd
 solIe1mIl9LIfGrqDuyrnGUjjwYKxR67PwPAwvQuRg6V8ipwmr/BdstjSjpz8XXmb5EF
 JeLF5Pr2SBrFL0MRxCX0Q3s2iobFIZTBxLD5Tbp+aUp2Lg7iRFLShYTr3yTMaPimuKGD
 HtZa5nLuvULnZjHRmHVdtRfNTsh/CxX5j/HKWUbQbc6y1i0oJHx5Lqm08/skEPacs+A+
 iPmgB0QAXYyHQ4KPU2WrAvXai4lNBh7qTi8dYo3oQIlu+Z0aEY143mczC5d8zNoxSmk7
 V+Zg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1741698115; x=1742302915;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=s/hwfz8W3nE/NCo2dN8T5chquYKvDoTqUnc1wA+QdPA=;
 b=h+dQJEI3hCog9DQVtduQEK9Qw17eeNHg2xmS+sXqr6gNm/ixXEPesWZSj8VuG+ycX3
 O+T7vbTaZlAWqVuMJTDo7jjtYJn5ipz4L51xRMHw2xsypFyFCmyA8/Dwg5/dEH4gg7M8
 bo+MCeBtAm6VrBFEFCGkCpCPxYG+IYzlRVSTfmg7ohi7KWfcmoiTEeODRWiBpBr4qFm4
 0o2E+5JqFezWoQG/t4sSL3Isbpqh5oXxxZK9TmOBKn2JEGE7wT1g456mtaQiaXrOpWdB
 X5F9bVMpBBVDUkSQEbIG0jVQf0r5QDR/DpVRjBdY/R3TTHUcJwK66NjsnShcSU86vFPJ
 aGkw==
X-Forwarded-Encrypted: i=1;
 AJvYcCWYVe+ZYGJjCZ+inPdzPXHDvb6NksycyupyOCv8o0QrR5e0lqdbHy+Jt7bUtcPUbAsATkhPlU7QKQ==@nongnu.org
X-Gm-Message-State: AOJu0YyabGuBYQ/ZemWWa/riuwo+yfXuhEB48Mm8PwP8fckfMX/7bRox
 iwRuuyvymTDMOCnvM3HGZwkmRYTVObObZlD35lX4MC5Fdbw+y4CiBhxifA==
X-Gm-Gg: ASbGnctxMmqtSmHihD+qlX2672UbuL2Lskn6OESLcqfv7oaKqq/2daJUdjz9MCVA70Z
 +A5oX2g4qtUO5Ri9xyOX6c9SifSqEg0FcZMBQ+bihfSYsEYkxQ39Qd9vPfvd+G2Qdj6Aitq7tw1
 tXYPEkb7iOuamMZ43iiGSMI6Rgs5/21tC3qMOkgmPzxjPUR8oP/ujGuguJhUt2UxGUu/9etIKXs
 2cvPuPltq6b9jSPm44cZUUEzdKYHyP/7KjtYCFN+jhbu29btASLIT5Kk+CGT257NSFz/VBTwi1/
 sKO2kE0wq8fE2I/Dbiu7xEU0MMtladdk8c9tXg8atoAUTtvNz85ppeTI/jw+LQ==
X-Google-Smtp-Source: AGHT+IEfSr0Gudn4GDMIT4yBrRsINF1KjueLA3K/k+IuqK9TzELvKvXpXWwdPEKEfe5NbCoDvTjnCQ==
X-Received: by 2002:a17:90b:528a:b0:2ee:5c9b:35c0 with SMTP id
 98e67ed59e1d1-30100544832mr4123620a91.9.1741698115514; 
 Tue, 11 Mar 2025 06:01:55 -0700 (PDT)
Received: from wheely.local0.net ([118.208.151.101])
 by smtp.gmail.com with ESMTPSA id
 98e67ed59e1d1-2ff4e773dddsm11822318a91.12.2025.03.11.06.01.53
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 11 Mar 2025 06:01:55 -0700 (PDT)
From: Nicholas Piggin <npiggin@gmail.com>
To: qemu-devel@nongnu.org
Cc: Nicholas Piggin <npiggin@gmail.com>, qemu-ppc@nongnu.org,
 BALATON Zoltan <balaton@eik.bme.hu>
Subject: [PULL 69/72] ppc/amigaone: Add default environment
Date: Tue, 11 Mar 2025 22:58:03 +1000
Message-ID: <20250311125815.903177-70-npiggin@gmail.com>
X-Mailer: git-send-email 2.47.1
In-Reply-To: <20250311125815.903177-1-npiggin@gmail.com>
References: <20250311125815.903177-1-npiggin@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::1030;
 envelope-from=npiggin@gmail.com; helo=mail-pj1-x1030.google.com
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

From: BALATON Zoltan <balaton@eik.bme.hu>

Initialise empty NVRAM with default values. This also enables IDE UDMA
mode in AmigaOS that is faster but has to be enabled in environment
due to problems with real hardware but that does not affect emulation
so we can use faster defaults here.

Signed-off-by: BALATON Zoltan <balaton@eik.bme.hu>
Reviewed-by: Nicholas Piggin <npiggin@gmail.com>
Message-ID: <4d63f88191612329e0ca8102c7c0d4fc626dc372.1740673173.git.balaton@eik.bme.hu>
Signed-off-by: Nicholas Piggin <npiggin@gmail.com>
---
 hw/ppc/amigaone.c | 37 ++++++++++++++++++++++++++++++++++++-
 1 file changed, 36 insertions(+), 1 deletion(-)

diff --git a/hw/ppc/amigaone.c b/hw/ppc/amigaone.c
index feb2cf452c..1c6f2a944d 100644
--- a/hw/ppc/amigaone.c
+++ b/hw/ppc/amigaone.c
@@ -52,6 +52,28 @@ static const char dummy_fw[] = {
 #define NVRAM_ADDR 0xfd0e0000
 #define NVRAM_SIZE (4 * KiB)
 
+static char default_env[] =
+    "baudrate=115200\0"
+    "stdout=vga\0"
+    "stdin=ps2kbd\0"
+    "bootcmd=boota; menu; run menuboot_cmd\0"
+    "boot1=ide\0"
+    "boot2=cdrom\0"
+    "boota_timeout=3\0"
+    "ide_doreset=on\0"
+    "pci_irqa=9\0"
+    "pci_irqa_select=level\0"
+    "pci_irqb=10\0"
+    "pci_irqb_select=level\0"
+    "pci_irqc=11\0"
+    "pci_irqc_select=level\0"
+    "pci_irqd=7\0"
+    "pci_irqd_select=level\0"
+    "a1ide_irq=1111\0"
+    "a1ide_xfer=FFFF\0";
+#define CRC32_DEFAULT_ENV 0xb5548481
+#define CRC32_ALL_ZEROS   0x603b0489
+
 #define TYPE_A1_NVRAM "a1-nvram"
 OBJECT_DECLARE_SIMPLE_TYPE(A1NVRAMState, A1_NVRAM)
 
@@ -94,7 +116,7 @@ static void nvram_realize(DeviceState *dev, Error **errp)
 {
     A1NVRAMState *s = A1_NVRAM(dev);
     void *p;
-    uint32_t *c;
+    uint32_t crc, *c;
 
     memory_region_init_rom_device(&s->mr, NULL, &nvram_ops, s, "nvram",
                                   NVRAM_SIZE, &error_fatal);
@@ -113,12 +135,25 @@ static void nvram_realize(DeviceState *dev, Error **errp)
             return;
         }
     }
+    crc = crc32(0, p + 4, NVRAM_SIZE - 4);
+    if (crc == CRC32_ALL_ZEROS) { /* If env is uninitialized set default */
+        *c = cpu_to_be32(CRC32_DEFAULT_ENV);
+        /* Also copies terminating \0 as env is terminated by \0\0 */
+        memcpy(p + 4, default_env, sizeof(default_env));
+        if (s->blk) {
+            blk_pwrite(s->blk, 0, sizeof(crc) + sizeof(default_env), p, 0);
+        }
+        return;
+    }
     if (*c == 0) {
         *c = cpu_to_be32(crc32(0, p + 4, NVRAM_SIZE - 4));
         if (s->blk) {
             blk_pwrite(s->blk, 0, 4, p, 0);
         }
     }
+    if (be32_to_cpu(*c) != crc) {
+        warn_report("NVRAM checksum mismatch");
+    }
 }
 
 static const Property nvram_properties[] = {
-- 
2.47.1


