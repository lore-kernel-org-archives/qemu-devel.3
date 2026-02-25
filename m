Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 04C17EFD206
	for <qemu-devel@archiver.kernel.org>; Wed, 25 Feb 2026 08:05:25 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vv9t2-0005CI-LW; Wed, 25 Feb 2026 03:04:50 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <florian.hofhammer@epfl.ch>)
 id 1vv9st-0005Bm-As
 for qemu-devel@nongnu.org; Wed, 25 Feb 2026 03:04:40 -0500
Received: from
 mail-switzerlandnorthazlp170100000.outbound.protection.outlook.com
 ([2a01:111:f403:c213::] helo=ZRAP278CU002.outbound.protection.outlook.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <florian.hofhammer@epfl.ch>)
 id 1vv9sp-0000eE-EJ
 for qemu-devel@nongnu.org; Wed, 25 Feb 2026 03:04:38 -0500
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=OtiwQ5TCUJY4E6ew7JJgtbQ1SN57Nf1hTKTUpK4kwE/cI1wFRS1KwTR79kNwoEH6fz/pwgaEQtgiRD3Q6PotV7os/r1EvtkKv8R3Bxxue4XKrVQalAbS8TNMZN44QZ87K+WPsLEFd4z6o504fqxAkI9rtcln5dJgv/QcpMj478SWs+k+ePCph3u2SjrDIpwR5C8AZpaGTR8yoKgITN9kOMDzWRq3Blg31g0eUexfiRqsd91LTxLesZ7fUFCFD697xsY18FqF3yeDZ+8GPbfWu8ex3uoB6e1y2g2SxdsGPIiCWWv8O+QH/8GUdhMaqi6cz8qxFMZ4eDNRg3mPPKi6tw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=vcuVG/fmQuxTypzkpxuKhlejODf7/AXPYjfdTfOKFNM=;
 b=IbVbTJ/+grQ2zMoB7OuPGPdp1NY8WQ8u2oUIfyY3kOBTNITUSOjHPb6z5lOe65zvGxJy8z+bIrXRl7Js0dcyF982JMvfzpaZAVYmlsyxvoOZ22sFES6P7HbW9zT2p32vPpF0kezu39AS4DPejD22wnfjaGiAAK5tvgpEDmFw4m41eu6ymn1o04Fl6A474GczA9V/MKbNnIdKHoGOnENHeBlYn/jIEc8ytN29d2WB3RCVijjCnFvPr9teHv85LJW/XqIgfLOnrzLQoAiFbPkoDDk1iRd+AvtUMwkCXHNvQqKDKrt3wGZFWu9dQWDC9CVf6hCgt0BmRUCBHXSwMID3Ew==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=epfl.ch; dmarc=pass action=none header.from=epfl.ch; dkim=pass
 header.d=epfl.ch; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=epfl.ch; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=vcuVG/fmQuxTypzkpxuKhlejODf7/AXPYjfdTfOKFNM=;
 b=aV17JAWOyJNEBItzIQcsec/9sbjrFfSyBcKz8U69ADTxcpik3vQkFNyVPkVSBeRFoJPTu0HM5wRuucOgyLCexc+gAADBD3U3vrUC7PaoapiLAhf0k4yrzHlaASpmv/uHhX4MDQxNKd/oHXvDqxGES3MV2LiPZ+hIRDoABVEexB4=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=epfl.ch;
Received: from ZRH2PFAD84B9AF9.CHEP278.PROD.OUTLOOK.COM (2603:10a6:918::220)
 by ZR3P278MB1238.CHEP278.PROD.OUTLOOK.COM (2603:10a6:910:73::6) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9632.23; Wed, 25 Feb
 2026 08:04:28 +0000
Received: from ZRH2PFAD84B9AF9.CHEP278.PROD.OUTLOOK.COM
 ([fe80::80ea:3d03:40bf:998c]) by ZRH2PFAD84B9AF9.CHEP278.PROD.OUTLOOK.COM
 ([fe80::80ea:3d03:40bf:998c%6]) with mapi id 15.20.9632.017; Wed, 25 Feb 2026
 08:04:28 +0000
Message-ID: <ca11b212-e824-4e34-92ac-c6e2af505c0c@epfl.ch>
Date: Wed, 25 Feb 2026 08:55:25 +0100
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v4 3/7] plugins: add PC diversion API function
To: Pierrick Bouvier <pierrick.bouvier@linaro.org>,
 =?UTF-8?Q?Alex_Benn=C3=A9e?= <alex.bennee@linaro.org>
Cc: qemu-devel@nongnu.org, richard.henderson@linaro.org, laurent@vivier.eu,
 imp@bsdimp.com, berrange@redhat.com
References: <909b0a4f-9759-4e27-bba8-997ae2f41bd6@epfl.ch>
 <33eb2408-b4c3-4ca4-9555-b2015fa38630@epfl.ch>
 <87wm022fxi.fsf@draig.linaro.org>
 <8cd3610f-c6c2-4b8e-85cc-ad4711deab9b@linaro.org>
Content-Language: en-US
From: Florian Hofhammer <florian.hofhammer@epfl.ch>
In-Reply-To: <8cd3610f-c6c2-4b8e-85cc-ad4711deab9b@linaro.org>
Content-Type: multipart/signed; protocol="application/pkcs7-signature";
 micalg=sha-256; boundary="------------ms040105010909010904010408"
X-ClientProxiedBy: GV0P278CA0072.CHEP278.PROD.OUTLOOK.COM
 (2603:10a6:710:2a::23) To ZRH2PFAD84B9AF9.CHEP278.PROD.OUTLOOK.COM
 (2603:10a6:918::220)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: ZRH2PFAD84B9AF9:EE_|ZR3P278MB1238:EE_
X-MS-Office365-Filtering-Correlation-Id: f3bfa2d2-5687-4d63-1629-08de74447f82
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|376014|19092799006|366016|786006|1800799024; 
X-Microsoft-Antispam-Message-Info: =?utf-8?B?c092YnNoVTFRQVNXYlVUL3hoM0JYTnlsZm1YSHlFMFBwdFN6Z21wa2hPTUJK?=
 =?utf-8?B?RDQ0YmRUazRaS2ptR055UE9HaTg3UUVhM1ZDS3Z5R3ZTOTBJd2xGMVgvRk5i?=
 =?utf-8?B?VEZ6RFBmQmVoOXk2Yi9PdFMxM1A1ODRVRFRhVThWSW9EclpoSWV5WWtBVHVH?=
 =?utf-8?B?cEYxbW1VL0xJT0NudUZ4dUQ4WlcrVnBVR0hmakl6OUNuZmt0YjdJMWlSK2JV?=
 =?utf-8?B?YzBMR0FzbkRiblBNb0FuTG1yZWJKeUNsYVBoOUpIcnM4N0ZzeFBWUXFZZkdT?=
 =?utf-8?B?V1l5NE1lL0V4dnMyR2p5ZlBVL3Z5aXI1cDM2UkVzSGxEUWZ1VXRLNEtjdVJm?=
 =?utf-8?B?R0FBSVdWUVFTTGU4WnBEbHVBT1BFMTA5ODhSeVVncDYxOUIyRW1mTENLS3hu?=
 =?utf-8?B?Qiszek5RbmZQd3Q4VkhmRHkwWTNzMFRzbHhWQXVSZ09RSm03clgvVE42M05P?=
 =?utf-8?B?S0Y1NmN2dUcyT3RNMGFvYlVKcGVYWDJsUTZ5Y3FRYTdkUnJOUEFORlVmMDlW?=
 =?utf-8?B?MG5JMEtYeGJobE81SFN5cEd2RU11NUpla0FVeGd0WTduQm9qZjNQWGIwRi93?=
 =?utf-8?B?MmFEaVNaVzNOcStHWFpvc0pIRFAxY1dGSXpqSTRRbzREZksyOWlrOElFc3pt?=
 =?utf-8?B?VDVrMVVjVFVuTTVwcFVremluWkRpU0F4VlpoSllGYkJnQVNLODRmWStYVURY?=
 =?utf-8?B?MTZzM2pHQ05wK0lSZnJBT2F2c2dRNjdGUHBkVUFVeTEyaXU2d3hGRE9KVG9P?=
 =?utf-8?B?bHlSMmhLT0YzQnZQRkpUZFVNNXQvZ0lhRmxzT3h1Yk5hUEFxSGR3bWZmUDBI?=
 =?utf-8?B?ZncrRVVCbU5tK21sWWR3eGt3aEpwNDgvTHA5Q2hJa3ZUWmkxYWtlRzVzc0xz?=
 =?utf-8?B?elI4K3lDQ0I4bFhDOUVhaUNnUThoZE5EaGpzNnFwdkRCZit1NzRCaVpuY1JS?=
 =?utf-8?B?cE90UUZSN1B0aEZ2QThIYjZIdVlMNUZFZThKNkJyWXVuRXNMWStHQnRhYS9T?=
 =?utf-8?B?bjFjS09MSzROTkh1Q1hPaDNkMy9PK3hIU2lOeFpUSzM0TVpFdmxPSFNOWDkx?=
 =?utf-8?B?SkgvMENWR29vdHJieDBWcjluUjQ4Ly9mVlYwcFhYZTlKek52NHRKSGVGSld0?=
 =?utf-8?B?dWgxQ09YS2N0VDZiWUZOYWdFNjRmVUszeVV0ZGp6ak5RWHN6SW1KRGZucEY4?=
 =?utf-8?B?cWdjeHA4VHlnc01WaXRyaEg1MytHTmVoNE5aanNIWkhqVUFsWTRtWjNQZlBX?=
 =?utf-8?B?RFpTQ2NvMk5RUFpDVlE2amxZeG1GbHFmTEY5cHFZRU9xaHJnWFdja2pNVm42?=
 =?utf-8?B?QkRIZ0liLzhROHJYUSszdjZWYXA1R25UU09YTUcydUsyNFIrd3lvTWdNdU4x?=
 =?utf-8?B?a2IwaXo4ZTA0SklNUDM4REhaVkp5VlBHNTR4cEJmd2FCLzJoQXpnYUMrSFVm?=
 =?utf-8?B?alJ5bUlJY2RuZ0xGQkZtVUFNZXpxSGh1QytHdXRpYThZUTNvQWp1U1hCbno5?=
 =?utf-8?B?ZTB0UUpBQTNmTldVa2RhTHEwa0NVV3cwZGZlWGNHWUFCb3lnWEI4NzhyMEhS?=
 =?utf-8?B?T1IvT0FHZnNrN2hQb1JaRGZRVHZmd2ZiOW01SWpsc2pqTTFvMUJXQkZrT1BR?=
 =?utf-8?B?ZmpoenNDRXJhVHNLWWlGSjcwMDBUdlFxb3VtOTNEaStYUG1tc2JoL1J1M0NM?=
 =?utf-8?B?aU5WcEhVWTFVSmpsRS8wdVJRTlZFRzU2eFJOM2h3bXdpQXBHTzJxZmpRUTJv?=
 =?utf-8?B?eGdBZTNBalYxekFMVFJDMlBZTTI4SGxlV0RnYXFZYWdzenR6WjI5ZmFCVXYr?=
 =?utf-8?B?cHlvOGJhaS9jUzBSRUtJNWRTbWVHRHppcmliNUY1MzVRR0pFbnBQM25iR2t0?=
 =?utf-8?B?dGRkVXo4a0tjbStwN0d3MFJSclRQY0l4eWJJbCtlQWRvbm0zbzhEODdKR0s0?=
 =?utf-8?B?cWFuVkNnekRmWGcyOFM3TnI2aWpobFRqbjRZWko5c1YxRVFSNEZIaXYzbGE5?=
 =?utf-8?B?Ty9XSEZYTjJVZUJjRnNjaWFmeEVJR3dPait3M1lMMXBuQ2E1SmdYYTFPa0tU?=
 =?utf-8?B?TFl0Zk0yaFE0OEJUUkJnL08zMUxCU3pCRURDV1d5bUVob0RLQW1WdWx2c0VE?=
 =?utf-8?Q?o/0A=3D?=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:ZRH2PFAD84B9AF9.CHEP278.PROD.OUTLOOK.COM; PTR:; CAT:NONE;
 SFS:(13230040)(376014)(19092799006)(366016)(786006)(1800799024); DIR:OUT;
 SFP:1102; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?SkhFQzN0SkF1NzlxalREMzRkbmtVaXRCbWNBVGJIZmZPZy85ZG5DVzZMNDlH?=
 =?utf-8?B?RlAzN3RKNitMblhmekJpTVo5NGZsVWt5VHhMcTdBT2lzVXVpNVVBb0hmdU5V?=
 =?utf-8?B?Mzl5MHJzSWQ1RlN1U0pIelR5ZkJFZHVzUGs4VmpxakpUSThiYU1BaFprWWFm?=
 =?utf-8?B?dFdPdjBWNzJHNUJGeUVmZXl4Mkl5VnpsQWUzTmpwaEJITjRNcUdyaTBDbzNt?=
 =?utf-8?B?MWx2TEtwb0dJSE1nYnJKamNMUWdvY3VzcHZWajFKWTk3dk94VnppOEtxRmtz?=
 =?utf-8?B?ajFUT2g5dFQwb0szL3NkOEpCVTMycWpGaTVwMGtjL0JjcjliMXNGQkh6cE1m?=
 =?utf-8?B?Z3RrZkdmSEFRd3lQRkt5Z0xMT1QvRDVxNlIvK2tQdFI4UmFKNFprWWIzdFFi?=
 =?utf-8?B?enkwYTlVRzlKWkhzZmk0VFFkQlVzZVNmbVV0SitrM0t0R2hqb0Q3eWJRa0Ny?=
 =?utf-8?B?eDhUcTRWOEdBbkxTQ1hVVTh6UmhXVVNrOFUyY1NjY2laOXFMVm1TMW9Gak4r?=
 =?utf-8?B?T0RYb2l1REVwcnpQQzBlWU5WZU9JS3hpQ05ua2ExOS9vcU5BZHRod0VBb2tL?=
 =?utf-8?B?RC9yR1FtQWpoQWJidHJUcFFTc253TTRJckxBVkVFNm1pQmFib2NuQ1FIenBa?=
 =?utf-8?B?K0pxQzUzWjl1d2lOY3l3blVjMHU1bzFQTjRuYjBBckxSdTdEeGY1QVFCdHZh?=
 =?utf-8?B?MS9KeWxZcUtGL2grSWdKLzhRZk95MzhZbjJhdTQwSW5PMHJBK3pKcDB1Q0hq?=
 =?utf-8?B?MW1uVjZUMmZ4KzllTWpLWW1MRDFVYUtBSEdYZXR3dWRoVDIrcExsSTJRNFlm?=
 =?utf-8?B?RjJzOFIwY3NHeW1rVi9IR2tFekRYU0lxSTFmMXdyenZudWpkRTlUdm56ZnRR?=
 =?utf-8?B?L0NPNlNNU0VJRm9ia0R2REQwQWJaZDRsMzI4WFhNbEUxYkRSRHZHdWM0VEJa?=
 =?utf-8?B?K3FXMk9Xc2pWeEcyaHJ4L0tDS0RPOTY3c3ltRUt6eVowQ0IxSUZxaVJMZHRN?=
 =?utf-8?B?WW03cUI0cVVYK0Vmc3c4Rk82UFhBWlpxSzRudE5iSXNmdkN0VElycDliTUI3?=
 =?utf-8?B?czhmWjdkeDk5dlNLdW1qY0tCSkphK09VenpLVG1QQ2ovNG9CNVZhK3dXMG9u?=
 =?utf-8?B?bjdRUFVUaXlKVURvOGhzRVlpZFowNkZVTDBic2xBeUtodTJsRU1wV21pRG9k?=
 =?utf-8?B?ZFdrK3J6akhYMlZwTlF6bUQwRFlTN2RKbmx5VGxwOC9kckpsWnJySk5XWEs3?=
 =?utf-8?B?UkI0M3ZUckpTRXc0ZCs2YkgxWmFCNExZZllJYXZoOTFUcDl6Z3F5SU5ZVU1v?=
 =?utf-8?B?TUxQWDQvN2VZQlN2U1V0SnpycFA4Zk9CNy9WbmpsQ3M2ZUJWN1REM1dqaHcw?=
 =?utf-8?B?VFZiRFVQdGxWWGowMFFsQXBQUFBGTXNMZlJyMGROTUIyOWhacldacnpGenJl?=
 =?utf-8?B?eFVReHV3cWxIRU1FaTRtVmlaZEl6MWJLeXRHbnJERkZXbFZWUkdRckZheDFW?=
 =?utf-8?B?SjNoUjFheDdZTUduTWQ0QjlaZWFOWTJqSzhZeGVYM01NeEx3SGxGTFVSNEd3?=
 =?utf-8?B?L1U3T245MmtHM1IyOVczVjRmbGZPOUtMTm1UNUpUUWduOXZBWXd0YTZ5bkFW?=
 =?utf-8?B?TmdDMDUybTlXNW9pV2pIOXJ4SFBRMlU5eFd6cWp6VHJ1THNwQnNNZjBZSkx1?=
 =?utf-8?B?L1NKa3lDZ1g3QnlsQVRvZlNad0xQOERSc2VrUGQ3N0ozL05NNUs1dGJnaHFU?=
 =?utf-8?B?eXdXOFErL0JBRTdnSS9pN1d0ZlJjT0pJelVQN0lOdklkU1hEOFhrSE55VEhx?=
 =?utf-8?B?VW96Vk9YVEhpdXk2R2xGL1RwaHpKR2g4N2RtdWc1TGJiZUdPK1Y1SkxTQ1A2?=
 =?utf-8?B?V1BpRVNWY3NYOHNvYW5vYTlKTmRPNUEvRi95a1Z3L3Fnb0tiSHI1VlVwUzVv?=
 =?utf-8?B?VXU0NEV3S29Vb0tteFJady85dWcwNm1PRmpLeTF2YnhLOUc5ZGUrZHFEMVFr?=
 =?utf-8?B?NVd5ekJKUzJhMnFEbzByYmFOMGw2cWpDQ0hpZkdPSFZYSjFtQlN5a2pneTgx?=
 =?utf-8?B?WHJVMWx0YVc3K1pIT05KdnZhRk5oUHBYL2dCR0p3QjlQUlNLWGVqZzhTd1JI?=
 =?utf-8?B?VEJQdkhGL0FGZmVaTFBMajNhWGN6VzZOa3RtVk9VVkdOVi9BUEJXUFVKaUJx?=
 =?utf-8?B?cmdqdEt5cE9hT1FkYUVlL0NZL1BnQXdLZE83TmJBU2FQWW56U04zcGQ4bnk5?=
 =?utf-8?B?S2ZpOXJhVWFsNDFlRFNwdWFqd3hrTXRYK1RHQ2NydzZySFF1TWRqMFBsN0x5?=
 =?utf-8?B?STRwNTZ0bGRsM2ljM1hTU2hYbEJkOVBLV1d4MWc0TktKSnpadVpFUT09?=
X-OriginatorOrg: epfl.ch
X-MS-Exchange-CrossTenant-Network-Message-Id: f3bfa2d2-5687-4d63-1629-08de74447f82
X-MS-Exchange-CrossTenant-AuthSource: ZRH2PFAD84B9AF9.CHEP278.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 25 Feb 2026 08:04:28.1434 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: f6c2556a-c4fb-4ab1-a2c7-9e220df11c43
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: zh8QlRTYzHgE93eXZGEkCC0EIz8xg8wBZO1lC6HU598kkZO3m9OZ+lfiWVdt/FaQG718kdyN/F3ErTVdKEP8xgBcmTWMyifEu8xn3lgHZhU=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: ZR3P278MB1238
Received-SPF: pass client-ip=2a01:111:f403:c213::;
 envelope-from=florian.hofhammer@epfl.ch;
 helo=ZRAP278CU002.outbound.protection.outlook.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, SPF_HELO_PASS=-0.001,
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

--------------ms040105010909010904010408
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

On 24/02/2026 21:12, Pierrick Bouvier wrote:
> On 2/24/26 9:46 AM, Alex Benn=C3=A9e wrote:
>> Florian Hofhammer <florian.hofhammer@epfl.ch> writes:
>>
>>> This patch adds a plugin API function that allows diverting the progr=
am
>>> counter during execution. A potential use case for this functionality=
 is
>>> to skip over parts of the code, e.g., by hooking into a specific
>>> instruction and setting the PC to the next instruction in the callbac=
k.
>>>
>>> Link: https://lists.nongnu.org/archive/html/qemu-devel/2025-08/msg006=
56.html
>>> Signed-off-by: Florian Hofhammer <florian.hofhammer@epfl.ch>
>>> ---
>>>   include/plugins/qemu-plugin.h | 13 +++++++++++++
>>>   plugins/api.c                 | 13 +++++++++++++
>>>   2 files changed, 26 insertions(+)
>>>
>>> diff --git a/include/plugins/qemu-plugin.h b/include/plugins/qemu-plu=
gin.h
>>> index a6ec8e275d..04c884e82b 100644
>>> --- a/include/plugins/qemu-plugin.h
>>> +++ b/include/plugins/qemu-plugin.h
>>> @@ -76,6 +76,7 @@ typedef uint64_t qemu_plugin_id_t;
>>>    *
>>>    * version 6:
>>>    * - changed return value of qemu_plugin_{read,write}_register from=
 int to bool
>>> + * - added qemu_plugin_set_pc
>>>    */
>>>     extern QEMU_PLUGIN_EXPORT int qemu_plugin_version;
>>> @@ -1042,6 +1043,18 @@ QEMU_PLUGIN_API
>>>   bool qemu_plugin_write_register(struct qemu_plugin_register *handle=
,
>>>                                   GByteArray *buf);
>>>   +/**
>>> + * qemu_plugin_set_pc() - set the program counter for the current vC=
PU
>>> + *
>>> + * @vaddr: the new virtual (guest) address for the program counter
>>> + *
>>> + * This function sets the program counter for the current vCPU to @v=
addr and
>>> + * resumes execution at that address. This function only returns in =
case of
>>> + * errors.
>>> + */
>>> +QEMU_PLUGIN_API
>>> +void qemu_plugin_set_pc(uint64_t vaddr);
>>> +
>>>   /**
>>>    * qemu_plugin_read_memory_vaddr() - read from memory using a virtu=
al address
>>>    *
>>> diff --git a/plugins/api.c b/plugins/api.c
>>> index e754b7c69c..ca3e93a194 100644
>>> --- a/plugins/api.c
>>> +++ b/plugins/api.c
>>> @@ -41,6 +41,7 @@
>>>   #include "qemu/log.h"
>>>   #include "system/memory.h"
>>>   #include "tcg/tcg.h"
>>> +#include "exec/cpu-common.h"
>>>   #include "exec/gdbstub.h"
>>>   #include "exec/target_page.h"
>>>   #include "exec/translation-block.h"
>>> @@ -466,6 +467,18 @@ bool qemu_plugin_write_register(struct qemu_plug=
in_register *reg,
>>>       return (gdb_write_register(current_cpu, buf->data, GPOINTER_TO_=
INT(reg) - 1) > 0);
>>>   }
>>>   +void qemu_plugin_set_pc(uint64_t vaddr)
>>> +{
>>> +    g_assert(current_cpu);
>>> +
>>> +    if (qemu_plugin_get_cb_flags() !=3D QEMU_PLUGIN_CB_RW_REGS_PC) {=

>>> +        return;
>>> +    }
>>
>> I think its fine to assert() here - we do it elsewhere in the api, if
>> the user is holding it wrong we should exit now rather than leave the
>> plugin more confused in the future.
>>
>=20
> Agree.
> With the assert instead of return,
> Reviewed-by: Pierrick Bouvier <pierrick.bouvier@linaro.org>

Ack, will update the patch accordingly. Thanks for the feedback!

--------------ms040105010909010904010408
Content-Type: application/pkcs7-signature; name="smime.p7s"
Content-Transfer-Encoding: base64
Content-Disposition: attachment; filename="smime.p7s"
Content-Description: S/MIME Cryptographic Signature

MIAGCSqGSIb3DQEHAqCAMIACAQExDzANBglghkgBZQMEAgEFADCABgkqhkiG9w0BBwEAAKCC
DD0wggWvMIIEl6ADAgECAhANkOKMSmGXhF5eMl0rsRhvMA0GCSqGSIb3DQEBDAUAMGUxCzAJ
BgNVBAYTAlVTMRUwEwYDVQQKEwxEaWdpQ2VydCBJbmMxGTAXBgNVBAsTEHd3dy5kaWdpY2Vy
dC5jb20xJDAiBgNVBAMTG0RpZ2lDZXJ0IEFzc3VyZWQgSUQgUm9vdCBHMjAeFw0yNDAzMTMw
MDAwMDBaFw0zNDAzMTIyMzU5NTlaMGIxCzAJBgNVBAYTAlVTMRcwFQYDVQQKEw5EaWdpQ2Vy
dCwgSW5jLjE6MDgGA1UEAxMxRGlnaUNlcnQgQXNzdXJlZCBHMiBTTUlNRSBSU0E0MDk2IFNI
QTM4NCAyMDI0IENBMTCCAiIwDQYJKoZIhvcNAQEBBQADggIPADCCAgoCggIBAOfSIeC0vv1x
PQ+dgSxbIIrkaru6skAWJYaGFzmvq4Kq+2wU2jxhcWlJg/JeP5jEkq/LM3pn5aaLao79j+XR
mS7J1ZpJKUODJVoM4s9MQJhTMvo4qS5ZS64g6QR7Obkz3I1Lr3aWeSBmDDEyzue+NKtuWZ1C
xy3RdXo/w5HgRc3l2AercOM3Gt1XonTzEtTbZ/Hwc0Sn9Gz8RmGRK6Ka4hVDl8q/2l110KaV
233Kh5etP0csXS8MIMdVRfRu3sc5hp13DG7lCKzK72a2GEpI8Wpl26G6I1/LMzz/98T+FqjT
qxsdquk7Cj7m2vKGLW1BorpQH7WFGPdJQXJe1hfbfiZACcVdCtl4nAacFacmsiArZBfX7AQG
L7isvHUwwYFEtcApyGW4p2Lt+t8nvU0CANA6BHOpOz1xOP8WmAESbUriIjyuTUf3fJ9oDNCu
rVqhASMJCDaWI3lYX/QAoiAzt6akqbbZxo2ujW7mGGqc0KxqE2csh2T79v7pC8aUtHBfwNrT
R19GnZVxE0eQ7ViIQhR6mpSaUQFA9sG+cmD2G8TnCgYsLa0q8De6F61aCBevQGHNzrbZ3JAM
neveYg/Jy1XxQHDRcvrMfWKe0jjcWbdKYlaGVPm5V1ILwYz7Yv5ewo3NUrxIGJiywe9qPhuJ
SDZs7VehTuI0FxGIsgKzVjgbAgMBAAGjggFcMIIBWDASBgNVHRMBAf8ECDAGAQH/AgEAMB0G
A1UdDgQWBBT3m6JO05fF9DQPQw6Bhc6RkzKv+TAfBgNVHSMEGDAWgBTOw0q5mVXyuNtgv6l+
vVa1lzan1jAOBgNVHQ8BAf8EBAMCAYYwHQYDVR0lBBYwFAYIKwYBBQUHAwQGCCsGAQUFBwMC
MHkGCCsGAQUFBwEBBG0wazAkBggrBgEFBQcwAYYYaHR0cDovL29jc3AuZGlnaWNlcnQuY29t
MEMGCCsGAQUFBzAChjdodHRwOi8vY2FjZXJ0cy5kaWdpY2VydC5jb20vRGlnaUNlcnRBc3N1
cmVkSURSb290RzIuY3J0MEUGA1UdHwQ+MDwwOqA4oDaGNGh0dHA6Ly9jcmwzLmRpZ2ljZXJ0
LmNvbS9EaWdpQ2VydEFzc3VyZWRJRFJvb3RHMi5jcmwwEQYDVR0gBAowCDAGBgRVHSAAMA0G
CSqGSIb3DQEBDAUAA4IBAQA+b8Uw53sDspdZgukU+qzLyyHkcjlxGGhHlP+zrmDLKm1wEFvC
RS2pili3Hy67i8N4N5NUvw5Rg6kv3lxb9S9Rktxk43k+tvm68pl7OxQE55ZjVY87P0lUPGwE
qOOwLLyH02ZQcsfq5p5LrOH90JvmvZ1yy73HS+VpDAqOlytE0NSvTIRqFFkKQGQwfjvtql9Y
flujuNNvJztjBaHKYZsnNSg+J38ojYq4TP3pSg3UdVH0PncVjPQyqxC9xef5Xae92Kbkzol3
x7Nel3A1bwAkalrDMspvTHvey6LfiBksFIqviTnoy7fgjaRAJgHS+RXx/cmuRd3rUAclSVVr
Yu8RMIIGhjCCBG6gAwIBAgIQAggtinx6OJLKM4FVztNyWTANBgkqhkiG9w0BAQsFADBiMQsw
CQYDVQQGEwJVUzEXMBUGA1UEChMORGlnaUNlcnQsIEluYy4xOjA4BgNVBAMTMURpZ2lDZXJ0
IEFzc3VyZWQgRzIgU01JTUUgUlNBNDA5NiBTSEEzODQgMjAyNCBDQTEwHhcNMjUwNTI4MDAw
MDAwWhcNMjgwNTMwMjM1OTU5WjCBrDEOMAwGA1UEYRMFR09WQ0gxCzAJBgNVBAYTAkNIMREw
DwYDVQQHEwhMYXVzYW5uZTE0MDIGA1UECgwrw4ljb2xlIHBvbHl0ZWNobmlxdWUgZsOpZMOp
cmFsZSBkZSBMYXVzYW5uZTEaMBgGA1UEAxMRRmxvcmlhbiBIb2ZoYW1tZXIxKDAmBgkqhkiG
9w0BCQEWGWZsb3JpYW4uaG9maGFtbWVyQGVwZmwuY2gwggEiMA0GCSqGSIb3DQEBAQUAA4IB
DwAwggEKAoIBAQDZkbG07NgfFKDNM3VI4qQdU1fVIGUQnN6BO2zeqoUdytNIzxOX6n7HxM+o
CLa01AnxaL59DXwFTXIg0OVq5ETAoLshUwnkYeWhKZH4Ysoq74QGVFihjrrs41d+8o+ymG2F
cZBMzQ/RO4KzFhmlaZ/E+1d2F7/O3x8LohaFxxBsN0+qonMreRQGx+ialMmbARFJkVuinuB4
3hZ8eRVmXy8A4R8ywakunaCNm15+eIQtptCs3IH5UqPEEOn16ANekWr7z5mZJh3ApxreflA/
iwJKWd/Ljga90TJXjTFc7sNA0RgA78Edqw7BE+D2VUcPMshdhKYNB1BVHZS81anGL7RFAgMB
AAGjggHrMIIB5zAfBgNVHSMEGDAWgBT3m6JO05fF9DQPQw6Bhc6RkzKv+TAdBgNVHQ4EFgQU
ogXJJmzPazWg0eBlf1DbolocD3gwJAYDVR0RBB0wG4EZZmxvcmlhbi5ob2ZoYW1tZXJAZXBm
bC5jaDAUBgNVHSAEDTALMAkGB2eBDAEFAwEwDgYDVR0PAQH/BAQDAgWgMB0GA1UdJQQWMBQG
CCsGAQUFBwMCBggrBgEFBQcDBDCBqQYDVR0fBIGhMIGeME2gS6BJhkdodHRwOi8vY3JsMy5k
aWdpY2VydC5jb20vRGlnaUNlcnRBc3N1cmVkRzJTTUlNRVJTQTQwOTZTSEEzODQyMDI0Q0Ex
LmNybDBNoEugSYZHaHR0cDovL2NybDQuZGlnaWNlcnQuY29tL0RpZ2lDZXJ0QXNzdXJlZEcy
U01JTUVSU0E0MDk2U0hBMzg0MjAyNENBMS5jcmwwgY0GCCsGAQUFBwEBBIGAMH4wJAYIKwYB
BQUHMAGGGGh0dHA6Ly9vY3NwLmRpZ2ljZXJ0LmNvbTBWBggrBgEFBQcwAoZKaHR0cDovL2Nh
Y2VydHMuZGlnaWNlcnQuY29tL0RpZ2lDZXJ0QXNzdXJlZEcyU01JTUVSU0E0MDk2U0hBMzg0
MjAyNENBMS5jcnQwDQYJKoZIhvcNAQELBQADggIBAD3Ne2mHg2ctxRIflrx/T2yBDnQunFhe
SRwBnFIaOvCG05KE9iit2I2sazC5xqdp292spCoP9Qa4MOJg22BFmTnN9XnOjcEv9KFPSMaA
ITLu8CXyewPb0xLET8WqdEe5AravlneZ9/H0ve9Ufhk3wbJPKK5yijcKYmEYH21JBtZ1pnjs
fVEXAETdKkp9LC5sVeYeFk67BbUTPrFl37pha3TynPwJAiXDJFR2uI2JVGESQFyWkeO/bY5T
DCf6VIp3d1p++XoOTVseFE8OqaHZYGN+DgSK4ejT19c/GgjQqoWVK+xSvHEEsoLfOADKcYFN
M0ptGrFYpdRWJO0CKukBUAk8fpriJ/OjhSVQltCpN3pK1DPXnPrXTROXGacb3PNSUyeDlP2/
y0FqpEY7GjwMZMdu+U/rHhMGbDmv/ZBLGwiGzQVmld5je+d8nvZTamE1iBA8Nhmuz6wg6yN1
qx9b7Jn/9yQebxvHddnvz6jw6FDnw2bhq7z88eH3mYZYZ48Fhr8J87horGotEDKTDNHkF1Oe
FSxhIx0a7yoe1I66R5tapkRlNgI5EX53e/npP4ruND5bQFWDI7JGkKrLlAjQR/dNahXXX/Ry
rCfngiHZcAQakPkQrlrZCxMhlIKvDMunATaICyjnHizEC+1qzJsdvJgSC8sOzLxiEjlx3MRe
CswFMYIEezCCBHcCAQEwdjBiMQswCQYDVQQGEwJVUzEXMBUGA1UEChMORGlnaUNlcnQsIElu
Yy4xOjA4BgNVBAMTMURpZ2lDZXJ0IEFzc3VyZWQgRzIgU01JTUUgUlNBNDA5NiBTSEEzODQg
MjAyNCBDQTECEAIILYp8ejiSyjOBVc7TclkwDQYJYIZIAWUDBAIBBQCgggLWMBgGCSqGSIb3
DQEJAzELBgkqhkiG9w0BBwEwHAYJKoZIhvcNAQkFMQ8XDTI2MDIyNTA3NTUyNVowLwYJKoZI
hvcNAQkEMSIEIEmVd0PhjqtgROJCgZsBlNdWfW5U7eUBbpRiFmU9+e+KMIGFBgkrBgEEAYI3
EAQxeDB2MGIxCzAJBgNVBAYTAlVTMRcwFQYDVQQKEw5EaWdpQ2VydCwgSW5jLjE6MDgGA1UE
AxMxRGlnaUNlcnQgQXNzdXJlZCBHMiBTTUlNRSBSU0E0MDk2IFNIQTM4NCAyMDI0IENBMQIQ
Aggtinx6OJLKM4FVztNyWTCBhwYLKoZIhvcNAQkQAgsxeKB2MGIxCzAJBgNVBAYTAlVTMRcw
FQYDVQQKEw5EaWdpQ2VydCwgSW5jLjE6MDgGA1UEAxMxRGlnaUNlcnQgQXNzdXJlZCBHMiBT
TUlNRSBSU0E0MDk2IFNIQTM4NCAyMDI0IENBMQIQAggtinx6OJLKM4FVztNyWTCCAVcGCSqG
SIb3DQEJDzGCAUgwggFEMAsGCWCGSAFlAwQBKjALBglghkgBZQMEAQIwCgYIKoZIhvcNAwcw
DQYIKoZIhvcNAwICAQUwDQYIKoZIhvcNAwICAQUwBwYFKw4DAgcwDQYIKoZIhvcNAwICAQUw
BwYFKw4DAhowCwYJYIZIAWUDBAIBMAsGCWCGSAFlAwQCAjALBglghkgBZQMEAgMwCwYJYIZI
AWUDBAIEMAsGCWCGSAFlAwQCBzALBglghkgBZQMEAggwCwYJYIZIAWUDBAIJMAsGCWCGSAFl
AwQCCjALBgkqhkiG9w0BAQEwCwYJK4EFEIZIPwACMAgGBiuBBAELADAIBgYrgQQBCwEwCAYG
K4EEAQsCMAgGBiuBBAELAzALBgkrgQUQhkg/AAMwCAYGK4EEAQ4AMAgGBiuBBAEOATAIBgYr
gQQBDgIwCAYGK4EEAQ4DMA0GCSqGSIb3DQEBAQUABIIBAATWW5dG61ZUPzPPR21oHsOQxxjQ
kKmKKc2DIM75VS/gHm8SLJijvFcrYwhiQACv/OZn7/zxq/bb++pqEbkS1b9ESBurIp2wVYZA
o7Yy+kaWTZQtKn5czPnOwltSRCpT4/gbZN3TI7Xew/Fuof+uNV7jm9xQvdF5Go+h+cpMWo/n
tsV6XyL7IPmYQyHMlY3m8Q70zrKpTaHbebautMl6l4g7jaGHpzSHb0goVIZ3XpGP451Bk6Gw
sueInPJDFsSpL8RgGc0jQKx1tE4m7tJfD/norBihFZMQXG5mH2Ojp74wCktnvfBM0WjNm8F1
fRvgnGNCewe13QeSot2almUCR0AAAAAAAAA=

--------------ms040105010909010904010408--

