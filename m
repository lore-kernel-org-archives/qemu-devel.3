Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id F2375C02198
	for <qemu-devel@archiver.kernel.org>; Sun, 16 Feb 2025 21:02:04 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tjllO-0002x3-Uf; Sun, 16 Feb 2025 16:01:20 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1tjllK-0002vt-1D
 for qemu-devel@nongnu.org; Sun, 16 Feb 2025 16:01:14 -0500
Received: from mail-wm1-x32f.google.com ([2a00:1450:4864:20::32f])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1tjllI-0007tb-Cy
 for qemu-devel@nongnu.org; Sun, 16 Feb 2025 16:01:13 -0500
Received: by mail-wm1-x32f.google.com with SMTP id
 5b1f17b1804b1-4395f66a639so21898585e9.0
 for <qemu-devel@nongnu.org>; Sun, 16 Feb 2025 13:01:12 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1739739670; x=1740344470; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=VkyzUhB3/r5FKmFNHJ6alO+UuiYZhYCsq602cNE3EOo=;
 b=jymf0gLwQMEy7QfHBPrwjW0GTc1jwHr0dsDGUfij0vI4bgeNsiJzy/B6XePN1Vj3Ui
 ovxkToQPSetMY5KWvVmneNTaqGhR0l9NrXHazT3z+xXXhvmMEMuochewsXoocwU+vC1H
 rwt18fiv3GDXP3NBlaZdgd82vM62UUgNuu3i+ewE2LU+G7+GCnwiqf1daQBhGg/aQLd3
 uD+BM2a1p9o0CG2ccu6CmqSBs4BtMDrWsfNIr98P6+i2vHUhYH6Z8i2FdHU5J8/f257Z
 FScQDeXQ/FOaFrBqRe28Tzk1nOqFrAbNhith7c2yPfLWT/lPhplgVdlZqE+umCcKRjFF
 augA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1739739670; x=1740344470;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=VkyzUhB3/r5FKmFNHJ6alO+UuiYZhYCsq602cNE3EOo=;
 b=a9bMG7p0MGB06AWWzAMNwev+URY8pPo/pxNHyNpUJp6HBP3blgZTJ445HmMhqBRCuX
 DB/8qCWYP8nc1q8ON6I1qJnUTd+VhdslceUWBZQDp5oucrXnpod6M3d6RsV4KO6obMX+
 0R1nfkeg24OE0azy4kdwRWIIcPh3+cOCMijc/3JP/s/TQCOrMjjhp3F/CFYzr3tMRC61
 +Y/KaUiSPmolU1ZWba7PrcAmB7wKNjHK8kDKznJ2D+9WL+l7lyBODsui+Sp6XfAuhGAW
 4426YzxRChr49kXW0y4K0C73WFZGRlBsiber0s+JD697dvPM6esc7RwcncX9ydJUIi2q
 nt7w==
X-Gm-Message-State: AOJu0Yz+cgnFSIADlXy2+wE8Zj5gYUdsja9pNcApHn6yG2bt/r5xnQ4u
 to0QVy1h4pc7xNatJ6vJZRwSBdyIJd06QeNVgsQ8v+RqEhH+jtPe6wdVO2o8wwRbJCnhyZwK73f
 6sz4=
X-Gm-Gg: ASbGncsSxqO5KPh9uiGK8vD3EYAN8dv3UEB1Jjp8DDr/WG84lx/wrzRE1TaztoopVZk
 PiPa7mPbtr1tirMeW1o8nHZgOcDjpwuqBfhGFPkKiG09Au2lPtHWVSG8BjUmJ7Pe7DaAi7OP5u3
 RarrRC+Yjs2gWC7TGmxNP7BBY4zIofglC0SE5EH6ynn7ltQZvw/oFELlmfQjWGl6Q70wtFGvOfo
 b/p8IwTduxAS5Kx8C6BecdGJ6Vtfjq+ivyH/tbdqTg6li2zz6RmEANM2cUsfJYkrK7Gu2MXWK9n
 j5Ypwm/oV38sd74PozStKEI2JI5iR8BWNZ/P9+80ASPJtTz9ueUiBCe5ZrYUmSKGUaQ4L8M=
X-Google-Smtp-Source: AGHT+IEjykP/JMg5uTAdLtI7PAKHhBbeDyNSyYJAvbnSPaQLenaMk32iR8v79ugLaSSp+nGTyrLwJQ==
X-Received: by 2002:a5d:4a91:0:b0:38f:2ef1:dd2b with SMTP id
 ffacd0b85a97d-38f33f2f2d5mr4541276f8f.22.1739739670333; 
 Sun, 16 Feb 2025 13:01:10 -0800 (PST)
Received: from localhost.localdomain (88-187-86-199.subs.proxad.net.
 [88.187.86.199]) by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-38f259d94acsm10599645f8f.75.2025.02.16.13.01.09
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Sun, 16 Feb 2025 13:01:09 -0800 (PST)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
To: qemu-devel@nongnu.org
Cc: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Thomas Huth <thuth@redhat.com>, Markus Armbruster <armbru@redhat.com>,
 Richard Henderson <richard.henderson@linaro.org>
Subject: [PULL 29/39] hw/qdev-properties-system: Introduce EndianMode QAPI enum
Date: Sun, 16 Feb 2025 22:00:53 +0100
Message-ID: <20250216210103.70235-2-philmd@linaro.org>
X-Mailer: git-send-email 2.47.1
In-Reply-To: <20250216210103.70235-1-philmd@linaro.org>
References: <20250216210103.70235-1-philmd@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::32f;
 envelope-from=philmd@linaro.org; helo=mail-wm1-x32f.google.com
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

Introduce the EndianMode type and the DEFINE_PROP_ENDIAN() macros.
Endianness can be BIG, LITTLE or unspecified (default).

Reviewed-by: Thomas Huth <thuth@redhat.com>
Acked-by: Markus Armbruster <armbru@redhat.com>
Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
Reviewed-by: Richard Henderson <richard.henderson@linaro.org>
Message-Id: <20250213122217.62654-2-philmd@linaro.org>
---
 qapi/common.json                    | 14 ++++++++++++++
 include/hw/qdev-properties-system.h |  7 +++++++
 hw/core/qdev-properties-system.c    | 11 +++++++++++
 3 files changed, 32 insertions(+)

diff --git a/qapi/common.json b/qapi/common.json
index 6ffc7a37890..0e3a0bbbfb0 100644
--- a/qapi/common.json
+++ b/qapi/common.json
@@ -212,3 +212,17 @@
 ##
 { 'struct': 'HumanReadableText',
   'data': { 'human-readable-text': 'str' } }
+
+##
+# @EndianMode:
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


