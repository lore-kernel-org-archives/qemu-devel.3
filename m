Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7B107C982ED
	for <qemu-devel@archiver.kernel.org>; Mon, 21 Sep 2026 11:37:07 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1x8cKE-0005go-Og; Mon, 21 Sep 2026 07:36:47 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mark.caveayland@nutanix.com>)
 id 1x8cK3-0005co-2Z
 for qemu-devel@nongnu.org; Mon, 21 Sep 2026 07:36:35 -0400
Received: from mx0b-002c1b01.pphosted.com ([148.163.155.12])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mark.caveayland@nutanix.com>)
 id 1x8cJz-0007vr-38
 for qemu-devel@nongnu.org; Mon, 21 Sep 2026 07:36:34 -0400
Received: from pps.filterd (m0127843.ppops.net [127.0.0.1])
 by mx0b-002c1b01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 68LAfatP878504; Mon, 21 Sep 2026 04:36:26 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nutanix.com; h=
 content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=
 proofpoint20171006; bh=eNYMq3JkNMR3ougTL4C8nUG+DKPhxzNogqTTUjQXF
 5k=; b=YG5loE4pnmOOXBOQOUrdy/jMuvPSTbwOzO/bzyzWo/BD5xzhmPKpJr46D
 Fye6LtvJzNk+t7huLIvJBbeqMdmgu8qtQNTtRS4n5ctpWc3qvuV30L7d/L8RIVlG
 DdUb43NYgbDPmcJ+j+MJdoiCBvZ/KD2DRMfN1FuXsDdxHjqDhfV+i2EaDyL5fcRr
 M+hYUaMI+tt6qBltaJth41RovJif+c5n/FRFL6gPYe/1SqfVp67GJM4r6904Lciu
 XS+EOSB2QT0vQmBrWgWuYZmy6e8xqEhj7/CvUWBJZ8j/7JgP/ZXIuFVUYSYoVfyr
 KkIkI6nj4l0PG3h/iVx+zoy0BDa4w==
Received: from sn4pr2101cu001.outbound.protection.outlook.com
 (mail-southcentralusazon11022079.outbound.protection.outlook.com
 [40.93.195.79])
 by mx0b-002c1b01.pphosted.com (PPS) with ESMTPS id 4gsrggjwrp-1
 (version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NOT);
 Mon, 21 Sep 2026 04:36:25 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=B3r7BLDaWiKWKzNW9HPQ8DZHoAkqt7lBHXxA+1OR36G8PCNmmxmnqNiuL1IC+dwrYGFKQeIPN1+UFO0F5Ukc9xPnrwq/KYbMbQRU6YeRybZlVuZ1dn+tDPdhq3L/MvNKBVHLxdn75fXcxMDGGPhlVyugczJgoaFzw136Flx9X/nNPCT+uMhG9hs3E2i/RGgPRmw4zGdb+miUtBPFSOiEOMyEXjGx2PoXkg/q+4WCIbO5nWG5F1HOa90qN+UFpbic/G7yuK1pgwPJjPPrTWjnNq4Wr8+I31X/tzWg8kKX3+6mFl8A9plwPt7VHkuBTW1nUwupJLUw6BI0bkszHr9lvg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=eNYMq3JkNMR3ougTL4C8nUG+DKPhxzNogqTTUjQXF5k=;
 b=lTF/0W5IUyf0EdchwbIhrltr/ICDVGIWu3XcKrcMmoYQ0ZA28r566mhGbuJxvmqCHaXWsIZ9OM8XTZOD5kQOL8m+FgqVblEqgdOFbajehc/w31HOB2DJqgO7gzpsWAX8wwp/6mw+5L+ynKGoCe/ieYnKo9GkJW8AivBvvIiqvOW9Gr7gc8JqR8IprRS+o00xHvU2Kco7eLTrekPg/opGJgVbHgazukxUmUU4U3kBy8X0GBK87WR5lwncQbfJ6Ysrx/wpNKUZsRt+aEkC09+VXks33kZE4YVBxm+VD0CVxS4aaOO0ZY3XFyldlWm74GqGlXQ/OYN4NshaFMHYs1/foA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nutanix.com; dmarc=pass action=none header.from=nutanix.com;
 dkim=pass header.d=nutanix.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nutanix.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=eNYMq3JkNMR3ougTL4C8nUG+DKPhxzNogqTTUjQXF5k=;
 b=uFg9tqQxh6eA3odQDsCYZB/0xKPMDfse0oaRs4eILr2r4bIFS49QnfPDH1A9apfcpYTkuqdz1UT7lSedmX5XVlfkI9UxKXA3IRsjXmwi+TMhu7Oc4W02s7uPrneq0WJ1GeOcOCJL5BNzSrkDNBv+oEDP7ltPP/vQnRIH7H81tvKcAO4NH8lIEJZRZlmm6K+ntjz2CRGTzOMniL4LlOrv705Rx25Ty681PXo9depfKzRuWpxeIKP3T7aQVPRz6DxauZnoaovHRBRdnl93R8vLBliMZZHKt8bL5/vzSigA+iR/nqwIVGZHZi8OOAKAsfQjuIlft2ikzu5sgaY3dEminQ==
Received: from PH0PR02MB7159.namprd02.prod.outlook.com (2603:10b6:510:16::8)
 by SJ2PR02MB9416.namprd02.prod.outlook.com (2603:10b6:a03:4c4::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.428.16; Mon, 21 Sep
 2026 11:36:24 +0000
Received: from PH0PR02MB7159.namprd02.prod.outlook.com
 ([fe80::8e97:bc32:822c:b250]) by PH0PR02MB7159.namprd02.prod.outlook.com
 ([fe80::8e97:bc32:822c:b250%4]) with mapi id 15.21.0428.015; Mon, 21 Sep 2026
 11:36:24 +0000
From: Mark Cave-Ayland <mark.caveayland@nutanix.com>
To: pbonzini@redhat.com, richard.henderson@linaro.org, mst@redhat.com,
 mtosatti@redhat.com, marcandre.lureau@redhat.com, armbru@redhat.com,
 qemu-devel@nongnu.org
Subject: [PATCH v4 6/9] hw/i386/pc.c: convert rtc-time object prop to a class
 prop
Date: Mon, 21 Sep 2026 12:35:12 +0100
Message-ID: <20260921113559.1299740-7-mark.caveayland@nutanix.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260921113559.1299740-1-mark.caveayland@nutanix.com>
References: <20260921113559.1299740-1-mark.caveayland@nutanix.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: SJ0PR03CA0155.namprd03.prod.outlook.com
 (2603:10b6:a03:338::10) To PH0PR02MB7159.namprd02.prod.outlook.com
 (2603:10b6:510:16::8)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH0PR02MB7159:EE_|SJ2PR02MB9416:EE_
X-MS-Office365-Filtering-Correlation-Id: d4c66b8d-f8b3-419f-7a04-08df17d49109
x-proofpoint-crosstenant: true
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|23010399003|1800799024|376014|366016|56012099006|10067099003|6133799003|22082099003|18002099003;
X-Microsoft-Antispam-Message-Info: 8gD/b2Y7IuRI5bprjhZmp0zN/MNTXEsPuxvYBCO6UfSJuTfwa/J1aAQdByQxLE8Nkdvor7Iv69EN2J9K3q5m7nCARGEhxeYf9hUpkpIA7rm0T3PG8wh/yER4uwe3qcsVXU2TpXMF31CJGWQ+Q/rwKPmWDQOuGxtY5rkaUmHXp0WhEsPe23PYK6EoJpKCvgpfare6narcUWCyBafYtbNDu9AIRZqlr0T/c2PDcd5Bt9Nsl9e48DY6QruDSC7P9OSJcly4h4uaW4y6Eg7eb8nwNtmyLg3IETDcaHlhugzvqvNOM8taSVTXxxwFvvfe/Lsa5tlnHgvs8OycM28hgNq8ovnD38KaJvXv1leSQp6SI9rI6/cF7ydoPNJejxf9L1pp7ui8yugucV0t1nlfnWdCI1zXYnq2bQPEutyRs9Bu82XhliHgwEAZU8E0bYvNeovgFC/MrsSEfNr9+CFNDOF3poOkPxLlgAdXMrsR2IXGpf5QDX+uMBVlIsFsavGaNRaDaMBxq52wp/1ihO1x4UZbJxXC7KqGVDrUTuhL/yc/ra5pdWkl38K3l9BNuoBaeHY8vzSHKvGAfjP2CmRdjmC8RizFnVD44x5yT1eDMrbLcysFNXIO8cNoxe+xC4juPoWiDKgeInK3VZu6J+xNk6DHT50BXRfrLcBE1zC/S7fpraU=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:PH0PR02MB7159.namprd02.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(23010399003)(1800799024)(376014)(366016)(56012099006)(10067099003)(6133799003)(22082099003)(18002099003);
 DIR:OUT; SFP:1102; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?T0p6YjFyR2IrRElISGpFRlFiOGRRNzJTT3BkSVFHdTQ0cmFSUiszcTltUWRC?=
 =?utf-8?B?MWkwOS8zUTA1SktwcktiY1cvWkN6WXRRTFBremxGK3lSSTd2Nkk3cTJnYmNj?=
 =?utf-8?B?QjcwVmRhVjRSOWl3bXhrRFUweHJrMEdwdnpvVk02RXZGSzBnZDJKR0plN3Nh?=
 =?utf-8?B?U3NXYVNQRzkrL1BTeXRvS0M2dnNlempVL0creXBUQTlBeWlIN1pZem5Scm5R?=
 =?utf-8?B?a0dMK2Fmc2NDWWpJOEtQVDVUK2JIcUdnODhVNVhENFhMYmRTTW1rTlZ1dDVY?=
 =?utf-8?B?aXhmQnVrdC9NUUNic2E1dEQwVVk3Z0lERGlaMnJIT2grc0JYc3dPL2xiV2tH?=
 =?utf-8?B?WjFXNmdrbS9OUEd1Tlg2THpsTzF2cDAraThjVWl1RkUxR1FRM1BUOEhBQVlW?=
 =?utf-8?B?Y3VVSG5YYTVlckRmQ2RFVkVMNmxSTzcrZGczQnRDL0liTTZCemtLdWIwa01w?=
 =?utf-8?B?QVhmQy9GYXNOZnZ3bm1IS0FrRmlNLzFDYUZLT3hKaWVjZzFYenN2U3k3Z1lV?=
 =?utf-8?B?bldqbkVmS3RGTEExblE5a0wyUG96bzBWYURJL2EvSFdDTnZjNmdwaC9sKzJP?=
 =?utf-8?B?cUROL1hHTUtRanVGZjBhem5RNHg2aTdKUGFRNmRGbElSMzFmZHJlQlQwakNV?=
 =?utf-8?B?d0dhWU54dlUxMU14MWNzSGRCNTc4MklZbXc2d1RFcTRYUnpERmY4UmxoQith?=
 =?utf-8?B?N0hJRTRmUE43QmJZRVRWLzNBVEw3RjBZL0k1UkMzaW5WVE5xU09BcFo1WWhh?=
 =?utf-8?B?Z0lmV1V2WlYxWlNvb2xMTTl6UktWMmUzOEZDeVIxMGxLaytLMVB2blZmVE8r?=
 =?utf-8?B?Z2VnUHpxU3dmSTJici84MCtRMnlWd2R2YTQ4cis0OW81ak1uMk9NaUQybHdS?=
 =?utf-8?B?RDBnZjB4MlJaR2ZlaEpvRHdNZEV1b1ZweitRWURtMkNrVzY1bFdMN2RyOUpH?=
 =?utf-8?B?Z040M21ob2VUTmVWUUMwNXJoTy9VQlg5aVF3ZDliUmVyb3pxeHRIRjNOQzlP?=
 =?utf-8?B?Ri9TcTF2bVZHQXVLWUFwZTBPOE5qR2RzdDU1VCs5K1AyWUQzYVJuV1hrK21L?=
 =?utf-8?B?NFIwSlF6NzI1NitUV1FRZnFGc1BrK2gyWEU2Y1ZKZ2RSRENCSVFSZVQ2dHlT?=
 =?utf-8?B?U3hod2NuRTZqUjlvdzRQQkdtMi9wOGYyMm9ZYTJLcXh2QVhRRlk3QkR5dm1h?=
 =?utf-8?B?QkhiUzh6bUNSendPekI5MXR6TmpOV29zeSs1RWJhK2NWS0p2SDYwaVJjdjBT?=
 =?utf-8?B?TE9VbUFlenJVU2xvaWdRYlkxb21xOS83L0ZqemdxRjRXR0c3M1BKT3BNUlp0?=
 =?utf-8?B?eFJBWEVFTnRBV0I2cW9EWnBjMkFZNlVLYmlzUXkveUs0NXRjdGJoaSs0MWpE?=
 =?utf-8?B?Sk9hTTJMbnYwOHRMc1ZYcU53a1FFejZUMG9wc2Z1MitOZkczL3B0d1dXem9C?=
 =?utf-8?B?QnY4RWRHWk5JY0RXM2xoOU1SMjJwRFNwUTNKL2N6UkNibk5LQ2xPY1FhUE8z?=
 =?utf-8?B?b0xuZ3Z4TmRpNUlGSDhreFhFcTVUL3hvWThWWDIwdlppdFNScU43aVRVeDJy?=
 =?utf-8?B?QldvNzZjOFcvMGNFZUdGR2RDeC9jRVNteUlKQWE0aENOelZtWmF0WkJQcEc0?=
 =?utf-8?B?UnV4QkJoR1ZraGNESVl4aVdEdEVqM3JaSUNhM1lSSk5ZSWlOb1VjVTlHOFNH?=
 =?utf-8?B?RkE2dGFMS0VTRzdrZ3plVjJMWGtsUkozZ2xNUnJiQjBwMlpqNnpESmN3RUdL?=
 =?utf-8?B?RHFYWnUvenh3Rk5GRUNYVEFRbDFhVS9yK1YwZXFmdlNtWm0zWWJXZERZT2hh?=
 =?utf-8?B?bEJrTTJnYmk4SnhlNlVyQVo3UExTcTMvN1RDSnJMTkFLdkMrOHphMm1PYkxu?=
 =?utf-8?B?S0dtQjdyWjZvbVMvbGVHQUFhTzkxaXBFK0laQ2xKOW9UMEJOZ0hORGZtVXNh?=
 =?utf-8?B?WXZheGljUmNSVjI3bzBPdGh1RmxLMHRrZ285VmxhYzNyaWpBRndlZHh4Qi9s?=
 =?utf-8?B?Z25rSVpwY2RTa1A3WGVvaElHL3d1VUxjU0ZueGZ1Sk03RDM0RC9WQzZuTG9q?=
 =?utf-8?B?aDV5c3JDRDFzRHZKZjE4NUgyNmkrTm9EWmo3cXhJUGhjVjRhUFJXWXFhSDl4?=
 =?utf-8?B?Z2szV2lTd1hUTGtQWDREYkFoMUZtWThuV3VqQzJtcXB2alllRmxjZ21VUGw3?=
 =?utf-8?B?V3ZkWnNOZmp1TzFPWHlWVEcrVE1tejFCaWVMRzg4ZW1QUmx2bVE5LzBlSUpO?=
 =?utf-8?B?UTgzWGt1RTV4U0xybU4wSGdiNmZ4c01xVGx0RXVIMjV4L1l2Q0FCSkZ5TUdZ?=
 =?utf-8?B?ZTVTK3JsZm4rVjZpMEVoYkNKV24xenNiQk4ramhXR3l4ZVY2S0w3S2NCNTA4?=
 =?utf-8?Q?FAGJ5pziM+15mLb4=3D?=
X-Exchange-RoutingPolicyChecked: andGivTgUFQ3QJx5ES4tFrql1Yx6drLFa6bE3NQYaLFT0OFHNXgKeYZ7Ru62ZKaWLtK6Jt6HdccEUkCYvO31+Il9EJNWgA6xACCP213k00XI55zeZVEpMxRM4itBzupIR/nJ0ayQ2DNeVNh8ZuMkAgtfm+wX93JWdAgFRFVqprNyUHF1sc11ZZ7E5ydo9faQKiWUzkeS9NAAcL+5UPbPWyS2vdvP8rt4vSQ8PMwyo6zXMseFPyXehB6YmY/+SY7J5v2qhU4j0S/cra6c40V/Y2LMYeiz0OVal1pUZNbkKwynjNeFc3qs0n0ElgDngTJIGrXVT/RETP9KEOCjXf4pzw==
X-OriginatorOrg: nutanix.com
X-MS-Exchange-CrossTenant-Network-Message-Id: d4c66b8d-f8b3-419f-7a04-08df17d49109
X-MS-Exchange-CrossTenant-AuthSource: PH0PR02MB7159.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 21 Sep 2026 11:36:24.4358 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: bb047546-786f-4de1-bd75-24e5b6f79043
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: /GsN1h+0NPAem7RM28FQSsJspHBNsWQBYRq7zSXSRF6ry9CArVkO/i3FkI7nz87TFrehFNtVFTLsQCavZpwC3caQjHJUD9vCbQe37zTVpLc=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ2PR02MB9416
X-Authority-Analysis: v=2.4 cv=A775rKWG c=1 sm=1 tr=0 ts=6ab116b9 cx=c_pps
 a=ON2AtRasCbt5Ww1V1qMYlA==:117 a=6eWqkTHjU83fiwn7nKZWdM+Sl24=:19
 a=z/mQ4Ysz8XfWz/Q5cLBRGdckG28=:19 a=lCpzRmAYbLLaTzLvsPZ7Mbvzbb8=:19
 a=xqWC_Br6kY4A:10 a=IkcTkHD0fZMA:10 a=VdqzKS8jKosA:10 a=0kUYKlekyDsA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=VofLwUrZ8Iiv6rRUPXIb:22 a=dEe9Ve2bX-KnNSUMM2s9:22
 a=64Cc0HZtAAAA:8 a=20KFwNOVAAAA:8 a=EUspDBNiAAAA:8 a=DDMMZ6NTPqBClWpVUZEA:9
 a=3ZKOabzyN94A:10 a=QEXdDO2ut3YA:10
X-Proofpoint-GUID: TtDZB2iNvXq6qFEDfgf9-tuyCK8_Si4a
X-Proofpoint-Spam-Info: AW1haW4tMjYwOTIxMDE2OCBTYWx0ZWRfX+BR35giaXFVb
 Rmp5mQ3PJpq8ktSL64wqvXFzmKIhcGvBb6RZTa7mQwH2kKvFei/3hFW+fS7SXW7Obq27UrT1lja
 rqX9pTdNMnEp3YYajbSe1v6vS2Hx8eY=
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwOTIxMDE2OCBTYWx0ZWRfX6wffhJCh84ex
 ssvngYSYm9ZPdo6NFkCu+hEjclV3f/neZbDyiWk/iweAIwwq803GgBdpzcDnV+5nq3emNW6o8tI
 oU/zHJ01FwLpPHfBPr818JRWnFCe9uTLS83i9I+AO+gNeXDySvve4ILpBzgkcMAANNcq/uLWiXJ
 5zzKomqVBx8/s/8FB6p/c697fceYBdAwy5hEfZJjSxSJKHshxzlNZl4IpV42MGw9C19bfov8NCN
 +0OzbWi1PLzI4uQ7KDaITnInrxPZMGKlFUb0TYcPNmcbiQQhm7VCO9fkWpAB/aENEZ/MPd0RyJm
 3ZU7l6Ceqkq4kmgjwAJjh23fDYnqi+Qi1bb8rgy0y1pILCn+4iliBuWtBamLfR3up+xQyYFhhht
 27Y3MleAUUWYy8fKRFCpUdMi1S7LaLoGuHME/UmkP5gYUgDO6FSx54crksvUyMVdnC+iJ5nqg0/
 DJUVKUPl8wPZ221BUVQ==
X-Proofpoint-ORIG-GUID: TtDZB2iNvXq6qFEDfgf9-tuyCK8_Si4a
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-09-21_04,2026-09-16_02,2025-10-01_01
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

Signed-off-by: Mark Cave-Ayland <mark.caveayland@nutanix.com>
Reviewed-by: Daniel P. Berrangé <berrange@redhat.com>
Reviewed-by: Philippe Mathieu-Daudé <philmd@oss.qualcomm.com>
---
 include/hw/i386/pc.h | 1 +
 hw/i386/pc.c         | 7 +++++--
 2 files changed, 6 insertions(+), 2 deletions(-)

diff --git a/include/hw/i386/pc.h b/include/hw/i386/pc.h
index 2f1603e104..cbe88a1788 100644
--- a/include/hw/i386/pc.h
+++ b/include/hw/i386/pc.h
@@ -39,6 +39,7 @@ typedef struct PCMachineState {
     BusState *idebus[MAX_IDE_BUS];
 
     Object *alias_pcspk;
+    Object *alias_rtc_time;
 
     /* Configuration options: */
     uint64_t max_ram_below_4g;
diff --git a/hw/i386/pc.c b/hw/i386/pc.c
index e2ee1bd88d..70677786bf 100644
--- a/hw/i386/pc.c
+++ b/hw/i386/pc.c
@@ -1097,8 +1097,7 @@ void pc_basic_device_init(struct PCMachineState *pcms,
         qdev_connect_gpio_out(DEVICE(rtc_state), 0, rtc_irq);
     }
 
-    object_property_add_alias(OBJECT(pcms), "rtc-time", OBJECT(rtc_state),
-                              "date");
+    object_property_set_alias(OBJECT(pcms), "rtc-time", OBJECT(rtc_state));
 
 #ifdef CONFIG_XEN_EMU
     if (xen_mode == XEN_EMULATE) {
@@ -1792,6 +1791,10 @@ static void pc_machine_class_init(ObjectClass *oc, const void *data)
                                     offsetof(PCMachineState, alias_pcspk),
                                     TYPE_PC_SPEAKER,
                                     "audiodev");
+    object_class_property_add_alias(oc, "rtc-time",
+                                    offsetof(PCMachineState, alias_rtc_time),
+                                    TYPE_MC146818_RTC,
+                                    "date");
 }
 
 static const TypeInfo pc_machine_info = {
-- 
2.43.0


