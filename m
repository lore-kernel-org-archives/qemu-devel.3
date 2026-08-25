Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8D4BDC61DB9
	for <qemu-devel@archiver.kernel.org>; Tue, 25 Aug 2026 13:45:45 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wyrS5-00043J-PS; Tue, 25 Aug 2026 09:44:33 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mark.caveayland@nutanix.com>)
 id 1wyrRr-0003u1-6w; Tue, 25 Aug 2026 09:44:19 -0400
Received: from mx0a-002c1b01.pphosted.com ([148.163.151.68])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mark.caveayland@nutanix.com>)
 id 1wyrRp-0002Y3-Bu; Tue, 25 Aug 2026 09:44:18 -0400
Received: from pps.filterd (m0127838.ppops.net [127.0.0.1])
 by mx0a-002c1b01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 67PB1AlY1846113; Tue, 25 Aug 2026 06:44:05 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nutanix.com; h=
 content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=
 proofpoint20171006; bh=xwvrJKuLCPfBY2KCnrrqOz+NlxQSYhbdaRGloOsE9
 MA=; b=XcVFEtElmlo8I1pLFcalpXmvr2AAl7sr45jKXlnYr5s3mCMVo5uO4iBl9
 Ufzojupfd/FgPX3VTSkX6q/4juL2Y8+mJ5JlDOgZpf4JvaxpmVpVdpcBiJhoPUg5
 JHzeZPaLMcF6sSTx7UREcZHqpabN9axKz2wclaaj0q1Ln23m3BRjwzgXSTdSoaBa
 t+L+Cw+ZLWXFjTChg/P4CvCCsLMyjg2mQBwwLntEj7HmKazYJaDzPD1zpnZmCJE7
 8QSeTs9o+vd2ryIhm2cWQ8xbKEIuHOVFX+OuId2pS/ovKPx7iMfwCNbg9nM1603P
 jz8ZHU3/otZ2Y3Lt8hDtWweioWGHA==
Received: from sn4pr2101cu001.outbound.protection.outlook.com
 (mail-southcentralusazon11022089.outbound.protection.outlook.com
 [40.93.195.89])
 by mx0a-002c1b01.pphosted.com (PPS) with ESMTPS id 4g7baved9b-1
 (version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NOT);
 Tue, 25 Aug 2026 06:44:04 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=JYUFsGxohF8kYOITAMhskZ5s4qI0YE6U3NYjjpLUAlHI8Uv/znSnrBa22D/JzERlxppiNiXnFtoirLzgLs8NgEPDp1e+tY2Di5FQnXaTNjvnbqrgnfLTzbaZMNTatO/matZLqxFx5LGQebUroLosFlwNauGwe3RiAPFNQeQ/FT+BNhepmeQFKEAUKn4vUqujs7OGsQxjhZrEumJP0PLvHGiSM1sOjffh8w3P/Y7nZSEnQ1Ln8VpKGY86ktlZARzf/UdyBUwaACI62liO6yGJ9R12RdVmgR330J+upF1kV08unY5GEXha1zSTToxg1apLWMNGapNBNXM1T89TuGo6jA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=xwvrJKuLCPfBY2KCnrrqOz+NlxQSYhbdaRGloOsE9MA=;
 b=HDA7K1i1yqu8XQwyFpjpmwCfi7fYcNcigstDJsK92RYk0kDWZYEjevlmhWqLod9QXwV5BFLbkCpMUdTgJX2rPns1q1JVHNh2sBT1X8XhlIouzr1b2wmKbcwLmf8g0zEaXOdkKtYFx7TdYENFSHjds8xXYlG6JmJPkKPh2W23GpbDXcozEZchueS7GEoY1APp3hwg+yOHGQXpjg7fUiOCfntWWi9B2o7DVopYCn8Gns6RrtkcrtAwYKJi4NgPEI1YHJLYFtSQfZiAH2i+EZEROdEKzh+jvJei0xES85wuBS5pKRjMfhMPvOIJUqRb+phAG9TyPs1A6HW1e9WFXVrXPQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nutanix.com; dmarc=pass action=none header.from=nutanix.com;
 dkim=pass header.d=nutanix.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nutanix.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=xwvrJKuLCPfBY2KCnrrqOz+NlxQSYhbdaRGloOsE9MA=;
 b=KG+q8cMbY5ca2tXcj0VeKBKYIznTDIb+jXjyttsOmMY8h57mAd8YpHZU+pHxMbsFy15E6gxCJBHedI/YHXeTBGgyaA4iH3gtAIDyOUeybWqu8qLhwBdEqy1neOeBxJ5nJk1NeqxH3cSoAt/2XtENMX2BOajizsNxKlUG/pOhuAsSvsnjzUHpqpgTX0E/BFI92Qnc4e0iXNU4G+H2IoL3/qFNQrlcwA3DCNT//ZsV7WgmahdRZC2vnYMF5MTdfAisx+wXRr7FnJEP26pl/ZtEENrMtgizU2SdcWBO5H9Yo0kI1jGEdpFuuj+W7SVxrZTP9uTLQTGMdU9ri/3SmPN8Ng==
Received: from PH0PR02MB7159.namprd02.prod.outlook.com (2603:10b6:510:16::8)
 by PH0PR02MB7557.namprd02.prod.outlook.com (2603:10b6:510:54::17) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.360.6; Tue, 25 Aug
 2026 13:44:03 +0000
Received: from PH0PR02MB7159.namprd02.prod.outlook.com
 ([fe80::8e97:bc32:822c:b250]) by PH0PR02MB7159.namprd02.prod.outlook.com
 ([fe80::8e97:bc32:822c:b250%3]) with mapi id 15.21.0360.005; Tue, 25 Aug 2026
 13:44:03 +0000
From: Mark Cave-Ayland <mark.caveayland@nutanix.com>
To: mst@redhat.com, imammedo@redhat.com, anisinha@redhat.com, philmd@mailo.com,
 aurelien@aurel32.net, peter.maydell@linaro.org,
 richard.henderson@linaro.org, berrange@redhat.com,
 marcandre.lureau@redhat.com, qemu-devel@nongnu.org, qemu-arm@nongnu.org
Subject: [PATCH v5 13/16] hw/acpi/pcihp.c: convert ACPI_PCIHP_IO_BASE_PROP and
 ACPI_PCIHP_IO_BASE_PROP to class props
Date: Tue, 25 Aug 2026 14:41:34 +0100
Message-ID: <20260825134320.1039012-14-mark.caveayland@nutanix.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260825134320.1039012-1-mark.caveayland@nutanix.com>
References: <20260825134320.1039012-1-mark.caveayland@nutanix.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: SA0PR11CA0056.namprd11.prod.outlook.com
 (2603:10b6:806:d0::31) To PH0PR02MB7159.namprd02.prod.outlook.com
 (2603:10b6:510:16::8)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH0PR02MB7159:EE_|PH0PR02MB7557:EE_
X-MS-Office365-Filtering-Correlation-Id: cde53dea-d343-454c-7c70-08df02aeecd8
x-proofpoint-crosstenant: true
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|23010399003|7416014|376014|366016|1800799024|10067099003|22082099003|18002099003|56012099006|921020;
X-Microsoft-Antispam-Message-Info: Wf8NpCkRiibpZ00jwgjCnBM0p6YrbP1C3dnRGRhjm248TxDq2eiPphcqRPAYEc+XOJEvqqqyM5671mR05rbLUFhYOwRRSA4JRONw9maaceYOdor+PmGJJ8+3qZ1IGSNr7Mf3dy0svJl+GLxGhIX5gq25FUSRy5HtQgszdLR/Pxj+HOuI1mT+IMauOY044DiTCWKfSF1bhPcMc8mOQDMlgWr9XGpqrU4OeKcGPoT3y3m3bYxbtL1EEwH7mgb7Z8EHWSSrb2mujAsshdxGille7wDXbwTTUvFBMO+DQFUxnbrVfgIpatUjg7/v743pkPpaz+VII1XHAOwoTgb+OrrWslyzXRSUkt/vGK1pgp+k2dlK/S0lSQmuWAgZRXMHNubJ8iSMiuAALLnam8XTqTj6EK5wPgnsGm0H7N2EhvG/7iBCr+mLGLDE4BMjGWS1tZrTNselF4NVJv5dHEiCOWl40ivsbme1KsD/B4liRgiUWCgzXQyqvSxggvgfMezhUbIlg8YwtBd5RG15n8rwGRbcIqvzRZg6Scwl6+Wn9uIW5yUPw1qxapomA4EeqSQU5AIKXcHHwqMZxlBNhvfZ0Xmatqp6L1oPpEgO2g13w7PF7hvbKnXr7E++qkNavOVaQKpMWelGbw4a/eG2tBo+pRSlF9QvTwKVEWVV57QQZx3r92fjHHgTvkKC+LvEM53IdHvnmkNc2iNUFcVzjKAt+XWkuw==
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:PH0PR02MB7159.namprd02.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(23010399003)(7416014)(376014)(366016)(1800799024)(10067099003)(22082099003)(18002099003)(56012099006)(921020);
 DIR:OUT; SFP:1102; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?VzBtbTVaK21qbVhDVkQ3Vndlc3ZDam03S3ppNTRSalVNalRIN3hlL0tyc0tO?=
 =?utf-8?B?RXZ5Um1mTlBWcXNhOXU3U0plUFVKRmhUanp5Yk9xV3gxRTNhWVZiS0hyMzBC?=
 =?utf-8?B?QzArOXYzbk9Wd3NSczhmOU5WVlpLaEtaeUREUGpuSkNiVTIvMGdvMGNrOHc0?=
 =?utf-8?B?aDZvUVB6S0daQXczWE9udUd6M01nRGtzZ0wvM1ovVklkV2l6T1pzYUhodE42?=
 =?utf-8?B?c2k3VHdXV1RnVWlQQnJCcUZ5QXVDR0Uxdi93NzFjUDJQNi9SSS9VaG1hL2Nv?=
 =?utf-8?B?c05oTWpMOFdBT0o2UVBvd2ZGbjVabW8vUTBsWTVTM24zL0RuU0daaUFWa3Ni?=
 =?utf-8?B?c3dTRnd3b0pwNUpYbkgxa0tpVTNWbXdtdjZ1ak4wRTlXbVhtRlhaek9udjZm?=
 =?utf-8?B?TXNVV1IxM0RlNUVpNHo4RThISnoyRnpvbFNvZjNkY1poNm8wU1lDRXVKSFVZ?=
 =?utf-8?B?ek9mWlI3MWZ2QjB0YnlsVUYzL055MkdVSVZtNklPSkRPbFhram83bU82MUJx?=
 =?utf-8?B?ckRxZDAzbGlIVWE3K3ZlN2pWZkZBczVDVTlveEFDc2VoQmhjZ1cvcEw4WXpK?=
 =?utf-8?B?QVZwRGZ6elREQ2ZzRFBhRC9xWkF3OVFPYUgzWi9yNGQrc09ZSlBad01SN3RV?=
 =?utf-8?B?TlVrc1g0cnlESERqNnRZWWxpWHRNL1NNWXRHU3hybEV1c2NNM3pkMWp3Q3lF?=
 =?utf-8?B?TTJPaWQxU3lXRkx6ZmtuSWdDOTZ0VEJDT09mZ3B2VEtGOWoxUFd1WkVyTThT?=
 =?utf-8?B?TGJKZTNHSXZVeUFIR0I3MlcrUlZxNk9vOHM5dk96Y1NLRktuTjU4S25WRzRH?=
 =?utf-8?B?STNobEhiMmlsRzZlclcyNHd2MnVFdHNrRkUwVTJXUndJTTR5SmxtTjZMdVRH?=
 =?utf-8?B?L3BKTDJvNytHMDgxWUdZUFNZQ0FvY01ERjRQSlJSSkt5U29kY2VyK0hva0Nn?=
 =?utf-8?B?V0l1V1Q4ZzZUZkJOMGVGMG9GQytGRkpGNlIwVWllNWJrSHp2UUlISnpsSEhu?=
 =?utf-8?B?RE9vbGNNbWs5ZkVMTEV0dGp3dFdwT2NvNTlBVE9pS3NCTFF5Szk3d2plY0sv?=
 =?utf-8?B?dlJrZFh2S1poajFZTGk4YnpkMHhHSFk1ajhpSUt0RzJxclJJMkZ6b0dDTWwv?=
 =?utf-8?B?bVl3Y1pNL2ZsaDNyVGlkVGtjRy9ab3JOSUczSkd6LzdiMEVwMldCeUsyeEVw?=
 =?utf-8?B?WjREUEpMRWpEd2ljcnR5L3ppWVNRTDYzOW5mRGdiaWhsT1JuMmNXY2dQSzk2?=
 =?utf-8?B?K2dQMXEzNkxTcTdBaUJybXRSbnJoNDRzbEdPdExPQ3JJWEZpMmFDUDNrclE1?=
 =?utf-8?B?aHhmVXdMNmJpVGpteUJkSzBKaldDQzk3YlpvVHZGVHVEUCtPS2dyamxlWXR5?=
 =?utf-8?B?cWhjTjZsazA0aFN6dFVBdmh1djh1d0Y2ejZFaDNWajVaR2NhTEN6dVc4Z0Ri?=
 =?utf-8?B?bjhEdVIySkZZRlBlekZWd0hqY09OSTJOUFJoMHF5aGRQcTM5eWJSMFE1WWdu?=
 =?utf-8?B?dFoyOTR0K293dVBwaE9pL0xMUGlWUWM3ajhHa29TRDN2aVVTR2o0Ni8xL3h6?=
 =?utf-8?B?UngxNEkwcWk2SGhMbkV6amo3TFNmZXFzaUo5dG12MkxBMHNzSnhtNkJLRklj?=
 =?utf-8?B?K0grektJZ1NId05VcVBFdWxDTE9SQWZocVM1aWNIMVpma0FLQzFpc2RKbDhq?=
 =?utf-8?B?M3BDaVBOOEpmSittQTlpV2kxQXN6VjRsdWxsUXBYOXVBK3Zlc1VUN2VmQzBa?=
 =?utf-8?B?aEhlZ2dHVGlJajBsZ2Rid0NIQXEwSnp3VFk3UGNSZTMyMGRYeVhKa1ZPN1Rj?=
 =?utf-8?B?eVNHZEZMSWhRSytkUnhlbGl3VkxjNVhUbVoyVVBhanptd2JpMXJkWmNiaVh5?=
 =?utf-8?B?SEw5UUpPOTFKc2ZVeW9qSnVONTBNN2xDTk1pZ0ltSkxVcVBvTVdNRjUzTjBT?=
 =?utf-8?B?TG1SVmh3ODJuL2hrSmNxaDFzODRkRDF0YVNwNDhKV2NpZUw2LzJPNlozU2tV?=
 =?utf-8?B?c3A2QTYxUFUvZjFSSk1uNjZZTjJ6d2diMEpVKzFya3VLUk1DZ2xybHVhOGFv?=
 =?utf-8?B?UHZQZnRRc0c0QmJCS0pUNnJVbW41QVAyUHBPSnFFZENDT0hEbTNXMnFHVmFj?=
 =?utf-8?B?emtzK1Q5dGFGUnhWM0h6TUtGaDVPWllKL0pWVmxIV1VIcTJxclpTa3VOZlV2?=
 =?utf-8?B?TDRkTzQ3QktmVHNVS0c3TlRONzk1OGN3WWVrRG1Yckx2WUNpTnR6NE9Kd3RZ?=
 =?utf-8?B?d2c1UEhaRDArL2ROMElXZUNhdE53VkFFc0xrbkwwbWFuS1kwcmhVKy9sZVZ2?=
 =?utf-8?B?YVI5OTZmbEgyU2htbkRvQmg3MzVRVzFieEdaaGx2aGd1N1MwdTkzOTdsUk5H?=
 =?utf-8?Q?CxueNoPAMrDek1w4=3D?=
X-Exchange-RoutingPolicyChecked: ZQgsMcsfvmNzqZenLr0eBQFSE01ohJfVPMEsqFArMMtp2dILJDgutPPLCSF1l51FWX61wYkNoVz3EZfR7vBancGUBIOBxEZvQkII/j1iqr/cSROS/9XAANvct3kqqqbuM1UL+hCLL/4zR+39niuyijwp8SMgXzNv9EzDtHqybhYLVvTm9y/V2uebKbkMLIqN4SfIQvrkDMLWqjtO3pV7jaOF/VZXuHsAotjpK1Pl0sqT0rAjanw8+117KhBC3y9Q0pPcSBUqYlnIL9IAY+W1KLZqOXw7S/woJo2QwmpgOgfHKsCQDb9BTthHMUv8RBoETIXSAa/+lTKDCPr7MgNNgA==
X-OriginatorOrg: nutanix.com
X-MS-Exchange-CrossTenant-Network-Message-Id: cde53dea-d343-454c-7c70-08df02aeecd8
X-MS-Exchange-CrossTenant-AuthSource: PH0PR02MB7159.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 25 Aug 2026 13:44:03.4673 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: bb047546-786f-4de1-bd75-24e5b6f79043
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: D78lhsRcJhIEqA8QYUDBlEGWT+0f/fF0E+te4cQcgIuhTSXhNVarxkowXUTI2d6tl6fR+6/XxAozPFuEbjSnCIaV0GiTjtymmf+57mzby1A=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH0PR02MB7557
X-Proofpoint-Spam-Info: AW1haW4tMjYwODI1MDExNiBTYWx0ZWRfXwvfFtYAvfE87
 OEpLtJIvtMIs6Ffm8v6u08JeLPsulAUS1NjiptHlFhAUl/+q8oQh2xEO/XyR6d3Yq5ka4fxHJnv
 T3FixDA2ioNdCkPICZ40/FXE2uyBHD8=
X-Authority-Analysis: v=2.4 cv=aJvAb79m c=1 sm=1 tr=0 ts=6a8d9c25 cx=c_pps
 a=kxmFeFNFoFP9kiE4Ycxc9A==:117 a=6eWqkTHjU83fiwn7nKZWdM+Sl24=:19
 a=z/mQ4Ysz8XfWz/Q5cLBRGdckG28=:19 a=lCpzRmAYbLLaTzLvsPZ7Mbvzbb8=:19
 a=xqWC_Br6kY4A:10 a=IkcTkHD0fZMA:10 a=Sv0fKeRqtYgA:10 a=0kUYKlekyDsA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=VofLwUrZ8Iiv6rRUPXIb:22 a=1L6crL_YRTbalZ11mEUO:22
 a=64Cc0HZtAAAA:8 a=20KFwNOVAAAA:8 a=pnBmNuUOYQARQnUSyu0A:9 a=3ZKOabzyN94A:10
 a=QEXdDO2ut3YA:10
X-Proofpoint-GUID: lJcNE0qsb04C1AmDK_ZfJq1SwWfkw6sh
X-Proofpoint-ORIG-GUID: lJcNE0qsb04C1AmDK_ZfJq1SwWfkw6sh
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwODI1MDExNiBTYWx0ZWRfX3aodbBxt4EMF
 3PL3MlaPVZT5XU+a0MXuCMuU6yGG3eW/h+XlSjbMFbxQjE7acfTJI6K3ervMe7Af83p/7f3oAAx
 iBWvwplMkTAjbcnbE81+6dja9bZVYn1VEcd46nIiHEYiJqYhZTY9qW5FlyI7Xq5x1QvMXRBGmpz
 hEpiGQQdA/ifOxd8z0OkTUcGzGQeXJxsLF7iIFHXRurzDvt2iiVmaFBW0FD2ctFq1UvZPMEu8u0
 8c22t8e8QIsbxzos2pRFPpPkWWIlJxI8+/ukK/IxgMepwqqnFsTFO6oxTevaGgib1p5oDW2wEia
 kewe5tOaEaG1dQxiWmAEwU3UKBg57q0rXb/8xtrDm+zOG/G5EIWteG1iDOWWksyiAdq4M2PSGJl
 2N7CA/nvcBaR3Q+LzwtatAdN3kTBEON5SvLHqddI/il9b87U4Z/n2LvhMhRCfCzFW8tlz+Wj9ud
 s84PApuN6PJGypcYQ/g==
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

Since the objects referenced by acpi_pcihp_init() do not inherit from a common
class, add ACPI_PCIHP_IO_BASE_PROP and ACPI_PCIHP_IO_BASE_PROP class properties
to each referenced object and remove the object properties manually added in
acpi_pcihp_init().

Signed-off-by: Mark Cave-Ayland <mark.caveayland@nutanix.com>
Reviewed-by: Marc-André Lureau <marcandre.lureau@redhat.com>
Reviewed-by: Daniel P. Berrangé <berrange@redhat.com>
---
 hw/acpi/generic_event_device.c | 10 ++++++++++
 hw/acpi/ich9.c                 |  6 ++++++
 hw/acpi/pcihp.c                |  5 -----
 hw/acpi/piix4.c                |  9 +++++++++
 4 files changed, 25 insertions(+), 5 deletions(-)

diff --git a/hw/acpi/generic_event_device.c b/hw/acpi/generic_event_device.c
index 9e9416d406..67c9e9b3e8 100644
--- a/hw/acpi/generic_event_device.c
+++ b/hw/acpi/generic_event_device.c
@@ -11,6 +11,7 @@
 
 #include "qemu/osdep.h"
 #include "qapi/error.h"
+#include "qapi/visitor.h"
 #include "hw/acpi/acpi.h"
 #include "hw/acpi/pcihp.h"
 #include "hw/acpi/cpu.h"
@@ -608,6 +609,15 @@ static void acpi_ged_class_init(ObjectClass *class, const void *data)
 
     adevc->ospm_status = acpi_ged_ospm_status;
     adevc->send_event = acpi_ged_send_event;
+
+    object_class_property_add_uint16_ptr(class, ACPI_PCIHP_IO_BASE_PROP,
+                                         offsetof(AcpiGedState,
+                                                  pcihp_state.io_base),
+                                         OBJ_PROP_FLAG_READ);
+    object_class_property_add_uint16_ptr(class, ACPI_PCIHP_IO_LEN_PROP,
+                                         offsetof(AcpiGedState,
+                                                  pcihp_state.io_len),
+                                         OBJ_PROP_FLAG_READ);
 }
 
 static const TypeInfo acpi_ged_info = {
diff --git a/hw/acpi/ich9.c b/hw/acpi/ich9.c
index d6df8db21f..8082eae428 100644
--- a/hw/acpi/ich9.c
+++ b/hw/acpi/ich9.c
@@ -400,6 +400,12 @@ void ich9_pm_add_class_properties(ObjectClass *oc, ptrdiff_t pm_offset)
     object_class_property_add_bool_ptr(oc, "x-keep-pci-slot-hpc",
                                        PM_REG_FIELD(keep_pci_slot_hpc),
                                        OBJ_PROP_FLAG_READWRITE);
+    object_class_property_add_uint16_ptr(oc, ACPI_PCIHP_IO_BASE_PROP,
+                                   PM_REG_FIELD(acpi_pci_hotplug.io_base),
+                                   OBJ_PROP_FLAG_READ);
+    object_class_property_add_uint16_ptr(oc, ACPI_PCIHP_IO_LEN_PROP,
+                                   PM_REG_FIELD(acpi_pci_hotplug.io_len),
+                                   OBJ_PROP_FLAG_READ);
 }
 
 #undef PM_REG_FIELD
diff --git a/hw/acpi/pcihp.c b/hw/acpi/pcihp.c
index 87162ff2c0..a91f523c93 100644
--- a/hw/acpi/pcihp.c
+++ b/hw/acpi/pcihp.c
@@ -502,11 +502,6 @@ void acpi_pcihp_init(Object *owner, AcpiPciHpState *s,
     memory_region_init_io(&s->io, owner, &acpi_pcihp_io_ops, s,
                           "acpi-pci-hotplug", s->io_len);
     memory_region_add_subregion(io, s->io_base, &s->io);
-
-    object_property_add_uint16_ptr(owner, ACPI_PCIHP_IO_BASE_PROP, &s->io_base,
-                                   OBJ_PROP_FLAG_READ);
-    object_property_add_uint16_ptr(owner, ACPI_PCIHP_IO_LEN_PROP, &s->io_len,
-                                   OBJ_PROP_FLAG_READ);
 }
 
 void build_append_pci_dsm_func0_common(Aml *ctx, Aml *retvar)
diff --git a/hw/acpi/piix4.c b/hw/acpi/piix4.c
index 9b7f50c7af..1d209ac96d 100644
--- a/hw/acpi/piix4.c
+++ b/hw/acpi/piix4.c
@@ -607,6 +607,15 @@ static void piix4_pm_class_init(ObjectClass *klass, const void *data)
     hc->is_hotpluggable_bus = piix4_is_hotpluggable_bus;
     adevc->ospm_status = piix4_ospm_status;
     adevc->send_event = piix4_send_gpe;
+
+    object_class_property_add_uint16_ptr(klass, ACPI_PCIHP_IO_BASE_PROP,
+                                         offsetof(PIIX4PMState,
+                                                  acpi_pci_hotplug.io_base),
+                                         OBJ_PROP_FLAG_READ);
+    object_class_property_add_uint16_ptr(klass, ACPI_PCIHP_IO_LEN_PROP,
+                                         offsetof(PIIX4PMState,
+                                                  acpi_pci_hotplug.io_len),
+                                         OBJ_PROP_FLAG_READ);
 }
 
 static const TypeInfo piix4_pm_info = {
-- 
2.43.0


