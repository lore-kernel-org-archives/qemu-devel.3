Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2810DC02193
	for <qemu-devel@archiver.kernel.org>; Tue,  4 Feb 2025 20:11:12 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tfPFE-000142-Aj; Tue, 04 Feb 2025 15:10:04 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1tfPEz-0000w9-Bm
 for qemu-devel@nongnu.org; Tue, 04 Feb 2025 15:09:51 -0500
Received: from mail-wm1-x332.google.com ([2a00:1450:4864:20::332])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1tfPEv-0006Om-RI
 for qemu-devel@nongnu.org; Tue, 04 Feb 2025 15:09:48 -0500
Received: by mail-wm1-x332.google.com with SMTP id
 5b1f17b1804b1-4361f796586so71099675e9.3
 for <qemu-devel@nongnu.org>; Tue, 04 Feb 2025 12:09:44 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1738699783; x=1739304583; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=BrfjnJSg9CX0l2LnyeLtW/bJrqIZsHOwQ9P6gpzmndY=;
 b=J+LBwAfMNXb2GHQc1AAps3xejB0wQ3DfNg71DUXkOsYrgp5sSMBa6aYHx9UB1spuVA
 VAce/bb9PQBLb1xTlHmZeeQA1GM7Cwjn8gpBg93uP5gIFKbLECppGrNylqXB8hUvCK/S
 HDvlO8sJRflSXTlERY8ZnwmQql7WpY9uGrOCqvOcZl/M4MY0PsyPihLGbSZV6frTWigB
 L6UXjptN0IVSBim/o66OZRaMHOtKVnVlm7pwychqT/kADNhrKoZn/Djm5GjVGySYnMzx
 F3jY3P+eqPI53YiGyomPurmN7/oCbCSsdeqfOF497R3rSYkkuzHqPwVlmd6CxTBx3WGq
 qhvw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1738699783; x=1739304583;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=BrfjnJSg9CX0l2LnyeLtW/bJrqIZsHOwQ9P6gpzmndY=;
 b=DVDuT369pEBxmUXS3W+RGOoAHeonSdctU7+l3CXB2am/jmXvyVZZZTmnLKIUO4B4d5
 cG63446ZF4XuKT0YpsA4D84NocvALmnjqj58cMPspNXHhfE31jmNlHC7LpNo5JRvAjvR
 FCELT5j5othHpPM0o1zFoTAv7zVHfYdERf0jILr1MS9yXe387xC5Ztxw41yjqFdCkHY8
 Cqj0rp4TTZMzXAB3alQ4IiGDpePhEjzqwlO1FufcsRXgKDFLmB0VxtjygaN/9oxo24yE
 9ae2kb6cf74LptF+bm/1o4eEvImJtoje30lUMtbWBBeFLemg5cfgjx67nfovo3/JnY49
 rFNQ==
X-Gm-Message-State: AOJu0YxKFj2aUMk28dyKjwZikxUO7WNFyL7ewCmzTp1b46EWbWyMo1mp
 hYgVqSHpVSW2MBnzB4UyuNTynq9nmgAaVlAjDFZidJgNh30JSSwcXwMmncpnuzZ4KXs4ti58zGJ
 4uyI=
X-Gm-Gg: ASbGncuhQRSxiKcQVxYI/yZhrLtHOYsqGkjyIC2/vgMgKMHYM35cMIswq2YFyijAyD3
 3k3SQP6+RPCkU9K9A/vF2gjFA8v1tHp1PN5j97jTOoJj98eUcwB9ofX3RmoNJFvS6ZpUG4XbUIA
 MOjWMzqRtV+HSsabZKyzp5dJIkJer6+EAAWMfBt7BdiXouYt79f9dWfLp7XSBtTsF3m1/Yxhrwo
 wRwAEtx+JAf5cN/SrFKwrUfNtPWdZ9D7i2PPxHrWQ+61+iKcxIkfcd2F4ZF6X5YyHttXNv2fGD1
 aLPl9/hY8O74s3EYTeHQ0b93HUW1PVvpktaKScKByL3NGVkeP5g+3KroCcOVYw9TBw==
X-Google-Smtp-Source: AGHT+IHHWTJ/su69cvMPLa86OLnfOM8eXOZDAnGWS9KRbnyoIi1cbvbhglXphr/F27zeh0wNHNjMKA==
X-Received: by 2002:a05:600c:4586:b0:434:a734:d279 with SMTP id
 5b1f17b1804b1-4390d43e90emr6995e9.16.1738699781774; 
 Tue, 04 Feb 2025 12:09:41 -0800 (PST)
Received: from localhost.localdomain (88-187-86-199.subs.proxad.net.
 [88.187.86.199]) by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-38c5c102e51sm16990636f8f.31.2025.02.04.12.09.40
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Tue, 04 Feb 2025 12:09:41 -0800 (PST)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
To: qemu-devel@nongnu.org
Cc: qemu-riscv@nongnu.org, qemu-s390x@nongnu.org,
 Markus Armbruster <armbru@redhat.com>, qemu-arm@nongnu.org,
 qemu-ppc@nongnu.org,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Thomas Huth <thuth@redhat.com>
Subject: [PATCH v4 1/7] hw/boards: Convert no_sdcard flag to OnOffAuto
 tri-state
Date: Tue,  4 Feb 2025 21:09:28 +0100
Message-ID: <20250204200934.65279-2-philmd@linaro.org>
X-Mailer: git-send-email 2.47.1
In-Reply-To: <20250204200934.65279-1-philmd@linaro.org>
References: <20250204200934.65279-1-philmd@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::332;
 envelope-from=philmd@linaro.org; helo=mail-wm1-x332.google.com
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

MachineClass::no_sdcard is initialized as false by default.
To catch all uses, convert it to a tri-state, having the
current default (false) becoming AUTO.

No logical change intended.

Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
Reviewed-by: Thomas Huth <thuth@redhat.com>
---
 include/hw/boards.h        | 2 +-
 hw/arm/xilinx_zynq.c       | 2 +-
 hw/core/null-machine.c     | 2 +-
 hw/s390x/s390-virtio-ccw.c | 2 +-
 system/vl.c                | 2 +-
 5 files changed, 5 insertions(+), 5 deletions(-)

diff --git a/include/hw/boards.h b/include/hw/boards.h
index e1f41b2a533..d61b0a47780 100644
--- a/include/hw/boards.h
+++ b/include/hw/boards.h
@@ -283,9 +283,9 @@ struct MachineClass {
         no_parallel:1,
         no_floppy:1,
         no_cdrom:1,
-        no_sdcard:1,
         pci_allow_0_address:1,
         legacy_fw_cfg_order:1;
+    OnOffAuto no_sdcard;
     bool is_default;
     const char *default_machine_opts;
     const char *default_boot_order;
diff --git a/hw/arm/xilinx_zynq.c b/hw/arm/xilinx_zynq.c
index 8477b828745..12418094f9d 100644
--- a/hw/arm/xilinx_zynq.c
+++ b/hw/arm/xilinx_zynq.c
@@ -463,7 +463,7 @@ static void zynq_machine_class_init(ObjectClass *oc, void *data)
     mc->desc = "Xilinx Zynq Platform Baseboard for Cortex-A9";
     mc->init = zynq_init;
     mc->max_cpus = ZYNQ_MAX_CPUS;
-    mc->no_sdcard = 1;
+    mc->no_sdcard = ON_OFF_AUTO_ON;
     mc->ignore_memory_transaction_failures = true;
     mc->valid_cpu_types = valid_cpu_types;
     mc->default_ram_id = "zynq.ext_ram";
diff --git a/hw/core/null-machine.c b/hw/core/null-machine.c
index f586a4bef54..b93056c0f7b 100644
--- a/hw/core/null-machine.c
+++ b/hw/core/null-machine.c
@@ -53,7 +53,7 @@ static void machine_none_machine_init(MachineClass *mc)
     mc->no_parallel = 1;
     mc->no_floppy = 1;
     mc->no_cdrom = 1;
-    mc->no_sdcard = 1;
+    mc->no_sdcard = ON_OFF_AUTO_ON;
 }
 
 DEFINE_MACHINE("none", machine_none_machine_init)
diff --git a/hw/s390x/s390-virtio-ccw.c b/hw/s390x/s390-virtio-ccw.c
index d9e683c5b49..5f78c8d20ff 100644
--- a/hw/s390x/s390-virtio-ccw.c
+++ b/hw/s390x/s390-virtio-ccw.c
@@ -817,7 +817,7 @@ static void ccw_machine_class_init(ObjectClass *oc, void *data)
     mc->no_cdrom = 1;
     mc->no_floppy = 1;
     mc->no_parallel = 1;
-    mc->no_sdcard = 1;
+    mc->no_sdcard = ON_OFF_AUTO_ON;
     mc->max_cpus = S390_MAX_CPUS;
     mc->has_hotpluggable_cpus = true;
     mc->smp_props.books_supported = true;
diff --git a/system/vl.c b/system/vl.c
index db8e604ebab..2940c865b19 100644
--- a/system/vl.c
+++ b/system/vl.c
@@ -1346,7 +1346,7 @@ static void qemu_disable_default_devices(void)
     if (!has_defaults || machine_class->no_cdrom) {
         default_cdrom = 0;
     }
-    if (!has_defaults || machine_class->no_sdcard) {
+    if (!has_defaults || machine_class->no_sdcard == ON_OFF_AUTO_ON) {
         default_sdcard = 0;
     }
     if (!has_defaults) {
-- 
2.47.1


