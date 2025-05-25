Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 02362C54F30
	for <qemu-devel@archiver.kernel.org>; Sun, 25 May 2025 19:35:32 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uJH7n-000704-BU; Sun, 25 May 2025 15:35:11 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <Edgar.Iglesias@amd.com>)
 id 1uJH7e-0006rm-0p
 for qemu-devel@nongnu.org; Sun, 25 May 2025 15:35:04 -0400
Received: from mail-bn8nam12on2061b.outbound.protection.outlook.com
 ([2a01:111:f403:2418::61b]
 helo=NAM12-BN8-obe.outbound.protection.outlook.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <Edgar.Iglesias@amd.com>)
 id 1uJH7b-0008Cn-AG
 for qemu-devel@nongnu.org; Sun, 25 May 2025 15:35:01 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=H8AazrCfqNtiqQFGX/sQkCeRO1uqT/+FTGQsPtsCRawZdVRtSOTcDY6N0tbaPmq+fNj1KuUXiFCHfjaq42rosnXnJ3W4jvN8RYFfLZfc/A25Vj3jsCee/cARVW96U+W8gYUsjod8ZjsqLQXND+2VekJnGf3Zq/2f3GoM63tEyqvrtc8JKDTsLd8qFEgv7z2Du9RdniLRZDNI7x7IMCOJhdABQN7xJTnCR4I8PMHDwjavJZPo7DWKa1i84PruNA09YjcJQOVhyYKPYlRxE1fv/jJAMaEwr3ekYOoPdz6e/99dBXSKE0j+eiHtLnHkkV1UEhZUUOMNDTCT/OmJMD3Z6g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=294EWNf0ookZs9YpdbK1imKYHtjvrEtdRti+37LL5yA=;
 b=d2ruc0P/E6zuMjG/s0peO4ucCyneVR6cEqZsK7BmVjIqWD1aySnTydsqBII7HLoTjx3oAuyUkvhCJquitkoZxqlzP70ocOnwHwXVls3VZUdlcHEDm01wPt/vG09ryBpD99KPDWMZtk6uDSKCczXBtTsDbcfNc3tPqBuXucA5LOBS/ulG6YbZpN/YOx2iEplR7dQEjfid2NFMrsZTezmecI9pe8q07/F7kNgRHPHLrEV7kq+Pd0igI8gy6bJebdaTbH7Yht4jl2v+2wk254qmhtyr3D695kM0qbOd6k/m+PIXzUIIwk5XxfhMNhQcA5/XPOJewYnZnFw+wk7ln9sajA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=linaro.org smtp.mailfrom=amd.com; dmarc=pass
 (p=quarantine sp=quarantine pct=100) action=none header.from=amd.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=294EWNf0ookZs9YpdbK1imKYHtjvrEtdRti+37LL5yA=;
 b=NxYCQtcZxqCVb8lLlD/9paE8/XITwdcN7Ut76zWUNL9M26F87/qbspt/FCzRJCIYlUUX7/45RswVVAYFmoQOvvc26FolVZGIKsmXvKDUvwCYyPQRkuzKkJViowgRbHydQzLKvcFjTXooJzmnEhExniOy1HW1eVcLRnrYjbEgktY=
Received: from BL6PEPF00013E0F.NAMP222.PROD.OUTLOOK.COM
 (2603:10b6:22e:400:0:1001:0:13) by SA0PR12MB4447.namprd12.prod.outlook.com
 (2603:10b6:806:9b::23) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8769.24; Sun, 25 May
 2025 19:34:53 +0000
Received: from BL6PEPF0001AB4D.namprd04.prod.outlook.com
 (2a01:111:f403:f903::4) by BL6PEPF00013E0F.outlook.office365.com
 (2603:1036:903:4::4) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.8769.18 via Frontend Transport; Sun,
 25 May 2025 19:34:52 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 BL6PEPF0001AB4D.mail.protection.outlook.com (10.167.242.71) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.8769.18 via Frontend Transport; Sun, 25 May 2025 19:34:52 +0000
Received: from localhost (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Sun, 25 May
 2025 14:34:52 -0500
Date: Sun, 25 May 2025 21:34:50 +0200
From: "Edgar E. Iglesias" <edgar.iglesias@amd.com>
To: Richard Henderson <richard.henderson@linaro.org>
CC: <qemu-devel@nongnu.org>, <edgar.iglesias@gmail.com>, <philmd@linaro.org>
Subject: Re: [PATCH v2 05/10] target/microblaze: Use uint64_t for
 CPUMBState.ear
Message-ID: <aDNw2qE8WyXnVLeh@zapote>
References: <20250525160220.222154-1-richard.henderson@linaro.org>
 <20250525160220.222154-6-richard.henderson@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <20250525160220.222154-6-richard.henderson@linaro.org>
User-Agent: Mutt/2.2.14+84 (2efcabc4) (2025-03-23)
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB04.amd.com (10.181.40.145) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BL6PEPF0001AB4D:EE_|SA0PR12MB4447:EE_
X-MS-Office365-Filtering-Correlation-Id: 9df54230-c74e-420b-7b7e-08dd9bc338a6
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|376014|82310400026|36860700013|1800799024|7053199007; 
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?U4br2MI1fj5gG0VWKICBMRBBLN0kZIEvCdGgryaDSo0MwtNMsocf2h+UmP/4?=
 =?us-ascii?Q?3/3pzi247Mf9VH7zF8CpMj+yoPLc5DJpdBP8FJz6pcm8UBXhtX+/Vq6qc1W3?=
 =?us-ascii?Q?7pgPBMgRky2S5rcG7s7PUFIAaaRypzbGj/5/Kt5Na959JjNqod2vYJEYQf53?=
 =?us-ascii?Q?s2rwHdpGQDt5FCnfsq7ZFOL3JyU1e65L2puhl1C3uaKVaEma+izsS5IFEO4U?=
 =?us-ascii?Q?aCanh2tCf+RCV3vBtmtdZDPElCLnbIqzANzpFn/3R7NLgwvB/RI5q2MEMret?=
 =?us-ascii?Q?rF9sML+bo3UG9P2aFfd4/TQJYoloQNx6Dhc0w4eeaGowExH5SmKlL9wWh7PC?=
 =?us-ascii?Q?MIONux3DB9adraJdEWVp1hqbc7x/mEAWES+KcCRo+cinoGNU9bM3MoVTzaob?=
 =?us-ascii?Q?2XMj7nt2DieuF2Hj3EVYKH6qmqRbMpU7e3F5wtKOeO1bz5AQpEicRW4++hnu?=
 =?us-ascii?Q?mvEg3EPohMYJodyxcuCo2Y01HEzbx1TVYSvuQTZxI6cwNffePjqFxoc6/Clw?=
 =?us-ascii?Q?V6FmPpk1rWd7sapylLMOKDsl4tOSXO4vaBeAMP3VPoUVH4yH7Vehdw3Zm3nO?=
 =?us-ascii?Q?vRpqQ8EhXCKkh9faxICae/HvQYJKzx8Xz9TZO9bn99eeJPBo5A76Eet6vmqb?=
 =?us-ascii?Q?fEKRD/e/NRJL2iXtRgzsibi2DRsfUpJgdD/kmLE0KSsMAMTIz9p+X3Nsb9l6?=
 =?us-ascii?Q?aDCvWau+j7PG/ZUvuV0LDLcNqYq7szi4jVu/K6ZcWdPZTFR39swF68kMyLq4?=
 =?us-ascii?Q?b+H63V2yX1kjBS71KRM8wNN+KLvWPEV+z6zl7HmSX8k+ObZkTaHEfoS3ljs9?=
 =?us-ascii?Q?bmB/e0GHcFMaGfwx5UArMwOjUyBfbzvmzweUqeh8788D1CQ8krR9nwnW8AwE?=
 =?us-ascii?Q?VsjzPXenwA1yZWwC0i+6iqfarCJ+W8g5fOd+J97guBh2hZdiaj/eKax6V0Z6?=
 =?us-ascii?Q?6szLBXBfKuYUgEoJcGr+pPFsI26A4e4q69xody0HY9CxBzBK5LsUlUgW7aYt?=
 =?us-ascii?Q?j+fgB9wbzsbDSGUNf2RGX1ZCTOpdOOF2X75grZSjj2Lj9Ywfsqzb6ZIpTRPM?=
 =?us-ascii?Q?Zq8hdDvH3yUYrCjfZv8Vja4FI9sY/jePH/J9vS88IXDmWVFHbyFVtl6Cl9Ex?=
 =?us-ascii?Q?tuVN52R54KxtQPV04PZkDiDg///D+7hSUE17vGaV9P5lahYBiCYk3gKn0uTi?=
 =?us-ascii?Q?avz/LhBXIxqzARvYYffvf3PMCOCUaca2+dIPAuNVDiwpYjuA7vEiRIWirOs6?=
 =?us-ascii?Q?6B1K8OO4OMtTG1crZd5xh3eqlxTodh1v75fghXQaCuAstTTzFoYTIK92VNOl?=
 =?us-ascii?Q?1LcyfRRVFkeml7xu5A5Cz0A2AGfdA1HRAZdgpkntTctDLDQROgghGsx7pB+j?=
 =?us-ascii?Q?H+wvF1UnlSuom7D9Ahvm1TSjzvEUU4JcrDs7Hi2t6FuZuKNeGfkjimof1ANw?=
 =?us-ascii?Q?3W5r9oM/blGI21e4C1X6QBGkf2nUrA1nqgM2vGVF5HFfDMJQ19ULjN3ec+JR?=
 =?us-ascii?Q?Fry1XDaNIo9FAlsf24+1EnvaqWzXorxVaRE1?=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(376014)(82310400026)(36860700013)(1800799024)(7053199007);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 25 May 2025 19:34:52.7411 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 9df54230-c74e-420b-7b7e-08dd9bc338a6
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: BL6PEPF0001AB4D.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA0PR12MB4447
Received-SPF: permerror client-ip=2a01:111:f403:2418::61b;
 envelope-from=Edgar.Iglesias@amd.com;
 helo=NAM12-BN8-obe.outbound.protection.outlook.com
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

On Sun, May 25, 2025 at 05:02:15PM +0100, Richard Henderson wrote:
> Use an explicit 64-bit type for EAR.

Reviewed-by: Edgar E. Iglesias <edgar.iglesias@amd.com>


> 
> Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
> ---
>  target/microblaze/cpu.h       | 2 +-
>  target/microblaze/translate.c | 2 +-
>  2 files changed, 2 insertions(+), 2 deletions(-)
> 
> diff --git a/target/microblaze/cpu.h b/target/microblaze/cpu.h
> index 6ad8643f2e..3ce28b302f 100644
> --- a/target/microblaze/cpu.h
> +++ b/target/microblaze/cpu.h
> @@ -248,7 +248,7 @@ struct CPUArchState {
>      uint32_t pc;
>      uint32_t msr;    /* All bits of MSR except MSR[C] and MSR[CC] */
>      uint32_t msr_c;  /* MSR[C], in low bit; other bits must be 0 */
> -    target_ulong ear;
> +    uint64_t ear;
>      uint32_t esr;
>      uint32_t fsr;
>      uint32_t btr;
> diff --git a/target/microblaze/translate.c b/target/microblaze/translate.c
> index 3d9756391e..b1fc9e5624 100644
> --- a/target/microblaze/translate.c
> +++ b/target/microblaze/translate.c
> @@ -1857,7 +1857,7 @@ void mb_cpu_dump_state(CPUState *cs, FILE *f, int flags)
>      }
>  
>      qemu_fprintf(f, "\nesr=0x%04x fsr=0x%02x btr=0x%08x edr=0x%x\n"
> -                 "ear=0x" TARGET_FMT_lx " slr=0x%x shr=0x%x\n",
> +                 "ear=0x%" PRIx64 " slr=0x%x shr=0x%x\n",
>                   env->esr, env->fsr, env->btr, env->edr,
>                   env->ear, env->slr, env->shr);
>  
> -- 
> 2.43.0
> 

