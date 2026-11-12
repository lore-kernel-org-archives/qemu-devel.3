Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 27D5F606A31C
	for <qemu-devel@archiver.kernel.org>; Thu, 12 Nov 2026 21:48:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=proton.me header.i=@proton.me header.a=rsa-sha256 header.s=protonmail2 header.b=dtAtHkQo
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xRces-0001ff-6o; Thu, 12 Nov 2026 16:48:38 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <christianslima@proton.me>)
 id 1xRcem-0001eL-EH
 for qemu-devel@nongnu.org; Thu, 12 Nov 2026 16:48:32 -0500
Received: from mail-10631.protonmail.ch ([79.135.106.31])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <christianslima@proton.me>)
 id 1xRcek-0006ur-Pi
 for qemu-devel@nongnu.org; Thu, 12 Nov 2026 16:48:32 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=proton.me;
 s=protonmail2; t=1794520106; x=1794779306;
 bh=sQmY9xuTJpqp6aWv3skdQ7t26iMTkbBIpzk3uzeTRoY=;
 h=Date:To:From:Subject:Message-ID:In-Reply-To:References:
 Feedback-ID:From:To:Cc:Date:Subject:Reply-To:Feedback-ID:
 Message-ID:BIMI-Selector;
 b=dtAtHkQoD0jsdOa38YGnN+lBARwPcKRN7gqbO8hYNpBlavNK22yB//JkkfcLHuPXM
 f4YCCdn3sTrq6QXiRtF6R3n55TUviejfBOeMYn5dFrB7MEji6Q9BDn9jMROnTYKcCR
 82dMKqVvuO//FIpjmhFBHdM1aaNmN8xkpzNpvrN7qBCPYmZyO6fvFfJ31n/pGeBUcn
 bcDECsOWrPRA0pHQvO5tY/g4hlqHIEr73q36bLHqJnJMhtTqFIZgk7JTPwTqICA+a5
 0G16sL6h5o60fgGTfgW0Zf0dZdkLgANeFWhYNjmZSBOnuKn2HjVYlXRRlk00jtG/in
 ekEQZC+j53kDA==
Date: Thu, 12 Nov 2026 21:48:23 +0000
To: Palmer Dabbelt <palmer@dabbelt.com>,
 Alistair Francis <alistair.francis@wdc.com>, Weiwei Li <liwei1518@gmail.com>,
 Daniel Henrique Barboza <daniel.barboza@oss.qualcomm.com>,
 Liu Zhiwei <zhiwei_liu@linux.alibaba.com>,
 Chao Liu <chao.liu@processmission.com>, qemu-riscv@nongnu.org,
 qemu-devel@nongnu.org
From: "Christian S. Lima" <christianslima@proton.me>
Subject: [PATCH 1/1] target/riscv: make mstatus.SPELP read-only when S-mode is
 not present
Message-ID: <20261112214810.78747-2-christianslima@proton.me>
In-Reply-To: <20261112214810.78747-1-christianslima@proton.me>
References: <20261112214810.78747-1-christianslima@proton.me>
Feedback-ID: 169431447:user:proton
X-Pm-Message-ID: 1df95b567d1137241b1acfafdf897a6aa3010365
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=79.135.106.31;
 envelope-from=christianslima@proton.me; helo=mail-10631.protonmail.ch
X-Spam_score_int: -27
X-Spam_score: -2.8
X-Spam_bar: --
X-Spam_report: (-2.8 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_LOW=-0.7, SPF_HELO_PASS=-0.001,
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
X-Spam-Status: No, score=-20.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_CR_TRAILER,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SPF_HELO_PASS,SPF_PASS autolearn=ham
	autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

According to the Zicfilp specification the bit SPELP in the mstatus
register should be 0 (read-only) when s-mode is not present.

Resolves: https://gitlab.com/qemu-project/qemu/-/work_items/4456#note_41816=
30619

Signed-off-by: Christian S. Lima <christianslima@proton.me>
---
 target/riscv/tcg/csr.c | 5 ++++-
 1 file changed, 4 insertions(+), 1 deletion(-)

diff --git a/target/riscv/tcg/csr.c b/target/riscv/tcg/csr.c
index af444e3e6f..340c61a1c4 100644
--- a/target/riscv/tcg/csr.c
+++ b/target/riscv/tcg/csr.c
@@ -2124,7 +2124,10 @@ static RISCVException write_mstatus(CPURISCVState *e=
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



