Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id AFE19C02194
	for <qemu-devel@archiver.kernel.org>; Thu,  6 Feb 2025 15:13:19 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tg3YI-0000Y3-83; Thu, 06 Feb 2025 10:12:26 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1tg3YE-0000Vt-9X
 for qemu-devel@nongnu.org; Thu, 06 Feb 2025 10:12:23 -0500
Received: from mail-wm1-x334.google.com ([2a00:1450:4864:20::334])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1tg3YC-00013m-9d
 for qemu-devel@nongnu.org; Thu, 06 Feb 2025 10:12:21 -0500
Received: by mail-wm1-x334.google.com with SMTP id
 5b1f17b1804b1-437a92d7b96so10230475e9.2
 for <qemu-devel@nongnu.org>; Thu, 06 Feb 2025 07:12:19 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1738854738; x=1739459538; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=Dyc4k4zZ3UDjTeOj4G3vch41PnGrPu5ooBf/NMqW0u8=;
 b=Xih5rxwUrZhpx/r741Y/GOmx4ptWOkxgwnUEs2rv1t3fA/68/yf0Kk/HbekxH4YrgZ
 llMrZoqT0FhotzENKVhEHa2tcvCvbHTVVwp6uGc0Kh4Cleu36XIR1JPXbG3FJwyvB+he
 rsJdLGLNYJo89x8F2MOMyp3tcTB5gjYjuXx2ZprTlGZ4BPfx+zG3XdnPYFB8GTP//raW
 U4BhQ8EONFyRgbSOEMiEhimk7MUG7YN3MB7Le0q7fX/F5W8Xe1cXG9M2t1yRU7v5jhaX
 7/ZgMwVc/lo13ONFQlEefDKMXzeto06OR+0/rF6YBv4kmWuNydsafckuO+JorfKWK7ia
 cibA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1738854738; x=1739459538;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=Dyc4k4zZ3UDjTeOj4G3vch41PnGrPu5ooBf/NMqW0u8=;
 b=sdIAOjPRmTb+SRPJUD5YX5LlPlNt/PPTr15ehy2c1XzNpIe9GbAFIGoKbsga59b+BU
 SvdMzLKgwYcOUoDvumgO5W5UMhgg+b2jXsYZjBLvhlogbhSIvjzRqhopnjafVCms8CPP
 hQdcCajXOh1stBuTF+kzmnTW7W0h+1l4fbKO2cCElou3S0taokaEV5CELBbzKR3zwDAw
 tfFCquoiuRByP09tgAipEV0QpOQOiqHKoR3rs7NQA8DYikROeClxRAXUWWZ/3c93sBtz
 vNbokwIrr+8YKyOT0Wsx9BRIprXzVOu09ARK/f3hGUsD74kZj284YlDIfCnJ7OqPYtxw
 vISQ==
X-Gm-Message-State: AOJu0Yy9JXHCf0JTZ9mIg02KXZHX/Gz/PDQOmxFtns5CGdvNe48eqPWh
 8Ioj0qtkEQnpBCEv2esmBbjd+N7YotZ4nXCJbMPLgfS7oVVzCkgpvnEM4NWoVIXDVPQ3GiNm+pv
 Y
X-Gm-Gg: ASbGncujuhGnz3zT26VYCbAdn6A8IA2eswE22oxUxYMHy4x4hsVJ0U8wObwRvamXy+9
 rRJv7J+d62AsKuuQgyRFPb8V/mgSdcmSkWvBPblhK7EbLYofVPSsT9NJPyTE36JMDv71u02Y4kG
 ULXVuJTqPnwGVKMiI3YgBesPSDUqr3wrkSO3BX0gIBe5WZeXlV1PTMp1u+7WwAjww4RSdTIB7f8
 AXV8AZL9jTUYuxFw/tTnHzXNCV2I9AoJmje8rx2xiMTIsXgb2dRI/nXrstovCdn2ExLTa6CPyYJ
 3ZJvLWe2u91Hl2bePUCNVw==
X-Google-Smtp-Source: AGHT+IEzNVIMw8Z0j37Z//OLms2ZqtZbssK9Leq57496w96yeu0R25JZkO+YonoMyA7ykPdMRhnLAA==
X-Received: by 2002:a05:600c:3b0f:b0:434:e9ee:c2d with SMTP id
 5b1f17b1804b1-4390d56c256mr48427715e9.26.1738854738483; 
 Thu, 06 Feb 2025 07:12:18 -0800 (PST)
Received: from orth.archaic.org.uk (orth.archaic.org.uk. [2001:8b0:1d0::2])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-4391d5283b2sm23591535e9.0.2025.02.06.07.12.17
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 06 Feb 2025 07:12:17 -0800 (PST)
From: Peter Maydell <peter.maydell@linaro.org>
To: qemu-devel@nongnu.org
Cc: Paul Burton <paulburton@kernel.org>, Aleksandar Rikalo <arikalo@gmail.com>,
 Eduardo Habkost <eduardo@habkost.net>,
 Marcel Apfelbaum <marcel.apfelbaum@gmail.com>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Yanan Wang <wangyanan55@huawei.com>, Zhao Liu <zhao1.liu@intel.com>,
 Jia Liu <proljc@gmail.com>
Subject: [PATCH 2/6] hw/openrisc: Support monitor dumpdtb command
Date: Thu,  6 Feb 2025 15:12:10 +0000
Message-Id: <20250206151214.2947842-3-peter.maydell@linaro.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20250206151214.2947842-1-peter.maydell@linaro.org>
References: <20250206151214.2947842-1-peter.maydell@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::334;
 envelope-from=peter.maydell@linaro.org; helo=mail-wm1-x334.google.com
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

The openrisc machines don't set MachineState::fdt to point to their
DTB blob.  This means that although the command line '-machine
dumpdtb=file.dtb' option works, the equivalent QMP and HMP monitor
commands do not, but instead produce the error "This machine doesn't
have a FDT".

Set MachineState::fdt in openrisc_load_fdt(), when we write it to
guest memory.

Signed-off-by: Peter Maydell <peter.maydell@linaro.org>
---
 include/hw/openrisc/boot.h | 3 ++-
 hw/openrisc/boot.c         | 7 +++++--
 hw/openrisc/openrisc_sim.c | 2 +-
 hw/openrisc/virt.c         | 2 +-
 4 files changed, 9 insertions(+), 5 deletions(-)

diff --git a/include/hw/openrisc/boot.h b/include/hw/openrisc/boot.h
index 25a313d63a1..9b4d88072c4 100644
--- a/include/hw/openrisc/boot.h
+++ b/include/hw/openrisc/boot.h
@@ -20,6 +20,7 @@
 #define OPENRISC_BOOT_H
 
 #include "exec/cpu-defs.h"
+#include "hw/boards.h"
 
 hwaddr openrisc_load_kernel(ram_addr_t ram_size,
                             const char *kernel_filename,
@@ -28,7 +29,7 @@ hwaddr openrisc_load_kernel(ram_addr_t ram_size,
 hwaddr openrisc_load_initrd(void *fdt, const char *filename,
                             hwaddr load_start, uint64_t mem_size);
 
-uint32_t openrisc_load_fdt(void *fdt, hwaddr load_start,
+uint32_t openrisc_load_fdt(MachineState *ms, void *fdt, hwaddr load_start,
                            uint64_t mem_size);
 
 #endif /* OPENRISC_BOOT_H */
diff --git a/hw/openrisc/boot.c b/hw/openrisc/boot.c
index 0f08df812dc..72e2756af05 100644
--- a/hw/openrisc/boot.c
+++ b/hw/openrisc/boot.c
@@ -90,8 +90,8 @@ hwaddr openrisc_load_initrd(void *fdt, const char *filename,
     return start + size;
 }
 
-uint32_t openrisc_load_fdt(void *fdt, hwaddr load_start,
-                           uint64_t mem_size)
+uint32_t openrisc_load_fdt(MachineState *ms, void *fdt,
+                           hwaddr load_start, uint64_t mem_size)
 {
     uint32_t fdt_addr;
     int ret;
@@ -111,6 +111,9 @@ uint32_t openrisc_load_fdt(void *fdt, hwaddr load_start,
     /* copy in the device tree */
     qemu_fdt_dumpdtb(fdt, fdtsize);
 
+    /* Save FDT for dumpdtb monitor command */
+    ms->fdt = fdt;
+
     rom_add_blob_fixed_as("fdt", fdt, fdtsize, fdt_addr,
                           &address_space_memory);
     qemu_register_reset_nosnapshotload(qemu_fdt_randomize_seeds,
diff --git a/hw/openrisc/openrisc_sim.c b/hw/openrisc/openrisc_sim.c
index e0da4067ba3..d9e0744922a 100644
--- a/hw/openrisc/openrisc_sim.c
+++ b/hw/openrisc/openrisc_sim.c
@@ -354,7 +354,7 @@ static void openrisc_sim_init(MachineState *machine)
                                              machine->initrd_filename,
                                              load_addr, machine->ram_size);
         }
-        boot_info.fdt_addr = openrisc_load_fdt(state->fdt, load_addr,
+        boot_info.fdt_addr = openrisc_load_fdt(machine, state->fdt, load_addr,
                                                machine->ram_size);
     }
 }
diff --git a/hw/openrisc/virt.c b/hw/openrisc/virt.c
index 7b60bf85094..9afe407b00a 100644
--- a/hw/openrisc/virt.c
+++ b/hw/openrisc/virt.c
@@ -540,7 +540,7 @@ static void openrisc_virt_init(MachineState *machine)
                                              machine->initrd_filename,
                                              load_addr, machine->ram_size);
         }
-        boot_info.fdt_addr = openrisc_load_fdt(state->fdt, load_addr,
+        boot_info.fdt_addr = openrisc_load_fdt(machine, state->fdt, load_addr,
                                                machine->ram_size);
     }
 }
-- 
2.34.1


