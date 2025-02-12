Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3DCB9C02198
	for <qemu-devel@archiver.kernel.org>; Wed, 12 Feb 2025 12:39:11 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tiC0F-0003yl-9G; Wed, 12 Feb 2025 07:38:07 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1tiBzW-0003RB-FW
 for qemu-devel@nongnu.org; Wed, 12 Feb 2025 07:37:23 -0500
Received: from mail-wm1-x336.google.com ([2a00:1450:4864:20::336])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1tiBzN-0000Ow-F2
 for qemu-devel@nongnu.org; Wed, 12 Feb 2025 07:37:16 -0500
Received: by mail-wm1-x336.google.com with SMTP id
 5b1f17b1804b1-4394829ef0fso4937655e9.0
 for <qemu-devel@nongnu.org>; Wed, 12 Feb 2025 04:37:07 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1739363826; x=1739968626; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=cvDaF3GKG76GRCi7eSTTtcTkqo3eY1cM/gGguFUqtkI=;
 b=hk6EH+Bqi0lq4psoQrxuSFd5s7/MjK95JhOzeIMIJYgf8vy2oBQZZ17ZPuUQoq2Gc5
 N/6DjVJx1KYnUqJSrJnvmnrRdHw0qB6Ow6W+kWaxiUiz5WDw+s9ZdNDEUXfZiLw3OodG
 czpiMM6Br/UAkhzkHLDE4EbQIVRbCSX0+D4y0ousgz3+4OonsnQhxdQ79R15oU+5zDSt
 8XSbR2IVDzOVbyZ5Q+tQT0c0KHOVdX36Ksxhw7mZbc4V2TZCHv3CpWPrrRFCNIoAxHUt
 4prUIAIR/XDuKqV7O9dO9glJBIx44BkLPf+28nIIWZ/oUhxi+Gqi24n+eVrXtl6+ouk4
 fRaA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1739363826; x=1739968626;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=cvDaF3GKG76GRCi7eSTTtcTkqo3eY1cM/gGguFUqtkI=;
 b=MEs3q0tWCzbivHS5soV1Bvd9ZkW3RY5RQ6CQ3omshByqsUp1tClKo/6plU9IWUUOTt
 7HXA0QZa1vv20uXJc+YI4VmWNiIhrMReJYMgNhLneYyQrGKEsSLlXV0zAeka8LrdL+of
 06jic3J2D25Id2/+iL43cDe2EgUaqTGM/UUCGzCR9ogzLLmChNRCWUzdk2PQKN4ldmse
 JMD5Ce3YUTLHhrHH+Y1efi+1NtrNl4l+IE7IjwoXtL+CWFfRfPP0/vk0iOPfzdqHhREl
 okGDMU7W0ryH2H5RyEBv+4nYIlzqF7nUmUIs2iP/0NN7zyzxgiOsbA79vg40lqtCUCi7
 5+gA==
X-Gm-Message-State: AOJu0Yyu7tfiSYDeWZ4J0F5EL5YX/vOwt3d9lApgz47Vdq+k8tjju+CM
 Q/3+1mMIVlYXeSWbOoG1KnUr5+DZmBBJrqgSPq5DE8r4Yyu/o1oeK6CDNnac6SzT5NdtxHjUti2
 9lVk=
X-Gm-Gg: ASbGncsoWLmMhMcBB5Pt8SZdt0fS30FdItT2dNQPlzDRqR0kRwKzm4iISvYmHHTgKLD
 KQZvFz7QkxXGzJRY+G02va//Wb/JTHn1rqJzpLOq13uercCSPkPv7XcnnQpikiU86POeRi95k1M
 3Naljk9h6wzyK+xgEEUZ12FslGI6FdldzMnnJmPhvwrUrne05s6vbpH5x55axKrCtczn7YlGYPr
 bN7GpZUj+YT3Ft15VAX9xq4K0ZphJSdi3PJbiMk1niJmqutG68dB1k0U0wWjHVaSzgI7Ty3lmaN
 E3LAwY/TUcURKDg647Ha/+mmKJYixxtvqcgDK9UM2KTEMraNvxsW8R15hdgTcNEpoA==
X-Google-Smtp-Source: AGHT+IHpM1ThR1kf/5shI0F9XZ0aY2JXWPOzCQ2Yf90fiU3jbFQ6dtoGxFx4iMVaM8dpuBnqMePO6A==
X-Received: by 2002:a05:600c:1508:b0:439:5b5c:e03b with SMTP id
 5b1f17b1804b1-4395b5ce0d2mr15307345e9.6.1739363826533; 
 Wed, 12 Feb 2025 04:37:06 -0800 (PST)
Received: from localhost.localdomain (88-187-86-199.subs.proxad.net.
 [88.187.86.199]) by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-4395a04f208sm18657015e9.6.2025.02.12.04.37.05
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Wed, 12 Feb 2025 04:37:06 -0800 (PST)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
To: qemu-devel@nongnu.org
Cc: qemu-riscv@nongnu.org, Thomas Huth <thuth@redhat.com>, qemu-arm@nongnu.org,
 Richard Henderson <richard.henderson@linaro.org>, qemu-ppc@nongnu.org,
 Sai Pavan Boddu <sai.pavan.boddu@amd.com>,
 Markus Armbruster <armbru@redhat.com>,
 "Edgar E. Iglesias" <edgar.iglesias@gmail.com>,
 Alistair Francis <alistair.francis@wdc.com>,
 =?UTF-8?q?Daniel=20P=2E=20Berrang=C3=A9?= <berrange@redhat.com>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
Subject: [PATCH v7 01/10] hw/qdev-properties-system: Introduce EndianMode QAPI
 enum
Date: Wed, 12 Feb 2025 13:36:50 +0100
Message-ID: <20250212123659.52764-2-philmd@linaro.org>
X-Mailer: git-send-email 2.47.1
In-Reply-To: <20250212123659.52764-1-philmd@linaro.org>
References: <20250212123659.52764-1-philmd@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::336;
 envelope-from=philmd@linaro.org; helo=mail-wm1-x336.google.com
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

Introduce the EndianMode type and the DEFINE_PROP_ENDIAN() macros.
Endianness can be BIG, LITTLE or unspecified (default).

Reviewed-by: Thomas Huth <thuth@redhat.com>
Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
---
 qapi/common.json                    | 16 ++++++++++++++++
 include/hw/qdev-properties-system.h |  7 +++++++
 hw/core/qdev-properties-system.c    | 11 +++++++++++
 3 files changed, 34 insertions(+)

diff --git a/qapi/common.json b/qapi/common.json
index 6ffc7a37890..33d8df19f67 100644
--- a/qapi/common.json
+++ b/qapi/common.json
@@ -212,3 +212,19 @@
 ##
 { 'struct': 'HumanReadableText',
   'data': { 'human-readable-text': 'str' } }
+
+##
+# @EndianMode:
+#
+# An enumeration of three options: little, big, and unspecified
+#
+# @unspecified: Endianness not specified
+#
+# @little: Little endianness
+#
+# @big: Big endianness
+#
+# Since: 10.0
+##
+{ 'enum': 'EndianMode',
+  'data': [ 'unspecified', 'little', 'big' ] }
diff --git a/include/hw/qdev-properties-system.h b/include/hw/qdev-properties-system.h
index 7ec37f6316c..ead4dfc2f02 100644
--- a/include/hw/qdev-properties-system.h
+++ b/include/hw/qdev-properties-system.h
@@ -30,6 +30,7 @@ extern const PropertyInfo qdev_prop_pcie_link_speed;
 extern const PropertyInfo qdev_prop_pcie_link_width;
 extern const PropertyInfo qdev_prop_cpus390entitlement;
 extern const PropertyInfo qdev_prop_iothread_vq_mapping_list;
+extern const PropertyInfo qdev_prop_endian_mode;
 
 #define DEFINE_PROP_PCI_DEVFN(_n, _s, _f, _d)                   \
     DEFINE_PROP_SIGNED(_n, _s, _f, _d, qdev_prop_pci_devfn, int32_t)
@@ -97,4 +98,10 @@ extern const PropertyInfo qdev_prop_iothread_vq_mapping_list;
     DEFINE_PROP(_name, _state, _field, qdev_prop_iothread_vq_mapping_list, \
                 IOThreadVirtQueueMappingList *)
 
+#define DEFINE_PROP_ENDIAN(_name, _state, _field, _default) \
+    DEFINE_PROP_UNSIGNED(_name, _state, _field, _default, \
+                         qdev_prop_endian_mode, EndianMode)
+#define DEFINE_PROP_ENDIAN_NODEFAULT(_name, _state, _field) \
+    DEFINE_PROP_ENDIAN(_name, _state, _field, ENDIAN_MODE_UNSPECIFIED)
+
 #endif
diff --git a/hw/core/qdev-properties-system.c b/hw/core/qdev-properties-system.c
index a96675beb0d..89f954f569e 100644
--- a/hw/core/qdev-properties-system.c
+++ b/hw/core/qdev-properties-system.c
@@ -1283,3 +1283,14 @@ const PropertyInfo qdev_prop_iothread_vq_mapping_list = {
     .set = set_iothread_vq_mapping_list,
     .release = release_iothread_vq_mapping_list,
 };
+
+/* --- Endian modes */
+
+const PropertyInfo qdev_prop_endian_mode = {
+    .name = "EndianMode",
+    .description = "Endian mode, big/little/unspecified",
+    .enum_table = &EndianMode_lookup,
+    .get = qdev_propinfo_get_enum,
+    .set = qdev_propinfo_set_enum,
+    .set_default_value = qdev_propinfo_set_default_value_enum,
+};
-- 
2.47.1


