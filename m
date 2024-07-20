Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2444BC3DA59
	for <qemu-devel@archiver.kernel.org>; Sat, 20 Jul 2024 21:28:48 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sVHcu-0004HD-EK; Sat, 20 Jul 2024 17:28:24 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <steven.sistare@oracle.com>)
 id 1sVHcs-0004G1-CN
 for qemu-devel@nongnu.org; Sat, 20 Jul 2024 17:28:22 -0400
Received: from mx0a-00069f02.pphosted.com ([205.220.165.32])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <steven.sistare@oracle.com>)
 id 1sVHcq-0008Qj-PY
 for qemu-devel@nongnu.org; Sat, 20 Jul 2024 17:28:22 -0400
Received: from pps.filterd (m0246629.ppops.net [127.0.0.1])
 by mx0b-00069f02.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 46KLGWFR002129;
 Sat, 20 Jul 2024 21:28:16 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=
 message-id:date:subject:to:cc:references:from:in-reply-to
 :content-type:content-transfer-encoding:mime-version; s=
 corp-2023-11-20; bh=Mu+wI5vJjgwz0DIzZHhL1IhFiY6sbapqnY8WoDCL7VI=; b=
 mjaPYA5FAsAojHeGDmXMfexrxxDWc0Mc0d7k9H/f1iYpCgptd2U7r8Uw5td2TlwY
 UY9J4V8JL5zMzG+sVO/CJxfkFM5DOo6wqcOo34FugVZ38yr/kuNLuVPCRh50PcN2
 tzL4SGI8H9mqisC8qn8rugqoMbswbn/vYw5VEjpXEuluEn/j+9hTK/uxTfqqCTAE
 ABD1wtdqHKRM74PGmSHMZs7th3X4pN+nqTasCykPExnPt92MQ9ViFJA6UY8N9UCJ
 I7gXgJjbKs0qNJRefafPFsRP3GVIN5mmHEfwdPtETjqtPegb8JH8EHrGfv+wPi+A
 AhOKEBPHJzhVq3JK92OEVw==
Received: from iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com
 (iadpaimrmta03.appoci.oracle.com [130.35.103.27])
 by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 40gn06g07x-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Sat, 20 Jul 2024 21:28:16 +0000 (GMT)
Received: from pps.filterd
 (iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
 by iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (8.17.1.19/8.17.1.19)
 with ESMTP id 46KI0QRC027478; Sat, 20 Jul 2024 21:28:15 GMT
Received: from nam02-dm3-obe.outbound.protection.outlook.com
 (mail-dm3nam02lp2041.outbound.protection.outlook.com [104.47.56.41])
 by iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTPS id
 40g3p5rcr3-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Sat, 20 Jul 2024 21:28:15 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=pmWyKkB6ViVJWPin0U5Z7k1IRdDS8S9LdpE7O3NNCjQHOo1MwFCLpdqgFOh6psm9UWSPN+U4R+pE3ilZ2O5enhaH2tvGb108YU44EHvlLqXC4bWv5pGtpnh6ajL2eY+Bfs9RMwhOYM7NO08mz3YMWTdIbjcD6HnA6o97QkHaYWxBB9EAuy/GRtGGNqsH4CQ3ljQfd9R44wskSg5lXWQmhnabVArLhReiVsK35eFL0LCcE1RcgmYuF4DQUYp3Wb+eL6Xzr+7RPSyKNnRU8dlGnIIcUmdCYKD0jJiuenyYupV+wSj0jK5iZ6LHhl0NHIHGMYjKxHKQxTmwVV3PoJIpsA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Mu+wI5vJjgwz0DIzZHhL1IhFiY6sbapqnY8WoDCL7VI=;
 b=f6v5LPYUMGiflE9iGEEGXJ+hRm5eSVR/DDSLQaQqDpuRPIr7hbpwPOmmhSR8tARDdPS3HxRMBvgjRa0OstEB8JtoF96M0lFeuw+64dsPv+FQXd52ZI/yfQ0pggtsRlxfIcpkv/6ARHIr5EjTMLfApIv33dUoVCstEvH8oCov8kuL7IFKuiD/4BrI0VfQ7uC/6MVtMvvCUFNGjM6BDRkjgWBmYTCpU6ohrCNvWNUR3BpeX055/9fHQZuYtNAwGI5aC4t3Dr5OG8EDvo6b0G57I+QYhJyhccCmRfeZxijX52Hlnl74l9ghpmwlhha4o8bH4BKdTAKXszh1SJVgAVrBrg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Mu+wI5vJjgwz0DIzZHhL1IhFiY6sbapqnY8WoDCL7VI=;
 b=xqyNdXbVg2kYXpUDIdUG/8DI1CfzrIM8q3tO5shGwGosWBKlUiatmvhUzNIRB6rjethyEXS1aGX3RXfnH4l+L48dCiFhpKoOjxEhbuH5og0MxB76seoI85KL41jUjODjNaDj/xAWqcCfQyRpMBPR5LISvqeLyLO+zEjsIZm3d/I=
Received: from IA1PR10MB7447.namprd10.prod.outlook.com (2603:10b6:208:44c::10)
 by DM3PR10MB7946.namprd10.prod.outlook.com (2603:10b6:0:4b::7) with
 Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.7784.17; Sat, 20 Jul 2024 21:28:13 +0000
Received: from IA1PR10MB7447.namprd10.prod.outlook.com
 ([fe80::f2fe:d6c6:70c4:4572]) by IA1PR10MB7447.namprd10.prod.outlook.com
 ([fe80::f2fe:d6c6:70c4:4572%6]) with mapi id 15.20.7784.016; Sat, 20 Jul 2024
 21:28:12 +0000
Message-ID: <dc452d41-82e0-4457-a86b-bfcd15e3ddc6@oracle.com>
Date: Sat, 20 Jul 2024 17:28:07 -0400
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH V2 06/11] migration: fix mismatched GPAs during cpr
To: Peter Xu <peterx@redhat.com>
Cc: qemu-devel@nongnu.org, Fabiano Rosas <farosas@suse.de>,
 David Hildenbrand <david@redhat.com>,
 Marcel Apfelbaum <marcel.apfelbaum@gmail.com>,
 Eduardo Habkost <eduardo@habkost.net>,
 Philippe Mathieu-Daude <philmd@linaro.org>,
 Paolo Bonzini <pbonzini@redhat.com>, "Daniel P. Berrange"
 <berrange@redhat.com>, Markus Armbruster <armbru@redhat.com>
References: <1719776434-435013-1-git-send-email-steven.sistare@oracle.com>
 <1719776434-435013-7-git-send-email-steven.sistare@oracle.com>
 <ZpqUGYclrONQEuc7@x1n>
Content-Language: en-US
From: Steven Sistare <steven.sistare@oracle.com>
Organization: Oracle Corporation
In-Reply-To: <ZpqUGYclrONQEuc7@x1n>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: LO2P265CA0107.GBRP265.PROD.OUTLOOK.COM
 (2603:10a6:600:c::23) To IA1PR10MB7447.namprd10.prod.outlook.com
 (2603:10b6:208:44c::10)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: IA1PR10MB7447:EE_|DM3PR10MB7946:EE_
X-MS-Office365-Filtering-Correlation-Id: 94ca5e28-3b37-48ef-5807-08dca902dc1c
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|366016|1800799024|7416014|376014;
X-Microsoft-Antispam-Message-Info: =?utf-8?B?aEhXNENkV0QwVEcxREdxRFJXN2taR09CbXVOYVNxWkZhOXJqTytqcHdUNFBw?=
 =?utf-8?B?U2wrOFZTQkNuWUZweUZLSEQwT2hlOE0vcm1Cbk0zTmliTURYa0lIbTBmOGhJ?=
 =?utf-8?B?TmtPMWduSGUxbWhibjZVeXpxemFNSTl2azUwRlZMUUJNVGRZUm5qTkhiYThC?=
 =?utf-8?B?ZFVUOWJYNGtVSkt3emwrQ0ZabTdFck5jcjZZYlRpekJRaUMwUWRwS1VERTcx?=
 =?utf-8?B?MmZLeFo5RGZtSGRxbCtaNFI1MXFXczY5cWtsNmZsczNDOUNZOURnOEhja0g0?=
 =?utf-8?B?ZWV3M29Vci9KSXptNFdmN3NTSWd1VSs0YnhXNGlhNHRYcGZ1a1BOckg0Ty9C?=
 =?utf-8?B?NDZ2VnROVlJoelVSZXVEeEtUNVpKWEZXUjhKOWtjS2tpd0ZzMlY4aFFDNENk?=
 =?utf-8?B?bzdGbDNjcm1lQVowK0hrWWRsendHeU9nNTgvVGhSTjdTRGlJUWJzYjdpNjlV?=
 =?utf-8?B?UEZmbytIc0Z6TmtUdmJMK0o0d1g5OVFMc21IRmxnNW9rUUFwaENSQ29zcmdH?=
 =?utf-8?B?dVRFOWxZbjlxZzF3R3FDVWFrYTkrVDJ0c0tZdkRwaEcwTkpTdzF3TG5Pb1Bn?=
 =?utf-8?B?UVd6ZXo1aGMwYTZZaC85OU90TGgwTmRMVXFvakRVdEhhY1BiZ29DVmZmRGcw?=
 =?utf-8?B?dHNoeHZuenJuZ3pFdytTc2laSGVCQU9WOHZva0VuUzV1dG51MjZDNHdMOFE5?=
 =?utf-8?B?Tld4L2J5czVNUENTRnppOEl6UXU2dVpVbjFJOGd5OGl1RTI2UEt2dklZMG8r?=
 =?utf-8?B?NVhSMUgydXJMdXhweElyTjJYZEdnZXlOd011VDlPbThpSVhXUGU2Ym10QUhJ?=
 =?utf-8?B?NDBEbDYzOFpzSnA0S0o4cEhRR01MM256NFgyMHU5ekQ4ZzhmZm5nUmY1Umg5?=
 =?utf-8?B?QXA0cFRMbElLb2owYTdsQnphMUw2T3BUSHpVdjkvWnJwMmF2K0ZYRXN5ZlVS?=
 =?utf-8?B?Nzd2cGZpVFdnOVJOQVNsQzE4RzBzRjdkcUtTdW1GVnVKSnV4N2FvdVpPT25L?=
 =?utf-8?B?d3NSeVFwQWlrMTVEWE1xNmRvT3ZLNWVhYVVzMFIwOVNOUEoyTjU4dXFSbGV3?=
 =?utf-8?B?YWlvMHB1eDVGWHlQclJHSHRJMGtvUmNZM0xxNGtobE5zTmNMK29qcHYvUTBL?=
 =?utf-8?B?a25rblBvblN2UFJmRXlvYXlqVVRZTVZndlFhV1pNM1BoazBBSGtUU294cE9L?=
 =?utf-8?B?SlRIK3V6WVRGdXlITHVsSFZJYXdIZGlUNm9OcXJTOGJMMEFyYXBJZXliQm10?=
 =?utf-8?B?U1p6ekRzTmp1YTJiNHhtTDBuNjVsMmJGSkV6UmZ5L0xTaEwrUHVucG1TeDRZ?=
 =?utf-8?B?cXIxbktPWXJyY0cyYWY2L3J2QWFBYy94dktIUG5tMWtWQlFTSHdLWXUwY0Q2?=
 =?utf-8?B?cENBSUlibjd0czc4MnRzb0dVNENuT1U2NkcycFh4UkNzVTFwYjRtd0NBZG1Z?=
 =?utf-8?B?QXdQNmE3a2lFVnMzREthc2RLMnJSYldQdHQ5U1pnR29ieHdPd1B4TVFxdGJP?=
 =?utf-8?B?M1JQYTFQU0Zrdy9ON3NMMS8yZWZJbEwyQVRuUHBqOGltOUI5SzRVQ2lKWE5M?=
 =?utf-8?B?ckxxd2w0WWlIaFpDVDROT2pCMVZYSldlWmkrSndCMmcxMmJjbStuZGhSSnRk?=
 =?utf-8?B?NXl5YU1EVW44Q0hhbWtaZHFsQmRLNzVPaTBVREwrU1R6Q2ExNVU2M00wOFdi?=
 =?utf-8?B?YnU1Zk1KeDlxSkhGNlpoWldFMDZ4TURLWXZkcTJDTndhK09CaUNKeVhSNEh0?=
 =?utf-8?B?bWEzUGt6WG9COHFHRUN4NS9YZ3V3VXh3VUFBbWxyUnRaTDZVVVRKTGtsWEZV?=
 =?utf-8?B?bGhRTXBkMDFqRDAxWjh6dz09?=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:IA1PR10MB7447.namprd10.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(366016)(1800799024)(7416014)(376014); DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?YmJQNk44WWVMQk41NTZhYjVMeHRjT0w1WkQwMk5NcE9uVDNtVWdhaUdDRFhj?=
 =?utf-8?B?WWIvWWFHcXRVdktsdEs1YmE0WGU1TTZNcVdwTDUxL2RsS09GcStHbXpGTHNL?=
 =?utf-8?B?dlR5b3c4TmJKc2tpdmtZbWx3aURTdjRtbzFibjBrQnlIMDg0RExpYUIxRC9y?=
 =?utf-8?B?YmE1SXR0T3dTTXhhYUR3Z1djOW1nQ0g5WW0zZTE3Q1lPYkNrYlpGcEs0NkNS?=
 =?utf-8?B?N205MEo3WWJoWnEyVldoei9wdkNKTGlCbnMrVFFYM09NNVFiQ042dXpPSTVV?=
 =?utf-8?B?aE5kbDQxYk1mcW5Ja0pIOHRMdkF2Y0dqVEsvN3UvdjFvUXA0QWxqT2NsN0Rj?=
 =?utf-8?B?aFkrNS81d1JlWU53Y2lSRGVGNUJ2VTVOb1h3UGFmb1MzRWN4MjBtMzZlRzI0?=
 =?utf-8?B?WThaN3RXQXcrYUliMHZGbUVlc1R6RG5wKzlVdjdHS3JON2ZCdEI3OVJseklo?=
 =?utf-8?B?OFFFYThIWjlvWE5NQmxUYS82eENMOHZvekN4RDhrN3FjQklqT3QzRThTMXJ0?=
 =?utf-8?B?bXJ2eitXQ0kvbkJSRllqQkdIdm9hbVNwalZIekl1bWVXNWZtTU5zREZmYzEv?=
 =?utf-8?B?Z0tpK3lYaVZ0RkxmWjEyUzU4M2NTdzBKcVozek1rMVBpZ2p0OTlhNlk4Wjc3?=
 =?utf-8?B?RmVxU1lBeG9GOUpaV0JpcnRlNFFtM3Exa2NpNUE3Z1RzK2ZPVHBRRkVOZFgx?=
 =?utf-8?B?U0tHSkdzOUd3RksyZ0ovU1N0RGFKOEVCNURSbmxWQW1tNll0dnBaanIwUk8x?=
 =?utf-8?B?bUFHaFFESTh5UEVaejdoS1I3QlJubVhXUlI0ZnNuaWZrWVo1TDJ3MWQvZnpB?=
 =?utf-8?B?bWdOUFZ3eGtJbTh2emFsWHplSFY4THd5OWttMVFkOVI3OENEYlgwSzV3ZWlx?=
 =?utf-8?B?WWdoR2c3NTJmMHZhczJtZUpodVl6K1ZERytkRkhtQk5KRXVEYS8vZ1VzTlp5?=
 =?utf-8?B?eTFqNi9kMG1MZURSejdXckYxa0lvMU11ZkVuNm9CSVNHUERQU2EwcXJNWmpQ?=
 =?utf-8?B?SzFZc25NRlpNOWRFem9NeUt0bVJ1b3Q2aDZ0QzdlVElNRm9xWHBDTzZ6TFRB?=
 =?utf-8?B?NVFkNU5OYzJNYjhEblB3OVh6ZFpRVW1uQzNtVFRpNnBCdFU2WnNOaTJoZStT?=
 =?utf-8?B?NlVtVDh4ZklBaytka0lFbDIzWnJmU00vOHhDWXVPc2k3d3V3czl1WjJMeEx1?=
 =?utf-8?B?ZThHN2FGV0l5Vm12QUZXaWpJYVBzUEtSNTAwbDUvYStFcVlGRURONXNsR2Rl?=
 =?utf-8?B?OUtPcFkvSHk5cktDY2l2Qk5OVEVzSWN4c3prNlhPSjVpTzVyblFhVk03RmRP?=
 =?utf-8?B?ZzB2Vk5wcDlQeHl0NXVFVnc0MytvWW9rS1lXY1ZVZE0wSFVYTnF5Tm12Zk5s?=
 =?utf-8?B?OUR1MkFhcno3NWZOR2YvQm52M0ZUVnlFWGRWNUlKam9GSjNLMjVoa3gyd0Ja?=
 =?utf-8?B?RDRWbnJ6MGxmUWxmaldHVjFHc3hMQzNBczRoOUJzeFVCNStZcUVMbHZqY3FV?=
 =?utf-8?B?cTZpd0E1LzlISWwybXlqaFlsSkZQNHhrTTVMSDBlM2l6MmpaajNRVDZET1Mv?=
 =?utf-8?B?emE0d2lvcHl4YXFjZUdEMzAvZCtkL3hFeUllK2J3YnFjNDJtVFY3ZmZ5eHR6?=
 =?utf-8?B?bERsS2Y2b0xRNk13SFBhSkhkb2NZMHlYa3A3QjlzakxBU1JvL2EyZmpxUDRG?=
 =?utf-8?B?OUN2cnFLUjJQRDNhTU13ZlJzWnZGblROcWR6S0ZnRHloSnlrd3pwckdlZ0g3?=
 =?utf-8?B?TkltQko4MW04eXFWRlQxZUhtNWpXS3piWllVZ0lhbW5ncjh2VldZa0MzK1di?=
 =?utf-8?B?WkR3SklsK05nU1pUNTlSMi9HUHVRWUNlMUM2azEyUjhOeXlEWHhoOVNSakhO?=
 =?utf-8?B?c1VXQUU0MDkxV0RsSUllSTNRVFY2ZmsxOG5qN3M2Rmw1TXdYaXFiOTZ6V3lz?=
 =?utf-8?B?WmtlM3VScVdiZytyVkJIUk9XMUVMUmY3d0F4RzNSNFo3R24wR25mVW1HMTdG?=
 =?utf-8?B?MVVXblAwTGtqbWRxcThLK3JTbnVpdXBwMm1JQ1RKSWhuMnVwMkpGTnNvWHov?=
 =?utf-8?B?R2lITWhoZEF0VUJVQlhnaWRJTGl6YmtCZ2p3cU9pdGZ6c2pZaVpaZ0RlSlJZ?=
 =?utf-8?B?SjE3UHJUTjhNRUpJSitnRStLWGNSVHFpYWdIZlh2K3l2NEtjY29xcjV5b2Zy?=
 =?utf-8?B?QlE9PQ==?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: 21OJ8Kw08Xiz+wSfrispoC5uMuokEd93CJ89rLJCJLeET+Pin7O3XKbSyAit0/YY7ZiLnZ+OmaY+RdHXEH2L8FWHlaILqFCZ87ztf51XZnLAymyu7Q7mK7zS+OH7PmbASRxyhMvuOQswCZ4Vj9KegWWgY55EhW31bue54yL8VDiHDcznP0inmmEwiGLsg9m5nUxSLnjMrB+iXl+0Zd27+NPb41iZBhTXCexRB7t+qOLxI4xdL0Eh4HUeZQw3aE8quWPfL40OZkqqjFxVFN4YJQCX/EAX3VkrtZMekt4OJcNmMrYzNmskfjRJs8b8yN01IlrCofnmmVmfcquqmaFPE5HCXA90NUFkIEYx/ZBzNrDgmfL3TH46J5pI5ov9E1AmKSmpKAS8SxtUGKDoWZIlmZ/X2J0rehl6ZCMqji+FG44G7TnBB7WBbBrRkd4Y4muyyzKa6m98N59kXKpnuOPhnFcBe0hIID6RBirWc09x7OBsgxoNhFhuE1fRuKn2dMgVOOu6SjbIsAM7inYBAaqLG1kR/G6TXzVB7CIDj6kFtOVse44C/jnDnrlSpv9dVF7aiJLheZIZ3w2n/uDHW07S2Zl8XvFDdhg1FCx5nBigUsE=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 94ca5e28-3b37-48ef-5807-08dca902dc1c
X-MS-Exchange-CrossTenant-AuthSource: IA1PR10MB7447.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 20 Jul 2024 21:28:12.9216 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: lgln1FgwLWG9vGhPRCLvsW97EASVevLuK6VzUHDmVzguuOHw5ZgE8AqGplMOWDlY70yROQP/pulvVmy5zBPZfqWjQr8Oq6jcK6y4uav0ELw=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM3PR10MB7946
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1039,Hydra:6.0.680,FMLib:17.12.28.16
 definitions=2024-07-20_19,2024-07-18_01,2024-05-17_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 mlxscore=0
 bulkscore=0 phishscore=0
 suspectscore=0 adultscore=0 malwarescore=0 spamscore=0 mlxlogscore=999
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2407110000
 definitions=main-2407200157
X-Proofpoint-GUID: 6pbHsUFVwa3c5Q2mHd0zCg091Q7Pcr_Y
X-Proofpoint-ORIG-GUID: 6pbHsUFVwa3c5Q2mHd0zCg091Q7Pcr_Y
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

On 7/19/2024 12:28 PM, Peter Xu wrote:
> On Sun, Jun 30, 2024 at 12:40:29PM -0700, Steve Sistare wrote:
>> For new cpr modes, ramblock_is_ignored will always be true, because the
>> memory is preserved in place rather than copied.  However, for an ignored
>> block, parse_ramblock currently requires that the received address of the
>> block must match the address of the statically initialized region on the
>> target.  This fails for a PCI rom block, because the memory region address
>> is set when the guest writes to a BAR on the source, which does not occur
>> on the target, causing a "Mismatched GPAs" error during cpr migration.
> 
> Is this a common fix with/without cpr mode?

It does not occur during normal migration.

> It looks to me mr->addr (for these ROMs) should only be set in PCI config
> region updates as you mentioned.  But then I didn't figure out when they're
> updated on dest in live migration: the ramblock info was sent at the
> beginning of migration, so it doesn't even have PCI config space migrated;
> I thought the real mr->addr should be in there.
> 
> I also failed to understand yet on why the mr->addr check needs to be done
> by ignore-shared only.  Some explanation would be greatly helpful around
> this area..

I will continue this thread later and explain more fully.

- Steve

