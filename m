Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 87A84C47DDF
	for <qemu-devel@archiver.kernel.org>; Wed, 24 Jan 2024 12:17:49 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rScC3-0007fv-31; Wed, 24 Jan 2024 07:17:24 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <vadim.shakirov@syntacore.com>)
 id 1rScBu-0007fT-Jl; Wed, 24 Jan 2024 07:17:17 -0500
Received: from mta-04.yadro.com ([89.207.88.248])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <vadim.shakirov@syntacore.com>)
 id 1rScBs-00022S-J6; Wed, 24 Jan 2024 07:17:14 -0500
DKIM-Filter: OpenDKIM Filter v2.11.0 mta-04.yadro.com E9D59C0002
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=syntacore.com;
 s=mta-04; t=1706098627;
 bh=ASux4KlJHtWR7c1zy0HzR6e4UEPp0SFvfTsiW9xejbc=;
 h=From:To:Subject:Date:Message-ID:MIME-Version:Content-Type:From;
 b=tmyLSnGMNWtae9kSERUZu/azWe9vujP0OYXlolMudld0xUmDih5LDcwiOKtwFy7WU
 rvHDmt+9X4B1UJM5ygWyfZPNOR8DznngyNR2ZAFMIagaPfS8qBe2amckHSRoPcO0II
 LrVjIOdn/9q2eWVZ9qByXZ5ECERWEtSJVrwdAeyed5X9e35VaMfFNJpvRTppRnxasD
 MjaMuYG7L8iW5+agkJIWpxxRGoXq4mWI3l3yU0nvMc/Q6G1UTqfbI0k3oqkiiMQK7N
 gnFUVMVe4bPS5hTo52JV1kfFBXxtPjmtu1pyfRH0fH09ts/Xn/go/ZNPVzPVecqLAx
 6a4hMEyY03ZrQ==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=syntacore.com;
 s=mta-03; t=1706098627;
 bh=ASux4KlJHtWR7c1zy0HzR6e4UEPp0SFvfTsiW9xejbc=;
 h=From:To:Subject:Date:Message-ID:MIME-Version:Content-Type:From;
 b=GRxI0Ws2a2XvYAqRjJigUAQtf6MrZ/dLNgOFUB/a5kLtBqlMaJsLGWHWg6vCEZQgw
 txxMhQuF3Jqjd6MfM/Jr/YDQO7s99gHMTwZdA4IpIOtb0djr+2vjwquMKse2K33ITm
 l4MrQ0gRdX51trrPXSVKVDuA3xgbResF1+v7HzypthC8MoxDS9MvIS/ue1l2DJY/u9
 13EJwIGpeueBFtEI7DB6YpgZgLEKxHb8wLxNl/NNmeIKcG7FoIeFhGVS0WxiDe9uIA
 mMQrxjW0evj+7fwBe1ZOPphDfivcJp246euiFq2BLR4PCJr/DgbaZFMW+zzgli/pLF
 Dd/VOq0OMVMOw==
From: Vadim Shakirov <vadim.shakirov@syntacore.com>
To: <qemu-devel@nongnu.org>
CC: Vadim Shakirov <vadim.shakirov@syntacore.com>, Palmer Dabbelt
 <palmer@dabbelt.com>, Alistair Francis <alistair.francis@wdc.com>, Bin Meng
 <bin.meng@windriver.com>, Weiwei Li <liwei1518@gmail.com>, "Daniel Henrique
 Barboza" <dbarboza@ventanamicro.com>, Liu Zhiwei
 <zhiwei_liu@linux.alibaba.com>, <qemu-riscv@nongnu.org>
Subject: [PATCH] target/riscv/csr: Added the ability to delegate LCOFI to VS
Date: Wed, 24 Jan 2024 15:16:07 +0300
Message-ID: <20240124121607.698469-1-vadim.shakirov@syntacore.com>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: T-EXCH-08.corp.yadro.com (172.17.11.58) To
 S-Exch-01.corp.yadro.com (10.78.5.241)
Received-SPF: permerror client-ip=89.207.88.248;
 envelope-from=vadim.shakirov@syntacore.com; helo=mta-04.yadro.com
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

In the AIA specification in the paragraph "Virtual interrupts for VS level"
it is indicated for interrupts 13-63: if the bit in hideleg is enabled,
then the corresponding vsip and vsie bits are aliases to sip and sie

Signed-off-by: Vadim Shakirov <vadim.shakirov@syntacore.com>
---
 target/riscv/csr.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/target/riscv/csr.c b/target/riscv/csr.c
index 1ddc03ff39..ec55be3c45 100644
--- a/target/riscv/csr.c
+++ b/target/riscv/csr.c
@@ -1133,7 +1133,7 @@ static RISCVException write_stimecmph(CPURISCVState *env, int csrno,
 static const uint64_t delegable_ints =
     S_MODE_INTERRUPTS | VS_MODE_INTERRUPTS | MIP_LCOFIP;
 static const uint64_t vs_delegable_ints =
-    (VS_MODE_INTERRUPTS | LOCAL_INTERRUPTS) & ~MIP_LCOFIP;
+    VS_MODE_INTERRUPTS | LOCAL_INTERRUPTS;
 static const uint64_t all_ints = M_MODE_INTERRUPTS | S_MODE_INTERRUPTS |
                                      HS_MODE_INTERRUPTS | LOCAL_INTERRUPTS;
 #define DELEGABLE_EXCPS ((1ULL << (RISCV_EXCP_INST_ADDR_MIS)) | \
-- 
2.34.1


