Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0DCA8ECD981
	for <qemu-devel@archiver.kernel.org>; Thu,  5 Feb 2026 16:19:38 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vo24d-0002ah-DX; Thu, 05 Feb 2026 11:19:19 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mark.caveayland@nutanix.com>)
 id 1vo24b-0002aP-NR
 for qemu-devel@nongnu.org; Thu, 05 Feb 2026 11:19:17 -0500
Received: from mx0a-002c1b01.pphosted.com ([148.163.151.68])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mark.caveayland@nutanix.com>)
 id 1vo24Y-00044W-TF
 for qemu-devel@nongnu.org; Thu, 05 Feb 2026 11:19:17 -0500
Received: from pps.filterd (m0127838.ppops.net [127.0.0.1])
 by mx0a-002c1b01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 615BPYMU2081089; Thu, 5 Feb 2026 08:19:05 -0800
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nutanix.com; h=
 cc:content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=
 proofpoint20171006; bh=Gvk53YF6cd6ixbb+hTga2HUNSnddUanW6PYag6ve3
 qY=; b=ejKsM6ifAmV4+ngk8egzSap8+a96GnFSnij3KzcjsTLB3T8ilwan/v5TS
 ds7t/YS1czKXZPSfcSW4jJO9UcbPVyUcQPdFX/oAI21vyyeAQOM5xqB/Uz4ZCmwQ
 aja/lnncif0LU8E99p7MV4fIRvewd0n9s3oCUVeK2G20ntmERWduD7IJb68nJVQl
 USqdZLUgm086qEZ3vIK9W9E09IHfUCEozgy8sRSeXxayRYXAABFG/S9Qae/j8/wt
 GLk5SUz1CjALNWO9HZi1yFihzzHY2YjdY56psqxLqyx+9nTxb0Gx8xoVGiFfNXok
 w7AI2+qH8dObG0606umPN6DVRDnbA==
Received: from mw6pr02cu001.outbound.protection.outlook.com
 (mail-westus2azon11022110.outbound.protection.outlook.com [52.101.48.110])
 by mx0a-002c1b01.pphosted.com (PPS) with ESMTPS id 4c4dh52bh7-1
 (version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NOT);
 Thu, 05 Feb 2026 08:19:05 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=tSNjzpTV+4CEnS+G+2Rsai50/qOY4zPZNlCE7sE8pHiv0kHTYBys/K6QBzyg9PJaumCWrjFj7h9pnOukNLTWiCoEUFMzLNRe3GPNGivViW0H7oArroaQHRmgyhQtlHeeT5zbXrQJNRutnouP7h/gSAs7PRwAFChF6hIIfsNp1hXoARvoWokXMDnf3Wh8eCB0ow0bEY9zGHb9qCkvg6+54v5v0hJkERxrTcJX168kUBVtlBanWViAL2c62G1/7bOlAClsPn7AzuinM3GBHSvf182yBcnbXTSWJ/QO8Ni4luRPvYHHY7JQAKJdIZhXIV/462qzdOKxo/EE2dMi1wKzIQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Gvk53YF6cd6ixbb+hTga2HUNSnddUanW6PYag6ve3qY=;
 b=ZZj26XM0WDhebV72PbdIGTTMO42+c+vJp9Da7ii0G0/VlbpLsHj1bH/eohA1+8pAWJPoICs1kEjesMJE1lZE+9+oruLgtmueqYaaWQt96XU3EOmSi9Gvm+vnlMD7Rv8lQi0CdpxA1XigzgV/djgY9vIuKETVwNLcRsEgCtRKZaKKDY6WCPc9jvAyVuHH+/hQFsW5KQ1UBiDJUswClrOQV1593QuN3fkHUpj7Eir6ndH72d7NarABt7Bh45rhTkqjIHOsrFIBIOHfdyBTB0kGNRjgeP0OYwyca/OiUNPGDn7ASDMiV7l113V6FznuZ+jOkqKbkwdubc6ppV4Q82VJNg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nutanix.com; dmarc=pass action=none header.from=nutanix.com;
 dkim=pass header.d=nutanix.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nutanix.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Gvk53YF6cd6ixbb+hTga2HUNSnddUanW6PYag6ve3qY=;
 b=UsoQmRObGyZy0bKJ0jkwkHXfEApnpUiSb2C8+L5MNGcdk+FcbBau2lZnb/iKcA5FlAJ777CNdTm7BoEHQSrxnCrv+6DzvhtH/X/cpZFFzVpu5fnnD4FyXRTj1uoYlbI5SFafG8Z7Rfv5AoZCgRiTp7LBDt21eOZfv2fmXoqih1U6iaEntTOROqq/KU6BWoSlEk/hTaOlCwNi9sS8WL6WXoT05nSeS/3CzEFzRPhSGKRpsCcS7kW8alQXDqfpMDkNr2f4OBf70EPRxplIoEBsnylNNV+hvl7qGSQ8TFQqCuSBFvnw4tSfPp+VxAzQXjXgJI8voeqnSQcFd3r9uVLH4w==
Received: from PH0PR02MB7159.namprd02.prod.outlook.com (2603:10b6:510:16::8)
 by CY5PR02MB8991.namprd02.prod.outlook.com (2603:10b6:930:38::17) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9564.16; Thu, 5 Feb
 2026 16:19:03 +0000
Received: from PH0PR02MB7159.namprd02.prod.outlook.com
 ([fe80::8e97:bc32:822c:b250]) by PH0PR02MB7159.namprd02.prod.outlook.com
 ([fe80::8e97:bc32:822c:b250%6]) with mapi id 15.20.9587.013; Thu, 5 Feb 2026
 16:19:02 +0000
Message-ID: <1f9dfd2f-9586-4f08-afc9-113b7ecab135@nutanix.com>
Date: Thu, 5 Feb 2026 16:18:58 +0000
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 05/37] qemu-options.hx: clarify default audio backend
 selection
To: =?UTF-8?Q?Marc-Andr=C3=A9_Lureau?= <marcandre.lureau@gmail.com>
Cc: qemu-devel@nongnu.org, =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?=
 <philmd@linaro.org>, Gerd Hoffmann <kraxel@redhat.com>
References: <20260123074945.2563196-1-marcandre.lureau@redhat.com>
 <20260123074945.2563196-6-marcandre.lureau@redhat.com>
 <b28fd63e-063c-41d3-a9dc-54929e7adfaa@nutanix.com>
 <CAJ+F1CKauYDpB0+_ggGP9mMkvYTDTbcsp2LX+twm8dvMggpSuQ@mail.gmail.com>
Content-Language: en-US
From: Mark Cave-Ayland <mark.caveayland@nutanix.com>
In-Reply-To: <CAJ+F1CKauYDpB0+_ggGP9mMkvYTDTbcsp2LX+twm8dvMggpSuQ@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: LO2P265CA0514.GBRP265.PROD.OUTLOOK.COM
 (2603:10a6:600:13b::21) To PH0PR02MB7159.namprd02.prod.outlook.com
 (2603:10b6:510:16::8)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH0PR02MB7159:EE_|CY5PR02MB8991:EE_
X-MS-Office365-Filtering-Correlation-Id: 28d20a49-649a-4e88-4414-08de64d246b3
x-proofpoint-crosstenant: true
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|366016|376014|1800799024;
X-Microsoft-Antispam-Message-Info: =?utf-8?B?M0FXMVltUlBOY0ZIa21iazhtN3BxbzNiN3QyWThxYTh0TGE4cXN0NFV1R2RC?=
 =?utf-8?B?czF2U283MWpid0U1bklnQTFWRlRpSHlJdnBlQWNBS0dFWUZHdDRBTjcydkV1?=
 =?utf-8?B?VDFCT0hldjRjRTd6bzNaVHN5d1ZHajljWkZzRlpKVlVsTUdELytkbk1DUFNl?=
 =?utf-8?B?dXRGZ2tvYUJlNy9EaCtNbHRSVnV2WHYzeVF2VW1MTFU2Rk8xY3UzeDdEeGVU?=
 =?utf-8?B?cjllUXlQZEFBVi9aZzhYdHpoMjIxWW1ySEVVWjgrN0dtbloyT1JNS3Q2VjMw?=
 =?utf-8?B?akdWKzJyVEJJbFd2cmVhcEtvN0Z2dWV1RjFtRXdKTXJGSWlMVnZsU01IQWM0?=
 =?utf-8?B?N1FCMllXQWx3eDRtZU1EdGhlbEdmdEl1WVNCSFJKVUxxVE10VHNiaHFkOTBu?=
 =?utf-8?B?OGk2NnZnS2JQd1hYeHJpUzgzcWwrcDIxWUpOOURETHdRcmEzQ2crcFNMZllv?=
 =?utf-8?B?NGtuVk9WSTBHSUFBRTRHdDJSLy9uU0FkcmwxQ3hxalJPUkpCOER0TzBuMEU4?=
 =?utf-8?B?czVVWGZkTCsxS2M2bUlZd2NhRG9pT1dVTXZlVHRZdmJrdWhXM1dWV1VRUzdZ?=
 =?utf-8?B?cmcxa1l1NkhMK1o0S29IVUFKN3hjT0FiQzhoYmpPRWdTNFBseDhQK1NmWnNw?=
 =?utf-8?B?Rm5qUHpvenE1RGhQSWtaajk3aWlqbU9RM0tTaitWQU5ialkwQnNQR04yUS9M?=
 =?utf-8?B?Tnhrc2tkdXlLa1k1K3o4MVhJN1o2eUVYUUk1SkVYeVZEZGZOTldrZVJkWEI3?=
 =?utf-8?B?TnpFZzF6K2lUU3MvZ3IvTkJmV3YwT082TGpPaUFwNEJuMEI5SkhLWUFJYnZ2?=
 =?utf-8?B?SDNGMEdFVldiblpHTVBIT0srb2pHMDA0N3ppZnljeVp6bGlYQXd2QmFSc00v?=
 =?utf-8?B?MUo0Z3ZyZitGcUNtUjdET3dRbjR2NTVHWEdlUHFUTEdaN1BGQ1czK1lpd3lr?=
 =?utf-8?B?Wk1GUFBEMGZPRUNETDFOZG1DK09XV050cVVZcGx1NllOUlF1cDFwQU5nakVj?=
 =?utf-8?B?MmpHWXN5Y3J1dUpRSkVlN0RpWEdGelR2UnlVTGVpTEM3NlhuNkJzaVczMDBn?=
 =?utf-8?B?a3lDcTlkd2MrNzZOZktQVjdFbE9iUnJTL016bEo5T0JJU3A1aHJ6bXV0eXVv?=
 =?utf-8?B?aUZ6bWZNRmlFem5DS1Zpb3lmWFc1VUVUV3Z4ZGtXNDhGaHF3QnJYY1hxemx3?=
 =?utf-8?B?YlZuRGFnYU1qeUVCaWtUTTBhNTE2Y0FoSFM5UklWaDZzbzVYNE5NVGtJYk9z?=
 =?utf-8?B?bllJdHJpVVpLWjNlczRPY2M0SU4rejRKQjl2cUJjMG00TmhYZVcyYlY0YzBv?=
 =?utf-8?B?Z1ZibmNabUkwaFljd2tvNGdOQU1RTy9DMVowQm51M3RuSDVSR0lNRXI2SW9T?=
 =?utf-8?B?NURCa0ROTzB3SXl1aFNFbkZyTEV4R1psRGpIdC9xSGJ4aG9QRHA4NForK08r?=
 =?utf-8?B?M2ZpaWU0ZWQyWlRlL3hzd2VBckYzNGN1N1dGdDRIbWdMR3N0M2hQZmM1WXhs?=
 =?utf-8?B?UUNyMU1DYVZqY1dhbGpienY0UWpDUitUTHNUWm4xeGZoOWQ2VjlhcDUwUmtO?=
 =?utf-8?B?eWJpMk03eDd0T0svNE5CaDNCaHVkaTAwMHdLY1ZlM0NyZjNaM0JkNjFBdmVS?=
 =?utf-8?B?bmxiNkdCZ2loaW1ZZmcyN2JvSVdoZ1l3eThMeXJtVWovQUlGSVpLZ2VIQW83?=
 =?utf-8?B?cGdzc0VBVTgzUG4yMC9OMW9YU1gzQzJTamZncEJhQUx5TUJQNitraUZOeTJw?=
 =?utf-8?B?RnMyLzk4ZlpOMEhCSmFFcXpEM3hkZVE4ZUVEUDh1cjU4NnNkNkl0dXM3aEps?=
 =?utf-8?B?U1A4bTdZR3hKd2J6aEtPL1lZdVoyd1Fic25pSUZkUjNhWjRiQWRtK1NhdzFV?=
 =?utf-8?B?WU9NNGZmYVhSSGg3aDFzSEZ0M0JoeFBta1BxNXRrLy84QmI1eDgwZm9QS1BS?=
 =?utf-8?B?Z2lmM1Exd3hFOWMzQnRNby9zei9UOXNBT0gwdXAwd2I3UGlxSGQvTjNYdDBI?=
 =?utf-8?B?NHR3MXZYTTlOYnVZaGt3ZFVsSlp1eDJTR3JjNDN5YW9yMzcrSmpiYWxWYjJp?=
 =?utf-8?Q?Y6JxVB?=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:PH0PR02MB7159.namprd02.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(366016)(376014)(1800799024); DIR:OUT; SFP:1102; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?dGlTMzFLMGJBTzQwV25jMStFcDBZSnBiS1lBOFBWWWp0ZTg1cTNTWDlPUnhG?=
 =?utf-8?B?S1dMUFlmcG9wdDZQZDg4MlNIOCs1RGM4ekVRSU1VTmF2dlBuOGdFMEdBcGpo?=
 =?utf-8?B?YzRqZzlxeFBzZDhNZGhPN2RPWDBJRnRpQ0M4eGtjZFlmeTZFQ0lZenVkZ0VX?=
 =?utf-8?B?S2NLV1ZDbk5jak1aMEhPUldodkVJYzh3R0VOZmRYdERlNjJhcmp6SjJjT0FF?=
 =?utf-8?B?UzdLMmcrVllyenVnVXNFT042UDJoL0RYWUJva0VOOTlkNENRQzdpZVVZQTc4?=
 =?utf-8?B?c2QrRW1kVTkrQmkzUDBhTWZZWVkyZHVrSGVZS0dVUzlLbmIzNXA2K0U0b013?=
 =?utf-8?B?dVI1VlZldlFqRUhwdzdmTE4zTm5UWVdsVzlDTTd2bXM3OS82Y255cTJpRUo1?=
 =?utf-8?B?VnhNTUdJbDV0YUpIWW12STJHRGl3VFp6ZmgrWmNvc0NkcGE0Mmo0V0ViTnVh?=
 =?utf-8?B?aW8yemhmZWFDQTlyNy9pR203Yzh5bmc4aTRzaWUxM0dwK0NyZ29WVnJYSUR6?=
 =?utf-8?B?emE1dm93SWs3Z3pFMTIxMUI1S1ZaNFRUd1NYNGdmSmk2cUVyNms5V2dVUS82?=
 =?utf-8?B?VG02UFZ6aTQ5TllJQllEcVFTK052dHBPZ1dtb2d5dWtXSks0alBpTmZtNWhQ?=
 =?utf-8?B?cmh6K01WMVM1cmx2TFhsRDNGTjh0dzZvc00rQ0xsMWdWKzB3QU1DMk5KSWhO?=
 =?utf-8?B?WjBKNzFSb200Zy9aY0xKWm01NXQrV01meW8yWFJadmRQOXZoM3p4ZFVoMEZj?=
 =?utf-8?B?aVovMWN2dWEwWTRTWDlBRTM0RGt5Q2FXRFUxOVdEeFFoNTNVSjE4QUxISFhw?=
 =?utf-8?B?UU8rYlZ3ckQ4MUkzNjRqVlVKbXFQalpYUldJWUYzTEx3anMwTTNSajdBdUE0?=
 =?utf-8?B?RFh1alkwZUFYUS93azQzSnZxeTM5Y05zZk95WGhaR0tWcXduYXFaYUVFVXRh?=
 =?utf-8?B?T3Y4blJ3RFpXY29EcXp6T3ppblBtYUczVEc0aitFR2xPNi9oUmQwV05BbUhC?=
 =?utf-8?B?aEFRRkVnVm8yc2VMYTZlRitwMGNZcm9vall5TU9IVlJBajlDRWhSQTg2V0I1?=
 =?utf-8?B?eE1ldEJMMWVPNHA5VXJGcGFIczY2Y2dKTDYvRW1JcWo3MjU2ZGJiN011THhZ?=
 =?utf-8?B?STlQZ3NDT1FaUlF3bC9RZEVKdm5LOCsxbXV6SmdncHhZNEdGOU1QS21CaVVu?=
 =?utf-8?B?NzdZRGdJYXJ5dktZdk5QZURXYzJJNlNVeGZvVzhaZ2ZKbVVMUlFYcDNET2Vo?=
 =?utf-8?B?VHdBSGpTRXRCSEpyYStjMGI3UE5MMmcyYnQwR0VraTJEYnNERTZQMnRyYTZq?=
 =?utf-8?B?bWhaSXZkbWFNT0RTQ3lRY1JUd3FBZ3pFRTJETU9iRGovOUdFOU42emdUdzdS?=
 =?utf-8?B?cktLUDBtTStPMlZ3NGdocURXUVI0UTN4aFdTNjdIYjRTNDJpcms3djd2bVFu?=
 =?utf-8?B?QkRheTluclNVc2ZIZlFaUlVRTmJiQy8rVzBTRTdxVllEUjQxY09QOVdJcUln?=
 =?utf-8?B?YVNsdHBXTklOWGQ2aUVZTU85SFhvWWQxQVBSMVZwVlB5OURsd2hJRVNkVHVX?=
 =?utf-8?B?d1V2dnlTNXN0WXk0bCt4QmxuaFhQeElQdFdGa0VTM1JCTGsyZTdDZzNzTUFk?=
 =?utf-8?B?LzNEVGhheEhmUm80SVVBWnZCUjZyZ0J1V251b0ExK20xbTAvVlRSUGkxODBo?=
 =?utf-8?B?ZUo3dDZVaWUxTTFsSVBZeW5RMnJEZnhTM1RaeE10UzEvbXhNV1UzYnRzN1cz?=
 =?utf-8?B?Q2pVdWRyeWkzYUlmak9ZK3pBL3RwQmJET3JWczZmdVZ4Z3VEWVdBQmlzdXF2?=
 =?utf-8?B?OUJXalBjNUpLODRFUWt4d2hMbVVjSms1QnBKN2tuYXFRQ053VFJwM1FBU2l6?=
 =?utf-8?B?VTJQTEJsUmoyQ05XalZrU2t6YVdiUWxGcE1hSnJlSkp0YUZZY3dlaHltT2RZ?=
 =?utf-8?B?ZlYxWDlma2ExdDBJOUN5SWFzcEkraWRyeUpoSXdSdVZUc29ZYzZhR0dTZjNI?=
 =?utf-8?B?RlFOQ1N4aG9BaGdVZzJlRUpYc0I3OFMybDByalhBYWpPR0Rlblc0NVF0NThE?=
 =?utf-8?B?YzI1b1hjb3RsYkF0UjJndXBvSitFNGkvSHRZeExKdHlPeTBpTW5XMnBCdjVp?=
 =?utf-8?B?TXRVQkJKV3N6RlBHQlB4WFZnanFYTzY0VFVOaXlOWlhLUTFhWTlvdElHODF6?=
 =?utf-8?B?Q016T2VDaUxLVElTeFhUZGtOdFhIWmdCc3Vkd2poZHlzM3VkQjZEQmxGYXg1?=
 =?utf-8?B?QkZjWWFSWEJQTTlBR1FQeXBtaVY4TnVKZnYvVEd1ZzAxMk4xU1V4MkVuVHY2?=
 =?utf-8?B?R1VISTN4VmI2cG9udHBwQ0JEVFZCaGpqQUhoTGlIRHc0ZTlzeVpUclhoVUsx?=
 =?utf-8?Q?mnJKBDWFf/gfvik8=3D?=
X-OriginatorOrg: nutanix.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 28d20a49-649a-4e88-4414-08de64d246b3
X-MS-Exchange-CrossTenant-AuthSource: PH0PR02MB7159.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 05 Feb 2026 16:19:02.8027 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: bb047546-786f-4de1-bd75-24e5b6f79043
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: A9QMyWA+mNW1gtvEFYzJd7FgZ6ard+q+Y1m2w5q4mXmCPu783ht2Ao6+WlypFU7MElcUp7zZ4ZP8BmNhowaAmwvn1v4wE+XoFf9K0VsXdGE=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY5PR02MB8991
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwMjA1MDEyNCBTYWx0ZWRfX/rowI4iJFUf1
 uhFgA1Eh18jrNKhmBmg788opZstUeTe3rliUFSO168CHDhk+v0XiaE4dfBXtSlON8N5JpZZjXRq
 rcEf5pKORdbiVbsyAyEMWigQi7ge/wdfbXWP5UYgFls5MRPYvQW3o3uKxr4eTuFX5oKx6K3faIl
 I6Dk3wabvpd8pR40b46uiRVvyu1504spHkSyrdmzI7Zld73D9n61jMKY4qzFXeH4CVcwYlNb4aJ
 CWxfR8zQLYzPRq6huwjJyXctHvA8dgHFqlYJftQFAbh8EJKWdHUQy4udnSz6YYCklz1aT+3BeDh
 uqmUzwfMOC079C+L+jpjYpH+zCSeX8wbjMg/td+1iS4965v/hBksDV1QIqUyl6qVKyLAyBGe7US
 xtiH0t6RR/Nqw8DFB4wwL+lJRzMvY9kIyyi7nhWkV0N5KV/vmVlEf5WBExP6DTE8SmIUeRRsLwD
 NyWqCEcihPqrOBBXWIg==
X-Proofpoint-GUID: -0Tsf9U60xm6QBiDUrgh144AJKHJh-2n
X-Proofpoint-ORIG-GUID: -0Tsf9U60xm6QBiDUrgh144AJKHJh-2n
X-Authority-Analysis: v=2.4 cv=fY+gCkQF c=1 sm=1 tr=0 ts=6984c2f9 cx=c_pps
 a=ylTaWg/OuTOBUQxDHB/KXw==:117 a=6eWqkTHjU83fiwn7nKZWdM+Sl24=:19
 a=z/mQ4Ysz8XfWz/Q5cLBRGdckG28=:19 a=lCpzRmAYbLLaTzLvsPZ7Mbvzbb8=:19
 a=xqWC_Br6kY4A:10 a=IkcTkHD0fZMA:10 a=HzLeVaNsDn8A:10 a=0kUYKlekyDsA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=UXIAUNObAAAA:8 a=64Cc0HZtAAAA:8 a=20KFwNOVAAAA:8
 a=8ydhDqggtdRh_7AbUmoA:9 a=3ZKOabzyN94A:10 a=QEXdDO2ut3YA:10
 a=dDbJgj3P-9cA:10 a=a1s67YnXd6TbAZZNj1wK:22
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1121,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-02-05_03,2026-02-05_02,2025-10-01_01
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

On 04/02/2026 12:27, Marc-André Lureau wrote:

> Hi Mark
> 
> On Tue, Feb 3, 2026 at 7:49 PM Mark Cave-Ayland
> <mark.caveayland@nutanix.com> wrote:
>>
>> On 23/01/2026 07:49, marcandre.lureau@redhat.com wrote:
>>
>>> From: Marc-André Lureau <marcandre.lureau@redhat.com>
>>>
>>> Signed-off-by: Marc-André Lureau <marcandre.lureau@redhat.com>
>>> ---
>>>    qemu-options.hx | 22 +++++++++++++++-------
>>>    1 file changed, 15 insertions(+), 7 deletions(-)
>>>
>>> diff --git a/qemu-options.hx b/qemu-options.hx
>>> index 455b8be8903..732934a6fa8 100644
>>> --- a/qemu-options.hx
>>> +++ b/qemu-options.hx
>>> @@ -896,11 +896,16 @@ DEF("audiodev", HAS_ARG, QEMU_OPTION_audiodev,
>>>        QEMU_ARCH_ALL)
>>>    SRST
>>>    ``-audiodev [driver=]driver,id=id[,prop[=value][,...]]``
>>> -    Adds a new audio backend driver identified by id. There are global
>>> -    and driver specific properties. Some values can be set differently
>>> -    for input and output, they're marked with ``in|out.``. You can set
>>> -    the input's property with ``in.prop`` and the output's property with
>>> -    ``out.prop``. For example:
>>> +    Adds a new audio backend driver identified by id.
>>> +
>>> +    If no audio backend is specified, QEMU will attempt to select a
>>> +    default one. The ``-display`` option may influence which backend is
>>> +    selected.
>>> +
>>> +    There are global and driver specific properties. Some values can be
>>> +    set differently for input and output, they're marked with ``in|out.``.
>>> +    You can set the input's property with ``in.prop`` and the output's
>>> +    property with ``out.prop``. For example:
>>>
>>>        ::
>>>
>>> @@ -2172,8 +2177,11 @@ DEF("display", HAS_ARG, QEMU_OPTION_display,
>>>        , QEMU_ARCH_ALL)
>>>    SRST
>>>    ``-display type``
>>> -    Select type of display to use. Use ``-display help`` to list the available
>>> -    display types. Valid values for type are
>>> +    Select type of display to use. This may also influence the default
>>> +    audio backend selection.
>>> +
>>> +    Use ``-display help`` to list the available display types. Valid values
>>> +    for type are
>>>
>>>        ``spice-app[,gl=on|off]``
>>>            Start QEMU as a Spice server and launch the default Spice client
>>
>> The documentation changes look fine in terms of describing how one
>> option may influence the other, however there is no explicit mention in
>> the documentation that selecting a dbus display with no audio backend
>> will also use dbus for audio.
>>
>> Is it possible to mention this somewhere? Otherwise someone would have
>> to go digging through the code to figure this out.
> 
> would something like that help?
> 
> @@ -2191,6 +2192,9 @@ SRST
>       ``dbus``
>           Export the display over D-Bus interfaces. (Since 7.0)
> 
> +        When no audio backend is specified, the dbus audio backend is used
> +        by default.
> +

That definitely helps. Is it possible to tweak the wording to something 
along the lines of:

If no audio backend is specified and the dbus display backend is 
specified, the dbus audio backend is used by default.

Another question: is there any documentation for -audiodev dbus and its 
properties anywhere at all? I had a look at 
https://qemu.readthedocs.io/en/master/system/invocation.html but I can't 
see an entry for it in the audiodev section anywhere?


ATB,

Mark.


