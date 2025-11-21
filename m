Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8F9D0CFA759
	for <qemu-devel@archiver.kernel.org>; Fri, 21 Nov 2025 09:09:38 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vMN8e-000622-Vk; Fri, 21 Nov 2025 04:09:09 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <zhiyuan.plct@isrc.iscas.ac.cn>)
 id 1vMN8c-00061b-E4; Fri, 21 Nov 2025 04:09:06 -0500
Received: from smtp81.cstnet.cn ([159.226.251.81] helo=cstnet.cn)
 by eggs.gnu.org with esmtps (TLS1.2:DHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <zhiyuan.plct@isrc.iscas.ac.cn>)
 id 1vMN8Z-0007h7-Ha; Fri, 21 Nov 2025 04:09:06 -0500
Received: from chenxiaoou-ubuntu-02.. (unknown [210.73.43.101])
 by APP-03 (Coremail) with SMTP id rQCowADnctUiLCBp3cGHAQ--.12868S2;
 Fri, 21 Nov 2025 17:08:50 +0800 (CST)
From: TravisYang <zhiyuan.plct@isrc.iscas.ac.cn>
To: Palmer Dabbelt <palmer@dabbelt.com>,
 Alistair Francis <alistair.francis@wdc.com>,
 Weiwei Li <liwei1518@gmail.com>,
 Daniel Henrique Barboza <dbarboza@ventanamicro.com>,
 Liu Zhiwei <zhiwei_liu@linux.alibaba.com>
Cc: TravisYang <zhiyuan.plct@isrc.iscas.ac.cn>, qemu-riscv@nongnu.org,
 qemu-devel@nongnu.org
Subject: [PATCH v1] target/riscv:Add support for RV64 Sifive U74 CPU
Date: Fri, 21 Nov 2025 09:08:48 +0000
Message-Id: <20251121090849.1353917-1-zhiyuan.plct@isrc.iscas.ac.cn>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID: rQCowADnctUiLCBp3cGHAQ--.12868S2
X-Coremail-Antispam: 1UD129KBjvJXoWxXF45Cw45ZF18tF1xKr48JFb_yoW5Cw1kpr
 15GFs09a4DJFZFv3yfJF4DXrn5Wws5u3yxK39xZ3W7KF4agFZxJrnrJr4UCr40qF1fJw1F
 gr18Gr15Gws0qa7anT9S1TB71UUUUU7qnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
 9KBjDU0xBIdaVrnRJUUUvq14x267AKxVW8JVW5JwAFc2x0x2IEx4CE42xK8VAvwI8IcIk0
 rVWUuVWrJwAFIxvE14AKwVWUJVWUGwA2ocxC64kIII0Yj41l84x0c7CEw4AK67xGY2AK02
 1l84ACjcxK6xIIjxv20xvE14v26r1j6r1xM28EF7xvwVC0I7IYx2IY6xkF7I0E14v26r1j
 6r4UM28EF7xvwVC2z280aVAFwI0_Jr0_Gr1l84ACjcxK6I8E87Iv6xkF7I0E14v26r4j6r
 4UJwAS0I0E0xvYzxvE52x082IY62kv0487Mc02F40EFcxC0VAKzVAqx4xG6I80ewAv7VC0
 I7IYx2IY67AKxVWUXVWUAwAv7VC2z280aVAFwI0_Gr0_Cr1lOx8S6xCaFVCjc4AY6r1j6r
 4UM4x0Y48IcxkI7VAKI48JM4x0x7Aq67IIx4CEVc8vx2IErcIFxwCY1x0262kKe7AKxVWU
 AVWUtwCY02Avz4vE14v_GFWl42xK82IYc2Ij64vIr41l4I8I3I0E4IkC6x0Yz7v_Jr0_Gr
 1lx2IqxVAqx4xG67AKxVWUJVWUGwC20s026x8GjcxK67AKxVWUGVWUWwC2zVAF1VAY17CE
 14v26r1q6r43MIIYrxkI7VAKI48JMIIF0xvE2Ix0cI8IcVAFwI0_Jr0_JF4lIxAIcVC0I7
 IYx2IY6xkF7I0E14v26r1j6r4UMIIF0xvE42xK8VAvwI8IcIk0rVWUJVWUCwCI42IY6I8E
 87Iv67AKxVWUJVW8JwCI42IY6I8E87Iv6xkF7I0E14v26r1j6r4UYxBIdaVFxhVjvjDU0x
 ZFpf9x0JU2eHgUUUUU=
X-Originating-IP: [210.73.43.101]
X-CM-SenderInfo: 52kl53ddqo1z1fw6x21ufox2xfdvhtffof0/
Received-SPF: pass client-ip=159.226.251.81;
 envelope-from=zhiyuan.plct@isrc.iscas.ac.cn; helo=cstnet.cn
X-Spam_score_int: -41
X-Spam_score: -4.2
X-Spam_bar: ----
X-Spam_report: (-4.2 / 5.0 requ) BAYES_00=-1.9, RCVD_IN_DNSWL_MED=-2.3,
 RCVD_IN_VALIDITY_CERTIFIED_BLOCKED=0.001, RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001,
 SPF_HELO_PASS=-0.001, SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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

Add a CPU entry for the RV64 SiFive U74 CPU .It is available in
single-core and dual-core configurations,and features advanced power
management and AIA compliance.More details can be found at
https://www.sifive.com/document-file/sifive-essential-u7-product-brief
 

Signed-off-by: TravisYang <zhiyuan.plct@isrc.iscas.ac.cn>
---
 target/riscv/cpu-qom.h |  1 +
 target/riscv/cpu.c     | 44 ++++++++++++++++++++++++++++++++++++------
 2 files changed, 39 insertions(+), 6 deletions(-)

diff --git a/target/riscv/cpu-qom.h b/target/riscv/cpu-qom.h
index 1fc8140190..f17390d072 100644
--- a/target/riscv/cpu-qom.h
+++ b/target/riscv/cpu-qom.h
@@ -57,6 +57,7 @@
 #define TYPE_RISCV_CPU_XIANGSHAN_NANHU  RISCV_CPU_TYPE_NAME("xiangshan-nanhu")
 #define TYPE_RISCV_CPU_XIANGSHAN_KMH    RISCV_CPU_TYPE_NAME("xiangshan-kunminghu")
 #define TYPE_RISCV_CPU_THEAD_C910       RISCV_CPU_TYPE_NAME("thead-c910")
+#define TYPE_RISCV_CPU_SIFIVE_U74       RISCV_CPU_TYPE_NAME("sifive-u74")
 #define TYPE_RISCV_CPU_HOST             RISCV_CPU_TYPE_NAME("host")
 
 OBJECT_DECLARE_CPU_TYPE(RISCVCPU, RISCVCPUClass, RISCV_CPU)
diff --git a/target/riscv/cpu.c b/target/riscv/cpu.c
index ea9e6eb6a5..aa2fc59804 100644
--- a/target/riscv/cpu.c
+++ b/target/riscv/cpu.c
@@ -3284,10 +3284,10 @@ static const TypeInfo riscv_cpu_type_infos[] = {
         .cfg.pmp = true,
         .cfg.max_satp_mode = VM_1_10_SV48,
     ),
-
+
 	DEFINE_RISCV_CPU(TYPE_RISCV_CPU_THEAD_C910, TYPE_RISCV_VENDOR_CPU,
 		.misa_mxl_max = MXL_RV64,
-       .misa_ext = RVG | RVC | RVS | RVU,
+       .misa_ext = RVG | RVC | RVS | RVU,
 		.priv_spec = PRIV_VERSION_1_12_0,
 
 		.cfg.ext_zcf = true,
@@ -3297,9 +3297,9 @@ static const TypeInfo riscv_cpu_type_infos[] = {
 		.cfg.ext_zfhmin = true,
 
 		.cfg.mmu = true,
-       .cfg.ext_xtheadba = true,
-       .cfg.ext_xtheadbb = true,
-       .cfg.ext_xtheadbs = true,
+       .cfg.ext_xtheadba = true,
+       .cfg.ext_xtheadbb = true,
+       .cfg.ext_xtheadbs = true,
 	 	.cfg.ext_xtheadcmo = true,
 		.cfg.ext_xtheadcondmov = true,
 		.cfg.ext_xtheadfmemidx = true,
@@ -3328,9 +3328,41 @@ static const TypeInfo riscv_cpu_type_infos[] = {
 		.cfg.max_satp_mode = VM_1_10_SV39,
 #ifndef CONFIG_USER_ONLY
 		.custom_csrs = th_csr_list,
-#endif
+#endif
 	),
 
+    DEFINE_RISCV_CPU(TYPE_RISCV_CPU_SIFIVE_U74, TYPE_RISCV_CPU_SIFIVE_U,
+       .misa_mxl_max = MXL_RV64,
+       .misa_ext = RVI | RVM | RVA | RVF | RVD | RVC | RVS | RVU | RVH,
+       .priv_spec = PRIV_VERSION_1_12_0,
+
+       .cfg.mmu = true,
+       .cfg.pmp_regions = 16,
+
+       .cfg.ext_zba = true,
+       .cfg.ext_zbb = true,
+       .cfg.ext_zbs = true,
+       .cfg.ext_zic64b = true,
+
+       .cfg.ext_zicbom = true,
+       .cfg.ext_zicboz = true,
+       .cfg.ext_zicbop = true,
+
+       .cfg.ext_svinval = true,
+       .cfg.ext_svadu = true,
+
+       .cfg.ext_zfh = true,
+       .cfg.ext_zfhmin = true,
+       .cfg.ext_zfa = true,
+
+       .cfg.ext_smaia = true,
+       .cfg.ext_ssaia = true,
+
+       .cfg.ext_sscofpmf = true,
+       .cfg.ext_sstc = true,
+
+       .cfg.max_satp_mode = VM_1_10_SV39,
+    ),
 
 #if defined(CONFIG_TCG) && !defined(CONFIG_USER_ONLY)
     DEFINE_RISCV_CPU(TYPE_RISCV_CPU_BASE128, TYPE_RISCV_DYNAMIC_CPU,
-- 
2.34.1


