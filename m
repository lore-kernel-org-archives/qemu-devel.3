Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2861BCF6497
	for <qemu-devel@archiver.kernel.org>; Mon, 30 Sep 2024 12:49:24 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1svFpS-00083I-87; Mon, 30 Sep 2024 08:48:42 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1svFpO-00080J-5L
 for qemu-devel@nongnu.org; Mon, 30 Sep 2024 08:48:38 -0400
Received: from mail-wr1-x42d.google.com ([2a00:1450:4864:20::42d])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1svFpL-00067z-Sw
 for qemu-devel@nongnu.org; Mon, 30 Sep 2024 08:48:37 -0400
Received: by mail-wr1-x42d.google.com with SMTP id
 ffacd0b85a97d-37ce14ab7eeso1593045f8f.2
 for <qemu-devel@nongnu.org>; Mon, 30 Sep 2024 05:48:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1727700514; x=1728305314; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to;
 bh=uzm24+ZWrwMOuzZZfqf6biduFwcmS7XxAWWZizuNc3E=;
 b=kcaRKTLWVdxSp1v+2AuVQcUs2z2lVsjzt9aXB2dk5UhXcrWa8YThKD57qG0teJlZQU
 vikNhyN/jDUjreo8rPPUBSh5Nj/BpZWgL9K5mAreWGd87jAJ8oVq0EMiyFJia9dehKZj
 IH4LdSDunIqEOrJHKSfywXg0mie9YjEswGxsd52uW5z8lTnku1axNOVQY7xACBWe1Qxa
 E3+46HRGOi2Jgs89uo2c1n5/pQvySCqAL9HZpQ5P7oYdiaDN+JB6RKqJvLHCctBLHo3K
 RPQrGfl0caDoPEyt1JRmo4HYWd3PnEjOlRcnOvpA4Qz1DDaoD+c1A5F1HGg0Y9gxmqDW
 m/dA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1727700514; x=1728305314;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=uzm24+ZWrwMOuzZZfqf6biduFwcmS7XxAWWZizuNc3E=;
 b=l06mVPExR3rA8x5CxfE5+cIa9VtbHS4En8TGLv6g7tjczfxPSLoEL0udUIMF4J1TDP
 5JY4D3dW2fTS06bqH5aP9P9dFNVVjmRcqJ9gQvLv5MNcxhHbQtBkeQH4pifEmBjXHYyD
 BupnaHHtzun57zpVhRI2Ljc6rdr0sF5JvxbPoextOjCLCy/4nUCDDPMh3ZSXLGHQbKRM
 UPzZ+cnev6KN7pITTC034xq8AEsrAhchJuV7hdDRgPpsHb0EtbtWb9V/n/bRIl6Xnjq1
 eF7e/cdRp7e6iFkGpEw7jVTuIGtJP4FYIXCu5j2Cj0eI1f5cxyfEmgTq5py7Bo3JJErk
 X6pw==
X-Gm-Message-State: AOJu0Yx6zYGxod/v0/9I5pTx4GewVMAKqctQNT/Du2qDgKirduuW0dug
 DzYzHlT6hzi9g+0JUCBlvG0ZjRpoa+obM8ybo5vTPADWttzG/uhKpokBQoA+NZO+d2KW+QWJiym
 B
X-Google-Smtp-Source: AGHT+IG+WpDxktDwhDeAB7ZoaSFd8qPxhHZHMtpY9pSMS0NDmTy9YHm3YWJCoEIAfidwgw3P3C9cOg==
X-Received: by 2002:adf:fa88:0:b0:37c:cce6:997d with SMTP id
 ffacd0b85a97d-37cd5a8c952mr11781297f8f.20.1727700513641; 
 Mon, 30 Sep 2024 05:48:33 -0700 (PDT)
Received: from localhost.localdomain ([78.196.4.158])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-37cd56e6408sm8975801f8f.48.2024.09.30.05.48.32
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Mon, 30 Sep 2024 05:48:33 -0700 (PDT)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
To: qemu-devel@nongnu.org
Cc: Thomas Huth <thuth@redhat.com>, Paolo Bonzini <pbonzini@redhat.com>,
 qemu-riscv@nongnu.org, Liu Zhiwei <zhiwei_liu@linux.alibaba.com>,
 Alistair Francis <alistair.francis@wdc.com>,
 Daniel Henrique Barboza <dbarboza@ventanamicro.com>,
 =?UTF-8?q?Marc-Andr=C3=A9=20Lureau?= <marcandre.lureau@redhat.com>,
 Anton Johansson <anjo@rev.ng>, Palmer Dabbelt <palmer@dabbelt.com>,
 Bin Meng <bmeng.cn@gmail.com>, Weiwei Li <liwei1518@gmail.com>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
Subject: [PATCH] hw/riscv/spike: Replace tswap64() by ldq_endian_p()
Date: Mon, 30 Sep 2024 14:48:31 +0200
Message-ID: <20240930124831.54232-1-philmd@linaro.org>
X-Mailer: git-send-email 2.45.2
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::42d;
 envelope-from=philmd@linaro.org; helo=mail-wr1-x42d.google.com
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

Hold the target endianness in HTIFState::target_is_bigendian.
Pass the target endianness as argument to htif_mm_init().
Replace tswap64() calls by ldq_endian_p() ones.

Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
---
Based-on: <20240930073450.33195-2-philmd@linaro.org>
          "qemu/bswap: Introduce ld/st_endian_p() API"

Note: this is a non-QOM device!
---
 include/hw/char/riscv_htif.h |  4 +++-
 hw/char/riscv_htif.c         | 17 +++++++++++------
 hw/riscv/spike.c             |  2 +-
 3 files changed, 15 insertions(+), 8 deletions(-)

diff --git a/include/hw/char/riscv_htif.h b/include/hw/char/riscv_htif.h
index df493fdf6b..24868ddfe1 100644
--- a/include/hw/char/riscv_htif.h
+++ b/include/hw/char/riscv_htif.h
@@ -35,6 +35,7 @@ typedef struct HTIFState {
     hwaddr tohost_offset;
     hwaddr fromhost_offset;
     MemoryRegion mmio;
+    bool target_is_bigendian;
 
     CharBackend chr;
     uint64_t pending_read;
@@ -49,6 +50,7 @@ void htif_symbol_callback(const char *st_name, int st_info, uint64_t st_value,
 
 /* legacy pre qom */
 HTIFState *htif_mm_init(MemoryRegion *address_space, Chardev *chr,
-                        uint64_t nonelf_base, bool custom_base);
+                        uint64_t nonelf_base, bool custom_base,
+                        bool target_is_bigendian);
 
 #endif
diff --git a/hw/char/riscv_htif.c b/hw/char/riscv_htif.c
index 9bef60def1..77951f3c76 100644
--- a/hw/char/riscv_htif.c
+++ b/hw/char/riscv_htif.c
@@ -30,7 +30,6 @@
 #include "qemu/timer.h"
 #include "qemu/error-report.h"
 #include "exec/address-spaces.h"
-#include "exec/tswap.h"
 #include "sysemu/dma.h"
 #include "sysemu/runstate.h"
 
@@ -211,13 +210,17 @@ static void htif_handle_tohost_write(HTIFState *s, uint64_t val_written)
                     SHUTDOWN_CAUSE_GUEST_SHUTDOWN, exit_code);
                 return;
             } else {
+                bool be = s->target_is_bigendian;
                 uint64_t syscall[8];
+
                 cpu_physical_memory_read(payload, syscall, sizeof(syscall));
-                if (tswap64(syscall[0]) == PK_SYS_WRITE &&
-                    tswap64(syscall[1]) == HTIF_DEV_CONSOLE &&
-                    tswap64(syscall[3]) == HTIF_CONSOLE_CMD_PUTC) {
+                if (ldq_endian_p(be, &syscall[0]) == PK_SYS_WRITE &&
+                    ldq_endian_p(be, &syscall[1]) == HTIF_DEV_CONSOLE &&
+                    ldq_endian_p(be, &syscall[3]) == HTIF_CONSOLE_CMD_PUTC) {
                     uint8_t ch;
-                    cpu_physical_memory_read(tswap64(syscall[2]), &ch, 1);
+
+                    cpu_physical_memory_read(ldl_endian_p(be, &syscall[2]),
+                                             &ch, 1);
                     qemu_chr_fe_write(&s->chr, &ch, 1);
                     resp = 0x100 | (uint8_t)payload;
                 } else {
@@ -320,7 +323,8 @@ static const MemoryRegionOps htif_mm_ops = {
 };
 
 HTIFState *htif_mm_init(MemoryRegion *address_space, Chardev *chr,
-                        uint64_t nonelf_base, bool custom_base)
+                        uint64_t nonelf_base, bool custom_base,
+                        bool target_is_bigendian)
 {
     uint64_t base, size, tohost_offset, fromhost_offset;
 
@@ -345,6 +349,7 @@ HTIFState *htif_mm_init(MemoryRegion *address_space, Chardev *chr,
     s->pending_read = 0;
     s->allow_tohost = 0;
     s->fromhost_inprogress = 0;
+    s->target_is_bigendian = target_is_bigendian;
     qemu_chr_fe_init(&s->chr, chr, &error_abort);
     qemu_chr_fe_set_handlers(&s->chr, htif_can_recv, htif_recv, htif_event,
         htif_be_change, s, NULL, true);
diff --git a/hw/riscv/spike.c b/hw/riscv/spike.c
index 64074395bc..0989cd4a41 100644
--- a/hw/riscv/spike.c
+++ b/hw/riscv/spike.c
@@ -327,7 +327,7 @@ static void spike_board_init(MachineState *machine)
 
     /* initialize HTIF using symbols found in load_kernel */
     htif_mm_init(system_memory, serial_hd(0), memmap[SPIKE_HTIF].base,
-                 htif_custom_base);
+                 htif_custom_base, TARGET_BIG_ENDIAN);
 }
 
 static void spike_set_signature(Object *obj, const char *val, Error **errp)
-- 
2.45.2


