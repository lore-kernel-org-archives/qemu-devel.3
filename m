Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id EC7D4C27C53
	for <qemu-devel@archiver.kernel.org>; Wed, 12 Jun 2024 19:18:19 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sHTTc-0008CP-97; Wed, 12 Jun 2024 15:17:44 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <Babu.Moger@amd.com>)
 id 1sHTTb-0008CG-IE
 for qemu-devel@nongnu.org; Wed, 12 Jun 2024 15:17:43 -0400
Received: from mail-co1nam11on2081.outbound.protection.outlook.com
 ([40.107.220.81] helo=NAM11-CO1-obe.outbound.protection.outlook.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <Babu.Moger@amd.com>)
 id 1sHTTZ-0003pX-7H
 for qemu-devel@nongnu.org; Wed, 12 Jun 2024 15:17:43 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=j/b8idCyKe+G4Y3PEImnl3LDEVbQhwTeutT/V0dU+243WEWeRpnQ4IfNIL5gD5G9a41sQcW4FwUD2kjGPszzeKsFah2wzo10h0/ibA+hmaxmhseMy26dgxiHP6X/oPm90Ef2NGTI8eN5FrL2ebP4YsyVWt3fjS8xGDjC55/CgjzPKJQsDMkupIGWtGllEIq0LJ/HTc+eLGjdnEoeNY3X4iiP8uAiEpVlmdYwgV7HtlK7TErrnVxEI3J1FDYIuievrs2g/Hw1w9eOhySXnSXQbR0tPveymlpEqMRKBfbuvOIWKAXH0s5nfjYzbbNlpZ1wQtnqEgxQbw6Z6wCR9Z6xKw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=abdutjUGx5kavoiZQufXrbHrlCnwFwMKoGFc6jW2ToM=;
 b=HR470JINO0yJxZlkzBilu/56xw+Biw4NBrTHjn5GrICZdbFQRKiFMIdEDs9dkQ+dlSQblA5pe22GemIp+jNWVh7YXgeDcddLku+r8zY7IkGMzzRjDsbJGy/fPex6KtvV58OlxnIF9OLT+1fukN1kT94rzimIC3YN29/Oz4NGtb4iA5i2G7awtyjYJ9xWSmp3Dp23+ksnXVUlK6sNMtRyuqo9EOWhHAltPwpsP19SfdAA1ldg5phrJ8EYe3hGBaTma+DP6VpwWjI8Fn7lrBzwqpNH/snxr503POk5R9HG1x1mRfJI9u/VwMA+yZDeeZTvDPWmGU9GAuHEFLtgXjDMCQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=redhat.com smtp.mailfrom=amd.com; dmarc=pass
 (p=quarantine sp=quarantine pct=100) action=none header.from=amd.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=abdutjUGx5kavoiZQufXrbHrlCnwFwMKoGFc6jW2ToM=;
 b=S0BmO7yKaUm/T7MKwpLHwpddoitudPa8ZW8w+oHnrlP2D1Uskjkz4hKDy0NFJZeOkqyo77/jKLgfy0oq+sC5V2CWvJGWEtglF0xlnBn5hiWvRRWWQdGd0dzK/3rQzdhUh0zVxzKujBa5LXwONSxQMeQl82kU7zA6a7O9PyrK/oE=
Received: from BYAPR05CA0102.namprd05.prod.outlook.com (2603:10b6:a03:e0::43)
 by PH7PR12MB7453.namprd12.prod.outlook.com (2603:10b6:510:20a::10)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7633.36; Wed, 12 Jun
 2024 19:12:28 +0000
Received: from SJ1PEPF00002315.namprd03.prod.outlook.com
 (2603:10b6:a03:e0:cafe::6) by BYAPR05CA0102.outlook.office365.com
 (2603:10b6:a03:e0::43) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7677.20 via Frontend
 Transport; Wed, 12 Jun 2024 19:12:27 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 SJ1PEPF00002315.mail.protection.outlook.com (10.167.242.169) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.7677.15 via Frontend Transport; Wed, 12 Jun 2024 19:12:27 +0000
Received: from bmoger-ubuntu.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Wed, 12 Jun
 2024 14:12:25 -0500
From: Babu Moger <babu.moger@amd.com>
To: <pbonzini@redhat.com>
CC: <qemu-devel@nongnu.org>, <babu.moger@amd.com>, <kvm@vger.kernel.org>
Subject: [PATCH 0/4] i386/cpu: Add support for perfmon-v2,
 RAS bits and EPYC-Turin CPU model
Date: Wed, 12 Jun 2024 14:12:16 -0500
Message-ID: <cover.1718218999.git.babu.moger@amd.com>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB04.amd.com (10.181.40.145) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SJ1PEPF00002315:EE_|PH7PR12MB7453:EE_
X-MS-Office365-Filtering-Correlation-Id: 6afec269-a446-4da6-6bb1-08dc8b1399bb
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230034|376008|1800799018|82310400020|36860700007; 
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?50Y3YFQSUEbTEkGA2p+8wdMzCRxWSqbFCzgzlJlRMrd4/zmtmIZKuEePxqC4?=
 =?us-ascii?Q?wLTI1WOf0GHeIJ7bNJyWj8iQXKsQfUCiSm8FR+ViQpgwtupXEQFofbpgrWIO?=
 =?us-ascii?Q?quvGvwXph2+pdD3DCD3eF+QZDJg3AOnrDel3YgS5Gv63wshm7yYiCN2i96OS?=
 =?us-ascii?Q?D4JkeW9e0nO+VpRVBLUrCZuNeJocW3wGOpwrE+J1148cZ9EBK3ZopNFH7QMq?=
 =?us-ascii?Q?qqLG9rJRJZwuemQJaMaB8w0y2mfT9iLaG4tthtu58Aa9AwCuAu45oXwXsw9q?=
 =?us-ascii?Q?q+o9RObV+urqFGCFbRMTSt6A/XffungR+EqZiPdcoD9/Vpq7DmL4Jw+9fzTU?=
 =?us-ascii?Q?7eIkLkqHpDmlpaZ4MHzmawh5ZkUH8wwUZcmJrx8KjUEhB+cGdNg4BTTptYBl?=
 =?us-ascii?Q?Xpq8f0OFeiCoZgr4hwHc46mwzODzeDFpxxmgUyOsQWzq6lso8+S7DQiWFkeo?=
 =?us-ascii?Q?2dbJiuBOwP9Ux4bGB7T/ak+eBORVV4r4Z1af4B5HIYM66v2Blun5q1w9gFKs?=
 =?us-ascii?Q?hkRkxhSbax2JGA1bw20uoB1joesdu9L9scCZsEmblWkR+YvKnMDdQvIJ9tZo?=
 =?us-ascii?Q?o6EyAAGgrZg2rx9Fzqqc+ZrH9QooeVVHx7wLtdKP2ZAuru2X7Of3KQIHd1sf?=
 =?us-ascii?Q?80xIsqYfDYl8eJXKFspgZOywKWBJbBHdQ8tVe/M4iNFk26Gp9Sxkle/0N9Hz?=
 =?us-ascii?Q?vEzmpIYwmfBExmu2nWo31Y/6ip4ALoDh8a+nKKnN3jjR7KeDt/zZz4JID8nw?=
 =?us-ascii?Q?3x2UxU2gmL18V/1jSuYjq/9n36LQZzpUZecWR/j6CnO67ZEQZXbQRyvYsXts?=
 =?us-ascii?Q?pYx3OP+pEETyTulIu9ldXvIDY7rUQ5bT5qcatV+OkFmJIpXJlKaXq7K21RNz?=
 =?us-ascii?Q?usG2LJwjD3gn6ETADDkKTX5tEEWJ992HUPdcTSUFiDaJ3zANYJgTjrqL+jeY?=
 =?us-ascii?Q?31746HS2ZjY5/k5VJIdgWz8eLbKk6IkleL4+OD1/uOhDpL5YkT+IjzJkpWDX?=
 =?us-ascii?Q?B+TKlrzOrYb4818TxrDkCrO2rBPTtkPuiAipWsIbJHnrD9hSh73Gpn1ef8dV?=
 =?us-ascii?Q?KyC8mKcuhxKyJaKE05KwjqSrsQu/5Vla7oV2R9QDFCOkhNMRDo/Az7T40Khb?=
 =?us-ascii?Q?H2NvV+Dx4pAo1uoksRYnYU2dZCdfgr+ktMFrTUI1MsQ9BAMjrW2MHaQpHXx8?=
 =?us-ascii?Q?/Kj4VpudEmEg0F7f741LYgpZKWoX/l8cv1dWxFHqT681A+SJcyeXr3YDRS/x?=
 =?us-ascii?Q?ap5qp5MPyiXJDYZtgQ5Rmrn6DO4W48mIQzRMr4ZxIRqgUDnYFEuiXG5Llkd9?=
 =?us-ascii?Q?0W9YNVvkab/UXrQWa+28ReVARRAKCpnf6x79RuMaQV9h/WPG6U8gPj3EqCqJ?=
 =?us-ascii?Q?gkGsXkjo7viX5ZipjyObqzWav2ajBHC6HGpuTnoHd6vg7KtEHg=3D=3D?=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230034)(376008)(1800799018)(82310400020)(36860700007); DIR:OUT;
 SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 12 Jun 2024 19:12:27.5229 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 6afec269-a446-4da6-6bb1-08dc8b1399bb
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: SJ1PEPF00002315.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH7PR12MB7453
Received-SPF: permerror client-ip=40.107.220.81;
 envelope-from=Babu.Moger@amd.com;
 helo=NAM11-CO1-obe.outbound.protection.outlook.com
X-Spam_score_int: -22
X-Spam_score: -2.3
X-Spam_bar: --
X-Spam_report: (-2.3 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.143,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_MSPIKE_H2=-0.001, SPF_HELO_PASS=-0.001, SPF_PASS=-0.001,
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


This series adds the support for following features in qemu.
1. RAS feature bits (SUCCOR, McaOverflowRecov)
2. perfmon-v2
3. Update EPYC-Genoa to support perfmon-v2 and RAS bits
4. Add support for EPYC-Turin


Babu Moger (3):
  i386/cpu: Add RAS feature bits on EPYC CPU models
  i386/cpu: Enable perfmon-v2 and RAS feature bits on EPYC-Genoa
  i386/cpu: Add support for EPYC-Turin model

Sandipan Das (1):
  i386/cpu: Add PerfMonV2 feature bit

 target/i386/cpu.c | 202 ++++++++++++++++++++++++++++++++++++++++++++++
 target/i386/cpu.h |   4 +
 2 files changed, 206 insertions(+)

-- 
2.34.1


