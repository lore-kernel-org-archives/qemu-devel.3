Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C8D3BE95389
	for <qemu-devel@archiver.kernel.org>; Wed,  4 Feb 2026 11:39:34 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vnbEH-0007MT-6B; Wed, 04 Feb 2026 06:39:29 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mark.caveayland@nutanix.com>)
 id 1vnbEE-0007M6-I1
 for qemu-devel@nongnu.org; Wed, 04 Feb 2026 06:39:26 -0500
Received: from mx0a-002c1b01.pphosted.com ([148.163.151.68])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mark.caveayland@nutanix.com>)
 id 1vnbEB-0002tJ-2Y
 for qemu-devel@nongnu.org; Wed, 04 Feb 2026 06:39:26 -0500
Received: from pps.filterd (m0127838.ppops.net [127.0.0.1])
 by mx0a-002c1b01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 6145lODA1749214; Wed, 4 Feb 2026 03:39:20 -0800
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nutanix.com; h=
 cc:content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=
 proofpoint20171006; bh=iLhJkSDSVlmzKciOKxbuO7MhIvSn4q58QYvIxLnin
 Fs=; b=N3Hpq8Vx36X6EuewrpEeN76yUbuMj9auly4+uuJTYvT9fePT6LdRqQdFq
 k5Z/vdHgDpG2wnVMh84R26lizEMIrxco76NRr4srB7GBWUnuGbNnt1r1J+ejycZz
 3HAvcTzNvdvMNVCzwqgEfqQISoI8IPQZPMIBVHiszMnn27UMXkNNw2wD21OYRnk5
 t6rg6plGSVgbaZ6ovk9KTaboMEcKZmaSeOY3l9wbD85IrfSDQj7ZcAOWUuAuo09n
 Lac2x0HHjQd7TSq9q/DI/+ihT8YTazLSDkJ4tmTF/TFFwZOCeYQCrfLa081Hj2Cm
 iWJj9YLAgEl8HlyIXaY9kFnBKmMZQ==
Received: from mw6pr02cu001.outbound.protection.outlook.com
 (mail-westus2azon11022090.outbound.protection.outlook.com [52.101.48.90])
 by mx0a-002c1b01.pphosted.com (PPS) with ESMTPS id 4c2ympwcmu-1
 (version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NOT);
 Wed, 04 Feb 2026 03:39:20 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=E54gXwmeEp1zSdftbLYv76mYrhM/Si+LDFd73Jpl9gcegb16yFXsZEZsyyhh2j+W14gmWDuUKWQSnsDG/kFy7mqFIFF3sCagcGJyZsgZgE1yxCbIh9YA3s58HIAsf5NSlh+9jTd+2NnlOCwepmJmHnO4nAVOsYVaoGgmQ+wNahU5SZ3PrUirD2hYP31Z2PRe2ztTYL5tDcbhOf1PNi7SxL2Ja+DmfsEToRk5v8zCGDdvFbS2+jhFUO+7RvM/2pk9FF1I5yfZsiXJkt01FL3jiFwwY+BDvEeTbUb2QMyXvlj1XKuFiTvSm2o8gJkS79lsVooA5VWWMC0sndJFAI/IPA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=iLhJkSDSVlmzKciOKxbuO7MhIvSn4q58QYvIxLninFs=;
 b=kfs4u10o+WSPos70kBFbeIJFFRAw5uhgr5UDjH3AykzefgbW9RmIk4iPFiVGeSUE39DRUXtLKv9E+IIWFP//KRabzpOoxChqXXPHwKAxurcmPGP5/s2eD/8IUmE9tNTyDTmuwB7/GJssBS0Lr5fdJC5CtGtTVuSnnKTU32/ehoYWcRmiVDuU3I8T7NCH1gEs2VaBaSJy5selpiAx986vqyMOCP+mTOoWR/nCcKM9R4axVCNcK1rC4GExR0tHv0kN/fBUOZw+azSfL/vCpW+T1COsF/AIVa5fQr/ZbH5RMwqbWnMf4ykSUqmkhqXPoCNUCAEr5nQ1/rL7ab9U5bG7PQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nutanix.com; dmarc=pass action=none header.from=nutanix.com;
 dkim=pass header.d=nutanix.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nutanix.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=iLhJkSDSVlmzKciOKxbuO7MhIvSn4q58QYvIxLninFs=;
 b=hSbFivC4aicWl1ue51Zf0FCzE6IDxrTuv/MKNjeTguJUz4kYkT9iKFT+dFyPTIUPEHsC46cM86K/8A5ra9+rxQtgRE5Wk/ihXjtIKSEW8768f6pmEw25KYkibtmKeiw1i2MIR6KgypjpjCzV+sdk+2p9ziLU8u5l9jmVlE8UfEPybK0CL41hNn0N8gTzhPXBP02nMiuw76As/CRsqF96wt1vvFtHbt8grU/bXNhuBE6MHJ8aJj9Hf+AGaHJMoZZgOLjO7ayf+K0OvNChrSWOtaytfNayBvzx42Qrc/oR2pk086UYdV7dDhgJF65YbVrFHJ/YhiC8Lc+xl+bau/SPQw==
Received: from PH0PR02MB7159.namprd02.prod.outlook.com (2603:10b6:510:16::8)
 by DS7PR02MB10889.namprd02.prod.outlook.com (2603:10b6:8:269::22) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9542.12; Wed, 4 Feb
 2026 11:39:19 +0000
Received: from PH0PR02MB7159.namprd02.prod.outlook.com
 ([fe80::8e97:bc32:822c:b250]) by PH0PR02MB7159.namprd02.prod.outlook.com
 ([fe80::8e97:bc32:822c:b250%6]) with mapi id 15.20.9587.010; Wed, 4 Feb 2026
 11:39:19 +0000
Message-ID: <872fd135-2a1d-4001-9d42-b66faeb99b54@nutanix.com>
Date: Wed, 4 Feb 2026 11:39:16 +0000
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 28/37] audio: make create_pdos() private
To: marcandre.lureau@redhat.com, qemu-devel@nongnu.org
Cc: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Gerd Hoffmann <kraxel@redhat.com>
References: <20260123074945.2563196-1-marcandre.lureau@redhat.com>
 <20260123074945.2563196-29-marcandre.lureau@redhat.com>
Content-Language: en-US
From: Mark Cave-Ayland <mark.caveayland@nutanix.com>
In-Reply-To: <20260123074945.2563196-29-marcandre.lureau@redhat.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: SN1PR12CA0082.namprd12.prod.outlook.com
 (2603:10b6:802:21::17) To PH0PR02MB7159.namprd02.prod.outlook.com
 (2603:10b6:510:16::8)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH0PR02MB7159:EE_|DS7PR02MB10889:EE_
X-MS-Office365-Filtering-Correlation-Id: 4be614c3-0d04-4f04-a445-08de63e20876
x-proofpoint-crosstenant: true
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|366016|1800799024|376014|7053199007;
X-Microsoft-Antispam-Message-Info: =?utf-8?B?M1Rmclg5Zkk2WnRrdWUzR0RZSTJvOGZySzFiVUZweTliSFloeW1MWlZRM1RN?=
 =?utf-8?B?L0RVN2VaUzBlc1B3MUpnOXZ6TGdMTWZPdExKeW9RWFhlS3lWRE5BUVZmREpa?=
 =?utf-8?B?TUdTY1UycmVWdWZrN1hhZmZoUDFNbjhrdlpRaUdUN0lYYU95VHpZWUxoTVp6?=
 =?utf-8?B?czRpazBHV0lxRGlISDhLbGlZb3l6RDZJcFVNajRLbysrY05iRm5VaGlRTTh4?=
 =?utf-8?B?ZFM2S3B1QzZaeUFGSVJFVURuY0hCdnFEUlZva2s1VnJkcTRPdlllL1lkZ1pa?=
 =?utf-8?B?VWxnMS9wd09kOFpxT3NzdXRuOXJGeFg3RU5SS1hlL2J4aDdLY1NHak9rb3FB?=
 =?utf-8?B?WXpkVFpJenl1aCtEeERhOWVPYXlRb2I5eXpDTjZZRTlGQWI4Zmlsd2Q2a1hi?=
 =?utf-8?B?Lyt4OHY5cmRQQ2tLYnA3SUVUajluRmZuYytNaFE1YXFldktuUllPdzRZOVFs?=
 =?utf-8?B?NDZEQWV1aldiVlZZa05IMkdWL0M0V1Y5U24rUnIxQU44dWRtRzdJV0phVUU1?=
 =?utf-8?B?NHZ1YTBVb214U2ZKdytpR0FCNFJmMHVJYkxtb29RcjdFRTc3U2tueFc4dlBM?=
 =?utf-8?B?SFozR2QwZTEybkRNRTRPMFlsbkNNNnhHdEJ2Q3NrWlRUbjJUampvN1liMjd5?=
 =?utf-8?B?R3ZleWNOWlJ6bFBPdERwa3lVcmR5cE9kODV2VkhDYXAyU1p4TTFEKzJrUGpV?=
 =?utf-8?B?U1RqQVN6MC9NeXBnOVZ1bThGRDY4MllwVFo4d1BQMHYxVzdwM0ZNOEt2ZTc1?=
 =?utf-8?B?SVdRaE9kQUZXa3BSWlY2elhteXJhWmZrK1h0aFNobWx1WnFSdWNXNXJJOUdm?=
 =?utf-8?B?ZmNWMlFUT2h6V3BKTnBiK25NdXQxMWJIa2tIdXdlWmQxSjZEV2tkS09WU3pQ?=
 =?utf-8?B?R3VUa1JNbytlazV4aUtpM1kzMzBUd3NicTdpZlhjVGFVdHlLcGd4TnMwYUYz?=
 =?utf-8?B?N05JSFFaMFVIdG00M3pUcmR3NGZYS3V3VS9wK05uTFdPZXhaSTdQU0dscVJC?=
 =?utf-8?B?enh5eHNSUno5aWh2ajhVY0hMUVZodjJzYWZMZldRQzU5VmdRbno3aUdIdHNR?=
 =?utf-8?B?N3BHSzFDZlVvNlpxV3VZcGd4Zzl4MGdteEhqL3pMNHByYkNyRWd6RGRzSEFC?=
 =?utf-8?B?bFpadXpmMWpsWmVVbDJVTEIvdHFVNlp5WmhlK1dpUTM0ZFI0NHBDVW1hNFdy?=
 =?utf-8?B?eW8zRElUQklHNS9ybFJlTmRORVc4a1VxY2x1dExmanhzQkV3cjhISVFkRWo2?=
 =?utf-8?B?eWxRMWJrNnIrV3F1QS9yZExiMjQxcDlXR1pjSndGSWJNb3hzd0RzdUlSa0Iy?=
 =?utf-8?B?REtERlBrNlBBN3VQUUZaS0dBcGFjajQ5RHhrVHhSdXJIbVBsN3ZoajRxd2Jz?=
 =?utf-8?B?dng5ZVFzNlh4U29EalEyTGYvMkZOcThvZ0lVV0RFZ0o0YUU3OFhQM0R1SFdz?=
 =?utf-8?B?RDdzTHd2aEdLRzc1dzVnOU04SnJoaWVWZXhKRmlwREJlemN0TEdGNUpJdWow?=
 =?utf-8?B?dC93eHdGeCtQZm04Y3JXaDM2a2s5YjVCYlBoUzFRaC84bW1JWmYyYVE5cjlD?=
 =?utf-8?B?aUJIOUd5VmFqNVQzTXBnYVIwbkdMdm9uNlFoMEtTTld1M0FiWnlscDZJUVpK?=
 =?utf-8?B?R0xUNjZacFRJQzByd0VicmpVYjcwWENjWkVJL3RMaExJM2orcjdnK2dWbTdm?=
 =?utf-8?B?ZUhGNFhFc2hiTVRuY3FvMlV2VHdMLzlXQ0JVeWVzSFVpTVJJUHM1Zy82QU1t?=
 =?utf-8?B?V0owM2JaQ2dJcjhTei9IeGRxenVQejZLVGdXYzBJWENkWEl0Wk92ZFNCNDhw?=
 =?utf-8?B?dVdEdVVKK2FGNGFjWngzdi92eUtFVHZxSnp1dWhFc25qL0pGczU0SGZDbWU4?=
 =?utf-8?B?cUdvMkhYK01VSGdYVE5hemJkODJaVTNhTGZtbUJ3Wnk4Z3BmbTFiSm9tbzBN?=
 =?utf-8?B?RVFxZVEyRlJSM0ZCNGdINmhTTFFrZ1BzNDBpMXRJd2NCdGdzNE1WU1dRZ3BV?=
 =?utf-8?B?VEdTL0dUenN2bVQ5TFErM0pOM2cwUldMMFpLU3o3QmRwTHF5NkNWV29JMTU0?=
 =?utf-8?B?WDlBcnNJd1ozUTdSMzQzU2tLS3B2VmNWU3FWdHpyWW9TOGdlZVJmdmpzUGZk?=
 =?utf-8?Q?+Mb4=3D?=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:PH0PR02MB7159.namprd02.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(366016)(1800799024)(376014)(7053199007); DIR:OUT; SFP:1102; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?dHVVNVZQaE9EcnIrS1ZQZE11TEYxcm5semlmd3hja05xSlJORVU2QWNDMFZL?=
 =?utf-8?B?cUxONFhHYlhYcWI1S2NJbTg4b1Q5NHlVcWVCd2djVC9qRnA2c2EzT003SkVt?=
 =?utf-8?B?TGZPOVVQZ3FJR2dIdEpQdnZNWXUwdmNiNTBQdWFmSUtBS054aldnL1dtZUZD?=
 =?utf-8?B?T21nN013cXdvWEMyMGNrc2E3Sks0UkdRWnNmUXZEaW9uem90RGREV1lROGFl?=
 =?utf-8?B?VEpyWlhPbU1kMjBFc1hlMUowbERqTWMreVRobGlXVEFSUVd3eUVHRnN5TGhm?=
 =?utf-8?B?a0dlUFhkK2tBUlQ4UlJPQVFOc0dxc2R5ZDJXL2taeTZCdVFwWkpJa1lYT09N?=
 =?utf-8?B?VVRobmcrbm04UEJMaWVBbWRjM0pOVHdta0c2QmZtK21Cb05maGdQdit1RkRm?=
 =?utf-8?B?Mk4vaUVqemRubGlmdDFUcGQ2UUFEdVoyOVpWZlBVVnJuclBlWWhSdGt2Vjkr?=
 =?utf-8?B?UnlhaENRRlViU0lxZ2lJVDFOSHYvSmF5cmNKZkNyekxQQ3ZTNVdyZG9ENXpJ?=
 =?utf-8?B?TEhIZ09mTk05eEJvU2I3TDJJc0hQaHkvTEdyblFEaGdMaEFqb09Md0tlTXpk?=
 =?utf-8?B?RDZtUlBJQTBmVTJIWlJ6bkMxMCtBc21XR3pOSlc4WE9ZcG5vVStXUlRnVEFO?=
 =?utf-8?B?aktwbW9EMkZab1NXeG1VUnZvOTdsaTQrUUJZaVR4a05TTTRDbzRCaUNHNmo1?=
 =?utf-8?B?QXV3am1DcXpVTUdURFpDSnlVbStpU0x1OUN5aG85RzhZRSsvQzNBL2xzOUo4?=
 =?utf-8?B?aDUwZFVMeHkvczB2MjVqbFhpMkxrS0pPamZuRFBNZTVpdmFLQ0NBRGpWT2hx?=
 =?utf-8?B?Rlh0TDdlSGFOTU82dGUrTnVtcjdKSlhURUJRZjdhM3NSOGR2V003M2wyV1FN?=
 =?utf-8?B?Z1NMM1BBWGFrMUlDTkJyQUR5Tm5ZTGlUdm1TQjdBZjQvQVpHTHBZMVBhb3B5?=
 =?utf-8?B?Q09weHE0L1EyY2pmMWpBQ09hYStlTnRRcnZWMFIrK2w5aVRJb3FwREdkdnJx?=
 =?utf-8?B?RnFvZWtkemJFRS9KR29GVW5FQUNBYnk0NHhDbkNWMkFwVkxmay9mcCtEUjN3?=
 =?utf-8?B?UVRRQW9OZ1hBOUxyNFNhZEZVMHIxWXU5UFoyWGZBZGJmaEJJYnV3M2NjOGpL?=
 =?utf-8?B?ZThjaXJRNXduRzhnbC9ZVjdla3o5c1R3OWZ1bElLSlB1TW1GdUVnVzlyNDZ1?=
 =?utf-8?B?dklocm5PdTM2WVM5RVdVQmFPOFZPR0krTEh4ZE9tSVFRb3ZMTUh0ci9ubkxQ?=
 =?utf-8?B?Ty81RVNEVjJQcWszSTl3SElzRWUvRnRMU2RiNkQzbXZoOTJtSVdNTE1KeGhx?=
 =?utf-8?B?T3NlOWZhZmVpQTlWMHFVbWRUVTdPOE5yTXA4L21Yd1BIK0x6SkpmOHp5R1lx?=
 =?utf-8?B?aXp6L3ZnaGo5a2lvay9laG1ON2ZzN1M4VTBNT2FNZUovR1prVktFc3RNQXB6?=
 =?utf-8?B?dUxVVm5LaHVhbHV4MW5vbFhaR2pkN1VITXU4YlAzcURsM05xZlNPbzlvaVlF?=
 =?utf-8?B?Sks1Z3lTcHFWTkY1NW1yYmd6Y2FRNFkzQ1Z6Tkh1M0dFekZVdEMySXNraE9U?=
 =?utf-8?B?dW9oa2phQjlzSSt0YmRDNXNDODN0TVBZc0lwS2JHRHpLVkJoZjNmcmhOaHdr?=
 =?utf-8?B?UXR0WEg1TlRlR0FxVGJ0dDRaOTZFOVZvRDdOcTg4bUh5TXNNNU0rVnkzMjhE?=
 =?utf-8?B?VDBMZWhla1VLZVIwdGZ3b2l0YXNxS0g3ZzYreEFWSVdtRjlRdHRBRmRhbTBT?=
 =?utf-8?B?dU5WcGM5Z3RrYmt1ZnI3S2tTbHk0VzZIYVhvMkNGUUJRSGFIdWtia1F5Y2kx?=
 =?utf-8?B?czN0aUdCRFdtNnlRNmxmVTBmL2hYOFpxQ2J4d0dDSDk1bGNOS1lmUE5GbGVk?=
 =?utf-8?B?Y2hpTzM5YnV2NmFscHF5cHVMelVMZEE1V2NrY1oxU3g5WHJtRklrVEVJMU5X?=
 =?utf-8?B?MldJODF3aGk2Y1V6UEpzRzhHRW16aitONVBlZ1QzSzI2L2tOVWh3NFdLTFpC?=
 =?utf-8?B?WTVLNVJIUlo4cUZxdlJUSzVQWEJ2c3pZTEdvS1VzUlJWY1ovcnFGWWg1QzJR?=
 =?utf-8?B?VSs2U0FTY0hoUGhNc0VVc08vekZCWlJHNTFpYnRTbks3TEpKQUZmS1FPbmZJ?=
 =?utf-8?B?anFaYlFaVGJMclZaZG4vS2pIeXYvZGl3ZEMxMWhwbFc4TkoxWElXdHU5aE5O?=
 =?utf-8?B?Tk9zWlZ0NUt0SE5mc0l5RlVKYU5DRXZzS0RjVGZJNUh4d2NpVkY4TEQ0N00v?=
 =?utf-8?B?dHUxWC8rQ3BMN2ZhWmJ2RytTb0l1OTZTOHREM0hnYlg3Q1lNajJObFVqcU5n?=
 =?utf-8?B?U3Vpa3JCcCs5c2NpaVdTVktGNWNNOXNpaUZQeDYxRUZTQUZkVVZxZSsycnRT?=
 =?utf-8?Q?XCQW44dlcaU/5Yks=3D?=
X-OriginatorOrg: nutanix.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 4be614c3-0d04-4f04-a445-08de63e20876
X-MS-Exchange-CrossTenant-AuthSource: PH0PR02MB7159.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 04 Feb 2026 11:39:18.9865 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: bb047546-786f-4de1-bd75-24e5b6f79043
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: MLh1ZchDM0ZjNmn1JoEGvA5LWhIx3Yux//Z1YkqRCMXHokyQ/JsEvFF7Ui/9y0STViTrKq92+WAHQ423QgFrl/OVlbJkhiimlrgFQdQCcwA=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS7PR02MB10889
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwMjA0MDA4OCBTYWx0ZWRfX8n3ymxN4WAcj
 ckQsZa9yM3ES2p9VuFgKk5VQUq54UHCRXjjSKxoCPbrLsz0lUaLunVdhLIUHx4r1nCXUpCAYcKS
 YodpPpIvm4kNSuTM1DgfjTNSKMI59YXxBCuMvlY3AGqfG51bgiZ2HbGiwUKH7B5/cF3NLK8F9GE
 Ar7sxhdXXDZbWLRdKJXtax56h+WJFuMg44YbAlC4mbSUZFgmTHRqWV6lNWT38HmoLFv4EFxVzUa
 keuV4D02lvCJKRP2WepLEB+PtBdovdhfuht7mir3gs/SomUMc1EwvulC25ytUpRDicBswVX6FjG
 J/5hI+VOy3mJOJoi0vm28FkiyQXOqd1VabLHvss0z9TVPit19Qy+S/dsTq8CGgWjYE811xhmkjo
 WvS6xGwcP6sIb9AjVkgyNJ6wNx1z9OWYTCSo4DHad135t/47Y5UpQH50OTDa/Jw0XlE1SmTaOYc
 Ukkq51RSl6/5wFRZOrw==
X-Authority-Analysis: v=2.4 cv=RrDI7SmK c=1 sm=1 tr=0 ts=69832fe8 cx=c_pps
 a=Gbvvz3TddPyANoHKDDnYFg==:117 a=6eWqkTHjU83fiwn7nKZWdM+Sl24=:19
 a=z/mQ4Ysz8XfWz/Q5cLBRGdckG28=:19 a=lCpzRmAYbLLaTzLvsPZ7Mbvzbb8=:19
 a=xqWC_Br6kY4A:10 a=IkcTkHD0fZMA:10 a=HzLeVaNsDn8A:10 a=0kUYKlekyDsA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=20KFwNOVAAAA:8 a=64Cc0HZtAAAA:8
 a=posAIAFHnNveVNcVQNcA:9 a=3ZKOabzyN94A:10 a=QEXdDO2ut3YA:10
X-Proofpoint-GUID: S-jUkbRH9muPONHSfGqEv3YrOnAmLNFT
X-Proofpoint-ORIG-GUID: S-jUkbRH9muPONHSfGqEv3YrOnAmLNFT
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1121,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-02-04_02,2026-02-04_01,2025-10-01_01
X-Proofpoint-Spam-Reason: safe
Received-SPF: pass client-ip=148.163.151.68;
 envelope-from=mark.caveayland@nutanix.com; helo=mx0a-002c1b01.pphosted.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001,
 RCVD_IN_VALIDITY_SAFE_BLOCKED=0.001, SPF_HELO_NONE=0.001,
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

On 23/01/2026 07:49, marcandre.lureau@redhat.com wrote:

> From: Marc-André Lureau <marcandre.lureau@redhat.com>
> 
> Clean up.
> 
> Signed-off-by: Marc-André Lureau <marcandre.lureau@redhat.com>
> ---
>   audio/audio_int.h | 1 -
>   audio/audio.c     | 2 +-
>   2 files changed, 1 insertion(+), 2 deletions(-)
> 
> diff --git a/audio/audio_int.h b/audio/audio_int.h
> index 08d07b17557..e1f9fa333ba 100644
> --- a/audio/audio_int.h
> +++ b/audio/audio_int.h
> @@ -306,7 +306,6 @@ static inline size_t audio_ring_posb(size_t pos, size_t dist, size_t len)
>   #define ldebug(fmt, ...) (void)0
>   #endif
>   
> -void audio_create_pdos(Audiodev *dev);
>   AudiodevPerDirectionOptions *audio_get_pdo_in(Audiodev *dev);
>   AudiodevPerDirectionOptions *audio_get_pdo_out(Audiodev *dev);
>   
> diff --git a/audio/audio.c b/audio/audio.c
> index 8aa071f4580..b303cfb4904 100644
> --- a/audio/audio.c
> +++ b/audio/audio.c
> @@ -1989,7 +1989,7 @@ void AUD_set_volume_in(SWVoiceIn *sw, Volume *vol)
>       }
>   }
>   
> -void audio_create_pdos(Audiodev *dev)
> +static void audio_create_pdos(Audiodev *dev)
>   {
>       switch (dev->driver) {
>   #define CASE(DRIVER, driver, pdo_name)                              \

Reviewed-by: Mark Cave-Ayland <mark.caveayland@nutanix.com>


ATB,

Mark.


