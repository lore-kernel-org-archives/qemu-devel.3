Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3F895D2AB30
	for <qemu-devel@archiver.kernel.org>; Tue, 29 Oct 2024 12:11:21 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1t5l3a-0004as-23; Tue, 29 Oct 2024 08:10:42 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1t5l3W-0004Zd-Iw
 for qemu-devel@nongnu.org; Tue, 29 Oct 2024 08:10:38 -0400
Received: from mail-wm1-x332.google.com ([2a00:1450:4864:20::332])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1t5l3V-0007SQ-28
 for qemu-devel@nongnu.org; Tue, 29 Oct 2024 08:10:38 -0400
Received: by mail-wm1-x332.google.com with SMTP id
 5b1f17b1804b1-4315abed18aso51218855e9.2
 for <qemu-devel@nongnu.org>; Tue, 29 Oct 2024 05:10:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1730203835; x=1730808635; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=XPzMIRyHHPYrwvugSrdgfTS150qXNc9bgO1rDL0GqR8=;
 b=R5Tk4LwSLjn1ujGeBKBzeq4YEmiLnPfzPFYKOJPl7g9RmRTpKALF5e2dg5E3IRPBsE
 YlR9EP0f0dXjvcowZbgDyPWIBcEkV8jDbdYKzMZk7DBbjdOz5yv/PGmThqEmn7SjaiXF
 cOprKLYktWGOJ2FSxZ83E6clkP2dmLhqU7twpNXWwgcp69hYzofuQcW71Xi63d2AhEd/
 GQSx5Wit+v68Tj1twWnTlZOrmE6izOMuvK3uKq6f/9msLxiz4ECynfiZJ6OYKf3yD2G+
 N0AU7sMqUeOy5lvEfLlnUwHh7NPLoNIGDvYxuAXnq9BOh/75uZ7iYWmyaIfnZpFfQrS1
 LP0w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1730203835; x=1730808635;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=XPzMIRyHHPYrwvugSrdgfTS150qXNc9bgO1rDL0GqR8=;
 b=GmY4hs6rUBNmAcnAX85LferH70E4SvejyRkk9ivLQvuuUUXl6BQXyv+DzFeuV7eKV5
 a0Q1/BAEaiEieJGu3/Qed3jXF+MVKkLow49OZFXrWq9wfiU4VKfptf+ad3PFEqr+XGRM
 OFDAhZl1Murw5gEfc3QYFVCFHSdlxE56uQRY0CEONgvv95BvBmQiahhjMUSNmPIM6PG1
 Rt6Or1Nj0tRnryelcsvJ+P18J6tyNZxtw1BWRFn8hHHJPOM+VdBOYgCrjYxHjhozSwhv
 GH9YXLnhzz1NZq2afGWcyakkwR349HpcJz2YIdhr8EGUQv+GhtcpsdiIjiGFnetpGvoD
 i4RQ==
X-Gm-Message-State: AOJu0Yx8Jk6+DRd5fPcdWkNwuxYgVNkzS6zC/YqZef7u8MNFQoAKjHLQ
 UrxWcveggbbpAJ12XRWarcTi0lctqAkZkA4rypj7eMOLbZ9aHDwTHPk9Wyf53gqNRI+ZhkgPfqt
 R
X-Google-Smtp-Source: AGHT+IGf1EhwNTYrSBor1mLywv2aKwGNAwxy5d1jkpLDBB654F5xps6JwoigQFNdX1GAzI5aOU7IwQ==
X-Received: by 2002:adf:e0c2:0:b0:37d:940c:7391 with SMTP id
 ffacd0b85a97d-380611e75b9mr9050584f8f.41.1730203835415; 
 Tue, 29 Oct 2024 05:10:35 -0700 (PDT)
Received: from draig.lan ([85.9.250.243]) by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-38058b47a86sm12344746f8f.53.2024.10.29.05.10.32
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 29 Oct 2024 05:10:34 -0700 (PDT)
Received: from draig.lan (localhost [IPv6:::1])
 by draig.lan (Postfix) with ESMTP id E6E8D5FABB;
 Tue, 29 Oct 2024 12:10:30 +0000 (GMT)
From: =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>
To: qemu-devel@nongnu.org
Cc: Dmitry Osipenko <dmitry.osipenko@collabora.com>,
 =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>,
 "Michael S. Tsirkin" <mst@redhat.com>
Subject: [PULL 05/13] virtio-gpu: Unrealize GL device
Date: Tue, 29 Oct 2024 12:10:22 +0000
Message-Id: <20241029121030.4007014-6-alex.bennee@linaro.org>
X-Mailer: git-send-email 2.39.5
In-Reply-To: <20241029121030.4007014-1-alex.bennee@linaro.org>
References: <20241029121030.4007014-1-alex.bennee@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::332;
 envelope-from=alex.bennee@linaro.org; helo=mail-wm1-x332.google.com
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

Even though GL GPU doesn't support hotplugging today, free virgl
resources when GL device is unrealized. For consistency.

Signed-off-by: Dmitry Osipenko <dmitry.osipenko@collabora.com>
Message-Id: <20241024210311.118220-6-dmitry.osipenko@collabora.com>
Signed-off-by: Alex Bennée <alex.bennee@linaro.org>

diff --git a/hw/display/virtio-gpu-gl.c b/hw/display/virtio-gpu-gl.c
index ea3413aa56..753b35ed69 100644
--- a/hw/display/virtio-gpu-gl.c
+++ b/hw/display/virtio-gpu-gl.c
@@ -156,6 +156,22 @@ static Property virtio_gpu_gl_properties[] = {
     DEFINE_PROP_END_OF_LIST(),
 };
 
+static void virtio_gpu_gl_device_unrealize(DeviceState *qdev)
+{
+    VirtIOGPU *g = VIRTIO_GPU(qdev);
+    VirtIOGPUGL *gl = VIRTIO_GPU_GL(qdev);
+
+    if (gl->renderer_state >= RS_INITED) {
+        if (virtio_gpu_stats_enabled(g->parent_obj.conf)) {
+            timer_free(gl->print_stats);
+        }
+        timer_free(gl->fence_poll);
+        virgl_renderer_cleanup(NULL);
+    }
+
+    gl->renderer_state = RS_START;
+}
+
 static void virtio_gpu_gl_class_init(ObjectClass *klass, void *data)
 {
     DeviceClass *dc = DEVICE_CLASS(klass);
@@ -169,6 +185,7 @@ static void virtio_gpu_gl_class_init(ObjectClass *klass, void *data)
     vgc->update_cursor_data = virtio_gpu_gl_update_cursor_data;
 
     vdc->realize = virtio_gpu_gl_device_realize;
+    vdc->unrealize = virtio_gpu_gl_device_unrealize;
     vdc->reset = virtio_gpu_gl_reset;
     device_class_set_props(dc, virtio_gpu_gl_properties);
 }
-- 
2.39.5


