Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 92930E87846
	for <qemu-devel@archiver.kernel.org>; Tue,  3 Feb 2026 16:10:20 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vnIyX-0007re-CX; Tue, 03 Feb 2026 11:10:01 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mark.caveayland@nutanix.com>)
 id 1vnIyV-0007rO-RA
 for qemu-devel@nongnu.org; Tue, 03 Feb 2026 11:09:59 -0500
Received: from mx0a-002c1b01.pphosted.com ([148.163.151.68])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mark.caveayland@nutanix.com>)
 id 1vnIyT-0002xx-Sf
 for qemu-devel@nongnu.org; Tue, 03 Feb 2026 11:09:59 -0500
Received: from pps.filterd (m0127837.ppops.net [127.0.0.1])
 by mx0a-002c1b01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 613E63sl1458941; Tue, 3 Feb 2026 08:09:53 -0800
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nutanix.com; h=
 cc:content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=
 proofpoint20171006; bh=IHx1f1BrufL3m+qmESW07xGl8mvnyKV0wSNTdbHdy
 /Y=; b=wr9DhBGitapAN9ZXpTnuZ1WyMahrjCOe+cHzHXo/1x8x6/UvX4VjMNlfm
 4xcsfagPwUNM/UZXZzmYG/AloYgnQE3JewU9zKubZgWAGaIARJ38DgCJn6MmaX/c
 IxZo4H5Sy4s7Ro7r96luTkzvZZ+TQC2U7vrJPajMSXY8JspwyIHAN2PeR6vld/hH
 /aYjRu9M3FQdQy/9vDU2DzUiQ/gpSc1bY6d1DKKy1cXRcIFHEA+qPKiLu7kO19yn
 JdsLifW+X5Nj7BC3qpMfA5eZsTIN9mxl6VOMOxEH1GyykdMDevubEI80F4M1LiKN
 5WxJRnUwZaxVTub/kIy2LN7BVcSoA==
Received: from byapr05cu005.outbound.protection.outlook.com
 (mail-westusazon11020122.outbound.protection.outlook.com [52.101.85.122])
 by mx0a-002c1b01.pphosted.com (PPS) with ESMTPS id 4c3b029f7s-1
 (version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NOT);
 Tue, 03 Feb 2026 08:09:53 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=v2iwlFM3y9juwcyk2h7I8lczvk5iQN9fcurWb+1M5bZjCOA3277T17kYQnC4Jr6mlkw8m1dCjz7jg7KWna1vVvtZCdCCq4yp/39NsFOVK4l1iVjWwZOBE8xhhkMr86KOl4ZCXnDAzZ94yRoCANuIzf1l+K0gwxNa47g1Tq5K6TEIjlAOH1ptqUKtovWOb3ZYSXbn4ZmAtnKXJUtA4VL3Ehdp4Y/+7kAyNyXHeqnM84OTD/xp6TH/jkO/lUAn/61mYMMkgWLmgBLlCmRtYTBLbVC+/ap0chpnTQpUXlx0YBToFqu9fJOUXCRy9225ZPAfipO5EwKANARs28w/3+9hCw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=IHx1f1BrufL3m+qmESW07xGl8mvnyKV0wSNTdbHdy/Y=;
 b=ZiSqv6nYLCfxCWSF1gK/N4LJQJY5ve/MlsbzXh0VPDw1FDQskXyoKPTI5SI6Af7ScOK0JBnW2amcDOQIcZvOUc5H3waG2sU3mUC0Jmv11j5zT95Y4VeUG+KLbwpg2USg9E80gP9KKU7RZfuGPmwfJrfccl3Kc9gHLe7ZQSmv1XjSPitrEgxtrx5J/4HiixkKFv1qSUwUaF5G7h+qeBzrQ/ytMYqRXzkcFGTH+2Jtiid4jf8/vS78mSF7y4j5JgcjwGupFuTmkiowtAFNNo+x0thC6Dm9nCoA3Oc+WUFMdF11f++XPG5eEQyP26eM6Bk1uZ9uu0+MH8e2oAg96bO4nA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nutanix.com; dmarc=pass action=none header.from=nutanix.com;
 dkim=pass header.d=nutanix.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nutanix.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=IHx1f1BrufL3m+qmESW07xGl8mvnyKV0wSNTdbHdy/Y=;
 b=mbl9l8Fz8McyMVR0Kx5quSZk5dmNPC+ZT5X6tm+aq8PtxauUwwnEiv5tGf7mLL5a1SDciUOGqTRIpTGWl2B4CN5Q3UVNEDuDVC+NLSX48AgBouimZlZrpmCm2GQiy/RzfZ5qDdYn3sqWdL8SBbNBSAvPmLXO2CyN2BWB21BVtQrdoaeLRCNukR+uvNvSOf7IUia9FlhzQfYWkDLlJkLdf9FZ+ik35lMAzZ0osJUFlz25v17TkxDGx7loRj0AyFut++oO1hZ2f3KPt2j3fEGQD/X/KJgTzM6Tw0u6DDCjgCQ0DV+7C76fbKJ4bb+ZjaUCbsa43sS7MRyEGNY18iouJg==
Received: from PH0PR02MB7159.namprd02.prod.outlook.com (2603:10b6:510:16::8)
 by MW6PR02MB9669.namprd02.prod.outlook.com (2603:10b6:303:239::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9587.12; Tue, 3 Feb
 2026 16:09:51 +0000
Received: from PH0PR02MB7159.namprd02.prod.outlook.com
 ([fe80::8e97:bc32:822c:b250]) by PH0PR02MB7159.namprd02.prod.outlook.com
 ([fe80::8e97:bc32:822c:b250%6]) with mapi id 15.20.9564.016; Tue, 3 Feb 2026
 16:09:51 +0000
Message-ID: <177d9d7b-52a3-42be-844f-616452b6a5a9@nutanix.com>
Date: Tue, 3 Feb 2026 16:09:48 +0000
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 11/37] scripts/modinfo: use in instead of find()
To: marcandre.lureau@redhat.com, qemu-devel@nongnu.org
Cc: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Gerd Hoffmann <kraxel@redhat.com>, John Snow <jsnow@redhat.com>,
 Cleber Rosa <crosa@redhat.com>
References: <20260123074945.2563196-1-marcandre.lureau@redhat.com>
 <20260123074945.2563196-12-marcandre.lureau@redhat.com>
Content-Language: en-US
From: Mark Cave-Ayland <mark.caveayland@nutanix.com>
In-Reply-To: <20260123074945.2563196-12-marcandre.lureau@redhat.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: SA0PR11CA0168.namprd11.prod.outlook.com
 (2603:10b6:806:1bb::23) To PH0PR02MB7159.namprd02.prod.outlook.com
 (2603:10b6:510:16::8)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH0PR02MB7159:EE_|MW6PR02MB9669:EE_
X-MS-Office365-Filtering-Correlation-Id: 91bb89c0-b20f-4779-5eab-08de633ea957
x-proofpoint-crosstenant: true
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|376014|1800799024|366016|7053199007;
X-Microsoft-Antispam-Message-Info: =?utf-8?B?elVDQ2xIamZhUFBwTDQzNCtmQktIOXFHSDJ2MHlneDE4clFPQXZaZTBlY3l5?=
 =?utf-8?B?OWVMOHZ1QVpnNUthb0dKOVFXOVppcTN4bXpzRUpUb2gvYTdpcGpMRGkrdUZ3?=
 =?utf-8?B?cWpuMkExZnhPSHpSS1YzUU1SeVFaMk5pMXVYNklsS09qbGkvYmJmWlRHMGVQ?=
 =?utf-8?B?eDF1UWpaVzllcmJWSkEyUURWejlYQVYybnk4QytNT3c1RzdzWSt2d0NNVFl5?=
 =?utf-8?B?WUV1d01yNG9oZVVheVFtTndvNjJUVjZRRDRlWnpjUDRzSFdRQmxtVXlweUlS?=
 =?utf-8?B?bUZqeks0Z05MbzIxczFHL3grSWpNL2xnQUF4eVpKdWV2bDNLUmZkemdYakpZ?=
 =?utf-8?B?Y0pscEpDMFEyaFl5UDh2ZHB5ZnF3YUZZTTdkZVNPKytsZ2dKQzJnTDZIRDNn?=
 =?utf-8?B?b0NUbllqb0FJWStMQzdvb3luS1dMUGEzYjlRZjNVdzdRNFdDMDlKNnVBVFRn?=
 =?utf-8?B?VU9OMlhjY0FRdlB4R24yaTRuU211UmdwVTQ0NHdoeThBeDNxK3VuWWRGZ2wx?=
 =?utf-8?B?d2I3UGxOV2NDYjY5Y0o1UVc5OForOWJ6VjMyTm9CWS8vWHVuOWhNSDBpd1Zr?=
 =?utf-8?B?d21kSm11Q3dKS0wyZCtHNlk1QTNRWnplcWNFc0lRRHFYdnJpWFhxL2F4ODVq?=
 =?utf-8?B?dm4va2p2Umg2WTBkSmJsaVVtSW90ZTdjVHNtTmpPcVVyUS9qM2RVQ1ZWRk90?=
 =?utf-8?B?MEFsVldseXZLdC91Z3RKNFd1L0xkKzVKdmxaQXZqT0UyRXBoRlVUWk5NTTl6?=
 =?utf-8?B?MGF2a3RLanZhL0xETkx5Y3gwOEhQTDd4YldnR0hPUFgvMkpvWGV4bS9NM2k1?=
 =?utf-8?B?OG1VWk5LekFyb2ZtbTVxU0dmTktacVVRMXR0elc1UEh0a0Evakh1ZWxoMFZ5?=
 =?utf-8?B?OWxvTVNVWUlBNHdjNmVmdGovdmgzclpNbWp0Nnc2bVJrS0Y2bkxiRExuR2pI?=
 =?utf-8?B?cnh5MjlvZkdDZzZoZStEVGpqcmlFcFRROUd3SlRkYW5oUnZwK1ZDRnBlaGxD?=
 =?utf-8?B?VWxTRkNvTUFKcXFycUxFMWppc0Zhc0JRQ1lMc1luSnRrK3RPQnRIYWFWYVds?=
 =?utf-8?B?OEliOHdjbWlrSnhVZ2t5bjJsUnlRb0YzK3U5WlJhbE9zaXpJVFV3akJXRStT?=
 =?utf-8?B?b1Fnb25wdnVuZk9VZlRpZWpHUzRFeDl1T25QaWpFcjZWclhlb0ZBQkVvVWRE?=
 =?utf-8?B?QzBQS2FHN1RJRmZFMkZsdWlPMmdUT2VCdGVDcUlYeWJyQ01IaGxyL1lyY0JH?=
 =?utf-8?B?cDQ1ajFVVHhycWRCVUU3TnYxSld5djM1T1pSOG1iTEJVQ2N6WDdoaG5Na2VJ?=
 =?utf-8?B?UUVBYXZSMXZ5aTF5YklOR2VPWmo1a2tIV3NRekp0QVAvWHpSWUp4VXJ1b3Ex?=
 =?utf-8?B?SC9ZR0xiVWRMbUxWTmV3SFpWSkNlcUJCMkdzelFISStLeDhXeFlOUGtlZHNs?=
 =?utf-8?B?MStHdzViMWxEYUgydG55VjF0RXZJZlJXK1IvWFo2QVRXUVM2K1I0VmcvMFBi?=
 =?utf-8?B?Sk5MZlZPV0lBRFYzZ2YvK3BxYlVIUFVqdmo3SUtnNnBnemlpamY2KzJRYnpP?=
 =?utf-8?B?Wk9WRS9TNFY1RFppS1d4S2xGSUErZzV5RkNxZm04ZzMycHRCUG5hd1lPMWZ3?=
 =?utf-8?B?MUVtcHpkaHlNcGkwRk8xVmRSL1JDK0FvOTN6ZDRidzB5VUdGRFhKK3FWTG1B?=
 =?utf-8?B?WnN0bElvZ0NBOGcwNFJvVTRPQ1VnRSt1bC83Q3cwVEh6blBrOXZoTUhhbXo3?=
 =?utf-8?B?c2doR0lGR0krUW91WVdWS2dIVVpJSEdmVEp3WkNuTjI1MHRJTmhUQlhORjA1?=
 =?utf-8?B?bHoyNkk1RGplbHdMZ1ZWNUdaZVZ2ZENmZzNvV3J1UEl6WGo2eU1aM0xPQ2N5?=
 =?utf-8?B?SmZ2RjlTS3ZaWVE0WXVHN2JDMHVnMGE4eXRNak5oSTBmQVROeHc3R3VOS2Zr?=
 =?utf-8?B?ZVRVTjdLWC9VbFBpRDFXUHYzMjl1TlEwUEdQdWZqWnBQNUJ2K3BaY1hVV0ph?=
 =?utf-8?B?WGFVbzhQNUZRL0dNUVRYMHI2ZG91YWppdll0QkU5M28zTzBTUElrN1BuQndo?=
 =?utf-8?B?SzBtalB3M08vdFdlNlRaNGhXYnVmYjdyUWtsV0xyc1NmQ2U3UzVhbmtOT2VW?=
 =?utf-8?Q?I4zM=3D?=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:PH0PR02MB7159.namprd02.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(376014)(1800799024)(366016)(7053199007); DIR:OUT; SFP:1102; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?TUErV0xTRkZqUnZxTmdkd2I2NFJyeDNyUXhZbDNDeXRSN3ZpS1o2aGhrblk2?=
 =?utf-8?B?U25nOFRoMXlCeWRhZ01oZHd1amJGMFZSL1p5MGFibDdiMUR6NDhXUmJPNk1R?=
 =?utf-8?B?eFE0MnJuMkxlY3dWeGV6YW9HdHJkbWtFQXFPdzRSaHFYNnA1eWRVRGU2c2I1?=
 =?utf-8?B?WEl4c1BQRnNtUlFFeG02YkJoaFdieC9LRWwyVlpVcTY3OUhMU3prWVN0b0xW?=
 =?utf-8?B?TXlyWW9wSFRUeEVOZDhLeldpZ3c1OGhlUXdjaDJUQ2tjd2ZraWI4T1ppSVYr?=
 =?utf-8?B?T1BTR2tQYjAzWDdYZTlJQnFzMEdDRmtBVmVxT000dTJieDdNakdwdS9aWm9z?=
 =?utf-8?B?aGpQem9uTHlTakRZT05lRHoxcHBhUWpmR2U4c1BMZm9WMkVHNjlXZ0RJbFk1?=
 =?utf-8?B?RWxJMnVNREdKbkY2QWhjanB6YnJTUmNuSHJRdW1GVkVocnB4TnZnOXVVLzU4?=
 =?utf-8?B?MEpramhmRjZPcmVuZ1V6SFE4eE1FUUNIQ2gwTDcyNHV4bVhVejJPeHpObEcy?=
 =?utf-8?B?TlBJaTRvWHJON2tkL2F6Z0QwMGl6K1BxbldrMEdyOVpVTHM4NkhXOGlQWVVU?=
 =?utf-8?B?OCsvS2ZzYkRpQUZWczJmNnRXWERwdjVrb0U0bS9TQjF5ekJ5cVBSWkJjbUdk?=
 =?utf-8?B?em5UV3Y2Yi8rTWltNXVvZDZwSTNMZnNuMURvQ0FSVUhQSW1hRzRUdW4rU0dJ?=
 =?utf-8?B?NzJDaVpRZXd2cHNFc0JEWVhmQnd5dWt1VUlNVkNZbGU2VGZja3dtN09BamNC?=
 =?utf-8?B?cy9uSi85c3VpVStubXZqTXErMnYzSUZ0RDQ2RlRWNGYySkZkbTl5S1FiNE54?=
 =?utf-8?B?QXZycDFUU0tTMWxDVituVWFNTXZHQ2I5UVA4NGNQUm5naXUzWnQzMUhrd2pr?=
 =?utf-8?B?T0RVVjhjdDFkMnZBTjJxVzM4azdLUVJMeXkyd0x0Qk92NW1RblNZTmVnWUZi?=
 =?utf-8?B?MXlad2dCRnFPUjFCNjV1K2ZyQVhYSVV2N05hUXNGbVdBL1BFa0pHNTZjanpE?=
 =?utf-8?B?WDRYK0VoY255eEEwbVM4QkZqLzlaSWpBOFl3VDhGMyszbVlUalBzdEpWbkRP?=
 =?utf-8?B?SnZhaWJpU3ptQnIrcWNXV2ZHOU1yUXhTOFpKT1hwU2cxanFQSzZpSTYwY3Er?=
 =?utf-8?B?VWRGYUkxRE5pYjB1MDNSVWtCK1ZROGlyRE1idjhTSTNSempVQzJibDE5aHgv?=
 =?utf-8?B?b0dKbVBJemYyaWJWVHdVWUsweC9XTUFZdzNYRWJKZVRRSE1idWppUDJNWGR0?=
 =?utf-8?B?OS9pOWRES0l0NXdkejAvME84VGZGeThaSy8zenBkR0pic29JSnAyeW9sbG9K?=
 =?utf-8?B?Z0N3QlEwR25Rb3NPNW5uY0xBek11VGlra0NhT2RRMUhvY2NYcHFQWDdvcDdh?=
 =?utf-8?B?MzdnbVQ3UDdkdU44V1lPcnNMT3VBanl3OVlSaG13RzVsazU5V2xBZFhyMUtL?=
 =?utf-8?B?UG00d3NGbnh1VFhHR0pGR2d2S2VjbGEwekZ0S0ExTUo0OVNoRkFBVEhxaTVX?=
 =?utf-8?B?bXJLd3lIbmFkN2Y4Nkp6NVpseGVTWG81U3NKbGZlUDJCb0RPcmVUcndWc1Fz?=
 =?utf-8?B?NkNqMnhUeGJuTXJsWHdPbW9jSnVmNEVyTUpPOGZ1N3M0YkI2dmtEYjNneDZt?=
 =?utf-8?B?TTlCRzNQQTg0NEVzN1d5d2JwZmc3U09ONWpaQXBzM3BEWUo0K25mYm9OUjNz?=
 =?utf-8?B?NjhmQzVZZXdRZDdUR01CTHhvRkduT29kc1QxV2txT08yS1lqeld5dHhvbUJu?=
 =?utf-8?B?WllyVTYwR0NGMll1dHhNMXk3UWE4Vkg0MDV0U1VMVjBiUG5UM00wK01veDRP?=
 =?utf-8?B?ZkR5UFI2bUdiZ0NEeE1YQzdiR1k0dW1ZVW9qaVBqMVZuU09qR2FSdXNPWkk3?=
 =?utf-8?B?bmRaVDJTWFA2enFRT1ZOZG1jK1dzbS8vTWZNZXJsZ3M0VVQ2aFhwL28zRGEz?=
 =?utf-8?B?THAwbG9vVVgxUURVa3FiR2JVWEF6VllsWHlXTVJSWlNLc0lKSHA2bTZwWUxm?=
 =?utf-8?B?S1RZb2IwZzF2T0cwTzh4QmVaMmNrU2tnVWMwMnRtTFlocSs0RWJyMEFWSWds?=
 =?utf-8?B?eXZpOUhLZVFQUzYzUERrZWlFZWcwV3ZBd0EyeWFFYnRVNGx0SENuTTNYWEU5?=
 =?utf-8?B?L0U2eHkzZzduWUFQVkF6UTFVS3R1cjlWbExkcy8vd2h1Y3V0aXk2alZTUnlV?=
 =?utf-8?B?M01XRnpBSTVBaHRNU0llWmh5d1YvUStoaExtb3Z0V3BTVFUySC9BNGRJZ3pq?=
 =?utf-8?B?WWpwdnI5STh2S3U1eWlqVkJWNFpSUTRRQ2EvcUx3dWZCTVQvazFUaVBEVVk5?=
 =?utf-8?B?RFVZdEdZYWhKR0l1TUgraUpiUnhUaTFodS9IeDRBVkZzSmU5azdtbHpiMmxs?=
 =?utf-8?Q?0lBOir1tJdYJfm2c=3D?=
X-OriginatorOrg: nutanix.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 91bb89c0-b20f-4779-5eab-08de633ea957
X-MS-Exchange-CrossTenant-AuthSource: PH0PR02MB7159.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 03 Feb 2026 16:09:51.5612 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: bb047546-786f-4de1-bd75-24e5b6f79043
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: PbaKRTKwCMefToqVtKZmceEJd1UlFfYxEnxKiUP2GCagoigdaW7jlMYMTv9DoIoQCSRmfDP3FcMXgBcnh5/x/uqauP438l36IzBWCtz0e7s=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MW6PR02MB9669
X-Proofpoint-ORIG-GUID: ovPrzwaPQpv0PsYUT4wOYLu3J6aZ_-cH
X-Authority-Analysis: v=2.4 cv=GpRPO01C c=1 sm=1 tr=0 ts=69821dd1 cx=c_pps
 a=Qdo7Ea4lwGWRD8/XiwST5A==:117 a=6eWqkTHjU83fiwn7nKZWdM+Sl24=:19
 a=z/mQ4Ysz8XfWz/Q5cLBRGdckG28=:19 a=lCpzRmAYbLLaTzLvsPZ7Mbvzbb8=:19
 a=xqWC_Br6kY4A:10 a=IkcTkHD0fZMA:10 a=HzLeVaNsDn8A:10 a=0kUYKlekyDsA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=20KFwNOVAAAA:8 a=64Cc0HZtAAAA:8
 a=TgE5dNLbD6jxWOKatNQA:9 a=3ZKOabzyN94A:10 a=QEXdDO2ut3YA:10
X-Proofpoint-GUID: ovPrzwaPQpv0PsYUT4wOYLu3J6aZ_-cH
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwMjAzMDEyOSBTYWx0ZWRfX5Nd8hCsTnXpf
 lVGOXX6y7BxClITq5tGALPhU60y123o+dybje155uVdJPkYjJJmDWn9yjyRG889Moe2fyagBGei
 3Y1J4xRfhYzk/MOF0nA5n00b2aJa8B80nRDtuJxZ9o5iidbP7EqBMvuDZ8XUlU0AST08PcsvPpz
 CUd0nXbAcX3njikL2GXj10cKJzSXVpGIgYsTzEZBNXUk2f36WNXA1vU6UQ5s4UCkS5KvI6eM7JH
 5++uHhtTlW5XdXRs4HJ6RFkq+jdKFKJWSzgCQuvwe1VTSBVhlcnFX99MCsKf6kUn6B0qIs6rzI/
 k6yHlQ9ySK66FI+sorI0FzIeqkc2nJq7jAI2qz2hoO2gN8P91ghUQ3yESkouqiCDFFBiafwn9a3
 kkXik/rk+HmHSxu5rkzbCCcXioK2HnfWzUb4U6xf+7eNBzZpBctanGKnDZ2QAu8tQUK7O5+U+Nd
 TsxWyebIgIYWvJWTasg==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1121,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-02-03_05,2026-02-02_01,2025-10-01_01
X-Proofpoint-Spam-Reason: safe
Received-SPF: pass client-ip=148.163.151.68;
 envelope-from=mark.caveayland@nutanix.com; helo=mx0a-002c1b01.pphosted.com
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
> Minor style improvement
> 
> Signed-off-by: Marc-André Lureau <marcandre.lureau@redhat.com>
> ---
>   scripts/modinfo-generate.py | 2 +-
>   1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/scripts/modinfo-generate.py b/scripts/modinfo-generate.py
> index 83ffa4a7c52..63093a0f820 100644
> --- a/scripts/modinfo-generate.py
> +++ b/scripts/modinfo-generate.py
> @@ -39,7 +39,7 @@ def generate(name: str, lines: list[str], enabled: set[str]) -> Optional[set[str
>       deps = []
>       opts = []
>       for line in lines:
> -        if line.find("MODINFO_START") != -1:
> +        if "MODINFO_START" in line:
>               (kind, data) = parse_line(line)
>               if kind == 'obj':
>                   objs.append(data)

Reviewed-by: Mark Cave-Ayland <mark.caveayland@nutanix.com>


ATB,

Mark.


