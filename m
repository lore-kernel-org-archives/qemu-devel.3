Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1B7ECE95389
	for <qemu-devel@archiver.kernel.org>; Wed,  4 Feb 2026 11:38:57 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vnbDY-0006sr-T3; Wed, 04 Feb 2026 06:38:44 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mark.caveayland@nutanix.com>)
 id 1vnbDX-0006sd-Lr
 for qemu-devel@nongnu.org; Wed, 04 Feb 2026 06:38:43 -0500
Received: from mx0b-002c1b01.pphosted.com ([148.163.155.12])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mark.caveayland@nutanix.com>)
 id 1vnbDV-0002kY-UD
 for qemu-devel@nongnu.org; Wed, 04 Feb 2026 06:38:43 -0500
Received: from pps.filterd (m0127843.ppops.net [127.0.0.1])
 by mx0b-002c1b01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 6146FRiW3734266; Wed, 4 Feb 2026 03:38:40 -0800
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nutanix.com; h=
 cc:content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=
 proofpoint20171006; bh=4ri6n/HTfXto34M9Ftn2gaKRyBuRKyEB+BQg1AWjc
 Jc=; b=t3EzacBa5xhhshy5RsHi3e8A+RPcvoa2nYS8JIudl4fRnbVti6/zWOL3j
 RGa9J4Mo5fc5PnC1BGGp2Jr7CTCkHvJk2Y82sYn6ywEyczeyWJq2t4lXO811UFCO
 YemL3re5nctNg0aasd+rwNjTaiq9L00qVjgBcPPKcULbGlewUhu+S87mnJpG7WSV
 XEo/DNcyTlLYVMOKMie6vJsacRLusxWXOpQFCSIX4kMauVWHnnHZG0bxOO9fbF93
 dBajXt4zTYWA8SaSPfCylNOJ6uTTUdtU63/9K5aPtgmDmXXyicXYxqgshGSZG+tL
 n5Pip0b/V3IIIOX1yctUgXspiS/zw==
Received: from byapr05cu005.outbound.protection.outlook.com
 (mail-westusazon11020105.outbound.protection.outlook.com [52.101.85.105])
 by mx0b-002c1b01.pphosted.com (PPS) with ESMTPS id 4c3nvm25n8-1
 (version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NOT);
 Wed, 04 Feb 2026 03:38:39 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=K0XrICBz1KKZs1FIeHxm4qjiiIDU9Sjm+9P4Og0U/1daHIcnaBR9zTqPYtWqQi9mqx9m/rm3xeHI2zUVsZJKZila78BA5AWK5M5qXoVfagqtJZI+A5DjaplRfrpV060I1NBYHbcG6WQNjJRL6kveQ/WpMqfjm8KQa1RjM2BmpcmwAkIbGKRq/H/KB7JnRvj/RvGY2Iq/7izb9FC4k/npAawhlqsSD/RTS2ZKrkJI+rYNs+qCB1cbWmnC64hw6vnsxrS+w4chGZxDN9vq1ZCUhIKF2opvmEyeBHmhaL7qpbd7E3JHLKWJPSfQQU4AZ3WJMte4aVl0ueCbgQ25Ck30+A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=4ri6n/HTfXto34M9Ftn2gaKRyBuRKyEB+BQg1AWjcJc=;
 b=Ksp7Vqn/juHINZSiCqUxooEmSU7vmzhKL9buRl5Eou0VKYlbfGpmDkqxKa+hMQdb6WspZ7asLqvGsO1a2TKfA/jvor243ZmfG5vsi1p1Dfs819vlNWVwPXKoxbfzBlpfBwTIBOhaf8H2hSg59ofZRSCMA5ZsnMNv5mB8fik7tCr17MSrknwWlRYtjUBBfUDkTyd5m61phSlNlcJnlbQZGsLMNQziSdxjB1UUIcT2WXHdMEupgdeoAH/mbE+/gNj49B6bIBwGLaq8GbLG6ekg4qJhlo9IE5f7NxaP0zZHuzWUUgwLX+06l98zXw6O05S8TiXGLQr42gXX/M/aQ0gQxQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nutanix.com; dmarc=pass action=none header.from=nutanix.com;
 dkim=pass header.d=nutanix.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nutanix.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=4ri6n/HTfXto34M9Ftn2gaKRyBuRKyEB+BQg1AWjcJc=;
 b=JBFm2l95HUjlSSDBu6rSi7uuZM7AggQKIpiVZnH1cjoj+xFU1zgVey4johcY0CKkIKKXqR5EG/eZq+Z8/dpPoV0VhL67wzN/Khy4/Fo1WHb/aocFSqC3P0U41lWSeBpU3RdwUbHjU9MTe+jGGH7yST4tE+MLqrpeHpZRKOkFilnodijKkXTjDMOyXFv9reSPx4ietJdto3Twp6aC6sj6q1XyzOAI6rWA88N3BIdf93bYjhh7sDhg2m5tx44k3/FoQtNS22EuNYQ3yctyT+Pw5k5rlWHJeeP66DeCgahuiyugy0CRSVwjnzXihb6d2Nb0GyUMlVzALA78MUKtiOV8NA==
Received: from PH0PR02MB7159.namprd02.prod.outlook.com (2603:10b6:510:16::8)
 by DS7PR02MB10889.namprd02.prod.outlook.com (2603:10b6:8:269::22) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9542.12; Wed, 4 Feb
 2026 11:38:38 +0000
Received: from PH0PR02MB7159.namprd02.prod.outlook.com
 ([fe80::8e97:bc32:822c:b250]) by PH0PR02MB7159.namprd02.prod.outlook.com
 ([fe80::8e97:bc32:822c:b250%6]) with mapi id 15.20.9587.010; Wed, 4 Feb 2026
 11:38:38 +0000
Message-ID: <2cdca4c1-22af-48fd-bcdc-92044c106366@nutanix.com>
Date: Wed, 4 Feb 2026 11:38:35 +0000
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 27/37] audio: make list type declaration private
To: marcandre.lureau@redhat.com, qemu-devel@nongnu.org
Cc: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Gerd Hoffmann <kraxel@redhat.com>
References: <20260123074945.2563196-1-marcandre.lureau@redhat.com>
 <20260123074945.2563196-28-marcandre.lureau@redhat.com>
Content-Language: en-US
From: Mark Cave-Ayland <mark.caveayland@nutanix.com>
In-Reply-To: <20260123074945.2563196-28-marcandre.lureau@redhat.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: SN1PR12CA0083.namprd12.prod.outlook.com
 (2603:10b6:802:21::18) To PH0PR02MB7159.namprd02.prod.outlook.com
 (2603:10b6:510:16::8)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH0PR02MB7159:EE_|DS7PR02MB10889:EE_
X-MS-Office365-Filtering-Correlation-Id: 6a8dbbc4-d678-4349-80c8-08de63e1f01e
x-proofpoint-crosstenant: true
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|366016|1800799024|376014|7053199007;
X-Microsoft-Antispam-Message-Info: =?utf-8?B?aDNOTm54b0pkM2p1cWNscWw0c0ZTM1pxTGNCYUhsTWtvVmFLMFhmSjBIenVF?=
 =?utf-8?B?eWFkZi9MTGVxNTVuV0tmeitSeEpmb2Ywdjl1Q2RweHlvV2VsangrSE1PN3l2?=
 =?utf-8?B?Q3VNempKc2wyeTFaVE9iM1Qra3QvNmJvSENyOWFmdlN2U002QWtidUNGeGgx?=
 =?utf-8?B?WUpKY0xERUgxbUl4a0RBNDZjRW1hT2RUa3pvTW4xK0R2dVVZL3BYL0ZvNitx?=
 =?utf-8?B?NDVkSHJ2TWxVUE5JSVU1ZkVFLy9PdHlLSW03ZGU0WVYxQy94U2VlaCt5Yis5?=
 =?utf-8?B?L3F1T1owYWZhNDVZRmE3MHQ0d3NkWWRObnU1S0gvVDBkcFNYVUUwTEZDWlFo?=
 =?utf-8?B?YTJOcUlmZmdLeWJQZklUZmxXRDFiQ3RSRitmQXVUVHZYYWxnckZUR21DNnpw?=
 =?utf-8?B?all3TjJ2L3IwUGpwZFd5WmdFekVCaEV5SmlxdVBxNHZCQ3VlUXM3STdUakVW?=
 =?utf-8?B?VkdoZXRNYjN2MG1sQjNpSVVmeFFEUDY4NjI0NW9OWjdFNEJuL0ZSMlRtUERS?=
 =?utf-8?B?YmI5Q3I5aTlJUlg4TGxnakhYZXJiVHpBYXJtNGVPZjh2bWVqWjg3Z1dQNW1h?=
 =?utf-8?B?Z1NaMnlycHFqVyt6Vk1OelhVeWhkV21qMFVCa3hUQ3V1MU9CVUY4c2IzYnFE?=
 =?utf-8?B?NGkvei80UXllMGdUUjh1SURSZVJkYXFkSE12ajZMRklISHlwTU9uZURCQjBl?=
 =?utf-8?B?bENNREhtNGlZODA2YnZoNHI5azZWOHA4aVBVUDQ0dkhYVTh5RFdicmNXTVNJ?=
 =?utf-8?B?Znlza3hxTUNLOXRWOFRmaU53VGd5Wm5lNytHQm16Q0FxcklzM0d5L2Q5MStu?=
 =?utf-8?B?aUI5WmgzRXRRSWZKTDNnV1FBS0QwN1lycFVSdEVmU0NZa3huczVpT2NUc0dQ?=
 =?utf-8?B?cGJ1b25KTEFES25yQktleDRYTDNTS2hpQXJtMGI1dDlMRnBkN3NpK1JiUm1B?=
 =?utf-8?B?ZHlWREVIaWNjaUViMU5sN3lqcUsveGJka1UrYWdyUkV5V0ozbVdSN0ZUeFF5?=
 =?utf-8?B?SW5qZmhwNGZKTWkvak43K1c1bUhpVVQzSS9yaTI2N3ZqZjdYNVhhaVd1a05r?=
 =?utf-8?B?YjJrMzBRVFRCV01wYjdCSFY3M2lHSUw2MXBqK2dXams2WUpOMTFzbjM3aHdn?=
 =?utf-8?B?bGNZWUs0Zkt0clBweEtJaWZMazI3d1Z3SUh5ZWw3cHJ1NVQ2MlIwV3lTbDU2?=
 =?utf-8?B?dkgwTHVqeTEvZ2NtV2JNSVVTTFFueHlqZ3pJOEpTQlFab2srcEYwQW8wY21Q?=
 =?utf-8?B?ZUZvcm13SXRWZXNFOWk5WStBVmFibjFCMStpRnUwMFJVdHpXWjdxdEpCMUpi?=
 =?utf-8?B?NEdXaE9XaFMrdXdKYXh5S3J3L1RrVUhTdHlOQ2lMeVpjSjEyMXhoRnltODYy?=
 =?utf-8?B?TzUwenRhVEFJeDlUVjdCVndQVDFTbC9Za29QRTQvNzZoNHRsODJYcEdhLzNz?=
 =?utf-8?B?MnQ1MmJaVlBES1I3cjQyNFVCdndRb28yQnN2Y1AweXMvUGVyZXR4ajMvWm93?=
 =?utf-8?B?aHdJRU4rQXBSYUh1ZEVVc1B3ZnF4VTNxWHByUHp6Nkg4bFNtR1dpV21OTHZD?=
 =?utf-8?B?MlpXa3dRblU4bEhzUVA1Sno3ZGZWMTNBTHMwUXlRWWx2ZXo4ODhnZmFydm9l?=
 =?utf-8?B?VEJLUUxsa2QwR250bHZHQVd3U2RqQ244ZmlSZk01YjRoWXJaR0VJWVBWaGlT?=
 =?utf-8?B?LzhZVkhxQ1g5NkZ4dVMrcDFxUEZmSDI2Um9xdVpzNXhiYkV6TXd2NkpPTVZL?=
 =?utf-8?B?MnllbGNFbTdPWnIzMVJHSkdzSlVBa0dEa3RPQmZRZ1RYd2g3S0llSktqTWVX?=
 =?utf-8?B?bllvQjdNdnVnenM0Z3ZzZ1lCKzUrTnMyM25nRzNMVUMyK05FUTBGSHlKTEg1?=
 =?utf-8?B?dHNibHNUczlHMmJiWTJPSUZ6cVFuUkZITjFNeU9IY1RQU0wrZ1hPUmZMV3No?=
 =?utf-8?B?aHcrM0h0dEdLUHBpVXNjQm1saGEybFM3d0phRTIzVWM1OUdNTHRWQjk0YWYw?=
 =?utf-8?B?Yjc1MXF1REE3WHFCMlRWTTNibVpoOEs3WkcxclNheU5XV2tEQ2JJR0I2VmdR?=
 =?utf-8?B?NSsvalE3SFg0TllIOEZUWTVjRzMzWHlmQU44dWFIQkxaQ0VHcVN2amRQM0Z1?=
 =?utf-8?Q?x1fI=3D?=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:PH0PR02MB7159.namprd02.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(366016)(1800799024)(376014)(7053199007); DIR:OUT; SFP:1102; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?U0RETXNnczJUN3IrYUt1Um01TUUxSXRDSFo0eDZDKzJodTkveHp4WXZ4R2Zh?=
 =?utf-8?B?bTV5RjF5Zm8ydSt1cmZMdmxOaUNlb1NGT1Qyd2E1Y2phMTF4VzloSVJKT1NG?=
 =?utf-8?B?czdrTlUrVnJQSHQrcWdVaEI0VHFKQmtRTERlVzYxUWVMQStzNGVPUWc3Qk82?=
 =?utf-8?B?alBZdWlnUy9mbTlkWDIwQU9HSHNmSkgzQ1A5T3hMS0F2eUVCd3JGRHNJR2V4?=
 =?utf-8?B?VmdUU3F4aUk0ZzB0UnFPRXhNcnhEeHJvSWZvaVloa1ZBdDh4Vm1RZU01TzdH?=
 =?utf-8?B?RDc1bklaVlJaN1lIQ2xYajlvaW14ZjFET1FGdm1Dc1BlZUQrazZiSGNIcnEw?=
 =?utf-8?B?ekIvV1BZckJ4M200bVVqb0YrYS9NeC9uMnA3UTJTQkE2S2VKck1ZWk1reS9X?=
 =?utf-8?B?dmY3NWQ5T0plemRWZVA0RTVhZm8vN3dBUmVISGgrTUNIMVhLTkNOZUh0SEFq?=
 =?utf-8?B?MUpwRE0va0FuWE0vRTB4OUE0cG1yUW1hTVRIR2hPUC9kaElrWEFvM0JHWVF4?=
 =?utf-8?B?c2ZKUXlkc3JBVThXUnJWMnRUbmsyR1Y5MnNONzgxZ0tYNFQvL1l1YUEvejNk?=
 =?utf-8?B?VUFnNk56RlptSEs4dVJxdXhBOXJlTlpleHlhSkdsemlkN2lOYmVINFRmT0gr?=
 =?utf-8?B?NFgyZDFtbXpsNUpaWThHdUI3bm4yWlhieDVURk9HRFlYWHFsQTZ0dHZCRUpw?=
 =?utf-8?B?K0xaZEZTQzRXRGV2S3o1NHFjNVdrVjhqR1gxM2RUMVpzTGxTVitGNVJDWlFE?=
 =?utf-8?B?Y25rWDU3TkE1S1FNakNYRThLcFhtK1hEcU9LQjFOaDc2eHcvbVVRUmN2YkRm?=
 =?utf-8?B?SU40d215L29oc0hzdWRRRzAxVjQySUMyOWFNbGtQT09YSm1ENU9YaTR1UW12?=
 =?utf-8?B?alFsRi96bmw0VXV5RGd1WEkrQjlMWXFyankxdWRlTFBJem1qcmNZVGsvcGR3?=
 =?utf-8?B?MWZkcURjM0xMb0VPUndKNlRxQkhTeHdScDN0WVlGaUUwK0ZqazZRSjZQL2c3?=
 =?utf-8?B?TXo4b3hDMmMrNkRseGF6dVZvMzZQeVVzVVYxWkRRcnNIKzN0cEFyNTViSUd0?=
 =?utf-8?B?Wkw0azBBV1gxcGZNZUMxRkNMWENYR1J1bDM2dGlmOTF3NzVzRkNzK2N2bnk0?=
 =?utf-8?B?WjBaUFVia2hWT1pqQXlHTjN2TG5KTjVJTCtYcXoyc1hseDFRdW1aODk0Mnor?=
 =?utf-8?B?NUEyMVMwTUdPK2ZtNFplYXVGUjRML0pSUDB3M2xFYlVhMzZjZXIxWS9GL1N5?=
 =?utf-8?B?THlaTmRLU3crY2lNMTQ4eU5lYUpCRmRZWmFWUkx0ZmtrNGVoQWo5Qk50aktU?=
 =?utf-8?B?OTJMOHRHZEFPWXpTeWNXajVvQVNURnZhSjc2N2RQVDlMd3FLb3hDTWZLK0dL?=
 =?utf-8?B?WHFOMnREbXZFUGFrVDMydWwvNmVnaGNmQkVUZVlmMWNxaGV1L3MxdjhhYkYx?=
 =?utf-8?B?SGdqbmpOV1cvVjd1THlUUE9mbCsxOW5CeXVZMUVOekUxU2xVc1JQN0dTdkds?=
 =?utf-8?B?TmQxa1FoeWQzUlVJYXBwc255MnJNanVocXg2R2dVOHdkVGxGYnpwWTNGVnhI?=
 =?utf-8?B?cG5wOWJiS3Vjd01BcGJYUkFzWG0ySTRvTWordHRNQWFPdUNXRFlFOGhMNWVU?=
 =?utf-8?B?R1p1OXBsQmdPZGxqU0J2TEg1TXZGNHFnc09DaWxDQklyVDU3TUJ2UFRkUWFU?=
 =?utf-8?B?QktHRmZwRTY4NHYrZnZSeVllNDF3YnBCTUN1OWZ4WXpQYXVoTkh3dmVTUW0x?=
 =?utf-8?B?WVNSWkRVZlpXZU80ckY5OVlhb1pWRFV6SWZxUStpeFpnVlYzU0xOSkE3Z242?=
 =?utf-8?B?RmtvZjFHUmlrbEZISkpVMGRYVm5mM2F0STdXNEFkQkw0MFdCNzVRMUlPaHVH?=
 =?utf-8?B?dVVVdVM2TlpsbmFrQkJtQ0Nib204dW9NdFBjNmNvSG9nVUlNZDFtT0hmckI5?=
 =?utf-8?B?a0xuZUY1M0grUTZCbklQZWJtcGpNaGNRd0Zrc1Q3Njl2RzdNd0k3L1NkVkY4?=
 =?utf-8?B?cVBLQXpwMFlwSWpvTVpHMmFpcFpPaWdQemJsdzZDVlBBcS9meTFBTzNnTDFj?=
 =?utf-8?B?OEtJNjRsMDRkaXY2RVFwY1FuVlFET1RpZUh2dkEvM0tnMWhTVDlHMlBPaVJ4?=
 =?utf-8?B?MDcxUUFGVnA2QlRBc1Z4MHNDWkNjVlhtSlV6WHIzRnBSdlBTZWN2QXI3RjlR?=
 =?utf-8?B?ZkZoTXA3ekRRSC9HTjVvZVNmVXBwL29HSlpKdDN3L2Z1TTc3RElaZWxXaDBx?=
 =?utf-8?B?QVp1K1kzRmZTZ1J3Q3UwVVMyRTZqdHJyQTkwb2tHaDBoSEt2N1VYM0ZjUTA5?=
 =?utf-8?B?ckExeWtTWnlvNC80Nk01ZHZaMFRjblhNMDdoeDE2R2dhM2lpT0Rnd3pPakY2?=
 =?utf-8?Q?vvjw94vmeGgPxubo=3D?=
X-OriginatorOrg: nutanix.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 6a8dbbc4-d678-4349-80c8-08de63e1f01e
X-MS-Exchange-CrossTenant-AuthSource: PH0PR02MB7159.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 04 Feb 2026 11:38:38.1247 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: bb047546-786f-4de1-bd75-24e5b6f79043
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: CViZwUIQGs2yIuQp1cs/h3PX+KsJhlQAZ3KNX/+yhqCXDNl8jmuvHXOldopdKVvpVox9HnLbG5hBSH296b8mNZIuaCvB/hmY52e59qWZvXQ=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS7PR02MB10889
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwMjA0MDA4OCBTYWx0ZWRfX0bLuJ5KeIDT5
 K+fnuIDJf+yfGLdzkl2BCMTlqJDtgTIxkmestY6McRJcbQT6iA7jCBaJ+qm8KGF7OgXShpxMTXJ
 xU6y5q6dhFAkwv0CWlG83/u7G6Ipn0UNVH0wjwoAQ6BQ/cWsSXP5adnBRrVnyB52o3ZDl2nTAWX
 htTmaTQHUf43YPCQWMZji2tUqE9whcp9gYIP5EpWomMXwS6bvrfInlyNye48CwpyD0zCRzuox8h
 lTDzGeXj28kiDFoC9lG8zmmQ0nLiex5JEY4hxnjiFxtvPyAHOuzpU8ZEuR8v7WvyVUaMKIqEoJF
 +wOjGX1cU6KSjYEEGNO90A1mvoqp1ub+jJ2YWFZrxlkreDuqDGlNaZs63+b1qE09nUVCO3DKECc
 GotkXxYjC17NR+9MrxPVqitBO2vqrRV68Ij1fLb1PjUVbxELlUHHXxA7xgJghJcfxB0d+p2sZdd
 BmBTRVvYx3WvobQOnHg==
X-Proofpoint-GUID: EUGwn7QAUARWjQD5RsRGVPt0yDybLcmR
X-Proofpoint-ORIG-GUID: EUGwn7QAUARWjQD5RsRGVPt0yDybLcmR
X-Authority-Analysis: v=2.4 cv=ZNjaWH7b c=1 sm=1 tr=0 ts=69832fbf cx=c_pps
 a=KI7s4FTSNOfRXFB7i9gQ4A==:117 a=6eWqkTHjU83fiwn7nKZWdM+Sl24=:19
 a=z/mQ4Ysz8XfWz/Q5cLBRGdckG28=:19 a=lCpzRmAYbLLaTzLvsPZ7Mbvzbb8=:19
 a=xqWC_Br6kY4A:10 a=IkcTkHD0fZMA:10 a=HzLeVaNsDn8A:10 a=0kUYKlekyDsA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=20KFwNOVAAAA:8 a=64Cc0HZtAAAA:8
 a=ALzcmc6JWyVOYNm8pxoA:9 a=3ZKOabzyN94A:10 a=QEXdDO2ut3YA:10
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1121,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-02-04_02,2026-02-04_01,2025-10-01_01
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

On 23/01/2026 07:49, marcandre.lureau@redhat.com wrote:

> From: Marc-André Lureau <marcandre.lureau@redhat.com>
> 
> No need to share in a common header.
> 
> Signed-off-by: Marc-André Lureau <marcandre.lureau@redhat.com>
> ---
>   audio/audio_int.h | 7 -------
>   audio/audio.c     | 7 +++++++
>   2 files changed, 7 insertions(+), 7 deletions(-)
> 
> diff --git a/audio/audio_int.h b/audio/audio_int.h
> index 446ba1d52c6..08d07b17557 100644
> --- a/audio/audio_int.h
> +++ b/audio/audio_int.h
> @@ -306,13 +306,6 @@ static inline size_t audio_ring_posb(size_t pos, size_t dist, size_t len)
>   #define ldebug(fmt, ...) (void)0
>   #endif
>   
> -typedef struct AudiodevListEntry {
> -    Audiodev *dev;
> -    QSIMPLEQ_ENTRY(AudiodevListEntry) next;
> -} AudiodevListEntry;
> -
> -typedef QSIMPLEQ_HEAD(, AudiodevListEntry) AudiodevListHead;
> -
>   void audio_create_pdos(Audiodev *dev);
>   AudiodevPerDirectionOptions *audio_get_pdo_in(Audiodev *dev);
>   AudiodevPerDirectionOptions *audio_get_pdo_out(Audiodev *dev);
> diff --git a/audio/audio.c b/audio/audio.c
> index 53b3ad09bf9..8aa071f4580 100644
> --- a/audio/audio.c
> +++ b/audio/audio.c
> @@ -67,6 +67,13 @@ const char *audio_prio_list[] = {
>       NULL
>   };
>   
> +typedef struct AudiodevListEntry {
> +    Audiodev *dev;
> +    QSIMPLEQ_ENTRY(AudiodevListEntry) next;
> +} AudiodevListEntry;
> +
> +typedef QSIMPLEQ_HEAD(, AudiodevListEntry) AudiodevListHead;
> +
>   static AudiodevListHead audiodevs =
>       QSIMPLEQ_HEAD_INITIALIZER(audiodevs);
>   static AudiodevListHead default_audiodevs =

Reviewed-by: Mark Cave-Ayland <mark.caveayland@nutanix.com>


ATB,

Mark.


