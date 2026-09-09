Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 569B9C79F8C
	for <qemu-devel@archiver.kernel.org>; Wed,  9 Sep 2026 10:43:07 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1x4Fle-0002I9-NU; Wed, 09 Sep 2026 06:43:02 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mark.caveayland@nutanix.com>)
 id 1x4Flb-0002HZ-Kn
 for qemu-devel@nongnu.org; Wed, 09 Sep 2026 06:42:59 -0400
Received: from mx0a-002c1b01.pphosted.com ([148.163.151.68])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mark.caveayland@nutanix.com>)
 id 1x4FlY-0002ZZ-Qn
 for qemu-devel@nongnu.org; Wed, 09 Sep 2026 06:42:58 -0400
Received: from pps.filterd (m0127840.ppops.net [127.0.0.1])
 by mx0a-002c1b01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 689AUreP4148474; Wed, 9 Sep 2026 03:42:46 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nutanix.com; h=
 cc:content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=
 proofpoint20171006; bh=U/TDEizvZYaJCXvathxFIvxhyyoaUfMwjeWJxM4wO
 0Y=; b=Xik6T2eXpsX3mtH6zBAqw0dCDgq1t9LejpBcGvY6sQu2VqG/ulskW8NHK
 vCCP961hRtm1p97n4B82NovWOWQbHKi/TBCdfdZOodT3Ve2ReqAW4f1WP0m0fJQW
 7fq+I+Yk5YJL9ViaYFOASofdqCucNd8i3hQFp8riAV47bE0DTv3fC9D9D/A6yO64
 P4pDr6G2jTTwcdseSOTE2mQHXxjYH9cbD6IeZV2Hb0O3uUJQ7JR/xJUoLdDPGTK0
 FE/yaT4k1TM4DabLB9oFDYMvZCVb+VF0zIM59KkXWh7JhRV54WVHQ6eRSP6P7FPR
 aO/yTjM1OO4xK6Ok+fxPS3CFPiE+w==
Received: from sn4pr2101cu001.outbound.protection.outlook.com
 (mail-southcentralusazon11022143.outbound.protection.outlook.com
 [40.93.195.143])
 by mx0a-002c1b01.pphosted.com (PPS) with ESMTPS id 4gjdcgumst-1
 (version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NOT);
 Wed, 09 Sep 2026 03:42:46 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=XQM6iCsmJ0A7rIw/DpfM5dY7vlo47+ERuQXaOTXawXOUBVALwZOv1BlR7wKgUUpNFhB7vNkdCTAPmtPnNE85PTnXgbqf+g2/jbJUlKaB5LCDSqssjcjDvEWcfa2Kx7571lhTasa6H+nGL92GB1XTmQ2c5j6vFXBEHKT0qLSbWcfaoQBToL68lSv4OFIru0++UlQnnYX2l8RDzciXxeAxeVWHJSTK3okyVjj5bbdxKIdD1PXDDrBCfrWidI5s1veQoz67XoAv09MFRD4BuDRpMWwY40DKHhUSDpEgn4VlXdfudZvQrN1LzHMEBiIqLhr6fhciMF225JkViMUSdje6Xw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=U/TDEizvZYaJCXvathxFIvxhyyoaUfMwjeWJxM4wO0Y=;
 b=TzK+Y7g9JFjkr3FUOk7xD5gbPBvLbSu3GeUyOnTkXsDH+vNkNqyNE65EFoo4urKu4xwQvGE2ynTdxZpqP92NJTSrssaf/V7BC9CMqvDsJqE/VUm93vQsQVrcnGqvIYON8V2UNlrOCl/PzS9L3akbR/dPRUnvx/GBuVXtTpn9yfvdILYqKjj9C7O85/q3KYMnyrDtNFgmAp63OEHSCdw2F5RtLOyPD5moWoWJ/wYTk0MvOFBkQRkMnKCtvyK1cy2tqgXKA0fiZIJz/5y5ZcVUhi4DYmZ+pcf//fTZWGWenSatd+Npc8rCAlDjWq1DqXETgK5qjeN/x1YmmK2MTUvjaQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nutanix.com; dmarc=pass action=none header.from=nutanix.com;
 dkim=pass header.d=nutanix.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nutanix.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=U/TDEizvZYaJCXvathxFIvxhyyoaUfMwjeWJxM4wO0Y=;
 b=NOAsJfcl/P+oGEVnGRDzsd5YoM0TaVuVLFOJ6tXX+/An4NbWz2U+NZYYtpwjf8/LqPEkFBofphBF/navgoiWeS3JGO9MMUamf/rgWvvSr/RDqD4jizXh3duFL+VAlp7DyIGc7e4x/IUGy4KVM515BkpHYnMTbtWxE8/l8wuLY9+py/tKZkgTus8D50RFsz8sclMTjWgXGQ9wjdWkAGs8tFbORUtMNI7lO2cKqEezUTm4xd4BNvTVasNctK5LvA9E3RyqmfVe3KkO+7eEXnaULTnb6fWb/HcQywaYN3bV04FLk5/VCpL+paBTRQE4gKY2g6NeVOZOnaMY0eNkjlYWYw==
Received: from PH0PR02MB7159.namprd02.prod.outlook.com (2603:10b6:510:16::8)
 by CO6PR02MB7556.namprd02.prod.outlook.com (2603:10b6:303:a1::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.406.8; Wed, 9 Sep 2026
 10:42:43 +0000
Received: from PH0PR02MB7159.namprd02.prod.outlook.com
 ([fe80::8e97:bc32:822c:b250]) by PH0PR02MB7159.namprd02.prod.outlook.com
 ([fe80::8e97:bc32:822c:b250%3]) with mapi id 15.21.0406.007; Wed, 9 Sep 2026
 10:42:43 +0000
Message-ID: <49e94859-4924-440f-9582-6848b5e7573d@nutanix.com>
Date: Wed, 9 Sep 2026 11:42:39 +0100
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] docs: bump sphinx_rtd_theme pin to fix --enable-docs build
To: Peter Maydell <peter.maydell@linaro.org>
Cc: Brian Cain <brian.cain@oss.qualcomm.com>, qemu-devel@nongnu.org,
 Mauro Carvalho Chehab <mchehab+huawei@kernel.org>,
 =?UTF-8?Q?Alex_Benn=C3=A9e?= <alex.bennee@linaro.org>,
 John Snow <jsnow@redhat.com>, Paolo Bonzini <pbonzini@redhat.com>,
 Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>
References: <20260906222926.3714852-1-brian.cain@oss.qualcomm.com>
 <762d160e-974a-47d4-8f0a-6cd7f6a4c0b5@nutanix.com>
 <CAFEAcA-cTaqgDi3NTiqZVvU+iNA4udw6umoAFHFk=raXmxvhBQ@mail.gmail.com>
Content-Language: en-US
From: Mark Cave-Ayland <mark.caveayland@nutanix.com>
In-Reply-To: <CAFEAcA-cTaqgDi3NTiqZVvU+iNA4udw6umoAFHFk=raXmxvhBQ@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: LO4P123CA0294.GBRP123.PROD.OUTLOOK.COM
 (2603:10a6:600:196::11) To PH0PR02MB7159.namprd02.prod.outlook.com
 (2603:10b6:510:16::8)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH0PR02MB7159:EE_|CO6PR02MB7556:EE_
X-MS-Office365-Filtering-Correlation-Id: 03b9fea0-090d-4fd6-1c17-08df0e5f146b
x-proofpoint-crosstenant: true
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|366016|1800799024|23010399003|376014|10067099003|18002099003|22082099003|4143699003|56012099006;
X-Microsoft-Antispam-Message-Info: /UPSRflbjr1epTVBwggPPnuu5v1Fk6Df6lslb3/DoMBBwyEmwNAbFyeIJZ2wz0NikITXrJShAZHLPZ6KHYJ4OICEa5gxYthT7d7uaok+RO/Al8rloZj64Dbo77nfNIiM8th8GUNNmm6YTc2D60r7GtAVWKEmvsxc/QnZfGtcDrbs4kVk8XFoJHYngMSO6ov1AUk2Kt97lbJrIeIRAZxXDj9TRUjhB24OmvH+1u25qba99sR9qNqp3IzroNDfJ8DMYc9gHIlOmjIfDHsJjTukC+RLcjOa90nfi2fUZXMxXXjCug+in37qE1o91yAudtWpKG69v7ycuBPhPxkpwBX5m47vAh0g1EnCOnLeXw2/eH8a8/N7R0fjIRFNasHO1huIni2ReYdJpZVeKFNiNlUVNOGE6lwoAX3LBs1ev5sldZci1j40aQNSAteK/3kT77BRpkAGDutKc4tDIvPVUS+IvqEtnJ54PKKvqqzEK0uNMxLxohRiZeY5a5UV/j23Vj+WckiKiGatMDqOJM789NYXa9d5WX6RR/VVZNnOk6n+UHPjlN93srmfK2gLSzKLeoINU/eeJ3AC33PKD6HhcpsEeM5MwWw7pIcp9+1ITGO1iAzsDn9Kk5GoSY9t1u32YN/CIe2TdF3BQl2RI8KFMLRqXQz4H6jxLl2i9NU23sGAWSI=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:PH0PR02MB7159.namprd02.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(366016)(1800799024)(23010399003)(376014)(10067099003)(18002099003)(22082099003)(4143699003)(56012099006);
 DIR:OUT; SFP:1102; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?OHBKb0dtSEJ2OXNDTXh6Q3ZUTm9nc2tkVWx4ayttNWpURE5GYS9yTXExZjU5?=
 =?utf-8?B?bkthSGs0aDNBVWtya0ZVYy9teUlBSGF4bktSeGJpamQxMjJCMUxVdWcrVXRT?=
 =?utf-8?B?ZENjQ3U4bytWeFhsRi94RVRNN2xtMG5iOWJVVWs4K2V0T1J1RVFvTm9hRzZV?=
 =?utf-8?B?UDZjaCs3TWlYSlhwbmJDdEVaNUJwYTE5dzRad05OK2dqNVJ5NUlsZy9BczZp?=
 =?utf-8?B?NGt3cEZOaWU4U2dNWEp6MURLbkUwNDBwNGJQZXRvUFp0NDJiaU02ZFdYV3JO?=
 =?utf-8?B?a3lUdHE1S0dBenlRZ09GR1k0TTU3ZXhrUlpuQW4vZXpNTGdLblgyUSs2UGRP?=
 =?utf-8?B?Y1N6KzZRTXV3ay9jL3dBTjcvTWpqR0pRTjZUNDBBOSt0R1Rmc2lsaGF1KzlN?=
 =?utf-8?B?RFZxV050dmdOMlE0bERwbXNUdHZPSnNlRVcvZlQzU05RR0FWdC95MWlxa2U1?=
 =?utf-8?B?LzAzbUdVZzJEWDNINzJ2by9hdmgzb2Roc0hBN2JFRWZpWnJoZFFCYmo4ZDVI?=
 =?utf-8?B?R2JCZk4wM2dlbWdpNm5RRXZ4d1JSSFBIQnkrM1RMQjJiQ0Z1VmN5RDlFU3VW?=
 =?utf-8?B?a3l3TGlLL1dSMEpWbG0wc2h1cUdPa2RrajU4aGIzUzZSQ0huaHA5OHJ1UWt6?=
 =?utf-8?B?WXRyRDJOMUU3dVJYM0d3cWpyZjhYcllaeU8wNUpnaitkRVpXNzRHUVNhR0l2?=
 =?utf-8?B?aGVuUU1uVVlXVXd1aUY1UEhvc3hLRlFZSGkvaEZxRTdhWkdKVEdkMXVTOGFO?=
 =?utf-8?B?bUducU53TDQ5KzMyNlZZcDc0eGwyOUhqZ2ZQamtBUyt0TjZjZTNSMXpDQis0?=
 =?utf-8?B?ME95dVFPdlNSS28xM2c5NDlLV2hJU2lydUYwbGphb2QxYkt4UHV5NWVsMXRG?=
 =?utf-8?B?aStheXJxZDBHUjNpVDB4Ky81UTNkcWVXcWpwaUF4Z0ppWHdBV1NzVjNIQi9t?=
 =?utf-8?B?QVNadWdVWEtuQzdpZUQvM3lFODRSaTRWa3EzYkl5Njc3NytJQTBoVkUwbXQx?=
 =?utf-8?B?V1k1aGRJTjNVa2h4RDQxcVREWmdULzUrUGdqem5MemdiRHFJOXVud2libktY?=
 =?utf-8?B?b3NDajU4UG1iNC9BMWhELzZmdmFvbjdwZldGUWVjR2tzUHBUdFI4dm5rUENY?=
 =?utf-8?B?QVhOYk9MR2FCNWpEdVJXd0lNSWFZeEtpQW5hZXdSK1o0M2JmcXdaQ3BzaCtJ?=
 =?utf-8?B?NFM3bzhPZHlpSWlWWWRFbWlGT1NaSklmWWZVOWpFakh6dWlSZDliZ0R6VFRL?=
 =?utf-8?B?TkJDUkRWYmhIME9kdmR4Lzd5NVRuVTVXN1pXSUFQTXE3QWRPd3ZFb0J6S2oz?=
 =?utf-8?B?TVBjbisyZVYydnNFSWN4UWtUNU04dUNKUU50alBjSWh1MGZIa3hTK05SOWtU?=
 =?utf-8?B?Mnh6c01DdFEvVCtMUGI3UU16MjFvdHdyRkJzb09Ndk9wTXgzRmFuM2t5RWJD?=
 =?utf-8?B?TU8zR1dRc0o3aURQRmxuVzcwM1VGYmZ5SmxPVGRENzFOMkYvQXZYczZMTlVL?=
 =?utf-8?B?QjdBaW1Hdk9jNUdiOXV0cWNFaEFIR1pqSk16Y0dzbGtpTU5VQVNyMWdmcis5?=
 =?utf-8?B?ei85cXF2YXlCVTBXOVBwTE5GSEc4NnhYbVowcm0zNGdFNmxKVXlKWnlaV2lT?=
 =?utf-8?B?NDZuNWRtZ3N1dGpqZkswanh3b20yNGJ4dVMzOHhYclc1UHExU0lORVdMN09t?=
 =?utf-8?B?MlpoTmNqMThrQkpHL3pGL1BhOUt1S2tJenRTQlF4STJ3ZDFzRUg5ZXpvVkNj?=
 =?utf-8?B?VlNFTjFDUW1SR2dkcVN4Z1p6SDQ0TkVxWUlqTDFoUC9Ra3FFMmtLdUlJb1Qr?=
 =?utf-8?B?Zy9WTC9lV0FpUThWbzRTTjRmNHB4VE52R1RKZ3ZPbzZqYk5VcStnajl5UU9N?=
 =?utf-8?B?d3JQUmg2OElZNW1iKzhUa0tpMnhxeVlGWUgzRWJKZFNyckdSVDVCWnhxeG41?=
 =?utf-8?B?d3hGZjlIRXJXYnFydE9idEdyeUVYcGppOWczZE1ic1hWemorZFZ1M1YyYUw3?=
 =?utf-8?B?WGlNSVlRVzlLWThsa3dPdnRhWTZBUWNlQUsraGV4RG01ODhCWGx5aFJZSk0w?=
 =?utf-8?B?SHlzSEN0L0dLRGFpeGhOaGNkcy9mQWJiOTlUUWtPWGo0c2hPN3lTeFZ4QWFj?=
 =?utf-8?B?L2s5cGJwaURKR00vUHA3RTZLWjFmQjhUTldwV1RiZzZ6b1g2NWQzRDJ2ck5C?=
 =?utf-8?B?V2dCWDVCUW5WOXQyYmJ1QzNmQU5FeUhXUkNsaFEzbjBtSk1tREJXSVAvdTFE?=
 =?utf-8?B?UUlxOWZScnphdHZjMEx2WTJMQ1pvMVlSWm5mdnpMNllxUGN5ZzVRYnk1U2lu?=
 =?utf-8?B?dmhyRE5KT0FIZC9iTkhVNjdiNFZ6WWUrNjhDVjBjN25ibmpVTUVCTkZPODBP?=
 =?utf-8?Q?Q8ZLs6ksSDjmjtdY=3D?=
X-Exchange-RoutingPolicyChecked: vtjQcv365xecfgvpJfu4eEXIpWZQHlV+eB4uZp5c11qGkwtAdbAQstqQ4nBNzl0t8omdAhdvBOmXFIVVRelGsGGI99X6BV7+kSB/y8xIf6HJ5Av5Mzq76pH8phoxWEMhm4hGZdlOXoJ/qWfnTLR7emzor5ZJuG+qu2VRR+XEgOBcuPUeIsON/fmRtEQIAKEACf/o3PghyGmtc6xxPMOiQUTf+C8Sb9aSZHImwedkmy8bWhNKiUzaTrHFhoCaJrulmeI54hJaEMiTY+ZFi6+L8QCrWfaDgEJhXf0rRZeBADydsL2V1R6xwwV8gcqnqidIkLKfoO3pZK8x1rin+ayX4Q==
X-OriginatorOrg: nutanix.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 03b9fea0-090d-4fd6-1c17-08df0e5f146b
X-MS-Exchange-CrossTenant-AuthSource: PH0PR02MB7159.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 09 Sep 2026 10:42:43.8954 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: bb047546-786f-4de1-bd75-24e5b6f79043
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 54d3j0Ykz9/jn6BeArHlgIuqwuaSbU698aG0X7sfxjOfj6PHTqtci6CsSqKdZTKAsGAKuc+szxoTHgYHB/UE/K1V+t5mzbvl3r/7/5lJwWg=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CO6PR02MB7556
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwOTA5MDExOSBTYWx0ZWRfX/iF/KHVRL8MB
 tYJySPi8nHycpWwQweAgrTSq3zb3piL2pXn9lu8d5p/50LGt74XmSTIDGuHSK0aBq1tXbG233N+
 yHkU0LiMGV7WotzRFsE9m+pb+nI8w2qkXGANjN1pv+Zh2YsRdFzra2J4sUWY532xDhjXWTtj34z
 kb/AjWpp8qvgsyM2imCAgAo3Bjh9LpzDxnZhENkkRshmWJa/aJYkISQiiwDwViPF+GplHwRK2B7
 +KW3icwVwjm77+nE/JyNL+xaYLd/y/pr0G3ntmuyLxCDh+u0cj8rnPMe/xU8Z4dZKtmHXwMkxVJ
 EyPygaJeNKbKHLjQkELOV8sMOUyh7vArsfnnXh6sGssBLhGLzu3criQvR4rTUu74bLGZWWKbYuI
 QQESOW73hM6Gb6VHBW3X21keYprfvVIP1ujg4kHdZhSJnO6s8eVFxd+jfHRmbgR2IFP8x8k/D2W
 1dM6sXMLWC/noXVfH3w==
X-Authority-Analysis: v=2.4 cv=N+QZ0W9B c=1 sm=1 tr=0 ts=6aa13826 cx=c_pps
 a=ZgU9I8B0O1PKiENeC86Haw==:117 a=6eWqkTHjU83fiwn7nKZWdM+Sl24=:19
 a=z/mQ4Ysz8XfWz/Q5cLBRGdckG28=:19 a=lCpzRmAYbLLaTzLvsPZ7Mbvzbb8=:19
 a=xqWC_Br6kY4A:10 a=IkcTkHD0fZMA:10 a=VdqzKS8jKosA:10 a=0kUYKlekyDsA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=VofLwUrZ8Iiv6rRUPXIb:22 a=_-M8LpHI31CeLmyZm6wg:22
 a=64Cc0HZtAAAA:8 a=EUspDBNiAAAA:8 a=dcdBhupplw5_RlWrpwAA:9 a=QEXdDO2ut3YA:10
X-Proofpoint-GUID: qp0gLx8NAMhGOIMV2uWWUqmd6sJ2871z
X-Proofpoint-ORIG-GUID: qp0gLx8NAMhGOIMV2uWWUqmd6sJ2871z
X-Proofpoint-Spam-Info: AW1haW4tMjYwOTA5MDExOSBTYWx0ZWRfX4gyvry04MwfK
 H172jRofXdr/7q//K5ZvwwKiH8g3vcnyXxHe8/4m3827RGACXtiHi3iUrE/j9iWmvtnOLiRtoo4
 J7m9LCtKlaO44WGct6YxgS6cgfgR4dc=
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-09-08_03,2026-09-08_03,2025-10-01_01
X-Proofpoint-Spam-Reason: safe
Received-SPF: pass client-ip=148.163.151.68;
 envelope-from=mark.caveayland@nutanix.com; helo=mx0a-002c1b01.pphosted.com
X-Spam_score_int: -27
X-Spam_score: -2.8
X-Spam_bar: --
X-Spam_report: (-2.8 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
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

On 09/09/2026 11:00, Peter Maydell wrote:

> On Wed, 9 Sept 2026 at 10:56, Mark Cave-Ayland
> <mark.caveayland@nutanix.com> wrote:
>>
>> On 06/09/2026 23:29, Brian Cain wrote:
>>
>>> pythondeps.toml and docs/requirements.txt pin sphinx==7.2.6 alongside
>>> sphinx_rtd_theme==1.2.2, but 1.2.2 requires sphinx<7 on PyPI.
>>>
>>> A fresh install of the docs group silently downgrades Sphinx to 6.2.1 to
>>> satisfy that cap, which then fails Sphinx's own >=7.2.6 runtime check
>>> in docs/meson.build.
>>>
>>> sphinx_rtd_theme==2.0.0 is the first release that drops the sphinx<7 cap
>>> and resolves cleanly against sphinx==7.2.6.
>>>
>>> Signed-off-by: Brian Cain <brian.cain@oss.qualcomm.com>
>>> ---
>>>    docs/requirements.txt | 2 +-
>>>    pythondeps.toml       | 2 +-
>>>    2 files changed, 2 insertions(+), 2 deletions(-)
>>>
>>> diff --git a/docs/requirements.txt b/docs/requirements.txt
>>> index c10c4cf7c91..509d56bd1e8 100644
>>> --- a/docs/requirements.txt
>>> +++ b/docs/requirements.txt
>>> @@ -2,4 +2,4 @@
>>>    # Should be in sync with the "installed" key of pythondeps.toml
>>>
>>>    sphinx==7.2.6
>>> -sphinx_rtd_theme==1.2.2
>>> +sphinx_rtd_theme==2.0.0
>>> diff --git a/pythondeps.toml b/pythondeps.toml
>>> index e4c10d4a9f7..afb1364dd28 100644
>>> --- a/pythondeps.toml
>>> +++ b/pythondeps.toml
>>> @@ -29,7 +29,7 @@ meson = { accepted = ">=1.12.0", installed = "1.12.0", canary = "meson" }
>>>    [docs]
>>>    # Please keep the installed versions in sync with docs/requirements.txt
>>>    sphinx = { accepted = ">=7.2.6", installed = "7.2.6", canary = "sphinx-build" }
>>> -sphinx_rtd_theme = { accepted = ">=1.2.2", installed = "1.2.2" }
>>> +sphinx_rtd_theme = { accepted = ">=1.2.2", installed = "2.0.0" }
>>>
>>>    # This test group is for dependencies required to run various tooling
>>>    # and tests that should always be installed at configure time. It should
>>
>> Reviewed-by: Mark Cave-Ayland <mark.caveayland@nutanix.com>
>>
>> It would be good to get this queued to master soon as my local
>> development setup is currently broken (particularly as I'm working on
>> series that include documentation changes).
> 
> I've now applied this to master as a buildfix; thanks.
Thanks Peter!


ATB,

Mark.


