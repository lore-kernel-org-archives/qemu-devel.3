Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 328F5C9832F
	for <qemu-devel@archiver.kernel.org>; Mon, 28 Sep 2026 01:40:16 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xB0LS-000546-U8; Sun, 27 Sep 2026 21:39:55 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1)
 (envelope-from <prvs=724888370=Alistair.Francis@wdc.com>)
 id 1xB0LP-00053f-VR; Sun, 27 Sep 2026 21:39:53 -0400
Received: from esa4.hgst.iphmx.com ([216.71.154.42])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1)
 (envelope-from <prvs=724888370=Alistair.Francis@wdc.com>)
 id 1xB0LN-0003cA-Bb; Sun, 27 Sep 2026 21:39:51 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
 d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
 t=1790559594; x=1822095594;
 h=from:to:cc:subject:date:message-id:references:
 in-reply-to:content-id:content-transfer-encoding: mime-version;
 bh=/+g4Ot4FYHELSEAL8QryWXmd44RJ0D7kJtJEBHDvQww=;
 b=XBKGL6U3PUwX32lz3hQzlUkiAUoY97+uToxCPvz5bGoI5vu+wtM+DPzK
 iooXFbSiXyIrUXlFutIPQQiCz2KFkMgKYy48afJcMrv3Egs6cXz0afM94
 YHicCK8ucN7rd/IVih6THbb91QAu8YWCDUPPVMP0Nwf1lQ9iSIoRedUkj
 dfxYFUyrfXDdVYrFdjdsGUqomPIu0xY+8pxoARmpgljQIrbSLuNUarEQf
 if/zZIJB7hvfKJ70LKp8qDo/xyUcp2U5fUn3kW37X1X0AasnggHheNi+O
 O3L3f3jg1SL9wB1IQq5mWNjEEjMXNcr7MjXQB77+rgj8srupkIjfqDZ6U Q==;
X-CSE-ConnectionGUID: e4pJm1R7S5SKya/kasOXsA==
X-CSE-MsgGUID: xnfyv17vTC+lexfl2nf6fg==
X-IronPort-AV: E=Sophos;i="6.27,127,1786982400"; d="scan'208";a="152484359"
Received: from mail-northcentralusazon11010016.outbound.protection.outlook.com
 (HELO CH1PR05CU001.outbound.protection.outlook.com) ([52.101.193.16])
 by ob1.hgst.iphmx.com with ESMTP/TLS/ECDHE-RSA-AES128-GCM-SHA256;
 28 Sep 2026 09:39:48 +0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=oagiuCSWFPOoDIMbcdQ/3cDsPmNONfCvLdp8yawuy+O9u9rc6ZQ1MPHoRFcr0BfW3cPiXKvEIh/ILSBOBZbFV2hCsfeoTC78NZ1mobCbUPR+FDSmWxUa53j6pdjpDugecv7pGkXLasTQtIFqCbWOIyeBDVU1FoVrSQbjWbNU9JYOeA3HmnMeW5wTeuaT/UmoObKQqXAAeAA7DP0UCMrtAZlqS9b2qt04xGfMt7h0610kxTEgEj+a0rC4gd1j1Iyj9eLgKC1hZ5dCF94vFC7i2BFt7K3us1CRLteGSnI7wxVLo5L/eIPCsvZ4lqiT6S8Bco5VHp7XegxIJvo6L3Wjyw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=/+g4Ot4FYHELSEAL8QryWXmd44RJ0D7kJtJEBHDvQww=;
 b=AVfEQTjCmIN5ZleaEyzHgc8LcF+EWy33XVKhG8DiVACdYEugcxn1NFeddTlDCb9vCy9dYTbrZv4Y8JaRgRaBgx4zX5aiS7QN30/VacfwV3ny30a3rca/LS27ogwU7GPG3aRZ+CwYw78cjrlmftc5ua+K3pQ7AD4kiHLTfZjmwebe/6xNJfF7MBcHOCPUm/9yoCW46YQD+73FzEv0I1FzRdTvJuhYcol7B9mpHD+li4YJCJM+OkdIaMe0DK5GHchxW+UYLmiMzBK3u38ggHaN8S85EdRD+wKIk9K7XbSqhrj87cdDYrMddOX3NmRo4XnXuCdImBFcTiIwFTLuTA3WnA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=wdc.com; dmarc=pass action=none header.from=wdc.com; dkim=pass
 header.d=wdc.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=sharedspace.onmicrosoft.com; s=selector2-sharedspace-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=/+g4Ot4FYHELSEAL8QryWXmd44RJ0D7kJtJEBHDvQww=;
 b=eXEJiOmH8S8XgMD0qpBxbOMM+uau+JjFOIEwdzcB7FoLIH2+2a/WCVd0TXvz7fjg7gNDmRH4mNzfm+mnFMNAo/yOoV1s+JfrkPd0VAIoOh2d8esxpzrwUb1bfwhPmaLeeUBPsLU/QXbU0zSRQAti3jGkfvfEz3RlpseBJ4FInaw=
Received: from BY1PR04MB9561.namprd04.prod.outlook.com (2603:10b6:a03:5b6::11)
 by CO6PR04MB7651.namprd04.prod.outlook.com (2603:10b6:303:a5::17)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.451.23; Mon, 28 Sep
 2026 01:39:39 +0000
Received: from BY1PR04MB9561.namprd04.prod.outlook.com
 ([fe80::3869:e494:2fa8:9888]) by BY1PR04MB9561.namprd04.prod.outlook.com
 ([fe80::3869:e494:2fa8:9888%6]) with mapi id 15.21.0451.022; Mon, 28 Sep 2026
 01:39:39 +0000
From: Alistair Francis <Alistair.Francis@wdc.com>
To: "marcandre.lureau@redhat.com" <marcandre.lureau@redhat.com>,
 "palmer@dabbelt.com" <palmer@dabbelt.com>, "pbonzini@redhat.com"
 <pbonzini@redhat.com>, "pierrick.bouvier@oss.qualcomm.com"
 <pierrick.bouvier@oss.qualcomm.com>, "farosas@suse.de" <farosas@suse.de>,
 "visitorckw@gmail.com" <visitorckw@gmail.com>, "lvivier@redhat.com"
 <lvivier@redhat.com>
CC: "wxchen0913@gmail.com" <wxchen0913@gmail.com>, "marscheng@google.com"
 <marscheng@google.com>, "portias@oss.tenstorrent.com"
 <portias@oss.tenstorrent.com>, "daniel.barboza@oss.qualcomm.com"
 <daniel.barboza@oss.qualcomm.com>, "jserv@ccns.ncku.edu.tw"
 <jserv@ccns.ncku.edu.tw>, "qemu-devel@nongnu.org" <qemu-devel@nongnu.org>,
 "chao.liu@processmission.com" <chao.liu@processmission.com>,
 "zhiwei_liu@linux.alibaba.com" <zhiwei_liu@linux.alibaba.com>,
 "qemu-riscv@nongnu.org" <qemu-riscv@nongnu.org>, "eleanor15x@gmail.com"
 <eleanor15x@gmail.com>, "liwei1518@gmail.com" <liwei1518@gmail.com>
Subject: Re: [PATCH v5 2/7] hw/misc: Add Sophgo CV1800B clock controller
Thread-Topic: [PATCH v5 2/7] hw/misc: Add Sophgo CV1800B clock controller
Thread-Index: AQHdTrzBuc3AddTsfECOg1s18BJjULbjNvgA
Date: Mon, 28 Sep 2026 01:39:38 +0000
Message-ID: <078888af41bcf5671d9f81693b045842caba535b.camel@wdc.com>
References: <20260927201326.650943-1-visitorckw@gmail.com>
 <20260927201326.650943-3-visitorckw@gmail.com>
In-Reply-To: <20260927201326.650943-3-visitorckw@gmail.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
user-agent: Evolution 3.62.0 (by Flathub.org) 
authentication-results: mx.microsoft.com 1; dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=wdc.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: BY1PR04MB9561:EE_|CO6PR04MB7651:EE_
x-ms-office365-filtering-correlation-id: ef85684d-5b75-46f0-62e0-08df1d015c47
wdcipoutbound: EOP-TRUE
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
 ARA:13230040|366016|376014|7416014|23010399003|1800799024|19092799006|10070799003|38070700021|4143699003|6133799003|10067099003|260925021311599003|260925022911599003|260925021911599003|56012099006|5023799004|11063799006|22082099003|18002099003;
x-microsoft-antispam-message-info: xIKsUlg7mfwmm+WEdP+FLnBXWjLXTZHbtCk8QqcvtOokKUPaP3vRzo11cdZUcRCT38rvaDXqptrDR/GkbGpj58+6bGTJg5/XPTzst1aOSpq+xELgJfkUllmyPU3TMgf1LgVxs3AdgOsAjcGDxvhLfypQRBI7qnBO2ru11jU/mCNGS83aWSDpzn12exfyT+NZGnmcWD5pdlOmLUbINbXbidceARwLEx5X/VCWMelzZgYNpRYfCDSFuw5dGd3XuFa2CpTtOcxhTMZh1r1Otis8/Tgo8LsfER6sY+RoQGXMXfHCtuQI39OI98PJN4C6YwH14rrDHDLxnRvuAgxc2QDQtyHsa4jW2Uu40G+DlN+hOlQby/uc+8GMF14MAXafzu7C/zXVjr1DAvvaHIY8emkXpKl6RCwTGcY7SGwlfigI01cbrzc7MFRh/McpgqjunH7l9FrrZECDjZWQRS/krOIJKQbbX8a+0mo5iKWlD/iUZj7HWrc+/BWaTZsSfJOZc48QZJkd4v2Dz+Bx9hLkGZ+m+Vh07xDhdBHMYRKHY4VM/UEmxlYb0Fd0zt0rhw9RjtDx2k7e1DQX1Yil5R6Kw+8iODfe1PiSjJs1LnNboOUw6kIQqKAZ66MSyFY9V698r7NMZL0i8+01YcgcsHd+/7fIZECbRU107WVCbus5VXSTHAio6IgFl011h0mVGGqhNn9hnQWFB6mBrbf8lInem0GdL6FuuOqG9ek3Jc96EtjB/zE=
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:BY1PR04MB9561.namprd04.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(366016)(376014)(7416014)(23010399003)(1800799024)(19092799006)(10070799003)(38070700021)(4143699003)(6133799003)(10067099003)(260925021311599003)(260925022911599003)(260925021911599003)(56012099006)(5023799004)(11063799006)(22082099003)(18002099003);
 DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 2
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?M2FnYU9EeEdTWVlZNmV0T0hGKzBSK1RTRmFicUprcDRyd0JHTUxpeTk1NlUv?=
 =?utf-8?B?L3pFaU5kVkY1bFZlTlZWSnhwUmtWcHhnUHpiTnF5bStxWmwyM20yemxaV1dU?=
 =?utf-8?B?TmRjRU1sMnliZGI2QlllTU1sdkhzVlYwdUxqYmxSZlFVTWtXUlIvQkduWGJh?=
 =?utf-8?B?V3ZOWVgzN0NZbFY0eklhS2ljUzhIc2J3UGtNUjlUL210Uko0dmMvRlFxYjlP?=
 =?utf-8?B?R0owUEtlSEl2WUw2TmVLOGkrRldqbDZPUHc5azE5enViQVZWenp5Y0xYclJZ?=
 =?utf-8?B?dTlkbkZvaGQ3cTdUdDZHMjg0bTV2UUN0ZnN1alhrYUlranNBVkc1WDBzMjh6?=
 =?utf-8?B?K3hrUlBaNm1UNS9aZzUzQUtiSmpxZlNNNlFVL3BlL09STjJ0c3pyNUJxYjVR?=
 =?utf-8?B?NExaL2Zyc0laN3lBdHBlSVVCdk9LMHhET1dpclo3MG9ZdzliSzdmRC9NdHI4?=
 =?utf-8?B?NnlaYjdwNzVJZVBBdFJZL1JxaXlGeGZWL2JQQ0lJRTd1QzhtSER1YUc4T3U3?=
 =?utf-8?B?bEdmV29TQllXU1J4bzJUWjJEU1pmazJyc0xFL3ZVRThmWi9VajI4eFlwTEdR?=
 =?utf-8?B?aGRHL0d5WVJOR2YwaGxWZEpqaE9raDBUTmdWK0VTYTJLZ2pqUjBrT1czWVBI?=
 =?utf-8?B?SnlYNWJ0dnRVaWwrV2t1RDd4Q21LSGNmTWVPL1VHUEYzUjZIRXpRS0tBWTdU?=
 =?utf-8?B?Y09laTRXcDlmN3RMU0VXeXFzeW1ZYVZuYWZHNlJ0OXowcm5ocUpUdnFmUERi?=
 =?utf-8?B?UWIzTUdKVGNyR2lxdnRtai9DSUVOWW50Q3Z6MjQ2c0loREtvdWhZcEhBVHRv?=
 =?utf-8?B?SFVCUTJMZkVLM0ZzYVp4bSswdFlFcFFVc3lmRWJtZy9oQUpWUHRTQmdFNUJh?=
 =?utf-8?B?Umt0Z2pEekJYbWJabUozOG11RDlUS3ZLcFRYTGZrU0YxU0VJU0hqOTkvYVd0?=
 =?utf-8?B?VStlTUtZRTN2L3BiTjlUc253dGJDb0tBdXU3YlVCRUFISFZCaTYwM3B2MUh5?=
 =?utf-8?B?WmpIVGVMVC9mVTRTWngxM2FzS2h2OFF1a0Q5bVg1bG1KclRtdU9yR1BuNktn?=
 =?utf-8?B?d1pDRmgyOXlGRTRtMHhBbm9MUG5DYkw4QnArUDJGK2JtSHNaK3A5bmU0OWU4?=
 =?utf-8?B?MjRrMDR1MWRJQUhQRXdVYlZRclBLdkhRcmRNRGZkcS9mSmNhSzlTZTFwTWtX?=
 =?utf-8?B?Q21RVHEzM3hqUFNVRzZGTlRVdTlSZEJZV2RnQ1VWTVhqcmMzQ2lCVVNHeUg0?=
 =?utf-8?B?bnZjTGNmTDhVamhCT1dEcjZsZlhwbFpmM0Z6UmtFcG1MVTJZQXhoSnV0U3F2?=
 =?utf-8?B?Y1ZpWDhaNkVzNEt4TWZCS1BlVXRQQUtnTG4rQWVJL2hnTDU5RnhVYjNkd1c1?=
 =?utf-8?B?VEQ4eUFRV1NQZlYwWTludmlmbG4vR2ZyWTgrVklrWXJXc2VwZXpYUUtuK21s?=
 =?utf-8?B?VVVodTltQ01IcGJWL2VOVDRFVUZVMnJqUzIvMGZFV0hZa0JSbm5wbDdpQ0Y1?=
 =?utf-8?B?dTc5dmNrUGhEUmpkRWlFV2VUbW5CaHRFbUVFZ0l3TmxlYUpuYnF1KzFIWmQ0?=
 =?utf-8?B?dmhuSmFSL29kaGp3NTN6a1p3c2VrYWtaY245ZVcyeGt0S2dBekRRbElTcHdN?=
 =?utf-8?B?NWRjT1M4d2toL2RtUXhIVVJKUElpalhxV1p5ZnpPMllYUVFEWVVaRTV1V1lZ?=
 =?utf-8?B?MitQMUNwU0VRbTVRRUxmMVYyekpEL2RycStneTlvRWF4VUV6b0tvN1J0eVNI?=
 =?utf-8?B?Sk1jaUVjU21scHpKZEFxSDNWYmZJRHhVR3RBY3FrSVdtZTBKQzRJK0NZUmRS?=
 =?utf-8?B?KzlhU1JWeGlmTTlObG1FcXdkN1IwTmRZK1ducDc2Skt2b3NMbVpucWlITHBP?=
 =?utf-8?B?c0xsNUVOVVdmRDlFRlFLdm1DOW5UMEZXYVlTQXpqU0ZmQWdVRzU1aU5zMkdk?=
 =?utf-8?B?NlRPbHMzaWZHbmRUVDRDNzd1OVZQWThtSjlQVU9ZUFJ5OTl1WjJXZktEcVB3?=
 =?utf-8?B?VHc5NGtZUnlMSVdiSUxKc1JRZVhhV1J2RFdvcFZTMUxsZURZVkJBWGYvWE9M?=
 =?utf-8?B?OWpHSkpveXhpM3E1WXFQWkV4a1UxeWJHK0t6Q1FaM2FIOXZGRGhGb0x2eXNw?=
 =?utf-8?B?TFU3UWhCZEV2UDYyK0I2eDA2WkZCc2hQWlhBY0V5dFloWWJDSkhQMGsyKy9p?=
 =?utf-8?B?TzIyM3dENkpveXVCOE1sZzBZNWQvclZuMnRaWkgwa3Jua2YzcUFkVVJHeGxS?=
 =?utf-8?B?c3oyODlZL3hHQlVnNUJHZzlYMXpIYWFTaWFINGMxVWxxazBtclhUNHRWdk1Z?=
 =?utf-8?B?UWNGMEZDcHNkNXAxVmYyNVNEUndCa0NBbVR6WUJVQ094c1hnK0RQUFFYTWJS?=
 =?utf-8?Q?7iPCrZR0ovYJFO/J9qIdLslHXH5u6GLWbJvfGaYJg1ryT?=
x-ms-exchange-antispam-messagedata-1: xUq7yOPaHEroxKbURxdGpmw6NuDrxhGnq48=
Content-Type: text/plain; charset="utf-8"
Content-ID: <22B5939E1D8D474C91F7B17A80131277@namprd04.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-Exchange-RoutingPolicyChecked: i5VoqonDzQhFMI4YsXvYlFSHYdttrBYZ9RjI1JC8YHG/52fGjn8dRKbbDCs3S4oRXmFeyVLiv8NpG9rciNf6Xlula8raxPj2Y1af/rCfuemqwJwVzqnWREITwt5lOkPtJgWh7wMxWHZQD91ZyO2Qmz8DwZ/53y5O6iNc339IanJSFHkit+VNTJ9F07cHnEXKRZx1yLSgH2Q5vasmjT4fNPbzOqHoGZ/iZifTvEpLEv3e+EltdJ8IthVf5zAuszBidIFzJv4uh08tXIQkU1vE+xajZTFoaZcpUnLlvA9zwZDEfbddK2YxUYSQQEzXC0YHITak+R5sEpYMPT/rQ+c7fQ==
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: sPQnFzlkKc/BSQZ4Mtoo0DrKQQNJ+HU/CJPxtEVs53Z8Jwkg2pnflxQknWzfkPZCg9qbU6h0QItiaO/pwrRU3LZWKwHtbylKOE12YUpj7l5zbnEPawUsrRHupp6Ky/g0phECxQpP3nhNxGbu5IlUuQyO39koVKMw5zK5RH5X8WAp4xireqWue3Z3gzri7PVixDS/X6kXKpzTgWzBtAn569mXrNoovem1651VpRcXU7/RRHlQbcrpYcMvF5qvuHETQ6aQvuUjLvWLb3z8mOu5fkO20bnYl0K8Bso3BH3n1xwGdUOFC/SHQCEJ73ObfqEJ2JcowZGq2Yxe39PqJOHHW/yWPfTtiY4HHKh+aI+S0gCXmDKH8iq+tVTF1baX9UkBn09uVaVB6c1EeF9aWvm8pWJPRGjzSuV0HJ+LYrCpY1d9Gh4GOG2ppk7gLQIHjeIASZ4AZ7Du5SKzYwX2b1GaNLBm4a0TetLm17nSYooQGrbNUVLefWcKsJZLwH/CYIBrO5H7XYB3xSTby6HOp/vXgLkW7HhA2yaKbiJYcSRQ2SWMCLVR4RxXLi9dSU7plJV5z8gxD9N5Z2VVOlZVK17uiHWzdMWVxaZnclP+gPruLq9hdM6WvdiUHlLgy1N8E9kU
X-OriginatorOrg: wdc.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: BY1PR04MB9561.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: ef85684d-5b75-46f0-62e0-08df1d015c47
X-MS-Exchange-CrossTenant-originalarrivaltime: 28 Sep 2026 01:39:38.9678 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: b61c8803-16f3-4c35-9b17-6f65f441df86
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: tC2AxhIiYmLs/AgA2fdve3L4Bqc84uZ45nAtIOv8FROPhZFn6+hAYauz7np+pcKwtUOP0AT8vtXZkfvzHKjyX7B9PIfz3B5pxnCJxYAEvLE=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CO6PR04MB7651
Received-SPF: pass client-ip=216.71.154.42;
 envelope-from=prvs=724888370=Alistair.Francis@wdc.com;
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

T24gU3VuLCAyMDI2LTA5LTI3IGF0IDIwOjEzICswMDAwLCBLdWFuLVdlaSBDaGl1IHdyb3RlOg0K
PiBBZGQgYSBzdHViIGZvciB0aGUgQ1YxODAwQiBjbG9jayBjb250cm9sbGVyLiBUaGlzIGlzIHNw
ZWNpZmljYWxseQ0KPiByZXF1aXJlZCBmb3IgdGhlIFNESENJIGNvbnRyb2xsZXIgdG8gZnVuY3Rp
b24gY29ycmVjdGx5IHVuZGVyIExpbnV4Lg0KPiANCj4gVGhlIExpbnV4ICdzb3BoZ28sY3YxODAw
LWNsaycgZHJpdmVyIHByb2JlcyB0aGlzIGRldmljZSB0byBkZXRlcm1pbmUNCj4gdGhlIGNsb2Nr
IHRyZWUgY29uZmlndXJhdGlvbi4gVGhpcyBpbXBsZW1lbnRhdGlvbiBzZXRzIHRoZSBieXBhc3MN
Cj4gcmVnaXN0ZXJzIChDTEtfQllQXzAgYW5kIENMS19CWVBfMSkgdG8gMHhGRkZGRkZGRiBkdXJp
bmcgcmVzZXQsDQo+IG1hdGNoaW5nIHRoZSBQT1IgZGVmYXVsdCBzdGF0ZS4gVGhpcyBieXBhc3Nl
cyB0aGUgUExMcyBhbmQgYWxsb3dzIHRoZQ0KPiBTREhDSSBhbmQgb3RoZXIgcGVyaXBoZXJhbHMg
dG8gb3BlcmF0ZSB1c2luZyB0aGUgMjVNSHogcmVmZXJlbmNlDQo+IGNsb2NrLg0KPiANCj4gV2l0
aG91dCB0aGlzIGRldmljZSwgdGhlIFNEIGNhcmQgZHJpdmVyIGZhaWxzIHRvIGluaXRpYWxpemUs
DQo+IHByZXZlbnRpbmcNCj4gdGhlIHN5c3RlbSBmcm9tIG1vdW50aW5nIHRoZSByb290IGZpbGVz
eXN0ZW0gZnJvbSB0aGUgU0QgY2FyZC4NCj4gDQo+IFNpZ25lZC1vZmYtYnk6IEt1YW4tV2VpIENo
aXUgPHZpc2l0b3Jja3dAZ21haWwuY29tPg0KDQpBY2tlZC1ieTogQWxpc3RhaXIgRnJhbmNpcyA8
YWxpc3RhaXIuZnJhbmNpc0B3ZGMuY29tPg0KDQpBbGlzdGFpcg0KDQo+IC0tLQ0KPiDCoGh3L21p
c2MvS2NvbmZpZ8KgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqAgfMKgIDMgKysNCj4gwqBody9t
aXNjL2N2MTgwMGJfY2xrLmPCoMKgwqDCoMKgwqDCoMKgIHwgOTgNCj4gKysrKysrKysrKysrKysr
KysrKysrKysrKysrKysrKysrKysNCj4gwqBody9taXNjL21lc29uLmJ1aWxkwqDCoMKgwqDCoMKg
wqDCoMKgwqAgfMKgIDEgKw0KPiDCoGluY2x1ZGUvaHcvbWlzYy9jdjE4MDBiX2Nsay5oIHwgMjYg
KysrKysrKysrKw0KPiDCoDQgZmlsZXMgY2hhbmdlZCwgMTI4IGluc2VydGlvbnMoKykNCj4gwqBj
cmVhdGUgbW9kZSAxMDA2NDQgaHcvbWlzYy9jdjE4MDBiX2Nsay5jDQo+IMKgY3JlYXRlIG1vZGUg
MTAwNjQ0IGluY2x1ZGUvaHcvbWlzYy9jdjE4MDBiX2Nsay5oDQo+IA0KPiBkaWZmIC0tZ2l0IGEv
aHcvbWlzYy9LY29uZmlnIGIvaHcvbWlzYy9LY29uZmlnDQo+IGluZGV4IDQ2ZTNjMDNjYzguLjdh
YmQyMjg2OWEgMTAwNjQ0DQo+IC0tLSBhL2h3L21pc2MvS2NvbmZpZw0KPiArKysgYi9ody9taXNj
L0tjb25maWcNCj4gQEAgLTI2Myw0ICsyNjMsNyBAQCBjb25maWcgQVhJQURPX0NMSw0KPiDCoGNv
bmZpZyBLMjMwX0RFQ09NUF9HWklQDQo+IMKgwqDCoMKgIGJvb2wNCj4gwqANCj4gK2NvbmZpZyBT
T1BIR09fQ1YxODAwQl9DTEsNCj4gK8KgwqDCoCBib29sDQo+ICsNCj4gwqBzb3VyY2UgbWFjaW8v
S2NvbmZpZw0KPiBkaWZmIC0tZ2l0IGEvaHcvbWlzYy9jdjE4MDBiX2Nsay5jIGIvaHcvbWlzYy9j
djE4MDBiX2Nsay5jDQo+IG5ldyBmaWxlIG1vZGUgMTAwNjQ0DQo+IGluZGV4IDAwMDAwMDAwMDAu
LjM4ODA3OTk1YWMNCj4gLS0tIC9kZXYvbnVsbA0KPiArKysgYi9ody9taXNjL2N2MTgwMGJfY2xr
LmMNCj4gQEAgLTAsMCArMSw5OCBAQA0KPiArLyogU1BEWC1MaWNlbnNlLUlkZW50aWZpZXI6IEdQ
TC0yLjAtb3ItbGF0ZXIgKi8NCj4gKy8qDQo+ICsgKiBTb3BoZ28gQ1YxODAwQiBDbG9jayBDb250
cm9sbGVyDQo+ICsgKg0KPiArICogQ29weXJpZ2h0IChjKSAyMDI2IEt1YW4tV2VpIENoaXUgPHZp
c2l0b3Jja3dAZ21haWwuY29tPg0KPiArICovDQo+ICsNCj4gKyNpbmNsdWRlICJxZW11L29zZGVw
LmgiDQo+ICsjaW5jbHVkZSAicWVtdS9sb2cuaCINCj4gKyNpbmNsdWRlICJody9taXNjL2N2MTgw
MGJfY2xrLmgiDQo+ICsNCj4gKyNkZWZpbmUgUkVHX0JZVEVfV0lEVEjCoMKgwqAgKHNpemVvZih1
aW50MzJfdCkpDQo+ICsjZGVmaW5lIFJFR19DTEtfQllQXzDCoMKgwqDCoCAoMHgwMzAgLyBSRUdf
QllURV9XSURUSCkNCj4gKyNkZWZpbmUgUkVHX0NMS19CWVBfMcKgwqDCoMKgICgweDAzNCAvIFJF
R19CWVRFX1dJRFRIKQ0KPiArDQo+ICtzdGF0aWMgdWludDY0X3QgY3YxODAwYl9jbGtfcmVhZCh2
b2lkICpvcGFxdWUsIGh3YWRkciBhZGRyLCB1bnNpZ25lZA0KPiBpbnQgc2l6ZSkNCj4gK3sNCj4g
K8KgwqDCoCBDVjE4MDBCQ2xrU3RhdGUgKnMgPSBvcGFxdWU7DQo+ICvCoMKgwqAgdWludDMyX3Qg
dmFsID0gMDsNCj4gKw0KPiArwqDCoMKgIGlmIChhZGRyIDwgQ1YxODAwQl9DTEtfSU9TSVpFKSB7
DQo+ICvCoMKgwqDCoMKgwqDCoCB2YWwgPSBzLT5yZWdzW2FkZHIgLyBSRUdfQllURV9XSURUSF07
DQo+ICvCoMKgwqAgfSBlbHNlIHsNCj4gK8KgwqDCoMKgwqDCoMKgIHFlbXVfbG9nX21hc2soTE9H
X0dVRVNUX0VSUk9SLA0KPiArwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDC
oMKgICIlczogT3V0LW9mLWJvdW5kcyByZWFkIGF0IG9mZnNldCAweCUiDQo+IEhXQUREUl9QUkl4
ICJcbiIsDQo+ICvCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqAgX19m
dW5jX18sIGFkZHIpOw0KPiArwqDCoMKgIH0NCj4gKw0KPiArwqDCoMKgIHJldHVybiB2YWw7DQo+
ICt9DQo+ICsNCj4gK3N0YXRpYyB2b2lkIGN2MTgwMGJfY2xrX3dyaXRlKHZvaWQgKm9wYXF1ZSwg
aHdhZGRyIGFkZHIsIHVpbnQ2NF90DQo+IHZhbCwgdW5zaWduZWQgaW50IHNpemUpDQo+ICt7DQo+
ICvCoMKgwqAgQ1YxODAwQkNsa1N0YXRlICpzID0gb3BhcXVlOw0KPiArDQo+ICvCoMKgwqAgaWYg
KGFkZHIgPCBDVjE4MDBCX0NMS19JT1NJWkUpIHsNCj4gK8KgwqDCoMKgwqDCoMKgIHMtPnJlZ3Nb
YWRkciAvIFJFR19CWVRFX1dJRFRIXSA9IHZhbDsNCj4gK8KgwqDCoCB9IGVsc2Ugew0KPiArwqDC
oMKgwqDCoMKgwqAgcWVtdV9sb2dfbWFzayhMT0dfR1VFU1RfRVJST1IsDQo+ICvCoMKgwqDCoMKg
wqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqAgIiVzOiBPdXQtb2YtYm91bmRzIHdyaXRl
IGF0IG9mZnNldCAweCUiDQo+IEhXQUREUl9QUkl4ICJcbiIsDQo+ICvCoMKgwqDCoMKgwqDCoMKg
wqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqAgX19mdW5jX18sIGFkZHIpOw0KPiArwqDCoMKgIH0N
Cj4gK30NCj4gKw0KPiArc3RhdGljIGNvbnN0IE1lbW9yeVJlZ2lvbk9wcyBjdjE4MDBiX2Nsa19v
cHMgPSB7DQo+ICvCoMKgwqAgLnJlYWQgPSBjdjE4MDBiX2Nsa19yZWFkLA0KPiArwqDCoMKgIC53
cml0ZSA9IGN2MTgwMGJfY2xrX3dyaXRlLA0KPiArwqDCoMKgIC5lbmRpYW5uZXNzID0gREVWSUNF
X0xJVFRMRV9FTkRJQU4sDQo+ICvCoMKgwqAgLnZhbGlkID0gew0KPiArwqDCoMKgwqDCoMKgwqAg
Lm1pbl9hY2Nlc3Nfc2l6ZSA9IDQsDQo+ICvCoMKgwqDCoMKgwqDCoCAubWF4X2FjY2Vzc19zaXpl
ID0gNCwNCj4gK8KgwqDCoCB9LA0KPiArfTsNCj4gKw0KPiArc3RhdGljIHZvaWQgY3YxODAwYl9j
bGtfcmVzZXRfaG9sZChPYmplY3QgKm9iaiwgUmVzZXRUeXBlIHR5cGUpDQo+ICt7DQo+ICvCoMKg
wqAgQ1YxODAwQkNsa1N0YXRlICpzID0gQ1YxODAwQl9DTEsob2JqKTsNCj4gKw0KPiArwqDCoMKg
IG1lbXNldChzLT5yZWdzLCAwLCBzaXplb2Yocy0+cmVncykpOw0KPiArDQo+ICvCoMKgwqAgLyoN
Cj4gK8KgwqDCoMKgICogVE9ETzogSW1wbGVtZW50IHByb3BlciBQTEwgc3RhdGUgbWFjaGluZXMu
DQo+ICvCoMKgwqDCoCAqIEZvciBub3csIHVzZSBQT1IgZGVmYXVsdCB0byBieXBhc3MgUExMcyBh
bmQgYm9vdCB2aWEgMjVNSHoNCj4gWFRBTC4NCj4gK8KgwqDCoMKgICovDQo+ICvCoMKgwqAgcy0+
cmVnc1tSRUdfQ0xLX0JZUF8wXSA9IDB4RkZGRkZGRkY7DQo+ICvCoMKgwqAgcy0+cmVnc1tSRUdf
Q0xLX0JZUF8xXSA9IDB4RkZGRkZGRkY7DQo+ICt9DQo+ICsNCj4gK3N0YXRpYyB2b2lkIGN2MTgw
MGJfY2xrX2luaXQoT2JqZWN0ICpvYmopDQo+ICt7DQo+ICvCoMKgwqAgQ1YxODAwQkNsa1N0YXRl
ICpzID0gQ1YxODAwQl9DTEsob2JqKTsNCj4gKw0KPiArwqDCoMKgIG1lbW9yeV9yZWdpb25faW5p
dF9pbygmcy0+aW9tZW0sIG9iaiwgJmN2MTgwMGJfY2xrX29wcywgcywNCj4gK8KgwqDCoMKgwqDC
oMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoCBUWVBFX0NWMTgwMEJf
Q0xLLCBDVjE4MDBCX0NMS19JT1NJWkUpOw0KPiArwqDCoMKgIHN5c2J1c19pbml0X21taW8oU1lT
X0JVU19ERVZJQ0Uob2JqKSwgJnMtPmlvbWVtKTsNCj4gK30NCj4gKw0KPiArc3RhdGljIHZvaWQg
Y3YxODAwYl9jbGtfY2xhc3NfaW5pdChPYmplY3RDbGFzcyAqa2xhc3MsIGNvbnN0IHZvaWQNCj4g
KmRhdGEpDQo+ICt7DQo+ICvCoMKgwqAgUmVzZXR0YWJsZUNsYXNzICpyYyA9IFJFU0VUVEFCTEVf
Q0xBU1Moa2xhc3MpOw0KPiArDQo+ICvCoMKgwqAgcmMtPnBoYXNlcy5ob2xkID0gY3YxODAwYl9j
bGtfcmVzZXRfaG9sZDsNCj4gK30NCj4gKw0KPiArc3RhdGljIGNvbnN0IFR5cGVJbmZvIGN2MTgw
MGJfY2xrX2luZm8gPSB7DQo+ICvCoMKgwqAgLm5hbWUgPSBUWVBFX0NWMTgwMEJfQ0xLLA0KPiAr
wqDCoMKgIC5wYXJlbnQgPSBUWVBFX1NZU19CVVNfREVWSUNFLA0KPiArwqDCoMKgIC5pbnN0YW5j
ZV9zaXplID0gc2l6ZW9mKENWMTgwMEJDbGtTdGF0ZSksDQo+ICvCoMKgwqAgLmluc3RhbmNlX2lu
aXQgPSBjdjE4MDBiX2Nsa19pbml0LA0KPiArwqDCoMKgIC5jbGFzc19pbml0ID0gY3YxODAwYl9j
bGtfY2xhc3NfaW5pdCwNCj4gK307DQo+ICsNCj4gK3N0YXRpYyB2b2lkIGN2MTgwMGJfY2xrX3Jl
Z2lzdGVyX3R5cGVzKHZvaWQpDQo+ICt7DQo+ICvCoMKgwqAgdHlwZV9yZWdpc3Rlcl9zdGF0aWMo
JmN2MTgwMGJfY2xrX2luZm8pOw0KPiArfQ0KPiArDQo+ICt0eXBlX2luaXQoY3YxODAwYl9jbGtf
cmVnaXN0ZXJfdHlwZXMpDQo+IGRpZmYgLS1naXQgYS9ody9taXNjL21lc29uLmJ1aWxkIGIvaHcv
bWlzYy9tZXNvbi5idWlsZA0KPiBpbmRleCA5NzkwYWZhMTA0Li4yNDRiZjI3OGE5IDEwMDY0NA0K
PiAtLS0gYS9ody9taXNjL21lc29uLmJ1aWxkDQo+ICsrKyBiL2h3L21pc2MvbWVzb24uYnVpbGQN
Cj4gQEAgLTM5LDYgKzM5LDcgQEAgc3lzdGVtX3NzLmFkZCh3aGVuOiAnQ09ORklHX1NJRklWRV9F
X0FPTicsIGlmX3RydWU6DQo+IGZpbGVzKCdzaWZpdmVfZV9hb24uYycpKQ0KPiDCoHN5c3RlbV9z
cy5hZGQod2hlbjogJ0NPTkZJR19TSUZJVkVfVV9PVFAnLCBpZl90cnVlOg0KPiBmaWxlcygnc2lm
aXZlX3Vfb3RwLmMnKSkNCj4gwqBzeXN0ZW1fc3MuYWRkKHdoZW46ICdDT05GSUdfU0lGSVZFX1Vf
UFJDSScsIGlmX3RydWU6DQo+IGZpbGVzKCdzaWZpdmVfdV9wcmNpLmMnKSkNCj4gwqBzeXN0ZW1f
c3MuYWRkKHdoZW46ICdDT05GSUdfSzIzMF9ERUNPTVBfR1pJUCcsIGlmX3RydWU6DQo+IGZpbGVz
KCdrMjMwX2RlY29tcF9nemlwLmMnKSkNCj4gK3N5c3RlbV9zcy5hZGQod2hlbjogJ0NPTkZJR19T
T1BIR09fQ1YxODAwQl9DTEsnLCBpZl90cnVlOg0KPiBmaWxlcygnY3YxODAwYl9jbGsuYycpKQ0K
PiDCoA0KPiDCoHN1YmRpcignbWFjaW8nKQ0KPiDCoA0KPiBkaWZmIC0tZ2l0IGEvaW5jbHVkZS9o
dy9taXNjL2N2MTgwMGJfY2xrLmgNCj4gYi9pbmNsdWRlL2h3L21pc2MvY3YxODAwYl9jbGsuaA0K
PiBuZXcgZmlsZSBtb2RlIDEwMDY0NA0KPiBpbmRleCAwMDAwMDAwMDAwLi40ZDAzZDg4N2M2DQo+
IC0tLSAvZGV2L251bGwNCj4gKysrIGIvaW5jbHVkZS9ody9taXNjL2N2MTgwMGJfY2xrLmgNCj4g
QEAgLTAsMCArMSwyNiBAQA0KPiArLyogU1BEWC1MaWNlbnNlLUlkZW50aWZpZXI6IEdQTC0yLjAt
b3ItbGF0ZXIgKi8NCj4gKy8qDQo+ICsgKiBTb3BoZ28gQ1YxODAwQiBDbG9jayBDb250cm9sbGVy
DQo+ICsgKg0KPiArICogQ29weXJpZ2h0IChjKSAyMDI2IEt1YW4tV2VpIENoaXUgPHZpc2l0b3Jj
a3dAZ21haWwuY29tPg0KPiArICovDQo+ICsNCj4gKyNpZm5kZWYgSFdfTUlTQ19DVjE4MDBCX0NM
S19IDQo+ICsjZGVmaW5lIEhXX01JU0NfQ1YxODAwQl9DTEtfSA0KPiArDQo+ICsjaW5jbHVkZSAi
aHcvY29yZS9zeXNidXMuaCINCj4gKyNpbmNsdWRlICJxb20vb2JqZWN0LmgiDQo+ICsNCj4gKyNk
ZWZpbmUgVFlQRV9DVjE4MDBCX0NMSyAiY3YxODAwYi1jbGsiDQo+ICtPQkpFQ1RfREVDTEFSRV9T
SU1QTEVfVFlQRShDVjE4MDBCQ2xrU3RhdGUsIENWMTgwMEJfQ0xLKQ0KPiArDQo+ICsjZGVmaW5l
IENWMTgwMEJfQ0xLX0lPU0laRSAweDEwMDANCj4gKw0KPiArc3RydWN0IENWMTgwMEJDbGtTdGF0
ZSB7DQo+ICvCoMKgwqAgU3lzQnVzRGV2aWNlIHBhcmVudF9vYmo7DQo+ICsNCj4gK8KgwqDCoCBN
ZW1vcnlSZWdpb24gaW9tZW07DQo+ICvCoMKgwqAgdWludDMyX3QgcmVnc1tDVjE4MDBCX0NMS19J
T1NJWkUgLyBzaXplb2YodWludDMyX3QpXTsNCj4gK307DQo+ICsNCj4gKyNlbmRpZg0K

