Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id CEBC9FCC066
	for <qemu-devel@archiver.kernel.org>; Fri,  6 Mar 2026 19:52:08 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vybDE-0004te-4P; Fri, 06 Mar 2026 14:51:53 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1vybCT-0004DX-UR
 for qemu-devel@nongnu.org; Fri, 06 Mar 2026 14:51:07 -0500
Received: from mail-wm1-x32b.google.com ([2a00:1450:4864:20::32b])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1vybCQ-0000Rx-1x
 for qemu-devel@nongnu.org; Fri, 06 Mar 2026 14:51:03 -0500
Received: by mail-wm1-x32b.google.com with SMTP id
 5b1f17b1804b1-483a233819aso94836385e9.3
 for <qemu-devel@nongnu.org>; Fri, 06 Mar 2026 11:51:00 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1772826660; x=1773431460; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=gfe3K7QKeRshXSLGLqPywya5dd4X5MPIdqIvBVHRxYY=;
 b=XcEwnzOIk7U2iRKQlQ/Q7pZnrnaQ+z3RET2UJJcvdkuosp0/51Ik/40JhBZQl2zExo
 W/+M87x8elxbUgjv7sZVMZjJPUbE6MvxfpXtKxI9joIj+5k33H/sRe3/zJ0e5mIm9iz2
 l+DZwWTq9+SyspITjPPVFcQpWxc4FL39hJYo3HPfS4Ad+yr0IpBXjO1XCE5xw5kHLrN+
 4himvwGyt2CWQ9q0sRyTzh6Tg2MPXUItepmQBxNB8jAcAoAvl8Xxn4QN7NLe7H8sU2uW
 q1EYYVviUxzNsOBZPfBebW1cVpdADoc1qpw80vvGGNiXKbBtBYCg+cdEA5hs7T6zoWJW
 bSSg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1772826660; x=1773431460;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=gfe3K7QKeRshXSLGLqPywya5dd4X5MPIdqIvBVHRxYY=;
 b=IemlVMGXSSYMrkSGi55CsUip0msKjIcnlFD4Q7l2CkO74IJR+FFGss/xZePfKSI8cd
 wN1FPbDkbmhRWOT7McyP2GpuRbhoKiIrFPYh8kn8lLgN3SUsChuDmlIevDgvhR36hH0/
 rZ3fARSk1S+c9wxdny4EDdydrwBtXaGxp1oH5RtpsMKGGsFsFgoMSEzc++E6u9OhsK9P
 u8UGTw2x9RAun4UWb/hwe3Xd8UAcH0XwiB4FkI1KPVD5cucXYSfTH1D3FN7paUmopErH
 zRSbvUZeUnXEBR+m7JE0PacXymhh/Fx6Gdn69MqC1Sys9rB91UKPRssPZJLVmPPeeomM
 2+Hg==
X-Gm-Message-State: AOJu0Ywn6ooNzK+5V4NazXnvbn0Jgm6+pXziglHg3OHNvZovgTM6wnz2
 jrVCVzsOPBCoMlGWk0AUDTJk1qVoVwmcAwCAp1wagLg9mr8Hb2NYJED2shnCQEE7ZYk=
X-Gm-Gg: ATEYQzyRDjB3jHnkZhIGtF50tMzSI4t8gDbbhGW8vagLix4rg+6TY5kh5gR2R6bwzCH
 QeN2WpGWoGVPsKEBimNZ6KTbzhjyFwuXbZLjONLqpcBUqNjis8pz5yd07+qvyg55NgdcoZ2jyIe
 faL/AysnOoQJQyg7941Jh9KPUcNML78FZfa48yzplURLRBzHZoBF8ADthfqMoaDVsMOSWIVlMVo
 yjk5PnzX9tRucOEqWTCPhr4+khnwh31LQW+CcJ1ZY75cnYenSIf4CABZuwEoFG8FZRuGiIIS7sg
 0iR9AxqZwlbxDsqQhUe6z5R8R7EbEttujQ64v2pwmsr/ZN+3vc4u/1LFYpP8R4NoDnWi9nsdZ9w
 EBDvGvssudn0I0GEuPiqbWMkCVSunPDmP1W4WgxKLrbqari7rbMRFJCJ7xdEs2lVe0JashmBtcK
 I4LEP84K+hII+7DeS71yNfBxVcaMJz39FNrQ==
X-Received: by 2002:a05:600c:34d2:b0:483:badb:6191 with SMTP id
 5b1f17b1804b1-48526923595mr54794455e9.8.1772826659679; 
 Fri, 06 Mar 2026 11:50:59 -0800 (PST)
Received: from draig.lan ([185.124.0.126]) by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-4851fae00absm133406515e9.4.2026.03.06.11.50.52
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 06 Mar 2026 11:50:53 -0800 (PST)
Received: from draig.lan (localhost [IPv6:::1])
 by draig.lan (Postfix) with ESMTP id DA061689D9;
 Fri, 06 Mar 2026 19:50:49 +0000 (GMT)
From: =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>
To: qemu-devel@nongnu.org
Cc: Dmitry Osipenko <dmitry.osipenko@collabora.com>,
 Akihiko Odaki <akihiko.odaki@daynix.com>,
 "Michael S. Tsirkin" <mst@redhat.com>,
 =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>,
 Pierre-Eric Pelloux-Prayer <pierre-eric.pelloux-prayer@amd.com>,
 Yiwei Zhang <zzyiwei@gmail.com>,
 Akihiko Odaki <odaki@rsg.ci.i.u-tokyo.ac.jp>
Subject: [PULL 10/20] virtio-gpu: Handle virgl fence creation errors
Date: Fri,  6 Mar 2026 19:50:37 +0000
Message-ID: <20260306195048.2869788-11-alex.bennee@linaro.org>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <20260306195048.2869788-1-alex.bennee@linaro.org>
References: <20260306195048.2869788-1-alex.bennee@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::32b;
 envelope-from=alex.bennee@linaro.org; helo=mail-wm1-x32b.google.com
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

Print out error messages when virgl fence creation fails to aid debugging
of the fence-related bugs.

Reviewed-by: Akihiko Odaki <akihiko.odaki@daynix.com>
Acked-by: Michael S. Tsirkin <mst@redhat.com>
Tested-by: Alex Bennée <alex.bennee@linaro.org>
Acked-by: Pierre-Eric Pelloux-Prayer <pierre-eric.pelloux-prayer@amd.com>
Reviewed-by: Yiwei Zhang <zzyiwei@gmail.com>
Tested-by: Yiwei Zhang <zzyiwei@gmail.com>
Signed-off-by: Dmitry Osipenko <dmitry.osipenko@collabora.com>
Message-ID: <20260303151422.977399-9-dmitry.osipenko@collabora.com>
Message-ID: <20260304165043.1437519-11-alex.bennee@linaro.org>
Signed-off-by: Alex Bennée <alex.bennee@linaro.org>

diff --git a/hw/display/virtio-gpu-virgl.c b/hw/display/virtio-gpu-virgl.c
index 10c4b5160f4..f00c666f61f 100644
--- a/hw/display/virtio-gpu-virgl.c
+++ b/hw/display/virtio-gpu-virgl.c
@@ -900,6 +900,7 @@ void virtio_gpu_virgl_process_cmd(VirtIOGPU *g,
                                       struct virtio_gpu_ctrl_command *cmd)
 {
     bool cmd_suspended = false;
+    int ret;
 
     VIRTIO_GPU_FILL_CMD(cmd->cmd_hdr);
 
@@ -1000,14 +1001,30 @@ void virtio_gpu_virgl_process_cmd(VirtIOGPU *g,
     trace_virtio_gpu_fence_ctrl(cmd->cmd_hdr.fence_id, cmd->cmd_hdr.type);
 #if VIRGL_VERSION_MAJOR >= 1
     if (cmd->cmd_hdr.flags & VIRTIO_GPU_FLAG_INFO_RING_IDX) {
-        virgl_renderer_context_create_fence(cmd->cmd_hdr.ctx_id,
-                                            VIRGL_RENDERER_FENCE_FLAG_MERGEABLE,
-                                            cmd->cmd_hdr.ring_idx,
-                                            cmd->cmd_hdr.fence_id);
+        const uint32_t flags = VIRGL_RENDERER_FENCE_FLAG_MERGEABLE;
+
+        ret = virgl_renderer_context_create_fence(cmd->cmd_hdr.ctx_id, flags,
+                                                  cmd->cmd_hdr.ring_idx,
+                                                  cmd->cmd_hdr.fence_id);
+        if (ret) {
+            qemu_log_mask(LOG_GUEST_ERROR,
+                          "%s: virgl_renderer_context_create_fence error: %s",
+                          __func__, strerror(-ret));
+        }
         return;
     }
 #endif
-    virgl_renderer_create_fence(cmd->cmd_hdr.fence_id, cmd->cmd_hdr.type);
+
+    /*
+     * Unlike other virglrenderer functions, this one returns a positive
+     * error code.
+     */
+    ret = virgl_renderer_create_fence(cmd->cmd_hdr.fence_id, 0);
+    if (ret) {
+        qemu_log_mask(LOG_GUEST_ERROR,
+                      "%s: virgl_renderer_create_fence error: %s",
+                      __func__, strerror(ret));
+    }
 }
 
 static void virgl_write_fence(void *opaque, uint32_t fence)
-- 
2.47.3


