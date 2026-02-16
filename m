Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8C0C8E83837
	for <qemu-devel@archiver.kernel.org>; Mon, 16 Feb 2026 21:32:43 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vs6Cs-0002GH-UM; Mon, 16 Feb 2026 16:32:39 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1vs6CR-00016f-SG
 for qemu-devel@nongnu.org; Mon, 16 Feb 2026 16:32:24 -0500
Received: from mail-wm1-x334.google.com ([2a00:1450:4864:20::334])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1vs6CQ-00044P-9L
 for qemu-devel@nongnu.org; Mon, 16 Feb 2026 16:32:11 -0500
Received: by mail-wm1-x334.google.com with SMTP id
 5b1f17b1804b1-48378136adcso18390125e9.1
 for <qemu-devel@nongnu.org>; Mon, 16 Feb 2026 13:32:09 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1771277528; x=1771882328; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=pMtVGcZy0xyurJAQ1/i7z0i0Ln6l5I0t8FfNIVKbubI=;
 b=utzVSv5s5IquZl2aUXN35VMXZ930vmTL4geek7Lmj/QudWiyMpOc0/nVOqscWM6GCa
 MNgePc7XrjgNqS2iVKiKy3BornpJHwXwCyO0YA4SpQ6ur6zgB55W5qmmW8VnDsqnlYHj
 hWFP7FksyvDxPRMlxAXAiOCu7lAVMRPqeCIGelImkG7r8q9p2r1Oc4DILz+N7E1qP2c4
 F9Dcl7g9DwnY/rg1GMplOlT4+B6fULr1QlaPROahm3Lbzsk4netq7mgQXNYWqZl0aa3W
 HSJtkn9H9E9R35MuU/ILfdXzdluZB343y6ZDXdaew2uwV9uzxS3PVyBMT8r8Mn3VR9tN
 gkgg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1771277528; x=1771882328;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=pMtVGcZy0xyurJAQ1/i7z0i0Ln6l5I0t8FfNIVKbubI=;
 b=gXg0pbW/nd6F6mHbzRgFMRHiQvnmJcpKvZNi10O1ElhUnlldGf5EodB1AYn6dzE5OJ
 DholMtUI6LOmaO/oMeLby2ZGuugulkdJfMq4U2XUU7GQtIVAqM7Y5zsjKZoyi1J/g4hy
 pObAfK8CTNxVeZlbqISVGz7gJJKER3/4poypCl/Z1jo2dFT070/nW3aXVGE+YOE0mdz9
 k7fjBJeMnsOi/4IAEBZ17UbTjxKzN4MKvY59GF9axv5txyXGcm/KKrMDj18/2Ycw8JOF
 812MAAmLWMrUGQsYsmG68fr3R48lZrwXMcmX+PEU5+z/SzB/FkQlP9AFP5U/+Klju89B
 n0jw==
X-Gm-Message-State: AOJu0YwMetkwLHIBljvaHae2PYRW6XJ48j4OgrKLnfVXpceOp7JSp/3R
 GUr+WfmBFSK68t8MoiBaabOLqBn7qB2Ab9qdlqVYRCf18s6Mue6OcMl2MjRzltD64BRwWsB5kgA
 xWXlPlnQ=
X-Gm-Gg: AZuq6aK2Duf0AUv5hPmeYKcJZ2KcJHIDBB9GwsXG/tFAsy2p9imObxgQqA8Nwh8zrG4
 s/K9JbTVWEj+nnGASPdH7x0Pzg8wLOukyAVLZjiBNvAXfqtCye0j230CJHBGpQgpR+h95rsSKBe
 zvH62Eqe5iOBtRRq3gZQxA6nJROqNlxNLUu3csy0PZjAfETQn4m6vHGWFdwsvUb8WI6YuMPKz0c
 EuSNPPwfrX5vAKdwgG73HkLix/X0+a+j2IJHwtzkQqId7IyVDTFtGzQkoS6f7w8cgngd9RuTmYL
 hdDSSKcAxPtswqA8KT3Ts00RupItIrknah/uJb/A7ojmuMZu0QjOqi1ZSSzveE3TO2ie6z6mPbV
 GHVCuty2P4MKb/pMHuypam+3JM2x44o8Kay+xQKWeLapQ8sHjjDtR33FttSngjDgqPnxGH4mNzJ
 AXu0httm242X3BvCUjBarHYF0gzH7gVDMuvWOsi5tKCQuE7QoiWAJrpO9eeoCFZu7HgWv8hlNY
X-Received: by 2002:a05:600c:3e06:b0:482:e5d4:b7ca with SMTP id
 5b1f17b1804b1-48379bac81dmr147236465e9.8.1771277528002; 
 Mon, 16 Feb 2026 13:32:08 -0800 (PST)
Received: from localhost.localdomain (88-187-86-199.subs.proxad.net.
 [88.187.86.199]) by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-48371a3f835sm91275755e9.25.2026.02.16.13.32.06
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Mon, 16 Feb 2026 13:32:07 -0800 (PST)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
To: qemu-devel@nongnu.org
Cc: Nicholas Piggin <npiggin@gmail.com>,
 =?UTF-8?q?Herv=C3=A9=20Poussineau?= <hpoussin@reactos.org>,
 Paolo Bonzini <pbonzini@redhat.com>, Chinmay Rath <rathc@linux.ibm.com>,
 Artyom Tarasenko <atar4qemu@gmail.com>,
 Pierrick Bouvier <pierrick.bouvier@linaro.org>,
 Laurent Vivier <laurent@vivier.eu>, qemu-ppc@nongnu.org,
 Harsh Prateek Bora <harshpb@linux.ibm.com>,
 Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
Subject: [PATCH v2 6/8] hw/sparc: Set graphic display dimensions generically
Date: Mon, 16 Feb 2026 22:31:19 +0100
Message-ID: <20260216213121.47122-7-philmd@linaro.org>
X-Mailer: git-send-email 2.52.0
In-Reply-To: <20260216213121.47122-1-philmd@linaro.org>
References: <20260216213121.47122-1-philmd@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::334;
 envelope-from=philmd@linaro.org; helo=mail-wm1-x334.google.com
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


