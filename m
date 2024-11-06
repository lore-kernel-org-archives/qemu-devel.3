Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0050FD59F73
	for <qemu-devel@archiver.kernel.org>; Wed,  6 Nov 2024 21:00:37 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1t8n7x-000423-9m; Wed, 06 Nov 2024 15:59:45 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <steven.sistare@oracle.com>)
 id 1t8n7u-00041o-RC
 for qemu-devel@nongnu.org; Wed, 06 Nov 2024 15:59:42 -0500
Received: from mx0b-00069f02.pphosted.com ([205.220.177.32])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <steven.sistare@oracle.com>)
 id 1t8n7s-0005wX-70
 for qemu-devel@nongnu.org; Wed, 06 Nov 2024 15:59:42 -0500
Received: from pps.filterd (m0246632.ppops.net [127.0.0.1])
 by mx0b-00069f02.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 4A6JXWmb023148;
 Wed, 6 Nov 2024 20:59:35 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=cc
 :content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=
 corp-2023-11-20; bh=RwO2JWLfznYo+KpqkCxVNgffKo2VAUydYBbOtI8Im8k=; b=
 P05rMU3YsPOmxbwVyspCgZBWbOh/ugQFt5oJktgaYc9g2D9KddRdE6t4a4SE4dIt
 V8e18js2NmvlW1Ha+m1pjL0fSGS/LU7Zk59Sf5Gfenfe5rJHyuhry+5GZdwrrjBz
 H+RxHxbG5pSyPP5d/afiun4dGYxpmig+bmICBWQapn+25ykQia5wMHtggrgr4kpl
 4wRZi690mQ8O4302D5XR7dt4fmSsjfNkyqQUcXwg8qqmj1ncaYwWc1JkdxWnn3uK
 4R5Dw/3/TXrdeiDUys2fAzBPDY4c2uDsbadz84LXJuWososIrBdjGOxozytadBJ5
 +ljO2SYeD2YL3qJ22sqV6Q==
Received: from phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com
 (phxpaimrmta03.appoci.oracle.com [138.1.37.129])
 by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 42nbpss3hq-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Wed, 06 Nov 2024 20:59:35 +0000 (GMT)
Received: from pps.filterd
 (phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
 by phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (8.18.1.2/8.18.1.2)
 with ESMTP id 4A6KYbvY005033; Wed, 6 Nov 2024 20:59:34 GMT
Received: from nam10-bn7-obe.outbound.protection.outlook.com
 (mail-bn7nam10lp2045.outbound.protection.outlook.com [104.47.70.45])
 by phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTPS id
 42p87cfvyh-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Wed, 06 Nov 2024 20:59:34 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=XrYunifGeQ/wtitwlBN0GO2Je7s1QVGyiyBsJ2GdqYmG0GTGcSR8fTEHb7F9JW69IV7UuEnSR70dTEBEvdTPjGi7RXVIT3+Gq4UGlA0Bu97xu7NnCQbu8BH1H1xa/5c6KtgmiGGDNxanxFk2KY7/q0PeeZhRjMnVQ/JE3GhoDDsL9vkN25L5v5eMKX4UaDkzOsMtRw4OrPRv4NXv7Sh8ZfVGPl+nm6s9JMY4tsNuOJyu0DuGGWbispeGhLaPyxf7qPhglCBvbD1yxkNyv07Sp8t0FEYc4kBjjMbyDGUbo+kNSsOl/83GhvvZZN2ABH6814iG2tej/PTM0T7atnlxiQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=RwO2JWLfznYo+KpqkCxVNgffKo2VAUydYBbOtI8Im8k=;
 b=lluqDrY92jcNOqiZF3RF/HUjdEUvSfki5nIyhHCiMDlZ64TrA/lVBvfflGRyDz9pYt0nOcB7ZVxS3Ak1N7qj5sn2MsIdxvLavcEOj++rEG+iL5R84yjstA6pgHekFQF6hOKSB0wGwyr5sTmNnSDpdxpx+QGVWBpKI+omPHBjXEkpowZDPM5DtPCVXq6EuKPcyYAwQQCaWd37pvxyABCLvwnf/G0uM711MQ9t4AIF/ej7qiJo9g6JTHEu14O3hmolZfOVA480EDlWo90Eds36g0ANHKVtsVzRasKsbJdW3LmyjYbTp8FIL5Jr83GkWxyQH/rtW0XK0Ijz12LuXjXWlg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=RwO2JWLfznYo+KpqkCxVNgffKo2VAUydYBbOtI8Im8k=;
 b=WiB9MCSZZa7nwXib5s35w9WO/KvWTqCVqLeyjyM84ipJkzQV08t7IYQSqWj1/fvbbQqJV6MaY6gdOCgwj+dRLhvm+wS7+7gWJSsPHOyM5xdueJHwDhCTtYqcCzGpEZwc+hekel0vSyJnBkhwXZ5HyoF3wuwHNj1d0FnXNRhY2Hk=
Received: from IA1PR10MB7447.namprd10.prod.outlook.com (2603:10b6:208:44c::10)
 by MW4PR10MB6462.namprd10.prod.outlook.com (2603:10b6:303:213::7)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8137.19; Wed, 6 Nov
 2024 20:59:29 +0000
Received: from IA1PR10MB7447.namprd10.prod.outlook.com
 ([fe80::f2fe:d6c6:70c4:4572]) by IA1PR10MB7447.namprd10.prod.outlook.com
 ([fe80::f2fe:d6c6:70c4:4572%4]) with mapi id 15.20.8137.018; Wed, 6 Nov 2024
 20:59:29 +0000
Message-ID: <d78a806f-4c15-4a1c-a9a4-8fb9f215a2a6@oracle.com>
Date: Wed, 6 Nov 2024 15:59:23 -0500
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH V3 01/16] machine: anon-alloc option
To: Peter Xu <peterx@redhat.com>
Cc: David Hildenbrand <david@redhat.com>, Fabiano Rosas <farosas@suse.de>,
 Marcel Apfelbaum <marcel.apfelbaum@gmail.com>,
 Eduardo Habkost <eduardo@habkost.net>,
 Philippe Mathieu-Daude <philmd@linaro.org>,
 Paolo Bonzini <pbonzini@redhat.com>, "Daniel P. Berrange"
 <berrange@redhat.com>,
 Markus Armbruster <armbru@redhat.com>, qemu-devel@nongnu.org
References: <1730468875-249970-1-git-send-email-steven.sistare@oracle.com>
 <1730468875-249970-2-git-send-email-steven.sistare@oracle.com>
 <78fa25f1-03dc-400c-a604-998c53e4fbce@redhat.com>
 <45ea8a8a-928d-4703-b698-d5f910e6a224@oracle.com>
 <1f1a2742-0429-47d5-958f-b37575c1e4ba@redhat.com>
 <c2ca740b-0178-463b-8262-b149841b8def@redhat.com>
 <bcc4cd7e-3532-475a-8989-211e80bf3eab@oracle.com>
 <09701693-436c-4e1a-8206-03eb26cacab5@redhat.com>
 <66c05a06-dbb7-49ec-b58e-ccd917d098ea@oracle.com> <ZyvUg3CP30f3DZYY@x1n>
Content-Language: en-US
From: Steven Sistare <steven.sistare@oracle.com>
In-Reply-To: <ZyvUg3CP30f3DZYY@x1n>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: LO4P265CA0161.GBRP265.PROD.OUTLOOK.COM
 (2603:10a6:600:2c7::8) To IA1PR10MB7447.namprd10.prod.outlook.com
 (2603:10b6:208:44c::10)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: IA1PR10MB7447:EE_|MW4PR10MB6462:EE_
X-MS-Office365-Filtering-Correlation-Id: 845ebe8b-179c-492b-3fee-08dcfea5e809
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|1800799024|366016|376014|7416014;
X-Microsoft-Antispam-Message-Info: =?utf-8?B?ZzBWTnVOSEtWMjdmY3RQM2tvSzBEQ1FTQkpEV2V2bFRzeWRBNGV6MGo3bUVt?=
 =?utf-8?B?SmE5M0FtT1lYalVPN1RzOC9ydVpnNzN4UEs5WEtuOGJwN3VsR09aQ0wxWlNJ?=
 =?utf-8?B?U2JtWXJ3REg4Y0RsT1ZmT2gvRFF2YzJ2Y2crVHh4Y29BQkx0dStsL3oxSXlX?=
 =?utf-8?B?cGh2QjlEM0h0TFNIU1VtUWZJT2V0anNtQml6dHkxckcwUVdvTmtmMWFIM2ts?=
 =?utf-8?B?aDJPdXI5aVA5NU02ZFJUcjVHNmlzUjVMaE51ckU0dHBkV0Vtb2ROOHBhcEk5?=
 =?utf-8?B?RTMzZndaMmlHUVJ2MkY4M1hnQ0lNc2U3ZmRXbHBHaXNKSUJZRTlRRnlNTHdm?=
 =?utf-8?B?SHdIMXFkVEJDeVlncHNOUXhBMDJ5d1BnT2hhZ29OTmVZRG9URmtHL1V1ZGRL?=
 =?utf-8?B?cGNDdVU3M29McUVXQzJWM3A4SE5PdUtXdEh0VEZxTGNlRzRZbSsyOVBJNFJt?=
 =?utf-8?B?MnZTbEFnOHdhN2QzenpJanVJaFZ3WFFDcnRvRFJkaFA3SUJiWUVIS1lKbVFB?=
 =?utf-8?B?WTZYeGhwRXg4bzQ2amxtRm9hcExzQkJpTXZMdjFLb2FOUm5uOU9OOFZVelE2?=
 =?utf-8?B?YkdNM0NWcmx3dVlpN3ZyS2tFNS9FYVhmWUs2OGVoUzZhbXNFUDhJaWZSRDFh?=
 =?utf-8?B?L1hTejljcXIzTXA0RFlwYk9qbTBsVjdNR0ptSmFPbEsrUWQ5bWFwanAwZWVj?=
 =?utf-8?B?bVlPYzBINVh3K3lpWHpCWm44dytiNU91Y2lCY1ZxSFZ4ZlRKT0gzMGc0NTFL?=
 =?utf-8?B?d0hqQ2kvRldLRUhpcUNzMnVkWlVzbDJRN2ZncVZ0VjJCdEdDTVpaRHBEaWZ1?=
 =?utf-8?B?UFNQWVJMMXA0Z2JMc2hvTTdaUVFkaFdlckc0ejhuRDR1R2dQVUVTRVl4MEJT?=
 =?utf-8?B?UCtkYWxnbTV1Ry9mSDdLamp6TGhUR0hnb3JvUW5sRmNadDRIYWtxK05IREVI?=
 =?utf-8?B?UC9pc002anNnRDNOUTlZOWk3K2h1cTh0bHhHMlpjNHVkK1I4NFo0THJ3cVA2?=
 =?utf-8?B?WFZkaWpBT00wc2tZQytnVGJwd3lBd1VsNHgrMmhHTExIUWMxQjhqS0dlb0R0?=
 =?utf-8?B?WDNWVVRnZWRoV2V0aFNRdTJlWWZjNy9MaG01YTF4dzJIempFQ1ZZWDlodFZj?=
 =?utf-8?B?NG9oQlhFYW9xQzNpaldobUNVVjI4U1lXL3l2MGEwV05IWVBxZlAyR1lqaXNm?=
 =?utf-8?B?anRSeGR4bFBVOEIyQWxWdmVpZk1XRE5GUUJiVnZldy9aVlNrVElMY3pvc0FU?=
 =?utf-8?B?a1dtQkY2Uk1XKzZHMWxnWnZ2cW1oT0c5QmV1TnRuWldLaGhrWXZ5cGZFcEJL?=
 =?utf-8?B?b3pmZ1ptcG93T1AyaVNocjgwdjVSUUpXNmVCR25Uc2RLaTBScDRnQ3VhclhP?=
 =?utf-8?B?eFFBMU1wQmNZYTMrbjJZbEgwYmV2QWJiWTYxdmYvTUt5RkVtdlcyWkl5QktL?=
 =?utf-8?B?WklFdHhIdDFWQTBjenVvK0ZIanJxZUFUOFR0c2svZ0U4c2dKUDNyVUlqVDU2?=
 =?utf-8?B?eVdxRXp4b2VCL2NramIvRjlMMjFrUFV6K3lPYkNhdng1YVpNQkFiakc0QkNP?=
 =?utf-8?B?UGZFRE1UUUZnQ282N1VhRzB6MzA1dVdOajUyUGg1OUhMZmxXb3pLSW5YOFEw?=
 =?utf-8?B?LzU4Mm9iZ2k2eTVPd1R5T2JJMWg1aXoyZnIrdU5zcVQ1aFZTZDNmeXpZNWdQ?=
 =?utf-8?B?bGRVdG9mWXNEK3J4LzJrOUhJUnI1eURHc0ZsaDNXamxNdXBWT3RaRzhaMzdz?=
 =?utf-8?Q?IxGu0AxYcNcPqEZf+eVIm50ZGh5rNWrR9JjujpM?=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:IA1PR10MB7447.namprd10.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(1800799024)(366016)(376014)(7416014); DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?U0daT1c0YytZcVNYWk9tMklrV3h5QUY3Y1dsYXd1UnpBREJCaThFRjIwNThZ?=
 =?utf-8?B?THhSM2QzYmVsT01HMHA1bjZpQ0RTOFF3aFdpZjZWRVdMNVFtSURtcDF5MUQ3?=
 =?utf-8?B?T0hXVUw3aHMrY1BYak43aFNDRWFyL1NsUTlWajR3bjNDd3JQNzc3bk5jUmg1?=
 =?utf-8?B?SnpmdTNMOHl1Vlp2S2VIWWN5RG5TNjlCZE40VTVZNHE2TDhsVEh5ZU8vRDJO?=
 =?utf-8?B?c0ZzZEovRjQ5cE94ZDQ4bE00TjhNTWltaFIzTFBzSGkyNjJZbUMzZS9PZDh5?=
 =?utf-8?B?anBHdUJXRmx3TmtUZVMxTS9yU2dpRnJka0IvSlhjbzBHblkxbDBoc1RwbUpB?=
 =?utf-8?B?eTZYekF0bkVMTWgwOFVPc3BtSEdyNTVzaEF6ZEY1QXRwUWlaT3VWbGZWUnJL?=
 =?utf-8?B?WGdGUGY5Q0FFTExwMEJ2LzI5eUUzNUtmYnEyV1k1WTNSTldNTzVVOURHRGlk?=
 =?utf-8?B?QVl2dzVxNjhUQ0NPOFRtM0llNWZ1S2FwakN6NHFvdVlVSTZOMnczelFJNUlt?=
 =?utf-8?B?a3VsMGE3bC9DOFEvUHM3TnZtNXZramNTSTNuZENjcVovbjlzaVZoWHhGbjVQ?=
 =?utf-8?B?WDhZQXJ6UkpFUVRzSjdXcjdLQVhqb3huSkZQTzR2NGg2N0JTMEdYVHZsZUlP?=
 =?utf-8?B?bnRiOGlvb1hpK2lVYXJES25laWdpM0E4cXAxL0phV3NKKzdJMFVpajlhVjdW?=
 =?utf-8?B?SkRiZ1ZWd3J0Y0JLK3RSS0xCYjM3QjdhcnV5R1MzdnVEY1lLaCtaTGQ3N0lR?=
 =?utf-8?B?Wm1neW05WDRWdzJoUjA5RS9lUWFYeUdOdnZveVFwNE1JK2lacEhJai9JUUZC?=
 =?utf-8?B?Vkh2Vmx4U2k4dGJETXJ6Tzl1SlBhdU8wY1JNQm5TdjlpNHVaaTMvWWc2Zndx?=
 =?utf-8?B?R1g4bFMwT3diWVBzeHZTR3NSdk16cndHaTN3aFRja1NRMXlocjFXaytYTjdH?=
 =?utf-8?B?R21iaGpaTjNORG5nSzNaVjIwQVVtMGpLYjN1UzV2bk1iUFRML0t1eUNmL0RY?=
 =?utf-8?B?dDlUS2pmTFRGUzZzb3VVTHRvQlNDZ0tPWlVrVG10MkE2blhKQzhOcU84K2h5?=
 =?utf-8?B?OXdNdDJhQ2Y2alcyWEFoVG9mdUZYdWhTZjhQUlVXZGZVRXdUVTBSMGRaU1RU?=
 =?utf-8?B?cmw3dzZjbmlidVdjd3FQNHJXdGZRLzVrMTlPMmRmd2M5RmpudFVackxKcGhV?=
 =?utf-8?B?U1dBclNrZU4zM01VajJFS1poeTM5ZFVWbXRERUdhTjQrSWVybFYrazBwb1VY?=
 =?utf-8?B?Szl1bXhBeW9mZWYyNmdmRVB3WDRjRU02MTY0V054dGNTQkxWamtXRTRzYnFK?=
 =?utf-8?B?SVl3VEcxN2pmVzd2WFlKdkM0ZndvNFBxSmsxNFo1TTBJaUk3bGhQYkZNZXlN?=
 =?utf-8?B?c1lvb2tmc3hWd0xmaVVMbEQwU3RnVUJkeDhJdVJhZ2gwZWxEZjFnSmJYY2hS?=
 =?utf-8?B?VVROd2lkNktlMStsVkMyZGNtSkxueGYrSzhiUEF2OFRKVEJrUEFyaXVDQUpt?=
 =?utf-8?B?d28yWW9PMW55R09QQ1Y0T1dHVnpnMDg1dTJBYzNqYW9PV0E3VXY2ekFWZnJG?=
 =?utf-8?B?L3pQUE9uTWVaTVc5SU1hUElFOWNVVTU5aVAveXlGR2NsMVdWSFNNZ0FVS3p0?=
 =?utf-8?B?YTVabGMvUXpwZU9zOTFUZE5GYm9HTzN0NmhjUnkzdkIrVDVVTEx6TTRsQnRt?=
 =?utf-8?B?ZElvNzJHbERYNzQ0VkhXb3hzbXdzanRRaTFjNVhRSzI2TWRscVhGZGRGOTdz?=
 =?utf-8?B?aHdIajR5d3FhYmhEUllNTlhFblBuWmxiTGMxSGNZbFZDRDljNFhwam1sSWFj?=
 =?utf-8?B?Y00rQVdCOUpGNEkwSFc1b1N4UWgrelkxck5kaGdqMDhwWVVrWjlOR1BOVTVs?=
 =?utf-8?B?NHIzN0MzTkw2VWtWTTNTMXU5WHBmZ0VZdHJvU0pEVm4xZmpGV1A2SlVZdDB4?=
 =?utf-8?B?SnRFeGZvLy8yRU1oYmNqb3h0LzVJdFpNTVgwbkV4QnpPQXdXczNYSzRLTFJR?=
 =?utf-8?B?SWVMckFWWEhZOGxac0p1Um4vSFN5UHdGMEVueXU3Y2F6ZXN6TkI1b0RJRzV5?=
 =?utf-8?B?b3VTQ2VvY0paZTdNbk0rQmMvcHZWekxwVlRFVTJvZi9WVS9VOWFLMlYwZ2RR?=
 =?utf-8?B?elUrYjNMT1lkMG1nd2grZThla0ZMSitIMG1ZQnBGWmNlZ3dJTHJhd1JEelJS?=
 =?utf-8?B?akE9PQ==?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: Ip8TUhaaeNm+AzykrvG4YQT680e5YELBfYmGfB3h/Ungo2QoXm5n73hvX1NZyUE6Ndvzw7n2SAHwRX4FN9vF8WWDjJJzBdhOl74YU+9+mscNECV9gId7NRLUZoyldx2NKmze6MZw8eFCj9mgY1Y+mI1TmcJxmEFb12j3zFP82F40g36h0meJXoCMIyG6BoGzcJb3Tn1zRfYe8p/Q7MB8vX/44PGj2kAQ960nkAT12ZprdGtmMBfi2hVAjNGNB44P4hBnx9kF0+vgR5hzB5ho77J7DIGse17rGfBQHkaHr1cz66Q9FlKPmRPDp7AouP+IuCOlpVygTmSeQIMUPQzJ6idyk+vc1IHp5E/bMLomPxOl6QFsUUfUqXU148TtZM95Z4bEC0dlOswaqU1uW6uvbRrqTX7RewgNl7VSeVPQ2P8yK84v6Lcpju1wC0mUYrb2Y+JgFVO0ZBMThqsWKkiLEXNy9500Gprz7F43eMsclO/jy+iNrHeymNfLakdMdvQ18/IMgVInuCVG7HcTKXgCiLw+2fW0C+aQlXKsaE0FDEgRa9ehtc3OT8hkj/6hcaMm77IAjT+PSHJwEjIv6Zt+I2f4kdcRHA8JUGaYB3uky9E=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 845ebe8b-179c-492b-3fee-08dcfea5e809
X-MS-Exchange-CrossTenant-AuthSource: IA1PR10MB7447.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 06 Nov 2024 20:59:29.8060 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: gMYsOJX/pzMGhpSreSmkqW+Fp/yD1IQGpiYrzxGhldlr0tZetqVY6jT2y3OUPTpiMLZZBRB5nIrGT9QYUTL1NJCRqtn1K9ExasDyLdxhDpU=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MW4PR10MB6462
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1057,Hydra:6.0.680,FMLib:17.12.62.30
 definitions=2024-11-06_14,2024-11-06_01,2024-09-30_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 mlxscore=0
 adultscore=0 spamscore=0
 mlxlogscore=999 phishscore=0 malwarescore=0 bulkscore=0 suspectscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2409260000
 definitions=main-2411060160
X-Proofpoint-ORIG-GUID: Bzy0Tp8odnXPRiHyldPvpaAXow7b_0gQ
X-Proofpoint-GUID: Bzy0Tp8odnXPRiHyldPvpaAXow7b_0gQ
Received-SPF: pass client-ip=205.220.177.32;
 envelope-from=steven.sistare@oracle.com; helo=mx0b-00069f02.pphosted.com
X-Spam_score_int: -27
X-Spam_score: -2.8
X-Spam_bar: --
X-Spam_report: (-2.8 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_LOW=-0.7, RCVD_IN_MSPIKE_H3=0.001, RCVD_IN_MSPIKE_WL=0.001,
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

On 11/6/2024 3:41 PM, Peter Xu wrote:
> On Wed, Nov 06, 2024 at 03:12:20PM -0500, Steven Sistare wrote:
>> On 11/4/2024 4:36 PM, David Hildenbrand wrote:
>>> On 04.11.24 21:56, Steven Sistare wrote:
>>>> On 11/4/2024 3:15 PM, David Hildenbrand wrote:
>>>>> On 04.11.24 20:51, David Hildenbrand wrote:
>>>>>> On 04.11.24 18:38, Steven Sistare wrote:
>>>>>>> On 11/4/2024 5:39 AM, David Hildenbrand wrote:
>>>>>>>> On 01.11.24 14:47, Steve Sistare wrote:
>>>>>>>>> Allocate anonymous memory using mmap MAP_ANON or memfd_create depending
>>>>>>>>> on the value of the anon-alloc machine property.  This option applies to
>>>>>>>>> memory allocated as a side effect of creating various devices. It does
>>>>>>>>> not apply to memory-backend-objects, whether explicitly specified on
>>>>>>>>> the command line, or implicitly created by the -m command line option.
>>>>>>>>>
>>>>>>>>> The memfd option is intended to support new migration modes, in which the
>>>>>>>>> memory region can be transferred in place to a new QEMU process, by sending
>>>>>>>>> the memfd file descriptor to the process.  Memory contents are preserved,
>>>>>>>>> and if the mode also transfers device descriptors, then pages that are
>>>>>>>>> locked in memory for DMA remain locked.  This behavior is a pre-requisite
>>>>>>>>> for supporting vfio, vdpa, and iommufd devices with the new modes.
>>>>>>>>
>>>>>>>> A more portable, non-Linux specific variant of this will be using shm,
>>>>>>>> similar to backends/hostmem-shm.c.
>>>>>>>>
>>>>>>>> Likely we should be using that instead of memfd, or try hiding the
>>>>>>>> details. See below.
>>>>>>>
>>>>>>> For this series I would prefer to use memfd and hide the details.  It's a
>>>>>>> concise (and well tested) solution albeit linux only.  The code you supply
>>>>>>> for posix shm would be a good follow on patch to support other unices.
>>>>>>
>>>>>> Unless there is reason to use memfd we should start with the more
>>>>>> generic POSIX variant that is available even on systems without memfd.
>>>>>> Factoring stuff out as I drafted does look quite compelling.
>>>>>>
>>>>>> I can help with the rework, and send it out separately, so you can focus
>>>>>> on the "machine toggle" as part of this series.
>>>>>>
>>>>>> Of course, if we find out we need the memfd internally instead under
>>>>>> Linux for whatever reason later, we can use that instead.
>>>>>>
>>>>>> But IIUC, the main selling point for memfd are additional features
>>>>>> (hugetlb, memory sealing) that you aren't even using.
>>>>>
>>>>> FWIW, I'm looking into some details, and one difference is that shmem_open() under Linux (glibc) seems to go to /dev/shmem and memfd/SYSV go to the internal tmpfs mount. There is not a big difference, but there can be some difference (e.g., sizing of the /dev/shm mount).
>>>>
>>>> Sizing is a non-trivial difference.  One can by default allocate all memory using memfd_create.
>>>> To do so using shm_open requires configuration on the mount.  One step harder to use.
>>>
>>> Yes.
>>>
>>>>
>>>> This is a real issue for memory-backend-ram, and becomes an issue for the internal RAM
>>>> if memory-backend-ram has hogged all the memory.
>>>>
>>>>> Regarding memory-backend-ram,share=on, I assume we can use memfd if available, but then fallback to shm_open().
>>>>
>>>> Yes, and if that is a good idea, then the same should be done for internal RAM
>>>> -- memfd if available and fallback to shm_open.
>>>
>>> Yes.
>>>
>>>>
>>>>> I'm hoping we can find a way where it just all is rather intuitive, like
>>>>>
>>>>> "default-ram-share=on": behave for internal RAM just like "memory-backend-ram,share=on"
>>>>>
>>>>> "memory-backend-ram,share=on": use whatever mechanism we have to give us "anonymous" memory that can be shared using an fd with another process.
>>>>>
>>>>> Thoughts?
>>>>
>>>> Agreed, though I thought I had already landed at the intuitive specification in my patch.
>>>> The user must explicitly configure memory-backend-* to be usable with CPR, and anon-alloc
>>>> controls everything else.  Now we're just riffing on the details: memfd vs shm_open, spelling
>>>> of options and words to describe them.
>>>
>>> Well, yes, and making it all a bit more consistent and the "machine option" behave just like "memory-backend-ram,share=on".
>>
>> Hi David and Peter,
>>
>> I have implemented and tested the following, for both qemu_memfd_create
>> and qemu_shm_alloc.  This is pseudo-code, with error conditions omitted
>> for simplicity.
> 
> I'm ok with either shm or memfd, as this feature only applies to Linux
> anyway.  I'll leave that part to you and David to decide.
> 
>>
>> Any comments before I submit a complete patch?
>>
>> ----
>> qemu-options.hx:
>>      ``aux-ram-share=on|off``
>>          Allocate auxiliary guest RAM as an anonymous file that is
>>          shareable with an external process.  This option applies to
>>          memory allocated as a side effect of creating various devices.
>>          It does not apply to memory-backend-objects, whether explicitly
>>          specified on the command line, or implicitly created by the -m
>>          command line option.
>>
>>          Some migration modes require aux-ram-share=on.
>>
>> qapi/migration.json:
>>      @cpr-transfer:
>>           ...
>>           Memory-backend objects must have the share=on attribute, but
>>           memory-backend-epc is not supported.  The VM must be started
>>           with the '-machine aux-ram-share=on' option.
>>
>> Define RAM_PRIVATE
>>
>> Define qemu_shm_alloc(), from David's tmp patch
>>
>> ram_backend_memory_alloc()
>>      ram_flags = backend->share ? RAM_SHARED : RAM_PRIVATE;
>>      memory_region_init_ram_flags_nomigrate(ram_flags)
> 
> Looks all good until here.
> 
>>
>> qemu_ram_alloc_internal()
>>      ...
>>      if (!host && !(ram_flags & RAM_PRIVATE) && current_machine->aux_ram_share)
> 
> Nitpick: could rely on flags-only, rather than testing "!host", AFAICT
> that's equal to RAM_PREALLOC.  

IMO testing host is clearer and more future proof, regardless of how flags
are currently used.  If the caller passes host, then we should not allocate
memory here, full stop.

> Meanwhile I slightly prefer we don't touch
> anything if SHARED|PRIVATE is set.  

OK, if SHARED is already set I will not set it again.

> All combined, it could be:
> 
>      if (!(ram_flags & (RAM_PREALLOC | RAM_PRIVATE | RAM_SHARED))) {
>          // ramblock to be allocated, with no share/private request, aka,
>          // aux memory chunk...
>      }
> 
>>          new_block->flags |= RAM_SHARED;
>>
>>      if (!host && (new_block->flags & RAM_SHARED)) {
>>          qemu_ram_alloc_shared(new_block);
> 
> I'm not sure whether this needs its own helper.  

Reserve judgement until you see the full patch.  The helper is a
non-trivial subroutine and IMO it improves readability.  Also the
cpr find/save hooks are confined to the subroutine.

> Should we fallback to
> ram_block_add() below, just like a RAM_SHARED?

I thought we all discussed and agreed that the allocation should be performed
above ram_block_add.  David's suggested patch does it here also.

- Steve

> IIUC, we could start to create RAM_SHARED in qemu_anon_ram_alloc() and
> always cache the fd (even if we don't do that before)?
> 
>>      } else
>>          new_block->fd = -1;
>>          new_block->host = host;
>>      }
>>      ram_block_add(new_block);
>>
>> qemu_ram_alloc_shared()
>>      if qemu_memfd_check()
>>          new_block->fd = qemu_memfd_create()
>>      else
>>          new_block->fd = qemu_shm_alloc()
>>      new_block->host = file_ram_alloc(new_block->fd)
>> ----
>>
>> - Steve
>>
> 


