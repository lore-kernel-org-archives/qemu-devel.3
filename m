Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 80822D5E368
	for <qemu-devel@archiver.kernel.org>; Sat,  9 Nov 2024 12:32:50 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1t9kRw-000301-90; Sat, 09 Nov 2024 07:20:20 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mjt@tls.msk.ru>)
 id 1t9kQM-0008Fj-ND; Sat, 09 Nov 2024 07:18:43 -0500
Received: from isrv.corpit.ru ([86.62.121.231])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mjt@tls.msk.ru>)
 id 1t9kQJ-0005MN-8d; Sat, 09 Nov 2024 07:18:40 -0500
Received: from tsrv.corpit.ru (tsrv.tls.msk.ru [192.168.177.2])
 by isrv.corpit.ru (Postfix) with ESMTP id F225DA164E;
 Sat,  9 Nov 2024 15:08:08 +0300 (MSK)
Received: from tls.msk.ru (mjt.wg.tls.msk.ru [192.168.177.130])
 by tsrv.corpit.ru (Postfix) with SMTP id B8973167FD4;
 Sat,  9 Nov 2024 15:09:03 +0300 (MSK)
Received: (nullmailer pid 3296238 invoked by uid 1000);
 Sat, 09 Nov 2024 12:09:01 -0000
From: Michael Tokarev <mjt@tls.msk.ru>
To: qemu-devel@nongnu.org
Cc: qemu-stable@nongnu.org, Anton Blanchard <antonb@tenstorrent.com>,
 Daniel Henrique Barboza <dbarboza@ventanamicro.com>,
 Alistair Francis <alistair.francis@wdc.com>, Michael Tokarev <mjt@tls.msk.ru>
Subject: [Stable-9.1.2 36/58] target/riscv: Fix vcompress with rvv_ta_all_1s
Date: Sat,  9 Nov 2024 15:08:37 +0300
Message-Id: <20241109120901.3295995-36-mjt@tls.msk.ru>
X-Mailer: git-send-email 2.39.5
In-Reply-To: <qemu-stable-9.1.2-20241109150812@cover.tls.msk.ru>
References: <qemu-stable-9.1.2-20241109150812@cover.tls.msk.ru>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=86.62.121.231; envelope-from=mjt@tls.msk.ru;
 helo=isrv.corpit.ru
X-Spam_score_int: -68
X-Spam_score: -6.9
X-Spam_bar: ------
X-Spam_report: (-6.9 / 5.0 requ) BAYES_00=-1.9, RCVD_IN_DNSWL_HI=-5,
 RCVD_IN_VALIDITY_CERTIFIED_BLOCKED=0.001, RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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

From: Anton Blanchard <antonb@tenstorrent.com>

vcompress packs vl or less fields into vd, so the tail starts after the
last packed field. This could be more clearly expressed in the ISA,
but for now this thread helps to explain it:

https://github.com/riscv/riscv-v-spec/issues/796

Signed-off-by: Anton Blanchard <antonb@tenstorrent.com>
Reviewed-by: Daniel Henrique Barboza <dbarboza@ventanamicro.com>
Reviewed-by: Alistair Francis <alistair.francis@wdc.com>
Message-ID: <20241030043538.939712-1-antonb@tenstorrent.com>
Signed-off-by: Alistair Francis <alistair.francis@wdc.com>
(cherry picked from commit c128d39edeff337220fc536a3e935bcba01ecb49)
Signed-off-by: Michael Tokarev <mjt@tls.msk.ru>

diff --git a/target/riscv/vector_helper.c b/target/riscv/vector_helper.c
index 10a52ceb5b..f32b1f86ee 100644
--- a/target/riscv/vector_helper.c
+++ b/target/riscv/vector_helper.c
@@ -5130,7 +5130,7 @@ void HELPER(NAME)(void *vd, void *v0, void *vs1, void *vs2,               \
     }                                                                     \
     env->vstart = 0;                                                      \
     /* set tail elements to 1s */                                         \
-    vext_set_elems_1s(vd, vta, vl * esz, total_elems * esz);              \
+    vext_set_elems_1s(vd, vta, num * esz, total_elems * esz);             \
 }
 
 /* Compress into vd elements of vs2 where vs1 is enabled */
-- 
2.39.5


