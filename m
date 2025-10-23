Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id CD8ADCCD1BE
	for <qemu-devel@archiver.kernel.org>; Thu, 23 Oct 2025 14:31:00 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vBwKM-00017M-Od; Thu, 23 Oct 2025 10:30:06 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mark.caveayland@nutanix.com>)
 id 1vBwJz-0000pC-JY
 for qemu-devel@nongnu.org; Thu, 23 Oct 2025 10:29:43 -0400
Received: from mx0b-002c1b01.pphosted.com ([148.163.155.12])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mark.caveayland@nutanix.com>)
 id 1vBwJu-0001J5-Qq
 for qemu-devel@nongnu.org; Thu, 23 Oct 2025 10:29:43 -0400
Received: from pps.filterd (m0127841.ppops.net [127.0.0.1])
 by mx0b-002c1b01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 59N7G4UY2044691; Thu, 23 Oct 2025 07:29:32 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nutanix.com; h=
 content-transfer-encoding:content-type:date:from:message-id
 :mime-version:subject:to; s=proofpoint20171006; bh=9YL64FOX5U/6C
 C35z6Hgj5iVU0wJjSAXZwEwCUx9hfQ=; b=uA5lYlHbSuzC0HKcVM0p3xDm9LpM/
 ITS2qRrmy5SYyZhpyL21G0Db5x7GB7LdRYP+xubRYK02iiMvNu5T2+2fZMiZQfm8
 edV1mZiWeUmoY/tFnSMKGuUL5s7gJS4eHsXrtKNBWI40Aj92czKnKC0BQIqrNxqw
 mds4A5jV5iickz5joTXmCcZVBlyDIWEWwyADVcQ8bnpYezSiEQWipiHIwap9p5EI
 ZCvn2J+DJgO2ndBnpcp5REK3yBFib3MnOjf8jmtvZT1ReNRBFG1L3uiqBmLBOXLu
 Z0MeLgEIfvRot9VTPFZ3zgiJ/a06ozNNScDTNgCbgLTuLA1DjK1HoVdug==
Received: from bl2pr02cu003.outbound.protection.outlook.com
 (mail-eastusazon11021124.outbound.protection.outlook.com [52.101.52.124])
 by mx0b-002c1b01.pphosted.com (PPS) with ESMTPS id 49y3matf2m-1
 (version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NOT);
 Thu, 23 Oct 2025 07:29:32 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=tLZAxoqLoEv8M1KJzwnRrMJP6b8bEZqBWef9bQOi2cpP4e1l2t5Y++dg6ePszXUk4cQ3t8lYJi1lQ2MVolfs3AU/RYqK5NCSti844lJ+UlMvmk9Lw0OKw48PB06bSIpfQ3cABDdotZQMX9QrgNY7fOBMuuptV26ovRvHAFer/rlsOsW/IIw3xmdKyWowAh5rlrFWt+VHXZjuop3Nk9LSXvLUo8sSFfoApDdzfO985k4UqwEd5aBHL1R+wg3ZiVRodYJlHVjYMfHjTTqShogbvnq78ooYLXkRxlDgIhiZ3BH6TAqNwvVRVZrmOab5JLiiDWxlD1Bocl0v9EGfsqN7sg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=9YL64FOX5U/6CC35z6Hgj5iVU0wJjSAXZwEwCUx9hfQ=;
 b=ZphgqM6HI5nHqebVrhaWrQlD0PtqC8krviafKnjhh9TDjfJWj1oEXWxVu1+CCczPj/ZTpn7dblhLla4TGKcpcn2XDalkRU1WSoeGNqPQDYSDE4gfJwRxOeg7P9pyyh6hgRmKvLpzhx0FZtd7SReM3Cyxq6Fc7vEeTCa/LWouujPvUSA+2ZRb+A4LERxQsTrwHnItaHFJClAh7G1OeNzwhzg/X/AokCBcuFEdpxWoGjS/g3AD73GG5bd43y++AYYJJomqgtWgoTPMg5iqjvgcM67734NX+SHtqHeNExL2xF1LWdfroy1Hdzce+lIf8ZO7f0i+/BBs3N2go7ZjcFUVdw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nutanix.com; dmarc=pass action=none header.from=nutanix.com;
 dkim=pass header.d=nutanix.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nutanix.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=9YL64FOX5U/6CC35z6Hgj5iVU0wJjSAXZwEwCUx9hfQ=;
 b=GVg26XTaM4D/6fN8yKCGPrRtyyeyvHv4gWaFVtGjdltz5kPTfXrSVvYzoQ3VfSsXql+FOjwIyaLrjktRCGoOYkn+1ARwYOgMDOc6Zsr8vvi9oftfmtvBVyJN+OXdo22X8RQgU/K1dMtMnalvm3wv3ofGtzUxNKI1k7m4qlxwoJcC3/p/yNqog+6tb7VFlb8S12yvGP8zF5nKjveknisR1l73uzgCA2FR9auNmgkas5zVjKOdVxr/PoeL8txmUR65wRM37B1RlOMwTIteJ8Wt5FdW5d/nc2izeUFhmIgaBxUbaifvOlw97+tv63j02POXkRYDrtSNqYOoTOp1y1lp9g==
Received: from PH0PR02MB7159.namprd02.prod.outlook.com (2603:10b6:510:16::8)
 by LV4PR02MB10977.namprd02.prod.outlook.com (2603:10b6:408:2de::8) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9253.13; Thu, 23 Oct
 2025 14:29:30 +0000
Received: from PH0PR02MB7159.namprd02.prod.outlook.com
 ([fe80::6cf9:b35c:b143:bb88]) by PH0PR02MB7159.namprd02.prod.outlook.com
 ([fe80::6cf9:b35c:b143:bb88%3]) with mapi id 15.20.9228.016; Thu, 23 Oct 2025
 14:29:30 +0000
From: Mark Cave-Ayland <mark.caveayland@nutanix.com>
To: imammedo@redhat.com, mst@redhat.com, marcel.apfelbaum@gmail.com,
 pbonzini@redhat.com, richard.henderson@linaro.org, eduardo@habkost.net,
 qemu-devel@nongnu.org
Subject: [PATCH 0/2] isapc: warn rather than reject modern x86 CPU models
Date: Thu, 23 Oct 2025 15:28:08 +0100
Message-ID: <20251023142926.964718-1-mark.caveayland@nutanix.com>
X-Mailer: git-send-email 2.43.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: SA1P222CA0138.NAMP222.PROD.OUTLOOK.COM
 (2603:10b6:806:3c2::27) To PH0PR02MB7159.namprd02.prod.outlook.com
 (2603:10b6:510:16::8)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH0PR02MB7159:EE_|LV4PR02MB10977:EE_
X-MS-Office365-Filtering-Correlation-Id: 6eca3438-20fb-4bea-d5df-08de1240940c
x-proofpoint-crosstenant: true
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0; ARA:13230040|366016|376014|10070799003|1800799024;
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?/33KhidnAgBeoa0mU7KlSVWkS/Vx83ZP8pE7caUzvD1iTsXI6psTFDOuGxSl?=
 =?us-ascii?Q?ak4sx0OZ2Msqd/QwmBQiwtyQPoB4eGst2ikJPn6kiXKdNIL9eCye4zq4ks2e?=
 =?us-ascii?Q?8rVRBsTJBhHmrrk2v5OKREW1/ZqrRDEnbFTUAXpGYQnwzDoR8U35ALarjxmY?=
 =?us-ascii?Q?iFgGUbd35DLLnPbP3VfCzEvgwFWOhqRe7vtsUF1ibqQE6r1gfL5APak221TU?=
 =?us-ascii?Q?PGH5ZHPyT0wQ0ZWKL9duHyp7MENgEWiAy7jKWmmyuqLrWejQaJiezRTESsyu?=
 =?us-ascii?Q?5zLb7w5VTmhMmHVaY1gcB/7wA7buxfRIPuIviD5UxSfVVd3bTEoFgyB2tNng?=
 =?us-ascii?Q?Ec98nCasrJuqiC/3AuZb67oSDjtKwXRv8dxkdsABCFLMi9e2dtnxanx+34cm?=
 =?us-ascii?Q?Hfz9W7+y1FeHnAcq30tDKoUDNtZ0JHZLGncDPqH9Cn2DIArSpbg8f8/8nxPU?=
 =?us-ascii?Q?AoIj5upTK/X3P1TNzytwXZerA+4u62wz02QSoi++nngFv45NKdDaFn7OPBna?=
 =?us-ascii?Q?xD/A8j0jAmg0OpFzIzL74lex98ZtOnaHaibOmFPbh6jBMlNNQx1wsnHs1mjn?=
 =?us-ascii?Q?rWam3fXRBUI+or41Dv7hM3kkPFNz+fvf0H7fXk4lrL+UkRFAqRfX/gWfRqkP?=
 =?us-ascii?Q?99kWaQ54wTjVeP7uqsdNFPrv4yZq3Qf9l5Vungd9TV9DjFddGBHagJZVGl2M?=
 =?us-ascii?Q?iove6zJM7++uS2cJzh/F7e4XK2DT0xCjekrCdext6ADD1dd7KWTpcxyBjP0E?=
 =?us-ascii?Q?GlyPWErnvFUFMkM7/qefXam9iw2PH0AeeT6BaI9azjDCUcwixpkHPG95wDL2?=
 =?us-ascii?Q?mpzcEJmcDqoamWyyhE74Urkm3qTvdVzLLqXO/PHo2sIv/Hb5AD4cNSQEtltr?=
 =?us-ascii?Q?tMAteG1Qv8kFnTagkLC9Rt2QvLTaqNfKjIZMV5LubP9RpmudODIgwCQ8MRaK?=
 =?us-ascii?Q?TJVhTsncv2/WkVWz7KrHKyF7f3LEDWqYjKU2EPCWPim7SYht2d2+cbfryUxx?=
 =?us-ascii?Q?xbiI5PgrDkLfUHE0nYNpoqsFiQRu5yiuESr3IMaOaccpfs72MX/GH+JZqxQx?=
 =?us-ascii?Q?wjQ/iSe/nVyaL4p70/YpFTNeKO/5J8FSMAL2oYv9DBpJaVkYA79ioTM2eLCk?=
 =?us-ascii?Q?p1raKQ63AIvgqgfWL295OsmnoKjffZscsM1Fq0dR5uWNy03fT4VN23UbFwth?=
 =?us-ascii?Q?VRUE+jqOxybpaRVEm1H0Nnk8zPJX+itJLKirNEfdt8ppmAeaieuFMXDfWVOZ?=
 =?us-ascii?Q?O8RkzpkkktUDO/gUs177jpLy38/q2F0WDy/uFWMeP6S0nI0gl8XoP/NaSGSI?=
 =?us-ascii?Q?/IGTMCTW5t7gT/fCyQZJkKLxnWBr/O9WOgJTty72BUG2iZVw5yAaqbnLrH0a?=
 =?us-ascii?Q?NeZXUsDhjgrkxXFBr4sE85d2dPTOtVUuMj+yuhFcPNbYAlWzKYjJgWv4kzo1?=
 =?us-ascii?Q?onawDfI5OUyRNEi3xApvEHZGvnhkiiMs?=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:PH0PR02MB7159.namprd02.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(366016)(376014)(10070799003)(1800799024); DIR:OUT; SFP:1102; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?1KVpk4oW/Klz8fqGvsTB+8+KVPhtrDhHma6B4wxxqBzZXFjQsI7CJYgHsFaE?=
 =?us-ascii?Q?imFW9WEFtlC0i8ziewo8HlsTcGBQDSFGJHmINlzc2GknGNOV0PGE6j3KATht?=
 =?us-ascii?Q?iCb+ZAbX9S5xsH1Coe8PltfSCDAJxpL3CSIkyG3vcHdGuKmUtTbZTj3vdxPT?=
 =?us-ascii?Q?2cIKWtIhLfBYwGt+VIWwYs/SxhQoUllmKfn87Njl0dKDBaYIP97nNyOLz3S9?=
 =?us-ascii?Q?lpO0WO7w/5Kc7ipq9DItqdV3YYNCa9wY594xHGGU3Z3bTGmQwfUj2yuMcVrk?=
 =?us-ascii?Q?g4kpm2o8EEneHApdmL1D0qtGs/Mn5E2qXrNlmGmlRGBlVCaAeVJkwxz9adjb?=
 =?us-ascii?Q?ykL2z4th/SaV4CgtYX5JJpjSUsXAkvHO868SH6D5GnMJVquDIJklfNOeg2O/?=
 =?us-ascii?Q?GETuNpl9m5rBhshX4Cu4GN//AJhY3lZvByr9yQw2TGutHkUjDhjyM6bQVpSy?=
 =?us-ascii?Q?LehLfFuXMSHbxiMcMrZT+nFv47yM1ap/JC+LCguWLDvy1NyNla+ncDjmpfGY?=
 =?us-ascii?Q?5jdXy+KD0hkSahhKUdM/e9LXv7XnPbtuyR7DLnNmRjMlX8tkx0OXcLJf+iM2?=
 =?us-ascii?Q?teJdTGVo+vlWonxjuYk6U5mW/MrZmD5Hpoj3WtC5WbvhryMLOX6HF+nCE8hv?=
 =?us-ascii?Q?kAqNHWbjqeRJkIeFLGQQIKbCWRO26TfQh2uIB+yZ2jtP7EMbfnkU8QENPTzu?=
 =?us-ascii?Q?Yb8kiZW9wa8J9j0GwZ4H5PDOp+dmJAGYRwICIXFPQISHZgmQOapfEZGg/3WD?=
 =?us-ascii?Q?jmIQNc8yem9bqo4FEathnyXL30Uq93H+IEww408wQw3Xd+dZ77dVetxRe+kW?=
 =?us-ascii?Q?Z47UtevE/8YGcoja6pwSQ3/NoIdHfpRuCarxf/PlNuy6tSfAH5izKT5gbKoS?=
 =?us-ascii?Q?Y7kvlhGvV15wwj+EskCH1isoSzBdptVaQOjQqzxDujelxkD/sZu74DiSYWxN?=
 =?us-ascii?Q?lYVrP/kO871FBT80SDcigp/ib7AaQrzGQgLME44NuVqv6KWiJAlHbexrxPgk?=
 =?us-ascii?Q?ca4Y1tGRrzv+PFiPIqmLBYQsqmLJBRuuNtiqBfh4VD9EK4YQAhBfAC1aUj4f?=
 =?us-ascii?Q?z22JuxOgT6cneI17s3pP6ERSBirJKP2N9YuD43jZgV313bMsnTU7zfxlYFAq?=
 =?us-ascii?Q?Fye05Vs+Ghk3eYQqOA28Dn5yFmPCFegHyh39NmPFzfXJjXz0aA4+fYgJgGlZ?=
 =?us-ascii?Q?3HfNFfg7huQHQKvyOgorNtvY036t/UcRteBhQMtlr0UWkGak3swE60TfJrQp?=
 =?us-ascii?Q?+2p/440F4XbfG4GHqHPEUULKpQ/VT2vfzNVJjZQctfX+SmRYiuxI2kGOWaSa?=
 =?us-ascii?Q?xY+4fIhmdZGLSxLbLF07BuHWu2igfvNU/4PX4jBrQL+H7p/PUa+v2HA8Vn65?=
 =?us-ascii?Q?fB9MKK7vfRQedH46kOB7Oi83vkh6E9Q3SQfBaIhlckSYzYkMY9cy7hLYfuvH?=
 =?us-ascii?Q?ncc1jnN8bpE6ut3JhGdSLGv44kl3zOd7vdNJ6l+RuVuOChE7vedTQ4tP1usl?=
 =?us-ascii?Q?jP4PI0FymFLXNgwXKqpqXQkmXlUf8ZLUR1UfM03qRgLz757eG5mqtsdJOLuT?=
 =?us-ascii?Q?mxsIOM1Kzg32J1Fd0cDZ3JyZivzS+97+W2JEsCuiVJABjDr+DZZu4jPtzmec?=
 =?us-ascii?Q?J+gQ8MggxJgm4erHYBZKKjl9LET7Q2vRfsBJCG2kt77sykTCbNQsZK+CxL8t?=
 =?us-ascii?Q?gNk3lQ=3D=3D?=
X-OriginatorOrg: nutanix.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 6eca3438-20fb-4bea-d5df-08de1240940c
X-MS-Exchange-CrossTenant-AuthSource: PH0PR02MB7159.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 23 Oct 2025 14:29:30.7226 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: bb047546-786f-4de1-bd75-24e5b6f79043
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 6HCTBbXWESQS6CzR4nCDH21slNaJPdoTHt6S2gGnDnKu1iSnCbxEEAqxTY6gFlv/d8IWD9FmO8XA0DBMEA068MSOvm4wQDwDPkAcurF6FWk=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: LV4PR02MB10977
X-Proofpoint-GUID: 4bp1tflh_zlQrQPkHeyYBpxMygaHpSH-
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUxMDIzMDEzMiBTYWx0ZWRfXwYz2peWvI4BL
 G6C8/azDVZa698ZBdx41nADmdQaKkFuf9ZJcCp/d3q0Zek4tL7bJrHAQUrbstyU8EJCJMyNVTrF
 1bYs2ceyGyz5JLwlQhzwfblToY7nj4wxmyVhU2RFxmHxZrBaGH3PZytQWR45nx3ZrZe26SSgjTx
 tm4u1q8t51w7ZDUesjK2nwftCP65kmKWIn6j0rCGLnYfg4+lBtrwzlG2U5TPlDKrp1Ea3gDbHow
 ymE2uGyVH72mnL7saqeaf3JMH/g60bUQ6eEk6hQmUCs01t8DntzbvOnNj3oyk/2+VRwjWkj1xrA
 BiL2asINRmX0wC8TSgcnkqt/3l9kDl8hvtr0FmiOf8bhCFnpRGJaMr/i6AcELtQrMxuSGRk0L7K
 fqS4n4lUMdNIuTlvAL3vNQob0TLepg==
X-Authority-Analysis: v=2.4 cv=dsDWylg4 c=1 sm=1 tr=0 ts=68fa3bcc cx=c_pps
 a=VOnUWlUrRp4hX9ZrTSiZOw==:117 a=6eWqkTHjU83fiwn7nKZWdM+Sl24=:19
 a=z/mQ4Ysz8XfWz/Q5cLBRGdckG28=:19 a=lCpzRmAYbLLaTzLvsPZ7Mbvzbb8=:19
 a=xqWC_Br6kY4A:10 a=x6icFKpwvdMA:10 a=0kUYKlekyDsA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=64Cc0HZtAAAA:8 a=ua_N-wOVawbHOeQA46IA:9
 a=cPQSjfK2_nFv0Q5t_7PE:22
X-Proofpoint-ORIG-GUID: 4bp1tflh_zlQrQPkHeyYBpxMygaHpSH-
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1121,Hydra:6.1.9,FMLib:17.12.80.40
 definitions=2025-10-23_01,2025-10-22_01,2025-03-28_01
X-Proofpoint-Spam-Reason: safe
Received-SPF: pass client-ip=148.163.155.12;
 envelope-from=mark.caveayland@nutanix.com; helo=mx0b-002c1b01.pphosted.com
X-Spam_score_int: -27
X-Spam_score: -2.8
X-Spam_bar: --
X-Spam_report: (-2.8 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_LOW=-0.7, RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001,
 RCVD_IN_VALIDITY_SAFE_BLOCKED=0.001, SPF_HELO_NONE=0.001,
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

Following on from the original discussion and series which has been merged for
the 10.2 release, there are still some concerns as to whether this will have
an impact on users.

Rather than outright reject modern x86 CPU models for the isapc machine, take a
gentler approach by starting the normal deprecation process as suggested by
Igor.

Signed-off-by: Mark Cave-Ayland <mark.caveayland@nutanix.com>


Mark Cave-Ayland (2):
  hw/i386/isapc.c: warn rather than reject modern x86 CPU models
  docs/about/deprecated.rst: document isapc deprecation for modern x86
    CPU models

 docs/about/deprecated.rst | 14 +++++++++++
 hw/i386/isapc.c           | 53 ++++++++++++++++-----------------------
 2 files changed, 35 insertions(+), 32 deletions(-)

-- 
2.43.0


