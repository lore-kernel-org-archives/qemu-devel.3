Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9858CD2AB31
	for <qemu-devel@archiver.kernel.org>; Tue, 29 Oct 2024 12:11:13 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1t5l3k-0004dp-VZ; Tue, 29 Oct 2024 08:10:53 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1t5l3Z-0004at-HY
 for qemu-devel@nongnu.org; Tue, 29 Oct 2024 08:10:41 -0400
Received: from mail-lf1-x133.google.com ([2a00:1450:4864:20::133])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1t5l3X-0007Sz-Ai
 for qemu-devel@nongnu.org; Tue, 29 Oct 2024 08:10:41 -0400
Received: by mail-lf1-x133.google.com with SMTP id
 2adb3069b0e04-539f1292a9bso6285352e87.2
 for <qemu-devel@nongnu.org>; Tue, 29 Oct 2024 05:10:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1730203837; x=1730808637; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=Lowm4YyV2GElWtVAlyi9nUtaFHXu7/ajO637WhpLQKM=;
 b=xYVnIbC1ac2tJEgnUEHNJ5uDPzfWmZOspdwbWTOJZeSK7W1KaszhF8Tv1JuSlWW12Y
 xoqvrHwtSn3F7RO5dEr+WN2VgBW3mALQRrjUtkukKk389p6gg/ajflX3Ers02zwzYyk1
 Yxhk/yQkET3vSy2exjA99tc+rWOC9fSgQ8Zdc1Ojl0BEgGi27bLqeCF/E3PRfO175GZt
 NBnfoNDiveSzVzhytri2CpDCVlY6ig6yCXZo+/NyLSplIpw3L+sAl1tes0qnKIig+tzM
 PG4Ax5qkC2a/efXz/0Dvn0vW3LsqJJvNCJsCSbbHntVYDxlKeTJ/+tnZaTT6R6meRvzs
 R2Ig==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1730203837; x=1730808637;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=Lowm4YyV2GElWtVAlyi9nUtaFHXu7/ajO637WhpLQKM=;
 b=nl+IMkaj4CEBtM/KzVerhAz1J7DuRvGIwoQOePe5tRNC5Av+LMeEVlVAYzIKnqzj37
 GIxGi2SYMvAovPMMmYN3XOw7KG2ezOwZYvhcdSvjUBoZ+mITUAxBPr6qmtCFfLvxVdh/
 s0k9lBCVfQH8s9u/pI3QP5wNi77Fko9hGek0bNqtjvTyloot2LZ0e4PmZaqKpXPN+GFR
 p0gXpC7cEFsAVGO29Wzl6ZMSQBlYoiQ/U6xJFlqiRDa6LQUn11GV0wL7dGuhbqKJlMRf
 8yO5XFu6Up8vkHw+JQekudQvd6GDGREUG01xUtV/H4mFfDYTzx09f9rQoSoYea2WNKYb
 uuGQ==
X-Gm-Message-State: AOJu0YyDC46IDAyu18SjKEtcRig/XD+Jh5itfexF9WgI5BR+XNjimpaq
 zKM/YyYXRO6TDLdrJXnvG+EcBTr0wL9rNWAYux5KdYfx6rF2nQM6dEsT3yUYJio=
X-Google-Smtp-Source: AGHT+IGjTGDiRCVJEGBE/cC71k3FucS4hi/JgbbTrHBY1hEvAen5h8YiyW29FV5Mr80LPRlpKVmEcQ==
X-Received: by 2002:a05:6512:32c7:b0:539:a353:279c with SMTP id
 2adb3069b0e04-53b348d8f6cmr6306914e87.28.1730203837419; 
 Tue, 29 Oct 2024 05:10:37 -0700 (PDT)
Received: from draig.lan ([85.9.250.243]) by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-38058bb1bc3sm12200227f8f.110.2024.10.29.05.10.32
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 29 Oct 2024 05:10:34 -0700 (PDT)
Received: from draig.lan (localhost [IPv6:::1])
 by draig.lan (Postfix) with ESMTP id 2676B5FACF;
 Tue, 29 Oct 2024 12:10:31 +0000 (GMT)
From: =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>
To: qemu-devel@nongnu.org
Cc: Huang Rui <ray.huang@amd.com>,
 Antonio Caggiano <antonio.caggiano@collabora.com>,
 Antonio Caggiano <quic_acaggian@quicinc.com>,
 Dmitry Osipenko <dmitry.osipenko@collabora.com>,
 =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>,
 "Michael S. Tsirkin" <mst@redhat.com>
Subject: [PULL 07/13] virtio-gpu: Support context-init feature with
 virglrenderer
Date: Tue, 29 Oct 2024 12:10:24 +0000
Message-Id: <20241029121030.4007014-8-alex.bennee@linaro.org>
X-Mailer: git-send-email 2.39.5
In-Reply-To: <20241029121030.4007014-1-alex.bennee@linaro.org>
References: <20241029121030.4007014-1-alex.bennee@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::133;
 envelope-from=alex.bennee@linaro.org; helo=mail-lf1-x133.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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

From: Huang Rui <ray.huang@amd.com>

Patch "virtio-gpu: CONTEXT_INIT feature" has added the context_init
feature flags. Expose this feature and support creating virglrenderer
context with flags using context_id if libvirglrenderer is new enough.

Originally-by: Antonio Caggiano <antonio.caggiano@collabora.com>
Signed-off-by: Huang Rui <ray.huang@amd.com>
Reviewed-by: Antonio Caggiano <quic_acaggian@quicinc.com>
Signed-off-by: Dmitry Osipenko <dmitry.osipenko@collabora.com>
Message-Id: <20241024210311.118220-8-dmitry.osipenko@collabora.com>
Signed-off-by: Alex Bennée <alex.bennee@linaro.org>

diff --git a/hw/display/virtio-gpu-gl.c b/hw/display/virtio-gpu-gl.c
index 753b35ed69..bf87ba4232 100644
--- a/hw/display/virtio-gpu-gl.c
+++ b/hw/display/virtio-gpu-gl.c
@@ -147,6 +147,10 @@ static void virtio_gpu_gl_device_realize(DeviceState *qdev, Error **errp)
     VIRTIO_GPU_BASE(g)->virtio_config.num_capsets =
         virtio_gpu_virgl_get_num_capsets(g);
 
+#if VIRGL_VERSION_MAJOR >= 1
+    g->parent_obj.conf.flags |= 1 << VIRTIO_GPU_FLAG_CONTEXT_INIT_ENABLED;
+#endif
+
     virtio_gpu_device_realize(qdev, errp);
 }
 
diff --git a/hw/display/virtio-gpu-virgl.c b/hw/display/virtio-gpu-virgl.c
index ca6f4d6cbb..b3aa444bcf 100644
--- a/hw/display/virtio-gpu-virgl.c
+++ b/hw/display/virtio-gpu-virgl.c
@@ -106,8 +106,24 @@ static void virgl_cmd_context_create(VirtIOGPU *g,
     trace_virtio_gpu_cmd_ctx_create(cc.hdr.ctx_id,
                                     cc.debug_name);
 
-    virgl_renderer_context_create(cc.hdr.ctx_id, cc.nlen,
-                                  cc.debug_name);
+    if (cc.context_init) {
+        if (!virtio_gpu_context_init_enabled(g->parent_obj.conf)) {
+            qemu_log_mask(LOG_GUEST_ERROR, "%s: context_init disabled",
+                          __func__);
+            cmd->error = VIRTIO_GPU_RESP_ERR_UNSPEC;
+            return;
+        }
+
+#if VIRGL_VERSION_MAJOR >= 1
+        virgl_renderer_context_create_with_flags(cc.hdr.ctx_id,
+                                                 cc.context_init,
+                                                 cc.nlen,
+                                                 cc.debug_name);
+        return;
+#endif
+    }
+
+    virgl_renderer_context_create(cc.hdr.ctx_id, cc.nlen, cc.debug_name);
 }
 
 static void virgl_cmd_context_destroy(VirtIOGPU *g,
-- 
2.39.5


