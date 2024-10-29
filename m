Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 50758D2AB30
	for <qemu-devel@archiver.kernel.org>; Tue, 29 Oct 2024 12:12:50 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1t5l3m-0004el-Kh; Tue, 29 Oct 2024 08:10:54 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1t5l3W-0004Ze-JH
 for qemu-devel@nongnu.org; Tue, 29 Oct 2024 08:10:38 -0400
Received: from mail-wm1-x32c.google.com ([2a00:1450:4864:20::32c])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1t5l3U-0007SF-ND
 for qemu-devel@nongnu.org; Tue, 29 Oct 2024 08:10:38 -0400
Received: by mail-wm1-x32c.google.com with SMTP id
 5b1f17b1804b1-431688d5127so52139115e9.0
 for <qemu-devel@nongnu.org>; Tue, 29 Oct 2024 05:10:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1730203835; x=1730808635; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=P5phWhGoDCJYI2vf4vKZn7wKxwIMi3ZojG0/RvNfBVE=;
 b=hC4TpEVZkf//MdfuJ+KojrnG+rwK+TsCl+mklPCa4TrlXwqt+CbjwswiwENosw1sRJ
 0QKXofIrUdsU2n9ymc3PGPt58QOGOFwzKRpfBqvwUuyA4zDd9aWgdY5kh56BWgiteRb6
 psZ7qBno+o3pmeOqBW42ASXB7r9pxCELHr3E8y8DRqMin/Is3U59MYAG9tQvebc5F4sd
 j96BjJ8SUCf84IwZRmRrkEMhm8qclH4j3n2L9dguBJEscKxyYMQjhIRnrFVd6THCkyQw
 eFoLI/MoiQ+JrPImDt9g2Zf62RUHRsljfq7seVfkedwu6A8WlKPZtsDsqzUybUJdaBmQ
 XApQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1730203835; x=1730808635;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=P5phWhGoDCJYI2vf4vKZn7wKxwIMi3ZojG0/RvNfBVE=;
 b=cvZuPNwSz+qrt8w3Apvy6j53tWcjpqe3vJCLeE9ZDOOXDTsj2hbwH+xwSGOVr9aRQP
 yBjkPPCOivQKykTmBYWvxvFZJaKiAVhXCEBN4aFelfJ/GIx9C6cQPhfznRc02pRZXFC7
 LHLWZCYpa9sGvtCfplZ9XTqMJubRDHsepVCOG8ItzrmguWGzHslMDFH/uBccGJ462iJt
 5LDSJmPjIwfVyfuew5xSfmM6145Ap5dmSFt5zs0AvaYxOfbmimn563CzDS/WL8mGo/m3
 Fyx+pq94hPOGmzgiOScYaS9ax5YXAXnNkWa8moSpdEN9dzTM9IskVp8iaLamiWompL6O
 ZGAg==
X-Gm-Message-State: AOJu0YxcmnDQCA9R+xXtNglt2EHHKEC7/vsLmGA+RoKIizKdQPx59PTJ
 Pj+Zb0ZO9WNHdrM+ZjuGpg4N9evc5vjEz+uPOJNYxitqh48scq7TlTyH02oYtps=
X-Google-Smtp-Source: AGHT+IGuO+aJwa5R23vDVae25uLLv9UTtBQyan+hIuC9CkmWhaER1N+s11QjlHDVGdRzmLAu3XfRXg==
X-Received: by 2002:a05:600c:5118:b0:42c:de2f:da27 with SMTP id
 5b1f17b1804b1-4319ac6f848mr110887835e9.2.1730203834715; 
 Tue, 29 Oct 2024 05:10:34 -0700 (PDT)
Received: from draig.lan ([85.9.250.243]) by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-431935a4ad8sm142617555e9.23.2024.10.29.05.10.31
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 29 Oct 2024 05:10:31 -0700 (PDT)
Received: from draig.lan (localhost [IPv6:::1])
 by draig.lan (Postfix) with ESMTP id BBD1E5FAA0;
 Tue, 29 Oct 2024 12:10:30 +0000 (GMT)
From: =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>
To: qemu-devel@nongnu.org
Cc: Dmitry Osipenko <dmitry.osipenko@collabora.com>,
 =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>,
 "Michael S. Tsirkin" <mst@redhat.com>
Subject: [PULL 03/13] virtio-gpu: Move print_stats timer to VirtIOGPUGL
Date: Tue, 29 Oct 2024 12:10:20 +0000
Message-Id: <20241029121030.4007014-4-alex.bennee@linaro.org>
X-Mailer: git-send-email 2.39.5
In-Reply-To: <20241029121030.4007014-1-alex.bennee@linaro.org>
References: <20241029121030.4007014-1-alex.bennee@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::32c;
 envelope-from=alex.bennee@linaro.org; helo=mail-wm1-x32c.google.com
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

From: Dmitry Osipenko <dmitry.osipenko@collabora.com>

Move print_stats timer to VirtIOGPUGL for consistency with
cmdq_resume_bh and fence_poll that are used only by GL device.

Signed-off-by: Dmitry Osipenko <dmitry.osipenko@collabora.com>
Message-Id: <20241024210311.118220-4-dmitry.osipenko@collabora.com>
Signed-off-by: Alex Bennée <alex.bennee@linaro.org>

diff --git a/include/hw/virtio/virtio-gpu.h b/include/hw/virtio/virtio-gpu.h
index 48a67d662d..18b6c3b3a2 100644
--- a/include/hw/virtio/virtio-gpu.h
+++ b/include/hw/virtio/virtio-gpu.h
@@ -194,7 +194,6 @@ struct VirtIOGPU {
     uint64_t hostmem;
 
     bool processing_cmdq;
-    QEMUTimer *print_stats;
 
     uint32_t inflight;
     struct {
@@ -230,6 +229,7 @@ struct VirtIOGPUGL {
     bool renderer_reset;
 
     QEMUTimer *fence_poll;
+    QEMUTimer *print_stats;
 };
 
 struct VhostUserGPU {
diff --git a/hw/display/virtio-gpu-virgl.c b/hw/display/virtio-gpu-virgl.c
index 91dce90f91..a63d1f540f 100644
--- a/hw/display/virtio-gpu-virgl.c
+++ b/hw/display/virtio-gpu-virgl.c
@@ -574,6 +574,7 @@ static struct virgl_renderer_callbacks virtio_gpu_3d_cbs = {
 static void virtio_gpu_print_stats(void *opaque)
 {
     VirtIOGPU *g = opaque;
+    VirtIOGPUGL *gl = VIRTIO_GPU_GL(g);
 
     if (g->stats.requests) {
         fprintf(stderr, "stats: vq req %4d, %3d -- 3D %4d (%5d)\n",
@@ -588,7 +589,7 @@ static void virtio_gpu_print_stats(void *opaque)
     } else {
         fprintf(stderr, "stats: idle\r");
     }
-    timer_mod(g->print_stats, qemu_clock_get_ms(QEMU_CLOCK_VIRTUAL) + 1000);
+    timer_mod(gl->print_stats, qemu_clock_get_ms(QEMU_CLOCK_VIRTUAL) + 1000);
 }
 
 static void virtio_gpu_fence_poll(void *opaque)
@@ -651,9 +652,10 @@ int virtio_gpu_virgl_init(VirtIOGPU *g)
                                   virtio_gpu_fence_poll, g);
 
     if (virtio_gpu_stats_enabled(g->parent_obj.conf)) {
-        g->print_stats = timer_new_ms(QEMU_CLOCK_VIRTUAL,
-                                      virtio_gpu_print_stats, g);
-        timer_mod(g->print_stats, qemu_clock_get_ms(QEMU_CLOCK_VIRTUAL) + 1000);
+        gl->print_stats = timer_new_ms(QEMU_CLOCK_VIRTUAL,
+                                       virtio_gpu_print_stats, g);
+        timer_mod(gl->print_stats,
+                  qemu_clock_get_ms(QEMU_CLOCK_VIRTUAL) + 1000);
     }
     return 0;
 }
-- 
2.39.5


