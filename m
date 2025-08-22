Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 68598CA0EED
	for <qemu-devel@archiver.kernel.org>; Fri, 22 Aug 2025 12:24:27 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1upQfr-00024n-Jo; Fri, 22 Aug 2025 08:15:16 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mark.caveayland@nutanix.com>)
 id 1upQfe-0001qk-MO
 for qemu-devel@nongnu.org; Fri, 22 Aug 2025 08:15:03 -0400
Received: from mx0a-002c1b01.pphosted.com ([148.163.151.68])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mark.caveayland@nutanix.com>)
 id 1upQfb-0000qa-CF
 for qemu-devel@nongnu.org; Fri, 22 Aug 2025 08:15:02 -0400
Received: from pps.filterd (m0127838.ppops.net [127.0.0.1])
 by mx0a-002c1b01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 57MA7uhK2824419; Fri, 22 Aug 2025 05:14:56 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nutanix.com; h=
 content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=
 proofpoint20171006; bh=7pdaTuuDJcaGjxWsNMwSdITadxGExHeIUdYsV5+MF
 0E=; b=0UMJMPCdgPwIrBRyW+SDOadTlabEQ8PyGKoHCP8Xazyws3R5VcNL1BLoW
 EaB2RVEcMUi8NMlwGKqjD2jZMBpc9bcfAQe/O/qxxkqvgH0SYma30NT0IDv511CT
 kp6YryvcRdVbe6rrGfKFi1Hi+t5uxchfy1WrUMM97CrYbGAOToYRy9ClnqXcwmj6
 vPkl1K5rgWZxmCS4nlImP6o2RtXbh+ZFrnu3bTMZhGw5sMOfAW2QQS3QdGzHvuTH
 3vvXG7zogIwTb0yzexi9Zkf/DzzncafUCv2gGCtVOXuvSQiSCVK3GUg+SayrIS3t
 warfUYrBb1y9yWPD5khQel4lDurgw==
Received: from nam11-co1-obe.outbound.protection.outlook.com
 (mail-co1nam11on2095.outbound.protection.outlook.com [40.107.220.95])
 by mx0a-002c1b01.pphosted.com (PPS) with ESMTPS id 48pphe080n-2
 (version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NOT);
 Fri, 22 Aug 2025 05:14:55 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=bROLp0agC3gfYWwJNYvZX/CqFwzroLtxsGgQPxAoHSQP8JVfKEfu3mnO2TyTovIbn06+TWypL23cjd03EiwxWvKMw0+Ue5tu+pXplBk3dVHGOvo3KAvEE2yvU/mOrodANnxTGOe5vo6oBegPq8Kv08zbZNmWDiLvvIfCnUQXjHHqxsMF4McAY0ZLLKcN9ww4zc5svE5XYCDWBgDAYHgAD+CbZ7HLz9GVrwh3lNp1U+KYpsFY8mHu/Djj0PHnC4nv4FvXL7bOqavkSZ95b7QkKud6fHjNYgjaiNN2FfrpDntOlbpDiN/1bAm6FayOg+SEm36pV9UryY5r/vh9JF8jTA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=7pdaTuuDJcaGjxWsNMwSdITadxGExHeIUdYsV5+MF0E=;
 b=YM9N8l37CIH/gBIFSU6FDx1VDraJteLPZekWYJN2kcMqo5oBZ+s/9ma/UFfMDhwXaPsFJzhFFoffNBjT6VZnjRU9slC9pJQjSlmR4I5GuPP9crYeaOKSKH93uH5mCbhuo+C4iVUe8NYJ5vfBLM9CmTNSQwZgrEkRHKJpmRU8zfyHhGtgGQ+tBxRsslcE2UGrAmoOk2bHD6lU8L5nb6mTgTJa4fnCja993CPxY4shhf3PZ6YDDwhIbEfxX4TGmSMJlyvi4IcWFxMKzjjjS5iiNfINLNGEwIyLIBqDjN1SWqqAVW15hDzYNAUjZYsgZEcUsHHYxyFXO7YLGqJ2maw5Lw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nutanix.com; dmarc=pass action=none header.from=nutanix.com;
 dkim=pass header.d=nutanix.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nutanix.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=7pdaTuuDJcaGjxWsNMwSdITadxGExHeIUdYsV5+MF0E=;
 b=XTqzRizQQLfbLhw6rrAqLWPjdcToIfgiQjuTaeUxeaMExIB3T51YK7dtt658km1lw9jcFeQG5vdWsUfByTlZe7BuAi5BUcII26Kj3vkQUzsRnalg/K9DH7mfiRkK/NDA5RbWDHSwdwB9Y3yiLrB8howF4HSFMJ26WLTR7w+U7LF04gp6dJFuHJYV96pW4aqMDYh4mXbQVtrJpWMhik/5MT5Gx/yM6mA5W1OhSCextUYkujkmXjd4USuB6gROFbgM8PZwnquYgKswR/aI9oMSmhKGlBs7yoYnV97mdhooxdfiwCpwPVIdTe4kc9fKLwY5DifxnXXN6xCxsOxtkRB0Iw==
Received: from PH0PR02MB7159.namprd02.prod.outlook.com (2603:10b6:510:16::8)
 by SJ0PR02MB7725.namprd02.prod.outlook.com (2603:10b6:a03:322::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9031.24; Fri, 22 Aug
 2025 12:14:49 +0000
Received: from PH0PR02MB7159.namprd02.prod.outlook.com
 ([fe80::6cf9:b35c:b143:bb88]) by PH0PR02MB7159.namprd02.prod.outlook.com
 ([fe80::6cf9:b35c:b143:bb88%3]) with mapi id 15.20.9052.014; Fri, 22 Aug 2025
 12:14:49 +0000
From: Mark Cave-Ayland <mark.caveayland@nutanix.com>
To: pbonzini@redhat.com, mst@redhat.com, marcel.apfelbaum@gmail.com,
 eduardo@habkost.net, imammedo@redhat.com, qemu-devel@nongnu.org
Subject: [PATCH v6 18/19] hw/i386/pc_piix.c: replace rom_memory with pci_memory
Date: Fri, 22 Aug 2025 13:12:04 +0100
Message-ID: <20250822121342.894223-19-mark.caveayland@nutanix.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20250822121342.894223-1-mark.caveayland@nutanix.com>
References: <20250822121342.894223-1-mark.caveayland@nutanix.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: AM0PR02CA0170.eurprd02.prod.outlook.com
 (2603:10a6:20b:28e::7) To PH0PR02MB7159.namprd02.prod.outlook.com
 (2603:10b6:510:16::8)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH0PR02MB7159:EE_|SJ0PR02MB7725:EE_
X-MS-Office365-Filtering-Correlation-Id: 8bc551ec-1927-4eba-96b8-08dde1757d8d
x-proofpoint-crosstenant: true
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|1800799024|366016|376014;
X-Microsoft-Antispam-Message-Info: =?utf-8?B?a0FkVDRuZDZHV1Q3UXB4MlY0dkhwZlU1ZmhROUliZjBpTWh1Ny9WaHJURjJG?=
 =?utf-8?B?SU1uWmhMNXZncHVVZU02RFpMWWRxeWRsVkFYSlRoRW01c2FPUW5ISDNaQUk0?=
 =?utf-8?B?cUsxeGc4Y0F2eW1nQ2JIK2VRT1RzbU9mZ0FWQmQyVmx3Q2c5ZkxkbUtFRVo1?=
 =?utf-8?B?TGhXNWhzZE8yZTljTUtuZHd4MGh1WDdVV28ySXlBUWtXK2pKSE5mQ2l4RjZB?=
 =?utf-8?B?RlEwN21uOWZVbGpZUEVmQTlURlRmWHI0R2FCblp2cHdxQkVNSHBMNEpWeENG?=
 =?utf-8?B?R0NyeEFyYjZzbnZYR2U5bEdmOENHTUJLQmNyU2tvR0pxWml5WUxlQStBSTNp?=
 =?utf-8?B?cDdWeFZndTZQK0E3bFVENmkvcGdDQTNNbXhlQml6Z3VFNzl1QVF3SHdaMGRq?=
 =?utf-8?B?M3hwdFFHdFhyY0hIc0thelppQjUrbHlxL1pldU5lSkpRUUl5czgxczZYMWlO?=
 =?utf-8?B?bTZkSXYzV0dSeVMyak1xRWlkcjJMODhWTEtPQXhTNGN1eHhmNDBuSTFIY0JE?=
 =?utf-8?B?bVVVOG5uVnZQODA3YzJYQXc0OXlZeGo0TEMzUTNDNFZVMzZNaTVQNEtZVUxX?=
 =?utf-8?B?MURDUFB3NnBVVXduVlRjZHVNc0hqYVppb00xK01ETmNzdmY5V0VZenhtbWht?=
 =?utf-8?B?NTdKTk1BREFielg0cHZvQjdSZEQza1d1NGlPcVJmVTRmeE1tbUhjdzB4S2Nk?=
 =?utf-8?B?L0x6UFdaQldTV2Uxa29KK21ScVA0aTZFZ1BvalhVaTk4R1FXTGNpS2ZkU1VW?=
 =?utf-8?B?NSt2Vk4rREVBZXdzZ3dUdlcvdmFsa1ZGUTI0b2xLb3Z2SFp2YndlR0ZsRjNF?=
 =?utf-8?B?a0k5SnRIUU1LTm52cFlrejFUbk1zVU1YR2wwUUdHRlgwVzc2VitNQjlwZ0pH?=
 =?utf-8?B?cWNnWVhScVp3YnRjcDdoVlMwZ3J6ZzNHVE1nZkI5SDkvenJadlovRnFuTSta?=
 =?utf-8?B?VFpCUFhrc3o2amJsRXpEV1pMRXZWM3hiSUlxY3ZFV1AwalJPR2orK1pRcjZr?=
 =?utf-8?B?d21sWC9FTnozaW0vZlNUenphQzhEa1FDRy9xRnA2cWJSWVFJbGNxeFpNekow?=
 =?utf-8?B?WFM0OUdnWlhyRFVMRDRqUjcvVzFSNW5xUVBLZVErZW5RUldwbUx4UkovUzh2?=
 =?utf-8?B?dWNEQ1BEZ0dCMGNLT3I0ZlVMZXI0K01rNTQ5ald3bW5PTHVRQnZtM0hJUWV5?=
 =?utf-8?B?SjhRNkFTM0pIbUsxalhMU3RGbzA4cm9PVjlWR3NZRGJocy9naWxucDlFQ2M3?=
 =?utf-8?B?dzIwaXRiUVhibXI0VytEWE5mbmd4NVc1Mms2ZGVXT0ExTlVUNHVZTis0czdM?=
 =?utf-8?B?MDZZRmJqSEJ6MWN1d1UvRjZuNDZQeTFLbmJJTVVCTFc0Z1REMWJmekJ2SHA3?=
 =?utf-8?B?allDUnkyQ0VsWWNIcmhHdWFXWUNuTDdsZTJZZGhOSTEwR2h1K2x0Zk5ZWWxP?=
 =?utf-8?B?K0tEM2ROazV6bnBZUUxKZGh1dE1icFdrK1dWbnpUc2tXTld4WnVQUjlFRWIw?=
 =?utf-8?B?Ynl2M3VzL1ltSXovZG8rSkduZUdwWitLK29NVG1ZYkpZcTNrQkRRUUk2amdD?=
 =?utf-8?B?VlFvOVp2ZGpGOUFxNEZ1dE5XNDlibVcrSFViVUwwbUhMQmFYQnVzbmVQL1FX?=
 =?utf-8?B?dXA3RWtPdUdzdEdlVWJtQkc2cjA3MTJyUlQvazVXRXh2WkVhMGIxSVIveEh6?=
 =?utf-8?B?RFJJZTJic2o2UHJUZWJabXkyWXpDTHZiSjV6clVvNkN5UmUwazQvVldLWkNu?=
 =?utf-8?B?UDFWNVFONmQ4Z2tJTjhReFkzQzE2MUtLMjdHRWVVV3lRdG1uTTRVVzM3UWlE?=
 =?utf-8?B?WnVOZzBjYi9YTTQ5THRUbXlkaGdlakM2VmlkZ1A5RVJUdTdwT2VlUW05clVB?=
 =?utf-8?B?VlJzZHJlN0RQSXE0VFF3SEMrVDhNZWRvMFk4VE8wTUYyMDBFVHhKcVJJd3Fa?=
 =?utf-8?Q?hCb7pGfhCWg=3D?=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:PH0PR02MB7159.namprd02.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(1800799024)(366016)(376014); DIR:OUT; SFP:1102; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?S1BEU09taEtjVTRVNjZjWWlLSTBMWTFQWnA3Ym9ZWjZEZ281aDd3cE1oK1hT?=
 =?utf-8?B?enNTb2c0ZnlQelI4V1RyYWtkTHJqaytnL1F4bGNUUWxoOUZtZlUzYnRjTUQ5?=
 =?utf-8?B?dHJSWHFWSHBRbWxEMnhnWGRFcHZqUGtQYUY5STZ4eXJlWnRRd084Uzd3RCsx?=
 =?utf-8?B?ZmJhSzZFQWkwZzVyZG50eFlnMklKVTRyU0dBN3Zqa09OWXhRSXNCditqZmc4?=
 =?utf-8?B?Y3NZRlpqRk1yYmEzdGlQR0RuL2taYjBTend0SHAvWi9jYk10a2hRRjNveEVC?=
 =?utf-8?B?Zlk2VWs5clRleS9wUWxkS0cvdCthTHNEMVV6bTd0bDFPbzVXRU1KS3JiNUlY?=
 =?utf-8?B?MjBIMk1aZi9TRzdkL2lQK28veUltWFNwbXR4V2NPTVIwWGNYNFZnTDVPNnV0?=
 =?utf-8?B?UzJXREVmdTZab0VlZjZrVi9VY3lHcE5TRnp5Tkt2c0F6bnFJbUJnanVCU0FN?=
 =?utf-8?B?dExEamdnNmM2Z1dhZGljQVg0NmJTb1hzSi9jMGlpaTg4cFphK1ZUbG5OYlE5?=
 =?utf-8?B?MTdtMXhaTSt4NzJ6RWF1eXJUVVNkNjAzZEovUGpYcTlaZXhHOHh6ZWJBWlJa?=
 =?utf-8?B?VkNvMU9EU1htQ3dkRUdsWURWK25Zell1ekphZ0Vsb1ZSTDljeWlwTkxQeEUx?=
 =?utf-8?B?aTkyWGh5QUdzVGNJVXluOUR3di9OWEdSRzl5aGxjakNRdmRkYmYrUkIrOVc3?=
 =?utf-8?B?NmlHSGFNem1oc2NjaVB1eGNlUWUxUml2d3ZqWWU5cys2VElNREJXVEgzRWNL?=
 =?utf-8?B?b3BlcEdFdjNJTm9BRE5SbW1oYnllWVg4djRpRUdUbzR3Y0JrU2djS0o5NXZv?=
 =?utf-8?B?djNnUjBlT2FsMXhtZnIxN3hEZkRpSy9nTjhhbGZCcW9pL3pQQm1ITW5CK3E3?=
 =?utf-8?B?ejcyVXhVUlRkZG81Vlo1RnNwQWgwRGZiTnNZV2tCK3M3THNBeFZnQUs3VGpY?=
 =?utf-8?B?NERucXJXY2lwYk9yTjFLb2VFRTBNTDJxSTF2N2dnVW8rUnE0UE90UCtBT0Jt?=
 =?utf-8?B?NG9pMTFlSWY4S1pCanVja1kxRnFCcDd1VXZVUGZEaC9TaDNId0FzMFVUM05h?=
 =?utf-8?B?c1k1Q21xbnRnYjJMRk1SMFc5TW5VL3g4dWc2SGp2dk5qMlVsYlBWUDEvb2RV?=
 =?utf-8?B?M2pHNEJUZnh2Vi8xYUVudjFqMnNGNkxlTnVxeERnYXF5bTloampPVkdZSU0x?=
 =?utf-8?B?ZGxreUNxZUVNNHJVMy9vWEloWmpJTERQem9mb3RuMnNkN21kdzkvK0hqNUFq?=
 =?utf-8?B?bzFGZE85L1FMcTlWaEVqQUpQR3NKVnkyQWlOUVR6UXdIaU5OcTkyb1Zyc0ZX?=
 =?utf-8?B?TWlkY2JYTnh3M2lWS1liNmRsNVlKbjdkOUVXNTE5bWk0dTh6R2ZBZHRpVUF1?=
 =?utf-8?B?OUI5QjVyN2g0QXhONVp3RHFsVjFhWEQvUkVZbkZBcEpNY0VJc3loMkNBN2du?=
 =?utf-8?B?NjNVMEhtN3lmS1plMGZaUEtSUEVqZnVtYlk1dXBPY2pNNFpMVU1tMHpBTktB?=
 =?utf-8?B?Q2Qya3JNblUyTm5ZZStVMDJWTmxWdUs5bWF1Mi9peGxBZU1OT2hDVTNmcXp1?=
 =?utf-8?B?UG1jek44Sk1WcEpscW9rSjdndFJNc0pvd2J5Nm9jeHFrcCtiUmdGaGJjdnp6?=
 =?utf-8?B?dXJZR0RpNmwvM1RUQTc1WVF4UlhlY013aFVySXNMTXMxYnJPdFZPQldpOVo4?=
 =?utf-8?B?eVRJam5FK3VXWjNMSUJSTUZWSm9oL1ZReGpDWEJ6TjBnWlgvaC9ZeVpiMHNJ?=
 =?utf-8?B?VEtuUkVXQzRQWko4WURLWnFXNEk3a3gydXhkVzhaWGxVejdURERxd3IwUXUz?=
 =?utf-8?B?T3ZOZTBhV0JFbmRBYUdEUGdrSXI1RE5GNXhwbnErSS9jWkdQcFlZdGdZdjRV?=
 =?utf-8?B?M2dNczJDVFJ2UmtFWHVpM05PR3NvSVkrcGZNclRjUDUzVi9mcTB1ZTQ5NmNx?=
 =?utf-8?B?M1k1OFZOWjV2cFRPV3ZFNGpwb052Z2Z4KzZ5bHQrL0lGRzJUWkRXVk4wNXZS?=
 =?utf-8?B?NU9VT3U2MUpzZCtzbU53N2lRUjhxaWF1b050czFLM0ZUYTRndVVxK1pqNVh3?=
 =?utf-8?B?RWVYTlFMVVpPVFlhV2JoQXhnVHpZZ2poRzNMTjZqZWlXampKTjNzNGxHT1g0?=
 =?utf-8?B?NW81SkNhRGNyK3FDNFkvb2lJNjJoTW9WTTl1ZE1aQ0RSSzJ3ZmZCRUtGTDV6?=
 =?utf-8?B?ZkE9PQ==?=
X-OriginatorOrg: nutanix.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 8bc551ec-1927-4eba-96b8-08dde1757d8d
X-MS-Exchange-CrossTenant-AuthSource: PH0PR02MB7159.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 22 Aug 2025 12:14:49.1916 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: bb047546-786f-4de1-bd75-24e5b6f79043
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: GVwCx25w6ovi+HssI0N+oYSdySrJomotm80kd3UiAF/XCdhqZJ82AjQFSP2UKNye2xyKnpBYcoLXWcV09HtWPBZpZHnyTPgv1dOfU4cFrCY=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ0PR02MB7725
X-Authority-Analysis: v=2.4 cv=PvLKrwM3 c=1 sm=1 tr=0 ts=68a85f3f cx=c_pps
 a=YKE8LuPMBYZ6rjMuwm3XPg==:117 a=6eWqkTHjU83fiwn7nKZWdM+Sl24=:19
 a=z/mQ4Ysz8XfWz/Q5cLBRGdckG28=:19 a=lCpzRmAYbLLaTzLvsPZ7Mbvzbb8=:19
 a=wKuvFiaSGQ0qltdbU6+NXLB8nM8=:19 a=Ol13hO9ccFRV9qXi2t6ftBPywas=:19
 a=xqWC_Br6kY4A:10 a=IkcTkHD0fZMA:10 a=2OwXVqhp2XgA:10 a=0kUYKlekyDsA:10
 a=64Cc0HZtAAAA:8 a=KKAkSRfTAAAA:8 a=9K-6XCuZSqnjzfDIaq0A:9 a=3ZKOabzyN94A:10
 a=QEXdDO2ut3YA:10 a=cvBusfyB2V15izCimMoJ:22 a=cPQSjfK2_nFv0Q5t_7PE:22
X-Proofpoint-GUID: XpgtR_vlPBkRu1L_GITfmq4LT0wrGXp7
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwODIyMDExNCBTYWx0ZWRfX1krDIxlxxLzC
 bSeKjFMSyUHTInVPET7wgQK7ihkVu64GdDImU3k2Y2cr1xDmOjgrgwplZytIm0nKQByLwd63GYP
 2C7S+UYS4FAb+ZKpxXpxpmgrTAkXvJA2eKZkw8/EZ3Lz+X6sEapgBrOYYJdXOCyJ6kQh5GqM7CC
 fK6qGCOSNbwSzr/YFKfekaWSBqyjNcp5tvyBGMqUL6O3dpdoYqC4jxGWEGF/A4F2IOnlN4/73vc
 95WJUXEHU6fpCHJU6GZ5+s6/6DZYJ9H3y7gXfdr2/jhraW6KvDjvjO90ekRUUs0E0UOBw1yTWE3
 frDqJq2SL62H7mTDhtdhZpOA2N678exOwn5/Ao56S1YWnY3Rhh3rSs7Qge5sBQ672kYGrkAV1nv
 xYo0j79gSgGirYivfnm37g1mzfBzQw==
X-Proofpoint-ORIG-GUID: XpgtR_vlPBkRu1L_GITfmq4LT0wrGXp7
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1099,Hydra:6.1.9,FMLib:17.12.80.40
 definitions=2025-08-22_04,2025-08-20_03,2025-03-28_01
X-Proofpoint-Spam-Reason: safe
Received-SPF: pass client-ip=148.163.151.68;
 envelope-from=mark.caveayland@nutanix.com; helo=mx0a-002c1b01.pphosted.com
X-Spam_score_int: -27
X-Spam_score: -2.8
X-Spam_bar: --
X-Spam_report: (-2.8 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_LOW=-0.7, RCVD_IN_VALIDITY_CERTIFIED_BLOCKED=0.001,
 RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001, SPF_HELO_NONE=0.001,
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

Now that we can guarantee the i440fx-pc machine will always have a PCI bus, any
instances of rom_memory can be replaced by pci_memory and rom_memory removed
completely.

Signed-off-by: Mark Cave-Ayland <mark.caveayland@nutanix.com>
Reviewed-by: Philippe Mathieu-Daudé <philmd@linaro.org>
---
 hw/i386/pc_piix.c | 4 +---
 1 file changed, 1 insertion(+), 3 deletions(-)

diff --git a/hw/i386/pc_piix.c b/hw/i386/pc_piix.c
index 5babdc3e4c..b736f0f236 100644
--- a/hw/i386/pc_piix.c
+++ b/hw/i386/pc_piix.c
@@ -113,7 +113,6 @@ static void pc_init1(MachineState *machine, const char *pci_type)
     GSIState *gsi_state;
     MemoryRegion *ram_memory;
     MemoryRegion *pci_memory = NULL;
-    MemoryRegion *rom_memory = system_memory;
     ram_addr_t lowmem;
     uint64_t hole64_size = 0;
     PCIDevice *pci_dev;
@@ -191,7 +190,6 @@ static void pc_init1(MachineState *machine, const char *pci_type)
 
     pci_memory = g_new(MemoryRegion, 1);
     memory_region_init(pci_memory, NULL, "pci", UINT64_MAX);
-    rom_memory = pci_memory;
 
     phb = OBJECT(qdev_new(TYPE_I440FX_PCI_HOST_BRIDGE));
     object_property_add_child(OBJECT(machine), "i440fx", phb);
@@ -222,7 +220,7 @@ static void pc_init1(MachineState *machine, const char *pci_type)
 
     /* allocate ram and load rom/bios */
     if (!xen_enabled()) {
-        pc_memory_init(pcms, system_memory, rom_memory, hole64_size);
+        pc_memory_init(pcms, system_memory, pci_memory, hole64_size);
     } else {
         assert(machine->ram_size == x86ms->below_4g_mem_size +
                                     x86ms->above_4g_mem_size);
-- 
2.43.0


