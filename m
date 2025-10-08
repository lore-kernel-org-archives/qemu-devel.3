Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7DA0ACCA470
	for <qemu-devel@archiver.kernel.org>; Wed,  8 Oct 2025 10:18:40 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1v6RFb-00026f-FR; Wed, 08 Oct 2025 06:18:28 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <zhenzhong.duan@intel.com>)
 id 1v6RFa-00026M-Qf
 for qemu-devel@nongnu.org; Wed, 08 Oct 2025 06:18:26 -0400
Received: from mgamail.intel.com ([198.175.65.9])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <zhenzhong.duan@intel.com>)
 id 1v6RFY-0003yp-QH
 for qemu-devel@nongnu.org; Wed, 08 Oct 2025 06:18:26 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1759918705; x=1791454705;
 h=from:to:cc:subject:date:message-id:references:
 in-reply-to:content-transfer-encoding:mime-version;
 bh=1Y5Tm96KNadmXGKRlvHdh7eOT9xejSU2EW6/S3SD3hc=;
 b=lFO5vUSkDlj+hsxYIArXGa+hWj8cCmJgwNqDetmEJnALglwkLAojX8VU
 LoIOrHrC0dAAmsoheVbmgVtvQbkJS2r+yCFPkrjhc11PK3F8+irrffDm5
 gpf7V9Uz4o27j6GM26BSavMzDLpPaXMj0azmxrCJ0XOivY0YUNP5J4icN
 ORgQem43cHq3c2U29BiZGmkMy3Oqw7XzqZhOaEbYxe1l8WAB2fFf2oGhw
 PHdI8IDn5XypyzJFrhujG2SvO+kIPOONGNQpfRyZ8OdSqv0TysjQg4a9D
 zy8BP8Vjf7m/EhCMf2ooaJ2l45T/goo68xRINw0SNOd5sDqmGhh4XfYiI w==;
X-CSE-ConnectionGUID: zxdDlzowTT+cOkaXon4irQ==
X-CSE-MsgGUID: gtF9c49LTXWX4N0Z/74XiA==
X-IronPort-AV: E=McAfee;i="6800,10657,11575"; a="84725540"
X-IronPort-AV: E=Sophos;i="6.18,323,1751266800"; d="scan'208";a="84725540"
Received: from fmviesa003.fm.intel.com ([10.60.135.143])
 by orvoesa101.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 08 Oct 2025 03:18:23 -0700
X-CSE-ConnectionGUID: oPr+d3BUQD6tYiMaxrkieQ==
X-CSE-MsgGUID: qOgGyRw1SK6jPkp/5m2HMA==
X-ExtLoop1: 1
Received: from fmsmsx903.amr.corp.intel.com ([10.18.126.92])
 by fmviesa003.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 08 Oct 2025 03:18:22 -0700
Received: from FMSMSX902.amr.corp.intel.com (10.18.126.91) by
 fmsmsx903.amr.corp.intel.com (10.18.126.92) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.27; Wed, 8 Oct 2025 03:18:22 -0700
Received: from fmsedg902.ED.cps.intel.com (10.1.192.144) by
 FMSMSX902.amr.corp.intel.com (10.18.126.91) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.27 via Frontend Transport; Wed, 8 Oct 2025 03:18:22 -0700
Received: from BN1PR04CU002.outbound.protection.outlook.com (52.101.56.50) by
 edgegateway.intel.com (192.55.55.82) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.27; Wed, 8 Oct 2025 03:18:21 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=kKLIQaVmJS2rmIfut+W8uLBuIcOUj4x23hqiX3TB9902CQRs9kE+oyMVjXn/l6dq2hv1k1/kGnLntpuP3TezQ+DAA7jxh1791NuDKJMeJ/9vXxPSGMTeXjA01kpM6xxS5K2YKRVLPsgAlFodQHlt35ApXOugiwecxu+6zs0ICtL+xSmHzVN5JLI8nFFB5IqwHM5/eKx01Ri+ombkAozJX5qqbIgx62ioSNlkXhGoGTXP8TaOp6ZHceq33aRJpHi2soTqrYl2lyRJAxlANFuU0mgKr/vO5csSi9+KJIGpWB8eRQARsk1FSZVY9wZQ8nTYwW3qOam2nv1RaY2D92Fi9g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=jD7cHFC3ZorUJyIivwQaUEZXNfTn32bPNF2hrwFJ74U=;
 b=ZkQIACkgNTpYEJfPB1INdd6PyZQ3Vv0LELVXIJ920mdBkPKtV+u4djpeSgHZCm9+Kgb+ZBhbfKJLUvDotQ6bE0p+8MjlfuZUCm76yF1l8ShZFJrKF7YE8uRnyFMFs3SJv9NmVlzbN2gEE9ry39K84SviLmVmZCmCNeln58iumeTb3SGJeKbkv+JyLmrnuVGyFk1v5+M2FFCy2NfGbUnNqRYFLnxb2U6jYxKihXkMtBzgSTb+mF2GVi6n8eEcceoVpDE3vp40d100WfE9z8c1yzvqcsHAAgVHM5n14ym9JQW4wTcMqxugOPTozIQ+2sRSM7tP5TVAwHqjFT1tK0rojQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Received: from IA3PR11MB9136.namprd11.prod.outlook.com (2603:10b6:208:574::12)
 by SA1PR11MB6662.namprd11.prod.outlook.com (2603:10b6:806:256::19)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9182.20; Wed, 8 Oct
 2025 10:18:19 +0000
Received: from IA3PR11MB9136.namprd11.prod.outlook.com
 ([fe80::604b:77a4:b1be:3f13]) by IA3PR11MB9136.namprd11.prod.outlook.com
 ([fe80::604b:77a4:b1be:3f13%4]) with mapi id 15.20.9115.020; Wed, 8 Oct 2025
 10:18:19 +0000
From: "Duan, Zhenzhong" <zhenzhong.duan@intel.com>
To: =?iso-8859-1?Q?C=E9dric_Le_Goater?= <clg@redhat.com>, John Levon
 <levon@movementarian.org>
CC: "qemu-devel@nongnu.org" <qemu-devel@nongnu.org>,
 "alex.williamson@redhat.com" <alex.williamson@redhat.com>,
 "eric.auger@redhat.com" <eric.auger@redhat.com>, "joao.m.martins@oracle.com"
 <joao.m.martins@oracle.com>
Subject: RE: [PATCH 1/2] vfio/container: Support unmap all in one ioctl()
Thread-Topic: [PATCH 1/2] vfio/container: Support unmap all in one ioctl()
Thread-Index: AQHcLSFOP3lFuvTAwE6oZXK9Hxqc07Sr4xCAgABu9YCAAJVegIAGrApA
Date: Wed, 8 Oct 2025 10:18:19 +0000
Message-ID: <IA3PR11MB91364A76C06D76B0E6ADBEBD92E1A@IA3PR11MB9136.namprd11.prod.outlook.com>
References: <20250924070254.1550014-1-zhenzhong.duan@intel.com>
 <20250924070254.1550014-2-zhenzhong.duan@intel.com>
 <01f0b0eb-b036-4823-8020-fd6962b26d9d@redhat.com>
 <aNxT1w0BbMH6pJ0J@movementarian.org>
 <d715d9dd-a613-4406-93c1-507d1470619f@redhat.com>
In-Reply-To: <d715d9dd-a613-4406-93c1-507d1470619f@redhat.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: IA3PR11MB9136:EE_|SA1PR11MB6662:EE_
x-ms-office365-filtering-correlation-id: fedacadc-4737-47a1-0172-08de065400c1
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0; ARA:13230040|366016|1800799024|376014|38070700021;
x-microsoft-antispam-message-info: =?iso-8859-1?Q?HKx21mrQ5I8jdD5jDAbmO431jZknGUoHBKlv5Oe++Uhj/W2SLh0IJi5cSy?=
 =?iso-8859-1?Q?5BvRjY8JXtVbA58ibSFlK7QGfxWytNanwRMUJeO1JDOGBq1eVlBRDLWtV/?=
 =?iso-8859-1?Q?Qs3liTaXzGrCnZUJMecHHNULlIlDByIVJ7eUwvCseU1ef2UuB2qCRjweaA?=
 =?iso-8859-1?Q?ci4vgBxExLShzvMxfNxCttzAgdqvn+FpZkmpInNb5xA6vzQsSD5C699SZ/?=
 =?iso-8859-1?Q?ggpXsC3prZ9+m3mho4MYf3dFDysO8kRlb0hJSujrSkFIbqc3OfRE0fHrsH?=
 =?iso-8859-1?Q?41NzJRBqaq6Fr7x9pmmh35pJjTpytqbNIR6a2G9ldw2g015UAOqA2tr4wM?=
 =?iso-8859-1?Q?rjWv3zwws/NK7W/qcZs4xGoTLszdEqL8k9IxYHIwr/dwGhFpd+yxgk8a5W?=
 =?iso-8859-1?Q?fzj7jTj7H34FUmNEd0l0yacoHmT6rGouTWveHTnEvfevTElBALaFn1wmnX?=
 =?iso-8859-1?Q?5aKBRllWbwX0ttl863QgxqniIkeq7H/S/vluOZgMR2dh0agvD1qrqXcpbE?=
 =?iso-8859-1?Q?qXmDIeoGCzhjxYZZ6xjEiS5g7i3/uS57nwhP8TZoGSlBg9axejljWeB03N?=
 =?iso-8859-1?Q?Tqk35nTchn1gG6r0IBbBZQdjZeNLbqa7bYjCU/IzcXDmLQSIY6szzwFo4B?=
 =?iso-8859-1?Q?lyesog0lpfko/FTQkReNd4fWgE2hdq+1Jo+YbKT02gzmDmZ0DwmvV2WoCo?=
 =?iso-8859-1?Q?BV00y/eX7H1SGpNhhNzUOxcMbP2TTLQR92yxh6Ejkqhcq1yELLhZPhTm1E?=
 =?iso-8859-1?Q?IXwNIzPn+vSCXqgjyqtWWpSSLVT/9H2ERMEQG3OlJ2zmUVFFa8Bo90xCWm?=
 =?iso-8859-1?Q?HcmA6glggpWEsYnxdJI6oZusUrlcivwbO1p0VbpQKSzE9p1Hb8+eVl6l1S?=
 =?iso-8859-1?Q?wGIVgjAm0z5NmO8srKCfuXfAxd0xQY+IqW14iMHObrBLaP4H1dtqKEchp7?=
 =?iso-8859-1?Q?hT41SQjCz7S+5fTCY+ewCPr9BbJTUosGnMKvpDrGc7cSNwZAYsvs1ucPmL?=
 =?iso-8859-1?Q?1qOa5ySaObSXmBiVkgsQDbfVrX/9YhU/fbwB6KhQauRRLuIMNpwSOTHlCt?=
 =?iso-8859-1?Q?tddYrttQifkiEYrnhGYrpVOmotcFB5uxYiAKIKOUdUPrPgnYnu4YBSyGzl?=
 =?iso-8859-1?Q?n7AI0EF8lSD+sJfBWrHiVDixBzIB+nRKAL1r1klB++L+daickCygv8Eg5R?=
 =?iso-8859-1?Q?zbIrzqYIvv9yqrVRwc/JID3PjCGL7QzEsc5JGYl+kQLCkOCwQS8UcoOu4+?=
 =?iso-8859-1?Q?vuS8mAfHGe6aWp4o1SGsgV8+wz4jB+cHUDDF+8FLI926skvupZU7EuAonG?=
 =?iso-8859-1?Q?w5u7EmfewyvTxE4dj09XU6TZpskmK6PRw06JhkT8E/Arq3KoDYoloACZoi?=
 =?iso-8859-1?Q?fgoTVO78tSoQNp77OHy+hK8L7ppNChKRdchgo1WJydwJx6dkD9trosknX/?=
 =?iso-8859-1?Q?rKrxKTWro1mMLu7VFOlAOOkYsNu2wb30wXiXyDfJMyZfbAv/+XEMZraC7g?=
 =?iso-8859-1?Q?iKQn4vAKNM+iBjiUByQARhzYpDVP1T/N3JS8UpbLJp4jT9NtY5RwCC/pea?=
 =?iso-8859-1?Q?ILygKgBsHEwTH7Dq6zRJJFdnZ3Ny?=
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:IA3PR11MB9136.namprd11.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(366016)(1800799024)(376014)(38070700021); DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?iso-8859-1?Q?0ta7VqCnFoxbWIwc6gsaAgVQ7M0nEfklvg/S6Cw7krleuLrMPavdhT+clu?=
 =?iso-8859-1?Q?hsXoFPBEqWxdYvZwRZo5Lskbq1G+BS0XZUrAkauE5kGMu0TesXdbMQiUBS?=
 =?iso-8859-1?Q?LAOwKBdjPYxwHkXsclqlk4IJSTHMDIl0fGkwvLUrJTD8OZpLzxPRsnxiel?=
 =?iso-8859-1?Q?j9r/f+xu801Ophzl9yTW6T9z1Xw15A4gi7AgLKU5qt+AyhMTOhzyIF2JQD?=
 =?iso-8859-1?Q?i7x0m6BeQr7U1nZuz+P4NCC1HjLW62nd5nxhSq6O/E6bHq+htQ2X57MibF?=
 =?iso-8859-1?Q?5bnYx1Sgt2AgvE5Pa9857ycdQotEr5ZdypGyas48mTY9bRRiv4a6V+jcjO?=
 =?iso-8859-1?Q?s0Z3DlT5RU+WeWSWoUQbiHLozAjaYR2+uhYlj88jiPRcBaU3VM+s9SdOO3?=
 =?iso-8859-1?Q?NKK4BHIhXLH5MkyiVdFV1Oi8T3dOPiD7rH0uGcaAdP+UaFY7D5PlMhUCP1?=
 =?iso-8859-1?Q?yjVOHanb0R67TolHaGm2KQ8RQbtXURXffjeVw7E0E0HwidX1LmAmQd+oyu?=
 =?iso-8859-1?Q?AEGuZxEjAvxylKRyFjA0YyGgQxvH7bPuCRUM+Hi93sMkNYrkxG68IwXEZo?=
 =?iso-8859-1?Q?nMqz0bSTaj7X22mgruhBYSX6pU+eKNphKEsM7XzwUoIimra7xvjEZGzk3H?=
 =?iso-8859-1?Q?FHg+2KLAomzBUeKRKW7b4sg+u8M/Wm5RtVxaOPohfb6/7qnsaqLFhBG9ea?=
 =?iso-8859-1?Q?FLT/lPyKdWSm2sDzRxgQcI2gAjSB/AIRB640DXWiR/3+Sy1ALK8puUMzRZ?=
 =?iso-8859-1?Q?Kz0/1aL4pPcEHNhnI4X2S0b28/YhQNnc5McLfZjfMUQB0TuZw0KWcZ5WfC?=
 =?iso-8859-1?Q?HXZPrSgeJuUT0/bVAK8KDDEOBoTteK70Y1xYzgL0Z+2ReIDz162ioSLdz8?=
 =?iso-8859-1?Q?8MLbZb0/zxo9n2I1R6BXY31L7EYX51x2NjEdG7qzfl2Oa0OI3mRYJXEaKK?=
 =?iso-8859-1?Q?0dBiZAhO/JY0E9/9dZh20VIfkmbWs4ZMQMXmmA6EzWe2ivBEJpIsxKU6SQ?=
 =?iso-8859-1?Q?Q9eXrc9DANvHoEXyMQAVMs/o/q0GeWNlY2yHQo9J+hxxeL3qBU4KXkM4yD?=
 =?iso-8859-1?Q?SpeHRfUKmLEYey5GFRFinTCmDvyA/v5pW2P/IJqo3853WoEfqPiN+nGrxz?=
 =?iso-8859-1?Q?UgIpLu5TGe/6SaA2Ae2cK3PoHVJu4bmXIRKpW4NXgRxcQ3eKcMIFIOSsnb?=
 =?iso-8859-1?Q?fx3JjNxRBGUhCzLYCOPpolppyoU24Hw0cjGVbmdFPYKWqLYOxdih7+WUGp?=
 =?iso-8859-1?Q?Izrp2Jeidj6mRTnPrNcAgvysnTFGJc1Jc43opm6CBD8o+agiRzWDk9LZRP?=
 =?iso-8859-1?Q?j41j9P+6eoHcU4rr8do2yDRqMWIwbrdx27p38ChO6zHCLSx0k9F8f9dviB?=
 =?iso-8859-1?Q?wXp6n26iqM7kGX/ZT0Bf6YS7qIdEqnf4F/p300f7VB88njhn0FGUDS15Vc?=
 =?iso-8859-1?Q?BxiEXbraQJczpFVV4FgiPoK/aZ6B2WIcxxVQ+8DUvfe4TjE2/jVA10oe5u?=
 =?iso-8859-1?Q?LdMu7rXPhruJcMvzU8CzYQ/vIwn3mY6tUqaiI+MSbHe24eGO+LOMKL4/tC?=
 =?iso-8859-1?Q?yn1djSddsFL7b3VgdVFgS8t4ipDeb7WStvDTMYiHbjbCS3hRi6HJ6JR7eX?=
 =?iso-8859-1?Q?gxOf30YJB0SZZcJqGa2fvN011q8F3dwWtL?=
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: IA3PR11MB9136.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: fedacadc-4737-47a1-0172-08de065400c1
X-MS-Exchange-CrossTenant-originalarrivaltime: 08 Oct 2025 10:18:19.2715 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: SdRs/fdqVDM7beT+L8d/3GwC2jB7qfhQtMp3GNnRo7nRKKMMy1dNfs61bb4XLAB78jWxuWR600xVEo9gvhM/YcdnAf1QMO74F+dHLF2ZIeo=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA1PR11MB6662
X-OriginatorOrg: intel.com
Received-SPF: pass client-ip=198.175.65.9;
 envelope-from=zhenzhong.duan@intel.com; helo=mgamail.intel.com
X-Spam_score_int: -47
X-Spam_score: -4.8
X-Spam_bar: ----
X-Spam_report: (-4.8 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.422,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_MED=-2.3, RCVD_IN_VALIDITY_CERTIFIED_BLOCKED=0.001,
 RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001, SPF_HELO_NONE=0.001,
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



>-----Original Message-----
>From: C=E9dric Le Goater <clg@redhat.com>
>Subject: Re: [PATCH 1/2] vfio/container: Support unmap all in one ioctl()
>
>On 10/1/25 00:04, John Levon wrote:
>> On Tue, Sep 30, 2025 at 05:26:59PM +0200, C=E9dric Le Goater wrote:
>>
>>>> -        }
>>>> +        ret =3D ioctl(container->fd, VFIO_CHECK_EXTENSION,
>VFIO_UNMAP_ALL);
>>>
>>> Could we introduce an helper to test 'unmap_all' support in the host
>>> kernel ? The result would be something like :
>>>
>>>    if (unmap_all) {
>>>          if
>(vfio_legacy_has_unmap_all(VFIO_IOMMU_LEGACY(bcontainer))) {
>>>              flags =3D VFIO_DMA_UNMAP_FLAG_ALL;
>>>          } else {
>>>              /* The unmap ioctl doesn't accept a full 64-bit span. */
>>>              Int128 llsize =3D int128_rshift(int128_2_64(), 1);
>>>              ...
>>>          }
>>>    }
>>
>> For reference/consideration, the previous approach taken in the vfio-use=
r
>> series:
>>
>>
>https://lore.kernel.org/qemu-devel/20250219144858.266455-4-john.levon@
>nutanix.com/
>>
>> @@ -533,6 +562,11 @@ static bool vfio_legacy_setup(VFIOContainerBase
>*bcontainer, Error **errp)
>>       vfio_get_info_iova_range(info, bcontainer);
>>
>>       vfio_get_iommu_info_migration(container, info);
>> +
>> +    ret =3D ioctl(container->fd, VFIO_CHECK_EXTENSION,
>VFIO_UNMAP_ALL);
>> +
>> +    container->unmap_all_supported =3D (ret !=3D 0);

Good suggestion, thanks John.

>>
>> (I dropped this particular change as part of getting merged.)
>Yes. I'm reconsidering now.
>
>Should we introduce a VFIOContainerBase attribute/flag
>'unmap_all_supported',
>set in the vioc->setup handler ?

Do you mean to check bcontainer->unmap_all_supported and do the split in vf=
io_listener_region_del()?

If only checking it in legacy container, putting it in VFIOLegacyContainer =
sounds better?

Thanks
Zhenzhong

