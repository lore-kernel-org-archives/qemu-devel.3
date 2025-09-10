Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D3F12CA101F
	for <qemu-devel@archiver.kernel.org>; Wed, 10 Sep 2025 08:02:40 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uwFmK-00054J-Kc; Wed, 10 Sep 2025 04:02:09 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mark.caveayland@nutanix.com>)
 id 1uwFmF-00053b-7r
 for qemu-devel@nongnu.org; Wed, 10 Sep 2025 04:02:03 -0400
Received: from mx0a-002c1b01.pphosted.com ([148.163.151.68])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mark.caveayland@nutanix.com>)
 id 1uwFm2-0004MY-Nm
 for qemu-devel@nongnu.org; Wed, 10 Sep 2025 04:02:02 -0400
Received: from pps.filterd (m0127838.ppops.net [127.0.0.1])
 by mx0a-002c1b01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 58A44sgM1023032; Wed, 10 Sep 2025 01:01:44 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nutanix.com; h=
 content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=
 proofpoint20171006; bh=FESIiMbMqj1NdSqW0aNIv/D1ZuNZbncA1lUs+0A5j
 2Q=; b=KI+GqzHKw66zFxWTpH2HbvRxIhLZULRAiDplBnahaam1jF68+fHvw6pBA
 bgihAAogJMW3aUkS0OZL7nNrmGnkFglR2Yi35hSsrhZbObhklKO/vlU7k8lKHjFk
 U4P0EFkRk//d2XCkaKBHmXCB/eg6WS0nEYd1Digrd5aVDwEpvrrsp/GvwDHgCgOo
 hLmCTHIgxmYoxChN0z6OGs3CN3hQrV4wy9ez5hNGJ7LTP2y3ynK6vaOwWkKFU0fS
 2dAMpUbYJubf3t3BTzfXSvF94ADwYASdGLCOMKUb4TMG/pMtO573N25tamLQvLfX
 1mo7A6kMFlviPwFv+I7TqS+U2MNgg==
Received: from co1pr03cu002.outbound.protection.outlook.com
 (mail-westus2azon11020107.outbound.protection.outlook.com [52.101.46.107])
 by mx0a-002c1b01.pphosted.com (PPS) with ESMTPS id 492qh59v20-1
 (version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NOT);
 Wed, 10 Sep 2025 01:01:44 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=nxb6JIZe2YW8GlOxxoFuJIENbXIsGZK+We00pGEq41lnAnvvTlrOib3zDHgnhqjIcjL5sQO8BtgMDdG1ttUF8Uvol2UNiRMe0sF99kTL9EHSHHGf4KYNz1qG+JhQbIE01aRgUF/vJD4Rhh2Uh9pCOAbI3X7z+Q3WDp7leEf3zVM6k8mfe1kjeof5H/AUMPx3wNpwjWQrSODgm/T9P4DcKD/64psSnmKSKJkImD8ylNab54KHeOJKc8YkxnLzWPsPzvJA1IOHQFRN/j328+ZTxBzNsUB9vgqzUMWt+o1eRfUQq9bTwL66Ai8+MgPYKBstEH0aLPa7+drGULGdg1KlRA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=FESIiMbMqj1NdSqW0aNIv/D1ZuNZbncA1lUs+0A5j2Q=;
 b=c6H2baofHLcUxu90pQCCjsKkU/Dm91AieIXIQOvosatBZYbf1QAaO1bSR7x3GPn0sbid1fi6gtGseIu3fEDN9/taexCOtOjsiLeJSvf3qhRp/auENXr9ttR+HyklEfoGMlnla80aic9gJ0w6g2wa4r/xj44VTzabzkC+8oP7PMujVU8eygtSo+2+D7+X84u9RUuVpAtxFKYReRYHr+sTfGrgYr4EBg9nP1/yfsfJC6ewAzuHg3ABNecQQLKVqTJeS2E3FBc3DaiU+Pry8JfBPZE9P3DHQaKud2UedMYhYaWZOXjEW4pugSF6QnxQ8VXA8UfroEMZNI5y7IMPTE8Pgw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nutanix.com; dmarc=pass action=none header.from=nutanix.com;
 dkim=pass header.d=nutanix.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nutanix.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=FESIiMbMqj1NdSqW0aNIv/D1ZuNZbncA1lUs+0A5j2Q=;
 b=qmoQRs+gJe1qf+PyV0R1f6s47VX4SDMLvYlQxQy8n345RZaVSJ2qB3u5zl9PnhRBBP73Mv8DB6PNtAFolr/SIFDfDbpAMsx2AJ5q9m+BuOyfxt/ukRq48esGWC025484GVvb6wGSoYNF7M7spfNIouI/1eCKrsh50heeTzjkoN4kjevzZ4hf10Vwr4boeiBDZHpaxQFRr/ozA2tbPFTPB2zTl3AoOnC5JTKOZc6+WhlY7K54D2868ub1XevW9olaHBsHINsfywY5Mu0nAY7C1uXrVrw0xcBum9lu0tnjwsmKxDgyKewU45l+ItMYZXJ2o3Esa/NYrUvfuca+GBMDZw==
Received: from PH0PR02MB7159.namprd02.prod.outlook.com (2603:10b6:510:16::8)
 by PH0PR02MB7574.namprd02.prod.outlook.com (2603:10b6:510:55::8) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9052.29; Wed, 10 Sep
 2025 08:01:42 +0000
Received: from PH0PR02MB7159.namprd02.prod.outlook.com
 ([fe80::6cf9:b35c:b143:bb88]) by PH0PR02MB7159.namprd02.prod.outlook.com
 ([fe80::6cf9:b35c:b143:bb88%3]) with mapi id 15.20.9094.021; Wed, 10 Sep 2025
 08:01:42 +0000
Message-ID: <f78216d1-c80c-4b43-b9bc-c7e941a49cb6@nutanix.com>
Date: Wed, 10 Sep 2025 09:01:38 +0100
User-Agent: Mozilla Thunderbird
Subject: Re: [PULL 10/16] target/i386: implement TSS trap bit
To: Thomas Huth <thuth@redhat.com>, Paolo Bonzini <pbonzini@redhat.com>,
 qemu-devel@nongnu.org
References: <20250512190524.179419-1-pbonzini@redhat.com>
 <20250512190524.179419-11-pbonzini@redhat.com>
 <23d92164-5f1c-4905-a2c9-12ae2db580f5@redhat.com>
Content-Language: en-US
From: Mark Cave-Ayland <mark.caveayland@nutanix.com>
In-Reply-To: <23d92164-5f1c-4905-a2c9-12ae2db580f5@redhat.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: LO2P265CA0407.GBRP265.PROD.OUTLOOK.COM
 (2603:10a6:600:f::35) To PH0PR02MB7159.namprd02.prod.outlook.com
 (2603:10b6:510:16::8)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH0PR02MB7159:EE_|PH0PR02MB7574:EE_
X-MS-Office365-Filtering-Correlation-Id: 805afa3f-f1a6-463e-f5dd-08ddf0404781
x-proofpoint-crosstenant: true
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|1800799024|366016|10070799003|376014|13003099007; 
X-Microsoft-Antispam-Message-Info: =?utf-8?B?UVI1cXprT1MydU9tRWh5QnVyUnRFNmdnMWt0bzFkWnk0T2pCS3ZkYStQZGFp?=
 =?utf-8?B?U1Njb0R2cFlkbmE4NkpyeVlmTGUzOXJUMTVKY3lpUWg1VFZ5b3dTQ1pkdy9i?=
 =?utf-8?B?VW8rWW9QYTJWYXhtWDJrekdJY2YyWUJDeG95VWNERUViR3lPT0g0ZzFpOUFO?=
 =?utf-8?B?SEFJM0lnTmtqMnlmMUV1d25LSStpdXRtQkR2Q1VSNndqdlYveXBrV1JmUUVm?=
 =?utf-8?B?U0tNWmtPdE9SV0syb2swNWdTOW9BWFQ2cE9QM1ZMNjA0cDJGSktJZDVnZ3hV?=
 =?utf-8?B?NW9DTzBZZlJaa1RNek55ZmluNG1aYS8vTkh1VzZwUm42cFNIbWloZlFyWFFW?=
 =?utf-8?B?MDNLVk9ObGNlcDN4endiemdKWDRHcy9RakIzQmV0ME02aDFOSW12NFBUWHJo?=
 =?utf-8?B?aGRDVzdiUzVHZVJhblNGMU5qaGZid2V4bGIydVNnUml6WnBKT2lON0trNUVU?=
 =?utf-8?B?QWJsZG15YXRKNWVGbzM5dDZFOWdyL0t6MVhmbUlyUEY2VUc2Y2d3T0hPdmpo?=
 =?utf-8?B?aWZFdFZ4UGREOWRjWU02ZXkyR0JsdVlWbEpSWTlKbUVnNmlXakFXWFlpKzRv?=
 =?utf-8?B?TExQZDBURVRFakxjZFBTZnZmcyt3Vlh4TU9TMGY4My9JSTFzcCtrcktpc241?=
 =?utf-8?B?bXlGNlFyTk82US9kanpBY2ZKSVFxLzVsYTJpMUczaXRiSzNqTmlQajVVVys3?=
 =?utf-8?B?eEthWjZsZ3hJZmF1VFdNT2RPdWVWTXl2Q25mNWpIYWhyZWRjMXR5UE9qeFZu?=
 =?utf-8?B?aTRZNk01ZmoxSG9LWmtoOERFbEVzaTVxcU0vNEVPRklNRXhXWjRiRE9idXBK?=
 =?utf-8?B?ZElXbk01Q29Yb0NpbmZCUkxWaThQQmZmNS9Ra2JJdTJVTURpU0ZWd1JBdzNN?=
 =?utf-8?B?dnZFbW1CSDdBYnRCOUtjQjdSb2drd1pORFd5YWVaQlc0N3ZsRmM5d2swNzlu?=
 =?utf-8?B?QlZKbnNkR1plcEM4OXFDWVhRbDhoWVdGcjdWR1F2LzFuSzNNTVM2YVpaRnhI?=
 =?utf-8?B?OU5sdEdjTWJBYVVTd09rblR2ZTFMRkhmM1lDTXBLZHo3TEVDMFUrKy9yaGhG?=
 =?utf-8?B?N0xVVjBsbThySHFiYm5hRUxqVldLQ3FaWGIzK2VHWmFVNXNlUzhqMlJYL3BC?=
 =?utf-8?B?aGhlVE1kYkNEY3ZvSytkV3J0R3NEb2pva2NqL0lQc2VvbWJtY1BJanZFYnA5?=
 =?utf-8?B?dGhzU1FZVmtET3RZdnZYaUJsQS9rQUx3bDcwRGcvQmlBT1JCUnYvL0x0MUp3?=
 =?utf-8?B?cG12OWs0cnhYSjB0YllQL2FkdWdPTE9xUkxmUHkxTUJYSm9Jbk1Iem9TUGNn?=
 =?utf-8?B?VWVybTljZnFqWjZGVEtDRnpvaDl0N2RYdTJSMndadDhVM1kveFUrMmdUNGZD?=
 =?utf-8?B?VDZja1NFQ2RWWDl3V3NFcVZKZzBrb0FqZDFwNE93WkZ1RUIrODdzcHN0YTYr?=
 =?utf-8?B?aHhQdzZmTVg4N3ZvTEowTStCMmUyVitSOXZIdnBsajVVVmFqNnpUTkliRjdI?=
 =?utf-8?B?SnIwbFpQU3A2alhXRVEySmJpWVM0TU9VZHNoTmRpZEpsRnZNRW5iUTZJR2tt?=
 =?utf-8?B?eWFTNStIQi9ZSFkzQXFaUU1iM3dDNDdyZDNKYjIxTHdPTCtQWk9YSmJYaXM5?=
 =?utf-8?B?Y08vTnEyV2xWdWo2aUFwWVVyOTJEUXZENkp4eFE0SE02WDhIMCt3U1ZzdGd2?=
 =?utf-8?B?d215YkxZc2xEU1dqMXNxdHkza2ZSRjRTU0pxYjV5UXg0QkdHNnBJOVJFSUZt?=
 =?utf-8?B?RjRoQkpRcXdBSXZXbTlzWUNHTmRRQ1Y4UW5SOHFUbUJ4eDFKN21MYmdmY2JF?=
 =?utf-8?B?SnpCQmQyRjF0Y2g1MmFmbGNSanBJMG9BcjAvVlRtOTJvRUZlUklSNTIzR2U4?=
 =?utf-8?Q?a8qj/3f8AYSh7?=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:PH0PR02MB7159.namprd02.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(1800799024)(366016)(10070799003)(376014)(13003099007); DIR:OUT;
 SFP:1102; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?ejRySjhPbW9JQzRIZUdiT0hDTmtQbEprdWtuN1lKMkVnTFdBSkRrNHlhR05k?=
 =?utf-8?B?azg2R1lGajArNkhLZUtoTDlUbkRkYnFCNkduVUpob0lweDRlM3RHdENGcXUx?=
 =?utf-8?B?RG82SDA5R2Zya3FTalRsMkN3WHZQSEYwbTM5NXNpVFZUdm1XaGJ4Y3NlSW93?=
 =?utf-8?B?K1Rxa01hWEt5dVUyV2t3Zy9PMWNTNEJLamNDNlVXd3IxdW5zRWFDYXFVVktZ?=
 =?utf-8?B?eEhXOXJ5elcwQnRTS3lhSE1zWFY2N05OUHZPTGRMbEM2T2RjQ1hBcWYyRnZ3?=
 =?utf-8?B?dnlidGRqUkRNemxkY0k4VVZxZk8rdDl1VHJsdkFIRlhyQUZSanVGN0RScFJ6?=
 =?utf-8?B?UWdNbURON05sRXZ4cUVldkMxeS8yalI1dUgvTDBJdmQzSFRPdkx2ZTIvSjIz?=
 =?utf-8?B?YTRsV2dpNmNwOGQ3YlNuV1Z5UDNmQTI4MjlxR0VBUkNoUzRYdlI4OWl6WHhT?=
 =?utf-8?B?ajBBTlV4NDJxZER1SUs0dDZlVVhFQndVMWhVY0s4VW5oblZmRUl3bmR3Nmw4?=
 =?utf-8?B?Zmx3cndjck8xQUlvUmN6MjR3UXRzVmt4RnBjbjEyc0RjbjBIRUpHOWRXaFFw?=
 =?utf-8?B?a0RrTGNaekE1cTEzWkJKcmJiMnMxZnUrMlhqampNZlcwbVVwZTBKRlJBT0N0?=
 =?utf-8?B?NkZWSDhralFLQ0lHTFlETjg2NTQwbmpzZ05GYTl6aTE0UU1OR2F0eTNIQ0E1?=
 =?utf-8?B?K3RyOHhNclVHK0dlS0FsNmJpRnBCaHBrZ20zeVBGS3VlMUdZZWJlSisyOWor?=
 =?utf-8?B?UkY5VnNqM3JvbmQzNlZiSWo1cWw3Wm9vdkl4UWdpK0x3ZTR1Mis3WFFvMkRL?=
 =?utf-8?B?aEwraFBieGEyeXpKTnN5NGVPVC9jaTUwajY5K2Y1d3RWZDJpNDlxMytSQW1q?=
 =?utf-8?B?eS9hMFc1Q1hRTXVSVVBtOE1GWTYydGJEZVlQZkNxc3d6QnBNNEJYMTF0cHF6?=
 =?utf-8?B?UlE4MnNhdFNsUkhQNzZzV0lMWDEvM2FWTkx1WGJNMkt5VUR2cG15YWVjOVJl?=
 =?utf-8?B?KzVMVWJZQnRVcU93TVlvSFR5ZXlLN0lLYVREMFllZFV5NlBYVXVWTnRwNVZs?=
 =?utf-8?B?Sm5JdlZpdjRHQU01ekk3NGRPS28yNXAranpCVUlhanFmSXZVUEdUNnJyc1JV?=
 =?utf-8?B?ZHhKSEplN09Fb3hSWGtwUDVSYVI1cGtCNVk2ZVlzVXpoU09lYk1yOHBHdXZZ?=
 =?utf-8?B?b0NCeTYwdWtZUUFjOGMrVzVYVER5WGJPUVp3R0dmU2JVMkFyZ3pWN2JvWGNl?=
 =?utf-8?B?cE9DS0JHMExVbkNOeHJZUUxPMXZlZzdRQmtJajd1dkF2RnlDSHhleHVMSjY5?=
 =?utf-8?B?bnFtOUIxaGhRVFRCMlBGUE1ubDk3U09aeTMvTHhBVmtyYmRuNGMvb1htS1Fx?=
 =?utf-8?B?Tit6N3RCbXBrY2lrcFNwbVNBaUlIcFc3Um1DaTlkNElLdGNOTkFKeGd0bFo1?=
 =?utf-8?B?cTBUVWpNV2NBaEhTaEJQVkNKZlFqOEEvUVc5cnVGeXoxNnI5N3R6WmJaYVpU?=
 =?utf-8?B?U2Vma0MzcnEvNE5EczdnY09CSjJtaVhKVFRVcWVPYUtMMVVkbHpSZ0JmalJQ?=
 =?utf-8?B?ZTZldVJUai8zQ2RyQ2lValdRcjVCZzFmck13cE5KbVN4RklmR3dSZHRqbWh3?=
 =?utf-8?B?TzRPUkNieVlUc0E4eW4rQmJoTTV3NWVxSG1ienhkdFhHVTJXa2gzL2lsamlL?=
 =?utf-8?B?d1FoWTdqUHJ5SmVIR0NRRUt2WXpMTEFDQW53ei9VUTdvSjU1U05DZ1VGTTF1?=
 =?utf-8?B?cFIxM1M0ejNxNlozTzhNZVZqMmFHYUFpaTlvVG8rUlBGS2o5K1N2UjRFNTNZ?=
 =?utf-8?B?Z3hYUEpYWkQwaEExMTBEUStPUUlBS2RaYTYwVzFyb2JweDdEa1NXSlZZQjZt?=
 =?utf-8?B?R0dyeWN1WlMxNG83dWRQc2NaWDJ0Y2VnZThQL3lrb3FnMEZTektPdTdVOWpK?=
 =?utf-8?B?NmNtNEhqMEt1UnlZcFR1LzVxNUJJbGQ5NFgya2p5VURXZnROTHQxVGRIY2Nq?=
 =?utf-8?B?R0taOGZNeWY5c1NUaFFhQjc1TEVxRzIrc0lsYm5nRDVDdkxWaVN1UUsvbVZu?=
 =?utf-8?B?cGJwYWlrL2VSYncrbE9sL3lBellhT0tLNGUxWWtTcTdpZk9TdDdZNGtndUox?=
 =?utf-8?B?WXErRTlJQ0pCVUJqUzBCRWQzRWFJcGxEVUFaQUg3NG5TNG8rNjdCUlYyL2hT?=
 =?utf-8?B?d2VobUN2Y2ZhcjBEcmkrUjBzd0JUS1pwRFNFZkJxSmE4dlFWSlhSMUJKVkF4?=
 =?utf-8?B?cWJ3WnZQcnFZRGJrK2NTL0lkbnBnPT0=?=
X-OriginatorOrg: nutanix.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 805afa3f-f1a6-463e-f5dd-08ddf0404781
X-MS-Exchange-CrossTenant-AuthSource: PH0PR02MB7159.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 10 Sep 2025 08:01:42.7065 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: bb047546-786f-4de1-bd75-24e5b6f79043
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: gcsKTzYKEUVbBmVHVn3EZu0AJe2qUISjswDkVUvKVhcOrVaDxKdhiCCxyPl0cZ/8lwpYD11qs+QqqawjNMgF48eK+uHM400aPPoz8ZVnwys=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH0PR02MB7574
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwOTEwMDA3MiBTYWx0ZWRfXxpDCn5vgEjQK
 6wFKk1SiCXW/+LHQPavkRALkVFKVJxxZmORoU4Bs316CuUsCeXo0wsvkfC/E9eg4O6y/5bfS+HZ
 7YYXlZsAUtFoULtYrEJZmDIlgDouVJLRIBF7HhyhzgDul3ufSSNEgOBzSZ1tYGXIED6NO2nWGUP
 qMaNA4b6wYJQUS1VHG0jyV01Erkh9DgPsbmulkck+AuEIo4yAlruz7bdyk/TJWBbuIbjW0LmVyd
 tbkvMSeIuM6i2bcs55/kYw31zOr6Sj0qrbBJubZsqXA5byHofqtfO5bIjmIKrKb3D+radQzLgPE
 5p9hEipPxrvlbFNUDVo3aJRnFqF5vPGFBLGHZlyz/1Ch7+tM5+AkHKqpFs+WDw=
X-Proofpoint-GUID: eZpYarSTx95RXKha6GgdUgzAYdXgD7VU
X-Authority-Analysis: v=2.4 cv=MpJS63ae c=1 sm=1 tr=0 ts=68c13068 cx=c_pps
 a=a0OOicVJf4Rsx7t1FJu4FA==:117 a=6eWqkTHjU83fiwn7nKZWdM+Sl24=:19
 a=z/mQ4Ysz8XfWz/Q5cLBRGdckG28=:19 a=lCpzRmAYbLLaTzLvsPZ7Mbvzbb8=:19
 a=wKuvFiaSGQ0qltdbU6+NXLB8nM8=:19 a=Ol13hO9ccFRV9qXi2t6ftBPywas=:19
 a=xqWC_Br6kY4A:10 a=IkcTkHD0fZMA:10 a=yJojWOMRYYMA:10 a=0kUYKlekyDsA:10
 a=RpNjiQI2AAAA:8 a=p0WdMEafAAAA:8 a=20KFwNOVAAAA:8 a=T6wyQN5KTsjw67HM1rEA:9
 a=3ZKOabzyN94A:10 a=QEXdDO2ut3YA:10
X-Proofpoint-ORIG-GUID: eZpYarSTx95RXKha6GgdUgzAYdXgD7VU
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1117,Hydra:6.1.9,FMLib:17.12.80.40
 definitions=2025-09-09_03,2025-09-10_01,2025-03-28_01
X-Proofpoint-Spam-Reason: safe
Received-SPF: pass client-ip=148.163.151.68;
 envelope-from=mark.caveayland@nutanix.com; helo=mx0a-002c1b01.pphosted.com
X-Spam_score_int: -27
X-Spam_score: -2.8
X-Spam_bar: --
X-Spam_report: (-2.8 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_LOW=-0.7, RCVD_IN_MSPIKE_H2=0.001,
 RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001, RCVD_IN_VALIDITY_SAFE_BLOCKED=0.001,
 SPF_PASS=-0.001, T_SPF_HELO_TEMPERROR=0.01 autolearn=ham autolearn_force=no
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

On 10/09/2025 06:50, Thomas Huth wrote:

> On 12/05/2025 21.05, Paolo Bonzini wrote:
>> Now that we can do so after the error code has been pushed, raising
>> the #DB exception for task-switch traps is trivial.
>>
>> Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>
>> ---
>>   target/i386/tcg/seg_helper.c | 9 +++++----
>>   1 file changed, 5 insertions(+), 4 deletions(-)
>>
>> diff --git a/target/i386/tcg/seg_helper.c b/target/i386/tcg/seg_helper.c
>> index cb90ccd2adc..071f3fbd83d 100644
>> --- a/target/i386/tcg/seg_helper.c
>> +++ b/target/i386/tcg/seg_helper.c
>> @@ -473,10 +473,6 @@ static void switch_tss_ra(CPUX86State *env, int 
>> tss_selector,
>>           new_segs[R_GS] = 0;
>>           new_trap = 0;
>>       }
>> -    /* XXX: avoid a compiler warning, see
>> -     https://urldefense.proofpoint.com/v2/url? 
>> u=http-3A__support.amd.com_us_Processor-5FTechDocs_24593.pdf&d=DwICaQ&c=s883GpUCOChKOHiocYtGcg&r=c23RpsaH4D2MKyD3EPJTDa0BAxz6tV8aUJqVSoytEiY&m=ne1e2OYZDArdmBhjIXmv-d6hN8DFQV2i9elKEJJ2rgw_Rjs4bbFAj9BI-B8Y8SUa&s=Lx1uoh3Mv7iduPgFcshKa1nly0lcsCF6Z1G0neDOxQ4&e= -     chapters 12.2.5 and 13.2.4 on how to implement TSS Trap bit */
>> -    (void)new_trap;
>>       /* clear busy bit (it is restartable) */
>>       if (source == SWITCH_TSS_JMP || source == SWITCH_TSS_IRET) {
>> @@ -622,6 +618,11 @@ static void switch_tss_ra(CPUX86State *env, int 
>> tss_selector,
>>           }
>>           SET_ESP(sa.sp, sa.sp_mask);
>>       }
>> +
>> +    if (new_trap) {
>> +        env->dr[6] |= DR6_BT;
>> +        raise_exception_ra(env, EXCP01_DB, retaddr);
>> +    }
>>   }
> 
>   Hi Paolo,
> 
> as already quickly mentioned in IRC, the kvm-unit-tests CI had a 
> regression after homebrew updated its QEMU from 10.0 to 10.1, the 
> "eventinj" and the "taskwitch" test started failing:
> 
> 10.0:  https://urldefense.proofpoint.com/v2/url? 
> u=https-3A__gitlab.com_kvm-2Dunit-2Dtests_kvm-2Dunit-2Dtests_-2D_jobs_10871048973&d=DwICaQ&c=s883GpUCOChKOHiocYtGcg&r=c23RpsaH4D2MKyD3EPJTDa0BAxz6tV8aUJqVSoytEiY&m=ne1e2OYZDArdmBhjIXmv-d6hN8DFQV2i9elKEJJ2rgw_Rjs4bbFAj9BI-B8Y8SUa&s=2-qwz0tlJsb4ChkM4ZqunWv6Bmf3Zri5BDO1guawTyc&e= 10.1:  https://urldefense.proofpoint.com/v2/url?u=https-3A__gitlab.com_kvm-2Dunit-2Dtests_kvm-2Dunit-2Dtests_-2D_jobs_11282832498&d=DwICaQ&c=s883GpUCOChKOHiocYtGcg&r=c23RpsaH4D2MKyD3EPJTDa0BAxz6tV8aUJqVSoytEiY&m=ne1e2OYZDArdmBhjIXmv-d6hN8DFQV2i9elKEJJ2rgw_Rjs4bbFAj9BI-B8Y8SUa&s=U7Y_mIKPuJtmnCc5eDadnSt1qVAWtKHPBqnXRrPcG1s&e=
> I've now bisected the problem (painfully in the terminal window of the 
> cirrus-ci), and it seems to be this commit here that is causing the issue:
> 
>   ad441b8b7913a26b18edbc076c74ca0cdbfa4ee5 is the first bad commit
>   commit ad441b8b7913a26b18edbc076c74ca0cdbfa4ee5
>   Author: Paolo Bonzini <pbonzini@redhat.com>
>   Date:   Wed Aug 14 12:33:02 2024 +0200
> 
>       target/i386: implement TSS trap bit
> 
> Could you please have a look?
> 
>   Thanks,
>    Thomas

Possibly related: https://gitlab.com/qemu-project/qemu/-/issues/3101? 
The submitter has also provided a suggested patch.


ATB,

Mark.


