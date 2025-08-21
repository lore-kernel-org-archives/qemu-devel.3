Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id CED75CA0EF8
	for <qemu-devel@archiver.kernel.org>; Thu, 21 Aug 2025 10:05:51 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1up29y-00077B-EU; Thu, 21 Aug 2025 06:04:43 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <Luc.Michel@amd.com>)
 id 1up29r-00075t-0c; Thu, 21 Aug 2025 06:04:35 -0400
Received: from mail-bn7nam10on2053.outbound.protection.outlook.com
 ([40.107.92.53] helo=NAM10-BN7-obe.outbound.protection.outlook.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <Luc.Michel@amd.com>)
 id 1up29h-0004mp-Cq; Thu, 21 Aug 2025 06:04:34 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=W0rP9GU4Y1omtH0l5XuqB563O2EvDlxgOvUH03vtDiP+DmbYjKXzJ4acZWyQ9CiSc6/SWC4vIGGh74Ot5LrXIEeXLPLK6VIsR55YbUolaTAeLT225xDiq8Ztji8nZ5BXE4T446ge2LQpzYm+7eBbjiz+Fqe6LRilrXBZmHGQt4c4IvfeOSPTUVDhm3/fkyzsbKFl6l0seDfeEkWMsrJLOpRd8RsInladnjI+JdH/Laz5bjLRQoKCW7cXr8uVMEQJTRuDxuutNrCBAw3+zD6lFUJG9WCLemk7mex9hgvRbTHIZkfgroQt5Wsot6c/3cCO0CalIjRj5/0Rkt64Z5+Qtw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=iKWC10tuHS05jKhd8Oz8Pk7ivIKvwGetZKN7uFZ8tFc=;
 b=PSwFxm+n+4g8K1QpacOUZgiTjmogfY8xCc08TJI/tu8pPMOte6a64/+wmIyppZB2lraIR1+aJjAAg0wyCTEnLb5b5XgHdzOgi0m5C+ZCtF+AO0EVkCyKJQ1mYDlg0NHzn23lwxslhui3niL6QZ4juRAkxoi241K2b05zNUpg3Wgc/SeiikB1Iq+rO4y3Dck9BPd2MChsfvMJCRYIStBgRK8LRd/ES04tBwxx9t/Mih90vOHaqcciCEFXHRc7yghQxXF4l2Cr40D/Ab0mgWYGN7MwqWOwmbnD4yfZNmqLt7/Y83jYsWcyP72b5ovbrcghIq77Vh9O/6XcdjyPqZOxFg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=linaro.org smtp.mailfrom=amd.com; dmarc=pass
 (p=quarantine sp=quarantine pct=100) action=none header.from=amd.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=iKWC10tuHS05jKhd8Oz8Pk7ivIKvwGetZKN7uFZ8tFc=;
 b=ZuW4V9Fb7w7wBLaeQSgsDhXItu+0IbTdMTX6f346zwvl+gewqfIahDn23i3xNrktxTS27pY65AzyqxIp85Ie4chO4kIaLG5Ur1ZZPqYUXslL8y/tPAUvs+4wBrjZeEw9pmUpev/0cResb9d3cyawo0GxVp0m+gRK3vl45d/lPlM=
Received: from MN2PR17CA0007.namprd17.prod.outlook.com (2603:10b6:208:15e::20)
 by SA5PPF530AE3851.namprd12.prod.outlook.com
 (2603:10b6:80f:fc04::8c9) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9031.24; Thu, 21 Aug
 2025 09:59:10 +0000
Received: from MN1PEPF0000ECDA.namprd02.prod.outlook.com
 (2603:10b6:208:15e:cafe::4f) by MN2PR17CA0007.outlook.office365.com
 (2603:10b6:208:15e::20) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9052.15 via Frontend Transport; Thu,
 21 Aug 2025 09:59:09 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB03.amd.com; pr=C
Received: from SATLEXMB03.amd.com (165.204.84.17) by
 MN1PEPF0000ECDA.mail.protection.outlook.com (10.167.242.134) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.9052.8 via Frontend Transport; Thu, 21 Aug 2025 09:59:09 +0000
Received: from SATLEXMB05.amd.com (10.181.40.146) by SATLEXMB03.amd.com
 (10.181.40.144) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Thu, 21 Aug
 2025 04:59:09 -0500
Received: from SATLEXMB04.amd.com (10.181.40.145) by SATLEXMB05.amd.com
 (10.181.40.146) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Thu, 21 Aug
 2025 04:59:08 -0500
Received: from XFR-LUMICHEL-L2.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39 via Frontend
 Transport; Thu, 21 Aug 2025 04:59:07 -0500
Date: Thu, 21 Aug 2025 11:59:07 +0200
From: Luc Michel <luc.michel@amd.com>
To: Philippe =?utf-8?Q?Mathieu-Daud=C3=A9?= <philmd@linaro.org>
CC: <qemu-devel@nongnu.org>, <qemu-arm@nongnu.org>, Peter Maydell
 <peter.maydell@linaro.org>, Francisco Iglesias <francisco.iglesias@amd.com>,
 "Edgar E . Iglesias" <edgar.iglesias@amd.com>, Alistair Francis
 <alistair@alistair23.me>, Frederic Konrad <frederic.konrad@amd.com>, "Sai
 Pavan Boddu" <sai.pavan.boddu@amd.com>
Subject: Re: [PATCH v2 21/47] hw/arm/xlnx-versal: add the mp_affinity
 property to the CPU mapping
Message-ID: <aKbt6wxvmiq8Ba8m@XFR-LUMICHEL-L2.amd.com>
References: <20250820082549.69724-1-luc.michel@amd.com>
 <20250820082549.69724-22-luc.michel@amd.com>
 <188d2482-6bbd-432d-8ec3-5864d6c821a6@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <188d2482-6bbd-432d-8ec3-5864d6c821a6@linaro.org>
Received-SPF: None (SATLEXMB05.amd.com: luc.michel@amd.com does not designate
 permitted sender hosts)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: MN1PEPF0000ECDA:EE_|SA5PPF530AE3851:EE_
X-MS-Office365-Filtering-Correlation-Id: 81e054f7-9921-4488-62b0-08dde0995fab
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|1800799024|376014|36860700013|82310400026; 
X-Microsoft-Antispam-Message-Info: =?utf-8?B?TlNJUkM3MjJyM1ZXdXhzR1g4SWtEQWZoSWhTUFJjMmVRUG1mcTZEcm5zN0Y2?=
 =?utf-8?B?QXlLNjJVOFcvZlhtaFdPNzRPcThLV0ZXZk1MQTNZRFdvQVYyOGhPOVVad2hj?=
 =?utf-8?B?aGkzTVhXM3ZhRFpVYmVGbXdRMnlPWG5OdEV0a0Y0VUZCRkQ2ME5FYVFxYlM4?=
 =?utf-8?B?RTZhajEyTUNTbm9lUUNPOFI3cjNqTDN1VzhXdHFYSEY5NXRPOTBXOEY4V2ZI?=
 =?utf-8?B?djhBSnpvMHpnWVJnOTF4SVRrTytYU3V2Y0Y5cnVmWlREVTFyZjI5bzhialUw?=
 =?utf-8?B?cDFuaU0zZWZkZEQ0QW5UbVNHQU1WNDRySitrdDQ1SWNUQ2w2b0w2VVpvcEli?=
 =?utf-8?B?YXVWWnhzTVBiNFlrTWJKZFgvUEQ3TTV1UFdCa3VvQkZ6dlhiN2hnN2NjNmJr?=
 =?utf-8?B?NzJyckhUQTRQWEdLMTJKT3owVUNQMkxBSjlkbU96RXZMcVRqRHBmNHduYldD?=
 =?utf-8?B?WHNLaDhHOG9BMkdZdmRsSjlsSGc2ZDZORHkzZEFseHJKWUU0OFM0c0o0ZnVx?=
 =?utf-8?B?dzhMSzBORzNZWlVSYnRsYTdMcDJ5V0lqeVRUOHp2YklqUVBOeTdCM1Awb0I0?=
 =?utf-8?B?NFlDZEpjVThWMG1hYkVCWVhVY2xxSWNUTTVnbytWdm5PVFdEaGJHMkJ6c1l5?=
 =?utf-8?B?MmpXbEVZeW9KQ3lJTDFMbmZpL3ViekRjQXlYYXh0ckRVd1NXeVh4Z2VtenNP?=
 =?utf-8?B?QkVWWUdpM2h6Rmk3MXZvS3lROWZJMTJoT3h6MlRGM1JzUTF0bzVNUDNtakxS?=
 =?utf-8?B?SER2SDZaeDlSQzJvTFB5UUcwb0hXTUUzQ0t3VmtTTjdxem5DZ0NSNmN3MTFs?=
 =?utf-8?B?VHV5cU5JMUYvRm1jN1FEVllhNk1oSWR3eTQvNjU0TGV6a2twSG1NZGdweUIr?=
 =?utf-8?B?NUdSdytGWmYrUHlXU3RPUUdUdGhhbzdPbVdWL1k5bVYybDM2WFNvY3Zta0g4?=
 =?utf-8?B?M1VSc3VLRC8wUDFoWlNJYUZsSHUwa3ovZTc3UmFTRytpdGQxcTI0M3FGeUd3?=
 =?utf-8?B?ZVIwKzZQZk1aT0RhTkJqWnlWK3F2UGs3d0E2SjdIUngwRndsRm1OcS9RL0t0?=
 =?utf-8?B?QXAxNGFZYW5OVElBMExoR2lnUzg0bzRSL2xpRFFCb1FCaGNZWUpaYjcwUG9n?=
 =?utf-8?B?SWt6TU9wVVBDQXl2VVR5aDRMVHZ5cm1HL01NYXgwRnl4VS9HeUJXMmZUTVVa?=
 =?utf-8?B?UWx1TVFaUkNKOEJvV0dra3ZLK2s4dlRUSlY0NG14dEVKdTZqNUFSU1RIc0du?=
 =?utf-8?B?R2hwTy9FOFFVWFB6emk4bU95TWJYRUE3T1NIYnVyK1oxcTB0OXFZbG5ra3h6?=
 =?utf-8?B?OVR3T3poRDZsdjFSZkdHSWNJSG5zMVIrY3orNnZzZ1NtdWZMNXRXeUMxUGpH?=
 =?utf-8?B?UDF0Ym9YR3poa3dta2lqNktxWHpTNUp0MThqZUdOVUxySWYxT3RoRzliL0NM?=
 =?utf-8?B?ZVJpNTE0aDd6WXRsL1ZGRUhWRGdCdFVVSXlHR0hYUlNJUzlZckhWMk5rTVBZ?=
 =?utf-8?B?dXdOalVGS1pPUHhzMHpHc1V6QVRZRzQ4QmZRVURuaGtxN3JYWDdKOCtBaXBy?=
 =?utf-8?B?V0s1VEpRa0YxdFd3ZUFvOFQ4OTNldHJ3UTdHMnRHNURJRFJud2NYVERDUVZY?=
 =?utf-8?B?OXVIVEVIV09BYUo5d002NTAxYUc2OENTQ1VudkhTYWRNQTFlRmx4RWZOc1Vk?=
 =?utf-8?B?dkwxeXNKMDVla09DV3U5SGZyZ2pRV3czTG9XTStZdDMxYXh3M2xXUWtHM1F3?=
 =?utf-8?B?Y0xLWHZ3cHh2MVBSbjhGVWlUeURHU0pUSzRzTEcxTmtCUjB6VkJQN2o0R001?=
 =?utf-8?B?VS9XbHREUUkwWlhjcUNZdzhYcGlLdzYyM2VYNkxBUHZWL1RHVUppOUsvRG9i?=
 =?utf-8?B?RFVET21FenBBTGs3UHVicG90TmkraS8reVVMb1d3TUZGcEozSGRTUWE1QXRq?=
 =?utf-8?B?ejFVNE1LamhIWWVQb0F4UlFOWVppaHdDSXh4ZEtQRkFLTm1tNFNTTDMrZWJy?=
 =?utf-8?B?T0xHdUN4OU4rL2NybFZJR1JOYmNhcHhwQUpPdTdtWVY2MTJkVStqelp0Vjh2?=
 =?utf-8?Q?bdzdzZ?=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB03.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(1800799024)(376014)(36860700013)(82310400026); DIR:OUT;
 SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 21 Aug 2025 09:59:09.5729 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 81e054f7-9921-4488-62b0-08dde0995fab
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB03.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: MN1PEPF0000ECDA.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA5PPF530AE3851
Received-SPF: permerror client-ip=40.107.92.53;
 envelope-from=Luc.Michel@amd.com;
 helo=NAM10-BN7-obe.outbound.protection.outlook.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
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

On 14:18 Wed 20 Aug     , Philippe Mathieu-Daudé wrote:
> Hi Luc,
> 
> On 20/8/25 10:25, Luc Michel wrote:
> > Add a way to configure the MP affinity value of the CPUs given their
> > core and cluster IDs. For the Versal APU CPUs, the MP affinity value is
> > directly given by the core ID.
> > 
> > Signed-off-by: Luc Michel <luc.michel@amd.com>
> > Reviewed-by: Francisco Iglesias <francisco.iglesias@amd.com>
> > ---
> >   hw/arm/xlnx-versal.c | 21 +++++++++++++++++++++
> >   1 file changed, 21 insertions(+)
> > 
> > diff --git a/hw/arm/xlnx-versal.c b/hw/arm/xlnx-versal.c
> > index 5a08ad07b28..35c32de0159 100644
> > --- a/hw/arm/xlnx-versal.c
> > +++ b/hw/arm/xlnx-versal.c
> > @@ -88,10 +88,18 @@ typedef struct VersalCpuClusterMap {
> >       size_t num_core;
> >       size_t num_cluster;
> >       uint32_t qemu_cluster_id;
> >       bool dtb_expose;
> > 
> > +    struct {
> > +        uint64_t base;
> > +        uint64_t core_mask;
> > +        uint64_t core_shift;
> > +        uint64_t cluster_mask;
> > +        uint64_t cluster_shift;
> > +    } mp_affinity;
> 
> 
> > @@ -565,23 +578,31 @@ static DeviceState *versal_create_cpu(Versal *s,
> >                                         size_t core_idx)
> >   {
> >       DeviceState *cpu = qdev_new(map->cpu_model);
> >       ARMCPU *arm_cpu = ARM_CPU(cpu);
> >       Object *obj = OBJECT(cpu);
> > +    uint64_t affinity;
> >       bool start_off;
> >       size_t idx = cluster_idx * map->num_core + core_idx;
> >       g_autofree char *name;
> >       g_autofree char *node = NULL;
> > 
> > +    affinity = map->mp_affinity.base;
> > +    affinity |= (cluster_idx & map->mp_affinity.cluster_mask)
> > +        << map->mp_affinity.cluster_shift;
> > +    affinity |= (core_idx & map->mp_affinity.core_mask)
> > +        << map->mp_affinity.core_shift;
> 
> Could we expand/re-use arm_build_mp_affinity() here?

I'm not sure:
   - versal RPU hardcodes Aff1 to 1,
   - versal2 APU uses Aff2 for cluster id and Aff1 for core id,
   - versal2 RPU uses Aff1 for cluster id and Aff0 for core id.

What I can do is use ARM_AFFx_SHIFT defines in my mp_affinity
description struct, and remove the mask as we probably expect it to be
0xff all the time. Something like:

        .mp_affinity = {
            .base = 0x0,
            .core_mask = ARM_AFF1_MASK,
            .cluster_shift = ARM_AFF2_SHIFT,
        },

What do you think?

-- 
Luc

