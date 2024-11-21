Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D5399D743FD
	for <qemu-devel@archiver.kernel.org>; Thu, 21 Nov 2024 01:49:57 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tDwJz-0007CX-ST; Wed, 20 Nov 2024 20:49:27 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <anjo@rev.ng>) id 1tDwJu-0006lK-26
 for qemu-devel@nongnu.org; Wed, 20 Nov 2024 20:49:23 -0500
Received: from rev.ng ([94.130.142.21])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <anjo@rev.ng>) id 1tDwJs-0004sG-LI
 for qemu-devel@nongnu.org; Wed, 20 Nov 2024 20:49:21 -0500
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=rev.ng;
 s=dkim; h=Content-Transfer-Encoding:MIME-Version:References:In-Reply-To:
 Message-ID:Date:Subject:Cc:To:From:Sender:Reply-To:Content-Type:Content-ID:
 Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
 :Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:List-Subscribe:
 List-Post:List-Owner:List-Archive:List-Unsubscribe:List-Unsubscribe-Post:
 List-Help; bh=XdRCsx0NU7YzRpnmN8Uf2wu+MGo6jaBAg0CJXu+Wbdo=; b=BFLBdRLKOCSs7bd
 CMYhd3gYoIYnhuMqUd9qpJv0VYo/xlwpugtYWT1S1puC3NH5Ncaw4SvG89WBfiqaVQfrlbuGB0rag
 a+t259i7owrd72qo92c4D2U1cfmwbRMVsayOSMYgMMXGRxJotFzSXJVnvxWUMljktC/UHesQoIUmI
 a8=;
To: qemu-devel@nongnu.org
Cc: ale@rev.ng, ltaylorsimpson@gmail.com, bcain@quicinc.com,
 richard.henderson@linaro.org, philmd@linaro.org, alex.bennee@linaro.org
Subject: [RFC PATCH v1 34/43] target/hexagon: Add get_tb_mmu_index()
Date: Thu, 21 Nov 2024 02:49:38 +0100
Message-ID: <20241121014947.18666-35-anjo@rev.ng>
In-Reply-To: <20241121014947.18666-1-anjo@rev.ng>
References: <20241121014947.18666-1-anjo@rev.ng>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=94.130.142.21; envelope-from=anjo@rev.ng;
 helo=rev.ng
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
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
Reply-to:  Anton Johansson <anjo@rev.ng>
From:  Anton Johansson via <qemu-devel@nongnu.org>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org

Adds a functions to return the current mmu index given tb_flags of the
current translation block.  Required by helper-to-tcg in order to
retrieve the mmu index for memory operations without changing the
signature of helper functions.

Signed-off-by: Anton Johansson <anjo@rev.ng>
---
 target/hexagon/cpu.h | 12 ++++++++++++
 1 file changed, 12 insertions(+)

diff --git a/target/hexagon/cpu.h b/target/hexagon/cpu.h
index 764f3c38cc..7be4b5769e 100644
--- a/target/hexagon/cpu.h
+++ b/target/hexagon/cpu.h
@@ -153,6 +153,18 @@ static inline void cpu_get_tb_cpu_state(CPUHexagonState *env, vaddr *pc,
     }
 }
 
+// Returns the current mmu index given tb_flags of the current translation
+// block.  Required by helper-to-tcg in order to retrieve the mmu index for
+// memory operations without changing the signature of helper functions.
+static inline int get_tb_mmu_index(uint32_t flags)
+{
+#ifdef CONFIG_USER_ONLY
+    return MMU_USER_IDX;
+#else
+#error System mode not supported on Hexagon yet
+#endif
+}
+
 typedef HexagonCPU ArchCPU;
 
 void hexagon_translate_init(void);
-- 
2.45.2


