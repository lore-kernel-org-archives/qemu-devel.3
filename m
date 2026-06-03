Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2957FCD6E57
	for <qemu-devel@archiver.kernel.org>; Wed,  3 Jun 2026 15:27:58 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wUnUx-0000ow-VB; Wed, 03 Jun 2026 11:27:16 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mark.caveayland@nutanix.com>)
 id 1wUnUw-0000oJ-0i
 for qemu-devel@nongnu.org; Wed, 03 Jun 2026 11:27:14 -0400
Received: from mx0b-002c1b01.pphosted.com ([148.163.155.12])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mark.caveayland@nutanix.com>)
 id 1wUnUs-0005j5-SB
 for qemu-devel@nongnu.org; Wed, 03 Jun 2026 11:27:13 -0400
Received: from pps.filterd (m0127842.ppops.net [127.0.0.1])
 by mx0b-002c1b01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 653ED0WI203708; Wed, 3 Jun 2026 08:24:55 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nutanix.com; h=
 cc:content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=
 proofpoint20171006; bh=CemyeFxSyUb2CbJwwCnUXc9110dlkWfOTuO5C2L2k
 4k=; b=kpUn/ss3fEY8bwrxjI8RfGbHD+LJJveJIiBnwQaSnthGL4Qu/1peqtmWP
 m9amUES2HYosXK5kJPxRi7uBo9NfjwnvvVQL+MA1I0fg54Rs6x6RkwhgT357/5lj
 4/UZzERFp/Sr7yZMfcmH15+EmSoP/kGxDTafNDkmNNCKWoiknVh+gA95R6WakN08
 k5DG2LYbGKba6pHq7574Cufi/zmFNNeQf/Imp8et+fH6Q4AQns28QzNAsJ8w6r5c
 kORiSLezyhhWc/xgpgitWtm84rtvkuCyQs4ZoMZDdh7ekQ7N/Cl+OWKit4MFopWA
 41qrTt91lkRNchowrAC0xhGtr49sA==
Received: from sn4pr0501cu005.outbound.protection.outlook.com
 (mail-southcentralusazon11021101.outbound.protection.outlook.com
 [40.93.194.101])
 by mx0b-002c1b01.pphosted.com (PPS) with ESMTPS id 4ej8sg9yau-1
 (version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NOT);
 Wed, 03 Jun 2026 08:24:55 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=ET245qK7YD4sGU0u7MHaCGM4gZHjnDG3clSBTlYBLZBBttIBWtBfWyipgPQJ0TrdOqOWQeN0KNjzYA+34UrpuNo0ge8tmqoAx5pSZk6Mwq9zXlonlMti2Z/NK+SScC0C0KtvqJxtNZTSI5zhoeYTUxCsYwLIFzeXP4wIqx2vsAaCBP2wzMLsJZrlIW+6cI2SGlAAoRV1nLRBSQwj8NoagEaO0A0Gx8eItGqdmq6+29LRzsoeQBQmwFr5ePh1t0JefGnfHk8QW49g0JXD7JwJga1Y8pTaoAAECTLiYWBntozqFjnxZMYgN2YIgCB/B8gnaGIRWianqdmcMLmVq6eZwg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=CemyeFxSyUb2CbJwwCnUXc9110dlkWfOTuO5C2L2k4k=;
 b=HtffExrYylGYYAuObiRH6CaFbJgUfeJwkvywcLQbI2ObaJDsyqYN5C43KcGcqxfMq60FbPSATUvEbDClg9vkbbJ4h0b74sNx4Af3cstzg3hkXYCTanq77ohqcmBdA03YeaN0V0Mc5iWgF2nVOFlgrFNtar69OzuI2vjIoqDgWMcOJ/aeMrg5aekXM0+IlhVrIoLA+EXAgf5tm6xBeIpLVuMUiGJ8PlHqGY98kwQaQxzaiGUpGR/vgeLvM697EXCoafdT9TNtesxKlh+Sq7UfjZpTTbEbneX3hoQxFFz84wvJtLT7OYDW3Lp8WNhIOVWH9JZrOjVZx51JZEtpHkcTtQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nutanix.com; dmarc=pass action=none header.from=nutanix.com;
 dkim=pass header.d=nutanix.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nutanix.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=CemyeFxSyUb2CbJwwCnUXc9110dlkWfOTuO5C2L2k4k=;
 b=tAesfsTCo6ewxpwcMKPvBLPn3UXYyFS2pLhA4JpcxgaL4gDGsfUazyT3ibeE0w2X6LOpXVKu7GbXEw3GaC1ZivfkckSQWOibbovXfB/5Djn/tuf82iFXXATnYH0S45QGd9MXf37FKroiFP2cDRfYw5wDWrMGlCnCXEuqjMacNNub1rd3VcrUf4eZYWc1p0TmVaofprxlEqrFavfaYSN5iztL5531mTwaNfKlBbeC2006oz/WTll/jemnIbb8oaO3+8nHwqRAlXwYzq9Cs7OdHMOmBNT1Y81iGg2xN+mF1SJPmE7fSLTO3dpQWZuaaxjZqljPlofnwyJw+LInr7bkxw==
Received: from PH0PR02MB7159.namprd02.prod.outlook.com (2603:10b6:510:16::8)
 by IA1PR02MB11053.namprd02.prod.outlook.com (2603:10b6:208:5b2::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.92.7; Wed, 3 Jun 2026
 15:24:53 +0000
Received: from PH0PR02MB7159.namprd02.prod.outlook.com
 ([fe80::8e97:bc32:822c:b250]) by PH0PR02MB7159.namprd02.prod.outlook.com
 ([fe80::8e97:bc32:822c:b250%3]) with mapi id 15.21.0092.006; Wed, 3 Jun 2026
 15:24:53 +0000
Message-ID: <78b9e565-1853-4aee-8eb5-b28c4b650037@nutanix.com>
Date: Wed, 3 Jun 2026 16:24:47 +0100
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v17 00/10] virtio-net: live-TAP local migration
To: Vladimir Sementsov-Ogievskiy <vsementsov@yandex-team.ru>,
 jasowang@redhat.com, mst@redhat.com
Cc: armbru@redhat.com, peterx@redhat.com, farosas@suse.de,
 raphael.s.norwitz@gmail.com, bchaney@akamai.com, qemu-devel@nongnu.org,
 berrange@redhat.com, pbonzini@redhat.com, yc-core@yandex-team.ru
References: <20260527191150.250333-1-vsementsov@yandex-team.ru>
Content-Language: en-US
From: Mark Cave-Ayland <mark.caveayland@nutanix.com>
In-Reply-To: <20260527191150.250333-1-vsementsov@yandex-team.ru>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: CY5P221CA0050.NAMP221.PROD.OUTLOOK.COM
 (2603:10b6:930:4::19) To PH0PR02MB7159.namprd02.prod.outlook.com
 (2603:10b6:510:16::8)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH0PR02MB7159:EE_|IA1PR02MB11053:EE_
X-MS-Office365-Filtering-Correlation-Id: 31d90b7d-2af2-44f6-7b65-08dec18442ae
x-proofpoint-crosstenant: true
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|1800799024|366016|376014|7416014|3023799007|4133799003|56012099006|5023799004|18092099006|22082099003|18002099003|18056099003|6133799003;
X-Microsoft-Antispam-Message-Info: PSmAMd6+zltaQ2RF6Qe4MHkPm3sIlUEJVt5U8QA7ssv+Zz5Ro0pj0A0L9mU946e3YrPG0Rr+mY7DYnZ49Jr0izqIVkOXa2AlYH9QD5Z5IAe5Bi0F757jOHwTZREFwBLwU3iUBGO5QfFQl+G1eqyfInVe+Gd+Eq+sMb6vF6cPiNdIS6eo6twTy3NQOB5Y5ISr3zmtz9G1tWfIdy1XSbNgGmPtrSN7MKeimy0ndcSV/AGW9OCElrqlYPxvs2MIdhv/23oi79rGDqa1iHS7Qz0FzyqC3eMN6L+NLgi8hB2MG9FfykPlQDpNKqICxN9Nlc5DU8Ijz1JQ5kwvDU8ZAEO2+9EiEqKiw9y7OgvWfbL5+r4IAGDMbyaUXv5F4y22B/aHlrymDI32grT+rA8W5pB3eP96T0GNUFTYBGZkTdbG08BIK0kcvIVYNRp3y4TLEIFikt4mCBjnKKsUrQwOni/TAqumQIPUaKe6W+I/YAuet8Ey4of28Ai/lUF6f+QjBpXAtn2Y2tAVicsYsZF16vDPaxPsITqjShidqmUkHBOaV5k4+H8J63JSM7TtM4lCBBfY41LxudU+wyjRQLMQDnhaiuSOp0SkFFwXe8DWZVCdWismnOVgmuWJ6N/I7xYK+V9eep3pvCDvE4eCBxuQVpW0SzmaOKxVkqLUdYi8kNmKnfJf6hxkJWZ1aQ+QykrtrUAk41IN+1/v9mJlwTeRN+ViHQ==
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:PH0PR02MB7159.namprd02.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(1800799024)(366016)(376014)(7416014)(3023799007)(4133799003)(56012099006)(5023799004)(18092099006)(22082099003)(18002099003)(18056099003)(6133799003);
 DIR:OUT; SFP:1102; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?elRWU04rbDU4ekwvVW93eEk2QUNtcGJDcTl2VmxjdDJ1R3ExMTFYZ1JmQ0hw?=
 =?utf-8?B?ZEpRZXh1MGVBdEkyWEhTbk0xT3VTSW82d1ZPMkJIVjg1Z3VpMkc0MjlTZ3Vw?=
 =?utf-8?B?b0E1NUtMSWVVeUcrVFpSaEZGRGF2OSt0OFBTQmpVaGd1S1h5dzE1NkhSY3Jk?=
 =?utf-8?B?cElOdjhqQlIwY0ZOMSt1RytsMVBRajFLNlMyaS9jVXByZFZOdnh0Y3p0eHo4?=
 =?utf-8?B?Z1AxVTFVMENEYmtVSlNmR1Vqa2lsZzdtSjdHR1JkSFA4dHRBWnFOTXRtdStG?=
 =?utf-8?B?SVRndmN6d3dsUTU1Q0pVaTE0aThWMnRVS1A0MEwwYUt0amhOakhHN015MGVR?=
 =?utf-8?B?ZWt5eFFCcFhjM1Y4ZjM2eGpLZEEzUGVzdU43cXM0ZE9HQTluZ3VhaTc5Rkpv?=
 =?utf-8?B?UTBuT1VmT29jTXc2bklZUk1tekJpYnZqVWE5ZnJYYlhZSlBvQXVzbU9IQXlj?=
 =?utf-8?B?VWJwbWM1WkJKSTBHMTBFd1h5UmxpSkYvMW1RTDNKTGsvUEFZdmxyd0Nna3I0?=
 =?utf-8?B?ZGZZMUZJc3BjbU44Q2lMWktEWnhPT1lEejNJU3cyZlVNRUcyTmtaV0lPZ1Ey?=
 =?utf-8?B?OCtNMk1pMnpUeitaeFphMm8xbkpjZkRTQTB4NFdXbm4xY2RtaS9oaHBtRnNm?=
 =?utf-8?B?UmxGM1N6SHVkVW1ZdmcwY01hSm05azhQNU1QU2pVem1jcklzSHNVWEY2dzV6?=
 =?utf-8?B?QWpQSjVJREdENjlGaGZ4dkIwcTRQUzVKVk5xNWtYS29nUTViNXRmTXo2ZGxz?=
 =?utf-8?B?Y2diOFZ6RUNDQ0tENFA3TWxBWE9XNzBSWStSUkVtME5tY1BvSVRTUVpkdUlq?=
 =?utf-8?B?bStRdTk1Ty9PNVlFakNsNlFmYkIxQ3RqbG1POXVTVmhHaDhwV2EvbTR0Mmla?=
 =?utf-8?B?MzFRWm9ZeU5va0ZzU3hQRjA5ZXpIeVhYbXltN0VuOTVCZHJEYmU0Ym1Penl3?=
 =?utf-8?B?UXltL2NSOEFhUHVnT3h4TVJXblZxUkNSTzJ4aVFYU0UrdEF2ZDM0cjlWNHYz?=
 =?utf-8?B?NE04SHZRbEdSUVZSSnBnUHdnRE91cUtVS2pYVG1yU3BDeEdmWGxHODJ2RFhy?=
 =?utf-8?B?UjRSbDlrYkxuOWk2NW1nL2hwMU0xNnhPK1ZGQ3hpWTJyLzlyeGNBNjRDTDQr?=
 =?utf-8?B?dEVMK2JEVGZzRXR3R1ZmY0lTL01laXlPektPSlBoVDFWRUEzckhTYjVvTzZH?=
 =?utf-8?B?UldvZFk5aG00RFZ1RnBmWlZ5ZlVDRmtkYWlwaGJjT3RPU1lnaW1HVWhyVm52?=
 =?utf-8?B?QzA3L0ZqWFNZVEcvVndTUjQySG1rWnBDTUNzQkM5dkR4THRqZ3ZtdTk1OThQ?=
 =?utf-8?B?aHlyVFdyUytFaEdnM282RDM0SjJ0WTdSZ0s5MEVWNnROOE00V09YYXVYbUdk?=
 =?utf-8?B?dENncnhYTXorMmt3SGF2RHdRbzRiQWhMdFoyUHY1N05WMk9BRDFLWW5WVmZH?=
 =?utf-8?B?US93KzF4d2RNNkVpeWlFbElQazhUcHA1VVdOcThPYVIzZXpMZ1BQQk96VjhE?=
 =?utf-8?B?UTFoNWhVWmJXRVJrUXo3L1NFSzZoS3F3V3VheW5BSVExMnUzdEpYRE1SRjNn?=
 =?utf-8?B?NmY3eGhkQitVRXRIbXdTUjRKMEVPSGkrNFRydXVPbGdYRkZzcXlFUnFJTmF1?=
 =?utf-8?B?ZFdRV3hzb1pMWEQxY0psb2pqY3BEUTBhK0t1TW84K0tSTXNveHVOZ00wZDVC?=
 =?utf-8?B?WDR3QnZ3OXk3WnFhU3JSaER0d3hxL2tJWEJYUjdUREhwRGdGRXdTSXZJYWZE?=
 =?utf-8?B?ZlBDL0dQNWF4OUhlQzh2T3dmM2w3TzlzN05GaVZNVmZ2QnlzSHMzODZNaFcr?=
 =?utf-8?B?M3B3ejZlQ2E3ZmlDUzFHQ1ZxYm50YWJQK2M4dFNzT3ozMVRPNTJsVGRKMEVp?=
 =?utf-8?B?RGxQOGFYemZNMFM5TllnOGs3M3R4VFY1OThpRjYrZmJDSVpIbkFBcDVzc0N4?=
 =?utf-8?B?UE5VWTh0cXljaUZkVXo3TS94QlpER05WR1B3aG0veHNyWFpTeWRsaWFzY3FF?=
 =?utf-8?B?WGgrcnBtdHMrNlpsZE0zS2RpRGtOVmZDNTNUS3Iwa1Rva3M3aU42MFRubFNO?=
 =?utf-8?B?dXo0cEtPVElUVWk5aEJTakk3RjBkYnJqSCs1bFpxYjJPeFRMenhTeWFNYzhm?=
 =?utf-8?B?ZDlYaHBwMDZVOVVHb2pOVG9jWXd5TWY4YlpqMS9rRTRra0JmNUl1WmNrVXhm?=
 =?utf-8?B?TGFDdmljdDRZRVhVOFFhSnhNN0QyN1VoZEZjY0hsdGVpdUV6U25PNHlqcDNO?=
 =?utf-8?B?WjFxYnZ6N3gwb1dQczloaTh2NFo2T3diZjU5bnkxMEF5dithSU5QTEhleDFH?=
 =?utf-8?B?OUtCSHVyQ3Npc3hzTkpid0I2ZkJ2dWNwUjVxUUVTbVNCUnZhMldiQ3E3RWRG?=
 =?utf-8?Q?fqN3+6VVNIQ+SIkw=3D?=
X-Exchange-RoutingPolicyChecked: FnS+eIzFMYCip4dsz+qbV0ccUrr4OQhAIGH0LFI2SXY1fea+Qd+11cSccfeZlrQiLMWFWudeTYny6ngn1ZWs/E/90XliLxko6fg1aXG0mTNqwmLUc/GqrEHXn7wUx8lWiw8IzUEeBwTLWrraXeVTcc9auI3YPBGhtrFG67w5VxL2pnB4ZgD4C4nn7MdKnvjfYzoNPm4CFOdEueyFg3xBEB2ALhYObWoH/QDKIrzrnfADuAVdqvXx7ubrmSf0NzFprdwJ9mSdZifv8wyWqXXPMkOW4USesSEKC7tjk/sBsDhWqvzS7yhN0xLHXqXviE3D2hW0zcRRmuDz8H1VDuY9Eg==
X-OriginatorOrg: nutanix.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 31d90b7d-2af2-44f6-7b65-08dec18442ae
X-MS-Exchange-CrossTenant-AuthSource: PH0PR02MB7159.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 03 Jun 2026 15:24:53.5497 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: bb047546-786f-4de1-bd75-24e5b6f79043
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: UVO2IHsb0C3Q6V5uM9zHaiZsC1Z6fZAbikWn3O6rnWsHtWDn44caNgqah6SFLSEnSSNt1qBkDpMELASXbSISgpZCQ48RZMYU1CxUens038E=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA1PR02MB11053
X-Authority-Analysis: v=2.4 cv=NJrlPU6g c=1 sm=1 tr=0 ts=6a204747 cx=c_pps
 a=+kXwOJT9iXP9BgnuWAWdUA==:117 a=6eWqkTHjU83fiwn7nKZWdM+Sl24=:19
 a=z/mQ4Ysz8XfWz/Q5cLBRGdckG28=:19 a=lCpzRmAYbLLaTzLvsPZ7Mbvzbb8=:19
 a=xqWC_Br6kY4A:10 a=IkcTkHD0fZMA:10 a=FelO9ux0wxsA:10 a=0kUYKlekyDsA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=VofLwUrZ8Iiv6rRUPXIb:22 a=VUi8bpU7OL1Oj2-RSIOF:22
 a=p0WdMEafAAAA:8 a=kmYkUENqAAAA:8 a=6R7veym_AAAA:8 a=sgQQMPFwC5MYNhv6lowA:9
 a=3ZKOabzyN94A:10 a=QEXdDO2ut3YA:10 a=p9kz6gysRiz6SGr9lVkz:22
 a=ILCOIF4F_8SzUMnO7jNM:22
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNjAzMDE0OCBTYWx0ZWRfX3zchzdKh1qPl
 n1K6lteuevYl20fHum8XTVMR1Xz36FR4Zzkz/1e6WyGO1zv4lE9Xv8tOPytCO/tUA57saeSR+t7
 FbAgCBojhqLZCdZBRzaNk2BNKQjRmfch/a5TDaoOvXN9Ur0m6BVJYGNQ65wIvsOmrJj2Wo6HBwB
 IjvE99DapH7fAZbSwrczntnAnCXOeukAdU0KASK2nM/DLlmnCm2uBb9T7CkaCgA+M5ZWK6Yd+Ta
 6SEjV1eiUYQoRMvskuTRsL2VdrxR/wYKeVdnH1TrxzcY/ikrI3IW83+G8rjSVggYh4DYaX9OkPQ
 C2jAdt1mSXcJm+CHD6FM0yB7zps9YPQTdvjYvkMdPNcdktl3lKcM8gB47yDUGOObp6We8CjPZUa
 C13tGgnXZcA9R2piHQH2OwszSrYghOOo1FRrkx19zXLib/K3DtdaV/Y9okEVpuzSYvWXER4e23s
 QVUCZ9G9i28xDze4U3w==
X-Proofpoint-GUID: BntAHgygXDAyTWbwZuefalakm0UkeVLa
X-Proofpoint-ORIG-GUID: BntAHgygXDAyTWbwZuefalakm0UkeVLa
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.125,FMLib:17.12.100.49
 definitions=2026-06-03_05,2026-05-28_03,2025-10-01_01
X-Proofpoint-Spam-Reason: safe
Received-SPF: pass client-ip=148.163.155.12;
 envelope-from=mark.caveayland@nutanix.com; helo=mx0b-002c1b01.pphosted.com
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

On 27/05/2026 20:11, Vladimir Sementsov-Ogievskiy wrote:

> Hi all!
> 
> Here is a migration for TAP net backend, including its properties and
> open fds.
> 
> With this new feature, management software doesn't need to initialize
> new TAP and do a switch to it. Nothing should be done around
> virtio-net in local migration: it just migrates and continues to use
> same TAP device. So we avoid extra logic in management software, extra
> allocations in kernel (for new TAP), and corresponding extra delay in
> migration downtime.

Hi Vladimir,

Thanks for the updated instructions - I was able to successfully test an 
FD-based tap device migration using this series, although I had to make 
a couple of minor changes below:

> v17: rework interface
> 02-04: new
> 07: - drop local-migration parameter for virtio-net and the whole
>        code to migrate backends (they should migrate by themselves).
>      - drop virtio_net_update_host_features(), and call
>        peer_test_vnet_hdr() and virtio_net_get_features() directly
>        from post-load handlers
>      - drop r-b
> 08: - add local-migratieon-supported property (instead of
>        local-migration that is dropped in 07)
>      - register own vmstate
>      - add check for being in incoming migration when use incoming-fds
>      - drop r-b, a-b
> 10: only move 'local_migration=local' from virtio-net device
>      to 'local-migration-supported": local' in netdev. keep r-bs
> 
> Based-on: <20260318113144.15697-1-vsementsov@yandex-team.ru>
>      "[PATCH v4 00/13] net: refactoring and fixes"
> 
> v17 is pushed to
> 
>      https://urldefense.proofpoint.com/v2/url?u=https-3A__gitlab.com_vsementsov_qemu.git&d=DwIDaQ&c=s883GpUCOChKOHiocYtGcg&r=c23RpsaH4D2MKyD3EPJTDa0BAxz6tV8aUJqVSoytEiY&m=BO9WL9PEcrRM2I2KvXYdAYQ-qD80S8kAodStSmO6ukcWGHfyhmC5oBYZnpRkE2it&s=mKXtt2cIaKN9EjEyFBVWf7-n1xDIbFzA6_5oaEK84HQ&e=
>        tag: up-tap-fd-migration-with-bk-opt-v17
> 
> To run the test, use sudo, as test needs to configure TAP device:
> 
>      sudo PYTHONPATH=python:tests/functional \
>      QEMU_TEST_QEMU_BINARY=$PWD/build/qemu-system-x86_64 \
>      MESON_BUILD_ROOT=$PWD/build \
>      ./build/pyvenv/bin/python3 tests/functional/x86_64/test_tap_migration.py
> 
> Or, to test the feature by hand, you may follow the instruction:
> 
> 1. Prerequisites
> ----------------
> 
>      QEMU=/path/to/your/build/qemu-system-x86_64
> 
> # download same image as in test
> 
>      wget -O /tmp/alpine.iso "https://urldefense.proofpoint.com/v2/url?u=https-3A__dl-2Dcdn.alpinelinux.org_alpine_v3.22_releases_x86-5F64_alpine-2Dstandard-2D3.22.1-2Dx86-5F64.iso&d=DwIDaQ&c=s883GpUCOChKOHiocYtGcg&r=c23RpsaH4D2MKyD3EPJTDa0BAxz6tV8aUJqVSoytEiY&m=BO9WL9PEcrRM2I2KvXYdAYQ-qD80S8kAodStSmO6ukcWGHfyhmC5oBYZnpRkE2it&s=yF_WcQ_YiVipmpp9Gs3nNSd5lHNU1lOy2GophvYXYDE&e= "
> 
> 
> # prepare tap device (be careful to not break your own networks)
> 
>      sudo ip tuntap add dev tap0 mode tap multi_queue
>      sudo ip addr add 192.168.100.1/24 dev tap0
>      sudo ip link set tap0 up
> 
> 
> 2. Start source VM
> ------------------
> 
> Open terminal A, and run:
> 
>      $QEMU \
>          -name source \
>          -machine q35 \
>          -accel kvm \
>          -m 1G \
>          -object memory-backend-file,id=ram0,size=1G,mem-path=/dev/shm/qemu_migration_test,share=on \
>          -machine memory-backend=ram0 \
>          -drive file=/tmp/alpine.iso,media=cdrom,format=raw \
>          -device pcie-pci-bridge,id=pci.1,bus=pcie.0 \
>          -netdev tap,id=netdev.1,ifname=tap0,queues=4,vnet_hdr=on,script=no,downscript=no,local-migration-supported=on \

Looks like local-migration-supported is no longer required?

>          -device virtio-net-pci,netdev=netdev.1,id=vnet.1,bus=pci.1,mq=on,vectors=18,romfile=,disable-legacy=off \
>          -serial stdio \
>          -nographic \
>          -qmp unix:/tmp/qmp-source.sock,server=on,wait=off
> 
> Wait for Alpine to boot.  When you see the login prompt, log in as root
> (no password):
> 
>      localhost login: root
> 
> Configure the guest network:
> 
>      ip addr add 192.168.100.2/24 dev eth0
>      ip link set eth0 up
> 
> Verify connectivity from the guest:
> 
>      ping -c 3 192.168.100.1
> 
> And from the host (in another terminal):
> 
>      ping -c 3 192.168.100.2
> 
> 
> 3. Start target VM
> ------------------
> 
> Open terminal B.  The target VM uses the same shared memory file and
> the same ISO.  The NIC is configured with incoming-fds=on — it will
> not open tap0 itself; instead it will receive the TAP file descriptors
> from the source over the migration channel.
> 
>      $QEMU \
>          -name target \
>          -machine q35 \
>          -accel kvm \
>          -m 1G \
>          -object memory-backend-file,id=ram0,size=1G,mem-path=/dev/shm/qemu_migration_test,share=on \
>          -machine memory-backend=ram0 \
>          -drive file=/tmp/alpine.iso,media=cdrom,format=raw \
>          -device pcie-pci-bridge,id=pci.1,bus=pcie.0 \
>          -netdev tap,id=netdev.1,queues=4,script=no,downscript=no,local-migration-supported=on,incoming-fds=on \

And also here?

>          -device virtio-net-pci,netdev=netdev.1,id=vnet.1,bus=pci.1,mq=on,vectors=18,romfile=,disable-legacy=off \
>          -serial stdio \
>          -nographic \
>          -qmp unix:/tmp/qmp-target.sock,server=on,wait=off \
>          -incoming defer
> 
> 
> 4. Start migration
> ------------------
> 
> Open terminal C and connect to the source QMP socket:
> 
>      socat - UNIX-CONNECT:/tmp/qmp-source.sock
> 
> Negotiate capabilities and configure migration:
> 
>      {"execute": "qmp_capabilities"}
> 
>      {"execute": "migrate-set-capabilities", "arguments": {
>          "capabilities": [
>              {"capability": "events",          "state": true},
>              {"capability": "x-ignore-shared", "state": true}
>          ]
>      }}
> 
>      {"execute": "migrate-set-parameters", "arguments": {"local": true}}
> 
> Open terminal D and connect to the target QMP socket:
> 
>      socat - UNIX-CONNECT:/tmp/qmp-target.sock
> 
> Negotiate capabilities and configure migration:
> 
>      {"execute": "qmp_capabilities"}
> 
>      {"execute": "migrate-set-capabilities", "arguments": {
>          "capabilities": [
>              {"capability": "events",          "state": true},
>              {"capability": "x-ignore-shared", "state": true}
>          ]
>      }}
> 
>      {"execute": "migrate-set-parameters", "arguments": {"local": true}}
> 
> Tell the target to listen for the incoming migration (terminal D):
> 
>      {"execute": "migrate-incoming",
>       "arguments": {"uri": "unix:/tmp/migration.sock"}}
> 
> Trigger the migration from the source (terminal C):
> 
>      {"execute": "migrate",
>       "arguments": {"uri": "unix:/tmp/migration.sock"}}
> 
> Poll migration status until it completes (terminal C):
> 
>      {"execute": "query-migrate"}
>      # repeat until "status" == "completed"
> 
> Or just wait for the MIGRATION event that QEMU emits automatically:
> 
>      # {"event": "MIGRATION", "data": {"status": "completed"}, ...}
> 
> Once the source reports "completed", resume the target VM (terminal D):
> 
>      {"execute": "cont"}
> 
> The target VM is now running with the migrated state and the TAP file
> descriptors that were passed from the source.
> 
> Verify that the guest is still reachable from the host:
> 
>      ping -c 3 192.168.100.2
> 
> And from inside the guest (terminal B, target serial console):
> 
>      ping -c 3 192.168.100.1
> 
> 
> 5. Cleanup
> ----------
> 
> Shut down the target VM (terminal D):
> 
>      {"execute": "quit"}
> 
> Shut down the source VM (terminal C):
> 
>      {"execute": "quit"}
> 
> Remove the TAP device:
> 
>      sudo ip tuntap del tap0 mode tap multi_queue
> 
> Remove the shared memory file:
> 
>      rm /dev/shm/qemu_migration_test
> 
> Remove leftover sockets if they still exist:
> 
>      rm -f /tmp/migration.sock /tmp/qmp-source.sock /tmp/qmp-target.sock
> 
> Vladimir Sementsov-Ogievskiy (10):
>    net/tap: move vhost-net open() calls to tap_parse_vhost_fds()
>    net/tap: move vhost initialization to tap_setup_vhost()
>    net/tap: use container_of instead of DO_UPCAST
>    net/tap: QOMify tap backend
>    net/tap: add TYPE_VMSTATE_IF interface
>    qapi: add local migration parameter
>    virtio-net: support local migration of backend
>    net/tap: support local migration with virtio-net
>    tests/functional: add skipWithoutSudo() decorator
>    tests/functional: add test_tap_migration
> 
>   hw/core/machine.c                             |   2 +
>   hw/net/virtio-net.c                           |  89 +++-
>   include/hw/virtio/virtio-net.h                |   1 +
>   include/migration/misc.h                      |   2 +
>   include/migration/vmstate.h                   |   2 +
>   include/net/net.h                             |   9 +
>   include/net/tap.h                             |   2 +
>   migration/options.c                           |  18 +-
>   net/net.c                                     |  14 +-
>   net/tap.c                                     | 429 +++++++++++++---
>   qapi/migration.json                           |  12 +-
>   qapi/net.json                                 |  20 +-
>   tests/functional/qemu_test/decorators.py      |  16 +
>   tests/functional/x86_64/meson.build           |   1 +
>   tests/functional/x86_64/test_tap_migration.py | 458 ++++++++++++++++++
>   15 files changed, 986 insertions(+), 89 deletions(-)
>   create mode 100755 tests/functional/x86_64/test_tap_migration.py

I have a few more thoughts related to the ongoing discussions with Peter 
and Fabiano which I will reply to in the relevant threads.


ATB,

Mark.


