Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 53EAECD6E6C
	for <qemu-devel@archiver.kernel.org>; Wed,  3 Jun 2026 15:27:59 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wUnVI-0000qf-VY; Wed, 03 Jun 2026 11:27:37 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mark.caveayland@nutanix.com>)
 id 1wUnVH-0000qD-0Z
 for qemu-devel@nongnu.org; Wed, 03 Jun 2026 11:27:35 -0400
Received: from mx0a-002c1b01.pphosted.com ([148.163.151.68])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mark.caveayland@nutanix.com>)
 id 1wUnVE-0005tt-By
 for qemu-devel@nongnu.org; Wed, 03 Jun 2026 11:27:34 -0400
Received: from pps.filterd (m0127840.ppops.net [127.0.0.1])
 by mx0a-002c1b01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 653EFW1P4054723; Wed, 3 Jun 2026 08:27:29 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nutanix.com; h=
 cc:content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=
 proofpoint20171006; bh=EBdv6XdjbS6ORsE24vuq7H2F/H1kztDtYod5tN42M
 G4=; b=mthEjhrdBCSMItyD0aMV281j5DTXWWEyKV2IAEGuFZG2RYdEhWJKsobhJ
 IJx6C9rYGRa+W60L3e/nxp82JYBBsaJDWPkgj7DuzEdLiCPOw2q0ajx5sZ3sq7bI
 e0ClG6oc3BvbDRoCu34Gw/eYd/TklngXxjINMQdKqB5nkDEzNrRk6i1HE9+VVWr9
 Ke+OplgT3dYYV/JSvp1ClgcLSYezeCOtR0ZiRWF6dTKWCKgtk+3pZaFhLWnCyFfc
 047QciPbA6TrvIByH8jQW+P7UzYiB+I4Qj/LX8n1+yXcG4ntV0map2Fk4VoPzv3z
 fQvI/3vzUARv3PFIXEx3vO7LfxCWw==
Received: from cy3pr05cu001.outbound.protection.outlook.com
 (mail-westcentralusazon11023113.outbound.protection.outlook.com
 [40.93.201.113])
 by mx0a-002c1b01.pphosted.com (PPS) with ESMTPS id 4ej6g128hy-1
 (version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NOT);
 Wed, 03 Jun 2026 08:27:29 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=dk0yMvLA5XMQy+KKypAyYR/IJB2bhkkh1t+vY511HCdzfHm8+fB/P/LYWIoeDRkCNNmJ2KiYasQjk/NofbEK+YJ9jaJOFtliL2SqAmeqFURkM6nvihgEIKGDd+wzknL1ItNZYSOExJ1ZzZvMhf0nlt7z54gxipZE05aTvHkMlPRMD7p4w9J+pv30DogOILUecj7g9HnZccYDh3Fu5gBlXzWn2fKtJvTdKWSv3seZELVeWaM20YxRwqHsJBhc3KeXB1W4n0k2F1MMjA3ag0y8zvoAu4pDml+yuvjU5qAcJy1sDNRHAU5gFhqe4ZoCFvpVN5AnI+PDSLMB6v2flDgS1w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=EBdv6XdjbS6ORsE24vuq7H2F/H1kztDtYod5tN42MG4=;
 b=OQpmpHncl/XLcgRgGQz3uMdcgv/nQQDXuCGszuXaVlgsWDZEixHGWT0iEv9ZY8wZ72MdggBSCxY0FXKJ3XwHHHvHY37RkQ7RhGKvtf+FnLuHCHe14cacZe4Lbivk5Tbc3VzORCTb3ov1lSyFwllEyNGr8UYu9FvcOxEw0eSWcuTgSWYk0qcebEqRVbfQDlP8eHTnG/0hUpFr4QjRXRDIaXkce0DdBfsbl1a1DAL7calVyyGmCAYHO5so5ocNadO0g+mrgkWeGdma0BVLezUSpEQpmYyWXsUmOPVBR2geXUwX8xG8KLXedYESq/rZnBYPqVQz3Or06QuyphKEt6/RyQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nutanix.com; dmarc=pass action=none header.from=nutanix.com;
 dkim=pass header.d=nutanix.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nutanix.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=EBdv6XdjbS6ORsE24vuq7H2F/H1kztDtYod5tN42MG4=;
 b=TUExGC1ZNwOnw3s9VgvwHc8aY5mOhXRwdSET7bsaEn7QNxj8h+/1vy5Owftv+OMB6airdjj5r0j08xPnrNv5ST8nEVX8uMmVQKX5mdVJYZuW5mQbdieh7x/YgHJ6p8u223bAZZ+tdzO5aF2dSjmZniTIjapRSpnstyh6HFPdjbrvFx3EhnSE3g1lGyK6jajcdiw7mNikhYncaTpZ19PxFo4yIiieLiMqoVE0VyHi/ishF7d+r2+NJcFsrFUUWbhuNC1+UxxKaeGyC5IhYe+Yq6UmwVvhhum6mPXB6r3Nx7scf3+lq7JJJbvgv4yFFreEpi0e8uetMPdya7WwQnIjrg==
Received: from PH0PR02MB7159.namprd02.prod.outlook.com (2603:10b6:510:16::8)
 by PH0PR02MB7510.namprd02.prod.outlook.com (2603:10b6:510:4d::6) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.92.7; Wed, 3 Jun 2026
 15:27:26 +0000
Received: from PH0PR02MB7159.namprd02.prod.outlook.com
 ([fe80::8e97:bc32:822c:b250]) by PH0PR02MB7159.namprd02.prod.outlook.com
 ([fe80::8e97:bc32:822c:b250%3]) with mapi id 15.21.0092.006; Wed, 3 Jun 2026
 15:27:26 +0000
Message-ID: <10e159ec-3ead-4297-a24a-8e6f6029afb6@nutanix.com>
Date: Wed, 3 Jun 2026 16:27:20 +0100
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
X-ClientProxiedBy: CY5PR19CA0014.namprd19.prod.outlook.com
 (2603:10b6:930:15::18) To PH0PR02MB7159.namprd02.prod.outlook.com
 (2603:10b6:510:16::8)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH0PR02MB7159:EE_|PH0PR02MB7510:EE_
X-MS-Office365-Filtering-Correlation-Id: f9bfd141-d50a-48f5-4fb2-08dec1849dfb
x-proofpoint-crosstenant: true
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|1800799024|376014|7416014|366016|22082099003|6133799003|18002099003|3023799007|4143699003|56012099006;
X-Microsoft-Antispam-Message-Info: G0UGMxQ6KWAYHpFPnrivm4EKC6Z6cIL46YwT1Miv0LTTvbf3y+5M5ULPt+4LhGa+EgiYzY9CZEwGUnT8QGa5ZSdGa6olvAETD4XMJHTGFbVbfLZ8XhovnI8Ee9vZKV2O6iPnfG4HZn4iZylyO3o6UEP5RiE3sbP2KYCxdk++ynWvC577wuoylpMbO8H510RdPlNvywAFACtxmNkzF1p1l9Wl7XLXSvVi+RioTwSoU5lnFOqqc8i7Whfi5r43WpZAXD3NEvYfIc2UsdiYd/bazSu49leeQNT0dmhE5x1WEzvEuxGegrzR08i4DOiG9Vw36LSiM0vvCQryqGXr7yUcAhJ+lY6lSQ9BYW7gR8W3S21VuqmZLntFveVRbgYSjxw807upGUyu5pFu0adxhy/UDfQAuGXxtvJu+0GbZ1SptyaqPKSWSYoD/DgAFk5Mi744S7j5uuz5msheB4t/PQVQyA0cZjNDn4ujaRuuf3jatcO4k3BWNbs0TeSkmABs5W5ZVSDnZu913kWRhLLe3F7ma9Nmjbpb55xOh5H3FUGxFfrlrBNswwkJfX+Usw2aKsKaAoczirhaSkVvTntaJ+8HX8An8lCIDJwluOcvwnEyQ6wPhylS8Q48oyvYW4hkzDEi25/oow1KfIM77xnpgH0MKQ==
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:PH0PR02MB7159.namprd02.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(1800799024)(376014)(7416014)(366016)(22082099003)(6133799003)(18002099003)(3023799007)(4143699003)(56012099006);
 DIR:OUT; SFP:1102; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?V0tsUVo0azhaZnZrZjkzL1FVMDllb2ZzenU2Q09BclhUa21GcWQwN0RXOFYx?=
 =?utf-8?B?eW1idEJlU0d4K0x3MXR4SDBqZXBEY2JFMExnTHM4QzNCWjNxM0dEcC9Gdm92?=
 =?utf-8?B?RkVZQTBnTHlqZmpKU2hJS010L0QxY1c1eHBYSVJyajFuTU8zQlZGTk5BMDRw?=
 =?utf-8?B?dzdBalluYzB1V1Z3ZW8zckRzUkpGRkpuQkkvZWl3dG1JaU5ESFBKcVp6Uzhu?=
 =?utf-8?B?R1VMSUoxekVyR3B1dDVSYWMvV2NYNUlmRkU3dzVrd1o5bHFqSmZja2pXZzF2?=
 =?utf-8?B?aDlJM1Y1bzVyMWw5Z1grZEZ6QldpTHR2aFd5WmFMM2d2KzFSRnJVMVN1OHkw?=
 =?utf-8?B?SU9TTXZxbFlCcHVReFFyZ1RPZnNBeFVJaks2QmFmR0ZiL0l1RnhsTWc1bGpt?=
 =?utf-8?B?Mks0NC9uM01iTjBienpYaW5sbGlLeUphRXlTbldMQVE2NzFBZHc5VGNlLzJy?=
 =?utf-8?B?TDJmcHRNRm1kcVptcnZ6K29nUkE1SkJkdGhNeERDVVgwc3hCM2tNb0xIRjRI?=
 =?utf-8?B?Nm94NzJleHBMSnlvTVlibnNzeXc3MGZOdXIyZnRNdzVWTDlDVkpHZEZVK1FV?=
 =?utf-8?B?NjdqTTJzSHU4NVBDRVR1SU5oRklTS0FCVTI0Q0hLRCt0TjZsWkZBdnhNaFBD?=
 =?utf-8?B?akdTZ1dET2N2SUNjMERPZU9MR0pCam1INzBIalVXZE1BTVB1WlVERU9SbkFh?=
 =?utf-8?B?STFQU3NyT0J2K0JEMzJOR0dVSTdVMUg5OFEya0JUeEhiZkhzaGZiVFg2b3VU?=
 =?utf-8?B?TmRjc212VEoxVGNRajN6d1VMWE1ZZUVhQndwSmdTbkhxQWJGTkozazNvUjZj?=
 =?utf-8?B?VnNxSWdtM3k3bGlkSHNFb2lzekc5ZEJvV0R0d0RoVkVxT2hyV2txSHM3M2tL?=
 =?utf-8?B?dDFHL0d2dEs0RkhOek9reDBCVGMybzFKdWRKOGM3d21LU293eTR6WTAvY1Bw?=
 =?utf-8?B?SnlSdG5IUnc5MEt0NWs2Zi9rSkNwSktBUHVqZ04vYWFxRXRWRFQvK0w3QzNn?=
 =?utf-8?B?TjVQNnljdXNaMStFZkk4UTl4dTBBWVlpZmF0am1FYzJvQ1prdE5pTURORStY?=
 =?utf-8?B?WkxENXluRmVOajExYkowSTU5T1J6MkhLaXdhUTV0SVp3NjBmNnNhUTM5TFBM?=
 =?utf-8?B?NWVUdnU1YUg1Z1RZUE5TYXlTMWVHZUViTDlZd0xmcm84VU9VK0dPc1d3b1VC?=
 =?utf-8?B?L1dDMlVia0tRTTZOcGU0TXNYS2hMREI1Rm5pZWNZZmlDUUx2ZUtaK0lKWUlv?=
 =?utf-8?B?MHlVNzVnaGpmM3NlMWFpcmxoeVpjaG1adkQ1aVYxV0I1MTQxWFhzdUpvMWM2?=
 =?utf-8?B?UTYzM1pBSUZzbEFBS3U1MENkZVNrK1NMTnJLdlhUekQyZlptaFVkZlYzclVx?=
 =?utf-8?B?VW5OVkZKWnJ2UlFqVTg4VkVvN2VMY0dWYkMwM2RoQWlrWkhNK05xT2NDSGFO?=
 =?utf-8?B?RmpsRnNwSjhFOFlzNnRDVEJxeWp1di9sdml0VWtzczQ0anEvK3FSQXlJVm1j?=
 =?utf-8?B?cDdWcHkvMXVEdVN3RUJaVHVWK1kyQ3F0RWIyRGdPNGpmNldLbFlxQXVMUnky?=
 =?utf-8?B?ZlBDUjlyLzIvVnZCb0g0VXFvU1orTnpBdkJ4R2dFMmpQelkrR0pMT3h5WFI0?=
 =?utf-8?B?ZXVDNlRSb1NhUFZRcVBWemkvS3IrQVhUcFJQTmg1TDlxTXV4amo1Vk1ZbUtC?=
 =?utf-8?B?Z3Q2K1RuUytLbEdra1doS1V3OEZ2SUFEclpyU3p1Y21ra0kzOGhCcDVINnZz?=
 =?utf-8?B?ZldGZitGMHlBQU1Yb2JtNWxsL2E4UmFvNnp6cjVsY3BER0FqTnp2NEUvUEJU?=
 =?utf-8?B?c2ZiWE5mL0lLN01lZ24vclRPTUs5WE5qQTcwTDIrTmR2b1Z1UU9RVlhQNHV0?=
 =?utf-8?B?aG8wREUwUHlXMmZZYUs4ZHZ6c3p0U2F2WXRTZmJRRDNvZjRUb21TRkZRb1Vw?=
 =?utf-8?B?UmFuSGl4d1AyLzZMaXF5Qis2SWUrd0EzUnZUTWtuV3ZUZzZSZEhCS1ZwemNH?=
 =?utf-8?B?MWVRZGw4Q3NjMUEwNlRLeUZ5K1VrOVozVnBkVFJvWUs5eHY5Qk9Gd1NDcmp3?=
 =?utf-8?B?N3hEWnhWek1GOXNsNEpNU0ZpeHU3MUcyZ3JNT2dWcE5ZNVQ3WklDZXpnbFc1?=
 =?utf-8?B?OG5oK3V1UUhWOFZSVUdscmQ1ZzNzK0N4WXB1L0hhanR0N3ZSVjVPeklNd1Rh?=
 =?utf-8?B?TnU4cVZYUHREWitrOFZvaGM3U2R0U04vV2h6bEx2T254RStuMTdrSlRIN0JR?=
 =?utf-8?B?SFloR085d1pWRHlCdzRIMnFmTW9oQmJEQ2hnTVRhSHlHWHNmNHA4M0YydDVm?=
 =?utf-8?B?aU9GUyt1b3ppU1I4K0NrbDc4OVRVNnJoYlc3eW5OTzJoWEM3dDh6ZXQ3NEIy?=
 =?utf-8?Q?ntSuUBjLJuqBkz/U=3D?=
X-Exchange-RoutingPolicyChecked: UgR8WqWXRf34MZes0l80iPszEKCcZekbPfJ4hQSMHv5LdkQ91UxsQ7SA1IqmHG4PSSvLJeDV+TDAFxpPSyr/riN8rlFVWDRJIWAPU7YbhUC4K4GsDPxFRTUxQeEw+vwcFxCgj4UhPc6LXzuGlG3xnr/FQkiE1LnSBvLO6ElBkAP5kcBGpZ12pSTBQZJggL9a8Ci5ZvV6aLsRkk1Jo2dIe+inzurtZNVQRyu3SFNcmdUlpEM84sHKBKr8QTRf81abexGbdJpa4+lQTxgpCInKjrhgcAU8/LXCKcLQg/NlhSZQ26K54pJ5st0BZMyW3csp1vThNjRQRNY4WmiEIOV6mQ==
X-OriginatorOrg: nutanix.com
X-MS-Exchange-CrossTenant-Network-Message-Id: f9bfd141-d50a-48f5-4fb2-08dec1849dfb
X-MS-Exchange-CrossTenant-AuthSource: PH0PR02MB7159.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 03 Jun 2026 15:27:26.6588 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: bb047546-786f-4de1-bd75-24e5b6f79043
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 0aBDpan7lm3WjHM+mx/Ge2kLkhhL+EhecPxLvckh2R4UIu7m/M1opl4CFKmp5wD0DLDK+cf2QR6LIAmyk7o8SyP+js2AfxM/1lFqxgwLym8=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH0PR02MB7510
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNjAzMDE0OSBTYWx0ZWRfX5V3vsR837fcM
 UDWCEfpla/l2w5nfqloGV3QeuU57IYwmGfb0ylPj1/ggPrLwqNp9J+9YzIzJQo2kblQ3KAaGz5f
 4GKmtuaUvux1x/i1s/RFpkYv2NN0S9WMvKmbUY4duKs+ee0W5RpdKTFUomk5uk4bNOgyeikcxjy
 g23Q4VqdoCoudlIXG5fuVYe7x8WxOnFfgpg2LPk+W0VX4Z/aMwN417gRp+IBPmeLSTSroKhOPiP
 kQruBNMinN9m2K7Eq2m+No+AhfwHBLgZBQ/XHfFaQEKKCEEQYFwS7WQX9meXfxM1Kd525TtknqV
 tN/KDyp8BZNEl41v+loxZFt6f/25SNlQf6Vd1gba1GRqRXPD489+cEldhiUl5gKJ6srshylyYrG
 peOhiqpmb6UT0R1A7Tg3tJL6k1XawpwS8JmbZOhcDz1iq1YMLTFggfJeEHir1LDdmOR1wbn0/IK
 4ZWaQgfOUB2lP+3wOVg==
X-Authority-Analysis: v=2.4 cv=Roj16imK c=1 sm=1 tr=0 ts=6a2047e1 cx=c_pps
 a=zMw3/4lVTLt0/G0IafOnjQ==:117 a=6eWqkTHjU83fiwn7nKZWdM+Sl24=:19
 a=z/mQ4Ysz8XfWz/Q5cLBRGdckG28=:19 a=lCpzRmAYbLLaTzLvsPZ7Mbvzbb8=:19
 a=xqWC_Br6kY4A:10 a=IkcTkHD0fZMA:10 a=FelO9ux0wxsA:10 a=0kUYKlekyDsA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=VofLwUrZ8Iiv6rRUPXIb:22 a=_-M8LpHI31CeLmyZm6wg:22
 a=GaQpPoNlAAAA:8 a=wczX5d3niv5u62JxDFYA:9 a=QEXdDO2ut3YA:10
 a=xF5q_uoM5gZT5J3czcBi:22
X-Proofpoint-GUID: VRkqGaNNJC2QMqz7qV6GlhTR1pYvLGUU
X-Proofpoint-ORIG-GUID: VRkqGaNNJC2QMqz7qV6GlhTR1pYvLGUU
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

(cut)

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

Is this related to the series posted at 
https://patchew.org/QEMU/20251215220041.12657-1-farosas@suse.de/? What's 
the current status with this work?


ATB,

Mark.


