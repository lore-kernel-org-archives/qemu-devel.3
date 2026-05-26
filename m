Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9961ECD5BC8
	for <qemu-devel@archiver.kernel.org>; Tue, 26 May 2026 09:58:44 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wRoY3-0000A7-QO; Tue, 26 May 2026 05:58:07 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1wRoY2-00009p-7T
 for qemu-devel@nongnu.org; Tue, 26 May 2026 05:58:06 -0400
Received: from mail-wm1-x336.google.com ([2a00:1450:4864:20::336])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1wRoY0-0000XT-Ll
 for qemu-devel@nongnu.org; Tue, 26 May 2026 05:58:05 -0400
Received: by mail-wm1-x336.google.com with SMTP id
 5b1f17b1804b1-49050ff7cbdso27690255e9.2
 for <qemu-devel@nongnu.org>; Tue, 26 May 2026 02:58:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1779789483; x=1780394283; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=Zy8eiABwRpCam2ogJ6+dKB3dvQ/4Eln/DRD1aKrsllg=;
 b=osJemNmp7rJ+NIP5gXp20d/QWVU5Wlv8JLQ/tfx0IlP6h3FwA7EXvhyT0e3f+DaV+6
 KyILXn82GId1LcZu56TcNwW07nNvmB3hIfk3sWJ83Tk7V9Sb+0Fe+FqjLedXwSqYnekq
 QBOeNd8K1/k7sYXza2eyUg9/kjHcvojSNOL/wa+XYus43DPWEgsscNZs3S5pQQuJ2yeR
 H2dgKqWd1ItxLb3jZJwZHwKz/HxeyQo2u1mtEMmG/2dsDlFG3iGLLEBm4NjUccuCHIQW
 Sd3DgRxGdDZI9WnzVN0cbSx66OHEu68by6VmvSd/fH3lmqrHDE9Lv/5Ru4a8tjTRHxdO
 0yTA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1779789483; x=1780394283;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=Zy8eiABwRpCam2ogJ6+dKB3dvQ/4Eln/DRD1aKrsllg=;
 b=m8s17yedAf6TqY1NRo8oAjkcg3RaxzDQDbO69J1gz63RVF5caJyq6iI+AqfTf0RZ6U
 tng7vXWkE+ncVAOjHdk+fn0nFMAeYPHPtGZ+oyv3Xk8M9FNGFr2Cckxo7XAtWzIwyMRV
 EpaGhjXIF8tmcYH644n7t0wrnmkhE8gn2dbwEHBa9a6M8AdDnLy08ld754HRIoUlLnZy
 JnomQFlY1M1/fP+WziGuB3M1D6/7xkMR3SKxJgM8ZmjTDamE3QTHBcxH5AFecleglT3z
 iY5GRnx98su5W7/ky1mjXbXzSjLNWf4lv4YVv3g1MYPhIhck+ncRATKbNRpYF1A07oO3
 JCnQ==
X-Gm-Message-State: AOJu0YwEuLopCPa9FHNzItTqERdtJdazU2AOvBeGKodcpyfVL2iW0sFu
 WjNCBzKFmMqUCJkadPb3V0Sy0aYR/8IUdDm7OUkNDVbUOVOFRzd+kbryt7MdItI6JC9eIazQ+75
 /R/hcfKJ1RA==
X-Gm-Gg: Acq92OH8mbv+mo7SLMDWB0mcBr1FAdHwq24cJzbBKAAYogc7+LiaP3TU77JUZqjLRkJ
 04GxtZe/lweq8skfiCw6Uo4KNlWYk9BWTmOSd8HGhaxAqNt7bGL3QRGEbC4+0sdJbQbeukqzEEi
 bpDv9j3bN2btwXqXAEbDt/fQf2ePZyvJXeqF7LiO24LlHhw/bZMhyzxOfolLaEyTsb3dFLlouDs
 FD6dKmoPbrvYp5Kv4BFXrkwY8QdYechp+VllPZzSYVyQjNOVHpcl3EOnvINF/4QtLlUHP9WjWE3
 9SspjM4eX+EDVWB+4E0bHoSkd470NRbTjz0p1aEhZzjFybmjxb7QPBAz+iP3PbKEfWWG3WZBO82
 GYOtADktDLIv/OAK7YZihzmNnDfVyDEFYcS2uZYMDv5LoQq629BgjcW6v3ig5jvy3Yw3YT6mKQQ
 ee63PbsYEAZ77vj2bhICR3O74Mj0Q9IB+7005UR2g1V+gHfdnhekPJl7M=
X-Received: by 2002:a05:600c:1c0a:b0:490:402f:324d with SMTP id
 5b1f17b1804b1-490428e03admr291296075e9.29.1779789483010; 
 Tue, 26 May 2026 02:58:03 -0700 (PDT)
Received: from m17.home (88-187-86-199.subs.proxad.net. [88.187.86.199])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-49049973b71sm91270615e9.29.2026.05.26.02.58.01
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Tue, 26 May 2026 02:58:01 -0700 (PDT)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
To: qemu-devel@nongnu.org
Cc: qemu-riscv@nongnu.org, Anton Johansson <anjo@rev.ng>,
 Sai Pavan Boddu <sai.pavan.boddu@amd.com>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Chao Liu <chao.liu.zevorn@gmail.com>,
 Daniel Henrique Barboza <daniel.barboza@oss.qualcomm.com>,
 Liu Zhiwei <zhiwei_liu@linux.alibaba.com>,
 Palmer Dabbelt <palmer@dabbelt.com>, Weiwei Li <liwei1518@gmail.com>,
 Alistair Francis <alistair.francis@wdc.com>,
 Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>
Subject: [PATCH 4/4] hw/riscv/virt: Inline TYPE_RISCV_CPU_BASE definition
Date: Tue, 26 May 2026 11:57:31 +0200
Message-ID: <20260526095731.63525-5-philmd@linaro.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260526095731.63525-1-philmd@linaro.org>
References: <20260526095731.63525-1-philmd@linaro.org>
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

TYPE_RISCV_CPU_BASE is only use by the 'virt' machine.
Inline it, replacing a built time check by a runtime one.

Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
---
 target/riscv/cpu.h | 6 ------
 hw/riscv/virt.c    | 4 +++-
 2 files changed, 3 insertions(+), 7 deletions(-)

diff --git a/target/riscv/cpu.h b/target/riscv/cpu.h
index 7d79c7a5a7e..0d2ecd9d6ba 100644
--- a/target/riscv/cpu.h
+++ b/target/riscv/cpu.h
@@ -39,12 +39,6 @@ typedef struct CPUArchState CPURISCVState;
 
 #define CPU_RESOLVING_TYPE TYPE_RISCV_CPU
 
-#if defined(TARGET_RISCV32)
-# define TYPE_RISCV_CPU_BASE            TYPE_RISCV_CPU_BASE32
-#elif defined(TARGET_RISCV64)
-# define TYPE_RISCV_CPU_BASE            TYPE_RISCV_CPU_BASE64
-#endif
-
 /*
  * b0: Whether a instruction always raise a store AMO or not.
  */
diff --git a/hw/riscv/virt.c b/hw/riscv/virt.c
index 3d06c9c6104..8371b28c27a 100644
--- a/hw/riscv/virt.c
+++ b/hw/riscv/virt.c
@@ -22,6 +22,7 @@
 #include "qemu/units.h"
 #include "qemu/error-report.h"
 #include "qemu/guest-random.h"
+#include "qemu/target-info.h"
 #include "qapi/error.h"
 #include "hw/core/boards.h"
 #include "hw/core/loader.h"
@@ -1932,7 +1933,8 @@ static void virt_machine_class_init(ObjectClass *oc, const void *data)
     mc->desc = "RISC-V VirtIO board";
     mc->init = virt_machine_init;
     mc->max_cpus = VIRT_CPUS_MAX;
-    mc->default_cpu_type = TYPE_RISCV_CPU_BASE;
+    mc->default_cpu_type = target_riscv64() ? TYPE_RISCV_CPU_BASE64
+                                            : TYPE_RISCV_CPU_BASE32;
     mc->block_default_type = IF_VIRTIO;
     mc->no_cdrom = 1;
     mc->pci_allow_0_address = true;
-- 
2.53.0


