Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id CEDE3C27C53
	for <qemu-devel@archiver.kernel.org>; Fri,  7 Jun 2024 14:19:02 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sFaQ9-0005Pe-FV; Fri, 07 Jun 2024 10:18:21 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <ribalda@chromium.org>)
 id 1sFaQ7-0005OR-2I
 for qemu-devel@nongnu.org; Fri, 07 Jun 2024 10:18:19 -0400
Received: from mail-qk1-x72d.google.com ([2607:f8b0:4864:20::72d])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <ribalda@chromium.org>)
 id 1sFaQ4-0007TY-2V
 for qemu-devel@nongnu.org; Fri, 07 Jun 2024 10:18:18 -0400
Received: by mail-qk1-x72d.google.com with SMTP id
 af79cd13be357-7953189e63aso124768685a.2
 for <qemu-devel@nongnu.org>; Fri, 07 Jun 2024 07:18:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=chromium.org; s=google; t=1717769895; x=1718374695; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=8f1XR3zG8J0peL2PazykKctKRNQnwZxeiwzSk3jP9wI=;
 b=BlUTjORcx/Ne7sNXpMOJXNu/cCH/12PzgwYsKYZOhJVaDwU6jpAU+0x7bSb6jsV0p+
 AEbudH/m8lLSOK0VUn720p5/NbIihZpJonEz8uwlUoRo8asnC6iElsgENsTVpyyR4qrX
 KrXCBhb+h2eXPYNZhJisQ9TxVeuMRkycVwJa0=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1717769895; x=1718374695;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=8f1XR3zG8J0peL2PazykKctKRNQnwZxeiwzSk3jP9wI=;
 b=O5CWs3R7UjLD3PqF7e9oz+sz/+PnYVEPU8iZtjfplkmdUesQvZ+MQGOZ2v/7QAu6sJ
 5fGMRY1DIDYQxPmj1pJX2R5wP6VmDR3xYpIg1Ys1ZnU3nWEEN39Q99x8zRfk3gzke5tM
 /jSEOS4jN6thr4O/Aw75lXTQ/PIdyzZ7/ts6l6905oTzSGp+oqRA19cmJcYCftkYaKPs
 0iex1FUMKyK7QobM62xI2Kmk7rDALy66EB/de+wK5ZvUFQePznpZbQOtlispJuZS0h3z
 i7vRmCDSW/5tPbonf4btX6IiIRQJ4dylAROuq/XgE1qQBgEyrjsYpAninKVTEl/V7pBA
 nfeA==
X-Forwarded-Encrypted: i=1;
 AJvYcCWfMrUqQm+jELeU0PU+q6e8zui4rzDJvtINDqCw3IQxc7D9976Bw5PdXla5y7k11yrfcpDaUBRFA/ErVMS2otQgMM06sic=
X-Gm-Message-State: AOJu0YyMJc61L36WQIN8AEktvmq50AekPB5f/16ZPTvR6B+wBuRueJBb
 somGpm+k1Te5lRYvnhrXkyoA0aS935IqCJdgDYm5pR4vFdvYQXhZh+gA8gtN1g==
X-Google-Smtp-Source: AGHT+IGCtUCkkfgESHgVDj5Dn4AIeTsORaTVk5B1DgCIOVpR44kwcftQICTiHYcWqqjDx463GUvANA==
X-Received: by 2002:ae9:e50f:0:b0:795:1961:18d4 with SMTP id
 af79cd13be357-7953c676f93mr258037685a.46.1717769894789; 
 Fri, 07 Jun 2024 07:18:14 -0700 (PDT)
Received: from denia.c.googlers.com.com
 (123.178.145.34.bc.googleusercontent.com. [34.145.178.123])
 by smtp.gmail.com with ESMTPSA id
 af79cd13be357-79532813a2dsm170873885a.20.2024.06.07.07.18.14
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 07 Jun 2024 07:18:14 -0700 (PDT)
From: Ricardo Ribalda <ribalda@chromium.org>
To: "Michael S. Tsirkin" <mst@redhat.com>, Igor Mammedov <imammedo@redhat.com>,
 Ani Sinha <anisinha@redhat.com>,
 Marcel Apfelbaum <marcel.apfelbaum@gmail.com>,
 Paolo Bonzini <pbonzini@redhat.com>,
 Richard Henderson <richard.henderson@linaro.org>,
 Eduardo Habkost <eduardo@habkost.net>, qemu-devel@nongnu.org,
 Andrea Righi <andrea.righi@canonical.com>
Cc: Ricardo Ribalda <ribalda@chromium.org>
Subject: [PATCH v3 2/3] hw/i386/acpi-build: Return a pre-computed _PRT table
Date: Fri,  7 Jun 2024 14:17:25 +0000
Message-ID: <20240607141809.1637137-3-ribalda@chromium.org>
X-Mailer: git-send-email 2.45.2.505.gda0bf45e8d-goog
In-Reply-To: <20240607141809.1637137-1-ribalda@chromium.org>
References: <20240607141809.1637137-1-ribalda@chromium.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::72d;
 envelope-from=ribalda@chromium.org; helo=mail-qk1-x72d.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
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
---
 hw/i386/acpi-build.c | 120 ++++++++-----------------------------------
 1 file changed, 22 insertions(+), 98 deletions(-)

diff --git a/hw/i386/acpi-build.c b/hw/i386/acpi-build.c
index 53f804ac16..03216a6f29 100644
--- a/hw/i386/acpi-build.c
+++ b/hw/i386/acpi-build.c
@@ -725,120 +725,44 @@ static Aml *aml_pci_pdsm(void)
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
+            const char link_name[][5] = {"LNKD", "LNKA", "LNKB", "LNKC"};
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
2.45.2.505.gda0bf45e8d-goog


