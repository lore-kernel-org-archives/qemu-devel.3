Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2099A1125857
	for <qemu-devel@archiver.kernel.org>; Wed, 11 Mar 2026 17:56:31 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1w0Nn6-0005g0-M0; Wed, 11 Mar 2026 13:56:17 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <nathanc@nvidia.com>)
 id 1w0Nmg-0005YN-Bz; Wed, 11 Mar 2026 13:55:54 -0400
Received: from mail-northcentralusazlp170120005.outbound.protection.outlook.com
 ([2a01:111:f403:c105::5] helo=CH5PR02CU005.outbound.protection.outlook.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <nathanc@nvidia.com>)
 id 1w0Nme-0006rI-Ep; Wed, 11 Mar 2026 13:55:49 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=jkxA3tU4Hd63kaq+8ZfaZgpDFXGcOoTk7HxKcIzgMaIf++yuDumUTiCL0KB6ZhqiI1q+Cn1AUA9A/GBcxuiWEHQGOzdylwhTWOpM9Fo+iqfgpcUBMDELMscScNBkA8aKMPxHKYdivU8ESxXn1IbFQFVs9DZpDdWQ9nIo01+tfeNYZ1BK9wsNyDstv9zNESbya6Uv2/FSB8h6M6TO9Cvg2n16Vjz0WsSHKW1V/bmy2yO872jVGAg3MbPiY3jPov2ShMzqqt3dqQsLjkX0Q65xFmH+YRTUHB5gTWmtx+E9tmWI8d/trDhsT95Cwr9XwfUHec+fn5J3QWpw8vC1dLvZuw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=oXG698npVbJzU9lzFWsCNfNap+qoxPG5BKUKJaVY9jc=;
 b=zAwsX6cvCVwnIJQ2Z0xTGHlPosbH0mR6EvsWHpZgrZy3IN8m2KkyGg2EVCeoLZnDl1UQSVE/pTErPAaEqqMhWAby2TpT+IAAA2c7IxMyz9lXlzTUAvPHE1AhoTCoTRfvT69iiSosdaBP+tI5CAzsnk5c0dqQg0BuC/5BuL1rvsvT5bAJINWH1ct77U46oJGc9V3xcm819MAfay0znJYwQ/uj/3iojgQ5Jkd5RdnQbJSnBEJUbS5DZJH8bhaL5vjPKF7nxqfGUF+i1Mf54lr4lqmoFX5cD3oNzD5yV+b0uWSgwbgmqwo4gt7C3WgLnYNSQ5ciLu/nZ66b3l8sGJXzcA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=oXG698npVbJzU9lzFWsCNfNap+qoxPG5BKUKJaVY9jc=;
 b=VZ6kL4XbYi2yGEBu2swAMZaiaKYFuX2g6jB2ADhEqwmj91SgCeNabuRe6QKOKtBMjFaS+3UaQnBTWyvGypp8L0pI4RbqdcUxjuZbCLbWClDBRqHpDnzJPC00hrXWbWXAscAoYvbD2tsDxSph3IrTGF3C/cplj7XCdeEGPbgkU/FshGsumLtnYYx+DX0Gw+SR0IBaFmEJk2BuE52wxMv8JqrMJ8mhoQF+603KTIIsBtSGePV5kMaoewyD3J476Z01EJay6nl6PJtt21z3EGQR6UZkmQUt7Jw80RdT3lTR1ACQ4lQqJB/XPNhAZdbEGRnJHFdSxKMLUzqgih5PuNT1Jw==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from DS2PR12MB9567.namprd12.prod.outlook.com (2603:10b6:8:27c::8) by
 DM4PR12MB6135.namprd12.prod.outlook.com (2603:10b6:8:ac::5) with
 Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9723.4; Wed, 11 Mar 2026 17:55:40 +0000
Received: from DS2PR12MB9567.namprd12.prod.outlook.com
 ([fe80::636:1b52:24ca:d7e5]) by DS2PR12MB9567.namprd12.prod.outlook.com
 ([fe80::636:1b52:24ca:d7e5%3]) with mapi id 15.20.9700.010; Wed, 11 Mar 2026
 17:55:40 +0000
Message-ID: <33209425-ff30-4106-827f-a12a86161afb@nvidia.com>
Date: Wed, 11 Mar 2026 10:55:37 -0700
User-Agent: Mozilla Thunderbird
Subject: Re: [RFC PATCH 0/8] hw/arm/smmuv3-accel: Support AUTO properties
To: eric.auger@redhat.com, qemu-devel@nongnu.org, qemu-arm@nongnu.org
Cc: Yi Liu <yi.l.liu@intel.com>, Zhenzhong Duan <zhenzhong.duan@intel.com>,
 Peter Maydell <peter.maydell@linaro.org>,
 Shannon Zhao <shannon.zhaosl@gmail.com>, "Michael S . Tsirkin"
 <mst@redhat.com>, Igor Mammedov <imammedo@redhat.com>,
 Ani Sinha <anisinha@redhat.com>, Paolo Bonzini <pbonzini@redhat.com>,
 =?UTF-8?Q?Daniel_P_=2E_Berrang=C3=A9?= <berrange@redhat.com>,
 Alex Williamson <alex@shazbot.org>, =?UTF-8?Q?C=C3=A9dric_Le_Goater?=
 <clg@redhat.com>, Eric Blake <eblake@redhat.com>,
 Markus Armbruster <armbru@redhat.com>
References: <20260309192119.870186-1-nathanc@nvidia.com>
 <a9c03e3c-448e-480a-a6dd-b3c4c7903758@redhat.com>
Content-Language: en-US
From: Nathan Chen <nathanc@nvidia.com>
In-Reply-To: <a9c03e3c-448e-480a-a6dd-b3c4c7903758@redhat.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: SJ0PR13CA0082.namprd13.prod.outlook.com
 (2603:10b6:a03:2c4::27) To DS2PR12MB9567.namprd12.prod.outlook.com
 (2603:10b6:8:27c::8)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS2PR12MB9567:EE_|DM4PR12MB6135:EE_
X-MS-Office365-Filtering-Correlation-Id: 12d7a2aa-5c39-4423-284d-08de7f976841
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|1800799024|366016|7416014|376014|22082099003|18002099003|56012099003;
X-Microsoft-Antispam-Message-Info: DnCABXT0soPIM89NWQmh1ue67saGoazat9vKHotAYK/hHz9A9yxsfGNfVhUFvvJ7GMDaoT/+imSUA5N6Ob0KYoqG1CPKWd0W5rRVRhp28x0lLCNDoXmZ1nlyxe/AZewfDddZMIzgPr3AG6WvvP2EknXcxwS01edYKagXdSvR136eVr+jL/9gviYR3sD30Z0hV5e6MgTOjB9tTHISbEF1kXoT1j1b3zfuAIOTSmQe8Xy41ZKnGJWQVMXX1fAx+TCQRh93cIXP7vuiO3se5V8y8WUyA4TkgLjz7gPAD+VYLz3HXrWEcxG0qT0wm8NQeqdn81r6+AnFwI87YDGfj6xsfj1Muue2ityZSCfu5d4l6i2En26gwkFfWz8cEXEPSmYMzEnM3AuLsB3zz9iw3kuMqALuvIfjCVrb9bimpWAKIjl0yXe+vlX38s600ODU6zSEee+Q9gcR9MGJHkWVo13VrvcbGfgXSd3f9Bm2gaIUCMxEMC9+KaUZCNlUHBxhH4j/tz4NCwGipX6S7AygT7mGxDY3oJHNA+elnvrZvx3vXZ7f4VjmiuQm7m54SlcZ36DOrqmTpa50wMg1reoiruL4vritS85muk2rd7I4gAhkDVAkWlCqAdI7+u59RF+DfGg3y/DUMx1RzgO+ojMfHqAr1Cd3K3DLE+/iMGVNvVETgk8IriMsvqY5I8+a11eslqFx
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DS2PR12MB9567.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(1800799024)(366016)(7416014)(376014)(22082099003)(18002099003)(56012099003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?TUZEVm1EVjdrNzh2c05YbVpFRkpGMmJkVDVnU2tRWnQxSkIwb2FJdDJXY0lY?=
 =?utf-8?B?MkZLcTlvQ29oU0V6OGw1R0psNjhaZDJvSGpPUHF0N1owY21lTGMwTXRDeitI?=
 =?utf-8?B?MlVzc0VINzNjTWt4a1gwaU43UElqUFhraUMzN2F3WVArZzFHOTNCUDdYL0ZR?=
 =?utf-8?B?QmIvZGZocUdsZXlCZzhpL2tlK0htRU92SW5aazZ5eVhJcDlPcVVXaUNMd3pt?=
 =?utf-8?B?bGZEeFdCb0R5eWJFTlRWMzZoTjQ1MjAxNUZrbkVkbFV2UlVuTFRhQ0thVEl6?=
 =?utf-8?B?YTFKckwrblNBT0NDRzA3QW92YTF5bi91QzdQbWM3QlhnVk5hcVF0dWVKY2JZ?=
 =?utf-8?B?NmhQMEpHd3FQeHNMSVVGWEJKenpuUUJoZkJFRjY5WjVNY1piVXZRS3lIY2t3?=
 =?utf-8?B?QXJhNlc2SnNNWmVvN0FGN3hsY1RNR3IyV25xUzZKUS9ZOGpERFJTN1kzMStF?=
 =?utf-8?B?ZG10ajlrdTBoSlk4dndFQW1LVGJtS2M1ZUZlTURRc2FHSGVRVUs5VXJUSXJo?=
 =?utf-8?B?cVhieDlQRmNFYjM4WCtqSFB6K1JvM0h2L3MvTWZ5Tkt5Sk9VUXJuZW9jUUls?=
 =?utf-8?B?ZmlTOFVqUCtNWGhsdWJLdmx2N0hVWE9BZ2tacVViYm1IRW54cDlub2xLN1Q1?=
 =?utf-8?B?TlN3SUZPTEo1Sm9hR2xVNUZTQVhhUHZmY3Y2VUxhWkNpLzdUNXV6L2hENnRY?=
 =?utf-8?B?VjY4YnNhTWdvaUZFUzF4cmliWDFUcjBhb3JyOE5xbjFGR3BneFJPNmlYSTBX?=
 =?utf-8?B?SnRJZmV3dmNEYVhPbitTUzM4amFZaCs1ZEhPWjJ2N0pBa3psZGdlUGpqNEVk?=
 =?utf-8?B?NXcxZUNwVWhjNWRidUFZbDNWcFpnZmdPNkd2SlZJa21nV3FQWEFWdjJFNlpO?=
 =?utf-8?B?TW5QWFVERVB2b1lDYkdaNzM1VlBTbUV4OCtwUXRUZk5ncEhHMTVDcHFscmQ2?=
 =?utf-8?B?eXBueUhkb2VNSFZUcWZ3K3EzRkZTaFJDd0Z2SWdnZ0l4cnF0UkloL3pxWWUy?=
 =?utf-8?B?M0NGaitHeFgxeVFlcVByZ252aUFvWUJUMG9QTk5EQkxsZi9CRnFMdDBsUXZL?=
 =?utf-8?B?dEE3T1pWQ3R1ZFpTT1JFTSsrdUVEUExoWWVFUE5Bdnp3d0FmaEFmTWU3akVB?=
 =?utf-8?B?b0s2Rno4b3UyaFIwcW8vZ0gyYXF5WEg5UUFvNTMzbWJMYlE4c0grOUN5R2Zl?=
 =?utf-8?B?aXg2SWJmTjRUZXdRMWZsRm13ZlFvK0h5T00wd0JXM2ZraWhJbXlqZjE4ZFBG?=
 =?utf-8?B?S3RuazlXcDNJZS8xaFRFY0haWnRlT2hjRXg0UWxVY0tPVVNpNHdLTEM2VWUr?=
 =?utf-8?B?SFB5bHA5dWRMbWhKNEFtVkE0L0RqdWNtL0duKzBnb21LOXIyakVIV1FtVzhO?=
 =?utf-8?B?Rjl0c1BsT0xIbGhmdkEwcWI2YjNwQ2xyanF4SWNobWtGazFpTkpremdwS1RG?=
 =?utf-8?B?dWp3RUhaa25pay9Ebm9uUXNvV3J4dzRGMWtZZzh2VHEyZFJzNnlVQVo3dEJT?=
 =?utf-8?B?ZGlyaE4xWjVpQkxjUGZtLzJxNXRSTlVwUVFOSHJIdWhxeFhERk1SbGtjclBx?=
 =?utf-8?B?ZHpubHQ2TXNmZ2tnRDRKVW8vQmVVdVloeENqSmUwajlnN0FzaUNNQVEwT1dm?=
 =?utf-8?B?S1NUVDhOTVNuaXNtYWlSUXZWZXBTK3B1blZIck1EOFB0SUg3YVNPcldSeHdR?=
 =?utf-8?B?b2puUU4rMG9Vdm80anNLQ20rcUFRZk9oMmxwVGQzUUFIaHM3ekxTVGp5Q0Jt?=
 =?utf-8?B?VnhkaGJSc3libm1wbmN2VWJEUU9hWjNENVRQU3RwZFJGRVpRRE1JMVo2aGUz?=
 =?utf-8?B?R08zL0RHUWc3L3hMSm5QWm4xcUs0bTY1Mko3UFZYc1VQL093OU1QckZlMkxW?=
 =?utf-8?B?cWJiTVBEQWZMa0Y3M2U3MUpvZEl2cWNLZFRlbTRLTzdXMi82Z2ZKOU53bXkz?=
 =?utf-8?B?ZG0wYXJhdVhudkNROCtuVkpOWWtrd2dsc09VWmpsVHltdFc0L3BMM1owVjBN?=
 =?utf-8?B?ZUhXb29aY2dwZS9DeDhsZWUzNVoxQXd0UW5zVGJBQ2hZSE5wQ1ZoK2l4N3Fm?=
 =?utf-8?B?aGZJZDJKcXRjdFhjUmJKZ3dRZ3ZPT3FsQTE4a2dKbDlpREtJQ1RsMDMrQXQy?=
 =?utf-8?B?NFJOa3JLQ055TTZwMHRIc3ZSSkVZV3V0elh6NXVPZ3BocHlhZkRtdjlMWEkw?=
 =?utf-8?B?Y0w2WkxHM2FIWkVqQlJsMllhZ0RWN3htZjRqZ0V2d1A1U0VrdXJpVjFwdi80?=
 =?utf-8?B?QmhjcUtJWExpMzNwczU1SDlVVlc1VzJ1TzVZS1Y0RkxPRFVteWFYQ2U2dW45?=
 =?utf-8?B?ZC9YVDhKandkc1I0dG8wOGdBUlFXYkFYRkNPT3RRYnRSZGRpaUx1UT09?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 12d7a2aa-5c39-4423-284d-08de7f976841
X-MS-Exchange-CrossTenant-AuthSource: DS2PR12MB9567.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 11 Mar 2026 17:55:40.0565 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: Jjw5MqVuyMRCcbJjNYJaQAggf1kvV2YAG6ifVSV1SMdkL1mh7duDYEFynkvf1/D5NvpnYzqx0Kluhyh1cQ4qBw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM4PR12MB6135
Received-SPF: permerror client-ip=2a01:111:f403:c105::5;
 envelope-from=nathanc@nvidia.com;
 helo=CH5PR02CU005.outbound.protection.outlook.com
X-Spam_score_int: -10
X-Spam_score: -1.1
X-Spam_bar: -
X-Spam_report: (-1.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 FORGED_SPF_HELO=1, RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_PASS=-0.001,
 SPF_NONE=0.001 autolearn=no autolearn_force=no
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



On 3/11/2026 10:43 AM, Eric Auger wrote:
> 
> On 3/9/26 8:21 PM, Nathan Chen wrote:
>> Hi,
>>
>> This series introduces support for specifying 'auto' for arm-smmuv3
>> accelerated mode's ATS, RIL, SSIDSIZE, and OAS feature properties.
>> When set to 'auto', these feature values are derived directly from
>> host IOMMU capabilities, avoiding the need for management layers to
>> introspect host settings.
>>
>> Accelerated SMMUv3 Address Translation Services support is derived
>> from IDR0, Range Invalidation support is derived from IDR3, Substream
>> ID size is derived from IDR1, and output address space is derived from
>> IDR5.
>>
>> Additionally, an OnOffAuto "ats" property is added for vfio-pci devices,
>> where setting 'auto' detects the per-device presence of
>> IOMMU_HW_CAP_PCI_ATS_NOT_SUPPORTED from the kernel, and the ATS cap can
>> be advertised or hidden by setting 'on' or 'off'. This is dependent
>> on Shameer's recent kernel series for reporting effective ATS support
>> status [0].
>>
>> The default values are set to 'auto' for all properties.
>>
>> A complete branch can be found here:
>> https://github.com/NathanChenNVIDIA/qemu/tree/smmuv3-accel-auto
> I have just noticed we are missing documentation for smmuv3 accel options in
> 
> qemu-options.hx
> 
> At the moment we just have:
> 
> ``-device arm-smmuv3,primary-bus=id``
>      This is only supported by ``-machine virt`` (ARM).
> 
>      ``primary-bus=id``
>          Accepts either the default root complex (pcie.0) or a
>          pxb-pcie based root complex.

I will add a commit to include documentation for the smmuv3 accel 
options in the next refresh.

Thanks,
Nathan

