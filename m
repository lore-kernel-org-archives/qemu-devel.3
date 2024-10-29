Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id DB1CCD2AB2F
	for <qemu-devel@archiver.kernel.org>; Tue, 29 Oct 2024 12:12:34 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1t5l3Y-0004a0-HS; Tue, 29 Oct 2024 08:10:40 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1t5l3U-0004Yz-VF
 for qemu-devel@nongnu.org; Tue, 29 Oct 2024 08:10:36 -0400
Received: from mail-wm1-x333.google.com ([2a00:1450:4864:20::333])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1t5l3S-0007Rl-3r
 for qemu-devel@nongnu.org; Tue, 29 Oct 2024 08:10:36 -0400
Received: by mail-wm1-x333.google.com with SMTP id
 5b1f17b1804b1-4314f38d274so70709375e9.1
 for <qemu-devel@nongnu.org>; Tue, 29 Oct 2024 05:10:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1730203832; x=1730808632; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=pUPdzr3axCBtNpWLG3/6d3bv+WC8e9tr/zVd9fr5GLY=;
 b=Re6vA2H9Vm+RXwhXvWRSzB+j5lGhtNddfsDFhvwFbPueJx4TbQH6RvV6YwtEMThUdv
 5K5OYlxP6Ps7l9TfrVoGXl31MBHPZYgZpqkvL7eAVAoxX9Ii8IXlF7xFIFVv/sxqYKXF
 xgKVwdLmkFcQnfr/4hQBVyNryvgtNu3msb1My32ALOIhxf3WIKSiv86UOhAxl1tGWwtj
 Y1jdy4RT1v+Hauhk2YiMFnN3YCAmt623SKg51ubDyZDwTlv547KFhHQieJSJJkhgCJqg
 pq1D+fUZj0ud0l1J3vRfpI/mgiiVAVrhlYfqoOsayKecN2vR4K5QmhQsOMuGI9g/w3e7
 7zEA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1730203832; x=1730808632;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=pUPdzr3axCBtNpWLG3/6d3bv+WC8e9tr/zVd9fr5GLY=;
 b=PNpxk2e0b5KTa4eCTDxGTvzror8H1uYHNHrlbvrreCSy9lot44E0Eozbiy1iXTX9tp
 0AU09YBijM765uON/XKkYBlxSpk/syiPaxp1mOEa4n/pCp7mf5iS4IzM4On2xOG7pgux
 x9h6W4aRxGdCwIWCt2TemwFrgCxYNI9QpHOtvTmAbHrLGTWj5qDSCivkjMFv+sHjcNRQ
 1scxGpBnGqrwgKf3j3iSYjV0BYUV0DR/PKdO4zaXklQLfLU+k+/mjqe4sPa5kpsM4wrm
 jx1Hj6Buae00V4IK8U+Z1oZsk4f9G7JupoEnr3vehSiJ95UEaUHrfJ8+/ITlyHoywdgL
 v7Ug==
X-Gm-Message-State: AOJu0YyHx0WLFWFFiL7DQLDmgAsq578u0bxwfzz9ZWsytpziMAien6K9
 QkQiPnDJUbHQHOcnX7Jy9KPBBZeWd2PYg/uSYjO7OtMrxFG9tKHiZpYuIRC0Ezs=
X-Google-Smtp-Source: AGHT+IG1tiGow53VxMw8x2rFsV4CPG2Fbzhmcv/Jf5RwxLv6Nv4NgMlv33bpPuWM/hy28o5cWT4KvA==
X-Received: by 2002:a05:600c:1910:b0:431:5c3d:1700 with SMTP id
 5b1f17b1804b1-4319acadd83mr130824285e9.21.1730203832051; 
 Tue, 29 Oct 2024 05:10:32 -0700 (PDT)
Received: from draig.lan ([85.9.250.243]) by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-4318b5797c3sm172938845e9.40.2024.10.29.05.10.31
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 29 Oct 2024 05:10:31 -0700 (PDT)
Received: from draig.lan (localhost [IPv6:::1])
 by draig.lan (Postfix) with ESMTP id A704F5FA99;
 Tue, 29 Oct 2024 12:10:30 +0000 (GMT)
From: =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>
To: qemu-devel@nongnu.org
Cc: Dmitry Osipenko <dmitry.osipenko@collabora.com>,
 =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>,
 "Michael S. Tsirkin" <mst@redhat.com>
Subject: [PULL 02/13] virtio-gpu: Move fence_poll timer to VirtIOGPUGL
Date: Tue, 29 Oct 2024 12:10:19 +0000
Message-Id: <20241029121030.4007014-3-alex.bennee@linaro.org>
X-Mailer: git-send-email 2.39.5
In-Reply-To: <20241029121030.4007014-1-alex.bennee@linaro.org>
References: <20241029121030.4007014-1-alex.bennee@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::333;
 envelope-from=alex.bennee@linaro.org; helo=mail-wm1-x333.google.com
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

Move fence_poll timer to VirtIOGPUGL for consistency with cmdq_resume_bh
that are used only by GL device.

Signed-off-by: Dmitry Osipenko <dmitry.osipenko@collabora.com>
Message-Id: <20241024210311.118220-3-dmitry.osipenko@collabora.com>
Signed-off-by: Alex Bennée <alex.bennee@linaro.org>

diff --git a/include/hw/virtio/virtio-gpu.h b/include/hw/virtio/virtio-gpu.h
index e343110e23..48a67d662d 100644
--- a/include/hw/virtio/virtio-gpu.h
+++ b/include/hw/virtio/virtio-gpu.h
@@ -194,7 +194,6 @@ struct VirtIOGPU {
     uint64_t hostmem;
 
     bool processing_cmdq;
-    QEMUTimer *fence_poll;
     QEMUTimer *print_stats;
 
     uint32_t inflight;
@@ -229,6 +228,8 @@ struct VirtIOGPUGL {
 
     bool renderer_inited;
     bool renderer_reset;
+
+    QEMUTimer *fence_poll;
 };
 
 struct VhostUserGPU {
diff --git a/hw/display/virtio-gpu-virgl.c b/hw/display/virtio-gpu-virgl.c
index 14091b191e..91dce90f91 100644
--- a/hw/display/virtio-gpu-virgl.c
+++ b/hw/display/virtio-gpu-virgl.c
@@ -594,11 +594,12 @@ static void virtio_gpu_print_stats(void *opaque)
 static void virtio_gpu_fence_poll(void *opaque)
 {
     VirtIOGPU *g = opaque;
+    VirtIOGPUGL *gl = VIRTIO_GPU_GL(g);
 
     virgl_renderer_poll();
     virtio_gpu_process_cmdq(g);
     if (!QTAILQ_EMPTY(&g->cmdq) || !QTAILQ_EMPTY(&g->fenceq)) {
-        timer_mod(g->fence_poll, qemu_clock_get_ms(QEMU_CLOCK_VIRTUAL) + 10);
+        timer_mod(gl->fence_poll, qemu_clock_get_ms(QEMU_CLOCK_VIRTUAL) + 10);
     }
 }
 
@@ -626,6 +627,7 @@ int virtio_gpu_virgl_init(VirtIOGPU *g)
 {
     int ret;
     uint32_t flags = 0;
+    VirtIOGPUGL *gl = VIRTIO_GPU_GL(g);
 
 #if VIRGL_RENDERER_CALLBACKS_VERSION >= 4
     if (qemu_egl_display) {
@@ -645,8 +647,8 @@ int virtio_gpu_virgl_init(VirtIOGPU *g)
         return ret;
     }
 
-    g->fence_poll = timer_new_ms(QEMU_CLOCK_VIRTUAL,
-                                 virtio_gpu_fence_poll, g);
+    gl->fence_poll = timer_new_ms(QEMU_CLOCK_VIRTUAL,
+                                  virtio_gpu_fence_poll, g);
 
     if (virtio_gpu_stats_enabled(g->parent_obj.conf)) {
         g->print_stats = timer_new_ms(QEMU_CLOCK_VIRTUAL,
-- 
2.39.5


