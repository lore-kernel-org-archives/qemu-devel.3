Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 25960606A33D
	for <qemu-devel@archiver.kernel.org>; Thu,  5 Nov 2026 13:24:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=xen0n.name header.i=@xen0n.name header.a=rsa-sha256 header.s=mail header.b=TTNOywXj
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xOxRa-0001wh-Dk; Thu, 05 Nov 2026 08:23:54 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <i.qemu@xen0n.name>)
 id 1xOusK-0007wa-AL; Thu, 05 Nov 2026 05:39:21 -0500
Received: from [115.28.160.31] (helo=mailbox.box.xen0n.name)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <i.qemu@xen0n.name>)
 id 1xOusH-0005I6-47; Thu, 05 Nov 2026 05:39:20 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=xen0n.name; s=mail;
 t=1793874567; bh=bRlGEqYHq49dJCph1FkFiiqLa3Il2BqZi7vY6wcMXfY=;
 h=From:To:Cc:Subject:Date:From;
 b=TTNOywXjrbi0wAIZ61WTqajIuj+Y6SiLELjmQpgsfZIYI7w6h2Yp10vXzFHcss0xB
 c6s9aq6YOqTbSrVdGYy/jnNCsbFog6ku4HwSZpaq7l3mLvhOoO0BIUH8KRY9xcsbxb
 2eN65zDUWnhpsefWTRGIrdjTiZTImOtqcjY2P/e8=
Received: from ld50.lan (unknown [IPv6:240e:b8f:9520:b00:4d15:c490:17a1:b378])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mailbox.box.xen0n.name (Postfix) with ESMTPSA id B47E060075;
 Thu,  5 Nov 2026 18:29:26 +0800 (CST)
From: WANG Xuerui <i.qemu@xen0n.name>
To: qemu-devel@nongnu.org
Cc: WANG Xuerui <git@xen0n.name>, qemu-stable@nongnu.org,
 Richard Henderson <richard.henderson@linaro.org>
Subject: [PATCH] host/include/loongarch64: Fix build with 128-bit LL/SC enabled
Date: Thu,  5 Nov 2026 18:29:24 +0800
Message-ID: <20261105102924.1309687-1-i.qemu@xen0n.name>
X-Mailer: git-send-email 2.55.0
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Host-Lookup-Failed: Reverse DNS lookup failed for 115.28.160.31 (deferred)
Received-SPF: pass client-ip=115.28.160.31; envelope-from=i.qemu@xen0n.name;
 helo=mailbox.box.xen0n.name
X-Spam_score_int: -12
X-Spam_score: -1.3
X-Spam_bar: -
X-Spam_report: (-1.3 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, RDNS_NONE=0.793,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001 autolearn=no autolearn_force=no
X-Spam_action: no action
X-Mailman-Approved-At: Thu, 05 Nov 2026 08:23:50 -0500
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
X-Spam-Status: No, score=-23.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_CR_TRAILER,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SPF_HELO_PASS,SPF_PASS,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

From: WANG Xuerui <git@xen0n.name>

LoongArch64 v1.1 has native 128-bit LL/SC capability through the
`sc.q` instruction, and [GCC uses it since 16.1.0][1]. So for
`-march=la64v1.1` (and equivalents such as `-march=la664` or just
`-mscq`) configurations the following happens:

- `CONFIG_ATOMIC128` is set,
- in `host/include/generic/host/atomic128-cas.h.inc`, `HAVE_CMPXCHG128`
  is set to `1`,
- in `accel/tcg/ldst_atomicity.c.inc`, code paths invoking
  `store_atom_insert_al16` are enabled,
- this errors out because of the explicit
  `host/include/loongarch64/host/store-insert-al16.h.inc` override.

This doesn't affect `-march=la64v1.0` builds because the `atomic128`
probe, when code-generated without `sc.q` support, correctly fails to
link without libatomic.

Simply removing the override is enough to make QEMU build and run
correctly on `sc.q`-enabled hosts. The override was introduced in 2023,
in commit adc8467e697d ("host/include/loongarch64: Add atomic16 load
and store"), when it was true that no existing LoongArch implementation
could perform 128-bit LL/SC nor CAS at that time. It is no longer the
case since LA664 with LoongArch64 v1.1.

[1]: https://github.com/gcc-mirror/gcc/blob/releases/gcc-16.1.0/gcc/config/loongarch/sync.md#L784

Cc: qemu-stable@nongnu.org
Cc: Richard Henderson <richard.henderson@linaro.org>
Fixes: adc8467e697d ("host/include/loongarch64: Add atomic16 load and store")
Resolves: https://gitlab.com/qemu-project/qemu/-/work_items/4767
Signed-off-by: WANG Xuerui <git@xen0n.name>
---
 .../include/loongarch64/host/store-insert-al16.h.inc | 12 ------------
 1 file changed, 12 deletions(-)
 delete mode 100644 host/include/loongarch64/host/store-insert-al16.h.inc

diff --git a/host/include/loongarch64/host/store-insert-al16.h.inc b/host/include/loongarch64/host/store-insert-al16.h.inc
deleted file mode 100644
index 919fd8d74404..000000000000
--- a/host/include/loongarch64/host/store-insert-al16.h.inc
+++ /dev/null
@@ -1,12 +0,0 @@
-/*
- * SPDX-License-Identifier: GPL-2.0-or-later
- * Atomic store insert into 128-bit, LoongArch version.
- */
-
-#ifndef LOONGARCH_STORE_INSERT_AL16_H
-#define LOONGARCH_STORE_INSERT_AL16_H
-
-void store_atom_insert_al16(Int128 *ps, Int128 val, Int128 msk)
-    QEMU_ERROR("unsupported atomic");
-
-#endif /* LOONGARCH_STORE_INSERT_AL16_H */
-- 
2.55.0


