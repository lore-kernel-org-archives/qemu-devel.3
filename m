Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 25DDDC43458
	for <qemu-devel@archiver.kernel.org>; Mon, 13 Jul 2026 09:02:39 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wjCY9-0001eB-1y; Mon, 13 Jul 2026 05:02:05 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <prvs=647032007=graf@amazon.de>)
 id 1wjCY7-0001dh-AO; Mon, 13 Jul 2026 05:02:03 -0400
Received: from fra-out-007.esa.eu-central-1.outbound.mail-perimeter.amazon.com
 ([3.75.33.185])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <prvs=647032007=graf@amazon.de>)
 id 1wjCY4-0005ht-Nn; Mon, 13 Jul 2026 05:02:03 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=amazon.de; i=@amazon.de; q=dns/txt; s=amazoncorp2;
 t=1783933320; x=1815469320;
 h=from:to:cc:subject:date:message-id:references:
 in-reply-to:content-id:content-transfer-encoding: mime-version;
 bh=BaxJCCXrX9+CTQG1RyuJpIbHF5uM3o3qZwBUsM8DqdA=;
 b=eqobSZQrWBzIcm4/GOVzZbdzZZ6SlAyv1C+oGRfGXBkY7K1VP5XPAcqh
 RyF6E3yBgiQ4hnfpKEuRB1P2ApRuEWRqpkaIQ+GRo9Wc4P3xx16OayFCD
 i9mYjqNT9GuhX8lrvDI6ojHsB5SMTiFoBvW0Id4QY4C55UPFPR/eE432j
 wH4KQfSsVyjeP2ChdoupP+8kYxkRSR2XSZ/+TtowlBsYRO4QOHDKCI46t
 bf3VrN4370jIIsmKS4y55PTHps8jfWvwl+ZuMTED90c8Vy/bwtEtkEoyx
 /nhO5oNfKjBrj8m4rMAJYcLD6jTEPaF+FUoCLMLobPxhCr6la5k5KJP+z w==;
X-CSE-ConnectionGUID: 6iTe8Ou9RTKdsP8OajVA5w==
X-CSE-MsgGUID: auy3mhGLQTWy+FKj1xm7Pw==
X-IronPort-AV: E=Sophos;i="6.25,154,1779148800"; d="scan'208";a="16389023"
Received: from ip-10-6-6-97.eu-central-1.compute.internal (HELO
 smtpout.naws.eu-central-1.prod.farcaster.email.amazon.dev) ([10.6.6.97])
 by internal-fra-out-007.esa.eu-central-1.outbound.mail-perimeter.amazon.com
 with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 13 Jul 2026 09:01:53 +0000
Received: from EX19MTAEUB002.ant.amazon.com [54.240.197.224:13290]
 by smtpin.naws.eu-central-1.prod.farcaster.email.amazon.dev [10.0.19.47:2525]
 with esmtp (Farcaster)
 id 66acc7c7-b313-4d14-8cc0-0e0d1678ea51; Mon, 13 Jul 2026 09:01:52 +0000 (UTC)
X-Farcaster-Flow-ID: 66acc7c7-b313-4d14-8cc0-0e0d1678ea51
Received: from EX19EXOEUC002.ant.amazon.com (10.252.51.145) by
 EX19MTAEUB002.ant.amazon.com (10.252.51.79) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA) id 15.2.2562.43;
 Mon, 13 Jul 2026 09:01:52 +0000
Received: from FR4P281CU032.outbound.protection.outlook.com (10.252.50.44) by
 EX19EXOEUC002.ant.amazon.com (10.252.51.145) with Microsoft SMTP
 Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA) id 15.2.2562.43
 via Frontend Transport; Mon, 13 Jul 2026 09:01:51 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=Sc686c4atrOoqrWnGzl1YGPNBEnx5f0FIMn7ogaZ/lTAS7VkCN060Ocx0YPALoB3xH6f6RqjX4ZBDxU44rVrKmOahm9ZDY2cP7GgwQjN0JptSL66GhhXJi3aD5khDya7QBcaiU4v9xKXuhfneu6RA5DHisjxc+hUHNwuRl3K5Q5evaZyVCQPZtGFUhFcL4/nhAvplHlvBBqGS81W+GNpSkUqX9n6mLlDy0TBVFeXXUifS4FlQfOE/LTyjuCXYVs6dlxWwZ8siwdGOJDdEIOOkt/+aYO3ijviqRqpcPbNqpkZt5jEz2eR3Kjw7zErWc6UrTJ6Ov524TtmkuySEWts6g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=BaxJCCXrX9+CTQG1RyuJpIbHF5uM3o3qZwBUsM8DqdA=;
 b=ZPZlkliL6SygktbNOGu6P5zo83euaPA4jJFmTCWDLiQWwLAy7ZQftXD+UCnU1R6ULoMACErPOrayplJT8hPc/OXahLfvbv+UZVe8OMjDuNef6mXoFgvF350PqVk0wbDkPLq4+PxJD+GSFVvFZvbfgypmQHleDyp10NyerY07djdduvBL5Msd74cU3TArV8XSrb1tfB1kcwy6JVp0eYw1ZsJPCqg1/gRXEdZDyVrGlloQz9BUAqKkv3BRIm/yAdFMw3ioxqB7+I04EjNPVencwFtTOgaA9gWasuC4s9MrMHpgX2/LCq/aPGLjleFRxVCjZZnMAfL7MYjwJRaGwCnglQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amazon.de; dmarc=pass action=none header.from=amazon.de;
 dkim=pass header.d=amazon.de; arc=none
Received: from FRSP281MB6250.DEUP281.PROD.OUTLOOK.COM (2603:10a6:d10:1e0::23)
 by FR4P281MB4151.DEUP281.PROD.OUTLOOK.COM (2603:10a6:d10:fb::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.202.18; Mon, 13 Jul
 2026 09:01:48 +0000
Received: from FRSP281MB6250.DEUP281.PROD.OUTLOOK.COM
 ([fe80::7ad:f028:e0a7:bd4b]) by FRSP281MB6250.DEUP281.PROD.OUTLOOK.COM
 ([fe80::7ad:f028:e0a7:bd4b%6]) with mapi id 15.21.0202.014; Mon, 13 Jul 2026
 09:01:48 +0000
From: "Graf (AWS), Alexander" <graf@amazon.de>
To: =?utf-8?B?RGFuaWVsIFAuIEJlcnJhbmfDqQ==?= <berrange@redhat.com>
CC: "qemu-devel@nongnu.org" <qemu-devel@nongnu.org>, "qemu-arm@nongnu.org"
 <qemu-arm@nongnu.org>, "qemu-ppc@nongnu.org" <qemu-ppc@nongnu.org>,
 "qemu-riscv@nongnu.org" <qemu-riscv@nongnu.org>, "qemu-s390x@nongnu.org"
 <qemu-s390x@nongnu.org>, Song Gao <17746591750@163.com>, Aditya Gupta
 <adityag@linux.ibm.com>, Alexey Kardashevskiy <aik@ozlabs.ru>, Farhan Ali
 <alifm@linux.ibm.com>, Alistair Francis <alistair.francis@wdc.com>, "Alistair
 Francis" <alistair@alistair23.me>, Antony Pavlov <antonynpavlov@gmail.com>,
 Markus Armbruster <armbru@redhat.com>, Artyom Tarasenko
 <atar4qemu@gmail.com>, BALATON Zoltan <balaton@eik.bme.hu>, Felipe Balbi
 <balbi@kernel.org>, Christian Borntraeger <borntraeger@linux.ibm.com>, "Brian
 Cain" <brian.cain@oss.qualcomm.com>, Hendrik Brueckner
 <brueckner@linux.ibm.com>, Chao Liu <chao.liu@processmission.com>, "Huacai
 Chen" <chenhuacai@kernel.org>, =?utf-8?B?Q2zDqW1lbnQgQ2hpZ290?=
 <chigot@adacore.com>, =?utf-8?B?Q8OpZHJpYyBMZSBHb2F0ZXI=?= <clg@kaod.org>,
 Helge Deller <deller@gmx.de>, Dorjoy Chowdhury <dorjoychy111@gmail.com>,
 "Edgar E . Iglesias" <edgar.iglesias@gmail.com>, Alexandre Iooss
 <erdnaxe@crans.org>, Eric Farman <farman@linux.ibm.com>, Francisco Iglesias
 <francisco.iglesias@amd.com>, Gaurav Sharma <gaurav.sharma_7@nxp.com>,
 "Gautam Gala" <ggala@linux.ibm.com>, Harsh Prateek Bora
 <harshpb@linux.ibm.com>, =?utf-8?B?SGVydsOpIFBvdXNzaW5lYXU=?=
 <hpoussin@reactos.org>, Jan Kiszka <jan.kiszka@web.de>, Max Filippov
 <jcmvbkbc@gmail.com>, Joel Stanley <joel@jms.id.au>, Jared Rossi
 <jrossi@linux.ibm.com>, Tyrone Ting <kfting@nuvoton.com>, Frederic Konrad
 <konrad.frederic@yahoo.fr>, "Laurent Vivier" <laurent@vivier.eu>, Manos
 Pitsidianakis <manos.pitsidianakis@linaro.org>, Bibo Mao
 <maobibo@loongson.cn>, "Mark Cave-Ayland" <mark.cave-ayland@ilande.co.uk>,
 Glenn Miles <milesg@linux.ibm.com>, Matthew Rosato <mjrosato@linux.ibm.com>,
 "Michael Rolnik" <mrolnik@gmail.com>, "Michael S . Tsirkin" <mst@redhat.com>, 
 "Niek Linnenbank" <nieklinnenbank@gmail.com>, Nicholas Piggin
 <npiggin@gmail.com>, Palmer Dabbelt <palmer@dabbelt.com>, Halil Pasic
 <pasic@linux.ibm.com>, "Paolo Bonzini" <pbonzini@redhat.com>, Peter Maydell
 <peter.maydell@linaro.org>, =?utf-8?B?UGhpbGlwcGUgTWF0aGlldS1EYXVkw6k=?=
 <philmd@mailo.com>, "Pierrick Bouvier" <pierrick.bouvier@oss.qualcomm.com>,
 Richard Henderson <richard.henderson@linaro.org>, Sai Pavan Boddu
 <sai.pavan.boddu@amd.com>, Samuel Tardieu <sam@rfc1149.net>, Bernhard Beschow
 <shentey@gmail.com>, Stafford Horne <shorne@gmail.com>, Sergio Lopez
 <slp@redhat.com>, "Subbaraya Sundeep" <sundeep.lkml@gmail.com>, Thomas Huth
 <th.huth+qemu@posteo.eu>, "Ran Wang" <wangran@bosc.ac.cn>, Hao Wu
 <wuhaotsh@google.com>, =?utf-8?B?QWxleCBCZW5uw6ll?= <alex.bennee@linaro.org>
Subject: Re: [RFC PATCH 001/134] qom: Introduce object_new_child()
Thread-Topic: [RFC PATCH 001/134] qom: Introduce object_new_child()
Thread-Index: AQHdEqY8nCrcgEDIYkGrfuBuKsmkWw==
Date: Mon, 13 Jul 2026 09:01:48 +0000
Message-ID: <3205c42d-6ceb-4e4a-b527-d0dfed4537b3@amazon.com>
References: <20260711223707.42139-1-graf@amazon.com>
 <20260711223707.42139-2-graf@amazon.com> <alSmLv3qq6kl3o2i@redhat.com>
In-Reply-To: <alSmLv3qq6kl3o2i@redhat.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amazon.de;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: FRSP281MB6250:EE_|FR4P281MB4151:EE_
x-ms-office365-filtering-correlation-id: 63eefe28-5915-4073-3258-08dee0bd5f08
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
 ARA:13230040|23010399003|366016|1800799024|7416014|376014|22082099003|6133799003|18002099003|38070700021|4143699003|11063799006|5023799004|56012099006;
x-microsoft-antispam-message-info: cNgApZzbblPRTouYzLlRZHlT0irKihCcedk2QcoSbdgkx2HKAGNJiOy0qV49EdCxsEwhTll6v7g4qmnSUU98yZUPtG8WV9MZ4ZWrS6N0itkQyLWWgzhxZpx4N+cHUHvwdyo7cSw+k6fkud4cWb7La5LtTS8YwuNFB3vEw7WJpSyZ6xj2ATYId8nFrLwFwbsy8CDPuEfQ2HWf2aQAUViHbf44z+NYCOyy4FcynAPRI0cPZgA6jm5Zk693BTiNAT0SvKQEzY22kT4hRkYB3l0+ARO8dR6TgCLQz1HzPSP+Hdq+qLRftEQFyzawGZp7UCJj9dY6vJElkDooZabZufQhMSLTs6EiRdiAsPQV/6GdDuWktjQLQibDXcfvkucJzfSTSI4sCAo0g4PCfpIxGQwKeE//keywy7aROmNK4KwEA221BSBijqypzhJnwJ45Nj04eElqr8Ql1+SqHUCXZ9U5VYqD1aZHPrDX3aDUKUU5TIr1Y1iIVujwCXAHstbDCV7Tvarp1gV3Ga1kodbSfoKGbKmTgVjWeG/o474cF0LzmcYJJE0yUXC9WON7LwEjv55aNGnN/N412GO2vZp2+2CHmJ4exn+E4X4n1l9Ft7GzDBqI/BVpuhbajLLw6GcTwNh6w5gauSY4lzqSdxc3edq01ZYDNi4qWbbkOxufOjJ+Rv/YLxXgFI3SV5eQjHElSfvRmsGu8Jd4O492UX6hXHBfcD5A1uBmIexc6gZ00Ec9izs=
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:FRSP281MB6250.DEUP281.PROD.OUTLOOK.COM; PTR:; CAT:NONE;
 SFS:(13230040)(23010399003)(366016)(1800799024)(7416014)(376014)(22082099003)(6133799003)(18002099003)(38070700021)(4143699003)(11063799006)(5023799004)(56012099006);
 DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?aERZTjl3N1BkdDRsc2FadVBVSXNzbHpTY2hWeUNiNUVjaUIrQWdWc0paVnpw?=
 =?utf-8?B?cWdDR0pRWHdjUGpGc3JDQzFZa2JER29vYlgzYVhNdDdGSjhrcWF0MHZrb3Bn?=
 =?utf-8?B?UzRmVDJPYThOK1N6UU5jVXZ0aFc5VFF6UmFIOUZWK3hhWERibWUyR3FYVEV4?=
 =?utf-8?B?YWFyT29TMWFuN2ZKcmtRUE50S2FyY2luT1VRU3lzL0RSZDh4U3ZwMEZrRlhz?=
 =?utf-8?B?UTNBMjAyZmc3d2dqRyt6R20weFZma25YZDhsRFhQM0pDZ1VnZ3ZaNWd3VkVI?=
 =?utf-8?B?dUZ2RkU2c0l3YXV0TWtGRVpTbXhBTU82MytsUmNPdkZRRGlZaGI4TWg2RWVq?=
 =?utf-8?B?bE1CdmhqSWRWS1VDSmxkeGdiRFU0OFlYME5xbWZpdnpIRWtCbDY2SjNmS0JQ?=
 =?utf-8?B?T1c4cTJmNFN3RnBkazgvYm1RL2UrT2ZSemFYMkxOMVNEV0c1dVJhb0VSdDFq?=
 =?utf-8?B?SHNQU2VSVk1zTjUwZ3JKOGdYdWluclZ4bm9tbDlyM2t0V0xRdk1tdHVhck1l?=
 =?utf-8?B?VTNoTnBrNnBoSWVEQVRHVEFndDBpZzJ6T2RwS3R1UGtsVmFOMmNRS1pTblYr?=
 =?utf-8?B?cDRxUEN1M2JlY0JMcVphdkFCWjlLQVVObkN1TzFDQTY4T1F2ZHZ2V2JuRTlS?=
 =?utf-8?B?SEVVNDZtallKaWsrS2IvcmFQSTVaY1VTYnNzQklQRTlaTjB3dmc5ei9vdXVk?=
 =?utf-8?B?QU1DWEdyRzNJdnQxZ3paRTYyWjRkM0NJM1hrM3ZpOWo3Mkl3aEhzQXZGUlZn?=
 =?utf-8?B?bVNCSDhJOTFHSDl2eUgxejZPMnVYTVBkeWVSNkNybURrYm91V0hmazVMaVRS?=
 =?utf-8?B?VnZmQk4rZzE3cGllb1ZNTDA2Umw2T3luQTFUazlZME8xRHZnQXVhS0lScXVr?=
 =?utf-8?B?S0Q1N05kSEN2dVhVa0pEU2VHZEh3aDd0Qmt0NmNNT3lyYURHYVFkQnpmV3RV?=
 =?utf-8?B?WCtvY05weWxTd2t4cDRoc2FaM0hIVTdlTXhlOWZDTGplZW0rSGtWZEtFWm5B?=
 =?utf-8?B?elZpQlNzWEdFc1JaRGdMS1p1amtIRmdrRlZGNTNkeXFIZUxXRTlWcTh6aGhU?=
 =?utf-8?B?RnJleXBYemhSZkV2QVdaeWtQREJtZElJQWE2VnV4MjI1NDJGdkVsd2QvWTBr?=
 =?utf-8?B?UGs5eUlJdXpuL01QQlFGaGlyY01XMHFtVUdKQjlOK1JId1M4VVFnc3doWEs3?=
 =?utf-8?B?WE5DZjdoTkg2SnlQRFgyMUk0aUVqcHRIVE9lUWZEcWlmeXVJbGNJNkpZUUdD?=
 =?utf-8?B?MitINzZDUWI3MzMxVFBiMWpxNDNtUDZTTzV3ZEtJZ3pyT1FQQkQyZWE0bndL?=
 =?utf-8?B?RDlLdXozemRvWkx1TjRHcW52MmpMMWM4elI1dEhDTjlQZzB1MllQMlBudWsy?=
 =?utf-8?B?bUxFQnRmamFWUWdsNXJZMU52SHhRZjcxeTVxVVFwS0JTU0JrdHN1SFdmNVBj?=
 =?utf-8?B?bWhIcHVFUzBRREE3M21YdEVmVE01UkNOamVENHpudHdreVhPYm5ZL1NaczNq?=
 =?utf-8?B?d2NaTzFTTjRmcHpZV2ZaNXlIM1lWVjFSNC8xaWdKMzNPS3I2dXFNcGV2eElM?=
 =?utf-8?B?TVB5RFVNRTlxNEhSeVJKN29TNExnSmFhQmpveVJXUzR6T0xoaDkwdG1SSmxU?=
 =?utf-8?B?UTkxUGtOUW1XOVJJK2JIVnFmdG9DNm1qMTdYbGJ2Yy9RcmgvYmYzamxIMDVp?=
 =?utf-8?B?WUx1enBoOTJQbkZRa1RlWC9CVU9vOGpLY2pyYnpoOVdHaE9IYVV4YTQwNFZI?=
 =?utf-8?B?U0g1UFh0aUVyK2FJK2F2NWlOYm9sREt6dHJKSjBHY3h3WUd4VXJFdllGYVY2?=
 =?utf-8?B?VHdUdVdrN25UVDd1NUxhdk91Y2dnbkZDZTV2UWp3SGtkL1FtNDI2eVRVaUV6?=
 =?utf-8?B?ZHcvbjNzMUk0SHR1Y0M0bEp5ME9ueDdSVUIvZ01KNU5KM3hYd2xGeGphTHB5?=
 =?utf-8?B?ay96WHQ4TTJ2WFlHSEZ3TEVvRDVpUm04MzVnVW9mY0xVUGpPNGJFN3RnWVdR?=
 =?utf-8?B?RW4zNGtVbmo0eVorbS90Vkk5dFZLSU1SZFgvMzdEWmdiSzBIdk9pYnlDaWYv?=
 =?utf-8?B?REJDVS8rL1JJVkVJR2t0VCt6R0lBUkpoUituWENIaWZEemxGRGpMME9sc3Ru?=
 =?utf-8?B?MEU4UmJUVVltRjFVUW5VQUcrVzhzVXF3MGFOQno1VklNR1EyUVF4UEJpVkVY?=
 =?utf-8?B?d1ZTSUhwUFVNQWlZdXdPVDBlZytoTzQ2T1FiSk5hbnVPOHAycTlGNXlCeEtH?=
 =?utf-8?B?d0FFdTRSR09PeWwzY1BqcnN3M1JicVNpSlM3b044c2FEd0Vib3RWOWwzeXhl?=
 =?utf-8?Q?ySLovUulcTusI9Phoh?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <B4F2F3FEEBA726439E1C2013A0590E79@DEUP281.PROD.OUTLOOK.COM>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-Exchange-RoutingPolicyChecked: pXRIBaK/jcQUpGXBW8ZB3YdD4Wm2oB22Phx1kfRVKkW9yeYW0KURI6SsmyFbioawF1yAwvmXRxU70HCYitaAajw/l5y9P1j4mW5VMVJfvlwsjQpsmupOrNVMKJ1wS0zK6jWDriUF3pgFqvS7N1z3LAZRaOoJXoMfu9IVpZFmejbZyrCZXPk/N/WQAYZIyOL45XNtN73k6XxkG1BRC4s8pV45Vx4qJ1Irh/Vc1XlHMs5wGzOExTwx+DZnNmoSyVLo/cP8wnV9ziLedt473oCBy+YkHzptYhFxhTHwKzXB5GIL8HSO097adXhpWaJJ5DoW+/XFOmSYTSAehtGD8+xt5w==
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: FRSP281MB6250.DEUP281.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-Network-Message-Id: 63eefe28-5915-4073-3258-08dee0bd5f08
X-MS-Exchange-CrossTenant-originalarrivaltime: 13 Jul 2026 09:01:48.0666 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 5280104a-472d-4538-9ccf-1e1d0efe8b1b
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: XhC/sHXp6N2wLjE2v2qHVMe3cPaUQWR6oMwz7nA3V8noUrQHDqK8Z5kVmBz3DUvx
X-MS-Exchange-Transport-CrossTenantHeadersStamped: FR4P281MB4151
X-OriginatorOrg: amazon.de
Received-SPF: pass client-ip=3.75.33.185;
 envelope-from=prvs=647032007=graf@amazon.de;
 helo=fra-out-007.esa.eu-central-1.outbound.mail-perimeter.amazon.com
X-Spam_score_int: -27
X-Spam_score: -2.8
X-Spam_bar: --
X-Spam_report: (-2.8 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
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

DQpPbiAxMy4wNy4yNiAxMDo0NywgRGFuaWVsIFAuIEJlcnJhbmfDqSB3cm90ZToNCj4gT24gU2F0
LCBKdWwgMTEsIDIwMjYgYXQgMTA6MzQ6NTRQTSArMDAwMCwgQWxleGFuZGVyIEdyYWYgd3JvdGU6
DQo+PiBXZSBhbHJlYWR5IGhhdmUgdHdvIHdheXMgb2YgY3JlYXRpbmcgYSBRT00gb2JqZWN0IHdp
dGggYSBwYXJlbnQgc2V0DQo+PiBmcm9tIGJpcnRoOiBvYmplY3RfaW5pdGlhbGl6ZV9jaGlsZCgp
IGZvciBvYmplY3RzIGVtYmVkZGVkIGluIHRoZQ0KPj4gcGFyZW50IHN0cnVjdCwgYW5kIG9iamVj
dF9uZXdfd2l0aF9wcm9wcygpIGZvciBoZWFwLWFsbG9jYXRlZCBvYmplY3RzDQo+PiB0aGF0IGFs
c28gd2FudCBhIGxpc3Qgb2Ygc3RyaW5nIHByb3BlcnRpZXMgYXBwbGllZC4gIFdoYXQgd2UgZG8g
bm90DQo+PiBoYXZlIGlzIHRoZSBwbGFpbiBoZWFwLWFsbG9jYXRlZCBkdWFsIG9mIG9iamVjdF9p
bml0aWFsaXplX2NoaWxkKCk6DQo+PiBjcmVhdGUgdGhlIG9iamVjdCwgYWRkIGl0IGFzIGEgY2hp
bGQ8PiBvZiBhIGdpdmVuIHBhcmVudCB1bmRlciBhIGdpdmVuDQo+PiBuYW1lLCBhbmQgaGFuZCB0
aGUgcmVmZXJlbmNlIHRvIHRoZSBwYXJlbnQuDQo+Pg0KPj4gQm9hcmQgYW5kIGNvbXBvc2l0ZS1k
ZXZpY2UgY29kZSB0aGF0IGhlYXAtYWxsb2NhdGVzIGNoaWxkcmVuIHRvZGF5DQo+PiB0aGVyZWZv
cmUgZWl0aGVyIG9wZW4tY29kZXMgb2JqZWN0X25ldygpK29iamVjdF9wcm9wZXJ0eV9hZGRfY2hp
bGQoKQ0KPj4gK29iamVjdF91bnJlZigpLCBvciBza2lwcyB0aGUgcGFyZW50aW5nIHN0ZXAgZW50
aXJlbHkgYW5kIGxldHMNCj4+IGRldmljZV9zZXRfcmVhbGl6ZWQoKSBkdW1wIHRoZSBvYmplY3Qg
aW50byAvbWFjaGluZS91bmF0dGFjaGVkLg0KPj4NCj4+IEFkZCBvYmplY3RfbmV3X2NoaWxkKHBh
cmVudCwgaWQsIHR5cGVuYW1lKSBhcyB0aGF0IG1pc3NpbmcgcHJpbWl0aXZlLg0KPj4gVGhlIHJl
ZmVyZW5jZSBjcmVhdGVkIGJ5IG9iamVjdF9uZXcoKSBpcyB0cmFuc2ZlcnJlZCB0byB0aGUgcGFy
ZW50J3MNCj4+IGNoaWxkPD4gcHJvcGVydHksIHNvIG9uIHJldHVybiB0aGUgc29sZSByZWZlcmVu
Y2UgaXMgaGVsZCBieSBAcGFyZW50DQo+PiBhbmQgdGhlIGNhbGxlciBkb2VzIG5vdCBuZWVkIHRv
IHVucmVmLiAgTGF0ZXIgcGF0Y2hlcyBidWlsZCB0aGUgcWRldg0KPj4gYW5kIHBlci1idXMgY3Jl
YXRpb24gaGVscGVycyBvbiB0b3Agb2YgdGhpcy4NCj4+DQo+PiBTdWdnZXN0ZWQtYnk6IE1hcmt1
cyBBcm1icnVzdGVyIDxhcm1icnVAcmVkaGF0LmNvbT4NCj4+IExpbms6IGh0dHBzOi8vbG9yZS5r
ZXJuZWwub3JnL3FlbXUtZGV2ZWwvODdqeXIzdzl0Yy5mc2ZAcG9uZC5zdWIub3JnLw0KPj4gQXNz
aXN0ZWQtYnk6IEtpcm8NCj4gUUVNVSBkb2VzIG5vdCBjdXJyZW50bHkgcGVybWl0IGNvbnRyaWJ1
dGlvbnMgYXNzaXN0ZWQgYnkgQUkNCj4gY29kaW5nIHRvb2xzLg0KPg0KPiBUaGVyZSBpcyBhbiBv
cGVuIGRpc2N1c3Npb24gYWJvdXQgYWx0ZXJpbmcgdGhlIHBvbGljeSBidXQgdGhhdA0KPiBpcyBu
b3QgY29uY2x1ZGUgd2l0aCBhZ3JlZW1lbnQgeWV0Lg0KDQoNCll1cCwgd2hpY2ggaXMgd2h5IEkg
Y2FsbGVkIG91dCBleGFjdGx5IHRoYXQgaW4gdGhlIGNvdmVyIGxldHRlciB0b28uIElzIA0KaXMg
YWxzbyB0aGUgbWFpbiByZWFzb24gdGhhdCB0aGlzIHBhdGNoIHNldCBpcyBSRkMgOikuDQoNClRo
aXMgc2V0IGlzIGEgZm9sbG93LXVwIGZyb20gYSByZXF1ZXN0IGJ5IE1hcmt1cyB0byBmaXggdXAg
dGhlIFFPTSANCnBhcmVudCBoaWVyYXJjaHkuIEkgc2FpZCB0aGF0IEkgKGFuZCBwcm9iYWJseSBu
b2JvZHkgZWxzZSBpbiBDQykgaGFkIHRoZSANCmRlZGljYXRlZCB0aW1lIHRvIHBlcmZvcm0gdGhh
dCBjb252ZXJzaW9uIGJ5IGhhbmQuIEFuZCBpZiB3ZSANCiJkaXN0cmlidXRlIiB0aGUgd29yaywg
dGhlbiBJTUhPIGl0IHdpbGwganVzdCBuZXZlciBnZXQgZG9uZS4NCg0KQnV0IEkgY291bGQgZWFz
aWx5IGxlYXZlIGFuIEFJIHJ1bm5pbmcgb24gdGhlIHNpZGUgdG8gZ2V0IGl0IGRvbmUuIFRoaXMg
DQppcyBzbyB0aGF0IHdlIGNhbiBzZWUgd2hldGhlciB3ZSB3YW50IHRvIDEvIGNoYW5nZSBvdXIg
QUkgc3RhbmNlIG9yIDIvIA0KZ2V0IGluc3BpcmVkIGJ5IHRoZSBBSSBjb2RlIGFuZCBoYXZlIHNv
bWVvbmUgZWxzZSByZWRvIGl0IGJ5IGhhbmQgb3IgMy8gDQpsZWF2ZSBpdCBiZSBhbmQgY29udGlu
dWUgbGl2aW5nIHdpdGggdGhlIFFPTSB0ZWNoIGRlYnQuDQoNCg0KQWxleA0K

