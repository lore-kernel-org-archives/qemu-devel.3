Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E1FB0C8303F
	for <qemu-devel@archiver.kernel.org>; Thu, 28 Aug 2025 11:13:26 +0000 (UTC)
Received: from [::1] (helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uraYM-0000Vc-SL; Thu, 28 Aug 2025 07:12:31 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mark.caveayland@nutanix.com>)
 id 1uraY4-0000Kn-B3
 for qemu-devel@nongnu.org; Thu, 28 Aug 2025 07:12:08 -0400
Received: from mx0b-002c1b01.pphosted.com ([148.163.155.12])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mark.caveayland@nutanix.com>)
 id 1uraY2-0005aL-GX
 for qemu-devel@nongnu.org; Thu, 28 Aug 2025 07:12:08 -0400
Received: from pps.filterd (m0127842.ppops.net [127.0.0.1])
 by mx0b-002c1b01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 57S9n9xK1758810; Thu, 28 Aug 2025 04:12:04 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nutanix.com; h=
 content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=
 proofpoint20171006; bh=mJyHaxDaoCTIveZgNIzqGivkD8tmG9DEtYNbbzgiq
 4w=; b=Y60EYpdtOc4wzzYKDUrF2dqX7B0aOvudSwU3RTlCnTbyYXF37ANhvsGbg
 b3U6wiltN4NqPiol1FcyLec2Ts7lTHMAFbFP8+Xtve8Vnk/MiI+o0E7kp5cDdlMy
 wiQ0AGpU5biWDhaP0PEKZWnnrUKGS/ZrN5UjUvSZ+mbVlVZAH0INtr/PGphE6OCV
 PUXNDA5YLgaIu7SvgTQF7C7bmuoyy7+e0jq1ayYQBsNeXBoFXuROlTlUELU3x4Aa
 4iF6eZTRNWRM8sthOXEfxY5l+y9Cbn+XxD8npnrW+c92AoydznRf9ZyRQG+Bxxb4
 TSRToZcklDgTi8dhLc6Xk1gTSua4w==
Received: from dm5pr21cu001.outbound.protection.outlook.com
 (mail-centralusazon11021072.outbound.protection.outlook.com [52.101.62.72])
 by mx0b-002c1b01.pphosted.com (PPS) with ESMTPS id 48t00vjx33-1
 (version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NOT);
 Thu, 28 Aug 2025 04:12:04 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=s6qm59xCarVno5qiZg08ToTvv0fP80Z0NayA0lGjznTKFRsJZnXR9GU0RqLROh3SD/KUQLn8/Oho7cyKaJyDJXd/dL9mEMDMCJSI9BHttUUKUmvPpk7zMSNgH1OMywILOeJL6KJO86lmsQN8tpbY8/GI0EZ6hU0zq7f3/nwl0/qb7vYN0jyYEFoQj2Ee6U/ucZ5gNziwRa3GyEOVdHAEyA6yvnjRJ87Uih8FaEX805elZNznWOGeKW7xBrEKesPze0AmhNF+gd2C8bMpmKwPdMZxrj7xqvx4gPjLMzXVsii6gW1GJiVynSI7vPUaL530gC4SHzdwc5RlWuHN8/GIsQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=mJyHaxDaoCTIveZgNIzqGivkD8tmG9DEtYNbbzgiq4w=;
 b=sXcjLU8jZdkIaw8MMmz0XH8wljsUNEXYT2B5xDLZvOUt4TY26/gjMnvDw50b3Jv912dmiLRiXsay1dXQHtJnl9MhuVCV3I1UcCq4GfxD0CfVRcdbtkrYI7dxTia0GTKcxQWnMHX+pJUbuFN/6tETcz+wtjed0/goLadFprmOugi24XJz0H7c5diARkPG62YmjV0Ot57rUpbzaA5gHtRGccbyqllLALPfKGLD1I1fWCmNc1v65XpM5Wnwpr6T2jZ016xGAx93iM56ArC7CgFfgP6MqDOKI022LGXsOdsb0PuBjPfcyymPNTNfawZZ8vMmY3NACY7Knh9BJJPLE3lC8w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nutanix.com; dmarc=pass action=none header.from=nutanix.com;
 dkim=pass header.d=nutanix.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nutanix.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=mJyHaxDaoCTIveZgNIzqGivkD8tmG9DEtYNbbzgiq4w=;
 b=ANPuJvhs/BS/jRkjtXFRzuDESmqx56nlvb2fxQaimhFfaMwnmxzZq8YYtmA/fLkZc2fVTFj0Kf2XTks9cD5VIirtLdmZrcWTQyhFYXCLmTRnktdjdmf4T4Bje8C0HPpjm6DxL1eP6M0w0GXi8clOYQfRT9wmhtb6W3IC8gi0y+YJ43W5NMWRPRULUNVj9ula2UZFgjuNBNE/lYKnaz1Y5fZ9HtU8Wdlp44ToD7/2V4+Yjv8OItsPRI9LjvblDfTp5lBT6rofwwewmeabcIgRTAgtNIacPCenIFXFHFP0mPuAZz2JXIguLXlf754NLnb0gsIXZeQiNBQOUXCpLYchpg==
Received: from PH0PR02MB7159.namprd02.prod.outlook.com (2603:10b6:510:16::8)
 by BN0PR02MB8077.namprd02.prod.outlook.com (2603:10b6:408:149::21) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9052.23; Thu, 28 Aug
 2025 11:11:59 +0000
Received: from PH0PR02MB7159.namprd02.prod.outlook.com
 ([fe80::6cf9:b35c:b143:bb88]) by PH0PR02MB7159.namprd02.prod.outlook.com
 ([fe80::6cf9:b35c:b143:bb88%3]) with mapi id 15.20.9052.019; Thu, 28 Aug 2025
 11:11:59 +0000
From: Mark Cave-Ayland <mark.caveayland@nutanix.com>
To: pbonzini@redhat.com, mst@redhat.com, marcel.apfelbaum@gmail.com,
 eduardo@habkost.net, imammedo@redhat.com, qemu-devel@nongnu.org
Subject: [PATCH v7 18/19] hw/i386/pc_piix.c: replace rom_memory with pci_memory
Date: Thu, 28 Aug 2025 12:10:01 +0100
Message-ID: <20250828111057.468712-19-mark.caveayland@nutanix.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20250828111057.468712-1-mark.caveayland@nutanix.com>
References: <20250828111057.468712-1-mark.caveayland@nutanix.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: AM0PR02CA0019.eurprd02.prod.outlook.com
 (2603:10a6:208:3e::32) To PH0PR02MB7159.namprd02.prod.outlook.com
 (2603:10b6:510:16::8)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH0PR02MB7159:EE_|BN0PR02MB8077:EE_
X-MS-Office365-Filtering-Correlation-Id: 93343b23-90ef-4825-e282-08dde623b516
x-proofpoint-crosstenant: true
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0; ARA:13230040|376014|1800799024|10070799003|366016;
X-Microsoft-Antispam-Message-Info: =?utf-8?B?NEl4T1ZTb0haSXFVTnRxZFpuUVYvSkx1RkY3ei9VYmxkNmdrTmJ1MFlSQWJ5?=
 =?utf-8?B?NWd2MFVNdjFYSS9HWS84V2NBNlBwK0tJNjBmT3c1UWorb09wNTRxMk0rWWFq?=
 =?utf-8?B?dmFId3h4a1plSGhEbUhiaFh1ekJsUEJTK1VnRlRsd0VNYVJ1VmdpN2lVYkVU?=
 =?utf-8?B?MERCRDhtWk45TjAzdDVpM0E5NzFrNThoMVRjQUtTMjhzVVcwVWJkdHhXZVJS?=
 =?utf-8?B?SlJGaXgvTXFWRmpOKzdhOXpDUFlsSEVLUXJGYlZ0dW5ycWVlU1c1aTVTR3g5?=
 =?utf-8?B?WTgxY0JybE5NT1FvNzBrVGZiY1JOSEVDalZOdFZyeW1CQmJ2bk43TG4yZSt1?=
 =?utf-8?B?SHdESzBaaE16VGFSWWhjTXhSdEttanA4bW9GQ0psRHJnSVVXTzY3QjNzdXNh?=
 =?utf-8?B?OXJobkdETnhubjdqYWN4ejdEV3g3MWh0WU9RU0t6Q0JnY0NXVi9udWFuNXdH?=
 =?utf-8?B?RksyREZ6aFNPQlFjQXRqNzRSU2xjanVUQ3NiYm1UOFNyYkxzdnREZDlGUmxp?=
 =?utf-8?B?VDl2WVdqNzJCeUNmYXJlcE1ERWJqYmdmdVdmRytFK0I5R1plMkNMUHkzaWIx?=
 =?utf-8?B?aVFDaVdIZlRGOXhKMkc4Qnk2Tk9YWnB3Q0tibWxlL0lsZFZnVFBIKzhZb2Vs?=
 =?utf-8?B?dEs4NnFXU1RBZ0dOSmJBUFNrMmNVTUNtcTJOZk5WUC94SGVRYi81cU9JZzVP?=
 =?utf-8?B?REpnNjd1M0ZreW5QelBVWVUrQnMvVmgxbS94UXgyUWQvYVNqQzdoM1B1NHc1?=
 =?utf-8?B?T2hHTm5XR214V3FSU0Y3Z2ZLT25iTDdRblRVSTIrSGl1eGVsakhMeVV1RmYy?=
 =?utf-8?B?WGx1aUpWZmU5dDF3amJraHZmVzlQdjFhVTBVMzFXRGQzcjN3L2tIU3g2T2VN?=
 =?utf-8?B?Q3pvNk1Ha09WNDhrZFphMVBKUHJKZ21lM0ptUWlqVWJ6enl4OCt0ODR1SkMw?=
 =?utf-8?B?MGpYeE9BckVma01yeUpOYUEweDRrZ0tnN1VhSmhZcWl4QThpMmg5SnYvbjl1?=
 =?utf-8?B?MFNKZ2g4OHc1T0lNNmpkRTYxNmZWaWJnR3c4RWlXRjFTeTdtd0VVblFiR2hV?=
 =?utf-8?B?cnZvYVFKcnNpUEtDQUw5a0ZtU05KaWpaUEp5MllIM3dXY2FZeVNyWVF2amFj?=
 =?utf-8?B?VHVweWMvWEtTN29rY0xvdzkraVQ1SG5ZcjM1b3NhZWZuUGJyNld0SzFSMFVY?=
 =?utf-8?B?NnlZV1VEUFFxbkJnUldsSjJjU2djMTNzSDdwUmhuN0hWbUp2NUdKVmt4M0N0?=
 =?utf-8?B?VTc1cytWZERUUDhXaFUxV3pXTHRQeTk1akphK3lLbktkanp2VGJjMWpIZkhr?=
 =?utf-8?B?RERBK0s0cGtpQVhYZm5JOVppeTVTS0Q0UDBjS3owVW82N3VoQ0E2T3BCenhI?=
 =?utf-8?B?L0l2eEk2ai8rRmM3d0UzZ0Y2eXMyWHB3bHhyd044RFRUSjNyY2ZBTGlyODgx?=
 =?utf-8?B?VldhVEM5K2ZMM3hKRzJqKzVVb3ltb1FLSlNlZStjUXlPZUhrc1ZNRWVXalhZ?=
 =?utf-8?B?RzRUcDIzYklJalc0TWdMd2tKM3Q2OTVFdWd5bTlFdXlIczk3QkNLT1FqL1U0?=
 =?utf-8?B?S3JYMzZJdlZTVHEwYWZtN3B0YURvU2NEZzI4eTFMNVB3UlVaVGtURHExMVNN?=
 =?utf-8?B?WEV3dVJHL24waExzdjVXMG44RzVSVEw1aEdmMm1aRGFpb3VhYmQ4czNBTFNF?=
 =?utf-8?B?S3ZQOThUb1BWaXorTHdYOEN0MGlIM0RMa0tHMzE2UEVmWlVncFQ3Z3lTSFdy?=
 =?utf-8?B?YmVBeHg4eDhYcWFaU1cvTldWY2hwWjNUaEw5Q0grN3JZVTVkTG5vWFJzRWF0?=
 =?utf-8?B?blZjZTNnM2dPaUpzMUNBMkRQT2cveGFJY0JlSEplRlFITGdtL3cxQXgyRGQw?=
 =?utf-8?B?V044d051ZDVodFh4dTFybGo5Q0lKZFRIS3l0U2VKWC82Wk1hdjRzVWJ1NUs1?=
 =?utf-8?Q?TQDK2a/t73E=3D?=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:PH0PR02MB7159.namprd02.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(376014)(1800799024)(10070799003)(366016); DIR:OUT; SFP:1102; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?em1qZ0poTGZpU3FFZWQ1eXNnRWtRUVhwY1lITEw4QUFIYVVSbnhRZHl0L3dZ?=
 =?utf-8?B?YnphV1NCMkgreWRXOTZkWVpvM3NqYjJIb0JTcGw0TE5LVDlRUWsyaEgzY3lk?=
 =?utf-8?B?RURCV1RNNk1XaGpTbTR4VlkzZFJ1dW5oTWFkUlJVZXFjQjE0NlJLQ3M4aGp0?=
 =?utf-8?B?ZmsvcHBGUHVtN2xuZ3J2ODAzUkxsb1lVTG05LzBrVWZUTEVEVXUxRU9LeWo4?=
 =?utf-8?B?VnBwdE9sL3FpYjVUN1pSSVJOc2lXcnRzVlhhMEJrb0VHdW9aTDZRQVU3Ui9W?=
 =?utf-8?B?dWtXdXNreUJmb3ZsK0lIbzV6TUloRmswSUh0cktxQjhLUExPbjdvWk9zaFM3?=
 =?utf-8?B?VDZ2alZITTU0Slpxc0tva3g2d3JiMjF2S3EzNzN4a3U0Ti9PSFdxdjhVelRY?=
 =?utf-8?B?NHNJczF0Y0NRRTg0NE9MSzdsc1RhelZjelVKdlA0QmtLQWxpYURNeVAyLzFQ?=
 =?utf-8?B?MGZ3MExYWG1ER002eEJ1c2FQZ21ZcUNYRlNXL3FzUWFRSGVxamhTT01oY3I5?=
 =?utf-8?B?Wi9mT3dOWFQ2aXpmZmhSQW1tYy93R1E1RjVqay9pZE5iZm5BWlNkRlFjZUtB?=
 =?utf-8?B?NE51TFR1YWQybFRiYVE2NFhZUEc1Tll2OGFPSXl4Mmd2N3E4dnpDa2pXcUM4?=
 =?utf-8?B?OWlQTHFaTFQ4c0dXenhqSE41NzNPSUp5dEtxTVdvUjExRUtZditnaGhDZ2dW?=
 =?utf-8?B?aStQTUswb0NDODJDQ3lJeThtRmFzVWNvV0RublMyT3pBb3JBOW92MU9kSjZS?=
 =?utf-8?B?TXFVSGZGbHZ0Z2IyZ2dUUWZCWUhNOGE0L3BuU0FVV3ZxdUloKzNaVFYzZ1VL?=
 =?utf-8?B?TXVqTjRUMVlkYXNiR1dlM1hxUGNnTS9vWWQrZ1NYaG9GalNVUndxOHcvcFFD?=
 =?utf-8?B?Y0ZDWnRzMFJEcWF2TmxmUjA0MTlhcHErMVliWTIvL1VOMzh2bUpNL09zVWtR?=
 =?utf-8?B?djNadmZzVlVDWEZ1RWc3OWRmekxwcUN6bHA5bTAzeG8yMVlSejM3Snp1MGpq?=
 =?utf-8?B?VjE3VVF1SFNISCtHeWFxSEVEUXo4Qm95OWNNV0EyVm5lb0NSSXVmdHB2a25k?=
 =?utf-8?B?VWZmSUZhL2VvRmt5Qmp0RmJjVUIvNHpxSzlQZGxFUUlQS3pBemhsRHduSHJE?=
 =?utf-8?B?OW4rL1VWVlNMVElUZHdoSGhwdFloWlJ2bnY4SnNQMmd6aTNaSGVGc0NJL2w0?=
 =?utf-8?B?NVJqZU5zRU5hMVllV2xWNERYeWFlSWlHd0RNVm9iRkRzMEF1MTluQ1psd0Y3?=
 =?utf-8?B?ME1Bb3EwQWY4Z2xyYWhZTVo2L3BoSDVzOVFycmdtMkp3eDJTcW0veUI4K29Q?=
 =?utf-8?B?SGx5aHQ1ZWpQcURPaHI2c2p4ZVIxTndDMkZGWXd2NVgvM2dpU3MrUEJjYURW?=
 =?utf-8?B?ZSswT2E3QmNqM0F1cjI0MmdzbkhxVDJwUWdpVDdaNUtIblVIU3RtMnk1RDRp?=
 =?utf-8?B?bDFSM3hHbXhHUGczcCtPTjE1V0ZxVGRFWDQzbldNelpXdnNtajNnSkt0YVhz?=
 =?utf-8?B?VkQ1VkIwL3MyYWYycGg5UVh5WjFCeUJqV1U5T0E4bFp1bFNwYllDZ2trdExF?=
 =?utf-8?B?My9PQnlzeHh5dFJaQXpmLzFaZi9EUjRqbjI3T3dOUTgvajRNSDZlZVY4TzRj?=
 =?utf-8?B?ZGV2RkRrbVZJOUcvZ2NXeXE4YTdGV3o3TDBrc29tUEJXSVBReWJpSVhvTDlq?=
 =?utf-8?B?M2dJWmtqRTdXY0c5MVRZaDRIRnVZRmFsUXFvV2ltQ0pqU3F3bEY3VXdFMjAw?=
 =?utf-8?B?cUhwazlyRjhjTjZwOG1TUkJ4a2JlTnd3S3VnT2cwTGtBeGk2OWxPUmc3d24v?=
 =?utf-8?B?UVlSYnhsWWVZWjhjZ2FscDg3VW5Xb054TjZJRHdRQmdZRHhkZDRDOHA3VkR6?=
 =?utf-8?B?cG1iVzlSKzBIeHEzOUZMWWFlMXhDMlJLVFc4NWJPZWhVNk84UEZhUnR2UCsr?=
 =?utf-8?B?bTJzM3FKTkVGRE9uczVuR3lyZ1NGVGhMYnU5WGNpZTIwVUhrTSs1N0xKSml6?=
 =?utf-8?B?UG9mS3ZIalNmaGlkQVNvVVlkUjNGTkdWL1Npd1MzeE1uMW5GMFYzRWxuUjY4?=
 =?utf-8?B?cGFDcHFIRUdlQjFpak5lbXlwZWdtRElHRWMvV1BkbW0rYjU4S0JCb3JIT3d0?=
 =?utf-8?B?dWtPSUMxM0FWU3ZWUlBoV245ZDZrZUVwa3lKTkwvd0hQQldMR0VjTHdQTFl0?=
 =?utf-8?B?Z0dPZTB2VXRPQXFsRHd0ZFVXUk1YMFZrOGU5ckx2NDRPMHk0bjJDZkJlRlNF?=
 =?utf-8?B?UWErUWZtdVFsSTBhamhMTGJXUW5nPT0=?=
X-OriginatorOrg: nutanix.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 93343b23-90ef-4825-e282-08dde623b516
X-MS-Exchange-CrossTenant-AuthSource: PH0PR02MB7159.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 28 Aug 2025 11:11:59.3578 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: bb047546-786f-4de1-bd75-24e5b6f79043
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: p/qwblWHUNXV23BXYuvYxz8AqcImWpsX3lYPBr0yveNkgHmhfLN4WE+nxRY8J9gCQI8/JsZeDaV9zs2gkLbULt8E0s0IJsjR5eCURFmr1Us=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BN0PR02MB8077
X-Proofpoint-ORIG-GUID: U4_bCH6XqrdXlkOTmqAyOCg84uIYaR_4
X-Proofpoint-GUID: U4_bCH6XqrdXlkOTmqAyOCg84uIYaR_4
X-Authority-Analysis: v=2.4 cv=C9vpyRP+ c=1 sm=1 tr=0 ts=68b03984 cx=c_pps
 a=F9Mk9h/5U8Q1eoeBjDhbew==:117 a=6eWqkTHjU83fiwn7nKZWdM+Sl24=:19
 a=z/mQ4Ysz8XfWz/Q5cLBRGdckG28=:19 a=lCpzRmAYbLLaTzLvsPZ7Mbvzbb8=:19
 a=wKuvFiaSGQ0qltdbU6+NXLB8nM8=:19 a=Ol13hO9ccFRV9qXi2t6ftBPywas=:19
 a=xqWC_Br6kY4A:10 a=IkcTkHD0fZMA:10 a=2OwXVqhp2XgA:10 a=0kUYKlekyDsA:10
 a=64Cc0HZtAAAA:8 a=KKAkSRfTAAAA:8 a=QyXUC8HyAAAA:8 a=VVXk-92eaM9LjyQm6BwA:9
 a=3ZKOabzyN94A:10 a=QEXdDO2ut3YA:10 a=cvBusfyB2V15izCimMoJ:22
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwODI4MDA5MyBTYWx0ZWRfX4b5qdjOXslgM
 fjD2fgUOXc9C4TwVSWJc/0yOUEgPvvgldjnIjdkA9K//XET/SKk9WxYvim7OKI7YnCPU8k25JDa
 VJc5dRI9KTh3Ahm7U+zBGeb8j1SIPLVx2Ynf7PPj5TjM5KoudPLWexFS+JHP19vARz4tFeiIyHx
 4Tcn32KNaIVWPCDA8FxU6zkw1smsRCQdUBZiy3WDqoR0SvhoVDQJQATd/EUfZTqnWqNc8Ss8I2h
 zq5o/IDpUBZHHsXguozSDh8PfN60nE07Oaj8/x5IgKNWOr0iOhNIYqeQxxxZYGjRvcMgvfpJGzg
 hqC5Ace0x9HJAYYXjoyI4NEw+E/Fw1/cMmznLi/T2INj4ZZl6bCeBHSeQY7n9U=
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1099,Hydra:6.1.9,FMLib:17.12.80.40
 definitions=2025-08-28_03,2025-08-28_01,2025-03-28_01
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

Now that we can guarantee the i440fx-pc machine will always have a PCI bus, any
instances of rom_memory can be replaced by pci_memory and rom_memory removed
completely.

Signed-off-by: Mark Cave-Ayland <mark.caveayland@nutanix.com>
Reviewed-by: Philippe Mathieu-Daudé <philmd@linaro.org>
Reviewed-by: Xiaoyao Li <xiaoyao.li@intel.com>
---
 hw/i386/pc_piix.c | 4 +---
 1 file changed, 1 insertion(+), 3 deletions(-)

diff --git a/hw/i386/pc_piix.c b/hw/i386/pc_piix.c
index 627de09c70..7e78b6daa6 100644
--- a/hw/i386/pc_piix.c
+++ b/hw/i386/pc_piix.c
@@ -113,7 +113,6 @@ static void pc_init1(MachineState *machine, const char *pci_type)
     GSIState *gsi_state;
     MemoryRegion *ram_memory;
     MemoryRegion *pci_memory = NULL;
-    MemoryRegion *rom_memory = system_memory;
     ram_addr_t lowmem;
     uint64_t hole64_size = 0;
     PCIDevice *pci_dev;
@@ -193,7 +192,6 @@ static void pc_init1(MachineState *machine, const char *pci_type)
 
     pci_memory = g_new(MemoryRegion, 1);
     memory_region_init(pci_memory, NULL, "pci", UINT64_MAX);
-    rom_memory = pci_memory;
 
     phb = OBJECT(qdev_new(TYPE_I440FX_PCI_HOST_BRIDGE));
     object_property_add_child(OBJECT(machine), "i440fx", phb);
@@ -224,7 +222,7 @@ static void pc_init1(MachineState *machine, const char *pci_type)
 
     /* allocate ram and load rom/bios */
     if (!xen_enabled()) {
-        pc_memory_init(pcms, system_memory, rom_memory, hole64_size);
+        pc_memory_init(pcms, system_memory, pci_memory, hole64_size);
     } else {
         assert(machine->ram_size == x86ms->below_4g_mem_size +
                                     x86ms->above_4g_mem_size);
-- 
2.43.0


