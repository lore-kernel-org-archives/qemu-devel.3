Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B6435F43697
	for <qemu-devel@archiver.kernel.org>; Fri, 17 Apr 2026 12:28:27 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wDiIE-0002AD-8F; Fri, 17 Apr 2026 08:27:30 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1wDiIC-00029U-JI
 for qemu-devel@nongnu.org; Fri, 17 Apr 2026 08:27:28 -0400
Received: from mail-wr1-x42c.google.com ([2a00:1450:4864:20::42c])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1wDiIB-0002dP-35
 for qemu-devel@nongnu.org; Fri, 17 Apr 2026 08:27:28 -0400
Received: by mail-wr1-x42c.google.com with SMTP id
 ffacd0b85a97d-43fe62837baso293370f8f.3
 for <qemu-devel@nongnu.org>; Fri, 17 Apr 2026 05:27:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1776428845; x=1777033645; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to;
 bh=09Ao/kdkItFINOSsUtWmsMGzeiiAB3gnUtxxrN6Tkro=;
 b=O5+ev40i379X/kVixTVEp1lkhj2xZMaxUToDVLf31Ly5QBMX+cA6nqIOq9ZgMePNnL
 uhbheIoKSLJX0fqV8ulKvH8g9Uunayn+QxR1kfL4gb+f3VzCyiQCn+VDZqA9TZip865f
 iNCqB53u65XryHTcX5U1TKX630+8VO57MVnMsAps3rJEKBZVgWijJT1ULy7kQpA3HwzJ
 V2xCJ9Xo3d0MahhuoSogpfKjZlEDXdCP/McYTvdASbF8FnLA12bdcZbhswDwl2FrGEO+
 98azor5A3wQX2HGHYBdm/gvwIC1jtnz5HywT+RqcqJTtZN0tvajaJm21935ZRXi/8xmD
 Yqjg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1776428845; x=1777033645;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=09Ao/kdkItFINOSsUtWmsMGzeiiAB3gnUtxxrN6Tkro=;
 b=JSSPsAD4a0V+imELdVkJuI9EQba3VNGIfEmObJ2CiYHFmqoL3VAP4fpcJnhGDqKckL
 IGeUruzlnuk+i5WSE5YUTGnmwK/zIsejasc5kR5Ni7bNAQ8wkgx43T2folvRnGj/n+ZI
 dk/RbfUx7ueppZBj8NFstMei0iDPhJqxVM2x5g0uwb9N/eBdwoKIVFFBqB7kVR/ZVr5b
 787NkNYnirnd/GXwBKfMNyhZqKOZ3gvzdXGlV1IO6J7CnFf53s8sjskw1JQxou57EBru
 h/bCRFDhTZYwmWa5SKD3yOCiY/LuUKcpsNKDCfMTi55nvhH/7bsBBBFOPR0JedWh2/kg
 n5vw==
X-Gm-Message-State: AOJu0YyoYfXtHhCbgC+L7/MWDdIkFdYaWkvXRmGED0AtWgoWLNAZ1eXL
 vMLBl66YTCBmOw07LL6A5WbeKKsTOWsWSg/Z+I7g2xB8GceqG2mML30tC2i+QY1uqBo=
X-Gm-Gg: AeBDietl9ZXYhgcfJzndAj7QUUqAVYZdb7fHWJkv50DS941hAPJqbd54MM/iejf3l9e
 7sre3AbZMngvCkpFy0wNdCp3mq9Bm9mQjVWxpCKNQseAW5eGMug06/loPCB6q5e/Lob14jwxZ9+
 1FXug7MaH+97z5DdEf/sBqW01KXeQPLHSaRJ78ShbF2dRXsJ/sS+Shtz6ee50is19l9YzG2VMTz
 YTSBr93oFOEJhaH2Z+wDdWgwcUvEk3cwzDNSX0e7pwvg5xUAc5igiV8n7H52qzezRdC3NoJ2A23
 lkoknwzbR8fUU4gHqhaMLlQk2v4LZP0aKPOhM+NeEkI/yB9NECyqZV0ykSaBGlea1jf9vbOutb/
 LLcNF0ZMdzRd+Fp14+StTRxQys4nSFkODQs3lhBIx8qn+EFrPXKQH37i2rno+Ol8+GIchevLmON
 tnkmWZY3Yv+f5iT2EkkB4JwnLTUk4mYGXBVcEj/UGwXJ45
X-Received: by 2002:a05:6000:240e:b0:43d:7594:f378 with SMTP id
 ffacd0b85a97d-43fe3e0b18emr4094615f8f.41.1776428845051; 
 Fri, 17 Apr 2026 05:27:25 -0700 (PDT)
Received: from draig.lan ([185.124.0.195]) by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-43fe4e3a381sm4669706f8f.21.2026.04.17.05.27.23
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 17 Apr 2026 05:27:24 -0700 (PDT)
Received: from draig.lan (localhost [IPv6:::1])
 by draig.lan (Postfix) with ESMTP id BC8A15F94F;
 Fri, 17 Apr 2026 13:27:22 +0100 (BST)
From: =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>
To: qemu-devel@nongnu.org
Cc: =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>,
 Manos Pitsidianakis <manos.pitsidianakis@linaro.org>,
 qemu-stable@nongnu.org, "Michael S. Tsirkin" <mst@redhat.com>,
 Akihiko Odaki <odaki@rsg.ci.i.u-tokyo.ac.jp>,
 Dmitry Osipenko <dmitry.osipenko@collabora.com>
Subject: [PATCH v2] hw/display: don't accidentally autofree existing virgl
 resources
Date: Fri, 17 Apr 2026 13:27:03 +0100
Message-ID: <20260417122703.845442-1-alex.bennee@linaro.org>
X-Mailer: git-send-email 2.47.3
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::42c;
 envelope-from=alex.bennee@linaro.org; helo=mail-wr1-x42c.google.com
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
Signed-off-by: Alex Bennée <alex.bennee@linaro.org>
Reviewed-by: Manos Pitsidianakis <manos.pitsidianakis@linaro.org>
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


