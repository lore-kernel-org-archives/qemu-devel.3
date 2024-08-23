Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 785B3C531DC
	for <qemu-devel@archiver.kernel.org>; Fri, 23 Aug 2024 06:39:49 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1shNwX-0001mg-FJ; Fri, 23 Aug 2024 02:38:41 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <vladimir.isaev@syntacore.com>)
 id 1shNwT-0001lb-BW; Fri, 23 Aug 2024 02:38:37 -0400
Received: from mta-04.yadro.com ([89.207.88.248])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <vladimir.isaev@syntacore.com>)
 id 1shNwQ-0007K8-Fz; Fri, 23 Aug 2024 02:38:36 -0400
DKIM-Filter: OpenDKIM Filter v2.11.0 mta-04.yadro.com 5C8B6C0004
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=syntacore.com;
 s=mta-04; t=1724395107;
 bh=c62We7L953Ej4LOAyqiC5U72CjEbzq0XBNJOrjd0lzE=;
 h=From:To:Subject:Date:Message-ID:MIME-Version:Content-Type:From;
 b=zr9lxo4ix5zWQSW3Zinh1r5qLAJr9FABTWawLsB5gqMuZBfGqolJt5yQyrqzXBXYY
 H6iih68yrK7IE7We0rX3+0fNJ3rT68Dh9W6rVbXaCrl9vAzJaOjQdT40X9kwrNiGrZ
 wO9zwiW3m6xtZlUUCQM/WleN+uDgz0K0lwoqIeE4LtbeI7+CWqMso4k/WGJ6f7widp
 j4D4q1k/nsearzV3C8xys88vu8EkS2T2b8Vfa/QczzZ/8gfq8dUiaJ26XiTknn5kFw
 THT7gTD5uCoJrcuN4tS7jO5Tz793pgAfLVlqfGeTqeO0f5J/2k0roiXofNKuctO5YG
 Ts06g3j5HxwOw==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=syntacore.com;
 s=mta-03; t=1724395107;
 bh=c62We7L953Ej4LOAyqiC5U72CjEbzq0XBNJOrjd0lzE=;
 h=From:To:Subject:Date:Message-ID:MIME-Version:Content-Type:From;
 b=IkPZZdtMW1HnSkcrQeira/ln3pFE5xzkQbgWpDM0kMloxt7IwLFNjAGxrMYaj9QPx
 Ts41kfnBUCvR19bSzaMA0hhDRW9b8waaTsJeKxJuV7VGNVGxnvZ1SLnZ2bRwzE0XPI
 DpN07WusenbGUIGmtstYD5gxLgsuk7GBXJJhPBHIZISO52w0tQKfEsXPLcQwkyJ8c+
 P3849oqJE89o1OojiWm3sRWoPg1V63Uoe/pWAK0xEvgOiQfA0MIivwC1u2zaPS8obC
 /9mszgF66Be67mOol0p8sXxEQaD6Gz0Jxv4pyt5vOd32+ap+cu4z5Xm//I9xLI5Wo5
 lltQ0WIJPZX0g==
From: Vladimir Isaev <vladimir.isaev@syntacore.com>
To: <qemu-devel@nongnu.org>
CC: <qemu-riscv@nongnu.org>, <zhiwei_liu@linux.alibaba.com>,
 <dbarboza@ventanamicro.com>, <liwei1518@gmail.com>, <bin.meng@windriver.com>, 
 <alistair.francis@wdc.com>, <palmer@dabbelt.com>, Vladimir Isaev
 <vladimir.isaev@syntacore.com>
Subject: [PATCH] target/riscv: fix za64rs enabling
Date: Fri, 23 Aug 2024 09:34:31 +0300
Message-ID: <20240823063431.17474-1-vladimir.isaev@syntacore.com>
X-Mailer: git-send-email 2.45.2
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: T-EXCH-07.corp.yadro.com (172.17.11.57) To
 S-Exch-01.corp.yadro.com (10.78.5.241)
Received-SPF: permerror client-ip=89.207.88.248;
 envelope-from=vladimir.isaev@syntacore.com; helo=mta-04.yadro.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_VALIDITY_CERTIFIED_BLOCKED=0.001, RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001,
 SPF_HELO_NONE=0.001, T_SCC_BODY_TEXT_LINE=-0.01,
 T_SPF_PERMERROR=0.01 autolearn=ham autolearn_force=no
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

za64rs requires priv 1.12 when enabled by priv 1.11.

This fixes annoying warning:
warning: disabling za64rs extension for hart 0x00000000 because privilege spec version does not match

on priv 1.11 CPUs.

Fixes: 68c9e54beae8 ("target/riscv: do not enable all named features by default")
Signed-off-by: Vladimir Isaev <vladimir.isaev@syntacore.com>
---
 target/riscv/cpu.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/target/riscv/cpu.c b/target/riscv/cpu.c
index a90808a3bace..07a7af59b6d9 100644
--- a/target/riscv/cpu.c
+++ b/target/riscv/cpu.c
@@ -115,7 +115,7 @@ const RISCVIsaExtData isa_edata_arr[] = {
     ISA_EXT_DATA_ENTRY(zihpm, PRIV_VERSION_1_12_0, ext_zihpm),
     ISA_EXT_DATA_ENTRY(zimop, PRIV_VERSION_1_13_0, ext_zimop),
     ISA_EXT_DATA_ENTRY(zmmul, PRIV_VERSION_1_12_0, ext_zmmul),
-    ISA_EXT_DATA_ENTRY(za64rs, PRIV_VERSION_1_12_0, has_priv_1_11),
+    ISA_EXT_DATA_ENTRY(za64rs, PRIV_VERSION_1_12_0, has_priv_1_12),
     ISA_EXT_DATA_ENTRY(zaamo, PRIV_VERSION_1_12_0, ext_zaamo),
     ISA_EXT_DATA_ENTRY(zabha, PRIV_VERSION_1_13_0, ext_zabha),
     ISA_EXT_DATA_ENTRY(zacas, PRIV_VERSION_1_12_0, ext_zacas),
-- 
2.45.2


