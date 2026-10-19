Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 41470CCA490
	for <qemu-devel@archiver.kernel.org>; Mon, 19 Oct 2026 02:26:16 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xId4Z-0006kp-QK; Sun, 18 Oct 2026 22:25:59 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1)
 (envelope-from <prvs=7454c2a62=Alistair.Francis@wdc.com>)
 id 1xId4Z-0006kd-29
 for qemu-devel@nongnu.org; Sun, 18 Oct 2026 22:25:59 -0400
Received: from esa3.hgst.iphmx.com ([216.71.153.141])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1)
 (envelope-from <prvs=7454c2a62=Alistair.Francis@wdc.com>)
 id 1xId4X-0001lm-9J
 for qemu-devel@nongnu.org; Sun, 18 Oct 2026 22:25:58 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
 d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
 t=1792376757; x=1823912757;
 h=from:to:cc:subject:date:message-id:references:
 in-reply-to:content-id:content-transfer-encoding: mime-version;
 bh=kELQDWv7X8SCqJpCrewkRwnwvAhQ097Pu+BZoM6Gd6A=;
 b=Uh3Zcl4u1ug9cqku34kyDCyMeW/R1LbvZz+YMM2vkqueMVVUOhqTsmD1
 m40hJq9t6D4HESpa4fWunf+27Xq5TaE3N8QzHLZ1q1fWT2fAwNsHl7ACn
 047CTKI5FP9/XckmZMK9+BUFBJwkshTOFxNMRHJf7JMAAc5vHZfm5nN0I
 DkqiFB/hLxCAsnQVJ19aqYjikLeLkc1oQaocUpe/DlLeUuMy/E0FBQuqw
 meYMSBNVZZFDx+WUgZNEJCz0GdiVvyOkCRIqjT684616JE+kqd9SolW18
 KZCba7LycY0A+bghRvLMQ6zRb90OBoqIz76TH5dRKGFc3d3Oej3lVJkVo Q==;
X-CSE-ConnectionGUID: bMCPHF5NS4yVJqUlD7ml7A==
X-CSE-MsgGUID: vZLD++bNRK2RuHHs2oVR/Q==
X-IronPort-AV: E=Sophos;i="6.27,166,1786982400"; d="scan'208";a="158416793"
Received: from mail-eastusazon11011037.outbound.protection.outlook.com (HELO
 BL2PR02CU003.outbound.protection.outlook.com) ([52.101.52.37])
 by ob1.hgst.iphmx.com with ESMTP/TLS/ECDHE-RSA-AES128-GCM-SHA256;
 19 Oct 2026 10:25:55 +0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=M1LR2+u5CfCE19NITxP3P4ldF3jzAkgkMXTjJXPh417z/5yuJqnV673H+S6xKRUg8bAzRGU7HMC+48BruJwQSIgvUQh/bNy+pvd1wt8dp1Ea87ihfc0X1lM7T9PLkqIWu1vnjVK4kO2QhrW3MPVsES+h0Ehnydkke/aszSQBAx3ygDoiyokoKDsroF03JRdXzn1NVd6UYgXRbjvMVZtYYpH0rR3rlv/wysV05pbmY/b7N7ybbbAw5yquEgAj9tfaDjngF+B3zGz0jidRCVfHT5pO26WRYYB0R26D8v53CCOpyrHfLqDNpSDn1jSiXCnWs6q2ksYcRrvvWW2AjMF10w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=kELQDWv7X8SCqJpCrewkRwnwvAhQ097Pu+BZoM6Gd6A=;
 b=HiaxDAZHpiqWvkbaWL6vSt/EylxOeWIGWga5fmRBetOMdRQ6zcfsDQ3qR+CdMZr6ZHxC4ab2SxypH7oTRA1GPquUk4OBlPK5u6UkylZ0/hoCxERccdgRe6CvxVXJ68NJL0vkov+e2EZ2zANLxQU235CDgaZkj58O5xOEZ4tpSXW/wtxJi6sakMDfMYaPc9gCpZqKNmESrVSU5xnmm6lkhjeLiWAZ7IsDXqDsUbC8y4sj6R7UBUJ8h85RQlDI+7GBo6vIsvjFQ7gA5rZv/s0U5w+W5BrvAyM35OkEnRlPU+f0xK/Qw70wvH+jwfWXg1Eo9klOQZPaoThjlZ0FV4y98w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=wdc.com; dmarc=pass action=none header.from=wdc.com; dkim=pass
 header.d=wdc.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=sharedspace.onmicrosoft.com; s=selector2-sharedspace-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=kELQDWv7X8SCqJpCrewkRwnwvAhQ097Pu+BZoM6Gd6A=;
 b=Dv5bGhGB+T71fKuvRKl0kl09BhSoE1E0d0kaOe55DlJMAce0mldsmDa3U0YhgUjpdviZjpjNe2qwxt8N+Z+wJtJQAgZNVwOO91OHfHrSXxSSDppA+S1Rxj3xMp7Bn+QhOWYYkaPXdSPax8XL9U/vw8+6Ihbtjsonlg6EYS+gcr0=
Received: from MN6PR04MB9359.namprd04.prod.outlook.com (2603:10b6:208:4f2::13)
 by MN6PR04MB9336.namprd04.prod.outlook.com (2603:10b6:208:4f1::11)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.522.19; Mon, 19 Oct
 2026 02:25:54 +0000
Received: from MN6PR04MB9359.namprd04.prod.outlook.com
 ([fe80::e729:bbef:5a37:2e77]) by MN6PR04MB9359.namprd04.prod.outlook.com
 ([fe80::e729:bbef:5a37:2e77%4]) with mapi id 15.21.0522.017; Mon, 19 Oct 2026
 02:25:54 +0000
From: Alistair Francis <Alistair.Francis@wdc.com>
To: "pierrick.bouvier@oss.qualcomm.com" <pierrick.bouvier@oss.qualcomm.com>,
 "qemu-devel@nongnu.org" <qemu-devel@nongnu.org>
CC: "philmd@oss.qualcomm.com" <philmd@oss.qualcomm.com>,
 "daniel.barboza@oss.qualcomm.com" <daniel.barboza@oss.qualcomm.com>,
 "anjo@rev.ng" <anjo@rev.ng>
Subject: Re: [PATCH v2 4/9] hw/riscv/virt: restrict scope of
 virt_is_acpi_enabled to this file
Thread-Topic: [PATCH v2 4/9] hw/riscv/virt: restrict scope of
 virt_is_acpi_enabled to this file
Thread-Index: AQHdXcVXrlZ2MkNYyEeo+x5ihbDKw7cEJsmA
Date: Mon, 19 Oct 2026 02:25:54 +0000
Message-ID: <ee59eaa7225caada5aa61b672caf78eeaabb1a94.camel@wdc.com>
References: <20261016232304.1215119-1-pierrick.bouvier@oss.qualcomm.com>
 <20261016232304.1215119-5-pierrick.bouvier@oss.qualcomm.com>
In-Reply-To: <20261016232304.1215119-5-pierrick.bouvier@oss.qualcomm.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
user-agent: Evolution 3.62.0 (by Flathub.org) 
authentication-results: mx.microsoft.com 1; dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=wdc.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: MN6PR04MB9359:EE_|MN6PR04MB9336:EE_
x-ms-office365-filtering-correlation-id: 7780d5fa-2b4d-4a3d-aac3-08df2d884d00
wdcipoutbound: EOP-TRUE
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
 ARA:13230040|376014|19092799006|366016|10070799003|23010399003|1800799024|261009223027099003|10067099003|56012099006|22082099003|18002099003|11063799006|4143699003|38070700021;
x-microsoft-antispam-message-info: nKXhxcyTTdGyrcqGLvUaKMH3xXxh8fUmbOkDbrG4S4MerDLRP3OxvP8pRn/wTrbIR61LfT62Vv7XmcgoQpShGJv49amwsH+JT6vRnuvkkX/gwJVVZznjXMOWoPpxbFu8D4nOHZaxLVFgYTfJVarD8BEFzssRZW2uk4oncxwDhrX9AuqZM2MFs6adNbPBVOuWzUId7M76rsWG04OSgLmin9tsI0gjtLBdHbEvbcdR1g0Hru3FivFsJMYo/w3eyJyNLPyVk3UeOjF/KJs0hXFJBxi1jJZeOlwmn4jZjz71Jd4fxCqrm1TmizubqffFN64PmR78AF/ENoWtJpbZ+wy1vBVMePjC2qOraO8MXbgW/+m4KbIsg0hcwLFKi17F9MYRoyMgYOTNxihoxxCa4PPRdHtgv2zIhnhRdZl2St3tog99AnI9nGJP7IpIzqXxOuQzobOUwXolaBsxEgen3TNgT8/AihvamrqjoHTzMrPUWZt9IhN+apv0eTg1iLT1ZJrtSXBsr+2gJ4/RQzvp7ExvdFHgTx6s/ZdY3s14KODMv343EmrZqeKgllJVB6MzqqcskG+Zr9ggxXMz//MhPsnzlFFtssnad9RL9A6RTIHP10J65aR5v5T/x0VAd/n944YOKnBKXu/cVYar9hCx4i5uM56Utt+JMaxA74HDhLC88S3gAJexkAKMIww7KpzuJwTnxuiCxdB50jTn0RZBxrF6DxNMvVUrCHIxaOeiBsDyFTc=
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:MN6PR04MB9359.namprd04.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(376014)(19092799006)(366016)(10070799003)(23010399003)(1800799024)(261009223027099003)(10067099003)(56012099006)(22082099003)(18002099003)(11063799006)(4143699003)(38070700021);
 DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 2
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?bGJKc3MwcnpQWE5CNDEzbWZvS1Z2V0QrZEVpQkdERjcvUlN6eVFJS2YvUGxt?=
 =?utf-8?B?VnFwTUIzTUpuQWlPVG5vSHhEMzl0Yk9uaEptTE9tVUt3aHpDVmhwaUdnUG0w?=
 =?utf-8?B?OTlBbTNrRi85ZTY3VEhtYzMwTmFjZjFqblFFN25ZUEM0UFBFK1c4TWo0ay9l?=
 =?utf-8?B?Vi91T0dVam9vTnoyYnNta1NyV2hmRVF6VlpuUFIyNW1BQ2lQUjk4NXNjRDF6?=
 =?utf-8?B?eE53VFZ2WlF0Y3MvZ0IzamRobng3OHdrMzhVclgwQnFpUjAxWFFJVXpoVWVU?=
 =?utf-8?B?bUpwN0JHWGlQemJSdmovSGZuUStCYVpNY3FPL09laHhURUh5elU2T1ZJaE9C?=
 =?utf-8?B?MkQ3WFZKZ2pqaHJFSXNBKy9hNVBnRjRMYnhEOWNqOXlIY1E3L0Q1T0Z1dVRx?=
 =?utf-8?B?SWp6STdNN0crWmRKVGlLNXVzakFFVmp3cFBpREtqRWo5ai9IaElKclQ2bHBk?=
 =?utf-8?B?MWFTRU80TWg3NFdlajM3YytkWGRvN2haaS8yenFvUWJTTEg2NXlUcEgweWVL?=
 =?utf-8?B?SCtOa0dzd0hMTWttMEhMV2FEb0dRamlPN3VGdWtWVVhrWlNVZUIydWJhMCs2?=
 =?utf-8?B?T1lpSE1vam9VRjRiN0pOMFZoWWVhWG9UMGx5bkR2VTBJYWJ0Q29CYmtuOHYy?=
 =?utf-8?B?cUpRam9kdFFKWFdERUxLRVMxRVNUUGNMR0FPbXB5K25Qcnd3b1Y5M05LUXQr?=
 =?utf-8?B?Z0VjK3Z5b1IrYmNZNFo0SDBDNWJsUktENVNmT1VpUkJaOHpJcHlFZUFFdVpt?=
 =?utf-8?B?RHh1S2lucTAyOHZKYytuTDhqVklkaEFLQjJFc0lEdmVrMTVCWHZjeEthMHZq?=
 =?utf-8?B?a3BBRVJrZU41SEFXWGU5MmpuM3V0bjRtaXM0WjNsWU9Cd2hMd2ExMkNkN2RG?=
 =?utf-8?B?RzU0UFJrT2xPeTJGNWNrNmhjRk14TzlraTkxWE8vQVhFeEswNG5RMXczMDll?=
 =?utf-8?B?eGczYU0rMzBpZFlsYXlsZWZwK2Naa01FNy9neDROZ1F4Tm9LYkd4dmt4KzR0?=
 =?utf-8?B?SjFqMnE3dGcwVC82NEZIYmpjVWY0VWlhL3N0S2owaU1FRHpUVVZ2akRCN1Rs?=
 =?utf-8?B?R0x6cnU4eGpaZWVaR240Q0JQeTdibS9HQkhibGltVlAvcFZYYjEwSk4wTWRV?=
 =?utf-8?B?eWNxUENjVUNJcEFoOXVZZWRsbm5ELzJ4QkpXOW40N1hIZzl1a0RTRFkvT1Yw?=
 =?utf-8?B?R0hCV25hRWdyRkJXNEgrOFNteXZGd0MvQ21ISDZuMTlwYXF6Nit3RlhTbW9L?=
 =?utf-8?B?Ukg0aWRHUnVvWkV0b1ZzWHY5dndqMVFZalh5WVFpWXh4c09FMTJ1cTJQdVk2?=
 =?utf-8?B?UHlOcURNUjdmZ3d6bng3VGpUT0pGSG1wck5WSENpSTl1ejFQcFB5T2VxZndn?=
 =?utf-8?B?Q29aQVZHRkFQTkNic0xhZW5TYjBVRlVuREhXelhNOTdMeE9TNXdpeUhQTkVp?=
 =?utf-8?B?TEhVUnl5YWUxb0dpdEM0bTBxRXlDN044Vkh4MUJDbTgrM0RvUHhTdzFqZXN4?=
 =?utf-8?B?ZEdZVTR4c1RNQUg3Um9JczhERHFraDdYTEFjSHVmbVJNQnUzU2NmU3BRUDE5?=
 =?utf-8?B?QjZKc0hUU1JRNS90dVhzNFFCT1I2dzZ1RFJyMHByRlhtaUk2bzdGUFZseGlS?=
 =?utf-8?B?MnlsczBuelpRSENvdzJZNVBvbEY3aFViYmFvcVF1L2VEV1k0UzRPc0VhaFNC?=
 =?utf-8?B?Ykd4Tzl1OU5VckJHS0lRYW5QNFJjcjlGakZsVC9SQkJNdG9TMVVYNWUvdG9E?=
 =?utf-8?B?VjllS21VR2dMNWpUdm5wenhwazE2a2RvVkFmQmI3L3VUWHpLQk5XSXhnZG5o?=
 =?utf-8?B?eXFJZzR4azJlY3FtUTNiU0ozM0R3TGZrcG5hQmEzeTQ3OFVhbzFQTEdBQkJh?=
 =?utf-8?B?aXMwYWtycmk1dGRLQjE2c1FRL1d4T0I5b0V5YUJObXdrRGJzMTNEdk93ckt5?=
 =?utf-8?B?QlNCQkdYbTdneVZ2T2xmTGd1bkZUQ0liSDU4RkRzelBscldxTDdibzNicTlN?=
 =?utf-8?B?Y3lLZ2lnWlJGT05aTzJ5MTBmNWU3T2J6aUZUWm9wbnk1UWkvQXJLRlpUcXJv?=
 =?utf-8?B?TGk5UFQ0S2lMREtlTk03R3ZWMzk3dkVVYTJtYjRQbC9kWU5Ob3JCUU1NeHk5?=
 =?utf-8?B?bEIvaWJtT0dpTHdvWjhuN2doVEJaenpGNWoyYURoUGJVTC9kT09TS1VSR2g0?=
 =?utf-8?B?TzhWeWkzdEZ1bVZaWGRMTXZWdVcrM001OTV6TUtHdlBRMzNUeXp5Ym9meDBZ?=
 =?utf-8?B?RVpoQTduaXJKenNra0FOS2o3MUV4MHRvSlBpaUcxYko1c292eHZ5aUlPTjdr?=
 =?utf-8?B?MTJKY0dsTHV2RFNvYk1qajZvcXFydEhNNUoyNUVSYVA0dmNjZU1xMkZkOXMr?=
 =?utf-8?Q?xd3jY6gsTNBCCHfNYv6ogxZYxMAta1d+I3d/ttBW5dPO2?=
x-ms-exchange-antispam-messagedata-1: c45rgYw9r3EUqD3TQ8beGrxGVDO93KNxTyY=
Content-Type: text/plain; charset="utf-8"
Content-ID: <5CDAA1982088F542B18159397E8E89C4@namprd04.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-Exchange-RoutingPolicyChecked: cN8+LpmGaM9PogAW8/wsvxyzgNRMuxLyqLkkKU+/3vaXyustW5JCyiKvTg2J+4cEdanwBFnBoTgFVCiy3Noqg0rskX8zr4ptq/NBX1CDQjDjEWZe9HAO6DZRlOdPr3L5IrfgEvVY+7bUjiwsGZBCSfUe7r+deACkptpd6aI9MFxw/Gla3H1VOmHVB3MSQnPx08R2gCnSmiOV4528+DXS0ARjfPY7Tt+eQceLW7bxqxymQ5571EWGtgL7RWAeg+hlK99C2DKeQRJGukrk18K9VRcGvgmlNtznX12TJqpI1vdTq+WA+zlPcAtiPf1XaIxeqV9dgk9DzT5/Ge4UsDhPnw==
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: WNa/mpnpukGJBQ4D9V/GqdplfRBZBiZM3Gw64U8TcFMxwdz3frEGJNgdGUAahAqxUdRq5QPrVpj+GXnpVieFXY/6Dt0F+V5Kvu2GunCEiZRkGsinlEOsH5SVrVc0y4b7c2H/JKqe+DUI1hH5UVi0MmRiIzjVR8NYPTy0IcSXqzB83eRN2tiKa8+R4AuAnmbhoS1Jcp+XEAvuI68sHZ6HifWAazkDoZ7NCT3h0CJzkoYg9qWnQacco7ujiYl2MXQCU7c1PYtiCG3Ca8Qsg6xiR4LmQDyGS/I9Nltz3YFyFet6K0FO2f2xY+wReI1e8Q7etKeJ/IdkxQORgfZzk8OroSpC4jT4NtSBhqws3skNZ0kbuH01tWeHZbwN7Zxb3OhOV/xyWsNP8fWxPTFPvLmQJJW/hR1laF9FipTRv5KCFuNINbAlRG6VUqlc5mnFtPGTkWRNWPRagz8B1mxw8if53929ysvT5+CX8M2TTUh+ZX5qgz8L5LJLEKPU7Q45Sg5hdc2hRKyU9M/Ff5ie6QKP9CSez5/PldwlIDZ8KJGQ1wACEym+FmS4fevoiC50FAaCa8hQsFJHp5feheqVZ0lkyCnd+C2AcxXd93YF1syqrqe5vn7g50b4CN8ka2EVpQZn
X-OriginatorOrg: wdc.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: MN6PR04MB9359.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 7780d5fa-2b4d-4a3d-aac3-08df2d884d00
X-MS-Exchange-CrossTenant-originalarrivaltime: 19 Oct 2026 02:25:54.0567 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: b61c8803-16f3-4c35-9b17-6f65f441df86
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: zrj9k45TxnvR2+37nDjrCV9y/PDZvov8uYxfYASzquXH1tuehFDMWmi4hP0Qrv5cVtVK2dmPJOKdOsfMcNdKWv4htUlguGBdzjN2dDTkNr8=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN6PR04MB9336
Received-SPF: pass client-ip=216.71.153.141;
 envelope-from=prvs=7454c2a62=Alistair.Francis@wdc.com;
 helo=esa3.hgst.iphmx.com
X-Spam_score_int: -43
X-Spam_score: -4.4
X-Spam_bar: ----
X-Spam_report: (-4.4 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_MED=-2.3, SPF_HELO_PASS=-0.001,
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

T24gRnJpLCAyMDI2LTEwLTE2IGF0IDE2OjIyIC0wNzAwLCBQaWVycmljayBCb3V2aWVyIHdyb3Rl
Og0KPiBUaGlzIHJlbW92ZXMgY29uZmxpY3Qgd2l0aCB0aGUgc2FtZSBmdW5jdGlvbiBmcm9tIHRh
cmdldC9hcm0uIFRvIHRoZQ0KPiBvcHBvc2l0ZSBvZiBhcm0gdGFyZ2V0LCB0aGVyZSBpcyBubyBl
eHRlcm5hbCBjYWxsZXIgZm9yIHRoaXMNCj4gZnVuY3Rpb24uDQo+IA0KPiBSZXZpZXdlZC1ieTog
RGFuaWVsIEhlbnJpcXVlIEJhcmJvemENCj4gPGRhbmllbC5iYXJib3phQG9zcy5xdWFsY29tbS5j
b20+DQo+IFNpZ25lZC1vZmYtYnk6IFBpZXJyaWNrIEJvdXZpZXIgPHBpZXJyaWNrLmJvdXZpZXJA
b3NzLnF1YWxjb21tLmNvbT4NCg0KQWNrZWQtYnk6IEFsaXN0YWlyIEZyYW5jaXMgPGFsaXN0YWly
LmZyYW5jaXNAd2RjLmNvbT4NCg0KQWxpc3RhaXINCg0KPiAtLS0NCj4gwqBody9yaXNjdi92aXJ0
LmPCoMKgwqDCoMKgwqDCoMKgIHwgMTAgKysrKystLS0tLQ0KPiDCoGluY2x1ZGUvaHcvcmlzY3Yv
dmlydC5oIHzCoCAxIC0NCj4gwqAyIGZpbGVzIGNoYW5nZWQsIDUgaW5zZXJ0aW9ucygrKSwgNiBk
ZWxldGlvbnMoLSkNCj4gDQo+IGRpZmYgLS1naXQgYS9ody9yaXNjdi92aXJ0LmMgYi9ody9yaXNj
di92aXJ0LmMNCj4gaW5kZXggODk0Y2RkOTc5NzYuLjJjNmY5ODNmODNmIDEwMDY0NA0KPiAtLS0g
YS9ody9yaXNjdi92aXJ0LmMNCj4gKysrIGIvaHcvcmlzY3YvdmlydC5jDQo+IEBAIC03Miw2ICs3
MiwxMSBAQCBzdGF0aWMgYm9vbA0KPiB2aXJ0X3VzZV9rdm1fYWlhX2FwbGljX2ltc2ljKFJJU0NW
VmlydEFJQVR5cGUgYWlhX3R5cGUpDQo+IMKgwqDCoMKgIHJldHVybiByaXNjdl9pc19rdm1fYWlh
X2FwbGljX2ltc2ljKG1zaW1vZGUpOw0KPiDCoH0NCj4gwqANCj4gK3N0YXRpYyBib29sIHZpcnRf
aXNfYWNwaV9lbmFibGVkKFJJU0NWVmlydFN0YXRlICpzKQ0KPiArew0KPiArwqDCoMKgIHJldHVy
biBzLT5hY3BpICE9IE9OX09GRl9BVVRPX09GRjsNCj4gK30NCj4gKw0KPiDCoHN0YXRpYyBib29s
IHZpcnRfdXNlX2VtdWxhdGVkX2FwbGljKFJJU0NWVmlydEFJQVR5cGUgYWlhX3R5cGUpDQo+IMKg
ew0KPiDCoMKgwqDCoCBib29sIG1zaW1vZGUgPSBhaWFfdHlwZSA9PSBWSVJUX0FJQV9UWVBFX0FQ
TElDX0lNU0lDOw0KPiBAQCAtMTA2NywxMSArMTA3Miw2IEBAIHN0YXRpYyB2b2lkIHZpcnRfc2V0
X2lvbW11X3N5cyhPYmplY3QgKm9iaiwNCj4gVmlzaXRvciAqdiwgY29uc3QgY2hhciAqbmFtZSwN
Cj4gwqDCoMKgwqAgdmlzaXRfdHlwZV9Pbk9mZkF1dG8odiwgbmFtZSwgJnMtPmlvbW11X3N5cywg
ZXJycCk7DQo+IMKgfQ0KPiDCoA0KPiAtYm9vbCB2aXJ0X2lzX2FjcGlfZW5hYmxlZChSSVNDVlZp
cnRTdGF0ZSAqcykNCj4gLXsNCj4gLcKgwqDCoCByZXR1cm4gcy0+YWNwaSAhPSBPTl9PRkZfQVVU
T19PRkY7DQo+IC19DQo+IC0NCj4gwqBzdGF0aWMgdm9pZCB2aXJ0X2dldF9hY3BpKE9iamVjdCAq
b2JqLCBWaXNpdG9yICp2LCBjb25zdCBjaGFyICpuYW1lLA0KPiDCoMKgwqDCoMKgwqDCoMKgwqDC
oMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgIHZvaWQgKm9wYXF1ZSwgRXJyb3IgKipl
cnJwKQ0KPiDCoHsNCj4gZGlmZiAtLWdpdCBhL2luY2x1ZGUvaHcvcmlzY3YvdmlydC5oIGIvaW5j
bHVkZS9ody9yaXNjdi92aXJ0LmgNCj4gaW5kZXggZTUxNjg5OGY5YWQuLjE2ZDg2ZWRmY2ZjIDEw
MDY0NA0KPiAtLS0gYS9pbmNsdWRlL2h3L3Jpc2N2L3ZpcnQuaA0KPiArKysgYi9pbmNsdWRlL2h3
L3Jpc2N2L3ZpcnQuaA0KPiBAQCAtMTIxLDcgKzEyMSw2IEBAIGVudW0gew0KPiDCoCNkZWZpbmUg
VklSVF9QTElDX1NJWkUoX19udW1fY29udGV4dCkgXA0KPiDCoMKgwqDCoCAoVklSVF9QTElDX0NP
TlRFWFRfQkFTRSArIChfX251bV9jb250ZXh0KSAqDQo+IFZJUlRfUExJQ19DT05URVhUX1NUUklE
RSkNCj4gwqANCj4gLWJvb2wgdmlydF9pc19hY3BpX2VuYWJsZWQoUklTQ1ZWaXJ0U3RhdGUgKnMp
Ow0KPiDCoGJvb2wgdmlydF9pc19pb21tdV9zeXNfZW5hYmxlZChSSVNDVlZpcnRTdGF0ZSAqcyk7
DQo+IMKgdm9pZCB2aXJ0X2FjcGlfc2V0dXAoUklTQ1ZWaXJ0U3RhdGUgKnZtcyk7DQo+IMKgDQo=

