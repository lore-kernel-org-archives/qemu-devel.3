Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 47984C5DF9C
	for <qemu-devel@archiver.kernel.org>; Tue, 25 Aug 2026 03:55:34 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wyiFn-0003Jn-9Z; Mon, 24 Aug 2026 23:55:15 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1)
 (envelope-from <prvs=690dc056c=Alistair.Francis@wdc.com>)
 id 1wyiFl-0003JV-I3; Mon, 24 Aug 2026 23:55:13 -0400
Received: from esa6.hgst.iphmx.com ([216.71.154.45])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1)
 (envelope-from <prvs=690dc056c=Alistair.Francis@wdc.com>)
 id 1wyiFj-00056B-75; Mon, 24 Aug 2026 23:55:13 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
 d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
 t=1787630110; x=1819166110;
 h=from:to:cc:subject:date:message-id:references:
 in-reply-to:content-id:content-transfer-encoding: mime-version;
 bh=1Pcz8RTqjjpI3dGVhcqGYvstLutFr3PrIDLOuLHK6NU=;
 b=p/ChysuM8BXu5L/Kab503GNTkMrUBqAMKMH3f/+PwFMxd2qSS4p1szR0
 U6dlmTSCntpU2mw2KJ0K8L3P0PtbGFN/DpdECSR44Oa1WKnNEnxYKs/z4
 gL1QmwAN8F3LPBDuQYVjD1451V5hidU0dup5wDPkmAoS9YswcXkb7eMdx
 DoGjyMqN5TEvc9PsDfV3MutjqCEqUTx6i5dqrOEYY7UOWpvTvpqCEKtO7
 boqfsDc54+0wzu0GAQ+yIpp2ZBt6Yp57CM1VNGAUGCvTAv2c13xs/9HpD
 2sYdwAHhC6fQvG+dxiXWOYomyGi0HoobCWxpP5Q7XKUnLwAzdLPT8HO28 A==;
X-CSE-ConnectionGUID: 7mR8cburSU+mqCw1v3wBmw==
X-CSE-MsgGUID: LmCwcHe4QrS3VOYdjLAGEQ==
X-IronPort-AV: E=Sophos;i="6.25,241,1779120000"; d="scan'208";a="152627303"
Received: from mail-westusazon11012053.outbound.protection.outlook.com (HELO
 SJ2PR03CU001.outbound.protection.outlook.com) ([52.101.43.53])
 by ob1.hgst.iphmx.com with ESMTP/TLS/ECDHE-RSA-AES128-GCM-SHA256;
 25 Aug 2026 11:55:08 +0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=CUT6ZJVmxjbaphioLTnzMvwIVww5wzvDsrSFpgDcEdGfNKAlOmWqWtZGo+hGORKMhhgpfoFwv9BfpR57zWGaf8J450eZD/6ikMGMQB0RWFD1YpY0XXJJZ6WmG4R5wy+A5KjIFXXKPnvlR3Ik0dDkdSlrKLBFsy7wJXLJHP9Ks5pdFIMlD7adzFg+K8YsJzz38ERIHqVFoFXDHMPtbV4/MmSO3ufB0gsfGeKSSRIyWqz+Oc66jO6fcvXMtJu3aYCf6Q2QuDTxFmMbxMwZdP2chsfUvfbD0NkgYt366gccKNDw4nGzGa2wawbgdEem3dAj4qyIRQ3IN1WGNLrmaBtUiQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=1Pcz8RTqjjpI3dGVhcqGYvstLutFr3PrIDLOuLHK6NU=;
 b=tgm9Q7a1HpKlX63ziVI0lJPMXbXLjjxOWwGGDUvW3v9+gE/QIPP4gzl+V7WJ/arMhlkGbxjjB0Sy5+vA8qvpTPEVVxDZ2vQcJX/DoMvMvQ1dH6qTbZUGDFBl8F18TWCucMpVcZy2N5zJ7etquqtHYZ0p9x5ScU7eB6splvDZ3rPmlRBH34CkXJ4MLWzy55b2lXOuF0KxisEpBNob4lAB2zOWyDdVjrzZtEbGWJkIGx/DbC7LYy2YY11QIXeGykvYA1MW0REq9Ho48T3TEs8loy6/ruUE6406G3VVjsNnkE/lEADyV/K1Te19Xvc7ukySczF/bOWGWux7UglLsd9SIg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=wdc.com; dmarc=pass action=none header.from=wdc.com; dkim=pass
 header.d=wdc.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=sharedspace.onmicrosoft.com; s=selector2-sharedspace-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=1Pcz8RTqjjpI3dGVhcqGYvstLutFr3PrIDLOuLHK6NU=;
 b=v2sP1dkR7v0OAtVug1NSyTJgf9Rfj9j1TYRCJAME2yKvzlJnOO5oeln/B7wRmR02T3A9haKWM3E+8TgtdxnND+rSO905cNSy07yaulUxPBi7T1MC29MFzH+4vC+PKbxAhej8odDOACiFvt69AlMQFwJDYzGzNegM69hv6/xEV18=
Received: from BY1PR04MB9561.namprd04.prod.outlook.com (2603:10b6:a03:5b6::11)
 by BL1PR04MB549746.namprd04.prod.outlook.com (2603:10b6:208:243::21)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.339.12; Tue, 25 Aug
 2026 03:55:07 +0000
Received: from BY1PR04MB9561.namprd04.prod.outlook.com
 ([fe80::3869:e494:2fa8:9888]) by BY1PR04MB9561.namprd04.prod.outlook.com
 ([fe80::3869:e494:2fa8:9888%5]) with mapi id 15.21.0360.005; Tue, 25 Aug 2026
 03:55:06 +0000
From: Alistair Francis <Alistair.Francis@wdc.com>
To: "daniel.barboza@oss.qualcomm.com" <daniel.barboza@oss.qualcomm.com>,
 "qemu-devel@nongnu.org" <qemu-devel@nongnu.org>
CC: "qemu-riscv@nongnu.org" <qemu-riscv@nongnu.org>,
 "chao.liu@processmission.com" <chao.liu@processmission.com>,
 "pierrick.bouvier@oss.qualcomm.com" <pierrick.bouvier@oss.qualcomm.com>,
 "liwei1518@gmail.com" <liwei1518@gmail.com>, "zhiwei_liu@linux.alibaba.com"
 <zhiwei_liu@linux.alibaba.com>
Subject: Re: [PATCH 5/5] docs/specs: add RISC-V CPU Debug support info
Thread-Topic: [PATCH 5/5] docs/specs: add RISC-V CPU Debug support info
Thread-Index: AQHdJQfNcIJaTrWW7EGMyq1DvN5277auQPgA
Date: Tue, 25 Aug 2026 03:55:06 +0000
Message-ID: <28327619f8afa5e1db57d83bad7d0d8e3736574c.camel@wdc.com>
References: <20260805182506.2943757-1-daniel.barboza@oss.qualcomm.com>
 <20260805182506.2943757-6-daniel.barboza@oss.qualcomm.com>
In-Reply-To: <20260805182506.2943757-6-daniel.barboza@oss.qualcomm.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
user-agent: Evolution 3.60.2 (by Flathub.org) 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=wdc.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: BY1PR04MB9561:EE_|BL1PR04MB549746:EE_
x-ms-office365-filtering-correlation-id: 827b835f-8c42-4048-ecf8-08df025ca6dc
wdcipoutbound: EOP-TRUE
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
 ARA:13230040|23010399003|10070799003|366016|1800799024|19092799006|376014|38070700021|6133799003|11063799006|4143699003|10067099003|56012099006|18002099003|22082099003|3023799007;
x-microsoft-antispam-message-info: VaiD+z5NBZZjYGJV3xyTfJMhnXfVqbHGXIzSZeYapxsQdZ1yjlhs2oiiQ8CznbPjaEGYZQWOeinQ/hvZhsyN4brY1iCOWx+QBqF0PvUrZ1G0JhXn6dpuSL8UCnUet6jEWVF2fDQSf+GgwtKl0v0Hz47CPrNFibS2prgK09KtOAOa6IbiAoVIPylr9OBO7pFNrEslw6Uy491LcZxbyF04vE/NgCySeblHWGOS06qN4O8sX8snSGSZNbKzpIGEzN+wXSAdCxleXDm0PvGJniYj7QQ/W+2H1AaeKG56UPDJDwHlsHZHNZNN3DU864/tLc5G8NgVqoApckJj/bur8b2+BglT99OCRFY8G/6l3fQSCfs5sZqvU/0JZbetGTzOGftusuAJVd+faSNSKPWDtcAt0bitIb/Vz+xfXFhdARnix98mDGrAbtb0Ii2vzlblaRZlsb7c0ZEYOi7i6hWPDbi/Bx1UqxC+XzKCCOWq2mYhywm/89ZLo9pSrScbigbUB/7gZ8RbHN5Csbni9I2G9tx6iU5QGt/SL6MAlLLZwZgNtLe60sYiemHmuKwe6mVRhOkW60drr+sDkBUxb5fbWksErhKa5t7Xt3nYONPSPL0WB1lNmT2i8cJvyRY5e47q7WU6n1BMH+a44HU57EvWDw1AULQ3Wf8U5hbHrNt/67xo6uc=
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:BY1PR04MB9561.namprd04.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(23010399003)(10070799003)(366016)(1800799024)(19092799006)(376014)(38070700021)(6133799003)(11063799006)(4143699003)(10067099003)(56012099006)(18002099003)(22082099003)(3023799007);
 DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 2
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?L1Q3dlZGVk1GK25YTEgwaGs4cWNRTnNSWTVKWGFBbVlucnRXNzJWRkExZ2Q2?=
 =?utf-8?B?dWdJYklxS1F0WXFHVkxmSGhjTXlwcFo0NVlBcVNsdENBcTFZZ2VHY0FUMUZL?=
 =?utf-8?B?cU92UDljampXVGxqWU54dCtIVWxxc3RBcW9YaGhPNndUVEJyNmlJUzVha3VW?=
 =?utf-8?B?TXRzQjk3UDhkdnNobTU5QWtPQklyNlp3NlZXYktUbDhlNXVGWEdzbzY2SVVM?=
 =?utf-8?B?c09GaWFrbjJCWGRWY3duTC9uTFY4QXRRYVFzeFMwZXIrZHBUTU1VdGFVWXZP?=
 =?utf-8?B?S3c1U3BkVVA0MnliVXhSYjFTbnBCbGlleEI0b2VJVVhYNFB3K3k2UWVUcjlS?=
 =?utf-8?B?S2xwSXM5T3U5NUJyTjlIL2xTaCt5UzExeUY3N09VNHgzUmxWYUd3WS9KRU5P?=
 =?utf-8?B?ZmpRelJpcFJwZGpRUzhqMEsvcWVQd04rbkpZaWFqMW5YNzR0eklHSFo3eEo2?=
 =?utf-8?B?R1ZjSFc2VGdERitnUkVOdW5HWFpPUmlCWWhGd0JlNFpFTDlQOFo1T2FyYkxZ?=
 =?utf-8?B?R294MWlyUDNoajYvQkhtM0VTNE90TnptVVFsdjF2ZStac1huaTBUUDNMUFpV?=
 =?utf-8?B?bkhQWjQ1OE9JYk0rK3RNN3hHdXY2WHQ4SlgyTllRU24wRUhqZDhOejhDZ1gv?=
 =?utf-8?B?WVdHVUhXdDlvQ25jQVVJZ2hkeXVoV3gwUVN3RnlYTkl2Q2xnUVRXUDduUDQx?=
 =?utf-8?B?STJVeFhnQWFaRnhGc0NobWlPREVtS1Z3NzJhSmltQlpWVk9YZnBZb0N3c1Va?=
 =?utf-8?B?YUN2YmUxSkk1SVBNRHFMN2w1QWxDeWljb1ArMDJkVkd1WGpWeHZ5TnZpd0Zz?=
 =?utf-8?B?d0U0aHl4Q2Q4OWUxbDY2Uk5BZmdQTlZjT2ZTZnBYZHFyVXViam9xdHdLeC9I?=
 =?utf-8?B?ZVlKeUpTN3NoYm9haENmMzllL0Q0UlhTUno4Y1o5WHhLRi9WemF0VHIxNGlp?=
 =?utf-8?B?V1c5UFJuSGZZYWRqTHJBOGdwSjdxRFFQL29ZbTNZVC9nbTZwSlErTWZqODRQ?=
 =?utf-8?B?K0VRSUw4WTU4WUxraXQrUnlzU2lxV3d0OFZNNTh4VUY3cXhOdjRnSlBON0do?=
 =?utf-8?B?UWdVdzg4T2pUd1FJNmxMVDUrNjBKWEpJajJnVTVuTnY1K01oZFJ0T2F4MGZn?=
 =?utf-8?B?SWJNUTNEKzArK2NKaXYrbUpUN0thQnA1U01JMzBPZ3JFbzBJYVp1VWRXMDFO?=
 =?utf-8?B?RlRlSkRYcnpUNU1VRGVtNTdkMFJpTDBtdHcxajZIbi9sQ0lXMndoTm80aU9Z?=
 =?utf-8?B?M0J3RWl6N2VqZlYxbk4yM3htYjJJQXFtUzA4NmFJNnZoWUJ5ZEtOVmdId08w?=
 =?utf-8?B?bFVJalhjcEtvR3BUQWZhSzBOSURXRWsxY05ZdmJwN1psb1Y1d2UrNzk4MnZO?=
 =?utf-8?B?b1dzcHRtVTEyUGhiY3hZMGNwQVAxajhVQTVTNHlVUjQ3Mi9yTUZYZDJZU2lZ?=
 =?utf-8?B?Y0xUSkE0OVlCT0s4WjR4VHBUbW9CSzFzWk5zTW5zTzdVQlROZmF3M1ZZSEZu?=
 =?utf-8?B?K1JkYk9yK2JxNUhnTmVOUmM4WlRicGI4S3FrcGFMd0orNGp1d0JuRHZ6YXRP?=
 =?utf-8?B?aUhrT2VUdStvZW1kUWhMNVdFS25ZZG5PcGM3S2xVNjBVL0txV0lCa1B3NTR6?=
 =?utf-8?B?ZVE1Q3ZsN1NKR3dReFhEbWtqQVB3Qk1CMlJuck95ei9qbitCSUNiVWNJcUF4?=
 =?utf-8?B?b0UrZ3pGaDlrTStnRXNwbXN0Syt0eXhBYUQrN2NpQkthTDRNQjBTUWJQOXBL?=
 =?utf-8?B?Y3ZHVTB5QlFqYWMxaHJ6T01ic2hFTWxTbUNvZFl3ejZMR01xSS9ZTFlCS3ds?=
 =?utf-8?B?ZWUvQ3d2NGhBc0EzeUJVeitaWlNpbEtWNzNmR240MzFGTDU3eWUxcFBuMmwv?=
 =?utf-8?B?SER3ZDh6Sjc2S1UvSXBtNzhHNEh5TFFjNkZ2WjVkM3hNSXQ5R2VkVjdmMzZ5?=
 =?utf-8?B?Z01VL1dTekNic3VZcGtuVlB3V05yTXhLclZjUnFiTzlXSjVkUFBJNlIxSnZU?=
 =?utf-8?B?bFFoS0wvZzVKZk9hNGZJSnBzbzk2Y1ZTZWJXWVF2bjJaZXZaTnVxVEFWd21v?=
 =?utf-8?B?OThFbm9QOWI4c0RCVWVHSlpHdHJtOEtRY0FMRzhQMHVqQ2FFUW96QTN6ajVL?=
 =?utf-8?B?ZEl3aXViZHVEK2V4bXhUVlpXbm5oZ0V0MGpiQ3NSNmN2MXNsMjBvMlorcnFX?=
 =?utf-8?B?YWtFS0RqSjRPWHN5Snp1dUJrT2VpWTBLUlBtWC9CVXkwZzROd2U3M2pFRnZx?=
 =?utf-8?B?ODRYWW9qenIvZlNheVV6MmhXd25HNzhOcFRKcnFRODN3WDlaTXdDL2U2T0g3?=
 =?utf-8?B?a2QveE82bDZPVWFEMHhpVCtnSDNsSHpLaXp4SklNQlpsRk9JcDZTS0NSZDBP?=
 =?utf-8?Q?yK+Rxm8ZNRy3UxjaiLFzo+TBRve+UXtQ40FysA/Zawh47?=
x-ms-exchange-antispam-messagedata-1: RrTOLRUKyzMfwB+XyUt4pCzOoBNkASfr3jA=
Content-Type: text/plain; charset="utf-8"
Content-ID: <1EDF60567D91BB4996BF8460093B45AA@namprd04.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-Exchange-RoutingPolicyChecked: gFqvMkeN4kL+de+dIEiStjSdubh8QH8dtweS/PS+Aj0Cg78jv5/YV1uOnoUnHKcNubazoROGbxedXwPNuct/LyQdBM56hBRDUiLTlq6nSfZ3ULVW50ijGIa7fIvdhepd7CgoXHOQAEP+3jDlwTqKJQGvYOdsiCcH6a1kgBgMnMnmm4yfHmequXvmNxdXbKJVRrX9Dw8ZUylydLjxCMz9J/QiLOA6f/0wCRJZyJqhk2NNDyAw0LU/qnGWagClL/fWouDZjIWRfFw51sdHVjHwtbuumzulAv+/XflNJl//gi96Bdi8BjRfmQ+na1QT1uNPxfTwhrprwS0BH1Y1sE88aA==
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: YUgWuPHscr4GRuaBTRYckmt2tMkdGShyGHe2LWBbgaOACCl6ILu2nlp5PnX+u3JLp+SOvwDRvud0GygLOqHX286dD4e1Iirdv49fRytWozPZC9P4tMv2aOSeyDC1GDOuoDVBs8aah2CK6c2//mzIrIYU9GIueXQdkYa4/6qRluWURJzdD2qlaPitlbePUlzuOYj+jSzAaP+nSO4U0YO1DN8GJLmsJEnmQpjtuyWJuftZTXESFKe58RCMszOzPqktWXfjVzYfz6s0uy9JTQn52AbysRNEXvY4+BUxpts34Sb4iJr6cqwv7sVmZM362bVJaeiSBQtS5gjjgUJu3tQw5CtH9bDNmqwFyFjtGmY2dGVbHWvg4LXYVwTXP5dhsRIh7YfQUVu282/8f2Mtm+NE+qKme3Q7dHUqqeedi+2s4d5DaubbByybi+5/+Zr+yajaKY7XHtGxUhMyp3MhVQ9P3pLshWNyujkjZtUJQ5tTtBJ7SCZz7zsB3TDulhhx9CTbsE6j/y7tszBOXcD/J0NuQeu2sOK6CHAoomycz3Ohdc/kTPJ2J1Yu6aE23F0bVNLYjH0q7FAtp0aBl1IOQIUMqTt5AfdqLa8UTVZwKCzIrJrico2H9oUDz1FbrdrK5tCM
X-OriginatorOrg: wdc.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: BY1PR04MB9561.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 827b835f-8c42-4048-ecf8-08df025ca6dc
X-MS-Exchange-CrossTenant-originalarrivaltime: 25 Aug 2026 03:55:06.9051 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: b61c8803-16f3-4c35-9b17-6f65f441df86
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: UJdppIG0hCQloecMmGozo8SQNJuHjQJR9xmfC4DfE+l9IPYXEP3jQLSasli/VYWWDbGwts++TR9lpU6WWL5ObAh7n3PGSourrjJFcIsntbs=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BL1PR04MB549746
Received-SPF: pass client-ip=216.71.154.45;
 envelope-from=prvs=690dc056c=Alistair.Francis@wdc.com;
 helo=esa6.hgst.iphmx.com
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

T24gV2VkLCAyMDI2LTA4LTA1IGF0IDE1OjI1IC0wMzAwLCBEYW5pZWwgSGVucmlxdWUgQmFyYm96
YSB3cm90ZToNCj4gQWRkIGRvY3VtZW50YXRpb24gcmVnYXJkaW5nIGhvdyBRRU1VIGhhbmRsZXMg
RGVidWcgdmVyc2lvbnMgMC4xMyBhbmQNCj4gMS4wLg0KPiANCj4gU2lnbmVkLW9mZi1ieTogRGFu
aWVsIEhlbnJpcXVlIEJhcmJvemENCj4gPGRhbmllbC5iYXJib3phQG9zcy5xdWFsY29tbS5jb20+
DQoNClJldmlld2VkLWJ5OiBBbGlzdGFpciBGcmFuY2lzIDxhbGlzdGFpci5mcmFuY2lzQHdkYy5j
b20+DQoNCkFsaXN0YWlyDQoNCj4gLS0tDQo+IMKgZG9jcy9zcGVjcy9pbmRleC5yc3TCoMKgwqDC
oMKgwqAgfMKgIDEgKw0KPiDCoGRvY3Mvc3BlY3MvcmlzY3YtZGVidWcucnN0IHwgNjgNCj4gKysr
KysrKysrKysrKysrKysrKysrKysrKysrKysrKysrKysrKysNCj4gwqAyIGZpbGVzIGNoYW5nZWQs
IDY5IGluc2VydGlvbnMoKykNCj4gwqBjcmVhdGUgbW9kZSAxMDA2NDQgZG9jcy9zcGVjcy9yaXNj
di1kZWJ1Zy5yc3QNCj4gDQo+IGRpZmYgLS1naXQgYS9kb2NzL3NwZWNzL2luZGV4LnJzdCBiL2Rv
Y3Mvc3BlY3MvaW5kZXgucnN0DQo+IGluZGV4IGI3OTA5YTEwOGEuLjE4MTc3MzUxNWQgMTAwNjQ0
DQo+IC0tLSBhL2RvY3Mvc3BlY3MvaW5kZXgucnN0DQo+ICsrKyBiL2RvY3Mvc3BlY3MvaW5kZXgu
cnN0DQo+IEBAIC0zOCw1ICszOCw2IEBAIGd1ZXN0IGhhcmR3YXJlIHRoYXQgaXMgc3BlY2lmaWMg
dG8gUUVNVS4NCj4gwqDCoMKgIHJvY2tlcg0KPiDCoMKgwqAgcmlzY3YtaW9tbXUNCj4gwqDCoMKg
IHJpc2N2LWFpYQ0KPiArwqDCoCByaXNjdi1kZWJ1Zw0KPiDCoMKgwqAgYXNwZWVkLWludGMNCj4g
wqDCoMKgIGlvbW11LXRlc3RkZXYNCj4gZGlmZiAtLWdpdCBhL2RvY3Mvc3BlY3MvcmlzY3YtZGVi
dWcucnN0IGIvZG9jcy9zcGVjcy9yaXNjdi1kZWJ1Zy5yc3QNCj4gbmV3IGZpbGUgbW9kZSAxMDA2
NDQNCj4gaW5kZXggMDAwMDAwMDAwMC4uZTZkY2FkN2QzOA0KPiAtLS0gL2Rldi9udWxsDQo+ICsr
KyBiL2RvY3Mvc3BlY3MvcmlzY3YtZGVidWcucnN0DQo+IEBAIC0wLDAgKzEsNjggQEANCj4gKy4u
IFNQRFgtTGljZW5zZS1JZGVudGlmaWVyOiBHUEwtMi4wLW9yLWxhdGVyDQo+ICsNCj4gKy4uIF9y
aXNjdi1kZWJ1ZzoNCj4gKw0KPiArUklTQy1WIERlYnVnIHN1cHBvcnQgZm9yIFJJU0MtViBDUFVz
DQo+ICs9PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT0NCj4gKw0KPiArVXAgdW50
aWwgUUVNVSB2ZXJzaW9uIDExLjEgUklTQy1WIENQVXMgaGlzdG9yaWNhbGx5IHN1cHBvcnRzIERl
YnVnDQo+IHZlcnNpb24NCj4gKzAuMTMgdmlhIGEgImRlYnVnIiBmbGFnIHRoYXQgaXMgZW5hYmxl
ZCBieSBkZWZhdWx0IGluIHRoZSBkZWZhdWx0DQo+IHJ2NjQNCj4gK0NQVS4NCj4gKw0KPiArU3Rh
cnRpbmcgb24gUUVNVSAxMS4yLCBSSVNDLVYgQ1BVcyBzdXBwb3J0cyBhbHNvIERlYnVnIHZlcnNp
b24gMS4wLA0KPiBlbmFibGVkDQo+ICt2aWEgdGhlICJzZHRyaWciIGZsYWcgbGlrZSBhIHJlZ3Vs
YXIgZXh0ZW5zaW9uLsKgIFRoZSBkZWZhdWx0IHNldHRpbmcNCj4gZm9yIHJ2NjQNCj4gK2lzIHN0
aWxsIERlYnVnIDAuMTMgKGRlYnVnID0gb24sIHNkdHJpZyA9IG9mZiksDQo+ICsNCj4gK1RoZSAi
c2R0cmlnIiBmbGFnIHByZWNlZGVzICJkZWJ1ZyIsIGkuZS4gaWYgYm90aCBhcmUgZW5hYmxlZCB0
aGUgQ1BVDQo+IHdpbGwNCj4gK2ltcGxlbWVudCBEZWJ1ZyAxLjAuwqAgSW4gc2hvcnQ6DQo+ICsN
Cj4gKy4uIGxpc3QtdGFibGU6OiAiZGVidWciIGFuZCAic2R0cmlnIiBmbGFncyBhbmQgZW5hYmxl
ZCBEZWJ1ZyB2ZXJzaW9uDQo+ICvCoMKgIDp3aWR0aHM6IDI1IDI1IDI1DQo+ICvCoMKgIDpoZWFk
ZXItcm93czogMQ0KPiArDQo+ICvCoMKgICogLSBkZWJ1Zw0KPiArwqDCoMKgwqAgLSBzZHRyaWcN
Cj4gK8KgwqDCoMKgIC0gRW5hYmxlZCBEZWJ1ZyB2ZXJzaW9uDQo+ICvCoMKgICogLSBvbg0KPiAr
wqDCoMKgwqAgLSBvZmYNCj4gK8KgwqDCoMKgIC0gMC4xMw0KPiArwqDCoCAqIC0gb24NCj4gK8Kg
wqDCoMKgIC0gb24NCj4gK8KgwqDCoMKgIC0gMS4wDQo+ICvCoMKgICogLSBvZmYNCj4gK8KgwqDC
oMKgIC0gb24NCj4gK8KgwqDCoMKgIC0gMS4wDQo+ICvCoMKgICogLSBvZmYNCj4gK8KgwqDCoMKg
IC0gb2ZmDQo+ICvCoMKgwqDCoCAtIEFsbCBEZWJ1ZyB2ZXJzaW9ucyBkaXNhYmxlZA0KPiArDQo+
ICsNCj4gK0RlYnVnIDAuMTMgdG8gMS4wIGNvZGUvZGVzaWduIGNoYW5nZXMNCj4gKy0tLS0tLS0t
LS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0NCj4gKw0KPiArVGhlIGVmZm9ydCBkb25lIGlu
IFFFTVUgdmVyc2lvbiAxMS4yIHRvIHN1cHBvcnQgRGVidWcgdmVyc2lvbnMgMC4xMw0KPiBhbmQN
Cj4gKzEuMCB0b2dldGhlciB3YXMgYmFzZWQgaW4gc2VjdGlvbiAxLjIuMS4yICJJbmNvbXBhdGli
bGUgQ2hhbmdlcyBmcm9tDQo+IDAuMTMNCj4gK3RvIDEuMCIgZnJvbSB0aGUgcmF0aWZpZWQgYDEu
MCBzcGVjYF8uwqAgSGVyZSdzIGhvdyB0aGUgcHJvcG9zZWQNCj4gY2hhbmdlcyBpbg0KPiArdGhh
dCBzZWN0aW9uIHdlcmUgaW1wbGVtZW50ZWQgaW4gUUVNVSAxMS4yOg0KPiArDQo+ICtDaGFuZ2Vz
IHRoYXQgYXJlbid0IGFwcGxpY2FibGUgZHVlIHRvIGVpdGhlciBiZWluZyBTQkkgcmVsYXRlZCBv
cg0KPiBub3QgcHJlc2VudC9zdXBwb3J0ZWQgaW4gUUVNVToNCj4gK8KgwqDCoCAqICJNYWtlIGhh
bHRzdW0wIG9wdGlvbmFsIGlmIHRoZXJlIGlzIG9ubHkgb25lIGhhcnQuIg0KPiArwqDCoMKgICog
IlN5c3RlbSBidXMgYXV0b2luY3JlbWVudCBvbmx5IGhhcHBlbnMgaWYgYW4gYWNjZXNzIGFjdHVh
bGx5DQo+IHRha2VzIHBsYWNlIChzYmRhdGEwKS4iDQo+ICvCoMKgwqAgKiAiUmVxdWlyZSBkZWJ1
Z2dlciB0byBwb2xsIGRtYWN0aXZlIGFmdGVyIGxvd2VyaW5nIGl0LiINCj4gKw0KPiArQWxyZWFk
eSBpbXBsZW1lbnRlZCBpbiB0aGUgbGVnYWN5IERlYnVnIDAuMTMgYmFzZSBjb2RlOg0KPiArwqDC
oMKgICogIldoZW4gYSBzZWxlY3RlZCB0cmlnZ2VyIGlzIGRpc2FibGVkLCB0ZGF0YTIgYW5kIHRk
YXRhMyBjYW4gYmUNCj4gd3JpdHRlbiB3aXRoIGFueSB2YWx1ZSBzdXBwb3J0ZWQgYnkgYW55IG9m
IHRoZSB0eXBlcyB0aGlzIHRyaWdnZXINCj4gc3VwcG9ydHMuIg0KPiArwqDCoMKgICogInRjb250
cm9sIGZpZWxkcyBvbmx5IGFwcGx5IHRvIGJyZWFrcG9pbnQgdHJhcHMsIG5vdCBhbnkNCj4gdHJh
cC4iDQo+ICsNCj4gK0FsbCAiaGl0TiIgZmllbGRzIGFyZSBoYXJkd2lyZWQgMCB0aHVzIG5vIGNo
YW5nZXMgbWFkZToNCj4gK8KgwqDCoCAqICJJZiB2ZXJzaW9uIGlzIGdyZWF0ZXIgdGhhbiAwLCB0
aGVuIGhpdDAgKHByZXZpb3VzbHkgY2FsbGVkDQo+IG1jb250cm9sNi5oaXQpIG5vdyBjb250YWlu
cyAwIHdoZW4gYSB0cmlnZ2VyIGZpcmVzIG1vcmUgdGhhbiBvbmUNCj4gaW5zdHJ1Y3Rpb24gYWZ0
ZXIgdGhlIGluc3RydWN0aW9uIHRoYXQgbWF0Y2hlZC4gKFRoaXMgaW5mb3JtYXRpb24gaXMNCj4g
bm93IHJlZmxlY3RlZCBpbiBoaXQxLikiDQo+ICsNCj4gK1FFTVUgZG9lc24ndCBzdXBwb3J0IGVu
Y29kaW5nIHNpemVzIGdyZWF0ZXIgdGhhbiA2NCBiaXQgc28gbm8gY2hhbmdlDQo+IG1hZGU6DQo+
ICvCoMKgwqAgKiAiSWYgdmVyc2lvbiBpcyBncmVhdGVyIHRoYW4gMCwgdGhlbiB0aGUgZW5jb2Rp
bmdzIG9mIHNpemUgZm9yDQo+IHNpemVzIGdyZWF0ZXIgdGhhbiA2NCBiaXQgaGF2ZSBjaGFuZ2Vk
LiINCj4gKw0KPiArQ2hhbmdlcyBtYWRlIGluIHRoZSAwLjEzIGNvZGViYXNlIHRvIHN1cHBvcnQg
RGVidWcgMS4wOg0KPiArwqDCoMKgICogIkFkZCBwZW5kaW5nIHRvIGljb3VudC4iDQo+ICvCoMKg
wqAgKiAiSWYgdmVyc2lvbiBpcyBncmVhdGVyIHRoYW4gMCwgdGhlbiBiaXQgMjAgb2YgbWNvbnRy
b2w2IGlzIG5vDQo+IGxvbmdlciB1c2VkIGZvciB0aW1pbmcgaW5mb3JtYXRpb24uIChQcmV2aW91
c2x5IHRoZSBiaXQgd2FzIGNhbGxlZA0KPiBtY29udHJvbDYudGltaW5nLikiDQo+ICsNCj4gKw0K
PiArLi4gXzEuMCBzcGVjOg0KPiBodHRwczovL2RvY3MucmlzY3Yub3JnL3JlZmVyZW5jZS9kZWJ1
Zy92MS4wL19hdHRhY2htZW50cy9yaXNjdi1kZWJ1Zy1zcGVjaWZpY2F0aW9uLnBkZg0K

