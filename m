Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A75CBF3C9AC
	for <qemu-devel@archiver.kernel.org>; Tue, 24 Feb 2026 16:02:31 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vuurO-0001do-UF; Tue, 24 Feb 2026 11:02:07 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <florian.hofhammer@epfl.ch>)
 id 1vuur3-0001Ab-8a
 for qemu-devel@nongnu.org; Tue, 24 Feb 2026 11:01:49 -0500
Received: from
 mail-switzerlandnorthazlp170120005.outbound.protection.outlook.com
 ([2a01:111:f403:c213::5] helo=ZR1P278CU001.outbound.protection.outlook.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <florian.hofhammer@epfl.ch>)
 id 1vuuqx-0001kk-OJ
 for qemu-devel@nongnu.org; Tue, 24 Feb 2026 11:01:42 -0500
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=RYR6HohBMc/OcJpCRTwm7vxHJ90O4tYGz8aZV4f+xwhwHQ5SxSQSdAPaFFOcSi9tS0+oz53/UJpAAtZTjMDu958Xg3WhJppUgz3P982qweAtQCQQYdX4QCQZ4fyt/44a/qdpGpD+QV24hBaNCeId7wEnoypXmdcXiAi1UVvRTJ4BlFvuzKPXlqZbCu0NuaTjl77WIyeQrEh4zo0+RhkLKjZTEmoMAjMOLtwbNOR9eOxwzZViv9mipkPtlIKVtAh/ekVynbzOTQcmXQaMTb+jfyvyNtMoBqSMMJwWY6XdhnIBpt1yyopzMHGMYvX/5Jc4fuPoXxHNpyWXGBXfXtHGwQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=f17hvKRsdxDqIaN8KQ6slEZ1PWnsXw5wX/MCN1HEkNQ=;
 b=XWQdrDB0vUVRmW8tKKHsjEZXNaYL96SbddfRzNYegos59cHCyKANMUcT1Syt2mSfBPTzv4jbUw8c9ARnNG7dSUFml6fkAlx5FPVydVkFWdfI/j2n2MggLr+DOmu+fhKgDwrgW952b3jpZs9N1K8nALJau04UwykYQ3RQD0kEwh8o0ktpr8YtV/WRAz0sq24EqnSjBI2Aa5scVnyfu8hjbPlACYLKhvHaH4jDpBtn9YC2pL7E9Ln/+u40WeTxGr2uBzAY/z64WYVcM8hxTmYzyotKtn/ntuwaMEfq1cJOWtS8Q/BVwOmQ/hWVlQDQkzRuALiC3woETMUTBQrcPnuj/Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=epfl.ch; dmarc=pass action=none header.from=epfl.ch; dkim=pass
 header.d=epfl.ch; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=epfl.ch; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=f17hvKRsdxDqIaN8KQ6slEZ1PWnsXw5wX/MCN1HEkNQ=;
 b=jp5zPnWZbG3VwLRUxf+mUpMvLYrAoSJSKDN1eqpqOXhS1H22r8JbNqBwkik4RdGm24biaF4KhEqFbt/jpIC+3JM1z9QJdsAo69bWjtzi6XjlyFrmVW6U8cWuulJ3Le+3Gb1Sb1+IHnl3Y6oaOeK3eeccGYGDw2KEeEgvtNFxu/k=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=epfl.ch;
Received: from ZRH2PFAD84B9AF9.CHEP278.PROD.OUTLOOK.COM (2603:10a6:918::220)
 by ZR3P278MB1305.CHEP278.PROD.OUTLOOK.COM (2603:10a6:910:72::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9632.22; Tue, 24 Feb
 2026 16:00:34 +0000
Received: from ZRH2PFAD84B9AF9.CHEP278.PROD.OUTLOOK.COM
 ([fe80::80ea:3d03:40bf:998c]) by ZRH2PFAD84B9AF9.CHEP278.PROD.OUTLOOK.COM
 ([fe80::80ea:3d03:40bf:998c%6]) with mapi id 15.20.9632.017; Tue, 24 Feb 2026
 16:00:34 +0000
Message-ID: <8716147d-d5b4-4d8b-859a-26a5310973bc@epfl.ch>
Date: Tue, 24 Feb 2026 16:53:03 +0100
User-Agent: Mozilla Thunderbird
Subject: [PATCH v4 5/7] plugins: add read-only property for registers
From: Florian Hofhammer <florian.hofhammer@epfl.ch>
To: qemu-devel@nongnu.org
Cc: alex.bennee@linaro.org, pierrick.bouvier@linaro.org,
 richard.henderson@linaro.org, laurent@vivier.eu, imp@bsdimp.com,
 berrange@redhat.com
References: <909b0a4f-9759-4e27-bba8-997ae2f41bd6@epfl.ch>
Content-Language: en-US
Autocrypt: addr=florian.hofhammer@epfl.ch; keydata=
 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
 5hMMZIzTI4AtIcgA3xe4Ew==
In-Reply-To: <909b0a4f-9759-4e27-bba8-997ae2f41bd6@epfl.ch>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: GV0P278CA0016.CHEP278.PROD.OUTLOOK.COM
 (2603:10a6:710:26::26) To ZRH2PFAD84B9AF9.CHEP278.PROD.OUTLOOK.COM
 (2603:10a6:918::220)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: ZRH2PFAD84B9AF9:EE_|ZR3P278MB1305:EE_
X-MS-Office365-Filtering-Correlation-Id: 10973a64-62cb-4f54-6ff3-08de73bdd672
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|366016|376014|786006|19092799006|1800799024; 
X-Microsoft-Antispam-Message-Info: =?utf-8?B?Mzh1aDRMNmtXYWh1cnowZFZoYUZGZlNVVXpzM2JUYUZTRXRKZ09PRzk1VzJH?=
 =?utf-8?B?czVhODdMbzBKNHBjV3U0MElBa1hhaTQ5QWhDbml2bUxBaFVjUUNYaldNN25R?=
 =?utf-8?B?Nm12U3k5ay9tSWk0dCt3MlRDMEF3RkJ5Y2l1QVJRd1RUQ2FpL1dvV2R6L21Y?=
 =?utf-8?B?aTcrdSthSkFkSG1PRVl4UUZHMDFiVm4vK0JTNjFDbHNuYXJBcWNmM0wyeUhX?=
 =?utf-8?B?ckx2UVBaWUVFd094UkwvT2VOZktIU0hIeVNtbTgvT3Y4bUc3TTBQRlRKclZi?=
 =?utf-8?B?UnFkaDRSeTlrNFVSTkZYd1Y5NXlQYVNlM0h2eXREQ0V1Tk5KeksyQkZYTUIv?=
 =?utf-8?B?QVNJenova096MG1DWlJPYU1PTUl3UkFVeWFDa2xSdFp0M1ppazNFSHkzTVor?=
 =?utf-8?B?emtaQTFJcy82N2d6Vkc1NzBSeWpJOTY5bUJucGRhL3N5aVBsL2FtMzJzaUR3?=
 =?utf-8?B?Z1BhUTdDRjFzbVNISDVweUpyd2x0ZXRyNjFxZTJDT3JrdEhCSUxhUFdmdHpE?=
 =?utf-8?B?RTZsVDJPUUxzY2krYVVwVGVocmEzMm5kVFJTa3ROY1d5NlcrSGhxOG9UdXJx?=
 =?utf-8?B?djBFeEVQNndPc0ptRzBuckFVYTF2Nmk5dkk3VS9RYnQwTERpQmlQbXp3NEhO?=
 =?utf-8?B?S3FUdnRJamJIdThVUTBra0dIV05GOStqK3VIZXBzdXpQSzd1eEJPakxrbnNI?=
 =?utf-8?B?dVdjaEhycGZnK1JIZVFwWlBtZUVJSEJSOFRYL0VLVGxoSy8yU29tT0NyS2Q0?=
 =?utf-8?B?RFlubzFycGlhUnJZWlFhUkIzeTlCbnNsd0tZRTM2TEhLVDFNN2R3RVRhYWsx?=
 =?utf-8?B?bHdFTUNVamNvZjBScmkzejhrdSsyVUFxWlF2STNZMEY0SENuL1lNWmZpa2Fs?=
 =?utf-8?B?RlZ0NGNmSmFZUUZvVS8ycHQzOXJuRmYyOGVSeXY0c3JoRlV3OUhMRyt6WFdM?=
 =?utf-8?B?TU9jZjFwUmVnM0h6bGtiM2tRaVVlMzIvM1lLaEVCL2dJcEVXRnpwMnQzT3k2?=
 =?utf-8?B?ZWhKSzM1QWNGWitIeUtiSE9Dc3VKT0JBU0lDNVVRZXE5MG5XbVB6RHRyYW9D?=
 =?utf-8?B?bXVBVVhVN1pySE8vQkt1cTE4Z0hNa0ZVZFpRYTVsd3RuWEliaCtIYUFSNno0?=
 =?utf-8?B?TG92ZDNNMjJRZy9PMlhCMkVOT09yUzlNYnpZTDY1aThhSHRCVVNBaWhrWmI3?=
 =?utf-8?B?SlJyR1d5VXkvTnRRbThNMlRoK3VEbjlVbERObVRrMXVNMW42NFFyT3IvZ0o5?=
 =?utf-8?B?VkphSHpzam1sYXNKQXF1TWZQaisxTXNqNFl5UnpRMm5ZUGR5NC8vbkNoQ1Ex?=
 =?utf-8?B?MklDQzUyaURaZUZ2dUNwMlBieVloWE1iTmoyZ3h4WVA1UjRkZGtqZEJuRUZm?=
 =?utf-8?B?aTBieStuTUoyc2pTcm9qNitHaFJPNUE1aDRiYlpuVmc4dXVWdTI0S0hqWnZH?=
 =?utf-8?B?YXUxU3VJbTNabUVxRUhpUVQwZEY2WnZseHR0cXZDQnBSK25vNnE2dTAwK1lD?=
 =?utf-8?B?V2pHMkVIN3BYL1FiSVgzY3prV1VBdHBSbEorMERZQndnbnBFWDgyeVRydnln?=
 =?utf-8?B?a0phYk55UHZGaktLMU54WFd3S1B3ZEdlM2J5SHpEQzdUOTVINXo1eWlobWd1?=
 =?utf-8?B?RGs2TjFTQTFqK0ZOQ1g4bFRudnhmK29zSnFNaEFNZXMwY0lQRlBRV1VBSGZr?=
 =?utf-8?B?WUIzMVNtbTRXbTBBVFpJeTROWnRoeTE5S2hFRlZUekd1TmR6TVhvNmx1dDJQ?=
 =?utf-8?B?amI2M0ZHWld2R2YrclVYZ1N6bjlpWkZSZkgvdC9zdkNFUk43THNxT05NeGtS?=
 =?utf-8?B?T2gySkFPblZuK3kvMWl0bWpWMkRwWjMvL3FqMVErM0srYnljU1FIcmxCZlpQ?=
 =?utf-8?B?Mmxra2NlTTVKYkxNN1BWZlF2VXNVRzB5VnpPMGthYnN2QWdvR0cvWDhCL2x1?=
 =?utf-8?B?THdQVUFiWUVKZzBqNUZSNE9CcDh5VDlvSkdVRXJsZ0doTUtqaGxsdTdranhM?=
 =?utf-8?B?T3hSQXYyVjdNdHZMWnc5ekJSOGtGMmtGZTVlbG9vZzdZeE9RQldOSmYzNWpl?=
 =?utf-8?B?djFlTWRJTW1ZUXArT1l3SE5lS3BvT3BpZWk4eGpJRFBORmc4R20vdm92Y01s?=
 =?utf-8?Q?RTIg=3D?=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:ZRH2PFAD84B9AF9.CHEP278.PROD.OUTLOOK.COM; PTR:; CAT:NONE;
 SFS:(13230040)(366016)(376014)(786006)(19092799006)(1800799024); DIR:OUT;
 SFP:1102; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?R3MxZDBKTVNKa1BDUVZ3dDR2bmJVS3R3dHk1T2FyUXo1MHBhRW01TW1hZkJv?=
 =?utf-8?B?MnZwQXlVUFh6OWVIYWV2NnJzRlBKV05wSG9jak1HcGFqMlFqR3JzdVFRVlNP?=
 =?utf-8?B?TmxnUEJsUmtmS2l5ZFphNzVxYXR3R044TXN3U2NCcXlBUkdoRytaYWREQnBI?=
 =?utf-8?B?NU1LZWpIdDJWV214SU4xdmFNdjFablJqa1VqMUprMk12ck9zdWpHeGx2Z1dT?=
 =?utf-8?B?Y2d5amw4dGx2NTFsS2VDUnhjYWhmeWZiYXU0RjJJdFN5anl5MzZ6TUtxaU1G?=
 =?utf-8?B?MWNnR0hmVWlLL214S2lDeGRxdWdqMnhYNmpUeC81bTVkL3NCd3VqUm0vU2Z0?=
 =?utf-8?B?RlE3bE1VRkVrSXd0THh0S0NsVFJEQklYTVNlM3NHRk5FRk9kL2hXRWdjbjNS?=
 =?utf-8?B?MWtzekR4dlI1RnQyNXpvVVF0dmk2RUw1V24xZk04enFSZVJtTlhOTmVLK2tu?=
 =?utf-8?B?QnRRMXpNbmM4YVFJdHorbVllclNIRHp2YzFYcCtWb0EvcUFISUQ0dnBONUVr?=
 =?utf-8?B?QmswTlRwdW9FaEpNVURDc1E5Y1BtNUx6R3hFelJETUdINXYrUWVaMlVhN25L?=
 =?utf-8?B?aGYrSjVJZk00S0kvaXdyZXhydGVvd0J3dG03b05iMDdqLzl0OWM2cDZmUi9W?=
 =?utf-8?B?dlpVb0U0NHpMSzlxOGhuanlHR1I5NHFkUWs0QTUzMWdhSDdVRnN4bmV3ZERP?=
 =?utf-8?B?ZTlVMHBhc21UM1doUDIrSSs3N1BJWEU5aysxYm02Ni9hd1dTWnBqSG1TSWpo?=
 =?utf-8?B?d0UrLzV0Y3kxblhWSFVNcUhtYjR1TkZVL1h2SXlxM01hQXhwcUgxcnFrTFFu?=
 =?utf-8?B?OTFMeFg4RDFRd3Vxb1dLL2J5TFFlWG1aVWxMQUdFb3V0THFVNDkwWUI1WXNP?=
 =?utf-8?B?a3pya2dBeXFVMUV5MVNTM1hHWnJkSy9GUW00dmcwOGFxdjl5dTluQy9IZFFT?=
 =?utf-8?B?Z2w1YUtmaTBNYnVIMkxsQzdoQXluSk9CUUhVeUtTRXVnSHVDNEEreDdQemhu?=
 =?utf-8?B?ZEVsUGU2M01KQS9kbnE2ZCt2a0p3a2lueEpUaHBNWWFKRlRHY3lnU2VheVdF?=
 =?utf-8?B?WmlRVysrQlgxbDJiQTNlZjNoNysyZU93RG1GNWtCeUJzOHo0dGpyaGxidWRp?=
 =?utf-8?B?S2pmTmQ4TU9WRWpTVnpNeUpmQ3o4TGVma1BtUjJTSExkOENPRHQwYmZwMk1X?=
 =?utf-8?B?THpJazNwa2t3VWkvWFBDL0pFZ0RvM3l2dUNQQ0FZekptZ1NqTnhsZWx4dTY2?=
 =?utf-8?B?cmpGeDJhOEJjNU0xdU9ia2hMcHp1ZThKTXo0Q3hPRC8wZ24wQloxQktmZmI2?=
 =?utf-8?B?Vi9QU0lKalUwMlN0NU1qTURmSkRPaStlSUVQY0ppTzY3N0ZMUmJYdEJmR3JW?=
 =?utf-8?B?VDFIMzdaZHZMNTM4K1FQZEk4VUNzZnNpWURtNll5c0NpZzNUb0pINmVRSGRR?=
 =?utf-8?B?RDBabnFjQTh6clBFd0JGL0NPWGdsYXdpUUtCY0k3L1dXd3VlakR0WXBtWUJr?=
 =?utf-8?B?Y2Njam1mbWtaclVhK3N5dXgvYlQ2djJwL0ROWU5VcFhnNitXeExEUDhQcXNw?=
 =?utf-8?B?VHNHQW5NaWtmSmZGU0VmK0l1amZXYUUzcStic3pqazBHbllYVmUveDZscUU3?=
 =?utf-8?B?L2RzVThwT0xnNU9KS1pOazNxSlExYTdpUHNRNVdTWnRSb3l6M0lqb21ac0ha?=
 =?utf-8?B?S2V5ajVockFuQzNFRjB1ZG4xQ0FVb1BWdU13UVJxVEExTjJNSk5abWVWUnEz?=
 =?utf-8?B?S0NEZ0VrMEY4SE1HQUNyaXp0YzlRR0RSeVZoZjZXNUpZYytrb2NTWVM5Z0Z4?=
 =?utf-8?B?cFBtaWlwT2NWUnVIRVZSNVJNcVhqMEMzTXdPWGk0bnFsQitMTitha2pkL2dX?=
 =?utf-8?B?V2RGRDdLZXRiSFNsVEwvWDNScjlUUk94b3p2K1oxN2RiaURzVC9PenBLYWhF?=
 =?utf-8?B?TjBvMENzTjF6QjU3czd5azJzWElGMllYaCtseGdNT21LL1BhQlM5MVROcm5n?=
 =?utf-8?B?QWQxd1NCOVEzbHYwcG5ZdDBkU2w5S1FwajBUSG1RT2Irdy90Z09zcDVXWFNY?=
 =?utf-8?B?bEl2TmVMekJrZWlYUmRyZFl1YlF6L2pLSHhYVmVQSThiNmVCZzUrak5zeHND?=
 =?utf-8?B?eEJmdWJwZVBQbHAwb3E1c1ROK01zcW1ZV09tNG9pNUVhSWwxMkZ5d2xTNlJw?=
 =?utf-8?B?YUFWalBIS09UeW1QSGpELzB4ekZTY2x2VHlwYldQb0VCN21mR2xiTnlvWHJB?=
 =?utf-8?B?dHhxUW4rekJlK2RiS0Q4dTgrdCtiU0pmS3EzeEF4VkxTeFl1eTFTZ1RzV21v?=
 =?utf-8?B?ekhuL3VTcElmanMrWGlmNmVhclN2Y2w5VUpWc21ocFd4dmppYWN5Zz09?=
X-OriginatorOrg: epfl.ch
X-MS-Exchange-CrossTenant-Network-Message-Id: 10973a64-62cb-4f54-6ff3-08de73bdd672
X-MS-Exchange-CrossTenant-AuthSource: ZRH2PFAD84B9AF9.CHEP278.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 24 Feb 2026 16:00:31.8262 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: f6c2556a-c4fb-4ab1-a2c7-9e220df11c43
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: F5cM32XVs4UaMkSeU2SEtuv+iFNC+GElPgGkAWfmrGiOpXI8mpciQirC7vc1M39W4AslBF+xn/jhpIQ6iw6uKhWP+7p8LxGMHzlm9aNxV/s=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: ZR3P278MB1305
Received-SPF: pass client-ip=2a01:111:f403:c213::5;
 envelope-from=florian.hofhammer@epfl.ch;
 helo=ZR1P278CU001.outbound.protection.outlook.com
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

Some registers should be marked as read-only from a plugin API
perspective, as writing to them via qemu_plugin_write_register has no
effect. This includes the program counter, and we expose this fact to
the plugins with this patch.

Signed-off-by: Florian Hofhammer <florian.hofhammer@epfl.ch>
---
 include/plugins/qemu-plugin.h |  2 ++
 plugins/api.c                 | 16 ++++++++++++++++
 2 files changed, 18 insertions(+)

diff --git a/include/plugins/qemu-plugin.h b/include/plugins/qemu-plugin.h
index 04c884e82b..ae711758f1 100644
--- a/include/plugins/qemu-plugin.h
+++ b/include/plugins/qemu-plugin.h
@@ -979,11 +979,13 @@ struct qemu_plugin_register;
  *          writing value with qemu_plugin_write_register
  * @name: register name
  * @feature: optional feature descriptor, can be NULL
+ * @is_readonly: true if the register cannot be written via qemu_plugin_write_register
  */
 typedef struct {
     struct qemu_plugin_register *handle;
     const char *name;
     const char *feature;
+    bool is_readonly;
 } qemu_plugin_reg_descriptor;
 
 /**
diff --git a/plugins/api.c b/plugins/api.c
index ca3e93a194..b2c52d2a09 100644
--- a/plugins/api.c
+++ b/plugins/api.c
@@ -410,6 +410,12 @@ bool qemu_plugin_bool_parse(const char *name, const char *value, bool *ret)
  * ancillary data the plugin might find useful.
  */
 
+static const char pc_str[] = "pc"; // generic name for program counter
+static const char eip_str[] = "eip"; // x86 specific name for program counter
+static const char rip_str[] = "rip"; // x86_64 specific name for program counter
+static const char pswa_str[] = "pswa"; // s390x specific name for program counter
+static const char iaoq_str[] = "iaoq"; // HP/PA specific name for program counter
+static const char rpc_str[] = "rpc"; // microblaze specific name for program counter
 static GArray *create_register_handles(GArray *gdbstub_regs)
 {
     GArray *find_data = g_array_new(true, true,
@@ -427,6 +433,16 @@ static GArray *create_register_handles(GArray *gdbstub_regs)
         /* Create a record for the plugin */
         desc.handle = GINT_TO_POINTER(grd->gdb_reg + 1);
         desc.name = g_intern_string(grd->name);
+        desc.is_readonly = false;
+        if (g_strcmp0(desc.name, pc_str) == 0
+            || g_strcmp0(desc.name, eip_str) == 0
+            || g_strcmp0(desc.name, rip_str) == 0
+            || g_strcmp0(desc.name, pswa_str) == 0
+            || g_strcmp0(desc.name, iaoq_str) == 0
+            || g_strcmp0(desc.name, rpc_str) == 0
+           ) {
+            desc.is_readonly = true;
+        }
         desc.feature = g_intern_string(grd->feature_name);
         g_array_append_val(find_data, desc);
     }
-- 
2.53.0

