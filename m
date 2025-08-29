Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B37BDCA0EFF
	for <qemu-devel@archiver.kernel.org>; Sat, 30 Aug 2025 15:18:07 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1usNGz-00081s-Ho; Sat, 30 Aug 2025 11:13:45 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1uryho-0000tU-CM
 for qemu-devel@nongnu.org; Fri, 29 Aug 2025 08:59:49 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1uryhl-00082W-Qa
 for qemu-devel@nongnu.org; Fri, 29 Aug 2025 08:59:47 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1756472384;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=gLBHU6qEdcCWpckmzfsIkdtzaetPZfpQiElf8W7G/SE=;
 b=XeJK0B11dtAKcI2zvMAsGbLBCn251bDHMQ6oDX5cLXi/gd4B72Bci6Xkhmxj/dMGU5Jz+R
 FDovT3zmVbzV9DNL3MCHmoNzUdcYdMDtnq51Gt3sLw9K2X+wT77dEDErAah9YNI6z2XeAK
 wh3RsqqBHsrfaN5yBwll6j0TItvQSvM=
Received: from mail-wm1-f69.google.com (mail-wm1-f69.google.com
 [209.85.128.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-75-gkR72UL5POG-PFFC4dHzug-1; Fri, 29 Aug 2025 08:59:42 -0400
X-MC-Unique: gkR72UL5POG-PFFC4dHzug-1
X-Mimecast-MFC-AGG-ID: gkR72UL5POG-PFFC4dHzug_1756472381
Received: by mail-wm1-f69.google.com with SMTP id
 5b1f17b1804b1-45b7d485153so11508215e9.0
 for <qemu-devel@nongnu.org>; Fri, 29 Aug 2025 05:59:41 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1756472380; x=1757077180;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=gLBHU6qEdcCWpckmzfsIkdtzaetPZfpQiElf8W7G/SE=;
 b=h5+PScNejCgMrfa2gh3n1gRiYHz+FkEBX57aU0s2Od+kXe+sGifvf5+TXRUhcEYim6
 qpvR+LdL3jzX6zZMAhjQOkkBS4sTxO95g3rlGjkTEfkH69G/ZvE18wFwb7OfYR79Jjf1
 FCsPtifEz/Sk2eBJJUtK3fxNcVxv/uDmCUr5NGA3ZXi82yyFUY3x4JFnQrJtkcLYBilS
 vg3N5gxFrf9KDmOK6azLppKnuHwOcIDkS1Hb+Qdl3U1oDmiRf/HqNHmsKhYT2TEpTW4e
 PmQFQmsceufrcyMnDepoo9JH3uGmCKzA6ysQE3SvXRoWCRMeG59rdIkDdHTm7aSaNmpg
 G+Pw==
X-Gm-Message-State: AOJu0Yw6MZKgi345FGCXInZVlsFxv63l3T/d9qPXZe2eNtxh5VScvaf9
 3Hv5hRB6TsvI6pBFGV769BghMW0KCQCyQXRnTaobNrOcZs4bD57x8TZ3/b9sEHoHJhCQWRogV1e
 TvWqeRDHJfnYxVe7DgDdkCFre57ECLLCWaNqLUUAYUW/YG1C03zk0YydqMhcamkkvOQuZ1OveGq
 19IaEYzjdK3BcKoLUN2lKIbfvBEgcOpbi7yRGeGb8j
X-Gm-Gg: ASbGncug/4bYhqAnEnZabsfH6o/OFd4q+UOa+h8TEYv1CNiyFbphUZImhmPvKbftr0C
 XxNxORcIN4zaqDSLcRb0fZdMRkS6QEkfLKnnvp2I8iQfrzFE4/QW0pvDzhqbold5jMmjSiF0lHg
 xqk5u6mu+M8QnOykMl6xprOBnH9orkd4sbMzdQwbgdmXunLQzn6H/TMgqFBS8E9lv/bvRqEbu7R
 oNqaXqywyoqo+1rRDfkbdOCynUV9Zjh9Wjdh8q1GtbvIKNBqtOt6tLONa7FXXcd+Y6OZ2RDCgjl
 9Jn9oQJQzl5NodvLLQg0ylLMfNc8xhvISFH0xhj9SbOe1X/aYjVyD2goDPactYI6sBPawQoZ4eT
 7aJmZPWCg/gJC0yWgTK+IECpkRQwfJ22ysoW7x43sDFM=
X-Received: by 2002:a05:600c:4e87:b0:459:e094:92c2 with SMTP id
 5b1f17b1804b1-45b517dd290mr220156795e9.27.1756472379902; 
 Fri, 29 Aug 2025 05:59:39 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IGZ3BJkar1NmnX9u4VmzDEfyEjes5XeY+FXh2noUbd6eOe+vrTK2Kzl6rh7bVxs9emHXSZtwQ==
X-Received: by 2002:a05:600c:4e87:b0:459:e094:92c2 with SMTP id
 5b1f17b1804b1-45b517dd290mr220156575e9.27.1756472379387; 
 Fri, 29 Aug 2025 05:59:39 -0700 (PDT)
Received: from [192.168.10.48] ([151.95.56.250])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-3cf34491a7fsm3227408f8f.57.2025.08.29.05.59.37
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 29 Aug 2025 05:59:38 -0700 (PDT)
From: Paolo Bonzini <pbonzini@redhat.com>
To: qemu-devel@nongnu.org
Cc: Mark Cave-Ayland <mark.caveayland@nutanix.com>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
Subject: [PULL 01/28] hw/i386/pc_piix.c: restrict isapc machine to 32-bit CPUs
Date: Fri, 29 Aug 2025 14:59:08 +0200
Message-ID: <20250829125935.1526984-2-pbonzini@redhat.com>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <20250829125935.1526984-1-pbonzini@redhat.com>
References: <20250829125935.1526984-1-pbonzini@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=170.10.129.124; envelope-from=pbonzini@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H5=0.001, RCVD_IN_MSPIKE_WL=0.001,
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

The isapc machine represents a legacy ISA PC with a 486 CPU. Whilst it is
possible to specify any CPU via -cpu on the command line, it makes no
sense to allow modern 64-bit CPUs to be used.

Restrict the isapc machine to the available 32-bit CPUs, taking care to
handle the case where if a user inadvertently uses either -cpu max or
-cpu host then the "best" 32-bit CPU is used (in this case the pentium3).

Signed-off-by: Mark Cave-Ayland <mark.caveayland@nutanix.com>
Reviewed-by: Philippe Mathieu-Daudé <philmd@linaro.org>
Link: https://lore.kernel.org/r/20250828111057.468712-2-mark.caveayland@nutanix.com
Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>
---
 hw/i386/pc_piix.c | 39 +++++++++++++++++++++++++++++++++++++++
 1 file changed, 39 insertions(+)

diff --git a/hw/i386/pc_piix.c b/hw/i386/pc_piix.c
index d165ac72ed7..8f5fb3cf90b 100644
--- a/hw/i386/pc_piix.c
+++ b/hw/i386/pc_piix.c
@@ -436,6 +436,31 @@ static void pc_set_south_bridge(Object *obj, int value, Error **errp)
 #ifdef CONFIG_ISAPC
 static void pc_init_isa(MachineState *machine)
 {
+    /*
+     * There is a small chance that someone unintentionally passes "-cpu max"
+     * for the isapc machine, which will provide a much more modern 32-bit
+     * CPU than would be expected for an ISA-era PC. If the "max" cpu type has
+     * been specified, choose the "best" 32-bit cpu possible which we consider
+     * be the pentium3 (deliberately choosing an Intel CPU given that the
+     * default 486 CPU for the isapc machine is also an Intel CPU).
+     */
+    if (!strcmp(machine->cpu_type, X86_CPU_TYPE_NAME("max"))) {
+        machine->cpu_type = X86_CPU_TYPE_NAME("pentium3");
+        warn_report("-cpu max is invalid for isapc machine, using pentium3");
+    }
+
+    /*
+     * Similarly if someone unintentionally passes "-cpu host" for the isapc
+     * machine then display a warning and also switch to the "best" 32-bit
+     * cpu possible which we consider to be the pentium3. This is because any
+     * host CPU will already be modern than this, but it also ensures any
+     * newer CPU flags/features are filtered out for older guests.
+     */
+    if (!strcmp(machine->cpu_type, X86_CPU_TYPE_NAME("host"))) {
+        machine->cpu_type = X86_CPU_TYPE_NAME("pentium3");
+        warn_report("-cpu host is invalid for isapc machine, using pentium3");
+    }
+
     pc_init1(machine, NULL);
 }
 #endif
@@ -815,7 +840,20 @@ DEFINE_I440FX_MACHINE(2, 6);
 #ifdef CONFIG_ISAPC
 static void isapc_machine_options(MachineClass *m)
 {
+    static const char * const valid_cpu_types[] = {
+        X86_CPU_TYPE_NAME("486"),
+        X86_CPU_TYPE_NAME("athlon"),
+        X86_CPU_TYPE_NAME("kvm32"),
+        X86_CPU_TYPE_NAME("pentium"),
+        X86_CPU_TYPE_NAME("pentium2"),
+        X86_CPU_TYPE_NAME("pentium3"),
+        X86_CPU_TYPE_NAME("qemu32"),
+        X86_CPU_TYPE_NAME("max"),
+        X86_CPU_TYPE_NAME("host"),
+        NULL
+    };
     PCMachineClass *pcmc = PC_MACHINE_CLASS(m);
+
     m->desc = "ISA-only PC";
     m->max_cpus = 1;
     m->option_rom_has_mr = true;
@@ -828,6 +866,7 @@ static void isapc_machine_options(MachineClass *m)
     pcmc->has_reserved_memory = false;
     m->default_nic = "ne2k_isa";
     m->default_cpu_type = X86_CPU_TYPE_NAME("486");
+    m->valid_cpu_types = valid_cpu_types;
     m->no_floppy = !module_object_class_by_name(TYPE_ISA_FDC);
     m->no_parallel = !module_object_class_by_name(TYPE_ISA_PARALLEL);
 }
-- 
2.51.0


