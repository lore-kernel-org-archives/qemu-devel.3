Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C5932C25B75
	for <qemu-devel@archiver.kernel.org>; Wed, 15 May 2024 07:18:39 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1s78qV-0004aL-52; Wed, 15 May 2024 03:14:39 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <clement.mathieu--drif@eviden.com>)
 id 1s78qK-0004Xy-B7
 for qemu-devel@nongnu.org; Wed, 15 May 2024 03:14:29 -0400
Received: from smarthost1.eviden.com ([80.78.11.82])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <clement.mathieu--drif@eviden.com>)
 id 1s78qF-0000oX-AE
 for qemu-devel@nongnu.org; Wed, 15 May 2024 03:14:28 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=eviden.com; i=@eviden.com; q=dns/txt; s=mail;
 t=1715757263; x=1747293263;
 h=from:to:cc:subject:date:message-id:references:
 in-reply-to:content-id:content-transfer-encoding: mime-version;
 bh=we+kjz2Cu2q6YkP/UfGNhUBZcgYGej5Wk02odB72gxg=;
 b=HMATLW3K4Gx9PaZ3ZqGDN3bl4xzlzSWjGSHfoUJvkxzLqTWaJH7nPhLk
 /h86k8w0nDmtKv1MJlJF/nPX8Vreaw5wxLlG2SZAkrCZP4dzAODCTVbLy
 h31snZ4PjFzkszTaU5zAOSs/3HCZPP0Nbdk8qUkhE2PrS128PVpcy2QpP
 0jgrn3wYcVTUVrdHy3vKpxh5sSOuDbR3rGwy+EZRuDdGXXfyeTo9tRAu2
 fwW6ikva/t8ba1uKcQmOtLfSE1p6BzAUWdFPWKchv8T+Sl6/wZedtyvVs
 xtcYOg2Jp9diDps/KlvlgAs2gQnlrwEt4UU2Dne7pu9Hgjyr15vD2v4xa A==;
X-IronPort-AV: E=Sophos;i="6.08,161,1712613600"; d="scan'208";a="12580200"
X-MGA-submission: =?us-ascii?q?MDG/UngeG5tFbfb74bx+GLGzcYkjaFuLvdHlwY?=
 =?us-ascii?q?e6Uq8ayALWL0Qiwf7vAW/Xj/Ts73458gvinrywVBBYexoTPlm7gIREys?=
 =?us-ascii?q?6587bBvxx65dXJPn79wOierRvXwmuaIoBsmfcvWTtfGlsUE48+SKdDpD?=
 =?us-ascii?q?hE70rryiw0CXEOktMSiPngbg=3D=3D?=
Received: from mail-db8eur05lp2104.outbound.protection.outlook.com (HELO
 EUR05-DB8-obe.outbound.protection.outlook.com) ([104.47.17.104])
 by smarthost1.eviden.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 15 May 2024 09:14:18 +0200
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=GhUlnoex8SrpzNw33KZ8MYtJeq5KOAiyf/EX8uC9l597FQv5gXzQc/qfJgdVUMwClL8Uqq1bNZtTrH0vBqIqiBw1TXNnOg3ijBA90BOUAyshIQq4n3k/s7YY/lhWjf1gEdKa494PFObDRANfQ+8TsdSSDlzmXLHtgqlozp6Y4vz2ZRk+9arGfFsZcK4pJ2y4YeMmi0uVyW5Z1pUJdIHCteTCtx9CxRoo0oU65XY1uPn5JW+/hCvmh9xTQKXQQPWYvqlD2rXl7TRO7zlVwYmTGlAFgqGiNAaSMWEZoN6FApDRG8iPZeW5Z/zztlFTda62i3Gssfdi8C0VZfaKAQhAvA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=we+kjz2Cu2q6YkP/UfGNhUBZcgYGej5Wk02odB72gxg=;
 b=VxxZ77+++1sCTx3EJ/zW7ywlpG/ulQAtMW1KPDPRw4/IJP5oeQ3CSCT+xat768SPJUcOBP3Qq/6fo7lk+97ymo/e6Ldy7SOr3R/rPTz1R9pUjmn2u+OLyWz0FDGONTWhkwPxrP0yGxTH28ydHeLVclPiHMFOAJyyJFdnG60KlyVKJem3lZLnALcWTrfgwy0ERIGGQr2TGcPkjTGPKJQqBRPFOSf5+5+jAEhncsVa2zkrE8JFeGK/uo8VtXhwifwiJXatvY/kzRPWnqtE1s/q+W6KdJVpkE0U6PIkPjrsdt/EqukPsddsefoRghSXiwZBa4poigOF2zRzcn6aS9TZLQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=eviden.com; dmarc=pass action=none header.from=eviden.com;
 dkim=pass header.d=eviden.com; arc=none
Received: from AM8PR07MB7602.eurprd07.prod.outlook.com (2603:10a6:20b:24b::7)
 by AS5PR07MB9896.eurprd07.prod.outlook.com (2603:10a6:20b:676::11)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7544.55; Wed, 15 May
 2024 07:14:16 +0000
Received: from AM8PR07MB7602.eurprd07.prod.outlook.com
 ([fe80::fbd7:ca71:b636:6f9d]) by AM8PR07MB7602.eurprd07.prod.outlook.com
 ([fe80::fbd7:ca71:b636:6f9d%5]) with mapi id 15.20.7544.056; Wed, 15 May 2024
 07:14:16 +0000
From: CLEMENT MATHIEU--DRIF <clement.mathieu--drif@eviden.com>
To: "qemu-devel@nongnu.org" <qemu-devel@nongnu.org>
CC: "jasowang@redhat.com" <jasowang@redhat.com>, "zhenzhong.duan@intel.com"
 <zhenzhong.duan@intel.com>, "kevin.tian@intel.com" <kevin.tian@intel.com>,
 "yi.l.liu@intel.com" <yi.l.liu@intel.com>, "joao.m.martins@oracle.com"
 <joao.m.martins@oracle.com>, "peterx@redhat.com" <peterx@redhat.com>, CLEMENT
 MATHIEU--DRIF <clement.mathieu--drif@eviden.com>
Subject: [PATCH ats_vtd v2 08/25] memory: add permissions in IOMMUAccessFlags
Thread-Topic: [PATCH ats_vtd v2 08/25] memory: add permissions in
 IOMMUAccessFlags
Thread-Index: AQHappd+1X32ylJH50OSWYK+S1O/wg==
Date: Wed, 15 May 2024 07:14:16 +0000
Message-ID: <20240515071057.33990-9-clement.mathieu--drif@eviden.com>
References: <20240515071057.33990-1-clement.mathieu--drif@eviden.com>
In-Reply-To: <20240515071057.33990-1-clement.mathieu--drif@eviden.com>
Accept-Language: en-GB, fr-FR, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=eviden.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: AM8PR07MB7602:EE_|AS5PR07MB9896:EE_
x-ms-office365-filtering-correlation-id: c398351a-dad0-4328-66c3-08dc74aea16a
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0; ARA:13230031|376005|366007|1800799015|38070700009;
x-microsoft-antispam-message-info: =?utf-8?B?WTBhcWlpMkNOeXBYUEovcWdyRFZGVldOaVAyZVJSUElwM05iRFlMS3VoRE5l?=
 =?utf-8?B?R214ZnRad3NZOGt2RFR0Vk41OW51UjNtSWJBQ1p2REZRU2VYT1FRMlpIOHRK?=
 =?utf-8?B?M0I4WmpocWk2SWxHYVdKKzdGTTZ5WC9vQXVvWFlZZ3JNMFRrYm5jYzlFSGk5?=
 =?utf-8?B?UEkzRzRGYWx3dWo2NjNJaUdZVUtFTENmWWRUdzdGbjN6UUsrRVhNTnBrL1lV?=
 =?utf-8?B?Y2xKeHhqUXNMdlBLdFBlaGhtNjlTejc1djdlVGw5MzhGUmpnMUtKZjkydG9h?=
 =?utf-8?B?OHVwV1c3YXo2cE1uRFNQTHdtZ2RKRHpvREdnN3hOMU93VnZSZ1dVTWhlaGZt?=
 =?utf-8?B?SEdGa1FmREQ5VnovMFA2V2tuU01oaEZ3bjlIT2hsUjZ1dks4OFgwQ0Y0RWMx?=
 =?utf-8?B?VXhzZUVST2dvbjZNd2NOVnNTWWR3Z2sweVVQK2NsL3FhWDlNbGZtdzkvUHB0?=
 =?utf-8?B?UUplS3VkWU1ZYmh6RktUTm9BVlp2MWtOZEF1dmQwUlI5eGs2OG9OcVl0RFI3?=
 =?utf-8?B?dXh6djFXZ1AxMW9xTFAwWWJsV24rOWtmSEFwS200czd4TFNBRUZvWTlySnJr?=
 =?utf-8?B?ZGMxVnVVWmh4LzR1U0duMm1venQ5b3RBMHZFMlBRdUsyRTdhWUdJNC9GVkZG?=
 =?utf-8?B?bTdUWEhIU2kvV09RMEo0aUpNMk8xdVpESFZZM3BidE0rUnJQd096UDdpVXR5?=
 =?utf-8?B?UEQ0L1ZtNzVtamdvRkRZS0lydExrRWlEWWJNclZBUE4yVUNtMlcwVzdNZkVT?=
 =?utf-8?B?Zm9WTWNQSU1BbGtkeTQwRzZQb3d4Y09tRyttaFNnUkg2TW9kdmczT081Tll3?=
 =?utf-8?B?VCtzYy9yRHREWkxuMWtCcllJSzdlM2VqOUlqWEZxd1VqZVlvbFZndXpSZVFl?=
 =?utf-8?B?YkxFaUlGZHBuRHNBSVJzRyttYkFJeDZYbldjYnVHRXFYQlBvTCt2UnJtZnNj?=
 =?utf-8?B?d1pWdXJBYUY3RXI4dDRMaHFIUlZUTjFpUzQzY2lGM0t0VTdScVlQZ2xkTGFs?=
 =?utf-8?B?U3BKbmVHd0NVclpiQ2Z4K0NTbkRPT1Fwd1hRREFrcTdSdzk5RmVoZlV4bEVK?=
 =?utf-8?B?TnlGQ05LMFVwS2VMOFJuTnlyK1Vyc2EvTlAxczFaT0JEc0J6ZDRQMUNKLzBO?=
 =?utf-8?B?dnBqeGNkK0tVK0NWSkphbUFWRGJONStKRG9FYTZXVERPbCs1LzFveHhZd2M5?=
 =?utf-8?B?bm52alBSaDRmRUVLYStydnZBaTErVkhMazZjeWFId3ZQb3Zyc1krUUxoSjhL?=
 =?utf-8?B?WUd3cTRiNUdMZVlkcVNRVFpWUHhsOXNxVGx4TUhCNGtqUUU1VEYwM0QzUG1W?=
 =?utf-8?B?VXFUdUNvNVZQeHZxWXlsSFN3blNWUmhMVC9KQmxIdHZ1Uk4xOHc2VktqOXRr?=
 =?utf-8?B?enJNSWJ0aXN6dlFLb1JnbU9VOVFiSC9seGpBeFNOcmlUVUk2enh2SHhrS3l5?=
 =?utf-8?B?UWYveERZUXdqanM2dVNzbkQ4REFWWCtheGRNRlljdFk0YzZxWmdzWWVyUXpn?=
 =?utf-8?B?R3c2bzUxeDFuM3Erd2djWnQzWTdQZjlTMzduTFFyYzRMYmR5VTVCYXgvRC90?=
 =?utf-8?B?OVRkZTd3Q2tlckJaMEx1bWpmQU44QSs5blcvZE8yc3BqWDFYQytDV1crUUF0?=
 =?utf-8?B?dTFybjZHM1A4RnlSSnRkelZRWmVhdFlHNG1PSUhIWVpsdzdsWE00R0lTaDRV?=
 =?utf-8?B?blNuaFJPaWdYSmxXRXovTWxIUnA3UFlnVXdQOXA5QjNwU1ErRlgzTVQ2YThD?=
 =?utf-8?B?UDM1SmlKd3M4d3lVaUtiOG85VHcxNjE4S296eTY4QXBjV2FzVkE4UWdnV1p5?=
 =?utf-8?B?MlJJZ2Y2QlNUdk4vSkRRQT09?=
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:AM8PR07MB7602.eurprd07.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230031)(376005)(366007)(1800799015)(38070700009); DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?UDlycTdKOUtNVkJSZnlHblhEL1I3dVM0OXVSd3d6OWVKTmppRWtPeXRqSmx6?=
 =?utf-8?B?N0EvdDFqTnhvejVqejN2cWtVdS9wZFFFNzdMcVY2aTJDNFdheVRwWUdUY3RW?=
 =?utf-8?B?VElud0k3WWc2OHBWTkdYRFpOM2JBRU5uQ0xCdVNpc2RBWkw5YVdQRU5Uck1x?=
 =?utf-8?B?bko1OHkya3A4ZDlJclNnQnFIYlJxMEtZbzhzUkp0dmxpYWF4cTRHQUlCbHAw?=
 =?utf-8?B?cjAwZFRXWUwzZUgxb01xdHhERUlyYktpZmMxYXNSTEtnc2lsTW1rbm9naHhE?=
 =?utf-8?B?VUE2VXhmVUJYRGFSSUd6bUlkVWJ3dk5ybWVmeXRvaWRiWUJGS2NyaDBmaGkx?=
 =?utf-8?B?Um9Ub1hnTkVleUFFQ2xOQ1hWcjZkMHJlQzExS1VTUHhCVDJLcGt3S2V1VUJP?=
 =?utf-8?B?K0RnWUJqODJlWjdiRmtMZ2FxbmZZOG5rSFJ4QlZjU2s4QmRrc3FpOWtZRFVL?=
 =?utf-8?B?TE4yVUNDZWt2M1R3Qmt0VlZYVzVEZ1YrYjBCRG53c1FDOG1FVjBBZElud3hq?=
 =?utf-8?B?RzVGNUNleW92SUh1Q21IZlIzWlUzck9ORzV4SEkvT0kranI5RUQ1SjhHaHVU?=
 =?utf-8?B?ZWVlMHpreFNjNkx0NUhTK1dOK2lLc093WlN3VGd6MVBFQXlrZTVRVUFWYTM2?=
 =?utf-8?B?NW9ydUEvRC8wVHhCU1BaNEMyU3FMTkJ5Y1AyY0s2UkFqT1JFVnZKbHNwSWlJ?=
 =?utf-8?B?SWtaM01VeGV2SFM5N3NQbWwwa3lWYTBOR3A3eXI5MDRYVDNzUDBaTDhuR1JW?=
 =?utf-8?B?WWZRcTJwdDBHam0xcTByMFBDaWJkRncyZ3RiNmpJazhMZ1QzN2VsMUJoUDRH?=
 =?utf-8?B?WnFuSVFXUFdjOUFFWWRrU2tKQWFaQllvdWcvODNpN2xKUGxlZnNLdHNQOVhR?=
 =?utf-8?B?T3ppbWRhNExPdlRpU1IrZHRUVWYzdWVTaXRwZ0IxZ3BNYWpHbDdOaUQ5Ui9u?=
 =?utf-8?B?Y2Q2SmxMZlc3Q2RMdWcybXpuNTJQR0pDRWZMeXArVUVndlAzb0k2bHB6Sm43?=
 =?utf-8?B?aHJUdm9HYXN0bVhwQ3Z0ODBvdW9GNU5DS3dZbGdNeUphaTdDUXoyeUE1VUdE?=
 =?utf-8?B?ZDBKeE9UcDQ1NE1HSWtxdGxqdXN5dHQrWXh3cTYxbXB3cGJwZ2N4RFhsWnhM?=
 =?utf-8?B?cklwSDZiZ1dhdE1wVUZBU2xwWHRJK2t6bEVJcnFQTFZ6VEtoNnlielNZY1pq?=
 =?utf-8?B?Tjl5K1BpdEVkTHFsUFloOXYzbmlnQ1kwTHBBbzNvS1dJMlIwQ2xhb1FZSERV?=
 =?utf-8?B?b2g3TUZyRHhzb04ydVIzUjVOZi9lVTljZDh0aHB3WHhrbE5qZFJHVVNESC80?=
 =?utf-8?B?dnN0ZnVBVy8vajdMSEZpZURRUzR2U2VxSU13bktBUWIxM0xudm42VWRTVEEz?=
 =?utf-8?B?a1FhQTFHamZSQkNkVVIycFExd21tWFNJakt1d1VKT29XT3hiY0x3UUkzU0Ew?=
 =?utf-8?B?VWdqM2Qyc0hxVVl3UUtvK1ZkS3NWL1dEbGdaK1VGSWl3VjlObkxiOXdTbVli?=
 =?utf-8?B?VDBWUS9pRGRJbEcrOVp1eHlkVGdZYm9hYmtCWVNFYllSKzhObFZQYllGOEhP?=
 =?utf-8?B?SitCR3JzY2lBSThKbTRzMkdBMnR0R0c0OFRTWTljMkZWUFlyNVZQSmtPZXpi?=
 =?utf-8?B?ZlA4MklEdXZXOUIyT1VOK3FQN29WcnZMdFljeTFBelJsZE9xS0xMOTlvN3Vo?=
 =?utf-8?B?S29ialBLd0JtcVA3c3RQajFCb3d6ZGpkNWxTWGJwWnBWdjZuc2MwUzZtS3Ft?=
 =?utf-8?B?bE9yY2JsMUxXdElBOFI1d2xuaXIyZ0g0Rk1FdGEwUUtSTmhRVDRvUnJybjB2?=
 =?utf-8?B?dVNhQUdwMnE5Vy9jQXpJRDEzQVF0OTBITmFuQlJOMEF6VWNZbXhvcFJoaGU2?=
 =?utf-8?B?amNEVnpLL0VoVEV6M0h3SmtOTFNjMm1QbnJ3S2FFNmNyWHJoOXJJVk15blgz?=
 =?utf-8?B?c0pIWVRRL2c2bk9JRzdZTEJKSVVDYTdBOE4vUmF2ZHhtQkpndVMvS3p1MHI4?=
 =?utf-8?B?ZzZDTzhxM1RlRXZ0bkczMUZXd2l5Nyt4bENQYjZYN0RzWHJkUzhNQ3Uwb2RV?=
 =?utf-8?B?UVJ4Q3V5bTFyVFRReXpneTZNZzhUUlcxSGlac0RlU0lISy8wWEdPMjREYloz?=
 =?utf-8?B?aXdPT2ZSeWhsQi9ENExZcTNIeXJPejlmQzhLMWZjQzNvTURhZG1oZVd5MTdL?=
 =?utf-8?Q?9ny4R72ec5AtTAT6vmFBgbI=3D?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <3733CE74C9BF6F41855D04A026995368@eurprd07.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: eviden.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: AM8PR07MB7602.eurprd07.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: c398351a-dad0-4328-66c3-08dc74aea16a
X-MS-Exchange-CrossTenant-originalarrivaltime: 15 May 2024 07:14:16.0610 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 7d1c7785-2d8a-437d-b842-1ed5d8fbe00a
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: IdDGmkHGhjNije6IwAvr14cnVmj+n3zr/7rZ7jx8Qa0j+zDVJRE2V0T0O85BiaouhNjuvaqxytckvFULF7h+fXQjH8gB93OpS5+YPwjY/jLalEhkopPA4NiG43CmBlxK
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AS5PR07MB9896
Received-SPF: pass client-ip=80.78.11.82;
 envelope-from=clement.mathieu--drif@eviden.com; helo=smarthost1.eviden.com
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

VGhpcyB3aWxsIGJlIG5lY2Vzc2FyeSBmb3IgZGV2aWNlcyBpbXBsZW1lbnRpbmcgQVRTLg0KV2Ug
YWxzbyBkZWZpbmUgYSBuZXcgbWFjcm8gSU9NTVVfQUNDRVNTX0ZMQUdfRlVMTCBpbiBhZGRpdGlv
biB0bw0KSU9NTVVfQUNDRVNTX0ZMQUcgdG8gc3VwcG9ydCBtb3JlIGFjY2VzcyBmbGFncy4NCklP
TU1VX0FDQ0VTU19GTEFHIGlzIGtlcHQgZm9yIGNvbnZlbmllbmNlIGFuZCBiYWNrd2FyZCBjb21w
YXRpYmlsaXR5Lg0KDQpIZXJlIGFyZSB0aGUgZmxhZ3MgYWRkZWQgKGRlZmluZWQgYnkgdGhlIFBD
SWUgNSBzcGVjaWZpY2F0aW9uKSA6DQogICAgLSBFeGVjdXRlIFJlcXVlc3RlZA0KICAgIC0gUHJp
dmlsZWdlZCBNb2RlIFJlcXVlc3RlZA0KICAgIC0gR2xvYmFsDQogICAgLSBVbnRyYW5zbGF0ZWQg
T25seQ0KDQpJT01NVV9BQ0NFU1NfRkxBRyBzZXRzIHRoZSBhZGRpdGlvbmFsIGZsYWdzIHRvIDAN
Cg0KU2lnbmVkLW9mZi1ieTogQ2zDqW1lbnQgTWF0aGlldS0tRHJpZiA8Y2xlbWVudC5tYXRoaWV1
LS1kcmlmQGV2aWRlbi5jb20+DQotLS0NCiBpbmNsdWRlL2V4ZWMvbWVtb3J5LmggfCAyMyArKysr
KysrKysrKysrKysrKysrKystLQ0KIDEgZmlsZSBjaGFuZ2VkLCAyMSBpbnNlcnRpb25zKCspLCAy
IGRlbGV0aW9ucygtKQ0KDQpkaWZmIC0tZ2l0IGEvaW5jbHVkZS9leGVjL21lbW9yeS5oIGIvaW5j
bHVkZS9leGVjL21lbW9yeS5oDQppbmRleCA4NjI2YTM1NWIzLi4yYzBlOTY0YzA3IDEwMDY0NA0K
LS0tIGEvaW5jbHVkZS9leGVjL21lbW9yeS5oDQorKysgYi9pbmNsdWRlL2V4ZWMvbWVtb3J5LmgN
CkBAIC0xMTAsMTUgKzExMCwzNCBAQCBzdHJ1Y3QgTWVtb3J5UmVnaW9uU2VjdGlvbiB7DQogDQog
dHlwZWRlZiBzdHJ1Y3QgSU9NTVVUTEJFbnRyeSBJT01NVVRMQkVudHJ5Ow0KIA0KLS8qIFNlZSBh
ZGRyZXNzX3NwYWNlX3RyYW5zbGF0ZTogYml0IDAgaXMgcmVhZCwgYml0IDEgaXMgd3JpdGUuICAq
Lw0KKy8qDQorICogU2VlIGFkZHJlc3Nfc3BhY2VfdHJhbnNsYXRlOg0KKyAqICAgICAgLSBiaXQg
MCA6IHJlYWQNCisgKiAgICAgIC0gYml0IDEgOiB3cml0ZQ0KKyAqICAgICAgLSBiaXQgMiA6IGV4
ZWMNCisgKiAgICAgIC0gYml0IDMgOiBwcml2DQorICogICAgICAtIGJpdCA0IDogZ2xvYmFsDQor
ICogICAgICAtIGJpdCA1IDogdW50cmFuc2xhdGVkIG9ubHkNCisgKi8NCiB0eXBlZGVmIGVudW0g
ew0KICAgICBJT01NVV9OT05FID0gMCwNCiAgICAgSU9NTVVfUk8gICA9IDEsDQogICAgIElPTU1V
X1dPICAgPSAyLA0KICAgICBJT01NVV9SVyAgID0gMywNCisgICAgSU9NTVVfRVhFQyA9IDQsDQor
ICAgIElPTU1VX1BSSVYgPSA4LA0KKyAgICBJT01NVV9HTE9CQUwgPSAxNiwNCisgICAgSU9NTVVf
VU5UUkFOU0xBVEVEX09OTFkgPSAzMiwNCiB9IElPTU1VQWNjZXNzRmxhZ3M7DQogDQotI2RlZmlu
ZSBJT01NVV9BQ0NFU1NfRkxBRyhyLCB3KSAoKChyKSA/IElPTU1VX1JPIDogMCkgfCAoKHcpID8g
SU9NTVVfV08gOiAwKSkNCisjZGVmaW5lIElPTU1VX0FDQ0VTU19GTEFHKHIsIHcpICAgICAoKChy
KSA/IElPTU1VX1JPIDogMCkgfCBcDQorICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAg
ICAgKCh3KSA/IElPTU1VX1dPIDogMCkpDQorI2RlZmluZSBJT01NVV9BQ0NFU1NfRkxBR19GVUxM
KHIsIHcsIHgsIHAsIGcsIHVvKSBcDQorICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAg
ICAgKElPTU1VX0FDQ0VTU19GTEFHKHIsIHcpIHwgXA0KKyAgICAgICAgICAgICAgICAgICAgICAg
ICAgICAgICAgICAgICgoeCkgPyBJT01NVV9FWEVDIDogMCkgfCBcDQorICAgICAgICAgICAgICAg
ICAgICAgICAgICAgICAgICAgICAgKChwKSA/IElPTU1VX1BSSVYgOiAwKSB8IFwNCisgICAgICAg
ICAgICAgICAgICAgICAgICAgICAgICAgICAgICAoKGcpID8gSU9NTVVfR0xPQkFMIDogMCkgfCBc
DQorICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgKCh1bykgPyBJT01NVV9VTlRS
QU5TTEFURURfT05MWSA6IDApKQ0KIA0KIHN0cnVjdCBJT01NVVRMQkVudHJ5IHsNCiAgICAgQWRk
cmVzc1NwYWNlICAgICp0YXJnZXRfYXM7DQotLSANCjIuNDQuMA0K

