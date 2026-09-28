Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9FEEFC9832F
	for <qemu-devel@archiver.kernel.org>; Mon, 28 Sep 2026 03:33:35 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xB277-00044F-Rr; Sun, 27 Sep 2026 23:33:14 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1)
 (envelope-from <prvs=724888370=Alistair.Francis@wdc.com>)
 id 1xB275-000433-An
 for qemu-devel@nongnu.org; Sun, 27 Sep 2026 23:33:11 -0400
Received: from esa2.hgst.iphmx.com ([68.232.143.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1)
 (envelope-from <prvs=724888370=Alistair.Francis@wdc.com>)
 id 1xB270-0005NF-UZ
 for qemu-devel@nongnu.org; Sun, 27 Sep 2026 23:33:11 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
 d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
 t=1790566386; x=1822102386;
 h=from:to:cc:subject:date:message-id:references:
 in-reply-to:content-id:content-transfer-encoding: mime-version;
 bh=tRwJiRE7DZAlfopfcPJg88RQv36m9b2ho0bnf2GUsTc=;
 b=NvFNPjjqoctPnGbS5HcLq61Qd0emRanpLsRGb+sOXPUwu6df8GR26YOS
 f8mOg9/P2leYui1+wSbQTbxeIEohMeO5J5qqWO1in6Bmu/Bf40bR8K9/x
 gyiob6TY08CB06uNS6YJW8DCeFf0nSUBvqlVRmd4uGzRrEAMmrIUrK7Fa
 ltRCoq7t3awG7zx26MbKZVUwQlNK3pjDFZoN4a3kzgRl8pVnGXMaYruVI
 90b2P/xIp55/SDQcgdxK+San7tlv9dBB8rbk/vyVNh5N8CjWPhe7LfJXC
 OMXYJ556nXTF2KbnGRe1zcSd5yCLzGBPScbrk08WgOODHu2w4ZdF5/kio w==;
X-CSE-ConnectionGUID: rbi6GpivSgalwNJTtdZArg==
X-CSE-MsgGUID: r19WBVwbRjynIktukJ/bRg==
X-IronPort-AV: E=Sophos;i="6.27,127,1786982400"; d="scan'208";a="157646961"
Received: from mail-northcentralusazon11013043.outbound.protection.outlook.com
 (HELO CH4PR04CU002.outbound.protection.outlook.com) ([40.107.201.43])
 by ob1.hgst.iphmx.com with ESMTP/TLS/ECDHE-RSA-AES128-GCM-SHA256;
 28 Sep 2026 11:33:03 +0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=xByizXKFtFnnHBBussOe0S4R9/8yvs5DMjcM3K/tz8CIxiO4sZdtLOPEEdHloh+WEWcMX4ripNs+xvM/x8cpAFzH9P27ySFp4Jg6+EqhcEaLCu7eE/W0gXyubm2f4FPTHSRASYmVp/pYzLywmGVyXaRxKuF2MfFiEbJb+3cbcIl7A0RvQd9iCG5DBoGG41pwz4FHUbxlt7yseG/mBy0bui4a+eDL9wlbaY/2BKfmmTnxkZLtEZq2vV59Me/1N1/OBM62LApfgVmbGuuZhhDR872J6qkXQ7zNF+uUSUvsJQ8xpYAix42jAA2DIqOfmeR/Fz4toW07gluXr97xNFchhw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=tRwJiRE7DZAlfopfcPJg88RQv36m9b2ho0bnf2GUsTc=;
 b=JxqhiNvYzRIXXyi1EgZ/I9mY/zyoWsWen2/vDAmj+Riq5oeGkJu2Ju1P4AiltLx38C3e3ccXb7kxDuOqjE71tKrHewgKBknGQJUHmJmPDj30CIBghqd7ZSFy2MLYXb6rN5H3fayxS6G/Tn8RskHuELHFI1VeuEPsdyZFaqXrlXaxRA+pq1PknLhWtXdpDHgYTLhRFsClpNybIzbK6ZS7adcvEDcCgsndhLeR0m3vqWvVPPOkkUp4CJW/sAvayjHl36o+6B9B1T2M310WFbacKtv5FNC162jnWUWV0/6lvUkbPr1vfgkow2oSxOHVzT1d2t7FH3jk23qLLWBqJEJ1ag==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=wdc.com; dmarc=pass action=none header.from=wdc.com; dkim=pass
 header.d=wdc.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=sharedspace.onmicrosoft.com; s=selector2-sharedspace-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=tRwJiRE7DZAlfopfcPJg88RQv36m9b2ho0bnf2GUsTc=;
 b=CrUOjaHh3jR7xZUn4IoPu4K+HrLPGr12XC+QAGic/lmFbH8cU2s1ZWs6RFXtVMwx1qan0Oc/l3GuOQPpP9JFNK64Q+NhdNw60XEGZ57EKMSRJmWM2qtC+etp45Urnxkx8fCRTKkG7DpnV4Xxwp8q96AAKQXrrvtSYjpV1q7BxVQ=
Received: from BY1PR04MB9561.namprd04.prod.outlook.com (2603:10b6:a03:5b6::11)
 by SA3PR04MB8715.namprd04.prod.outlook.com (2603:10b6:806:302::20)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.451.24; Mon, 28 Sep
 2026 03:33:00 +0000
Received: from BY1PR04MB9561.namprd04.prod.outlook.com
 ([fe80::3869:e494:2fa8:9888]) by BY1PR04MB9561.namprd04.prod.outlook.com
 ([fe80::3869:e494:2fa8:9888%6]) with mapi id 15.21.0451.022; Mon, 28 Sep 2026
 03:33:00 +0000
From: Alistair Francis <Alistair.Francis@wdc.com>
To: "richard.henderson@linaro.org" <richard.henderson@linaro.org>,
 "qemu-devel@nongnu.org" <qemu-devel@nongnu.org>
CC: "max.chou@sifive.com" <max.chou@sifive.com>, "palmer@dabbelt.com"
 <palmer@dabbelt.com>, "daniel.barboza@oss.qualcomm.com"
 <daniel.barboza@oss.qualcomm.com>, "philmd@oss.qualcomm.com"
 <philmd@oss.qualcomm.com>
Subject: Re: [PATCH v3 05/11] tcg/riscv64: Adjust sign of lui immediate in
 tcg_out_movi
Thread-Topic: [PATCH v3 05/11] tcg/riscv64: Adjust sign of lui immediate in
 tcg_out_movi
Thread-Index: AQHdQ90rkBeGCr7M1kqknoubl+VY+7bjbGOA
Date: Mon, 28 Sep 2026 03:33:00 +0000
Message-ID: <79943eb73ea148c07f7cf98cf14664a7d4211a73.camel@wdc.com>
References: <20260914000814.785155-1-richard.henderson@linaro.org>
 <20260914000814.785155-6-richard.henderson@linaro.org>
In-Reply-To: <20260914000814.785155-6-richard.henderson@linaro.org>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
user-agent: Evolution 3.62.0 (by Flathub.org) 
authentication-results: mx.microsoft.com 1; dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=wdc.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: BY1PR04MB9561:EE_|SA3PR04MB8715:EE_
x-ms-office365-filtering-correlation-id: d4211fd0-e2d9-43f0-3ca5-08df1d11324a
wdcipoutbound: EOP-TRUE
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
 ARA:13230040|19092799006|1800799024|23010399003|376014|10070799003|366016|10067099003|38070700021|56012099006|11063799006|4143699003|22082099003|18002099003;
x-microsoft-antispam-message-info: 6pnYJYm1witijujsnUhyWyxwgdFTb70l2yCLLMUxCd5ZDY9iwDEequ3IFMBOKnmaCjnXGtWB9P89VnoX+HGQkF7aPRexLZ+wEQ73Km4hMRiSeUwSu0arlAMQCl3XXg3wDM6lmS7Pwxwq5HmazDStfTFzEgqqy/nKjUWn3SQCBq+gx8HJU/j0Rr4tp5xiTxuqtcwwndbB8wZuspwtCNMHIlozPW3Jdo6xPV3EOofdIYLf3rK1z+gBdp+fyfXr5b4XRCe8wt44uNpRWWoIpTa/DuR8maUDvUWFotVLkeMODmRJcwfySAJ5Xy57cMgkijKTi2UKGScXk9OFLyroLDcwCujQg0am4VQumOahuCUSxadVImFbZizYg9rejIqYapgkcB8Cdu0he9jwyO0vNnTqbrvQIRwAayC2a/av3iTZP01Lxkv1b8B+tN5eBDKRzDfw5XnqrWoloOb83JiqYPrbCu/KrsFdYdETCeHkbKAJp8cbPloEHa5dIa/4nlMDi6DlWFPU+4BRM85tx9dmNYprSzwFRNeLzKTOmiR8OeUjItfQa/8OQpPGfRzfGxWzP2BF1Gotao8LK6xnvD7ZaM/hzazmzW2VZBOqmeufNqoD9BB8YzArnq61HjIpLbBddqOY1nzf4pIpRAvfkUTijDbluDTFbaoXW7UjFvmAWPjDzf0VpNJPiB4/4o5p4phwN8MtsZ8cVSV7LenLcNT0tD1DkJc5MfFTpbV6ic2rt3AMqVI=
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:BY1PR04MB9561.namprd04.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(19092799006)(1800799024)(23010399003)(376014)(10070799003)(366016)(10067099003)(38070700021)(56012099006)(11063799006)(4143699003)(22082099003)(18002099003);
 DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 2
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?TjFSZWxwWjFWTjdsTVBMWVRHdlpaZzViNVhGWm5iVkpDZHZDZm1jcDMxZHNi?=
 =?utf-8?B?bjZ2RGFMNC9vNEVBNmRHVjlVQmp3THJFd05pMzVNNXc5TlVzMWVXdGxUNmp0?=
 =?utf-8?B?MnJuOTB1QmRndCtLc2Raa1pDZ1EwOE1sb21Uc2ZGR00rM3hKWkNpT05QWS9o?=
 =?utf-8?B?VzlhdUkvemNwMHNHUE9KNk5vak1UL1QrLzZhN1dEb1NtM1JWV3hVYU1xak8v?=
 =?utf-8?B?VGpmaVQwdWduYzU5SHFqUVZMOHlnV2pXNEFob21NeFZVdXFrZEszblRIZWpq?=
 =?utf-8?B?UkdLcmhwaStSYWFnNlAvNG5zamN6ZUhaN3JNTGJjaCs0dmk2OHpETVc4MGxh?=
 =?utf-8?B?VXRSN1hEVEhLQVN5ZmphRDNGMzlQY08xL0xOeERrNFVmUFN4VHQ0OHY3dXhj?=
 =?utf-8?B?UmZwVnlvWXp5RGRIRkl6TG5EQjhyaXYxd3BKMXI2OVRTVWhzWHBIRDdtQ2NK?=
 =?utf-8?B?QkdWWjlTL2lnajZJYUFXTVFUZTcrOTZxdiswR2FiZGpzRDVyemFscmxSeXpt?=
 =?utf-8?B?TC9KdzkzcHB2Z2JQVXB5SFp5NnBjTVZxTXNyYkFhTkNnNkp6MjN6NndlRlpX?=
 =?utf-8?B?UnpCOVZLck5ob1Vob2QzQllXM1ozemkzTHlMeFMzRTAyM3FXOU9sS3pYVzVy?=
 =?utf-8?B?L01GOW1nek1NdE1BZGtQUTFVUVRseTAxM2U1SXowSENhcGtRRWZOeHpCMHZY?=
 =?utf-8?B?NFVMcExwV0dSOEZ4VmkwVGE0amxrTkFhMUJvRjNrMlJYU1REQjVmZmhneE1V?=
 =?utf-8?B?dVA2Q2d4K2d6RXdtUy9TWEIya1lhUDB1VHJpN2YxVkJjWW9SdFIxWUhPYTNv?=
 =?utf-8?B?N2JCWmd1VHB4V2o0QzJuR0gzNFlFZFYxM0VHZUxnKzFLeXp6M3F3TFF3SXFy?=
 =?utf-8?B?MDNsejhQelV2cU5jMzlYUGRBYnlkSGdtejdoREYwRDhZM2F5VzRQdi9UR3hk?=
 =?utf-8?B?VWZRNU9UbXQ5QTdpcHhkSUs1WGhMYnpwOE90cFErb1B3c3o4b2ZZVHhUblhR?=
 =?utf-8?B?S0IyUjVmV3N2ejJPWjhpSWsxUTllQXFIZGtkQVlKTi8rZ1VqVlIxZmpWS2dm?=
 =?utf-8?B?Uks5REN4S2pmSTUzRWp2L1RoZDVKUXVZN3BzN1pzR3dndzVET0dMMi9DbkV2?=
 =?utf-8?B?UGhKUWo4WnZ6ZS92ZjNBQ3R5T00yOWVsbThLWldFVDJabENaeTBjckwxVWhz?=
 =?utf-8?B?ZE4vczM4SnFxMlpyODdtMWU4a3V0RkJLbXZ5T2hxTnFNVGYrbFg2ZHdJT2Yv?=
 =?utf-8?B?WE1Na0gxaFd0OUNNNDJQRSszSG9jU01yZmNSOXZaWWVzT2l2dHlTNjZNOGpE?=
 =?utf-8?B?anlYZHhCM0NXRW5lTGNRb2RleVoyZnRZeHdsQjIzZ2hJZ1luelNLQXJ4Sjdp?=
 =?utf-8?B?NjFSZ1kvZzhuaXorTlRna3ZCYStOdVlTSHBiUldZTmNieDZqVDUyRVJwUCsv?=
 =?utf-8?B?SFBCdXIyL0NDSEhGemM5cUhtL0xTUUpRbFB1UmE5bEdDU2t5Qm0wbTNnRjN6?=
 =?utf-8?B?SEE1MUZ0MDZVcDY2NEx2azFrdXJRMUR2SzU3eFNMV1RyL1Q0UmlUQ2g1bGR2?=
 =?utf-8?B?aXFraGdWSWZoa3J6Z1FhQVdYUTR1RUNaK25TRzliSU1OdFhYcXNSWkc3WHZL?=
 =?utf-8?B?VytJazJZNDFhTmZNaGViTk9pOTJmWml6cWpSRHpJVE5HWkFsN1dYVWNySVRv?=
 =?utf-8?B?dzV2MWRhcVp2MmJPdEpZSzMxQ1lsN3ovWGNkaHgzV1o1VnozWE84bDlzL1lB?=
 =?utf-8?B?OEJxK250Tm5GenVZbTRMNWRjSGtGOEpZZk5BYzgzTXY1bVZMT0ZnMDBSVmVG?=
 =?utf-8?B?OStaY3hPRHptbHlWdCs1RVNpMXJvTDlEZForTm1heVp3MExCOHF2R09ZTmpk?=
 =?utf-8?B?WVV4blQ2aWtQQTc3QTNFc08vbEhsQXJlbG9EWHE1Y3R2Z0gvbWxqTGVWVlJU?=
 =?utf-8?B?UEJ0M094KzdUdis2OGExeXFHQ1hIM1hmbTVZbnYzZmZPVmhFYmxMdkVRQnpD?=
 =?utf-8?B?Q0gvL3Q3MURxNCtDRzJuek9TTTdNQTJJS3JEVmhFcUpLcWUyeHRQVWsyTXFk?=
 =?utf-8?B?b0M4Y25jM2RxN2hNRkk3YWZMZXRxMkM4TStzUGxwc2U2OUFudU5hQ3BnUVYv?=
 =?utf-8?B?dkhvUGI3bDk5cUhwdGJCd0VTcEJMU1dia2dRTHNtSndwY0FUUDFNS2lxalcv?=
 =?utf-8?B?UmRRbHRkK0oybFVHWk80ZituZGZ5eU5HQmtlWUNYbTlmTG5mNmxuN0ZFdWd4?=
 =?utf-8?B?VWtkS1RpM3B6b0YzMkxnZmlQU1ZQQlVPVkJMbVJsdlN5VERya3RtL1BHSm5Q?=
 =?utf-8?B?MHZCcHYvcGNGT2swSkc4eXV0bThZSnJwZG1IS0xabFk0UWpHUHh0MGZxMWVH?=
 =?utf-8?Q?2u/c7sFZ/FqU8Q57inoiy+8m2N2LYCsKCmH8zW/MOjxcU?=
x-ms-exchange-antispam-messagedata-1: AJVwQu0pn5qZlj/8ut3xjwsvU53DlLAOYsU=
Content-Type: text/plain; charset="utf-8"
Content-ID: <B93D2010316B234FB03D7FCCB34F5AA0@namprd04.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-Exchange-RoutingPolicyChecked: iEi+yOQQ3JRwoczIEavAuHTA4s9e5qJyecEEM5oxVbZu5y8T5G/nzybL5SIYFMDaEGfuqm1DzJBrELAtZlJB8ezckpKwyzCxZAcefFYM1vakHopvsapt4TPF4REWKfypSJbM1yPSk5bX1G+XiJArXGNVYiHWgehZntaAZbJpicy5InFbHGGrtrAODcuTB1F375ORErOGt2+/6zVF//30zJLkSTh5ZHKRcY4/DihjJHjD4XZh2QWhFJQZM+ZGen6OIHiS/5VXO0fZxIxZoz+HjdMv2FUE2JU+haBpQ+l0FSqAiqTBA+f7qiz+iaoRAeOPJklghqJgnLOujDOxrFAnrg==
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: IQexGcS2db++mzsBHxUr/dX9yE6QxxxAk2BFAxLbRHAePTRkXTb3/VBm8NZkQLThKyZxczSkKZ0FJo9sVBerH6O2GvJ5NzVdVjMQWwo6tNeifyLLeSEqM1OlJiXnYOgRnxG/OzWLLCUypxxpnYGmxp+b7V0be3HxkT2ZEq35fCkrtS/cgR/MzjaLfHNA1BBQkTcsP7Iw5oc6jt4IX7F6+blL+8A62t59k57Pafm8A95zloGfhGFLzKSq+E6aDzzlSp0d1sQ8hjxLPw/phjTzQSUo3NSrsn8CYCfpgM3jX2bcaEthxBb35ZnvPOj66l690LGdUyANhpeEgRuat8W4SXRtd3gUSfrQ3IWiyUqDr+11D6KwuJIM1OkaskIjuNZsk6n04V6/ZjivNzTDJPfT37Iqkuz46OJz2gS7EITp/HBaY7rsFO3VzFkPW2LDzJunCPVh1ABaXYIB0ma0cKmGcf3tuCF8R97Ly7Q1T2eCbBcigLiC8It0IsYoqOQi6nHo96UC1UeEanC7mwEXH8xF6UHByjeIGL+iuvkFExXf7p3FZe5NeM/AxQ+s0lzM6SsbQtqyBLeUVGFJFZMpoMTClU5bk6vXBU6c6LFb+uS3WAf8Y5jrzTQVs0DA8sVagPj/
X-OriginatorOrg: wdc.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: BY1PR04MB9561.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: d4211fd0-e2d9-43f0-3ca5-08df1d11324a
X-MS-Exchange-CrossTenant-originalarrivaltime: 28 Sep 2026 03:33:00.5199 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: b61c8803-16f3-4c35-9b17-6f65f441df86
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: dR73Os/RLKfkMUsvYA2oR40fmSu4L2m6aMKhIuTW7OTp4ZcMZE00luYaQE14HYqBVk6595p+ZAHPv23AcS1gyYitEabTfNPDx76ilP2HJts=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA3PR04MB8715
Received-SPF: pass client-ip=68.232.143.124;
 envelope-from=prvs=724888370=Alistair.Francis@wdc.com;
 helo=esa2.hgst.iphmx.com
X-Spam_score_int: -27
X-Spam_score: -2.8
X-Spam_bar: --
X-Spam_report: (-2.8 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_LOW=-0.7, SPF_HELO_PASS=-0.001,
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

T24gU3VuLCAyMDI2LTA5LTEzIGF0IDE0OjA4IC0xMDAwLCBSaWNoYXJkIEhlbmRlcnNvbiB3cm90
ZToNCj4gTm8gcmVhbCBidWcgZml4IGhlcmUsIGFzIHdlJ3ZlIGFscmVhZHkgc2hvd24gdGhlIGZ1
bGwgdmFsdWUNCj4gZml0cyBpbiBpbnQzMl90LCBidXQgc2ltcGxlIHN1YnRyYWN0aW9uIGluIHRj
Z190YXJnZXRfbG9uZw0KPiBtYXkgcHJvZHVjZSBhIHBvc2l0aXZlIG91dC1vZi1yYW5nZSBpbnRl
cm1lZGlhdGUuDQo+IA0KPiBTaWduZWQtb2ZmLWJ5OiBSaWNoYXJkIEhlbmRlcnNvbiA8cmljaGFy
ZC5oZW5kZXJzb25AbGluYXJvLm9yZz4NCg0KUmV2aWV3ZWQtYnk6IEFsaXN0YWlyIEZyYW5jaXMg
PGFsaXN0YWlyLmZyYW5jaXNAd2RjLmNvbT4NCg0KQWxpc3RhaXINCg0KPiAtLS0NCj4gwqB0Y2cv
cmlzY3Y2NC90Y2ctdGFyZ2V0LmMuaW5jIHwgNyArKysrLS0tDQo+IMKgMSBmaWxlIGNoYW5nZWQs
IDQgaW5zZXJ0aW9ucygrKSwgMyBkZWxldGlvbnMoLSkNCj4gDQo+IGRpZmYgLS1naXQgYS90Y2cv
cmlzY3Y2NC90Y2ctdGFyZ2V0LmMuaW5jIGIvdGNnL3Jpc2N2NjQvdGNnLQ0KPiB0YXJnZXQuYy5p
bmMNCj4gaW5kZXggOTliYzY1OGMyNjQuLmQwYzlkOGU5Y2QyIDEwMDY0NA0KPiAtLS0gYS90Y2cv
cmlzY3Y2NC90Y2ctdGFyZ2V0LmMuaW5jDQo+ICsrKyBiL3RjZy9yaXNjdjY0L3RjZy10YXJnZXQu
Yy5pbmMNCj4gQEAgLTc5MiwyMSArNzkyLDIyIEBAIHN0YXRpYyBib29sIHRjZ19vdXRfbW92KFRD
R0NvbnRleHQgKnMsIFRDR1R5cGUNCj4gdHlwZSwgVENHUmVnIHJldCwgVENHUmVnIGFyZykNCj4g
wqBzdGF0aWMgdm9pZCB0Y2dfb3V0X21vdmkoVENHQ29udGV4dCAqcywgVENHVHlwZSB0eXBlLCBU
Q0dSZWcgcmQsDQo+IMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKg
wqDCoMKgIHRjZ190YXJnZXRfbG9uZyB2YWwpDQo+IMKgew0KPiAtwqDCoMKgIHRjZ190YXJnZXRf
bG9uZyBsbywgaGksIHRtcDsNCj4gK8KgwqDCoCB0Y2dfdGFyZ2V0X2xvbmcgdG1wOw0KPiArwqDC
oMKgIGludDMyX3QgbG8sIGhpOw0KPiDCoMKgwqDCoCBpbnQgc2hpZnQsIHJldDsNCj4gwqANCj4g
wqDCoMKgwqAgaWYgKHR5cGUgPT0gVENHX1RZUEVfSTMyKSB7DQo+IMKgwqDCoMKgwqDCoMKgwqAg
dmFsID0gKGludDMyX3QpdmFsOw0KPiDCoMKgwqDCoCB9DQo+IMKgDQo+IC3CoMKgwqAgbG8gPSBz
ZXh0cmVnKHZhbCwgMCwgMTIpOw0KPiArwqDCoMKgIGxvID0gc2V4dHJhY3QzMih2YWwsIDAsIDEy
KTsNCj4gwqDCoMKgwqAgaWYgKHZhbCA9PSBsbykgew0KPiDCoMKgwqDCoMKgwqDCoMKgIHRjZ19v
dXRfb3BjX2ltbShzLCBPUENfQURESSwgcmQsIFRDR19SRUdfWkVSTywgbG8pOw0KPiDCoMKgwqDC
oMKgwqDCoMKgIHJldHVybjsNCj4gwqDCoMKgwqAgfQ0KPiDCoA0KPiAtwqDCoMKgIGhpID0gdmFs
IC0gbG87DQo+IMKgwqDCoMKgIGlmICh2YWwgPT0gKGludDMyX3QpdmFsKSB7DQo+ICvCoMKgwqDC
oMKgwqDCoCBoaSA9IHZhbCAtIGxvOw0KPiDCoMKgwqDCoMKgwqDCoMKgIHRjZ19vdXRfb3BjX3Vw
cGVyKHMsIE9QQ19MVUksIHJkLCBoaSk7DQo+IMKgwqDCoMKgwqDCoMKgwqAgaWYgKGxvICE9IDAp
IHsNCj4gwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgIHRjZ19vdXRfb3BjX2ltbShzLCBPUENfQURE
SVcsIHJkLCByZCwgbG8pOw0K

