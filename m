Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4FC92FED9EA
	for <qemu-devel@archiver.kernel.org>; Tue, 17 Mar 2026 16:13:14 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1w2X2S-0001S4-SC; Tue, 17 Mar 2026 12:13:00 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <nathanc@nvidia.com>)
 id 1w2X2R-0001Rc-QP; Tue, 17 Mar 2026 12:12:59 -0400
Received: from mail-westusazlp170100001.outbound.protection.outlook.com
 ([2a01:111:f403:c000::1] helo=BYAPR05CU005.outbound.protection.outlook.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <nathanc@nvidia.com>)
 id 1w2X2Q-00038I-EY; Tue, 17 Mar 2026 12:12:59 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=CIrfpNwihz/EktdTJn6Dx15Tg9P+xRveSstrmTXa7oy1i2G6O4nN6IRlrZ1OyKViw8xgJnR34+AOvdlxGRQbwitTVLU2xESBXIu5ZJFrR4hTrnJ0k8eChvsdL1aN3BNQFtwQHYDNoCF4vBn4+ThjZUWE39/YeP8uNoDg9y6K9fVyEgCIU8yq5j+jy+ltLxmGUYfDLhau97Usnn+ZFqlzgnv4DW8oJQNm5Ktxu6CmTGn8/NhO5sadtPCGNm4CJyZeG9dVxWnq1BlLTOCeCI2uw4ErnBwHIwdQ2aNimJOrbvxQJbvQFP8PwSC0S9rH+w4eAbFcv/afk0FjSQFYEtIExg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=w7e3vmtN6mWyzXYdTXIahXC2hVdVUhmZw/WxE9bdeso=;
 b=ZosmZnBMk/JWntL5twv0rLNE2vUKsAp2FQu1usO0lJKUzPyC+zPUElQyNBxgr+UZ4AXy3cFZfItjurSpQidXV9lQUf5laKTpTxS2Uy+f84N48nNx6Wn6K3HSiHJcnmYJs0BWAecBc8mnUZm6714/JwhA+FYW4NPVAYC54PdTT8oq5pMDgIHmYyOPHVciiBkmFyKJrXeL+3svysMY5pSARYgw1TNImVqS/CP7Q8MZ6pe4I/06gVs9qfoTTkkxU4BXJJLdv8Y3na3uD8aiUsKnEAfYJfdHB9CewxIEl2t8fVRCpwnh59145M31UvO95lTD75YD6shXC3AGrVSmJZoumg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=w7e3vmtN6mWyzXYdTXIahXC2hVdVUhmZw/WxE9bdeso=;
 b=FlFQriyJp3V6dzNIa73B2T7lgRoMImgyVeSdVarrfkt8BLXpkA2dNaUv2Y39LgbIFhEwhg+TR5mY0KFHU+beKOq5mtl7cr9+4lXXy5dNKVitx7FXQAw/tJ/uE3kcuhfFM4AAT8F0DNUxQk/PSZmDgWbUN4HAlng/5fNvZaDi+3Ry4r/+pTuqzpyHX3hadQzfIxJ0Mjqdk63BLMoYhxxMjrawXoPDIrnZ512YjtAXGV8/fdZThkaENGsHugTXy7v0oIJKmJ/6qy0j5coNFsOyEJE0MN7oK4qX+NYwlqP1yLT0/XjEdGwNtGU7ZrrL/SxgN0Jl+amok7bQ8GbfqvroZA==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from DS2PR12MB9567.namprd12.prod.outlook.com (2603:10b6:8:27c::8) by
 SAWPR12MB999141.namprd12.prod.outlook.com (2603:10b6:806:4e1::14)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9723.19; Tue, 17 Mar
 2026 16:12:51 +0000
Received: from DS2PR12MB9567.namprd12.prod.outlook.com
 ([fe80::636:1b52:24ca:d7e5]) by DS2PR12MB9567.namprd12.prod.outlook.com
 ([fe80::636:1b52:24ca:d7e5%3]) with mapi id 15.20.9723.018; Tue, 17 Mar 2026
 16:12:51 +0000
Message-ID: <eb2b2582-0c8f-4e51-bef5-7e6721a2767b@nvidia.com>
Date: Tue, 17 Mar 2026 09:12:54 -0700
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 2/8] hw/arm/smmuv3-accel: Change ATS property to
 OnOffAuto
To: eric.auger@redhat.com, qemu-devel@nongnu.org, qemu-arm@nongnu.org
Cc: Peter Maydell <peter.maydell@linaro.org>,
 "Michael S . Tsirkin" <mst@redhat.com>, Igor Mammedov <imammedo@redhat.com>,
 Ani Sinha <anisinha@redhat.com>, Shannon Zhao <shannon.zhaosl@gmail.com>,
 Paolo Bonzini <pbonzini@redhat.com>,
 =?UTF-8?Q?Daniel_P_=2E_Berrang=C3=A9?= <berrange@redhat.com>,
 Eduardo Habkost <eduardo@habkost.net>, Eric Blake <eblake@redhat.com>,
 Markus Armbruster <armbru@redhat.com>,
 Shameer Kolothum <skolothumtho@nvidia.com>,
 Nicolin Chen <nicolinc@nvidia.com>, Matt Ochs <mochs@nvidia.com>
References: <20260312210328.2016191-1-nathanc@nvidia.com>
 <20260312210328.2016191-3-nathanc@nvidia.com>
 <8b7b4803-81fe-4c30-a36f-7141df641964@redhat.com>
Content-Language: en-US
From: Nathan Chen <nathanc@nvidia.com>
In-Reply-To: <8b7b4803-81fe-4c30-a36f-7141df641964@redhat.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: SJ0PR05CA0101.namprd05.prod.outlook.com
 (2603:10b6:a03:334::16) To DS2PR12MB9567.namprd12.prod.outlook.com
 (2603:10b6:8:27c::8)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS2PR12MB9567:EE_|SAWPR12MB999141:EE_
X-MS-Office365-Filtering-Correlation-Id: 4694adba-7ca0-4b3e-b4e3-08de844009cf
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|376014|7416014|1800799024|366016|56012099003|22082099003|18002099003;
X-Microsoft-Antispam-Message-Info: nb/GGLtP/sAtntuhvgQlrckBXiJg+3ZCIw7Xr1h8uIZq2wMl9dPAP95P+hL+OKaM16nR8PaWZe4UvZGSoQvDQrmdMs3OwPw/Mg2PhpJZc5WxwFaFP2TrrhhRmO5iEOO1irKwr/SPqQdRRT+fSSCWcaJYkIsdFIFkfPLXeugWBW+AN2GxF0wAEZhYNqmXpRXCgjxqChiJpxxerXnfD69hmsHy7uRX2v91GT7d2TJn2mQ7DlLAvtDJ8rpjrgp76jE0G3JvDqyC5WMSgYyKG8YLcVIiwNVEWpSmHs5CBCr1esFgzXezfzM/Gw112XX8y2HHvzpvih8BgiwdTPOMH3AOx+agGS7Bi7tHw7hcal4W1NgmktFwBJTZiQBmi6HRkmfZvx+i/3N6+o0byVzwhlvOjtNv/K9DdutOr3juqRVhOm2UKGu6v+1VNrRTkYwUYSMFtUR6qrt9KgYjlOzsdTW9Tm9cdbl25TisUVyfCu6hquWm/Ni+YVXS4UQDilxVEi0ip7ezukHisZkd/ARZJ1O9IOYWEuNAweLhpKFM7oD+gl5FMYSS3Eap5c6QG4Wiy4LXPPHyX9mrzkAGzXfs1ai3n76BG0XefairjAL/JMAw0kcJyhZXKhO6rjWQMcHA+dCyXDKvOgRCisr9GcHU+b6veH9O+AQxWxyhmTnvrd/D0PGDWFo60HKk/eIoX+qYjB2PhACWB8ginvnXYBBPAzsfCVlFvtwCXNplkdYgqSR64cc=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DS2PR12MB9567.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(376014)(7416014)(1800799024)(366016)(56012099003)(22082099003)(18002099003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?NE9VK3RnZGlaNXJtUjlpV2o0MTJueStZZ3RQTmFRZTVwdEpFRzVXSXY0R2NG?=
 =?utf-8?B?ZW5PRHZLbmdoRXREMi8rcUY0T3k5N2tIclk2OUxtY0NJWlhlQk5yd2k4U3VN?=
 =?utf-8?B?NlpaZFVTNloySmFJeGZCdWtSbi94WGJCYWxNRDJvanBzNzFSM0xsOWRRWVZR?=
 =?utf-8?B?eUZtZ1MwZVlIeVRwK2VPc2RQdElqRGoya3NMNlJod2FqVXlLMm1yTkszWWxC?=
 =?utf-8?B?Vk9KdFc4Q2txZlVkTlcwMWFla29aRVJTNHNlaXBBd2REdDRzOHV5NkxVMHgy?=
 =?utf-8?B?S1dtZFNlQkNuK2toaGtOaGRiQUlDZXlENkw3YjZpSWx4M2U5cjcwbTFsZzQx?=
 =?utf-8?B?OTR2V0IrdmNiQ3JENlNDZ0VxeFN5VnZESWxjaGhlVzFabGRaVzliaWFRVUFn?=
 =?utf-8?B?YVNIU0tsQmp3L1pYdHhJR3BFYml5dTJpeTNHU2tZMyt2a3BOVzJXVnhvU2Z5?=
 =?utf-8?B?ZWFwSEErSzVNWnlia3g5dHNtZ0x2MEZ5WHN0eis0U1ZENEpqSnJmR1dBVEZy?=
 =?utf-8?B?U0VuYXRPbHZEVURWQmZ6ZmxQLzdobVluUFJreGJLbGlOYmZqOEczNmt6ZHFN?=
 =?utf-8?B?a0JzNTN5TXRvQ2VVZHdpM2k2cks2Nkd3RnE4Qm5KMmt6YXQ1c3JQNlg3UGRB?=
 =?utf-8?B?a3lBU3N6N2cwOVdFRFVBb1NlUEs0VmhnazZlUWV1dUxIbXR5cGU0TG5wcEVh?=
 =?utf-8?B?TUxUR1FIYkQrRDNySzNDUGJmYWcvRnlCV3U2ZDRzT2NyMXN4TmdoYUZlUXFm?=
 =?utf-8?B?c045TW04OUVJUitFa2g5eUNCdEJGa0FYNng4bmxQT2JSQUc1SEZGVkNmWE1J?=
 =?utf-8?B?anZYYzI4Z0hPSUdiL2psZEZqMEphc2FRSy9hR1VoNmRpRWN3WU5OTHpYeEtS?=
 =?utf-8?B?UUxzekkrNi9KUFhpaHU2bE5jZlRXOXkxdFZRM3FFOGwwaHJTamlneEFNYjhl?=
 =?utf-8?B?NW1ncDVtVTlTRENjczk2OThIdnE1Tk0rNmxnU3pSd1AySWc3YVFtdERPWHBB?=
 =?utf-8?B?dUpnRVBCRTc5a3F1UFh6SXcyd1E0VjR5Z1VwQi9wMDk5d1BqZElGc2UzckM1?=
 =?utf-8?B?MWJsZlpJZEk0QTQ5d2JzUm4veTNJc2ZEbE1DTTRxVDJyN1pEbTFpNVgzcng3?=
 =?utf-8?B?L0g1eHF2ei8xYUx4QzB5OHhmVmtMSlA3M2ZDeFYrUi84N2QyRG9PSU93aGhn?=
 =?utf-8?B?OUVBMzFBT0RCZ1ZYb3dueDU1ZlFHOE5nVXRWMVQydjZTYSt1MEJMM2IvYUd2?=
 =?utf-8?B?dFBaenllNHZWc1E5VDVkWWNRdzFOaENNcTFOUEtuYlVoYWtzOWQ0L0lnZ2Qz?=
 =?utf-8?B?UjdPck1JNDYrR0pFMmIySHlOLzE1a25kUHk2MUtrdk9ZZCtsaFBROXFUb1JZ?=
 =?utf-8?B?cVdDN0Q0WjZzZWUxK3FGZGN4eDVXNE5CK3dhcUM0eVl3b2k5ZzlTMmN2YUI5?=
 =?utf-8?B?bzBUcHBja3NMTlltRWNtMnFMUzRZbUsvaTdLdm8zNnNvRkVKNmIyeGIvN3g1?=
 =?utf-8?B?Qm95U2tPbTZoeUExOFZNV0NzUDZOdzhnR3FVR0NzeWRoTUlBa2YzdGo0RHhW?=
 =?utf-8?B?c2NLdHk3d2FpUXVMUG9uZGpraEVHS3EzY2lhZXV4SGlTcW41bkR1Z2FYUTh2?=
 =?utf-8?B?SmNvMUdKUWtFUVN4cU02YTZibmgwazNTdlBSZ2NzVGh5N280YUlvSUs5MnNY?=
 =?utf-8?B?ZmVuSVZtS3k1QWx3VkQ1MjA4Rk1tQTM2dlVTUTFDRHZWRElldjVMV0ZzSmhH?=
 =?utf-8?B?dzhIeDhRNldsOU5JUVBTWlE4S3BNZEo0ck9XL0JRaEVSbU5lMllFaEk2MTU4?=
 =?utf-8?B?djNtSUJ3b29FRjRmbFcwbytpZFFLdVlwVGRFZ2RETWMvRlVaWHB2ZEVvYklj?=
 =?utf-8?B?NzhYVTQ0VUhHZXExTDZKazRyNE1STVBOaU94bkJWMy9ndkxiclhQZ1A2ZzJH?=
 =?utf-8?B?LzZvZzQ4RmZqVndZeWZaVytPQjArRFdXOUZMa2xnT0lpTnFucVlIcWNxcXNW?=
 =?utf-8?B?d2tBS29zeDQvOEd2Q0hVaFhBZjZXd2FldjZFcXE3Q1VTLzZ4b2IwTE1BZmdG?=
 =?utf-8?B?RllGM2NodGJTV3VDR0NBd0hWRGxmM2xGNEVEeStHQW5OV3B4NmRtV2xvQTR5?=
 =?utf-8?B?NjU2Y01rVmF4eU4wcjVQS0VETkZhK1BvZkxObkxvT1NuZkJoa2RVSjhaWlRW?=
 =?utf-8?B?bXZ3b29YampQbWRqR2NPNTFWNThqZEJuOXRCSEtHVzN3RWIvTW5KSldSM2xP?=
 =?utf-8?B?ZUhXYTdtbGJIUkNWSHBlUDlxb2x5ODd0WWFXTjRIRDZ2TGlVL0k5cm1vZEJH?=
 =?utf-8?B?NGxlT0syMHl3RnpMclZIUGJ6TkZaUmFJZUdsd3N5SlpPNy9zNnBIZz09?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 4694adba-7ca0-4b3e-b4e3-08de844009cf
X-MS-Exchange-CrossTenant-AuthSource: DS2PR12MB9567.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 17 Mar 2026 16:12:51.2594 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: /Jm+VL7B9Z10yiGNSCC4aC5AdxvNlS7TmWS5tLuueXLkgQzIDW0DbqviAucX6k2ZczZgvmO1X0S4np37EfaXtQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SAWPR12MB999141
Received-SPF: permerror client-ip=2a01:111:f403:c000::1;
 envelope-from=nathanc@nvidia.com;
 helo=BYAPR05CU005.outbound.protection.outlook.com
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

Hi Eric,

On 3/16/2026 12:38 AM, Eric Auger wrote:
> Hi Nathan,
> 
> On 3/12/26 10:03 PM, Nathan Chen wrote:
>> From: Nathan Chen<nathanc@nvidia.com>
>>
>> Change accel SMMUv3 ATS property from bool to OnOffAuto. Setting 'auto'
>> will result in the default value being used, i.e. 0 in IDR0 which
>> translates to 'off'. A future patch will implement resolution of 'auto'
>> value to match the host SMMUv3 ATS support.
>   i.e. 0 in IDR0 which translates to 'off': this is unclear to me what you want to say.
> 
> I would clearly state here that at the moment the auto value is not implemented. This is just to get the property right and do not break JSON/QMP when getting the auto mode introduced. Also I think you want to enforce that in the code, ie. the end user is not trying to set to AUTO.

That makes sense, in the next refresh I will enforce not setting auto 
for these properties and reflect that in the commit messages.

Thanks,
Nathan

