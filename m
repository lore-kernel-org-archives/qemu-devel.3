Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 15823C47422
	for <qemu-devel@archiver.kernel.org>; Mon, 29 Jan 2024 08:48:40 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rUNJg-0003K5-79; Mon, 29 Jan 2024 03:48:32 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <vadim.shakirov@syntacore.com>)
 id 1rUNJe-0003ID-CI; Mon, 29 Jan 2024 03:48:30 -0500
Received: from mta-04.yadro.com ([89.207.88.248])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <vadim.shakirov@syntacore.com>)
 id 1rUNJc-0006ZH-BY; Mon, 29 Jan 2024 03:48:30 -0500
DKIM-Filter: OpenDKIM Filter v2.11.0 mta-04.yadro.com 1E471C0016
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=syntacore.com;
 s=mta-04; t=1706518104;
 bh=C1QYP0j3twV0lFLiJ0IiCEddYoizmIvDtyy/2gcN9u4=;
 h=From:To:Subject:Date:Message-ID:MIME-Version:Content-Type:From;
 b=oAZ4d+2Ahq15BGv6D2YZWcXe5IcFB2H8q2aoZ0FLBgbh+w3XeeH/Dfs1um9zjnbn0
 xgwLgQm/E8eNsJJkLFCRQ63OM5xR2mUsayFO4PFHce4svendhOuD+PUx1lgD+lvz7g
 LcNC+YfHITECqbdYYMyRKg9Tz92o2xIsx+hCIKAcBPnG7ME3zcO69eHM3d/xAelYRq
 hXwmg1tu0WA5Z1mPdhgk6vIKBH3dMcviVA9Fep660QaVoQUGuAIdeMNLyXYJ/UKw4u
 v6VdWYHlOvwEyjOI2A406lwIDRiLByyccjSQdcnxXgqbCX2SLcrkAPzKOj8y9nVBXi
 9yeY54uwwFBoQ==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=syntacore.com;
 s=mta-03; t=1706518104;
 bh=C1QYP0j3twV0lFLiJ0IiCEddYoizmIvDtyy/2gcN9u4=;
 h=From:To:Subject:Date:Message-ID:MIME-Version:Content-Type:From;
 b=IW3iXXBHsb7QLNLAXcv7bO94swhOS/LXRc1ya4ACk0QfPoSkXR+mzpxkKdbD0I771
 DBj8DUfu8s85Dd/Klh7RwslNdWnoq7RbfmYvE9QQfA+V9o4sGr1Vpd4Z2D9hjIW0ow
 02OKVinRjUavyG11Oor0EFkA6LGmoGcaLdAEurlhr3sWNXMj6Lp/g8rDtwem9oYqY/
 aLCh/UxOu85dvaC0TexJAy6FFyGSrzpJ6xU1wdVGbh7Gps3QvPd6/R/HB3Fzl4TxwQ
 8WL53mwf5lVEg8EefUucPsJEiNaS0WHyLFb0JP8BzyK46ZMIIYK8ugYbdECb6GgdHE
 6RfLYf9DjWKqg==
From: Vadim Shakirov <vadim.shakirov@syntacore.com>
To: <qemu-devel@nongnu.org>
CC: Vadim Shakirov <vadim.shakirov@syntacore.com>, Palmer Dabbelt
 <palmer@dabbelt.com>, Alistair Francis <alistair.francis@wdc.com>, Bin Meng
 <bin.meng@windriver.com>, Weiwei Li <liwei1518@gmail.com>, "Daniel Henrique
 Barboza" <dbarboza@ventanamicro.com>, Liu Zhiwei
 <zhiwei_liu@linux.alibaba.com>, <qemu-riscv@nongnu.org>
Subject: [PATCH v2] target/riscv: mcountinhibit,
 mcounteren and scounteren always 32-bit
Date: Mon, 29 Jan 2024 11:47:28 +0300
Message-ID: <20240129084728.48311-1-vadim.shakirov@syntacore.com>
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

mcountinhibit, mcounteren and scounteren must always be 32-bit by
privileged spec

Signed-off-by: Vadim Shakirov <vadim.shakirov@syntacore.com>
---
 target/riscv/cpu.h     |  6 +++---
 target/riscv/machine.c | 10 +++++-----
 2 files changed, 8 insertions(+), 8 deletions(-)

diff --git a/target/riscv/cpu.h b/target/riscv/cpu.h
index 5138187727..2236a55bf1 100644
--- a/target/riscv/cpu.h
+++ b/target/riscv/cpu.h
@@ -334,10 +334,10 @@ struct CPUArchState {
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
index 72fe2374dc..6bf013054d 100644
--- a/target/riscv/machine.c
+++ b/target/riscv/machine.c
@@ -354,8 +354,8 @@ static const VMStateDescription vmstate_jvt = {
 
 const VMStateDescription vmstate_riscv_cpu = {
     .name = "cpu",
-    .version_id = 9,
-    .minimum_version_id = 9,
+    .version_id = 10,
+    .minimum_version_id = 10,
     .post_load = riscv_cpu_post_load,
     .fields = (const VMStateField[]) {
         VMSTATE_UINTTL_ARRAY(env.gpr, RISCVCPU, 32),
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


