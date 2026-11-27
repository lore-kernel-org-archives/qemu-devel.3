Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8F524606A330
	for <qemu-devel@archiver.kernel.org>; Fri, 27 Nov 2026 06:13:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=tls.msk.ru header.i=@tls.msk.ru header.a=rsa-sha256 header.s=202602 header.b=Q5kBfViK
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xWp9C-0003JS-K5; Fri, 27 Nov 2026 01:09:26 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mjt@tls.msk.ru>)
 id 1xWp8p-0000Yk-Hc; Fri, 27 Nov 2026 01:09:03 -0500
Received: from isrv.corpit.ru ([212.248.84.144])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mjt@tls.msk.ru>)
 id 1xWp8n-00021m-Hx; Fri, 27 Nov 2026 01:09:03 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=tls.msk.ru; s=202602;
 t=1795759048; bh=/vpU7EDR4R3d/tDH8vxrZRD/2kiPKXa2S+V7kPOO1uE=;
 h=From:To:Cc:Subject:Date:In-Reply-To:References;
 b=Q5kBfViKSQ1SiphONf9kH7XIpmhh+jDoP4/Gag1Nybv6TkqYl9vMMG5Okk2++r+IZ
 J4eofML63WJ4HY8PK3GtRpI3eds+Mq5FK5jsbtfuf5gCCR8ZUK+1JQw7Klx20q+orn
 O1YiJvRbPx3xsSVawjgArzRp12a4Oej39S14ZwNcLFpsYvTfrT7kSQMhkHcNxai1op
 wYplompLXp6B43w4TU6yMHD9qj0QuEnz96s9MX9vA5KtGJJelGupRhCJkREwSDAgu7
 XGBEKYXaOJ3E1bjxNwhtWtBv8nX7BPJuwvYzgBU42HXMZ6ULQ0aSSedcvj/iJcG5/7
 uEd4+7Xp5A3/Q==
Received: from tsrv.corpit.ru (tsrv.tls.msk.ru [192.168.177.2])
 by isrv.corpit.ru (Postfix) with ESMTP id 57A181EA373;
 Fri, 27 Nov 2026 08:57:28 +0300 (MSK)
Received: from gandalf.tls.msk.ru (mjt.wg.tls.msk.ru [192.168.177.130])
 by tsrv.corpit.ru (Postfix) with ESMTP id 5528446999E;
 Fri, 27 Nov 2026 08:57:28 +0300 (MSK)
Received: by gandalf.tls.msk.ru (Postfix, from userid 1000)
 id 28A9DCF334; Fri, 27 Nov 2026 08:57:28 +0300 (MSK)
From: Michael Tokarev <mjt@tls.msk.ru>
To: qemu-devel@nongnu.org
Cc: qemu-stable@nongnu.org, WANG Xuerui <git@xen0n.name>,
 Richard Henderson <richard.henderson@linaro.org>,
 Michael Tokarev <mjt@tls.msk.ru>
Subject: [Stable-11.1.4 v2 129/152] host/include/loongarch64: Fix build with
 128-bit LL/SC enabled
Date: Fri, 27 Nov 2026 08:54:27 +0300
Message-ID: <20261127055709.39630-66-mjt@tls.msk.ru>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <qemu-stable-11.1.4-20261127085309@cover.tls.msk.ru>
References: <qemu-stable-11.1.4-20261127085309@cover.tls.msk.ru>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=212.248.84.144; envelope-from=mjt@tls.msk.ru;
 helo=isrv.corpit.ru
X-Spam_score_int: -19
X-Spam_score: -2.0
X-Spam_bar: --
X-Spam_report: (-2.0 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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
Fixes: adc8467e697d ("host/include/loongarch64: Add atomic16 load and store")
Resolves: https://gitlab.com/qemu-project/qemu/-/work_items/4767
Signed-off-by: WANG Xuerui <git@xen0n.name>
Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
Message-ID: <20261105102924.1309687-1-i.qemu@xen0n.name>
(cherry picked from commit 8f18c59c018eff94b6465f73f5cd76a49ee3d6ec)
Signed-off-by: Michael Tokarev <mjt@tls.msk.ru>

diff --git a/host/include/loongarch64/host/store-insert-al16.h.inc b/host/include/loongarch64/host/store-insert-al16.h.inc
deleted file mode 100644
index 919fd8d7440..00000000000
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
2.47.3


