Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 59843C021A0
	for <qemu-devel@archiver.kernel.org>; Thu, 13 Feb 2025 23:09:23 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tiiK7-0006il-J3; Thu, 13 Feb 2025 18:08:47 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <kim.phillips@amd.com>)
 id 1tiiK5-0006iO-N0
 for qemu-devel@nongnu.org; Thu, 13 Feb 2025 18:08:45 -0500
Received: from mail-mw2nam12on2073.outbound.protection.outlook.com
 ([40.107.244.73] helo=NAM12-MW2-obe.outbound.protection.outlook.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <kim.phillips@amd.com>)
 id 1tiiK3-0001JD-Jd
 for qemu-devel@nongnu.org; Thu, 13 Feb 2025 18:08:45 -0500
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=dXZPtcyNJ9BtTt11W4t7svVl6a6KKCkYiiqrSSmTxmgrEhUwlW7GnvnnM/0u7PH3vbzG0LD952cTNIaosbA8GUHR9IRvjymBuJt/4YW8ILug+57XjWWJOkmszFiVfHmuN+oApv0nRTcJZc7LXaPD0hxXgDRmZxBrP4JLvNX2K7aFdmx4nAlZWu2rh/VgPK5wZa1ndh58GiHuLbxuQCyUHfHQ6UzeJPhOXePXw62J6GEzFGUL0MbDqGVPwVSBT98Gg23u2DzRXrg4hsvjfZB+kj6zLW1pkoEpL3w9w9JjE/O4bpb7bD8kFMQ4CkIgCGduVKEnNN5WwKoSHzaDswdoRA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=NtGd0b4YUW6UhNp6Q0LyESnx5dadRDiehL8NNkE5Ylk=;
 b=NUxPc6+faU5tOmTF5UXuCaSE/6ZVoebOFp6uFtyrPXps8OTrGJHjfD8+JqrnoI9bOw14uuYWbD43MdYyi+dRsr0rNORNFC3p77js2tkIbLtaeP/cHUoFFg4P9Z5F+qyEOSuP+DjtPo68UsZN/729FDTdp1f930hlmqRRH+zTu4U4t3UCr3wl3JlSzR+8TGmAnkLWNc3rx82Xl8rGZVaMVxkmBlt7nqwhx+XUFDBBTCijWgP9KawYFb0ZSHIp+j79m/3Nzad34GCycIA/Aynh47rSmsagYIZbCxCTNCUaucIzM6QuiqFsPsV0FwW0d/wbej0zrUhpoZ3GW+TM0p/+SA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=google.com smtp.mailfrom=amd.com; dmarc=pass
 (p=quarantine sp=quarantine pct=100) action=none header.from=amd.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=NtGd0b4YUW6UhNp6Q0LyESnx5dadRDiehL8NNkE5Ylk=;
 b=tEYYALTLibvl++IH4vljMRa27+wbeQGsfaGiOxlMOKuoYkkRLQTlayUVctRw5CI2a71OuXkMt7Qpa8spCt88O6cgjeZvpgx//PLfEoVN5VnT9qauEZcFZptG48/OjodbsUecVlxo2/gPmtYS1pOEgidrSJLt6+Qjr3OpbmsKid8=
Received: from PH7P223CA0017.NAMP223.PROD.OUTLOOK.COM (2603:10b6:510:338::10)
 by PH8PR12MB6844.namprd12.prod.outlook.com (2603:10b6:510:1cb::17)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8445.13; Thu, 13 Feb
 2025 23:03:35 +0000
Received: from CY4PEPF0000E9D4.namprd03.prod.outlook.com
 (2603:10b6:510:338:cafe::d3) by PH7P223CA0017.outlook.office365.com
 (2603:10b6:510:338::10) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.8445.14 via Frontend Transport; Thu,
 13 Feb 2025 23:03:35 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 CY4PEPF0000E9D4.mail.protection.outlook.com (10.167.241.139) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.8445.10 via Frontend Transport; Thu, 13 Feb 2025 23:03:34 +0000
Received: from [10.236.30.53] (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Thu, 13 Feb
 2025 17:03:32 -0600
Message-ID: <6829cf75-5bf3-4a89-afbe-cfd489b2b24b@amd.com>
Date: Thu, 13 Feb 2025 17:03:31 -0600
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
From: Kim Phillips <kim.phillips@amd.com>
Subject: Re: [PATCH v3 2/2] KVM: SEV: Configure "ALLOWED_SEV_FEATURES" VMCB
 Field
To: Sean Christopherson <seanjc@google.com>, Tom Lendacky
 <thomas.lendacky@amd.com>
CC: <qemu-devel@nongnu.org>, <kvm@vger.kernel.org>, Michael Roth
 <michael.roth@amd.com>, Ashish Kalra <ashish.kalra@amd.com>, "Nikunj A .
 Dadhania" <nikunj@amd.com>, Borislav Petkov <bp@alien8.de>, Dave Hansen
 <dave.hansen@linux.intel.com>, Paolo Bonzini <pbonzini@redhat.com>, "Kishon
 Vijay Abraham I" <kvijayab@amd.com>
References: <20250207233410.130813-1-kim.phillips@amd.com>
 <20250207233410.130813-3-kim.phillips@amd.com>
 <4eb24414-4483-3291-894a-f5a58465a80d@amd.com> <Z6vFSTkGkOCy03jN@google.com>
Content-Language: en-US
In-Reply-To: <Z6vFSTkGkOCy03jN@google.com>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB04.amd.com (10.181.40.145) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CY4PEPF0000E9D4:EE_|PH8PR12MB6844:EE_
X-MS-Office365-Filtering-Correlation-Id: f600258d-426a-4563-57e0-08dd4c82a4ce
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|36860700013|376014|1800799024|82310400026; 
X-Microsoft-Antispam-Message-Info: =?utf-8?B?VzV2UjMxendHTVJQdmdLcGFJNmJGZmNzdTRxUmVCSWF4cnZKN0lzbmZDcldD?=
 =?utf-8?B?bjZCZ09HWG5ZazVXd2E0cnRZU0IyV3ZTQTIrWTZCN09OQUJQZVVCTjVoSDlP?=
 =?utf-8?B?T1lISGJBZDlSWUNFUHBoZFJsaitsNjgyNGFEdzYvU3Q2NHhZbE1RTlI3VTJX?=
 =?utf-8?B?b2hXNmhkOWdodW1tODBsdWxqR0tTV2lxaVordGJzbno5UlE4R0ErYkYrSE9W?=
 =?utf-8?B?Ri9BT04yYkdyTi9OWVNybUprSEJBVFJXdktNNXNiMXR1M2ROV3NnWHh3NWZZ?=
 =?utf-8?B?QlQ0R0N1Uis0QkY1K2xZbG5RY3RkOEhNQ21vbTdsTlVRZUNrYll3N24xc1hW?=
 =?utf-8?B?aUZ5czNLR2RKKzJzcXF2OVZuTWI4QXA2WjNVRFBKR2lsTWhDNTczRTE3Nmx5?=
 =?utf-8?B?cGZzUWl2SWtvNzQ5SmlQNGUwaUJEbVcvM2lmeDdTNVpXTlZ0aENqL0ZHT2tS?=
 =?utf-8?B?QUowOFNjUFo2NEl1d053dEh3Z3h2V1JMeFhvQk5DTVhXWjRxN1lncDgxOEcx?=
 =?utf-8?B?cUlKYWNvSjZpaXJ4M3FUbVBNWnlGa25EVXFFN21ocmhITlM0UWZvWkw3cEhv?=
 =?utf-8?B?MXBnK3huS0dJV3plK2hGYTNJQjlBSURtK1dWc05UQkNyQ1FBYWIrSWtFYjli?=
 =?utf-8?B?L3BmalE0cExiQThVWk16UmtJWEhpV1lwb0Q1Tm1NNUIrQjlGbUlncGZXeFNq?=
 =?utf-8?B?bVlVSkhRNFNORmhjeUJtM04vL3VEcElXbkVrMnlZaHp2RVFsWFdwMThNb0hO?=
 =?utf-8?B?U0xLYkVRUFl3S3JvY0lHSVJQd0N4N2NDVUpzTFFqWDJrd3BvbHBJLy8wZWR2?=
 =?utf-8?B?VHBkbEF4UEVjRjRLREpUaUVVdEd3L2l4R05jRXJhU3NneTl1ZG9sMXB3MEVo?=
 =?utf-8?B?aVN2RE5TSmp1bzUvWjZTbitvSWJjWm5DdHRwZkQ3Zmp4SlVtQWVDYVRZK050?=
 =?utf-8?B?T3N0dUlSUlRZTGF6REYwN0d2V3k0YnFXdHFBMHFxWHRjcndjVWxkU0pUL2Js?=
 =?utf-8?B?cXk4dGduNDNHMnpHdzkxSTJRYnQ1ZTBORnVWc0I5dUxmNkM5bGZxQWYxSVJs?=
 =?utf-8?B?SzhSTEZPcVN0bHBsQjR1QTlZZngwVktLVDdyMlZ6NXNTWlg1aDFxQUwwcGg3?=
 =?utf-8?B?c0Q5czczVWlMbzExRXVkY3BoRHo5eTROYVFFWnVaVWVsKzdVbXZ1dElneGFS?=
 =?utf-8?B?YjREUlhTcGZKWlYrZzVtQUZJQUhzQUxDUUMxamo0SXBCWGIrK0tQYisraHor?=
 =?utf-8?B?WTdqNVYwSUdZWmd3UmNENU8ydENXL0RGL2hPZ2JkeVhLcFY4eUd6RTY5cGtP?=
 =?utf-8?B?dEhnK3VWWllvcEUrUldQS3dKQlcrVW5Fb2U5MkRyZTZmZzhreUgyRHJ6QVJv?=
 =?utf-8?B?RjdHQmtBc2JkSklDRUowcEMrTktsWng2Mm5JMkRPR0ZMcndwekNRZW1UUURQ?=
 =?utf-8?B?ZDkzcU52VUJyOGdkSUNyTDk3dElqb0J3bklxV2hpRlBEWStSTzZmS250OVpU?=
 =?utf-8?B?V0xzZDVDVFB1REdzS1VOVGRHZUZkRnFrV3FOZHpHZzMwL3dHd2RzNzR1Mi9K?=
 =?utf-8?B?N0pZOWNNclpKS0wzeHVmU3FpUzgyT2g1YXE1amFzelBoTHpPVmU2V0ZBMTYr?=
 =?utf-8?B?VjdldjRzZk1ESGhaUUtLWVpJUkF4R0k3MTRLRlJwWEJMcGkwN0wyakVnZEc2?=
 =?utf-8?B?N2ZKaUhMc3FGc1k5a2pUdEg0YTFuVHI5cU1kM3FEOExGK3BMTW9RbzdTSEhX?=
 =?utf-8?B?NTM5cFZTbGNLajFwdVgzN01MM0IxWjVxblJJb1VoS2lYUXJxZ2h0NmtLd3ky?=
 =?utf-8?B?a1ZEbjh2RENpc09VZmk4eTdkV0dkaFUzbW9kYXdlNUpsbGJmZkxJMGtWa0ly?=
 =?utf-8?B?KytsclRUZTdaVWE3cU5Xb3lRS1JCcWVHTkpoYXhzVjg4TnRlbGJNSUFBZXRG?=
 =?utf-8?B?bGtZUjJuRTdMai9ISGp2WGIydHFvbEN1amhMY2Z2RWpZeVo5RU9LZHAyVWky?=
 =?utf-8?Q?UY2CVjmlmEEv0O6UyyekO28Wq6OMIU=3D?=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(36860700013)(376014)(1800799024)(82310400026); DIR:OUT;
 SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 13 Feb 2025 23:03:34.9205 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: f600258d-426a-4563-57e0-08dd4c82a4ce
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: CY4PEPF0000E9D4.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH8PR12MB6844
Received-SPF: permerror client-ip=40.107.244.73;
 envelope-from=kim.phillips@amd.com;
 helo=NAM12-MW2-obe.outbound.protection.outlook.com
X-Spam_score_int: -35
X-Spam_score: -3.6
X-Spam_bar: ---
X-Spam_report: (-3.6 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-1.495,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_MSPIKE_H2=0.001, RCVD_IN_VALIDITY_CERTIFIED_BLOCKED=0.001,
 RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001, SPF_HELO_PASS=-0.001,
 SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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

On 2/11/25 3:46 PM, Sean Christopherson wrote:
> On Mon, Feb 10, 2025, Tom Lendacky wrote:
>> On 2/7/25 17:34, Kim Phillips wrote:
>>> diff --git a/arch/x86/kvm/svm/sev.c b/arch/x86/kvm/svm/sev.c
>>> index a2a794c32050..a9e16792cac0 100644
>>> --- a/arch/x86/kvm/svm/sev.c
>>> +++ b/arch/x86/kvm/svm/sev.c
>>> @@ -894,9 +894,19 @@ static int sev_es_sync_vmsa(struct vcpu_svm *svm)
>>>   	return 0;
>>>   }
>>>   
>>> +static u64 allowed_sev_features(struct kvm_sev_info *sev)
>>> +{
>>> +	if (cpu_feature_enabled(X86_FEATURE_ALLOWED_SEV_FEATURES) &&
>>
>> Not sure if the cpu_feature_enabled() check is necessary, as init should
>> have failed if SVM_SEV_FEAT_ALLOWED_SEV_FEATURES wasn't set in
>> sev_supported_vmsa_features.
> 
> Two things missing from this series:
> 
>   1: KVM enforcement.  No way is KVM going to rely on userspace to opt-in to
>      preventing the guest from enabling features.
>   2: Backwards compatilibity if KVM unconditionally enforces ALLOWED_SEV_FEATURES.
>      Although maybe there's nothing to do here?  I vaguely recall all of the gated
>      features being unsupported, or something...

This contradicts your review comment from the previous version of the series [1].

If KVM enforces ALLOWED_SEV_FEATURES, it can break existing VMs, thus
the explicit userspace allowed-sev-features=on opt-in [2].

Thanks,

Kim

[1] https://lore.kernel.org/kvm/ZsfKYHFkWA-Rh23C@google.com/
[2] https://lore.kernel.org/kvm/20250207233327.130770-1-kim.phillips@amd.com/

