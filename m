Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 17F23606A31A
	for <qemu-devel@archiver.kernel.org>; Fri, 23 Oct 2026 09:29:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=cdac.in header.i=@cdac.in header.a=rsa-sha256 header.s=default header.b=ffcHIcZk
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xKBZj-00068E-Gz; Fri, 23 Oct 2026 05:28:36 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <karthika.b@cdac.in>)
 id 1xKBZe-00067K-Mh; Fri, 23 Oct 2026 05:28:30 -0400
Received: from mailsender.cdac.in ([196.1.113.117]
 helo=mailsender-core1.pune.cdac.in)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <karthika.b@cdac.in>)
 id 1xKBZc-0007AW-Fc; Fri, 23 Oct 2026 05:28:30 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=cdac.in; s=default;
 t=1792747678; bh=6p1ZPvxgt6Pe8BYrvR1sD+sWOwQK1H7YfUsziQ2iPoE=;
 h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
 b=ffcHIcZkCgqzXZW4zZm/grhmHQ4vhkD+A4HvgLyfJD8MCUvap6nndUDNotBkNOMtK
 T8bac3kcCbdaumPFNOkevaNHbuYxO8bovYV/mNIzEiBoY8hqALZbNTvtcISIYrq+ci
 CNC3z84v6FugcxaOvxjAhAN/1h3pBH/FMcmsVHBQ=
Received: from mscr-int.pune.cdac.in (mscr-int.pune.cdac.in [10.208.193.2])
 by mailsender.cdac.in (8.15.2/8.15.2/Debian-22ubuntu3) with ESMTP id
 69N9Rug91831907; Fri, 23 Oct 2026 14:57:56 +0530
Received: from mailgw-cip.pune.cdac.in (mscr-haproxy.pune.cdac.in
 [10.208.193.46])
 by mscr-int.pune.cdac.in (Postfix) with ESMTP id 72E7E100565B5;
 Fri, 23 Oct 2026 14:57:46 +0530 (IST)
X-Auth: karthika.b@cdac.in
Received: from hdg164.tvm.cdac.in (hd_hdg164.tvm.cdac.in [10.176.18.107])
 (Authenticated sender: karthika.b@cdac.in)
 by mailgw-cip.pune.cdac.in (Postfix) with ESMTPSA id EF57014E2709;
 Fri, 23 Oct 2026 14:57:45 +0530 (IST)
From: Karthika B <karthika.b@cdac.in>
To: qemu-devel@nongnu.org
Cc: qemu-riscv@nongnu.org, alistair@alistair23.me, sreenadh@cdac.in,
 raokk@cdac.in, Karthika B <karthika.b@cdac.in>,
 Palmer Dabbelt <palmer@dabbelt.com>,
 Alistair Francis <alistair.francis@wdc.com>,
 Weiwei Li <liwei1518@gmail.com>,
 Daniel Henrique Barboza <daniel.barboza@oss.qualcomm.com>,
 Liu Zhiwei <zhiwei_liu@linux.alibaba.com>,
 Chao Liu <chao.liu.zevorn@gmail.com>
Subject: [PATCH 1/3] target/riscv: Fix VEGA32/VEGA64 PMP inheritance from
 vendor CPU class
Date: Fri, 23 Oct 2026 14:57:25 +0530
Message-ID: <20261023092727.41197-1-karthika.b@cdac.in>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <2071795723.301996.1792747114406@webmail2.cdac.in>
References: <2071795723.301996.1792747114406@webmail2.cdac.in>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CDAC-PUNE-MailScanner-Information: Please contact the ISP for more
 information
X-CDAC-PUNE-MailScanner-ID: 72E7E100565B5.A170D
X-CDAC-PUNE-MailScanner: Found to be clean
X-CDAC-PUNE-MailScanner-SpamCheck: not spam, SpamAssassin (not cached,
 score=-2.9, required 6, autolearn=not spam, ALL_TRUSTED -1.00,
 BAYES_00 -1.90)
X-CDAC-PUNE-MailScanner-From: karthika.b@cdac.in
Received-SPF: pass client-ip=196.1.113.117; envelope-from=karthika.b@cdac.in;
 helo=mailsender-core1.pune.cdac.in
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, SPF_HELO_NONE=0.001,
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

Signed-off-by: Karthika B <karthika.b@cdac.in>
---
 target/riscv/cpu.c | 6 ++++--
 1 file changed, 4 insertions(+), 2 deletions(-)

diff --git a/target/riscv/cpu.c b/target/riscv/cpu.c
index 7b96b7b670..adfa0581c3 100644
--- a/target/riscv/cpu.c
+++ b/target/riscv/cpu.c
@@ -2989,7 +2989,7 @@ static const TypeInfo riscv_cpu_type_infos[] = {
 
 
 #if defined(TARGET_RISCV32)
-    DEFINE_RISCV_CPU(TYPE_RISCV_CPU_VEGA32, TYPE_RISCV_CPU_SIFIVE_U,
+    DEFINE_RISCV_CPU(TYPE_RISCV_CPU_VEGA32, TYPE_RISCV_CPU,
         .misa_mxl_max = MXL_RV32,
         .misa_ext = RVI | RVM | RVA | RVS | RVU,
         .priv_spec = PRIV_VERSION_LATEST,
@@ -2997,6 +2997,7 @@ static const TypeInfo riscv_cpu_type_infos[] = {
         .cfg.max_satp_mode = VM_1_10_SV32,
         .cfg.ext_zicsr = true,
         .cfg.ext_zifencei = true,
+        .cfg.mmu = true,
         .cfg.pmp = false,
     ),
 #endif
@@ -3046,7 +3047,7 @@ static const TypeInfo riscv_cpu_type_infos[] = {
         .misa_mxl_max = MXL_RV64,
     ),
 
-    DEFINE_RISCV_CPU(TYPE_RISCV_CPU_VEGA64, TYPE_RISCV_CPU_SIFIVE_U,
+    DEFINE_RISCV_CPU(TYPE_RISCV_CPU_VEGA64, TYPE_RISCV_CPU,
         .misa_mxl_max = MXL_RV64,
         .misa_ext = RVI | RVM | RVA | RVS | RVU,
         .priv_spec = PRIV_VERSION_LATEST,
@@ -3054,6 +3055,7 @@ static const TypeInfo riscv_cpu_type_infos[] = {
         .cfg.max_satp_mode = VM_1_10_SV39,
         .cfg.ext_zicsr = true,
         .cfg.ext_zifencei = true,
+        .cfg.mmu = true,
         .cfg.pmp = false,
     ),
 
-- 
2.43.0


------------------------------------------------------------------------------------------------------------
[ C-DAC is on Social-Media too. Kindly follow us at:
Facebook: https://www.facebook.com/CDACINDIA & Twitter: @cdacindia ]

This e-mail is for the sole use of the intended recipient(s) and may
contain confidential and privileged information. If you are not the
intended recipient, please contact the sender by reply e-mail and destroy
all copies and the original message. Any unauthorized review, use,
disclosure, dissemination, forwarding, printing or copying of this email
is strictly prohibited and appropriate legal action will be taken.
------------------------------------------------------------------------------------------------------------


