Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5550BC83F1A
	for <qemu-devel@archiver.kernel.org>; Tue, 22 Jul 2025 19:09:30 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1ueIMB-0004lv-2D; Tue, 22 Jul 2025 15:08:55 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from
 <3weF_aAkKCs4u74yyC5yB08805y.w86Ay6E-xyFy578707E.8B0@flex--ankeesler.bounces.google.com>)
 id 1ueIM8-0004j2-VG
 for qemu-devel@nongnu.org; Tue, 22 Jul 2025 15:08:52 -0400
Received: from mail-qv1-xf4a.google.com ([2607:f8b0:4864:20::f4a])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from
 <3weF_aAkKCs4u74yyC5yB08805y.w86Ay6E-xyFy578707E.8B0@flex--ankeesler.bounces.google.com>)
 id 1ueIM7-0000Su-C7
 for qemu-devel@nongnu.org; Tue, 22 Jul 2025 15:08:52 -0400
Received: by mail-qv1-xf4a.google.com with SMTP id
 6a1803df08f44-6fd5e0bc378so101330896d6.1
 for <qemu-devel@nongnu.org>; Tue, 22 Jul 2025 12:08:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=google.com; s=20230601; t=1753211330; x=1753816130; darn=nongnu.org;
 h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
 :date:from:to:cc:subject:date:message-id:reply-to;
 bh=VyE0qHPI/P4gmMnGUVnepiuV2iHxwOPB7AmBfA8cmbA=;
 b=EzymTvy0Sw8qieSpJB5OdHDuwcfigMqdT5t6MmQEOC++jll6STsAtDdOOsIwHXGEJL
 d09pVkCI8eHyIUZ2vNfIY17Q2vSEYqeyFCPKQsGwdszkTkwNauKpx1PNn7cZcBbuGEyB
 WgXJyyNDHPUfl8s6lAu+cCyjPY2NT9aBsBYHr7P292DRO7EoqXKN+CDJv/Kc1QWYp9tB
 TLY38AVFpyXweM6dxGxd1FgN56zZac7afNSieL9OkAojPy1W/vVcGFlSEh5qeS4/AgoK
 pSLs0fwrVomD8P7lcH0nv7raoZKQukpe688o1P3KTXTdHdpozH0bcsJbH38YlYXM4oCo
 RORQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1753211330; x=1753816130;
 h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
 :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=VyE0qHPI/P4gmMnGUVnepiuV2iHxwOPB7AmBfA8cmbA=;
 b=sbtEM7xGq+7++/SoA0QR7SaTf0GxxpdfFEpuMCDOwqVjEczqBe9xBqYin4g0E0wRpb
 VppoviI48Wj9eFftNVi+05wHRAM8pjNVfd22pEJ9cE3LfmzZvghxD+TgcpItBWSLZyL2
 d6kwnVFvYDrePVvwkFfJnZSFXxajwZx+3nYHtCwOXsYkdnGArKC1WLf9GizX9hHPNW8d
 IGKmMfosTQHw1gEDevk4eWZZItdcGzlH1WEe4V2FPIr9N4w62yPSmt6cEWxrpCG0da7t
 Pdg2uHuA9Q8e2kFqDu07Cw7yHCy35N2vPOD4ZQHXI1NuRshhqvdu8NaKhWcg3vqwHiva
 az6w==
X-Gm-Message-State: AOJu0YwoIxucPfycd0DziuIm/3TjxR40NAvGWc2iIujrxnSt06TMuejb
 xE4D7UdsBX4oeIp+RuMZrQIkT4gOj/SjJ+GR/TruZRuZybfeevPEK0/jR8sEGJJVZUXMY6rkvnx
 CMSQ/zS+YzrqsUsRr
X-Google-Smtp-Source: AGHT+IGN8PsDhQysteH4DmHk2EBMHVCMXIsWUZ5mws1pq/GOgKFNKhZL6wYEs9z33uonDD23JPvpk4lYYS19a7M=
X-Received: from qtbay14.prod.google.com
 ([2002:a05:622a:228e:b0:4ab:9383:b32e])
 (user=ankeesler job=prod-delivery.src-stubby-dispatcher) by
 2002:a05:622a:98c:b0:499:5503:7b2c with SMTP id
 d75a77b69052e-4ae6df763f6mr2800071cf.43.1753211329762; 
 Tue, 22 Jul 2025 12:08:49 -0700 (PDT)
Date: Tue, 22 Jul 2025 19:08:24 +0000
In-Reply-To: <20250722190824.3419413-1-ankeesler@google.com>
Mime-Version: 1.0
References: <20250722190824.3419413-1-ankeesler@google.com>
X-Mailer: git-send-email 2.50.0.727.gbf7dc18ff4-goog
Message-ID: <20250722190824.3419413-2-ankeesler@google.com>
Subject: [PATCH 1/1] hw/display: Support per-head resolutions with virtio-gpu
From: Andrew Keesler <ankeesler@google.com>
To: berrange@redhat.com, marcandre.lureau@gmail.com
Cc: qemu-devel@nongnu.org, Andrew Keesler <ankeesler@google.com>
Content-Type: text/plain; charset="UTF-8"
Received-SPF: pass client-ip=2607:f8b0:4864:20::f4a;
 envelope-from=3weF_aAkKCs4u74yyC5yB08805y.w86Ay6E-xyFy578707E.8B0@flex--ankeesler.bounces.google.com;
 helo=mail-qv1-xf4a.google.com
X-Spam_score_int: -95
X-Spam_score: -9.6
X-Spam_bar: ---------
X-Spam_report: (-9.6 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_MED=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
 USER_IN_DEF_DKIM_WL=-7.5 autolearn=ham autolearn_force=no
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

In 454f4b0f, we started down the path of supporting separate
configurations per display head (e.g., you have 2 heads - one with
EDID name "AAA" and the other with EDID name "BBB").

In this change, we add resolution to this configuration surface (e.g.,
you have 2 heads - one with resolution 111x222 and the other with
resolution 333x444).

  -display vnc=localhost:0,id=aaa,display=vga,head=0 \
  -display vnc=localhost:1,id=bbb,display=vga,head=1 \
  -device '{"driver":"virtio-vga",
            "max_outputs":2,
            "id":"vga",
            "outputs":[
              {
                 "name":"AAA",
                 "xres":111,
                 "yres":222
              },
              {
                 "name":"BBB",
                 "xres":333,
                 "yres":444
              }
            ]}'

If no virtio_gpu_base_conf.outputs are provided, then
virtio_gpu_base_conf.xres/virtio_gpu_base_conf.yres will still be
respected, preserving backwards compatibility.

Otherwise, if any virtio_gpu_base_conf.outputs are provided, then
virtio_gpu_base_conf.outputs.xres/virtio_gpu_base_conf.outputs.yres
will take precedence. In this case,
virtio_gpu_base_conf.outputs.xres/virtio_gpu_base_conf.outputs.yres
must be non-zero.

Signed-off-by: Andrew Keesler <ankeesler@google.com>
---
 hw/display/virtio-gpu-base.c | 12 ++++++++++++
 qapi/virtio.json             |  6 +++++-
 2 files changed, 17 insertions(+), 1 deletion(-)

diff --git a/hw/display/virtio-gpu-base.c b/hw/display/virtio-gpu-base.c
index 7269477a1c..1fc879cc93 100644
--- a/hw/display/virtio-gpu-base.c
+++ b/hw/display/virtio-gpu-base.c
@@ -206,6 +206,10 @@ virtio_gpu_base_device_realize(DeviceState *qdev,
                        node->value->name, EDID_NAME_MAX_LENGTH);
             return false;
         }
+        if (node->value && !(node->value->xres && node->value->yres)) {
+            error_setg(errp, "invalid resolution == 0");
+            return false;
+        }
     }
 
     if (virtio_gpu_virgl_enabled(g->conf)) {
@@ -233,6 +237,14 @@ virtio_gpu_base_device_realize(DeviceState *qdev,
     g->req_state[0].width = g->conf.xres;
     g->req_state[0].height = g->conf.yres;
 
+    for (output_idx = 0, node = g->conf.outputs;
+         node && output_idx < g->conf.max_outputs;
+         output_idx++, node = node->next) {
+        g->enabled_output_bitmask |= (1 << output_idx);
+        g->req_state[output_idx].width = node->value->xres;
+        g->req_state[output_idx].height = node->value->yres;
+    }
+
     g->hw_ops = &virtio_gpu_ops;
     for (i = 0; i < g->conf.max_outputs; i++) {
         g->scanout[i].con =
diff --git a/qapi/virtio.json b/qapi/virtio.json
index 9d652fe4a8..36581690c7 100644
--- a/qapi/virtio.json
+++ b/qapi/virtio.json
@@ -970,11 +970,15 @@
 #
 # @name: the name of the output
 #
+# @xres: horizontal resolution of the output in pixels
+#
+# @yres: vertical resolution of the output in pixels
+#
 # Since: 10.1
 ##
 
 { 'struct': 'VirtIOGPUOutput',
-  'data': { 'name': 'str' } }
+  'data': { 'name': 'str', 'xres': 'uint16', 'yres': 'uint16' } }
 
 ##
 # @DummyVirtioForceArrays:
-- 
2.50.0.727.gbf7dc18ff4-goog


