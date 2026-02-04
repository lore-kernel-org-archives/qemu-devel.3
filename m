Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2D008E9537B
	for <qemu-devel@archiver.kernel.org>; Wed,  4 Feb 2026 11:45:14 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vnbJj-00012C-72; Wed, 04 Feb 2026 06:45:07 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mark.caveayland@nutanix.com>)
 id 1vnbJg-00010Z-Ic
 for qemu-devel@nongnu.org; Wed, 04 Feb 2026 06:45:04 -0500
Received: from mx0b-002c1b01.pphosted.com ([148.163.155.12])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mark.caveayland@nutanix.com>)
 id 1vnbJd-0003mP-PJ
 for qemu-devel@nongnu.org; Wed, 04 Feb 2026 06:45:04 -0500
Received: from pps.filterd (m0127841.ppops.net [127.0.0.1])
 by mx0b-002c1b01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 6145rq5C3065620; Wed, 4 Feb 2026 03:45:00 -0800
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nutanix.com; h=
 cc:content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=
 proofpoint20171006; bh=PpT2ibuznURktXR66V670r325sa8oYKvvUleK8sA0
 +o=; b=CzXOBUQu6gr1CKMHCY6S2bKN3jUEv/72HdywtCj9PtyhV2iOvz+90XjYH
 nblbNhf2oetSt3pwJNpv3tuHVzoaMwasbx5zgvTwph+BpKHeO3df7U36jO6qPdPX
 yH90cgogipIt/EWqVU1/J+wBXzXIjlKiB0xQYLPJ0p3IEkfOkaKGFEOzy/SWwVHY
 ovF/jSBNVX8ITV9K+kfMmyLsHWyltapgCWyfHI+VMrUFArsqB8wk4WaNnollQuEY
 SCtahSzwtoWpJOtIs4CR4kcbIyyrhSkvhlYJEaEwNvXKBCoNCS1aTBB3ewSot9K8
 b7yJbKEXikKwp/akk8LkRxskSC3nw==
Received: from bn1pr04cu002.outbound.protection.outlook.com
 (mail-eastus2azon11020133.outbound.protection.outlook.com [52.101.56.133])
 by mx0b-002c1b01.pphosted.com (PPS) with ESMTPS id 4c3aydkwkq-1
 (version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NOT);
 Wed, 04 Feb 2026 03:44:59 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=V7+qPVmERgNWm5uGlhOo0OVy6PIS4HjpOegf0+lYyW6V+0h8VOcRy0uRCzb2CyuhnQkZw78TAuoZ24ZBaMf5NPP7y4UZpqLr435IK5T8h0XUpd4LqbIPWrzlmbmpL/zpnCw+ehGxs5dANNRk3WnYKGvSYpRI7J/pI+wOR/duvUuM1cD3UluJ1Lip2KpHGCtOBwjLItWbrcQ3d7JY5P76J1zxoUozX+Nl2guqkR9lry+GNMzD5PdK5tq9j0Uss05hXFvJSUbLcCujWazmJsGT+OXBnPE6JgUykaKnfUELefz9P9kt3kyDTe6r2mT++UOrueZFktdsemzhKPyL5Ei25w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=PpT2ibuznURktXR66V670r325sa8oYKvvUleK8sA0+o=;
 b=PTf2AsbzcmjX4rJX6MZ5TQh8CVGPyEJ6Kt3jbNFsLZ9vZqTgVOY8r40Pdkfo0n/pnyqa1ECQv7XDWUCbxhjKSosu8jwamnJ9X7sVR76oK0B08mb37/K2z/VlRuebjA5phSKp2+IyHI9m74YcSLj9C6PBCJvaXsG8CAj5dmyMsb/BO7lQ9crpReAYkuwyTSqZEndXl61LDOGAFoWL5fJNyEUqDXcxq+RKxfgrguMLGmtgTeqwA3lXitCzy7V8x9p/C3hdONop30NiXOjTm2xZz2oM4gcFJjy3FZnCeDNfAd4WRzzgMjNcjx2K8zoCjTek54ual/8ikKnIF/o1zcNWvg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nutanix.com; dmarc=pass action=none header.from=nutanix.com;
 dkim=pass header.d=nutanix.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nutanix.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=PpT2ibuznURktXR66V670r325sa8oYKvvUleK8sA0+o=;
 b=ONxF+HuA36hQXQi7DUTVyxZly78IeiaeBe0+0T7LQeZ5pmjcuV7HB/wQ4PnwvGQPpsfEcWHYV77ru17yC8U50PVgZVMnnYKl+yhyLz/H1CYvy2xKIpDZkXftpSTZOPF1HqXNghLNEacg1B8IEtmoXvXtGnGDw5fdr5wNdRt0ivRH8XahbYQMz/Mya8JnKMvDwk8OzH25BuD/VamO3Nn5pdE0F2l+Ebivabu6HWgmG72JDrodDN+pGuWkak7Lh/GZb9N7FOrlj78EY19MFrQ9JLCpB2EN9RYCmbeOf0yBfsLjx9TYj7XWgvUM0kC97yJ55JNDL7euVd6kg/4inzB+jw==
Received: from PH0PR02MB7159.namprd02.prod.outlook.com (2603:10b6:510:16::8)
 by DS7PR02MB10889.namprd02.prod.outlook.com (2603:10b6:8:269::22) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9542.12; Wed, 4 Feb
 2026 11:44:58 +0000
Received: from PH0PR02MB7159.namprd02.prod.outlook.com
 ([fe80::8e97:bc32:822c:b250]) by PH0PR02MB7159.namprd02.prod.outlook.com
 ([fe80::8e97:bc32:822c:b250%6]) with mapi id 15.20.9587.010; Wed, 4 Feb 2026
 11:44:58 +0000
Message-ID: <25242772-cfec-44b6-b4b8-bd4f9eff52ac@nutanix.com>
Date: Wed, 4 Feb 2026 11:44:55 +0000
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 32/37] audio: split AudioBackend
To: marcandre.lureau@redhat.com, qemu-devel@nongnu.org
Cc: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Gerd Hoffmann <kraxel@redhat.com>
References: <20260123074945.2563196-1-marcandre.lureau@redhat.com>
 <20260123074945.2563196-33-marcandre.lureau@redhat.com>
Content-Language: en-US
From: Mark Cave-Ayland <mark.caveayland@nutanix.com>
In-Reply-To: <20260123074945.2563196-33-marcandre.lureau@redhat.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: SA9PR10CA0021.namprd10.prod.outlook.com
 (2603:10b6:806:a7::26) To PH0PR02MB7159.namprd02.prod.outlook.com
 (2603:10b6:510:16::8)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH0PR02MB7159:EE_|DS7PR02MB10889:EE_
X-MS-Office365-Filtering-Correlation-Id: 75858e08-0d75-4a22-9ca4-08de63e2d2c1
x-proofpoint-crosstenant: true
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|366016|1800799024|376014|7053199007;
X-Microsoft-Antispam-Message-Info: =?utf-8?B?YjZiVFMxU2d5c2c1VTRCRXEvM3QzaDk0UXlLTERiU2VRSWZZV0tMZnByQTFi?=
 =?utf-8?B?VlpubGZNMFE0STdEWGN5b2c5SGxsS05rODcxQWZsQVdXR1BZdGlZenBvZ3ZS?=
 =?utf-8?B?Y3lnVTU5bU8zSUxLclI0dmJQdnVodXEwL09Rb3ZNTzNRYTlWMWN1UFliMUQ4?=
 =?utf-8?B?TVdVTWxBbUZzd3h6UXJwVE0wTkJDS1hIM0c3VngrakFqMXNKVU5WdzJMQWlh?=
 =?utf-8?B?T1ZpMTAxZVUxZjBYYWFQWDhlMTNsaTRqdXNTNENBaEx0U0laOFVMRDFzSHYx?=
 =?utf-8?B?OFFYR3VaRjRGTkVLVTl1eXdGTmFNLytGZkJpRUlHVU54TXo0dDl2WC84MlN1?=
 =?utf-8?B?WWRlMVhsZGtRNFBNbFkwejlKZ1RnYnFQTXFVSmZSTDBwZ2FqRDBaeGR5K1Ex?=
 =?utf-8?B?RmcyQ2FtV0pWd1J1S0pOU20ycTZ4cjJtazZORFk5ZGZHMTM0dUJjR2svb3o3?=
 =?utf-8?B?YVJwbEF1ZU5UZFN0clVXdE5QcCtjY09tRG9CUVBMMmZRMVowclpQaHJvRU1x?=
 =?utf-8?B?Z1pJd294RWF0SjRoTWNYc0xGTFVabE0zUGZQVGlNMXJMby8wVmxVdU44cnNB?=
 =?utf-8?B?VThkVmhFcG1qQUJKVnE0eUpuRG9QU2wrVGFrODRPU2tvK3h3di9ITzYzNFh6?=
 =?utf-8?B?OFY3VFRKNjQwSDhCWUtlR1doaHhZZ0tnZWJ6Y2xHOTg3Rndhb3dEYjZFUWFw?=
 =?utf-8?B?QUsxMlF2RHhmVUt6TmdtMG5XL2hxbkY3QTNDWnFLdkZBMjFvNDlURUxqd1g1?=
 =?utf-8?B?MkNrK3Y5R1VwakttYlZFb0F2LytXc0Q5RTRodGhnb25VaHRqald0YVVSc2NK?=
 =?utf-8?B?d2cxYmdzRkFTOVhLWUFqOEl1WlhmSjV2SXdTODFxd1grSlBrbHRTbTNOVFdt?=
 =?utf-8?B?K3BnMXRoNldtWEg5b1BtUW5ueVhKbTVkL2EzL1NHK1dNWFBRNlBtZXRQMWo1?=
 =?utf-8?B?QUFCV3psNEhnaXg5Nnl4Q2pUc0pSZXEyZkttcXhMNkFWR1l1NVl2b2NKKzl6?=
 =?utf-8?B?RmhaQ08veGVITW5uUjU2Ti9XMmJkVmgwemV2NFYwbVJQUFZEd1NwaWxNeTNB?=
 =?utf-8?B?WkVHME15RVlYTWRGZlc2d0lxem40VXRKbVJNZEQ3WVlzcUNHUmJwSE5JcWhn?=
 =?utf-8?B?TVJzNVl1ckpyc1lrT2xmWXlKR0FqaHAxME5aRWlzT1lUU251RjhReG5rRDdv?=
 =?utf-8?B?QW4rNG9waThvdHlnbENSNkkrcTRIRG9QSU1hNWNSVFFNb0hzWXNSc2hMRUd3?=
 =?utf-8?B?NjkyZy9CR3NNWFFyME1sd05adUlORzVBL0ZmSExnUGhOaDZJUnJqWXg2K3E3?=
 =?utf-8?B?UEFKbzd2UHA4REdEeTlsWHFFWEV5L2hSeW1zM3lTNWNzcEFYWE9LUXh4QnJK?=
 =?utf-8?B?bGlSd3BaZUV0MmZWMEI4T2FOeFREY3VlL3J4QUJIQ3BpMG16Y1d6U2dGVWt6?=
 =?utf-8?B?MnlRYU10ZGlTamFML0E2S1IybVAzYUpEZ21LOGIwalJhWU9qSFJqeU4xTTlJ?=
 =?utf-8?B?QXRPS014QVVmYjlQNFZEN0RPZzhFcXFRRzJ4djg0T3FoQ3lFUFl0ajlDTjFF?=
 =?utf-8?B?QUc0d3pDU2dBaldSbWs0YU5FQkdFbGU4SmdOVnk4b3BHMGRnVUVoeXlCQ3BT?=
 =?utf-8?B?ZjVaUXRGYktKVHQrS0tqVEJYN0VtY0lmcTVZWUNyR1pPMnBnOUl3M2l5eVl1?=
 =?utf-8?B?TU9FU2JkWWhmdDZtMGlnM0YrZGhtNUFkTENNOWNQR2R5Y1JNMXduZ3V2a1JT?=
 =?utf-8?B?d0p4b2JQM2xTQnRob3FwUktRNW1DVk90dHIzanZKWU0xak9IU1dQWHhxUHFU?=
 =?utf-8?B?RmNZNTVHaHZRelM2OVk1aXlPTVNvaUlkQXRWVStjOHpwbEowOFZhMTZvMFlP?=
 =?utf-8?B?dzFWOHpmZ1gxWVIvYXVnU2ZOME9ETk5sQjZJOGtSZzlqWlpYMi9rU0U1dVpy?=
 =?utf-8?B?ZUJsT1RBbmtBd3pGN2hLZFpqUWdnUCtWeThJY1AwY25VVTBWd2RVSW5MYlRj?=
 =?utf-8?B?TFBJc0dkbGVxbWN3Ym9zK1Y0MXRHOFZabE9wSnhrbDNjbThMQ1dUemlMcnNO?=
 =?utf-8?B?ZVFIYUVUSGVSQ0ZlWC83akZDRENTMUV3TkF5SUFMMGNPdkNyUjM4Nkk0Qzlm?=
 =?utf-8?Q?j0Lk=3D?=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:PH0PR02MB7159.namprd02.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(366016)(1800799024)(376014)(7053199007); DIR:OUT; SFP:1102; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?OVAzYWcrcUNpa0F3OVd0TVZBZ2p6eVFvOFJkMFg4aXBCbVRjMUNDOTYvQnBD?=
 =?utf-8?B?cUwxM1F2UzVwNng5dnRsaWNnWS85dnhBWHZDcDZZQ1JWUVFVKzJqaUd3VXFn?=
 =?utf-8?B?TjIwbENLVUZPNlUxa0xSUjQvTktaVUZtU0t5ak9jbld6bzh4a1JQNmk4Vjdt?=
 =?utf-8?B?WURQUXAyOTJWTWpjWklrK0UrNTVQM0NtbEVvQTZaNC9FK1ZTaTlsWUVJd3cx?=
 =?utf-8?B?ZUN6d1VocTNOZDRQc3RDR2x5V2UyZGVoclhnUjhnQ0Z1NG1WeGJEbXlWZUlM?=
 =?utf-8?B?SGtJdW41RU5BMlJscmtzZktkNVFtQkc5NnFObk1UVzVuR2tPWlBWTXdpSm9s?=
 =?utf-8?B?TGtPTEhJeEc4L1IwMWpiTWwwR0tjL3d1RnB3ejJaZ3FmWTM4aHhYMXFUY1dC?=
 =?utf-8?B?ZDFKRDJMUkgwc3JuODBmUmFaNnFYRDgvdnVkdTdKdzZGMFhoRDROcmUxYmx3?=
 =?utf-8?B?a2RjQnc1YXhPTmZHMnVsVWNrWGVPdVM2eXluNDFuMmhlZmtsY2lyT29VSFMx?=
 =?utf-8?B?Q25QbEF0dFVzRVFHZUp6aU4vWVJSbGlBSnM4UWlXZVJQU1JKaEsxcGhtM2p0?=
 =?utf-8?B?SVM3MGtIUzF3SmJDb0NXeDlCZmswb0xzejlGMEF5eFNEUWVjcVpCSzVjcDk1?=
 =?utf-8?B?RWdFdVgrZy9iVnk3K2prUng0by82TndqWnhVdTM4djFWNExmZjNGQUd2OUVK?=
 =?utf-8?B?ZjFtWFFacTdQZXBzSDYvcDEwblRaN0ZxMStYVzIzMkhwQWp4MmhXRUd2Rnlx?=
 =?utf-8?B?Nk1ZTWkvcGU2dU5BQzZzWTdGS1QzTFpOM3lSTk8vZ2tOWHlkc0F4eTZhamRC?=
 =?utf-8?B?cFlRV05OdGo3YTNtKzEvRVRLU1FlNGMzbmxuOVo5N0owUXkwZkdGWDRiUitU?=
 =?utf-8?B?QjRLQXNBLzZmUDRiQW1oY3JvWjMxRHVKajdHbW1wZ3V3MUp2c0EvSm9tckFv?=
 =?utf-8?B?WDZYeVdWMy9xQXpFRDFvVXN1MTQ0ZktMeEVuY2tleC9CdStoaFpxOERoaEdH?=
 =?utf-8?B?djBTenA1SmpEdmpPWHRpdmE5SS9CdCtrZGtKek1QbnRybm9WNjJkeHg3TUx5?=
 =?utf-8?B?OXpqOVNtaVdmTUdQS2MrbDloZFEwNG82MXFhb3RxbTBoUEtvQlI4eTJWYmJt?=
 =?utf-8?B?QnhBcmZFMnpXRUhuWDhXQUtJOWVWdlN5Kys1VHpjN3EyUHZYejhBVUZDVy9o?=
 =?utf-8?B?OEE4UG1mU1BxR0dMb1VHV2tNcEcvbCt6bk9Nd3NsMWR1UFpVMHF0aVNJZVRu?=
 =?utf-8?B?eUxHUjYza3EwcEIxeHhZTlpQTjJDdlNJWThwK2YzUG54dUU2RWRrZzRwanlp?=
 =?utf-8?B?bkdScU1lT1ZUZFRPbXpRMVdVVXBaVUx5QitRcWgxVG93RXVUSDdkV1Y4QlhH?=
 =?utf-8?B?Z2FjRWFXbmd6T3JzOVl2emF6UHkvcnMrVnRGRitjMWs1VkZOdVNwZGszYlRy?=
 =?utf-8?B?eFRKTmhYMEZLNUIrMGhEMTVVazN6SlJQdGU0Nm50NHc1YTVVb0p5NXJUNVAz?=
 =?utf-8?B?dWZ0R1hBZkgwLzV5V1pPb08xcU81d2NjSmEyTXFsSXdQNG55RlAzRHNNb2Y1?=
 =?utf-8?B?aW5nQTRkMk8ySmZRNElrNlkrZnZvcmlOZmdYc1lUcm9Ra0pMYlBjUjdTWmsr?=
 =?utf-8?B?OXFHdzE5TGprK0tZQWJEUnlwTWZFYXd4WG5VMjBMSVZVVUQ3MDQ4TlhaeGNM?=
 =?utf-8?B?MkNBWGh2emVjNU5OSG1VNjkyMkQ2Syt4YngxRzBzaEh6cS9iK0xJcmNDSnlQ?=
 =?utf-8?B?RnNxWk1jTm9WNmduVVQ0N0xzendlV2FXUnFDY0tOZDJjRUs1bHl1bzZiLzdN?=
 =?utf-8?B?bHR3Qm5STENVb1gvVWY5SDBqVExQZFZlb05nVHo1UTl6ZmxUaEhyWlI1SEtM?=
 =?utf-8?B?eXpVTkdsMldhbTRyYzdhSXhxQjkxOWxIN3FMR2JENTlpZ3d5MzNNbVQzdkR1?=
 =?utf-8?B?VHcwaUVWV05YcGVGUzhrOVptb1VmNFBLQjhxV0VpaDh1YVBTZEJkTE5pejJG?=
 =?utf-8?B?RklLSDZGUUZWMlRmYUxVM0JtcktycWl0d1RKeDRnVjR1aHZsS0dKTXZod3VU?=
 =?utf-8?B?ZzRDY2JVdU5VdDA2U3Y3aGJJZ1Z1TEpqKzJWYkRLbUJIaVVEY2tYRFNRZTlw?=
 =?utf-8?B?d3VMY3FnZ1hnYk5TdXlTVHREdzhpbVV3TEZSQzhWYXMvUzllVklHcmdFczFQ?=
 =?utf-8?B?YTI5WldkOEZIWkxXVFBoOEdnaWd1SlpnbVliTE1RMWN2WktnNTV1bm10dkE1?=
 =?utf-8?B?bTg1RTlDdmtkQnV6bklQdXFNMXJGTGdBTDZwVmRLdUt5bTJ2bXRFTGIzZm05?=
 =?utf-8?B?dE92a1dHV1NpdkhwMmNwYkROQ0lqeE52N0FiZFFIS2NPNlJlVzUrZlNMMDg2?=
 =?utf-8?Q?YSfGe4GUydP6Hraw=3D?=
X-OriginatorOrg: nutanix.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 75858e08-0d75-4a22-9ca4-08de63e2d2c1
X-MS-Exchange-CrossTenant-AuthSource: PH0PR02MB7159.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 04 Feb 2026 11:44:58.3722 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: bb047546-786f-4de1-bd75-24e5b6f79043
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: s+pAGRqKjkXpGLHnvr0qVIH0zgw9Rftji6cMaDggmeurdJruQouTanFBTctDiByQmsKwlDfEPSxKwPulShlMvT+4sseFsxy8KarnYpogubg=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS7PR02MB10889
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwMjA0MDA4OSBTYWx0ZWRfX+TDAj7xOQGUX
 Ogr6j0Lf7OuSjaRjHo05HLifiFGNmF8ZIyWhOwfTO6HsPDhf/55fHfVDgwdfGqgcLbR47znFD4E
 ImqTX59Heg9YpBvyITaV6bpLVlhoLpYCHRiCnu8/TNxarBWCt7/tvbRhjarj6JORnzjCIUxgST4
 SeC/x4/oL4NfNBTT1a1vuLSeLx2Svbki9WrAgzoIMa4xMjf0YzPGQmfG3QrQ5TaV+i1ZjSMIOPZ
 qnbdXFZSrBgIEavkSoM7Iwnk8Vc+8fUh+G854w77bC1rMRLSsQUybcbWUMewNsIQryUtMNeaByW
 u2Wd9KlYzDduo5CnTvxcPVJSXTkvgKnmsLqWpyrjLvHPCOlxwil5dNrePYSjS19Ml7fR1raCV45
 4xMk6T71PJxOSPNwh6crzjMlu4ZM3TWRwQSINOQG6HOSG6NHYLs8K/8QBmHFdx/XGtWik9bU00O
 o6+Y9wkKR3AOuVLxTyQ==
X-Proofpoint-GUID: M70dT1UFBJfuXdd2_eDlX3NmYeZ7BaTc
X-Proofpoint-ORIG-GUID: M70dT1UFBJfuXdd2_eDlX3NmYeZ7BaTc
X-Authority-Analysis: v=2.4 cv=AeC83nXG c=1 sm=1 tr=0 ts=6983313b cx=c_pps
 a=q7ul7JX4f8a5wKXmg0eXeg==:117 a=6eWqkTHjU83fiwn7nKZWdM+Sl24=:19
 a=z/mQ4Ysz8XfWz/Q5cLBRGdckG28=:19 a=lCpzRmAYbLLaTzLvsPZ7Mbvzbb8=:19
 a=xqWC_Br6kY4A:10 a=IkcTkHD0fZMA:10 a=HzLeVaNsDn8A:10 a=0kUYKlekyDsA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=20KFwNOVAAAA:8 a=64Cc0HZtAAAA:8
 a=M1NGqRFELoHMNm0iuuoA:9 a=3ZKOabzyN94A:10 a=QEXdDO2ut3YA:10
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
> Code clean-up, to allow building bare abstract class separately.
> 
> The original file is MIT-licensed.
> 
> Signed-off-by: Marc-André Lureau <marcandre.lureau@redhat.com>
> ---
>   include/qemu/audio.h |   2 +
>   audio/audio-be.c     | 210 ++++++++++++++++++++++++++++++++++++++++++
>   audio/audio.c        | 211 +------------------------------------------
>   audio/meson.build    |   1 +
>   4 files changed, 215 insertions(+), 209 deletions(-)
>   create mode 100644 audio/audio-be.c
> 
> diff --git a/include/qemu/audio.h b/include/qemu/audio.h
> index 4fae48886ba..9f85c6316a8 100644
> --- a/include/qemu/audio.h
> +++ b/include/qemu/audio.h
> @@ -111,6 +111,8 @@ typedef struct AudioBackendClass {
>   
>   bool AUD_backend_check(AudioBackend **be, Error **errp);
>   
> +AudioBackend *audio_be_new(Audiodev *dev, Error **errp);
> +
>   SWVoiceOut *AUD_open_out(
>       AudioBackend *be,
>       SWVoiceOut *sw,
> diff --git a/audio/audio-be.c b/audio/audio-be.c
> new file mode 100644
> index 00000000000..8154727dbfb
> --- /dev/null
> +++ b/audio/audio-be.c
> @@ -0,0 +1,210 @@
> +/* SPDX-License-Identifier: MIT */
> +
> +#include "qemu/osdep.h"
> +#include "qemu/audio.h"
> +#include "qemu/audio-capture.h"
> +#include "qapi/error.h"
> +
> +bool AUD_backend_check(AudioBackend **be, Error **errp)
> +{
> +    assert(be != NULL);
> +
> +    if (!*be) {
> +        *be = audio_get_default_audio_be(errp);
> +        if (!*be) {
> +            return false;
> +        }
> +    }
> +
> +    return true;
> +}
> +
> +SWVoiceIn *AUD_open_in(
> +    AudioBackend *be,
> +    SWVoiceIn *sw,
> +    const char *name,
> +    void *callback_opaque,
> +    audio_callback_fn callback_fn,
> +    const struct audsettings *as)
> +{
> +    AudioBackendClass *klass = AUDIO_BACKEND_GET_CLASS(be);
> +
> +    return klass->open_in(be, sw, name, callback_opaque, callback_fn, as);
> +}
> +
> +SWVoiceOut *AUD_open_out(
> +    AudioBackend *be,
> +    SWVoiceOut *sw,
> +    const char *name,
> +    void *callback_opaque,
> +    audio_callback_fn callback_fn,
> +    const struct audsettings *as)
> +{
> +    AudioBackendClass *klass = AUDIO_BACKEND_GET_CLASS(be);
> +
> +    return klass->open_out(be, sw, name, callback_opaque, callback_fn, as);
> +}
> +
> +void AUD_close_out(AudioBackend *be, SWVoiceOut *sw)
> +{
> +    AudioBackendClass *klass = AUDIO_BACKEND_GET_CLASS(be);
> +
> +    return klass->close_out(be, sw);
> +}
> +
> +void AUD_close_in(AudioBackend *be, SWVoiceIn *sw)
> +{
> +    AudioBackendClass *klass = AUDIO_BACKEND_GET_CLASS(be);
> +
> +    return klass->close_in(be, sw);
> +}
> +
> +bool AUD_is_active_out(AudioBackend *be, SWVoiceOut *sw)
> +{
> +    AudioBackendClass *klass = AUDIO_BACKEND_GET_CLASS(be);
> +
> +    return klass->is_active_out(be, sw);
> +}
> +
> +bool AUD_is_active_in(AudioBackend *be, SWVoiceIn *sw)
> +{
> +    AudioBackendClass *klass = AUDIO_BACKEND_GET_CLASS(be);
> +
> +    return klass->is_active_in(be, sw);
> +}
> +
> +size_t AUD_write(AudioBackend *be, SWVoiceOut *sw, void *buf, size_t size)
> +{
> +    AudioBackendClass *klass = AUDIO_BACKEND_GET_CLASS(be);
> +
> +    return klass->write(be, sw, buf, size);
> +}
> +
> +size_t AUD_read(AudioBackend *be, SWVoiceIn *sw, void *buf, size_t size)
> +{
> +    AudioBackendClass *klass = AUDIO_BACKEND_GET_CLASS(be);
> +
> +    return klass->read(be, sw, buf, size);
> +}
> +
> +int AUD_get_buffer_size_out(AudioBackend *be, SWVoiceOut *sw)
> +{
> +    AudioBackendClass *klass = AUDIO_BACKEND_GET_CLASS(be);
> +
> +    return klass->get_buffer_size_out(be, sw);
> +}
> +
> +void AUD_set_active_out(AudioBackend *be, SWVoiceOut *sw, bool on)
> +{
> +    AudioBackendClass *klass = AUDIO_BACKEND_GET_CLASS(be);
> +
> +    return klass->set_active_out(be, sw, on);
> +}
> +
> +void AUD_set_active_in(AudioBackend *be, SWVoiceIn *sw, bool on)
> +{
> +    AudioBackendClass *klass = AUDIO_BACKEND_GET_CLASS(be);
> +
> +    return klass->set_active_in(be, sw, on);
> +}
> +
> +void AUD_set_volume_out(AudioBackend *be, SWVoiceOut *sw, Volume *vol)
> +{
> +    AudioBackendClass *klass = AUDIO_BACKEND_GET_CLASS(be);
> +
> +    klass->set_volume_out(be, sw, vol);
> +}
> +
> +void AUD_set_volume_in(AudioBackend *be, SWVoiceIn *sw, Volume *vol)
> +{
> +    AudioBackendClass *klass = AUDIO_BACKEND_GET_CLASS(be);
> +
> +    klass->set_volume_in(be, sw, vol);
> +}
> +
> +CaptureVoiceOut *AUD_add_capture(
> +    AudioBackend *be,
> +    struct audsettings *as,
> +    struct audio_capture_ops *ops,
> +    void *cb_opaque)
> +{
> +    AudioBackendClass *klass = AUDIO_BACKEND_GET_CLASS(be);
> +
> +    return klass->add_capture(be, as, ops, cb_opaque);
> +}
> +
> +void AUD_del_capture(AudioBackend *be, CaptureVoiceOut *cap, void *cb_opaque)
> +{
> +    AudioBackendClass *klass = AUDIO_BACKEND_GET_CLASS(be);
> +
> +    klass->del_capture(be, cap, cb_opaque);
> +}
> +
> +#ifdef CONFIG_GIO
> +bool audio_be_can_set_dbus_server(AudioBackend *be)
> +{
> +    AudioBackendClass *klass = AUDIO_BACKEND_GET_CLASS(be);
> +
> +    return klass->set_dbus_server != NULL;
> +}
> +
> +bool audio_be_set_dbus_server(AudioBackend *be,
> +                              GDBusObjectManagerServer *server,
> +                              bool p2p,
> +                              Error **errp)
> +{
> +    AudioBackendClass *klass = AUDIO_BACKEND_GET_CLASS(be);
> +
> +    if (!audio_be_can_set_dbus_server(be)) {
> +        error_setg(errp, "Audiodev '%s' is not compatible with DBus",
> +                   audio_be_get_id(be));
> +        return false;
> +    }
> +
> +    return klass->set_dbus_server(be, server, p2p, errp);
> +}
> +#endif
> +
> +const char *audio_be_get_id(AudioBackend *be)
> +{
> +    if (be) {
> +        return AUDIO_BACKEND_GET_CLASS(be)->get_id(be);
> +    } else {
> +        return "";
> +    }
> +}
> +
> +AudioBackend *audio_be_new(Audiodev *dev, Error **errp)
> +{
> +    const char *drvname = AudiodevDriver_str(dev->driver);
> +    g_autofree char *type = g_strconcat("audio-", drvname, NULL);
> +    AudioBackend *be = AUDIO_BACKEND(object_new(type));
> +
> +    if (!be) {
> +        error_setg(errp, "Unknown audio driver `%s'", drvname);
> +        return NULL;
> +    }
> +
> +    if (!AUDIO_BACKEND_GET_CLASS(be)->realize(be, dev, errp)) {
> +        object_unref(OBJECT(be));
> +        return NULL;
> +    }
> +
> +    return be;
> +}
> +
> +
> +static const TypeInfo audio_be_info = {
> +    .name = TYPE_AUDIO_BACKEND,
> +    .parent = TYPE_OBJECT,
> +    .instance_size = sizeof(AudioBackend),
> +    .abstract = true,
> +    .class_size = sizeof(AudioBackendClass),
> +};
> +
> +static void register_types(void)
> +{
> +    type_register_static(&audio_be_info);
> +}
> +
> +type_init(register_types);
> diff --git a/audio/audio.c b/audio/audio.c
> index 3f09452e300..1d948084e80 100644
> --- a/audio/audio.c
> +++ b/audio/audio.c
> @@ -869,15 +869,8 @@ static size_t audio_mixeng_backend_write(AudioBackend *be, SWVoiceOut *sw,
>       }
>   }
>   
> -size_t AUD_write(AudioBackend *be, SWVoiceOut *sw, void *buf, size_t size)
> -{
> -    AudioBackendClass *klass = AUDIO_BACKEND_GET_CLASS(be);
> -
> -    return klass->write(be, sw, buf, size);
> -}
> -
> -static size_t audio_mixeng_backend_read(AudioBackend *be, SWVoiceIn *sw,
> -                                        void *buf, size_t size)
> +static size_t audio_mixeng_backend_read(AudioBackend *be,
> +                                        SWVoiceIn *sw, void *buf, size_t size)
>   {
>       HWVoiceIn *hw;
>   
> @@ -900,13 +893,6 @@ static size_t audio_mixeng_backend_read(AudioBackend *be, SWVoiceIn *sw,
>   
>   }
>   
> -size_t AUD_read(AudioBackend *be, SWVoiceIn *sw, void *buf, size_t size)
> -{
> -    AudioBackendClass *klass = AUDIO_BACKEND_GET_CLASS(be);
> -
> -    return klass->read(be, sw, buf, size);
> -}
> -
>   static int audio_mixeng_backend_get_buffer_size_out(AudioBackend *be, SWVoiceOut *sw)
>   {
>       if (!sw) {
> @@ -920,13 +906,6 @@ static int audio_mixeng_backend_get_buffer_size_out(AudioBackend *be, SWVoiceOut
>       return sw->hw->samples * sw->hw->info.bytes_per_frame;
>   }
>   
> -int AUD_get_buffer_size_out(AudioBackend *be, SWVoiceOut *sw)
> -{
> -    AudioBackendClass *klass = AUDIO_BACKEND_GET_CLASS(be);
> -
> -    return klass->get_buffer_size_out(be, sw);
> -}
> -
>   static void audio_mixeng_backend_set_active_out(AudioBackend *be, SWVoiceOut *sw,
>                                                   bool on)
>   {
> @@ -977,13 +956,6 @@ static void audio_mixeng_backend_set_active_out(AudioBackend *be, SWVoiceOut *sw
>   
>   }
>   
> -void AUD_set_active_out(AudioBackend *be, SWVoiceOut *sw, bool on)
> -{
> -    AudioBackendClass *klass = AUDIO_BACKEND_GET_CLASS(be);
> -
> -    return klass->set_active_out(be, sw, on);
> -}
> -
>   static void audio_mixeng_backend_set_active_in(AudioBackend *be, SWVoiceIn *sw, bool on)
>   {
>       HWVoiceIn *hw;
> @@ -1029,13 +1001,6 @@ static void audio_mixeng_backend_set_active_in(AudioBackend *be, SWVoiceIn *sw,
>       }
>   }
>   
> -void AUD_set_active_in(AudioBackend *be, SWVoiceIn *sw, bool on)
> -{
> -    AudioBackendClass *klass = AUDIO_BACKEND_GET_CLASS(be);
> -
> -    return klass->set_active_in(be, sw, on);
> -}
> -
>   static size_t audio_get_avail(SWVoiceIn *sw)
>   {
>       size_t live;
> @@ -1642,25 +1607,6 @@ static bool audio_mixeng_backend_realize(AudioBackend *abe,
>       return true;
>   }
>   
> -static AudioBackend *audio_be_new(Audiodev *dev, Error **errp)
> -{
> -    const char *drvname = AudiodevDriver_str(dev->driver);
> -    g_autofree char *type = g_strconcat("audio-", drvname, NULL);
> -    AudioBackend *be = AUDIO_BACKEND(object_new(type));
> -
> -    if (!be) {
> -        error_setg(errp, "Unknown audio driver `%s'", drvname);
> -        return NULL;
> -    }
> -
> -    if (!AUDIO_BACKEND_GET_CLASS(be)->realize(be, dev, errp)) {
> -        object_unref(OBJECT(be));
> -        return NULL;
> -    }
> -
> -    return be;
> -}
> -
>   static void audio_vm_change_state_handler (void *opaque, bool running,
>                                              RunState state)
>   {
> @@ -1684,14 +1630,6 @@ static void audio_vm_change_state_handler (void *opaque, bool running,
>   
>   static const VMStateDescription vmstate_audio;
>   
> -static void audio_be_init(Object *obj)
> -{
> -}
> -
> -static void audio_be_finalize(Object *obj)
> -{
> -}
> -
>   static const char *audio_mixeng_backend_get_id(AudioBackend *be)
>   {
>       return AUDIO_MIXENG_BACKEND(be)->dev->id;
> @@ -1713,60 +1651,6 @@ static void audio_mixeng_backend_set_volume_out(AudioBackend *be, SWVoiceOut *sw
>   static void audio_mixeng_backend_set_volume_in(AudioBackend *be, SWVoiceIn *sw,
>                                                  Volume *vol);
>   
> -SWVoiceOut *AUD_open_out(
> -    AudioBackend *be,
> -    SWVoiceOut *sw,
> -    const char *name,
> -    void *callback_opaque,
> -    audio_callback_fn callback_fn,
> -    const struct audsettings *as)
> -{
> -    AudioBackendClass *klass = AUDIO_BACKEND_GET_CLASS(be);
> -
> -    return klass->open_out(be, sw, name, callback_opaque, callback_fn, as);
> -}
> -
> -SWVoiceIn *AUD_open_in(
> -    AudioBackend *be,
> -    SWVoiceIn *sw,
> -    const char *name,
> -    void *callback_opaque,
> -    audio_callback_fn callback_fn,
> -    const struct audsettings *as)
> -{
> -    AudioBackendClass *klass = AUDIO_BACKEND_GET_CLASS(be);
> -
> -    return klass->open_in(be, sw, name, callback_opaque, callback_fn, as);
> -}
> -
> -void AUD_close_out(AudioBackend *be, SWVoiceOut *sw)
> -{
> -    AudioBackendClass *klass = AUDIO_BACKEND_GET_CLASS(be);
> -
> -    return klass->close_out(be, sw);
> -}
> -
> -void AUD_close_in(AudioBackend *be, SWVoiceIn *sw)
> -{
> -    AudioBackendClass *klass = AUDIO_BACKEND_GET_CLASS(be);
> -
> -    return klass->close_in(be, sw);
> -}
> -
> -bool AUD_is_active_out(AudioBackend *be, SWVoiceOut *sw)
> -{
> -    AudioBackendClass *klass = AUDIO_BACKEND_GET_CLASS(be);
> -
> -    return klass->is_active_out(be, sw);
> -}
> -
> -bool AUD_is_active_in(AudioBackend *be, SWVoiceIn *sw)
> -{
> -    AudioBackendClass *klass = AUDIO_BACKEND_GET_CLASS(be);
> -
> -    return klass->is_active_in(be, sw);
> -}
> -
>   static void audio_mixeng_backend_class_init(ObjectClass *klass, const void *data)
>   {
>       AudioBackendClass *be = AUDIO_BACKEND_CLASS(klass);
> @@ -1971,20 +1855,6 @@ AudioBackend *audio_get_default_audio_be(Error **errp)
>       return default_audio_be;
>   }
>   
> -bool AUD_backend_check(AudioBackend **be, Error **errp)
> -{
> -    assert(be != NULL);
> -
> -    if (!*be) {
> -        *be = audio_get_default_audio_be(errp);
> -        if (!*be) {
> -            return false;
> -        }
> -    }
> -
> -    return true;
> -}
> -
>   static struct audio_pcm_ops capture_pcm_ops;
>   
>   static CaptureVoiceOut *audio_mixeng_backend_add_capture(
> @@ -2061,17 +1931,6 @@ static CaptureVoiceOut *audio_mixeng_backend_add_capture(
>       return cap;
>   }
>   
> -CaptureVoiceOut *AUD_add_capture(
> -    AudioBackend *be,
> -    struct audsettings *as,
> -    struct audio_capture_ops *ops,
> -    void *cb_opaque)
> -{
> -    AudioBackendClass *klass = AUDIO_BACKEND_GET_CLASS(be);
> -
> -    return klass->add_capture(be, as, ops, cb_opaque);
> -}
> -
>   static void audio_mixeng_backend_del_capture(
>       AudioBackend *be,
>       CaptureVoiceOut *cap,
> @@ -2114,13 +1973,6 @@ static void audio_mixeng_backend_del_capture(
>       }
>   }
>   
> -void AUD_del_capture(AudioBackend *be, CaptureVoiceOut *cap, void *cb_opaque)
> -{
> -    AudioBackendClass *klass = AUDIO_BACKEND_GET_CLASS(be);
> -
> -    klass->del_capture(be, cap, cb_opaque);
> -}
> -
>   static void audio_mixeng_backend_set_volume_out(AudioBackend *be, SWVoiceOut *sw,
>                                                   Volume *vol)
>   {
> @@ -2138,13 +1990,6 @@ static void audio_mixeng_backend_set_volume_out(AudioBackend *be, SWVoiceOut *sw
>       }
>   }
>   
> -void AUD_set_volume_out(AudioBackend *be, SWVoiceOut *sw, Volume *vol)
> -{
> -    AudioBackendClass *klass = AUDIO_BACKEND_GET_CLASS(be);
> -
> -    klass->set_volume_out(be, sw, vol);
> -}
> -
>   static void audio_mixeng_backend_set_volume_in(AudioBackend *be, SWVoiceIn *sw,
>                                                  Volume *vol)
>   {
> @@ -2162,13 +2007,6 @@ static void audio_mixeng_backend_set_volume_in(AudioBackend *be, SWVoiceIn *sw,
>       }
>   }
>   
> -void AUD_set_volume_in(AudioBackend *be, SWVoiceIn *sw, Volume *vol)
> -{
> -    AudioBackendClass *klass = AUDIO_BACKEND_GET_CLASS(be);
> -
> -    klass->set_volume_in(be, sw, vol);
> -}
> -
>   static void audio_create_pdos(Audiodev *dev)
>   {
>       switch (dev->driver) {
> @@ -2422,40 +2260,6 @@ AudioBackend *audio_be_by_name(const char *name, Error **errp)
>       }
>   }
>   
> -#ifdef CONFIG_GIO
> -bool audio_be_can_set_dbus_server(AudioBackend *be)
> -{
> -    AudioBackendClass *klass = AUDIO_BACKEND_GET_CLASS(be);
> -
> -    return klass->set_dbus_server != NULL;
> -}
> -
> -bool audio_be_set_dbus_server(AudioBackend *be,
> -                              GDBusObjectManagerServer *server,
> -                              bool p2p,
> -                              Error **errp)
> -{
> -    AudioBackendClass *klass = AUDIO_BACKEND_GET_CLASS(be);
> -
> -    if (!audio_be_can_set_dbus_server(be)) {
> -        error_setg(errp, "Audiodev '%s' is not compatible with DBus",
> -                   audio_be_get_id(be));
> -        return false;
> -    }
> -
> -    return klass->set_dbus_server(be, server, p2p, errp);
> -}
> -#endif
> -
> -const char *audio_be_get_id(AudioBackend *be)
> -{
> -    if (be) {
> -        return AUDIO_BACKEND_GET_CLASS(be)->get_id(be);
> -    } else {
> -        return "";
> -    }
> -}
> -
>   const char *audio_application_name(void)
>   {
>       const char *vm_name;
> @@ -2519,16 +2323,6 @@ AudiodevList *qmp_query_audiodevs(Error **errp)
>       return ret;
>   }
>   
> -static const TypeInfo audio_be_info = {
> -    .name = TYPE_AUDIO_BACKEND,
> -    .parent = TYPE_OBJECT,
> -    .instance_size = sizeof(AudioBackend),
> -    .instance_init = audio_be_init,
> -    .instance_finalize = audio_be_finalize,
> -    .abstract = true,
> -    .class_size = sizeof(AudioBackendClass),
> -};
> -
>   static const TypeInfo audio_mixeng_backend_info = {
>       .name = TYPE_AUDIO_MIXENG_BACKEND,
>       .parent = TYPE_AUDIO_BACKEND,
> @@ -2542,7 +2336,6 @@ static const TypeInfo audio_mixeng_backend_info = {
>   
>   static void register_types(void)
>   {
> -    type_register_static(&audio_be_info);
>       type_register_static(&audio_mixeng_backend_info);
>   }
>   
> diff --git a/audio/meson.build b/audio/meson.build
> index a5fec14fb3a..417670bd4c7 100644
> --- a/audio/meson.build
> +++ b/audio/meson.build
> @@ -1,6 +1,7 @@
>   audio_ss = ss.source_set()
>   audio_ss.add(files(
>     'audio.c',
> +  'audio-be.c',
>     'mixeng.c',
>     'noaudio.c',
>     'wavaudio.c',

Reviewed-by: Mark Cave-Ayland <mark.caveayland@nutanix.com>


ATB,

Mark.


