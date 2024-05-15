Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id AA7B2C25B77
	for <qemu-devel@archiver.kernel.org>; Wed, 15 May 2024 07:19:20 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1s78rn-0006QG-89; Wed, 15 May 2024 03:15:59 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <clement.mathieu--drif@eviden.com>)
 id 1s78rF-0005An-TY
 for qemu-devel@nongnu.org; Wed, 15 May 2024 03:15:29 -0400
Received: from smarthost3.eviden.com ([80.78.11.84])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <clement.mathieu--drif@eviden.com>)
 id 1s78r1-0000oJ-RT
 for qemu-devel@nongnu.org; Wed, 15 May 2024 03:15:24 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=eviden.com; i=@eviden.com; q=dns/txt; s=mail;
 t=1715757311; x=1747293311;
 h=from:to:cc:subject:date:message-id:references:
 in-reply-to:content-id:content-transfer-encoding: mime-version;
 bh=aKnisHdbFAfgulEF7yIkNe9+bvQwr9U5G5fWP8kqic8=;
 b=nWN8KDReeKonxkijvqwiAJpYR2sET/OwUB+ub8cMUKMFuK02sjXTW03b
 /cSLWa51g9p+5F1481f8wfVGC3OYHdskdk6PswlfjZ7DNXx0lhfcNqb4b
 Nzo218N+2i2eLnkruwhLgEmHI3gq0uQ/u1+ZMrON+r2iAkUp8mI2Cybmb
 UuTrF+vP9OcTs6q++PqYtwExFCiYZNugFtWq/uUJqJJuFI1Z0ySk29NcW
 4tIOlp/6Oq37SrLLeg/nngrN64QkIz3hXGMVw2cr1VJH/aUKT/lxa7G6I
 M1nB2zBjCsJO+6BE60h71HKvWhLj/peFs9zzH2dufBniKWYRplbsnXuhV Q==;
X-IronPort-AV: E=Sophos;i="6.08,161,1712613600"; d="scan'208";a="12581817"
X-MGA-submission: =?us-ascii?q?MDGXDm6pemKBV0ylHiqvuQNKgFoMO9nhaIfc5Y?=
 =?us-ascii?q?re/TZYSDYfWstlXbZExqBVKXxQhopXc7kMR8DgCIT2Vu34jyDHgfRRR6?=
 =?us-ascii?q?5KcjSr0ZHuSzv62qkn208mPNoGwuPXiypDktrwymCBfjMSyspJqDXMaq?=
 =?us-ascii?q?78QEwIv+pcCaL8hhoH4SgbFA=3D=3D?=
Received: from mail-vi1eur04lp2051.outbound.protection.outlook.com (HELO
 EUR04-VI1-obe.outbound.protection.outlook.com) ([104.47.14.51])
 by smarthost3.eviden.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 15 May 2024 09:14:23 +0200
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=KL3WAGJBDzfVJ+YKzNZJl8yK+7NSa3ToEAuAkm/S0UDomzTasgxYBA3LDgl2uJMEqBqjomrrPMtwBe8yStYrlA6rzzl3lykE4Gu99wWTayssJJhqQVwUPHmK/3MAyKv836eHibpV3FhBJCZERfwSli5gg5PV0yI+IZEmrhb5ynthp/hmb8tAZVhLxhZsytHNI4ULwAYy45R7ixgFavBfK6mI08F5ZxzrQuuG98BtgRePvR/OVI9IncWWLH31PwT4TQPiFGLNIILnM2UMv8stnv7SvHHbfNGDUutYvkstQfnDNgcwmd6jRUpVj59O5A1qSIvJx20NrI+v4UTbwZGubg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=aKnisHdbFAfgulEF7yIkNe9+bvQwr9U5G5fWP8kqic8=;
 b=R8AI0y94YrBap/HVfoT5z+9L7rzCsxaoyydox2R3HzdkgD3gYhfab0RAdXRKoJDMLVQJRlTCKsnNa1ZPlXedellDC+1L/XAS3b4SYMiOK5QzQMYXXTyTUUH/g0tFoHaRfG2uEw5LPcDE1hT0bcxbN0g0aDtyczKv/HmUe6g2v+HR9gfkS0Hnf449PQJVK0TrBhYTS07uZO1hNlQBEDvozQohVDaUNDzrXFRMhxdqn8O+CGuT0lcPXMZK1Ckodk7YamKzkxSEJHNpBQkc6H1WCZ0ibUiJ1Z73w5/M4TxHeGNFT5cai7oQMbvqFdWHL6ztSkfgOOPFFYgfDXnXgaU4TQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=eviden.com; dmarc=pass action=none header.from=eviden.com;
 dkim=pass header.d=eviden.com; arc=none
Received: from AM8PR07MB7602.eurprd07.prod.outlook.com (2603:10a6:20b:24b::7)
 by VI1PR07MB6718.eurprd07.prod.outlook.com (2603:10a6:800:18f::21)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7587.27; Wed, 15 May
 2024 07:14:22 +0000
Received: from AM8PR07MB7602.eurprd07.prod.outlook.com
 ([fe80::fbd7:ca71:b636:6f9d]) by AM8PR07MB7602.eurprd07.prod.outlook.com
 ([fe80::fbd7:ca71:b636:6f9d%5]) with mapi id 15.20.7544.056; Wed, 15 May 2024
 07:14:22 +0000
From: CLEMENT MATHIEU--DRIF <clement.mathieu--drif@eviden.com>
To: "qemu-devel@nongnu.org" <qemu-devel@nongnu.org>
CC: "jasowang@redhat.com" <jasowang@redhat.com>, "zhenzhong.duan@intel.com"
 <zhenzhong.duan@intel.com>, "kevin.tian@intel.com" <kevin.tian@intel.com>,
 "yi.l.liu@intel.com" <yi.l.liu@intel.com>, "joao.m.martins@oracle.com"
 <joao.m.martins@oracle.com>, "peterx@redhat.com" <peterx@redhat.com>, CLEMENT
 MATHIEU--DRIF <clement.mathieu--drif@eviden.com>
Subject: [PATCH ats_vtd v2 25/25] intel_iommu: add support for ATS
Thread-Topic: [PATCH ats_vtd v2 25/25] intel_iommu: add support for ATS
Thread-Index: AQHappeCjqBaENfy6kaXOnkN/YX9aA==
Date: Wed, 15 May 2024 07:14:22 +0000
Message-ID: <20240515071057.33990-26-clement.mathieu--drif@eviden.com>
References: <20240515071057.33990-1-clement.mathieu--drif@eviden.com>
In-Reply-To: <20240515071057.33990-1-clement.mathieu--drif@eviden.com>
Accept-Language: en-GB, fr-FR, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=eviden.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: AM8PR07MB7602:EE_|VI1PR07MB6718:EE_
x-ms-office365-filtering-correlation-id: e560f823-9b38-4619-ea1e-08dc74aea509
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0; ARA:13230031|366007|376005|1800799015|38070700009;
x-microsoft-antispam-message-info: =?utf-8?B?Yjl5R00rSFRhelVmOUVMbVUvM1RCSnEwcFoyYXA2VkRuMFI1TDUrQmRSSkF1?=
 =?utf-8?B?Qm9QS3FQRWcxeW1yRVZpR00wM1hwSmNMQWJDdEljYXU4bkx5N0NoNUpCT2VH?=
 =?utf-8?B?bjFEams4Q0pXaDNKcjVWWk5PRlVTQ1c1OGJHQ2VoK0FDK2x0Z3M4UTFXdTV4?=
 =?utf-8?B?c3BWbjA4cm80c3lNakRNR0dJZlh4djZGK052ZWNVbGVTbWw3TENINGdTL0pK?=
 =?utf-8?B?RFRFMlE5eEdpR2V4bVpOUkVyYnRGczBPS01jWnluS0lnTzFNbEN1S3hWZmZR?=
 =?utf-8?B?eUMrc1pSOTFNeG1WdmVidmRMR0M4c2dXOGI5SG0xZWFndDJneXRhL2JnNVpi?=
 =?utf-8?B?ZXhZcUpUZ1FOcERKblQ3SDh4S1huSmhlVm9lYUVZdVh5NU1zWUhhdkx1aWJv?=
 =?utf-8?B?dGRJYVY1Z1pRLzJ1MkFyVU5zMk1UOCt3K2QwVng0L3l0MjR0elhsOGFzQ0hl?=
 =?utf-8?B?NDN5WWxTNTNUbXU1ekhreVU5UkZmWXpZdTZqU0dvU084K0NqUWFVaUt4OVVj?=
 =?utf-8?B?cWhlTnVWZ29tS2JMMXVEMnU1bm9BQXZzZFdTTCtxQ2toS0N6am12Z0xGYlJt?=
 =?utf-8?B?V2hNdGZpMHNFa2FCdEVzOFFQVWdNUjBMUlVULzZ2R0dIRVhYcm9wQjdlTUpX?=
 =?utf-8?B?VlhNcVUzcWNLR0NaN3R5VE8rbTdIZ3VNVEgzTUNNdkt5SkJ0WTNWT3lqRWJp?=
 =?utf-8?B?VVJ6MXZ1bnlNakRXQzMwbjdLMGE5MHB2T0NhSEhtVG04TzNpd0c0Ymt4T0ZP?=
 =?utf-8?B?VGJ5QkNSUktBbnZGcFVPOXVZYzY0NzVhdFl2TGxxOXNMRVpvSHRCTDNPN2lE?=
 =?utf-8?B?S0E2cnVRckwvVmNvTTlzeWNqZWh3bVFjNU9uamliWkNKaDhBSzhmL2l4NVRR?=
 =?utf-8?B?dFBIdHc3QnZZdFRIa2Vma1RXRnE1OUtCMEphOUpmQWZrZU5POVZEaDB2ZkV2?=
 =?utf-8?B?NXl6V2dubGo3TkMyMlMxckRYUlY3Y3hqL1BEaWwrUU01SU8zSFFHQS9XRjVU?=
 =?utf-8?B?Y1NFSkh1Wm1aaEhMWjkzTnErMFAzaFRCcU1haE1OaHJsdURVQlRmaWh4Q3FH?=
 =?utf-8?B?NldVV05sU2thazI1MHlSTlQya1MrQXpsQ1B5UVdmdEVnMENpSCtENXlOR01o?=
 =?utf-8?B?aDc4WXNnODNDbDh1ZFhZMnVwWEY3VmlpK2lvTnIzYXJlSDIvVUZLai9oaXR4?=
 =?utf-8?B?dkFXTmI2bFNGR1F4RHQyRWVDODVoRVhDQWEraDEyMEZDK0p3QnYyaDc5blVU?=
 =?utf-8?B?TEhTVm5XbmJXWDV0LzdvNzF3M25zejQxajZSVFhOMm13NEx5VkRwbGQrNG04?=
 =?utf-8?B?Q3M1eHRJTm54Vmx0cU5wTFIvLy95cVdDdU4zVEN0WXJUby94K1haNFVLbXUv?=
 =?utf-8?B?dlA5Z25NMW5PWXBlS3BaTW5CUlBjc3I3MVBBb0o4YWpUNU9ZMlZ3aVB0N1ND?=
 =?utf-8?B?dHVKM1hJNmZkYm5CVWlhOXJzc2RaQk44QUNtd2QrVVlSSWRFOXlmS2hWeVF4?=
 =?utf-8?B?Y2xKMWtEVWdQcnVGZkgrZ3BLZHlOTVhHY01XM1l6NGJCbkRJWlZQN1VyOHdM?=
 =?utf-8?B?QU9qbHYzd1pwcE5DekNEdjUwOVNRS2o2aHhEWWllOGpqS040U2lod0hXejNs?=
 =?utf-8?B?TVRTSmJyQWwwb05lZU9HV0owbTF5bUFwaHpIY3JkeVFiaDJ3VTFLYXFZWWZW?=
 =?utf-8?B?aWNDZUhDbE13cDBlc1VLSWxSdzV2anpLaGlwaGZ4enVRT2ZJc1ZHb0xqQVg3?=
 =?utf-8?B?L1c4aWZYV2p1Qmhtbnp5SnRHNXRPM2U5WE9nZzI1Ynhlc21QNzhQcDhXVS9v?=
 =?utf-8?B?dHZTTm5vZ0FNZlNuZ0tEZz09?=
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:AM8PR07MB7602.eurprd07.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230031)(366007)(376005)(1800799015)(38070700009); DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?cmpPOUlMQm4rUWxYcUdwWS96MUZQMENEc1lLV0dKdzJDSFMvUE5GMHlHN0tG?=
 =?utf-8?B?QVYxVmJibEtOZlRKR2tGY0JGZVcxU0dYM2dmbVpscWh5VkEvcjFhcEMrUnJG?=
 =?utf-8?B?TVplenEyY2pJSlNyTGRPejJiZWpvVnV3Q0syR3BEMHJmQ3lFN2dpM0FNN2JC?=
 =?utf-8?B?dUhnNTVsU0RSKzNwUUxvaEVlNTg3QmtLbkFZY0NwSGxlbWtZZkgreWFTQkRH?=
 =?utf-8?B?N2hqd1pLMFRseFNMMkFUZTlMeEN2RndIM2crUE5LdHViOEVkbG1hTWpJSzN6?=
 =?utf-8?B?WVlGYXAwdWYyalFGWFJFdHpwaldMQ3gxVjhQRTBkT083NytyWUVlWlJlUFow?=
 =?utf-8?B?bW1ZMW94b2N2UHJIZUNZU2dNcDM0bThXdERXSHNMMnV5NGRjZEVlcDBoUHlm?=
 =?utf-8?B?a2RBNHQ5N3FuUUl1dUJ3U1hOTmZqYUM4TXNqTVIxYitZZTFTZm5wNGQzK0lH?=
 =?utf-8?B?Syt5bzA0SEdQUEg5MFJNeTRCeXJLNVVkdmFNYURJcUxyTmNJOFFiUkdjdUcz?=
 =?utf-8?B?NVZ5UEZmMkpiUVRjajU2QlVWZ3dmMFJwVENhNCtaTFhGTHk5VVp0U3J4ZnpI?=
 =?utf-8?B?bndyTDlXNHgvVyt3Nkw0MS9RUFFTVzVKRFFOQWM1UXk3cTBSVWIyNHZHYkE5?=
 =?utf-8?B?c3pqdHpjOVN3Zk9YSWFKNXhrMDZHaDAzb2lZQWx1MkpzcUdTbU5ucUJ6aW9Q?=
 =?utf-8?B?b0U4ZEl6T1NYQ2UrdWNteUZrYUZOZ1hOYjcwbnJPakE1cmxMSW5JeG42WC9n?=
 =?utf-8?B?bE1JYWwvak9GMlZQcTdJMHFCOFpsVDUrWHRlSEtpZ3d5UnJnNy9pWUpKZUJq?=
 =?utf-8?B?OHA0THBRem04RHlYNnJQWUlDVmxwYlg2c3lxOTZzY2RyRGNGenhZTzhwWU9K?=
 =?utf-8?B?eUp0emJQQnhHTmZzS0ZHeWx4emxVaHRKbHlsV0MySE1GaVpkV3o5VFNhRVdD?=
 =?utf-8?B?Nlhnd3cvVlZ5RWF3TnJUZDhBTWVLdWkrR3dXUnBIUEpUTG83aFgwcU01RU5E?=
 =?utf-8?B?NjlxUE1PTXdWd3lRbENzL1liSEpOTExKKy9mRVNDVVdjL0g1YXJPNlRIb2s4?=
 =?utf-8?B?Mm5GK0xzTHpPaERGNE1XOGNESUVWZG1xb2tZR3lBdnREMDN2NWFmU2tJdWw1?=
 =?utf-8?B?R1hkTUhJUjJaWWF6WEdEVnZPd0YvRktOL0FWVENsOTg0TzlpYUd5N1ZnZjgw?=
 =?utf-8?B?cVBCMWRDbUpOa2x3cGhHMDY2bnZNUjdPcXpNRU8wZ3RnOUxXQXZDM29TSnph?=
 =?utf-8?B?ZFdQN2s1Z0UwSFVGaXBoY3FUcmFlMWtPQ0pPUm4zS2tzOTlDN1lxcnhmcnI1?=
 =?utf-8?B?akswbWlPQno0Qy9EUHBWQldDcmdESTN4OE45T25GVC9rczJVYVlTcmVEV0M4?=
 =?utf-8?B?WlFVYmtvOGNnRUdJcVFzVjZiOXd1aDBFb2lCc3lZOUc0YUtKUVZ3OVZKT0hX?=
 =?utf-8?B?Ti9qcnE0S2tJSW85aHRZR1piWk1XamJJY2dLL0F2L0hPbVRsRUhqWE5OOE9Z?=
 =?utf-8?B?UEJrMWRkY0gvYmtxc2J4bU8zUEo0alZ5ZnJ5S3Rpb0VTSVgvOUM0anQyYUI3?=
 =?utf-8?B?dENyVnlGZHFGYS9XdzAvbER6ZEhzWks5VUdoYzI4N0w5ck5pT2F1a3dFVndP?=
 =?utf-8?B?eWQvTUcvYXRERngvQkhDWVFPYjBMMTFIWnczTG01dFIrVHJvZVNSMTdudDJM?=
 =?utf-8?B?bDFKY2xZRmNpOVlDejdGVCt5L1p4Z2FWUHhXRnpjb2hFM0dJQ3QzdHFvU1NG?=
 =?utf-8?B?RExvSEdwam9JQzZIUzhCWjl1Zk1DV2ZEY2I0TXlRQzN2V282djFkbUNjd28w?=
 =?utf-8?B?NmpnQW56UjFpVDNBTk1jRDRpY0EvV3BkdE5yQ1VIcUlQaTc2TEpTYksxUlQr?=
 =?utf-8?B?SGpEdTVCNWlFRGxXK0NIcnFKdDRRUm9QbU1QTmFWQ0RtTU4wdVRpRTBYUFZV?=
 =?utf-8?B?VjlKeUhSUlk0QXRRbW1pMk9SRGRFTlBJWTJxTDNuYysvQUlxVU8zSW9qOTRz?=
 =?utf-8?B?eEFyUlVBOXk5Qlh5RzlaVjNpbTJsamN1K05pZWs4ZVN1RnE5dHJESEVmNlpp?=
 =?utf-8?B?Vkt6eGNjU1JNb2x4V2k0N1VJa2RSbC9UQ1dFTHBTNkt5RTNsSEhQSldHcUZ0?=
 =?utf-8?B?Q3JBZ0J0QnN1RSsxWUs0V2swdlpLWUU4U3Jla0F6Y1dKeXRydmxKOHBnOTdH?=
 =?utf-8?Q?MLzG1/c/r/EAIXzefG499g0=3D?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <FF4E3BC030934A4289C18F1D20228F14@eurprd07.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: eviden.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: AM8PR07MB7602.eurprd07.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: e560f823-9b38-4619-ea1e-08dc74aea509
X-MS-Exchange-CrossTenant-originalarrivaltime: 15 May 2024 07:14:22.1185 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 7d1c7785-2d8a-437d-b842-1ed5d8fbe00a
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: YRlVO/4RKl0tZbvBPClQdtdT1nMzusoPoCUYqgFJ1s/uDMmx2/jJ2JUXLzqi6/7mMMa6dKkpqUBS28GeAAMo98gWzeK9LPlQeSZkYJ2GuUWC0ZxCuZJjQVYn4KCq46bc
X-MS-Exchange-Transport-CrossTenantHeadersStamped: VI1PR07MB6718
Received-SPF: pass client-ip=80.78.11.84;
 envelope-from=clement.mathieu--drif@eviden.com; helo=smarthost3.eviden.com
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

U2lnbmVkLW9mZi1ieTogQ2zDqW1lbnQgTWF0aGlldS0tRHJpZiA8Y2xlbWVudC5tYXRoaWV1LS1k
cmlmQGV2aWRlbi5jb20+DQotLS0NCiBody9pMzg2L2ludGVsX2lvbW11LmMgICAgICAgICAgfCA3
NSArKysrKysrKysrKysrKysrKysrKysrKysrKysrKysrKy0tDQogaHcvaTM4Ni9pbnRlbF9pb21t
dV9pbnRlcm5hbC5oIHwgIDEgKw0KIDIgZmlsZXMgY2hhbmdlZCwgNzMgaW5zZXJ0aW9ucygrKSwg
MyBkZWxldGlvbnMoLSkNCg0KZGlmZiAtLWdpdCBhL2h3L2kzODYvaW50ZWxfaW9tbXUuYyBiL2h3
L2kzODYvaW50ZWxfaW9tbXUuYw0KaW5kZXggNjdiOWZmNDkzNC4uNzQyMWE5OTM3MyAxMDA2NDQN
Ci0tLSBhL2h3L2kzODYvaW50ZWxfaW9tbXUuYw0KKysrIGIvaHcvaTM4Ni9pbnRlbF9pb21tdS5j
DQpAQCAtNTM5NCwxMiArNTM5NCwxMCBAQCBzdGF0aWMgdm9pZCB2dGRfcmVwb3J0X2lyX2lsbGVn
YWxfYWNjZXNzKFZUREFkZHJlc3NTcGFjZSAqdnRkX2FzLA0KICAgICBib29sIGlzX2ZwZF9zZXQg
PSBmYWxzZTsNCiAgICAgVlREQ29udGV4dEVudHJ5IGNlOw0KIA0KLSAgICBhc3NlcnQodnRkX2Fz
LT5wYXNpZCAhPSBQQ0lfTk9fUEFTSUQpOw0KLQ0KICAgICAvKiBUcnkgb3V0IGJlc3QgdG8gZmV0
Y2ggRlBELCB3ZSBjYW4ndCBkbyBhbnl0aGluZyBtb3JlICovDQogICAgIGlmICh2dGRfZGV2X3Rv
X2NvbnRleHRfZW50cnkocywgYnVzX24sIHZ0ZF9hcy0+ZGV2Zm4sICZjZSkgPT0gMCkgew0KICAg
ICAgICAgaXNfZnBkX3NldCA9IGNlLmxvICYgVlREX0NPTlRFWFRfRU5UUllfRlBEOw0KLSAgICAg
ICAgaWYgKCFpc19mcGRfc2V0ICYmIHMtPnJvb3Rfc2NhbGFibGUpIHsNCisgICAgICAgIGlmICgh
aXNfZnBkX3NldCAmJiBzLT5yb290X3NjYWxhYmxlICYmIHZ0ZF9hcy0+cGFzaWQgIT0gUENJX05P
X1BBU0lEKSB7DQogICAgICAgICAgICAgdnRkX2NlX2dldF9wYXNpZF9mcGQocywgJmNlLCAmaXNf
ZnBkX3NldCwgdnRkX2FzLT5wYXNpZCk7DQogICAgICAgICB9DQogICAgIH0NCkBAIC02MDI0LDYg
KzYwMjIsNzUgQEAgc3RhdGljIElPTU1VTWVtb3J5UmVnaW9uICp2dGRfZ2V0X21lbW9yeV9yZWdp
b25fcGFzaWQoUENJQnVzICpidXMsDQogICAgIHJldHVybiAmdnRkX2FzLT5pb21tdTsNCiB9DQog
DQorc3RhdGljIElPTU1VVExCRW50cnkgdnRkX2lvbW11X2F0c19kb190cmFuc2xhdGUoSU9NTVVN
ZW1vcnlSZWdpb24gKmlvbW11LA0KKyAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAg
ICAgICAgICAgICAgIGh3YWRkciBhZGRyLA0KKyAgICAgICAgICAgICAgICAgICAgICAgICAgICAg
ICAgICAgICAgICAgICAgICAgIElPTU1VQWNjZXNzRmxhZ3MgZmxhZ3MsDQorICAgICAgICAgICAg
ICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgaW50IGlvbW11X2lkeCkNCit7DQor
ICAgIElPTU1VVExCRW50cnkgZW50cnk7DQorICAgIFZUREFkZHJlc3NTcGFjZSAqdnRkX2FzID0g
Y29udGFpbmVyX29mKGlvbW11LCBWVERBZGRyZXNzU3BhY2UsIGlvbW11KTsNCisNCisgICAgaWYg
KHZ0ZF9pc19pbnRlcnJ1cHRfYWRkcihhZGRyKSkgew0KKyAgICAgICAgdnRkX3JlcG9ydF9pcl9p
bGxlZ2FsX2FjY2Vzcyh2dGRfYXMsIGFkZHIsIGZsYWdzICYgSU9NTVVfV08pOw0KKyAgICAgICAg
ZW50cnkuaW92YSA9IDA7DQorICAgICAgICBlbnRyeS50cmFuc2xhdGVkX2FkZHIgPSAwOw0KKyAg
ICAgICAgZW50cnkuYWRkcl9tYXNrID0gflZURF9QQUdFX01BU0tfNEs7DQorICAgICAgICBlbnRy
eS5wZXJtID0gSU9NTVVfTk9ORTsNCisgICAgICAgIGVudHJ5LnBhc2lkID0gUENJX05PX1BBU0lE
Ow0KKyAgICB9IGVsc2Ugew0KKyAgICAgICAgZW50cnkgPSB2dGRfaW9tbXVfdHJhbnNsYXRlKGlv
bW11LCBhZGRyLCBmbGFncywgaW9tbXVfaWR4KTsNCisgICAgfQ0KKyAgICByZXR1cm4gZW50cnk7
DQorfQ0KKw0KK3N0YXRpYyBzc2l6ZV90IHZ0ZF9pb21tdV9hdHNfcmVxdWVzdF90cmFuc2xhdGlv
bihJT01NVU1lbW9yeVJlZ2lvbiAqaW9tbXUsDQorICAgICAgICAgICAgICAgICAgICAgICAgICAg
ICAgICAgICAgICAgICAgICAgICAgIGJvb2wgcHJpdl9yZXEsIGJvb2wgZXhlY19yZXEsDQorICAg
ICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgIGh3YWRkciBhZGRy
LCBzaXplX3QgbGVuZ3RoLA0KKyAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAg
ICAgICAgICAgICBib29sIG5vX3dyaXRlLA0KKyAgICAgICAgICAgICAgICAgICAgICAgICAgICAg
ICAgICAgICAgICAgICAgICAgICBJT01NVVRMQkVudHJ5ICpyZXN1bHQsDQorICAgICAgICAgICAg
ICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgIHNpemVfdCByZXN1bHRfbGVuZ3Ro
LA0KKyAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICB1aW50
MzJfdCAqZXJyX2NvdW50KQ0KK3sNCisgICAgSU9NTVVBY2Nlc3NGbGFncyBmbGFncyA9IElPTU1V
X0FDQ0VTU19GTEFHX0ZVTEwodHJ1ZSwgIW5vX3dyaXRlLCBleGVjX3JlcSwNCisgICAgICAgICAg
ICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgcHJpdl9yZXEsIGZhbHNl
LCBmYWxzZSk7DQorICAgIHNzaXplX3QgcmVzX2luZGV4ID0gMDsNCisgICAgaHdhZGRyIHRhcmdl
dF9hZGRyZXNzID0gYWRkciArIGxlbmd0aDsNCisgICAgSU9NTVVUTEJFbnRyeSBlbnRyeTsNCisN
CisgICAgKmVycl9jb3VudCA9IDA7DQorDQorICAgIHdoaWxlICgoYWRkciA8IHRhcmdldF9hZGRy
ZXNzKSAmJiAocmVzX2luZGV4IDwgcmVzdWx0X2xlbmd0aCkpIHsNCisgICAgICAgIGVudHJ5ID0g
dnRkX2lvbW11X2F0c19kb190cmFuc2xhdGUoaW9tbXUsIGFkZHIsIGZsYWdzLCAwKTsNCisgICAg
ICAgIGlmICghSU9NTVVfVExCX0VOVFJZX1RSQU5TTEFUSU9OX0VSUk9SKCZlbnRyeSkpIHsgLyog
VHJhbnNsYXRpb24gZG9uZSAqLw0KKyAgICAgICAgICAgIGlmIChub193cml0ZSkgew0KKyAgICAg
ICAgICAgICAgICAvKiBUaGUgZGV2aWNlIHNob3VsZCBub3QgdXNlIHRoaXMgZW50cnkgZm9yIGEg
d3JpdGUgYWNjZXNzICovDQorICAgICAgICAgICAgICAgIGVudHJ5LnBlcm0gJj0gfklPTU1VX1dP
Ow0KKyAgICAgICAgICAgIH0NCisgICAgICAgICAgICAvKg0KKyAgICAgICAgICAgICAqIDQuMS4y
IDogR2xvYmFsIE1hcHBpbmcgKEcpIDogUmVtYXBwaW5nIGhhcmR3YXJlIHByb3ZpZGVzIGEgdmFs
dWUNCisgICAgICAgICAgICAgKiBvZiAwIGluIHRoaXMgZmllbGQNCisgICAgICAgICAgICAgKi8N
CisgICAgICAgICAgICBlbnRyeS5wZXJtICY9IH5JT01NVV9HTE9CQUw7DQorICAgICAgICB9IGVs
c2Ugew0KKyAgICAgICAgICAgICplcnJfY291bnQgKz0gMTsNCisgICAgICAgIH0NCisgICAgICAg
IHJlc3VsdFtyZXNfaW5kZXhdID0gZW50cnk7DQorICAgICAgICByZXNfaW5kZXggKz0gMTsNCisg
ICAgICAgIGFkZHIgPSAoYWRkciAmICh+ZW50cnkuYWRkcl9tYXNrKSkgKyAoZW50cnkuYWRkcl9t
YXNrICsgMSk7DQorICAgIH0NCisNCisgICAgLyogQnVmZmVyIHRvbyBzbWFsbCAqLw0KKyAgICBp
ZiAoYWRkciA8IHRhcmdldF9hZGRyZXNzKSB7DQorICAgICAgICByZXR1cm4gLUVOT01FTTsNCisg
ICAgfQ0KKyAgICByZXR1cm4gcmVzX2luZGV4Ow0KK30NCisNCitzdGF0aWMgdWludDY0X3QgdnRk
X2dldF9taW5fcGFnZV9zaXplKElPTU1VTWVtb3J5UmVnaW9uICppb21tdSkNCit7DQorICAgIHJl
dHVybiBWVERfUEFHRV9TSVpFOw0KK30NCisNCiBzdGF0aWMgUENJSU9NTVVPcHMgdnRkX2lvbW11
X29wcyA9IHsNCiAgICAgLmdldF9hZGRyZXNzX3NwYWNlID0gdnRkX2hvc3RfZG1hX2lvbW11LA0K
ICAgICAuZ2V0X2FkZHJlc3Nfc3BhY2VfcGFzaWQgPSB2dGRfaG9zdF9kbWFfaW9tbXVfcGFzaWQs
DQpAQCAtNjIzMCw2ICs2Mjk3LDggQEAgc3RhdGljIHZvaWQgdnRkX2lvbW11X21lbW9yeV9yZWdp
b25fY2xhc3NfaW5pdChPYmplY3RDbGFzcyAqa2xhc3MsDQogICAgIGltcmMtPnRyYW5zbGF0ZSA9
IHZ0ZF9pb21tdV90cmFuc2xhdGU7DQogICAgIGltcmMtPm5vdGlmeV9mbGFnX2NoYW5nZWQgPSB2
dGRfaW9tbXVfbm90aWZ5X2ZsYWdfY2hhbmdlZDsNCiAgICAgaW1yYy0+cmVwbGF5ID0gdnRkX2lv
bW11X3JlcGxheTsNCisgICAgaW1yYy0+aW9tbXVfYXRzX3JlcXVlc3RfdHJhbnNsYXRpb24gPSB2
dGRfaW9tbXVfYXRzX3JlcXVlc3RfdHJhbnNsYXRpb247DQorICAgIGltcmMtPmdldF9taW5fcGFn
ZV9zaXplID0gdnRkX2dldF9taW5fcGFnZV9zaXplOw0KIH0NCiANCiBzdGF0aWMgY29uc3QgVHlw
ZUluZm8gdnRkX2lvbW11X21lbW9yeV9yZWdpb25faW5mbyA9IHsNCmRpZmYgLS1naXQgYS9ody9p
Mzg2L2ludGVsX2lvbW11X2ludGVybmFsLmggYi9ody9pMzg2L2ludGVsX2lvbW11X2ludGVybmFs
LmgNCmluZGV4IDNkNTllMTA0ODguLmFhNGQwZDVmMTYgMTAwNjQ0DQotLS0gYS9ody9pMzg2L2lu
dGVsX2lvbW11X2ludGVybmFsLmgNCisrKyBiL2h3L2kzODYvaW50ZWxfaW9tbXVfaW50ZXJuYWwu
aA0KQEAgLTE5Myw2ICsxOTMsNyBAQA0KICNkZWZpbmUgVlREX0VDQVBfTUhNViAgICAgICAgICAg
ICAgICgxNVVMTCA8PCAyMCkNCiAjZGVmaW5lIFZURF9FQ0FQX05FU1QgICAgICAgICAgICAgICAo
MVVMTCA8PCAyNikNCiAjZGVmaW5lIFZURF9FQ0FQX1NSUyAgICAgICAgICAgICAgICAoMVVMTCA8
PCAzMSkNCisjZGVmaW5lIFZURF9FQ0FQX05XRlMgICAgICAgICAgICAgICAoMVVMTCA8PCAzMykN
CiAjZGVmaW5lIFZURF9FQ0FQX1BTUyAgICAgICAgICAgICAgICAoMTlVTEwgPDwgMzUpDQogI2Rl
ZmluZSBWVERfRUNBUF9QQVNJRCAgICAgICAgICAgICAgKDFVTEwgPDwgNDApDQogI2RlZmluZSBW
VERfRUNBUF9TTVRTICAgICAgICAgICAgICAgKDFVTEwgPDwgNDMpDQotLSANCjIuNDQuMA0K

