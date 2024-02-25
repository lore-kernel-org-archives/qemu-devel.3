Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 11027C47DD9
	for <qemu-devel@archiver.kernel.org>; Sun, 25 Feb 2024 17:18:19 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1reI7Q-0001tl-1s; Sun, 25 Feb 2024 12:16:52 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1reI7O-0001sa-Qa
 for qemu-devel@nongnu.org; Sun, 25 Feb 2024 12:16:50 -0500
Received: from mail-wm1-x332.google.com ([2a00:1450:4864:20::332])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1reI7M-0003wV-LX
 for qemu-devel@nongnu.org; Sun, 25 Feb 2024 12:16:50 -0500
Received: by mail-wm1-x332.google.com with SMTP id
 5b1f17b1804b1-412a4a932f4so1526245e9.0
 for <qemu-devel@nongnu.org>; Sun, 25 Feb 2024 09:16:48 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1708881407; x=1709486207; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=cwzDlmu7+joT64q6lgoDz20T+b1NRYPG1wt4e7xF0MU=;
 b=RA5Ff0nswQF68hFCVjnzAqGpfIcCUpWYAfxEh7MIafWZl7bfLl14dGPni7Oe3frnYx
 YBHBN+ptiGyLNnOiUPuO6oHpZFSKo/FGB6Kf+7PEJsKC5SqVrYcGnwdgShX+5d0spDn1
 NojeOS8r5KCc6tqaQXwwvnIQGO7QTrkZwh/4ansm6vhTRW8HEiyQfIT/4v2y/FK6MyzA
 fc4fgkr+3IxUeymk5IEbEFkTpNlIazkK1qipzSZvCmy4b/81UKveri1HnI5zVxUI+5MC
 NO/d14eZZVn9gsmO4kv9cW5kRBRWHOi8h1n8qoeUnb3PmtJAo8K7x/zizenlZgGEXnpU
 rgKQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1708881407; x=1709486207;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=cwzDlmu7+joT64q6lgoDz20T+b1NRYPG1wt4e7xF0MU=;
 b=w4K6N//WFeK+KzbtTsZwN5LQuzo5e8CaGIi3H/H1ESQ3Yqu9lB3lDRzsyhTfuuH51f
 Q6YFlGXiTYNMNVFBNWLMCUfZMn5tp8QzrPEb+NPTr3SKYmze9c3KOKIlQEeRzFCjXZUW
 mNlObKpkCqQ4NSeZ8KuxxI8r/NS9+p9htlSUPXQo4Bb7C4/qq+axvMaWMhZMTLVUlRnh
 WkimqBa5c/jPrurjkr/BKs3ifDUchB93QWViS63dzgbPCccmA6hUGG/B5a7/X6B3gCUk
 D8Yi3YGTC0rtjlwqZL7fqJYOdw+4ScGKqQO+w4tCjY39wxzMuaoCwDkyVTMqYINu+V17
 qudw==
X-Gm-Message-State: AOJu0Yy28iQ5WZ6qfHPnhjgT6s+Hol2a1pVbM/37Nw1gcvfdfg5AqFPR
 bXFlXf3QULhZwBDqVd+D9GqEVFPC3mJ+Pql3zx2dZIFsRYdPb0yTbZw9n6v99cJsB0L8toaLd36
 o
X-Google-Smtp-Source: AGHT+IGDIX2D7AbqyFrO/24RCh5vKznW9+AVVhucB+k0Jge+FwpDWlNy2pQYV/U57X8P3Lxs6O20Aw==
X-Received: by 2002:a05:600c:41c2:b0:412:9018:74ca with SMTP id
 t2-20020a05600c41c200b00412901874camr3943606wmh.35.1708881406794; 
 Sun, 25 Feb 2024 09:16:46 -0800 (PST)
Received: from m1x-phil.lan ([176.176.164.69])
 by smtp.gmail.com with ESMTPSA id
 l6-20020a1c7906000000b0040fddaf9ff4sm9297419wme.40.2024.02.25.09.16.45
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Sun, 25 Feb 2024 09:16:46 -0800 (PST)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
To: qemu-devel@nongnu.org
Cc: qemu-ppc@nongnu.org, Leif Lindholm <quic_llindhol@quicinc.com>,
 Marcin Juszkiewicz <marcin.juszkiewicz@linaro.org>,
 BALATON Zoltan <balaton@eik.bme.hu>, Radoslaw Biernacki <rad@semihalf.com>,
 qemu-arm@nongnu.org, Peter Maydell <peter.maydell@linaro.org>,
 qemu-block@nongnu.org, John Snow <jsnow@redhat.com>,
 Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
Subject: [PATCH v2 1/3] hw/arm/sbsa-ref: Do not open-code
 ahci_ide_create_devs()
Date: Sun, 25 Feb 2024 18:16:35 +0100
Message-ID: <20240225171637.4709-2-philmd@linaro.org>
X-Mailer: git-send-email 2.41.0
In-Reply-To: <20240225171637.4709-1-philmd@linaro.org>
References: <20240225171637.4709-1-philmd@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::332;
 envelope-from=philmd@linaro.org; helo=mail-wm1-x332.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
 T_SCC_BODY_TEXT_LINE=-0.01 autolearn=unavailable autolearn_force=no
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

Use ahci_ide_create_devs() instead of open-coding it.
Not accessing AHCIDevice internals anymore allows to
remove "hw/ide/ahci_internal.h" (which isn't really a
public header).

Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
---
 hw/arm/sbsa-ref.c | 9 +--------
 1 file changed, 1 insertion(+), 8 deletions(-)

diff --git a/hw/arm/sbsa-ref.c b/hw/arm/sbsa-ref.c
index 5d3a574664..995c7be23e 100644
--- a/hw/arm/sbsa-ref.c
+++ b/hw/arm/sbsa-ref.c
@@ -37,7 +37,6 @@
 #include "hw/block/flash.h"
 #include "hw/boards.h"
 #include "hw/ide/internal.h"
-#include "hw/ide/ahci_internal.h"
 #include "hw/ide/ahci-sysbus.h"
 #include "hw/intc/arm_gicv3_common.h"
 #include "hw/intc/arm_gicv3_its_common.h"
@@ -572,7 +571,6 @@ static void create_ahci(const SBSAMachineState *sms)
     DriveInfo *hd[NUM_SATA_PORTS];
     SysbusAHCIState *sysahci;
     AHCIState *ahci;
-    int i;
 
     dev = qdev_new("sysbus-ahci");
     qdev_prop_set_uint32(dev, "num-ports", NUM_SATA_PORTS);
@@ -583,12 +581,7 @@ static void create_ahci(const SBSAMachineState *sms)
     sysahci = SYSBUS_AHCI(dev);
     ahci = &sysahci->ahci;
     ide_drive_get(hd, ARRAY_SIZE(hd));
-    for (i = 0; i < ahci->ports; i++) {
-        if (hd[i] == NULL) {
-            continue;
-        }
-        ide_bus_create_drive(&ahci->dev[i].port, 0, hd[i]);
-    }
+    ahci_ide_create_devs(ahci, hd);
 }
 
 static void create_xhci(const SBSAMachineState *sms)
-- 
2.41.0


