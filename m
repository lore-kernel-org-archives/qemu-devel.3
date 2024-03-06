Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A3761C5475B
	for <qemu-devel@archiver.kernel.org>; Wed,  6 Mar 2024 13:03:52 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rhqvk-00019c-Fu; Wed, 06 Mar 2024 08:03:32 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <eric.huang@linux.alibaba.com>)
 id 1rhnZG-0004dB-2u; Wed, 06 Mar 2024 04:28:06 -0500
Received: from out30-119.freemail.mail.aliyun.com ([115.124.30.119])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <eric.huang@linux.alibaba.com>)
 id 1rhnZC-0006OM-34; Wed, 06 Mar 2024 04:28:05 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linux.alibaba.com; s=default;
 t=1709717278; h=From:To:Subject:Date:Message-ID:MIME-Version;
 bh=dxArenT2bes2ADR+Tb1jbQotfGOHruOhNtqSb92CP8A=;
 b=B1UgZL4RniIyh/RDYcm5dVuJOIXc+s9e2hBQM/GRCU85itJkWHQULXomrSO0/OtEaTVoF/7Q6HGqKFpWtsyB0RY9clwU2i89jcPVDjuJtmiwriXKXSRgsHyXSAAw3eU+Kp4jicm0pdYewdcFcDrTLpqrXxAtHyocNOL5GdCDNho=
X-Alimail-AntiSpam: AC=PASS; BC=-1|-1; BR=01201311R371e4; CH=green; DM=||false|;
 DS=||; FP=0|-1|-1|-1|0|-1|-1|-1; HT=ay29a033018045192;
 MF=eric.huang@linux.alibaba.com; NM=1; PH=DS; RN=9; SR=0;
 TI=SMTPD_---0W1x7LCo_1709716969; 
Received: from localhost.localdomain(mailfrom:eric.huang@linux.alibaba.com
 fp:SMTPD_---0W1x7LCo_1709716969) by smtp.aliyun-inc.com;
 Wed, 06 Mar 2024 17:22:51 +0800
From: Huang Tao <eric.huang@linux.alibaba.com>
To: qemu-devel@nongnu.org
Cc: qemu-riscv@nongnu.org, zhiwei_liu@linux.alibaba.com,
 dbarboza@ventanamicro.com, liwei1518@gmail.com, bin.meng@windriver.com,
 alistair.francis@wdc.com, palmer@dabbelt.com,
 Huang Tao <eric.huang@linux.alibaba.com>
Subject: [PATCH 4/4] target/riscv: Delete the former element agnostic function
Date: Wed,  6 Mar 2024 17:20:12 +0800
Message-ID: <20240306092013.21231-5-eric.huang@linux.alibaba.com>
X-Mailer: git-send-email 2.41.0
In-Reply-To: <20240306092013.21231-1-eric.huang@linux.alibaba.com>
References: <20240306092013.21231-1-eric.huang@linux.alibaba.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=115.124.30.119;
 envelope-from=eric.huang@linux.alibaba.com;
 helo=out30-119.freemail.mail.aliyun.com
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

Delete vext_set_elems_1s_le.

Signed-off-by: Huang Tao <eric.huang@linux.alibaba.com>
---
 target/riscv/vector_internals.c | 13 -------------
 target/riscv/vector_internals.h |  2 --
 2 files changed, 15 deletions(-)

diff --git a/target/riscv/vector_internals.c b/target/riscv/vector_internals.c
index 0166e81e02..4f24bd8516 100644
--- a/target/riscv/vector_internals.c
+++ b/target/riscv/vector_internals.c
@@ -73,19 +73,6 @@ void vext_set_elems_1s(void *vd, uint32_t is_agnostic, uint32_t esz,
 }
 #endif
 
-void vext_set_elems_1s_le(void *base, uint32_t is_agnostic, uint32_t cnt,
-                       uint32_t tot)
-{
-    if (is_agnostic == 0) {
-        /* policy undisturbed */
-        return;
-    }
-    if (tot - cnt == 0) {
-        return ;
-    }
-    memset(base + cnt, -1, tot - cnt);
-}
-
 void do_vext_vv(void *vd, void *v0, void *vs1, void *vs2,
                 CPURISCVState *env, uint32_t desc,
                 opivv2_fn *fn, uint32_t esz)
diff --git a/target/riscv/vector_internals.h b/target/riscv/vector_internals.h
index de7d2681e6..45168d4cfc 100644
--- a/target/riscv/vector_internals.h
+++ b/target/riscv/vector_internals.h
@@ -116,8 +116,6 @@ static inline uint32_t vext_get_total_elems(CPURISCVState *env, uint32_t desc,
 /* set agnostic elements to 1s */
 void vext_set_elems_1s(void *vd, uint32_t is_agnostic, uint32_t esz,
                        uint32_t idx, uint32_t tot);
-void vext_set_elems_1s_le(void *base, uint32_t is_agnostic, uint32_t cnt,
-                       uint32_t tot);
 
 /* expand macro args before macro */
 #define RVVCALL(macro, ...)  macro(__VA_ARGS__)
-- 
2.41.0


