Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 51962CA0EFC
	for <qemu-devel@archiver.kernel.org>; Fri, 22 Aug 2025 12:15:41 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1upQf8-0001fG-4n; Fri, 22 Aug 2025 08:14:30 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mark.caveayland@nutanix.com>)
 id 1upQf5-0001eX-QZ
 for qemu-devel@nongnu.org; Fri, 22 Aug 2025 08:14:27 -0400
Received: from mx0b-002c1b01.pphosted.com ([148.163.155.12])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mark.caveayland@nutanix.com>)
 id 1upQf3-0000hm-Oo
 for qemu-devel@nongnu.org; Fri, 22 Aug 2025 08:14:27 -0400
Received: from pps.filterd (m0127843.ppops.net [127.0.0.1])
 by mx0b-002c1b01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 57M8EEUh714063; Fri, 22 Aug 2025 05:14:23 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nutanix.com; h=
 content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=
 proofpoint20171006; bh=u6zNLt7Qh69BjrPCHnqv5HHknreOucEItrzNywo3k
 8o=; b=L9clwnVzylkqcuqVWenxAVLeV5k3iQql2Q5YTczFT1VGz2X1umTgXHx23
 B4GRSdVvxNnHUUlSFxAKbWnhiCoKJB1zc6qxzWjpsovLXY4B2L3mCJUzR+klWB1f
 /giJZAZ92t6bQubNI3hc+6L6R7Vo95gZsRAeSfShgu0jb30oIPrygMseUJhg1sow
 dIfOmjzryillrJQ8X4R/PRV2Qs3EnVNXAJDekckLa7VwEezhvUVfdfm/Cts3UvVx
 Wdj26ehOri8jvMnUzIZs44xsjngguhVyNm5ubRgjRtfptvTG86fQLvs2ClhgnaW6
 Rv0VaQHycUvisLxKJHb2LUP2bFOdw==
Received: from nam11-dm6-obe.outbound.protection.outlook.com
 (mail-dm6nam11on2117.outbound.protection.outlook.com [40.107.223.117])
 by mx0b-002c1b01.pphosted.com (PPS) with ESMTPS id 48mye6qgdx-1
 (version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NOT);
 Fri, 22 Aug 2025 05:14:23 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=b9+G6pTBjEb5lbRRIFwNy9vph23MP1Ywo4nql4c25PvlCOH2gwaV/X71KrqV1oW4fZvTI1bgj4yljhGc8sS7RxctzOVlqHNQ+bbw39xk7oCwSILX91YrMGhFciqf/skhdbZCb1DEb7NNZoKTZPNyEhtVvRQcROSHmFnfvBdFfJrzzbCw9hWG6xMiUmsNGq9VNXY6trpZ7TrZFnFGr1KZd+BolkoZLTOFHpJ32b5DHgKS3GwNOEZiCxMdIto7K7V4uOX4xzhM5Wgctft2W57Kgc5fs01MSqanSCihGaoW3cl6meRa9HOro4o3trLvDxrIuOdO0jjTROxUUc4Hq2E+jw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=u6zNLt7Qh69BjrPCHnqv5HHknreOucEItrzNywo3k8o=;
 b=bXVj2ju6e/DApn7uyIQjyJvQbuXxullcjnFqAI8hYsvIUngnWuUM15wp6VFXP75c6Niun91V8tM6z/RnFqUqsV/eWUBOqHYcT8kB7pTmBb+ZonHKQCMV0g95Uv0/HxksUQCQ+ilj7y+6HXocMv0TDSitOLSoagnZfSeB7Dkk/pPtviBcLTzq7VE45XTJfpW5ImHa8nmO2k5Hy/HYtgQxx4IMlYk43S0+XK33IYtCgFTfmIvW2HVSItc5a5Re9lwqaRawMRwH6vJ2cfOEVxLP63lX6X9oHSGUSq8u3+PnQm0UfixB1+cBqx2ezUCjhYsAX5vcRMXQBLiZXdva3f6INA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nutanix.com; dmarc=pass action=none header.from=nutanix.com;
 dkim=pass header.d=nutanix.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nutanix.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=u6zNLt7Qh69BjrPCHnqv5HHknreOucEItrzNywo3k8o=;
 b=YkNgs4v9zVTb7jwX7MYPEEXcteHXcgBFcscEmAoc/xDa4+y2FzucGbtvo8t8d1Fe9bzw8aAnume6H+AVk5EYD2f4/k95PAYY70XbINFlUQnHL/Ei3v5zjG28kKO4ZZcwNx4t5ER2ahfyvxlAHLJ/lS9CXMJnozrZKxGNCQCQ9eu/uPehLIUbmfhwFDFCxwzUJ9V9956wc2jW6FHi+FR2JwgvwV7ATqv6GpVynOqvUsuBb2M+Hod7MFFwZcjLbsFGKNxBeUHrtsj6yIhDuu/2TZqvCKcpyPkQMeKy5yGy8U9a68DHQ0OkERPIAOTl6LyR+TVVCmoJaEJD5sh/ePw5PQ==
Received: from PH0PR02MB7159.namprd02.prod.outlook.com (2603:10b6:510:16::8)
 by SJ0PR02MB7725.namprd02.prod.outlook.com (2603:10b6:a03:322::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9031.24; Fri, 22 Aug
 2025 12:14:22 +0000
Received: from PH0PR02MB7159.namprd02.prod.outlook.com
 ([fe80::6cf9:b35c:b143:bb88]) by PH0PR02MB7159.namprd02.prod.outlook.com
 ([fe80::6cf9:b35c:b143:bb88%3]) with mapi id 15.20.9052.014; Fri, 22 Aug 2025
 12:14:21 +0000
From: Mark Cave-Ayland <mark.caveayland@nutanix.com>
To: pbonzini@redhat.com, mst@redhat.com, marcel.apfelbaum@gmail.com,
 eduardo@habkost.net, imammedo@redhat.com, qemu-devel@nongnu.org
Subject: [PATCH v6 10/19] hw/i386/pc_piix.c: hardcode hole64_size to 0 in
 pc_init_isa()
Date: Fri, 22 Aug 2025 13:11:56 +0100
Message-ID: <20250822121342.894223-11-mark.caveayland@nutanix.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20250822121342.894223-1-mark.caveayland@nutanix.com>
References: <20250822121342.894223-1-mark.caveayland@nutanix.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: AM0PR06CA0124.eurprd06.prod.outlook.com
 (2603:10a6:208:ab::29) To PH0PR02MB7159.namprd02.prod.outlook.com
 (2603:10b6:510:16::8)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH0PR02MB7159:EE_|SJ0PR02MB7725:EE_
X-MS-Office365-Filtering-Correlation-Id: 168913ed-a5ad-485a-4b77-08dde1756d56
x-proofpoint-crosstenant: true
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|1800799024|366016|376014;
X-Microsoft-Antispam-Message-Info: =?utf-8?B?VWtJS1hlcFVSTW1Hb1o2MDZORVJXR2RXdlMyWUlXOGtXaVVSKzRwSlRxU3gx?=
 =?utf-8?B?a2VaL2lsdkxxODRMemFyNGVGWEdJRFFwVDQ2N1Z2YXVzT0JPWTJLZ2JRUmJS?=
 =?utf-8?B?YnZ6Tk5lYzJ4SXVRd3RSUkp2M1hpb2F4T3lMTk9IWjZ6VGhZa1hMNVY2aGdL?=
 =?utf-8?B?UXRiU0c0a2YvckhwQ0xwbVdWRUtpdVFvUmJld05hbmZHcGsvU3NVL2tmelZz?=
 =?utf-8?B?dEFLYjFFSnhwdDV6OHYxdENCWk81aWNmdmtmVitEZGtpTDdwc2pPbVRMd0oy?=
 =?utf-8?B?V00zODk3R3Jhck5VNlZmMUFRdkNaQWwyR09wYjZXMkRVUzhRcWpXd1FrM0p2?=
 =?utf-8?B?SktJdjA3Z2phNnVQWm01eGloUzR5dmtPZ0tITUZRNHBKWDhRYmpoZTFsU1hX?=
 =?utf-8?B?VThyL0RoMGtHbXdHZythWFM3VmMrbGx1Y2lmS21lcEw2QSs3dmZDdCtlNE0x?=
 =?utf-8?B?clBOUmFaS1R6QzI3cDEyaHFLeDV0eEl5WERaUTVkSzk3eFNHRlRqd1JaOWxm?=
 =?utf-8?B?bGZpbHVqMlI2Vm9qNW9SaXFjVEVBeVl5Mm1JdjZLa2ZhZGVvNHczeWlZVWVE?=
 =?utf-8?B?MkNpbVV2aFYvdTRaaVl1d0E0bncxVjFoYnlkWnRsTUtDRVhpZ1NoeGV6RnE1?=
 =?utf-8?B?cjdwL1ZoRVhnM2dvblE3cUhaaXg0MVZpUHg3R1p4bDdmMkoyNWFkSU92ZW5Y?=
 =?utf-8?B?S2NZNVJGSW1PWFhJSVpGcXpnMjhSMWh3WGdrTFh3Y2lrWldDMmFReFcxWHVK?=
 =?utf-8?B?TFV6d2l3bHJrMGlJcit6dFdFdElSUHFQWEpTTytjQVMva2Z0a0Nlb1E0MW1Z?=
 =?utf-8?B?Z2UySzJkR2h4eEhBRkJyUkpNMS94TFp2RVpVWFg2ZlFhcC84Nkd1dnJ6MGtt?=
 =?utf-8?B?UGxUYnZaSUpOeElPRWt2UEZvUk04Rml0UTZWMUVCMXlnbUwzQjF6MkFuSG1F?=
 =?utf-8?B?SkZ2MWprN1dSeTdDdHFnZEpSOFB3U2lIeFJUWTczS0FmcFhqdVAvTVJpS01M?=
 =?utf-8?B?cVAxUU11U01iMG1Pa3lLcUprUWRvUDVYNko2Z2dsRW5jN3I5N2NoSEdIajdI?=
 =?utf-8?B?RTEwTzI2akF0MS93RnYyemkzTC9ERktPdnpNaDdPUnVEYTcvNWZKNWZYN2h6?=
 =?utf-8?B?WUZPUEVnd3VQUE94ODJ6YWZhMkVtd0xYK3d2RG9IUHlIR2pueUY5V21JWXI1?=
 =?utf-8?B?eXo3NnM3bGZwNUFCdE5oNGlvUE1CWmFZTkZ3UGVCL3FTWkFUME9QcG01Sk9x?=
 =?utf-8?B?eGdzV0Q5a0svMzd1NVhjRmZKQmpGbklMUGdveFpWOHJNWmQ0NzhKSTZoL3JT?=
 =?utf-8?B?SVdmL3IvbW5qYTVIUW5IajdlWEJaZE1laG5RcUd3Q3JrQzR3c25MMngwcjdh?=
 =?utf-8?B?a3VZNHhCNHhlKzF6WVdWVHU4N09DNHF0V0wrd1lMcUNTeE03endBRkNnMkhC?=
 =?utf-8?B?dHE4NEZadXRpVUxZaTFWRFNvWmo5a29ycWoyb00reDhVUWs2Yk0zMk1tTHUw?=
 =?utf-8?B?QWFqSms3TmpZQTdrQ2NOSUZkRjRxNVBIaWJNODNyNC9XWjlPdEpnWmoxckVr?=
 =?utf-8?B?MElURXdTQ204ZGxDRjNQQzcvWnY2bmxFZE9GdE56L1hUaHhNV3B2QkZQWVJl?=
 =?utf-8?B?K1MxRkthM2FzNzdSaW1LN1ByakFtTHIvQms0bTBjQmdCdHAyM05sN3RMLzk3?=
 =?utf-8?B?VERSSnUzOEF5cW1vcWd0VXVTdXRMZmo0RFk3SGxRK0E5cTh6Sk9nV2VzY1c2?=
 =?utf-8?B?dEFPR2pla2dua0srV3ZFc0t5VmwxY0Vod0ZneGpmUFZ0WVBHU1pmVGVuYnNL?=
 =?utf-8?B?SnhiVXBxcUV4TytVbGl1T25BYUgwVW4rWVdKSkFDTThPUEVTRlpycjdjWnpR?=
 =?utf-8?B?SnF6TUM3cFpsL1hPWi9ZL3RaaFN0cm9yVUE2YjcxVmpYLzg0bEl5Z3BKU0RR?=
 =?utf-8?Q?5/rp7P3sF+s=3D?=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:PH0PR02MB7159.namprd02.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(1800799024)(366016)(376014); DIR:OUT; SFP:1102; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?RzluU2hPeXJKNGI4MXUxdmVkbWEzNkZpWDVrQ1ExYmlxNW1PSW10SzEvRXVR?=
 =?utf-8?B?THY1MDZBYlFyQmJHQ2s0cWNnbmprM0VkenFCZ2hoWUYySi8zbDBkQTdoajJM?=
 =?utf-8?B?OGYwSDNSK3o0S2NXQVQ0RVJqTkVBUWJHdFdMUTFQTHlMbVRRS2JialAxdUxn?=
 =?utf-8?B?YUZ6WW0wTmVtL1AzbGFzTW5IVkVVN2RWWkhkOVM4aitpOTBqTTN6V1Z2OXB4?=
 =?utf-8?B?SldlYXU1QzZpSDZMbEFaL2dka0xhT1N1eWtrL3dHMW1ib09PSzNKeTd0WnU4?=
 =?utf-8?B?SGMwNWY0dVdPOHNKQ0ZRZkdNbGM0Wlk0NjMrNmVvSkR0ay9oRkNCbnBaNkRl?=
 =?utf-8?B?SnZrWVBvQVRWbVhUciswWVVsODlRb0tFSFN1dTh1WldUNHdkNnpPYjU1cUdq?=
 =?utf-8?B?bElrMDR2cVpmSXRxR3d0bUxxKzJmUjR3TEpnR1pFODZMazhxNnIvaDh0NTRq?=
 =?utf-8?B?UmI0dStvcnRUSmVqZjZ3Z3J1TTB1aGtCV1RyQnVpMTVXdlR2c1RNY1Qzcm1W?=
 =?utf-8?B?UHhZb2FVZ1RiWk1OSmcwS0hDYzJSNVk0RE9hNXUwTmVLUTdrZGNERWtydWFF?=
 =?utf-8?B?U3RHMGJZSzJzTFNoeVAyQkRtKzY4dnh0YlR0WjJIa1hyMnNpQW8relJOTFZt?=
 =?utf-8?B?VFdYY1VHREFzdFd1c0g5bWJFUmNieE1jWHhRNm15QTFLbUNmMDVxQkFqa3Z2?=
 =?utf-8?B?d2pkWFB6bCticFJGTmFTSFUxSTY2czJhM0pGMUxUekVxcTVtQWpvR2djTTRI?=
 =?utf-8?B?RFoxdStnSjBWa1k5UnBLQVBZSlcrNGp2RFU0SUo1Sk5BR3hkSVcxN0w4dnRp?=
 =?utf-8?B?dnk0ODYrcG5PS1dQYXQ1dlVIcjNTRHJTNzRTY2M1Y1JjYXlvSSs1dzVBTnh2?=
 =?utf-8?B?RjdlVmRPaytoSjdxV28zR3Jja2VvTkw5K3NBaENTSVhsbXZzRGZrUm9wY1Bj?=
 =?utf-8?B?K2h3Y21aaXNCZU9NUCt2QitVRkpaS2VqaExHNWNPd0xBeHg4R0dNYUVLN25K?=
 =?utf-8?B?UHJPYWtENHJOVE9NSHY2Q3FRa0IzVU8yUW01c25xU3djakhKSzI3MDh6SElq?=
 =?utf-8?B?LzRzK1BYdEF1S2JXVHB1T0hRdExtd2ZOSXU3NkN5dml6Z2FIVk9zZitLMUV5?=
 =?utf-8?B?TGJnTkM0K3cvdzN0bXNtMUFWMzJxWkVlcU10TVphMlAvOEI2YjI5cllCM3Nj?=
 =?utf-8?B?aTMvU2pWVGlDbW9KLzVtbmcyOS91TytsMXBING5qUDNTSkFkK1FHblFHcnd5?=
 =?utf-8?B?MEMwek8xSXduQm5kVmx0NUJQcEpxT2U4SHFxL3RsNEV0dFlBWnBjSTBjanlQ?=
 =?utf-8?B?dEZLbi9XUFRhSDNXY3JEMGN6Z1VodkFXWmZaWlZzQ2h4N25aZCt0ZjM0N1pN?=
 =?utf-8?B?V2ZyMnpNcnVpWEhwcEZjYnFVdGxCN3hUWnk2UWhvZ2hjSmM3NGtpbXAzWkRW?=
 =?utf-8?B?a3JOdWNiNEpLVXdOWUF5cllmazFOWkI4MXZ0MnhtRWcwc1JtV0VNQ0NIcEFI?=
 =?utf-8?B?LzdjaTFmZFdQcnpRdEdHbXpuR0MwRmoxak5xMnN5MzFDemFkSmgzY3cvVmVY?=
 =?utf-8?B?QW5ad29lekNpbDFDbStYbjVsQ3Z4MUVzTGp3MGlKUC9sOHdDRUdjMWxZV3Zi?=
 =?utf-8?B?RGFmaHdjM1RidHpTOHdjVG54aExLZU1kK1dtbWx2T3FEME5ESm9EeXd5WUJ5?=
 =?utf-8?B?MGVLb21CZGFjTlNIeXdwaGl1L3pmSFRzbThUMzAxU2pvR0kyenhibXlJN0Nw?=
 =?utf-8?B?WWo2aXFjQmlSUlVZYTRqRUhueDNHRkUyKytkaGhNRFRTMUlrbE5XelFieU81?=
 =?utf-8?B?c1BiUldnZkcrY1QrVGU3eEFIZGFQU2JoZ2FWejhhQUZpSUhOOUpzaVk0ZmxC?=
 =?utf-8?B?ZThOUnU0anNZSVFXSVJPdlU2WlUxZXJFWW1CQjV4VTZIUTk1UjE3Zzdna0lx?=
 =?utf-8?B?WXpJaUtGdzJZRUlwb2hrVmFIL0NMckZ2citvU09jVVVhUWNzc3RtdDd5T0hW?=
 =?utf-8?B?TnIxdXhSQXZYQmZTWU5wenhhSmJKTnkwWVp2b0F4RDFHeit4c1FLK1plV29n?=
 =?utf-8?B?SnZzcjZtVzdiRktRaFN5UitodVV0L1ZFOHdmSmwxOFRVVGlYbUhXRUpvMlF3?=
 =?utf-8?B?cGtlWWY1eStCRW9Bd0sxMWJ6K3pHOEN2ZXJCLzlWdGJSNm5IL2Q1MTlFWEIy?=
 =?utf-8?B?SUE9PQ==?=
X-OriginatorOrg: nutanix.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 168913ed-a5ad-485a-4b77-08dde1756d56
X-MS-Exchange-CrossTenant-AuthSource: PH0PR02MB7159.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 22 Aug 2025 12:14:21.9273 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: bb047546-786f-4de1-bd75-24e5b6f79043
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: wZe19QcvACj1s8jld0ALi/F2Ql9JS6Fc9DBW4lh4LaIAaGg38fAhwjkm1yijbEo/VTVWjpIHuWirt/pYLmPPVo7BEWYeLFphdFNwbScj/BE=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ0PR02MB7725
X-Proofpoint-ORIG-GUID: jl-EqLI8AuIF4GTHs7kgivpK0WgotAaF
X-Authority-Analysis: v=2.4 cv=QLwxhgLL c=1 sm=1 tr=0 ts=68a85f1f cx=c_pps
 a=gSfga9H3o/hfQwPnBHsPpQ==:117 a=6eWqkTHjU83fiwn7nKZWdM+Sl24=:19
 a=z/mQ4Ysz8XfWz/Q5cLBRGdckG28=:19 a=lCpzRmAYbLLaTzLvsPZ7Mbvzbb8=:19
 a=wKuvFiaSGQ0qltdbU6+NXLB8nM8=:19 a=Ol13hO9ccFRV9qXi2t6ftBPywas=:19
 a=xqWC_Br6kY4A:10 a=IkcTkHD0fZMA:10 a=2OwXVqhp2XgA:10 a=0kUYKlekyDsA:10
 a=64Cc0HZtAAAA:8 a=KKAkSRfTAAAA:8 a=aqeCdxMHYQgX1PSeTiMA:9 a=3ZKOabzyN94A:10
 a=QEXdDO2ut3YA:10 a=cvBusfyB2V15izCimMoJ:22 a=cPQSjfK2_nFv0Q5t_7PE:22
X-Proofpoint-GUID: jl-EqLI8AuIF4GTHs7kgivpK0WgotAaF
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwODIyMDExNCBTYWx0ZWRfX1W6KaRKKrd3k
 NAstOnO+9ZYR6bL7jbST6rMcCLw197cdch7cb5Hs0pUtrvQisNY/OnveT9m7hmt+NnZsL2N3q4A
 8ivMbQbdfUzg3S4jmHKCKa7MZZDZwLLFTBPKBYY9RhGJIoB6WkKiAgE1cKfUp8R4gXziRUfiax8
 Fpz+ceviaSqJ99vT7avHWgxmb6Dypzf3AQXzIcDOGBeJoAZmMs8ycUSKBOguN2QR43ortBUMv5u
 sT4ryaMxziFVni9JPMnszbr+EmZm+R8CjUrnqd3/+dUKke0N2lHCC8pAmUDPz5HePD8veq/W6Va
 euAr8ok3h3vKjgE3Rt/lp04yb64jbq5ZC7bh5lJqSyz4DtTPLal58vMlXSrNFxWhxZPtUok5Sp7
 xsXZTuq2VK99b0vQR/NiQOrKQ5eg8g==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1099,Hydra:6.1.9,FMLib:17.12.80.40
 definitions=2025-08-22_04,2025-08-20_03,2025-03-28_01
X-Proofpoint-Spam-Reason: safe
Received-SPF: pass client-ip=148.163.155.12;
 envelope-from=mark.caveayland@nutanix.com; helo=mx0b-002c1b01.pphosted.com
X-Spam_score_int: -27
X-Spam_score: -2.8
X-Spam_bar: --
X-Spam_report: (-2.8 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
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

All isapc machines must have 32-bit CPUs and have no PCI 64-bit hole so it can be
hardcoded to 0.

Signed-off-by: Mark Cave-Ayland <mark.caveayland@nutanix.com>
Reviewed-by: Philippe Mathieu-Daudé <philmd@linaro.org>
---
 hw/i386/pc_piix.c | 3 +--
 1 file changed, 1 insertion(+), 2 deletions(-)

diff --git a/hw/i386/pc_piix.c b/hw/i386/pc_piix.c
index fc94937ad4..7c9f4b78b0 100644
--- a/hw/i386/pc_piix.c
+++ b/hw/i386/pc_piix.c
@@ -444,7 +444,6 @@ static void pc_init_isa(MachineState *machine)
     GSIState *gsi_state;
     MemoryRegion *ram_memory;
     MemoryRegion *rom_memory = system_memory;
-    uint64_t hole64_size = 0;
 
     /*
      * There is no RAM split for the isapc machine
@@ -480,7 +479,7 @@ static void pc_init_isa(MachineState *machine)
 
     /* allocate ram and load rom/bios */
     if (!xen_enabled()) {
-        pc_memory_init(pcms, system_memory, rom_memory, hole64_size);
+        pc_memory_init(pcms, system_memory, rom_memory, 0);
     } else {
         assert(machine->ram_size == x86ms->below_4g_mem_size +
                                     x86ms->above_4g_mem_size);
-- 
2.43.0


