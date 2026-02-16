Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 69B48E63F3F
	for <qemu-devel@archiver.kernel.org>; Mon, 16 Feb 2026 09:32:43 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vrux9-0000Nq-IT; Mon, 16 Feb 2026 04:31:39 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mark.caveayland@nutanix.com>)
 id 1vrux7-0000J3-Gb
 for qemu-devel@nongnu.org; Mon, 16 Feb 2026 04:31:37 -0500
Received: from mx0a-002c1b01.pphosted.com ([148.163.151.68])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mark.caveayland@nutanix.com>)
 id 1vrux2-0001Yd-8f
 for qemu-devel@nongnu.org; Mon, 16 Feb 2026 04:31:36 -0500
Received: from pps.filterd (m0127840.ppops.net [127.0.0.1])
 by mx0a-002c1b01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 61G967Zf3282454; Mon, 16 Feb 2026 01:31:23 -0800
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nutanix.com; h=
 cc:content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=
 proofpoint20171006; bh=kxHktCdTajS9mfa5rqrXindKgGvgiv0AqMI2jzszk
 d8=; b=EL1mgBM553yPsTrL2gzyWui3WVI49ZlXGJzNueVgQkB3oUZWHu+1gZiE+
 eLOEjbZIW7SKtstATwMCVnr/yv371+bD8VY/nO7/V/MjGmnfhwkeR4eKTo0F0uCK
 X8rrQ3zJZMGjhv/N+1XfxanjJ3d61C3Y3oCXF7aCe6e0IVltUscQiUzMpoxqiv7m
 xD6HMKC9OW9gJcqjkxvcslK1hZCiD7duFCMXoaQOE4ZRXLelNFdhJz1iigo2slhP
 UzLRaYyWXYIrKCyQbITDPVLHiBYQjAkkeod74G/BiWFvieZh0wr7LYRYVs6Om02L
 Y3j3yFJOAjXaBRNlxNIVtZXkTNDZg==
Received: from bn1pr04cu002.outbound.protection.outlook.com
 (mail-eastus2azon11020085.outbound.protection.outlook.com [52.101.56.85])
 by mx0a-002c1b01.pphosted.com (PPS) with ESMTPS id 4cap8wk4ne-1
 (version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NOT);
 Mon, 16 Feb 2026 01:31:23 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=jnzZqdwufT5i6hfjac1ewT5NBhy6PZx8oET7IEcV1SJrtSN1iTpCdvtL6hgXf7RvZVAZIgg/CsevtjvhIuPO034uN/gZu6l0/LPCOMFrfKw9qsreQUbeiNQMnrzeOHxQl0S6cLGa+v0l/ZVxz8L/B1o/d/IyJ+5oneAJ2PF3cjmhHvpdWdn61B6gWnbO7plMaKy0rTn7RdtpWTDhbEYTSaTbzboIUSv+fQ8B371hkuSZE/8UPc1Li0No9X9MS6nRx4/V5f20nRP3JKKTU4mtYSnGHQrKrjgtnDBukkbC8k8iE9bNUvilfT0grp7suOrqyV3tIX6rHP+GTYaE3AQhoQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=kxHktCdTajS9mfa5rqrXindKgGvgiv0AqMI2jzszkd8=;
 b=il541svPi3nJwEjpnIv9FO1rV4A/NTgdy/xm/iXTHQfRsd5E3DZOlelAFA4xugfEo7nP6EKxFg9yqLlfQzyf3h5tHMgbsBz/loam7Yj0wNAyDvF+D6WeDQK22tQWxpT4edmWTCv4RmowuX1wvpFQJhpb8T2buxwNUk3FxhrxVH6ec3R3ihdCrZcLAAbscS1uAPBw2RIBAcf4sobIJXXb25sBJtx61tEgCfGISR2neZFnSehfotVX6Sz8R+LF5O0OylYaJ1xQRzdZu660S9iWBwub2vzoCiuU6SO12BIQ/II1n5Gktf90oZHNMrXyGtS+QZ7le7cvMZqREiZY1vImzw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nutanix.com; dmarc=pass action=none header.from=nutanix.com;
 dkim=pass header.d=nutanix.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nutanix.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=kxHktCdTajS9mfa5rqrXindKgGvgiv0AqMI2jzszkd8=;
 b=VUdisrkgOY2H4TTeqly4Nvf8d/zwz5v913hzUnvCAGwYgBPjV+OFPhxjcwP8fT9yCQSF0qp+S4tUFGPOgyBGQEIynbUA+XNVIOsJNkd0lkyaaKx4WzNP3I8ib1BmZ1MzpLcpMivMpsFg8/rTw2USrkfTSnESNYRbVjbQrQEiQ/jQppGUPFLP7OXLTOVOobKYhvhVA2EMQgM1mSwQImMkOZ5GNWJqin2xZFN4klfi20lglqTrREQTtn6X+X0+jTt6fTqXZWHFGpnLD1fHGsrxGq/UFwG44PXv/Cnhwyirt+97jN6Myk3Pn33NRlLwdLKvFYUa3XrNkGt2/xls43ksNA==
Received: from PH0PR02MB7159.namprd02.prod.outlook.com (2603:10b6:510:16::8)
 by CO6PR02MB7761.namprd02.prod.outlook.com (2603:10b6:303:ab::7) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9611.14; Mon, 16 Feb
 2026 09:31:21 +0000
Received: from PH0PR02MB7159.namprd02.prod.outlook.com
 ([fe80::8e97:bc32:822c:b250]) by PH0PR02MB7159.namprd02.prod.outlook.com
 ([fe80::8e97:bc32:822c:b250%7]) with mapi id 15.20.9611.012; Mon, 16 Feb 2026
 09:31:21 +0000
Message-ID: <265f1343-64f6-4357-a82f-d20bad056904@nutanix.com>
Date: Mon, 16 Feb 2026 09:31:16 +0000
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 31/43] audio/mixeng: replace redundant pcm_info fields
 with AudioFormat
To: =?UTF-8?Q?Marc-Andr=C3=A9_Lureau?= <marcandre.lureau@redhat.com>
Cc: qemu-devel@nongnu.org, =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?=
 <philmd@linaro.org>, Gerd Hoffmann <kraxel@redhat.com>,
 Christian Schoenebeck <qemu_oss@crudebyte.com>,
 Akihiko Odaki <odaki@rsg.ci.i.u-tokyo.ac.jp>
References: <20260127182516.289834-1-marcandre.lureau@redhat.com>
 <20260127182516.289834-32-marcandre.lureau@redhat.com>
 <6f204d62-f14b-479c-ab37-1dcca6b5bd30@nutanix.com>
 <CAMxuvazGyHmW1iUcyaKuEdwjvmHRxP_oF-0vno2eZc+-8XH_mQ@mail.gmail.com>
Content-Language: en-US
From: Mark Cave-Ayland <mark.caveayland@nutanix.com>
In-Reply-To: <CAMxuvazGyHmW1iUcyaKuEdwjvmHRxP_oF-0vno2eZc+-8XH_mQ@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: LO3P123CA0024.GBRP123.PROD.OUTLOOK.COM
 (2603:10a6:600:388::7) To PH0PR02MB7159.namprd02.prod.outlook.com
 (2603:10b6:510:16::8)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH0PR02MB7159:EE_|CO6PR02MB7761:EE_
X-MS-Office365-Filtering-Correlation-Id: 2e474b7d-40f2-4161-566f-08de6d3e24f7
x-proofpoint-crosstenant: true
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|1800799024|366016|376014|7053199007;
X-Microsoft-Antispam-Message-Info: =?utf-8?B?dFdoS2dtV3VqREp5TW1xNlJ1c05aYUMwU0NJVGJYa25tc29KbUdWNExrdjR0?=
 =?utf-8?B?R2VWc1JSdUU4RXF4WDl0NkxzU1VFZThWN2FFYXFCUVZqOW9xeEFFaHF1c0lX?=
 =?utf-8?B?aWtZZGE4dnBTNEkvWExhZUZKRGVrQWlIVGlKSUM4UFAvZ2xyV3Y4dTN0aEFi?=
 =?utf-8?B?dTJWZ29ML3pNSHh0Vm1Pdi9McFdTZTJ4dlphcFc5L1FuOFVKRjFDWjFyTXZW?=
 =?utf-8?B?VVA5ZkZJQmppWkNXSnFsdGRRRkc5bmpjNmpkcm9LRExqZWhEd0xVZitjRVNw?=
 =?utf-8?B?eXluNjdDaW9SVmYydzYvWXlDYzNsRWV3cXFMeXVScmZxcmRCNktIc1JZcTE0?=
 =?utf-8?B?UTdmVTViellDYk5nYU5XcVRpc1ZuUTh6S1FKUXd1Z3paWTNHajBROTFlbFpI?=
 =?utf-8?B?VFVqd1JwY2w3VmRaSHFqZXZjVUt0bjBmdFBhM0VsUTY1R0xCTXU0bU95eWd4?=
 =?utf-8?B?UUlLUnhwcFBObEhobjdaSk1TbStVQlVJTDJMT2gweklPaFR2Nks1YzlvMnp0?=
 =?utf-8?B?QXZpSXhNZjg0MFErUWdkWmlVSDZLMVhubnM4SExhTVh4bG5OelROTzBVek4v?=
 =?utf-8?B?WTdaWWIxU1pBb2F2U2lFSG9rVFB6cnVvSE5tbmxUZTRHaHJQMERpZHcwakdS?=
 =?utf-8?B?UU15MWt4RSttRHZpTUl6T3V0M1U2L3M4NUZ4eWF0aWFBMlpZenQ3U2xCL291?=
 =?utf-8?B?OXZtOVlrR1hOUG5WY2w4Z0dta3VJYm55WU9IY0pBTWd6YlJFVVU1YXREMXpq?=
 =?utf-8?B?emFSSmZuYlh5a1pTcXlnQll0VFhCSjRBTU5mWnZZSnh5VFVnOTBLVDBQSWZU?=
 =?utf-8?B?RWk4SGpSeDRpNHVzL3RFcnVjTWsyaDhjYUhxS0RkNytkaTQzVE9VdGlOYk1Y?=
 =?utf-8?B?YWxya2djNjlUc0IzTmJRS1EwNVRuK3BXWkRSN3FvVm1yVFpDc1JwQVBFZWdE?=
 =?utf-8?B?aEZVb3NiUE5sQXRSL20rSHQ4RkluSndlaU15M29YU1JBTHFFN1VVcnBvSHB5?=
 =?utf-8?B?WnhZZU1RMHBkTnVmemRocmoyRUQ4alFaN0FER2hHTGZMaTF2Uit3blQ1eFZu?=
 =?utf-8?B?ci9pTkJacXVwWGlxM2ZmQXVCNE9pSzRET3NIbFI4VGV2d3lNbEY5ZkRrUVpK?=
 =?utf-8?B?WEEwTVdMdURTQ2VWeU9ObFRPUXBsNmVYeUFhWmt2eHJVUExRSnlrT0twcStP?=
 =?utf-8?B?Mzc3bEZUL1JwVjc2TlNBNlBDVDNWaTR1VlRoVnJHWE9MZXpqZExKeTBkcDN3?=
 =?utf-8?B?RHpLTUUzY3lZWFhHKzNUMUxDUFVFT1pyL3h0YVBseW0wZ0RCSFhiYnZKUUlw?=
 =?utf-8?B?NWpxaU5Wc2pjNzJTWWNtdGwxMURUdHZJMGpyS3NYWTZwR2dPMitGRXFDWnFh?=
 =?utf-8?B?SFJyTk5vMDFqdEtsRjN3MW9VMlBTb1R1VnpmVU1IQlI0eldqa3pEd3dYakpX?=
 =?utf-8?B?aEQvd0ZlMzRBbW9MYWhzbWN0cWFXNjh0clh5UFU1UEc3T0JnbVlXblhrTnNI?=
 =?utf-8?B?OTNrZUZzbElIMTJ5V3B2RkY5cklTa1lUd3dGeWtKN2FGVVdReE1JMzhTOTdG?=
 =?utf-8?B?QUFRRkpRVlMyNDVkYlEzby9FYUl3RnE3QS9nRis3MkUzcHN2dnd0WnkvcTBS?=
 =?utf-8?B?bGxVNkQxSHNHQUtwWm10UWZ3djJBajBUcWVPTU5Ud0I0bmxsbHdUUmVINXMx?=
 =?utf-8?B?QXhmRnI0ak1XTWlMQzZ6WTdUSS94bzNuYW9mYktLc05DWFQvZU81SGdhUHdw?=
 =?utf-8?B?ZE54OHkwd2NmV3AwbTNxRzFHMlljVm9SNHg0SDF2WkVsdllFTTJxT1BrZjRp?=
 =?utf-8?B?ZDdPUUxLWlMzRWk2UlRCeFVFU25saHE5dS8wSDhwZVp2ZFFJeGNkNEhyMC9I?=
 =?utf-8?B?ZU9weDE1bngxNGdjYjBLay9ZNU9VL0pJc3gzMFcyZ0ZqU0NTNTJ0Q3FxYyth?=
 =?utf-8?B?ZXI0ZTMrMHZiSHZVUlNFVm5hcEhlaVRvZVB5ZVN6SXdGT05Xaks1dlR4c2JT?=
 =?utf-8?B?TzVnMk1HbG4xUkFBQXlvVk1YUlVGeXE0U3FKUVJST3hGZmoyMXlTaFF6UG9E?=
 =?utf-8?B?Z3pIczN4WmMvcDZEb3hxakRZMXZzZE9TRkg1TzUrS0lraE91NmFuL3BhQmJj?=
 =?utf-8?Q?WJ0w=3D?=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:PH0PR02MB7159.namprd02.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(1800799024)(366016)(376014)(7053199007); DIR:OUT; SFP:1102; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?aWk4OFRKdE9iOTBYUThpNmx1aEMxRWc0bERieGVxRWdIRzRwNDcrWVVnbWFp?=
 =?utf-8?B?Q3BmNVlXUUxtQk5lbU5rcUFib1B4RTJxRFVQcnRsaFZCaWp0dloxU1NFbUhO?=
 =?utf-8?B?bC96R1FURkM0MWhqM0hKQXM1dGFqMTZORWRPYTVXY1pEZml6WmthamMzZ04x?=
 =?utf-8?B?RDRmMDdvcGZlNGNTMXF5VS94WTlwcEN2QmhadkI5TVR5TStPRG1pQUxOdndu?=
 =?utf-8?B?TTVkR1J2eFp6T042QzRQYkYzSm50ZFhBVEVaTXJDTU1wOEM3SW9ISWlsUk0y?=
 =?utf-8?B?WlppZjRRVzNoUmoxV3phbjVlUnRCNTlDZElIRWpic0p4b1BkT2JTcFc2Nmh3?=
 =?utf-8?B?dGlvVHJMM2hZRytvS2VKbkFpK24rWXY5UkFhd2d5Z1ROdjFCNGl5WkQ4WGpB?=
 =?utf-8?B?NEF6d0tXQkFZYzNwNzNkSHdHN1ZhNGdNVGR2a0dWSW1qMDBaVlVSOVgxZ25Y?=
 =?utf-8?B?M0VvY1VjbE41ZFN1bXhlN09jVks5RXVDMzZxTmhUVWo0cjRGWmdCbkdVay9Y?=
 =?utf-8?B?MzVTZkZidzlwSmZxYmJma3FLYW9wdndWSXF6c0lXQjZodENMTlZ0NWwwNzkx?=
 =?utf-8?B?Mk9qZWhnRmNkSWoyWG5STU9CUWJGU1JJdkdVYlZDdFFLcUFFd0RKUENmSitZ?=
 =?utf-8?B?SFVqRVdGenFWbjJnWGxWUmRuc051NmFWNm5xWUJMU3V5RHlkWjlRS2IrOVl4?=
 =?utf-8?B?ZjFNOWxoRzQvbUZyVjZtUHlkRkRLVkozdUV2NXhoclB2MjZIY3pUNTBJTTdF?=
 =?utf-8?B?dWNycDdFdmRhMEV4NUxaWGhJODFKUGd5VlRrQ25tWUFMV3pJMzkrMDJQeE0v?=
 =?utf-8?B?OWg0SHZNZzh6NFAyd3VldjRiTnBORG1xQ1l6RktTaTlCZS94T1dQcGFRYjZO?=
 =?utf-8?B?eEFiQ3ZvTW1VYUF3RkxXS0tCUWpmd0Vvd0tUUXhlZm9SaEJCU1lkeTRrTUZN?=
 =?utf-8?B?VUFaRTZrRmhDRWk2THcvVjFWSGpYbm1kSUR4WVpxdDQxc2dWby9Xb0RGb0NE?=
 =?utf-8?B?am14OFF2ZkpFbWg1Y1hlTTQzYjVLU1paMUdkdXJNaFdRcFhYQXlmNFVHM3FI?=
 =?utf-8?B?QTFqNythbUMxcm10OWM5MGFZaHlvTjdodUd2MFN6M2pKQzBKQ1VEZTZ0anBH?=
 =?utf-8?B?dUVTMWZQWmFRUHlRRUhrSWdBVWVibHdNeXMyU3B2Z0YwZENWU0ZJaHc1M2dp?=
 =?utf-8?B?VDh5V0pOV1FDRXlpZ1pDVjdwOGtVVEw4VUdGQ3d1MStlc3FteXhxaEp2VUtk?=
 =?utf-8?B?cy9hYkxOQ01pREE2UlZob05RL3FZMVhla2dZQzlWZ3hBMWJZQSsvRVk4TTJw?=
 =?utf-8?B?UXZNdXZXVVY5L3FBMnlpWkhrNHJIZzc5cW94c0kwQmdSUEpxOTFyMUhPblVX?=
 =?utf-8?B?azlrR3BvamhMY3FjV1pUdFFNUGZYbVp2K2RzZytQRTlEbUl1SW9QaW1EQmo5?=
 =?utf-8?B?T0dmbDVmMlphbzFTV2NYL1lLcDczUTVPZUFDTk9YcVF4cDl0R2hkcHZTMGZ4?=
 =?utf-8?B?aFlXbFlnOHhMdTdBOWdYVG9BcVRVVHVPZWdPNHBMVi9FWEY3NXJKTVdKN2xs?=
 =?utf-8?B?NisvRC9XZFZIZXpOcUJRNDUvaGhTbmo3TnBWVm5NaHJ0RjM4MjhESTFjd1dD?=
 =?utf-8?B?RCt2bHZBeWRxU25paURkQ0N3a3k2RzFzZUhSbzR0NUZOSVhuTEZYNFlxWUov?=
 =?utf-8?B?OGFScEN0dDNCbzFvMFBiOUhtSTNONFI5cGdsTUc2cUxaWHp0aGM3Nk0zWVIy?=
 =?utf-8?B?ZnRrK2JvZnVHeEVsUUZ3SHBJc0FGeWlPbkgwN0kvN0hIUCtBb3FOd3Y1bkZ4?=
 =?utf-8?B?aVFoTW1UOS9nbGp1YVU3UFpHMG55eVRUenBoQXVJUldvM0RFenhnMGFaQlRj?=
 =?utf-8?B?TGdWazZESEl0MmJETS8vZG1qbzlFeGszcXlsdXlHN0dnSjJSZ252WFNWNDNF?=
 =?utf-8?B?M25zdzdKNjV3RHZ6bTJYSVQ0eG5kVlVZUGMreSs3ZnVGQW1sQjFJZHBYN3Mz?=
 =?utf-8?B?ekdtVU1qRjgxcFBNR0Z6Ni9GS0xjNWNkZ2t1bDBJSFJQaTExemVqbnVsZ1lq?=
 =?utf-8?B?TEsydHc3YjJ4MjBEYUJrVkpFaXZycXVvQUpGeEJtUDdGRnRjbDhEZWcxTkk4?=
 =?utf-8?B?b0xac3VkWkt2dmdNQmtJNE9KZ0p0Rm5aR0tValVwMkZ3K00rRkFXMm54aVFT?=
 =?utf-8?B?bnhpbXoxNXBLbHZ1Q2NtQlRvTGJFbHFIcXo1cFBNWVZOMEYzalBIaWRTQmRp?=
 =?utf-8?B?L25lZmVXbnAzcFoySFpOV3hrT0ZHM0tHaDBZTXpFMHEzeU11TWQ4VUtGYnA0?=
 =?utf-8?B?Z1kyVC84elZnQitmdU1VT1ZjWUVlY1d4OFQ3MTcxS2tOVEQzZ29IOVFHTU9y?=
 =?utf-8?Q?xp02VbOafWLvWrgo=3D?=
X-OriginatorOrg: nutanix.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 2e474b7d-40f2-4161-566f-08de6d3e24f7
X-MS-Exchange-CrossTenant-AuthSource: PH0PR02MB7159.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 16 Feb 2026 09:31:21.0005 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: bb047546-786f-4de1-bd75-24e5b6f79043
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: GZnVKZnpESjBdai4Z8GdaoYlib9KFFbn3Zb/oYRzRN0/IzRsxzb2eemTym8yuX2Ti527fRm6LVQiGD0lNRx75ZKQnuUt4Zm/fecq4jPXVC4=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CO6PR02MB7761
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwMjE2MDA3OSBTYWx0ZWRfXw1SWrCL9Cws/
 PO6qAj2V9OISx3EVFJmwhYRyKMJ3i9s700h/1+Aa6Z8Z6zEr7ePZZgde/LLiNMNfVYM5ruBlwKz
 uVH+GiP+6cSW8D+4GuEVI2oWHZnM9lWK4iXFOlUM02FMjDpXq6fAWtwnK2SSZbDQPXegUxtgH2M
 FyosnUB86nUupTdSnypLZ3QNU+ejUvmmNNikPw5ZEc7loeihEIZIjkKXR+7TORjIfpKgQCSzBUZ
 AEmF5hw0LjxkjnVs0D2xjThhFnZ2f+kYlZGQpfypAxwE/swhQo0BbD10fL0gSY8yjD3TQqDnFGp
 BO5zrG+xqFZdv+mXSl53XaGjJpzNwSW2jOKNuYtWV63iDUf1sk4Fdhkfyd3gUFN6n0p+23hClgh
 lnvm/HP6y4K5LCEJdBZha1az9Vqj95E1tAylOfYKqRn9Jsn1N3nFSKc4q2zsqdHZDw7NfGgsO5Y
 /o2bViBuB9ck0Agi06Q==
X-Authority-Analysis: v=2.4 cv=OP0qHCaB c=1 sm=1 tr=0 ts=6992e3eb cx=c_pps
 a=82Hej2R/WPb/df+cPJtM0A==:117 a=6eWqkTHjU83fiwn7nKZWdM+Sl24=:19
 a=z/mQ4Ysz8XfWz/Q5cLBRGdckG28=:19 a=lCpzRmAYbLLaTzLvsPZ7Mbvzbb8=:19
 a=xqWC_Br6kY4A:10 a=IkcTkHD0fZMA:10 a=HzLeVaNsDn8A:10 a=0kUYKlekyDsA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=Mpw57Om8IfrbqaoTuvik:22 a=GgsMoib0sEa3-_RKJdDe:22
 a=64Cc0HZtAAAA:8 a=20KFwNOVAAAA:8 a=QrdharD8P5BrLf_qZwAA:9 a=3ZKOabzyN94A:10
 a=QEXdDO2ut3YA:10
X-Proofpoint-GUID: QBBrWdCJfaVpcp1eA2rVhpp8yXUUtw8k
X-Proofpoint-ORIG-GUID: QBBrWdCJfaVpcp1eA2rVhpp8yXUUtw8k
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1121,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-02-16_03,2026-02-16_01,2025-10-01_01
X-Proofpoint-Spam-Reason: safe
Received-SPF: pass client-ip=148.163.151.68;
 envelope-from=mark.caveayland@nutanix.com; helo=mx0a-002c1b01.pphosted.com
X-Spam_score_int: -27
X-Spam_score: -2.8
X-Spam_bar: --
X-Spam_report: (-2.8 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_LOW=-0.7, RCVD_IN_MSPIKE_H2=0.001,
 RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001, RCVD_IN_VALIDITY_SAFE_BLOCKED=0.001,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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

On 14/02/2026 08:20, Marc-André Lureau wrote:

> Hi
> 
> On Fri, Feb 13, 2026 at 4:28 PM Mark Cave-Ayland
> <mark.caveayland@nutanix.com> wrote:
>>
>> On 27/01/2026 18:24, marcandre.lureau@redhat.com wrote:
>>
>>> From: Marc-André Lureau <marcandre.lureau@redhat.com>
>>>
>>> The audio_pcm_info structure stored three fields (bits, is_signed,
>>> is_float) that were always derived from the AudioFormat enum. This
>>> redundancy meant the same information was represented twice, with no
>>> type-level guarantee that they stayed in sync.
>>>
>>> Replace these fields with a single AudioFormat field, and add helper
>>> functions to extract the derived properties when needed:
>>> - audio_format_bits()
>>> - audio_format_is_signed()
>>> - audio_format_is_float()
>>>
>>> This improves type safety by making AudioFormat the single source of
>>> truth, eliminating the possibility of inconsistent state between the
>>> format enum and its derived boolean/integer representations.
>>>
>>> Signed-off-by: Marc-André Lureau <marcandre.lureau@redhat.com>
>>> ---
>>>    audio/audio_int.h       |   4 +-
>>>    audio/audio_template.h  |  12 +--
>>>    include/qemu/audio.h    |  49 +++++++++
>>>    audio/audio-mixeng-be.c | 218 ++++++++++++----------------------------
>>>    audio/dbusaudio.c       |  12 +--
>>>    audio/coreaudio.m       |   2 +-
>>>    6 files changed, 126 insertions(+), 171 deletions(-)
>>>
>>> diff --git a/audio/audio_int.h b/audio/audio_int.h
>>> index 5334c4baad2..dd5f2220d75 100644
>>> --- a/audio/audio_int.h
>>> +++ b/audio/audio_int.h
>>> @@ -45,9 +45,7 @@ struct audio_callback {
>>>    };
>>>
>>>    struct audio_pcm_info {
>>> -    int bits;
>>> -    bool is_signed;
>>> -    bool is_float;
>>> +    AudioFormat af;
>>>        int freq;
>>>        int nchannels;
>>>        int bytes_per_frame;
>>> diff --git a/audio/audio_template.h b/audio/audio_template.h
>>> index 08d60422589..3da91a4782c 100644
>>> --- a/audio/audio_template.h
>>> +++ b/audio/audio_template.h
>>> @@ -173,7 +173,7 @@ static int glue (audio_pcm_sw_init_, TYPE) (
>>>        sw->empty = true;
>>>    #endif
>>>
>>> -    if (sw->info.is_float) {
>>> +    if (audio_format_is_float(hw->info.af)) {
>>>    #ifdef DAC
>>>            sw->conv = mixeng_conv_float[sw->info.nchannels == 2]
>>>                [sw->info.swap_endianness];
>>> @@ -188,9 +188,9 @@ static int glue (audio_pcm_sw_init_, TYPE) (
>>>            sw->clip = mixeng_clip
>>>    #endif
>>>                [sw->info.nchannels == 2]
>>> -            [sw->info.is_signed]
>>> +            [audio_format_is_signed(hw->info.af)]
>>>                [sw->info.swap_endianness]
>>> -            [audio_bits_to_index(sw->info.bits)];
>>> +            [audio_format_to_index(hw->info.af)];
>>>        }
>>>
>>>        sw->name = g_strdup (name);
>>> @@ -300,7 +300,7 @@ static HW *glue(audio_pcm_hw_add_new_, TYPE)(AudioMixengBackend *s,
>>>            goto err1;
>>>        }
>>>
>>> -    if (hw->info.is_float) {
>>> +    if (audio_format_is_float(hw->info.af)) {
>>>    #ifdef DAC
>>>            hw->clip = mixeng_clip_float[hw->info.nchannels == 2]
>>>                [hw->info.swap_endianness];
>>> @@ -315,9 +315,9 @@ static HW *glue(audio_pcm_hw_add_new_, TYPE)(AudioMixengBackend *s,
>>>            hw->conv = mixeng_conv
>>>    #endif
>>>                [hw->info.nchannels == 2]
>>> -            [hw->info.is_signed]
>>> +            [audio_format_is_signed(hw->info.af)]
>>>                [hw->info.swap_endianness]
>>> -            [audio_bits_to_index(hw->info.bits)];
>>> +            [audio_format_to_index(hw->info.af)];
>>>        }
>>>
>>>        glue(audio_pcm_hw_alloc_resources_, TYPE)(hw);
>>> diff --git a/include/qemu/audio.h b/include/qemu/audio.h
>>> index b6b6ee9b560..a2fbc286eb1 100644
>>> --- a/include/qemu/audio.h
>>> +++ b/include/qemu/audio.h
>>> @@ -185,6 +185,55 @@ bool audio_be_set_dbus_server(AudioBackend *be,
>>>
>>>    const char *audio_application_name(void);
>>>
>>> +static inline int audio_format_bits(AudioFormat fmt)
>>
>> Does the inline make a difference here? My understanding is that the
>> compiler treats this as a weak hint these days, and generally does the
>> right thing by itself.
> 
> If you drop "inline" you get -Werror=unused-function.

Ah I guess because this is a header file? Yeah that does make it 
trickier, I guess let's keep the compiler happy then.

>>
>>> +{
>>> +    switch (fmt) {
>>> +    case AUDIO_FORMAT_S8:
>>> +    case AUDIO_FORMAT_U8:
>>> +        return 8;
>>> +
>>> +    case AUDIO_FORMAT_S16:
>>> +    case AUDIO_FORMAT_U16:
>>> +        return 16;
>>> +
>>> +    case AUDIO_FORMAT_F32:
>>> +    case AUDIO_FORMAT_S32:
>>> +    case AUDIO_FORMAT_U32:
>>> +        return 32;
>>> +
>>> +    case AUDIO_FORMAT__MAX:
>>> +     break;
>>> +    }
>>
>> I'm not sure that AUDIO_FORMAT__MAX is a valid choice here - can you
>> drop the explicit case for AUDIO_FORMAT__MAX and then simply have a
>> default that calls g_assert_not_reached() instead?
> 
> We need to handle all variants, because -Werror=switch. That

Does that also include the use of default? I was thinking something 
along the lines of this to help make things clearer:

static inline int audio_format_bits(AudioFormat fmt)
{
     switch (fmt) {
     case AUDIO_FORMAT_S8:
     case AUDIO_FORMAT_U8:
         return 8;

     case AUDIO_FORMAT_S16:
     case AUDIO_FORMAT_U16:
         return 16;

     case AUDIO_FORMAT_F32:
     case AUDIO_FORMAT_S32:
     case AUDIO_FORMAT_U32:
         return 32;

     default:
         break;
     }

     g_assert_not_reached();
}

>>> +    g_assert_not_reached();
>>> +}
>>> +
>>> +static inline bool audio_format_is_float(AudioFormat fmt)
>>
>> Same comment here re: inline.
>>
>>> +{
>>> +    return fmt == AUDIO_FORMAT_F32;
>>> +}
>>> +
>>> +static inline bool audio_format_is_signed(AudioFormat fmt)
>>
>> And here.
>>
>>> +{
>>> +    switch (fmt) {
>>> +    case AUDIO_FORMAT_S8:
>>> +    case AUDIO_FORMAT_S16:
>>> +    case AUDIO_FORMAT_S32:
>>> +    case AUDIO_FORMAT_F32:
>>> +        return true;
>>> +
>>> +    case AUDIO_FORMAT_U8:
>>> +    case AUDIO_FORMAT_U16:
>>> +    case AUDIO_FORMAT_U32:
>>> +        return false;
>>> +
>>> +    case AUDIO_FORMAT__MAX:
>>
>> Same comment here re: AUDIO_FORMAT__MAX.
>>
>>> +     break;
>>> +    }
>>> +
>>> +    g_assert_not_reached();
>>> +}
>>> +
>>>    #define DEFINE_AUDIO_PROPERTIES(_s, _f)         \
>>>        DEFINE_PROP_AUDIODEV("audiodev", _s, _f)
>>>
>>> diff --git a/audio/audio-mixeng-be.c b/audio/audio-mixeng-be.c
>>> index a0e542754e5..146026d0b39 100644
>>> --- a/audio/audio-mixeng-be.c
>>> +++ b/audio/audio-mixeng-be.c
>>> @@ -62,23 +62,28 @@ int audio_bug (const char *funcname, int cond)
>>>        return cond;
>>>    }
>>>
>>> -static inline int audio_bits_to_index (int bits)
>>> +/*
>>> + * Convert audio format to mixeng_clip index. Used by audio_pcm_sw_init_ and
>>> + * audio_mixeng_backend_add_capture()
>>> + */
>>> +static int audio_format_to_index(AudioFormat af)
>>>    {
>>> -    switch (bits) {
>>> -    case 8:
>>> +    switch (af) {
>>> +    case AUDIO_FORMAT_U8:
>>> +    case AUDIO_FORMAT_S8:
>>>            return 0;
>>> -
>>> -    case 16:
>>> +    case AUDIO_FORMAT_U16:
>>> +    case AUDIO_FORMAT_S16:
>>>            return 1;
>>> -
>>> -    case 32:
>>> +    case AUDIO_FORMAT_U32:
>>> +    case AUDIO_FORMAT_S32:
>>>            return 2;
>>> -
>>> -    default:
>>> -        audio_bug ("bits_to_index", 1);
>>> -        AUD_log (NULL, "invalid bits %d\n", bits);
>>> -        return 0;
>>> +    case AUDIO_FORMAT_F32:
>>> +    case AUDIO_FORMAT__MAX:
>>
>> Same comment re: AUDIO_FORMAT__MAX.
>>
>>> +        break;
>>>        }
>>> +
>>> +    g_assert_not_reached();
>>>    }
>>>
>>>    void AUD_vlog (const char *cap, const char *fmt, va_list ap)
>>> @@ -172,141 +177,68 @@ static int audio_validate_settings (const struct audsettings *as)
>>>
>>>    static int audio_pcm_info_eq (struct audio_pcm_info *info, const struct audsettings *as)
>>>    {
>>> -    int bits = 8;
>>> -    bool is_signed = false, is_float = false;
>>> -
>>> -    switch (as->fmt) {
>>> -    case AUDIO_FORMAT_S8:
>>> -        is_signed = true;
>>> -        /* fall through */
>>> -    case AUDIO_FORMAT_U8:
>>> -        break;
>>> -
>>> -    case AUDIO_FORMAT_S16:
>>> -        is_signed = true;
>>> -        /* fall through */
>>> -    case AUDIO_FORMAT_U16:
>>> -        bits = 16;
>>> -        break;
>>> -
>>> -    case AUDIO_FORMAT_F32:
>>> -        is_float = true;
>>> -        /* fall through */
>>> -    case AUDIO_FORMAT_S32:
>>> -        is_signed = true;
>>> -        /* fall through */
>>> -    case AUDIO_FORMAT_U32:
>>> -        bits = 32;
>>> -        break;
>>> -
>>> -    default:
>>> -        abort();
>>> -    }
>>> -    return info->freq == as->freq
>>> +    return info->af == as->fmt
>>> +        && info->freq == as->freq
>>>            && info->nchannels == as->nchannels
>>> -        && info->is_signed == is_signed
>>> -        && info->is_float == is_float
>>> -        && info->bits == bits
>>>            && info->swap_endianness == (as->endianness != HOST_BIG_ENDIAN);
>>>    }
>>>
>>>    void audio_pcm_init_info (struct audio_pcm_info *info, const struct audsettings *as)
>>>    {
>>> -    int bits = 8, mul;
>>> -    bool is_signed = false, is_float = false;
>>> -
>>> -    switch (as->fmt) {
>>> -    case AUDIO_FORMAT_S8:
>>> -        is_signed = true;
>>> -        /* fall through */
>>> -    case AUDIO_FORMAT_U8:
>>> -        mul = 1;
>>> -        break;
>>> -
>>> -    case AUDIO_FORMAT_S16:
>>> -        is_signed = true;
>>> -        /* fall through */
>>> -    case AUDIO_FORMAT_U16:
>>> -        bits = 16;
>>> -        mul = 2;
>>> -        break;
>>> -
>>> -    case AUDIO_FORMAT_F32:
>>> -        is_float = true;
>>> -        /* fall through */
>>> -    case AUDIO_FORMAT_S32:
>>> -        is_signed = true;
>>> -        /* fall through */
>>> -    case AUDIO_FORMAT_U32:
>>> -        bits = 32;
>>> -        mul = 4;
>>> -        break;
>>> -
>>> -    default:
>>> -        abort();
>>> -    }
>>> -
>>> +    info->af = as->fmt;
>>>        info->freq = as->freq;
>>> -    info->bits = bits;
>>> -    info->is_signed = is_signed;
>>> -    info->is_float = is_float;
>>>        info->nchannels = as->nchannels;
>>> -    info->bytes_per_frame = as->nchannels * mul;
>>> +    info->bytes_per_frame = as->nchannels * audio_format_bits(as->fmt) / 8;
>>>        info->bytes_per_second = info->freq * info->bytes_per_frame;
>>>        info->swap_endianness = (as->endianness != HOST_BIG_ENDIAN);
>>>    }
>>>
>>> -void audio_pcm_info_clear_buf (struct audio_pcm_info *info, void *buf, int len)
>>> +void audio_pcm_info_clear_buf(struct audio_pcm_info *info, void *buf, int len)
>>>    {
>>>        if (!len) {
>>>            return;
>>>        }
>>>
>>> -    if (info->is_signed || info->is_float) {
>>> -        memset(buf, 0x00, len * info->bytes_per_frame);
>>> -    } else {
>>> -        switch (info->bits) {
>>> -        case 8:
>>> -            memset(buf, 0x80, len * info->bytes_per_frame);
>>> -            break;
>>> -
>>> -        case 16:
>>> -            {
>>> -                int i;
>>> -                uint16_t *p = buf;
>>> -                short s = INT16_MAX;
>>> -
>>> -                if (info->swap_endianness) {
>>> -                    s = bswap16 (s);
>>> -                }
>>> -
>>> -                for (i = 0; i < len * info->nchannels; i++) {
>>> -                    p[i] = s;
>>> -                }
>>> -            }
>>> -            break;
>>> +    switch (info->af) {
>>> +    case AUDIO_FORMAT_U8:
>>> +        memset(buf, 0x80, len * info->bytes_per_frame);
>>
>> This doesn't look right - isn't this the signed version?
> 
> No,
> 
>>
>>> +        break;
>>> +    case AUDIO_FORMAT_U16: {
>>> +        int i;
>>> +        uint16_t *p = buf;
>>> +        short s = INT16_MAX;
>>>
>>> -        case 32:
>>> -            {
>>> -                int i;
>>> -                uint32_t *p = buf;
>>> -                int32_t s = INT32_MAX;
>>> +        if (info->swap_endianness) {
>>> +            s = bswap16(s);
>>> +        }
>>>
>>> -                if (info->swap_endianness) {
>>> -                    s = bswap32 (s);
>>> -                }
>>> +        for (i = 0; i < len * info->nchannels; i++) {
>>> +            p[i] = s;
>>> +        }
>>
>> I think this is signed too?
>>
>>> +        break;
>>> +    }
>>> +    case AUDIO_FORMAT_U32: {
>>> +        int i;
>>> +        uint32_t *p = buf;
>>> +        int32_t s = INT32_MAX;
>>>
>>> -                for (i = 0; i < len * info->nchannels; i++) {
>>> -                    p[i] = s;
>>> -                }
>>> -            }
>>> -            break;
>>> +        if (info->swap_endianness) {
>>> +            s = bswap32(s);
>>> +        }
>>>
>>> -        default:
>>> -            AUD_log (NULL, "audio_pcm_info_clear_buf: invalid bits %d\n",
>>> -                     info->bits);
>>> -            break;
>>> +        for (i = 0; i < len * info->nchannels; i++) {
>>> +            p[i] = s;
>>>            }
>>
>> And also here.
>>
>>> +        break;
>>> +    }
>>> +    case AUDIO_FORMAT_S8:
>>> +    case AUDIO_FORMAT_S16:
>>> +    case AUDIO_FORMAT_S32:
>>> +    case AUDIO_FORMAT_F32:
>>> +        memset(buf, 0x00, len * info->bytes_per_frame);
>>
>> ... and this the unsigned version? I think they've been swapped.
> 
> no, unsigned PCM use mid-range value for zero.

Sigh. Yes of course you're right, sorry for the noise.

>>> +        break;
>>> +    case AUDIO_FORMAT__MAX:
>>> +        g_assert_not_reached();
>>
>> This looks more like I would expect, although possibly replace the case
>> with a default? I expect that another assert() would have tripped by now
>> with real usage if AUDIO_FORMAT__MAX were specified, but I think it
>> would be good to be consistent.
> 
> Unfortunately, the compiler complains for non-void functions if you
> don't finish the function with the g_assert_not_reached().
> 
>>
>>>        }
>>>    }
>>>
>>> @@ -719,8 +651,8 @@ static size_t audio_pcm_sw_write(SWVoiceOut *sw, void *buf, size_t buf_len)
>>>    #ifdef DEBUG_AUDIO
>>>    static void audio_pcm_print_info (const char *cap, struct audio_pcm_info *info)
>>>    {
>>> -    dolog("%s: bits %d, sign %d, float %d, freq %d, nchan %d\n",
>>> -          cap, info->bits, info->is_signed, info->is_float, info->freq,
>>> +    dolog("%s: %s, freq %d, nchan %d\n",
>>> +          cap, AudioFormat_str(info->af), info->freq,
>>>              info->nchannels);
>>
>> More dolog. Presumably this gets converted to error_report() later?
>>
>>>    }
>>>    #endif
>>> @@ -1759,15 +1691,15 @@ static CaptureVoiceOut *audio_mixeng_backend_add_capture(
>>>
>>>            cap->buf = g_malloc0_n(hw->mix_buf.size, hw->info.bytes_per_frame);
>>>
>>> -        if (hw->info.is_float) {
>>> +        if (audio_format_is_float(hw->info.af)) {
>>>                hw->clip = mixeng_clip_float[hw->info.nchannels == 2]
>>>                    [hw->info.swap_endianness];
>>>            } else {
>>>                hw->clip = mixeng_clip
>>>                    [hw->info.nchannels == 2]
>>> -                [hw->info.is_signed]
>>> +                [audio_format_is_signed(hw->info.af)]
>>>                    [hw->info.swap_endianness]
>>> -                [audio_bits_to_index(hw->info.bits)];
>>> +                [audio_format_to_index(hw->info.af)];
>>>            }
>>>
>>>            QLIST_INSERT_HEAD (&s->cap_head, cap, entries);
>>> @@ -1869,29 +1801,6 @@ audsettings audiodev_to_audsettings(AudiodevPerDirectionOptions *pdo)
>>>        };
>>>    }
>>>
>>> -int audioformat_bytes_per_sample(AudioFormat fmt)
>>> -{
>>> -    switch (fmt) {
>>> -    case AUDIO_FORMAT_U8:
>>> -    case AUDIO_FORMAT_S8:
>>> -        return 1;
>>> -
>>> -    case AUDIO_FORMAT_U16:
>>> -    case AUDIO_FORMAT_S16:
>>> -        return 2;
>>> -
>>> -    case AUDIO_FORMAT_U32:
>>> -    case AUDIO_FORMAT_S32:
>>> -    case AUDIO_FORMAT_F32:
>>> -        return 4;
>>> -
>>> -    case AUDIO_FORMAT__MAX:
>>> -        ;
>>> -    }
>>> -    abort();
>>> -}
>>> -
>>> -
>>>    /* frames = freq * usec / 1e6 */
>>>    int audio_buffer_frames(AudiodevPerDirectionOptions *pdo,
>>>                            audsettings *as, int def_usecs)
>>> @@ -1914,8 +1823,7 @@ int audio_buffer_samples(AudiodevPerDirectionOptions *pdo,
>>>    int audio_buffer_bytes(AudiodevPerDirectionOptions *pdo,
>>>                           audsettings *as, int def_usecs)
>>>    {
>>> -    return audio_buffer_samples(pdo, as, def_usecs) *
>>> -        audioformat_bytes_per_sample(as->fmt);
>>> +    return audio_buffer_samples(pdo, as, def_usecs) * audio_format_bits(as->fmt) / 8;
>>>    }
>>>
>>>    void audio_rate_start(RateCtl *rate)
>>> diff --git a/audio/dbusaudio.c b/audio/dbusaudio.c
>>> index e284542b2dd..72d6194033b 100644
>>> --- a/audio/dbusaudio.c
>>> +++ b/audio/dbusaudio.c
>>> @@ -147,9 +147,9 @@ dbus_init_out_listener(QemuDBusDisplay1AudioOutListener *listener,
>>>        qemu_dbus_display1_audio_out_listener_call_init(
>>>            listener,
>>>            (uintptr_t)hw,
>>> -        hw->info.bits,
>>> -        hw->info.is_signed,
>>> -        hw->info.is_float,
>>> +        audio_format_bits(hw->info.af),
>>> +        audio_format_is_signed(hw->info.af),
>>> +        audio_format_is_float(hw->info.af),
>>>            hw->info.freq,
>>>            hw->info.nchannels,
>>>            hw->info.bytes_per_frame,
>>> @@ -273,9 +273,9 @@ dbus_init_in_listener(QemuDBusDisplay1AudioInListener *listener, HWVoiceIn *hw)
>>>        qemu_dbus_display1_audio_in_listener_call_init(
>>>            listener,
>>>            (uintptr_t)hw,
>>> -        hw->info.bits,
>>> -        hw->info.is_signed,
>>> -        hw->info.is_float,
>>> +        audio_format_bits(hw->info.af),
>>> +        audio_format_is_signed(hw->info.af),
>>> +        audio_format_is_float(hw->info.af),
>>>            hw->info.freq,
>>>            hw->info.nchannels,
>>>            hw->info.bytes_per_frame,
>>> diff --git a/audio/coreaudio.m b/audio/coreaudio.m
>>> index 40d7986b1d7..08bab353831 100644
>>> --- a/audio/coreaudio.m
>>> +++ b/audio/coreaudio.m
>>> @@ -359,7 +359,7 @@ static OSStatus init_out_device(coreaudioVoiceOut *core)
>>>        AudioValueRange frameRange;
>>>
>>>        AudioStreamBasicDescription streamBasicDescription = {
>>> -        .mBitsPerChannel = core->hw.info.bits,
>>> +        .mBitsPerChannel = audio_format_bits(core->hw.info.af),
>>>            .mBytesPerFrame = core->hw.info.bytes_per_frame,
>>>            .mBytesPerPacket = core->hw.info.bytes_per_frame,
>>>            .mChannelsPerFrame = core->hw.info.nchannels,

Having said that, given that the unsigned/signed bit is actually 
correct, then regardless of the final form of the switch() statements 
then this seems okay:

Reviewed-by: Mark Cave-Ayland <mark.caveayland@nutanix.com>


ATB,

Mark.


