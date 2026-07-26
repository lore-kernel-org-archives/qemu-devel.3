Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A3BD1C53200
	for <qemu-devel@archiver.kernel.org>; Sun, 26 Jul 2026 14:41:47 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wo02b-0003Bh-Ej; Sun, 26 Jul 2026 10:41:21 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <marcelomanzo@gmail.com>)
 id 1wo02Z-00035q-4P
 for qemu-devel@nongnu.org; Sun, 26 Jul 2026 10:41:19 -0400
Received: from mail-vs1-xe2a.google.com ([2607:f8b0:4864:20::e2a])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <marcelomanzo@gmail.com>)
 id 1wo02W-00050t-IT
 for qemu-devel@nongnu.org; Sun, 26 Jul 2026 10:41:18 -0400
Received: by mail-vs1-xe2a.google.com with SMTP id
 ada2fe7eead31-737f6e70678so1299328137.0
 for <qemu-devel@nongnu.org>; Sun, 26 Jul 2026 07:41:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1785076875; x=1785681675; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=euPvdh95iQPl9fiq2XC5We3plNW5BhTWufPyosLAmNM=;
 b=MUMRiyDRYc3k2h5InpHNlVlkv65zYgBiQmdCvCUSWpG3yR/ejF86k99RvTHNsk6TFE
 cFy1YRZwHqC8+hpGrwxnQuQwJi4ajLpvSzchvJSRGUHEKVx6eh1AcYviTdyEKzIFSGR4
 OQDphPKHIQPTD13rSlKeLSKPLg7mjCBQb2n0qu0/u+NMvBDJ0Vcv1gJVbEUscIR1pUEb
 wWwWcpvLzEyxlh3+uA7P3h9rBJ0W5k7L1dvYqEBlNe21sS9UE1YdvocP2R0V/3VJq9jK
 RgH5lkgrWBn4mtcHFF3AIemtfaZerzmMVMpJb89Vr9PLWV2ttxiigaxvrOWqh8xCviji
 2/pg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1785076875; x=1785681675;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to:content-type;
 bh=euPvdh95iQPl9fiq2XC5We3plNW5BhTWufPyosLAmNM=;
 b=FX9OL2RHC2vKUlgImpZw85obImNQvlHgDBMnzWvA2Qu4LOwdVZjScU4RWBRq7pVwwO
 hhXa4ZbE21TlKckzvru27Di4OVR3EzJzGohaTn4LSyaPbHN8L0g3PMLBuHDxCa6cCpAf
 V2iDxqt+jSAeWY1zTRjbVG0KC0q8El2ePnlYqtIiq69fPuHD3cymCkQ4zhuO/nD77B81
 96mcZdbguIk6A4hKfkZzfo0wtOydYe7tuMHWx5+d2c+EARe3L2/zt8KFZ84t4y7dvCiX
 JtrsefxgsfZ46OX97pvPQAeJ7m5Af9n9YmZAzVcLGQLEnxCBRcz76zSbbv2eQnS7aNE2
 pTyw==
X-Gm-Message-State: AOJu0Yzp3/QiQM12YufG2CLtsBU667uwZtzlBFqMQNCQFb6eMXsfiySP
 7Rr0isUwjemi5MVK9PwjZHIhzsPeqdK9O/EjRCwfqoFSryPmnhCdtRUD6WzDgw==
X-Gm-Gg: AR+sD12kymhC0r4F7lOGNzV2D5Hl8k1377zT8h4oTkVmo0a4ASKoKWznJ6QPXP0ysWO
 2SW7LgvvU8QeaZrfz4idMhgc2xcnkL+rDd/UZQTc0+0n5GK6uF5NwBudiSjFtPy8C00xTJXAC8+
 JqNneddJpdQ799slV8jTxyOft/DAdHs7JQTZeRzQUwQGLM1x+JCHC72VXEQ6h2EArhjLDQgjdPl
 Euit4rb0thFEOxOvO2A8EikW04eIrFRcR5TPR7QjNvkTnO6SHU3e+pm3c6Ld4OS0OJKZu965rCd
 XZETeL4a3rVrg3MTjxaC51Trzpga0OQ7/aEHRJquwvF1mLTpOdOeCSxYyek5ZW3m2Fuvv2d27cV
 62RGXVvEffOXDbd8FjGdQdHfS35Uj/s4eAwZasFSfRR7vyXLluIrD5ImGJ2L6wl7DluYAeULfhk
 RAAWjyhYEQo5Zjox4MNIu+taTtPmRAJVyc
X-Received: by 2002:a05:6102:3ec8:b0:738:bf0f:d0c6 with SMTP id
 ada2fe7eead31-7503acf2e29mr3795651137.0.1785076875417; 
 Sun, 26 Jul 2026 07:41:15 -0700 (PDT)
Received: from localhost.localdomain ([146.71.8.128])
 by smtp.gmail.com with ESMTPSA id
 ada2fe7eead31-7503436f542sm3682735137.4.2026.07.26.07.41.14
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Sun, 26 Jul 2026 07:41:15 -0700 (PDT)
From: Marcelo Manzo <marcelomanzo@gmail.com>
To: qemu-devel@nongnu.org,
	qemu-arm@nongnu.org
Cc: Peter Maydell <peter.maydell@linaro.org>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@mailo.com>,
 Marcelo Manzo <marcelomanzo@gmail.com>
Subject: [PATCH 1/2] hw/arm/raspi4b: fix guest never seeing more than ~1 GiB
 of RAM
Date: Sun, 26 Jul 2026 10:41:11 -0400
Message-ID: <20260726144112.56321-2-marcelomanzo@gmail.com>
X-Mailer: git-send-email 2.47.1
In-Reply-To: <20260726144112.56321-1-marcelomanzo@gmail.com>
References: <20260726144112.56321-1-marcelomanzo@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::e2a;
 envelope-from=marcelomanzo@gmail.com; helo=mail-vs1-xe2a.google.com
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

raspi4_modify_dtb() decides whether to add a second memory node above
the 1 GiB peripheral hole by checking info->ram_size -- but that field
is the boot loader's RAM budget for loading the kernel/initrd/dtb
image, itself always capped to at most UPPER_RAM_BASE - vcram_size by
raspi_base_machine_init(). Since that capped value can never exceed
UPPER_RAM_BASE by construction, the condition was never true for any
raspi4b configuration, and the second node was never added: the guest
never saw more than ~1 GiB of its nominal RAM, regardless of the
machine's actual size.

board_ram_size(info->board_id), computed one line above in the same
function, is the value that was actually needed -- the board's real
total RAM, not the boot loader's own budget for where it's allowed to
place the kernel image.

Confirmed via direct measurement inside the guest ("free -h" /
/proc/meminfo) on raspi4b's default 2 GiB configuration, before and
after:

    before: MemTotal:  943524 kB (~921 MiB)
    after:  MemTotal: 1905824 kB (~1861 MiB)

Also verified against two real, unmodified Raspberry Pi OS releases
(Debian 11/Bullseye and Debian 13/Trixie): both now report ~1.8 GiB of
usable RAM instead of ~900 MiB, with clean boots, working SSH, and no
kernel errors on either.

Signed-off-by: Marcelo Manzo <marcelomanzo@gmail.com>
---
 hw/arm/raspi4b.c | 14 +++++++++++++-
 1 file changed, 13 insertions(+), 1 deletion(-)

diff --git a/hw/arm/raspi4b.c b/hw/arm/raspi4b.c
index b92840e1b6..ca246ebb35 100644
--- a/hw/arm/raspi4b.c
+++ b/hw/arm/raspi4b.c
@@ -64,7 +64,19 @@ static void raspi4_modify_dtb(const struct arm_boot_info *info, void *fdt)
 
     ram_size = board_ram_size(info->board_id);
 
-    if (info->ram_size > UPPER_RAM_BASE) {
+    /*
+     * Bug: this used to compare info->ram_size (the boot-loader's RAM
+     * budget for loading the kernel/initrd/dtb, itself capped to at most
+     * UPPER_RAM_BASE - vcram_size by raspi_base_machine_init()) rather
+     * than the board's actual total RAM computed just above. Since that
+     * capped value can never exceed UPPER_RAM_BASE by construction, this
+     * condition was never true for any raspi4b configuration -- the
+     * second memory node was never added, and the guest never saw more
+     * than ~1 GiB regardless of the machine's nominal RAM size. Confirmed
+     * via direct measurement: default -m 2G returns ~916 MiB from
+     * "free -h" inside the guest, not 2 GiB.
+     */
+    if (ram_size > UPPER_RAM_BASE) {
         raspi_add_memory_node(fdt, UPPER_RAM_BASE, ram_size - UPPER_RAM_BASE);
     }
 }
-- 
2.47.1


