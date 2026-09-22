Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id CCDFAC982FE
	for <qemu-devel@archiver.kernel.org>; Tue, 22 Sep 2026 14:22:58 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1x91Nt-0006oW-J3; Tue, 22 Sep 2026 10:22:13 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <dblanzeanu@linux.microsoft.com>)
 id 1x91Nq-0006np-Mk
 for qemu-devel@nongnu.org; Tue, 22 Sep 2026 10:22:11 -0400
Received: from linux.microsoft.com ([13.77.154.182])
 by eggs.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <dblanzeanu@linux.microsoft.com>) id 1x91No-0003t6-RG
 for qemu-devel@nongnu.org; Tue, 22 Sep 2026 10:22:10 -0400
Received: from laptop.localdomain (unknown [81.196.141.38])
 by linux.microsoft.com (Postfix) with ESMTPSA id 525EC20B7169;
 Tue, 22 Sep 2026 07:21:18 -0700 (PDT)
DKIM-Filter: OpenDKIM Filter v2.11.0 linux.microsoft.com 525EC20B7169
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.microsoft.com;
 s=default; t=1790086879;
 bh=UGDJBAU+mCe1mAPEY0xyQf/BhO/3Vmb6hJmhba7fiPA=;
 h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
 b=DW9+w4cwcTqUapPUGW2ked+FZf9/dEocc8RcU8CKnAwbCrWtpwpKMLdLwNzq+aYXQ
 AsUX0l35ZwJxuyd2MaWTBQiBgtXq/0bVI56BJEyFbzvoSuz9yAt39cbDnNqPQBqilh
 xHdiaCdQfw6xBBvGFCKL3ok2yz02f2XCriQXbCic=
From: =?UTF-8?q?Doru=20Bl=C3=A2nzeanu?= <dblanzeanu@linux.microsoft.com>
To: qemu-devel@nongnu.org
Cc: Magnus Kulke <magnuskulke@microsoft.com>,
 Magnus Kulke <magnuskulke@linux.microsoft.com>,
 Wei Liu <wei.liu@kernel.org>,
 =?UTF-8?q?Doru=20Bl=C3=A2nzeanu?= <dblanzeanu@linux.microsoft.com>,
 Wei Liu <liuwe@microsoft.com>,
 =?UTF-8?q?Doru=20Bl=C3=A2nzeanu?= <dblanzeanu@microsoft.com>
Subject: [PATCH v2 2/2] accel/mshv: enable amx tiles support for guests
Date: Tue, 22 Sep 2026 17:21:56 +0300
Message-ID: <20260922142156.89306-3-dblanzeanu@linux.microsoft.com>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260922142156.89306-1-dblanzeanu@linux.microsoft.com>
References: <20260922142156.89306-1-dblanzeanu@linux.microsoft.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=13.77.154.182;
 envelope-from=dblanzeanu@linux.microsoft.com; helo=linux.microsoft.com
X-Spam_score_int: -19
X-Spam_score: -2.0
X-Spam_bar: --
X-Spam_report: (-2.0 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, SPF_HELO_PASS=-0.001,
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

The AMX tiles feature uses a larger than 4kB area in xsave.
This fix removes the code that disables AMX tiles in the partition and it
adjusts the supported CPUID to advertise AMX tiles.

Signed-off-by: Doru Blânzeanu <dblanzeanu@linux.microsoft.com>
---
 accel/mshv/mshv-all.c       | 18 +++++-------------
 target/i386/mshv/mshv-cpu.c | 16 ----------------
 2 files changed, 5 insertions(+), 29 deletions(-)

diff --git a/accel/mshv/mshv-all.c b/accel/mshv/mshv-all.c
index 725ccd0511..99b2b3362a 100644
--- a/accel/mshv/mshv-all.c
+++ b/accel/mshv/mshv-all.c
@@ -187,7 +187,6 @@ static int create_partition(int mshv_fd, int *vm_fd)
 {
     int ret;
     uint64_t pt_flags, host_proc_features;
-    union hv_partition_processor_xsave_features disabled_xsave_features;
     union hv_partition_processor_features disabled_partition_features = {0};
 
     struct mshv_create_partition_v2 args = {0};
@@ -200,17 +199,6 @@ static int create_partition(int mshv_fd, int *vm_fd)
                (1ULL << MSHV_PT_BIT_GPA_SUPER_PAGES) |
                (1ULL << MSHV_PT_BIT_CPU_AND_XSAVE_FEATURES);
 
-    /* enable all */
-    disabled_xsave_features.as_uint64 = 0;
-    /*
-     * AMX TILE XSAVE state (XTILE_DATA) is 8KB, which exceeds the
-     * current fixed 4KB XSAVE buffer size.
-     */
-    disabled_xsave_features.amx_tile_support = 1;
-    disabled_xsave_features.amx_bf16_support = 1;
-    disabled_xsave_features.amx_int8_support = 1;
-    disabled_xsave_features.amx_fp16_support = 1;
-
     /*
      * query host for supported processor features and disable unsupported
      * features: (0 means supported, 1 means disabled, hence the negation)
@@ -238,10 +226,14 @@ static int create_partition(int mshv_fd, int *vm_fd)
     args.pt_cpu_fbanks[0] |= disabled_partition_features.as_uint64[0];
     args.pt_cpu_fbanks[1] |= disabled_partition_features.as_uint64[1];
 
+    /*
+     * for now, all the xsave features are enabled, the filtering is only done
+     * at the CPUID level
+     * TODO: filter the xsave features based on the CPUID derived from Cpu model
+     */
     /* populate args structure */
     args.pt_flags = pt_flags;
     args.pt_isolation = MSHV_PT_ISOLATION_NONE;
-    args.pt_disabled_xsave = disabled_xsave_features.as_uint64;
     args.pt_num_cpu_fbanks = MSHV_NUM_CPU_FEATURES_BANKS;
 
     ret = ioctl(mshv_fd, MSHV_CREATE_PARTITION, &args);
diff --git a/target/i386/mshv/mshv-cpu.c b/target/i386/mshv/mshv-cpu.c
index 5b845b3e4e..21a3534578 100644
--- a/target/i386/mshv/mshv-cpu.c
+++ b/target/i386/mshv/mshv-cpu.c
@@ -2234,22 +2234,6 @@ uint32_t mshv_get_supported_cpuid(uint32_t func, uint32_t idx, int reg)
          */
         ret &= ~CPUID_7_0_ECX_LA57;
     }
-    if (func == 0x07 && idx == 0 && reg == R_EDX) {
-        /*
-         * AMX TILE XSAVE state (XTILE_DATA) is 8KB, which exceeds the
-         * current fixed 4KB XSAVE buffer size. Filter until buffer
-         * sizing is computed dynamically from CPUID.
-         */
-        ret &= ~CPUID_7_0_EDX_AMX_TILE;
-        ret &= ~CPUID_7_0_EDX_AMX_BF16;
-        ret &= ~CPUID_7_0_EDX_AMX_INT8;
-    }
-    if (func == 0x07 && idx == 1 && reg == R_EAX) {
-        ret &= ~CPUID_7_1_EAX_AMX_FP16;
-    }
-    if (func == 0x07 && idx == 1 && reg == R_EDX) {
-        ret &= ~CPUID_7_1_EDX_AMX_COMPLEX;
-    }
 
     return ret;
 }
-- 
2.53.0


