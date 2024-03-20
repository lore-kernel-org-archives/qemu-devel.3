Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9299CC54E58
	for <qemu-devel@archiver.kernel.org>; Wed, 20 Mar 2024 08:45:34 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rmrZO-0000n0-M2; Wed, 20 Mar 2024 04:45:10 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <Michael.Roth@amd.com>)
 id 1rmrZM-0000kG-Nf
 for qemu-devel@nongnu.org; Wed, 20 Mar 2024 04:45:08 -0400
Received: from mail-dm6nam11on20600.outbound.protection.outlook.com
 ([2a01:111:f403:2415::600]
 helo=NAM11-DM6-obe.outbound.protection.outlook.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <Michael.Roth@amd.com>)
 id 1rmrZK-00085a-05
 for qemu-devel@nongnu.org; Wed, 20 Mar 2024 04:45:08 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=hJESJWdGMq/esKu3BGmh2jUktOOffKW4lzL9l9WFoz8Wu7CuFQiTXqmFnFL7hnf53pcU0BysIguLwr7qWnqFYcg5wPwzHn/vNhma/Z5yOb0oDEiVuF5ufjUcCAJDqa+HHS+7EYupThxgiStnXvUdNNAfBftj0YB+HbUG8cCl0fJlXYxyOW8Hy7siNzgh2/k3yD37tIRxVtyIX+vGKxNGYYBrmGGAH29Gmkvjp0rjsJycN9fv78+ETpHTRrNxj0Vhz7Nu6vUd+R86kWfAZEHPzWU3t+dK9uICSS/QpC/qYJdV93a5ZS1m+iW3o45dTW0ozPHJix3bGPz055sMj2Vd4g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=BpZ+SqVKQVLU/VQrnrSoqvpAcIU0Juoe+lQqz7DfMFI=;
 b=Or+tfC3zbUfDEy/p+O3vqA8tAG5E/ER89onh26VVHGd2kfWn6q4AyNRPjl8eq9/83fOJCh3W71osgaitjQKStkNXkFenuWZAkl/minZyrjLFanf0eCYP7XWPdHzdetQnfwqHxLWgSNg1pvmFIn00ZSwniu4IRIfcst+iI44hyQaQgk67pSrfnGUE/LudKSRABGLcN92TjMKLy/k2k7k1rw1wwO06sl1Ngh8XsplvLfwV3a9GDYWdSL3xI+XVEqLDrtOQ/it4PZMfpaigP6Yde3vc+ukmY1IhLoaEw3JMcAMD5eoI/bWHCEyoAjonC8ldDsicRqkAioyTPTXGfWhGpQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=nongnu.org smtp.mailfrom=amd.com; dmarc=pass
 (p=quarantine sp=quarantine pct=100) action=none header.from=amd.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=BpZ+SqVKQVLU/VQrnrSoqvpAcIU0Juoe+lQqz7DfMFI=;
 b=tPW2cThE8+K6BPat/aEEA8ubqWD2lIZqyFGRWM6HBBotfbC1CrwRziZX1wDXlL67qk79BGSyvvzjFa80pyvAL3wG06EevB7QFv33oEjrxL07yRfFLXBqY0yQBP0ygDliWSuZI1E/g4TVqbeQxSzmuVrLuV+NZ1hkyeQaHhB5E9k=
Received: from MW4PR04CA0059.namprd04.prod.outlook.com (2603:10b6:303:6a::34)
 by SA1PR12MB8161.namprd12.prod.outlook.com (2603:10b6:806:330::7)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7386.27; Wed, 20 Mar
 2024 08:44:59 +0000
Received: from MWH0EPF000A672E.namprd04.prod.outlook.com
 (2603:10b6:303:6a:cafe::a) by MW4PR04CA0059.outlook.office365.com
 (2603:10b6:303:6a::34) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7386.28 via Frontend
 Transport; Wed, 20 Mar 2024 08:44:59 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 MWH0EPF000A672E.mail.protection.outlook.com (10.167.249.20) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.7409.10 via Frontend Transport; Wed, 20 Mar 2024 08:44:59 +0000
Received: from localhost (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.35; Wed, 20 Mar
 2024 03:44:58 -0500
From: Michael Roth <michael.roth@amd.com>
To: <qemu-devel@nongnu.org>
CC: <kvm@vger.kernel.org>, Tom Lendacky <thomas.lendacky@amd.com>, "Paolo
 Bonzini" <pbonzini@redhat.com>, =?UTF-8?q?Daniel=20P=20=2E=20Berrang=C3=A9?=
 <berrange@redhat.com>, Markus Armbruster <armbru@redhat.com>, Pankaj Gupta
 <pankaj.gupta@amd.com>, Xiaoyao Li <xiaoyao.li@intel.com>, Isaku Yamahata
 <isaku.yamahata@linux.intel.com>
Subject: [PATCH v3 19/49] kvm: Make kvm_convert_memory() obey
 ram_block_discard_is_enabled()
Date: Wed, 20 Mar 2024 03:39:15 -0500
Message-ID: <20240320083945.991426-20-michael.roth@amd.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20240320083945.991426-1-michael.roth@amd.com>
References: <20240320083945.991426-1-michael.roth@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB03.amd.com (10.181.40.144) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: MWH0EPF000A672E:EE_|SA1PR12MB8161:EE_
X-MS-Office365-Filtering-Correlation-Id: 1af5f33d-1b74-4826-a053-08dc48ba06c2
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: KShVnZL+BhTW3k38A/fuHCan76XqbbIFxYYGcF2y3udhKw+eVFQ8ZuSFveUqRSrvC1AmFc0Tb1JdF7EImmd/vOKMukr5HL5d7LmVWIj39zlu97P+OodwOyHpv0Ucl9lu2Tb4fQeAlfL8SrTtpQnLM0D1I5Ut8z6/U0QK0A+iaC5zCDrAHqk+Lo4BCtIdGgIrCrOtlDOxjAvTjBiPfaqkTi1Qhfbtf5JRM6PqehX/UKr73iYksB3ubmgooay6nr/1LQaI5chL6UPyXvv9MgQuIx9Iu1vApCGxltyoqiOseVCMRW7uI4AIyMH7MmSuFQV58GIPycj5Nk+CA1YORlnAwBO2aPdoa6p7Idwv6XP3kDfuC+Ht8eCWKXvXIx5Prj310Ti/Zv/1L6vbuSUBxNlbCnxpmkxdCJk4jFFcWnaFEmJ4mbtV97Iv/wuNR37ZiQGxpCeXMZRQerdzARCKa4FyxQVlgvldeEhFCuIIAmgHwhyRgqEWJL/7G24/m1yOxaAJ2+xtKi7O5LkML339xdjweNNgPajX9y/DsyIRxZMLDOsMo9XtW7/Ozqrmqazrj0+hC2aFKP0bMKtLKKiPuKKo0mNvbeWMjiKe/Uixa6UACJe54JB6qaPA3aRd8kuCHEzkKllCnLS1fVXwdlWNvc6S/E4tN6XMmzp5X8xJIzQ2bdB7VEmcxx4GSDz2sxLYveukjQ/MkX31CiPgLXIAYq7rLPwXOhME6tLSbITVliIkIlw8xJbQ2DOSpA1Lcoyn9hlG
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230031)(1800799015)(36860700004)(376005)(82310400014); DIR:OUT;
 SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 20 Mar 2024 08:44:59.2740 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 1af5f33d-1b74-4826-a053-08dc48ba06c2
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: MWH0EPF000A672E.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA1PR12MB8161
Received-SPF: permerror client-ip=2a01:111:f403:2415::600;
 envelope-from=Michael.Roth@amd.com;
 helo=NAM11-DM6-obe.outbound.protection.outlook.com
X-Spam_score_int: -24
X-Spam_score: -2.5
X-Spam_bar: --
X-Spam_report: (-2.5 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.422,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 SPF_HELO_PASS=-0.001, SPF_PASS=-0.001,
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

Some subsystems like VFIO might disable ram block discard for
uncoordinated cases. Since kvm_convert_memory()/guest_memfd don't
implement a RamDiscardManager handler to convey discard operations to
various listeners like VFIO. Because of this, sequences like the
following can result due to stale IOMMU mappings:

  - convert page shared->private
  - discard shared page
  - convert page private->shared
  - new page is allocated
  - issue DMA operations against that shared page

Address this by taking ram_block_discard_is_enabled() into account when
deciding whether or not to discard pages.

Signed-off-by: Michael Roth <michael.roth@amd.com>
---
 accel/kvm/kvm-all.c | 8 ++++++--
 1 file changed, 6 insertions(+), 2 deletions(-)

diff --git a/accel/kvm/kvm-all.c b/accel/kvm/kvm-all.c
index 53ce4f091e..6ae03c880f 100644
--- a/accel/kvm/kvm-all.c
+++ b/accel/kvm/kvm-all.c
@@ -2962,10 +2962,14 @@ static int kvm_convert_memory(hwaddr start, hwaddr size, bool to_private)
                 */
                 return 0;
             } else {
-                ret = ram_block_discard_range(rb, offset, size);
+                ret = ram_block_discard_is_disabled()
+                      ? ram_block_discard_range(rb, offset, size)
+                      : 0;
             }
         } else {
-            ret = ram_block_discard_guest_memfd_range(rb, offset, size);
+            ret = ram_block_discard_is_disabled()
+                  ? ram_block_discard_guest_memfd_range(rb, offset, size)
+                  : 0;
         }
     } else {
         error_report("Convert non guest_memfd backed memory region "
-- 
2.25.1


