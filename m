Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 58ABD606A325
	for <qemu-devel@archiver.kernel.org>; Sun,  1 Nov 2026 03:16:46 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xNM3F-00036t-Ao; Sat, 31 Oct 2026 23:16:09 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <tanchi25@mails.ucas.ac.cn>)
 id 1xNM3B-00033n-6f; Sat, 31 Oct 2026 23:16:05 -0400
Received: from smtp81.cstnet.cn ([159.226.251.81] helo=cstnet.cn)
 by eggs.gnu.org with esmtps (TLS1.2:DHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <tanchi25@mails.ucas.ac.cn>)
 id 1xNM38-0000Jt-Na; Sat, 31 Oct 2026 23:16:04 -0400
Received: from k3-03 (unknown [159.226.43.8])
 by APP-03 (Coremail) with SMTP id rQCowAAXJ5jlruZqSD4aAA--.22476S3;
 Sun, 01 Nov 2026 11:15:52 +0800 (CST)
From: Tan Chi <tanchi25@mails.ucas.ac.cn>
To: qemu-devel@nongnu.org
Cc: qemu-riscv@nongnu.org, pbonzini@redhat.com, palmer@dabbelt.com,
 alistair.francis@wdc.com, liwei1518@gmail.com,
 daniel.barboza@oss.qualcomm.com, zhiwei_liu@linux.alibaba.com,
 chao.liu@processmission.com, Tan Chi <tanchi25@mails.ucas.ac.cn>
Subject: [PATCH 1/5] hw/riscv: Build AIA glue only with APLIC and IMSIC
Date: Sun,  1 Nov 2026 11:15:43 +0800
Message-ID: <20261101031547.125591-2-tanchi25@mails.ucas.ac.cn>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20261101031547.125591-1-tanchi25@mails.ucas.ac.cn>
References: <20261101031547.125591-1-tanchi25@mails.ucas.ac.cn>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID: rQCowAAXJ5jlruZqSD4aAA--.22476S3
X-Coremail-Antispam: 1UD129KBjvJXoW7KFyDAFWUtFWUCFyrJryUtrb_yoW8tr1rpF
 s8GrsayryrJF1Sqa9Ikr1kAFnxJwsxur15Gr4qkw18ArsxArW5Jrsxtw4Y9Fy7JFW0yF4F
 vFWkGFy5uF45Xw7anT9S1TB71UUUUU7qnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
 9KBjDU0xBIdaVrnRJUUUHF14x267AKxVW5JVWrJwAFc2x0x2IEx4CE42xK8VAvwI8IcIk0
 rVWrJVCq3wAFIxvE14AKwVWUJVWUGwA2048vs2IY020E87I2jVAFwI0_Jr4l82xGYIkIc2
 x26xkF7I0E14v26r1I6r4UM28lY4IEw2IIxxk0rwA2F7IY1VAKz4vEj48ve4kI8wA2z4x0
 Y4vE2Ix0cI8IcVAFwI0_Gr0_Xr1l84ACjcxK6xIIjxv20xvEc7CjxVAFwI0_Cr0_Gr1UM2
 8EF7xvwVC2z280aVAFwI0_Gr1j6F4UJwA2z4x0Y4vEx4A2jsIEc7CjxVAFwI0_Gr1j6F4U
 JwAac4AC62xK8xCEY4vEwIxC4wAS0I0E0xvYzxvE52x082IY62kv0487Mc02F40EFcxC0V
 AKzVAqx4xG6I80ewAv7VC0I7IYx2IY67AKxVWUJVWUGwAv7VC2z280aVAFwI0_Jr0_Gr1l
 Ox8S6xCaFVCjc4AY6r1j6r4UM4x0Y48IcxkI7VAKI48JM4x0x7Aq67IIx4CEVc8vx2IErc
 IFxwACI402YVCY1x02628vn2kIc2xKxwCY1x0262kKe7AKxVWUtVW8ZwCY02Avz4vE14v_
 Gr4l42xK82IYc2Ij64vIr41l4I8I3I0E4IkC6x0Yz7v_Jr0_Gr1lx2IqxVAqx4xG67AKxV
 WUJVWUGwC20s026x8GjcxK67AKxVWUGVWUWwC2zVAF1VAY17CE14v26r1q6r43MIIYrxkI
 7VAKI48JMIIF0xvE2Ix0cI8IcVAFwI0_Jr0_JF4lIxAIcVC0I7IYx2IY6xkF7I0E14v26r
 4j6F4UMIIF0xvE42xK8VAvwI8IcIk0rVWUJVWUCwCI42IY6I8E87Iv67AKxVWUJVW8JwCI
 42IY6I8E87Iv6xkF7I0E14v26r4j6r4UJbIYCTnIWIevJa73UjIFyTuYvjfU1TmhDUUUU
X-CM-SenderInfo: pwdquxrlsvqzpdlo2hpxfd2hldfou0/
Received-SPF: pass client-ip=159.226.251.81;
 envelope-from=tanchi25@mails.ucas.ac.cn; helo=cstnet.cn
X-Spam_score_int: -41
X-Spam_score: -4.2
X-Spam_bar: ----
X-Spam_report: (-4.2 / 5.0 requ) BAYES_00=-1.9, RCVD_IN_DNSWL_MED=-2.3,
 SPF_HELO_PASS=-0.001, SPF_PASS=-0.001 autolearn=ham autolearn_force=no
X-Spam_action: no action
X-BeenThere: qemu-devel@nongnu.org
X-Mailman-Version: 2.1.29
Precedence: list
List-Id: qemu development <qemu-devel.nongnu.org>
List-Archive: <https://lists.nongnu.org/archive/html/qemu-devel>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=subscribe>
Sender: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
X-Spam-Status: No, score=-16.8 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_PASS,SPF_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

hw/riscv/aia.c is built unconditionally, but riscv_create_aia()
references the APLIC and IMSIC device implementations, which are
only built when their respective Kconfig options are enabled.

This causes undefined references to riscv_aplic_create() in
minimal RISC-V builds that do not include APLIC.

Build aia.c only when both CONFIG_RISCV_APLIC and
CONFIG_RISCV_IMSIC are enabled. Move imsic_num_bits() to aia.h
as a static inline helper, since it is also used by FDT and
ACPI code independently of the AIA device creation helper.

Signed-off-by: Tan Chi <tanchi25@mails.ucas.ac.cn>
---
 hw/riscv/aia.c       | 11 -----------
 hw/riscv/aia.h       | 12 +++++++++++-
 hw/riscv/meson.build |  3 ++-
 3 files changed, 13 insertions(+), 13 deletions(-)

diff --git a/hw/riscv/aia.c b/hw/riscv/aia.c
index 56fc064533..4463ea2be8 100644
--- a/hw/riscv/aia.c
+++ b/hw/riscv/aia.c
@@ -13,17 +13,6 @@
 
 #include "aia.h"
 
-uint32_t imsic_num_bits(uint32_t count)
-{
-    uint32_t ret = 0;
-
-    while (BIT(ret) < count) {
-        ret++;
-    }
-
-    return ret;
-}
-
 DeviceState *riscv_create_aia(MemoryRegion *container,
                              bool msimode, int aia_guests,
                              uint32_t m_imsic_stride,
diff --git a/hw/riscv/aia.h b/hw/riscv/aia.h
index 5df3292610..e4dcc5aae0 100644
--- a/hw/riscv/aia.h
+++ b/hw/riscv/aia.h
@@ -10,8 +10,18 @@
 #define HW_RISCV_AIA_H
 
 #include "exec/hwaddr.h"
+#include "qemu/bitops.h"
 
-uint32_t imsic_num_bits(uint32_t count);
+static inline uint32_t imsic_num_bits(uint32_t count)
+{
+    uint32_t ret = 0;
+
+    while (BIT(ret) < count) {
+        ret++;
+    }
+
+    return ret;
+}
 
 DeviceState *riscv_create_aia(MemoryRegion *container,
                              bool msimode, int aia_guests,
diff --git a/hw/riscv/meson.build b/hw/riscv/meson.build
index 6bdabb9544..957031c07d 100644
--- a/hw/riscv/meson.build
+++ b/hw/riscv/meson.build
@@ -1,5 +1,6 @@
 riscv_ss = ss.source_set()
-riscv_ss.add(files('aia.c'))
+riscv_ss.add(when: ['CONFIG_RISCV_APLIC', 'CONFIG_RISCV_IMSIC'],
+             if_true: files('aia.c'))
 riscv_ss.add(files('boot.c'))
 riscv_ss.add(files('device-common.c'))
 riscv_ss.add(files('fdt-common.c'))
-- 
2.53.0


