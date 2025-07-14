Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 347D7C83F1A
	for <qemu-devel@archiver.kernel.org>; Mon, 14 Jul 2025 11:13:31 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1ubH7b-0000NA-E1; Mon, 14 Jul 2025 07:13:23 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1ubGze-0000sg-Dm
 for qemu-devel@nongnu.org; Mon, 14 Jul 2025 07:05:14 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1ubGzb-0001qc-NA
 for qemu-devel@nongnu.org; Mon, 14 Jul 2025 07:05:10 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1752491107;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=dW2i+oCo9ZpgCYlYnI1btj+lqBMLXuFlBbfwc0ZiH08=;
 b=eQzyexnHnabrTngUu/kV8FGC4BZJKgqysCrutHaqmdyItcraFFhgpGgdD/3ME9feMuxASp
 5KDtBFktfuk7hfV3zdz350jFrW3V1hEtEyqCP3i1Wu50IXXuihoYfWBRwsRCvDuFpMNKwA
 Gq7PSHLiuob+ur414KhjMBb3IHcO+yo=
Received: from mail-wm1-f70.google.com (mail-wm1-f70.google.com
 [209.85.128.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-536-MmCOkSc_Pti22z63JITDBQ-1; Mon, 14 Jul 2025 07:05:05 -0400
X-MC-Unique: MmCOkSc_Pti22z63JITDBQ-1
X-Mimecast-MFC-AGG-ID: MmCOkSc_Pti22z63JITDBQ_1752491105
Received: by mail-wm1-f70.google.com with SMTP id
 5b1f17b1804b1-456106b7c4aso4887315e9.0
 for <qemu-devel@nongnu.org>; Mon, 14 Jul 2025 04:05:05 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1752491103; x=1753095903;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=dW2i+oCo9ZpgCYlYnI1btj+lqBMLXuFlBbfwc0ZiH08=;
 b=xU2FuNVmdJHzk1TLWtmTlfaz1cjTSyIwLT3s/8DOIASn+5Qf8r9t/McRNE7rVjqXFX
 k1njGqFczqHyyr8zCGcuunvyKwRYS6ILeON5s/k/iHdZnnzMcFhXJ32ZFJp0hGUjeYm8
 OHCWel9sm0wvNczoHJVGtRsC8068aFdWnoC9XAbAUekXMhgHGrRDJEf9gZAg9LDu1tfO
 TQ8+s8nqYLUUftEsD3J9SwWZoP/wQnJvRmWoxlmP9Idlf+Ogq+iI8eYsFztn4CkJDck8
 6DArbw+0xq2lTiMZ/iVgLSCGl7of7AaAg99AggZ3DWdUezGugqq6t+AoVgcF4eRX7FU7
 5eCQ==
X-Gm-Message-State: AOJu0Yxi+BEhdFmWOG0j6uhXaW4+qGz+rmYxLC3Y85Wq4amUw68LwIO5
 AkAA/SFjQ2qs0y7rtMmRWg1whQGNoTBZodcBzhLyKYOrk5ZHAry3Gn4uPaZJ9osd0KI/FLcGW29
 4K3AttG2EsTED1aRkYoB32rg3epaRnbiMSJomvq3H5i83CdCneMd/UcuaLxwZhkZVJTarDJ0rE7
 RCVxGHRQrzk9+V+lLyCShk2v8tPz71mKy3h/gXOwGA
X-Gm-Gg: ASbGnctWRBeDOtFuiQJDtCo4RKSCRaInODsEjr2mvnV6VjjPeoUUuOzIe3OMjHesNdo
 bi7z1u+0+FJulu54JCiFGTt40JFBMrUNGmmKo5MG6pSUTghpaLdogPfqk9hC22d74KJrSVs4k0a
 qUIh0AEMTqiF7ZXBC4IEM+phpWkYrV6zMT7EHeHjDiLCasucE2KGxZB6RsZ7VCfPgb2MiVPqk4V
 FmD9NRlTrMIjx4EPbIRX6Hb0+TcqE3D809pg54fKEnkvMwMRMFrFcbYc7CC78WWX4DT6uPJAeG5
 HvOddTRlOSfXz1dFJBQXai87CRtpLmHM4EmRGrRu7w4=
X-Received: by 2002:a05:600c:4746:b0:453:7713:476c with SMTP id
 5b1f17b1804b1-455bd8e63aemr95401805e9.2.1752491102764; 
 Mon, 14 Jul 2025 04:05:02 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IEF63REqR+7VypwkWaTIETl4dxA0iNTNvqaX+oeW7jJvqR3o0LBX2hgxJRtc3C5Jq0MuJbOIA==
X-Received: by 2002:a05:600c:4746:b0:453:7713:476c with SMTP id
 5b1f17b1804b1-455bd8e63aemr95401475e9.2.1752491102236; 
 Mon, 14 Jul 2025 04:05:02 -0700 (PDT)
Received: from [192.168.10.48] ([151.49.73.155])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-3b5e8e26ee3sm12333742f8f.96.2025.07.14.04.05.01
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 14 Jul 2025 04:05:01 -0700 (PDT)
From: Paolo Bonzini <pbonzini@redhat.com>
To: qemu-devel@nongnu.org
Cc: Roy Hopkins <roy.hopkins@randomman.co.uk>,
 Gerd Hoffman <kraxel@redhat.com>, "Michael S. Tsirkin" <mst@redhat.com>,
 Stefano Garzarella <sgarzare@redhat.com>, Ani Sinha <anisinha@redhat.com>
Subject: [PULL 20/77] hw/i386: Add igvm-cfg object and processing for IGVM
 files
Date: Mon, 14 Jul 2025 13:03:09 +0200
Message-ID: <20250714110406.117772-21-pbonzini@redhat.com>
X-Mailer: git-send-email 2.50.0
In-Reply-To: <20250714110406.117772-1-pbonzini@redhat.com>
References: <20250714110406.117772-1-pbonzini@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=170.10.133.124; envelope-from=pbonzini@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H5=0.001, RCVD_IN_MSPIKE_WL=0.001,
 RCVD_IN_VALIDITY_CERTIFIED_BLOCKED=0.001, RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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

From: Roy Hopkins <roy.hopkins@randomman.co.uk>

An IGVM file contains configuration of guest state that should be
applied during configuration of the guest, before the guest is started.

This patch allows the user to add an igvm-cfg object to an X86 machine
configuration that allows an IGVM file to be configured that will be
applied to the guest before it is started.

If an IGVM configuration is provided then the IGVM file is processed at
the end of the board initialization, before the state transition to
PHASE_MACHINE_INITIALIZED.

Signed-off-by: Roy Hopkins <roy.hopkins@randomman.co.uk>
Acked-by: Gerd Hoffman <kraxel@redhat.com>
Reviewed-by: Michael S. Tsirkin <mst@redhat.com>
Reviewed-by: Stefano Garzarella <sgarzare@redhat.com>
Reviewed-by: Ani Sinha <anisinha@redhat.com>
Link: https://lore.kernel.org/r/23bc66ae4504ba5cf2134826e055b25df3fc9cd9.1751554099.git.roy.hopkins@randomman.co.uk
Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>
---
 include/hw/i386/x86.h |  3 +++
 hw/i386/pc.c          | 12 ++++++++++++
 hw/i386/pc_piix.c     | 10 ++++++++++
 hw/i386/pc_q35.c      | 10 ++++++++++
 qemu-options.hx       | 28 ++++++++++++++++++++++++++++
 5 files changed, 63 insertions(+)

diff --git a/include/hw/i386/x86.h b/include/hw/i386/x86.h
index fc460b82f82..8755cad50a3 100644
--- a/include/hw/i386/x86.h
+++ b/include/hw/i386/x86.h
@@ -25,6 +25,7 @@
 #include "hw/intc/ioapic.h"
 #include "hw/isa/isa.h"
 #include "qom/object.h"
+#include "system/igvm-cfg.h"
 
 struct X86MachineClass {
     MachineClass parent;
@@ -92,6 +93,8 @@ struct X86MachineState {
      * which means no limitation on the guest's bus locks.
      */
     uint64_t bus_lock_ratelimit;
+
+    IgvmCfg *igvm;
 };
 
 #define X86_MACHINE_SMM              "smm"
diff --git a/hw/i386/pc.c b/hw/i386/pc.c
index b2116335752..432ab288a87 100644
--- a/hw/i386/pc.c
+++ b/hw/i386/pc.c
@@ -1833,6 +1833,18 @@ static void pc_machine_class_init(ObjectClass *oc, const void *data)
     object_class_property_add_bool(oc, "fd-bootchk",
         pc_machine_get_fd_bootchk,
         pc_machine_set_fd_bootchk);
+
+#if defined(CONFIG_IGVM)
+    object_class_property_add_link(oc, "igvm-cfg",
+                                   TYPE_IGVM_CFG,
+                                   offsetof(X86MachineState, igvm),
+                                   object_property_allow_set_link,
+                                   OBJ_PROP_LINK_STRONG);
+    object_class_property_set_description(oc, "igvm-cfg",
+                                          "Set IGVM configuration");
+#endif
+
+
 }
 
 static const TypeInfo pc_machine_info = {
diff --git a/hw/i386/pc_piix.c b/hw/i386/pc_piix.c
index ea7572e7831..3184ea1b378 100644
--- a/hw/i386/pc_piix.c
+++ b/hw/i386/pc_piix.c
@@ -366,6 +366,16 @@ static void pc_init1(MachineState *machine, const char *pci_type)
                                x86_nvdimm_acpi_dsmio,
                                x86ms->fw_cfg, OBJECT(pcms));
     }
+
+#if defined(CONFIG_IGVM)
+    /* Apply guest state from IGVM if supplied */
+    if (x86ms->igvm) {
+        if (IGVM_CFG_GET_CLASS(x86ms->igvm)
+                ->process(x86ms->igvm, machine->cgs, &error_fatal) < 0) {
+            g_assert_not_reached();
+        }
+    }
+#endif
 }
 
 typedef enum PCSouthBridgeOption {
diff --git a/hw/i386/pc_q35.c b/hw/i386/pc_q35.c
index 33211b1876f..6990e1c6695 100644
--- a/hw/i386/pc_q35.c
+++ b/hw/i386/pc_q35.c
@@ -325,6 +325,16 @@ static void pc_q35_init(MachineState *machine)
                                x86_nvdimm_acpi_dsmio,
                                x86ms->fw_cfg, OBJECT(pcms));
     }
+
+#if defined(CONFIG_IGVM)
+    /* Apply guest state from IGVM if supplied */
+    if (x86ms->igvm) {
+        if (IGVM_CFG_GET_CLASS(x86ms->igvm)
+                ->process(x86ms->igvm, machine->cgs, &error_fatal) < 0) {
+            g_assert_not_reached();
+        }
+    }
+#endif
 }
 
 #define DEFINE_Q35_MACHINE(major, minor) \
diff --git a/qemu-options.hx b/qemu-options.hx
index 1f862b19a67..f4c05b388b5 100644
--- a/qemu-options.hx
+++ b/qemu-options.hx
@@ -5992,6 +5992,34 @@ SRST
                  -machine ...,memory-encryption=sev0 \\
                  .....
 
+    ``-object igvm-cfg,file=file``
+        Create an IGVM configuration object that defines the initial state
+        of the guest using a file in that conforms to the Independent Guest
+        Virtual Machine (IGVM) file format.
+
+        This is currently only supported by ``-machine q35`` and
+        ``-machine pc``.
+
+        The ``file`` parameter is used to specify the IGVM file to load.
+        When provided, the IGVM file is used to populate the initial
+        memory of the virtual machine and, depending on the platform, can
+        define the initial processor state, memory map and parameters.
+
+        The IGVM file is expected to contain the firmware for the virtual
+        machine, therefore an ``igvm-cfg`` object cannot be provided along
+        with other ways of specifying firmware, such as the ``-bios``
+        parameter on x86 machines.
+
+        e.g to launch a machine providing the firmware in an IGVM file
+
+        .. parsed-literal::
+
+             # |qemu_system_x86| \\
+                 ...... \\
+                 -object igvm-cfg,id=igvm0,file=bios.igvm \\
+                 -machine ...,igvm-cfg=igvm0 \\
+                 .....
+
     ``-object authz-simple,id=id,identity=string``
         Create an authorization object that will control access to
         network services.
-- 
2.50.0


