Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 951EACCD19A
	for <qemu-devel@archiver.kernel.org>; Fri, 17 Oct 2025 08:51:07 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1v9gAM-0001MY-Rz; Fri, 17 Oct 2025 04:50:26 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jan.kiszka@siemens.com>)
 id 1v9gAK-0001M4-DQ; Fri, 17 Oct 2025 04:50:24 -0400
Received: from mail-norwayeastazlp170130007.outbound.protection.outlook.com
 ([2a01:111:f403:c20f::7] helo=OSPPR02CU001.outbound.protection.outlook.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jan.kiszka@siemens.com>)
 id 1v9gAE-00068Q-5q; Fri, 17 Oct 2025 04:50:24 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=VRlfdDORN3jz6eHohP+T/63GtqRNg0nUtkz284zckiGjAwgU/UMzlqNxq9DCtUL58Doz6TuioSJV36I4E22Zdo0k+2yI1J6hZhRixH4K08xEqLAmS69SJEZ2JS8LYxuTZy71m6Ws5F6G8Z2y6LpW8vkIqFtfsxmbu2cYO5aGiDaL2cwP9YOFnVLlualyyzgZ5Qqg10EMhso4SPwMFZVz/ETirA4TjQq9/fzQyDw1XCOCyoMzCkTD57FalDsW/soOxlzeuGibuTayGj1PD5IGKTIj/PSpZNPvue9O93pDyu0jkHplmfVodVjtCEiYeXvNSL9cWAICw04YXyNxFQXckw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=llW401XEZ9dRrVb00KgisR+aVaQh1TxCVlz1Km0npKQ=;
 b=nhZ16k60itftITc7HhjoF4BNuNolkBFltkjlwh35o5wnG172sJxZZNsxs8ZmtyfdmHJhxn66/SgZ0dB06RWLFU+YyNTlPdPXGlTDHUNchQDVw8f3Z/e6PCGH/7CrZE/UHE1sG1D0N93xgdkIVMDnX1j2bufzGYIg79MXVuktb+NLBJBjQWI9AfoKO6bwmdAndmRhkFwG9a6FfC9aKv2NiR63cz53qHB9NW/ZnuyyiXBNoQP+wWfmcHYAQzwctbpC+Z4EgMIEnA96gltetq+AOAFcLrYUXGA6qF/J5vO7MEFrgNe1WR6s09Z3nypnNhauDfxlbAI3Hu/sSJRWALbuXg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=siemens.com; dmarc=pass action=none header.from=siemens.com;
 dkim=pass header.d=siemens.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=siemens.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=llW401XEZ9dRrVb00KgisR+aVaQh1TxCVlz1Km0npKQ=;
 b=hbi96PA3NkoAKOo+M1b84wdrX/jpcSwFgaakz93n3JfoQPQPhAryEcQUdqjoV4edLj7bI97tBrkAHZiYmjDXIVHLcvASRsf8oxCv0K5X+vjinXOU9DYzS4LGOX76MsddAxE8AvTAcbgwelaUKK4FY9rVVdiU2eetAZvkdCwnZhXOZmIBW3eP+CnHr/2X+U5kMwWiDX3hlQroZhzPVav8c72Ic9eo9yhJL6vyGf6bYnMftg8/kEkZWr7Genf8nGxK+Xg2XVsRNMNBdsytZ9mFq7MN4yS/UsOa1hGg2mXcjgqsF2VkAPWJdwo6WieTQYlK0/FZFhHF/9JVVVEDzEYvlA==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=siemens.com;
Received: from AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:20b:588::19)
 by DB8PR10MB3498.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:10:13e::12)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9228.13; Fri, 17 Oct
 2025 08:50:06 +0000
Received: from AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::8fe1:7e71:cf4a:7408]) by AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::8fe1:7e71:cf4a:7408%6]) with mapi id 15.20.9228.011; Fri, 17 Oct 2025
 08:50:05 +0000
Message-ID: <a277de12-e5fb-4007-a7de-30f4735955f2@siemens.com>
Date: Fri, 17 Oct 2025 10:50:02 +0200
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v4 1/6] hw/sd/sdcard: Fix size check for backing block
 image
To: =?UTF-8?Q?C=C3=A9dric_Le_Goater?= <clg@kaod.org>,
 qemu-devel <qemu-devel@nongnu.org>,
 =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>
Cc: Bin Meng <bmeng.cn@gmail.com>, qemu-block@nongnu.org,
 Ilias Apalodimas <ilias.apalodimas@linaro.org>,
 =?UTF-8?Q?Alex_Benn=C3=A9e?= <alex.bennee@linaro.org>,
 =?UTF-8?Q?Jan_L=C3=BCbbe?= <jlu@pengutronix.de>,
 Jerome Forissier <jerome.forissier@linaro.org>, Warner Losh
 <imp@bsdimp.com>, Joel Stanley <joel@jms.id.au>,
 Alistair Francis <alistair@alistair23.me>, Alexander Bulekov
 <alxndr@bu.edu>, 'Jamin Lin' <jamin_lin@aspeedtech.com>
References: <cover.1757854006.git.jan.kiszka@siemens.com>
 <48930c1092424d22dc2171140378de19e0814ef3.1757854006.git.jan.kiszka@siemens.com>
 <c144202b-0d99-4507-8a57-35df1ece3cc0@siemens.com>
 <2070f7bb-cd1a-448f-ba87-50d75e24f4c0@kaod.org>
 <b09cd869-39e7-4a62-b452-4ea39ccf4df0@siemens.com>
 <e992011b-ac3f-4770-97e8-3c0321410e72@kaod.org>
 <aa63efc6-8edc-4db4-9221-a1a54fc1cdce@siemens.com>
 <8b14bde0-2ca8-4b45-a41a-f1459a7710fe@kaod.org>
 <2c028368-b840-4f22-bb5f-a9ffcfec26c8@siemens.com>
 <aaa7ee12-d74a-48b2-8175-097837f1d611@kaod.org>
From: Jan Kiszka <jan.kiszka@siemens.com>
Content-Language: en-US
Autocrypt: addr=jan.kiszka@siemens.com; keydata=
 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
In-Reply-To: <aaa7ee12-d74a-48b2-8175-097837f1d611@kaod.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: FR4P281CA0310.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:f6::15) To AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
 (2603:10a6:20b:588::19)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AS4PR10MB6181:EE_|DB8PR10MB3498:EE_
X-MS-Office365-Filtering-Correlation-Id: e1ce8213-e25d-400f-b2aa-08de0d5a2b37
X-MS-Exchange-AtpMessageProperties: SA
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|7416014|376014|1800799024|366016;
X-Microsoft-Antispam-Message-Info: =?utf-8?B?RkxBdmhFWEtRcEVONThtWldaUXpnYThoRXZVdmNZQzVaWXBxa0VEbGpJUzEy?=
 =?utf-8?B?Y01CSUUxRmk1TDgzejlBWWRhcTdVb0VJeE1uamdDU2VGTEQrSzAybzZtTnRj?=
 =?utf-8?B?bXZNekxSQUxLRVhZS0RvNlN1dzU2RFJ5V2J5WGZJSlR5VXN1T2lSWk1Sc2RN?=
 =?utf-8?B?dzRhcDZqS25GK2ZUUmw5RDcrUlV1blIrQi9ReDBxckFJL0tjOTZqTnFPS0N4?=
 =?utf-8?B?M0dhOXlYZVhQcHdVTzVRUUFwdmlyNXRGV296TnBrRTJSa3lDQ0RScmVKVGxD?=
 =?utf-8?B?eVdFRmJ3Z2Z2c2l3Rm5Bb0hmaXV3Y2h0c2JVcW03bnFFMitEeVJNRk9hQTBW?=
 =?utf-8?B?VU15OFAzM0hTUTRRcmdrSTcxK2x2aUZyd01YcVVlbUMyU2pJVXF6TXg2WTFI?=
 =?utf-8?B?QjlmeVJUbitualZPcnY5V3NDSkU3RitYeUtpWWlqZlhOeW56RDdmem9Pdnd3?=
 =?utf-8?B?NncrUk5OS2FVQkpmeFdYZ3BKODVHZzhOY1pNc1FrNlBIR3U2OE5JYUZvU2x5?=
 =?utf-8?B?MVo3WCtzZXdMdm1TczEySzV0QTNIamozb2JDNEdYNkt2TENrL2tTZjJjVGVp?=
 =?utf-8?B?WUJmNGhEZlpRTHArUjdFU3NKSjQ1ckVPUk1GUE80QkJwa3ZTRVArR3NqQktL?=
 =?utf-8?B?aDBNL3hBQis1bmorRjQ5aU1GWFJhZ3JScGpuTGVJbVduK0taMW94VlYzalh5?=
 =?utf-8?B?VnpxV2h0MDMxeXMxL0VDSU9HZFJxbDZkV1kwVWNnME9iaDc0eHp1ZnRRbHVE?=
 =?utf-8?B?N1RYSnY0OHc3RTgwMW9rVUVpSncrdWk3OEduaFRGNFpXaW1qOUkySnYrMGkr?=
 =?utf-8?B?QUFzT2hpVisxbGN6b2FMOWVhRFlyUHdLQ0RCSGs4K2ozVkRueDh5RUNSU3BM?=
 =?utf-8?B?S0pramkvUXJFUVcxM2pWZkpKaVRnMENjMU1pYVhNdTd4QWRJdWRFcGg3bEJt?=
 =?utf-8?B?NWF0elVPdFNIMEZGL3luZTRuUDkyY05jaGtFK2M3L2tqeE96YjhQVnc3bnpL?=
 =?utf-8?B?MXdQUmVLM3BCOWdxVWdEODhmOUVtRld1VCtwQXFlTHBiTVVsOXR2WEUxSzR1?=
 =?utf-8?B?ZU9RZ0VoN2dsSWV5Z0Q2Qi9LMlNiT2RqQU10VC9rVHprUjNEWEYvN1Z4Q3gy?=
 =?utf-8?B?VG8rRW41STZsbjJCU2VqeXNKYVJDNDJqaklWb0UvcmF1eFVnOEh6MnNidFJE?=
 =?utf-8?B?NlUrZzNuZHVpV3cxOC9WbDR1Z1R3N3k3anZaSUJFVmFQS2oybG5WMXY2cmdE?=
 =?utf-8?B?ai9laE4vNmkrbHhrSGUraVdtOXA4VzRQNTNsTEJjNWRXTkJLb3F0Ky9FTm9M?=
 =?utf-8?B?RThhclh6OWk3aVQrTHZMa3g5V2sxK3ZLTEdVdU1HK0psSGE5RUpFVjExdzlo?=
 =?utf-8?B?UzN2aHBrQ1ZSVDQxMm5abDU3bEdta3VGenV6dWJBRjAvYU9hZVlTR2ZHQkM4?=
 =?utf-8?B?VUVhaWlud0c0WGZxNmd3T2lQSjBnSlh4dk8zUzkycFNTY0o0TjBiaHc4Kzhq?=
 =?utf-8?B?ZUJUUVhlMGFOZUVXYXN4YjJ5TlJ5V2RpTjZxbEtzQlgwbjBjaCsrY0RvbTNV?=
 =?utf-8?B?ZWhXREJ0cWFNVG1SeVpnTCtsNXdUNzhhNlluZUw4Z2xuV1JrTzQrRW13WEw1?=
 =?utf-8?B?dGZwUVdIcG9rZ1NKd2xLbnZHaTY0My9XSDVJSndIdzdValEwc3JUN2o5d1c0?=
 =?utf-8?B?WjVDemp0U3NGbC84UHBLVkFHeVdmdmRCZ0hiTW9rNzZLUzIzZGZTd05XcWgv?=
 =?utf-8?B?ekZzelkvcWdVZVlncXFucW1LUWk1dkVCd3FhVnhOOGNhek9BWFdERE1iYzNM?=
 =?utf-8?B?R3l2cnp4VmpWbmJWNlhWMkdLSWhFcHNUNGJKNmhoTEgycmdrSG9tTlo0TGJm?=
 =?utf-8?B?eTlzR3F1RjN0NjJVL3dFRHJWL2RWSENrSWFPNUpCRlkvdEVCa0ljYlFINjBG?=
 =?utf-8?Q?sExUpR/4BN2ujU+fdgDRc+NOfmTOxzSx?=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM; PTR:; CAT:NONE;
 SFS:(13230040)(7416014)(376014)(1800799024)(366016); DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?RDNTbTdZT0ZVcW5ERGI3dkNYay9EKzJkSTNqeVR6bnlyOVIrWDZqUGhWRzRp?=
 =?utf-8?B?L0ZId3hId25IVHFaeWZoTnZkUGpHT20rbmFXRVg5SHlJQ3hRdHJpOEQyc0t6?=
 =?utf-8?B?OUErbDZObVllZXZ5OG5YZW9YZG5RUVM1NGJaZmQ0TUZZUFdML0tKaGlMNUdu?=
 =?utf-8?B?dnFONVhDZDVtdDhaK0w3Ly8yaDBiSXF2OXY1YVBhdFRYS1lCazVEUlhxRWxl?=
 =?utf-8?B?bWRUalFuU0kvUnJTWnZlQi8yc1J2NzVEUFFOQkdPcldoblFWOFVlNW14ZkNi?=
 =?utf-8?B?ZWpnanY2Qkl6UmE5R2tDVUszM043UEpicGdzMUtPb25oeTMvTkltRjBVbjZj?=
 =?utf-8?B?UFkwU0NBdGptUU82bS9EcXVTS3g2YWhuTmcxeXhzU1R1YnlVOE80OERWU3Ft?=
 =?utf-8?B?TXFLOGs2WmdmcDNIb1VtQXN2ckRLcU1GYTNJdW5PUHFFUDBLUzhWaEdDeWJm?=
 =?utf-8?B?RCtnR2syTGErZUlDck1WdFFUSFV4UkhvSmR6REVpdmduSitkbGhQVmIvK1Fx?=
 =?utf-8?B?aCtlL2I0OEYvNXFPUHRTZzIwNXV6cEFmNUw0NlVyWUR2SUhOOGxEK3RtSTZQ?=
 =?utf-8?B?ZVhXa203UFBRMW1jakUyTlV6T0FRbnRSdzVGNUVYa2FBTGY5WlFOUWl4RXZL?=
 =?utf-8?B?TWNjT1YzY3hGYlZWYm9IdzZZWDI5djhtZE9LbUt2SHZFQ3RJS2hWSEhHUU1L?=
 =?utf-8?B?bU5YSDVZVHlialZhdW9aUEpsUDVRTGNCcHZtU3BtaUJ4MU9TZ0dHZDMwZkpB?=
 =?utf-8?B?alR6ejdUekVnM21KbXFaamZYRk1VWHFWMi9lMnpOQUdIV0ZRbVM3Mmh0ZWhr?=
 =?utf-8?B?U0piY01xTVg4RkxMRFJScjRUVGxrL25YaUVTLy9nT2k1OVo2UVFVMWUxMlpy?=
 =?utf-8?B?WGgxZ1ZBcEVsOForalB2QndqeXBUMDVRc0ZBelZnRitPNTZkbjJQejg5NTBv?=
 =?utf-8?B?YVk0TjlNcldrUFFDV1ZnMUtBUXFVbFoxNUcxY0VkMzBHTFAyekY4Z0x0bVB6?=
 =?utf-8?B?Q3A4V3FUVXpydE91UlVjRS9XelhiQzdYbG1VWTFtUUZiQk5DS3VHaXZKVXpj?=
 =?utf-8?B?M0xSS3gzbGJGZ3NrQ3JESVEwZW5kZjI5bFZybGNPZitTT0QxRDhKc0lHa0h0?=
 =?utf-8?B?Wmkzd3FTOXlaNFpBUzlOV3JBcHJ0Q0lOWEdxUmVNTE9ISHNCTG9sb3hCdjJP?=
 =?utf-8?B?S3UwdTVLVUJwKzEvbW94NFNrRmcva0FBdmNPT1p0UmZMT2tkbmJHTlphU1Nl?=
 =?utf-8?B?TDlSWGUzRC91Tys2Q09Mb2dpb3U5SVlEejByM0g5cFlsOWZISXFMLzM2bENm?=
 =?utf-8?B?ejhFYjZFbVhaNVRhUzJLMzlPenl0R3BzUlZXNmVob2d3TUU1T1FaT3U2V0RS?=
 =?utf-8?B?dEpPL0FMT0VmN1ZoWFB0MkRUNi83VlM1N2dzMEtaN1N3d1hWcUdkRWU5bkIv?=
 =?utf-8?B?RVNySjVrUmhnTXFkU3UrNlNDbkZiMFErSWFQSHNybXBWeWF5elpPOWFpNDJL?=
 =?utf-8?B?bkpXNU5JVEN0WkY0cWpRZ0hPdjhnRFlkUmpYZ3RrK2RHNkJMNVdjRDZxT2FB?=
 =?utf-8?B?ZE91bFhBeE8yQ3ZzYVN1Rlord2VWdktGaHpSbWkvMjNMMUtQL09mK3lCUWJK?=
 =?utf-8?B?djBOaWw2cGx4WUtyUks4WFZJVTZpeWlqRUxWOXlnRG4xdEJLbUtBUmpsdm0r?=
 =?utf-8?B?SE5kcG1rbExjN2x4OTZmM21FOW9scFhvaUNOSmprZ1cwZjVCUFhLcEdaMnNN?=
 =?utf-8?B?YzdpVFpLM3FxWGJPMXBkeURmdVR6MHJ0RGMwVFJQa294cFRRZEwvd0U0M0Z2?=
 =?utf-8?B?bmcrQk9HTVl0UnE5MFY1Ujg4bkZKSE9NdG9aS2RJTTNTek5vazkvbUpqdVJG?=
 =?utf-8?B?V096bFZhWURkV0k1bVhPdGM1NnZwb3U1NkFEdEdoN0wvNFhubGlsR1A2d0VV?=
 =?utf-8?B?Rk4zUHZ1SzlHVEZ2Kzd6RTFxMXA4M2JrQXJYNzdrVG9HbkRlM2kwUlN1M0pt?=
 =?utf-8?B?NHY4UVdrazh4b1crdytVZUJGY29OZzcwbjJmS3NWNTF5Z0hTNkRtUS9YbVBC?=
 =?utf-8?B?bCtJRWJFanhtVy9acmthSDZvbHdONXpPVDJnWjFKS0dWQjNEeHpDdDJMdlF5?=
 =?utf-8?Q?MhheNAY8Znc3vbOsqE5sKlqMn?=
X-OriginatorOrg: siemens.com
X-MS-Exchange-CrossTenant-Network-Message-Id: e1ce8213-e25d-400f-b2aa-08de0d5a2b37
X-MS-Exchange-CrossTenant-AuthSource: AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 17 Oct 2025 08:50:05.9205 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 38ae3bcd-9579-4fd4-adda-b42e1495d55a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: GzUx6b7Hq1a3yT6CvY5f6qZV20xjTvB8D4akqMprd0BRCVNXooojGr7wX4f585LfeS5sU7v0f8Spuzv0g+g7GQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DB8PR10MB3498
Received-SPF: pass client-ip=2a01:111:f403:c20f::7;
 envelope-from=jan.kiszka@siemens.com;
 helo=OSPPR02CU001.outbound.protection.outlook.com
X-Spam_score_int: -13
X-Spam_score: -1.4
X-Spam_bar: -
X-Spam_report: (-1.4 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_MED=-0.271,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 FORGED_SPF_HELO=1, SPF_HELO_PASS=-0.001,
 SPF_NONE=0.001 autolearn=no autolearn_force=no
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

On 17.10.25 07:31, Cédric Le Goater wrote:
> Hello Jan,
> 
>>>> Just to avoid we are in deadlock: My understanding of this issue is
>>>> that
>>>> it is not a fault of this series. Am I right? Or am I supposed to
>>>> address that as well?
>>>
>>> Could you add to your series :
>>>
>>>     https://lore.kernel.org/qemu-devel/20250930142448.1030476-1-
>>> clg@redhat.com/
>>>
>>> and retry the aspeed machines ?
>>
>> Yes, that patch resolves the issue above.
> 
> A similar version is now merged.
> 
>>> I am afraid more should be done to run 'make check' with your series.
>>> Maybe set 'mc->auto_create_sdcard' to false for all machines ?
>>
>> Who should do that?
> 
> /me looks at sd maintainers. Thanks,
> 
> C.
> 

FWIW, v5 of this series is coming: I found an issue of this patch /wrt
unplugged SD cards. make check now passes.

Jan

-- 
Siemens AG, Foundational Technologies
Linux Expert Center

