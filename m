Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9926AC3ABCE
	for <qemu-devel@archiver.kernel.org>; Mon, 16 Sep 2024 15:10:15 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sqDLf-0004fD-Dl; Mon, 16 Sep 2024 11:09:07 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <edgar.iglesias@gmail.com>)
 id 1sqDLd-0004Z3-Bg
 for qemu-devel@nongnu.org; Mon, 16 Sep 2024 11:09:05 -0400
Received: from mail-il1-x130.google.com ([2607:f8b0:4864:20::130])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <edgar.iglesias@gmail.com>)
 id 1sqDLb-00048g-D0
 for qemu-devel@nongnu.org; Mon, 16 Sep 2024 11:09:05 -0400
Received: by mail-il1-x130.google.com with SMTP id
 e9e14a558f8ab-3a08489f757so13483725ab.0
 for <qemu-devel@nongnu.org>; Mon, 16 Sep 2024 08:09:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1726499342; x=1727104142; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=SbKegTM3qN+Ytt+xHcqndYgbj2oaz5lyUbttYzNXA8U=;
 b=I2jOGv/vrNQ2F6+6OJ2pYyCsP80TCBylTbnHio7o1V+K1+7lytWAIEUBLzVGzwDye1
 y7esGlZ+Tiel89ne4M61H9f3QvRvUL2yWa5zj1b9ivebULrpf54AopY9E4aRW+NFD0qR
 DPiFOfqGUxTjF3svgSO5QE37/ToW51BrE0rJD9oNh4iseNPTsLSza2aniYLHcv7BpRNO
 6JFvmcofjKz5G8o7V/KycUXGWPW0TkbIpzn3k2OyTb+7KDcT1CD3IJnLDenhqbePBCYH
 IEIA/CZASIAM6gTFin0WjanVxrx6THIVNp5uClMzhm1MxadYLRJexgXdiQvov7IvIZsV
 mkNA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1726499342; x=1727104142;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=SbKegTM3qN+Ytt+xHcqndYgbj2oaz5lyUbttYzNXA8U=;
 b=BMSpU1rp0Bq4mxhQ2c1fi80ghJMXBurfy0lBd6GpBEZZvaKqowHPEH3cQ8OmeZnDfQ
 rYJjNbhDrbO3yRKUaeTzcDiD9Kr2LfIHmFDN5eidkdhAWQzLdWabI4O6OxjoeEa8n9q4
 wO9Sy5biWW8kjsOfvmPiPnA17i2ObdmxALx2yqTcwt3QjBh0pzWg/0Lzb0mhn2FArJoO
 8V9/aOBdMUINiWxhyq884bvCYeOMKWUfjCAUSbDaB2pA6IFHk/yiirIvfpbth3ADN6Jj
 4EiOCqbzF3kHAUhzPWJF/hyQLy74uYMWke2bTua10H42RV+tQhGWD0wZxcXYES+jccu3
 3X4Q==
X-Gm-Message-State: AOJu0YzqXeTHDL2WgFgC3bE/k0SE9+dosPh0OZRhmMF1CBh0SGcIn6lU
 gHHAghoyafGirmoK5MUgQh6+V8ov8unhopgmcleIiH1zGmmdOFfg9M1Oqsrp
X-Google-Smtp-Source: AGHT+IG+/SW/D0yFpfEJ5d73OOBWnbYkm6OlW1UxBoRWx11pp93quvsquEBHNNv20XbyDW5ufhyR9g==
X-Received: by 2002:a05:6e02:148f:b0:3a0:98ab:7932 with SMTP id
 e9e14a558f8ab-3a098ab7be4mr50233635ab.9.1726499341496; 
 Mon, 16 Sep 2024 08:09:01 -0700 (PDT)
Received: from gmail.com (ip190-5-140-142.intercom.com.sv. [190.5.140.142])
 by smtp.gmail.com with ESMTPSA id
 e9e14a558f8ab-3a092e8eea7sm16674175ab.77.2024.09.16.08.08.58
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 16 Sep 2024 08:09:00 -0700 (PDT)
From: "Edgar E. Iglesias" <edgar.iglesias@gmail.com>
To: qemu-devel@nongnu.org
Cc: sstabellini@kernel.org, anthony@xenproject.org, paul@xen.org,
 peter.maydell@linaro.org, alex.bennee@linaro.org, edgar.iglesias@amd.com,
 xen-devel@lists.xenproject.org,
 "Edgar E. Iglesias" <edgar.iglesias@gmail.com>,
 "Michael S. Tsirkin" <mst@redhat.com>,
 Marcel Apfelbaum <marcel.apfelbaum@gmail.com>,
 Paolo Bonzini <pbonzini@redhat.com>,
 Richard Henderson <richard.henderson@linaro.org>,
 Eduardo Habkost <eduardo@habkost.net>
Subject: [PATCH v1 1/4] xen: Expose handle_bufioreq in xen_register_ioreq
Date: Mon, 16 Sep 2024 17:08:49 +0200
Message-ID: <20240916150853.1216703-2-edgar.iglesias@gmail.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240916150853.1216703-1-edgar.iglesias@gmail.com>
References: <20240916150853.1216703-1-edgar.iglesias@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::130;
 envelope-from=edgar.iglesias@gmail.com; helo=mail-il1-x130.google.com
X-Spam_score_int: 12
X-Spam_score: 1.2
X-Spam_bar: +
X-Spam_report: (1.2 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1, DKIM_VALID=-0.1,
 DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, FREEMAIL_FROM=0.001,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_SBL_CSS=3.335, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001, T_FILL_THIS_FORM_SHORT=0.01 autolearn=no autolearn_force=no
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

From: "Edgar E. Iglesias" <edgar.iglesias@amd.com>

Expose handle_bufioreq in xen_register_ioreq().
This is to allow machines to enable or disable buffered ioreqs.

No functional change since all callers still set it to
HVM_IOREQSRV_BUFIOREQ_ATOMIC.

Signed-off-by: Edgar E. Iglesias <edgar.iglesias@amd.com>
---
 hw/i386/xen/xen-hvm.c           |   4 +-
 hw/xen/xen-hvm-common.c         | 100 +++++++++++++++++++-------------
 hw/xen/xen-pvh-common.c         |   4 +-
 include/hw/xen/xen-hvm-common.h |   3 +
 include/hw/xen/xen_native.h     |   3 +-
 5 files changed, 70 insertions(+), 44 deletions(-)

diff --git a/hw/i386/xen/xen-hvm.c b/hw/i386/xen/xen-hvm.c
index 4f6446600c..d3df488c48 100644
--- a/hw/i386/xen/xen-hvm.c
+++ b/hw/i386/xen/xen-hvm.c
@@ -614,7 +614,9 @@ void xen_hvm_init_pc(PCMachineState *pcms, MemoryRegion **ram_memory)
 
     state = g_new0(XenIOState, 1);
 
-    xen_register_ioreq(state, max_cpus, &xen_memory_listener);
+    xen_register_ioreq(state, max_cpus,
+                       HVM_IOREQSRV_BUFIOREQ_ATOMIC,
+                       &xen_memory_listener);
 
     xen_is_stubdomain = xen_check_stubdomain(state->xenstore);
 
diff --git a/hw/xen/xen-hvm-common.c b/hw/xen/xen-hvm-common.c
index 3a9d6f981b..d8824cccf1 100644
--- a/hw/xen/xen-hvm-common.c
+++ b/hw/xen/xen-hvm-common.c
@@ -667,6 +667,8 @@ static int xen_map_ioreq_server(XenIOState *state)
     xen_pfn_t ioreq_pfn;
     xen_pfn_t bufioreq_pfn;
     evtchn_port_t bufioreq_evtchn;
+    unsigned long num_frames = 1;
+    unsigned long frame = 1;
     int rc;
 
     /*
@@ -675,59 +677,72 @@ static int xen_map_ioreq_server(XenIOState *state)
      */
     QEMU_BUILD_BUG_ON(XENMEM_resource_ioreq_server_frame_bufioreq != 0);
     QEMU_BUILD_BUG_ON(XENMEM_resource_ioreq_server_frame_ioreq(0) != 1);
+
+    if (state->has_bufioreq) {
+        frame = 0;
+        num_frames = 2;
+    }
     state->fres = xenforeignmemory_map_resource(xen_fmem, xen_domid,
                                          XENMEM_resource_ioreq_server,
-                                         state->ioservid, 0, 2,
+                                         state->ioservid,
+                                         frame, num_frames,
                                          &addr,
                                          PROT_READ | PROT_WRITE, 0);
     if (state->fres != NULL) {
         trace_xen_map_resource_ioreq(state->ioservid, addr);
-        state->buffered_io_page = addr;
-        state->shared_page = addr + XC_PAGE_SIZE;
+        state->shared_page = addr;
+        if (state->has_bufioreq) {
+            state->buffered_io_page = addr;
+            state->shared_page = addr + XC_PAGE_SIZE;
+        }
     } else if (errno != EOPNOTSUPP) {
         error_report("failed to map ioreq server resources: error %d handle=%p",
                      errno, xen_xc);
         return -1;
     }
 
-    rc = xen_get_ioreq_server_info(xen_domid, state->ioservid,
-                                   (state->shared_page == NULL) ?
-                                   &ioreq_pfn : NULL,
-                                   (state->buffered_io_page == NULL) ?
-                                   &bufioreq_pfn : NULL,
-                                   &bufioreq_evtchn);
-    if (rc < 0) {
-        error_report("failed to get ioreq server info: error %d handle=%p",
-                     errno, xen_xc);
-        return rc;
-    }
-
-    if (state->shared_page == NULL) {
-        trace_xen_map_ioreq_server_shared_page(ioreq_pfn);
+    if (state->has_bufioreq) {
+        rc = xen_get_ioreq_server_info(xen_domid, state->ioservid,
+                                       (state->shared_page == NULL) ?
+                                       &ioreq_pfn : NULL,
+                                       (state->buffered_io_page == NULL) ?
+                                       &bufioreq_pfn : NULL,
+                                       &bufioreq_evtchn);
+        if (rc < 0) {
+            error_report("failed to get ioreq server info: error %d handle=%p",
+                    errno, xen_xc);
+            return rc;
+        }
 
-        state->shared_page = xenforeignmemory_map(xen_fmem, xen_domid,
-                                                  PROT_READ | PROT_WRITE,
-                                                  1, &ioreq_pfn, NULL);
         if (state->shared_page == NULL) {
-            error_report("map shared IO page returned error %d handle=%p",
-                         errno, xen_xc);
+            trace_xen_map_ioreq_server_shared_page(ioreq_pfn);
+
+            state->shared_page = xenforeignmemory_map(xen_fmem, xen_domid,
+                                                      PROT_READ | PROT_WRITE,
+                                                      1, &ioreq_pfn, NULL);
+            if (state->shared_page == NULL) {
+                error_report("map shared IO page returned error %d handle=%p",
+                        errno, xen_xc);
+            }
         }
-    }
 
-    if (state->buffered_io_page == NULL) {
-        trace_xen_map_ioreq_server_buffered_io_page(bufioreq_pfn);
-
-        state->buffered_io_page = xenforeignmemory_map(xen_fmem, xen_domid,
-                                                       PROT_READ | PROT_WRITE,
-                                                       1, &bufioreq_pfn,
-                                                       NULL);
         if (state->buffered_io_page == NULL) {
-            error_report("map buffered IO page returned error %d", errno);
-            return -1;
+            trace_xen_map_ioreq_server_buffered_io_page(bufioreq_pfn);
+
+            state->buffered_io_page = xenforeignmemory_map(xen_fmem, xen_domid,
+                    PROT_READ | PROT_WRITE,
+                    1, &bufioreq_pfn,
+                    NULL);
+            if (state->buffered_io_page == NULL) {
+                error_report("map buffered IO page returned error %d", errno);
+                return -1;
+            }
         }
     }
 
-    if (state->shared_page == NULL || state->buffered_io_page == NULL) {
+
+    if (state->shared_page == NULL ||
+        (state->has_bufioreq && state->buffered_io_page == NULL)) {
         return -1;
     }
 
@@ -830,14 +845,15 @@ static void xen_do_ioreq_register(XenIOState *state,
         state->ioreq_local_port[i] = rc;
     }
 
-    rc = qemu_xen_evtchn_bind_interdomain(state->xce_handle, xen_domid,
-                                          state->bufioreq_remote_port);
-    if (rc == -1) {
-        error_report("buffered evtchn bind error %d", errno);
-        goto err;
+    if (state->has_bufioreq) {
+        rc = qemu_xen_evtchn_bind_interdomain(state->xce_handle, xen_domid,
+                                              state->bufioreq_remote_port);
+        if (rc == -1) {
+            error_report("buffered evtchn bind error %d", errno);
+            goto err;
+        }
+        state->bufioreq_local_port = rc;
     }
-    state->bufioreq_local_port = rc;
-
     /* Init RAM management */
 #ifdef XEN_COMPAT_PHYSMAP
     xen_map_cache_init(xen_phys_offset_to_gaddr, state);
@@ -865,6 +881,7 @@ err:
 }
 
 void xen_register_ioreq(XenIOState *state, unsigned int max_cpus,
+                        int handle_bufioreq,
                         const MemoryListener *xen_memory_listener)
 {
     int rc;
@@ -883,7 +900,8 @@ void xen_register_ioreq(XenIOState *state, unsigned int max_cpus,
         goto err;
     }
 
-    rc = xen_create_ioreq_server(xen_domid, &state->ioservid);
+    state->has_bufioreq = handle_bufioreq != HVM_IOREQSRV_BUFIOREQ_OFF;
+    rc = xen_create_ioreq_server(xen_domid, handle_bufioreq, &state->ioservid);
     if (!rc) {
         xen_do_ioreq_register(state, max_cpus, xen_memory_listener);
     } else {
diff --git a/hw/xen/xen-pvh-common.c b/hw/xen/xen-pvh-common.c
index 28d7168446..08641fdcec 100644
--- a/hw/xen/xen-pvh-common.c
+++ b/hw/xen/xen-pvh-common.c
@@ -194,7 +194,9 @@ static void xen_pvh_init(MachineState *ms)
     }
 
     xen_pvh_init_ram(s, sysmem);
-    xen_register_ioreq(&s->ioreq, ms->smp.max_cpus, &xen_memory_listener);
+    xen_register_ioreq(&s->ioreq, ms->smp.max_cpus,
+                       HVM_IOREQSRV_BUFIOREQ_ATOMIC,
+                       &xen_memory_listener);
 
     if (s->cfg.virtio_mmio_num) {
         xen_create_virtio_mmio_devices(s);
diff --git a/include/hw/xen/xen-hvm-common.h b/include/hw/xen/xen-hvm-common.h
index 3d796235dc..7246941fe5 100644
--- a/include/hw/xen/xen-hvm-common.h
+++ b/include/hw/xen/xen-hvm-common.h
@@ -81,6 +81,8 @@ typedef struct XenIOState {
     QLIST_HEAD(, XenPciDevice) dev_list;
     DeviceListener device_listener;
 
+    bool has_bufioreq;
+
     Notifier exit;
 } XenIOState;
 
@@ -95,6 +97,7 @@ void xen_device_unrealize(DeviceListener *listener, DeviceState *dev);
 
 void xen_hvm_change_state_handler(void *opaque, bool running, RunState rstate);
 void xen_register_ioreq(XenIOState *state, unsigned int max_cpus,
+                        int handle_bufioreq,
                         const MemoryListener *xen_memory_listener);
 
 void cpu_ioreq_pio(ioreq_t *req);
diff --git a/include/hw/xen/xen_native.h b/include/hw/xen/xen_native.h
index 1a5ad693a4..5caf91a616 100644
--- a/include/hw/xen/xen_native.h
+++ b/include/hw/xen/xen_native.h
@@ -464,10 +464,11 @@ static inline void xen_unmap_pcidev(domid_t dom,
 }
 
 static inline int xen_create_ioreq_server(domid_t dom,
+                                          int handle_bufioreq,
                                           ioservid_t *ioservid)
 {
     int rc = xendevicemodel_create_ioreq_server(xen_dmod, dom,
-                                                HVM_IOREQSRV_BUFIOREQ_ATOMIC,
+                                                handle_bufioreq,
                                                 ioservid);
 
     if (rc == 0) {
-- 
2.43.0


