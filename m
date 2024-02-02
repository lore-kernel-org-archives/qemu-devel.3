Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7322FC47DB3
	for <qemu-devel@archiver.kernel.org>; Fri,  2 Feb 2024 11:42:59 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rVrvq-0003nw-GK; Fri, 02 Feb 2024 06:42:06 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <vadim.shakirov@syntacore.com>)
 id 1rVrvp-0003nV-HX; Fri, 02 Feb 2024 06:42:05 -0500
Received: from mta-04.yadro.com ([89.207.88.248])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <vadim.shakirov@syntacore.com>)
 id 1rVrvn-0005KA-NQ; Fri, 02 Feb 2024 06:42:05 -0500
DKIM-Filter: OpenDKIM Filter v2.11.0 mta-04.yadro.com 8E1FEC0003
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=syntacore.com;
 s=mta-04; t=1706874117;
 bh=EbXOcRSAjLk94LsLZVw3GLjYqZ5HOqf43M1+CKsq08Y=;
 h=From:To:Subject:Date:Message-ID:MIME-Version:Content-Type:From;
 b=cDIp2WaS44oinZTra3c7T89oRvRcjwmp2GxgI7nAS9p2xJJvimiE8AM9BxMI+RFob
 M3Bv9M0buyAKrS2o0s8ZbsCNyZuWYbrrV+LDDKhupy76Knt9Ak+K0cHGfA2L4s2eyb
 34uHQQMYHEDL1ftCdLjvQ0Grzi0O3I1XjieI2faZb2tOfAmkvERQl22Tnd3oBI+dpT
 l8nKtoDBhDhRpmkRfB1NxKQzKAEudOsoHheJItciqANslLVvOtfqG/TMMByU0QgyYZ
 DAyurHfJQ7Ce/PXBexDmM1Mo93FU/XiXs9p45nnqS8KdQ6jgadxioBDJr1zWc6L697
 9IQnZSs50155A==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=syntacore.com;
 s=mta-03; t=1706874117;
 bh=EbXOcRSAjLk94LsLZVw3GLjYqZ5HOqf43M1+CKsq08Y=;
 h=From:To:Subject:Date:Message-ID:MIME-Version:Content-Type:From;
 b=ptTpVfGDV/MNDtvYF7bBpl9r3WqdiXXDwZbrakHvpj8EiQnAkCAzkR/AJAf/M30UE
 69Lk/yRKeidyDTHdKs8dveAFiusLEEs+cMk49daGMLltapRu5/OvRnTeVD1+ZCZBqr
 H75VvbEkffGsUNU2A02qulFuXDCKpvSj0tjc5N/4kMsDsRG89lDUKvBY8m6IYJVt2D
 i9yCte8fxfeTXEEGRbGQGTPhBkpqfwuYha4X/WhtP2SdVFNKXzSOmcNxFHoPkXa+re
 Nm53/kp5DQ/w294nH91PDkEvYlHTi+ows1Wv/cxhVsaJ3VTeKuihqSz6EffXhtf0BX
 iuFyKBNrHUFmg==
From: Vadim Shakirov <vadim.shakirov@syntacore.com>
To: <qemu-devel@nongnu.org>
CC: Vadim Shakirov <vadim.shakirov@syntacore.com>, Palmer Dabbelt
 <palmer@dabbelt.com>, Alistair Francis <alistair.francis@wdc.com>, Bin Meng
 <bin.meng@windriver.com>, Weiwei Li <liwei1518@gmail.com>, "Daniel Henrique
 Barboza" <dbarboza@ventanamicro.com>, Liu Zhiwei
 <zhiwei_liu@linux.alibaba.com>, <qemu-riscv@nongnu.org>
Subject: [PATCH v4] target/riscv: mcountinhibit, mcounteren, scounteren,
 hcounteren is 32-bit
Date: Fri, 2 Feb 2024 14:39:19 +0300
Message-ID: <20240202113919.18236-1-vadim.shakirov@syntacore.com>
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

mcountinhibit, mcounteren, scounteren and hcounteren must always be 32-bit
by privileged spec

Signed-off-by: Vadim Shakirov <vadim.shakirov@syntacore.com>
---
 target/riscv/cpu.h     |  8 ++++----
 target/riscv/machine.c | 16 ++++++++--------
 2 files changed, 12 insertions(+), 12 deletions(-)

diff --git a/target/riscv/cpu.h b/target/riscv/cpu.h
index 5138187727..cf1867a6e2 100644
--- a/target/riscv/cpu.h
+++ b/target/riscv/cpu.h
@@ -271,7 +271,7 @@ struct CPUArchState {
     target_ulong hstatus;
     target_ulong hedeleg;
     uint64_t hideleg;
-    target_ulong hcounteren;
+    uint32_t hcounteren;
     target_ulong htval;
     target_ulong htinst;
     target_ulong hgatp;
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
index 72fe2374dc..a4d47ec17e 100644
--- a/target/riscv/machine.c
+++ b/target/riscv/machine.c
@@ -79,14 +79,14 @@ static bool hyper_needed(void *opaque)
 
 static const VMStateDescription vmstate_hyper = {
     .name = "cpu/hyper",
-    .version_id = 3,
-    .minimum_version_id = 3,
+    .version_id = 4,
+    .minimum_version_id = 4,
     .needed = hyper_needed,
     .fields = (const VMStateField[]) {
         VMSTATE_UINTTL(env.hstatus, RISCVCPU),
         VMSTATE_UINTTL(env.hedeleg, RISCVCPU),
         VMSTATE_UINT64(env.hideleg, RISCVCPU),
-        VMSTATE_UINTTL(env.hcounteren, RISCVCPU),
+        VMSTATE_UINT32(env.hcounteren, RISCVCPU),
         VMSTATE_UINTTL(env.htval, RISCVCPU),
         VMSTATE_UINTTL(env.htinst, RISCVCPU),
         VMSTATE_UINTTL(env.hgatp, RISCVCPU),
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


