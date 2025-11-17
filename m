Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 55EC5CE8D6B
	for <qemu-devel@archiver.kernel.org>; Mon, 17 Nov 2025 16:09:30 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vL1mg-0005BC-40; Mon, 17 Nov 2025 11:08:54 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <Edgar.Iglesias@amd.com>)
 id 1vL1lT-0004lJ-80; Mon, 17 Nov 2025 11:07:46 -0500
Received: from mail-eastusazlp17011000f.outbound.protection.outlook.com
 ([2a01:111:f403:c100::f] helo=BL2PR02CU003.outbound.protection.outlook.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <Edgar.Iglesias@amd.com>)
 id 1vL1lM-0002rg-JK; Mon, 17 Nov 2025 11:07:35 -0500
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=g/brpE0zs0XrtM6wmy4FhOJ9qqsuOFEl+y9MzjUxxoctHG6E994ZHr8A72jUVPxT0ewXNrrikZzOCnkevRE0K1q8+yn5PLAZ9TrT0XfgNV2Y475gycqCgT/MtNn6HOCHglBIr3L9sxlaUYuiGobHFu2TSBCc7w2VtzoMRcOwoU8F7ECqJiwOCoZwvau97U0E1nXwbUX02EI1uFwVud/e15hER/I/STQbqcnF+niTS04mlk0DT6fwIASZNCYCbISJ9eV+YHgITQVxuNMXEm8risLQIysNOx/OAhRDvkRFgubdtM3op68BZwU9hZz1c2hymQaIinZL/AtjkiuqfY6RHw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=zUbIZBGtv9kmPmGwaHNpgl27hfBStNSLg1jFvodEUQE=;
 b=Y15aur3wQJ357azr36s/SB95Q/HXGnfoBDlUP7gYjiuVoWiHQyYkQV2ojtyrZXuKaFIYIYp9cvxJJsC9mSVqr6z4d4jC0z0RJvsDLkZZeAXQpd0Ci//KbiUyEFhpBzNLFiMJq87RhkeIcRbhpVVwq/358hO1OZG/ZuD7jr2sEBM1R0feXf7rFZMIs0qZ13y0uobNWlZyOlKNBPmJZIOrhoCW0OIiqzPOoVLAcosdiCGSzl4fDfLyNi4+VIlG0Ujqs9HRa6emlSvRoVVDFrnVYSoCCjmu58Km56KVQ+oA0Not0CORCGBlYBcep9jiKmvrlgCc7NVnSOpBACYkISANhw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=linaro.org smtp.mailfrom=amd.com; dmarc=pass
 (p=quarantine sp=quarantine pct=100) action=none header.from=amd.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=zUbIZBGtv9kmPmGwaHNpgl27hfBStNSLg1jFvodEUQE=;
 b=0+hmxDQtA4VBKm+rsF8WrE/ZnOgZ8gFJ16xH8UvVCbisRUR+Apui/6M6wOBo0xxOThQVLyF5sFIIr8XTXQ4ATMaEMfD55Lxb80lf7zgYmBjZfeQLHykwWQ4PWuCr2T9AioIQPPj2unyBShOQ3KT4+ZPWJqFiyT28eUS+MOBVQrU=
Received: from MN2PR03CA0006.namprd03.prod.outlook.com (2603:10b6:208:23a::11)
 by MN2PR12MB4422.namprd12.prod.outlook.com (2603:10b6:208:265::9)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9320.19; Mon, 17 Nov
 2025 16:07:24 +0000
Received: from BL6PEPF0001AB4D.namprd04.prod.outlook.com
 (2603:10b6:208:23a:cafe::10) by MN2PR03CA0006.outlook.office365.com
 (2603:10b6:208:23a::11) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9320.22 via Frontend Transport; Mon,
 17 Nov 2025 16:07:22 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb07.amd.com; pr=C
Received: from satlexmb07.amd.com (165.204.84.17) by
 BL6PEPF0001AB4D.mail.protection.outlook.com (10.167.242.71) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9343.9 via Frontend Transport; Mon, 17 Nov 2025 16:07:22 +0000
Received: from localhost (10.180.168.240) by satlexmb07.amd.com
 (10.181.42.216) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.17; Mon, 17 Nov
 2025 08:07:21 -0800
Date: Mon, 17 Nov 2025 17:07:15 +0100
To: Philippe =?iso-8859-1?Q?Mathieu-Daud=E9?= <philmd@linaro.org>
CC: <qemu-devel@nongnu.org>, Peter Maydell <peter.maydell@linaro.org>, Stefano
 Stabellini <sstabellini@kernel.org>, Paul Durrant <paul@xen.org>, Anthony
 PERARD <anthony@xenproject.org>, "Edgar E . Iglesias"
 <edgar.iglesias@gmail.com>, <qemu-arm@nongnu.org>
Subject: Re: [PATCH-for-10.2] hw/arm: Re-enable xenpvh machine in
 qemu-system-arm/aarch64 binaries
Message-ID: <aRtIM6H6IAdiKv1v@zapote>
References: <20251117091253.56009-1-philmd@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20251117091253.56009-1-philmd@linaro.org>
User-Agent: Mutt/2.2.14+84 (2efcabc4) (2025-03-23)
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: satlexmb08.amd.com (10.181.42.217) To satlexmb07.amd.com
 (10.181.42.216)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BL6PEPF0001AB4D:EE_|MN2PR12MB4422:EE_
X-MS-Office365-Filtering-Correlation-Id: 53a2b103-8d7d-4aef-8685-08de25f36453
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|376014|1800799024|36860700013|82310400026|7053199007; 
X-Microsoft-Antispam-Message-Info: =?iso-8859-1?Q?XstHxFwB63elTXLvTSvPcNJ5RBk7J3MXGl1B9ckg0Cbl9TIvuohyrtf2+3?=
 =?iso-8859-1?Q?6eIia5hCH9KsDJaxcSmRwXXLrTw4mcoQE1XOtc2kseWC2uUAzxwSy93gpy?=
 =?iso-8859-1?Q?ycSUHnsB9mOH6N1VZk4zG8OPg74RM4+UoEeowAi0KzTFgxRsBYKXjfNwRk?=
 =?iso-8859-1?Q?jWzsoLBGriUQwaSgJ5i4EWgxPJ9NlKXrEN/om2a7LOJQfMXCgt9MnORnnV?=
 =?iso-8859-1?Q?dq+u5m1w7RlKCrb++qwyeF5s3YSK0LrFdq8obGlK/oKBolNKxRb4M7A0dY?=
 =?iso-8859-1?Q?aikD5NvZQl3mBy/dTn3gQd6+av6iBXZ2ifqxsLRjcMtygScEnpHnb+w05o?=
 =?iso-8859-1?Q?g8bSa+5rIKwXXLQbnduVI49OMuYbV4UgczWOFUopGjR5abCBdTGd/lasnE?=
 =?iso-8859-1?Q?0Ox6Y6soCGExXwwLFifOQkdXodxVwBpyOo8nBi/k7K/7nn2PKB5n/7ejm8?=
 =?iso-8859-1?Q?gWkoXvDJQQB4CJUa+jezGbuybg5CcIQHJtQUDOkoYzXg+TZfWdoJ5giqDD?=
 =?iso-8859-1?Q?U6V9kZy1IZO4i5VDFsJXCgNJ2Z89xMWijhzWDy19mp6bJXBeyByhSIPNxJ?=
 =?iso-8859-1?Q?/VRhUB8QIKzH/DXGac+CFa8P4j1lQxPS0URBWmNfQKiTooYazvTwlybQg8?=
 =?iso-8859-1?Q?XhSM3yzaXwbidp3aXFwxB9DXOBxMD6dDOMI4T+79M+2z31Gv5UqEOsgMrD?=
 =?iso-8859-1?Q?jv10SRC4Z3Sd220mw2SNrnneywUZQqlNwz3FRzFfyX1jrmwIqEUFffd0sd?=
 =?iso-8859-1?Q?Y9jJJ4/RBcFbLSwfhTpmFpMa03J35of680Ptbj8pVjZ/VEqdZpwphXiARo?=
 =?iso-8859-1?Q?9L22H6H5XSOy/ksD2niCrX4LB+PSDWguuueANuNLVHyN4XNdCughJJ78xb?=
 =?iso-8859-1?Q?wv7ZF46yCslOUkfRzr0YmB8plJ4+kiUcPzxnrvW2YFYIwIIogrmmT0Yag6?=
 =?iso-8859-1?Q?B5vv1y2MgaVSKFPvKXQuiFbQO3vootnKVr6R/ElhqDRts2zstf4Dam/cxs?=
 =?iso-8859-1?Q?SOYAjPKLTxlubNyG23qakYS6PxC81Tem4YZJz3SKc1H6VfB/rHHIqFxg2P?=
 =?iso-8859-1?Q?OlyOzhzY7HPIbpUlr4hQ46BHG7MGt8/C3E8iiEuEJuwaAk2fIe97mk3t82?=
 =?iso-8859-1?Q?zBL91j0qXP7YBOqhDXfcoeGLxUJBzLu3U5pohbzfhfB/t2Km43t4BpCW9G?=
 =?iso-8859-1?Q?sG8HWjwJKVvchc4j8qRVI7V4c/LAE90IoWFcgDc0ftNblwcQy7GE3iCHjd?=
 =?iso-8859-1?Q?TfgNCn6Qd2T+T+8SyN1B6EpHOeVHYbPWvAzRQj/uNjD1y2D7ALMr1cn5fr?=
 =?iso-8859-1?Q?hVQXYVubQSETmlHyvr97zQojBI5jxyhQzQ5N91cnpT/9AoW9Hl0usFciyl?=
 =?iso-8859-1?Q?63wns93AFBVXZdP1nHIUKwozMZFyO835fibpoR6X3rq8fTL6gVuxui0By+?=
 =?iso-8859-1?Q?cUeJjfdH+ba52LUIqJkc3ejRbc9CWG1ZFddoiPuY/QDT6xmHxqnJRQOXzs?=
 =?iso-8859-1?Q?1dqlBq7jDSGEABIKUgJgzTwxqe9vVjj4DtwO1K5Weiqz/0OabTae7hPOUv?=
 =?iso-8859-1?Q?xySx1UFY6wrckJt1A/8sITkzM6N8KjpjWdM5DPQ2gx17EMSk9BVqne2W+N?=
 =?iso-8859-1?Q?ZULmNR1HaHPJQ=3D?=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:satlexmb07.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(376014)(1800799024)(36860700013)(82310400026)(7053199007);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 17 Nov 2025 16:07:22.3304 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 53a2b103-8d7d-4aef-8685-08de25f36453
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[satlexmb07.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: BL6PEPF0001AB4D.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN2PR12MB4422
Received-SPF: permerror client-ip=2a01:111:f403:c100::f;
 envelope-from=Edgar.Iglesias@amd.com;
 helo=BL2PR02CU003.outbound.protection.outlook.com
X-Spam_score_int: -16
X-Spam_score: -1.7
X-Spam_bar: -
X-Spam_report: (-1.7 / 5.0 requ) BAYES_00=-1.9, DKIM_INVALID=0.1,
 DKIM_SIGNED=0.1, SPF_HELO_PASS=-0.001,
 SPF_PASS=-0.001 autolearn=no autolearn_force=no
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
Reply-to:  "Edgar E. Iglesias" <edgar.iglesias@amd.com>
From:  "Edgar E. Iglesias" via <qemu-devel@nongnu.org>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org

On Mon, Nov 17, 2025 at 10:12:53AM +0100, Philippe Mathieu-Daudé wrote:
> While registering the ARM/Aarch64 machine interfaces
> in commit 38c5ab40031 ("hw/arm: Filter machine types
> for qemu-system-arm/aarch64 binaries"), we missed the
> XenPV machine. Correct that.
> 
> Reported-by: Edgar E. Iglesias <edgar.iglesias@amd.com>
> Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
> Tested-by: Edgar E. Iglesias <edgar.iglesias@amd.com>

Reviewed-by: Edgar E. Iglesias <edgar.iglesias@amd.com>




> ---
> 1/ Review got likely unnoticed by Xen folks because no
>    Xen-specific entry in MAINTAINERS:
> 
>    $ ./scripts/get_maintainer.pl -f hw/arm/xen-pvh.c
>    Peter Maydell <peter.maydell@linaro.org> (maintainer:ARM TCG CPUs)
>    qemu-arm@nongnu.org (open list:ARM TCG CPUs)
>    qemu-devel@nongnu.org (open list:All patches CC here)
> 
> 2/ Should we restrict it to aa64 only?
> ---
>  hw/arm/xen-pvh.c | 2 ++
>  1 file changed, 2 insertions(+)
> 
> diff --git a/hw/arm/xen-pvh.c b/hw/arm/xen-pvh.c
> index 1a9eeb01c8e..86a02966161 100644
> --- a/hw/arm/xen-pvh.c
> +++ b/hw/arm/xen-pvh.c
> @@ -10,6 +10,7 @@
>  #include "hw/boards.h"
>  #include "system/system.h"
>  #include "hw/xen/xen-pvh-common.h"
> +#include "hw/arm/machines-qom.h"
>  
>  #define TYPE_XEN_ARM  MACHINE_TYPE_NAME("xenpvh")
>  
> @@ -95,6 +96,7 @@ static const TypeInfo xen_arm_machine_type = {
>      .class_init = xen_arm_machine_class_init,
>      .instance_size = sizeof(XenPVHMachineState),
>      .instance_init = xen_arm_instance_init,
> +    .interfaces = arm_aarch64_machine_interfaces,
>  };
>  
>  static void xen_arm_machine_register_types(void)
> -- 
> 2.51.0
> 

