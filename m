Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 57141EF36E6
	for <qemu-devel@archiver.kernel.org>; Mon,  9 Mar 2026 06:45:35 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vzUMM-0007w6-Ca; Mon, 09 Mar 2026 02:44:58 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <edgar.iglesias@gmail.com>)
 id 1vzUMJ-0007vi-1q
 for qemu-devel@nongnu.org; Mon, 09 Mar 2026 02:44:55 -0400
Received: from mail-vk1-xa2b.google.com ([2607:f8b0:4864:20::a2b])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <edgar.iglesias@gmail.com>)
 id 1vzUMH-00027K-Fu
 for qemu-devel@nongnu.org; Mon, 09 Mar 2026 02:44:54 -0400
Received: by mail-vk1-xa2b.google.com with SMTP id
 71dfb90a1353d-56b0dfcc617so675454e0c.0
 for <qemu-devel@nongnu.org>; Sun, 08 Mar 2026 23:44:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1773038692; x=1773643492; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=WJrq6QMWPG9vMn/f3A1Ji6UEIjqvYTStXL9SXKLYoe4=;
 b=gLYx/LeeJWPQniye3zi5GUVcKTf8/bquglVlecGOvx6YC4DaWbuRPxjrqprHJW2d5+
 Ko1aRCgXz71KLNM5FpclhL7XYEMpTPJAkdM3Uwf2gmF0KTcT7Ae8WM8sd4NXtifpWDne
 710KDrati32eFfjPJV5/aqRA+ZTxy4/M65kTK/E/IHcd5Osxgnb2fhp1B1+uCsfySmIh
 qfJ4vVz8C584G15JVBjtb5ugJi/tWql3OLlxYsfYr2bbbLzXwi9kK/qqxQzIbTtcTvOO
 ZfMB3/dfzpNkM31da0TxBqePf+N5ohDbby9NnF92BmZ3jaq1O+5AtN+wBTNpLGuohJIR
 BLdg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1773038692; x=1773643492;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=WJrq6QMWPG9vMn/f3A1Ji6UEIjqvYTStXL9SXKLYoe4=;
 b=owO/d8vrwJr29CxR7xt39rPypAMOJzpMx0qqll2xY1Bq5Jw1DvSdCclHQzsSUFi0yE
 OYoAFxXZkVg5RlfbkCJgnkTtEF6gdfIzV3cDqN4+QCfpbM/f/Iyk651FRraNgVKwmFo+
 nhh4HMxIQ4aqB494KlU2eRmrab1gKXQfD95ITk3KzpBX1BJVjogi745ns0022ouOPMM2
 V88KE6cvj7agYpYDppDj73jr4E6KrdCAnk+twaQOxj+cSHz+U02HmL0Ydraj9eHWlXIE
 EwDo1WLnLwgaFct2EPBiN8OrbxkFFor/PJNqZ3d1E4XeBUeHBrHo3N8smBD2zWhh8PuT
 zNkA==
X-Gm-Message-State: AOJu0YxLghvqSRHc+3hI2idbz4DJPf8ZqfGjkh28nmlnv92W9q/MWAF6
 GEWq5oyu6djt8D8Eqf0z6luxi5qUBs0EF9JFbH+y9jb+ANxLojZmmWSYvszKFJBc
X-Gm-Gg: ATEYQzxyube1lDNXLEKVIdi95rgo7OEtJEtJ63Fh1tvro1M+Z49Whzdqz8I2fiuxOpz
 LXJNmybFOK04YeQUjPdSrccn/EDrauwFGmZDe4jW/zfjsWJU3fA294RSn1G17TljikcF3EaX4MO
 DndPXSL7QT5LYhQ31ubI8EiI5E80IkxFSQjLSkJdh+mUe8OxYAEkRIROxtcKsCmrsWQPf+ze5uq
 62d8AmeDtwKhuuylyX3/ZpUP1p5Iuz/uZ2rLWMYqJx0iE2K42E7i+w66/Ud5tsz/y+G+R3ioJzl
 ol+XK/pXIiu6nJXLBr+OOQu5Rt7hGemaamcpJfHefajnadjrFtBteAxcHDgh1PxQzmMYrcP92mH
 lRRR6+VXLC6WdqRSxljmumvtRAlT3KKMel1RkFlKaMlRrkDxT/eq5Dru+J8YqTCgka0t/AoIpfS
 aqCAs9O0q+qhNFp50Lbh7RuS8YV9C1XVLv9idZyv57ar46sKHzHayn5fVViw==
X-Received: by 2002:a05:6122:1d4e:b0:559:58a5:f6cc with SMTP id
 71dfb90a1353d-56b07d19f27mr3622628e0c.4.1773038691781; 
 Sun, 08 Mar 2026 23:44:51 -0700 (PDT)
Received: from gmail.com (ip190-5-140-138.intercom.com.sv. [190.5.140.138])
 by smtp.gmail.com with ESMTPSA id
 a1e0cc1a2514c-94ea681505csm1360097241.4.2026.03.08.23.44.50
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sun, 08 Mar 2026 23:44:51 -0700 (PDT)
From: "Edgar E. Iglesias" <edgar.iglesias@gmail.com>
To: qemu-devel@nongnu.org, Stefano Stabellini <sstabellini@kernel.org>,
 Anthony PERARD <anthony@xenproject.org>,
 "Edgar E. Iglesias" <edgar.iglesias@gmail.com>,
 Paolo Bonzini <pbonzini@redhat.com>,
 Richard Henderson <richard.henderson@linaro.org>,
 Eduardo Habkost <eduardo@habkost.net>,
 "Michael S. Tsirkin" <mst@redhat.com>,
 Marcel Apfelbaum <marcel.apfelbaum@gmail.com>
Cc: edgar.iglesias@amd.com,
	xen-devel@lists.xenproject.org
Subject: [PULL v1 4/5] hw/xen-hvm: Add a mapcache arg to xen_register_ioreq()
Date: Mon,  9 Mar 2026 07:44:34 +0100
Message-ID: <20260309064436.51860-5-edgar.iglesias@gmail.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260309064436.51860-1-edgar.iglesias@gmail.com>
References: <20260309064436.51860-1-edgar.iglesias@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::a2b;
 envelope-from=edgar.iglesias@gmail.com; helo=mail-vk1-xa2b.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, FREEMAIL_FROM=0.001,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
 T_FILL_THIS_FORM_SHORT=0.01 autolearn=ham autolearn_force=no
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

From: "Edgar E. Iglesias" <edgar.iglesias@amd.com>

Add a mapcache argument to xen_register_ioreq() allowing
the caller to optionally disable the mapcache.

All callers still call it with mapcache = true so there's no
functional change yet.

Signed-off-by: Edgar E. Iglesias <edgar.iglesias@amd.com>
Reviewed-by: Stefano Stabellini <sstabellini@kernel.org>
---
 hw/i386/xen/xen-hvm.c           |  2 +-
 hw/xen/xen-hvm-common.c         | 18 ++++++++++++------
 hw/xen/xen-pvh-common.c         |  3 ++-
 include/hw/xen/xen-hvm-common.h |  3 ++-
 4 files changed, 17 insertions(+), 9 deletions(-)

diff --git a/hw/i386/xen/xen-hvm.c b/hw/i386/xen/xen-hvm.c
index a6e1683885..c7bfcaae8e 100644
--- a/hw/i386/xen/xen-hvm.c
+++ b/hw/i386/xen/xen-hvm.c
@@ -622,7 +622,7 @@ void xen_hvm_init_pc(PCMachineState *pcms, MemoryRegion **ram_memory)
 
     xen_register_ioreq(state, max_cpus,
                        HVM_IOREQSRV_BUFIOREQ_ATOMIC,
-                       &xen_memory_listener);
+                       &xen_memory_listener, true);
 
     xen_is_stubdomain = xen_check_stubdomain(state->xenstore);
 
diff --git a/hw/xen/xen-hvm-common.c b/hw/xen/xen-hvm-common.c
index 59c73dfaeb..8c825588ae 100644
--- a/hw/xen/xen-hvm-common.c
+++ b/hw/xen/xen-hvm-common.c
@@ -473,7 +473,9 @@ static void handle_ioreq(XenIOState *state, ioreq_t *req)
         case IOREQ_TYPE_TIMEOFFSET:
             break;
         case IOREQ_TYPE_INVALIDATE:
-            xen_invalidate_map_cache();
+            if (xen_map_cache_enabled()) {
+                xen_invalidate_map_cache();
+            }
             break;
         case IOREQ_TYPE_PCI_CONFIG:
             cpu_ioreq_config(state, req);
@@ -823,7 +825,8 @@ void xen_shutdown_fatal_error(const char *fmt, ...)
 
 static void xen_do_ioreq_register(XenIOState *state,
                                   unsigned int max_cpus,
-                                  const MemoryListener *xen_memory_listener)
+                                  const MemoryListener *xen_memory_listener,
+                                  bool mapcache)
 {
     int i, rc;
 
@@ -874,11 +877,13 @@ static void xen_do_ioreq_register(XenIOState *state,
         state->bufioreq_local_port = rc;
     }
     /* Init RAM management */
+    if (mapcache) {
 #ifdef XEN_COMPAT_PHYSMAP
-    xen_map_cache_init(xen_phys_offset_to_gaddr, state);
+        xen_map_cache_init(xen_phys_offset_to_gaddr, state);
 #else
-    xen_map_cache_init(NULL, state);
+        xen_map_cache_init(NULL, state);
 #endif
+    }
 
     qemu_add_vm_change_state_handler(xen_hvm_change_state_handler, state);
 
@@ -901,7 +906,8 @@ err:
 
 void xen_register_ioreq(XenIOState *state, unsigned int max_cpus,
                         uint8_t handle_bufioreq,
-                        const MemoryListener *xen_memory_listener)
+                        const MemoryListener *xen_memory_listener,
+                        bool mapcache)
 {
     int rc;
 
@@ -922,7 +928,7 @@ void xen_register_ioreq(XenIOState *state, unsigned int max_cpus,
     state->has_bufioreq = handle_bufioreq != HVM_IOREQSRV_BUFIOREQ_OFF;
     rc = xen_create_ioreq_server(xen_domid, handle_bufioreq, &state->ioservid);
     if (!rc) {
-        xen_do_ioreq_register(state, max_cpus, xen_memory_listener);
+        xen_do_ioreq_register(state, max_cpus, xen_memory_listener, mapcache);
     } else {
         warn_report("xen: failed to create ioreq server");
     }
diff --git a/hw/xen/xen-pvh-common.c b/hw/xen/xen-pvh-common.c
index 1381310fc7..4fade017bb 100644
--- a/hw/xen/xen-pvh-common.c
+++ b/hw/xen/xen-pvh-common.c
@@ -202,7 +202,8 @@ static void xen_pvh_init(MachineState *ms)
     xen_pvh_init_ram(s, sysmem);
     xen_register_ioreq(&s->ioreq, ms->smp.max_cpus,
                        xpc->handle_bufioreq,
-                       &xen_memory_listener);
+                       &xen_memory_listener,
+                       true);
 
     if (s->cfg.virtio_mmio_num) {
         xen_create_virtio_mmio_devices(s);
diff --git a/include/hw/xen/xen-hvm-common.h b/include/hw/xen/xen-hvm-common.h
index e1beca062f..d177ff14ea 100644
--- a/include/hw/xen/xen-hvm-common.h
+++ b/include/hw/xen/xen-hvm-common.h
@@ -91,7 +91,8 @@ void xen_device_unrealize(DeviceListener *listener, DeviceState *dev);
 void xen_hvm_change_state_handler(void *opaque, bool running, RunState rstate);
 void xen_register_ioreq(XenIOState *state, unsigned int max_cpus,
                         uint8_t handle_bufioreq,
-                        const MemoryListener *xen_memory_listener);
+                        const MemoryListener *xen_memory_listener,
+                        bool mapcache);
 
 void cpu_ioreq_pio(ioreq_t *req);
 #endif /* HW_XEN_HVM_COMMON_H */
-- 
2.43.0


