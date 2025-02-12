Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6E93BC021A1
	for <qemu-devel@archiver.kernel.org>; Wed, 12 Feb 2025 11:25:33 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tiAr4-00060I-65; Wed, 12 Feb 2025 06:24:36 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1tiAqv-0005wd-Ov
 for qemu-devel@nongnu.org; Wed, 12 Feb 2025 06:24:27 -0500
Received: from mail-wr1-x42b.google.com ([2a00:1450:4864:20::42b])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1tiAqs-0004Rs-H5
 for qemu-devel@nongnu.org; Wed, 12 Feb 2025 06:24:25 -0500
Received: by mail-wr1-x42b.google.com with SMTP id
 ffacd0b85a97d-38a25d4b9d4so3474846f8f.0
 for <qemu-devel@nongnu.org>; Wed, 12 Feb 2025 03:24:22 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1739359461; x=1739964261; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=IcGwPw1KAay48jXvk36yUAnIISfs7y+i362KBjH7aCo=;
 b=Aw5ZjrU31SzRONn93F+4iorSSVB99rhJPQe7tOKH5docxDCoacADiEJTrcd3OgRZnq
 8IiGGfXWI32qecV9gluEv4jgIibiC6ELpkVlS6bq3HJf4gWeYy5k0Z9nCylzi/Q8RgMU
 mq/1egRvWYQ5KmX6IJu80BvakfEjQ8QBEKZ1Jeg5oRb7s/fMh73yx3Jv+fzEb4hhoseh
 TONljsp39o2TiKKGbynZi4mMJAipBloqgexKpV1ZQEK3te4aHkFC26loTVlkM5USSSA6
 6pCZ9PA/gXzS7AYccDceFqN6uc5a1WDuRQUnhbCwJJIkET8IsQmGQNX/YD2fLzww3Nkn
 VGbw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1739359461; x=1739964261;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=IcGwPw1KAay48jXvk36yUAnIISfs7y+i362KBjH7aCo=;
 b=Ilm3Sc56ppdFUYWlp5RT7APHgf523MTj7wKlkqvIbKnt+sX20cAlVT7+JHPqQtAJZG
 dqD7lG+Ga0cyXK6eNtC4XFYOqOIFaCZ9VTC2iWy4cZav9LzEiW8e+dIqk7jVaPgYlsHP
 OgV0YYyNYYDsTXEieBAP1hkTUw7PWm0/BJzUki/TE2tf+NAvjpoKR2mIWEgl4Y1B9CoC
 evFbi6abztNmxBIfPv93/hTd6veeWvlSX8822FSpOiHGSk1qy2jICVBA1byQChKOvw/m
 Vun3Lj91OECZc0X9BFeosfg4nv8lrdwSBxziWzpdvvRmVPK8HifTiQObTDD0ST5bvn/N
 s5dw==
X-Gm-Message-State: AOJu0YyKMOkJ4N+hrKf0uAmXWixrjQ/W5xI1Vkp0LUlgJsCxgs8sU9CC
 vUpnGvu2XqpUZrRPw8Me1Ezeo6k2Nt7W2vU2dTdGs256TKayC3t4YcI6StHbiRERBmNOkystT8y
 bTsY=
X-Gm-Gg: ASbGncv2xkiMyEolS0Tw/5hl/oFGeUPXDvgbe9ikamflFWV1wPdSFGZvWPwzTYwpCAW
 kW8Mc3fbkRuxFKuBrpat8S89bOnaJk6ZIWVfrp+ABfShh2BXgCzQAoJmwHr+/2LwoUQXYaH+Egq
 RKWaXE10z8DzEaLqEOpcosKxlIDhrd8lboinooek4Qu7qRJBLc1sJqvH1SPoIOY+LJmuVjrsNiX
 C1b9zmhjd0tzSIGEPkD/ThkkiKo8GmYWIkTm31n6kaXIvNZ5mEuFl/jG0H0Sy6S1D/ph+GvmbsV
 owmjAha7y0kGAAp2ANDoK8Hq8Xk6/Qi0khtRqzJ8+8l5F5Y8TdGahBDqHgXmeGxxPw==
X-Google-Smtp-Source: AGHT+IGdBKzBa8PDAI4y/2XXCk5AwlL5gt3FIYqzHZUkjF0O7Q0tFCVSyRSIzYaFAXpu5JXgnAVWpg==
X-Received: by 2002:a05:6000:1818:b0:38d:e304:7485 with SMTP id
 ffacd0b85a97d-38dea265ebfmr1914973f8f.19.1739359460764; 
 Wed, 12 Feb 2025 03:24:20 -0800 (PST)
Received: from localhost.localdomain (88-187-86-199.subs.proxad.net.
 [88.187.86.199]) by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-38dc5a8a9e4sm15910608f8f.10.2025.02.12.03.24.19
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Wed, 12 Feb 2025 03:24:20 -0800 (PST)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
To: qemu-devel@nongnu.org
Cc: qemu-riscv@nongnu.org, qemu-ppc@nongnu.org,
 "Edgar E. Iglesias" <edgar.iglesias@gmail.com>,
 Alistair Francis <alistair@alistair23.me>,
 Richard Henderson <richard.henderson@linaro.org>,
 Thomas Huth <thuth@redhat.com>, Markus Armbruster <armbru@redhat.com>,
 qemu-arm@nongnu.org,
 =?UTF-8?q?Daniel=20P=2E=20Berrang=C3=A9?= <berrange@redhat.com>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
Subject: [PATCH v6 01/11] hw/qdev-properties-system: Introduce EndianMode QAPI
 enum
Date: Wed, 12 Feb 2025 12:24:03 +0100
Message-ID: <20250212112413.37553-2-philmd@linaro.org>
X-Mailer: git-send-email 2.47.1
In-Reply-To: <20250212112413.37553-1-philmd@linaro.org>
References: <20250212112413.37553-1-philmd@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::42b;
 envelope-from=philmd@linaro.org; helo=mail-wr1-x42b.google.com
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

Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
---
 qapi/common.json                    | 16 ++++++++++++++++
 include/hw/qdev-properties-system.h |  7 +++++++
 hw/core/qdev-properties-system.c    | 11 +++++++++++
 3 files changed, 34 insertions(+)

diff --git a/qapi/common.json b/qapi/common.json
index 6ffc7a37890..217feaaf683 100644
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
+# @little: Little endianness
+#
+# @big: Big endianness
+#
+# @unspecified: Endianness not specified
+#
+# Since: 10.0
+##
+{ 'enum': 'EndianMode',
+  'data': [ 'little', 'big', 'unspecified' ] }
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


