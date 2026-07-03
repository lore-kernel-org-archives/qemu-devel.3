Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0F52CC44500
	for <qemu-devel@archiver.kernel.org>; Fri,  3 Jul 2026 09:09:26 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wfZsx-0001PU-GD; Fri, 03 Jul 2026 05:08:37 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mark.caveayland@nutanix.com>)
 id 1wfZsu-0001Og-OB
 for qemu-devel@nongnu.org; Fri, 03 Jul 2026 05:08:33 -0400
Received: from mx0b-002c1b01.pphosted.com ([148.163.155.12])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mark.caveayland@nutanix.com>)
 id 1wfZss-0007xo-TN
 for qemu-devel@nongnu.org; Fri, 03 Jul 2026 05:08:32 -0400
Received: from pps.filterd (m0127844.ppops.net [127.0.0.1])
 by mx0b-002c1b01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 6638mB812339081; Fri, 3 Jul 2026 02:08:22 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nutanix.com; h=
 content-transfer-encoding:content-type:date:from:message-id
 :mime-version:subject:to; s=proofpoint20171006; bh=WirgJt+dapn47
 o2G/TqqG+DJDbZu2p79b7mCgastPSk=; b=rLUIvC0j8J+C9tiCchJcNqP0xpR7B
 l22w69eqKwtaCWouBaMrOSdOY34WPhvGgZrbdNgSj1yrJ1In3Oead/RFPP+Yn9aV
 yDSHllQyZU+r9A0O55jVChzex5SK5kgtDrp9WgO2hNYSyW4NGOB9KoPs9SofcqZJ
 D7Fsq5aWNmc6Iurai4IQ+zbvymgCwWEOo3/IhLW55LbQStdgjOT4lvc1Vje9mluO
 s0Psm5j/OkVBes3zizyHAncXwJ+q94ZonIr/HPanH+Dh7Y24LRcss+ADZDyM69is
 HbG3RNstgMyuqrC6ky3vR2XYAYE0Sq5cuOx4lfv2Q6RJFjiRaskOGC+uA==
Received: from ch4pr04cu002.outbound.protection.outlook.com
 (mail-northcentralusazon11023105.outbound.protection.outlook.com
 [40.107.201.105])
 by mx0b-002c1b01.pphosted.com (PPS) with ESMTPS id 4f69w1r1an-1
 (version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NOT);
 Fri, 03 Jul 2026 02:08:22 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=vLRCW90uhnlkcVFVS8u6kZODb03eCxjD9FiGi+cRTHkilW+giMQkqpxLWMhhHLBxlDlNdtzFuS4sQoHrvS5Ieyv3b6pdGSyDnL7vLLWzuUZL+uqTC+US8Skp09dmpCyDY9jIlw8enNP/KT/7KYA46kkwZLVb7/Lh6EkKab7s6f00N8/pBftiEP9sTkpwsctb2oPYFB7ype+BjtA70YImqWCjSmAgPTkYTR9ksJm60xDWRIYnpyekDWVFbP5fS8O0Xk6HuOY4yhCkKS/YVk8OL2LJJPigmJ6lTm4tMoFuaVAwpbb17nmiByj/DMoBx9ZeT3mF4WM4RCWuVATZr6aJNQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=WirgJt+dapn47o2G/TqqG+DJDbZu2p79b7mCgastPSk=;
 b=Cl56Oynu9xMOZhqzZccjbewNsWWfg3kW7qB3XQD71j8ZZjngq0OQxc2n8W6V7DORxYlbQrMHsKDxByPgZDjiXxGjWoptASHx72+EP8uQXETUjnDmEy9VRGVoGiQgXtnf+/Pc+vuifaH1AIPsS91BE7+pFbutK6us5GLTZJNc9Xig/z5oP11GjjQZrQPBq8JU+RYOtf5m4hXHyVKCzyav426mOX0LdAxgCjgoyCRqxCScV2hPjw5ji1W3zTaszUQOPSQDTOY5gUVCDwDVDvyJYd5f72iQxh/dF1+082B5TO2L2DnFNUMnF3bxSpl+2RNDXFV06mYMXjfx7xCjLDLrBw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nutanix.com; dmarc=pass action=none header.from=nutanix.com;
 dkim=pass header.d=nutanix.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nutanix.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=WirgJt+dapn47o2G/TqqG+DJDbZu2p79b7mCgastPSk=;
 b=MjbbKTvUdF64WekzbgI7nY4cMIq5ukjM3NngcXw3urPBiPNvc52/1teSi0CLOXvLYYqU9vb8tV1O0ekynG9VdT4JW7k+5JKJ5OXLpLAdOJTMthyFfdP4HgqD0s4ld3hmH/O+jCljZsVk50KwKMjdZr7H2ZtO8jMm/ues+N3WtKsey4CPtEJf8Q5Z1puaGwx/680RxWWLOfqaVlF6aC5bzL+vKwbzDE1nwu1c/z1j4p+mqpuvZke6LBUrBlqV/WRancPpr3sQlzYj5hqLtNMmfDOuSDVJlRJdk21DEmmpczP/KZiPdgOM8IBsMIxQ3fU8weGi71jyq1SjPO1t/0RM2Q==
Received: from PH0PR02MB7159.namprd02.prod.outlook.com (2603:10b6:510:16::8)
 by SN4PR0201MB8838.namprd02.prod.outlook.com (2603:10b6:806:205::17) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.181.10; Fri, 3 Jul
 2026 09:08:18 +0000
Received: from PH0PR02MB7159.namprd02.prod.outlook.com
 ([fe80::8e97:bc32:822c:b250]) by PH0PR02MB7159.namprd02.prod.outlook.com
 ([fe80::8e97:bc32:822c:b250%3]) with mapi id 15.21.0181.010; Fri, 3 Jul 2026
 09:08:17 +0000
From: Mark Cave-Ayland <mark.caveayland@nutanix.com>
To: pbonzini@redhat.com, richard.henderson@linaro.org, mst@redhat.com,
 mtosatti@redhat.com, berrange@redhat.com, qemu-devel@nongnu.org
Subject: [PATCH 0/9] hw/i386: convert object props to class props
Date: Fri,  3 Jul 2026 10:07:53 +0100
Message-ID: <20260703090814.2993188-1-mark.caveayland@nutanix.com>
X-Mailer: git-send-email 2.43.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: LO3P123CA0022.GBRP123.PROD.OUTLOOK.COM
 (2603:10a6:600:388::12) To PH0PR02MB7159.namprd02.prod.outlook.com
 (2603:10b6:510:16::8)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH0PR02MB7159:EE_|SN4PR0201MB8838:EE_
X-MS-Office365-Filtering-Correlation-Id: 803bdc23-a6ce-40c4-c912-08ded8e29f1c
x-proofpoint-crosstenant: true
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|1800799024|366016|23010399003|376014|18002099003|6133799003|56012099006;
X-Microsoft-Antispam-Message-Info: wIhAvpYFNIsvZbPkrpnKR87eT3+lS2MTKXxPpmgJ3CNwbzeUOpbLN3f48BIC7g3eEUl6Te7O2CUEQ5iKUhqYyC738BkW+Sl107we122UI1LaHYbYzuVtxKQPo9ryonIMQPCVXjupOmoBye81jqCGXOwb/Ma3eSwDxyg4p7FVRIE4PzAQQzPBxPBZ/u6uovZA+bjHKFRbSE5e2slz99IVSfcOA1Zyd9XMDMTPMFifB7NPb1iTQ2njLy2hzK8i/eLzwDN9pVM8VjDENpFtejhZQ+gchkgmaztYGVDG7oHc2i25a3mG9MuITzDVYhFQyw8PeUxUa/GU+3+kREjzvIFOoWLGyCnxCNNoOC279n5mzo9m28/PYUdYRylOd+XCwJP/eIop8Gri6cXnYtDh17hAfdCkXoNqmE+m6PRsEUU/UsjgneJNCcCgwa2qh3hcc3aKp1nHPwAYxkSgwKLsCxEygbFy4oD+YBrba2neWkzo7kazr68I9YzHcyhLaynuhKmLyYq1TG4aBft5HUnftxgVAdhyFTw9Q1D4RZFuTk+EIThj2fT9OFBlZ+H7B66gEwsJ1Zcu5yBXK/ZW3+SaykuUHrVivgwk3b3Lk57guv//cpWIFuhD2ZxR+1XhZMcsaZ09Pn/cTWQyNe5/Jzvg2HcRil7ZWL3DTH5K/7ylFRuRxQ0=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:PH0PR02MB7159.namprd02.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(1800799024)(366016)(23010399003)(376014)(18002099003)(6133799003)(56012099006);
 DIR:OUT; SFP:1102; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?SC9xN0xNNHloUkg4NGNNcElxNi9EeXY2ci9CSHZVT043TXpqcWZPQU1VT21v?=
 =?utf-8?B?bGdMOWZqNFJEVkFOMk5YREJ6QjVhbEVVMGo5Z2h4bjE0cXYwRXFmT1hXZVpH?=
 =?utf-8?B?RkZFdm5nNjZjcDlDdVR4OEUya21Samcrc0dWZFRsNlVDRmx3QzcrVm9TYlBm?=
 =?utf-8?B?VkNVZSt1R3FTN2tTTTdPS1d3RVNNNGNQM2pocFM4citIamVMTXZQY3pqL24v?=
 =?utf-8?B?Ri8vSUFsWVVZMm8velZ1Z3d5ZzdJL29PTjNPMkRnR3R5SmF0MWRTVHZHSkw3?=
 =?utf-8?B?R05qMVl3cUttdGpyVE9UTjhEZjEzN0RndzZvRWFjcElmY3BIM28rYnk0Ykdu?=
 =?utf-8?B?MENmZ1c2Mk11S2FVeENYV09QQ3FsWnJ4Tm9zblZHMGNrNklubXVzMGErRy95?=
 =?utf-8?B?QnRocnRyemlPZlk2OC90M1I4aTAyUE50QWNWeHJUdlVkWjVRam1BV1MvaVZR?=
 =?utf-8?B?Vkd5ZVBpTkhYeENBaXIzRi9OYisxZ2lnT1FacnZ1aGlWM013RSt0OW5JQ01V?=
 =?utf-8?B?anYzVUszTm9IN2Yra2xoY1liVUhGUDlWTXVocXNWcnBrTEN0L0VXQk0rNTJE?=
 =?utf-8?B?UTdXYjFUa0N2YmdpbFdocm5GSVJyNXBLY0dWYmNxN0tja2cwNW1mUGl1QzFM?=
 =?utf-8?B?bDd1NHZkODFyajlSa0RRY1ZLeFBTR0hJcEdTSmF3dUlFU2F5dkNuT1QxTXVG?=
 =?utf-8?B?cDQyRlFyYkJ0dG9BcmdsSDE4b1JYbHQ3aEZCUmt4bVFEZ1V1UVJvVkNuR3g0?=
 =?utf-8?B?Qk8wb3UyQkdXZjg3NEVMMjlNMks0UHZoSEw3Z2VBWVl1Zm1haWE1SHZlRVpC?=
 =?utf-8?B?ai9Xdm5JZHgrSlRQcjZ4NkdQNHFnVTVsSHlYWk9DREVSdG4xNmN4ajRNcmtr?=
 =?utf-8?B?dWNHU0VYUFNBdXZ6UlpnNkNOQ0NsWUpKRTRBN0cyS2hyUG5RRXhHcjd1ZjJU?=
 =?utf-8?B?akh3QitWdEd2WWNJVlVZSzRwL2VUZEZEeFUzS29idTZsbWxEK2xJdCt4YkFE?=
 =?utf-8?B?S3lnd09td294OTA5KzgwVU90VWt4dUdmNi9XVEt4VS93YVZ6Q3dTMDMyVW5L?=
 =?utf-8?B?RjFFcUgvdnBvQjI4WEZNUnh1Vk83a1lxTEJwK0dFYWRzQmVaQ25KVWpFb2JS?=
 =?utf-8?B?UWFIRk1Wdi82NEcyVVRiU2ZFN2hucGtjN1hNb3lvZUdZVGx6eTk1SjJEdEo0?=
 =?utf-8?B?Mlg0Wm9zdWhNOG0wdEZoMHNPMXY3dGM3dnV1UEp0YjUrWVZ2Vklxb0hESmdE?=
 =?utf-8?B?MXRJUk5Yb1hxa29nV3d2cFQvZTRSbEtlYmxUSFhod3pUc0NMaktCY2J1aWFP?=
 =?utf-8?B?MzIxTjZlNmZOcXUxNnZlUGNUMkVQRlZId2FUVk9rWlVrdDJhWTJUQVM4Zjcy?=
 =?utf-8?B?bWNzZG1aa0E2c29WdDE3ZUdOZ3ZmdVR4OUJQdVBma1hkbm5DaUZQUHZmci8x?=
 =?utf-8?B?enAzMkVLOE9sYTNNS2MwSlZPYnZtbzkvTGpRM2lXZU1kbmNMWGxISCtTYWpl?=
 =?utf-8?B?ZFpUbEd5VHJ4S0RDS2o4VlQ5NHIxQkc2dktxZUVPbWEveEpjTkYrZ0ZRUUlC?=
 =?utf-8?B?N2o0RUQrKy94L2wxNkkyL3YzN3doMDJVY0NWUTR0VUo0UEtoRmJob0NzellY?=
 =?utf-8?B?ekRFOS9DWXI1UG0vNGRWZGNXRnpsUkJNcSt2TkN6d2ZZTmE0ZFlzUXdheENz?=
 =?utf-8?B?Mk9IUzNtN0o0M3VoUnZDcnl0bXJDdGtVTW55enRhL0hiai8rc2lSRkRtWGIy?=
 =?utf-8?B?SjZPMDUvQ1pMc3BYR3JTdTNSQmVjWnV1YlZzbE96WFVCN1FmblNuSFplUWRF?=
 =?utf-8?B?NFJ1alF4anJ5bzNOa2dKMEIveTEvWDQwazdXV1JUY1BZazRSMnJLYVp3amxW?=
 =?utf-8?B?MFpwc3pGczVkaUlBcm1rRTNkNVVtclo0Q2xRa2FiTE9NdFVjRHZ5ODlkK1FN?=
 =?utf-8?B?UGVDTC9ycDhMMTF3YTRQYmd4a3MwS2laTmNFbjVkM1VRRVVCbVY0azkzbnRT?=
 =?utf-8?B?WUQzMUg2V3VZcVpDV2xoTk12QzlEd1NnRVhRWmhUZnpTWExrU1QwbFN5aUY3?=
 =?utf-8?B?c2kzUFRsMS9yRE95d1ljem44QjFXTk1zMldGMm12TG1OTTcwamdJT1NmTmxF?=
 =?utf-8?B?eFE4UzZsVmRtTFppSURjakZGWnFSR1FIditQbko2Yk56UUlrS2pxSFlTMjRa?=
 =?utf-8?B?Yk1VOE4rNVM3clM0dHloTUQ1OFdhWTA3L0Y1U2lRU1ZFN2RJRlppNDJuSWRh?=
 =?utf-8?B?eDg2aVVwTS9Jbk5nekJ1WTgzNEhySVhja0VuT3RwdjU5OE5jS1hnZDVWMHRY?=
 =?utf-8?B?RGN4T0JORElUNHkzMS9aMXpWY2VKczQvVFV2RnNmYWJJblhCY0tJbXR0d1V4?=
 =?utf-8?Q?M8505WW3TkQ5x7NY=3D?=
X-Exchange-RoutingPolicyChecked: aPj7i8XmeGclSK078Vnq5p72kIOxzfp66A9s6/z/IEepzxMwpMc65KGodpy0xHO5PozsbvrsLS1HgTKh9VumPBY1Lc7d5DmT8YK77z6Shl3u6wsHsKIeldwJ/BNzk2yoQTGy3HHLdNWTPQcezy22RG4RHzAxdjiBax2widm2A4p0rt1P5dfvc0u8gjJJ6rOuWxEq04OZGtPTgzXlzCQt+lq5J5oLkumMLyZGWd3uQ6SCRjfe/KOo38RSGh6zFqCwcfpJFTbJUsK6R3PnoISA2yFK8xSB3MAnZkup/u+6HnPv4C9zQefsnjWtEbF5nbEyLHz5j0miZYlr9aHivrUrAQ==
X-OriginatorOrg: nutanix.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 803bdc23-a6ce-40c4-c912-08ded8e29f1c
X-MS-Exchange-CrossTenant-AuthSource: PH0PR02MB7159.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 03 Jul 2026 09:08:17.8651 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: bb047546-786f-4de1-bd75-24e5b6f79043
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: e7L1SCSV8ZRf1oHoesMNRFBCL/LsnLsCzcnAdyqbfr36njFAZKgieL2+/PQFSyUFrI67sF6NpqH7DfnN6SAeHBvH+w9BKyC9evxWsUhrF1I=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SN4PR0201MB8838
X-Proofpoint-GUID: oUWfbFmtyfwkFr6OI-mT4Is-sG2CZaew
X-Authority-Analysis: v=2.4 cv=dbWwG3Xe c=1 sm=1 tr=0 ts=6a477c06 cx=c_pps
 a=mXWPUgXNGD4LDRIkHGcDmw==:117 a=6eWqkTHjU83fiwn7nKZWdM+Sl24=:19
 a=z/mQ4Ysz8XfWz/Q5cLBRGdckG28=:19 a=lCpzRmAYbLLaTzLvsPZ7Mbvzbb8=:19
 a=xqWC_Br6kY4A:10 a=IkcTkHD0fZMA:10 a=RAioF0-LDSMA:10 a=0kUYKlekyDsA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=VofLwUrZ8Iiv6rRUPXIb:22 a=0LlEyIVc8U2lsR7dKhuH:22
 a=64Cc0HZtAAAA:8 a=fftrgsByXVBibpBSsv8A:9 a=3ZKOabzyN94A:10 a=QEXdDO2ut3YA:10
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNzAzMDA4NiBTYWx0ZWRfX68Pex53o5v2T
 i7iw+bmTrMqJkfrBId2T10loOSgfaNElXEnHUV+8nxTk+jIviYTRY8PU5O/5p6WSeScB+detc6L
 HWGzdtgCVbKZT414yua364LU7q+bK8zgUMttGy6ci0rxYraFBem1dEgynmEiZPq07lUCOQt1p+I
 H26PL+7aAEkNRMLZdKpx+EKRNMbkbaztNFp7c6/rIcXOUilRgUDInt+53QOQsn2JQNWziuKKiA6
 wW+KJfCWqn907d53UIVHuyTNHV5Szo/TpzU8cJ04qlPBXyrdORERmLxoF6zP8b4mkUcCX1ljteb
 GqJZ/wu947MKQ7iF50WmbwVR/ElZScKU/T7Yo8+AitskPprgEHdpzLiHOYXOR/gbQdebdUzzDii
 SWDS3dp67OxPzj9rbf8jsFGqnguK9y3h1h7FpQ/ukqW2Yeyy3KzPRpWFsz8HJXxWAHphGmyBY/U
 I9HKZ9cOqVpI1eO6wGg==
X-Proofpoint-ORIG-GUID: oUWfbFmtyfwkFr6OI-mT4Is-sG2CZaew
X-Proofpoint-Spam-Info: AW1haW4tMjYwNzAzMDA4NiBTYWx0ZWRfX+bSYO69/oDrK
 PKrXZu7iS1hu2nhDuVffGQANapZtox1++6dKB/rdMjzvN+sLwc6ZMAWmbABFUMajEDR6a+NTScC
 YrVvtXPA4TnDek7TqUrK75Dic1GvhgE=
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.125,FMLib:17.12.100.49
 definitions=2026-07-03_02,2026-06-26_01,2025-10-01_01
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

Since the use of object props is effectively deprecated, here is an attempt
to convert all use of object props in hw/i386 to class props. The eventual
aim is to continue working through the codebase, removing all remaining uses
of object props.

In order to facilitate the conversion of alias properties, this series
introduces a couple of new QOM functions: object_class_property_add_alias()
and object_property_set_alias() to declare the property and to set it within
an instance accordingly. This implementation is hugely inspired by the
existing link class property code: many thanks to Marc-André for doing this
initial work.

The series is lightly tested: it passes "make check", GitLab CI and some
simple local tests. I'm mostly interested for feedback on the conversion
strategy, and to get a feel for the best way to merge this series since once
the basic conversion patterns are in place, the same patterns can be applied
elsewhere and it would be good to minimise the merge window for such changes.

Signed-off-by: Mark Cave-Ayland <mark.caveayland@nutanix.com>


Mark Cave-Ayland (9):
  qom/object.c: introduce object_alias_get_targetp() lookup function
  qom/object.c: introduce object_class_property_add_alias()
  qom/object.c: introduce object_property_set_alias() function
  hw/i386/pc.c: convert pcspk-audiodev object prop to a class prop
  hw/rtc/mc146818rtc.c: convert date from object prop to class prop
  hw/i386/pc.c: convert rtc-time object prop to a class prop
  hw/i386/pc.c: convert PC_MACHINE_ACPI_DEVICE_PROP from object prop to
    class prop
  hw/i386/pc_sysfw.c: convert pflash0 and pflash1 object props to class
    props
  hw/i386/sgx-epc.c: convert SGX_EPC_SIZE_PROP object prop to class prop

 include/hw/i386/pc.h |   5 ++
 include/qom/object.h |  24 ++++++++
 hw/i386/pc.c         |  29 ++++++++--
 hw/i386/pc_piix.c    |   5 --
 hw/i386/pc_q35.c     |   5 --
 hw/i386/pc_sysfw.c   |   7 +--
 hw/i386/sgx-epc.c    |  12 ++--
 hw/rtc/mc146818rtc.c |   4 +-
 qom/object.c         | 130 +++++++++++++++++++++++++++++++++++++++----
 9 files changed, 181 insertions(+), 40 deletions(-)

-- 
2.43.0


