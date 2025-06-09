Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 501A8C61CE8
	for <qemu-devel@archiver.kernel.org>; Mon,  9 Jun 2025 13:18:55 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uOcNs-0001Qt-NR; Mon, 09 Jun 2025 09:17:52 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <srv_ts003@codethink.com>)
 id 1uOcNo-0001DY-DV; Mon, 09 Jun 2025 09:17:48 -0400
Received: from imap4.hz.codethink.co.uk ([188.40.203.114])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <srv_ts003@codethink.com>)
 id 1uOcNm-0006fp-2D; Mon, 09 Jun 2025 09:17:48 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=codethink.co.uk; s=imap4-20230908; h=Sender:Content-Transfer-Encoding:
 MIME-Version:References:In-Reply-To:Message-Id:Date:Subject:Cc:To:From:
 Reply-To:Content-Type:Content-ID:Content-Description:Resent-Date:Resent-From:
 Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:
 List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=yima1nGxODtmOyU6SbGTW9h9zw+/b2Gwa6neFo8mOxg=; b=RH9+Mqi0Lc54Rh/VCumpie8I2Z
 qHOnniUEZbxV74kRd4UVl2ion+EeNHOzh4qAgR/EETPKy42QMZZGTUXu4NG0ZxYdLH8XydtmfUdmY
 nOB8x5vN5HLMtMO8fa/LuMEv8skUaAEeEaZ3vkR9mTitPD3beVrTLH3IKh1b2UCiekfGd6WDPKx9c
 o8njoT5h1K2CGe55Gn2R0lJsR3Ma62fut8S/Begw6sMjmcrzhMXvFzN0jD/1EF7vz0PAzOL1Gdam7
 oExt0E4zX5chOKvA8x2NENdT6lq7qRnlip286aIsB2hfidI21hAhg4q6u3W4DvuFaBiSQEcd84DFk
 qqL6fGpg==;
Received: from [63.135.74.212] (helo=rainbowdash)
 by imap4.hz.codethink.co.uk with esmtpsa  (Exim 4.94.2 #2 (Debian))
 id 1uOcNZ-00BKI1-9B; Mon, 09 Jun 2025 14:17:33 +0100
Received: from ben by rainbowdash with local (Exim 4.98.2)
 (envelope-from <ben@rainbowdash>) id 1uOcNY-0000000696F-35Pa;
 Mon, 09 Jun 2025 14:17:32 +0100
From: Ben Dooks <ben.dooks@codethink.co.uk>
To: nazar.kazakov@codethink.co.uk, joseph.baker@codethink.co.uk,
 fran.redondo@codethink.co.uk, lawrence.hunter@codethink.co.uk,
 liwei1518@gmail.com, dbarboza@ventanamicro.com,
 zhiwei_liu@linux.alibaba.com, alistair.francis@wdc.com,
 qemu-riscv@nongnu.org
Cc: ben.dooks@codethink.co.uk,
	qemu-devel@nongnu.org
Subject: [PATCH v3 3/3] hw/riscv: set cva6 to use TYPE_RISCV_CPU_CVA6
Date: Mon,  9 Jun 2025 14:17:31 +0100
Message-Id: <20250609131731.1464616-4-ben.dooks@codethink.co.uk>
X-Mailer: git-send-email 2.37.2.352.g3c44437643
In-Reply-To: <20250609131731.1464616-1-ben.dooks@codethink.co.uk>
References: <20250609131731.1464616-1-ben.dooks@codethink.co.uk>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=188.40.203.114;
 envelope-from=srv_ts003@codethink.com; helo=imap4.hz.codethink.co.uk
X-Spam_score_int: -18
X-Spam_score: -1.9
X-Spam_bar: -
X-Spam_report: (-1.9 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, HEADER_FROM_DIFFERENT_DOMAINS=0.097,
 RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001, RCVD_IN_VALIDITY_SAFE_BLOCKED=0.001,
 SPF_HELO_PASS=-0.001, SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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

Change to using TYPE_RISCV_CPU_CVA6 once this is merged.

Signed-off-by: Ben Dooks <ben.dooks@codethink.co.uk>
---
 hw/riscv/cva6.c | 3 +--
 1 file changed, 1 insertion(+), 2 deletions(-)

diff --git a/hw/riscv/cva6.c b/hw/riscv/cva6.c
index 3adfa8b5cc..e6fd0ebafc 100644
--- a/hw/riscv/cva6.c
+++ b/hw/riscv/cva6.c
@@ -83,8 +83,7 @@ static void cva6_machine_class_init(ObjectClass *oc, const void *data)
     mc->init = cva6_machine_init;
     mc->max_cpus = 1;
     mc->default_ram_id = "cva6.ram";
-    /* start with "max" cpu type until we sort out CVA6 type */
-    mc->default_cpu_type = TYPE_RISCV_CPU_MAX;
+    mc->default_cpu_type = TYPE_RISCV_CPU_CVA6;
     mc->default_ram_size = cva6_memmap[CVA6_DRAM].size;
 };
 
-- 
2.37.2.352.g3c44437643


