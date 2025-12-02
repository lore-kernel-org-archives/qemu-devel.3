Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0E1A4CFD376
	for <qemu-devel@archiver.kernel.org>; Tue,  2 Dec 2025 11:12:38 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vQOIh-0005KC-If; Tue, 02 Dec 2025 06:12:07 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mark.caveayland@nutanix.com>)
 id 1vQOIf-0005Jy-Nc
 for qemu-devel@nongnu.org; Tue, 02 Dec 2025 06:12:05 -0500
Received: from mx0b-002c1b01.pphosted.com ([148.163.155.12])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mark.caveayland@nutanix.com>)
 id 1vQOId-0005KU-D4
 for qemu-devel@nongnu.org; Tue, 02 Dec 2025 06:12:05 -0500
Received: from pps.filterd (m0127843.ppops.net [127.0.0.1])
 by mx0b-002c1b01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 5B27nTTU3711005; Tue, 2 Dec 2025 03:12:00 -0800
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nutanix.com; h=
 cc:content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=
 proofpoint20171006; bh=XqPCUX1uyqfoamCTVQgwX5LiIuQTtscG1tqG5pQ0G
 IA=; b=edwNuKFybcSVNSlUPSJPIVPqmoe//nTcUjVl2fgCvdHROh8XkT9IUsd4a
 YF5YjnpeVlCdaHXTq8cicadrCXzjGllTw9M4kynG4nQQc9bQ9EcT8fHsVR5gnrqz
 zsMSQVC2Zv8DoAixrOLDnoJwYJlflKebwyE995X2qLjaXeVJTF3Jmkg0x/oLs9/6
 I9xwOFO/FrxN7MR3S16r/gGhiCfLNqv3vfMpx02c0+ig4ZRZaC6dL80V0DcQiy/e
 R0YSvNk1F3NBPIzssx2QXYOS0sgyh9sIGRqrAV6DlzZ9xVuekG8ovUlkrTy9DzX0
 fq9Ysnf9njYRUNFOrQTkp7PuVG6TA==
Received: from bl0pr03cu003.outbound.protection.outlook.com
 (mail-eastusazon11022111.outbound.protection.outlook.com [52.101.53.111])
 by mx0b-002c1b01.pphosted.com (PPS) with ESMTPS id 4as9qxtuaq-1
 (version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NOT);
 Tue, 02 Dec 2025 03:12:00 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=BvH2h0U9Yck1ASPO6j9VpSwqQv+UfwA1cekTHsqWwmz6bDBnzvkOvzHGeKzJxWlCHPz9cJ9if0KZ/TF3m9jclJp8E8cXSHIXYnQiUAQxg1db8P9bCp9J+u+tjEl5t/4JQZyw8q1OYysjiGYbhcHKsUJw+ql1fB9e9hrHtOefg2hFY99RuQeJVc6yB44rPXcr13btmWSr0nCmUKvE/hCszZ6RC6bVzcuO2FkzRwlUfNyaJZygdBC6sgig/XtHW2BiOltbtLG2I4VLQxtTfjxUl4WHYWPt2IDAcu2P4MAxczoPqdMCAymS5f99GH4jA/JdKSJBawyBXQXSdeT4bWrfJQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=XqPCUX1uyqfoamCTVQgwX5LiIuQTtscG1tqG5pQ0GIA=;
 b=EB2wzKQ5cDJ/3DLQM4nSSBAI7fG2NFSkvOEz4pU2Fox2SNz4CzXUyWFet5a/i/wR8AuLlfgdza58tFpb4jT27hxTLtPvu4PdPCy1C1a94asiahefpJIMn4bMW0t3b8WNXJcGVlcMya7mztxaMdfIPsHpnqie4wiPIFY14VeBQTJF2hfkXjEOtqNiFEDRiH6ZJipZs4t0YnoozHOho4nPbCGiWzFKXZqGO8WRF+1wGBUEpy4yR6X7+Vcp/hfwwcPNytSBGHw+WyjNFT+oMRsLVekAxDBWK3NmvrVELSRXTGH7dkWl6E2OAlbKl9bQUePUBmWGYjP7rYyo9Qnc5Bf6Qw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nutanix.com; dmarc=pass action=none header.from=nutanix.com;
 dkim=pass header.d=nutanix.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nutanix.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=XqPCUX1uyqfoamCTVQgwX5LiIuQTtscG1tqG5pQ0GIA=;
 b=bDVUfLwDEnL4b2ooa3IW4cp3Nk21P9bahgyjL5+fOtlRz1xEpMjU4k/b6xPzdxf/j1wdvJTJBIf4e76nFyrjiW0A+b83QUgfF/1+uXTmly+OqyJ6j/L02AuuMMNlHCx8ANv5Gu3kcc8aJOnaqnQdobsmTHxR2cRxHHqnbVelxTBEfFoP/kYCjvsEoJ8wFkOh0MmRlWDQtbSFWEsr9uE5/jJjWkJCqo/FpLMzUQFOzo0HvzPg0YeoBNcnNmtGToE3Sv2/tj/px/MmzhLcJZzyIcotSPZJdwQYIwimjxosMWe4CiOwKMOnwZPbB7/fQhix5sigpXbHS9czWEMsyTShqw==
Received: from PH0PR02MB7159.namprd02.prod.outlook.com (2603:10b6:510:16::8)
 by DM6PR02MB6617.namprd02.prod.outlook.com (2603:10b6:5:221::24) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9388.9; Tue, 2 Dec
 2025 11:11:57 +0000
Received: from PH0PR02MB7159.namprd02.prod.outlook.com
 ([fe80::6cf9:b35c:b143:bb88]) by PH0PR02MB7159.namprd02.prod.outlook.com
 ([fe80::6cf9:b35c:b143:bb88%3]) with mapi id 15.20.9388.003; Tue, 2 Dec 2025
 11:11:57 +0000
Message-ID: <03d9e117-d25d-46ed-aba6-03c9a1139eff@nutanix.com>
Date: Tue, 2 Dec 2025 11:11:53 +0000
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3 4/5] vfio-user: simplify vfio_user_recv_one()
To: John Levon <john.levon@nutanix.com>, qemu-devel@nongnu.org
Cc: Thanos Makatos <thanos.makatos@nutanix.com>,
 Peter Maydell <peter.maydell@linaro.org>, =?UTF-8?Q?C=C3=A9dric_Le_Goater?=
 <clg@redhat.com>
References: <20251201095621.2786318-1-john.levon@nutanix.com>
 <20251201095621.2786318-5-john.levon@nutanix.com>
Content-Language: en-US
From: Mark Cave-Ayland <mark.caveayland@nutanix.com>
In-Reply-To: <20251201095621.2786318-5-john.levon@nutanix.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: LO4P302CA0023.GBRP302.PROD.OUTLOOK.COM
 (2603:10a6:600:2c1::15) To PH0PR02MB7159.namprd02.prod.outlook.com
 (2603:10b6:510:16::8)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH0PR02MB7159:EE_|DM6PR02MB6617:EE_
X-MS-Office365-Filtering-Correlation-Id: 65fa0de3-dc4d-43bc-aef1-08de31939ba2
x-proofpoint-crosstenant: true
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0; ARA:13230040|376014|366016|10070799003|1800799024;
X-Microsoft-Antispam-Message-Info: =?utf-8?B?UFRuek8zUDE4QWhvMG80cDN4ZCthTUg2MjlqQWN2V2c1L1o4dUIrOFJ5aUFy?=
 =?utf-8?B?Y243TmVkTFpaUzlTVE83ZUtnemtkaXN6N3N1d2FVWHUxbDFqaTMyQ0Q4MmJC?=
 =?utf-8?B?U3Jqbnc3cWM2bG9VVUlLSDJ6OVpiTS9ORWJKRUxZRURkV0FzT3FscGVnZkFh?=
 =?utf-8?B?Um1HRkxIYzdwOS9ucnBhclhXeEVKemlnODgxam9jM251aEQ4SGN6Y1YrVzQ3?=
 =?utf-8?B?cDF6NzlGMHRWNW5WZWR2cHZtd3lnVWNzbUg3amdFcFU1Kzd0NDc5R0JYQ2JH?=
 =?utf-8?B?UTdWdlJkV0FPVXdqenArNlBGdjltdGs2REtlc3R5SUZ5VHRGUU9JSGZIS3Mz?=
 =?utf-8?B?RUVaSWt1QncyQnhkbzVxWldOQzVjOHZtVGNiZXNIM2UwaVgvN0VETEQrY0Vy?=
 =?utf-8?B?ZzZMMmRaSXV0RWRQNFZSbXdZTkNvRlRibzJvVDRCNmRhSmpUQm9GdTB1UlJj?=
 =?utf-8?B?a21qOWZQSjlKTUFaRzZzRzhoajZXNFNyWldCWEoyTkswKytzcy8yVFg1NlBZ?=
 =?utf-8?B?QWs1NTZNRmRuOU9icS9ld0tnUFFsQ2FuNHZwb3ZsSWhRT3dldkQwcEI4SGU2?=
 =?utf-8?B?WmVQenB4SkYzTm9hQ2cvK1FHZGQ5Wkw3dTAxTVNUcE9iNk1rQ0N6cGpwby9J?=
 =?utf-8?B?Q3c5Zk1mcms4T0RXUjlrTllFOHk0dnV3NU9aaEdlMDgzcE5MbUJPcmQwekVR?=
 =?utf-8?B?SG5GcGxNY1c0Y204TWZQOWp1STZ3RnFHSEhwSWdWZEN2L1BrNGU1STFGVlZo?=
 =?utf-8?B?M1FKYTU3QWxORW1IZ2lnajF4U3RaMVFNV3k1WUdNNnNuMnpMOUpkQm9yUnZJ?=
 =?utf-8?B?NldrZ1RQZ0FZeEFrL2w2RWxIdmllWFJnODFVYlQvRHhEM0xsS2hTbm1xcUMz?=
 =?utf-8?B?S1R1NnZxem9DWTk4eHN3TGtLdFhtb0NVbitUVGVzM2krRUlrbkVmMHR0c21z?=
 =?utf-8?B?L3Q5YjdxdTlJQmlvcUZHMlIzUEFXZC9EbEE1WGxVbklrRENOalhWSHdIdVAr?=
 =?utf-8?B?L3lyTGhqUWxnTU4vb29DM1YrdmhqUFA0djFvUG1yVWpGR1hwK2VYSWx2SFht?=
 =?utf-8?B?OWJra3JCVjZlODJuZXhIMmJZYWIxWVVGUm1KcTcrVkdkOFF0YmVWNEpjYU50?=
 =?utf-8?B?bTNZV2wvSFZXUGdobm9NdStzMm1IZWRyTDk1SWNkR25paHU4QXpZMVRaL1Na?=
 =?utf-8?B?Rlp1ME15MzRUdW1mZTJ3Nzlvc1Z6VnAySEtzMWpsYnBsS1dOSmV0bkNlc0Fk?=
 =?utf-8?B?TXVlanl2Y3hmbGxURERvcUVNVS96S21aL3BNME51MWZIVFB3VkVyNFBRV3dz?=
 =?utf-8?B?c08xSXVnVmx6YVVzOTllNFhZdEdidDk5OXRPd0ZXYUhsYTVxTno3aXhjb1pi?=
 =?utf-8?B?NFBzOU5YUHBZNXR5Z3dwMUtOYmtTNDYwYWo4ODhwY1hHVnNLanZ2aUFETUxT?=
 =?utf-8?B?VHJ1aTJpdW1ucDJ2V2N5L3M4OWVWR1BZZklsSDNYdlNpb1ovL1ZiNm0rcGRj?=
 =?utf-8?B?c2lKL0FUMVVIaWQ4SitGV0FuL0ZnczVadDIvbEpMUm5OTmVXdEducmhTVWtk?=
 =?utf-8?B?T3dlTzV4V3laTTN4NytSR3NqY1ZTYXB0UzMxeXg2THZOK1BKZmR0VDBuK0xB?=
 =?utf-8?B?QWt4U3ZKWkMxeXR5SjhIR3ZCMGFnaGR4UXdZRXBwd21Vdi9WZjFZdkZLRHhJ?=
 =?utf-8?B?VWt6UkVOWm9PMTRDVEo4L090cVN4RUJrMnU4b3J0bDU4azlmTjZpenVZK3dI?=
 =?utf-8?B?enI3TGFVNkVZZjIxTHNRT0s2alA5Zi9vdG83eklMVStBWHM2dURySUN5UGhm?=
 =?utf-8?B?WW84akdSMTNXS3pyb1pPQ1RVSWN3WUQ0V2lnUmhVZ004Q3E5MDFwdlJTcytR?=
 =?utf-8?B?MWlpaXJ4RzRoTVovaGZlT05yQks1THZhZzFSdmpmc0QrS1lNZXNsaEtDY1NZ?=
 =?utf-8?Q?cmL+nCsYissQxwIq8jvpZSR++jBNbmo2?=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:PH0PR02MB7159.namprd02.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(376014)(366016)(10070799003)(1800799024); DIR:OUT; SFP:1102; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?ZmxjSnZKeWE5SzJEcmRYOUJUMVdQcVRsZ0N1b1REWThLcEZEOFY5M1gydWhH?=
 =?utf-8?B?UC8rRjk5dW8zeWpvODhlb3lWa3k5TUhacExEN2VZd3NpL3FhL0pKR3hVRWF4?=
 =?utf-8?B?TlZHYzVTUFVpcjE0Ylp0YUlBZ01kZ0RsTFlMaC9PQWh4THk2ZEtYRlQvS2dy?=
 =?utf-8?B?bG93enRZdW5qeXRzVXdYeUpJdWtkQW5mbzFwcEg0SWJsNnZna3dDbFNOK2py?=
 =?utf-8?B?cHZjZXZrdHNKOVdqUXR1THpQaDdJZjJDYlM5S1Ivc2sxQU1JdHBGejlPWmRL?=
 =?utf-8?B?TUdaZHRUWDJaVnRHTTBYWmZ5QytsZDJ2SEMyY0RsUGM3UndUL2wvakVrVmJS?=
 =?utf-8?B?WXRkRXd6dHJGeThyTnFhY09iNHcrQzhCRzZJVE42NjZIWFhsRXZLTDJsdzlT?=
 =?utf-8?B?VkNkcnhRTXUzVURpU1BQaFhSNDZaemZPNlBEaGg5NlUyTWRJS080VW1TK2RN?=
 =?utf-8?B?S0VwS2pacUwvTXoyNGRaNVpmT3hDRlJkZ1hnS1Y2N1RVWUFLWlhRaTlpMTZs?=
 =?utf-8?B?WlJWNkxQaFdBNlJuQ1V6RmY1anpZak1UdEZaNWp2ZDlmZnR2enFMZkpzY3lB?=
 =?utf-8?B?bmJTakNjNVdjWDExcjlvd29Nd0NYU0gvZTNnd1lmMVZZRFk5V3A0TXM1b1dZ?=
 =?utf-8?B?cGlpL1k5UnJKTEp6RUV1SUI1T1FwQkVMc1hXZWdnRWlSdUN4dE9Bc2Iza3Za?=
 =?utf-8?B?V201T0lGTVFIK05sMFBiMU9DaU1LbmZCWDZtMnlIZ3p1LzkxQTJIN2szRGtO?=
 =?utf-8?B?N2x4ODZrcWM5cnpJVFh0ZVJXOVFGcjY2K0VNQmxKYWExQVVxTytHMlZQOVRz?=
 =?utf-8?B?cHpaS0Fldzk3TmZkamM3czl5NU1Tbmk1Y09NK0xIdWRvQ2N3Ym9oR0xQN3Fa?=
 =?utf-8?B?anI3RkpEbmU4aHNKazJLd1dITkpIMVdIcG5sRmpFK0hESTZoYS94czMzdzND?=
 =?utf-8?B?VFF6K0FkZU80QUZOUU9namt6UkxsQmI2d2NHQTFuTEhSZDVWTDc3cEpYOWc4?=
 =?utf-8?B?aXFnZlFjeWdmdE5iMldGNDVLbnRRaHA1QnVFWGdKRXZwQ1VNWGxyVHRJOTRt?=
 =?utf-8?B?b05tMlcwTnE1RG5JN29SQlN5WnRpZGN0U2xXd3VnNE1pcnpJOU5yRTFXYlNP?=
 =?utf-8?B?ZUsxbmh5Tm5tOXlEbG5lc1hCRzdLb2xyd1RsaWhzNXEySXoraG1sZ3ZqbS9h?=
 =?utf-8?B?dGpCS2hlaXpTZ1dGSm1yN25NVFFkaThybTYwOHROb2h1cndaYjFQQ3N5Q000?=
 =?utf-8?B?YTVqWTBvWWVveTVjaGlLSk5FdGoxOTM3bVU4aEJRci84eEdTb2JxSS9xWWM1?=
 =?utf-8?B?N2lBZmtxS2psOXUzekk0aW9ZblU2aU95eW9wQm9DcjdIRWJZSHNNTGMrZ1JS?=
 =?utf-8?B?cVN0NW1COXF3ZWZXcmdhdGJPWEh1RTQ2QTlEMmtKek0rYlZtUEd3SkxiTEFx?=
 =?utf-8?B?SmQ1c2ticHNnNkxQcFp4RHZ3dWNFcFNvTUpmS3Vybmk1TjVna3dHeGZIYXZ2?=
 =?utf-8?B?ZitYSjIvR3p0ckZjdE1hcG01eFFEZWNCRmlWQkhuWkFLdWE5VUZqanhLenlr?=
 =?utf-8?B?NFpURVVQa2I1SDVFQVZtVm9WQUJZNkZiYmdwV2JiMHFwOTRBZHRDM0pwekpt?=
 =?utf-8?B?NUQ0UnQ1aWt2QWNZR2VLa0dYQTc2d3p1b21scGdtOTZxbUdwU3pFMmttcWV4?=
 =?utf-8?B?NTFjVDFSTDlUbXNCM1lGMzRqNTBObEhHaVNyZ1UvMHNyTElWUHFnV3ltTExx?=
 =?utf-8?B?T1cyZld0Z0xweFI2bE41V3VxVXB4NWNzeXZtTzZBa05WdXNYV3NwTVRqdWFG?=
 =?utf-8?B?em1PTDh4YWlxUDdXRXlCNFZpZ1pHTlpEc0FzZnI4d2dSTFplQmQzUVdQczFR?=
 =?utf-8?B?MjRTKzlydDhrOHBCZVJuekJIMnlSVU5oR3hlUTNyRXp1QnFjVkgwQm4xMDUx?=
 =?utf-8?B?RHZRcUN1UUdRdURVdFRKTEVPTkJCMFhDclY2RjMwTTNGL1pTbTREbVJjZ2NS?=
 =?utf-8?B?T3MzbGd5SUh6aEdYK0tjaXhrNEdYQkNiU3BLaWFPWFZvKzRZZVVHMTY4SzRk?=
 =?utf-8?B?MVNXTllpQWpndm9CQXpWcnJsSTVJUkdRWjJMRG9wRUtqQzJJQ3pTa2FOTllr?=
 =?utf-8?B?blZXNisrZlh5L0VTUHdtdmJBQnZwUEFvUjhhRHFZTHBQeTlxRUt0OWRiM1ky?=
 =?utf-8?B?Z011Z1VpZ3JpL2FRS0VCd2lpOHE3eXIwVWZUb21LWThBSlZwdDZNd3pLV2hs?=
 =?utf-8?B?UVFqMFV1bWVpWHZLM3d1R1Zzem13PT0=?=
X-OriginatorOrg: nutanix.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 65fa0de3-dc4d-43bc-aef1-08de31939ba2
X-MS-Exchange-CrossTenant-AuthSource: PH0PR02MB7159.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 02 Dec 2025 11:11:57.6338 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: bb047546-786f-4de1-bd75-24e5b6f79043
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 8RexVnXwIPm0RZDaiC4ZNvxL7b4dKC+Entoq6xm7YkiHB7E0TFSg5p5jRZFDPNv1n63GUIwq69KUxzA7zV5YDHnJneMaIUPH3cGWo7mTvuo=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR02MB6617
X-Authority-Analysis: v=2.4 cv=BLW+bVQG c=1 sm=1 tr=0 ts=692ec980 cx=c_pps
 a=EF3+7zrlrsiSedIMbKc+Bw==:117 a=6eWqkTHjU83fiwn7nKZWdM+Sl24=:19
 a=z/mQ4Ysz8XfWz/Q5cLBRGdckG28=:19 a=lCpzRmAYbLLaTzLvsPZ7Mbvzbb8=:19
 a=xqWC_Br6kY4A:10 a=IkcTkHD0fZMA:10 a=wP3pNCr1ah4A:10 a=0kUYKlekyDsA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=64Cc0HZtAAAA:8 a=qPPDYS9pmDejV-WtpJEA:9
 a=QEXdDO2ut3YA:10
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUxMjAyMDA4OSBTYWx0ZWRfX+5CwivinMhD+
 bHiZ0K9QEk/Zz9meeOhVAa4+IolTSfUAG9z/G2KePGbaEttHdZmh/Gxi3nGm5Fg0zP81L/1CFV+
 Nfj+i1lY7zaF8yOcZdsRXzVYoZmvI7ZquApaq1zaDhL4q/7HDdBPHXL3gz71+l92oN5JO/7B7Hd
 DjAktw0goZjCo6bvdm0XQFwzR56E3JTtn6AHQeni6N8yTvuUAmbtvcFmWKbLynvxPO4XzHpgWp4
 yywX+wyFXBLSe3i1KqrGnnxbDnaTWvfCYewLy0NkduVV7zVKlaXXVoOcll19hg5MiFyUM/h6law
 IPQ4C4bzFXNX4gh1rzA5rVyTGvbnJb+Qehh0LsIf0QnG7brdAFjuZBZZrFynFYZHq5yZ9Y0mVB0
 3cd8/ceDwvRuu4VYT0BYXZIs1I5sgA==
X-Proofpoint-ORIG-GUID: VYp1G_UIRP3pP1_JtflyX8-SDx_Tutem
X-Proofpoint-GUID: VYp1G_UIRP3pP1_JtflyX8-SDx_Tutem
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1121,Hydra:6.1.9,FMLib:17.12.100.49
 definitions=2025-12-01_01,2025-11-27_02,2025-10-01_01
X-Proofpoint-Spam-Reason: safe
Received-SPF: pass client-ip=148.163.155.12;
 envelope-from=mark.caveayland@nutanix.com; helo=mx0b-002c1b01.pphosted.com
X-Spam_score_int: -27
X-Spam_score: -2.8
X-Spam_bar: --
X-Spam_report: (-2.8 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_LOW=-0.7, RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001,
 RCVD_IN_VALIDITY_SAFE_BLOCKED=0.001, SPF_HELO_NONE=0.001,
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

On 01/12/2025 09:56, John Levon wrote:

> This function was unnecessarily difficult to understand due to the
> separate handling of request and reply messages. Use common code for
> both where we can.
> 
> Signed-off-by: John Levon <john.levon@nutanix.com>
> ---
>   hw/vfio-user/proxy.c | 68 +++++++++++++++++++-------------------------
>   1 file changed, 30 insertions(+), 38 deletions(-)
> 
> diff --git a/hw/vfio-user/proxy.c b/hw/vfio-user/proxy.c
> index 87e50501af..d1d63816b3 100644
> --- a/hw/vfio-user/proxy.c
> +++ b/hw/vfio-user/proxy.c
> @@ -281,15 +281,14 @@ static int vfio_user_recv_hdr(VFIOUserProxy *proxy, Error **errp,
>    */
>   static int vfio_user_recv_one(VFIOUserProxy *proxy, Error **errp)
>   {
> -    VFIOUserMsg *msg = NULL;
>       g_autofree int *fdp = NULL;
> -    VFIOUserFDs *reqfds;
> -    VFIOUserHdr hdr;
> +    VFIOUserMsg *msg = NULL;
>       bool isreply = false;
> -    int i, ret;
> -    size_t msgleft, numfds = 0;
> +    size_t msgleft = 0;
> +    size_t numfds = 0;
>       char *data = NULL;
> -    char *buf = NULL;
> +    VFIOUserHdr hdr;
> +    int i, ret;
>   
>       /*
>        * Complete any partial reads
> @@ -317,8 +316,8 @@ static int vfio_user_recv_one(VFIOUserProxy *proxy, Error **errp)
>       }
>   
>       /*
> -     * For replies, find the matching pending request.
> -     * For requests, reap incoming FDs.
> +     * Find the matching request if this is a reply, or initialize a new
> +     * server->client request.
>        */
>       if (isreply) {
>           QTAILQ_FOREACH(msg, &proxy->pending, next) {
> @@ -332,51 +331,44 @@ static int vfio_user_recv_one(VFIOUserProxy *proxy, Error **errp)
>           }
>           QTAILQ_REMOVE(&proxy->pending, msg, next);
>   
> -        /*
> -         * Process any received FDs
> -         */
> -        if (numfds != 0) {
> -            if (msg->fds == NULL || msg->fds->recv_fds < numfds) {
> -                error_setg(errp, "unexpected FDs");
> -                goto err;
> -            }
> -            msg->fds->recv_fds = numfds;
> -            memcpy(msg->fds->fds, fdp, numfds * sizeof(int));
> -        }
> -    } else {
> -        if (numfds != 0) {
> -            reqfds = vfio_user_getfds(numfds);
> -            memcpy(reqfds->fds, fdp, numfds * sizeof(int));
> -        } else {
> -            reqfds = NULL;
> -        }
> -    }
> -
> -    /*
> -     * Put the whole message into a single buffer.
> -     */
> -    if (isreply) {
>           if (hdr.size > msg->rsize) {
>               error_setg(errp, "reply larger than recv buffer");
>               goto err;
>           }
> -        *msg->hdr = hdr;
> -        data = (char *)msg->hdr + sizeof(hdr);
>       } else {
> +        void *buf;
> +
>           if (hdr.size > proxy->max_xfer_size + sizeof(VFIOUserDMARW)) {
>               error_setg(errp, "vfio_user_recv request larger than max");
>               goto err;
>           }
> +
>           buf = g_malloc0(hdr.size);
> -        memcpy(buf, &hdr, sizeof(hdr));
> -        data = buf + sizeof(hdr);
> -        msg = vfio_user_getmsg(proxy, (VFIOUserHdr *)buf, reqfds);
> +        msg = vfio_user_getmsg(proxy, buf, NULL);
>           msg->type = VFIO_MSG_REQ;
>       }
>   
> +    *msg->hdr = hdr;
> +    data = (char *)msg->hdr + sizeof(hdr);
> +
> +    if (numfds != 0) {
> +        if (msg->type == VFIO_MSG_REQ) {
> +            msg->fds = vfio_user_getfds(numfds);
> +        } else {
> +            if (msg->fds == NULL || msg->fds->recv_fds < numfds) {
> +                error_setg(errp, "unexpected FDs in reply");
> +                goto err;
> +            }
> +            msg->fds->recv_fds = numfds;
> +        }
> +
> +        memcpy(msg->fds->fds, fdp, numfds * sizeof(int));
> +    }
> +
>       /*
> -     * Read rest of message.
> +     * Read rest of message into the data buffer.
>        */
> +
>       msgleft = hdr.size - sizeof(hdr);
>       while (msgleft > 0) {
>           ret = qio_channel_read(proxy->ioc, data, msgleft, errp);

Reviewed-by: Mark Cave-Ayland <mark.caveayland@nutanix.com>


ATB,

Mark.


