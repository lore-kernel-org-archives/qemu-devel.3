Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2D35CC61DC2
	for <qemu-devel@archiver.kernel.org>; Tue, 25 Aug 2026 13:46:32 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wyrRZ-0003hR-P7; Tue, 25 Aug 2026 09:44:01 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mark.caveayland@nutanix.com>)
 id 1wyrRN-0003ea-Ta; Tue, 25 Aug 2026 09:43:51 -0400
Received: from mx0a-002c1b01.pphosted.com ([148.163.151.68])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mark.caveayland@nutanix.com>)
 id 1wyrRL-0002SE-OD; Tue, 25 Aug 2026 09:43:49 -0400
Received: from pps.filterd (m0127837.ppops.net [127.0.0.1])
 by mx0a-002c1b01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 67PB0oYC1800348; Tue, 25 Aug 2026 06:43:29 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nutanix.com; h=
 content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=
 proofpoint20171006; bh=VRpFkuWClhMHjNR1huhUtW/g++ivWLmyOQoARjY1Y
 To=; b=1qL9hk3FmxGBB8ELbcwHkemu7lF4bflzZTOssnsC7tQ85VJQSbCMBqfzG
 b3XAI9yrVxGdefZ2krjTsHRnph0L5YQ4Enl1JupVUVMFcjbNmwaCdiw4Xy5/fdMF
 Sjl9+/g6KDMvUvMJAEsRrgWjUlXzCbElpfMWVtbLij7zWxNKJqZSI6yWcSGmnwVH
 0zD/9TQSAz8o8Z5nNr8WxJycaII6N3DNh88/LZVmV6G5y/7cau8iLB1DRJdC+NB5
 6N+e/IypkILKIPZX9Q26hVxn0XhlR2ZWwbRbndz1LJknsxqYe9N99lc3XJz2pQmE
 fDOVz78EM93/33s2UkLPq9GaWjRhg==
Received: from dm5pr21cu001.outbound.protection.outlook.com
 (mail-centralusazon11021074.outbound.protection.outlook.com [52.101.62.74])
 by mx0a-002c1b01.pphosted.com (PPS) with ESMTPS id 4g8sy9afe9-1
 (version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NOT);
 Tue, 25 Aug 2026 06:43:29 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=ujQ/ACSL1iOgX+zPYb/38HB+1tjehQ92yvdhMRzvbmDMLLgDPqNzDEUs6LDApWbLAXU+FXM4wHeS1IVJsPchMU2qp5ZN4/0s7zJ7qgcPU6Aeb1g76eOnElZEXDz5AFHwZzg60KMzWjepsn1ypiClJpGXKVikD1IGG/y7IN8XqSnQ0nxTvZl/IX0Zpar2cKuUyz1NrS+53caB7UOIySgEGXcWV8StfBxYGLI6suPoVp92InEPGsH+G4NRXX9tcZVc5acmcEyD8o7KMVO1er2zCxlIL+sz1ew4Sp5HonRbsxqJS/eLQiUBOGuhQcHDO4GuzVBbyATWuqyM2N7sJusXDw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=VRpFkuWClhMHjNR1huhUtW/g++ivWLmyOQoARjY1YTo=;
 b=vvUHTFHRrqiPQf3gUJrnFlK6TgkggHj8WxIV+GiXhJjAdg49GMNpdED0VcyYi3lSnO4e2SdEypDs6aiQ9Y5cil+semEBiVB1WLrhT+bCoA0MyWh7fMOVOz09AiGPYxsRosAvxk6R79AKut7POcoWY2JEeyak1kCzinCCfhSWnmEIn1TMIikmlCF63AUtLb9eEpnidZ7JjR1bDVtgFkElEaWvG+UNIsaT71+FmdUUtSuoycTAla/FrtDieLNkDNjPUCdkGjzJ64dcPiweQB8ut2H7RjTzzEP8QErWtp+kvZLB9nMM82/PfzkwczmLCBN0yRn4NwSBomTzFJ7tHgwtow==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nutanix.com; dmarc=pass action=none header.from=nutanix.com;
 dkim=pass header.d=nutanix.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nutanix.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=VRpFkuWClhMHjNR1huhUtW/g++ivWLmyOQoARjY1YTo=;
 b=YN1vbcNIpJtkfWXwTaGCOvFOtKoD1mXLNezcQQCUNf7KSh/VPVTN45kjrsB5rd3mn/+niJZyOznxQsWYIVd9s8qjZ3RCA3COLVxS9Ou1Utn/ELngpA51/xe9lNrhPdLKpMnjV8pPZJv44dLcQG9yUN5hI9IGr1FETQWPxz0o93f/7697plW3/sqX9ZqPebWfPDevBBBK9qkuG5Sd1F6iDP4qfiO78z7Hq+v7JOIWuG8+6MMhqVvlAngABvtbUW2wPv0SVSNnn37sa+oruap0I/Nr5DzXWYYM793nJx8FcdEwMBGNEr/arbmCcTbGoTUyoRy+sntuaIhEizQuvQ2/Bw==
Received: from PH0PR02MB7159.namprd02.prod.outlook.com (2603:10b6:510:16::8)
 by CO6PR02MB7681.namprd02.prod.outlook.com (2603:10b6:303:a4::15) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.360.7; Tue, 25 Aug
 2026 13:43:26 +0000
Received: from PH0PR02MB7159.namprd02.prod.outlook.com
 ([fe80::8e97:bc32:822c:b250]) by PH0PR02MB7159.namprd02.prod.outlook.com
 ([fe80::8e97:bc32:822c:b250%3]) with mapi id 15.21.0360.005; Tue, 25 Aug 2026
 13:43:26 +0000
From: Mark Cave-Ayland <mark.caveayland@nutanix.com>
To: mst@redhat.com, imammedo@redhat.com, anisinha@redhat.com, philmd@mailo.com,
 aurelien@aurel32.net, peter.maydell@linaro.org,
 richard.henderson@linaro.org, berrange@redhat.com,
 marcandre.lureau@redhat.com, qemu-devel@nongnu.org, qemu-arm@nongnu.org
Subject: [PATCH v5 01/16] qom/object.c: introduce
 OBJECT_CLASS_PROPERTY_SCALAR_GETTER(type) macro
Date: Tue, 25 Aug 2026 14:41:22 +0100
Message-ID: <20260825134320.1039012-2-mark.caveayland@nutanix.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260825134320.1039012-1-mark.caveayland@nutanix.com>
References: <20260825134320.1039012-1-mark.caveayland@nutanix.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: SA1PR04CA0020.namprd04.prod.outlook.com
 (2603:10b6:806:2ce::29) To PH0PR02MB7159.namprd02.prod.outlook.com
 (2603:10b6:510:16::8)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH0PR02MB7159:EE_|CO6PR02MB7681:EE_
X-MS-Office365-Filtering-Correlation-Id: 4891250f-26d3-46f4-9f01-08df02aed6e0
x-proofpoint-crosstenant: true
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|1800799024|366016|7416014|376014|23010399003|921020|18002099003|22082099003|10067099003|56012099006;
X-Microsoft-Antispam-Message-Info: d8ziclS1eckHzm2guEWM1251+t/xZ0bZD23t2Hegtt/wUs1j3f6/EsftbiTKnNH+DlCy8M7MEVJFch23DT0N+LHXTOtrKZuODk8kjaGRW2k78evAuAFXOi6zDy96mmnNKP25t6vVbybGtZNTWiYsmeATBIP8r2PXIaTWjoZ9T9krfh9Ad6R7qgDVbhm6XM1Ipn/O8hERJe9kMxMLDpwRKKo/MmYUWi0/cN0dil621XUJswyXhH2f8oQ9PwDWfftzBvgV/WCN0HcSOT9xKn4ISsGebHQuFHEJeQRonoyaNoN5ztNaVYzCKd80Wd4E5d12qBgzXF+h//4Uh0XvI6wbWAL80Sj956bSxAoWsiU6UemL+NtEDD1daG8SWqBQYnw1wLExuVZ6BZ7rRTTBSgjDjHN2XMOFxxjBjkJH6/mnZ12eE9AbIDP53ikzTFakiWsjQ3OwHJ7E3j0yv4WEYH4xK46l5SJlctv002LPKRNqD6iDHefrhhBd7p3TCllM/M1N5VytM0jOHIo/11gadMbQlYZ8ecfmyBzbgd7gwFf2dZEiomhk9Ji07wML1b3wRgvokDKrYkmYPDdl0vq/NjumlqDkqgVKBECPwo7Dszf9eynxfXijjrW2/9W7EFpIEwVxB1QxKJk/W2SBMni5/ePoMN1CBAmcI305r2RtsOdSTREBRTGYSTWACTLnhbcPAj6z2DzRn0Nzc8feek1zLZxIZA==
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:PH0PR02MB7159.namprd02.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(1800799024)(366016)(7416014)(376014)(23010399003)(921020)(18002099003)(22082099003)(10067099003)(56012099006);
 DIR:OUT; SFP:1102; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?T09IWGx4STFQcjRaanNXWHdwcVAwaE5JREdJY2N4R1lpeDdMUHFveFhqSWxS?=
 =?utf-8?B?U21tNmkySURnUEhGWXpiemhBQjVHaVd2MkcyRDZ3WStyQ29mT2t6bnVSZEUy?=
 =?utf-8?B?aEJOWkZudjBCZ3RYUXlUS0RhMmpIc2hGUDdZM1Fmc1hpWHFMSVg1TStqeUxB?=
 =?utf-8?B?b2RkcllCbkd4VVdVOU9FMllWTWVpK2kvc1psU1I4Z243MXZwMHRTaDdNNEFu?=
 =?utf-8?B?VFZoYUZVaTE5d3VpUmNiNmpxbkY3MlJsNHV0RjlXOHVlbVcza2dHR0M2SSs5?=
 =?utf-8?B?ZkJYSnk4RFUrTHp2MjQxcmNLOGg5NU1URW4ydDhITGtZT0JCMGh3bFVqN1Nu?=
 =?utf-8?B?RWZTMTNyamxuYVhYSmZnaTRaekE1RENhaFowSWNxR2dTcnVYcXBhcFlvZmZl?=
 =?utf-8?B?MXhMNmVTaTZqa1diSmllVkRxYU9XK2VFeHhJRDdKMlJPRkpYbSt3b0xRd0lM?=
 =?utf-8?B?VThCZUs2c0pDdDIxWUM0cGF5c0hsbkdGQWJQd0N5Vzh5b2VUVnU2MTFqL3E1?=
 =?utf-8?B?WmJxU3NFR1ErRWRmQzIxbTZsOENqalNyM1JEM1ljZWpaVnAyQmhNSU1xR3BG?=
 =?utf-8?B?cVl6Nk1NdDFrQ0IvYk5ENlpFYXk3UnhqNDYxaGhza3dwWlBBWUZTdlp0NVdU?=
 =?utf-8?B?aWZQM0lIZTVYaW1Talo5MndkbzA2UTUyV1M3WWk5MU5SNk9uampaRkc3MFQ0?=
 =?utf-8?B?YktIelpZMUN6dFdiQ0JRVE9hbU01K1UrTjIrV01wN3BDNkQzZ2QwN1M5dVNE?=
 =?utf-8?B?UnRmOU92Y0hiTGpqaVFoZyttUmU1ZnBjZ293YmNPeTEzT25VdTM5Y2FyN1Zm?=
 =?utf-8?B?Smp2N0U1TkprVmU1d3BKZjVpdTlNNXVMVlJ4V1o0b2k1Vk9LblR0QkROWFRo?=
 =?utf-8?B?VXdydjZhKy9Yai9ENEZYMlpVYzZnZllidXV0UXcydTJsb2VhN1J0bUx0YjV5?=
 =?utf-8?B?TnpIQ0FaUmZoNUN2dkM3aHA3WDNwcCtBWk4xNDZuTGF1TXZjK1RXUEVyOHM2?=
 =?utf-8?B?b3BtUlUwODFLUkdwdnVhbzVUQUVlUmsyc3RLTzJXN1VkTWYyNWxkUVBWbTIr?=
 =?utf-8?B?TGhIRU9mV2c5YXgrbHJIK2JUWHNmL0NiR3NMc3pUeDJraENYYnVoODFUV05M?=
 =?utf-8?B?OGdhRHNtam5VNlE0SldUaUZNSDhWUW9hUlJZakpqN2F2aUpTeTVjUWtWc1Vl?=
 =?utf-8?B?cEVQN2pWNjFqN0dTcHZFVTNQd1ErN29oQkVTZldPbTVnRU1WNHRncWtXREQx?=
 =?utf-8?B?ZHBPeDFVd25IU3RNVTAyVzVTb3pSUGFya3gvUk9iS1dwd2dsSENESzRzTGxp?=
 =?utf-8?B?WXNybmt5eXIyR2N4cXEwdC9mQjV6MXhzUGJYbmhhS0pLd3JXdm5JWjBhdVlJ?=
 =?utf-8?B?WGFsYkt3QTgyRytiWTBRd1M5RXJzbXJmYjJiTVlWc3A2RU5GMU1qeHBpWlkx?=
 =?utf-8?B?eEkvMGFWSTdXTTgvSEZ0YWxPZVYrL3R3enVrTDNONSs0eWllTkVEYmoveENO?=
 =?utf-8?B?dWhDQkhkdE9kdVpJYXErc21IQWVmS3pPTGZiYkFjbWhLOHBHT0NJdlpUMVpC?=
 =?utf-8?B?Y2ZheTNpeVJ5WEtaSjVJRGxGcVpKamhIYStGTDkxWE1Ta0lzNW5lRVh0QWpZ?=
 =?utf-8?B?bmkrWHhPZEVHNUdKdE9VNDZkVDFUWUk3d1M1YWFRWTEyYnFDRWFrbUpsbkJy?=
 =?utf-8?B?SXJVNGZmRWpmYVh2Si9sZmxYdElTbTB1VnF0VzA3L1J6T1A2L2Vwb2s0cWRp?=
 =?utf-8?B?UWIyeGtUbXpqY0ZYUWpMQnkwa1NVOUNTMG5HY256Ui9tRGk0TEw1MUt2TDRp?=
 =?utf-8?B?V3JzaWphS3Q0ZU5aMC9DbUQ5MFZaM0VwMUlPNWpCWFFpYjcvTElNK0FMYjNj?=
 =?utf-8?B?cE0xUWhOcW44NmNqV2gzS3VDLzhjR0VaZGkwenR0OG1KQllJYldCazg4dVJY?=
 =?utf-8?B?S255aHpQUzl1a2VCY1BCcUgyODM4RXJhaS80TU91Y0QvVkFOdzBpNTdMMTk5?=
 =?utf-8?B?ODZUd2RhTWNLRGZCQkM3NlZObG8vbjBQcUNJNktKR0s3RjhaR01UUEZnamVa?=
 =?utf-8?B?YitVT0RZbXN3SkozWUJDRS9BSFBGSFhvZEJvTlBFOUx6akYzM1d0VU5IcEtL?=
 =?utf-8?B?bVhWMU9CVXFkWXBFeDRIWUhhcGtReGJhN3kvam1jelFRbkVlWGRuTkpkZFBO?=
 =?utf-8?B?ck1xWm1iNWVHZkdKYS9PeWdOaHlSSzQrWDhkZG85eU0yUE9STHBmMWdZZUNl?=
 =?utf-8?B?eXJ3NE40MEN3WlZONXhXR0YzUC83dkN6M0hYaWJLazNnTVNaR1o5OVJGRnhM?=
 =?utf-8?B?MERUYmdsOGVEcGxiY3VHY1ordmFMUnpaRkZyV1NOZXduMzUybVgwcmRUVlZ3?=
 =?utf-8?Q?tpqt4h2e8Za/IkFk=3D?=
X-Exchange-RoutingPolicyChecked: E6MmWDNtN2APAMiftoQPwK2/wqmLJjGSqY1mt/bxS4XiJkuMKf/GnFPxKZ0Ic5Xsn/a1keTCzSupGCDPxpeLWlbAxvDwAjtx2fut/d4G88Z/46NI8B96xKA1T1spowT+1PgrhDDUmmw0lO2Ae/2jjdUUE4RHTgg+mwDlKIJhUo5zka+bf0Jauapm+AOmuU5eDMuzLSSnIHcj7zdllw0jqZT/9jhRf3DthhV26DU1goSfy34Vi+jmtGgErCMBex9uQExCH7NjPtNWX64kJLGawcg2Gaeq5NrZZkbkK8UjY/WdHftJ7auicgVcJMCnMHNDmo9vmxcQrnARKKlJ9CrlVQ==
X-OriginatorOrg: nutanix.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 4891250f-26d3-46f4-9f01-08df02aed6e0
X-MS-Exchange-CrossTenant-AuthSource: PH0PR02MB7159.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 25 Aug 2026 13:43:26.3671 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: bb047546-786f-4de1-bd75-24e5b6f79043
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 6gsmv3twLY4hH1vYfOwF0ZBwcx6qI5addduedwjsB6pqxYge9wqEPeyti4ikEPAA7MWJy1emhEAkTxjJqPNM6KNJNdaktmgmtq2dYCEVxmU=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CO6PR02MB7681
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwODI1MDExNiBTYWx0ZWRfX22kxcmOAt3hj
 i9tSw7WChqW920gpMm5bif9zuVFVIMUMAs0tz27cVCUF7hyWSyUKFggf4ePoUjyQRvGYBnzbYZf
 +C5XqxPEhIlehrj3MpwYUuF9DwrI10SgOGYXS6tgSGUCLAjzCjrXoI3s1OID/uB7jsEmgsEQ/gd
 YvgCMWh0oRbaQ6TgBHds8EyXwxp5icYAntFfPBiiJyzNFZGlAXqbO3GTVvr0SJ2FFSyBrScAZ5m
 asAxJAprt7n/iPRE9cM4MaI3Nh0rolkI1dRbNLmViUATI/qgzF7peFpCgXBtOXkbGO5rfFMtaCY
 iUqc9SSH7kv2P7bTYeUaQZnV4JSjmMrwiFEucnn6gKr0vJOoal5qvmpTtTlt09fx4y3xzX4ALnT
 vkO5FKKeZ5YoeT7bHiSqHAsvEWatPWiERvkyze699PSDO55rs+hFj52+DHrarbAitdvrak8OsDJ
 0S9thJ6zjNuM1bZ02lw==
X-Proofpoint-GUID: jahmHkxyyBNcmyLb36F5bg6phjjeDYIW
X-Proofpoint-Spam-Info: AW1haW4tMjYwODI1MDExNiBTYWx0ZWRfX8Ne7z8EynEu+
 YYGVpQhlvov1J4T2y8holGxWCw+cMjvC1NnlUtIvDuKe4viM7kcSyYLbWbMKBWQxEVRZ/nHqO8Z
 ieWNB6JeX8QNXh+Rji6Q8MyVOkCCpTU=
X-Authority-Analysis: v=2.4 cv=W9AIkxWk c=1 sm=1 tr=0 ts=6a8d9c01 cx=c_pps
 a=GnodoI7vw6685P6KDJTVEw==:117 a=6eWqkTHjU83fiwn7nKZWdM+Sl24=:19
 a=z/mQ4Ysz8XfWz/Q5cLBRGdckG28=:19 a=lCpzRmAYbLLaTzLvsPZ7Mbvzbb8=:19
 a=xqWC_Br6kY4A:10 a=IkcTkHD0fZMA:10 a=Sv0fKeRqtYgA:10 a=0kUYKlekyDsA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=VofLwUrZ8Iiv6rRUPXIb:22 a=Ap8k9tRZuQ82DLYWQqG7:22
 a=64Cc0HZtAAAA:8 a=20KFwNOVAAAA:8 a=sXIxgEWn3KJhRak5j5kA:9 a=3ZKOabzyN94A:10
 a=QEXdDO2ut3YA:10
X-Proofpoint-ORIG-GUID: jahmHkxyyBNcmyLb36F5bg6phjjeDYIW
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-08-25_03,2026-08-24_01,2025-10-01_01
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

This macro will be used to generate the boilerplate property_class_get_type_ptr()
QOM get function for the specified scalar type.

Note that since the macro is currently unused, the object_class_prop_ptr() helper
function is temporarily marked as __attribute__((unused)) to allow compilation to
succeed.

Signed-off-by: Mark Cave-Ayland <mark.caveayland@nutanix.com>
Reviewed-by: Marc-André Lureau <marcandre.lureau@redhat.com>
Reviewed-by: Daniel P. Berrangé <berrange@redhat.com>
---
 qom/object.c | 22 ++++++++++++++++++++++
 1 file changed, 22 insertions(+)

diff --git a/qom/object.c b/qom/object.c
index 47977b1f44..e32ae30bd5 100644
--- a/qom/object.c
+++ b/qom/object.c
@@ -2703,6 +2703,28 @@ DEFINE_OBJECT_PROPERTY_SCALAR_METHODS(uint64)
 #undef DEFINE_OBJECT_PROPERTY_SCALAR_METHODS
 
 
+__attribute__((unused))
+static void *object_class_prop_ptr(Object *obj, ptrdiff_t offset)
+{
+    void *ptr = obj;
+    ptr += offset;
+
+    return ptr;
+}
+
+#define OBJECT_CLASS_PROPERTY_SCALAR_GETTER(type) \
+    static void property_class_get_##type##_ptr(Object *obj, Visitor *v, \
+                                                const char *name, \
+                                                void *opaque, Error **errp) \
+    { \
+        type##_t value = *(type##_t *)object_class_prop_ptr(obj, \
+                                                        (ptrdiff_t)opaque); \
+        visit_type_##type(v, name, &value, errp); \
+    }
+
+#undef OBJECT_CLASS_PROPERTY_SCALAR_GETTER
+
+
 ObjectProperty *
 object_property_add_uint8_ptr(Object *obj, const char *name,
                               const uint8_t *v,
-- 
2.43.0


