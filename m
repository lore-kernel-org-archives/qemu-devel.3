Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E101BCD98C5
	for <qemu-devel@archiver.kernel.org>; Mon, 15 Jun 2026 13:43:16 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wZ7aF-0002Nd-3D; Mon, 15 Jun 2026 09:42:35 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mark.caveayland@nutanix.com>)
 id 1wZ7aC-0002JH-HA; Mon, 15 Jun 2026 09:42:32 -0400
Received: from mx0a-002c1b01.pphosted.com ([148.163.151.68])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mark.caveayland@nutanix.com>)
 id 1wZ7a8-0008Rz-ME; Mon, 15 Jun 2026 09:42:31 -0400
Received: from pps.filterd (m0127839.ppops.net [127.0.0.1])
 by mx0a-002c1b01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 65FCbss73569705; Mon, 15 Jun 2026 06:42:18 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nutanix.com; h=
 cc:content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=
 proofpoint20171006; bh=SQwJv7GWXy29CkU52b6ao/DxCdXGP+uKnmZatevgk
 OE=; b=yVmuBYAFhLzqYsGxL7nJWJ4nQSm0wV+8B5l1fA6VDKZjbwDX/LIGM8b99
 MgNkKkZqCjFjsantx21qm/paSgX83VsTTL+ob7dMvHO+bePjwuQT+SNVOgy9pyyG
 LuwZL0usp1ZdOtepS9pAlGusZtxze/9ijnUyzVw/ZO8fJ55vhZl4H1QUbgh5y8Wg
 kKDOr5DdcPQcFsFhkSNqhMn6BDlfv2TSDQFWn6hdwYrLu+WKJ8erQzqWfxDkzHpp
 vFMnMzK0rpz+Ypt5kBlv9AGJh7pJXl2dHGRGFAYGAqp60KiotrqKPEkmuKwDmpIG
 qCEnVl7Ea1LIS+r+q8JNMgdL7ItsQ==
Received: from cy7pr03cu001.outbound.protection.outlook.com
 (mail-westcentralusazon11020085.outbound.protection.outlook.com
 [40.93.198.85])
 by mx0a-002c1b01.pphosted.com (PPS) with ESMTPS id 4es69cuukf-1
 (version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NOT);
 Mon, 15 Jun 2026 06:42:17 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=sNnfiO4MBVilyH9KZ2zkJJuEGtj0mq897TkaNVWNOO4xQRgqQjIv+hxIGtovnCDYiO2fKZW0YOWILdr8y3HoAz2JygiNu5vrzOwJHP0KmJWhVl33/tVvRwLuPcTfR91Xfiv1/qSPKw7P1hPPuVdqA+PAo5NjkIzCA8AibpQQAb2agRwAoQ76cTjF2CNC3trpM7PyHA6kHQe16ByWGfvXDgpnnYwGyT9I39eohTJVgGADzIm3By6lvFWRE/2P3ZWv0SEIwXspsn0TX4QKtPDY2cJX4Z5N9AZZ7y9uNOA7TX3bSALWcfRcjuPes4Tce/v0rCa71jdaW6KNTXZJEXOHLw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=SQwJv7GWXy29CkU52b6ao/DxCdXGP+uKnmZatevgkOE=;
 b=cFqRye/5CJTRun1AN6xDAHuooLRX1eyaJYKzy7HwJt4pjzOMNfptcK2u9DGwHceFpwbIqGzl4OMT6yQZIM8u3BjulIwQ8nkpQ8GAPb7UHVFiQ2fi9DCRrcnapCGpaHt4Oxyh8wWAGSps2vUBYBdtlUEWXYPgGEyrfGCgvxKQAvsnXDkX3H8QJPiPG0TwbsSIjpdNi6u6eAPZ2AxPM3ZsCg7Fkp6qbJK5Tkm+B1LHhrmegPGVKan/OPObAqhi8fmvgLUm6K0g6cgQUSdB89p5bswRyTOiDZKoWvs8M6EDX0X4cARw3aRdIGpSONolfnTw7SC5yJm122d61/UkNqOyYw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nutanix.com; dmarc=pass action=none header.from=nutanix.com;
 dkim=pass header.d=nutanix.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nutanix.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=SQwJv7GWXy29CkU52b6ao/DxCdXGP+uKnmZatevgkOE=;
 b=IGuOkLpeR1oQ0XxmYd5DfPPZ2m5ixTRjzyzEu0eDcKaqZldadO6KXx2PmIfWt4Zq1Mzy4JwKKuU85ved3OKwknaxQcc2PVJUddrcUJ/zgpxLKJYoTYKH1IfeSSDxpHo6vt/DT8oECNkRziPPfeU+95g33lWA91ox0bobmglYuwvGOdLFlrGZOBXdIT/ix+TUj31poyuTqOs/Bsgcc+aZdqI+4SnuDRC37Kc7tqA+MdFZDmk1mOi3d9ehTEG1K8yfX07GUt4D16xXIFkM+GdL7ePamLlaxJrTLQveYuRkXOhBlLn0h8M1r4tOxaZ0ctgCJpB0ZFfyCMHCl39dMJci7g==
Received: from PH0PR02MB7159.namprd02.prod.outlook.com (2603:10b6:510:16::8)
 by SJ2PR02MB9822.namprd02.prod.outlook.com (2603:10b6:a03:546::21) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.113.16; Mon, 15 Jun
 2026 13:42:15 +0000
Received: from PH0PR02MB7159.namprd02.prod.outlook.com
 ([fe80::8e97:bc32:822c:b250]) by PH0PR02MB7159.namprd02.prod.outlook.com
 ([fe80::8e97:bc32:822c:b250%3]) with mapi id 15.21.0113.015; Mon, 15 Jun 2026
 13:42:15 +0000
Message-ID: <acb64b89-2a5f-4f7c-b5c8-8c31667908c2@nutanix.com>
Date: Mon, 15 Jun 2026 14:42:10 +0100
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 2/2] qom: Manage references to embedded child objects
To: Peter Maydell <peter.maydell@linaro.org>,
 =?UTF-8?Q?Daniel_P=2E_Berrang=C3=A9?= <berrange@redhat.com>
Cc: Akihiko Odaki <odaki@rsg.ci.i.u-tokyo.ac.jp>, qemu-devel@nongnu.org,
 Paolo Bonzini <pbonzini@redhat.com>,
 Manos Pitsidianakis <manos.pitsidianakis@linaro.org>,
 qemu-rust@nongnu.org, Peter Xu <peterx@redhat.com>,
 =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@mailo.com>,
 Alberto Garcia <berto@igalia.com>, Kevin Wolf <kwolf@redhat.com>,
 Hanna Reitz <hreitz@redhat.com>, qemu-block@nongnu.org
References: <20260615-embedded-v1-0-bb0c65bf126c@rsg.ci.i.u-tokyo.ac.jp>
 <20260615-embedded-v1-2-bb0c65bf126c@rsg.ci.i.u-tokyo.ac.jp>
 <ai-z14dMCK33_pis@redhat.com>
 <CAFEAcA_nFiQyXyCuvwUrJ+-0fhmGoMfswK-+KsZbxahAGatTXw@mail.gmail.com>
 <ai-5M6FF7CoJc_re@redhat.com>
 <CAFEAcA_52oFGv7cC11jbpj9pwBq-x2O-R_aOGkYzaRWW7t-K2g@mail.gmail.com>
Content-Language: en-US
From: Mark Cave-Ayland <mark.caveayland@nutanix.com>
In-Reply-To: <CAFEAcA_52oFGv7cC11jbpj9pwBq-x2O-R_aOGkYzaRWW7t-K2g@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: CYXPR03CA0083.namprd03.prod.outlook.com
 (2603:10b6:930:d3::15) To PH0PR02MB7159.namprd02.prod.outlook.com
 (2603:10b6:510:16::8)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH0PR02MB7159:EE_|SJ2PR02MB9822:EE_
X-MS-Office365-Filtering-Correlation-Id: 50f378a2-77ac-45f7-adf7-08decae3e96f
x-proofpoint-crosstenant: true
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|366016|1800799024|376014|7416014|23010399003|18002099003|22082099003|4143699003|5023799004|56012099006;
X-Microsoft-Antispam-Message-Info: Ul68/CrRRQZL88aNoKqU6ufPgN7pwylxtwDyJMMH30EB6jrKPGHkliC8aDphNpDva1t0JbOw+eiE9V2nockvXPwpNpkNugAKHhldv4SOM/zcgnNIosvZj4VtiOzj1/JiON3eaHwZhKM7MaQpWVc4GNxgi1+1B21nuURwzdx6tgrq+ArrBbgopYT0WVvTzcMv8CMNGf3enWb0lDwI8EreaksJ8VOpbbVTiTSWWAkAGDo7U9i3+AOqcK27cthAFAGA+tW2deusgZn79AGfPxdq75Svd4gHFP910U0ZaHR3duZswhfYpKwVv2nvjv95SBi94B/3cQpZ6QnUVgwV4zROLl07yYL1CHVcDeqoVvCPTaqjvUqOV4DecI9itBb2jb5ibj+AfNpCtKIKqBdsHOMo3SNCRMk3dXR/iXK7ZYv7X0raaTxeY0U0htzBy3KTtyyYI4pAyAWDZZKA32XmQJAQH5PAt5H+PEYbGq0Riz0YFQoxyxzljNamq+2m/Wx43H8QS5ufxOhldfwOcTDfxRXnRV9KFeXyoEGgue07G+yTzyHycdJJCOfldGBz/exz6/fS6+L1aksKKtK2CApkLS5iZAXZGt64HONCMy4dsKOHX7Uuj2gW6D7IG15HSpiixw/j85vvaVkbAbLMruD3ijMPJ1lEPJA+MdFDrUSnvUIRm42SrTL1uKcI6ApLn1sSxzXK
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:PH0PR02MB7159.namprd02.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(366016)(1800799024)(376014)(7416014)(23010399003)(18002099003)(22082099003)(4143699003)(5023799004)(56012099006);
 DIR:OUT; SFP:1102; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?dHluZEpOeXFzM0JYQVdpREJWL3RUM05BZVBrckZtaFA5UzZOWnh6SFRBYVIr?=
 =?utf-8?B?eWJGM3lNMWlSVTJtN1NJQzZQWEJUd2J3RGJJRE5Pa1Q5RzlMaVI4ZnUwRHNE?=
 =?utf-8?B?RTA1RER2WEpNdlJlL2x4ZGllNkRBejVpN2xZcWdBNjlQdDVPRE9LR0NNQkJJ?=
 =?utf-8?B?RzQ1NGloNjdFa1RvZUpocXR2OEZ5QUZTcVFEZHlRMDdiT1hSZmtUWDVDMmlO?=
 =?utf-8?B?Q1hXUThQbTg1M05KMENvRUtVOTQ1ZDdWTWRWNlBxQXk4b2pvZGZidHZEVWpq?=
 =?utf-8?B?TjRXdlFSanRzNnZ2d29ZYmJaRllnajJTSWtLZ0JyRUN0VUMrQ1FZNnpXN2Qr?=
 =?utf-8?B?TWo5K0VaVFRCREt1d09nUG1LY2tmYVE0eEE0UUZIeVJWOU41dk9KSGdnc0lm?=
 =?utf-8?B?dGtQS1FheERGNUdSUTJKS0F0cVhnOUxiWTBjcEw1Rzg5cU1LMzlpY085WDBo?=
 =?utf-8?B?VzZOWWxMMWtmZzdNeUpUT2pYWXJENmRYczJwWEVuc3BlSzQ1Zzk4bE05Ymli?=
 =?utf-8?B?WmZQMWRFYnVtSjVNZjBnVlVUNVAzREkrVEVKWTQ0Z0YwZWp5MlM1cUlRd3hT?=
 =?utf-8?B?eEczMkZGWHFVRWJ4eWhPbGh3ajh4RnlEWWwyNTdjd3JLbHpkb0F2dVlyWlRu?=
 =?utf-8?B?ZkhNQy9sdHdGckh2bHZBSlRjRFA1K2FDRWo3RTN2RUdrRGYrUzJUbUNRVXdW?=
 =?utf-8?B?UlM1bzQxKytnRjIvQTcyV1NaNkw3alRYWTNYb1J5RHJCYTZXWUFSaEdtYlY5?=
 =?utf-8?B?Z1VudXhWbS9BOFNpZDFJdENGQjQyc2VTbTU0cmRkWjFFWUsyMUVCZDgxMHhJ?=
 =?utf-8?B?c0M5R0xKVXVYajl1RXgzY3RjaFU4M0JrMEd6ZEQ4Ky9tY1QxZTdVVmFPOHBk?=
 =?utf-8?B?UXJPSE5IT2FzNTJYYUYrM1VESEVmNURjZlM3VXZKOXZWbHRQK20vUmc1c20r?=
 =?utf-8?B?M2dRbElzalhXNHYyeThPYVJUcWtwUlJLMW10bFAvVDVCRU1IL0lOR2RhTklJ?=
 =?utf-8?B?VzBZeVIweHJ3TEYrMVFVL3YxSUlhQVZOdHphTXk3T0tvRE5Gb01pSFZ1WVdm?=
 =?utf-8?B?WXZUMFBIWXdyS21xTmdmWWp1VDF6d0tiY3Y2Snp1Z1U2Ly92aXBMSFBEVzkx?=
 =?utf-8?B?WGUzMlJMcmVjdlFkOEZNbU1HQmhLRmZ0RXRQeHRaMVNNK0M1YWVlNVhWM0Rz?=
 =?utf-8?B?ekZjV2FwUEhGdEVpSjZLKzRKZ3lGWGVLaERSTGZPN0dPQ0cvd3hCV2w0bm1x?=
 =?utf-8?B?Q2EwbDFXZ0dKb2ZkSlFnai9oRWhhTmIxTjZOeWRCMTVjTTVSL1hhNGk3UXhV?=
 =?utf-8?B?Q2t2RmVZdHRRaWNCQVRraHlINHNIZzJzLzRaN1Q1ZjJCeStFZVB1dWNuU0x1?=
 =?utf-8?B?RXd4OFA2QmEzM3A1T2JCOFhrL01hOW1BY2tNdUtMOHh0MytrMmRjNngvY0l2?=
 =?utf-8?B?K3FSYy9yTWdmN0tSN0czODZOQkdGL2lvalhTY2xrTFNNRnhVUU5VcUJUelNy?=
 =?utf-8?B?NklybzNvK3dwQjVsR0NNdk9BQWlGQ2wxYkpFYXoyVFZod1lRRS9naHBGZmxP?=
 =?utf-8?B?d2xuSEdDaUFhWS9tSVZmRzVVcEt5UnZ3cEhYeWVQQXhNZDdrSE9udS95L2tx?=
 =?utf-8?B?NEJ0S0RXdk03c0dXb3JuR0dFc1FkYXZ0bnFjdk1pUXVRZFhoTW9zWnRGdzJG?=
 =?utf-8?B?enB2UmszSTh6NGRWNGw3MTZ1b29jRlFRUlhidElFelRIWXBJOWZINW8vMXRQ?=
 =?utf-8?B?b0tPR214bnpKZUUwVUpZTVhjOENjOUZkN3lDSzEwbVhYazBUZHBvdlFQZUlv?=
 =?utf-8?B?WHJicm1SZllWWmkzcTJjNlE0aDR6cXl2RjI5bEo3WlVJZ1ZnZnFFUVlyZVNq?=
 =?utf-8?B?NGVBTXI4UzVMUlZGcWVaZHh5OVUzL0RDbHZ4Y2tBZjI2QmpQN1A0N3hWTWJ1?=
 =?utf-8?B?RmRYeWlRL1djL2hUNnhCRkIrK3J5OUVCVGtuRWI3Qy9pQUhEaEI2WFpaeTBQ?=
 =?utf-8?B?MXM1SVkrZWlOK1IxYVh4VzQvM3FjQWpaM1BabktjWUhJdE1zaWFZQzlTM0dn?=
 =?utf-8?B?T3pWRmtzNnN3TTdQYXI1TEE5MVFqYnN6eWtvYkVjbS9nNDNMK2w2eG5VSlZt?=
 =?utf-8?B?c3drNjJLYWNtTE00dkc1WWl6QW8vVTRpY1ZqeWJESCtIamZEUVo4amJEODcv?=
 =?utf-8?B?aTlGQ0RtWTF6dnlMTG5RN3FhVCtoQkNkNHltdkZFRWo5MVpLUGZWNEtJYTFJ?=
 =?utf-8?B?clkybUFpdTF3OFNacFJRNlN1UjVXOHlKYVpkQWQxZnc4Q1pNWmx5ak03ekk0?=
 =?utf-8?B?S0VjVGk5a1pBeFRSMHV6WmxFMGlBTVNYcy9JL0JWVkoyV1U3VmFiU2k4am9L?=
 =?utf-8?Q?2dbxGzgUcJ0Rtf/s=3D?=
X-Exchange-RoutingPolicyChecked: Ab5XjzvHr+78V+WaFsG7sMlTQQBiBnDM2X0ixefNrRW5LyMpVibrTmaDQCAAUOdheGiCdCi3uFD8sNbGDcv5ZydLAIkhKY1OPFzPOAnYvxG4rfNCBUAfKFIKgujCZ/eFsO3iDm93XLodrW7Ocjq+mYW6Q8O+CryJqxaVWsZKEgeqk+MugmNFleCkL5XoRrVaO1ylFQPCR/RmaN7bJwXDkZQRWAgO8qB0HARD8+L1a9fd2QpYljk4liBldrQethNy4sAqy5kqoBzbQxC1sEonuGYDoxSI7US2X96yYA+LL4yv0tKdbr6r14fj+KN2tBKlebmteob4sETsIZkgUArEUw==
X-OriginatorOrg: nutanix.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 50f378a2-77ac-45f7-adf7-08decae3e96f
X-MS-Exchange-CrossTenant-AuthSource: PH0PR02MB7159.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 15 Jun 2026 13:42:15.7088 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: bb047546-786f-4de1-bd75-24e5b6f79043
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: ozsXzGOkXv80KDDJYaYF/nh5ru9LgwUFLAYzO1+pmvaNRVR5m1KbVhYidv+/51diNKGje4OdD3gH0HxGmefM4Bcp8LZqzYpjLgy7EnOxhVI=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ2PR02MB9822
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNjE1MDE0NCBTYWx0ZWRfXwohWHkAEUJZJ
 UfcX23JVcZMh5b5Kd/eoAR18drzBdEcyVC02/wwddJMS60tec6Zbtf1bSn8rbzXJpVS3/euUMit
 cq3iwtvNAYmDD1xz44WtzncfqqGihWyr7KupWBOdoCm2maZpI2NY9g2Y8Tgsvd77N/3KqA8kWXM
 TzgvQ9RBem9e6quKeWF5be7ke4+ffD02sn3KRgdK9juk0E0As8IyEEYe+AQ1KFpXMqMlBahAEyu
 HB/P8mN6YqsWsAbDSNW8sAp1d45yeiJt8LF56on0XTlBDflCQqJlrkWfOdAGIzmFUhveSYLsUrB
 wWPJYj1zk7hy+ZXw2ueckN4PAsqtpa0XH21riXi9GlbKUgFT9JGYu+OU07aeanRv3GeLnI+h6Yg
 w4Yp2nLNryAlCXqcMt4hUsFVpyXslEuc1VGntpCGMrYnoFPfso/4XMsiUj0LW8/ig9zvz0k5Ehu
 OCFZuF9xARw4+uk78Pw==
X-Proofpoint-ORIG-GUID: AzAB9pKdfFIxCdq3aegO7A5CUYCNyewU
X-Proofpoint-Spam-Info: AW1haW4tMjYwNjE1MDE0NCBTYWx0ZWRfX2swZIygAfSJ9
 UF+KgoSEtHMabfaF6maAFODw1zfzdQ6Wo9itY+mjqcptPULvcMFNcz5/iYyUQXPQFSGyG5fe72t
 m+VlZQHQjxHVFf5mgXKu5ykJ26WEhtk=
X-Proofpoint-GUID: AzAB9pKdfFIxCdq3aegO7A5CUYCNyewU
X-Authority-Analysis: v=2.4 cv=SK5ykuvH c=1 sm=1 tr=0 ts=6a300139 cx=c_pps
 a=A0XUNoO2kYPMKlNirmUWng==:117 a=6eWqkTHjU83fiwn7nKZWdM+Sl24=:19
 a=z/mQ4Ysz8XfWz/Q5cLBRGdckG28=:19 a=lCpzRmAYbLLaTzLvsPZ7Mbvzbb8=:19
 a=xqWC_Br6kY4A:10 a=IkcTkHD0fZMA:10 a=FelO9ux0wxsA:10 a=0kUYKlekyDsA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=VofLwUrZ8Iiv6rRUPXIb:22 a=y4UcunY2MAxhM4LwGdWI:22
 a=20KFwNOVAAAA:8 a=HrK8Fnj7WKTI5m-Ad8AA:9 a=3ZKOabzyN94A:10 a=QEXdDO2ut3YA:10
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.125,FMLib:17.12.100.49
 definitions=2026-06-15_03,2026-06-15_02,2025-10-01_01
X-Proofpoint-Spam-Reason: safe
Received-SPF: pass client-ip=148.163.151.68;
 envelope-from=mark.caveayland@nutanix.com; helo=mx0a-002c1b01.pphosted.com
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

On 15/06/2026 10:28, Peter Maydell wrote:

> On Mon, 15 Jun 2026 at 09:35, Daniel P. Berrangé <berrange@redhat.com> wrote:
>>
>> On Mon, Jun 15, 2026 at 09:31:36AM +0100, Peter Maydell wrote:
>>> On Mon, 15 Jun 2026 at 09:13, Daniel P. Berrangé <berrange@redhat.com> wrote:
>>>> Do we know how many examples we have of embedding objects inside
>>>> another ?
>>>
>>> It is an extremely common pattern for device and SoC model
>>> implementations; we've been recommending it for years.
>>>
>>>> I would much prefer if we forbid the embedding of objects. It is
>>>> horrible design practice to have some QOM objects which can be
>>>> freed via reference count and some which cannot.
>>>
>>> That would be a very large amount of code to rewrite to the
>>> new paradigm. I don't object inherently ("you have pointers to
>>> your child objects" works better when they might be implemented
>>> in Rust and might play better with being able to create
>>> machines and wire them up on the command line); I'm just
>>> noting how much work it would be if you wanted to make
>>> embedding forbidden.
>>
>> Would it be a more tractable problem to "fix" object structure only
>> incrementally as they gain a need to be managed/reference from
>> Rust code, or does the Rust usage already implicitly extend too
>> broadly
> 
> At the moment we have exactly 2 Rust devices. You can see the
> workaround we ended up with for the PL011 in commits 5b87a07e768
> and cc3d262aa93a4, where we pad out the C device struct and
> assert on the Rust side that its version isn't any bigger.
> 
> For that particular problem we could say "you need to refactor
> all users of device X to not embed it before creating the Rust
> version". There is I think only one embedded use of the PL011
> (I was actually expecting more). This does have the awkward
> effect that anybody wanting to do a "rewrite device in rust"
> is now forced into "do a big refactor of some old C code they
> don't care about". We would also need to actually document and
> provide some good examples of "this is how we think we should
> be writing device models that have child objects now".

I think given the legacy of the QEMU codebase then this will always be 
an issue, but we've solved this in the past with the introduction of 
MemoryRegions so there's no reason we couldn't do it again.

This is a similar problem to the use of non-class object properties I 
was discussing in the thread with Daniel: it seems the general consensus 
is that they shouldn't exist, but this hasn't been formalised anywhere. 
If we can formalise the decision not to use embedded QOM objects, then 
we can start by ensuring that new submissions don't use them and go from 
there.

Question: who currently should make these decisions? Is it restricted to 
the QOM maintainers?

> But embedded MemoryRegions are enormously common, and devices
> that embed other devices that embed MemoryRegions are also
> pretty common. So I don't know how much of a gradual approach
> you could take for the issue descibed in this patch.

Zoltan did post a patch that allowed for adding externally referenced 
MemoryRegions a while back: my reason for not supporting the approach 
was because it added yet another way of adding MemoryRegions to work 
around a particular legacy use case. However if there is agreement that 
this is the way we should do things, I suspect that the series will have 
solved most of the problems in this area.


ATB,

Mark.


