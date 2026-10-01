Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 37B41CA5FCE
	for <qemu-devel@archiver.kernel.org>; Thu,  1 Oct 2026 23:28:52 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xCQCY-0002ST-9U; Thu, 01 Oct 2026 19:28:34 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1)
 (envelope-from <prvs=727d860e1=Alistair.Francis@wdc.com>)
 id 1xCQCW-0002Rx-60; Thu, 01 Oct 2026 19:28:32 -0400
Received: from esa5.hgst.iphmx.com ([216.71.153.144])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1)
 (envelope-from <prvs=727d860e1=Alistair.Francis@wdc.com>)
 id 1xCQCU-0001YP-DI; Thu, 01 Oct 2026 19:28:31 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
 d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
 t=1790897315; x=1822433315;
 h=from:to:cc:subject:date:message-id:references:
 in-reply-to:content-id:content-transfer-encoding: mime-version;
 bh=+5S2OwG0xawCUfqh5zbFA9aNppL+UdP0rj79woPEYkg=;
 b=cvBBnOPx8BXBBMLAtWAeFrF/K0d2sQDEnAcg0GfD5A7F54rZJLSljWCa
 7A+3HWXJOye6eWOfqsyfYjRWdPqQboTqzFEMW/HuvipSg/03XuSq5SLtH
 c1CNzGa/13ktWRaM2gIfn6J2Xz9azdMGNoxYbC3UNcAkKtb+wlzCFRWZz
 TzH7m2a7xa92CKcUhCnGDPkPfT8Hdrbsxx9eiQVA5/LsFPFrr0qgh2NQr
 xPW4T39/d08QLvuhc0xMfvT+KNy7wXacm5eYcU0AdDzgrfRzkB2ic1cVF
 xX2IvC9aTWAXIK/fxXBmbYeAVA8+9v1tMlqdRy5jIJiWKScYUOliihUIU A==;
X-CSE-ConnectionGUID: emBuoK3uTRqELbQJy0r5Jg==
X-CSE-MsgGUID: cVBR4TymQZqxr5CV9ucRqQ==
X-IronPort-AV: E=Sophos;i="6.27,135,1786982400"; d="scan'208";a="156121677"
Received: from mail-southcentralusazon11012019.outbound.protection.outlook.com
 (HELO SN4PR2101CU001.outbound.protection.outlook.com) ([40.93.195.19])
 by ob1.hgst.iphmx.com with ESMTP/TLS/ECDHE-RSA-AES128-GCM-SHA256;
 02 Oct 2026 07:28:33 +0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=sCA5cuEc+mz/YBefRJ6ZnarmJtONBq21MWqMOyjt8R3fEgtEQOYKntLBsDlm0dZwh2jI16Yilr9w9RM9+RDOsWPURZp4w/0eM+aqOVDfAuJfMplcjZyiYOzKuk3hkKCVb1KpYrEjoYr76YCYG8YzhuQhzz/KC31Uco80m7j3uM8RS8gfvPOxKbkgeqmfrf64ZZUBVxdyuhtzqgnfZgzdqSH0OISU7NnzTW8rJ7gUb9oDfDcus7XmeI4+8AiZiLWvBfqYodGmGxgj0Aq+4vsNkX7cZEkBvjjmri/zrwwR6jzjwgBvzwfX5RNbQSHmzKQXmOgV2hfz+e1F70xtgP5ghA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=+5S2OwG0xawCUfqh5zbFA9aNppL+UdP0rj79woPEYkg=;
 b=Quk/wWWSLlg2BbqK8I6Qr/pLH2erP8NqnfeesoulY8wsdF84gPb+ocw8GXE/d0/9H87IA1MXwrox7VsgUU3XKmG1XQqo/6Hi47uxIW95D5UQ84V5wUEbWjxm++cWUBqEhKmVd2J/0ltHUVP5Ccw2OJliE4kFcxbiXhwEy8MHlNTlVE0DuqL808Y4LXZSHD0Hbjs4wFoW0lTnFzslHKNP7P6PwtFGk1xudwTGXzd1HnMAT8J0QfoNUWvTHlPR6BNxQjj5VG0O8HSM8Q0cLjDRMYryhx8N5z3n094reO0luCNlMFeDbOeEvQyWg58eFqsQWWPLeRZ4O72GRuhf/e24Kw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=wdc.com; dmarc=pass action=none header.from=wdc.com; dkim=pass
 header.d=wdc.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=sharedspace.onmicrosoft.com; s=selector2-sharedspace-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=+5S2OwG0xawCUfqh5zbFA9aNppL+UdP0rj79woPEYkg=;
 b=wenIhKbmILnLUbPwhhl6hNUy3Y8mnqcCtvC6IczSjALZ666gJ6HY519uvkRYVsQiDZ2qVznEjzCYXW056pKAjXYACNnz54TXPcJnAr6qhv7d5gk/meRzPXjYZmWi11q7SZ0sEV8o1dT4PQLlUd4ldGDPKrpHC/rVebClUmDg1zw=
Received: from BY1PR04MB9561.namprd04.prod.outlook.com (2603:10b6:a03:5b6::11)
 by SA6PR04MB9469.namprd04.prod.outlook.com (2603:10b6:806:446::18)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.451.29; Thu, 1 Oct
 2026 23:28:25 +0000
Received: from BY1PR04MB9561.namprd04.prod.outlook.com
 ([fe80::3869:e494:2fa8:9888]) by BY1PR04MB9561.namprd04.prod.outlook.com
 ([fe80::3869:e494:2fa8:9888%6]) with mapi id 15.21.0451.026; Thu, 1 Oct 2026
 23:28:25 +0000
From: Alistair Francis <Alistair.Francis@wdc.com>
To: "dingtaodtdt@gmail.com" <dingtaodtdt@gmail.com>, "qemu-devel@nongnu.org"
 <qemu-devel@nongnu.org>
CC: "dingtao0430@163.com" <dingtao0430@163.com>, "qemu-riscv@nongnu.org"
 <qemu-riscv@nongnu.org>, "pbonzini@redhat.com" <pbonzini@redhat.com>,
 "farosas@suse.de" <farosas@suse.de>, "chao.liu@processmission.com"
 <chao.liu@processmission.com>, "lvivier@redhat.com" <lvivier@redhat.com>
Subject: Re: [PATCH 2/3] qtest: fix k230_decomp_gzip test integer handling
 issues
Thread-Topic: [PATCH 2/3] qtest: fix k230_decomp_gzip test integer handling
 issues
Thread-Index: AQHdUUvUsYD0B1pTtkqE972aEQhyyLbpVoMA
Date: Thu, 1 Oct 2026 23:28:25 +0000
Message-ID: <f75dc58c63d02fac89f3b4940ade9fe54d41ec15.camel@wdc.com>
References: <20261001022223.8633-1-dingtao0430@163.com>
 <20261001022223.8633-3-dingtao0430@163.com>
In-Reply-To: <20261001022223.8633-3-dingtao0430@163.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
user-agent: Evolution 3.62.0 (by Flathub.org) 
authentication-results: mx.microsoft.com 1; dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=wdc.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: BY1PR04MB9561:EE_|SA6PR04MB9469:EE_
x-ms-office365-filtering-correlation-id: 66364002-ee2d-4287-b9b9-08df2013b105
wdcipoutbound: EOP-TRUE
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
 ARA:13230040|376014|1800799024|23010399003|366016|19092799006|10070799003|18002099003|22082099003|38070700021|4143699003|10067099003|56012099006|11063799006;
x-microsoft-antispam-message-info: /cvUAbI/jKI5bkJR+ZF65LSOg3mVIJD3PK2WbHcGIBf801BkZxgy/g/faYZjIfpfPuglDWC2VGi7brM8IZXpmz9mz25ncK59TISeNhZ1KCkaRk0FylYmbjj0i/WVJqax9AiyranXuC2iTtsc7BKSIvCtYQHS0i3vEv6SAiaXifnc9bTEw1nqvtvIkYbh5yKCCwRc8dOp8KEBkdblCVtT/IDSpmfifT/HWng1iHjG60maRGqhSK+oAFcFX/A82wLTN1Rwa6UJj0jo7FmU+7YTvJmn1vnWQtjnvrPsDpVhBSF+NL/XWP471Ntilt/zZI26NY8qeG2KyxEWByPvYNjUIEpTKsFo3hjiFY9S/vsiXDr4WC9E/y5lQctCSCt7VaC9YEy2imSHm5ez4tg/ED7ACxgsKomLi9O0fIDz0CRMysEtReCiZPSG8Lvy6Il9wfKuQPufbVDD+g84JaJgP9Gqd4I7BQ7lekr5dWZ8yq2oAwFTGqKW4iSrLGzW9zeJzI0VqGMBVErsChrRVSujza6b8uuA4zAOIbD4phjVF0tIKAYDdQlmq+wkKZyAv11Gq53oDhvq8sZNoak1krgtPU3FI+t4ToKjXIo0fUBAR3W9U1ASRVxBNb7buP+1fpflVjZTVzCwDeWH/znr6icNW3Ml9ytiNRKveMF8ibolS3jkzaZmKd9EbxNOxQWzJX5C0UVvK7UTk5RXxxrtacF3CmsHhixuB+ppZd2ZP1pGN8TpQ0Q=
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:BY1PR04MB9561.namprd04.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(376014)(1800799024)(23010399003)(366016)(19092799006)(10070799003)(18002099003)(22082099003)(38070700021)(4143699003)(10067099003)(56012099006)(11063799006);
 DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 2
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?akl6dkV5V3VxeXhrTjdtM1lFUFlraHNSOVhraWhBV2cxQmtmZ1l4bFF1WWl4?=
 =?utf-8?B?cHh4V1NuemovUnBzZU1tbUJuQXVMVGRFTjh4YzlXV0ZBbm5yam91VzhraE55?=
 =?utf-8?B?cktsWDBSLzZOV2JFUStVYUdNUkZ5ZDd0NnpLdGNKUWxZc1hVeEdLNGNtdzdw?=
 =?utf-8?B?aWR1cFRKS3JkQnJTK0grKzF0eExtMXd4S2Q1UlMveGhMc01naEJGWGRsTW9T?=
 =?utf-8?B?WkRCR0tadWtsY0FaZDBYclV4cGJIOFRCbDlxK0k0NG1YSmVyTUtyRG5pZ2do?=
 =?utf-8?B?OXFaTmIrWEZodkV6L1FRVTZaQWs4R2lVRTZqSWxTUURjMVluWmxCRHZVaHBy?=
 =?utf-8?B?c2NWYXd4ZU1hS1ZKWVVVdW8xaWFGa0lmUWN1RDg4VEc1YlpTbnV0b2dka1pC?=
 =?utf-8?B?bE93ZHdZOE9hMVd4cGhzS0RTR0g0WVEzdDRxSzZuT2tCZDdDcHJRd284dXZX?=
 =?utf-8?B?Z3BLaXpsc2RkTTR6Ym5NVkFYUGE0S1BpWFdmcW9aWk5XUTZScU5KZ2JITlBN?=
 =?utf-8?B?VTExZENVS0VURWFrSzdhWWFCWFdzaFVoeWt6cnBHQXpsU2FoNDVEVDhUWTJ2?=
 =?utf-8?B?Y2hFZVE5NlA4Yml2NThnRkZhWkp2T0tFZkVMeFpTUFFDLzFtV1llK0JXQ3RI?=
 =?utf-8?B?ejU5Zk9WQVNBdXlKVTJaWGFuOWV2YUF1S3RQYjlaQ2UzUkRmOWhUZU9BSVVr?=
 =?utf-8?B?V1R6bEdrdjlWb1JEUUNGdzAwaWcrTmRJa3BGODBWVGIzdVEzK1ZoYjNtZDBK?=
 =?utf-8?B?N1VXeUFUeE9ndlVaaGRkQVlqQmI0L0lUUm1TT3d6blh5cWl4OTYwSlBSQzJx?=
 =?utf-8?B?T3pCUG1UVzN4Y210WTV5WFBTMFpJazVQVnpXbkN0UUhaWUJsWTVZSi8zQitM?=
 =?utf-8?B?YWRYTTd3VWJ4SVZXSnM5SEMxeVYrYStZZWV3NHd2SDhqQm1rRGVBdzd1c0Zu?=
 =?utf-8?B?VDZUUUZTNXo4UGF0M01lakJmdlJKTitvSDhMUTkrZm1ubmxwMVdrUTJqQ3Uv?=
 =?utf-8?B?Ti9HcXZSdHhBMEFWNTNUY240UDZtL2FOMGYxMGl2VGNobWVZWnNyNXUzWFFR?=
 =?utf-8?B?VFZlRXFTbnBlVU14NXI1UlNYQzIydVZDZTZNQzdVcjRvaHYycUhnQ1VlS1Bv?=
 =?utf-8?B?bXpNVzgvbGJJc2ZuU3V4eXhJMHpnM3IxVFZDV1BEMHViZGpMZ1VPVmRRcDI5?=
 =?utf-8?B?OFVaY1k0eWlGbnpDc21BQmd1M0FxemwrOHB2MHJZTm0yZDVLWloxRnMxbXV5?=
 =?utf-8?B?YWdnamRkc2NGVjdLbGo4eEhZcURYWGxYVGxXOWlqREdKaVVseE9vTStEYjlJ?=
 =?utf-8?B?S09WWkNUcklDSGlUMjBpVDJiTEpuRDlpMWQ1Ui8xbEgxNkdmWGM5b3g5VFU1?=
 =?utf-8?B?SnJuSGgzYXNWL0JvMGxCWm03MGphQXZPaDRvalVVeDhMSXZSL1RRbjN3SWtT?=
 =?utf-8?B?NXJKbnlneEhiVUNFbmtrWGdONHFqY3Z4cWhMdlhibUhuRWwxQ0swVXhQcngx?=
 =?utf-8?B?aitlemVWQzRQYXRxNHhoT0NRTFR4aWJzR1FJT1lwL09keXBOeVdTNlFCeVg1?=
 =?utf-8?B?VG44S0FmRmZJc2RYVm5WUjZVcXFZNHJLQjMvdzMzTmx1YnlTS1RRT2tNU1kw?=
 =?utf-8?B?S0VvZ0UrdjhIUzhObGZ6aCtyTmh0OWpXUDFxdTFnRlg3L1FlbTdPandCSkJa?=
 =?utf-8?B?MjhadHlyaU91emROcDVLbE5pYVJ0bzQvUCsxNG1TZHZJbGV3cUdpL2lsWmpj?=
 =?utf-8?B?WlpKVGhiRVo5YnVKODVKMGExMVlib3RaMEJQNkFiNy9SOS9adTYrY1d2YXMx?=
 =?utf-8?B?UEZCVFNCWVo1TThXN2FXajNJUHl0OFE3d210dm9IWWNZeWdMTmFTT25ZcStD?=
 =?utf-8?B?ZU4xU0gyVGVVajYxRXVwUi94V1RBM1ZJcnJOVC9JbURWNGNGWjV6VTZZenZI?=
 =?utf-8?B?UmhLMnpXaEw1UmNVUi9VdlppYkhTVDRKMU5ubHVpOUowWVJSL0graW04cU11?=
 =?utf-8?B?SnNZYUlNT2xIdlVsYmJCUmRlMkd2MXdodDhYZi9hYXBicXlIUjVTUXpqQVhp?=
 =?utf-8?B?eHdrOEc0bGQwY1p5SnIzMkZ2UWRhR1JiMzV6dnNjWTJjVmlWcGxESmlFSHBz?=
 =?utf-8?B?U3RmZkdvenlXYVIveDM2NmxYcUVmUWpETHpmU2JLczFTeE9hMTc0ekp1QXRm?=
 =?utf-8?B?Q29xUVJ4cXJlSzQ1d3Z2VkJNWHhxNTdqZGlhRnhlQkltT1BlVmdwRXFlQ0Uw?=
 =?utf-8?B?M1VraVJQWXZINmdmdFQzNW1HZGNvWkI4dFlGV2Jad3ZEUW1sNGxod0UxRXo5?=
 =?utf-8?B?bTRUcE1DZHhJaWlKNUxjSkJidFBhVDdvVW12REx2VVFwdGxsMmpLZXppNG40?=
 =?utf-8?Q?idNb847I1sxSR2p1oCVDxifLAbvLKkkJuTirax5aJnqMK?=
x-ms-exchange-antispam-messagedata-1: jMDrkKMHFPDj2sNmMXJgMWbl984OyszpHIk=
Content-Type: text/plain; charset="utf-8"
Content-ID: <7F3C28DB40B353408B58C41F73752FED@namprd04.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-Exchange-RoutingPolicyChecked: s0OJct7g3z4jaWe4J9bY+oycqKAD/UIIL6fkSO5vcQP29sXNrzS75X1zk4eW7iSunwMZcBgknZszo689e4OxStbGuYpKN0qlOD9Fe1loRMomz29Epc24UGwTTNj9EosWd2M3jlu1X5ae6HuMIJzEwvpMTN7iMYNJCqEr9PyuaEi9ZUW7/NeF8JxrNh/abQ3+E9E1vhauFWjG/1s6nV7t/72Xkv3cZ3dAROnhEGWT/AAQZNU+rlamlds25HPqsPtwQWfcWZGFAoL3UoEz+G9FuKnQgYyXfAOf5ZMicZwa/lxOl+8/2wVuzkzZLZT3tekLBNt/sSq89Jm8eNI3v3xu8A==
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: nmuviMbx2kF+mEFp0nPParSKv4fUvAvmuz0BXLSXavrRQD9Qm+RMfU7Dn6N4zh8j4R8V1OtfQgOAump10zbfkV0uKtcXPysL1JzjMuwRLWdR3eYonOt7jHJYNc5JhWlS6ZYGwxmNP6x6PWbYfrlL4qjv3lHSGhPPUXCiCgidxx3sVzoD1d18H23V2reoUsTujiQYJ0pi/MtHIxivOcyEfqu1nJovv7U524qqjXDFA5enc2Zx/qedbmlfmByZMY23C4zW/WZExtpFYul50k4sGtuUzlZb3Zk7dZvAgUg+Z1/aZNQAiEtm1Io6JGuMiQFb3eKOp2mRwJAj+sJ78H83s3mNEOVbacbALW0MnCM4r9vTERaAF8RUrerTFvhwr+Mccu3Ty4dEeIN1fE6tYoqoB/sxyKKrxfyYf7/3xVnyhSs6LQqFnx9Hdcy32zRUW/NKxM3JMQh11QMTzcBv1+1JrDbfkwljJ04spsRFZzxlBHpF+CMlGmvpO1M1Qp3Rsc6i/pTzSXpv07qNfvviZSNWVDlDogqntMQd1j8IHKcNpLoHrQ1TViCxJszBFAmQ36eqTJObPTZNlLd4A8E2/KeDLl1nkQIWHd09uO87ayyUGKgREZL1B1ZRPKziXRT8F04W
X-OriginatorOrg: wdc.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: BY1PR04MB9561.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 66364002-ee2d-4287-b9b9-08df2013b105
X-MS-Exchange-CrossTenant-originalarrivaltime: 01 Oct 2026 23:28:25.6137 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: b61c8803-16f3-4c35-9b17-6f65f441df86
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: P7mfCBm0Vgf2OsEQ0dFU8zHzc4Apce1AQPihKou9OZ/zL2ILkXKdyBPB7gudeIlP301m0Mqd23WZcSF8jSk09BYVivz8AmXoVgVrnn0o+bA=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA6PR04MB9469
Received-SPF: pass client-ip=216.71.153.144;
 envelope-from=prvs=727d860e1=Alistair.Francis@wdc.com;
 helo=esa5.hgst.iphmx.com
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

T24gVGh1LCAyMDI2LTEwLTAxIGF0IDEwOjIyICswODAwLCBUYW8gRGluZyB3cm90ZToNCj4gQ2Fz
dCBzbG90IHRvIGh3YWRkciBiZWZvcmUgbXVsdGlwbGljYXRpb24gdG8gcHJldmVudCAzMi1iaXQg
b3ZlcmZsb3cNCj4gd2hlbiANCj4gY2FsY3VsYXRpbmcgdGhlIFNSQU0gaW5wdXQgYWRkcmVzcy4g
DQo+IA0KPiBSZXNvbHZlczogQ292ZXJpdHkgQ0lEIDE2ODU1MTQNCj4gDQo+IFJlcG9ydGVkLWJ5
OiBBbGlzdGFpciBGcmFuY2lzIDxBbGlzdGFpci5GcmFuY2lzQHdkYy5jb20+DQo+IFNpZ25lZC1v
ZmYtYnk6IFRhbyBEaW5nIDxkaW5ndGFvMDQzMEAxNjMuY29tPg0KPiAtLS0NCj4gwqB0ZXN0cy9x
dGVzdC9rMjMwLWRlY29tcC1nemlwLXRlc3QuYyB8IDIgKy0NCj4gwqAxIGZpbGUgY2hhbmdlZCwg
MSBpbnNlcnRpb24oKyksIDEgZGVsZXRpb24oLSkNCj4gDQo+IGRpZmYgLS1naXQgYS90ZXN0cy9x
dGVzdC9rMjMwLWRlY29tcC1nemlwLXRlc3QuYyBiL3Rlc3RzL3F0ZXN0L2syMzAtDQo+IGRlY29t
cC1nemlwLXRlc3QuYw0KPiBpbmRleCBlODAxMTNmZDI4Li4yNDljOGFlODJjIDEwMDY0NA0KPiAt
LS0gYS90ZXN0cy9xdGVzdC9rMjMwLWRlY29tcC1nemlwLXRlc3QuYw0KPiArKysgYi90ZXN0cy9x
dGVzdC9rMjMwLWRlY29tcC1nemlwLXRlc3QuYw0KPiBAQCAtNDYsNyArNDYsNyBAQCBzdGF0aWMg
aW5saW5lIGh3YWRkciBrMjMwX3NyYW1fYWRkcihod2FkZHIgb2ZmKQ0KPiDCoHN0YXRpYyBpbmxp
bmUgaHdhZGRyIGsyMzBfc3JhbV9pbnB1dF9hZGRyKHVuc2lnbmVkIGludCBzbG90KQ0KPiDCoHsN
Cj4gwqDCoMKgwqAgcmV0dXJuIGsyMzBfc3JhbV9hZGRyKEsyMzBfREVDT01QX0daSVBfU1JBTV9J
Tl9CQVNFICsNCj4gLcKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKg
wqDCoMKgIHNsb3QgKiBLMjMwX0RFQ09NUF9HWklQX0JMT0NLX1NJWkUpOw0KPiArwqDCoMKgwqDC
oMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqAgKGh3YWRkcikgc2xvdCAq
DQo+IEsyMzBfREVDT01QX0daSVBfQkxPQ0tfU0laRSk7DQoNCldoYXQgaXMgdGhlIHBvaW50IG9m
IHRoaXMgZnVuY3Rpb24/IEl0J3Mgb25seSBldmVyIHBhc3NlZCAwDQoNCkFsaXN0YWlyDQoNCj4g
wqB9DQo+IMKgDQo+IMKgLyoNCg==

