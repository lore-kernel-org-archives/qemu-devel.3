Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 11115C52D7D
	for <qemu-devel@archiver.kernel.org>; Wed, 14 Aug 2024 11:59:26 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1seCdR-0004AX-JN; Wed, 14 Aug 2024 07:57:49 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <ribalda@chromium.org>)
 id 1seCdQ-00045A-0q
 for qemu-devel@nongnu.org; Wed, 14 Aug 2024 07:57:48 -0400
Received: from mail-qv1-xf36.google.com ([2607:f8b0:4864:20::f36])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <ribalda@chromium.org>)
 id 1seCdN-0003Xu-R4
 for qemu-devel@nongnu.org; Wed, 14 Aug 2024 07:57:47 -0400
Received: by mail-qv1-xf36.google.com with SMTP id
 6a1803df08f44-6bbc1cee9b7so38544416d6.3
 for <qemu-devel@nongnu.org>; Wed, 14 Aug 2024 04:57:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=chromium.org; s=google; t=1723636664; x=1724241464; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=/9pBVuHeeKUuchvAHlh93dIxxXQ/KQ6UxVkCEoa6S8c=;
 b=Aelea2hmyV0CtWRCrTpVTioYecy91naHeGYWCoFVxcbNIfHuKML1dCYevBxY53QlHI
 HuidGhC5XJZis71H63T3nHYT4wr4p4UVO0xGaGvmjgwDvYbnD42J6cDAkQDAqwEROY4C
 T2qtKNW8iOUfL2BVsY+cPQ+PqdZTQ1Wa8J4TM=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1723636664; x=1724241464;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=/9pBVuHeeKUuchvAHlh93dIxxXQ/KQ6UxVkCEoa6S8c=;
 b=lcXpb3BWsa6n3h/uVt/wpNsH1gst0I9/2zKFfuQTm7LroqyI6g0ebOHe4H+Ev1OM2D
 D9UN4QrAmKd2fES28LN6P3Wu/AhtIevgpgsJTObBY+rxyL6V6gjP+a3jDQwan49GtTm9
 Ww1/5F2i8VCNziidoq8EEnEbiBXrtVnN2qtrswseUEjdQqRlUcRGVCkAg1Qs26DKiKeC
 O8EsiU3dOTppVxBrPQFODcuOLPJetf2zKmxZJm+sZMUOs1PG0hTBIy+1xXCz9DeIjGQO
 YDNFWrqHdBVFgYC/4MM/vNC0niC86RQWSRk7WlPX+zU57yKRoYLKrm/D/DSDwbJ6jqEC
 JKWw==
X-Forwarded-Encrypted: i=1;
 AJvYcCWuDAvjq/TPb9zcpucMqYyfupZAh8KcCZwNdTDsjpv9G8Q2uA72G0kWJSGwZRtrhaAQmTvNRkFLIj/x7+BuOXKAj2rQsc0=
X-Gm-Message-State: AOJu0YxDkNxovFF599jOyNdgqY7Vh7nT6KtB8Zqp32nVNl56tism2q8S
 meBVn2Ny+wQGCYjS7pHbu9lW6bggpd5j9qayjI7wnsvCaIFunZ4DoUpzJR2bkg==
X-Google-Smtp-Source: AGHT+IFi8rzfrhMUYTXT/JXRnnIoIjNNaA9iOj/efDcu93Y/fsGW4d2UtttzSUIFd0qVED73/+Sv5A==
X-Received: by 2002:a05:6214:2f88:b0:6b7:b285:74e7 with SMTP id
 6a1803df08f44-6bf5d24e7b5mr28690156d6.37.1723636664617; 
 Wed, 14 Aug 2024 04:57:44 -0700 (PDT)
Received: from denia.c.googlers.com.com
 (123.178.145.34.bc.googleusercontent.com. [34.145.178.123])
 by smtp.gmail.com with ESMTPSA id
 6a1803df08f44-6bd82c5f375sm43001586d6.14.2024.08.14.04.57.43
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 14 Aug 2024 04:57:44 -0700 (PDT)
From: Ricardo Ribalda <ribalda@chromium.org>
To: "Michael S. Tsirkin" <mst@redhat.com>, Igor Mammedov <imammedo@redhat.com>,
 Ani Sinha <anisinha@redhat.com>,
 Marcel Apfelbaum <marcel.apfelbaum@gmail.com>,
 Paolo Bonzini <pbonzini@redhat.com>,
 Richard Henderson <richard.henderson@linaro.org>,
 Eduardo Habkost <eduardo@habkost.net>, qemu-devel@nongnu.org,
 righi.andrea@gmail.com
Cc: Ricardo Ribalda <ribalda@chromium.org>
Subject: [PATCH v5 2/3] hw/i386/acpi-build: Return a pre-computed _PRT table
Date: Wed, 14 Aug 2024 11:56:10 +0000
Message-ID: <20240814115736.1580337-3-ribalda@chromium.org>
X-Mailer: git-send-email 2.46.0.76.ge559c4bf1a-goog
In-Reply-To: <20240814115736.1580337-1-ribalda@chromium.org>
References: <20240814115736.1580337-1-ribalda@chromium.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::f36;
 envelope-from=ribalda@chromium.org; helo=mail-qv1-xf36.google.com
X-Spam_score_int: -21
X-Spam_score: -2.2
X-Spam_bar: --
X-Spam_report: (-2.2 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.135,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
 T_SCC_BODY_TEXT_LINE=-0.01 autolearn=ham autolearn_force=no
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

When qemu runs without kvm acceleration the ACPI executions take a great
amount of time. If they take more than the default time (30sec), the
ACPI calls fail and the system might not behave correctly.

Now the _PRT table is computed on the fly. We can drastically reduce the
execution of the _PRT method if we return a pre-computed table.

Without this patch:
[   51.343484] ACPI Error: Aborting method \_SB.PCI0._PRT due to previous error (AE_AML_LOOP_TIMEOUT) (20230628/psparse-529)
[   51.527032] ACPI Error: Method execution failed \_SB.PCI0._PRT due to previous error (AE_AML_LOOP_TIMEOUT) (20230628/uteval-68)
[   51.530049] virtio-pci 0000:00:02.0: can't derive routing for PCI INT A
[   51.530797] virtio-pci 0000:00:02.0: PCI INT A: no GSI
[   81.922901] ACPI Error: Aborting method \_SB.PCI0._PRT due to previous error (AE_AML_LOOP_TIMEOUT) (20230628/psparse-529)
[   82.103534] ACPI Error: Method execution failed \_SB.PCI0._PRT due to previous error (AE_AML_LOOP_TIMEOUT) (20230628/uteval-68)
[   82.106088] virtio-pci 0000:00:04.0: can't derive routing for PCI INT A
[   82.106761] virtio-pci 0000:00:04.0: PCI INT A: no GSI
[  112.192568] ACPI Error: Aborting method \_SB.PCI0._PRT due to previous error (AE_AML_LOOP_TIMEOUT) (20230628/psparse-529)
[  112.486687] ACPI Error: Method execution failed \_SB.PCI0._PRT due to previous error (AE_AML_LOOP_TIMEOUT) (20230628/uteval-68)
[  112.489554] virtio-pci 0000:00:05.0: can't derive routing for PCI INT A
[  112.490027] virtio-pci 0000:00:05.0: PCI INT A: no GSI
[  142.559448] ACPI Error: Aborting method \_SB.PCI0._PRT due to previous error (AE_AML_LOOP_TIMEOUT) (20230628/psparse-529)
[  142.718596] ACPI Error: Method execution failed \_SB.PCI0._PRT due to previous error (AE_AML_LOOP_TIMEOUT) (20230628/uteval-68)
[  142.722889] virtio-pci 0000:00:06.0: can't derive routing for PCI INT A
[  142.724578] virtio-pci 0000:00:06.0: PCI INT A: no GSI

With this patch:
[   22.938076] ACPI: \_SB_.LNKB: Enabled at IRQ 10
[   24.214002] ACPI: \_SB_.LNKD: Enabled at IRQ 11
[   25.465170] ACPI: \_SB_.LNKA: Enabled at IRQ 10
[   27.944920] ACPI: \_SB_.LNKC: Enabled at IRQ 11

ACPI disassembly:
        Scope (PCI0)
        {
            Method (_PRT, 0, NotSerialized)  // _PRT: PCI Routing Table
            {
                Return (Package (0x80)
                {
                    Package (0x04)
                    {
                        0xFFFF,
                        Zero,
                        LNKD,
                        Zero
                    },

                    Package (0x04)
                    {
                        0xFFFF,
                        One,
                        LNKA,
                        Zero
                    },

                    Package (0x04)
                    {
                        0xFFFF,
                        0x02,
                        LNKB,
                        Zero
                    },

                    Package (0x04)
                    {
                        0xFFFF,
                        0x03,
                        LNKC,
                        Zero
                    },

                    Package (0x04)
                    {
                        0x0001FFFF,
                        Zero,
                        LNKS,
                        Zero
                    },
Context: https://lore.kernel.org/virtualization/20240417145544.38d7b482@imammedo.users.ipa.redhat.com/T/#t

Signed-off-by: Ricardo Ribalda <ribalda@chromium.org>
Reviewed-by: Igor Mammedov <imammedo@redhat.com>
Reviewed-by: Richard Henderson <richard.henderson@linaro.org>
---
 hw/i386/acpi-build.c | 120 ++++++++-----------------------------------
 1 file changed, 22 insertions(+), 98 deletions(-)

diff --git a/hw/i386/acpi-build.c b/hw/i386/acpi-build.c
index 5d4bd2b710..4967aa7459 100644
--- a/hw/i386/acpi-build.c
+++ b/hw/i386/acpi-build.c
@@ -724,120 +724,44 @@ static Aml *aml_pci_pdsm(void)
     return method;
 }
 
-/**
- * build_prt_entry:
- * @link_name: link name for PCI route entry
- *
- * build AML package containing a PCI route entry for @link_name
- */
-static Aml *build_prt_entry(const char *link_name)
-{
-    Aml *a_zero = aml_int(0);
-    Aml *pkg = aml_package(4);
-    aml_append(pkg, a_zero);
-    aml_append(pkg, a_zero);
-    aml_append(pkg, aml_name("%s", link_name));
-    aml_append(pkg, a_zero);
-    return pkg;
-}
-
 /*
- * initialize_route - Initialize the interrupt routing rule
- * through a specific LINK:
- *  if (lnk_idx == idx)
- *      route using link 'link_name'
- */
-static Aml *initialize_route(Aml *route, const char *link_name,
-                             Aml *lnk_idx, int idx)
-{
-    Aml *if_ctx = aml_if(aml_equal(lnk_idx, aml_int(idx)));
-    Aml *pkg = build_prt_entry(link_name);
-
-    aml_append(if_ctx, aml_store(pkg, route));
-
-    return if_ctx;
-}
-
-/*
- * build_prt - Define interrupt rounting rules
+ * build_prt - Define interrupt routing rules
  *
  * Returns an array of 128 routes, one for each device,
  * based on device location.
  * The main goal is to equally distribute the interrupts
  * over the 4 existing ACPI links (works only for i440fx).
- * The hash function is  (slot + pin) & 3 -> "LNK[D|A|B|C]".
+ * The hash function is: (slot + pin) & 3 -> "LNK[D|A|B|C]".
  *
  */
 static Aml *build_prt(bool is_pci0_prt)
 {
-    Aml *method, *while_ctx, *pin, *res;
+    const int nroutes = 128;
+    Aml *rt_pkg, *method;
+    int pin;
 
     method = aml_method("_PRT", 0, AML_NOTSERIALIZED);
-    res = aml_local(0);
-    pin = aml_local(1);
-    aml_append(method, aml_store(aml_package(128), res));
-    aml_append(method, aml_store(aml_int(0), pin));
+    rt_pkg = aml_varpackage(nroutes);
 
-    /* while (pin < 128) */
-    while_ctx = aml_while(aml_lless(pin, aml_int(128)));
-    {
-        Aml *slot = aml_local(2);
-        Aml *lnk_idx = aml_local(3);
-        Aml *route = aml_local(4);
-
-        /* slot = pin >> 2 */
-        aml_append(while_ctx,
-                   aml_store(aml_shiftright(pin, aml_int(2), NULL), slot));
-        /* lnk_idx = (slot + pin) & 3 */
-        aml_append(while_ctx,
-            aml_store(aml_and(aml_add(pin, slot, NULL), aml_int(3), NULL),
-                      lnk_idx));
-
-        /* route[2] = "LNK[D|A|B|C]", selection based on pin % 3  */
-        aml_append(while_ctx, initialize_route(route, "LNKD", lnk_idx, 0));
-        if (is_pci0_prt) {
-            Aml *if_device_1, *if_pin_4, *else_pin_4;
-
-            /* device 1 is the power-management device, needs SCI */
-            if_device_1 = aml_if(aml_equal(lnk_idx, aml_int(1)));
-            {
-                if_pin_4 = aml_if(aml_equal(pin, aml_int(4)));
-                {
-                    aml_append(if_pin_4,
-                        aml_store(build_prt_entry("LNKS"), route));
-                }
-                aml_append(if_device_1, if_pin_4);
-                else_pin_4 = aml_else();
-                {
-                    aml_append(else_pin_4,
-                        aml_store(build_prt_entry("LNKA"), route));
-                }
-                aml_append(if_device_1, else_pin_4);
-            }
-            aml_append(while_ctx, if_device_1);
+    for (pin = 0; pin < nroutes; pin++) {
+        Aml *pkg = aml_package(4);
+        int slot = pin >> 2;
+
+        aml_append(pkg, aml_int((slot << 16) | 0xFFFF));
+        aml_append(pkg, aml_int(pin & 3));
+        /* device 1 is the power-management device, needs SCI */
+        if (is_pci0_prt && pin == 4) {
+            aml_append(pkg, aml_name("%s", "LNKS"));
         } else {
-            aml_append(while_ctx, initialize_route(route, "LNKA", lnk_idx, 1));
+            static const char link_name[][5] = {"LNKD", "LNKA", "LNKB", "LNKC"};
+            int hash = (slot + pin) & 3;
+            aml_append(pkg, aml_name("%s", link_name[hash]));
         }
-        aml_append(while_ctx, initialize_route(route, "LNKB", lnk_idx, 2));
-        aml_append(while_ctx, initialize_route(route, "LNKC", lnk_idx, 3));
-
-        /* route[0] = 0x[slot]FFFF */
-        aml_append(while_ctx,
-            aml_store(aml_or(aml_shiftleft(slot, aml_int(16)), aml_int(0xFFFF),
-                             NULL),
-                      aml_index(route, aml_int(0))));
-        /* route[1] = pin & 3 */
-        aml_append(while_ctx,
-            aml_store(aml_and(pin, aml_int(3), NULL),
-                      aml_index(route, aml_int(1))));
-        /* res[pin] = route */
-        aml_append(while_ctx, aml_store(route, aml_index(res, pin)));
-        /* pin++ */
-        aml_append(while_ctx, aml_increment(pin));
+        aml_append(pkg, aml_int(0));
+        aml_append(rt_pkg, pkg);
     }
-    aml_append(method, while_ctx);
-    /* return res*/
-    aml_append(method, aml_return(res));
+
+    aml_append(method, aml_return(rt_pkg));
 
     return method;
 }
-- 
2.46.0.76.ge559c4bf1a-goog


