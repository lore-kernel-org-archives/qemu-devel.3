Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 823EACCD1AA
	for <qemu-devel@archiver.kernel.org>; Tue, 21 Oct 2025 20:48:09 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vBJGD-0004jJ-PK; Tue, 21 Oct 2025 16:47:13 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1vBJGC-0004iw-Eb
 for qemu-devel@nongnu.org; Tue, 21 Oct 2025 16:47:12 -0400
Received: from mail-wr1-x42c.google.com ([2a00:1450:4864:20::42c])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1vBJGA-00012I-82
 for qemu-devel@nongnu.org; Tue, 21 Oct 2025 16:47:12 -0400
Received: by mail-wr1-x42c.google.com with SMTP id
 ffacd0b85a97d-4285169c005so487084f8f.0
 for <qemu-devel@nongnu.org>; Tue, 21 Oct 2025 13:47:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1761079628; x=1761684428; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
 :reply-to; bh=h2Si+mJWkJrlCMUzyJdIDCI/yIQ7Fr+yrGGAP8w/vlU=;
 b=S2WVc5W2sivWyabA0PPVSesJX2jIsU+sMrkMOGecjPo3vN7aS8PunCUOis3jHKeemw
 kK2V8mMpVfmCo1nAjgzepzUtsB54QKrt06VB/3AWgGNVLlxEhbTqEMYHFMmy4kIbKIQU
 PSCHlps7gHlkqdCffnsCEQSa/ghbxqA6/b5toqC5uDE8kNL1VNyo1SjKaEqk5jfzIscM
 PKJWQldc0RwUy8yK1IS++pXy9lEzsCC6ZKgh6Ms+R1QKPHD+jduEJXH2/PbXWKj+X/iT
 Df+OMYcRpoGYGSY3ZdKaXo/2OJsImFUBIDuhiOF6UMLVVhW0NuMPDTkoes9z8t7beXaA
 W+1g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1761079628; x=1761684428;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=h2Si+mJWkJrlCMUzyJdIDCI/yIQ7Fr+yrGGAP8w/vlU=;
 b=lshr01E0hiwi05AmwDYjIj8WIsRIYSz15JSbNByQJ2uK9RWKBRD6RndYGuaV1de75U
 fWJ8wM/Izz8ORxbqs/ToZ99m34dPPSsuhqgV5/+CLY/bU3kqGrJ5P1C6Tk0AOG3KWfja
 FmY5aU4vS3elQxdJRFFqyVA2lC/+cLaGwIKK4Ity/ZvcMEpbcv9+VG+lTbKAshGMuq7o
 oN012HUatr9PK8xanQAcrN5AD/VLBjg48//HsJ5Pj09asygcP6LFDh9cyY61bNnT5ECa
 Bg8ELvqxseVNXtMWHSTZzrTZRcWS0rdmK5sL416RsfB337jIoHdaNs7ykUrC7/ZyjHDk
 AFDg==
X-Gm-Message-State: AOJu0YwoV4asxl6L5qt/MCAEj4cY6VohkfU3+wCK/DrVhgURqhv3JT9t
 AN5ag8TW9miMKlfzxg97gQee8agUCObQPN1ENyH2mWMQ4EJPEWfoK+uxqLIv7J7ZTzL42qFpSbi
 nO1fJqRA=
X-Gm-Gg: ASbGncsj99SElRZrh5bKAVJTmrzO4rOllWqlalWfKVAEA2LTD58g/AOsUrpkdY93+VC
 E4Jh0N4yVMcBVhZZTGg/gaZYtqBFD7alWoL83F1/MW5vvFfZmKs8bpYRG/+26Afwfy144BNa0rT
 qWU/twM+nvPLZ5m2B7QrLEsLM1ZiNnNjtjLsJvLr9VswIMJbe5/k7fzeM+XhkAP6SYO+FfvId8B
 iV1Ma11fYayog9pajgi98phznp5gWPN+YhS51YAAlxUfkomT9bAbSnkuuu6fO+vQlCMifeSebYG
 hT/WBLCcSXeIFu/vLGY/DMn1GqlWfnju4zD5mxsxWeymbKSHn1AvZRpzRKqpl6+a9R8Qrf2D8AY
 cTtf7yAx3ZSM59X7oZHPQX4fApRZ+P8+oxU66rAbVi19jcp8P06c9xSR0BqFFpoR7lVwdk++FVN
 4pd5seW4Qf4cpyL9gkxHyYYooz4PWySu323SWWSkrfcZx9gJPWqg==
X-Google-Smtp-Source: AGHT+IFns7fQqBu0rwakO++TuxNGLsQP+qNtcuIaKEQzTSdtPd35VB3+sfGVbHjUawFHuaE4zMt6oA==
X-Received: by 2002:a05:6000:22c5:b0:427:492:79e5 with SMTP id
 ffacd0b85a97d-42704d7504emr11058490f8f.21.1761079627784; 
 Tue, 21 Oct 2025 13:47:07 -0700 (PDT)
Received: from localhost.localdomain (88-187-86-199.subs.proxad.net.
 [88.187.86.199]) by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-427f00ba01bsm21596285f8f.41.2025.10.21.13.47.05
 for <qemu-devel@nongnu.org>
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Tue, 21 Oct 2025 13:47:06 -0700 (PDT)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
To: qemu-devel@nongnu.org
Subject: [PULL 01/45] hw/virtio/virtio-mem: Convert VIRTIO_MEM_USABLE_EXTENT
 to runtime
Date: Tue, 21 Oct 2025 22:46:15 +0200
Message-ID: <20251021204700.56072-2-philmd@linaro.org>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <20251021204700.56072-1-philmd@linaro.org>
References: <20251021204700.56072-1-philmd@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::42c;
 envelope-from=philmd@linaro.org; helo=mail-wr1-x42c.google.com
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

Use target_arch() to check at runtime which target architecture
is being run.

Note, since TARGET_ARM is defined for TARGET_AARCH64, we
check for both ARM & AARCH64 enum values.

Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
Reviewed-by: Pierrick Bouvier <pierrick.bouvier@linaro.org>
Acked-by: David Hildenbrand <david@redhat.com>
Reviewed-by: Michael S. Tsirkin <mst@redhat.com>
Message-Id: <20250502214551.80401-4-philmd@linaro.org>
---
 hw/virtio/virtio-mem.c | 24 ++++++++++++++++--------
 1 file changed, 16 insertions(+), 8 deletions(-)

diff --git a/hw/virtio/virtio-mem.c b/hw/virtio/virtio-mem.c
index 15ba6799f22..f16445b9347 100644
--- a/hw/virtio/virtio-mem.c
+++ b/hw/virtio/virtio-mem.c
@@ -15,6 +15,7 @@
 #include "qemu/cutils.h"
 #include "qemu/error-report.h"
 #include "qemu/units.h"
+#include "qemu/target-info-qapi.h"
 #include "system/numa.h"
 #include "system/system.h"
 #include "system/ramblock.h"
@@ -170,13 +171,20 @@ static bool virtio_mem_has_shared_zeropage(RAMBlock *rb)
  * necessary (as the section size can change). But it's more likely that the
  * section size will rather get smaller and not bigger over time.
  */
-#if defined(TARGET_X86_64) || defined(TARGET_I386) || defined(TARGET_S390X)
-#define VIRTIO_MEM_USABLE_EXTENT (2 * (128 * MiB))
-#elif defined(TARGET_ARM)
-#define VIRTIO_MEM_USABLE_EXTENT (2 * (512 * MiB))
-#else
-#error VIRTIO_MEM_USABLE_EXTENT not defined
-#endif
+static uint64_t virtio_mem_usable_extent_size(void)
+{
+    switch (target_arch()) {
+    case SYS_EMU_TARGET_I386:
+    case SYS_EMU_TARGET_X86_64:
+    case SYS_EMU_TARGET_S390X:
+        return 2 * 128 * MiB;
+    case SYS_EMU_TARGET_AARCH64:
+    case SYS_EMU_TARGET_ARM:
+        return 2 * 512 * MiB;
+    default:
+        g_assert_not_reached();
+    }
+}
 
 static bool virtio_mem_is_busy(void)
 {
@@ -699,7 +707,7 @@ static void virtio_mem_resize_usable_region(VirtIOMEM *vmem,
                                             bool can_shrink)
 {
     uint64_t newsize = MIN(memory_region_size(&vmem->memdev->mr),
-                           requested_size + VIRTIO_MEM_USABLE_EXTENT);
+                           requested_size + virtio_mem_usable_extent_size());
 
     /* The usable region size always has to be multiples of the block size. */
     newsize = QEMU_ALIGN_UP(newsize, vmem->block_size);
-- 
2.51.0


