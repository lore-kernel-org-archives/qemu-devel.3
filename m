Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B5925EDF15B
	for <qemu-devel@archiver.kernel.org>; Fri, 13 Feb 2026 13:44:44 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vqtT9-0001Vj-PC; Fri, 13 Feb 2026 08:44:27 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <florian.hofhammer@epfl.ch>)
 id 1vqtSu-0001V8-Of
 for qemu-devel@nongnu.org; Fri, 13 Feb 2026 08:44:16 -0500
Received: from mail-switzerlandwestazon11020119.outbound.protection.outlook.com
 ([52.101.188.119] helo=GVAP278CU002.outbound.protection.outlook.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <florian.hofhammer@epfl.ch>)
 id 1vqtSs-0003ib-D2
 for qemu-devel@nongnu.org; Fri, 13 Feb 2026 08:44:12 -0500
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=snNBJ0a4jGiMCjF4LFH+GrclQPMMcr4My4bdtFD4x/50coeDiCd/xP41xNrlEyFBG8LyjAI1dYZNHZPZn8ifAUDgDaUccure8LL/0eaI6BEenhVTPB3OKD40PJfJ551pqhVWolG5S8gDAVG9x49X3UGkHZj/LB8r16CMCaIZxI+a5TiBzIKB+iVi/ycAaqeLy8cwAVqYbTmPVLB7ivy3z4uusiWhSniNnFRYLRq1/ts8p0v6ZEUWvA1ygzqp+tpoJNM47fV2cvgNzduaqBNUes22tNwt9Wn+ihFUbCeNExDg/VNEZVKHnfA8Xnn8hUlc/pj3v9x01ABnqkAmSRXzvg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=yYKrRD97UneUSnTH0EqLElMDxxMxNOItxz9BrxlseEU=;
 b=I+naX7rdWtAlv4zBlXM0PrQzKp+NsN3Bbm663r5dhUePIpneMPlav0fxSphIimxjghX8C1X58f/gECWt5LbVV8KwAUra99vnZrJIHajZw1T5Qa5RmnxnCac9+AKYvwYBWaxClARwr9kJLiuT4I00cMtw6JYdA0z50DPD1Oi9kIiKahfJ4M51OJvArm5p9eqmrAdnNQot6tx3lqizqjHQ+vpdw5dqaNa+3XmLu0Qx77SuxJWVzjtsmfT5enPJmOfKMkNT7v7qNW/u5WCPZNLRfGZsidrZUgTuHxhVF816gDqgWr+9d4om7upUpp+SqwtWL8xFXLow8XWL/uetv7lpRw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=epfl.ch; dmarc=pass action=none header.from=epfl.ch; dkim=pass
 header.d=epfl.ch; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=epfl.ch; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=yYKrRD97UneUSnTH0EqLElMDxxMxNOItxz9BrxlseEU=;
 b=lTqjij1wCNv8GSukYe5D/v52myULraTbIz/drJE6oNPkx6jgqGan16ogu/mb5bbNUsBNYVjzomOzUXNJhi3w9I5DdcmqmxnNb6c4wH1TZMZR3r0uK0zC6Kq7rFX4WnX935s5m5N3/KboXcUllsOwHP+AindvmeE4+GRxYqh58hI=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=epfl.ch;
Received: from ZR1PPF9AC83A6B5.CHEP278.PROD.OUTLOOK.COM (2603:10a6:918::2a0)
 by GV0P278MB2025.CHEP278.PROD.OUTLOOK.COM (2603:10a6:710:6d::17) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9611.13; Fri, 13 Feb
 2026 13:39:05 +0000
Received: from ZR1PPF9AC83A6B5.CHEP278.PROD.OUTLOOK.COM
 ([fe80::7db7:1c57:a0e1:54d9]) by ZR1PPF9AC83A6B5.CHEP278.PROD.OUTLOOK.COM
 ([fe80::7db7:1c57:a0e1:54d9%5]) with mapi id 15.20.9611.012; Fri, 13 Feb 2026
 13:39:05 +0000
Message-ID: <878883e5-7100-48b7-bb44-e0728c93ae72@epfl.ch>
Date: Fri, 13 Feb 2026 14:38:23 +0100
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3 2/5] plugins: add read-only property for registers
To: =?UTF-8?Q?Alex_Benn=C3=A9e?= <alex.bennee@linaro.org>
Cc: qemu-devel@nongnu.org, pierrick.bouvier@linaro.org,
 richard.henderson@linaro.org, laurent@vivier.eu, imp@bsdimp.com,
 berrange@redhat.com
References: <ef60bfbb-cc12-4411-acc1-8c131726f22e@epfl.ch>
 <8b36b6c1-83bd-462b-a346-f240dd17746d@epfl.ch>
 <871pjcdt5q.fsf@draig.linaro.org> <87pl6wcda9.fsf@draig.linaro.org>
Content-Language: en-US
From: Florian Hofhammer <florian.hofhammer@epfl.ch>
In-Reply-To: <87pl6wcda9.fsf@draig.linaro.org>
Content-Type: multipart/signed; protocol="application/pkcs7-signature";
 micalg=sha-256; boundary="------------ms090506050604080003090106"
X-ClientProxiedBy: GV0P278CA0041.CHEP278.PROD.OUTLOOK.COM
 (2603:10a6:710:29::10) To ZR1PPF9AC83A6B5.CHEP278.PROD.OUTLOOK.COM
 (2603:10a6:918::2a0)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: ZR1PPF9AC83A6B5:EE_|GV0P278MB2025:EE_
X-MS-Office365-Filtering-Correlation-Id: 7f455e0b-d31f-45a1-2986-08de6b05415e
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|366016|376014|786006|19092799006|1800799024|7053199007; 
X-Microsoft-Antispam-Message-Info: =?utf-8?B?bGtDcWVaUEEva3VyQkNPQzY1VnQrU2ZEZThhaVh1S0I4YnhLSStFVXBEclFB?=
 =?utf-8?B?bCtzUm0vMU9veVMvdjhpL1dhNDRDb3YzRFI2MG9JdnlwVXpnKzlyZ3ZrcXJR?=
 =?utf-8?B?SWhBcStNeUZObkFBSE13WWRINWt5YktydFFZaHMvWERkTEdmSi9ZZTBrU3FN?=
 =?utf-8?B?MG1SR3gzVnRzVEVHald4eWlIUDFyUnVrdjAwalM4ZlpXUGIrc2R0NGNZOXVp?=
 =?utf-8?B?TVc2UTBEQ2JFeStCQ2d1YjJKVUJqaDBUOWc2a1BaQ3lWc0xHcVUzbXlhMk9P?=
 =?utf-8?B?aXhkR1FvSVBoV0FvQTVTTU9LOVpRVmthV2VlTW9wQkVVNmpiY2ptNEgxRDhK?=
 =?utf-8?B?Wk9aNVhaYTdkd1VPM0RDUGM5aThmZm0weUhPbFVkMWVHUWpZM0I4c0JqTTI4?=
 =?utf-8?B?R2hVUFpIK0Q1R1d6b3VjeDd0cWVLQ0RqbjV2TTFZUDN6YVlNVWR2a0hWaXhC?=
 =?utf-8?B?M21iVXA1cmZtVG8vYXVuKzFwYW01MXQ0OGkyRXA2bnpILzlzSjVnM01BSU44?=
 =?utf-8?B?Uk1LemI3R3BuK25Ddks2QTlVQ2xST3BMcFVQNHZOVlIzbkYvaVpueEdVL1RE?=
 =?utf-8?B?YmdoejZRcUs4WmhlcnhoZmFJdVNuL3JPbE0vY3l5bWIzR3dpU0NrTk94MHgy?=
 =?utf-8?B?SVBsV0xGT3hzMjRiQlN0RXJJZTA2QlV0c0hhZDFHQ2p1WjBiRXoyZzF5OGdi?=
 =?utf-8?B?ai8yOGZDMFNDTFZ2Nlc2REx4dzJ5YTkzd1lFMGZCU3p3NUs3Kzg5L0lmRy9D?=
 =?utf-8?B?eGE1ZldEM0xmR2hXdVliN3p0OTVvUHVpQWVETWpMdlcyYm15Z2ZmQlNiN0ky?=
 =?utf-8?B?MXQvbmN0UlpCK1M1ak1RT2RZdDNIQWNraW9kckRPdkFWS0lNVS9mRG80OFdx?=
 =?utf-8?B?cFhrQ3RmUlFvdEduWVBnaXU3RVUzeCtKVWxOM1MvcWphek12L0hzYzh5bE1v?=
 =?utf-8?B?d3d0NENJOHR5eWpSc0M3TENUaENHb25yL0htbU9RNEtTRFg4SUtYM2FQYzRC?=
 =?utf-8?B?RW4yR0x5d05rWWhwVWI2YzRBVmNHWHg0YWY1aTBERnVFcEtLaHFKTUpabWNm?=
 =?utf-8?B?Z0ovcXIrOElQL3NyOFNERm1RSVNOZG9RaTVwc1NkUjU2NU9KMmtsWWV2U0k3?=
 =?utf-8?B?Nm1DTlNRWmlMMzNBSkZRQWFtdFdRUXhwTlJkWDZ2c3pNZlJHTFhGaitjcEk2?=
 =?utf-8?B?U0FDYzhrcWJRdk1LNVYxOUhsUVg5d3NXaUlDV3BmaVBCVVpUdWZmc3hNWUpR?=
 =?utf-8?B?Wkk0cVQ3aVJkWnMyNWxvSG5OSmIrNlNDcmVWVWdBL2o4K1IyM0xmcEtKZ2dF?=
 =?utf-8?B?R0pVZ1dkckNORDY4VlpJWUl3R0N6RXMrenlXbHRaSS9sOEtheVlVMnVyQXFC?=
 =?utf-8?B?UDl3dTFNT2dBTFYyN1hqR0lwWXFEUXl3Zml4QlhLSTJtb0s0cVI3UkRPcUJQ?=
 =?utf-8?B?U0V6VXh0bzg4T3U4VGNQeE5HRFdxY0x3SlF2V0U2YlRnbjN4cnVselZIT09z?=
 =?utf-8?B?OTQxUUNWMW43WXo0dzR3WHZVejFQcFg2aWFzQzcwREJLK2dxYU1qWjBDZVI5?=
 =?utf-8?B?SHRvZVRLQWdNNkIyVUZON1ovY0lBNXd4Y3JveWplT3NTMzhHUFJXdUFKUHlQ?=
 =?utf-8?B?Q1M1NTk4YWIrRHROUzlRUW1ncVNEZTBRZzZLSi92M0Q5OWV3elA2U1podjBu?=
 =?utf-8?B?YUUvck5LeG01bGpPekg2SGp4YzVrdlV1eHAzOUNkQjBoRk8xb1UrUHAraG45?=
 =?utf-8?B?MFMwbXZ1NTRBeUhDcWR0QUtNU0NFcGhIVkhYN3ZCMTBqcjlOZzZSQXZ6Z0pF?=
 =?utf-8?B?UndUbXVrSDZsRHd2cjRxV2VuVDN1UVVsWjh2YnlRd2N0WWhaZE1ZSDF3cndK?=
 =?utf-8?B?SkFOUXYxZGFVdVI5RlVFQVlxUnhQM3BPbjhYVDJQWkREcnZPRFFuclhidHhI?=
 =?utf-8?B?NGx2WWgrWE0yNldXQ0ZubXB4Uy95V2plR3VUQk5ZWFI3Z2N6Vk94Q2N0Nmd3?=
 =?utf-8?B?NzBFdTRYSEtCVStReTdZa2xyMnJVRk1DcXdvNFhwRUFHQXVoOUY4Mm5hMG1F?=
 =?utf-8?B?cXQ4N2gzSTN2UzZHeHJyRDRaV0lSTmZNbDUxeURUb2NETU9vWTdnanRLbWZQ?=
 =?utf-8?Q?g+rI=3D?=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:ZR1PPF9AC83A6B5.CHEP278.PROD.OUTLOOK.COM; PTR:; CAT:NONE;
 SFS:(13230040)(366016)(376014)(786006)(19092799006)(1800799024)(7053199007);
 DIR:OUT; SFP:1102; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?MVE0bTdLTDNSazhHeXVENDNpcU9BWGM5cWNqQkNDRGxKM0hJdFNhTnRRaXAx?=
 =?utf-8?B?VzZMeTVjbklqNDdBTmU2WW1qa3pqVjVMMXBBQm9hMFZ6NHVuNmtVL3hLSmth?=
 =?utf-8?B?Nkx1aEcrcHhKdjZoTU1aUEowK3piSklocXZsejdDNEhiUTNvanZ3SjRjcENa?=
 =?utf-8?B?S3JLRThZMHBNYkFNMUx0SmtNTGs2bUVVS2lYV3VDb2dpZkxBclNvRncvYTVM?=
 =?utf-8?B?Znp4NGNXOXpNa3dmUDdmMVd3ZStqOUdhWUUzYzRETGFmZkI5TlF3U0x1YU94?=
 =?utf-8?B?UklpYk5RdHZ5TGFtWVhiRVE5azBzQVR0eTkzTFBqV3hJL0h3aXdob1BmT3V3?=
 =?utf-8?B?WUxXa0h2SmxLY1BWOUpVVk5id1lXTjJuUmRhbzBMU3g3RTNYTU5TOEVtQmgx?=
 =?utf-8?B?cEhzQ1VKYVEzR1dXZ0QvRGxtemtCYmJnQVBwcklBL2JoOGZ5aVlscHJxR0pv?=
 =?utf-8?B?T1RER2prNHZWNnFYVHpiemMzYXQ4akNzcUVsb21ldE55dHRvc2lLbTE1SUhy?=
 =?utf-8?B?NGNYTWd2SmV6bjU4UGR5dXovVEdHeXhQdTl5ZmNUbU51WkRzc2hFYUJWNTRr?=
 =?utf-8?B?NHIwTkVYcnRPYW9URTVSRWdBTnRYSWk0UWRYMDF2ODNza2xpNzlLK1JQcktN?=
 =?utf-8?B?TlNtRUdlR0Q1SVJ1SUFpOXcrRXlPdDAwRkpXcEVVWGgwYXhpNE5BMHFWMXJG?=
 =?utf-8?B?ZklZSFFCR2VvMWd4Y3ljSHlTd0RXNUs1RVdZRkhDajd2VExQUmp1S0dQY09D?=
 =?utf-8?B?UERBb01VeFhNVWxOTXEzM0sxMDhjeVFQSXZHZ29YZzVFbFBvWVh2RlJTSVRQ?=
 =?utf-8?B?YnFWL2RkVzZ3VFU3VmJxKzYvRm1Pd29qK1RaZFk2cmVpYkNYQzMvbHRidkFK?=
 =?utf-8?B?SDVaYUNmd2Z1bWVRTWd3dUxRRktSUit2dEV0NFBOSXRsOHNxVituMnBPVnBG?=
 =?utf-8?B?bnBld2oySDl2MjkvYWkyeWhnaThDTU12UEFuaWpkNWVVK0lmTG1tVnQxV0FJ?=
 =?utf-8?B?MjNkY01BVXlvUlhjYmhCRDFjUVQvczNzdFZndi85bUNITzF6TU5WNHYwMEZm?=
 =?utf-8?B?RVg0TklSeDBzYnZxbXFQK2I1Uyt1OEpTYXE3UEhrRzdNRVd3cmxtWW1pRkhm?=
 =?utf-8?B?TWVERW9VR1dXdzRLZzB5V0FCS2NhK21MUnRqUFRyZkpsbjNtd2ptWGM1TDJY?=
 =?utf-8?B?ZkFyVlp0WFM5L2lPZDYyT1ZMZGI1RFlITEVyM2VnM0VqaUtkb3lWUHY4OG1P?=
 =?utf-8?B?WS95QWpiRjBCRFR5T2ZacURFUkE0WURxQ0ljNklWaEUvSUdRUDJyYkErS2pi?=
 =?utf-8?B?WkF3WlJoQ01ZejQyVS9IMDV3VWxueG1MUXZOVFdJOEdkRXZOR0lZZGZrd1A3?=
 =?utf-8?B?S2VwamlyaWkydStyYkhneDZxT2ovd09SZlIyVis4aVQ3ZzhKTWdNT1ZBWUxI?=
 =?utf-8?B?Yys0ZjM0TERTRmJoVmhUZFhSdHRsQVVGUFhkOERFbURmL2Vkc1lZdks2MUNv?=
 =?utf-8?B?YzBSOG4wVDd3b1BiQWJUQWZjQ1V3Nlc2S3RzYzBqckN4ZDZxMFdxUUN2WHBF?=
 =?utf-8?B?dmlhZGNnTVRPQ2t2eGUrb05vczhIOWd2UHRwT0o1amJqT1E5RVVaUkpEOG1T?=
 =?utf-8?B?RTZkSUFhaXVrQ3hrZjNnd0t5RG5LTlZpTEJobWEwWjR1d0x3akFweDBtVGRZ?=
 =?utf-8?B?OWtwYWl5VDVOV1IxeTRQWnVjalo1ZS9DdmQxR3ZUTE9SRSs2aHQ4Uzg0S1pv?=
 =?utf-8?B?OVY3Qy8vZnVuT0g3WU9iOS9yTjFlV2tmRm5Nb3FuZE10Q2dQM0RtOWpCRzB2?=
 =?utf-8?B?UER6RXJUYmVBV3lRaU9uVUdqb2JBeUp3U292cDk4bGxLdlUrWHR6TUF1Tloz?=
 =?utf-8?B?VVJLOTZjTFhHK2NQOFkyeVk5Vmh6U3UxcmE0NTdpUHkvZlJaWFZOMy8xQThI?=
 =?utf-8?B?ZTBiK3ViZkZoMnBtNzJndS9vWnJNcG56WHRWdTc2WVpCZ1luWlRtdTFLbVd3?=
 =?utf-8?B?aUtVNHJPUTFGMlNhSHFRY1V5dmZkQmhKb090TnZzSGt0Y0hvRzNYRmg0RUxU?=
 =?utf-8?B?czl1OGZ6cWx6K3QzZ0NaYkh6STFIVDQvUUt3RVd6OWFWdVZ5TW5aZjUvL1F1?=
 =?utf-8?B?UjlhaW5HUWdJYjBoazlTMVduTS90QTBqelhkRHQveWRBRk10V2lqTWZVVGRm?=
 =?utf-8?B?L3JBUENOTExUNUNlc29tMTNhZmIxYmxBK2c2K0w1V0MzaFVlM2MwcXpmZkE3?=
 =?utf-8?B?QSt0Sk9zWEZNeGNRSk5KK1dDSnV3aTJRWlRPcjVKTm9ISURvYStiaGFJMVZM?=
 =?utf-8?B?Y2NVaXRibm1obTJIbWlzZUxpLzFaeHlXTndFSkIzM3IrUzdKMldMS012Rkkv?=
 =?utf-8?Q?qFIcMi8eCvpZzB3E=3D?=
X-OriginatorOrg: epfl.ch
X-MS-Exchange-CrossTenant-Network-Message-Id: 7f455e0b-d31f-45a1-2986-08de6b05415e
X-MS-Exchange-CrossTenant-AuthSource: ZR1PPF9AC83A6B5.CHEP278.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 13 Feb 2026 13:39:05.0841 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: f6c2556a-c4fb-4ab1-a2c7-9e220df11c43
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 8WKD60qDhJ2/jD5S6WzmheEVxnobbk0qEF4NyWUKpEjVX6vQgZ/n885hFsNj9PZ+TdkpcPVTo10SKQ0Vno2dbe5VDWbY/U007sIBKK1dELI=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: GV0P278MB2025
Received-SPF: pass client-ip=52.101.188.119;
 envelope-from=florian.hofhammer@epfl.ch;
 helo=GVAP278CU002.outbound.protection.outlook.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H2=0.001,
 RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001, RCVD_IN_VALIDITY_SAFE_BLOCKED=0.001,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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

--------------ms090506050604080003090106
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

On 26/01/2026 21:46, Alex Benn=C3=A9e wrote:> Alex Benn=C3=A9e <alex.benn=
ee@linaro.org> writes:
>=20
>> Florian Hofhammer <florian.hofhammer@epfl.ch> writes:
>>
>>> Some registers should be marked as read-only from a plugin API
>>> perspective, as writing to them via qemu_plugin_write_register has no=

>>> effect. This includes the program counter, and we expose this fact to=

>>> the plugins with this patch.
>>>
>>> Signed-off-by: Florian Hofhammer <florian.hofhammer@epfl.ch>
>>> ---
>>>  include/qemu/qemu-plugin.h |  2 ++
>>>  plugins/api.c              | 17 +++++++++++++++++
>>>  2 files changed, 19 insertions(+)
>>>
>>> diff --git a/include/qemu/qemu-plugin.h b/include/qemu/qemu-plugin.h
>>> index f976b62030..1f25fb2b40 100644
>>> --- a/include/qemu/qemu-plugin.h
>>> +++ b/include/qemu/qemu-plugin.h
>>> @@ -942,11 +942,13 @@ struct qemu_plugin_register;
>>>   *          writing value with qemu_plugin_write_register
>>>   * @name: register name
>>>   * @feature: optional feature descriptor, can be NULL
>>> + * @is_readonly: true if the register cannot be written via qemu_plu=
gin_write_register
>>>   */
>>>  typedef struct {
>>>      struct qemu_plugin_register *handle;
>>>      const char *name;
>>>      const char *feature;
>>> +    bool is_readonly;
>>>  } qemu_plugin_reg_descriptor;
>>> =20
>>>  /**
>>> diff --git a/plugins/api.c b/plugins/api.c
>>> index fc19bdb40b..de8c32db50 100644
>>> --- a/plugins/api.c
>>> +++ b/plugins/api.c
>>> @@ -403,6 +403,12 @@ bool qemu_plugin_bool_parse(const char *name, co=
nst char *value, bool *ret)
>>>   * ancillary data the plugin might find useful.
>>>   */
>>> =20
>>> +static const char pc_str[] =3D "pc"; // generic name for program cou=
nter
>>> +static const char eip_str[] =3D "eip"; // x86 specific name for prog=
ram counter
>>> +static const char rip_str[] =3D "rip"; // x86_64 specific name for p=
rogram counter
>>> +static const char pswa_str[] =3D "pswa"; // s390x specific name for =
program counter
>>> +static const char iaoq_str[] =3D "iaoq"; // HP/PA specific name for =
program counter
>>> +static const char rpc_str[] =3D "rpc"; // microblaze specific name f=
or
>>> program counter
>>
>> It's ugly but I can't think of anything better as you say in the commi=
t message.
>>
>>>  static GArray *create_register_handles(GArray *gdbstub_regs)
>>>  {
>>>      GArray *find_data =3D g_array_new(true, true,
>>> @@ -417,9 +423,20 @@ static GArray *create_register_handles(GArray *g=
dbstub_regs)
>>>              continue;
>>>          }
>>> =20
>>> +        gint plugin_ro_bit =3D 0;
>>>          /* Create a record for the plugin */
>>>          desc.handle =3D GINT_TO_POINTER(grd->gdb_reg + 1);
>>>          desc.name =3D g_intern_string(grd->name);
>>
>> Lets just set desc.is_readonly to false here.
>>
>>> +        if (!strcmp(desc.name, pc_str)
>>> +            || !strcmp(desc.name, eip_str)
>>> +            || !strcmp(desc.name, rip_str)
>>> +            || !strcmp(desc.name, pswa_str)
>>> +            || !strcmp(desc.name, iaoq_str)
>>> +            || !strcmp(desc.name, rpc_str)
>>> +           ) {
>>> +            plugin_ro_bit =3D 1;
>>> +        }
>>> +        desc.is_readonly =3D plugin_ro_bit =3D=3D 1 ? true : false;
>>
>> And fold setting it to true into the if statement. I have a marginal
>> preference for g_strcmp0(desc.name, eip_str) =3D=3D 0 style tests.
>=20
> The option of course would be to skip the register all together. Do we
> have code which will have multiple vaddr's for the same TB where using
> the TB data wouldn't be sufficient?

Skipping the register altogether would basically make it invisible to
plugins and therefore remove functionality. A plugin might want to get a
list of all registers (which would not be complete anymore), or get the
current PC value. If I didn't miss anything, the latter might not
necessarily be possible anymore, as a callback (especially the simple
callback type) doesn't have access to the current TB data and can't
necessarily pass userdata to the callback, so it wouldn't be able to get
the PC from there anymore.

>>
>>>          desc.feature =3D g_intern_string(grd->feature_name);
>>>          g_array_append_val(find_data, desc);
>>>      }
>>
>> Otherwise:
>>
>> Reviewed-by: Alex Benn=C3=A9e <alex.bennee@linaro.org>

--------------ms090506050604080003090106
Content-Type: application/pkcs7-signature; name="smime.p7s"
Content-Transfer-Encoding: base64
Content-Disposition: attachment; filename="smime.p7s"
Content-Description: S/MIME Cryptographic Signature

MIAGCSqGSIb3DQEHAqCAMIACAQExDzANBglghkgBZQMEAgEFADCABgkqhkiG9w0BBwEAAKCC
DD0wggWvMIIEl6ADAgECAhANkOKMSmGXhF5eMl0rsRhvMA0GCSqGSIb3DQEBDAUAMGUxCzAJ
BgNVBAYTAlVTMRUwEwYDVQQKEwxEaWdpQ2VydCBJbmMxGTAXBgNVBAsTEHd3dy5kaWdpY2Vy
dC5jb20xJDAiBgNVBAMTG0RpZ2lDZXJ0IEFzc3VyZWQgSUQgUm9vdCBHMjAeFw0yNDAzMTMw
MDAwMDBaFw0zNDAzMTIyMzU5NTlaMGIxCzAJBgNVBAYTAlVTMRcwFQYDVQQKEw5EaWdpQ2Vy
dCwgSW5jLjE6MDgGA1UEAxMxRGlnaUNlcnQgQXNzdXJlZCBHMiBTTUlNRSBSU0E0MDk2IFNI
QTM4NCAyMDI0IENBMTCCAiIwDQYJKoZIhvcNAQEBBQADggIPADCCAgoCggIBAOfSIeC0vv1x
PQ+dgSxbIIrkaru6skAWJYaGFzmvq4Kq+2wU2jxhcWlJg/JeP5jEkq/LM3pn5aaLao79j+XR
mS7J1ZpJKUODJVoM4s9MQJhTMvo4qS5ZS64g6QR7Obkz3I1Lr3aWeSBmDDEyzue+NKtuWZ1C
xy3RdXo/w5HgRc3l2AercOM3Gt1XonTzEtTbZ/Hwc0Sn9Gz8RmGRK6Ka4hVDl8q/2l110KaV
233Kh5etP0csXS8MIMdVRfRu3sc5hp13DG7lCKzK72a2GEpI8Wpl26G6I1/LMzz/98T+FqjT
qxsdquk7Cj7m2vKGLW1BorpQH7WFGPdJQXJe1hfbfiZACcVdCtl4nAacFacmsiArZBfX7AQG
L7isvHUwwYFEtcApyGW4p2Lt+t8nvU0CANA6BHOpOz1xOP8WmAESbUriIjyuTUf3fJ9oDNCu
rVqhASMJCDaWI3lYX/QAoiAzt6akqbbZxo2ujW7mGGqc0KxqE2csh2T79v7pC8aUtHBfwNrT
R19GnZVxE0eQ7ViIQhR6mpSaUQFA9sG+cmD2G8TnCgYsLa0q8De6F61aCBevQGHNzrbZ3JAM
neveYg/Jy1XxQHDRcvrMfWKe0jjcWbdKYlaGVPm5V1ILwYz7Yv5ewo3NUrxIGJiywe9qPhuJ
SDZs7VehTuI0FxGIsgKzVjgbAgMBAAGjggFcMIIBWDASBgNVHRMBAf8ECDAGAQH/AgEAMB0G
A1UdDgQWBBT3m6JO05fF9DQPQw6Bhc6RkzKv+TAfBgNVHSMEGDAWgBTOw0q5mVXyuNtgv6l+
vVa1lzan1jAOBgNVHQ8BAf8EBAMCAYYwHQYDVR0lBBYwFAYIKwYBBQUHAwQGCCsGAQUFBwMC
MHkGCCsGAQUFBwEBBG0wazAkBggrBgEFBQcwAYYYaHR0cDovL29jc3AuZGlnaWNlcnQuY29t
MEMGCCsGAQUFBzAChjdodHRwOi8vY2FjZXJ0cy5kaWdpY2VydC5jb20vRGlnaUNlcnRBc3N1
cmVkSURSb290RzIuY3J0MEUGA1UdHwQ+MDwwOqA4oDaGNGh0dHA6Ly9jcmwzLmRpZ2ljZXJ0
LmNvbS9EaWdpQ2VydEFzc3VyZWRJRFJvb3RHMi5jcmwwEQYDVR0gBAowCDAGBgRVHSAAMA0G
CSqGSIb3DQEBDAUAA4IBAQA+b8Uw53sDspdZgukU+qzLyyHkcjlxGGhHlP+zrmDLKm1wEFvC
RS2pili3Hy67i8N4N5NUvw5Rg6kv3lxb9S9Rktxk43k+tvm68pl7OxQE55ZjVY87P0lUPGwE
qOOwLLyH02ZQcsfq5p5LrOH90JvmvZ1yy73HS+VpDAqOlytE0NSvTIRqFFkKQGQwfjvtql9Y
flujuNNvJztjBaHKYZsnNSg+J38ojYq4TP3pSg3UdVH0PncVjPQyqxC9xef5Xae92Kbkzol3
x7Nel3A1bwAkalrDMspvTHvey6LfiBksFIqviTnoy7fgjaRAJgHS+RXx/cmuRd3rUAclSVVr
Yu8RMIIGhjCCBG6gAwIBAgIQAggtinx6OJLKM4FVztNyWTANBgkqhkiG9w0BAQsFADBiMQsw
CQYDVQQGEwJVUzEXMBUGA1UEChMORGlnaUNlcnQsIEluYy4xOjA4BgNVBAMTMURpZ2lDZXJ0
IEFzc3VyZWQgRzIgU01JTUUgUlNBNDA5NiBTSEEzODQgMjAyNCBDQTEwHhcNMjUwNTI4MDAw
MDAwWhcNMjgwNTMwMjM1OTU5WjCBrDEOMAwGA1UEYRMFR09WQ0gxCzAJBgNVBAYTAkNIMREw
DwYDVQQHEwhMYXVzYW5uZTE0MDIGA1UECgwrw4ljb2xlIHBvbHl0ZWNobmlxdWUgZsOpZMOp
cmFsZSBkZSBMYXVzYW5uZTEaMBgGA1UEAxMRRmxvcmlhbiBIb2ZoYW1tZXIxKDAmBgkqhkiG
9w0BCQEWGWZsb3JpYW4uaG9maGFtbWVyQGVwZmwuY2gwggEiMA0GCSqGSIb3DQEBAQUAA4IB
DwAwggEKAoIBAQDZkbG07NgfFKDNM3VI4qQdU1fVIGUQnN6BO2zeqoUdytNIzxOX6n7HxM+o
CLa01AnxaL59DXwFTXIg0OVq5ETAoLshUwnkYeWhKZH4Ysoq74QGVFihjrrs41d+8o+ymG2F
cZBMzQ/RO4KzFhmlaZ/E+1d2F7/O3x8LohaFxxBsN0+qonMreRQGx+ialMmbARFJkVuinuB4
3hZ8eRVmXy8A4R8ywakunaCNm15+eIQtptCs3IH5UqPEEOn16ANekWr7z5mZJh3ApxreflA/
iwJKWd/Ljga90TJXjTFc7sNA0RgA78Edqw7BE+D2VUcPMshdhKYNB1BVHZS81anGL7RFAgMB
AAGjggHrMIIB5zAfBgNVHSMEGDAWgBT3m6JO05fF9DQPQw6Bhc6RkzKv+TAdBgNVHQ4EFgQU
ogXJJmzPazWg0eBlf1DbolocD3gwJAYDVR0RBB0wG4EZZmxvcmlhbi5ob2ZoYW1tZXJAZXBm
bC5jaDAUBgNVHSAEDTALMAkGB2eBDAEFAwEwDgYDVR0PAQH/BAQDAgWgMB0GA1UdJQQWMBQG
CCsGAQUFBwMCBggrBgEFBQcDBDCBqQYDVR0fBIGhMIGeME2gS6BJhkdodHRwOi8vY3JsMy5k
aWdpY2VydC5jb20vRGlnaUNlcnRBc3N1cmVkRzJTTUlNRVJTQTQwOTZTSEEzODQyMDI0Q0Ex
LmNybDBNoEugSYZHaHR0cDovL2NybDQuZGlnaWNlcnQuY29tL0RpZ2lDZXJ0QXNzdXJlZEcy
U01JTUVSU0E0MDk2U0hBMzg0MjAyNENBMS5jcmwwgY0GCCsGAQUFBwEBBIGAMH4wJAYIKwYB
BQUHMAGGGGh0dHA6Ly9vY3NwLmRpZ2ljZXJ0LmNvbTBWBggrBgEFBQcwAoZKaHR0cDovL2Nh
Y2VydHMuZGlnaWNlcnQuY29tL0RpZ2lDZXJ0QXNzdXJlZEcyU01JTUVSU0E0MDk2U0hBMzg0
MjAyNENBMS5jcnQwDQYJKoZIhvcNAQELBQADggIBAD3Ne2mHg2ctxRIflrx/T2yBDnQunFhe
SRwBnFIaOvCG05KE9iit2I2sazC5xqdp292spCoP9Qa4MOJg22BFmTnN9XnOjcEv9KFPSMaA
ITLu8CXyewPb0xLET8WqdEe5AravlneZ9/H0ve9Ufhk3wbJPKK5yijcKYmEYH21JBtZ1pnjs
fVEXAETdKkp9LC5sVeYeFk67BbUTPrFl37pha3TynPwJAiXDJFR2uI2JVGESQFyWkeO/bY5T
DCf6VIp3d1p++XoOTVseFE8OqaHZYGN+DgSK4ejT19c/GgjQqoWVK+xSvHEEsoLfOADKcYFN
M0ptGrFYpdRWJO0CKukBUAk8fpriJ/OjhSVQltCpN3pK1DPXnPrXTROXGacb3PNSUyeDlP2/
y0FqpEY7GjwMZMdu+U/rHhMGbDmv/ZBLGwiGzQVmld5je+d8nvZTamE1iBA8Nhmuz6wg6yN1
qx9b7Jn/9yQebxvHddnvz6jw6FDnw2bhq7z88eH3mYZYZ48Fhr8J87horGotEDKTDNHkF1Oe
FSxhIx0a7yoe1I66R5tapkRlNgI5EX53e/npP4ruND5bQFWDI7JGkKrLlAjQR/dNahXXX/Ry
rCfngiHZcAQakPkQrlrZCxMhlIKvDMunATaICyjnHizEC+1qzJsdvJgSC8sOzLxiEjlx3MRe
CswFMYIEezCCBHcCAQEwdjBiMQswCQYDVQQGEwJVUzEXMBUGA1UEChMORGlnaUNlcnQsIElu
Yy4xOjA4BgNVBAMTMURpZ2lDZXJ0IEFzc3VyZWQgRzIgU01JTUUgUlNBNDA5NiBTSEEzODQg
MjAyNCBDQTECEAIILYp8ejiSyjOBVc7TclkwDQYJYIZIAWUDBAIBBQCgggLWMBgGCSqGSIb3
DQEJAzELBgkqhkiG9w0BBwEwHAYJKoZIhvcNAQkFMQ8XDTI2MDIxMzEzMzgyM1owLwYJKoZI
hvcNAQkEMSIEIBDK9b6NjPfyW5/zqNyL+taDxtXxxZ/X38Nx26N5+LQIMIGFBgkrBgEEAYI3
EAQxeDB2MGIxCzAJBgNVBAYTAlVTMRcwFQYDVQQKEw5EaWdpQ2VydCwgSW5jLjE6MDgGA1UE
AxMxRGlnaUNlcnQgQXNzdXJlZCBHMiBTTUlNRSBSU0E0MDk2IFNIQTM4NCAyMDI0IENBMQIQ
Aggtinx6OJLKM4FVztNyWTCBhwYLKoZIhvcNAQkQAgsxeKB2MGIxCzAJBgNVBAYTAlVTMRcw
FQYDVQQKEw5EaWdpQ2VydCwgSW5jLjE6MDgGA1UEAxMxRGlnaUNlcnQgQXNzdXJlZCBHMiBT
TUlNRSBSU0E0MDk2IFNIQTM4NCAyMDI0IENBMQIQAggtinx6OJLKM4FVztNyWTCCAVcGCSqG
SIb3DQEJDzGCAUgwggFEMAsGCWCGSAFlAwQBKjALBglghkgBZQMEAQIwCgYIKoZIhvcNAwcw
DQYIKoZIhvcNAwICAQUwDQYIKoZIhvcNAwICAQUwBwYFKw4DAgcwDQYIKoZIhvcNAwICAQUw
BwYFKw4DAhowCwYJYIZIAWUDBAIBMAsGCWCGSAFlAwQCAjALBglghkgBZQMEAgMwCwYJYIZI
AWUDBAIEMAsGCWCGSAFlAwQCBzALBglghkgBZQMEAggwCwYJYIZIAWUDBAIJMAsGCWCGSAFl
AwQCCjALBgkqhkiG9w0BAQEwCwYJK4EFEIZIPwACMAgGBiuBBAELADAIBgYrgQQBCwEwCAYG
K4EEAQsCMAgGBiuBBAELAzALBgkrgQUQhkg/AAMwCAYGK4EEAQ4AMAgGBiuBBAEOATAIBgYr
gQQBDgIwCAYGK4EEAQ4DMA0GCSqGSIb3DQEBAQUABIIBAIFPkHjwfbGoF0zBe8RHRDOXWCzr
q6awvDsAEBZ4bt06Gw4QQbPF9N4ycRtFSRae2CR1gwT9B88YiGvaSRomRHFEeGex76kSXgL6
dWRIbO8Xfd0rhVZlcZ25+de9bcnFbapQMpm/vlqGcWr1TCtRNEocUl5D3iEWUNFYIKfZ8bWQ
hvQu5XIkH7sRNNa+I8BTOCIwbD8YDuLy0BEX8mLJqlgd84cyaBK/jc0Knz7GgO74okxb3D83
M6MCmVopCzznYH+q3ZS7Dgf8xgULbcpdLg9ybJftWODAB8j4cfBUhBEF8syBXK2vD8wDxF1F
qA5SpkekIEvp9Wrb8bd5QkAtWPUAAAAAAAA=

--------------ms090506050604080003090106--

