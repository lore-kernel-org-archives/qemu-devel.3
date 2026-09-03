Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id CF1F6C624D6
	for <qemu-devel@archiver.kernel.org>; Thu,  3 Sep 2026 01:48:33 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1x1wYr-0005uS-Qn; Wed, 02 Sep 2026 21:48:17 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1)
 (envelope-from <prvs=6997dc6e7=Alistair.Francis@wdc.com>)
 id 1x1wYk-0005u5-DA; Wed, 02 Sep 2026 21:48:11 -0400
Received: from esa5.hgst.iphmx.com ([216.71.153.144])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1)
 (envelope-from <prvs=6997dc6e7=Alistair.Francis@wdc.com>)
 id 1x1wYg-0002nc-Ky; Wed, 02 Sep 2026 21:48:09 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
 d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
 t=1788400087; x=1819936087;
 h=from:to:cc:subject:date:message-id:references:
 in-reply-to:content-id:content-transfer-encoding: mime-version;
 bh=1OJqsP99FGKzPx0d8s7vK1x9R/dVLTRlV9Wy5itFJWg=;
 b=dlWGiGjauZp0CIIAlC2ictExrIjXWzJSy8fY84o/kd5h157cl3dkN7kw
 KDI+Pl/WI3j5rINUm8X1PeCp0qtoy6nJEOZtHGDRVoQxG0PJgT48Jw8UE
 P/eE4GRzYNlzekGRv999Q/iCzjJa6YjdatBYv0avUJJVaJDrGWC644r/w
 cld/bMBYiT54EPUwUMck9RviXmtqEFSW2iCfRAtTaHfTCGO7Emr9jWbgf
 BZMGaMf0VXeUNTKNJZfZwNYWDrg5a888mvK+1cwehL19XXHTjBCYwmjlG
 7ewg5qT9nfx1GVr63Rul6mbT1AgXoA0hCDjLoKjYTTcJoDWv9teGCLdrf A==;
X-CSE-ConnectionGUID: vMjybJYBRxCfpkbIly4gEw==
X-CSE-MsgGUID: 4RbJauW4R8y5AidGUqLzVA==
X-IronPort-AV: E=Sophos;i="6.25,258,1779120000"; d="scan'208";a="153874814"
Received: from mail-centralusazon11011024.outbound.protection.outlook.com
 (HELO DM5PR21CU001.outbound.protection.outlook.com) ([52.101.62.24])
 by ob1.hgst.iphmx.com with ESMTP/TLS/ECDHE-RSA-AES128-GCM-SHA256;
 03 Sep 2026 09:48:04 +0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=HbYOklRkkU5/tQFS5QKKVq/BLRFbgoK20Ryf0HRSL8n3RAELOGeCAX1rNN3Zwsm7RWSmksCT060Jc2pMnFRUsMaFMjC/j/gmKXgnROb8q1I5lmtLNZA4f+uauqB7SQEU5oKrZuE+S4DgOTendagA/nZS8npKm3SigkgNyIheayg+ZjLdfn651fL1vfLTQXT/eDYAX4xWQF4Q9O1SKm0iZATwUOci6pO3Yer1kSKhWem8PQymUWXDhF92j1Zz8cpCC3bBz0AXJswMIRa1TeEykqT8pabeUvofey9qqCFGbErW+eZRelHAlqSdCWKq3yVD/tlA88uHWCsT/8N02ACoSw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=1OJqsP99FGKzPx0d8s7vK1x9R/dVLTRlV9Wy5itFJWg=;
 b=Ufm2Pl71vipJJ+g7JHfduva1P1mmpaNmenNE2UNLlxxmOEE3X9dLyEIdBpFthTEK4SZQwhdNFdsdtylqtQpQzRPYxjzzJ8R93UZ2bhweBwggzfujVgLNz8ppIec6hpkPg511R85hBCglvkPyJnIFWqX+P4q4rO+WLYcootR5/A4g8wbqlcwF7zxxaXqc3TdumY1Un8AVES6wjobkCSO5EVs8g/Mu4ObKStVuc2TIo5j6agtYtia57T1pclA7yGPbF/EQpwhwt3/c5IAv5eIt9Hd7Iidn0wkFBadZBuYi7lddq019GT5rwolCP5RNF89ai5GRq9vBZ7P/vDaPtssFww==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=wdc.com; dmarc=pass action=none header.from=wdc.com; dkim=pass
 header.d=wdc.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=sharedspace.onmicrosoft.com; s=selector2-sharedspace-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=1OJqsP99FGKzPx0d8s7vK1x9R/dVLTRlV9Wy5itFJWg=;
 b=pnDbRMqTyY6WQ1LVfiL1D0EHxoiUfGMf0LpS9SQs4+7uTUPjjaSK+i1csOwAcK+i63HwaBd19DsA9/8P54CMHvY8v266tsi1cl2GyLuEB+Pdrst952VPmekUpLg9jAPhEoikl8BM94RttAe1BRDi55pX8eTZ7o9btpKePf8XUjE=
Received: from BY1PR04MB9561.namprd04.prod.outlook.com (2603:10b6:a03:5b6::11)
 by PH0PR04MB7640.namprd04.prod.outlook.com (2603:10b6:510:5b::12)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.360.13; Thu, 3 Sep
 2026 01:48:02 +0000
Received: from BY1PR04MB9561.namprd04.prod.outlook.com
 ([fe80::3869:e494:2fa8:9888]) by BY1PR04MB9561.namprd04.prod.outlook.com
 ([fe80::3869:e494:2fa8:9888%5]) with mapi id 15.21.0382.007; Thu, 3 Sep 2026
 01:48:02 +0000
From: Alistair Francis <Alistair.Francis@wdc.com>
To: "daniel.barboza@oss.qualcomm.com" <daniel.barboza@oss.qualcomm.com>,
 "joel@jms.id.au" <joel@jms.id.au>
CC: "npiggin@gmail.com" <npiggin@gmail.com>, "mpe@kernel.org"
 <mpe@kernel.org>, "portias@oss.tenstorrent.com"
 <portias@oss.tenstorrent.com>, "qemu-devel@nongnu.org"
 <qemu-devel@nongnu.org>, "clg@kaod.org" <clg@kaod.org>,
 "chao.liu@processmission.com" <chao.liu@processmission.com>,
 "zhiwei_liu@linux.alibaba.com" <zhiwei_liu@linux.alibaba.com>,
 "asrinivasan@oss.tenstorrent.com" <asrinivasan@oss.tenstorrent.com>,
 "liwei1518@gmail.com" <liwei1518@gmail.com>, "qemu-riscv@nongnu.org"
 <qemu-riscv@nongnu.org>
Subject: Re: [PATCH v2 06/16] hw/riscv/cps: Map interrupt controllers in SoC
 container
Thread-Topic: [PATCH v2 06/16] hw/riscv/cps: Map interrupt controllers in SoC
 container
Thread-Index: AQHdOO62KlpkCIOAP02ho8SozdWjQ7a8GqOA
Date: Thu, 3 Sep 2026 01:48:01 +0000
Message-ID: <c40e659291d0d3ace0d97bcb0fb9942208a6279e.camel@wdc.com>
References: <20260831021500.82565-1-joel@jms.id.au>
 <20260831021500.82565-7-joel@jms.id.au>
In-Reply-To: <20260831021500.82565-7-joel@jms.id.au>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
user-agent: Evolution 3.60.2 (by Flathub.org) 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=wdc.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: BY1PR04MB9561:EE_|PH0PR04MB7640:EE_
x-ms-office365-filtering-correlation-id: 9c622dc4-b819-4527-a0e5-08df095d63bc
wdcipoutbound: EOP-TRUE
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
 ARA:13230040|7416014|10070799003|366016|1800799024|19092799006|376014|23010399003|22082099003|18002099003|38070700021|4143699003|56012099006|11063799006|10067099003;
x-microsoft-antispam-message-info: ErR2PsXUfXq3CEgn7iEPGwX6dz2viR9eMI1Z3MFD3u+/scwDb/BaVE/G6VdVg12Aefswks6EvQnlZxKWbK0sU8NfdIzGZdyUMhtrCpqzC6jkqhl6+0UsnHeH39j4FAKca1P1NrWWIvBfx9zVicNkiG/MIoekByk705Dw4bbQPXSZjbDqNpEFkh5IMyUsJ7yuKpTLFKVRzUce3j8lao7x8nSijejgVobKX+P13+/7giqGtfty4zULCafNrZCM/b/4NVrukwYWbuI/UV+RNQHEcIPMU5ksuEwBoBCsuq02m+DjWyDMnVF9HveGhtDRkARuIOfxc48mEaOnHTNccwhwOiK3hMf+dKYEiHILh+V6u2XyVvuPt12cZup4ju2SV5UgM3mg4oxDSe5YUmanVOS02EDCHPMg2IslzzPJj49EjJCx4anqPYlrprlN8y0Z3rSNAytGX93WCSVQP3+kxi+ID2DnxjIHQON9pLybY0dYw7oZtb2KPn4NKbyfpAX5XVRhkRqOWB9Eeb1M0q9T97+hKWIRM1L0Ja7kyJZ6MH5097327+bPbeMU0NjuFY/5qnsqHfvk3ea2mYB6IEjP/OeQ//2sW/iJL27J5/w2Of7MWMbMOXe1/k7MNgTSpfNRYEKlD+q2HxEURfXKoCyUPrmdwYkQy0ijj46s1Itw5Io4tG+p56BqwTEQcHDLOaKcGTtlOM5lrCDK7WbmDxvZSzElGVrGWKnSUmwv56ryRTc+ENM=
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:BY1PR04MB9561.namprd04.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(7416014)(10070799003)(366016)(1800799024)(19092799006)(376014)(23010399003)(22082099003)(18002099003)(38070700021)(4143699003)(56012099006)(11063799006)(10067099003);
 DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 2
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?TUc5aEJxL0p6bzRmQUVRaXYrTURqUW5SUVVhaDE1d0lWT0lmNndhTFBwVUVk?=
 =?utf-8?B?Qkh5OFhoTFczQU5XaER5ZjdIOUg4V2JJTm5BWmNTZG1hSEtzUjJHUlZHRng1?=
 =?utf-8?B?cW8vS1JEMExHaVU2RGpSUVdWWjhsSUhjN3Y5SjVuMXRJSlV4VVN0SSthS1Jn?=
 =?utf-8?B?ekFqdlF2MWJmR1dBc0t2ZFpiY0VkaStMc1FMeW95a1lqaVlNNEFnL2dycFZC?=
 =?utf-8?B?bGlVMmFsZmp3QkMwNHQwemRwM05rU0xmamM3eklkZXpzTFhSUWtCSVRldjFa?=
 =?utf-8?B?MXFrQVcvME5qY09QLzdXME42Qmc4NU96V292RzVwajZwMk5JUlFLS3BiWFdM?=
 =?utf-8?B?UEFVclZOeWwwb2FRdk9DbUd0TTVjTzRNMnpXdy9lK3JndFN3aFZVVUdEK1l6?=
 =?utf-8?B?TjhLTVBJSFgzTlBKckJFVjFiU1d0bnhoUEpFRnN2NmlZREVJckR5L3FNVHRy?=
 =?utf-8?B?TFltMVZWUlZWL01MRWZ5RmVLdlZpVlRINDRGVGFNekhMaitnelZYdUZjWWNK?=
 =?utf-8?B?YmxvZEN1QWFPd1hvVUx5RGhZYmlrV01DRVUvSTh5Tys5UXFOSlp5V1EwaFk0?=
 =?utf-8?B?VVIzaFhvUU52OHBxNUJ3M1FnUVUwRzROKzYxazNDYzdYWEJBVFhEU2R4VTFH?=
 =?utf-8?B?NDJsZDFBT1hrRlg0dktsbzh0cGM0NnBWMUFvSGlpVmdDaTJxZ3p6Y3lwQlhm?=
 =?utf-8?B?WTZYb2gxREhRNUhSYVc0WUFjcHAyRU9mWXYwNDZYc2hmVWFoemVGaXY1YTQr?=
 =?utf-8?B?VUI3TENMVFBJMHRhNXB0M2dKcko4RDNLeitaZVljdlh1SHhONHBxdFJ4cjY4?=
 =?utf-8?B?MkFzUjUvQUdlTjVkQjc4K2U1cWwrOThUb2RHM2RpaFVUaW9nL3dGL3RtN1hT?=
 =?utf-8?B?WnJvMHZuRWgvZko5U3pmeTJPWEZMeTg1UHU2Tjc4NTRxb1k5eXZKWkQwOER6?=
 =?utf-8?B?ZVg1dzVmSHN6NGI5NmcxVlBvQWlxYWs3M3hMYWR4aVUvMWlrZlZkZlBCTWFq?=
 =?utf-8?B?UmdMQkE3ZjZIOCt2L2NIWTZ0WW9hTjdlWU5XaTJsc283cWpTY3pPZlVUR3JB?=
 =?utf-8?B?KzdPa0VsVkRtck94V1Z6M0VuM3ErRitaYWFXV01zOG13elpHNFhhMEcwa2Nr?=
 =?utf-8?B?eUx4VVBlMzZEQnFCeUpTNHJwS2F3ck5HaDdoRXBUSnJBQkZrcVFUOXRMc0dY?=
 =?utf-8?B?b2h2UElhUzA2MFRKTTA4WSsvRUtKVkVmM0VieHpOOWgyNkZIdjhtajJYcUll?=
 =?utf-8?B?VUxscENIZE4xaVN6L2dqcTZIcS9PU1pQN3VQeHRpSXVEQktMMDJGQ25DUGU1?=
 =?utf-8?B?SXhYaEQ4YXlGMlBQWFZPV0JtMEcrejRQU0UyQUlNZlMvOTFZNzNSY0FvM0cx?=
 =?utf-8?B?blRxb29MZEdGMVRWYnZBOExkT1AreXVUTVdvOTBQYkhGRThoVkh1RFdPT0J5?=
 =?utf-8?B?clY3WDljMjIyMHkvY3p5S295UkJkOGNtYVQ5SFNkR3VESmVJUHc5M1FYM0tq?=
 =?utf-8?B?MW9WRHJtZXFLcXNtMkZrU2wxWDIrRHpMdXpxMlNvcEx2dEtPVGhQcmVzeXJz?=
 =?utf-8?B?VlFYLzVXaFFjRnIwcXE0REZabCt5WTBEWCtweXFGSjRIRTVVOWk0YVJoMkFl?=
 =?utf-8?B?L05SRGNkY2FlMUF3Q2t5dWhqZ1hkTnlZM2F2UmZyaEgxNENCU1lHWjhaVHRX?=
 =?utf-8?B?cnlIYnZPS3c5TllyYkdHaTRmSGNsaEZhK013NkZ0R2dVWmRYanNTaVlOUDVQ?=
 =?utf-8?B?SDZ5VkoyZTUvOWpScUN0VjRSSngvY3BBL2w1UUkyRmlISFhBWEx5bkF3bm4x?=
 =?utf-8?B?RkhhQVlobVRlWUxkajFBaVdhMmFFWVF5TXR2RjU3blFCbU1yeVVxdGMwWUNv?=
 =?utf-8?B?cHNZMUx4M1V2UDhPRW9pQjVvanptd3RmTERaWjh5WnR4UDg4RjMvMkhEdlRH?=
 =?utf-8?B?MmJqVjlkSUwxc0FJY0NXRmM0SHliY0xoT21vNktHUys1ejVJemhFUlhWVis2?=
 =?utf-8?B?ZzVmRjY5TnNqbUpKeTdBYm9EUHp3eGdwenZOKzdxZENxUkhsUjd4LzUwMGZs?=
 =?utf-8?B?azdTRTE0ZWpRTXRLbW1ERHY2V1JtbHN2NHlMWXdaUmhscnZEQWtEalhaMDRn?=
 =?utf-8?B?Z0oyL2owcEJhZC90OUw4eTV3OWRMcXVPRTVOWWJxYlNYWXY2dTkwOGJ4dEJM?=
 =?utf-8?B?b0krZktveWpZSkZNT2VmbGNMRUlUdzJTTmdkZnpxbTFFUkdFd3NJSDhDcTNV?=
 =?utf-8?B?aUdwNG5JZHh2RkN4dk1BR1F0a1lzNnh3dWZKQUlCWDBrV3ZCUlNwY3lZMktz?=
 =?utf-8?B?NzVwSjdPV3MrZEdXK1c2SjlpemF4TkNoMHpwbDRaVlNTMVUvc2s4a2I1RFl2?=
 =?utf-8?Q?g1UIpWTPWp22dyXZ+oEW2IRftc8FgSmVLRsMEPUoJ+M5J?=
x-ms-exchange-antispam-messagedata-1: tPea0GvIFIzmsNHnCOp6svMObvsbTWEYrCc=
Content-Type: text/plain; charset="utf-8"
Content-ID: <ECA72755BFAD0A4D9730BA87B75BAFE3@namprd04.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-Exchange-RoutingPolicyChecked: BSPWPLMvXE/0fqUPAYvqf09mIWExnuiYEE9AIssK8uWjHHzSueCU0SvUbXWjY6X/99e5BQoFEJSWBvferury+8eWqIchaZFy6Wh9yEpukbaUXK8doPC6C6uBINVvGcgweySqNI5LTGchrq5pBp94PQ1JH/7au7FEYIeFl5PBHQafKXt5rvnKKr69QAOtaxqW7ShC7pqrPn1Svlr0T9robbZTHY+YRCluLi4NXwjXyZy7nmivYePOTmNvogg+7ieyHXj36i+UXCIVwoAA5rH1Mn0Mh69LK4oVYcT3GaGquTMS3iNfL10eM4R8Lqvv385J0b3RhFGneyOqAKFg0C0Qfg==
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: vGvEpMqiGPnrRWXKVZn/43v8cRU1jwoz4HsAZQbuazAmf8kVR/5mVcrahgAApxlENc5k7uRKN0OCAL8BqwcnidzGiWxELqDqeTLPt9P9bC9FcDVNe/PW1umkhQ4gQNsP8s2W7Y51vHVJJUFvezLUqMiRU3Chs7R6wL0HaMiQzFfJi0ttIk/kNQA4KoR0zeKKtnpGmELv3+H34Fky6qchF8kRjo/BxZOPAq1I9Zxz99Ql4LYGe/lQ+F7V3VR2dGnDkfHwy0jWOew9KU+MyZ1Lg+Kkirb1Y8P+y2viUAqkNHcDj3rXt3Y+bDuq+DJRhoTLYMRSfj2AwYKQ+4xql+4+jgrNaQjKyAV7RfcEQ6gzArymcLjG+X9jmLBTcpm2B+aU9YrZDwn7JGMs44Q+1gax+g33d+ff0Wx/GDKvdWdCuIN4QUdG69ov6/8svFtdDoAi5NhFqN7oSl0rs5hqWQEifsTQwTERC6/zPobaq7JB1Un13LUgf/6+3lygbcZz+V9CrC99AhzR+GjyfbD8VKweT832witqm3Vko0/S1wNT+oscPANgaKevA53aabCWiA9z4nKt+cpIj3eg0PP9MNb4tbp6Brz21RmvPyFDyz6y42UGLD7eAKCPAfvk69IY3lS/
X-OriginatorOrg: wdc.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: BY1PR04MB9561.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 9c622dc4-b819-4527-a0e5-08df095d63bc
X-MS-Exchange-CrossTenant-originalarrivaltime: 03 Sep 2026 01:48:01.9273 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: b61c8803-16f3-4c35-9b17-6f65f441df86
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: BeVSGICl/8xD4tQeVro+29Ca4V7EUdsc7uu0Kiz3ujUHDABSLj36KInynnA+qLdYXkv8ukpbvFfKB8KW1LlufzcKGXkYhVrT0oM6t1cIejM=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH0PR04MB7640
Received-SPF: pass client-ip=216.71.153.144;
 envelope-from=prvs=6997dc6e7=Alistair.Francis@wdc.com;
 helo=esa5.hgst.iphmx.com
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

T24gTW9uLCAyMDI2LTA4LTMxIGF0IDExOjQ0ICswOTMwLCBKb2VsIFN0YW5sZXkgd3JvdGU6Cj4g
VGhlIENQUyBkZXZpY2UgbWFwcyBzb21lIGRldmljZXMgaW50byBhIGNvbnRhaW5lciByZWdpb24s
IGJ1dCB0aGUKPiBBQ0xJTlQgYW5kIEFQTElDIHdlcmUgbWFwcGVkIGRpcmVjdGx5IHRvIHN5c3Rl
bV9tZW1vcnkuCj4gCj4gUGFzcyB0aGUgY29udGFpbmVyIG1lbW9yeSByZWdpb24gdG8gdGhlIGlu
dGVycnVwdCBjb250cm9sbGVyIGhlbHBlcnMKPiBzbwo+IGFsbCBDUFMgZGV2aWNlcyBsaXZlIGlu
IHRoZSBjb250YWluZXIuIFRoZSBsb2NhdGlvbiBvZiBkZXZpY2VzIGluCj4gbWVtb3J5Cj4gZm9y
IHRoZSBib3N0b24tYWlhIG1hY2hpbmUgaXMgdW5jaGFuZ2VkLgo+IAo+IFNpZ25lZC1vZmYtYnk6
IEpvZWwgU3RhbmxleSA8am9lbEBqbXMuaWQuYXU+CgpSZXZpZXdlZC1ieTogQWxpc3RhaXIgRnJh
bmNpcyA8YWxpc3RhaXIuZnJhbmNpc0B3ZGMuY29tPgoKQWxpc3RhaXIKCj4gLS0tCj4gwqBody9y
aXNjdi9jcHMuYyB8IDggKysrKy0tLS0KPiDCoDEgZmlsZSBjaGFuZ2VkLCA0IGluc2VydGlvbnMo
KyksIDQgZGVsZXRpb25zKC0pCj4gCj4gZGlmZiAtLWdpdCBhL2h3L3Jpc2N2L2Nwcy5jIGIvaHcv
cmlzY3YvY3BzLmMKPiBpbmRleCBkMmZkOTYzOGEwOGQuLjIxZGFhZjQ5NDNkOCAxMDA2NDQKPiAt
LS0gYS9ody9yaXNjdi9jcHMuYwo+ICsrKyBiL2h3L3Jpc2N2L2Nwcy5jCj4gQEAgLTEzNSw3ICsx
MzUsNyBAQCBzdGF0aWMgdm9pZCByaXNjdl9jcHNfcmVhbGl6ZShEZXZpY2VTdGF0ZSAqZGV2LAo+
IEVycm9yICoqZXJycCkKPiDCoMKgwqDCoCBmb3IgKGkgPSAwOyBpIDwgbnVtX29mX2NsdXN0ZXJz
OyBpKyspIHsKPiDCoMKgwqDCoMKgwqDCoMKgIHVpbnQ2NF90IGNtX2Jhc2UgPSBHTE9CQUxfQ01f
QkFTRSArIChDTV9TSVpFICogaSk7Cj4gwqDCoMKgwqDCoMKgwqDCoCB1aW50MzJfdCBoYXJ0aWRf
YmFzZSA9IGkgPDwgTUhBUlRJRF9DTFVTVEVSX1NISUZUOwo+IC3CoMKgwqDCoMKgwqDCoCBzLT5h
cGxpYyA9IHJpc2N2X2FwbGljX2NyZWF0ZShnZXRfc3lzdGVtX21lbW9yeSgpLAo+ICvCoMKgwqDC
oMKgwqDCoCBzLT5hcGxpYyA9IHJpc2N2X2FwbGljX2NyZWF0ZSgmcy0+Y29udGFpbmVyLAo+IMKg
wqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDC
oMKgwqDCoMKgwqDCoMKgwqAgY21fYmFzZSArIEFJQV9QTElDX01fT0ZGU0VULAo+IMKgwqDCoMKg
wqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDC
oMKgwqDCoMKgwqAgQUlBX1BMSUNfTV9TSVpFLAo+IMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKg
wqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqAgaGFydGlk
X2Jhc2UsIC8qIGhhcnRpZF9iYXNlICovCj4gQEAgLTE0Myw3ICsxNDMsNyBAQCBzdGF0aWMgdm9p
ZCByaXNjdl9jcHNfcmVhbGl6ZShEZXZpY2VTdGF0ZSAqZGV2LAo+IEVycm9yICoqZXJycCkKPiDC
oMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKg
wqDCoMKgwqDCoMKgwqDCoMKgIEFQTElDX05VTV9TT1VSQ0VTLAo+IMKgwqDCoMKgwqDCoMKgwqDC
oMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKg
wqAgQVBMSUNfTlVNX1BSSU9fQklUUywKPiDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDC
oMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgIGZhbHNlLCB0cnVl
LCBOVUxMKTsKPiAtwqDCoMKgwqDCoMKgwqAgcmlzY3ZfYXBsaWNfY3JlYXRlKGdldF9zeXN0ZW1f
bWVtb3J5KCksCj4gK8KgwqDCoMKgwqDCoMKgIHJpc2N2X2FwbGljX2NyZWF0ZSgmcy0+Y29udGFp
bmVyLAo+IMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKg
wqDCoCBjbV9iYXNlICsgQUlBX1BMSUNfU19PRkZTRVQsCj4gwqDCoMKgwqDCoMKgwqDCoMKgwqDC
oMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgIEFJQV9QTElDX1NfU0laRSwKPiDCoMKg
wqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqAgaGFydGlk
X2Jhc2UsIC8qIGhhcnRpZF9iYXNlICovCj4gQEAgLTE1MywxMCArMTUzLDEwIEBAIHN0YXRpYyB2
b2lkIHJpc2N2X2Nwc19yZWFsaXplKERldmljZVN0YXRlICpkZXYsCj4gRXJyb3IgKiplcnJwKQo+
IMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoCBm
YWxzZSwgZmFsc2UsIHMtPmFwbGljKTsKPiDCoMKgwqDCoMKgwqDCoMKgIC8qIFBMSUMgY2hhbmdl
cyBtc2lfbm9uYnJva2VuIHRvIHR1cmUuIFdlIHJldmVydCB0aGUgY2hhbmdlLgo+ICovCj4gwqDC
oMKgwqDCoMKgwqDCoCBtc2lfbm9uYnJva2VuID0gZmFsc2U7Cj4gLcKgwqDCoMKgwqDCoMKgIHJp
c2N2X2FjbGludF9zd2lfY3JlYXRlKGdldF9zeXN0ZW1fbWVtb3J5KCksCj4gK8KgwqDCoMKgwqDC
oMKgIHJpc2N2X2FjbGludF9zd2lfY3JlYXRlKCZzLT5jb250YWluZXIsCj4gwqDCoMKgwqDCoMKg
wqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoCBjbV9i
YXNlICsgQUlBX0NMSU5UX09GRlNFVCwKPiDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDC
oMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgIGhhcnRpZF9iYXNlLCBNQVhfSEFSVFMs
IGZhbHNlKTsKPiAtwqDCoMKgwqDCoMKgwqAgcmlzY3ZfYWNsaW50X210aW1lcl9jcmVhdGUoZ2V0
X3N5c3RlbV9tZW1vcnkoKSwKPiArwqDCoMKgwqDCoMKgwqAgcmlzY3ZfYWNsaW50X210aW1lcl9j
cmVhdGUoJnMtPmNvbnRhaW5lciwKPiDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKg
wqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgIGNtX2Jhc2UgKyBBSUFfQ0xJTlRf
T0ZGU0VUICsKPiDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKg
wqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgIFJJU0NWX0FDTElOVF9TV0lfU0laRSwKPiDCoMKgwqDC
oMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKg
wqDCoMKgIFJJU0NWX0FDTElOVF9ERUZBVUxUX01USU1FUl9TSVpFLAo=

