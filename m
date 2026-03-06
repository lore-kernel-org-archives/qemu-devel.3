Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id BE67DFCC066
	for <qemu-devel@archiver.kernel.org>; Fri,  6 Mar 2026 19:52:22 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vybDS-0006J3-OS; Fri, 06 Mar 2026 14:52:06 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1vybCO-0004CW-1O
 for qemu-devel@nongnu.org; Fri, 06 Mar 2026 14:51:02 -0500
Received: from mail-wm1-x329.google.com ([2a00:1450:4864:20::329])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1vybCL-0000QL-9p
 for qemu-devel@nongnu.org; Fri, 06 Mar 2026 14:50:59 -0500
Received: by mail-wm1-x329.google.com with SMTP id
 5b1f17b1804b1-4852a9c6309so4261835e9.0
 for <qemu-devel@nongnu.org>; Fri, 06 Mar 2026 11:50:56 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1772826655; x=1773431455; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=jx8Lc4PU9gFc5YSQurhHft6B2Pg7POf9lPTDKPwGiY8=;
 b=dIEnuew42qO3M49KQczvamTkWMCh7rQAhHsVbE1pcGT2MRFGRGFxOZKF0JbTw0Rg36
 cqZGhDhLJuWG8QQVuehtOhRPdk4fWehd9mhU/n9EXeR9NYow6SusYqjE5WGLzunTfcw5
 GTbfSODgcWLIkDAQx5UKLmMdwYaNi/gDZgOge5ztLC5K6nboQNBw4zzD1XIL6zEOP7Gk
 82fPsPKV6Ewntekez09OuZPK+Ttf8VxMQO/p2wwTGH9YGQCaPxCLAG8p8b9fqQ4xtoq7
 7bmTWbZbXAD2LHwSJabeWu4EyjzzEvLMWrF9+5leSB93GcjCQaQx+mXbpaAjgxwbbFmP
 XuXg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1772826655; x=1773431455;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=jx8Lc4PU9gFc5YSQurhHft6B2Pg7POf9lPTDKPwGiY8=;
 b=pz2xFONiW7f1afOwZraq5hZNlFV1Sk44qwffBlqP3B8Mr/rgdX2FBoxiCAwlDwnpon
 ZHT69DTGFqCSWQjns8l+WzZZeXfUkkKPZG3cjTByxboKSNKnUqM9ceQBhLkFyyuCvdIg
 YNcoDAyGDF+FN1ykAtlE2aVOA1en3aWZBgCadl+bBBUF/+l0DVv3yEP6zKijvOjJrNv/
 h9uXUH1Xt6I6lbVxmjxVjlTS8Jw51Zgc2du/GTyOgyOW7WL/1GEAwBCQOBvR+yOegwy0
 JcOaZDLoWW7xJXVl5zjTMk5BJpdkZfrKW9OskYOUmtXlPY8L6n6E/WbnQi7XNG0dJ2K8
 t4dQ==
X-Gm-Message-State: AOJu0YyzM4RWCOd8vVAy7mcFZ8tA+YhqJa2L+dHUpItYuC/9Xl2dTBE7
 B6XAITaMeQo1QEpFJp6BTOzzdaVHT2h/8JW9pfl1RfJuUpmzFy+yGhCweLRemlvjZ8I=
X-Gm-Gg: ATEYQzxW3No7OjmFX8yx2QqsNXvK/Ig0VD/pLWXP4iSdINKk/yVkAJLaDtV3PzhMEy/
 px3wZjZ0/tAPiyLunbighMgZjvBxpQvx1yTlDUJnJwWYjIkbVDaP6Q6VYXi0U0lmfi0BfGZeUQO
 6OzSipLgRXcS3YIH6INkv4J7UM0c1/+O22l5kDLPzBvutCk5XdWSVGV+PixZLh0q/h1G5rcfDz3
 z1XI1GemQbrLhJRDcO3/gEZdIsoiBf+wG7EFP9JO3Dhkr9OL+I50b3YLePI1wkoJ6b0wNpcuyI+
 MbvfUfheZUvybodUkPf4cZDmBXBMFB/RpoTH3Gc838h3T1Xg0wYerOHPR9hD/qdvj9HJwJLQRDi
 6MZ0ZQhX+5Ee3VvsW8foV9dWfEFZzDZqgynXTjRT/ci0uwrkrhZfrtaOuSSdYxIZgykh55LyKvX
 4YYekmkgfiIift0O/tDwF2n3FYAS/8ngkxzQ==
X-Received: by 2002:a05:600c:609a:b0:477:63a4:88fe with SMTP id
 5b1f17b1804b1-48526919691mr56836275e9.2.1772826654838; 
 Fri, 06 Mar 2026 11:50:54 -0800 (PST)
Received: from draig.lan ([185.124.0.126]) by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-485276b7571sm54152365e9.13.2026.03.06.11.50.52
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 06 Mar 2026 11:50:53 -0800 (PST)
Received: from draig.lan (localhost [IPv6:::1])
 by draig.lan (Postfix) with ESMTP id C2EFA689D8;
 Fri, 06 Mar 2026 19:50:49 +0000 (GMT)
From: =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>
To: qemu-devel@nongnu.org
Cc: Dmitry Osipenko <dmitry.osipenko@collabora.com>, qemu-stable@nongnu.org,
 =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>,
 Akihiko Odaki <odaki@rsg.ci.i.u-tokyo.ac.jp>,
 "Michael S. Tsirkin" <mst@redhat.com>
Subject: [PULL 09/20] virtio-gpu: Ensure BHs are invoked only from main-loop
 thread
Date: Fri,  6 Mar 2026 19:50:36 +0000
Message-ID: <20260306195048.2869788-10-alex.bennee@linaro.org>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <20260306195048.2869788-1-alex.bennee@linaro.org>
References: <20260306195048.2869788-1-alex.bennee@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::329;
 envelope-from=alex.bennee@linaro.org; helo=mail-wm1-x329.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=unavailable autolearn_force=no
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

From: Dmitry Osipenko <dmitry.osipenko@collabora.com>

QEMU's display GL core is tied to main-loop thread and virtio-gpu
interacts with display while processing GPU commands. Virtio-gpu BHs
work in generic AIO context that can be invoked on vCPU thread, while
GL and UI toolkits are bound to the main-loop thread.

Make virtio-gpu BHs use iohandler AIO context that is handled in a
main-loop thread only.

 0  SDL_GL_MakeCurrent() (libSDL3)
 1  SDL_GL_MakeCurrent_REAL() (libSDL2)
 2  sdl2_gl_make_context_current() (ui/sdl2-gl.c:201)
 3  make_current() (virglrenderer.c:639)
 4  vrend_finish_context_switch() (vrend_renderer.c:11630)
 5  vrend_hw_switch_context() (vrend_renderer.c:11613)
 6  vrend_renderer_force_ctx_0() (vrend_renderer.c:12986)
 7  virgl_renderer_force_ctx_0() (virglrenderer.c:460)
 8  virtio_gpu_virgl_process_cmd() (virtio-gpu-virgl.c:1013)
 9  virtio_gpu_process_cmdq() (virtio-gpu.c:1050)
 10 virtio_gpu_gl_handle_ctrl() (virtio-gpu-gl.c:86)
 11 aio_bh_poll() (util/async.c)
 12 aio_poll() (util/aio-posix.c)
 13 blk_pwrite() (block/block-gen.c:1985)
 14 pflash_update() (pflash_cfi01.c:396)
 15 pflash_write() (pflash_cfi01.c:541)
 16 memory_region_dispatch_write() (system/memory.c:1554)
 17 flatview_write() (system/physmem.c:3333)
 18 address_space_write() (system/physmem.c:3453)
 19 kvm_cpu_exec() (accel/kvm/kall-all.c:3248)
 20 kvm_vcpu_thread_fn() (accel/kvm/kaccel-ops.c:53)

Cc: qemu-stable@nongnu.org
Signed-off-by: Dmitry Osipenko <dmitry.osipenko@collabora.com>
Message-ID: <20260303151422.977399-8-dmitry.osipenko@collabora.com>
Message-ID: <20260304165043.1437519-10-alex.bennee@linaro.org>
Signed-off-by: Alex Bennée <alex.bennee@linaro.org>

diff --git a/include/hw/virtio/virtio.h b/include/hw/virtio/virtio.h
index 42d20899390..6344bd7b689 100644
--- a/include/hw/virtio/virtio.h
+++ b/include/hw/virtio/virtio.h
@@ -552,4 +552,14 @@ QEMUBH *virtio_bh_new_guarded_full(DeviceState *dev,
 #define virtio_bh_new_guarded(dev, cb, opaque) \
     virtio_bh_new_guarded_full((dev), (cb), (opaque), (stringify(cb)))
 
+/*
+ * The "_io" variant runs BH only on a main-loop thread, while generic BH
+ * may run on a vCPU thread.
+ */
+QEMUBH *virtio_bh_io_new_guarded_full(DeviceState *dev,
+                                      QEMUBHFunc *cb, void *opaque,
+                                      const char *name);
+#define virtio_bh_io_new_guarded(dev, cb, opaque) \
+    virtio_bh_io_new_guarded_full((dev), (cb), (opaque), (stringify(cb)))
+
 #endif
diff --git a/hw/display/virtio-gpu-virgl.c b/hw/display/virtio-gpu-virgl.c
index 0f754829fb7..10c4b5160f4 100644
--- a/hw/display/virtio-gpu-virgl.c
+++ b/hw/display/virtio-gpu-virgl.c
@@ -1203,9 +1203,9 @@ int virtio_gpu_virgl_init(VirtIOGPU *g)
     }
 
 #if VIRGL_VERSION_MAJOR >= 1
-    gl->cmdq_resume_bh = aio_bh_new(qemu_get_aio_context(),
-                                    virtio_gpu_virgl_resume_cmdq_bh,
-                                    g);
+    gl->cmdq_resume_bh = virtio_bh_io_new_guarded(DEVICE(g),
+                                                  virtio_gpu_virgl_resume_cmdq_bh,
+                                                  g);
 #endif
 
     return 0;
diff --git a/hw/display/virtio-gpu.c b/hw/display/virtio-gpu.c
index b2af861f0d8..a89d49aa8cc 100644
--- a/hw/display/virtio-gpu.c
+++ b/hw/display/virtio-gpu.c
@@ -1526,9 +1526,9 @@ void virtio_gpu_device_realize(DeviceState *qdev, Error **errp)
 
     g->ctrl_vq = virtio_get_queue(vdev, 0);
     g->cursor_vq = virtio_get_queue(vdev, 1);
-    g->ctrl_bh = virtio_bh_new_guarded(qdev, virtio_gpu_ctrl_bh, g);
-    g->cursor_bh = virtio_bh_new_guarded(qdev, virtio_gpu_cursor_bh, g);
-    g->reset_bh = qemu_bh_new(virtio_gpu_reset_bh, g);
+    g->ctrl_bh = virtio_bh_io_new_guarded(qdev, virtio_gpu_ctrl_bh, g);
+    g->cursor_bh = virtio_bh_io_new_guarded(qdev, virtio_gpu_cursor_bh, g);
+    g->reset_bh = virtio_bh_io_new_guarded(qdev, virtio_gpu_reset_bh, g);
     qemu_cond_init(&g->reset_cond);
     QTAILQ_INIT(&g->reslist);
     QTAILQ_INIT(&g->cmdq);
diff --git a/hw/virtio/virtio.c b/hw/virtio/virtio.c
index 22d798e6cdd..4c5a4479bfa 100644
--- a/hw/virtio/virtio.c
+++ b/hw/virtio/virtio.c
@@ -4497,3 +4497,13 @@ QEMUBH *virtio_bh_new_guarded_full(DeviceState *dev,
     return qemu_bh_new_full(cb, opaque, name,
                             &transport->mem_reentrancy_guard);
 }
+
+QEMUBH *virtio_bh_io_new_guarded_full(DeviceState *dev,
+                                      QEMUBHFunc *cb, void *opaque,
+                                      const char *name)
+{
+    DeviceState *transport = qdev_get_parent_bus(dev)->parent;
+
+    return aio_bh_new_full(iohandler_get_aio_context(), cb, opaque, name,
+                           &transport->mem_reentrancy_guard);
+}
-- 
2.47.3


