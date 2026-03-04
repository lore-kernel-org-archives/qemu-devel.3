Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D34B9EDEBFD
	for <qemu-devel@archiver.kernel.org>; Wed,  4 Mar 2026 01:53:42 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vxbPl-00063c-E5; Tue, 03 Mar 2026 20:52:41 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <edgar.iglesias@gmail.com>)
 id 1vxbPj-00063Q-R8
 for qemu-devel@nongnu.org; Tue, 03 Mar 2026 20:52:39 -0500
Received: from mail-vs1-xe2b.google.com ([2607:f8b0:4864:20::e2b])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <edgar.iglesias@gmail.com>)
 id 1vxbPi-0004Uz-6T
 for qemu-devel@nongnu.org; Tue, 03 Mar 2026 20:52:39 -0500
Received: by mail-vs1-xe2b.google.com with SMTP id
 ada2fe7eead31-5ff18242343so1634991137.2
 for <qemu-devel@nongnu.org>; Tue, 03 Mar 2026 17:52:37 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1772589157; x=1773193957; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=rZOO08zLikZY030P2ehrGV6veLejKIl076oxwM9/gTs=;
 b=X+ANL9c2Z5oDkVFP2VEW1xFELup1bBMXDJA8JRNHxCe9cjrPtA4kPVk97Vsja42sZI
 v0BJdg8q+yVdz4QcSlTxsxRQr7JQkhbQKSeO4FOn53nPFzhBqAJxZuZwWYMUfuNIA/yT
 0cLJkJ56w56IM5JnDsx5fvjZhkIAP0oM5hxan3IkNrfgVFbA0FgAOwVa/8IU4PTdJtN9
 bpaOqWd0c87l39ZXpC9GsZD4ZnZV7tkA+DqL2pwGoXArCb5NGuipZN0NSodsdGeAayC9
 u0WqnS7lavoXU1MAUPt+etYyFT+LBgI52ZFbkbsod63GuOTRi7Id7GlKOGszE2K4RsMO
 0wpA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1772589157; x=1773193957;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=rZOO08zLikZY030P2ehrGV6veLejKIl076oxwM9/gTs=;
 b=dn4gi6EawyHoGDn0M7cj40emYXSpzhJcwAevLkuJQDCQiqqzL6vN2pT24nq1LrrsJw
 eofJyh99x6yY5DrfqcfESh3NmUlAoEOHS8T1ObjXuoizg9ZdCVxvOgXlwL+3KK/wfau4
 nDk3Gw3SAOySs4em2e9kkEPPA6/pPHJGeGXf6kvgDhaeWBnURzht/xrV1goN7zE43Afc
 1XA7m6gUKrbpo827vfQDKGZlErf0VIGq2+oQ8oLmVrYuwYOr20i1x5+yjjwFHiqStm4i
 AKB390gC94w0cwgOEr837XzeWSgNuKearKy9rV9y9s9oroGiCT2rmIPKunxBdAYwYLBF
 M01A==
X-Gm-Message-State: AOJu0YxsV7oibcfTyqf+6To1T2UDJUfi96qVkihUrZNVWtYJveRH7udt
 MY39xDKYkJLU27+5HTmi/qsonhyErqc8DHlBGUFCMQp0ahclrSapjuT8NH+IyfX0
X-Gm-Gg: ATEYQzx4mbGHyDQ+R30WLRMho0KftAyKDRlrHyfB5ELh2+0Cxgeb2lPPukHH6bmdvzA
 4so6TwGq1ZLwT/b1EjbWzDTtvQrysw9kRCavYuvZUMDGPBbS6oOBTaekVFi7eR1yYMVQQQz6pnx
 vku5HScnACsWvSVebMAkQVmKHlGE4l9k+fZljbJpuk0LgGVD/o7GiD1+Q0VhCu0qZ/LlqRrpmC7
 T96H5e/ku7CS4vNAj8aSrtZ8bMVCUesXH90ON9tRAiaZ7xwsrHjKmTrFn4RfClXGMzqflk9B/Hh
 1z2XSYr/ZTtxZF2eDvBmMHHNrkiDvDA+Xi7nzXxEKc4K5GHXflrYYYafgfnKu2MRFdKYKulfmko
 RzU5RiFFYjuN1AxBr8rnt8Ys/zjBkt2ZM0ieOqoMXXyBw6+Riw8xA7cMZ19hlrnWhJkbc+PX/iI
 MBhBOjSvhg7i05nSbComEpiEkSjjQbTa5PZT+4OBBMAPiO4ieD0ewOiPhIMg==
X-Received: by 2002:a05:6102:c52:b0:5fe:13bc:f13a with SMTP id
 ada2fe7eead31-5ffaafb23f5mr239107137.36.1772589156590; 
 Tue, 03 Mar 2026 17:52:36 -0800 (PST)
Received: from gmail.com (ip190-5-140-138.intercom.com.sv. [190.5.140.138])
 by smtp.gmail.com with ESMTPSA id
 a1e0cc1a2514c-94df6577693sm16742382241.9.2026.03.03.17.52.35
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 03 Mar 2026 17:52:35 -0800 (PST)
From: "Edgar E. Iglesias" <edgar.iglesias@gmail.com>
To: qemu-devel@nongnu.org, Stefano Stabellini <sstabellini@kernel.org>,
 Anthony PERARD <anthony@xenproject.org>, Paul Durrant <paul@xen.org>,
 "Edgar E. Iglesias" <edgar.iglesias@gmail.com>,
 "Michael S. Tsirkin" <mst@redhat.com>,
 Marcel Apfelbaum <marcel.apfelbaum@gmail.com>,
 Paolo Bonzini <pbonzini@redhat.com>,
 Richard Henderson <richard.henderson@linaro.org>,
 Eduardo Habkost <eduardo@habkost.net>
Cc: edgar.iglesias@amd.com,
	xen-devel@lists.xenproject.org
Subject: [PATCH v1 4/5] hw/xen-hvm: Add a mapcache arg to xen_register_ioreq()
Date: Wed,  4 Mar 2026 02:52:20 +0100
Message-ID: <20260304015222.979224-5-edgar.iglesias@gmail.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260304015222.979224-1-edgar.iglesias@gmail.com>
References: <20260304015222.979224-1-edgar.iglesias@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::e2b;
 envelope-from=edgar.iglesias@gmail.com; helo=mail-vs1-xe2b.google.com
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


