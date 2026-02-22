Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 06F7AC6369E
	for <qemu-devel@archiver.kernel.org>; Sun, 22 Feb 2026 23:24:04 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vuIms-0003e0-FZ; Sun, 22 Feb 2026 18:22:54 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1vuImr-0003dl-PB
 for qemu-devel@nongnu.org; Sun, 22 Feb 2026 18:22:53 -0500
Received: from mail-wm1-x32d.google.com ([2a00:1450:4864:20::32d])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1vuImp-000154-Pq
 for qemu-devel@nongnu.org; Sun, 22 Feb 2026 18:22:53 -0500
Received: by mail-wm1-x32d.google.com with SMTP id
 5b1f17b1804b1-48069a48629so38418915e9.0
 for <qemu-devel@nongnu.org>; Sun, 22 Feb 2026 15:22:51 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1771802570; x=1772407370; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
 :reply-to; bh=225TRUen1v6UrPUYAsvEDGTLDbDIBVr5PBF8l5nUIB8=;
 b=jouCsZEDwykVIrF0OiVKPMj5TvzaSmrb76w+41q2WrGEWU4p+H6jEbu9wbc6G894Ux
 cUVInxglxfuAwniYARHGfYK5SGaEvKUL46w2AuJ0iQjLPCtTI68vz01wbH2pykSriMly
 CXcmSChFubrqN7DvIbY9qrvkShh0W4npYI0t+34aIdGXM96DnR20izokq7DZU7Soyx0q
 JK16qouMhw5UeVTTHJ7dr5x72/kfJU4jcCwzfgebndMNaQaZ/WOsxuSasKVzHXCs9nHp
 y29FjeYSBYsm21AHHEKIFVhYtFh0Ez5XeICZR4Gdc2N904U4xwMqDR5r/osw8nJWMXi3
 pgkw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1771802570; x=1772407370;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:x-gm-gg:x-gm-message-state:from:to
 :cc:subject:date:message-id:reply-to;
 bh=225TRUen1v6UrPUYAsvEDGTLDbDIBVr5PBF8l5nUIB8=;
 b=aXt/Tja09OYmRku8SWmdHCNkiA0SxOe35tQbmZW9HU8F3oI1wSVI0WSB3A4oIZA8um
 Mn7/VENWr4dnJaKFnhGcLASt4BAvcWcmQ4y5vZqkyB86r+kHFefsNOAfeHdW8Rqjonkh
 8hyqY9XRFLon/J2ygJLb5+cEiqAgHSJrvbpkOOm3AbuJxe967/wPuaaFlxQhESK+BzZI
 YJqySw7zVc2FUvsfejhTOvjtw/lQzjcACDIMFDj5DN7rWoOYy5JqwzL97n4OYW8TaGw/
 KGT0qCw4r2s1USQ5QxUkoJN+y1aaD3gAqxSBc90/OdLemVz7sOgEwTbQjMNPSL06FrnQ
 OyUg==
X-Gm-Message-State: AOJu0YyaXoLpFqFKsxhvNMmbQi6APbXG1UdUt4AHk2/z0KCfd0s81f64
 Yuo5Nym5vSCtP+oCCD4eAjE8457fH4C1kR3d3lvstiIGzFA/gUWqOEDx4lnaPGkZwQFLf9K4M/P
 XEmByzEc=
X-Gm-Gg: AZuq6aK6zOpMRc5Ia0LoBvi6XOV9fI9LZdUYy+codBOmfV2pjSuv/aAJkD17tpwuvNi
 v0t6hOK0pKUs5DBNE6PBGf3Rd5erHFvPEJ5OgUw0L5oLZOtceJf+gGvezsC4Ly2C6XFQmQUaiqY
 3yA626V6Pm1ipFNWBUa+YwOmqSQPpQf4mWbJmy041fmWZsbeG+iafbeXDygFUmGuhIubq0Kn2xu
 6j1QTV1PJINgW5Kpwr13QUvxXkv3VkmSjbNN+UaJVxfrpzLqziqu4c6HiZbhTUc2HoS3tL/pBbg
 ummsLhAsRzVqw6AC8vWaCBGX29VfS3o+e3utYi5zs1hq/ia6Qwx2oQZHRRzX6zNWqYG00W9cJ4f
 Rv66UKNbYBq63v0gZugW5QdPdNAQEE+ZVRNCpFTIBQVzzSbATmyPS7hHYWE9zZDwAIlIpq21wBq
 OvC4mNzy9hQlRhNpKDr0p60NbdFH4/Cj4LzEKSsh6V2iIR7f7/mGkD7YL/akwfRRydPBkfQ4os
X-Received: by 2002:a05:600c:5397:b0:483:71f9:37f3 with SMTP id
 5b1f17b1804b1-483a95a85c0mr119333875e9.1.1771802569904; 
 Sun, 22 Feb 2026 15:22:49 -0800 (PST)
Received: from localhost.localdomain (88-187-86-199.subs.proxad.net.
 [88.187.86.199]) by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-483a82d8c50sm62883625e9.6.2026.02.22.15.22.49
 for <qemu-devel@nongnu.org>
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Sun, 22 Feb 2026 15:22:49 -0800 (PST)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
To: qemu-devel@nongnu.org
Subject: [PULL v2 10/21] hw/sparc: Set graphic display dimensions generically
Date: Mon, 23 Feb 2026 00:22:20 +0100
Message-ID: <20260222232222.7183-5-philmd@linaro.org>
X-Mailer: git-send-email 2.52.0
In-Reply-To: <20260222232222.7183-1-philmd@linaro.org>
References: <20260222232222.7183-1-philmd@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::32d;
 envelope-from=philmd@linaro.org; helo=mail-wm1-x32d.google.com
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

If a dimension is not set, have the machine init code
set the default values.

Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
Reviewed-by: Pierrick Bouvier <pierrick.bouvier@linaro.org>
Reviewed-by: Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>
Message-Id: <20260216213121.47122-7-philmd@linaro.org>
---
 hw/sparc/sun4m.c        |  9 +++++++++
 hw/sparc64/sun4u.c      | 10 ++++++++++
 system/globals-target.c |  6 +-----
 3 files changed, 20 insertions(+), 5 deletions(-)

diff --git a/hw/sparc/sun4m.c b/hw/sparc/sun4m.c
index 0c0d658d301..a17bdb36927 100644
--- a/hw/sparc/sun4m.c
+++ b/hw/sparc/sun4m.c
@@ -892,6 +892,15 @@ static void sun4m_hw_init(MachineState *machine)
                      hwdef->esp_base, slavio_irq[18],
                      hwdef->le_base, slavio_irq[16], &hostid);
 
+    if (!graphic_width) {
+        graphic_width = 1024;
+    }
+    if (!graphic_height) {
+        graphic_height = 768;
+    }
+    if (!graphic_depth) {
+        graphic_depth = 8;
+    }
     if (graphic_depth != 8 && graphic_depth != 24) {
         error_report("Unsupported depth: %d", graphic_depth);
         exit (1);
diff --git a/hw/sparc64/sun4u.c b/hw/sparc64/sun4u.c
index 5d7787fc1a5..b8bda1eb816 100644
--- a/hw/sparc64/sun4u.c
+++ b/hw/sparc64/sun4u.c
@@ -666,6 +666,16 @@ static void sun4uv_init(MemoryRegion *address_space_mem,
                                 sysbus_mmio_get_region(s, 0));
     nvram = NVRAM(dev);
  
+    if (!graphic_width) {
+        graphic_width = 1024;
+    }
+    if (!graphic_height) {
+        graphic_height = 768;
+    }
+    if (!graphic_depth) {
+        graphic_depth = 8;
+    }
+
     initrd_size = 0;
     initrd_addr = 0;
     kernel_size = sun4u_load_kernel(machine->kernel_filename,
diff --git a/system/globals-target.c b/system/globals-target.c
index e3f7d846ac0..17a27a06218 100644
--- a/system/globals-target.c
+++ b/system/globals-target.c
@@ -9,11 +9,7 @@
 #include "qemu/osdep.h"
 #include "system/system.h"
 
-#ifdef TARGET_SPARC
-int graphic_width = 1024;
-int graphic_height = 768;
-int graphic_depth = 8;
-#elif defined(TARGET_M68K)
+#if defined(TARGET_SPARC) || defined(TARGET_M68K)
 int graphic_width;
 int graphic_height;
 int graphic_depth;
-- 
2.52.0


