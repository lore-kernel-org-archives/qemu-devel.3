Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 93F5FE7718F
	for <qemu-devel@archiver.kernel.org>; Fri,  3 Jan 2025 17:11:47 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tTlCa-0000Th-Dy; Fri, 03 Jan 2025 12:11:12 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1tTlCW-0000T9-QX
 for qemu-devel@nongnu.org; Fri, 03 Jan 2025 12:11:09 -0500
Received: from mail-wr1-x434.google.com ([2a00:1450:4864:20::434])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1tTlCV-0006oP-9P
 for qemu-devel@nongnu.org; Fri, 03 Jan 2025 12:11:08 -0500
Received: by mail-wr1-x434.google.com with SMTP id
 ffacd0b85a97d-385df53e559so9799460f8f.3
 for <qemu-devel@nongnu.org>; Fri, 03 Jan 2025 09:11:06 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1735924265; x=1736529065; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=Q/CzbbG3jOxGhXorzYheCWoGqel4SlzmIyrU6suQqBM=;
 b=kyUL5HaUsDQe9YDQZb6Ki7ZTbvghAYHCf9IpLCsxUmPpN9OqGE/Akc6aFFRFTE3fi0
 Nj56nzaUAahlISX3hvvIk2jJZlxVrfd8dqZcSec4GA8BJtUmVQdlz5oBeNhKDTnn0GNK
 CqE+PDVKefkUjjuztn0ifAm9d6skVxw2fRqeRtUgA+5seEwi+gL7bmSwknTZ18VC/UMD
 baNqZbgAX8NJEZtQ756u5itvFgeKqz22blEc8ZN8oQsvGZJ+5z2KHzglOIq5/kYwZ0/C
 9jiB8ikFqqmsSfIQITBgplcfjKgOh67K8TeE82qx1hkLVNOKmiA9lnxf+zmJvdRoaFzv
 UVdQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1735924265; x=1736529065;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=Q/CzbbG3jOxGhXorzYheCWoGqel4SlzmIyrU6suQqBM=;
 b=oero3itUF3BKSkUj6+XlKLhhqANKstWkdKyXyajwCWb9c66Wvyt8CE+Ax67MCCBpMi
 IxO3bYZ+4ZbgOYDd/fyuF+HHYCw/6A6koV33L4vlnOrlY5jou7OV7pGdTkOg9rmEvcPu
 TMhKRZ49/BO33oDErl5x+JYBSFFqhV3hnRhc+kb5bsIEJJtDDVPWny5XX/zsyjfuxsgP
 5gWL/f9n4nMD47uPSFXXgHbN4tF8W3cn+g/HwBc+2rxHh4sX93Jj8tiXpF/daTOczSkm
 L24Oa+cgdt6Pn0WPE0vuABxwRRfSnnJIJBPdrHVFSOpg+7ltjdAPGOsim52DirBZRTS1
 W6tg==
X-Gm-Message-State: AOJu0YzdNqEzQ5wjjRb9kHSNPDmGi0ku4p1lfmYpxhXZwG5icac/Kbtx
 ZXoEiINpCabtiCjZJrWQwm+/Qfi+T9Lhwi+nS9IHbNbjmDSuIMav2e0qqfieXz3OJJj+GCdRu7I
 wBDE=
X-Gm-Gg: ASbGncsrCGr2aWNxazci7J/Z5PzEstou30q+r7MuOt1wOtCU/L+QElKGCzqmMCmKmo+
 W4nXnvv+WXv2hATyVo11lSTONbwPRCXGV10KyZ/Vlo4uHZO2JGtCn5AER75fO1hVQ+5JfykezCJ
 GMcQAo/MxtC7tGH51WsdtSHsFYs8R5VzrZ12dDe3/lhXMQ+qyer2H+IQKAfuYLtBzQCmcd7GQkJ
 ILxwCSrtZM3YWb8LHjNHPyENKf3qflSdM3OGIt57HpLGULzsV3BtWJGhAd99m68snDsHvUAXe+P
 uiR0ZbBzukVA4H9GQbfKkYtcfLkpk64=
X-Google-Smtp-Source: AGHT+IGchJbT6bpnXWoxhQ17XnigkqxhTNr+aNxhYgiEpo4fdURQlkPCucKa22rfOo74+Qm9odwasw==
X-Received: by 2002:a05:6000:154f:b0:385:eeb9:a5bb with SMTP id
 ffacd0b85a97d-38a221f698amr40605261f8f.17.1735924264910; 
 Fri, 03 Jan 2025 09:11:04 -0800 (PST)
Received: from localhost.localdomain (88-187-86-199.subs.proxad.net.
 [88.187.86.199]) by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-43656b119b6sm526575015e9.22.2025.01.03.09.11.03
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Fri, 03 Jan 2025 09:11:04 -0800 (PST)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
To: qemu-devel@nongnu.org
Cc: Pierrick Bouvier <pierrick.bouvier@linaro.org>,
 Alistair Francis <alistair.francis@wdc.com>,
 Kito Cheng <kito.cheng@sifive.com>,
 Richard Henderson <richard.henderson@linaro.org>,
 Keith Packard <keithp@keithp.com>,
 Daniel Henrique Barboza <dbarboza@ventanamicro.com>,
 =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>,
 Thomas Huth <thuth@redhat.com>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
Subject: [PATCH 5/5] semihosting/meson: Build config.o and console.o once
Date: Fri,  3 Jan 2025 18:10:37 +0100
Message-ID: <20250103171037.11265-6-philmd@linaro.org>
X-Mailer: git-send-email 2.47.1
In-Reply-To: <20250103171037.11265-1-philmd@linaro.org>
References: <20250103171037.11265-1-philmd@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::434;
 envelope-from=philmd@linaro.org; helo=mail-wr1-x434.google.com
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

config.c and console.c don't use any target specific
headers anymore, move them from specific_ss[] to
system_ss[] so they are built once, but will also be
linked once, removing global symbol clash in a single
QEMU binary.

Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
---
 semihosting/meson.build | 9 ++++++---
 1 file changed, 6 insertions(+), 3 deletions(-)

diff --git a/semihosting/meson.build b/semihosting/meson.build
index 34933e5a195..86f5004bed7 100644
--- a/semihosting/meson.build
+++ b/semihosting/meson.build
@@ -4,13 +4,16 @@ specific_ss.add(when: 'CONFIG_SEMIHOSTING', if_true: files(
 ))
 
 specific_ss.add(when: ['CONFIG_SEMIHOSTING', 'CONFIG_SYSTEM_ONLY'], if_true: files(
-  'config.c',
-  'console.c',
   'uaccess.c',
 ))
 
 common_ss.add(when: ['CONFIG_SEMIHOSTING', 'CONFIG_SYSTEM_ONLY'], if_false: files('stubs-all.c'))
-system_ss.add(when: ['CONFIG_SEMIHOSTING'], if_false: files('stubs-system.c'))
+system_ss.add(when: ['CONFIG_SEMIHOSTING'], if_true: files(
+  'config.c',
+  'console.c',
+), if_false: files(
+  'stubs-system.c',
+))
 
 specific_ss.add(when: ['CONFIG_ARM_COMPATIBLE_SEMIHOSTING'],
 		if_true: files('arm-compat-semi.c'))
-- 
2.47.1


