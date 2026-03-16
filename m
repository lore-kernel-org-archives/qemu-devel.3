Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id BD10EEFCBD4
	for <qemu-devel@archiver.kernel.org>; Mon, 16 Mar 2026 07:22:34 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1w22HM-0007P0-KC; Mon, 16 Mar 2026 03:22:20 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <FangSheng.Huang@amd.com>)
 id 1w22HJ-0007Os-Nz
 for qemu-devel@nongnu.org; Mon, 16 Mar 2026 03:22:18 -0400
Received: from mail-eastus2azon11010023.outbound.protection.outlook.com
 ([52.101.56.23] helo=BN1PR04CU002.outbound.protection.outlook.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <FangSheng.Huang@amd.com>)
 id 1w22HG-0000b5-Cy
 for qemu-devel@nongnu.org; Mon, 16 Mar 2026 03:22:16 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=XKZ76QCVFdZ3Vq3xceHOY9kFNIvs1iGdaVuEnC3l2nhGSBhWIub7ZHbkQj61/agQj7Uan8zeneJo/IHVtDjvsEpwq8NDZJ2FUp7Sorw8kxqqwH/YcFGTKkQF2N6ZGG6QAj1qocOgMHQ0sxp3e4IWDu6O8L46C06ZBAbSr8rK6N/BROb2fJBOrm3NT9Y0A9OWhCkXrG1O5giSymQPBS2sx/rJoi4G8SDW0k8bdPXYJmLGUo1wk34rz6WOuWSObUDidF5Qa5ES7qnKJfwVXByIismPs3QcnVy0DfnbovfHbx9XaIy0oLUtAEoCoyFR1bMo5GIFCdRt520rJG8HiBZPMA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=i/U2aXBj0AfWSOrALn9WGg4i+H0uoq7wQcgdkOLcrdc=;
 b=wvz6fgSoHQnZGbOdalXHiPSD9az2NdubSq7iAiebwiDJ5KZCOkPymbrAsEHlAApdQQYjQAgWMu9djvijLsSrFjIvR93uuIOseL2dL6rsU8pS365emGpw3ifjdviNa4GMcTPVzB9ygJd8gf6hPJdZ9D73bQ89vMlM3FLfoaJrIOK2AMxzNNt5Gttq0IHlzS8rZ6byHB66LzOE6IqqDh61id42BXsmhreXkxdRTo8yYlzayR98ZcCGx2jGS+RJpTu1lZirXMgbCipZ3Lcx2EO7j64GYNsnRZyaehcuXeVshFluGkxtVXWh0Mrh8wgTXh9rfTHBFd/R+qJA9BiEwYkPcA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=huawei.com smtp.mailfrom=amd.com; dmarc=pass
 (p=quarantine sp=quarantine pct=100) action=none header.from=amd.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=i/U2aXBj0AfWSOrALn9WGg4i+H0uoq7wQcgdkOLcrdc=;
 b=3pIwckHUH5WOxg+LqGs7kPC/aZrsHcPFQvgv6ea8KaVBps76/MgxA4ufmtwE7q8vhYY3gvmwQuwv0oV5YpkrYuaovWerB9v/k6PQkt9z4pBuTzJUGlNRiLgx4N68dUOoKnvoRxXMpGqo4tIVIHLZLl6h0r63ZSH3AbMfJvID5yo=
Received: from IA1P220CA0004.NAMP220.PROD.OUTLOOK.COM (2603:10b6:208:461::10)
 by DS2PR12MB9798.namprd12.prod.outlook.com (2603:10b6:8:2b9::17) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9723.16; Mon, 16 Mar
 2026 07:17:06 +0000
Received: from MN1PEPF0000ECDA.namprd02.prod.outlook.com
 (2603:10b6:208:461:cafe::bb) by IA1P220CA0004.outlook.office365.com
 (2603:10b6:208:461::10) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9700.24 via Frontend Transport; Mon,
 16 Mar 2026 07:17:13 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb08.amd.com; pr=C
Received: from satlexmb08.amd.com (165.204.84.17) by
 MN1PEPF0000ECDA.mail.protection.outlook.com (10.167.242.134) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9700.17 via Frontend Transport; Mon, 16 Mar 2026 07:17:05 +0000
Received: from satlexmb07.amd.com (10.181.42.216) by satlexmb08.amd.com
 (10.181.42.217) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.17; Mon, 16 Mar
 2026 02:17:04 -0500
Received: from [10.65.99.73] (10.180.168.240) by satlexmb07.amd.com
 (10.181.42.216) with Microsoft SMTP Server id 15.2.2562.17 via Frontend
 Transport; Mon, 16 Mar 2026 02:17:02 -0500
Message-ID: <f43d8a68-62e3-472e-80e4-f018a91d7eaa@amd.com>
Date: Mon, 16 Mar 2026 15:17:02 +0800
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v7 0/1] numa: add 'memmap-type' option for memory type
 configuration
To: Jonathan Cameron <jonathan.cameron@huawei.com>, Gregory Price
 <gourry@gourry.net>, Igor Mammedov <imammedo@redhat.com>
CC: <qemu-devel@nongnu.org>, <apopple@nvidia.com>, <dan.j.williams@intel.com>, 
 <Zhigang.Luo@amd.com>, <Lianjie.Shi@amd.com>, <david@redhat.com>
References: <20260306082735.1106690-1-FangSheng.Huang@amd.com>
 <4609b0dc-4510-48c7-8190-e8fd5c53b658@amd.com>
 <abQquiWHPoVgw-jt@gourry-fedora-PF4VCD3F>
 <20260313161429.00003ace@huawei.com>
From: "Huang, FangSheng (Jerry)" <FangSheng.Huang@amd.com>
In-Reply-To: <20260313161429.00003ace@huawei.com>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 8bit
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: MN1PEPF0000ECDA:EE_|DS2PR12MB9798:EE_
X-MS-Office365-Filtering-Correlation-Id: 57914091-a07f-4f00-9fc5-08de832c0713
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|1800799024|36860700016|376014|82310400026|22082099003|56012099003|18002099003|13003099007;
X-Microsoft-Antispam-Message-Info: Ayq+6dC32oOLfRkH2Qgp+XWfzpqfE+PrnRUqD6R322YiTTc2o75P93GfxX5s36VT0J2z4gaPnuLD9qZmj0oGESJA0j7LI+Dp1sxF6DCyF7Rs2nxDDgugGSzWzwrG8iqObNARy4OphTP5vm8pFxmU0rc8jpqLNHUGirwJYz8R8O4RM4qAS+vM3eUFGqyoLVkR/pb7ZHlBBNeDkxd2gY+9rFWGm/Cz7KBU8Aw3eR654n6chYGLqh5c4SonhW67GfNZHj0l4E/GpABPM54Hy7iq2vc8c6HjWxkNhhVsQoEEo0PkVtw5GNzmeyzypEsddgaCdEW2mUNaz6rxLEwla+6rjMD1EwnOAQ4yV+zJIxRP6Z3M2j1Xdr9wZQ28O+BE5aVOfXXRkb6Vs+pTEEp2XPItLconOqERnuwUvWpjrHFGGCAxcCu2R5tZmXRdeel19qcSKoP63rd4fFdqMxmfPpUuZoddrB101oZstd5qvKA6FNuMC4pGjhK6lYWDJXC9WNbOZPpMd4Oz1yRs6pS7DmUqqXdqTdlH59AJNd2jjGq9ONDKrjNayVTjcInswgZ6k+ldpc7qG0+wr285E8UngxSavbqQ6g5LEYZCf1T57Aa4OnDgY3hTz9SERRWxIN+zsZs83BEj+g69dxlNs+sMpiO2SgDvviWGG3iO2wmXc3sPUl7LjJ/9yWnGyhHanp4ltmfdUIynXo0H6nG5I4+5QN2Nkg==
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:satlexmb08.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(1800799024)(36860700016)(376014)(82310400026)(22082099003)(56012099003)(18002099003)(13003099007);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: MvC7FMsqh97ka1+71qeLDmFeSU9nZHHP1xq89YjRiPR8yIZrONwp+HFGG3pxU4zbSoPnuSaSthvlCKhJ919QWVL5JVRRpGggrtpyI+9z3RiD8gs/PJr128oadGHYtKIyYXVJPa/rBwdaeCc42Hh9M0/WoLVoVAsUoMCBz7G38pI4o6B3fmxqgmqSI3zrM2za41wv3zqIfcpdSRmvo95o8EC3MiEps8PMuKi2B0peMrg9aXNmxd+AtPrQmrV0qunjryK/83mmjkGmjDbJ9SssMbZ2kafCC6fXlnRHFNBufcaBjhy840mienKN/dv3EwYcjYEdBL3bJUH/ntKxq0vwmpRZj1kpHf0s3KI+xsfpNA4Ef3w33EFxVXb8IAgJvcKJvOWoYz6Z8jibENBAd7Wxfy2i8OoLqdqWuE5Rn7qCHhfPrwslhFaIZOQgtzcHQwJS
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 16 Mar 2026 07:17:05.3268 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 57914091-a07f-4f00-9fc5-08de832c0713
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[satlexmb08.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: MN1PEPF0000ECDA.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS2PR12MB9798
Received-SPF: permerror client-ip=52.101.56.23;
 envelope-from=FangSheng.Huang@amd.com;
 helo=BN1PR04CU002.outbound.protection.outlook.com
X-Spam_score_int: -3
X-Spam_score: -0.4
X-Spam_bar: /
X-Spam_report: (-0.4 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H2=0.001,
 RCVD_IN_VALIDITY_RPBL_BLOCKED=0.819, RCVD_IN_VALIDITY_SAFE_BLOCKED=0.903,
 SPF_HELO_PASS=-0.001, SPF_PASS=-0.001 autolearn=no autolearn_force=no
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


On 3/14/2026 12:14 AM, Jonathan Cameron wrote:
> On Fri, 13 Mar 2026 11:18:18 -0400
> Gregory Price <gourry@gourry.net> wrote:
> 
>> On Fri, Mar 13, 2026 at 04:30:20PM +0800, Huang, FangSheng (Jerry) wrote:
>>> Hi Gregory,
>>>
>>> Thanks again for the thorough review on v6 and for catching the hardcoded
>>> address issue — v7 has that fixed, now using x86ms->above_4g_mem_start as
>>> you suggested.
>>>
>>> Just wanted to follow up and check if your Reviewed-by still applies to v7,
>>> since it's a minimal change from v6 (only the one-line fix you identified).
>>>    
>>
>> Yes sorry, we're good to go
>>
>> Reviewed-by: Gregory Price <gourry@gourry.net>
>>
>> Thank you for this, this will be very helpful for testing
>>
>> Jonathan would be able to answer more questions re: upstream
> 
> Can provide general details, but specifics of this patch is probably
> something for Igor as it's not CXL specific.
> 
> Soft freeze for 11.0 has passed, so this will be a 11.1 feature.
> https://wiki.qemu.org/Planning/11.0
> Is the 11.0 timeline. (11.1 will go up around time of 11.0 release).
> 
> Jonathan

Hi Gregory, Jonathan,

Thank you both!

Gregory — much appreciated for the Reviewed-by and your continued
support throughout the review process.

Jonathan — thanks for clarifying the timeline. Understood that this
would target the 11.1 cycle. Will follow up with Igor when the 11.1 
window opens up.

Best regards,
Jerry Huang

