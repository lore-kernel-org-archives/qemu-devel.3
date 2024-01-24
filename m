Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3D3B6C46CD2
	for <qemu-devel@archiver.kernel.org>; Wed, 24 Jan 2024 12:09:57 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rSc3s-0001Yd-6C; Wed, 24 Jan 2024 07:08:56 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <vadim.shakirov@syntacore.com>)
 id 1rSc3q-0001YD-0m; Wed, 24 Jan 2024 07:08:54 -0500
Received: from mta-04.yadro.com ([89.207.88.248])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <vadim.shakirov@syntacore.com>)
 id 1rSc3m-00080A-95; Wed, 24 Jan 2024 07:08:53 -0500
DKIM-Filter: OpenDKIM Filter v2.11.0 mta-04.yadro.com EE66DC0002
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=syntacore.com;
 s=mta-04; t=1706098121;
 bh=DF3tDmrsdN5mqIYobCTSS8cQ5lq44Vz72IGCEa43Yqc=;
 h=From:To:Subject:Date:Message-ID:MIME-Version:Content-Type:From;
 b=fOGiFbOpPVe5TlvqePG9SdgOpa//rlIA/nTtdgj8YkzXZghXwncHc3ym1pCnbT9uH
 4xNLHEZ6LF7R/b2peWa5KdI+LAy6HIyASdM1ijNq9irYlpdASPR+212vcwSVbKnBpN
 qkD+86HuG23GTxLK8LBQTZVMtstdlhOaNu/rx9sXN0wEPerR6Dkl1xglb7fVRWQSPM
 xzL9+HREKaOVtr0yMFptO8JoqfyhcIaMaSXaELVCOeWmriPAs2PfMhH2HjRYFXTv1a
 3QdpUVR+kpcjNqIw7zmgHjc3ZCMsjRIkvnByF7PokArPTw1tGm/WUT7hcEagv4iE7a
 JsH5B3N2Myu9Q==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=syntacore.com;
 s=mta-03; t=1706098121;
 bh=DF3tDmrsdN5mqIYobCTSS8cQ5lq44Vz72IGCEa43Yqc=;
 h=From:To:Subject:Date:Message-ID:MIME-Version:Content-Type:From;
 b=zz8oRVVbfQ3RGIWnfemaSay1UPt4xYKF7UI57btc8qwY/UeqKiMkh7vN6adZkZIFS
 /lWBKByFVhBFgcDBPEJwXVt/gszBBhEwjWSz5VT412afnPz2r4dTqY5wEAhkyFGC8X
 cjOW1OSkHtseDpcr/YWrIGNENazv99tZKktX+GvJ03nyyDJ29Fn8WPTzyAdPi3vlZF
 so2vste7NWk9VNKAVyMm3C3LbU4aukZrcVFVmmUA113UZ1avQOWW/2RV+NkRkCGmjV
 1yaFmY0CdjNhPpfdnI12yiq9/hs5Cp2hZe20xJgdfkYcN05ZtYb1dkGF6fpHCW2Bi7
 UlTpIyYEKYxWw==
From: Vadim Shakirov <vadim.shakirov@syntacore.com>
To: "open list:All patches CC here" <qemu-devel@nongnu.org>
CC: Vadim Shakirov <vadim.shakirov@syntacore.com>, Palmer Dabbelt
 <palmer@dabbelt.com>, Alistair Francis <alistair.francis@wdc.com>, Bin Meng
 <bin.meng@windriver.com>, Weiwei Li <liwei1518@gmail.com>, "Daniel Henrique
 Barboza" <dbarboza@ventanamicro.com>, Liu Zhiwei
 <zhiwei_liu@linux.alibaba.com>, <qemu-riscv@nongnu.org>
Subject: [PATCH] target/riscv/cpu.h: mcountinhibit,
 mcounteren and scounteren always 32-bit
Date: Wed, 24 Jan 2024 15:06:58 +0300
Message-ID: <20240124120658.695350-1-vadim.shakirov@syntacore.com>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: T-EXCH-09.corp.yadro.com (172.17.11.59) To
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

mcountinhibit, mcounteren and scounteren must always be 32-bit by
privileged spec

Signed-off-by: Vadim Shakirov <vadim.shakirov@syntacore.com>
---
 target/riscv/cpu.h     | 6 +++---
 target/riscv/machine.c | 6 +++---
 2 files changed, 6 insertions(+), 6 deletions(-)

diff --git a/target/riscv/cpu.h b/target/riscv/cpu.h
index 5b0824ef8f..3cf059199c 100644
--- a/target/riscv/cpu.h
+++ b/target/riscv/cpu.h
@@ -317,10 +317,10 @@ struct CPUArchState {
      */
     bool two_stage_indirect_lookup;
 
-    target_ulong scounteren;
-    target_ulong mcounteren;
+    uint32_t scounteren;
+    uint32_t mcounteren;
 
-    target_ulong mcountinhibit;
+    uint32_t mcountinhibit;
 
     /* PMU counter state */
     PMUCTRState pmu_ctrs[RV_MAX_MHPMCOUNTERS];
diff --git a/target/riscv/machine.c b/target/riscv/machine.c
index fdde243e04..daab121799 100644
--- a/target/riscv/machine.c
+++ b/target/riscv/machine.c
@@ -398,9 +398,9 @@ const VMStateDescription vmstate_riscv_cpu = {
         VMSTATE_UINTTL(env.mtval, RISCVCPU),
         VMSTATE_UINTTL(env.miselect, RISCVCPU),
         VMSTATE_UINTTL(env.siselect, RISCVCPU),
-        VMSTATE_UINTTL(env.scounteren, RISCVCPU),
-        VMSTATE_UINTTL(env.mcounteren, RISCVCPU),
-        VMSTATE_UINTTL(env.mcountinhibit, RISCVCPU),
+        VMSTATE_UINT32(env.scounteren, RISCVCPU),
+        VMSTATE_UINT32(env.mcounteren, RISCVCPU),
+        VMSTATE_UINT32(env.mcountinhibit, RISCVCPU),
         VMSTATE_STRUCT_ARRAY(env.pmu_ctrs, RISCVCPU, RV_MAX_MHPMCOUNTERS, 0,
                              vmstate_pmu_ctr_state, PMUCTRState),
         VMSTATE_UINTTL_ARRAY(env.mhpmevent_val, RISCVCPU, RV_MAX_MHPMEVENTS),
-- 
2.34.1


