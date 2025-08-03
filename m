Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2346CC87FCB
	for <qemu-devel@archiver.kernel.org>; Sun,  3 Aug 2025 11:17:01 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uiWhV-0001c8-6i; Sun, 03 Aug 2025 07:16:25 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <yunpeng.yang@nutanix.com>)
 id 1uiWhL-0001Z8-1F
 for qemu-devel@nongnu.org; Sun, 03 Aug 2025 07:16:23 -0400
Received: from mx0a-002c1b01.pphosted.com ([148.163.151.68])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <yunpeng.yang@nutanix.com>)
 id 1uiWhH-0002Z4-3a
 for qemu-devel@nongnu.org; Sun, 03 Aug 2025 07:16:14 -0400
Received: from pps.filterd (m0127837.ppops.net [127.0.0.1])
 by mx0a-002c1b01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 5735ZQ0a012640;
 Sun, 3 Aug 2025 04:15:52 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nutanix.com; h=
 cc:content-type:date:from:in-reply-to:message-id:mime-version
 :references:subject:to; s=proofpoint20171006; bh=cB5OnvE4yi3BQ0j
 9ckXbCfdshBWW/fniLmnUsFahwNg=; b=nPDi0n4yaCKoQVGBFeeSnnVI2FABzD/
 o6V8yVE8W+VzvqC5RnRV3nhSK6tmeosCnli+7rVngRjg/Ae18d766u4eKF8kDCO+
 tleDx6ot7r2+IXTvHpqAGCKbPtIVEBgErLtauhPwUI/iPaPIa46Q80TciQES9xfM
 wgikG0Kgwi0SW7S7i5ciOeoJsCbTURPO++UqrgnGJwyFJd11A0BjjGsjiczEGe8L
 uwL7krbxL1DGGC1+hiKIqv2Ekn0hED5IXx7AOky8pUg6SCt9H+fkTpPD0xihqcF+
 jvS0+Isq4leS7HvHoC8mNfdhPkbd9AN3qyWlKFfUp37RgnmFBDdjhHw==
Received: from nam12-bn8-obe.outbound.protection.outlook.com
 (mail-bn8nam12on2127.outbound.protection.outlook.com [40.107.237.127])
 by mx0a-002c1b01.pphosted.com (PPS) with ESMTPS id 489ek719a2-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Sun, 03 Aug 2025 04:15:51 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=OGBw7fJJJ0Q1LZz0w/hBQ7OL130w+7DDuGGcv/FyqD8LXvjluRpLGhWpbml1SXimLRgl5WrfEj4uvIaJx+OFcGn4rUsaqCXwzfmy6hhHdJat3bi4hPUVhUJH/OqQ1jpnw7jaTK//d0/l6Z0Fn07gnzg08+jrQ2jHQHv5IG04oLlytF0wsROY3j6we0QKOnRT5eSAhEOWi6HGTqW8yDa6tQokltxfH1pbY4QDomymVkh5DN3zV73Yrg57qjG6RKh+1hbIptLBadkw6g/T2uDMsmUW05UcJWyHmZIcF45IMdSkAl/LK8prpDuBRZwTe7XioApn7krfj3EIARO0Q6u6uw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=cB5OnvE4yi3BQ0j9ckXbCfdshBWW/fniLmnUsFahwNg=;
 b=GNOp+0wFWewC6PocU+P3UK50qqhZ8onWOm8Arx5+5ti1LcZCVxJNgEuNxzqNAbI8I6Vtj/0hE0GGC3F3VUDhpv1s45luVoq8ogr+MU4vpq3JACI2jWQ02yh9VtJoEjG382GeaWH9SvqGNbmHjbMKBOxu9Cx5Z2E0t75AYmnFcYd35sz8oObGiYYKL8wpYOHJFs4aJhZ6N6S+PaXBGZwaXm3BJQt9ECboK1GDZ6HoXm7cBUjHurLDxjlg3nDVWrisProTlqPrfY6jqQARPkZ/UjTcMkqp/IMh0N7Irt4OW+rKPIQsK74pceXGUB1kxo3Ap6CbpXIh7o7A2m3nhwlFrw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nutanix.com; dmarc=pass action=none header.from=nutanix.com;
 dkim=pass header.d=nutanix.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nutanix.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=cB5OnvE4yi3BQ0j9ckXbCfdshBWW/fniLmnUsFahwNg=;
 b=CQ1sv/7toqPS2/Ff4mR78UDaB3LX8fKuks/bH/9omPeZn6nZ5FxWTyPNAztMPHAAmQMlio+ABQhO+PywIzKbE9sAAF42rkL3o47q4+U5U6UE81lCG5QFFB2T1Mp2Fr3yMGGLgvr+nzwuu+Qg2v1GuMAzK9hJM3mgnQletu4skGaRUw+1F38cV+sEYgAE6bWalShApLPN13/ak2v4JnYtM1VA5ibKV8siImkATqq9RexW1fDIMVq1zUfZ5RQNrwFxhTRQvbCUTgEd2V6KPBFXf4b0LDiYnGL2R4kjVBSH4FTwAL7sgxVLf4C5FR15wcISLDDLNudKPoBkAXw9mx7f+g==
Received: from BYAPR02MB5029.namprd02.prod.outlook.com (2603:10b6:a03:61::24)
 by PH0PR02MB7256.namprd02.prod.outlook.com (2603:10b6:510:1a::23)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8989.20; Sun, 3 Aug
 2025 11:15:47 +0000
Received: from BYAPR02MB5029.namprd02.prod.outlook.com
 ([fe80::3158:6137:fd0f:d590]) by BYAPR02MB5029.namprd02.prod.outlook.com
 ([fe80::3158:6137:fd0f:d590%7]) with mapi id 15.20.8989.017; Sun, 3 Aug 2025
 11:15:47 +0000
From: Yunpeng Yang <yunpeng.yang@nutanix.com>
To: "minyard@acm.org" <minyard@acm.org>
CC: "qemu-devel@nongnu.org" <qemu-devel@nongnu.org>, Mark Cave-Ayland
 <mark.caveayland@nutanix.com>, Jonathan Davies <jond@nutanix.com>
Subject: Re: Add support for retrieving fake LAN config from `ipmi-bmc-sim`
 device
Thread-Topic: Add support for retrieving fake LAN config from `ipmi-bmc-sim`
 device
Thread-Index: AQHb539cPoDAP+0h/UiqkFcjX4CXjrRQ/kAZ
Date: Sun, 3 Aug 2025 11:15:44 +0000
Message-ID: <BYAPR02MB5029F83A450ED347FF69345F8520A@BYAPR02MB5029.namprd02.prod.outlook.com>
References: <BYAPR02MB502953334AA7CE0A695C373C8545A@BYAPR02MB5029.namprd02.prod.outlook.com>
In-Reply-To: <BYAPR02MB502953334AA7CE0A695C373C8545A@BYAPR02MB5029.namprd02.prod.outlook.com>
Accept-Language: en-US, en-GB
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: 
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: BYAPR02MB5029:EE_|PH0PR02MB7256:EE_
x-ms-office365-filtering-correlation-id: b82afcc2-e70d-4fcc-32cb-08ddd27f1702
x-proofpoint-crosstenant: true
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
 ARA:13230040|1800799024|366016|376014|8096899003|38070700018|7053199007; 
x-microsoft-antispam-message-info: =?iso-8859-1?Q?ZStbNlaaK2x+EusHVb5UmlNqXRmc17sc05llGGjjVDXBtYw1tXh37k7tvo?=
 =?iso-8859-1?Q?vMjdj0qsdS216rEmEsZYYJCWRKcLGLmTTlg4DSRdNXuj4LebE4Se0J11Lt?=
 =?iso-8859-1?Q?dkZti2RSE+O8mGRIuwBwHHxURHTTIcNkASplq3xB7Y52hDn/a5/Eq8Yxcl?=
 =?iso-8859-1?Q?6y2n6MD4XzP0R08qXKNlzbd04d0Bm/uFjA4koqzMya4ooppMXUAV1T+uHE?=
 =?iso-8859-1?Q?radwv6IYGS1WekVtlkQwaYhOqAuQQT4dYAKG+PsogsSr6qaPlOJaOvIBe3?=
 =?iso-8859-1?Q?2PHROFagJfmuqXr4Yi++Zo2tnlGDZglcIx0qwvOdT2/9WztYi3KZIMYShv?=
 =?iso-8859-1?Q?LirJAc0q8zx+RjGap4Bg+EWh4Ui0Fqc/F5rx2C2lNr3XfY1BdYyWrOdVNr?=
 =?iso-8859-1?Q?zSEbqWFP+m8Wqw9We5PhGwyp+jpccfNtiPyjmEQ510bJZwGg773Ga0PQ0D?=
 =?iso-8859-1?Q?GYg0cGj9pinZltA7Z+XzyYsRjNUwT3EtMHlm9kFAFQzNImbSZYOAe3KcZx?=
 =?iso-8859-1?Q?utQfojNq8fmmv+EnkwwTl84UchWrVx+hdTivvKG6BrVfUmCC+XtUwkhyoT?=
 =?iso-8859-1?Q?cbAMqYiM/R5fQODhhJKfNTLyeTBBCJ5UxY6DqWd1dNQLooBelFYRSVX8er?=
 =?iso-8859-1?Q?IAmAy5pSi21EOveKfPJ+S+WiOf//9zkc5f2lDNMSidSe36l8dSW7bbFF3/?=
 =?iso-8859-1?Q?yoOyylbDmXQNq5cAb/kFdmilsaNF6Yn0hS2WAgzQJsAmk8BBz3VAsuqA68?=
 =?iso-8859-1?Q?xyVkPhe4gobl9fTXGFS6mN+e63FO++99qzPUXsDY7+tec/x39oZGw7dVeo?=
 =?iso-8859-1?Q?fa238GXkkW97GDQ3rUrm8wdOOQGgsz9qeECQ6cVMLH38uKMz0glUPlQglW?=
 =?iso-8859-1?Q?vtrzq2zDhvC1Tyn2vdmytW5zmZKFX/HIaBmfc0kbKfYk2nwv4oVe5+0jVM?=
 =?iso-8859-1?Q?oECw15PICOsb1xtKGJ6oRJ3MtvExHBom37l4LMkc6JP7hhVbMN3ttGrRxb?=
 =?iso-8859-1?Q?7lbfidW0ubI1JTzfa+9vPYnqvDFB2XC6YGgw6GGuLbVejNeGGSlXnkCiU9?=
 =?iso-8859-1?Q?HQaTwTVQ+iaN3RV5cs4iZpW6TtxHyYNG5G/j5DvKLdwCQLYK0xhpeaSxbh?=
 =?iso-8859-1?Q?VfQawPTgU3n84LF5SPF1C5Io7eSA6ap5cwsCXzmMMxQLwoycX0HOyWY1FU?=
 =?iso-8859-1?Q?qW91OuavYFuxIwSuv50Os/SuDvU2VWlgNI6PdBaQUZmiDlIpT8qbD8f33z?=
 =?iso-8859-1?Q?NH3FOUIoJ+t+Q+JOn6O8L/2kvg9rTZiLx/cEIrgqwyKv5ly+QgYruGdW2w?=
 =?iso-8859-1?Q?LunROObT82pjpRCRTbUF+t7g0thExcqoDIn4aXEK6P0YBjUYfqG6odedKl?=
 =?iso-8859-1?Q?HUUsmJ3KvcuZOOzmq71XCNPKnleMOTvQd7Cqx8ynAsEinLDjde3c8tf7A0?=
 =?iso-8859-1?Q?givgfDY1XLOdj1lifvyRWA6i6uQnbDzzt2rOvRfOUh6NmTrZS+7u1lJZdu?=
 =?iso-8859-1?Q?vc6LrRb7OvXUEnb8oti/FFlxYBVEQaKhRokqrPzXjvug=3D=3D?=
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:BYAPR02MB5029.namprd02.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(1800799024)(366016)(376014)(8096899003)(38070700018)(7053199007);
 DIR:OUT; SFP:1102; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?iso-8859-1?Q?FLps4LuOI1tz3bfSIo0QHSOx5lYQLG1E8v2jQ80WJN3BO8LLV4LV1B/o3i?=
 =?iso-8859-1?Q?wiTb5dT+fG+bilmlc4on6LijVukLKTXTODA+CbrkJg0N7iMzROyUiUsZBI?=
 =?iso-8859-1?Q?co6lFs/xLN+BqGzVOYfIA7UND4ONdT4p2HDFDcbEV6Cfr4G0g1kGtGTIEW?=
 =?iso-8859-1?Q?I7cpuFndVXn9hnd0eQ6DUvNCnQmD6F6DS+SmgmOBEQKaQwC3T4LOk6V/V3?=
 =?iso-8859-1?Q?8a44+joPcJa0XdUuH5vsaDoTXPMsA2L6Q3UWfsMGMCtOWXxFiIxVYfuCCh?=
 =?iso-8859-1?Q?evJE5SgbF7n5NtszC6h+0TnTVlxU+aKpywdg+/UJfuhuJ9gc2/x6VbwVe3?=
 =?iso-8859-1?Q?EUVBOkwQ8FZM6Ggp9TIxibGViYV79koalrsFGKUseFtWWJJFmy/dtuUZRS?=
 =?iso-8859-1?Q?MzSzloeikRwaNDwyeh8Ktwyqp/uZINx9y5OcefAP7L9r0yUDNAImgZhmvI?=
 =?iso-8859-1?Q?O6l6VMCDSdA2u/xq8dnQ2/o4AGiwEiL1sK/ReBY6pmyHfSKBpQSlerytyl?=
 =?iso-8859-1?Q?CPbOVCtr6tkFBCfapU8WAMq5zZSlkl8SMQLh+A/OQ2ebnJSAwQK4qAlw4t?=
 =?iso-8859-1?Q?0naStEVdG/QIEE+u1d4a5JJgnYonVogYVXQiboXMoqEzNu4b12Cx23pnnx?=
 =?iso-8859-1?Q?56yBIb4bkqk9jFWwdzpfa2kbxo8cm8EBqhfyvQm8MQ5XiG68M0zjJ8CC4B?=
 =?iso-8859-1?Q?RqhrTrG1cO2nvmwvMBXB3ZokEWLWgyl5OsZdp3itf2W/S6JdSFIxWx3GdP?=
 =?iso-8859-1?Q?4eAxNvKz89vudqhaNGPJmTGrjMNpL+24WxyMIBuMTGRImMdumtKZg4JGkn?=
 =?iso-8859-1?Q?JYSATUu0Z+71iRVMAWepKNsL7rQ6YgsLGu57tWIZkTkMAfvQpqpTlk/vgo?=
 =?iso-8859-1?Q?qD+TI1SLULe2LmBHtqgy8wVgZnfT2vLl9rWM0DuQpWhDlhe6O0rUy0zsUL?=
 =?iso-8859-1?Q?HZ064Y4nNXKUlAzFc3E/6BMLNZCm82zpCHHxwfk9WJyW8DIC4pVXRX/A0N?=
 =?iso-8859-1?Q?n5taAva35E27cHvJ9EN7cD0GeTaL7gq7HHABAk6QwahzExY/3lFOB8S2EC?=
 =?iso-8859-1?Q?UVSIh2lxkHu6r+eEFiXNciZU8h40pxR4lNEn8W7ruqWg3gTIztgcFGcu4S?=
 =?iso-8859-1?Q?XIP9bR+DnOfTWNUsjNLdWwjGewV0iCTj01uVVQowYm6Hvr7RF1+GiSzQ16?=
 =?iso-8859-1?Q?nF2D8Byq8kR3EXAtiJ2YyFwDuidkBdPdaOEyOVKH9D3RCfc5bOkwi+WOl3?=
 =?iso-8859-1?Q?ZY5mz+jnibLH3OW2Dm5BTPCD3pkcT04rb5C6Vl9tTNubs3VSNROX5vOyEc?=
 =?iso-8859-1?Q?6l47zAXgOIYenTyj9anj4mbQEUDMd0UvPDbr09SSvwcDiS/FR+8fjTybML?=
 =?iso-8859-1?Q?021tfPmgDmxUzeczkrMXf63aQZ+NNRkDASemmAwnUcC23+42BDc18i7IsQ?=
 =?iso-8859-1?Q?UFW8KBOIP4OpLmtvbTacAksFG+X/Bz+iD6TybW+0UaXw9DG/Ruh5ICvJVK?=
 =?iso-8859-1?Q?fceVe+9lXlfHm4TP81FgcYh3YRwsPGZG1W68+Gl0OuP6SyPgd9XoyGbx1l?=
 =?iso-8859-1?Q?9ZlpC+8qSkBHnYpVOTzTHLt2sC2Bf2SlbpiLFlqtPpOAdu10uYVdSR6Fv8?=
 =?iso-8859-1?Q?bndKCXtsD5z9a5tKesxKSWVuXf/wqnZMEu?=
Content-Type: multipart/alternative;
 boundary="_000_BYAPR02MB5029F83A450ED347FF69345F8520ABYAPR02MB5029namp_"
MIME-Version: 1.0
X-OriginatorOrg: nutanix.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: BYAPR02MB5029.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: b82afcc2-e70d-4fcc-32cb-08ddd27f1702
X-MS-Exchange-CrossTenant-originalarrivaltime: 03 Aug 2025 11:15:44.4559 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: bb047546-786f-4de1-bd75-24e5b6f79043
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: vYUSZDn74/YemYsbDgoA2ZJEkZjj3zkkKZxwZmtIsgoINKihx1yBHjVRj9FApHVmk/Wq7s4WYr9dUSVGpT8anfklqLJefx+7qRqgOROFagU=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH0PR02MB7256
X-Proofpoint-ORIG-GUID: 9SHlgj2LnMGPhpEVxxtWaFOrYdWa2Wek
X-Authority-Analysis: v=2.4 cv=VOXdn8PX c=1 sm=1 tr=0 ts=688f44e7 cx=c_pps
 a=MJlwP/pY7jdh0k4YB6prAg==:117 a=z/mQ4Ysz8XfWz/Q5cLBRGdckG28=:19
 a=lCpzRmAYbLLaTzLvsPZ7Mbvzbb8=:19 a=wKuvFiaSGQ0qltdbU6+NXLB8nM8=:19
 a=Ol13hO9ccFRV9qXi2t6ftBPywas=:19
 a=xqWC_Br6kY4A:10 a=2OwXVqhp2XgA:10 a=0kUYKlekyDsA:10 a=64Cc0HZtAAAA:8
 a=N54-gffFAAAA:8 a=69wJf7TsAAAA:8 a=beMNLQdf_eq_z5rbWAsA:9 a=wPNLvfGTeEIA:10
 a=S2XLYNWnPrdKhaop4k4A:9 a=tUqKKieQZtDrWsLP:21 a=frz4AuCg-hUA:10
 a=_W_S_7VecoQA:10
 a=zY0JdQc1-4EAyPf5TuXT:22 a=Fg1AiH1G6rFz08G2ETeA:22
X-Proofpoint-GUID: 9SHlgj2LnMGPhpEVxxtWaFOrYdWa2Wek
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwODAyMDA2NiBTYWx0ZWRfX4t1rxK2Btg8U
 hWhHTP9wkWPH/bMI8FO8K+gy44MFO761sOJOG2xd72Ez8qMaw5dMjiZkBOJLT90LESsAImP6doh
 YgBxa041Sl2tvBsycPLOppqcaCLfxmfkFeOdxSu01tvURsIMup5qvLwg1cLpeHkIfeiEbKwojB9
 iFWaeJbjmBpVU5BHtv4y5zP66vrbQYj4UaHMoZNAgZirifIbZXq8HOGQ2W7BIT6C7CxqTXtsAf6
 BksucJgY0REXb9f/uVWxJgjPPiFA+jXYlNr3OnnPHEJizHom2HQaMFkVkzlSH+IVKlN1KdZum7t
 kJJghz4/HM/oStqY92Lj6d9L7Tqz4E/2/zXmTZwreVsqAF08SxzQAVAQce2vpSVsVAazWz2MYNU
 0/VPO+BZ
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1099,Hydra:6.1.9,FMLib:17.12.80.40
 definitions=2025-08-03_03,2025-08-01_01,2025-03-28_01
X-Proofpoint-Spam-Reason: safe
Received-SPF: pass client-ip=148.163.151.68;
 envelope-from=yunpeng.yang@nutanix.com; helo=mx0a-002c1b01.pphosted.com
X-Spam_score_int: -27
X-Spam_score: -2.8
X-Spam_bar: --
X-Spam_report: (-2.8 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 HTML_MESSAGE=0.001, RCVD_IN_DNSWL_LOW=-0.7, RCVD_IN_MSPIKE_H2=-0.01,
 RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001, RCVD_IN_VALIDITY_SAFE_BLOCKED=0.001,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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

--_000_BYAPR02MB5029F83A450ED347FF69345F8520ABYAPR02MB5029namp_
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable

Hello Corey Minyard,

I hope you are all well.

Could I ask for your opinion on whether it is worthing implementing a fake =
LAN config for device ipmi-bmc-sim ? (Details are in my last email, which i=
s also included below).

During my work over last month, I found that QEMU already has ipmi-bmc-exte=
rn which supports comprehensive BMC simulation, including LAN config faking=
. But ipmi-bmc-sim is more light-weight and easier to set up. So I think it=
 still has some value in implementing LAN config for ipmi-bmc-sim . Could y=
ou please share your views?

Best regards,
Yunpeng Yang


________________________________
From: Yunpeng Yang <yunpeng.yang@nutanix.com>
Sent: Friday, June 27, 2025 18:13
To: minyard@acm.org <minyard@acm.org>
Cc: qemu-devel@nongnu.org <qemu-devel@nongnu.org>; Mark Cave-Ayland <mark.c=
aveayland@nutanix.com>; Jonathan Davies <jond@nutanix.com>
Subject: Add support for retrieving fake LAN config from `ipmi-bmc-sim` dev=
ice

Hello Corey Minyard,

I hope this email finds you well.

I'm currently adding LAN-configs-retrieval support to the QEMU ipmi-bmc-sim=
 device. And I hope to merge the modifications upstream after it's finished=
. Could you please check the attached patch file of the draft code and shar=
e your opinions and advice?

In my work, we need to run tools like "ipmitool lan print" on a VM for test=
ing purposes. However, QEMU internal BMC simulator device (`ipmi-bmc-sim`) =
does not support retrieving LAN configs from it. I have to implement two IP=
MI commands so that the device can now work with ipmitool. The LAN config v=
alues are faked, but for testing purposes this is not a problem. I believe =
other people may also have the same need, so it's worth getting merged upst=
ream.

The fake BMC LAN config values are currently hard coded into the code. My p=
lan is to add a parameter to the device, which is a file containing user de=
signated values. The device then reads the file and returns those values as=
 LAN configs. This is similar to sdrfile for sensor data and frudatafile fo=
r FRU data.

Looking forward to hearing your thoughts.
Have a nice weekend.

Kind regards,
Yunpeng Yang

--_000_BYAPR02MB5029F83A450ED347FF69345F8520ABYAPR02MB5029namp_
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
<div style=3D"font-family: Aptos, Aptos_EmbeddedFont, Aptos_MSFontService, =
Calibri, Helvetica, sans-serif; font-size: 11pt; color: rgb(0, 0, 0);" clas=
s=3D"elementToProof">
Hello Corey Minyard,</div>
<div style=3D"font-family: Aptos, Aptos_EmbeddedFont, Aptos_MSFontService, =
Calibri, Helvetica, sans-serif; font-size: 11pt; color: rgb(0, 0, 0);" clas=
s=3D"elementToProof">
<br>
</div>
<div style=3D"font-family: Aptos, Aptos_EmbeddedFont, Aptos_MSFontService, =
Calibri, Helvetica, sans-serif; font-size: 11pt; color: rgb(0, 0, 0);" clas=
s=3D"elementToProof">
I hope you are all well.</div>
<div style=3D"font-family: Aptos, Aptos_EmbeddedFont, Aptos_MSFontService, =
Calibri, Helvetica, sans-serif; font-size: 11pt; color: rgb(0, 0, 0);" clas=
s=3D"elementToProof">
<br>
</div>
<div style=3D"font-family: Aptos, Aptos_EmbeddedFont, Aptos_MSFontService, =
Calibri, Helvetica, sans-serif; font-size: 11pt; color: rgb(0, 0, 0);" clas=
s=3D"elementToProof">
Could I ask for your opinion on whether it is worthing implementing a fake =
LAN config for device
<code>ipmi-bmc-sim</code>&nbsp;? (Details are in my last email, which is al=
so included below).</div>
<div style=3D"font-family: Aptos, Aptos_EmbeddedFont, Aptos_MSFontService, =
Calibri, Helvetica, sans-serif; font-size: 11pt; color: rgb(0, 0, 0);" clas=
s=3D"elementToProof">
<br>
</div>
<div style=3D"font-family: Aptos, Aptos_EmbeddedFont, Aptos_MSFontService, =
Calibri, Helvetica, sans-serif; font-size: 11pt; color: rgb(0, 0, 0);" clas=
s=3D"elementToProof">
During my work over last month, I found that QEMU already has <code>ipmi-bm=
c-extern</code>&nbsp;which supports comprehensive BMC simulation, including=
 LAN config&nbsp;faking. But
<code>ipmi-bmc-sim</code>&nbsp;is more light-weight and easier to set up. S=
o I think it still has some value in implementing LAN config for
<code>ipmi-bmc-sim</code>&nbsp;. Could you please share your views?</div>
<div style=3D"font-family: Aptos, Aptos_EmbeddedFont, Aptos_MSFontService, =
Calibri, Helvetica, sans-serif; font-size: 11pt; color: rgb(0, 0, 0);" clas=
s=3D"elementToProof">
<br>
</div>
<div style=3D"font-family: Aptos, Aptos_EmbeddedFont, Aptos_MSFontService, =
Calibri, Helvetica, sans-serif; font-size: 11pt; color: rgb(0, 0, 0);" clas=
s=3D"elementToProof">
Best regards,</div>
<div style=3D"font-family: Aptos, Aptos_EmbeddedFont, Aptos_MSFontService, =
Calibri, Helvetica, sans-serif; font-size: 11pt; color: rgb(0, 0, 0);" clas=
s=3D"elementToProof">
Yunpeng Yang</div>
<div id=3D"appendonsend"></div>
<div class=3D"elementToProof"><br>
</div>
<div style=3D"font-family: Calibri, Arial, Helvetica, sans-serif; font-size=
: 12pt; color: rgb(0, 0, 0);">
<br>
</div>
<hr style=3D"display: inline-block; width: 98%;">
<div style=3D"font-family: Calibri, Arial, Helvetica, sans-serif; font-size=
: 12pt; color: rgb(0, 0, 0);">
<b>From:</b>&nbsp;Yunpeng Yang &lt;yunpeng.yang@nutanix.com&gt;<br>
<b>Sent:</b>&nbsp;Friday, June 27, 2025 18:13<br>
<b>To:</b>&nbsp;minyard@acm.org &lt;minyard@acm.org&gt;<br>
<b>Cc:</b>&nbsp;qemu-devel@nongnu.org &lt;qemu-devel@nongnu.org&gt;; Mark C=
ave-Ayland &lt;mark.caveayland@nutanix.com&gt;; Jonathan Davies &lt;jond@nu=
tanix.com&gt;<br>
<b>Subject:</b>&nbsp;Add support for retrieving fake LAN config from `ipmi-=
bmc-sim` device
</div>
<div style=3D"font-family: Calibri, Arial, Helvetica, sans-serif; font-size=
: 12pt; color: rgb(0, 0, 0);">
<br>
</div>
<div style=3D"direction: ltr; font-family: Aptos, Aptos_EmbeddedFont, Aptos=
_MSFontService, Calibri, Helvetica, sans-serif; font-size: 11pt; color: rgb=
(0, 0, 0);">
Hello Corey Minyard,</div>
<div style=3D"direction: ltr; font-family: Aptos, Aptos_EmbeddedFont, Aptos=
_MSFontService, Calibri, Helvetica, sans-serif; font-size: 11pt; color: rgb=
(0, 0, 0);">
<br>
</div>
<div style=3D"direction: ltr; font-family: Aptos, Aptos_EmbeddedFont, Aptos=
_MSFontService, Calibri, Helvetica, sans-serif; font-size: 11pt; color: rgb=
(0, 0, 0);">
I hope this email&nbsp;finds you well.</div>
<div style=3D"direction: ltr; font-family: Aptos, Aptos_EmbeddedFont, Aptos=
_MSFontService, Calibri, Helvetica, sans-serif; font-size: 11pt; color: rgb=
(0, 0, 0);">
<br>
</div>
<div style=3D"direction: ltr; font-family: Aptos, Aptos_EmbeddedFont, Aptos=
_MSFontService, Calibri, Helvetica, sans-serif; font-size: 11pt; color: rgb=
(0, 0, 0);">
I'm currently adding LAN-configs-retrieval support&nbsp;to the QEMU <code>i=
pmi-bmc-sim</code>&nbsp;device. And I hope to merge the modifications upstr=
eam after it's finished. Could you please check the attached patch file of =
the draft code and share your opinions and
 advice?</div>
<div style=3D"direction: ltr; font-family: Aptos, Aptos_EmbeddedFont, Aptos=
_MSFontService, Calibri, Helvetica, sans-serif; font-size: 11pt; color: rgb=
(0, 0, 0);">
<br>
</div>
<div style=3D"direction: ltr; font-family: Aptos, Aptos_EmbeddedFont, Aptos=
_MSFontService, Calibri, Helvetica, sans-serif; font-size: 11pt; color: rgb=
(0, 0, 0);">
In my work, we need to run tools like &quot;ipmitool lan print&quot; on a V=
M for testing purposes. However, QEMU internal BMC simulator device (`ipmi-=
bmc-sim`) does not support retrieving LAN configs from it. I have to implem=
ent two IPMI commands so that the device can
 now work with <code>ipmitool</code>. The LAN config values are faked, but =
for testing purposes this is not a problem. I believe other people may also=
 have the same need, so it's worth getting merged upstream.</div>
<div style=3D"direction: ltr; font-family: Aptos, Aptos_EmbeddedFont, Aptos=
_MSFontService, Calibri, Helvetica, sans-serif; font-size: 11pt; color: rgb=
(0, 0, 0);">
<br>
</div>
<div style=3D"direction: ltr; font-family: Aptos, Aptos_EmbeddedFont, Aptos=
_MSFontService, Calibri, Helvetica, sans-serif; color: rgb(0, 0, 0);">
<span style=3D"font-size: 11pt;">The fake BMC LAN config values are current=
ly hard coded into the code. My plan is to add a parameter to the device, w=
hich is a file containing user designated values. The device then reads the=
 file and returns those values as
 LAN configs. This is similar to <code>sdrfile</code>&nbsp;for sensor data =
and <code>frudatafile</code></span><span style=3D"font-size: 14.6667px; bac=
kground-color: rgb(255, 255, 255);">&nbsp;for FRU data.</span></div>
<div style=3D"direction: ltr; font-family: Aptos, Aptos_EmbeddedFont, Aptos=
_MSFontService, Calibri, Helvetica, sans-serif; font-size: 14.6667px; color=
: rgb(0, 0, 0);">
<span style=3D"background-color: rgb(255, 255, 255);"><br>
</span></div>
<div style=3D"direction: ltr; font-family: Aptos, Aptos_EmbeddedFont, Aptos=
_MSFontService, Calibri, Helvetica, sans-serif; font-size: 14.6667px; color=
: rgb(0, 0, 0);">
<span style=3D"background-color: rgb(255, 255, 255);">Looking forward to he=
aring your thoughts.</span></div>
<div style=3D"direction: ltr; font-family: Aptos, Aptos_EmbeddedFont, Aptos=
_MSFontService, Calibri, Helvetica, sans-serif; font-size: 14.6667px; color=
: rgb(0, 0, 0);">
<span style=3D"background-color: rgb(255, 255, 255);">Have a nice weekend.<=
/span></div>
<div style=3D"direction: ltr; font-family: Aptos, Aptos_EmbeddedFont, Aptos=
_MSFontService, Calibri, Helvetica, sans-serif; font-size: 14.6667px; color=
: rgb(0, 0, 0);">
<span style=3D"background-color: rgb(255, 255, 255);"><br>
</span></div>
<div style=3D"direction: ltr; font-family: Aptos, Aptos_EmbeddedFont, Aptos=
_MSFontService, Calibri, Helvetica, sans-serif; font-size: 14.6667px; color=
: rgb(0, 0, 0);">
<span style=3D"background-color: rgb(255, 255, 255);">Kind regards,</span><=
/div>
<div style=3D"direction: ltr; font-family: Aptos, Aptos_EmbeddedFont, Aptos=
_MSFontService, Calibri, Helvetica, sans-serif; font-size: 14.6667px; color=
: rgb(0, 0, 0);">
<span style=3D"background-color: rgb(255, 255, 255);">Yunpeng Yang</span></=
div>
</body>
</html>

--_000_BYAPR02MB5029F83A450ED347FF69345F8520ABYAPR02MB5029namp_--

