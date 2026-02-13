Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4A233EE36A0
	for <qemu-devel@archiver.kernel.org>; Fri, 13 Feb 2026 09:52:24 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vqpqV-0002xY-Rg; Fri, 13 Feb 2026 04:52:20 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mark.caveayland@nutanix.com>)
 id 1vqpqI-0002Kp-P4
 for qemu-devel@nongnu.org; Fri, 13 Feb 2026 04:52:07 -0500
Received: from mx0b-002c1b01.pphosted.com ([148.163.155.12])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mark.caveayland@nutanix.com>)
 id 1vqpqG-0007hk-N0
 for qemu-devel@nongnu.org; Fri, 13 Feb 2026 04:52:06 -0500
Received: from pps.filterd (m0127843.ppops.net [127.0.0.1])
 by mx0b-002c1b01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 61CM0nvc1341809; Fri, 13 Feb 2026 01:52:00 -0800
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nutanix.com; h=
 cc:content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=
 proofpoint20171006; bh=7Uua99UXufoHB1EBd2Lu4LrCFARN16jDJZ6ZQAJSE
 ts=; b=UxsxG6Ssu17+p/b/ymykI0S/Xe+tAC8H830WD6TUzooY5yLwTWKmEiWSX
 ytt9PrHGbofJALDzqWw+0LICs31ZCBbH8p+8xbZpP4N3GGrURaIXY5LZJQXOpkIt
 KiffNe3okgrz1YJ6w+ruRF2bn32E5E9j1qIl95Fy5puLcTmr2xJVAOWYU/4TnrgI
 cDUz95gizSULYzq5Owh9P27Jw9sFDLp4WrWQkZdGZVbqQK/XETZHfQyvCfwlRwdF
 w7UP2OuQ5VPElpXSCQcJ/7QNeuo0Y8nqdN98rTVFqBQY11FUdUvpCxoie6vkY7Z+
 t4X1oP1It9WT8tiB6w9JTr/A3Bw9A==
Received: from co1pr03cu002.outbound.protection.outlook.com
 (mail-westus2azon11020078.outbound.protection.outlook.com [52.101.46.78])
 by mx0b-002c1b01.pphosted.com (PPS) with ESMTPS id 4c8k9s7jr2-1
 (version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NOT);
 Fri, 13 Feb 2026 01:52:00 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=OxIc/21Ysdk/Qpga3KUoYG+Y+Kfs+3pW/Mlo1WPkyCmszNISu26N+/DZfLkVI+pQRraChdP9oiY/1cqkp+b6DhWP7US/FZQNm44dGWAI7nGR8m/oo3UxD/cxOqDsiNzxHSrWwKKtjxs4ew/uwLrs62ZqpR/nW1frSjbAJai/cKX0mfqwo7Gq4269Zd7ioPjK/6OTDTxzwplAK9hAbYMbzCCizWNvgG3+Jlq78sG7Yi1oRw4dNtBZThBcIboACP+BnMjAUnN2fuoAqULK85dyiPbSnM0cXDV6Fxgh8dXsf6JFrXcdnC35/kajiqz7I0VaVD9fxfW2vux4+oyEPnfJ+w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=7Uua99UXufoHB1EBd2Lu4LrCFARN16jDJZ6ZQAJSEts=;
 b=Pw4f1G+SwhcNtGc+YGCX3AeYgG3xgVc7pvj9I9EQ54jJmn972Itm0DG6WMrzNMSFdhw8y/sqoQjCJA2Xhvf8MMnh7jNed1arxPYISmUqFfYa07NbTAcsBF4Ijsr4zxeYHEXJFM4FWvTbhnHaNTeoEZujgESSZFupOjU5tmQQsOhT0CIRgAI1PzyLTq8EbXetr0nfoqlWFe/YNcoHZtLmkocGUsPca6QuU6ltinXAZgEKRZ5MEEXMXb26Ec4Dye35Q8bacMXwsTOl8jIX1yEWxt7nWL1ESzS7OX8gVeuMYnSCJcorm6HnKsDluWGZtrUQhEG3ZbBYz4Z0nbfcTbM7+Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nutanix.com; dmarc=pass action=none header.from=nutanix.com;
 dkim=pass header.d=nutanix.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nutanix.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=7Uua99UXufoHB1EBd2Lu4LrCFARN16jDJZ6ZQAJSEts=;
 b=bcH6Sh4caHjSgjR8WU7GK1gngyo5EV6u7z30HgC+BQ28RYPJmpv12R3vH+s9debHjzX4nuWLmBjN7EUVAut/YE6+ZQv+UbOQXHM+Zodg6QJWGSDsQqRSQUCe/qK8T8WvvzDAEfkNtFtQXsVoikWUVqNcoiHTE6SLSqn2H5hzMzgveKHGWPerkdo8aU0dcxrD5N1JcsDJHWsyDPeXIOETO5GmSB7Nv4w7afvcut3K0smArnE3Bd5vgA6aoysmDH24H25D3k6e9w86YbnPD7edWR/hHogVHvTmZQJm0wsil+Q8DkBmtfGMNzhaf28MiskqtS+dXO5zvR+jJVNjYCL+eQ==
Received: from PH0PR02MB7159.namprd02.prod.outlook.com (2603:10b6:510:16::8)
 by SA1PR02MB8852.namprd02.prod.outlook.com (2603:10b6:806:1f3::15) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9611.13; Fri, 13 Feb
 2026 09:51:58 +0000
Received: from PH0PR02MB7159.namprd02.prod.outlook.com
 ([fe80::8e97:bc32:822c:b250]) by PH0PR02MB7159.namprd02.prod.outlook.com
 ([fe80::8e97:bc32:822c:b250%7]) with mapi id 15.20.9611.012; Fri, 13 Feb 2026
 09:51:58 +0000
Message-ID: <57df9bb6-a504-45b4-a04d-bdb1732eed4c@nutanix.com>
Date: Fri, 13 Feb 2026 09:51:53 +0000
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 05/43] audio/alsa: convert to QOM lifecycle methods
To: marcandre.lureau@redhat.com, qemu-devel@nongnu.org
Cc: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Gerd Hoffmann <kraxel@redhat.com>,
 Christian Schoenebeck <qemu_oss@crudebyte.com>
References: <20260127182516.289834-1-marcandre.lureau@redhat.com>
 <20260127182516.289834-6-marcandre.lureau@redhat.com>
Content-Language: en-US
From: Mark Cave-Ayland <mark.caveayland@nutanix.com>
In-Reply-To: <20260127182516.289834-6-marcandre.lureau@redhat.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: LO2P123CA0084.GBRP123.PROD.OUTLOOK.COM
 (2603:10a6:600:138::17) To PH0PR02MB7159.namprd02.prod.outlook.com
 (2603:10b6:510:16::8)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH0PR02MB7159:EE_|SA1PR02MB8852:EE_
X-MS-Office365-Filtering-Correlation-Id: f95e7ce7-d970-4496-f43a-08de6ae5871d
x-proofpoint-crosstenant: true
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|1800799024|366016|376014|7053199007;
X-Microsoft-Antispam-Message-Info: =?utf-8?B?UllGVkd1SjRqMTBNZEpZNyt1N2lpSlRSN2c5ZkdsclJIVTZZeXgxYWxXSy9q?=
 =?utf-8?B?MmgyUWQ1dnFEejFUUUxwcHZ2RVh0RWNUVDNSSGxseEFTR1pzRDdCUTVZY2JE?=
 =?utf-8?B?NGIxS3pWTi9xUGExS0NYTFVxZkNINkErdm9SQ3FnZ0RJbmVyVDQ3eldzTmly?=
 =?utf-8?B?di9hUnJ5b3RXa2hZNk91WGhiL1N5Nmprc21FeHE4cndEZXczTEtzMjVyT3lE?=
 =?utf-8?B?R2VBd2JhcXJsZzR3T0lQcm5QcTAvMjEzbHVMTjV3dncxOWxwOGw0YkFiNnAv?=
 =?utf-8?B?eEZES3g2N0dJZC92SWs4eVNIdFRPT0Jpdjk2bThzMjl0QlVxRnVMVDVoZmhi?=
 =?utf-8?B?ZkNEZmpmRHpEeFVSZHRDbU54NFlFaDFPSHpxSHNITWg3TzhNTWNsOWU5UG5x?=
 =?utf-8?B?dlQ4NXh5S2JSQUl2YlpWa3ZMVkJuaUdFYlBHZHNtZ0hZZDgyNXRtYWd4dVFE?=
 =?utf-8?B?QnR2c2FrVXd0TTA3bmt0UG9kRXBlbHVyK0JBblphVFdkOVhyQWw1am1WSXVF?=
 =?utf-8?B?dm82SmFUTWE4bzJ5RVUzN3FYU3VyZndzRHpvajdFSVYrTFVyRnBNcTV2U2M1?=
 =?utf-8?B?VHNrWWx4YkE2WHlhcXlvbkxNbUFRV1B1Ump6b3ZNNFNIMFp6Rm9CbVF4NW1V?=
 =?utf-8?B?THJZa3RWMzcya1N4QmNCN29BNkgvYVR3SFUwRXArNytYb0RVNHJGeVFuSWFw?=
 =?utf-8?B?QWc3U0hzYXJXSWlXNUc3dnZXOVhoUTVZdE5PN2VzUEpIc2VDSXdsZk9MZ1ps?=
 =?utf-8?B?UHN5bFNLWlM3OVBXVUtLOHBFSlF0emQzaExqRGMzZ3pVSWlNTWN3djVhL29p?=
 =?utf-8?B?QVptUDlxWnZ3VThwbDhmKzJtcjM4V0l3cnpFYW1hM1BxT2NmcVlDakNVZnJF?=
 =?utf-8?B?T0R5UVR1aUdsRnprdE9jYlpmQVZJYys0eXZsbDJuR2JXTGFSazhkbmZUZXhF?=
 =?utf-8?B?anN2MG1CdDNyQS9lbE9lNU9OMlNQRDhiNmRydjFjM21nWGhHMEdyemtlaWFQ?=
 =?utf-8?B?bVJFeHloM3RucXhnNXdrSXlsOXFYRUU1UWVSTWZPbW40UWs2QTJPeUp1elZt?=
 =?utf-8?B?SFVqeDZuZkU0OUp6cjBFdk5iUHh1eFc0L3pNWXpubHhPTjZjVzBKMm9VRW9J?=
 =?utf-8?B?SWVpWkpES09EaVpndHp3c2ZzQ0JuTGs5c2pKTysrSkcrcGxMbDhzSFo1M1hv?=
 =?utf-8?B?cnhiUzJueTVGTUJZVUZZaElQclRpQmphVjE2SEJXUzY2dXJEQUFKQ1VYb3pT?=
 =?utf-8?B?d2ZjRHN4bDFSVlExeWYvRDdZS0t2R1dLVDB2Z3FvSUQ0K3Era2o5dytQLzBn?=
 =?utf-8?B?S2xVV1JQekZEY3JnM0haMmhHM3JkdXdWWFlES2JhZWxVaG1RQUExdjUvZDk0?=
 =?utf-8?B?dVFkQy9kTVVBYUd2WDdvQXdxM1d2aTcrd21SdnJYV3dJd0RKQnNOQ1d6MWdz?=
 =?utf-8?B?MjEzNkE5ZW1RdXp0dW92bERDTmszdjRnRklDeUlIcElPTnNvS1RreTdDK05i?=
 =?utf-8?B?V2JNYmZYc21ZWTNvSSsxQ1JRaXdJU2orcW5Vc1lxRndZTXpjellNanBlV2hJ?=
 =?utf-8?B?OTc0TlovZWF2WHdncmNJNmpxWDU5WVhUNkdmZ21nclNNQzhtRlgyN1RPUW9S?=
 =?utf-8?B?amNrdHN2MDFRUXRBODVXOTdyK2pZM0JIZUwxd3phQlA5UjdUWE5XUWFEV3p3?=
 =?utf-8?B?Yk9DdVJQbkpqTisvTER3NWZuRDVGZ2NqV2lLdWxmbVNKV3cyZTdBNEpJdlVO?=
 =?utf-8?B?V2g2dGwwUzRpZ21HeC85azg0UE5ZcEgxczFiMUdpUDBhQUNnaVdVcCtjN0RU?=
 =?utf-8?B?a1RRZGJwM1NxZkluLzBZS2Fua2JSd21FMnhkV0MySUpOL3dTMGNLSG4yUTRK?=
 =?utf-8?B?Rmw0eStCLzVtek12SU9aRW44RlhWYWRocEhGdnhEaWNrbUhRdHI3cDMreDls?=
 =?utf-8?B?VWF0MTR4eG9jcjdpbnYyVkRINjluTTUxMThoWXNYZXh6bXBvV3JJVkVpSUd4?=
 =?utf-8?B?MFZRaVY0SmpVcHpmYlVvRGtyY2pJTEp4TlcwQlM5cHNpVkw4OG42RzQzTDJK?=
 =?utf-8?B?Umt1V0RuTjJ4RGoxOXRxVDNEajJPTWwvaE5ZcXVvUlVuNHY2cWZNbWpNSEhs?=
 =?utf-8?Q?n5FM=3D?=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:PH0PR02MB7159.namprd02.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(1800799024)(366016)(376014)(7053199007); DIR:OUT; SFP:1102; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?ckpUNEpZSUVjeDVvRFQ2a0srcEwxVzJWQVV5K05kVndPZGNXZnFNRzhYTmgv?=
 =?utf-8?B?SkJ2ZytEV1MvNHNmaWcyNXY4aXlQUVh4amtzUzJ2T05xWHZyM3ZkZUJURlB1?=
 =?utf-8?B?dnA0emJEU0VFaXc5eDZrZTR6ZG9tL0tFVzVVaS9tb0diczA3Vlk0eUo0MHBw?=
 =?utf-8?B?YXpWcEIvdGFQNGZtamJzblpWWTBjVjYrMktjS3BlNUtNVFEwNDlaTTczNlAx?=
 =?utf-8?B?WjdlNVhObUZBMkN6aDhKZm4vNDZ5dlRidnE3TEk3VmNnZHV4T2ZiQ293aHp5?=
 =?utf-8?B?ZXp5L2ZkL2FjTm1BaG5LU2xTc2FDZVZINWJ1QTVaUldzWTY4RDRJNDhIUTg0?=
 =?utf-8?B?OUVLTzA2QjVhN1Jrc29Obk5aR3FsWmtkSmxXWWd3Y2V4Uy9uVFRIQ1d6Qlhj?=
 =?utf-8?B?S2czb2o2RjM4cU82Szd1b1cyZ1BHcmhrZWsxa1J5Rk02UGFCRzZ0L2VKVEZi?=
 =?utf-8?B?dWoxMGhEamtIdHJDaVlqbGdtNUlIUWNCeUhpMzFGL0E2Y3lQcHdnQlp5RVJT?=
 =?utf-8?B?YWNERHJQQzAyYWpnRDZjMUhlbjRjOGdleUo1c09TRGNXdTVhQW1OTEhrazVG?=
 =?utf-8?B?VmZHL2EraW51emdSby9yaDlBQjVlcmx6TDBwK1lLeUdUUkhNdkJ1R2FDeWRq?=
 =?utf-8?B?L1p2SHJERFN6c3pVamI3MG9uV2xmL010bW5mTmpoOGFqNTlzTm1HZVNOZmpS?=
 =?utf-8?B?Qlkvd0FyV1BuVEdqL0M5VVNPT254bDEzZURqZWp6Z1pJSnI3RTIyUGlMQm1D?=
 =?utf-8?B?VXhaQk9hV2p5UGNPU2o0ZURzYlZzRTBVaXVvNXdpbW9pNlB0bXFudS9OUkVa?=
 =?utf-8?B?TWM1TXJrbG5mRVJMSzhGRmFwVmVPcGRlV1YvZlovcG94UkV1UGVDRlBkd3Bt?=
 =?utf-8?B?Q1UrYjlpRHluQmhzY0loRkM4UFVtckorTjNIMzZqN3U4MGpyMldvUEluVk5R?=
 =?utf-8?B?YzUxT1V3SHd0L2kxVFR5UXROT2NBbnkvWmhPeGxpdHBUZGlmY0RlKzRZY204?=
 =?utf-8?B?WCtjZUVCMFg5Vm4yZHFLOFBBbDk2YW5WZ3l6L3BXQ2o2Wm1XUWQ0UWE4RnFx?=
 =?utf-8?B?eEliV213MVNDZVl1UENMSmdnOU9pYUZzbWx6WUJtaFp0YjFvOVVZNllZZlVF?=
 =?utf-8?B?aEgxNng2aXZQeml3S1hRY3dBbzVIeHFoMjBGN2kzYnJGb3J0YXo5N1pXWFVi?=
 =?utf-8?B?N0pYU0pCcERYaG93dmt0MjlTWlJlSkI2YUJBVFAzWmJBdmVmSE5qeVh0SHpi?=
 =?utf-8?B?S2JyNUFLc3pLUFJLOVBZS1JJSFpVZUk2UDQzV0QveXhpVXdlanlqUmlRUlAy?=
 =?utf-8?B?K2JXVlI2UURqR1JMdzJCRDI3Z3A1SVZFSjBhYzJUeWJLek56YnN3SUhmVVhR?=
 =?utf-8?B?c1ZhTFpkV0ZtaFUzSDZINmZlYnFMYWxQVzVhYXhiZGx1RTdNbDlyMkk4cDZk?=
 =?utf-8?B?dkduYVNDcGNpbjFNaGZac3NZVUNWcVY4T0E2M25QY1g2MmU1Vko3WERCNDFP?=
 =?utf-8?B?S1lXeHJwd2dDN0hnU0t1eStpWWRGd3ZaRjB1TFVvT1JSVG5FM1RyWWd4b2p4?=
 =?utf-8?B?SkJLZXBtd3lCbDZFbXlmN3UzOTQrK3ViZWwvQ2FiNzJaSEpKdWlnenN3UHNW?=
 =?utf-8?B?dTdadmZoSm1JekFzQ3dyeVhBR1BTWVNNa1ZBcWVrSnlEYW9nTTB2ekpjU2ZZ?=
 =?utf-8?B?L0pSV2pGanJheDJIbmdZak80NHNaQ1JnZ1lZZU9teEx1YUQxY3FPUWErTWxL?=
 =?utf-8?B?UGRqc1N4Rkp0VUhKeVVjcmFjTUhNM0ZSS3RZYkp3U3MvbnVzWEhJUk5YQ3JK?=
 =?utf-8?B?ZFp0RHh2U3RBNzZGN3dPYWJQS25BZHRGWDIweUJyY3hMT2JuMXBkQ0E4NlhJ?=
 =?utf-8?B?RTdTM0R2SzJOYjdHUHRoNUVpUnFmWFRUSm1VbHd6NmFMV3dmcC9ETnRMVzZI?=
 =?utf-8?B?L2tpaUlSRnErclMxeGZZYXlScVcvOWJZd2E3bUFUbFlLbjVnU1owZzF0c3BX?=
 =?utf-8?B?dXdHZW9uRlVRZ2NFQWUzSncxaGZDSkwrc2hnSm8yUGdIbjVkOHM2UWplK3Vz?=
 =?utf-8?B?dlZxZ3hVaU5rbi83bzZFL0lSdEFWbGJzQkx5c3k3a242ODhVOTJkbllGc1Rv?=
 =?utf-8?B?Mk9RZmNic2FFSk9pK2VWWHBJc09FSXc5WitnWVpLaTU1dVl6NTFMTDU0bXRF?=
 =?utf-8?B?a1VZOFVZVm5kWWJuWXhzOUg2SGttZXdaZWovZ3ptL1RLQ1A3VlVISEllOUtB?=
 =?utf-8?B?eXZ6dFdycDQ5Qm1tTzBpUFZSWW5ZaHhkNkR5UlZiakhEUWdqMFBjcE00TGlV?=
 =?utf-8?B?amw4T0c3NjJqRU9MaWRUekFaU1luTmRreWc2RnFqRWtEVHZINWVKL1hyTlYx?=
 =?utf-8?Q?AFwynwUo7duuVMqY=3D?=
X-OriginatorOrg: nutanix.com
X-MS-Exchange-CrossTenant-Network-Message-Id: f95e7ce7-d970-4496-f43a-08de6ae5871d
X-MS-Exchange-CrossTenant-AuthSource: PH0PR02MB7159.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 13 Feb 2026 09:51:58.2224 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: bb047546-786f-4de1-bd75-24e5b6f79043
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: gmWugPuo7nQWZ9QRWbPT+kasA/qFNqv9sHkU+x7AQaKkTAnUxtibGNR379ZGmVmSjVdHGmNCvcGJj73s6C2iMkqOGt1TZso/EUFokZDQQsY=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA1PR02MB8852
X-Proofpoint-GUID: rK3Yolf1JcD2mXbIHbML7LxG7pdvBAAs
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwMjEzMDA3NSBTYWx0ZWRfX4p1StbgGPb9D
 qlfdAWtAHSICOj3UWdcSEpU1TkNsi8KkkMccCWzmDTKYIbIbyJzUjqDqBG7tDIM9wa58X7GlGmg
 BE7YHJJ/aLxWg9sm30Zjkhanez9FZpTlqH39GKWiPQpiqrxzJhVgF8//DDsq1ErcVUiGmRUzLq8
 muGraOlpqIhZoZUsppapdT1TyYTvadT3UmnVJzmeD4sQ96Lhp+GOtfC594Jz8xNSd3uyKxanEzQ
 MRrpjxNiXNSloWU6W+JjC8rGdODddkilDoL/liHYFuuy+FC3yaETOCzPdYq9dxsZACwfH81rUL2
 ba3YwxW40bXOb3ecopoXaeMNbcA2/c/+CglYNL8xxVbCpBl3jWXLFr+HeGFaUOzcpqF6CfCE5JX
 6JqkKtWfNVNltXdAlQxgzyQgcNcouqb6e+HCtpmKWje1Dno5mNBWqQ8gm1Jc+y200wTPEtEpS9m
 yORcccCiCNkOh5+WChA==
X-Proofpoint-ORIG-GUID: rK3Yolf1JcD2mXbIHbML7LxG7pdvBAAs
X-Authority-Analysis: v=2.4 cv=DrxbOW/+ c=1 sm=1 tr=0 ts=698ef440 cx=c_pps
 a=x8fXg9NzY3hbHNzXWQS9+Q==:117 a=6eWqkTHjU83fiwn7nKZWdM+Sl24=:19
 a=z/mQ4Ysz8XfWz/Q5cLBRGdckG28=:19 a=lCpzRmAYbLLaTzLvsPZ7Mbvzbb8=:19
 a=xqWC_Br6kY4A:10 a=IkcTkHD0fZMA:10 a=HzLeVaNsDn8A:10 a=0kUYKlekyDsA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=Mpw57Om8IfrbqaoTuvik:22 a=GgsMoib0sEa3-_RKJdDe:22
 a=20KFwNOVAAAA:8 a=64Cc0HZtAAAA:8 a=OqkfTW9lKEOJ6iQ_K2AA:9 a=3ZKOabzyN94A:10
 a=QEXdDO2ut3YA:10
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
> Migrate the ALSA audio backend from the legacy driver init/fini
> callbacks to proper QOM realize method.
> 
> The alsa_audio_init() function is replaced with audio_alsa_realize(),
> which performs the same ALSA option initialization before delegating
> to the parent class realize method. The empty alsa_audio_fini() is
> removed.
> 
> The Audiodev pointer stored in ALSAVoiceOut and ALSAVoiceIn is removed
> as it can now be accessed through hw->s->dev.
> 
> Signed-off-by: Marc-André Lureau <marcandre.lureau@redhat.com>
> ---
>   audio/alsaaudio.c | 43 ++++++++++++++++++++-----------------------
>   1 file changed, 20 insertions(+), 23 deletions(-)
> 
> diff --git a/audio/alsaaudio.c b/audio/alsaaudio.c
> index e8541e1a2a3..42bfea2515d 100644
> --- a/audio/alsaaudio.c
> +++ b/audio/alsaaudio.c
> @@ -40,19 +40,14 @@
>   #define TYPE_AUDIO_ALSA "audio-alsa"
>   OBJECT_DECLARE_SIMPLE_TYPE(AudioALSA, AUDIO_ALSA)
>   
> +static AudioBackendClass *audio_alsa_parent_class;
> +
>   struct AudioALSA {
>       AudioMixengBackend parent;
>   };
>   
>   static struct audio_driver alsa_audio_driver;
>   
> -static void audio_alsa_class_init(ObjectClass *klass, const void *data)
> -{
> -    AudioMixengBackendClass *k = AUDIO_MIXENG_BACKEND_CLASS(klass);
> -
> -    k->driver = &alsa_audio_driver;
> -}
> -
>   struct pollhlp {
>       snd_pcm_t *handle;
>       struct pollfd *pfds;
> @@ -65,14 +60,12 @@ typedef struct ALSAVoiceOut {
>       HWVoiceOut hw;
>       snd_pcm_t *handle;
>       struct pollhlp pollhlp;
> -    Audiodev *dev;
>   } ALSAVoiceOut;
>   
>   typedef struct ALSAVoiceIn {
>       HWVoiceIn hw;
>       snd_pcm_t *handle;
>       struct pollhlp pollhlp;
> -    Audiodev *dev;
>   } ALSAVoiceIn;
>   
>   struct alsa_params_req {
> @@ -707,7 +700,7 @@ static int alsa_init_out(HWVoiceOut *hw, struct audsettings *as,
>       struct alsa_params_obt obt;
>       snd_pcm_t *handle;
>       struct audsettings obt_as;
> -    Audiodev *dev = drv_opaque;
> +    Audiodev *dev = hw->s->dev;
>   
>       req.fmt = aud_to_alsafmt (as->fmt, as->endianness);
>       req.freq = as->freq;
> @@ -727,7 +720,6 @@ static int alsa_init_out(HWVoiceOut *hw, struct audsettings *as,
>   
>       alsa->pollhlp.s = hw->s;
>       alsa->handle = handle;
> -    alsa->dev = dev;
>       return 0;
>   }
>   
> @@ -766,7 +758,7 @@ static int alsa_voice_ctl (snd_pcm_t *handle, const char *typ, int ctl)
>   static void alsa_enable_out(HWVoiceOut *hw, bool enable)
>   {
>       ALSAVoiceOut *alsa = (ALSAVoiceOut *) hw;
> -    AudiodevAlsaPerDirectionOptions *apdo = alsa->dev->u.alsa.out;
> +    AudiodevAlsaPerDirectionOptions *apdo = hw->s->dev->u.alsa.out;
>   
>       if (enable) {
>           bool poll_mode = apdo->try_poll;
> @@ -794,7 +786,7 @@ static int alsa_init_in(HWVoiceIn *hw, struct audsettings *as, void *drv_opaque)
>       struct alsa_params_obt obt;
>       snd_pcm_t *handle;
>       struct audsettings obt_as;
> -    Audiodev *dev = drv_opaque;
> +    Audiodev *dev = hw->s->dev;
>   
>       req.fmt = aud_to_alsafmt (as->fmt, as->endianness);
>       req.freq = as->freq;
> @@ -814,7 +806,6 @@ static int alsa_init_in(HWVoiceIn *hw, struct audsettings *as, void *drv_opaque)
>   
>       alsa->pollhlp.s = hw->s;
>       alsa->handle = handle;
> -    alsa->dev = dev;
>       return 0;
>   }
>   
> @@ -871,7 +862,7 @@ static size_t alsa_read(HWVoiceIn *hw, void *buf, size_t len)
>   static void alsa_enable_in(HWVoiceIn *hw, bool enable)
>   {
>       ALSAVoiceIn *alsa = (ALSAVoiceIn *) hw;
> -    AudiodevAlsaPerDirectionOptions *apdo = alsa->dev->u.alsa.in;
> +    AudiodevAlsaPerDirectionOptions *apdo = hw->s->dev->u.alsa.in;
>   
>       if (enable) {
>           bool poll_mode = apdo->try_poll;
> @@ -901,7 +892,8 @@ static void alsa_init_per_direction(AudiodevAlsaPerDirectionOptions *apdo)
>       }
>   }
>   
> -static void *alsa_audio_init(Audiodev *dev, Error **errp)
> +static bool
> +audio_alsa_realize(AudioBackend *abe, Audiodev *dev, Error **errp)
>   {
>       AudiodevAlsaOptions *aopts;
>       assert(dev->driver == AUDIODEV_DRIVER_ALSA);
> @@ -929,11 +921,7 @@ static void *alsa_audio_init(Audiodev *dev, Error **errp)
>           dev->u.alsa.in->buffer_length = 92880;
>       }
>   
> -    return dev;
> -}
> -
> -static void alsa_audio_fini (void *opaque)
> -{
> +    return audio_alsa_parent_class->realize(abe, dev, errp);
>   }
>   
>   static struct audio_pcm_ops alsa_pcm_ops = {
> @@ -953,8 +941,6 @@ static struct audio_pcm_ops alsa_pcm_ops = {
>   
>   static struct audio_driver alsa_audio_driver = {
>       .name           = "alsa",
> -    .init           = alsa_audio_init,
> -    .fini           = alsa_audio_fini,
>       .pcm_ops        = &alsa_pcm_ops,
>       .max_voices_out = INT_MAX,
>       .max_voices_in  = INT_MAX,
> @@ -962,6 +948,17 @@ static struct audio_driver alsa_audio_driver = {
>       .voice_size_in  = sizeof (ALSAVoiceIn)
>   };
>   
> +static void audio_alsa_class_init(ObjectClass *klass, const void *data)
> +{
> +    AudioBackendClass *b = AUDIO_BACKEND_CLASS(klass);
> +    AudioMixengBackendClass *k = AUDIO_MIXENG_BACKEND_CLASS(klass);
> +
> +    audio_alsa_parent_class = AUDIO_BACKEND_CLASS(object_class_get_parent(klass));
> +
> +    b->realize = audio_alsa_realize;
> +    k->driver = &alsa_audio_driver;
> +}
> +
>   static const TypeInfo audio_alsa_info = {
>       .name = TYPE_AUDIO_ALSA,
>       .parent = TYPE_AUDIO_MIXENG_BACKEND,

Reviewed-by: Mark Cave-Ayland <mark.caveayland@nutanix.com>


ATB,

Mark.


