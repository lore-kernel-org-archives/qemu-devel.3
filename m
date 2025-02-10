Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id F1DAAC0219D
	for <qemu-devel@archiver.kernel.org>; Mon, 10 Feb 2025 20:48:53 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1thadO-00014U-D4; Mon, 10 Feb 2025 15:44:02 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1thadF-0000Op-JC
 for qemu-devel@nongnu.org; Mon, 10 Feb 2025 15:43:56 -0500
Received: from mail-wm1-x32e.google.com ([2a00:1450:4864:20::32e])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1thadD-0003lb-SD
 for qemu-devel@nongnu.org; Mon, 10 Feb 2025 15:43:53 -0500
Received: by mail-wm1-x32e.google.com with SMTP id
 5b1f17b1804b1-43948f77f1aso7037445e9.0
 for <qemu-devel@nongnu.org>; Mon, 10 Feb 2025 12:43:51 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1739220230; x=1739825030; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=zXvQGNnfpvT1VTqpauRS8evm2rYYkEf6B70nswq9ErA=;
 b=Nta/IgQH+ZisLmFChmCsvjZZBvrpEiN+9miuCyFm+rVzcetz9xedJr14/c19/GAEEc
 jUJE6wt7YhCTagND7AmbTay9+09kI15eqnwvXvc746tUBf5JCxHDQTscQphttiuQNU78
 lqnvBRJ/LL4SRmt9ChZbAjkrB9h/a/NLp0hR7CKbHTCyNtZiEtvD3CwD4AInMX5GpcL8
 oJjrMeOouthcdYd6LANGlsS5krbkccxc/1lHvxw1ogSjJ+YXiKXgWMP80VPIF5nLWdSC
 N1SrG2EI/B9iBHo34fEe/qZEGeH85CZbbfbvXKjSJrOstTP+Lvqg6WcE98pXAwQIPZqO
 Lxog==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1739220230; x=1739825030;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=zXvQGNnfpvT1VTqpauRS8evm2rYYkEf6B70nswq9ErA=;
 b=c+DAkpY3pjMjferZgXf0rr4h7WkGokDN0w7+y1R799Ndo4tVD34HH5OPnu2Q1CAu8W
 deWKBZojc/aqIdlm5o/yLro1N3JQL5a1k/rVCfxF881NAm4fnnBhicfkkfsIGjVictZO
 2GC6AhmnNNUyzvUEQDr5qvSTzYxj1KYKoo3xpX+ONr/HhO18MkOFe9KJsm+BIA0cJvEw
 KKcujpoMMiKd56x+jPNpXAYfgEWuM4qfdJV+NSyIwk8GEIxrNEAHRnnnSuhrRQUBHgUW
 fZL7PU/t3FCYJBlnyDoAAzZQZXTybeK5Q5x1okoUESKJ/1ZgfbbBhRs76Sp3BBDiTYTY
 MxJg==
X-Gm-Message-State: AOJu0Yyzcc4/ZhomKoeqeeqLlISOxE1pQ/ZMhoJurgMYwNNpNqCbBrlO
 fUyR0H8XegnEdFNXdvxgtG4p+ZCGoBoHTlp7bW2gEBTEGzsZdv5aSxPiOGDjw99j+FUdl6NwU/l
 UX5o=
X-Gm-Gg: ASbGncspVSek0iTGqy2/i9YlbBEyDhSJhmeThL7As6lOAx0FRYodY2MjZjHh4AlGpaH
 k7DpkiTI/3Xiv25GOwMy3qw+Uahhnvv+SGjXWxRyGAiQbBgczmsmP+00PbHgAFH0HM5XHdX+vC4
 EyXb84HU3kJ916eSZxUO9GXvDVW0oFVFnCBEEw+0oIBcwHNM1TzPom82uGlrMtU564huOemJ2MT
 d/TjbQhBQTQLosKpvoEF3tXjy1kRCb0T+KP9RUNQY5Mg6uKBtNtYC9G0Bo0LEdoW7llAjzb14XS
 1DeOqxeCPLE9CmQGWTD9RRh4vcdYyXBn51+zBE6Ip+P5k94gezIC3gi6FH6xLYS8dQ==
X-Google-Smtp-Source: AGHT+IGxZ0VyTFz2OLb855O009Q8ElmdYG6IKwQq+Ff2cTq7t17PHa+GAHmlYJO2U/4hMHc0xdMdbw==
X-Received: by 2002:a05:6000:1448:b0:385:ee40:2d88 with SMTP id
 ffacd0b85a97d-38dc90e39c5mr11772777f8f.3.1739220229954; 
 Mon, 10 Feb 2025 12:43:49 -0800 (PST)
Received: from localhost.localdomain (88-187-86-199.subs.proxad.net.
 [88.187.86.199]) by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-38dd3dcca71sm7795971f8f.76.2025.02.10.12.43.49
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Mon, 10 Feb 2025 12:43:49 -0800 (PST)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
To: qemu-devel@nongnu.org
Cc: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Thomas Huth <thuth@redhat.com>
Subject: [PULL 20/32] hw/boards: Convert no_sdcard flag to OnOffAuto tri-state
Date: Mon, 10 Feb 2025 21:41:52 +0100
Message-ID: <20250210204204.54407-21-philmd@linaro.org>
X-Mailer: git-send-email 2.47.1
In-Reply-To: <20250210204204.54407-1-philmd@linaro.org>
References: <20250210204204.54407-1-philmd@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::32e;
 envelope-from=philmd@linaro.org; helo=mail-wm1-x32e.google.com
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

MachineClass::no_sdcard is initialized as false by default.
To catch all uses, convert it to a tri-state, having the
current default (false) becoming AUTO.

No logical change intended.

Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
Reviewed-by: Thomas Huth <thuth@redhat.com>
Message-Id: <20250204200934.65279-2-philmd@linaro.org>
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
index ff91af8eca6..a845f692af1 100644
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


