Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C59BDC54FB3
	for <qemu-devel@archiver.kernel.org>; Mon, 26 May 2025 11:24:20 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uJVw0-0006Fr-BD; Mon, 26 May 2025 07:24:00 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1uJVvx-0006Eu-H0
 for qemu-devel@nongnu.org; Mon, 26 May 2025 07:23:57 -0400
Received: from mail-wr1-x42c.google.com ([2a00:1450:4864:20::42c])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1uJVvv-0001pL-KC
 for qemu-devel@nongnu.org; Mon, 26 May 2025 07:23:57 -0400
Received: by mail-wr1-x42c.google.com with SMTP id
 ffacd0b85a97d-3a36efcadb8so2082211f8f.0
 for <qemu-devel@nongnu.org>; Mon, 26 May 2025 04:23:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1748258633; x=1748863433; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=jNvIkaGWqwIyyf3qPO21sauAQBsDAgapC08M3PdrX3U=;
 b=kIroOeabYqKJve8r3aKCpOjFzOlOpNwZcvtiIGBF9WEj2vOYPlRoVC6CnlqnPnFzol
 QqCvWMKmdVYjGNWej5qccFwGjHYiUKcv2fDk1tq/LU2J1MLqsiF5l75ff+Y33uhg+Zvs
 2coAttz0uCs7r1X1bBORVb8AkOyADYIEAb6LkCz+tid0yKdfLyCb1cq9ldwOvSDJaDYf
 GJJ3zQRpF/DBMV7MPl/Wxm3O6PzwM3Bx6VU67MM5nuuc20SAWCJhsxJpqdeLJAXw1snw
 bS/VklvSpOdFo4+rXMxrip1KW7RxbYONFHwDWqx9kzzz07NDVysMchMUShWYa8mstdjc
 KVOw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1748258633; x=1748863433;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=jNvIkaGWqwIyyf3qPO21sauAQBsDAgapC08M3PdrX3U=;
 b=A0iy832W2DM5s0bu330CZTZo4nbiG5J4xaFgISY71YWoCMSg06RA0JpHi7KOYZ/Ptj
 EHSBxm9/B0Xg+wqoEiKzyxbdrpvO/SOVL5IY5KDAeIqle7GN4wyqOhpupBeMwW27Gyaq
 /ULS80u8El78coBjzkK/Wkg4dSaPgkI+Y/nwl26iCgmS2QLN9tdCW0XpBeD+QRBRs2v+
 g6wKzKpPB16S4bknK3rTthscQqXUfC/f0bOVT/zCta60oJj47w6WFMPVHD4OT8LgueR9
 nAMi9JsYQqB4EP9yYEn3CPYaNwqdhTgM5sc9yU5S8jxw3SSfe/oZCxfeBurD5i+IbUzd
 Rm2A==
X-Gm-Message-State: AOJu0YzhfkgrYFBUm/yW2iDQTprZ7nbLOcF3nOIg4trIOfqGtoVLZtWs
 TOPzwK8GZ4m1kY7TqrAqEutbPvXUhoNT9aqGQj8mEKstp1glEVAKtwKiaMlfRAiK8mtoZ3qR1lY
 kqyKaxUC7Ow==
X-Gm-Gg: ASbGncvb/to9DBVl4QJjnGJfUG6mn6K+mnWlIAsDhVOlTq2TpasFSaUPBnpEw32PZ+u
 3V42Rd12WjlwvAJP7J6xlOvEGyyuzJBncIY4nG+Z4d+g0yBOC6J/X+1OwvVyDFNb6YTV9sv9pU/
 3leNuGPGPl8rdQFO/7dGJehdb84Z+mHiAzZNUL7uMS0plQWsWj7o3fNMdsYc7lcvnteWS519XLA
 tQzE2MKoaCvdDyOH8fkH+NaMTR77lqh8Q/FDXQ7xw46D70ZcED/twuKpYhxs16/gKkdiRBEEz4f
 z4LZTnp3mlyjZYCRcexutIobNTwjLRfjkIV5dIkq+XY8yYZj7GzveVSocaX3ADGVycgXR+CAb+3
 13IGGbLLVRka8FNRFTnykyrPLXcL+oeM=
X-Google-Smtp-Source: AGHT+IH8CZLUa85gQ0EPaSVJ+MfCxlPTUfLUVJUNZ/3XwuupnTyP4vJBF3aDXu5tvhZU+LvO49YX6w==
X-Received: by 2002:adf:f0cc:0:b0:3a4:d02e:84ac with SMTP id
 ffacd0b85a97d-3a4d02e8731mr4434127f8f.13.1748258632991; 
 Mon, 26 May 2025 04:23:52 -0700 (PDT)
Received: from localhost.localdomain (88-187-86-199.subs.proxad.net.
 [88.187.86.199]) by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-3a4de9c9853sm549909f8f.27.2025.05.26.04.23.52
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Mon, 26 May 2025 04:23:52 -0700 (PDT)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
To: qemu-devel@nongnu.org
Cc: Paolo Bonzini <pbonzini@redhat.com>,
 =?UTF-8?q?Fr=C3=A9d=C3=A9ric=20Barrat?= <fbarrat@linux.ibm.com>,
 "Michael S. Tsirkin" <mst@redhat.com>, Nicholas Piggin <npiggin@gmail.com>,
 Igor Mammedov <imammedo@redhat.com>,
 Daniel Henrique Barboza <danielhb413@gmail.com>, qemu-ppc@nongnu.org,
 =?UTF-8?q?C=C3=A9dric=20Le=20Goater?= <clg@redhat.com>,
 Ani Sinha <anisinha@redhat.com>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
Subject: [PATCH 1/3] hw/acpi: Build IPMI stubs when ACPI is disabled
Date: Mon, 26 May 2025 13:23:44 +0200
Message-ID: <20250526112346.48744-2-philmd@linaro.org>
X-Mailer: git-send-email 2.47.1
In-Reply-To: <20250526112346.48744-1-philmd@linaro.org>
References: <20250526112346.48744-1-philmd@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::42c;
 envelope-from=philmd@linaro.org; helo=mail-wr1-x42c.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=unavailable autolearn_force=no
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

When ACPI is disabled, no ACPI code depends on IPMI,
so we don't need the stubs.

We need them when IPMI is enabled and ACPI disabled,
otherwise when using '--without-default-devices' we
get:

  Undefined symbols for architecture arm64:
    "_build_ipmi_dev_aml", referenced from:
        _isa_ipmi_bt_class_init in hw_ipmi_isa_ipmi_bt.c.o
  ld: symbol(s) not found for architecture arm64

Split the source set list to avoid a too long line.

Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
---
 hw/acpi/meson.build | 10 ++++++++--
 1 file changed, 8 insertions(+), 2 deletions(-)

diff --git a/hw/acpi/meson.build b/hw/acpi/meson.build
index 73f02b96912..76948cdd00d 100644
--- a/hw/acpi/meson.build
+++ b/hw/acpi/meson.build
@@ -26,12 +26,18 @@ acpi_ss.add(when: 'CONFIG_ACPI_PCIHP', if_false: files('acpi-pci-hotplug-stub.c'
 acpi_ss.add(when: 'CONFIG_ACPI_VIOT', if_true: files('viot.c'))
 acpi_ss.add(when: 'CONFIG_ACPI_ICH9', if_true: files('ich9.c', 'ich9_tco.c', 'ich9_timer.c'))
 acpi_ss.add(when: 'CONFIG_ACPI_ERST', if_true: files('erst.c'))
-acpi_ss.add(when: 'CONFIG_IPMI', if_true: files('ipmi.c'), if_false: files('ipmi-stub.c'))
+acpi_ss.add(when: 'CONFIG_IPMI', if_true: files('ipmi.c'))
 acpi_ss.add(when: 'CONFIG_PC', if_false: files('acpi-x86-stub.c'))
 if have_tpm
   acpi_ss.add(files('tpm.c'))
 endif
-system_ss.add(when: 'CONFIG_ACPI', if_false: files('acpi-stub.c', 'aml-build-stub.c', 'ghes-stub.c', 'acpi_interface.c'))
+system_ss.add(when: 'CONFIG_ACPI', if_false: files(
+  'acpi-stub.c',
+  'acpi_interface.c',
+  'aml-build-stub.c',
+  'ghes-stub.c',
+  'ipmi-stub.c',
+))
 system_ss.add(when: 'CONFIG_ACPI_PCI_BRIDGE', if_false: files('pci-bridge-stub.c'))
 system_ss.add_all(when: 'CONFIG_ACPI', if_true: acpi_ss)
 system_ss.add(files('acpi-qmp-cmds.c'))
-- 
2.47.1


