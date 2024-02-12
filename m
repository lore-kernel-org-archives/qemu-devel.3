Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 40CF0C4829C
	for <qemu-devel@archiver.kernel.org>; Mon, 12 Feb 2024 17:13:59 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rZZsM-0007E4-SH; Mon, 12 Feb 2024 12:13:50 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <irina.ryapolova@syntacore.com>)
 id 1rZZsK-0007Ba-Ne; Mon, 12 Feb 2024 12:13:49 -0500
Received: from mta-04.yadro.com ([89.207.88.248])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <irina.ryapolova@syntacore.com>)
 id 1rZZsJ-0004hZ-3N; Mon, 12 Feb 2024 12:13:48 -0500
DKIM-Filter: OpenDKIM Filter v2.11.0 mta-04.yadro.com 87E0AC0005
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=syntacore.com;
 s=mta-04; t=1707758023;
 bh=p2He24Co5aJs3M9K5ZmUnK0CvHWqfjQF8RaDer3mx0Q=;
 h=From:To:Subject:Date:Message-ID:MIME-Version:Content-Type:From;
 b=iiWR9uVm9nns8737y23ZcPEjxtLkOq7tOkf/XU+hPNexc2rVvfmyZ1QaqzQS5iPki
 L2CaortPJpuwQaxr4Dd4xQsIPnSqIWOCyICnWVtsO+Jg6+ZuTlCfuxL3XSjJ3ImaRZ
 y1xEIcCgR1NIMn35zuwnUTDZ14iRakJMo6cqrfNyek64899l00cFOaHrq65M0DSMk+
 5y3Km28twXzE90jvMrAOggKXof/R816fWS2grkQ4RegNMvfpLzfem2X/6KwyxWNWjU
 etc5wLFsw6teH1NNvdFNR1lsIEViOGCUZj1gEFQNpuHn0vKLhfpr1eMLXMu22LzwDj
 gFqoKeDuOzuRA==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=syntacore.com;
 s=mta-03; t=1707758023;
 bh=p2He24Co5aJs3M9K5ZmUnK0CvHWqfjQF8RaDer3mx0Q=;
 h=From:To:Subject:Date:Message-ID:MIME-Version:Content-Type:From;
 b=xYVnmU1k2yVovZaAE2ordGjJ0A2KSvgu0DZMgQhHEWi0Ct1WMpO34AlRe77UKvPK3
 EziGfbkziNoqWQuH5qdMJAFzLPkABwuxs3FTFrhewvWe417+1AiAJYxUCqfLAajDna
 CrHdZ6JkrC6btS/ZCe1zJE39D67AYnTej8TDqrBoMk+MHgPDOlRTKOP/U6VYSb3a3G
 BJVwWw3DTOEkwm31iuO+E+IS+8MWXofO3wPrc4Ay2gd1wU86QFRHYjd6ysWLjuHVRp
 9QnnTPlulbHxPWDx7Z0DgGx2GyOoQ0vEOWxDTsx1C/xJT4+cPR0QytmD8cbR0mOknu
 kvDr3dhMxbyXQ==
From: Irina Ryapolova <irina.ryapolova@syntacore.com>
To: <qemu-devel@nongnu.org>
CC: <qemu-riscv@nongnu.org>, <palmer@dabbelt.com>, <alistair.francis@wdc.com>, 
 <bin.meng@windriver.com>, <liwei1518@gmail.com>,
 <dbarboza@ventanamicro.com>, 
 <zhiwei_liu@linux.alibaba.com>, Vadim Shakirov <vadim.shakirov@syntacore.com>
Subject: [PATCH 2/2] target/riscv/csr: Added the ability to delegate LCOFI to
 VS
Date: Mon, 12 Feb 2024 20:13:20 +0300
Message-ID: <20240212171320.47361-2-irina.ryapolova@syntacore.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20240212171320.47361-1-irina.ryapolova@syntacore.com>
References: <20240212171320.47361-1-irina.ryapolova@syntacore.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: T-Exch-05.corp.yadro.com (172.17.10.109) To
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


