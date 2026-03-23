Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4FA2AF483D8
	for <qemu-devel@archiver.kernel.org>; Mon, 23 Mar 2026 17:29:32 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1w4j5D-00069u-Ng; Mon, 23 Mar 2026 13:28:55 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <nathanc@nvidia.com>)
 id 1w4j5B-00069Y-PT; Mon, 23 Mar 2026 13:28:53 -0400
Received: from mail-northcentralusazlp170120005.outbound.protection.outlook.com
 ([2a01:111:f403:c105::5] helo=CH5PR02CU005.outbound.protection.outlook.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <nathanc@nvidia.com>)
 id 1w4j5A-00056P-7G; Mon, 23 Mar 2026 13:28:53 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=B+RCp+Bq5LfUmWoKYG74QCFGmRc7v3BBtYlu+CZ25i7C0KHCI8taA7AoPxlVKlKPCKFhCNr2C6Bf12MvzgkM2C2Nm15md2xOGBkqYOMQTx6ZA3Q7jNwbGReU3ftGmh7s2EHoWKAwIK7gB1dzVb1uv91cJcFtMdV3bZGyWi3roR1K/mE29SBUxo7F82QAcglRsiQ0t8IAngnsuwLh+nLoh7OueVIdknc9kXgdGDhxz/chDxq41OueBWYN/ArnuGj8ucaG6ZsVKFYxM6Fjd5VLaxPZUjr1F0LRDAAImpAOT6mIbSFxGfkt1dKb+Vxa1LotC7/icdFaYou30nBV39oB9A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=AKar1Zti6TLp9T4vbdfe4EdXxl/JQLHhRmV06RAqqmQ=;
 b=ibHtOjXBayUcyghsD2VcGIcpvMu7pC+h0WjjX4sXRtVW9C+q7Vg4ziaRuIjZcr/Y9BCguRsiByMInxO4lFrrNzSLkzefMhMYW4fYlorlAf9z+GS94gPOQH6+nZTq24ME5Hl7JoAljpgZ7l6pIpOIp4LYCyLEDy5uQ+N+tQ/2kqof+nd6/75doJcbIkdj5EfJji4GbHz/pIb0/x7DJ9wNPNZP3lnIQlUvy8FMXyre/3djseChzj64ykMyPehihAjG/nKiRe68Hr3DrLZb7tD2FtmMxdsAd/ZUxm7+4Dr8c+LLZJJOqRa8gBdMzs7zmNrypHcsuXPpTiGgLbgwZq+FiQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=AKar1Zti6TLp9T4vbdfe4EdXxl/JQLHhRmV06RAqqmQ=;
 b=YBqGQzoXhsKSrjWCrNpByxfd+aOLvdpLRvdxYATGbpzw8Dtra/oOYRSaO2J6NTpgwVxGLVgdIqYiwL1yaYxo6usUCTVsaDFe52//xxL5pHwRuXv4cJ0D/4JWfVvp7j2zJIfl91ENGQtGBPDrxIG9DJc4qpV6xZUhO4nn/OSkJ5Yr53QCbeLAFo4uRPaQ13u2N3OQqx0Zp3/kCrIKT/HhwPrGTA/Rcb8RvgBOh/HuDWZVsyIZvwCjxHo9COsfhHCNVlmBk74HBnqXxL15kzdBBe4MjhJPyuBoqilGbtQbVSH27JPHGlb1ssxpXWxihk995BqU80KFijbSnqNzDEPRsQ==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from DS2PR12MB9567.namprd12.prod.outlook.com (2603:10b6:8:27c::8) by
 DS7PR12MB9526.namprd12.prod.outlook.com (2603:10b6:8:251::10) with
 Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9723.16; Mon, 23 Mar 2026 17:28:37 +0000
Received: from DS2PR12MB9567.namprd12.prod.outlook.com
 ([fe80::636:1b52:24ca:d7e5]) by DS2PR12MB9567.namprd12.prod.outlook.com
 ([fe80::636:1b52:24ca:d7e5%3]) with mapi id 15.20.9745.012; Mon, 23 Mar 2026
 17:28:37 +0000
Message-ID: <e855b12b-5e1c-4590-8440-a29155a6c9b0@nvidia.com>
Date: Mon, 23 Mar 2026 10:28:34 -0700
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v4 5/8] hw/arm/smmuv3-accel: Change SSIDSIZE property to
 SsidSizeMode
To: Markus Armbruster <armbru@redhat.com>
Cc: qemu-devel@nongnu.org, qemu-arm@nongnu.org,
 Eric Auger <eric.auger@redhat.com>, Peter Maydell
 <peter.maydell@linaro.org>, "Michael S . Tsirkin" <mst@redhat.com>,
 Igor Mammedov <imammedo@redhat.com>, Ani Sinha <anisinha@redhat.com>,
 Shannon Zhao <shannon.zhaosl@gmail.com>, Paolo Bonzini
 <pbonzini@redhat.com>, =?UTF-8?Q?Daniel_P=2EBerrang=C3=A9?=
 <berrange@redhat.com>, Eric Blake <eblake@redhat.com>,
 Shameer Kolothum <skolothumtho@nvidia.com>, Matt Ochs <mochs@nvidia.com>,
 Nicolin Chen <nicolinc@nvidia.com>
References: <20260318184907.4060030-1-nathanc@nvidia.com>
 <20260318184907.4060030-6-nathanc@nvidia.com> <87341w9ftp.fsf@pond.sub.org>
Content-Language: en-US
From: Nathan Chen <nathanc@nvidia.com>
In-Reply-To: <87341w9ftp.fsf@pond.sub.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: SJ0PR13CA0209.namprd13.prod.outlook.com
 (2603:10b6:a03:2c3::34) To DS2PR12MB9567.namprd12.prod.outlook.com
 (2603:10b6:8:27c::8)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS2PR12MB9567:EE_|DS7PR12MB9526:EE_
X-MS-Office365-Filtering-Correlation-Id: bf001638-fd39-49e0-cf63-08de89019dea
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|7416014|376014|1800799024|366016|56012099003|22082099003|18002099003;
X-Microsoft-Antispam-Message-Info: FDHRYUQ2SyemahxsyuPsgh4AXylC7xvwabxHYrTbWWtKtfpf7Mw/1wMOmn5xd9/wQnoLA+7Kq+pKjz/JxZLUHj+LP1dfkKsTtGLfY9ZPLIAlUbi3qeoC7foWBHYKLUWLxZmEDRcBSExliDxNKhCveghV5ZPRkBfvPA9QcXLgg1Q0GAHOjMCFfstsYJgDHOm9NX1LvcSy5UTB0bbfc1lrd1G0oCxHdqa56OzSzjD3I0YCxFOKNGQmmPF851zrKhn5KEwxhixg9hzGUsD3NOYa2uQy9vDHuwK/axVNnqexmxe4MdGitX6DVuCbx9Hpe1CFkgQAgBcHRYz8E6bqLFtbC0e1oWUKID9LgTM8B+lvZxw91F1zA9BTTMqXqNEqV3zaBMiLRxckm3hd9qH70Hg2J3vwr7kLAUfbuOWMDsS4D0sg1NZkEk1clweFouv6Vz84OdbajNV/paGtrJoqP6w7YAmoQ410QbJRnvgKlVsP9pPtoSgblLIFm6hhLq5fyPN4IVp0e+6+8tB6yv1+Fy+bnX596wDbm616GOu37L0i7P70uq9MQwMA19uQbTWSa7IlA36/5dlituS+NrPgEQMtzV3v+4VSCTsBg9dxQgDirdGTZmeZnlj4R4edDtjcQZOfKPVoOMBf09J15v033vlUQ3jXkhil1Vos/hJ5B1QfbX+b/f2o93qn9A1yBaWV7epDbB7mhtzezJ5TbPsXz823IiCDAK7IGPHXcKZiKDityTE=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DS2PR12MB9567.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(7416014)(376014)(1800799024)(366016)(56012099003)(22082099003)(18002099003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?QnFxbjJoVE5aQ0l3ZnNHZlNaQlMvNDEya2w2dU9FeXo0VU9XcGlpQkNYaUM1?=
 =?utf-8?B?MDYyVkU5RVRSdzl4N3gvdmozZ2Y0Q0FlSmI5OTBicWRRcFdYOG5LZHpmcmZz?=
 =?utf-8?B?a1ZvMUFZVGsxa1JJL3hERWxCQlBYRG92eWdPWjV2cmFmMjlPa2s0U2huYzJa?=
 =?utf-8?B?VE40Rnd2RnVqb3JoTkUvMUpZYXordHJ2UXQ0OGdRU0tOV2dXNmZYbnpJWlE2?=
 =?utf-8?B?RFV1eHlMRnNnUW1wZEtqQXB0L21QVU16RTVmbi9VL05hcndOUGhVSmdPMllJ?=
 =?utf-8?B?VmhqT0JiLzY4WGNvVWt5VGZmRytBY2UyamRPdnphNGF6RzMrWVZYNjl4S3p3?=
 =?utf-8?B?OCswd1hWRDczSDJCbi9FMWFsUmdKRlZFUWU4RXdPWkZueDUzMkNaNXJqRDRU?=
 =?utf-8?B?Wjl1emoxYWRRbGdHK1dQRWV5dk5uMG5CUjJKS29VRVpFY2pwemc5aE9ONTY3?=
 =?utf-8?B?di9wekE3UjdBNzY3NjYyUHU1Y2ZFcjJtc1QxZFl6dkRubjBqbkliWjF1UTdi?=
 =?utf-8?B?R1FLcmx5eFlDZTdyelNkaGNBWDBhVEFCUDVuSDQrRkFvUks4WkV1VzFsdTF0?=
 =?utf-8?B?T1YwemErbUhCVWY4dElwM2lFVE1IYWRtb3RoNjVaSE85c3hkNmdLR0svZTBj?=
 =?utf-8?B?RmVQaE1hZXFJa2FyaG9MdDV2bVA5RFVpbk0vczNKai9xcExHbHVpeDVmSTV3?=
 =?utf-8?B?UWllUyt3b1NzR2wxcDRmMm4wZGpsc2NLWkdmWjZZNFV5TFp4clY5SElLR2Yw?=
 =?utf-8?B?ZEhhZGduYVBEUjkzRnBhQWJEV0Mza3ZRZHBEd0tpV0VMajZWblhxQlZQVFll?=
 =?utf-8?B?ck5SaXdSeDAzVGlRa0c2SGxwN3JFMHJvTFRWR3dMQUo1S0lvRTFxbmJYaEJp?=
 =?utf-8?B?L2xyY3hMcW1ndzVEMG44dkN2OUNXQStsSWtFZmpHcnNmMWJJZmpiZzM2YXhQ?=
 =?utf-8?B?VC81SVQ1ZjdzTDJ0YzlNZk1GcEpINW9ucTZTWElFRURJc0VhRHdGaTA1dWx4?=
 =?utf-8?B?R0R2bSs1YTZXTWo2b1RPdC9KbGJTdm5YQVZIL1ZIMlBuejJnZVdFKzY2OFBj?=
 =?utf-8?B?bkhhdll2UVYvMmRWcHV6Tk82UGhidS9UZ2EvV2JISXVNaW9CaCtyNGRMYU5B?=
 =?utf-8?B?UzN1SUVldTd6aFZvVy8rbGtqRTlxQkRUNnpocjVMNGNwWG8vaE5aVGhFcUFH?=
 =?utf-8?B?QkxGc1NSMGJiL2ZNMkNvTC9XVi9GKzhWWW5HWm5wZFlLZ0IrajFpMXlLQlRT?=
 =?utf-8?B?ZWR6ZWpYNkNpY25HT2FxSU44MDl1aUVGaWtvbEE1NnF3eU1nNGoyQ1MvaWd6?=
 =?utf-8?B?MWgwOTI2amtqV2UwWHFicXBSZ1pXdEpkdUtpUm1NQ29ML1h3NmdUV3pvM01j?=
 =?utf-8?B?VVBiUG1CcUtrL0NybC9yb3NhTjcvZjJOR1l4b0VFY0pGWXZLbWcxRzFMYUNV?=
 =?utf-8?B?amNtUmJIbWJNQjREbzBmRThtck9Uam03TVlaS2t0cmRkcWV2Z241RCtmOTJj?=
 =?utf-8?B?V3pTcHljdHpLM3VtL0M4MVQzYWhwY2tJQ21PenoyZDFFY01ZTWczS3hDV3N5?=
 =?utf-8?B?TUZBTDNWYVVsV3lMZ2phQXJaTjhGdU1GRXhGS1doYlFzYlpsUnhWMyt6ZGZ5?=
 =?utf-8?B?Ym9xNms3Y3EyUDlkTS9oQkJBa2pTREMyNVZpZG9uZ3JmKzlCOEdNNlJ4anZ6?=
 =?utf-8?B?ZkQ0ci9jVGdDU3BiZmNHVUs3NjFKMGJFTTRUU1pjSmVxUWU5NWUySDQ3SEtD?=
 =?utf-8?B?UG03WHc1MWpVYmJrSEpiSjJpTkFvS2RDSU9CVXRudWx2L1dkWjBITE56VFN0?=
 =?utf-8?B?T0RGSTVJZjRSdlZraXBHTEErdlN5amJ3VVhzTlFxWEwrVXlTZmFzTE5YdFFt?=
 =?utf-8?B?WFNEVE1td2FhUnNkTlhSRDRQMmJudGlJbGJicFR4OVFFQVU2VHVsUGFHazI3?=
 =?utf-8?B?S3VSYy80ZHk3Vm41UnNPN3QydEh6MmxQV2FTUTNGam1EYXRqWWFpM09DcERm?=
 =?utf-8?B?NlJLTEQ1eSs1bUR4QUJBak94Zno2VVZTemtCS0txUWNIcy9uVU16ZCtsMjhn?=
 =?utf-8?B?OERmbTdESjNGc3F6SEluYnZiK3loOHNDQm1TdjZkbmdqVXIrM3IyeFdyRjV5?=
 =?utf-8?B?YWl3aERNbSswQ1V0N2wzRXJ2ZXRobVBaakFZc0tsUTJUVkhoak0zNFVDWE45?=
 =?utf-8?B?WFluaG1MbkxIZ0M5RGN4eUxqcHNkRUYzdVhWRXNRSWJ0TGUvWURyTmMrMVVZ?=
 =?utf-8?B?bHMxenZwRU0vcUsyNngvUzlpQnlsaG52MVFvWHAwVGZLU3AyZGh3V3FRZk1X?=
 =?utf-8?B?UmNhTnR1ZWx6WEZya280OGJIQ0V4bXFLeHVzVXJuSjNnOEVyYlM4Zz09?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: bf001638-fd39-49e0-cf63-08de89019dea
X-MS-Exchange-CrossTenant-AuthSource: DS2PR12MB9567.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 23 Mar 2026 17:28:37.2775 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: inGH8IYtTgi2ZCBVd8uyxshD3GIgENUf6KuN0I4iC2w/lkoMiZjG3Wx8D7ppWiL7J8KTDhG6RtZ8Oyb1rMjY6w==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS7PR12MB9526
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



On 3/19/2026 5:14 AM, Markus Armbruster wrote:
> Subject line: please use the literal property name, for easier grepping.
> I.e. something like
> 
>      hw/arm/smmuv3-accel: Change "ssidsize" property to SsidSizeMode
> 
> Same for several other patches.
> 
Yes that would be easier for grepping - I will change it to use the 
literal property name in a respin today.

> Nathan Chen<nathanc@nvidia.com> writes:
> 
>> From: Nathan Chen<nathanc@nvidia.com>
>>
>> Change accel SMMUv3 SSIDSIZE property from uint8_t to SsidSizeMode.
> Incompatible change; okay because property "ssidsize" is new in this
> release.  Spelling out such things out in the commit message helps
> reviewers.  Not worth a respin by itself.
> 
> Any particular reason this is called @ssidsize and not @ssid-size?

I'm not sure there's a particular reason - this property was newly 
introduced in the accel SMMUv3 series [0]. Should we include a patch to 
change it to @ssid-size to match the format of other properties?

[0] 
https://lore.kernel.org/all/20260126104342.253965-38-skolothumtho@nvidia.com/

Thanks,
Nathan

