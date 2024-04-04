Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E0659CD1297
	for <qemu-devel@archiver.kernel.org>; Thu,  4 Apr 2024 19:14:36 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rsSX9-00063Z-Lm; Thu, 04 Apr 2024 15:13:59 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1rsSX8-00063Q-8z
 for qemu-devel@nongnu.org; Thu, 04 Apr 2024 15:13:58 -0400
Received: from mail-ej1-x635.google.com ([2a00:1450:4864:20::635])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1rsSX0-0005Vd-BC
 for qemu-devel@nongnu.org; Thu, 04 Apr 2024 15:13:56 -0400
Received: by mail-ej1-x635.google.com with SMTP id
 a640c23a62f3a-a4e60a64abcso432933266b.1
 for <qemu-devel@nongnu.org>; Thu, 04 Apr 2024 12:13:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1712258028; x=1712862828; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=bvdlQf7pHfui8YenaIyIB+vGNyHogH/cKFxc4FINeZE=;
 b=M0cAWhJTFpiVlffZ/nFFvGuzM/ygkEABDYooHYY0Jum7VIJ9TlF/TE8e+HuM9eG3F9
 8q0YjPI1iQfFOHBum8MB/H5X066Jems9A/XGoCsOj9DGWHIYKB65scHuvV32hlxzEaBH
 mlc3amRoFprS3XB+mxmS3Hrcv7E3gLHL7/Usw7SGg/QwAE8Z3iKRRGL+egc4quEeIEdE
 iqNUxPZ1TUjoQ4cziIPUd43mEhQytP2nI33z4VtgWhE+oNxCjY5L7g+C0nSEtrT4OiFB
 AYCL0wByeql+1kU1CuXLHgOdwqZLnVQx1+vVko5PxjduF2N7SsOzx/RYjsdQf1qsigTL
 uHug==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1712258028; x=1712862828;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=bvdlQf7pHfui8YenaIyIB+vGNyHogH/cKFxc4FINeZE=;
 b=FW5cUj4X8Qc7VuJgC9iOJCE6Jgr6CMdSs0ihk5CRg1flrj73OR/Y2eC1/3NevI0udc
 DiTZHJ0SAmgJSPVV83QKCJTPgQ1UGdXJ1yV24nA4bolk8pLzmKxKpxmZ7LUB04VeMuQI
 0k16DssEfgeio7KDmFyV0+NM0P8iG+Dna1+/4PqCjZG/rfZVdIihtchEF0pu6Ntmzhpu
 gDD2TMyp3aGO4vX+YhtmTa4ZgktAva0AHEt5XMVhOGZQWVKDkr34hWFq06OKqToSGo34
 6s5AhLO35fmAR+yOGWbinvW96FQq6Dc6R9zjBsnBEnvytouX24SYhu0YuziGayENQLls
 XMdg==
X-Gm-Message-State: AOJu0YyGJ5ZKaci4zZT2H1Ah2Ks3GRy/F8KLwOy0PwdPqJO2MsJa/F3g
 Q57ZC/teWNGEiLocc/qxI/+9EWkFQqvJpSLP8+mTB+EtKV2rl52La+DcskQCnfOchs0AIJP5UFl
 P
X-Google-Smtp-Source: AGHT+IF9j3SKcg2Ny+e4pt79HnzSaY5+vwV7V8cQ3SuQKblL9sunzEpYk9wiW1rk/veHVSxmRHFgbg==
X-Received: by 2002:a17:906:ae8e:b0:a51:931a:f82c with SMTP id
 md14-20020a170906ae8e00b00a51931af82cmr292258ejb.32.1712258028223; 
 Thu, 04 Apr 2024 12:13:48 -0700 (PDT)
Received: from m1x-phil.lan ([176.187.216.111])
 by smtp.gmail.com with ESMTPSA id
 bu8-20020a170907930800b00a4e451724ffsm7302786ejc.166.2024.04.04.12.13.46
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Thu, 04 Apr 2024 12:13:47 -0700 (PDT)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
To: qemu-devel@nongnu.org
Cc: Gerd Hoffmann <kraxel@redhat.com>, Amit Shah <amit@kernel.org>,
 "Michael S. Tsirkin" <mst@redhat.com>, Alexander Bulekov <alxndr@bu.edu>,
 "Gonglei (Arei)" <arei.gonglei@huawei.com>,
 =?UTF-8?q?Marc-Andr=C3=A9=20Lureau?= <marcandre.lureau@redhat.com>,
 Laurent Vivier <lvivier@redhat.com>,
 Mauro Matteo Cascella <mcascell@redhat.com>,
 Paolo Bonzini <pbonzini@redhat.com>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
Subject: [PATCH-for-9.0 1/4] hw/virtio: Introduce virtio_bh_new_guarded()
 helper
Date: Thu,  4 Apr 2024 21:13:36 +0200
Message-ID: <20240404191339.5688-2-philmd@linaro.org>
X-Mailer: git-send-email 2.41.0
In-Reply-To: <20240404191339.5688-1-philmd@linaro.org>
References: <20240404191339.5688-1-philmd@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::635;
 envelope-from=philmd@linaro.org; helo=mail-ej1-x635.google.com
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

Introduce virtio_bh_new_guarded(), similar to qemu_bh_new_guarded()
but using the transport memory guard, instead of the device one
(there can only be one virtio device per virtio bus).

Inspired-by: Gerd Hoffmann <kraxel@redhat.com>
Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
---
 include/hw/virtio/virtio.h |  7 +++++++
 hw/virtio/virtio.c         | 10 ++++++++++
 2 files changed, 17 insertions(+)

diff --git a/include/hw/virtio/virtio.h b/include/hw/virtio/virtio.h
index b3c74a1bca..12419d6355 100644
--- a/include/hw/virtio/virtio.h
+++ b/include/hw/virtio/virtio.h
@@ -22,6 +22,7 @@
 #include "standard-headers/linux/virtio_config.h"
 #include "standard-headers/linux/virtio_ring.h"
 #include "qom/object.h"
+#include "block/aio.h"
 
 /*
  * A guest should never accept this. It implies negotiation is broken
@@ -527,4 +528,10 @@ static inline bool virtio_device_disabled(VirtIODevice *vdev)
 bool virtio_legacy_allowed(VirtIODevice *vdev);
 bool virtio_legacy_check_disabled(VirtIODevice *vdev);
 
+QEMUBH *virtio_bh_new_guarded_full(VirtIODevice *vdev,
+                                   QEMUBHFunc *cb, void *opaque,
+                                   const char *name);
+#define virtio_bh_new_guarded(vdev, cb, opaque) \
+    virtio_bh_new_guarded_full((vdev), (cb), (opaque), (stringify(cb)))
+
 #endif
diff --git a/hw/virtio/virtio.c b/hw/virtio/virtio.c
index fb6b4ccd83..e1735cf7fd 100644
--- a/hw/virtio/virtio.c
+++ b/hw/virtio/virtio.c
@@ -4176,3 +4176,13 @@ static void virtio_register_types(void)
 }
 
 type_init(virtio_register_types)
+
+QEMUBH *virtio_bh_new_guarded_full(VirtIODevice *vdev,
+                                   QEMUBHFunc *cb, void *opaque,
+                                   const char *name)
+{
+    BusState *virtio_bus = qdev_get_parent_bus(DEVICE(vdev));
+    DeviceState *transport = virtio_bus->parent;
+
+    return qemu_bh_new_full(cb, opaque, name, &transport->mem_reentrancy_guard);
+}
-- 
2.41.0


