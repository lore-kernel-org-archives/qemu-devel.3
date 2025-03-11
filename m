Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 32DF4C282EC
	for <qemu-devel@archiver.kernel.org>; Tue, 11 Mar 2025 19:53:19 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1ts5ek-0007fs-Iy; Tue, 11 Mar 2025 15:52:51 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1ts5eO-0007YC-7d
 for qemu-devel@nongnu.org; Tue, 11 Mar 2025 15:52:29 -0400
Received: from mail-wm1-x32f.google.com ([2a00:1450:4864:20::32f])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1ts5eM-0007b5-Eo
 for qemu-devel@nongnu.org; Tue, 11 Mar 2025 15:52:27 -0400
Received: by mail-wm1-x32f.google.com with SMTP id
 5b1f17b1804b1-43cf05f0c3eso19735515e9.0
 for <qemu-devel@nongnu.org>; Tue, 11 Mar 2025 12:52:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1741722744; x=1742327544; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=6pPHUcmotQ2rkbUdZZNWdsu4jVRIsLE/Gfct1AtODJ4=;
 b=L3DY0cb0218D5TlAvnn41AtNeXkeIQ4Jcwp1XNTq067zEwpj8bu6TGGKRCywE0xelu
 aI+QHUAoN7ASsVJwtHQSR8x4py3kbFONeJmXqcKWMDrqtP61e5WTeRnt7jFB45QYBsXs
 dBJIeyyiRFk/9mMxQBqZO08LW933Pb27SY1/390PHsYtwxKAOMnJptKqTu0beMxAh4qp
 yVriGfmEigKBU4tulNWm8A+O+UpeN6oecTofXJe60yrpIFoRGDdFqURzBe38kGw2hiOA
 kufkGnxDOdqawZZPH7wrPiHz2Gt905rCRmofVgHBn3TPdRhVJJyM6d4G9/pQ5nfKjSMj
 laxA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1741722744; x=1742327544;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=6pPHUcmotQ2rkbUdZZNWdsu4jVRIsLE/Gfct1AtODJ4=;
 b=tz0etDesKqhbWPl27y/SISsp+z/yCtjW+1sewqam9xlLLFXW/bL8nBIOZUpUuZ41Me
 VPV9ZodrXCVSHHHjqmHSuhl8kbaqm+MILG/4g+OcP4KuB4HvzyMSyUQhBhR76Q9yg2xO
 de5BPcJBOn9Zyvwquq8OGFuju4BWOmeAkP+pajGw0QGlWjYvqE8o3uH9zowYAjbyNSKo
 4UUQF2x90fk6AjIecosiEZAgBwGtJp5XOj6iLLQ2hdOdw2DHe482UtMnwdHvbZ0uAPAO
 IFBic28xN5QOTfuCSb1SKZrm4rgtH7F37hvJubPHdd2r9Vg6IevBZSFMcKh6SmFVawGS
 jdlA==
X-Gm-Message-State: AOJu0YxF54t84z4Dmh1Ft5vivvZZaJkw8p1J+u1DMrwTradlFUFKZWN5
 YalP7UlBlsAVyiCSdwOcjshEmIRkk+Y7sqvAMT8Q5O4IV7iYT++ty3gJNOS6Q7XBsnT7FDNjOUm
 WsAc=
X-Gm-Gg: ASbGncuJs+ZBiEVPubdQm7CDg82NLlwkqEExM4o8fcbtnqZ31Kt9EnIALygWCth1fnC
 U/hMpjrZcdZ4kofmY8lp0sIXyR0a6m401sijBe7nOkGLz0fy2JyFSFweRdp0g54+0IqCY+iPgIW
 YncDe6RRvW6ZRVUsCuplWyLXYH8nczqeI/CLtVwyyVgsy1Lc0naY2r8IY3bRINV8WKJiuKLRBkc
 NVDtfVZcoCXpykCXNehb+bYbSy94o8EtWoA9JwCf/kYcmtiVLjDwtYrBwaVwXTP2yhs90i7e9Y4
 j/NZFj8g3QHfJPSBmqpgom0iZ6+p1fI4BhPEt7ALMnB9Suwg3il69WzghwZ7EShoQTKwjOzDV6M
 705LurnPqVBOSFUc54HA=
X-Google-Smtp-Source: AGHT+IFhD7v2RgHUHk8O5vK2kRzYxR9EGbeB4XlBX7XdzarBWH3cONAixUnadWAp2bLhYMAftuhjNQ==
X-Received: by 2002:a05:600c:3596:b0:43c:f8fc:f697 with SMTP id
 5b1f17b1804b1-43cf8fcf8e0mr72805645e9.9.1741722744184; 
 Tue, 11 Mar 2025 12:52:24 -0700 (PDT)
Received: from localhost.localdomain (88-187-86-199.subs.proxad.net.
 [88.187.86.199]) by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-3912bfb7aefsm18716456f8f.20.2025.03.11.12.52.22
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Tue, 11 Mar 2025 12:52:23 -0700 (PDT)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
To: qemu-devel@nongnu.org
Cc: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 David Hildenbrand <david@redhat.com>,
 Pierrick Bouvier <pierrick.bouvier@linaro.org>
Subject: [PULL 12/14] hw/virtio/virtio-mem: Remove CONFIG_DEVICES include
Date: Tue, 11 Mar 2025 20:51:21 +0100
Message-ID: <20250311195123.94212-13-philmd@linaro.org>
X-Mailer: git-send-email 2.47.1
In-Reply-To: <20250311195123.94212-1-philmd@linaro.org>
References: <20250311195123.94212-1-philmd@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::32f;
 envelope-from=philmd@linaro.org; helo=mail-wm1-x32f.google.com
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

Rather than checking ACPI availability at compile time by
checking the CONFIG_ACPI definition from CONFIG_DEVICES,
check at runtime via acpi_builtin().

Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
Reviewed-by: David Hildenbrand <david@redhat.com>
Reviewed-by: Pierrick Bouvier <pierrick.bouvier@linaro.org>
Message-Id: <20250307223949.54040-5-philmd@linaro.org>
---
 hw/virtio/virtio-mem.c | 6 ++----
 1 file changed, 2 insertions(+), 4 deletions(-)

diff --git a/hw/virtio/virtio-mem.c b/hw/virtio/virtio-mem.c
index 7b140add765..5f57eccbb66 100644
--- a/hw/virtio/virtio-mem.c
+++ b/hw/virtio/virtio-mem.c
@@ -28,7 +28,7 @@
 #include "migration/misc.h"
 #include "hw/boards.h"
 #include "hw/qdev-properties.h"
-#include CONFIG_DEVICES
+#include "hw/acpi/acpi.h"
 #include "trace.h"
 
 static const VMStateDescription vmstate_virtio_mem_device_early;
@@ -883,10 +883,8 @@ static uint64_t virtio_mem_get_features(VirtIODevice *vdev, uint64_t features,
     MachineState *ms = MACHINE(qdev_get_machine());
     VirtIOMEM *vmem = VIRTIO_MEM(vdev);
 
-    if (ms->numa_state) {
-#if defined(CONFIG_ACPI)
+    if (ms->numa_state && acpi_builtin()) {
         virtio_add_feature(&features, VIRTIO_MEM_F_ACPI_PXM);
-#endif
     }
     assert(vmem->unplugged_inaccessible != ON_OFF_AUTO_AUTO);
     if (vmem->unplugged_inaccessible == ON_OFF_AUTO_ON) {
-- 
2.47.1


