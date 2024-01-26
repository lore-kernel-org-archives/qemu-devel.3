Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7EE25C47422
	for <qemu-devel@archiver.kernel.org>; Fri, 26 Jan 2024 14:42:52 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rTNPi-0003sb-CL; Fri, 26 Jan 2024 09:42:38 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <manos.pitsidianakis@linaro.org>)
 id 1rTNPg-0003nD-5b
 for qemu-devel@nongnu.org; Fri, 26 Jan 2024 09:42:36 -0500
Received: from mail-ed1-x530.google.com ([2a00:1450:4864:20::530])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <manos.pitsidianakis@linaro.org>)
 id 1rTNPe-0001Sb-Dg
 for qemu-devel@nongnu.org; Fri, 26 Jan 2024 09:42:35 -0500
Received: by mail-ed1-x530.google.com with SMTP id
 4fb4d7f45d1cf-55817a12ad8so341684a12.2
 for <qemu-devel@nongnu.org>; Fri, 26 Jan 2024 06:42:33 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1706280152; x=1706884952; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=YRomrCy8IeTekhDJYOH7WoAUevPbXUg88RTgcJFKTB0=;
 b=nGyEa9rat7slr0PqpIaTxu2aSdLe2/7gdhpdqTCFz4UEBU3nK96In4bky7ID9gi4T5
 zQMigDNmbtrrKI7XM8Sr/4DbzwOmYWZXZalwXh51cqM+5wRkn96UikIEcKgrwLq7OS7q
 38aanHYry38udct9SmriWhxlkxUabIf8fOhI97ckp5nAU/eeRi2EQt5SOMi7M2KUtRp9
 MgYfrxy083C00lV0ItRbZOfJOxFLVJJMvgH5qaZh79vglledSuw6BlklW50Sq0aaaS+D
 2bUIm97U3wiskRAT357SBRJWK2UqKYpjWnuTrIT1XGpN643hAluvx7JjTfVuYmN7/M9W
 W62g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1706280152; x=1706884952;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=YRomrCy8IeTekhDJYOH7WoAUevPbXUg88RTgcJFKTB0=;
 b=r9MC0bIYrAfAKDeFYqGZ9pDCjqp//FmYdmBOteDn9CY+hg6JAUftTOVaIQwM4UYuTm
 nEKhqU1iN3o5VkFoxOoILQ9WPZ1pWhR5Spw1qPhGnLcL7IG3TZSsh04ZrW+35L5Ml1XA
 1wrx8tOyRoQt4xXu2Inx5EgqtCFgrJqua293boy8A+aUBNHjlsGijoaFxyqninojQ8eB
 AfdzmUHYH2mvO3PtgjbzfxrmnTGqpFWIPMS2AwIOueOJ785Umm2ZCkk2HeoMtQ3RDzYT
 YIlmnY5Fg2TNmTuuW1LyA9TdHUCcH2sGq4kFuL8LLaEdqsGGshKYsILFlT6l5ssYI2C+
 YX8g==
X-Gm-Message-State: AOJu0YwbVE7QjF8rU+rWciMI9zHAGBfQg+yarjW/yU3Wz1Uf/8R3FM5p
 SErxgmBwz67gfVHefXseKFGQ4NpmW+evtSbu+cacRqSQiEJzINgFNMxOhMlu1rchNK1kjAFQfS8
 ALIA=
X-Google-Smtp-Source: AGHT+IHNIWgmlYJeROz+iV92mYwBMd78GXiTOKu5EbTU6koJT/9Gh88Sg3EDtSfD9Ar2GzY/JenQ+w==
X-Received: by 2002:a17:906:7fd5:b0:a30:a9bc:5a15 with SMTP id
 r21-20020a1709067fd500b00a30a9bc5a15mr907517ejs.20.1706280152018; 
 Fri, 26 Jan 2024 06:42:32 -0800 (PST)
Received: from localhost.localdomain (adsl-114.109.242.225.tellas.gr.
 [109.242.225.114]) by smtp.gmail.com with ESMTPSA id
 ox27-20020a170907101b00b00a3221b95ce8sm699168ejb.77.2024.01.26.06.42.30
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 26 Jan 2024 06:42:31 -0800 (PST)
From: Manos Pitsidianakis <manos.pitsidianakis@linaro.org>
To: qemu-devel@nongnu.org
Cc: Gerd Hoffmann <kraxel@redhat.com>, "Michael S. Tsirkin" <mst@redhat.com>,
 Gurchetan Singh <gurchetansingh@chromium.org>, Alyssa Ross <hi@alyssa.is>
Subject: [PATCH v1 3/3] virtio-gpu-rutabaga.c: override resource_destroy method
Date: Fri, 26 Jan 2024 16:41:50 +0200
Message-Id: <5dc2d365fa4f88c7b5761f1032e1ea505d6b7e86.1706279540.git.manos.pitsidianakis@linaro.org>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <cover.1706279540.git.manos.pitsidianakis@linaro.org>
References: <cover.1706279540.git.manos.pitsidianakis@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::530;
 envelope-from=manos.pitsidianakis@linaro.org; helo=mail-ed1-x530.google.com
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

When the Rutabaga GPU device frees resources, it calls
rutabaga_resource_unref for that resource_id. However, when the generic
VirtIOGPU functions destroys resources, it only removes the
virtio_gpu_simple_resource from the device's VirtIOGPU->reslist list.
The rutabaga resource associated with that resource_id is then leaked.

This commit overrides the resource_destroy class method introduced in
the previous commit to fix this.

Signed-off-by: Manos Pitsidianakis <manos.pitsidianakis@linaro.org>
---
 hw/display/virtio-gpu-rutabaga.c | 31 ++++++++++++++++++++-----------
 1 file changed, 20 insertions(+), 11 deletions(-)

diff --git a/hw/display/virtio-gpu-rutabaga.c b/hw/display/virtio-gpu-rutabaga.c
index 9e67f9bd51..66b5a115ac 100644
--- a/hw/display/virtio-gpu-rutabaga.c
+++ b/hw/display/virtio-gpu-rutabaga.c
@@ -147,6 +147,24 @@ rutabaga_cmd_create_resource_3d(VirtIOGPU *g,
     QTAILQ_INSERT_HEAD(&g->reslist, res, next);
 }
 
+static int32_t
+virtio_gpu_rutabaga_resource_unref(VirtIOGPU *g,
+                                   struct virtio_gpu_simple_resource *res)
+{
+    int32_t result;
+    VirtIOGPURutabaga *vr = VIRTIO_GPU_RUTABAGA(g);
+
+    result = rutabaga_resource_unref(vr->rutabaga, res->resource_id);
+
+    if (res->image) {
+        pixman_image_unref(res->image);
+    }
+
+    QTAILQ_REMOVE(&g->reslist, res, next);
+    g_free(res);
+    return result;
+}
+
 static void
 rutabaga_cmd_resource_unref(VirtIOGPU *g,
                             struct virtio_gpu_ctrl_command *cmd)
@@ -155,8 +173,6 @@ rutabaga_cmd_resource_unref(VirtIOGPU *g,
     struct virtio_gpu_simple_resource *res;
     struct virtio_gpu_resource_unref unref;
 
-    VirtIOGPURutabaga *vr = VIRTIO_GPU_RUTABAGA(g);
-
     VIRTIO_GPU_FILL_CMD(unref);
 
     trace_virtio_gpu_cmd_res_unref(unref.resource_id);
@@ -164,15 +180,8 @@ rutabaga_cmd_resource_unref(VirtIOGPU *g,
     res = virtio_gpu_find_resource(g, unref.resource_id);
     CHECK(res, cmd);
 
-    result = rutabaga_resource_unref(vr->rutabaga, unref.resource_id);
+    result = virtio_gpu_rutabaga_resource_unref(g, res);
     CHECK(!result, cmd);
-
-    if (res->image) {
-        pixman_image_unref(res->image);
-    }
-
-    QTAILQ_REMOVE(&g->reslist, res, next);
-    g_free(res);
 }
 
 static void
@@ -1099,7 +1108,7 @@ static void virtio_gpu_rutabaga_class_init(ObjectClass *klass, void *data)
     vgc->handle_ctrl = virtio_gpu_rutabaga_handle_ctrl;
     vgc->process_cmd = virtio_gpu_rutabaga_process_cmd;
     vgc->update_cursor_data = virtio_gpu_rutabaga_update_cursor;
-
+    vgc->resource_destroy = virtio_gpu_rutabaga_resource_unref;
     vdc->realize = virtio_gpu_rutabaga_realize;
     device_class_set_props(dc, virtio_gpu_rutabaga_properties);
 }
-- 
γαῖα πυρί μιχθήτω


