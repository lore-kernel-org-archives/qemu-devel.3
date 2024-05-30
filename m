Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4B2DBC25B74
	for <qemu-devel@archiver.kernel.org>; Thu, 30 May 2024 12:25:29 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sCeqG-0006yU-N1; Thu, 30 May 2024 08:25:13 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <clement.mathieu--drif@eviden.com>)
 id 1sCeqD-0006xk-4x
 for qemu-devel@nongnu.org; Thu, 30 May 2024 08:25:09 -0400
Received: from smarthost3.eviden.com ([80.78.11.84])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <clement.mathieu--drif@eviden.com>)
 id 1sCeq8-00060c-PE
 for qemu-devel@nongnu.org; Thu, 30 May 2024 08:25:07 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=eviden.com; i=@eviden.com; q=dns/txt; s=mail;
 t=1717071905; x=1748607905;
 h=from:to:cc:subject:date:message-id:references:
 in-reply-to:content-id:content-transfer-encoding: mime-version;
 bh=HVKnFkrmgwdohMnHQE5psyw3hmzpcGX7tSLYpwPUtPg=;
 b=IPtAJfAiloqZRDL0Dy5gUXGbReO3RZOtZIsZEuNqacmtxkoxITrEDO0T
 LZS4yp1UqZEwhdH36a4k/vKXSvDHd8iSgJHO3vUn6wqhq8qyX3VF4NQMh
 VtPnXjgKUvSfp+i+Hn8FuB7ezTCtbTdK7Y/8K6ATDysU+gon1luuOEtED
 r8C1K4wT7ftHefjLVcG2T/irTvuQPIk+SLK62iN9yHB6m4/16eZDtx8q7
 mhpayNNwXi+QPJO8rYwA2bQAUKw49yPeJvCrqbVnv6lWYzcesbibvFfMp
 fFJuCULyAqcao1n6hQoVuf0O8kDYoMweby4V78X2ideDDlZbW/jrOfF2i g==;
X-IronPort-AV: E=Sophos;i="6.08,201,1712613600"; d="scan'208";a="13581111"
X-MGA-submission: =?us-ascii?q?MDFFSogs6Qum6mvTEluzHApt1FNFthsGIzL8ll?=
 =?us-ascii?q?pUFVpVjQavGTWsX3RY2poZj8ZPMel7HwgxJ05pGO5OxNPkj8ZZS5nPhn?=
 =?us-ascii?q?iYw1F8q5Yp+Zy2VStRcmnbVkodNi5VaZ02+HvnKZXY4VgRKL/cvljPZH?=
 =?us-ascii?q?OXMlSYfYcXOZ8KUss0/sfWAQ=3D=3D?=
Received: from mail-he1eur01lp2051.outbound.protection.outlook.com (HELO
 EUR01-HE1-obe.outbound.protection.outlook.com) ([104.47.0.51])
 by smarthost3.eviden.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 30 May 2024 14:25:01 +0200
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=KGi56cIw2J080kev3LMaMS2BMTPZPpxNzpgU/4zSvl/CRFrqP21dxvFe+hVywsWawUhfQ0YC81XB921dRAAmMwJtkrVZu//Fh8nS/c9EuRpfEOS5hWXRrxI3KG7SEKp9t+itYMLcVuhzudKBRdt4XAe8cS2x5QUbYRt7UemKMOz5OiJ/s//jRH7AcakXjfHuaGCyrml5lJQjCge+wKTvIcdjGRH3aceN860w/AiTpria3UBWvHZW7TvUjKb3UGqqUdtEVnRAj0emMcc5lhvniInnVDLVCVfnorJ+t9+oRT+GT623YUoyKhDnqfg1ATMNTpzQJolnoAURRMwooThyOw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=HVKnFkrmgwdohMnHQE5psyw3hmzpcGX7tSLYpwPUtPg=;
 b=SM3mtnpdwd1yjqAcl5Ccbhs67otKF29h6f5tmQ7s6FD3+qiPa6XNANFUs4C4u+WoWTmgmsmmqI0zTGszJircYNISODxZwK15aQlauIG6UhMHsiWiVeBIU9vlyDbAeYrnmYpXMtdx2CSv8PmuNsP3+GDTTaTqhTfHZ9mhMQJP8yE93eHyGwCmUv1vK1dfcNP04PTmBUCpfEmZdndgYexub6wgVSsy8qeYDmFVo732pRxO11XiWq2saF2/lEXc4UFI8PrQl0PUGgZ7CbNhJfiNr5HtWXM7vUw6G+GFB29fVmTfAfQKnBKFXqKg1Cz+q9Amv0SDit5GpBNOyn85pNdhAg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=eviden.com; dmarc=pass action=none header.from=eviden.com;
 dkim=pass header.d=eviden.com; arc=none
Received: from AM8PR07MB7602.eurprd07.prod.outlook.com (2603:10a6:20b:24b::7)
 by AS8PR07MB8069.eurprd07.prod.outlook.com (2603:10a6:20b:358::7)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7633.21; Thu, 30 May
 2024 12:25:00 +0000
Received: from AM8PR07MB7602.eurprd07.prod.outlook.com
 ([fe80::fbd7:ca71:b636:6f9d]) by AM8PR07MB7602.eurprd07.prod.outlook.com
 ([fe80::fbd7:ca71:b636:6f9d%5]) with mapi id 15.20.7633.018; Thu, 30 May 2024
 12:25:00 +0000
From: CLEMENT MATHIEU--DRIF <clement.mathieu--drif@eviden.com>
To: "qemu-devel@nongnu.org" <qemu-devel@nongnu.org>
CC: "jasowang@redhat.com" <jasowang@redhat.com>, "zhenzhong.duan@intel.com"
 <zhenzhong.duan@intel.com>, "kevin.tian@intel.com" <kevin.tian@intel.com>,
 "yi.l.liu@intel.com" <yi.l.liu@intel.com>, "joao.m.martins@oracle.com"
 <joao.m.martins@oracle.com>, "peterx@redhat.com" <peterx@redhat.com>, CLEMENT
 MATHIEU--DRIF <clement.mathieu--drif@eviden.com>
Subject: [PATCH v1 1/8] pcie: add a helper to declare the PRI capability for a
 pcie device
Thread-Topic: [PATCH v1 1/8] pcie: add a helper to declare the PRI capability
 for a pcie device
Thread-Index: AQHasoxj3XXMvKtwP02RxAFJg4tHdg==
Date: Thu, 30 May 2024 12:25:00 +0000
Message-ID: <20240530122439.42888-2-clement.mathieu--drif@eviden.com>
References: <20240530122439.42888-1-clement.mathieu--drif@eviden.com>
In-Reply-To: <20240530122439.42888-1-clement.mathieu--drif@eviden.com>
Accept-Language: en-GB, fr-FR, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=eviden.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: AM8PR07MB7602:EE_|AS8PR07MB8069:EE_
x-ms-office365-filtering-correlation-id: 2bd6d0bf-546e-464c-1d36-08dc80a38653
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0; ARA:13230031|376005|1800799015|366007|38070700009;
x-microsoft-antispam-message-info: =?utf-8?B?RGlld2dUWjBCMENTRmEvT2orc2RpYmpqZWdNQzhCQ0E4TWJQbUZzMG42NzVv?=
 =?utf-8?B?U0U0MkxDc0xHWnVpcmNKb3lNYnhUT1FCSGwvLzRYMUp5ai9oSTdwQUdVWEdZ?=
 =?utf-8?B?WlMxMExDdmNBcU8zd0V5S1RGbUFDTkNqeWhIcjRFUDhOZzlJaWUwK1BhNGhC?=
 =?utf-8?B?MDdjb1VJSGNleURtYzNPVHZIN2hMd05RZmR4OVhWV3d6R2xuWFF6Vnh6UC9h?=
 =?utf-8?B?NExTaTdMSUlGTmZQRlFZb211Mm9sdlRQdUZUQklHbjlmcERIYW0xcjh1Z2Vr?=
 =?utf-8?B?RU1USHpCVjVrVlByS2phTm9BL2FXWHVHaXg3WlEvWm5QdHdwVGVCaHo1d3V4?=
 =?utf-8?B?QWFqSVFEZEJPaEN1OHRJZEVOYWNxai9TUGpEV0ZLU29VMDRFZ0lPSXdjRW5h?=
 =?utf-8?B?KzRsM1BUS1IzN2s1YjV0Q3hCWlF5V2dDUjV1elp4TEsrZHdKTlZ4a0RBK0pG?=
 =?utf-8?B?Q2ZJNHRjbFJ5Y2dEdDM0aS84MVhPN3JVZFE4OC9ybzZRMkR1aXVFTVVsaGJJ?=
 =?utf-8?B?R29RREY2aXBXRnk2ajhwTGpId1p0b1hsekVIR21ITXFiN2l6S3EvMlJRRUNq?=
 =?utf-8?B?L3RUcnJXZy9vaU1lZDdKUjYrM2JRcFZ6eHdMa0l4TERidUFIZy9TSVNjMFg0?=
 =?utf-8?B?QmUyQnk5N3MwSkJZTGFKWml4T01NcUR5QWM2eHJHSThPbm5kaGYxcWV2Qyti?=
 =?utf-8?B?OWdJZXhqMzNMR09aQnJ5ZnNMMWdWRTFHSFhPKzl6eGpwWW4vb3gzZDJJWHlx?=
 =?utf-8?B?ZW5obE0rZEJla01sK25ReFJtYUk1bnd5cFRHNFQ5YTdUMkJNQld4aHgyUVE2?=
 =?utf-8?B?YjNNS2U1YWIzVmFoODV0MlVYZldSMXc5RWZqWHpPenM1L2ovWmR3eUx0UjN0?=
 =?utf-8?B?ODM3Ry8rSW9GRWs0Mkp0UTN0eG1MVGZOeGtPYUZVb0FONHRJWStyNFNKNzFE?=
 =?utf-8?B?ZCtvVDVuNzlMRG40TnJzN2FqS1Y3ekJXUGJBazc1c2lUT3dLY2dldTFCTkln?=
 =?utf-8?B?OE1sVW91RmRaS1dvcTFKbFo2YVp0ZGVxOXZGQ3lBWGtybFc2NWQyOUJEdUJu?=
 =?utf-8?B?cVI5bVprUmZJZVhPVktJOExIMC9MWWthTG02ZXJYQWZHNnVZRnhyYXF3RXVp?=
 =?utf-8?B?ei8xT1hxV0VQbzNUM3BXcG95UldSaW9jZVMwdFNveDZQZVRxNy9qOGVudEVK?=
 =?utf-8?B?cWprQTA0eGY2TTBuUEJPek90UE5WK2ZqNi9MZk05UGQzRlBXUVZ3SnBrUU1h?=
 =?utf-8?B?OEx5UU1wZnh2RUxGOFVST250K09DY0FOaWVKN3h2OGx5eXp2MmkwQnVpc2dL?=
 =?utf-8?B?ZnlZRENuTVB5bDB1elVQbXBtVzVpUGZsNXlZRHYxczFEUi8vdVd5VUpIY2VW?=
 =?utf-8?B?TE5NMWFXYXF0citvOXUyV2RxSGVTd3ZSVTlQL0daaFJDNWdOYWNERTF1WG0v?=
 =?utf-8?B?TFpkWjVrdVJXMGRCNzIzZnd3ZG5pMUx4Y0lxVWtHVGdCVmp2eGFFQmRBVWVG?=
 =?utf-8?B?dFgrVkFsM3ZucTRNOTNhNWtzdEphOEJLY0pTSTlZUkhaM0xFNVJTY2RhZk15?=
 =?utf-8?B?REYzaDZDZTBTY1dsUmJnZ28zbXoyQ3JxS1Rwb2FJQndERnBBajdGWlZlejgv?=
 =?utf-8?B?WGFpaDNFUnNsVm1nUXF4WEpWNGdXT2ZVQmk4ZnFJUmM5L0YxbURZZWZuSmpy?=
 =?utf-8?B?YjFta3VoQ1hkNjRESGkzYkxQblprcnBwNXk0dXBIaDJ3OUprMFZXZElWaWxz?=
 =?utf-8?B?Y0VWUGQrcnFKa2RoQVRUV2tBdTFqOGtHNGQrQWV0Qzc0NXRJTHhMNWdOQUVL?=
 =?utf-8?B?cWlBU2xZVi9ZRTd0VU9idz09?=
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:AM8PR07MB7602.eurprd07.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230031)(376005)(1800799015)(366007)(38070700009); DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?eWpzUklwQ2lEQUpXMXVvQXZyYXpIa0dGQmFueTF0UGJlTk9KY0lxSmxzcFdW?=
 =?utf-8?B?bEcyTVRJbiszejN0UG8wb3BzcG0zUXhGU0ZvbnhrYmtSdjBmUFJ1QzIyWW1W?=
 =?utf-8?B?bjJsK3UvMVJJUlRpYkFlMXJQb2o3OVkzeXlHNVlJZ2hXWEh4R1ZMMUJoNjg0?=
 =?utf-8?B?Q0ZkUjdtTGdNeXRpdEdPV1gzWG5sTUlMTUg1VU1kbjUwQU54QVJlZTcvWE9Q?=
 =?utf-8?B?dk5zQVEzRVQ4em5QTmxBOURpNmFhODZYV3Brd0JKaFAwd3p4TUduWGlOQktm?=
 =?utf-8?B?dDZ1Q2JoQlBsK0pkNUh0S3lUcFU1elZtbTZLNGZlTlp2ZThyQ1hkWlVMbkYr?=
 =?utf-8?B?U3dEQktCMVJHMndtM3hIanNxd20xaG5qa0tzbGY2TmpzMkZBaXkyUFhueHUv?=
 =?utf-8?B?M09WRFl6RzdlZG1Bek04UzNpUnJ6a3MwWTNkczdvZmRPdHZ4V1JhdTliMEl0?=
 =?utf-8?B?ZUU5OHp1VUJ5dDlWRG1DZTkwVmxhd1FINFA5WWp5SWEvZklzalhWK2FKTVlM?=
 =?utf-8?B?S3RGdmNUN29VQnlTRjRnRWZkdG1rKzRHeEZvR0FrK0s1WEt1dzlBYXgzclBI?=
 =?utf-8?B?Z1BzRkxBcDRvTE1EdUFPaklSVnRIWmplNFZETFY5REppUnVXK00wMVZTb0dv?=
 =?utf-8?B?RkRpLzBoL1kvQmxXT1NPN1l0M3pSQ3ZuREtiVUUwRFg1dEdQZXZWSjJqQmJQ?=
 =?utf-8?B?TitzSlFYcGZkZktESVNuUEwvTTlsWWJHSFRkS0VGZFI5dW51eFhnaHp2citT?=
 =?utf-8?B?YlF6MXFpVEV5YWsyWTJYSStkSll6WjNEWTZ4SUMxRXBFWlA0THpDUWhubEN3?=
 =?utf-8?B?ZXpKdldEcGFlR2MrZFdlaHFsSjBsUE1vMFNvSzFxWE05VHBuU1VpQ1Y0d3VI?=
 =?utf-8?B?VVBvMTVLQ21WVmxkYWc1bE8wekExN3h3NTFCVUd0bWpWOXFmUFBJVWR1ck4x?=
 =?utf-8?B?MGdFd09zcDhGYU83NkIwcUEvNUhUalVERWwvWmF2WWNUL3pIOTdpTWtvNS9P?=
 =?utf-8?B?MG9HTXFDNEp3TUxRV296N3llR2c2ZTUyTlN0NW53YWJqS2tCNW1wbHVjdXlt?=
 =?utf-8?B?a1B0QVlTazNxSDVIQ1VHVklmUDQwamoyQVRyb0wrUE1KSTFEUlBMV1A4R0pw?=
 =?utf-8?B?ME1KRS90Rk9rTFN2ZnhPUDU3LzZjTXNwQVd5MGtOODhQVDd3aHlRY0ZnaXpr?=
 =?utf-8?B?R1BMMGJ6cTVTZ2toYTFJV3NiZ2xJM0MycHFmMmpreitiKzJoRFdIeTVVVits?=
 =?utf-8?B?WnV4UWROWEVQYXkrSTU1UjFFSkE1U0IyTDZOZk1pdFpSY3dabWgyU3pBUVIv?=
 =?utf-8?B?bXZVKzZkZTM5MVRuSU1ZMFN5MjU4dVFLdGZMaHRuT1duNUY0Vkd1ODRGNmdK?=
 =?utf-8?B?TDExc2JQYkpMTDJFdm80MFVLbnBSWUx3RW1qZnpNOVNvcFNVSUsyeUttbWZy?=
 =?utf-8?B?UVdRRDZSUmZZYzRoWUE0aXV4QngxRmVIZXhWMUdIcitXNkZaazRWTG1hTlhy?=
 =?utf-8?B?OFhkRnpBdlA0OFM3bzgvN0lOSy9CZTY0Y25Dd01NK3BScEtTc1FCZjl0YzNN?=
 =?utf-8?B?V0ZaMEZJeWt4bHNBdThRM3I5bDVDU280RWtuenhtWCtZQ2t0UmladDA2UkI5?=
 =?utf-8?B?TkQrRnNpWU52bVRhOFNVVm9PTVRvQVk1alJ6MmI2Ujdwa25YT2JDcHVpdkNZ?=
 =?utf-8?B?S2VZNEFxa3k0dTVtdkUzeTRCdEpCZDRLcExGZUVVWXl1K0NWdHFZR093K0RH?=
 =?utf-8?B?ai8wc1JMeUNvTGFCQ3hPRHlQdW9GbWpCSENzdythS3VDeDNEbkJIUXRhZlR4?=
 =?utf-8?B?WG1hWk13Q0wwQjhCem81VnVLSUxiL2w1NnBaNjRHd3VJSXhYdXF6aWFaVG9F?=
 =?utf-8?B?NThTR0dzcHB2cW5weG1OMVVPNng2a2tZR1FYTU01bmtJdDJQaFdPc3FoWng2?=
 =?utf-8?B?cVNpc0FQSUlMRThnVjlPTlRYQ3JFRTg0dGk4cXI1eFJMNGJ6NkFRbUJpMkZl?=
 =?utf-8?B?UGhHb3R6ZVd4V2EvbFlRRkdhZXduVXpSSlBER3JLSytyVklvSG5ZanhTS2dX?=
 =?utf-8?B?V25wdnFCMmJkQTNienlWQUdoaXlxZVBDdzd2Wi9PY3l4YmZmZlF3TmFHMEdM?=
 =?utf-8?B?aFp5VnZvSjJpZkl5aWtTaWcvQ2hFbHVrZktrMTVacE1HRnkvZG1VRmNGbXQr?=
 =?utf-8?Q?/abxz7YIr7Ke86V66tMeXV4=3D?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <CABFB021B8A36148A11477C398680BEC@eurprd07.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: eviden.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: AM8PR07MB7602.eurprd07.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 2bd6d0bf-546e-464c-1d36-08dc80a38653
X-MS-Exchange-CrossTenant-originalarrivaltime: 30 May 2024 12:25:00.0946 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 7d1c7785-2d8a-437d-b842-1ed5d8fbe00a
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: PK3jXAXn42tHcufiEVyrGDZSBvkzF+2+X9y50/g0auETSNQXv1FKLYV4jYBJwKFyLTV+CT4gE2ZdGV+Rs5KqTq1cXsRyRp5WPnHFw/2qgP3HsaUnmg75Gb/nByHqCIrr
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AS8PR07MB8069
Received-SPF: pass client-ip=80.78.11.84;
 envelope-from=clement.mathieu--drif@eviden.com; helo=smarthost3.eviden.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, SPF_HELO_PASS=-0.001,
 SPF_PASS=-0.001, T_SCC_BODY_TEXT_LINE=-0.01 autolearn=ham autolearn_force=no
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

dGhlIHByaSBjb25maWd1cmF0aW9uIG9mZnNldCBpcyBhbHNvIHN0b3JlZCBpbnRvIHRoZSBQQ0lF
eHByZXNzRGV2aWNlDQp0byBtYWtlIGl0IGVhc2llciB0byBnZXQgdGhlIFBSSSBzdGF0dXMgcmVn
aXN0ZXINCg0KU2lnbmVkLW9mZi1ieTogQ2zDqW1lbnQgTWF0aGlldS0tRHJpZiA8Y2xlbWVudC5t
YXRoaWV1LS1kcmlmQGV2aWRlbi5jb20+DQotLS0NCiBody9wY2kvcGNpZS5jICAgICAgICAgICAg
ICB8IDI1ICsrKysrKysrKysrKysrKysrKysrKysrKysNCiBpbmNsdWRlL2h3L3BjaS9wY2llLmgg
ICAgICB8ICA1ICsrKystDQogaW5jbHVkZS9ody9wY2kvcGNpZV9yZWdzLmggfCAgNCArKysrDQog
MyBmaWxlcyBjaGFuZ2VkLCAzMyBpbnNlcnRpb25zKCspLCAxIGRlbGV0aW9uKC0pDQoNCmRpZmYg
LS1naXQgYS9ody9wY2kvcGNpZS5jIGIvaHcvcGNpL3BjaWUuYw0KaW5kZXggNGVmZDg0ZmVkNS4u
MDUzYmNhNjk0OSAxMDA2NDQNCi0tLSBhL2h3L3BjaS9wY2llLmMNCisrKyBiL2h3L3BjaS9wY2ll
LmMNCkBAIC0xMjAyLDYgKzEyMDIsMzEgQEAgdm9pZCBwY2llX3Bhc2lkX2luaXQoUENJRGV2aWNl
ICpkZXYsIHVpbnQxNl90IG9mZnNldCwgdWludDhfdCBwYXNpZF93aWR0aCwNCiAgICAgZGV2LT5l
eHAucGFzaWRfY2FwID0gb2Zmc2V0Ow0KIH0NCiANCisvKiBQUkkgKi8NCit2b2lkIHBjaWVfcHJp
X2luaXQoUENJRGV2aWNlICpkZXYsIHVpbnQxNl90IG9mZnNldCwgdWludDMyX3Qgb3V0c3RhbmRp
bmdfcHJfY2FwLA0KKyAgICAgICAgICAgICAgICAgICBib29sIHByZ19yZXNwb25zZV9wYXNpZF9y
ZXEpDQorew0KKyAgICBzdGF0aWMgY29uc3QgdWludDE2X3QgY29udHJvbF9yZWdfcndfbWFzayA9
IDB4MzsNCisgICAgc3RhdGljIGNvbnN0IHVpbnQxNl90IHN0YXR1c19yZWdfcncxX21hc2sgPSAw
eDM7DQorICAgIHN0YXRpYyBjb25zdCB1aW50MzJfdCBwcl9hbGxvY19yZWdfcndfbWFzayA9IDB4
ZmZmZmZmZmY7DQorDQorICAgIHVpbnQxNl90IHN0YXR1c19yZWcgPSBwcmdfcmVzcG9uc2VfcGFz
aWRfcmVxID8gUENJX1BSSV9TVEFUVVNfUEFTSUQgOiAwOw0KKyAgICBzdGF0dXNfcmVnIHw9IFBD
SV9QUklfU1RBVFVTX1NUT1BQRUQ7IC8qIFN0b3BwZWQgYnkgZGVmYXVsdCAqLw0KKw0KKyAgICBw
Y2llX2FkZF9jYXBhYmlsaXR5KGRldiwgUENJX0VYVF9DQVBfSURfUFJJLCBQQ0lfUFJJX1ZFUiwg
b2Zmc2V0LA0KKyAgICAgICAgICAgICAgICAgICAgICAgIFBDSV9FWFRfQ0FQX1BSSV9TSVpFT0Yp
Ow0KKyAgICAvKiBEaXNhYmxlZCBieSBkZWZhdWx0ICovDQorDQorICAgIHBjaV9zZXRfd29yZChk
ZXYtPmNvbmZpZyArIG9mZnNldCArIFBDSV9QUklfU1RBVFVTLCBzdGF0dXNfcmVnKTsNCisgICAg
cGNpX3NldF9sb25nKGRldi0+Y29uZmlnICsgb2Zmc2V0ICsgUENJX1BSSV9NQVhfUkVRLCBvdXRz
dGFuZGluZ19wcl9jYXApOw0KKw0KKyAgICBwY2lfc2V0X3dvcmQoZGV2LT53bWFzayArIG9mZnNl
dCArIFBDSV9QUklfQ1RSTCwgY29udHJvbF9yZWdfcndfbWFzayk7DQorICAgIHBjaV9zZXRfd29y
ZChkZXYtPncxY21hc2sgKyBvZmZzZXQgKyBQQ0lfUFJJX1NUQVRVUywgc3RhdHVzX3JlZ19ydzFf
bWFzayk7DQorICAgIHBjaV9zZXRfbG9uZyhkZXYtPndtYXNrICsgb2Zmc2V0ICsgUENJX1BSSV9B
TExPQ19SRVEsIHByX2FsbG9jX3JlZ19yd19tYXNrKTsNCisNCisgICAgZGV2LT5leHAucHJpX2Nh
cCA9IG9mZnNldDsNCit9DQorDQogYm9vbCBwY2llX3Bhc2lkX2VuYWJsZWQoY29uc3QgUENJRGV2
aWNlICpkZXYpDQogew0KICAgICBpZiAoIXBjaV9pc19leHByZXNzKGRldikgfHwgIWRldi0+ZXhw
LnBhc2lkX2NhcCkgew0KZGlmZiAtLWdpdCBhL2luY2x1ZGUvaHcvcGNpL3BjaWUuaCBiL2luY2x1
ZGUvaHcvcGNpL3BjaWUuaA0KaW5kZXggMGMxMjdiMjlkYy4uMTk4ZDZkYTgxNyAxMDA2NDQNCi0t
LSBhL2luY2x1ZGUvaHcvcGNpL3BjaWUuaA0KKysrIGIvaW5jbHVkZS9ody9wY2kvcGNpZS5oDQpA
QCAtNzIsOSArNzIsMTAgQEAgc3RydWN0IFBDSUV4cHJlc3NEZXZpY2Ugew0KICAgICB1aW50MTZf
dCBhZXJfY2FwOw0KICAgICBQQ0lFQUVSTG9nIGFlcl9sb2c7DQogDQotICAgIC8qIE9mZnNldCBv
ZiBBVFMgYW5kIFBBU0lEIGNhcGFiaWxpdGllcyBpbiBjb25maWcgc3BhY2UgKi8NCisgICAgLyog
T2Zmc2V0IG9mIEFUUywgUFJJIGFuZCBQQVNJRCBjYXBhYmlsaXRpZXMgaW4gY29uZmlnIHNwYWNl
ICovDQogICAgIHVpbnQxNl90IGF0c19jYXA7DQogICAgIHVpbnQxNl90IHBhc2lkX2NhcDsNCisg
ICAgdWludDE2X3QgcHJpX2NhcDsNCiANCiAgICAgLyogQUNTICovDQogICAgIHVpbnQxNl90IGFj
c19jYXA7DQpAQCAtMTU0LDYgKzE1NSw4IEBAIHZvaWQgcGNpZV9jYXBfc2xvdF91bnBsdWdfcmVx
dWVzdF9jYihIb3RwbHVnSGFuZGxlciAqaG90cGx1Z19kZXYsDQogDQogdm9pZCBwY2llX3Bhc2lk
X2luaXQoUENJRGV2aWNlICpkZXYsIHVpbnQxNl90IG9mZnNldCwgdWludDhfdCBwYXNpZF93aWR0
aCwNCiAgICAgICAgICAgICAgICAgICAgICBib29sIGV4ZWNfcGVybSwgYm9vbCBwcml2X21vZCk7
DQordm9pZCBwY2llX3ByaV9pbml0KFBDSURldmljZSAqZGV2LCB1aW50MTZfdCBvZmZzZXQsIHVp
bnQzMl90IG91dHN0YW5kaW5nX3ByX2NhcCwNCisgICAgICAgICAgICAgICAgICAgYm9vbCBwcmdf
cmVzcG9uc2VfcGFzaWRfcmVxKTsNCiANCiBib29sIHBjaWVfcGFzaWRfZW5hYmxlZChjb25zdCBQ
Q0lEZXZpY2UgKmRldik7DQogYm9vbCBwY2llX2F0c19lbmFibGVkKGNvbnN0IFBDSURldmljZSAq
ZGV2KTsNCmRpZmYgLS1naXQgYS9pbmNsdWRlL2h3L3BjaS9wY2llX3JlZ3MuaCBiL2luY2x1ZGUv
aHcvcGNpL3BjaWVfcmVncy5oDQppbmRleCAwYTg2NTk4ZjgwLi5iYjg3OTFkMWIzIDEwMDY0NA0K
LS0tIGEvaW5jbHVkZS9ody9wY2kvcGNpZV9yZWdzLmgNCisrKyBiL2luY2x1ZGUvaHcvcGNpL3Bj
aWVfcmVncy5oDQpAQCAtODksNiArODksMTAgQEAgdHlwZWRlZiBlbnVtIFBDSUV4cExpbmtXaWR0
aCB7DQogLyogUEFTSUQgKi8NCiAjZGVmaW5lIFBDSV9QQVNJRF9WRVIgICAgICAgICAgICAgICAg
ICAgMQ0KICNkZWZpbmUgUENJX0VYVF9DQVBfUEFTSURfTUFYX1dJRFRIICAgICAyMA0KKw0KKy8q
IFBSSSAqLw0KKyNkZWZpbmUgUENJX1BSSV9WRVIgICAgICAgICAgICAgICAgICAgICAxDQorDQog
LyogQUVSICovDQogI2RlZmluZSBQQ0lfRVJSX1ZFUiAgICAgICAgICAgICAgICAgICAgIDINCiAj
ZGVmaW5lIFBDSV9FUlJfU0laRU9GICAgICAgICAgICAgICAgICAgMHg0OA0KLS0gDQoyLjQ1LjEN
Cg==

