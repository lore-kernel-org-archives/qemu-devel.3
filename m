Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D766AC3600C
	for <qemu-devel@archiver.kernel.org>; Thu,  3 Apr 2025 20:41:14 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1u0RMp-0000QQ-1J; Thu, 03 Apr 2025 16:40:51 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1u0RMn-0000QE-Io
 for qemu-devel@nongnu.org; Thu, 03 Apr 2025 16:40:49 -0400
Received: from mail-wr1-x42a.google.com ([2a00:1450:4864:20::42a])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1u0RMi-000523-Om
 for qemu-devel@nongnu.org; Thu, 03 Apr 2025 16:40:49 -0400
Received: by mail-wr1-x42a.google.com with SMTP id
 ffacd0b85a97d-3913b539aabso772213f8f.2
 for <qemu-devel@nongnu.org>; Thu, 03 Apr 2025 13:40:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1743712842; x=1744317642; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=91qw8dB7Eg7Eq+MHz4XIrej88B1FVRM9ctS9zjgiZGk=;
 b=wiNHb4TXxLhauYBb42lEygT+ElfPmQYLPU1CT3g2wPNmVMQQjWOtxLHTxnBM9qkRWm
 YW3KjzLTVRNmYy+VGdp2JOJEc50aCWdnnO+m0/X3TAnD48pX7NkJSDmV8IjKHpVtl6FI
 fUPrfG0LyxBWk7LZjJU4EeEppx+Hu+E/eOcVkciaO7H9gdol8NGh7nWlmJ3qhfSea1VF
 dwKIM0vjVxpw1F4vbDwpz5JXnKIJW6Ow7SBqgPhMp70Io20Pv+UVEhM3OpU48tNaXDZo
 PLng0Lk8RhOdDhjytLxM/lF/4mHbpV+aDFyzJfHF64aopkaRZ6Czcl1TeamQl2UxKhrC
 U99A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1743712842; x=1744317642;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=91qw8dB7Eg7Eq+MHz4XIrej88B1FVRM9ctS9zjgiZGk=;
 b=YQIMGNsZx6hxiHa4Icr3JveorEg1cT0cWAqW0B/C+hCfRp2OjJe0nxH+/ozq4gAuXt
 VxSJzWQOZDPdhYCFSuRSymL8vkCpT47uPkQUUNaH9XxCjDnHI9lQdKu0Qwvc7Hgxq4Jt
 eY8tevDQV+RJIa6HMKjqzv4UxgZyxJaRsKwR31nOPVKVQWfWAG8CE0HH196NbnrrbcSZ
 U31qPGg8MojZG2UzOf29P1IxEi/FQwKsfs29XkXpJzNUr/j0GwBJzPCOhGqEWLwog7AS
 M9Ci56Ou0c2+WgpSxhhCm6gf/PN50fnl4HOCkk/SiYRLtr9tKTUo3xfL00g9ykXM/aQK
 xM4g==
X-Gm-Message-State: AOJu0YwHigf/pA4Inej8oBuzZ2q0/im9BwU07D/oeM4MzNkfhmHaO00f
 I1kIU9BwQMHrXI5qr2U5KNb/k8Sz895ZBRR/kjZwcRiMcC/MRkXv3Eot58hQrKQymglrmlyX1eI
 F
X-Gm-Gg: ASbGncvihW+YAVBh2VLZ1VCoWcTRzKf8ksqgURz3cByBKQY7seYx4rUvFCuEjMrEH4R
 U6ViWjjSliRc8boGbDt0nZR7eza8YyRm5+cHoETfRwJlHaYNIsKuEaPEjg8ATf/5NpcOBFmBirF
 FjIU15ntlXqfiBKa0sxcOiOPjHOjZa957G7stmlufYU5ixqYT7vK+gdU1qYRqQAbgpNKp4JfyKE
 OhmTGjqjM+ufJlDT/T+508tnjFqTY4YTeH7iEYqhu2++1ucsTkqE/zz4LhlHmzC8ysAWu7cykQ3
 muihfipdP1pHUS1ORfbXkgrAzmQsjch9yWe/9PNkuv7IKy0Kt2jcmz5poaXhpMvQ4QimqI9hzoX
 KygXtPHvh1RXPlbiV/sS8yPGobmrF7JJNoXQ=
X-Google-Smtp-Source: AGHT+IF0VB25+QWZbsznnQinFc032J8n9BsALOb34HjpL7ukA/Tx7TYioKqQiRbt6yig2CP+o+N8Tg==
X-Received: by 2002:a05:6000:188f:b0:391:3915:cfea with SMTP id
 ffacd0b85a97d-39cba93329amr612537f8f.38.1743712842401; 
 Thu, 03 Apr 2025 13:40:42 -0700 (PDT)
Received: from localhost.localdomain (88-187-86-199.subs.proxad.net.
 [88.187.86.199]) by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-43ec1663053sm30876275e9.15.2025.04.03.13.40.40
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Thu, 03 Apr 2025 13:40:41 -0700 (PDT)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
To: qemu-devel@nongnu.org
Cc: Andrew Jones <ajones@ventanamicro.com>,
 =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>,
 "Michael S. Tsirkin" <mst@redhat.com>, qemu-arm@nongnu.org,
 Udo Steinberg <udo@hypervisor.org>,
 Shannon Zhao <shannon.zhaosl@gmail.com>,
 Gustavo Romero <gustavo.romero@linaro.org>,
 Igor Mammedov <imammedo@redhat.com>,
 Peter Maydell <peter.maydell@linaro.org>, Ani Sinha <anisinha@redhat.com>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Richard Henderson <richard.henderson@linaro.org>
Subject: [PATCH-for-10.1 v3 2/9] hw/intc/gicv3_its: Do not check
 its_class_name() for NULL
Date: Thu,  3 Apr 2025 22:40:22 +0200
Message-ID: <20250403204029.47958-3-philmd@linaro.org>
X-Mailer: git-send-email 2.47.1
In-Reply-To: <20250403204029.47958-1-philmd@linaro.org>
References: <20250403204029.47958-1-philmd@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::42a;
 envelope-from=philmd@linaro.org; helo=mail-wr1-x42a.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 T_SPF_TEMPERROR=0.01 autolearn=unavailable autolearn_force=no
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

Since commit cc5e719e2c8 ("kvm: require KVM_CAP_SIGNAL_MSI"),
its_class_name() single implementation doesn't return NULL
anymore. Update the prototype docstring, and remove the
pointless checks.

Reported-by: Gustavo Romero <gustavo.romero@linaro.org>
Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
Reviewed-by: Richard Henderson <richard.henderson@linaro.org>
---
 include/hw/intc/arm_gicv3_its_common.h | 2 +-
 hw/arm/virt-acpi-build.c               | 4 ++--
 2 files changed, 3 insertions(+), 3 deletions(-)

diff --git a/include/hw/intc/arm_gicv3_its_common.h b/include/hw/intc/arm_gicv3_its_common.h
index 7dc712b38d2..3c7b543b018 100644
--- a/include/hw/intc/arm_gicv3_its_common.h
+++ b/include/hw/intc/arm_gicv3_its_common.h
@@ -128,7 +128,7 @@ struct GICv3ITSCommonClass {
  * Return the ITS class name to use depending on whether KVM acceleration
  * and KVM CAP_SIGNAL_MSI are supported
  *
- * Returns: class name to use or NULL
+ * Returns: class name to use
  */
 const char *its_class_name(void);
 
diff --git a/hw/arm/virt-acpi-build.c b/hw/arm/virt-acpi-build.c
index 3ac8f8e1786..9b7fc99f170 100644
--- a/hw/arm/virt-acpi-build.c
+++ b/hw/arm/virt-acpi-build.c
@@ -741,7 +741,7 @@ build_madt(GArray *table_data, BIOSLinker *linker, VirtMachineState *vms)
                                           memmap[VIRT_HIGH_GIC_REDIST2].size);
         }
 
-        if (its_class_name() && !vmc->no_its) {
+        if (!vmc->no_its) {
             /*
              * ACPI spec, Revision 6.0 Errata A
              * (original 6.0 definition has invalid Length)
@@ -973,7 +973,7 @@ void virt_acpi_build(VirtMachineState *vms, AcpiBuildTables *tables)
                           vms->oem_table_id);
     }
 
-    if (its_class_name() && !vmc->no_its) {
+    if (!vmc->no_its) {
         acpi_add_table(table_offsets, tables_blob);
         build_iort(tables_blob, tables->linker, vms);
     }
-- 
2.47.1


