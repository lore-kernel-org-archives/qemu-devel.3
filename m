Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2666FCFA749
	for <qemu-devel@archiver.kernel.org>; Fri,  4 Oct 2024 05:23:53 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1swamQ-0008FO-Ez; Fri, 04 Oct 2024 01:23:06 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <clement.mathieu--drif@eviden.com>)
 id 1swamO-0008FA-P2
 for qemu-devel@nongnu.org; Fri, 04 Oct 2024 01:23:04 -0400
Received: from smarthost4.eviden.com ([80.78.11.85])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <clement.mathieu--drif@eviden.com>)
 id 1swamM-0005zL-8w
 for qemu-devel@nongnu.org; Fri, 04 Oct 2024 01:23:04 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=eviden.com; i=@eviden.com; q=dns/txt; s=mail;
 t=1728019381; x=1759555381;
 h=from:to:cc:subject:date:message-id:references:
 in-reply-to:content-id:content-transfer-encoding: mime-version;
 bh=JgiDik3RSEUPrm0JlPH/2tywSNuuk+hRNBP6kb42pwQ=;
 b=k0/Qduga8+AQOEi8VnkzqsfJ+1Fii2OnemWEXkfkkq/dt8LI2P9+d7CV
 pR/rWoyvMhrR2weMQvjp67VBI5tZrwtrZ2gdBKe+9pPSLM5Kv3pG4uaun
 aXP938jihLqYuYNAZS1fokIcWwzqR/v5MbvV6JUObNU3ivCE+BvHMp6RK
 JPGPQaVVTjiLAvzJ8wWjG4XBMrHQGVqU7JSRj2VDqBlhqWUXerKku5ky5
 Eyvus3Hz/1wAiIqRSLn/PvD6fNDV5TTofYJyvGAmmo6nKwfSHH0TRg0EP
 Fhnh0VmvLDpOLp6VXyOJYX/D8uP1dSNM+2xT7pyrJngAyDCOhDjLqAhiy A==;
X-IronPort-AV: E=Sophos;i="6.11,176,1725314400"; d="scan'208";a="21930865"
X-MGA-submission: =?us-ascii?q?MDFjgHXUy9RU/TVNcVYtZ0+xQXixU/cxpRZ1j3?=
 =?us-ascii?q?8J6OHbHtwW1Qot40QPTgJwaPwVG6rb/3StewdpIaNQv2u3A81XAsZADz?=
 =?us-ascii?q?TQ607WvXBr0R2gZRTNJrPC23z6+E2CnbnWRQLudIV6Nd+3xpcPpV4KUy?=
 =?us-ascii?q?ImgXmmR4f7OI2KXe5hIz2czQ=3D=3D?=
Received: from mail-vi1eur02lp2044.outbound.protection.outlook.com (HELO
 EUR02-VI1-obe.outbound.protection.outlook.com) ([104.47.11.44])
 by smarthost4.eviden.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 04 Oct 2024 07:22:55 +0200
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=p/EusW4igNU3W+Igmr1xgod1CmXCHET562hik1vg+Kj0DkC8Y5njEOYPxpMzKeIABBPcOnaXhU8lxyRFuPjr7CCf6jU2wJ/Ti1uS4ITy5HJjrx0dXpEKa/CUM91RtddEn2JuGcvN/wjCcp33MKyM+xn/aW+sgWDAsTAVw3vycpGvAAmOMH/xNZi1UuOXtT7pgIHXrBlwrXwGZ3U1Hbx84g7Ct0d9noUr3NsjZGLVpTc+y6jF6gG1+m9g71bje9uEvp0mTb/FrJZYZsAqc8qsd4AwgBe8aXt2SN+x+3bJ1EqRNShO/CIRSornN3d8dgoiVRyt2PPb52A+vupgbqHcSQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=JgiDik3RSEUPrm0JlPH/2tywSNuuk+hRNBP6kb42pwQ=;
 b=quZ6q8mm1/4hSaRQFoO6VnZiiH95tt/TkKpNjUdkGI69oZgV2naYzD407CC/pUQbZhpTpxHXwkOW1D/CgYauHHGL4yM8Jac5VUHEK1sw5JVzYGkRAWogWaODAbkKXGD+9f1e1ss1fLj7rmdbOXDeXdb0FxkFYdUzuYHWdQvGSKR3FuWzkOK1LbmXUFKolyhf1C6PVCR/6KiAxHzC0CSCQ36uVKrAD+CcUwipzjUz7J6LKtbzNFSRRFLEfQe6wm3wgzaRAI4GwDtetmGDOOyBChMIQSdpk0I8dCznufKzfn953xteah9351vBV8UgCP9inaNluJi7qSYF9MvS3C7h+A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=eviden.com; dmarc=pass action=none header.from=eviden.com;
 dkim=pass header.d=eviden.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Eviden.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=JgiDik3RSEUPrm0JlPH/2tywSNuuk+hRNBP6kb42pwQ=;
 b=Tlz4ItTMrMu1G/JG/0+VtN9xdF8GmzS4nY/1B9RBjZN1iUoZZQE4qldMqqx8apDYKNFpMoZ8Sq3F8BBvKNXzWE+19jM5OUNV/wGKfDfBRJUSz0XMYe5qzjBfuQts8wLhxzGPub1Pe6HwnD68aP4yr1lNYzk4NaFIRaQX3ZrtUyebBusgDT7t+sqP1vMyFARTDCFkgCjbyZ1cP9GvZtlbBCO6AuJxm5oHRbSBxVCq9Y0otKUjDWkTSGaOyE+5oQX5xMHAhRLYvmzo1fVf6pw0C2GyWklQZzMLq+qVz/W5JbxtADBTg5ynp8NvjS6z4mEHEsoCCP0RdbXwzjryGVf7Mw==
Received: from AM8PR07MB7602.eurprd07.prod.outlook.com (2603:10a6:20b:24b::7)
 by PA4PR07MB7197.eurprd07.prod.outlook.com (2603:10a6:102:d5::21)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7982.24; Fri, 4 Oct
 2024 05:22:54 +0000
Received: from AM8PR07MB7602.eurprd07.prod.outlook.com
 ([fe80::fbd7:ca71:b636:6f9d]) by AM8PR07MB7602.eurprd07.prod.outlook.com
 ([fe80::fbd7:ca71:b636:6f9d%5]) with mapi id 15.20.7982.018; Fri, 4 Oct 2024
 05:22:54 +0000
From: CLEMENT MATHIEU--DRIF <clement.mathieu--drif@eviden.com>
To: Zhenzhong Duan <zhenzhong.duan@intel.com>, "qemu-devel@nongnu.org"
 <qemu-devel@nongnu.org>
CC: "alex.williamson@redhat.com" <alex.williamson@redhat.com>,
 "clg@redhat.com" <clg@redhat.com>, "eric.auger@redhat.com"
 <eric.auger@redhat.com>, "mst@redhat.com" <mst@redhat.com>,
 "peterx@redhat.com" <peterx@redhat.com>, "jasowang@redhat.com"
 <jasowang@redhat.com>, "jgg@nvidia.com" <jgg@nvidia.com>,
 "nicolinc@nvidia.com" <nicolinc@nvidia.com>, "joao.m.martins@oracle.com"
 <joao.m.martins@oracle.com>, "kevin.tian@intel.com" <kevin.tian@intel.com>,
 "yi.l.liu@intel.com" <yi.l.liu@intel.com>, "chao.p.peng@intel.com"
 <chao.p.peng@intel.com>, Marcel Apfelbaum <marcel.apfelbaum@gmail.com>, Paolo
 Bonzini <pbonzini@redhat.com>, Richard Henderson
 <richard.henderson@linaro.org>, Eduardo Habkost <eduardo@habkost.net>
Subject: Re: [PATCH v4 03/17] intel_iommu: Add a placeholder variable for
 scalable modern mode
Thread-Topic: [PATCH v4 03/17] intel_iommu: Add a placeholder variable for
 scalable modern mode
Thread-Index: AQHbExtOcmEd7lg7IEu85cphAyfAurJ2FJMA
Date: Fri, 4 Oct 2024 05:22:54 +0000
Message-ID: <ed6d8a6b-b712-4859-8e4f-9a160a183410@eviden.com>
References: <20240930092631.2997543-1-zhenzhong.duan@intel.com>
 <20240930092631.2997543-4-zhenzhong.duan@intel.com>
In-Reply-To: <20240930092631.2997543-4-zhenzhong.duan@intel.com>
Accept-Language: en-GB, fr-FR, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=eviden.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: AM8PR07MB7602:EE_|PA4PR07MB7197:EE_
x-ms-office365-filtering-correlation-id: 6f8f6aaa-bdad-43a9-ac61-08dce434997b
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
 ARA:13230040|376014|7416014|366016|1800799024|38070700018; 
x-microsoft-antispam-message-info: =?utf-8?B?VEM0VElZaGdPSnZ0a2pObnRpenRvVHJya2lhZFNTRGhUeUF1NEx6UCs0anFz?=
 =?utf-8?B?eTltMFc0UmszSkxRVGFacUxRaStKVTNsYklMbU8vOG5qOXMvQVNDMUUrNm94?=
 =?utf-8?B?cnNiczdTUDBYY3dMVzBIaXE2L0JTZ0NOT0hBZmp3L3VOZ3NVT1dQelFLVXlI?=
 =?utf-8?B?SGlHUVZORlpGUWg5RW1RdmRRamJ2c1lLalN6T2UwMUMwOXZPQzNEUnNGMDhG?=
 =?utf-8?B?RlRGdzF4eTFqUVYycXY4eUljUTFKN1Z5Z2sxUkg0VXJhNmovM2U5T0RZVmFL?=
 =?utf-8?B?bmI1aFVBZnUyZ3MzVHo5T0pOUmdObjVqU2lPODlkQTJ1UXJnM2kySTNWSnV6?=
 =?utf-8?B?ODJOVDlJRHUweG9qYzVjai9Wby9TMEpoQ3p3MjduNWdMRmxuQTQ4TXBDUnEy?=
 =?utf-8?B?aWRweXpjYytEOUtXSm5NamxsZ3pDSzNmQkQ3QjYvR1JXaUp6U3hWSEJGK0xm?=
 =?utf-8?B?dHBFUkE5aWtuTkViMDhXaVZIWGpEaEZpdUIvbVE0aE4wNyswMFc4WWtpR3VN?=
 =?utf-8?B?TjZ2b2RUVXROdTNSWlRlTFV4OHJNc3Vtejlvbzd2Y01KSithMmN0M1p3d3lM?=
 =?utf-8?B?YkdlT0ExMStiTUdmTExrMFl3RFZsSkJabnhBR3BJRWh0Z1pFM1NTL0NrNHFu?=
 =?utf-8?B?S3dZNTFwb2xsY3hjREZNQmVFQU5ScWs0REthU3dKeXA2bHhQbTFCS0IwWit5?=
 =?utf-8?B?azl3ZTNiczNCRTR0S0JzMEJQak5IQlZtKzhONDRqbklTcVlUZFVDd0x0RExu?=
 =?utf-8?B?S2l4SEYvS0tvM3k1RWtreGZYekVIU0Fla2RUQnF3UlN6NkhmT0tvbkhOSnZl?=
 =?utf-8?B?aStPTzhxTUtUL3RsUmdHZThleEpoUGtmdnVUckhwZDMyaUZHUXl5Tkg5MUdo?=
 =?utf-8?B?blg3emtJVm1iQlJxbFFVVjdPOEhSdzNCZlNTeitQRmI5bFVNaHB1cFJIWHVa?=
 =?utf-8?B?dFpBNy9Wam0zVlBjaWNDdE1qWDBYbWxody9wQW80T01RWVltUS94Z05qZUQ1?=
 =?utf-8?B?TzhkWTcyTEM1SXlhNDdYSGh0OFRNenFXMlZteXJ6eUEyU3hHQ3lQdWdBWXc0?=
 =?utf-8?B?VllZTXlHWG95enpLK1N5K3JDek13dTFjWFRZTWhNbDc5MUU0WXZFRkZTamYy?=
 =?utf-8?B?WHl3RWV4dFNuMEs1THp1RXJwRGpaRjhNck1wOUtEdmRuMHFNcHZYMmw3anZt?=
 =?utf-8?B?QXMrcGRkck8wc0UxaWYwUWlpNndNTFppNFB6dXUxNFNMM21zaENwUkR0OHJ3?=
 =?utf-8?B?WCtUeFQ1Y25hdFhTT0tjU1g5L1R5bEdNUmNQd3ZDNDJ1dUJwd0RaS1NFUVEx?=
 =?utf-8?B?WXVrdVBvZDhnNm9EazRKbnIzOEFnRlVFY2tIV21SVkYxMWtVekV6dmQvM2ZN?=
 =?utf-8?B?MGxDQU5GcWk5U0pEbVpDdlVNN1k5bFBSWHJONTRIaEpiSmYzWkFMYkZpTC9F?=
 =?utf-8?B?Tkd4T29uV2tTVUtpcFhHUDA4Wnc2bDNlM2J5eWtaRmdEQnpDdms0OExDcFpI?=
 =?utf-8?B?elZxeTZJbVpKQUNLdklFV0xSZTh6R2xCb1dDN01GV0Ywb0huVnVrUE4zRjd5?=
 =?utf-8?B?d2RWeG5RMi9mZ0NiV1JtT2VzZGRTSkppOWtvb2cxOWZGeWprSnRXSkltbFdO?=
 =?utf-8?B?R3FEejVYc3ozQW91T2VybTlrQWRoWGV1K3YrY2gvS0k3VzJndHdtOXU1VGxE?=
 =?utf-8?B?bE93cGhSU095K2NybWlMUE9URnU0eHZPbGJWUlhUN1VCRTM2SzFqTVppUlF2?=
 =?utf-8?B?ajV0WUxjQVEydHhBemdhKzExWHQwOVoyZisyUFdxbnFxdzl0MFR0WG9VRmpq?=
 =?utf-8?B?MzlkYTJONXRXTDRUempUUT09?=
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:AM8PR07MB7602.eurprd07.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(376014)(7416014)(366016)(1800799024)(38070700018); DIR:OUT;
 SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?QkpwTm5rWWk5RzFaUmpoR1VoSHJ0Slp1a3hXa2dZU2J6aTRaNDRUK0pVa0lY?=
 =?utf-8?B?bVUvMWdVb3k1dmdyTU9aRzIzY0Z5MXJkcGJsWkhaKzJ4eFBzSk1ZeHl2Y29O?=
 =?utf-8?B?eDZUMzNVWFJEZUFqdVZFYURvRHFuSnZsWVdmdy9qYVpmS1pQSGJnRThrUWF1?=
 =?utf-8?B?b1FlSWZGeEpLUHdUeGVTUHZ1QkNJd1I4enFMRFRwaTcxdXgwcS9DNnljZE1G?=
 =?utf-8?B?M3JzcXNSREM4N1c2L21pVDRxTVRsQWlzLzA4UVRmQkduK2JjL2U0QVBxSk1U?=
 =?utf-8?B?U3RQME8zQm9FV1RYbkZzSERNWlRTSy9wUXpsb2NVd0M2TGsrL0NkSjRsL3Iz?=
 =?utf-8?B?NDJzQVdsNGhkL2lHdkxTNjYvY3ZIYndoQ3BKdlpzRnJEU2RFT3lkSHgzYTJC?=
 =?utf-8?B?cjJuNm5wYzZZdzRTSjQ1K3BBV1pJYlhtTzdTRGpLQ2R6Z3ZpeEtUVWhRb3pq?=
 =?utf-8?B?N0NYWmJOOFlBODBvaVZqYkd1eHMweXhBQndpU3Vrak8yODhMV0VGN2NGOXZD?=
 =?utf-8?B?WlR5Vno3Z0diWTFoeDdUSno5ZmgwUmRYYk5TOS85OGYxS1RDQUhWeUtVT0Zy?=
 =?utf-8?B?SDVpMFBDb2VxMG55UGdFVXc0bk56TEU2K0VJMGtBelZqbEVsYVIvZGp6aU1O?=
 =?utf-8?B?VzgrOGQ4emJSN09JOUlpdGdRTG81Mk1TSk9pTVg3MktBa0lPalhlSFl5TnJS?=
 =?utf-8?B?MFY5Q0tZUno3MU5jbjlsMlk2MVVxSUpxYzhFMlhYbTFHdFRkOWlYZ2pkWXVF?=
 =?utf-8?B?YVRaZlRYOGRRS3B3U2lwbXpvdWhWNUR0UEZLeTcrYWNHUkZlVlpkbUt4djg3?=
 =?utf-8?B?cWZrSXJLWWlTN0hDbExBNmhQRlBuUzhML0Qvak91bmlDWW1XSEJ0TXhqU3NP?=
 =?utf-8?B?UlhVU0c2K1lQbm5NQ0dKT205QS9GNTBxUjdod3ZKanJBQk8rQVJBZGxKZm5U?=
 =?utf-8?B?akJDajJlK2VWTm9jWkphUDN0alBKYzZqUmlaMGxxcUo4MFpnd1dXRENHazZC?=
 =?utf-8?B?OXl4M3AwTWQ2T1VvODZMTUlvSjM0d1NDUnhqb0F3bGZ4R3k0dWJIbEZDR0ZK?=
 =?utf-8?B?ZE5kcEJuWStqYzl2WEFOWjlUbUZ5YlFKeXJTVWJKSzI1djFMSGJEc1hUanVZ?=
 =?utf-8?B?WnFzZUlIMUM3ZUFQWkc2YXZlQTZ0b21XMXpaN0Y3ZHgxSUlPbE15TmlSdmdX?=
 =?utf-8?B?ZVJ3OFVSZmkzbzgyeURQQXVsNEVQN3MwNGxHY3htSG4zWE5vMnNUMWYxU2V2?=
 =?utf-8?B?S2FOZnZTQ1lqNGYvVmdFS3JJbDlXVTJxb1JBT00xc0RwektHWmsvRExRRzVy?=
 =?utf-8?B?Mnd5bnJ6ZWd5MnZodEFxYzJFaTNvMGpCUW5qU1paa3prZ3QybWJ1anRwR0RZ?=
 =?utf-8?B?VVBCS013NS9ZY2YvWXNRdytIazh4Y0Q0Q1lHSzUyam56Y0RDQnVNL2dkZWZB?=
 =?utf-8?B?MUY1bEJiOUROaGwrM3JWNEl0cmJBaGhPLzlyTzRkb3VLTXN1QWVZdWdFeGRF?=
 =?utf-8?B?Zkx5a2k3aWg3bzhOaGl4YnNNVXlvbWloQXE0eDFidnE1V3ZOc0l5TzBUVVMy?=
 =?utf-8?B?RmE2VWx3VmtLVUI5Q1VlMlcvR0NBTC9aaC9Wbnpvd1duOThSZkUvc2Y4a0VZ?=
 =?utf-8?B?TGVwNDRhbU85M1hFQiswYldMSzJTQkFTZlhSNStHbTdyaHlNNTJwVGc4OTZ0?=
 =?utf-8?B?RkhYNCtjbzlIaUNyNHgwaGMzZldEMkdrVXlOOHE2QUdkUmk1M2MrazhjN05P?=
 =?utf-8?B?TDNoelI4NWNjWjVoWVplazdzRkN2OTZheUJOMTFTNDhCNXZyaURDL3BjN0k4?=
 =?utf-8?B?bU85bzVNK2Y2ZWg0Z240SlhqOFVMellRbWZoQUdOUW5tVTR6aUM3RGFseWxa?=
 =?utf-8?B?dHFWUWcxY1MxKytSWG1PTldjaVBRNzRsR3d3TEtyeThKZURwREtTUHM0bCt4?=
 =?utf-8?B?Z2NmOVZvZFI5VWhxVG1jRDYxcmVneU8xcXI2RkdnQTJ3c2Z0UEFUSGM3d3Nm?=
 =?utf-8?B?TktHUzNWSzlvSEdQS1lIQitMMVhmR2h6TmhNOVRES3B0cnpTaUZhVmJNTm05?=
 =?utf-8?B?SmZXMWY5Zlc1SWE5Nnh2dGw1ellLTHF2enRIS08rTVRnbm41amMyWnozdFl2?=
 =?utf-8?B?d1g0bGZTNVB5Q201emdYL3NORnVBTWw2SkNZT0ZnaFNnNkN0aDRXNElhdDlF?=
 =?utf-8?Q?JBVDxSM/43ZgcJSyhzD+2QE=3D?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <2D2031F57A3FEA4D9DDCF14DC8D93325@eurprd07.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: eviden.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: AM8PR07MB7602.eurprd07.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 6f8f6aaa-bdad-43a9-ac61-08dce434997b
X-MS-Exchange-CrossTenant-originalarrivaltime: 04 Oct 2024 05:22:54.4173 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 7d1c7785-2d8a-437d-b842-1ed5d8fbe00a
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: E/2es40WFzatFCWR0XEANiCJmTQiivBlP6gd4jp8aZGYvBVgkWvN0CNeJdZpJ1R9ECYlrhjchIaie6eoTBIG0m6+XVjl5WY6gwcAeQQsgjYsnO4+OQ96FmtSuH37lUHB
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PA4PR07MB7197
Received-SPF: pass client-ip=80.78.11.85;
 envelope-from=clement.mathieu--drif@eviden.com; helo=smarthost4.eviden.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001, RCVD_IN_VALIDITY_SAFE_BLOCKED=0.001,
 SPF_HELO_PASS=-0.001, SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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

DQpMR1RNLCB0aGFua3MgZm9yIHRoZSB1cGRhdGUNClJldmlld2VkLWJ5OiBDbMOpbWVudCBNYXRo
aWV1LS1EcmlmPGNsZW1lbnQubWF0aGlldS0tZHJpZkBldmlkZW4uY29tPg0KDQo+IENhdXRpb246
IEV4dGVybmFsIGVtYWlsLiBEbyBub3Qgb3BlbiBhdHRhY2htZW50cyBvciBjbGljayBsaW5rcywg
dW5sZXNzIHRoaXMgZW1haWwgY29tZXMgZnJvbSBhIGtub3duIHNlbmRlciBhbmQgeW91IGtub3cg
dGhlIGNvbnRlbnQgaXMgc2FmZS4NCj4gDQo+IA0KPiBBZGQgYW4gbmV3IGVsZW1lbnQgc2NhbGFi
bGVfbW9kZSBpbiBJbnRlbElPTU1VU3RhdGUgdG8gbWFyayBzY2FsYWJsZQ0KPiBtb2Rlcm4gbW9k
ZSwgdGhpcyBlbGVtZW50IHdpbGwgYmUgZXhwb3NlZCBhcyBhbiBpbnRlbF9pb21tdSBwcm9wZXJ0
eQ0KPiBmaW5hbGx5Lg0KPiANCj4gRm9yIG5vdywgaXQncyBvbmx5IGEgcGxhY2VoaG9sZGVyIGFu
ZCB1c2VkIGZvciBhZGRyZXNzIHdpZHRoDQo+IGNvbXBhdGliaWxpdHkgY2hlY2sgYW5kIGJsb2Nr
IGhvc3QgZGV2aWNlIHBhc3N0aHJvdWdoIHVudGlsIG5lc3RpbmcNCj4gaXMgc3VwcG9ydGVkLg0K
PiANCj4gU2lnbmVkLW9mZi1ieTogWWkgTGl1IDx5aS5sLmxpdUBpbnRlbC5jb20+DQo+IFNpZ25l
ZC1vZmYtYnk6IFpoZW56aG9uZyBEdWFuIDx6aGVuemhvbmcuZHVhbkBpbnRlbC5jb20+DQo+IEFj
a2VkLWJ5OiBKYXNvbiBXYW5nIDxqYXNvd2FuZ0ByZWRoYXQuY29tPg0KPiAtLS0NCj4gIGluY2x1
ZGUvaHcvaTM4Ni9pbnRlbF9pb21tdS5oIHwgIDEgKw0KPiAgaHcvaTM4Ni9pbnRlbF9pb21tdS5j
ICAgICAgICAgfCAyMyArKysrKysrKysrKysrKysrKystLS0tLQ0KPiAgMiBmaWxlcyBjaGFuZ2Vk
LCAxOSBpbnNlcnRpb25zKCspLCA1IGRlbGV0aW9ucygtKQ0KPiANCj4gZGlmZiAtLWdpdCBhL2lu
Y2x1ZGUvaHcvaTM4Ni9pbnRlbF9pb21tdS5oIGIvaW5jbHVkZS9ody9pMzg2L2ludGVsX2lvbW11
LmgNCj4gaW5kZXggMWViMDVjMjlmYy4uNzg4ZWQ0MjQ3NyAxMDA2NDQNCj4gLS0tIGEvaW5jbHVk
ZS9ody9pMzg2L2ludGVsX2lvbW11LmgNCj4gKysrIGIvaW5jbHVkZS9ody9pMzg2L2ludGVsX2lv
bW11LmgNCj4gQEAgLTI2Miw2ICsyNjIsNyBAQCBzdHJ1Y3QgSW50ZWxJT01NVVN0YXRlIHsNCj4g
DQo+ICAgICAgYm9vbCBjYWNoaW5nX21vZGU7ICAgICAgICAgICAgICAvKiBSTyAtIGlzIGNhcCBD
TSBlbmFibGVkPyAqLw0KPiAgICAgIGJvb2wgc2NhbGFibGVfbW9kZTsgICAgICAgICAgICAgLyog
Uk8gLSBpcyBTY2FsYWJsZSBNb2RlIHN1cHBvcnRlZD8gKi8NCj4gKyAgICBib29sIHNjYWxhYmxl
X21vZGVybjsgICAgICAgICAgIC8qIFJPIC0gaXMgbW9kZXJuIFNNIHN1cHBvcnRlZD8gKi8NCj4g
ICAgICBib29sIHNub29wX2NvbnRyb2w7ICAgICAgICAgICAgIC8qIFJPIC0gaXMgU05QIGZpbGVk
IHN1cHBvcnRlZD8gKi8NCj4gDQo+ICAgICAgZG1hX2FkZHJfdCByb290OyAgICAgICAgICAgICAg
ICAvKiBDdXJyZW50IHJvb3QgdGFibGUgcG9pbnRlciAqLw0KPiBkaWZmIC0tZ2l0IGEvaHcvaTM4
Ni9pbnRlbF9pb21tdS5jIGIvaHcvaTM4Ni9pbnRlbF9pb21tdS5jDQo+IGluZGV4IGJlN2M4YTY3
MGIuLjllNmVmMGNiOTkgMTAwNjQ0DQo+IC0tLSBhL2h3L2kzODYvaW50ZWxfaW9tbXUuYw0KPiAr
KysgYi9ody9pMzg2L2ludGVsX2lvbW11LmMNCj4gQEAgLTM4NzIsNyArMzg3MiwxMyBAQCBzdGF0
aWMgYm9vbCB2dGRfY2hlY2tfaGlvZChJbnRlbElPTU1VU3RhdGUgKnMsIEhvc3RJT01NVURldmlj
ZSAqaGlvZCwNCj4gICAgICAgICAgcmV0dXJuIGZhbHNlOw0KPiAgICAgIH0NCj4gDQo+IC0gICAg
cmV0dXJuIHRydWU7DQo+ICsgICAgaWYgKCFzLT5zY2FsYWJsZV9tb2Rlcm4pIHsNCj4gKyAgICAg
ICAgLyogQWxsIGNoZWNrcyByZXF1ZXN0ZWQgYnkgVlREIG5vbi1tb2Rlcm4gbW9kZSBwYXNzICov
DQo+ICsgICAgICAgIHJldHVybiB0cnVlOw0KPiArICAgIH0NCj4gKw0KPiArICAgIGVycm9yX3Nl
dGcoZXJycCwgImhvc3QgZGV2aWNlIGlzIHVuc3VwcG9ydGVkIGluIHNjYWxhYmxlIG1vZGVybiBt
b2RlIHlldCIpOw0KPiArICAgIHJldHVybiBmYWxzZTsNCj4gIH0NCj4gDQo+ICBzdGF0aWMgYm9v
bCB2dGRfZGV2X3NldF9pb21tdV9kZXZpY2UoUENJQnVzICpidXMsIHZvaWQgKm9wYXF1ZSwgaW50
IGRldmZuLA0KPiBAQCAtNDI1NywxNCArNDI2MywyMSBAQCBzdGF0aWMgYm9vbCB2dGRfZGVjaWRl
X2NvbmZpZyhJbnRlbElPTU1VU3RhdGUgKnMsIEVycm9yICoqZXJycCkNCj4gICAgICAgICAgfQ0K
PiAgICAgIH0NCj4gDQo+IC0gICAgLyogQ3VycmVudGx5IG9ubHkgYWRkcmVzcyB3aWR0aHMgc3Vw
cG9ydGVkIGFyZSAzOSBhbmQgNDggYml0cyAqLw0KPiAtICAgIGlmICgocy0+YXdfYml0cyAhPSBW
VERfSE9TVF9BV18zOUJJVCkgJiYNCj4gLSAgICAgICAgKHMtPmF3X2JpdHMgIT0gVlREX0hPU1Rf
QVdfNDhCSVQpKSB7DQo+IC0gICAgICAgIGVycm9yX3NldGcoZXJycCwgIlN1cHBvcnRlZCB2YWx1
ZXMgZm9yIGF3LWJpdHMgYXJlOiAlZCwgJWQiLA0KPiArICAgIGlmICghcy0+c2NhbGFibGVfbW9k
ZXJuICYmIHMtPmF3X2JpdHMgIT0gVlREX0hPU1RfQVdfMzlCSVQgJiYNCj4gKyAgICAgICAgcy0+
YXdfYml0cyAhPSBWVERfSE9TVF9BV180OEJJVCkgew0KPiArICAgICAgICBlcnJvcl9zZXRnKGVy
cnAsICIlcyBtb2RlOiBzdXBwb3J0ZWQgdmFsdWVzIGZvciBhdy1iaXRzIGFyZTogJWQsICVkIiwN
Cj4gKyAgICAgICAgICAgICAgICAgICBzLT5zY2FsYWJsZV9tb2RlID8gIlNjYWxhYmxlIiA6ICJM
ZWdhY3kiLA0KPiAgICAgICAgICAgICAgICAgICAgIFZURF9IT1NUX0FXXzM5QklULCBWVERfSE9T
VF9BV180OEJJVCk7DQo+ICAgICAgICAgIHJldHVybiBmYWxzZTsNCj4gICAgICB9DQo+IA0KPiAr
ICAgIGlmIChzLT5zY2FsYWJsZV9tb2Rlcm4gJiYgcy0+YXdfYml0cyAhPSBWVERfSE9TVF9BV180
OEJJVCkgew0KPiArICAgICAgICBlcnJvcl9zZXRnKGVycnAsDQo+ICsgICAgICAgICAgICAgICAg
ICAgIlNjYWxhYmxlIG1vZGVybiBtb2RlOiBzdXBwb3J0ZWQgdmFsdWVzIGZvciBhdy1iaXRzIGlz
OiAlZCIsDQo+ICsgICAgICAgICAgICAgICAgICAgVlREX0hPU1RfQVdfNDhCSVQpOw0KPiArICAg
ICAgICByZXR1cm4gZmFsc2U7DQo+ICsgICAgfQ0KPiArDQo+ICAgICAgaWYgKHMtPnNjYWxhYmxl
X21vZGUgJiYgIXMtPmRtYV9kcmFpbikgew0KPiAgICAgICAgICBlcnJvcl9zZXRnKGVycnAsICJO
ZWVkIHRvIHNldCBkbWFfZHJhaW4gZm9yIHNjYWxhYmxlIG1vZGUiKTsNCj4gICAgICAgICAgcmV0
dXJuIGZhbHNlOw0KPiAtLQ0KPiAyLjM0LjENCj4gDQo+IA0KPiANCg==

