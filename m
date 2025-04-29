Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9D5BBC369D5
	for <qemu-devel@archiver.kernel.org>; Tue, 29 Apr 2025 00:23:11 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1u9Yk1-0003d9-6E; Mon, 28 Apr 2025 20:22:29 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <Alexey.Kardashevskiy@amd.com>)
 id 1u9Yjz-0003cq-8d
 for qemu-devel@nongnu.org; Mon, 28 Apr 2025 20:22:27 -0400
Received: from mail-bn8nam04on2052.outbound.protection.outlook.com
 ([40.107.100.52] helo=NAM04-BN8-obe.outbound.protection.outlook.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <Alexey.Kardashevskiy@amd.com>)
 id 1u9Yjw-0005Fj-Ai
 for qemu-devel@nongnu.org; Mon, 28 Apr 2025 20:22:26 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=i9l5JyQiEsKZwxxlCuQx0X4KPFQXbPsG0Vtb8tZF+Byg0CdhywNZ32Z12H2g/rp26MnAxUbNI8RWOSIBI68ePRS34CjNddPQ9FVAAdH70CiKPOrGt+wn1Iq7CU3OmkftM4EOtl21mCCd0B824Zc7LJsaMYqzHEX6N/MzFBvS/qzvcUbdKKbu5/68DhMM7rBakQyEw6NlsAQtPubsRlPfPr/sGKmdJoOmrvVjymcfseA2n8sO7D/B5I5LY49ckuG+vAXRUHHywDoEFyLi1pYOYC2AApZ1UwpJcLUD1WPoLlL2ngON4LdB88I9tFIEulr/gYqm2oqKmH8aMvpXCTCi7w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=2OnzZ7iJDqkrJgWKN6qHfpv0y6FAH2Uamz+0XrsMGis=;
 b=cky3HG2DqIl0DR4g8xFA93l/P6Ue5fhFrgURJLGUY0qu124a4Xc03jhlMaHq+PeHz02fhs5yUk5pvK1dMlExp8WaCetiG4JoGeUexBsCWOinqJi5CM06sGn02glaVE3Ht4emX14cFhigZAWp302Ky4DxxyQu0u57U9o9V4WvlZtyqBaop84IVcxWc5ZPbM7s1A0tXU+6rWGcBj1FG9AetOHSCrrIeGcXysQn1iawJDi02tps0MSfN002hA/2FPJrxUX0zA8OXp8Yih4C5ZJnTU46d4LocsBIQElbNGuuQxHXeomWmAEPbEkHNOS72LW4AQ1RVRCHgVwRhRZVdmaxpg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=nongnu.org smtp.mailfrom=amd.com; dmarc=pass
 (p=quarantine sp=quarantine pct=100) action=none header.from=amd.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=2OnzZ7iJDqkrJgWKN6qHfpv0y6FAH2Uamz+0XrsMGis=;
 b=ALhucL9gBz8jQk/G+7m9r+uHHuQtKlF3H0kUrmVRNget7MJSZYokvu4x/Ff+hKqb6z/l4ofy7+SjJ+40K8h9c+SNedeaFGhYk5/B9YvwsqAMUWW4RweRJ8fN0P2sMaCV7/TZ6QB8cUdBCSkYySiBXw1VIAU3Eq5yXwSZQrsSWPI=
Received: from SA1PR05CA0020.namprd05.prod.outlook.com (2603:10b6:806:2d2::22)
 by SJ0PR12MB6944.namprd12.prod.outlook.com (2603:10b6:a03:47b::11)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8678.27; Tue, 29 Apr
 2025 00:17:17 +0000
Received: from SA2PEPF00003F67.namprd04.prod.outlook.com
 (2603:10b6:806:2d2:cafe::8) by SA1PR05CA0020.outlook.office365.com
 (2603:10b6:806:2d2::22) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.8655.33 via Frontend Transport; Tue,
 29 Apr 2025 00:17:17 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 SA2PEPF00003F67.mail.protection.outlook.com (10.167.248.42) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.8678.33 via Frontend Transport; Tue, 29 Apr 2025 00:17:17 +0000
Received: from aiemdee.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Mon, 28 Apr
 2025 19:17:14 -0500
From: Alexey Kardashevskiy <aik@amd.com>
To: <qemu-devel@nongnu.org>
CC: Thomas Huth <thuth@redhat.com>, "Michael S. Tsirkin" <mst@redhat.com>,
 Cornelia Huck <cohuck@redhat.com>, Paolo Bonzini <pbonzini@redhat.com>,
 Stefano Garzarella <sgarzare@redhat.com>, Li Zhijian
 <lizhijian@cn.fujitsu.com>, Alexey Kardashevskiy <aik@amd.com>
Subject: [PATCH QEMU] x86/headers: Replace __ASSEMBLY__ with __ASSEMBLER__ in
 UAPI headers
Date: Tue, 29 Apr 2025 10:17:05 +1000
Message-ID: <20250429001705.2734439-1-aik@amd.com>
X-Mailer: git-send-email 2.49.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB03.amd.com (10.181.40.144) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SA2PEPF00003F67:EE_|SJ0PR12MB6944:EE_
X-MS-Office365-Filtering-Correlation-Id: 66f1f7d3-ccf7-4e36-0a3c-08dd86b33321
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|1800799024|82310400026|36860700013|376014; 
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?A3oPlGQFQHEAxdb13+jqUsQoo4d6PgTf/M2Bv1fwQTUmXAI5lfSe7NgOEGAw?=
 =?us-ascii?Q?q7jBCZBTqtiegcU3dOeWJA0RjhAUHIctEvJcsa4Op7o8oEP4ixDmpxrRrP84?=
 =?us-ascii?Q?XCXh11FgBTc8neF/J1v2ntr42iugqQMYH8zEnp48LfCEt8oJDVBhptHyCBrQ?=
 =?us-ascii?Q?N/IpeeSw4JLgne1WN9D6y3FVk9/+PMqTjgvQX8A7yxGdKRlt7uGmmkeXu8Rk?=
 =?us-ascii?Q?xc8K1M+mxeJEM16qekY1WwOl+Qn9vpSQjXmj7hfdgyrRW1/I7RzDX4xfybG7?=
 =?us-ascii?Q?tz657/306dYdKfSCGVNo+rR/lDu5Y7D65N9G8J5vSZ3RHwv6+e7/U3qdXUJO?=
 =?us-ascii?Q?GocmaBEDdx9nRheRLYYi7srG+JwuuOuDuUHc3Whm9GzX5I62+cn1Oj0v+qql?=
 =?us-ascii?Q?pxrGPoRbs20JN9LJ++sNKj3rR/i6STZ9m/HasRbJZgA90B6sfTBMq6MaXkZD?=
 =?us-ascii?Q?DpRLs2F9Zv8oXfDPHs3TPvWmfQjWKiNX1qyoLP0reJuazKSwXnbphApxzU80?=
 =?us-ascii?Q?0MS2u0WP626j/vGvStgu8EVgJMTglSajzQYaihcy6P52d0efwwHN9hemUSVk?=
 =?us-ascii?Q?dVjR5OWfnWj+9oweDoqwJx5fYbKZW26PMxr3cZIC7nMjVmxt77L7NUtFWw+e?=
 =?us-ascii?Q?AAAYaBV/bxpzIDNlHIsFKLMGSOJn7R5prueiPO/3ceRlYvZHElqWhARi10UI?=
 =?us-ascii?Q?UmgQ6w0h0fTZ5+lkwDyzpLJRTzAGXQ15RljKnNMOEJfmeJUJBqbqKp3xk79/?=
 =?us-ascii?Q?wD/MJvZ7Ts7aBETe9iOUH/KRxOQfemqVXS8e6hTbNlZY7pr0yqhDKh9j22LJ?=
 =?us-ascii?Q?SaflANrp1rt8JAfxQcYErsO681muATGnfGlGcS3rS0mXyRcKSMXR13dpqVll?=
 =?us-ascii?Q?tRwouK7CQi8bqCiADOl3cEB2mS6iVq0YYF9iDw7gmWfUvj+Qpzk8k0yNSUdc?=
 =?us-ascii?Q?GBTgasJJcDM8KKGrmrx7N3nR4c3bvXz2CuBfARcCnPw0HzN9IajTuJPlBaUw?=
 =?us-ascii?Q?40DfO1Me07H0pluIH2jBIbcc3tu8oBu4XefZWTGSdbDFlw0Yc5nkXuQI1GH0?=
 =?us-ascii?Q?KIC7kbLc/eiKNxPfiEZIJwuKlBd0MExCxdYXz06z2m8slt4tDl2sv/MTZ6kr?=
 =?us-ascii?Q?9sdZst93NIjr1sLGwxseeZok4ts5wMAomJHIal89ieO5bBjcDABtjWZtss8r?=
 =?us-ascii?Q?AK0WdpLwRZ3/3HUdbJBzqysr1a+5q+Rf8gtP4cWib5Wz9B0jQo7tBLYetWwV?=
 =?us-ascii?Q?dibbMjpzTkIHsjRHuL9V/9NIyG+vbuvd38ud8nppsvek3rC7ci0tKYLxUtWU?=
 =?us-ascii?Q?uP6WCFECk9/nFS91FRKeUp3hLF7D/wbrHsV1+B/MA/q4mN1ep6fa3/6zRUHh?=
 =?us-ascii?Q?FsiEPPVZxqRNCvX7yiTy1f6esuJf5+PoxUf8bm3ApgxecNSJQvKR2clMhOSm?=
 =?us-ascii?Q?i3Cw4cHN1O1BWUKfUT/0ABpQFveXSrU42FPiucm7V/44imlYNqgoJHGJJuvD?=
 =?us-ascii?Q?Br+5BNaoKAY7Y62plvnwTp95rk8Aw8La2jxednWddMBbeTXVRNC+7ZBBog?=
 =?us-ascii?Q?=3D=3D?=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(1800799024)(82310400026)(36860700013)(376014); DIR:OUT;
 SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 29 Apr 2025 00:17:17.0895 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 66f1f7d3-ccf7-4e36-0a3c-08dd86b33321
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: SA2PEPF00003F67.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ0PR12MB6944
Received-SPF: permerror client-ip=40.107.100.52;
 envelope-from=Alexey.Kardashevskiy@amd.com;
 helo=NAM04-BN8-obe.outbound.protection.outlook.com
X-Spam_score_int: -25
X-Spam_score: -2.6
X-Spam_bar: --
X-Spam_report: (-2.6 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.484,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H2=0.001,
 RCVD_IN_VALIDITY_CERTIFIED_BLOCKED=0.001, RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001,
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
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org

The recent kernel update 8a141be3233af7d broke the headers update,
fix it in the script.

Cc: Thomas Huth <thuth@redhat.com>
Signed-off-by: Alexey Kardashevskiy <aik@amd.com>
---

Or we want both __ASSEMBLY__ and __ASSEMBLER__?

https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/commit/?id=8a141be3233af7d
---
 scripts/update-linux-headers.sh | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/scripts/update-linux-headers.sh b/scripts/update-linux-headers.sh
index 8913e4fb99b..b43b8ef75a6 100755
--- a/scripts/update-linux-headers.sh
+++ b/scripts/update-linux-headers.sh
@@ -177,7 +177,7 @@ EOF
 
         # Remove everything except the macros from bootparam.h avoiding the
         # unnecessary import of several video/ist/etc headers
-        sed -e '/__ASSEMBLY__/,/__ASSEMBLY__/d' \
+        sed -e '/__ASSEMBLER__/,/__ASSEMBLER__/d' \
                "$hdrdir/include/asm/bootparam.h" > "$hdrdir/bootparam.h"
         cp_portable "$hdrdir/bootparam.h" \
                     "$output/include/standard-headers/asm-$arch"
-- 
2.49.0


