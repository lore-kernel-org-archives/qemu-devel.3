Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id EA3E7CD98D2
	for <qemu-devel@archiver.kernel.org>; Wed, 17 Jun 2026 01:36:28 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wZfCK-0003eT-BJ; Tue, 16 Jun 2026 21:36:08 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1)
 (envelope-from <prvs=621684bf8=Dmitry.Fomichev@wdc.com>)
 id 1wZfCI-0003e5-FZ; Tue, 16 Jun 2026 21:36:06 -0400
Received: from esa2.hgst.iphmx.com ([68.232.143.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1)
 (envelope-from <prvs=621684bf8=Dmitry.Fomichev@wdc.com>)
 id 1wZfCG-0002P2-52; Tue, 16 Jun 2026 21:36:06 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
 d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
 t=1781660163; x=1813196163;
 h=from:to:cc:subject:date:message-id:references:
 in-reply-to:mime-version;
 bh=5mmxd1dBao2RcaABJdWusbYfIF+pG9+kIjYdaYJHbuw=;
 b=oJ7f0sI6fKrfe5S25jvXk2yo6MnNLHeGWid35lTN/hpG8dMzjY1+cfDX
 F1kH3vT0QgZBsPpGWsadJRzJXFpvQMYQYwELoGyo0sUTbnR6FgubHv5s4
 +8vUvHAxBtnovKduLdHouAlBIAve2qSJkYxBEMlGZbziM+JfeiocBFhag
 yKiNBDV7vI9qtyMZ54kxCddr214552Nb7EE/WTL4ms5x4adBgzyRvoz7W
 W9Fdgs4dY15SnxW5AomB6RzFbjvw2ESmnPF+S45KpDWnzMQT4j3fSBsg9
 e61zcpX7ZxDRctPS0YETMSUe1qF+vE0DLgVT2IwaANxnzNswzQkkveGLQ A==;
X-CSE-ConnectionGUID: B8ZijjB1SjyM3QWx80OqPQ==
X-CSE-MsgGUID: yOZklSVmTrSsvOuvXpduxA==
X-IronPort-AV: E=Sophos;i="6.24,208,1774281600"; 
 d="scan'208,217";a="150176269"
Received: from mail-westcentralusazon11010018.outbound.protection.outlook.com
 (HELO CY7PR03CU001.outbound.protection.outlook.com) ([40.93.198.18])
 by ob1.hgst.iphmx.com with ESMTP/TLS/ECDHE-RSA-AES128-GCM-SHA256;
 17 Jun 2026 09:35:58 +0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=TUxX9IfZQvEf+DNSVa8iriT6GUPcePZxZtSzigGcw4swZV+QBQPhfk8j6R6IMFpZBJQMOPT2OsqoAft9GIXtMSVTbTyeelbDAh3XIuXSw8bVAx7My8x3R+67XUenb82ko+I2fQYJfH50rOrrSyGbhg6C7LmbZAz9PS/nzstxMBACblw4P3qJwevVnqI8WqytRYI56tf65V1yFiasK7tVeL5/BvurCldzBANHmrzQEhCSC52HOcJoMGWin0lpOJJc7a+MqDe7XGWkVC3K1Fl9BYgS9HpcZy96sqIjTkFY+bJntNH2Ws9D04UtYHUa4PfNjs/lreQugTPbBISV1kSN6Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=wWwCrHT8v3bi4+A5KNIvgU3eaqrKA1vDabxQBH2CtBI=;
 b=QvbbiseDNTiE6b2kID5dSe8JHrrbMRPy8CUepvjBTaT5yIHHK3XZKrgFSHvhitQwP4wZlgI/aYTudU5nmDYLqqRkkOkmlBz2UPMFuReBIOBdPJv/KSq7XCWvz/L1TEcgnqTzl9Ig7h3wIS5ds2ygHG6pBSd/8Lop8Db4E8fgFAru+SDU20bYktQuzafrmS1STHTiQfRwZ38UwHwjU6B/jYjjZ6EjBxODnfB/oz7EiyDbveEAX93HcvbbSnNjRstXaSrabCYrBKB1qdqrHp50oGOGopUqPxnRPB/JyLNQEnj08DA83P1O3prWpF83l9Zn8YQwjbi9mCAkW2CXVJyWRw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=wdc.com; dmarc=pass action=none header.from=wdc.com; dkim=pass
 header.d=wdc.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=sharedspace.onmicrosoft.com; s=selector2-sharedspace-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=wWwCrHT8v3bi4+A5KNIvgU3eaqrKA1vDabxQBH2CtBI=;
 b=uqRe4nRnblJzbCLpgJtc4wbIlPtJOyDK85lkfteQvg4WS9MKLIYt88r7yjcawr5WwygKyTekj05oyiwOxqVhKSDRbE0hWZghqdcyVIquIrU6DYKRoRSh34QSo5BmmCFyVEH420Bq3p/JtI3Wx/fCjD1cqOgv4k/agbIQwpBGmjw=
Received: from DS1PR04MB9539.namprd04.prod.outlook.com (2603:10b6:8:220::22)
 by CH2PR04MB6586.namprd04.prod.outlook.com (2603:10b6:610:6e::15) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.113.18; Wed, 17 Jun
 2026 01:35:56 +0000
Received: from DS1PR04MB9539.namprd04.prod.outlook.com
 ([fe80::8528:ecc9:3e9b:11f1]) by DS1PR04MB9539.namprd04.prod.outlook.com
 ([fe80::8528:ecc9:3e9b:11f1%7]) with mapi id 15.21.0113.015; Wed, 17 Jun 2026
 01:35:56 +0000
From: Dmitry Fomichev <Dmitry.Fomichev@wdc.com>
To: Niklas Cassel <cassel@kernel.org>, Kevin Wolf <kwolf@redhat.com>, Hanna
 Reitz <hreitz@redhat.com>
CC: "qemu-block@nongnu.org" <qemu-block@nongnu.org>, "qemu-devel@nongnu.org"
 <qemu-devel@nongnu.org>, Sam Li <faithilikerun@gmail.com>, Stefan Hajnoczi
 <stefanha@redhat.com>, Damien Le Moal <dlemoal@kernel.org>, Johannes
 Thumshirn <Johannes.Thumshirn@wdc.com>
Subject: Re: [PATCH] file-posix: fix cache.direct=on check for zoned block
 devices
Thread-Topic: [PATCH] file-posix: fix cache.direct=on check for zoned block
 devices
Thread-Index: AQHc/Y4SXbVaJP1M4kqoJXQc221/dbZB9qsd
Date: Wed, 17 Jun 2026 01:35:56 +0000
Message-ID: <DS1PR04MB9539485DBE4F22A268FAA63FE1E42@DS1PR04MB9539.namprd04.prod.outlook.com>
References: <20260616124535.1818951-1-cassel@kernel.org>
In-Reply-To: <20260616124535.1818951-1-cassel@kernel.org>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=wdc.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: DS1PR04MB9539:EE_|CH2PR04MB6586:EE_
x-ms-office365-filtering-correlation-id: 56da74f8-6a9f-413c-9a19-08decc10c6e3
wdcipoutbound: EOP-TRUE
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
 ARA:13230040|1800799024|19092799006|376014|23010399003|366016|38070700021|18002099003|22082099003|56012099006|8096899003|11063799006|3023799007|5023799004;
x-microsoft-antispam-message-info: BdKkaCKZSb176qAkSuhS6wVa+RlrQ67lA65PFggoAySyoQ0J7eNqcxH2+Gi35fls31vnW1AHfPUcA4AxDhwiDSqr+K9/oWbxmZPcGDslhckUwmnuXcgHvlSCedY+5B3xucKBSaTLjz00wgoLsSZZL8ub/9IrGeuFRbsEVBLzrpu8LNCam0aHyGi+PAFGvCL8pMCAaR8FIPg/K49DhyIDBwzSGOGBIE/OrsVmtYL0wtTQvxo3efCYzPtlR8yYiajcl9I3XQ/XUBbUryx9S24XkqA2SF816RD18bXFtDrnh5wWrhtsaVl/b3fRBYjLGxdEuEd14PRnQyitdO219o0qQi8ThRPIL+j1oLzdlQ2ObfsFZd7Xdz972LWDN8uOx9k2cFCXwbIaaqMa0D5C88XWQvfMDiuxBgFhC7wy59Zvi/ZAy6c/vYzsF19vVeBQD4YpRfmMLF82jDG1uueSFs6pQYYGIpk0sIFMM2UacTHCVkd/6mstQCVo9WP/evbEcs/OQ7SKfvdCEEO1oh+23LO1shmJ3jtWh+EgK55e03CDALZAHdZlDINx4E4SUYaVfc9JMSD4izY7kbeQ5j/zQpWdKc3H877nWtFBDr3Gve7fRvBHkqn3yD3WTMYoVDTQVfellJoVo0NQWqq7elvzP8MXQauouAWihQE4OVvmDP8q4kdmKyQ9Cnic9jKhzKF5czUgZqDhyT/tT+mbfQaJdml1xLJBa0Q+J/1I+Agyncj83nI2avb8vwU5MNS7SuWnqJHV
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DS1PR04MB9539.namprd04.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(1800799024)(19092799006)(376014)(23010399003)(366016)(38070700021)(18002099003)(22082099003)(56012099006)(8096899003)(11063799006)(3023799007)(5023799004);
 DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?iso-8859-1?Q?5xWjL1FdKEuM9cdrzCid1TuTPJEpMOw0FHbUnPGfR5MRpXTfpXQpDHldlg?=
 =?iso-8859-1?Q?+jGzD7mAviyV/nbW9lzKlYH+apjU4wITey1SAnMlmnBKLdJOpknoGkAgod?=
 =?iso-8859-1?Q?NDgcnWvoB1ribp7vVjwGn4dhMPPPj6dPE2/ggZMD/vKJnOibn/bq4lPNML?=
 =?iso-8859-1?Q?IkBBpsQuBGJtdujVohvw3wTB6sBJcl7gKUxLEhUPstwUn/yoEFyarnHvLo?=
 =?iso-8859-1?Q?5mZe5uttgSE9W6L/OqaajLeLWtO+Xjo/AVz1c8oryNAUd//4to72ApyTTu?=
 =?iso-8859-1?Q?IcYZOejgd84ylZRlG6eRq1aAzWDimAzTrkVcH6iCdI+5/sNUQnN3W2fTBy?=
 =?iso-8859-1?Q?ciTbuxCrzCRieN3Nasq7f+7bMgWtaNUxEp+ZVFJraBdvS3bg6SFHog7YeL?=
 =?iso-8859-1?Q?nky4/YpZaR/EtvebBsKqQTrP1rN8hVf/79qZ/nrlmuVWgLaq7roDILWigm?=
 =?iso-8859-1?Q?NmSeGuLBjvBG6zWGfqixFqJpzZlxybqDH9xSknHk9YTlNmh3u6JCK+euC8?=
 =?iso-8859-1?Q?Ahau9nd4YyBU5PfJ9fYQzMnQ5VhMMp6ijuDcbIV2xRllx2pLZQ0y0t5bfq?=
 =?iso-8859-1?Q?oYkswbX4HGGwaCZfsKvjpTsrP1qxtUzxQ0iDP/8XdIC1fZRZRy3fxhXoRE?=
 =?iso-8859-1?Q?QDJOkV94DcdWcOf4Rtvs/vOvA/HoNYzACh2OnO+Fqky4ieZ8WozYX4T3Rr?=
 =?iso-8859-1?Q?7xy8CFM4i4tSJNDeQTdibk9YU8SZBwatspTN25gGXVrSb+oFOeCYEaAIUI?=
 =?iso-8859-1?Q?AAwbB2a+rIqN4Txrr3osiDz5WR9ssHNQyHuqmF0ENY2o0maOs9raxDO1WN?=
 =?iso-8859-1?Q?7ZBNJvCJ/6RW16LH7btBB8V//T18Ut+2OWDInmC6fdblEoauwpALxNO7lW?=
 =?iso-8859-1?Q?RE8x6Jp7ztvR2Pf7ynyQmLvVC0wWLX6lCqahSdRT5hCG/NJzsfDRfGjCpR?=
 =?iso-8859-1?Q?YOlREbR5loyUnZkcF5mPvOqKUBZG7PZKOl3NBe1GNksk8pI2PRDz+6ZcfX?=
 =?iso-8859-1?Q?OqCgY+0c0jTlHVh4Uv0hOvbMl+Q1DmwPxULWyk4NMrVmWQPWlRE4mOFEu2?=
 =?iso-8859-1?Q?3WicFVCF5tacFnjZt3crlX1+nm+e1ak36UCTksinyVAUX416gsfG1BcTuU?=
 =?iso-8859-1?Q?R15LlEFRZ8v6cubrfOQXmAqQO38J+RWysMI0OtbvyOeb+nw4+29BTEeR74?=
 =?iso-8859-1?Q?nGMGNTGUiACykhgEE/dltARerFoVSuCng+Q3Nhol+F1H+738jbmme6xr3z?=
 =?iso-8859-1?Q?07GxTg0oL2brAl83i/5gDDsjjA/WcWhAWO3lopJCuEeVSGRaT6pr7T0dlH?=
 =?iso-8859-1?Q?Pg/u6F1E9t48OFIoyUhOxcX8qq0xGGXHZld9RbE2215/aRQmRu4AHkeJlY?=
 =?iso-8859-1?Q?SsnrCq77D3WrPUM4EEubB3224HNQngEWGMqxB6pl1uD/nSyRsXZp4vu94B?=
 =?iso-8859-1?Q?eEO76Y8laLR74D0pGiqA9Q+Rt0WhL5rlF39ipQJb2fiTnIUfT//w65rWxn?=
 =?iso-8859-1?Q?Ag8AvUxkiNSPj7bSX94lDD+W7Buxm1qrN0zAj20W8n8dT6V5ArzFOSWDJQ?=
 =?iso-8859-1?Q?AKO8yVjCF+yFuUrQy0Tw1djVWGghm3khShZuVVCIy6FxsfnO505eOwnu33?=
 =?iso-8859-1?Q?DCNZVXcR/t4EdtlwvDNh5DA+yNTDLZgnnrC1Ry+WjNfl27tt1Qns+yZHix?=
 =?iso-8859-1?Q?jWqrv3ItM4zTK4fM5UfHfll3orf/iM65wRmShxBujvs/aBxeg3JY/Y9TzF?=
 =?iso-8859-1?Q?lwXf7UUyy7KtFfMzJbR643O3vsD8PVYQHiREvg7qv4EfcxzhmjsUuA2vLh?=
 =?iso-8859-1?Q?dGaTuHpVQg=3D=3D?=
Content-Type: multipart/alternative;
 boundary="_000_DS1PR04MB9539485DBE4F22A268FAA63FE1E42DS1PR04MB9539namp_"
MIME-Version: 1.0
X-Exchange-RoutingPolicyChecked: T6g8a78/wpkamR4YG0HcBLKrTh7kZLIp7WyDH1vXGrKoe/zyKuSmunrb+oe55KcPt+kOJWNdA+7twwCpf8uMmCNh03e71tucHxvBkKTh6+NuLUAfIFnrEPQBtfmXNDfEmivEEXLqoMKaZONHNNg4YB64BgjwImUE8eYWWm9a8D+4/pzyJOAveGhYjM7z+QjNPPGnJmuTVrOpM1EfJI9scXFqhXU9gDMw844D8VkpIdF1NSHzfF9x8azOUp76xoyDZUij7Gze2oIMIfnfrgYjBffXIRWQLiG5BR8cGdlf9xyXbpIgTUBF4FE3PtOB/9GcSBrcor7NKbC+VxxlIHl5zQ==
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: fDdzn5Po4CBprBEX9RO5BL8hDGxGtnX6qDyaS4fhVV4Z+JNJY3ic3UWb7+nWLqadGmSDVVFr8jvDG4x3IAKath1s7/7QmUelqjA3iXPfI0fo2zWyej5oqqCf9i1M+MQUNy1G37AKxHgYIglTH4DHrKg5zkFfbvbtrvizgS6WDo43XViVAPQtY+W/pelgWVuoFFvXiYcc369TGq6EAhr97qZvH8jpInHKDosKoXvaI+nIA87YF9zNo6LAoCj0fuKDnrHP1uE488bPDcETi+drVf7iriiwcL0MjagtwvdNGoiIUyViXhEq/e3VkYdICsCfyStQgfIEl0C3cqMsEUS0L4pxPC+1qqMb24l4GG2vG5lqOC8dZqCDUWt0A8nE/hj1mIg8gw6758PEujiB1QTf/BlRGtxCiJW9n0Ff/sQY0Uk0xm5npttDaxRvVfp3pWPpzNkdADq3pxfeftigabhZUWe4PLrrBpjLu79wvCf/yrW7kgX6km/gc6fSNVtXhYSIzbPoeJ8F3Eg2l8SckQ+f7X+/YbpukxnfRaOpkHjYSk1R1TPR61IeMUzPz4SO4yumDE1VmbIEZf+mJsNK4cjY/g39+vEReZUEp1Urd2MXikVFTbPEvVyDQ1eTZlLvYzhP
X-OriginatorOrg: wdc.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: DS1PR04MB9539.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 56da74f8-6a9f-413c-9a19-08decc10c6e3
X-MS-Exchange-CrossTenant-originalarrivaltime: 17 Jun 2026 01:35:56.1357 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: b61c8803-16f3-4c35-9b17-6f65f441df86
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: ASZeQfSu+KIGSxsz9IcVCVnkvw6dNMkeUIKsdi2uhlP8SXZdXheoEQdvnP7pBNKgjuai8FvCEayv42UbDimxiQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH2PR04MB6586
Received-SPF: pass client-ip=68.232.143.124;
 envelope-from=prvs=621684bf8=Dmitry.Fomichev@wdc.com; helo=esa2.hgst.iphmx.com
X-Spam_score_int: -43
X-Spam_score: -4.4
X-Spam_bar: ----
X-Spam_report: (-4.4 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, HTML_MESSAGE=0.001,
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

--_000_DS1PR04MB9539485DBE4F22A268FAA63FE1E42DS1PR04MB9539namp_
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable

Looks good.

Reviewed-by: Dmitry Fomichev <dmitry.fomichev@wdc.com>

________________________________
From: Niklas Cassel <cassel@kernel.org>
Sent: Tuesday, June 16, 2026 8:45 AM
To: Kevin Wolf <kwolf@redhat.com>; Hanna Reitz <hreitz@redhat.com>
Cc: qemu-block@nongnu.org <qemu-block@nongnu.org>; qemu-devel@nongnu.org <q=
emu-devel@nongnu.org>; Sam Li <faithilikerun@gmail.com>; Dmitry Fomichev <D=
mitry.Fomichev@wdc.com>; Stefan Hajnoczi <stefanha@redhat.com>; Damien Le M=
oal <dlemoal@kernel.org>; Johannes Thumshirn <Johannes.Thumshirn@wdc.com>; =
Niklas Cassel <cassel@kernel.org>
Subject: [PATCH] file-posix: fix cache.direct=3Don check for zoned block de=
vices

For zoned block devices with SWR zones, the order of the writes must be
maintained to avoid write not at write pointer errors.
Thus, cache.direct=3Don must be used to bypass the page cache, since the
page cache uses write-back caching, where the physical order of the writes
is not guaranteed.

There is already a check for cache.direct=3Don in raw_open_common(),
however, this check is done before raw_refresh_zoned_limits() has been
called (which initializes bs->bl.zoned), so it is currently dead code.

Fix this by moving the check to raw_refresh_zoned_limits(), such that the
check is done after bs->bl.zoned has been initialized.

Fixes: 774c726ceb2a ("block: add zoned BlockDriver check to block layer")
Signed-off-by: Niklas Cassel <cassel@kernel.org>
---
 block/file-posix.c | 22 ++++++++++------------
 1 file changed, 10 insertions(+), 12 deletions(-)

diff --git a/block/file-posix.c b/block/file-posix.c
index 5019ddade9..2cdae2d40c 100644
--- a/block/file-posix.c
+++ b/block/file-posix.c
@@ -800,18 +800,6 @@ static int raw_open_common(BlockDriverState *bs, QDict=
 *options,
             goto fail;
         }
     }
-#ifdef CONFIG_BLKZONED
-    /*
-     * The kernel page cache does not reliably work for writes to SWR zone=
s
-     * of zoned block device because it can not guarantee the order of wri=
tes.
-     */
-    if ((bs->bl.zoned !=3D BLK_Z_NONE) &&
-        (!(s->open_flags & O_DIRECT))) {
-        error_setg(errp, "The driver supports zoned devices, and it requir=
es "
-                         "cache.direct=3Don, which was not specified.");
-        return -EINVAL; /* No host kernel page cache */
-    }
-#endif

 #ifdef __FreeBSD__
     if (S_ISCHR(st.st_mode)) {
@@ -1462,6 +1450,16 @@ static void raw_refresh_zoned_limits(BlockDriverStat=
e *bs, struct stat *st,
     }
     bs->bl.zoned =3D zoned;

+    /*
+     * The kernel page cache does not reliably work for writes to SWR zone=
s
+     * of zoned block device because it can not guarantee the order of wri=
tes.
+     */
+    if (!(s->open_flags & O_DIRECT)) {
+        error_setg(errp, "The driver supports zoned devices, and it requir=
es "
+                         "cache.direct=3Don, which was not specified.");
+        goto no_zoned;
+    }
+
     ret =3D get_sysfs_long_val(st, "max_open_zones");
     if (ret >=3D 0) {
         bs->bl.max_open_zones =3D ret;
--
2.54.0


--_000_DS1PR04MB9539485DBE4F22A268FAA63FE1E42DS1PR04MB9539namp_
Content-Type: text/html; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable

<html>
<head>
<meta http-equiv=3D"Content-Type" content=3D"text/html; charset=3Diso-8859-=
1">
<style type=3D"text/css" style=3D"display:none;"> P {margin-top:0;margin-bo=
ttom:0;} </style>
</head>
<body dir=3D"ltr">
<div class=3D"elementToProof" style=3D"font-family: Aptos, Aptos_EmbeddedFo=
nt, Aptos_MSFontService, Calibri, Helvetica, sans-serif; font-size: 12pt; c=
olor: rgb(0, 0, 0);">
Looks good.</div>
<div class=3D"elementToProof" style=3D"font-family: Aptos, Aptos_EmbeddedFo=
nt, Aptos_MSFontService, Calibri, Helvetica, sans-serif; font-size: 12pt; c=
olor: rgb(0, 0, 0);">
<br>
</div>
<div class=3D"elementToProof" style=3D"font-family: Aptos, Aptos_EmbeddedFo=
nt, Aptos_MSFontService, Calibri, Helvetica, sans-serif; font-size: 12pt; c=
olor: rgb(0, 0, 0);">
Reviewed-by: Dmitry Fomichev &lt;dmitry.fomichev@wdc.com&gt;</div>
<div id=3D"appendonsend"></div>
<div style=3D"font-family: Aptos, Aptos_EmbeddedFont, Aptos_MSFontService, =
Calibri, Helvetica, sans-serif; font-size: 12pt; color: rgb(0, 0, 0);">
<br>
</div>
<hr style=3D"display: inline-block; width: 98%;">
<div id=3D"divRplyFwdMsg">
<div style=3D"direction: ltr; font-family: Calibri, sans-serif; font-size: =
11pt; color: rgb(0, 0, 0);">
<b>From:</b>&nbsp;Niklas Cassel &lt;cassel@kernel.org&gt;<br>
<b>Sent:</b>&nbsp;Tuesday, June 16, 2026 8:45 AM<br>
<b>To:</b>&nbsp;Kevin Wolf &lt;kwolf@redhat.com&gt;; Hanna Reitz &lt;hreitz=
@redhat.com&gt;<br>
<b>Cc:</b>&nbsp;qemu-block@nongnu.org &lt;qemu-block@nongnu.org&gt;; qemu-d=
evel@nongnu.org &lt;qemu-devel@nongnu.org&gt;; Sam Li &lt;faithilikerun@gma=
il.com&gt;; Dmitry Fomichev &lt;Dmitry.Fomichev@wdc.com&gt;; Stefan Hajnocz=
i &lt;stefanha@redhat.com&gt;; Damien Le Moal &lt;dlemoal@kernel.org&gt;;
 Johannes Thumshirn &lt;Johannes.Thumshirn@wdc.com&gt;; Niklas Cassel &lt;c=
assel@kernel.org&gt;<br>
<b>Subject:</b>&nbsp;[PATCH] file-posix: fix cache.direct=3Don check for zo=
ned block devices</div>
<div style=3D"direction: ltr;">&nbsp;</div>
</div>
<div style=3D"font-size: 11pt;">For zoned block devices with SWR zones, the=
 order of the writes must be<br>
maintained to avoid write not at write pointer errors.<br>
Thus, cache.direct=3Don must be used to bypass the page cache, since the<br=
>
page cache uses write-back caching, where the physical order of the writes<=
br>
is not guaranteed.<br>
<br>
There is already a check for cache.direct=3Don in raw_open_common(),<br>
however, this check is done before raw_refresh_zoned_limits() has been<br>
called (which initializes bs-&gt;bl.zoned), so it is currently dead code.<b=
r>
<br>
Fix this by moving the check to raw_refresh_zoned_limits(), such that the<b=
r>
check is done after bs-&gt;bl.zoned has been initialized.<br>
<br>
Fixes: 774c726ceb2a (&quot;block: add zoned BlockDriver check to block laye=
r&quot;)<br>
Signed-off-by: Niklas Cassel &lt;cassel@kernel.org&gt;<br>
---<br>
&nbsp;block/file-posix.c | 22 ++++++++++------------<br>
&nbsp;1 file changed, 10 insertions(+), 12 deletions(-)<br>
<br>
diff --git a/block/file-posix.c b/block/file-posix.c<br>
index 5019ddade9..2cdae2d40c 100644<br>
--- a/block/file-posix.c<br>
+++ b/block/file-posix.c<br>
@@ -800,18 +800,6 @@ static int raw_open_common(BlockDriverState *bs, QDict=
 *options,<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; go=
to fail;<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; }<br>
&nbsp;&nbsp;&nbsp;&nbsp; }<br>
-#ifdef CONFIG_BLKZONED<br>
-&nbsp;&nbsp;&nbsp; /*<br>
-&nbsp;&nbsp;&nbsp;&nbsp; * The kernel page cache does not reliably work fo=
r writes to SWR zones<br>
-&nbsp;&nbsp;&nbsp;&nbsp; * of zoned block device because it can not guaran=
tee the order of writes.<br>
-&nbsp;&nbsp;&nbsp;&nbsp; */<br>
-&nbsp;&nbsp;&nbsp; if ((bs-&gt;bl.zoned !=3D BLK_Z_NONE) &amp;&amp;<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; (!(s-&gt;open_flags &amp; O_DIR=
ECT))) {<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; error_setg(errp, &quot;The driv=
er supports zoned devices, and it requires &quot;<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; &quo=
t;cache.direct=3Don, which was not specified.&quot;);<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; return -EINVAL; /* No host kern=
el page cache */<br>
-&nbsp;&nbsp;&nbsp; }<br>
-#endif<br>
&nbsp;<br>
&nbsp;#ifdef __FreeBSD__<br>
&nbsp;&nbsp;&nbsp;&nbsp; if (S_ISCHR(st.st_mode)) {<br>
@@ -1462,6 +1450,16 @@ static void raw_refresh_zoned_limits(BlockDriverStat=
e *bs, struct stat *st,<br>
&nbsp;&nbsp;&nbsp;&nbsp; }<br>
&nbsp;&nbsp;&nbsp;&nbsp; bs-&gt;bl.zoned =3D zoned;<br>
&nbsp;<br>
+&nbsp;&nbsp;&nbsp; /*<br>
+&nbsp;&nbsp;&nbsp;&nbsp; * The kernel page cache does not reliably work fo=
r writes to SWR zones<br>
+&nbsp;&nbsp;&nbsp;&nbsp; * of zoned block device because it can not guaran=
tee the order of writes.<br>
+&nbsp;&nbsp;&nbsp;&nbsp; */<br>
+&nbsp;&nbsp;&nbsp; if (!(s-&gt;open_flags &amp; O_DIRECT)) {<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; error_setg(errp, &quot;The driv=
er supports zoned devices, and it requires &quot;<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; &quo=
t;cache.direct=3Don, which was not specified.&quot;);<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; goto no_zoned;<br>
+&nbsp;&nbsp;&nbsp; }<br>
+<br>
&nbsp;&nbsp;&nbsp;&nbsp; ret =3D get_sysfs_long_val(st, &quot;max_open_zone=
s&quot;);<br>
&nbsp;&nbsp;&nbsp;&nbsp; if (ret &gt;=3D 0) {<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; bs-&gt;bl.max_open_zones =
=3D ret;<br>
--<br>
2.54.0<br>
<br>
</div>
</body>
</html>

--_000_DS1PR04MB9539485DBE4F22A268FAA63FE1E42DS1PR04MB9539namp_--

