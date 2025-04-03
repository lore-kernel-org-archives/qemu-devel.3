Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id AF871C3600C
	for <qemu-devel@archiver.kernel.org>; Thu,  3 Apr 2025 13:38:03 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1u0KkS-0001ac-G3; Thu, 03 Apr 2025 09:36:48 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <manos.pitsidianakis@linaro.org>)
 id 1u0JVR-0000L9-E8
 for qemu-devel@nongnu.org; Thu, 03 Apr 2025 08:17:13 -0400
Received: from mail-ed1-x52c.google.com ([2a00:1450:4864:20::52c])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <manos.pitsidianakis@linaro.org>)
 id 1u0JVP-0002w4-0J
 for qemu-devel@nongnu.org; Thu, 03 Apr 2025 08:17:13 -0400
Received: by mail-ed1-x52c.google.com with SMTP id
 4fb4d7f45d1cf-5ec9d24acfbso3609739a12.0
 for <qemu-devel@nongnu.org>; Thu, 03 Apr 2025 05:17:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1743682629; x=1744287429; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=diGTPMOfCdQXRY7pq98mNhHNXR0bqqEOtRlrBmePnE0=;
 b=A0th0HbefJHJgrYUSwXkuVPJTA4t2x1bbthJIvDu1ZlE1OgoD6G63Ea+qGZgVEnc9G
 sML0g2zw8K+CkAjDaqfcon5OA3VA/xKgLdGDEuxzjXO7HsRh4GzPZXCJIOns9BRGEgNn
 6TguU0AY9u9OQx1VZTwK0+vhWhug8dO6sFLdhpXJ67xK7CEbQlDTiAiE6HxWk0Mtj8aw
 E/neJEjqzjiQPfWhSOilkkuKYipePCI8wTA2IDjfVVvJZkKIQFBRG6Vc7UhLkAhTjn3A
 1OSrQuCYzJrDnA/LnkIzYpE/S8GvoLsrnuactsDLH/QrBIrML/l62FJ9k4DW1sc8PKHJ
 01BA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1743682629; x=1744287429;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=diGTPMOfCdQXRY7pq98mNhHNXR0bqqEOtRlrBmePnE0=;
 b=tJu6mHwjFgS1MeKy5w9/JeSyNSU7FcSepm7q7+E2UM0fl/bk0dkzhMWqh8yzoDNHUI
 KDIdkfU8zxBoqNviQc7rhmTp8wqwoPt4CRBuGabzfim0umfe9K4IxRU0Hz8WjdRpzR8l
 eqfLcT0KuJbAB1fGVmxUtT3TkB1ZVlun5gzWrylx1RUVJ7K7ou4c3n67Rb/fY7Ys4pZi
 kwNw/PHgU9LrgIv4GXwayo8+S+A7MWs6gaWSRunE8gsMdrAMAMw7TQsVMnk7GclLotb8
 EBRvHYQK1EE+V6dn8FoY25fRUy0za4LQL70SyPu4+rV69TkKewYX7cfj2ZtFM+nh+4we
 Cc+A==
X-Gm-Message-State: AOJu0Yw4zYSotxdXk3zprOhfDVqkadk1ybNU0dcum3Ql4KfTHCXThjTn
 8YS8UFVI9xBeIUjL4L7LyYHiU5NvlHa+GilneqAxYIrLccWXx7IOVg1ZkDVCWe2mAmQcPTFqD8v
 IZU8=
X-Gm-Gg: ASbGncuo1/D1cnao/3DRoWa4tV+OwXZKIQvsv7yV4QH2S3FSHHShujTtT4Z+qW2CO3W
 Wb2S0A3cmOBpBgDYc9Zbz9M9x9X0IZTmuonkTqL9WudA8QAKMXpZJ+QwszvaqTT6g5SeiNzjGxc
 iwVzovTd09I+mCBbz1dJcyrdhpW6+eW3J1E6KnsN3I8d/G1hQpsaM4DEWCj1+xDsZ3EEQ7Xh6Kn
 4z9OJ24GVk4Jwmvp1+ldhoLoTuurz6uTRu9/bAShw9/H4g2rQ/FwODuI+2MKkE96yhLgAASk/Ig
 /eta/XElKzMiPKhhnrrcjJd/b/6s9dibZ8zrYJFQHqsjVLsC3gYryqM5CDcBsx8xEMSW83XJyvY
 Mk0nXw/YE6GLFOr74uJcr+l3dh5BKCA==
X-Google-Smtp-Source: AGHT+IFcAZgTAKf5LvrF2Rb+YHZVbWxj/aZ0MQew0BXekA2eRja6x5sWAIaYIvi+4yTL2DGBat5fIQ==
X-Received: by 2002:a17:907:7f91:b0:ac0:4364:4083 with SMTP id
 a640c23a62f3a-ac7b6762bf7mr320997266b.0.1743682629244; 
 Thu, 03 Apr 2025 05:17:09 -0700 (PDT)
Received: from localhost.localdomain (adsl-37.37.6.161.tellas.gr.
 [37.6.161.37]) by smtp.gmail.com with ESMTPSA id
 a640c23a62f3a-ac7bfe61c15sm85641666b.12.2025.04.03.05.17.08
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 03 Apr 2025 05:17:09 -0700 (PDT)
From: Manos Pitsidianakis <manos.pitsidianakis@linaro.org>
To: qemu-devel@nongnu.org
Cc: =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Richard Henderson <richard.henderson@linaro.org>,
 "Michael S. Tsirkin" <mst@redhat.com>
Subject: [PATCH v1 2/2] virtio-gpu: refactor async blob unmapping
Date: Thu,  3 Apr 2025 15:17:02 +0300
Message-ID: <20250403121704.2754589-3-manos.pitsidianakis@linaro.org>
X-Mailer: git-send-email 2.47.2
In-Reply-To: <20250403121704.2754589-1-manos.pitsidianakis@linaro.org>
References: <20250403121704.2754589-1-manos.pitsidianakis@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::52c;
 envelope-from=manos.pitsidianakis@linaro.org; helo=mail-ed1-x52c.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=ham autolearn_force=no
X-Spam_action: no action
X-Mailman-Approved-At: Thu, 03 Apr 2025 09:36:46 -0400
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

Change the 3 part async cleanup of a blob memory mapping to check if the
unmapping has finished already after deleting the subregion; this
condition allows us to skip suspending the command and responding to the
guest right away.

Signed-off-by: Manos Pitsidianakis <manos.pitsidianakis@linaro.org>
---
 hw/display/virtio-gpu-virgl.c | 35 +++++++++++++++++++++++++----------
 1 file changed, 25 insertions(+), 10 deletions(-)

diff --git a/hw/display/virtio-gpu-virgl.c b/hw/display/virtio-gpu-virgl.c
index ad600ccc9c..c75206114d 100644
--- a/hw/display/virtio-gpu-virgl.c
+++ b/hw/display/virtio-gpu-virgl.c
@@ -162,7 +162,32 @@ virtio_gpu_virgl_unmap_resource_blob(VirtIOGPU *g,
      *    asynchronously by virtio_gpu_virgl_hostmem_region_free().
      * 3. Finish the unmapping with final virgl_renderer_resource_unmap().
      */
+
+    /* 1. Check if we should start unmapping now */
+    if (!vmr->finish_unmapping) {
+        /* begin async unmapping. render will be unblocked once MR is freed */
+        b->renderer_blocked++;
+
+        memory_region_set_enabled(mr, false);
+        memory_region_del_subregion(&b->hostmem, mr);
+        object_unparent(OBJECT(mr));
+        /*
+         * The unmapping might have already finished at this point if no one
+         * else held a reference to the MR; if yes, we can skip suspending the
+         * command and unmap the resource right away.
+         */
+        *cmd_suspended = !vmr->finish_unmapping;
+    }
+
+    /*
+     * 2. if virtio_gpu_virgl_hostmem_region_free hasn't been executed yet, we
+     * have marked the command to be re-processed later by setting
+     * cmd_suspended to true. The freeing callback will be called from RCU
+     * context later.
+     */
+
     if (vmr->finish_unmapping) {
+        /* 3. MemoryRegion has been freed, so finish unmapping */
         res->mr = NULL;
         g_free(vmr);
 
@@ -173,16 +198,6 @@ virtio_gpu_virgl_unmap_resource_blob(VirtIOGPU *g,
                           __func__, strerror(-ret));
             return ret;
         }
-    } else {
-        *cmd_suspended = true;
-
-        /* render will be unblocked once MR is freed */
-        b->renderer_blocked++;
-
-        /* memory region owns self res->mr object and frees it by itself */
-        memory_region_set_enabled(mr, false);
-        memory_region_del_subregion(&b->hostmem, mr);
-        object_unparent(OBJECT(mr));
     }
 
     return 0;
-- 
γαῖα πυρί μιχθήτω


