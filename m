Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7BE5710F9314
	for <qemu-devel@archiver.kernel.org>; Wed,  1 Apr 2026 01:04:42 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1w7jzH-000807-PX; Tue, 31 Mar 2026 21:03:15 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <nathanc@nvidia.com>)
 id 1w7jz3-0007lj-Jn; Tue, 31 Mar 2026 21:03:03 -0400
Received: from mail-centralusazlp170100005.outbound.protection.outlook.com
 ([2a01:111:f403:c111::5] helo=DM1PR04CU001.outbound.protection.outlook.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <nathanc@nvidia.com>)
 id 1w7jz2-0007bB-5z; Tue, 31 Mar 2026 21:03:01 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=i67XJzVnFFqmepj6eRP7SkjHUCVBi3ikHdLKi3CkWyoPWTM5hkeP8u42sThR6aEQAXAT5H9ymvMnRoALaBRflxyG6q14HBzrL/d2JeBmZ2eUh/YRX4TjSHFTxm06AVS/Jm0Qgx7WaLDgfTLzkBXV6hkTj3g3QkB1yb65rRrF4y7yokSnnV/rA6278mMWfzun5QTxgZUFjC/WsbsxhR+uBpMoSjwHy+hQmIkd0cf+MCmEym4spTcwqlrN7/MM5kCVE9GnH341RMBG4rHCJkyfs4bBlzjX5d4c4njvwraU6nxDrWj7lJoQB4StCl6AkuHyfD97LHAcakMnUz0GRd/N+A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=7dBj2IM5wVx7ZccbLxxA53xxhQtH+qa5Tb5FKlU+FkU=;
 b=O34CgSiGXDdN7bREdshtVcDj5UucKV/Frt0mNvQUXFF8A+uvQKh2xbrDBED8wSbzzAGMlYQr7fPIQDCQaPDlCaeUwDsjjM62+5Yr25GQozm9p5m8rDi5w/x4ZwqGnJlsTmEpzxDnJAxRYdQJIIdJ8k02bYrDPdpg0xAO38HDIpRofN92pd02MScBfdF8rpTE4ExqNwMQ7z5hPZ6N5DZFSKdT/Ym5oQnc0sj2jr7IQA5hCcUPKgR69ycsB0JaIo/NFiHdWT4M3FiTfEoUSnfPIAHKAMIf3HASzoja1nWPkyoLjQtD/fHLg6FjXwKDGY0MdVx1g9cR3OrybBeShWAfLw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=7dBj2IM5wVx7ZccbLxxA53xxhQtH+qa5Tb5FKlU+FkU=;
 b=JEwzaj4sLhFMPoIpT8eOeEJLjtesqgBrNotr7bM4enO8DD0S3wuM8XREcMh8u6vVNLGZY7xnMDIWyO0oJ7/58doiVLewmBgozXKRRbz7jvwlsLntojDAKoUjGKJCFN1kI/Wxw7emR2T991gfpTTKVPY0j5krTclbF1Cdi/7R142q2Za0/yVmdzO71FVB3US7uEq4XfIDvanIreaMeratpsYwo6bw0tDBu3ME5SBLpXeE+78Dj0Mj1pEqMy1PWn6MzAIY7i92POsUI6LM1O29zoPcTeLHeJNnLPmexb5PweOaqkLRvtCq+2redIW/MB0dZSty8BRIxpK402a5mm9SDg==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from DS2PR12MB9567.namprd12.prod.outlook.com (2603:10b6:8:27c::8) by
 CH1PR12MB9647.namprd12.prod.outlook.com (2603:10b6:610:2b0::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9769.17; Wed, 1 Apr
 2026 01:02:45 +0000
Received: from DS2PR12MB9567.namprd12.prod.outlook.com
 ([fe80::636:1b52:24ca:d7e5]) by DS2PR12MB9567.namprd12.prod.outlook.com
 ([fe80::636:1b52:24ca:d7e5%3]) with mapi id 15.20.9769.015; Wed, 1 Apr 2026
 01:02:45 +0000
From: Nathan Chen <nathanc@nvidia.com>
To: qemu-arm@nongnu.org,
	qemu-devel@nongnu.org
Cc: Yi Liu <yi.l.liu@intel.com>, Eric Auger <eric.auger@redhat.com>,
 Zhenzhong Duan <zhenzhong.duan@intel.com>,
 Peter Maydell <peter.maydell@linaro.org>,
 Marcel Apfelbaum <marcel.apfelbaum@gmail.com>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Yanan Wang <wangyanan55@huawei.com>, Zhao Liu <zhao1.liu@intel.com>,
 Alex Williamson <alex@shazbot.org>,
 =?UTF-8?q?C=C3=A9dric=20Le=20Goater?= <clg@redhat.com>,
 Shameer Kolothum <skolothumtho@nvidia.com>, Matt Ochs <mochs@nvidia.com>,
 Nicolin Chen <nicolinc@nvidia.com>, Nathan Chen <nathanc@nvidia.com>
Subject: [PATCH 06/11] hw/arm/smmuv3: Change the default ril support to match
 the host
Date: Tue, 31 Mar 2026 18:02:26 -0700
Message-ID: <20260401010231.4166776-7-nathanc@nvidia.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260401010231.4166776-1-nathanc@nvidia.com>
References: <20260401010231.4166776-1-nathanc@nvidia.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: BY5PR03CA0021.namprd03.prod.outlook.com
 (2603:10b6:a03:1e0::31) To DS2PR12MB9567.namprd12.prod.outlook.com
 (2603:10b6:8:27c::8)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS2PR12MB9567:EE_|CH1PR12MB9647:EE_
X-MS-Office365-Filtering-Correlation-Id: a2b10eb4-4835-4a6b-3426-08de8f8a62a1
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|1800799024|366016|376014|7416014|18002099003|56012099003|22082099003;
X-Microsoft-Antispam-Message-Info: 8ue1O8W12aUJ69e1fCTy9ya0HWCAuaeDj4LflT6px0rIJoUsl6fmWSooqybbZnzMBZqPyanBqrixKtuRA5Vksy9SlTPQlxKnrhgp/BcjiBnuAD0H8bfjf4uFc0//3a9EPAjeBRyrA5Kt0MQw6LSn6STW93HOUCueUjq0hsGpePFmBkXmOugrEHUfG23zuz5X+ORftO/69bjYai9EDr69sMr0sVvW0oNESRVlgvmjrHhGpbEWwHZp5CVz61oVXukPl/SKK6P3GG4OQyeJpZzLNpFY3+uaZ9hdknc4XsWgTed95Cgi/vGmck3oVP01sSVUhJ46IavU/o7hvDKWiwmgQnQ41TgJKqiWOHYWHZtswgBwmnNnVafy+UP/WZ3M0LZX6iHFYUlTKvrM8d8x2uJnPAINCe2rDTfR3XSShsyJwjsUcpz3L7FYOYHT9syYTfHEELDzceyZ09Vu/lEVKgsYCcWEeOBciO28YfH7+HxQoPtHg0BR8TvTN+epqR5cqtvCN6E92PSfHd6pkwXuTUQ3CajTViptlRtmLL2ioABmMtuhf1QNCa1WhWJlLFFi08huB/EdPeCC9XEaPHpqZ1BeL1EP1CIIiGKZ1PAkalevWvKMGKTvLfiWDoRcInMXIRwC8gCla0zclnrgd7/0TRZKkuCQP1Za8nHmPqqMIqVAHl5fQMBYbY/CmnDVb9W9SvdR53uABnI6l/oQ+Ia28jxCi1vsFyqC1psrf20ZQhGAM+4=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DS2PR12MB9567.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(1800799024)(366016)(376014)(7416014)(18002099003)(56012099003)(22082099003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?2hvVCM2SgeKomzzSQzwH/zFSnbuarzQn7/SRyEjMWBJMzRrFGt70KPFnUMKk?=
 =?us-ascii?Q?bgn5nWlncv+fPIoz/oloFIxSgewKQ+RShMmpKKBcJDMNG6LpzElyCZclLkE7?=
 =?us-ascii?Q?cCbAS/Is5+Aas1UJx6ZZWOiHw2z1TR6Crkl5R0jbcVPGrGIIkwUAOOfRFubX?=
 =?us-ascii?Q?zRPOfqGAkm4TSoL11ozKs+eKlI7lgTWWh9kC/TbmazxTmq/AbI8p50qmv5Sv?=
 =?us-ascii?Q?t4XxJknYv/2UH+hbnUuzQrP1JuzJvc3bXmGFwwvAAf7reftLTgionDy5KH4Q?=
 =?us-ascii?Q?l+kFLvn0c3sayVA44E+OXcHi5QONckGIPQOPmnM0xhgaql899wJqRULIZ0Hz?=
 =?us-ascii?Q?6e8zOjxXcJ8G/fI2dFx+lV2JKUNImG5rujZKlZuMBi2D1IHfzMNleX/E7t8c?=
 =?us-ascii?Q?7xpXkqrunxmytFK9qBoYd68mEvXpiOi3Nr1MLeAm+fFH8CD1a3R4mXV5TUvU?=
 =?us-ascii?Q?C2LDYdxu5Clk0gtPgEgBkq3P/aKB9p1llEMinfldmXeXxWLJemmROu+4phK5?=
 =?us-ascii?Q?vvguX7pN0ISoTaxOoX5YzzNhf2wtbSWPaASruizFke3oQQ0udIpWp63r8qnG?=
 =?us-ascii?Q?ibWoPKjlEUuwGB/whRB8tGu9yad1IWcScUL3rLCt+64DlY4eb72E0zGKfAJN?=
 =?us-ascii?Q?NkHkKqaKu/CQEEU2zH6iVhkmJ66IEkX3TVE87pixpeQz2eSG4IdbPJBlV4yv?=
 =?us-ascii?Q?mX/Ef5bWUlqJxtmM41/wJe8gvwSlJLSZsl8X8TqdyDBwCBjDKHzEcPJNdIKf?=
 =?us-ascii?Q?nYtm+jcIKkqss5lkCT0VrCNXekELxSQHqKNYtOux6lMnSAjyOUuQdIedpquD?=
 =?us-ascii?Q?Z0tlUstGjiyiHf0StTk34kNttPULfn30ZhMSys3cuhrBVta1VJvDhqhnqd9E?=
 =?us-ascii?Q?wD8FgtSMgGVVTHqu+Sz3huR1KZyQj9/dUob72cunGLZenbss1QrFFIhq+yfY?=
 =?us-ascii?Q?sIGgkr9DlE1cxO5+W6glWIz1hH0UnJ8qjN3FLxNVggliUTFpkDe8CAj+3EaE?=
 =?us-ascii?Q?W0Phq11MsVyzQzqJ90wf5CiZj7JjQU+e2dJ5k4QSh/AKKf2SpRpVAkgm/0UP?=
 =?us-ascii?Q?CKuADF3WyjgyZ+SK6d5XYRC8b7avVcWSEXKVamaLfFREwKs7WAb9Kwp4uzJQ?=
 =?us-ascii?Q?0JvfXmYk7srYxG0If0Adse7KAjQdJuxPQxemN+an6YcJVk7mFhepmnsFHa65?=
 =?us-ascii?Q?gvxG1puXsc6T3q9HjqFmX58rTnJc2xIjkHdIwfBVfkgl+WIPDc6cGu5zwTmh?=
 =?us-ascii?Q?eSv7s/NW5xUThTadFQMQ2gvn9KYasFw39H+Icg77NsFgswDoRsZMoFbKcwV7?=
 =?us-ascii?Q?cdUTl9zYHCTaEfzkrBdvqQDmXFKDiK45m4I9xzJMnSQVx5zhPM+v4urFsqp/?=
 =?us-ascii?Q?2BczFVaC9l6pCsP85NaGxODqiOmtpnx/61Nx5leEuGrYw0i1utSAn+VOLOBW?=
 =?us-ascii?Q?BqVBRAhZNH8/Zp9quvNd09l5ui5A6yv/9l/moA9b8sNCZekxMnxtRESgrWYK?=
 =?us-ascii?Q?UOITJ+LD04mszVbL8SxiVkdBy0tvvJHMlWLNSdBwrb8GeXxpfbykl0X4opji?=
 =?us-ascii?Q?H3HYDoHmDbfM1vdmcSFFyByWTyOxF7qHNepWnkLRiH8ZcCI6XzxOGPyT+3f2?=
 =?us-ascii?Q?NcfTSc3QW0kmUDFVPyFjccqRFgWmhbZXVpiPQBrCaOh7G4VFLLzqqNtZ86GE?=
 =?us-ascii?Q?6x26GXJeBB/DQ8XkJOwH3vvd24wu/MKvWjwjMZnToLootI3cgLkX7kqJDby5?=
 =?us-ascii?Q?1bDlwFGU/g=3D=3D?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: a2b10eb4-4835-4a6b-3426-08de8f8a62a1
X-MS-Exchange-CrossTenant-AuthSource: DS2PR12MB9567.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 01 Apr 2026 01:02:45.7612 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 2ymBArltE8fznGzT4TvuJp0D87TRdhfgnWOE3uQHGZJ+T6pKHlkVfaRYMHVZtQlI1yHVb9+T60uyLDO2pidaew==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH1PR12MB9647
Received-SPF: permerror client-ip=2a01:111:f403:c111::5;
 envelope-from=nathanc@nvidia.com;
 helo=DM1PR04CU001.outbound.protection.outlook.com
X-Spam_score_int: -15
X-Spam_score: -1.6
X-Spam_bar: -
X-Spam_report: (-1.6 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.54,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 FORGED_SPF_HELO=1, RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_PASS=-0.001,
 SPF_NONE=0.001 autolearn=no autolearn_force=no
X-Spam_action: no action
X-BeenThere: qemu-devel@nongnu.org
X-Mailman-Version: 2.1.29
Precedence: list
List-Id: qemu development <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <https://lists.nongnu.org/archive/html/qemu-devel>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=subscribe>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org

From: Nathan Chen <nathanc@nvidia.com>

Set the default value of RIL to auto. The default for RIL support used
to be set to on, but we change it to match what the host IOMMU
properties report so that users do not have to introspect host IDR3 for
Range Invalidation support. Include the previous default for ril in the
11.0 compat.

Signed-off-by: Nathan Chen <nathanc@nvidia.com>
---
 hw/arm/smmuv3.c   | 2 +-
 hw/core/machine.c | 1 +
 2 files changed, 2 insertions(+), 1 deletion(-)

diff --git a/hw/arm/smmuv3.c b/hw/arm/smmuv3.c
index a2d2f0e3bc..74cc81ae32 100644
--- a/hw/arm/smmuv3.c
+++ b/hw/arm/smmuv3.c
@@ -2153,7 +2153,7 @@ static const Property smmuv3_properties[] = {
     /* GPA of MSI doorbell, for SMMUv3 accel use. */
     DEFINE_PROP_UINT64("msi-gpa", SMMUv3State, msi_gpa, 0),
     /* RIL can be turned off for accel cases */
-    DEFINE_PROP_ON_OFF_AUTO("ril", SMMUv3State, ril, ON_OFF_AUTO_ON),
+    DEFINE_PROP_ON_OFF_AUTO("ril", SMMUv3State, ril, ON_OFF_AUTO_AUTO),
     DEFINE_PROP_ON_OFF_AUTO("ats", SMMUv3State, ats, ON_OFF_AUTO_AUTO),
     DEFINE_PROP_OAS_MODE("oas", SMMUv3State, oas, OAS_MODE_44),
     DEFINE_PROP_SSIDSIZE_MODE("ssidsize", SMMUv3State, ssidsize,
diff --git a/hw/core/machine.c b/hw/core/machine.c
index 6796ab63cc..8f8c26bbe8 100644
--- a/hw/core/machine.c
+++ b/hw/core/machine.c
@@ -41,6 +41,7 @@
 
 GlobalProperty hw_compat_11_0[] = {
     { TYPE_ARM_SMMUV3, "ats", "off" },
+    { TYPE_ARM_SMMUV3, "ril", "on" },
 };
 
 GlobalProperty hw_compat_10_2[] = {
-- 
2.43.0


