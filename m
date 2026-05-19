Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id ACFC8CD4F5B
	for <qemu-devel@archiver.kernel.org>; Tue, 19 May 2026 08:56:45 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wPGFI-0003gu-Bw; Tue, 19 May 2026 04:56:13 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <kraxel@redhat.com>) id 1wPGFB-0003fz-Sy
 for qemu-devel@nongnu.org; Tue, 19 May 2026 04:56:07 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <kraxel@redhat.com>) id 1wPGF9-0001VV-RK
 for qemu-devel@nongnu.org; Tue, 19 May 2026 04:56:05 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1779180961;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=gmWH8TlLipTDm1QeUP9GkUq3EE0SkXJJj62EqvoQh4A=;
 b=cVVnO6oyO7btFL05DqEoDP3nO52lO6izD6wqxS42AMl8h+a5VBMDGW0W7DA0lLaPfsSL7V
 o9yxI92yuTO/D8fKfRnHsSQ46+xZihhGM5HVJMN6yb5e5WjmH8blJFbpVTricZc6oFesgY
 RHxwrYJxL5hgD7WSg5WvctzU/pplVRs=
Received: from mx-prod-mc-06.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-35-165-154-97.us-west-2.compute.amazonaws.com [35.165.154.97]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-589-As-qNEIeMzq0VPnLNlnp4Q-1; Tue,
 19 May 2026 04:55:59 -0400
X-MC-Unique: As-qNEIeMzq0VPnLNlnp4Q-1
X-Mimecast-MFC-AGG-ID: As-qNEIeMzq0VPnLNlnp4Q_1779180959
Received: from mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.93])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-06.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id E9F7A1800616; Tue, 19 May 2026 08:55:58 +0000 (UTC)
Received: from sirius.home.kraxel.org (unknown [10.44.48.13])
 by mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP
 id AE0C91800673; Tue, 19 May 2026 08:55:57 +0000 (UTC)
Received: by sirius.home.kraxel.org (Postfix, from userid 1000)
 id F25401800840; Tue, 19 May 2026 10:55:54 +0200 (CEST)
From: Gerd Hoffmann <kraxel@redhat.com>
To: qemu-devel@nongnu.org
Cc: Sergio Lopez <slp@redhat.com>, Gerd Hoffmann <kraxel@redhat.com>,
 "Michael S. Tsirkin" <mst@redhat.com>,
 Richard Henderson <richard.henderson@linaro.org>,
 Paolo Bonzini <pbonzini@redhat.com>, Luigi Leonardi <leonardi@redhat.com>
Subject: [PULL 2/2] hw/i386/microvm: Add IGVM support
Date: Tue, 19 May 2026 10:55:54 +0200
Message-ID: <20260519085554.944458-3-kraxel@redhat.com>
In-Reply-To: <20260519085554.944458-1-kraxel@redhat.com>
References: <20260519085554.944458-1-kraxel@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.93
Received-SPF: pass client-ip=170.10.129.124; envelope-from=kraxel@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -24
X-Spam_score: -2.5
X-Spam_bar: --
X-Spam_report: (-2.5 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.445,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H4=0.001, RCVD_IN_MSPIKE_WL=0.001,
 SPF_HELO_PASS=-0.001, SPF_PASS=-0.001 autolearn=ham autolearn_force=no
X-Spam_action: no action
X-BeenThere: qemu-devel@nongnu.org
X-Mailman-Version: 2.1.29
Precedence: list
List-Id: qemu development <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <https://lists.nongnu.org/archive/html/qemu-devel>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=subscribe>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org

From: Luigi Leonardi <leonardi@redhat.com>

The IGVM infrastructure operates on X86MachineState and is already
machine-type-agnostic, but the "igvm-cfg" QOM property is only
registered on the PC machine type. Register it on microvm as well.

When an IGVM file is configured, the firmware image is provided as
a payload of the IGVM file so skip loading the default BIOS.

Signed-off-by: Luigi Leonardi <leonardi@redhat.com>
Message-ID: <20260512-microvm_igvm-v1-1-8b1fd8861235@redhat.com>
Signed-off-by: Gerd Hoffmann <kraxel@redhat.com>
---
 hw/i386/microvm.c | 21 ++++++++++++++++-----
 1 file changed, 16 insertions(+), 5 deletions(-)

diff --git a/hw/i386/microvm.c b/hw/i386/microvm.c
index 5a7889f21b8a..779741ec76ee 100644
--- a/hw/i386/microvm.c
+++ b/hw/i386/microvm.c
@@ -159,7 +159,6 @@ static int microvm_ioapics(MicrovmMachineState *mms)
 
 static void microvm_devices_init(MicrovmMachineState *mms)
 {
-    const char *default_firmware;
     X86MachineState *x86ms = X86_MACHINE(mms);
     ISABus *isa_bus;
     GSIState *gsi_state;
@@ -276,10 +275,12 @@ static void microvm_devices_init(MicrovmMachineState *mms)
         serial_hds_isa_init(isa_bus, 0, 1);
     }
 
-    default_firmware = x86_machine_is_acpi_enabled(x86ms)
-            ? MICROVM_BIOS_FILENAME
-            : MICROVM_QBOOT_FILENAME;
-    x86_bios_rom_init(x86ms, default_firmware, get_system_memory(), true);
+    if (!x86ms->igvm) {
+        const char *default_firmware = x86_machine_is_acpi_enabled(x86ms)
+                ? MICROVM_BIOS_FILENAME
+                : MICROVM_QBOOT_FILENAME;
+        x86_bios_rom_init(x86ms, default_firmware, get_system_memory(), true);
+    }
 }
 
 static void microvm_memory_init(MicrovmMachineState *mms)
@@ -717,6 +718,16 @@ static void microvm_class_init(ObjectClass *oc, const void *data)
 
     compat_props_add(mc->compat_props, microvm_properties,
                      G_N_ELEMENTS(microvm_properties));
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
 }
 
 static const TypeInfo microvm_machine_info = {
-- 
2.54.0


