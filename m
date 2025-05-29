Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8368FC54FB3
	for <qemu-devel@archiver.kernel.org>; Thu, 29 May 2025 05:24:35 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uKVk1-0004qY-CI; Thu, 29 May 2025 01:23:45 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <Vasant.Hegde@amd.com>)
 id 1uKVjy-0004qF-Lv
 for qemu-devel@nongnu.org; Thu, 29 May 2025 01:23:42 -0400
Received: from mail-dm6nam11on20605.outbound.protection.outlook.com
 ([2a01:111:f403:2415::605]
 helo=NAM11-DM6-obe.outbound.protection.outlook.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <Vasant.Hegde@amd.com>)
 id 1uKVjo-0000kr-Rh
 for qemu-devel@nongnu.org; Thu, 29 May 2025 01:23:42 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=E1B00GIMgOOFFqoTSFVXXnxuP4sRYm+mO/LVKSPlv0NAPh3ku0RwgBpg4q2Mbg6/eoucZze6R7dC9iOloqfKzLLqBfTbJu/9x9NvHou0n/yDzR7A3aXS6oXRuUrhtpuBldBTcrHekfEfzKncnc3pe86NSshOaaBz0Ukq3mMIR3WTXlM4lLB6olCQfWvbl+G+yVrHtyKdZPHRT5pviatht8ebr4iMbaNOAM9frtBMUeixJCma35fTh1mFYDs11GxXcOz4XUyu2VztRwFbCcbdv4rOukL766vE9rWVr5INICDRm8SUfHOl3kooEmpj/mtN+BmFxMqRoXfYM5kKn+MKnw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=UfP0yDeL1BtT55/UDS7fHl7TdtObwNs47XOtqOmOJaI=;
 b=I8FjuHFLGYqNZNEa3nuSE2sT8c46ge/+n9v89TbN/e2v3InBuq3iQJS4d5nRlRPiJTr5RaIho5C9geGOR0+o1UhDFggRynju0ZeyfRfEPljZTRsjTxcAHKQX/kpsKDDQ+6GghSVhKc/K67J+H+eLNk8blpWWQMDLRpUAWj5fuYG8PZlqYjUYRAyNKYZYMYdQPTj9lWELHHKIun8KRsDP4PvmvXtjGO2fpbbzp+HuacNQ4D1QjbSmTXxlZH45yL77kcuXvkudM1Qycsh9CBEOLCpNnGo5tVQM+yXQEqjdsu7MGgA5Ty2U2Bgi1vBxhTtykMu7tc4F2KYBn9u8cEly6g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=UfP0yDeL1BtT55/UDS7fHl7TdtObwNs47XOtqOmOJaI=;
 b=ZdA5O4u4isjuNtLanPYv4kGZlw7wbQf/WPmxdBHV07pLCbViRIW2uPDGEF+xY/k1mrqcRo4CFvCubmXkU0MubCtMslWMS2gGpsBfmJapkNOjCvP7j7UnjylUxCDrmNYYof5+Vyk9do3zWSyIg4mQ50vky9fjqcz8vV4YHdymeC0=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from DS7PR12MB6048.namprd12.prod.outlook.com (2603:10b6:8:9f::5) by
 DS5PPF5FAA0E762.namprd12.prod.outlook.com (2603:10b6:f:fc00::651)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8678.33; Thu, 29 May
 2025 05:23:20 +0000
Received: from DS7PR12MB6048.namprd12.prod.outlook.com
 ([fe80::6318:26e5:357a:74a5]) by DS7PR12MB6048.namprd12.prod.outlook.com
 ([fe80::6318:26e5:357a:74a5%5]) with mapi id 15.20.8769.025; Thu, 29 May 2025
 05:23:20 +0000
Message-ID: <13142886-d48e-4b4a-8bb3-ff11c291e977@amd.com>
Date: Thu, 29 May 2025 10:53:11 +0530
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 4/7] amd_iommu: Fix masks for various IOMMU MMIO
 Registers
To: Alejandro Jimenez <alejandro.j.jimenez@oracle.com>, qemu-devel@nongnu.org
Cc: mst@redhat.com, pbonzini@redhat.com, mjt@tls.msk.ru,
 marcel.apfelbaum@gmail.com, richard.henderson@linaro.org,
 eduardo@habkost.net, suravee.suthikulpanit@amd.com, santosh.shukla@amd.com,
 sarunkod@amd.com, joao.m.martins@oracle.com, boris.ostrovsky@oracle.com
References: <20250528221725.3554040-1-alejandro.j.jimenez@oracle.com>
 <20250528221725.3554040-5-alejandro.j.jimenez@oracle.com>
Content-Language: en-US
From: Vasant Hegde <vasant.hegde@amd.com>
In-Reply-To: <20250528221725.3554040-5-alejandro.j.jimenez@oracle.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: PN2PR01CA0049.INDPRD01.PROD.OUTLOOK.COM
 (2603:1096:c01:22::24) To DS7PR12MB6048.namprd12.prod.outlook.com
 (2603:10b6:8:9f::5)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS7PR12MB6048:EE_|DS5PPF5FAA0E762:EE_
X-MS-Office365-Filtering-Correlation-Id: f231bc3b-d6f6-4581-4ddf-08dd9e70ec75
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|366016|7416014|1800799024|376014|7053199007; 
X-Microsoft-Antispam-Message-Info: =?utf-8?B?bVpsN2QvT3NWS2hMSXB2L2dybXJFalhuWG95RWlxbjdmQ1Qra2lhUlVaNzUx?=
 =?utf-8?B?UXZrM1E4bk9aOXc1Y3lIVlRWTlFoS0duK0R4SFB4MzFaelQwbFdGWlpsSTZ3?=
 =?utf-8?B?MkZTdDI0NFU1cFlyQWNkVzhGeVA5eHdWRVBQWnhhQUdiS2UvOTRoT3J0bU14?=
 =?utf-8?B?YmJaS1hmVzFnU01QK2JnRk5CRlkvSC9XcytjWldta1V5dHY4b3U3ekRTNlda?=
 =?utf-8?B?Sm45RUhXeDNkTDB1WVAwbWJEOWdOb0RxazZ0RVVieVd5OWtUMTgvZ3FUOTdQ?=
 =?utf-8?B?d05oa0Y1RWVpTVNrNW9yWDlVZUZ1emppNFl2T244YUNsd1hsaGJVbWJ3S29P?=
 =?utf-8?B?ZXZxSlA2RnVLaHNhc3NoMzQ5OUFtNFB3OWhOVEo4eTBWcTYwZkhRcFI3YzZv?=
 =?utf-8?B?dEdjdlRUNVkwN0JLOXZieVNSSVkxRFVuK1VJRDVxSnFoRlNyNzdKTjVGaTl5?=
 =?utf-8?B?UUpwdFZmMnFRWGpVWXVYNk9OUThZak9uWmF4WERDWnJLenZwcXNWY0pleEVY?=
 =?utf-8?B?R0NLM3NtbzRvQWE1bWYydTduTGh0OFhwQUdHVDR3VTk5R0pvZGM2UUJtOUtZ?=
 =?utf-8?B?RXJWa2I1ellWNHljYmcxRDJuNTVJQW1tSk1NMWtzNHdoQU5IeUV0aCtpNzhh?=
 =?utf-8?B?OTd2TEVyN040WjlwMjg0cElWZGxobTBYem5kQ0J1WkxPczR4ckxIVGIvdHF2?=
 =?utf-8?B?Y1I4Q29VVmdlSENMc2VHRjRHY21jOEVQRGlXODg3d3ZZS0lNaFV5U0c4MlJO?=
 =?utf-8?B?SnJzZ0tWSWlyS2RldjIxM1o3YmhTcHBhdmlPN3ZsRFp0MTFDRzhyM1doTUpV?=
 =?utf-8?B?YndmNEZMUGIwM1BYYVByNDNPTDdmeW90UFRuRmp1VzNrRm9sb0JtaHlldzVs?=
 =?utf-8?B?N0VmZ0w5ZTU1YUcvd05ZcktTcjZ3UkQ1OEhFWTZtcWRHMFNqck9tQXE2MmhR?=
 =?utf-8?B?T2xkTXFVWDc5RW1ZR2RUZDRibG9BU0luUHI0ejJ0bHF2WnlNMWNnUXRGa2tK?=
 =?utf-8?B?aE5acS8wQURqKytkMm5KT0JDVnJ6eEhTU0h3UERCY0xzZlhiZVNHRHAyV21k?=
 =?utf-8?B?UE84RTNtaGhWUGRtMmFRZDdVOEJNcmlZYlByaGRkUDc4UUhIdktkNU40Q0cr?=
 =?utf-8?B?cURPVFlGL2dIdHNRTUJTTVpaWkNhSHBBcjRiZ2pQUlp5RnNXUWt5RStkM1l2?=
 =?utf-8?B?STNka1l3dFlsME5kUUtJWHdlNjdrTThZNXdmR1dkSmh6dXY4aThRR1FkVUN1?=
 =?utf-8?B?KzNjZkgxRHpCTzZxdDBPS2hRaTJtcXp5UFJKZ0lqbUVNVjV5aVlQcG5yMFJH?=
 =?utf-8?B?NnJjdjd0Yjl5SFZQVllLMmxlOFF0ZGNtVUplNGpoYVFyRktHblFrc0luaG03?=
 =?utf-8?B?V1o0dE5FcUh6R3lGbXZGUS9EdWh0QVhoY3ZMSm5RdUdueVltR2lja253enhx?=
 =?utf-8?B?RkYrZHd0QlAxWi9oZDdsSlJjOXYyODdoeUdMMldkUXVVQVdERlRPZzBNOS90?=
 =?utf-8?B?ZDVWTm5RT1NacHRlN1JLWE05SGpnM291Njk3ejdSZ2ZwaGN6cXJ0SkZFbm8w?=
 =?utf-8?B?cnkxNFJUallFK0pJeU9OczIzVHRObGo0MzYxZnJ2NExmd1lieUl0NXB4Nzda?=
 =?utf-8?B?RmVrN2l2amo3MUZraVlUTGU1MlY4bGNFdStNUE11UFN0RVJjSmprcVZDWUxk?=
 =?utf-8?B?MWxJN21zSFp6dmFTSVhjTlNFd0RZS1VtVDlyZzg4TFhoa2VSUWhldDBjWXh0?=
 =?utf-8?B?R3ZGVzB2VllKZjEySTBpUlphamxBR2t1R0YxVWJlaHpobU51M1FtdWlzeXpz?=
 =?utf-8?B?MEpwNnREcE5VK2dpNEhkZWpUQWI3NG9rdjlSam9qekovNEM5UTJVWG1Tdy9h?=
 =?utf-8?B?M1RxT2ttMnNxdlI2cGFsQ0h1ZlM3KzdvSGh3TjZsaVRSclVkY0VVZG13NEwx?=
 =?utf-8?Q?NPLUBQBZPt4=3D?=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DS7PR12MB6048.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(366016)(7416014)(1800799024)(376014)(7053199007); DIR:OUT;
 SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?OUpLUEFoN1hZM09jRWlYTVp2YXBwZjZlRUp2MzdPeTdaMnB5MW84VW5HcUFO?=
 =?utf-8?B?bkNBdHBMYkg2bGdmbWxMTWZIQnhKTm5jeVJIcXNlSm1jbmNpTjBQanNQaytF?=
 =?utf-8?B?VkxpdmVJKzV6ak9qcnZNUUh4Z2xMcHcwemV1ekhMN3F4YnFOR2pNZVpiK2M4?=
 =?utf-8?B?QzY1blFZbEp3YlNhcFhRMUhCeUNHVGZIQjYwYnp6S01NdXhYdk82SGVLQksx?=
 =?utf-8?B?NW12Y0N4SlhWZWtsUWRYR3F3SUtEcDF1L0Q4Y0FTTGM3NDhvNjY0MEpBbUZH?=
 =?utf-8?B?UFVxdUl0N3Q2UjE5TTdNZWJYUUhYcnNtR3NBRzdaeWxRdjNiUW9BeVpSdVBa?=
 =?utf-8?B?WlM4ZksvNGh2MEd1bXZUMTlseE9aWmFnbDFYSzBJa2NIVUxDK1lJYUF5REd2?=
 =?utf-8?B?Z2hPVjhwMitPRFlobTlxOHgyR2FOY0pTbFZmMXlQaGFFVjdoY3Y1Q0tLRFZW?=
 =?utf-8?B?UDkzM2hDZURIaEhUdFhtWXBLMUNnQjJ0UHBiZ3dGOU12bzJwL1czZm9wWEhD?=
 =?utf-8?B?aVVOeVlUR3BSRjBOTFA5aFRtakI3S2NLZzlZamh5M0hIS0JSaDBINXptYUFX?=
 =?utf-8?B?Q2JlblNGWUFtdjluTGhLa3hVK2lvNTVGUzNWQ1dQdy9Md3lBSzZLcU5aeXF6?=
 =?utf-8?B?UVRJWnQxTjZLV21YL2lua2tZZjhrWTB2cUg1cG9hazBqc05FSkZuRUVDUHBl?=
 =?utf-8?B?TnZLQk5PNjh6YzJ3TlFacVZtcENTakRZdDJSWnc4VzJicDNuQnpRTEZtb1Ir?=
 =?utf-8?B?VU1SdVhHelBUQUUrZTM2REVyYUhMKzNjRGJwVlpENytqYThpTlJMSmxsSW1T?=
 =?utf-8?B?N3BxYzIyNGl1OFBIdWQ4Y2hyQWFLTEtBSW0xQ1BxSStQMkloRVM3Tm5MaDhH?=
 =?utf-8?B?ZFB1UVVaaitpVXRnTFlKejZZSFZHV0g0d0FQSDdhRkY3blFUc3Q1dEhUV3dk?=
 =?utf-8?B?VUEzaTlWUWZSN2thVVA4anZsUWY0RFV3cm9BMFJRUndsNGdsNG5IejIwUGsw?=
 =?utf-8?B?MnFjOFdVb2U1SVluc0VZenZQNHp5OXJCeC9keG9wcjJFMG5ZZEl3MUNnclVq?=
 =?utf-8?B?UDVxMlhGL3o1L05SK2lLbjQ4VGFlVEhDc2pzaktqaEFHTW1oTWc4Y2VXdmJ1?=
 =?utf-8?B?ci9YSlR2Z3dwS1NnQWNqaU1CQ1owRGNJVmNiVkxVOWt4ci9TSVltbVRMSkNn?=
 =?utf-8?B?VUlZSEVpSW9PQU1XSGpHbDdwMXAxM2tLdVVoRXlJV1JnQmdXcHlZQUNXUUgw?=
 =?utf-8?B?Nlh6Z1VyRnNwMVJNRG15UzdDc1hvMEsrMWRrUkRKcDhLcWlLZVhLTmthMXA1?=
 =?utf-8?B?ZFV4VnE2eS9tL1oyYUZzcm1OOEhpOUgzVzYyOVRBYkxrK01yR0svNUxtU1p1?=
 =?utf-8?B?Wnd4c01iY3FvTDlILzQ5TFQ3aTUyeTNJS0ZEdnA0aDRlZDRZaWh4dlJCY1NJ?=
 =?utf-8?B?cFIzalpJS0hnT1JUMGVoVDNYdmU3YTlOYUQzbzBHWUZnUGVFVU9KRStzVERz?=
 =?utf-8?B?YTdPSmxOT0J0MXMrOS92NlFkQU53cDNFQmx5bzczNTl2bHRkbGJLQ3lYOHhK?=
 =?utf-8?B?TXpRdVdGTndPMEdrM0FkajhLT0RBdllXL2t4US9YM3lhRWFTMVhJUzdPZlQ3?=
 =?utf-8?B?ZU1OZmIrbWdEcGgzWDd1U0V1ZWVLbjNLL1NaNjVubUJHbUlRd1FRRXFOYTZ4?=
 =?utf-8?B?bWE4UlJmU3NUTTZMTmgwKzlEeWN3VUZheTYrNVNEQlpNV1BKcmhFT0hSK2Fp?=
 =?utf-8?B?VGhmUjg4TjVHSktka1AxNVFDRk9vaU5sTnRHQ2szQzZHVFM3QU4yemovME83?=
 =?utf-8?B?MTBMK1JtNjRxV2NQTTgyZUlZOWpoZXBVYk9ocWRBNmxma0ZLTU9zZ3BsbDdi?=
 =?utf-8?B?T24wV1hHd3hVNnptUHF0UDFISlFVRmtRRzI1YWVZZG5aWlh0dG5uaVQweU56?=
 =?utf-8?B?anFTWFRVNUtoSXIrTkdXRi9oeDI1S3NjbEZWYmRlMTJ3aDlIYWhabmh0R2JC?=
 =?utf-8?B?YnBPd2ZQSVI5U1BrV3ltMW5ENjlObU15dG9ZODBmdXB3U3pmZWd1d216dE5Y?=
 =?utf-8?B?aDQ2MU8wbFQ0UjVObmhZaUR1eTJZQ0twa3ExYmVoS0FiUHhxVkl0MThpNW9V?=
 =?utf-8?Q?lqYNQMaz5FKjEPuUZZhcH6RTE?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: f231bc3b-d6f6-4581-4ddf-08dd9e70ec75
X-MS-Exchange-CrossTenant-AuthSource: DS7PR12MB6048.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 29 May 2025 05:23:20.1047 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: vAwwic4crTXlT0CQsKefryE0fAIUghryh0L8UsMbmEcbFNDfYh83xXdXyjHLElF/QLHhT3sRY9D5EiBpszh8/Q==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS5PPF5FAA0E762
Received-SPF: permerror client-ip=2a01:111:f403:2415::605;
 envelope-from=Vasant.Hegde@amd.com;
 helo=NAM11-DM6-obe.outbound.protection.outlook.com
X-Spam_score_int: -49
X-Spam_score: -5.0
X-Spam_bar: -----
X-Spam_report: (-5.0 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-2.904,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
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



On 5/29/2025 3:47 AM, Alejandro Jimenez wrote:
> Address various issues with definitions of the MMIO registers e.g. for the
> Device Table Address Register, the size mask currently encompasses reserved
> bits [11:9], so change it to only extract the bits [8:0] encoding size.
> 
> Convert masks to use GENMASK64 for consistency, and make unrelated
> definitions independent.
> 
> Cc: qemu-stable@nongnu.org
> Fixes: d29a09ca6842 ("hw/i386: Introduce AMD IOMMU")
> Signed-off-by: Alejandro Jimenez <alejandro.j.jimenez@oracle.com>

This patch makes it easy to read macros! Thanks.


Reviewed-by: Vasant Hegde <vasant.hegde@amd.com>


> ---
>  hw/i386/amd_iommu.h | 38 +++++++++++++++++++-------------------
>  1 file changed, 19 insertions(+), 19 deletions(-)
> 
> diff --git a/hw/i386/amd_iommu.h b/hw/i386/amd_iommu.h
> index 45a997af861e6..09352672bdcc2 100644
> --- a/hw/i386/amd_iommu.h
> +++ b/hw/i386/amd_iommu.h
> @@ -68,34 +68,34 @@
>  
>  #define AMDVI_MMIO_SIZE               0x4000
>  
> -#define AMDVI_MMIO_DEVTAB_SIZE_MASK   ((1ULL << 12) - 1)
> -#define AMDVI_MMIO_DEVTAB_BASE_MASK   (((1ULL << 52) - 1) & ~ \
> -                                       AMDVI_MMIO_DEVTAB_SIZE_MASK)
> +#define AMDVI_MMIO_DEVTAB_SIZE_MASK     GENMASK64(8, 0)
> +#define AMDVI_MMIO_DEVTAB_BASE_MASK     GENMASK64(51, 12)
> +
>  #define AMDVI_MMIO_DEVTAB_ENTRY_SIZE  32
>  #define AMDVI_MMIO_DEVTAB_SIZE_UNIT   4096
>  
>  /* some of this are similar but just for readability */
>  #define AMDVI_MMIO_CMDBUF_SIZE_BYTE       (AMDVI_MMIO_COMMAND_BASE + 7)
>  #define AMDVI_MMIO_CMDBUF_SIZE_MASK       0x0f
> -#define AMDVI_MMIO_CMDBUF_BASE_MASK       AMDVI_MMIO_DEVTAB_BASE_MASK
> -#define AMDVI_MMIO_CMDBUF_HEAD_MASK       (((1ULL << 19) - 1) & ~0x0f)
> -#define AMDVI_MMIO_CMDBUF_TAIL_MASK       AMDVI_MMIO_EVTLOG_HEAD_MASK
> +#define AMDVI_MMIO_CMDBUF_BASE_MASK       GENMASK64(51, 12)
> +#define AMDVI_MMIO_CMDBUF_HEAD_MASK       GENMASK64(18, 4)
> +#define AMDVI_MMIO_CMDBUF_TAIL_MASK       GENMASK64(18, 4)
>  
>  #define AMDVI_MMIO_EVTLOG_SIZE_BYTE       (AMDVI_MMIO_EVENT_BASE + 7)
> -#define AMDVI_MMIO_EVTLOG_SIZE_MASK       AMDVI_MMIO_CMDBUF_SIZE_MASK
> -#define AMDVI_MMIO_EVTLOG_BASE_MASK       AMDVI_MMIO_CMDBUF_BASE_MASK
> -#define AMDVI_MMIO_EVTLOG_HEAD_MASK       (((1ULL << 19) - 1) & ~0x0f)
> -#define AMDVI_MMIO_EVTLOG_TAIL_MASK       AMDVI_MMIO_EVTLOG_HEAD_MASK
> +#define AMDVI_MMIO_EVTLOG_SIZE_MASK       0x0f
> +#define AMDVI_MMIO_EVTLOG_BASE_MASK       GENMASK64(51, 12)
> +#define AMDVI_MMIO_EVTLOG_HEAD_MASK       GENMASK64(18, 4)
> +#define AMDVI_MMIO_EVTLOG_TAIL_MASK       GENMASK64(18, 4)
>  
> -#define AMDVI_MMIO_PPRLOG_SIZE_BYTE       (AMDVI_MMIO_EVENT_BASE + 7)

Unrelated to this patch.. I think we should just read the AMDVI_MMIO_EVENT_BASE
register and extract the length. Same for rest of the buffer. We can do that as
improvement later.

-Vasant



