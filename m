Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7C09EEDF141
	for <qemu-devel@archiver.kernel.org>; Fri, 13 Feb 2026 09:58:13 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vqpvq-0005wA-4Q; Fri, 13 Feb 2026 04:57:50 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mark.caveayland@nutanix.com>)
 id 1vqpvn-0005vo-Pb
 for qemu-devel@nongnu.org; Fri, 13 Feb 2026 04:57:47 -0500
Received: from mx0b-002c1b01.pphosted.com ([148.163.155.12])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mark.caveayland@nutanix.com>)
 id 1vqpvh-0000z4-EC
 for qemu-devel@nongnu.org; Fri, 13 Feb 2026 04:57:45 -0500
Received: from pps.filterd (m0127844.ppops.net [127.0.0.1])
 by mx0b-002c1b01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 61D7mPCG170345; Fri, 13 Feb 2026 01:57:39 -0800
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nutanix.com; h=
 cc:content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=
 proofpoint20171006; bh=MtQMItL8uxCbswli6lNWYkKVxhupjDryBFjvcXuLQ
 0E=; b=NMCnVW9owXxEixs/JQfVXjPD9LKc1DHdxHM+Y5UpA7ySaTvd6m1DMuoFe
 g9U1DLRyl/Ue1zxvFCSGruYLLm9X7yBUT5jvs1A+1WoMk0WfzDdS3kuAdZx2pzkQ
 qB5wY2dwX6xsBiqmUgJxb/h/hxF/DCNQ56ODBq71uejxWeNOkp80roLzqwzNAWlp
 gY3hJMBvgucPRW4mCig7H7l36QdfB+d5/22yl5OokGzD7rvXNFfIc2jRybv4r3+y
 6Y9bmJ9U2jL1FICGAV8uIW0GJHOssweB0kSH4RE/Rcy/uQJ6k/8Wcmh5kuZ/Lgv7
 JXwfOKgcDXTlnlqMnfpSvZoy5di0A==
Received: from ph7pr06cu001.outbound.protection.outlook.com
 (mail-westus3azon11020115.outbound.protection.outlook.com [52.101.201.115])
 by mx0b-002c1b01.pphosted.com (PPS) with ESMTPS id 4c9yvvra00-1
 (version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NOT);
 Fri, 13 Feb 2026 01:57:39 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=WMIZ6th4S+zNE9UrvUoUIp0m1KQoATZbmHq/LUuiF7wGPKn5InuzQSOV87jjQYoRpG8x5C+749l6xnlwFhueL7ZnjVvTqzdsSrR/PJZtnrB0Iyv4JLKMVFmkxmFMz82KpyRAM/eFnjIK+2D1gRqA2ODXcczn/XQSTeA/NODvK7wZbe0rpVRWU2ZIuKL/S5B8IpopjPutPoh2BqDKJjE6pRz2Srw0Yd8MnYaZ1si0BiXv51yzJU/ZJjY5sUY+QpQMcGkPNy7pIYKZbRImXrpYFFuGulwvKZ8lxFHcKhWCvg9+JC1tDnvQe0ebup0xUxfwtNFvmTAWPwfH8RDE2dPsaA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=MtQMItL8uxCbswli6lNWYkKVxhupjDryBFjvcXuLQ0E=;
 b=iUCkCRY1Rtydoj3mmwDtm5Vmi4cOo4fmw2vZnmGWVvTHAisJ2VVI3aTKhb7mc3fO2VJ7Nom9L4yVBP846bSW/qd8ke5taWOiw4Ov0rh3PJyJLd1LuWkHgR/xFKX1p80jytoVBFNgETZWpOZNRHWADrI7lm43CRcYdBdDApXjsQSzmU5SHjWnvueZe2BGWl7BJjvEkFIBUfDjiphv5pp0aynodPu3cHcMcuOA1N6LToIY58/J6qaSWw4rdv7NbcsBjdxweZL6jichhAxl1FMVAai6fCmgFxSbd6LY1CpQJf0+bvR0/EMqrcZ2zeRag2UrhUupK5xvpme8YIo/lsYAPA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nutanix.com; dmarc=pass action=none header.from=nutanix.com;
 dkim=pass header.d=nutanix.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nutanix.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=MtQMItL8uxCbswli6lNWYkKVxhupjDryBFjvcXuLQ0E=;
 b=FoKB3R8BXrJcFRsqEcp3S1v3gtx0mhH1Bp2G5ZbTkH7qljTjG6g+8uRbU3ONP+A5e0FvYNmxAe0F9jzccQojp3Yen4YAD8dXMkOBGAnHKiGotBQXB9ar753IXiBTldQR2PmVFFMxCPi/GWQ+nFynwlnNwnZFe2TM97HJnDikn6183TXCSHKgxon+nwcTEw2ujJkW6NtUAEWewg9bxncxaNqzkFStyQ78gha2IEIqIB3zfhmpFmX9K4iSiKILqQp5tEU6IgZm0UQEHbvwBkDaSvdW/ZSbYVMp7pnTDlWommBRyuKpGuPzsyhZRRYGNhpixMBZrjKCbGkzyIPjOjAPYw==
Received: from PH0PR02MB7159.namprd02.prod.outlook.com (2603:10b6:510:16::8)
 by MN2PR02MB6848.namprd02.prod.outlook.com (2603:10b6:208:1d6::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9611.14; Fri, 13 Feb
 2026 09:57:35 +0000
Received: from PH0PR02MB7159.namprd02.prod.outlook.com
 ([fe80::8e97:bc32:822c:b250]) by PH0PR02MB7159.namprd02.prod.outlook.com
 ([fe80::8e97:bc32:822c:b250%7]) with mapi id 15.20.9611.012; Fri, 13 Feb 2026
 09:57:35 +0000
Message-ID: <a45cff3e-2984-456a-8be7-0b136493c1d9@nutanix.com>
Date: Fri, 13 Feb 2026 09:57:31 +0000
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 06/43] audio/oss: convert to QOM lifecycle methods
To: marcandre.lureau@redhat.com, qemu-devel@nongnu.org
Cc: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Gerd Hoffmann <kraxel@redhat.com>
References: <20260127182516.289834-1-marcandre.lureau@redhat.com>
 <20260127182516.289834-7-marcandre.lureau@redhat.com>
Content-Language: en-US
From: Mark Cave-Ayland <mark.caveayland@nutanix.com>
In-Reply-To: <20260127182516.289834-7-marcandre.lureau@redhat.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: LO4P265CA0145.GBRP265.PROD.OUTLOOK.COM
 (2603:10a6:600:2c4::7) To PH0PR02MB7159.namprd02.prod.outlook.com
 (2603:10b6:510:16::8)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH0PR02MB7159:EE_|MN2PR02MB6848:EE_
X-MS-Office365-Filtering-Correlation-Id: ad9403cb-8254-4a1c-9489-08de6ae6503a
x-proofpoint-crosstenant: true
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|1800799024|366016|376014|7053199007;
X-Microsoft-Antispam-Message-Info: =?utf-8?B?ck1RRjlyNlZhTXVidUcvMHFyVmp2bk1xZ1BMazUzZWYxZmxIU1ZVQ3JIRndl?=
 =?utf-8?B?ckM1MDJkK3FQZlliZk9ScVFJdERuSlZ4ekFWMi9udllPWkRQU09yS2lHUjZm?=
 =?utf-8?B?N0s3Wkg4WlRZYUNXcHkxK3JOOU1maFlCbWgvdUZFU0diZ29qNFhjWWQyTENp?=
 =?utf-8?B?c0ExZFlzV2o2aGxhODJzSlJRZmZSbVp5b1BsZ0VickNUSGdEYnZJRTlScGty?=
 =?utf-8?B?a1VHcU12ME5EUnBvdkQrMHJNN1l3dWRMeHN0Smt6aStERDhPWnFHdy94VUNO?=
 =?utf-8?B?N3Y2MnZUdWxUY0ZVcFJKVGhCb0xQQlpFZ3hSblc1VEtFY3NObldzSFhiS21T?=
 =?utf-8?B?bHBMQ21jdWhOcWRUY20xOWRmYkVUeVpsMFBCNDJ0ZzhFUW40UkxBTktsbGlK?=
 =?utf-8?B?N24xaGo5RzFsODNvU0E3UzRNM1dPb2ZpMHk2YlNWWmVHZWRnQXVtOTZad2pC?=
 =?utf-8?B?NFlHa3c4T0ZHWjQreHlIdmZDTTVGcGNCVW01VHZBYlBoVk1sUXRHYSs1bmJr?=
 =?utf-8?B?bkNqUy9mRVRZK1VBNW5uK1JJN1pXYXlWRGRNdDdTSFFDYk5pQXhha1piRUFF?=
 =?utf-8?B?NUo1TkxjeStOcDQreHo3a3JkS2dMR2xqMDk2SU5pMVVQZUt3UXltcmo2Uzc3?=
 =?utf-8?B?OFhxU08yYjZJNGhhRWg1OGxkVGI3NS9wSlExYUxmMlZtUy80Q1B4dzcyb1dR?=
 =?utf-8?B?R1JTekE3UCt3TXJWYk5tT2lEeXM5RW5kMzdUM0lsY2pOQko4V1lYNUdKSWM0?=
 =?utf-8?B?cTUxRjg2aWhTa2o1RWh1S2lBeUZvTkw0cDI3dzNac2h0UXF4d3VoY3RZY2tT?=
 =?utf-8?B?c2dPbmxWVnk2LzFsOFdwNHV4SEhTOUhiWFFTQ3NEeWRJbUExUVQxZ1lCK0V1?=
 =?utf-8?B?NG5SMEZVMDJ4Q043bm5XMFBnNzN4RUFpTFZ0WlFzejhIdy9YODRsUWNxL1ZC?=
 =?utf-8?B?YmFJUFlockdVZ3hCSTR0bEJjY2szUzA4aVJNZUJNNk5VeHQ3YVVaU1ZXSlJ6?=
 =?utf-8?B?UmpCRDNsSlprb2NjV1FqaWdXNktFQUp0WmRCbjl4c05QTEM3eFZOY2orWEJG?=
 =?utf-8?B?MnpOc3ExeW1IVlFUTXB2czlYb24xOGxrZDQvQlpZdDVDNkN4bjkzWHFZUXNY?=
 =?utf-8?B?aXdRV0JXN1BYU0F4V1Qva2dBN05TZEEzak8yRHRjUFB3WVQrbXdLWDFZS29n?=
 =?utf-8?B?WWNoR0tSTUc1MEUxVUVLaThDVmhLUlJoeDIvNW0zbGM0K09xS3h1UkZJd3ZU?=
 =?utf-8?B?NXB2VVVJZnJkY2IzdWJmWlBIeFFkd2MxQ214eGxXVnAxdTREeFpIVTFLa085?=
 =?utf-8?B?T2F0SUJ0dUJaRVVVNFNnTGV2ZzN4UDhGNkp1bmxRcGZiT2piVC92dU5xUnJr?=
 =?utf-8?B?eXlzekIvOTZlY1BaTXU1U3l2N2dldC9EQ2FqZWJ0bG9ENlUyMCtEbXZsN3Nu?=
 =?utf-8?B?cVQ5NHlUNFQ5VG10NzVEUFpKcDhOOERoMC9XMGtZVGFSSWwzQTN4WWlOQThy?=
 =?utf-8?B?WHVDeEZrYmk2ak1xMWFxb291OWY2SCtvdnNRNnFpaTA5bVg3bDJJM0VlTE03?=
 =?utf-8?B?S2t0NkV4UlVIemMrZWtTQzNZaW1kUE51YzRnOU42aTljeDh0TGU3YTF5cXZV?=
 =?utf-8?B?Wi83b3hTRTFMaFFibURDNklITWFORndLeXJuRFdQc1J0UHQzUFZITTZjSzE4?=
 =?utf-8?B?cEtQdlFGU0lNYnRKQlI4QjA0ZlpjckdXWXJqNDZlbDJLSU5NamJyWWU5RFI4?=
 =?utf-8?B?SzJ2a3FHb1NBQ0VMNmRjQWVqWDk5QWsyUWxQRXBBYVdVaDB6bVo0M0J4b1B0?=
 =?utf-8?B?QkJqd3JHN2xRcytOa3hzWTg0U0owQU1zR09xQW8rbEFnaDBPMFR1bDMvZjBi?=
 =?utf-8?B?VWdZb0V5RmdpQk44MERZUjI5dTJieUhWM2pHd1M1eGVTbGpndHREaHdDRkJy?=
 =?utf-8?B?M1N4VEo2Wk5yNFFZYmtOVHZaamdaY2ZUZVREZXNSQ3gwNk5HUkJJNXRwYXlW?=
 =?utf-8?B?bmZhNEUwSGJYRFd6VGpxYXlkUVVHTmRQNHNXY1JtSVJHM0Z1SG1JdHNMQ0hB?=
 =?utf-8?B?RDluTk9Iekd2Y2Y5U2prdFZJcXIyUFBoYkovT05uZmNJRVR6QnNRVVdVbm1I?=
 =?utf-8?Q?oSFc=3D?=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:PH0PR02MB7159.namprd02.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(1800799024)(366016)(376014)(7053199007); DIR:OUT; SFP:1102; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?NGFFa1N1c2dmMGFwbmRHckJoUDN2endDZGFzRFdoN0xXRkVjSEFmSEJRT0VW?=
 =?utf-8?B?eFdGLzV5K2oxUEVOTEtOOGI1WlBhKzM4ZUlIV01BelZTRVRIUS82ckZ5N21v?=
 =?utf-8?B?Q1RreG5HQVhLd0NyMDZJV285L2lGVFE3SXlHMmgwMExqRFRMTW9xVjJaVFNo?=
 =?utf-8?B?SmdvWDZaZ1BzQUJIcXBZRTI5dTZQTjFZOU1wbnhQcEl4Z3ZjY0pxZkJwZzV0?=
 =?utf-8?B?SFNlWXcweXo1cGZWSEk0QW1qY2hTSFdRbWppckpsRysyRngrOUxOQnNWa3Bw?=
 =?utf-8?B?VlFBUlVsL05qa2JqQXFXUFpHWkc4R1dVS1pvMi8xcXpnNFdjSWJ2VXpZWTlX?=
 =?utf-8?B?aFl2UmthTGdtcXVpUlRScTIyQ01xV2pxdmhoSmJhWlMxMzR0NlJ6UVpaZjdl?=
 =?utf-8?B?SHpsWUJ4c3IyMk9sMUN5a29tWlFYZHE2L0NFd1hpVzFyVEZ1VVRCVXMra2U0?=
 =?utf-8?B?ckJDVThOMVFDLzE0UkQyRWFjSkxOS1p1K2VhcWp3R09kUkJFY2Q3d0lrYUpZ?=
 =?utf-8?B?ditkWldCaHhOMDIzSTE0Tzhub0dBaFpWYVRpR2ZxOTZudkY0Mytza1AwQmpj?=
 =?utf-8?B?YlB3MmVOVXhHWkRad2xXV3BZZUsrcVdDcHVPYm1rSURKcjFOcXhHK2xBMXNx?=
 =?utf-8?B?Ymx3U0F3eXc4V1ZzOHV1b29rMmw0dW1GZjdlUjJReHppNit6VXMyWWx6eGFO?=
 =?utf-8?B?Z2pjcU5Vemc3Q0c2dVJheGVNaCtTdzJWWDNpU1JmanR5Mm9HWVg5SWVPR1Fp?=
 =?utf-8?B?S05UUUlyK25aamJ5NmU0ek1qRzhjUVJNWU54cEpJQW5GOUF2N0FaU2llTmZS?=
 =?utf-8?B?Nm5qaGVLNlJrWWJsWW9jMzAwZnNnT0cxWWVIbWNJTmh4N0o1U0FTdCtvcHZF?=
 =?utf-8?B?blU1TVhCUDd6cEFrWU4vM2E4dzhFSkpKSXovWGVEYTRBT0U5OUFCdU5wdWZG?=
 =?utf-8?B?NXlpQkZRVDdwTklBMkw1NWtUbkRBcXVGcHpDTFJyYmgvblNMdFRwTXgyU0VR?=
 =?utf-8?B?RURMcTBEMitXbmFDSXYzMUVqNlhFdnJ1VmJHMkh5QVRKengvS0ptWko0WCt3?=
 =?utf-8?B?Y1dZc1NKVzZNWitEMmJsbjlZclgzeTM5NTNwNFQxVTlEQndOeFRUSHBUUHly?=
 =?utf-8?B?RXVmNlhQOGsrRmJ0YXpXRW00MWhaUFhhR0hpT0p2LzFRVzRuVnQrbG1TYStD?=
 =?utf-8?B?czV0Vi9NZXU2UVlVQmluUGdkeGdleFEwN0JDZS9jY05ETThyNUNyVXVCanZr?=
 =?utf-8?B?V0NWVHkzQnBJTHExdEZzM1NpMjc2NERsZVFNUGU1RitmNmlQUkludTJ5RWpM?=
 =?utf-8?B?K0xGSEhzcnFZaTFPdCtDc2MvN3E1NTM0OGgrTm4vNm1SUzFnN01rWXRaa21P?=
 =?utf-8?B?VHBRblJrYTNFRHpYTExuR3Q4OHJQNDNwUkZWdzVCL3UyUHVnenByUkkwbVdP?=
 =?utf-8?B?OTg0eUgwSVJReVRxQXU4NTdNK1FvKytmWWF3ejVldkF5ZEZIZmFJMHJRNmJl?=
 =?utf-8?B?d2E3bmJBMWg1QUMvR1BjRGI3aHo0d2RuaW12MjNIZFlGSG5FY0k4UlRTZm80?=
 =?utf-8?B?RjBJM0hNa3BlaHB3YlpFMzJodko4WXFUeExJQVp3TGNCR21sWGd0MlpDVXhl?=
 =?utf-8?B?b1FUZTdSUUxiUis4enZSM0taRFE1bzJWb2xXNkxSNnBMSURmZEVRbVY3bzJ6?=
 =?utf-8?B?Z0YycVoyY3hFOEZFRWVORXVpK3RzZ0VhbEorcGhBcjNtMWErU3ZpaVBwRXhG?=
 =?utf-8?B?TFlzYWErcGV6MzlLMDJ2SWRLZXJMYjkyODFmOGl6UFhWMUswT3plM1hLemNm?=
 =?utf-8?B?Skc5TUZNTkYzdFRidWtYb2ptdEQzNkxiRUsya2pMZXY5cUN2VzUrcUoyNDYw?=
 =?utf-8?B?WTJZSTRFT3VtaUVQRFkvd0R5ZVk1SGczUmhDMzVPN2J1aHVqaTkvTGxNQU0z?=
 =?utf-8?B?Z0N0QjlRcVNMcFgzSUFVeE5xeWhmdE5ScEYyMjlsazJLbUJ2U1hUbmFMeEhq?=
 =?utf-8?B?QkRHR2NIZG50Qmg0Rk96ZEUxWTloYVNtZjk3ZGNkcm0zSTdrekRzbm1sOUVW?=
 =?utf-8?B?akFxS3B4OWhWYUpCNktueXpGTXVROGxhZDM1T2wxYUIwd1JVM05WaGVFbXRl?=
 =?utf-8?B?ZXBPMXNOVmRiZEMwT0d6S2lrSHNSRW56eXI2UStlUCszNnl0ZkJ5ZUlRbDFJ?=
 =?utf-8?B?bTdNVVpTdHRIWnpTL2MxUHJFVU4zK3BVQTZzRElDNEViOWg1b2liUkJSTHky?=
 =?utf-8?B?RDgxbGlwczB6aGRXSmYvL25jcGV6UVB3QTE1aEN3MngxOS82VmxIQzN3d1p6?=
 =?utf-8?B?cFRmVEEzeThMbkZnazVpNUU4OVlWdHJPSnY2NXM1cU1ybEVPYjFWMVZnVldY?=
 =?utf-8?Q?THSAJaKEgz+2RoJ4=3D?=
X-OriginatorOrg: nutanix.com
X-MS-Exchange-CrossTenant-Network-Message-Id: ad9403cb-8254-4a1c-9489-08de6ae6503a
X-MS-Exchange-CrossTenant-AuthSource: PH0PR02MB7159.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 13 Feb 2026 09:57:35.6467 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: bb047546-786f-4de1-bd75-24e5b6f79043
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: beT4aZWLzhH8w7cAkFr7FKyOc7xsFY21rYNPbeTHSrQJt5E1OAk2ZuYmK3FWBqAq908lQmM/P/yS1y4cXPyJOM5xkeGMsPbZ/QfMbhnkagU=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN2PR02MB6848
X-Proofpoint-GUID: YxSRUAisxEt8N3NyhHIg2pJhwrNfwClz
X-Proofpoint-ORIG-GUID: YxSRUAisxEt8N3NyhHIg2pJhwrNfwClz
X-Authority-Analysis: v=2.4 cv=CegFJbrl c=1 sm=1 tr=0 ts=698ef593 cx=c_pps
 a=i9AYdY+muJfbJY5DtBkDBA==:117 a=6eWqkTHjU83fiwn7nKZWdM+Sl24=:19
 a=z/mQ4Ysz8XfWz/Q5cLBRGdckG28=:19 a=lCpzRmAYbLLaTzLvsPZ7Mbvzbb8=:19
 a=xqWC_Br6kY4A:10 a=IkcTkHD0fZMA:10 a=HzLeVaNsDn8A:10 a=0kUYKlekyDsA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=Mpw57Om8IfrbqaoTuvik:22 a=GgsMoib0sEa3-_RKJdDe:22
 a=20KFwNOVAAAA:8 a=64Cc0HZtAAAA:8 a=4LVTTFkr40IfCdBqwq8A:9 a=3ZKOabzyN94A:10
 a=QEXdDO2ut3YA:10
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwMjEzMDA3NiBTYWx0ZWRfX1ApGfFegkspM
 VpSQHSDPTUSfdOr3XE8nLlN6EnekPYyxpi/GNWIfpH2F74KQotebWLyS6lAlL4g7yCuScOybJ0I
 CNzixxemBf4+smt6Dur/8fGS6Zk9IKzhvqTYGDrauoYYQMBM08m3I7r+/3vGydKFlgGbeAqJhkp
 Q+mE4chJKWEQLHTCRNczRKse4UZiTsGMAi9ZgDijtpSdQpBbr+EcL7S5Pg0oc+w31PfI/h5Kr8Z
 SD3SFwlhn4fZNWVwCfiTeuUsnZRi8CtiB2GdqJLra6WK8z9CqlVLISXdE8DOR+9iTOlVj0RelBT
 xYHnjpSbfP8OfCF/eNzSBaRXpiYDkZ2ywvuawP/BFJwzW8MK0f12pewHPx0Ex+kxA0eWuAmkxYm
 rUATXaJZY+GbmN3QBp+pGQQJ1wRSQd8chzu9GDV8gLCmnAnarxpxWdvhT9t995fzkgUqXMcpXJB
 SdklrFA8OPGwE93xp1w==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1121,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-02-13_01,2026-02-12_03,2025-10-01_01
X-Proofpoint-Spam-Reason: safe
Received-SPF: pass client-ip=148.163.155.12;
 envelope-from=mark.caveayland@nutanix.com; helo=mx0b-002c1b01.pphosted.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001,
 RCVD_IN_VALIDITY_SAFE_BLOCKED=0.001, SPF_HELO_NONE=0.001,
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

On 27/01/2026 18:24, marcandre.lureau@redhat.com wrote:

> From: Marc-André Lureau <marcandre.lureau@redhat.com>
> 
> Migrate the OSS audio backend from the legacy driver init/fini
> callbacks to proper QOM realize method.
> 
> The oss_audio_init() function is replaced with audio_oss_realize(),
> which performs the same device accessibility check before delegating
> to the parent class realize method. The empty oss_audio_fini() is
> removed.
> 
> Access to the Audiodev is now through hw->s->dev instead of the
> drv_opaque pointer.
> 
> Signed-off-by: Marc-André Lureau <marcandre.lureau@redhat.com>
> ---
>   audio/ossaudio.c | 37 +++++++++++++++++++++----------------
>   1 file changed, 21 insertions(+), 16 deletions(-)
> 
> diff --git a/audio/ossaudio.c b/audio/ossaudio.c
> index 013958e1344..e745149ca39 100644
> --- a/audio/ossaudio.c
> +++ b/audio/ossaudio.c
> @@ -23,6 +23,7 @@
>    */
>   
>   #include "qemu/osdep.h"
> +#include "qapi-types-audio.h"
>   #include <sys/ioctl.h>
>   #include <sys/soundcard.h>
>   #include "qemu/main-loop.h"
> @@ -39,19 +40,14 @@
>   #define TYPE_AUDIO_OSS "audio-oss"
>   OBJECT_DECLARE_SIMPLE_TYPE(AudioOss, AUDIO_OSS)
>   
> +static AudioBackendClass *audio_oss_parent_class;
> +
>   struct AudioOss {
>       AudioMixengBackend parent;
>   };
>   
>   static struct audio_driver oss_audio_driver;
>   
> -static void audio_oss_class_init(ObjectClass *klass, const void *data)
> -{
> -    AudioMixengBackendClass *k = AUDIO_MIXENG_BACKEND_CLASS(klass);
> -
> -    k->driver = &oss_audio_driver;
> -}
> -
>   #if defined OSS_GETVERSION && defined SNDCTL_DSP_POLICY
>   #define USE_DSP_POLICY
>   #endif
> @@ -505,7 +501,7 @@ static int oss_init_out(HWVoiceOut *hw, struct audsettings *as,
>       int err;
>       int fd;
>       struct audsettings obt_as;
> -    Audiodev *dev = drv_opaque;
> +    Audiodev *dev = hw->s->dev;
>       AudiodevOssOptions *oopts = &dev->u.oss;
>   
>       oss->fd = -1;
> @@ -636,7 +632,7 @@ static int oss_init_in(HWVoiceIn *hw, struct audsettings *as, void *drv_opaque)
>       int err;
>       int fd;
>       struct audsettings obt_as;
> -    Audiodev *dev = drv_opaque;
> +    Audiodev *dev = hw->s->dev;
>   
>       oss->fd = -1;
>   
> @@ -737,7 +733,8 @@ static void oss_init_per_direction(AudiodevOssPerDirectionOptions *opdo)
>       }
>   }
>   
> -static void *oss_audio_init(Audiodev *dev, Error **errp)
> +static bool
> +audio_oss_realize(AudioBackend *abe, Audiodev *dev, Error **errp)
>   {
>       AudiodevOssOptions *oopts;
>       assert(dev->driver == AUDIODEV_DRIVER_OSS);
> @@ -748,17 +745,16 @@ static void *oss_audio_init(Audiodev *dev, Error **errp)
>   
>       if (access(oopts->in->dev ?: "/dev/dsp", R_OK | W_OK) < 0) {
>           error_setg_errno(errp, errno, "%s not accessible", oopts->in->dev ?: "/dev/dsp");
> +        qapi_free_Audiodev(dev);
>           return NULL;

Should this be "return false" instead?

>       }
>       if (access(oopts->out->dev ?: "/dev/dsp", R_OK | W_OK) < 0) {
>           error_setg_errno(errp, errno, "%s not accessible", oopts->out->dev ?: "/dev/dsp");
> +        qapi_free_Audiodev(dev);
>           return NULL;

And also here?

>       }
> -    return dev;
> -}
>   
> -static void oss_audio_fini (void *opaque)
> -{
> +    return audio_oss_parent_class->realize(abe, dev, errp);
>   }
>   
>   static struct audio_pcm_ops oss_pcm_ops = {
> @@ -780,8 +776,6 @@ static struct audio_pcm_ops oss_pcm_ops = {
>   
>   static struct audio_driver oss_audio_driver = {
>       .name           = "oss",
> -    .init           = oss_audio_init,
> -    .fini           = oss_audio_fini,
>       .pcm_ops        = &oss_pcm_ops,
>       .max_voices_out = INT_MAX,
>       .max_voices_in  = INT_MAX,
> @@ -789,6 +783,17 @@ static struct audio_driver oss_audio_driver = {
>       .voice_size_in  = sizeof (OSSVoiceIn)
>   };
>   
> +static void audio_oss_class_init(ObjectClass *klass, const void *data)
> +{
> +    AudioBackendClass *b = AUDIO_BACKEND_CLASS(klass);
> +    AudioMixengBackendClass *k = AUDIO_MIXENG_BACKEND_CLASS(klass);
> +
> +    audio_oss_parent_class = AUDIO_BACKEND_CLASS(object_class_get_parent(klass));
> +
> +    b->realize = audio_oss_realize;
> +    k->driver = &oss_audio_driver;
> +}
> +
>   static const TypeInfo audio_oss_info = {
>       .name = TYPE_AUDIO_OSS,
>       .parent = TYPE_AUDIO_MIXENG_BACKEND,

Otherwise:

Reviewed-by: Mark Cave-Ayland <mark.caveayland@nutanix.com>


ATB,

Mark.


