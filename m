Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id AA804C83F09
	for <qemu-devel@archiver.kernel.org>; Wed,  9 Jul 2025 09:35:29 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uZRCM-0004YF-Le; Wed, 09 Jul 2025 05:34:42 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mark.caveayland@nutanix.com>)
 id 1uZRCE-0004Wo-61
 for qemu-devel@nongnu.org; Wed, 09 Jul 2025 05:34:36 -0400
Received: from mx0b-002c1b01.pphosted.com ([148.163.155.12])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mark.caveayland@nutanix.com>)
 id 1uZRC5-0007Dv-Sv
 for qemu-devel@nongnu.org; Wed, 09 Jul 2025 05:34:28 -0400
Received: from pps.filterd (m0127842.ppops.net [127.0.0.1])
 by mx0b-002c1b01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 5693Ft9O019149;
 Wed, 9 Jul 2025 02:34:20 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nutanix.com; h=
 cc:content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=
 proofpoint20171006; bh=I6Bh84qGtmT15/NdFFulvju6iHakw7E61DFtEUL8/
 e8=; b=ZQWRZxbj+UuLoBlov8P1FLiw9rX0S31Uz3P+FCaqovzdl1+Y0EyP/J0Ro
 ysRavmAF+aBzjKPKjj/yjfQYOdWoOA6DjjpSaobvP3UWw7GROR39UJvIhqf7mriK
 XQWynJjrRgYPCbxrcbQu27k3inON6hp4Iq5JbDgVxYvDO+4povIakbjd6zrePj67
 YzVT4DTmcYsnVO6T8G6tA21COEtDT9h5vs7Dg/Muza2MFXS9wbHS7ddcTVpAUWHb
 5ty6dVuOKgTv6n65yjDdjnmaB2wisYL8btA55UzrSOAyaAqMOXd34swjSizCOMyf
 2oEay4wzG/CearYyFvsKjZqEt0qog==
Received: from nam12-mw2-obe.outbound.protection.outlook.com
 (mail-mw2nam12on2104.outbound.protection.outlook.com [40.107.244.104])
 by mx0b-002c1b01.pphosted.com (PPS) with ESMTPS id 47q3cetqx5-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Wed, 09 Jul 2025 02:34:20 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=saIElqtKcaxFGyjftWllgsirdZdsgFpxgYZ4Rwcsk5hTaeD7UEbZxtWG+nUzF0JHh2wlEnAEy4SB6TCn7n0BoN9E4Ih9NR3MvPU7luX3W88RLiS2MIPrX+4UU7BCXcHPyEJSWrSXIGLji9aym6AFF3wACJT/jb4Lb6NaW7Frck6+TRXznfCgtj8h5bSI0Rtq01UaE0wilApMEYVuqnmxkf1H5Hd5X3QSXq0VaeWsAK1p4vexGXAfRe0XDEAkZwMYMeOE1vJoBdGutGyV/IM/BaJVgzrhymH61XEV5Q0GRHH0uWoTYDgLKTQeLt1lNWYgZjiD0qPqT1kxtqdr/qHypQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=I6Bh84qGtmT15/NdFFulvju6iHakw7E61DFtEUL8/e8=;
 b=yHppQYEDH3UOcoufg4gqeNf+S73IvtevwOBvDyYkz3FjpEN8SrGzQSDF1V/zRByUfZpKoFZjY+10oXFlPM1iZWHk41vcvNWexG2HIr1yVzaLEqhJ1UW88+LUbBnluipPjShgl3dmsuwJnOJaarRIjXJkVS7/B+ZjGe/XueBtUZK93QXbziOeMJIlAtbyj0MfqorVzvkXOmS82R9ge5y2q76Z3zcJ7mUxRT6jyVax3ycYCn1cMYJyuA0ia79LyOcbEn+F1r1w1QfYj679lzVyU3y2BZUJqrAk+wEYV+PFxZcQltgfoJHJ3nBw/WOOtKF3tpXAgTHibB/Bqs5VojtbgA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nutanix.com; dmarc=pass action=none header.from=nutanix.com;
 dkim=pass header.d=nutanix.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nutanix.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=I6Bh84qGtmT15/NdFFulvju6iHakw7E61DFtEUL8/e8=;
 b=LkvW8DfZ6CkATPX6x0pwUP07dgn5Iq3mxHprXZYaBC3JzqXh/2nRs3IIBv1ycffgi4f2OzTvqt0UhyDEYBtnrJCElwlEkcjKhvVuLORjI6YvAIK8wL8JW2Cmo/AIDpAosRimRqKA20tDSpi5HSmf5UVrug4oDjGUze2gFSUgXSBv//tge9TlQR/AAx3K8L0/SJxDoBMcWI1ayY2QebBez3Iq3NtPSXLm1GQYldBYeur9IA3DiIg3oXHLVqYhnM/hS+8Bs6MKTgrD1po1BPZeq0BlJMphYQHaGI/3Fp1hXsp/PvxutiZm8Yra3Ktvbm3j45Wvw3Lid5MixfE1vJ2h/g==
Received: from PH0PR02MB7159.namprd02.prod.outlook.com (2603:10b6:510:16::8)
 by DS0PR02MB10709.namprd02.prod.outlook.com (2603:10b6:8:1f5::20) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8880.31; Wed, 9 Jul
 2025 09:34:16 +0000
Received: from PH0PR02MB7159.namprd02.prod.outlook.com
 ([fe80::6cf9:b35c:b143:bb88]) by PH0PR02MB7159.namprd02.prod.outlook.com
 ([fe80::6cf9:b35c:b143:bb88%5]) with mapi id 15.20.8901.024; Wed, 9 Jul 2025
 09:34:16 +0000
Message-ID: <75610c56-88df-4616-8cd1-1c97fe59c3ef@nutanix.com>
Date: Wed, 9 Jul 2025 10:34:12 +0100
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] hw/vfio-user: fix use of uninitialized variable
To: John Levon <john.levon@nutanix.com>, qemu-devel@nongnu.org
Cc: Thanos Makatos <thanos.makatos@nutanix.com>,
 =?UTF-8?Q?C=C3=A9dric_Le_Goater?= <clg@redhat.com>
References: <20250708154948.483480-1-john.levon@nutanix.com>
Content-Language: en-US
From: Mark Cave-Ayland <mark.caveayland@nutanix.com>
In-Reply-To: <20250708154948.483480-1-john.levon@nutanix.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: AM0PR04CA0056.eurprd04.prod.outlook.com
 (2603:10a6:208:1::33) To PH0PR02MB7159.namprd02.prod.outlook.com
 (2603:10b6:510:16::8)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH0PR02MB7159:EE_|DS0PR02MB10709:EE_
X-MS-Office365-Filtering-Correlation-Id: a576a6ad-8b45-486d-cc2c-08ddbecbc58f
x-proofpoint-crosstenant: true
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0; ARA:13230040|376014|366016|10070799003|1800799024;
X-Microsoft-Antispam-Message-Info: =?utf-8?B?R0FDdWZ1NWxsQ2NWUDA0b0U0UHYxdU1kSnNYdHREN2QzSTlGVUV6Tk5FTlRo?=
 =?utf-8?B?ZTVSbmlZVFNOQTM5cTBHT2xVa2U0RnNzZ0s5Mi9QUFFtOVFSdW02VGNRYkJI?=
 =?utf-8?B?d0JQWXBTRzZKS3FTVmVKN1dYRGI1U0hPanp1SWZkMW5pV2NIMDFMckhUZU13?=
 =?utf-8?B?RmRkdWVVM0R3L0tzS2M2ZHo2T1lSazFTK2ZpeStKcjhvT0FBZnhaYzNuRHJ6?=
 =?utf-8?B?NE03ZFhUbENtYTB2c3NJNmZneUFXVHc5b1c0OHM5VWFaMTVoZVZidkYvUG51?=
 =?utf-8?B?ckl3OWFUODNBRHB0TW9PMkp1NFFjTHlsVEdVeFNqTUc2M0YwVXJSZ3dUUjAw?=
 =?utf-8?B?RHlMeHVLU2ZDWjB2NWw3TEljb2hvZVdQUzdpaFZ4NXZmbHRFd2ljTnFoZmJt?=
 =?utf-8?B?b1ZHZzFseEd6UUFkVFVxbFc0Q2xIUDlvVGlxQzdzdjVLOTRTMGw2MjlJTUtm?=
 =?utf-8?B?SUVjcWxMNW51cVpRR1JLb0pIMm9Za0RRRG4rbkJVUGtZRThPU2xHZ0JXNFl3?=
 =?utf-8?B?L0NxcHl0ajg5aHZMQXE4K21mMTFCYnp0d0JLTG80RG12cHB5VnljTlpma0Y0?=
 =?utf-8?B?ZHk0SStNUk1qSjB0V0J4UytNaG1JZ3gyMzE0d25ITDJsVDZ1OWlVNWpVTE01?=
 =?utf-8?B?N2l3UTEzWS9jaStISVhIN3dIaTR3Lys5NWdiMzNyUkt5MWFUaEx2WGJCS0J5?=
 =?utf-8?B?YlJ4Z3lCNnpSa1pZbzJBdGtITFl2bTNIcmxseFozZVFqdVE2cmJPbUtPRnVK?=
 =?utf-8?B?eGNBbkNIbi9jR0V5WmQ0MCtvbkZhVEdyMmtWdjBvNVkwMWx2S3dpcldvdENJ?=
 =?utf-8?B?cklIb21JcFpleW9CTXhuNUN1TGVsZXN2cjRNaVVWUUwwdXNISno4SEU0OWdU?=
 =?utf-8?B?VDRjNWEyMkNJd25kS1VVSU54UmNLUFg1NmI4Q0JzclIvMk4zTWtCZnp2anNE?=
 =?utf-8?B?dFpPRjRGWHVKbXNVamc0M1Q3WHZJUHRmNHl2YUNEeTR2d0s2L3kxekdtb3pj?=
 =?utf-8?B?blo5bUlZVnQ4ai9NcDZNZDdieFFmS0tIZzZ3eDZ5OE50ZHR5U0l5eEFwN21l?=
 =?utf-8?B?c2JvcWYxUWsrLzdjcVpFUVB0VWFDQmoxV1A0UHd2OU9CSHBBTjhMTTNBNFpa?=
 =?utf-8?B?ZXJPUTdxTHp5K2Y5MjZlNWFCZE53R3lGVFNmZ3pUOXJnRnUvNGhDV1Z1K2JD?=
 =?utf-8?B?d2JFWTBvMUJDVVdJbm9CaTd2YzhJTEZiMEs3dTYvUkY4QlpQclNGNUowampr?=
 =?utf-8?B?NXJleFJSWkpaRUl1UnNmT2c4d2NyRnU3M01qdnpUUE5MRHJONVRXN0NJVTVz?=
 =?utf-8?B?WWVOOHFSUVo0b2NFNXN4em8yS2JiYzBNdjRMWmZ3MGlYZzdLc2hocEhnQWs5?=
 =?utf-8?B?ZHpkY0FxUm5ZTVIyVVd3S1VITUhMTS9VMHUvNzFxWDRQQWFtUk8xWTV2emU3?=
 =?utf-8?B?SEREV1lEOUdhZDZWYmpCQlJQSGg2aEdCVVhDUlA5bm8yZ0VzUlhkeGZLdm1M?=
 =?utf-8?B?dUMxZjYvN0VWMXRpMDJQNHhMMDNXY1FCSXd4WUpGakJ3WGpiSXdNeEk2c215?=
 =?utf-8?B?bnVLRFhlVXBVZmF5YjA3YWNkYllaVWJreXQwTEFKc2JFYXVYWExZei9NTk9Y?=
 =?utf-8?B?bnFJUDlWTXNITXFjVjBQU2FnRDh3bDVWMHBSeVF6U21WdGpaUHVrYk81TEJj?=
 =?utf-8?B?emMyR00weXF0c0dEL2U0ajFnQ3NOV3luaXMveDk2MWVsS29DWGJJYXJsMTNC?=
 =?utf-8?B?MEpDckNPQ3NoZmdmQ0tXUkNCK3MxU01JNGh6eWFVdkFwQ1E5YmRDVmpsVDJ5?=
 =?utf-8?B?M0tPdUlWSTE2VCtKdDBVNE9DYzFvdit6TnVBSEF6SWltbGlTL2FFNDhkWlBR?=
 =?utf-8?B?YWYxS2ZhUEdkUFhiTFp6UmZqYS9CTERrRVdWOUQyWHZTb1E9PQ==?=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:PH0PR02MB7159.namprd02.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(376014)(366016)(10070799003)(1800799024); DIR:OUT; SFP:1102; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?RU5GbjVrR3R2UFBJbFk1T2s0TzQ0RFo3blZCTVJzQm9xeW5wS09WRXdMQzFQ?=
 =?utf-8?B?ZXBlcWg4dVRUdC8zOGxHekE5VjZFVXpjQWdYQ2VoN1ljamFJUUFjd0lyYlIz?=
 =?utf-8?B?Z2dSMVlhZFA5dGsyUGVmVmFBNm4vMXZoQlFCK2JBVVJ0TGZ4UEY3ZW0zUXRU?=
 =?utf-8?B?YW9tV1ZnRHZudytmRXRnbTVuRE5MZnU1aHZndTNRbTBQWUhEaDdMRlh2ZUdO?=
 =?utf-8?B?VnJTWU1wTG5QWXhVVUFXUnlvbHAzRERYSjFveXZMMDNjZnNQV1JucXovUzdF?=
 =?utf-8?B?T2c5enBWWGNSaEFZOUsrQllnZktOdGhaRndjZHJDNnVZNUVEYk1QQUxXZnNk?=
 =?utf-8?B?R3BwU3FIWnUraDJLZ05iY0lQT2pJUVVxL2lBLzE2RHc5am9iUjJFSFhDQXMx?=
 =?utf-8?B?QmpsK2trTUpzUE1nMmlleERWRDVhUU5RU0Z2SnVYRHBCRGE1MEt6ZUQ5U3M1?=
 =?utf-8?B?T3BJOVBmQzZ4dFpCdlJndm5LQVpUYXNVQk9NTlNCWEdsQnJkNXFTT0NldzhO?=
 =?utf-8?B?ZmNuYjlTRXVPRWcxUkFMUyt4NWpJNDdmZForM1AzYXlkVnZYd2VCdkV1ZFNu?=
 =?utf-8?B?S0hIMzdTS0FYaWR1N1J4MXJsQjNjajNrUWQveTdUdlViQmRnS21ma3VsOHp1?=
 =?utf-8?B?dVhTaFh3VlpNTEdJVlY1ZDIvdWtxdC9qTXJGckxmVEFhc3NYZnB6ckpkLys2?=
 =?utf-8?B?MjNzbFVvK04vdW5LMkIraS9wVzRwa0x3MS94MlRwNW5aL0lzZ0pzTTBYTURz?=
 =?utf-8?B?Z09qQ010MmNvZndXS3diZXVxSVExaGhld296dGd1aHBNZ2YwL0l5N0hiRVU1?=
 =?utf-8?B?UGdPNVlFbGtKTkxoNkN6cUxWdG9pZU9WUkVKZXZTdnZSbXdjck9ScDU0NElZ?=
 =?utf-8?B?RTFWUEVhekgxUk4ydzRMUFRwOUlFUllYRVVoZkdmbWpmWTIyM3N0QXFCZlVw?=
 =?utf-8?B?c0w3Q291c0tTczZZeXlUMXdDMWtVcmo2eFFVR0NoTHdEeEhOclRKdTRzU1pB?=
 =?utf-8?B?MmhqcDQwZmJOQWxCSTVCQjc0c0hUNE5HUlNhUExrNXBaZXZTQ1FVRTcvRnRJ?=
 =?utf-8?B?S1FyN01vaXdMazljM241QW9wZzFPRVh3MW9veWs2MjRIU1ZlVndvSEQ1cW43?=
 =?utf-8?B?djM4NHYwbEhWeGZheUp6Vis5T3g0ZU5OYmhadzBqeE9XWVErWU0vUithdUdI?=
 =?utf-8?B?T29ZUWQ1NC91bWxacENDckYzREZSRVpyT1NYcE11NzFmcmxMQzVGZE0zdERC?=
 =?utf-8?B?eTBqdVAzalVsd0lxRCtvQy85SlpNanl1YTVwcmFJRkxPSUpZR3o5eXhkTWNP?=
 =?utf-8?B?ZU9YWSsvek1rMkdOdDRsNnEzcnFJQnF4LzN2K0JWU0E2NVlSaVZFUkpxZFZ5?=
 =?utf-8?B?U3VjS25xNFN2TkljeWtoM2paOGlidVU3VGliRThDOXMwVHdLWlNYdWtjeGtq?=
 =?utf-8?B?SytKNnYrMVB6TlVmdEhjK2NFdEhmZlIzRElTMllLbHlhRXdCNVM2OFI0TTdL?=
 =?utf-8?B?Wm54K0hLdXd3Y25wZ0FXbU5FZ3Uza1ZNL0Q3Nmk0S09nZXJEWktQV0xLbFp3?=
 =?utf-8?B?VUZKR2FEQlU1Zkg3N2FhdnNLOTRiVEx3NGtGeS9IN1VqWC9LbnoybFErUEVu?=
 =?utf-8?B?T0FCdWN6TWtEd2x3TjNYNUFlS0pOL1lUeFRIcEorVVhOVWpLTEhGTkw1dkpL?=
 =?utf-8?B?Y0ZiMHBFb2VHMm1SLzRPdk9UbVRJZkRXSE9qaEpRZEVFZ2llcjhNazh6Wm1C?=
 =?utf-8?B?dWJmMHlqalhiNTRzZmd6RUc0VGdsR3k5M2JhcjVadFNmaTUyUFZmVVZqN3k4?=
 =?utf-8?B?b3JkTFQydXBGdC9UZm12QkxnemlwV3BNc1dqdmw1d0UzSWZjVXpCamloeisz?=
 =?utf-8?B?aGZDZUlSTWFWLzkrTkdFcklDY3B2bVEwcWhiY1FQeDhPY0ZsaFMzcUQxbVZy?=
 =?utf-8?B?SGVRK05LMTlMdy9DbTJwZUw0NzJTWnZDWmtLV2ZHWStLQlNHMEYwYzRHaEhM?=
 =?utf-8?B?bmp3M2N1Y0pNWFRpN09FREZvNjdUcGdVY0FRcnM5VUVwaStYd09kMWNaSVFY?=
 =?utf-8?B?b2xqaHhQRlc1Qlg3QWR3cTNnRmhWUWVDazk3Y3dHMGFBOGJOcFhramN2b1lU?=
 =?utf-8?B?UEM5MlpLQjJIZ3JZeGVYemh5ckFYMHFmS1QzY3YyVWMvR3RlQzB6L2p2dlls?=
 =?utf-8?B?MVlUM2hMcnFwMjRuQ21CT0phTWpTbk85Qy9rSXk0Uld1M01mcWZxVGcxdFpT?=
 =?utf-8?B?amdjNkluanM3NDc1YVBWQy91NmNBPT0=?=
X-OriginatorOrg: nutanix.com
X-MS-Exchange-CrossTenant-Network-Message-Id: a576a6ad-8b45-486d-cc2c-08ddbecbc58f
X-MS-Exchange-CrossTenant-AuthSource: PH0PR02MB7159.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 09 Jul 2025 09:34:16.3066 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: bb047546-786f-4de1-bd75-24e5b6f79043
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: FfcL1Hq1XyIbJUbr59zWTtbZNd0BlL2yV+2PfBtomyPnlPM0B0xyjHi7QpCdn2Njh81K09NklqnGiktnraYWcDAiX+uuBb46ro3HEleJCDc=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS0PR02MB10709
X-Authority-Analysis: v=2.4 cv=U9SSDfru c=1 sm=1 tr=0 ts=686e379c cx=c_pps
 a=UmjVza0x1M4UpXJilF6xSA==:117 a=6eWqkTHjU83fiwn7nKZWdM+Sl24=:19
 a=lCpzRmAYbLLaTzLvsPZ7Mbvzbb8=:19 a=wKuvFiaSGQ0qltdbU6+NXLB8nM8=:19
 a=Ol13hO9ccFRV9qXi2t6ftBPywas=:19
 a=xqWC_Br6kY4A:10 a=IkcTkHD0fZMA:10 a=Wb1JkmetP80A:10 a=0kUYKlekyDsA:10
 a=20KFwNOVAAAA:8 a=64Cc0HZtAAAA:8 a=t508SXVf2mZW7wIXU4AA:9 a=3ZKOabzyN94A:10
 a=QEXdDO2ut3YA:10
X-Proofpoint-ORIG-GUID: ZOQwcE8BDGSwYi9gXTT1X5yDoTHPd4U3
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwNzA5MDA4NSBTYWx0ZWRfX+56rFUScFkZx
 neNFcGUYXF6xQ0KBU8KoSU0Rv1zEFsQX2i0ltc3mKtS5wrK6LxF0AfEpy4aMNy1gFqnnBFzkERe
 LA8TZD+feK6eVp7YQcWRWVpjfcikjVh3YDcGuwTBEA9JogKd/vKnLIoor39K7jWEQ3OvxZlxv6G
 qJH7TSYNiBMEydatx9PM0FYTmPwWOnTn+pB1+sotA87n2n+gXbOKIZ/gtJpuM6GRDW+8ZjjcNqZ
 cZ3eiPJC80bcpDmpJlydrdJqCYpD00T0288gWk+K5yptq1wbYdmEfHN6lPMDzFKyIqIfNtHHpA3
 F/J9uieaPvZPjWpZGSzSpcYSzgjaZ6UDbgnXLaklXXbzKsrwuNP8O6yrZXU//5e1b8wa5oB3Xt+
 W0Rnlc7JD+Tr5yllTXm+mY60cLRlCgSQJM4SFFkcDI8Bdt7ZST+RpTu+j2YoUJq7XYa2bO1Y
X-Proofpoint-GUID: ZOQwcE8BDGSwYi9gXTT1X5yDoTHPd4U3
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1099,Hydra:6.1.7,FMLib:17.12.80.40
 definitions=2025-07-09_02,2025-07-08_01,2025-03-28_01
X-Proofpoint-Spam-Reason: safe
Received-SPF: pass client-ip=148.163.155.12;
 envelope-from=mark.caveayland@nutanix.com; helo=mx0b-002c1b01.pphosted.com
X-Spam_score_int: -27
X-Spam_score: -2.8
X-Spam_bar: --
X-Spam_report: (-2.8 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_LOW=-0.7, RCVD_IN_MSPIKE_H2=0.001,
 RCVD_IN_VALIDITY_CERTIFIED_BLOCKED=0.001, RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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

On 08/07/2025 16:49, John Levon wrote:

> Coverity reported:
> 
> CID 1611805:         Uninitialized variables
> 
> in vfio_user_dma_map(). This can occur in the happy path when
> ->async_ops was not set; as this doesn't typically happen, it wasn't
> caught during testing.
> 
> Align both map and unmap implementations to initialize ret the same way
> to resolve this.
> 
> Reported-by: Cédric Le Goater <clg@redhat.com>
> Signed-off-by: John Levon <john.levon@nutanix.com>
> ---
>   hw/vfio-user/container.c | 6 +-----
>   1 file changed, 1 insertion(+), 5 deletions(-)
> 
> diff --git a/hw/vfio-user/container.c b/hw/vfio-user/container.c
> index d318e6a339..d589dd90f5 100644
> --- a/hw/vfio-user/container.c
> +++ b/hw/vfio-user/container.c
> @@ -64,8 +64,6 @@ static int vfio_user_dma_unmap(const VFIOContainerBase *bcontainer,
>                                 0, &local_err)) {
>               error_report_err(local_err);
>               ret = -EFAULT;
> -        } else {
> -            ret = 0;
>           }
>       } else {
>           if (!vfio_user_send_wait(container->proxy, &msgp->hdr, NULL,
> @@ -92,7 +90,7 @@ static int vfio_user_dma_map(const VFIOContainerBase *bcontainer, hwaddr iova,
>                                                   bcontainer);
>       int fd = memory_region_get_fd(mrp);
>       Error *local_err = NULL;
> -    int ret;
> +    int ret = 0;
>   
>       VFIOUserFDs *fds = NULL;
>       VFIOUserDMAMap *msgp = g_malloc0(sizeof(*msgp));
> @@ -135,8 +133,6 @@ static int vfio_user_dma_map(const VFIOContainerBase *bcontainer, hwaddr iova,
>                                 0, &local_err)) {
>               error_report_err(local_err);
>               ret = -EFAULT;
> -        } else {
> -            ret = 0;
>           }
>       } else {
>           VFIOUserFDs local_fds = { 1, 0, &fd };

Reviewed-by: Mark Cave-Ayland <mark.caveayland@nutanix.com>


ATB,

Mark.


