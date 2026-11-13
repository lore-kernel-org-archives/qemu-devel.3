Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B3408606A339
	for <qemu-devel@archiver.kernel.org>; Fri, 13 Nov 2026 21:37:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=proton.me header.i=@proton.me header.a=rsa-sha256 header.s=vyg3g755szaqdmrpc7zn5wvky4.protonmail2 header.b=dT83HwiN
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xRywT-00023P-Ha; Fri, 13 Nov 2026 16:36:17 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <christianslima@proton.me>)
 id 1xRywQ-00022U-TS
 for qemu-devel@nongnu.org; Fri, 13 Nov 2026 16:36:15 -0500
Received: from mail-4316.protonmail.ch ([185.70.43.16])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <christianslima@proton.me>)
 id 1xRywP-0001gl-Ah
 for qemu-devel@nongnu.org; Fri, 13 Nov 2026 16:36:14 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=proton.me;
 s=vyg3g755szaqdmrpc7zn5wvky4.protonmail2; t=1794605771;
 x=1794864971; bh=4twaEbuV8CPr/dd0Mz0UYalpDQ5OlRJbLeeZ8eB9/6Y=;
 h=Date:To:From:Subject:Message-ID:In-Reply-To:References:
 Feedback-ID:From:To:Cc:Date:Subject:Reply-To:Feedback-ID:
 Message-ID:BIMI-Selector;
 b=dT83HwiNtr7dRarblwklr0I+L6G1dyyjGh8J9LPOlq9sJIp325GNaK4R4IbFhybkp
 vk8HfLPBU91l/YkMR7nKCzU0HwDze9iTDASDRYnKSP1h56BDB+Ma6R3CAv6V86IaAs
 Q0El0+qohP2fFc78UTo88huCpXBM6ZfO14JHrb0d6ij/6BTlYoqVMruBkRpEWCysfR
 gbrapTSpnJjLpNhUP5zXBPgM5gGjwaTtLT5UwUd5+e/3TAg4U4BLYMrWnJ5qA1AxW5
 LDoChywl0o9LJViTpq2ZwtRuCy7ZOZZSbOHKpKqUvSBrB8EyqtD42ScDiPFgALr/bO
 FLjHvIAqL8CFQ==
Date: Fri, 13 Nov 2026 21:36:05 +0000
To: Palmer Dabbelt <palmer@dabbelt.com>,
 Alistair Francis <alistair.francis@wdc.com>, Weiwei Li <liwei1518@gmail.com>,
 Daniel Henrique Barboza <daniel.barboza@oss.qualcomm.com>,
 Liu Zhiwei <zhiwei_liu@linux.alibaba.com>,
 Chao Liu <chao.liu@processmission.com>, qemu-riscv@nongnu.org,
 qemu-devel@nongnu.org
From: "Christian S. Lima" <christianslima@proton.me>
Subject: [PATCH v2] target/riscv: make mstatus.SPELP read-only when S-mode is
 not present
Message-ID: <20261113213542.37925-3-christianslima@proton.me>
In-Reply-To: <20261113213542.37925-1-christianslima@proton.me>
References: <20261113213542.37925-1-christianslima@proton.me>
Feedback-ID: 169431447:user:proton
X-Pm-Message-ID: 16f2c4eaea74362ef53a31735455d2cc0b80c6ce
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=185.70.43.16;
 envelope-from=christianslima@proton.me; helo=mail-4316.protonmail.ch
X-Spam_score_int: -27
X-Spam_score: -2.8
X-Spam_bar: --
X-Spam_report: (-2.8 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_LOW=-0.7, RCVD_IN_MSPIKE_H5=0.001, RCVD_IN_MSPIKE_WL=0.001,
 SPF_HELO_PASS=-0.001, SPF_PASS=-0.001 autolearn=unavailable autolearn_force=no
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
X-Spam-Status: No, score=-20.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_CR_TRAILER,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SPF_HELO_PASS,SPF_PASS autolearn=unavailable
	autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

According to the Zicfilp specification the bit SPELP in the mstatus
register should be 0 (read-only) when s-mode is not present.

changes in v2:
- Change to patch series
- Now tooling can close the issue in Gitlab properly

Link to v1: https://lore.kernel.org/qemu-riscv/20261112214810.78747-2-chris=
tianslima@proton.me/

Resolves: https://gitlab.com/qemu-project/qemu/-/work_items/4456

Signed-off-by: Christian S. Lima <christianslima@proton.me>
---
 target/riscv/tcg/csr.c | 5 ++++-
 1 file changed, 4 insertions(+), 1 deletion(-)

diff --git a/target/riscv/tcg/csr.c b/target/riscv/tcg/csr.c
index 398e312c9a..9d0378bc69 100644
--- a/target/riscv/tcg/csr.c
+++ b/target/riscv/tcg/csr.c
@@ -2131,7 +2131,10 @@ static RISCVException write_mstatus(CPURISCVState *e=
nv, int csrno,
=20
     /* If cfi lp extension is available, then apply cfi lp mask */
     if (env_archcpu(env)->cfg.ext_zicfilp) {
-        mask |=3D (MSTATUS_MPELP | MSTATUS_SPELP);
+        mask |=3D MSTATUS_MPELP;
+        if (riscv_has_ext(env, RVS)) {
+            mask |=3D MSTATUS_SPELP;
+        }
     }
=20
     mstatus =3D (mstatus & ~mask) | (val & mask);
--=20
2.56.0



