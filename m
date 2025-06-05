Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E0168C5B543
	for <qemu-devel@archiver.kernel.org>; Thu,  5 Jun 2025 16:28:57 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uNDQo-00073Y-8N; Thu, 05 Jun 2025 12:27:06 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1uNDQl-00071P-4W
 for qemu-devel@nongnu.org; Thu, 05 Jun 2025 12:27:03 -0400
Received: from mail-ed1-x52d.google.com ([2a00:1450:4864:20::52d])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1uNDQi-0007wc-NZ
 for qemu-devel@nongnu.org; Thu, 05 Jun 2025 12:27:02 -0400
Received: by mail-ed1-x52d.google.com with SMTP id
 4fb4d7f45d1cf-60766191202so114991a12.1
 for <qemu-devel@nongnu.org>; Thu, 05 Jun 2025 09:27:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1749140818; x=1749745618; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=frC5TwMhV/f34ENXgINk4bwryZOX0QIG0KIu5oqBjUU=;
 b=OQU1IPmL/E46rDbIK+yWvmaWJJAoiyzNm7F1JuJas1sXkbX5Lw9DFN+m7plyoyZWBQ
 ED74sJmRDm/3GVEX5LOywx9KmYXpf6M5H4K4tG+tqING+vP0iJ1yraByiqIcnk7g7ZLd
 +crKNOqMJTjVG/w9pb4CiQZCTPu/KFOlSEFnJaXLXnA5xgLsbfUwu1ispkhlABWEeDoO
 uDVsukTaZn7ZaqbA7fX1HaZNjBT+mjfVCrAeqzIKWtvoTlVpFEOPcJT23Y58ZoSRrLD/
 ndxTyUpCmq7cQkBicMdFhoN2mlik1ALSDBlMvlixHTaEf0yCkvAd0yGqtuP3HIke+T2z
 bRkw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1749140818; x=1749745618;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=frC5TwMhV/f34ENXgINk4bwryZOX0QIG0KIu5oqBjUU=;
 b=JUrUSg+DA7qo0O0InnifHvaip4arr0kQ71hzFQ+Tp4c2BjMTkluSsjBQwEW4oY6+yf
 UxTnnMy58ZpJkpIeNhQEMSsxxhE6/aQtGJ/P4GccqH6EPYzuAnFKot3pY5wON6XT9zHT
 xtGVsGGTQMdSSxYKVwuqKBb1QUTsl5SIIcDqSQioJx4d9omfusJkXxvrUVr3W2iX5W8d
 SxxnJhHlzk0sMK4OCcDN6fpGvtBIm2PBfVL6sFKABcCxm2qBwBsmPONb2r7JL/ddi3pV
 JKKg6o2Ky8LRY9wz8PmCSj/v1xywIHPpsszE4zmjsSMN7q9p7XS3mnjb16pe9IkLB7Ym
 S2uw==
X-Gm-Message-State: AOJu0YycxyjKlK+g1iStZFfjAGL3eAp4u9c504dDOSIoOHlShGhI5Epg
 EaRBBwcABAjlMiURDgbN81LY6xSSSIscFVhA4a14HAGJODsDImp59w4nhopgJsYankI=
X-Gm-Gg: ASbGncvpv6TUJ9diQo7whMAIX11DrxTjnd4rAdFQFe9t0vCuscEbsfewTOOt+G+ZIAa
 Mtzx/2uyiitxkPiWF+hAmRFeybBBJdZ5jCHQ0Mbkpe2dfkvQ20lvnhKIjJlbOnfQgQV3qWLUpCP
 OdxD26Qex0brlKUclN4kyRP8VzT0DWy8LgIWO2dzfh2RAtLk1A/iwc6SrY2L4TsO1jLYGGCqIxj
 jE9S4CfWkkJzUJ8jko8jJxKclM+8Ck42MN99IQQwumShXU+8wq4HyvG5Sny+dW5tKF8wfrXuaDJ
 RQmQ3ne1LbeeTuiT8wy9SohTtrxXNH+wmkss7PP8LozhGe//BkkP
X-Google-Smtp-Source: AGHT+IGyjWg2ZppBWu18HWcyfEfEw8JL03VA568llPwWODWUnNbPvxZqHYmPq2UZMmiUx6Nt46sX2Q==
X-Received: by 2002:a17:906:4794:b0:ad5:6dac:ebfa with SMTP id
 a640c23a62f3a-addf8fad78cmr730833366b.55.1749140817672; 
 Thu, 05 Jun 2025 09:26:57 -0700 (PDT)
Received: from draig.lan ([185.126.160.19]) by smtp.gmail.com with ESMTPSA id
 a640c23a62f3a-ada5d82dd12sm1299487066b.58.2025.06.05.09.26.53
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 05 Jun 2025 09:26:54 -0700 (PDT)
Received: from draig.lan (localhost [IPv6:::1])
 by draig.lan (Postfix) with ESMTP id 525275F82B;
 Thu, 05 Jun 2025 17:26:52 +0100 (BST)
From: =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>
To: qemu-devel@nongnu.org
Cc: Manos Pitsidianakis <manos.pitsidianakis@linaro.org>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 qemu-stable@nongnu.org,
 =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>,
 Akihiko Odaki <odaki@rsg.ci.i.u-tokyo.ac.jp>,
 Dmitry Osipenko <dmitry.osipenko@collabora.com>,
 "Michael S. Tsirkin" <mst@redhat.com>
Subject: [PULL 10/17] virtio-gpu: refactor async blob unmapping
Date: Thu,  5 Jun 2025 17:26:43 +0100
Message-ID: <20250605162651.2614401-11-alex.bennee@linaro.org>
X-Mailer: git-send-email 2.47.2
In-Reply-To: <20250605162651.2614401-1-alex.bennee@linaro.org>
References: <20250605162651.2614401-1-alex.bennee@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::52d;
 envelope-from=alex.bennee@linaro.org; helo=mail-ed1-x52d.google.com
X-Spam_score_int: 12
X-Spam_score: 1.2
X-Spam_bar: +
X-Spam_report: (1.2 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1, DKIM_VALID=-0.1,
 DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, RCVD_IN_DNSWL_NONE=-0.0001,
 RCVD_IN_SBL_CSS=3.335, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=no autolearn_force=no
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

From: Manos Pitsidianakis <manos.pitsidianakis@linaro.org>

Change the 3 part async cleanup of a blob memory mapping to check if the
unmapping has finished already after deleting the subregion; this
condition allows us to skip suspending the command and responding to the
guest right away.

Signed-off-by: Manos Pitsidianakis <manos.pitsidianakis@linaro.org>
Reviewed-by: Philippe Mathieu-Daudé <philmd@linaro.org>
Message-Id: <20250410122643.1747913-4-manos.pitsidianakis@linaro.org>
Cc: qemu-stable@nongnu.org
Signed-off-by: Alex Bennée <alex.bennee@linaro.org>
Message-ID: <20250603110204.838117-11-alex.bennee@linaro.org>

diff --git a/hw/display/virtio-gpu-virgl.c b/hw/display/virtio-gpu-virgl.c
index 71a7500de9..b4aa8abb96 100644
--- a/hw/display/virtio-gpu-virgl.c
+++ b/hw/display/virtio-gpu-virgl.c
@@ -155,7 +155,32 @@ virtio_gpu_virgl_unmap_resource_blob(VirtIOGPU *g,
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
 
@@ -166,16 +191,6 @@ virtio_gpu_virgl_unmap_resource_blob(VirtIOGPU *g,
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
2.47.2


