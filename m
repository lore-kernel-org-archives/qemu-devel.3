Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5FE61C369B4
	for <qemu-devel@archiver.kernel.org>; Tue, 15 Apr 2025 09:33:53 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1u4cfc-0001Ka-Fs; Tue, 15 Apr 2025 05:33:32 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <manish.mishra@nutanix.com>)
 id 1u4cfV-0001ID-80
 for qemu-devel@nongnu.org; Tue, 15 Apr 2025 05:33:25 -0400
Received: from mx0a-002c1b01.pphosted.com ([148.163.151.68])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <manish.mishra@nutanix.com>)
 id 1u4cfR-0003HF-Jf
 for qemu-devel@nongnu.org; Tue, 15 Apr 2025 05:33:24 -0400
Received: from pps.filterd (m0127838.ppops.net [127.0.0.1])
 by mx0a-002c1b01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 53F4dr9p001015;
 Tue, 15 Apr 2025 02:33:17 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nutanix.com; h=
 cc:content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=
 proofpoint20171006; bh=m7VSGQJZiaff99IMJIeE4r3YmAFnYc5ROHXSbS5Ho
 4Q=; b=NAfSj4s5pfXO3LiKJoZEYgiSbk46P8HirFW9ZQnecFQn/rkcIlyw3sOew
 u6Ox7YZbmviDclkgvYUr2YfiLoX0iL1sYKdJH4Y3VvXaUzwfjAtASogoTpSbNrc/
 HwOMr/r8fbJ8iR+Jg662gcwBmRecheAdnMGutA6lMJnGYA9XQfubdrrpvqkGiTqA
 btaPjZSX186aI7MJf+itv2duXmAHfZrGlgkDSHrBbvQ/13S+CTyIEjVz0WPxPrL5
 r0YQ8WLmOhyGhpVWrjihLZsg4dQs2kZcwFzVmoOqx1NWn1VHNHEDEyF8C4LCBkna
 S3HIABAq/UbT7YwmfwRWf4Qr2v5Fg==
Received: from bn1pr04cu002.outbound.protection.outlook.com
 (mail-eastus2azlp17010021.outbound.protection.outlook.com [40.93.12.21])
 by mx0a-002c1b01.pphosted.com (PPS) with ESMTPS id 45yqqyng8n-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Tue, 15 Apr 2025 02:33:17 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=OI5Re4YpMwCKHYj+h/8QlWSg0yM4n+bjMGZ++6etSY97OxNEVLnDQRrRZ/gVpqYcT/+X49KeGkEPAhy3WqiDS+wSstTUg7mBmeRkJqbDTSMZqnvWXqHSvTz/v+4yCPOdpSz7ZNr9VIH7yO8rGUo2JIIlK82uEqnhaCtfjS/6Yu5+kUn6s7/uOUu5SuoSloC4SLwN2S+5U7ulL4nSndGswQOrgFprO56PH7LAbkG82y+stUjmr7wrDli9WGrmtDdbKs1hxoFQA8JL5qUm77+ykwfvTbi7lphIlOVEIP30UWawlkXGYmYIRZ9GdWkdI+g9xYGgzzRrENdwA8uwTyWI9A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=m7VSGQJZiaff99IMJIeE4r3YmAFnYc5ROHXSbS5Ho4Q=;
 b=g/JQscy9a1BC4M941Yw2C4mXCQIsjZTH67dbaAYhUdv6KSn7KbUkwGYe+7gf//gAM/EUg9pZjbYm/BOI3gU1pRzHH6mvy/dJVtXMVnk27s76ZJDbs4M91knFeIGosrMxlqm+OM6nXMSBtLxda5RKzuydJaFAzLL2PIqYTf94a9QEg1Jl0GfRDFLsgnflWMsjpx2Eh9C/K3WOsEWSgYmHjcdM/WJnx/xtcc59IPEZBKnxnEN9rfGuAJUD9akVNJJyu7KzXINp9PqDWfIF5rz5xLAiGgo2GFWAkI/zAvZbA4jqgc6+LG2acACoHSMoQ5i4qG5pzt3RdOgs9+SatC/f7Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nutanix.com; dmarc=pass action=none header.from=nutanix.com;
 dkim=pass header.d=nutanix.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nutanix.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=m7VSGQJZiaff99IMJIeE4r3YmAFnYc5ROHXSbS5Ho4Q=;
 b=TnD2ZW9lGMKwXMPUPSCy8BisscAP5kUXuYQv0r4ZKQlonNKWMWQkej4nOapHzCfpyZagPpMY2G8ds3kOHIEht3ClvhIWRPRSoOopps+XmYha9NhJSYLSGAEUldBqsrpGzWjvLIEXLcmhWyiOzdo2VTMuD1sZH0iN8T9B+jtSLePM0FDFoGPv+lUvimt2j8myxpVpa9wfepid6XgoXyr1u9ixXFZDzyD3EqMtUrh8m/YVv0TW0N5lLk4+bVLahF2Rjoa19mkTd8dM2MGWcsvULa8CWfUtAMBbykGydIMkII+nVxaAqbj2npbrVkPwOJFYaYbon6cE7gYHXUzBJwgzdA==
Received: from PH0PR02MB7384.namprd02.prod.outlook.com (2603:10b6:510:12::12)
 by DM6PR02MB7100.namprd02.prod.outlook.com (2603:10b6:5:25a::21) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8632.34; Tue, 15 Apr
 2025 09:33:14 +0000
Received: from PH0PR02MB7384.namprd02.prod.outlook.com
 ([fe80::6bd7:e8f0:596a:4842]) by PH0PR02MB7384.namprd02.prod.outlook.com
 ([fe80::6bd7:e8f0:596a:4842%3]) with mapi id 15.20.8632.030; Tue, 15 Apr 2025
 09:33:14 +0000
Message-ID: <beaa2d0d-49ba-4eb4-a7a3-1a167711f023@nutanix.com>
Date: Tue, 15 Apr 2025 15:03:06 +0530
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v4] QIOChannelSocket: Flush zerocopy socket error queue on
 sendmsg failure due to ENOBUF
Content-Language: en-GB
To: =?UTF-8?Q?Daniel_P=2E_Berrang=C3=A9?= <berrange@redhat.com>
Cc: Fabiano Rosas <farosas@suse.de>, qemu-devel@nongnu.org, peterx@redhat.com, 
 leobras@redhat.com
References: <20250403082121.366851-1-manish.mishra@nutanix.com>
 <871ptuhla6.fsf@suse.de> <14f644e9-aa8a-45b0-9d0a-972d72345409@nutanix.com>
 <Z_4mUkuAXcTXyx5B@redhat.com>
From: Manish <manish.mishra@nutanix.com>
In-Reply-To: <Z_4mUkuAXcTXyx5B@redhat.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: PN4PR01CA0097.INDPRD01.PROD.OUTLOOK.COM
 (2603:1096:c01:2ac::10) To PH0PR02MB7384.namprd02.prod.outlook.com
 (2603:10b6:510:12::12)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH0PR02MB7384:EE_|DM6PR02MB7100:EE_
X-MS-Office365-Filtering-Correlation-Id: c705805a-11b0-43a1-f514-08dd7c008b8a
x-proofpoint-crosstenant: true
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|366016|10070799003|1800799024|52116014|376014; 
X-Microsoft-Antispam-Message-Info: =?utf-8?B?bjQyU1N6WTZrQm92Zno0amdvVXZZVVg0L0ZSS2Uxejh0cHZDNUhxd2x4QTY1?=
 =?utf-8?B?dFVITDl4a1hTWUVxWmRETlIvdWVjNy9kZFBkMkZGRW0yM2REd1k5RjFmRC9W?=
 =?utf-8?B?NStpRlRRek4vMjVvN0hkMlZUeDhneTJyWjRnL1BlU0Y0YnczK1hETU5mcVVX?=
 =?utf-8?B?M0VWclFjazYreEg1S0dyelN2MVVrcUk5WFdsUHlhdGZuN3UxQ0VNSk1zOUVI?=
 =?utf-8?B?T3V6MzRtcnNnUFdMaWU4SEpRZGVPZWhzRUtjUDlUa0k0WFZYKzlvSEJXRURT?=
 =?utf-8?B?V0c5c0NmMUVOM0ZWV0xIRWVFSkJ5emRqNFl4YXBRS2VTTVhZMFF4dTR2L092?=
 =?utf-8?B?d1l4Q1FvaDcxNGRUbzVDK2VDeW9scmc3MW1ZZFNYck13V2J6VWUxdHpkSzhC?=
 =?utf-8?B?eTJvVEcxcXg1ajR0ZlJtRWQrWmNCZGoxSmQ0UlRWTXFEVWVCVmR1UW5ITWlD?=
 =?utf-8?B?ZTJtU05oRk1VWERFSGJjbVQ0a1lJZ2k4UCtWQUN6bmlkWHpCclhhbFdaT1J5?=
 =?utf-8?B?RUxtcW1RRWdmd1BWdjk0MmRQcTJSSG1HMWJSV0xySHJZcklvS3hnQ1ptWjVO?=
 =?utf-8?B?emxIUSsraG9zSUQzU2pTeEdvNDRwN3NPRzFMSTNFUlhsTnFQdkM4TXJNSGhZ?=
 =?utf-8?B?cDAwaHhVRGtvWFgwdno4eTlCTXdhaE5zbFVHZURZL0pIbEU1NE5FSzJvd2M1?=
 =?utf-8?B?V3haWjJOUFVsZ2NSRWFtWUJjRVhiVlNUMG1JTWVid3p2QjB6b2VqU3gwTzVG?=
 =?utf-8?B?UWJpOFRpK0tsYVhxb1dheUxoYWlWbGRtdDNyNlR6RG9OTnpUVG8wWndWcmRS?=
 =?utf-8?B?VzU2OEpiVjRSa0NOWG91Ynp4WWdvMnY2NnJvRS81a2M4VnJuaXZCYWx3R0JW?=
 =?utf-8?B?QXpTcFZZc0s3MGFWb1N5dWYvNnFxWjB4SjhudnN2Y3BlTnN6ZXVhZElMT25p?=
 =?utf-8?B?RHdJMWdMTzRDYTFrcTd4SVo4dHF5OUREN3Y1TzM4amtMM3UzZVkvZmhQdUVC?=
 =?utf-8?B?dHBUVE1YNUNUTzFmSnJyM1JZcGlLcC9aOVJnUWpnRlgwWWxxWHgxSzVBQlNi?=
 =?utf-8?B?WENNdVRqYWN4SXp1VUZnclBrZnU3cHUrSXMyMHExK1pqWHc4T0NqeXBESVcx?=
 =?utf-8?B?c3RzcU1LZFBzY0Q2U3dUd2pGWktXQVRhcnJaQWc2VWVRcTRPSVNSOXhYdmtj?=
 =?utf-8?B?aUFjeFdRbTRtTGVGdmtPY0FXTGw0NE5VSkg1VkkzeXhCall0bmF4R1cweXBm?=
 =?utf-8?B?bm1uWnlsREFMUmdTSjNXTE4vODdFdUNSVkhiS09VVFJJOTBvQmlZWWpQNFg3?=
 =?utf-8?B?V0I1V2hPaklHWmN6MzE4WjdTa0VMM0xWL3pCTGFjSGJjcXZHVDM5aTgvdDNB?=
 =?utf-8?B?bTdYWGg5VDhIeE44amVJUE5yb2RJTzhMdTNMdUhhZGZVLzB0VXpSWVZleFBR?=
 =?utf-8?B?MS9uQ0xjM1RTbW12RVJiQjBNLzZQOGM0Wk9HcUFKVHVyaHFYMGdhWU1IQ0Zv?=
 =?utf-8?B?Q0VFc3ZydFgwVGZIVXlLZzRHTFJ0Wm96UnJvRnE3emxNeUJtbldOS09sZGkv?=
 =?utf-8?B?MWYwNXEwN2NIQkpUVnE2QlNFdjF6emt6N3Zwc0R3UlRBUU94ci85ZDE5RnZK?=
 =?utf-8?B?OSs0WnlkMDFMY3pQWWVVRnlscnRoK2ZNV1pQRGtCMzFacHNueGpCMVpsUStY?=
 =?utf-8?B?VS9pWkVlN1gwMDVONnY1bk1sV0duVHliQ1NYVmpkL3g5RmgxdjMxNlRLRmNI?=
 =?utf-8?B?Rzk3M09tSzJKZFR3SXdobFRwdGVneElOZ2xPWmwzQVhab1NsdFpJUGhub2c3?=
 =?utf-8?B?ZlFsQkptWXBSNVhscmFZb24wTjFBRGltZFpMdDhlcXNKTklZclFzek9zdjV3?=
 =?utf-8?B?NlFkSFc5aFZXSzJoTndTS25wTENSVEkrZTE2L3Ura1BpZDFCOHprOG44cG8z?=
 =?utf-8?Q?NTsZjvhOkSg=3D?=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:PH0PR02MB7384.namprd02.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(366016)(10070799003)(1800799024)(52116014)(376014); DIR:OUT;
 SFP:1102; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?NWwweE5BMFlmeUl6dmlBK29MVmZXalJ2VUJ2QWc1OENxcnA1emwrSlROcjNT?=
 =?utf-8?B?NGFHRTE0ZGdSRlVrQ21jRkdmeXFJQWp0d1h4N1VCdTNiRjVQTkNRSXBWdVpn?=
 =?utf-8?B?Rko4WlFPemhDcEdXWVJDUWlZOCt1NnVRR2NUakxmZlI2SjNqcnJ4SlltOHRE?=
 =?utf-8?B?T3diTUVGUzQvcS9za3JIY0VRcEdFRng2Z0R1MVQzdE9BejBZeW1LSW1tVnlE?=
 =?utf-8?B?ZFlsTWcvY1FSdEZPdVFTTFR5S21HRUJ1QkZMa2lxWEQxVnI5b0Z4dlh2b3lX?=
 =?utf-8?B?NmhmM3l6dUtFNUtPK1hPRkJXMERlWEZKU1B4TkVsdytLZlJ1M0VlQWRlZ1ha?=
 =?utf-8?B?K1dJc1NQRm5ZZDYyQmw0S05jK21qL2IxTDNzL21EWVZhK2YrejhYZGJNTkha?=
 =?utf-8?B?UnVqTkppWGlHUVNxejJzamJ2RjV6NXRpUE9KQnE0MVU3dDhJWlRmcSs4UFBD?=
 =?utf-8?B?NndXczRTa0kveis4SWpxcmlMNEtmVmFVa01ja1pNaXVIY2pxRUlMakZCMkJo?=
 =?utf-8?B?R29zT2RkOHQ4ZVZNd1VXUzZYa2I4SG5rK1NVV3ZmeXp1aEVOT1JQTEFtbDUw?=
 =?utf-8?B?YUpRK2tHUlJtMGFvclFTRm4xVW80OVdYNWZoa3huVlpzNElJbzAvUnNOMDR1?=
 =?utf-8?B?U1dWSEZuSGJSUGdEUlp4M0hqbTN2cUVicmd0OXFrOHdhK1BjcXVFRVRRRWdC?=
 =?utf-8?B?a0ZFQWdicXRVSmh6SWtaTnZmbzRWT0tQczlZSFhPM3hTbE51eW9HbTBzWnly?=
 =?utf-8?B?SjQyOG56Si9oNER6RHNFNXVjd040ZmV5RjV6SitWV1RoQnFvUUJ2bWFVMGQ2?=
 =?utf-8?B?ck84NWxnUlhKYXd3K1UyaDNkL1dIaCtXWVBEN2xPOUd5K04vclczSWhteHZC?=
 =?utf-8?B?a0EyMUFaZkcvNmJXVmJsamVyTHdBelp1RWFEaklLRzQ4VlAwcFJDZDYxQ280?=
 =?utf-8?B?bVovNVpXWThWbEZGb0E4WjV3Z1loanJweHlIZkM0NVJHYWFTM2NhQ1QrL3Br?=
 =?utf-8?B?anpxSFBBYlBXTGdmUVhzaGp5eGwzQkNmeHNaZmw5WXIxU0xzS1A1TTAyMXNT?=
 =?utf-8?B?M1Ivd1dQc25DUFZvVEg3L2tUQ1RDUkgrNllWSm5CNjIwcEZmS2lMeTZtbFlY?=
 =?utf-8?B?Q2JvSGI3OHREc0RsR1huUjZmT0ZuRVFEbWtLbVd0T2hHeG5PZmwvb3U4cDdw?=
 =?utf-8?B?UVdlYjlobjdCVkx6RXNnS0FJU2JndjVIZ0Q3YituajlmUTJDaDEvRE1XamlE?=
 =?utf-8?B?dmU2VFJXMkp1cWdOK2JEMlRZZXhML0M4VUZzamFaRGw0UmowSjVsZGhENkJL?=
 =?utf-8?B?d0Vpa0NFVVFycWEvRjF2WHpNTlRITnkyTGptLy9ZdHNDaHZ0aHlpd3VCUlJ6?=
 =?utf-8?B?SjFONmJXcW54K3ZIK0k3TVNQZDVqUEViYlZNcUNkd2pLY1dySlljU2NLM1F4?=
 =?utf-8?B?dUNZNVJDOFF5VG8yOTc3enVPcXFub1BxUi9JbGRiYnd1czVyVlladTJ2SlNO?=
 =?utf-8?B?d3l0bU1xT0tXU3BoOVhlSXk1RUdPaVNVOHQzeVlXMnR6czJYeks2a3JOekh0?=
 =?utf-8?B?WTBKM2tZUDcrN2pGeitDM3pPSWdDc0hKdTdZVWtpNDdaMi83RC9iWWhpWFNF?=
 =?utf-8?B?aWc0ajFJeXVlZnIrb2JrNVRFNVlud2hHdW9BN2VnUnBCeHEvVXlXT1Z0dDln?=
 =?utf-8?B?RFNDeHVGbERraXdGbVh2aDBkQWhKdlpDWmpWbi8wa3piV3RzU2hvb0JJdTlX?=
 =?utf-8?B?QjhMSjRheFc5VE41dE82VjdlZHp1SVIzS3FRaVZIaktVYjB4MEtQMHFSQ01R?=
 =?utf-8?B?dGZrU2xLZnd1ZnZYNXEvTEtYRVJnR0FaUzBPTk1ScG1wWXRrQnNCNWhrUXhP?=
 =?utf-8?B?MDYzaDBkaUJ0dkduenpHMysyQzFQUTByb2FzKzUrMDRBbDkxWk5IVWhpRWxm?=
 =?utf-8?B?MWt6dFh4OTVoTGkvWWt2SVd5Rms4c1hoYXhvS1dHWEJna28wZWxkazdseEFZ?=
 =?utf-8?B?MVcvT1NFbmhTcldldFBEVkJ6Q3MyeUZRdFM0TEJjUHpacFYyeXoyZjZaVWxD?=
 =?utf-8?B?VS92RnQ3c1VIZDJSWVppeXdYWEtRVFdEaVJIS3c4cXgrTEpZTUxPTWhzZURD?=
 =?utf-8?B?TGo1R2U0cFB4N3IxcnlJNUZYMmRiSnlOaTI3ZXVrYVdlMW5iSzlXVnRWUzha?=
 =?utf-8?B?TWJxejBzVUQyUTRsRTg5UTBUUGhPQXdrNy9WWjQ4ekhncE9jZWVKMnh5ZkMv?=
 =?utf-8?B?LzhWRmhvd3hXTDkrNU1YekwxcnJRPT0=?=
X-OriginatorOrg: nutanix.com
X-MS-Exchange-CrossTenant-Network-Message-Id: c705805a-11b0-43a1-f514-08dd7c008b8a
X-MS-Exchange-CrossTenant-AuthSource: PH0PR02MB7384.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 15 Apr 2025 09:33:14.2908 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: bb047546-786f-4de1-bd75-24e5b6f79043
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: IqNhjbZj+34HeCbeKcZhprNyq0HB6vbwFnqqp7WXRs+X1g5EYsprjM8LbtUExrDSJcspQFuoDbo31Gtgf43BMT1yO/vqXD+RvQwbh0s0oSU=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR02MB7100
X-Proofpoint-ORIG-GUID: d-ekgXCo61OvtSv5AuKz6mPEwnxLc4nd
X-Proofpoint-GUID: d-ekgXCo61OvtSv5AuKz6mPEwnxLc4nd
X-Authority-Analysis: v=2.4 cv=H8bbw/Yi c=1 sm=1 tr=0 ts=67fe27dd cx=c_pps
 a=6dLVn7RwcbTzQ1hpYGxp6A==:117 a=lCpzRmAYbLLaTzLvsPZ7Mbvzbb8=:19
 a=wKuvFiaSGQ0qltdbU6+NXLB8nM8=:19 a=Ol13hO9ccFRV9qXi2t6ftBPywas=:19
 a=xqWC_Br6kY4A:10 a=IkcTkHD0fZMA:10
 a=XR8D0OoHHMoA:10 a=0kUYKlekyDsA:10 a=VwQbUJbxAAAA:8 a=64Cc0HZtAAAA:8
 a=fVJiuE1KIbRFwE39zZwA:9 a=3ZKOabzyN94A:10 a=QEXdDO2ut3YA:10
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1095,Hydra:6.0.680,FMLib:17.12.68.34
 definitions=2025-04-15_04,2025-04-10_01,2024-11-22_01
X-Proofpoint-Spam-Reason: safe
Received-SPF: pass client-ip=148.163.151.68;
 envelope-from=manish.mishra@nutanix.com; helo=mx0a-002c1b01.pphosted.com
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


On 15/04/25 2:56 pm, Daniel P. Berrangé wrote:
> !-------------------------------------------------------------------|
>    CAUTION: External Email
>
> |-------------------------------------------------------------------!
>
> On Tue, Apr 15, 2025 at 02:50:39PM +0530, Manish wrote:
>> On 14/04/25 7:56 pm, Fabiano Rosas wrote:
>>> !-------------------------------------------------------------------|
>>>     CAUTION: External Email
>>>
>>> |-------------------------------------------------------------------!
>>>
>>> Manish Mishra <manish.mishra@nutanix.com> writes:
>>>
>>>> We allocate extra metadata SKBs in case of a zerocopy send. This metadata
>>>> memory is accounted for in the OPTMEM limit. If there is any error while
>>>> sending zerocopy packets or if zerocopy is skipped, these metadata SKBs are
>>>> queued in the socket error queue. This error queue is freed when userspace
>>>> reads it.
>>>>
>>>> Usually, if there are continuous failures, we merge the metadata into a single
>>>> SKB and free another one. As a result, it never exceeds the OPTMEM limit.
>>>> However, if there is any out-of-order processing or intermittent zerocopy
>>>> failures, this error chain can grow significantly, exhausting the OPTMEM limit.
>>>> As a result, all new sendmsg requests fail to allocate any new SKB, leading to
>>>> an ENOBUF error. Depending on the amount of data queued before the flush
>>>> (i.e., large live migration iterations), even large OPTMEM limits are prone to
>>>> failure.
>>>>
>>>> To work around this, if we encounter an ENOBUF error with a zerocopy sendmsg,
>>>> we flush the error queue and retry once more.
>>>>
>>>> Signed-off-by: Manish Mishra <manish.mishra@nutanix.com>
>>>> ---
>>>>    include/io/channel-socket.h |  5 +++
>>>>    io/channel-socket.c         | 74 ++++++++++++++++++++++++++++++-------
>>>>    2 files changed, 65 insertions(+), 14 deletions(-)
>>>>
>>>> V2:
>>>>     1. Removed the dirty_sync_missed_zero_copy migration stat.
>>>>     2. Made the call to qio_channel_socket_flush_internal() from
>>>>        qio_channel_socket_writev() non-blocking.
>>>>
>>>> V3:
>>>>     1. Add the dirty_sync_missed_zero_copy migration stat again.
>>>>
>>>> V4:
>>>>     1. Minor nit to rename s/zero_copy_flush_pending/zerocopy_flushed_once.
>>>>
>>>> diff --git a/include/io/channel-socket.h b/include/io/channel-socket.h
>>>> index ab15577d38..2c48b972e8 100644
>>>> --- a/include/io/channel-socket.h
>>>> +++ b/include/io/channel-socket.h
>>>> @@ -49,6 +49,11 @@ struct QIOChannelSocket {
>>>>        socklen_t remoteAddrLen;
>>>>        ssize_t zero_copy_queued;
>>>>        ssize_t zero_copy_sent;
>>>> +    /**
>>>> +     * This flag indicates whether any new data was successfully sent with
>>>> +     * zerocopy since the last qio_channel_socket_flush() call.
>>>> +     */
>>>> +    bool new_zero_copy_sent_success;
>>>>    };
>>>> diff --git a/io/channel-socket.c b/io/channel-socket.c
>>>> index 608bcf066e..d5882c16fe 100644
>>>> --- a/io/channel-socket.c
>>>> +++ b/io/channel-socket.c
>>>> @@ -37,6 +37,12 @@
>>>>    #define SOCKET_MAX_FDS 16
>>>> +#ifdef QEMU_MSG_ZEROCOPY
>>>> +static int qio_channel_socket_flush_internal(QIOChannel *ioc,
>>>> +                                             bool block,
>>>> +                                             Error **errp);
>>>> +#endif
>>>> +
>>>>    SocketAddress *
>>>>    qio_channel_socket_get_local_address(QIOChannelSocket *ioc,
>>>>                                         Error **errp)
>>>> @@ -65,6 +71,7 @@ qio_channel_socket_new(void)
>>>>        sioc->fd = -1;
>>>>        sioc->zero_copy_queued = 0;
>>>>        sioc->zero_copy_sent = 0;
>>>> +    sioc->new_zero_copy_sent_success = FALSE;
>>>>        ioc = QIO_CHANNEL(sioc);
>>>>        qio_channel_set_feature(ioc, QIO_CHANNEL_FEATURE_SHUTDOWN);
>>>> @@ -566,6 +573,7 @@ static ssize_t qio_channel_socket_writev(QIOChannel *ioc,
>>>>        size_t fdsize = sizeof(int) * nfds;
>>>>        struct cmsghdr *cmsg;
>>>>        int sflags = 0;
>>>> +    bool zerocopy_flushed_once = FALSE;
>>>>        memset(control, 0, CMSG_SPACE(sizeof(int) * SOCKET_MAX_FDS));
>>>> @@ -612,9 +620,25 @@ static ssize_t qio_channel_socket_writev(QIOChannel *ioc,
>>>>                goto retry;
>>>>            case ENOBUFS:
>>>>                if (flags & QIO_CHANNEL_WRITE_FLAG_ZERO_COPY) {
>>>> -                error_setg_errno(errp, errno,
>>>> -                                 "Process can't lock enough memory for using MSG_ZEROCOPY");
>>>> -                return -1;
>>>> +                /**
>>>> +                 * Socket error queueing may exhaust the OPTMEM limit. Try
>>>> +                 * flushing the error queue once.
>>>> +                 */
>>>> +                if (!zerocopy_flushed_once) {
>>>> +                    ret = qio_channel_socket_flush_internal(ioc, false, errp);
>>> I'm not following this closely so I might have missed some disussion,
>>> but let me point out that the previous version had a comment regarding
>>> hardcoding 'false' here that I don't see addressed nor any comments
>>> explaining why it wasn't addressed.
>> Hi Fabiano, I did reply to that in last comment for v3. Please let me know
>> if that does not make sense. https://urldefense.proofpoint.com/v2/url?u=https-3A__lore.kernel.org_all_c7a86623-2Ddb04-2D459f-2Dafd5-2D6a318475bb92-40nutanix.com_T_&d=DwIBaQ&c=s883GpUCOChKOHiocYtGcg&r=c4KON2DiMd-szjwjggQcuUvTsPWblztAL0gVzaHnNmc&m=gSsIJRLS4OSUnEkLMiIoiEpY4GGpBsw1hThWqPIQxeyBiNnpZKt3fBmvoU8Psc5Q&s=rWZP5zS-gO43ebKzVTB0970TjuqPCIKmc-_kYco6-Qk&e=
> That comment doesn't really address the problem.
>
> If the socket is in blocking mode, we *MUST* block to send
> all data. Returning early with a partial send when zerocopy
> buffers are full isn't matching the requested semantics
> for blocking mode.
>
>>
>>>> +                    if (ret < 0) {
>>>> +                        error_setg_errno(errp, errno,
>>>> +                                         "Zerocopy flush failed");
>>>> +                        return -1;
>>>> +                    }
>>>> +                    zerocopy_flushed_once = TRUE;
>>>> +                    goto retry;
>>>> +                } else {
>>>> +                    error_setg_errno(errp, errno,
>>>> +                                     "Process can't lock enough memory for "
>>>> +                                     "using MSG_ZEROCOPY");
>>>> +                    return -1;
>>>> +                }
>>>>                }
>>>>                break;
> With regards,
> Daniel


Sure Daniel


Thanks

Manish Mishra


