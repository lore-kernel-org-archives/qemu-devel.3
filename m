Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D37B8C4451B
	for <qemu-devel@archiver.kernel.org>; Fri, 17 Jul 2026 13:53:41 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wkj0D-0006Gm-TD; Fri, 17 Jul 2026 09:53:21 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mark.caveayland@nutanix.com>)
 id 1wkj0B-0006GF-IX; Fri, 17 Jul 2026 09:53:19 -0400
Received: from mx0a-002c1b01.pphosted.com ([148.163.151.68])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mark.caveayland@nutanix.com>)
 id 1wkj08-0002Vc-I8; Fri, 17 Jul 2026 09:53:19 -0400
Received: from pps.filterd (m0127839.ppops.net [127.0.0.1])
 by mx0a-002c1b01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 66HCKVgl3845121; Fri, 17 Jul 2026 06:53:09 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nutanix.com; h=
 content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=
 proofpoint20171006; bh=9AqjsrBgaFrMig/55bHUTCPYN6bCAwg0FrDNdKfX/
 aQ=; b=d2uXGNGXwLldJ7sYcAD2QvuaLbPu4dNYvuCsS6v1Ps9v2fGpkEs1jy038
 6PkQE4kyPYx5rqcIauoyeg65rt8XEpPoJLHRTxuDGqlklxnuSYgWxv4yF6uKDLhM
 H3MEWs5KKm+vR8unDXu3kFbINJPE2hoWgwKRd5yjdCDz2KANliqcMcayzJvAeM6H
 5RSIdTUXf93YGlC16oJbD23yKvecS8I37lZTVDM5TnbeUZMlLEVoMqLvO+o0IYW9
 2Sx1GkwPt5giCRlN8ZJkqYYso5OFExHh1zoRmYNjLkXZvqFAxysLOdIn+JTIOVc+
 z6mMfbo3/JLVkvn8Aedm2m/NCugwA==
Received: from ch4pr04cu002.outbound.protection.outlook.com
 (mail-northcentralusazon11023097.outbound.protection.outlook.com
 [40.107.201.97])
 by mx0a-002c1b01.pphosted.com (PPS) with ESMTPS id 4ff2f9jm3m-1
 (version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NOT);
 Fri, 17 Jul 2026 06:53:09 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=xGfBS+HjC66pzBmE0Xe4ZaqmT9IvvobKJXtGaQwl8PMbOtXXzmnuLyokMMsEM5FuFvum0NBMaL/n71WkGlGeVjyP0NbAd5a3eJgMY8ZyzOe+Qx6Tr7+HFEytz4xNUaRXqOBRBEi8Yr7pK+2Qv0+ihNkGqFqaOAilHyZgDW1c3GKhbFWEFYky9jnG0p5CjbYFqxbHaWvZunrCFhzCX4keNzbmdKAtsjtALI48Z0rZyJPH5Ore/07yoZ8jde9G2lwYaPCUoER1RWXsaCrfV6DyHAyoatH4FXXkV6xQI9guKShu8DK2HCrzYmw6MMH+e+198pUSpUgAbaHzE1Zmz7zObg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=9AqjsrBgaFrMig/55bHUTCPYN6bCAwg0FrDNdKfX/aQ=;
 b=wWEqhGBC3/a+rJ5Grpn+XOSmgrgOuyUGvC3JbVZHLPEYP5vdJ6tUs+9nayhyIg+gH75Rs0EjHMLosg5GH2ZhfUsHxYz5D6JJTk3rYpl39q2S/qhLEB6lXtA1cJJxjhWsFZWz+gEwec7QAR0/wNeo5WqZyLqvJJHGRhOamF6Kqpwmu+jl34jYM69aby0mz1RzVJ6OxhANNQxstOm/lr0kHcpfmH2JP15AVhFL5GBkYPsIxIXXwceqJ7JzcpxeITwAtvO4Y38YVzIcvPd4QdhizbfKv5S9ve9Z4bjYVEC34M5YBaT8N2uIFFaz/K3bBv2GsxOdVpTWc5thBDnD0EMOHA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nutanix.com; dmarc=pass action=none header.from=nutanix.com;
 dkim=pass header.d=nutanix.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nutanix.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=9AqjsrBgaFrMig/55bHUTCPYN6bCAwg0FrDNdKfX/aQ=;
 b=NrzySVZI8vtKGPtx+GUfgedcXWwkdu0oTpAGK7UTNPGIPBigSkrmY8bm8/SOYYFk5Z2s9mlo0uOAaRs+8u8J/RQtIUM/CymNl8pGIYhNxWW2RWtIyosA8KyMkxEYWotZY/m+sPeWQ0us0H7fKyclX4wSWh9R0qUvb5WEoSVz/2LKVCyW78y4goxR2uWlP6CwXIBOuBZJ33yTp8WnRsCkcmefm1Cr42e8OGYdOUSWBW+SfPPFbg8pDn8uOwhZyqTnwuHcGIaSyzeRdGmwt1+a4fxbQkALIjhG9whXYA1YM2rOueJO3ISaQwiyT74Ak7ptN2da47yGwA8aK5VDMEgsuQ==
Received: from PH0PR02MB7159.namprd02.prod.outlook.com (2603:10b6:510:16::8)
 by CO1PR02MB8540.namprd02.prod.outlook.com (2603:10b6:303:15b::6) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.223.9; Fri, 17 Jul
 2026 13:53:06 +0000
Received: from PH0PR02MB7159.namprd02.prod.outlook.com
 ([fe80::8e97:bc32:822c:b250]) by PH0PR02MB7159.namprd02.prod.outlook.com
 ([fe80::8e97:bc32:822c:b250%3]) with mapi id 15.21.0223.011; Fri, 17 Jul 2026
 13:53:06 +0000
From: Mark Cave-Ayland <mark.caveayland@nutanix.com>
To: palmer@dabbelt.com, alistair.francis@wdc.com, liwei1518@gmail.com,
 daniel.barboza@oss.qualcomm.com, zhiwei_liu@linux.alibaba.com,
 pbonzini@redhat.com, berrange@redhat.com, qemu-riscv@nongnu.org,
 qemu-devel@nongnu.org
Subject: [PATCH v2 2/6] qom/object.c: introduce
 OBJECT_PROPERTY_SCALAR_SETTER(type) macro
Date: Fri, 17 Jul 2026 14:51:42 +0100
Message-ID: <20260717135254.508701-3-mark.caveayland@nutanix.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260717135254.508701-1-mark.caveayland@nutanix.com>
References: <20260717135254.508701-1-mark.caveayland@nutanix.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: CY5PR14CA0002.namprd14.prod.outlook.com
 (2603:10b6:930:2::12) To PH0PR02MB7159.namprd02.prod.outlook.com
 (2603:10b6:510:16::8)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH0PR02MB7159:EE_|CO1PR02MB8540:EE_
X-MS-Office365-Filtering-Correlation-Id: 94c0d521-67f5-4df7-033e-08dee40aba66
x-proofpoint-crosstenant: true
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|23010399003|1800799024|366016|376014|22082099003|18002099003|56012099006|10067099003|6133799003;
X-Microsoft-Antispam-Message-Info: ZkKXmPnkWApWZ88poIviiRR6jynIqGKbPBNmR2P7ufgoF5lyQnRm6GkWJj4KVxawQaP3uPiK3/5gprqorL5BAu6eNkbY+AuYqhlURiPrNsWGSHQUHlE9Gzl70dCttxNJbFHvNzJ6qS1t1MhBbd9k1RZJsW00eKR8vaZXQc3bOB6UZJ2jD7y69N9A5/M4/0C/Cj1VT8yRGAWZip4aLeHRvGUUmoewWGTVCLozoM5uM9/CZaJmwTA340+zKosCSLXSsUb3TXCVi73H9w9tsGpZyTpWIYI/iPCSevaAV5033Y8hlm3aQVItpPkHcXRHPXnig37FpgqYJ7aktl6/UskkFXAF3fRtrHDa56cU/rgfKvt4bgwMh2hdDjq5ymRwz2aBAIjfmgqVacKot5Bt5GCwFiEy97uii/FE2bzVto5Ei3Ldvm6UhbT3yC0SkWnV1vQbpYrbMTLPqCj2ow/GT/0kM6w0oHVC556MLUOQPiXjoCOnKASQMU1S/PPrWUA25cFFK1XgDc+hXaipsBO1wereU7K33vxmHHsOLjaBiYAgSrPT0Je8CsapDq1ixG9YxsxqOLi/pgf59MWzqV8gPNH/7FPL307YQ8/1Z9mFMifTjeZS96OXRf6LhlwkyHTG4BILY28H+kzQYB6EXVTBZDr5vRwd6tTe6eybEf21+79RnPI=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:PH0PR02MB7159.namprd02.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(23010399003)(1800799024)(366016)(376014)(22082099003)(18002099003)(56012099006)(10067099003)(6133799003);
 DIR:OUT; SFP:1102; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?MW1Wa2drMk0zWEFDNVlPQUVXd3FNN0pDZFJxRENLcXROWnhNZXdPZ0pRVklX?=
 =?utf-8?B?Z2hQQXV0M0xoRE15OXR5NTdlNVNTQnBaTVpMRnJ5UWlLdVBtZGEzbWhCaUl5?=
 =?utf-8?B?WU1sT2VlYTZaamlGa1ovcHUyQjMrRWVEb2ZyV1NYV1NoSFJKZWZXUnVBOGR6?=
 =?utf-8?B?QVQvQWdaSGRobnZsbGd3ZWVEai8wakFrV1ZJazVESUczaFNtWkJ2ZDdUVkNY?=
 =?utf-8?B?SmQrM3E2NHMwb3E1ckU2eUg2R3pFbVNKd1BybC91UEF6aGpPdXIwclRtbk9x?=
 =?utf-8?B?YW04bHFtdFVNYVRqbCswNHI4NThrRWdmaEJVaGxTcEhZUTVIZ0hjaC9sajlS?=
 =?utf-8?B?VEZLTGhGRjgyWGV0emNSOVVaMkJrUGJ3YUpFTjNDL0hiZUtUSEl5aEdpM0J1?=
 =?utf-8?B?M1VhWTB3NWdWQWI3eU4zVEhYSnRoRXBZMWZyLzR6STc4b3Fob3paTFh5NXpp?=
 =?utf-8?B?U2FsUnpYcW81MU1sVTYvSGJuaHlRcWhGNm8vZ3dPdFB5RXp4TUhCeHMxbnhv?=
 =?utf-8?B?VW52eWNyaFJwVmpnQS83V2dNTWY1T2d2Y1VNcURDaFdDWGZSM0N0c1U5ZnNO?=
 =?utf-8?B?QVdNWEFSWEFzUlAwaHFZWDFGVVBpQllBRjNyZzRkKzlXZk1pWGU4SFFESWxV?=
 =?utf-8?B?NytUemd0VW94ejVqWitpNm1FY1hCNGU2VDVlYWp0UjFqUU5uQWtDRHRJVE1q?=
 =?utf-8?B?RVEyY21VNUw0QzRtNHRNcmpOYzR4YkNqRXFpTVYyZjhOTnNhRkhqamFkTDJI?=
 =?utf-8?B?YjFnWE1EQUhlZStsaDA1ZXdvY0VRV1ZDOStEa1BQTkk0NDA2WjB6WjlUdFp5?=
 =?utf-8?B?T1BmTGdrb1V4VjNlSzV2cFZFczRRTys3QXYrZXJiRVpIUEpHQUhKTVFReUJH?=
 =?utf-8?B?d2xmeHhXeDRnT0h2SzgwbTF2M3hkd1dZYkVhWWFPSlVPa29MTjdRUU5HMkUw?=
 =?utf-8?B?VHlkNW9Yd1AyZFd3QVpPR3FjOGtneGFVRHB3bFZoMkN1UTV5dnR0N3d2RHNB?=
 =?utf-8?B?aHdNaDlIYmpCSEV3YlVmQjJ2U1pQakJQWVBLL2dCeDk3eDV3c29FTExWYWx0?=
 =?utf-8?B?aDIvNUxmU1dZa3c3RlQ2dGRNY2FwMDV6NDBZOG9CcjREb051czFoNHpEdlNG?=
 =?utf-8?B?L3pNZlJYRVo3MjlZNFcrTXdIdXN6aURZdVZzRFpjWjQvWm9WMUwySWN0Kys2?=
 =?utf-8?B?TFVxSEwreW9rYXJhblVCMmtxdUM3UnZneE5nYkxkYStod3FaRExHN0lnY3RD?=
 =?utf-8?B?aFpiaWpQNk5GNVBVQ0tkdkxUTWtoanNkMEhWWmc2bzdLa1RoSkozdWtkbExY?=
 =?utf-8?B?MFJJNWVpWFA1dnExYXlMdTQ1OVdsYjhhTDV5ZFZZWVc4elRyUktEdXlEMUh3?=
 =?utf-8?B?VEdmY3BIcEhOQjJucmFIMTM5L1FLbGlhUTFzZG5Md0w3TjBPUzFYWE5JRjNP?=
 =?utf-8?B?MGR2RTFkNTgrQnRTOHU3dE0rT3VPb041Ykt3cDVqSnBOSU02UVIwSHlQTEJr?=
 =?utf-8?B?UHRlY3B6Q3lPeTlBYVp5bXh5akRyVGZSUlJsUTl6dzBqMC9PWCtNOCtiYXJM?=
 =?utf-8?B?eHVSVmdVaEFBdEthWTBPYTRvSHdRa1pWU3dWeWpjdnlYbzRyaEc2N3dVaFc0?=
 =?utf-8?B?azU2S1luMTBjbUR3QjFVeHBhMitZTUdVN1lranhUaGMwUENqbFVoUWd6NmY0?=
 =?utf-8?B?cnRFRkUvc2l6ZmJhOVliYWQ5OEVGYlU0bXZuV3NxUDBBOGNuenlpNDUzSDNB?=
 =?utf-8?B?NkpWV1NGN3QxSy9yTnNtdUY0OTZCdjlNZlgwcnNPMWJZUTdFNnNDd0FNNWJj?=
 =?utf-8?B?eDUzZHBUcTlkSVR5ZjJMZ2phMTh5a1NpWFB2dkt2OHcyZkY5WGlvcFQ5cUFH?=
 =?utf-8?B?K3lwVzdmVjkvc1hGaktqWlZrTkswOGdQQ0JCdS93K0NzUEliL0lCd0FIdU84?=
 =?utf-8?B?dm4wbitrV3Q2MUUwaXhhc25vVXZIbExIWVVtaE84NkVNc1ZSMFczRHoyV0hx?=
 =?utf-8?B?T3lxVG1jUTFpbnk0NGtUcWljaUNrUVJaeVNHdlFQbDVoT1VMUXQ3cDg1eUhF?=
 =?utf-8?B?L3Fmb0ZZaXk5VjhON3FsRFZJNysya0sxYXQwVm9XNWZCcTJhRk11aWJXZi81?=
 =?utf-8?B?dno4NDdKb042NVJ6ck5RNkEvM3N4RXAvZjFWVWRCbDZwQktrOW1wNGo2U3hW?=
 =?utf-8?B?bzUxZkpKVEw2RlZEZzcvcG42b2FxbDNSenRCOFhwNHlXZEN3d3BxeU1XWnhN?=
 =?utf-8?B?d3ZHM3R6U1lsdXB6N3pneTFjNnMxMHA1TXZrQWxYSDEzRVJHMDJaL1N2dFNW?=
 =?utf-8?B?Znhwem5XUVRpdXc3M1d6ZW5EanBQM2J6NGdZbTFrUmQwbWMxSmF6UGM1TjF1?=
 =?utf-8?Q?4Q3fEq1jsDa/r9ew=3D?=
X-Exchange-RoutingPolicyChecked: KaMgvwCmiMe+tbd0L24mxgdkl13KhpybiS+0zLgWj+d+eJws3hX//+BDjdsydZLf475yG8mW5C3V/BsSHqpmXZYbn3XGtU37eyrOiREzr8mRVCE4kUc878xX+7IxV3M/XN4+EUf8dytgG0iWuEth5qr9oxUFEN0wTRtxcip40J2oUDTbIVmwHlY8Lvn7Shg3FMFdlpOLXdfjbAHT3zY4KIUD5So/4PR9o9vykNirdxjQe77XCzU5IpiK99Iuw6UoWh1Aj3vRam6n3oHUtcjqzgEHMiMQi+HwGRTwT4TcrS8g+Q1O/Y828ctxONrLoU43G5MpjyGsR64uke3Z2GeCjg==
X-OriginatorOrg: nutanix.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 94c0d521-67f5-4df7-033e-08dee40aba66
X-MS-Exchange-CrossTenant-AuthSource: PH0PR02MB7159.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 17 Jul 2026 13:53:06.8776 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: bb047546-786f-4de1-bd75-24e5b6f79043
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: fGr7pdlkVS2ID7k/z4rvXXERsG08bdrZwrolR+5/Heg3FIJ24c320Wprn2aDvpxyQecz2r/8abyA1h+Z/rhIn6z8Y4z+M9OjEMumMt+/bOE=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CO1PR02MB8540
X-Proofpoint-ORIG-GUID: rWcg6IQ2AzG2cOXNojQpEFi09cXrFNAC
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNzE3MDE0MSBTYWx0ZWRfX9Ph1xEkLlv71
 QkNL/qz6DW1u027A5wuV2uFs/6HmuYHKaMjEwLHBFBXkp2GtiySqUpUUFxxSHQTAgFWIVlGWHrq
 UO1M/s2hUX6odjEPIkArdOcpOp++XWQut3l3kZ27ra+keRVOvOK99vTscv0lTbNYLm9Hv14WR3Y
 P68b/L/Wm+4pb0EI/iSn4XonRVsnoeNicSgqzqj6yYv4gaw/T/sR8fPg2vrbF6MpIP04BfeEWHE
 uFrFwo1BhgEDuxGGd9UOv9+upD8r2HgDs8L4K2am19ep3XIA7imImBnvZf2vKEnEYBkF9cHFeCn
 3ggeE82ukS+FWmjJ+elII5TjSI0SlE9VbCsORANEYB6jRTNAKjcAfsA/F89Y8/mFnyp6ye/YpNn
 Q/2WmXOvUKHvYskWRaL+4bmPIdnVvikg8kJCSgP5/6OPgQISgSP6lfOddPnYWlLQmzL44KauuW/
 amnHKhQYbsRDfYhvXew==
X-Authority-Analysis: v=2.4 cv=WvAb99fv c=1 sm=1 tr=0 ts=6a5a33c5 cx=c_pps
 a=XVr+MSEQQxWnM56OsALW2Q==:117 a=6eWqkTHjU83fiwn7nKZWdM+Sl24=:19
 a=z/mQ4Ysz8XfWz/Q5cLBRGdckG28=:19 a=lCpzRmAYbLLaTzLvsPZ7Mbvzbb8=:19
 a=xqWC_Br6kY4A:10 a=IkcTkHD0fZMA:10 a=RAioF0-LDSMA:10 a=0kUYKlekyDsA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=VofLwUrZ8Iiv6rRUPXIb:22 a=y4UcunY2MAxhM4LwGdWI:22
 a=64Cc0HZtAAAA:8 a=20KFwNOVAAAA:8 a=fKZFoM0pQB3ZjpgBshEA:9 a=3ZKOabzyN94A:10
 a=QEXdDO2ut3YA:10
X-Proofpoint-GUID: rWcg6IQ2AzG2cOXNojQpEFi09cXrFNAC
X-Proofpoint-Spam-Info: AW1haW4tMjYwNzE3MDE0MSBTYWx0ZWRfXz+rT1Efn6RRt
 4eN9DJOFASgf846tfeGQFxpxoslT8+0+TEb6Y39IM85fcVE/zAD9n/GBi+/bCRfiBcdqA5zGDHB
 iV84OLfyH1JNdytg6wNHcVRrn7FOOLs=
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-07-17_03,2026-07-17_01,2025-10-01_01
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

This macro can be used to generate the boilerplate property_set_type_ptr()
QOM set function for the specified scalar type. Replace the existing scaler set
functions with the new macro.

Signed-off-by: Mark Cave-Ayland <mark.caveayland@nutanix.com>
Reviewed-by: Daniel P. Berrangé <berrange@redhat.com>
---
 qom/object.c | 72 ++++++++++++++++------------------------------------
 1 file changed, 22 insertions(+), 50 deletions(-)

diff --git a/qom/object.c b/qom/object.c
index 34aef7ca9f..8a1f80f613 100644
--- a/qom/object.c
+++ b/qom/object.c
@@ -2671,62 +2671,34 @@ static char *object_get_type(Object *obj, Error **errp)
         visit_type_##type(v, name, &value, errp); \
     }
 
+
+#define OBJECT_PROPERTY_SCALAR_SETTER(type) \
+    static void property_set_##type##_ptr(Object *obj, Visitor *v, \
+                                          const char *name, \
+                                          void *opaque, Error **errp) \
+    { \
+        type##_t *field = opaque; \
+        type##_t value; \
+        \
+        if (!visit_type_##type(v, name, &value, errp)) { \
+            return; \
+        } \
+        \
+        *field = value; \
+    }
+
 OBJECT_PROPERTY_SCALAR_GETTER(uint8)
+OBJECT_PROPERTY_SCALAR_SETTER(uint8)
 OBJECT_PROPERTY_SCALAR_GETTER(uint16)
+OBJECT_PROPERTY_SCALAR_SETTER(uint16)
 OBJECT_PROPERTY_SCALAR_GETTER(uint32)
+OBJECT_PROPERTY_SCALAR_SETTER(uint32)
 OBJECT_PROPERTY_SCALAR_GETTER(uint64)
+OBJECT_PROPERTY_SCALAR_SETTER(uint64)
 
-static void property_set_uint8_ptr(Object *obj, Visitor *v, const char *name,
-                                   void *opaque, Error **errp)
-{
-    uint8_t *field = opaque;
-    uint8_t value;
-
-    if (!visit_type_uint8(v, name, &value, errp)) {
-        return;
-    }
-
-    *field = value;
-}
-
-static void property_set_uint16_ptr(Object *obj, Visitor *v, const char *name,
-                                    void *opaque, Error **errp)
-{
-    uint16_t *field = opaque;
-    uint16_t value;
-
-    if (!visit_type_uint16(v, name, &value, errp)) {
-        return;
-    }
-
-    *field = value;
-}
-
-static void property_set_uint32_ptr(Object *obj, Visitor *v, const char *name,
-                                    void *opaque, Error **errp)
-{
-    uint32_t *field = opaque;
-    uint32_t value;
-
-    if (!visit_type_uint32(v, name, &value, errp)) {
-        return;
-    }
-
-    *field = value;
-}
-
-static void property_set_uint64_ptr(Object *obj, Visitor *v, const char *name,
-                                    void *opaque, Error **errp)
-{
-    uint64_t *field = opaque;
-    uint64_t value;
-
-    if (!visit_type_uint64(v, name, &value, errp)) {
-        return;
-    }
+#undef OBJECT_PROPERTY_SCALAR_GETTER
+#undef OBJECT_PROPERTY_SCALAR_SETTER
 
-    *field = value;
-}
 
 ObjectProperty *
 object_property_add_uint8_ptr(Object *obj, const char *name,
-- 
2.43.0


