Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 532DCC5AD5A
	for <qemu-devel@archiver.kernel.org>; Wed, 12 Aug 2026 12:18:11 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wu7tY-0005Ta-Sg; Wed, 12 Aug 2026 08:17:21 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1wu7tN-0005Lq-H5
 for qemu-devel@nongnu.org; Wed, 12 Aug 2026 08:17:10 -0400
Received: from mail-wm1-x334.google.com ([2a00:1450:4864:20::334])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1wu7tL-0000At-1w
 for qemu-devel@nongnu.org; Wed, 12 Aug 2026 08:17:08 -0400
Received: by mail-wm1-x334.google.com with SMTP id
 5b1f17b1804b1-49802c418b5so7809645e9.1
 for <qemu-devel@nongnu.org>; Wed, 12 Aug 2026 05:17:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1786537025; x=1787141825; darn=nongnu.org;
 h=content-transfer-encoding:content-type:mime-version:references
 :in-reply-to:message-id:date:subject:to:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=/a90+RjxnTaZ+UVIjaZp+HdePMcz0aan2K71ZgqleNc=;
 b=iFW3pTZTTPjZMfZQZdFwPNp1RqKu92UFyucuA1kVBlaP87XKlNf/kqXcq0x/MQZq/z
 K4EZrJPVNcOgnhQGRGMqkt8RpRuuMHuGovPBAKMvElSpi1rFLhpoyYUTMmS5Yx6mt92t
 nUQDagLHS5qmsq+o2Kef5drvT1SUAaHVdr6NwuiVPc4b0rRWaYhVK0xMS5xobYxwGdAt
 SVWW7MetQYclZaxSVCspJ/EkmcFJYoTF02sIaqHPPiF+hjraep2Z1OVXQoFpQx/f2OTJ
 czoqtb4s5xIR4pf8toKNPPtPJveLMe8WpolTKeq5wOMjHJlObcIJOI8C3VP9hhSZ8hNQ
 hpmw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1786537025; x=1787141825;
 h=content-transfer-encoding:content-type:mime-version:references
 :in-reply-to:message-id:date:subject:to:from:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=/a90+RjxnTaZ+UVIjaZp+HdePMcz0aan2K71ZgqleNc=;
 b=mWQA1HW3lfdhYC4D6SCYjJcD9UEqLnnes7YwCxV6yotJswnfnYHg/SZXbjIGYYvzMX
 gn4bCln+mZsoXc47ndRKSg8VVBFyRMAJ36y2rJOXLW4/TLMGekCh4v3Pt0pncxubvh5Y
 dOIgUEnl+2ZJbwxQxlSLNkYERfRRMaHVkgis/ZrK4UlZPdmlq83SHe0lY78BBD7Vqz9z
 podl5ri6/LdKPYKJPGKo8dyhpYsIkxRj2PmAC3m6+kjdn8zT4xrmI1cg6cazHe4KkOGw
 tqRTl1MpvBLTPGC4qMqkK+yeXfLwQX94KfK6jkEFUyHNO0Sqsavb3M45878E4jmXNGGi
 1PMA==
X-Gm-Message-State: AOJu0YwU6epp033vvcDFaYWMjfcyfQ7gCEcM3iciNit2r/K7PmOgeBVF
 tIo/KXMOG19Xv2a9c4pPeN8nO6AhDAimQVBpiJMsgMXNl+/YQMHPhg9m0395vUk7UKp73NUo7Ut
 c4Nmp
X-Gm-Gg: AR+sD13nlYZd+YmQbr1b4tA36CRrG88JzN3/7BBomnUBBoUW7bGuRjJt8llMs0ukApV
 pvQE591oPlP36WO2EkPCbAeWD0OxMWJ5OqBSC/JpsPAzgtHvbZjPKePvD14bEIwMwq0mzSVZopG
 TZLw3YdnzlRlqwuUI7i/ZM62J2cKy3b6KVWDCoThr77S7LfkaX+7datWN7djTxe75I0EG6H8csM
 SAHDL76iffYzAvRce7a8rCqPYhpXkaecX/ELyIgqecsSgyB9qNemeTxBcFgTYHl/d+aNu/qKyZZ
 cIdLZO3aqVtRl2j93x4yY7cBnYOqRwXhG6RiWpEcJAmyjATDzT0wZ1gSZSdT61pb1OE2SPe3DvY
 Tt90Sr4PlWJ1KJG9UEAY0us0nmylqCe6Qc4M5vvsh3R7eBCRGA/Pm9+yCUpR42x2PXMHgvyobS1
 wol3boAFb027Kp+EcPnsUOCq+dl7s0lU0KAy1saTf3RAp84WZuwvNBQ6+SxTP9eQT/7E6voS9gz
 byb6Zb+kZsYuqcMZyeHKBJmzz/PgxffmWas7HHbXQbokcWOGxD4vuN1dYkEt2O9dheDCDYKBxGS
 5lVn
X-Received: by 2002:a05:600c:1d03:b0:499:7ce1:d8af with SMTP id
 5b1f17b1804b1-4997ce1db38mr47316355e9.1.1786537025215; 
 Wed, 12 Aug 2026 05:17:05 -0700 (PDT)
Received: from lanath.. (wildly.archaic.org.uk. [81.2.115.145])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-4997ad79e5csm36963805e9.3.2026.08.12.05.17.04
 for <qemu-devel@nongnu.org>
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 12 Aug 2026 05:17:04 -0700 (PDT)
From: Peter Maydell <peter.maydell@linaro.org>
To: qemu-devel@nongnu.org
Subject: [PULL 25/26] hw/arm/raspi4b: fix guest never seeing more than ~1 GiB
 of RAM
Date: Wed, 12 Aug 2026 13:16:21 +0100
Message-ID: <20260812121622.649730-26-peter.maydell@linaro.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260812121622.649730-1-peter.maydell@linaro.org>
References: <20260812121622.649730-1-peter.maydell@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::334;
 envelope-from=peter.maydell@linaro.org; helo=mail-wm1-x334.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
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

From: Marcelo Manzo <marcelomanzo@gmail.com>

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
Reviewed-by: Philippe Mathieu-Daudé <philmd@oss.qualcomm.com>
Message-id: 20260811143539.7835-2-marcelomanzo@gmail.com
Signed-off-by: Peter Maydell <peter.maydell@linaro.org>
---
 hw/arm/raspi4b.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/hw/arm/raspi4b.c b/hw/arm/raspi4b.c
index 06aeb8db01..e1595a875f 100644
--- a/hw/arm/raspi4b.c
+++ b/hw/arm/raspi4b.c
@@ -85,7 +85,7 @@ static void raspi4_modify_dtb(const struct arm_boot_info *info, void *fdt)
 
     ram_size = board_ram_size(info->board_id);
 
-    if (info->ram_size > UPPER_RAM_BASE) {
+    if (ram_size > UPPER_RAM_BASE) {
         raspi_add_memory_node(fdt, UPPER_RAM_BASE, ram_size - UPPER_RAM_BASE);
     }
 }
-- 
2.43.0


