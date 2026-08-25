Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 389D9C61DB9
	for <qemu-devel@archiver.kernel.org>; Tue, 25 Aug 2026 15:24:29 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wyt0R-0003pk-4U; Tue, 25 Aug 2026 11:24:07 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mark.caveayland@nutanix.com>)
 id 1wyt0P-0003pX-Sy
 for qemu-devel@nongnu.org; Tue, 25 Aug 2026 11:24:05 -0400
Received: from mx0a-002c1b01.pphosted.com ([148.163.151.68])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mark.caveayland@nutanix.com>)
 id 1wyt0O-0000kA-7q
 for qemu-devel@nongnu.org; Tue, 25 Aug 2026 11:24:05 -0400
Received: from pps.filterd (m0127837.ppops.net [127.0.0.1])
 by mx0a-002c1b01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 67PEbfZV2274554; Tue, 25 Aug 2026 08:23:57 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nutanix.com; h=
 cc:content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=
 proofpoint20171006; bh=E9tg3d7QpZ+c/HsqMOYoc/D+y4XEZOl354wqQcbxi
 sg=; b=EDnkK/ARNqzURQy+LL1bl/p81W1gSbpRYWvb1R+0JOPY+6dOTXpRMiHCI
 VkhYt1+hfYm0fORn9UaG2yrBJozDepzS/7cIhTLJf2eg4GvsjhwaJYDhps/pK5lu
 b78Lyyoj3UAHzDIRrQQk0gqhOxNQwWAsXOHcruluLkvT4nkWUjj0cRW/G4jQdLJB
 7SxouYUxUEnD0Vs96Zn7mZNGgOyX68CtkKStmgui9/6il11mmrKjafbMa0ugs8TB
 HSb8++W0Kd2N7biJuo6DCnRRoebh9FXowUai5jV0mjLh/MCNk3A/ny37cpxLBATb
 G28r99jmr+qM7G1FoAzAsKInKQsHw==
Received: from ph7pr06cu001.outbound.protection.outlook.com
 (mail-westus3azon11020099.outbound.protection.outlook.com [52.101.201.99])
 by mx0a-002c1b01.pphosted.com (PPS) with ESMTPS id 4g8sy9arjw-1
 (version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NOT);
 Tue, 25 Aug 2026 08:23:57 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=xuYUJWZhBb5m7nMRJ1vIvqcxuwpVXOWMa/IkTYW1TirYwt82I0qCLxbbjVdZwk8pAJyGuIUr6bbxI5G3aS4YUS8k2ggCu5iGuMlPbT0wRD4Fxpy8p5fOj06S+JVipIuV6qo8Njz8BzPyxtckyaSlrI8KW/Amy1j71fypPRO3DwkQK77ZBDha55N5vYhEY4w6Ck3toKRu75HSEtwnGVG3FDVSQBZ/+ohz3Up9cpKl1+iiKt50FlhIg6+f1tRIvpyl10APdVZblvxQyDNlzQW73xG2LLxfDTjogw2j/utuwzTll1j+rqJpf41Ap/bdImDQ9xJqKpx0D4WT2VfNy1iAsA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=E9tg3d7QpZ+c/HsqMOYoc/D+y4XEZOl354wqQcbxisg=;
 b=sgOiJpJLGswSciO3Xv+Qbh5JH+E1MZtyCUD09yIXCVqjaCE5q+z1VDuyS2IuGdkRWPp8D8a5cNpX114Y9faEDc5h+02gsmycgBPvlqsilnCWyPH9MCVMeqk54vE9wcgm19qzY0nZ8CUfi9GMvq+cUAE9K+nBwTjXYSx5F7ZO3LBn+mgqnid26Yejms6hZ/QC9Bqaxiz3I/xC50IWV5Som4pSDo9H3tsk9V2OFZqPAUB9NCsFuA+PL/WG/ENdKvib/rNtzfpIR2YZ6qqkRkqE12K+hv+KfENDUC10WRb3h/rksVgcI3TMFkzNfuu7KCc63A3/86Nef1lOWVDTTa2zMw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nutanix.com; dmarc=pass action=none header.from=nutanix.com;
 dkim=pass header.d=nutanix.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nutanix.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=E9tg3d7QpZ+c/HsqMOYoc/D+y4XEZOl354wqQcbxisg=;
 b=k6NayMHVyfM8KuYd/5tA3tEoM05VZQ/sGuTvHhc73twXBbKHs2FP1OVNcm1x8eDnRp+PvcZpJEWdCECEJPf8gPDqWGsR1FkV88kVZMHUE+Qx+sIMJgr3MTyqEG8qF40qBcklFMglgvWU+AeEhXhy/dQ7+Kb+bWIs8BM5Q/qfc/JCbumCycXd6Oh8rWqXZ5rWLSHzLa/QfUaVzeC+9jlwblBStBsocjQnY/rI6gV93HE+XjMvf6jBN1K5phUBebS9YMkBf5dGT2G/zLFMCWjDAPdB7A26xTOXUHMPB9XU9Qw3Dc8eOKuX8iL9WPhIEp8PXpfkUAey2vSvcCNhO0iPZA==
Received: from PH0PR02MB7159.namprd02.prod.outlook.com (2603:10b6:510:16::8)
 by BN0PR02MB8192.namprd02.prod.outlook.com (2603:10b6:408:153::5) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.360.6; Tue, 25 Aug
 2026 15:23:54 +0000
Received: from PH0PR02MB7159.namprd02.prod.outlook.com
 ([fe80::8e97:bc32:822c:b250]) by PH0PR02MB7159.namprd02.prod.outlook.com
 ([fe80::8e97:bc32:822c:b250%3]) with mapi id 15.21.0360.005; Tue, 25 Aug 2026
 15:23:54 +0000
Message-ID: <adba45bb-8e72-4226-9ed9-0cf67814da65@nutanix.com>
Date: Tue, 25 Aug 2026 16:23:50 +0100
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3 41/74] hw/acpi: fix "node" properties typename
To: =?UTF-8?Q?Marc-Andr=C3=A9_Lureau?= <marcandre.lureau@redhat.com>,
 qemu-devel@nongnu.org
Cc: Markus Armbruster <armbru@redhat.com>, Paolo Bonzini <pbonzini@redhat.com>,
 =?UTF-8?Q?Daniel_P=2E_Berrang=C3=A9?= <berrange@redhat.com>,
 Michael Roth <michael.roth@amd.com>,
 Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>,
 =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@mailo.com>,
 "Michael S. Tsirkin" <mst@redhat.com>,
 Igor Mammedov <imammedo@redhat.com>, Ani Sinha <anisinha@redhat.com>
References: <20260818-qom-qapi-v3-0-24b8bbbe3d86@redhat.com>
 <20260818-qom-qapi-v3-41-24b8bbbe3d86@redhat.com>
Content-Language: en-US
From: Mark Cave-Ayland <mark.caveayland@nutanix.com>
In-Reply-To: <20260818-qom-qapi-v3-41-24b8bbbe3d86@redhat.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: SA0PR11CA0152.namprd11.prod.outlook.com
 (2603:10b6:806:1bb::7) To PH0PR02MB7159.namprd02.prod.outlook.com
 (2603:10b6:510:16::8)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH0PR02MB7159:EE_|BN0PR02MB8192:EE_
X-MS-Office365-Filtering-Correlation-Id: 212a0c9c-6d62-457f-463d-08df02bce021
x-proofpoint-crosstenant: true
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|1800799024|366016|7416014|376014|23010399003|18002099003|22082099003|10067099003|56012099006|4143699003;
X-Microsoft-Antispam-Message-Info: Dok63e4VT9SVZ3xsJU1qaBAMSXImo5at9kNUsSPjnfH3cHO3Od3opCCZbfzeCtTDjpSF3E0NtwICOc6BttzN3f4fMI5QPVA1WJC+hU+4vYJXAWGhcFXjNI+YbGhlSR7Gpc79ct203nW9j62OE36MaVp8H2fao9S8njie9blbVJkQXtphx3xgzSDCSqTF4dEiiBqEosi6SvEQ9IDQZHNy7rIq4M6m8fRmAgWPCX0suh38D5hWGGqXle7qNQLCNECpYu8QeGRkEh9M4i0WVZhomrTOtUY5j/skPIRGx7Xf/W8U0+P3fnBiSjZi3PQrXHDRIVhMAcC7KIQeS+HbE+Vp9A1N5GP9wJtBkVCHidZ+qRzp4Yfcx1tS60LLdaCs5IXUg/V2lDtV10nzGdqw0ng3G0bszr/u9SVQpSmLA2fBDcF/78lu2LYTkP/UMSmScC+N6PJOU1nQO9KeJylC6ZF20G84vd2fL8ttL+Sej4u++gl4HnbtmcLNqDJIXwzBgnzAtqyWw0fMcj/ISkp7Atrx9wubpuoXO7xyfAfJe+5yRyymmzw7XbFbtUEpe901O4G4G+B0bv3xgJnQ8JeVrKaB1Pi4P02Bja2y1Iq3JdJJG2b9+sP3mtho1xvIIiJM4HwfcXEqIlizJ1/HOtTms7Er6A==
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:PH0PR02MB7159.namprd02.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(1800799024)(366016)(7416014)(376014)(23010399003)(18002099003)(22082099003)(10067099003)(56012099006)(4143699003);
 DIR:OUT; SFP:1102; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?YTJ4K0dEamRTNUdKYkxoK1VKSkxieVNIeGh6ZXNiVXd0SkZYVGFucHV3d2Fp?=
 =?utf-8?B?ZzJxWkFoMjNVNU1Nb0lRdnZlVEVCVFJsQ0RjRCtWdWpOQWZPK1E2Y25id3dn?=
 =?utf-8?B?Q3FyTTN5cXR6cUFHUEpoWkd4dUNwbVR3SDFpYlJCdjRrdGx4VzZXSmVvcUxu?=
 =?utf-8?B?OGhsMWp0Y0UvZEpOWlNpMVR3SnN5NExsMXV2NU1QOXdTWWc2SEZ1OU8wOUdD?=
 =?utf-8?B?ajZRSnJKR0RTR1Y3UjFBWVRWeUtxb1NxejZMeWt1MCtZeXZMejU3TS9KZWFG?=
 =?utf-8?B?dVhiU0ROeDI0bVV1Nnd2RTVoRTNQaXM3U0dweWhlejI2U2YrcUVxcVE2RC9B?=
 =?utf-8?B?bzFkMU5nQU9mdEVGZ3ArUUJsRktIVkRQYkZIdkhkeGRCK2QwaUptaEhDMExB?=
 =?utf-8?B?N3luUDZvV0JnS2d6am9zbGZ6cDFSYVQyNEJFWExTYkIraGVwb3FCSm9Za0RE?=
 =?utf-8?B?VmRveFg4S2xYTXUyTXBCd1d1VittOGxnMGdrYy8ySDIvZ1NnVmF5VC8vUXNz?=
 =?utf-8?B?bkVWdVVpSndLU2VPWGQ2TVlmTE9yV1Y1bk5pWHZtOEprTGZkNy9LejIrUElv?=
 =?utf-8?B?OGVtaTh0RzBrQ3Y4MUdEaTVwU0g4clVZZmk2cDViT1RLQkhrRHk0UUE0K1JF?=
 =?utf-8?B?VE5GVzBBTXR3NERmdUdxWEN0ekRDMG5yYVlPZXFxb1J0TVVTMnV4dzJjVTds?=
 =?utf-8?B?MU9FTXV5Z1pselp0THh1KzVDZVVuODh4SjFDcVUwRXRpVDFVK1ZBNElYWW84?=
 =?utf-8?B?dFdteVFta1ZTcWQ2VkJleFVQZk56SGVOL3dscXBJVjZGQ0JXR2o3N1h3TVhx?=
 =?utf-8?B?L01McU5pRzJwekI5TGV2QndFT3dxOXF2WnFMRHFYWW9ocDN2WVQ1SG9NRjRE?=
 =?utf-8?B?Wk9JSTFWQmJCcWU1dDdrSDNZYUYwSmpoNWdZUFBVME04Y0dLUWxlczAxQWFY?=
 =?utf-8?B?VXdxYlN1K2ptWXpkcjRlaTJUY2Z2UldtOU9wVFJMV1lGN1U2SnFkaDFISCsw?=
 =?utf-8?B?T0JSYTJxUUtyMW1yNE9yaFM4SFJxNXNxeUVvYUd0U3NSMlFSZDhFaFRObzRS?=
 =?utf-8?B?enNDTDdBeEtFRmdDYnBqZE9uZUZLWlhvcDRud0plVkowOCtSaUtYazdsNHp1?=
 =?utf-8?B?UW5uS2toblBGd3kyMjFUemxXOWs4T0Nwa053UnRPZ0ZmSHNXK2l4YVNlL3hm?=
 =?utf-8?B?TlR4S2FFdEtWY2M2RUd5T0FqN01WakdNdVlONVg4ZjhQVkxNMk1nVG5ta2hE?=
 =?utf-8?B?Yjk0VGtRRFhOK2Q2a2dXL1I3SEJOKzNBcFh5aGVzTTByTEVIMkRqZlJ1UUI2?=
 =?utf-8?B?SGhpc0R0SlJHTzRMK0FGZk80c0dNYXVPZWFkV1VTUVlrQ015bVBKWThnUnFS?=
 =?utf-8?B?MGR3dm5kVXRNYU5aZVZFQjNSTlhuV0RzdVRGMkRzMmlxUmpzK1YzQTRVUDNz?=
 =?utf-8?B?VXJyRGM1VG41eXJXcExXWmxnZkpjdlovK2Z6MDd0a2tXcjdlSVA3NnFqQWRo?=
 =?utf-8?B?aGY2QVVzeVZmVFphSE1mRmFhTDRKWS9QRUpJWlhVcmxacndlanorVlFNMlZR?=
 =?utf-8?B?ZVZ4cjdVY2pHRnI5MDQ1Qm5NeENNUkYxVDZpbGVlbEtNMWVkeTA5MFo2SXhn?=
 =?utf-8?B?ZUwrenJVcDQ4Y2RlTngveSt0aysybGhjSERvd014N1laOHhYWHp1M0tmOGRH?=
 =?utf-8?B?aXFQVVAwRFhLVGRmdjdKR2owMHZaTEwwdDVPNXpLbzJ4UHIyc0hxZEJVeEpy?=
 =?utf-8?B?elRKUStHOVJaalZwK0IrSzZ2WTF6T0M0V1ZQWi9SM2VWZDZrZHBjbWI2MHNF?=
 =?utf-8?B?WS9yaEtOMERBZHVBa3lPSTVJbDVUZE1ZU2hqY2VSRXN3REJaZ29wV3E1MWdm?=
 =?utf-8?B?UDBBWXFDNTZJM2h3OUZvM2tvbEFUWUtUZVViV1dRY0N1Z0R1L0RjTWJjbXJE?=
 =?utf-8?B?M2syV1drbktmOXZaeFY3VThIZThYR0dYRE01SHJ3SmFuejRtN3hxc0dpREhS?=
 =?utf-8?B?cldqdDVmT3d1Wm5ONWNqZHRlQ0NWRzg5SnJvYTdFZU5EVnRMTklKSWRZcUlW?=
 =?utf-8?B?SktRT2Z4b3hoZXllcnFUWTVqbEFDZ0c0cVhjU2MveWtvT1pUNXZ5Yy8vTDJW?=
 =?utf-8?B?QlFodWJsRWNwRzltb0Yxck5iMmhQU3RpR3lGVTZkSW8rNnhiOVU0NWJGcTFl?=
 =?utf-8?B?NzF2YnBJMU9Jd2Vmcmg2Q253U1diTkNXdHZEaDQzZDBzSW8zcGVZVGljc2Ex?=
 =?utf-8?B?N1lhbmEwUUdvQ2poZE1KTGxwT3JTZy9Ib3o1S1JLMnpLMUNGUHcxTkxFNDVm?=
 =?utf-8?B?Wml4ZUNWeW5DSTJVdjdsNWpNT3Y2RjEwaUtQZXpDUkFRS05OOHJ0SFNYL25L?=
 =?utf-8?Q?/3T9n+QYU6spyS9Y=3D?=
X-Exchange-RoutingPolicyChecked: j/4ql7K5MmYnYw2TnQwLy3Iz4VL4YNalUMkuKgjJVS723h8Gvqi5uPJ4Q5I8vU8uCLXb/DRxyM06p5yvVtu2W2/kbDKhVkk0OOEHBcEHs+C92eBO2NBxE3IrL2q4bQSTECaHyRA8voH2YL8mp2edkkfi3M09d18FNdqL/jkm+iqT7DAyrWoz3Cj5y98j6eJW6hQGJaGBIhqcFh6Ju5ZEdltpHLbP9WF4ke/3UDPs7xRyivSV4QD4j03m0Fxz7RmcZibhFXHI277teydMPdH8OhICwq5JhDEOQaUffz9gFkHbEg82suPrm9z4BHMCGRVr3eqJ3aUq5hGY9b9vr3ZAog==
X-OriginatorOrg: nutanix.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 212a0c9c-6d62-457f-463d-08df02bce021
X-MS-Exchange-CrossTenant-AuthSource: PH0PR02MB7159.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 25 Aug 2026 15:23:54.8310 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: bb047546-786f-4de1-bd75-24e5b6f79043
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: E4aQU/lrbcYeKqv5G3CMi+eIBdZKYRxyCk2Ik5QYUuSDGAgdp/NUfwsnE+RLWI+qv3AzpytY6iu5AKU67HP7uLzprdYMWN/DmGswy5KB/Uo=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BN0PR02MB8192
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwODI1MDEzMSBTYWx0ZWRfXyiDun6nCmWyh
 UUEtokkd700KjQgTQd6e3PICsliotZM0u5JNS6+BzvI65MwssIidkmBDBNj566bfGIxllm7cAl+
 FfNqhnjeZmtEiH9XVmfvdFgaeraeIsii27A52KjkJTNlZfDY/by2IFEp8egwxDLu5meqRC3b3uq
 DQbZuTkrilNS5r8+S0U2Hne0ZqUA6oxl7+1hnV4ZAkMGQ5jo5I46He+v3LpaAHEhnlJec1d4iMz
 3gRFio8IoSGaAzdCojTlajgCRWbDfa4JtTwdPBCgUsXKSLC9C8AouResp2F7kwcOHmT/3Z+wPlL
 WlDBgRArNy1RPd0fNxibZ5/wqmX1ILk7d1kDVXC9XjJhQ1Bmk1nQ3gviw7W4lD0lfMaKkCtiZMK
 bS68K0XslUm2y9sT6e+4Y8y/wUPyR9NESApi160nEaKaESI6p0f9IhjHzE70vqvel5wFDRqMfCl
 f9yiCQCfwfVue/8UP0A==
X-Proofpoint-GUID: Vsf_8Az2ikwEXgdT6_hgBGEUbGvz1qPG
X-Proofpoint-Spam-Info: AW1haW4tMjYwODI1MDEzMSBTYWx0ZWRfX/1lWnuB1o6uI
 ro0UWh3277UUwnoj5dSvI0x8ar0cknoxJQGYA+uFiwyJ3cURCa3qr74ZU2VzYk/knAbKSO8aZNQ
 QVRnk2VC4lpEKZ6cYrnZBHjk1ELCtfg=
X-Authority-Analysis: v=2.4 cv=W9AIkxWk c=1 sm=1 tr=0 ts=6a8db38d cx=c_pps
 a=kJh41/vVy0mmRivLipeQDA==:117 a=6eWqkTHjU83fiwn7nKZWdM+Sl24=:19
 a=z/mQ4Ysz8XfWz/Q5cLBRGdckG28=:19 a=lCpzRmAYbLLaTzLvsPZ7Mbvzbb8=:19
 a=xqWC_Br6kY4A:10 a=IkcTkHD0fZMA:10 a=Sv0fKeRqtYgA:10 a=0kUYKlekyDsA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=VofLwUrZ8Iiv6rRUPXIb:22 a=Ap8k9tRZuQ82DLYWQqG7:22
 a=20KFwNOVAAAA:8 a=64Cc0HZtAAAA:8 a=kFuP2k2SZqg43xan0SQA:9 a=3ZKOabzyN94A:10
 a=QEXdDO2ut3YA:10
X-Proofpoint-ORIG-GUID: Vsf_8Az2ikwEXgdT6_hgBGEUbGvz1qPG
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-08-25_04,2026-08-24_01,2025-10-01_01
X-Proofpoint-Spam-Reason: safe
Received-SPF: pass client-ip=148.163.151.68;
 envelope-from=mark.caveayland@nutanix.com; helo=mx0a-002c1b01.pphosted.com
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

On 18/08/2026 12:11, Marc-André Lureau wrote:

> The setter uses visit_type_uint32, not visit_type_int.
> 
> Fixes: f74e78220dbf ("acpi/pci: Move Generic Initiator object handling into acpi/pci.*")
> Fixes: a82fe8291643 ("hw/acpi: Generic Port Affinity Structure support")
> Signed-off-by: Marc-André Lureau <marcandre.lureau@redhat.com>
> ---
>   hw/acpi/pci.c | 4 ++--
>   1 file changed, 2 insertions(+), 2 deletions(-)
> 
> diff --git a/hw/acpi/pci.c b/hw/acpi/pci.c
> index 8c7ed104796d..c82924be8620 100644
> --- a/hw/acpi/pci.c
> +++ b/hw/acpi/pci.c
> @@ -139,7 +139,7 @@ static void acpi_generic_initiator_class_init(ObjectClass *oc, const void *data)
>           acpi_generic_initiator_set_pci_device);
>       object_class_property_set_description(oc, "pci-dev",
>           "PCI device to associate with the node");
> -    object_class_property_add(oc, "node", "int", NULL,
> +    object_class_property_add(oc, "node", "uint32", NULL,
>           acpi_generic_initiator_set_node, NULL, NULL);
>       object_class_property_set_description(oc, "node",
>           "NUMA node associated with the PCI device");
> @@ -253,7 +253,7 @@ static void acpi_generic_port_class_init(ObjectClass *oc, const void *data)
>           acpi_generic_port_set_pci_bus);
>       object_class_property_set_description(oc, "pci-bus",
>          "PCI Bus of the host bridge associated with this GP affinity structure");
> -    object_class_property_add(oc, "node", "int", NULL,
> +    object_class_property_add(oc, "node", "uint32", NULL,
>           acpi_generic_port_set_node, NULL, NULL);
>       object_class_property_set_description(oc, "node",
>          "The NUMA node like ID to index HMAT/SLIT NUMA properties involving GP");

Reviewed-by: Mark Cave-Ayland <mark.caveayland@nutanix.com>


ATB,

Mark.


