Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0A1FB606A31C
	for <qemu-devel@archiver.kernel.org>; Tue, 17 Nov 2026 01:26:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=zte.com.cn header.i=@zte.com.cn header.a=rsa-sha256 header.s=z202610 header.b=hU5xRjIl
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xT7xR-00056O-5l; Mon, 16 Nov 2026 20:26:01 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <wang.yechao255@zte.com.cn>)
 id 1xT7xO-00055z-2D; Mon, 16 Nov 2026 20:25:59 -0500
Received: from mxhk.zte.com.cn ([160.30.148.35])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <wang.yechao255@zte.com.cn>)
 id 1xT7xL-0005wN-QU; Mon, 16 Nov 2026 20:25:57 -0500
Received: from mse-fl1.zte.com.cn (unknown [10.5.228.132])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange x25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mxhk.zte.com.cn (FangMail) with ESMTPS id 4jT6Vv2wRSz8Xs71;
 Tue, 17 Nov 2026 09:25:43 +0800 (CST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=zte.com.cn;
 s=z202610; t=1794878743;
 bh=k4CFCRrN+4mmzDaJnqK/ns1dS+JpRGwAke6xjXdJPas=;
 h=From:To:Cc:Subject:Date;
 b=hU5xRjIluT0JUpv+62vJLi/GgSAfQqx7nkD17kL7fIewYhiaXTHNksNVBrzs7cBlU
 DIgtDBlxP0VA2VxQUsbNuP0+T5DcZ4E9h2E6ChIydwiovC4TL/tpAIkAUflXBkaaP9
 tX+YHQBijnhyMUGmrBO5AQr2B4Mi+HYEZyDltJmeaPCDXDr20bNVtREUulPd2V6bCs
 s/cnbeBKgCqiohEVG7qSFd606qkjHEDcnuQFXe59bfxqBHuFGSoCKvTWlkLsj9Ce9h
 b3m17L18kdlF35poFqQQIstv2zDPZAwDa60uDedw+mN6F4GRbiIs/8Qy+AZqy/u/m4
 UgbDNbs16lzaA==
Received: from szxl2zmapp07.zte.com.cn ([10.1.32.52])
 by mse-fl1.zte.com.cn with SMTP id 6AH1PcRf098403;
 Tue, 17 Nov 2026 09:25:38 +0800 (+08)
 (envelope-from wang.yechao255@zte.com.cn)
Received: from localhost.localdomain (unknown [10.234.74.162])
 by smtp (Zmail) with SMTP; Tue, 17 Nov 2026 09:25:39 +0800
X-Zmail-TransId: 3e816afbad1202e-2399e
X-Zmail-LocalSMTP: 1
X-ZMAIL-USEORIGINALEMLTOOUTBOUND: 1
X-Zmail-RealSender: wang.yechao255@zte.com.cn
From: Wang Yechao <wang.yechao255@zte.com.cn>
To: Palmer Dabbelt <palmer@dabbelt.com>,
 Alistair Francis <alistair.francis@wdc.com>
Cc: Weiwei Li <liwei1518@gmail.com>,
 Daniel Henrique Barboza <daniel.barboza@oss.qualcomm.com>,
 Liu Zhiwei <zhiwei_liu@linux.alibaba.com>,
 Chao Liu <chao.liu@processmission.com>, qemu-riscv@nongnu.org,
 qemu-devel@nongnu.org, Wang Yechao <wang.yechao255@zte.com.cn>,
 Nutty Liu <nutty.liu@hotmail.com>
Subject: [PATCH] target/riscv: Only save vmstate_debug when TCG is enabled
Date: Tue, 17 Nov 2026 09:21:57 +0800
Message-ID: <20261117012204.3591024-1-wang.yechao255@zte.com.cn>
X-Mailer: git-send-email 2.41.0
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8bit
X-MAIL: mse-fl1.zte.com.cn 6AH1PcRf098403
X-TLS: YES
X-ENVELOPE-SENDER: wang.yechao255@zte.com.cn
X-SOURCE-IP: 10.5.228.132 unknown Tue, 17 Nov 2026 09:25:43 +0800
X-CLEAN: YES
X-Fangmail-Anti-Spam-Filtered: true
X-Fangmail-MID-QID: 6AFBAD17.000/4jT6Vv2wRSz8Xs71
Received-SPF: pass client-ip=160.30.148.35;
 envelope-from=wang.yechao255@zte.com.cn; helo=mxhk.zte.com.cn
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_MSPIKE_H5=0.001, RCVD_IN_MSPIKE_WL=0.001, SPF_HELO_NONE=0.001,
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
X-Spam-Status: No, score=-18.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_CR_TRAILER,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_PASS,
	SPF_PASS,USER_AGENT_GIT autolearn=unavailable autolearn_force=no
	version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

Commit d45b9bc65515 ("target/riscv: move TCG only files to tcg subdir")
moved the TCG-only files into the tcg/ subdirectory, so env->tdataX is
now only allocated and valid when TCG is enabled.

However, cfg.debug is always true in riscv_cpu_properties, so
debug_needed() unconditionally returned true and the debug vmstate
subsection was always considered needed. On --disable-tcg builds the
corresponding fields are uninitialized, and attempting to save them
triggers an assertion failure in vmstate_save_state_v:

  qemu-system-riscv64: ../migration/vmstate.c:727:
  vmstate_save_state_v: Assertion `first_elem || !n_elems || !size' failed.

Fix this by making debug_needed() also require tcg_enabled(), so the
debug subsection is only saved when the TCG-only state actually exists.

Fixes: d45b9bc65515 ("target/riscv: move TCG only files to tcg subdir")
Signed-off-by: Wang Yechao <wang.yechao255@zte.com.cn>
Reviewed-by: Daniel Henrique Barboza <daniel.barboza@oss.qualcomm.com>
Reviewed-by: Nutty Liu <nutty.liu@hotmail.com>
---
 target/riscv/machine.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/target/riscv/machine.c b/target/riscv/machine.c
index 0de06e9588..c5f0261ba7 100644
--- a/target/riscv/machine.c
+++ b/target/riscv/machine.c
@@ -324,7 +324,7 @@ static bool debug_needed(void *opaque)
 {
     RISCVCPU *cpu = opaque;
 
-    return cpu->cfg.debug || cpu->cfg.ext_sdtrig;
+    return tcg_enabled() && (cpu->cfg.debug || cpu->cfg.ext_sdtrig);
 }
 
 static bool sdext_needed(void *opaque)
-- 
2.27.0


