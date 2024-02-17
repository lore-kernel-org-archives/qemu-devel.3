Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8B6CCC48BC3
	for <qemu-devel@archiver.kernel.org>; Sat, 17 Feb 2024 10:47:57 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rbIDi-0008Db-03; Sat, 17 Feb 2024 05:46:58 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <shentey@gmail.com>) id 1rbIDg-0008DC-Ad
 for qemu-devel@nongnu.org; Sat, 17 Feb 2024 05:46:56 -0500
Received: from mail-ej1-x62b.google.com ([2a00:1450:4864:20::62b])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <shentey@gmail.com>) id 1rbIDe-0006C1-Pc
 for qemu-devel@nongnu.org; Sat, 17 Feb 2024 05:46:56 -0500
Received: by mail-ej1-x62b.google.com with SMTP id
 a640c23a62f3a-a29c4bbb2f4so375452766b.1
 for <qemu-devel@nongnu.org>; Sat, 17 Feb 2024 02:46:54 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1708166812; x=1708771612; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to;
 bh=IDieyL3NhRm4W1GAhBH3itBIh81iBVvz9eXNdLzU4b4=;
 b=FzpcbeE/TebJ3DK+S556HuCKjbitpFhqHp7Yoe+haPh1WS1mJqcDKXFvDFUEibED9d
 czzh10v+Hu4xnHt69S23JncyV5WfeLqM0rbyrriMTcheErP6Yy0jRF6HwYvgn6cFpJaZ
 +2pWvwE9i0GNzkfej/C8hV1DnvUzfHNhnUHVhgBkmgzmfTTP30qVXDqu3/6rEHxFtMeH
 EmoCVyz2JV+pQ+loswuP8toApJXv+6HJCQNfIfGMgBwRr4vu2rryRTQoI7qF0veStNqM
 EJK9bkHF5wJtkSoV/BeHe25xg/WBJM01sT98fOF+GlIxoSrbVn38iy8+9XUViepdWypk
 HqOQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1708166812; x=1708771612;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=IDieyL3NhRm4W1GAhBH3itBIh81iBVvz9eXNdLzU4b4=;
 b=oxQuoZYDG5MgKmlKsS4Bc/gThQl9LaD+NBbZwdKgkImOJSrruxgrrxOkt/L7LvRj3/
 dkp1Cw7Tcuk76jaxePeuRz058tZXECtQJ+1VPqa4ma+F6ED/MI3JJ10qMiLKBqec7mtd
 3gP0Eh36B+u7lS/InxH832UjKsW98bPgk2/d479D9oTZSO1fjJWw1I062FCujt9s3wmD
 0yOgm2odNlMdoiNsClppZLG1wzVUR40lszxm52yuP1W9rjXNW9DdjERT/qaPqH4bYFCD
 yxrIb1DkQ92kPcuxiRGdM8vHTWkQJ4YV4Bl4As7NEEc2RTs+w9ro2f+368bp4HGNnb5g
 I6Ag==
X-Gm-Message-State: AOJu0YzI2jby82wNV8iWr36q0/+FxtJuuugKotL7ojSlz9MT3tsXUZdj
 tQpVul6tiSnyc2jwDHobni0hK/PIBNNnjW5gpoxW4PSP/gmwHgLutXpSupBE
X-Google-Smtp-Source: AGHT+IER+uAPD3X/T5rUcnPKkXgB0Nf+mubZQfTUZxW/ps+f4nHKWQAIWJrga8qRvyJsvWUz/C4S+Q==
X-Received: by 2002:a17:906:f343:b0:a3d:643f:1cd4 with SMTP id
 hg3-20020a170906f34300b00a3d643f1cd4mr5304682ejb.48.1708166811968; 
 Sat, 17 Feb 2024 02:46:51 -0800 (PST)
Received: from archlinux.. (dynamic-089-012-016-210.89.12.pool.telefonica.de.
 [89.12.16.210]) by smtp.gmail.com with ESMTPSA id
 vw15-20020a170907a70f00b00a3cf7711d40sm872992ejc.131.2024.02.17.02.46.51
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sat, 17 Feb 2024 02:46:51 -0800 (PST)
From: Bernhard Beschow <shentey@gmail.com>
To: qemu-devel@nongnu.org
Cc: Richard Henderson <richard.henderson@linaro.org>,
 Paolo Bonzini <pbonzini@redhat.com>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 "Michael S. Tsirkin" <mst@redhat.com>,
 Eduardo Habkost <eduardo@habkost.net>,
 Marcel Apfelbaum <marcel.apfelbaum@gmail.com>,
 Bernhard Beschow <shentey@gmail.com>
Subject: [PATCH] hw/i386/pc_q35: Populate interrupt handlers before realizing
 LPC PCI function
Date: Sat, 17 Feb 2024 11:46:44 +0100
Message-ID: <20240217104644.19755-1-shentey@gmail.com>
X-Mailer: git-send-email 2.43.2
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::62b;
 envelope-from=shentey@gmail.com; helo=mail-ej1-x62b.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, FREEMAIL_FROM=0.001,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
 T_SCC_BODY_TEXT_LINE=-0.01 autolearn=ham autolearn_force=no
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

The interrupt handlers need to be populated before the device is realized since
internal devices such as the RTC are wired during realize(). If the interrupt
handlers aren't populated, devices such as the RTC will be wired with a NULL
interrupt handler, i.e. MC146818RtcState::irq is NULL.

Fixes: fc11ca08bc29 "hw/i386/q35: Realize LPC PCI function before accessing it"

Cc: Philippe Mathieu-Daudé <philmd@linaro.org>
Signed-off-by: Bernhard Beschow <shentey@gmail.com>
---
 hw/i386/pc_q35.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/hw/i386/pc_q35.c b/hw/i386/pc_q35.c
index d346fa3b1d..43675bf597 100644
--- a/hw/i386/pc_q35.c
+++ b/hw/i386/pc_q35.c
@@ -240,10 +240,10 @@ static void pc_q35_init(MachineState *machine)
     lpc_dev = DEVICE(lpc);
     qdev_prop_set_bit(lpc_dev, "smm-enabled",
                       x86_machine_is_smm_enabled(x86ms));
-    pci_realize_and_unref(lpc, host_bus, &error_fatal);
     for (i = 0; i < IOAPIC_NUM_PINS; i++) {
         qdev_connect_gpio_out_named(lpc_dev, ICH9_GPIO_GSI, i, x86ms->gsi[i]);
     }
+    pci_realize_and_unref(lpc, host_bus, &error_fatal);
 
     rtc_state = ISA_DEVICE(object_resolve_path_component(OBJECT(lpc), "rtc"));
 
-- 
2.43.2


