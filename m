Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A1B34C04FF6
	for <qemu-devel@archiver.kernel.org>; Tue, 16 Apr 2024 19:03:48 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rwo4I-0003uI-Sw; Tue, 16 Apr 2024 15:02:11 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1rwo3o-0002Rl-2B
 for qemu-devel@nongnu.org; Tue, 16 Apr 2024 15:01:46 -0400
Received: from mail-lf1-x12f.google.com ([2a00:1450:4864:20::12f])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1rwo3l-0005qI-7s
 for qemu-devel@nongnu.org; Tue, 16 Apr 2024 15:01:39 -0400
Received: by mail-lf1-x12f.google.com with SMTP id
 2adb3069b0e04-518a3e0d2ecso5866108e87.3
 for <qemu-devel@nongnu.org>; Tue, 16 Apr 2024 12:01:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1713294095; x=1713898895; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=zBppzEDS51MDAVFf+oWkcwnoJzt4m+loPuqdwyia2Jo=;
 b=ZmTXwUHmj3q8U46KRPzzCOlT5o+Qs5NxLPpWYpiWtZAed6DmykGp3FvwOplHl7+4PG
 iRaUdN6ls0+7n+L9fChk+25qfm4YmyEABSx4Cwa35Syy/qJUk073kM1S69PW4MrguJ+t
 h85agyaasw/xS+wCi9dBEPhqJdNWec9Rqpz9aSs8NVxi60U1FHkY12lruJxY5J6btLua
 L4syHbqkKePjZddhocx7bBpUFin/8UNzHrfVTwRw7wZ4Eqi67iOKDCP7lurDIZaL8b7J
 tSmbzNMViV9lY44CbzkT2TXYbpHouHNTLw8+oXDZ+W0RNJx6Lv6ppXPOl7xMJd6aKpGa
 XXYw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1713294095; x=1713898895;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=zBppzEDS51MDAVFf+oWkcwnoJzt4m+loPuqdwyia2Jo=;
 b=m4bMLnl6QHMhCVuspxXEGxLR+OcPQj+r92W8FqX5tH7FHl33CKdFNkrxWi/nn/meVt
 QYU+HeKgGxfzjDqZz16OKDJIggF7b0lKoQTZOiLIMF2tiMMAlbxmWkakeFWe1rsMC39h
 m6SWY94PYVFBYLXQbZXU55NjqC22qc2Hzf1Scl7xovcVGFFVTdV762Xb+pTYeFlIlkp4
 Lzy4PlB2iFwtjmUTMsYmmuFrwppfl0XbB209+nBc9kGQkKt8hh+dLqhSiCbOFhALn31Q
 kWtD2SrohrUqt7rxSsCZUo3u4r26C+o4sDUQgEY4aKS5/8ISLPfIInktLBh1gp0kG1JL
 GGPw==
X-Gm-Message-State: AOJu0YxKlYyaqUc+cd1uywCkx7JAVHRDhu3p1vuKqeamJDC5gIMtq2Y3
 BwKHi9vEfJW3nFhIMlmdLhkCnlwTf6KthkLY3DyY+Ump1FdFS6mZffaILyoOA0LqgkUQ/jHDEhH
 N
X-Google-Smtp-Source: AGHT+IEFR6OBlGzd1sBQXRUUWBXXmlB65DVpuvZEoyWE4Twkpri2X1zpfnKaaW9v57/rJ2UooyCk1g==
X-Received: by 2002:a05:6512:3091:b0:518:dd52:600a with SMTP id
 z17-20020a056512309100b00518dd52600amr7046791lfd.68.1713294095267; 
 Tue, 16 Apr 2024 12:01:35 -0700 (PDT)
Received: from m1x-phil.lan ([176.176.155.61])
 by smtp.gmail.com with ESMTPSA id
 en15-20020a17090728cf00b00a522fb5587esm6391223ejc.144.2024.04.16.12.01.33
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Tue, 16 Apr 2024 12:01:34 -0700 (PDT)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
To: qemu-devel@nongnu.org,
	Thomas Huth <thuth@redhat.com>
Cc: "Michael S. Tsirkin" <mst@redhat.com>, qemu-riscv@nongnu.org,
 David Hildenbrand <david@redhat.com>, Igor Mammedov <imammedo@redhat.com>,
 kvm@vger.kernel.org, qemu-ppc@nongnu.org, qemu-arm@nongnu.org,
 Paolo Bonzini <pbonzini@redhat.com>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Zhao Liu <zhao1.liu@intel.com>, Ani Sinha <anisinha@redhat.com>,
 Marcel Apfelbaum <marcel.apfelbaum@gmail.com>,
 Richard Henderson <richard.henderson@linaro.org>,
 Eduardo Habkost <eduardo@habkost.net>
Subject: [PATCH v4 17/22] hw/i386/pc: Remove
 PCMachineClass::resizable_acpi_blob
Date: Tue, 16 Apr 2024 20:59:33 +0200
Message-ID: <20240416185939.37984-18-philmd@linaro.org>
X-Mailer: git-send-email 2.41.0
In-Reply-To: <20240416185939.37984-1-philmd@linaro.org>
References: <20240416185939.37984-1-philmd@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::12f;
 envelope-from=philmd@linaro.org; helo=mail-lf1-x12f.google.com
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

PCMachineClass::resizable_acpi_blob was only used by the
pc-i440fx-2.2 machine, which got removed. It is now always
true. Remove it, simplifying acpi_build().

Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
Reviewed-by: Zhao Liu <zhao1.liu@intel.com>
---
 include/hw/i386/pc.h |  3 ---
 hw/i386/acpi-build.c | 10 ----------
 hw/i386/pc.c         |  1 -
 3 files changed, 14 deletions(-)

diff --git a/include/hw/i386/pc.h b/include/hw/i386/pc.h
index df97df6ca7..10a8ffa0de 100644
--- a/include/hw/i386/pc.h
+++ b/include/hw/i386/pc.h
@@ -124,9 +124,6 @@ struct PCMachineClass {
     /* create kvmclock device even when KVM PV features are not exposed */
     bool kvmclock_create_always;
 
-    /* resizable acpi blob compat */
-    bool resizable_acpi_blob;
-
     /*
      * whether the machine type implements broken 32-bit address space bound
      * check for memory.
diff --git a/hw/i386/acpi-build.c b/hw/i386/acpi-build.c
index a6f8203460..ab2d4d8dcb 100644
--- a/hw/i386/acpi-build.c
+++ b/hw/i386/acpi-build.c
@@ -2688,16 +2688,6 @@ void acpi_build(AcpiBuildTables *tables, MachineState *machine)
      * keep the table size stable for all (max_cpus, max_memory_slots)
      * combinations.
      */
-    /* Make sure we have a buffer in case we need to resize the tables. */
-    if ((tables_blob->len > ACPI_BUILD_TABLE_SIZE / 2) &&
-        !pcmc->resizable_acpi_blob) {
-        /* As of QEMU 2.1, this fires with 160 VCPUs and 255 memory slots.  */
-        warn_report("ACPI table size %u exceeds %d bytes,"
-                    " migration may not work",
-                    tables_blob->len, ACPI_BUILD_TABLE_SIZE / 2);
-        error_printf("Try removing CPUs, NUMA nodes, memory slots"
-                     " or PCI bridges.\n");
-    }
     acpi_align_size(tables_blob, ACPI_BUILD_TABLE_SIZE);
 
     acpi_align_size(tables->linker->cmd_blob, ACPI_BUILD_ALIGN_SIZE);
diff --git a/hw/i386/pc.c b/hw/i386/pc.c
index 18bef7c85e..c4a7885a3b 100644
--- a/hw/i386/pc.c
+++ b/hw/i386/pc.c
@@ -1755,7 +1755,6 @@ static void pc_machine_class_init(ObjectClass *oc, void *data)
     pcmc->acpi_data_size = 0x20000 + 0x8000;
     pcmc->pvh_enabled = true;
     pcmc->kvmclock_create_always = true;
-    pcmc->resizable_acpi_blob = true;
     x86mc->apic_xrupt_override = true;
     assert(!mc->get_hotplug_handler);
     mc->get_hotplug_handler = pc_get_hotplug_handler;
-- 
2.41.0


