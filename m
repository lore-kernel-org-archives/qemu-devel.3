Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 927D7CCD1BF
	for <qemu-devel@archiver.kernel.org>; Tue, 28 Oct 2025 17:38:22 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vDnbt-0006Ws-Ki; Tue, 28 Oct 2025 13:35:54 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1vDnbW-0006Oo-Og
 for qemu-devel@nongnu.org; Tue, 28 Oct 2025 13:35:33 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1vDnbP-0004hx-Tj
 for qemu-devel@nongnu.org; Tue, 28 Oct 2025 13:35:30 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1761672922;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=eLhLVJ2XarzKVk+Slx8EqzVV2n5CC0vk3GBdbky8+bk=;
 b=YbF7G3QQzntxJwTEiMLAuFM8CuZTdHvLPX9Mr3LVqxmWRuKwLFhWIP9HvbiZ6rpnFjYxQG
 HkcG3NizHBVceX87W8bK7iv8S/Cfj1/fP/BHw4xftAxk0OFtN/nt2LOyknd+H1Qzomam3v
 nKsIzQcuSxPH/SltghMjbiLaiVZ1eOY=
Received: from mail-wm1-f70.google.com (mail-wm1-f70.google.com
 [209.85.128.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-546-bC7CMogrOjei_uKmrT1kSQ-1; Tue, 28 Oct 2025 13:35:20 -0400
X-MC-Unique: bC7CMogrOjei_uKmrT1kSQ-1
X-Mimecast-MFC-AGG-ID: bC7CMogrOjei_uKmrT1kSQ_1761672919
Received: by mail-wm1-f70.google.com with SMTP id
 5b1f17b1804b1-475c422fd70so50648885e9.2
 for <qemu-devel@nongnu.org>; Tue, 28 Oct 2025 10:35:20 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1761672919; x=1762277719;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=eLhLVJ2XarzKVk+Slx8EqzVV2n5CC0vk3GBdbky8+bk=;
 b=he+/+zpwFlKe+YIbKTltQCSJlzQyxRW/CuZUYgLNnHEM90Ty2SWPtueuqtPiRbSJRx
 Xb0IRepVp/oyImGllFdRf9VGB+vyQbiL2640XrQhCwMzHfWrcovQquWneA6s0ygMR9Pa
 GJDzp26cmWRvLjyE7FmrTtvh6QYfQDVrpNWz1wYFdDGd0pEFySlny+NZsnH3b4T4WOCD
 S/z+o/9+rYULFfUmu1H8H5ACdMs5SulS9tbzJ+MYHBLM2pntokwXBInoPTIeqsOdQZ5C
 0w8BQyWie7t5/K3dpZfQzlMiwK9VjhXMrchJhNxZ/1VUMqM5ldPwLRUexP3DVrBX2ru/
 o0IQ==
X-Gm-Message-State: AOJu0YyjmKphXWCEy8ExJyD2FHAhJIlN+WQhLr4sDLzCzzphB2U1xXOQ
 Gb30OZXHNq3ryikJ0pya7IM9RclsbP14idBECxoImxI13kDFRWgFlrlcohuHtHMz7I/XxgxEQUL
 Uc9rsO272QFG559qDD7SfapwWITb9vwhAgEllvTZJ50pwC4F9DWqtKEQxbdOs+SagCRDiWpeqXx
 WjP46hrJ0TtK6PgzkV+h82kkol312eABrI44xV/LA0
X-Gm-Gg: ASbGnctAwKY7uujId+CVV8IZ7lYul6cBGv86gvyioQ2RZWqY7ZS4Ej1YVVSA2cKrXQM
 k/+XwcJ0VqEXYk4c/i4pmKuZa4cAQks77hiPYWaRnE21nJkCn770TFPtSAoPORuX830m0Bfan1q
 H02h7sRqg0n4XSKOCGx1FI/qITm16Y6wOF8IIEby0yOPJ+NRvWWvAwn7m0PP2lY0OY2uI+L9f5s
 /3ojF+BYTYOunfsexBGN4rjDFOEWAexIs71blMgNBSe6sLpDmnJ+W7E1msgVljgOsIOxxCV69iC
 dhIBE5Nij4GgXFZmBPK+BLyEgs/iESwq/Z0RZ4csJ0rOtkF5jxF1jjjd2mut6YwBUiejhiATEut
 lLREIhP5NGloD9bWCswty7DScDsiNhINf1wOUYOncw6kLceEp2CnAh5RW8bRfgDmBjxb7lqLugf
 vwN94=
X-Received: by 2002:a05:6000:1786:b0:426:fb28:7962 with SMTP id
 ffacd0b85a97d-429a7e86fdfmr4110812f8f.61.1761672918516; 
 Tue, 28 Oct 2025 10:35:18 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IGYISxoFXRWT4CSQFkij0/JYLnvkQ9ZHEUxIVRSWMIjdtVxfJZ2pB4Kvct1JEbXqJvyYeHsRg==
X-Received: by 2002:a05:6000:1786:b0:426:fb28:7962 with SMTP id
 ffacd0b85a97d-429a7e86fdfmr4110553f8f.61.1761672916739; 
 Tue, 28 Oct 2025 10:35:16 -0700 (PDT)
Received: from [192.168.10.48] ([151.95.110.222])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-429952df473sm21505827f8f.42.2025.10.28.10.35.13
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 28 Oct 2025 10:35:14 -0700 (PDT)
From: Paolo Bonzini <pbonzini@redhat.com>
To: qemu-devel@nongnu.org
Cc: Mark Cave-Ayland <mark.caveayland@nutanix.com>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
Subject: [PULL 15/18] hw/i386/isapc.c: warn rather than reject modern x86 CPU
 models
Date: Tue, 28 Oct 2025 18:34:27 +0100
Message-ID: <20251028173430.2180057-16-pbonzini@redhat.com>
X-Mailer: git-send-email 2.51.1
In-Reply-To: <20251028173430.2180057-1-pbonzini@redhat.com>
References: <20251028173430.2180057-1-pbonzini@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=170.10.133.124; envelope-from=pbonzini@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H3=0.001, RCVD_IN_MSPIKE_WL=0.001,
 RCVD_IN_VALIDITY_CERTIFIED_BLOCKED=0.001, RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001,
 SPF_HELO_PASS=-0.001, SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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

From: Mark Cave-Ayland <mark.caveayland@nutanix.com>

Commit e1e2909f8e ("hw/i386/pc_piix.c: restrict isapc machine to 32-bit CPUs")
restricted the isapc machine to 32-bit CPUs, but subsequent concern has been
expressed as to the effect this could have on users.

The outcome of the latest discussion is that we should exercise more caution
and follow the official deprecation route, so instead of rejecting modern x86
CPUs issue a deprecation warning but allow the user to continue.

Signed-off-by: Mark Cave-Ayland <mark.caveayland@nutanix.com>
Reviewed-by: Philippe Mathieu-Daudé <philmd@linaro.org>
Link: https://lore.kernel.org/r/20251023142926.964718-2-mark.caveayland@nutanix.com
Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>
---
 hw/i386/isapc.c | 55 ++++++++++++++++++++-----------------------------
 1 file changed, 22 insertions(+), 33 deletions(-)

diff --git a/hw/i386/isapc.c b/hw/i386/isapc.c
index 44f4a446724..1ba9ae22cc3 100644
--- a/hw/i386/isapc.c
+++ b/hw/i386/isapc.c
@@ -41,29 +41,31 @@ static void pc_init_isa(MachineState *machine)
     DriveInfo *hd[MAX_IDE_BUS * MAX_IDE_DEVS];
     int i;
 
-    /*
-     * There is a small chance that someone unintentionally passes "-cpu max"
-     * for the isapc machine, which will provide a much more modern 32-bit
-     * CPU than would be expected for an ISA-era PC. If the "max" cpu type has
-     * been specified, choose the "best" 32-bit cpu possible which we consider
-     * be the pentium3 (deliberately choosing an Intel CPU given that the
-     * default 486 CPU for the isapc machine is also an Intel CPU).
-     */
-    if (!strcmp(machine->cpu_type, X86_CPU_TYPE_NAME("max"))) {
-        machine->cpu_type = X86_CPU_TYPE_NAME("pentium3");
-        warn_report("-cpu max is invalid for isapc machine, using pentium3");
-    }
+    bool valid_cpu_type = false;
+    static const char * const valid_cpu_types[] = {
+        X86_CPU_TYPE_NAME("486"),
+        X86_CPU_TYPE_NAME("athlon"),
+        X86_CPU_TYPE_NAME("kvm32"),
+        X86_CPU_TYPE_NAME("pentium"),
+        X86_CPU_TYPE_NAME("pentium2"),
+        X86_CPU_TYPE_NAME("pentium3"),
+        X86_CPU_TYPE_NAME("qemu32"),
+    };
 
     /*
-     * Similarly if someone unintentionally passes "-cpu host" for the isapc
-     * machine then display a warning and also switch to the "best" 32-bit
-     * cpu possible which we consider to be the pentium3. This is because any
-     * host CPU will already be modern than this, but it also ensures any
-     * newer CPU flags/features are filtered out for older guests.
+     * The isapc machine is supposed to represent a legacy ISA-only PC with a
+     * 32-bit processor. For historical reasons the machine can still accept
+     * almost any valid processor, but this is now deprecated in 10.2. Emit
+     * a warning if anyone tries to use a deprecated CPU.
      */
-    if (!strcmp(machine->cpu_type, X86_CPU_TYPE_NAME("host"))) {
-        machine->cpu_type = X86_CPU_TYPE_NAME("pentium3");
-        warn_report("-cpu host is invalid for isapc machine, using pentium3");
+    for (i = 0; i < ARRAY_SIZE(valid_cpu_types); i++) {
+        if (!strcmp(machine->cpu_type, valid_cpu_types[i])) {
+            valid_cpu_type = true;
+        }
+    }
+
+    if (!valid_cpu_type) {
+        warn_report("cpu type %s is deprecated for isapc machine", machine->cpu_type);
     }
 
     if (machine->ram_size > 3.5 * GiB) {
@@ -154,18 +156,6 @@ static void pc_init_isa(MachineState *machine)
 
 static void isapc_machine_options(MachineClass *m)
 {
-    static const char * const valid_cpu_types[] = {
-        X86_CPU_TYPE_NAME("486"),
-        X86_CPU_TYPE_NAME("athlon"),
-        X86_CPU_TYPE_NAME("kvm32"),
-        X86_CPU_TYPE_NAME("pentium"),
-        X86_CPU_TYPE_NAME("pentium2"),
-        X86_CPU_TYPE_NAME("pentium3"),
-        X86_CPU_TYPE_NAME("qemu32"),
-        X86_CPU_TYPE_NAME("max"),
-        X86_CPU_TYPE_NAME("host"),
-        NULL
-    };
     PCMachineClass *pcmc = PC_MACHINE_CLASS(m);
 
     m->desc = "ISA-only PC";
@@ -180,7 +170,6 @@ static void isapc_machine_options(MachineClass *m)
     pcmc->has_reserved_memory = false;
     m->default_nic = "ne2k_isa";
     m->default_cpu_type = X86_CPU_TYPE_NAME("486");
-    m->valid_cpu_types = valid_cpu_types;
     m->no_floppy = !module_object_class_by_name(TYPE_ISA_FDC);
     m->no_parallel = !module_object_class_by_name(TYPE_ISA_PARALLEL);
 }
-- 
2.51.1


