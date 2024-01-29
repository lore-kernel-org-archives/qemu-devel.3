Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C6269C47DDB
	for <qemu-devel@archiver.kernel.org>; Mon, 29 Jan 2024 15:46:46 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rUTqF-0000Np-3q; Mon, 29 Jan 2024 10:46:35 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <manos.pitsidianakis@linaro.org>)
 id 1rUTqD-0000N5-7x
 for qemu-devel@nongnu.org; Mon, 29 Jan 2024 10:46:33 -0500
Received: from mail-wm1-x32a.google.com ([2a00:1450:4864:20::32a])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <manos.pitsidianakis@linaro.org>)
 id 1rUTqB-0005Eh-4q
 for qemu-devel@nongnu.org; Mon, 29 Jan 2024 10:46:32 -0500
Received: by mail-wm1-x32a.google.com with SMTP id
 5b1f17b1804b1-40e80046246so15777095e9.1
 for <qemu-devel@nongnu.org>; Mon, 29 Jan 2024 07:46:30 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1706543189; x=1707147989; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=OO1Xd496GZU9VnfGz8L9/dfv4mIbaz4PPUfJmAWvi4E=;
 b=XCNw98moHjT8fWX3O1Olh0L3dWS/IRlLm//uLtt37asDAOFKd7eNSm3cB1DJUT3wnH
 smZI/d6y76HErxFm5OfvylwjaguEkZVXpXuTVNHHueWBbNmdtTfmUVSWtgU/zOlK0NOL
 CaXHRc05QRMpmwh6NxxPeM1v15gs2GE324toeo0hnNjm2foZT+hGC016MqdMNi+lA+CE
 kIsolTi1IN0WJybt11VlGw5ndW4bd6kNzfxzSRdh5XBXhx42mlWkVZsxXN23e44OizEU
 R3uiI8zTN1wtD1EMm6INDmYx6xievFVHyItnoZSK1JnY9LO8bqh5LS0xfpzNHyc05U5R
 KlNg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1706543189; x=1707147989;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=OO1Xd496GZU9VnfGz8L9/dfv4mIbaz4PPUfJmAWvi4E=;
 b=CNuxS1RjcEizLPxrMQ8MPFVCFf9nFC6SQsse3jEvT+e8w68zdRn9yEfBFRh/HP4oUp
 zXjlVZUG4TZydR22GWbZmdZYY5/a6DCkeIJdkvXL0aaSeqFEHWKuxgn+dH+9kIc/QipP
 uOcIOGn4HiReRPIQ7ENiBCak48XCSUkct9NkPDsSzLnGt3E1LKU1+GaeKIJ/kOT5jjja
 sVp5xHV6WH03e3wYEHhzvjabXNDM7nEMKB8I5Tc0kxpp7646AZp68TtQcjh480ETYitf
 i//6b2vmbIC7jK65KmTu5A7MbhVbDz5wvaR7yuLaMjUiDIr0Yr9BaspkWuK8LBr/cna5
 ntwQ==
X-Gm-Message-State: AOJu0YyA7teKgKaU914lNf81y73pi01v2I3XyCJM0uyuxU6PyHP8tfbP
 qGAIQZbkyiVzcsNKkvUBPXEdCgFtBKz2QvQRv7M10J2L4YNPhcXeWvBI2q1p1lUV+yu7chAAyal
 N6uM=
X-Google-Smtp-Source: AGHT+IEbhvq46WfB26KVKDoPqwu7uC6IFLXmRvAJVSOMGlQWMYSorr/E+rcAzgUP67285OgCXI9Iaw==
X-Received: by 2002:a05:600c:5108:b0:40e:f14c:e1a6 with SMTP id
 o8-20020a05600c510800b0040ef14ce1a6mr3889537wms.6.1706543189201; 
 Mon, 29 Jan 2024 07:46:29 -0800 (PST)
Received: from localhost.localdomain (adsl-101.109.242.224.tellas.gr.
 [109.242.224.101]) by smtp.gmail.com with ESMTPSA id
 h15-20020a05600016cf00b0033aedfc5581sm2852608wrf.32.2024.01.29.07.46.27
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 29 Jan 2024 07:46:28 -0800 (PST)
From: Manos Pitsidianakis <manos.pitsidianakis@linaro.org>
To: qemu-devel@nongnu.org
Cc: =?UTF-8?q?Marc-Andr=C3=A9=20Lureau?= <marcandre.lureau@gmail.com>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Gerd Hoffmann <kraxel@redhat.com>, "Michael S. Tsirkin" <mst@redhat.com>,
 Gurchetan Singh <gurchetansingh@chromium.org>, Alyssa Ross <hi@alyssa.is>
Subject: [PATCH v2 2/3] virtio-gpu.c: add resource_destroy class method
Date: Mon, 29 Jan 2024 17:45:24 +0200
Message-Id: <78b15e8f7e2af529aeaed2e6ef37efa508cf405f.1706542958.git.manos.pitsidianakis@linaro.org>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <cover.1706542958.git.manos.pitsidianakis@linaro.org>
References: <cover.1706542958.git.manos.pitsidianakis@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::32a;
 envelope-from=manos.pitsidianakis@linaro.org; helo=mail-wm1-x32a.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
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

When destroying/unrefing resources, devices such as virtio-gpu-rutabaga
need to do their own bookkeeping (free rutabaga resources that are
associated with the virtio_gpu_simple_resource).

This commit adds a class method so that virtio-gpu-rutabaga can override
it in the next commit.

Signed-off-by: Manos Pitsidianakis <manos.pitsidianakis@linaro.org>
---
 include/hw/virtio/virtio-gpu.h |  3 +++
 hw/display/virtio-gpu.c        | 25 ++++++++++++++++++++++---
 2 files changed, 25 insertions(+), 3 deletions(-)

diff --git a/include/hw/virtio/virtio-gpu.h b/include/hw/virtio/virtio-gpu.h
index 584ba2ed73..b28e7ef0d2 100644
--- a/include/hw/virtio/virtio-gpu.h
+++ b/include/hw/virtio/virtio-gpu.h
@@ -219,6 +219,9 @@ struct VirtIOGPUClass {
     void (*update_cursor_data)(VirtIOGPU *g,
                                struct virtio_gpu_scanout *s,
                                uint32_t resource_id);
+    void (*resource_destroy)(VirtIOGPU *g,
+                             struct virtio_gpu_simple_resource *res,
+                             Error **errp);
 };
 
 struct VirtIOGPUGL {
diff --git a/hw/display/virtio-gpu.c b/hw/display/virtio-gpu.c
index 2b73ae585b..1c1ee230b3 100644
--- a/hw/display/virtio-gpu.c
+++ b/hw/display/virtio-gpu.c
@@ -402,7 +402,8 @@ static void virtio_gpu_disable_scanout(VirtIOGPU *g, int scanout_id)
 }
 
 static void virtio_gpu_resource_destroy(VirtIOGPU *g,
-                                        struct virtio_gpu_simple_resource *res)
+                                        struct virtio_gpu_simple_resource *res,
+                                        Error **errp)
 {
     int i;
 
@@ -438,7 +439,11 @@ static void virtio_gpu_resource_unref(VirtIOGPU *g,
         cmd->error = VIRTIO_GPU_RESP_ERR_INVALID_RESOURCE_ID;
         return;
     }
-    virtio_gpu_resource_destroy(g, res);
+    /*
+     * virtio_gpu_resource_destroy does not set any errors, so pass a NULL errp
+     * to ignore them.
+     */
+    virtio_gpu_resource_destroy(g, res, NULL);
 }
 
 static void virtio_gpu_transfer_to_host_2d(VirtIOGPU *g,
@@ -1488,11 +1493,24 @@ static void virtio_gpu_device_unrealize(DeviceState *qdev)
 static void virtio_gpu_reset_bh(void *opaque)
 {
     VirtIOGPU *g = VIRTIO_GPU(opaque);
+    VirtIOGPUClass *vgc = VIRTIO_GPU_GET_CLASS(g);
     struct virtio_gpu_simple_resource *res, *tmp;
+    uint32_t resource_id;
+    Error *local_err = NULL;
     int i = 0;
 
     QTAILQ_FOREACH_SAFE(res, &g->reslist, next, tmp) {
-        virtio_gpu_resource_destroy(g, res);
+        resource_id = res->resource_id;
+        vgc->resource_destroy(g, res, &local_err);
+        if (local_err) {
+            error_append_hint(&local_err, "%s: %s resource_destroy"
+                              "for resource_id = %"PRIu32" failed.\n",
+                              __func__, object_get_typename(OBJECT(g)),
+                              resource_id);
+            /* error_report_err frees the error object for us */
+            error_report_err(local_err);
+            local_err = NULL;
+        }
     }
 
     for (i = 0; i < g->parent_obj.conf.max_outputs; i++) {
@@ -1632,6 +1650,7 @@ static void virtio_gpu_class_init(ObjectClass *klass, void *data)
     vgc->handle_ctrl = virtio_gpu_handle_ctrl;
     vgc->process_cmd = virtio_gpu_simple_process_cmd;
     vgc->update_cursor_data = virtio_gpu_update_cursor_data;
+    vgc->resource_destroy = virtio_gpu_resource_destroy;
     vgbc->gl_flushed = virtio_gpu_handle_gl_flushed;
 
     vdc->realize = virtio_gpu_device_realize;
-- 
γαῖα πυρί μιχθήτω


