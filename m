Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C8B11C30653
	for <qemu-devel@archiver.kernel.org>; Wed, 26 Jun 2024 11:08:24 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sMQUP-0005R4-Fz; Wed, 26 Jun 2024 07:07:01 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <akihiko.odaki@daynix.com>)
 id 1sMQUO-0005OP-3H
 for qemu-devel@nongnu.org; Wed, 26 Jun 2024 07:07:00 -0400
Received: from mail-pl1-x634.google.com ([2607:f8b0:4864:20::634])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <akihiko.odaki@daynix.com>)
 id 1sMQUM-0004gS-Hx
 for qemu-devel@nongnu.org; Wed, 26 Jun 2024 07:06:59 -0400
Received: by mail-pl1-x634.google.com with SMTP id
 d9443c01a7336-1fa2ea1c443so29122345ad.0
 for <qemu-devel@nongnu.org>; Wed, 26 Jun 2024 04:06:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=daynix-com.20230601.gappssmtp.com; s=20230601; t=1719400017; x=1720004817;
 darn=nongnu.org; 
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :mime-version:subject:date:from:from:to:cc:subject:date:message-id
 :reply-to; bh=NdtXuYtoYpM+68cWqs8hQd4tffE/iSVor/TSMG9jMpE=;
 b=PPauVM+UgMUALgAr2fPV8PkAPs0l5wP4h749VNITr2FVNnIZj9Vjp9bDeD5Enqgi1e
 zKzqgow6MU7nCBGtWauC0qWWuCCNbC4EaAAJQpCLy3P4Rplcfn+h5KWDU46JbmJfG5JC
 HJHjNXi26vgwn0ryQpxYpnFNnZVA0ndESeppXClx8QKUqRk1h2n/FUM1SeiUAKSYk3IL
 1ORmS4qWGyTolpD7fUc79OP7QiWEPsFG9stszDntRN8lVHu5kjYpIpAvkuVNXJCAKHmK
 ABGk4R5CH4QR4ZIIcFd1aFBDiucay75pDnt8t70Ft7+yhjCjiy5SAQZrbhFU2Gi/emDR
 JITw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1719400017; x=1720004817;
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :mime-version:subject:date:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=NdtXuYtoYpM+68cWqs8hQd4tffE/iSVor/TSMG9jMpE=;
 b=AQc6QXlGYToUtD4IQrchzh3jK8ghgOWbEzm4yroj6j1neO2jLFT6cIbQFh8JH1Q5QG
 vbS8diu3oSZU7pr9xCm4U3XPOmFrULumk/Gn7yckA14YCzHT7b5TV/d8GXfhtGFNqGR+
 CCDRYZ+QduEwfCreGkPksSy6Uxak0XWkrcNxq7EbMruDlTjp1ictuLodlba0sJGdwYsN
 vhlotoEwQM7RhImmxTwX2BB9mdym33rp2otpXKIceGXq55OnzyivhCQY6hxDXNZb/zvK
 yxg3D0IEEJmGdEVowl3XedCNGsYsVXhlSpjEoexNSHxf8h/+aZ1u/BeS0HtPja+GxwGt
 IFfQ==
X-Gm-Message-State: AOJu0YweL/YTNwAtsG3SJUcF7+Imdfu8Tl+o+FOCQ/kiEMZxNmDVhT9C
 SWk2yItSdbBcf1dB6Yak5HVAq39xUdsWbmpu8BrfS61vGsgI/MwrXXM/XNBDa/o=
X-Google-Smtp-Source: AGHT+IFg1T+vqFnUee178oY9EUIeMhokug+RTUydh6dLIMpcg1X+lIRMwce+VWX5z7BcMoNNVng/8A==
X-Received: by 2002:a17:902:ea01:b0:1f7:3a5b:2f0 with SMTP id
 d9443c01a7336-1fa23ef7803mr126640085ad.44.1719400017213; 
 Wed, 26 Jun 2024 04:06:57 -0700 (PDT)
Received: from localhost ([157.82.204.135])
 by smtp.gmail.com with UTF8SMTPSA id
 d9443c01a7336-1fa2ac93ad8sm62979925ad.266.2024.06.26.04.06.52
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Wed, 26 Jun 2024 04:06:56 -0700 (PDT)
From: Akihiko Odaki <akihiko.odaki@daynix.com>
Date: Wed, 26 Jun 2024 20:06:26 +0900
Subject: [PATCH 03/14] hw/isa/vt82c686: Free irqs
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20240626-san-v1-3-f3cc42302189@daynix.com>
References: <20240626-san-v1-0-f3cc42302189@daynix.com>
In-Reply-To: <20240626-san-v1-0-f3cc42302189@daynix.com>
To: Eduardo Habkost <eduardo@habkost.net>, 
 Marcel Apfelbaum <marcel.apfelbaum@gmail.com>, 
 =?utf-8?q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>, 
 Yanan Wang <wangyanan55@huawei.com>, John Snow <jsnow@redhat.com>, 
 BALATON Zoltan <balaton@eik.bme.hu>, Jiaxun Yang <jiaxun.yang@flygoat.com>, 
 Nicholas Piggin <npiggin@gmail.com>, 
 Daniel Henrique Barboza <danielhb413@gmail.com>, 
 David Gibson <david@gibson.dropbear.id.au>, 
 Harsh Prateek Bora <harshpb@linux.ibm.com>, 
 Alexey Kardashevskiy <aik@ozlabs.ru>, "Michael S. Tsirkin" <mst@redhat.com>, 
 =?utf-8?q?Alex_Benn=C3=A9e?= <alex.bennee@linaro.org>, 
 Peter Xu <peterx@redhat.com>, Fabiano Rosas <farosas@suse.de>, 
 Paolo Bonzini <pbonzini@redhat.com>, David Hildenbrand <david@redhat.com>, 
 Thomas Huth <thuth@redhat.com>, Laurent Vivier <lvivier@redhat.com>
Cc: qemu-devel@nongnu.org, qemu-block@nongnu.org, qemu-ppc@nongnu.org, 
 Akihiko Odaki <akihiko.odaki@daynix.com>
X-Mailer: b4 0.14-dev-fd6e3
Received-SPF: none client-ip=2607:f8b0:4864:20::634;
 envelope-from=akihiko.odaki@daynix.com; helo=mail-pl1-x634.google.com
X-Spam_score_int: -18
X-Spam_score: -1.9
X-Spam_bar: -
X-Spam_report: (-1.9 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 SPF_NONE=0.001 autolearn=ham autolearn_force=no
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

This suppresses LeakSanitizer warnings.

Signed-off-by: Akihiko Odaki <akihiko.odaki@daynix.com>
---
 hw/isa/vt82c686.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/hw/isa/vt82c686.c b/hw/isa/vt82c686.c
index 8582ac0322eb..189b487f1d22 100644
--- a/hw/isa/vt82c686.c
+++ b/hw/isa/vt82c686.c
@@ -721,7 +721,6 @@ static void via_isa_realize(PCIDevice *d, Error **errp)
 
     qdev_init_gpio_out(dev, &s->cpu_intr, 1);
     qdev_init_gpio_in_named(dev, via_isa_pirq, "pirq", PCI_NUM_PINS);
-    isa_irq = qemu_allocate_irqs(via_isa_request_i8259_irq, s, 1);
     isa_bus = isa_bus_new(dev, pci_address_space(d), pci_address_space_io(d),
                           errp);
 
@@ -729,7 +728,9 @@ static void via_isa_realize(PCIDevice *d, Error **errp)
         return;
     }
 
+    isa_irq = qemu_allocate_irqs(via_isa_request_i8259_irq, s, 1);
     s->isa_irqs_in = i8259_init(isa_bus, *isa_irq);
+    qemu_free_irqs(isa_irq, 1);
     isa_bus_register_input_irqs(isa_bus, s->isa_irqs_in);
     i8254_pit_init(isa_bus, 0x40, 0, NULL);
     i8257_dma_init(OBJECT(d), isa_bus, 0);

-- 
2.45.2


