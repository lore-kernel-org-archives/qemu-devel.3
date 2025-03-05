Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id EF90DC282D0
	for <qemu-devel@archiver.kernel.org>; Wed,  5 Mar 2025 02:57:39 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tpewA-0001n6-9b; Tue, 04 Mar 2025 21:56:46 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <Suravee.Suthikulpanit@amd.com>)
 id 1tpew0-0001mg-Vr
 for qemu-devel@nongnu.org; Tue, 04 Mar 2025 21:56:37 -0500
Received: from mail-bn8nam12on20629.outbound.protection.outlook.com
 ([2a01:111:f403:2418::629]
 helo=NAM12-BN8-obe.outbound.protection.outlook.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <Suravee.Suthikulpanit@amd.com>)
 id 1tpevx-0007OC-Pa
 for qemu-devel@nongnu.org; Tue, 04 Mar 2025 21:56:36 -0500
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=mZXW5ukyroYlqi63xC8aRXPf1yVKB7Rba3E7QmlaWUpWS482iyC4QyEMJp2OnTyI4DHFsyUUgd1L63smGmH+frSchq11QIW7Pbj04RKxM4HWjrbd+nATySGT1cc7pTfMX/h66N7EU1sdIxOZUH267onmB8vhJq77cINusP/jZel5xhBi8M5popHXeHe95NuksmlHSOu1aQj/xCFbo8rDHDXQHX2ZHYk4hAnylXt5/aVt9zFeCr9bLi+tZhvniufRHQoMqEmBhymF3oA8Y5fnCVFAt/J2kc5Ee6QqmBYGgnVGc6mOu3mmvBNB/23W8uV1Zi4mmIISL72YuQxeatkGgg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=q5nA7OM7Urq95Phv6NOKPL2PwwrF/dEKdgSWiJhwTS8=;
 b=xBwTMOYj2s6Z8Bzp54gU/xJc1RWcDic53Bi8sGdqgfWoqn0hnMZpoRiCkGXiYDkOqAzeCAvjFtj6zDuLMAiSaU3N/j5OdByXRmvI4mwqegJG7Rh+4tXr6UvQQu7ymOZOg+auouY/hLZUbeP3xHREmk7R2DlUAj8C6N9y4LouX/KbZF8gOXhj0fobj6y8vi8MYyoxUNt4eE6vLS2ay/hqlUBDplNZTtDgnWSb0K/ll4npljRocgZa6VUuZVOoznt4/HB6Dpo0PZQCDfjmnttL6PljQvntOcULLYVrR0MUDEcl7REklk1zEWdp4Ntm04jFwAF5TB4P7KOjKzqOSlUQrg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=q5nA7OM7Urq95Phv6NOKPL2PwwrF/dEKdgSWiJhwTS8=;
 b=s8F3aXhfg6AeaPk3p701o1uhPKHGujL8DOeZyhxe22XZbfzzPaqQ5T1xP2i5vzUGQ6qEKcujIfM2nQv3xDzIMlnJN2xMGYRD1iPtYrk2DuzmSjC3LKr9vCULga3y+KPACA3SPAd3S7L2SPIg7Fuy8zy/V4BSfxag3b12A1JTyw0=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from DM8PR12MB5445.namprd12.prod.outlook.com (2603:10b6:8:24::7) by
 MW4PR12MB6804.namprd12.prod.outlook.com (2603:10b6:303:20d::16) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8489.29; Wed, 5 Mar
 2025 02:56:27 +0000
Received: from DM8PR12MB5445.namprd12.prod.outlook.com
 ([fe80::a544:caf8:b505:5db6]) by DM8PR12MB5445.namprd12.prod.outlook.com
 ([fe80::a544:caf8:b505:5db6%6]) with mapi id 15.20.8489.028; Wed, 5 Mar 2025
 02:56:26 +0000
Message-ID: <61205b17-3556-45d5-87b2-347a9b2c2b69@amd.com>
Date: Wed, 5 Mar 2025 09:56:16 +0700
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] pci-ids.rst: Add Red Hat pci-id for AMD IOMMU device
To: Donald Dutile <ddutile@redhat.com>, qemu-devel@nongnu.org
Cc: pbonzini@redhat.com, mtosatti@redhat.com, mst@redhat.com,
 marcel.apfelbaum@gmail.com, jon.grimm@amd.com, santosh.shukla@amd.com,
 vasant.hegde@amd.com, Wei.Huang2@amd.com, kraxel@redhat.com, bsd@redhat.com,
 berrange@redhat.com
References: <20250304183747.639382-1-suravee.suthikulpanit@amd.com>
 <c8adb591-c4e5-4658-9b87-cb11d75c143f@redhat.com>
Content-Language: en-US
From: "Suthikulpanit, Suravee" <suravee.suthikulpanit@amd.com>
In-Reply-To: <c8adb591-c4e5-4658-9b87-cb11d75c143f@redhat.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: SG2P153CA0050.APCP153.PROD.OUTLOOK.COM (2603:1096:4:c6::19)
 To DM8PR12MB5445.namprd12.prod.outlook.com
 (2603:10b6:8:24::7)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM8PR12MB5445:EE_|MW4PR12MB6804:EE_
X-MS-Office365-Filtering-Correlation-Id: d136bba7-e27f-4e55-33a1-08dd5b9151f4
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|366016|1800799024|376014;
X-Microsoft-Antispam-Message-Info: =?utf-8?B?UGFQUmpIUlFVMmlpL0JGOXlVaU5sRHNTekFaL25wRW82RzBnSElPYXFYVElR?=
 =?utf-8?B?bDh6anNCaERMY1h2dGJ5VE9CS0ptcFErbzhHMXMwYnIvZXVwdHc3ZG5INUc3?=
 =?utf-8?B?WGVxTzI4NEJ4WjRWZllHa2pBNWIyd3VFY0NBSExHdHdISFBTalQxbnFJejV0?=
 =?utf-8?B?TEVXWTd4aUNzNWJUSmJDbDU4bmNaMGNnMFkxZW16elloelBaOUN5QU5qTCtE?=
 =?utf-8?B?dXNZZFlVeGpHRVB5WU1nZk4vV1Uwd1Y1L09LQ0FrZDVuVjc5eno3cU40RDJs?=
 =?utf-8?B?citqYTAwVE5mUGdPSFlCYjJMNENhSzhGNURaUVRwRGY5TXE1M3RmNGF1bmZ1?=
 =?utf-8?B?ZFdiTTZDZzRlemw3MHFIMm1WM3JMa3BDOUozemlST2VNLzdHc05mR2dvbkJW?=
 =?utf-8?B?cTkrU0FiNktqaHFIeGF3NUZTdlIwNU9aWW1oelJmWTRzdGdDbU55WEhmODFh?=
 =?utf-8?B?OTdsNDhTeHZ1RWtWOEdWUUdqV1d2bkRsT09ldHFQTkpHRUVGU1RxWGNCTWlj?=
 =?utf-8?B?blNrT3ZrMkY4cDFEVWUwczkvMFJObm9BRGgraUtnelpyYjlxRFBOeGlxdXVI?=
 =?utf-8?B?SThsbkt4RzFZYUdWcGlSNkcvTTBHUkE0MjN3dHpRUk5TK0RrRkpha0loVFJ5?=
 =?utf-8?B?SVVBRGVqb05kWnlrL1k4dXhmdjJ4S3ZYOVdUYlBEcU5nbkIrT0F2NGh2c1Bz?=
 =?utf-8?B?azY1Mng1L0U2RjNhYTRhbWJiS1F4NjMxSnFxeFhseENUelA3NGNDOFFCT0dN?=
 =?utf-8?B?TlBYdzNJUW9LTjFYdkRwTWdoNEthRlU2dEhaTUlUYkIxQloxbnF1bFhjekZw?=
 =?utf-8?B?ZDRSWnlGUXJuM0VxamU1VzRlWXA2SzdMM3YxOGt6Y3lDdVF0Z2dodlNLNmwv?=
 =?utf-8?B?SXU5UURMNEJPekdHdFZuSmlRMDZLMUlRREg5MDNpeSs0TTBrLzFFcUJ1VFh3?=
 =?utf-8?B?ZWN6dm9xNjJpbDZkMmVyUDF6ejNHWjBOcU5QZnp3ZmgzbEJPMW9CYU5xSWJu?=
 =?utf-8?B?cWt4VzB1emFRU0VXaDZaNFZPZDRheW1mc1V0SG1yLzlXbjhiRWJKNzJrL1N4?=
 =?utf-8?B?YVU0S1BPUlJmMUdaUWhJUTZPRUQ3TGdPaDFZR0JadkFTN1JLRks2N21ZclNK?=
 =?utf-8?B?VDRxR0RBbWtZRmY1ZU13d094YjJudjd0SkhDbkcyek5RWG5yQXp1czFFQnNx?=
 =?utf-8?B?cW5wendNN290MSthSURjVHZhOVFvWWFzZ3MyRTVnbS9kMUNtMlA4ekNqU0t6?=
 =?utf-8?B?c25GRksya3BVeE96R1dHalExekFmdmZRQ0hjbklkUHJ1TFlEQk5xYS9RTC9p?=
 =?utf-8?B?VXdSQzFHY1NhbE94YUZDYzl2T3N2bjJWNGIzZUNTcVBJa2RrU25PQzg3aEFl?=
 =?utf-8?B?Wm9uU09SRm52UUpOa1VyVVV0NDc3ZEhZTXRIYkNadGJMSFJHcWloRmZvTUF3?=
 =?utf-8?B?VFZqMEp6WjdZUFc2Mi9tSTVDWDlvRHNPcXVIdzhRZDcrVGR3LzliTDJwbEpn?=
 =?utf-8?B?VE1pT3JSWEwyalJEVmxNbTZ5Njh5dHBoU3ZUUkkyUTRCSFlUbTBzWEhDN3px?=
 =?utf-8?B?b1VPMkl5Qm5MVmFhTDlEVTVMTkhHa2tJMlhkNUJEUmMwUWZnNVBNSU5zTHds?=
 =?utf-8?B?MmF4SUF3YWV2c0xMcGJwNERGY1dSeEEzVEFWVUNJTnpmd3BISG8wc3RkM09V?=
 =?utf-8?B?bTJrRlhFTS8zNVN1SmwwcFZLUU1NMzZ4Z3V0TVEvMytNUkNkOUFNK1dWWnVE?=
 =?utf-8?B?d1F6anZxVnppSnBwRkFiQzk3K1Zha3lTbmNEa3lXRTQ0R1N6dEQ5UVVjU3hv?=
 =?utf-8?B?dzZXU1Q2amZZOU9xWjA3T0hiQUdzV1RYRGhTOFFOVGNiU05PdS9TQkFGMG1Z?=
 =?utf-8?Q?1ZV7vG4+rVEp0?=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DM8PR12MB5445.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(366016)(1800799024)(376014); DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?K3Y3SXdBQzdadlpYMzd2NnREeE8zK0wrRE5Ha1EzbmdONkRwKzI1ei9rMnJS?=
 =?utf-8?B?dGtiSXpUR2hsazFrdHpPc0p0b2tleEFNaGpyaXpSSDFPSkZ3Qm95L1NGUEFH?=
 =?utf-8?B?clJveUZuQlJYVlY2bUZUcG5DbnFSQTJac1A5dlJ3VmlKZUtCZXFKUE5POUJC?=
 =?utf-8?B?aHRLSytuT3JGL0xkUVJtM3FzMkZ6ZGVwdmNkTDZObFBJWWVTazZlSjFUZm42?=
 =?utf-8?B?all3OXVmS0F2cDY1Q1dHdTQvWUVKRmxoSjk5cTdCVW9wUTF6ZnRKSFJSMkUz?=
 =?utf-8?B?cXUyL2Y2UXRGY0ZtTXBMWUhwb0g2d1BxK2t3b0lRNklWM2FKUzVrWEhFTkJH?=
 =?utf-8?B?cGZJYkpHOGV0bWpqWkRjVHRVWmQyNmd4dC9DNGpoQUVtNndaYmNuK25kYlNn?=
 =?utf-8?B?QitFdGdIOUNTUnRDL2FOS0p6cGpCMW81OFk3SzNuNHhTOTRNZUc4TXJyMTF5?=
 =?utf-8?B?N2ZUR29iQWlhZ1A5YTNyajU1ZlRGemhlRzk2WDBjRjF2SnhOcVNLZk1CMnl0?=
 =?utf-8?B?bmtyblJlUVk3Z1hWeElrVk81M1ZaYWZoc1hud09wMXA0YkhKTy9Nd0ZXMnJs?=
 =?utf-8?B?ejUxb00xQWNYQnFKZDF1ZndFelFBeU9DRUU4d0tRN1k4WloyOFFBbEtkc1NX?=
 =?utf-8?B?ZVpYVFdjeFNINjAzWDNndDloSXVtZHB4SldIVldhUURxRnNZUkE4aXlHaFdr?=
 =?utf-8?B?THlCTHlPZzZnT2Z0NFhaK3hWNWZjMjg5NkY2MGFYWDdoV1J1WkhXNGJaUzVw?=
 =?utf-8?B?SHhpZ2NaWWlHV1BYNVViUlA1RE5hMlFoZElzZlNxdXV1YnhrYUtXa3Y2Vnl2?=
 =?utf-8?B?Y25LNjBZdWxKOTN6ZG94TGtkMXpjczBVUzh1b084My9qQjlmc1p1WWxPQkNl?=
 =?utf-8?B?dVBQaFpVVEhCZGk5Qm9Rd3dnN1VZZVJWQmJoS2lhYjFyeERySjJCV3NNMlEv?=
 =?utf-8?B?NVliY1d3YWNXN2MraXZJMTVrSzZmcDVIdkd6RDZOdVJXRlJMbXo5Y2pXUjVO?=
 =?utf-8?B?Sk9HeW5kckk0SVFDcDZGMnMzZm5QRzJJV0JsVG1JcWNpZGNUSWNtMTRQd1p4?=
 =?utf-8?B?OCtXWTE0NGlEa2tlYWlCZk5RZ0d1eWhqQktkYVJFditMUFNsMVJGUnR1ck42?=
 =?utf-8?B?NHJNbkxTUXJnRkZib0plYS9OeEVyT2MyR2FOR3lHL1dHdkRLLzFETFA1M2s0?=
 =?utf-8?B?UkwzVWVSRklLMThVcGlpa0p5T2ZBVHlmVGpMSklMd3dLTjZ5Y3ZndUJkSHFz?=
 =?utf-8?B?dWNJVUQza2dnbkFxa2ZFUTBIK1dObmh5U2l5UkJLd2hpa1FhSVlSNE9NQkha?=
 =?utf-8?B?RW9sbFdxSmZSZFZqQUtQcU9KVjROaWg5eDJWQlhydVlYbmNHQ2ZERzhCRUZa?=
 =?utf-8?B?QjN0WlRvWFd3WERUVGIrbUxpalVXWFJBUkJVOEswbkZYYjN6eDdVUVIzOWN2?=
 =?utf-8?B?OThoS2tSWkVvS3dwWlJKMGZDOUNqTHVYZ2FjZEFZNXE5UUdrRHBITlFhYnVI?=
 =?utf-8?B?WUJrWVpRRUcwWDNIbDRTdGRzbGRvbzc3K0hJZmM4Z3ZaUTVYTDlnOHZ1bGxQ?=
 =?utf-8?B?d0FwLzJ5TWhDT3FDT3A0a2Qvbkhublg5aFc4anN2OWlPMkhoT0ZQWERMMU1I?=
 =?utf-8?B?amFkU0UyN1hFQjhRRzB4eHhsb2JPSmJXeUFRREExc0FoR0xsRHFNRjlLWWRk?=
 =?utf-8?B?ZGZVK3ZaU3BVMjZKbXlOWjVCZUhxNnRvMHVWVUQ4SzM5Zmp4clI0VjBJejhF?=
 =?utf-8?B?c3htM3F6WUhXV2tiSmxhUmxHZjE4Qk5EZTBsc3dHejBlOHN0cytwT3VGckRM?=
 =?utf-8?B?TksrSUJEcGU0ZGRwRGprOWhINGozYmJUSThsTHhKL2JXNzNpOS9Td1YwWkk0?=
 =?utf-8?B?WGtuc3ZPd3RwWXoraHZ1Rk5kZjA3bXhTaEgvZkdmS1dGdzRQUnV6QmZENFU3?=
 =?utf-8?B?UW5pQTEvL2ozaWJxdDhKdHNyZUQreHRQa0FQeUJZWHlhNlVManloME0wNU12?=
 =?utf-8?B?dkFGbVJ3dldQaXlhaktUVklkNi9ZVThEQzV2UTZNR0NxYXNEeTdQVFgyTEcx?=
 =?utf-8?B?YVFyVDQyYmZ1UFhmNlpRS0pTSWRhTHZVdUpaSEg5aFJsQU44Q2R4SDdRZXRX?=
 =?utf-8?Q?ej02+hSX4YYTC8mU+w/zCSWJ3?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: d136bba7-e27f-4e55-33a1-08dd5b9151f4
X-MS-Exchange-CrossTenant-AuthSource: DM8PR12MB5445.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 05 Mar 2025 02:56:26.4533 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: BNkJ/j4yWi6Rdpcoz4yWEbIcebVwzC1QJ0T7nmWu+muDpon2aEjlMTBmlv4NtzaeQMDY9sxKMBTfIQGIS9wHpA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MW4PR12MB6804
Received-SPF: permerror client-ip=2a01:111:f403:2418::629;
 envelope-from=Suravee.Suthikulpanit@amd.com;
 helo=NAM12-BN8-obe.outbound.protection.outlook.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
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



On 3/5/2025 6:02 AM, Donald Dutile wrote:
> Hi Suravee!
> 
> Not your issue, but wondering if others know:
> 
> Why isn't this an issue for Intel-vtd-iommu & ARM-SMMUV3 ?
> Are they instantiated as non-PCI-id (platform) devices, but AMD puts 
> their IOMMU in PCI space?
> 
> Adv. thanks for the info.

Unlike AMD IOMMU, Intel VT-d IOMMU and ARM SMMUV3 are not enumerated as 
a PCI device in the system.

Thanks,
Suravee

