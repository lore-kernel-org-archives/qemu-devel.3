Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 51BD4C61DD6
	for <qemu-devel@archiver.kernel.org>; Tue,  1 Sep 2026 08:36:47 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1x1JyV-0001ku-Iw; Tue, 01 Sep 2026 04:36:11 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <lucas.kornicki@nutanix.com>)
 id 1x1JyR-0001k3-JL
 for qemu-devel@nongnu.org; Tue, 01 Sep 2026 04:36:08 -0400
Received: from mx0b-002c1b01.pphosted.com ([148.163.155.12])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <lucas.kornicki@nutanix.com>)
 id 1x1JyM-0005CY-P9
 for qemu-devel@nongnu.org; Tue, 01 Sep 2026 04:36:06 -0400
Received: from pps.filterd (m0127841.ppops.net [127.0.0.1])
 by mx0b-002c1b01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 68178dJ21827550; Tue, 1 Sep 2026 01:35:59 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nutanix.com; h=
 cc:content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=
 proofpoint20171006; bh=63eE2o5b00bQSGwL/HQqIQWKQlw8a/zPFHfe2H/8r
 vU=; b=kqBJJ8sfSm07/VPM9MGGp5fnAv6ErmKN4HNRe4sy2CWFPqHTx1vHsw5pl
 5Be5Vzd+4xgBy3YJI8b4VlPnkwv3omPEJrBwHgRntbpT6kdn+O2ud+6nZMdR27Ul
 4jejLjfJFYatWP5mNWuYA/IA0IXF4bkmAmStYfdJ88Xcx3oIH7poAlAMeNYdhm8A
 Rfu3J+d7BYYX1wNm8rkUvn8hC7OzWXLsRNHjZgdblrpwFXCytccMHBat6HmgYe0z
 8zBoO4sq2KlHXsWFNg/+jLsIXTDGS7q9gZfmDP97wM+kFSz2BcUIDNPOwRrzySC8
 fPqPT7ImzHdDK9NATKYUUeqCh2c4w==
Received: from bl0pr03cu003.outbound.protection.outlook.com
 (mail-eastusazon11022124.outbound.protection.outlook.com [52.101.53.124])
 by mx0b-002c1b01.pphosted.com (PPS) with ESMTPS id 4gdhhxhawh-1
 (version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NOT);
 Tue, 01 Sep 2026 01:35:58 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=UnZLGPupSzc4nP6sab2Ifurblc9cOHDBMiXVtA3jQbgcacL5FQu6xsjCGb8jdt96sZVmOLSymziZaA/VEYLVFNQllPizQj/WT5oFUr7jzkHkCbJGfUR3kyNOs2hqZInQ3SV5Nrtg8QMSoWLkIQz5FZ4se3UxoYEWeSK4vlQ5A/RJbTVD8/GzEUSy1XDUdCXLLTyzOeOOyRNFDuvNGSNecQSFh9gHoBZXUtMw3VuGTRxp0bJT2pYRxsc3kjx2J6z2H84lVqEKoFGN1fmC0afmpEjiuFqH8I9jRU4Gm6s7tUkg848ackjL3CfTsXWjGLiIq9kuG8oaL1ut7kRAoFMqLA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=63eE2o5b00bQSGwL/HQqIQWKQlw8a/zPFHfe2H/8rvU=;
 b=tvZ/L9NXqEUIVKtH2JbVpHoQV1vO/2rONWI2OT/8KacHK+ke7aWzbyO6bon2Rxv+v4H51QajwUy5nr1za4bN9MKla51MWprxiwENAiAqJ5id3YNxaG9osrxGS9vMdo8SLauJ7RtpuEdRk77X0P2scq5KgGNYGP6i7ga11zgrLy7z/NTFLl0wHDlWKmuA8fIqNXCEaWJW2buoXxbsUx+7RS48rIZB12HT+xAtM+ZCXqiMlmdxCqF3djD2lAhlZaT9tTC8AbAXllJDGw3GG2JGy3sjo523eRKzJYxiKoJ8QTbkLPDoVeOTWvn9tg9infcJehVGBUp3i2g0ZGaTl5zlJg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nutanix.com; dmarc=pass action=none header.from=nutanix.com;
 dkim=pass header.d=nutanix.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nutanix.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=63eE2o5b00bQSGwL/HQqIQWKQlw8a/zPFHfe2H/8rvU=;
 b=OTXlGrrld1GgiMkqZvcQK+5DpSs5PiLPevn1HY42c41P5fuJozLjzYyitF6SsC+5B97F/qc/91Cc893Fq3e8Um12KDSKOcWsBsED2n9hpt1TuFfd+gprmkLZ8iPgI8ypsOyBxmO7d8acxQYNqPaQrVJnWQC93Cp4br1Lv0SfmytHh7bTTPXxuON3n2XJA7yELn4/aFb0O2AJk1ypYI+YupOyVshS/ZA49kZY3s8KUX3Gty/42vsJj3IUa0ekySbz5F2V2neRit1l+mh/Hb/QfqI2JfgW7sbD0NCNKFG+NSTEaJGIEbVfXh/6dVueFZDbO4YYyL8MGTwwsF0zqMMX9A==
Received: from BL0PR02MB3827.namprd02.prod.outlook.com (2603:10b6:207:42::26)
 by LV6PR02MB12097.namprd02.prod.outlook.com (2603:10b6:408:425::24)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.360.13; Tue, 1 Sep
 2026 08:35:57 +0000
Received: from BL0PR02MB3827.namprd02.prod.outlook.com
 ([fe80::5f5f:bb6:29f7:afd]) by BL0PR02MB3827.namprd02.prod.outlook.com
 ([fe80::5f5f:bb6:29f7:afd%4]) with mapi id 15.21.0360.008; Tue, 1 Sep 2026
 08:35:56 +0000
Message-ID: <736df70e-6833-4480-9d9c-eb72b966f6be@nutanix.com>
Date: Tue, 1 Sep 2026 10:35:53 +0200
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 4/4] ui/vnc: notify client of clipboard peer status
To: =?UTF-8?Q?Marc-Andr=C3=A9_Lureau?= <marcandre.lureau@redhat.com>
Cc: qemu-devel@nongnu.org
References: <20260818121413.2660786-1-lucas.kornicki@nutanix.com>
 <20260818121413.2660786-5-lucas.kornicki@nutanix.com>
 <CAJ+F1CKuDAzTz2iC+acOKf2j1vW3iFE6jinTKL=AwWCu3-1KGg@mail.gmail.com>
 <43d32e1c-ae73-4863-87a5-98c2f6ee5fe0@nutanix.com>
 <CAJ+F1CL_Z2C_k5_40VT9P6t80Z56YBObQ1fiQpW3t_nO0h1JWg@mail.gmail.com>
Content-Language: en-US
From: Lucas Kornicki <lucas.kornicki@nutanix.com>
In-Reply-To: <CAJ+F1CL_Z2C_k5_40VT9P6t80Z56YBObQ1fiQpW3t_nO0h1JWg@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: VIYP296CA0003.AUTP296.PROD.OUTLOOK.COM
 (2603:10a6:800:29d::9) To BL0PR02MB3827.namprd02.prod.outlook.com
 (2603:10b6:207:42::26)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BL0PR02MB3827:EE_|LV6PR02MB12097:EE_
X-MS-Office365-Filtering-Correlation-Id: 7c96d665-d950-403d-11ac-08df08040b00
x-proofpoint-crosstenant: true
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|1800799024|366016|23010399003|376014|3023799007|22082099003|18002099003|56012099006|6133799003|4143699003|10067099003;
X-Microsoft-Antispam-Message-Info: cVKn790eAiD70RgtBeDNmfMAmXrz1NeA2s/D1UJ+2XUzNNMhVu/fTlUsZoxO0ZtbEE4mhLTo+8ZoALp5ad2UfDC0AOVyUaDTZJkSUYZhxE9GIIStI1ex6pDAOe6V2vV/jCrSkapHC2DXyq5EgeX+xLKxkYAIgGNadl/dLkyasmMaKdnCWjsmYG/n4iRk6UkCcnmCB8zVukryuJZH7xawrsWUkkn7I5Zk1uPo3Q/M65rU74N6IM46HxEU+AupPgaU61nfqITOSR0nyefbeXKgdclegnJOyiSS4d1yIietNKAqbLjGZyl+v3RrNILNxevXT7TSABRDvLEz+a6x1Q1aZA6oqNmsiOPQ6+nhd9UaSCT+8XApHWLAHGKtJonlvlrUu/3Q/vl6Zr65FAaTEVs/wqdSrdzEeyEh4+Z+D3c1sq7Oiaqvlm12nTJybIy++A2Ud81TJ1WS1apkCNoKzEwFlIoOv7ptCnmbNpPnr9IwICGQi4la1cFmWLnMXC3ROjSgt+rZP4xVfDQ4XCU6Xm39ErEoAg+f2gSlFsNdXWLf96c47Stg+v7RWgo09z91I2tGOoeXJY/9UR8XcY9756DWu8kgDCvI43HqDZOlQraQZnRfk+y6uDEelNDD24I1a43D3wxUMJ5/iW/q9wwec2FSHuW6QUat1xG2fBCHy749A6o=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:BL0PR02MB3827.namprd02.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(1800799024)(366016)(23010399003)(376014)(3023799007)(22082099003)(18002099003)(56012099006)(6133799003)(4143699003)(10067099003);
 DIR:OUT; SFP:1102; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?ZEY5WXEyeW1NOHA4eTZLa1ZuYllDdmNSSmc5ayswRyt2d2tudW44bFBzRVJY?=
 =?utf-8?B?M2F6enpVU3ZjaGZhczE0b0NFQkVHRkE2Zlo5dmhCeC9VZUhYN2dtKytBeGpC?=
 =?utf-8?B?Y0svVTdmY2ZLa0J5a2pESWhYZmxsRlQybGJKdm9NMW4rcmJMNUZ0TkR4Ujhm?=
 =?utf-8?B?VXBKR2tLL1MvZ3Q5R2tsQVdkYnRvNWMwWnhSNmc0ZlNVMVg2NituNGliV3F1?=
 =?utf-8?B?bExBeGNpeEFIRklsWEFoN2lNSEdBOFdXWTBDdk14aFV0ejhxajRRU3RQd3lY?=
 =?utf-8?B?Z0dFQktnNWVCNW53YTJJSndWNVpWcU5RdmJWNU1ZeDBUT2JRbnlPbU5LdTl6?=
 =?utf-8?B?SHd6RE8xc2JOTkttUldRNmY2OU1kTkNaek4yNCt0ZDdOS3l1ZGI3QXBWSFFs?=
 =?utf-8?B?djNXL2VZSUJWWC9pNUhrNFVaN0ZvUG5zQ1Vic1BWa3VKUEpmVWxkWnBKRm9K?=
 =?utf-8?B?UG1kV2ZvMytMYWVTdVpkTTBBVENDY1ppR0VUdzZkYVFzRVJSazh4Yk9YdnB5?=
 =?utf-8?B?N3JBaGZ4a3ZybEtjUlVUUVpPdFlTanFVejFFYVZXSnpzaitkc2dQdCtVSEs1?=
 =?utf-8?B?aUI3aW80V0huaDRuOTNyNjE1eFRIUU1RbWpaSFVzSzJFcldQeEZYK2VFQjFy?=
 =?utf-8?B?Ny91U04xcC9STFdHa3hZaWJoTzRtamVNTGFJbHQ5V3dKRHpvM2RiNzBpaXFY?=
 =?utf-8?B?ZUEwblNGVWRmYTJwSzZ3VTFTYmxxVkFacHhyU0UzV1hKQ1F6WjlMcDZiSEJL?=
 =?utf-8?B?S1dUVDdacVF1b0tjdnMwSFlJRjZaelhqRlRmZXNoQzk3K1NLc251U1JCTUVk?=
 =?utf-8?B?NlIrQ1FRYnlucVliQ0ZzMktHSDNKVklsb3RzaUNJVTF2U2hSVTlueUNFbjhi?=
 =?utf-8?B?NFRvSG8xemlmdXFrcmM0bStDWVhYRlNtcTFyWjRaQ1pjYk80WlhWUU5wYnhO?=
 =?utf-8?B?TzE4d0E2d2dSMk10NEtJcS9PYWphWEluRzI3dG92RE5DeXpzSzdUZjhJaGNv?=
 =?utf-8?B?NXVVUUdSUWhvbXk4ZHhrek9GNkpPNkVXRXFRdkFORnRibE4rWlhYN0NWRE5P?=
 =?utf-8?B?OUViK2dMVHRKUUtYRk1NbFVPL1ZrOFJmcGt0cE5HNGlONTVzYzQ4L0VybGEx?=
 =?utf-8?B?SU01bmZXUEJWWkx4c0ROczZ1M0ZLSUREUmp0UCtMb0ZYRWRkUVluQVA2bk5Q?=
 =?utf-8?B?VndTYWNNK1RnZklpM1Nab1FmenZzV3hxNFN2VjV5aDljdEdod1U0Q2tZTkxY?=
 =?utf-8?B?SitHRTVmUmJ0alhYRmg1N1NCNW1Jc0gxNC9tZ2VzRnYxUWJwb2QydnJOSDlv?=
 =?utf-8?B?b1dGenhEMHhtWGpkY1Q1dkVrZXJTdmllV2ZIWUtXWG15QmUwbVdXeDNQWlBK?=
 =?utf-8?B?OUxwMkFvOFp6M3VONlFBRFZ3eXpjaTY2ZUF4Z3RvVS9IRmYrdnVSZDFHWlRW?=
 =?utf-8?B?ZnJ3Zkp2SkVJVzRyMTJhWmlHcU9wcnJMUm1LNjRrOGRYdHdOc3ZsVE42cnhu?=
 =?utf-8?B?UFBPb25ubzJHZEZ3WkJXQ1NUN1RvT0RhM2FGbmRJZTE1d0huTFFaVGNheXZl?=
 =?utf-8?B?V2VNdlBwZWJpYWp3OTROdjZITmRjUHAwamdoWS9IeTk2R05vaDcyc3JUTWJm?=
 =?utf-8?B?V0hpUkpmNTlBWUJIYjg2bmprMUxZdjZmS0ZibkxkVTlJaHQvb1gwT1hmYmsz?=
 =?utf-8?B?ajR4SHV4YU1WblNydWFsKzlCbU53dmk2Tm5JUmpEVHRUWTQ1empIVUt0NU1P?=
 =?utf-8?B?aElicnBHVm9CYVd6dURnZjJhTWl6N09taVRVQ2NGMEtuQkhUdy9GKzhwTkha?=
 =?utf-8?B?NU9tNEdNMmNvNTdvWCtRWGpVcThIdHo4SnBHUjNxQWt2QUtEVFBpdWh4V2Fa?=
 =?utf-8?B?Zm83TkIxUVU0NWdla3NMcFFJVk5wNElBQ29RMVQxM1dPRGJqSFlnbWZ1UkNN?=
 =?utf-8?B?OVZ3b1NmS2swWVVoZjRzVmxYQVNIbXBJcHZaSysvZlJ5U1FZQ25nMVJseStu?=
 =?utf-8?B?ckdNaTZJQi9oeWd1eDhjZGU3NDdMZWxETUsvb3VpR0hKN3JEYmplYWpJZThr?=
 =?utf-8?B?QkJ1NWxhWjBTanRGU3hoQUo4RzE1RGY2d2U4WVVHdnJsMUtVZG1qRGRqZHM5?=
 =?utf-8?B?QVljNUk5M3NML05xWmxmeTVHeVl3eDJRWURPRlUxbHA5bUxpK09IWFpLQjY0?=
 =?utf-8?B?NjVkemo5aTU2R003NUxETXpwYWNXVWQzU3BVaDFuQWd5RFVoY1E3c3l0VTl1?=
 =?utf-8?B?Skc5aGplQ09WSW9oY2ZqdHdVMEJWa0NUUE10UjF1bHBXeFIzaUJNSGtqZ0J1?=
 =?utf-8?B?cTl4RGZGK2lrcERCRzF6aGhiTGVLZUVkKzJTTUpLNFZzd1RxYXRGcjJOYktK?=
 =?utf-8?Q?FN/K7YHO4AXp0OVI=3D?=
X-Exchange-RoutingPolicyChecked: HY6SMiZvIHpbJO+/LqIvDRI/crZSrHsc9SfHZ9JA3gLxNgYPJXmScQDDvr2E1e4E9Et8fhYpjCHL0/dkvhfmhTZ5V1v5pYhkjWMrPRGD5QU/kEJOCOW3lGoBqXNkUw2o2qozlwj0LrzyR0gFtVOgtCH9maabVraMHOT+IAP9IoQAgLOI6OOfgaFaMSwpJESgo2MZrsuO5zS3Lj1eppmHxsF+toDhG5hsJgBWNSG05OEYsPsRbAuDB8U5zrb+n/DzbWHYtIqJdhOya1xFQs3A+OMxQKVRM/GDU2K4wINJPAtrWljflOsUImS/mj0tmLJinuJG8ja3ynwQaIbL1BNC2A==
X-OriginatorOrg: nutanix.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 7c96d665-d950-403d-11ac-08df08040b00
X-MS-Exchange-CrossTenant-AuthSource: BL0PR02MB3827.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 01 Sep 2026 08:35:56.8654 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: bb047546-786f-4de1-bd75-24e5b6f79043
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: vvYwcR9j74xrGdatNkVYh4A21miT2CQ0fPsklOne0jylBsrWb9O2S55I56L+z7HXmtLUDcdImmTLHugi9aSJz8+azKmhsCNLtDjiApC9Zxc=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: LV6PR02MB12097
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwOTAxMDA3NSBTYWx0ZWRfXxzNkhoG9u4ah
 SDn5PozRadF4qFFv6kslJlTvRTI3250nPMkKImy3iZmmtPwQlcM7KJLSIJSQwpsYj2Q8WqVvxQO
 CFhdjVDBiky2WvCGOAbjIXqnn9ig858H0olVHRvVrrmoZnF9vueT/GETiZq5EVyofxWc4xrkL07
 qWEafsCCvhx257lOU4urLZ+4KlnzLLebJX0iBmeoFZazTEnddKlToD9zFd7Q1LmNxZAOPOn19ZE
 5drDpumUTWF3SlItnsa8uKpXr/kt4gl7DtyhB9tit/+Hxor5YhrEKNdSBOXCokURBmPnpW3tDbO
 6z4qr+X+gvyRp8/iQ6+/ZYesjbJ2tqjEJZsWHJHlW61oQPmPFQ//QYkpF4PdmwsgPY99fhYahZp
 5RE7Oei0K3H2d2nrlYUn5/f/vNgPqO0sp2h7hX8IVmgG1o3xBVyQKlvKONQYM7HviYyZQ9pbiVq
 Ad1L1TAn+sgBZF2tOHg==
X-Proofpoint-ORIG-GUID: xSrC7GxBusFm8gzMj9z7E5qSAh5psFLv
X-Proofpoint-Spam-Info: AW1haW4tMjYwOTAxMDA3NSBTYWx0ZWRfX2AX4dzQJuVSc
 IFkR5+PyHMClF1z8xRoFXtQtf9gSHexSbaox2Pm8AtgFIGZ1kfqWEKOK22ozN/ZcxDlE9IVivv7
 3kEbZ08wXNdq7etFPgDk0yIS1rfoFj0=
X-Proofpoint-GUID: xSrC7GxBusFm8gzMj9z7E5qSAh5psFLv
X-Authority-Analysis: v=2.4 cv=S6HpBosP c=1 sm=1 tr=0 ts=6a968e6e cx=c_pps
 a=Z+wCPMcgC1Y9moSb1l8pUA==:117 a=6eWqkTHjU83fiwn7nKZWdM+Sl24=:19
 a=z/mQ4Ysz8XfWz/Q5cLBRGdckG28=:19 a=lCpzRmAYbLLaTzLvsPZ7Mbvzbb8=:19
 a=xqWC_Br6kY4A:10 a=IkcTkHD0fZMA:10 a=VdqzKS8jKosA:10 a=0kUYKlekyDsA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=VofLwUrZ8Iiv6rRUPXIb:22 a=jxMXjlTPpCISP5mWtjnE:22
 a=64Cc0HZtAAAA:8 a=WPDSxMP2Y5Ft-Yw_FPAA:9 a=3ZKOabzyN94A:10 a=QEXdDO2ut3YA:10
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-09-01_02,2026-08-31_01,2025-10-01_01
X-Proofpoint-Spam-Reason: safe
Received-SPF: pass client-ip=148.163.155.12;
 envelope-from=lucas.kornicki@nutanix.com; helo=mx0b-002c1b01.pphosted.com
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

On 8/24/26 14:36, Marc-André Lureau wrote:

> !-------------------------------------------------------------------|
>    CAUTION: External Email
>
> |-------------------------------------------------------------------!
>
> Hi
>
> On Tue, Aug 18, 2026 at 5:56 PM Lucas Kornicki
> <lucas.kornicki@nutanix.com> wrote:
>> Hi Marc-Andre
>>
>> I quickly became aware of the shortcomings of my v1 series and I've
>> already drafted a v2 where the cover is a bit more detailed and the
>> commits were fixed to remove the Change-IDs.
>>
>> On 8/18/26 15:33, Marc-André Lureau wrote:
>>> !-------------------------------------------------------------------|
>>>     CAUTION: External Email
>>>
>>> |-------------------------------------------------------------------!
>>>
>>> Hi Lukasz
>>>
>>> On Tue, Aug 18, 2026 at 4:15 PM Lukasz Kornicki
>>> <lucas.kornicki@nutanix.com> wrote:
>>>> Introduce a new vnc message (VNC_MSG_SERVER_QEMU_CLIPBOARD_STATUS) and
>>>> the corresponding feature/encoding.
>>>>
>>>> When a client requests this feature, the server will inform the client
>>>> whether a guest clipboard peer is present. The server will repeat the
>>>> notification each time availability of a guest clipboard peer changes.
>>>>
>>>> This change enables the VNC client to determine if a guest side
>>>> clipboard peer is available for clipboard exchange and react to
>>>> changes of its availability.
>>>>
>>>> Until now the VNC clipboard peer was only registered when
>>>> VNC_FEATURE_CLIPBOARD_EXT was enabled. With this change the VNC peer
>>>> can be registered just for the purpose of receiving peer status
>>>> updates. This requires introducing a VNC_FEATURE_CLIPBOARD_EXT guard
>>>> before the QEMU_CLIPBOARD_UPDATE_INFO handler which previously only ran
>>>> if VNC_FEATURE_CLIPBOARD_EXT was enabled.
>>>>
>>> The series looks good, but this extension is not documented afaict.
>>> Can you make a PR for it?
>> Sure. I've found this repo before but was not aware that it functions in
>> any official capacity.
> I dont think we should take the change until the rfbproto documents it.
Hi. Just a heads up but this might take some more time as I'm having 
trouble convincing legal to allow contribution to rfbproto since it has 
no license. Hopefully this will be resolved soon.
> thanks
>
>>>> Change-Id: Id0897a24fae103288c399f73e808ed6c07018359
>>> What is this? Is it a gerrit thing?
>> Yes, I forgot to remove the commit-msg hook and they got regenerated
>> right after I removed them :)
>>>> Signed-off-by: Lukasz Kornicki <lucas.kornicki@nutanix.com>
>>>> ---
>>>>    ui/trace-events    |  1 +
>>>>    ui/vnc-clipboard.c | 31 ++++++++++++++++++++++++++++++-
>>>>    ui/vnc.c           |  6 ++++++
>>>>    ui/vnc.h           |  8 ++++++++
>>>>    4 files changed, 45 insertions(+), 1 deletion(-)
>>>>
>>>> diff --git a/ui/trace-events b/ui/trace-events
>>>> index 917d116d90..d2fe153b7d 100644
>>>> --- a/ui/trace-events
>>>> +++ b/ui/trace-events
>>>> @@ -48,6 +48,7 @@ vnc_msg_server_ext_desktop_resize(void *state, void *ioc, int width, int height,
>>>>    vnc_msg_client_audio_enable(void *state, void *ioc) "VNC client msg audio enable state=%p ioc=%p"
>>>>    vnc_msg_client_audio_disable(void *state, void *ioc) "VNC client msg audio disable state=%p ioc=%p"
>>>>    vnc_msg_client_audio_format(void *state, void *ioc, int fmt, int channels, int freq) "VNC client msg audio format state=%p ioc=%p fmt=%d channels=%d freq=%d"
>>>> +vnc_clipboard_peer_status_send(void *state, bool present) "VNC server clipboard peer status state=%p present=%d"
>>>>    vnc_msg_client_cut_text(void *state, void *ioc, int len) "VNC client msg cut text state=%p ioc=%p len=%u"
>>>>    vnc_msg_client_cut_text_ext(void *state, void *ioc, int len, int flags) "VNC client msg cut text state=%p ioc=%p len=%u flags=%u"
>>>>    vnc_msg_client_ext_key_event(void *state, void *ioc, int down, int sym, int keycode) "VNC client msg ext key event state=%p ioc=%p down=%u sym=%u keycode=%u"
>>>> diff --git a/ui/vnc-clipboard.c b/ui/vnc-clipboard.c
>>>> index 67f710f6ed..4ecc4489e4 100644
>>>> --- a/ui/vnc-clipboard.c
>>>> +++ b/ui/vnc-clipboard.c
>>>> @@ -26,6 +26,7 @@
>>>>    #include "qemu/error-report.h"
>>>>    #include "vnc.h"
>>>>    #include "vnc-jobs.h"
>>>> +#include "trace.h"
>>>>
>>>>    static uint8_t *inflate_buffer(uint8_t *in, uint32_t in_len, uint32_t *size)
>>>>    {
>>>> @@ -224,6 +225,23 @@ static void vnc_clipboard_update_info(VncState *vs, QemuClipboardInfo *info)
>>>>        }
>>>>    }
>>>>
>>>> +void vnc_clipboard_peer_status_send(VncState *vs, bool present)
>>>> +{
>>>> +    if (!vnc_has_feature(vs, VNC_FEATURE_CLIPBOARD_STATUS)) {
>>>> +        return;
>>>> +    }
>>>> +
>>>> +    trace_vnc_clipboard_peer_status_send(vs, present);
>>>> +
>>>> +    vnc_lock_output(vs);
>>>> +    vnc_write_u8(vs, VNC_MSG_SERVER_QEMU);
>>>> +    vnc_write_u8(vs, VNC_MSG_SERVER_QEMU_CLIPBOARD_STATUS);
>>>> +    vnc_write_u16(vs, present ? VNC_CLIPBOARD_PEER_PRESENT
>>>> +                              : VNC_CLIPBOARD_PEER_ABSENT);
>>>> +    vnc_unlock_output(vs);
>>>> +    vnc_flush(vs);
>>>> +}
>>>> +
>>>>    static void vnc_clipboard_notify(Notifier *notifier, void *data)
>>>>    {
>>>>        VncState *vs = container_of(notifier, VncState, cbpeer.notifier);
>>>> @@ -231,13 +249,24 @@ static void vnc_clipboard_notify(Notifier *notifier, void *data)
>>>>
>>>>        switch (notify->type) {
>>>>        case QEMU_CLIPBOARD_UPDATE_INFO:
>>>> +        /* ignore the update if client does not want ext messages */
>>>> +        if (!vnc_has_feature(vs, VNC_FEATURE_CLIPBOARD_EXT)) {
>>>> +            return;
>>>> +        }
>>>> +
>>>>            vnc_clipboard_update_info(vs, notify->info);
>>>>            return;
>>>>        case QEMU_CLIPBOARD_RESET_SERIAL:
>>>>            /* ignore */
>>>>            return;
>>>>        case QEMU_CLIPBOARD_PEER_UPDATE:
>>>> -        /* ignore */
>>>> +        /* only guest side peers affect the status we relay to the client */
>>>> +        if (!notify->peer_update.peer->guest) {
>>>> +            return;
>>>> +        }
>>>> +
>>>> +        vnc_clipboard_peer_status_send(vs,
>>>> +            qemu_clipboard_guest_peer_present());
>>>>            return;
>>>>        }
>>>>    }
>>>> diff --git a/ui/vnc.c b/ui/vnc.c
>>>> index 656768f9c9..9e44a20311 100644
>>>> --- a/ui/vnc.c
>>>> +++ b/ui/vnc.c
>>>> @@ -2191,6 +2191,12 @@ static void set_encodings(VncState *vs, int32_t *encodings, size_t n_encodings)
>>>>                vnc_set_feature(vs, VNC_FEATURE_CLIPBOARD_EXT);
>>>>                vnc_server_cut_text_caps(vs);
>>>>                break;
>>>> +        case VNC_ENCODING_CLIPBOARD_STATUS:
>>>> +            vnc_set_feature(vs, VNC_FEATURE_CLIPBOARD_STATUS);
>>>> +            vnc_clipboard_peer_register(vs);
>>>> +            vnc_clipboard_peer_status_send(vs,
>>>> +                qemu_clipboard_guest_peer_present());
>>>> +            break;
>>>>            case VNC_ENCODING_COMPRESSLEVEL0 ... VNC_ENCODING_COMPRESSLEVEL0 + 9:
>>>>                vc->worker.tight.compression = (enc & 0x0F);
>>>>                break;
>>>> diff --git a/ui/vnc.h b/ui/vnc.h
>>>> index d8b0070396..6e8fa66e9c 100644
>>>> --- a/ui/vnc.h
>>>> +++ b/ui/vnc.h
>>>> @@ -422,6 +422,7 @@ enum {
>>>>    #define VNC_ENCODING_DESKTOP_RESIZE_EXT   0XFFFFFECC /* -308 */
>>>>    #define VNC_ENCODING_XVP                  0XFFFFFECB /* -309 */
>>>>    #define VNC_ENCODING_ALPHA_CURSOR         0XFFFFFEC6 /* -314 */
>>>> +#define VNC_ENCODING_CLIPBOARD_STATUS     0XFFFFFEC5 /* -315 */
>>>>    #define VNC_ENCODING_WMVi                 0x574D5669
>>>>    #define VNC_ENCODING_CLIPBOARD_EXT        0xc0a1e5ce
>>>>
>>>> @@ -466,6 +467,7 @@ enum VncFeatures {
>>>>        VNC_FEATURE_LED_STATE,
>>>>        VNC_FEATURE_XVP,
>>>>        VNC_FEATURE_CLIPBOARD_EXT,
>>>> +    VNC_FEATURE_CLIPBOARD_STATUS,
>>>>        VNC_FEATURE_AUDIO,
>>>>    };
>>>>
>>>> @@ -507,6 +509,7 @@ enum VncFeatures {
>>>>
>>>>    /* QEMU server -> client message IDs */
>>>>    #define VNC_MSG_SERVER_QEMU_AUDIO                 1
>>>> +#define VNC_MSG_SERVER_QEMU_CLIPBOARD_STATUS      2
>>>>
>>>>
>>>>
>>>> @@ -541,6 +544,10 @@ enum VncFeatures {
>>>>    #define VNC_CLIPBOARD_NOTIFY   (1 << 27)
>>>>    #define VNC_CLIPBOARD_PROVIDE  (1 << 28)
>>>>
>>>> +/* guest side clipboard peer status */
>>>> +#define VNC_CLIPBOARD_PEER_ABSENT  0
>>>> +#define VNC_CLIPBOARD_PEER_PRESENT 1
>>>> +
>>>>    VncDisplay *vnc_display_new(const char *id, Error **errp);
>>>>    void vnc_display_free(VncDisplay *vd);
>>>>
>>>> @@ -637,6 +644,7 @@ void vnc_zrle_clear(VncWorker *worker);
>>>>
>>>>    /* vnc-clipboard.c */
>>>>    void vnc_clipboard_peer_register(VncState *vs);
>>>> +void vnc_clipboard_peer_status_send(VncState *vs, bool present);
>>>>    void vnc_server_cut_text_caps(VncState *vs);
>>>>    void vnc_client_cut_text(VncState *vs, size_t len, uint8_t *text);
>>>>    void vnc_client_cut_text_ext(VncState *vs, int32_t len, uint32_t flags, uint8_t *data);
>>>> --
>>>> 2.43.0
>>>>
>>>>

