Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C3C8CF4368A
	for <qemu-devel@archiver.kernel.org>; Fri, 17 Apr 2026 09:45:51 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wDfkx-0006FE-Ez; Fri, 17 Apr 2026 05:44:59 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1wDfkv-0006Ev-Ok
 for qemu-devel@nongnu.org; Fri, 17 Apr 2026 05:44:57 -0400
Received: from mail-wm1-x32f.google.com ([2a00:1450:4864:20::32f])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1wDfkt-0006Rv-PN
 for qemu-devel@nongnu.org; Fri, 17 Apr 2026 05:44:57 -0400
Received: by mail-wm1-x32f.google.com with SMTP id
 5b1f17b1804b1-4838c15e3cbso4203785e9.3
 for <qemu-devel@nongnu.org>; Fri, 17 Apr 2026 02:44:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1776419093; x=1777023893; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to;
 bh=95kL8o9wIOGj8/U74zkb4wUZKKITt6J6HXnMFnuJ9VU=;
 b=L9nwcpDmUEkHHcuNpMAtogYak/+h/p2lq7ApU/TXmVT5ktzzoKNq2ZVSFGCOV/B1Bw
 CrdQWxnzr/SXQwIfQfwy18i6O8404ufMoftXuFcTeEYsMl6gMCx6A4PZW//CK0gC93aM
 D8aKk/DIYvpqMfmMjZFk1veayGj2u8pSvqreBM0IUsiolJcFhc1phlRgBHzn6rgL7zdl
 AKLfTItwbNM6ICbYDUVfxkCqZEUziO0SH/OBoOeEcwUp/j7ybea2w5rK8+Qkga7MPLPx
 +40pdtLYyOtJC7t0/08xdLM4a8+iql9ER8QwGgjfs4Z0GS1295M8U1IytGaga2YRrCwd
 dkAg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1776419093; x=1777023893;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=95kL8o9wIOGj8/U74zkb4wUZKKITt6J6HXnMFnuJ9VU=;
 b=BYI87Lc/yaGhsjHf/gP7Am1/Cg3evGKakjN7QYsSAPINqnJyqFbVJtgcqoMQ0X3D/E
 5kse61GRPNAz0DvWZz5itfIyCphIUXhixfG/jO0YSpbWFD9fiC3Grm1ecYc6hQWQhhhR
 27qG+vipo1G7gTwMxwP3cgeTRLrF9TgvZK/6zopKh7gbwD2EnZoR/5PYFvdfdpLAXe9/
 i1tp4Bl4v69l2u2SRIK8p5ttb4Y+Z3NBB8Q6wrRcuyHxioqpZtwiAyCFC0glQ7ZXNUNB
 IEF47KJpZAcymCKVyo94A/k8gyZaAcsgQLU/bSJO3UhK/vYxIeXLPYV0ezyWRvCjF0ft
 MdTA==
X-Gm-Message-State: AOJu0YzwlPLPMJOTcqr0MAu3V/Zw7eFgsnspyEEVOlz+SPeULD+TBdnY
 At/l+2eOdtNTRqrmAFw9bSNWxjHI5mqr3lXNcTMqQyl6IUXmVj4uvB/fxcdMJyHA7aY=
X-Gm-Gg: AeBDieu3qM0sz8mAc4qQgtKH9puPse6ddeCZmPyNMTOZbj5pB4IhoWv8/OzT0CrDJ3F
 xmqqi5oPgs7GSXEbAei2txHuX9HLnuHSroOHERskM4gmimFD0FEtkNGM9Dx/Ey4Xw7UIOK2UycB
 dTjrxMjRXAXhO9jKVOYMt2rMmgLK7qm3TA8Zb7DZU+RL28sTPkjyqDLDXWWH1hij0az6FG8wjxp
 C0jeVxGj0aqU43t0vx6aED2aPsin4PPTBrJtdQxsN8ww25xGz//dHabMoPpg/w8ZjeUpojpgxn6
 bsx148pnoVzEL5fp30ZYu8kNJrO1613FS/jNUD6AppBLxoZMk41/i9/HRittQsTgWHuI8VkJk8+
 T1xKaTypCEg4AALabfeugXQqfDo4pvNyDrW1GeggmA31FrJwVr/OEeszwcONeoIBUQEyEnlSZB1
 mqUy3kKJyBrTmxohjIf73sf7e/qhj9T0iRUg==
X-Received: by 2002:a05:600c:a00c:b0:488:c51f:e04e with SMTP id
 5b1f17b1804b1-488fb765e65mr26192995e9.13.1776419093461; 
 Fri, 17 Apr 2026 02:44:53 -0700 (PDT)
Received: from draig.lan ([185.124.0.195]) by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-43fe4e3a166sm3383545f8f.19.2026.04.17.02.44.52
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 17 Apr 2026 02:44:52 -0700 (PDT)
Received: from draig.lan (localhost [IPv6:::1])
 by draig.lan (Postfix) with ESMTP id 233F65F94F;
 Fri, 17 Apr 2026 10:44:52 +0100 (BST)
From: =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>
To: qemu-devel@nongnu.org
Cc: manos.pitsidianakis@linaro.org,
 =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>,
 qemu-stable@nongnu.org, "Michael S. Tsirkin" <mst@redhat.com>,
 Akihiko Odaki <odaki@rsg.ci.i.u-tokyo.ac.jp>,
 Dmitry Osipenko <dmitry.osipenko@collabora.com>
Subject: [RFC PATCH] hw/display: don't accidentally autofree existing virgl
 resources
Date: Fri, 17 Apr 2026 10:44:43 +0100
Message-ID: <20260417094443.785462-1-alex.bennee@linaro.org>
X-Mailer: git-send-email 2.47.3
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::32f;
 envelope-from=alex.bennee@linaro.org; helo=mail-wm1-x32f.google.com
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

Fixes: 7c092f17cce (virtio-gpu: Handle resource blob commands)
Signed-off-by: Alex Bennée <alex.bennee@linaro.org>
Cc: qemu-stable@nongnu.org
---
 hw/display/virtio-gpu-virgl.c | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

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


