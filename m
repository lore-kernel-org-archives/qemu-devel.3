Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0CDE3F3C9A9
	for <qemu-devel@archiver.kernel.org>; Tue, 24 Feb 2026 16:02:23 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vuurO-0001bf-Tk; Tue, 24 Feb 2026 11:02:07 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <florian.hofhammer@epfl.ch>)
 id 1vuuqv-00016h-La
 for qemu-devel@nongnu.org; Tue, 24 Feb 2026 11:01:42 -0500
Received: from
 mail-switzerlandnorthazlp170120005.outbound.protection.outlook.com
 ([2a01:111:f403:c213::5] helo=ZR1P278CU001.outbound.protection.outlook.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <florian.hofhammer@epfl.ch>)
 id 1vuuqq-0001kk-JZ
 for qemu-devel@nongnu.org; Tue, 24 Feb 2026 11:01:35 -0500
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=fm1SpAD2pmG6vFKk0pcCltZsiZ94lJunFCdmcAB8zCDK65FJc1+HI71tXMB9MpaLNzhvf/QQtHUb40MAkL8jTIjwv7R+KYpHTsapRhBOhOyCVoSHG+eU0G1zlXPUnqLuqoWp4bZB7037MiVJzTaXx4AAFaV0idmjHF3CHbxciS4K9TMMIVquBs2wcOPUHi/9yY3arN/bi/THEaSSrzrh8bIDugEHpPNtHcjoE80Hk7vR0GSuXxufuCfEigKX91Q4XnyqrBFQdbFMk8941LHETfPNzTP9jgp0JFjZsJcDFFU0CSfGmnG5dOFiwJLbnsXIgyF/8lSYM+R7XZFjqKu3mg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=0ISy3kQp1go1wwmNkq8lZDiNxD/uu6c9J/JPxYcPwIg=;
 b=QO0/XjGY0ijtL6xArBYoPq9f95MiWRYlbCUAFX2ZPQqbJI0eNiJQOyGE161C26TSA3TEbF1tJEINI1Ro7KMC8dYlBg4kYaLiWKZgZdtu/i0gDat6IE993xQsgv9bwvrvNhSQ6zejOz/8SeBizNw8yIvkIYydJXoQyYvwvRzCXWRO6wAg3Q9kll1GFFFCNZi4007O581U6iJ6HQDQzehputU5v7NWXm3CCGGPwp52n98AeqrJwoD+3p0OYzobCo26YFKyEXWI78b53JQalpE4E7XhnIvio2YBUrXijm5wa2YPexlBchuw29JMth3SyG6z3xLnIv4luX+8M7lAE91vBQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=epfl.ch; dmarc=pass action=none header.from=epfl.ch; dkim=pass
 header.d=epfl.ch; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=epfl.ch; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=0ISy3kQp1go1wwmNkq8lZDiNxD/uu6c9J/JPxYcPwIg=;
 b=sQ+VoVBSL4GL6lMlcQQ+lz3E3yJWZeZAvY3AhEBXqOfN+3GpxnugdbuUbeqQ7T1dkz7+/caYAu5yhHlOl7ACcywdtJR8xoyZNIhbOT6xZj/Bh8NrKscyUwuiW8ja0aIEtTvnedhgCyU9CPGAe+3itFoywAj3HGYsSQrpPACdsFc=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=epfl.ch;
Received: from ZRH2PFAD84B9AF9.CHEP278.PROD.OUTLOOK.COM (2603:10a6:918::220)
 by ZR3P278MB1305.CHEP278.PROD.OUTLOOK.COM (2603:10a6:910:72::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9632.22; Tue, 24 Feb
 2026 16:00:35 +0000
Received: from ZRH2PFAD84B9AF9.CHEP278.PROD.OUTLOOK.COM
 ([fe80::80ea:3d03:40bf:998c]) by ZRH2PFAD84B9AF9.CHEP278.PROD.OUTLOOK.COM
 ([fe80::80ea:3d03:40bf:998c%6]) with mapi id 15.20.9632.017; Tue, 24 Feb 2026
 16:00:35 +0000
Message-ID: <e6be7001-491f-4f5b-9aeb-3d27727d7b9a@epfl.ch>
Date: Tue, 24 Feb 2026 16:58:25 +0100
User-Agent: Mozilla Thunderbird
Subject: [PATCH v4 7/7] tests/tcg/plugins: test register readonly feature
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
X-MS-Office365-Filtering-Correlation-Id: 248fd597-e7e2-4dd9-907d-08de73bdd727
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|366016|376014|786006|19092799006|1800799024; 
X-Microsoft-Antispam-Message-Info: =?utf-8?B?WWd3WFdYVnFFcUJyNGJRU25PSytXOEpPT2s0dGVWaEtrZGNwbXV4SmRnajla?=
 =?utf-8?B?OGQ0dVZuRWZjZEZnVDFTanZtUU9IRUp5MS9LKzJzRTRHRk1aRkE2OWlLaTFV?=
 =?utf-8?B?SXhMOU9VMHdYM0ZCK2ovMkJxVTJZbm82cEpRZ3J5R25MNnZEV3F0Wm1SMSsv?=
 =?utf-8?B?SUVaQVN1L0xkSVYvT3FNWVNvVkQ2c2hDdFI5b3BOTTFrOFJybUp5M1pUOW9p?=
 =?utf-8?B?MTVuQ2M2dVV2cjRvTVhQMERUenNXN1VJZVV6TkpSc3J3K093S3JtcnNQb0Fo?=
 =?utf-8?B?UVhXQk15VzUzb1hZSWszSDZHT3BjcVA4bW16T0RGaTRGRGNYK256YjFsVDV6?=
 =?utf-8?B?TFRNUlo4OUVnOEhZMmt5UmZLbkpiT05abTNLMHAvMTFCRHA2Zzd4ZzY4c1Ax?=
 =?utf-8?B?eGRDVjVaL3NmMng4dWYvN09XbWR0NUdET1hLcXJkQkVsa2lEUlpzbjVacTZs?=
 =?utf-8?B?YmhiUnZOUWYxN3JnTXY3bEdSeE9aNlZIRTRtZVFtL2pxQ21abnczYS96a0Nw?=
 =?utf-8?B?U2hlTFBWR1FzSjgyWEVUbFpYdlFMYlp3NTBVZ3hxM2RtWVZ1eldwUUdRWit5?=
 =?utf-8?B?MW9yR3BESThaeHdxNXIyOHhNWmM0Zkd0U29sZnZvWGpFbWR6Zjh6elh3M0dF?=
 =?utf-8?B?VHVJcG5vdmNFM0NLKzgrWmVlOFFrMU9pTUxYTXNBMHBzQnFtdGtxU21WQ3po?=
 =?utf-8?B?RUFMc2FCaHpMdU9raWU3ZGxDTXlVUlBDalg3R1dkNTBON2RKcHJCYTlyZ3VT?=
 =?utf-8?B?T3hDaE5YVmRWbUZGNEhXQXZBU2UwbUlOL1lkWVo4SmpZYWU2Yld1RVpEcWZQ?=
 =?utf-8?B?cmowN3pRc05GSTdGeWRBNldva1hNUXljVU5WWmlsQW02L0lCSWljVG9uT2VO?=
 =?utf-8?B?OENqZUtlQW9SQ1laQ2NtaFdKWXRkai85eUYrQWh2U0U5RElCTjlZcFBMV3Vn?=
 =?utf-8?B?dHAzL090S3hzUmRxNyt5ZWt3VHFISkMvdGxtQm1oYVBJcEFKaWhxRU90SG1T?=
 =?utf-8?B?TDFqOVUwZmxkNHp6bEFLZmJqVFhxeGkwb2dLOFZTN29SY2hqRXhaS1EwOG5r?=
 =?utf-8?B?blFZU2ZSSlIzaDBlVzNCMC9NNDlieVdiM0JvWW56V2F4SnBRak1QQVhNUGZ2?=
 =?utf-8?B?MVJKL2hmVGhudDJwc21jRmoydnkrZGdDbUNnYTVvdGdrb0JQbUQweDZFTEcr?=
 =?utf-8?B?Vm96Mjh1SGdIVTlpQnN5ZWhiNEtoWXJoYjEvdWsvWkgrY1luaG96VU8zaTZz?=
 =?utf-8?B?TVB2UUJXVnBUZE45N2YzWThCeGpjYXpsUmtkR1htMC9EWVVYUFo3cXhQUEsw?=
 =?utf-8?B?UmVJUDk3WWt6MGEzeEdIVEpxYmdERGNJaVczY0JpaGhEb2JubG9CUnlheDJw?=
 =?utf-8?B?b2FqbVh6RFFmOGY2Znh6VmEzcXBoRkg2K0ZHelFrckh0NGFLeUp5bDFjTVBv?=
 =?utf-8?B?L0dvemtRY2VrRGFYeHkzN0huSlpHUXZ2YXNrL203U0FPV0NTQzhzYXdlSGdV?=
 =?utf-8?B?clNRc1ZGeTI0N3ZnQWxONk1ldVU5d0lScDl3cWpFcDdjUC9seHZJNkZXMXpy?=
 =?utf-8?B?bERSeE9jdjdEOTlFUVYxcktLRVNSR3FhYlRDRlJOdnluNjlkaTNVOTBoVFR1?=
 =?utf-8?B?Nnl3bVpaWUhPelE3OG5RNTR0bjZiVmYyME1hNEdqQ3lSOXFQWnFJdjluTmxa?=
 =?utf-8?B?K3lqZGdmZEZWaXlCd2FYWmgxbkIwdzY3amtpQW5TWFpKOUhwM2xBUXFDSHRI?=
 =?utf-8?B?TEkxd3IvNVhoWXZXQW9kQzk0VUQvR0VaWFVmMFVGQjVZTDVmMGlRemV0SUsz?=
 =?utf-8?B?clNSTlRva0Y4dnNFUGJVY0Q1cnFnMVlia0pqZFhQU0VnTjR4Yno3d2x3T3ZS?=
 =?utf-8?B?cHVGaXlTMzk4K3paTktzQ1ZJZzRsZ2NZOXh2M1BkejlYVFlpKzA0a0s3TXEy?=
 =?utf-8?B?S0ZoQ1B6WVF5KzB5SWJhNTE3aVhzbGFrQUVHVnUvamRHeklIeEZIalhqM0pV?=
 =?utf-8?B?UHNBQTMwNHUvazhyMU5ka010bWdTSlZqWGxlc0hYZy9wUVBZcjl4THFtQ3FM?=
 =?utf-8?B?VHlrWlh1bFJueWZIeHFDTzdtaVBkZzRLdVE2SDRSYjk2alNlUGg3VUtzN3F3?=
 =?utf-8?Q?nB+8=3D?=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:ZRH2PFAD84B9AF9.CHEP278.PROD.OUTLOOK.COM; PTR:; CAT:NONE;
 SFS:(13230040)(366016)(376014)(786006)(19092799006)(1800799024); DIR:OUT;
 SFP:1102; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?anBmcFR3ZHpZNWdrMUtkNWxwY1VZYTZINFpCaER3bWF5SFpyNmZya0FxQWRZ?=
 =?utf-8?B?VGtSOU85aXFuT1V0S0g0N05KNVFpRVE2SmZDaFFuV0hSOCtkZDdiL0hYdzlK?=
 =?utf-8?B?b3c0alJJT2EwWTFNUGVDdmU0V2w2ZC9QOFhrZUUydFZMTG9PZW9QSmpUU3F4?=
 =?utf-8?B?eTN1eE5TNEdMZXV0c3Y4L2FqcU9jTG91RTNaTjlGYmJlT0FsclQzUUtHbm5m?=
 =?utf-8?B?WFRUUHNOeGlQcm83MC9kcmR3Vitucm9JN1RGVFdFS1B4YUd2dmo3NENkZUdx?=
 =?utf-8?B?YW5YWVV1VWQreGlwZ3pjandpTy94L0tLMmNIZ0t1amVvSDFoSDFxdjZSamw0?=
 =?utf-8?B?LzJpRTd3eXpuRGhzOHViTFZ3SHY1WUdZSVRrMGttQ09PTERBRGpyYmxrM0dD?=
 =?utf-8?B?TWJuN28xaDAycEJTTTkzNk1oS0ZPNlJKclpBbGNXRURaYThCdTIzWTM3VTV1?=
 =?utf-8?B?RkNMTUV3ZFFtQUtZUXoyWEZVS0ZXdk0yVUxsM29RZ0QyNEhyVTY4Tjc3OXF0?=
 =?utf-8?B?S2YxRldzcG5XZlhmU2Z0UlRhendKeU9hUFExcVZHaVpxUU8xcHl0cGxBSVVW?=
 =?utf-8?B?UTNtTVNObnpDbE4yVC95c01aakxELzNkeEdiR0hyVVhqMTlCMkxBTE9pSDVQ?=
 =?utf-8?B?UndsNjkraUVQSjVBK2dHK2ZxWGt5RTg1clhlcjVGVDI3eXlma3E4SkJVRGFz?=
 =?utf-8?B?NGJHRFU2OXNlSkdkY1drVWt3cTVxMSsydHloRlJaRmlYeVFoYXI0STlCRjBJ?=
 =?utf-8?B?NllhK1ZaTDFIMjluS0t2Ymc0Z2I2TE5XU0RRaXlXdjl1QmRzeXlLSk5IMHlE?=
 =?utf-8?B?eVF6a1JkUUdlRWdhL1J3YnJGTWJmaHhCZ3R1Z3ROT1R3cEE1REI2eldkZTBp?=
 =?utf-8?B?YnREWmJWdDJmNnd3T2RSaWVUR1RJMmpwQnlGOXcyVnpEeTBIdmExQXVDdEtQ?=
 =?utf-8?B?RGt6MVdBZlRKVFVIU3FrbTVFZElITzU1QVYvRWFVby9iU1VxZnMzM3lTUTNv?=
 =?utf-8?B?Vnpmd2NMVGdwcE1SMFR2UC9DWEM3Q2NvblEwZkZSbHVKelZ3M2diUnNja3RG?=
 =?utf-8?B?Z1hGeVVjRnVvS0Nwbm83UnVCYTQwUExwdVllM1REQzk1VnR1UENyS2wwZlI2?=
 =?utf-8?B?OUc2OGxNaE1ETGx1SXVGNnZGZk1zc3c5b2wyWkdvcFA3anJYcFI5eDhTTll3?=
 =?utf-8?B?OWNaMkwvN1FGNERQb3ZZZDh1aEowM3UrVmp0YkhiRFYrRXAwbjNCTWFFNUtr?=
 =?utf-8?B?czEranZPd3BFazFueHB3WCtqZ09iKzFrTnlOTVVBL295QTFpWDNBY01KK0ZD?=
 =?utf-8?B?S1pzQjQ2K2NTcThNa0RoTUxSSGYxVVdzYnpyR1Rzd2QraDNDelJadmRFV1Jp?=
 =?utf-8?B?R0JEblhadzF2Q2Z1RWVWd09GWDhTK2FGRUFXSXpxd2kyNHBxSmtxNFZRdk1Z?=
 =?utf-8?B?U1o2R0tSV0M0UEdWMm5XcXlsUkdRM1NoczFUNER0V3R4MGVIMmZ5eWZQSVdM?=
 =?utf-8?B?SGJMQytNZ1MrcTF3SG1GWGQ1V2o3bndnZ3o4eXBucWM3L0c5Qm05cEFRcGJ6?=
 =?utf-8?B?N00xUkx1TW5mY01qc1pBdDhmcTZjdEUwYUhKUW5BcDJ2QlBoU3hoSlNYUnNw?=
 =?utf-8?B?OXNWV2x4dnBtakdkSHUydjdSZWJ5aHR4RjU4Y2JVS2gzOFNlQStoNFU2N3lz?=
 =?utf-8?B?S1FzMzZkdjU4NjJiNVVWYW1TbDNLclFXWkVzZk1WZG5YV05iK2hKZ2RIaXdk?=
 =?utf-8?B?ck51YmxveTJOanhkbys5ODRma2RaYkhTcFJOVnVkZ1IwbFI2Q0RBWDZuMSsy?=
 =?utf-8?B?QXYxdGxTTUcraHJkdmpyNW5GUHlsdHM1Z0YrMmc0WE9sRHV6VWhORE5ld2Nw?=
 =?utf-8?B?ZGJvL0JNTGxZQUt4T3hpQmZxM2ZaMWRUa0lNMW94SVBtOXpOaWlBbGVZMU42?=
 =?utf-8?B?TFpoZU1kaExyOGhJakNEMHdSR2hHbEpYRDlHYTFLbmZBa1pJVldrVHBhaGhY?=
 =?utf-8?B?U3FaSWVsT2x4MUtJL3RnRkN2Yk8vcytrSjUyMm1uWElLVkdVa0VLcmZnSXBC?=
 =?utf-8?B?L0xvL0Fib1JBVHZOZmFGQmIzc2pWb0lBL0oxdUdUeENGU1g1TWo5d1lGZU1C?=
 =?utf-8?B?NGwycUdOcXYwS1E4QzdmeVRSU21keTFIeExlT2dNMG4vaHpaWnFGcmV0QWd2?=
 =?utf-8?B?NzlEZVM2M0RhZG81d09raENHZ3JUMXI3OWJ6OFB1SmJMaG4zVEZVNUVTSE11?=
 =?utf-8?B?N0s0aXh3Mis0TGlCeTlYbmQrSGhWYzBUbmpwejFPSXppYTMzaytvcGgzK3RO?=
 =?utf-8?B?MXNzTVdTV3lZRU9PQVNSL1hxY2hVKzVmM1AzcW1nZFVQS3V0Vm9sQT09?=
X-OriginatorOrg: epfl.ch
X-MS-Exchange-CrossTenant-Network-Message-Id: 248fd597-e7e2-4dd9-907d-08de73bdd727
X-MS-Exchange-CrossTenant-AuthSource: ZRH2PFAD84B9AF9.CHEP278.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 24 Feb 2026 16:00:33.0200 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: f6c2556a-c4fb-4ab1-a2c7-9e220df11c43
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: Ua9ZVjMTILR8aqdV0XsnkffQnCk/ffm3u7Mjk/5bTWHYNlowhthQ1OvmHjkWfnJ3bHOWnN/21bIgUF4CyQI6g7JgA6wVnYvmNh4Ari5ihwI=
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

This commit tests the readonly feature for registers exposed via the
plugin API introduced earlier in the patch series.

Signed-off-by: Florian Hofhammer <florian.hofhammer@epfl.ch>
---
 tests/tcg/plugins/meson.build |  1 +
 tests/tcg/plugins/registers.c | 68 +++++++++++++++++++++++++++++++++++
 2 files changed, 69 insertions(+)
 create mode 100644 tests/tcg/plugins/registers.c

diff --git a/tests/tcg/plugins/meson.build b/tests/tcg/plugins/meson.build
index c5e49753fd..5005aa8dc9 100644
--- a/tests/tcg/plugins/meson.build
+++ b/tests/tcg/plugins/meson.build
@@ -6,6 +6,7 @@ test_plugins = [
 'insn.c',
 'mem.c',
 'patch.c',
+'registers.c',
 'reset.c',
 'syscall.c',
 ]
diff --git a/tests/tcg/plugins/registers.c b/tests/tcg/plugins/registers.c
new file mode 100644
index 0000000000..a7bd692225
--- /dev/null
+++ b/tests/tcg/plugins/registers.c
@@ -0,0 +1,68 @@
+/*
+ * Copyright (C) 2026, Florian Hofhammer <florian.hofhammer@epfl.ch>
+ *
+ * License: GNU GPL, version 2 or later.
+ *   See the COPYING file in the top-level directory.
+ */
+#include "glib.h"
+#include <inttypes.h>
+#include <assert.h>
+#include <stdlib.h>
+#include <string.h>
+#include <unistd.h>
+#include <stdio.h>
+
+#include <qemu-plugin.h>
+
+QEMU_PLUGIN_EXPORT int qemu_plugin_version = QEMU_PLUGIN_VERSION;
+
+/*
+ * This callback is called when a vCPU is initialized. It tests whether we
+ * successfully read from a register and write value back to it. It also tests
+ * that read-only registers cannot be written to, i.e., we can read a read-only
+ * register but writing to it fails.
+ */
+static void vcpu_init_cb(qemu_plugin_id_t id, unsigned int vcpu_index)
+{
+    g_autoptr(GArray) regs = qemu_plugin_get_registers();
+    g_autoptr(GByteArray) buf = g_byte_array_sized_new(0);
+    bool success = false;
+
+    /* Make sure we can read and write an arbitrary register */
+    qemu_plugin_reg_descriptor *reg_desc = &g_array_index(regs,
+            qemu_plugin_reg_descriptor, 0);
+    g_assert(reg_desc->is_readonly == false);
+    success = qemu_plugin_read_register(reg_desc->handle, buf);
+    g_assert(success);
+    success = qemu_plugin_write_register(reg_desc->handle, buf);
+    g_assert(success);
+
+    /*
+     * Reset the buffer and find a read-only register. On each architecture, at
+     * least the PC should be read-only because it's only supposed to be
+     * modified via the qemu_plugin_set_pc() function.
+     */
+    g_byte_array_set_size(buf, 0);
+    for (size_t i = 0; i < regs->len; i++) {
+        reg_desc = &g_array_index(regs, qemu_plugin_reg_descriptor, i);
+        if (reg_desc->is_readonly) {
+            success = qemu_plugin_read_register(reg_desc->handle, buf);
+            g_assert(success);
+            break;
+        } else {
+            reg_desc = NULL;
+        }
+    }
+    /* Make sure there is a read-only register and we cannot write to it */
+    g_assert(reg_desc != NULL);
+    success = qemu_plugin_write_register(reg_desc->handle, buf);
+    g_assert(!success);
+}
+
+QEMU_PLUGIN_EXPORT int qemu_plugin_install(qemu_plugin_id_t id,
+                                           const qemu_info_t *info,
+                                           int argc, char **argv)
+{
+    qemu_plugin_register_vcpu_init_cb(id, vcpu_init_cb);
+    return 0;
+}
-- 
2.53.0

