Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9EEE3C02193
	for <qemu-devel@archiver.kernel.org>; Mon,  3 Feb 2025 07:30:18 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1teqtp-0006nK-Us; Mon, 03 Feb 2025 02:29:41 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jamin_lin@aspeedtech.com>)
 id 1teqtJ-0006Wy-Rl; Mon, 03 Feb 2025 02:29:11 -0500
Received: from mail-psaapc01on20711.outbound.protection.outlook.com
 ([2a01:111:f403:200e::711]
 helo=APC01-PSA-obe.outbound.protection.outlook.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jamin_lin@aspeedtech.com>)
 id 1teqtF-0001Pl-0B; Mon, 03 Feb 2025 02:29:09 -0500
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=twp+luY9lnxc2+/LgcX/7mfJg4VWJOJFIli7TWiVV1LFyfAvLkud0V6Fi7x3mCW1H/vELfeIeYdu3RYJaLtk9Vy8Ccf/oaUR0Y9XFduyYsJsuHqM1dxGUiHo+G49fzycb1drqxpXK/e6QM1Cd2sLw5nZSMrPLvF3J/RPua04paR7zENHdGqUApkTKYH2HsNlrDn7djAdg25TEx2SbTL4zuwzCskmgRD5YrvkTPx9t5MgMmAGDcrss5rupo25ZkhTTYEiFYujTjj5MwjhhJEcARnm9TpP4Gi8pdqqH59Cono52zVe4x9lKNmPn4STTPwet6b6wqJJha1APtI5og4bxQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=fYERllGJsapGM4LUIfhKw6x0NNpgi/TVJsBhE4dJZAg=;
 b=DjFlyjt1/3qvnNYuElnHsa3C4ed970A2vEIZhpFIaACATw/zR9r5eLybGARmL5vrqdZd99QbIA7l6au98AJqWLwSf9IQRxQQdRnbtqS4i0QStUKBd1EbzVc1zvuVZjUSUOqzHyioUHh51Sk/zMNm+m7PbgADy3s+SSXFS2nmGICixKkoD8siJTR2qEKv3Wvpt8/RnKdk6RdG1M9Yt/LqghVl4mcpTPoVfCuZCG04AL0azOQDhDQAgdg/vQ0kemH90au2yHTvrNuWRhQ9474NlY7MGmHRsRB4GWPd7DppE5ZYs0PZz3Sb41PKA34d97Phlzfk417AQqtuqEH/q1SwOA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=aspeedtech.com; dmarc=pass action=none
 header.from=aspeedtech.com; dkim=pass header.d=aspeedtech.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=aspeedtech.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=fYERllGJsapGM4LUIfhKw6x0NNpgi/TVJsBhE4dJZAg=;
 b=o6jxB9eQiZr0Mto6hfqED8TVrVka9NhwIT3QIglYzeIAn7UxEVtBA5tlHXfIs1PrtJW7J+1FVG62V4mU2xZQTe/qaqGajlxuuc4mhq07MnzlifvyG3rVNMniwHVXwscmpO46E4DIdEUY49T3xILYnm6C8HIr9TAKqO59T+nQOOgtmzb6IJAl66Lmtv2/JflSIljtHDGuSGXlhJmIbujcGRkohkVEacnZrF4sJ7P43e+gZ3RSyA56jHEp1mbpfmRNa3Regyulm7ZYd/PlFB9mMleF8j8XSTQTbp5bfdSwNzExHglYZTgHctO54MF4rd1VejcvGo8/Hj6hWZ+lJ12u4Q==
Received: from SI2PR06MB5041.apcprd06.prod.outlook.com (2603:1096:4:1a4::6) by
 SEYPR06MB6131.apcprd06.prod.outlook.com (2603:1096:101:dc::12) with
 Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.8422.8; Mon, 3 Feb 2025 07:28:50 +0000
Received: from SI2PR06MB5041.apcprd06.prod.outlook.com
 ([fe80::705a:352a:7564:8e56]) by SI2PR06MB5041.apcprd06.prod.outlook.com
 ([fe80::705a:352a:7564:8e56%5]) with mapi id 15.20.8422.005; Mon, 3 Feb 2025
 07:28:50 +0000
From: Jamin Lin <jamin_lin@aspeedtech.com>
To: =?utf-8?B?UGhpbGlwcGUgTWF0aGlldS1EYXVkw6k=?= <philmd@linaro.org>,
 =?utf-8?B?Q8OpZHJpYyBMZSBHb2F0ZXI=?= <clg@kaod.org>, Peter Maydell
 <peter.maydell@linaro.org>, Andrew Jeffery <andrew@codeconstruct.com.au>,
 Joel Stanley <joel@jms.id.au>, Alistair Francis <alistair@alistair23.me>,
 Cleber Rosa <crosa@redhat.com>, Wainer dos Santos Moschetta
 <wainersm@redhat.com>, Beraldo Leal <bleal@redhat.com>, "open list:ASPEED
 BMCs" <qemu-arm@nongnu.org>, "open list:All patches CC here"
 <qemu-devel@nongnu.org>, Jinjie Ruan <ruanjinjie@huawei.com>
CC: Troy Lee <troy_lee@aspeedtech.com>, Yunlin Tang
 <yunlin.tang@aspeedtech.com>
Subject: RE: [PATCH v5 13/17] aspeed/soc: Add AST2700 support
Thread-Topic: [PATCH v5 13/17] aspeed/soc: Add AST2700 support
Thread-Index: AQHatkJWGs9xLfQ5AU+zfhhp5GQ22rMw5oUAgAXDrjA=
Date: Mon, 3 Feb 2025 07:28:50 +0000
Message-ID: <SI2PR06MB5041F84077718CE5A58B8F54FCF52@SI2PR06MB5041.apcprd06.prod.outlook.com>
References: <20240604054438.3424349-1-jamin_lin@aspeedtech.com>
 <20240604054438.3424349-14-jamin_lin@aspeedtech.com>
 <ffafbec0-db25-478b-8eba-39162f9bce0d@linaro.org>
In-Reply-To: <ffafbec0-db25-478b-8eba-39162f9bce0d@linaro.org>
Accept-Language: zh-TW, en-US
Content-Language: zh-TW
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=aspeedtech.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: SI2PR06MB5041:EE_|SEYPR06MB6131:EE_
x-ms-office365-filtering-correlation-id: dbbdac86-bf90-4966-f75d-08dd44246768
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
 ARA:13230040|366016|1800799024|7416014|376014|38070700018|921020; 
x-microsoft-antispam-message-info: =?utf-8?B?STliQnRJOS9PYjd0UnZtQVlVTVRXbnZka1FFZUczL3doclhReEN0QmxCTzFM?=
 =?utf-8?B?ZXR2UVUvMGhyWi9MR1EyeW1ySHdYZ1hqNE9UcjN3a2YrVVQ4NGxoQkZCQ2V4?=
 =?utf-8?B?c1dMeGRiNHZnVmpUV1B0VmRHMEhnVnk3dWtTdXdkdk1tQWZsdytYaUpKYlgv?=
 =?utf-8?B?SzEyTnFGa29wWHpPY0NCeVc0TXZReUY0cENxcGFneTRGUUplcitHdGtyWVVK?=
 =?utf-8?B?a2E4RGpKWHE1cU02cVhQMUpURjR0MDFMVDUvVUtBQ2dqMmFEZUJxaFlSYlRX?=
 =?utf-8?B?VG1ibXVRcGQ2NnpuM05jaGxTRDVDaEorQlIyc1FpRHkrQkx3MFBhSHFSKzYz?=
 =?utf-8?B?bWpPOS9GZk53Ukpwdlg1a2NyRE5QQ0xjSVc2ZWJNc3hMczNDNTgzSktKZTc2?=
 =?utf-8?B?d21RS3BKL3ZBaW5CSFlZL2tWQnpsNGFqeUZnYUpvUjRYR3dZR05yeWpsMEpr?=
 =?utf-8?B?ZHlMZlo5SjRWWWR4d2tyYU5haWdLQnZEMTZNNVRrR05TNmM4ZlE3U0E3Y0Rl?=
 =?utf-8?B?Qm5nQlRJM25rdCtuZ2Zwb0tpVDExR21ibjJvVXNyTlB2QW1TNXhZclJQamZt?=
 =?utf-8?B?NWdVdjllU0hVWTlGcTJFSXNFemllc3lFbFFES05kazNLVmx1NWxMWE9hWEhj?=
 =?utf-8?B?eVZqZnJkb3A3LzA4RHNIaVhDL1RReE9WZUZ4bHg4UlBkem4vR2FKUmI3WlA4?=
 =?utf-8?B?TC9ad3QxbFltRkdaNzZBcVJFZTV4emFLbnM2MzljM085Vit2TVlibHBRcCtJ?=
 =?utf-8?B?UWhodnpUWXh6UWJka2ZObytGS0dFWnhrLy9qSlFSbWFPMGNBRDJuaWNUeXBv?=
 =?utf-8?B?aGZXQk5RNkVwcElSbGVRbysySS80YnRLYnovSkJBSGtBVUt5TjM5N3F4NjRJ?=
 =?utf-8?B?aVZVaUhFemZIVzRMYnpwQ3NqaFVOeTFIWHZSYXY3QnZuL2drcVRvUTZmc1Fo?=
 =?utf-8?B?L2tIbHlVb29hK1lSZHFUMVZxUlgzS1dHSjRGZlF2MTJiMFp5YWtaWWVqcEZU?=
 =?utf-8?B?ZmovUUZ0eTZMZ0dmVlgrZVlnd1BSaW1pTmVnb3VEZEFVVlRLUkZ4VDJQTzZY?=
 =?utf-8?B?N1Z4NlJYSitXZ2M2OUh1K0pTbFd4WTNEa2ZsdWNLQnB1Y0EraEhCL21mNmk1?=
 =?utf-8?B?c1piT2xoKzA5aVBTbFM3YXB4K2cyMU1RbllLTHV2aTJmcXcwK05NTGlsYWls?=
 =?utf-8?B?YmJ6WHNpeW4rNUhuNDlJeWZVdFhEQkl2RWlnRXRvVkpVWlNLRHVGOU4yMlND?=
 =?utf-8?B?QmwxS2tFUnAxeGU2TVkyVk95SmkrRHNnYXVBWnpBZkRNdHoxR1dwc1g5c2pi?=
 =?utf-8?B?TU84Q2ZJQW1OUXN6d0lMUFJ0cDFQRHZpSytCZVpwZUw4U3hGRFlWL2U0SWxP?=
 =?utf-8?B?WlAxakU2ekJFaUJNa204UjFnaGk0S2ZORGtFbVBkTHpLUDRmcWZNMEN5M2k4?=
 =?utf-8?B?WkZNZHVmUDRaV25iMmhKWDZkQ3BsZFZ0N2NYZ2cyRDdQR0o0eXFqMFV2bjlz?=
 =?utf-8?B?THY5a2xEMnFTNVRzUTI2M3M1Z1hyR0R3dnBPdEVISkoxdFNPeE9PeVJyb1ln?=
 =?utf-8?B?TmFOb2JSeGxRWVphclJRYXBrK1hONUo0NEtoN1ZwTVVCb3MveDFLL2RoazZE?=
 =?utf-8?B?QkRVaExKTHhuZkdoTDk3U3ZFRDhzQkMva21abWVGMG5iZmkwcWZWNTVKRjBH?=
 =?utf-8?B?MDJFd1VNa3NDS3NobnhwdjhiUkpCQjBPclBsbFpERGRpM2dGalBzTEsvejhm?=
 =?utf-8?B?SkF5dklsaS9jQ3pMMWNqMUhoWDg0QkUzMndHakJEZHJ4K2R3NDdzaXdZcSt0?=
 =?utf-8?B?OUxndkVEL0p6d1FaQ3N5ZTFPWlJQUWg3NERnOEV5Tk5rdzdTSWpTUkw3T1Bh?=
 =?utf-8?B?WDV5NDZPc2l0b2M5MldLN3luSEJ3L0ZYVGRMdTlnYXBxL2Zjb1pDbG1IUW1y?=
 =?utf-8?B?clFrUjFqbGhnT2VyYTVJS0VWWG9seWF2ZTNSRkZmRWpDY1JwaXEvM0p3TlQr?=
 =?utf-8?B?NU1Sd3l3RkdnPT0=?=
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:zh-tw; SCL:1;
 SRV:; IPV:NLI; SFV:NSPM; H:SI2PR06MB5041.apcprd06.prod.outlook.com; PTR:;
 CAT:NONE;
 SFS:(13230040)(366016)(1800799024)(7416014)(376014)(38070700018)(921020);
 DIR:OUT; SFP:1102; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?R2huN3dtUmFlcGpDdTdEUXBTSkZpT1BLM3pkbjNpdEQzYnJwRVAzZ3JGZnJu?=
 =?utf-8?B?K3ZuaW45elA0ZmxVTDZFL2p3QmFRTXRZd3gzSU5HM2txdTZqLzAxY2tmRENN?=
 =?utf-8?B?bW5uNE1sZUhDWU0zYzRvYnVrN3ZVamlGYUlDa3V4NnVRSWl6SmhVcGJ2K3lN?=
 =?utf-8?B?R1gyTW9qNWh5OVREQlZ3aUc5Y2lDUFZyNE4vMEJOQXNYTnU0VG5rSWxsNDFy?=
 =?utf-8?B?azZWQkRBRHFnY01ZRGhtY2doT1VnUGIzNGUyMDlDdTdycm8zYU9NOHYvOWNk?=
 =?utf-8?B?MHJRV2QydWx4ZFRNcEphT1BsYUVOT25UL3orWVhYUWJaeEt6enBoN2VlWXIz?=
 =?utf-8?B?am5mTVNPK0FYTWpyQ1Y2ZFVZTkZ1aVhMOTFoeExDWGwxNHJaOGZNaGE5ZWZB?=
 =?utf-8?B?c2hBQ2x3amRzWU01SXRsUmdCU2hqUi9iT294UTNhM3lDSkxqMWc0OWZYWGlX?=
 =?utf-8?B?WUFhU1d5Ukx1N001Zy92T1V2cHc0TlVmVTRTaXRPMzZFWDNRbDhNMjVZWDA3?=
 =?utf-8?B?eS9aWVpneXZHbXdUeDVhU0dLN0pVbnAxWU9sNEltUFJjS3J5d0tPVnFBbVRT?=
 =?utf-8?B?a01VaFgrZ0ZXOEdmZ0VCazhwUWx3enkvblRmV096MFpkeVl0eE1NOFpNbm43?=
 =?utf-8?B?cHJKendMMTE4WEZKdU55cGFhUjBKSVcwdVNvVnlPWWwvNWZWM0RSMEFWcytU?=
 =?utf-8?B?RXhBZTk0NVQ3K0NUMXNtN3JjeG5Lelk3NldzN1JUR1IvWHZ3YVBGOExWV1ly?=
 =?utf-8?B?ckMzS3JocTRHSkVyWmRDakhGbjhIaURNOFM4bVE4V1lmZHNETTVteXpmSU5k?=
 =?utf-8?B?cWszbGdDU3dsZVpBYmN5ZWlzeVlCOEJiNStHSGFaS00yNjVHV0J3Qkdtdlp1?=
 =?utf-8?B?cTVtVEY3a2VoQjVYeHdvSnRyRk0rdmY4Vk56czNDelpaUmFqUTBnMHZMQy9m?=
 =?utf-8?B?dUFmUktpc3VjMEZrdm5MQkhQVWVTMTNldWxNUE9WK096V05YdnZDc3Byd3FF?=
 =?utf-8?B?MElBOVQwK1RCWko4ZHdQK01vbFpzdWlrMmI2Y1QrRnFqRGFyYUsrMElydm9B?=
 =?utf-8?B?bkx1VGMzZ3JIVmsvd3l4a1VONmZaaWFObHlsUnBQenZ1U1YxR3A0YTJBb0Fa?=
 =?utf-8?B?Mlh0cUpzY01hOW9ZcHcxREtrYVZpYi9VL29UTTdkZnZKb1pkdnZNZmtlTmZJ?=
 =?utf-8?B?TURpL29ERmljM1JqMXBiK21YWDhabWNuWS9lRXp1VVp3UU1lMmZiTG1PbThz?=
 =?utf-8?B?L3pxZUp4UDJXcm9mLzRXenRWQUg3UDZ3SEFqS1gycnNKSkVINVM3cmVxWHdk?=
 =?utf-8?B?Nm96U3BFV2FqWGt0S3dkWVJ5YmI2eXk0T3M0eURJSWVqdDBEYkI2dHdmRUNa?=
 =?utf-8?B?UWorOVRJUzVvV2lnNlIzUGMxaXhoKytrbVMycHU3SHdHWHJJbkkzVUpwcjJo?=
 =?utf-8?B?cGNlRVBVc1VVT2F0V3NqYlQ2dmt0cnRLN1g4K3ZBVDVhNGZJV3NOV0R3b21r?=
 =?utf-8?B?Ymx5eG1MSnhyT1QrNldvTERGVlZ5ZCt3WDhtRU84dXU0VzBqOEVWRkREeVpL?=
 =?utf-8?B?ZzNvNjBsQnhGODh4VnAyTldDTUkxWDZONjNFY1V4VlhvZ3ppai90dVFGT2FN?=
 =?utf-8?B?L2lQN2Z4dTdSNldFb3M0bTVPcGlkRFk5Q2VBaEYrNGhTQTh6VGpiWTRSaC9i?=
 =?utf-8?B?WU5sbTVOMkVkYWVGM0pLRVozTkw4VDRsb2prSkpxdFozMHNlaUN3YWxFbjNa?=
 =?utf-8?B?R1loSURpenRnRGpyTEFiYzd3Yzk0UW1jejVRTEFkRE5wcVRLRmpnQytCNVJC?=
 =?utf-8?B?ekIwakUrcUdLQ0RDZU9TNjJzOUxjK0N2NmlDWW5sUWQ5SzRXRGJ3YzIzemln?=
 =?utf-8?B?blJaWVVSUGlESmZrWjI5WWJNVVhGUXduWlZKRElnYXNDUXpYNWNuM3krVHYy?=
 =?utf-8?B?MmlYREp2cUw4ZFRlTDNRRlZSWXRrRjFRWWdhQkxPRU9LTmZCaWozdGJiS0c3?=
 =?utf-8?B?ZWkrRFJtaDFXM3dJMVVENE9LSlR0QVpTTHZhRTk0VnlOOGRCeEpNcmozaXlF?=
 =?utf-8?B?SkcyYjRROGlGeE1ubktQODlvSkdteEJrQ1lEdUsrZlRURWhYTm9jbmUxclc5?=
 =?utf-8?Q?b7sI9IZ4Ef7xuGTkAjvEW/EZJ?=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: aspeedtech.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: SI2PR06MB5041.apcprd06.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: dbbdac86-bf90-4966-f75d-08dd44246768
X-MS-Exchange-CrossTenant-originalarrivaltime: 03 Feb 2025 07:28:50.0383 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 43d4aa98-e35b-4575-8939-080e90d5a249
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 6+sg6ntI0kHeyick/Lq7E4iuEk7KHhMzX4Q6tYW072q/KI16ilCWA4n6whgveXwzJk4Qolu56aHkO6gqGG0kszVLo/jNgM7WTsqJTThHCv8=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SEYPR06MB6131
Received-SPF: pass client-ip=2a01:111:f403:200e::711;
 envelope-from=jamin_lin@aspeedtech.com;
 helo=APC01-PSA-obe.outbound.protection.outlook.com
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

SGkgUGhpbGlwcGUsDQoNCj4gRnJvbTogUGhpbGlwcGUgTWF0aGlldS1EYXVkw6kgPHBoaWxtZEBs
aW5hcm8ub3JnPg0KPiBTZW50OiBUaHVyc2RheSwgSmFudWFyeSAzMCwgMjAyNSAxMToxNCBQTQ0K
PiBUbzogSmFtaW4gTGluIDxqYW1pbl9saW5AYXNwZWVkdGVjaC5jb20+OyBDw6lkcmljIExlIEdv
YXRlciA8Y2xnQGthb2Qub3JnPjsNCj4gUGV0ZXIgTWF5ZGVsbCA8cGV0ZXIubWF5ZGVsbEBsaW5h
cm8ub3JnPjsgQW5kcmV3IEplZmZlcnkNCj4gPGFuZHJld0Bjb2RlY29uc3RydWN0LmNvbS5hdT47
IEpvZWwgU3RhbmxleSA8am9lbEBqbXMuaWQuYXU+OyBBbGlzdGFpcg0KPiBGcmFuY2lzIDxhbGlz
dGFpckBhbGlzdGFpcjIzLm1lPjsgQ2xlYmVyIFJvc2EgPGNyb3NhQHJlZGhhdC5jb20+OyBXYWlu
ZXINCj4gZG9zIFNhbnRvcyBNb3NjaGV0dGEgPHdhaW5lcnNtQHJlZGhhdC5jb20+OyBCZXJhbGRv
IExlYWwNCj4gPGJsZWFsQHJlZGhhdC5jb20+OyBvcGVuIGxpc3Q6QVNQRUVEIEJNQ3MgPHFlbXUt
YXJtQG5vbmdudS5vcmc+OyBvcGVuDQo+IGxpc3Q6QWxsIHBhdGNoZXMgQ0MgaGVyZSA8cWVtdS1k
ZXZlbEBub25nbnUub3JnPjsgSmluamllIFJ1YW4NCj4gPHJ1YW5qaW5qaWVAaHVhd2VpLmNvbT4N
Cj4gQ2M6IFRyb3kgTGVlIDx0cm95X2xlZUBhc3BlZWR0ZWNoLmNvbT47IFl1bmxpbiBUYW5nDQo+
IDx5dW5saW4udGFuZ0Bhc3BlZWR0ZWNoLmNvbT4NCj4gU3ViamVjdDogUmU6IFtQQVRDSCB2NSAx
My8xN10gYXNwZWVkL3NvYzogQWRkIEFTVDI3MDAgc3VwcG9ydA0KPiANCj4gSGkgSmFtaW4sDQo+
IA0KPiBPbiA0LzYvMjQgMDc6NDQsIEphbWluIExpbiB3cm90ZToNCj4gPiBJbml0aWFsIGRlZmlu
aXRpb25zIGZvciBhIHNpbXBsZSBtYWNoaW5lIHVzaW5nIGFuIEFTVDI3MDAgU09DIChDb3J0ZXgt
YTM1DQo+IENQVSkuDQo+ID4NCj4gPiBBU1QyNzAwIFNPQyBhbmQgaXRzIGludGVycnVwdCBjb250
cm9sbGVyIGFyZSB0b28gY29tcGxleCB0byBoYW5kbGUgaW4NCj4gPiB0aGUgY29tbW9uIEFzcGVl
ZCBTb0MgZnJhbWV3b3JrLiBXZSBpbnRyb2R1Y2UgYSBuZXcgYXN0MjcwMCBjbGFzcyB3aXRoDQo+
ID4gaW5zdGFuY2VfaW5pdCBhbmQgcmVhbGl6ZSBoYW5kbGVycy4NCj4gPg0KPiA+IEFTVDI3MDAg
aXMgYSA2NCBiaXRzIHF1YWQgY29yZSBjcHVzIGFuZCBzdXBwb3J0IDggd2F0Y2hkb2cuDQo+ID4g
VXBkYXRlIG1heGltdW0gQVNQRUVEX0NQVVNfTlVNIHRvIDQgYW5kIEFTUEVFRF9XRFRTX05VTSB0
byA4Lg0KPiA+IEluIGFkZGl0aW9uLCB1cGRhdGUgQXNwZWVkU29jU3RhdGUgdG8gc3VwcG9ydCBz
Y3Vpbywgc2xpLCBzbGlpbyBhbmQgaW50Yy4NCj4gPg0KPiA+IEFkZCBUWVBFX0FTUEVFRDI3WDBf
U09DIG1hY2hpbmUgdHlwZS4NCj4gPg0KPiA+IFRoZSBTRE1DIGNvbnRyb2xsZXIgaXMgdW5sb2Nr
ZWQgYXQgU1BMIHN0YWdlLg0KPiA+IEF0IHByZXNlbnQsIG9ubHkgc3VwcG9ydHMgdG8gZW11bGF0
ZSBib290aW5nIHN0YXJ0IGZyb20gdS1ib290IHN0YWdlLg0KPiA+IFNldCBTRE1DIGNvbnRyb2xs
ZXIgdW5sb2NrZWQgYnkgZGVmYXVsdC4NCj4gPg0KPiA+IEluIElOVEMsIGVhY2ggaW50ZXJydXB0
IG9mIElOVCAxMjggdG8gSU5UIDEzNiBjb21iaW5lcyAzMiBpbnRlcnJ1cHRzLg0KPiA+IEl0IGNv
bm5lY3QgR0lDSU5UIElSUSBHUElPLU9VVFBVVCBwaW5zIHRvIEdJQyBkZXZpY2Ugd2l0aCBpcnEg
MTI4IHRvIDEzNi4NCj4gPiBBbmQsIGlmIGEgZGV2aWNlIGlycSBpcyAxMjggdG8gMTM2LCBpdHMg
aXJxIEdQSU8tT1VUUFVUIHBpbiBpcw0KPiA+IGNvbm5lY3RlZCB0byBHSUNJTlQgb3ItZ2F0ZXMg
aW5zdGVhZCBvZiBHSUMgZGV2aWNlLg0KPiA+DQo+ID4gU2lnbmVkLW9mZi1ieTogVHJveSBMZWUg
PHRyb3lfbGVlQGFzcGVlZHRlY2guY29tPg0KPiA+IFNpZ25lZC1vZmYtYnk6IEphbWluIExpbiA8
amFtaW5fbGluQGFzcGVlZHRlY2guY29tPg0KPiA+IC0tLQ0KPiA+ICAgaHcvYXJtL2FzcGVlZF9h
c3QyN3gwLmMgICAgIHwgNTYzDQo+ICsrKysrKysrKysrKysrKysrKysrKysrKysrKysrKysrKysr
Kw0KPiA+ICAgaHcvYXJtL21lc29uLmJ1aWxkICAgICAgICAgIHwgICAxICsNCj4gPiAgIGluY2x1
ZGUvaHcvYXJtL2FzcGVlZF9zb2MuaCB8ICAyOCArLQ0KPiA+ICAgMyBmaWxlcyBjaGFuZ2VkLCA1
OTAgaW5zZXJ0aW9ucygrKSwgMiBkZWxldGlvbnMoLSkNCj4gPiAgIGNyZWF0ZSBtb2RlIDEwMDY0
NCBody9hcm0vYXNwZWVkX2FzdDI3eDAuYw0KPiANCj4gDQo+ID4gK3N0YXRpYyBib29sIGFzcGVl
ZF9zb2NfYXN0MjcwMF9naWNfcmVhbGl6ZShEZXZpY2VTdGF0ZSAqZGV2LCBFcnJvcg0KPiA+ICsq
KmVycnApIHsNCj4gPiArICAgIEFzcGVlZDI3eDBTb0NTdGF0ZSAqYSA9IEFTUEVFRDI3WDBfU09D
KGRldik7DQo+ID4gKyAgICBBc3BlZWRTb0NTdGF0ZSAqcyA9IEFTUEVFRF9TT0MoZGV2KTsNCj4g
PiArICAgIEFzcGVlZFNvQ0NsYXNzICpzYyA9IEFTUEVFRF9TT0NfR0VUX0NMQVNTKHMpOw0KPiA+
ICsgICAgU3lzQnVzRGV2aWNlICpnaWNidXNkZXY7DQo+ID4gKyAgICBEZXZpY2VTdGF0ZSAqZ2lj
ZGV2Ow0KPiA+ICsgICAgUUxpc3QgKnJlZGlzdF9yZWdpb25fY291bnQ7DQo+ID4gKyAgICBpbnQg
aTsNCj4gPiArDQo+ID4gKyAgICBnaWNidXNkZXYgPSBTWVNfQlVTX0RFVklDRSgmYS0+Z2ljKTsN
Cj4gPiArICAgIGdpY2RldiA9IERFVklDRSgmYS0+Z2ljKTsNCj4gPiArICAgIHFkZXZfcHJvcF9z
ZXRfdWludDMyKGdpY2RldiwgInJldmlzaW9uIiwgMyk7DQo+ID4gKyAgICBxZGV2X3Byb3Bfc2V0
X3VpbnQzMihnaWNkZXYsICJudW0tY3B1Iiwgc2MtPm51bV9jcHVzKTsNCj4gPiArICAgIHFkZXZf
cHJvcF9zZXRfdWludDMyKGdpY2RldiwgIm51bS1pcnEiLCBBU1QyNzAwX01BWF9JUlEpOw0KPiA+
ICsNCj4gPiArICAgIHJlZGlzdF9yZWdpb25fY291bnQgPSBxbGlzdF9uZXcoKTsNCj4gPiArICAg
IHFsaXN0X2FwcGVuZF9pbnQocmVkaXN0X3JlZ2lvbl9jb3VudCwgc2MtPm51bV9jcHVzKTsNCj4g
PiArICAgIHFkZXZfcHJvcF9zZXRfYXJyYXkoZ2ljZGV2LCAicmVkaXN0LXJlZ2lvbi1jb3VudCIs
DQo+ID4gKyByZWRpc3RfcmVnaW9uX2NvdW50KTsNCj4gPiArDQo+ID4gKyAgICBpZiAoIXN5c2J1
c19yZWFsaXplKGdpY2J1c2RldiwgZXJycCkpIHsNCj4gPiArICAgICAgICByZXR1cm4gZmFsc2U7
DQo+ID4gKyAgICB9DQo+ID4gKyAgICBzeXNidXNfbW1pb19tYXAoZ2ljYnVzZGV2LCAwLCBzYy0+
bWVtbWFwW0FTUEVFRF9HSUNfRElTVF0pOw0KPiA+ICsgICAgc3lzYnVzX21taW9fbWFwKGdpY2J1
c2RldiwgMSwgc2MtPm1lbW1hcFtBU1BFRURfR0lDX1JFRElTVF0pOw0KPiA+ICsNCj4gPiArICAg
IGZvciAoaSA9IDA7IGkgPCBzYy0+bnVtX2NwdXM7IGkrKykgew0KPiA+ICsgICAgICAgIERldmlj
ZVN0YXRlICpjcHVkZXYgPSBERVZJQ0UoJmEtPmNwdVtpXSk7DQo+ID4gKyAgICAgICAgaW50IE5V
TV9JUlFTID0gMjU2LCBBUkNIX0dJQ19NQUlOVF9JUlEgPSA5LA0KPiBWSVJUVUFMX1BNVV9JUlEg
PSA3Ow0KPiA+ICsgICAgICAgIGludCBwcGliYXNlID0gTlVNX0lSUVMgKyBpICogR0lDX0lOVEVS
TkFMICsgR0lDX05SX1NHSVM7DQo+ID4gKw0KPiA+ICsgICAgICAgIGNvbnN0IGludCB0aW1lcl9p
cnFbXSA9IHsNCj4gPiArICAgICAgICAgICAgW0dUSU1FUl9QSFlTXSA9IDE0LA0KPiA+ICsgICAg
ICAgICAgICBbR1RJTUVSX1ZJUlRdID0gMTEsDQo+ID4gKyAgICAgICAgICAgIFtHVElNRVJfSFlQ
XSAgPSAxMCwNCj4gPiArICAgICAgICAgICAgW0dUSU1FUl9TRUNdICA9IDEzLA0KPiA+ICsgICAg
ICAgIH07DQo+ID4gKyAgICAgICAgaW50IGo7DQo+ID4gKw0KPiA+ICsgICAgICAgIGZvciAoaiA9
IDA7IGogPCBBUlJBWV9TSVpFKHRpbWVyX2lycSk7IGorKykgew0KPiA+ICsgICAgICAgICAgICBx
ZGV2X2Nvbm5lY3RfZ3Bpb19vdXQoY3B1ZGV2LCBqLA0KPiA+ICsgICAgICAgICAgICAgICAgICAg
IHFkZXZfZ2V0X2dwaW9faW4oZ2ljZGV2LCBwcGliYXNlICsgdGltZXJfaXJxW2pdKSk7DQo+ID4g
KyAgICAgICAgfQ0KPiA+ICsNCj4gPiArICAgICAgICBxZW11X2lycSBpcnEgPSBxZGV2X2dldF9n
cGlvX2luKGdpY2RldiwNCj4gPiArICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAg
ICAgIHBwaWJhc2UgKw0KPiBBUkNIX0dJQ19NQUlOVF9JUlEpOw0KPiA+ICsgICAgICAgIHFkZXZf
Y29ubmVjdF9ncGlvX291dF9uYW1lZChjcHVkZXYsDQo+ICJnaWN2My1tYWludGVuYW5jZS1pbnRl
cnJ1cHQiLA0KPiA+ICsgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAwLCBpcnEp
Ow0KPiA+ICsgICAgICAgIHFkZXZfY29ubmVjdF9ncGlvX291dF9uYW1lZChjcHVkZXYsICJwbXUt
aW50ZXJydXB0IiwgMCwNCj4gPiArICAgICAgICAgICAgICAgIHFkZXZfZ2V0X2dwaW9faW4oZ2lj
ZGV2LCBwcGliYXNlICsNCj4gVklSVFVBTF9QTVVfSVJRKSk7DQo+ID4gKw0KPiA+ICsgICAgICAg
IHN5c2J1c19jb25uZWN0X2lycShnaWNidXNkZXYsIGksIHFkZXZfZ2V0X2dwaW9faW4oY3B1ZGV2
LA0KPiBBUk1fQ1BVX0lSUSkpOw0KPiA+ICsgICAgICAgIHN5c2J1c19jb25uZWN0X2lycShnaWNi
dXNkZXYsIGkgKyBzYy0+bnVtX2NwdXMsDQo+ID4gKyAgICAgICAgICAgICAgICAgICAgICAgICAg
IHFkZXZfZ2V0X2dwaW9faW4oY3B1ZGV2LA0KPiBBUk1fQ1BVX0ZJUSkpOw0KPiA+ICsgICAgICAg
IHN5c2J1c19jb25uZWN0X2lycShnaWNidXNkZXYsIGkgKyAyICogc2MtPm51bV9jcHVzLA0KPiA+
ICsgICAgICAgICAgICAgICAgICAgICAgICAgICBxZGV2X2dldF9ncGlvX2luKGNwdWRldiwNCj4g
QVJNX0NQVV9WSVJRKSk7DQo+ID4gKyAgICAgICAgc3lzYnVzX2Nvbm5lY3RfaXJxKGdpY2J1c2Rl
diwgaSArIDMgKiBzYy0+bnVtX2NwdXMsDQo+ID4gKyAgICAgICAgICAgICAgICAgICAgICAgICAg
IHFkZXZfZ2V0X2dwaW9faW4oY3B1ZGV2LA0KPiBBUk1fQ1BVX1ZGSVEpKTsNCj4gDQo+IFlvdXIg
cGF0Y2ggd2FzIG1lcmdlZCBhcm91bmQgdGhlIHNhbWUgdGltZSBKaW5qaWUgYWRkZWQgTk1JIHN1
cHBvcnQgKHNlZQ0KPiBjb21taXQgYjM2YTMyZWFkMSAidGFyZ2V0L2FybTogQWRkIHN1cHBvcnQg
Zm9yIE5vbi1tYXNrYWJsZSBJbnRlcnJ1cHQiKS4NCj4gDQo+IFNob3VsZCB3ZSBhZGQgdGhlbSBu
b3c/DQo+IA0KDQpBZnRlciBJIHJlYWQgdGhpcyBjb21taXQsIGh0dHBzOi8vZ2l0aHViLmNvbS9x
ZW11L3FlbXUvY29tbWl0L2IzNmEzMmVhZCwgaXQgc2VlbXMgdGhhdCBpdCBpbXByb3ZlcyB0aGUg
aGFuZGxpbmcgb2YgQVJNX0NQVV9WSVJRIGFuZCBBUk1fQ1BVX1ZGSVEuDQpJIHRlc3RlZCB0aGUg
Y2hhbmdlcyBieSByZW1vdmluZyB0aGUgZm9sbG93aW5nIGxpbmVzIGFuZCB3b3JrZWQgZm9yIEFT
VDI3MDAuDQoNCnN5c2J1c19jb25uZWN0X2lycShnaWNidXNkZXYsIGkgKyAyICogbnJfYXB1X2Nw
dXMsDQogICAgICAgICAgICAgICAgICAgICAgICAgIHFkZXZfZ2V0X2dwaW9faW4oY3B1ZGV2LCBB
Uk1fQ1BVX1ZJUlEpKTsNCnN5c2J1c19jb25uZWN0X2lycShnaWNidXNkZXYsIGkgKyAzICogbnJf
YXB1X2NwdXMsDQogICAgICAgICAgICAgICAgICBxZGV2X2dldF9ncGlvX2luKGNwdWRldiwgQVJN
X0NQVV9WRklRKSk7DQoNCkFyZSB5b3Ugc3VnZ2VzdGluZyB0aGF0IHRoZXNlIGxpbmVzIHNob3Vs
ZCBiZSByZW1vdmVkPw0KDQpUaGFua3MtSmFtaW4NCg0KPiA+ICsgICAgfQ0KPiA+ICsNCj4gPiAr
ICAgIHJldHVybiB0cnVlOw0KPiA+ICt9DQo=

