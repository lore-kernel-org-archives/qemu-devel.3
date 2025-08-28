Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id DF490C8303F
	for <qemu-devel@archiver.kernel.org>; Thu, 28 Aug 2025 17:55:01 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1urgoJ-0003dd-8x; Thu, 28 Aug 2025 13:53:19 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from
 <3fpewaAkKCrsbolfftmfshpphmf.dpnrfnv-efwfmopohov.psh@flex--ankeesler.bounces.google.com>)
 id 1urgoG-0003dF-No
 for qemu-devel@nongnu.org; Thu, 28 Aug 2025 13:53:16 -0400
Received: from mail-qt1-x84a.google.com ([2607:f8b0:4864:20::84a])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from
 <3fpewaAkKCrsbolfftmfshpphmf.dpnrfnv-efwfmopohov.psh@flex--ankeesler.bounces.google.com>)
 id 1urgo8-00081d-JZ
 for qemu-devel@nongnu.org; Thu, 28 Aug 2025 13:53:16 -0400
Received: by mail-qt1-x84a.google.com with SMTP id
 d75a77b69052e-4b109be41a1so49526411cf.2
 for <qemu-devel@nongnu.org>; Thu, 28 Aug 2025 10:53:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=google.com; s=20230601; t=1756403583; x=1757008383; darn=nongnu.org;
 h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
 :date:from:to:cc:subject:date:message-id:reply-to;
 bh=3Xa+Cr9KqBCArfh1BVK1sBDjtakPs/JB+duqu8nLn7o=;
 b=OXbkJVW+W09O0WvGFXQMkA1/Tm7as9tPIF6HQY6oU1VLJncn2UOKsct7GCblVRtnz6
 c7xTCeR6nK3oHMGJwsh0z/xqRqZVMPdEDvRo+Nr07LLuXai2G65ygAnhmwCmclGsCf5B
 d+VeVsuXpCb0xmxF9FmnKUgIjxfGepUm2tXA23v7pxN45woSiN5nubwnBs35yn9wpOF6
 LPBfBrEkM375k6O0LigvCuvKVrMYuU4ynZpumEHFET16nPCRxIbde0A6sc0O6GPr6aoW
 6Kv4xj4BEB1FvyXBx6kXz47c82ivpHkh9sSFg16AYA+qvTWug9aQo8uIKd/wIL0g6AHz
 3LbA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1756403583; x=1757008383;
 h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
 :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=3Xa+Cr9KqBCArfh1BVK1sBDjtakPs/JB+duqu8nLn7o=;
 b=g4ifqajhvI6cy1ZMIQVDOwEBc2H2QZKR/Sqs+mFq4sA1v3PFrSh72AGbhLdptmSUCd
 57xJ+zPMQVPF3Ek5qw3S9P+kGVGRZP4wZOEImdozOXDyFyL3cmKm2f+lZfbP5yXDYSy9
 sn0DHn1DzPNDEx3Wqtm2oRj2pM1oMMOJSrofYEx0d833Asvi4AdL0nDpiUmUU0JPojL5
 FJEc05Ai6cBjsItYbBsXRtD6R38SgiDRoDkyyET9Hki/51FDqI7fwzfc6eGB7xl2T96G
 uIVOeTyywyvmn6THl9YoPl9FS7RzwqN3Kh7ftPhZKfTKPl0iUMWBNxxZYvKoYJO5yNVg
 aqGw==
X-Gm-Message-State: AOJu0Yw+Bx9o+aBHJEYPG7/Fd/50Lcub052d6tOUWd4luOU/BCkTvZFD
 +pou3zQimBWV70pMBfi8o1mKbAWGadmMl9YuLaYrGi3TgIXa5mTR+gcArFMiHlKLxw3UWhRTNRi
 ZsBsO9J56EpfWILVX
X-Google-Smtp-Source: AGHT+IErTmp/pG1SJL1JrowZ8dxWqRDYguXTrXaeSTGDSjvOHEIf7Pxr9jgjQFZMkuonvFujnCwdoy1+faLeGOA=
X-Received: from qknqf9.prod.google.com ([2002:a05:620a:6609:b0:7e6:99b9:8ab0])
 (user=ankeesler job=prod-delivery.src-stubby-dispatcher) by
 2002:a05:622a:1993:b0:4b0:8057:1de9 with SMTP id
 d75a77b69052e-4b2aaa19f21mr286456101cf.3.1756403582840; 
 Thu, 28 Aug 2025 10:53:02 -0700 (PDT)
Date: Thu, 28 Aug 2025 17:52:59 +0000
In-Reply-To: <20250828175259.3831672-1-ankeesler@google.com>
Mime-Version: 1.0
References: <20250828175259.3831672-1-ankeesler@google.com>
X-Mailer: git-send-email 2.51.0.338.gd7d06c2dae-goog
Message-ID: <20250828175259.3831672-2-ankeesler@google.com>
Subject: [PATCH v2 1/1] Support per-head resolutions with virtio-gpu
From: Andrew Keesler <ankeesler@google.com>
To: berrange@redhat.com, marcandre.lureau@gmail.com
Cc: qemu-devel@nongnu.org, Andrew Keesler <ankeesler@google.com>
Content-Type: text/plain; charset="UTF-8"
Received-SPF: pass client-ip=2607:f8b0:4864:20::84a;
 envelope-from=3fpewaAkKCrsbolfftmfshpphmf.dpnrfnv-efwfmopohov.psh@flex--ankeesler.bounces.google.com;
 helo=mail-qt1-x84a.google.com
X-Spam_score_int: -95
X-Spam_score: -9.6
X-Spam_bar: ---------
X-Spam_report: (-9.6 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_MED=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001, T_SPF_TEMPERROR=0.01,
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

Here is the behavior matrix of the current resolution configuration
surface (xres/yres) with the new resolution configuration surface
(outputs[i].xres/yres).

Case: !(xres || yres) && !(outputs[i].xres || outputs[i].yres)
Behavior: current behavior - outputs[0] enabled with default xres/yres

Case: (xres || yres) && !(outputs[i].xres || outputs[i].yres)
Behavior: current behavior - outputs[0] enabled with xres/yres

Case: !(xres || yres) && (outputs[i].xres || outputs[i].yres)
Behavior: new behavior - outputs[i] enabled with outputs[i].xres/yres

Case: (xres || yres) && (outputs[i].xres || outputs[i].yres)
Behavior: new behavior - outputs[i] enabled with outputs[i].xres/yres
---
 hw/display/virtio-gpu-base.c   | 10 ++++++++++
 include/hw/virtio/virtio-gpu.h |  2 ++
 qapi/virtio.json               |  6 +++++-
 3 files changed, 17 insertions(+), 1 deletion(-)

diff --git a/hw/display/virtio-gpu-base.c b/hw/display/virtio-gpu-base.c
index 7269477a1c..8bcbe5e837 100644
--- a/hw/display/virtio-gpu-base.c
+++ b/hw/display/virtio-gpu-base.c
@@ -233,6 +233,16 @@ virtio_gpu_base_device_realize(DeviceState *qdev,
     g->req_state[0].width = g->conf.xres;
     g->req_state[0].height = g->conf.yres;
 
+    for (output_idx = 0, node = g->conf.outputs;
+         node && output_idx < g->conf.max_outputs;
+         output_idx++, node = node->next) {
+        if (node->value->xres || node->value->yres) {
+            g->enabled_output_bitmask |= (1 << output_idx);
+            g->req_state[output_idx].width = node->value->xres;
+            g->req_state[output_idx].height = node->value->yres;
+        }
+    }
+
     g->hw_ops = &virtio_gpu_ops;
     for (i = 0; i < g->conf.max_outputs; i++) {
         g->scanout[i].con =
diff --git a/include/hw/virtio/virtio-gpu.h b/include/hw/virtio/virtio-gpu.h
index 9f16f89a36..7597e87971 100644
--- a/include/hw/virtio/virtio-gpu.h
+++ b/include/hw/virtio/virtio-gpu.h
@@ -129,6 +129,8 @@ struct virtio_gpu_base_conf {
     uint32_t xres;
     uint32_t yres;
     uint64_t hostmem;
+    // If set, outputs[i].xres/yres takes precedent over xres/yres and enables
+    // the ith output.
     VirtIOGPUOutputList *outputs;
 };
 
diff --git a/qapi/virtio.json b/qapi/virtio.json
index 9d652fe4a8..9f753543cb 100644
--- a/qapi/virtio.json
+++ b/qapi/virtio.json
@@ -970,11 +970,15 @@
 #
 # @name: the name of the output
 #
+# @xres: horizontal resolution of the output in pixels (since 10.2)
+#
+# @yres: vertical resolution of the output in pixels (since 10.2)
+#
 # Since: 10.1
 ##
 
 { 'struct': 'VirtIOGPUOutput',
-  'data': { 'name': 'str' } }
+  'data': { 'name': 'str', '*xres': 'uint16', '*yres': 'uint16' } }
 
 ##
 # @DummyVirtioForceArrays:
-- 
2.51.0.338.gd7d06c2dae-goog


