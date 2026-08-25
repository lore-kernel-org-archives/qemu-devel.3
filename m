Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 236B4C5B572
	for <qemu-devel@archiver.kernel.org>; Tue, 25 Aug 2026 04:07:42 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wyiRb-0000Xk-KY; Tue, 25 Aug 2026 00:07:27 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1)
 (envelope-from <prvs=690dc056c=Alistair.Francis@wdc.com>)
 id 1wyiRZ-0000X6-DE; Tue, 25 Aug 2026 00:07:25 -0400
Received: from esa4.hgst.iphmx.com ([216.71.154.42])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1)
 (envelope-from <prvs=690dc056c=Alistair.Francis@wdc.com>)
 id 1wyiRW-00089K-Np; Tue, 25 Aug 2026 00:07:25 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
 d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
 t=1787630842; x=1819166842;
 h=from:to:cc:subject:date:message-id:references:
 in-reply-to:content-id:content-transfer-encoding: mime-version;
 bh=IqbzptGxhqFRcfXG7dQQeyPXiFAIq6SN7AQ4pQ/A1V0=;
 b=EBWNgmhmk3hzZQqra3pKlPy6q8LXGwFG5LmsCsnK2Gz0MUbkHsn6WG/L
 mhabfK/5xB8oAuhVJhLwST9uEINnXaCcM4iae69VOR0TAZQzA4WAGNnwX
 zxeaMXSf7H8sol8IymjtWC4BfOHkywlq1O4taOf3GXuZyW3ncE6ZbS+J0
 d9gvEKt5QE9F7czTTcqSxIHlM47FNN4hxyWx1Citg4Iw71OGNlXFfNrt6
 alope0jsaYxeg70+m/Epp4s+a+x1PWreQXshRVba8SoApWoVPBJEJsWLv
 CFT6eNdBzEBFwch8qv1ZGLqkZJ1m45t9m3lxqLw2c/gnpaHqhwQGHfQJh w==;
X-CSE-ConnectionGUID: p9NE9X2oTUaOwckcr4Ncnw==
X-CSE-MsgGUID: 7IqcHDT5T1+Sy4Cs0NUWbQ==
X-IronPort-AV: E=Sophos;i="6.25,242,1779120000"; d="scan'208";a="150004168"
Received: from mail-eastusazon11012012.outbound.protection.outlook.com (HELO
 BL0PR03CU003.outbound.protection.outlook.com) ([52.101.53.12])
 by ob1.hgst.iphmx.com with ESMTP/TLS/ECDHE-RSA-AES128-GCM-SHA256;
 25 Aug 2026 12:07:19 +0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=dStzvYRay69KxREw/4LwVxL1b8Bvugcw3D/kmwSbwMotJl+4mkUFsxkgPfQAC5sCmjKf3ByqGLCcwpixa72Gs8XBt3KRvjv78i5pjOdBWa4mZe4I79VUmQyCbiwNV7OuMoHcOkqVsCOeM6i3Fnt8xPXmqou21xaeo5mD3GgIFRmHnZCCFUwJbRiTOcyrwbAvYxT/SgDLyAjXTYtZjKeY6egzxQpaCqiudjTwnx9g0r5ZHKbj45TK1S3wSeU9OpOcsnZ7cxt5Hk8yQiUTDTQZ/sCvhvcVTPb/NTNV91RiEg8zxqVEQHkhGrSczcjPLF43/oQowOuqSwU98E0KnuJweQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=IqbzptGxhqFRcfXG7dQQeyPXiFAIq6SN7AQ4pQ/A1V0=;
 b=vvcygQss6JdGPNgVDVGBuXX1bg1BZlonldutwN7H5osIO9x6gVX68zRJTuDevvBAbibVpyYqH5sA6BncDeQ0X2PojLym7/2LYocv0OH0DU/Oc+JRHy/9U/YtaufEMJEgWbYom6aerZGkFiJuyYbJzrPvKkfyqdhw8lIKZFJwG1iykHkixpt1tneAG4ET3kRov7D9u3+eCTjtak5pTrhY7u16p6H9dxkcuLB/6xTu67JpzNOrZ8OomMqqir3CXP4/rx3PJ3esjBUtHSS7cGkHoko8gqO8UFWg9/sDRfI0JD6IihFFQwx5+gNawE8AeP1tzPWToucjYcZEhIUNdcjkrA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=wdc.com; dmarc=pass action=none header.from=wdc.com; dkim=pass
 header.d=wdc.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=sharedspace.onmicrosoft.com; s=selector2-sharedspace-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=IqbzptGxhqFRcfXG7dQQeyPXiFAIq6SN7AQ4pQ/A1V0=;
 b=sNj/Z5Bml051Jp2DbWYLAvNz2Y1u3S8nFq00HW1OSwWUfX0l9SK4qvumjE0l1fRSZH/TOlZs/JB3EBZduhwA+9Q9KG6gWUeRmCZOmHLEsZA0upQZSxM+nZt61gXHwU3FT+CXON6XIiUoYwedGJ40YloqJWlIfvfjXbsRbuPuD/w=
Received: from BY1PR04MB9561.namprd04.prod.outlook.com (2603:10b6:a03:5b6::11)
 by LV0PR04MB9859.namprd04.prod.outlook.com (2603:10b6:408:32a::21)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.339.12; Tue, 25 Aug
 2026 04:07:17 +0000
Received: from BY1PR04MB9561.namprd04.prod.outlook.com
 ([fe80::3869:e494:2fa8:9888]) by BY1PR04MB9561.namprd04.prod.outlook.com
 ([fe80::3869:e494:2fa8:9888%5]) with mapi id 15.21.0360.005; Tue, 25 Aug 2026
 04:07:17 +0000
From: Alistair Francis <Alistair.Francis@wdc.com>
To: "daniel.barboza@oss.qualcomm.com" <daniel.barboza@oss.qualcomm.com>,
 "joel@jms.id.au" <joel@jms.id.au>, "philmd@linaro.org" <philmd@linaro.org>
CC: "qemu-riscv@nongnu.org" <qemu-riscv@nongnu.org>, "npiggin@gmail.com"
 <npiggin@gmail.com>, "mpe@kernel.org" <mpe@kernel.org>,
 "portias@oss.tenstorrent.com" <portias@oss.tenstorrent.com>,
 "qemu-devel@nongnu.org" <qemu-devel@nongnu.org>, "peter.maydell@linaro.org"
 <peter.maydell@linaro.org>, "chao.liu@processmission.com"
 <chao.liu@processmission.com>, "zhiwei_liu@linux.alibaba.com"
 <zhiwei_liu@linux.alibaba.com>, "asrinivasan@oss.tenstorrent.com"
 <asrinivasan@oss.tenstorrent.com>, "liwei1518@gmail.com"
 <liwei1518@gmail.com>, "nieklinnenbank@gmail.com" <nieklinnenbank@gmail.com>, 
 "philmd@mailo.com" <philmd@mailo.com>
Subject: Re: [PATCH 2/4] hw/riscv/virt: Use hwaddr for IMSIC device tree
 address
Thread-Topic: [PATCH 2/4] hw/riscv/virt: Use hwaddr for IMSIC device tree
 address
Thread-Index: AQHdM41uoW9dOD2si02jBWZeYSd5HLauJ1MA
Date: Tue, 25 Aug 2026 04:07:17 +0000
Message-ID: <2491f35d94ee4d77010828383fc13fc8403fe8d8.camel@wdc.com>
References: <20260824055642.41098-1-joel@jms.id.au>
 <20260824055642.41098-3-joel@jms.id.au>
In-Reply-To: <20260824055642.41098-3-joel@jms.id.au>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
user-agent: Evolution 3.60.2 (by Flathub.org) 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=wdc.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: BY1PR04MB9561:EE_|LV0PR04MB9859:EE_
x-ms-office365-filtering-correlation-id: f9671cd9-be36-460d-3c56-08df025e5a4d
wdcipoutbound: EOP-TRUE
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
 ARA:13230040|366016|1800799024|19092799006|376014|10070799003|7416014|23010399003|4143699003|22082099003|18002099003|11063799006|56012099006|38070700021|10067099003;
x-microsoft-antispam-message-info: hqDPrxWz1tIDKqld5waKybt6XGNWGUK93AaXyDjnr0HJNAxTUWTKpXkSULyZjaETo/GBQUrEUyyDOVm8PxlXT6Oats5q9bvl33UI7elBrEjTnh9BW789Z1kpcOu16jVpg3vgy+qfXjmzvApSCaMj2qOwu/hLeXrcUak9NAwws2RXU8aoohGfaJNkdjLSsyjJlCk3N5KFC+z/75V6pyFGeOkDOjl6iGH25Qs3RBB+sKT8tc/Ohu7EppLZRWEUJ91Dde5R23piQeU+PS5FGmSDm0XdaemBObpbOCEe/QUQkDrs5k/9J9D+73GL0hUGIIdVPLFrkfu8O8ceCQPyGDR2LieOdGmzh0Z8sBWss4W342JyIuySjyV7cRcuNFpti2Y939REz/rctp9J8hlDJWJpy2qT+dPQf7XFdXW+pVjK5UXaJNF8Du1rrahnu9tMExPVRFAQj+2CmcxFA7qhBiiVKgRK79gR2r1WuJUrjUI3AQ5qJRgiftAG387AWllD/alb0uR8FKZ6EDT8OJz9yy0yGFZV4etSjuJXjIaXvMXVivEk6/juayTQB8jNny2mW6v1cB9se6u64OndUraA0mNsromuvicU8TUXfmqeBCihyd3OpJxUL+uQ+qk5g978Wz+R7y9Pi7pq/Y6W/z5Oix7pmmJfhxj31L0i6Q8MwmX5cLN4ZbXv5Qnt/q8L/Ras+x5NH2Np5b6hzanERBSlSLQUur0degVWV+afdgKHJdBanSg=
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:BY1PR04MB9561.namprd04.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(366016)(1800799024)(19092799006)(376014)(10070799003)(7416014)(23010399003)(4143699003)(22082099003)(18002099003)(11063799006)(56012099006)(38070700021)(10067099003);
 DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 2
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?TTZaZkZHTnJYQnJVYlRoWnpSQzFXZnRmNmh0eFZyRmM2V01ialIxU2MwcnNT?=
 =?utf-8?B?b2p6cncrTlZocFB6Vld5ekdtQUo3Q25ha1VSK0E0WVVTRjMyNVRiVEdCYmll?=
 =?utf-8?B?UklxUENZUGJkVkhKTXV0T1MyaHRpZ2c5RXlwbmp0cFhTQk1WNWNMYitoU2hq?=
 =?utf-8?B?cUdYbkR5NEJvRnYrREg3dU1tZlFPazhuUlFqRHY5Rk5OTVVlK1V2Z3dMRzdH?=
 =?utf-8?B?a3BXdUgrRVExSWJwdFA2YW5qcERTbUt3VXpoUGVYYW9nMC9oSlB4WXNVeGN3?=
 =?utf-8?B?VUE5STRJZ09JVmQ0M2k0SzNYYzM5Z3QweWp3NUNWL0pIandkV2txRlRXVkVk?=
 =?utf-8?B?VzVNU1NPc0c1SmZ4NEphNFFrU3NYSk51aTdxT1RtZ0IyY20vU2JiWjh5bGxq?=
 =?utf-8?B?RDhqZzd4VW1RTld0aGxGdkk1aVNUWnQ2Z1FXVUNaNDk4MjlONTB5OWxqN2V3?=
 =?utf-8?B?OXpBUGRMbWVER2JvTnBic1VkMFJuZVJEemtnSlM0OFBqanVKc0x2RlFZQ1lo?=
 =?utf-8?B?S3hWSklJdFdHb2NFZ3BNdjUzVXFYSWlCci9vNGxkNVVwblA2WlRST3hUVDZL?=
 =?utf-8?B?dnpSZnpMVDNvRmI1WDMyd0hJTkpFTkFad1IzVmQ4YTgyR2hkRnA5dTdrTEZ4?=
 =?utf-8?B?UWo1MXg4TitnYWlGa1haZ1JIODhWVnNReWdKRXFqSk1IKzFYMVJNUGFmUlpj?=
 =?utf-8?B?MWozTmJXaGprRlc3SThWUEdoMitEU29TMHJRTnlzYm40QkFqaUtkK3FoaTBo?=
 =?utf-8?B?eGdGV0ZrOU5iSDZvV0hxYkFQeExMUmxQZ3U4OVJqNEVlWE9VcjI0eVNSTFBn?=
 =?utf-8?B?QmM0Z0RDRkxaNUV4Q2NkQ2d4cEUvQm9NQTVxRitZSk83U2VLYlY3TmIrMVVr?=
 =?utf-8?B?d2ZROUtZQnFjVnU5eDlCOGtxdVVEbS8yZlprN2VVbTB3eHJrdFhPZU9xWFQv?=
 =?utf-8?B?TGFyaVZOemRLVGRBYkN0ZlRWSjhhQWxTbHJGTk1UNUF2UGc4WDNtcXE0TXd5?=
 =?utf-8?B?dUFwMnArbWs4cWJvd0xKdmJESnQ4eE5MbDE0OC9EMHRDblgwdTVpcDZJSDNT?=
 =?utf-8?B?VllGK1pwdnhYMnFjN29nUm9LeEhyRm52aVdES0lHSHlmTUZ2aHlobk00aGoz?=
 =?utf-8?B?c2l5SjM3ZXFIcWxtanhacXpzcGpkOWx1T20xazVIYjRON1JNOWZHbjdXNTNS?=
 =?utf-8?B?ck10U2MwYTh6eFJRMDVMa0lyL2RrQ0tCTGRVb25laTYzWHBOYUxoZ0Y1eGtV?=
 =?utf-8?B?Z2k4OHdBb2pRdzZLbEpSajY1K1lKeGl1V0lxQkNYMXBFQzlERkdDTjhGbjd5?=
 =?utf-8?B?OTJWckQyUHlTeGQraHE0VFR4WjRIVSt4YjZ1TzE4blhHcDgrcXk3Z2hXdElt?=
 =?utf-8?B?U1VwUWRjZzF2TTVrUGltM1F2aDdPOWFKdkZ3VG0yQVJRSVBhdnMyTHo2SU8y?=
 =?utf-8?B?OFJsVnZLV1BFYUlDRlJwQUQ0dlh0YUptWHpkYk1sRWRXM2VMQlF1a2huUU0x?=
 =?utf-8?B?b3FwQVdNQ016NE9qKzJ6SlRkLzk1SEdweUxaTmdDMUJrQmczZmlIUEVja0Qx?=
 =?utf-8?B?a2VvbmpBbUpBRWpwaXNCQ0RMQUU0S3VMQi9wYWhNZVp2OEJza0Q3UUdWQUE0?=
 =?utf-8?B?dnUxTzF2RHRBK1M0bS9aaVcxU1U2bklYSlFVT0pxekRUVCtXWFZuNi9ISWMz?=
 =?utf-8?B?YmhjSGNVUXR5YWZWdE5MZkJoNHJTcytrR3FiZy9jSUVndHhhb2xKTzJPWnpr?=
 =?utf-8?B?cTFjTzltS3pMUm1DckU2T1RET1lVT01iOHVKQ2hoWXhJdFdCZXhLc2tmUm0w?=
 =?utf-8?B?TFN5NWtVTklDTUhOYVhxTUVLNDZoVk13aXN4TFpUSW1TbGhYSXBUR3NJQ0xV?=
 =?utf-8?B?a2lESUoxNEI3Y0hhcFNVd2NMRDRUOGhRRnYxM0o5S2JvTy9QU2daTjBFcmU2?=
 =?utf-8?B?WmExekpxUlJtbXZpazJnR0FRWlpjSVVqdTRGUGp0eVhkZVJBdE1HVWhtTE9H?=
 =?utf-8?B?aEl0RDlIc3JPM0FNVnZuTGxpQjZRY2ZLYlMwdnRKSEwvR0cyWEFLY1I0QjFE?=
 =?utf-8?B?VklOWDRmMHcrWUJpdXFLVEJhYngwd3JwaEdabUI5OEJNWVhQYUkwNzMvbGdS?=
 =?utf-8?B?VEE4a1VwZVlwNHFxNkxLRXJtL0VpM1RMT0F6cklMemNyKzBZK1RtRXNQNEF0?=
 =?utf-8?B?UDd4b25tNURxT1FXeDhCNm94OEt2REJzdXpGWXpCcTI0TFhnUktmL096eGR4?=
 =?utf-8?B?Y1ByR3F4QVR1L2dCRTdCUkhkVWxoRGc1Mld6enVLTjR2bjRxejY4S3hJbDIw?=
 =?utf-8?B?K0VrQmNJR2VNTWI3ejEvKyt2elQvME9reXNZMEw2N3QrL3BwajlXWkp4NVY4?=
 =?utf-8?Q?p1jMhg1PLE50ZXrofR3PdyN3185AOEKrOAMFwxHSeb6MP?=
x-ms-exchange-antispam-messagedata-1: 8mfmCCW5FMVUcEVdB1wlpGWNiJyKLJa7Yqc=
Content-Type: text/plain; charset="utf-8"
Content-ID: <4BF4F9D22500D441A4DC808EDAFD445D@namprd04.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-Exchange-RoutingPolicyChecked: aOjjm2lQ5x0uIumPCABohTZ1IgaKfZUBF8Ip3mkx2XL9KXVXXrm/MohbtyFWdTUzNwIagovjZjj1l1IBgloi/JHJq+W4G6krbqlAUl8Rumg67rN8SIZY87j01JwaPPJ1ftf3PORw+CrHt6l0IejevcMvqdCQtieJaUX6z6RnSuzfzpXw6j3WLdpqz/TW67VmSRIaRU/UJ5XcvSl/9+YsO5yhUxqcK/RIkn3laaZWEiCiuBHCPfGdkYZlKYL34VAUD+bGbkn6EDqxPwC/mIO3f1juHiBaWoRLHcbf3VtMjFWkQHqbDmPPRvKAc6D9CdoVqML+OSu2K4wOVETbP5FgSQ==
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: pFTNLr5B8oPSLFl2t6aeipko2ok2owNshoZ+yLMKi0QgBzo1VygVIj11JB6H//4yJ/uMNntu2seUl/scs8k4dK/dC34AikPPI7kSNyn7GtKlqKVZ5Vc4z1WmQSRQu0Kyj58LGafVZ/ApZdz4fl+o8SnHcghXXGwcfJutJ7td4cjfrGCwaUC1aMj5SYRzuCxLNFDZJEh1D8r+ngNfItCmpItnKl+/NPHp+NhHkrhWRDwh2/BEd0HHl6XVHBpIkE3Ohmt6CUH02qlQZ+3YPBoPprvoFEaDw/nCWKFLqy8NZxGG5ws5hlQGB/Q0kb8Q67Ksoo6KRu5dsk5mbGvnSFACc1xge2vN9VBM7Xni+K3i1gZuiL3cegfM3BewkR6c7lYuFMbSDmrZ1jbR6kjYOv5UVkND8LGmgSwRA59UWHeJFfoIyFRLyI/45ZqEgRpeh6agoCqybJQTLSulPf/I+KvSUNE+TyCaHyAcB4ungLSuoTVkyjyNE1jLCNxqVnZHQdGsCTXjht1Y54cXu/9MjyJhzIU1Erbh7kYeJ6SfPb/HlY/HDhTgo0PCPhVhG1P/afbvHlYyDj0LrM9JW/BpYB4M0chqNpqk/V9t0+XK1v3hIW3TPgpl5XKFsz775L3B3oPF
X-OriginatorOrg: wdc.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: BY1PR04MB9561.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: f9671cd9-be36-460d-3c56-08df025e5a4d
X-MS-Exchange-CrossTenant-originalarrivaltime: 25 Aug 2026 04:07:17.4677 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: b61c8803-16f3-4c35-9b17-6f65f441df86
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: XJzJ+ayw+AQmP89tIHYTw0HcoP1rlqBUHykn9OsoLVbT5kJBh18+DzneQJW/vfaSXkqc2UH8HB6S0MSDLa0L4cIXfJplMXe6rn56PzUSCck=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: LV0PR04MB9859
Received-SPF: pass client-ip=216.71.154.42;
 envelope-from=prvs=690dc056c=Alistair.Francis@wdc.com;
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

T24gTW9uLCAyMDI2LTA4LTI0IGF0IDE1OjI2ICswOTMwLCBKb2VsIFN0YW5sZXkgd3JvdGU6DQo+
IGNyZWF0ZV9mZHRfb25lX2ltc2ljKCkgaGFyZCBjb2RlcyB0aGUgdG9wIDMyIGJpdHMgdG8gemVy
by4gSW5zdGVhZA0KPiB0YWtlDQo+IGEgaHdhZGRyIGFuZCBwb3B1bGF0ZSBib3RoIHRoZSBoaWdo
IGFuZCBsb3cgY2VsbC4NCj4gDQo+IFN1Z2dlc3RlZC1ieTogUGhpbGlwcGUgTWF0aGlldS1EYXVk
w6kgPHBoaWxtZEBtYWlsby5jb20+DQo+IFNpZ25lZC1vZmYtYnk6IEpvZWwgU3RhbmxleSA8am9l
bEBqbXMuaWQuYXU+DQoNClJldmlld2VkLWJ5OiBBbGlzdGFpciBGcmFuY2lzIDxhbGlzdGFpci5m
cmFuY2lzQHdkYy5jb20+DQoNCkFsaXN0YWlyDQoNCj4gLS0tDQo+IMKgaHcvcmlzY3YvdmlydC5j
IHwgNSArKystLQ0KPiDCoDEgZmlsZSBjaGFuZ2VkLCAzIGluc2VydGlvbnMoKyksIDIgZGVsZXRp
b25zKC0pDQo+IA0KPiBkaWZmIC0tZ2l0IGEvaHcvcmlzY3YvdmlydC5jIGIvaHcvcmlzY3Yvdmly
dC5jDQo+IGluZGV4IGQ1ODY1NmY3MGQxYi4uYjkxZDUwNjZkOGFkIDEwMDY0NA0KPiAtLS0gYS9o
dy9yaXNjdi92aXJ0LmMNCj4gKysrIGIvaHcvcmlzY3YvdmlydC5jDQo+IEBAIC0zODMsNyArMzgz
LDggQEAgc3RhdGljIHZvaWQgY3JlYXRlX2ZkdF9vbmVfaW1zaWMoUklTQ1ZWaXJ0U3RhdGUNCj4g
KnMsIGh3YWRkciBiYXNlX2FkZHIsDQo+IMKgwqDCoMKgIGdfYXV0b2ZyZWUgY2hhciAqaW1zaWNf
bmFtZSA9IE5VTEw7DQo+IMKgwqDCoMKgIE1hY2hpbmVTdGF0ZSAqbXMgPSBNQUNISU5FKHMpOw0K
PiDCoMKgwqDCoCBpbnQgc29ja2V0X2NvdW50ID0gcmlzY3Zfc29ja2V0X2NvdW50KG1zKTsNCj4g
LcKgwqDCoCB1aW50MzJfdCBpbXNpY19tYXhfaGFydF9wZXJfc29ja2V0LCBpbXNpY19hZGRyLCBp
bXNpY19zaXplOw0KPiArwqDCoMKgIHVpbnQzMl90IGltc2ljX21heF9oYXJ0X3Blcl9zb2NrZXQs
IGltc2ljX3NpemU7DQo+ICvCoMKgwqAgaHdhZGRyIGltc2ljX2FkZHI7DQo+IMKgwqDCoMKgIGdf
YXV0b2ZyZWUgdWludDMyX3QgKmltc2ljX2NlbGxzID0gTlVMTDsNCj4gwqDCoMKgwqAgZ19hdXRv
ZnJlZSB1aW50MzJfdCAqaW1zaWNfcmVncyA9IE5VTEw7DQo+IMKgwqDCoMKgIHN0YXRpYyBjb25z
dCBjaGFyICogY29uc3QgaW1zaWNfY29tcGF0WzJdID0gew0KPiBAQCAtNDAzLDcgKzQwNCw3IEBA
IHN0YXRpYyB2b2lkIGNyZWF0ZV9mZHRfb25lX2ltc2ljKFJJU0NWVmlydFN0YXRlDQo+ICpzLCBo
d2FkZHIgYmFzZV9hZGRyLA0KPiDCoMKgwqDCoMKgwqDCoMKgIGltc2ljX2FkZHIgPSBiYXNlX2Fk
ZHIgKyBzb2NrZXQgKiBWSVJUX0lNU0lDX0dST1VQX01BWF9TSVpFOw0KPiDCoMKgwqDCoMKgwqDC
oMKgIGltc2ljX3NpemUgPSBJTVNJQ19IQVJUX1NJWkUoaW1zaWNfZ3Vlc3RfYml0cykgKg0KPiDC
oMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqAgcy0+c29jW3NvY2tldF0u
bnVtX2hhcnRzOw0KPiAtwqDCoMKgwqDCoMKgwqAgaW1zaWNfcmVnc1tzb2NrZXQgKiA0ICsgMF0g
PSAwOw0KPiArwqDCoMKgwqDCoMKgwqAgaW1zaWNfcmVnc1tzb2NrZXQgKiA0ICsgMF0gPSBjcHVf
dG9fYmUzMihpbXNpY19hZGRyID4+IDMyKTsNCj4gwqDCoMKgwqDCoMKgwqDCoCBpbXNpY19yZWdz
W3NvY2tldCAqIDQgKyAxXSA9IGNwdV90b19iZTMyKGltc2ljX2FkZHIpOw0KPiDCoMKgwqDCoMKg
wqDCoMKgIGltc2ljX3JlZ3Nbc29ja2V0ICogNCArIDJdID0gMDsNCj4gwqDCoMKgwqDCoMKgwqDC
oCBpbXNpY19yZWdzW3NvY2tldCAqIDQgKyAzXSA9IGNwdV90b19iZTMyKGltc2ljX3NpemUpOw0K

