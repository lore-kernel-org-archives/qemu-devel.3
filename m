Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id AEB91CD5BC7
	for <qemu-devel@archiver.kernel.org>; Thu,  5 Sep 2024 14:16:32 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1smDHQ-0000qm-RD; Thu, 05 Sep 2024 10:16:12 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <avihaih@nvidia.com>)
 id 1smDHN-0000c8-Fb
 for qemu-devel@nongnu.org; Thu, 05 Sep 2024 10:16:09 -0400
Received: from mail-bn8nam11on20619.outbound.protection.outlook.com
 ([2a01:111:f403:2414::619]
 helo=NAM11-BN8-obe.outbound.protection.outlook.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <avihaih@nvidia.com>)
 id 1smDHI-0008B7-Fo
 for qemu-devel@nongnu.org; Thu, 05 Sep 2024 10:16:09 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=YxEWkiVk1pEsMhHEmZEt0FvINUFT/THLuUVEqVa4OvUZjWny4nk/g96tJT4WxwTKBYj/XFc0S/itL8YaZ4Ay3zs3h2orRoO3tv3I5cS0jibaGZXzrsOcH4vSjZq0A4zk67oZWd83xzZJIko087HsD3x9YnDNJHj7nddp9PdOcx5e5xhtpCOsXGrjtXZT4sbs7B5dNDLrLkJGVRojFMcK47IkmJjFmHSIB+2O5xAhPhuhr1CmUCcx3/z0fLfnkz5CrO4+PiSLgArBLwnML5RvyTblPxya9ST5fm4aW/bMSCAqyOuodPdknPIkCqrk3pJxIo4rs4wlw1gPBiXk9xHR7A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=z39bU0QeKRe8wEkrAbvh2zY4MMvpSylVJtXJagpykYQ=;
 b=SLv9D1mh4a3ezCi8auhLsuzfWFg6lsmmJKBJQjUiiC0ih66kQ6QsWm2a9iX7Zi/4UyHfUI4UMMqj14vrKvrZcYrDVGCqxN6ndOknvqyYTfK/GmlK6PohU4dmH+N2ddbNI1RUmoTH0ip2Kw4X8DWWwo9RdNerr4G/KcNTKZLVVeWhyPNxG8b0kSFhjzmojS48lIRXyDPayETQ3xhRctSGt5z+XO8qCQANkSsewmAiX878AEIfcLqCHNXkwW8MdGRqg8MDyBcwTIL/o/tnIcu8agf1pTyOJ41bn/rsoeThtEbTA6MZ559iivsSKbg/TI/cstEeEHQvocEHesr+gWBMow==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=z39bU0QeKRe8wEkrAbvh2zY4MMvpSylVJtXJagpykYQ=;
 b=Pvvd2wugTcLTTZo3lPiOBKy6sk2BSgPCjaRjNpM22oxoLyHHcjdnEpngn79P53GazJ3wkGXlpbvKSvIzfDdcGibVCx35rGeIQIEcbgcXOV+LC7bTepojsfLlAUz3PnSIEHp3hgWrFVHelEquMJRZ3a6kb94P5AZDj3f+BpClEGUqDqkdhEtBef1S55vtdBJMuyIvtYlr7yrrrpFwsVLGS9/XB4tn4pt951A6jfQjEpwkU66+irhhPdsenbB8XPFq2qDRHEg52U/GQV/hMPrADxELVV9mS3nA5+gs/KnLyGRAvRx/FAYRhPmEQ9Lj5ajpxP1aJcmE8tzyxegUb7Jp7w==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from DM6PR12MB5549.namprd12.prod.outlook.com (2603:10b6:5:209::13)
 by DM4PR12MB6398.namprd12.prod.outlook.com (2603:10b6:8:b5::19) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7918.28; Thu, 5 Sep
 2024 14:15:58 +0000
Received: from DM6PR12MB5549.namprd12.prod.outlook.com
 ([fe80::e2a0:b00b:806b:dc91]) by DM6PR12MB5549.namprd12.prod.outlook.com
 ([fe80::e2a0:b00b:806b:dc91%5]) with mapi id 15.20.7918.024; Thu, 5 Sep 2024
 14:15:58 +0000
Message-ID: <3478eec4-df27-46ec-94ad-924d7dd3e5ab@nvidia.com>
Date: Thu, 5 Sep 2024 17:15:51 +0300
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 07/17] migration: Add qemu_loadvm_load_state_buffer()
 and its handler
To: "Maciej S. Szmigiero" <mail@maciej.szmigiero.name>,
 Peter Xu <peterx@redhat.com>, Fabiano Rosas <farosas@suse.de>
Cc: Alex Williamson <alex.williamson@redhat.com>,
 =?UTF-8?Q?C=C3=A9dric_Le_Goater?= <clg@redhat.com>,
 Eric Blake <eblake@redhat.com>, Markus Armbruster <armbru@redhat.com>,
 =?UTF-8?Q?Daniel_P_=2E_Berrang=C3=A9?= <berrange@redhat.com>,
 Joao Martins <joao.m.martins@oracle.com>, qemu-devel@nongnu.org
References: <cover.1724701542.git.maciej.szmigiero@oracle.com>
 <fe14c841e40e294c05f8dae966e94cc12b3e5473.1724701542.git.maciej.szmigiero@oracle.com>
Content-Language: en-US
From: Avihai Horon <avihaih@nvidia.com>
In-Reply-To: <fe14c841e40e294c05f8dae966e94cc12b3e5473.1724701542.git.maciej.szmigiero@oracle.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: FR0P281CA0192.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:ab::11) To DM6PR12MB5549.namprd12.prod.outlook.com
 (2603:10b6:5:209::13)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM6PR12MB5549:EE_|DM4PR12MB6398:EE_
X-MS-Office365-Filtering-Correlation-Id: b3c10f17-e2af-441a-e7b4-08dccdb5431d
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|1800799024|366016|7416014|376014;
X-Microsoft-Antispam-Message-Info: =?utf-8?B?WnA5VlZWRXB5QzQ1N2xMTjRzMStBbVoyUFhoOUZhS2lnbHhRMGt2bkYxcGJz?=
 =?utf-8?B?RjFEa1FVbGVpcHE0M1hBeGg3ZlNRcGlQQS8yT21XeS9MOG1vS2hKaWVxNC9R?=
 =?utf-8?B?VWZKQ1dUckhtaUNLVVVwRzVXRXdmb1VuMVVBSEJqZFNkcFdhNmkwZEJuRXIx?=
 =?utf-8?B?UGNBVGRvTzJ5d0pFQzc5N05XRE91UXlqeTB3eWd3bGpWcCtmZlp4NWRScUth?=
 =?utf-8?B?UUFaR0h2eERTMVhVbXNxNFZYM21OZzJDbTFuRllRTlB3aXRoYTN3bGRUbTVV?=
 =?utf-8?B?UDZUWXJNZWkyZ3psalhNUE8rVzlqZTVDWFgrR1RONURuZXJ3M0F4SVErYmdl?=
 =?utf-8?B?S2lqdGM1ZmNXMUpFZTUvNXhoTCtzRWVVKzZnVFdUanMvMGJoL2oyR3BDaUxu?=
 =?utf-8?B?cnBSWWFWSkg4VE0rbTZ4NFRrRERpSGdDM2tnRFZMMzJKUmlYREFRT2w5Zy83?=
 =?utf-8?B?aXhzaTR3ajZMQjJ3VmVJMUJUZ2ZoZUl6OWRlZG55cEJScUliTkJUdXJKNW5o?=
 =?utf-8?B?N2FYd1hLY1BxM0w0QmFwM3llWXlsNjF4NjFEeXYwR3c2Wnl4MVhpOFJ5azZ6?=
 =?utf-8?B?QnB3TlZvWG5WcHNSR3RtOTI0dE1ac3o1ZmxkZTJzTlBpOUptUkV3TThiYXVq?=
 =?utf-8?B?cFVFTkE2TWx0amQwL1NCWW5sTVNnbVlUMlpTUDMvSVN0ZVhBRC9Yc0gwQ3lS?=
 =?utf-8?B?M25kT1l2WXgxRFVBYnVjSkQ4TDl0Wmx1QUVrc3lQN2NIajNrR3ZxSC9oaits?=
 =?utf-8?B?RUFHaG9CVlByb0ZkNTNKZk96dDF3ZFFxRXN6L2FpZzhHS0kvRTYrNXlGWEJ5?=
 =?utf-8?B?V2MyeVZGYXo3RHRHck95NW9FUExjam5oZVRtVldQVDlTcU9oWEYzdHZWa3BG?=
 =?utf-8?B?ek5UMWJCS0hJMVQzMVJBZXRmRldLYjRnRUR0NjR5YmkvRFNaeVQzaGVGcm13?=
 =?utf-8?B?SnJvMUdYZFlRL2k4MGVHUGVOWGhIblFxWGo3cWZWS2JpSDk1TkxqNVk0ZVgx?=
 =?utf-8?B?WU5wUmt4TE9JdStzWE5xaXJZQVNGczd1cjFjYnBWeDB2WXU4Q0dDRlV4eWV6?=
 =?utf-8?B?U0xaSENkV2o5SzBQbWxwZFZSVm5uR2s5SGZGdDR3SHNwSDFrcHRiZ00zdEo4?=
 =?utf-8?B?YkRrRC9jeXNHWDUvRHhkVGF4R3MxK01MSDJEWFhBaElVOWZsOTFWL0ZiRXZh?=
 =?utf-8?B?ZFh3MHhRK2VUV1psdElYZld1WWVJbE0vb09iZVNIbURqZFVxTVk4cHhVU3pZ?=
 =?utf-8?B?Wk56eEJpU1l0SW1BakF4VmZYTEJtQ0dkbjRhUVRlcXhyeExmVDVmN2hsRUVh?=
 =?utf-8?B?dGl0ZHBFY1lWWHB5NHFBRFdZeUhveDhpMjEyVi91aDgzd1lqWDdpaUQrbUhC?=
 =?utf-8?B?T21TN3E3UFZzTDh5Z2pxNG4xN082T2grRUVzVzA3RUs0aEVCUlZwWkJUZHg3?=
 =?utf-8?B?K1N3TWJZNDRJN1NuZ0hGV3lYYnpVRmhQR2NDZ0RPQWpGajBGWFpQOXJ5VitX?=
 =?utf-8?B?MEx2eUlwdXRFOUxTVlEzMVNGMkkwODA2STF2bDRBVTlEbDhWejFVanBoRXl0?=
 =?utf-8?B?NW5Dd0JsREFyQjZZdlMyRlZ6bEdDUEFqYnNCZE51eVlJbGRUdktBUC9lN0Mz?=
 =?utf-8?B?cDErSTVLRFA2WDVVTU9Gc2FoSndVcjMreFFlSWVRbHlEU0V5ZWlzejA2cm1z?=
 =?utf-8?B?d3YwMG9NckI2a0JJSGZ6VTd6TEp2enptUTFqdVdOOHZDQXpKS1B0WUlHMXVn?=
 =?utf-8?B?VzhrQXhIT0czY21hT1pubmQ1YjdNZ2pUUm9FMkJoZWxleGYyaEhuL0QxL1Yx?=
 =?utf-8?B?bHkyQ3V6TWU1NlY1cjZzdz09?=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DM6PR12MB5549.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(1800799024)(366016)(7416014)(376014); DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?aElETDh6UjRmVkFNRjc4VU1YQ1I2b2hGTkY2WnYwbll0MXNmZEdYQlowMlNW?=
 =?utf-8?B?RXBrVDY4TXBOaCtUNTdYMFNxaExpQU1UK2hBWkp3ZzBlNmtOeWNGSVdjRXAw?=
 =?utf-8?B?T3dvTG9SbEtnc2NGQWlsVk9YWHZFY1FWdEFaRkM4bVoxdmgrcEh2dnd0Y2Q0?=
 =?utf-8?B?djJUcTFFdFdrTlQ1dXBYcTFSdEhQN0Q0czgyNU5aZHFJWVEyWXFEVGVja3pI?=
 =?utf-8?B?SzBOT3h6dmZxWU5ETzErVCtkNDJEWG5XcUJXU09LOHdpQXpkTEV0QVFQMnVF?=
 =?utf-8?B?WlJIc0M3eTlyZTFYcHdsQzd2NnZOeTNrRHJ6WlVGZjFDc3pMMEtYa3BsRURp?=
 =?utf-8?B?b0U0UXFqMXlEZVlxZmlkcWxNWklEWjZML1h3RlRwbTA4T3l1U2dNUmNvbFFp?=
 =?utf-8?B?VWdxdFFpZ3dkdkE1WXlwdE55eXF2WXREU05SQjVDemRScE1wV1lZM1pFSXRV?=
 =?utf-8?B?OTFwNjE2UFBPemxMUVRKdVh3TTBUVVJNeEhtTzRMV3dTQnV0OFk2NEdYcDJl?=
 =?utf-8?B?a3E1NjRHdDgyUWdlVUFWRFFUSlBSeFltWk12Rkl6NFhrWStvaHpSdnZUa2Vx?=
 =?utf-8?B?QXdwUFF5UC9Ud2RkOGl5SStBV1d2bWxucExLL1EwakRkbk1KcnBGKzh1enU2?=
 =?utf-8?B?MDVTZklIRzV6bTZiTFJ0bS9DVjBvUFU4aFI1SHJ1ZmlZeW1rOHlieGsvdWUx?=
 =?utf-8?B?VGxodzlQMVorWGYxaVNNaEZjVTJyWWNRY3VRRjVFcFRRTzE3WG5kZW92Rk1I?=
 =?utf-8?B?RmwrRUg2ZEhHOUV6ZVNLaXpmbGlyN1RxWDI0QVdjaXVuV21rTXZHMTgxVW5w?=
 =?utf-8?B?OVkycEpkSGlTU1NBSlk1SkhRNjRtQkYrKzhabWJsZ1ExaXBvWlZ3bzlveFhs?=
 =?utf-8?B?WXFxRUI0dmdtMG1PL3VRS0JmdkVjZ2pTaWt1SG1WVldwY0t1M1Q3MGFRaW5V?=
 =?utf-8?B?bGoxOUtwZ2pVMlBlczZNZFBYZFAxSzlHR1hOQ0pDOWx0ekpnTHFFc1QvbVQ3?=
 =?utf-8?B?OXJTalFZSlRWUXdvUUliamJUZjQvWjErTjQ1WGZuOXJ3K21HdUpaRCtlcVBQ?=
 =?utf-8?B?MVcya1lGUFI5djNoRFNBTHNUazlyMVRyOW8wN0pLeG4yZ1dBUzJvMEdyUy9w?=
 =?utf-8?B?bnY1czUvSkl3N3lsUmxtSGJac0tGbEQvTnZqby9UeExZUWJkTzg0Z3c2dmQ1?=
 =?utf-8?B?NzQ1b0ExMVZ3OUVFSzJEbTUySytPbWhmWVB2YVAxNStkZnZVSlRiUDZudEdk?=
 =?utf-8?B?RFVYS0Fkb0ZEa0NEamlqc1o4UFhFcHdrNTdhVGJteGpkRFUrUmJKR0lXUzVL?=
 =?utf-8?B?Smk3dmpXbVZFbXZjWm82aWxkUmhaZVRRV0J3VVZBaVRKaWdDbnNwdU5yemFG?=
 =?utf-8?B?S1V0RWE2RUJGNVRGcEhyUU4raVRSR0g1STgxQnZDMDR5YnNDcGFmMmpzeGQ5?=
 =?utf-8?B?aUNWNk1URjZ3T2loNmRCN3NQMk5WM2lIVWtHYVlxYW1jd3ZHb1VCNEE5ZWtI?=
 =?utf-8?B?dmdNTVNoMnNTbVNTaEFtMnF2czRkU0JzbXlBN29KakQ5VHd6L1NJY3U5NlB1?=
 =?utf-8?B?Z0toL2hkckY2SmVVWXZZUVN0d2FjQUp2amJCSXJkRnBZQWVXMHIwU3B0OTJo?=
 =?utf-8?B?NjFCdTFoVFUwT1ExWnVTbGEremdsNHU1TENDYlFPYXN6dHcremlidVJEY3gr?=
 =?utf-8?B?WkpMMGhBQlUzS0R4TkxZMmZKdVIxZWhCUGs5ZFNQYlVyNVEwUStDaE81ZnAv?=
 =?utf-8?B?K0RBUjQrSE90RVpWVFZ2OHFNZ08xdXZWaDBuc0lpSlU1WWt1ZW4xdUNKYzJS?=
 =?utf-8?B?TzRXb3pWbFFLWUg3S0ZNeXllbjROK2ladW1GUVc3cCt3RUI0aWV1T0VRZk9H?=
 =?utf-8?B?YmJNb0FUR3g2eFd2SDRoRWxFczllWXZpQXdMNjhqK0Zrdnpka0dFVklscGtP?=
 =?utf-8?B?amU5dkhzaFdyYklHM0pWZDd4T1Bua2tMY3g4a2dnODNLQnVtdndSRlk5Rmpq?=
 =?utf-8?B?bTBMc2xNMkVzYzkzbGVBV2ozcThhUWtPUEdyb29JNnZEZk13dkdvZ2ZOUkpG?=
 =?utf-8?B?UGZQa3NPY2ovMUdyOVN0SERsV0ZqM3NiVmIrdHg5QTJIeVZqVy8rMmxSRGJu?=
 =?utf-8?Q?u1jhoNMD6sIdKhExGebtI66uZ?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: b3c10f17-e2af-441a-e7b4-08dccdb5431d
X-MS-Exchange-CrossTenant-AuthSource: DM6PR12MB5549.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 05 Sep 2024 14:15:58.1928 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: Tz5miLiu7lW9YYh982aDvCfb8gUY0vovalqGNWnLrceLZsDtiZP48bS2rm7COEQDjbZw6ffiz3UXI0ysZi12Jg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM4PR12MB6398
Received-SPF: softfail client-ip=2a01:111:f403:2414::619;
 envelope-from=avihaih@nvidia.com;
 helo=NAM11-BN8-obe.outbound.protection.outlook.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, SPF_HELO_PASS=-0.001,
 SPF_PASS=-0.001, T_SCC_BODY_TEXT_LINE=-0.01 autolearn=ham autolearn_force=no
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


On 27/08/2024 20:54, Maciej S. Szmigiero wrote:
> External email: Use caution opening links or attachments
>
>
> From: "Maciej S. Szmigiero" <maciej.szmigiero@oracle.com>
>
> qemu_loadvm_load_state_buffer() and its load_state_buffer
> SaveVMHandler allow providing device state buffer to explicitly
> specified device via its idstr and instance id.
>
> Signed-off-by: Maciej S. Szmigiero <maciej.szmigiero@oracle.com>
> ---
>   include/migration/register.h | 15 +++++++++++++++
>   migration/savevm.c           | 25 +++++++++++++++++++++++++
>   migration/savevm.h           |  3 +++
>   3 files changed, 43 insertions(+)
>
> diff --git a/include/migration/register.h b/include/migration/register.h
> index 9de123252edf..4a578f140713 100644
> --- a/include/migration/register.h
> +++ b/include/migration/register.h
> @@ -263,6 +263,21 @@ typedef struct SaveVMHandlers {
>        */
>       int (*load_state)(QEMUFile *f, void *opaque, int version_id);
>
> +    /**
> +     * @load_state_buffer
> +     *
> +     * Load device state buffer provided to qemu_loadvm_load_state_buffer().
> +     *
> +     * @opaque: data pointer passed to register_savevm_live()
> +     * @data: the data buffer to load
> +     * @data_size: the data length in buffer
> +     * @errp: pointer to Error*, to store an error if it happens.
> +     *
> +     * Returns zero to indicate success and negative for error
> +     */
> +    int (*load_state_buffer)(void *opaque, char *data, size_t data_size,
> +                             Error **errp);

Nit: Maybe rename data to buf and data_size to len to be consistent with 
qemu_loadvm_load_state_buffer()?

> +
>       /**
>        * @load_setup
>        *
> diff --git a/migration/savevm.c b/migration/savevm.c
> index d43acbbf20cf..3fde5ca8c26b 100644
> --- a/migration/savevm.c
> +++ b/migration/savevm.c
> @@ -3101,6 +3101,31 @@ int qemu_loadvm_approve_switchover(void)
>       return migrate_send_rp_switchover_ack(mis);
>   }
>
> +int qemu_loadvm_load_state_buffer(const char *idstr, uint32_t instance_id,
> +                                  char *buf, size_t len, Error **errp)
> +{
> +    SaveStateEntry *se;
> +
> +    se = find_se(idstr, instance_id);
> +    if (!se) {
> +        error_setg(errp, "Unknown idstr %s or instance id %u for load state buffer",
> +                   idstr, instance_id);
> +        return -1;
> +    }
> +
> +    if (!se->ops || !se->ops->load_state_buffer) {
> +        error_setg(errp, "idstr %s / instance %u has no load state buffer operation",
> +                   idstr, instance_id);
> +        return -1;
> +    }
> +
> +    if (se->ops->load_state_buffer(se->opaque, buf, len, errp) != 0) {
> +        return -1;
> +    }
> +
> +    return 0;

Nit: this can be simplified to:
return se->ops->load_state_buffer(se->opaque, buf, len, errp);

Thanks.

> +}
> +
>   bool save_snapshot(const char *name, bool overwrite, const char *vmstate,
>                     bool has_devices, strList *devices, Error **errp)
>   {
> diff --git a/migration/savevm.h b/migration/savevm.h
> index 9ec96a995c93..d388f1bfca98 100644
> --- a/migration/savevm.h
> +++ b/migration/savevm.h
> @@ -70,4 +70,7 @@ int qemu_loadvm_approve_switchover(void);
>   int qemu_savevm_state_complete_precopy_non_iterable(QEMUFile *f,
>           bool in_postcopy, bool inactivate_disks);
>
> +int qemu_loadvm_load_state_buffer(const char *idstr, uint32_t instance_id,
> +                                  char *buf, size_t len, Error **errp);
> +
>   #endif

