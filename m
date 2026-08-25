Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 608DFC61DB9
	for <qemu-devel@archiver.kernel.org>; Tue, 25 Aug 2026 15:03:16 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wysfT-0002wY-2S; Tue, 25 Aug 2026 11:02:27 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mark.caveayland@nutanix.com>)
 id 1wysfJ-0002vs-Hv
 for qemu-devel@nongnu.org; Tue, 25 Aug 2026 11:02:17 -0400
Received: from mx0b-002c1b01.pphosted.com ([148.163.155.12])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mark.caveayland@nutanix.com>)
 id 1wysfC-0004F2-96
 for qemu-devel@nongnu.org; Tue, 25 Aug 2026 11:02:16 -0400
Received: from pps.filterd (m0127842.ppops.net [127.0.0.1])
 by mx0b-002c1b01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 67PEbSQt537904; Tue, 25 Aug 2026 08:01:29 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nutanix.com; h=
 cc:content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=
 proofpoint20171006; bh=s1u9I4Nyq9RQYGZksEdABK/ErQpLegmHe6mCsEU5H
 N8=; b=x7XB+NQR0+N3Xe6eqV1dxsmUx26LvSUZPp8ooFgG0B3SRpjrrO+KUugVj
 pltDphBwa/eEGm/busWNlNWNgD4qr2fgiZzTFnK+PTgsfAB/q2d9ev+eF3E3046B
 Jk38NryEx6EKrR+oS3P56l6LXnVnjZRXnS7oAlYLbSU3BTqr7EIcC/Y9gmoZUgYp
 DYEnZsCMbvE1KFlTbyFOqCE8i8eR7v+tUbmqF00pJhHvEJ6+GAmFTmZZ3VsbM3qR
 9Aa4wPtoNJFzi9KtscwLe3p3R/50mMc5DIuJH192a1QwHpO8Q8QvAKIoGD5brlhf
 VHO/QSb8JuLIs6lyY/XVXdzX57hsQ==
Received: from ph7pr06cu001.outbound.protection.outlook.com
 (mail-westus3azon11020127.outbound.protection.outlook.com [52.101.201.127])
 by mx0b-002c1b01.pphosted.com (PPS) with ESMTPS id 4g97as0ywu-1
 (version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NOT);
 Tue, 25 Aug 2026 08:01:28 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=GMFEdRjgzOmPr8i02bjAjQSY+glMHF2J2FCEw1W3nUkoylOcXhq9THOSuPEYykOG+MoO5wbm/5HD0vc7WQPD3Y54tkAXeGSX4NR9hS3h2X0rvSrDT2I6de+kLhIIJhfjqjjspMEOT/YE7BPN5EY8O8S+ea8S4KWiJyGEDrorc4y9FQaTLPgli2avco8nIn2YwtT9fCi61V2ZldZ1hXqbXs1CBQ9eKMJZFEDkb3Z1Jdw0RtGfGsaV73YmccbwkGpuNoKPimUSTYH3k9OYUYCk+1SIHU6p6Xk1ybzyzHUvCX46viLI/PeqNFAgMLPl3WSKY38bh8OR3UAu5dDBQJhzsg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=s1u9I4Nyq9RQYGZksEdABK/ErQpLegmHe6mCsEU5HN8=;
 b=aSO5uyECgiDriG/Rs3a166y0BPJ3utUaqUVkWibmj1iJM2e/aEmnZ+uj8pPgD5gx74NjSY57ma10XnJcR1S+1nNc7SX0bXhEUorLtl8rkqRnfgKunz4nV1maAyPrmStjv23Am/B3DE1FO7Xb+KteW94eq3mocBLSPzrFzF1e9VlYuPF6/H8P6vWtWyIn9NsEGYq0fv0GYknxt5GKa8H9ZWzMHDUUCyUVJMAlBOWUViphZfoDwvhs756t7ugDz26PONMc2S0nKvrEylFnpv/SqDMfXdwxxnack7ogHqAOwiXC10LnUR5AG8DpxjmL04zk47uwcxbaCXmfKk+T5ZdGVA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nutanix.com; dmarc=pass action=none header.from=nutanix.com;
 dkim=pass header.d=nutanix.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nutanix.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=s1u9I4Nyq9RQYGZksEdABK/ErQpLegmHe6mCsEU5HN8=;
 b=MqZNmZimLW4j7QPRuXgfqyKYq4TevKQx2rJROSNrdrkh5vKuZDCzB6LzaZh/mGGYGScVhtBnWBmBVA7DJpkJA1rOrPp+c3Ub6vgjBz1jnh0VSBo5HZrC5Y4c3sAksVAhS2dtbnRDCZ1lQfFTTzdGIksgqncInhfpVof2wvkiF4z8W0MaDUFjILpRpxhndI1XW6ZpnoBQ2eYzJEAJsvWLGbR4vbIIFanVLWLbtZel93RnEUSXs+qYga5Rtw4VTe62/nTMqiO70kqcV4hiU21UJMCuQ5lrPZWy9oHSDYCPF3UHERNuEvZbBmF29TBW7gR5GGnWSOCnctvQdYJhTfHflA==
Received: from PH0PR02MB7159.namprd02.prod.outlook.com (2603:10b6:510:16::8)
 by DS1PR02MB10540.namprd02.prod.outlook.com (2603:10b6:8:217::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.339.12; Tue, 25 Aug
 2026 15:01:26 +0000
Received: from PH0PR02MB7159.namprd02.prod.outlook.com
 ([fe80::8e97:bc32:822c:b250]) by PH0PR02MB7159.namprd02.prod.outlook.com
 ([fe80::8e97:bc32:822c:b250%3]) with mapi id 15.21.0360.005; Tue, 25 Aug 2026
 15:01:26 +0000
Message-ID: <c2251650-966d-44fb-bcb6-c413c54f4f77@nutanix.com>
Date: Tue, 25 Aug 2026 16:01:22 +0100
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3 30/74] system/memory: fix "priority" property typename
To: =?UTF-8?Q?Marc-Andr=C3=A9_Lureau?= <marcandre.lureau@redhat.com>,
 qemu-devel@nongnu.org
Cc: Markus Armbruster <armbru@redhat.com>, Paolo Bonzini <pbonzini@redhat.com>,
 =?UTF-8?Q?Daniel_P=2E_Berrang=C3=A9?= <berrange@redhat.com>,
 Michael Roth <michael.roth@amd.com>,
 Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>,
 =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@mailo.com>,
 Peter Xu <peterx@redhat.com>
References: <20260818-qom-qapi-v3-0-24b8bbbe3d86@redhat.com>
 <20260818-qom-qapi-v3-30-24b8bbbe3d86@redhat.com>
Content-Language: en-US
From: Mark Cave-Ayland <mark.caveayland@nutanix.com>
In-Reply-To: <20260818-qom-qapi-v3-30-24b8bbbe3d86@redhat.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: SA1P222CA0036.NAMP222.PROD.OUTLOOK.COM
 (2603:10b6:806:2d0::21) To PH0PR02MB7159.namprd02.prod.outlook.com
 (2603:10b6:510:16::8)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH0PR02MB7159:EE_|DS1PR02MB10540:EE_
X-MS-Office365-Filtering-Correlation-Id: d4f8fcc3-c919-4992-0ea1-08df02b9bc73
x-proofpoint-crosstenant: true
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|366016|376014|23010399003|1800799024|22082099003|18002099003|4143699003|10067099003|56012099006;
X-Microsoft-Antispam-Message-Info: C1y0G2Bc/kiQUI/6nmz8pbncOk11OYFFVPMEHThJo0Ahord2w0OaiBO+B0O5Qlp17rZv3YNJj97VodEl9HGrNbSa1KhKnsFyeQi16XcZXV7ZIda7lpqRWD2G2Zxy4hQpp6j3QQlGnkjulL25vuE1tIQI4tJxLLigitQlvUjiQn+jBxaavS0aDhSnyVSNGkKr5TyYgvrc6yReYsbFwx5RGX5EYAfj0Guh7nQRBhtvJT5oJ33P//VUVMys60UFyWGbG4y2OJ14UncNy+wCQ3kcC7yOxYSvHSO8qgCF0poFjemCRXiwGEYLwUl/GuVnDFQ9UrZ8WjazDMexpRJsJrSL65BDdjgOhjRpTnw6xDjEKBes5eG/19PxlPIjld+H2jfsfMIFbdNjfZnagsK1D4Mgx8VQ+3fksUjjTcAXrTwg4UoRwj6tjLHf9/rKUce+T4BY177fse05rC+xHzmsxkgspD4auylJAErG4itr9pkSZbaRoBABv/jbg6QG4ujMrVxaMMd3KBtmBEGx3rvNOoO/mZwmDT1C9hIlFn+ZvHxdmljmNLtjjehgs2z7Q3weBjofLpOUdcLw5rvW/wVHGmhZkILGfmB9yKPNLkHv+4h0I5V8zUkW8MR6XDRU/xUZ6/4jZq7TJqtIMQwXA+zdj5rTsE3MnSFcVRzVWrgW/nf6Eos=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:PH0PR02MB7159.namprd02.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(366016)(376014)(23010399003)(1800799024)(22082099003)(18002099003)(4143699003)(10067099003)(56012099006);
 DIR:OUT; SFP:1102; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?V05vZnFEMElzaUw2NnlQd1dDQlREV0xKS2ExS05xaFJoM05DaUxjQ1dCbnVp?=
 =?utf-8?B?QUZpbFJkNjl0SUI5ZnY1aUl4UkQ4a1piWi9KdTRJNVg5YUV1SUpmZjVNUFd6?=
 =?utf-8?B?K2FndHQwZHMrZkN6TDhxRlNoV3BvWXdKRFpLNHAyN1V0cGxvME4yK0hhOUxO?=
 =?utf-8?B?L3gvbmFlSGhwQndDZ0JXRHNpNkNlOTQyb1JhbjRXRmgzTktpKzk1WTJyUmRB?=
 =?utf-8?B?RmxMN2k5NWIvdmJvYTdRTTR4OHhLSEV0NUFZQThmMUt3N2hzampCYmJ3THpt?=
 =?utf-8?B?SHZFM3k5UG1FR0JKTm9UTlF6NVljOHhEeU1VenJCd1JvcnpPZmZZWWFTNEZ6?=
 =?utf-8?B?Um5WR0E4UytjdU1TZXVjM0Q5Mk81S0ZPR3pHWHRPTVNxODlEVytXT0I4SHJz?=
 =?utf-8?B?U2pMVU9qTlh1V0pLa0hCOHV5K3ZCdmFTZmRmaDhwcmpCY2hINmVtZ1NlUkhQ?=
 =?utf-8?B?anVaMjJWV1krVnVGbkRlSU5iSGhleEJmeUlMOWxWNVFYYUtwZ25VdjNlbDFj?=
 =?utf-8?B?SW1xSEY0eExkYlZvWktUS3YydlBkSE5hblY5V0tSY3RPMGY4bFZNTXk1WG1l?=
 =?utf-8?B?a2lKZkJUZk1JSzFzL1F0YkIxSTIxNjNFdWU3UmpjK3FhamtlY3Z5V0dRL1Aw?=
 =?utf-8?B?NmlEWnpWRFZmdjMzYlo4RDhpcUFDNXpqMURTdnEzRWRHb0FweGNwZEVFdTMw?=
 =?utf-8?B?UStZOU0wNzRzQmZHMlk3SENwazA3ck5DakdNTHBDL2w2c0RYN3hsSkhKblh4?=
 =?utf-8?B?VmtXNmVBMDBFblZ4QmZjaTh2enVrR3dsd2d3OEVKUUNkeVZXUUJ4cENzellM?=
 =?utf-8?B?UVZBN204WWlkWGZuOEFpZUNLdmZnczhXdVQ3OEYwR3I5bUFYYXVRU2dHUlRS?=
 =?utf-8?B?MDFQbWFtQTM0ejBpMnhIYzg0eU45ZmdHOUpTbmhGbEM4OXoySTZtMWJKejBQ?=
 =?utf-8?B?ekRoVnhTbUJrUlovZThMekNsRTJJTkYwemdWOC9RRGNFRWlpd0QvK0RDVzNq?=
 =?utf-8?B?aGJzeU54YnYrVHRsaGExcE5PNG44TTFVa0VZcFhEMk9Gd2FJUFAyZ3NQQXMr?=
 =?utf-8?B?UEFJbU1aelpZdEtnYXFEcURJSWh0UURHaDZvQThPM21LbTR6a1NEMGFCclpE?=
 =?utf-8?B?RFJvTDZadm5CWFJkQlFKRFNmb2NoNmYydnVlZG92b2ZNNDVHejdKbXAvRTNX?=
 =?utf-8?B?YTV6ZEhhYWk3NUlCNVQ4eTB2b29CbHRnSnhWMVhveTI5RGs2cm5UQmdnejAz?=
 =?utf-8?B?THZveXJGd2lEUUtlTGhxL1c3UnBuM1liS0IzZERtUUtSZ3U3bmU2cW1jU0JK?=
 =?utf-8?B?OHEyQmZHTDU3d2VMUEpiejV0TFdtOU9McHFoa3BmNlpsdk5nWTRrMjFRRk9D?=
 =?utf-8?B?NGNDT3pPQ1VZN0hvbVJxVkc4VFRlWUQ3T0pUV2hJRVJQUDcwRlNaSllvV0hY?=
 =?utf-8?B?MjBVZWdFUjRDVGFqa2Y4aDYxZStNd2IzT3VyTWwxSkNyc1lOS1VvNVJBbGJK?=
 =?utf-8?B?WVAzemg0QVp4M1JlWHRZTWZBc3M4dzVTSUNYRytZUGtIcHo5L0hpV3NSMVZO?=
 =?utf-8?B?N2kvTUNUM0xQZGRLcW02RElpMW93WEVMTzI3bDh4bU03ajA2U1R1OVF2WlEr?=
 =?utf-8?B?UmxXbUNBaE0weThyK3ozelhVTFZPZmI5NjkxS3g0NWNCYnV6V3ozUEREWEtJ?=
 =?utf-8?B?a0VPdkRhOFFzNTArL0p2dVpBZDVTUENHWis5OThMbXBxSWFhMG00TExCd29q?=
 =?utf-8?B?aWUrT1kvWXpkdkgzMHhEbjBoUHVGRGVENjZSdk1PU1MxMXM0aVJremJkRHVF?=
 =?utf-8?B?SFB6K0FzVmt4NXc4MjFOZDJZY0s5TDVKM2RSYkZlbzlCVWVMTjEyZ0xnQjIy?=
 =?utf-8?B?YkN0eC9KMXhlRVVZSkVFc0hoMzB2RFVDV21BWjhDRjd1TFNHVEtoSEVGby9K?=
 =?utf-8?B?eGp0U0V6STZDR0JpRFJ1a1RCRm93Z0l6U0NpM2VRUTFvY1JEVGR4YUJSSDAx?=
 =?utf-8?B?dVFyWkxmc2xnUXpXaGlreVQ4alk2VkIzZGpoTFFxZ3I0dHBQZEpFS0Rqalk5?=
 =?utf-8?B?ejd3blRTSFZJbWgzaGgrampDLzZ3cW9rR1hDaVl3Ulk3N245RjVmUVdvaU5h?=
 =?utf-8?B?bGNUQ29rWGE5N2R2ZjdtQkEvSkI2akJtS2dNTTlqM0kyay84ZGZJeXVZL244?=
 =?utf-8?B?NFBhODFJSjhzRjFnSzhraWU4aVNFdzBqN2ZzZkJ1bTZ2SHNUQlBXMk9tK1Rp?=
 =?utf-8?B?Mmc4MUpRNHZDcmx6Y2l4SFdBSTNyMlNHZjNMRjVjdjFScW1xek1rRC9HUzY0?=
 =?utf-8?B?ZXVPbytjOFp2RDN3ZTY1eDYrQSs2REpEM3pPSW5MNTE3T1ZBZTBZelhIaFNj?=
 =?utf-8?Q?OzWegXKbsPQiYw2U=3D?=
X-Exchange-RoutingPolicyChecked: DfEZIpeI7k+VltmM0FSNTAU1EFELpwSFSFLTAJsRch6QM/Q5lB6ihUjoLlS+clMEtV0q8p6ystrurGCFst+oPC4xp5OAv5hhgEwwSAc8/OBQXKQYKHgwxIO6eYjOs12ie0/Xm7yxfoDyL6UpjSkMCXhoZB2Zx3PrHU44VHt1rje+/o9zwcE9SQzVMkaw/rYXmH0JRGWVMfZLgOTT2Z+zoxs6RLp6pEv4o1CszgX/SD1UpHL3VlRjXGpITvV2QKNUAFmuJwxD6Sq0aqxxV99okzIwXGTrc50AVjSz5ITfRsRQfCkUkdrpTHvf9GmYbreLA3eh9dUAwt8wFYCXvSM3fw==
X-OriginatorOrg: nutanix.com
X-MS-Exchange-CrossTenant-Network-Message-Id: d4f8fcc3-c919-4992-0ea1-08df02b9bc73
X-MS-Exchange-CrossTenant-AuthSource: PH0PR02MB7159.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 25 Aug 2026 15:01:26.5006 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: bb047546-786f-4de1-bd75-24e5b6f79043
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 441NKlI3D6MmPzj7nXuse7HlDW7w0USZYyqGeMNukjTtFl4EDxbql9asbEME2a04XlbTXcCiaJBZlr7T78YEhnsf1epodzBfrw2UWTUCEa0=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS1PR02MB10540
X-Authority-Analysis: v=2.4 cv=DJu/JSNb c=1 sm=1 tr=0 ts=6a8dae48 cx=c_pps
 a=PudVcg9mnr0bxBTXJVVJTw==:117 a=6eWqkTHjU83fiwn7nKZWdM+Sl24=:19
 a=z/mQ4Ysz8XfWz/Q5cLBRGdckG28=:19 a=lCpzRmAYbLLaTzLvsPZ7Mbvzbb8=:19
 a=xqWC_Br6kY4A:10 a=IkcTkHD0fZMA:10 a=Sv0fKeRqtYgA:10 a=0kUYKlekyDsA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=VofLwUrZ8Iiv6rRUPXIb:22 a=VUi8bpU7OL1Oj2-RSIOF:22
 a=20KFwNOVAAAA:8 a=64Cc0HZtAAAA:8 a=RLtZFoWnJogxvlf5T1kA:9 a=3ZKOabzyN94A:10
 a=QEXdDO2ut3YA:10
X-Proofpoint-Spam-Info: AW1haW4tMjYwODI1MDEyNyBTYWx0ZWRfX4kfrrUHGmxNN
 ks1eWye32c2VklP7sfJEVHJz8PP2AS8GaxxI1bbHijljqkgdPObMHmdKHmf6RfiUJlf3vmaoPzs
 +zzWyEXokvQbByVoz02cmVB1fPYpoME=
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwODI1MDEyNyBTYWx0ZWRfX01rLBsgX4/xD
 Isa+yKBYWdUDW0KvVxrkClgC4X0atKJeoB+ZP33n9MvG9DlzjxXSKvczTmazQ7nfKC3L2T8hoyk
 0r+5iFSO9tBVDJYgFrX6SciXU5LkreegsjdzbSLCbnwUQ0TYWSeiyaCJNMm5J6f1Yi4r22IUHg0
 XCxcVQzwWF8K1799UEgyN4xdwyzW4SRr//fI1AfdMbbmPmMC/GTLJ1HTFxsjjsT7JW9LYHp2N28
 yHn6cVn2XJxdQsmtMtglbjNPRR2u7xC4qcv8DDVxUElaBvkYO8n0w0PwzS81SUGuL+E8jH4Y5DG
 RccKIGeRuvBtVHwOeDjS2Do1pCwAkrQktyxDOIoNBZs4UiP2GrPCE1Zs1+i22PpOLYFf0VLk5xt
 M4JUsLHoocpVY+yOyLXGNWCzLlmwKHS+ql8U+leS64niOJ18TTf1q35JJLyGRCaeRPWRYr4LlDK
 4H8b/Q6j68P5bSV4HvA==
X-Proofpoint-GUID: yDhHTjVazmWuHlunJ71hPOjmdVdPcIrP
X-Proofpoint-ORIG-GUID: yDhHTjVazmWuHlunJ71hPOjmdVdPcIrP
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-08-25_04,2026-08-24_01,2025-10-01_01
X-Proofpoint-Spam-Reason: safe
Received-SPF: pass client-ip=148.163.155.12;
 envelope-from=mark.caveayland@nutanix.com; helo=mx0b-002c1b01.pphosted.com
X-Spam_score_int: -27
X-Spam_score: -2.8
X-Spam_bar: --
X-Spam_report: (-2.8 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
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

On 18/08/2026 12:10, Marc-André Lureau wrote:

> The value and the getter are int32.
> 
> Fixes: d33382da9ab ("memory: MemoryRegion: Add may-overlap and priority props")
> Signed-off-by: Marc-André Lureau <marcandre.lureau@redhat.com>
> ---
>   system/memory.c | 2 +-
>   1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/system/memory.c b/system/memory.c
> index da710bbade1b..164c18757f8f 100644
> --- a/system/memory.c
> +++ b/system/memory.c
> @@ -1318,7 +1318,7 @@ static void memory_region_initfn(Object *obj)
>   
>       object_property_add_uint64_ptr(OBJECT(mr), "addr",
>                                      &mr->addr, OBJ_PROP_FLAG_READ);
> -    object_property_add(OBJECT(mr), "priority", "uint32",
> +    object_property_add(OBJECT(mr), "priority", "int32",
>                           memory_region_get_priority,
>                           NULL, /* memory_region_set_priority */
>                           NULL, NULL);

Reviewed-by: Mark Cave-Ayland <mark.caveayland@nutanix.com>


ATB,

Mark.


