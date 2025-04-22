Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 57489C369C2
	for <qemu-devel@archiver.kernel.org>; Tue, 22 Apr 2025 08:42:38 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1u79C8-0004vM-Dx; Tue, 22 Apr 2025 04:41:32 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1u79By-0004tV-MV
 for qemu-devel@nongnu.org; Tue, 22 Apr 2025 04:41:25 -0400
Received: from mail-wm1-x32d.google.com ([2a00:1450:4864:20::32d])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1u79Bv-0003JD-Da
 for qemu-devel@nongnu.org; Tue, 22 Apr 2025 04:41:22 -0400
Received: by mail-wm1-x32d.google.com with SMTP id
 5b1f17b1804b1-43d07ca6a80so23483975e9.1
 for <qemu-devel@nongnu.org>; Tue, 22 Apr 2025 01:41:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1745311277; x=1745916077; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to;
 bh=yoeov9e+tM0XUlv1GH3ay9NvMbVOLWXWAK/YedufpK0=;
 b=d2vUzpX6a2rBW5mB5HigQKtUuL+5rT4nsWYT9i+3lDPAHNM19tMjOX/Dx6XsmItzHB
 MP497Savbal+Av6/8PAcQhtIutHAE63v9s70am1LOF8Tkk6btGYk5qoa+23IWSmq5R2R
 jYlujdqMG6KgLI1PyiAQZ6JBVJeV5jQbF4wyX966H5zQHzxLA7+ZYLwuEQ0uJh+QLQew
 i/dBWWTaISDetVOvoQAmq0Y0adBhcdTyIjLasEiRkyEBcBEB2bH00mrXHMUY7ZXKVyjZ
 4HzRb1bCvSiSkC38NvOUBjgXUp7/7FOv+Vpz5A/aSKFbj/zvX8fR4YeSG1bzjqr6Vqdu
 q3aA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1745311277; x=1745916077;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=yoeov9e+tM0XUlv1GH3ay9NvMbVOLWXWAK/YedufpK0=;
 b=E9XBBG5oQpAOFCdg+gaO6/xtagHnzvgnlegtFpYV2E4rI8ktqpvi4mrADaDCf9zbYb
 rUGIaCUT0NdwYZZZtB3k432DIELtZOB9Fun3QFBHjnoRbcp33Tp6WjIbCsu73IZra3Q4
 4clzomTO6pdj4F7eAktlNlslr9uu7aPb+QafV4AyOeHbkhdF0633B8Zl1/h58lBW9pM4
 dbT8UxUlOxXwwv6Y1LNKcRdIefGE3j36fgFAp7I517lACfY2xK9/uSAr4uP6YnvgP6sC
 py3L6j31RBpACjgFusyjW8/KRN246ZQXWjY08jZSPqUVzdsuAGcJuWwoiXpzN7aLS/qn
 uacQ==
X-Gm-Message-State: AOJu0YwlUGZjyWBe32nyKHNda6Rv5wdzt8nCKTvb9H4yFWW2598qNi2N
 eZaWtdww07oF6HNRQhmBFoy8bDp7SHI3qsz0QJiFItsI0NXuJ5lmS7LRVcyhzwVA9xeX1WumRD4
 x
X-Gm-Gg: ASbGncvevimYCrC0LC4dD3BiekhCkkmifo/439zITYHGQBDNRehtYS1MO85Yc18Xx5c
 xRbeZKeS8EZfQipxu9kUcwwW9oVHhFjaUOzA2HI+T/h/VnMqbZssmjX0Gr1WCc2BqqstYxPCHWa
 mjVSyEWu6mmDpBiOzT8q2aqQ9E9eSTdC8VwVlhUhoduQ3ihEkdGuarkuI1fIg3/LY4xl/keDZHN
 TFC3icUZClGRyyFAykG91flfG7e0j0TpS2n6JZN4Acdeg92vgImGdC+lWy2vsGL3QBLWlYsJEch
 MkpXf1NSjXPrrqTQX/NAnrxqGpShrOgnATKszOaiDbeY1EkObItZ1doM1K0E9AcjYCB4indAYxC
 Fewe0QdM4uItx+8Y=
X-Google-Smtp-Source: AGHT+IHVS9Q1L6iCAoJOIX2WS0KCbkTBSGyvuLXZJUZA350ohvALrSGVCNVJlSybnOr0euGix7duGw==
X-Received: by 2002:a05:600c:cc4:b0:43b:d0fe:b8ac with SMTP id
 5b1f17b1804b1-4406ac0fcd2mr140501095e9.30.1745311276794; 
 Tue, 22 Apr 2025 01:41:16 -0700 (PDT)
Received: from localhost.localdomain (88-187-86-199.subs.proxad.net.
 [88.187.86.199]) by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-39efa4a4f21sm14626799f8f.91.2025.04.22.01.41.15
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Tue, 22 Apr 2025 01:41:16 -0700 (PDT)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
To: qemu-devel@nongnu.org
Cc: Zhao Liu <zhao1.liu@intel.com>, Markus Armbruster <armbru@redhat.com>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Nicholas Piggin <npiggin@gmail.com>,
 Marcel Apfelbaum <marcel.apfelbaum@gmail.com>,
 Eduardo Habkost <eduardo@habkost.net>,
 Daniel Henrique Barboza <danielhb413@gmail.com>, qemu-ppc@nongnu.org,
 Yanan Wang <wangyanan55@huawei.com>, qemu-stable@nongnu.org,
 Gavin Shan <gshan@redhat.com>
Subject: [PATCH] hw/core: Get default_cpu_type calling
 machine_class_default_cpu_type()
Date: Tue, 22 Apr 2025 10:41:14 +0200
Message-ID: <20250422084114.39499-1-philmd@linaro.org>
X-Mailer: git-send-email 2.47.1
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::32d;
 envelope-from=philmd@linaro.org; helo=mail-wm1-x32d.google.com
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

Since commit 62b4a227a33 the default cpu type can come from the
valid_cpu_types[] array. Call the machine_class_default_cpu_type()
instead of accessing MachineClass::default_cpu_type field.

Cc: qemu-stable@nongnu.org
Fixes: 62b4a227a33 ("hw/core: Add machine_class_default_cpu_type()")
Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
---
Cc: Gavin Shan <gshan@redhat.com>
---
 hw/core/machine-qmp-cmds.c | 5 +++--
 target/ppc/cpu_init.c      | 2 +-
 2 files changed, 4 insertions(+), 3 deletions(-)

diff --git a/hw/core/machine-qmp-cmds.c b/hw/core/machine-qmp-cmds.c
index 3130c5cd456..1bc21b84a4f 100644
--- a/hw/core/machine-qmp-cmds.c
+++ b/hw/core/machine-qmp-cmds.c
@@ -72,6 +72,7 @@ MachineInfoList *qmp_query_machines(bool has_compat_props, bool compat_props,
 
     for (el = machines; el; el = el->next) {
         MachineClass *mc = el->data;
+        const char *default_cpu_type = machine_class_default_cpu_type(mc);
         MachineInfo *info;
 
         info = g_malloc0(sizeof(*info));
@@ -90,8 +91,8 @@ MachineInfoList *qmp_query_machines(bool has_compat_props, bool compat_props,
         info->numa_mem_supported = mc->numa_mem_supported;
         info->deprecated = !!mc->deprecation_reason;
         info->acpi = !!object_class_property_find(OBJECT_CLASS(mc), "acpi");
-        if (mc->default_cpu_type) {
-            info->default_cpu_type = g_strdup(mc->default_cpu_type);
+        if (default_cpu_type) {
+            info->default_cpu_type = g_strdup(default_cpu_type);
         }
         if (mc->default_ram_id) {
             info->default_ram_id = g_strdup(mc->default_ram_id);
diff --git a/target/ppc/cpu_init.c b/target/ppc/cpu_init.c
index f81cb680fc3..21a76e904af 100644
--- a/target/ppc/cpu_init.c
+++ b/target/ppc/cpu_init.c
@@ -7082,7 +7082,7 @@ ObjectClass *ppc_cpu_class_by_name(const char *name)
     if (strcmp(name, "max") == 0) {
         MachineClass *mc = MACHINE_GET_CLASS(qdev_get_machine());
         if (mc) {
-            return object_class_by_name(mc->default_cpu_type);
+            return object_class_by_name(machine_class_default_cpu_type(mc));
         }
     }
 #endif
-- 
2.47.1


