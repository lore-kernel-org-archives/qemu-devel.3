Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5C8AEC54F30
	for <qemu-devel@archiver.kernel.org>; Sun, 25 May 2025 19:27:59 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uJH0E-0003y9-BO; Sun, 25 May 2025 15:27:22 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <Edgar.Iglesias@amd.com>)
 id 1uJH0C-0003xt-Kf
 for qemu-devel@nongnu.org; Sun, 25 May 2025 15:27:20 -0400
Received: from mail-dm6nam11on2062c.outbound.protection.outlook.com
 ([2a01:111:f403:2415::62c]
 helo=NAM11-DM6-obe.outbound.protection.outlook.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <Edgar.Iglesias@amd.com>)
 id 1uJH09-0007TJ-RD
 for qemu-devel@nongnu.org; Sun, 25 May 2025 15:27:20 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=lS/DmxUtHvgtRw5GEPawrUr1w8Cs0pinF8Kly6A+JOopH5O49G1GOHluK4oRFwSek/toohAP+F/B7Pl28sduAaC7/YXq7LmUyq//UXkX8nTDXpkTGZd1IJxOmaUNGlrhvNKMnVyt5xgIXLtRXzoceWWhQFejPNF/xrPYBN9Sn+hx0Pl7X9ooArgGOq/OhhgyHuVhBcLBv5tJEuXZ1k1RkSUdNEmDtXXJv75lUxEpe3z6u0mO+DPuX+LbuuDXPK/bnkDsg7Q5Gbv+2nZTqw0tA7FFQCsPJpO2NY6BB1Fjz4mjsWP12Bz1hQqanLXAmRowJkp1N7HUlQKO3td/2cehDg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=sDrUrY8gJkRO+zhyop9yhkpO7J/dJ+zTgqBK7mkDuKk=;
 b=oaFSDyi7tlNCu8xyhO+yAlnqL8scMgWkf19NkXRfblH8IbfGTJEIxUOjtRqncq8/AYeNYBz2NTONPTfAl6BKqOxqYhtY+dv5PmuJ9uibSzwlyz8nGxxZwsk6il9fqG9ib9Mkl0DwNfEeej9KKggrf+BuaX9G1kNfrKkkKf6Re3Z1wwmWjCOzQH9iy8Aa0511kKgxcmDCSskxOH8ken/c5Z3jLekHGgU11fcxjJ2NPImPd3udd0kC6NMNdfRgjr1cAfz/nb3YhccOGcGyHl5BjjrXNVW7TYDFOkvHgYClEqpkuBkxpLLnYUMA+KMicYLu0BwLaACUUEFzKSA+mfTu0g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=linaro.org smtp.mailfrom=amd.com; dmarc=pass
 (p=quarantine sp=quarantine pct=100) action=none header.from=amd.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=sDrUrY8gJkRO+zhyop9yhkpO7J/dJ+zTgqBK7mkDuKk=;
 b=qdirHvaSsuXkaFYhoqxTyFV0738yug/wZC+gqVQaABLvUdtaLBGYdHV0jdY5FrViX0sx3UeuUNCEbYspAKHK+0RNeQxXc0VMEBcLBtJP957lFvj3RnRlFOFJrDSehux0kq2sAJfXwrugijBk8C6r8GK4P6FuaCOyNHdCbpVhCf0=
Received: from BYAPR11CA0078.namprd11.prod.outlook.com (2603:10b6:a03:f4::19)
 by SA3PR12MB9199.namprd12.prod.outlook.com (2603:10b6:806:398::19)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8769.21; Sun, 25 May
 2025 19:27:11 +0000
Received: from CY4PEPF0000EE31.namprd05.prod.outlook.com
 (2603:10b6:a03:f4:cafe::1d) by BYAPR11CA0078.outlook.office365.com
 (2603:10b6:a03:f4::19) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.8746.30 via Frontend Transport; Sun,
 25 May 2025 19:27:10 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 CY4PEPF0000EE31.mail.protection.outlook.com (10.167.242.37) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.8769.18 via Frontend Transport; Sun, 25 May 2025 19:27:10 +0000
Received: from localhost (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Sun, 25 May
 2025 14:27:08 -0500
Date: Sun, 25 May 2025 21:27:02 +0200
From: "Edgar E. Iglesias" <edgar.iglesias@amd.com>
To: Richard Henderson <richard.henderson@linaro.org>
CC: <qemu-devel@nongnu.org>, <edgar.iglesias@gmail.com>, <philmd@linaro.org>
Subject: Re: [PATCH v2 02/10] target/microblaze: Introduce
 helper_unaligned_access
Message-ID: <aDNvBoLLiZBJRQVI@zapote>
References: <20250525160220.222154-1-richard.henderson@linaro.org>
 <20250525160220.222154-3-richard.henderson@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <20250525160220.222154-3-richard.henderson@linaro.org>
User-Agent: Mutt/2.2.14+84 (2efcabc4) (2025-03-23)
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB03.amd.com (10.181.40.144) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CY4PEPF0000EE31:EE_|SA3PR12MB9199:EE_
X-MS-Office365-Filtering-Correlation-Id: 2539695c-a471-4d96-c1a0-08dd9bc22519
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|36860700013|1800799024|376014|82310400026|7053199007; 
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?rkPWokkj3svOMLYMcOE+phnvEXBL51rWQQrqUW/V+jpDs5bnHGpcxVXOPmO5?=
 =?us-ascii?Q?9lNxvM7s3rm4EJy5Xsxsslzw30cHhu446pH2JiGvdBbAWepEagsUHJnEV+x4?=
 =?us-ascii?Q?i3+l/DN6SGM1sXkR276euFsQKVxBVZEhpmKXw1GcLqgzgE/TzoM4V+4kfMx7?=
 =?us-ascii?Q?wCijib9W4IvhD4e2lHcIWkamNaw3vMH1AZj3yKW/CQKzIA2i4Gg5RSMp3jXu?=
 =?us-ascii?Q?DWULVtfBn18XSVJALlM+Si6S/6bAx9mTpOreRtQB92imuVBCIEFH5V/3Y/46?=
 =?us-ascii?Q?RRzYlUp6aNAXK1DAUPgIVGd06ctjVBJDZ1V9/Or7/pmIj3Rj6UoOm4WaP/Xn?=
 =?us-ascii?Q?oR3EeDrp589C8ElYOtleLN2EUA05nNaDpBjrcXSOP87xARklnfudPx28IVe9?=
 =?us-ascii?Q?NN6VD176iyqlY922t9Bgl1uhr9DSJY9iNJC3CBUXRJh7DdVhR6LvVnOI3neN?=
 =?us-ascii?Q?o64eH1LqiuwsgQUcMqeutvrmsdotrEIBPY/MaTBQQ8b//5j1aXmnXOgEYG1o?=
 =?us-ascii?Q?R/7yK7xYDlLZbbWNWiF7zoDmm5M65tQlFUu4QAHb/CDs7w9y67Zqnm44apjX?=
 =?us-ascii?Q?qUm2a8UXLJ0oOq6hmPOan3DtSi6M/dlv7BvfRhAK1zN322FYBB83C5kn7w+3?=
 =?us-ascii?Q?ZK9vERSEj8VS2I+WGIbfGitlxxe893K/bD02Q5Sa2fDlRJHY3dr9Zz8td3PE?=
 =?us-ascii?Q?D5br9Fr6R6wdQ19YI9W1wr31EXbXvW6ZSFhHGnNBPuZTxRYCX1XFAszszDXX?=
 =?us-ascii?Q?6UlKLYuuPSjJQFoHn6MUpYzKdlMaO1gxJkACrU9mqJzXI72iJ+8P6uAKvS+c?=
 =?us-ascii?Q?hcyUsPPt1qqE3StY7WTx5O+Lp6CkvuA89u9ZGz08GOHNqsIw4+Kwqz5fesX4?=
 =?us-ascii?Q?pWMIDzpjL9DPTekINZTwnP65J1gODlmGS/b7CPuP3m2P4NDRTCRf9MRoP9IL?=
 =?us-ascii?Q?d3bwF+hUgkkSVX0VGRdExF4r14+Jue10oagVVOygIiD4zWc4oaHigQeQSz4o?=
 =?us-ascii?Q?uofHXXQ3Euh82x3mZmD16BiW46C9PWTRvgFifUKyRqIwCpidxwsyo2RwsZYj?=
 =?us-ascii?Q?LtiUQktRHBANOhyid6E036sBQh4K71UwWzKnIrtpD2GnoVXcTnbD16jCMIwW?=
 =?us-ascii?Q?BwTzy4qAq9Iz5pwM3fGPYql3+KAkR3MsnpQ7IelKaFUP0kKWq+N/oMMFB69+?=
 =?us-ascii?Q?g3/USjRTkwKneK7Gl2Lv5vGTdcuWTrhhjowQ4Zshm++pHAaqAKO/Ay0M4q3T?=
 =?us-ascii?Q?R9eKWTzoYs3+0dHnxNgs3Rh2KG7rGszNO8HZp91Cpki1Y2jNEyaZzmWInAFl?=
 =?us-ascii?Q?ugF6eBClZYGX5eSQ5QSWJYJFZs2MK+TaNyY7TcFmaeyKmREUJpoZyCcbzhrB?=
 =?us-ascii?Q?kWmJptUgwyuVmmJ+nIssul9Zu8+LJMI/H1OTndlQ5YeCeXP+4vjtd64Th9Wf?=
 =?us-ascii?Q?eYb0U1C8xRVxoDYK37yeVV+BUb1++rS/IqCVnrXAXXkN7gLgmNrvquUu9ZuH?=
 =?us-ascii?Q?4BfKQRhGw80t1HdUQGR0vAPIrxqJCK3lMkoj?=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(36860700013)(1800799024)(376014)(82310400026)(7053199007);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 25 May 2025 19:27:10.3877 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 2539695c-a471-4d96-c1a0-08dd9bc22519
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: CY4PEPF0000EE31.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA3PR12MB9199
Received-SPF: permerror client-ip=2a01:111:f403:2415::62c;
 envelope-from=Edgar.Iglesias@amd.com;
 helo=NAM11-DM6-obe.outbound.protection.outlook.com
X-Spam_score_int: -49
X-Spam_score: -5.0
X-Spam_bar: -----
X-Spam_report: (-5.0 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-2.904,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
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

On Sun, May 25, 2025 at 05:02:12PM +0100, Richard Henderson wrote:
> Signed-off-by: Richard Henderson <richard.henderson@linaro.org>

Reviewed-by: Edgar E. Iglesias <edgar.iglesias@amd.com>


> ---
>  target/microblaze/helper.h | 12 ++++++------
>  target/microblaze/helper.c |  7 +++++++
>  2 files changed, 13 insertions(+), 6 deletions(-)
> 
> diff --git a/target/microblaze/helper.h b/target/microblaze/helper.h
> index f740835fcb..41f56a5601 100644
> --- a/target/microblaze/helper.h
> +++ b/target/microblaze/helper.h
> @@ -20,12 +20,12 @@ DEF_HELPER_FLAGS_3(fcmp_ne, TCG_CALL_NO_WG, i32, env, i32, i32)
>  DEF_HELPER_FLAGS_3(fcmp_ge, TCG_CALL_NO_WG, i32, env, i32, i32)
>  
>  DEF_HELPER_FLAGS_2(pcmpbf, TCG_CALL_NO_RWG_SE, i32, i32, i32)
> -#if !defined(CONFIG_USER_ONLY)
> -DEF_HELPER_FLAGS_3(mmu_read, TCG_CALL_NO_RWG, i32, env, i32, i32)
> -DEF_HELPER_FLAGS_4(mmu_write, TCG_CALL_NO_RWG, void, env, i32, i32, i32)
> -#endif
> -
>  DEF_HELPER_FLAGS_2(stackprot, TCG_CALL_NO_WG, void, env, tl)
> -
>  DEF_HELPER_FLAGS_2(get, TCG_CALL_NO_RWG, i32, i32, i32)
>  DEF_HELPER_FLAGS_3(put, TCG_CALL_NO_RWG, void, i32, i32, i32)
> +
> +#ifndef CONFIG_USER_ONLY
> +DEF_HELPER_FLAGS_3(mmu_read, TCG_CALL_NO_RWG, i32, env, i32, i32)
> +DEF_HELPER_FLAGS_4(mmu_write, TCG_CALL_NO_RWG, void, env, i32, i32, i32)
> +DEF_HELPER_FLAGS_2(unaligned_access, TCG_CALL_NO_WG, noreturn, env, i64)
> +#endif
> diff --git a/target/microblaze/helper.c b/target/microblaze/helper.c
> index 5fe81e4b16..ef0e2f973f 100644
> --- a/target/microblaze/helper.c
> +++ b/target/microblaze/helper.c
> @@ -26,6 +26,7 @@
>  #include "exec/target_page.h"
>  #include "qemu/host-utils.h"
>  #include "exec/log.h"
> +#include "exec/helper-proto.h"
>  
>  
>  G_NORETURN
> @@ -64,6 +65,12 @@ void mb_cpu_do_unaligned_access(CPUState *cs, vaddr addr,
>  }
>  
>  #ifndef CONFIG_USER_ONLY
> +
> +void HELPER(unaligned_access)(CPUMBState *env, uint64_t addr)
> +{
> +    mb_unaligned_access_internal(env_cpu(env), addr, GETPC());
> +}
> +
>  static bool mb_cpu_access_is_secure(MicroBlazeCPU *cpu,
>                                      MMUAccessType access_type)
>  {
> -- 
> 2.43.0
> 

