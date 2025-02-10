Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C03F9C02198
	for <qemu-devel@archiver.kernel.org>; Mon, 10 Feb 2025 10:27:09 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1thR09-00025p-Vk; Mon, 10 Feb 2025 05:26:57 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1thQzz-0001lq-PY
 for qemu-devel@nongnu.org; Mon, 10 Feb 2025 05:26:43 -0500
Received: from mail-wr1-x436.google.com ([2a00:1450:4864:20::436])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1thQzy-0001rv-0y
 for qemu-devel@nongnu.org; Mon, 10 Feb 2025 05:26:43 -0500
Received: by mail-wr1-x436.google.com with SMTP id
 ffacd0b85a97d-38dcc6bfbccso1481514f8f.0
 for <qemu-devel@nongnu.org>; Mon, 10 Feb 2025 02:26:41 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1739183200; x=1739788000; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=GB1YwrY+qaOJi+5vuXWHaBJPFs12eogUHsnzqNis+TE=;
 b=O1VoJn0M5kdWNIVHIKrATTPcwCiNnQKcNs6H+Q+5IzKHkTFXEpvL0TpLT2jAPIfksU
 DuuF0ILPWz1SwOGSov4VmD3xThRLEAFUF7gRhZvevOFZlDOq+K7YKGSAoWXyuYFwfjZ+
 /DDdg8WkQLsXRGHXdqyrhh72AhMvbsL0oqOge12fayJdeJvNhC8tr7AeEpnqJCdqnydr
 b5grHYVgy61m8BbiHdChISQPVT7bDcm6YQ2nZ4AB6KuE2ogZa4KrCTAick/slzWPkY8c
 IzGhlNiqtSM8U1XftluKHggKcuf/L5IwoRpLL+j6bJ4Ftxj3BTFqrfHEjaoTiUFiWDwD
 H4hg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1739183200; x=1739788000;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=GB1YwrY+qaOJi+5vuXWHaBJPFs12eogUHsnzqNis+TE=;
 b=pgZHIRWsbmJW5f/R3O7LXJ5iAFtfpfu77sxyVOPUWkz3MYgfHtNgC1o4JwfGHPmUOW
 8voB38BXWgV93a/FsB8Is2ZdwEGY4kR5RcYbwMP9whMcn6N7BINqVdcrdCYY8CLTWyP0
 ohhraiimRXpvmjouVnN8JCw2KqZYzovrZZhNpXVPi7Q766S2Gjr+7g570ofgP5PrabZe
 8Sv9O8L5O/YV9x3e9CMRKOBibGjql+6kdo2Zox29u43v94kc9NE3IC3vwMlW803AnS3f
 XnZAZc7n3uAWhp2bmmqPeXS37xkS7CTfePlQBJFrfubQAw7AnUfC+7yhsiXyiI17cNQN
 aEzg==
X-Gm-Message-State: AOJu0YzLwefHoBdLtayWlm5npHOzHvHh2WKFQ+6uVpu2uhT+BQsWNp61
 EFmBTUnJHhP32nI5LsYtTOmslbjjBgyct5BWvtRDZeGdufww7fO5h/e28u+RhMyVul3OyvzCqIY
 7zKs=
X-Gm-Gg: ASbGncsML+IT5fO+AssPHkq9+ajfZ+fVKn6yQ2htU4JYKEr8jaHV0OpcO0LCH0nVUtO
 kCT3xSY4iojbrTPHbvJGAbokJ9/SEDCdt4Lzd+k3/2cYBIgAFspcjsQi0uXaQR/RgGTKVLhfwgw
 lA7MFSR1IahX30kZSINUbHBb9w82fy8P7B0xhI6yOYb50XvicAx33+sr3LYGQZiOpReBYbq+i+q
 vuZ6IiR58CybvQL7t0qObSARCjsoHL7UkRwmxjYA7KIGwzwKoSeqFN+4gcgS7aFO1MFiH7BGq+a
 VhRzHOyxo0p6xEBAdUD7BfP1HMJqh2EQ5URhD/AWQOu0P4sYrVB0mRqjDCqj3L3HQnZZHg8=
X-Google-Smtp-Source: AGHT+IH6pwMEx6djZzFCuT6TulqhUaQBKKP6j4NSnCsZAzfWBRciB50ODMoQSAYnrZvVNXPEJYXc+g==
X-Received: by 2002:a5d:5984:0:b0:38d:e1b1:be9f with SMTP id
 ffacd0b85a97d-38de1b1c170mr923966f8f.4.1739183200061; 
 Mon, 10 Feb 2025 02:26:40 -0800 (PST)
Received: from localhost.localdomain (88-187-86-199.subs.proxad.net.
 [88.187.86.199]) by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-4391dca0041sm139608005e9.14.2025.02.10.02.26.39
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Mon, 10 Feb 2025 02:26:39 -0800 (PST)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
To: qemu-devel@nongnu.org
Cc: Richard Henderson <richard.henderson@linaro.org>,
 Paolo Bonzini <pbonzini@redhat.com>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
Subject: [PATCH 07/10] hw: Make class data 'const'
Date: Mon, 10 Feb 2025 11:26:01 +0100
Message-ID: <20250210102604.34284-8-philmd@linaro.org>
X-Mailer: git-send-email 2.47.1
In-Reply-To: <20250210102604.34284-1-philmd@linaro.org>
References: <20250210102604.34284-1-philmd@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::436;
 envelope-from=philmd@linaro.org; helo=mail-wr1-x436.google.com
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

When the %data argument is not modified, we can declare it const.

Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
---
 hw/sd/sdhci-internal.h   | 2 +-
 hw/sd/sdhci.c            | 2 +-
 hw/sensor/emc141x.c      | 2 +-
 hw/sensor/isl_pmbus_vr.c | 2 +-
 4 files changed, 4 insertions(+), 4 deletions(-)

diff --git a/hw/sd/sdhci-internal.h b/hw/sd/sdhci-internal.h
index 5f3765f12d2..9f768c418e0 100644
--- a/hw/sd/sdhci-internal.h
+++ b/hw/sd/sdhci-internal.h
@@ -322,6 +322,6 @@ void sdhci_initfn(SDHCIState *s);
 void sdhci_uninitfn(SDHCIState *s);
 void sdhci_common_realize(SDHCIState *s, Error **errp);
 void sdhci_common_unrealize(SDHCIState *s);
-void sdhci_common_class_init(ObjectClass *klass, void *data);
+void sdhci_common_class_init(ObjectClass *klass, const void *data);
 
 #endif
diff --git a/hw/sd/sdhci.c b/hw/sd/sdhci.c
index 99dd4a4e952..1f45a77566c 100644
--- a/hw/sd/sdhci.c
+++ b/hw/sd/sdhci.c
@@ -1542,7 +1542,7 @@ const VMStateDescription sdhci_vmstate = {
     },
 };
 
-void sdhci_common_class_init(ObjectClass *klass, void *data)
+void sdhci_common_class_init(ObjectClass *klass, const void *data)
 {
     DeviceClass *dc = DEVICE_CLASS(klass);
 
diff --git a/hw/sensor/emc141x.c b/hw/sensor/emc141x.c
index aeccd2a3c94..33c1bd330fd 100644
--- a/hw/sensor/emc141x.c
+++ b/hw/sensor/emc141x.c
@@ -265,7 +265,7 @@ static void emc141x_initfn(Object *obj)
                         emc141x_set_temperature, NULL, NULL);
 }
 
-static void emc141x_class_init(ObjectClass *klass, void *data)
+static void emc141x_class_init(ObjectClass *klass, const void *data)
 {
     DeviceClass *dc = DEVICE_CLASS(klass);
     I2CSlaveClass *k = I2C_SLAVE_CLASS(klass);
diff --git a/hw/sensor/isl_pmbus_vr.c b/hw/sensor/isl_pmbus_vr.c
index 304a66ea8b0..c60282cfe77 100644
--- a/hw/sensor/isl_pmbus_vr.c
+++ b/hw/sensor/isl_pmbus_vr.c
@@ -233,7 +233,7 @@ static void raa228000_init(Object *obj)
     isl_pmbus_vr_add_props(obj, flags, 1);
 }
 
-static void isl_pmbus_vr_class_init(ObjectClass *klass, void *data,
+static void isl_pmbus_vr_class_init(ObjectClass *klass, const void *data,
                                     uint8_t pages)
 {
     PMBusDeviceClass *k = PMBUS_DEVICE_CLASS(klass);
-- 
2.47.1


