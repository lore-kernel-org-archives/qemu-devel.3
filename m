Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 35047C624D3
	for <qemu-devel@archiver.kernel.org>; Wed,  2 Sep 2026 14:43:02 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1x1mAX-0007kP-Hi; Wed, 02 Sep 2026 10:42:29 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mark.caveayland@nutanix.com>)
 id 1x1mAT-0007hp-A4
 for qemu-devel@nongnu.org; Wed, 02 Sep 2026 10:42:26 -0400
Received: from mx0a-002c1b01.pphosted.com ([148.163.151.68])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mark.caveayland@nutanix.com>)
 id 1x1mAR-0002AM-8z
 for qemu-devel@nongnu.org; Wed, 02 Sep 2026 10:42:25 -0400
Received: from pps.filterd (m0127840.ppops.net [127.0.0.1])
 by mx0a-002c1b01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 682CXcM01205931; Wed, 2 Sep 2026 07:42:21 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nutanix.com; h=
 content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=
 proofpoint20171006; bh=faplxVQ72UmOJN5D4U7lML2iYCDtp/dE3pbnkwuiD
 Es=; b=1T+iX79Zm+v/N+AdxnrhlHoOpWx6qA6bMKo9Ab7TvGvKC/twhiHNH6wO7
 3wzrLM8iESQdQAJx10BAhv5SDGYSV0AGMf18vDKSNwB2kaOqmxCn6KSustoZYBkc
 i3mrFymx1VghD3HgsRK7kdGxvaf7FgXN96/hHCFMrBCrZdc8UmqGgl4YiRINmYxI
 onqyu2dXbwDSaoNcgTpA0z4WGQc56pXcqhcLbA0wtVwRwhvHgU4dYLiMfc43RCY4
 RflLYtF3s4uPWCvrR9imKPJWf09ddxrLEpvOFHs7KNTSiHNnCjROxnbE58agqoYY
 Odst+7thotX7mBwRb8IYJDh70ISNA==
Received: from bl2pr02cu003.outbound.protection.outlook.com
 (mail-eastusazon11021134.outbound.protection.outlook.com [52.101.52.134])
 by mx0a-002c1b01.pphosted.com (PPS) with ESMTPS id 4ge100u3x3-1
 (version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NOT);
 Wed, 02 Sep 2026 07:42:20 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=lSkwvyfQ9/hBwRQjHbryWEMZLJL39QCTVzXsOaLWzxJgXgjcpKuxy9MaYn/c+C76qsPoC/QhZj0d1EB8kJUIPg8KguaWjVx4Rl2U082QPATJZrzB6c1VMKy8BiOgCAImxKll3Kjuwqo1aMd7rNSfcgG4YVYX+RYev7IYiBrfnafeVFnbI2OIuUXGRjicp96AiZO//yonYAJ9hwlVuWiR4QNt59RsABcHsc0MuhFZEBQmackYG5tVAKKgb5VyiNNT/zpAfhy866UQe+cLEZUHnchQK3f4i3n+c/fl+qQWGwozGH4NvGjyGrCzKFG48ZYcJg9KAPsYBZTI+mP5xKjdqw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=faplxVQ72UmOJN5D4U7lML2iYCDtp/dE3pbnkwuiDEs=;
 b=Jmi/4A0WzyE/QFcUPlPoncKwaHVtM4WuHfatOkewuNvwDAoLpKuOF2CeTQ6aIJYUN8sbAAc5p2UUnySTdDRiW5GUOffFcvegC/7wqcoGUQ3JAuEieizYp/+e0NorGPFHAn2hK7ummJSfnjAwLCE7jGHJ6xX2ERo24NPtq+UTpaNzPsi0JQ/U0DYjSCOmVXoyNEhk5FJEMEahyjsXLbf7rYBzskl7lGj4ZOhErBdWEKtHtz18l/Eh9RTDnA6N4TgoH8cfL7YC62SBF1qL6tIsOpoH/Rufwv6/PK9vr/aPNnPw5+qa8yuzfOxeV/mbDJMuo7/8IkFpBkfy5EPWAiBdIw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nutanix.com; dmarc=pass action=none header.from=nutanix.com;
 dkim=pass header.d=nutanix.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nutanix.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=faplxVQ72UmOJN5D4U7lML2iYCDtp/dE3pbnkwuiDEs=;
 b=nDe4/FJcNeFVuvOTMe8l9ahh9VZ59d7Zpb/6aJ9DhBv0yIB07ofUE9gB+VCOgwnLcBK/Qa6OkZ0qQbTjvIMo4+WxybRqxtUqxSmpCoYNQ/tgD7zovl4smgQJ/mBFjkOhjm3PFGXdYPeesTwxv1i8HJMZFM3dyJAID8x5P67XoSbD44BncY3t/C2zNBo0sLwlQe2ko/YsIr6it2FX7KFV41IlskbJL7p792bBY2XokSBIcN0dJbqGwe0WMGZ0BToM3WxBJzLmpWSnbT+0TA10KrboY8R6MrFptKLedDCnEYrpFgAFZRTASn6hxe4IJ0FQiW0XGoL+mWrmKpwhlwCJ2g==
Received: from PH0PR02MB7159.namprd02.prod.outlook.com (2603:10b6:510:16::8)
 by CHXPR02MB11331.namprd02.prod.outlook.com (2603:10b6:610:2f9::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.360.13; Wed, 2 Sep
 2026 14:42:18 +0000
Received: from PH0PR02MB7159.namprd02.prod.outlook.com
 ([fe80::8e97:bc32:822c:b250]) by PH0PR02MB7159.namprd02.prod.outlook.com
 ([fe80::8e97:bc32:822c:b250%3]) with mapi id 15.21.0360.008; Wed, 2 Sep 2026
 14:42:18 +0000
From: Mark Cave-Ayland <mark.caveayland@nutanix.com>
To: pbonzini@redhat.com, richard.henderson@linaro.org, mst@redhat.com,
 mtosatti@redhat.com, marcandre.lureau@redhat.com, armbru@redhat.com,
 qemu-devel@nongnu.org
Subject: [PATCH v3 2/8] qom/object.c: introduce
 object_class_property_add_alias()
Date: Wed,  2 Sep 2026 15:40:49 +0100
Message-ID: <20260902144207.2553037-3-mark.caveayland@nutanix.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260902144207.2553037-1-mark.caveayland@nutanix.com>
References: <20260902144207.2553037-1-mark.caveayland@nutanix.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: BY5PR04CA0018.namprd04.prod.outlook.com
 (2603:10b6:a03:1d0::28) To PH0PR02MB7159.namprd02.prod.outlook.com
 (2603:10b6:510:16::8)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH0PR02MB7159:EE_|CHXPR02MB11331:EE_
X-MS-Office365-Filtering-Correlation-Id: 60b75c49-3e34-4910-66d9-08df090063a1
x-proofpoint-crosstenant: true
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|1800799024|376014|23010399003|366016|10067099003|56012099006|6133799003|22082099003|18002099003;
X-Microsoft-Antispam-Message-Info: JUToHX3dcshdlLIH18cCbzNPRUDkTVtEgeuL/bUlBCzBVHEQuHA7NVV5cLAGfZRRQV59XCGmKcjWvspl6KsyNu9ymnGNI354MJIgOciJwB5N5ZD6PYFVBE7upkJ8hY2dPGVRNsbMz0cUFncsoibMti+27GDUmfYMsTg28ehE0Tj4rYm9vw1XrbNhiWX9YOHTWSRpMyR8vVDykruR3IBdtgbEFocS2+VcSGK3m33a0SD2gZtwh3lTFr5r7zb6UM1MJw7/mbGXiFvHKi3RHwPXB7CDuMqRJEsKhN/q/glTrhTHcfKWSIhi6y2FLcNETJ/PME25yznG8UApJfrPUWvQQ5+3z51BqDAmwO1yRv83wWmQmy9uZTWhozMEpJRUxOVfxGJhVHrkEAB0KgS5/3H4rLidiVXEUC8Qg3L5rxx2LEeqZIbn6UDnlok5+QaeG1flq2oJT19phNEU1Lw+FE5hRkPq5xLWcHXWMo+ecaZTFC6uCCirDpIYJxuAkNCJ/ojN+9LH9l/mOKjlhtJXlXvZoGBSiHmWctCTojkkx4wp2LJ455E4nGbb3sV7VbygGm0Aki9A4Qi39M2xtLIVFcD4jAghFKz5bStjsOfI86owbQtaTzL8Dbne4KsUMAZKfrTfTwHSFzQPmSGL/r2RWbxoTXgswZUvOsBwCNnTI2bIDj0=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:PH0PR02MB7159.namprd02.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(1800799024)(376014)(23010399003)(366016)(10067099003)(56012099006)(6133799003)(22082099003)(18002099003);
 DIR:OUT; SFP:1102; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?axJQGVMG2PfVzoSzBRZz7hPK2i6gggVfYKlnhOwGpWbxCmhwSxz34dvFmOZg?=
 =?us-ascii?Q?sbLFQp/TGtxe/Cj1PL9MWGXzrVisovu3FDJ/WkiJr77lKuZIcSXC3nUj+Cs+?=
 =?us-ascii?Q?m1Cih4YNya4R0JVqqmDMIfeDGsFXR1NpfClqCb4bnTYAwe1DtvvchA8FeQwJ?=
 =?us-ascii?Q?tRULfPMqtyfWdCO1osrfE4iJnaAkQu3cxIo8J0HhkK/TzI9frscIJfiGUMES?=
 =?us-ascii?Q?Z3T61LDOik2Willt+BHtVUyq85x3fYfipPtQrzmjtJ+NdIwFvHWPgA9Gm0Y8?=
 =?us-ascii?Q?2bhsBIRuLnvGz9C7drhb+VEQlAkxaKanqfBe2lHOfmmEVtedt3HYIgF4Dliv?=
 =?us-ascii?Q?On47FCRA/R1GaDsdP+oWgEiLK5YBtjWfBc041szw0QzYhHviOqmiK8YOJsGU?=
 =?us-ascii?Q?rdwVpUaCDGTwFcraRcq4dyavgxQE3ag2Ox/gWvaFfjr7cvDPhcE+TVBXpSK1?=
 =?us-ascii?Q?DLCPbmiOlICHS6hsw9y5bC0fWxLCz9I2IgnQdO/4Te4KGPsaELXBit7oHetv?=
 =?us-ascii?Q?kAksQcaKZ17JyhVvKpzxC+0lPUjvuLXeZ1YDCpBvVl7WByCqWD6rOE0Y8ybi?=
 =?us-ascii?Q?COGxhSb0YKFEXlVCFmlZ//5d6CxEDmvvG/+/G8QK5kBrc5Gub5haXH3vw6IW?=
 =?us-ascii?Q?dU1quwN7QvVvyDs++9vytjRS11h61X4DMbK4GhI06msQg680hdStnADiijaS?=
 =?us-ascii?Q?vld0lC51yZyycxmzz1l38S+QH4nxTTquBgHcH8BI/59Sn6ixJyPvjCwh0+nJ?=
 =?us-ascii?Q?N8Zq+BNykcB0sKO0YbOP10oWmcAenvwzJEoyfXXS1WLRj5BdsxjsCy42cDIE?=
 =?us-ascii?Q?YO/QwwBTIOHLXlcXdtb71rxzmvj+G5nw84Q3il2/EAB0E1QuNR08thgKbGgY?=
 =?us-ascii?Q?IlPs2e/XU8ZRz0fRdUu3A8fztrQKemxaSdA398ptFBEgqP9ic6p9zKs/9sbL?=
 =?us-ascii?Q?tisumk9MDqAMsEab1ohpvB60QLt+CABj9XTuVkWPwD1tnU3JXKAssA7iFl7w?=
 =?us-ascii?Q?YH5tBXotvlslBADswLcdMpVkcVCSplOF7s8HFG1rBOaF+Qg/i9Pudq3o7wO4?=
 =?us-ascii?Q?g1Oc0Le0QI3QbI6+ri5Itcb2Pz614+tSTM/SHOdrn5ccyJp2WZZvDyzPqc/P?=
 =?us-ascii?Q?L+uOp+qdxkml6ocF4DHtQA136upScaLDlmIf9FwOYbUnDfCleh/g7c4LwwYw?=
 =?us-ascii?Q?6DnYWuarSqdPibf++joORbBWHH+tBEkK17amIhs1S43as9OKm7qiuxHVYupU?=
 =?us-ascii?Q?Rt6EIhaF5CC2P8ItUC5CFM2mW3Nr1di2qLRg064+EULIfe5az32pEVXnP4IA?=
 =?us-ascii?Q?yhWzVINpIe0uVrfnKmfwmAVM8ZeILLyhbuOQL41P0V0+P8ekQh/D7lQn5+u4?=
 =?us-ascii?Q?1vMpFFvbN3i3Qryj8VSUgOa2qnUxiiCnEptF2pM1Vz1TS0x3prOx0xBr1hze?=
 =?us-ascii?Q?tjtQV1IGRT+9W1jtXO2n1lDi6d/WKESNdB0QuFw/JAjXPitmfdkF9Et6e8Ry?=
 =?us-ascii?Q?TwR8+kuysWuNOa1BgTaSsY5g3fPzjvVCtRd1klGOOi0wmT3jVEOk6UmztiQp?=
 =?us-ascii?Q?2/AT6/GRGs5xfGTJKX1Dv4d5KiloZQz5bdYuLO+vjiF4NyUil15bLs8mfmXw?=
 =?us-ascii?Q?QOV9sCdH8jdWqX8UqZr14+yv1knP57bNDyHaA/y+WyxLMih17t8rkNkE6WYb?=
 =?us-ascii?Q?WM///8GUGYlKy1RA/oj/W/52K5QOUekswlONHtO38qXtNihmODwi9DuoOb7P?=
 =?us-ascii?Q?rg/Z24T20J6gBDEIPT2FmGW5C1e09/0=3D?=
X-Exchange-RoutingPolicyChecked: FdRw0bJQGI1RQtG0y6yDTYGWdxggMZoB7l1LJuBFDmHyzjm1Kbds6hZA+2eRIceCRrBGNckwhJs8pobNyIJZRhAIpADy6CrzQF3KbMxxpsbRdrjmfYBUU6JX68KlkLk9O94w6rltuplopS54rlgzGoCcyhkt9xlEbH6GIkhGUpoFveObhHeTQTGaZXvJAnUXiu5NWVOpvOgjwQTo8GyCQ4c9iLLUlHdcloXRB/HIUJBPPXkD6jqrjGF5T2WQkU296lV+pL8o24ChCTFmTvBZXQ/3asIvinvo2yfuu4pV6icbJak4IPyJ7jyRs7bYFAdwF5l/AR6IZKpyUEzVfeAo5w==
X-OriginatorOrg: nutanix.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 60b75c49-3e34-4910-66d9-08df090063a1
X-MS-Exchange-CrossTenant-AuthSource: PH0PR02MB7159.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 02 Sep 2026 14:42:18.8628 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: bb047546-786f-4de1-bd75-24e5b6f79043
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: FINoQy2UCGunAn2lwsiEYsCzt48OlxYyQbceY4ZnZKiP4BoZY8FWB/mhOxrXTP+kEyjsTAiFfE+yUewIjixiW+BEnpM6twkT6MciVM0ssas=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CHXPR02MB11331
X-Proofpoint-Spam-Info: AW1haW4tMjYwOTAyMDEzMCBTYWx0ZWRfX6vpCIeo9qPL/
 Yn+nwArB7csvkhy737c9gBqgP4tUtlpxm2UWJbFxqU8Xr2DES3SvrQKOyfpfoWgZ/tPEnwSLEeb
 vpKQZBo1VXmF1Lj2YH58NPsqlfdAiaQ=
X-Authority-Analysis: v=2.4 cv=JZuMa0KV c=1 sm=1 tr=0 ts=6a9835cc cx=c_pps
 a=UUmGjFhUr3uPr7k6e03iKg==:117 a=6eWqkTHjU83fiwn7nKZWdM+Sl24=:19
 a=z/mQ4Ysz8XfWz/Q5cLBRGdckG28=:19 a=lCpzRmAYbLLaTzLvsPZ7Mbvzbb8=:19
 a=xqWC_Br6kY4A:10 a=VdqzKS8jKosA:10 a=0kUYKlekyDsA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=VofLwUrZ8Iiv6rRUPXIb:22 a=_-M8LpHI31CeLmyZm6wg:22
 a=64Cc0HZtAAAA:8 a=5qpsIK_AQi6EPHI5KBEA:9
X-Proofpoint-GUID: XjrXC-vFNBxkFDbzeqGvmae_xYvhGCLS
X-Proofpoint-ORIG-GUID: XjrXC-vFNBxkFDbzeqGvmae_xYvhGCLS
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwOTAyMDEzMCBTYWx0ZWRfX7uD0SDOTlDJ1
 IRq3yPZ6HHRTEFkTkkYpoF1Tk9jfGa63cnWUxmzw/MYwQ2+vsuPosxa/7zs/oTefCCGJe5Q8cq0
 mtxf6BpvCgWKjOxNqMslirX9JEiLLiJYUvVB0owTu8N6NPPe39UEzfZDE8mvkajKpTijYLVaMzE
 iJdcG/bKSomDckFskmjzRhpMudWbqMaUkzJFY6EojxDDG+rsPlpYFNppEM7mKpI+qEcxMeLoYl6
 oOEKGRJmjAUlMlUmHogac5truMN1AIiqYLNHKReeOfjPdeiJSR/CKif0DfxHUxVZowyQMNjqeOe
 JuNqt/sDqOLPN49bDnwHPLCALxXaOJIRzTIN0PvoQ2ThewNdhZorkvjjLfv/OlWE8/15ikWUrTU
 CwH/VHwWLe0vkOewv27zVoJneAPtQB59JKs7WW13XYF+itirdeq3UaI2b3pJLrlKuqBqVH7eT1h
 KE+oirXTkfl8Br6JGSg==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-09-02_03,2026-09-01_03,2025-10-01_01
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

This is eventually intended to be a replacement for object_property_add_alias()
which uses an object property instead of a class property.

With the advent of class properties, it is possible that QOM may attempt to
set or retrieve the value of an unset alias property. Update the existing
property_get_alias() and property_set_alias() functions to use the null visitor
if the alias target has not been set, and property_resolve_alias() to return
NULL for the same case.

This ensures that unset class alias properties accessed e.g. via the monitor do
not cause QEMU to crash.

Signed-off-by: Mark Cave-Ayland <mark.caveayland@nutanix.com>
---
 include/qom/object.h |  25 +++++++++++
 qom/object.c         | 100 +++++++++++++++++++++++++++++++++++++------
 2 files changed, 113 insertions(+), 12 deletions(-)

diff --git a/include/qom/object.h b/include/qom/object.h
index e24f0a2b2d..96c76975ef 100644
--- a/include/qom/object.h
+++ b/include/qom/object.h
@@ -2263,6 +2263,11 @@ ObjectProperty *object_class_static_property_add_uint64_ptr(ObjectClass *klass,
                                           const uint64_t *v,
                                           ObjectPropertyFlags flags);
 
+typedef enum {
+    /* private */
+    OBJ_PROP_ALIAS_CLASS = 0x1,
+} ObjectPropertyAliasFlags;
+
 /**
  * object_property_add_alias:
  * @obj: the object to add a property to
@@ -2283,6 +2288,26 @@ ObjectProperty *object_class_static_property_add_uint64_ptr(ObjectClass *klass,
 ObjectProperty *object_property_add_alias(Object *obj, const char *name,
                                Object *target_obj, const char *target_name);
 
+/**
+ * object_class_property_add_alias:
+ * @klass: the object class to add a property to
+ * @name: the name of the property
+ * @offset: the offset from the object instance where the object alias is
+ *   stored
+ * @target_type: QOM type we expect the alias to resolve to
+ * @target_name: the name of the property on the forwarded object
+ *
+ * Add an alias for a property on an object.  This function will add a property
+ * of the same type as the forwarded property.
+ *
+ * Returns: The newly added property on success, or %NULL on failure.
+ */
+ObjectProperty *
+object_class_property_add_alias(ObjectClass *klass, const char *name,
+                                ptrdiff_t offset,
+                                const char *target_type,
+                                const char *target_name);
+
 /**
  * object_property_add_const_link:
  * @obj: the object to add a property to
diff --git a/qom/object.c b/qom/object.c
index a904f53ed6..9a05e189ea 100644
--- a/qom/object.c
+++ b/qom/object.c
@@ -34,6 +34,7 @@
 #include "qom/qom-qobject.h"
 #include "qobject/qbool.h"
 #include "qobject/qlist.h"
+#include "qobject/qnull.h"
 #include "qobject/qnum.h"
 #include "qobject/qstring.h"
 #include "qemu/error-report.h"
@@ -3039,14 +3040,22 @@ object_class_static_property_add_uint64_ptr(ObjectClass *klass,
 }
 
 typedef struct {
-    Object *target_obj;
+    union {
+        Object *target_obj; /* if !OBJ_PROP_ALIAS_CLASS */
+        ptrdiff_t offset;   /* if OBJ_PROP_ALIAS_CLASS */
+    };
     char *target_name;
+    ObjectPropertyAliasFlags flags;
 } AliasProperty;
 
 static Object **
-object_alias_get_targetp(Object *obj, AliasProperty *lprop)
+object_alias_get_targetp(Object *obj, AliasProperty *aprop)
 {
-    return &lprop->target_obj;
+    if (aprop->flags & OBJ_PROP_ALIAS_CLASS) {
+        return (void *)obj + aprop->offset;
+    } else {
+        return &aprop->target_obj;
+    }
 }
 
 static void property_get_alias(Object *obj, Visitor *v, const char *name,
@@ -3054,10 +3063,18 @@ static void property_get_alias(Object *obj, Visitor *v, const char *name,
 {
     AliasProperty *prop = opaque;
     Object **target_obj = object_alias_get_targetp(obj, prop);
-    Visitor *alias_v = visitor_forward_field(v, prop->target_name, name);
 
-    object_property_get(*target_obj, prop->target_name, alias_v, errp);
-    visit_free(alias_v);
+    if (*target_obj) {
+        Visitor *alias_v = visitor_forward_field(v, prop->target_name, name);
+
+        object_property_get(*target_obj, prop->target_name, alias_v, errp);
+        visit_free(alias_v);
+    } else {
+        QNull *null = NULL;
+
+        visit_type_null(v, NULL, &null, errp);
+        qnull_unref(null);
+    };
 }
 
 static void property_set_alias(Object *obj, Visitor *v, const char *name,
@@ -3065,10 +3082,18 @@ static void property_set_alias(Object *obj, Visitor *v, const char *name,
 {
     AliasProperty *prop = opaque;
     Object **target_obj = object_alias_get_targetp(obj, prop);
-    Visitor *alias_v = visitor_forward_field(v, prop->target_name, name);
 
-    object_property_set(*target_obj, prop->target_name, alias_v, errp);
-    visit_free(alias_v);
+    if (*target_obj) {
+        Visitor *alias_v = visitor_forward_field(v, prop->target_name, name);
+
+        object_property_set(*target_obj, prop->target_name, alias_v, errp);
+        visit_free(alias_v);
+    } else {
+        QNull *null = NULL;
+
+        visit_type_null(v, NULL, &null, errp);
+        qnull_unref(null);
+    }
 }
 
 static Object *property_resolve_alias(Object *obj, void *opaque,
@@ -3077,15 +3102,21 @@ static Object *property_resolve_alias(Object *obj, void *opaque,
     AliasProperty *prop = opaque;
     Object **target_obj = object_alias_get_targetp(obj, prop);
 
-    return object_resolve_path_component(*target_obj, prop->target_name);
+    if (*target_obj) {
+        return object_resolve_path_component(*target_obj, prop->target_name);
+    } else {
+        return NULL;
+    }
 }
 
 static void property_release_alias(Object *obj, const char *name, void *opaque)
 {
     AliasProperty *prop = opaque;
 
-    g_free(prop->target_name);
-    g_free(prop);
+    if (!(prop->flags & OBJ_PROP_ALIAS_CLASS)) {
+        g_free(prop->target_name);
+        g_free(prop);
+    }
 }
 
 ObjectProperty *
@@ -3110,6 +3141,7 @@ object_property_add_alias(Object *obj, const char *name,
     prop = g_malloc(sizeof(*prop));
     prop->target_obj = target_obj;
     prop->target_name = g_strdup(target_name);
+    prop->flags = 0;
 
     op = object_property_add(obj, name, prop_type,
                              property_get_alias,
@@ -3126,6 +3158,50 @@ object_property_add_alias(Object *obj, const char *name,
     return op;
 }
 
+ObjectProperty *
+object_class_property_add_alias(ObjectClass *klass, const char *name,
+                                ptrdiff_t offset,
+                                const char *target_type,
+                                const char *target_name)
+{
+    AliasProperty *prop;
+    ObjectProperty *op;
+    ObjectProperty *target_prop;
+    ObjectClass *target_class;
+    g_autofree char *prop_type = NULL;
+
+    target_class = object_class_by_name(target_type);
+    assert(target_class);
+    target_prop = object_class_property_find(target_class, target_name);
+    assert(target_prop);
+
+    if (object_property_is_child(target_prop)) {
+        prop_type = g_strdup_printf("link%s",
+                                    target_prop->type + strlen("child"));
+    } else {
+        prop_type = g_strdup(target_prop->type);
+    }
+
+    prop = g_malloc(sizeof(*prop));
+    prop->offset = offset;
+    prop->target_name = g_strdup(target_name);
+    prop->flags = OBJ_PROP_ALIAS_CLASS;
+
+    op = object_class_property_add(klass, name, prop_type,
+                                   property_get_alias,
+                                   property_set_alias,
+                                   property_release_alias,
+                                   prop);
+    op->resolve = property_resolve_alias;
+    if (target_prop->defval) {
+        op->defval = qobject_ref(target_prop->defval);
+    }
+
+    object_class_property_set_description(klass, op->name,
+                                          target_prop->description);
+    return op;
+}
+
 void object_property_set_description(Object *obj, const char *name,
                                      const char *description)
 {
-- 
2.43.0


