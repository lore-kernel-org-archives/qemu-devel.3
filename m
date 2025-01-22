Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 85483C02181
	for <qemu-devel@archiver.kernel.org>; Wed, 22 Jan 2025 09:33:19 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1taX4v-0001wl-9D; Wed, 22 Jan 2025 04:31:17 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1taX4t-0001vy-Ix
 for qemu-devel@nongnu.org; Wed, 22 Jan 2025 04:31:15 -0500
Received: from mail-wr1-x42d.google.com ([2a00:1450:4864:20::42d])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1taX4r-0003K3-SQ
 for qemu-devel@nongnu.org; Wed, 22 Jan 2025 04:31:15 -0500
Received: by mail-wr1-x42d.google.com with SMTP id
 ffacd0b85a97d-38a8b35e168so409887f8f.1
 for <qemu-devel@nongnu.org>; Wed, 22 Jan 2025 01:31:13 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1737538272; x=1738143072; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=XAK8+ZcQI8PZXdkgjSlPlEy1wFV5KzZpV4Si9c0ft5M=;
 b=VXAjRfjE8OylNIyuOsBkgXwpcq94dayKhJgrI1QhZitsYBaSz7jvIi1OjIHZ8hg6aH
 0HapH6CoLoXR1YVkvOu/+FfZX+abTU1UuIcx/Ziiqpd4eEXpzgWORCqGeO9rnn2Qi388
 PSmQisliiPSz37rcNI8q5JaUiuLvuJjQzA5HWCItW+GW7BvNkSh9YYcgkP51o1f0gg4H
 K8VfRudtaxQqTXBD+dZUVNAA7cWlY7WGWHF2c9LC2R0xDMI45axgpKXz6rLX5u+IuhoN
 zPw9E6/ulbeQFsxE1pwOItw5lvOJqDn3LzyakVszCqkHNeheDehXxGU5Ca6heDeXzPUj
 6pHQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1737538272; x=1738143072;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=XAK8+ZcQI8PZXdkgjSlPlEy1wFV5KzZpV4Si9c0ft5M=;
 b=dj8O3ZHCG0GPQMWZZOxVo68q2mF+WEah1AfCB1+1zZfIdfYBuQvk30yh26XI/gTll1
 nVSQ1mkxhwG/nZcsnFlMhf7PumhjOdKK4gDZGnXrdheEcqEAs5bNu8S71I0ikQzvJaVG
 fkrqhmx0zN4Ou5gdExpef3Zd74y+VBO7nAd4m8VXKtAAcXkSmzhavwYvrA7/ZFBUxWxV
 0g50d8NEUYShbmO8JUWpfniQtgT7ZYxjpI/VfiCQid1D5eWDSLNFRpF3RHleBsSehoDI
 qG6h2Uv81OB6KEySfNv9AEwc49vai4jMBi0a/Z6ihg21HLzE3M9m4Fe8H63VEyZFO93n
 8v7Q==
X-Gm-Message-State: AOJu0Yyr2GmF1Z6bi5tJENq64pVXxSQeF5yZ7EpdOKxNvUmGrWqKq7KU
 DhEwzCHZ7Tm12TiIttrypuLblY/SWQcHeGKzU3umAUJ946eI889UTrqICqagiV/kOr9TugSpwci
 DGcs=
X-Gm-Gg: ASbGncuNhmTHMxy7qNSruaQJrGpbhs/bKu8BP3jykiCOKu5y0x5Q99NHPlo+V9WPfVD
 g1Kiev7Qedo0hzKnRSKMahFWBEM++dToqMHbVlJl1PdNCXtZ6yoSXtMG2zJULjdtcQyirZZIUdS
 hOpzZSfcf7ql5G3MYT87OhHk6pSUC8NbXaSKfU3cjg/bwsLucXIecGoKI7GyPNlI/Aw4i89daVX
 Er0kSCS+3QYzuwqzteWlyC+KdfPfxzNXN3vYYv1yb/m4pOAGW4OI+/rA4AZsZGB/Uzbrmjw8En+
 rSj3BR/wUePP3GnUSXdLCF3XRl2xEE5IOGyFtbihlum+
X-Google-Smtp-Source: AGHT+IFai9mD8GltFAw7gxPrREpzrvJjo+UMSvD2ijZjgbzRv5dMrin2AUgKp4k7hnSrJKSzVAnRdw==
X-Received: by 2002:a5d:64e6:0:b0:381:ed32:d604 with SMTP id
 ffacd0b85a97d-38bf5ad3a71mr16765849f8f.10.1737538271919; 
 Wed, 22 Jan 2025 01:31:11 -0800 (PST)
Received: from localhost.localdomain (88-187-86-199.subs.proxad.net.
 [88.187.86.199]) by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-38bf322a414sm15660432f8f.47.2025.01.22.01.31.11
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Wed, 22 Jan 2025 01:31:11 -0800 (PST)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
To: qemu-devel@nongnu.org
Cc: qemu-arm@nongnu.org, Richard Henderson <richard.henderson@linaro.org>,
 =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
Subject: [PATCH v2 09/10] hw/acpi: Prefer cached CpuClass over CPU_GET_CLASS()
 macro
Date: Wed, 22 Jan 2025 10:30:27 +0100
Message-ID: <20250122093028.52416-10-philmd@linaro.org>
X-Mailer: git-send-email 2.47.1
In-Reply-To: <20250122093028.52416-1-philmd@linaro.org>
References: <20250122093028.52416-1-philmd@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::42d;
 envelope-from=philmd@linaro.org; helo=mail-wr1-x42d.google.com
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

CpuState caches its CPUClass since commit 6fbdff87062
("cpu: cache CPUClass in CPUState for hot code paths"),
use it.

Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
Reviewed-by: Richard Henderson <richard.henderson@linaro.org>
---
 hw/acpi/cpu.c         | 4 ++--
 hw/acpi/cpu_hotplug.c | 3 +--
 2 files changed, 3 insertions(+), 4 deletions(-)

diff --git a/hw/acpi/cpu.c b/hw/acpi/cpu.c
index f70a2c045e1..6f1ae79edbf 100644
--- a/hw/acpi/cpu.c
+++ b/hw/acpi/cpu.c
@@ -235,8 +235,8 @@ void cpu_hotplug_hw_init(MemoryRegion *as, Object *owner,
 
 static AcpiCpuStatus *get_cpu_status(CPUHotplugState *cpu_st, DeviceState *dev)
 {
-    CPUClass *k = CPU_GET_CLASS(dev);
-    uint64_t cpu_arch_id = k->get_arch_id(CPU(dev));
+    CPUState *cpu = CPU(dev);
+    uint64_t cpu_arch_id = cpu->cc->get_arch_id(cpu);
     int i;
 
     for (i = 0; i < cpu_st->dev_count; i++) {
diff --git a/hw/acpi/cpu_hotplug.c b/hw/acpi/cpu_hotplug.c
index 83b8bc5deb8..aa0e1e3efa5 100644
--- a/hw/acpi/cpu_hotplug.c
+++ b/hw/acpi/cpu_hotplug.c
@@ -62,10 +62,9 @@ static const MemoryRegionOps AcpiCpuHotplug_ops = {
 static void acpi_set_cpu_present_bit(AcpiCpuHotplug *g, CPUState *cpu,
                                      bool *swtchd_to_modern)
 {
-    CPUClass *k = CPU_GET_CLASS(cpu);
     int64_t cpu_id;
 
-    cpu_id = k->get_arch_id(cpu);
+    cpu_id = cpu->cc->get_arch_id(cpu);
     if ((cpu_id / 8) >= ACPI_GPE_PROC_LEN) {
         object_property_set_bool(g->device, "cpu-hotplug-legacy", false,
                                  &error_abort);
-- 
2.47.1


