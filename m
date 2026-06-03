Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8BE2ACD6E55
	for <qemu-devel@archiver.kernel.org>; Wed,  3 Jun 2026 15:42:33 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wUnjC-0005JB-E0; Wed, 03 Jun 2026 11:41:58 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mark.caveayland@nutanix.com>)
 id 1wUnj5-0005Iv-4t
 for qemu-devel@nongnu.org; Wed, 03 Jun 2026 11:41:51 -0400
Received: from mx0a-002c1b01.pphosted.com ([148.163.151.68])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mark.caveayland@nutanix.com>)
 id 1wUnix-0003T5-Ud
 for qemu-devel@nongnu.org; Wed, 03 Jun 2026 11:41:47 -0400
Received: from pps.filterd (m0127838.ppops.net [127.0.0.1])
 by mx0a-002c1b01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 653EGBf94090399; Wed, 3 Jun 2026 08:41:40 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nutanix.com; h=
 cc:content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=
 proofpoint20171006; bh=TK/dqjpfIDyECLfzmprkEQdFE/61Etv7qO+y7QISq
 30=; b=TlFb6addNBd0uzUR6Eij2q6yrUGyf7XS1ja2Cm5E4u6afmHrIhwoL5pv4
 D1v2z7qZxZg0esDxhWJDjcKmZi5G9dZfC1I3uugk2r1bkyussk8+cXmVlDeWOma1
 j4Qte3X0bJVpsP9cIAELuucdZxFxlCcT2l82KYWN5BH0gorMcZ7qmEHBSPe26yFf
 /narCemAPtW+VzGKnS5TMY+gGvHoMDQSEiLb2xzAxcSYndIDAVbAPEF1pNQ+pXro
 tKwbRdphtpz2mpZUxNVxEsqdy7kjk1kZ6ssETBHh7w9aYTce+nSpFCTJW9OgukAy
 9+d3thF81H/pNVwbFbOPnMI7LR1LQ==
Received: from ch5pr02cu005.outbound.protection.outlook.com
 (mail-northcentralusazon11022074.outbound.protection.outlook.com
 [40.107.200.74])
 by mx0a-002c1b01.pphosted.com (PPS) with ESMTPS id 4ej5a2age6-1
 (version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NOT);
 Wed, 03 Jun 2026 08:41:40 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=N6fB2sQML3uOFYTRFRiiLriH/nEBNtmLqTWjiMPIix0sGeAmMWXzqBk9mIvwowY4bN60aM1jbG85WoMenv9w4zGJiw/XOJFztRU7LF8ZuUTwz/MMIkYuMn8dQRrbQmcE0kW1dCFRgZP56i5Ycb0ob2SH7G8iLBcIHRit2n3dYMdsJ9D5iBIqNga14wZzYpQt3ukupwETnkeU6LkPRbS+8nqvCidUOg9ZFv3wHjNqhJR2lCoskwuvL4UHzBGRgv2LyWEn+HuCgXRxETEP7nqAYC0iRwHHjar5zEenC+6hcLQmyN7LCQAf9FHOQiNWAa5Fg9M+Ayt9zJKb5Dl+eqW7fg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=TK/dqjpfIDyECLfzmprkEQdFE/61Etv7qO+y7QISq30=;
 b=L7nSOkeYVpBynPXah4IjUD5CKM30AJUhCBbsZElvaPCwGjY1wt4xLRpSQSRFqiU02DbsQjw7+sr0b+K85JYoAu5gmtfB+BtNSaYhHiTObeVqAnCuP12is9SGGNFeZuNQQY0pDyxdt7wn4dmNdmI/FqDNOwJsMOonqo/1oYRX+NvwtyvZoQy+Y4anx+KDm7+RQZMgl0t4rSzViOaAG+M7n2Dw0G8f4l+q6tfDiMwTfsYyVZoyG/4WBECv//SyHt7m2KqsKIgsVH/2LPrGzxi2RbXtbfcKA/vpOIxTewoibFWorwiePiuQ1RMCxQydyZ5ry3t4QO9OoT3DnaoMD2n6gg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nutanix.com; dmarc=pass action=none header.from=nutanix.com;
 dkim=pass header.d=nutanix.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nutanix.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=TK/dqjpfIDyECLfzmprkEQdFE/61Etv7qO+y7QISq30=;
 b=jeMeUaExV+njp695Nucq8ttnhkZHZSgG2BnGkfo2M44g8mR+RAR7q1IBsvy7UH1JqKUAFBHVG+Ji9RHvlu6EYB692qwoMUoNwPhrYRf2RX+4tjN4f227LgRZ70TRCgiz+gCSb1BXUfGsTotL6rUCOZ1fKLkxZQYemMXmL7ZsE4g7ld3YHBGqzygRekRIyWaJBDbDI2f4b+XQv4b8tkyWU5GphpPYJYq5mYcLt3jGDKhMIZZKTw2c48foFbfa5qlrUnOZq8fYWaSVenkBzwh1pP/ylrqvbSqlB50ITmDWi+ydGiHyJf17hIHl+bQCt0mFYz8W9D/Ko3ABiu/S2LwMyg==
Received: from PH0PR02MB7159.namprd02.prod.outlook.com (2603:10b6:510:16::8)
 by DM6PR02MB6541.namprd02.prod.outlook.com (2603:10b6:5:20b::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.92.7; Wed, 3 Jun 2026
 15:41:37 +0000
Received: from PH0PR02MB7159.namprd02.prod.outlook.com
 ([fe80::8e97:bc32:822c:b250]) by PH0PR02MB7159.namprd02.prod.outlook.com
 ([fe80::8e97:bc32:822c:b250%3]) with mapi id 15.21.0092.006; Wed, 3 Jun 2026
 15:41:36 +0000
Message-ID: <283f85de-92b0-4c62-94ed-631221b62c07@nutanix.com>
Date: Wed, 3 Jun 2026 16:41:31 +0100
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH RFC 0/2] migration/vl: new -incoming config:* for early
 migration parameters
To: Peter Xu <peterx@redhat.com>, Fabiano Rosas <farosas@suse.de>
Cc: qemu-devel@nongnu.org, Paolo Bonzini <pbonzini@redhat.com>,
 Mark Kanda <mark.kanda@oracle.com>, "Michael S . Tsirkin" <mst@redhat.com>,
 Markus Armbruster <armbru@redhat.com>, Eric Blake <eblake@redhat.com>,
 "Maciej S. Szmigiero" <maciej.szmigiero@oracle.com>,
 Jason Wang <jasowang@redhat.com>, Ben Chaney <bchaney@akamai.com>,
 Vladimir Sementsov-Ogievskiy <vsementsov@yandex-team.ru>
References: <20260528212947.368132-1-peterx@redhat.com>
 <87se7btcq9.fsf@suse.de> <ahmfh2s7CLFLoZKN@x1.local>
Content-Language: en-US
From: Mark Cave-Ayland <mark.caveayland@nutanix.com>
In-Reply-To: <ahmfh2s7CLFLoZKN@x1.local>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: CY5PR15CA0062.namprd15.prod.outlook.com
 (2603:10b6:930:18::25) To PH0PR02MB7159.namprd02.prod.outlook.com
 (2603:10b6:510:16::8)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH0PR02MB7159:EE_|DM6PR02MB6541:EE_
X-MS-Office365-Filtering-Correlation-Id: c99fd295-e76d-476a-4848-08dec1869885
x-proofpoint-crosstenant: true
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|366016|376014|7416014|1800799024|18002099003|22082099003|4143699003|56012099006|3023799007|4133799003|6133799003;
X-Microsoft-Antispam-Message-Info: +b1ly/M83dtyfDUjljOe6AjEx9aOEugLKrrMuyv6tCu8EScEsQ9eA3drRYWMbhy1kj01+2PFHpbXL49Ts4btik4RPs0B0FNLcr+nKiio0yAT9JzdGS2YfwT0Ep36bgT8CjWRUH4Z6xWE7v44D8WZX+7k/MOW9s8uUNZoMMG4zdecWB4JrBbXVmC0zKj2xzECGIVWglI8PxylDbuyASVSj81MJvQzAjXDo7XNsacMEtIF/Qsu8nhfmPsd5KFKxyJRzGNP0iMfWnMyy40Yql8arjC1i8uU/sZJYh+VJFTgSoJLJ1uZ+FwcVgFny649zAR8fmnPZq6M4x8Pq7FiAtbPKSTr+5mjGyaS6YZauajPLCbHwjc6AS3+9E7rh92bRQh+3uee0whJfbwqB1ANMYOmeCWDWEaYvlvcesbCvvxOZ64DVuCa/F4tHgMCaVyRcF3TKcycBOR4WNibtqNDfmtSaKdd8EWC2tuheDi7EkGxxjDtLWTu2OEgTNUiNxskMkxPJbELaPn1kGRLBpoc+FsPeoYK3+0FZeyd+LhFg2QxSd25pec0hTIH5PHjLqZ0suHSl9c+n8QpUB/QmfyjqxgUlRkaz0mmhFfpAdxGaTbHMIBuHYn2ltP0LowyK8BZLRK65k9pzWwKNKDFedQEvzbQqG/+uPIWw9pLiDJBVwLiikGD9ktbLhUyisG40f3DBukI/lJR4nQuXINHISwj5hiCJQ==
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:PH0PR02MB7159.namprd02.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(366016)(376014)(7416014)(1800799024)(18002099003)(22082099003)(4143699003)(56012099006)(3023799007)(4133799003)(6133799003);
 DIR:OUT; SFP:1102; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?a0ZHMVFzbG4zOWR2TDIrR044K2pRUDBYa1ZrUmNrb3lCSnpKbFV5K3M1WlN4?=
 =?utf-8?B?c0FyVDBKUjYxaXVRVG1uVXNjT3FoYWhKZU9tcTRZQ0UyTjl3RmVnbjNhUGdQ?=
 =?utf-8?B?NUhsYmNmVjgyUEtiKzExazE1VkNPZWJDYXBZeU1scDY2U21XTWN4QUhLZ1I4?=
 =?utf-8?B?c1NsSy91aEZzRWNCT2IvYnZ5K0FmaEl3NW9WSW5tYlB2cHc1Zk5YQkVGdzM1?=
 =?utf-8?B?dVVJOFpLU2VBRkZwSFRGMWFKcDhkeGpLL0xDVFBXOHF0Nkljd2R0UjZ2Njdv?=
 =?utf-8?B?TzNCWTFMRUdrYVFNclc3UmtEQnZRS3FSWlpnQ1NGWFVaRFp2MHVEcFA4K2JF?=
 =?utf-8?B?UFY0TWtnSFBxOGFDa3JFbDJHMVdZQU0rdnNVQjhWRCtIVy9iVG1VYnQzZTFh?=
 =?utf-8?B?bXJYSXM1L1Z6VUVTWGdQNzlDVHI5Q3V1aWR4MFZWUXZiMUFpckNYeGhMay9h?=
 =?utf-8?B?Y1lGZy8xRkFuUnNiYWNqeE1ZVE55M3M5WjdqbzYwc0g1MUhIY0ZRc21abFQ0?=
 =?utf-8?B?Y1NYM3h1Nzl5dVk3M3ZMRDZKa1RzZW1CbUpNMG0rZkxnVURNeTFSLzZUTXZQ?=
 =?utf-8?B?Wk9rVER2cWVseWVJRHRNSU42U0NXT3hpWXEyY1gwNzJIVDcvdk5rTVZ1blJR?=
 =?utf-8?B?eXhMdVB0RmZySk5oVzdjYkJYM2NWcXZUTE43WXBvS0hhMDVxUE1IdHlkNmR5?=
 =?utf-8?B?dXNXRldsdGV4TzJGV1hscE1XajhsZ2taYUx1bjF2ZHo0T3FRaXBvcEFmWkEy?=
 =?utf-8?B?bGJDcGQrZDhzQ3p6dzBnTzFtWUkwRlBNL3cxc3g5aFhYcDFBeDdOY25SN1Rl?=
 =?utf-8?B?aWVWalJhRjFIb3RxZ2JhVU9iSEMzQjR1dzlnalJETDJpd1JWVEEycXh0NnFT?=
 =?utf-8?B?bitlV1dtTmlobG9zTWFSQURnU1JNYTViUkpXdkkwSk9TQTVlYldURGZmQVE2?=
 =?utf-8?B?SHhnODBpQkdjZlRQNTUwVFRpK1dCSVhoR09aMFZjaVBsVDNlQUp0RWx6NVB3?=
 =?utf-8?B?bnZlVENyWDdMK3RFTlNWRFh5a2hFZC9xajJLWXVGZGkzTmJZcHJhaVA4VnBu?=
 =?utf-8?B?aFpYUkRtTG9qazZTdE8yczRQR08rNEhuaWNzN1BkYmdrUmpJWWE5UXVjVDll?=
 =?utf-8?B?czZPbFAzZzMyazR5MkFIRyt6eUU3cy8yVmhVcjkxVlZ3N1MzSWRSTVp0N0dn?=
 =?utf-8?B?M2YzdFRzMWY3YnduZytzYXZjS1ZCQVNTVEl5Z1l4OER0MnFIL01OYmlHbXc2?=
 =?utf-8?B?TlYyZlhldHNEdTB6NzJ5eVJCVm51RVFFZlllUkxDMlV6eHE0bDNTa3JycUJW?=
 =?utf-8?B?cXVYV3N6ZWdoZU4xcFpiY05HTVh4eUJLVUx3WEwvK1IyeGVpcURzaU9YajZN?=
 =?utf-8?B?V0dUaWkyUzJzaUN4RjBnWDRobnloZ05TYXo2bnFtOEJhVnZRQUNXK1NObDF1?=
 =?utf-8?B?SjJvTktuYWRnNzhtV1dwdG96YUpDUkdZdTM5TUNUb3l1cXBHZ3hjMTArOUx0?=
 =?utf-8?B?ZzY3YVJUYnJMOHlHUEV3dnJwSGs5TSsrSzR1YnBFNmxoYjFVTTRNK0hhWE15?=
 =?utf-8?B?Zm9JaFF6WWdXQXk4UWxHcGNuRXlMK3JPSWdxWGFYYzB3bnZJcmYva3NqS1dZ?=
 =?utf-8?B?cktpTGxBMEs5NkVXcDNZR1hEY3Y5bnFCQlBiWHNjL3NMVHlldUZwYU1raTNh?=
 =?utf-8?B?aWtZVDYrd04zRUNZNXJ1K0FqSXlncCtHVmpiQnhsMjJOZ2JoWUZUU0sxc1I0?=
 =?utf-8?B?UG9RZVlVazBVZkJqbzFVZlhFRXJXSzNnYUxOL0dZaEFLazZJZmRUenNGakZK?=
 =?utf-8?B?NWd1bW9KMHpnQ2g0bGJJQkt1Z2hEL2VxV243MDRRbFVCSnNlS1oxbWtFNUtm?=
 =?utf-8?B?MnJTdGJSMWo1K1BSYzhRakxOTThiK1NiOUZJZmpKdHJVZEk3U3ovUmEvQWVv?=
 =?utf-8?B?Y2I4YSt2dGtsMUVaaE5RQzZDNnlXc3F2MEVmV3BneVZQcUlRbUN2bDQyY1Bx?=
 =?utf-8?B?NHRMdjExVXZiTEUwdUoxeW04U3BJRzJMak04RlVtS1ZoR1RWN05rMmtSM20r?=
 =?utf-8?B?TWo1TmxjdW1JTlJEVHZFNENPMnZNK2RGclJDUXBuL3FFWWJzeVRQTmc5ZmYv?=
 =?utf-8?B?ZFM0ajlWSXhzaFFSa3JhSnhxdUo4Wm9Bc29XblpxUzVWUjY2TTFnU0x6VWN1?=
 =?utf-8?B?RUl0QzJWdVBMN2UxZFd2Q296NjJwN0w0cDdRb1F1LzVsbDBnemhiMGJXeW9t?=
 =?utf-8?B?aittQjUrdVlyWXNOckZ3c3h1OUJqSGFHTWVNWjRONC9NRCtjcVF3QUJlWVRt?=
 =?utf-8?B?bHlVOGdvdFIxdTY1c3pGeStxcEczbG5EYWpNdlJHQ1hCbXhiaEVxWGJqY1g2?=
 =?utf-8?Q?fZM+xrZL5XqQLnaQ=3D?=
X-Exchange-RoutingPolicyChecked: NvsUFj9/39Yuqhma68x6KlOyqn4oxrcluntq1EPdxpltvTgRqjWCUHNbl+qpG5INLj/9H54sXMpFyv1NHrlh+H1KJC0qzh62fUrO0mb5b8BxIFEptQQvMzSzrZ3/VWTI41MvILSQQZXuTOcxgIRbavOIue1fai6Tz3bBLpvIZRgMfRqvTpufSdryvl1Cwf5n4d8a/oIf90rJGwBxDHivPrKCyG8sRKmjiQ7BKHleNbk3cIXnChbAg3qMBi8d2VJI+wyY57b1N5coMM69OMfYqz0FWZpTfhATo7u+PpG9sJgTHRolvAyWZ5G6d7pDqwht2v7oO0lYsMk3ZtV2sfDxOQ==
X-OriginatorOrg: nutanix.com
X-MS-Exchange-CrossTenant-Network-Message-Id: c99fd295-e76d-476a-4848-08dec1869885
X-MS-Exchange-CrossTenant-AuthSource: PH0PR02MB7159.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 03 Jun 2026 15:41:36.2585 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: bb047546-786f-4de1-bd75-24e5b6f79043
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: TrQnFs927XJj3/uCZ9ozgzDbqvaOob4P+bvqmlCpwz+fhR4EO+0FXgfNx0b8VevQRSAAbRd+5pvMQKMdWnrb0hwVxFxJvSoJCFr6WfE/Ut8=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR02MB6541
X-Authority-Analysis: v=2.4 cv=Mq5iLWae c=1 sm=1 tr=0 ts=6a204b34 cx=c_pps
 a=yafsvPyTBqI1YZ6v0bsx/A==:117 a=6eWqkTHjU83fiwn7nKZWdM+Sl24=:19
 a=z/mQ4Ysz8XfWz/Q5cLBRGdckG28=:19 a=lCpzRmAYbLLaTzLvsPZ7Mbvzbb8=:19
 a=xqWC_Br6kY4A:10 a=IkcTkHD0fZMA:10 a=FelO9ux0wxsA:10 a=0kUYKlekyDsA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=VofLwUrZ8Iiv6rRUPXIb:22 a=1L6crL_YRTbalZ11mEUO:22
 a=p0WdMEafAAAA:8 a=VwQbUJbxAAAA:8 a=6R7veym_AAAA:8 a=20KFwNOVAAAA:8
 a=j6gpQQwHwN5ZeBaIkFAA:9 a=QEXdDO2ut3YA:10 a=ILCOIF4F_8SzUMnO7jNM:22
X-Proofpoint-ORIG-GUID: JdftxWEW66-pzGB8fe3gEN3vDH3JJTYz
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNjAzMDE1MSBTYWx0ZWRfX41ebKHxHLsLt
 2B9buFeRkApYDGv+217R2o7VALbJXOOSL0Yz4zOhJD/Am7Ln6u2O3XwN9TwUjNNhYrQRcLMjAZp
 V5bcM8L1cnLpzvh9ite6aKi09l5i7lu202kvKGdqmJNpIKXcNMyLA/HPZJcs4gZTV5cLSZLOpYE
 rYGXV+AwED7KWKJFFt3bA4rE+nVULFZX3kxG+jMkvLtBeOKy1Nx5Z8szN8kNT63zUbsKQnFhl99
 9hwLNu4YAyhbMlk9Mww+HtkMT1T+acWgGl1fF0Kl1GrlRRP2dKSow17SCraJLiYzgc/wG1KGYeV
 tlBd4v6/YXDMGqcqysL1gUpAck5iNZgjSCfydhGV0QMDMJ9MfXXsPJ8B/yiN0pnn/NdgsPmVSy0
 Y9kRabgm1XU/lPji6EebJ2xkri+W7X9OwrXy8J1ZdBfrt5osAQWbtK90CfFBK8WrpCNz8D/W7Bm
 7ho8R5K02fgc6yhLhag==
X-Proofpoint-GUID: JdftxWEW66-pzGB8fe3gEN3vDH3JJTYz
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.125,FMLib:17.12.100.49
 definitions=2026-06-03_05,2026-05-28_03,2025-10-01_01
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

On 29/05/2026 15:15, Peter Xu wrote:

> On Thu, May 28, 2026 at 07:01:50PM -0300, Fabiano Rosas wrote:
>> Peter Xu <peterx@redhat.com> writes:
>>
>>> CI: https://urldefense.proofpoint.com/v2/url?u=https-3A__gitlab.com_peterx_qemu_-2D_pipelines_2560168907&d=DwIBaQ&c=s883GpUCOChKOHiocYtGcg&r=c23RpsaH4D2MKyD3EPJTDa0BAxz6tV8aUJqVSoytEiY&m=UheDdoNwrmPPc3shvbHQ-dAHk7N6GGtWRAbXjZasaJCgV123Fp6foXXlMUC1mXjb&s=KXo-AcgkWswgIUOgetjfuqaSAGVBUC-c78vno6rnNV0&e=
>>>
>>> This series introduces a generic way to specify migration parameters that
>>> can be used even during the early boot phase of QEMU.
>>>
>>> One example use case that already existed is CPR-transfer / CPR-exec.
>>> currently QEMU has a temporary global variable (incoming_mode) to achieve
>>> this, but it's hard to understand and this hack bleeded into quite a few
>>> places that we could have avoided.  The lines in patch 2 touched may
>>> provide some idea.
>>>
>>> With a generic approach of setting migration parameters with cmdlines, we
>>> can remove this hack meanwhile QEMU should be able to keep the CPR behavior
>>> as before.  To CPR maintainers and reviewers: please have a closer look,
>>> even better if it can be smoke tested, to see if this works for Oracle's
>>> environment, TIA.
>>>
>>> The 1st patch implemented that new semantics.  It is straightforward: now
>>> we can setup any migration parameter using an extra line of:
>>>
>>>    -incoming config:key1=value1,key2=value2,...
>>
>> Just merge my code mate.
>> https://urldefense.proofpoint.com/v2/url?u=https-3A__lore.kernel.org_r_20251215220041.12657-2D25-2Dfarosas-40suse.de&d=DwIBaQ&c=s883GpUCOChKOHiocYtGcg&r=c23RpsaH4D2MKyD3EPJTDa0BAxz6tV8aUJqVSoytEiY&m=UheDdoNwrmPPc3shvbHQ-dAHk7N6GGtWRAbXjZasaJCgV123Fp6foXXlMUC1mXjb&s=jaAeqTGqX39wQ3zMnICUZhIcIJl6a0lCALABkjC-HxI&e=
> 
> Heh, I apologize. I totally forgot it even if I seem to have read it..
> 
> The goal is differnent, though, which is to make it available before
> migration object initialization.  Say, I wished -global would work too but
> it doesn't, and it just can't.  So it's not "something good to have"
> anymore, but functionally required for either CPR and TAP in the future if
> we adopt this, they'll all read them early.

One of the reasons CPR requires a separate channel is because it needs 
to access the stream before the devices are created. Is this part of the 
same problem in that the migration object needs to be created much 
earlier than it is currently? And could doing this potentially remove 
the need for a separate CPR channel?

>> A couple of differences from my patch:
>>
>> - old-style keyval vs. json;
>>
>> Isn't json preferred nowadays?
> 
> I didn't mention it in doc, but yeah this series also supports JSON due to
> the same qapi helper used.  I don't suggest json though for this entry (and
> that's also why I didn't mention it..) because 99% of migration parameters
> are scalars and I don't see why we should use JSON here.. the only one not
> scalar is block-bitmap-mapping but it's not intended to be used in
> -incoming at all (even if it'll work..).
> 
>>
>> - using "config:"
>>
>> This makes it non-uniform with uri and channels which don't have a
>> keyword in front of them. I guess I could live with it, but it seems
>> odd. I see that it makes parsing way easier.
> 
> Yeah, having some identifier would be nice.  I wished channels also have
> identifiers if we don't need to keep compatibility.
> 
>>
>>>
>>> So far only one such instance is allowed for simplicity, but it should be
>>> enough.  We still allow multiple -incoming for specifying channels, used
>>> together with one "-incoming config:*".
>>>
>>> Then parameters set this way will be visible almost anytime for QEMU, for
>>> example, during initialization of device backends (which is before
>>> migration object created).
>>>
>>> I posted this series majorly because I want to see if this will make a
>>> possible new user for the new "local" migration parameter proposed in
>>> Vladimir's series:
>>>
>>>    https://urldefense.proofpoint.com/v2/url?u=https-3A__lore.kernel.org_r_20260522120534.77653-2D1-2Dvsementsov-40yandex-2Dteam.ru&d=DwIBaQ&c=s883GpUCOChKOHiocYtGcg&r=c23RpsaH4D2MKyD3EPJTDa0BAxz6tV8aUJqVSoytEiY&m=UheDdoNwrmPPc3shvbHQ-dAHk7N6GGtWRAbXjZasaJCgV123Fp6foXXlMUC1mXjb&s=T6LBhQkrn3e5gBGAQuTCshuzq04UbUaFAO1OaFnRAhY&e=
>>>
>>> Especially, there're some context on this idea too in this email:
>>>
>>>    https://urldefense.proofpoint.com/v2/url?u=https-3A__lore.kernel.org_all_ahdI7Vl5KraK566D-40x1.local_&d=DwIBaQ&c=s883GpUCOChKOHiocYtGcg&r=c23RpsaH4D2MKyD3EPJTDa0BAxz6tV8aUJqVSoytEiY&m=UheDdoNwrmPPc3shvbHQ-dAHk7N6GGtWRAbXjZasaJCgV123Fp6foXXlMUC1mXjb&s=Ix4yc95OzsoKMBcFrEc51cVrtKzUZKarzIBlN-IeYaI&e=
>>>
>>
>> I like the idea overall.
>>
>>> With this series, we should be able to drop "incoming-fds" TAP property
>>> from the other series, instead relying on the existing "local" parameters
>>> both in migration core and in TAP's property should suffice.
>>>
>>> One thing to mention is I didn't further make only-migratable into a
>>> migration parameter.  Logically it will also work now with only-migratable,
>>> but it then also means I'll need to convert it to a parameter, which will
>>> be mutable even after VM started.  It will change how only-migratable used
>>> to work, hence I skipped.
>>>
>>> After this, we also almost have no reason to use -global for migration
>>> parameters.  Capabilities are still not supported in -incoming cmdline,
>>> though.
>>>
>>
>> Will we still merge capabilities and parameters? Then it would be a free
>> upgrade.
> 
> Yes!  /me waiting for your patches.


ATB,

Mark.


