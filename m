Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3C801C54E41
	for <qemu-devel@archiver.kernel.org>; Wed,  6 Mar 2024 13:03:53 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rhqvb-000182-VZ; Wed, 06 Mar 2024 08:03:24 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <eric.huang@linux.alibaba.com>)
 id 1rhnYE-0004T5-5T; Wed, 06 Mar 2024 04:27:02 -0500
Received: from out30-101.freemail.mail.aliyun.com ([115.124.30.101])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <eric.huang@linux.alibaba.com>)
 id 1rhnYA-0006G1-4B; Wed, 06 Mar 2024 04:27:00 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linux.alibaba.com; s=default;
 t=1709717214; h=From:To:Subject:Date:Message-ID:MIME-Version;
 bh=SAG2jil2xka/v1ZxkE69o9VK2553YYWXxOikTfvBeOA=;
 b=bLfjxnhl9F55DCrp3vxZl1Lg8TztLl7pe+f1q0xcK2VDt/bpfumkJ7aPUW6rFguJhx1qe7Bs1qN1YYdkAPzQi1dqYuKOQWKtyNhXUSceZp+cLPamQGvlmD7L46CBQ8idbA3wXnUZc/i6pG5RCcY/JIiyMVS9QDlurlBewiAl8XQ=
X-Alimail-AntiSpam: AC=PASS; BC=-1|-1; BR=01201311R201e4; CH=green; DM=||false|;
 DS=||; FP=0|-1|-1|-1|0|-1|-1|-1; HT=ay29a033018045176;
 MF=eric.huang@linux.alibaba.com; NM=1; PH=DS; RN=9; SR=0;
 TI=SMTPD_---0W1wzaUs_1709716906; 
Received: from localhost.localdomain(mailfrom:eric.huang@linux.alibaba.com
 fp:SMTPD_---0W1wzaUs_1709716906) by smtp.aliyun-inc.com;
 Wed, 06 Mar 2024 17:21:47 +0800
From: Huang Tao <eric.huang@linux.alibaba.com>
To: qemu-devel@nongnu.org
Cc: qemu-riscv@nongnu.org, zhiwei_liu@linux.alibaba.com,
 dbarboza@ventanamicro.com, liwei1518@gmail.com, bin.meng@windriver.com,
 alistair.francis@wdc.com, palmer@dabbelt.com,
 Huang Tao <eric.huang@linux.alibaba.com>
Subject: [PATCH 2/4] target/riscv: Add right functions to set agnostic elements
Date: Wed,  6 Mar 2024 17:20:10 +0800
Message-ID: <20240306092013.21231-3-eric.huang@linux.alibaba.com>
X-Mailer: git-send-email 2.41.0
In-Reply-To: <20240306092013.21231-1-eric.huang@linux.alibaba.com>
References: <20240306092013.21231-1-eric.huang@linux.alibaba.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=115.124.30.101;
 envelope-from=eric.huang@linux.alibaba.com;
 helo=out30-101.freemail.mail.aliyun.com
X-Spam_score_int: -174
X-Spam_score: -17.5
X-Spam_bar: -----------------
X-Spam_report: (-17.5 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, ENV_AND_HDR_SPF_MATCH=-0.5,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
 T_SCC_BODY_TEXT_LINE=-0.01, UNPARSEABLE_RELAY=0.001, USER_IN_DEF_DKIM_WL=-7.5,
 USER_IN_DEF_SPF_WL=-7.5 autolearn=ham autolearn_force=no
X-Spam_action: no action
X-Mailman-Approved-At: Wed, 06 Mar 2024 08:03:17 -0500
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

We add vext_set_elems_1s to set agnostic elements to 1s in both big
and little endian situation.
In the function vext_set_elems_1s. We using esz argument to get the first
element to set. 'cnt' is just idx * esz.

Signed-off-by: Huang Tao <eric.huang@linux.alibaba.com>
---
 target/riscv/vector_internals.c | 53 +++++++++++++++++++++++++++++++++
 target/riscv/vector_internals.h |  2 ++
 2 files changed, 55 insertions(+)

diff --git a/target/riscv/vector_internals.c b/target/riscv/vector_internals.c
index 349b24f4ae..455be96996 100644
--- a/target/riscv/vector_internals.c
+++ b/target/riscv/vector_internals.c
@@ -20,6 +20,59 @@
 #include "vector_internals.h"
 
 /* set agnostic elements to 1s */
+#if HOST_BIG_ENDIAN
+void vext_set_elems_1s(void *vd, uint32_t is_agnostic, uint32_t esz,
+                       uint32_t idx, uint32_t tot)
+{
+    if (is_agnostic == 0) {
+        /* policy undisturbed */
+        return;
+    }
+    void *base = NULL;
+    switch (esz) {
+    case 1:
+        base = ((int8_t *)vd + H1(idx));
+    break;
+    case 2:
+        base = ((int16_t *)vd + H2(idx));
+    break;
+    case 4:
+        base = ((int32_t *)vd + H4(idx));
+    break;
+    case 8:
+        base = ((int64_t *)vd + H8(idx));
+    break;
+    default:
+        g_assert_not_reached();
+    break;
+    }
+    /*
+     * spilt the elements into 2 parts
+     * part_begin: the memory need to be set in the first uint64_t unit
+     * part_allign: the memory need to be set begins from next uint64_t
+     *              unit and alligned to 8
+     */
+    uint32_t cnt = idx * esz;
+    int part_begin, part_allign;
+    part_begin = MIN(tot - cnt, 8 - (cnt % 8));
+    part_allign = ((tot - cnt - part_begin) / 8) * 8;
+
+    memset(base - part_begin + 1, -1, part_begin);
+    memset(QEMU_ALIGN_PTR_UP(base, 8), -1, part_allign);
+}
+#else
+void vext_set_elems_1s(void *vd, uint32_t is_agnostic, uint32_t esz,
+                       uint32_t idx, uint32_t tot)
+{
+    if (is_agnostic == 0) {
+        /* policy undisturbed */
+        return;
+    }
+    uint32_t cnt = idx * esz;
+    memset(vd + cnt, -1, tot - cnt);
+}
+#endif
+
 void vext_set_elems_1s_le(void *base, uint32_t is_agnostic, uint32_t cnt,
                        uint32_t tot)
 {
diff --git a/target/riscv/vector_internals.h b/target/riscv/vector_internals.h
index fa599f60ca..c96e52f926 100644
--- a/target/riscv/vector_internals.h
+++ b/target/riscv/vector_internals.h
@@ -114,6 +114,8 @@ static inline uint32_t vext_get_total_elems(CPURISCVState *env, uint32_t desc,
 }
 
 /* set agnostic elements to 1s */
+void vext_set_elems_1s(void *vd, uint32_t is_agnostic, uint32_t esz,
+                       uint32_t idx, uint32_t tot);
 void vext_set_elems_1s_le(void *base, uint32_t is_agnostic, uint32_t cnt,
                        uint32_t tot);
 
-- 
2.41.0


