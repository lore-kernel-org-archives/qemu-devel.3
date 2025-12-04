Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7FE66D2A520
	for <qemu-devel@archiver.kernel.org>; Thu,  4 Dec 2025 20:06:38 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vRFaq-0000Qk-QP; Thu, 04 Dec 2025 15:06:25 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <bchaney@akamai.com>)
 id 1vRFad-0000EX-9r
 for qemu-devel@nongnu.org; Thu, 04 Dec 2025 15:06:16 -0500
Received: from mx0a-00190b01.pphosted.com ([2620:100:9001:583::1])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <bchaney@akamai.com>)
 id 1vRFab-0004DT-1j
 for qemu-devel@nongnu.org; Thu, 04 Dec 2025 15:06:11 -0500
Received: from pps.filterd (m0050093.ppops.net [127.0.0.1])
 by m0050093.ppops.net-00190b01. (8.18.1.11/8.18.1.11) with ESMTP id
 5B445kJw1472184; Thu, 4 Dec 2025 20:06:04 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=akamai.com; h=cc
 :content-id:content-transfer-encoding:content-type:date:from
 :in-reply-to:message-id:mime-version:references:subject:to; s=
 jan2016.eng; bh=qB6/xIJhO1ENbKJ7i2PEuRH285ho04PtXPIdFMXKXMc=; b=
 CoL3WTiYTjdWyS8Lz8FAADX1kdU+nM2X5eLuhWzCGJu3CuxYoASS4GHb7xBY0rRO
 XilJYUMukGIiOnIz++3nzu64+aGCWPe9k0RVFLiSHYBDrNfSi3fM4FtcgbCfc9hG
 MG7d6+bdXdT/QFmikf03KKvci4UtCnBJ3yILG9g28PC+dAAKLZW83dKOdjP/5IRA
 3sIITqg+IkuFzppFoMripuSbqnHAB30nChiaaREwqjQZpq8s6vjatKWy6gbbdiPM
 fK/QcstCRYtG+wBwaNiCX6AzKCm2viYHE7QNZ1YxurwL4fJDz4GxTl6A/yPYHDIY
 r6WmrTKSrmN1sf0gOgBfMg==
Received: from prod-mail-ppoint3
 (a72-247-45-31.deploy.static.akamaitechnologies.com [72.247.45.31] (may be
 forged))
 by m0050093.ppops.net-00190b01. (PPS) with ESMTPS id 4atwf29qnm-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Thu, 04 Dec 2025 20:06:04 +0000 (GMT)
Received: from pps.filterd (prod-mail-ppoint3.akamai.com [127.0.0.1])
 by prod-mail-ppoint3.akamai.com (8.18.1.2/8.18.1.2) with ESMTP id
 5B4J72nk030201; Thu, 4 Dec 2025 15:06:03 -0500
Received: from email.msg.corp.akamai.com ([172.27.50.220])
 by prod-mail-ppoint3.akamai.com (PPS) with ESMTPS id 4arem2y7pd-3
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Thu, 04 Dec 2025 15:06:03 -0500
Received: from ustx2ex-exedge4.msg.corp.akamai.com (172.27.50.215) by
 ustx2ex-dag5mb3.msg.corp.akamai.com (172.27.50.220) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.29; Thu, 4 Dec 2025 12:06:03 -0800
Received: from ustx2ex-exedge3.msg.corp.akamai.com (172.27.50.214) by
 ustx2ex-exedge4.msg.corp.akamai.com (172.27.50.215) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.27; Thu, 4 Dec 2025 12:06:03 -0800
Received: from CO1PR07CU001.outbound.protection.outlook.com (72.247.45.132) by
 ustx2ex-exedge3.msg.corp.akamai.com (172.27.50.214) with Microsoft
 SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.27 via Frontend Transport; Thu, 4 Dec 2025 14:06:02 -0600
Received: from SA0PR17MB4299.namprd17.prod.outlook.com (2603:10b6:806:e2::12)
 by MW4PR17MB5658.namprd17.prod.outlook.com (2603:10b6:303:12d::10)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9388.10; Thu, 4 Dec
 2025 20:05:59 +0000
Received: from SA0PR17MB4299.namprd17.prod.outlook.com
 ([fe80::2d2f:3703:1db2:1d95]) by SA0PR17MB4299.namprd17.prod.outlook.com
 ([fe80::2d2f:3703:1db2:1d95%5]) with mapi id 15.20.9388.009; Thu, 4 Dec 2025
 20:05:59 +0000
From: "Chaney, Ben" <bchaney@akamai.com>
To: Peter Xu <peterx@redhat.com>, "berrange@redhat.com" <berrange@redhat.com>
CC: "farosas@suse.de" <farosas@suse.de>, "armbru@redhat.com"
 <armbru@redhat.com>, "mark.kanda@oracle.com" <mark.kanda@oracle.com>,
 "qemu-devel@nongnu.org" <qemu-devel@nongnu.org>, "Hunt, Joshua"
 <johunt@akamai.com>, "Tottenham, Max" <mtottenh@akamai.com>, "Hudson, Nick"
 <nhudson@akamai.com>
Subject: Re: [PATCH] migration: cpr socket permissions fix
Thread-Topic: [PATCH] migration: cpr socket permissions fix
Thread-Index: AQHcWk+Ww41l0upbvEuzSutbKZyWdrT9TVYAgBRdCAA=
Date: Thu, 4 Dec 2025 20:05:59 +0000
Message-ID: <3DD5C44B-B1D5-4E5D-95F5-45DA855DDD39@akamai.com>
References: <20251120185733.141912-1-bchaney@akamai.com>
 <aSCOVNMJ-NK_9PuH@x1.local>
In-Reply-To: <aSCOVNMJ-NK_9PuH@x1.local>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: SA0PR17MB4299:EE_|MW4PR17MB5658:EE_
x-ms-office365-filtering-correlation-id: f7d3c50e-c51e-485e-4621-08de33708ad7
x-ld-processed: 514876bd-5965-4b40-b0c8-e336cf72c743,ExtAddr
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
 ARA:13230040|376014|1800799024|10070799003|366016|38070700021; 
x-microsoft-antispam-message-info: =?utf-8?B?eGM3T3VUQ1U3TXlOOFpsc0hudlpPT2JoVFAwRzBVUG12U1JzbkVRN25sQ0hq?=
 =?utf-8?B?cERXWkwzN1M0RzZhQi9UWk5zY2NSRm82WGRjL0JkbGNqRHdLMjNDSkc3TFRj?=
 =?utf-8?B?a0xZVTk5VEhMN0orQU9PRm5SUHdVYjZpZ1UyRUU1MFk0UU5ZTHFKcHlDeUdQ?=
 =?utf-8?B?Ly9sM0RCeWVGNDJiM0N2UEM5MUtLUHJHUjlCT3crekdBV2RqSks1N1VEdjI3?=
 =?utf-8?B?QktNN0JkdkxRK1k4QVhnblFEdVJXN21Bbitld3NYdzNtQlJkazh1SEFwdFg0?=
 =?utf-8?B?YzloNTFqdWJuWnZkdHRobDFTS1BoYjJiNitXY0FrZlFiLzJtV0hIbEZVK1N2?=
 =?utf-8?B?M3B5SS9OZVowWmFVR1d0ZENndm1sbGxua1AzblhER2FtUCtXeGYwT1M4ZzNz?=
 =?utf-8?B?dVhpbFpSdXgzY002M2Z6ZENGbGhQMHpHRGlwTEMzWFpSR1Y0ZXoza0hCTXJ1?=
 =?utf-8?B?U08wMFJuNnY0WGd1M0grUCsxRWNqbGFBZWtQTjdVZWI5Vjd1ZlJJTEVFaTJG?=
 =?utf-8?B?SlROYWJmYmdmNTZTRXJucktIT0FDUFFUMjdmbmlRMGJnVlBJbUxJM09JZ1BP?=
 =?utf-8?B?YmZvRUdoOHFPRUNsalVRZEpVeWZIMGNocE83OTlQMlRDRDRwN1A0WTg4WlEz?=
 =?utf-8?B?SXNBK1F2RTA3cVI3TzNmVUhhVWFvcHY3K2NtRGZLTWdsTklmQ1FCRWNSZ1Jh?=
 =?utf-8?B?QmxhY1RDUnhodStsZVZRRDQxbmhlRGFJVkJjSFVPQnRZRFljMVZuWGkyT2pj?=
 =?utf-8?B?cEtOcGk1TWFMZy83V1VZenltb3hnREc0b1E5d2MyVDFoaGY5VG5uU3RJWUtl?=
 =?utf-8?B?dS8wcnJFZVJOR3RoeU04clkxdHNtNDI5M1NzK1FiQXBJMm92KzFRNDN1NXhR?=
 =?utf-8?B?b2FIZG1oMndjbldrdzJ4NXdCZ2FOajlMSnovNzMyS29KOU0rYVp2WnF2K28w?=
 =?utf-8?B?S3VETVRxMHFMVjNKQml3V1VKMi9vWWhSNDVrbWt2RXpKYkRCYVBMSlh2b1Vs?=
 =?utf-8?B?aDZTV2wzMkdMMld3QThMN2xtKzh1eUVtc1BjSnJWVThaek8vZC8xUzhKSkZY?=
 =?utf-8?B?ZU8xRE8yOVBqS1lrOWx5STFSalRUdXZjekZaSFo4M1ordER0emtwU3Nka2lP?=
 =?utf-8?B?dGk0OTFzRkhqZVNPVUk2K2pybGpCSUFIMUY0YlZMK0R1UDkvTUhTOHViSEdM?=
 =?utf-8?B?QVhnVTVkdXJYZEQ5QXE1OUR2L0JGUnRLMHJ1azVSQi9oL2hZRXhIZ3Nia3My?=
 =?utf-8?B?cTNSdWdYaDlCOGVLUkVoRFZaR21VRFdyRnRSUWRxdVZpTGVaamxKemtRSVM0?=
 =?utf-8?B?YXJwaElGcGNxbitRRmc2TXBjbVVxMUk1WE9YZXRlZDFNUk42UlBZbGNqVERG?=
 =?utf-8?B?NWdjdHFEdzg5T05IT1RLTkZvZzNZd2thL2crQTRKcS80OXM3cmtjMU42M3dQ?=
 =?utf-8?B?cDREQ0ZVU055U3BkSDFhLysxbTExME00R0wxZzdVdFg3bkdYcGM5VWI2UWZa?=
 =?utf-8?B?UXBtMjlRQ0lUTnVuelBoaitoWGpDU1llVFhPc1FIRnA5ejI4dHdXRjBqbGU3?=
 =?utf-8?B?UDNXTzlCMjRrZTlaS09NdHBtVEVsaVlJLytUaWUwUk5ram5ZbENQcG9XT0JF?=
 =?utf-8?B?MmJQTFJEd2RJcVR1VFpJQ1o0bnZzQ3lGcU83UXZSdE9FelQ1Q0JiMjJ2akdK?=
 =?utf-8?B?TFZ2dDJCZS9nTGtNQUowN0Y5bytoTVRtcmFiU2Mya1VtcG5ZVlp0eXRmL29H?=
 =?utf-8?B?VmFFbmlqbjFKUjRhYlNzL0p2M29hUWo3MnVJa0o1Z05QWU5DMXV2M0h1M0Vx?=
 =?utf-8?B?ZnY1OGlPemlHRS9pcklxQWNXcUUrNkphb1ZIc3k4QXRSbXczWEVzbmJKbFEy?=
 =?utf-8?B?MzlvekhxVDl1V2NRUm4velovVGRTNzd1UWFJeGR2ZjVTWWlHYkF3V096ZXlo?=
 =?utf-8?B?dFgxdVc3amJvTkVka2k5MThvajVNTnNMZUZJMTlqNTUvRHJCb0tVU1RjTWd2?=
 =?utf-8?B?UjRLK1Y5VjhmSzl5SkdLcmtqSGxGellsWUtBSHVNUytMcHNMUmZPUEJja1Bj?=
 =?utf-8?Q?UskbJ5?=
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:SA0PR17MB4299.namprd17.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(376014)(1800799024)(10070799003)(366016)(38070700021); DIR:OUT;
 SFP:1102; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?T1VmQ2FqUFBmUWtkQ0dmcmNSK1BwdU9IczQ5S2FITHdoaGNqdjFHY3k4dHBR?=
 =?utf-8?B?U1Y2U2I3b3dhVkpicEYzT1hENjlnVGY3V2N3OXBHcXZFNWxaSzZZSTliRXUx?=
 =?utf-8?B?TnpLRVMrZjFhYlUyWTB1SzRKUVVwQUY5RzFHZXBBNlBWZFFvNHdFV3kzb2ky?=
 =?utf-8?B?Z2dtL2ZGV25aWERqaGlrdkhFSlY5SlVESFp3ak1nbDdzaFphSFZ6Mk81ckh4?=
 =?utf-8?B?SDVRUWk3SVB5NjRhYTIyTlk4bWpKSWgxSXE3M3pXMUJEdlVMOWNTSVZqeUVG?=
 =?utf-8?B?ZmN0bVZKYTZRNWFXRWFUY1lQM3hrRDNZa1VZTkM0TnY3aTFaT2pPTTlwVi9Q?=
 =?utf-8?B?YWxpYWxjcVV3VHZUUjFwNC9ybjVRWUVqcGpKSythc2FvdFdZcUM1TjBvRkRz?=
 =?utf-8?B?MjFDZUluRDR2UHNCYmdkdllvS0NCMWNUbERWR01uall2eGt4OXNqSURITmJR?=
 =?utf-8?B?cHZUODdrN3orNzRJN3lFa2hOWWZDdGk0QkZOWVR5eW00ak40Tys2WDkwMUJo?=
 =?utf-8?B?OGgzSTBHRnJPdTJrTTBocXNyb1lnOUZUZXhpWERHQVF3QVUvR3hUWEljYnVa?=
 =?utf-8?B?OHFmcUJmOVgzWWJTbnlTYWpoYWdwc2Y0VDdYdkN6V2FVN2wwRWhzcDdTdHdH?=
 =?utf-8?B?MVNTUjVnYmttc1VuTXdrc0xIUGlEdzlxM1pucktJb2ZFTXgzRm5Sc2c5SXVL?=
 =?utf-8?B?RFdZb3Q2eStsS3JaSjk5d0RXR3dldWx5TjU1SEJ3ampWSzdaVTNhYmllRndR?=
 =?utf-8?B?OFpub3Q4Z2pBK1JaSlJ2VmdEeFRzSW85ZWNKRyt5MFM5TlNLTHlLZlR0NDZE?=
 =?utf-8?B?bnNQbjg4WmdOSXpSeXJoTUw2RG9iRXBueHhvNlQvSTRTRmdBUTMzUmlXRExs?=
 =?utf-8?B?dkRNRGtnVEM2OVY3alBxdlc3VUZhb0RWUzlkVWs2SjdRUlpaVTFTZ1lkZUJG?=
 =?utf-8?B?WEtMVHFuTTVuRFBKLzErc3dYZTc5cUtkSmFKb0dSemFRTENqcm9qRlZCUFJI?=
 =?utf-8?B?cHVURk9EZW5WSmFEZXpzbFRIekFVSEttVzNhNHJERlYwZEplM09ubC9WMXZs?=
 =?utf-8?B?TTRuMDk5aG9vRUlnbjJlelVkS3dwbWJlUGJCbVBiUHNDajRidEE2YUZWVHBm?=
 =?utf-8?B?YW9jSXkyb0s5b2grZytTTGx3RGV1QlR1bmkrU1JiUEFEVWVvMWRMSHFKQ09l?=
 =?utf-8?B?Q28vN2lqWXQ5VzBQNmpDWHpZMnFtYXpNblppMFkzOTZxaWNEcGM3RFJHNmxs?=
 =?utf-8?B?Nmt3S255ZlRsY3JZVWhlbk5SR0xJWEducURleUJibFFGRmN3WERIZnMrbks1?=
 =?utf-8?B?aXpuMTA5cnhkV3lYOUxNdzNFcThGNTNuVmlKUEx2MTdpQ1ZST2hTYnUyc0g4?=
 =?utf-8?B?SXZHOUxVVWVoU3JVNkZYZ3lCK1ZJcUdmaFpDRlVyejBSNjdzK3VyZWtsTHIx?=
 =?utf-8?B?bzBkSDh4cW12Y2lMcmk3Sks4aE43MU5HVFZ2VmdVN3dDMVdRTmlQdS9SR2pz?=
 =?utf-8?B?MHhsYk5rWXI0VUhXR0JMTWRQdHc1dTM2YzNNditVd0tha1kwMW5HMTFabVlG?=
 =?utf-8?B?UUNEWitHVENZSFc5aFhDMmQzazNxUm1IbUhDaGRic3NDUFVZbWhiR3B5ZlJW?=
 =?utf-8?B?ZFdJQzI0eVBPajVMa1RSZEZWR0RMek5Bb0xGdFN6ZlVkN1NJQjJXaDNGTlhi?=
 =?utf-8?B?a3lHaWR2K2J5azhSTit4ei9DUmVCL1ZqREhSR3RyVGZuVFVTYTBlT1I4Ny9u?=
 =?utf-8?B?SDZxOFpNSmV5cDN1VDI5Q0ZlSlFvWnNPWEFqVlZ6ci95bHA0aUtZYy94VUha?=
 =?utf-8?B?U1NReHFIRDJTWU1pRU9KSFpJWVNtYnhRRDUwVThFMWxXeUFka0NyQm1JdG9C?=
 =?utf-8?B?NkEyWGZVMnQ1VEdISTNXQlgvc1lsa0xMY2RGZ2p3aitaa2xRa05sUnFxMWt1?=
 =?utf-8?B?d1VWQk41dlBXbkhsYzY0RzNNOGt0Zms2ZVVVN2ladkhiWEFpVEFjNlZYaDh2?=
 =?utf-8?B?WUVDV2FoMndNaFd5M2NwYUxGQWFCd2VGcllzMUd3dk9oclZsVzdHRjBOS2py?=
 =?utf-8?B?VkVMYk8rMTc3YlRzdEZldmgxeTU5R3VQNmk2VEQxVnJ0VUc3cExGZnZTMnNh?=
 =?utf-8?B?UHcrYlgzNmlnNm9EamJPRjV1MjM4NU5OcEhmdWYrMEJOV054Q1FDZzZRS2RQ?=
 =?utf-8?Q?cYlOK3TX44fO3CsdlqWY2t8u0dzBTLMts9vUc8HXTBrw?=
arc-seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=Mq230yQdRjGw1fb8z/UN2ZLqiotZu89UMcqyOaUWhu6eGW6bJjmZLV11U/89rVaDGQ0roevrxwKfHVKkUQwC3IqFlZiCZM+8GjrZsFfVowd8s7UuNO/AlJniWW9KOX4oM8BYeypTs42ljnwqhnGwrRXluWtahTeD55DQgKzhWtRSaeiF1DasojhR+04leR97Jjvh8QIYneq4wlRf5RRu1N26fHewWO/kYXjL0cmmNUCaPBmIZ6Zi50O4Do29GcqkXpvsEXZYIC3AnJclFL5Kyvjg6R6fpt1mM2ok0AqZPzpW+kmtcp9WSX5vvi9BNzp9tZz79jMw35rTwgVvKL6rnQ==
arc-message-signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=JhEYOheZnC/0UyB2i0TB9KTpKtCO+/YMJ5cScES3FKA=;
 b=xEt7SkgMBGuEIioBKyK7M228mbmq5oP1WdJZQ/JM+aXAiaV0zepeBQcE0I6sGy4KOLgOnluepjz8xQD1YrGlBywkoPu0kFHlIcILp6y64wBN10YsaH9mzp1ABFoGrgJXmxUqrpolf1EVIKPBwRSnUeTjFJJ0oe02O8YwHntHHbweHztsh737Mx/tA/ZBd2J2XcFgw+MMlXsVylktnkxan9okMg+87ledNEPFQxQc5W7JnH196XAlFIHacnpze+G6PT2SdNFCsdcqeyR5aolRmW4RS9SlQBOB0Llo9SSj+lmRzd1ql+y5FYudmaKpW0UvIKQFarqS392B6eg3zKc3xw==
arc-authentication-results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=akamai.com; dmarc=pass action=none header.from=akamai.com;
 dkim=pass header.d=akamai.com; arc=none
dkim-signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=akamai365.onmicrosoft.com; s=selector1-akamai365-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=JhEYOheZnC/0UyB2i0TB9KTpKtCO+/YMJ5cScES3FKA=;
 b=KcDnuCHfJwmt6W0H8GHtPwwvqyYLAzSISra4CRUH1oTdzRqMDDc5QfBmUChudwG+9GW0/CUNu3WE6kCiisF5ynq/qvi7z1nZB20PLPIETgM2gWW+QgWr3nwTNH9R5kiGJu5CC5wzFxy6+tPDJ8omC8bJ63XO91PvQVgv1dtTsoI=
x-ms-exchange-crosstenant-authas: Internal
x-ms-exchange-crosstenant-authsource: SA0PR17MB4299.namprd17.prod.outlook.com
x-ms-exchange-crosstenant-network-message-id: f7d3c50e-c51e-485e-4621-08de33708ad7
x-ms-exchange-crosstenant-originalarrivaltime: 04 Dec 2025 20:05:59.1311 (UTC)
x-ms-exchange-crosstenant-fromentityheader: Hosted
x-ms-exchange-crosstenant-id: 514876bd-5965-4b40-b0c8-e336cf72c743
x-ms-exchange-crosstenant-mailboxtype: HOSTED
x-ms-exchange-crosstenant-userprincipalname: OqI6ePytgp4N5wfXop6pIqLOPgtR3gaORNGVATP3c9qj5Z6+QmpNVYOovYph3YhAUiN27o7DuH65eem1wy5hxw==
x-ms-exchange-transport-crosstenantheadersstamped: MW4PR17MB5658
Content-Type: text/plain; charset="utf-8"
Content-ID: <8827F4F01DB7E0498535A4868D5EE4A2@namprd17.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: akamai.com
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1121,Hydra:6.1.9,FMLib:17.12.100.49
 definitions=2025-12-04_05,2025-12-04_04,2025-10-01_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 mlxlogscore=834
 malwarescore=0
 adultscore=0 phishscore=0 suspectscore=0 spamscore=0 mlxscore=0
 bulkscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2510240000 definitions=main-2512040163
X-Authority-Analysis: v=2.4 cv=HoB72kTS c=1 sm=1 tr=0 ts=6931e9ac cx=c_pps
 a=x6EWYSa6xQJ7sIVSrxzgOQ==:117 a=x6EWYSa6xQJ7sIVSrxzgOQ==:17
 a=lCpzRmAYbLLaTzLvsPZ7Mbvzbb8=:19 a=xqWC_Br6kY4A:10 a=IkcTkHD0fZMA:10
 a=wP3pNCr1ah4A:10 a=g1y_e2JewP0A:10 a=VkNPw1HP01LnGYTKEx00:22
 a=t2B_wTH4hsGAJ1tOYYoA:9 a=QEXdDO2ut3YA:10
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUxMjA0MDE2MyBTYWx0ZWRfX3PxESelITBah
 UFupiZDlSwG2GFDj6YXNlM0SskPX7959ktt6Q8IjNPZk29F+9hcV2sTQrpb9Mnznnc1u31SQXAU
 /NCyZs2pV3LxjjgRsgU0w4odVptRbgSCaEaYVFz4zMhAOjQGpAlSrZJHMNqYZEF/Z3flOTVrGb4
 2B3UZ31N0/iOEC8oIfMItIIbzsGaRMU/5E0vbyqYWeM3VO9c6UFSoyv7wEgRCNLLkwSy4BWrK+8
 bgp6sqqC13spAM26JPaWA3yrl7/fkr5tuJEDNs6tW+SfvlvFvL8n1HG4MpSwJ9mvpm2xcllELXV
 wi1WxrzkpaNCpuPCKEwTDYeWBB/imKlWNqKHqJmjtPyZrpnljlEEHVLFvrmkGgrH2QqNF9gfuyS
 Vq0ShAoxJXowUzgHsrQfwCClcf7amg==
X-Proofpoint-ORIG-GUID: Eo1pa3t9sT3EotZPFX3WIco8RfrzkuT6
X-Proofpoint-GUID: Eo1pa3t9sT3EotZPFX3WIco8RfrzkuT6
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1121,Hydra:6.1.9,FMLib:17.12.100.49
 definitions=2025-12-04_05,2025-12-04_04,2025-10-01_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 phishscore=0
 priorityscore=1501 impostorscore=0 bulkscore=0 malwarescore=0 adultscore=0
 lowpriorityscore=0 spamscore=0 suspectscore=0 clxscore=1015
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2510240001 definitions=main-2512040163
Received-SPF: pass client-ip=2620:100:9001:583::1;
 envelope-from=bchaney@akamai.com; helo=mx0a-00190b01.pphosted.com
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

PiBDb25zaWRlcmluZyB1bml4IHNvY2tldCBpdHNlbGYgZG9lc24ndCByZWFsbHkgaGF2ZSBhIFVJ
RCBhdHRhY2hlZCB0byBpdCwNCj4gaXQncyBvbmx5IHRoZSB1bml4IHBhdGggdGhhdCBuZWVkcyBh
IGNobW9kKCksIG1lYW53aGlsZSB0aGUgbWdtdCBvZiBjb3Vyc2UNCj4ga25vd3MgYm90aCB0aGUg
cmlnaHQgVUlEIChhcyBzcGVjaWZpZWQgaW4gLXJ1bi13aXRoKSBhbmQgdGhlIHBhdGgsIHdvdWxk
IGl0DQo+IG1ha2Ugc2Vuc2UgaWYgdGhlIG1nbXQgY2htb2QoKSBhZnRlciBpdCBzdGFydHMgZGVz
dCBRRU1VPyBUaGF0J2xsIHJlZHVjZQ0KPiB0aGUgc2NvcGUgb2YgaW1wYWN0IHRvIG1pbmltdW0u
DQoNCg0KSSBsaWtlIHRoaXMgc29sdXRpb24sIGJ1dCBpdCBydW5zIGludG8gdGhlIGlzc3VlIHRo
YXQgdGhlIG1haW4gY2hhbm5lbCBzb2NrZXQgaXMgbm90DQpjcmVhdGVkIGFoZWFkIG9mIHRpbWUs
IHNvIHRoZXJlIGlzbid0IGFuIG9wcG9ydHVuaXR5IGZvciB0aGUgbWFuYWdlbWVudCBsYXllcg0K
dG8gY2hhbmdlIGl0J3MgcGVybWlzc2lvbnMuIFRoZSBDUFIgc29ja2V0IGlzIGNyZWF0ZWQgYWhl
YWQgb2YgdGltZSwgc28gd2UgY291bGQNCnVzZSB0aGlzIHNvbHV0aW9uIHRoZXJlLiBJJ20gbm90
IGZhbWlsaWFyIHdpdGggdGhlIGhpc3RvcnkgaGVyZS4gRG8geW91IGtub3cgd2h5DQp0aGUgc29j
a2V0cyBhcmUgY3JlYXRlZCBhdCBkaWZmZXJlbnQgdGltZXM/DQoNClRoYW5rcywNCiAgICAgICAg
QmVuDQoNCg0KDQoNCg0K

