Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 510E5CD98CC
	for <qemu-devel@archiver.kernel.org>; Thu, 11 Jun 2026 12:55:46 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wXewJ-00082F-Vj; Thu, 11 Jun 2026 08:55:20 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mark.caveayland@nutanix.com>)
 id 1wXewI-00081z-QU; Thu, 11 Jun 2026 08:55:18 -0400
Received: from mx0a-002c1b01.pphosted.com ([148.163.151.68])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mark.caveayland@nutanix.com>)
 id 1wXewD-0005Yl-Sl; Thu, 11 Jun 2026 08:55:18 -0400
Received: from pps.filterd (m0127840.ppops.net [127.0.0.1])
 by mx0a-002c1b01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 65BCZDgN3935000; Thu, 11 Jun 2026 05:55:06 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nutanix.com; h=
 cc:content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=
 proofpoint20171006; bh=gWRSyRI3TORytBeVpyw0ufqrkX32bpGV0SMIMGuN/
 4I=; b=Cq36iZTHxXvqV9pIApSvGe807mZq9Wu+V09dW9YQI+Dxh+fnBB9HBXgU7
 v5TpyG2rXsp9H5BgX/8gUA2i7VwmO07bzZc1o8FDzl3y+aAURigbe3o7GUb4klWv
 e4jV7nokyw3B57MQgt+QFZqG2UBhj17TC4M6ikMedjUAeNNKnMU5CzMLH5Zi5Vt5
 kUsQH9/Wa+3IcQAoorE7ShOLjk9sYeXMllZSl90KR0ASPr2w6aJ6c3ttPXGna5Nx
 eVqDsDh+6jhydexk9KkRf98h/Q/+2lJqpybi/9OKOFq3BtkyEiQmTe586phOHcAh
 yjhX5FudkCCAxPSI/58ayzq/ia62Q==
Received: from ph0pr06cu001.outbound.protection.outlook.com
 (mail-westus3azon11021142.outbound.protection.outlook.com [40.107.208.142])
 by mx0a-002c1b01.pphosted.com (PPS) with ESMTPS id 4eqe5w2384-1
 (version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NOT);
 Thu, 11 Jun 2026 05:55:05 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=T2ktKnAd+1106RZMQGhGlZp9kQJ7Z+UPHD7N69De5vgYRAYN5B6CDIPMPwOHMbf8I52aiCoeV9BnQ8g+JptoY4umfMoxe78s9/J0jOe4K0GMR46o3M/Y9ai7ULWVjobP7CqWL4XEpu9fCbfp04LRcNfO3nYQmPzQBf0sGzHG/hw5Y4Tc2fN3l2zwB7DrOOfn4M2kV8xq1Q2vzLQSyTt4yeqYnwpTCoBu8S2gLx4SdN2XZuDkRadqOoN5hdxbb8lymLF3ZQU079jBcWsTcQAXYbStZyZEoNKUgxZlpU/xKw31aF7fnAi+3L40rQoYQ7tAiL5pDZXuFUm0Fv7+i+ZxUQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=gWRSyRI3TORytBeVpyw0ufqrkX32bpGV0SMIMGuN/4I=;
 b=rIslitklLFo/lEjI34baf6C5QVZgNs6QkXSmKJZN7bGarqf4ysskVz7vfIqwm0WRt6NhPZLOfCjfNif66MVGTvJm+eeQ4zSetIMgbNNUlJvKFBbj5q3Rr9Vrz56m0EClyhBc2qSjXdLGqYfLMYJtaVJfEjMXo8F1YzEGSmWK8qLxwOjUlaLtxRNvAJFJDUyP6IqItKSu/Z3qh/lHNYy81oQPgw9tQLCmmrTAUUcTyrCdjd1lohoq8YwJBYVZSDEEJqUXgXt3DMcpCl58EklXfQB4SOqbgTCnkJEZJ/9BCne0dOc2t7IcauIh6moZfGhsIwh9TAFY4We0Jt8ASpa/pA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nutanix.com; dmarc=pass action=none header.from=nutanix.com;
 dkim=pass header.d=nutanix.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nutanix.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=gWRSyRI3TORytBeVpyw0ufqrkX32bpGV0SMIMGuN/4I=;
 b=ye/jIm4D4P3jfYqYXUWoJKTgdB7RYyzZZgfJmF1mYoH2ZLZYcgGWykhOQeK+C9B+Pmobn7s2xFMjedshPOnIpxwPN80JOm71z9S6KAj/0pFeAdJN9VymdS8r6AxW9MnSjo040a5V7iLUFKgXsVbktu1OqMzC16KquWNTvvFXI4Dd6oyLrPzpLNodYdYB3U5GU7PT64alXUugesUnlQlAtRru78Wra1TtQ+jn0n14HImMy737+Q1zFScGWO/yHkZFe9dWlubM2K+7ndOO9Jy3McsJOP89ob0UAbEqHAf3M0EPMazn60Bhk7jxKNnQgN0LDVl8zayVcM5EOF+gThZBIQ==
Received: from PH0PR02MB7159.namprd02.prod.outlook.com (2603:10b6:510:16::8)
 by CH0PR02MB8117.namprd02.prod.outlook.com (2603:10b6:610:10a::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.113.13; Thu, 11 Jun
 2026 12:55:03 +0000
Received: from PH0PR02MB7159.namprd02.prod.outlook.com
 ([fe80::8e97:bc32:822c:b250]) by PH0PR02MB7159.namprd02.prod.outlook.com
 ([fe80::8e97:bc32:822c:b250%3]) with mapi id 15.21.0113.013; Thu, 11 Jun 2026
 12:55:03 +0000
Message-ID: <73fe919b-d8eb-4b01-8401-f7ecb418eb11@nutanix.com>
Date: Thu, 11 Jun 2026 13:54:54 +0100
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 05/10] qom: Create object-property-ptr.[ch]
To: Peter Xu <peterx@redhat.com>, qemu-devel@nongnu.org
Cc: qemu-arm@nongnu.org, =?UTF-8?Q?C=C3=A9dric_Le_Goater?= <clg@redhat.com>,
 =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@mailo.com>,
 =?UTF-8?Q?Daniel_P_=2E_Berrang=C3=A9?= <berrange@redhat.com>,
 Fabiano Rosas <farosas@suse.de>,
 Vladimir Sementsov-Ogievskiy <vsementsov@yandex-team.ru>,
 Peter Maydell <peter.maydell@linaro.org>,
 "Dr . David Alan Gilbert" <dave@treblig.org>, Eric Blake
 <eblake@redhat.com>, Akihiko Odaki <odaki@rsg.ci.i.u-tokyo.ac.jp>,
 Paolo Bonzini <pbonzini@redhat.com>, Kevin Wolf <kwolf@redhat.com>,
 Sana Sharma <sansshar@redhat.com>,
 =?UTF-8?Q?Marc-Andr=C3=A9_Lureau?= <marcandre.lureau@redhat.com>,
 Juraj Marcin <jmarcin@redhat.com>, qemu-rust@nongnu.org,
 Markus Armbruster <armbru@redhat.com>
References: <20260609172514.2037645-1-peterx@redhat.com>
 <20260609172514.2037645-6-peterx@redhat.com>
Content-Language: en-US
From: Mark Cave-Ayland <mark.caveayland@nutanix.com>
In-Reply-To: <20260609172514.2037645-6-peterx@redhat.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: CYXPR03CA0038.namprd03.prod.outlook.com
 (2603:10b6:930:d2::23) To PH0PR02MB7159.namprd02.prod.outlook.com
 (2603:10b6:510:16::8)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH0PR02MB7159:EE_|CH0PR02MB8117:EE_
X-MS-Office365-Filtering-Correlation-Id: 7c658c89-e460-4388-bde1-08dec7b8a743
x-proofpoint-crosstenant: true
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|1800799024|23010399003|376014|7416014|366016|4143699003|18002099003|22082099003|56012099006;
X-Microsoft-Antispam-Message-Info: v46W1Gfu0XXw9vkV08szaja9Iwb4TLf3RqvqmViWyFcpPmExPqY+uig0pvH5AJdhRzzYamRKn6DH72O9rOosJCV5fePY0TwbSMAJLNuv1rtlsP7GSIcYccfi4ifsYzGl0MCYu5W5hYj6b2XWtL5eBVIxhmtjjA91+liVY7eEOLGMUuc+UMjS44OASLfGEQP0mCZpuBYztZj13lRwC2kcS8aewVIdcNVH1EbeLBRbmJ9ppbbHvblpTjjP6iDrj+o82VFMZJYpfz6p83MLxFIS2E+s4NwDKZ5E4zF4p+1VTZkeyVqaM4/TUZsrCpIdHl8BVL+CnqfNnbw2fjrxXt6tFSbZxfn7wvSH6QwLtwSnKOY4bzo0DFuQkseKF6NSCPPBRQm74pXer6EINTbhiyWG3i7YCe/cUOBJpWJuc4yd2mtrmG3oTKpennwuT87Fcrq+HzlLGrKJ6uDq0Zx4vNueciNNHJgYZYBzTacPgVHPvmWwDY7PKdEcPrDM95KeZxzpRtQceWM4hOVL3/zBR59jZ8bd8AdO3khSXx1JhFi2mOP6TeW9b+ekuJeEaFiL9baGR8jIxrdxwsAFa/YLmGr3vYq89ee9RZsOVmoWtDbLhT4gS+5igVJPGIg6vLLWZ246YK/KH8PlWKd3htg9Bl8eetZWAt1TGaWzcg3bcJ4fvKyvnDpx8vvVuIspmgTxW7Sl
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:PH0PR02MB7159.namprd02.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(1800799024)(23010399003)(376014)(7416014)(366016)(4143699003)(18002099003)(22082099003)(56012099006);
 DIR:OUT; SFP:1102; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?WUM2VXJjR3F6dnFlN2RQdEhiZ240R0hCdWdvQWZrQUxCWDN1NklnK0lydzcw?=
 =?utf-8?B?cWJKRlBUbG8vZkZvRng5RWhkR3RvTTNOaDZtODBFdm1lS1BMY2JwQmNnWTls?=
 =?utf-8?B?dmNlQmZwQjN3UWFnaHFiaHdobHlXNnRFMEhsQkFnOTNWVUVmWDRMS0hmMklm?=
 =?utf-8?B?VlEyNUgvdmRPRFJmZ0VvalFPRnRNZjBRZnNYRWZmalRTU3JGOVY4bXU4NFlF?=
 =?utf-8?B?WnhoM2dKL2w2TFNXSkNtVEF1VG1QalNEY3N0R25aZDZob1o3Si9YdktCZXJL?=
 =?utf-8?B?MU5xU3VwVE9JZzAvL252LzhCV3VVbFJEOVdjalJCYWRFdXBXZVVQWm5wdUlu?=
 =?utf-8?B?V01SU1lNTGROdFBJblByUGxuM3FyNE9rbTFpbWVzNTBCTUJOSngvSURIWlI0?=
 =?utf-8?B?ZG4xSDAva0ZCdUFhWXE5aVVCdHpySjhDV0dkSmhpRDgyTGR6NXFpWUR0WnJ4?=
 =?utf-8?B?L3I5bW45NDl0ZjVJUU9rRmVQQVRZcjJuTmdXSFdyQnB5ck5wVjRGWFJGL2hW?=
 =?utf-8?B?L0RjRWZzckhob0ZPTU5EbnRMWHRqS1RyaWVOZUZRSmZ3WngwWHh4QVdmdFlx?=
 =?utf-8?B?T3lqQVdGemVneEcrT2FqZENOVnFGNzhoVXErS09XVFFIbmVtWVRVOVQ3bFlN?=
 =?utf-8?B?MGZhaEx6UExtZ2VORjhzN3Z6S09PakFteWpzOFo0MGhrUnpkZmtrc29ydThj?=
 =?utf-8?B?cllDUytlWHVCb09CdFc0QmswU3V3MEVCSDF5eCtKNWp1YTZpU3FIQVhFOGdZ?=
 =?utf-8?B?V2tJWTMzUWRaVWhTa1hpUDhoUm1CVGhIVnJsTG1hY2xnZ2Jvcm14c1VnblRk?=
 =?utf-8?B?Z1krSzJ2UlFjTVRTUTI4RVEraHorUThWYkxWK1lLYUxwa2NvbHZreFh3NWs2?=
 =?utf-8?B?ek9ZQ3h0QjdUTkJnZmN6ekcwNkhnRFBkVjNtNnpFRmdOdnVRTFdzQ096QnRt?=
 =?utf-8?B?VXFuL2FVa0pSOEZGdHJUdFc4ZVc2eFIyUTY0Q2tDeXRxWW5Ra1N5V1QxYkcw?=
 =?utf-8?B?TXoyRlgxQVlya0R4cHlyU0R0NFJOSktZRU1JenBQSUV1ZXZmbjVHRkhoV3A2?=
 =?utf-8?B?eVZKNitET3Q3MkE3YVpGdFhQMVNKdlpOZVA1NiswcmRmZHlOeVFRclNUUHh4?=
 =?utf-8?B?Z0xlWm84V2Zvc0dBMm84N1BHcVU2Q0JjbTV4b3lPc1AxQ0Z3QTY4aGo3aUc0?=
 =?utf-8?B?VGtvcTcrNjJkKzUvakFaZHk1aDFyZkRwN3pPUUE3MWlhUGY3alJXRW5qdzhq?=
 =?utf-8?B?V3NjN21CeHFYZlNSNmlINDBCR29DdDZHNWtnUGRvOHBBTjRjVHljZXdNejJF?=
 =?utf-8?B?enBxZy9kTktJdUpMSFdWYUFxNFQ0aHE2eTlkSk5FeEtpMnVLblNwQ0I5OVFp?=
 =?utf-8?B?TVhsVzh5bzJCS25mVEtqVGdKTUU5YnFvRDdFYU1sek0wa1hlRXV2R2htQktV?=
 =?utf-8?B?aDBRRFphK0ovYklaMno2TVZrV01jd0lIcmNCVW8yRmtNK0JJdG1MMWtFOGNj?=
 =?utf-8?B?SXFwQ3FxMENVY0FaSEg5aG5mNldUUWMwVlZZRmdtRzRQQ2c5ek1PckRKWUVU?=
 =?utf-8?B?T2tnV29YYlhKZVZUbGlRWlRGbFZvT3IzamdUUGlPa2h1K05HRVYwTHpmZ1pY?=
 =?utf-8?B?OWgzeUVRTkZyZWY0UUMzY2hCTHJqclgyWHBsV0lINFJXOFlRZzQwNWcxem5I?=
 =?utf-8?B?d0xsVEhsb3Z3WGtYUisxcFV3Ym9Ma01tb0duTFFkOWs3bEQzZkkwMGJwZ01S?=
 =?utf-8?B?RDN6RFR4aWZWMytYZ0svYnVtVzc0UVZUQ1BmWjRnOEdFWEFpSVN2ancxSXpR?=
 =?utf-8?B?TWFhdWNJSFI2RUN6bEYvU1Z1c2NlTVlFWWdIWmUvVWIxeTBFR2JpRWY4UHYy?=
 =?utf-8?B?dDNCN1gyMUZveGdJZDRhSEgxK2w5TnFtL1BuNFpJZzUrVHI0THUvaENYWFll?=
 =?utf-8?B?YlpSaE4zNzFLMHhDb1NFbjNsZFFFelo4VUFmc2NWY3lGQlYvNWE3Zmd3c29C?=
 =?utf-8?B?QkVyMWt6b1l6dHdjVmlGdmhVTjlPdElhVXlEbGVwQUF2YzNQc2QycldIS0Er?=
 =?utf-8?B?MEZrS2RHZ1k4Y1B1aFFWTVhPVkcyTHFKVXVtSXZ0cXJkRWxsc0ZrUGxRKzJw?=
 =?utf-8?B?YXV2WFlZdUtmQ0dhUnZhREU0aFNBM0hkcHhnaGR4L20vdzRDVXFuLzV4emVH?=
 =?utf-8?B?eTYzVHdGRXlnT3RZbGoyU0pmUEFlUHFZczVqZDdaS09OZjZYN1V6c2p0ejJI?=
 =?utf-8?B?eXpueUI2bnhySFhzaGFZVXpUem1DQUpQS0ZRR3pWVWlJRGJBZzkyRThoNk8x?=
 =?utf-8?B?ak5RYklKQ0JiSmJCL1VDNWswUGVKeTVQRWlUSzlxc0VFVm9XOU9pbDNHQW5l?=
 =?utf-8?Q?tif9vNttHbEKwggU=3D?=
X-Exchange-RoutingPolicyChecked: TfS7C9Of/AxYVGaX+bhZoPMtJo+PlwO/+CUNTLF6695697px0KhMj48OSb5gXYczUvlyAGse4KAbMIPdSYokZbXHpE4FoB6YyUZ4DvEmAbKUhjMNub4jhwYYc4DgchneQVOzwO2xcvpv8ABWwF86K0c8RnmEZj5xnNcsihYpoWpSUASxTFVbqbdEs1CqMxpuOOM/5piGar55t8uzgH/+csTvOlVZm3YfvVCrYvkoAjfyH+BsvOVuO/ac1/2efXyJsL3d19A3ovCHlqhAB9OfYPcFI925LbZ/MSpZtHM641xibRj98pEXrKo5Z9A4X6vkK1HEosaMaYeeB7WMk9XYZA==
X-OriginatorOrg: nutanix.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 7c658c89-e460-4388-bde1-08dec7b8a743
X-MS-Exchange-CrossTenant-AuthSource: PH0PR02MB7159.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 11 Jun 2026 12:55:03.0083 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: bb047546-786f-4de1-bd75-24e5b6f79043
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: KoarzEt8ttgiz6QLRsvzkLY6XlgYje7WR1EgVjStp5m+qEr5Uuhn/yiEXxsXttjKpnY4WIL6RVB7aQnFQqvTXXNNxFDH6juXNJmwNKjxLeo=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH0PR02MB8117
X-Proofpoint-ORIG-GUID: Qbas6PplV7ZSIHXNoBMhsUQDP6gjHT8c
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNjExMDEyOCBTYWx0ZWRfX8GBNKUv6hVlK
 Wr3J6nktppSYPBN1wPUWKtmlEzV64Vg8gEvG7MHSH3btMAA+nUuWAg67/3wq8rh2oXGGJ9jplYT
 kq73W+Vt4mCUZawKtAJZzoe0PQPgGyFAtXPyWvhu1d9f6n04BjJLDTHgFpvDjpTv5V1k1/YjCS+
 xZC7NtiBVuEADTqjGB9zRU5XkvyVMPcY3zvE09tWFokno0FMmIKCwIM9WgAY+npl5gcn/xGSKnP
 +SzckFrrp4G3T6flFKkEv5+u4D5ErXRPdNIhgIVQRh+N1O1n6zrXlmKmHg8OCLlYjtDQt+qemxw
 E9zV2us1ABGEXpTju9qAJPibipKCKgI25um7QPRno1if+jH9xhfRNWedOpnpj/JWpR4e0yfWHMq
 X+TL1wtZP20NvF6SV/ptn9zHbqTv/pOZKqJVd9waTQTbc3vd9IEbK4H6/ZqEG/JRqGooMKw+ymM
 d26/EFc/o1Lh09+/hUQ==
X-Authority-Analysis: v=2.4 cv=cbjiaHDM c=1 sm=1 tr=0 ts=6a2ab029 cx=c_pps
 a=s+5vLJ1poW1T9bNDw6yRNw==:117 a=6eWqkTHjU83fiwn7nKZWdM+Sl24=:19
 a=z/mQ4Ysz8XfWz/Q5cLBRGdckG28=:19 a=lCpzRmAYbLLaTzLvsPZ7Mbvzbb8=:19
 a=xqWC_Br6kY4A:10 a=IkcTkHD0fZMA:10 a=FelO9ux0wxsA:10 a=0kUYKlekyDsA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=VofLwUrZ8Iiv6rRUPXIb:22 a=_-M8LpHI31CeLmyZm6wg:22
 a=20KFwNOVAAAA:8 a=64Cc0HZtAAAA:8 a=b4TJ3ItIlFcYYt3xdSkA:9 a=QEXdDO2ut3YA:10
X-Proofpoint-Spam-Info: AW1haW4tMjYwNjExMDEyOCBTYWx0ZWRfXzkuiNGNOCDX1
 iUvTARuk3pHDris4gLAMfZJTDkABbXgsclolGXi9EQv+bPanTBxZhyOj64bhWiO/KA4ElyniD0k
 zmjqORkZOhwfuCL3dc0InRD8Of/H/w8=
X-Proofpoint-GUID: Qbas6PplV7ZSIHXNoBMhsUQDP6gjHT8c
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.125,FMLib:17.12.100.49
 definitions=2026-06-11_02,2026-06-11_01,2025-10-01_01
X-Proofpoint-Spam-Reason: safe
Received-SPF: pass client-ip=148.163.151.68;
 envelope-from=mark.caveayland@nutanix.com; helo=mx0a-002c1b01.pphosted.com
X-Spam_score_int: -31
X-Spam_score: -3.2
X-Spam_bar: ---
X-Spam_report: (-3.2 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.445,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_LOW=-0.7, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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

On 09/06/2026 18:25, Peter Xu wrote:

> Create object-property-ptr.[ch] files to include all the helpers for
> object_property_add*_ptr().
> 
> These set of helpers are handy because they look extremely familiar with
> qdev-properties, allowing the caller to provide a pointer and it will
> manage all the setters and getters.
> 
> The follow up patches may introduce more of such helpers.  Since object.c
> has been already too big, split that part out.
> 
> No functional change intended.
> 
> Signed-off-by: Peter Xu <peterx@redhat.com>
> ---
>   include/qom/object-property-ptr.h | 103 +++++++++++++
>   include/qom/object.h              |  99 +-----------
>   qom/object-property-ptr.c         | 248 ++++++++++++++++++++++++++++++
>   qom/object.c                      | 240 -----------------------------
>   qom/meson.build                   |   1 +
>   5 files changed, 358 insertions(+), 333 deletions(-)
>   create mode 100644 include/qom/object-property-ptr.h
>   create mode 100644 qom/object-property-ptr.c
> 
> diff --git a/include/qom/object-property-ptr.h b/include/qom/object-property-ptr.h
> new file mode 100644
> index 0000000000..6066c377fb
> --- /dev/null
> +++ b/include/qom/object-property-ptr.h
> @@ -0,0 +1,103 @@
> +/*
> + * Object property helpers to operate on a pointer.
> + *
> + * SPDX-License-Identifier: GPL-2.0-or-later
> + */
> +
> +#ifndef QEMU_OBJECT_PROPERTY_PTR_H
> +#define QEMU_OBJECT_PROPERTY_PTR_H
> +
> +typedef enum {
> +    /* Automatically add a getter to the property */
> +    OBJ_PROP_FLAG_READ = 1 << 0,
> +    /* Automatically add a setter to the property */
> +    OBJ_PROP_FLAG_WRITE = 1 << 1,
> +    /* Automatically add a getter and a setter to the property */
> +    OBJ_PROP_FLAG_READWRITE = (OBJ_PROP_FLAG_READ | OBJ_PROP_FLAG_WRITE),
> +} ObjectPropertyFlags;
> +
> +/**
> + * object_property_add_uint8_ptr:
> + * @obj: the object to add a property to
> + * @name: the name of the property
> + * @v: pointer to value
> + * @flags: bitwise-or'd ObjectPropertyFlags
> + *
> + * Add an integer property in memory.  This function will add a
> + * property of type 'uint8'.
> + *
> + * Returns: The newly added property on success, or %NULL on failure.
> + */
> +ObjectProperty *object_property_add_uint8_ptr(Object *obj, const char *name,
> +                                              const uint8_t *v,
> +                                              ObjectPropertyFlags flags);
> +
> +ObjectProperty *object_class_property_add_uint8_ptr(ObjectClass *klass,
> +                                         const char *name,
> +                                         const uint8_t *v,
> +                                         ObjectPropertyFlags flags);
> +
> +/**
> + * object_property_add_uint16_ptr:
> + * @obj: the object to add a property to
> + * @name: the name of the property
> + * @v: pointer to value
> + * @flags: bitwise-or'd ObjectPropertyFlags
> + *
> + * Add an integer property in memory.  This function will add a
> + * property of type 'uint16'.
> + *
> + * Returns: The newly added property on success, or %NULL on failure.
> + */
> +ObjectProperty *object_property_add_uint16_ptr(Object *obj, const char *name,
> +                                    const uint16_t *v,
> +                                    ObjectPropertyFlags flags);
> +
> +ObjectProperty *object_class_property_add_uint16_ptr(ObjectClass *klass,
> +                                          const char *name,
> +                                          const uint16_t *v,
> +                                          ObjectPropertyFlags flags);
> +
> +/**
> + * object_property_add_uint32_ptr:
> + * @obj: the object to add a property to
> + * @name: the name of the property
> + * @v: pointer to value
> + * @flags: bitwise-or'd ObjectPropertyFlags
> + *
> + * Add an integer property in memory.  This function will add a
> + * property of type 'uint32'.
> + *
> + * Returns: The newly added property on success, or %NULL on failure.
> + */
> +ObjectProperty *object_property_add_uint32_ptr(Object *obj, const char *name,
> +                                    const uint32_t *v,
> +                                    ObjectPropertyFlags flags);
> +
> +ObjectProperty *object_class_property_add_uint32_ptr(ObjectClass *klass,
> +                                          const char *name,
> +                                          const uint32_t *v,
> +                                          ObjectPropertyFlags flags);
> +
> +/**
> + * object_property_add_uint64_ptr:
> + * @obj: the object to add a property to
> + * @name: the name of the property
> + * @v: pointer to value
> + * @flags: bitwise-or'd ObjectPropertyFlags
> + *
> + * Add an integer property in memory.  This function will add a
> + * property of type 'uint64'.
> + *
> + * Returns: The newly added property on success, or %NULL on failure.
> + */
> +ObjectProperty *object_property_add_uint64_ptr(Object *obj, const char *name,
> +                                    const uint64_t *v,
> +                                    ObjectPropertyFlags flags);
> +
> +ObjectProperty *object_class_property_add_uint64_ptr(ObjectClass *klass,
> +                                          const char *name,
> +                                          const uint64_t *v,
> +                                          ObjectPropertyFlags flags);
> +
> +#endif
> diff --git a/include/qom/object.h b/include/qom/object.h
> index 11f55613fc..6ea569d580 100644
> --- a/include/qom/object.h
> +++ b/include/qom/object.h
> @@ -1931,99 +1931,6 @@ ObjectProperty *object_class_property_add_tm(ObjectClass *klass,
>                               const char *name,
>                               void (*get)(Object *, struct tm *, Error **));
>   
> -typedef enum {
> -    /* Automatically add a getter to the property */
> -    OBJ_PROP_FLAG_READ = 1 << 0,
> -    /* Automatically add a setter to the property */
> -    OBJ_PROP_FLAG_WRITE = 1 << 1,
> -    /* Automatically add a getter and a setter to the property */
> -    OBJ_PROP_FLAG_READWRITE = (OBJ_PROP_FLAG_READ | OBJ_PROP_FLAG_WRITE),
> -} ObjectPropertyFlags;
> -
> -/**
> - * object_property_add_uint8_ptr:
> - * @obj: the object to add a property to
> - * @name: the name of the property
> - * @v: pointer to value
> - * @flags: bitwise-or'd ObjectPropertyFlags
> - *
> - * Add an integer property in memory.  This function will add a
> - * property of type 'uint8'.
> - *
> - * Returns: The newly added property on success, or %NULL on failure.
> - */
> -ObjectProperty *object_property_add_uint8_ptr(Object *obj, const char *name,
> -                                              const uint8_t *v,
> -                                              ObjectPropertyFlags flags);
> -
> -ObjectProperty *object_class_property_add_uint8_ptr(ObjectClass *klass,
> -                                         const char *name,
> -                                         const uint8_t *v,
> -                                         ObjectPropertyFlags flags);
> -
> -/**
> - * object_property_add_uint16_ptr:
> - * @obj: the object to add a property to
> - * @name: the name of the property
> - * @v: pointer to value
> - * @flags: bitwise-or'd ObjectPropertyFlags
> - *
> - * Add an integer property in memory.  This function will add a
> - * property of type 'uint16'.
> - *
> - * Returns: The newly added property on success, or %NULL on failure.
> - */
> -ObjectProperty *object_property_add_uint16_ptr(Object *obj, const char *name,
> -                                    const uint16_t *v,
> -                                    ObjectPropertyFlags flags);
> -
> -ObjectProperty *object_class_property_add_uint16_ptr(ObjectClass *klass,
> -                                          const char *name,
> -                                          const uint16_t *v,
> -                                          ObjectPropertyFlags flags);
> -
> -/**
> - * object_property_add_uint32_ptr:
> - * @obj: the object to add a property to
> - * @name: the name of the property
> - * @v: pointer to value
> - * @flags: bitwise-or'd ObjectPropertyFlags
> - *
> - * Add an integer property in memory.  This function will add a
> - * property of type 'uint32'.
> - *
> - * Returns: The newly added property on success, or %NULL on failure.
> - */
> -ObjectProperty *object_property_add_uint32_ptr(Object *obj, const char *name,
> -                                    const uint32_t *v,
> -                                    ObjectPropertyFlags flags);
> -
> -ObjectProperty *object_class_property_add_uint32_ptr(ObjectClass *klass,
> -                                          const char *name,
> -                                          const uint32_t *v,
> -                                          ObjectPropertyFlags flags);
> -
> -/**
> - * object_property_add_uint64_ptr:
> - * @obj: the object to add a property to
> - * @name: the name of the property
> - * @v: pointer to value
> - * @flags: bitwise-or'd ObjectPropertyFlags
> - *
> - * Add an integer property in memory.  This function will add a
> - * property of type 'uint64'.
> - *
> - * Returns: The newly added property on success, or %NULL on failure.
> - */
> -ObjectProperty *object_property_add_uint64_ptr(Object *obj, const char *name,
> -                                    const uint64_t *v,
> -                                    ObjectPropertyFlags flags);
> -
> -ObjectProperty *object_class_property_add_uint64_ptr(ObjectClass *klass,
> -                                          const char *name,
> -                                          const uint64_t *v,
> -                                          ObjectPropertyFlags flags);
> -
>   /**
>    * object_property_add_alias:
>    * @obj: the object to add a property to
> @@ -2141,4 +2048,10 @@ char *object_property_help(const char *name, const char *type,
>   
>   G_DEFINE_AUTOPTR_CLEANUP_FUNC(Object, object_unref)
>   
> +/*
> + * Object property ptr helpers cannot be included at the beginning of the
> + * file, because it depends on QOM definitions in current header.
> + */
> +#include "qom/object-property-ptr.h"

I wonder if possibly we might want to let the caller include the extra 
header? But I don't feel too strongly either way.

>   #endif
> diff --git a/qom/object-property-ptr.c b/qom/object-property-ptr.c
> new file mode 100644
> index 0000000000..02c01ed7f0
> --- /dev/null
> +++ b/qom/object-property-ptr.c
> @@ -0,0 +1,248 @@
> +/*
> + * Object property helpers to operate on a pointer.
> + *
> + * SPDX-License-Identifier: GPL-2.0-or-later
> + */
> +#include "qemu/osdep.h"
> +#include "qom/object.h"
> +#include "qapi/visitor.h"
> +
> +static void property_get_uint8_ptr(Object *obj, Visitor *v, const char *name,
> +                                   void *opaque, Error **errp)
> +{
> +    uint8_t value = *(uint8_t *)opaque;
> +    visit_type_uint8(v, name, &value, errp);
> +}
> +
> +static void property_set_uint8_ptr(Object *obj, Visitor *v, const char *name,
> +                                   void *opaque, Error **errp)
> +{
> +    uint8_t *field = opaque;
> +    uint8_t value;
> +
> +    if (!visit_type_uint8(v, name, &value, errp)) {
> +        return;
> +    }
> +
> +    *field = value;
> +}
> +
> +static void property_get_uint16_ptr(Object *obj, Visitor *v, const char *name,
> +                                    void *opaque, Error **errp)
> +{
> +    uint16_t value = *(uint16_t *)opaque;
> +    visit_type_uint16(v, name, &value, errp);
> +}
> +
> +static void property_set_uint16_ptr(Object *obj, Visitor *v, const char *name,
> +                                    void *opaque, Error **errp)
> +{
> +    uint16_t *field = opaque;
> +    uint16_t value;
> +
> +    if (!visit_type_uint16(v, name, &value, errp)) {
> +        return;
> +    }
> +
> +    *field = value;
> +}
> +
> +static void property_get_uint32_ptr(Object *obj, Visitor *v, const char *name,
> +                                    void *opaque, Error **errp)
> +{
> +    uint32_t value = *(uint32_t *)opaque;
> +    visit_type_uint32(v, name, &value, errp);
> +}
> +
> +static void property_set_uint32_ptr(Object *obj, Visitor *v, const char *name,
> +                                    void *opaque, Error **errp)
> +{
> +    uint32_t *field = opaque;
> +    uint32_t value;
> +
> +    if (!visit_type_uint32(v, name, &value, errp)) {
> +        return;
> +    }
> +
> +    *field = value;
> +}
> +
> +static void property_get_uint64_ptr(Object *obj, Visitor *v, const char *name,
> +                                    void *opaque, Error **errp)
> +{
> +    uint64_t value = *(uint64_t *)opaque;
> +    visit_type_uint64(v, name, &value, errp);
> +}
> +
> +static void property_set_uint64_ptr(Object *obj, Visitor *v, const char *name,
> +                                    void *opaque, Error **errp)
> +{
> +    uint64_t *field = opaque;
> +    uint64_t value;
> +
> +    if (!visit_type_uint64(v, name, &value, errp)) {
> +        return;
> +    }
> +
> +    *field = value;
> +}
> +
> +ObjectProperty *
> +object_property_add_uint8_ptr(Object *obj, const char *name,
> +                              const uint8_t *v,
> +                              ObjectPropertyFlags flags)
> +{
> +    ObjectPropertyAccessor *getter = NULL;
> +    ObjectPropertyAccessor *setter = NULL;
> +
> +    if ((flags & OBJ_PROP_FLAG_READ) == OBJ_PROP_FLAG_READ) {
> +        getter = property_get_uint8_ptr;
> +    }
> +
> +    if ((flags & OBJ_PROP_FLAG_WRITE) == OBJ_PROP_FLAG_WRITE) {
> +        setter = property_set_uint8_ptr;
> +    }
> +
> +    return object_property_add(obj, name, "uint8",
> +                               getter, setter, NULL, (void *)v);
> +}
> +
> +ObjectProperty *
> +object_class_property_add_uint8_ptr(ObjectClass *klass, const char *name,
> +                                    const uint8_t *v,
> +                                    ObjectPropertyFlags flags)
> +{
> +    ObjectPropertyAccessor *getter = NULL;
> +    ObjectPropertyAccessor *setter = NULL;
> +
> +    if ((flags & OBJ_PROP_FLAG_READ) == OBJ_PROP_FLAG_READ) {
> +        getter = property_get_uint8_ptr;
> +    }
> +
> +    if ((flags & OBJ_PROP_FLAG_WRITE) == OBJ_PROP_FLAG_WRITE) {
> +        setter = property_set_uint8_ptr;
> +    }
> +
> +    return object_class_property_add(klass, name, "uint8",
> +                                     getter, setter, NULL, (void *)v);
> +}
> +
> +ObjectProperty *
> +object_property_add_uint16_ptr(Object *obj, const char *name,
> +                               const uint16_t *v,
> +                               ObjectPropertyFlags flags)
> +{
> +    ObjectPropertyAccessor *getter = NULL;
> +    ObjectPropertyAccessor *setter = NULL;
> +
> +    if ((flags & OBJ_PROP_FLAG_READ) == OBJ_PROP_FLAG_READ) {
> +        getter = property_get_uint16_ptr;
> +    }
> +
> +    if ((flags & OBJ_PROP_FLAG_WRITE) == OBJ_PROP_FLAG_WRITE) {
> +        setter = property_set_uint16_ptr;
> +    }
> +
> +    return object_property_add(obj, name, "uint16",
> +                               getter, setter, NULL, (void *)v);
> +}
> +
> +ObjectProperty *
> +object_class_property_add_uint16_ptr(ObjectClass *klass, const char *name,
> +                                     const uint16_t *v,
> +                                     ObjectPropertyFlags flags)
> +{
> +    ObjectPropertyAccessor *getter = NULL;
> +    ObjectPropertyAccessor *setter = NULL;
> +
> +    if ((flags & OBJ_PROP_FLAG_READ) == OBJ_PROP_FLAG_READ) {
> +        getter = property_get_uint16_ptr;
> +    }
> +
> +    if ((flags & OBJ_PROP_FLAG_WRITE) == OBJ_PROP_FLAG_WRITE) {
> +        setter = property_set_uint16_ptr;
> +    }
> +
> +    return object_class_property_add(klass, name, "uint16",
> +                                     getter, setter, NULL, (void *)v);
> +}
> +
> +ObjectProperty *
> +object_property_add_uint32_ptr(Object *obj, const char *name,
> +                               const uint32_t *v,
> +                               ObjectPropertyFlags flags)
> +{
> +    ObjectPropertyAccessor *getter = NULL;
> +    ObjectPropertyAccessor *setter = NULL;
> +
> +    if ((flags & OBJ_PROP_FLAG_READ) == OBJ_PROP_FLAG_READ) {
> +        getter = property_get_uint32_ptr;
> +    }
> +
> +    if ((flags & OBJ_PROP_FLAG_WRITE) == OBJ_PROP_FLAG_WRITE) {
> +        setter = property_set_uint32_ptr;
> +    }
> +
> +    return object_property_add(obj, name, "uint32",
> +                               getter, setter, NULL, (void *)v);
> +}
> +
> +ObjectProperty *
> +object_class_property_add_uint32_ptr(ObjectClass *klass, const char *name,
> +                                     const uint32_t *v,
> +                                     ObjectPropertyFlags flags)
> +{
> +    ObjectPropertyAccessor *getter = NULL;
> +    ObjectPropertyAccessor *setter = NULL;
> +
> +    if ((flags & OBJ_PROP_FLAG_READ) == OBJ_PROP_FLAG_READ) {
> +        getter = property_get_uint32_ptr;
> +    }
> +
> +    if ((flags & OBJ_PROP_FLAG_WRITE) == OBJ_PROP_FLAG_WRITE) {
> +        setter = property_set_uint32_ptr;
> +    }
> +
> +    return object_class_property_add(klass, name, "uint32",
> +                                     getter, setter, NULL, (void *)v);
> +}
> +
> +ObjectProperty *
> +object_property_add_uint64_ptr(Object *obj, const char *name,
> +                               const uint64_t *v,
> +                               ObjectPropertyFlags flags)
> +{
> +    ObjectPropertyAccessor *getter = NULL;
> +    ObjectPropertyAccessor *setter = NULL;
> +
> +    if ((flags & OBJ_PROP_FLAG_READ) == OBJ_PROP_FLAG_READ) {
> +        getter = property_get_uint64_ptr;
> +    }
> +
> +    if ((flags & OBJ_PROP_FLAG_WRITE) == OBJ_PROP_FLAG_WRITE) {
> +        setter = property_set_uint64_ptr;
> +    }
> +
> +    return object_property_add(obj, name, "uint64",
> +                               getter, setter, NULL, (void *)v);
> +}
> +
> +ObjectProperty *
> +object_class_property_add_uint64_ptr(ObjectClass *klass, const char *name,
> +                                     const uint64_t *v,
> +                                     ObjectPropertyFlags flags)
> +{
> +    ObjectPropertyAccessor *getter = NULL;
> +    ObjectPropertyAccessor *setter = NULL;
> +
> +    if ((flags & OBJ_PROP_FLAG_READ) == OBJ_PROP_FLAG_READ) {
> +        getter = property_get_uint64_ptr;
> +    }
> +
> +    if ((flags & OBJ_PROP_FLAG_WRITE) == OBJ_PROP_FLAG_WRITE) {
> +        setter = property_set_uint64_ptr;
> +    }
> +
> +    return object_class_property_add(klass, name, "uint64",
> +                                     getter, setter, NULL, (void *)v);
> +}
> diff --git a/qom/object.c b/qom/object.c
> index 0ac201de4c..fc738549dc 100644
> --- a/qom/object.c
> +++ b/qom/object.c
> @@ -2673,246 +2673,6 @@ static char *object_get_type(Object *obj, Error **errp)
>       return g_strdup(object_get_typename(obj));
>   }
>   
> -static void property_get_uint8_ptr(Object *obj, Visitor *v, const char *name,
> -                                   void *opaque, Error **errp)
> -{
> -    uint8_t value = *(uint8_t *)opaque;
> -    visit_type_uint8(v, name, &value, errp);
> -}
> -
> -static void property_set_uint8_ptr(Object *obj, Visitor *v, const char *name,
> -                                   void *opaque, Error **errp)
> -{
> -    uint8_t *field = opaque;
> -    uint8_t value;
> -
> -    if (!visit_type_uint8(v, name, &value, errp)) {
> -        return;
> -    }
> -
> -    *field = value;
> -}
> -
> -static void property_get_uint16_ptr(Object *obj, Visitor *v, const char *name,
> -                                    void *opaque, Error **errp)
> -{
> -    uint16_t value = *(uint16_t *)opaque;
> -    visit_type_uint16(v, name, &value, errp);
> -}
> -
> -static void property_set_uint16_ptr(Object *obj, Visitor *v, const char *name,
> -                                    void *opaque, Error **errp)
> -{
> -    uint16_t *field = opaque;
> -    uint16_t value;
> -
> -    if (!visit_type_uint16(v, name, &value, errp)) {
> -        return;
> -    }
> -
> -    *field = value;
> -}
> -
> -static void property_get_uint32_ptr(Object *obj, Visitor *v, const char *name,
> -                                    void *opaque, Error **errp)
> -{
> -    uint32_t value = *(uint32_t *)opaque;
> -    visit_type_uint32(v, name, &value, errp);
> -}
> -
> -static void property_set_uint32_ptr(Object *obj, Visitor *v, const char *name,
> -                                    void *opaque, Error **errp)
> -{
> -    uint32_t *field = opaque;
> -    uint32_t value;
> -
> -    if (!visit_type_uint32(v, name, &value, errp)) {
> -        return;
> -    }
> -
> -    *field = value;
> -}
> -
> -static void property_get_uint64_ptr(Object *obj, Visitor *v, const char *name,
> -                                    void *opaque, Error **errp)
> -{
> -    uint64_t value = *(uint64_t *)opaque;
> -    visit_type_uint64(v, name, &value, errp);
> -}
> -
> -static void property_set_uint64_ptr(Object *obj, Visitor *v, const char *name,
> -                                    void *opaque, Error **errp)
> -{
> -    uint64_t *field = opaque;
> -    uint64_t value;
> -
> -    if (!visit_type_uint64(v, name, &value, errp)) {
> -        return;
> -    }
> -
> -    *field = value;
> -}
> -
> -ObjectProperty *
> -object_property_add_uint8_ptr(Object *obj, const char *name,
> -                              const uint8_t *v,
> -                              ObjectPropertyFlags flags)
> -{
> -    ObjectPropertyAccessor *getter = NULL;
> -    ObjectPropertyAccessor *setter = NULL;
> -
> -    if ((flags & OBJ_PROP_FLAG_READ) == OBJ_PROP_FLAG_READ) {
> -        getter = property_get_uint8_ptr;
> -    }
> -
> -    if ((flags & OBJ_PROP_FLAG_WRITE) == OBJ_PROP_FLAG_WRITE) {
> -        setter = property_set_uint8_ptr;
> -    }
> -
> -    return object_property_add(obj, name, "uint8",
> -                               getter, setter, NULL, (void *)v);
> -}
> -
> -ObjectProperty *
> -object_class_property_add_uint8_ptr(ObjectClass *klass, const char *name,
> -                                    const uint8_t *v,
> -                                    ObjectPropertyFlags flags)
> -{
> -    ObjectPropertyAccessor *getter = NULL;
> -    ObjectPropertyAccessor *setter = NULL;
> -
> -    if ((flags & OBJ_PROP_FLAG_READ) == OBJ_PROP_FLAG_READ) {
> -        getter = property_get_uint8_ptr;
> -    }
> -
> -    if ((flags & OBJ_PROP_FLAG_WRITE) == OBJ_PROP_FLAG_WRITE) {
> -        setter = property_set_uint8_ptr;
> -    }
> -
> -    return object_class_property_add(klass, name, "uint8",
> -                                     getter, setter, NULL, (void *)v);
> -}
> -
> -ObjectProperty *
> -object_property_add_uint16_ptr(Object *obj, const char *name,
> -                               const uint16_t *v,
> -                               ObjectPropertyFlags flags)
> -{
> -    ObjectPropertyAccessor *getter = NULL;
> -    ObjectPropertyAccessor *setter = NULL;
> -
> -    if ((flags & OBJ_PROP_FLAG_READ) == OBJ_PROP_FLAG_READ) {
> -        getter = property_get_uint16_ptr;
> -    }
> -
> -    if ((flags & OBJ_PROP_FLAG_WRITE) == OBJ_PROP_FLAG_WRITE) {
> -        setter = property_set_uint16_ptr;
> -    }
> -
> -    return object_property_add(obj, name, "uint16",
> -                               getter, setter, NULL, (void *)v);
> -}
> -
> -ObjectProperty *
> -object_class_property_add_uint16_ptr(ObjectClass *klass, const char *name,
> -                                     const uint16_t *v,
> -                                     ObjectPropertyFlags flags)
> -{
> -    ObjectPropertyAccessor *getter = NULL;
> -    ObjectPropertyAccessor *setter = NULL;
> -
> -    if ((flags & OBJ_PROP_FLAG_READ) == OBJ_PROP_FLAG_READ) {
> -        getter = property_get_uint16_ptr;
> -    }
> -
> -    if ((flags & OBJ_PROP_FLAG_WRITE) == OBJ_PROP_FLAG_WRITE) {
> -        setter = property_set_uint16_ptr;
> -    }
> -
> -    return object_class_property_add(klass, name, "uint16",
> -                                     getter, setter, NULL, (void *)v);
> -}
> -
> -ObjectProperty *
> -object_property_add_uint32_ptr(Object *obj, const char *name,
> -                               const uint32_t *v,
> -                               ObjectPropertyFlags flags)
> -{
> -    ObjectPropertyAccessor *getter = NULL;
> -    ObjectPropertyAccessor *setter = NULL;
> -
> -    if ((flags & OBJ_PROP_FLAG_READ) == OBJ_PROP_FLAG_READ) {
> -        getter = property_get_uint32_ptr;
> -    }
> -
> -    if ((flags & OBJ_PROP_FLAG_WRITE) == OBJ_PROP_FLAG_WRITE) {
> -        setter = property_set_uint32_ptr;
> -    }
> -
> -    return object_property_add(obj, name, "uint32",
> -                               getter, setter, NULL, (void *)v);
> -}
> -
> -ObjectProperty *
> -object_class_property_add_uint32_ptr(ObjectClass *klass, const char *name,
> -                                     const uint32_t *v,
> -                                     ObjectPropertyFlags flags)
> -{
> -    ObjectPropertyAccessor *getter = NULL;
> -    ObjectPropertyAccessor *setter = NULL;
> -
> -    if ((flags & OBJ_PROP_FLAG_READ) == OBJ_PROP_FLAG_READ) {
> -        getter = property_get_uint32_ptr;
> -    }
> -
> -    if ((flags & OBJ_PROP_FLAG_WRITE) == OBJ_PROP_FLAG_WRITE) {
> -        setter = property_set_uint32_ptr;
> -    }
> -
> -    return object_class_property_add(klass, name, "uint32",
> -                                     getter, setter, NULL, (void *)v);
> -}
> -
> -ObjectProperty *
> -object_property_add_uint64_ptr(Object *obj, const char *name,
> -                               const uint64_t *v,
> -                               ObjectPropertyFlags flags)
> -{
> -    ObjectPropertyAccessor *getter = NULL;
> -    ObjectPropertyAccessor *setter = NULL;
> -
> -    if ((flags & OBJ_PROP_FLAG_READ) == OBJ_PROP_FLAG_READ) {
> -        getter = property_get_uint64_ptr;
> -    }
> -
> -    if ((flags & OBJ_PROP_FLAG_WRITE) == OBJ_PROP_FLAG_WRITE) {
> -        setter = property_set_uint64_ptr;
> -    }
> -
> -    return object_property_add(obj, name, "uint64",
> -                               getter, setter, NULL, (void *)v);
> -}
> -
> -ObjectProperty *
> -object_class_property_add_uint64_ptr(ObjectClass *klass, const char *name,
> -                                     const uint64_t *v,
> -                                     ObjectPropertyFlags flags)
> -{
> -    ObjectPropertyAccessor *getter = NULL;
> -    ObjectPropertyAccessor *setter = NULL;
> -
> -    if ((flags & OBJ_PROP_FLAG_READ) == OBJ_PROP_FLAG_READ) {
> -        getter = property_get_uint64_ptr;
> -    }
> -
> -    if ((flags & OBJ_PROP_FLAG_WRITE) == OBJ_PROP_FLAG_WRITE) {
> -        setter = property_set_uint64_ptr;
> -    }
> -
> -    return object_class_property_add(klass, name, "uint64",
> -                                     getter, setter, NULL, (void *)v);
> -}
> -
>   typedef struct {
>       Object *target_obj;
>       char *target_name;
> diff --git a/qom/meson.build b/qom/meson.build
> index bd6f4aadd7..2c746aaa9c 100644
> --- a/qom/meson.build
> +++ b/qom/meson.build
> @@ -3,6 +3,7 @@ qom_ss.add(files(
>     'container.c',
>     'object.c',
>     'object_interfaces.c',
> +  'object-property-ptr.c',
>     'qom-qobject.c',
>   ))
>   if have_system

Otherwise looks okay to me:

Reviewed-by: Mark Cave-Ayland <mark.caveayland@nutanix.com>


ATB,

Mark.


