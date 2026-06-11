Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9E647CD98CE
	for <qemu-devel@archiver.kernel.org>; Thu, 11 Jun 2026 14:05:01 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wXg0n-0006Il-HD; Thu, 11 Jun 2026 10:04:01 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mark.caveayland@nutanix.com>)
 id 1wXg0j-0006Hx-CZ; Thu, 11 Jun 2026 10:03:57 -0400
Received: from mx0b-002c1b01.pphosted.com ([148.163.155.12])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mark.caveayland@nutanix.com>)
 id 1wXg0h-0000gt-0Q; Thu, 11 Jun 2026 10:03:56 -0400
Received: from pps.filterd (m0127844.ppops.net [127.0.0.1])
 by mx0b-002c1b01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 65BCXPnU3994205; Thu, 11 Jun 2026 07:03:48 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nutanix.com; h=
 cc:content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=
 proofpoint20171006; bh=grgbi8O9LJkGzdJk8JS1FCJq1Slp1vzRzLtwsr2Lw
 fc=; b=KUCW8Qi9WXyWNwp9VpJV3l2J/DPHUiHR2+HCqPMytaz0kFAyeNASd+ACB
 cgp64wapE6+u1BiJ0s0Jb9k2LET/HTup8JVpbx8MaPjYPTzUKEmr8+iHIObjN3pd
 Os0agFS5xo7sV8Esk0U3W+SyraQAjPeFReuCr4/SECPMYhnW1hrSfb1vGfHabbG1
 5WmipchsiudJGPv7FeesQKdbQQv116qB7rIl/+kTglDCCRqAw8ma5yLCNQcuZZ69
 NVu4dhU2lrd4wDsQ3IrWkhdJasFRd0925nanSISdVnlE4gKzwK6ycSOjJFI4AFvv
 snKux4xdta3z+m3RElEiZKDdcHoWA==
Received: from bn8pr05cu002.outbound.protection.outlook.com
 (mail-eastus2azon11021121.outbound.protection.outlook.com [52.101.57.121])
 by mx0b-002c1b01.pphosted.com (PPS) with ESMTPS id 4eqe5k29q2-1
 (version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NOT);
 Thu, 11 Jun 2026 07:03:48 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=polDedS2ewj9TQfJTYMP305c9MCAx1zS6IbkLPp0sBPQhQ7CCSZdd9WxZR5Zo/SWLHfqQAd1GU/l9+62KbH7qPBQEoIQSuFsEz6YLsHc3LGmElXuMPWb4Yfy3Jnx9Z5rR/4fFhFp/rB+tzcl1AAKInHIv65xpvwWuCP+amym244/3jZWvkSUxXItEWZu17a4e6CQjNJmG2bS81w9cUr2569HY1HWZz4FJVP8e8jXbOYagJ01EVQL/i4sroAp6PipNfrPHZVKAL/MaJ5lqNA55Ax1BG9dGy6vhpX66WfhzWOU0ZfxYB51n47e/hjCK+9eHbO66WTPororwOCFUA71Ow==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=grgbi8O9LJkGzdJk8JS1FCJq1Slp1vzRzLtwsr2Lwfc=;
 b=kSXcQ4KEhyx6fsxUxjTXC5iPkwzvuxWsP71Q3//WKvw6Eq7mkINmsU7EvdEUdQ+QUiZKlL9c/1Bq5XG8iDJzlabdVi79D25LA5S8ap5S4e54dAn5NfttjWBH96QodoTsojTW/14uL8pcGd5zEa7LcISR62MLuCaL4+Sf1BGPbUn/BTySxcQnZ+xxqUfu2O3ARX9Blx7WwFI1gpY37GD39WpIH8X8HXl71+hxoBGkod19h6u8mBsTh39Ib7dujONsn3Cb8z2RqFU+lodII1kGd/f8PgnS87l+2y4vggR8XnMDwogkRNyeCkinhH7y0wTnlDWI2Q5BCTrRdjBX3VzGUg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nutanix.com; dmarc=pass action=none header.from=nutanix.com;
 dkim=pass header.d=nutanix.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nutanix.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=grgbi8O9LJkGzdJk8JS1FCJq1Slp1vzRzLtwsr2Lwfc=;
 b=F5jTiPi4qjxPScDeJ86Rk3tA4sLywfI9F1Z2GBClL1yZSe+6l6pBEM3x8SWj20x9rAk5D4Asl6zq6PO+agGL+aqHx5gSx+IZcHUzumynthNInNXnfFmruCHjyzuflX5KGmQC32wMOnIvaZ4OBvKbUkufH1GZEDlHWOZOn5J0Z1fvMU8eihkXzIPTnQyRMxFVMs/d1gN3y9HXwlCW2pRCrk9Gb1gqUcSa2lWLCbiLGEtfLzA/ipkcLVceO+o1S9Yw83lJm6ahRqWudLUego7RCpDktOcyza8VJggPbUq9t5ONxVWdJYDC14f/yi1BxO/ks30Xlromtlekmg2gjZ/W8w==
Received: from PH0PR02MB7159.namprd02.prod.outlook.com (2603:10b6:510:16::8)
 by MW4PR02MB7265.namprd02.prod.outlook.com (2603:10b6:303:7f::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.92.17; Thu, 11 Jun
 2026 14:03:46 +0000
Received: from PH0PR02MB7159.namprd02.prod.outlook.com
 ([fe80::8e97:bc32:822c:b250]) by PH0PR02MB7159.namprd02.prod.outlook.com
 ([fe80::8e97:bc32:822c:b250%3]) with mapi id 15.21.0113.013; Thu, 11 Jun 2026
 14:03:46 +0000
Message-ID: <dac87bca-5556-4636-8e39-a180031a4fb7@nutanix.com>
Date: Thu, 11 Jun 2026 15:03:39 +0100
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 08/10] qom: Add object_property_add_*_ptr_def()
To: Peter Xu <peterx@redhat.com>, qemu-devel@nongnu.org
Cc: qemu-arm@nongnu.org, =?UTF-8?Q?C=C3=A9dric_Le_Goater?= <clg@redhat.com>,
 =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@mailo.com>,
 =?UTF-8?Q?Daniel_P_=2E_Berrang=C3=A9?= <berrange@redhat.com>,
 Fabiano Rosas <farosas@suse.de>,
 Vladimir Sementsov-Ogievskiy <vsementsov@yandex-team.ru>,
 Peter Maydell <peter.maydell@linaro.org>,
 "Dr . David Alan Gilbert" <dave@treblig.org>, Eric Blake
 <eblake@redhat.com>, Akihiko Odaki <odaki@rsg.ci.i.u-tokyo.ac.jp>,
 Paolo Bonzini <pbonzini@redhat.com>, Kevin Wolf <kwolf@redhat.com>,
 Sana Sharma <sansshar@redhat.com>,
 =?UTF-8?Q?Marc-Andr=C3=A9_Lureau?= <marcandre.lureau@redhat.com>,
 Juraj Marcin <jmarcin@redhat.com>, qemu-rust@nongnu.org,
 Markus Armbruster <armbru@redhat.com>
References: <20260609172514.2037645-1-peterx@redhat.com>
 <20260609172514.2037645-9-peterx@redhat.com>
Content-Language: en-US
From: Mark Cave-Ayland <mark.caveayland@nutanix.com>
In-Reply-To: <20260609172514.2037645-9-peterx@redhat.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: CY5PR15CA0142.namprd15.prod.outlook.com
 (2603:10b6:930:67::8) To PH0PR02MB7159.namprd02.prod.outlook.com
 (2603:10b6:510:16::8)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH0PR02MB7159:EE_|MW4PR02MB7265:EE_
X-MS-Office365-Filtering-Correlation-Id: 303700b5-4725-49fd-5f62-08dec7c24129
x-proofpoint-crosstenant: true
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|23010399003|366016|1800799024|376014|7416014|4143699003|56012099006|5023799004|18002099003|6133799003|22082099003;
X-Microsoft-Antispam-Message-Info: 9d5rHjTSABjD70d1E3UVqT6ZhgjB74GeIUC01+h7l9u8v3K8Q6LF4c/tkiIuq3XS3pn+CYzaaodkeH6MLqyyJ+iGQylH7rf595RikRhPrDPTjuwdICFaeUUcQYoTGl7MH7UIROJO0cywWnI4n3IQ2ZQ8Un5akSKHRXSCZfUtnyJLDmd1ZirI1IaWqs6YeoGhgZR3v/KoZYNc+oRAjSLEn9Jk2TYa84mrTWcRLrkfc7200Vg/fAvLOaF+JlbXNg1ZjoluoQR5vy9JLD07tbI4DmCmX6cOyPDFj+b8WFVq8J73hvgbMKKYqrUMgUNwo/MqIoj4rE6gfiqPcImPnany0RiP+1YVNYHeeO0t9Bp8Zr1Cu+2/zkCPI8JrSMOsNep9f5AFpAtJvaYry9/VZcUzz0La3bjcNKfrHt0kLo3v3X0AAZ1pWKI7vrsR5leCJrOBkY94IskmPsKPalRXZ2+a4pGK7UcGbaqqt9xx//ybFylBNN9FbK7uI1SZ+vuIlnFqmA6yxLyiEuasDDHASmwfLwsUr+31o9mvJAZBXXYgNHE3vvD49j7r4S5GDP9yeJ4nf4khaayhkf0OQ+UbVK6hmfbdWTRs348x1Jr2NVxPZlBUgwpqTT2UAXZcVFRo5oSP/i3c5pXdOin3sNholQi523OGx285CvLBDreDD3BNxk8MQe+4EFWSiP9FIx5htGzW
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:PH0PR02MB7159.namprd02.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(23010399003)(366016)(1800799024)(376014)(7416014)(4143699003)(56012099006)(5023799004)(18002099003)(6133799003)(22082099003);
 DIR:OUT; SFP:1102; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?WFNzL3BHT3ViRjZCTEFDVGhCNzRLTlVnZm9BQ1FmT2E4SHlVSnpRdmhCKzcz?=
 =?utf-8?B?aXZkNVpxblJrRjhseHdVdEhMVUxRTU84Sm8yVlA4d3R2Y1hXd2ZDM2pBUGp1?=
 =?utf-8?B?Qzg5WEYrWE55cDlRNUtZcGZqL3V2QWtUZWJsL21GRnQ1NGZxN2w5OGZEdmx3?=
 =?utf-8?B?cURGZ3hTUzI1ZnF6STdCb2oyZVBGUytuVE0zV0VQYzRqNE0zenFMbEFkVVRt?=
 =?utf-8?B?bUE3S29IZXl6SmZpOWFGdmd0MHFpQTI5bEQxTU84aVVxZmJKVGxiS2VwK1Ux?=
 =?utf-8?B?eS9yS2tsQkF3REVMV3ZLUXprekx1NXJWVGdrYStJVnRHVDlRb3FjTVc1K3Nw?=
 =?utf-8?B?eTNYRXIzZnA5NlVnR1FnZ2tzYTlVRjl1VUtxMGdYNDF2bHNqZzRXVjFKdGpW?=
 =?utf-8?B?VmNmenRaSHZzZ2R1VDVzcUxRYmFJOGxLMnBtWldZTTZmakJyenBvM0JXR21W?=
 =?utf-8?B?S2xuMnBXMllBMFhZQVBMeURERGZlUFFSaDBZcGxob2RiaUM1dEtaQXo4U09y?=
 =?utf-8?B?bDhZbkg0dlBpQ0llSVdSVHhUWjdsZkRLOFJ1bnhsd1hjY2I3ZkZtMGNudDNV?=
 =?utf-8?B?eDZ0QjlQN29oUGlhL1RpL2FaVGxWcDRvRWJvcnZ0UGJ3RmRESG5pQklMR2Z5?=
 =?utf-8?B?d3I1YWxDRytScnllejdnZVBSNWg5aHlUL0JPNTFteXlkNEMzRFBCUHplOGJh?=
 =?utf-8?B?R0M2YkdVNE5uKzNFKzdHS0ZRQllnc1RPOG5iMitMUjM2a3gvcy9laGFBbC9C?=
 =?utf-8?B?ZVVEMTdmSm1aNjNWUFNzZVFvc1NoN1hidlZMVnh4UTFOR004aEt3c1BDbEpm?=
 =?utf-8?B?VVI5TSt4MVNEYVFjTktKUEVyTEZuVU1UZFlFeEM0VE5VZkJZUDhucFNqNFdO?=
 =?utf-8?B?VVk1eHJHaGlLdVRkUW9naHZxOEVaRzllVmFZWmJwRFFvRzQ1TVNyellJV0RM?=
 =?utf-8?B?RnNEU3B5T2ErczJUeUFXa2U5UTBNWkRiOVFudTQxREZWa3ZJWnkyejhPYkhz?=
 =?utf-8?B?WWdzdlFIaCs0NkttUTRxdDBGRVFDTWJJbCtOU0E0RVZHT0tETWo3QWZCRVZk?=
 =?utf-8?B?S1JrY0lmM3pZRytZTXZZdVp5UzRRZjNkaVZONklWbVU4enVtWGZOWkxZbW96?=
 =?utf-8?B?K0IrV1FDdlFyVUZHQzNyM05EajhpZEduMmY4L1N5cGpJZWNvb1dMUnU3L3Fz?=
 =?utf-8?B?NldTZDgzNmR3b0FTNGRwV3pST2pZN3E3a3V5b2RFY3FoUUYrSXVheGRSNytL?=
 =?utf-8?B?TVRSNFVVbDFDb2M5TmdzY1BXUEFTcXYrM2VlUDNhblJiZnpWTGlKd1ErOTAy?=
 =?utf-8?B?RDZVUyszRlhYNTZvaGszYnk1RERTWkxrb1pnZitiZDdqM0ZhYUh1TVArNFA1?=
 =?utf-8?B?ZmJUd3JMVHhIV2ozcW0ya0NRUEJxbmtqWk8ySmNIVk1hNFpCK0wzYTBoT3Rt?=
 =?utf-8?B?azFzeCtIMnFFMWtkWkYxYklpc090cWkvRlQrUzNIOUpJNFA1a0d6UFgwK29Y?=
 =?utf-8?B?dEhGS20vTjRnNllSazFrTzZ4eU9qMWprTUR5Q2k3SFJlcW50SUpvRjlpa09Q?=
 =?utf-8?B?V2hoZE9YUEw2SHFmaitHWW9wTTFobkQ1UlJIdllVZkIwOWliQ2JJS255N0Vq?=
 =?utf-8?B?SzFrSDlFWE1VMFNBeVBwMXRiSnNuRnI1QmdYaEpDNUtGVnI3S3dKSDZYSERU?=
 =?utf-8?B?NlpnTUZOTlJxNmZLcHFpMk9semhsenczWnRQSU9ieVNxNXdvQUxqNERCdXNM?=
 =?utf-8?B?VDZtUHNRSWs3SHJRUXRMcWRMN2YyT2hYWUZCQmk1UHd1VmFaTXNkWDFCamZx?=
 =?utf-8?B?MHhobGZGNlo2SE1PbGphaUF4Q3Y3QXRxQ1ZVcFR3aWp3NVR2WGFxVnhWdHJZ?=
 =?utf-8?B?c3BZWHphRFB6VDNaQWdKZThqOUxUMHhoTDFhU2FwQkpIZk1tYUlscmxKRW5J?=
 =?utf-8?B?QURxbjdQemFQVldLYVkwQzJiUHF3VEVsMGRWNGhENzZNTm9yNHh3QmdIMDdX?=
 =?utf-8?B?eGc5V1FjYllsbVF0MzBDSTBENG1zMDJMWDFBZ3UwS0JOSC9ubnlaUlJ5cUhU?=
 =?utf-8?B?SHowbGN0d3pNb204eitjTXd0K3A1Ri9DL1h0aUc5citGdldmNzRKYXhjU2p4?=
 =?utf-8?B?Z2kwdVo3SzNFeDdlS3NQRFBMSnl3Z0Jub2l2WGJBQ1JxTTBzTkp3S1VJYUdj?=
 =?utf-8?B?NkR2Qm43SHNOa21FQjVrVmlzd1M4U2lrNkZDbkN5dUhqdWR5SFVYMURRaGMw?=
 =?utf-8?B?algyZS9xUDZaNWpUbUtobFFFUm53KzdidVM2QjM4RDhBOXZJcEVycEJVYk9H?=
 =?utf-8?B?aTNUc3hZTWpVelBrVUVXaHZyUGwvWmIvTXVGRDh1R3B3UWt0N2I4ZzFGb0t3?=
 =?utf-8?Q?eDohpgW6q5ek8q+0=3D?=
X-Exchange-RoutingPolicyChecked: az8EDLHAZg/nNnp+GB6jA5c0EonaFtxYugPjgeN193jxa+AKtfIQhRiafImUQKQh5X3Gqh5Mdi02ZCmvfchFP7oki4d+LWx1qr4r2YFZNDueeq4xrgc9trM3KozByzZ16KEGWZDW1x0QapYF8oXoWeJq7afTLY1h08JdrPxvi7y5kRQgmJJ0Sfrli5ji0DGOAQLJDnn/r6E/lWdbcSCasUP53cqEAJCIsqr2+3CmoH3fyggVkeql/NMACH2UeKp0h8KK/YxEG7Zh0HxArtwB7vY2Xh+ZHdVYSfvjcVlT9XscsbgXs5ds1art8cthLNaRaXo+HjW9r/Zr7Uel2YDLNQ==
X-OriginatorOrg: nutanix.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 303700b5-4725-49fd-5f62-08dec7c24129
X-MS-Exchange-CrossTenant-AuthSource: PH0PR02MB7159.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 11 Jun 2026 14:03:46.6182 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: bb047546-786f-4de1-bd75-24e5b6f79043
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 9etDcAtUqdh7Pq0qjWlQUOcA0HRfQniUt6cBG3ukekOsaEAE4L3qTrtNePpFxKzCgKiHmM9wqt4NOEhmHZkYe7jmyOYWIo8g9pzhyaay0YU=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MW4PR02MB7265
X-Authority-Analysis: v=2.4 cv=cqOrVV4i c=1 sm=1 tr=0 ts=6a2ac044 cx=c_pps
 a=twImIRnwXVHz+pcTAbAWxA==:117 a=6eWqkTHjU83fiwn7nKZWdM+Sl24=:19
 a=z/mQ4Ysz8XfWz/Q5cLBRGdckG28=:19 a=lCpzRmAYbLLaTzLvsPZ7Mbvzbb8=:19
 a=xqWC_Br6kY4A:10 a=IkcTkHD0fZMA:10 a=FelO9ux0wxsA:10 a=0kUYKlekyDsA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=VofLwUrZ8Iiv6rRUPXIb:22 a=0LlEyIVc8U2lsR7dKhuH:22
 a=20KFwNOVAAAA:8 a=jRQY__-s_naQPixS0osA:9 a=QEXdDO2ut3YA:10
X-Proofpoint-ORIG-GUID: 3Ul8j8iuNEyAjCfTbHXtTOTQUN2qdhe_
X-Proofpoint-GUID: 3Ul8j8iuNEyAjCfTbHXtTOTQUN2qdhe_
X-Proofpoint-Spam-Info: AW1haW4tMjYwNjExMDE0MSBTYWx0ZWRfX+w8famW1VKWC
 qXtpSrz5ag41wwq6keafW9PjrxQ2NpBXecccZCzLb05S/hq4p5ObBoCYWmiPdVQCnGG5krPF9DA
 CVkxjBYCkK2e+YGD1qVbmuv1tVapm5A=
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNjExMDE0MSBTYWx0ZWRfX1beCAt4A2t8T
 DOLVFApLJXC7shvhke077WI1PBLckHLKVVhPMnh/8lCJlOg6bGGRI8iX7l5u8h6aa5j6XXMPWA5
 mZ1BJulCUW1pHW1NnDq1/fez0qSDfgPDXMTDOtk+HeI6CBwCb0vM3fi5OETPo6JROnoe9y0tNMS
 WniLad+tDHqTvHxqM+CLWwn2ZhQUlENlIbgTQkA1QVHENxIiHXMct9tuobWMsuOjKhed36F+TQH
 HZrWZX88ewnikmpB/FnVtRVIjbHrBOqawnf+ppK65F5BKeEB/EL6pA+JMiyge+mKFFuomS4A4mS
 kNoXJ/JkNmsmBmlHrCdijXvTfzMu6DK5KUJdX4nrdi/68wVJv+nPdLA+aH07R0bVj79ry/4ZOgY
 TYMZDZhvJQFL416FKiXD6423vZqtgRsaG4MTdbei9iCIXyz7ejfamopBhCGiZBnLxKbZ4y8JiAi
 KVLBvXdTdEtb/wSuovA==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.125,FMLib:17.12.100.49
 definitions=2026-06-11_02,2026-06-11_01,2025-10-01_01
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

On 09/06/2026 18:25, Peter Xu wrote:

> Add sister functions for existing pointer versions, to make it even easier
> to use by:
> 
> - always make properties to be rw-able
> - allowing to specify default values
> - no retcode needed (assert on failure, always)
> 
> Signed-off-by: Peter Xu <peterx@redhat.com>
> ---
>   include/qom/object-property-ptr.h | 28 +++++++++++++
>   qom/object-property-ptr.c         | 67 +++++++++++++++++++++++++++++++
>   2 files changed, 95 insertions(+)
> 
> diff --git a/include/qom/object-property-ptr.h b/include/qom/object-property-ptr.h
> index be467c64af..ecd6f7819b 100644
> --- a/include/qom/object-property-ptr.h
> +++ b/include/qom/object-property-ptr.h
> @@ -131,4 +131,32 @@ object_property_add_size_ptr(Object *obj, const char *name,
>                                const uint64_t *v,
>                                ObjectPropertyFlags flags);
>   
> +/*
> + * Below are sister helpers of above, except that:
> + *
> + * (1) nothing is returned
> + * (2) always make the property to be both readable and writeable
> + * (3) allow setting default value
> + *
> + * Please refer to the sister functions for the documentation.
> + */
> +void
> +object_property_add_bool_ptr_def(Object *obj, const char *name,
> +                                 const bool *v, bool def);
> +void
> +object_property_add_uint8_ptr_def(Object *obj, const char *name,
> +                                  const uint8_t *v, uint8_t def);
> +void
> +object_property_add_uint16_ptr_def(Object *obj, const char *name,
> +                                   const uint16_t *v, uint16_t def);
> +void
> +object_property_add_uint32_ptr_def(Object *obj, const char *name,
> +                                   const uint32_t *v, uint32_t def);
> +void
> +object_property_add_uint64_ptr_def(Object *obj, const char *name,
> +                                   const uint64_t *v, uint64_t def);
> +void
> +object_property_add_size_ptr_def(Object *obj, const char *name,
> +                                 const uint64_t *v, uint64_t def);
> +
>   #endif
> diff --git a/qom/object-property-ptr.c b/qom/object-property-ptr.c
> index 21ceb2510d..ae9081d2d8 100644
> --- a/qom/object-property-ptr.c
> +++ b/qom/object-property-ptr.c
> @@ -325,3 +325,70 @@ object_property_add_size_ptr(Object *obj, const char *name,
>       return object_property_add(obj, name, "size",
>                                  getter, setter, NULL, (void *)v);
>   }
> +
> +void
> +object_property_add_bool_ptr_def(Object *obj, const char *name,
> +                                 const bool *v, bool def)
> +{
> +    ObjectProperty *prop;
> +
> +    prop = object_property_add_bool_ptr(obj, name, v,
> +                                        OBJ_PROP_FLAG_READWRITE);
> +    object_property_set_default_bool(prop, def);
> +}
> +
> +
> +void
> +object_property_add_uint8_ptr_def(Object *obj, const char *name,
> +                                  const uint8_t *v, uint8_t def)
> +{
> +    ObjectProperty *prop;
> +
> +    prop = object_property_add_uint8_ptr(obj, name, v,
> +                                         OBJ_PROP_FLAG_READWRITE);
> +    object_property_set_default_uint(prop, def);
> +}
> +
> +void
> +object_property_add_uint16_ptr_def(Object *obj, const char *name,
> +                                   const uint16_t *v, uint16_t def)
> +{
> +    ObjectProperty *prop;
> +
> +    prop = object_property_add_uint16_ptr(obj, name, v,
> +                                          OBJ_PROP_FLAG_READWRITE);
> +    object_property_set_default_uint(prop, def);
> +}
> +
> +void
> +object_property_add_uint32_ptr_def(Object *obj, const char *name,
> +                                   const uint32_t *v, uint32_t def)
> +{
> +    ObjectProperty *prop;
> +
> +    prop = object_property_add_uint32_ptr(obj, name, v,
> +                                          OBJ_PROP_FLAG_READWRITE);
> +    object_property_set_default_uint(prop, def);
> +}
> +
> +void
> +object_property_add_uint64_ptr_def(Object *obj, const char *name,
> +                                   const uint64_t *v, uint64_t def)
> +{
> +    ObjectProperty *prop;
> +
> +    prop = object_property_add_uint64_ptr(obj, name, v,
> +                                          OBJ_PROP_FLAG_READWRITE);
> +    object_property_set_default_uint(prop, def);
> +}
> +
> +void
> +object_property_add_size_ptr_def(Object *obj, const char *name,
> +                                 const uint64_t *v, uint64_t def)
> +{
> +    ObjectProperty *prop;
> +
> +    prop = object_property_add_size_ptr(obj, name, v,
> +                                        OBJ_PROP_FLAG_READWRITE);
> +    object_property_set_default_uint(prop, def);
> +}

Would these ever be required outside of the migration logic? I'm 
wondering if it might make sense to use macros within the migration code 
instead. This would at least prevent them from leaking elsewhere into 
QEMU until we figure out a long-term strategy.


ATB,

Mark.


