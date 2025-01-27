Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 55C4BC02190
	for <qemu-devel@archiver.kernel.org>; Tue, 28 Jan 2025 08:06:50 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tcgZG-00070B-OB; Tue, 28 Jan 2025 03:03:31 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mjt@tls.msk.ru>)
 id 1tcgXZ-0002MA-K0; Tue, 28 Jan 2025 03:01:46 -0500
Received: from isrv.corpit.ru ([86.62.121.231])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mjt@tls.msk.ru>)
 id 1tcgXX-0001wE-RS; Tue, 28 Jan 2025 03:01:45 -0500
Received: from tsrv.corpit.ru (tsrv.tls.msk.ru [192.168.177.2])
 by isrv.corpit.ru (Postfix) with ESMTP id A867AE1B52;
 Tue, 28 Jan 2025 10:57:08 +0300 (MSK)
Received: from localhost.tls.msk.ru (mjt.wg.tls.msk.ru [192.168.177.130])
 by tsrv.corpit.ru (Postfix) with ESMTP id 243D51A6305;
 Tue, 28 Jan 2025 10:57:34 +0300 (MSK)
Received: by localhost.tls.msk.ru (Postfix, from userid 1000)
 id EF4865209B; Tue, 28 Jan 2025 10:57:33 +0300 (MSK)
To: qemu-devel@nongnu.org
Cc: qemu-stable@nongnu.org, Harsh Prateek Bora <harshpb@linux.ibm.com>,
 Anushree Mathur <anushree.mathur@linux.vnet.ibm.com>,
 Nicholas Piggin <npiggin@gmail.com>, Michael Tokarev <mjt@tls.msk.ru>
Subject: [Stable-9.1.3 11/58] ppc/spapr: fix drc index mismatch for partially
 enabled vcpus
Date: Mon, 27 Jan 2025 23:24:57 +0300
Message-Id: <20250127202547.3723716-11-mjt@tls.msk.ru>
X-Mailer: git-send-email 2.39.5
In-Reply-To: <qemu-stable-9.1.3-20250127232536@cover.tls.msk.ru>
References: <qemu-stable-9.1.3-20250127232536@cover.tls.msk.ru>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
From: Michael Tokarev <mjt@tls.msk.ru>
Received-SPF: pass client-ip=86.62.121.231; envelope-from=mjt@tls.msk.ru;
 helo=isrv.corpit.ru
X-Spam_score_int: -53
X-Spam_score: -5.4
X-Spam_bar: -----
X-Spam_report: (-5.4 / 5.0 requ) BAYES_00=-1.9, DATE_IN_PAST_06_12=1.543,
 RCVD_IN_DNSWL_HI=-5, RCVD_IN_VALIDITY_CERTIFIED_BLOCKED=0.001,
 RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001, SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
 T_SCC_BODY_TEXT_LINE=-0.01 autolearn=ham autolearn_force=no
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

In case when vcpus are explicitly enabled/disabled in a non-consecutive
order within a libvirt xml, it results in a drc index mismatch during
vcpu hotplug later because the existing logic uses vcpu id to derive the
corresponding drc index which is not correct. Use env->core_index to
derive a vcpu's drc index as appropriate to fix this issue.

For ex, for the given libvirt xml config:
  <vcpus>
    <vcpu id='0' enabled='yes' hotpluggable='no'/>
    <vcpu id='1' enabled='yes' hotpluggable='yes'/>
    <vcpu id='2' enabled='no' hotpluggable='yes'/>
    <vcpu id='3' enabled='yes' hotpluggable='yes'/>
    <vcpu id='4' enabled='no' hotpluggable='yes'/>
    <vcpu id='5' enabled='yes' hotpluggable='yes'/>
    <vcpu id='6' enabled='no' hotpluggable='yes'/>
    <vcpu id='7' enabled='no' hotpluggable='yes'/>
  </vcpus>

We see below error on guest console with "virsh setvcpus <domain> 5" :

pseries-hotplug-cpu: CPU with drc index 10000002 already exists

This patch fixes the issue by using correct drc index for explicitly
enabled vcpus during init.

Reported-by: Anushree Mathur <anushree.mathur@linux.vnet.ibm.com>
Tested-by: Anushree Mathur <anushree.mathur@linux.vnet.ibm.com>
Signed-off-by: Harsh Prateek Bora <harshpb@linux.ibm.com>
Reviewed-by: Nicholas Piggin <npiggin@gmail.com>
Signed-off-by: Nicholas Piggin <npiggin@gmail.com>
(cherry picked from commit e8185fdc63e1db1efba695aae568fae8a075a815)
Signed-off-by: Michael Tokarev <mjt@tls.msk.ru>

diff --git a/hw/ppc/spapr.c b/hw/ppc/spapr.c
index 370d7c35d3..0307953fe5 100644
--- a/hw/ppc/spapr.c
+++ b/hw/ppc/spapr.c
@@ -758,7 +758,7 @@ static void spapr_dt_cpu(CPUState *cs, void *fdt, int offset,
     uint32_t radix_AP_encodings[PPC_PAGE_SIZES_MAX_SZ];
     int i;
 
-    drc = spapr_drc_by_id(TYPE_SPAPR_DRC_CPU, index);
+    drc = spapr_drc_by_id(TYPE_SPAPR_DRC_CPU, env->core_index);
     if (drc) {
         drc_index = spapr_drc_index(drc);
         _FDT((fdt_setprop_cell(fdt, offset, "ibm,my-drc-index", drc_index)));
-- 
2.39.5


