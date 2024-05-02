Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 105CCC4345F
	for <qemu-devel@archiver.kernel.org>; Thu,  2 May 2024 15:33:21 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1s2YNH-0003dw-84; Thu, 02 May 2024 11:29:31 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <clement.mathieu--drif@eviden.com>)
 id 1s2YNF-0003dP-Ei
 for qemu-devel@nongnu.org; Thu, 02 May 2024 11:29:29 -0400
Received: from smarthost4.eviden.com ([80.78.11.85])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <clement.mathieu--drif@eviden.com>)
 id 1s2YN9-0005ys-4k
 for qemu-devel@nongnu.org; Thu, 02 May 2024 11:29:29 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=eviden.com; i=@eviden.com; q=dns/txt; s=mail;
 t=1714663763; x=1746199763;
 h=from:to:cc:subject:date:message-id:content-id:
 content-transfer-encoding:mime-version;
 bh=RgSs0a8yt86J4qaEVtdH+Iuq8b1J6iLIfJH0jS2pGK0=;
 b=jGy+2nyffqchYqdQi1fi7VnxgI+zutgEYLZGbfdW1awj+DpE7KUJnpuI
 5xLhVEzvDfNitNYoGhM1S+WzR/oElTXL8xyDmuBkhSLu9oqGAoxw0Ojl8
 jBsITKSYFz+Esc8m2PZpUehmBo85U9HaujxWZM+Jb+XfLh6pJhGoY+61v
 XIFWnrmHLddCUr/apiLP9T8rCXYb3APZx6Dkxc+P8Yshfxx96Vnm0Xhjn
 iFv1WYUXLwjrM1iQmcN+F6qUujLIe2mFT55ViIa1Qz5zOqXQ6sl1/fx8p
 +WPM5UPVftiq90LRq8GraKcNFfbCuoV8OOmqkBDPh7Iz9/JU9FTa8Git8 w==;
X-IronPort-AV: E=Sophos;i="6.07,247,1708383600"; d="scan'208";a="11785871"
X-MGA-submission: =?us-ascii?q?MDGNgAkNfoImEhJWV0YcM5kL4fjKRY89EMqt+K?=
 =?us-ascii?q?RZ2ginw6uDIpQNG4H7ZwYo5e3UtfeRaJSnGRkDW4E3RgorHiIOYnqx0D?=
 =?us-ascii?q?4gL8hR0Qpxz2mvt8+MbhprJ7HB+aisBM1KAsGGhn3/5OHazfInV0qvU8?=
 =?us-ascii?q?UGcYV6M9+X1+TmDX/gJx7SZw=3D=3D?=
Received: from mail-db8eur05lp2104.outbound.protection.outlook.com (HELO
 EUR05-DB8-obe.outbound.protection.outlook.com) ([104.47.17.104])
 by smarthost4.eviden.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 02 May 2024 17:29:17 +0200
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=JznXEJdlKs4tlirAAXs7rrDzbYFmEWXaii/xIkEKWl3ohDsi5TG1JZA6MElJnafsGadEvXF4dkOgHTDenyZX4j6D9QPVzeFarKuQTBPwZYiu5XOt7u5yZkecqoB91pTR5ij3m4e57A6hByAQw+jQl3QNwGw9AuPhKgaWgJoFpszOTWxL/ipxchaiZ1VxEkUyYjzEqr8D43828AdKxxo6/FNFvTltoqVvUat0pRhCZC8NlSvnXr7aO6B4OZpGyM3u78r/JxrY2jyChFXQJMP8EibxaDm9dCHmPnAHGB1CuiYurfej5F0h8ifOOc3fAEHyC5aeJWJPkpxq1AIluYPkIw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=RgSs0a8yt86J4qaEVtdH+Iuq8b1J6iLIfJH0jS2pGK0=;
 b=M+Jna+E0KXnsQ0+W+o3HRxVnVodQ+yXfB2dx+FltsnQFW27POkEDG3CzIRythOPo/6LY0iFiSdmC45HhGr2aURqOUXdR160Y20CB0ZVCx13jNNLBY5eaMjMXUFwfIhLBYQRe8CY1LBQW+yTSxBjLVgKhIT9RvcQWJJVOlKkOChUodZ0FnxvFJ5j44KQWNTs/aEx4StVR0Bh9ToIo3Z/0YPxgKltPjpsqc0QA0L8OIO1uyf+a6dzY0iqPeNmNqiYMGT84zVjMUxtg7cQKaib9M68BwDDqE/BlIB5jrbePYPK+ilklXaZogpaU0vrD+TA4Sj5U4WlHIlT9LsSmepDbpw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=eviden.com; dmarc=pass action=none header.from=eviden.com;
 dkim=pass header.d=eviden.com; arc=none
Received: from AM8PR07MB7602.eurprd07.prod.outlook.com (2603:10a6:20b:24b::7)
 by PAWPR07MB9661.eurprd07.prod.outlook.com (2603:10a6:102:389::19)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7544.29; Thu, 2 May
 2024 15:29:16 +0000
Received: from AM8PR07MB7602.eurprd07.prod.outlook.com
 ([fe80::fbd7:ca71:b636:6f9d]) by AM8PR07MB7602.eurprd07.prod.outlook.com
 ([fe80::fbd7:ca71:b636:6f9d%4]) with mapi id 15.20.7519.035; Thu, 2 May 2024
 15:29:16 +0000
From: CLEMENT MATHIEU--DRIF <clement.mathieu--drif@eviden.com>
To: "qemu-devel@nongnu.org" <qemu-devel@nongnu.org>
CC: "jasowang@redhat.com" <jasowang@redhat.com>, "zhenzhong.duan@intel.com"
 <zhenzhong.duan@intel.com>, "kevin.tian@intel.com" <kevin.tian@intel.com>,
 "yi.l.liu@intel.com" <yi.l.liu@intel.com>, "joao.m.martins@oracle.com"
 <joao.m.martins@oracle.com>, "peterx@redhat.com" <peterx@redhat.com>, CLEMENT
 MATHIEU--DRIF <clement.mathieu--drif@eviden.com>
Subject: [PATCH ats_vtd v1 00/24] ATS support for VT-d
Thread-Topic: [PATCH ats_vtd v1 00/24] ATS support for VT-d
Thread-Index: AQHanKV+t5i5swb4vUarY95NSLhSPg==
Date: Thu, 2 May 2024 15:29:16 +0000
Message-ID: <20240502152810.187492-1-clement.mathieu--drif@eviden.com>
Accept-Language: en-GB, fr-FR, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=eviden.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: AM8PR07MB7602:EE_|PAWPR07MB9661:EE_
x-ms-office365-filtering-correlation-id: a52ae5e6-091b-471a-de7c-08dc6abca0fa
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0; ARA:13230031|366007|1800799015|376005|38070700009;
x-microsoft-antispam-message-info: =?utf-8?B?b2RXMm0ydjVYMVE0eE1Obks3Y1puU0dxNWFlQjYxZFZjTjNXNExSaVpkcUNO?=
 =?utf-8?B?VlV1K1pSdnF6WmhEby90djdSTnhjSFI1dDl6eURjMmtIbElTUjFCMnNmV3Uz?=
 =?utf-8?B?T2VGRXVpRmVXb1lkaEVDNG9iNFVCU1RxWUU2ZWVuVUtZb2lqcDhwcmNZTEk0?=
 =?utf-8?B?d0JBV3R1VUV1UC9BalU0aXphZkJCK3BYU2VpVThjUHhlM1ZsRlMzTGZxNS9E?=
 =?utf-8?B?d2QyVU5jNGFvMUZlWk85TU1VMlpNdWh2aVJzTk16VmljS3JmeEQ1V2VPR2JU?=
 =?utf-8?B?WGhaNzJsVDhnajFxdjVnMFBSUmNRNTVNcDJnc09JSm9MeVJBUk5XRkpFUi9u?=
 =?utf-8?B?NmNpQ0pqeWU0aG56cDRCSUpDQmxmTEQrbDJGK2VERkxONGgrWWRLdlVWRFFR?=
 =?utf-8?B?MzJFdDAvQk42VjZCRzR2cnFsZFhWNElwOGo0YmZzTy9uQ0xxQkFZWU5mdFZj?=
 =?utf-8?B?akNQby9OWjFiZHdUL0l4UjZhR2ZZNmNmZEQ1ZXRCWGJBeVpsYkdHVnhaUkVJ?=
 =?utf-8?B?MmVQcGM2MFdKU25hL280b3JlYXdRM0hMYWZHbkhYOHdIbFg2TTJHQnhzR3Ev?=
 =?utf-8?B?WWZVOExTaGhKekVLSWRMRW54MzV4NzAxYmhZN0duNUZrdk5PN0hnV3R3SjJL?=
 =?utf-8?B?cDhoN0FxY2RiT3g4S3djRVY3UmxHeDJ2RldJQW1WdzJsaWRVMFdMUng2RFhp?=
 =?utf-8?B?N3AxT2dIaitudVRUaVVwaFBrRlBsVDlrNzdlaDBkTnoxZFNrdlVzS1RwVE1s?=
 =?utf-8?B?bVVNOEY0OG5FcENUczMvQS9QN05iejExcTRkY1pLR2tOK2xFQzVQRjRjSDBh?=
 =?utf-8?B?d0Y1MjhORDhCdlJlZlg0Rk5nSVJTN3owTU0vSXJFYU9CMHpUSFZHWVdpWUZj?=
 =?utf-8?B?RGZqTXBRUHVFS0F4Z2Q3NVp6dlZYeEluZkRtODZOb3hLM3RzZlVSd21OMHk3?=
 =?utf-8?B?TlVpa25lajJvdUppUGp3RjVzMVJsTGtsSGJyOGVFR3RadjhjeUNyUXBNR3lu?=
 =?utf-8?B?UzcwVm1ibzkrM2h1clF2SzVWNUt0NnlqOGx6bUNvTmF1d24zbzN4RUhqMGUx?=
 =?utf-8?B?RWpTQ2c5TEZOcmdvWnpXMTg0bDVIUjJCV0F3ZTY4TjhwMmhsQmpuTmg2dC9q?=
 =?utf-8?B?YUtzN2paUHZ5ZTVkUXNqYlNPRlRzRnpQYSsvM1BoQVhIZ0Z1WURHeEtiSkRO?=
 =?utf-8?B?QURWNVBMc21DcWROdmM1UnE1anoxSmNPVU45TFg2VXFQZjFWdE93T0VxcHIv?=
 =?utf-8?B?Q3VrRHRzeFFtLzA4VXRTeUpXUG4ydlQ3d3IrTjhlVjI0aXJ6Z3BmMnhZeEFm?=
 =?utf-8?B?dUMxZThGZlI1aXFoTkwxNXpaaDl0NllybjRRc0VpY3U1MTdTNWNHNnYwa3lB?=
 =?utf-8?B?bHVoRHFNQmtvOGRVNVhQV3kxM0VERXNzQ1pNMmZnNVJLWTgxTUlUdCsxR0pi?=
 =?utf-8?B?S0ZON011THRuMmVJb1pTQ3pHdHBBaEVQT0t5aUovdm4xSENDZTNrSStJaWF2?=
 =?utf-8?B?SlkxVXh5QmV3Y0NSUkx6K21jSjg4MDNQcDNkeGtMV0l6czRmbUltQmo5MXNo?=
 =?utf-8?B?OHFEbFlPQWJwb0ZjcjFyaE9rY2lDbTVrR3VlaGdyWTFEdTZBNlIreXdUS2xU?=
 =?utf-8?B?YjRRNFV2KzhiMm9leitTbjNRR0VpOUt0RzBGVzhjQWxyQXZnc1NtcFVVM0NE?=
 =?utf-8?B?NmtnRGxQNE0yYmFJM3BUN1ZkcTBjUlpqeTB2K3ozWGwrcmlUMTRDK1ZPSllT?=
 =?utf-8?B?RGpzLzBiS21VU05FQndHOW9CUXNYdmVpdVAySnpIY214cmtXWUFiOXRPQ1Jw?=
 =?utf-8?B?bFp2c2lSd1FGR3UxRFN6QT09?=
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:AM8PR07MB7602.eurprd07.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230031)(366007)(1800799015)(376005)(38070700009); DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?Ym5XdHJvZ3VTN0lRdThRWXAwOENLcXJpYXBxUHljSDFzb2tmY2xlT2FURU50?=
 =?utf-8?B?TzZiYkVGYXIxV2p4MjJyZVVvRUZkd2NhTUt2RGx2Q0swbUJPOVYzMUZQQXJ2?=
 =?utf-8?B?OTNJUERscU9mTVBZL1pMMDN1ZlVHQWI0TDIwaWhETGtHN3ZLTnNKMFRGamk1?=
 =?utf-8?B?b1I5QVdCNTRxODRRdFJWTHJyU2JqcFdoNzVuczNYeENsR1ZkRlhEbVlkK1hm?=
 =?utf-8?B?SUNZam1WbWNhZGpJWFpRbEw4bTBxdjhYM1BrZmNXbHAvSmdLWm15MTZ0OTlY?=
 =?utf-8?B?K01xbUUrVVNEV2R1STBIYU05c0pIOE5YNDBMMGFvdlQ3NlpvUko3dmVtTGdD?=
 =?utf-8?B?blcrNnVlckdQUTZoT3R6MzFadkl2MGdzWkg1V1VmcFo2KzdOLzg1YjNvOE9n?=
 =?utf-8?B?SmN0UWtIb1JmWGZSalliUGlxWnpiZEhVclZQb2hlM05oaWtiMzhIZWFXT3hh?=
 =?utf-8?B?OW1nQlBSYk41ZE4wZUtkS0p0WmJYeEh1R3hBaStuMjZHK2picHZqSjZyTkt2?=
 =?utf-8?B?TnlEVkdJZG5XYWNxeng2VDZHYnFsOFVodG1oS0FmMzlrbHE5bng1OFZwQTZj?=
 =?utf-8?B?Sy8zd3BjbWQ0cERXVDhvcFJpaUxwREM3Q2tyaGh0N29IQnFIOGxjRzVBWkZW?=
 =?utf-8?B?TE1zcHlkZ1VEdTdBemZmVFVqNi9OYk56YkQyY1AxZ3dtc292K0wzL1A4T296?=
 =?utf-8?B?RUJuQXkwZlZhTENBRjNObW5WQStwazVpdElmbXRmbFhBSmo2MzhMVlFFNEI0?=
 =?utf-8?B?YUk2eXd4SHB6bllxUC94UldUNDBDRE1GR0p1aGl0VGI4Y3BadnNhK1ozR1Nt?=
 =?utf-8?B?dGdMWjhXaVhrc28xU3BnSHpRYURlTVdSc01BcTJmZHR6TUtVcDBzNFpnZW9k?=
 =?utf-8?B?YW9SKzVQREFOdU9vb3V2ZWsyZ3FOQThHZUhNN3cvRXpIT3pIWXNCeGw5cS9Y?=
 =?utf-8?B?bjlDVDdWRjdXdHFTSkRtTVpYUE0vZzM2bGJGZVZaNWNvWUw2TW1SUzZiTWh3?=
 =?utf-8?B?ZjBtVnN5RFk0L2xZRzU0NmM3MDdJbmI3WE5kNUZmZThWTlliUVRpM1hKYnBV?=
 =?utf-8?B?TGNkc2FmMnIzSnk1SlB2RWd0NHA3SFFVVFNVVmpsOGdRZWcrbThBam9QNlRL?=
 =?utf-8?B?UkU5TWc4aUluU1VVbGl1MHJZYWFJYUNMcVdEMmpvbUwzV0NFUWVRUXpUTUlJ?=
 =?utf-8?B?YkdZRHJIMXZFQmlER0N2cmFZb1dtUXk3ZWlUR0xkdWJIWFo4RVlQU2FKWWUy?=
 =?utf-8?B?Z0w4cE1NalM0TytVbHBoZ2xyeU1RRTN3TEZGNWE5eGdvTVUybjJ0WGNkTUpO?=
 =?utf-8?B?V0JPOElPMnFIWTFNOGRBeTUrWEY5UzRudFR1a05NenpXeDBQbVZJb29JZ2xh?=
 =?utf-8?B?MFJQZFdQRUhrNjVyODFNRlQ5ZXNjSlVpM2Y2NUJGUDZUWkROZ3hSWDJPUHNQ?=
 =?utf-8?B?czYyL01VT1dDd2JVMWJLTnRIUlpTUkxyWHg5RGtHWUt6TGVzTkV6YTh0bktu?=
 =?utf-8?B?UVQ2elVKR1pJdDBNZlJtT0ZrcENpRjljSk5pZWpWVm9OMGY1MGtnVkpEMU5y?=
 =?utf-8?B?MXA1S1ZzdWk5V3BtNURkZ2d2ZC9jaTZhVHNlRzZLODRMVjhmVHlFMDFYRVhL?=
 =?utf-8?B?VlZkcndMeGdaV256YWlsUlRGTnBxYTlKMlQ0cTZWazNOTGNvQUEvVG5MT2hY?=
 =?utf-8?B?TGRVbGVPSHZ6MTArODVvZktSb3U4bmtCaXdaL2gvdWR6am9sbHF3ZzFORHU0?=
 =?utf-8?B?SjRBZ1VpT0ZMVkQ0M01iajYrRmhMMkpCd1BkSHJKd3dRbWgyMGRMZHZHb2hU?=
 =?utf-8?B?MS9ONERpRVdVZWJLRklmeEFNYmZCeEU4aVRCMi9ZbnJlTVRydHhKUXp2MlYz?=
 =?utf-8?B?b1lWK2FyTEszcFR0T2IzV0F0SkpVQk5FRGlKUFB6ZDEwN1RjUElJcnJZZnFM?=
 =?utf-8?B?cnl6K1pPL0xMZ05jNUs0Smhja05MWU1ZWlpSU0tOZW15WWl5S2dzOTJPSjhO?=
 =?utf-8?B?MDVKdDl6dDdmTDRvMFNXS05LZnQ2dS91N3c2bkpnSSthYWFjdzd5b1VQRVZT?=
 =?utf-8?B?SzlkV3UwaWlsS3ZsVlR0QzhEM0p3dmh4OWNjZ2FvRll2VXIwR1l4ZFphMkh0?=
 =?utf-8?B?emhCTTdLM3NsNlFwVmdnaGlPeGZKSXlNN3IxOWVDWmU1MW1oYnhqMTRaajhr?=
 =?utf-8?Q?oin9XMFm2uRu7SZ9EQeA27E=3D?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <3D53094CC3557741856A566C76F2A282@eurprd07.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: eviden.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: AM8PR07MB7602.eurprd07.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: a52ae5e6-091b-471a-de7c-08dc6abca0fa
X-MS-Exchange-CrossTenant-originalarrivaltime: 02 May 2024 15:29:16.6574 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 7d1c7785-2d8a-437d-b842-1ed5d8fbe00a
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: r1RNSZAaTUpHSIwTIEKnGX20AX6lcivNQBfvZ5xJDaqbX1Ny8JGVOTluAqhNqpP8pV42RK7ryhgqk9SRWNk9ocmgCH8BmylmU2BrnZ0LjBDwL7NuNeGXDnTLIBR6siZJ
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PAWPR07MB9661
Received-SPF: pass client-ip=80.78.11.85;
 envelope-from=clement.mathieu--drif@eviden.com; helo=smarthost4.eviden.com
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

VGhpcyBzZXJpZXMgYmVsb25ncyB0byBhIGxpc3Qgb2Ygc2VyaWVzIHRoYXQgYWRkIFNWTSBzdXBw
b3J0IGZvciBWVC1kLg0KDQpBcyBhIHN0YXJ0aW5nIHBvaW50LCB3ZSB1c2UgdGhlIHNlcmllcyBj
YWxsZWQgJ2ludGVsX2lvbW11OiBFbmFibGUgc3RhZ2UtMSB0cmFuc2xhdGlvbicgKHJmYzIpIGJ5
IFpoZW56aG9uZyBEdWFuIGFuZCBZaSBMaXUuDQoNCkhlcmUgd2UgZm9jdXMgb24gdGhlIGltcGxl
bWVudGF0aW9uIG9mIEFUUyBzdXBwb3J0IGluIHRoZSBJT01NVSBhbmQgb24gYSBQQ0ktbGV2ZWwN
CkFQSSBmb3IgQVRTIHRvIGJlIHVzZWQgYnkgdmlydHVhbCBkZXZpY2VzLg0KDQpUaGlzIHdvcmsg
aXMgYmFzZWQgb24gdGhlIFZULWQgc3BlY2lmaWNhdGlvbiB2ZXJzaW9uIDQuMSAoTWFyY2ggMjAy
MykuDQpIZXJlIGlzIGEgbGluayB0byBhIEdpdEh1YiByZXBvc2l0b3J5IHdoZXJlIHlvdSBjYW4g
ZmluZCB0aGUgZm9sbG93aW5nIGVsZW1lbnRzIDoNCiAgICAtIFFlbXUgd2l0aCBhbGwgdGhlIHBh
dGNoZXMgZm9yIFNWTQ0KICAgICAgICAtIEFUUw0KICAgICAgICAtIFBSSQ0KICAgICAgICAtIERl
dmljZSBJT1RMQiBpbnZhbGlkYXRpb25zDQogICAgICAgIC0gUmVxdWVzdHMgd2l0aCBhbHJlYWR5
IHRyYW5zbGF0ZWQgYWRkcmVzc2VzDQogICAgLSBBIGRlbW8gZGV2aWNlDQogICAgLSBBIHNpbXBs
ZSBkcml2ZXIgZm9yIHRoZSBkZW1vIGRldmljZQ0KICAgIC0gQSB1c2Vyc3BhY2UgcHJvZ3JhbSAo
Zm9yIHRlc3RpbmcgYW5kIGRlbW9uc3RyYXRpb24gcHVycG9zZXMpDQoNCmh0dHBzOi8vZ2l0aHVi
LmNvbS9CdWxsU2VxdWFuYS9RZW11LWluLWd1ZXN0LVNWTS1kZW1vDQoNCkNsw6ltZW50IE1hdGhp
ZXUtLURyaWYgKDI0KToNCiAgaW50ZWxfaW9tbXU6IGZpeCBGUkNEIGNvbnN0cnVjdGlvbiBtYWNy
by4NCiAgaW50ZWxfaW9tbXU6IG1ha2UgdHlwZXMgbWF0Y2gNCiAgaW50ZWxfaW9tbXU6IGNoZWNr
IGlmIHRoZSBpbnB1dCBhZGRyZXNzIGlzIGNhbm9uaWNhbA0KICBpbnRlbF9pb21tdTogc2V0IGFj
Y2Vzc2VkIGFuZCBkaXJ0eSBiaXRzIGR1cmluZyBmaXJzdCBzdGFnZQ0KICAgIHRyYW5zbGF0aW9u
DQogIGludGVsX2lvbW11OiBleHRyYWN0IGRldmljZSBJT1RMQiBpbnZhbGlkYXRpb24gbG9naWMN
CiAgaW50ZWxfaW9tbXU6IGRvIG5vdCBjb25zaWRlciB3YWl0X2Rlc2MgYXMgYW4gaW52YWxpZCBk
ZXNjcmlwdG9yDQogIG1lbW9yeTogYWRkIHBlcm1pc3Npb25zIGluIElPTU1VQWNjZXNzRmxhZ3MN
CiAgcGNpZTogYWRkIGhlbHBlciB0byBkZWNsYXJlIFBBU0lEIGNhcGFiaWxpdHkgZm9yIGEgcGNp
ZSBkZXZpY2UNCiAgcGNpZTogaGVscGVyIGZ1bmN0aW9ucyB0byBjaGVjayBpZiBQQVNJRCBhbmQg
QVRTIGFyZSBlbmFibGVkDQogIGludGVsX2lvbW11OiBkZWNsYXJlIHN1cHBvcnRlZCBQQVNJRCBz
aXplDQogIGludGVsX2lvbW11OiBhZGQgYW4gaW50ZXJuYWwgQVBJIHRvIGZpbmQgYW4gYWRkcmVz
cyBzcGFjZSB3aXRoIFBBU0lEDQogIGludGVsX2lvbW11OiBhZGQgc3VwcG9ydCBmb3IgUEFTSUQt
YmFzZWQgZGV2aWNlIElPVExCIGludmFsaWRhdGlvbg0KICBwY2k6IGNhY2hlIHRoZSBidXMgbWFz
dGVyaW5nIHN0YXR1cyBpbiB0aGUgZGV2aWNlDQogIHBjaTogYWRkIElPTU1VIG9wZXJhdGlvbnMg
dG8gZ2V0IGFkZHJlc3Mgc3BhY2VzIGFuZCBtZW1vcnkgcmVnaW9ucw0KICAgIHdpdGggUEFTSUQN
CiAgcGNpOiBhZGQgYSBwY2ktbGV2ZWwgaW5pdGlhbGl6YXRpb24gZnVuY3Rpb24gZm9yIGlvbW11
IG5vdGlmaWVycw0KICBpbnRlbF9pb21tdTogaW1wbGVtZW50IHRoZSBnZXRfYWRkcmVzc19zcGFj
ZV9wYXNpZCBpb21tdSBvcGVyYXRpb24NCiAgaW50ZWxfaW9tbXU6IGltcGxlbWVudCB0aGUgZ2V0
X21lbW9yeV9yZWdpb25fcGFzaWQgaW9tbXUgb3BlcmF0aW9uDQogIG1lbW9yeTogQWxsb3cgdG8g
c3RvcmUgdGhlIFBBU0lEIGluIElPTU1VVExCRW50cnkNCiAgaW50ZWxfaW9tbXU6IGZpbGwgdGhl
IFBBU0lEIGZpZWxkIHdoZW4gY3JlYXRpbmcgYW4gaW5zdGFuY2Ugb2YNCiAgICBJT01NVVRMQkVu
dHJ5DQogIGF0YzogZ2VuZXJpYyBBVEMgdGhhdCBjYW4gYmUgdXNlZCBieSBQQ0llIGRldmljZXMg
dGhhdCBzdXBwb3J0IFNWTQ0KICBtZW1vcnk6IGFkZCBhbiBBUEkgZm9yIEFUUyBzdXBwb3J0DQog
IHBjaTogYWRkIGEgcGNpLWxldmVsIEFQSSBmb3IgQVRTDQogIGludGVsX2lvbW11OiBzZXQgdGhl
IGFkZHJlc3MgbWFzayBldmVuIHdoZW4gYSB0cmFuc2xhdGlvbiBmYWlscw0KICBpbnRlbF9pb21t
dTogYWRkIHN1cHBvcnQgZm9yIEFUUw0KDQogaHcvaTM4Ni9pbnRlbF9pb21tdS5jICAgICAgICAg
IHwgMzEzICsrKysrKysrKysrKysrKystLS0tDQogaHcvaTM4Ni9pbnRlbF9pb21tdV9pbnRlcm5h
bC5oIHwgIDIxICstDQogaHcvcGNpL3BjaS5jICAgICAgICAgICAgICAgICAgIHwgMTI3ICsrKysr
KysrLQ0KIGh3L3BjaS9wY2llLmMgICAgICAgICAgICAgICAgICB8ICA0MiArKysNCiBpbmNsdWRl
L2V4ZWMvbWVtb3J5LmggICAgICAgICAgfCAgNjAgKysrLQ0KIGluY2x1ZGUvaHcvaTM4Ni9pbnRl
bF9pb21tdS5oICB8ICAgMiArLQ0KIGluY2x1ZGUvaHcvcGNpL3BjaS5oICAgICAgICAgICB8ICA5
OSArKysrKysrDQogaW5jbHVkZS9ody9wY2kvcGNpX2RldmljZS5oICAgIHwgICAxICsNCiBpbmNs
dWRlL2h3L3BjaS9wY2llLmggICAgICAgICAgfCAgIDkgKy0NCiBpbmNsdWRlL2h3L3BjaS9wY2ll
X3JlZ3MuaCAgICAgfCAgIDMgKw0KIHN5c3RlbS9tZW1vcnkuYyAgICAgICAgICAgICAgICB8ICAy
MCArKw0KIHRlc3RzL3VuaXQvbWVzb24uYnVpbGQgICAgICAgICB8ICAgMSArDQogdGVzdHMvdW5p
dC90ZXN0LWF0Yy5jICAgICAgICAgIHwgNTAyICsrKysrKysrKysrKysrKysrKysrKysrKysrKysr
KysrKw0KIHV0aWwvYXRjLmMgICAgICAgICAgICAgICAgICAgICB8IDIxMSArKysrKysrKysrKysr
Kw0KIHV0aWwvYXRjLmggICAgICAgICAgICAgICAgICAgICB8IDExNyArKysrKysrKw0KIHV0aWwv
bWVzb24uYnVpbGQgICAgICAgICAgICAgICB8ICAgMSArDQogMTYgZmlsZXMgY2hhbmdlZCwgMTQ1
NCBpbnNlcnRpb25zKCspLCA3NSBkZWxldGlvbnMoLSkNCiBjcmVhdGUgbW9kZSAxMDA2NDQgdGVz
dHMvdW5pdC90ZXN0LWF0Yy5jDQogY3JlYXRlIG1vZGUgMTAwNjQ0IHV0aWwvYXRjLmMNCiBjcmVh
dGUgbW9kZSAxMDA2NDQgdXRpbC9hdGMuaA0KDQotLSANCjIuNDQuMA0K

