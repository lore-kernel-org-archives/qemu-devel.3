Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C1CB4CAC5AE
	for <qemu-devel@archiver.kernel.org>; Fri, 26 Sep 2025 12:29:19 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1v27Z5-00028O-4j; Fri, 26 Sep 2025 08:28:44 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mark.caveayland@nutanix.com>)
 id 1v27Yy-0001zi-2j
 for qemu-devel@nongnu.org; Fri, 26 Sep 2025 08:28:38 -0400
Received: from mx0a-002c1b01.pphosted.com ([148.163.151.68])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mark.caveayland@nutanix.com>)
 id 1v27Yk-0002Rx-8z
 for qemu-devel@nongnu.org; Fri, 26 Sep 2025 08:28:35 -0400
Received: from pps.filterd (m0127839.ppops.net [127.0.0.1])
 by mx0a-002c1b01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 58Q7LCF91598878; Fri, 26 Sep 2025 05:28:10 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nutanix.com; h=
 cc:content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=
 proofpoint20171006; bh=y/w/FZNDR2MgVs7ypJlDS0jJgUIS+8E06kBoEmMcp
 lY=; b=bkJ3uN/moO68zDrmCn2LuKyyBapwtb0iTHzkspBwrT6+6Os/3K4lhXqP/
 hU3slRnWCGYkk/TtOj5TyLIexC2OMLW4t8ZxIk+nSP/9WbrazO9q1Osx4qDLLTbD
 72zhpij1CrpmN9MJQROqY2WOHuLUXaEmGFx1DarTxPjG13lZbS9PRGTsDMgGQQqp
 GCWYnPa0VCr30Hv2O6ZWhXCvHnWYRXJyuchjzuG4TVzuUBVsWziUVnogsSe6Dhp5
 OQ3U1RJfQ7JoQvrWKVduktYaIUFbLY5GYPETfr2/4dXBzAJHns2HPl1+FU2Th/Gv
 xsMmwj5Ad7H1SWtPEj7xFLXqdcnpg==
Received: from bn8pr05cu002.outbound.protection.outlook.com
 (mail-eastus2azon11021112.outbound.protection.outlook.com [52.101.57.112])
 by mx0a-002c1b01.pphosted.com (PPS) with ESMTPS id 49dbrf1xgg-1
 (version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NOT);
 Fri, 26 Sep 2025 05:28:10 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=rR3sbohZbb++E2o4ubkXHoRi2UOuEcmY3SyLU2s1RIVcd1Xwp5Ygs1RHWAOenKsdmImujn2LOBojMyM4paZN5lbpYFERl3r0vrwt+DkGD4SinXts0DA5WtOc5J7F5lGKb3xPFJJ6dQXMhFCo6SYXbodiDusBd06ieQt9uQiPwdPrUBwJftVgF4FW7sGvp64nPcsaJg8wyHHRULdQWseCn6xR4GOELWjKTd4SWXj3RgznpC38PbDXzLqXkHd7v5dlDdamn+KW5x2BIE4PSBGO3lhQSAtFY9+3q7qihn3pGFYo1Q5nOTfYoehkLlwIbCrAFWIZnK+LtDv3ZHKObY0Hiw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=y/w/FZNDR2MgVs7ypJlDS0jJgUIS+8E06kBoEmMcplY=;
 b=dIAm22VjzC7ShHe/9Fp3i9ZuGOw6nTnXGc9DO9kjRBGFoMK5ajdI44xlWKSCkNNtS9Xb9CFevYF499h85aXmC0DU+zg9vEmMCktnc/+Jdhp1RSxDwaf5NSPPbBxMKT7ZThVyh2KfSDupuU8/Clh/7Go+G0vvH5PpygYGVzWhvf29v2qZqAgSdpzBh2suYid9TqI2RlvKmqppublNo9ZOKbDlu6dMe6kus9ioWHI38nJmTnvLl7TxAHeQJiDKJWppNAKTrFvSP+6TCOcZuu1MC+/XrYEnTDsbVFhgsD8eBLQUjDA8+nDorbBQqKuV8D1bapWGMSUmjaMgqRgvfZSPgw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nutanix.com; dmarc=pass action=none header.from=nutanix.com;
 dkim=pass header.d=nutanix.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nutanix.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=y/w/FZNDR2MgVs7ypJlDS0jJgUIS+8E06kBoEmMcplY=;
 b=FC0mzK+gM/yoIhO9v0f1pB8UbQYf/1LEPcEEB0ZQfQgh/ICy0Qj3LatMc0JqMVDSDVi/pV7FEFARfUrbF9sc2klFs4zAo3SFpcg12V89DE3BcCWwa+R0c5fef40l78Ijql5lc0QRfGvmtz/K4R9JbPALC1XLMREuf2N+97FdkXs/BsVufXudThpb918SAwhFXPmHqUje3UOrha0vCP4k3mgsU569sPF6gonqL8G02FrkVvoo5B1b9F4lY1fPklYP19e3QMBQlqIExSfSERPQgL3rxZk1DDKwYRwLwu9uB3YBQEUsXK4pFCJv9MmXx1UlLy8gw55uZss3bK/lRJQwPg==
Received: from PH0PR02MB7159.namprd02.prod.outlook.com (2603:10b6:510:16::8)
 by PH0PR02MB9383.namprd02.prod.outlook.com (2603:10b6:510:289::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9137.20; Fri, 26 Sep
 2025 12:26:25 +0000
Received: from PH0PR02MB7159.namprd02.prod.outlook.com
 ([fe80::6cf9:b35c:b143:bb88]) by PH0PR02MB7159.namprd02.prod.outlook.com
 ([fe80::6cf9:b35c:b143:bb88%3]) with mapi id 15.20.9160.010; Fri, 26 Sep 2025
 12:26:25 +0000
Message-ID: <9343fab3-f1e8-4a07-ae15-cc905d4bc42c@nutanix.com>
Date: Fri, 26 Sep 2025 13:26:15 +0100
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 2/2] docs/about/deprecated.rst: document new
 restrictions for isapc CPU models
To: Peter Maydell <peter.maydell@linaro.org>
Cc: imammedo@redhat.com, philmd@linaro.org, berrange@redhat.com,
 jdenemar@redhat.com, armbru@redhat.com, pbonzini@redhat.com,
 richard.henderson@linaro.org, eduardo@habkost.net, mst@redhat.com,
 marcel.apfelbaum@gmail.com, qemu-devel@nongnu.org
References: <20250925160453.2025885-1-mark.caveayland@nutanix.com>
 <20250925160453.2025885-3-mark.caveayland@nutanix.com>
 <CAFEAcA_w1QkHACeb9y6GGUOPunu1YHYVQQwat4zdFWODG3u2Nw@mail.gmail.com>
Content-Language: en-US
From: Mark Cave-Ayland <mark.caveayland@nutanix.com>
In-Reply-To: <CAFEAcA_w1QkHACeb9y6GGUOPunu1YHYVQQwat4zdFWODG3u2Nw@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: AM0PR02CA0099.eurprd02.prod.outlook.com
 (2603:10a6:208:154::40) To PH0PR02MB7159.namprd02.prod.outlook.com
 (2603:10b6:510:16::8)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH0PR02MB7159:EE_|PH0PR02MB9383:EE_
X-MS-Office365-Filtering-Correlation-Id: 26f85549-cfd3-449b-a1b8-08ddfcf7e8f1
x-proofpoint-crosstenant: true
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|10070799003|366016|1800799024|376014|7416014; 
X-Microsoft-Antispam-Message-Info: =?utf-8?B?eTJhRUxZSEdxQndZLzdmYVFuUTNZWlFTaEswelFNbHM1bkM2NEM5SFhSckU4?=
 =?utf-8?B?cnRkT2wwdkpMVFdNcDlGdVFBWmlhUGYxbi8rVVo0MUZib1JURmFQQ0UxLy9Z?=
 =?utf-8?B?UWw2YXdjdzBGblNXaGZyV3JOOXVXbHRRK1hUNndPdkRSbURLemE1WlhBSkRx?=
 =?utf-8?B?YWZRZjlzNlN5V3hXeFlKamdKTVpMOGNVOWJvL01Tb0J0R2lrUnM5ak5GTVJ4?=
 =?utf-8?B?anhkQVFXOFM1UHgvRHZsL1c5RTA5V3FuRFExSVdNc3F0cXBCVzNPQ3REQkpO?=
 =?utf-8?B?eDZXckZPWSs2dUJkaHl1SDEvdFVzM0tiSm5UZzFXWmdyQTlKbTQ0Z01ueUZ0?=
 =?utf-8?B?UFdYRWpLYVpnaVFuOXpZSHlNckxOWUo0U203cGQxVG0wY2ZZb0NnbVA1U0Vs?=
 =?utf-8?B?QUl2azdPTnAvaTBqREQweG5RQUpVTC93MjhDRy9BVUFsOHlTL3ZmN0JaK1cv?=
 =?utf-8?B?SGlaWFhLeXJkZVIyaXpid29GSnlEVWdKMi90anc4Wmc2cjdTSE01a1NoVlUv?=
 =?utf-8?B?UmZRNkU5WmNvOWZUeGlhaURuNFMxVVRWMHZ3U0p5eDRwM3BkYXN0UzNvc1lt?=
 =?utf-8?B?SEVLRWFnVDNVZ2F6by9Qek1WUklhYlFGKzZ2dTZzVUtjbDFpYVViNDF1NkpB?=
 =?utf-8?B?NEQxWVc3TlA5TWNxWmpZMlFNZTZzNlVqRWp4b2hCSTVBUWtKTVpNYmd3YXJP?=
 =?utf-8?B?Ykg1RVd2Nm8zRUxmeURGNGlSL1dSVlRNSlFKenJ2cWxWUGs5SDN3dE1hREl3?=
 =?utf-8?B?aUd5UnhRMnc5WFNlQUlVbmRSeFU0bTNiNXltRk8zd1BMYzNuOWgzV3JUdXFl?=
 =?utf-8?B?NitLMzFDUkV2K3phQVVibjFYV2tJYkhGcmJVTUJHOW9BZnMxNjhRL0kvVWRN?=
 =?utf-8?B?SXNyL09CRE1zZnpRWmVINWhwRFhvNUUzanFHQUZMb3dUOGQ2eEFMeTdyUlJq?=
 =?utf-8?B?a3NLenNxa1B3Y2lLUzBWaDJ1MkhWNVcwakdpd0NVQTZCQm5Pa3Rib3RwcHB0?=
 =?utf-8?B?QzFEeTZWK0tEdUVVSVZ3b1NkUG93b1dBb2hlZVQzd0F6dVpRWVRJK1hWY3dU?=
 =?utf-8?B?NmdJZjErb0t1Q2ZvMTdCRFFZL3lYcHBJaHhyN0xFWFNFQzY3ZHZ4UDU3NnBD?=
 =?utf-8?B?M0R4Vys5ZHE3VmkrR084ZEtNV3pjNTI4b3ZKMFNkNmcvN21EMk8vMEtZVjZV?=
 =?utf-8?B?Q2lwNThEUWZaaUVaRmEyR0txelJKeWM1NGhvdklWQlBzZUlOaG1aSEg1VWNO?=
 =?utf-8?B?QXc0S2JQcnZtU3FMRisxV0R6Z0NEMUxsOVgzVXRFV050RC82T3QxVVdtWG5J?=
 =?utf-8?B?YU9IWDFWMWUyNVdNSVp0ZHdUbThzaVMwNUg3dml1bUZ3b1BtVmJKOE1FSWdB?=
 =?utf-8?B?dFdaczZGTmdZdUVUN3RpS0hOaVdMdG81VHRiK1ZqMndTNWtQdUdtb0hRMnJ6?=
 =?utf-8?B?bWxFMHhOYlB5YngvSVlxZzhuWjNuUk1tWlZXS0RBMkRKTWpQZ3RZY3czaXZC?=
 =?utf-8?B?MVY2YmdCeDZHTmk0VzlmQUh4WmFqeEdIU1BDZTZvQmhLMnBVMzVDMUVpTDZt?=
 =?utf-8?B?S2QvcDJUNGEzRGxiRFZRWEZKcWxaaSs3bnNQRDU4QytXcitkNmZrcFhZcTFD?=
 =?utf-8?B?Q2lUWWs5Wmc1QVh6d1ByaVh2Qk1JMXh0eTAxSkxIeFlhQnlXcFdlRUpzM3Fj?=
 =?utf-8?B?ai8ydHpNdTJNb2J6NDRLeUNSNDBkd3FVaGJxU252cjZ4MVRhaDhpczVtVFUx?=
 =?utf-8?B?dTZCc3dnNUowY09jbnZsRlVGa1IzTDJpS3JNWkJBQWNvN2dpY1RFd0Vsa1dF?=
 =?utf-8?B?cHY4STgvb2pMVkhnamYxVjBsSCtUam1tVU5YUlhTRUFxOHg2YWk0MmtybU9M?=
 =?utf-8?B?YjlZa1NNT0h5UVpFNzZSZGN3K1A4VnJJZ1RuS2JUUGR4VVI5WTlmbFdYWWpv?=
 =?utf-8?Q?0mT0gktN2RZ7GidUcMtAoQECDV1Snpy6?=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:PH0PR02MB7159.namprd02.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(10070799003)(366016)(1800799024)(376014)(7416014); DIR:OUT;
 SFP:1102; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?Tzl6bGlMSDBpZndXYXFFbzk2VTR5U3dGb2NyaWFSMnN0MkhFanhQZm1kM1Qx?=
 =?utf-8?B?K1A1OTJWZjU4NENTaEdlemQwcHVNbk83b2x3Yk5qZm5VTnp1SmI1WFJHYTlH?=
 =?utf-8?B?Y1ZNeERXVEpUaEJ6clRnVy9NZHB4UXlKNmxjZzlBVm9XMCs1eTVuVWZyL3BL?=
 =?utf-8?B?UzIyZXNybk9kRnBjOERidDlYUGQweWt6dUFOK056c2hWdWdnRk1iYzNYajlG?=
 =?utf-8?B?M1BjcllsNjVYOFc4RDFQT0p0Nk5oZENmcjE5UXZWNUgvak9iTWp0WE1KcWd3?=
 =?utf-8?B?TDQwRzRnTTJTVDhrM1dtKy8rSVBEa3A4RHlDT1BKY0J1bkdkMmYybVNqMlJB?=
 =?utf-8?B?eFM5aThBMTVkcXA2OGEvSTA3MVBwVHVlUytWSzFaakFGVFMvL29TYUs1S3Fu?=
 =?utf-8?B?L0swa3pxeUkrRUlEOGoxYjdNTElWTGRwU2JjTUZDY3pEaFRtYlpqNXg2UUxu?=
 =?utf-8?B?MkFxU1Nlc1RncDZFczBwa0lzeWJBZ09MbEpVWHlaZDQ1U2duZ2FrR3U1WjBh?=
 =?utf-8?B?VGxxTW1TRkFiazRFWEp1d0pLOFZTdVhnSlFVV01ONjBJM0E2eHh2L05vS1ZB?=
 =?utf-8?B?aTR2NWhKcFNlbHZqbUNBTjZRNXJldzJYemJrUVZMTisvd01MQkRYODJEcXVn?=
 =?utf-8?B?ZWZIbW9KYWtBWlgyVytJdERJZ2p5dDRaWVFZNEJVa1JVNzJsQkFla0RGL0Rl?=
 =?utf-8?B?UllpQ285RVZOYkJ1TTBzZmJCNHRVR3pZcDdyWk1KQmtBajY0M2lOTnZ5cUtH?=
 =?utf-8?B?V0hrallVakV4N1hsVzhwazVvZGw3ZWNOSU1pSHZRdE11T1JNSkdOcDNlQkhx?=
 =?utf-8?B?Q0Fhait2MUVtMjAxaHdYN2hwNWV4NzBXOUZPKzAzbXRaSW9tUmI0WURGSmFD?=
 =?utf-8?B?NysrZ2FaWDRRTmY4dWpzbXQ5R3dWMkJzeFF4UFlkTzB6YmZrbTllYllDTnVT?=
 =?utf-8?B?VXVZd2ZLT1JGV3ZscHJIaDJnYTBiaXZ6ZmlCWlNxcDhKN05UT1VwRGpXZHhl?=
 =?utf-8?B?ZGFSSlBvQjhPMXBUZFdSdnJZUTJ3N3Bob1JsZ1pGMGZXN0hvbThRT0NFWHpB?=
 =?utf-8?B?WFhQcWIxNHoyRzVSWkJsMTRueVc4VEZJMjRWc2duSmZFaTdyWXdTNVZzdTVx?=
 =?utf-8?B?djdwSERBVitKM2hBOXUzMi9ESTQrb3JKWTZ2Ti9xUjhzUEdCdG13WWYwcHQ1?=
 =?utf-8?B?OHRiM1JvalFzUmRndmNZdmZRR2owdmVlZnRveWQvMHdMVmY4MXRjZVU5N3FG?=
 =?utf-8?B?dGRacXN0ek5nbks0eTVpMUUvU1hodDBtY1lJOXd3UEo3SEk4bGdJN0xUOWRo?=
 =?utf-8?B?VFlnQTlRSDUzSHJ5UFpIa0E5cmVSMExYQUZ1akRhYWJwM0Y5QVhlWnUydm5J?=
 =?utf-8?B?WjVaY3B3dGtsaXlxTGxKMEZNWE5KV3pCb2kyd3Qza2ZSWFBoWGNkYk11cnY4?=
 =?utf-8?B?TlE2MjU2cnBDaHFxZm9GWmRWalhveVRJODFsTFJzc1hVSHBjNXBQVWpxT2pw?=
 =?utf-8?B?WEoxTndGbi9rcU5MbHc1cHJrZjRReEN4THF0L2ZLY2U4eklwU2ZUaUxTVUlC?=
 =?utf-8?B?MTVaNFluaUVndEZxYlZoZXJJenRwdGtIeGYyMGNabjhZbERqR3RuWVF2Z3I1?=
 =?utf-8?B?Um53QUVBR2xld0NTQS9uZ1hBdHRuMkJGV1FTRFJLeFlrUW5weTd2YitseVJN?=
 =?utf-8?B?cDlibWQrZUc0TXNhbng0VEFZaWlmd2lSVHQxalFTRjIyVEx4M0xLSkp1UCtT?=
 =?utf-8?B?cE1ETGpaV3Z0UGtrNUZwQkh4ZjJaRFVieWYrZGVObFd4YXFtcFh4WlhjbkR6?=
 =?utf-8?B?VytON1ZvYVp1RkdLQTdtYkczNUZkeExMWGJxS21kcTRZWk5TTW9ySCtsandH?=
 =?utf-8?B?bkYzWlZHeGNvTFZEWlVEM2laN3RYQ0o4cmorSkdnUjNYZ3J0d1JxL2JnZEVQ?=
 =?utf-8?B?elVIR1B6RWhPa2F3M3RQa1AwSEJnYVFpcFo0TzNUSEpIaXBVUDU1RTV6WlhS?=
 =?utf-8?B?Rk5yOXZxOFhJemRwa01PSDlWMTJubGVpZ2xEZklPNFpYWUxpSG5yRmxDVHZN?=
 =?utf-8?B?NFJnUDJ0eTY2RXBNLzVtSzJiaTdBOHNsSGU4VTRMV3FmSkMvUTdURCt2RVAy?=
 =?utf-8?B?MktFUGJTQzdCV3hPQjdhUmhWdlBkWEoyUVE0bU5Dbm5kRWR0czd1dTZOREd2?=
 =?utf-8?B?Mm5la0pxeTMvWExTbHRmY3VCcVRTbnRYVW1jVE05U0J0UHBHSm43WHpmWmxp?=
 =?utf-8?B?azgwSlZYdEpxNmd6OCtmM0dtTlN3PT0=?=
X-OriginatorOrg: nutanix.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 26f85549-cfd3-449b-a1b8-08ddfcf7e8f1
X-MS-Exchange-CrossTenant-AuthSource: PH0PR02MB7159.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 26 Sep 2025 12:26:25.4342 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: bb047546-786f-4de1-bd75-24e5b6f79043
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: QUi5GtAAiFTkiJnyDtNzpCSUAD5B2j/uvqkeuMl4gMyY5Ide6lMt1fLuzeC11huZrW5FfghEto3Dm2MOg+Iym6Ek38BiLnkmCMOq+VjMJmQ=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH0PR02MB9383
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwOTI2MDExNCBTYWx0ZWRfX80X6zou+gTqv
 CvmLxX50B5blrM/j5D/batsw5eJwufAaqCPGlYbujiDrDhjloSRIWNmMqqhoIqly/ae87A1AhDw
 yxO6L8pFGy1+UlbIQvpw5oudHsWg4u+PRuDsTfVRTX3/egP/Vd2agkFro4rFWTj73epV6PPm0jZ
 TPHMK/UMdlzgk5xzfvhnkje4CVJwnqapK57OZYJyE1/dBu6MhcJykVrhDqrJLnpf2v3+8oyTZm0
 vYS/CWEr5XktD76KCaBEy46c0zOyvPcdzQ+Ll8qj+8Dw4aGR8gIJir1dduNRRdKAqHuvFpfuZ4f
 XP7qNyTmJbjs3jGvvU86Yl3fbAUdbxh62Wnsz5CiP+m2FA+Sxrp2UzwCaGHBIiXwn0+zlSKBJGQ
 55UEPIIBOKPzrIHPuPdwcTdbY/IcNQ==
X-Proofpoint-ORIG-GUID: 9nsE4C7g6lJfhRgsWOCuYeEwHrrD4fc1
X-Proofpoint-GUID: 9nsE4C7g6lJfhRgsWOCuYeEwHrrD4fc1
X-Authority-Analysis: v=2.4 cv=aKj9aL9m c=1 sm=1 tr=0 ts=68d686da cx=c_pps
 a=Tfh5kxD+BHZRkXOJdNqs0Q==:117 a=6eWqkTHjU83fiwn7nKZWdM+Sl24=:19
 a=z/mQ4Ysz8XfWz/Q5cLBRGdckG28=:19 a=lCpzRmAYbLLaTzLvsPZ7Mbvzbb8=:19
 a=wKuvFiaSGQ0qltdbU6+NXLB8nM8=:19 a=Ol13hO9ccFRV9qXi2t6ftBPywas=:19
 a=xqWC_Br6kY4A:10 a=IkcTkHD0fZMA:10 a=yJojWOMRYYMA:10 a=0kUYKlekyDsA:10
 a=64Cc0HZtAAAA:8 a=Y3w0Dp44TZVTHr_NwsMA:9 a=QEXdDO2ut3YA:10
 a=cPQSjfK2_nFv0Q5t_7PE:22
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1117,Hydra:6.1.9,FMLib:17.12.80.40
 definitions=2025-09-26_03,2025-09-26_01,2025-03-28_01
X-Proofpoint-Spam-Reason: safe
Received-SPF: pass client-ip=148.163.151.68;
 envelope-from=mark.caveayland@nutanix.com; helo=mx0a-002c1b01.pphosted.com
X-Spam_score_int: -31
X-Spam_score: -3.2
X-Spam_bar: ---
X-Spam_report: (-3.2 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.446,
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

On 26/09/2025 13:05, Peter Maydell wrote:

> On Thu, 25 Sept 2025 at 17:07, Mark Cave-Ayland
> <mark.caveayland@nutanix.com> wrote:
>>
>> Add a new paragraph in the "Backwards compatibility" section documenting that
>> the isapc machine is now restricted to 32-bit x86 CPUs, and -cpu host and
>> -cpu max are no longer supported.
>>
>> Signed-off-by: Mark Cave-Ayland <mark.caveayland@nutanix.com>
>> ---
>>   docs/about/deprecated.rst | 13 +++++++++++++
>>   1 file changed, 13 insertions(+)
>>
>> diff --git a/docs/about/deprecated.rst b/docs/about/deprecated.rst
>> index aa300bbd50..4c7000650d 100644
>> --- a/docs/about/deprecated.rst
>> +++ b/docs/about/deprecated.rst
>> @@ -514,6 +514,19 @@ available firmwares that are using the current (wrong) name.  The
>>   property is kept as is in 9.1, together with "riscv,delegation", to
>>   give more time for firmware developers to change their code.
>>
>> +x86 "isapc" board restricted to 32-bit x86 CPUs (since 10.2)
>> +''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''
>> +
>> +The "isapc" board represents a historical x86 ISA PC and is intended for
>> +older 32-bit x86 CPU models, defaulting to a 486 CPU model.  Previously it
>> +was possible (but non-sensical) to specify a more modern x86 CPU, including
>> +``-cpu host`` or ``-cpu max`` even if the features were incompatible with many
>> +of the intended guest OSs.
>> +
>> +Now the "isapc" board contains an explicit list of supported 32-bit x86 CPU
>> +models. If the user requests an unsupported CPU model then an error message is
>> +returned indicating the available CPU models.
> 
> This should go in "removed.rst", I think. "deprecated.rst" is for
> things that still work today (perhaps with a warning) but will stop
> working in a future QEMU release, not for things that we have already
> caused to stop working. (And we should only go directly to
> 'removed' for features that we are sure nobody's using, but
> I assume we've already had that discussion for the code change.)

It's an interesting one because rather than removing something, we're 
adding a validation check to prevent the user from doing something that 
is nonsensical, i.e. using a modern CPU on a board/OSs that would never 
happen in real life. Given that just about everyone other than hobbyists 
is using the pc/q35 machines on x86, the target audience for isapc is 
comparatively small.

There was some concern that libvirt could generate -cpu host/-cpu max 
for isapc on the command line which is why I added the original 
workaround, but then Igor intervened as maintainer and requested this to 
be removed and enforced via valid_cpu_types instead.

Where do you think would be a suitable place in removed.rst? Maybe the 
"System emulator machines" section?


ATB,

Mark.


