Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2FBADCD5BD2
	for <qemu-devel@archiver.kernel.org>; Wed, 27 May 2026 00:16:29 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wS1w3-00019q-Ai; Tue, 26 May 2026 20:15:47 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1)
 (envelope-from <prvs=6009f06ea=Alistair.Francis@wdc.com>)
 id 1wS1w0-00018z-18; Tue, 26 May 2026 20:15:44 -0400
Received: from esa4.hgst.iphmx.com ([216.71.154.42])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1)
 (envelope-from <prvs=6009f06ea=Alistair.Francis@wdc.com>)
 id 1wS1vx-0002yZ-Bw; Tue, 26 May 2026 20:15:43 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
 d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
 t=1779840941; x=1811376941;
 h=from:to:cc:subject:date:message-id:references:
 in-reply-to:content-id:content-transfer-encoding: mime-version;
 bh=EF1Ate6VQ1hOD76/cmAlyx2mW3RGJuU+sJlEJl4uJho=;
 b=Kia3sN12Lo6sxMW3Wi62Sz6/wq47gQe5xSIY9TD5FQRBJYcfC+fsmmiv
 MhzwbhFkOq7QYf3xhwJv2uDLKkLVas5vzKdn8sJfu/H1M5n3lF9enEwVa
 Nb2wFC/B9o+20s9YKCJ2fZnBRedUotk57XDdGRbN3e2ke3WYEqZF0TwaL
 wdTnwJRHaDgxAApuedxzE69X/4DJQpCPyLJ0ALv5U7256EjihMPaX/ZjH
 EWOElOXYkfRivIQn6q9tu5vwpHXMl53hKXYfX2FYqUObf4lNPrkWWaO3R
 lkFPMiYH9RzNwFQ1rj/20GY0I8/I57L8JTLpBa58ZI509eJYdaIsqlpyp A==;
X-CSE-ConnectionGUID: EQZoX2hCTwygpNRaVUIFWA==
X-CSE-MsgGUID: xDgQz+SGQHuBx3cg/s0h5A==
X-IronPort-AV: E=Sophos;i="6.24,170,1774281600"; d="scan'208";a="143714670"
Received: from mail-westus2azon11010042.outbound.protection.outlook.com (HELO
 CO1PR03CU002.outbound.protection.outlook.com) ([52.101.46.42])
 by ob1.hgst.iphmx.com with ESMTP/TLS/ECDHE-RSA-AES128-GCM-SHA256;
 27 May 2026 08:15:39 +0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=uk7lRXRTL3ynKwaTydZPuIGOhe58ILYcD6Twc9BF0GjC6JrK1YbTlCERJzQnGrGzmAkhUMCjXJO4RBBrxvA5VF5uae0L695LlpsedjzhOGDmO6qv2bPVTqtF2Pi/OgwyNbBUspyXSWTa8BORlV6qggntwh/AMi4kiuW0TZfcsBmKR+STKdAaNpZaS1aUMzQ8BAp59Do9bZDEk89dUIR//KRIuVfuhVddhCf4ad9SRbPWZWmqKu62/QO39idq/91Z7S6woHRIFd0gjU03ijLYfE4UP52BNzKDqbIv6JjQSXQMppM7HkXgjWGGEX8ilHZGoXcGTzi6R7qMkcNcP4ca/Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=EF1Ate6VQ1hOD76/cmAlyx2mW3RGJuU+sJlEJl4uJho=;
 b=MIatoa1TeAhFJzFiQP7/bwv6LV08QYRJ5ahqoePcBODO8CgibdrbyQat1g6E5DsLregt+ehivCLVL+8GUkrEY01oEA69Tj9/m36qaA35bbKACmy/JokF81NZb0GF/qVD7GBNes5Sm5sFcFzvMp2t7ohYZ7zAH4fETuJC4om4LWMesLerPh5oLr9Fz7L+xNfGZShD4XDoME7gjK2M752NA9dYMnEmu/x5xhoXTqsy5VqU2pk4YnfvmzQHi5zIbfVBnRjAhOngr/2qtAMVgcXSSJAIMrTMsWBPmYFYNIGa57Iw3yS/RHimXiMoPVSYM7gAM35E6VfXQ2Mz4c+UUi05wQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=wdc.com; dmarc=pass action=none header.from=wdc.com; dkim=pass
 header.d=wdc.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=sharedspace.onmicrosoft.com; s=selector2-sharedspace-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=EF1Ate6VQ1hOD76/cmAlyx2mW3RGJuU+sJlEJl4uJho=;
 b=dcB19Ah0b+zxppHvyjjBjGBukUZ4HcvCnrD8/vwQdj4p76PHO/30y25wnWp5yb17J/8A3CUdbctvlilJ/pnMGGUfRf/VUlkcpkrwzMbA29mykM1GHJRohRJIcqYe90/Q4cVHBIIVhn17m8v4X64QXn00/I8IIlACo1kQtlPMODg=
Received: from BY1PR04MB9561.namprd04.prod.outlook.com (2603:10b6:a03:5b6::11)
 by PH0PR04MB7655.namprd04.prod.outlook.com (2603:10b6:510:51::23)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.71.12; Wed, 27 May
 2026 00:15:36 +0000
Received: from BY1PR04MB9561.namprd04.prod.outlook.com
 ([fe80::3869:e494:2fa8:9888]) by BY1PR04MB9561.namprd04.prod.outlook.com
 ([fe80::3869:e494:2fa8:9888%4]) with mapi id 15.21.0071.011; Wed, 27 May 2026
 00:15:36 +0000
From: Alistair Francis <Alistair.Francis@wdc.com>
To: "fritchleybohrer@gmail.com" <fritchleybohrer@gmail.com>,
 "qemu-devel@nongnu.org" <qemu-devel@nongnu.org>
CC: "qemu-riscv@nongnu.org" <qemu-riscv@nongnu.org>, "palmer@dabbelt.com"
 <palmer@dabbelt.com>, "daniel.barboza@oss.qualcomm.com"
 <daniel.barboza@oss.qualcomm.com>, "chao.liu.zevorn@gmail.com"
 <chao.liu.zevorn@gmail.com>, "liwei1518@gmail.com" <liwei1518@gmail.com>,
 "zhiwei_liu@linux.alibaba.com" <zhiwei_liu@linux.alibaba.com>
Subject: Re: [PATCH v2] target/riscv: Reject Svinval instructions in U-mode
Thread-Topic: [PATCH v2] target/riscv: Reject Svinval instructions in U-mode
Thread-Index: AQHc6Zwwlj9USCvjEky5hv1fo5oVW7YhCKeA
Date: Wed, 27 May 2026 00:15:36 +0000
Message-ID: <e80c9e96432e53bec6472d46bc6a8c7845006d89.camel@wdc.com>
References: <20260522033145.17850-1-fritchleybohrer@gmail.com>
In-Reply-To: <20260522033145.17850-1-fritchleybohrer@gmail.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
user-agent: Evolution 3.60.1 (by Flathub.org) 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=wdc.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: BY1PR04MB9561:EE_|PH0PR04MB7655:EE_
x-ms-office365-filtering-correlation-id: 8ea36e7c-6774-46bc-7c62-08debb85136b
wdcipoutbound: EOP-TRUE
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
 ARA:13230040|10070799003|19092799006|366016|1800799024|376014|38070700021|56012099006|11063799006|6133799003|3023799007|18002099003|22082099003|5023799004;
x-microsoft-antispam-message-info: I6Qr2pkmd7U95eb66Zsfls0C8v5lA+TxWp4Nldna7fFjZ3kFo30Y/0LrFPFq8GNxbUVwPdHWoIQh+BMBig6Njn0EnCeav4kmd/kv4z40NRSCUMqSklGpktZkriwv1jAAyMHJ2vc0e4iDKN6TK8POkdsfs7bQKXjU4x7hpOXe1ZYfNudBiLCRdpIZFHfq0BapYZUNdN2qOr/K00vXXsUX9QhaHuub9jT7Uz4Q4ceSyIoKb1YwpWHWOngDy0QN1yFLyz0/IoGWFMreFf0R2h3423AjV3BnosnxBsFhXizg3frD2qivA6f/28NWikP/7YUEmdTBIXtQCB6T8GC8V9EsVaYBox+ottRbf8/Xep6ArcHRIONOQPaDgYjZbupVrRxfI5R+TeqPAwbJzoDe0FibRS1LW00Uz7wjOsOdStUMY/0Ns4szXIcISKM5Jkr0fzViIrFDklwppAn5Kp4jy2W9hR1fEi1jBfKTNqt46MftrZCEJ25bPzQED2v9rlYdpnHy0gvT3nGjr4nLoxatvZEqgmwkWb8eTW2VD77gX1rYsxkclrX9JvKQjn7/BgWSvO3Ts2PJXHCS0bYcPD02Q4RNE3UxObyWfCMOIfUAKv8KNA+VgD3qzvOdmVIRx8hWtBfPEGsbDQIl1JUfQkCR2uH0+v8O6xNHbJPBib+qUbnXogORczBd+tYJ7xTRQTcx+7o4TBS1O0qOCvh8Olg5VFQOx622FEKNhVSb1L06kzmO0evRnKZ7Mo6R8mronz3XWosu
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:BY1PR04MB9561.namprd04.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(10070799003)(19092799006)(366016)(1800799024)(376014)(38070700021)(56012099006)(11063799006)(6133799003)(3023799007)(18002099003)(22082099003)(5023799004);
 DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 2
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?OSt3MUhMV0NtNWs1U3dtWXByaEQrNXd6dGtlakhacU81NFdsMnByQmxsWFRF?=
 =?utf-8?B?b1NyTkkrWk14Skt0MWl0RmJBZWFVbkRaSXZhQlZoNjNMOW5YaTB1UlE0dU9V?=
 =?utf-8?B?SHNwcmpGQnZ0a2VYUUJFWi9HSTJSMG8yOTJBTUViYTUvYmNNTTFMdEhJcHk2?=
 =?utf-8?B?RSs1NE1vVkpwSGk3cEVnSUd0M2ROdFcvbUdlenNEcStUcW5rdzl1L0xTRm4y?=
 =?utf-8?B?MU05OW1aTllrYUQwVXd6bXpKbk9pTFJjdUtEMGJSSlNDWFU0RFlYQ1dVbXkz?=
 =?utf-8?B?OHhoT3VHREgzYVVaRG1JWmhiK2dhd054cmVucDc0Y1NRa2xBMWpSNlJVN3FM?=
 =?utf-8?B?QlFjdHVGZDZOOXJFQXZSQzRpUDFkTk9sOTJPa1o1WEF4dWdYNXVOSUV6R1Ez?=
 =?utf-8?B?SzluQjlhbTJMOWxuUXVKUGtXZEFuR1k1a3kyeEt5N0JRK2V2KzRYZlVPa3Vo?=
 =?utf-8?B?NU80OTBOSHVTRjlKVHVLTDNFNmZLaThDNHFEOXVKTWFlNnZ3KzUwclYxQWRq?=
 =?utf-8?B?Wlg0UXJBZ1NybzZtYldiTktKd1hjQnE5U0o1NXNnT0RqVVNGNHhrOUdEcUhB?=
 =?utf-8?B?OWxSZnpBUlZXRHpNcFV4ZTh0c3UzejN3YVhGZ1BDSWg4SDJ3L2RpWlh3WnU3?=
 =?utf-8?B?TTZIclluWEdQdFJCVXg5dVIwUTFnaEN6S2xrRmRXbVF1SDd5NVBpUUtHSVIy?=
 =?utf-8?B?ZWtnNWNJQThEMnNpZGJaN2JyencvTGZRQ3ZUbXhZS0FCdnZhOUd2dGF3eU5k?=
 =?utf-8?B?eUlKWmV1eFVOQzdkanhGVWNGbklOMjJEWUlubjN1WUR2aGpXT1prbVh0dUtr?=
 =?utf-8?B?c2tzYzFka1IzV0piMElVNXpFUFNWMU55ckhLcTVLdHB0dThzbWxpOE9CYWVa?=
 =?utf-8?B?OUhnZzdYUTAwV2lxR091a25vN3AyWGVkdTlqNjloZk5wK25WeVYwUHpLdmI5?=
 =?utf-8?B?Sjd4blRWVm1XRDRYaThrVzdVV1JwLy81dndwNThXQU9xRjJqVzQzWUVDWmhK?=
 =?utf-8?B?dFU0T1diRXBiOC9UTW4yeFlsb1huWldoV29wN04rZ0pyTzFTY0d6T0dnVlhE?=
 =?utf-8?B?NDkzN01Sc3VIcEFjVG82WHM2TEIxMExoK1R1YXowc1Q1TlBiOFozaE13SlNY?=
 =?utf-8?B?TlkwMnNUMWJMeUwwb0o3aEhZUVpoVGNSelhzaTU5a3JvaTBlV2RLbCt1Uys5?=
 =?utf-8?B?K0tUTHVSUHBhNWtRM1VGVGZzZGlVblB4SVZFTVR1QlZ1TUFsY2pMdlFCaXpW?=
 =?utf-8?B?UFhia3BzU1hjbzBOcDBCS01laERDdUdzY3duc0p1WHBFUVl0aXVCWHpBS1pv?=
 =?utf-8?B?b3RHemREcWdxczExZ3h6WGpwMTFaUGt3MmJNc2JpUm9yM01SMjJKNHpQMVpS?=
 =?utf-8?B?R3F6RDZYS1RXM0YzV2lvdFlUYTM5TlpYT0xuNFAvVkxwNFo2Vk80M2p1Kzln?=
 =?utf-8?B?OGl5bTQ2TGtzaTNiVUUrQmRIZUhuV0t5anVMeEduSkdZb1U3V1l2U2E2T0hL?=
 =?utf-8?B?bXhyOEpHQWJxZDZ2RXE4RXZnS0ZueVVmWmEreW5pSjNsS2s4T0kvQ3ZBNXc0?=
 =?utf-8?B?QmkvSXRUWE91RHc3YnE0c0pTWkJDU0hzUzNkVnR3NlU1ZEdUdGx6MW5CdnlL?=
 =?utf-8?B?V0tHMmVOcytFcmFSQU84UHU5RmxCcGNkOGh5Yk1ldkRsNXVDRHNCRS9oaFVt?=
 =?utf-8?B?enBaNURoU3ovSXk1bkNJQUh1c0NuOEUzOTQ0SE55QXVYcXR1WXhaSmM4NXRU?=
 =?utf-8?B?WnBiZ3lWcDJobCtSYndyRGozQWNxY2llakdSYmZrNHpWZG9uREFYN3FreEV2?=
 =?utf-8?B?RzFXZk1OeXYxTHBsR2t3d3IvcDBWMk1VSnlYaXltelJybUJCT0srOEhNL0M3?=
 =?utf-8?B?YmZ6SWF5NjNYaS9KemZtM05jQ005VXpQeExDb05vWkJuOVhtZkNjalJreVYx?=
 =?utf-8?B?Z1ZUY08vYzROcWQyOGRDSTJucExDYTJqMWFTMVZPNmxxY0JNUklrRlJYZ002?=
 =?utf-8?B?bTRDVTRyRVJVQ0VYWUVhdzBacjNKZmJIdkpLNytESDB3SmRBM3dJLzVCemN6?=
 =?utf-8?B?Mk1iWjYyd05vaEZ6VkhEVUhDaW5OVW02eHFXbWJtckExMG9mcnFWL2pyelJB?=
 =?utf-8?B?TnpPb3YzcUpNYmZiMGMyZ2hnOHgvakZlRDVtMUVXT25ORldFaGpiSGFQQ0ZI?=
 =?utf-8?B?RjZwY1lFUXlQdEV4a0VWTnVzeGJnMFhZOXNET2VQUTgwS29xKy92Nmc4R3Ns?=
 =?utf-8?B?V25uNGVianJ2c2hBR0c1TGc2NU4vbU1iTk1PdHM0NkdzUTB4bEU2TmN3d3hQ?=
 =?utf-8?B?QjIrb09McHZjVUM1L2ZEUE9MUTA4cUF2QjRxSjUwdUZHZ1UrUG9JWllmRGhW?=
 =?utf-8?Q?7nk162sKFw8xwCPgS9MX8fys2IX3B1t48LonmuKRHDh2T?=
x-ms-exchange-antispam-messagedata-1: F3sVaYSlWCSGibF7FzzrrGEojx+rvhyBF4w=
Content-Type: text/plain; charset="utf-8"
Content-ID: <E34EE9AAB013CE489C6FD2ACA42EDF7E@namprd04.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-Exchange-RoutingPolicyChecked: LndAWsFkeejWvsYNyLdwEN5ZaUrMM3ADVt3ITDhV1MLelauvD4SKIa+G6NTW0xeDdFt4gb63BRe/fB1Yom57RZZ06Kvtkce1n/2ZbaQ8BXwj9HocNr0FTRXe7XuahR2Mjn5OQviJx2J7lsyKOZWtgAtyQ4v1lkAFUopKv15l30JLZm67i6BT63/NI+aTZn4jyj2Eptm9jbuKdwi53S3vAlKRvc6TpZzkBdY8zWMWDHYnz/r6n0ofgvYIWRrEt+VrRgQu11SIAslqFuI1rcu/f7X5zizAz1XMLWZgMDZGrchoElpzu+jvjLreShQqsTfojUXSM5jL0oM8zTDqzDMbpA==
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: FepkP3XhnVbgV1V+bu7QiFinu+wN8UggnXKLwLsktBsa/an/ON2s6uB3QlnPnOQjaL9098Gz8CByMDJ6/fLlj83rcfXz7b2htHbbUn+HgfKxPH6pac6BCMfrbo1Ee8xHuGHoEHRyrDOL7Ihuf9I7C9bwUOA3EF54cTos9OzYSNrBx9LAS+Sv46HoT2SF7kIjL9oL9fNXnivi7Lka0T3MarnQHWZbBac8w7Psa4iCfport+83ESVuGxlhzCitxcaRqYim087+W0HYtmWeasyBgEaq1UYxIidlSiayUagVcYPvhaKTCGCObQyQeCEGknKIZ3WYKrAjqIKjkmZ+zIcDf4x0DgujfQEFsZXCABn8eRahum8NwKY3U/V57q+jn3u/4b/fbOh/OOGAfQRc+TJqqbrAkYXb7PO92dDvoGq2ZhtRbIDYz0njXFMTsGPglXWCmDNnfceYI/+AIv/mmQ+X1Ks+ED2owI7WUQXea6JFckgEmaf8t8GUTIU4UtxL8s2XUFiHvL2ppC3ofj8qfgW/D36pb67Woc1/4qCHVgwg022scha6vNGeZ6xdY4jS4VwS/KpJT8YksAqtCPngSIRz3SMC5lLhMU9Iahl2Wo3N0Eyl/MTXNEKOj5s3xMU0maML
X-OriginatorOrg: wdc.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: BY1PR04MB9561.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 8ea36e7c-6774-46bc-7c62-08debb85136b
X-MS-Exchange-CrossTenant-originalarrivaltime: 27 May 2026 00:15:36.3546 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: b61c8803-16f3-4c35-9b17-6f65f441df86
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: ll+hmabLfOYCyxsusM0XVECryyM7dATuq5p/+GDXix8IKR8hDgvOY0RX6hLHvb9HnA/GoTQzgutHKDQroRK477FBVmOmwgrGmtymjlsqbyY=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH0PR04MB7655
Received-SPF: pass client-ip=216.71.154.42;
 envelope-from=prvs=6009f06ea=Alistair.Francis@wdc.com;
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

T24gRnJpLCAyMDI2LTA1LTIyIGF0IDExOjMxICswODAwLCBaZXBoeXIgTGkgd3JvdGU6DQo+IFRo
ZSBSSVNDLVYgcHJpdmlsZWdlZCBzcGVjaWZpY2F0aW9uIHJlcXVpcmVzIFNGRU5DRS5XLklOVkFM
IGFuZA0KPiBTRkVOQ0UuSU5WQUwuSVIgdG8gcmFpc2UgYW4gaWxsZWdhbCBpbnN0cnVjdGlvbiBl
eGNlcHRpb24gd2hlbg0KPiBleGVjdXRlZA0KPiBpbiBVLW1vZGUuIENoZWNrIHRoZSBjdXJyZW50
IHByaXZpbGVnZSBtb2RlIGR1cmluZyB0cmFuc2xhdGlvbiBhbmQNCj4gcmVqZWN0IHRoZXNlDQo+
IGluc3RydWN0aW9ucyBpbiBVLW1vZGUsIHNvIHRoZXkgYXJlIHJlcG9ydGVkIGFzIGlsbGVnYWwg
aW5zdHJ1Y3Rpb25zLg0KPiANCj4gQWRkIGEgaGVscGVyIHRvIHJlamVjdCB0aGVzZSBpbnN0cnVj
dGlvbnMgaW4gVS1tb2RlIGR1cmluZw0KPiB0cmFuc2xhdGlvbi4NCj4gDQo+IFJlc29sdmVzOiBo
dHRwczovL2dpdGxhYi5jb20vcWVtdS1wcm9qZWN0L3FlbXUvLS93b3JrX2l0ZW1zLzM0OTMNCj4g
DQo+IFN1Z2dlc3RlZC1ieTogRGFuaWVsIEhlbnJpcXVlIEJhcmJvemENCj4gPGRhbmllbC5iYXJi
b3phQG9zcy5xdWFsY29tbS5jb20+DQo+IA0KPiBTaWduZWQtb2ZmLWJ5OiBaZXBoeXIgTGkgPGZy
aXRjaGxleWJvaHJlckBnbWFpbC5jb20+DQoNClRoYW5rcyENCg0KQXBwbGllZCB0byByaXNjdi10
by1hcHBseS5uZXh0DQoNCkFsaXN0YWlyDQoNCj4gLS0tDQo+IMKgdGFyZ2V0L3Jpc2N2L2luc25f
dHJhbnMvdHJhbnNfc3ZpbnZhbC5jLmluYyB8IDEyICsrKysrKysrKysrKw0KPiDCoDEgZmlsZSBj
aGFuZ2VkLCAxMiBpbnNlcnRpb25zKCspDQo+IA0KPiBkaWZmIC0tZ2l0IGEvdGFyZ2V0L3Jpc2N2
L2luc25fdHJhbnMvdHJhbnNfc3ZpbnZhbC5jLmluYw0KPiBiL3RhcmdldC9yaXNjdi9pbnNuX3Ry
YW5zL3RyYW5zX3N2aW52YWwuYy5pbmMNCj4gaW5kZXggYTA2YzNiMjE0Zi4uNDYxNGMxNDg5YyAx
MDA2NDQNCj4gLS0tIGEvdGFyZ2V0L3Jpc2N2L2luc25fdHJhbnMvdHJhbnNfc3ZpbnZhbC5jLmlu
Yw0KPiArKysgYi90YXJnZXQvcmlzY3YvaW5zbl90cmFucy90cmFuc19zdmludmFsLmMuaW5jDQo+
IEBAIC0yMiwxMSArMjIsMTkgQEANCj4gwqDCoMKgwqAgfcKgwqDCoMKgwqDCoMKgwqDCoMKgwqDC
oMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgIFwNCj4g
wqB9IHdoaWxlICgwKQ0KPiDCoA0KPiArLyogVGVzdCBpZiBwcml2IGxldmVsIGlzIE0gb3IgUy4g
Ki8NCj4gKyNkZWZpbmUgUkVRVUlSRV9QUklWX01TKGN0eCkgZG8ge8KgwqDCoMKgwqDCoMKgwqDC
oCBcDQo+ICvCoMKgwqAgaWYgKGN0eC0+cHJpdiA9PSBQUlZfVSkge8KgwqDCoMKgwqDCoMKgwqDC
oMKgwqDCoMKgIFwNCj4gK8KgwqDCoMKgwqDCoMKgIHJldHVybiBmYWxzZTvCoMKgwqDCoMKgwqDC
oMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqAgXA0KPiArwqDCoMKgIH3CoMKgwqDCoMKgwqDC
oMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKg
wqDCoCBcDQo+ICt9IHdoaWxlICgwKQ0KPiArDQo+IMKgc3RhdGljIGJvb2wgdHJhbnNfc2ludmFs
X3ZtYShEaXNhc0NvbnRleHQgKmN0eCwgYXJnX3NpbnZhbF92bWEgKmEpDQo+IMKgew0KPiDCoMKg
wqDCoCBSRVFVSVJFX1NWSU5WQUwoY3R4KTsNCj4gwqDCoMKgwqAgLyogRG8gdGhlIHNhbWUgYXMg
c2ZlbmNlLnZtYSBjdXJyZW50bHkgKi8NCj4gwqDCoMKgwqAgUkVRVUlSRV9FWFQoY3R4LCBSVlMp
Ow0KPiArwqDCoMKgIFJFUVVJUkVfUFJJVl9NUyhjdHgpOw0KPiDCoCNpZm5kZWYgQ09ORklHX1VT
RVJfT05MWQ0KPiDCoMKgwqDCoCBkZWNvZGVfc2F2ZV9vcGMoY3R4LCAwKTsNCj4gwqDCoMKgwqAg
Z2VuX2hlbHBlcl90bGJfZmx1c2godGNnX2Vudik7DQo+IEBAIC0zOSw2ICs0Nyw3IEBAIHN0YXRp
YyBib29sIHRyYW5zX3NmZW5jZV93X2ludmFsKERpc2FzQ29udGV4dCAqY3R4LA0KPiBhcmdfc2Zl
bmNlX3dfaW52YWwgKmEpDQo+IMKgew0KPiDCoMKgwqDCoCBSRVFVSVJFX1NWSU5WQUwoY3R4KTsN
Cj4gwqDCoMKgwqAgUkVRVUlSRV9FWFQoY3R4LCBSVlMpOw0KPiArwqDCoMKgIFJFUVVJUkVfUFJJ
Vl9NUyhjdHgpOw0KPiDCoMKgwqDCoCAvKiBEbyBub3RoaW5nIGN1cnJlbnRseSAqLw0KPiDCoMKg
wqDCoCByZXR1cm4gdHJ1ZTsNCj4gwqB9DQo+IEBAIC00Nyw2ICs1Niw3IEBAIHN0YXRpYyBib29s
IHRyYW5zX3NmZW5jZV9pbnZhbF9pcihEaXNhc0NvbnRleHQNCj4gKmN0eCwgYXJnX3NmZW5jZV9p
bnZhbF9pciAqYSkNCj4gwqB7DQo+IMKgwqDCoMKgIFJFUVVJUkVfU1ZJTlZBTChjdHgpOw0KPiDC
oMKgwqDCoCBSRVFVSVJFX0VYVChjdHgsIFJWUyk7DQo+ICvCoMKgwqAgUkVRVUlSRV9QUklWX01T
KGN0eCk7DQo+IMKgwqDCoMKgIC8qIERvIG5vdGhpbmcgY3VycmVudGx5ICovDQo+IMKgwqDCoMKg
IHJldHVybiB0cnVlOw0KPiDCoH0NCj4gQEAgLTU2LDYgKzY2LDcgQEAgc3RhdGljIGJvb2wgdHJh
bnNfaGludmFsX3Z2bWEoRGlzYXNDb250ZXh0ICpjdHgsDQo+IGFyZ19oaW52YWxfdnZtYSAqYSkN
Cj4gwqDCoMKgwqAgUkVRVUlSRV9TVklOVkFMKGN0eCk7DQo+IMKgwqDCoMKgIC8qIERvIHRoZSBz
YW1lIGFzIGhmZW5jZS52dm1hIGN1cnJlbnRseSAqLw0KPiDCoMKgwqDCoCBSRVFVSVJFX0VYVChj
dHgsIFJWSCk7DQo+ICvCoMKgwqAgUkVRVUlSRV9QUklWX01TKGN0eCk7DQo+IMKgI2lmbmRlZiBD
T05GSUdfVVNFUl9PTkxZDQo+IMKgwqDCoMKgIGRlY29kZV9zYXZlX29wYyhjdHgsIDApOw0KPiDC
oMKgwqDCoCBnZW5faGVscGVyX2h5cF90bGJfZmx1c2godGNnX2Vudik7DQo+IEBAIC02OSw2ICs4
MCw3IEBAIHN0YXRpYyBib29sIHRyYW5zX2hpbnZhbF9ndm1hKERpc2FzQ29udGV4dCAqY3R4LA0K
PiBhcmdfaGludmFsX2d2bWEgKmEpDQo+IMKgwqDCoMKgIFJFUVVJUkVfU1ZJTlZBTChjdHgpOw0K
PiDCoMKgwqDCoCAvKiBEbyB0aGUgc2FtZSBhcyBoZmVuY2UuZ3ZtYSBjdXJyZW50bHkgKi8NCj4g
wqDCoMKgwqAgUkVRVUlSRV9FWFQoY3R4LCBSVkgpOw0KPiArwqDCoMKgIFJFUVVJUkVfUFJJVl9N
UyhjdHgpOw0KPiDCoCNpZm5kZWYgQ09ORklHX1VTRVJfT05MWQ0KPiDCoMKgwqDCoCBkZWNvZGVf
c2F2ZV9vcGMoY3R4LCAwKTsNCj4gwqDCoMKgwqAgZ2VuX2hlbHBlcl9oeXBfZ3ZtYV90bGJfZmx1
c2godGNnX2Vudik7DQo=

