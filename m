Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 62B85C001CC
	for <qemu-devel@archiver.kernel.org>; Wed, 17 Apr 2024 18:31:43 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rxA2q-0004T9-An; Wed, 17 Apr 2024 14:30:08 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1rxA2g-00040i-MY
 for qemu-devel@nongnu.org; Wed, 17 Apr 2024 14:30:00 -0400
Received: from mail-ej1-x62d.google.com ([2a00:1450:4864:20::62d])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1rxA2b-0003ko-M2
 for qemu-devel@nongnu.org; Wed, 17 Apr 2024 14:29:56 -0400
Received: by mail-ej1-x62d.google.com with SMTP id
 a640c23a62f3a-a51aac16b6eso322119766b.1
 for <qemu-devel@nongnu.org>; Wed, 17 Apr 2024 11:29:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1713378591; x=1713983391; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=n0UB6yYdJ7G4jV8uDJ7wPEMwbZmtBQgbO2jPSnrKT98=;
 b=fSk4uxYokOVaUFqEjuTMy0dfw5Y93qtqkCi/m4E+Ws9TJxaf1zB2mtcajW+zzV1Csm
 w+CQnYvYPcDFc9JqdobVQ2+Rz+SaNlVIeWr0uzCh7BAoYJzYX6466hhl6B7ASlSZa8je
 Tpx+JrV2Jy5+sfrl/6UZDUJAZrMltbnZLOtVYUK3DyPUwOcPOzRHsPdxHGyboUSBUa33
 elx2xzUBdpDdMZfmhJeq7bQampzWIlAr8UcDQIDbdI2NcdnS1zqBOwTgszthO1aVADqn
 gtht8rHQhSZ5cseQkFx4UeYuHT1MmnzoouE5ih/HAvAV18S3+HGlf+nnZ8qSfR/s1ckf
 1EjA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1713378591; x=1713983391;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=n0UB6yYdJ7G4jV8uDJ7wPEMwbZmtBQgbO2jPSnrKT98=;
 b=oxSCWxeSPw40EUMGBAP/HLmn0uuvwHLglEVY+q5g0zdUMnIS9bkZUSau/O1fj8Zj2l
 mcJgozlGx5hNgy3tuNPwDF66Bw1fOtmuw2tNSb8V/4QD6Ojk1rXTND2mPWEbyGlb9SSe
 9+dm4NwYlY7pVZegA5c0ShjEwueJfDonHlKu1C8pJvWml+/DPZNLdR8pT3zWnabkjGqZ
 gT8UHftMf0Fw+rqK8DoG+WAnpNQJfT0kOwv/dVecFXTo+qeScFZlYGqLVI6urDyGuDEa
 DmaECqsyiO6AEOV1NvTRSi6ayGm5hQrbK+VoSzqQTsgruyuOOaSpxEP1gtczJjkINCx/
 MMMQ==
X-Gm-Message-State: AOJu0Yyr30t3e0ahHsnBDm3Nvn7ZscqEV0YefO9jpzpmB3EMqCuOKqNO
 DLR4PikdJrqmdd6d/kYUA66am9OyWslemTqYx+VgXsj422MLK7FQRM3kUImwdLQE+GUb+065hhJ
 C
X-Google-Smtp-Source: AGHT+IEPnLcnJvK2uygwVmFbaNVvWoZmxBuf/A5rPEpIDlLZ4TQ8s8T75t/ux5mEm0q9I/elU5G7og==
X-Received: by 2002:a50:9faa:0:b0:570:37d:badd with SMTP id
 c39-20020a509faa000000b00570037dbaddmr322504edf.28.1713378591399; 
 Wed, 17 Apr 2024 11:29:51 -0700 (PDT)
Received: from m1x-phil.lan ([176.187.201.23])
 by smtp.gmail.com with ESMTPSA id
 z3-20020a056402274300b0056e3d80ca71sm7557489edd.35.2024.04.17.11.29.50
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Wed, 17 Apr 2024 11:29:50 -0700 (PDT)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
To: qemu-devel@nongnu.org
Cc: Richard Henderson <richard.henderson@linaro.org>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Anton Johansson <anjo@rev.ng>
Subject: [PATCH 18/21] exec: Declare target_words_bigendian() in 'exec/tswap.h'
Date: Wed, 17 Apr 2024 20:28:03 +0200
Message-ID: <20240417182806.69446-19-philmd@linaro.org>
X-Mailer: git-send-email 2.41.0
In-Reply-To: <20240417182806.69446-1-philmd@linaro.org>
References: <20240417182806.69446-1-philmd@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::62d;
 envelope-from=philmd@linaro.org; helo=mail-ej1-x62d.google.com
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

We usually check target endianess before swapping values,
so target_words_bigendian() declaration makes sense in
"exec/tswap.h" with the target swapping helpers.

Remove "hw/core/cpu.h" when it was only included to get
the target_words_bigendian() declaration.

Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
Reviewed-by: Anton Johansson <anjo@rev.ng>
Message-Id: <20231212123401.37493-16-philmd@linaro.org>
---
 include/exec/tswap.h     | 12 +++++++++++-
 include/hw/core/cpu.h    | 11 -----------
 cpu-target.c             |  1 +
 disas/disas.c            |  1 +
 hw/audio/virtio-snd.c    |  2 +-
 hw/core/cpu-sysemu.c     |  2 +-
 hw/core/generic-loader.c |  2 +-
 hw/display/vga.c         |  2 +-
 hw/virtio/virtio.c       |  1 +
 9 files changed, 18 insertions(+), 16 deletions(-)

diff --git a/include/exec/tswap.h b/include/exec/tswap.h
index 5089cd6a4c..b7a4191347 100644
--- a/include/exec/tswap.h
+++ b/include/exec/tswap.h
@@ -8,9 +8,19 @@
 #ifndef TSWAP_H
 #define TSWAP_H
 
-#include "hw/core/cpu.h"
 #include "qemu/bswap.h"
 
+/**
+ * target_words_bigendian:
+ * Returns true if the (default) endianness of the target is big endian,
+ * false otherwise. Note that in target-specific code, you can use
+ * TARGET_BIG_ENDIAN directly instead. On the other hand, common
+ * code should normally never need to know about the endianness of the
+ * target, so please do *not* use this function unless you know very well
+ * what you are doing!
+ */
+bool target_words_bigendian(void);
+
 /*
  * If we're in target-specific code, we can hard-code the swapping
  * condition, otherwise we have to do (slower) run-time checks.
diff --git a/include/hw/core/cpu.h b/include/hw/core/cpu.h
index 7f037b158e..3a66d8581e 100644
--- a/include/hw/core/cpu.h
+++ b/include/hw/core/cpu.h
@@ -1169,17 +1169,6 @@ bool cpu_exec_realizefn(CPUState *cpu, Error **errp);
 void cpu_exec_unrealizefn(CPUState *cpu);
 void cpu_exec_reset_hold(CPUState *cpu);
 
-/**
- * target_words_bigendian:
- * Returns true if the (default) endianness of the target is big endian,
- * false otherwise. Note that in target-specific code, you can use
- * TARGET_BIG_ENDIAN directly instead. On the other hand, common
- * code should normally never need to know about the endianness of the
- * target, so please do *not* use this function unless you know very well
- * what you are doing!
- */
-bool target_words_bigendian(void);
-
 const char *target_name(void);
 
 #ifdef COMPILING_PER_TARGET
diff --git a/cpu-target.c b/cpu-target.c
index 4c0621bf33..f88649c299 100644
--- a/cpu-target.c
+++ b/cpu-target.c
@@ -35,6 +35,7 @@
 #endif
 #include "sysemu/cpus.h"
 #include "sysemu/tcg.h"
+#include "exec/tswap.h"
 #include "exec/replay-core.h"
 #include "exec/cpu-common.h"
 #include "exec/exec-all.h"
diff --git a/disas/disas.c b/disas/disas.c
index 7e3b0bb46c..ec14715ecd 100644
--- a/disas/disas.c
+++ b/disas/disas.c
@@ -6,6 +6,7 @@
 #include "disas/disas.h"
 #include "disas/capstone.h"
 #include "hw/core/cpu.h"
+#include "exec/tswap.h"
 #include "exec/memory.h"
 
 /* Filled in by elfload.c.  Simplistic, but will do for now. */
diff --git a/hw/audio/virtio-snd.c b/hw/audio/virtio-snd.c
index c80b58bf5d..6a2ee085c0 100644
--- a/hw/audio/virtio-snd.c
+++ b/hw/audio/virtio-snd.c
@@ -20,11 +20,11 @@
 #include "qemu/log.h"
 #include "qemu/error-report.h"
 #include "include/qemu/lockable.h"
+#include "exec/tswap.h"
 #include "sysemu/runstate.h"
 #include "trace.h"
 #include "qapi/error.h"
 #include "hw/audio/virtio-snd.h"
-#include "hw/core/cpu.h"
 
 #define VIRTIO_SOUND_VM_VERSION 1
 #define VIRTIO_SOUND_JACK_DEFAULT 0
diff --git a/hw/core/cpu-sysemu.c b/hw/core/cpu-sysemu.c
index d0d6a910f9..2a9a2a4eb5 100644
--- a/hw/core/cpu-sysemu.c
+++ b/hw/core/cpu-sysemu.c
@@ -20,7 +20,7 @@
 
 #include "qemu/osdep.h"
 #include "qapi/error.h"
-#include "hw/core/cpu.h"
+#include "exec/tswap.h"
 #include "hw/core/sysemu-cpu-ops.h"
 
 bool cpu_paging_enabled(const CPUState *cpu)
diff --git a/hw/core/generic-loader.c b/hw/core/generic-loader.c
index d4b5c501d8..ea8628b892 100644
--- a/hw/core/generic-loader.c
+++ b/hw/core/generic-loader.c
@@ -31,7 +31,7 @@
  */
 
 #include "qemu/osdep.h"
-#include "hw/core/cpu.h"
+#include "exec/tswap.h"
 #include "sysemu/dma.h"
 #include "sysemu/reset.h"
 #include "hw/boards.h"
diff --git a/hw/display/vga.c b/hw/display/vga.c
index 77f59e8c11..d17ff4b93a 100644
--- a/hw/display/vga.c
+++ b/hw/display/vga.c
@@ -26,7 +26,7 @@
 #include "qemu/units.h"
 #include "sysemu/reset.h"
 #include "qapi/error.h"
-#include "hw/core/cpu.h"
+#include "exec/tswap.h"
 #include "hw/display/vga.h"
 #include "hw/i386/x86.h"
 #include "hw/pci/pci.h"
diff --git a/hw/virtio/virtio.c b/hw/virtio/virtio.c
index 871674f9be..893a072c9d 100644
--- a/hw/virtio/virtio.c
+++ b/hw/virtio/virtio.c
@@ -20,6 +20,7 @@
 #include "qemu/log.h"
 #include "qemu/main-loop.h"
 #include "qemu/module.h"
+#include "exec/tswap.h"
 #include "qom/object_interfaces.h"
 #include "hw/core/cpu.h"
 #include "hw/virtio/virtio.h"
-- 
2.41.0


