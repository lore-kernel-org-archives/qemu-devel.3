Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7AF5FCD1284
	for <qemu-devel@archiver.kernel.org>; Tue,  9 Apr 2024 10:56:14 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1ru98p-0001N9-8o; Tue, 09 Apr 2024 06:55:51 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1ru98o-0001N0-HM
 for qemu-devel@nongnu.org; Tue, 09 Apr 2024 06:55:50 -0400
Received: from mail-lj1-x235.google.com ([2a00:1450:4864:20::235])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1ru98m-000355-RC
 for qemu-devel@nongnu.org; Tue, 09 Apr 2024 06:55:50 -0400
Received: by mail-lj1-x235.google.com with SMTP id
 38308e7fff4ca-2d89346eb45so24329611fa.0
 for <qemu-devel@nongnu.org>; Tue, 09 Apr 2024 03:55:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1712660146; x=1713264946; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=3F/dkK0NgSzUFlZfqjm2SxtzBV4mhAilLiKtDZ6AMsk=;
 b=hai15fzDVniOa31ue0+WEPkcMx9keI8SAjNL3OMzI+jkzMW+8xJQ0m758TYrgBoub/
 L7uoRgQMZKpeJ5wIwHaAE4uIBTmZzhFdBnzMRXF7fibkPNBO1wYVitzyueGyLP/6qiqO
 itNhZoUsNFfF3Gmzprd/s5YW7Rsv1LeF+DonuzwUd0bL6Glw35Pk6VVXu/ugi5mWhp+S
 2hqussnqytvthybZ4DdW335DVe6vshzeykyw+N558wws3GUO0HpC7j9G+gj09D5OT1x8
 c/vym+s+/b/RfSxwUdZMeKLlD3UzOGApas9YQFB8N3XMxQNfMbRA2kjEkUa8P3Nb3RVe
 W0ug==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1712660146; x=1713264946;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=3F/dkK0NgSzUFlZfqjm2SxtzBV4mhAilLiKtDZ6AMsk=;
 b=p4kMh429ibtafQTSHZDwqGupozhN81mF1Y45Cn8KpnWZ/Fuk0EHPWOtKW/6i15pAZ+
 0ES9pkENI48X2ZuA9YPzJY8YOX850vO/AQP1BPx10WFw89B+X0y6PvO/V3dem6+o2szd
 /Wl9Hm1rjudaumDB9cAgHRpip1PTuc2xqu7Fi0MwbbKXFs/2ILaIedMurVQ/LGn9CMYn
 81PVlf40NJ2ZHU+wgIq9pI+pzpeVPCtwKqIU5Uw3J522aOdu+Fc/RXnM9WsYLGwkBe8N
 noJEA6FICy73FYvU4ZQoyF8Wl7a6ALW+tSAliGCvN3+bEmIrDHtfZ4VCNTEH5UiKZD22
 d+pg==
X-Gm-Message-State: AOJu0YxG/0zabUhqkSyF9D6zQybnuUcB2V77tHelj2NyzWaTc9sMS93k
 jbeNE9jNPuAhdC3IfsPBRZfnaH72oNnOI95Pb/NXCeTk6M3gSWj1JdF62F+Tu3cqX9IS08ZHkAR
 U
X-Google-Smtp-Source: AGHT+IFv9lNv8ryZ8e0xrwprGE2PTFnQGFV/WKkA2sdjC4x+HQINVm5kvRblbB0Nb/FQaQZnjAm/QQ==
X-Received: by 2002:a2e:924b:0:b0:2d8:5b34:b9ab with SMTP id
 v11-20020a2e924b000000b002d85b34b9abmr9692442ljg.34.1712660146429; 
 Tue, 09 Apr 2024 03:55:46 -0700 (PDT)
Received: from m1x-phil.lan ([176.176.160.134])
 by smtp.gmail.com with ESMTPSA id
 el4-20020a170907284400b00a51b3410e46sm4525826ejc.7.2024.04.09.03.55.45
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Tue, 09 Apr 2024 03:55:46 -0700 (PDT)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
To: qemu-devel@nongnu.org
Cc: Amit Shah <amit@kernel.org>, Paolo Bonzini <pbonzini@redhat.com>,
 "Gonglei (Arei)" <arei.gonglei@huawei.com>,
 Laurent Vivier <lvivier@redhat.com>, Gerd Hoffmann <kraxel@redhat.com>,
 "Michael S. Tsirkin" <mst@redhat.com>,
 =?UTF-8?q?Marc-Andr=C3=A9=20Lureau?= <marcandre.lureau@redhat.com>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
Subject: [PATCH-for-9.0 v2 1/4] hw/virtio: Introduce virtio_bh_new_guarded()
 helper
Date: Tue,  9 Apr 2024 12:55:34 +0200
Message-ID: <20240409105537.18308-2-philmd@linaro.org>
X-Mailer: git-send-email 2.41.0
In-Reply-To: <20240409105537.18308-1-philmd@linaro.org>
References: <20240409105537.18308-1-philmd@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::235;
 envelope-from=philmd@linaro.org; helo=mail-lj1-x235.google.com
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
Reviewed-by: Gerd Hoffmann <kraxel@redhat.com>
Acked-by: Michael S. Tsirkin <mst@redhat.com>
Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
---
 include/hw/virtio/virtio.h |  7 +++++++
 hw/virtio/virtio.c         | 10 ++++++++++
 2 files changed, 17 insertions(+)

diff --git a/include/hw/virtio/virtio.h b/include/hw/virtio/virtio.h
index b3c74a1bca..a4388c7db3 100644
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
 
+QEMUBH *virtio_bh_new_guarded_full(DeviceState *dev,
+                                   QEMUBHFunc *cb, void *opaque,
+                                   const char *name);
+#define virtio_bh_new_guarded(dev, cb, opaque) \
+    virtio_bh_new_guarded_full((dev), (cb), (opaque), (stringify(cb)))
+
 #endif
diff --git a/hw/virtio/virtio.c b/hw/virtio/virtio.c
index fb6b4ccd83..efe02deb77 100644
--- a/hw/virtio/virtio.c
+++ b/hw/virtio/virtio.c
@@ -4176,3 +4176,13 @@ static void virtio_register_types(void)
 }
 
 type_init(virtio_register_types)
+
+QEMUBH *virtio_bh_new_guarded_full(DeviceState *dev,
+                                   QEMUBHFunc *cb, void *opaque,
+                                   const char *name)
+{
+    DeviceState *transport = qdev_get_parent_bus(dev)->parent;
+
+    return qemu_bh_new_full(cb, opaque, name,
+                            &transport->mem_reentrancy_guard);
+}
-- 
2.41.0


