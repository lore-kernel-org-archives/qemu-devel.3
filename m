Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 703FDC6FD1F
	for <qemu-devel@archiver.kernel.org>; Wed, 20 Mar 2024 16:43:53 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rmz2E-0005S0-O8; Wed, 20 Mar 2024 12:43:26 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <irina.ryapolova@syntacore.com>)
 id 1rmz29-0005RM-Km; Wed, 20 Mar 2024 12:43:21 -0400
Received: from mta-04.yadro.com ([89.207.88.248])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <irina.ryapolova@syntacore.com>)
 id 1rmz25-0000BP-0i; Wed, 20 Mar 2024 12:43:19 -0400
DKIM-Filter: OpenDKIM Filter v2.11.0 mta-04.yadro.com 03147C0003
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=syntacore.com;
 s=mta-04; t=1710952994;
 bh=weVz+IQ/Qjl8ldpk0fDxZHKQqhnwiUhTY81/9WARAlY=;
 h=From:To:Subject:Date:Message-ID:MIME-Version:Content-Type:From;
 b=QSh/jdp9CjZRbeLZ6FT4Ufo/31cV0kYQuPgTTdgNqqoH+W8BVys8C/IkeAPaZKfLA
 JM73UfnT45myk1IqxUFmjHP5P4nqQm791ssrsf/W2ExdLGY2jT6EyPMzZgxvKw5+cg
 JKzA9x4++OFlf6mh1MUASZ46dS4KAQhpTlnmo1rRiz+JIQC+X/i42I4Yfd2XLOcrv6
 uBfv5caM6nCc97ek+SxwJl0vk2slTFh9H1x8tuBMKiupWf68sNUtodBidU5GXWIrRo
 CTVrCLtM2BWWjZE59mAnSv/5NG7sAjs09oBABJ5NnHCHv45ocm7HrJ3+7aCtiRPFDj
 GWS5oBLyWv6/Q==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=syntacore.com;
 s=mta-03; t=1710952994;
 bh=weVz+IQ/Qjl8ldpk0fDxZHKQqhnwiUhTY81/9WARAlY=;
 h=From:To:Subject:Date:Message-ID:MIME-Version:Content-Type:From;
 b=jTNUrzbNOsW+Wi99YX4znZL7ZuT1fBsu1XO0I5cspDgyRlKE9ZhFZb8PKCrH7IOUY
 NDzla5y35JB2XpcZNFrQrhFqAi2FD7eyDeaweJ3WT50np5kFeElI/Z4M8lgljojsRB
 zy2yRuo0INjF4lV6GbyY9xYyM3ajJ2VG8fKNSDquNoUrgR+ORgHLcF6w5snrXoyL0u
 kpH5YphKVVnZ439qPxDaJ6PGEG1+MWuVKGjyLcVhJsvhw3yHgHRiXnn56EW4rU5ra9
 Qk1+mcl7O15D2JzkA+MKGxz7h6f11/64kCq0sjh2r/4EdRyCDCSZdvuO+zK1w7ZXci
 mnwVCfGTkXRLw==
From: Irina Ryapolova <irina.ryapolova@syntacore.com>
To: <qemu-devel@nongnu.org>
CC: <qemu-riscv@nongnu.org>, <palmer@dabbelt.com>, <alistair.francis@wdc.com>, 
 <bin.meng@windriver.com>, <liwei1518@gmail.com>,
 <dbarboza@ventanamicro.com>, 
 <zhiwei_liu@linux.alibaba.com>, Vadim Shakirov <vadim.shakirov@syntacore.com>
Subject: [PATCH v2 2/2] target/riscv/csr: Added the ability to delegate LCOFI
 to VS
Date: Wed, 20 Mar 2024 19:42:59 +0300
Message-ID: <20240320164259.19205-2-irina.ryapolova@syntacore.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20240320164259.19205-1-irina.ryapolova@syntacore.com>
References: <20240320164259.19205-1-irina.ryapolova@syntacore.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: T-EXCH-09.corp.yadro.com (172.17.11.59) To
 S-Exch-01.corp.yadro.com (10.78.5.241)
Received-SPF: permerror client-ip=89.207.88.248;
 envelope-from=irina.ryapolova@syntacore.com; helo=mta-04.yadro.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, SPF_HELO_NONE=0.001,
 T_SCC_BODY_TEXT_LINE=-0.01,
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

From: Vadim Shakirov <vadim.shakirov@syntacore.com>

In the AIA specification in the paragraph "Virtual interrupts for VS level"
it is indicated for interrupts 13-63: if the bit in hideleg is enabled,
then the corresponding vsip and vsie bits are aliases to sip and sie

Signed-off-by: Vadim Shakirov <vadim.shakirov@syntacore.com>
Reviewed-by: Alistair Francis <alistair.francis@wdc.com>
---
 target/riscv/csr.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/target/riscv/csr.c b/target/riscv/csr.c
index 0c21145eaf..51b1099e10 100644
--- a/target/riscv/csr.c
+++ b/target/riscv/csr.c
@@ -1136,7 +1136,7 @@ static RISCVException write_stimecmph(CPURISCVState *env, int csrno,
 static const uint64_t delegable_ints =
     S_MODE_INTERRUPTS | VS_MODE_INTERRUPTS | MIP_LCOFIP;
 static const uint64_t vs_delegable_ints =
-    (VS_MODE_INTERRUPTS | LOCAL_INTERRUPTS) & ~MIP_LCOFIP;
+    VS_MODE_INTERRUPTS | LOCAL_INTERRUPTS;
 static const uint64_t all_ints = M_MODE_INTERRUPTS | S_MODE_INTERRUPTS |
                                      HS_MODE_INTERRUPTS | LOCAL_INTERRUPTS;
 #define DELEGABLE_EXCPS ((1ULL << (RISCV_EXCP_INST_ADDR_MIS)) | \
-- 
2.25.1


