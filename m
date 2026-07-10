Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9BD01C43458
	for <qemu-devel@archiver.kernel.org>; Fri, 10 Jul 2026 07:38:34 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wi5oc-0001fs-WE; Fri, 10 Jul 2026 03:38:31 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <prvs=64465d642=graf@amazon.de>)
 id 1wi5oZ-0001OO-68; Fri, 10 Jul 2026 03:38:27 -0400
Received: from fra-out-013.esa.eu-central-1.outbound.mail-perimeter.amazon.com
 ([63.178.132.221])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <prvs=64465d642=graf@amazon.de>)
 id 1wi5oX-0007nF-0Y; Fri, 10 Jul 2026 03:38:26 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=amazon.de; i=@amazon.de; q=dns/txt; s=amazoncorp2;
 t=1783669105; x=1815205105;
 h=from:to:cc:subject:date:message-id:references:
 in-reply-to:content-id:content-transfer-encoding: mime-version;
 bh=oxr/eHbgGUq29IozO+s+Bp86SeX63WO2zpH7CHp3HUU=;
 b=hcpTiaEieVa5DBBfkUk9ZTAtqD3qEMeUvG2TiHldn1OUlRwkTEUvg6vF
 nbLkEgofqNflnD4QOYUj2lOihsFBxGHynQxjL3hsd+1r0eQmczX6IN/oQ
 VvgO/Pa4argAkOfDZ+o2sT6539C3NYlziBJRC5MYOBXaGBHVZOs9kHNeH
 Qfb0a96wqkbbHyGgUqIU3X4sBQIJa+MtEb3WSbEqA4DF0t9mOwgOpaZf9
 lrlKyrrPdxkPguyHNQbr6XJh82GeLZugjwtR5U0dlaAdt3YCUa19EXfVB
 LO0NhL33HNsLmbisRhJdrRhWOWMs8UDoH9uGg3ZOeV3Ya7JpERWFfqqvg A==;
X-CSE-ConnectionGUID: WNnuirbZTU2UEXd7oMO20g==
X-CSE-MsgGUID: J1JJ+7cMQYWPJXOVyl0LYg==
X-IronPort-AV: E=Sophos;i="6.25,154,1779148800"; d="scan'208";a="16180534"
Received: from ip-10-6-6-97.eu-central-1.compute.internal (HELO
 smtpout.naws.eu-central-1.prod.farcaster.email.amazon.dev) ([10.6.6.97])
 by internal-fra-out-013.esa.eu-central-1.outbound.mail-perimeter.amazon.com
 with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 10 Jul 2026 07:38:11 +0000
Received: from EX19MTAEUA001.ant.amazon.com [54.240.197.233:5019]
 by smtpin.naws.eu-central-1.prod.farcaster.email.amazon.dev [10.0.19.47:2525]
 with esmtp (Farcaster)
 id caa6bd08-43d9-4a8a-b8f9-e1c4d23b06f4; Fri, 10 Jul 2026 07:38:11 +0000 (UTC)
X-Farcaster-Flow-ID: caa6bd08-43d9-4a8a-b8f9-e1c4d23b06f4
Received: from EX19EXOEUB001.ant.amazon.com (10.252.51.80) by
 EX19MTAEUA001.ant.amazon.com (10.252.50.50) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA) id 15.2.2562.43;
 Fri, 10 Jul 2026 07:38:10 +0000
Received: from FR5P281CU006.outbound.protection.outlook.com (10.252.50.44) by
 EX19EXOEUB001.ant.amazon.com (10.252.51.80) with Microsoft SMTP
 Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA) id 15.2.2562.43
 via Frontend Transport; Fri, 10 Jul 2026 07:38:10 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=jOxdQGmp6FTRV158JM7q3e95JixnG0ey74j3gNF1dbN4wuxim7lLjqA7AcG+HXeDzxh3AXX+FlOTUuEnSXiveZLR9TLTsRHVxcRZzn6xPLqcNzmydWZWzN4w5/9TFR9Z97Rm2y9EM2CEnGlETvoDn2v8t/FkDNKkt4NS+74zSDsdQZ/EggXR1YIPr3CaTGaz2WAYMetUlz8myICJGUZe/zIkUpU9G/E/RGd/fkYT3DBuohrQwb0ZPpcPxOEOJ39eHpEyF1nAC1p9OAmklKJjdEcZe5GvEvg82ES+mMDBNqe1O5gXsVNLjCwhrOfJKN+DYrkOjKHPy7wdbwiTHcmT3w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=oxr/eHbgGUq29IozO+s+Bp86SeX63WO2zpH7CHp3HUU=;
 b=oZ+OL7DjIwGK3d04hduYs90BXe9B/rbkG+J9qaqcs1H9GEu+rdsDxrLGLBsdrNpdCWV4mO7L0d6Koh4MqHMrqxNQ2G8FIbarwZtD6y32Z04R1pZFtDjWckHk7cYBlNslKFdRyhCt7MnRmjR+eHVZqA0pepalISmbtufvfa0tJiC0S3p+sDIDE5WQhrsju+Cbl5fvuje/KSC3dvKkftM6lRcXPekQVMPy69mHq+k/DOTYsf/Oonbks4BkjbUA1lR+0gq5pYkNXCYhlULRdtw7YnR90zROO9LithC+GOF6dY7a7+5ixiWm5pY9GR8gcg8MnUl7JqHY3oTWqjhOd4QAmg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amazon.de; dmarc=pass action=none header.from=amazon.de;
 dkim=pass header.d=amazon.de; arc=none
Received: from FR0P281MB3020.DEUP281.PROD.OUTLOOK.COM (2603:10a6:d10:54::12)
 by FRVP281MB5973.DEUP281.PROD.OUTLOOK.COM (2603:10a6:d10:1c6::17) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.181.17; Fri, 10 Jul
 2026 07:38:07 +0000
Received: from FR0P281MB3020.DEUP281.PROD.OUTLOOK.COM
 ([fe80::6924:1313:12cd:49a9]) by FR0P281MB3020.DEUP281.PROD.OUTLOOK.COM
 ([fe80::6924:1313:12cd:49a9%6]) with mapi id 15.21.0181.016; Fri, 10 Jul 2026
 07:38:07 +0000
From: "Graf (AWS), Alexander" <graf@amazon.de>
To: Markus Armbruster <armbru@redhat.com>
CC: BALATON Zoltan <balaton@eik.bme.hu>, "qemu-devel@nongnu.org"
 <qemu-devel@nongnu.org>, Aditya Gupta <adityag@linux.ibm.com>, "Alexandre
 Iooss" <erdnaxe@crans.org>, Alexey Kardashevskiy <aik@ozlabs.ru>, "Alistair
 Francis" <Alistair.Francis@wdc.com>, Alistair Francis
 <alistair@alistair23.me>, Antony Pavlov <antonynpavlov@gmail.com>, "Artyom
 Tarasenko" <atar4qemu@gmail.com>, Bernhard Beschow <shentey@gmail.com>, "Bibo
 Mao" <maobibo@loongson.cn>, Brian Cain <brian.cain@oss.qualcomm.com>, Chao
 Liu <chao.liu@processmission.com>, Christian Borntraeger
 <borntraeger@linux.ibm.com>, =?utf-8?B?Q2zDqW1lbnQgQ2hpZ290?=
 <chigot@adacore.com>, =?utf-8?B?Q8OpZHJpYyBMZSBHb2F0ZXI=?= <clg@kaod.org>,
 Dorjoy Chowdhury <dorjoychy111@gmail.com>, "Edgar E. Iglesias"
 <edgar.iglesias@gmail.com>, Eric Farman <farman@linux.ibm.com>, Farhan Ali
 <alifm@linux.ibm.com>, Felipe Balbi <balbi@kernel.org>, Francisco Iglesias
 <francisco.iglesias@amd.com>, Frederic Konrad <konrad.frederic@yahoo.fr>,
 Gaurav Sharma <gaurav.sharma_7@nxp.com>, Gautam Gala <ggala@linux.ibm.com>,
 Glenn Miles <milesg@linux.ibm.com>, Halil Pasic <pasic@linux.ibm.com>, Hao Wu
 <wuhaotsh@google.com>, Harsh Prateek Bora <harshpb@linux.ibm.com>, "Helge
 Deller" <deller@gmx.de>, Hendrik Brueckner <brueckner@linux.ibm.com>,
 =?utf-8?B?SGVydsOpIFBvdXNzaW5lYXU=?= <hpoussin@reactos.org>, Huacai Chen
 <chenhuacai@kernel.org>, Jan Kiszka <jan.kiszka@web.de>, Jared Rossi
 <jrossi@linux.ibm.com>, Joel Stanley <joel@jms.id.au>, Laurent Vivier
 <laurent@vivier.eu>, Manos Pitsidianakis <manos.pitsidianakis@linaro.org>,
 Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>, Matthew Rosato
 <mjrosato@linux.ibm.com>, Max Filippov <jcmvbkbc@gmail.com>, Michael Rolnik
 <mrolnik@gmail.com>, "Michael S. Tsirkin" <mst@redhat.com>, Nicholas Piggin
 <npiggin@gmail.com>, Niek Linnenbank <nieklinnenbank@gmail.com>, "Palmer
 Dabbelt" <palmer@dabbelt.com>, Paolo Bonzini <pbonzini@redhat.com>, "Peter
 Maydell" <peter.maydell@linaro.org>,
 =?utf-8?B?UGhpbGlwcGUgTWF0aGlldS1EYXVkw6k=?= <philmd@mailo.com>, "Pierrick
 Bouvier" <pierrick.bouvier@oss.qualcomm.com>, Ran Wang <wangran@bosc.ac.cn>,
 Richard Henderson <richard.henderson@linaro.org>, Sai Pavan Boddu
 <sai.pavan.boddu@amd.com>, Samuel Tardieu <sam@rfc1149.net>, Sergio Lopez
 <slp@redhat.com>, Song Gao <17746591750@163.com>, Stafford Horne
 <shorne@gmail.com>, Subbaraya Sundeep <sundeep.lkml@gmail.com>, Thomas Huth
 <th.huth+qemu@posteo.eu>, Tyrone Ting <kfting@nuvoton.com>,
 "qemu-arm@nongnu.org" <qemu-arm@nongnu.org>, "qemu-ppc@nongnu.org"
 <qemu-ppc@nongnu.org>, "qemu-riscv@nongnu.org" <qemu-riscv@nongnu.org>,
 "qemu-s390x@nongnu.org" <qemu-s390x@nongnu.org>
Subject: Re: Call to clean up QOM onboard devices lacking a parent
Thread-Topic: Call to clean up QOM onboard devices lacking a parent
Thread-Index: AQHdED8MMkWXmSzHj02teG6q8aEHjQ==
Date: Fri, 10 Jul 2026 07:38:07 +0000
Message-ID: <b5176cd7-385f-4e09-a2da-4f697de63bf0@amazon.de>
References: <87se5scipx.fsf@pond.sub.org>
 <17c7f91b-8935-8ebf-a982-f91df755af81@eik.bme.hu>
 <fee18020-dcfe-4d91-8384-5cc5f8321ff7@amazon.com>
 <87h5m7xsxi.fsf@pond.sub.org>
In-Reply-To: <87h5m7xsxi.fsf@pond.sub.org>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amazon.de;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: FR0P281MB3020:EE_|FRVP281MB5973:EE_
x-ms-office365-filtering-correlation-id: 4463a627-a17c-4b2a-d9a0-08dede562f45
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
 ARA:13230040|366016|23010399003|7416014|376014|1800799024|56012099006|11063799006|6133799003|4143699003|22082099003|18002099003|38070700021;
x-microsoft-antispam-message-info: LEEEeVkxByJNZdzxW37K67vZckezbG/fK2wCLDs2BiVaFYE8YeE7BX9QBligs0nvaaO1LYW6q2UlGpdnngpE9g6lhRmKSr5rNNRUyfb9qbR3X6PjSYA+x8nno5aCsyHFULDzyMofLHYmrq0GAekA28JYaRhEIfUWsqhrzYfmBCq8Rxe2iakJKSZlA2TiktXnL/QDGU9MakG9j8XQDhYFyN5fZ/3kI84+izNsr2rtdmaDJH0eVmRPiXkMjNPFZ0UxcF2PmW+WsxeAjQ7jyc338X1d3K9avtZ65UU9HIdxHqwc9oXelWKWYvwz1Naadlz9NcQ6X52c7Panm6LOEvk37je+axsK4UYoMEySPlP9Zz2Wyl8SA5xW5CJnPKO49A1Eolj+O4Wn+x9jDdlu2uILxhqt7Uro31CLaLIeA4cndiSPBDbUCO/0rxoRPa5HzGw2eVE94bOLOP2M/Zy+6G8hyXu+ONir9P7rGXg32xoVuuMN6sCT2Yc16dSpvTrb2MIq2OWRMZRlrlWdb5KrgYljr3wk20VQjk5Nskp4LaPX7Ltq7hdt22um2Wh7rb1SUDjeOTrJuokilpQM0MAidRxbYdESPuMzDHIVoNvaknsVm1L9TIp0dsdi0B2DfqiZc5GuYSjfRiX3w8xLiPKhNc1apPERsiE/Esq7tiNBalo+HM8fLzXlPkifberkuqMOurvluxcqqfz8RMwErg2hYEmAWxv6OMJE7FT7pKZsdqOeJNk=
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:FR0P281MB3020.DEUP281.PROD.OUTLOOK.COM; PTR:; CAT:NONE;
 SFS:(13230040)(366016)(23010399003)(7416014)(376014)(1800799024)(56012099006)(11063799006)(6133799003)(4143699003)(22082099003)(18002099003)(38070700021);
 DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?ME5HeUVwUmJyS05NZnh1UkY5U3ZEK0xmOVNFU3IvdEY5SEpKbDBzVGlZZXUw?=
 =?utf-8?B?TVkxczVRazBpVzlZcjRoL3JzbUNvVmdlNk5DUEFKaFBSK01KUnI5RFRxVWJD?=
 =?utf-8?B?bVNLWnFjcnNBQ3NiODFLcTdERkZQQjlQTWVTa0RKSUtzUy84czFGS2d4WE1q?=
 =?utf-8?B?cVBHTWJrVFZ2UUpwTCtPMDVzWHVsbHk3S0hKck9mY3FCbEwvbmF3WGJTMWdH?=
 =?utf-8?B?dDVkVjZhYXYycUl4ajBkaTh0UWhRa2NZRldiWGNXTWdCa1plSXhYWjdQc0V2?=
 =?utf-8?B?OWZuVVk3RkMvaU85aVAvaWVPZEJKNXJzVmhnbGkweEM1bklMV2wzdE9RdHpY?=
 =?utf-8?B?eE1BWXBxUVQvV3pEanRZOU94SjY2QUJZVEtLTk0xb2xVOXZuN3FIMVJxdGl6?=
 =?utf-8?B?YW1nOGl4TUR4ZXFVeWdUR0xhck10NXB1R2ozckxKZnRwTlRxd2NTZGgza09W?=
 =?utf-8?B?YVVzay9HNGI0b1luQWJEOWJtYTdwZ1FnbTdQMDJ4MldXQ1JZYUdYdzZEdFRv?=
 =?utf-8?B?Y1RUVHNybU12M3FtaXNxcHQxblpuUHlxSVVXcXZDQXZ6ZkJJMi9LWFdBVVg3?=
 =?utf-8?B?Sm5JWFdKUWVnWmdFOG1oTjFRUUVDbFAwNk1wYmlaYXhrZ0RiMWVObFg5K1Nm?=
 =?utf-8?B?ZlNUMVZYTCsrNDlmY2ZqWkt0bVJsYjJQVml6N2FDNnM3S3NBWHJ5eEUwVUZF?=
 =?utf-8?B?bm9OV0ZOclBuSHVrdjd0ZlhrOWhpNjdvZE1tVnpzOWVLKzdRZFlVRHdZQmpm?=
 =?utf-8?B?M2FPYVBkelpIc0ZlZFU0MTcvSytLbDkwVUUrSXk5dlVtMFA1dXZFSXBzSDIw?=
 =?utf-8?B?amZTaHJrbUZlYXFEQTFBR0xWNWpaUE5SNTA3N1psL1drcXU1Nko5RUJyVjJZ?=
 =?utf-8?B?UXp4NTByNU8rQmN0NEJ5Z1JzK2M4U2cwWlVkdmVuZ3JwSHBMZXZmSmJjY2ZC?=
 =?utf-8?B?V05pcmd2WGVocW1obDVIU1grVThKZkhsNU1la21KemNIOXVHWHZ6NkJtT0Zo?=
 =?utf-8?B?WG9wVzBVd3ZKWERaRE9RVitSYkVHNlFEaGJoOW1MVEttNE1RTTNyRVRNaCsw?=
 =?utf-8?B?ZVZaenNnS0lKYmlUaDJDYTdOdzY0RXVUWlBzNUlseUhjTDBvRE5VLzl6aUlS?=
 =?utf-8?B?cFhiTjNzYmZGdnkvalF4OUtQK2tWMUhRazdROVJmK21Qb1l0NEhEL0tGZDJ1?=
 =?utf-8?B?R0RxZytsYW1yblVEWEQ2ZktQNjBsV2VJc011NXZFV3U3djFsMXJOaGhkeE5H?=
 =?utf-8?B?UHErRU9oLzByOWpUNER3UVBjZGkwZXQ1eDNrczBFUmIxaDhHK2htS3JzKzRi?=
 =?utf-8?B?R0ZPUnhkaWJlUVpRcW82dFphZUFyTVZiUUwvK3pweGxkdmlxTFFLWmMxUXVV?=
 =?utf-8?B?U09zSm5aQlZ0QkF6TWxoNWNJQUtxRENkUnFKczBEYkE3YXh2MnBCcGRabFAr?=
 =?utf-8?B?MGlHL01nekR6MkZrTUgvaEY0WkxSMjNvNHQzaXVsTlJVdy9CSjFTR21KcE9U?=
 =?utf-8?B?SjBYWGVMVVpSUmliTWEzaWpBMEo2aGh4djRhQUc3YS9nSlpSdGJXY1lxQkFv?=
 =?utf-8?B?Sm9jWnQ2SXFtMzZPY091aTBBclZVNG9tUkZLQWl0anJKOVJxNGJWS1k2Ny8y?=
 =?utf-8?B?M21zSUlYSzdIeGJCYXd1dkFYYWFUNFBpb2pFK1pLcFovcy9JcWwveS9YNlR6?=
 =?utf-8?B?VHlNd3JjemV5YVlVQTErMnlnL0htaHhoYlpKWEFOUXRjZkM5aFhvNTFuYU1t?=
 =?utf-8?B?YWRVd01BcW9wQnZCY3JyNWxrd29OaElJNFJmWnZKTFpSbUhoRVlFM2U3V3Q4?=
 =?utf-8?B?djMrRXUyUnV0cy9ydkhqNGRDdmhTY1VRV2FYREJZai9wdHBNTFFIWGVhdXlO?=
 =?utf-8?B?T0d0VEJJTWZOejB2aWdlV2dJZXJLWVRXMnp2bFlQeDZpSzhqNWVDUVFiT081?=
 =?utf-8?B?RTBRYTJqMTJvMzdBRU41YkdMcjZScG1TWGFIcTAvYjZ3cUNKME04dXcvcTR1?=
 =?utf-8?B?ckdLTUVGeWlETHBQcWVrVFZhaXZaRFB4Y1hXWnZUSFR5a01lU1dEZ1kzSnZy?=
 =?utf-8?B?VVMzV05uUkpDOTJTYWhmNzc2TC9wWnFLRkJoMjVDZHVMVVlodk02em9DalVs?=
 =?utf-8?B?NFQwL0VDbmVERGhjQ1lycWtaNFNreHU3K2U1bUg1L2ZBUDZaMnAvdFhiVWJx?=
 =?utf-8?B?QWtsYUltYWd4QVYrSUx6QVc4RkREUE9KK3Vjak9JWE1obWhNVEk4dXFqYkJF?=
 =?utf-8?B?YUQweWV3YS9XWUlMcGpJcHJQSmlsUnhlSXJJTXYwZjg2b0lPRE9lVHlpWlln?=
 =?utf-8?Q?SskD+akIDit+PsqC2c?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <01D2767846F136429F887C41C4139AD6@DEUP281.PROD.OUTLOOK.COM>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-Exchange-RoutingPolicyChecked: M0bPOrlcoHUTKQUpva1Z+xBLr2RPmI6Eqm9iWP9QzUjAbqe1S5GOnXqpRy1yGgBsuFB7YAAMk/x1C5pRK3yB5O0Bn+Gm6KeglU/sQYdVvhJV7qK2WVh04xccFqV2hj2M5v+MxPNfTNcL8Ay2UOw6UpPKUhVCfIcV53rQqq0Pj65OtkJh7LFQdfxPdtj0AdK/gXBVBYMiccjtdBO4Hab4TeyU0PojbNx4TtcQUiR1s/h2NfEnXajcLveCEHkGi39qD5gCnDcAlmX87kFKiV9MGHaNtkQUI9thkREA4HVQpElUliJCTRvznovltVgmtR0n/69T+l0/YedHJqDGEvrFwQ==
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: FR0P281MB3020.DEUP281.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-Network-Message-Id: 4463a627-a17c-4b2a-d9a0-08dede562f45
X-MS-Exchange-CrossTenant-originalarrivaltime: 10 Jul 2026 07:38:07.4771 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 5280104a-472d-4538-9ccf-1e1d0efe8b1b
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: TJGjmjdinpUYAQYPCUlPrJoNlu6sFpKNdRIkoIZPSzwqWaJqbLDYwHcgdlpPoncb
X-MS-Exchange-Transport-CrossTenantHeadersStamped: FRVP281MB5973
X-OriginatorOrg: amazon.de
Received-SPF: pass client-ip=63.178.132.221;
 envelope-from=prvs=64465d642=graf@amazon.de;
 helo=fra-out-013.esa.eu-central-1.outbound.mail-perimeter.amazon.com
X-Spam_score_int: -31
X-Spam_score: -3.2
X-Spam_bar: ---
X-Spam_report: (-3.2 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.445,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_LOW=-0.7, SPF_HELO_NONE=0.001, T_SPF_PERMERROR=0.01,
 UNPARSEABLE_RELAY=0.001 autolearn=ham autolearn_force=no
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

DQpPbiAxMC4wNy4yNiAwODoyNSwgTWFya3VzIEFybWJydXN0ZXIgd3JvdGU6DQo+ICJHcmFmIChB
V1MpLCBBbGV4YW5kZXIiIDxncmFmQGFtYXpvbi5kZT4gd3JpdGVzOg0KPg0KPj4gSGkgTWFya3Vz
LA0KPiBbLi4uXQ0KPg0KPj4gSSdtIGFsc28gY3VyaW91cyBvbiB3aGV0aGVyIHRoZXJlIGlzIGFu
eXRoaW5nIHRoYXQgbWFrZXMgc3lzYnVzIGRldmljZQ0KPj4gc3Bhd25zIGJvdGggZWFzeSAoYXMg
dGhleSBhcmUgdG9kYXkpIGFuZCBhdCB0aGUgc2FtZSB0aW1lIGZ1bGx5IFFPTQ0KPj4gcGFyZW50
IGNvbXBsaWFudC4NCj4+DQo+PiBJIGhhZCBhIHF1aWNrIGxvb2sgYXQgdGhlIHZtYXBwbGUgbWFj
aGluZSBhbmQgbW9zdCBvZiB0aGUgb2ZmZW5kZXJzIGFyZQ0KPj4gc3lzYnVzIGRldmljZXMgSSBz
cGF3biB2aWEgcWRldl9uZXcoKS4gV291bGQgeW91IHdhbnQgYWxsIG9mIHRoZXNlIHRvDQo+PiBn
ZXQgdGhlaXIgcGFyZW50IGRlY2xhcmVkIHZpYSBvYmplY3RfcHJvcGVydHlfYWRkX2NoaWxkKCk/
IElmIHRoYXQncyB0aGUNCj4+IGNhc2UsIHdoeSBkb24ndCB3ZSBpbnRyb2R1Y2UgYSBuZXcgcWRl
dl9uZXdfY2hpbGQoKSB3aGljaCBkb2VzIHRoYXQNCj4+IGF1dG9tYXRpY2FsbHk/DQo+IFdlIGRv
IGhhdmUgc3VjaCBjb252ZW5pZW5jZSBmdW5jdGlvbnMgYXQgdGhlIFFPTSBsYXllcjogb2JqZWN0
X25ldygpIGFuZA0KPiBvYmplY3RfcHJvcGVydHlfYWRkX2NoaWxkKCkgZXRjLiwgYXJlIGJhc2lj
IGJ1aWxkaW5nIGJsb2NrcywgYW5kDQo+IG9iamVjdF9uZXdfd2l0aF9wcm9wcygpIGV0Yy4gY29t
YmluZSB0aGVtIGluIHVzZWZ1bCB3YXlzLg0KPg0KPiBXZSBkb24ndCBoYXZlIHN1Y2ggY29udmVu
aWVuY2UgZnVuY3Rpb25zIGF0IHRoZSBxZGV2IGxheWVyLiAgQ2FuJ3Qgc2VlDQo+IHdoeSB3ZSBj
b3VsZG4ndCBhZGQgdGhlbS4NCj4NCj4gTnVtYmVyIG9mIG9ycGhhbmVkIGRldmljZSB0eXBlcyBJ
IHNlZSBieSBidXNfdHlwZToNCj4NCj4gICAgICA2OSAgICAgIGJ1c2xlc3MNCj4gICAgICAxNSAg
ICAgIElTQQ0KPiAgICAgIDMzICAgICAgUENJDQo+ICAgICAgMTEgICAgICBTU0kNCj4gICAgICAy
MDkgICAgIFN5c3RlbQ0KPiAgICAgIDIgICAgICAgYXBwbGUtZGVza3RvcC1idXMNCj4gICAgICAy
MyAgICAgIGkyYy1idXMNCj4gICAgICAyICAgICAgIHNkLWJ1cw0KPiAgICAgIDEgICAgICAgc3Bh
cHItdmlvLWJ1cw0KPiAgICAgIDIgICAgICAgdXNiLWJ1cw0KPg0KPiBBZ2Fpbiwgbm90IGEgcHJv
YmxlbSB3aXRoIHRoZSBkZXZpY2UgdHlwZXMsIGJ1dCB0aGUgY29kZSB0aGF0IGNyZWF0ZXMNCj4g
YW5kIHJlYWxpemVzIHRoZW0uDQo+DQo+IEJ1cyB0eXBlcyBjb21tb25seSBwcm92aWRlIGEgbGF5
ZXIgYWJvdmUgcWRldiBmb3IgdGhhdC4gIFBlcmhhcHMgdGhlc2UNCj4gbGF5ZXJzIGNvdWxkIGFs
c28gdXNlIGNvbnZlbmllbmNlIGZ1bmN0aW9ucyB0byBtb3JlIGVhc2lseSBkZWFsIHdpdGgNCj4g
c2V0dGluZyB0aGUgUU9NIHBhcmVudC4NCg0KDQpJIHRoaW5rIHRoZSBjcnV4IG9mIHRoZSBwcm9i
bGVtIGlzIHRoYXQgd2UgZW5kZWQgdXAgaW5oZXJpdGluZyBjcmVhdGlvbiANCkFQSXMgdGhhdCBk
aWRuJ3QgbmVjZXNzYXJpbHkgZXhwcmVzcyBhIGNsZWFyIHBhcmVudC9jaGlsZCByZWxhdGlvbnNo
aXAsIA0Kc28gd2UgZW5kIHVwIG9ycGhhbmluZyB0aGVzZSB0eXBlIG9mIG9iamVjdHMgaW4gdGhl
IFFPTSB0cmVlLiBTbyB0aGUgDQoqcmVhbCogYW5zd2VyIElNSE8gaXMgdG8gcmVidWlsZCBhbGwg
dGhlc2UgQVBJcyBpbnRvIHNvbWV0aGluZyB0aGF0IA0KZW5mb3JjZXMgdGhhdC4gVGhpcyB3YXkg
d2UgYWxzbyB3b24ndCBoYXZlIG5ldyBvZmZlbmRlcnMgc25lYWtpbmcgaW4uDQoNCkkgd29uJ3Qg
YmUgYWJsZSB0byBzcGVuZCB0aGUgd2Vla3MgaXQgcmVxdWlyZXMgdG8gZG8gdGhpcyBieSBoYW5k
LCBidXQgSSANCmNhbiBoYXZlIGEgc3RhYiBhdCBpdCB3aXRoIEFJIC0gd2hpY2ggaXMgbGlrZWx5
IG11Y2ggbW9yZSByZWxpYWJsZSBhdCANCmdldHRpbmcgdGhpcyBkb25lIGNvcnJlY3RseSB0aGFu
IG1lIHRvbyA6KS4gSSBjYW4gcG9zdCBpdCBhcyBSRkMgYW5kIA0KdGhlbiB3ZSBkZWNpZGUgd2hl
dGhlciB3ZSB3YW50IHRvIHRha2UgaXQgb3IgbGVhdmUgaXQuDQoNCg0KQWxleA0K

