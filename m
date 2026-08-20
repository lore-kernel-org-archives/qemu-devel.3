Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 13706C5DF85
	for <qemu-devel@archiver.kernel.org>; Thu, 20 Aug 2026 04:59:29 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wwuro-0003mM-7x; Thu, 20 Aug 2026 00:59:04 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1)
 (envelope-from <prvs=685c7dad1=Alistair.Francis@wdc.com>)
 id 1wwurn-0003m7-4T; Thu, 20 Aug 2026 00:59:03 -0400
Received: from esa4.hgst.iphmx.com ([216.71.154.42])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1)
 (envelope-from <prvs=685c7dad1=Alistair.Francis@wdc.com>)
 id 1wwurk-0005MQ-JG; Thu, 20 Aug 2026 00:59:02 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
 d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
 t=1787201940; x=1818737940;
 h=from:to:cc:subject:date:message-id:references:
 in-reply-to:content-id:content-transfer-encoding: mime-version;
 bh=FE0D3+aFfmVFd0rIxsD/e/c6mJf8vaNkznYuKVeGFJY=;
 b=XEeCgdrBezBpbeaBJaqr9cASvAx9+ircUEvGJeBELV+mW/t71F77VBrs
 Pn244WUwBjj1bffMmavuhvl0ylCFTqdeYvflk2sStLagvMk8gjQThvTzB
 O1psUhcMrJZBHlgoWTmFmH47MFRTAeIxoG/ug1mhX/ZQC4p3RN7q05jc5
 xBCKfBunhItJ5dJ83FR91kZVrKHP5/YqFI9bniZQxkbYWqkBJ+OssjTIN
 2eXmtfY1kmlJPkiPMu7lB6KpkFEOjpBdivdMV8OGLymrujN0D2HH+UkpK
 sr2MZtIu2KjRHHGByAK3GvWFzUWgzpcoUbqRJRDDG1ipYY/eZ4CZrhpuj g==;
X-CSE-ConnectionGUID: wsFWjV+eTm6UcvsagzfwYw==
X-CSE-MsgGUID: 3rWF5sJ1Qg+6mBQI9LOnuA==
X-IronPort-AV: E=Sophos;i="6.25,232,1779120000"; d="scan'208";a="149706545"
Received: from mail-eastusazon11011039.outbound.protection.outlook.com (HELO
 BL2PR02CU003.outbound.protection.outlook.com) ([52.101.52.39])
 by ob1.hgst.iphmx.com with ESMTP/TLS/ECDHE-RSA-AES128-GCM-SHA256;
 20 Aug 2026 12:58:56 +0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=fiLbt6qBxz+p0a9KZEhP9N3PcCoRHFdwej8LUjUkH7ayDHAI3SCRbG9gZmRuvE5zc5xjHG5FhYEvkPGIeNp3V0pleVXBTnoFyrlQ5sQWU6+83Y/EqWQgUP7zUNtE62DfLgqRsQDvbH02C1kWUX5mdGxC6vEFQLGnwcRLWCnCB1+beeL+ZlwSVrEa6Om4UX+904juGC0FMFHmDafIJ5FSaOOHFkB1a2nJ8k/8x+RvovBO8PWwRx6fuPUdX/49JreAi9GFquvEtEzSbeIfR2FOkJSuC069mHHlKmezMTC0rJeLvFqxKHU31/V1mzZoGzoqg1GG4sb5+4rD4DrpMrgKiQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=FE0D3+aFfmVFd0rIxsD/e/c6mJf8vaNkznYuKVeGFJY=;
 b=M+FXN40QREbf2NghAfqThwG5d8nxHCWXXb2S4de3hReu+cp2pQvmJqebOythqPemaKVk4iQwuKUGA63iOC+/8LiTCEL2CNQ1qwnF/FknASzKJjfhr45dpZqmG0mR/c/ZFAPUOjEq1hlypHQsh+DnLAH+qXhz2+WK3q0QzdwnUVQPwrmZi0Wj4F/vncUsdvN/12MHmouYbmf9uehxihB4AOLB2yJYp6lygvLZsG2ws924ZUQVMY519jI5O0XO5MVZSCsYafbpcu8F9LOFDObCc5x9200f1qX5cNGhPkptPc0odRfpsRmrCi/hx4aI3YZuJXbJFV+LouaZ9n6lBpB1xA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=wdc.com; dmarc=pass action=none header.from=wdc.com; dkim=pass
 header.d=wdc.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=sharedspace.onmicrosoft.com; s=selector2-sharedspace-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=FE0D3+aFfmVFd0rIxsD/e/c6mJf8vaNkznYuKVeGFJY=;
 b=mrNQs/qvSQYufhl43U4LY2mfhB2ma3i2a98WC5k3wJj6sCNNDYTyt3Xo3x21zObE8/E3dOQqAiNpPOUHpK36GdoyNnQLob8RkH0bTDIqpYK7+Ofpu7l8dT3SmoFhRh1euecSGjcySMrUTp/gaNr/PDiuneYEBw5mGTd435t3Rfs=
Received: from BY1PR04MB9561.namprd04.prod.outlook.com (2603:10b6:a03:5b6::11)
 by BL3PR04MB8026.namprd04.prod.outlook.com (2603:10b6:208:345::17)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.339.8; Thu, 20 Aug
 2026 04:58:55 +0000
Received: from BY1PR04MB9561.namprd04.prod.outlook.com
 ([fe80::3869:e494:2fa8:9888]) by BY1PR04MB9561.namprd04.prod.outlook.com
 ([fe80::3869:e494:2fa8:9888%5]) with mapi id 15.21.0339.007; Thu, 20 Aug 2026
 04:58:54 +0000
From: Alistair Francis <Alistair.Francis@wdc.com>
To: "vvisaev@gmail.com" <vvisaev@gmail.com>, "qemu-devel@nongnu.org"
 <qemu-devel@nongnu.org>
CC: "joel@jms.id.au" <joel@jms.id.au>, "npiggin@gmail.com"
 <npiggin@gmail.com>, "daniel.barboza@oss.qualcomm.com"
 <daniel.barboza@oss.qualcomm.com>, "qemu-riscv@nongnu.org"
 <qemu-riscv@nongnu.org>, "palmer@dabbelt.com" <palmer@dabbelt.com>,
 "zhiwei_liu@linux.alibaba.com" <zhiwei_liu@linux.alibaba.com>,
 "chao.liu@processmission.com" <chao.liu@processmission.com>,
 "liwei1518@gmail.com" <liwei1518@gmail.com>
Subject: Re: [PATCH v2 2/2] tests/tcg/riscv64: add misa write test
Thread-Topic: [PATCH v2 2/2] tests/tcg/riscv64: add misa write test
Thread-Index: AQHdLlofuquP2NT0zkuYB4jcpa4xqbamZH2A
Date: Thu, 20 Aug 2026 04:58:54 +0000
Message-ID: <776fdf8e68f7c4eda1c97ea339a6e446bc9677b0.camel@wdc.com>
References: <20260817150653.40357-1-vvisaev@gmail.com>
 <20260817150653.40357-3-vvisaev@gmail.com>
In-Reply-To: <20260817150653.40357-3-vvisaev@gmail.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
user-agent: Evolution 3.60.2 (by Flathub.org) 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=wdc.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: BY1PR04MB9561:EE_|BL3PR04MB8026:EE_
x-ms-office365-filtering-correlation-id: 2db47fcf-1494-4c74-0d81-08defe77bc6f
wdcipoutbound: EOP-TRUE
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
 ARA:13230040|1800799024|7416014|10070799003|366016|376014|19092799006|23010399003|22082099003|18002099003|56012099006|3023799007|38070700021|6133799003|4143699003|11063799006|10067099003;
x-microsoft-antispam-message-info: clQdGln+fi1TjaAgzZ5CgOGopq4HQXBY11W+VB2DyB6L4kpSbLc+LohJYvXTB5B0iEM114Qlnd3EmMRGKFSwUAKsmM7BhvzNAnnVS2kD976qfZsMn3lneLpAs0H3TUOQ6f+IoeKZXR1FmDmWRZ/J8pLucaovGR6zqgJ+bfjjcHSZi4spQ4kPM4jRY9UKKu1kHOxbQdqmQ8fazB1I+0P1YTPQZqdjG5xnfSeY8Pfs91R7Y1ztYhpTjRa1PiRZumOXK8pLZLi2PQ+UjiSVf4sPpUOxcl+/0EA1J5YJplmLK6KgL2MfnB9DHVsT/x8MDYQJweAnCRaQUAS3q/vh4VFxnb7q0iCRRP3godw6tHs8r1TFOBkSOHbQw+QOP6D+N/mfMKtTwufdl/yiqiMH3RFha2IACAynKsKErmZinRet/PhO+P9oShvYlLhGeXlNs0+2h6M9VeLrdE2Z6EtT/GGUEowmcsEDsUvjCjXjvojCNXdrVXBLnYPVvMhDnWICNDUJ3ZrgwaX90N1bG+pOrG+hSEIhSDUg4MiXurmr3d6a8AmY40GY2hzvnRFefa6uyabu6qm1v544MB3crrSwNfIhX1eqjzeLsUnBxKcGz+qZspyhZp0NHfdaKzyFA1yF8R4T+X467BoR56IyaSiQuvNuEcUU8AVIBLNZSkmd2325UowpwkZGwo6yxEG5CKTfkDenMDA7FiTK6+s5IVGyXyd9aA1ZV2AEyr39pp258ahDJsU=
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:BY1PR04MB9561.namprd04.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(1800799024)(7416014)(10070799003)(366016)(376014)(19092799006)(23010399003)(22082099003)(18002099003)(56012099006)(3023799007)(38070700021)(6133799003)(4143699003)(11063799006)(10067099003);
 DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 2
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?QkZ2Qkg3R3dITU5qZGFUYzNvcTlTdjUzUmN4b0EvSThmbFpwOElzMGZobU41?=
 =?utf-8?B?NVhhTVVxN3ROUCs0d053U0tDRGdVSlgzc0RpSkQ0VW9ZTXQwWE54VEJERDhk?=
 =?utf-8?B?aVhaM3hqQVlIb1lrQStlSHNvTjB1T0ZsUDZlNHdRbWFRb2xPMzQxYTRlVG9X?=
 =?utf-8?B?eXNFVTNqNDcvYUVNZEozRUIxQ3lwQktRckVSWWRNTkl4SmtnQnVuSUEySE1G?=
 =?utf-8?B?M2JObWo3QmcxMDIxNGJXV1dRSHk5MWlERWVlT2dPV3ZDTjdFZTZrYUhYaHhH?=
 =?utf-8?B?THBDWVB2ckIySlpVZ3MxUW4zZVlISUtRdm0wNnVVUkpIWWhwd2VlRjFBeDhj?=
 =?utf-8?B?VkQ2Q3hHSUV2eC9qMFQ5eEVJa3VXeUhIMmxKSVJMS2gvYmN0UXArSXliY0hK?=
 =?utf-8?B?OHNoaFJIcW8xcVA2ZlNpTDdJNGpScjFIODd1bHRnRlk1Vnc1WlE2K29LT3RF?=
 =?utf-8?B?Mk9lRGRONHdydTl0MkRaa2gxUzZnUVRHRC9kTnlEajdmekhyeUdVRkU0dXJh?=
 =?utf-8?B?SzlucWdVajRUL0NrMlhkZU10RVZKR3BhYkVMNU1aS1YvWlZicFVRdGN2Wktw?=
 =?utf-8?B?REZPeVIyRW02N2ZjdkhpR3AvclBjZmdpSkhQZVdVK0hjL0NTTkFBRXk4VXpB?=
 =?utf-8?B?VlVhKzdMcFNUd2srcEVHR2ZzeGhjdW9hZVhpMjZvMEN1VXhoSG13U25jcWZ0?=
 =?utf-8?B?R3IrK29PdmVjSDdMbFV4WG1rd1hvUWlOazNNbzNDTU85NW9rRzZ5Q0M2RHNH?=
 =?utf-8?B?bUdjWHVITVAzVi9Sa0FCcGZCVTNXc2tkVkIzRmF3b0JQQ1U2Y1JycTZ0dDFu?=
 =?utf-8?B?K0g4SWxicjZvbG1uRHF0cSt0Q3NucXJQRkorRi9pWHAreDNJZFppZ05HdE15?=
 =?utf-8?B?dzBTZW9rL2l3MEh1akJlOTBCTnF3U05nMTBoL2dCTlhVZ1hhR2YxNjZyUEdP?=
 =?utf-8?B?dFhQUVczMGJSQTY0cFhpY1d0ZjEyR1lHRXVPZ3lZcm91WHZ5NnR4YllGa2Nt?=
 =?utf-8?B?RXVnR1pydkJnVE1HYjJReWZ3WXUrYmJ4ek9LczcwN09MZmFYQ2pWOWVleUxM?=
 =?utf-8?B?NWV5YWVlbXc1UDZxbGhOLzczbjZXUjFyRDN5SGppVnVQV1JFYUVoTld2RmtJ?=
 =?utf-8?B?SGhvemV4YnMxSjJBMWMyTnBZNUNaOTFiODkwVSt3aEkrN2VXeEwzK29KWWZt?=
 =?utf-8?B?SjdpWGN1TnRFV2UxTDdnR1NXZDd5cTB4dEtPejRjQy94VFlscW9LOFVYNkQy?=
 =?utf-8?B?R2IySzlSSk5kNFZrUURROUJ3amZMMUFhSmUzVjBUQnNTQ2NZYUFQK0tLT0da?=
 =?utf-8?B?ZnkzeUVWTy9xdG5ObG10Z1YxZ0Iza1dHcm1FeUZGWEcyNXBOdXBIVTVrWHFI?=
 =?utf-8?B?WC9MVFh0dkhnR3F0aVUxOVZTcjJ6a1Q0eUVmc3V1NW9mZmdRN1BvTDFkaFcx?=
 =?utf-8?B?YktDTGR0eFJMRzJIZzgvdjE5bmdtaGprSkFLa1g0OGhNVUdkUjNSZkpnc2Uz?=
 =?utf-8?B?M09jZUJhZ1l0NHBDanRwdHgwZ0h6dVNmck1Pa0JFeXoxanphbjN1S01tUXdj?=
 =?utf-8?B?cXVhQnNpZWQvOGVuUlJoWWRWTm5rekxnTUh6dFd3YURPREtreTg4aGNJSmxa?=
 =?utf-8?B?bnp4VCtFdW94Uy93Si9NOVY4VXdrZ1BUOVhqWlBUOFdnSWxXMjR1S0RIYi9S?=
 =?utf-8?B?QU5wQ2ZON211Y0xxdklvOG1FaERETDcvRnlJMnoxSmtKaUlCUktyeVdyc3Fu?=
 =?utf-8?B?eWprWWk2ejZheDNMdUhwaGZMTjU1bFBkQ2xTR1FMdnE2UDJEd0JUaDcxem10?=
 =?utf-8?B?dnZWRkFYRUxmUm5sY3RwekxQZWZSSXVwZUhxeDNiVE5hdmJHcXRDTkx6Qmsr?=
 =?utf-8?B?RVVEaDJtaUtIV3pMWThLd1hMMEloN1dwTWdlVms0VHBoUERKaENsNWVxY0xj?=
 =?utf-8?B?dTFQL0RZNW1Lb1NXWXZkUms1NUIvYWVFakJRWHg3RVlDd3lHTFR5b2JHRnkv?=
 =?utf-8?B?ckQ5VlhUb0Uvak45RXpIVnNrU2dMdytpZ2ZtcmpmSWVZN05Ib1BZKzhyRzVy?=
 =?utf-8?B?dXVrand1cEVZWWZkRHV6TzFDVFUrWGVINjZrTmxxdUZlWktZUGRmNm1hV3lO?=
 =?utf-8?B?ak44eVBBTnorWmdBZWhKR1ZXNG15MzNWSlp4VVg0ckNDNzBWT3Q5V1htYk94?=
 =?utf-8?B?ZU1PTHZVRnNSSEpYeXp5ZVNYSzNITk9vNitYelB0cmRqajVvMmc2UWYrWmtt?=
 =?utf-8?B?NjQrYmo1V0VMVDB1cERrZHdWQm1scjhNejk5V09IdEk5K2g1SkZwekVPTXlp?=
 =?utf-8?B?NHBiWWZRTVpGWGJEZ2kvd3JOUzE2VFh3VFMwRUJRVDFzb013ZGNJdm9uUDc5?=
 =?utf-8?Q?rAS2R6yGGs5uOza10/w+8L9iGy9HhzTtcExJbVNoTvLhG?=
x-ms-exchange-antispam-messagedata-1: JADa4+CYU0URd9AomFXjRR36KJXjYgX05w0=
Content-Type: text/plain; charset="utf-8"
Content-ID: <A90711568F291146A55A2F786C492690@namprd04.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-Exchange-RoutingPolicyChecked: kxZmtRT4nlC6zIXSUM7VB+J3NLO0QYYvSCTlVyL8DTm7ryjtPl5lC3qH3mpLousCJGvMNKDGC9T3XV/139LrltoVKqqEMxkneJ2GdMSKUvvDJCePezyQU9GDzjK0j1teLztWH9xnY/VdYikV+o3c+RKSS/Gs6wIoi3DAIuqc6fAzkZfMaFmBhHWKneyHFndYl5lIlUA7cWaZ5aRynetvorZ6pyVbAkSGbBbI5zIu8jPDm7yLzNTJATaTLMRW3hK1bJCbamE0Znd8aR7sErsTtsm619OaXj8VnyuYDYiQ11RlcA2nVk49ViGGL2bQ/3VPRrqwCS5nCNNWh7XH6MOJoQ==
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: buWrRrgUAFN1nTw2vf/Y04Aq3QPHIIvuyeRT1mh1AS8azHuhWys+txMopXBKb3xA3JiwTD/YCT1PnWqCtF4dqrCUlgqsBkpIkvSEIf79NVubnfsgK91s8vlW8JPa5D29YXgj/U6MklDms+lB39cfAwJLm7hq7vmnkd/ZUuxZDaqzI7Ck74hl5DhjB08I2dapNu43mVZ3wuDzNFzV1woihnaogHZEeHDEzt/j4ZuFREB7PTVL2JYZgxtxg1F+qqB+c8cm8eqXnRRq43QsMU8f9egYzHtHW6PxESHsAZpMJQA9mvDyhJBDQfjzN3T0OSSZWcPLecucw1pPptdqKsSaIryJcv4la0b+OGCsZ0o8t5Vv9/z/HmkzYps0tNAhFyAmJ6w1jusmnpFMb8/jif4uefB7q+IAkcvEIFxMKGxIIPRele/bn9fmPs+F+9fnsOyVtUvQZtPOdKIT7f6qudWXKbGJ4Tm7jqAk1VFRaAKMat1UPDCyOvb3wBy+EWzfPBrjL89V2P11ZP/XbuqOcTV7BsVWqZGEIh2s7tker7ygQDqx/4l13YQfOsWJvdj78Qgx3JR2DKmGmdV4tWjtXKqsBWP72n3TDabSUlCvzNTAepJ3OXe9SyCGx74Cyn/5KW6x
X-OriginatorOrg: wdc.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: BY1PR04MB9561.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 2db47fcf-1494-4c74-0d81-08defe77bc6f
X-MS-Exchange-CrossTenant-originalarrivaltime: 20 Aug 2026 04:58:54.8933 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: b61c8803-16f3-4c35-9b17-6f65f441df86
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: vlaIWO6Y57s5K5bRng62gDmDN/jTb9xzdlKl13q5kKgJZj9wgCrrQduJ9E6VnUjt0SHRewwEaCsvN10JCE838PlWLTfQbc1IeGwQwCCJRSc=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BL3PR04MB8026
Received-SPF: pass client-ip=216.71.154.42;
 envelope-from=prvs=685c7dad1=Alistair.Francis@wdc.com;
 helo=esa4.hgst.iphmx.com
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

T24gTW9uLCAyMDI2LTA4LTE3IGF0IDE4OjA2ICswMzAwLCBWbGFkaW1pciBJc2FldiB3cm90ZToN
Cj4gTGluazoNCj4gaHR0cHM6Ly9sb3JlLmtlcm5lbC5vcmcvci8yMDI2MDMyMTE0NDU1NC42MDY0
MTctMi1ucGlnZ2luQGdtYWlsLmNvbQ0KPiBTdWdnZXN0ZWQtYnk6IE5pY2hvbGFzIFBpZ2dpbiA8
bnBpZ2dpbkBnbWFpbC5jb20+DQo+IFNpZ25lZC1vZmYtYnk6IFZsYWRpbWlyIElzYWV2IDx2dmlz
YWV2QGdtYWlsLmNvbT4NCg0KUmV2aWV3ZWQtYnk6IEFsaXN0YWlyIEZyYW5jaXMgPGFsaXN0YWly
LmZyYW5jaXNAd2RjLmNvbT4NCg0KQWxpc3RhaXINCg0KPiAtLS0NCj4gwqB0ZXN0cy90Y2cvcmlz
Y3Y2NC9NYWtlZmlsZS5zb2Z0bW11LXRhcmdldCB8wqAgNCArKw0KPiDCoHRlc3RzL3RjZy9yaXNj
djY0L3Rlc3QtbWlzYS13LlPCoMKgwqDCoMKgwqDCoMKgwqDCoCB8IDg4DQo+ICsrKysrKysrKysr
KysrKysrKysrKysrDQo+IMKgMiBmaWxlcyBjaGFuZ2VkLCA5MiBpbnNlcnRpb25zKCspDQo+IMKg
Y3JlYXRlIG1vZGUgMTAwNjQ0IHRlc3RzL3RjZy9yaXNjdjY0L3Rlc3QtbWlzYS13LlMNCj4gDQo+
IGRpZmYgLS1naXQgYS90ZXN0cy90Y2cvcmlzY3Y2NC9NYWtlZmlsZS5zb2Z0bW11LXRhcmdldA0K
PiBiL3Rlc3RzL3RjZy9yaXNjdjY0L01ha2VmaWxlLnNvZnRtbXUtdGFyZ2V0DQo+IGluZGV4IDgy
YmU4YTJjOTEuLjJjN2YwMDk3NmMgMTAwNjQ0DQo+IC0tLSBhL3Rlc3RzL3RjZy9yaXNjdjY0L01h
a2VmaWxlLnNvZnRtbXUtdGFyZ2V0DQo+ICsrKyBiL3Rlc3RzL3RjZy9yaXNjdjY0L01ha2VmaWxl
LnNvZnRtbXUtdGFyZ2V0DQo+IEBAIC00MSw1ICs0MSw5IEBAIGNvbW1hOj0gLA0KPiDCoHJ1bi10
ZXN0LWNyYzMyOiB0ZXN0LWNyYzMyDQo+IMKgCSQoY2FsbCBydW4tdGVzdCwgJDwsICQoUUVNVSkg
LWNwdSBydjY0JChjb21tYSl4bHJicj10cnVlDQo+ICQoUUVNVV9PUFRTKSQ8KQ0KPiDCoA0KPiAr
RVhUUkFfUlVOUyArPSBydW4tdGVzdC1taXNhLXcNCj4gK3J1bi10ZXN0LW1pc2EtdzogdGVzdC1t
aXNhLXcNCj4gKwkkKGNhbGwgcnVuLXRlc3QsICQ8LCAkKFFFTVUpIC1jcHUgcnY2NCQoY29tbWEp
eC1taXNhLQ0KPiB3PXRydWUkKGNvbW1hKWM9dHJ1ZSQoY29tbWEpdj10cnVlICQoUUVNVV9PUFRT
KSQ8KQ0KPiArDQo+IMKgIyBXZSBkb24ndCBjdXJyZW50bHkgc3VwcG9ydCB0aGUgbXVsdGlhcmNo
IHN5c3RlbSB0ZXN0cw0KPiDCoHVuZGVmaW5lIE1VTFRJQVJDSF9URVNUUw0KPiBkaWZmIC0tZ2l0
IGEvdGVzdHMvdGNnL3Jpc2N2NjQvdGVzdC1taXNhLXcuUw0KPiBiL3Rlc3RzL3RjZy9yaXNjdjY0
L3Rlc3QtbWlzYS13LlMNCj4gbmV3IGZpbGUgbW9kZSAxMDA2NDQNCj4gaW5kZXggMDAwMDAwMDAw
MC4uN2YxZWIzMDAyMw0KPiAtLS0gL2Rldi9udWxsDQo+ICsrKyBiL3Rlc3RzL3RjZy9yaXNjdjY0
L3Rlc3QtbWlzYS13LlMNCj4gQEAgLTAsMCArMSw4OCBAQA0KPiArLyoNCj4gKyAqIFRlc3QgZm9y
IE1JU0EgY2hhbmdpbmcgQyBhbmQgcmVsYXRlZCBJQUxJR04gYWxpZ25tZW50IGNhc2VzDQo+ICsg
Kg0KPiArICogVGhpcyB0ZXN0IHZlcmlmaWVzIHRoYXQgdGhlICJDIiBleHRlbnNpb24gY2FuIGJl
IGNsZWFyZWQgYW5kIHNldA0KPiBpbiBNSVNBLA0KPiArICogdGhhdCBhIGJyYW5jaCB0byAyLWJ5
dGUgYWxpZ25lZCBpbnN0cnVjdGlvbnMgY2FuIGJlIGV4ZWN1dGVkIHdoZW4NCj4gIkMiIGlzDQo+
ICsgKiBlbmFibGVkLCBhbmQgdGhhdCBhIHdyaXRlIHRvIE1JU0Egd2hpY2ggd291bGQgaW5jcmVh
c2UgSUFMSUdOIGFuZA0KPiBjYXVzZQ0KPiArICogdGhlIG5leHQgaW5zdHJ1Y3Rpb24gdG8gYmUg
dW5hbGlnbmVkIGlzIGlnbm9yZWQuDQo+ICsgKg0KPiArICogU1BEWC1MaWNlbnNlLUlkZW50aWZp
ZXI6IEdQTC0yLjAtb3ItbGF0ZXINCj4gKyAqLw0KPiArDQo+ICsjZGVmaW5lIFJWQyAoMSA8PCAo
J0MnLSdBJykpDQo+ICsjZGVmaW5lIFJWViAoMSA8PCAoJ1YnLSdBJykpDQo+ICsNCj4gKy5vcHRp
b24gbm9ydmMNCj4gKwkudGV4dA0KPiArCS5nbG9iYWwgX3N0YXJ0DQo+ICtfc3RhcnQ6DQo+ICsJ
bGxhCXQwLCB0cmFwDQo+ICsJY3NydwltdHZlYywgdDANCj4gKw0KPiArCWNzcnIJdDAsIG1pc2EN
Cj4gKwlsaQl0MSwgUlZDDQo+ICsJbm90CXQxLCB0MQ0KPiArCWFuZAl0MCwgdDAsIHQxDQo+ICsJ
Y3NydwltaXNhLCB0MA0KPiArCWNzcnIJdDEsIG1pc2ENCj4gKwlsaQlhMCwgMiAjIGZhaWwgY29k
ZQ0KPiArCWJuZQl0MCwgdDEsIF9leGl0ICMgQ291bGQgbm90IGNsZWFyIFJWQyBpbiBNSVNBDQo+
ICsNCj4gKwlsaQl0MSwgUlZDDQo+ICsJb3IJdDAsIHQwLCB0MQ0KPiArCWNzcncJbWlzYSwgdDAN
Cj4gKwljc3JyCXQxLCBtaXNhDQo+ICsJbGkJYTAsIDMgIyBmYWlsIGNvZGUNCj4gKwlibmUJdDAs
IHQxLCBfZXhpdCAjIENvdWxkIG5vdCBzZXQgUlZDIGluIE1JU0ENCj4gKw0KPiArCWoJdW5hbGln
bg0KPiArLiA9IC4gKyAyDQo+ICt1bmFsaWduOg0KPiArDQo+ICsJbGkJdDEsIFJWQw0KPiArCW5v
dAl0MSwgdDENCj4gKwlhbmQJdDAsIHQwLCB0MQ0KPiArCWNzcncJbWlzYSwgdDANCj4gKwljc3Jy
CXQxLCBtaXNhDQo+ICsJbGkJYTAsIDQgIyBmYWlsIGNvZGUNCj4gKwliZXEJdDAsIHQxLCBfZXhp
dCAjIFdhcyBhYmxlIHRvIGNsZWFyIFJWQyBpbiBNSVNBDQo+ICsNCj4gKwlsaQl0MCwgKFJWQ3xS
VlYpDQo+ICsJbm90CXQwLCB0MA0KPiArCWFuZAl0MCwgdDAsIHQxDQo+ICsJY3NydwltaXNhLCB0
MA0KPiArCWNzcnIJdDAsIG1pc2ENCj4gKwlsaQlhMCwgNSAjIGZhaWwgY29kZQ0KPiArCWJuZQl0
MCwgdDEsIF9leGl0ICMgTUlTQSB3cml0ZSB3YXMgbm90IGlnbm9yZWQgKFJWViB3YXMNCj4gY2xl
YXJlZCkNCj4gKw0KPiArCWoJcmVhbGlnbg0KPiArLiA9IC4gKyAyDQo+ICtyZWFsaWduOg0KPiAr
DQo+ICsJIyBTdWNjZXNzIQ0KPiArCWxpCWEwLCAwDQo+ICsJaglfZXhpdA0KPiArDQo+ICt0cmFw
Og0KPiArCSMgQW55IHRyYXAgaXMgYSBmYWlsIGNvZGUgMQ0KPiArCWxpCWEwLCAxDQo+ICsNCj4g
KyMgRXhpdCBjb2RlIGluIGEwDQo+ICtfZXhpdDoNCj4gKwlsbGEJYTEsIHNlbWlhcmdzDQo+ICsJ
bGkJdDAsIDB4MjAwMjYJIyBBRFBfU3RvcHBlZF9BcHBsaWNhdGlvbkV4aXQNCj4gKwlzZAl0MCwg
MChhMSkNCj4gKwlzZAlhMCwgOChhMSkNCj4gKwlsaQlhMCwgMHgyMAkjIFRBUkdFVF9TWVNfRVhJ
VF9FWFRFTkRFRA0KPiArDQo+ICsJIyBTZW1paG9zdGluZyBjYWxsIHNlcXVlbmNlDQo+ICsJLmJh
bGlnbgkxNg0KPiArCXNsbGkJemVybywgemVybywgMHgxZg0KPiArCWVicmVhaw0KPiArCXNyYWkJ
emVybywgemVybywgMHg3DQo+ICsJagkuDQo+ICsNCj4gKwkuZGF0YQ0KPiArCS5iYWxpZ24JMTYN
Cj4gK3NlbWlhcmdzOg0KPiArCS5zcGFjZQkxNg0K

