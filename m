Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id BC41AC88E77
	for <qemu-devel@archiver.kernel.org>; Tue, 15 Sep 2026 21:28:40 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1x6ahM-0006Fm-FL; Tue, 15 Sep 2026 17:28:16 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <Michael.Roth@amd.com>)
 id 1x6ahL-0006FM-5m; Tue, 15 Sep 2026 17:28:15 -0400
Received: from mail-westus3azlp170110003.outbound.protection.outlook.com
 ([2a01:111:f403:c107::3] helo=PH0PR06CU001.outbound.protection.outlook.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <Michael.Roth@amd.com>)
 id 1x6ahI-0004v2-AE; Tue, 15 Sep 2026 17:28:14 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=gwZ0OgctBYPVubviDPAly6hZai9xznYcvDPxbTTMbKEKEOuYgiym3tEW0K4+HHHPR9o3akPOsRxRQ5gJPgnJPI9cAjp9YxVywPULASTV4XiWKTZRoD9tpH+DDX2VXwrGy1PbECgUVNAmLIZIFaIIicKo0pHySPk+gDcKKrCMLgOfKwy63FuZ2SonQJ1/tf9Y5QvfAoSvF+xEIofguqBvRSqzxivfSWKb0vbiYz1Tpz1/hCzt4C9lUn8tpQbPwvKTl/hO78Rkd39DbBTPp/YF00udiQMR/Kf6kJWJNOcJT8YW9FBk7qIAHExTtuJMfy5vDF5K/Hp499zaoB/9iOrxZQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=WNW/KICI4g/KE2/5QXCt6pyRhZSfli50GrtTqZdV+1M=;
 b=K1wQW0DnB0pTRgnVKghEhKLMH6BpEkXoo66bBUYINS6kdviAOui1WOK9szfNTXvgeQT/9wU3wL6dZOz0VwEJrNBKQtLiipnh1Pofqi6N6vgvBdW1IWZVA6QtgV1JfUYav3NXgCDWlixRHBEWeIlXkkPJXwloFrPABtsmGS3DAOZATHmOp/2Ax83W4g83RZwlVSVhQO3woHi8oG8G76AKL+nOJHjMnZK2g0IqIQYNtoaKBa9RDkjHqhap421JCDyO7rRve0M/4i8gug0jUddsHSphxdrAHY4mBntUkfqqsFUN8VfvtKkY3611XE9smopHdyMXcJGQ2Ua3Ou+/ocri0Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=linaro.org smtp.mailfrom=amd.com; dmarc=pass
 (p=quarantine sp=quarantine pct=100) action=none header.from=amd.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=WNW/KICI4g/KE2/5QXCt6pyRhZSfli50GrtTqZdV+1M=;
 b=c4sl2jLj3FWFhXZHm7x+aWBd63PwH7IJl8qbpEdgz2Rxy0vDMFIuZnptfjAE6VN7xUPCO7+4bsDePnYZu4WCnGWQqIg5X4tMKb93JlvqmgkOW4Qkfp/GPAAWbRXdwiDHAdy+Wt9ycbDjMeuCQsNsSuOasiq1lxJmMm4aK7ealNQ=
Received: from BN9PR03CA0867.namprd03.prod.outlook.com (2603:10b6:408:13d::32)
 by LV3PR12MB9120.namprd12.prod.outlook.com (2603:10b6:408:1a3::5)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.406.12; Tue, 15 Sep
 2026 21:27:58 +0000
Received: from BN5PEPF00046987.namprd02.prod.outlook.com
 (2603:10b6:408:13d:cafe::88) by BN9PR03CA0867.outlook.office365.com
 (2603:10b6:408:13d::32) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.428.11 via Frontend Transport; Tue,
 15 Sep 2026 21:27:58 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb07.amd.com; pr=C
Received: from satlexmb07.amd.com (165.204.84.17) by
 BN5PEPF00046987.mail.protection.outlook.com (10.167.245.36) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.428.7 via Frontend Transport; Tue, 15 Sep 2026 21:27:57 +0000
Received: from localhost (10.180.168.240) by satlexmb07.amd.com
 (10.181.42.216) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.49; Tue, 15 Sep
 2026 16:27:57 -0500
Date: Tue, 15 Sep 2026 16:27:21 -0500
From: Michael Roth <michael.roth@amd.com>
To: Mathieu Poirier <mathieu.poirier@linaro.org>
CC: <berrange@redhat.com>, <kchamart@redhat.com>,
 <pierrick.bouvier@oss.qualcomm.com>, <peter.maydell@linaro.org>,
 <mst@redhat.com>, <cohuck@redhat.com>, <pbonzini@redhat.com>,
 <eblake@redhat.com>, <armbru@redhat.com>, <lorenzo.pieralisi@linaro.org>,
 <gshan@redhat.com>, <enju.kohei@fujitsu.com>, <qemu-devel@nongnu.org>,
 <qemu-arm@nongnu.org>, <kvm@vger.kernel.org>
Subject: Re: [RFC v4 03/24] target/arm: Add confidential guest support
Message-ID: <dhrvydsmaw22xqx5d5i5s7fdyjxupz27yxp6trv2tesysp4npj@quvzrxjvfipz>
References: <20260903193611.1058589-1-mathieu.poirier@linaro.org>
 <20260903193611.1058589-4-mathieu.poirier@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <20260903193611.1058589-4-mathieu.poirier@linaro.org>
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: satlexmb08.amd.com (10.181.42.217) To satlexmb07.amd.com
 (10.181.42.216)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BN5PEPF00046987:EE_|LV3PR12MB9120:EE_
X-MS-Office365-Filtering-Correlation-Id: c5012477-a10a-44e9-d50d-08df1370365c
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|36860700016|30052699003|376014|23010399003|7416014|82310400026|1800799024|56012099006|4143699003|10067099003|11063799006|22082099003|18002099003|27256017;
X-Microsoft-Antispam-Message-Info: z5qGUCEbyd54G7hDySjjhfveOQg3xadDMtOCwsGaiXGFByZ4AKW1l57t89ILOEcaEXlxS7cUbbgbTtCSPMet3vOKZDcs2omim6gLrhZN/Csu6Endl4cnQMpjO0rnSOsZjgMcIRrdEUUGgC42iBid+XnwFZP59estD20By+XhwmtgVIEQIKJTh31Azg36mKTrE1Yx3lQlNe4w/j9MJOtUI8gFqyGxRH40xiwSX0GnNfjwRq+8rhw51xMyfKdVos3kVo3v1rj+pFab8Yi1SmxszjqAdpNf9TJpSelR1qRX3/+2YHlpeg5Q3hhLalHmDjfC/r+j/fiLZnhnPrgUzvLHDT/ZmVq8uDjqnFeG0d37S7d5ja4dl4pP4dnBlwI7SkyU0B/Gy9xOebbNVBFlxLy/kEyAhVUCV9m6xc3G7eW1gW9ywVqN1l7JLAU95iLfb+gVtpybSsRiNjg7iS9WYQwOhjB4jAWzXh3uYx2WT9gfF+mR5cXhsr/RBWFhZouJID/7UOMqk1iESqG8hs5MTdufVNrT3pUKkw4QNVgEhyrwtu1K2QH/HNzkj9Q3ZPbTKzxwj8putwiMxzLL/fsJJc0IiDPe9YaNs09BIyP1nD5qxp6yeySsz+gm1LVzjchhpECt8DKwElQt63F2pIZanweSDk3fxmlt1UUYMps3liHzeVOT6N4GSGAZFWem8NYTehi4fEea8UaWAXZygf0+F80CNBurh1DDrDl4opbzXX5CJUObP1ZOJ6HXlf4WCsjFfarg
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:satlexmb07.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(36860700016)(30052699003)(376014)(23010399003)(7416014)(82310400026)(1800799024)(56012099006)(4143699003)(10067099003)(11063799006)(22082099003)(18002099003)(27256017);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: 5JBCxTq2zw+Au0E7mVm3RQ3/9Mmu15SpYlGC03Wt2rG0fWsWeipKUjqc3wK9CkmL+fUQrhW38BajWzWlgAzAfxaL1BZpAKL5ImaaALQ4Y+GtjjUdC3az3MVeUFT1yPWgyVg08bhE3lFfRsjm0M0E/wA49x4iRaWH+HjIRPs3QRF0w0D7CqiCP33zR6QXHoKXQAJdP9Xek25RvkkrYp9d+583R9TAHJqGSgA0fUPlG172eLvk6Uix+oDRGK28KwDJ1gdLLMhk8n/rwr+6qOh0IExgQp2IqK9ckSUgbLvP82klB9WVWKs7Bnv+YbcLuxuhWxsyQCz5WBDlXVe+ipPaXsBDT9gqSaHKEXLJEAz97akHrFG3UQ0dtAt9WIVYnncxPTnPwT1vLhGdLOwGVIkLg70Ib2Lot5S4PcZH2rF5Ah+G+jW7f8Judc5yIIjuNKXi
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 15 Sep 2026 21:27:57.8782 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: c5012477-a10a-44e9-d50d-08df1370365c
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[satlexmb07.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: BN5PEPF00046987.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: LV3PR12MB9120
Received-SPF: permerror client-ip=2a01:111:f403:c107::3;
 envelope-from=Michael.Roth@amd.com;
 helo=PH0PR06CU001.outbound.protection.outlook.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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

On Thu, Sep 03, 2026 at 01:35:50PM -0600, Mathieu Poirier wrote:
> From: Jean-Philippe Brucker <jean-philippe@linaro.org>
> 
> Add a new RmeGuest object, inheriting from ConfidentialGuestSupport, to
> support the Arm Realm Management Extension (RME). It is instantiated by
> passing on the command-line:
> 
>   -M virt,confidential-guest-support=<id>
>   -object rme-guest,id=<id>
> 
> This is only the skeleton. Support will be added in following patches.
> 
> Signed-off-by: Jean-Philippe Brucker <jean-philippe@linaro.org>
> Signed-off-by: Mathieu Poirier <mathieu.poirier@linaro.org>
> ---
>  docs/system/confidential-guest-support.rst |  1 +
>  qapi/qom.json                              | 13 +++++++
>  target/arm/kvm-rme.c                       | 42 ++++++++++++++++++++++
>  target/arm/meson.build                     |  5 ++-
>  4 files changed, 60 insertions(+), 1 deletion(-)
>  create mode 100644 target/arm/kvm-rme.c
> 
> diff --git a/docs/system/confidential-guest-support.rst b/docs/system/confidential-guest-support.rst
> index 562a7c3c2852..abb56923ad13 100644
> --- a/docs/system/confidential-guest-support.rst
> +++ b/docs/system/confidential-guest-support.rst
> @@ -42,5 +42,6 @@ Currently supported confidential guest mechanisms are:
>  * POWER Protected Execution Facility (PEF) (see :ref:`power-papr-protected-execution-facility-pef`)
>  * s390x Protected Virtualization (PV) (see :doc:`s390x/protvirt`)
>  * AWS Nitro Enclaves (see :doc:`nitro`)
> +* Arm Realm Management Extension (RME)
>  
>  Other mechanisms may be supported in future.
> diff --git a/qapi/qom.json b/qapi/qom.json
> index 776b13027fd8..52997c29a32d 100644
> --- a/qapi/qom.json
> +++ b/qapi/qom.json
> @@ -1288,6 +1288,17 @@
>    'data': { '*pretty': 'bool',
>              '*close-action': 'MonitorQMPCloseAction' } }
>  
> +##
> +# @RmeGuestProperties:
> +#
> +# Properties for rme-guest objects.
> +#
> +# Since: 11.1
> +##
> +{ 'struct': 'RmeGuestProperties',
> +  'base': 'ConfidentialGuestSupportProperties',

Just FYI, based on input from Markus I'm planning to drop this
ConfidentialGuestSupportProperties base type from my series
since it's probably only SNP/TDX that need to be able to switch
it on/off, whereas this series appears to use/require it from
the start.

I'm not exactly sure what it will look like for v3 yet, but if you
were based on v2 you'd instead probably just do the following in the
instance_init function for your rme-guest instance:

  cgs->allow_convert_in_place = true;
  cgs->convert_in_place = true;

rather than exposing it as a cmdline option.

Thanks,

Mike

> +  'data': {} }
> +
>  ##
>  # @ObjectType:
>  #
> @@ -1346,6 +1357,7 @@
>      { 'name': 'pr-manager-helper',
>        'if': 'CONFIG_LINUX' },
>      'qtest',
> +    'rme-guest',
>      'rng-builtin',
>      'rng-egd',
>      { 'name': 'rng-random',
> @@ -1427,6 +1439,7 @@
>        'pr-manager-helper':          { 'type': 'PrManagerHelperProperties',
>                                        'if': 'CONFIG_LINUX' },
>        'qtest':                      'QtestProperties',
> +      'rme-guest':                  'RmeGuestProperties',
>        'rng-builtin':                'RngProperties',
>        'rng-egd':                    'RngEgdProperties',
>        'rng-random':                 { 'type': 'RngRandomProperties',
> diff --git a/target/arm/kvm-rme.c b/target/arm/kvm-rme.c
> new file mode 100644
> index 000000000000..42e1d1e7b859
> --- /dev/null
> +++ b/target/arm/kvm-rme.c
> @@ -0,0 +1,42 @@
> +/*
> + * QEMU Arm RME support
> + *
> + * SPDX-License-Identifier: GPL-2.0-or-later
> + *
> + * Copyright Linaro 2026
> + */
> +
> +#include "qemu/osdep.h"
> +
> +#include "hw/core/boards.h"
> +#include "hw/core/cpu.h"
> +#include "kvm_arm.h"
> +#include "migration/blocker.h"
> +#include "qapi/error.h"
> +#include "qom/object_interfaces.h"
> +#include "system/confidential-guest-support.h"
> +#include "system/kvm.h"
> +#include "system/runstate.h"
> +
> +#define TYPE_RME_GUEST "rme-guest"
> +OBJECT_DECLARE_SIMPLE_TYPE(RmeGuest, RME_GUEST)
> +
> +struct RmeGuest {
> +    ConfidentialGuestSupport parent_obj;
> +};
> +
> +OBJECT_DEFINE_SIMPLE_TYPE_WITH_INTERFACES(RmeGuest, rme_guest, RME_GUEST,
> +                                          CONFIDENTIAL_GUEST_SUPPORT,
> +                                          { TYPE_USER_CREATABLE }, { })
> +
> +static void rme_guest_class_init(ObjectClass *oc, const void *data)
> +{
> +}
> +
> +static void rme_guest_init(Object *obj)
> +{
> +}
> +
> +static void rme_guest_finalize(Object *obj)
> +{
> +}
> diff --git a/target/arm/meson.build b/target/arm/meson.build
> index 0369f96b4cc6..9d322a7aad28 100644
> --- a/target/arm/meson.build
> +++ b/target/arm/meson.build
> @@ -31,7 +31,10 @@ arm_common_user_system_ss.add(when: 'TARGET_AARCH64', if_true: files(
>  arm_common_system_ss.add(files(
>    'arm-qmp-cmds.c',
>  ))
> -arm_system_ss.add(when: 'CONFIG_KVM', if_true: files('hyp_gdbstub.c', 'kvm.c'))
> +arm_system_ss.add(when: 'CONFIG_KVM', if_true: files(
> +  'hyp_gdbstub.c',
> +  'kvm.c',
> +  'kvm-rme.c'))
>  arm_system_ss.add(when: 'CONFIG_HVF', if_true: files('hyp_gdbstub.c'))
>  
>  arm_user_ss.add(files('cpu.c'))
> -- 
> 2.43.0
> 
> 

