Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id EAAF7C43458
	for <qemu-devel@archiver.kernel.org>; Wed,  1 Jul 2026 23:13:25 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wf46j-0007M3-VH; Wed, 01 Jul 2026 19:12:42 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <heinrich.schuchardt@canonical.com>)
 id 1wf46f-0007Lk-1w; Wed, 01 Jul 2026 19:12:37 -0400
Received: from smtp-relay-canonical-1.canonical.com ([185.125.188.121])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <heinrich.schuchardt@canonical.com>)
 id 1wf46a-0002om-4X; Wed, 01 Jul 2026 19:12:34 -0400
Received: from LT03 (dynamic-176-006-032-233.176.6.pool.telefonica.de
 [176.6.32.233])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by smtp-relay-canonical-1.canonical.com (Postfix) with ESMTPSA id A611F3FB67; 
 Wed,  1 Jul 2026 23:12:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=canonical.com;
 s=20251003; t=1782947548;
 bh=pQiV7QFsH5IL5HF4ZxFPnm4TYVzNnK8BHu15WkJigdg=;
 h=From:To:Cc:Subject:Date:Message-ID:MIME-Version;
 b=VoRz8JkWfABvAr0pkJVQ7Wve4anx2HzrlYffZ5fmcj6EIPcBEQUsKVKMa7kGiPgjc
 vtM5BVlxIa9A9YVu4rLGmVh/zFNBqYlFivIemUHi5GRjjJZAaaOcuQbRy5RiAewPJQ
 MeK2hqwK4sjoKmADCtxpYAJX+oAZMN+AHLaq8gX0bdWiWykCBnceq9HDzmXpAyQirJ
 cSEuw7DfHmVt7NyPW2YAN+1UgdF2A/hK7ttL970SZ1RGcE5C8HFjTh2HsEgO7kBkL0
 6AZkIsXWVIH6tzdvLyjvKZ/kKoN7gvq8MB0DUhcdqsw+e4rTtLSdLA/sX4842dFFk0
 SVhb1LkNJ/sQWPxC+nEiSjr8tlbtxMhMlv0Sy6I1wZMnDAY5Kl9tJz7iV3Dz80RESD
 npf1XOCQKywVA/yL0EXye4x6ihpdTT6uTD1+zdWh81I8veppZyzjKlxkrWF9ZEcjmL
 CQEmO5m1+PqGnrQoYhr3ux/u0b9CbdgtANF85wQZuOZLWGCFhvFhhYtb+4/RPPK0OJ
 4pi5dJB1mcuaLKr8Kqvrj62XnvmB3Z2/wHT8veqy4dLh5AsPHSuBb0Xz4VNIpqR7Hn
 DwPL7ETUf7HxO+5Ckr4Dnwribt1Niz8VBO2GziwO2byk3ncMQ95QEn2VdrjtvxZwCE
 7gU2cwAz+uREK/BZHuE2tncM=
From: Heinrich Schuchardt <heinrich.schuchardt@canonical.com>
To: Peter Maydell <peter.maydell@linaro.org>
Cc: qemu-arm@nongnu.org, qemu-devel@nongnu.org,
 Heinrich Schuchardt <heinrich.schuchardt@canonical.com>
Subject: [PATCH 1/1] hw/arm/virt: define initial aarch64 TCG CPU
Date: Thu,  2 Jul 2026 01:12:24 +0200
Message-ID: <20260701231224.106850-1-heinrich.schuchardt@canonical.com>
X-Mailer: git-send-email 2.53.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=185.125.188.121;
 envelope-from=heinrich.schuchardt@canonical.com;
 helo=smtp-relay-canonical-1.canonical.com
X-Spam_score_int: -47
X-Spam_score: -4.8
X-Spam_bar: ----
X-Spam_report: (-4.8 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.445,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_MED=-2.3, SPF_HELO_NONE=0.001,
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

Function virt_get_default_cpu_type() is meant to return the default CPU
type. But for aarch64 TCG it returns cortex-a15 which is a 32-bit CPU.
This results in failures to boot if no specific CPU is required by
the command line.

Return neoverse-v1 as default aarch64 TCG CPU. This is the aarch64 CPU
with richest feature set.

Signed-off-by: Heinrich Schuchardt <heinrich.schuchardt@canonical.com>
---
 hw/arm/virt.c | 8 ++++++--
 1 file changed, 6 insertions(+), 2 deletions(-)

diff --git a/hw/arm/virt.c b/hw/arm/virt.c
index d8d27f2ef6..61cf260a5c 100644
--- a/hw/arm/virt.c
+++ b/hw/arm/virt.c
@@ -4074,8 +4074,12 @@ static bool get_kernel_irqchip_default(const MachineState *ms)
 
 static const char *virt_get_default_cpu_type(const MachineState *ms)
 {
-    return tcg_enabled() ? ARM_CPU_TYPE_NAME("cortex-a15")
-                         : ARM_CPU_TYPE_NAME("max");
+    if (tcg_enabled()) {
+        return target_aarch64() ? ARM_CPU_TYPE_NAME("neoverse-v1")
+                                : ARM_CPU_TYPE_NAME("cortex-a15");
+    } else {
+        return ARM_CPU_TYPE_NAME("max");
+    }
 }
 
 static GPtrArray *virt_get_valid_cpu_types(const MachineState *ms)
-- 
2.53.0


