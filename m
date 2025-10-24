Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id ED636CCD1A5
	for <qemu-devel@archiver.kernel.org>; Fri, 24 Oct 2025 09:18:10 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vCDvj-0002KB-Ha; Fri, 24 Oct 2025 05:17:51 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <lucas.kornicki@nutanix.com>)
 id 1vCDvh-0002Jm-Ha
 for qemu-devel@nongnu.org; Fri, 24 Oct 2025 05:17:50 -0400
Received: from mx0a-002c1b01.pphosted.com ([148.163.151.68])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <lucas.kornicki@nutanix.com>)
 id 1vCDvc-0002KV-QR
 for qemu-devel@nongnu.org; Fri, 24 Oct 2025 05:17:49 -0400
Received: from pps.filterd (m0127839.ppops.net [127.0.0.1])
 by mx0a-002c1b01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 59NK2csQ2709631; Fri, 24 Oct 2025 02:17:40 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nutanix.com; h=
 cc:content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=
 proofpoint20171006; bh=TT33wyqlXM6IStr7uoqQOYeyL6jUbly0WDKah1LC6
 ec=; b=rnp/wppJNX+NyiS4HwUy6QF+Y3/8YLca6uzyJOBUJlXOp2e7yvzWMconp
 rHB+Ii7Kb3SLk2zpAI0ciI76H/kMJSf9QoNj+hhJowzIfTznzUd3YKaMC+kvYnN2
 xFALmu1PeA+TvV3Yaw9qDd9Fyg8QJE4PGMlRN6ZEv/BWvPmcrEK9j+NdT4H6HZlc
 50nF4eMLxxx1i1M4D4TqF675lEoou7UAmWtH5mRiuDy3KGuGSg76DT+4MyVer4fC
 g5kEr5VAvZM47oyX8MWgypz2/BmqHKULSr3dy2yfYruto2gA+KpzHb6KKwuuXuFX
 Auh/a0he4UqnXqwp3lM6170JsfiZw==
Received: from ph0pr06cu001.outbound.protection.outlook.com
 (mail-westus3azon11021110.outbound.protection.outlook.com [40.107.208.110])
 by mx0a-002c1b01.pphosted.com (PPS) with ESMTPS id 49y7axux66-1
 (version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NOT);
 Fri, 24 Oct 2025 02:17:39 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=t6oHVILIncoXzRxoUJdFDjbbWGssKDGBQYl+uv01M8GKBBYZsE9z4lOoc+Fwj3PYot+4evSoeZrUYbsLiL1hg/nzPE+PlzK0TgT3U8LXpTIW8XMo7+UqpUyrPLpQjYRbVlWd1lzO3ZovO7rMHAVa22nLBY+MSFp3qy2sZNvwQZBkUxiYjsmPJZagRDlqX05qqiEywapxVl5UBykUPdTS6aC5RoOhRFgo9lRmPiQpxwx8NNPIJu5dsJdr3Vq4802mtw9skZr1Hqr2A/a3tD0+Yl/t3kX3Qbn/oznRq32V9km0lZsXyew2XdvCeEMW4CY3RcGqRTtkzaAMKK70IjzB8Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=TT33wyqlXM6IStr7uoqQOYeyL6jUbly0WDKah1LC6ec=;
 b=FmNnvp+A7niLvXQ0rHRiWqdtCojTHP3BD0k+jtDqa8cR+GHcBYP0J5WzcC293KEUrlQKKuNgrYXktSshVZnHTrDh4g07C5hBsHUWM9TTwH8CCl8EGWxPoPea9QXQyu1Y00TqUEDsQv35WazxkB29OCOa/DjJLIhhAmo1LILCuFi56j/U2U2htd1LKd57fk0FA7qkzTd167RV+2UpZBIHt76i7MUJbPmYqKuhVlM+hTy1vgLvVmzHQ5+xqgUYH+5qhOW0gg6ClErrKMeWjWcjaipYVKlH04WTPCDjg7PYlZkigx3zrAXkk1EutyQGNLPzarsyK0sk7kh57RO1dCgRbg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nutanix.com; dmarc=pass action=none header.from=nutanix.com;
 dkim=pass header.d=nutanix.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nutanix.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=TT33wyqlXM6IStr7uoqQOYeyL6jUbly0WDKah1LC6ec=;
 b=CAmcjaNWketQg0Pq7LV3nZwbaOWD9X1bGPOb/WBUTQ+vpoV5y1A7LacG23oDwTwFayw48HLgDI1fZ0rkJJm9jiC8fMZZuM6NFewNPCj8pFcCNrBaGZrZ4KCfAb36uJp5wwL2iKZtqKJZPKwoH4dp8EHCMN3/jRHfElGCP0mX2Hm9pouCi2THz59FNxMgE6UKviYlrvVvJqnp+El6+NC3vPkntPh88hprfypJOSIBORDhEW6jCEMCfuKx3xm2RRQWptFvgbS+jh3Xsd5v9aO06Yvk/FwVsYetVq0OwtrQHSkAcABzXnrsJ/B9z87FdCvG4qB9TMsTUgf9K8vfZ39P5A==
Received: from BYAPR02MB4838.namprd02.prod.outlook.com (2603:10b6:a03:48::29)
 by DS0PR02MB10711.namprd02.prod.outlook.com (2603:10b6:8:1f1::14)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9228.17; Fri, 24 Oct
 2025 09:17:38 +0000
Received: from BYAPR02MB4838.namprd02.prod.outlook.com
 ([fe80::4292:5b12:892c:5222]) by BYAPR02MB4838.namprd02.prod.outlook.com
 ([fe80::4292:5b12:892c:5222%6]) with mapi id 15.20.9253.011; Fri, 24 Oct 2025
 09:17:37 +0000
Message-ID: <de45b425-435c-4ca6-a1a9-59bc584e96a5@nutanix.com>
Date: Fri, 24 Oct 2025 11:17:32 +0200
User-Agent: Mozilla Thunderbird
Subject: Re: The impact of vdagent migration support patches on windows SPICE
 agent
To: =?UTF-8?Q?Marc-Andr=C3=A9_Lureau?= <marcandre.lureau@gmail.com>
References: <56a2ea44-7633-4858-8b04-def663322af0@nutanix.com>
 <CAJ+F1CLLdJiCrn6o+gGSMUN4mc4d2AohveT=2gSM5FtwZL=-TQ@mail.gmail.com>
Content-Language: en-US
From: Lucas Kornicki <lucas.kornicki@nutanix.com>
Cc: qemu-devel@nongnu.org
In-Reply-To: <CAJ+F1CLLdJiCrn6o+gGSMUN4mc4d2AohveT=2gSM5FtwZL=-TQ@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: WA2P291CA0005.POLP291.PROD.OUTLOOK.COM
 (2603:10a6:1d0:1e::11) To BYAPR02MB4838.namprd02.prod.outlook.com
 (2603:10b6:a03:48::29)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BYAPR02MB4838:EE_|DS0PR02MB10711:EE_
X-MS-Office365-Filtering-Correlation-Id: c84d1045-fa8d-4cad-6812-08de12de2c98
x-proofpoint-crosstenant: true
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|1800799024|376014|366016;
X-Microsoft-Antispam-Message-Info: =?utf-8?B?RkV5M0k5cWxvRGhOWTdwNStIaTZZeERMTHk0SHpJeEt2VXdJZVl3YnBmb1Er?=
 =?utf-8?B?YWFGYjBCejd2bE03UktlOVplNnowUnBPUG5yS1V6NDVPN2VhQVJ6WUVMU1pK?=
 =?utf-8?B?VEhZd1lBNnRoa3BOaDhtdkR3NndyMmRCVFpvUkRONEx4Z3JMelRyU2JvVmxJ?=
 =?utf-8?B?NVozMWFWTHFvbXhyK2dWNFJWVlE0OGFhQjRtWEdUbmM1dlNZdWY0eHZ5REhs?=
 =?utf-8?B?Z3o4S2VCelM3ZHNVYlQ0NGNJdTZLNGhmVUYvcTJJZTlSYXYyNkFBeC80amht?=
 =?utf-8?B?RzA3V0xqZjJXZldLOFIvUWpQZXp1RUVXYXg5Z3pFUStoQWxhZ3hnQ041S1ZU?=
 =?utf-8?B?bE5hVlB0dmNXdmVTbWJNVVlxYnY5S3lINmt2VHNhZmVBSmdBOWYxOWpVWlBy?=
 =?utf-8?B?NVBkS0Z6dk1KUEF4Y0ZMamk4ME1IYk9DSWkxRlUxc08xZkpRRGlVODlybks4?=
 =?utf-8?B?czZQRWdPTGRsMGZZWXRMQi9udUZOa1llQy9XZUloU2VqVldiMHp2M0xnZVRW?=
 =?utf-8?B?SFlaMGRySUc1dnFHdjQyUUt3Z3pZNVl4bHNPUCtDSUJQZDdkL1JzbVdXUVhH?=
 =?utf-8?B?NHVwVURIYnV0U2JKNDAzSG9WRmNJZXVXUjE4TE93R2o3WmljQjhpbm1tbndT?=
 =?utf-8?B?WDduV1NlNkIvRnhnRWhkdUlaWnJNV29HeHpiOU42SUJiM0RzVU93VDFwWitS?=
 =?utf-8?B?bGFKTzhYWkRJUE1zY1c3RUE0WHNrWk9JVVNvbzQraTdMRFFPM1NXaXFwaFAz?=
 =?utf-8?B?K2NHRXZYaHRGRXdOT2lCZ0FZaGlKL3ZPbVhLZzlvUXh0RWhsNklEQjNBZlkz?=
 =?utf-8?B?UW11WlI1ZWg3SFVMRTZ6MmwzTzVzcTFuNGhaaHpwZ3hyQksyaFNESFV5T0p6?=
 =?utf-8?B?WlBtT3hEdFpkaDB0K0RCTFd2ZXJPeGtSQm5QUUdIQ2FzS0tiVWtBWWxMMm5a?=
 =?utf-8?B?Tno5VTZYL0Z3bExsSWVtNDV6ZjllUEZZK0k5VU9Jd0YvWkpTcXltU0RQMURj?=
 =?utf-8?B?UzRDL2Q5bEFsZFVvNC92WnhMMXV4cEluUlozMkR3UXZMWHoxanJod2tPbllL?=
 =?utf-8?B?cFJYbFpZTTJ6KzhxdG5JTUFNOGd6MUVxNnZVOUxaMUR5RmJQdTd5NjVhdGwz?=
 =?utf-8?B?MUJ6cmRXcTFPKzIrTzFvdFNPaWdUSGMwUXR3SGhwTVFIbEJjNzlHYTBQWUZY?=
 =?utf-8?B?T0NWQXd6UWNESC9FNGprUC85eXVRaU40dUU4ei91eisxcUZUUkhwVThRN0RZ?=
 =?utf-8?B?MFhVV3RPZVUxYmQrQXRCN28rYVZxbmpueWkyRDVsQjh6TjUwbkhwbk9YUWpJ?=
 =?utf-8?B?T3dKbGt1TXE4eGE0Nlh2YzFZWGljeTNrem9zQkZsakMvVnBEMHVQTTVhQ3Zr?=
 =?utf-8?B?bFREMitYYndZYWxGcWRnQ1Zxekp5UWkwU0ZSQUZnQ1RnNzdibU5pczNGQU1r?=
 =?utf-8?B?Tm41MVBxTGREUXlDUC81TndvbEEvbVFXUUZycDR0MXluVDJvYi83aVRqNHlE?=
 =?utf-8?B?bkdnUk1xNnIyQW9WMUdjZ2g2UERmaGZxUlJDT05GOTRKZmZ4NmRyR3R6ZmlI?=
 =?utf-8?B?dWpXeVRzWnFkUWloRDkxYWdPOGlTeW5rODMwdGU3bElMZE5SV1UrN251TmNU?=
 =?utf-8?B?cDJqRFI1RlRFcDFZdWJlTnFGS3ZYelRVV1FWdEdYSmlUcGYwbWt4cWVBZFlz?=
 =?utf-8?B?bCtWeFRqMkFEY3o2VENiS2dSNjVoNnpaZzBsR09lL2pLYmpUa0ZhK2NLY3g2?=
 =?utf-8?B?am9lOXN1NzNxZDlKdDY4NmIrUTlpMXpuU2QzckxIcEZIYWhlVmZ2azRJV2lJ?=
 =?utf-8?B?Mmt2TXpoVjNoUDRxa25mSHk2WlBWcDZnaE1hY2lVcW84R1ZGY2ZRSnlzTXpo?=
 =?utf-8?B?dnd1b0dYb3hSdjNrQ3JmckNnR2FVSEcwVVFVWW1waHNka0E9PQ==?=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:BYAPR02MB4838.namprd02.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(1800799024)(376014)(366016); DIR:OUT; SFP:1102; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?b093NFBsdWVhQmhkQ3Rzb29rRGhHY3VKdExac3MrSUxueEdTVDk2RGovMXFn?=
 =?utf-8?B?M1lDVTVhU0ZtWnUyKzZwWmppU21jSFBUdmxZdndlVnd0OEp0cVAvYnc5Q0lS?=
 =?utf-8?B?RmI1cXp4NmQveUh1VUxIcnFHNjYxK3JxK1ZYQTJZSzhUNXdjU09QRmpPdnhk?=
 =?utf-8?B?RHhKcCtuZGdVM3FuU1o3OG1JSlV4Z0t0SHRvb1BIZjMrV1ZkLytHallNM3BH?=
 =?utf-8?B?ZVZaSytTSXJzaWx4MGxCSjBGZ0xxZjA3K2U0S3k2aWl3VG1zZ1YzY0dxeGFK?=
 =?utf-8?B?djJSZ2pJWldubHVycGNLMzZVVkoxVWszb1I4NEx1ZXZIWmFtY3FBa2RHakVv?=
 =?utf-8?B?cU1aNXIrNDhGWnpRSVRGR3ptLzdiV09UVUVMR0RwcGQrRWxCa3kxb2hDTFBh?=
 =?utf-8?B?Y01qMUtEZmZWVHdSYlZYRXdYTllpNkFINUZyREJOdDZGWmhMYVVyVWNZOVZh?=
 =?utf-8?B?OHZ6enhOWHRlenZBZS95SFlVWWhpWHNqeWUzN1NPWFRoVm9jNEdRSWRGUUxU?=
 =?utf-8?B?MEJmakxhT3BwdzhnWXUrMFBGQmp5TVFrVVMvanFtOG5UQ0owWnJjeCtmY0p1?=
 =?utf-8?B?TlJyaWMremhGWSt1eUJieXFFTXdJc3Erc0NpSVRGOTdLa2ZsaktVbWVTMElF?=
 =?utf-8?B?Z09tSFVBTVRQcFZ1dlJ2UWE2V09XbWNHVzhPQUQ2MHFuZVFYKzVZdFZQUEtF?=
 =?utf-8?B?S2xkLzUvVFFnVUhjVTI3a1IvbWRFZi9WU2U1UEtybHNNbWRuRGFzS0pIbXBH?=
 =?utf-8?B?b0Z0SENoQ1NaTjdaemRGSi9jKyszcW9uMk9CSkJkblpXbW10WlIycW0rVjM5?=
 =?utf-8?B?REJhSnZuaVc4VWcxcUJOam00b2kydWxWOHBxc2NieVVqR281cmFHdHYrUzBC?=
 =?utf-8?B?YnpSd1RlWVd3MHBGazNJN2syVFpINDVQK2xZQzhXWlhNdUFCUVRVSEdwUWp5?=
 =?utf-8?B?NzBydENWMjlPT0dPRlp0NWd5UDB4RDYxRmNjRGlxV053b1BFc1pndE9Va0dY?=
 =?utf-8?B?UXk5dWdpSVh6aURPL2U4YUdaZnYrRmVpV25xY2FvM2UwRk1vaHNtZzNPN295?=
 =?utf-8?B?enNneG5SWGkxbHJXWENqaDgxNy8vNFQxbFZ0dTJqam9FZ1BDWi9WNTFOOUsy?=
 =?utf-8?B?VGQwc0JRS0Y0Q25EYUhWMWRmVFM4VldVYlA3cmhmVGhtSThualZYUGZodTVi?=
 =?utf-8?B?a2ozcG1LWHp0ejBVRit2VEJKSjJyRzJQYW1PSmx1WVoyQnA2TzhuaEdSUUly?=
 =?utf-8?B?Vk9BcCtDVUxxSFFCVTZUNVVITlRnVFVUT1dCMEE3QkxsZ0FhbmdNMXFOYnNk?=
 =?utf-8?B?T1psMUhnOC8xVENvU1RQMjRlZEErUUwxZCsxdUxNaTU4NEthV3B0ZkxrUUd6?=
 =?utf-8?B?RjBNWFdCMUNNVjEvNTNadVlac0dTeFBVMG5HZk1MRUFNQlo0aXgvMXpSZXlL?=
 =?utf-8?B?V25JL1IvWUtPdS9BN0Y4VG82UGNYSzVSdnd5MHBUMkVzZXd5OFp1L0RzQ1Z0?=
 =?utf-8?B?d3BTVTk3MHR1M1BCUlNvaDFpZGtDUks2UXNTOWpMNEs4OEIxMnM4Z1VwZCtY?=
 =?utf-8?B?NmM4d2lEWVVESFJHQ1ZZZC9OSHZGc250eHdXSHpJMG0ydE1jTFdzNjJEQVpj?=
 =?utf-8?B?bzlRbW45Ym8xUlcwaUZESWRTc3oxTis3NzBVYkdZOTAvM0l1WlR6S3VERExj?=
 =?utf-8?B?Nk5zcjg1YUFZWEZtME9BQ0RDeU5WbG1XVmZHWFNzVHhaV3lxZFpUT25PUFA0?=
 =?utf-8?B?bUwrcFEyeDJYVm8yL3plQ1AyZFhQSXZySGQyZFpvTjJrenZNNnNld2xzajdl?=
 =?utf-8?B?bmdMdjBlVXVybHZpSytnRzhIRUVQbWxNTmlFT28remN6YWk2VUtPNlkwb1VW?=
 =?utf-8?B?bzMrZTNPUUhCZ0JuZVkxY3dVWm9FMFNlWjBJSnBaQXBabk16SnQ1cHh0UHRw?=
 =?utf-8?B?NjdFU0orTXphZkk1N1QyYmpNOVFQVDJ6c2JwUFEwKzBub3E4THo3Z2IwMGhV?=
 =?utf-8?B?NStsRWVqbEZ2VHlXa3ZwalBkd2VEaGlpNG94UEJNa08rYlBUU21uejBHZVdo?=
 =?utf-8?B?T0kyV0ZUSTAxRjFRc2p6M2dlcDNvdmdLMDVjRTRtNmRLWTRDQ1RMNGEwRjM1?=
 =?utf-8?B?T0pneVkraEg0bWp6a2piZ2lkV2trSUxmRXorRERIeVE0SHBXRUYrZ2Zhb2pY?=
 =?utf-8?B?VGc9PQ==?=
X-OriginatorOrg: nutanix.com
X-MS-Exchange-CrossTenant-Network-Message-Id: c84d1045-fa8d-4cad-6812-08de12de2c98
X-MS-Exchange-CrossTenant-AuthSource: BYAPR02MB4838.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 24 Oct 2025 09:17:37.7353 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: bb047546-786f-4de1-bd75-24e5b6f79043
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 4nMr+H4fpBOVmU4mv/GrhA2UdNKVb2EHZRmGYzm87hP6gynGmy65XSssg9wHokzGD2NyvUWd07N5buDPv076zy4cQY+3JUOaF2m8BMLr1Dg=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS0PR02MB10711
X-Proofpoint-ORIG-GUID: UrB6pBSqiAwU7YBa9_jNus7Ma9AiTtAu
X-Authority-Analysis: v=2.4 cv=K5Uv3iWI c=1 sm=1 tr=0 ts=68fb4433 cx=c_pps
 a=Ag07q676f2ng1MTlaQzx3A==:117 a=6eWqkTHjU83fiwn7nKZWdM+Sl24=:19
 a=z/mQ4Ysz8XfWz/Q5cLBRGdckG28=:19 a=lCpzRmAYbLLaTzLvsPZ7Mbvzbb8=:19
 a=I8YxwqQraDTXiFT0:21 a=xqWC_Br6kY4A:10 a=IkcTkHD0fZMA:10 a=x6icFKpwvdMA:10
 a=0kUYKlekyDsA:10 a=VkNPw1HP01LnGYTKEx00:22 a=e5mUnYsNAAAA:8 a=64Cc0HZtAAAA:8
 a=mhs35g2q7hD3AIEBY18A:9 a=3ZKOabzyN94A:10 a=QEXdDO2ut3YA:10
 a=Vxmtnl_E_bksehYqCbjh:22 a=HhbK4dLum7pmb74im6QT:22
X-Proofpoint-GUID: UrB6pBSqiAwU7YBa9_jNus7Ma9AiTtAu
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUxMDI0MDA4MSBTYWx0ZWRfX+4GSQwenZPvC
 C5dg2BgRHVCjzYekiCsV1+k2Z1LZbwBaU5nAhgDMQVCWPwzDABnTYFaj7QO1YUEaB7BgRhbYixS
 tPB3ULsG0n95yyk9BVR2/doFUhpZOBUMIg/oKD+yyTHCxarfVgESH5AyyX0gF4csoEe3jiWYmun
 6KqO9ZLJIiFaS3yKyUntF2zKsoiO4FVR/8P1QR/ERmz591YtnC4O3pVqOG3MlBWsDeltkqVyEJu
 43Zx0qRHnj1FpDX+NRSL7oHxqHXTO8QX7GCfRjjqJA0ZF0kDGzUiUd98RJbB1CsE6Is9Ieum/qj
 tDt1YXJZkbktZ42lOjnXByp6uSENcH8UjQovwrc20aRTXZIvgwM9RYmZPbFbupzOS3VhnSw5gjk
 zAUeD7n+muetyA6CBmarEb30EjE49g==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1121,Hydra:6.1.9,FMLib:17.12.80.40
 definitions=2025-10-23_03,2025-10-22_01,2025-03-28_01
X-Proofpoint-Spam-Reason: safe
Received-SPF: pass client-ip=148.163.151.68;
 envelope-from=lucas.kornicki@nutanix.com; helo=mx0a-002c1b01.pphosted.com
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

So far I've identified three possible solutions

1. Don't close the device on vdagent_clipboard_reset_serial

2. Reintroduce notify == NULL check (as you've just shown)

3. Remove the initial caps announcement request from win32/vd_agent, and 
only reply to qemu request


Option 1 is a guest agent side fix, so slightly out of scope for qemu.

Options 2 and 3 are similar in effect, but since 3 is a partial commit 
reversal I find it easier to justify.


Pursuing option 3 opens for me few questions about that reconnect 
mechanism that is split between vdagent_clipboard_reset_serial and 
vdagent_chr_set_fe_open.

Mainly, doesn't the reset path become dead code? If notify == NULL 
guards qemu_clipboard_reset_serial, that effectively prevents that path 
from ever being self invoked by vdagent. Only other place I've found 
issuing this call is dbus-clipboard.c#L255, and I don't know how common 
such a configuration would be.

If the above is true, maybe the reconnect logic should be removed.

On 10/23/25 14:42, Marc-André Lureau wrote:
> Hi
>
> On Thu, Oct 23, 2025 at 3:29 PM Lucas Kornicki
> <lucas.kornicki@nutanix.com> wrote:
>> Hello,
>>
>> I've found that using -chardev qemu-vdagent with a windows 11 guest
>> and win32/vd_agent
>> (https://urldefense.proofpoint.com/v2/url?u=https-3A__gitlab.freedesktop.org_spice_win32_vd-5Fagent&d=DwIFaQ&c=s883GpUCOChKOHiocYtGcg&r=D17nHqE5bUm03zYys97MRKlxg8_5m_UNOC_u5jGZgVE&m=9UY8wLhW02EynWMJqse7Eu6nRCjHLr7mCL_DdI8gaaOCjdUvi_sd5cpo_20MN9ne&s=PpM2Lxa0pb7aAmu1KWKmRYx7fwIcT2oM_tpbPmSMQkM&e= ), results in
>> non-functioning copy paste.
>>
>> Further investigation reveals that messages such as clipboard-grab are
>> being sent from qemu, but they do not reach the guest agent because the
>> VirtIOSerialPort has been closed from the host side
>> (host_connected=false). This is likely a result of the CHR_EVENT_CLOSED
>> event call done by vdagent_clipboard_reset_serial, which appears to be a
>> deliberate measure to force a guest reconnect (?).
>>
>> This has only become a problem with the introduction of commit
>> f626116f9897b95f68e5514a08098d590349c22e (factor out clipboard peer
>> registration), as it has changed the execution flow by moving the notify
>> == NULL, check inside the peer registration function
>>
>> -    if (have_clipboard(vd) && vd->cbpeer.notifier.notify == NULL) {
>> +    if (have_clipboard(vd)) {
>>            qemu_clipboard_reset_serial();
>> -
>> -        vd->cbpeer.name = "vdagent";
>> -        vd->cbpeer.notifier.notify = vdagent_clipboard_notify;
>> -        vd->cbpeer.request = vdagent_clipboard_request;
>> -        qemu_clipboard_peer_register(&vd->cbpeer);
>> +        vdagent_clipboard_peer_register(vd);
>>        }
>>
>> This change has created a new execution path that makes it possible for
>> vdagent to "self invoke" the vdagent_clipboard_reset_serial if it
>> receives caps from guest twice, which wasn't possible previously due to
>> the notify == NULL check. It just so happens that win32/vd_agent doesn't
>> handle the disconnect too well, while also enacting this exact scenario
>> by first sending a CAPS request of it's own, and then replying to the
>> CAPS request of qemu, leading to device closure.
>>
>> Was it the original intention of commit
>> f626116f9897b95f68e5514a08098d590349c22e to enable such behavior?
> That regression is unintentional.
>
> Is it enough to change:
> -    if (have_clipboard(vd)) {
> +    if (have_clipboard(vd) && vd->cbpeer.notifier.notify == NULL) {
>
> to revert the behaviour? Are you working on a fix?
>
> thanks a lot for the report!
>
>

