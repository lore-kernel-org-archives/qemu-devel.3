Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id F38B7F5A8C9
	for <qemu-devel@archiver.kernel.org>; Mon, 20 Apr 2026 22:32:41 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wEx9w-0003bh-Ho; Mon, 20 Apr 2026 18:32:04 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <nathanc@nvidia.com>)
 id 1wEx9u-0003ay-5m; Mon, 20 Apr 2026 18:32:02 -0400
Received: from mail-westus2azlp170100005.outbound.protection.outlook.com
 ([2a01:111:f403:c005::5] helo=CO1PR03CU002.outbound.protection.outlook.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <nathanc@nvidia.com>)
 id 1wEx9s-0002aD-Es; Mon, 20 Apr 2026 18:32:01 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=XIbRyJTjbP36hsB0QtT3iUEVrTYhyT2Q6nd/yZG59S8Wm4iSU/ZYeweGBgoGbwWjYaTVINBRAjClW4dVngzmgnJKrCi2AJUXFZLw4YnlDLlrbF43mdxnCQdmbDmNiKNGies6TC/OMlbSp2aGuGrhAcGZ6Ucq59ACh+KOQuyjtPQfZDm2EqQnmrUOOFjzS6AddXeCaJp8mIJ0e24HCd2/bjjcVMY5PbnN0JU/6mz+1BTIjcPL3M7V106UW4tGMX/do2ItVwqZU0k4UMqB7sH9/3bdSOFCjm1HjV8QEfAcn7YQur3+1wzV7uM51PBS5VFxnj9+8JdBw9mXrlKezgoucg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=EvEhv6HEatNHI4+B4BdBOwENyDAWSqeNWgsv482gv2U=;
 b=Od2oxOOHNn4ol6VZ/jIPfSpC9E0T1aiDn8Ie/4rWOtFt9UGLx6GzVSgnclhshaFfvns1BlKVI1FaZj5zC3leIHU6zZMIunEnQNK/l3Pd7Utt1/bXG0svEoS1b4kJ72volLs++60x6yl6tSZTZ9tb3FXxfTgdO1qCQjWOhEIfrvx2/UFdMN6iyshWe8U+4b+U8x2nT4QAT0aUvoJpFM69dtjMTnS6CmgLO8iNsWXdCFAXb4U/54nKDA51631EeRDsV9Wh4QWBCt0CWsiAwl+c8/W3Fh3FvYc20d3157EYb24JuCOuJA1Yw3OyODI3vm9aE+P04RA9P4muz+XFUACIzA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=EvEhv6HEatNHI4+B4BdBOwENyDAWSqeNWgsv482gv2U=;
 b=a4cV6bUTUnEK+GxPJ1kNO19GNjTDavtuVf1Eu7+3vax6xcC/M7DT7hReTO7vjGCFcAS0n+9uuO+5kLtzyR/JqKi+MYO3JAsuhOMvxS/+5lDqmijmEKZ+Q0gLYl/O/dbQsfqchUC1wZguMSMrQEu2mINZg349qUuv/nSUCdPcfzyBFjXK6WVeVuZR/TwvO68NAU4sr8iEggcd0hftALwJ3yDtyVSrRDHce4gSS3mCbQ0TWnHzVMiY5zXVvggMOrh0dp+2xE8woWGeHFJdD9hN74wjfF1JgnxcMNdyv9FQin/vl511ytpl5+H530rLzOXzGXsdmOJR81aXJN4sS20P5w==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from DS2PR12MB9567.namprd12.prod.outlook.com (2603:10b6:8:27c::8) by
 CH3PR12MB8879.namprd12.prod.outlook.com (2603:10b6:610:171::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9846.15; Mon, 20 Apr
 2026 22:31:48 +0000
Received: from DS2PR12MB9567.namprd12.prod.outlook.com
 ([fe80::636:1b52:24ca:d7e5]) by DS2PR12MB9567.namprd12.prod.outlook.com
 ([fe80::636:1b52:24ca:d7e5%3]) with mapi id 15.20.9846.014; Mon, 20 Apr 2026
 22:31:48 +0000
Message-ID: <9ab16130-a589-485d-a3fb-49b3569219d6@nvidia.com>
Date: Mon, 20 Apr 2026 15:31:45 -0700
User-Agent: Mozilla Thunderbird
From: Nathan Chen <nathanc@nvidia.com>
Subject: Re: [PATCH 09/11] hw/arm/smmuv3-accel: Implement "auto" value for
 "oas"
To: Shameer Kolothum Thodi <skolothumtho@nvidia.com>,
 "qemu-arm@nongnu.org" <qemu-arm@nongnu.org>,
 "qemu-devel@nongnu.org" <qemu-devel@nongnu.org>
Cc: Yi Liu <yi.l.liu@intel.com>, Eric Auger <eric.auger@redhat.com>,
 Zhenzhong Duan <zhenzhong.duan@intel.com>,
 Peter Maydell <peter.maydell@linaro.org>,
 Marcel Apfelbaum <marcel.apfelbaum@gmail.com>,
 =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Yanan Wang <wangyanan55@huawei.com>, Zhao Liu <zhao1.liu@intel.com>,
 Alex Williamson <alex@shazbot.org>, =?UTF-8?Q?C=C3=A9dric_Le_Goater?=
 <clg@redhat.com>, Matt Ochs <mochs@nvidia.com>,
 Nicolin Chen <nicolinc@nvidia.com>
References: <20260401010231.4166776-1-nathanc@nvidia.com>
 <20260401010231.4166776-10-nathanc@nvidia.com>
 <CH3PR12MB754858C236A5322833654F34AB232@CH3PR12MB7548.namprd12.prod.outlook.com>
Content-Language: en-US
In-Reply-To: <CH3PR12MB754858C236A5322833654F34AB232@CH3PR12MB7548.namprd12.prod.outlook.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: SJ0PR03CA0390.namprd03.prod.outlook.com
 (2603:10b6:a03:3a1::35) To DS2PR12MB9567.namprd12.prod.outlook.com
 (2603:10b6:8:27c::8)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS2PR12MB9567:EE_|CH3PR12MB8879:EE_
X-MS-Office365-Filtering-Correlation-Id: 3ccb0f62-23c1-41ed-d99c-08de9f2c9c09
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|1800799024|366016|376014|7416014|56012099003|18002099003|22082099003;
X-Microsoft-Antispam-Message-Info: C48qvM6qvbXO1oQ2vxymQQenh92vdPulJVw3DvIrKv8ue30yWSAdymd/9ETPQ43n7LrfBKOPsYopvFZzvbmRm4qQd5RXPLBuwdNjJLAInA6sQpNDNByQKvgGW24kZl0OddZiqQF/b39nSbozbSO+8QaWUGcxHDr4EYch0Euz+GyViqc2mYAgR2SuThVy3gn3sVr4m0IkRcEHlrX+m5sQm+WIa+0oJzDcSDqpeVat5u0UrwMsT9oBwixtnXqJy0yQS/YSrtSeRc4zzicbgf01lk1AUsZy551s/sXNdL4EntI0UmwO4s3YlanJPnAhisswPxgquMilfFveAEaWV+lnXJ++nULkYBUu2S69rnn64a2i8NHmTxUEaRjNcxp8deBnXHaN76JRQgO3tfXnzZjfHMQE5/PUjyoRve7CinkxuohxJCJCm4sZno6g3o9v2b8KQKZQd6g6dc2+8OfP0BP3kHpWX8ovKAIG2DFeKAkCxLcLB8rnOHrSe4hRDpQeud0PClEhBOu4ytsxyWEiTAV4IBQsYLI8X8hKZtT/pJ6gzBbwjg30CD+7HInY2ERAJkDpnmBoMK3EHcdBfrG/Akd73OxU0UeUn4bl2FC7v0lYCLHgNuaTsD/ORq09qQ8lWiy2/l2TZZ/QZDNIj6mtsobqIp4YKViG9h4VltlgEE7U0lgIPHZROfZ/ZKHYDlHxu2Jo8cc4sveZbWqYNjYCrf0N+k0anJxjri462Vi5VrQvAc4=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DS2PR12MB9567.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(1800799024)(366016)(376014)(7416014)(56012099003)(18002099003)(22082099003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?M2g3dytLTHA3QmtFMGdtSzRDWTJwVmc2WEhpKzUvWUhndGw5dkV0dTVORlFJ?=
 =?utf-8?B?SkcybVdyRmY1MWZDeUNRNkZqSFV0dmhBZk4rNkpTOVJCYW1LUXFUS0dNUXlj?=
 =?utf-8?B?d2JQeEdET21CQTRaWUE1cjBScWlyL25LYUozem5OOGVMZ0k0WHhsZ3RHeTd3?=
 =?utf-8?B?RThrMCtld1lpN3ROR24vWFVLdkJadm0rSXFoWnlVTGl0ZExJdXdialZodUNS?=
 =?utf-8?B?c0NMaUpjK3plT2JDaDlDUmpQWTNKRlRjR2ErVXVPOGQrVlp0bSt3UklvWUdj?=
 =?utf-8?B?MVNKTHNPNkZZV1N6bFVFUUNTT3BORE4yQU1iU3JjOENrcHYrVExhMGlZbCta?=
 =?utf-8?B?OVZuOGJGakpFcXpTUG5nci94MUZjNGtQYmljMFRmQTk3dkY5d1ZWV3JnZW1k?=
 =?utf-8?B?dDVXMzBvaWVua3Q4MDhGbFhQRFU2Q0gxSW5nWno4Smh6UHI0TG50K0JGWVI0?=
 =?utf-8?B?clQ5elFjODE2OHRncnJ4TVVFU1VRaVVmRnpkZHovUzI3ek1ORUNqMkh0akVi?=
 =?utf-8?B?a3VhYllMZkl6U3Z3NTY2Y3F3SzUvRkFqK3N4L2EyRFc1cDlvMlpKSWE0MmZ0?=
 =?utf-8?B?YW9Vb1ExRDhaMm5lMEpUTm9UeFJORWVPVTNTaWQyL1pyUEZBbFNyaGJoZ3lO?=
 =?utf-8?B?WCsyMTNBSlhWQ084WFhwMGFOVTBXYk9ZK2Y5aURIK2xrVXNocUp6VnZ1cWVP?=
 =?utf-8?B?REVaWklGTk0yTWRmbVNYck50dVJnMjVNWnBocTU3dEhSL0lMNlRMeHZZSzRJ?=
 =?utf-8?B?ZXRzK2NRSEFkUEJqS1pXRUhUc2tnTm85NlVBbkhvU1VtZDQrU3g0TXZrUENZ?=
 =?utf-8?B?ejVWY2JRZ2ZwcEk5R0x3blNmSW9hZnhtTDlrTjRVOG10dVNjcE8xSXF1VWl1?=
 =?utf-8?B?cUdyTXRTZWI3R3VlTUc2TStGQ3lxdGJPU0h2WVdpZG5RcTI3N3UxWHFZV01R?=
 =?utf-8?B?TEJqYzAxeWJBYzlSNnd1L2w2eHBXcG5ySTlSRFRvT0V5ZkVHbGNMUDMrSHUr?=
 =?utf-8?B?N2JmUk5OQzdDZ3FQT0xHUExGd3FTbm1FUm1VamRFbTUzb0RPMVFhVTVYOG9x?=
 =?utf-8?B?ZWJuYjBQSzFqTmp5Z1duSDBPaXp1aTB3REV4eUJKN1laTWM4WXppTkp2YVM0?=
 =?utf-8?B?dnIyZGFoVHR4a3lXODQ5OTVRSXhsQ2UvZXlHTzJyWWhGTWVLb3FvMGhZUG5Q?=
 =?utf-8?B?SzEvcXZIRmJuTjh1WVFHcEJkSkE2MlVNeTVBVzRyNnV0Qm50RTlSdlR4QmRD?=
 =?utf-8?B?MjlOTXY0aHVJbzFzV21ib3BXVWtuSzQxREhMbm9HT25HeG9iK1B2blNHOVlN?=
 =?utf-8?B?ajY1d2dHdElTeWFLT2Vvd3FYMEVrYVkwMW5xRHpCMmRvMmFRWitrdHVVNURT?=
 =?utf-8?B?MkE1cUIvR09RVUxkL0tGK01CWXNRM0xnbUZwWmZPL2pRTm05Wis2MnBkdjJr?=
 =?utf-8?B?ZDArK0Z0Y0FCa2JZOEZBTkJ0K0F3N0dzczZlQ0I3OWRZWnd1OE9uTk1TQXhU?=
 =?utf-8?B?bkxEUm9DZDhQcVFzWVRYaGhXUmpKZFpKc0thaS9WQS9zcnVLdVJUazF3Z2RR?=
 =?utf-8?B?VmJ1TC9LZWhzcGFoVnVzVVpFOGhHNzU0SUZwQXZ0Wm56dTl2Z2IrWGVlWm84?=
 =?utf-8?B?S1F5V24wM25oempXRTgrN0dNT21Sa2x4czhDNnZRS25KVFRvcExmYVFvQUJo?=
 =?utf-8?B?cy9oSXk3ZGZxNXo4eUthT0JnN1hXbkJBa1llK3plRHlpWWtDbzcrUCtBc1h4?=
 =?utf-8?B?OEdINW92ZDY1MitET2JUNzRSTko2ZU1CRHlNV2FadlZ1eUw3U3hGU2FOQ05D?=
 =?utf-8?B?VDRSNlhhV0Y2cklMTWFGTzdTV3dCTzRHaTRDUi9kSFZYcjhZSVkwVVBIcmNG?=
 =?utf-8?B?Vk53TnNVWjdUT0g0a081bGJkZWZKbm9hL0c1bThadkdyMERpRmxjdUMvaXlI?=
 =?utf-8?B?aWhDWTZ3M1NzeEREMWNUQU9rbDdmVFJOS1dacE9yK0JVK1RadXd3TS9LUnc5?=
 =?utf-8?B?NURkTk5HZzRpcVQ3d1d1dFpadGtGQWV1Z3FKOUR2aDZNV2RtYjcwandjMkEr?=
 =?utf-8?B?TVVxSFQ4V3JuRHVrSTNBb1pFdnp3UC93TFNTK1JNL0lTbStMRzd3SXlvUytD?=
 =?utf-8?B?dUJsK081NThlczR1cXV0V0g1b295OVh5TyttcFk5RkF5TmdKV01nZDhIUllk?=
 =?utf-8?B?NUNpRnRXMFBSaWF5M0srU1BYcFNtbjdjU3FsYTkyQllGZ3JBZlFBTmtmZ1Zo?=
 =?utf-8?B?Q2JuTko2YUZrZ0RTOGwyemQvQmlPNWlhWkFQQnQrd2xIbDhWNzJYblFYMlp6?=
 =?utf-8?B?a3hkM3pHalBBWE4yRXROMnpDMC84T3hJc3RNVXFPNlR0TXJHZGFyZz09?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 3ccb0f62-23c1-41ed-d99c-08de9f2c9c09
X-MS-Exchange-CrossTenant-AuthSource: DS2PR12MB9567.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 20 Apr 2026 22:31:48.0334 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: ZZJztjOPwo3EHcRiRUjivFYC9AzoGcYg/mVFNesiVKMcayt71K+pP5iOrS7itvmhWMSOONeisq/tOOKvKy7mzg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH3PR12MB8879
Received-SPF: permerror client-ip=2a01:111:f403:c005::5;
 envelope-from=nathanc@nvidia.com;
 helo=CO1PR03CU002.outbound.protection.outlook.com
X-Spam_score_int: -10
X-Spam_score: -1.1
X-Spam_bar: -
X-Spam_report: (-1.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 FORGED_SPF_HELO=1, SPF_HELO_PASS=-0.001,
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

Hi Shameer,

On 4/16/2026 7:08 AM, Shameer Kolothum Thodi wrote:
> 
>> -----Original Message-----
>> From: Nathan Chen<nathanc@nvidia.com>
>> Sent: 01 April 2026 02:02
>> To:qemu-arm@nongnu.org;qemu-devel@nongnu.org
>> Cc: Yi Liu<yi.l.liu@intel.com>; Eric Auger<eric.auger@redhat.com>;
>> Zhenzhong Duan<zhenzhong.duan@intel.com>; Peter Maydell
>> <peter.maydell@linaro.org>; Marcel Apfelbaum
>> <marcel.apfelbaum@gmail.com>; Philippe Mathieu-Daudé
>> <philmd@linaro.org>; Yanan Wang<wangyanan55@huawei.com>; Zhao Liu
>> <zhao1.liu@intel.com>; Alex Williamson<alex@shazbot.org>; Cédric Le Goater
>> <clg@redhat.com>; Shameer Kolothum Thodi<skolothumtho@nvidia.com>;
>> Matt Ochs<mochs@nvidia.com>; Nicolin Chen<nicolinc@nvidia.com>;
>> Nathan Chen<nathanc@nvidia.com>
>> Subject: [PATCH 09/11] hw/arm/smmuv3-accel: Implement "auto" value for
>> "oas"
>>
>> From: Nathan Chen<nathanc@nvidia.com>
>>
>> Allow accelerated SMMUv3 OAS property to be derived from host IOMMU
>> capabilities. Derive host values using IOMMU_GET_HW_INFO, retrieving
>> OAS from IDR5.
>>
>> This keeps the OAS value advertised by the virtual SMMU compatible with
>> the capabilities of the host SMMUv3, so that the intermediate physical
>> addresses (IPA) consumed by host SMMU for stage-2 translation do not
>> exceed the host's max supported IPA size.
>>
>> Signed-off-by: Nathan Chen<nathanc@nvidia.com>
>> ---
>>   hw/arm/smmuv3-accel.c | 9 ++++++++-
>>   hw/arm/smmuv3.c       | 6 +++---
>>   2 files changed, 11 insertions(+), 4 deletions(-)
>>
>> diff --git a/hw/arm/smmuv3-accel.c b/hw/arm/smmuv3-accel.c
>> index 03393fd7ba..105f6d26bf 100644
>> --- a/hw/arm/smmuv3-accel.c
>> +++ b/hw/arm/smmuv3-accel.c
>> @@ -63,6 +63,12 @@ static void
>> smmuv3_accel_auto_finalise(SMMUv3State *s,
>>                                  FIELD_EX32(info->idr[1], IDR1, SSIDSIZE));
>>       }
>>
>> +    /* Update OAS if auto from info */
>> +    if (s->oas == OAS_MODE_AUTO) {
>> +        s->idr[5] = FIELD_DP32(s->idr[5], IDR5, OAS,
>> +                               FIELD_EX32(info->idr[5], IDR5, OAS));
>> +    }
>> +
>>       accel->auto_finalised = true;
>>   }
>>
>> @@ -962,7 +968,8 @@ void smmuv3_accel_init(SMMUv3State *s)
>>
>>       if (s->ats == ON_OFF_AUTO_AUTO ||
>>           s->ril == ON_OFF_AUTO_AUTO ||
>> -        s->ssidsize == SSID_SIZE_MODE_AUTO) {
>> +        s->ssidsize == SSID_SIZE_MODE_AUTO ||
>> +        s->oas == OAS_MODE_AUTO) {
>>           s->s_accel->auto_mode = true;
>>       }
>>   }
>> diff --git a/hw/arm/smmuv3.c b/hw/arm/smmuv3.c
>> index cb14a08a66..0ab6d1e762 100644
>> --- a/hw/arm/smmuv3.c
>> +++ b/hw/arm/smmuv3.c
>> @@ -1976,7 +1976,8 @@ static bool
>> smmu_validate_property(SMMUv3State *s, Error **errp)
>>       }
>>   #endif
>>
>> -    if (s->oas != OAS_MODE_44 && s->oas != OAS_MODE_48) {
>> +    if (s->oas != OAS_MODE_44 && s->oas != OAS_MODE_48 &&
>> +        s->oas != OAS_MODE_AUTO) {
>>           error_setg(errp, "QEMU SMMUv3 model only implements 44 and 48 bit"
>>                      "OAS; other OasMode values are not supported");
>>           return false;
> Do we end up now allowing OAS_MODE_AUTO for non-accel mode?
> 
> I think we may need to adjust as below:
> 
>      if (!s->accel) {
>           if (s->ril == ON_OFF_AUTO_OFF) {
>                error_setg();
>                return false;
>            }
>            if (s->ats != ON_OFF_AUTO_OFF) {
>                error_setg();
>                return false;
>            }
>            if (s->oas != OAS_MODE_44) {
>                error_setg();
>                return false;
>            }
>            if (s->ssidsize != SSID_SIZE_MODE_0) {
>                error_setg()
>                return false;
>            }
>            return true;
>        }
> 
> Please check.

We do allow passing 'auto' if accel=off, but in that case 
smmuv3_accel_init() will not get called, so auto_mode = false and 
smmuv3_accel_auto_finalise() will not change the OAS.

If we adjust the check like above, users will have to manually set 
ril=on, ats=off, oas=44, ssidsize=0 when accel=off because the default 
is auto.

Would you prefer we do one of the following?
1. Add the adjustment above. Users have to manually set ril=on, ats=off, 
oas=44, ssidsize=0 when accel=off. Prevents setting auto for these 
properties when accel=off.

2. Add the adjustment above, but if accel=off and auto is set, resolve 
auto to previous defaults before we reach smmu_validate_property(). No 
functional change from current implementation.

3. Keep current implementation.

4. Add the adjustment above. Do not change defaults to auto. Users have 
to manually set auto for accel=on.

Thanks,
Nathan

