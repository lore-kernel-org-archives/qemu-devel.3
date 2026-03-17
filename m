Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4EA13FED9E8
	for <qemu-devel@archiver.kernel.org>; Tue, 17 Mar 2026 16:22:13 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1w2XBB-0005SK-Gq; Tue, 17 Mar 2026 12:22:01 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <nathanc@nvidia.com>)
 id 1w2XB1-0005Rb-RJ; Tue, 17 Mar 2026 12:21:51 -0400
Received: from mail-westus3azlp170120001.outbound.protection.outlook.com
 ([2a01:111:f403:c107::1] helo=PH8PR06CU001.outbound.protection.outlook.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <nathanc@nvidia.com>)
 id 1w2XB0-0004kJ-07; Tue, 17 Mar 2026 12:21:51 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=gTxlcZhXNdf16LsXQu31brVDN2uQbjXuMG9GF21EdxxViSssMeOdnvD0g/zT9uTjZ+AZwF0wMXQiOIZuEdzd4d58DmiUReJN3ptC00j70aupaYejfhsjhVXbRGTFQR46pBGioMlUEXpixWWCd0uEK8lscQNxMFsxK7FQDx5SMDdold0RwbosdhGG0BPjvfW23JQ6ULlX+XzhX60WknAO0cIuj2fTTGso6WrDT5lr+euRseeSjOe6OFeBmUEJNfbPxSO37WQa0rElpPhif0q2YNUD+Uhdj/plpugDTcXbKM0/AwhXT0yoCMW7zNAETSHmIAKBacJw4wzCx77GzrvzvA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=4NSoN6xsqOX1C71Ye7IA5XHiCea6JnQxPKs32SHAoDA=;
 b=bU0AalVOGvS7o6EoNgxmDUcec05ZaSnyzHOZLtikuaGMvDwphLftMbqAoRBRHmBdAqCZbJwULf4FDkM9V3SXfIYijnncrk4u+Hb/XeOoGwsQebyHCbAPMwq8cHk8g4V1pF29wL4nJ3zKRgLswozLS2yS1QS4ZHnjLbdiVFR9HQbaxqVCUddVM68+qzW91ipOJwdz81piHHZtTnn3L8iaMiPPtmyQLiAHShxwVTUuxBBSlVIsqvMCI9+23lZjFuE8hY32bbh3z9UUA6bOfRVdOBZ+eNYvWisU4wD1dfgH3tyZWEC+SJMTHvl/q2QU6yxLrWNpR7W+9/GD3BeCxC/k5A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=4NSoN6xsqOX1C71Ye7IA5XHiCea6JnQxPKs32SHAoDA=;
 b=Nrw7QYHyCAiEZk8TCpXOOVB8x7pFL3Q1TG8x5GdFUnW1aE+6eocQcMjS9jIlG+Ffpp5tZBE7s1xdfzX96HX8+xtU1swHz8vGAm8URJXI7g7Y2QHV1ZZOJSgynqFAnXhhjAR3wvkGi75byEALfgBlgfywqEOYKQNhsTbSpBG9pLQdf6Us6x37+tW+k12UJu2kaNHhTbTFaKvaqJKfxzVLLgBrNET1u7bWWPL5zcXSnLU5K1VpG1kp1lbW0EFcJwA1tuMX6g+v8g8Yh5fGSgoZTLMY2JVw3RFPvylzmAvkTHsVwpkEtzpBTuo+DEwxemjFP+EQbKzLVLkjK47CdPGWJQ==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from DS2PR12MB9567.namprd12.prod.outlook.com (2603:10b6:8:27c::8) by
 MW4PR12MB7335.namprd12.prod.outlook.com (2603:10b6:303:22b::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9723.19; Tue, 17 Mar
 2026 16:21:43 +0000
Received: from DS2PR12MB9567.namprd12.prod.outlook.com
 ([fe80::636:1b52:24ca:d7e5]) by DS2PR12MB9567.namprd12.prod.outlook.com
 ([fe80::636:1b52:24ca:d7e5%3]) with mapi id 15.20.9723.018; Tue, 17 Mar 2026
 16:21:43 +0000
Message-ID: <9b7178f1-fe7f-440c-811b-2ac2661b5f50@nvidia.com>
Date: Tue, 17 Mar 2026 09:21:41 -0700
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 0/8] hw/arm/smmuv3-accel: Support AUTO properties
To: Peter Maydell <peter.maydell@linaro.org>, eric.auger@redhat.com
Cc: qemu-devel@nongnu.org, qemu-arm@nongnu.org,
 "Michael S . Tsirkin" <mst@redhat.com>, Igor Mammedov <imammedo@redhat.com>,
 Ani Sinha <anisinha@redhat.com>, Shannon Zhao <shannon.zhaosl@gmail.com>,
 Paolo Bonzini <pbonzini@redhat.com>,
 =?UTF-8?Q?Daniel_P_=2E_Berrang=C3=A9?= <berrange@redhat.com>,
 Eduardo Habkost <eduardo@habkost.net>, Eric Blake <eblake@redhat.com>,
 Markus Armbruster <armbru@redhat.com>,
 Shameer Kolothum <skolothumtho@nvidia.com>,
 Nicolin Chen <nicolinc@nvidia.com>, Matt Ochs <mochs@nvidia.com>
References: <20260312210328.2016191-1-nathanc@nvidia.com>
 <a0ca818f-8e05-4756-b6bb-8f986c59cd54@redhat.com>
 <CAFEAcA-NjFCaZC-UAykS98J4DAEXyANj2QfAgc3bqT4eQsO=zA@mail.gmail.com>
Content-Language: en-US
From: Nathan Chen <nathanc@nvidia.com>
In-Reply-To: <CAFEAcA-NjFCaZC-UAykS98J4DAEXyANj2QfAgc3bqT4eQsO=zA@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: SJ0PR03CA0129.namprd03.prod.outlook.com
 (2603:10b6:a03:33c::14) To DS2PR12MB9567.namprd12.prod.outlook.com
 (2603:10b6:8:27c::8)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS2PR12MB9567:EE_|MW4PR12MB7335:EE_
X-MS-Office365-Filtering-Correlation-Id: 7a7ea022-642e-42f2-45c5-08de8441470d
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|366016|7416014|376014|1800799024|18002099003|22082099003|56012099003;
X-Microsoft-Antispam-Message-Info: wUnCafGYJA52+zs3CpJKB3JfboIrTlv1aurey7Lthpu21kMwA76u68rk3KZZGHQKxFUUSblWTSLAifBCMlKmx7jHT82Jx4rZudplt8co8WxCcy5y7tZW6H4L0EVa8uyPuTZ08x2+U+lwu6yl9P7gz/RCqQyEDU2CKsu1MY35skIvBVmYwjN6hn1EbIYaWUAY4af9wB916NFSW9hjd6ZPRa0JoAJOLPpK1tv1zu2JJrIAZgpMDfPiolb5BF18iEqSS57YX8ISWxy+4TKG4tY1ttCGqGgdRHkLh2GjPFga5+Kjxz27FJilpse7tpCT7lQFk6iNGB7rU0vpUHwaENvX7ExvOyx2t7qs6tCG9isdTG6Dn0fSMluFctm06kL+kxs5QuijdyPCkHSk5i8RAaqpYQ84kXgT1gVIbXk9pwzsGPweAgs9Vp1+ejrsC2OAuJTN5cBAGVbw9Hellj3lr/amqGwdEWP72g2o+ppmwTMox1BQ7HDiQH4bm8wClxpwf/xplaRFIFaif5X2diQvkKUu3vRBwrSpDL8LM8G30hVuqFJ0SoLH+3DKwQ/jCf1yMMnfj/gBlmX0SYFpK8Ua496hR5slLhUDUalqvC0dmud+2GCbhDWoST2dCMW4hVQBSUuK8fDRDQAydcb/8O1nFtvNUrDJurxbqOg9B40+hSHLURQyAa23aqQexi2brvP43ef4mixjWg32P6eKRu7F373AFPlPzkifAbHQHJ4ot7pKx3U=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DS2PR12MB9567.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(366016)(7416014)(376014)(1800799024)(18002099003)(22082099003)(56012099003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?KzcrMWF3UEgxek9oTTIrR05DTE1sQVhCM1YrTG1PVXhPYlNoV3EzOFdzSHBt?=
 =?utf-8?B?eENGN1lDQmE3RW5FcGNMWDBvNGlOaUlyamErdmlFaUQxdkFiYnJMQWk2SW9u?=
 =?utf-8?B?RWxtNnErUlJjL0xzZHozSDcwSmtzZm5wVk5pazRDQTBVbXZkNVNuU3UxNkdq?=
 =?utf-8?B?czJkTmpuOWU3WS9ZVjNnNHF0eEtBemk5MmZKUmVLSjBZMGdJdlZsVzVrZTll?=
 =?utf-8?B?ZmNENStNQnJSRytjUnNXKy9JK0oybHNTd2JaUFh4Wm1aUnFhcHREaG0ycy9N?=
 =?utf-8?B?czlmL28yemcxUUFwenNnZ0ZyTldJNXpLV0Y1SDB6ZmQ5blBqTnBWaXIrREU0?=
 =?utf-8?B?bnZ0c2FBek5hWlhMdEMzRUplS1BFeTRUQWI2eTEwd2xtMm1wZ0RvNnpKY0ZG?=
 =?utf-8?B?THdESHRZRXdBVVg5K3lmai9YaXovdGZEdXBxemtyVnBNeDdFVi9pNlZRSno4?=
 =?utf-8?B?SllGVzlMM3ViQjgwejVDSjNVTFZ6emo5QkZHT0x3SEJ2VzhUUkVVcnhJSktS?=
 =?utf-8?B?MGtUVzR2cDRYYVUya3RPNUVmaGxkYlJVQlMyYS80aENGOUdhZXpHVzM4ZzIz?=
 =?utf-8?B?b2t5NHJiSVU1NTNqZVViWmd0a3NHRXBFeWIvenpXLzJQYjhudXRkakNUQWp0?=
 =?utf-8?B?NlRZTkoybjZtYWF0TTF4dnZyRXVhQ2FBNWs3NGVNWkR0d1U1ZHIyblgvcVFj?=
 =?utf-8?B?RlI0QUJPZnEzUDAxWnFMU3FhZGxxalpHcE5MR3JrVjFQcURJenBEblVHc0xX?=
 =?utf-8?B?MEc4SDFvQ3JZSHo2VUZ1ZFU4aTNnU2VtdUV5V1VwaU9LSk4wTkc4RDlPeXhB?=
 =?utf-8?B?d2RqcEcyN0hkMk1qV1IyditjbER6OTlpTlZ3TEEySlVub29NZ0RCOXBVSXhm?=
 =?utf-8?B?Rm02bnNuNDhJcWdRV1BYTitxWkoxVitKOHBJZnMyOTZuRTlSTUxzTEZMcWNm?=
 =?utf-8?B?eGkzY3M0djI0MDlVVlBySEZXeEFucE54bXhVK2M3dnFPbStFY2c3U3A0aUFG?=
 =?utf-8?B?UkpyUUozM1RSY0tLelhoZUNHVGNpTmdzWWw4U1BWMTEwUnA4Wlo2QTZjOHdL?=
 =?utf-8?B?TGhaWHJDWkFyb0pFVE1MK3BVdDEwRE1ZK2YvZm5LU1NrNDNQVWtzM3FIYTBn?=
 =?utf-8?B?RDBlRE9sUmdBV2xKZlVpNFZYd2p1eVd6SzcyZU5UNi9zL0JibGxDZDN3KzNi?=
 =?utf-8?B?M1JlVjE0RnFSbXprdC8xazZNOHEvWmRtdHpuMk9FeUllNWF4M3VEVytId0FR?=
 =?utf-8?B?YU9senRHb1FySkoreGJhelJoUTBHRE9odVcwU2trdWlCTTg4ZVlIcnJhOUpP?=
 =?utf-8?B?Y2FnaE1xRGprQWdLVUlndG15OGpoQ3ljVTY0Nzg0RElVZUhWSkJDZCsza2U0?=
 =?utf-8?B?SWFKejFlN1lHZ3had2tJS0FjWUxTVC94WHJHank5ZDYxL2JsVG9GcWZ3RWgr?=
 =?utf-8?B?WkI1cDh3QmJPa2Z3ZEdVQTN2TFRvakp6d1FNK2tXcXNpWDc1OUkwckErdkpK?=
 =?utf-8?B?U3dTMnFSRHppU3g4L1VVclFFajQyRjFvTWZ3ekM3cllpMnlScDFSVENTdm9W?=
 =?utf-8?B?MEJIbjQ2K0lwc1VPQ0ZmRVVwVHo3c2FxL1I4QXExeURUbGRHRnB6SEs3NldP?=
 =?utf-8?B?OFVDM0JZZWtIVHFhMzl1a1NRTm5wUkRiRFpySFJUTDBNNk93SW1QRWJLZ0hl?=
 =?utf-8?B?UlhzckpreEN1TGVoV052WkgvQ3k5TkYzQ1d1Sk1Ja1Qvd3JTVXl1eVEvM2Zm?=
 =?utf-8?B?R3I3eEVkaS9mOTdpUFV5UDBWWWZvQ25wTUdkQkpOdnZTR1RkM3pOUGhYQzh2?=
 =?utf-8?B?Sk13UVE5UXl6aVY3NFRycjZLREV5cG5WRWI4alBWK0YxamU3a1FkKzVxRWlt?=
 =?utf-8?B?UnJERnhTUVBxbVgvanIvNjFaSGRjY0V3Vkp1cmFiZHFSZVFEeGMwWFZ5S1gx?=
 =?utf-8?B?eU94eWs2cTlYSkhsTHUvVVFWQ3h6c1FOYnlULzlya1NGYWhmUnllRC9OM1c1?=
 =?utf-8?B?eEJ6WnRQdTc1Vzk5UkRsRWRkQ0hKMDJkZDRFWHU0UWxTSmxvaVRZN25vTThT?=
 =?utf-8?B?Rjh5cnpQdEtXODVnT2VjeXRJRXY4SDl1QVB3VEFzUEVEMS9qQXpQWWhjQTNG?=
 =?utf-8?B?YjNRaXVLcVBqUkJmR3FJRXRsdlord013NmVvcENmZG81ZEQxcTVCRU5MK3lY?=
 =?utf-8?B?ZnM5eGtUU2tJamRFU255aDJIaFZCUHZTNHFjc0JBMFMrc3FXWUx0bzFSY0lY?=
 =?utf-8?B?VUF2OTRCanVFcTlWd3JjTzdQUFliQUQzRzQwT1Fmblh6eS9OSWd1ajlwSWRS?=
 =?utf-8?B?aGtmSzVhais0bFA3aXF6cG9MRUhqU1d6dWF4RXdCa3cxSUlqWUJiQT09?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 7a7ea022-642e-42f2-45c5-08de8441470d
X-MS-Exchange-CrossTenant-AuthSource: DS2PR12MB9567.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 17 Mar 2026 16:21:43.4368 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: ZLawgtaBMcvo55eSQ4m+T5LogYm9BC8UaMGb4QaJ3xzGxoDffUegZ215MJ8LHA3C/a4fIDaRPSiV2CygI63vTw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MW4PR12MB7335
Received-SPF: permerror client-ip=2a01:111:f403:c107::1;
 envelope-from=nathanc@nvidia.com;
 helo=PH8PR06CU001.outbound.protection.outlook.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 SPF_HELO_NONE=0.001, SPF_NONE=0.001 autolearn=ham autolearn_force=no
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

Hi,

On 3/16/2026 3:05 AM, Peter Maydell wrote:
> On Mon, 16 Mar 2026 at 08:08, Eric Auger<eric.auger@redhat.com> wrote:
>> Hi Nathan,
>>
>> On 3/12/26 10:03 PM, Nathan Chen wrote:
>>> Hi,
>> If we want this to be taken in qemu 11.0 you need to clearly indicate
>> that in the series title:
>> using a subject prefix like "PATCH for-11.0"
>>
>> Then you need to clearly justify what those patches are fixes for stuff
>> introduced in qemu 11.0, something like:
>>
>> In qemu 11 we introduced new options for vSMMU but feedbacks received
>> when starting the integration of layered products shows the need for
>> auto/host retrieved values. To avoid breaking JSON/QMP compat, we want
>> to fix the option types so that they can later support the auto mode. At
>> the moment the auto mode is not supported though.
> Yes. At the moment this is on my "look at it for 11.1" pile.
> If you want it in 11.0 then it must very clearly state the
> justfication (i.e. why it is not new feature work) and be
> as small as possible to achieve its aim.

I see, I will send out another revision today with the correct prefix 
and justification for belonging in 11.0. I will keep these guidelines in 
mind for the future.

Thanks,
Nathan

