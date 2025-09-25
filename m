Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id BB5ABCAC5A5
	for <qemu-devel@archiver.kernel.org>; Thu, 25 Sep 2025 11:37:17 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1v1kFh-0000qr-De; Thu, 25 Sep 2025 07:35:09 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mark.caveayland@nutanix.com>)
 id 1v1kEW-0006zy-9m; Thu, 25 Sep 2025 07:34:05 -0400
Received: from mx0b-002c1b01.pphosted.com ([148.163.155.12])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mark.caveayland@nutanix.com>)
 id 1v1kES-0008Uk-2m; Thu, 25 Sep 2025 07:33:55 -0400
Received: from pps.filterd (m0127842.ppops.net [127.0.0.1])
 by mx0b-002c1b01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 58PAtG8p1851329; Thu, 25 Sep 2025 04:33:42 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nutanix.com; h=
 content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=
 proofpoint20171006; bh=NO+KKpgVYbkNonVL4A5vvBxeKkNlI/k2plWrcfGXP
 y4=; b=S1moI4kPKpRuCHBfj1LBty0VA41pesQxxv+1nQ8bKq1prtxWVVW1fgDQs
 KvqS/FvgG8H68BDWHoe+JNd8liJZfx4FN1YkbXTKESUDaLy7hmVDqllPgy4tJDIJ
 yjF528baQpMF3czMrTgnKyEQJgmwp9us1sJUzcBN+SGIJXpViuosvspC6X6phP2P
 VvuecbXVIfgU4fLerymRL+zZqoj//N5M6V4ou+dpXbIZghbiyZ6jIBTeO09gaaPa
 oe40FSmjUGDmXT3eKhyrKLP1lripRnJmzaCTzGB/MNAuZjxfqryxufU9xuC/LWY1
 DqgUf57GKD8Fjzz2bXmjfpvb/pTGw==
Received: from sa9pr02cu001.outbound.protection.outlook.com
 (mail-southcentralusazon11023099.outbound.protection.outlook.com
 [40.93.196.99])
 by mx0b-002c1b01.pphosted.com (PPS) with ESMTPS id 49cgsjavg3-2
 (version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NOT);
 Thu, 25 Sep 2025 04:33:42 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=FRxDHe1+oDN3Oc2CQqlymQx0ywAf1yJahyq1Auj7RcCqF945NUVN3r0hVssEmLmjdA6wvvjHV6VUg2NCsFq/Yt1mjULGRVbTGYq36Qtdm8lQZLkmNXZwg72hKa4cNoYENK3Geo+GqKdIPssoITOxavo4+/9huDhVP3DHrVj6TjWHEOjeuLbmStNKUGPnn+sJ1S4K5jixeO8SuWbTAojT5akxfFNidUMrfGEboydLwfLA3qfoDjCwe6qqP22ZBy30paWvnCsIMo9gJ+g38zGB1RlpdwVibi6D0O7HEu7mOGNKgHakC7JgmHhJqt8SsnqI11q2fspn9xKnfg3382brMA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=NO+KKpgVYbkNonVL4A5vvBxeKkNlI/k2plWrcfGXPy4=;
 b=uwn4mEnRaxqL3yO+CxTEmQz5TaR45dD7zC77ir0yO5IvVtapedU1AzMvtqPD0LW3iK7WninlqURaiJcV9wNtPMHzzNhewW0zzgRIMZEZgc0JYa8nwyfMfKzy9/0KEdtHbLA/RJ2SVqqRhi1uVbPhnKXhDeCEH3GozzQSlTf7aMrfaDSEfrK9Vu/qF0A1l+99jB6yWtEy9OTwkA+a/+e2MsMrnuopsKnNf7p0NoUV3+shwYfUyD0BOVGiZC5ihKupvdr+ylmcCmxbnQQbR/W9aN/PspNmdBHL+c9YUfTlhRwisBm+o89W2XEDYZQA5p9NFclgZxtjvh+E+hbC3uYE+w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nutanix.com; dmarc=pass action=none header.from=nutanix.com;
 dkim=pass header.d=nutanix.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nutanix.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=NO+KKpgVYbkNonVL4A5vvBxeKkNlI/k2plWrcfGXPy4=;
 b=gWPRlqo/0tIWiwz4U+tm8qs/lf6rBc/o7pAjiZSNIDhCzWBRSfsEMdeiWKPN2h38dGyIW/GC/jBBjACtIeOIGHKlyEjwvr7kk1mTQnlkJvniblaiIZU2xR7PcLDe9Sgjt8Tud18RIaAJCPmkGFUcS/XVLEDAz2LIKtfGKYkUg8mYAmmFq21o9jK2HqqiR+8vdF43zKW/JHIwdFYdRDn3SwoxYEFdaVrwr++bxVLgntB2nxgOds9WDoPzxejJDLS4rY+Xlg6+3j0SHblCc0EDXYWv+KEhqfougv0uRoSYvc0rj0pFkD03UhQiIJB1IzNZfrKdNpbhvQd1GLJy9CEsbg==
Received: from PH0PR02MB7159.namprd02.prod.outlook.com (2603:10b6:510:16::8)
 by CO1PR02MB8380.namprd02.prod.outlook.com (2603:10b6:303:153::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9160.10; Thu, 25 Sep
 2025 11:33:41 +0000
Received: from PH0PR02MB7159.namprd02.prod.outlook.com
 ([fe80::6cf9:b35c:b143:bb88]) by PH0PR02MB7159.namprd02.prod.outlook.com
 ([fe80::6cf9:b35c:b143:bb88%3]) with mapi id 15.20.9160.010; Thu, 25 Sep 2025
 11:33:41 +0000
From: Mark Cave-Ayland <mark.caveayland@nutanix.com>
To: npiggin@gmail.com, harshpb@linux.ibm.com, mjrosato@linux.ibm.com,
 farman@linux.ibm.com, pasic@linux.ibm.com, borntraeger@linux.ibm.com,
 thuth@redhat.com, richard.henderson@linaro.org, david@redhat.com,
 iii@linux.ibm.com, john.levon@nutanix.com, thanos.makatos@nutanix.com,
 clg@redhat.com, alex.williamson@redhat.com, steven.sistare@oracle.com,
 qemu-ppc@nongnu.org, qemu-s390x@nongnu.org, qemu-devel@nongnu.org
Subject: [PATCH v2 25/28] vfio-user/pci.c: rename vfio_user_instance_init() to
 vfio_user_pci_init()
Date: Thu, 25 Sep 2025 12:31:33 +0100
Message-ID: <20250925113159.1760317-26-mark.caveayland@nutanix.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20250925113159.1760317-1-mark.caveayland@nutanix.com>
References: <20250925113159.1760317-1-mark.caveayland@nutanix.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: LO4P123CA0512.GBRP123.PROD.OUTLOOK.COM
 (2603:10a6:600:272::18) To MW4PR02MB7153.namprd02.prod.outlook.com
 (2603:10b6:303:65::11)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH0PR02MB7159:EE_|CO1PR02MB8380:EE_
X-MS-Office365-Filtering-Correlation-Id: e73b5cd4-3185-47ce-9f73-08ddfc275a5d
x-proofpoint-crosstenant: true
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|7416014|376014|366016|1800799024|10070799003|921020; 
X-Microsoft-Antispam-Message-Info: =?utf-8?B?US9nVU9IZGJXRWZzV1oycmloWjJoV0x6OWxCZkdGK0h3Z2dOd2puWExrNjlD?=
 =?utf-8?B?TktudmVFazdkSmI4cEkvNGN1eXJNWEE4TDJqekhTS0REUkFzaFRoZHVEUmZE?=
 =?utf-8?B?MUthSVBYbmRJUzRLeHJqZ3JmWk1rKzhJMDVCWmxJVXdhZE9CSzFkb2x3dWRH?=
 =?utf-8?B?RHc4VmZ4ZEdLcUpBejZvbjgyUVVDUXV6UE13MmxVK1BTRmJ3ODQ4a3ozTFJr?=
 =?utf-8?B?TGZxT1J1WTVzTGxSR0padmF2dGVhV0xLdEYzVXBabU85dVhLM21CVjl2aDEx?=
 =?utf-8?B?bUlEZ3EyZnk4VE1iSlgyQjhYdkV2WCtNWmxVOVJZUnU1elp4U0tBckVmMUU0?=
 =?utf-8?B?VnRJR2tCTjRuMi9aUk5XU2xWVyt3UjhHUWRJWmpQZlZNbDk1OEg4L0RIdXNi?=
 =?utf-8?B?eForWTBrQXpZSzVNNmdCOExKNXVhbzVmTkFBTnZpYS93V1MyVU5SRXJvMFdU?=
 =?utf-8?B?dThLZXNlTlZFQjErMllQODVkVlBDZENoL0FVTW1BNVlRSDdWN0lubXUyeXZE?=
 =?utf-8?B?OWROSDAvMk5Ba2IrOFZ4VVcrNjFFejlBazl5am14b2ZlcWkvTmlHMGY5Nllm?=
 =?utf-8?B?RHM3eWVJTXo5QjVnTCtidGNpMk5iUVpabVhEOGxwb24vRlBqYzhvazFpR21O?=
 =?utf-8?B?RDd0b1Rid2JXa2NhOHpmSEUwZmtoZi9XUzFQemF4TXZJNExuOFVWYTNlWDNS?=
 =?utf-8?B?YWRPTEdQK29US1BkenNjZVByZGg2azVCM1ZuY3EraHppdjE5NGErbUxLd3Bn?=
 =?utf-8?B?dHNyVHpZZkZQcnhCbDBOd2JXRmhNVy9CRW5CZjMwaU9Na25HTGo0cldCUFo0?=
 =?utf-8?B?cnB1bUFsR1l3a2ppUGpGMkRsdUl1dzVVTmo5a3ZKRy91U2pjamFQTlY2SGJW?=
 =?utf-8?B?cFdzUFBvd0kwb0lxOFZCV01NNTl6REM0a3U0aTJ3NGYya0lSWEF4NUo1RUR3?=
 =?utf-8?B?cHJZZlNleGo0NGl6Tk5tRG53MzZ6aEFBK1RaV1ZxYXZ0bEp1TXNPeCtJY1ds?=
 =?utf-8?B?MDBvdnUvWFJJTTcrY1BoTWpEUzJqYlVvbEYvZnVGTUUrbUplNXJ5L2MxcGhk?=
 =?utf-8?B?Ri95aFlHYXQ4Vlp5UURHNjQyM3EwUWFHVWN0TXp6TVA2ZVlHZzRqZzBpaHRS?=
 =?utf-8?B?eTgyVWJhWUxnb1FpTy9MaTB0UmVrUlRRWk96dDRNNDY4aHR5Ym1IbCtjcmJi?=
 =?utf-8?B?SU0weDBkeGNNeXJFUjFVcXZENDM1cFZ0bE4xWTNHZGhKTFNVVHhGeXlYMGdl?=
 =?utf-8?B?TTBweFVwbDN4NEVway9CVG1RL2RIK25BTW1iOE9Lem5hQ2RGc0VLcXpoUkFh?=
 =?utf-8?B?Q0k5bHlzVFBRNEJzK2hEbHVpMzJ0U3IycWhEWHNsWGhDQlpVTmNGbXlyNXdl?=
 =?utf-8?B?OVN1OGJOWGZ3ZGw5aWtwSHRJWmN4bVZiWE5KRlNpTnJKSjB2R2l6cHY0ODJt?=
 =?utf-8?B?ekhnbFlybjBtNmtPSnd5UlpMeC80QXBkd3dsOHlkbzIyK1IrZlBCU2VsM2lm?=
 =?utf-8?B?L0FuYlFpV1VLN3dLd3hjdHJiUC9jK3JQdGdnNUhOa1BVdi84Q3NLSnJVcElq?=
 =?utf-8?B?UHZ4Z2lERWEzQjl5MU13cUpzOThyaE5udVdXTlAxN0dSSmJmY1cxaU01RHp0?=
 =?utf-8?B?WS8zeXNHekpzVGhrUDB2VEhOOGYwTUZjRUs3QStVbmRTaE1sM09jcnhma29Z?=
 =?utf-8?B?eVpkYVcxTGhyR25SZnVNTmc4VjE3NjhnSlBiQjJ2dUcrbVVCd21XMnZ4QUJT?=
 =?utf-8?B?OFRJMGVyTHhFL0dEeHZZcVNnSWVtTWQ2TkRZU2QvZythT2FlM3pTWm1va1p6?=
 =?utf-8?B?dzN0R3dWSG1JYkhVbVcydERCUWNGQys0bHpsNlVpci9nTXVXdkUyL2cvZVhB?=
 =?utf-8?B?RXdwT1ZVcVh6eU5MU3NOZ3orVUluaFBIV0ltUXN2amJQVDRIaVI4T09lR0dO?=
 =?utf-8?B?bGRnY1luV0s0Ni9iaFh2cTRTdUFLQ3B0T1p1V3VvWEhOdm5jVWoxREJhY2U3?=
 =?utf-8?B?cmUzejlmOTNBPT0=?=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:PH0PR02MB7159.namprd02.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(7416014)(376014)(366016)(1800799024)(10070799003)(921020);
 DIR:OUT; SFP:1102; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?TFB2ZlltTFdxcHp5cFhoT3NQbU8rNDAvVmZQWkJJNC9HamM2eTZueklkUlhp?=
 =?utf-8?B?RUdJbTFBYXk3d2Z1OHpPVE43MFZBNWE3bUNzY1NUbjZ1a3lPQzVSVEJZbi93?=
 =?utf-8?B?TGc2Q0t0SlZwRVRTWkNGUCtsMFZqSU1XMGRzbjVNc2lvZ0VTRFdadkhoQmx3?=
 =?utf-8?B?WndNUy9pem8vZ0R1TWVHbXVPZk9PMk12aVhWZzJ6Z09FMWlTZkdRMFB4bzJy?=
 =?utf-8?B?aUpDSmZGYmE3alFMYmFSbjQ4SmE4WHVsMDlxOE5yOVVUaW42U0I0dFNLSnE2?=
 =?utf-8?B?TFFwV0wvUlQ1WStjOFRsa0R6Tk9WckM1aXgzS2VjSGRHRmZDZ0M1L0MyUkdT?=
 =?utf-8?B?ZjhWQTZlWS8xR2xPc2V3Z09oMUhBOEVtemVNVGwrRUV2a0NkdkZwSllVRUNO?=
 =?utf-8?B?a2d6bU1aRUdNbkI4NUJnOVVHZ3JVOEFrSDlUZ3BHcHNpSnJQdXNhbWZrUjFH?=
 =?utf-8?B?ZmRPUjM5cThpcW54QVBQb3NJeFRsZHptR3dhYytLcmZ5dFgrQ1VVK0pyYlU2?=
 =?utf-8?B?UHN6NHAvWUpWNTk0MkdYOGJmWEF4NEwwTU9vMUlQSi93S21JWGkvUEQ0N09K?=
 =?utf-8?B?V3lrTnpaU09xc05UcUk0VnNLUFJlMXdEZW5Ed0w4YktEN1h5TVNKcUFtdStX?=
 =?utf-8?B?U0lMNHJSZUVUeUJZNHFidkpCMExZNHVVSG8wNlpRRUlnZkNGbDhJWE1QbTQ1?=
 =?utf-8?B?eitaU1VGOURxZkRrREJkVm8xajdVZDZoMnU3MnZKODljNnpab2FKeUs5TlVW?=
 =?utf-8?B?d2VUZkw0L3B3VGlnbFlWSC9OQWVUeVh4cGFwckNuVCtFd3kxUVdWQnJObjg3?=
 =?utf-8?B?Wnp1UHpJNkdyQWlCWjg2TXFwYUdkNmM3Vnl4WjFnSzJhNDVUbHZEZzZJYjhr?=
 =?utf-8?B?VngvZVNtTWJuNld0OXZWTzF6bFdwczVrcGRZdFY5MlBFb2xEZ1lnRWlKZnZx?=
 =?utf-8?B?K1dnVlpuV0Ivb1IrZk1KcDRiU3llcmVsY3VmZm54T013aU5jci9XVUdWL0w0?=
 =?utf-8?B?V1ZTZGgvTlNjY3IwdHVmdjQ0d0cxa2R5ckpPZms1RFFsaHR1a0U3K3kvZk9t?=
 =?utf-8?B?cy9pcVBsWkZTSTN4dVJoMU5Rblk3MW9QM1VCRXVKNXZKdmxJOWs4TTI1UmI4?=
 =?utf-8?B?K2dqVHVZYUNHaDUzSjMyeDUwQUIyT2p4cWN0YlRxZXEyTDRPWDF0VWVOb1M4?=
 =?utf-8?B?UGxsTTJBTHY0Uk1RbTg0S0NCOFhHVUZhdjErWUlrcGJicndMbk4yV0lXQ2lD?=
 =?utf-8?B?Q0QwZkRudElBUHc1dFhGbXdjYWtqaXRUZjB6NzAyUGxNTzFjWmZkSVViNFZW?=
 =?utf-8?B?Qm5CdGd0Z1dIekZlZmhrZFhtbUxRUTJHcmhFd2lXZ2NVd0FaRXgrTUZuV2Vu?=
 =?utf-8?B?UktYZ1JEbzlxdS9RR3hhSVgxM0hka1VEMFdhdkRIVXc1WDlSVk4yQnp4Q0tl?=
 =?utf-8?B?K2xBZHpqMThWMWtZbEtHMlJ2UjFwTmU2M3JzWkZ2MjhaV1BYZXM0M2M2TXJU?=
 =?utf-8?B?TlVPeWJFS01HcExTRzJBSlV2SGtveEU0LzJDN05qVnNKcml4QzI0NVI0eC94?=
 =?utf-8?B?d0tObDRBelZQdmM3My9QTmxnVW9qZUFLWFBJRk9zcHVMNFo3blJEQklYdy85?=
 =?utf-8?B?SFYzb1hMSTNQNDI1VmpyL1cyMDZZb2dLem95N3NPeUNxUWFPR2lCK0VoZWdZ?=
 =?utf-8?B?UjNaVEorQTd1TlhQSVhRdVg4KzBIT0N1ck15RHdnUnV6MzV2bk8yYVI3bVY5?=
 =?utf-8?B?NnJvY3dxblJjWlJNd3EyV3N5NXJLQmNkVDJ4ZTBaM1BPUS9CYWNuT1N0Q2Zr?=
 =?utf-8?B?Qzc1YWg1eHQ5Wk1CaklKUGZPd2ZPc2xidDh3M1JLSEFhZGpQb2paSk1reDQ3?=
 =?utf-8?B?eDE3MFFFcWhhWk4xTHVJSCtzSE40VWFpVDJmSGZOQ2VQeGxqbm4zdGdneUJk?=
 =?utf-8?B?YlRoOW45NFVvY01ydVdZeWpFN3dpSUY1SGJLTEVEdXJSYS90VUlvenU3amVt?=
 =?utf-8?B?cm9ZUmYxRm93Q2I5L282RGJMRnZmaklOaGJPT3h3QmdXc0dWU3pvaU1RUjB2?=
 =?utf-8?B?ZjhKZzh3YXlPYUNoNFBoNDhkdUJUcFlLek82WGltczdIbzR1TkxrMHJSZFU1?=
 =?utf-8?B?c2JFUmxQUGhvZEdVdzVLNk5UUUNqdEczVHRnU1lrQW1ybmlzczBCbHFXdThM?=
 =?utf-8?B?SDJDS0pnbmc5OGg5ZDNSY3lScXN6bVlyU01LeWhsQ3lyNjBRS21FeEFSTFl5?=
 =?utf-8?B?enluY0pkWkZSR3JuOWEwNWNWM1JRPT0=?=
X-OriginatorOrg: nutanix.com
X-MS-Exchange-CrossTenant-Network-Message-Id: e73b5cd4-3185-47ce-9f73-08ddfc275a5d
X-MS-Exchange-CrossTenant-AuthSource: MW4PR02MB7153.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 25 Sep 2025 11:33:31.2307 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: bb047546-786f-4de1-bd75-24e5b6f79043
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: slCW1W3LAoyRExgePWs5RRNIJP60PPk5bu2niw3XmgNxglvzdojCThzxK22K+icI0eE2VyWf5nBf1YPTNaV73VHzOHwTepAvbuvZvqrjbGY=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CO1PR02MB8380
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwOTI1MDEwOCBTYWx0ZWRfX/tqLea+TQT7J
 DpmdYlIPua27GPaqF7fNIvD7VNCv2UNTsM0g5V42c9zHcUzCtsm9HxmNRnWOObuxxMRsqYTRmsy
 yiW5PbYnbldnoHxtvvPL9pGfUUjXgbOAMr3ZHUWu6UY9RMcLIVvkri6izLPjmgmeNWyTP1AMdBe
 gs6edhdU+EX24uQyDu5Co3skcxmabk3vFhv1ooOrqQI4sD3QaAB8GF+V7vNzjvkmXVKCH8R3yti
 lCE0TJOdIJyEWUgfkJ1MOgxcosMp3/Y3C/9eTQvQzQpVtjkLySib86kbxtR78CvbWghtg8hg8IA
 w56syFgqzfX1Mr3FeCyJR7o+/5GzHzu2jpkPCL8+eQSTTukHgkCy6VOVuc5CzI=
X-Proofpoint-ORIG-GUID: -t7sX9hX7XHjirz3sHRgj7v3ulfAZsU0
X-Proofpoint-GUID: -t7sX9hX7XHjirz3sHRgj7v3ulfAZsU0
X-Authority-Analysis: v=2.4 cv=aYdhnQot c=1 sm=1 tr=0 ts=68d52896 cx=c_pps
 a=iMozJJ0ZMpdRlXWW5uynUA==:117 a=6eWqkTHjU83fiwn7nKZWdM+Sl24=:19
 a=z/mQ4Ysz8XfWz/Q5cLBRGdckG28=:19 a=lCpzRmAYbLLaTzLvsPZ7Mbvzbb8=:19
 a=wKuvFiaSGQ0qltdbU6+NXLB8nM8=:19 a=Ol13hO9ccFRV9qXi2t6ftBPywas=:19
 a=xqWC_Br6kY4A:10 a=IkcTkHD0fZMA:10 a=yJojWOMRYYMA:10 a=0kUYKlekyDsA:10
 a=64Cc0HZtAAAA:8 a=20KFwNOVAAAA:8 a=VO-VGI-_H-TUAJbT1awA:9 a=3ZKOabzyN94A:10
 a=QEXdDO2ut3YA:10
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1117,Hydra:6.1.9,FMLib:17.12.80.40
 definitions=2025-09-25_01,2025-09-24_01,2025-03-28_01
X-Proofpoint-Spam-Reason: safe
Received-SPF: pass client-ip=148.163.155.12;
 envelope-from=mark.caveayland@nutanix.com; helo=mx0b-002c1b01.pphosted.com
X-Spam_score_int: -31
X-Spam_score: -3.2
X-Spam_bar: ---
X-Spam_report: (-3.2 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.445,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_LOW=-0.7, RCVD_IN_VALIDITY_CERTIFIED_BLOCKED=0.001,
 RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001, SPF_HELO_NONE=0.001,
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

This is the more typical naming convention for QOM init() functions, in
particular it changes the prefix to match the name of the QOM type.

Signed-off-by: Mark Cave-Ayland <mark.caveayland@nutanix.com>
Reviewed-by: Cédric Le Goater <clg@redhat.com>
---
 hw/vfio-user/pci.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/hw/vfio-user/pci.c b/hw/vfio-user/pci.c
index 30f485fdbb..52561900fd 100644
--- a/hw/vfio-user/pci.c
+++ b/hw/vfio-user/pci.c
@@ -344,7 +344,7 @@ error:
     vfio_pci_put_device(vdev);
 }
 
-static void vfio_user_instance_init(Object *obj)
+static void vfio_user_pci_init(Object *obj)
 {
     PCIDevice *pci_dev = PCI_DEVICE(obj);
     VFIOPCIDevice *vdev = VFIO_PCI_DEVICE(obj);
@@ -468,7 +468,7 @@ static const TypeInfo vfio_user_pci_dev_info = {
     .parent = TYPE_VFIO_PCI_DEVICE,
     .instance_size = sizeof(VFIOUserPCIDevice),
     .class_init = vfio_user_pci_class_init,
-    .instance_init = vfio_user_instance_init,
+    .instance_init = vfio_user_pci_init,
     .instance_finalize = vfio_user_instance_finalize,
 };
 
-- 
2.43.0


