Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id CFE4BC25B78
	for <qemu-devel@archiver.kernel.org>; Tue,  4 Jun 2024 10:00:33 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sEQwD-00063G-N9; Tue, 04 Jun 2024 05:58:41 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1sEQw8-0005qZ-ES
 for qemu-devel@nongnu.org; Tue, 04 Jun 2024 05:58:36 -0400
Received: from mail-wm1-x336.google.com ([2a00:1450:4864:20::336])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1sEQw5-0002KT-GI
 for qemu-devel@nongnu.org; Tue, 04 Jun 2024 05:58:36 -0400
Received: by mail-wm1-x336.google.com with SMTP id
 5b1f17b1804b1-4214fe0067fso3750185e9.1
 for <qemu-devel@nongnu.org>; Tue, 04 Jun 2024 02:58:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1717495111; x=1718099911; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=JSS7Auq4rjMzsXWfz5GZCQIt8zRmJ+DnGC7DTwkUw/o=;
 b=gt9SidZVNko3upKcRpipSjF5pYz7twkzxZhDl2BhJ+xZ5usTBIp91e5cKQJu2Ntd3s
 ylKi07E9O5MkCu/dNNhdp6wI27ALTXvLtLsAxnD3rXy39tDsVEq9rLBsBjPTQ2NjJNFc
 96EHK5/NyQUUbCYIpM/DqqF3uj+4BMWl9j3WIaa+51KkoIa18bcIVZJDpb8TLYprfD6d
 5Y9BdjpH5SEtZlbs45Rq2y+z06OfSUtFmpjJzxlpltKVRetfE1VelvZiygR4H1aVLqmK
 Ha63BdIwOKwxlmNZzsvvGY6yMJRrfMnYO5JXP2QhFpy4N3MCXpb8H8JHkk6nIczsxhEY
 mLCw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1717495111; x=1718099911;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=JSS7Auq4rjMzsXWfz5GZCQIt8zRmJ+DnGC7DTwkUw/o=;
 b=ZuAW6sHaoppCTKXyHyOc89ffR8UexJLKODs6dYkbPYVVIeYTgMqN68yrMWkhbPwaUC
 MRjBY2LKyPiW61RaPcyRUHvU0x4iUPF8+UQBrWlyrQ4VgH23GBR2VDbWS4bCSj7hE7Pz
 93gHG7v1uP3v7hYDL4xNVnC3SeI7ZoTn6LvOS0/WYEKW6QHgcFvrWNSIApbYQUif9v+0
 or1RUUmie+jdCUf97CXdlU7UWWVqiKD/rpg2Z/Z9iZf6PoSPM5H1Cs0iuiY0j2Cr/ejR
 +YMtRILFqrDURyNmjsrzqGtRP/fPLq6Jt0ybBVWNnd4KBWTthwgEElaM2ezOuk7zdcWd
 X11A==
X-Gm-Message-State: AOJu0YxAtNrDvoq94+kZ1YVzkhQcCluj3lNw9sK1z2RqQHoqUlAZ73zr
 KfHmGLDgG4B5+vAP0HvVnaszqVPV8RU3ofvvL0lE6M/z36iPHi+PYA7ib04xFb1Lubh8pLspXRK
 h
X-Google-Smtp-Source: AGHT+IEqZw8J1TvbFkkIzX9qRVJETCTGRQ2hTRyRRgoRWNi9EdONdKrG6MB2qGUfMV36SucEB1WWkA==
X-Received: by 2002:a5d:58c3:0:b0:35e:81b0:e28f with SMTP id
 ffacd0b85a97d-35e81b0e4efmr299450f8f.40.1717495111682; 
 Tue, 04 Jun 2024 02:58:31 -0700 (PDT)
Received: from m1x-phil.lan ([176.176.159.34])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-35dd04c0d6csm11105972f8f.1.2024.06.04.02.58.30
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Tue, 04 Jun 2024 02:58:31 -0700 (PDT)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
To: qemu-devel@nongnu.org
Cc: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Paul Durrant <paul@xen.org>
Subject: [PULL 26/32] hw/xen: Register framebuffer backend via
 xen_backend_init()
Date: Tue,  4 Jun 2024 11:56:02 +0200
Message-ID: <20240604095609.12285-27-philmd@linaro.org>
X-Mailer: git-send-email 2.41.0
In-Reply-To: <20240604095609.12285-1-philmd@linaro.org>
References: <20240604095609.12285-1-philmd@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::336;
 envelope-from=philmd@linaro.org; helo=mail-wm1-x336.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
 T_SCC_BODY_TEXT_LINE=-0.01 autolearn=ham autolearn_force=no
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

Align the framebuffer backend with the other legacy ones,
register it via xen_backend_init() when '-vga xenfb' is
used. It is safe because MODULE_INIT_XEN_BACKEND is called
in xen_bus_realize(), long after CLI processing initialized
the vga_interface_type variable.

Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
Reviewed-by: Paul Durrant <paul@xen.org>
Message-Id: <20240510104908.76908-8-philmd@linaro.org>
---
 include/hw/xen/xen-legacy-backend.h | 3 ---
 hw/display/xenfb.c                  | 9 +++++++--
 hw/xenpv/xen_machine_pv.c           | 2 --
 3 files changed, 7 insertions(+), 7 deletions(-)

diff --git a/include/hw/xen/xen-legacy-backend.h b/include/hw/xen/xen-legacy-backend.h
index e55a14057f..943732b8d1 100644
--- a/include/hw/xen/xen-legacy-backend.h
+++ b/include/hw/xen/xen-legacy-backend.h
@@ -66,9 +66,6 @@ static inline void xen_be_unmap_grant_ref(struct XenLegacyDevice *xendev,
     return xen_be_unmap_grant_refs(xendev, ptr, &ref, 1);
 }
 
-/* backend drivers not included in all machines */
-extern const struct XenDevOps xen_framebuffer_ops;  /* xenfb.c */
-
 /* configuration (aka xenbus setup) */
 void xen_config_cleanup(void);
 int xen_config_dev_vfb(int vdev, const char *type);
diff --git a/hw/display/xenfb.c b/hw/display/xenfb.c
index b6d370bdf6..ff442ced1a 100644
--- a/hw/display/xenfb.c
+++ b/hw/display/xenfb.c
@@ -29,6 +29,7 @@
 
 #include "ui/input.h"
 #include "ui/console.h"
+#include "sysemu/sysemu.h"
 #include "hw/xen/xen-legacy-backend.h"
 
 #include "hw/xen/interface/io/fbif.h"
@@ -996,8 +997,12 @@ static const GraphicHwOps xenfb_ops = {
     .ui_info     = xenfb_ui_info,
 };
 
-static void xen_vkbd_register_backend(void)
+static void xen_ui_register_backend(void)
 {
     xen_be_register("vkbd", &xen_kbdmouse_ops);
+
+    if (vga_interface_type == VGA_XENFB) {
+        xen_be_register("vfb", &xen_framebuffer_ops);
+    }
 }
-xen_backend_init(xen_vkbd_register_backend);
+xen_backend_init(xen_ui_register_backend);
diff --git a/hw/xenpv/xen_machine_pv.c b/hw/xenpv/xen_machine_pv.c
index b500ce0989..24395f42cb 100644
--- a/hw/xenpv/xen_machine_pv.c
+++ b/hw/xenpv/xen_machine_pv.c
@@ -50,8 +50,6 @@ static void xen_init_pv(MachineState *machine)
         break;
     }
 
-    xen_be_register("vfb", &xen_framebuffer_ops);
-
     /* configure framebuffer */
     if (vga_interface_type == VGA_XENFB) {
         xen_config_dev_vfb(0, "vnc");
-- 
2.41.0


