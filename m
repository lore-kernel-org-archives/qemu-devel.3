Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 579F8C4829A
	for <qemu-devel@archiver.kernel.org>; Tue, 13 Feb 2024 14:29:10 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rZtlW-0003u7-6W; Tue, 13 Feb 2024 09:28:06 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <Luc.Michel@amd.com>)
 id 1rZtlU-0003qo-Fa; Tue, 13 Feb 2024 09:28:05 -0500
Received: from mail-bn7nam10on20600.outbound.protection.outlook.com
 ([2a01:111:f403:2009::600]
 helo=NAM10-BN7-obe.outbound.protection.outlook.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <Luc.Michel@amd.com>)
 id 1rZtlS-0005tp-8t; Tue, 13 Feb 2024 09:28:04 -0500
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=mm/wCeRtSi+PaPVDLMSKbfSwlv7G002RxBWMl+eAcrHlkhtlYDymFN5rzegzbREE9Gx7qJjoPZhDIKhp+QL5QIC6yML52L0GEwx26zkgvrH+x7Jc9iykRe6bX4C9mocoF/Z1XYZam8JzP46fnFqTVXUQAWPao4DEP7sW2WqggIBvCEenKnoH5piawQdhLRTaCBzAXmKqMvA6m5+dfDPl7Vu9b+AhXq9frDgzOZsdVl9TB3cq5+S/+lB9gII1TCwMIaUx8ZmAxEkYL0GB00dewdg2RpJRqICuk/f0u0Q8MrgbJvy+3WmMgvMaSoYq895DFR7Cy0c533GinBD01sVBkw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=jQcAiDOGEu6vwCcvd8HnK/uRIJNH8uP0qcxXazrUL5E=;
 b=G12ychU5SIRlyxM/3yvbDgZO3MeHfSxfEkbbABg9mE2weTpbvXx1ngv0z+mdWeGblimEoAv2q3BorLyRlyDPuYi8/3hssT9xy3rP9HCtc2rFQdVFGBaajj9wjuw1U7HQkGKsHzi5B/B3KZG+bYOf7R5P0pROOwSvrE1kiAZHMiv68uA2+/xkO7S+klxA8xmAyJYQ7SFk7EThVfhXENvjYbiRliPgGaUr8/oGBIvV+eSetgOYCd7+7z0KV1x07WX+nE5o7asfyDnqiy2eY+RHKLn3R88PYrMXy/OSvyW0onh4728mYmDyxmDY3uWlgKpU4mDwLmhLMhpg9QGibJA/jg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=linaro.org smtp.mailfrom=amd.com; dmarc=pass
 (p=quarantine sp=quarantine pct=100) action=none header.from=amd.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=jQcAiDOGEu6vwCcvd8HnK/uRIJNH8uP0qcxXazrUL5E=;
 b=368O4FDWKkWuHxJLb2bjDeL43npod+aEsZk2wrpXrzgO4tEd9dsrgHsCzqSTMT2wuJXa9PWg7DAop+OwK+QFFLoiUAqSnoBaO+cSjuDhMMYdEE/SiKRt/NWhLTyEJ1ehZtbvvfx3xYlr90MjDrmdDxysfKNCEXiECpDXs37n8jc=
Received: from DM5PR07CA0087.namprd07.prod.outlook.com (2603:10b6:4:ae::16) by
 SJ2PR12MB8873.namprd12.prod.outlook.com (2603:10b6:a03:53d::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7292.25; Tue, 13 Feb
 2024 14:27:52 +0000
Received: from DS2PEPF0000343D.namprd02.prod.outlook.com
 (2603:10b6:4:ae:cafe::5f) by DM5PR07CA0087.outlook.office365.com
 (2603:10b6:4:ae::16) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7270.39 via Frontend
 Transport; Tue, 13 Feb 2024 14:27:52 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB03.amd.com; pr=C
Received: from SATLEXMB03.amd.com (165.204.84.17) by
 DS2PEPF0000343D.mail.protection.outlook.com (10.167.18.40) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.7292.25 via Frontend Transport; Tue, 13 Feb 2024 14:27:52 +0000
Received: from SATLEXMB04.amd.com (10.181.40.145) by SATLEXMB03.amd.com
 (10.181.40.144) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.35; Tue, 13 Feb
 2024 08:27:51 -0600
Received: from luc-work-vm (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.35 via Frontend
 Transport; Tue, 13 Feb 2024 08:27:50 -0600
Date: Tue, 13 Feb 2024 15:27:42 +0100
From: Luc Michel <luc.michel@amd.com>
To: Philippe =?utf-8?Q?Mathieu-Daud=C3=A9?= <philmd@linaro.org>
CC: <qemu-devel@nongnu.org>, Eduardo Habkost <eduardo@habkost.net>, Richard
 Henderson <richard.henderson@linaro.org>, Paolo Bonzini
 <pbonzini@redhat.com>, "Michael S. Tsirkin" <mst@redhat.com>, Igor Mammedov
 <imammedo@redhat.com>, Marcel Apfelbaum <marcel.apfelbaum@gmail.com>,
 Bernhard Beschow <shentey@gmail.com>, Ani Sinha <anisinha@redhat.com>,
 <qemu-trivial@nongnu.org>
Subject: Re: [PATCH 0/7] hw/i386: Cleanups around 'hw/i386/pc.h'
Message-ID: <Zct8Xv9O4uCgpghH@luc-work-vm>
References: <20240213120153.90930-1-philmd@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20240213120153.90930-1-philmd@linaro.org>
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS2PEPF0000343D:EE_|SJ2PR12MB8873:EE_
X-MS-Office365-Filtering-Correlation-Id: f1ada664-d539-4131-6b75-08dc2c9ff655
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: q9Te/A3+D+Jv+gLPyX79Ks+ZGVo4Du/6dNjFPH2kElMqw/ZKLdJ70PnfVIc5608U8mn6Z3si5376kPrcj9QRwS3VwNF3i1n9ELjVMqGtT4xJ36SbrF7XdYowpSGPLhD4FrGKNQxECL5Z3GxsaTMRKZXhnvGTq4HWC4j1Ox6s3L2F3YOfCHTMkqBmwvVnPBYmntR4/dlAnr6fsQIpRwC5Zc0d8EhlthcXx8FXtsE9yjOhooN+YOsvkltftEnsEZA3b4sX/m1MpJQYogArlGTY3T1JjkCwsFQmDZl9Rg9V9AhmwhmM16OoZ1zvb/IXQG3eUqrYJLEkg7GrY7uWyp8Z0jiUjsDdDw/y/CkyRZ8XVXPqCxfPi3J6lhYrERm1REeTZzq16USbbA2NYMZeSRBiats0sZnxJkTYydsMKDPsd0t+rRX1eaImRBHcXZUXbdyaJ+bXjeO1HktUgThgPXLK0ukN6rf+DGhzMMofovkJdrPFM/Frp7zW3gy96BEyR7swhrB+NxChaQdjmAwEyti8zE6tbmjao9lMVvBrXZ6J3qiN60H0Y6nfQ9eat6N3/yQ8POWqZpPrXmA0lBpj3lDPc0K0S2RNXOfE4HpuYGCNqeo=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB03.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230031)(4636009)(39860400002)(396003)(136003)(346002)(376002)(230922051799003)(1800799012)(186009)(64100799003)(451199024)(82310400011)(36840700001)(46966006)(40470700004)(86362001)(55016003)(33716001)(70586007)(6916009)(8676002)(8936002)(5660300002)(4744005)(4326008)(7416002)(2906002)(44832011)(83380400001)(9686003)(82740400003)(356005)(41300700001)(70206006)(26005)(336012)(478600001)(81166007)(426003)(316002)(6666004)(54906003);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 13 Feb 2024 14:27:52.3045 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: f1ada664-d539-4131-6b75-08dc2c9ff655
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB03.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: DS2PEPF0000343D.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ2PR12MB8873
Received-SPF: softfail client-ip=2a01:111:f403:2009::600;
 envelope-from=Luc.Michel@amd.com;
 helo=NAM10-BN7-obe.outbound.protection.outlook.com
X-Spam_score_int: -25
X-Spam_score: -2.6
X-Spam_bar: --
X-Spam_report: (-2.6 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.504,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_PASS=-0.001, SPF_PASS=-0.001,
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

On 13:01 Tue 13 Feb     , Philippe Mathieu-Daudé wrote:
> Trivial patches removing uses of "hw/i386/pc.h".
> 
> Philippe Mathieu-Daudé (7):
>   target/i386/monitor: Remove unused 'hw/i386/pc.h' header
>   hw/timer: Move HPET_INTCAP definition to "hpet.h"
>   hw/isa/lpc_ich9: Remove unused 'hw/i386/pc.h'
>   hw/i386/acpi: Declare pc_madt_cpu_entry() in 'acpi-common.h'
>   hw/i386/port92: Add missing 'hw/isa/isa.h' header
>   hw/acpi/cpu_hotplug: Include 'pci_device.h' instead of 'pci.h'
>   hw/acpi/cpu_hotplug: Include 'x86.h' instead of 'pc.h'
> 
>  hw/i386/acpi-common.h   | 3 +++
>  include/hw/i386/pc.h    | 6 ------
>  include/hw/timer/hpet.h | 2 ++
>  hw/acpi/cpu_hotplug.c   | 4 ++--
>  hw/i386/acpi-common.c   | 1 -
>  hw/i386/port92.c        | 1 +
>  hw/isa/lpc_ich9.c       | 1 -
>  hw/timer/hpet.c         | 1 -
>  target/i386/monitor.c   | 1 -
>  9 files changed, 8 insertions(+), 12 deletions(-)
> 
> --
> 2.41.0
> 
> 

For the series:
Reviewed-by: Luc Michel <luc.michel@amd.com>

