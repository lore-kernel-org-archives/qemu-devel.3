Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6C3B0C3DA49
	for <qemu-devel@archiver.kernel.org>; Sat, 20 Jul 2024 20:29:40 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sVGhB-0007WY-O3; Sat, 20 Jul 2024 16:28:46 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <steven.sistare@oracle.com>)
 id 1sVGh5-0007Vi-Cx
 for qemu-devel@nongnu.org; Sat, 20 Jul 2024 16:28:39 -0400
Received: from mx0a-00069f02.pphosted.com ([205.220.165.32])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <steven.sistare@oracle.com>)
 id 1sVGh1-0005tq-Qh
 for qemu-devel@nongnu.org; Sat, 20 Jul 2024 16:28:37 -0400
Received: from pps.filterd (m0333521.ppops.net [127.0.0.1])
 by mx0b-00069f02.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 46KKFkKY006899;
 Sat, 20 Jul 2024 20:28:31 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=
 message-id:date:subject:to:cc:references:from:in-reply-to
 :content-type:content-transfer-encoding:mime-version; s=
 corp-2023-11-20; bh=5wpkHQ5bNa1zDYNSz1GsyXERJCr4FApmR5A/fowDO6o=; b=
 dRjPW4HrM101WrWZWaHSCg92m1dauKpjVG88pudvndIWvQGWNfkSOAiql/Mp4/vG
 +CtTOcSgxMoj2TCzDq9hbFPNg4aVBhKFfqbUxIizwbW7pdU4jlTLJtbFs7tYQlqe
 uaQGcRlw6hPV0lCcamm4O5NxlUji8Cyx3bF6KUs/pAuUPGrfhuSNe26IRyg3kwPL
 8enUoO+CPBDsmiS51lLqrM0kwX9WVUTzNJ+PmFQ90x36fxuow/Nb/Wlgsz9H0ZnX
 rXQ+VdFRs5/hAEOinF10FAz25F/Mp9BFA/MADKuyJvDuJ88prAkcpzN0QZZ6h7pb
 w9gQizeiRjXIxBq5wluC/A==
Received: from phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com
 (phxpaimrmta01.appoci.oracle.com [138.1.114.2])
 by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 40gm41r0af-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Sat, 20 Jul 2024 20:28:31 +0000 (GMT)
Received: from pps.filterd
 (phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
 by phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (8.17.1.19/8.17.1.19)
 with ESMTP id 46KHnBI8024449; Sat, 20 Jul 2024 20:28:30 GMT
Received: from nam11-co1-obe.outbound.protection.outlook.com
 (mail-co1nam11lp2168.outbound.protection.outlook.com [104.47.56.168])
 by phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTPS id
 40g3p5ymb9-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Sat, 20 Jul 2024 20:28:30 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=Dl7faXKhCkPP/jbFQ/VF+tZTwvM2TEYoWEjldcvAhWaDdge39SKyc8eHAIr1EzjU21w4fhaBkRjYEVUHFORutEP2+1LwlJE/51Sieg0DeiHgTvfER6QGeP3c7ogmWy7Gkjk+tovObY/rxrGswi0BdLPkMDxnH1AdAWJ/I1PnOaWylNHLoJl3clRQVKVwmsBhBzNO2krybFqdJS6npc8O52mWT1TWdT6ayxhYERNoLFuxcSTUZVwZVRfR7peT4UhGaU0fzzuKsVBgcvCwW+WW0cf1EhaDbstcwDVEOfnWzD6aaxUEiF4pRHA3MjutQi7xu7wLCb0GU/rY7Zf1v0n/xw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=5wpkHQ5bNa1zDYNSz1GsyXERJCr4FApmR5A/fowDO6o=;
 b=NkTFjkxAQrkHjECixJd3FOs8l/nxrmCWXV6p9IY+owCQCM8QwbfV7yNQvJH6xgaD1EvnUAmtVxXm94cpHK8WWZ3rZFpat+rxP9If8LxjyhQ/rMbWaZyDp1oyN/aKxux4uaXhKAP+w3EdCOoZOz2/W98SS25jGErY541nQI5SAzzY8LPQ8JnK6FVUduvnPl1OHuJJ1leLN5MAHUrrzvrVLi0rRhbspaDuAdivNAfV+asqOx9qPVhMw7Z+dVTI8mx5iYbripK+npX0BV2Eq0obni0qBNZdzmfOSN6w5yMdzRH4B3L+E/Yt64pZtJztS/2RORzO+JO+ZPC4wtkwkjRaCA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=5wpkHQ5bNa1zDYNSz1GsyXERJCr4FApmR5A/fowDO6o=;
 b=U37qvMoDy3BQoVMu0ZfWI3PetIw+PZ4AGYDIpHWpz+9e30adk+EQRh+uFBqyBJlDBhpKCujBxU9kkAPG2D6nUqMaL2jSNz4MzJYXC6bROzmAMLRGuvy52xngxsy/608T25ttMxhzxctPSXH8M3oztvxlT3V8PF2wMECXrVzfOsA=
Received: from IA1PR10MB7447.namprd10.prod.outlook.com (2603:10b6:208:44c::10)
 by MW4PR10MB6583.namprd10.prod.outlook.com (2603:10b6:303:228::7)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7784.18; Sat, 20 Jul
 2024 20:28:27 +0000
Received: from IA1PR10MB7447.namprd10.prod.outlook.com
 ([fe80::f2fe:d6c6:70c4:4572]) by IA1PR10MB7447.namprd10.prod.outlook.com
 ([fe80::f2fe:d6c6:70c4:4572%6]) with mapi id 15.20.7784.016; Sat, 20 Jul 2024
 20:28:26 +0000
Message-ID: <88945053-6918-4096-ac55-0ef4b946b241@oracle.com>
Date: Sat, 20 Jul 2024 16:28:25 -0400
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH V2 01/11] machine: alloc-anon option
To: Igor Mammedov <imammedo@redhat.com>
Cc: qemu-devel@nongnu.org, Peter Xu <peterx@redhat.com>,
 Fabiano Rosas <farosas@suse.de>, David Hildenbrand <david@redhat.com>,
 Marcel Apfelbaum <marcel.apfelbaum@gmail.com>,
 Eduardo Habkost <eduardo@habkost.net>,
 Philippe Mathieu-Daude <philmd@linaro.org>,
 Paolo Bonzini <pbonzini@redhat.com>, "Daniel P. Berrange"
 <berrange@redhat.com>, Markus Armbruster <armbru@redhat.com>
References: <1719776434-435013-1-git-send-email-steven.sistare@oracle.com>
 <1719776434-435013-2-git-send-email-steven.sistare@oracle.com>
 <20240716111955.01d1d2b9@imammedo.users.ipa.redhat.com>
Content-Language: en-US
From: Steven Sistare <steven.sistare@oracle.com>
Organization: Oracle Corporation
In-Reply-To: <20240716111955.01d1d2b9@imammedo.users.ipa.redhat.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: MN2PR20CA0043.namprd20.prod.outlook.com
 (2603:10b6:208:235::12) To IA1PR10MB7447.namprd10.prod.outlook.com
 (2603:10b6:208:44c::10)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: IA1PR10MB7447:EE_|MW4PR10MB6583:EE_
X-MS-Office365-Filtering-Correlation-Id: 47b1300a-a5d1-4d02-8164-08dca8fa828b
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|376014|7416014|1800799024|366016;
X-Microsoft-Antispam-Message-Info: =?utf-8?B?Qit5aFdOcVQ1VThtZlpON1JBQzlNMFlsa3JkaElXbGlCTm41VHVLcnNxU3hT?=
 =?utf-8?B?Y09lRENKdUYwSm1DZkZSWWxwa2xLcTRxMWd2cWh3aFJzSzhjZTFycWxjclZt?=
 =?utf-8?B?K1lTWkNHZUt2RTdhbU1aOEk0c1FZeitIYUNQMEFSdHltYnRIbWNSYzRFQkVR?=
 =?utf-8?B?QmVYazlNRWxUd3JxeWpBLzZPQ0lZdWczN3Rrc1FJdFQ3SUFodHpwa2FERjBY?=
 =?utf-8?B?eHYzWmxaU2Y0bWJwRUFVdHlxa1FONkF6QzljVGltVUx0a3huMDJBbTc3d1NY?=
 =?utf-8?B?eG9kS2x1Zzg2M0NRamxPa09jUTRtamhoL0hBOUxEaHh4RVR6QnNGb1ZiY09u?=
 =?utf-8?B?UUJxekY4eHNQMkc5eUdnbzZPMXBVeTFhb3ZINEtPMm9sNmZ3U3pKcVRwUnpI?=
 =?utf-8?B?UkM4Q1RxcU5aQUEraG84Um1nTjR5ZTQrbWpRckFKVlNOZm5yTStST1diK0RP?=
 =?utf-8?B?OXIzbEJMeFMwdXpQV1F3cVJkcVh3QzFob0NjQm1FRXR1bUZtWXpnVlE5M05O?=
 =?utf-8?B?cDExaXpuZmRVbCsxRzhVNWNxY1g2WG16OExVTG9FREhSNCtEbW8xRHRKQVpN?=
 =?utf-8?B?cEFkdXlxY0swSEhubjk2bXJSWkp2VnpWSC9RUkEyL0ZZdTVOZnFWNlhUbjRG?=
 =?utf-8?B?U0RDcHNRcmowVnVMMkZzZzNGcEdaNGZTTHpvQmJyV1dtZVMycXJEdWd5bTky?=
 =?utf-8?B?SmMwNGdHNC9TSGpmeVFZTDcwRnNIYnZ2VVZPYXQ3UFY4Y3RRZUNuUzF0ZkVi?=
 =?utf-8?B?VzdrczVZZUNkNUZNQy9KZ09nSDR3R2o2YlJJd0wwTTIySHh0cXpwb0VVWU5k?=
 =?utf-8?B?SXhseldqTUlnc3hJYTVWM2ZFMXloVTA4YkJndEJIK2lQbmlJZXk5dk0zS20w?=
 =?utf-8?B?aldIQW91MVdzYm9YaXhPSC85UnNGdVhqZDJDRFJ3N204RjFINStjZmlZQVpp?=
 =?utf-8?B?a0VIMzk2QTJlMmVscklCYUZ3eXJzR0hvcVJFZmNoVHdUeUVReTZZRVlXcXcx?=
 =?utf-8?B?THdaOTdBRERWZ0RkamVpcGdmUXJhS0UvZXZuSzZ6ZHArZTVsY1ZPb2cvTXhC?=
 =?utf-8?B?R0p3RUNLQURmbk1GbmE2ZlFWWjNBTGdxcWd6MU95Y0h4VkthM0lYVWs1TVlQ?=
 =?utf-8?B?ZTNHL1dlRC9hMGtvelAwK2FzSkJ5QXBqeGpWRHQzNkFvZlFKTWFiZUVmN0sv?=
 =?utf-8?B?K2VST3g0cUtmdWNsRk1aSDhtcXh5Y3huTmlReXNrNTRpSkd1WjdaSGJoRjZ5?=
 =?utf-8?B?L0I3b2MyUFNxeVRoY01rYWdlaW9tTjg2S1RqdnF0bmFVTDRSOVJiM21Nbytl?=
 =?utf-8?B?TWN4WGtKSGE1aFFmRmsrK3pQaFdXVFRRU0VleW5yWkJpWUlVWkpGMzdDZk85?=
 =?utf-8?B?NytUakVZMnU4WTkzbC9BcUthdGYxQzFsRDREVXArV1lqam9CZHcvTURHdHNQ?=
 =?utf-8?B?aVZrb2VUdnNWREIybElKLzcxdzFJZXFYYm9RbW1IV01Wd3M5cFpRODJuT1hQ?=
 =?utf-8?B?QmdTb2JaRnBVNWZodHFTL0hnWXJoTkdmUEh5NDRHOTN6Nnp6M0hlNTc0OGNF?=
 =?utf-8?B?NGFsdjQwa0hiRlhuZVk4VkhjQXZscEljYkQ0M1ZEWkJ3RDdqcExoNGtwMEcx?=
 =?utf-8?B?bTM1bkFuaFM3YUI4VWtjMElwVFhGb0VXTFRzeC9jaEExMkNzS0FyVUNOUXhD?=
 =?utf-8?B?QlJzb0ZzenJUaFlhQlFIMnpoNXF3STRqdk96Y0dFcm5VMWNmK0JPS1BHa2gz?=
 =?utf-8?B?QzF4ckZsdTRnMWFJc2RpQXB1Y0FMdm54bzROeWxBMTBydkg4ZHN4L1lpd1dP?=
 =?utf-8?B?RTBMMWhBWVFQSTRKRTRZZz09?=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:IA1PR10MB7447.namprd10.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(376014)(7416014)(1800799024)(366016); DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?a0orZlRPVzVFNEFreFBWbW0yTmZBZXNtVko3emJQTzNNd01LZkZWZHB6NVZu?=
 =?utf-8?B?d2c2WEgwVWZOa2pVOWFkcitpNDQxSldxeUJ2cGthM3Z2YkN0d3hOSTM5Rnla?=
 =?utf-8?B?VENGL0NpTzdBaWkvVlFxdVJuNmhuV2x6M2xMRkpOSFVWUWsyV2FCcGUvN21k?=
 =?utf-8?B?NTdtYUQvM0lhbnVWdzZqZ0psNndVMEFJc0lsVzJDeVZQWmJjNHh0NEFubE1F?=
 =?utf-8?B?MUw3VUw3OVJsNFJzUEhXZWdrcERzc2picmczMnpmc3ZrRitwdWZHR3ZBVGlR?=
 =?utf-8?B?MkZ0SXVlVW83ZksrK1dLQUxIdnljclVxVzZsSldHakljRkVzZTJ1d2J5emRy?=
 =?utf-8?B?cnYrU2xmZDBueGFQYjJlOTFIbG12Q2dJYlgyQ3Z2b3JWdjVVTEFtRm9GZTZT?=
 =?utf-8?B?cWhrRW9KTENjaDhHeTVsY3FkQ1JFazF1RjlydW9Db25PSE5sNlEyeTVLWjhL?=
 =?utf-8?B?TzhiMEV0a204MUpiOFJ3c1AvU0JlNzZSREg0ZjdjTWlLUEFTbEVVd0ZxcW9r?=
 =?utf-8?B?K1RHeUozeUdqUzB5eTBLb0V1cHA2VFNaU1djMUNPeHBrRnpyUnpOTUpMWnpQ?=
 =?utf-8?B?NWJpUEJvSXJJWm9uRlFJdHZYT2F5MGJtcCtCRURZaStXbFo5L1VWUEhXNElG?=
 =?utf-8?B?empwSmI2WmpyenNWSXFTOGkyUEtUaDM1OXROZDU0c3U4Nmx1NzhIQVdUbUY4?=
 =?utf-8?B?djBNRHQwdXMyeEs4Y2t1cVozdkZoZGZ0MUM5NW5yNEVjRW4wZTVURjZTc1VM?=
 =?utf-8?B?ZHhwTmxXdjZrd2w2aTZEMmx3c0dzWHpOaFNlMkx3UDlhdDUwZHRZdklXakg1?=
 =?utf-8?B?VWhRWUljaHJGRjJTSWltR0pJODgxN1pEM2JMNGlOSzVIZ3I0U3MrbElwQnd5?=
 =?utf-8?B?aUZFSlIxNllDcFBXWCtJbHVqY09IVTMrL3FCZy9yTHVEQkdlZEZFeVVWci9E?=
 =?utf-8?B?eEdNMnZVRWFQUXVaUUJCSURCQmpWM29rbzJsQVFpdmx3Vnp4cS8zYkRFTHBz?=
 =?utf-8?B?NHV6eVptVmptdlc3dVNaaS9ZQzY3czRLU29pendyVExEcnczSUo0eHVKMVdT?=
 =?utf-8?B?aTg0V20vV2dMeHlQWkxDN3haVzd1S0FxN2ZGa1A4RkJvQnM2aXpMZng4RU9I?=
 =?utf-8?B?dERFSVdpeEpTZmtmK3VNa3ljUnJqdHNpQTRhbldwMVdrdDR4T1dMSmpXaWhR?=
 =?utf-8?B?QzRIK1dkbWdpS0JIU2JDWXAzOWN1c3EvYUVvdjJwTjk4NlVSSytpSzIxYmF3?=
 =?utf-8?B?TGs1a3BXM2VPZ0lZMVFyWi83aWpEY2VtYVNqM1lkVmlyTmFOKzFCeTl1Tktp?=
 =?utf-8?B?SEhqSDZNc0t6aStFVlpaeWh1eWVlL00rcy9GQUdyL3JCSmprNHh5ZzEyTlVW?=
 =?utf-8?B?aURueWtMNkFXaXhpcVR2M09FZjhsSUdDaFhabmpPM284YVhRaWcwWFgzaHVx?=
 =?utf-8?B?VGZPY1IzTi9LNzMydGZDeUZmc3ZDT1A3ejVzMUtmVkRzMkNmUXY0MnI3dnJM?=
 =?utf-8?B?Sjg0K1dWekpBTHlwRjRaUzNucElJMGR0b2FxRWQrTUIyckpQbU9yTkphdzRU?=
 =?utf-8?B?Y1huVGYrMGtuRk90ajV2eWZRdGIvZ2p6dGx5NWx0d2czN1JvQ3pqdUF0Vkky?=
 =?utf-8?B?UTAyT3djamR3ZXJkZTU0eDBNNWVpZEtzUjAvbGgyUlQ5aVduUC9zaXpMSVlw?=
 =?utf-8?B?UXpyWWhGMzFPdXFtQ01iaHhQVVhaeXFWcmd5ZnJWd3cyYmRja2hvN3B4RVBQ?=
 =?utf-8?B?MmQ0NjlscG45MHRWWUxGcDNBTm91YTZXY2ovcDVFbGt0cnU1ZkduTHQxclRU?=
 =?utf-8?B?RDVqbVR2eVBqNE9xa0NRWkYrdHMzOFhRcXpVQnQ0MFE3Vyt3ME1FQ0pieUkv?=
 =?utf-8?B?anY5NFFWY2M2NnZ3VFQycjBtZDFXbkZ6MVFYMFhsRXNtVnppNEVaNmlIVWg0?=
 =?utf-8?B?QW54YWZRU3ZpSVV6M2Uvc2J1TUhJMHVURU81Q2xPSWlkUWs4azhsM0YyS2VC?=
 =?utf-8?B?bWtlK1ZKa1hSMlZtRXJvUXF0ZlFhRmpPSUJXZHA0azNOUktIVDk1Ri92VXpx?=
 =?utf-8?B?cnpPbkhNZHV6dGduU05lMERMWDZxK01JRHNVZEQzR2N1MFUrOC9hcDd1dkFt?=
 =?utf-8?B?UXg0dzNMOUFXZzhVY29xcFZ3eFBwSEo4ejRHdmdITktYaEltYzNhU2ZnVjE3?=
 =?utf-8?B?Y3c9PQ==?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: Fw/7pC4ZnmOT+6cATIaciQCj47Vc7LFWYGi9SbKSEDcuzJt7NC86KkAQtuSbUaND/9NdxI8NZYdN+wpqZCIyJr3uYaKGh5vTGpvYiBVC45JZS/nr9F8wgYDmKUV0aX6ffAtLN+IAU3OBxp0ONUWGmZMU9u8tG/1fCK6TixEiaB1m9MNAzIg/WbCv/Zz20tGd32mT+vHK2lDlQajWUBG2eD167bWA4CChE5X/cUJk5EfXzaTGAyHG9xDfwU2c3o7jl5pAhj+HeqaF0bONp6ZH38dRKTqbVRYwWS0k9HQLIvlUpUuz+OTo5hkFGIYGO/xIlHulQNu5ppAsAbrN2OWIYpYWr2RA+DM/AxNo8n1SIrpTQAPX/0U50Ptgz1CKmg3Cb7DDdTtKjrLsTSU2TiZhI3JI47EE9Tjd3daZeia7z7LnxvpRcU5SV/JeHRw5wzHxAk+MYw+pKufDn8ehWsswkL3gkeeEVVxmm6CGbxXYn70b58oYLvQ6o13iYDCNJFAhgGgD7mqSnv+iNITrp8JtaoYZJjxGdv62KVLjjkUSSnkqLHyHGkDV/qA8BDujTBVRy6Rr2l6fQ7GCkSS7Ma2L3dxRmZs7nnm3p/b3VG33O+A=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 47b1300a-a5d1-4d02-8164-08dca8fa828b
X-MS-Exchange-CrossTenant-AuthSource: IA1PR10MB7447.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 20 Jul 2024 20:28:26.5846 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: txIABcoDa8+RiG7bS+D8mpf31GhQDfYCzdlO8i4WBVCQNYBpoE8uq7f/VK8LW/SdMO40v3vkmzXWIrGPHYWBMdPG83zbdrxG4bOwgFbQDZk=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MW4PR10MB6583
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1039,Hydra:6.0.680,FMLib:17.12.28.16
 definitions=2024-07-20_17,2024-07-18_01,2024-05-17_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 phishscore=0
 suspectscore=0 bulkscore=0
 mlxlogscore=914 adultscore=0 malwarescore=0 mlxscore=0 spamscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2407110000
 definitions=main-2407200149
X-Proofpoint-ORIG-GUID: 4PSNSr2yqbyJpgNS78YfaF51XUAXTI48
X-Proofpoint-GUID: 4PSNSr2yqbyJpgNS78YfaF51XUAXTI48
Received-SPF: pass client-ip=205.220.165.32;
 envelope-from=steven.sistare@oracle.com; helo=mx0a-00069f02.pphosted.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_MSPIKE_H3=0.001, RCVD_IN_MSPIKE_WL=0.001, SPF_HELO_NONE=0.001,
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

On 7/16/2024 5:19 AM, Igor Mammedov wrote:
> On Sun, 30 Jun 2024 12:40:24 -0700
> Steve Sistare <steven.sistare@oracle.com> wrote:
> 
>> Allocate anonymous memory using mmap MAP_ANON or memfd_create depending
>> on the value of the anon-alloc machine property.  This affects
>> memory-backend-ram objects, guest RAM created with the global -m option
>> but without an associated memory-backend object and without the -mem-path
>> option
> nowadays, all machines were converted to use memory backend for VM RAM.
> so -m option implicitly creates memory-backend object,
> which will be either MEMORY_BACKEND_FILE if -mem-path present
> or MEMORY_BACKEND_RAM otherwise.

Yes.  I dropped an an important adjective, "implicit".

   "guest RAM created with the global -m option but without an explicit associated
   memory-backend object and without the -mem-path option"

>> To access the same memory in the old and new QEMU processes, the memory
>> must be mapped shared.  Therefore, the implementation always sets
> 
>> RAM_SHARED if alloc-anon=memfd, except for memory-backend-ram, where the
>> user must explicitly specify the share option.  In lieu of defining a new
> so statement at the top that memory-backend-ram is affected is not
> really valid?

memory-backend-ram is affected by alloc-anon.  But in addition, the user must
explicitly add the "share" option.  I don't implicitly set share in this case,
because I would be overriding the user's specification of the memory object's property,
which would be private if omitted.

>> RAM flag, at the lowest level the implementation uses RAM_SHARED with fd=-1
>> as the condition for calling memfd_create.
> 
> In general I do dislike adding yet another option that will affect
> guest RAM allocation (memory-backends  should be sufficient).
> 
> However I do see that you need memfd for device memory (vram, roms, ...).
> Can we just use memfd/shared unconditionally for those and
> avoid introducing a new confusing option?

The Linux kernel has different tunables for backing memfd's with huge pages, so we
could hurt performance if we unconditionally change to memfd.  The user should have
a choice for any segment that is large enough for huge pages to improve performance,
which potentially is any memory-backend-object.  The non memory-backend objects are
small, and it would be OK to use memfd unconditionally for them.

- Steve

