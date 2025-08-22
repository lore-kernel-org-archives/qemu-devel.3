Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 42F97CA0EED
	for <qemu-devel@archiver.kernel.org>; Fri, 22 Aug 2025 13:55:37 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1upSDc-00065o-KL; Fri, 22 Aug 2025 09:54:12 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <cjchen@igel.co.jp>) id 1upO23-00066J-S4
 for qemu-devel@nongnu.org; Fri, 22 Aug 2025 05:25:59 -0400
Received: from mail-pl1-x634.google.com ([2607:f8b0:4864:20::634])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <cjchen@igel.co.jp>) id 1upO1z-0007JN-MJ
 for qemu-devel@nongnu.org; Fri, 22 Aug 2025 05:25:59 -0400
Received: by mail-pl1-x634.google.com with SMTP id
 d9443c01a7336-24646202152so3533735ad.0
 for <qemu-devel@nongnu.org>; Fri, 22 Aug 2025 02:25:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=igel-co-jp.20230601.gappssmtp.com; s=20230601; t=1755854753; x=1756459553;
 darn=nongnu.org; 
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=4n1o/3nULdO/4vcLp6ocaeLLrGhDDgu+DIftv97o3kU=;
 b=upys3JB4yKZU3ArIe++mskr14PrqnT5rPWeR6EO7s0Yqg/IlgGAjC7LaU8tAe5h+X/
 9p8bTY5elv5QATxT1TEYGRO370kAJCog70hSNKG+HLOu8+3hPFhqpIskttRA7QH8eBMh
 dW+WhDxFDAIDgsQKqF+XhTzCkPvUAfeS14dvfxIy+nGSs4pqO9975J08lNov7JeB9Zt+
 eXGTuwh76JzjrDmt4nEIMc+324+L2IhhluBC7JI/cBZTdzL9qGf0InhM6RXdo1PjTtgw
 z9KdYK2g/8KujQjEdiluiui7EAiAAdO5wmo9lBik28wCjvj50/lczhKJ28bk3emkar8F
 7DrA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1755854753; x=1756459553;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=4n1o/3nULdO/4vcLp6ocaeLLrGhDDgu+DIftv97o3kU=;
 b=SbYZL3F0hqR1azOhSVmvmoIQSkDuGR8sXtkk/j1rqvg2ppA8OHul+L68x/p6qGRy3R
 uXPQOfbfumcs+tNGvaMXD0/b9sv74K9w5rZpODpU6O+MqkHs3fii5igDnBKx9NWrR27y
 ZGHgPB0esdh2sWgyIw9XVjf1DTqKgU2D+qGqgZ4ugsaPbp/JKtPVBLKZxRTDK4N84/L6
 xWta6wxl8kmDbnG7auhtjxPeGbwUi0Ae0uTSET9t+fYCe4z7yWAyjmVYYMKNSAHh/qvJ
 bQmaklSDDa2NJNx7VewlDH2UtdE7h5JOgZLW3wCEjjRfBw94tLa7tAPAvHRnCAJtUpUk
 vZOQ==
X-Gm-Message-State: AOJu0YxybqLH+PDnt8HbAJ33JrgkMa9iDuUCFfGk18RHa35i0jbyLRJA
 2+IM8J+ysZUKCRxI/USXNnNV0KRG0N2CX68qhYRblwXkwk7VlHuMHtF5y/zMxPRvb/Ii8xZOgUv
 Poke7yLY=
X-Gm-Gg: ASbGnct72km+zsBuLk9ubFxpiZA/R0XkL9wO7WHGJiXk9WvAiXRAzQj1JhF/7PyDJ7n
 8PqDdrmzj3ARomn5tdx2+j5v5Wu2JeZEdR0bJE5nuFlFTFETsWoCS8mCd2+0L11rg6QZ9cZtH4K
 COutpLvObVGvBiJL3mebbQ2gAaXXL4cXQfBOmwPXqC6MKpM+A5uiKPYgwwuXfxrs4WqUf1oGkSN
 SfSh9hs/vNe83boeycmIK4wtNWpdGAawJTy4MS8eIvxdmj33/ZMcySHhYWwk/v2d0PDPmJf2l2c
 ZizHDBx8C2tJcGuD6furhDJb6Eogq5asV+aSFRrykTGz3qWqFrW1NzSwpKKg3bvQ7EP/KGuimyU
 UZNjmuaAVG6/+8jR6lPX6hkA0Ly1vAl4FKFyM+OOfRH20EKHfsdmw
X-Google-Smtp-Source: AGHT+IEnJxA4ELufqmF+83vXLTGSupOh5K2TH6ao0bmRfoYOFqouqA0TtrEayssE+w//NktDX9P0JA==
X-Received: by 2002:a17:902:ebc5:b0:246:255a:1915 with SMTP id
 d9443c01a7336-2462eea840emr32074745ad.27.1755854753093; 
 Fri, 22 Aug 2025 02:25:53 -0700 (PDT)
Received: from warg.hq.igel.co.jp (napt.igel.co.jp. [219.106.231.132])
 by smtp.gmail.com with ESMTPSA id
 d9443c01a7336-245ed4c6fb7sm78560215ad.89.2025.08.22.02.25.46
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 22 Aug 2025 02:25:52 -0700 (PDT)
From: CJ Chen <cjchen@igel.co.jp>
To: qemu-devel@nongnu.org, qemu-block@nongnu.org, qemu-riscv@nongnu.org,
 qemu-arm@nongnu.org
Cc: Paolo Bonzini <pbonzini@redhat.com>, Keith Busch <kbusch@kernel.org>,
 Klaus Jensen <its@irrelevant.dk>, Jesper Devantier <foss@defmacro.it>,
 Palmer Dabbelt <palmer@dabbelt.com>,
 Alistair Francis <alistair.francis@wdc.com>,
 Weiwei Li <liwei1518@gmail.com>,
 Daniel Henrique Barboza <dbarboza@ventanamicro.com>,
 Liu Zhiwei <zhiwei_liu@linux.alibaba.com>,
 Tyrone Ting <kfting@nuvoton.com>, Hao Wu <wuhaotsh@google.com>,
 Max Filippov <jcmvbkbc@gmail.com>, Peter Xu <peterx@redhat.com>,
 David Hildenbrand <david@redhat.com>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Fabiano Rosas <farosas@suse.de>, Laurent Vivier <lvivier@redhat.com>,
 Tomoyuki Hirose <hrstmyk811m@gmail.com>,
 Peter Maydell <peter.maydell@linaro.org>, CJ Chen <cjchen@igel.co.jp>
Subject: [RFC PATCH v2 8/9] hw/misc: add test device for memory access
Date: Fri, 22 Aug 2025 18:24:09 +0900
Message-Id: <20250822092410.25833-9-cjchen@igel.co.jp>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20250822092410.25833-1-cjchen@igel.co.jp>
References: <20250822092410.25833-1-cjchen@igel.co.jp>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::634;
 envelope-from=cjchen@igel.co.jp; helo=mail-pl1-x634.google.com
X-Spam_score_int: -18
X-Spam_score: -1.9
X-Spam_bar: -
X-Spam_report: (-1.9 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=unavailable autolearn_force=no
X-Spam_action: no action
X-Mailman-Approved-At: Fri, 22 Aug 2025 09:53:59 -0400
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

From: Tomoyuki Hirose <hrstmyk811m@gmail.com>

This commit adds a test device for checking memory access. The test
device generates memory regions that covers all the legal parameter
patterns. With this device, we can check the handling of
reading/writing the MemoryRegion is correct.

Co-developed-by: CJ Chen <cjchen@igel.co.jp>
Signed-off-by: CJ Chen <cjchen@igel.co.jp>
Tested-by: CJ Chen <cjchen@igel.co.jp>
Suggested-by: Peter Maydell <peter.maydell@linaro.org>
---
v2:
   - Fix the typo of ops size of big-l-valid.
   - Replaced the huge macro blocks with dynamic loops that fill in
     the `MemoryRegionOps` arrays at runtime.
   - Remove test cases valid.unaligned = false,impl.unaligned = true.
---
 hw/misc/Kconfig                     |   4 +
 hw/misc/memaccess-testdev.c         | 331 ++++++++++++++++++++++++++++
 hw/misc/meson.build                 |   1 +
 include/hw/misc/memaccess-testdev.h | 104 +++++++++
 4 files changed, 440 insertions(+)
 create mode 100644 hw/misc/memaccess-testdev.c
 create mode 100644 include/hw/misc/memaccess-testdev.h

diff --git a/hw/misc/Kconfig b/hw/misc/Kconfig
index ec0fa5aa9f..ff7d7c65ef 100644
--- a/hw/misc/Kconfig
+++ b/hw/misc/Kconfig
@@ -25,6 +25,10 @@ config PCI_TESTDEV
     default y if TEST_DEVICES
     depends on PCI
 
+config MEMACCESS_TESTDEV
+    bool
+    default y if TEST_DEVICES
+
 config EDU
     bool
     default y if TEST_DEVICES
diff --git a/hw/misc/memaccess-testdev.c b/hw/misc/memaccess-testdev.c
new file mode 100644
index 0000000000..1aaa52c69f
--- /dev/null
+++ b/hw/misc/memaccess-testdev.c
@@ -0,0 +1,331 @@
+/*
+ * QEMU memory access test device
+ *
+ * SPDX-License-Identifier: GPL-2.0-or-later
+ *
+ * Author: Tomoyuki HIROSE <hrstmyk811m@gmail.com>
+ *
+ * This device is used to test memory acccess, like:
+ * qemu-system-x86_64 -device memaccess-testdev,address=0x10000000
+ */
+
+#include "qemu/osdep.h"
+#include "system/address-spaces.h"
+#include "system/memory.h"
+#include "hw/qdev-core.h"
+#include "hw/qdev-properties.h"
+#include "qapi/error.h"
+#include "qemu/typedefs.h"
+#include "qom/object.h"
+#include "hw/misc/memaccess-testdev.h"
+
+typedef bool (*skip_func_ptr)(uint32_t valid_max, uint32_t valid_min,
+                              bool valid_unaligned, uint32_t impl_max,
+                              uint32_t impl_min, bool impl_unaligned);
+
+typedef struct MrOpsList {
+    const char *name;
+    MemoryRegionOps *ops_array;
+    const size_t ops_array_len;
+    const size_t offset_idx;
+    skip_func_ptr skip_fn;
+    bool is_little;
+} MrOpsList;
+
+MemoryRegionOps ops_list_little_b_valid[N_OPS_LIST_LITTLE_B_VALID];
+MemoryRegionOps ops_list_little_b_invalid[N_OPS_LIST_LITTLE_B_INVALID];
+MemoryRegionOps ops_list_little_w_valid[N_OPS_LIST_LITTLE_W_VALID];
+MemoryRegionOps ops_list_little_w_invalid[N_OPS_LIST_LITTLE_W_INVALID];
+MemoryRegionOps ops_list_little_l_valid[N_OPS_LIST_LITTLE_L_VALID];
+MemoryRegionOps ops_list_little_l_invalid[N_OPS_LIST_LITTLE_L_INVALID];
+MemoryRegionOps ops_list_little_q_valid[N_OPS_LIST_LITTLE_Q_VALID];
+MemoryRegionOps ops_list_little_q_invalid[N_OPS_LIST_LITTLE_Q_INVALID];
+MemoryRegionOps ops_list_big_b_valid[N_OPS_LIST_BIG_B_VALID];
+MemoryRegionOps ops_list_big_b_invalid[N_OPS_LIST_BIG_B_INVALID];
+MemoryRegionOps ops_list_big_w_valid[N_OPS_LIST_BIG_W_VALID];
+MemoryRegionOps ops_list_big_w_invalid[N_OPS_LIST_BIG_W_INVALID];
+MemoryRegionOps ops_list_big_l_valid[N_OPS_LIST_BIG_L_VALID];
+MemoryRegionOps ops_list_big_l_invalid[N_OPS_LIST_BIG_L_INVALID];
+MemoryRegionOps ops_list_big_q_valid[N_OPS_LIST_BIG_Q_VALID];
+MemoryRegionOps ops_list_big_q_invalid[N_OPS_LIST_BIG_Q_INVALID];
+
+static bool skip_core(uint32_t required_min, bool valid_test,
+                      uint32_t valid_max, uint32_t valid_min,
+                      bool valid_unaligned, uint32_t impl_max,
+                      uint32_t impl_min, bool impl_unaligned)
+{
+    if (valid_min != required_min) {
+        return true;
+    }
+    if (valid_test) {
+        if (!valid_unaligned) {
+            return true;
+        }
+    } else {
+        if (valid_unaligned || impl_unaligned) {
+            return true;
+        }
+    }
+    if (valid_max < valid_min) {
+        return true;
+    }
+
+    if (impl_max < impl_min) {
+        return true;
+    }
+
+    return false;
+}
+
+#define DEFINE_SKIP_VALID_INVALID_FN(NAME, REQ_MIN)                      \
+    static bool skip_##NAME##_valid(uint32_t vm, uint32_t vn, bool vu,   \
+                                    uint32_t im, uint32_t in, bool iu)   \
+    {                                                                    \
+        return skip_core(REQ_MIN, true, vm, vn, vu, im, in, iu);         \
+    }                                                                    \
+                                                                         \
+    static bool skip_##NAME##_invalid(uint32_t vm, uint32_t vn, bool vu, \
+                                      uint32_t im, uint32_t in, bool iu) \
+    {                                                                    \
+        return skip_core(REQ_MIN, false, vm, vn, vu, im, in, iu);        \
+    }
+
+DEFINE_SKIP_VALID_INVALID_FN(b, 1)
+DEFINE_SKIP_VALID_INVALID_FN(w, 2)
+DEFINE_SKIP_VALID_INVALID_FN(l, 4)
+DEFINE_SKIP_VALID_INVALID_FN(q, 8)
+
+static void testdev_init_memory_region(MemoryRegion *mr,
+                                       Object *owner,
+                                       const MemoryRegionOps *ops,
+                                       void *opaque,
+                                       const char *name,
+                                       uint64_t size,
+                                       MemoryRegion *container,
+                                       hwaddr container_offset)
+{
+    memory_region_init_io(mr, owner, ops, opaque, name, size);
+    memory_region_add_subregion(container, container_offset, mr);
+}
+
+static void testdev_init_from_mr_ops_list(MemAccessTestDev *testdev,
+                                          const MrOpsList *l)
+{
+    for (size_t i = 0; i < l->ops_array_len; i++) {
+        g_autofree gchar *name = g_strdup_printf("%s-%ld", l->name, i);
+        testdev_init_memory_region(&testdev->memory_regions[l->offset_idx + i],
+                                   OBJECT(testdev), &l->ops_array[i],
+                                   testdev->mr_data[l->offset_idx + i],
+                                   name,
+                                   MEMACCESS_TESTDEV_REGION_SIZE,
+                                   &testdev->container,
+                                   MEMACCESS_TESTDEV_REGION_SIZE *
+                                   (l->offset_idx + i));
+    }
+}
+
+#define LITTLE 1
+#define BIG    0
+#define _DEFINE_MR_OPS_LIST(_n, _ops, _len, _off, _skipfn, _is_little) \
+{                                                                      \
+    .name          = (_n),                                             \
+    .ops_array     = (_ops),                                           \
+    .ops_array_len = (_len),                                           \
+    .offset_idx    = (_off),                                           \
+    .skip_fn       = (_skipfn),                                        \
+    .is_little     = (_is_little),                                     \
+}
+
+#define DEFINE_MR_OPS_LIST(e, E, w, W, v, V)                    \
+    _DEFINE_MR_OPS_LIST(                                        \
+        #e "-" #w "-" #v,                /* .name            */ \
+        ops_list_##e##_##w##_##v,        /* .ops_array       */ \
+        N_OPS_LIST_##E##_##W##_##V,      /* .ops_array_len   */ \
+        OFF_IDX_OPS_LIST_##E##_##W##_##V,/* .offset_idx      */ \
+        skip_##w##_##v,                  /* .skip_fn         */ \
+        E /* .is_little => 1 = little endian, 0 = big endian */ \
+    )
+
+static MrOpsList mr_ops_list[] = {
+    DEFINE_MR_OPS_LIST(little, LITTLE, b, B, valid,   VALID),
+    DEFINE_MR_OPS_LIST(little, LITTLE, b, B, invalid, INVALID),
+    DEFINE_MR_OPS_LIST(little, LITTLE, w, W, valid,   VALID),
+    DEFINE_MR_OPS_LIST(little, LITTLE, w, W, invalid, INVALID),
+    DEFINE_MR_OPS_LIST(little, LITTLE, l, L, valid,   VALID),
+    DEFINE_MR_OPS_LIST(little, LITTLE, l, L, invalid, INVALID),
+    DEFINE_MR_OPS_LIST(little, LITTLE, q, Q, valid,   VALID),
+    DEFINE_MR_OPS_LIST(little, LITTLE, q, Q, invalid, INVALID),
+    DEFINE_MR_OPS_LIST(big,    BIG,    b, B, valid,   VALID),
+    DEFINE_MR_OPS_LIST(big,    BIG,    b, B, invalid, INVALID),
+    DEFINE_MR_OPS_LIST(big,    BIG,    w, W, valid,   VALID),
+    DEFINE_MR_OPS_LIST(big,    BIG,    w, W, invalid, INVALID),
+    DEFINE_MR_OPS_LIST(big,    BIG,    l, L, valid,   VALID),
+    DEFINE_MR_OPS_LIST(big,    BIG,    l, L, invalid, INVALID),
+    DEFINE_MR_OPS_LIST(big,    BIG,    q, Q, valid,   VALID),
+    DEFINE_MR_OPS_LIST(big,    BIG,    q, Q, invalid, INVALID),
+};
+#undef LITTLE
+#undef BIG
+
+static uint64_t memaccess_testdev_read_little(void *opaque, hwaddr addr,
+                                              unsigned int size)
+{
+    g_assert(addr + size < MEMACCESS_TESTDEV_REGION_SIZE);
+    void *s = (uint8_t *)opaque + addr;
+    return ldn_le_p(s, size);
+}
+
+static void memaccess_testdev_write_little(void *opaque, hwaddr addr,
+                                           uint64_t data, unsigned int size)
+{
+    g_assert(addr + size < MEMACCESS_TESTDEV_REGION_SIZE);
+    void *d = (uint8_t *)opaque + addr;
+    stn_le_p(d, size, data);
+}
+
+static uint64_t memaccess_testdev_read_big(void *opaque, hwaddr addr,
+                                           unsigned int size)
+{
+    g_assert(addr + size < MEMACCESS_TESTDEV_REGION_SIZE);
+    void *s = (uint8_t *)opaque + addr;
+    return ldn_be_p(s, size);
+}
+
+static void memaccess_testdev_write_big(void *opaque, hwaddr addr,
+                                        uint64_t data, unsigned int size)
+{
+    g_assert(addr + size < MEMACCESS_TESTDEV_REGION_SIZE);
+    void *d = (uint8_t *)opaque + addr;
+    stn_be_p(d, size, data);
+}
+
+static void fill_ops_list(MemoryRegionOps *ops,
+                          skip_func_ptr fptr,
+                          size_t ops_len,
+                          bool is_little)
+{
+    static const uint32_t sizes[] = { 1, 2, 4, 8 };
+    static const bool bools[] = { false, true };
+    int idx = 0;
+
+    for (int vMaxIdx = 0; vMaxIdx < 4; vMaxIdx++) {
+        for (int vMinIdx = 0; vMinIdx < 4; vMinIdx++) {
+            for (int vUIdx = 0; vUIdx < 2; vUIdx++) {
+                for (int iMaxIdx = 0; iMaxIdx < 4; iMaxIdx++) {
+                    for (int iMinIdx = 0; iMinIdx < 4; iMinIdx++) {
+                        for (int iUIdx = 0; iUIdx < 2; iUIdx++) {
+                            uint32_t valid_max       = sizes[vMaxIdx];
+                            uint32_t valid_min       = sizes[vMinIdx];
+                            bool     valid_unaligned = bools[vUIdx];
+                            uint32_t impl_max        = sizes[iMaxIdx];
+                            uint32_t impl_min        = sizes[iMinIdx];
+                            bool     impl_unaligned  = bools[iUIdx];
+
+                            if (!fptr(valid_max, valid_min, valid_unaligned,
+                                      impl_max, impl_min, impl_unaligned))
+                            {
+                                const MemoryRegionOps new_op = {
+                                    .read = is_little ?
+                                            memaccess_testdev_read_little :
+                                            memaccess_testdev_read_big,
+                                    .write = is_little ?
+                                             memaccess_testdev_write_little :
+                                             memaccess_testdev_write_big,
+                                    .endianness = is_little ?
+                                                  DEVICE_LITTLE_ENDIAN :
+                                                  DEVICE_BIG_ENDIAN,
+                                    .valid = {
+                                        .max_access_size = valid_max,
+                                        .min_access_size = valid_min,
+                                        .unaligned      = valid_unaligned,
+                                    },
+                                    .impl = {
+                                        .max_access_size = impl_max,
+                                        .min_access_size = impl_min,
+                                        .unaligned       = impl_unaligned,
+                                    },
+                                };
+
+                                ops[idx] = new_op;
+                                idx++;
+                                if (idx > ops_len) {
+                                    g_assert_not_reached();
+                                }
+                            }
+                        }
+                    }
+                }
+            }
+        }
+    }
+}
+
+#define N_MR_OPS_LIST (sizeof(mr_ops_list) / sizeof(MrOpsList))
+
+static void init_testdev(MemAccessTestDev *testdev)
+{
+    memory_region_init(&testdev->container, OBJECT(testdev), "memtest-regions",
+                       MEMACCESS_TESTDEV_REGION_SIZE * N_OPS_LIST);
+    testdev->mr_data = g_malloc(MEMACCESS_TESTDEV_MR_DATA_SIZE);
+
+    for (size_t i = 0; i < N_MR_OPS_LIST; i++) {
+        fill_ops_list(
+            mr_ops_list[i].ops_array,
+            mr_ops_list[i].skip_fn,
+            mr_ops_list[i].ops_array_len,
+            mr_ops_list[i].is_little
+        );
+        testdev_init_from_mr_ops_list(testdev, &mr_ops_list[i]);
+    }
+
+    memory_region_add_subregion(get_system_memory(), testdev->base,
+                                &testdev->container);
+}
+
+static void memaccess_testdev_realize(DeviceState *dev, Error **errp)
+{
+    MemAccessTestDev *d = MEM_ACCESS_TEST_DEV(dev);
+
+    if (d->base == UINT64_MAX) {
+        error_setg(errp, "base address is not assigned");
+        return;
+    }
+
+    init_testdev(d);
+}
+
+static void memaccess_testdev_unrealize(DeviceState *dev)
+{
+    MemAccessTestDev *d = MEM_ACCESS_TEST_DEV(dev);
+    g_free(d->mr_data);
+}
+
+static Property memaccess_testdev_props[] = {
+    DEFINE_PROP_UINT64("address", MemAccessTestDev, base, UINT64_MAX),
+};
+
+static void memaccess_testdev_class_init(ObjectClass *klass, const void *data)
+{
+    DeviceClass *dc = DEVICE_CLASS(klass);
+
+    dc->realize = memaccess_testdev_realize;
+    dc->unrealize = memaccess_testdev_unrealize;
+    device_class_set_props_n(dc,
+                             memaccess_testdev_props,
+                             ARRAY_SIZE(memaccess_testdev_props));
+    set_bit(DEVICE_CATEGORY_MISC, dc->categories);
+}
+
+static const TypeInfo memaccess_testdev_info = {
+    .name = TYPE_MEM_ACCESS_TEST_DEV,
+    .parent = TYPE_DEVICE,
+    .instance_size = sizeof(MemAccessTestDev),
+    .class_init = memaccess_testdev_class_init,
+};
+
+static void memaccess_testdev_register_types(void)
+{
+    type_register_static(&memaccess_testdev_info);
+}
+
+type_init(memaccess_testdev_register_types)
diff --git a/hw/misc/meson.build b/hw/misc/meson.build
index 6d47de482c..f06568aaed 100644
--- a/hw/misc/meson.build
+++ b/hw/misc/meson.build
@@ -4,6 +4,7 @@ system_ss.add(when: 'CONFIG_FW_CFG_DMA', if_true: files('vmcoreinfo.c'))
 system_ss.add(when: 'CONFIG_ISA_DEBUG', if_true: files('debugexit.c'))
 system_ss.add(when: 'CONFIG_ISA_TESTDEV', if_true: files('pc-testdev.c'))
 system_ss.add(when: 'CONFIG_PCI_TESTDEV', if_true: files('pci-testdev.c'))
+system_ss.add(when: 'CONFIG_MEMACCESS_TESTDEV', if_true: files('memaccess-testdev.c'))
 system_ss.add(when: 'CONFIG_UNIMP', if_true: files('unimp.c'))
 system_ss.add(when: 'CONFIG_EMPTY_SLOT', if_true: files('empty_slot.c'))
 system_ss.add(when: 'CONFIG_LED', if_true: files('led.c'))
diff --git a/include/hw/misc/memaccess-testdev.h b/include/hw/misc/memaccess-testdev.h
new file mode 100644
index 0000000000..c1b17297a2
--- /dev/null
+++ b/include/hw/misc/memaccess-testdev.h
@@ -0,0 +1,104 @@
+/*
+ * QEMU memory access test device header
+ *
+ * SPDX-License-Identifier: GPL-2.0-or-later
+ *
+ * Author: Tomoyuki HIROSE <hrstmyk811m@gmail.com>
+ */
+
+#ifndef HW_MISC_MEMACCESS_TESTDEV_H
+#define HW_MISC_MEMACCESS_TESTDEV_H
+
+#include "system/memory.h"
+#include "hw/qdev-core.h"
+
+#define TYPE_MEM_ACCESS_TEST_DEV "memaccess-testdev"
+
+#define MEMACCESS_TESTDEV_REGION_SIZE 32
+
+#define N_OPS_LIST_LITTLE_B_VALID   80
+#define N_OPS_LIST_LITTLE_B_INVALID 40
+#define N_OPS_LIST_LITTLE_W_VALID   60
+#define N_OPS_LIST_LITTLE_W_INVALID 30
+#define N_OPS_LIST_LITTLE_L_VALID   40
+#define N_OPS_LIST_LITTLE_L_INVALID 20
+#define N_OPS_LIST_LITTLE_Q_VALID   20
+#define N_OPS_LIST_LITTLE_Q_INVALID 10
+#define N_OPS_LIST_BIG_B_VALID      80
+#define N_OPS_LIST_BIG_B_INVALID    40
+#define N_OPS_LIST_BIG_W_VALID      60
+#define N_OPS_LIST_BIG_W_INVALID    30
+#define N_OPS_LIST_BIG_L_VALID      40
+#define N_OPS_LIST_BIG_L_INVALID    20
+#define N_OPS_LIST_BIG_Q_VALID      20
+#define N_OPS_LIST_BIG_Q_INVALID    10
+
+#define N_OPS_LIST \
+    (N_OPS_LIST_LITTLE_B_VALID   + \
+     N_OPS_LIST_LITTLE_B_INVALID + \
+     N_OPS_LIST_LITTLE_W_VALID   + \
+     N_OPS_LIST_LITTLE_W_INVALID + \
+     N_OPS_LIST_LITTLE_L_VALID   + \
+     N_OPS_LIST_LITTLE_L_INVALID + \
+     N_OPS_LIST_LITTLE_Q_VALID   + \
+     N_OPS_LIST_LITTLE_Q_INVALID + \
+     N_OPS_LIST_BIG_B_VALID      + \
+     N_OPS_LIST_BIG_B_INVALID    + \
+     N_OPS_LIST_BIG_W_VALID      + \
+     N_OPS_LIST_BIG_W_INVALID    + \
+     N_OPS_LIST_BIG_L_VALID      + \
+     N_OPS_LIST_BIG_L_INVALID    + \
+     N_OPS_LIST_BIG_Q_VALID      + \
+     N_OPS_LIST_BIG_Q_INVALID)
+
+#define OFF_IDX_OPS_LIST_LITTLE_B_VALID \
+    (0)
+#define OFF_IDX_OPS_LIST_LITTLE_B_INVALID \
+    (OFF_IDX_OPS_LIST_LITTLE_B_VALID + N_OPS_LIST_LITTLE_B_VALID)
+#define OFF_IDX_OPS_LIST_LITTLE_W_VALID \
+    (OFF_IDX_OPS_LIST_LITTLE_B_INVALID + N_OPS_LIST_LITTLE_B_INVALID)
+#define OFF_IDX_OPS_LIST_LITTLE_W_INVALID \
+    (OFF_IDX_OPS_LIST_LITTLE_W_VALID + N_OPS_LIST_LITTLE_W_VALID)
+#define OFF_IDX_OPS_LIST_LITTLE_L_VALID \
+    (OFF_IDX_OPS_LIST_LITTLE_W_INVALID + N_OPS_LIST_LITTLE_W_INVALID)
+#define OFF_IDX_OPS_LIST_LITTLE_L_INVALID \
+    (OFF_IDX_OPS_LIST_LITTLE_L_VALID + N_OPS_LIST_LITTLE_L_VALID)
+#define OFF_IDX_OPS_LIST_LITTLE_Q_VALID \
+    (OFF_IDX_OPS_LIST_LITTLE_L_INVALID + N_OPS_LIST_LITTLE_L_INVALID)
+#define OFF_IDX_OPS_LIST_LITTLE_Q_INVALID \
+    (OFF_IDX_OPS_LIST_LITTLE_Q_VALID + N_OPS_LIST_LITTLE_Q_VALID)
+#define OFF_IDX_OPS_LIST_BIG_B_VALID \
+    (OFF_IDX_OPS_LIST_LITTLE_Q_INVALID + N_OPS_LIST_LITTLE_Q_INVALID)
+#define OFF_IDX_OPS_LIST_BIG_B_INVALID \
+    (OFF_IDX_OPS_LIST_BIG_B_VALID + N_OPS_LIST_BIG_B_VALID)
+#define OFF_IDX_OPS_LIST_BIG_W_VALID \
+    (OFF_IDX_OPS_LIST_BIG_B_INVALID + N_OPS_LIST_BIG_B_INVALID)
+#define OFF_IDX_OPS_LIST_BIG_W_INVALID \
+    (OFF_IDX_OPS_LIST_BIG_W_VALID + N_OPS_LIST_BIG_W_VALID)
+#define OFF_IDX_OPS_LIST_BIG_L_VALID \
+    (OFF_IDX_OPS_LIST_BIG_W_INVALID + N_OPS_LIST_BIG_W_INVALID)
+#define OFF_IDX_OPS_LIST_BIG_L_INVALID \
+    (OFF_IDX_OPS_LIST_BIG_L_VALID + N_OPS_LIST_BIG_L_VALID)
+#define OFF_IDX_OPS_LIST_BIG_Q_VALID \
+    (OFF_IDX_OPS_LIST_BIG_L_INVALID + N_OPS_LIST_BIG_L_INVALID)
+#define OFF_IDX_OPS_LIST_BIG_Q_INVALID \
+    (OFF_IDX_OPS_LIST_BIG_Q_VALID + N_OPS_LIST_BIG_Q_VALID)
+
+typedef uint8_t MrData[MEMACCESS_TESTDEV_REGION_SIZE];
+#define MEMACCESS_TESTDEV_MR_DATA_SIZE (sizeof(MrData) * N_OPS_LIST)
+
+typedef DeviceClass MemAccessTestDevClass;
+typedef struct MemAccessTestDev {
+    /* Private */
+    DeviceState parent_obj;
+    /* Public */
+    MemoryRegion container;
+    MemoryRegion memory_regions[N_OPS_LIST]; /* test memory regions */
+    uint64_t base;                           /* map base address */
+    MrData *mr_data;                         /* memory region data array */
+} MemAccessTestDev;
+
+#define MEM_ACCESS_TEST_DEV(obj)                                    \
+    OBJECT_CHECK(MemAccessTestDev, obj, TYPE_MEM_ACCESS_TEST_DEV)
+
+#endif
-- 
2.25.1


