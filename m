Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 10FCACD342C
	for <qemu-devel@archiver.kernel.org>; Wed,  6 May 2026 13:57:38 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wKcki-0004Ka-3D; Wed, 06 May 2026 09:57:28 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1wKckf-00045F-Gh
 for qemu-devel@nongnu.org; Wed, 06 May 2026 09:57:26 -0400
Received: from mail-wm1-x32e.google.com ([2a00:1450:4864:20::32e])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1wKckc-00087l-U3
 for qemu-devel@nongnu.org; Wed, 06 May 2026 09:57:24 -0400
Received: by mail-wm1-x32e.google.com with SMTP id
 5b1f17b1804b1-488ba840146so57310105e9.1
 for <qemu-devel@nongnu.org>; Wed, 06 May 2026 06:57:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1778075840; x=1778680640; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
 :reply-to; bh=EfrcVSX6J2/8Is5CIR1OlIYl1W02vIXtlF5jlh3xIlY=;
 b=E6gRRQ4neVQM8Zxngu5myILnpT4Q30ZkJRGP8aOF6pyuyyM/+T3h0xVARCAQmMXVyD
 REHW6rMoiWTkiybDZKvKyD8UAcmbPlSjilNo9xAgvG20zs1+jFSQXQ0cefJinH1ADPnE
 pe1q2FNsJLeBW39bJtJpuUXoYEnozxe3hbiCi24OPGC/z4tkFsHYN9MfuFwU6UFPHasC
 wMtiebRTkenT6v95bfLqXL3oIurOtsklO6HTmylLDGJ5ZNy6UkdpSvby0LCpOVRXG4XF
 dgc+KiWhvrvpJtVyVPRkX4PCIeTWR0KJ08YPMhfXGDkYXSuGriLY5RWDRH8SGF71kHof
 2L8g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1778075840; x=1778680640;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:x-gm-gg:x-gm-message-state:from:to
 :cc:subject:date:message-id:reply-to;
 bh=EfrcVSX6J2/8Is5CIR1OlIYl1W02vIXtlF5jlh3xIlY=;
 b=Z5mac2tTjzv8UJORiqtwjRTVZzT83VnORu17OQvXmWUzkHzHR+Mtq2ElAba/l2w3x0
 uldOVnh7HM0hzoIf/a4Yaw6PYjfrUlolGblX38OVwlRdhoaQcYqy72nd/8d1Yldm8xjQ
 e1uOEZpP20iFZ2zm6SxqT/wx0SOIZZFxF69q4IrOwTudpxcy3ldNnSNZ6nfyCzAlqMMF
 50QY5xRbgGZ7yV3Z3zfCsVO7hhDERp9s6sYg1KRqLEUUGtBxZrMwvAJFTrZuvybMuY3s
 BvOq6gbdHWxy1hCh5PMDDueLCBKN3oEZRyn5O94+ZihkgWJNiSIvb1fseQH5bRPOaGx3
 Y+ew==
X-Gm-Message-State: AOJu0YztbVJtutAwtMTiuem+SOhtFTe3v13fdfJXgqBatSAJNCRp0GZ6
 rrJRGpbBqSe75/DaYWCaN9w3T93dxOXSnEMrnTmYeivC/5Lw5sfvOkUglAXz0fU8YICvcXGSH92
 C0rGi+nE=
X-Gm-Gg: AeBDiesm8mD1FaAZy1MO34t7yQEU9cNs3b6Croc18+Cy7SGIHY+x1gI3Jt6gn/c5NIk
 rIjDCwzzW9D8wnV04HOvsp1irm27KCDoFaKnk5zZIL+r5M6nuC5aNmUssM6GR4sAQM+rB5fcPGR
 HXP8Io1i0zfrdehSEHj0yBacTQz/tZ8RmwWqQx/c47/p5vEBG+AaSddDwx8hCiOkeNYXcbb+f8S
 blJC+grF6hJErzWUF9RyMjTON/61HIUvtEklTnNzP6klWfUOY5SvMnLEil2dgPNdJNPt9Jg22iA
 qPLnLDtNI1PN5HD499O6Yzda8nU3aJXD21FYj9k5XL00fxS7Fo+9gWLrgi2Sq1/DYF8X/QUj6QV
 7YZ59lQkSJiJwiejpQjsS9iXXC6v8VJihK3eguxTk7Gv7TXTMzQHxebKBVfhf7TynMbZVo7Uq71
 x2m3fY1Qe6M+LJU7vf1JjREEB/FE1wg5bXr6TLrnzQ9bfACLLklXdS0oHnWMqx4zO4m5sn8ASUR
 VMgy0/IX850nEhaPYGMkQ==
X-Received: by 2002:a05:600c:8b04:b0:488:bfc3:efc with SMTP id
 5b1f17b1804b1-48e51dd69d6mr61235605e9.0.1778075840125; 
 Wed, 06 May 2026 06:57:20 -0700 (PDT)
Received: from localhost.localdomain (88-187-86-199.subs.proxad.net.
 [88.187.86.199]) by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-48e5311f891sm28479385e9.4.2026.05.06.06.57.18
 for <qemu-devel@nongnu.org>
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Wed, 06 May 2026 06:57:18 -0700 (PDT)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
To: qemu-devel@nongnu.org
Subject: [PULL 015/110] target/cpu: Do not include 'exec/cpu-defs.h' anymore
Date: Wed,  6 May 2026 15:53:47 +0200
Message-ID: <20260506135524.20617-16-philmd@linaro.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260506135524.20617-1-philmd@linaro.org>
References: <20260506135524.20617-1-philmd@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::32e;
 envelope-from=philmd@linaro.org; helo=mail-wm1-x32e.google.com
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

Nothing in all our target "cpu.h" directly uses definitions
from "exec/cpu-defs.h": no need to include it there. This
remove a lot of target-specificities, simplifying inclusion
of target "cpu.h" by common code.

Inspired-by: Pierrick Bouvier <pierrick.bouvier@linaro.org>
Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
Reviewed-by: Pierrick Bouvier <pierrick.bouvier@linaro.org>
Message-Id: <20260313062055.2188-20-philmd@linaro.org>
---
 target/alpha/cpu.h      | 1 -
 target/arm/cpu.h        | 1 -
 target/avr/cpu.h        | 1 -
 target/hexagon/cpu.h    | 1 -
 target/hppa/cpu.h       | 1 -
 target/i386/cpu.h       | 1 -
 target/loongarch/cpu.h  | 1 -
 target/m68k/cpu.h       | 1 -
 target/microblaze/cpu.h | 1 -
 target/mips/cpu.h       | 1 -
 target/or1k/cpu.h       | 1 -
 target/ppc/cpu.h        | 1 -
 target/riscv/cpu.h      | 1 -
 target/rx/cpu.h         | 1 -
 target/s390x/cpu.h      | 1 -
 target/sh4/cpu.h        | 1 -
 target/sparc/cpu.h      | 1 -
 target/tricore/cpu.h    | 1 -
 18 files changed, 18 deletions(-)

diff --git a/target/alpha/cpu.h b/target/alpha/cpu.h
index b530cd0088b..2f611397782 100644
--- a/target/alpha/cpu.h
+++ b/target/alpha/cpu.h
@@ -22,7 +22,6 @@
 
 #include "cpu-qom.h"
 #include "exec/cpu-common.h"
-#include "exec/cpu-defs.h"
 #include "exec/cpu-interrupt.h"
 #include "qemu/cpu-float.h"
 
diff --git a/target/arm/cpu.h b/target/arm/cpu.h
index 5e4f12f1e77..0b9755533b0 100644
--- a/target/arm/cpu.h
+++ b/target/arm/cpu.h
@@ -25,7 +25,6 @@
 #include "hw/core/registerfields.h"
 #include "cpu-qom.h"
 #include "exec/cpu-common.h"
-#include "exec/cpu-defs.h"
 #include "exec/cpu-interrupt.h"
 #include "exec/gdbstub.h"
 #include "exec/page-protection.h"
diff --git a/target/avr/cpu.h b/target/avr/cpu.h
index 518e243d812..3da885c7ccb 100644
--- a/target/avr/cpu.h
+++ b/target/avr/cpu.h
@@ -23,7 +23,6 @@
 
 #include "cpu-qom.h"
 #include "exec/cpu-common.h"
-#include "exec/cpu-defs.h"
 #include "exec/cpu-interrupt.h"
 #include "system/memory.h"
 
diff --git a/target/hexagon/cpu.h b/target/hexagon/cpu.h
index faa07a6e05b..7c09c97db85 100644
--- a/target/hexagon/cpu.h
+++ b/target/hexagon/cpu.h
@@ -22,7 +22,6 @@
 
 #include "cpu-qom.h"
 #include "exec/cpu-common.h"
-#include "exec/cpu-defs.h"
 #include "exec/target_long.h"
 #include "hex_regs.h"
 #include "mmvec/mmvec.h"
diff --git a/target/hppa/cpu.h b/target/hppa/cpu.h
index 6ea4c9b6826..85f39401423 100644
--- a/target/hppa/cpu.h
+++ b/target/hppa/cpu.h
@@ -22,7 +22,6 @@
 
 #include "cpu-qom.h"
 #include "exec/cpu-common.h"
-#include "exec/cpu-defs.h"
 #include "exec/cpu-interrupt.h"
 #include "exec/target_long.h"
 #include "system/memory.h"
diff --git a/target/i386/cpu.h b/target/i386/cpu.h
index fd8d98a4bdd..f57c99e8b4e 100644
--- a/target/i386/cpu.h
+++ b/target/i386/cpu.h
@@ -24,7 +24,6 @@
 #include "cpu-qom.h"
 #include "kvm/hyperv-proto.h"
 #include "exec/cpu-common.h"
-#include "exec/cpu-defs.h"
 #include "exec/cpu-interrupt.h"
 #include "exec/target_long.h"
 #include "exec/memop.h"
diff --git a/target/loongarch/cpu.h b/target/loongarch/cpu.h
index 4d333806ed8..096d7789285 100644
--- a/target/loongarch/cpu.h
+++ b/target/loongarch/cpu.h
@@ -10,7 +10,6 @@
 
 #include "qemu/int128.h"
 #include "exec/cpu-common.h"
-#include "exec/cpu-defs.h"
 #include "exec/cpu-interrupt.h"
 #include "fpu/softfloat-types.h"
 #include "hw/core/registerfields.h"
diff --git a/target/m68k/cpu.h b/target/m68k/cpu.h
index 7911ab9de30..d7f508a9e80 100644
--- a/target/m68k/cpu.h
+++ b/target/m68k/cpu.h
@@ -22,7 +22,6 @@
 #define M68K_CPU_H
 
 #include "exec/cpu-common.h"
-#include "exec/cpu-defs.h"
 #include "exec/cpu-interrupt.h"
 #include "qemu/cpu-float.h"
 #include "cpu-qom.h"
diff --git a/target/microblaze/cpu.h b/target/microblaze/cpu.h
index 5a856edaaa9..5765786e6dc 100644
--- a/target/microblaze/cpu.h
+++ b/target/microblaze/cpu.h
@@ -22,7 +22,6 @@
 
 #include "cpu-qom.h"
 #include "exec/cpu-common.h"
-#include "exec/cpu-defs.h"
 #include "qemu/cpu-float.h"
 #include "exec/cpu-interrupt.h"
 
diff --git a/target/mips/cpu.h b/target/mips/cpu.h
index 3517d2d42cf..17e9f6039ec 100644
--- a/target/mips/cpu.h
+++ b/target/mips/cpu.h
@@ -3,7 +3,6 @@
 
 #include "cpu-qom.h"
 #include "exec/cpu-common.h"
-#include "exec/cpu-defs.h"
 #include "exec/cpu-interrupt.h"
 #include "exec/target_long.h"
 #ifndef CONFIG_USER_ONLY
diff --git a/target/or1k/cpu.h b/target/or1k/cpu.h
index c8e2827930b..5bb39b67519 100644
--- a/target/or1k/cpu.h
+++ b/target/or1k/cpu.h
@@ -22,7 +22,6 @@
 
 #include "cpu-qom.h"
 #include "exec/cpu-common.h"
-#include "exec/cpu-defs.h"
 #include "exec/cpu-interrupt.h"
 #include "fpu/softfloat-types.h"
 
diff --git a/target/ppc/cpu.h b/target/ppc/cpu.h
index a0df7a467ed..aba8109bbba 100644
--- a/target/ppc/cpu.h
+++ b/target/ppc/cpu.h
@@ -23,7 +23,6 @@
 #include "qemu/int128.h"
 #include "qemu/cpu-float.h"
 #include "exec/cpu-common.h"
-#include "exec/cpu-defs.h"
 #include "exec/cpu-interrupt.h"
 #include "exec/target_long.h"
 #include "cpu-qom.h"
diff --git a/target/riscv/cpu.h b/target/riscv/cpu.h
index df55a77c403..e42f3694089 100644
--- a/target/riscv/cpu.h
+++ b/target/riscv/cpu.h
@@ -24,7 +24,6 @@
 #include "hw/core/registerfields.h"
 #include "hw/core/qdev-properties.h"
 #include "exec/cpu-common.h"
-#include "exec/cpu-defs.h"
 #include "exec/cpu-interrupt.h"
 #include "exec/gdbstub.h"
 #include "exec/target_long.h"
diff --git a/target/rx/cpu.h b/target/rx/cpu.h
index b3b1ecff5af..b500b7a2474 100644
--- a/target/rx/cpu.h
+++ b/target/rx/cpu.h
@@ -24,7 +24,6 @@
 #include "cpu-qom.h"
 
 #include "exec/cpu-common.h"
-#include "exec/cpu-defs.h"
 #include "exec/cpu-interrupt.h"
 #include "qemu/cpu-float.h"
 
diff --git a/target/s390x/cpu.h b/target/s390x/cpu.h
index 40bc1f0741d..3acbe83f0fc 100644
--- a/target/s390x/cpu.h
+++ b/target/s390x/cpu.h
@@ -28,7 +28,6 @@
 #include "cpu-qom.h"
 #include "cpu_models.h"
 #include "exec/cpu-common.h"
-#include "exec/cpu-defs.h"
 #include "exec/cpu-interrupt.h"
 #include "qemu/cpu-float.h"
 #include "qapi/qapi-types-machine-common.h"
diff --git a/target/sh4/cpu.h b/target/sh4/cpu.h
index b0759010c47..e36268b4256 100644
--- a/target/sh4/cpu.h
+++ b/target/sh4/cpu.h
@@ -22,7 +22,6 @@
 
 #include "cpu-qom.h"
 #include "exec/cpu-common.h"
-#include "exec/cpu-defs.h"
 #include "exec/cpu-interrupt.h"
 #include "qemu/cpu-float.h"
 
diff --git a/target/sparc/cpu.h b/target/sparc/cpu.h
index 155aa8ec637..ac0eb9f0faa 100644
--- a/target/sparc/cpu.h
+++ b/target/sparc/cpu.h
@@ -3,7 +3,6 @@
 
 #include "qemu/bswap.h"
 #include "cpu-qom.h"
-#include "exec/cpu-defs.h"
 #include "exec/cpu-interrupt.h"
 #include "exec/target_long.h"
 #include "qemu/cpu-float.h"
diff --git a/target/tricore/cpu.h b/target/tricore/cpu.h
index ab46192e261..604fb7792c6 100644
--- a/target/tricore/cpu.h
+++ b/target/tricore/cpu.h
@@ -23,7 +23,6 @@
 #include "cpu-qom.h"
 #include "hw/core/registerfields.h"
 #include "exec/cpu-common.h"
-#include "exec/cpu-defs.h"
 #include "qemu/cpu-float.h"
 #include "tricore-defs.h"
 
-- 
2.53.0


