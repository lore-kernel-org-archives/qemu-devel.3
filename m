Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E941ACD6E55
	for <qemu-devel@archiver.kernel.org>; Wed,  3 Jun 2026 15:11:54 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wUnFW-00068R-V3; Wed, 03 Jun 2026 11:11:18 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <sai.pavan.boddu@amd.com>)
 id 1wUnFS-00067x-SL
 for qemu-devel@nongnu.org; Wed, 03 Jun 2026 11:11:15 -0400
Received: from mail-southcentralusazon11013053.outbound.protection.outlook.com
 ([40.93.196.53] helo=SA9PR02CU001.outbound.protection.outlook.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <sai.pavan.boddu@amd.com>)
 id 1wUnFQ-0005Ht-5Y
 for qemu-devel@nongnu.org; Wed, 03 Jun 2026 11:11:14 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=Oh38i861Zj1iAGtZMxO/h5UoSLJG8e7fOx7p3KtD0M/2qZ/P8+k4tH6je0WnXqverDaJiikibRqb6hDtQA4Dw+wdbno3/1zHogpbg7HSRpiWWGRXVoVumJ8Eo5B1u0YLXflfBKz7fFAxFcr2m27e0YMx7kKAofb5cVfBVtOQn0f31yxXZDiy6Ew0GuPfWdoOR9NqctZR43YuFuHf9aAUXHEeSJWQF2w75Gp0ZBXxafDPtsE/1cDXvuRZwb7LYgsWak+pwnnKDEFUG60iEO6f5JaYkdZqUlAZFFRETgDGTtYTzjI/h2nQPCRpYv1CSSC2DKatfUZSn/EkeXXN1OhCNQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=hUSGKGLM+absbQraR8MUGrJmj6cXC+F7BmMh+WKzsGQ=;
 b=j4GHuekj7u3cWVIGGEGZJLTPHHWOMt7utxQDtbnArj0j90Dz04JY5hzBjDT2iBOEQ9OdiB8/mquM5Mg0l5vzkMVdf2zlwHdDq5rPyJLjTK4Xdy0Cp4L552RKvJmi82gGC+JuN7P8LU4dnhEeXL8y0b4+AjGNiNc07e7NaJWZnjFpxL39MoZtXlG5bwCF2kklToSINpovn9qmcKEzFTBuUZ4YV3z8E6y1y6Siuk0D9P3BmQy3WelXDKo2UbczV2BZhkb8ud9c4DQBtSGmWAT/pwLGchNy4Gi2nogQzRN7lLJJxengS6JsjP3eMgPmIgOjbS8/6BBzVE3NzGh8PBXqxQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=linaro.org smtp.mailfrom=amd.com; dmarc=pass
 (p=quarantine sp=quarantine pct=100) action=none header.from=amd.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=hUSGKGLM+absbQraR8MUGrJmj6cXC+F7BmMh+WKzsGQ=;
 b=NJ4D0nPfRy0uGe9FpGaJasRbFCRMSKidnNPdKmsE0TkLCsD0/hnat6D78r133SdXa/6IyxsBLMiS005kO0EpqAvlLY1aTL/bx6IaLL7cz08BDRyZPBDF/g8OkQb2sb25YdK1ncFFOziVSHCI4DGTtcxHCD01jr9jBqbzNbQNGP8=
Received: from BY3PR05CA0052.namprd05.prod.outlook.com (2603:10b6:a03:39b::27)
 by MW4PR12MB5627.namprd12.prod.outlook.com (2603:10b6:303:16a::8)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.92.7; Wed, 3 Jun 2026
 15:05:55 +0000
Received: from SJ5PEPF000001F1.namprd05.prod.outlook.com
 (2603:10b6:a03:39b:cafe::30) by BY3PR05CA0052.outlook.office365.com
 (2603:10b6:a03:39b::27) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.92.7 via Frontend Transport; Wed, 3
 Jun 2026 15:05:55 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb07.amd.com; pr=C
Received: from satlexmb07.amd.com (165.204.84.17) by
 SJ5PEPF000001F1.mail.protection.outlook.com (10.167.242.69) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.92.5 via Frontend Transport; Wed, 3 Jun 2026 15:05:55 +0000
Received: from satlexmb08.amd.com (10.181.42.217) by satlexmb07.amd.com
 (10.181.42.216) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.41; Wed, 3 Jun
 2026 10:05:54 -0500
Received: from xhdsaipava41 (10.180.168.240) by satlexmb08.amd.com
 (10.181.42.217) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.41 via Frontend
 Transport; Wed, 3 Jun 2026 10:05:53 -0500
Date: Wed, 3 Jun 2026 20:35:45 +0530
From: Sai Pavan Boddu <sai.pavan.boddu@amd.com>
To: Philippe =?utf-8?Q?Mathieu-Daud=C3=A9?= <philmd@linaro.org>
CC: Alistair Francis <alistair23@gmail.com>, <qemu-devel@nongnu.org>, "Michal
 Simek" <michal.simek@amd.com>, Alistair Francis <alistair.francis@wdc.com>,
 Anton Johansson <anjo@rev.ng>
Subject: Re: [PULL v2 19/39] hw/riscv: Add Microblaze V generic board
Message-ID: <aiBCycdn/2THWQrd@xhdsaipava41>
References: <20241220015441.317236-1-alistair.francis@wdc.com>
 <20241220015441.317236-20-alistair.francis@wdc.com>
 <85827a75-e224-448d-8c16-5ca9238737e5@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <85827a75-e224-448d-8c16-5ca9238737e5@linaro.org>
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SJ5PEPF000001F1:EE_|MW4PR12MB5627:EE_
X-MS-Office365-Filtering-Correlation-Id: 8ab0c46f-a142-4a51-c2e6-08dec1819c8c
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|376014|1800799024|82310400026|36860700016|56012099006|18002099003|22082099003|4143699003|11063799006|6133799003;
X-Microsoft-Antispam-Message-Info: D736hyuMLAtdNtIQc0QBQtYScQeK6kEOI1iUHkjweQtBa6AMQm5Z7tzJMfnE1H4nbEjL10COPsjbAMiBoYG7d2IScyGY1UK/s0i3JOFcGXtNIWl1lY2bro4aQ1BfripkKlzanh1Mp99TvWEKnGTqY125yUVfLm1UUduT9s7Yo3tzz3B0VG3Mq1c0t6sB0fjY7HRhBo8xy4I5re9J3R4E54E52k6Hm6zrSBOJAQC5DtCRBHsr8qK+Cs1B7xS5PxydFMleLkyDwFcS6QLF30mAC5ztdYp9OttR6Cr3Yqc85O0AxPlrmQ+DmuAo0MiiMhEVxz9EGc7hG9sMBvbpQYs9V5OWHrmzCZzKcEQNo8cvOOdLw1VRHW2q+3H6nvQjuX3d/o9+gGKqBmbwrw/Ux3VOiu1RS0cTGpF0OSO6Uj9TheU6FQTLwPlDH7xNBuvnvv47C91mqmVcvP6zCfW/ypGVcrmiC4UKZY+H5jGa2cx8JqFC11E0wdum+hk7qpiZPH9ea1IdEs3Yq7nFidBhAbBBR7Eh1oXgNJfEF3AmA/ONJJTEwpuP6s2QDXjokHJiWQUaHsu9I7O6vrWCZGQ2a12NadJPhZB4k0gH45fCxTEZ0RHK+J3LbKaVh+I3/1sp0RSApjWp4M/M+SZgSU/CVht5HNA4fiun9WDWjeaKq1wQGs/iPlVx7zq69dbwHQ+izDsxHJp88fPb5fY49pftv1Gxe0yHd6+yGv9VXAdKp3GGmBQ=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:satlexmb07.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(376014)(1800799024)(82310400026)(36860700016)(56012099006)(18002099003)(22082099003)(4143699003)(11063799006)(6133799003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: 49C3XXEUVUxh7g8EwxWAdVsWUBbmlpPP6D7mkMeE6udkPHisnW7M7RwvyNWUDFaGtp8yR6opf149BqeYeiFAaaOVcH9Ho7+uy1w7MTCcGMRwQ6++HUVhRIoHZn0ZH3Tr5kZiIbRAf3Y8ayvHOCKkg/DLciEo3ZBdhviFwhBpY1PMKkmUtcX+nx603TzuV4B4bPfJi1riyBL8RZlZETgoEtMOu3m1YUz4kvZClFHYxwT4cKkE+GLGjsygbkSXPr6zveJ23nNBlI9IP0eLaVUYgvVXr/DaU1QNTB0cQPSRCLm3skIn33TfYj/1azlleWkrvCLJVfMQ348zUPGNL/lWujc4hJRJxcp9UCF5UXgaxk4Vb75xa+qewTB4RMHJZk8LGLxEFd3OIA9QA/0gd/+aJ8RT4FF7bRUZqJvex4VAdocVmZ6GSfLV+V4TpBHTe7XB
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 03 Jun 2026 15:05:55.3902 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 8ab0c46f-a142-4a51-c2e6-08dec1819c8c
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[satlexmb07.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: SJ5PEPF000001F1.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MW4PR12MB5627
Received-SPF: permerror client-ip=40.93.196.53;
 envelope-from=sai.pavan.boddu@amd.com;
 helo=SA9PR02CU001.outbound.protection.outlook.com
X-Spam_score_int: -24
X-Spam_score: -2.5
X-Spam_bar: --
X-Spam_report: (-2.5 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.445,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H2=0.001, SPF_HELO_PASS=-0.001,
 SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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

On Tue, May 26, 2026 at 10:34:04AM +0200, Philippe Mathieu-Daudé wrote:

Hi Philippe,

> Hi Sai,
> 
> On 20/12/24 02:54, Alistair Francis wrote:
> > From: Sai Pavan Boddu <sai.pavan.boddu@amd.com>
> > 
> > Add a basic board with interrupt controller (intc), timer, serial
> > (uartlite), small memory called LMB@0 (128kB) and DDR@0x80000000
> > (configured via command line eg. -m 2g).
> > This is basic configuration which matches HW generated out of AMD Vivado
> > (design tools). But initial configuration is going beyond what it is
> > configured by default because validation should be done on other
> > configurations too. That's why wire also additional uart16500, axi
> > ethernet(with axi dma).
> > GPIOs, i2c and qspi is also listed for completeness.
> > 
> > IRQ map is: (addr)
> > 0 - timer (0x41c00000)
> > 1 - uartlite (0x40600000)
> > 2 - i2c (0x40800000)
> > 3 - qspi (0x44a00000)
> > 4 - uart16550 (0x44a10000)
> > 5 - emaclite (0x40e00000)
> > 6 - timer2 (0x41c10000)
> > 7 - axi emac (0x40c00000)
> > 8 - axi dma (0x41e00000)
> > 9 - axi dma
> > 10 - gpio (0x40000000)
> > 11 - gpio2 (0x40010000)
> > 12 - gpio3 (0x40020000)
> > 
> > Signed-off-by: Sai Pavan Boddu <sai.pavan.boddu@amd.com>
> > Signed-off-by: Michal Simek <michal.simek@amd.com>
> > Reviewed-by: Alistair Francis <alistair.francis@wdc.com>
> > Message-ID: <20241125134739.18189-1-sai.pavan.boddu@amd.com>
> > Signed-off-by: Alistair Francis <alistair.francis@wdc.com>
> > ---
> >   MAINTAINERS                                |   6 +
> >   docs/system/riscv/microblaze-v-generic.rst |  42 +++++
> >   docs/system/target-riscv.rst               |   1 +
> >   hw/riscv/microblaze-v-generic.c            | 184 +++++++++++++++++++++
> >   hw/riscv/Kconfig                           |   8 +
> >   hw/riscv/meson.build                       |   1 +
> >   6 files changed, 242 insertions(+)
> >   create mode 100644 docs/system/riscv/microblaze-v-generic.rst
> >   create mode 100644 hw/riscv/microblaze-v-generic.c
> 
> 
> > +static void mb_v_generic_machine_init(MachineClass *mc)
> > +{
> > +    mc->desc = "AMD Microblaze-V generic platform";
> > +    mc->init = mb_v_generic_init;
> > +    mc->min_cpus = 1;
> > +    mc->max_cpus = 1;
> > +    mc->default_cpu_type = TYPE_RISCV_CPU_BASE;
> 
> Could you use or provide a proper CPU type for this machine?

since MicroBlaze-V extensions are FPGA-design-time configurable,
the CPU type inherits from `DYNAMIC_CPU` to allow CLI configuration,
with sensible defaults for a typical MicroBlaze-V configuration.

We need a new type `amd-microblaze-v` that inherits from DYNAMIC_CPU,
allowing users to specify extensions via command line matching
their design (e.g., `-cpu amd-microblaze-v,m=true,c=true`).

Does that sound good? Would you like me to send a patch for it?

Regards,
Sai Pavan
>



Regards,
Sai Pavan

> 
> > +    mc->default_cpus = 1;
> > +}
> 

