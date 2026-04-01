Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id BA1C810F9314
	for <qemu-devel@archiver.kernel.org>; Wed,  1 Apr 2026 01:04:48 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1w7jz7-0007mM-6w; Tue, 31 Mar 2026 21:03:05 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <nathanc@nvidia.com>)
 id 1w7jys-0007hY-K7; Tue, 31 Mar 2026 21:02:52 -0400
Received: from mail-southcentralusazlp170120001.outbound.protection.outlook.com
 ([2a01:111:f403:c10d::1] helo=SN4PR2101CU001.outbound.protection.outlook.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <nathanc@nvidia.com>)
 id 1w7jyo-0007bu-UI; Tue, 31 Mar 2026 21:02:49 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=tyxge+KEkoSqmSjezvmZ5KvdWJccwwI3t3B3Ghnj+BMbxY34aMDYNS4/SdbWZGO8pCoWCKrZ6xFREJRMCFCCnvwtm2UoJQhTr4cYgzUIm0+BRkV4jTzNpaK6qE6obdHHYzpwHu6YIN+brSwGOqj+aRAAZWMSjJ07k5ic4LU//oK1pR6rlIR2dQoiLvbXcjo7+nyWP3ATKMMxRqgA7ChpScJRvLj8j6yfDpXPD9LwQRrXCUXI78dMUpMe846cP6sn1UVoDZWxeb1xDbRPJ5CXdJtq89w+II7eHOyxqL2VtOTq2XtwTsoAh3YvPyKyyZQEaEnyC6oN/U1F3FwjfL801g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=OtNKE3qM0spLNQ1BvVI0EGcMMrIH6CLhGaRlKLTv57M=;
 b=AXhVIM8pkmJZ50NONbEq0ahtXm7OzLkXpZHLygDr++rBBFuFlf3/rc4sAJG+cv0a3fA3IQOe14omU5llyhbaBnBPmt7gOi2BZOJvkeTimQ8wXUesE334SrbeULRb3I8TzHsCzqQn4poy5laso2FSgJKqwX2R7N8WAqtg8WKNh/edrEArajLl6hck1zYVAugWIBI8XmwgBsPk2AmzzOZ+/8+pk2NGM39beltIf9Z8Dl3Q6+95ZOaikA+V1PPxLKXdeC/p5TQLgh/eSVsIIWLufpia99JTdl4a0gDpoASrvYkvp6W7JO3RUxbqRadsmSUO95nzqMRPmow3Zc1V47tQ0g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=OtNKE3qM0spLNQ1BvVI0EGcMMrIH6CLhGaRlKLTv57M=;
 b=fXk5BNtj/LQtN2nekMLdAL49ETDgTMzBIYGFuN5vOnnrFZiZhEfIWu40KjUC8w8Oiog3UOhG9tQCkhNTsT9DA5MF9yDTojDPAu427z6wBarMov+GR/eqEljYdXCgXBMMMGOuNctYLMA+6ty2pwpqgifObUXUbxOD+tZ+6q2oh4gqP8fAVTVLY5TwesX/3OIA3MJBflXr4NNxPxYlj/p1GHpYeAocXZvXI5sOIwNU25NokHNkl5e+uw+Vr0gXzEt6PD3PxritQn9QJ0pwZ4B8xuDHvscnOrAcc1FjsE9NeBUmiZpC83DammsdOqNVrNM+LhVUFwNG8NSra2XZdvz1ow==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from DS2PR12MB9567.namprd12.prod.outlook.com (2603:10b6:8:27c::8) by
 IA1PR12MB6626.namprd12.prod.outlook.com (2603:10b6:208:3a2::20) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9769.16; Wed, 1 Apr
 2026 01:02:41 +0000
Received: from DS2PR12MB9567.namprd12.prod.outlook.com
 ([fe80::636:1b52:24ca:d7e5]) by DS2PR12MB9567.namprd12.prod.outlook.com
 ([fe80::636:1b52:24ca:d7e5%3]) with mapi id 15.20.9769.015; Wed, 1 Apr 2026
 01:02:40 +0000
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
Subject: [PATCH 03/11] hw/arm/smmuv3: Change the default ats support to match
 the host
Date: Tue, 31 Mar 2026 18:02:23 -0700
Message-ID: <20260401010231.4166776-4-nathanc@nvidia.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260401010231.4166776-1-nathanc@nvidia.com>
References: <20260401010231.4166776-1-nathanc@nvidia.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: SJ0PR13CA0185.namprd13.prod.outlook.com
 (2603:10b6:a03:2c3::10) To DS2PR12MB9567.namprd12.prod.outlook.com
 (2603:10b6:8:27c::8)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS2PR12MB9567:EE_|IA1PR12MB6626:EE_
X-MS-Office365-Filtering-Correlation-Id: d51981ab-ceda-455c-5d55-08de8f8a5f9c
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|1800799024|376014|366016|7416014|22082099003|56012099003|18002099003;
X-Microsoft-Antispam-Message-Info: Q/c2r0XTZZBOcjnP9JHl+Q9m4bWG+FiaflM43r+ai1sGIJVOiS3Vukp7uUifs1eizVBmXvKUuuFifu5GA+a0oEUMxbEo9bnqfgC3opZ7nguXNDqXVPKRsRoLpCLsqVQFBeINuNH+z4WupJrEfahc3WnJP6ubjZz4bBRKPyBoYw8dwtLKfd/VrNK4zGYYsW5OBsb0MsGZiOaCoC4BIkaWelVjFbPkIBbCz7uxwUU7qjd4tDt9xJN4dR3N3N7RcyOKjJISsLbHIZSE6nJLhgGRqMDqWPcYabWOya0KpomO/79uuWfh3qYZ/V/Uun6bz4r9+T/dTP3kVRl/tIW1odxVAM6jd+VTq4WQ7TjmFJGoNwbXkB76Dy1P+7JC7aM0ESZaSqr1LUArJ3rojZpeXxICtd1LKXE/UKpAb0IozJhEB1jNIe/J+gBU4nYJqrjrwFB45K178KzBl9tf72X1LSMRThZyvbLP0yo9/F4R0sTKy8ZAPTcsjiCVpAaoNKb9gQt8kDsFQ2HEMGO61k/TQ8FX4P9CFCqObVsymELkxFIaP9K5gIHNPqvt6JFrGKDmBLZNFVtjsBjQFZxLtvonu3xQ9Aol1sheVLPDVdlrFvsQRzICxEbMxa2crvHrwkVGlhPVXMkRSu+AVYdwnAT/UbZ8+g6vCf249byub3zB3vsXCnWz5UfLi4trda9oj4Yaceenm6BVYRi1LL9TwnDO0WRWWeYaDY936DxEqADxurgsCr0=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DS2PR12MB9567.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(1800799024)(376014)(366016)(7416014)(22082099003)(56012099003)(18002099003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?AOzcK3KvGGtMQctNJuckcs9Nl6MC1w3uYn14PnguAie5IvGKF6uRB4J1ehAy?=
 =?us-ascii?Q?kN21NUdgigQj6upsFGaaABJzbmGeRF/RKK9ApMMNKrnpSo0J7CQEdrCHoRpa?=
 =?us-ascii?Q?x4QWMfADEbsDD3A128T/pZkP42HvH6dVzBJD0nSkKKColEgkXRrYYKYzW7DX?=
 =?us-ascii?Q?76KaBp115tOhyoJdussYp17qMeKdXXWg7dzZmrL38/XQJhTBLIQhSaemel8D?=
 =?us-ascii?Q?8u7zet+L4NcIeOijAq0oAL/TvuNrcjmUHQV33FP3VtSLT/ZFpMGldzJX3eEa?=
 =?us-ascii?Q?xgpmWjqx5D8JJKTdmPTviaoRKfo5FMJ7NlHQBiSAWtSzqbk8OcSkfhQaraL1?=
 =?us-ascii?Q?fskTOdcIlvoypjupraHz3K2R5CE5aUwNq4huNlMCxEbXMwS8tRpFBSIwtMbQ?=
 =?us-ascii?Q?3H8YGS6wdX224FUAQEwr9ZnxKts5ZV9NUTa87CGm08QHbfPQPqkaO7vudjnC?=
 =?us-ascii?Q?g8hROQmlG4y6b4I983tP3EDEgX6Ingu7qWmim1pWqJn09PdMAH3CFTl8w7O9?=
 =?us-ascii?Q?NAEspdFZSANBPTul3fXJZFAN+NCFxgAdfyO2fLF3sQyJlilqRppc6raFBqMP?=
 =?us-ascii?Q?CjBVpNkqBskMWhzIapIhNKks7mY8xTlALpwpkzGEDu5aEgV1idprnrK6ktWX?=
 =?us-ascii?Q?fyPy1tIMsm6JijH4VToD8DLrOiNuNhNkzIP2iv9Ydfn3hMb+xz+l+nsoACpZ?=
 =?us-ascii?Q?8E+CQ1TwFmmeq+BF7Eld4llcKHxwvghUP0ATF75Bd2VgFnpKrr/IrW4EwN9s?=
 =?us-ascii?Q?M2jnbaC7l/fSLTNqKx0ovmBvoeRPiXPKGJuOW1s6ug+OjX7KoFJyKYWv5PKS?=
 =?us-ascii?Q?DugQ9bGNvBOohssua3fA61JZKL0r/yU7wFFcOjQBP+6zxzJFmj562vXK/TA9?=
 =?us-ascii?Q?ugq8ZHQnuqBnia3Xr6uRVH7ft0MvrzKi/QkpyqtD0VIlgmd1vHbmZi6OduJ3?=
 =?us-ascii?Q?OiSAQGukEso7CK5UiRTzzRSOvIqDs6sqxE4IqvzvOy28BMhuMj8UMc0UaXIp?=
 =?us-ascii?Q?mNtvcke9gUFVcSeuVPD9R2cwLvR+YFWLYhxwOPuW4G1N9dQ7JxR243FkVyKY?=
 =?us-ascii?Q?ULKJDbCHSL2MmxF1M8bDBLSWNghSb8VIApukPqwoAwkn2mqnWImZbhP3oo4d?=
 =?us-ascii?Q?/65qdPSX9G+jVfTMi8XzaijYrp7q+6mbTSWWj7dggCRNHmra9kwWv7UYd7Aw?=
 =?us-ascii?Q?1/7sa/z8aZimOX82hLlHDliHf31dwL4ctaLnxdvMgN9wV0Dl81sZJsSwf6BU?=
 =?us-ascii?Q?5ugAtcF9qNCuVgCSdtfnSZ4ssYbrbppl5fmZSZMkr9FJ14CFkJPQv5GLW4c2?=
 =?us-ascii?Q?gaHT19AYYxO3wWjVBiGjgG/O6PjdzocHq37KNM/B9A21Q7V0lWcd5pKNxQCX?=
 =?us-ascii?Q?0hNaywBqskW8AslJ42gP/P92PR4S8ej993Dx57cXBB+oiIXKGkg0fkriwglV?=
 =?us-ascii?Q?WOJbaHhcYkpYZz2VnLON51QamNdOufMg50TOKP0hSuyb+zVszrrrwu6PfVFT?=
 =?us-ascii?Q?55FyEzBbo8JjDGp6skX9ZusTeWG8MvtCG2qfdE7DLfUlhDEvDuR5Dbw+sEcw?=
 =?us-ascii?Q?rDO28dI5zt1+y6SqceDWI01W9/jXnHyDaf+79bfMHhoxoXgUY8JHBmCAR3QR?=
 =?us-ascii?Q?YYmNi3NEmsZT6UXpSj1NDBr5rlhzhnuKn4lGX+vUG3Q6IPYw57OKOJ3+pi4R?=
 =?us-ascii?Q?fQUJ02R5qoS3aJ0h4/J8ot8guVJ3x1Z8viz+LcrT6LBFWBnQd4n3aICfK9hn?=
 =?us-ascii?Q?argVFCqMww=3D=3D?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: d51981ab-ceda-455c-5d55-08de8f8a5f9c
X-MS-Exchange-CrossTenant-AuthSource: DS2PR12MB9567.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 01 Apr 2026 01:02:40.6663 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 0A4tyz2THCsm35fKO20H0X2RUySK0AEn7OHm6y+A4yBMrIbD/OhxbGTFJhIZWdoV4YJGfNUzYeLN4eaGIxwhjg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA1PR12MB6626
Received-SPF: permerror client-ip=2a01:111:f403:c10d::1;
 envelope-from=nathanc@nvidia.com;
 helo=SN4PR2101CU001.outbound.protection.outlook.com
X-Spam_score_int: -15
X-Spam_score: -1.6
X-Spam_bar: -
X-Spam_report: (-1.6 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.54,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 FORGED_SPF_HELO=1, SPF_HELO_PASS=-0.001,
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

Set the default value of ATS to auto. The default for ATS support used
to be set to off, but we change it to match what the host IOMMU
properties report. Introduce a new compat for the changed default.

Signed-off-by: Nathan Chen <nathanc@nvidia.com>
---
 hw/arm/smmuv3.c   | 2 +-
 hw/core/machine.c | 5 +++++
 2 files changed, 6 insertions(+), 1 deletion(-)

diff --git a/hw/arm/smmuv3.c b/hw/arm/smmuv3.c
index f3603554e3..f353865187 100644
--- a/hw/arm/smmuv3.c
+++ b/hw/arm/smmuv3.c
@@ -2158,7 +2158,7 @@ static const Property smmuv3_properties[] = {
     DEFINE_PROP_UINT64("msi-gpa", SMMUv3State, msi_gpa, 0),
     /* RIL can be turned off for accel cases */
     DEFINE_PROP_ON_OFF_AUTO("ril", SMMUv3State, ril, ON_OFF_AUTO_ON),
-    DEFINE_PROP_ON_OFF_AUTO("ats", SMMUv3State, ats, ON_OFF_AUTO_OFF),
+    DEFINE_PROP_ON_OFF_AUTO("ats", SMMUv3State, ats, ON_OFF_AUTO_AUTO),
     DEFINE_PROP_OAS_MODE("oas", SMMUv3State, oas, OAS_MODE_44),
     DEFINE_PROP_SSIDSIZE_MODE("ssidsize", SMMUv3State, ssidsize,
                               SSID_SIZE_MODE_0),
diff --git a/hw/core/machine.c b/hw/core/machine.c
index 0aa77a57e9..6796ab63cc 100644
--- a/hw/core/machine.c
+++ b/hw/core/machine.c
@@ -37,6 +37,11 @@
 #include "hw/virtio/virtio-iommu.h"
 #include "hw/acpi/generic_event_device.h"
 #include "qemu/audio.h"
+#include "hw/arm/smmuv3.h"
+
+GlobalProperty hw_compat_11_0[] = {
+    { TYPE_ARM_SMMUV3, "ats", "off" },
+};
 
 GlobalProperty hw_compat_10_2[] = {
     { "scsi-block", "migrate-pr", "off" },
-- 
2.43.0


