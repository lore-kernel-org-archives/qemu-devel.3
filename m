Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9DD7BC61DBE
	for <qemu-devel@archiver.kernel.org>; Tue, 25 Aug 2026 15:04:29 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wysh8-00045R-A2; Tue, 25 Aug 2026 11:04:10 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mark.caveayland@nutanix.com>)
 id 1wysh6-00043f-Lb
 for qemu-devel@nongnu.org; Tue, 25 Aug 2026 11:04:08 -0400
Received: from mx0a-002c1b01.pphosted.com ([148.163.151.68])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mark.caveayland@nutanix.com>)
 id 1wysh4-0004jn-KH
 for qemu-devel@nongnu.org; Tue, 25 Aug 2026 11:04:08 -0400
Received: from pps.filterd (m0127838.ppops.net [127.0.0.1])
 by mx0a-002c1b01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 67PEcELn2321403; Tue, 25 Aug 2026 08:03:51 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nutanix.com; h=
 cc:content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=
 proofpoint20171006; bh=lzfesfCZEGuJ809iRxQmc20cgOw0HpTv6o54DYLrA
 Ko=; b=DDDlHpmBjMWNqwb+dQgd5mgNAT+xcKepAFWB9+qxPktylixn+nwHn18Ol
 zvZv0zUuEMPqf3h+6RMAMmT6fPY0MoTvJzNOH+FpUYgrwJYYuo8pjaJWztALokOT
 jxYlPQ6cPjr4LWfVsxbQymRk1JFDr8dnK1I2NBr7jbbaWBwuwqz6QUGzNUiw+KQu
 gQFlRHa7uynMzlnbanNjbBJoruYrCbofSMmpxHGdokgfG8iRIPZNzk+E1LxF9Gi+
 i0LNum+S+FscZom98r+BjZSrozWflDAVuh+BGOkpUU9tvH5aZPPb67STB7yeyK+W
 ord5HZhh75FY/7ieZaz5fTmCrwrLg==
Received: from ch1pr05cu001.outbound.protection.outlook.com
 (mail-northcentralusazon11020122.outbound.protection.outlook.com
 [52.101.193.122])
 by mx0a-002c1b01.pphosted.com (PPS) with ESMTPS id 4g7bavemkf-1
 (version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NOT);
 Tue, 25 Aug 2026 08:03:51 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=ggal+iv3nigs949c0xi+95Idi3FgQ4DH+tRw4i7tM+BybfEYDfl3YDA4skPEbM0yYdYv5tvb2ws7cLzA0Xqqnxc1aZE/2wSGdlJ1BWfK3s3MkVjln9xqtXvM4n8jRrFt4S0g4kJlCQw+TwYRZHVrtHeCj54kOTMouMNOXosAOODxLkuDKRrhtfZUQF1VbK5bGTkQLraTz/p6++FEuYgd99i3II2WcL2S8g5Ir2xojgrDAYkAkMrk0oHBrNpr5D1tTQgc5qNJAfymvGkuNC3J8g6pU2P1aSz8riaxHSsuHg2mTzzTaL2KOmLZ5ChOUDH9YCKiSgP8nFhHkjgIeb2iFA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=lzfesfCZEGuJ809iRxQmc20cgOw0HpTv6o54DYLrAKo=;
 b=IP1qctGW+X0Ff85NS10MgGt9wfx1R57eTKI6JMbOA7visiUgaGJ3rgbDJOidyPsmM55SY/sM7KoK//YsyU9zhPjY2o98vShyweKQsczoVH98/rNw5AwaZzUovRuAkEimOkmrZFvs5jFdN5JIN6UIovj106a+7PpcH2qr2cWroPc3SZ4ifr3WBl64UHtNTK89rsRPat/S1J2YzA8ouFtOpaRsArujYgTxFjZ+gc0HMEegugrgpYIK08MXiMNPXC9tOKwW/xl5UUsa931u6xQuM28t1WedaqfbkSEppvSC/gQ/pMNjCULLAMcZO+ZhFAdyz0SAciBsGqb2yW1kqNXtuw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nutanix.com; dmarc=pass action=none header.from=nutanix.com;
 dkim=pass header.d=nutanix.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nutanix.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=lzfesfCZEGuJ809iRxQmc20cgOw0HpTv6o54DYLrAKo=;
 b=EItxVhCE9MusvEmnIb0ZQE5IeBf7xqSKFHbzLh4vEs5rWiiUKAH86dAR+jmNS1zBAuzMj3rj8wWim+EM6g1QOvYV8HipslGWo4sPauxOzBNa0YIZe7osEpThBjQ1WfqZrV37unRXN1D3zE4FcD7ZYWfE5prr385ECX1okbRzpcOVVmDLCtOJX9nRjiG3Mv3avboIgrDq72ll/SM8ZCinHJ7bMz1jz6yQqtkqbcnY0oW0dwtfNgZREOKBHWu4SpkONJw7O3aOuWFyFo4CYTnKlk39O1lpayMoLLcXUPDqFmeff/Z9Rk2vjv1zYvJAfuB18eYN7Xm5VFGRd3GmiU2byg==
Received: from PH0PR02MB7159.namprd02.prod.outlook.com (2603:10b6:510:16::8)
 by CH0PR02MB8136.namprd02.prod.outlook.com (2603:10b6:610:10d::16) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.360.6; Tue, 25 Aug
 2026 15:03:49 +0000
Received: from PH0PR02MB7159.namprd02.prod.outlook.com
 ([fe80::8e97:bc32:822c:b250]) by PH0PR02MB7159.namprd02.prod.outlook.com
 ([fe80::8e97:bc32:822c:b250%3]) with mapi id 15.21.0360.005; Tue, 25 Aug 2026
 15:03:49 +0000
Message-ID: <cb95479b-07f5-4e90-823c-1cac37de4e60@nutanix.com>
Date: Tue, 25 Aug 2026 16:03:45 +0100
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3 31/74] backends/hostmem: fix property typenames
To: =?UTF-8?Q?Marc-Andr=C3=A9_Lureau?= <marcandre.lureau@redhat.com>,
 qemu-devel@nongnu.org
Cc: Markus Armbruster <armbru@redhat.com>, Paolo Bonzini <pbonzini@redhat.com>,
 =?UTF-8?Q?Daniel_P=2E_Berrang=C3=A9?= <berrange@redhat.com>,
 Michael Roth <michael.roth@amd.com>,
 Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>,
 =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@mailo.com>,
 David Hildenbrand <david@kernel.org>, Igor Mammedov <imammedo@redhat.com>
References: <20260818-qom-qapi-v3-0-24b8bbbe3d86@redhat.com>
 <20260818-qom-qapi-v3-31-24b8bbbe3d86@redhat.com>
Content-Language: en-US
From: Mark Cave-Ayland <mark.caveayland@nutanix.com>
In-Reply-To: <20260818-qom-qapi-v3-31-24b8bbbe3d86@redhat.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: SN6PR2101CA0020.namprd21.prod.outlook.com
 (2603:10b6:805:106::30) To PH0PR02MB7159.namprd02.prod.outlook.com
 (2603:10b6:510:16::8)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH0PR02MB7159:EE_|CH0PR02MB8136:EE_
X-MS-Office365-Filtering-Correlation-Id: d46d701f-c99a-42f9-997a-08df02ba11de
x-proofpoint-crosstenant: true
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|23010399003|366016|1800799024|376014|7416014|10067099003|4143699003|56012099006|18002099003|22082099003;
X-Microsoft-Antispam-Message-Info: t17mg5SW+Rjal/+8GgK0SSW6Zkc1NenN3jmApVVXXiL+lE5gY5k6fRoQNGk/OQIFab+YOskS7nOgnVcEUrVcXOcQDMHAVdl7Fv+doNQrPYYNgdii1fdCi/3K1C5sMSVTWfhxJM2dHetQ9XFKUb4O+IIl7Mfg80nTENx3bHvarLOPJrXe4384ppwWPkyFMqPuZT7z6WHhRcTyfqTbDO0nTy95IivbSiPoYqytZJphbJYLLpZghjlOp5AuPv/9l+UGxnpmIKsrpaCEbZ5uC+0TtKWhxc5m0v0lOsHcmax3CeZvBNFRAOYhkJV75QfRHXC7T4oolyC31N4S65dQABWoesO5Odd2q9GVBrkC5t2V/DiKk9aZWVk0UJkxjIfAMZ9saAWriYd3I1PKZFB67thrc2BpjTy81mrT03PhPs9Ezce9cOcY5/9u70BFSqfsdEKJlutscXq0yJWf1SCDe3EemzPV92JT60v3UUWnNkFqrCE04RPl030FRVfOwTSDcDhXCHLQDkZeJ6M3s9KDWa8uSUnHmMRHReQC5bNBgma1/4hkcoZOKf9SmJc6JTpraJnvG73hmEiqnmm6MJoFeWnsY2IE0RzdcGfQmBWAnQVUjBJeoAhVdKZLTDwYLVWJH0Xv/ATPwJlg10xKtZosXWDzgwsWKNrVlZFl3g5XItz7jLU=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:PH0PR02MB7159.namprd02.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(23010399003)(366016)(1800799024)(376014)(7416014)(10067099003)(4143699003)(56012099006)(18002099003)(22082099003);
 DIR:OUT; SFP:1102; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?VDZyWDhRRmV5VlFYT1RPeVREcmd3WWoxdEFzd1ZxZTVFbHh6anRYOG95QnVC?=
 =?utf-8?B?L0RqbGRXc1FSRUNxSlliYklLalFGQ1RMU1lHTTVPbVlXYm1VNFIyY1ppUDJL?=
 =?utf-8?B?TVVVK21TeGF3WGMwWFdaV3pIMXlQUlI2UTAyeE9hMHA5RlpETW5QQ21acWJ2?=
 =?utf-8?B?M1lzbFRNaWVGMVBSV3BXdnNSbFlPSGFRbHJYWDFLS0d4N00wTXc5NE4yRHZ3?=
 =?utf-8?B?Wm8rdXhpNCtIeDd0QXFCOXZqUUFhNEpUMkY1RGExZ0diQ25kODFqd3dBNG1q?=
 =?utf-8?B?bUhLcjM0SWE0d29pUDZwQUFENkUwRDd0TFBXdEJGRDRtTGtINXRmRU5kdHE5?=
 =?utf-8?B?QkZNNG5oeUo2ekY2aTFCVUNLaDl5SlZ5UHZwdElJR2JjTXVGUnhoa2xGR290?=
 =?utf-8?B?VGNscGNHb0RQelVBQXNuN0hrc3F0dmtKQTVna0w1dGVPQWV1cURxNnpqOWNI?=
 =?utf-8?B?Q3JLdGp4ajk5SDZDNnlsZnRkeDd3dktlTU5lYVo0enpIblpqVlZWOURyN1Zx?=
 =?utf-8?B?dXlqSHh0M3lWQ0RCckgrdEpranU5Um1HQjArcDdJSnFoMVZnNmM0M25uMnYv?=
 =?utf-8?B?bmxmSGtVUzJLTkxDNThibzE2NFFVQ0JGaWZhZEw3VU1TZVZra3ZIZDZIU08x?=
 =?utf-8?B?ek8ybjAxNkRyTlFNY0poeTZKQXovSU1HV1ZDZlYvdkh2am1LTEVVeUI1a3k5?=
 =?utf-8?B?NzIySWhPbWpzeTkwRTVZYWNwL3ZFRlJWRzBEbk5FSlo0Q0Y2WVFFRVVlOXBq?=
 =?utf-8?B?UVNXL3QvZ3dYNUF5Y3R0NUxWSjRTMi9WYW5hUmxEZDg3K0c5N2RPVnJBdGVV?=
 =?utf-8?B?S2d0RWF1RndaeGwwSnlrM2duci9nSHZYc1ErWHk0cE9ZcjBRVFJ1a2Vta1Aw?=
 =?utf-8?B?UVdaanN1N1ZocmtiZVBtNmhHWFVTdTFYbk0vSmlhYWtjMHJydDVtdFkzWUQ3?=
 =?utf-8?B?SWhNWmw4RDY3S0cxb1l0OTRYbDVNU2p5UHJlN0lhMFpuNlNNd3BqZHRRTVhP?=
 =?utf-8?B?VkdUZkpsU0lsY0o2VVlIZkRZd1lqSmlLeElacXlkZ212MTlmTEpaUzdjQ3BF?=
 =?utf-8?B?MzRKYkttOUt0Z2VEYUo0OHJGOW9saW95dVRwdlBCbHpsbHhNODhDcU1yU3hs?=
 =?utf-8?B?aXJoZDNzbkZpQkNUOUV3VzhxV2dEV2R1S2NQYkQzYnBsU2VUYTZOUDdoS3Mw?=
 =?utf-8?B?M2o5UnBUdDVmVlV0OUpyWko5d1JUbmNsbmcvcjlaVExINjByVG9wWGlaQ2Na?=
 =?utf-8?B?YUxuQWFad1ZodGxsSE5wcksyVWZnL2hpZFVCR2FYNG5SYU5JclJZaHljM3dW?=
 =?utf-8?B?anJTVW5BNy8yOTlKck1KSmp1QXJpdWY5eWtINjFON21VT1IxR0lLZTZlS1o3?=
 =?utf-8?B?RHJTWFAwcUlmTGl5OGRsbmNkQW9WS1hiUjJGRVB2NHRJWkY3cndVN1JRa2ds?=
 =?utf-8?B?djREcHUxdGt0RERVLzcwSG9pUnVaK3p4TWNPVWFxSkJxanM1NE9NZzRiUi93?=
 =?utf-8?B?eTZ2azQzRmR3SDFqRmFBcXlEVFdkSUxWSzZSZnVoRVE0d2FHTUY3VWVRL0Jj?=
 =?utf-8?B?SHcvdThKeVZkSnIwQW9LWXpmaXdZZ3RUVDBmaVM3bHpwOW9GT1Mrc1plaTNN?=
 =?utf-8?B?S3NZY2hIMHdwZnhIdkJRZmRRQjhsS2FuM0UxeGtKUG0zQmxDZytRQWxDYnY5?=
 =?utf-8?B?Y2t6czdTSlM1MHVwN1V4Ky91dW1UenYwcFZPSjhhVExMYm15aW1mcWgvMTFB?=
 =?utf-8?B?allWY1JBUDVSOG9GSVVmdDM5NVVvUDM1eFRtMVZYbWJiblFmazB0U3NqUnd1?=
 =?utf-8?B?bmxodlQrRGZ1WGlkaDEyL0xSbmpIUHUwV2hTVjVOS0p5aGF5ekJrRk9wUmlw?=
 =?utf-8?B?UlpKczVxOWo5RTdzQ0JWVTBwU1prVDZraGJKeGNMeDh6M2FsNDRjaHZtQTl2?=
 =?utf-8?B?S1lwc3I2ODJCNWRONDZrUmhEVmNNaVhXamxaRVEwU25BT2dQQkw0MFRVOGVj?=
 =?utf-8?B?VEs5VzNqOTVVbnJTeTdSQzBZZ3ltUS9IVEl6c1pxVFFkcE5qUDJZbEtPNEJG?=
 =?utf-8?B?UDZjWGd1eWVRQ2d5MHhkUVp3YTdVRkY2S3dSWWYrV0doVFRXdGJTa3pYZ3Vh?=
 =?utf-8?B?Y0NkNjl3eDBvdERFUlkzWSt1ckxzbHJqNGh0Z0loVk45ZE4raTQ0SS8veVZV?=
 =?utf-8?B?VThkdThEbUtvY1NXdGtFNk5EUFVHSFlzY1pWaXl3d1ZHN0dhSDA5V0VoY01q?=
 =?utf-8?B?S3NZSll4bG00WG5aZ09McCs1ek1zYzVmYUMzTDl0a3VmdktXWko1c280UUpo?=
 =?utf-8?B?cWRtSmliRFphK2l2VVZOZkJMRFM3enZOSStFenhEUnV4R2s4aHIwNHhpQ1Jz?=
 =?utf-8?Q?ehexSAelgYxBTgE8=3D?=
X-Exchange-RoutingPolicyChecked: a76kpjFvz0aBr043+7u2Pfhco5rdwciAmAyRkioX0i/Oj+x8zVrCh92n3znkxV5QrQJB0e7APLCrov4hkot0IGndjDWYxKjRyl17uH5tSZgandvp/orqgbAMs1has/2IYHVOFKhxfIpD15JM/cLLzq63bS+2pWMc3wMxw8MGoXmcUE/jKr36uPRY0JoouNHJhIrlyEN6SP0hYU3UQ8mjdwIelKXQ9DMsNw3bA8aRyryY5y2NCf7GKDzmdwncftcYye9998CThuRdEi+h4Mt5+VPskbIZJx9MP8p+L0m4csskYiygqIhQo1YlrpD03/wWi72wj7ItQyUWOJgHj0FudQ==
X-OriginatorOrg: nutanix.com
X-MS-Exchange-CrossTenant-Network-Message-Id: d46d701f-c99a-42f9-997a-08df02ba11de
X-MS-Exchange-CrossTenant-AuthSource: PH0PR02MB7159.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 25 Aug 2026 15:03:49.7692 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: bb047546-786f-4de1-bd75-24e5b6f79043
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: kovbxigwcxQ/Ql4+rUaCWdmRjln3GMqk+i8Ez7tYJV5wWbn/3iBtRpl5uF4iCbYIiOsNWqxLexysE48U2kfbW5JszhRdU8myxvHBri/07U8=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH0PR02MB8136
X-Proofpoint-Spam-Info: AW1haW4tMjYwODI1MDEyOCBTYWx0ZWRfX6KMIKcmx/Jpu
 tYiSlivTSD/Wy9raRY2ViLFIQX3+TcyvKVJ4JaHcO2MulbiebgGzaZFXHIjJ2/XDkigLJyrFTV1
 O6zsX5XBwXjMMI+YSa2LefT6NmDudVI=
X-Authority-Analysis: v=2.4 cv=aJvAb79m c=1 sm=1 tr=0 ts=6a8daed7 cx=c_pps
 a=PcTxMsyy24f1mGF745e4bA==:117 a=6eWqkTHjU83fiwn7nKZWdM+Sl24=:19
 a=z/mQ4Ysz8XfWz/Q5cLBRGdckG28=:19 a=lCpzRmAYbLLaTzLvsPZ7Mbvzbb8=:19
 a=xqWC_Br6kY4A:10 a=IkcTkHD0fZMA:10 a=Sv0fKeRqtYgA:10 a=0kUYKlekyDsA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=VofLwUrZ8Iiv6rRUPXIb:22 a=1L6crL_YRTbalZ11mEUO:22
 a=20KFwNOVAAAA:8 a=64Cc0HZtAAAA:8 a=FTAs2G7aMAOqu1aUxo0A:9 a=3ZKOabzyN94A:10
 a=QEXdDO2ut3YA:10
X-Proofpoint-GUID: fAuw0sBSP_BwSOgSLYqeEFshVKKb50C3
X-Proofpoint-ORIG-GUID: fAuw0sBSP_BwSOgSLYqeEFshVKKb50C3
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwODI1MDEyOCBTYWx0ZWRfX0ejl+aiFHaKd
 HD3DSOQ32u2rNQ9w58nqBUowzXDq4gOLOiegGhsGiP3k/EwZFUtLsrazuJ7j5+6xMy6rkfJ6hQN
 qmxRkZw3rKxydJszT/LVD/PW26FlvBdIa9DQJdpuiRG9orOpQh5sj2SijSN7khfdwZg3Tb4qjKB
 V4tLvF6+6xNtMzzBLrv1P0l34SlRIGz69+0wh74ow+bzuvmjlBWkCqL6vy/k3n59kInvvfcrujU
 jvRjOOReUsYFoONaNWPEn5CmAZd6I4yg9kbElHO6eyfo2E+04RdyXhx+VBcUaXP00+7aTpvwhpm
 MaBuUSAbAcVEwlgVgNymU7o1Lj09CAOek8Sk6JXk2v/BI85t/GnKvfEgWWk8240ggwzRR0B7WuH
 YUL5Qycbbc09RU9lBfVnyqiJ/aFxhA++YRv1SdlAZSfG0fhmT+CfgjC5p1Wg5J2boSduASv+x0x
 DtbarX7+BCpZMcAnkJQ==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-08-25_04,2026-08-24_01,2025-10-01_01
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

On 18/08/2026 12:10, Marc-André Lureau wrote:

> The "size" property uses visit_type_size, not visit_type_int. The
> "host-nodes" property uses visit_type_uint16List, not visit_type_int.
> 
> Fixes: e62834ca62a8 ("hostmem: Register TYPE_MEMORY_BACKEND properties as class properties")
> Signed-off-by: Marc-André Lureau <marcandre.lureau@redhat.com>
> ---
>   backends/hostmem.c | 4 ++--
>   1 file changed, 2 insertions(+), 2 deletions(-)
> 
> diff --git a/backends/hostmem.c b/backends/hostmem.c
> index ce82958050e2..e7f9b436a459 100644
> --- a/backends/hostmem.c
> +++ b/backends/hostmem.c
> @@ -540,13 +540,13 @@ host_memory_backend_class_init(ObjectClass *oc, const void *data)
>           object_property_allow_set_link, OBJ_PROP_LINK_STRONG);
>       object_class_property_set_description(oc, "prealloc-context",
>           "Context to use for creating CPU threads for preallocation");
> -    object_class_property_add(oc, "size", "int",
> +    object_class_property_add(oc, "size", "size",
>           host_memory_backend_get_size,
>           host_memory_backend_set_size,
>           NULL, NULL);
>       object_class_property_set_description(oc, "size",
>           "Size of the memory region (ex: 500M)");
> -    object_class_property_add(oc, "host-nodes", "int",
> +    object_class_property_add(oc, "host-nodes", "[uint16]",

I was not aware of this notation: you learn something new every day :)

>           host_memory_backend_get_host_nodes,
>           host_memory_backend_set_host_nodes,
>           NULL, NULL);

Reviewed-by: Mark Cave-Ayland <mark.caveayland@nutanix.com>


ATB,

Mark.


