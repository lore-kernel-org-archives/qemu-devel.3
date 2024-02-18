Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7DEA7C48BF6
	for <qemu-devel@archiver.kernel.org>; Sun, 18 Feb 2024 13:18:35 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rbh2n-0004Ar-5l; Sun, 18 Feb 2024 08:17:21 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <shentey@gmail.com>) id 1rbh2m-0004Ag-0d
 for qemu-devel@nongnu.org; Sun, 18 Feb 2024 08:17:20 -0500
Received: from mail-ej1-x630.google.com ([2a00:1450:4864:20::630])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <shentey@gmail.com>) id 1rbh2k-0007uR-HS
 for qemu-devel@nongnu.org; Sun, 18 Feb 2024 08:17:19 -0500
Received: by mail-ej1-x630.google.com with SMTP id
 a640c23a62f3a-a3e82664d53so23830666b.3
 for <qemu-devel@nongnu.org>; Sun, 18 Feb 2024 05:17:18 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1708262236; x=1708867036; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=ErOmGoohTQuuPRxQOH0NLqSeW4DnDgzvtYzR7cck4q4=;
 b=bjJZeBfcsciIyaqWmqLiaQUKd2ugrhgIE5vgjvx6xUn9mjcVsYy2YkIUnIg31eKi0+
 6nPWVfitoQ6accJhL9q1N8daVVWzIBdOnLIdEwR/NMx78UYKiujjzgCxjLT7zWsxRWQe
 x7T1e6R7GPN8yf+RencRhvatHnCDykQo5Ew/8hFp19gI8j6K5JxsVg+tt/aDKNSGutOq
 O3IExXe6/dVqLxiFfzeKBrJAijzDOnK6nOhyMvJkGdR0hHB25GccVg+b4QB06yYV/Be6
 67EmkQ1qL4CYzU7pQj+rK3qdK5ZOALhpZvp+6A44T2KkVk7ev+KWNzjtTAKHohC0CnAN
 ClZw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1708262236; x=1708867036;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=ErOmGoohTQuuPRxQOH0NLqSeW4DnDgzvtYzR7cck4q4=;
 b=Pg3VdXvhm9Rj2O0pus9pSNKS0wrUPEBaWqJs19R9IQJjWY0fWI3v/ZeulQqjyICFVF
 zF/5Jw/5/LGgtdfW2ABWKSnJUq2TzKBkxlVfdAOUQ1zfwKG9lFvEZmusC/ks3S1bhyw0
 EH599jQrB/o69n6rGGksz2SHjBRln7phBzc5Vbye/phU0kGvBKC77VDuDudm4XpNEFdV
 trZjDo1REms5SSyrZuH6aOryABoHziizeCToqDRQdejraYIaxB9BlYqeacdORFVxuHBD
 yQUvpGhqvsgUrU52+ZO5vXUWov95UESPEmKaULnGdL+dfZ7aRZ+bxRCAYWkU7YtinPkM
 fh3w==
X-Gm-Message-State: AOJu0Yz2kzhXERJrTYtm1w50ZB7HLoK3sSHzJ47HVTBeiVVUBtbzHUHH
 WXS/CQmUYi7RsFOPoJfJUonW53bmFPxgYrXw8n5VnVNyj/7zSzSrr3M9kq16
X-Google-Smtp-Source: AGHT+IFyGBbJw7pW3Wr2y9cLFQ1+v+pGP3uordXBEyDvB5i2qu0VG7QD0yQ8KD+bxXhfh6VwOyzZhA==
X-Received: by 2002:a17:906:f745:b0:a3e:422d:a27d with SMTP id
 jp5-20020a170906f74500b00a3e422da27dmr1961534ejb.47.1708262236156; 
 Sun, 18 Feb 2024 05:17:16 -0800 (PST)
Received: from archlinux.. (dynamic-078-054-149-080.78.54.pool.telefonica.de.
 [78.54.149.80]) by smtp.gmail.com with ESMTPSA id
 jw15-20020a170906e94f00b00a3e86a9c55asm255088ejb.146.2024.02.18.05.17.15
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sun, 18 Feb 2024 05:17:15 -0800 (PST)
From: Bernhard Beschow <shentey@gmail.com>
To: qemu-devel@nongnu.org
Cc: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Paolo Bonzini <pbonzini@redhat.com>, Eduardo Habkost <eduardo@habkost.net>,
 "Michael S. Tsirkin" <mst@redhat.com>, BALATON Zoltan <balaton@eik.bme.hu>,
 Aurelien Jarno <aurelien@aurel32.net>,
 Jiaxun Yang <jiaxun.yang@flygoat.com>,
 Richard Henderson <richard.henderson@linaro.org>,
 Marcel Apfelbaum <marcel.apfelbaum@gmail.com>,
 =?UTF-8?q?Herv=C3=A9=20Poussineau?= <hpoussin@reactos.org>,
 Bernhard Beschow <shentey@gmail.com>
Subject: [PATCH 4/5] hw/i386/pc: Inline i8042_setup_a20_line() and remove it
Date: Sun, 18 Feb 2024 14:17:00 +0100
Message-ID: <20240218131701.91132-5-shentey@gmail.com>
X-Mailer: git-send-email 2.43.2
In-Reply-To: <20240218131701.91132-1-shentey@gmail.com>
References: <20240218131701.91132-1-shentey@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::630;
 envelope-from=shentey@gmail.com; helo=mail-ej1-x630.google.com
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

This function is used once in the pc machines. Remove it since it contains one
line only.

Signed-off-by: Bernhard Beschow <shentey@gmail.com>
---
 include/hw/input/i8042.h | 1 -
 hw/i386/pc.c             | 2 +-
 hw/input/pckbd.c         | 5 -----
 3 files changed, 1 insertion(+), 7 deletions(-)

diff --git a/include/hw/input/i8042.h b/include/hw/input/i8042.h
index 9fb3f8d787..e90f008b66 100644
--- a/include/hw/input/i8042.h
+++ b/include/hw/input/i8042.h
@@ -89,7 +89,6 @@ struct MMIOKBDState {
 
 
 void i8042_isa_mouse_fake_event(ISAKBDState *isa);
-void i8042_setup_a20_line(ISADevice *dev, qemu_irq a20_out);
 
 static inline bool i8042_present(void)
 {
diff --git a/hw/i386/pc.c b/hw/i386/pc.c
index 8b601ea6cf..1b2077dc32 100644
--- a/hw/i386/pc.c
+++ b/hw/i386/pc.c
@@ -1195,7 +1195,7 @@ static void pc_superio_init(ISABus *isa_bus, bool create_fdctrl,
     }
 
     a20_line = qemu_allocate_irqs(handle_a20_line_change, first_cpu, 1);
-    i8042_setup_a20_line(i8042, a20_line[0]);
+    qdev_connect_gpio_out_named(DEVICE(i8042), I8042_A20_LINE, 0, a20_line[0]);
     g_free(a20_line);
 }
 
diff --git a/hw/input/pckbd.c b/hw/input/pckbd.c
index 90a4d9eb40..74f10b640f 100644
--- a/hw/input/pckbd.c
+++ b/hw/input/pckbd.c
@@ -777,11 +777,6 @@ void i8042_isa_mouse_fake_event(ISAKBDState *isa)
     ps2_mouse_fake_event(&s->ps2mouse);
 }
 
-void i8042_setup_a20_line(ISADevice *dev, qemu_irq a20_out)
-{
-    qdev_connect_gpio_out_named(DEVICE(dev), I8042_A20_LINE, 0, a20_out);
-}
-
 static const VMStateDescription vmstate_kbd_isa = {
     .name = "pckbd",
     .version_id = 3,
-- 
2.43.2


