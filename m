Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B02D6C30653
	for <qemu-devel@archiver.kernel.org>; Fri,  5 Jul 2024 02:40:39 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sPYrt-00019g-7x; Thu, 04 Jul 2024 22:40:13 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <lizhijian@fujitsu.com>)
 id 1sPYrq-00018r-9S; Thu, 04 Jul 2024 22:40:10 -0400
Received: from esa12.fujitsucc.c3s2.iphmx.com ([216.71.156.125])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <lizhijian@fujitsu.com>)
 id 1sPYrn-0005BE-Dd; Thu, 04 Jul 2024 22:40:09 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
 d=fujitsu.com; i=@fujitsu.com; q=dns/txt; s=fj1;
 t=1720147208; x=1751683208;
 h=from:to:cc:subject:date:message-id:references:
 in-reply-to:content-id:content-transfer-encoding: mime-version;
 bh=bKnwgjHStbQGnXLl6skbRQZGL0cQlagvjLwBSNKoNSM=;
 b=U8LD/71iNim4xrSLnllcLDXDabtYtyJDpj1eRKV21JLLZTbs2YHtV7Gu
 GLanWFK64jJ50h1qA0IDY6Bfyl9bSQ66clqhdNzO3c4an+pDCOrPEWtA3
 O1Fn208OMSN2hFXiZ6f9J/pFB59mMvbiVIu2u1pqx+m1+8DaYPCgO88mc
 BXm55+2MQo+bIOOKrAm88Zv10gyeRw6q/LUbg8V9bTo3IAuWgQA0qC37g
 UVDzYDvPmLhA/jit4LRSNgL3uIjEedgCqg+g2IwI2g1AHzBaJbi+MKwRX
 m6cIdB8lt323XGcxsDYShK4N64Lk88c0ovtmDubbqh/ICtei2nzSVUklk A==;
X-IronPort-AV: E=McAfee;i="6700,10204,11123"; a="124477912"
X-IronPort-AV: E=Sophos;i="6.09,183,1716217200"; d="scan'208";a="124477912"
Received: from mail-japaneastazlp17010005.outbound.protection.outlook.com
 (HELO TY3P286CU002.outbound.protection.outlook.com) ([40.93.73.5])
 by ob1.fujitsucc.c3s2.iphmx.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 05 Jul 2024 11:39:55 +0900
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=IL0okKTY5W0HW1ZpyQ2JVDIVRF24a/lnY7RHMv3OEjAiOlG0XmFlViF8BkrXTu37qAsVgfiLjdqOa1S28BMLDPlf9U57cij5+mRxXoJ/fD3yrYmIsgRG0KUW0C2yfiWdyx2uRzEUWfsCCVGifDbRpMB89lfTm7CNJg7aJuJTHlmEGt9gNuCAjsCcS49300+A2KSS2Jd4Nc4QVPAb23UOOzHtDNcoHv6XFwIMDXh4Rlrs5jxOSg4J6xHGOCOQaoPUv0dtSN4zmyUiHc5nZjlHqQrPxgq8r+LX24vbqOsbXW/QLCj/gLU+uLHRIU36o6z9gezeghetFVDyPPtcctDZmg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=bKnwgjHStbQGnXLl6skbRQZGL0cQlagvjLwBSNKoNSM=;
 b=DwBg0vPbc40UCmCg9mm6S1e0534eDOxXH/c36dta0kDI3SDjotAien+PjLEb80esxY+5BPL3PItFnpD2Qm+zrx5z9JbuWiTTjqHmRv5YzEZyq13OHISD5kOMGsedjG/SUavVkEDTqGXfXlaGVJoHEFgmMXqQT0B8CtTYqyZWnd6yFtcdqGJXA6kK++IOkN+yDS+3OokzLKT2clg+BtG/eg3q7JIzXEyQZCyfzM2ljFaV8U6qdI2yQw9CekZwE2H9M6qYSKS8/5f9zxsAauj/07fYO7xX1LpxyDnJDG1xhv3uLehMoo2y+n9rvzRER1GXHkJ+0Vd1sscF/TnL+vPWeA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=fujitsu.com; dmarc=pass action=none header.from=fujitsu.com;
 dkim=pass header.d=fujitsu.com; arc=none
Received: from TY1PR01MB1562.jpnprd01.prod.outlook.com (2603:1096:403:6::12)
 by TY3PR01MB11688.jpnprd01.prod.outlook.com (2603:1096:400:373::6) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7741.30; Fri, 5 Jul
 2024 02:39:51 +0000
Received: from TY1PR01MB1562.jpnprd01.prod.outlook.com
 ([fe80::d9ba:425a:7044:6377]) by TY1PR01MB1562.jpnprd01.prod.outlook.com
 ([fe80::d9ba:425a:7044:6377%3]) with mapi id 15.20.7741.027; Fri, 5 Jul 2024
 02:39:51 +0000
To: Zhao Liu <zhao1.liu@linux.intel.com>, Jonathan Cameron
 <jonathan.cameron@huawei.com>, Fan Ni <fan.ni@samsung.com>
CC: "qemu-devel@nongnu.org" <qemu-devel@nongnu.org>, "qemu-stable@nongnu.org"
 <qemu-stable@nongnu.org>, Zhao Liu <zhao1.liu@intel.com>
Subject: Re: [PATCH] hw/cxl/cxl-host: Fix guest crash when getting cxl-fmw
 property
Thread-Topic: [PATCH] hw/cxl/cxl-host: Fix guest crash when getting cxl-fmw
 property
Thread-Index: AQHazfNaqna5bUJSQkmiw0Omd9+O67HnbU+A
Date: Fri, 5 Jul 2024 02:39:51 +0000
Message-ID: <3cccc5ba-81b9-4391-b187-27562ebc6c85@fujitsu.com>
References: <20240704093404.1848132-1-zhao1.liu@linux.intel.com>
In-Reply-To: <20240704093404.1848132-1-zhao1.liu@linux.intel.com>
Accept-Language: en-US, zh-CN
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
user-agent: Mozilla Thunderbird
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=fujitsu.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: TY1PR01MB1562:EE_|TY3PR01MB11688:EE_
x-ms-office365-filtering-correlation-id: 6dc07b2b-a957-4cf7-8c2c-08dc9c9bbe98
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
 ARA:13230040|1800799024|376014|366016|38070700018|1580799027; 
x-microsoft-antispam-message-info: =?utf-8?B?R1hVb2p0dHhaZHFvU091SXhPY1hsWTJRcCtwV1Znd05WTjY5blc0Skk3RHpY?=
 =?utf-8?B?ZmIyTlNMSGR0cnZSSnh3cFRtQkhpd0g4VlA2TWZkMStTeHVRK1JqSUdmVDdz?=
 =?utf-8?B?MStFSGxwTDdVQytDcVZkZ2p4LzZzbThBM3FkOVRtdFJHbk0vQmlEUjB2VzNS?=
 =?utf-8?B?NGMxKzlkSzFxM0doQk5XeEJQaE9JZFFhU09rakZUWjcvR292VjdBblBwYUpm?=
 =?utf-8?B?SWg4bllxSWRDY2phNnRsNkFCcWordkdKcW5hVDZtYUJUa3Z3NE4yUDZuQUxy?=
 =?utf-8?B?V1kvL3dvZWFvY2svK0pNNnY3QW9HQ21JanlMTTdjWmpYcldtNlNuY0pjVm1n?=
 =?utf-8?B?MncwQWMxZXI1REFibk5WbVBDYWk5dEl0VHk0NlJkQnNLVHo4Q1dYOXpXU01Z?=
 =?utf-8?B?WGRkWVN4T1d5SitlMkRKTC9oS1NiZmtFYTVxRWJTaTRRTzdkQSt6VzN6MmRG?=
 =?utf-8?B?S3l1VHRJd3pJRjZrN2lpSmE0ZmFFUXRTU2hsWFJ3N1RnRTNNR3dNUFppZnFB?=
 =?utf-8?B?U2kzTzQ1cGhxUWZCUll4VHBuUTdFbWZ1VEwrWG1yWElCNUJFZlExWlN5dlV2?=
 =?utf-8?B?amk0cnFRSVcrQ3hzWVh2bnBDYysvajdadnZjVS92bHRHZDM4dzQvYklldW9x?=
 =?utf-8?B?WGZJM2x5STZzZlpRT1BHVExyaCtZY1RaRmRVSHBGbG4xQyswTG1SRS96S0dn?=
 =?utf-8?B?cGRHSnVoQ3BCeDM4Y0d1eFdFRkFtZXpLVTYrMElHeFJCd1pRUUhZSFc5K3Bl?=
 =?utf-8?B?a1lSQ1hxZnBpS3MxRE1vR09rYkp5UVRJZ2FxeWMvOGJNcmtKY2I4S0xRUko4?=
 =?utf-8?B?QU50d202V1JtOThROUNJUnJJUlcrc1gzSFZLL3g1Y3loVUFHMEVLZ2FVaEda?=
 =?utf-8?B?akxScnpJMTAwdGt1VHpxdXhLNVd4Q2lON0dtM0lZcGtsREN0QVRpS0Uwbllj?=
 =?utf-8?B?eVl1amErYnIycGlRRUw5U2tnenJWNURUVzhSZ2o2V29IVXlwOFZNZ25tYUhk?=
 =?utf-8?B?ZzRDdHo4WU0zdTFwUGRLNmdxM3I3bFpMOUpzbkRSSi9RT0xaenZTNEg2bmM0?=
 =?utf-8?B?NHpTb2orWUlZVWkyMWtkZHdXRlkveXdUeTcwaytwN1JaYURsL1dHTU1tb1kr?=
 =?utf-8?B?cDl6b3ZVNW5TMkJ6TGo4RG9SenFERVk4RFlSNkpzdDJnYVdid1pqYWJiWUVq?=
 =?utf-8?B?Mmw3Yzl6aXBnSDNFWFJYQnphZnczaUpLWUhxMmlvekUwVzl3QkNtVTlhcVhP?=
 =?utf-8?B?RlNyeDExZ3pINVUxTktYcXllMXkyb3pCbTgzSWJhVDBBc002K2RpMmoyTU9u?=
 =?utf-8?B?R0lSbVhpWEUwd1BSSWVnVk1WNU1Kdmd1U28xYi9IYi9MUHpmbDhERFk1V3FQ?=
 =?utf-8?B?Yk1RRVp5d1V2WGdOQjE3NlhIeldYSi9jNlovamhKQy94UGQxOTRuOE5GT0JP?=
 =?utf-8?B?dmF1bGhuNUV6WjhLU1ZuUkozaG9pcU9oVjRwM2ROSHRWU3NZU0dkZC95T2l0?=
 =?utf-8?B?bEsxRjlNQWJ3cENjY0VhTVAxSUdaVUdLbnlJQ3MxRmd2S1Z5cE9MeGt1bTBh?=
 =?utf-8?B?dDBycDBGcmJ1eEVDVE5nV3BaTmFHT1pXTi9TUjhGMTk1NjJYZElnL0JhZGFz?=
 =?utf-8?B?YU5tazRyMjYxSVdERmw1bi9ycXBnWFRQUVl6UDA1aEM4QStHbXlKMzdZamQy?=
 =?utf-8?B?UHA5QUZHWU5qcnE1TU9wRFJZTDdtQVNpbXlWeFpmcW84Zmk5NUpvbDBrVlh6?=
 =?utf-8?B?czZGM2w1aEhodGUzcDZwSGMyMXMycUJtMjV3SFBxeUNXQXJGTWQxSDJoWVIr?=
 =?utf-8?B?MDBQN05tOHhzR2IzM3B3T2Rtc01HVjQyVFRDTWFnQTdaUlB0SW82RGp0cVp4?=
 =?utf-8?B?ajVlNEd3OTVFUnBHRHBMRUx6L1dBZktSNHA0TEdycFNNVHFXelJBdGEycWJp?=
 =?utf-8?Q?i7GwLZwayn0=3D?=
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:TY1PR01MB1562.jpnprd01.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(1800799024)(376014)(366016)(38070700018)(1580799027); DIR:OUT;
 SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?bEY0eklvQVQ2UGtzckVQdVRTZTBxOENzdmYxcUN5L3BaTGoyWUppVkNGdis4?=
 =?utf-8?B?UGEramthME5hN3NzM0FJMDlYYVdHSnNwR1NyRm5rQ0hTNDgrRXl5UUFSbEo1?=
 =?utf-8?B?eWIweHAzYlJLajdVSnZaSXMzbXliRkxHMGtOT3RndExaQVNrbnVQUUVGM1Vr?=
 =?utf-8?B?RzRuTFVvRFlwSUtuYVcydzR6Z2JGREJZdmFkNWp3WXIyeTM5WVl3Zm04czlj?=
 =?utf-8?B?WG1XNUl4cGErdzdUMTA5Q2Z3VW4rTGlCcnBMVG5sNU1mQ0JsbkxZdVdIb1Nx?=
 =?utf-8?B?RHJqSUJEQ2RQZDlzVnZQQ0h5ajJmczNYVFZ2OGtVdkVFTFc2MytxTE5ZR3Rm?=
 =?utf-8?B?YmFpVzY0L2xOdzR0RUN2cW5jQTIvKzFQTDRaYng0QXM5aVYrZlZxOTlFZTE3?=
 =?utf-8?B?b2puR09wMnI4RjdlSE9CWkcrY1dWRHhVTytZS2haNW5LbWk0NFh2VG5YRnhw?=
 =?utf-8?B?R0dzdmRRRS9vRjhZZGxWRVgrOVFYUVFCSzhNYzNmRWl1b2RSVDBJT1pJdVp3?=
 =?utf-8?B?YU9tUHBXMkNlQ29LbmFoYThVYnBEcHhWYjhtUjNvYnBIS2JsSEo1Z2s2UmFq?=
 =?utf-8?B?STJpajVXeGxPcDRReUdPT1h0dFc1SmJyRDY5NTBleXJiRzN0OXVmY0dyTTlp?=
 =?utf-8?B?b0NLVjBTOERERUIrS0QzWHA2SnpJQktBRTU5MStPSVRCQ0J3ejRXaEV2cHdh?=
 =?utf-8?B?Ry9UbGwyd1RRajdXd3VOaTZxejl2dkFqNStRcFlIcGZYS3JuaWpSM3lHNkpk?=
 =?utf-8?B?TTRFdVVxNHJ1dG1zTE5odUxMZmxoVHFRYTFSVlhwUzRSS1liNG54bmRQWWZu?=
 =?utf-8?B?b1RnYUU2Y1NFSUUyUDBpU2pWZHJnNU9zMUI4M0xXWCtuZHd0UW1QQzVwZ1g4?=
 =?utf-8?B?Yis4NnV0QnBNR2dmWTZkM0NLWUFjNU9tWFRGL2NWb004Q1J5VUxXbTloSVFh?=
 =?utf-8?B?NFVmSko1M1RyRGl4dllTZVFwYnN4cUY0UHRaUk5OeVBadXRlY2xQYzdySFdm?=
 =?utf-8?B?SU56S0F5WUthdUVzTm5ndVorWkdLejJLOVdwR2JPcU1WS00yb3kxVnFLeDZ3?=
 =?utf-8?B?bkYvK1duY2ZIYWZyQ1JqcFFnWTFNbW15VUlCZDV5QmlXSjNzOWNhNnlZK293?=
 =?utf-8?B?bkpXSDc3SGxIZGZheVBGZ2V0NTMwQkw3d2prMDNGWVVJd0lGSDF5Zm1UTTk2?=
 =?utf-8?B?Uk11dUFOV0dFbThtOExlRTZzMGgrVGF6MXAyaTl2NFFGSHd2cWRLZ1h0c1pR?=
 =?utf-8?B?VmVBd2x3Q2N4bDBNUS9SUHhGTmlGOWtobldqWjZMRVRpZmdUMTdmYlBMVEJ1?=
 =?utf-8?B?cUxHdWFoaXJBT1ZTKzFEdWVRU3FsT3p0TGFoYk5LMGJxQnFzVkJxK2NmMzF6?=
 =?utf-8?B?dW56Y1hjUEY3VkpjNE43RG54dUYxNUV0cWZwM2w2NHRSZE8wMko0UUtZbW5q?=
 =?utf-8?B?VmJXT21sVUJZYm1uYkxmUDBNYXpSc0EzWmN2bStyblI0RDAyMTUzTWpRR2da?=
 =?utf-8?B?ZVk5MTRZOVc5Y3d3dUdlQXJxL09xK3hkR2Z2cWhCVTB4S0RzbnpISFRLeisw?=
 =?utf-8?B?SldYSVFDOHF0ZS9WNUlGUWZURFNqcTZweis3U0dTa2pJQkZvVXhjUW1DalJx?=
 =?utf-8?B?bC9oN2Mwa2tocnFkTm91ZkxvMW95Z3Jhem43akoyNXJNRWpDK1FraFBDaElt?=
 =?utf-8?B?V053THZmdDR3WTc5Z3hQVFUxU3ZYaGtDNW1yNTNvUEJzcDNHWkFyZ1hjSFNM?=
 =?utf-8?B?bTM0MkFsNFc0cE5FbmZ2OWFtYW0rcUxKb0pDVk9pUjVxSVcyKzAwTzlrYWhB?=
 =?utf-8?B?Q21tV25EbFU3cHJheWJLYmhMc2VhbmVXa0FPQlpSYmJtR21BS3c5eFBGK2h1?=
 =?utf-8?B?K091RE14S1RXNklwbDBJT2pIY056KzlpelVUcTFqV2VSZEZNSlh1ZjZOMzZa?=
 =?utf-8?B?NWx0cjR3L2doOHVCc1B5aHlZZGxUYjRzUFF6ZFF5MEhOMm1LNXBCUTBvRFVi?=
 =?utf-8?B?czBrTUJyeUxRRWNFclRRQmplTTlUcE8yclVSUDBsS2pYeDVLVHFiUHlnaEwr?=
 =?utf-8?B?Rk5lVUlPVzgxSHpSdFFDcndkNmNnZTJQc2t2K0ZPaXdLVUgwNTFtaWdzdDZR?=
 =?utf-8?B?YUhpR3FON21LQU9MQk1JNlk3aFVGME9jZmhwV1RZQm5OQk9UbXpKQ3NReDQ0?=
 =?utf-8?B?L3c9PQ==?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <FD5DDB5E77BA3D4F982403729306BCF1@jpnprd01.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: /VObkeAPbcMjjQAtmloiPN3IVFbtbxOTub2gs5FnfSlP458KDWO9vnYNAn32NY1R8SHQ/tpqz0EMMBcx03ntGvIAw2UPqitEMPAw6NObKieQkKOYrATjXO/MeNw5VOWIwJ58BuPbVrxfXPL1ZwJ4VJc9tbMU2avuilt9lQZTiXiguVNiIHvn5pkx2TVfnSw8uFM9+ho0k9J6CX3dkqVVfU4j5eQfNNOoGF0FCt8oRLMk4QwXUtohlkpHa+ap5Y/UGfoVGQqjoArJjNnf2E4BSOCxNWZA+9zPAGJTkAfC+2Cv2j+J/9I0wgGOLW6xSX5RF3RtOIGo7hCR01YDQt/r7fBHq/EL58DcCp+xLpTxhEHL2dYkxeCgzuIrKvZbDc4BL582tNHWPsyHOkZsbKw6vg8uAh/+0PZIvbU+d2ZWIpfHHwEoxYqlXTzK5P67VXazXAgYXLjbWWmKA1RGBWIDTdKY+3cUYHzwHxR96zidAR9mypmi156ztp+i9fO/XQAHFIXMOMRLwDoG9B1EnW/oov453NAkClHwKbw0dppgYCPsuEAwrYh7A/Z5cCRiYXQcSq9vw8lvLqxI6ibJzc3CczKHsxFXFuEt9038E0/YxpvuUHPCVtvOmh4Sd2gVDjdn
X-OriginatorOrg: fujitsu.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: TY1PR01MB1562.jpnprd01.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 6dc07b2b-a957-4cf7-8c2c-08dc9c9bbe98
X-MS-Exchange-CrossTenant-originalarrivaltime: 05 Jul 2024 02:39:51.1185 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: a19f121d-81e1-4858-a9d8-736e267fd4c7
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: pY63dYtvczyQIZC/3AlhLHQDCX1NS5VJadtJkpfHs5vR3FNtGS6FYKtVGL100Y5xpN0evwl4fcw2D1e5hAmCFw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: TY3PR01MB11688
Received-SPF: pass client-ip=216.71.156.125;
 envelope-from=lizhijian@fujitsu.com; helo=esa12.fujitsucc.c3s2.iphmx.com
X-Spam_score_int: -43
X-Spam_score: -4.4
X-Spam_bar: ----
X-Spam_report: (-4.4 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_MED=-2.3, RCVD_IN_MSPIKE_H4=0.001, RCVD_IN_MSPIKE_WL=0.001,
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
Reply-to:  "Zhijian Li (Fujitsu)" <lizhijian@fujitsu.com>
From:  "Zhijian Li (Fujitsu)" via <qemu-devel@nongnu.org>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org

DQoNCk9uIDA0LzA3LzIwMjQgMTc6MzQsIFpoYW8gTGl1IHdyb3RlOg0KPiBGcm9tOiBaaGFvIExp
dSA8emhhbzEubGl1QGludGVsLmNvbT4NCj4gDQo+IEd1ZXN0IGNyYXNoZXMgKFNlZ21lbnRhdGlv
biBmYXVsdCkgd2hlbiBnZXR0aW5nIGN4bC1mbXcgcHJvcGVydHkgdmlhDQo+IHFtcDoNCj4gDQoN
CklNTywgaXQncyBmYWlyIHRvIHNheSAiR3Vlc3QgY3Jhc2hlcyIgd2hpY2ggZ2VuZXJhbGx5IG1l
YW5zIHRoZSBndWVzdCBrZXJuZWwgcGFuaWMgZXRjLg0KSSdkIHByZWZlciB0aGUgc3ViamVjdCBs
aWtlOg0KaHcvY3hsL2N4bC1ob3N0OiBGaXggc2VnbWVudGF0aW9uIGZhdWx0IHdoZW4gZ2V0dGlu
ZyBjeGwtZm13IHByb3BlcnR5DQoNCg0KT3RoZXJ3aXNlLA0KDQpSZXZpZXdlZC1ieTogTGkgWmhp
amlhbiA8bGl6aGlqaWFuQGZ1aml0c3UuY29tPg0KDQoNCj4gKFFFTVUpIHFvbS1nZXQgcGF0aD1t
YWNoaW5lIHByb3BlcnR5PWN4bC1mbXcNCj4gDQo+IFRoaXMgaXNzdWUgaXMgY2F1c2VkIGJ5IGFj
Y2Vzc2luZyB3cm9uZyBjYWxsYmFjayAob3BhcXVlKSB0eXBlIGluDQo+IG1hY2hpbmVfZ2V0X2Nm
bXcoKS4NCj4gDQo+IGN4bF9tYWNoaW5lX2luaXQoKSBzZXRzIHRoZSBjYWxsYmFjayBhcyBgQ1hM
U3RhdGUgKmAgdHlwZSBidXQNCj4gbWFjaGluZV9nZXRfY2ZtdygpIHRyZWF0cyB0aGUgY2FsbGJh
Y2sgYXMNCj4gYENYTEZpeGVkTWVtb3J5V2luZG93T3B0aW9uc0xpc3QgKipgLg0KPiANCj4gRml4
IHRoaXMgZXJyb3IgYnkgY2FzdGluZyBvcGFxdWUgdG8gYENYTFN0YXRlICpgIHR5cGUgaW4NCj4g
bWFjaGluZV9nZXRfY2ZtdygpLg0KPiANCj4gRml4ZXM6IDAzYjM5ZmNmNjRiYyAoImh3L2N4bDog
TWFrZSB0aGUgQ1hMIGZpeGVkIG1lbW9yeSB3aW5kb3cgc2V0dXAgYSBtYWNoaW5lIHBhcmFtZXRl
ci4iKQ0KPiBTaWduZWQtb2ZmLWJ5OiBaaGFvIExpdSA8emhhbzEubGl1QGludGVsLmNvbT4NCj4g
LS0tDQo+ICAgaHcvY3hsL2N4bC1ob3N0LmMgfCAzICsrLQ0KPiAgIDEgZmlsZSBjaGFuZ2VkLCAy
IGluc2VydGlvbnMoKyksIDEgZGVsZXRpb24oLSkNCj4gDQo+IGRpZmYgLS1naXQgYS9ody9jeGwv
Y3hsLWhvc3QuYyBiL2h3L2N4bC9jeGwtaG9zdC5jDQo+IGluZGV4IGM1ZjVmY2ZkNjRkMC4uZTlm
MjU0M2M0M2M2IDEwMDY0NA0KPiAtLS0gYS9ody9jeGwvY3hsLWhvc3QuYw0KPiArKysgYi9ody9j
eGwvY3hsLWhvc3QuYw0KPiBAQCAtMzE1LDcgKzMxNSw4IEBAIHN0YXRpYyB2b2lkIG1hY2hpbmVf
c2V0X2N4bChPYmplY3QgKm9iaiwgVmlzaXRvciAqdiwgY29uc3QgY2hhciAqbmFtZSwNCj4gICBz
dGF0aWMgdm9pZCBtYWNoaW5lX2dldF9jZm13KE9iamVjdCAqb2JqLCBWaXNpdG9yICp2LCBjb25z
dCBjaGFyICpuYW1lLA0KPiAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgdm9pZCAqb3Bh
cXVlLCBFcnJvciAqKmVycnApDQo+ICAgew0KPiAtICAgIENYTEZpeGVkTWVtb3J5V2luZG93T3B0
aW9uc0xpc3QgKipsaXN0ID0gb3BhcXVlOw0KPiArICAgIENYTFN0YXRlICpzdGF0ZSA9IG9wYXF1
ZTsNCj4gKyAgICBDWExGaXhlZE1lbW9yeVdpbmRvd09wdGlvbnNMaXN0ICoqbGlzdCA9ICZzdGF0
ZS0+Y2Ztd19saXN0Ow0KPiAgIA0KPiAgICAgICB2aXNpdF90eXBlX0NYTEZpeGVkTWVtb3J5V2lu
ZG93T3B0aW9uc0xpc3QodiwgbmFtZSwgbGlzdCwgZXJycCk7DQo+ICAgfQ==

