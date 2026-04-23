Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id BC0BAFC0342
	for <qemu-devel@archiver.kernel.org>; Thu, 23 Apr 2026 15:21:00 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wFvqQ-0005Ux-QZ; Thu, 23 Apr 2026 11:19:58 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1wFvqP-0005Uf-BC
 for qemu-devel@nongnu.org; Thu, 23 Apr 2026 11:19:57 -0400
Received: from mail-wr1-x42d.google.com ([2a00:1450:4864:20::42d])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1wFvqN-0002GZ-Qc
 for qemu-devel@nongnu.org; Thu, 23 Apr 2026 11:19:57 -0400
Received: by mail-wr1-x42d.google.com with SMTP id
 ffacd0b85a97d-43cf7683a28so4643203f8f.2
 for <qemu-devel@nongnu.org>; Thu, 23 Apr 2026 08:19:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1776957592; x=1777562392; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=228cf+S0c2e/rGab2mnaiBCrE3sra0xAuasuA/jsx9E=;
 b=jB9b40NMRABq2FHd2IJ5iW4QbywGYjsx7jrYPgM76rvzMLHNaP1rfo1jPRpsv7amVt
 KhiI3UBB13geVps2LdhiT2onsq+DvDD0dSnCccsAbGYHEMvBrAo4v7AcUag4+GFXYcwI
 N0yCVhD5cZz/1dFy4CuChC1xdDFi9ycMQuetlvDY6xObVDI+vALtoX8tMEKeprwfLuiY
 sbnyzjzwx0fxco/PwUXGwoXkiq9xjwszJBjcDUtWTIVAcUmhPC1M5pF6q67V7GL+4hUk
 Mz2q3OUmeFZ2N1NcBgYiXdNGE9ypW1SthNUc7J7IdlO1DJMRLARz9CGTRa5atQUEwYdP
 v69Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1776957592; x=1777562392;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=228cf+S0c2e/rGab2mnaiBCrE3sra0xAuasuA/jsx9E=;
 b=NJYoq7cbz+sTFpIzhA9DxL6TNPM3/nuTNiX8pdmu83ycgWqt68tifEO9iNsjnbUl5D
 rMDwQhmlePRycqEf9/xU/FlinNBFe5YxY+xK34HZ53KHNBchKJIGhg0KKbljIIbFWyp2
 taTq4KoZ0bf0DBbdx67oB9wvqSXV8JLOdnD9KPkrkoriYtbChoky5gu3ZGAzdZxM1aOD
 T2NNEWjuUa/nFo4MneGSW25CZ0dwiYk+oKJrhJJ8K3TCjD8VntggkfFV3il4OcA8RGai
 az0BajcvfGFUtfjcMRMBjPhxaDE/4CSgyO9HYIGeVf8WbQTJ3CNO0y2/VOgX/Ij48DI4
 UlHw==
X-Gm-Message-State: AOJu0YwP8ZS0KxdxMQqcTSPydRbvKBMshsqU7Uv6wrESyoWvyMeq1n6Y
 TYt2GaqSt6V785LXAdbT2ep4wIOVm5pxZfIwGkbRXu8sSB1oGMcp6iWRK21MHa4yI7s=
X-Gm-Gg: AeBDievrqtBcRiDYKiRXZB/nftk1gAmfvRhrE5qur+sRfNaapngydRPIhyV5IqFUi2w
 Fulc7N3XXDQ4+W4jnyan3wlr4XvOnrXc6hOIOQDiSRLz6OizufGqd3Ez3tVnqkcGipflb/nauQV
 4B2BAg7bMzaF7S7CrvaGwYRzTeslk84cv6t1zAtXods7wX0THhcYRQnzt8O6yyz8h0jXG06o+/V
 CkFINWMiFaxV9Qctg7befj1d2ldwUz+kE9RMbJlOGpPymgLdkOnmOdZ36USPn/ob2hm9uBsn0Iq
 ivybzTPnj1axgtnVJ/sTV2UmL5aBULXprPdbWC9nseMU/hhDJE9J8uK0eiizjODFgsGy5Vh+fWL
 3szpvcCjtMYpG2vGXu7GUfd6F9FUndgjJQhQD7z0rtFdO6955aAG6POoDUyN8EEn+4E/FHyvXEV
 cfjE70BoXWOTBUK3YcryEAsOFiDJDtLeckAQ==
X-Received: by 2002:a5d:64c4:0:b0:43d:708f:a63e with SMTP id
 ffacd0b85a97d-43fe3dbddbbmr41774378f8f.10.1776957592440; 
 Thu, 23 Apr 2026 08:19:52 -0700 (PDT)
Received: from draig.lan ([185.124.0.195]) by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-43fe4cb1249sm50417720f8f.5.2026.04.23.08.19.47
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 23 Apr 2026 08:19:47 -0700 (PDT)
Received: from draig.lan (localhost [IPv6:::1])
 by draig.lan (Postfix) with ESMTP id CA1F35F943;
 Thu, 23 Apr 2026 16:19:46 +0100 (BST)
From: =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>
To: qemu-devel@nongnu.org
Cc: =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>,
 Manos Pitsidianakis <manos.pitsidianakis@linaro.org>,
 qemu-stable@nongnu.org, Dmitry Osipenko <dmitry.osipenko@collabora.com>,
 "Michael S. Tsirkin" <mst@redhat.com>,
 Akihiko Odaki <odaki@rsg.ci.i.u-tokyo.ac.jp>
Subject: [PULL 2/2] hw/display: don't accidentally autofree existing virgl
 resources
Date: Thu, 23 Apr 2026 16:19:46 +0100
Message-ID: <20260423151946.1853943-3-alex.bennee@linaro.org>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <20260423151946.1853943-1-alex.bennee@linaro.org>
References: <20260423151946.1853943-1-alex.bennee@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::42d;
 envelope-from=alex.bennee@linaro.org; helo=mail-wr1-x42d.google.com
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

While sanity checking a create blob operation the use of the auto
freed res variable could lead to inadvertently freeing an existing
blob.

Avoid this by in-lining the virtio_gpu_virgl_find_resource() check as
the value is not needed anyway.

While at it add a comment to the end and use g_steal_pointer to make
it clearer the object lifetime exceeds the function bounds if we pass
all the checks.

Fixes: CVE-2026-6502
Fixes: 7c092f17cce (virtio-gpu: Handle resource blob commands)
Message-ID: 20260417094443.785462-1-alex.bennee@linaro.org
Reviewed-by: Manos Pitsidianakis <manos.pitsidianakis@linaro.org>
Cc: qemu-stable@nongnu.org
Message-ID: <20260417122703.845442-1-alex.bennee@linaro.org>
Signed-off-by: Alex Bennée <alex.bennee@linaro.org>
Reviewed-by: Dmitry Osipenko <dmitry.osipenko@collabora.com>

diff --git a/hw/display/virtio-gpu-virgl.c b/hw/display/virtio-gpu-virgl.c
index b7a2d160ddd..add85bd4e61 100644
--- a/hw/display/virtio-gpu-virgl.c
+++ b/hw/display/virtio-gpu-virgl.c
@@ -830,8 +830,7 @@ static void virgl_cmd_resource_create_blob(VirtIOGPU *g,
         return;
     }
 
-    res = virtio_gpu_virgl_find_resource(g, cblob.resource_id);
-    if (res) {
+    if (virtio_gpu_virgl_find_resource(g, cblob.resource_id)) {
         qemu_log_mask(LOG_GUEST_ERROR, "%s: resource already exists %d\n",
                       __func__, cblob.resource_id);
         cmd->error = VIRTIO_GPU_RESP_ERR_INVALID_RESOURCE_ID;
@@ -884,8 +883,9 @@ static void virgl_cmd_resource_create_blob(VirtIOGPU *g,
 
     res->base.dmabuf_fd = info.fd;
 
+    /* Now live, cleaned up in virtio_gpu_virgl_resource_unref */
     QTAILQ_INSERT_HEAD(&g->reslist, &res->base, next);
-    res = NULL;
+    g_steal_pointer(&res);
 }
 
 static void virgl_cmd_resource_map_blob(VirtIOGPU *g,
-- 
2.47.3


