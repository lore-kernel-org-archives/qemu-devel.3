Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 52D07CD6E4A
	for <qemu-devel@archiver.kernel.org>; Thu,  4 Jun 2026 10:04:12 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wV4vc-0002l4-8P; Thu, 04 Jun 2026 06:03:57 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mark.caveayland@nutanix.com>)
 id 1wV4vZ-0002ks-Tv
 for qemu-devel@nongnu.org; Thu, 04 Jun 2026 06:03:54 -0400
Received: from mx0b-002c1b01.pphosted.com ([148.163.155.12])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mark.caveayland@nutanix.com>)
 id 1wV4vX-0008Im-Il
 for qemu-devel@nongnu.org; Thu, 04 Jun 2026 06:03:53 -0400
Received: from pps.filterd (m0127842.ppops.net [127.0.0.1])
 by mx0b-002c1b01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 65496fXK3215569; Thu, 4 Jun 2026 03:03:48 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nutanix.com; h=
 cc:content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=
 proofpoint20171006; bh=kXC+XfZglaPNgkVHWmjVfmfZWe4DSZJFY8pQxW82g
 Wk=; b=mtkSMJDMOp+TXws2tKeKCKRZ8mxup95mI58biHM5I8iHMMI/1RkWLeeiM
 XDO3f9JNyf37jado7PqKbWWxjLYfBEq9arebYQBcO4QHcQQhL8MqHSr33LaNHBsq
 v1WCOS7sF9rUBFMNIpVphrerr2cViAulcOJNi94NVIq/ye/+j426XnZoWR/J2Vrb
 dY+k21sOz7KX0ewQ/2NwW7Lmkc9ZlU9KlZaypOCz41FtsOJo5gIWnlNrC+evs+kn
 n1FZu4gtfn3fgE3cW2EBTkARUK8VLU73OAsZTVc8vo0EGVLyknC7w4Jh7TAVa4gO
 PmSlca3kaoZm4e0qpHkh5o1zwnf1g==
Received: from bl2pr02cu003.outbound.protection.outlook.com
 (mail-eastusazon11021120.outbound.protection.outlook.com [52.101.52.120])
 by mx0b-002c1b01.pphosted.com (PPS) with ESMTPS id 4ej8sgccx8-1
 (version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NOT);
 Thu, 04 Jun 2026 03:03:48 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=COoCsEA3H6+maLWQ1I5ph4es6GdvibaeBDuA5Io3QVD1Pv7twhMe8Sgmdik7kLl34WccW+YTT7+M4HHdCGAbZgN9A/xtVx6LOo/qfuBZ5Y3/1XJUSXMfC0q7CFT8TYj02k3C7AmBiCM5VR/EQdMNNcM096QUQ0C+JinNp6Sh6tLb8QE83cVz6etDbdHL9f9tYspLQ3aaxlZyXjFUUpEJvXD/OmbZw2Jgj6MxG7/UUTJmKjH0D7d/YN01++6cOctzfniWnZk1i5z9eEad5uy8fgqK0zYK+Zpc6MFzxEX/32pw+4QYmni18h+0iNnfnsFwngO7PJA+sJ7HbqpoPGwbxg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=kXC+XfZglaPNgkVHWmjVfmfZWe4DSZJFY8pQxW82gWk=;
 b=PRu/3e9FI3OU0z9hSd+vEW7LJS2W3ORJqN5rhSfXgrKykR6dXZJvKycjfPRno0b9L7HKY2bFXvE6wTtMj+SSqJgF62Ra6bUcf6DIGemKFUdDulRk8wFJl1Sk9xeYqkBraqYmtvkRr79PqTb0lF2zWbigofk8dQzhKWaFrrI3U74774iV0iGXZh4VcxtIRiSYZd+YklIFdCNbGprnwavv7W/ItEiU2pu2SI4QO0bTcUJCBDOJg99mi+fZ4u33hPmQmUgnqUV61554teusA04RjLZfuGvo1sHJgWbAK1iahPN/yAGbnRm6N+Eo0VaYsaM9Ee16kMlVJoo065LDf8WMIw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nutanix.com; dmarc=pass action=none header.from=nutanix.com;
 dkim=pass header.d=nutanix.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nutanix.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=kXC+XfZglaPNgkVHWmjVfmfZWe4DSZJFY8pQxW82gWk=;
 b=yo+a/kAdp4Og0jcKOX6ZLD6oyDUxkR+Va4WeMCtp4W2uGpHLi4QWd6nB58Kef+9Acb2x6vhSPWo2kaE15FLkjtgQ8VkuVqWaHzFBPIjUYdKQcaqARvEIVYn2HMF01IveKN1RVDlPWWWCD5hCWmRS+XsjQnzKXxKiRHJVJwvzyB97u/OBuz1LAHAJpi3xSAaPFj5Axo147JevuKtNKoJtyLtQQVD4kusYa3Y8ojbnIVGw60wHbO3w+Cz0f11iH1SWMb+N9wZ7aMmakpMXhe+cxNkYpuhbbWL/baAjnWNjyd18ArVQ7GX3Htg4uYD3ab3gn5zdlpk348WN4or5MrL35Q==
Received: from MW4PR02MB7153.namprd02.prod.outlook.com (2603:10b6:303:65::11)
 by SJ0PR02MB7295.namprd02.prod.outlook.com (2603:10b6:a03:292::12)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.92.8; Thu, 4 Jun 2026
 10:03:46 +0000
Received: from MW4PR02MB7153.namprd02.prod.outlook.com
 ([fe80::2d8:c73a:b2f9:f1dd]) by MW4PR02MB7153.namprd02.prod.outlook.com
 ([fe80::2d8:c73a:b2f9:f1dd%5]) with mapi id 15.21.0092.006; Thu, 4 Jun 2026
 10:03:45 +0000
Message-ID: <4498429c-bde1-430e-b240-fcf71c8d417d@nutanix.com>
Date: Thu, 4 Jun 2026 11:03:39 +0100
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH RFC 0/2] migration/vl: new -incoming config:* for early
 migration parameters
To: =?UTF-8?Q?Daniel_P=2E_Berrang=C3=A9?= <berrange@redhat.com>,
 Peter Xu <peterx@redhat.com>
Cc: Fabiano Rosas <farosas@suse.de>, qemu-devel@nongnu.org,
 Paolo Bonzini <pbonzini@redhat.com>, Mark Kanda <mark.kanda@oracle.com>,
 "Michael S . Tsirkin" <mst@redhat.com>, Markus Armbruster
 <armbru@redhat.com>, Eric Blake <eblake@redhat.com>,
 "Maciej S. Szmigiero" <maciej.szmigiero@oracle.com>,
 Jason Wang <jasowang@redhat.com>, Ben Chaney <bchaney@akamai.com>,
 Vladimir Sementsov-Ogievskiy <vsementsov@yandex-team.ru>
References: <20260528212947.368132-1-peterx@redhat.com>
 <87se7btcq9.fsf@suse.de> <ahmfh2s7CLFLoZKN@x1.local>
 <ah_4hixGcNv-CLfv@redhat.com> <aiBNXUU0xcT_UbKO@x1.local>
 <aiBhTTqSctU9lFsS@redhat.com>
Content-Language: en-US
From: Mark Cave-Ayland <mark.caveayland@nutanix.com>
In-Reply-To: <aiBhTTqSctU9lFsS@redhat.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: PR3P192CA0027.EURP192.PROD.OUTLOOK.COM
 (2603:10a6:102:56::32) To MW4PR02MB7153.namprd02.prod.outlook.com
 (2603:10b6:303:65::11)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: MW4PR02MB7153:EE_|SJ0PR02MB7295:EE_
X-MS-Office365-Filtering-Correlation-Id: 1a84fc2d-58bd-4b8b-8172-08dec22090b5
x-proofpoint-crosstenant: true
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|366016|376014|7416014|1800799024|22082099003|18002099003|6133799003|56012099006|4143699003|3023799007|4133799003;
X-Microsoft-Antispam-Message-Info: JjY+SLYQtskupi6PDbAAS/C4VwR91K/e30n30Lwy7ZTI+8T/BVqgAeIFNOERJeQV/vLSFHihgjXsmg8Me8SAHpgoUBVhOIB3vSV0z63Lgehb7C1a7w57Aktl4xnUJMlN1WXV8WuECXQCkf6ASjEuyvVpyLlWLPdFOWgDe9D2d+CnSm3HFFQogiiV6WHYOA1GpHHukP/z+twRfZOC62WIVu7LD400Evifn8AezN5M1CwPMN4b7usk8lN+rJdGwyd7vlk64KEAIfAGeXv8J9sLkVbSHaDYgypFf4kQxKtk3b92wJ3jO5MP19TEadoQhDaYYM40QDJ/zUz1J073XayJpBg8lkkJsiIu1P4rjLq24oDZg1iFpE7COJBj5bof4QmN2VYLl0wkw7EdjNzM66UdpXqqkgx7DmGEkBlUD5k0PbGP8WkVmjFMpj/AZoBR9QpDeb85vl9sPHb4QwV7nF/FSCrWe363HzD8Yo1clX2hvRiX8/Ndq8RQJHLH9IA+TkrEJ6asRiBiBC+mBOQmk97j8jOjPyXI9wB9SSfzXKppkRJhxlRfKHRIJ6Ni6nly3pTIdj8Iak4tuOzjE3E++9HQYkTkEPn8vR+y3Q6bCHS7VCh+O/LehhqVKs2IFOvZDANG8xjQXI89crElnDwoghlctPFxXpWFw/vs8X90saCMc3Av14TrPpAT8GIbqruOFnvu1/HCgQwTF6pR9agDSdzHTw==
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:MW4PR02MB7153.namprd02.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(366016)(376014)(7416014)(1800799024)(22082099003)(18002099003)(6133799003)(56012099006)(4143699003)(3023799007)(4133799003);
 DIR:OUT; SFP:1102; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?NjZvbWhMVEJIT05CdFViYkt0dGJjU2hnNlA3TzcyNzRsSVZGS0I1ekdNS1pC?=
 =?utf-8?B?V3M2Rmk5THlBZVlHMG9IMGVpM0x3WWxzakN4WEJTTEV5aUZzRGVzV0VGVjVH?=
 =?utf-8?B?UTcyZm5lVjlUNGtHUWtuQ3Q4UndTa0FZOXZNSDFyUmhCeWhjeXFRc0tnT3VM?=
 =?utf-8?B?QzZtR3EzOVpPTHY4cE5GWHY3aG1ibFM3ZkhmV3czUmR1U3JJZnFBWnJscnlY?=
 =?utf-8?B?UnlQck5rTm1kNTU2VWY2dGlMUXVyVVU5L3dvWldDWGdmdjVkQzVLMDZRQ0Zn?=
 =?utf-8?B?dmF4YzJ5RHFsVUFrc2t2RUw2K0JhWlluZzFjMTh2YVdkaWt6NDZFQktmckVh?=
 =?utf-8?B?TlBOTkhPV2VQZTg2NCtuNnZsMzFNbkgxeWRaamN4UGRkMkJDbEw2dzZPOTg0?=
 =?utf-8?B?Y0VMYTBSMEQ3UDN0c3JyaVF4TjRlV1FLYXRwNERWU1liSzZBQW1Dc1FlVGZm?=
 =?utf-8?B?dW53Rko0cDVoMmsxanVJUnY1a0w2TXNEZEo5bG92RjdiYVIxM2JhclNVRzhl?=
 =?utf-8?B?Q1M0TGdPbXhxa2U4ZDZXc2tGZVhqQWtEVmFNbXR0OUt4RXJML05xcTdIb3RB?=
 =?utf-8?B?SzJmV3Fva3lQZWNKRU9namNsTGc4aU52K2pTUVRGbUVQcnRCWEFRUjdyVzdj?=
 =?utf-8?B?b1dwNTBRMnIxZVF1RncvUXU1a2RUTEJRYUluKzdyTWtlN1psbThOcmlCekRj?=
 =?utf-8?B?ZFk2MDJuN3NLTXZ3L0NFNEhQNjFmanF2bkpmSHYvSU5GRlRmaHNQYjM2b1or?=
 =?utf-8?B?b0ZGdnp6ek00cGNaNTZ3ZmdLZ2w2RE55T0hidnF6allhYThvK0o1c2NwcGxZ?=
 =?utf-8?B?akN2VUhoWGI1SlRJU3NrRXBiRGEzV012SXNkNWRpbjdobFdTZE5MSmJyN0dz?=
 =?utf-8?B?d1ZxVEE4b3dUdDhXRVEyZVROcUF0dDN4cWxFcG1MRXIvd2wrYktERDRrdkxN?=
 =?utf-8?B?STZqVUtEdTdxNGpURGZzY28vMEREcmYzc3B5bk1ReldoQUxGRTJReHpnOUtK?=
 =?utf-8?B?TXd2WGVYdTZaNVR3VkxxSHlweWpCK01ZNG1uUENwRjZLeG5NMVREalN0dmdF?=
 =?utf-8?B?cGswbVcxQzVyOXN6M0RPN29nMGFjRnJ6YlJGYlU5YlpLK3RZMkxhSllHRTI5?=
 =?utf-8?B?SW8vWm9xMWprVktOTC9mUVRNNGc4T2Z2TTI1K1JpbmVkcEw4dS9vem5QaEVk?=
 =?utf-8?B?R09lY1V0elFqTmtGbitMWVk2Ym8zOXBGbjdIbUxPR1NFOEpnUW10QVc1aGVF?=
 =?utf-8?B?SlBZRktFekl1YUlBVzJLckRod3Bsa2h1Zmlaa1JNWkd6MmZjWHUwTk00bkpr?=
 =?utf-8?B?V3NpdVgrdXZmWjNFeDdRR0gySFllMEJvV3lHM0lqYzVvZ0NlOThVQnNjRGJD?=
 =?utf-8?B?RDFraE9aSnBoRGFEQTdsN2RtMUdFUTBScEliN1JadTVJc3FTTEpYejNGeTNQ?=
 =?utf-8?B?MmFlRWRpbUFNZWtqclRlY2g0a2MzRWhRL1FLQVpRaUxMSEtjTmRubHBGaXpE?=
 =?utf-8?B?aDZ1RFIzQmJzZHpTMXE3SlNBTk56WWU2Q3ZiQTY1TTNtWlNOQnR3L0t4czZ4?=
 =?utf-8?B?SER0WmI4bkFJakFudWpzTDdrRk90YkVoaXk4SzJGOGlzOUNvSVIrMElWb2Z3?=
 =?utf-8?B?Ump6bUw4R3Y5bElZV1poVUpqZUpiMUVtdGppbDRLK3JRdWFlQ3B4bVk0S0k2?=
 =?utf-8?B?QjJ2eTZXNy9ZWk1BcG5zbWFQdzVaZEZuRDVsMFQrNFU2RXgvbmZlVFlwcW1K?=
 =?utf-8?B?WGFuekdDQ0pXelY0bFpuTTk2U0Q3S1FjSlZSZU5GUEJZRVhSZW5vOUFOc0l0?=
 =?utf-8?B?VUlsRkh4enZ5eC9UMW15eW40YVRkQVU1M08zZWhwUlVIMlhseXpoaEd6TDhC?=
 =?utf-8?B?L0hsdXpSSkZUT1o1TVY4MzdCOUFtVUR5bmRNVUsycEkycG9OUFR2QWllSlFZ?=
 =?utf-8?B?VEJoVFg1Smx1THM3bmRMenJiT2VUR3BlR2FONWNOa1JGVU8xdDZuQ2NoRitw?=
 =?utf-8?B?Y2Y1ald2OHFDM1ZvWWNUUTA0V1Y4NkVHME5vemxZV3JqVUR3U3BjeXRtd3Zn?=
 =?utf-8?B?ZXNNTVcwKzNpcXFDa3lKTzJSQnlRZHhnSXRyKzIwZXZINTNjeHdlVkcwdkZh?=
 =?utf-8?B?ZGZkUFJ4VFlZR2lJSTRYb1B0V1NGazM2RTZXWGxWSWV4Yzg1LytjNGxQcUJJ?=
 =?utf-8?B?d2FiZTFrZVZsZ1cxYVNmUmo4MEpyd0FxSXkwRzBsR3ZoTzk2d2EwNW1OdWNR?=
 =?utf-8?B?N1R2RHhycEFRZ1k3VzRLNnhsZGQyUHBHeDNKcUR3dENENi9hL04rNmRSUy84?=
 =?utf-8?B?ZnZCZVpFb2c5SkR5RjdJbytmTGVNU0FrZCtvTjdIdzErVWN6dHhtQXpUaWVw?=
 =?utf-8?Q?M1s/hfK4WVEVHOng=3D?=
X-Exchange-RoutingPolicyChecked: Xbi6YAGKh+zhJkD176VoymI43SJ9tXsfN8pAcycNkbywuqHARap/ismglBoImzMWI5OCrSzwY3BTQAT5VCPnMcrRVudgTv01161+Z+qj6iHKHwiDmWDIibg8GM5HQSgoPLj08m1Xd2Yu57yWRVkmOaS8inmfQt16BFcN4JldCGCi4n2g2nCyP5x/402cj6/WFlBqz7T8DX1++VqX6ovcMTBhKiE9BajFEQBxD+DIeZXuDsDaNkKHq2mN0MPVzpCDooSLSR8y0GKM6Eormqzvg+0kPM588QYMCOb6UuS9wjNdg1xj6pNVI2zdTAtHqsNn5fE9q+/Z36IWafL1M8DHEg==
X-OriginatorOrg: nutanix.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 1a84fc2d-58bd-4b8b-8172-08dec22090b5
X-MS-Exchange-CrossTenant-AuthSource: MW4PR02MB7153.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 04 Jun 2026 10:03:45.7883 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: bb047546-786f-4de1-bd75-24e5b6f79043
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: AK+oRs2xopCzulvE8IePKY3gMz8Oi+cLqjBB8mX0m82ygoj+BpCZLKwFHCrOuUopAU+fjtrkLrwXPEBcUEN+WQxdkwkDzkmKdHWNi7le+hw=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ0PR02MB7295
X-Authority-Analysis: v=2.4 cv=NJrlPU6g c=1 sm=1 tr=0 ts=6a214d84 cx=c_pps
 a=zawiyoErqgptCln8LtCPNw==:117 a=6eWqkTHjU83fiwn7nKZWdM+Sl24=:19
 a=z/mQ4Ysz8XfWz/Q5cLBRGdckG28=:19 a=lCpzRmAYbLLaTzLvsPZ7Mbvzbb8=:19
 a=xqWC_Br6kY4A:10 a=IkcTkHD0fZMA:10 a=FelO9ux0wxsA:10 a=0kUYKlekyDsA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=VofLwUrZ8Iiv6rRUPXIb:22 a=VUi8bpU7OL1Oj2-RSIOF:22
 a=p0WdMEafAAAA:8 a=20KFwNOVAAAA:8 a=kX0d90yV1WhUzRYAw8YA:9 a=3ZKOabzyN94A:10
 a=QEXdDO2ut3YA:10
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNjA0MDA5NiBTYWx0ZWRfX1bg/T2rv7eS3
 wbJZgmlUcZIouujq4zFFFaeSqlr2zNDVY4xBTm4QF2bSSlPJ9FqA8dFexk25m9IEXLF/tORA1k4
 Ds1phNwNapjgqEmQ0QEVNsa0NNvJMH8yCKq3CrYsCZ7Z/Zbb3REO6d+ZNKLoV+2kxVdoDvmeb1x
 g9h9EPGsp3R68IlKyL8s7BrPhXMCMtnsmJnRjFQ6UUaECctutPnLbJMhBGT6mRmDx16eXCWwcre
 onc8JyuTdk0uPvHz+YOX10vJmCw7DcXYuzskvwF+cT00pvW2Eq+HZ9hxTUqBMMhIoVtbYfYkWWE
 kR4BbYFQ+vFg9yAbjxl0vg8P7mBdY1M6WHeDZnRwR4LVp/elEZRq6dSVlv2LX43EkVBB3Sp4I+i
 REAYv+BmsBHmJ44WDuVzdWCk4M05444mXyUniPsENj0SVHDBw9+W7JASbkQQq14glEJ1IGCD6vA
 Jw2BmGWYJ4Wowo08ZpA==
X-Proofpoint-GUID: 03lVMcpYYMnqMCGu_IosMcOZ8TDxhJ0e
X-Proofpoint-ORIG-GUID: 03lVMcpYYMnqMCGu_IosMcOZ8TDxhJ0e
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.125,FMLib:17.12.100.49
 definitions=2026-06-04_03,2026-05-28_03,2025-10-01_01
X-Proofpoint-Spam-Reason: safe
Received-SPF: pass client-ip=148.163.155.12;
 envelope-from=mark.caveayland@nutanix.com; helo=mx0b-002c1b01.pphosted.com
X-Spam_score_int: -31
X-Spam_score: -3.2
X-Spam_bar: ---
X-Spam_report: (-3.2 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.445,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_LOW=-0.7, SPF_HELO_NONE=0.001,
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

On 03/06/2026 18:15, Daniel P. Berrangé wrote:

> On Wed, Jun 03, 2026 at 11:50:53AM -0400, Peter Xu wrote:
>> On Wed, Jun 03, 2026 at 10:48:54AM +0100, Daniel P. Berrangé wrote:
>>> On Fri, May 29, 2026 at 10:15:35AM -0400, Peter Xu wrote:
>>>> On Thu, May 28, 2026 at 07:01:50PM -0300, Fabiano Rosas wrote:
>>>>> Peter Xu <peterx@redhat.com> writes:
>>>>>
>>>>>> CI: https://urldefense.proofpoint.com/v2/url?u=https-3A__gitlab.com_peterx_qemu_-2D_pipelines_2560168907&d=DwIDaQ&c=s883GpUCOChKOHiocYtGcg&r=c23RpsaH4D2MKyD3EPJTDa0BAxz6tV8aUJqVSoytEiY&m=kl69Otn4IxRhV6bx7NvgCZttOrO1SL4fZ-Qd3Jb-ODVtspTqSiQ6t1ujrrf-AB5J&s=nlkn4_NSgXkwTmC4JK_Le8z4ElYZ_cmlKRBCjJhTrIY&e=
>>>>>>
>>>>>> This series introduces a generic way to specify migration parameters that
>>>>>> can be used even during the early boot phase of QEMU.
>>>>>>
>>>>>> One example use case that already existed is CPR-transfer / CPR-exec.
>>>>>> currently QEMU has a temporary global variable (incoming_mode) to achieve
>>>>>> this, but it's hard to understand and this hack bleeded into quite a few
>>>>>> places that we could have avoided.  The lines in patch 2 touched may
>>>>>> provide some idea.
>>>>>>
>>>>>> With a generic approach of setting migration parameters with cmdlines, we
>>>>>> can remove this hack meanwhile QEMU should be able to keep the CPR behavior
>>>>>> as before.  To CPR maintainers and reviewers: please have a closer look,
>>>>>> even better if it can be smoke tested, to see if this works for Oracle's
>>>>>> environment, TIA.
>>>>>>
>>>>>> The 1st patch implemented that new semantics.  It is straightforward: now
>>>>>> we can setup any migration parameter using an extra line of:
>>>>>>
>>>>>>    -incoming config:key1=value1,key2=value2,...
> 
> snip
> 
>>>>> - using "config:"
>>>>>
>>>>> This makes it non-uniform with uri and channels which don't have a
>>>>> keyword in front of them. I guess I could live with it, but it seems
>>>>> odd. I see that it makes parsing way easier.
>>>>
>>>> Yeah, having some identifier would be nice.  I wished channels also have
>>>> identifiers if we don't need to keep compatibility.
>>>
>>> IMHO having a magic "config:" prefix is an anti-pattern because it
>>> involves custom command line parsing logic.
>>
>> Yes, it's not elegant.  I wished we had something like this though when
>> introducing the cpr channels; right now anything wasn't "defer" or URI
>> implies it's a "channel"..
>>
>> I also wanted to avoid introducing new cmdline parameters, so migration
>> incoming cmdlines can stick with the same option.  If there's better
>> suggestion please shoot.
>>
>>>
>>> Does "-incoming config" imply '-incoming defer' semantics or is it
>>> independent ?
>>
>> They're independent.  Examples:
>>
>>   a) "-incoming config:* -incoming tcp:*", setup parameters for TCP incoming
>>      migration without further deferral
>>
>>   b) "-incoming config:*" only, setup global parameters for a possible
>>      upcoming outgoing migration
> 
> In that case they should definitely be independent command line
> options. The old "-incoming" design is already broken / limited
> in the non-'defer' case because it is hardcoded to use URI syntax
> which can't express all the address formats we accept in QAPI
> syntax. Adding more special cases onto -incoming just makes the
> bad situation even worse and is not a forward looking design.
> 
> If we need the ability to specify migration parameters on the
> CLI, then as a starting point for the design, we should assume that
> -incoming does not exist, and design a complete solution from scratch
> that uses QAPI exclusively, both for addresses and configuration.

Yes, absolutely. There has been a lot of effort to standardise our 
parsing, so something that will accept the current (legacy?) -incoming 
command line along with a new JSON notation allowing the extra 
parameters feels like the right approach.

> As discussed before, IMHO the "migrate" and "migrate-incoming"
> commands need to accept both the address(s) and parameters/capabilities
> as inline data items rather than relying on pre-configured global state
> from the 'migrate-parameter' / 'migrate-capability' commands.
> 
> If we did that modelling for 'migrate-incoming' then that modelling of
> command parmaeters could map directly to a new '-migrate-incoming'
> command line argument that accepted exactly the same data model.
> 
> With regards,
> Daniel


ATB,

Mark.


