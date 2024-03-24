Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5C834C47DD9
	for <qemu-devel@archiver.kernel.org>; Sun, 24 Mar 2024 15:11:15 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1roPUe-00034z-Q5; Sun, 24 Mar 2024 11:10:43 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <irina.ryapolova@syntacore.com>)
 id 1roPUT-00031M-9Y; Sun, 24 Mar 2024 11:10:29 -0400
Received: from mta-04.yadro.com ([89.207.88.248])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <irina.ryapolova@syntacore.com>)
 id 1roPUI-0003xJ-Al; Sun, 24 Mar 2024 11:10:28 -0400
DKIM-Filter: OpenDKIM Filter v2.11.0 mta-04.yadro.com AFEC8C0003
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=syntacore.com;
 s=mta-04; t=1711293016;
 bh=6INlj23kPf1y3+Wyq31ki6nFc0ejvl17wG7d0KvVfuM=;
 h=From:To:Subject:Date:Message-ID:MIME-Version:Content-Type:From;
 b=rMQMU9T/EePcUdUzzBVunNWzSd/DeS6eehk5KKWHJ50YxpEJSZWq1XD4gqyZ0qlXu
 MctU+P7n+JWJtQWDNy3NQHq7lOXQY6YRo/MOz0n2EbjiD0W9dFXxLOy8HsxeCqvJNo
 Ng8Rq2XkhzGyCksE2F1aEkK1RewcNMWaionuwuXsndbnt0ck+q+gL7tOjHIvdp3p64
 YuAgFYDVWBfOZcsXd9gKEexu6ZvXwKU814JBTTofzdvMaQ8rK8VNXo1z/xZyDXVtcC
 KYrsSibGNy9GEoLSWbpYmLvHPEEfvaEQoAmb/DG+LNCXZ/wzN4yPY48YE8In+VuwbA
 GInVF7vlsYRdw==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=syntacore.com;
 s=mta-03; t=1711293016;
 bh=6INlj23kPf1y3+Wyq31ki6nFc0ejvl17wG7d0KvVfuM=;
 h=From:To:Subject:Date:Message-ID:MIME-Version:Content-Type:From;
 b=d89akmun3AxnL4IbTFa44Emub4uDlssJNf/FtemQ4rO+xI+qepvUGI5/jmbd1WI5M
 X6StjioaED7K56ogZ84h0vJid9teAYLmm1KHIm8/dCXkppmTsu58d/I/ZvuGFtt3Ve
 xkXAb6IUASOicw1GPpNObL+CKJST8VxTwrzCndFZqqWAtUYn1Xl9OSNif1HLdxf7ak
 lPl/otdD6Srk3YXmn9oiAJ65R9KNXRflYw4s/Qwjbqmx6Tgc1/eD36sKeTNwK6z5wk
 nitxxbdIB2aYMGE0dso7Ja6hQi7k6jhy7qpphiJL9HJwBblypvczfvIDXihIMjq+Rv
 EhizRQizjuIsA==
From: Irina Ryapolova <irina.ryapolova@syntacore.com>
To: <qemu-devel@nongnu.org>
CC: <qemu-riscv@nongnu.org>, <palmer@dabbelt.com>, <alistair.francis@wdc.com>, 
 <bin.meng@windriver.com>, <liwei1518@gmail.com>,
 <dbarboza@ventanamicro.com>, 
 <zhiwei_liu@linux.alibaba.com>, Vadim Shakirov <vadim.shakirov@syntacore.com>
Subject: [PATCH v3 2/2] target/riscv/csr: Added the ability to delegate LCOFI
 to VS
Date: Sun, 24 Mar 2024 18:09:49 +0300
Message-ID: <20240324150949.20822-3-irina.ryapolova@syntacore.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20240324150949.20822-1-irina.ryapolova@syntacore.com>
References: <20240324150949.20822-1-irina.ryapolova@syntacore.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: T-EXCH-08.corp.yadro.com (172.17.11.58) To
 S-Exch-01.corp.yadro.com (10.78.5.241)
Received-SPF: permerror client-ip=89.207.88.248;
 envelope-from=irina.ryapolova@syntacore.com; helo=mta-04.yadro.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, SPF_HELO_NONE=0.001,
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
index 4c2cbcd59f..38548a01d9 100644
--- a/target/riscv/csr.c
+++ b/target/riscv/csr.c
@@ -1150,7 +1150,7 @@ static RISCVException write_stimecmph(CPURISCVState *env, int csrno,
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


