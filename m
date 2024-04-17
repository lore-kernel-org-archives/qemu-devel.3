Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8DF74C4345F
	for <qemu-devel@archiver.kernel.org>; Wed, 17 Apr 2024 14:41:30 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rx6Sg-0007IN-Tn; Wed, 17 Apr 2024 10:40:34 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <ribalda@chromium.org>)
 id 1rx5lr-0004d0-63
 for qemu-devel@nongnu.org; Wed, 17 Apr 2024 09:56:19 -0400
Received: from mail-qt1-x836.google.com ([2607:f8b0:4864:20::836])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <ribalda@chromium.org>)
 id 1rx5lp-0001sx-1G
 for qemu-devel@nongnu.org; Wed, 17 Apr 2024 09:56:18 -0400
Received: by mail-qt1-x836.google.com with SMTP id
 d75a77b69052e-437846c4ceaso1404781cf.3
 for <qemu-devel@nongnu.org>; Wed, 17 Apr 2024 06:56:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=chromium.org; s=google; t=1713362175; x=1713966975; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to;
 bh=SjbPWBfINnOGzcvMdN5Bg4vOl+6PWZ3hUAroJs1C7pk=;
 b=T+xkuawp3wWaONUoflC+83dE6oZoSa3ox2PuC+Y27TT9r2+HuL6WqzodfZFOVHYsUm
 3XBlhXsOG4AmUoT/CyronbMhjfaGJ+O8V8a3oDFgwvg1AgY3rkLM+64blwCw0W1Kaa0g
 fSj5xxChgk8SnOgxhW1MUeOp2UYiFNULDD/ns=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1713362175; x=1713966975;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=SjbPWBfINnOGzcvMdN5Bg4vOl+6PWZ3hUAroJs1C7pk=;
 b=OA55+x6T35LRYSs+PgfYGCAA9imTAJkYJIu4ahCeGUs5S5OX7clZubUnhkAF9g+nsi
 RnLV4qqdZ1MMspyXd45W6MUFH+n3nUDTQ7d3XiupoMq/Xha+cDQTVWxHBf7GdJVKQHYS
 jTbvjD4Z5FVemDyUn7jES2JGuIj/u1gKpOlegDTidzy7VPlOEHpMpQWPvBwpwnvrPX5G
 VghiFa9zTyo+Bg52JEEAPyBYD5HKvNREx+XW8AS7Hkqcl++k99Cy44GQmfaCCG14P4WI
 bglepO1ZVGHnRK6RQNQwbvpHpqrIQqvTZ8Q44gkkU8BdeZKo+UWjum+1MV1LEEsUiEzq
 UoEQ==
X-Forwarded-Encrypted: i=1;
 AJvYcCWHo0lsmwGnzZvcs7g7CNs4qSuSgtCkLm2H0r8mZfwwZs96vFUVnR1ZXv6fgbJWrH6UcpzUC8+7itLqLHd3Gq253YD23ZY=
X-Gm-Message-State: AOJu0YzvwbFPTUiA2r6mJFIkY9wKeEDOKWX7WDKMByTLQ56vCVquj4tr
 nTPPnzVUHej6nYW/0SDEIUGNuN9f24lz2xP5FDWnpgc5xgXocrOR8AmhMfV4sg==
X-Google-Smtp-Source: AGHT+IH6TvE8n404S9zTQJP1CVxoAgrlQ+3mwMF4pbruZXFcH+WheIpEyhz6vjJu255/hE36YesffA==
X-Received: by 2002:a05:622a:678c:b0:436:aad9:6b65 with SMTP id
 hz12-20020a05622a678c00b00436aad96b65mr11707428qtb.25.1713362175234; 
 Wed, 17 Apr 2024 06:56:15 -0700 (PDT)
Received: from denia.c.googlers.com.com
 (114.152.245.35.bc.googleusercontent.com. [35.245.152.114])
 by smtp.gmail.com with ESMTPSA id
 t12-20020ac8588c000000b00436e193f408sm4466973qta.28.2024.04.17.06.56.13
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 17 Apr 2024 06:56:14 -0700 (PDT)
From: Ricardo Ribalda <ribalda@chromium.org>
To: "Michael S. Tsirkin" <mst@redhat.com>, Igor Mammedov <imammedo@redhat.com>,
 Ani Sinha <anisinha@redhat.com>,
 Marcel Apfelbaum <marcel.apfelbaum@gmail.com>,
 Paolo Bonzini <pbonzini@redhat.com>,
 Richard Henderson <richard.henderson@linaro.org>,
 Eduardo Habkost <eduardo@habkost.net>, qemu-devel@nongnu.org
Cc: Ricardo Ribalda <ribalda@chromium.org>
Subject: [PATCH] hw/i386/acpi-build: Return a pre-computed _PRT table
Date: Wed, 17 Apr 2024 13:53:46 +0000
Message-ID: <20240417135608.2613586-1-ribalda@chromium.org>
X-Mailer: git-send-email 2.44.0.683.g7961c838ac-goog
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::836;
 envelope-from=ribalda@chromium.org; helo=mail-qt1-x836.google.com
X-Spam_score_int: -37
X-Spam_score: -3.8
X-Spam_bar: ---
X-Spam_report: (-3.8 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-1.719,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=ham autolearn_force=no
X-Spam_action: no action
X-Mailman-Approved-At: Wed, 17 Apr 2024 10:40:32 -0400
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
 hw/i386/acpi-build.c | 118 ++++++++-----------------------------------
 1 file changed, 21 insertions(+), 97 deletions(-)

diff --git a/hw/i386/acpi-build.c b/hw/i386/acpi-build.c
index 53f804ac16..4c14d39173 100644
--- a/hw/i386/acpi-build.c
+++ b/hw/i386/acpi-build.c
@@ -725,40 +725,7 @@ static Aml *aml_pci_pdsm(void)
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
-/*
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
+#define N_ROUTES 128
 /*
  * build_prt - Define interrupt rounting rules
  *
@@ -771,74 +738,31 @@ static Aml *initialize_route(Aml *route, const char *link_name,
  */
 static Aml *build_prt(bool is_pci0_prt)
 {
-    Aml *method, *while_ctx, *pin, *res;
+    Aml *rt_pkg, *method;
+    const char link_name[][2] = {"D", "A", "B", "C"};
+    int i;
 
     method = aml_method("_PRT", 0, AML_NOTSERIALIZED);
-    res = aml_local(0);
-    pin = aml_local(1);
-    aml_append(method, aml_store(aml_package(128), res));
-    aml_append(method, aml_store(aml_int(0), pin));
+    rt_pkg = aml_varpackage(N_ROUTES);
 
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
-        } else {
-            aml_append(while_ctx, initialize_route(route, "LNKA", lnk_idx, 1));
+    for (i = 0; i < N_ROUTES; i++) {
+        Aml *pkg = aml_package(4);
+        const char *name;
+
+        name = link_name[((i >> 2) + i) & 3];
+
+        if (is_pci0_prt && i == 4) {
+            name = "S";
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
+
+        aml_append(pkg, aml_int((i << 14) | 0xFFFF));
+        aml_append(pkg, aml_int(i & 3));
+        aml_append(pkg, aml_name("LNK%s", name));
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
2.44.0.683.g7961c838ac-goog


