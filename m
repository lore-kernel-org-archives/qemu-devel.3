Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id BB129CAC592
	for <qemu-devel@archiver.kernel.org>; Mon, 22 Sep 2025 13:58:23 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1v0h2u-000728-8r; Mon, 22 Sep 2025 09:57:36 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mark.caveayland@nutanix.com>)
 id 1v0h2o-0006zI-S0
 for qemu-devel@nongnu.org; Mon, 22 Sep 2025 09:57:31 -0400
Received: from mx0b-002c1b01.pphosted.com ([148.163.155.12])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mark.caveayland@nutanix.com>)
 id 1v0h2b-0002rP-5l
 for qemu-devel@nongnu.org; Mon, 22 Sep 2025 09:57:22 -0400
Received: from pps.filterd (m0127843.ppops.net [127.0.0.1])
 by mx0b-002c1b01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 58MB0oe91546869; Mon, 22 Sep 2025 06:57:05 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nutanix.com; h=
 cc:content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=
 proofpoint20171006; bh=+AJc3Q20p8dh3HmW+Arx/qH0MftNwxc2RfRjsb3Lw
 jg=; b=KLTzE1fEjpeYoMVBIKUqTKwQlWI3Z8d9GvKVmf0B5ihsm1m7S5okS2f2j
 2+tiT+hiV/3DJrLf0HS1P14NhZpqsOqQ94aiLcqw4P9UTZROoh7uWwp+wFcugIYK
 K9ISSa8uSWuHPkJBbDBU/AMDfQWe8AEQlRGtlmPR/khUeqMOaxkt2txPSyYOz9QF
 IkY1WLdlAzzLhPfvmqJ31yST617J8zG+2V8N26iOLW6dPmdGTSJl05YBp19WPZqE
 C/Hut1w/dUpo/bPXdLQVjauG7+RwCljc3DhRxUDqnChvO5bpQOx0jHCXzWobaWZT
 yYJve8piLDUwpCNNWr5Pa73nZBU/w==
Received: from ch5pr02cu005.outbound.protection.outlook.com
 (mail-northcentralusazon11022082.outbound.protection.outlook.com
 [40.107.200.82])
 by mx0b-002c1b01.pphosted.com (PPS) with ESMTPS id 499tcfk76c-1
 (version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NOT);
 Mon, 22 Sep 2025 06:57:05 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=Xp1X66rDhCvHKTRBkdqSmvKMYDbcc7LRvAHa0UofyKTdKKSBJB2kLBYMyi++RtAbAted+gmaqsHEonGTgYDMDZ+PuCDiGr3VEbAyK2spTtu4A7pwp7ESmsPoqRGF/JgDFijKsD+QDGdBn709EItyNc025DNgmkRbQkuak666v7Tmf4MIfGiDn9zisCMEPFww4sR7Gq4RjJdZcTmabzmiA6XziZnQbdzhtubYxQkm79MQlzhFeYKdS435ouPA81s/zCK4ko6X0GozzfDSfyRyTO0c+Dq/RZQOEWY20D2Gt4hfI7WclbVCIFqLsZ8I3EYM5JdbnEWLAS+v7HIHIATlsA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=+AJc3Q20p8dh3HmW+Arx/qH0MftNwxc2RfRjsb3Lwjg=;
 b=TQNxrwdZcImHlxsyqc3/UniDBzbF02kWTT6vxkpRwJYFujunu4IPDke5aIG1zIWcT/9Ka9Dc4zGP8C9Zmga2KdyrUpoMIpgeS//DfqE626gpUwq4iHHHWlsk0FYm2VJPfuVlkkjkdo6/n83tfCK/AgmxxRm7r22FeylCj7NJuSbmP7UIuoVlVg4eQKpIXtR+yim+NIel1Etwvj/BIPqwouemh3w1sWj8PmHa2CF9Rakwbdw6TWrHydPfBv1CJve/+kWpGXddk4I/G8f3WHzgTBdi65NXqlOdlIemS6sdPHJVFsVp1NQ3/HiX7Vs/S1uqKe5e+RAKgyaGEadGobZsdA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nutanix.com; dmarc=pass action=none header.from=nutanix.com;
 dkim=pass header.d=nutanix.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nutanix.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=+AJc3Q20p8dh3HmW+Arx/qH0MftNwxc2RfRjsb3Lwjg=;
 b=fEYXxZhMl7dIkwJ6FVdbHiZkgoPd5Z47RjbLHmdCSiwRBByjs1ZLPFhmW6F3mfnZnlPMRs+8CoSM/0ETkxhec+Mp4ynQsFYn9g5JgBO574Atvqiow/VKo+Nw73eQmgxM7dHTdoxQRRLSO/wAjEB5WwTldENim6Uw+lfPMt6gUe/sB+DkSTHzlLyqZvBDovG8Ig49ZUXt9tGTaqsJI26UBruwFDb9RjoqfisR7WIYbnW/6TL+IDZ9MUUjcfz20wqojFAxN5SS2TpCYKyhj1BHDOcf5pEzyt4U8402OHPkYlKZLS8lhxlNnX1mK2Tgn86nw+MmcRogp/N7eb+A8yngoQ==
Received: from PH0PR02MB7159.namprd02.prod.outlook.com (2603:10b6:510:16::8)
 by DS7PR02MB9525.namprd02.prod.outlook.com (2603:10b6:8:ec::20) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9137.19; Mon, 22 Sep
 2025 13:57:02 +0000
Received: from PH0PR02MB7159.namprd02.prod.outlook.com
 ([fe80::6cf9:b35c:b143:bb88]) by PH0PR02MB7159.namprd02.prod.outlook.com
 ([fe80::6cf9:b35c:b143:bb88%3]) with mapi id 15.20.9137.018; Mon, 22 Sep 2025
 13:57:02 +0000
Message-ID: <bb967b28-4ec5-40b5-88cc-cebd7493d381@nutanix.com>
Date: Mon, 22 Sep 2025 14:56:57 +0100
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v6 01/19] hw/i386/pc_piix.c: restrict isapc machine to
 32-bit CPUs
To: Igor Mammedov <imammedo@redhat.com>,
 =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>
Cc: =?UTF-8?Q?Daniel_P=2E_Berrang=C3=A9?= <berrange@redhat.com>,
 Xiaoyao Li <xiaoyao.li@intel.com>, pbonzini@redhat.com, mst@redhat.com,
 marcel.apfelbaum@gmail.com, eduardo@habkost.net, qemu-devel@nongnu.org,
 Jiri Denemark <jdenemar@redhat.com>
References: <20250822121342.894223-1-mark.caveayland@nutanix.com>
 <20250822121342.894223-2-mark.caveayland@nutanix.com>
 <3c2e9fbc-db80-4dd6-a1a5-deeabb8c0194@intel.com>
 <58c515a4-292e-4aec-b57e-73be89b9c322@nutanix.com>
 <aK7wDn03e8RtKmk3@redhat.com>
 <1178e514-a054-4ace-a5b7-06ca899badec@linaro.org>
 <20250922143537.39896851@fedora>
Content-Language: en-US
From: Mark Cave-Ayland <mark.caveayland@nutanix.com>
In-Reply-To: <20250922143537.39896851@fedora>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: AM4PR0302CA0032.eurprd03.prod.outlook.com
 (2603:10a6:205:2::45) To PH0PR02MB7159.namprd02.prod.outlook.com
 (2603:10b6:510:16::8)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH0PR02MB7159:EE_|DS7PR02MB9525:EE_
X-MS-Office365-Filtering-Correlation-Id: bce607af-ba93-4f4e-15ff-08ddf9dfe822
x-proofpoint-crosstenant: true
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|10070799003|1800799024|7416014|376014|366016; 
X-Microsoft-Antispam-Message-Info: =?utf-8?B?Ym1PcEdQTDFtUHZwZHozMG10THA5NjFWKzdLRFRaWnZFU1NYT0xac3BwYTE0?=
 =?utf-8?B?MVRFeDBGR3JlKzJ0UHFFK0RXeU5zeG4wK2h4aVlFcjdXeU00Q1F4TmdiejRR?=
 =?utf-8?B?dkdSRXZBVHpwVENYOXQ2U01LeHV6d2JxUHhlc1VmT2YxUkUyOFhadWVXd2pr?=
 =?utf-8?B?dFBEMmpVamJmUzR6MEFPR0kwMWhseGNidW9sRHNhRkF6emxDL1R3VkpwaXR2?=
 =?utf-8?B?eVVoaDVRQjhib0F5VEo5cms2THBmaGtkaVpYTEhLWXdLbmZ5WHZiTGw3MWxM?=
 =?utf-8?B?d2pJdEJKMStVb2R0d3F4djdJY3p6eEEraDFGN1pOdTZQU3NKSmN2S2kydXBU?=
 =?utf-8?B?TGVLU0xEUG05Qnd5T0NvdGhqa0Y1MkV1WldoNVRGT0M4UFc0RkJsWkswVjZp?=
 =?utf-8?B?Wm42c1IzRFRkWHhqS1RUZ1lGeFB3bjdWZHc3ZGhYbitWbFVnUWJIUUVQQy9X?=
 =?utf-8?B?QmZYQmQ3MnBUcHR3RndrUkgvY3RTcXNiRmtKdWszbndMMmVSVDR5NnZXbEFN?=
 =?utf-8?B?SXcwMjRuM0E3ZXhreW9SaUtxNjFNL0U2YVJpV3RkYTcxMDNlYXhreDNFYjNI?=
 =?utf-8?B?aEpBQnN6TlhoUkpiQ0VROFQ2S3AzWUxrRGNqUXhOcFhxUVJCTXlwaXl4ZTNo?=
 =?utf-8?B?cVZSQ0lKa2ltLzFaSDVnWEh6S3JmbkhZbTk2bDRKWWxhS1dVRHdRL2h4dVlZ?=
 =?utf-8?B?S2pnYjhtNXUvTFRtMzN1ekQ5OG9RSC9vQk1qMUhya1Z1dVdKYnUyL1ZrYXNv?=
 =?utf-8?B?U0htd1I1N01QTmJxVlZSSERQM0dOa2lNa080ekF5U0JKa2pXTEU4T2dFZHN1?=
 =?utf-8?B?L1NiMmsxRkJvSGp2bXUyd1REWjBqUWt4Z2tDcUpTWGVubkR5QlU4WTNvYmNu?=
 =?utf-8?B?M1BJN21Edkp2NEgwYVVNeWtsektUc1BJRnBPYy93N0M3dDc1YWtqekdOMk9O?=
 =?utf-8?B?SEl3SmN6UDk3TjhXYVREMFh5TzlwSDVLR3FoOVhnQUdMWVNqeHBBUzNHUTd5?=
 =?utf-8?B?Ukt0U2dYM1ZnNnR3VUhMS0VxQ3Focm9tb0NickZFcmNrZWFMbWxqUmFUYkd4?=
 =?utf-8?B?K2Uwb3IyYWI2NEo0S1pBTnh0bTloUDhaSmlmWlV2UmZzYVNOVWQvSW1Cc1BG?=
 =?utf-8?B?d3N5c3ZOTlRQQUx0QWJ5dUdZV3VhT01KZHVSRWFZMmNIVkdQVlV5OG5iUHA2?=
 =?utf-8?B?OFhWcllna1BXUU1jNDBrVGw4cUZ5N2kzdEtDR2VRaHJHWnZCbVlXZHI1TmNh?=
 =?utf-8?B?S2VpOVZvSk5ITTQ4N01CSnd1cUxCSjdkNDNmVXUvRkIvaVFVSy81MkhkdWdL?=
 =?utf-8?B?WFYzTytOc3lNaTlwRGtTeUgyODdHQnRWM0ROMEFlRU5PSUhuNmh1dENvWFEw?=
 =?utf-8?B?bHhLeGd4MTRndGdTcVZNUjVkdlJteWRCcmZESmxKTDBtN0lXUmJJOEFQRlhk?=
 =?utf-8?B?YzVPWGZtOXRIUVF1dFNyZ0hKb1dYQi9BZUNHNVBYV0pmV0ZYNmdJNGFwK3Rs?=
 =?utf-8?B?czdIOXNuelN3RDErSWhzTzdKczBUV1V3R1ROcFNDMWdROWp3TzVLcUpRRWww?=
 =?utf-8?B?T3FyeHQrT0RHbGFXbmowL2Q2OE1JYlNybWFXVTlRTDM0TmFocnRjR0ZGUlA5?=
 =?utf-8?B?eWRoY0Y5Qm9iTkwwdzY4dytjY0lzcXlubngzRGFHMmp0V2YrQXJ3VVVEbkty?=
 =?utf-8?B?NEtTbDVabmVYb0owejZUcXdHUHkzSTUrbGU3djZTRnBtMVR2TGNWTzNsSWFu?=
 =?utf-8?B?QjVlVS9ZV0U0T3Y3QmE5Y0ZBcW11RXBaUTdqWnpINTNQY3AwbG1Ed1M2RTA1?=
 =?utf-8?B?dGRmRGU3VU82RmtQTUNjUENqNkNSQTZ5TnpaZ3R2U3hxMWR5blhJMVJ4OHdp?=
 =?utf-8?B?WEVwWER3TitMcUUrV1ZoQWRuZEFWb055ek54OTBBUFg0NWRWOUxOSE9VWHB0?=
 =?utf-8?Q?nF9TPtyIxUA=3D?=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:PH0PR02MB7159.namprd02.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(10070799003)(1800799024)(7416014)(376014)(366016); DIR:OUT;
 SFP:1102; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?WFVndVZsUUJOalYrWEszS25nMkdMMnZmZkF5WFMzS1docXM1Q254dUlidFdT?=
 =?utf-8?B?KzlVNjFyVW9HNjFGSHJCYUJFdzFMWi9RMzNuZndKWktxclZ6ZlhoWnA5bkxY?=
 =?utf-8?B?bXdpWnAxT1UyT3BXVFdjRTNvamRvRVovNjhiT1hUL3JENWcvSGlLeTlBYS9i?=
 =?utf-8?B?RUJkTmtvdEU3eU1tMzdlVy82MXNKMHgyTDRSa1oyN1Z3Wjk2ZGJKUjBjUVA2?=
 =?utf-8?B?WFMyWXhsK3NyMVZRekZabGxFaVpwOEQ0ZGl3NWRYOG9NODF6YkEvcGVZWnl0?=
 =?utf-8?B?KzExZ1cwN3NaeHExR0JLL0JqeTVHU2JxdSswdVhTOHVDdmdaa1kycUhiclA2?=
 =?utf-8?B?dFVHeFFpc2NRMjVrSDR2dExlbW95eEdSaDdLN3ZvS0dqUVZ2bnRiSkJqT1p2?=
 =?utf-8?B?c0VHODBySWplN2lSTHc1ZDNuOXpRUWxFQ3dJU2dVVnZ3bmM2SFEvUWJVaEh2?=
 =?utf-8?B?N1BIWm5NcHB3dHowUmxWVjN0QkduRFJtN0d3Q2ZzT2NaQUIwSGhhM2R4ZkFM?=
 =?utf-8?B?aGt5TGtoWUVlVEJXaWk2L2FiL3l4Nk1jSHRVWDlCNkZZWWptYmkwK2pRSi9E?=
 =?utf-8?B?bmhwR1phdTRpWmNGa09ac3RjQVQ1anZhKzduR2lxc3N0M3M3cUxwNm41azFU?=
 =?utf-8?B?MjNLRjNlRlV2VGcxdHNpMFhDN24vdktTYzFmQm4rcnVSRzlMVHR6bVdLK3Jv?=
 =?utf-8?B?SWk4UEFNMlFPNjhuSnlmNkRTbEFFZU5ZemdFc2dTWXU2UDhubTFidlhWUCtq?=
 =?utf-8?B?SjlpSk43QVVoSm5VNmZUK0RmNW1CcXpKbUU2MGVOVU5QZ25pL0NYMDJwejI1?=
 =?utf-8?B?VCt0aThKbjJsSVBMUlVrblk4WSsxQkRTbVhwZFJoeWh2MlIwMGpmVWZPa1Ny?=
 =?utf-8?B?VFZYckdUSUVMbHlQRTl1Sk9OQWFoNjhtQThGTWVuZ05tRlZuaVVrOEZ1M2NG?=
 =?utf-8?B?R1lyQklNQjFWek82MGdxTzc0bjFlRFFVRm1IcStocWpmNDlTYVNPK2pwRzR1?=
 =?utf-8?B?WUpJenNhTmQ2a3ZSTjdoZTBTNkFoZHU5SnVCWTBmajB6WW52Y1l2YVc5d3dI?=
 =?utf-8?B?LzZ3WkROR285WFJoVnNENklEMS9Ib0NURWpDQVNhL2VrL0lOdGl3NldQUnRu?=
 =?utf-8?B?ejNkaDBJTnF3eHltVzA4SVdxUHlLb3ZKOWZCWDI2Q1NrOUo5NGtuK09wbHBK?=
 =?utf-8?B?MXhiYmk1L0ZHa1hjYjF6TmN1M0FJNGIxV3gyaW5XRmxaNkxYWU9YZ0J6bGlu?=
 =?utf-8?B?Q1Z0SWhHY3R4YUhVVDJMRHdWWGV1cE9vbndydXhWazFkTEt1VDhZN045d0VM?=
 =?utf-8?B?NU1QK2dHVURtSFNMQWpHV2M1VFlWbUh1ZEt1RS93eVBzQXpFTXNzVm1FUklj?=
 =?utf-8?B?bi8zU3hUNjltM0xKcDh4TitPUWpYaWM3a1dIZjlxV2g3V2dWb25mMzBBZkMz?=
 =?utf-8?B?V1MwcFB2aERva0NydW9jOGZDUGJoY3l1Q0xsdXlJSXNvZkFQbnlaU3pLM0Iz?=
 =?utf-8?B?VndlM1owUENITE11ZXB5c2ViTFJ1NDljREJqbENINjl3a0FIb2xOUGIrayt5?=
 =?utf-8?B?L3BpTGNhSDFWR0hWV1MvbWxGUkwzay9SY1ZFSlNJMm9xcXU2TmFEZURvNGpn?=
 =?utf-8?B?SmQyL0RFZzg4R0RMeTJERlBLMlJ4OWsxRWNJS3JpcU8xdEplc2V3ZXhaSE5L?=
 =?utf-8?B?QjlsN041R2RkWHkxWjBGOUU3OW9VeFFSRDZjZXVvNVFNYnArandiWFI2NGph?=
 =?utf-8?B?Mm5RVFU2R0dBVy9oaEQzdFpDZkM1QXZjUmpEZnM5MmNGc09NYUpCdjJ3S21h?=
 =?utf-8?B?UnUyL2V5OXZIa2NEWVpCMkRIWFBaQnBOR2gxeEJQMDlRTk1zOVJ3QUlSY2hO?=
 =?utf-8?B?d3Exd0FkK0VQMmJmZFdZc01PdnkrWm5MYm5Pd0VhWlFUWHpqYUlrQVJuVXZY?=
 =?utf-8?B?OVNZUFJtSHBuTXB0QTZvNlpXVldsQUhmT3RaelU0STRldVFMdWJnOFcyT2w3?=
 =?utf-8?B?L1dYUkRyZFFXM1ZqbHNnYWxQM045Y3FnK3loTkFDb1E0VHJNcmp4aDZqTU44?=
 =?utf-8?B?dkxXYVJ6MFNHWUErOExWRVRUTkZ3RVp2bkhnQ3FiWVRsckk5NTdWc2VTR3dt?=
 =?utf-8?B?SlBHeklvTGljZS84T3luT0N1blN1QjJVVkRkQVRJUmdMV2xJVFBLb3NqYkVP?=
 =?utf-8?B?cUNBNlZKVnREbGxmTlNHVTVUT1BtZzdkRlc4RHE2V2I4K1RTOU8zVEIycFM3?=
 =?utf-8?B?MzdMQjZLa3RaL2hYdEUyZXRILzdnPT0=?=
X-OriginatorOrg: nutanix.com
X-MS-Exchange-CrossTenant-Network-Message-Id: bce607af-ba93-4f4e-15ff-08ddf9dfe822
X-MS-Exchange-CrossTenant-AuthSource: PH0PR02MB7159.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 22 Sep 2025 13:57:02.5341 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: bb047546-786f-4de1-bd75-24e5b6f79043
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 18afOXbsJNJs3Ans7n+lVWm71EDykXVgJkccpM5dvnPjwdOeNPTKWl7zfOvnqpicfcmM4SxE8w9UXOA7/+4gG0GtuCskRbLJk9vHHOV0gFM=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS7PR02MB9525
X-Authority-Analysis: v=2.4 cv=UoxjN/wB c=1 sm=1 tr=0 ts=68d155b1 cx=c_pps
 a=g/fcdA0ru3Q2I7SmDoHu6A==:117 a=6eWqkTHjU83fiwn7nKZWdM+Sl24=:19
 a=z/mQ4Ysz8XfWz/Q5cLBRGdckG28=:19 a=lCpzRmAYbLLaTzLvsPZ7Mbvzbb8=:19
 a=wKuvFiaSGQ0qltdbU6+NXLB8nM8=:19 a=Ol13hO9ccFRV9qXi2t6ftBPywas=:19
 a=xqWC_Br6kY4A:10 a=IkcTkHD0fZMA:10 a=yJojWOMRYYMA:10 a=0kUYKlekyDsA:10
 a=KKAkSRfTAAAA:8 a=64Cc0HZtAAAA:8 a=OZzLajGmYqqQTdnXNqMA:9 a=3ZKOabzyN94A:10
 a=QEXdDO2ut3YA:10 a=cvBusfyB2V15izCimMoJ:22
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwOTIyMDEzNiBTYWx0ZWRfX63l8c8URdaFo
 HPMmRB83y96kChRjb6ajv7RVT+bB4V0t6aiKr43/CYYGhO5oBSAqNkTK3MsAtrDMvXzPJdpRg3a
 nlcFEVRpQBlgZB2ORhOmk2k+kjcwhqifUHs1arJYA1LJTBxVrf7hykk756bkGyji2jLDwYcwI6e
 mRelMLv7J65/vTYQjjdPNrUmtgmZNPubDAL1QsIGNdtc9xKOlA9Lv6YuJXYEtDz1aHRxI3X7Mpu
 sJu0Kor3dZuwC3aFK0CvqIvaBxa4rD979tgYLqI7DulDKkEDwbSkoYzBEaBpJErxZfVRKKsjm2u
 uFS2yflBrHVfN7ZpP+5qz2EqM1qSSrhLxCEJe+Ac9k1/E6xPS4YlxYAdR75y5M=
X-Proofpoint-GUID: YGqdG_W8dlNNbA3PidwBcXcNB9SCiex3
X-Proofpoint-ORIG-GUID: YGqdG_W8dlNNbA3PidwBcXcNB9SCiex3
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1117,Hydra:6.1.9,FMLib:17.12.80.40
 definitions=2025-09-22_01,2025-09-22_01,2025-03-28_01
X-Proofpoint-Spam-Reason: safe
Received-SPF: pass client-ip=148.163.155.12;
 envelope-from=mark.caveayland@nutanix.com; helo=mx0b-002c1b01.pphosted.com
X-Spam_score_int: -31
X-Spam_score: -3.2
X-Spam_bar: ---
X-Spam_report: (-3.2 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.442,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_LOW=-0.7, RCVD_IN_VALIDITY_CERTIFIED_BLOCKED=0.001,
 RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001, SPF_HELO_NONE=0.001,
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

On 22/09/2025 13:35, Igor Mammedov wrote:

> On Mon, 22 Sep 2025 14:05:13 +0200
> Philippe Mathieu-Daudé <philmd@linaro.org> wrote:
> 
>> On 27/8/25 13:46, Daniel P. Berrangé wrote:
>>> On Wed, Aug 27, 2025 at 12:10:00PM +0100, Mark Cave-Ayland wrote:
>>>> On 26/08/2025 08:25, Xiaoyao Li wrote:
>>>>   
>>>>> On 8/22/2025 8:11 PM, Mark Cave-Ayland wrote:
>>>>>> The isapc machine represents a legacy ISA PC with a 486 CPU. Whilst it is
>>>>>> possible to specify any CPU via -cpu on the command line, it makes no
>>>>>> sense to allow modern 64-bit CPUs to be used.
>>>>>>
>>>>>> Restrict the isapc machine to the available 32-bit CPUs, taking care to
>>>>>> handle the case where if a user inadvertently uses -cpu max then the
>>>>>> "best"
>>>>>> 32-bit CPU is used (in this case the pentium3).
>>>>>>
>>>>>> Signed-off-by: Mark Cave-Ayland <mark.caveayland@nutanix.com>
>>>>>> Reviewed-by: Philippe Mathieu-Daudé <philmd@linaro.org>
>>>>>> ---
>>>>>>     hw/i386/pc_piix.c | 26 ++++++++++++++++++++++++++
>>>>>>     1 file changed, 26 insertions(+)
>>>>>>
>>>>>> diff --git a/hw/i386/pc_piix.c b/hw/i386/pc_piix.c
>>>>>> index c03324281b..5720b6b556 100644
>>>>>> --- a/hw/i386/pc_piix.c
>>>>>> +++ b/hw/i386/pc_piix.c
>>>>>> @@ -436,6 +436,19 @@ static void pc_set_south_bridge(Object *obj,
>>>>>> int value, Error **errp)
>>>>>>     #ifdef CONFIG_ISAPC
>>>>>>     static void pc_init_isa(MachineState *machine)
>>>>>>     {
>>>>>> +    /*
>>>>>> +     * There is a small chance that someone unintentionally passes
>>>>>> "- cpu max"
>>>>>> +     * for the isapc machine, which will provide a much more modern
>>>>>> 32-bit
>>>>>> +     * CPU than would be expected for an ISA-era PC. If the "max"
>>>>>> cpu type has
>>>>>> +     * been specified, choose the "best" 32-bit cpu possible which
>>>>>> we consider
>>>>>> +     * be the pentium3 (deliberately choosing an Intel CPU given
>>>>>> that the
>>>>>> +     * default 486 CPU for the isapc machine is also an Intel CPU).
>>>>>> +     */
>>>>>> +    if (!strcmp(machine->cpu_type, X86_CPU_TYPE_NAME("max"))) {
>>>>>> +        machine->cpu_type = X86_CPU_TYPE_NAME("pentium3");
>>>>>> +        warn_report("-cpu max is invalid for isapc machine, using
>>>>>> pentium3");
>>>>>> +    }
>>>>>
>>>>> Do we need to handle the case of "-cpu host"?
>>>>
>>>> I don't believe so. I wasn't originally planning to support "-cpu max" for
>>>> isapc, however Daniel mentioned that it could possibly be generated from
>>>> libvirt so it makes sense to add the above check to warn in this case and
>>>> then continue.
>>>
>>> Libvirt will support sending any valid -cpu flag, including both
>>> 'max' (any config) and 'host' (if KVM).
>>>
>>> If 'isapc' still expects to support KVM, then it would be odd to
>>> reject 'host', but KVM presumably has no built-in way to limit to
>>> 32-bit without QEMU manually masking many features ?
>>>
>>> I'm a little worried about implications of libvirt sending '-cpu max'
>>> and QEMU secretly turning that into '-cpu pentium3', as opposed to
>>> having '-cpu max' expand to equiv to 'pentium3', which might cauase
>>> confusion when libvirt queries the expanded CPU ? Copying Jiri for
>>> an opinion from libvirt side, as I might be worrying about nothing.
>>
>> OK, on 2nd thought, even while warning the user, changing the type
>> under the hood isn't great.
> 
> I second that,
> Please don't do magical mutations of CPUs, just error out.
> 
> we used to 'fix|tweak' CPUs using machine compat hack,
> however with introduction of versioned cpu models we shouldn't do that anymore.
> (aka: existing CPU devices should stay immutable if possible, and any visible
> changes should go into new version)

The original suggestion for allowing "max"/"host" was so that it 
wouldn't cause any regressions with command lines erroneously including 
-cpu max or -cpu host (which I believe may be possible with libvirt).

>> What about simply removing "max" of valid_cpu_types[], since it is
>> clearly confusing "max" == "pentium3"...
> 
> it seems that specifying supported cpu models in valid_cpu_types[] is the way to go.

That was what I did in v1 and v2 version of the series, but I can submit 
a patch to change this once there is agreement on the desired behaviour.


ATB,

Mark.


