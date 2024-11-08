Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id CBF52D5C0C9
	for <qemu-devel@archiver.kernel.org>; Fri,  8 Nov 2024 13:57:14 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1t9PTb-0000KV-Au; Fri, 08 Nov 2024 08:56:39 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <steven.sistare@oracle.com>)
 id 1t9PTY-0000Dy-V4
 for qemu-devel@nongnu.org; Fri, 08 Nov 2024 08:56:37 -0500
Received: from mx0b-00069f02.pphosted.com ([205.220.177.32])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <steven.sistare@oracle.com>)
 id 1t9PTV-0005iF-AE
 for qemu-devel@nongnu.org; Fri, 08 Nov 2024 08:56:36 -0500
Received: from pps.filterd (m0333520.ppops.net [127.0.0.1])
 by mx0b-00069f02.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 4A8BgwmD021711;
 Fri, 8 Nov 2024 13:56:29 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=cc
 :content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=
 corp-2023-11-20; bh=v4TmMRVFL87yYb/a3No8/+EEeVWUxzxfCQodaW8isVg=; b=
 B6yNJ8a+WSIsUSkIFe1bPuqGh+r7B7lgANyk2cO6IFUwRc3Tg+mYkUcRKgfPAfXC
 8UlQ+Ly+4Erw0rSwGMizUGw819EnKVskBM+91y+TyjbLpkjB+eeuegZfEAshtmp/
 sXWafxZQcK55AQQYIghHltEO0l1yew+IwNfsRaehGxDUtB1QsA/Jfh0XJsCgy64h
 muzHSSHauzbNHfgX3/racJtqFi8i5Ljd3unhbBVvAUznzszHesWc12YQLtO1Ln8s
 hs4Lt5BEr0SILo2CFnJY+pDqogPFin1HqeY09f52wK6jftpgih9LmHQhLn1LLDI1
 Es5iWJ1N+82QMOpn7xnlPA==
Received: from phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com
 (phxpaimrmta02.appoci.oracle.com [147.154.114.232])
 by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 42s6gc1jk5-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Fri, 08 Nov 2024 13:56:29 +0000 (GMT)
Received: from pps.filterd
 (phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
 by phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (8.18.1.2/8.18.1.2)
 with ESMTP id 4A8C6tPv008469; Fri, 8 Nov 2024 13:56:28 GMT
Received: from nam04-dm6-obe.outbound.protection.outlook.com
 (mail-dm6nam04lp2043.outbound.protection.outlook.com [104.47.73.43])
 by phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTPS id
 42nahbe3uf-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Fri, 08 Nov 2024 13:56:27 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=WAdvl4vqmGlJBe2oquXI+8LRlmMUKx1OrBoP9xRzyGJKQgPckyco90G+U5XRxVeiDyWSTxNcCU778bbQdrvJPU8CkRm/ky7i718Bg23y9cheUn0GnMQRFOywa1UEaOTgn4/vyR/gBrlLA+ISJ/3xqmLWKgjHiyzZlqp9qoMDsJiHyD1h9fA4mjRurqiKrnrxmF1G9A1HFoPYbRC700DuT6uGPRxMtHTnx0pSQPGwAGW1pZunc9wvorJj/jt0VtqbO2rhg0Yz7PQuXJOufdQrtWl/9P864C8RjqrjgZfz507utRaELny/n2yTDDBPZ8SJmBHjjqRTFBt6A1r0bQLNcQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=v4TmMRVFL87yYb/a3No8/+EEeVWUxzxfCQodaW8isVg=;
 b=fTCn5+4ij1HKSI9jcvFjA04o7g4Nn4Sl/rvNvlZ6xTBhjEHjtrs35MhOFmdfsGmULsU4hjwJOef7+XTqNw9vZtZVGyOBmijOKn9yU7MDJ8XiQ37Ih7fONTHeq14klM8E72Yi977Y9tMhOAbtEL+kcnC5e4knWRDCLyDnmFy6EkqEZb29+/devxHOBi4QP2A6LFdf0kR8uX6D50+/aeq8eZfo/GywVRV3eEjs5DPfOMN+b7QAl7MTzmBXFQGLLkx4YNHB3G1x33xbhZXxFmUGu3ZGPtLi6IUqiicBX/uFWtBQe2GqAhDzjJVAW2SioLLhMDHTOW06M1bvgSbNippItQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=v4TmMRVFL87yYb/a3No8/+EEeVWUxzxfCQodaW8isVg=;
 b=0KylYm6ROWwhgQrlpCEp14n8MUME7eZVYKEb3P00azXG3Iuu/BBXdrlxGxppvB1ELI+WoIXLQrHm5OpFWeGsl03iPSAXPWG5kO28s+cFB56ZQRmus81e+EVFY+HrbS/DxLxULyuSPs2TVnD3W1P+OOKdwdH7MlR9XB/WBXMVTUc=
Received: from IA1PR10MB7447.namprd10.prod.outlook.com (2603:10b6:208:44c::10)
 by SJ1PR10MB6002.namprd10.prod.outlook.com (2603:10b6:a03:45f::18)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8137.19; Fri, 8 Nov
 2024 13:56:24 +0000
Received: from IA1PR10MB7447.namprd10.prod.outlook.com
 ([fe80::f2fe:d6c6:70c4:4572]) by IA1PR10MB7447.namprd10.prod.outlook.com
 ([fe80::f2fe:d6c6:70c4:4572%4]) with mapi id 15.20.8137.018; Fri, 8 Nov 2024
 13:56:24 +0000
Message-ID: <44b15731-0ee8-4e24-b4f5-0614bca594cb@oracle.com>
Date: Fri, 8 Nov 2024 08:56:21 -0500
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH V3 01/16] machine: anon-alloc option
To: David Hildenbrand <david@redhat.com>, Peter Xu <peterx@redhat.com>
Cc: Fabiano Rosas <farosas@suse.de>,
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
 <66c05a06-dbb7-49ec-b58e-ccd917d098ea@oracle.com>
 <053dd9b6-e4f7-41c8-abe9-ed02214f0639@redhat.com>
 <cce158c4-3bb1-4771-b2c5-f3ae8a2285d5@oracle.com>
 <5b192b5e-943c-4b2f-ab40-ef54ea578363@redhat.com>
 <00261b15-3eef-439a-8501-574e3bb50d95@oracle.com>
 <d00ab1a4-2b72-4202-b810-adeb53a16f01@redhat.com>
Content-Language: en-US
From: Steven Sistare <steven.sistare@oracle.com>
In-Reply-To: <d00ab1a4-2b72-4202-b810-adeb53a16f01@redhat.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: BN9PR03CA0209.namprd03.prod.outlook.com
 (2603:10b6:408:f9::34) To IA1PR10MB7447.namprd10.prod.outlook.com
 (2603:10b6:208:44c::10)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: IA1PR10MB7447:EE_|SJ1PR10MB6002:EE_
X-MS-Office365-Filtering-Correlation-Id: ed2824a5-a6d6-4358-d821-08dcfffd2209
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|376014|7416014|366016|1800799024;
X-Microsoft-Antispam-Message-Info: =?utf-8?B?NE5vcS81eURYTDdTd3lGVFk5RXh5bk9kQ2lBTHdIM0N5N24zc1ZwbmpEM0dk?=
 =?utf-8?B?TFZFMDBXV0xQRUd3TlFTVFFhQVJiOWl6WEVMRUtUVHkvZDdJdTZYRUVRT2F6?=
 =?utf-8?B?UDJCeTFrMU9OKzJjMjJVc2FpSFJCZXMyRzgrcXFlWkpJWGN5cEhhTWRNenFx?=
 =?utf-8?B?M3pjZzBycm1DSjBtcVJYYUx1V21jV2JRNFRZSDFXWjNFMVNNRmdCeHUvaU5T?=
 =?utf-8?B?S0U3ZWcwNHdBNzQzMDlST2Z4RFhYSXFoMVZmaHdCRW5hRmZEK1hTTC9OZ2J2?=
 =?utf-8?B?aWxSM28yVmNJMzJ5eEJ3TElpNXdXVEpTTEs1OGVSVGRjU2RRTUxqdHNIMWpy?=
 =?utf-8?B?QVJaSTRKeUxpN2VlZUx6djRiTVhiSE9zYmc3b2RRWVpBaWthQUM5Z1d4QkJj?=
 =?utf-8?B?cWJobWFucVhJQUNiZmphVkJrZTVwRjN5TFcrYzdpTm5wMkVjVjNnaFZmRzFm?=
 =?utf-8?B?R3JPUnVReW1tbCtJQ3gvei9MMVV5RlFlVlVKOHVZcElINXdmM0pxL2M4b2Ix?=
 =?utf-8?B?Q01ud0s1d2FML0ExcVVmajQwSDg0YnRoemZXdUppU3dkNHVqN1ZtT29aZGJY?=
 =?utf-8?B?bE5FZzdXQytBeW5mdjhDVHM3RmZJZFlyTVJkMHk3eEhpUU9xMTR4Ri9TaFly?=
 =?utf-8?B?YXJ2T0dRY3c5L1grZGd5cnNkT3FZK1BQRS82d0xKbWFScGdTVzJ6VzJuVWRB?=
 =?utf-8?B?RmRoUDZhQ1l3QXVJSUZTOWFBNkZKWXNaMTZKZ1doRFQ3NXl2ajVyZmg5d3Z4?=
 =?utf-8?B?bzlZSmFyVDZwSWhTcGcxNW5vdDBvTFNiY3RFS1VWR1oyTGRubE9ReTNSWWNj?=
 =?utf-8?B?Rk1QVXlySGJUeFRTVjBWVlJ2dml4S0JNMWRzYWZ1dFpiNW5PRzhIWnlYU3Uy?=
 =?utf-8?B?M0diN1p5ZE93ZWRibUFnNnVJcnB5Qlo0RjNzdTRZSlBKdlJ1a1JzbVhSc2l2?=
 =?utf-8?B?dzFWTFF5NmZCTitjWW9Qc1FOS2Nua2V4bVkwSzZjbmtNWS8xOXFLRHBSTFFL?=
 =?utf-8?B?djY3STdHUjVCT1NReUJqOGtvdXFSQVNaUktnVHJYR2VyL2xqMllnOGZPNTNp?=
 =?utf-8?B?QUl2RU90T2M4UzZaKyttUWtMZXcvaWVraE9yM1FLY0pmem9xN2dMWjZBR212?=
 =?utf-8?B?OHpSb0xmaVRqcEVtd0sreG1abzQyMTVEeWUwM3QxODVENjRucTVpYVQyZENy?=
 =?utf-8?B?NFg5ak85d2l5REJaOW1mS05IUnM4L1o1b1drQkN2bFFFL1JOMVZjZ216L05m?=
 =?utf-8?B?a0QxUC9IUVdBRkN3eEFjVytLM2dyT2FOVEVMcFRydHFxSWo2aVI4N3I0NUZv?=
 =?utf-8?B?cjB6WXdTV25VeW5hOVh5Q0cwTW4yQnBmcDl2U1l0Mmh3RTNoeVU1bzNyR2JH?=
 =?utf-8?B?dUVPYXlkbFgycGlkVjBvYWp1Y1pObHdlcVlNeWZhY1U0RkRRZ0ZLUVNTZTI0?=
 =?utf-8?B?Y0VtbFByQjlBVkY4OVlkSURET0JQMktlUVFHQjBSQmlSaFp4Z0c1bHQzcVVv?=
 =?utf-8?B?ejFsNFFIdVhnbVZTaTlmcHEyQkw1U1FueGFZR3EzQis4NiszZVRUREh2SElY?=
 =?utf-8?B?R244SzNDa25HUTY0dklQc1c0a3lrUXBuenBSTi9FOGd2OTdvaFRWeWY5M0o3?=
 =?utf-8?B?dTRVZ2JLNWRVY1ZYeEd0VXVjVG4yaWl6RWJ3bURDQ1lQN2t3ZDJtZ2EwTThv?=
 =?utf-8?B?VUgzWGpjNlRkQkNMUGppYU1OZk9lUk12VFJ3M0ExOUY1dVd5T2l3QnYwb21q?=
 =?utf-8?Q?PRD07u3vLKoB/lWPth9+3W7qXKWMWhisXkgCZKE?=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:IA1PR10MB7447.namprd10.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(376014)(7416014)(366016)(1800799024); DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?Wnh6T3k0aEkvSk9EeGt2dTEvVGlndWNmNlNocGFXQTdtVHptVUFsQllqanZh?=
 =?utf-8?B?dUZGaS9XR2tGd29uRnptUG9qMmZVU0VQdm4vZlZRdGcrbzh3cWl2bjRSZ3VE?=
 =?utf-8?B?UE9WdTAzTTRMczhaL3RUYUNQblIvaWpRb2ViYUdWTEl6RGFzUlZ6bzllZ2FJ?=
 =?utf-8?B?L2R6bFlZVmJLVnBGS1hzNHJ5WndReWZIMExML0dVV1JUZVpUMXh2ZnBzajZU?=
 =?utf-8?B?S05UVnhQd0RjczArQ1drSzdQRW1LUnpqZjlBWXN1a2xPa1RlZDBtZVQyM290?=
 =?utf-8?B?MzZSSmJJYWN2blVTYmZmTS9FSVpwLzZ1N1g1RVVvTkdkVFg0UlBDbTUzaHA3?=
 =?utf-8?B?WjBnNkJCd3RuVTFvbWFmUHB5NmJHaXUvdW1Sd1Jycjh2U0IzalFsYVRKY2x4?=
 =?utf-8?B?aGROeldrSTE2MzdyUEEwNVdkVkZwTjBtOGFaOVJncGE0ODZGLytncFppTHJM?=
 =?utf-8?B?b3JYelhQSk9FQjlSR3lIbTVWZzdrcmZ5S3BCUlVBY1hxdHFxcDFrVGcycGo0?=
 =?utf-8?B?WmYzaDkyL1RoR2xMZE50ZmQ2dDFzU3F5NmV2aitOTnF3Q3hpRCtjMVQ2dCtp?=
 =?utf-8?B?cFNtM3ZTcTB6SlRuR0RVYUZWWUpWbFNFUFlJQ1FNOC9mOE91Tk84d0NCN0FC?=
 =?utf-8?B?RW1VSG9IRVpRWVh2QVkvODZtS2N2TXlUVVBvWSt4ZnMvaEV2eGRyVVhLOUtw?=
 =?utf-8?B?KzVSOTVyanE5azJ1RDlzWUdDYlYyREo3M2c1Mml3ekI1OUZRVkl1cWF1bzdj?=
 =?utf-8?B?LzZTQUtZeWlyY0NjR3pWZEZnRzV6dUszNjNiZktxVVhDenM4VDYzUlFqSEt3?=
 =?utf-8?B?SUhqcTduUklYa2ZwZDNSR3dNbmJIMHdFb3d5bTdteFk5ZEg4ZEQ0ZHQ3SmhE?=
 =?utf-8?B?U29sZFpoK3c4cTF2U1hUSWNJMkRQcW1qVnNWOTZBcmRLK2hMbEw0YjVpY21s?=
 =?utf-8?B?OHR5WXhCL0J6TkJsVzJ6NHkwVHNSSVRzV0VmeVAxYTl4eWNWcGxDZmM4MUxi?=
 =?utf-8?B?WWhkc2NzcmRWR0V1VHlCRFBxYkpocHJoZTdIUmkrSlNvU1JQSDVleTFKUVNB?=
 =?utf-8?B?N1hsN1hpTUtKeWJQS0xXdFY1VXlTRHJ6QWhRN3h5a2lTL0JrYWcvWHF3NmhD?=
 =?utf-8?B?aXRkeHgyZmpncmNmN21XQ2RGMVM5QTV1VDI3cStxYTRPSEFSRjlGM1lYVnBZ?=
 =?utf-8?B?Y0svdFRqRUxaT0ZYYTlOR2h3SU1KL1hBS1p2RU5MTXFJOFlnQUVUMFBFSGNX?=
 =?utf-8?B?cFl0OUN5Nlg0cERjOFhQK0ZWUVMzUTdBYlQxV3orU1JOcTd0WlNFa2NVRll2?=
 =?utf-8?B?MWUyd3NabFZQZFVJeUpOTFlpMTRkL0lvTWdKc3MzR2U2NlA4SlNoMjBUd04v?=
 =?utf-8?B?NU9Zcmwyem1rMmg1U3RueVl5TXBjeXBLMHNwNFV1WFMya1B4TnhYMWZzTWlk?=
 =?utf-8?B?bUMvQkRpWThDUXVINWVIQlNUUm13dUl6Q1d2NXpmSmxkR1FrWUY4RkdmemFM?=
 =?utf-8?B?QW1ReitlOUcxTG5zUHhJOFNaV0RPbzdnWnVJM3R5ZE9iYVBWNTZ5UWR6UEJJ?=
 =?utf-8?B?TW1yM21CbzMyQUtOWDZUK2FGN2dadEhFK2VVQWFGVkJ0Z0E4YSsyQkIyMVA3?=
 =?utf-8?B?eHVEQVZJaElxMEN0ME5yMGVLWnVXZ01sL1MyVkMzTDNhTWtnQTVScW8rOFFs?=
 =?utf-8?B?Qlo1VWY4MFJ4VVI1QVJJZW1hdnUwTk96RFk5RHZ4bmI1cVlwb0V3amNKbUNi?=
 =?utf-8?B?a3FVZ1FGdGVNcUpmUHIwT1dIY2J0SkNYNGdqSzdBMVBOVis4NW9QS0FOUm1n?=
 =?utf-8?B?b2c5ZG5YL3pvL1Y3bXNET2MzNXFtVHVvbVQwd1U1VEVkc3AraXc2VndYN3ZC?=
 =?utf-8?B?cmt0ckUrUzZRMENkMysyYUxiRGFqVXc3c1hZUkNPOEpqdk1OZ0tUVkg0c1Uy?=
 =?utf-8?B?bFJycnZMR3pzaVB3VGkzOUN0RkZPbzBCWVowaXBpR3NSZllzbUFnUTZwN21s?=
 =?utf-8?B?Rm1pRHhUVzBwZ2dJUDNSc25ZSXJrajNFaDhVTDFLY3BMZ1JuVUo4WGNsakYz?=
 =?utf-8?B?WkNPdG5QMGYzSkNQRWRlYWJaSTFGL2pKUmI5WjM1SGRPMGJPUFdIcTFPYXFG?=
 =?utf-8?B?TWlKMVhrSGx1UmloNDdNQmo1ZDVibzQ3c3RhaEdHaEhpTXFQWkFSRzd3cFc4?=
 =?utf-8?B?K2c9PQ==?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: 2h4OqLVi4KmYkh9W19avhr949RCbbVKtBQzzyI3asNkRoIaUsgC0CirsIW4KM0M0kOsvK0EuOwUglsybmbh6VzOqkfqSel/1WzOSZVZNtf3C475JhS5I8p23prE2IiVJ72EnLzjt+m58uzQ4cx98GeML5O5e1rrKkEy6YbCIkK7GLlv8HkO0UvFybOuMlvFzNVcGB7JiLtd0JCg8J0cEQmf/0yIcUvMXBDBQ8KbPlfEvg+5lVF3dMqIcH86md0xzSwsCj6yeuLulFnU0W68xXD5SgneZV8UQLF+9V3qW8MYtV5dSSXCnDBiPBatWG/Nu5sVMf1mD9zBn+OVhccXRiEwodGCbD2A0zhwS4PEtyEa26NVBf3VPdl+ENiI3TJ79dZp2KR3JYaZc05j9gdXKA3JwhjZgsOxluIwbxetnbb2Pr4N/a3DdytnqYY40qmKHwSGr3UIoefbErnkWVxoXguDuaBEO3sBrufa7IcIq133RVNHUtyCh6tqnYhrx92Hw33OJgboc8OkVci1Rn6VmwKhDavoYnFOX3lR0Nmrozw2PImlFmZsAVW4o9HlafTazR7H53tVFxwpn95jZogetQ8u1WXUQEoHJEDkxEgy3L1A=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: ed2824a5-a6d6-4358-d821-08dcfffd2209
X-MS-Exchange-CrossTenant-AuthSource: IA1PR10MB7447.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 08 Nov 2024 13:56:24.4057 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: TlHBo4k77Wq5RBmWHjjtwceMrsFkXgV+a4qRsINgcwt3X4sBEejoFDCYf6tzHyXM6aDeMjy95oYboUXzS1hktVUqZ2tmhqSMaY1NdkKjzeQ=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ1PR10MB6002
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1057,Hydra:6.0.680,FMLib:17.12.62.30
 definitions=2024-11-08_11,2024-11-08_01,2024-09-30_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 mlxlogscore=999
 bulkscore=0 spamscore=0
 adultscore=0 phishscore=0 suspectscore=0 malwarescore=0 mlxscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2409260000
 definitions=main-2411080116
X-Proofpoint-ORIG-GUID: hgeeiFSScxbdzVR_OuDpIjlZWNN3Fzif
X-Proofpoint-GUID: hgeeiFSScxbdzVR_OuDpIjlZWNN3Fzif
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

On 11/8/2024 6:31 AM, David Hildenbrand wrote:
> On 07.11.24 17:40, Steven Sistare wrote:
>> On 11/7/2024 11:26 AM, David Hildenbrand wrote:
>>> On 07.11.24 17:02, Steven Sistare wrote:
>>>> On 11/7/2024 8:23 AM, David Hildenbrand wrote:
>>>>> On 06.11.24 21:12, Steven Sistare wrote:
>>>>>> On 11/4/2024 4:36 PM, David Hildenbrand wrote:
>>>>>>> On 04.11.24 21:56, Steven Sistare wrote:
>>>>>>>> On 11/4/2024 3:15 PM, David Hildenbrand wrote:
>>>>>>>>> On 04.11.24 20:51, David Hildenbrand wrote:
>>>>>>>>>> On 04.11.24 18:38, Steven Sistare wrote:
>>>>>>>>>>> On 11/4/2024 5:39 AM, David Hildenbrand wrote:
>>>>>>>>>>>> On 01.11.24 14:47, Steve Sistare wrote:
>>>>>>>>>>>>> Allocate anonymous memory using mmap MAP_ANON or memfd_create depending
>>>>>>>>>>>>> on the value of the anon-alloc machine property.  This option applies to
>>>>>>>>>>>>> memory allocated as a side effect of creating various devices. It does
>>>>>>>>>>>>> not apply to memory-backend-objects, whether explicitly specified on
>>>>>>>>>>>>> the command line, or implicitly created by the -m command line option.
>>>>>>>>>>>>>
>>>>>>>>>>>>> The memfd option is intended to support new migration modes, in which the
>>>>>>>>>>>>> memory region can be transferred in place to a new QEMU process, by sending
>>>>>>>>>>>>> the memfd file descriptor to the process.  Memory contents are preserved,
>>>>>>>>>>>>> and if the mode also transfers device descriptors, then pages that are
>>>>>>>>>>>>> locked in memory for DMA remain locked.  This behavior is a pre-requisite
>>>>>>>>>>>>> for supporting vfio, vdpa, and iommufd devices with the new modes.
>>>>>>>>>>>>
>>>>>>>>>>>> A more portable, non-Linux specific variant of this will be using shm,
>>>>>>>>>>>> similar to backends/hostmem-shm.c.
>>>>>>>>>>>>
>>>>>>>>>>>> Likely we should be using that instead of memfd, or try hiding the
>>>>>>>>>>>> details. See below.
>>>>>>>>>>>
>>>>>>>>>>> For this series I would prefer to use memfd and hide the details.  It's a
>>>>>>>>>>> concise (and well tested) solution albeit linux only.  The code you supply
>>>>>>>>>>> for posix shm would be a good follow on patch to support other unices.
>>>>>>>>>>
>>>>>>>>>> Unless there is reason to use memfd we should start with the more
>>>>>>>>>> generic POSIX variant that is available even on systems without memfd.
>>>>>>>>>> Factoring stuff out as I drafted does look quite compelling.
>>>>>>>>>>
>>>>>>>>>> I can help with the rework, and send it out separately, so you can focus
>>>>>>>>>> on the "machine toggle" as part of this series.
>>>>>>>>>>
>>>>>>>>>> Of course, if we find out we need the memfd internally instead under
>>>>>>>>>> Linux for whatever reason later, we can use that instead.
>>>>>>>>>>
>>>>>>>>>> But IIUC, the main selling point for memfd are additional features
>>>>>>>>>> (hugetlb, memory sealing) that you aren't even using.
>>>>>>>>>
>>>>>>>>> FWIW, I'm looking into some details, and one difference is that shmem_open() under Linux (glibc) seems to go to /dev/shmem and memfd/SYSV go to the internal tmpfs mount. There is not a big difference, but there can be some difference (e.g., sizing of the /dev/shm mount).
>>>>>>>>
>>>>>>>> Sizing is a non-trivial difference.  One can by default allocate all memory using memfd_create.
>>>>>>>> To do so using shm_open requires configuration on the mount.  One step harder to use.
>>>>>>>
>>>>>>> Yes.
>>>>>>>
>>>>>>>>
>>>>>>>> This is a real issue for memory-backend-ram, and becomes an issue for the internal RAM
>>>>>>>> if memory-backend-ram has hogged all the memory.
>>>>>>>>
>>>>>>>>> Regarding memory-backend-ram,share=on, I assume we can use memfd if available, but then fallback to shm_open().
>>>>>>>>
>>>>>>>> Yes, and if that is a good idea, then the same should be done for internal RAM
>>>>>>>> -- memfd if available and fallback to shm_open.
>>>>>>>
>>>>>>> Yes.
>>>>>>>
>>>>>>>>
>>>>>>>>> I'm hoping we can find a way where it just all is rather intuitive, like
>>>>>>>>>
>>>>>>>>> "default-ram-share=on": behave for internal RAM just like "memory-backend-ram,share=on"
>>>>>>>>>
>>>>>>>>> "memory-backend-ram,share=on": use whatever mechanism we have to give us "anonymous" memory that can be shared using an fd with another process.
>>>>>>>>>
>>>>>>>>> Thoughts?
>>>>>>>>
>>>>>>>> Agreed, though I thought I had already landed at the intuitive specification in my patch.
>>>>>>>> The user must explicitly configure memory-backend-* to be usable with CPR, and anon-alloc
>>>>>>>> controls everything else.  Now we're just riffing on the details: memfd vs shm_open, spelling
>>>>>>>> of options and words to describe them.
>>>>>>>
>>>>>>> Well, yes, and making it all a bit more consistent and the "machine option" behave just like "memory-backend-ram,share=on".
>>>>>>
>>>>>> Hi David and Peter,
>>>>>>
>>>>>> I have implemented and tested the following, for both qemu_memfd_create
>>>>>> and qemu_shm_alloc.  This is pseudo-code, with error conditions omitted
>>>>>> for simplicity.
>>>>>>
>>>>>> Any comments before I submit a complete patch?
>>>>>>
>>>>>> ----
>>>>>> qemu-options.hx:
>>>>>>         ``aux-ram-share=on|off``
>>>>>>             Allocate auxiliary guest RAM as an anonymous file that is
>>>>>>             shareable with an external process.  This option applies to
>>>>>>             memory allocated as a side effect of creating various devices.
>>>>>>             It does not apply to memory-backend-objects, whether explicitly
>>>>>>             specified on the command line, or implicitly created by the -m
>>>>>>             command line option.
>>>>>>
>>>>>>             Some migration modes require aux-ram-share=on.
>>>>>>
>>>>>> qapi/migration.json:
>>>>>>         @cpr-transfer:
>>>>>>              ...
>>>>>>              Memory-backend objects must have the share=on attribute, but
>>>>>>              memory-backend-epc is not supported.  The VM must be started
>>>>>>              with the '-machine aux-ram-share=on' option.
>>>>>>
>>>>>> Define RAM_PRIVATE
>>>>>>
>>>>>> Define qemu_shm_alloc(), from David's tmp patch
>>>>>>
>>>>>> ram_backend_memory_alloc()
>>>>>>         ram_flags = backend->share ? RAM_SHARED : RAM_PRIVATE;
>>>>>>         memory_region_init_ram_flags_nomigrate(ram_flags)
>>>>>>
>>>>>> qemu_ram_alloc_internal()
>>>>>>         ...
>>>>>>         if (!host && !(ram_flags & RAM_PRIVATE) && current_machine->aux_ram_share)
>>>>>>             new_block->flags |= RAM_SHARED;
>>>>>>
>>>>>>         if (!host && (new_block->flags & RAM_SHARED)) {
>>>>>>             qemu_ram_alloc_shared(new_block);
>>>>>>         } else
>>>>>>             new_block->fd = -1;
>>>>>>             new_block->host = host;
>>>>>>         }
>>>>>>         ram_block_add(new_block);
>>>>>>
>>>>>> qemu_ram_alloc_shared()
>>>>>>         if qemu_memfd_check()
>>>>>>             new_block->fd = qemu_memfd_create()
>>>>>>         else
>>>>>>             new_block->fd = qemu_shm_alloc()
>>>>>
>>>>> Yes, that way "memory-backend-ram,share=on" will just mean "give me the best shared memory for RAM to be shared with other processes, I don't care about the details", and it will work on Linux kernels even before we had memfds.
>>>>>
>>>>> memory-backend-ram should be available on all architectures, and under Windows. qemu_anon_ram_alloc() under Linux just does nothing special, not even bail out.
>>>>>
>>>>> MAP_SHARED|MAP_ANON was always weird, because it meant "give me memory I can share only with subprocesses", but then, *there are not subprocesses for QEMU*. I recall there was a trick to obtain the fd under Linux for these regions using /proc/self/fd/, but it's very Linux specific ...
>>>>>
>>>>> So nobody would *actually* use that shared memory and it was only a hack for RDMA. Now we can do better.
>>>>>
>>>>>
>>>>> We'll have to decide if we simply fallback to qemu_anon_ram_alloc() if no shared memory can be created (unavailable), like we do on Windows.
>>>>>
>>>>> So maybe something like
>>>>>
>>>>> qemu_ram_alloc_shared()
>>>>>        fd = -1;
>>>>>
>>>>>        if (qemu_memfd_avilable()) {
>>>>>            fd = qemu_memfd_create();
>>>>>            if (fd < 0)
>>>>>                ... error
>>>>>        } else if (qemu_shm_available())
>>>>>            fd = qemu_shm_alloc();
>>>>>            if (fd < 0)
>>>>>                ... error
>>>>>        } else {
>>>>>            /*
>>>>>             * Old behavior: try fd-less shared memory. We might
>>>>>             * just end up with non-shared memory on Windows, but
>>>>>             * nobody can make sure of this shared memory either way
>>>>>             * ... should we just use non-shared memory? Or should
>>>>>             * we simply bail out? But then, if there is no shared
>>>>>             * memory nobody could possible use it.
>>>>>             */
>>>>>            qemu_anon_ram_alloc(share=true)
>>>>>        }
>>>>
>>>> Good catch.  We need that fallback for backwards compatibility.  Even with
>>>> no use case for memory-backend-ram,share=on since the demise of rdma, users
>>>> may specify it on windows, for no particular reason, but it works, and should
>>>> continue to work after this series.  CPR would be blocked.
>>>
>>> Yes, we should keep Windows working in the weird way it is working right now.
>>>
>>>   > > More generally for backwards compatibility for share=on for no particular reason,
>>>> should we fallback if qemu_shm_alloc fails?  If /dev/shm is mounted with default
>>>> options and more than half of ram is requested, it will fail, whereas current qemu
>>>> succeeds using MAP_SHARED|MAP_ANON.
>>>
>>> Only on Linux without memfd, of course. Maybe we should just warn when qemu_shm_alloc() fails (and comment that we continue for compat reasons only) and fallback to the stupid qemu_anon_ram_alloc(share=true). We could implement a fallback to shmget() but ... let's not go down that path.
>>>
>>> But we should not fallback to qemu_shm_alloc()/MAP_SHARED|MAP_ANON if memfd is available and that allocating the memfd failed. Failing to allocate a memfd might highlight a bigger problem.
>>
>> Agreed on all.
>>
>> One more opinion from you please, if you will.
>>
>> RAM_PRIVATE is only checked in qemu_ram_alloc_internal, and only needs to be
>> set in
>>     ram_backend_memory_alloc -> ... -> qemu_ram_alloc_internal
>>
>> None of the other backends reach qemu_ram_alloc_internal.
>>
>> To be future proof, do you prefer I also set MAP_PRIVATE in the other backends,
>> everywhere MAP_SHARED may be set, eg:
> 
> Hm, I think then we should set RAM_PRIVATE really everywhere where we'd want it and relied on !RAM_SHARED doing the right thing.
> 
> Alternatively, we make our life easier and do something like
> 
> /*
>   * This flag is only used while creating+allocating RAM, and
>   * prevents RAM_SHARED getting set for anonymous RAM automatically in
>   * some configurations.
>   *
>   * By default, not setting RAM_SHARED on anonymous RAM implies
>   * "private anonymous RAM"; however, in some configuration we want to
>   * have most of this RAM automatically be "sharable anonymous RAM",
>   * except for some cases that really want "private anonymous RAM".
>   *
>   * This anonymous RAM *must* be private. This flag only applies to
>   * "anonymous" RAM, not fd/file-backed/preallocated one.
>   */
> RAM_FORCE_ANON_PRIVATE    (1 << 13)
> 
> 
> BUT maybe an even better alternative now that we have the "aux-ram-share" parameter, could we use
> 
> /*
>   * Auxiliary RAM that was created automatically internally, instead of
>   * explicitly like using memory-backend-ram or some other device on the
>   * QEMU cmdline.
>   */
> RAM_AUX    (1 << 13)
> 
> 
> So it will be quite clear that "aux-ram-share" only applies to RAM_AUX RAMBlocks.
> 
> That actually looks quite compelling to me :)

Agreed, RAM_AUX is a clear solution.  I would set it in these functions:
   qemu_ram_alloc_resizeable
   memory_region_init_ram_nomigrate
   memory_region_init_rom_nomigrate
   memory_region_init_rom_device_nomigrate

and test it with aux_ram_share in qemu_ram_alloc_internal.
   if RAM_AUX && aux_ram_share
     flags |= RAM_SHARED

However, we could just set RAM_SHARED at those same call sites:
   flags = current_machine->aux_ram_shared ?  RAM_SHARED : 0;
which is what I did in
   [PATCH V2 01/11] machine: alloc-anon option
and test RAM_SHARED in qemu_ram_alloc_internal.
No need for RAM_PRIVATE.

RAM_AUX is nice because it declares intent more specifically.

Your preference?

- Steve


