Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 02276E69188
	for <qemu-devel@archiver.kernel.org>; Fri, 22 Nov 2024 18:54:57 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tEYn5-0002JZ-G1; Fri, 22 Nov 2024 13:54:03 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <nathanc@nvidia.com>)
 id 1tEYn3-0002J2-An; Fri, 22 Nov 2024 13:54:01 -0500
Received: from mail-dm6nam11on2061f.outbound.protection.outlook.com
 ([2a01:111:f403:2415::61f]
 helo=NAM11-DM6-obe.outbound.protection.outlook.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <nathanc@nvidia.com>)
 id 1tEYn1-0001UP-61; Fri, 22 Nov 2024 13:54:01 -0500
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=ERFgWGL9mYqDryFfnVQBx+JK3HU6UI2UUS0U8Xg8rDbs4ViadUs27WDCdcf9ACqydGNlRsCIOvRUJIQ1dB//BpsP3WExw43mf17XwgbaHpMq8PDh6rFmy9hHW/yRvKxuGFxw0mCTebDWHJii0eEKmLZnPJG2SMlag1t/yGp2n78xupWV3UIIxpCHpfd4oIHI47g10VSwInE+XjqMmAxgPySFP+nGDRdhsHIIpRgecZo1nSu0GSpESHoRp+r3Sc21MaSrUAfgatr0Qf/ewiAnI4yB4ypSl5Sj6Pxh1X7F4GHOFU6U7dOIL8Q6teAjEledTwiiEILdgXeFhovJjFqjxg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=8gIwyjrIykRVEOr9+VLXtJk8zrZqthLPbRbkbC4XwUE=;
 b=SfvbwgxOwCaVkZQQwtCFtt3JtAvHwV5k9qJvaiIO4Zk+vxDh+BoGmnjGPoOclJv6TrmtNMRgqlzr5QclxCqd/3PVVQUY1UI9LOcgg1FvKBqcm0YOMm6+/JmdwpiP3Tp4jzwXROo1oL9nVRacVtb3dEqCihOB1VHw2ABtRmfAxZ7ZpQdbeX5fiEdsMjCOsICQ/zhPrvoQyPG651juec5iZ4iNbTDRYWccJ0MoTt2gkThLE6k0pILun0LFaD2cCEysBsALgeotcJiIV1w6mzuL2O2ILQeyClvDIkfNFuo3LutQRvmuk3mh9/iHB22b503UVqLTItG/MMTiPGTvLK+A/w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=8gIwyjrIykRVEOr9+VLXtJk8zrZqthLPbRbkbC4XwUE=;
 b=b0CeGrDWINS1gY4vn9duU2Nnbyu9YpUCwODP4aoekLJ9S0FU045tHbL0Zuo+eWWbOYKtqSQBBEpiNx25VSU9jalih/td7bL2TDlpjiPRH84EEbwfCUDw7La03j4Emg6pZEJx15wsWXp5hWvrpOmBeGHpVnw49zcc2ewjI8JV9w8yC3Q4gIxvVYkTesXEu0k/d7Rwi76uuKYDLf5Iad3rABDmuaeXFsY5l0M1G4tsjS3U8M076iZRlTNWg82SUUu1v4VMJIzyZesaYQiSGzII162XiudnOxtLekyLR+d6JvGb1DOQvrtDu+hS+wmbPxi6tLy6m47KslL7KtBhj1qDuw==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from SN7PR12MB6838.namprd12.prod.outlook.com (2603:10b6:806:266::18)
 by IA0PR12MB8840.namprd12.prod.outlook.com (2603:10b6:208:490::13)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8182.14; Fri, 22 Nov
 2024 18:53:49 +0000
Received: from SN7PR12MB6838.namprd12.prod.outlook.com
 ([fe80::529d:478:bc5d:b400]) by SN7PR12MB6838.namprd12.prod.outlook.com
 ([fe80::529d:478:bc5d:b400%4]) with mapi id 15.20.8158.021; Fri, 22 Nov 2024
 18:53:48 +0000
Message-ID: <b3e93a16-24df-4ffa-9214-f41383844e48@nvidia.com>
Date: Fri, 22 Nov 2024 10:53:46 -0800
User-Agent: Mozilla Thunderbird
Subject: Re: [RFC PATCH 0/5] hw/arm/virt: Add support for user-creatable
 nested SMMUv3
To: Shameerali Kolothum Thodi <shameerali.kolothum.thodi@huawei.com>
Cc: "qemu-arm@nongnu.org" <qemu-arm@nongnu.org>,
 "qemu-devel@nongnu.org" <qemu-devel@nongnu.org>,
 "eric.auger@redhat.com" <eric.auger@redhat.com>,
 "peter.maydell@linaro.org" <peter.maydell@linaro.org>,
 "jgg@nvidia.com" <jgg@nvidia.com>, "ddutile@redhat.com"
 <ddutile@redhat.com>, Linuxarm <linuxarm@huawei.com>,
 "Wangzhou (B)" <wangzhou1@hisilicon.com>,
 jiangkunkun <jiangkunkun@huawei.com>,
 Jonathan Cameron <jonathan.cameron@huawei.com>,
 "zhangfei.gao@linaro.org" <zhangfei.gao@linaro.org>,
 Nicolin Chen <nicolinc@nvidia.com>
References: <20241108125242.60136-1-shameerali.kolothum.thodi@huawei.com>
 <ZzPd1F/UA2MKMbwl@Asurada-Nvidia>
 <2a61079f-a919-43b1-906a-bae8390bf733@nvidia.com>
 <04024d09ebad4d83ab0679f6bb3b3774@huawei.com>
 <d2bc4fdb-3188-4063-8ead-f2ccefec9c81@nvidia.com>
 <4f657876547f4001935f7314ecb8f8ca@huawei.com>
Content-Language: en-US
From: Nathan Chen <nathanc@nvidia.com>
In-Reply-To: <4f657876547f4001935f7314ecb8f8ca@huawei.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: BY1P220CA0015.NAMP220.PROD.OUTLOOK.COM
 (2603:10b6:a03:5c3::10) To SN7PR12MB6838.namprd12.prod.outlook.com
 (2603:10b6:806:266::18)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SN7PR12MB6838:EE_|IA0PR12MB8840:EE_
X-MS-Office365-Filtering-Correlation-Id: 03f455b8-e7d1-4f9a-b0cd-08dd0b26ffd1
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|1800799024|376014|366016|7416014;
X-Microsoft-Antispam-Message-Info: =?utf-8?B?S1hWa0t4T0t5NnIrT0lxK3hXeGRucVFUZittTmNsU2FkZnhzaEw0eFJxM0Ni?=
 =?utf-8?B?VkN1Z3VxUXdTUEVFTHMvNThNbHNRNlNvMTNrNHdSZUxiSk9KdEZ1ZjE2YWg4?=
 =?utf-8?B?bzU4T1J2UEQwcDFDVk1jNm1tM0VKVkNZRnZWNFpFV2RlZllxSzlNT1VWc2wx?=
 =?utf-8?B?Y3labkQ2QzdHYWlsbWFUOStJbFB6U0ZrbkxqLzZBcVFGNHlrc2c1VUJCenht?=
 =?utf-8?B?UDBhRG1oUEhDUmZpYWJ4SHBvcmhYSmNQVjN0Q2xybStTOTYwb3hJU1AxWXJL?=
 =?utf-8?B?VUZPeWhZcml6eHpONHc0Y1RMRlRvRGFjT1Y4TmtnQ1F3MWNIQU95Z1FQeXdJ?=
 =?utf-8?B?UjJZdjFRWU4zemJRTkYyUVJ6dk53SjI5MENydGUyNVFGcTNpc3IralYwa0Zp?=
 =?utf-8?B?ZlRJU3Rrdjd4aEpCL1V0eVBWOTI3dFEvZjY4eS9rcWwyQ1dhR29JZ2NlbXh6?=
 =?utf-8?B?Rno5ZHdTSXY1cXVuTlFUNXp1N0kvTVhTQUlUS3FUV1NSTE1pa0lJbE5qNXR0?=
 =?utf-8?B?alAwN3Rrc3JWSkJvOWFqM2h3VDlMWWpFY0RlcEdsMGZ4RTB2TjFocW5GeDV3?=
 =?utf-8?B?TFpyUEtDSVRrc3IxNHBwNHZRZ09DNU9yajR4ejdMZE9VNDFoR1duNWpIYy9u?=
 =?utf-8?B?akxZMXFOS1BBREc3SXU1SjFRL2JaYWpmaXVSK0hjQU0rTmo5QnkxaXhQcmMz?=
 =?utf-8?B?SndBaWttQWYwNXlpODlLZ2Y5NUVGYVJ0emFUV0UzVjE5S1k5QnlKUGdnL1Rn?=
 =?utf-8?B?TmZjUk10akNRdVRtNTJMYXhjUExBbHp5RFNZdExhN1VjSTZjUjVKZVJQWk40?=
 =?utf-8?B?T1FnVGtlUmxyUFJnUXRLTFZubmJOcnJIMXFKcTIxRXRIRVEzUXNpV05IUUc3?=
 =?utf-8?B?TE4vdzVMK2tsaFBBOVZLU3JFa2hTVTgvM1BNUEtkWm5MNjFYTzBXbnZwUGhT?=
 =?utf-8?B?Y2FXNU1RK0VYZDlVWXdETkNDWlBiUDVucW12aVMxTE1vUENCZm90SUNnWWYw?=
 =?utf-8?B?R1d4R2UrYitMelpvTm0yOEZxWkhoZkhuM1NmNGpYZWxzWnhERWpGd25VN3RK?=
 =?utf-8?B?WklpOGJoekVLSUxyTThFSUJPbjhYeTVLbjFvNVRReGpBMVBId2NGQ0xmRzJD?=
 =?utf-8?B?MllIYUxLZjZwWG04TE5WTlVHSnpMZzlhR2VDNXQ0MkhqaDBwNVpPUnFYOU9X?=
 =?utf-8?B?QUJKU3B0ZDRTKzR2Qm1VT1dpY21CQjY5VEVHVmNPckJDVENIOEp3azJJY3d3?=
 =?utf-8?B?L2p2a2J6a2Vqdyt2UUVzNDVRaXlQNTNWK2hrZXZucFVVaG1WL21BL3JXb1F0?=
 =?utf-8?B?UG5QdjVpbnA0T1FoY2RzT2tmdGVkcUhKc3RYYjZkMTA3RllER3ViMEwwQm5j?=
 =?utf-8?B?WVB6dXBGdzc2c3Y4ejFrYWNETXovVlhmdWpDR1RZZy85RFViZHQvSnJHRnRy?=
 =?utf-8?B?a1crVDFUQVorT29hT0dCSnVRTmh5R1MxbThudmhmM0RETmZhbDN3YzV4RSsr?=
 =?utf-8?B?ZnNNM2JsNk5QVDRrL2dpVnRKcTh2bmZSQ3U0TEowMDhaWWJYTEtPQjlpaExH?=
 =?utf-8?B?OU11b3BnRnVBUXJJeEZVYWZVNUk3bnBpMnp1SFVDR0NVTndnaDJKbG5oOCta?=
 =?utf-8?B?ZU0xeUQ4MGFSVmd3em9HWGVpODVMT1dUOElvZUd4ZVZvN1VUS3IxYzBWdEo0?=
 =?utf-8?B?NTFEMDJvaklLNVlGRGhGTlVsWWdqc0VMa2MxOENRVDZxc1lnSUx2ZE9Ea3F4?=
 =?utf-8?Q?fthHxPoaZ8yMrR8PsxNMIahPZRUssP1MLmbgdy5?=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:SN7PR12MB6838.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(1800799024)(376014)(366016)(7416014); DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?Qm91YmhRQnlhTUxQbi9yYi9NUUxjR0l1V1RiQ0N0dXJSMEtjRkMzMXV1Q0NB?=
 =?utf-8?B?eW83RGdNMGp5VFZ5N3BKMkZ4V3VBMUxNTVBnbkdVZU9Sb05aNzlYSEcvMUw3?=
 =?utf-8?B?blR1NjZOaVprdUtwUDBmdlY4ZmlQWis4WlFwR0h4aEp3TnBOM1l1enh3Vmxi?=
 =?utf-8?B?blN6TjB0YVA0REJSWEJvMS9JMEhnRUtKY3F4bHdvOGJzMzJJSGZjdnVaQmpw?=
 =?utf-8?B?WGt5VGdiU0ZkSzBXZlFrLzRiaE1vRXI1QUM4NUpaanBaRksvcTJndFZqbVF6?=
 =?utf-8?B?T1VQMHRSbHNoc2tnRTFpMEROeU9lbTdHbHdreHRacW9XK01nb2NGMmFKRzNa?=
 =?utf-8?B?c2daNCtJTXY5UXVqK0VDdkpmSXRYUWVMek9DTGlaTXFLeEx3SXMzdU11dHha?=
 =?utf-8?B?VHRHU1JlU2Y1NVBVeVBOdkoxMTJhTkxna1Y0Q2h2VW5reXAwZ1FoUDVSazgy?=
 =?utf-8?B?QjRDWVFjNS9oVTVoMWIrYTRQekc1QktMZEF4cWt4UExmcU4yeXFxWEZRMmhz?=
 =?utf-8?B?c1BhTjk5Z0lZUFFFNUN3MDVIYk9pRWdPQmgxcUFpemU1TFBsajNoRk1qUWZL?=
 =?utf-8?B?cGNZM1hUR2M0K2ZWc3pVMEMxeHRmc2RNWktzSnQwelhlUXBmMGdiaTdha0NL?=
 =?utf-8?B?NUdSMzIrQ1JlTnc5bTNIR3Y2bGdOZ2ZPZDdqaHUwM1VUNnR4d3VvdmtRWHIw?=
 =?utf-8?B?b0Z3Z2pTdk1pUFlVMEx6Z2gvUVYrWW1KS1h5TWFLbjNMU1B0anp2SVRENVo4?=
 =?utf-8?B?d3JEUldZa1kwTjdDb09KNTJKc2NVYkZvSThKU0dCaWh0QjFZZWdLU1duZmQ5?=
 =?utf-8?B?NXg4a282OGJEamhjemF3WU9zenlNUDQ1emhhNnhWTlZzcmhSd1dJRWd0dFdx?=
 =?utf-8?B?Mjd3R3RBa1h1RUVhWEF5NnkxT0hRU3hMck51OTk2S2IxOGpZd2VzeEw2VitH?=
 =?utf-8?B?RGdBU3BURFBxNlNBcVBMd080TVJSR1FhbW9yelRaR0YrTXAxcmp3N0lzMHov?=
 =?utf-8?B?Vk5ZZnZIM0dMckNVS1lKNWtIM2h3WVVuK2Q4a0VNVDJhRnR4emR2U2FVUlRU?=
 =?utf-8?B?WkNnWHdkR0Vwb1BidkxoS0FuZnNYSWRkbmlFREc1ZkhqNXhPcFAzMExmZ3pL?=
 =?utf-8?B?eURuZkFjTVVaMnl0THk3YUZRRkozZFJLN1VSeENjaTBjdjE3bFl2TS9mR2hU?=
 =?utf-8?B?ZXdmdDUxOFovMForMldiR2NQVFpyMWJ6VGIza0tsR1lJY3JKa2FMd0JrNHVJ?=
 =?utf-8?B?bTVnbGEvOUw5ckM2NmN3dXhHK3EybTN6Y1pWL1VnSEcrRjFkeE83WW1yR3k2?=
 =?utf-8?B?YWNsbG5aWnd5am1SSVBWVlRuNlFqMlBXamlnK2FtQVJqaVR6dXJ6QUt2aDB6?=
 =?utf-8?B?TFczMVR2T00rZ3BRVUxtMGM2OEEyT1ZOTlptQTd6VGhhQWpJK2ZEd1ZaUmpx?=
 =?utf-8?B?cDh4bmdMUnpJb0tGb280cU0xU2gvOXgrVkI5cHJoWkJ0TTBrM3dqTHVZM2NG?=
 =?utf-8?B?R3dXMVdHckhwalhxOXpWSmxxZC9GclpmQzFNYW8zbStRSWRCcXROcElSK3FX?=
 =?utf-8?B?U2lDS2dmTTNWSU1mcmsreXlMaFZiRThYU1ZFMnlRTy85ejErYUxXWThUY3lu?=
 =?utf-8?B?NGZvM1VnV3RoL3ZIQWw0VWJDWWptOFpoNWVpMUh1ZEIveUVUaGV3Rk1GR0Fl?=
 =?utf-8?B?ZFNjdWN2ZU45aHk1dGNidjkra2dla3dYcG40QTJtTi83TmhacjQvUkNwVEpa?=
 =?utf-8?B?WmN1WFZvYjFaM1hTdkcxY0tHZWpPV2VUemw2aXJsQ2s0S1MxTndKVitQUVdO?=
 =?utf-8?B?QTY5eXU3S05mN2drbzVVRlVTMjgxdFI0WDRNNUFQQzlibzVZaG14d3Zvdkhq?=
 =?utf-8?B?WlJaZ0pVRGRWeGJwMnVjZmtua01jMFVvSVFjQXBCQ1pMR1FOb016S3ZRRDVh?=
 =?utf-8?B?OENiU0NsRGtoMXRBTkN4ZnFFTFRLekdOazRINmpPSkpWQ0psWGYzRnNVQ1pt?=
 =?utf-8?B?S0R3UGR4MisvVVFaYWp1NGhDYU9KK1pSMEFtdTZGUHdsZ0JBVHR3alQ1dVQ4?=
 =?utf-8?B?TzFNcjFDSGxBK0svM2FrKzk2T3BtcDdvZmduZ0x3UVJrSFlDY2JKbVpYQXVy?=
 =?utf-8?Q?uhofDrJjltFcoAglxkEen5Xng?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 03f455b8-e7d1-4f9a-b0cd-08dd0b26ffd1
X-MS-Exchange-CrossTenant-AuthSource: SN7PR12MB6838.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 22 Nov 2024 18:53:48.7951 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: GcYUa5ANpM4IuNOidqcrRjjXcqcIjlAFfwbplxQNMZmicZXADaaJzOhd/XlgxglL+ZHclDDPiZSOdKyV6yASlA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA0PR12MB8840
Received-SPF: softfail client-ip=2a01:111:f403:2415::61f;
 envelope-from=nathanc@nvidia.com;
 helo=NAM11-DM6-obe.outbound.protection.outlook.com
X-Spam_score_int: -21
X-Spam_score: -2.2
X-Spam_bar: --
X-Spam_report: (-2.2 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.143,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 SPF_HELO_PASS=-0.001, SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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

 >  >> Also as a heads up, I've added support for auto-inserting PCIe switch
 >  >> between the PXB and GPUs in libvirt to attach multiple devices to a
 > SMMU
 >  >> node per libvirt's documentation - "If you intend to plug multiple
 >  >> devices into a pcie-expander-bus, you must connect a
 >  >> pcie-switch-upstream-port to the pcie-root-port that is plugged 
into the
 >  >> pcie-expander-bus, and multiple pcie-switch-downstream-ports to the
 >  >> pcie-switch-upstream-port". Future unit-tests should follow this
 >  >> topology configuration.
 >  >
 > >  > Ok. Could you please give me an example Qemu equivalent command
 > > option,
 > >  > if possible, for the above case. I am not that familiar with libvirt
 > > and I would
 > >  > also like to test the above scenario.
 > >
 > > You can use "-device x3130-upstream" for the upstream switch port, and
 > > "-device xio3130-downstream" for the downstream port:
 > >
 > >   -device pxb-pcie,bus_nr=250,id=pci.1,bus=pcie.0,addr=0x1 \
 > >   -device pcie-root-port,id=pci.2,bus=pci.1,addr=0x0 \
 > >   -device x3130-upstream,id=pci.3,bus=pci.2,addr=0x0 \
 > >   -device xio3130-
 > > downstream,id=pci.4,bus=pci.3,addr=0x0,chassis=17,port=1 \
 > >   -device vfio-pci,host=0009:01:00.0,id=hostdev0,bus=pci.4,addr=0x0 \
 > >   -device arm-smmuv3-nested,pci-bus=pci.1
 >
 > Thanks. Just wondering why libvirt mandates usage of pcie-switch for 
multiple
 > device plugging rather than just using pcie-root-ports?
 >
 > Please let me if there is any advantage in doing so that you are 
aware > of.

Actually it seems like that documentation I quoted is out of date. That 
section of the documentation for pcie-expander-bus was written before a 
patch that revised libvirt's pxb to have 32 slots instead of just 1 
slot, and it wasn't updated afterwards.

With your branch and my libvirt prototype, I was still able to attach a 
passthrough device behind a PCIe switch and see it attached to a vSMMU 
in the VM, so I'm not sure if you need to make additional changes to 
your solution to support this. But I think we should still support/test 
the case where VFIO devices are behind a switch, otherwise we're placing 
a limitation on end users who have a use case for it.

-Nathan

