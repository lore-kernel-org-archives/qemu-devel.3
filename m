Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6E4D5C25B78
	for <qemu-devel@archiver.kernel.org>; Tue,  4 Jun 2024 10:00:03 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sEQwi-0000Sq-MM; Tue, 04 Jun 2024 05:59:14 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1sEQwd-0000NX-S6
 for qemu-devel@nongnu.org; Tue, 04 Jun 2024 05:59:11 -0400
Received: from mail-wm1-x333.google.com ([2a00:1450:4864:20::333])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1sEQwc-0002OT-6A
 for qemu-devel@nongnu.org; Tue, 04 Jun 2024 05:59:07 -0400
Received: by mail-wm1-x333.google.com with SMTP id
 5b1f17b1804b1-42134bb9735so29712195e9.1
 for <qemu-devel@nongnu.org>; Tue, 04 Jun 2024 02:59:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1717495144; x=1718099944; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=aW7ooiPiVQKiciK9tXurprOszVnnccUrkSkxiG1Z0Yg=;
 b=IvnQi8a1g1K3LIsJaeJ3deUtiTfX3P5ndzfeybPQz59OObA58BZ5dx0Iv9ODxc3joq
 ctfxSvuASzT/Asek96eNPIf0aqk/BTqC/bLn6VOvLwdLqIFwflvaAd6KJvjfc/NMXXxl
 AG7aO4CzBRmV5jued/Dkd8GlGcGH0Prn2GcmNWNFfcOXrbSvyPVK2QX78Tc5wk2TFqEf
 0DIPTlxIGUx0545WBJLjUqsshY2aLwQIF/UthV7QUOemBY17EtaQpaSD9YJNQteQXj1e
 RWXIE/X18KwSr1i4NDH9pV0RDOP/4ktw0pUwlSQSHf1+A39cSv8PMEekdXQMoAiYS9LL
 +9fA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1717495144; x=1718099944;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=aW7ooiPiVQKiciK9tXurprOszVnnccUrkSkxiG1Z0Yg=;
 b=AJ46G24ZMd+1FnkLblTaIhkRhUBISi/S6HZTypvVrSO31MSItnbt+yGdMrPRn8Zfa8
 inWKBWAB9NB3IMo3W3BYIRcdnP53OJncVIV2SR30m1S3OilAl7I8ILSTh5nrNnoEdUvL
 KL5q66ZGVD26ddDfGYFljyWt6NnMexg2oBN/s9lQ+BOKM9fuKqlh+2Gmgkk5/2noKB7S
 icoNcILYazO/hB+WC9qta42hVkhf+vHnt3HGm2fzckRgXZExP3hIaz3uC38FZZhZqVtV
 VjaQmAq9yUd5FR7whDjtKqFO0ceV+0WI9Yxo/flS/FaObtKKWTeOBIBiKtBKEsUHsvBN
 JhIw==
X-Gm-Message-State: AOJu0YxA82F7XO3K274L4Jarls/C8aoJdtH/kk19WXcnhIOHh+R5ntNt
 LU6N3um4lQroRtTEY2eiqB8A6+LhTd6QoVtBc2Hq0C09vSgMhn1YKFZUEpNEbol3bJ91gIe/Gsu
 o
X-Google-Smtp-Source: AGHT+IFzprxbOD6h9vNgM6JBcW71mfntRiNSw9wJeoB+Eqylv5maHHZ0yPaeyEGsLahXg6EcDmeWZw==
X-Received: by 2002:a05:600c:511c:b0:421:2df7:beb8 with SMTP id
 5b1f17b1804b1-4212e05ea16mr102835835e9.14.1717495144565; 
 Tue, 04 Jun 2024 02:59:04 -0700 (PDT)
Received: from m1x-phil.lan ([176.176.159.34])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-4215310c7easm9559885e9.12.2024.06.04.02.59.03
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Tue, 04 Jun 2024 02:59:04 -0700 (PDT)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
To: qemu-devel@nongnu.org
Cc: Gerd Hoffmann <kraxel@redhat.com>, Thomas Huth <thuth@redhat.com>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
Subject: [PULL 32/32] usb: add config options for the hub and hid devices
Date: Tue,  4 Jun 2024 11:56:08 +0200
Message-ID: <20240604095609.12285-33-philmd@linaro.org>
X-Mailer: git-send-email 2.41.0
In-Reply-To: <20240604095609.12285-1-philmd@linaro.org>
References: <20240604095609.12285-1-philmd@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::333;
 envelope-from=philmd@linaro.org; helo=mail-wm1-x333.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
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

From: Gerd Hoffmann <kraxel@redhat.com>

Signed-off-by: Gerd Hoffmann <kraxel@redhat.com>
Reviewed-by: Thomas Huth <thuth@redhat.com>
Reviewed-by: Philippe Mathieu-Daudé <philmd@linaro.org>
Message-ID: <20240530112718.1752905-3-kraxel@redhat.com>
Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
---
 hw/usb/Kconfig     | 10 ++++++++++
 hw/usb/meson.build |  4 ++--
 2 files changed, 12 insertions(+), 2 deletions(-)

diff --git a/hw/usb/Kconfig b/hw/usb/Kconfig
index f569ed7eea..84bc7fbe36 100644
--- a/hw/usb/Kconfig
+++ b/hw/usb/Kconfig
@@ -65,6 +65,16 @@ config TUSB6010
     bool
     select USB_MUSB
 
+config USB_HUB
+    bool
+    default y
+    depends on USB
+
+config USB_HID
+    bool
+    default y
+    depends on USB
+
 config USB_TABLET_WACOM
     bool
     default y
diff --git a/hw/usb/meson.build b/hw/usb/meson.build
index 23f7f7acb5..d7de1003e3 100644
--- a/hw/usb/meson.build
+++ b/hw/usb/meson.build
@@ -35,8 +35,8 @@ system_ss.add(when: 'CONFIG_XLNX_VERSAL', if_true: files('xlnx-versal-usb2-ctrl-
 system_ss.add(when: 'CONFIG_XLNX_USB_SUBSYS', if_true: files('xlnx-usb-subsystem.c'))
 
 # emulated usb devices
-system_ss.add(when: 'CONFIG_USB', if_true: files('dev-hub.c'))
-system_ss.add(when: 'CONFIG_USB', if_true: files('dev-hid.c'))
+system_ss.add(when: 'CONFIG_USB_HUB', if_true: files('dev-hub.c'))
+system_ss.add(when: 'CONFIG_USB_HID', if_true: files('dev-hid.c'))
 system_ss.add(when: 'CONFIG_USB_TABLET_WACOM', if_true: files('dev-wacom.c'))
 system_ss.add(when: 'CONFIG_USB_STORAGE_CORE', if_true: files('dev-storage.c'))
 system_ss.add(when: 'CONFIG_USB_STORAGE_BOT', if_true: files('dev-storage-bot.c'))
-- 
2.41.0


