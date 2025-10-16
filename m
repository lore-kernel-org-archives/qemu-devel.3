Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E791FCCD199
	for <qemu-devel@archiver.kernel.org>; Thu, 16 Oct 2025 23:29:51 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1v9XOr-0003gq-GV; Thu, 16 Oct 2025 19:28:49 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <nicolinc@nvidia.com>)
 id 1v9XOp-0003gb-Is; Thu, 16 Oct 2025 19:28:47 -0400
Received: from mail-northcentralusazlp170100001.outbound.protection.outlook.com
 ([2a01:111:f403:c105::1] helo=CH1PR05CU001.outbound.protection.outlook.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <nicolinc@nvidia.com>)
 id 1v9XOn-00018H-HX; Thu, 16 Oct 2025 19:28:47 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=bIaNvmo9/4kC1vQf17otFeoZpH8wi10QkyGx62ygqdk3dyELXidZDsc5AN8csPki5ATOTXl5/eydUHXjcX3sQaOelktdx5HwpsKxCTL/TfXKoV0ssCTqanoxgG17zjRN2Hy9VzBl8OlbyS1p6lM+Ay+U3RtNnyY42QDp7L0LjzcfOk0fXVIz+z221lsHE97Lsu0O7tf3+I28cMOhHN/rN0PsXpJsQUmTWBSbfSucGE9sHhY68ftGHKh/faw5GkIVilyDOy3SY07sD8hQ0qJvUTWriEACckFL1DsKi818xEWIdrgKTQWl5QmBiOYRHYxNkOlGS6qe0yxTLlNaHxi8NQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=1zwz9rdTuN0snTQul54XTMDtu5czmuJxYZFak6CddRQ=;
 b=qqPJ5mEpeFMjNXZtitTrPCZTHQIDe/p2PHX50egm25Jw4M3lRr3HZuO59H9tlwIbY/uiM1hceTWrQcV3xrjkRbDYkPLxGBovWWHsSSlN9HoqFrvAMC1AfYDI+qQZi4lGroVwus6z8ZyrtPmKpzqYKG++m2+5ouT8YmhM2B5zgyBJn1jkFNH5J/GN4yrF2ay0HhTH9cqX0nAOSZByE0KuCoaNLQeT16wCGYlFkJAFrYx/NcMVW+4zMfA+9785SfneBI7sNU/VW1Y3s7HOPcyftJ9ViKy8RN+fwNUO1KJ7R8elwnZwQf1Y/FfvcbV/NVaNOAQtk6jLJTrHxNGH7PuIBg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.117.160) smtp.rcpttodomain=intel.com smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=1zwz9rdTuN0snTQul54XTMDtu5czmuJxYZFak6CddRQ=;
 b=ElfsLAgSWtR3Fy6r3yTWHSXuOZA6QwXfPwVy/HUWc4E+LFmAKjIp8bb5HwAWHyvk0Gq4P9jgyzWsblYfy2OvamJVyqF+eUDILh4U0FBXOyKGtM0dMe/0QKAkbUextyQh37bYlx9+bLfyiN5MoEIr5zfoefahZhvIGJJ36paHlNJWqf73kKy77cBD9LjUKYF/J+UrwSSdlM/YJ23EntZrYn+EgEXgVmE5gVt6xaTvdNBny/7JdP6tgDs3JiAaycl/7e5HxMkng+WYYTUlonoiVkdFNqOVMKHMV38m+OxltqkKRiH03zvK4Rcpkra1LCJ7Xp7bFfP1CNF650LcoOXoJg==
Received: from PH0PR07CA0078.namprd07.prod.outlook.com (2603:10b6:510:f::23)
 by IA1PR12MB6116.namprd12.prod.outlook.com (2603:10b6:208:3e8::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9228.11; Thu, 16 Oct
 2025 23:28:38 +0000
Received: from CY4PEPF0000EE3C.namprd03.prod.outlook.com
 (2603:10b6:510:f:cafe::2a) by PH0PR07CA0078.outlook.office365.com
 (2603:10b6:510:f::23) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9228.11 via Frontend Transport; Thu,
 16 Oct 2025 23:28:25 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.117.160)
 smtp.mailfrom=nvidia.com;
 dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.117.160 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.117.160; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.117.160) by
 CY4PEPF0000EE3C.mail.protection.outlook.com (10.167.242.13) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9228.7 via Frontend Transport; Thu, 16 Oct 2025 23:28:37 +0000
Received: from rnnvmail205.nvidia.com (10.129.68.10) by mail.nvidia.com
 (10.129.200.66) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.34; Thu, 16 Oct
 2025 16:28:19 -0700
Received: from rnnvmail204.nvidia.com (10.129.68.6) by rnnvmail205.nvidia.com
 (10.129.68.10) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.20; Thu, 16 Oct
 2025 16:28:18 -0700
Received: from Asurada-Nvidia (10.127.8.12) by mail.nvidia.com (10.129.68.6)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.20 via Frontend
 Transport; Thu, 16 Oct 2025 16:28:17 -0700
Date: Thu, 16 Oct 2025 16:28:16 -0700
From: Nicolin Chen <nicolinc@nvidia.com>
To: Shameer Kolothum <skolothumtho@nvidia.com>
CC: <qemu-arm@nongnu.org>, <qemu-devel@nongnu.org>, <eric.auger@redhat.com>,
 <peter.maydell@linaro.org>, <jgg@nvidia.com>, <ddutile@redhat.com>,
 <berrange@redhat.com>, <nathanc@nvidia.com>, <mochs@nvidia.com>,
 <smostafa@google.com>, <wangzhou1@hisilicon.com>, <jiangkunkun@huawei.com>,
 <jonathan.cameron@huawei.com>, <zhangfei.gao@linaro.org>,
 <zhenzhong.duan@intel.com>, <yi.l.liu@intel.com>, <shameerkolothum@gmail.com>
Subject: Re: [PATCH v4 12/27] hw/arm/smmuv3-accel: Make use of
 get_msi_address_space() callback
Message-ID: <aPF/kIPkKtLgm4jg@Asurada-Nvidia>
References: <20250929133643.38961-1-skolothumtho@nvidia.com>
 <20250929133643.38961-13-skolothumtho@nvidia.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <20250929133643.38961-13-skolothumtho@nvidia.com>
X-NV-OnPremToCloud: ExternallySecured
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CY4PEPF0000EE3C:EE_|IA1PR12MB6116:EE_
X-MS-Office365-Filtering-Correlation-Id: f3595c9c-a17f-4b17-e235-08de0d0bbb7b
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|1800799024|82310400026|36860700013|376014|7416014; 
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?DcVOmTBKd0kEQVV/+t3eqF4FEZNG06NYPpbARd731DZn3qB/lPGARtICkEEh?=
 =?us-ascii?Q?xp65i7TNvu8w7pq4+rEQ9kHuLUWhRfe7tPcqWmRpu91kaV5uj85GV6DYuL8P?=
 =?us-ascii?Q?rLKE/8wNdkHdGxR3rVvK2pjajftWAk1JTCOl2/3lQ3uk4f1Wp2HRSfuFlwln?=
 =?us-ascii?Q?J/eugRLTTqQr7xFaJ0OyrmK3CDrH/H/mhNCUNeK6cgYQNhiSaoiMCA5YRaYe?=
 =?us-ascii?Q?dS68e1Y5P8g5cBkS1H0/EVsIx/wnW0ErViNqfzXnhqjFKFxu1C0dpMiBKkNr?=
 =?us-ascii?Q?rsWlWiSy72e+U7D7dRo971Y9W8P6LM4RNEIG2bZRkSufFw22DHslCFqprmOD?=
 =?us-ascii?Q?qjrDHrzFKxzJVTPJsW3xfz6+mpU9qhRY8y1QwbhUHJEMmPjJwnS5lXiuoz1K?=
 =?us-ascii?Q?p7SfXBNjCo/GcP1BWmeokCssZV/kwOmRdL9ZjQRKOLurvzxue8QkIsYTflqD?=
 =?us-ascii?Q?FC04NwSmt0n2Lujo/vLdPrT4dhsjm3x1NHRvlQxTg5qRHo+uqmEnyTh2dA7o?=
 =?us-ascii?Q?slv1w/qsdSeuRzxgS3LTG/Y/ifweVIjeRX/km18pC1fiaMgr1RE8lL1FhVvj?=
 =?us-ascii?Q?A6SBHMklVNA/cG619CVbFC9twcneRhs7vjaDIgV/zA2KV62lo9CHRGABJ+Gu?=
 =?us-ascii?Q?4egIDVQzPanfTu8wDk1QKVPltLuX3mbCJEXrzy4HD653XmVMC2OIKlKvP+C8?=
 =?us-ascii?Q?TRIi5BspDjKbDjZxzUQacB0arg8DYWL+FH6nQu1MHXnC4OKptgfdaM8O45Mz?=
 =?us-ascii?Q?AelAltWljOOWfHNjEDkuD571UWgO/GVtsSiTHqJ+Q+MkxVn19H5kTSZqIu/o?=
 =?us-ascii?Q?8cz21rOmrMt5HIEuszkg+y3dJuBqUJVCgnXOJiEC6YZnyTDnX2f835/lrTxp?=
 =?us-ascii?Q?c2ijkKbs/Ni7U9j8EjwmtGkUxuxN/zVsbZnWER+6tNzfnXqZVzjpRVQuWTrA?=
 =?us-ascii?Q?5JRJ8A3brujvVWTL8bYCYcY5+mhxEQLKRCV9aGNapo3OPNOALxMqp1OUDO0H?=
 =?us-ascii?Q?WxMcNWEyqXOtVBljcCwNLmksXtE/0CvAHLkE6pIeTnvfYv0Dfyn99EqD6nQd?=
 =?us-ascii?Q?aC3WXIC52X3//dHP2iQSBzJTA1Px0OZdMZMCcVxTf8K8lq/Czm00Bbvxsst0?=
 =?us-ascii?Q?x0wF/cj001Y9ctIvqOcjMixxAOOijxEhunUO0bK0n/eS8zv71loxQ9g/fmVM?=
 =?us-ascii?Q?Rt8+da6Qc9YjoiJqTF1ioWm0xyzjvERM0aOysKv1BrGQg7MlqC8YqUbiSgoS?=
 =?us-ascii?Q?y0awo9vjx+oLKbl8PqFqilqFuGQMuc8Ahiq6qep9HZYcN0AAoqryOumcMlOC?=
 =?us-ascii?Q?+7EUg82nLG5zaiHhZkRY0eWez10ySlKEXkpQBbs9zHflmTXZpMrGWYhYQe7o?=
 =?us-ascii?Q?HoQpeY2j4UPYRaPwRXFYZUlyBWYTsuiU4vGUkEK8YJiInWwVd29pC4wsiNMI?=
 =?us-ascii?Q?7n98s1VpHb7t42exrVvZ1LMHiXMDdwuIeSgFcaEAi5GG06qi2RBH/v5I5Cek?=
 =?us-ascii?Q?hK8f89jkovgiHuWTZc6daWHxsUQ0Abv1rGb7K2KtZYkOw54uQFYxtqQJ1yxn?=
 =?us-ascii?Q?ypN9kpzZO3Lp0KypIjQ=3D?=
X-Forefront-Antispam-Report: CIP:216.228.117.160; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:mail.nvidia.com; PTR:dc6edge1.nvidia.com; CAT:NONE;
 SFS:(13230040)(1800799024)(82310400026)(36860700013)(376014)(7416014); DIR:OUT;
 SFP:1101; 
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 16 Oct 2025 23:28:37.3139 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: f3595c9c-a17f-4b17-e235-08de0d0bbb7b
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a; Ip=[216.228.117.160];
 Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource: CY4PEPF0000EE3C.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA1PR12MB6116
Received-SPF: permerror client-ip=2a01:111:f403:c105::1;
 envelope-from=nicolinc@nvidia.com;
 helo=CH1PR05CU001.outbound.protection.outlook.com
X-Spam_score_int: -10
X-Spam_score: -1.1
X-Spam_bar: -
X-Spam_report: (-1.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 FORGED_SPF_HELO=1, SPF_HELO_PASS=-0.001,
 SPF_NONE=0.001 autolearn=no autolearn_force=no
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

On Mon, Sep 29, 2025 at 02:36:28PM +0100, Shameer Kolothum wrote:
> Here we return the IOMMU address space if the device has S1 translation
> enabled by Guest. Otherwise return system address space.
> 
> Signed-off-by: Shameer Kolothum <shameerali.kolothum.thodi@huawei.com>
> Signed-off-by: Shameer Kolothum <skolothumtho@nvidia.com>

Apart from the naming that Jonathan pointed out,
 
Reviewed-by: Nicolin Chen <nicolinc@nvidia.com>

