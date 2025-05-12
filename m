Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4FC9CC3ABBC
	for <qemu-devel@archiver.kernel.org>; Mon, 12 May 2025 05:58:38 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uEMBB-00076u-63; Mon, 12 May 2025 01:58:24 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <Rajasekar.P@netapp.com>)
 id 1uELKb-0007fk-W5
 for qemu-devel@nongnu.org; Mon, 12 May 2025 01:04:02 -0400
Received: from mx0a-003fbd02.pphosted.com ([67.231.149.249])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <Rajasekar.P@netapp.com>)
 id 1uELKY-0000sk-5k
 for qemu-devel@nongnu.org; Mon, 12 May 2025 01:04:01 -0400
Received: from pps.filterd (m0412379.ppops.net [127.0.0.1])
 by mx0a-003fbd02.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 54C3f7io007720
 for <qemu-devel@nongnu.org>; Mon, 12 May 2025 05:03:54 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=netapp.com; h=cc
 :content-type:date:from:message-id:mime-version:subject:to; s=
 pps1; bh=S9OGs8ei3jkZFadEYXNOn52WoXAWbnjSpeZcUop3jVQ=; b=i9LF5Li
 uuu5r/l2DE4nYv/lwjjGXJLprDU8uJoFBAsyjJSRSIuIjGnd3pG+X+m6AOIKtpRp
 SL0qia3VgVv63+L8rkHxF7sISdFi279FCs21b6/FlG08OE0HxymPcO1yGCBO1sFD
 u3gKIxLLq9ItSGWfKTut5tQatCrNOclABhe1tnugYxRAQ6TDOMnF2iriA+yBEo2N
 Ldhqs4B7vowZzzDjGRRI0UfEdTpQIbt2sZIwJEg7UB8vA6EWNluteDyn2ZkI1Bqy
 K65aTPmXNgiL9rBSym024aP7NxKeas3bIPIxpbZ0rtmDvXnDMWLb8CmiA3nPxCQx
 /mznecyJrBue+fQ==
Received: from ch5pr02cu005.outbound.protection.outlook.com
 (mail-northcentralusazlp17012053.outbound.protection.outlook.com
 [40.93.20.53])
 by mx0a-003fbd02.pphosted.com (PPS) with ESMTPS id 46k99ug5rm-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT)
 for <qemu-devel@nongnu.org>; Mon, 12 May 2025 05:03:54 +0000 (GMT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=vOVyCuW1liIY0kAyt7x9eS1vwT7j9Af+QoPsD2B4sRUmqJK9oXhRW8YfJLUH0QLeoHrl0anGjtNlZTxeCh0W1NB69CAPOpi9fM59lzIbuCzpdgMnmfGVEH7u5mmquOs//gFPF3g5QRZTQvUvKTaBSeqe+7rir75GiFej2AEoaGqoTlqWbaSnTMCSqQqSMUXKWIgfNrk16eV7QIC+D63yYBhQE8Pz19n5nY/WgF3zXXZGN7cOoeJ1vudNYmIUaEem1FkN+Yz0wLW7I9It8MDVPMgsN3IRjckp7ZOtyzXr2oZI9fUx3rRkmUMqMa2JZ6W2FNsEFt6ySQODNArMd23+YQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=S9OGs8ei3jkZFadEYXNOn52WoXAWbnjSpeZcUop3jVQ=;
 b=c2y8yB0TVdRJrUJWdomdOlrhS7C9ymSuZTymQgb7pMMMdQGVvgfbF1TKA8UEdsYSnj9FBojfZAEiPW7R+pFJv924UdeqQ1MQc/pJ5ZbdMME3SwKKS5Ap/iGQxbh2V+t7RmnD0jVa94oogLGJKhwNkAsBuO/4yE/ONJ0uBHAYtFDZ8Cj4+LvCEVXyEOqpqfohWnGS9AYWPJlIQunNOFiRTXpO/UrcVb8vQbCwKrA9jqTR2IS7zCOeyPVzDSWM4q9eEWynthIbTIaZ5UZE20U2CQGEhweAmnxpKbSauirFwYpdr6Lkvcx9zuNKXNzl4qEJ0l2FBiCuiWz0YGrlVmyxJg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=netapp.com; dmarc=pass action=none header.from=netapp.com;
 dkim=pass header.d=netapp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=netapp.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=S9OGs8ei3jkZFadEYXNOn52WoXAWbnjSpeZcUop3jVQ=;
 b=vdiPKQF7Jl5ha8GaE9PlYKxDMWXOc5aohpR22U5rWsjv/4GBom16mYj7CjvtgixkQQOKhhJgGupmNQ47EmFCrw6qdBWxfe7OzGWAab+851nS3XaeZhbtgW+HPNTn2Xyblpv82QeJexY1J/n5LwMOr2Z+sxGkjPKD0hbcfUuaZ4K2Wfi+buaVtD4cSoC23yv/DKn1IrjUHy69nwKJ0XsnDcNXW8JaAmZ2QS5jxOu8Lmu0IpKj+MgmpErUfvHtZ0j4dJuC+qYKMZObXKEaQCwLUO8QJvZZ6gMVSJKVWDZPMeAjFC6T3P7jsut/Zy+tFkk71ObnXQvmOZ+Z2EU51If75A==
Received: from DS0PR06MB9231.namprd06.prod.outlook.com (2603:10b6:8:129::17)
 by SA2PR06MB7340.namprd06.prod.outlook.com (2603:10b6:806:14d::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8722.28; Mon, 12 May
 2025 05:03:51 +0000
Received: from DS0PR06MB9231.namprd06.prod.outlook.com
 ([fe80::2f5c:9cd3:216d:ab71]) by DS0PR06MB9231.namprd06.prod.outlook.com
 ([fe80::2f5c:9cd3:216d:ab71%5]) with mapi id 15.20.8722.027; Mon, 12 May 2025
 05:03:51 +0000
From: "P, Rajasekar" <Rajasekar.P@netapp.com>
To: "qemu-devel@nongnu.org" <qemu-devel@nongnu.org>
CC: "Bethur, Mohan" <Mohan.Bethur@netapp.com>, "Prabhu, Vasantha"
 <Vasantha.Prabhu@netapp.com>, "Kaplingat, Nikhil"
 <Nikhil.Kaplingat@netapp.com>, "Karinta, Vineeth"
 <Vineeth.Karinta@netapp.com>
Subject: Query Regarding VM Consistent Snapshot Approaches and Impact of QEMU
 Guest Agent Freeze
Thread-Topic: Query Regarding VM Consistent Snapshot Approaches and Impact of
 QEMU Guest Agent Freeze
Thread-Index: AdvC+nSpreafgdNgQJSVemOIVfAz3w==
Date: Mon, 12 May 2025 05:03:51 +0000
Message-ID: <DS0PR06MB9231E15CAD02D2566513ECAA8397A@DS0PR06MB9231.namprd06.prod.outlook.com>
Accept-Language: en-GB, en-IN, en-US
Content-Language: en-GB
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
dlp-product: dlpe-windows
dlp-version: 11.10.300.143
dlp-reaction: no-action
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: DS0PR06MB9231:EE_|SA2PR06MB7340:EE_
x-ms-office365-filtering-correlation-id: 9fe4b8c0-8b9c-49e7-3ca8-08dd91126318
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
 ARA:13230040|376014|366016|1800799024|8096899003|38070700018; 
x-microsoft-antispam-message-info: =?us-ascii?Q?3vc/cEDde9swklEYSkiP+VBKThiltdx3UfUwIazvaK7VlZogYGsBX2BEjaVo?=
 =?us-ascii?Q?myV1D/v7/PU+hrKFK/uAPupDrON+slnXSXQd6mjmAldEaEpvbVQM3l77ZlBe?=
 =?us-ascii?Q?EwEZegDM7Uj0kgq1fbtbyivzRLXkhqo+vi6zeCbAHCbd30cQWmKQ4PIvYYQw?=
 =?us-ascii?Q?tC6NbNEcoPVRuOubdXZ8vLl7KpoU9JnJLmQBU1V3/nErkNa/PG9z56agGNSD?=
 =?us-ascii?Q?0Y8HX5VBmOFvZcn8R9D9uUEMH+sFqgJ6usbWOFBUA0FlZzCiEp+z/u/rEAG6?=
 =?us-ascii?Q?KaSPd0efkz33/oVavpAx3URxvV7T1ioSQvJ9CUKcFKGnUIEokeyyiegyo3FH?=
 =?us-ascii?Q?17ncqzdKle3aAswOjQHBl5tA7FEzl5JK0IfRDOok6pbuMKtqcr4nyIj2vec0?=
 =?us-ascii?Q?8R5V80Fw9uWCFuP4HBMzxuGzEGdLrQ77BmNK+NyBVkEpIzlUb+/FL6glN4Na?=
 =?us-ascii?Q?QmwAqAF5NwX3VdiP2s1Y4gQmrxyFiWyI67ASW3Vql5Qz0uomcJNl8tjAj4hj?=
 =?us-ascii?Q?8K20zC0jM6A0qGJGKx+pI3B9FuSjJK1v4+M0wTEK/MJ+LUp9KJXEajUYhGe4?=
 =?us-ascii?Q?S/5MGrAXagDfFKbiVTmrqeB0wVRbn2Lngty3NiL9kPYzAVBiw6cBYXnNYxMU?=
 =?us-ascii?Q?pkVGz8G2Snq/sT28meiEKAzmWSN3oOIIV3WGizefsbJgd+wVcM9VRszMTP5w?=
 =?us-ascii?Q?euCmFv29VqsYp4OEhNpNmectDzaqtmFlh32rRCmPSA0bWGWrzgZlM+jblv97?=
 =?us-ascii?Q?EKruD7n4naWqW8lujihR3A1zlhkGfO2WkbgojD9Tx24gxM5nWbJ1dfP0Kzx/?=
 =?us-ascii?Q?BWTBfkTHNJxri3rBRtzbjU8cGwDIPYpsNYG54EqgFp6nk6XbppcmSisYIqZb?=
 =?us-ascii?Q?DfXEGBblIYi99PiJV9XV8tvJmDCQJ0tTztV4yN/4nbeuLGJ/gU+WxOsDCfh9?=
 =?us-ascii?Q?KbxQ72fH0ZY6LQEQ6NDZ7u3roOy5LOk04dr4a2ZNQ+ifNGnZs8Gkm5sOkwbF?=
 =?us-ascii?Q?tl5hWxGrKjD6DF5OUFY+XtTBqUhZWPX/E9NAbzPIDFnf1y+Bhp3YwRVgV6uq?=
 =?us-ascii?Q?yWkIS+syhuMuaHo4QoaQ9hkGKQO8pCNokfCUnFbVNvW8QGQ+chRQv0GVSVrG?=
 =?us-ascii?Q?q5m/vrwka0mVa9amXoWf4TAbszElwQZAqpgizESkLmYujBSFfhVJCV1VX+9r?=
 =?us-ascii?Q?3Z6UiMA93AKFp4NF/i7vDf3d6fhk2BfMVzXvMBYpSVKGm1oLuNQCzcxA5f8W?=
 =?us-ascii?Q?7B38UKmztBv0yAB2yzOfvqgHbIzfnNxXfjokyv/CcP/2EAmW5WpeGq+Tupam?=
 =?us-ascii?Q?tvinz3gB1YUOz0+/48c1FQqX2Ugm75cIMXCmqEF37Ssn7enrBYT4Tht6fyrO?=
 =?us-ascii?Q?z6GRbnT6/yA8ct2sfQ1SH5GFW/0fnfNi8xRiAPFVWuAQXnTyhfxWt6TmCZKX?=
 =?us-ascii?Q?CgZ0VkzJOrwQXy6k8KqsQ4VuzLyM+cli7bvjBYb3NZ1EF3MN2QK/vRzBUiIz?=
 =?us-ascii?Q?v5RsnNGXl5UG92Y=3D?=
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DS0PR06MB9231.namprd06.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(376014)(366016)(1800799024)(8096899003)(38070700018); DIR:OUT;
 SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?nb1rUE0CDkY9gM9WAxbniZyILT8fAn9568gDoIb//4phHuKlzbQQXPay/g0u?=
 =?us-ascii?Q?o68O0hmb26Qj3CmNsZQ7clBMfJmx4fzyST+D4g3nrgvHfhFNFqLAqvMNMClQ?=
 =?us-ascii?Q?ks28cFp97Yi8xJwaNtxn/C2csVPbK6qt1455nnZt4K0OVEG1j6dZrPKLnQgX?=
 =?us-ascii?Q?9+ZQZHBTivqxoGosgrPrsnZGVe0n0mWGCazcRY8gpaZFqypmwS4mSRgg3kiy?=
 =?us-ascii?Q?OivoZQM+/dqQAUeI1n/WjaE/u09pSM7GpN44TsMaNik9AeSERRzH1U13gax2?=
 =?us-ascii?Q?NRPWSK14GxKbHzvdTwUcafwTu90kGul7x5snAwgQUxrH6Fo4MxJgiwgYzF+K?=
 =?us-ascii?Q?SxyArGsYgH4/fVKtALsKm7KhpvJFCmz/xelHUou4gNK5AggJVn9ImBFPi9eQ?=
 =?us-ascii?Q?9x8l/t6KIpZNE/SUmYdJMERnhdE7L22KvpUDUyh4ACiXpI3Pmvmq7toK9Y7Z?=
 =?us-ascii?Q?EJM9TSyBIgIBAd08q+YKIkikHVvCnD6GHEEx5LNqZLKAC1wzI8H6JUCRR6Yp?=
 =?us-ascii?Q?N2VwY1HH6trVclD5thAfrplAYggmUHzPfAusi1QjI1FPjMdYmdXG5izWPS8v?=
 =?us-ascii?Q?Wb1JK4tDehHSCfhcRgeOr3/z2Gt9kuZIoc160mT7pCsD5Yqq6h6UHgEQASec?=
 =?us-ascii?Q?BQrFe6Y8XPlxgQs+B+cRzZhpeOBxj0xVfmGy83qcUv+9R9D9E5Kwy5N4wgAQ?=
 =?us-ascii?Q?QFoIfJOOI1bz/GTLmg7px34BsYnEsD2zma5JKOiSqCqwrWUGWSZ75itAMxZT?=
 =?us-ascii?Q?5KWm199FsvaFeoqD3TKxcOCsAkSX6gL6IcAX0gfXK181RMUw+m24LkgQmSKf?=
 =?us-ascii?Q?9fJGAaEBj0vqEoadMP3eOuzX9D7WE9x4jBmvC80YwcRrlI/jJdZzMt/QbGyZ?=
 =?us-ascii?Q?wj8ZdsXosn7G5tB6Nlx7rQLlz5WJ+TThl/MOD1FnCFMaDEItF7t7ZJ5+fSXP?=
 =?us-ascii?Q?vqKVxJyF9WbZLFuWfodFe4G1PXwTsCerbkb02okzkOfOTIQnhBeyaWuSQNqf?=
 =?us-ascii?Q?ZyMogR0Aq+h4aVxpNPnGXtz0eCqHKR4s50JQTEU70KRyfPE2r4rKsrNIy7cz?=
 =?us-ascii?Q?PM2GQpJ08h+pprUbCvHYBcsZiogKNrf5TLGzTmLNiz+sdsWRAOTHQl+f4FyN?=
 =?us-ascii?Q?kZb/nDLBaIKDKfyypR3kmzo9RvmvwlCBHpfkASr3V+QC0t0pFhLwVwZ2LSIr?=
 =?us-ascii?Q?uhpG7YkcKA+J5hNUAhzN16y3Hx3tPgIhpF/uu8jS4HC+fyr2i3jlCbALU+uD?=
 =?us-ascii?Q?EjjGINZjph4UPKnpxfm7LyNZDGIuNNuAS+rKK2tzYMilFp2MN2S8UL7+lFN0?=
 =?us-ascii?Q?tniNczRw1Dzy4c6i3QY1v+tepxUdR9DQmy5xZni5tz9W3EHcn3cCovM2KZVn?=
 =?us-ascii?Q?7CHBT56MrkiQYQWQEminS/iqv5W+TpGTdHliA4B2Jzhyw6LnwfYKDIb5rAqA?=
 =?us-ascii?Q?FCuGIsiQix1zpFbAaRmVEhxYdxS+Pz4Xw19QSZj/RuIM4PU+XfjSI53gSgtp?=
 =?us-ascii?Q?WLAoGGIlXmRuQPOFtUCOxwIQFMjxPmaZq9HcuBAyAk2nscK+NArAEx8ik3OV?=
 =?us-ascii?Q?jCZcNdJctaXLuBNBwb8=3D?=
Content-Type: multipart/alternative;
 boundary="_000_DS0PR06MB9231E15CAD02D2566513ECAA8397ADS0PR06MB9231namp_"
MIME-Version: 1.0
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: iMVGEpHgUC5713Vw/UFgPThcGTlZaOVMjdIAx/leZlCGyuCFbbTLemBXgvwcv3qubGVTKuyhmh0HodKZIaVI3YGHv9U0K5y5srkgnE+uz4NARHYrmZeigJhDMbhFHlKbtSYNgw5kkYicpZYx0DZXeYCFZPLNDa0f3SnMz1X7r9wGcN/IXjHdG5l+FZIfVRM8uMW/8o+L80ZjkQJ6cvui9RoiNOloMy/9KalL5svxWEVfdfJc3TbEwIdQt2ROqg9WMr5twjSDyquEPLp5wg/bWN/qrigObDJ9fbNPTM7x5sVxUUQ1JrbYxSBqA4Vyf1pdwTwsbtqGZmvSnJfyrrhWEX8JaQ/3FQlzY0xwJyyNVNKY6Kfi+dWHQ4ltFh2NIKIk7eytLqj2mFuE93LbkHjpyFtF1OMG/ow1lqr5IGuLBwclYnBGRahr9r+L00XNds9j3SGe0akIA5g93zoGIZ+rQsvEwV4l5Oe9aw4OUL4LzP6lPx0G49sRd5tBserWaM9yXU0UkZS8YGJ1xXdwisQD4wcHx0618svhEax0nzcC7T7EjxGx4pgv/AkSi00IBg60fIVuJqopTnX1G/xOP4W4emRNi6Ln7nSv3l2AmV28e4Fg3jL2IwXVsNF3jZse/82p
X-OriginatorOrg: netapp.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: DS0PR06MB9231.namprd06.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 9fe4b8c0-8b9c-49e7-3ca8-08dd91126318
X-MS-Exchange-CrossTenant-originalarrivaltime: 12 May 2025 05:03:51.3760 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 4b0911a0-929b-4715-944b-c03745165b3a
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: RXxj34quPdCECanRXkuUBVTGKg0i+8vUe10QorQ8sO6IbREh6m/pX19/ZuTVynqvHL5tZnx8jW/cbxC7nI41cw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA2PR06MB7340
X-Proofpoint-ORIG-GUID: WOJ17hIWPFX8l2zPhN0DCxx46jMNE0LN
X-Proofpoint-GUID: WOJ17hIWPFX8l2zPhN0DCxx46jMNE0LN
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwNTEyMDA1MSBTYWx0ZWRfXyRTMb/ZS+sfb
 Lyw6f1J4lJP6ARLFWWyTFUL/qpTLcyzQc35aTV+4wIYOkCCm/nQtQ520Eov4iBxkeYi9a3eyHOY
 XElwrVL2Hf24LYY+dmduu4O2kIZaPu6znQmJw418zUUtxtyYJLFx+NU9UGTIfMRlJYtS2wuz6MW
 whrJ7BQPRNJ50i+Ky1VZRufhPTxF9IE1KZ5DdY0JIXy/v+fLxcriGZ5seZR38opA/rcrUTUkGOb
 XWyqmdvTk/T6b6ssGXpxXusVlEPEKv+pB8PQZQonrmPfU+M+/0AQzGRuGRtGjs9oFhEHjeuo5mU
 0q6Zq3oVTa0SbSUeq8oPXKXrtewv5OH+ZDQxmr342lZNWkT0JzaaASfT04n0P8qHyx/Nixo1Zoo
 k42PGNeND1oLQpvH4rzsUD8dsd/8jXWZzW54T8vItro1aMWNCtziJ8tGnr2dIb3LBV/DBuyZ
X-Authority-Analysis: v=2.4 cv=BdrY0qt2 c=1 sm=1 tr=0 ts=6821813a cx=c_pps
 a=sf1zYAMyThzbrKU8SMWnlQ==:117 a=lCpzRmAYbLLaTzLvsPZ7Mbvzbb8=:19
 a=wKuvFiaSGQ0qltdbU6+NXLB8nM8=:19 a=Ol13hO9ccFRV9qXi2t6ftBPywas=:19
 a=xqWC_Br6kY4A:10 a=dt9VzEwgFbYA:10
 a=GWG4Yq0kndkA:10 a=Fk7l76uXiBR8Kq32zEEA:9 a=CjuIK1q_8ugA:10 a=yMhMjlubAAAA:8
 a=SSmOFEACAAAA:8 a=SQpHWODb-ruHya1CyNAA:9 a=H6KbyRC9S0lajyQr:21
 a=gKO2Hq4RSVkA:10 a=UiCQ7L4-1S4A:10 a=hTZeC7Yk6K0A:10 a=frz4AuCg-hUA:10
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1099,Hydra:6.0.736,FMLib:17.12.80.40
 definitions=2025-05-12_01,2025-05-09_01,2025-02-21_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 mlxlogscore=999
 malwarescore=0 clxscore=1011 priorityscore=1501 suspectscore=0
 adultscore=0 bulkscore=0 mlxscore=0 spamscore=0 lowpriorityscore=0
 impostorscore=0 phishscore=0 classifier=spam authscore=0 authtc=n/a
 authcc= route=outbound adjust=0 reason=mlx scancount=1
 engine=8.21.0-2504070000 definitions=main-2505120051
Received-SPF: pass client-ip=67.231.149.249;
 envelope-from=Rajasekar.P@netapp.com; helo=mx0a-003fbd02.pphosted.com
X-Spam_score_int: -27
X-Spam_score: -2.8
X-Spam_bar: --
X-Spam_report: (-2.8 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, HTML_MESSAGE=0.001,
 RCVD_IN_DNSWL_LOW=-0.7, RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001,
 RCVD_IN_VALIDITY_SAFE_BLOCKED=0.001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=ham autolearn_force=no
X-Spam_action: no action
X-Mailman-Approved-At: Mon, 12 May 2025 01:58:10 -0400
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

--_000_DS0PR06MB9231E15CAD02D2566513ECAA8397ADS0PR06MB9231namp_
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable

Dear KVM Team,

I am currently evaluating different approaches to achieve VM-consistent sna=
pshots and would appreciate your insights on the matter.

My analysis has identified two main approaches for quiescing a VM:


  1.  Quiescing by pausing (or suspending) the entire VM - as currently imp=
lemented using the
virsh suspend
This is a disruptive option as it halts the VM's execution.


  1.  Quiescing by freezing the file system inside the VM - typically perfo=
rmed via the QEMU guest agent using the
domfsfreeze / domfsthaw
                This option is non-disruptive because it allows the VM to c=
ontinue running while ensuring file system consistency.

Technically, the second option appears preferable. However, its implementat=
ion hinges on the following considerations:


  *   The QEMU guest agent must be installed and running within the guest O=
S. While this is often the case by default, it may not be present in all Li=
nux Flavors. Ensuring its availability is therefore a prerequisite.
  *   In Windows environments, the QEMU guest agent freeze leverages VSS (V=
olume Shadow Copy Service), and in Linux, it uses fsfreeze. Since fsfreeze =
freezes I/O, I would like to understand if this temporary freeze might impa=
ct user operations. Additionally, are there any alternative mechanisms to a=
chieve a consistent backup without relying solely on the QEMU guest agent?

Could you please clarify:


  *   The potential impact on user operations during the fsfreeze operation=
 in Linux environments.
  *   Whether there are alternative methods or improvements on the existing=
 approach to obtain VM-consistent backups without significant disruption or=
 reliance on the QEMU guest agent.

Thank you for your assistance. I look forward to your valuable feedback.

Best regards,
Raj.


--_000_DS0PR06MB9231E15CAD02D2566513ECAA8397ADS0PR06MB9231namp_
Content-Type: text/html; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable

<html xmlns:v=3D"urn:schemas-microsoft-com:vml" xmlns:o=3D"urn:schemas-micr=
osoft-com:office:office" xmlns:w=3D"urn:schemas-microsoft-com:office:word" =
xmlns:m=3D"http://schemas.microsoft.com/office/2004/12/omml" xmlns=3D"http:=
//www.w3.org/TR/REC-html40">
<head>
<meta http-equiv=3D"Content-Type" content=3D"text/html; charset=3Dus-ascii"=
>
<meta name=3D"Generator" content=3D"Microsoft Word 15 (filtered medium)">
<style><!--
/* Font Definitions */
@font-face
	{font-family:Wingdings;
	panose-1:5 0 0 0 0 0 0 0 0 0;}
@font-face
	{font-family:"Cordia New";
	panose-1:2 11 3 4 2 2 2 2 2 4;}
@font-face
	{font-family:"Cambria Math";
	panose-1:2 4 5 3 5 4 6 3 2 4;}
@font-face
	{font-family:DengXian;
	panose-1:2 1 6 0 3 1 1 1 1 1;}
@font-face
	{font-family:Aptos;}
@font-face
	{font-family:"\@DengXian";
	panose-1:2 1 6 0 3 1 1 1 1 1;}
/* Style Definitions */
p.MsoNormal, li.MsoNormal, div.MsoNormal
	{margin:0cm;
	font-size:12.0pt;
	font-family:"Aptos",sans-serif;
	mso-ligatures:standardcontextual;}
span.EmailStyle17
	{mso-style-type:personal-compose;
	font-family:"Aptos",sans-serif;
	color:windowtext;}
.MsoChpDefault
	{mso-style-type:export-only;}
@page WordSection1
	{size:612.0pt 792.0pt;
	margin:72.0pt 72.0pt 72.0pt 72.0pt;}
div.WordSection1
	{page:WordSection1;}
/* List Definitions */
@list l0
	{mso-list-id:181284272;
	mso-list-template-ids:183114520;}
@list l0:level1
	{mso-level-number-format:bullet;
	mso-level-text:\F0B7;
	mso-level-tab-stop:36.0pt;
	mso-level-number-position:left;
	text-indent:-18.0pt;
	mso-ansi-font-size:10.0pt;
	font-family:Symbol;}
@list l0:level2
	{mso-level-number-format:bullet;
	mso-level-text:o;
	mso-level-tab-stop:72.0pt;
	mso-level-number-position:left;
	text-indent:-18.0pt;
	mso-ansi-font-size:10.0pt;
	font-family:"Courier New";
	mso-bidi-font-family:"Times New Roman";}
@list l0:level3
	{mso-level-number-format:bullet;
	mso-level-text:\F0A7;
	mso-level-tab-stop:108.0pt;
	mso-level-number-position:left;
	text-indent:-18.0pt;
	mso-ansi-font-size:10.0pt;
	font-family:Wingdings;}
@list l0:level4
	{mso-level-number-format:bullet;
	mso-level-text:\F0A7;
	mso-level-tab-stop:144.0pt;
	mso-level-number-position:left;
	text-indent:-18.0pt;
	mso-ansi-font-size:10.0pt;
	font-family:Wingdings;}
@list l0:level5
	{mso-level-number-format:bullet;
	mso-level-text:\F0A7;
	mso-level-tab-stop:180.0pt;
	mso-level-number-position:left;
	text-indent:-18.0pt;
	mso-ansi-font-size:10.0pt;
	font-family:Wingdings;}
@list l0:level6
	{mso-level-number-format:bullet;
	mso-level-text:\F0A7;
	mso-level-tab-stop:216.0pt;
	mso-level-number-position:left;
	text-indent:-18.0pt;
	mso-ansi-font-size:10.0pt;
	font-family:Wingdings;}
@list l0:level7
	{mso-level-number-format:bullet;
	mso-level-text:\F0A7;
	mso-level-tab-stop:252.0pt;
	mso-level-number-position:left;
	text-indent:-18.0pt;
	mso-ansi-font-size:10.0pt;
	font-family:Wingdings;}
@list l0:level8
	{mso-level-number-format:bullet;
	mso-level-text:\F0A7;
	mso-level-tab-stop:288.0pt;
	mso-level-number-position:left;
	text-indent:-18.0pt;
	mso-ansi-font-size:10.0pt;
	font-family:Wingdings;}
@list l0:level9
	{mso-level-number-format:bullet;
	mso-level-text:\F0A7;
	mso-level-tab-stop:324.0pt;
	mso-level-number-position:left;
	text-indent:-18.0pt;
	mso-ansi-font-size:10.0pt;
	font-family:Wingdings;}
@list l1
	{mso-list-id:637495773;
	mso-list-template-ids:958310362;}
@list l1:level1
	{mso-level-number-format:bullet;
	mso-level-text:\F0B7;
	mso-level-tab-stop:36.0pt;
	mso-level-number-position:left;
	text-indent:-18.0pt;
	mso-ansi-font-size:10.0pt;
	font-family:Symbol;}
@list l1:level2
	{mso-level-number-format:bullet;
	mso-level-text:o;
	mso-level-tab-stop:72.0pt;
	mso-level-number-position:left;
	text-indent:-18.0pt;
	mso-ansi-font-size:10.0pt;
	font-family:"Courier New";
	mso-bidi-font-family:"Times New Roman";}
@list l1:level3
	{mso-level-number-format:bullet;
	mso-level-text:\F0A7;
	mso-level-tab-stop:108.0pt;
	mso-level-number-position:left;
	text-indent:-18.0pt;
	mso-ansi-font-size:10.0pt;
	font-family:Wingdings;}
@list l1:level4
	{mso-level-number-format:bullet;
	mso-level-text:\F0A7;
	mso-level-tab-stop:144.0pt;
	mso-level-number-position:left;
	text-indent:-18.0pt;
	mso-ansi-font-size:10.0pt;
	font-family:Wingdings;}
@list l1:level5
	{mso-level-number-format:bullet;
	mso-level-text:\F0A7;
	mso-level-tab-stop:180.0pt;
	mso-level-number-position:left;
	text-indent:-18.0pt;
	mso-ansi-font-size:10.0pt;
	font-family:Wingdings;}
@list l1:level6
	{mso-level-number-format:bullet;
	mso-level-text:\F0A7;
	mso-level-tab-stop:216.0pt;
	mso-level-number-position:left;
	text-indent:-18.0pt;
	mso-ansi-font-size:10.0pt;
	font-family:Wingdings;}
@list l1:level7
	{mso-level-number-format:bullet;
	mso-level-text:\F0A7;
	mso-level-tab-stop:252.0pt;
	mso-level-number-position:left;
	text-indent:-18.0pt;
	mso-ansi-font-size:10.0pt;
	font-family:Wingdings;}
@list l1:level8
	{mso-level-number-format:bullet;
	mso-level-text:\F0A7;
	mso-level-tab-stop:288.0pt;
	mso-level-number-position:left;
	text-indent:-18.0pt;
	mso-ansi-font-size:10.0pt;
	font-family:Wingdings;}
@list l1:level9
	{mso-level-number-format:bullet;
	mso-level-text:\F0A7;
	mso-level-tab-stop:324.0pt;
	mso-level-number-position:left;
	text-indent:-18.0pt;
	mso-ansi-font-size:10.0pt;
	font-family:Wingdings;}
@list l2
	{mso-list-id:1952786176;
	mso-list-template-ids:-1343068674;}
ol
	{margin-bottom:0cm;}
ul
	{margin-bottom:0cm;}
--></style><!--[if gte mso 9]><xml>
<o:shapedefaults v:ext=3D"edit" spidmax=3D"1026" />
</xml><![endif]--><!--[if gte mso 9]><xml>
<o:shapelayout v:ext=3D"edit">
<o:idmap v:ext=3D"edit" data=3D"1" />
</o:shapelayout></xml><![endif]-->
</head>
<body lang=3D"EN-IN" link=3D"#467886" vlink=3D"#96607D" style=3D"word-wrap:=
break-word">
<div class=3D"WordSection1">
<p class=3D"MsoNormal"><span style=3D"font-size:11.0pt">Dear KVM Team,<o:p>=
</o:p></span></p>
<p class=3D"MsoNormal"><span style=3D"font-size:11.0pt"><o:p>&nbsp;</o:p></=
span></p>
<p class=3D"MsoNormal"><span style=3D"font-size:11.0pt">I am currently eval=
uating different approaches to achieve VM-consistent snapshots and would ap=
preciate your insights on the matter.<o:p></o:p></span></p>
<p class=3D"MsoNormal"><span style=3D"font-size:11.0pt"><o:p>&nbsp;</o:p></=
span></p>
<p class=3D"MsoNormal"><span style=3D"font-size:11.0pt">My analysis has ide=
ntified two main approaches for quiescing a VM:<o:p></o:p></span></p>
<p class=3D"MsoNormal"><span style=3D"font-size:11.0pt"><o:p>&nbsp;</o:p></=
span></p>
<ol style=3D"margin-top:0cm" start=3D"1" type=3D"1">
<li class=3D"MsoNormal" style=3D"mso-list:l2 level1 lfo1"><span style=3D"fo=
nt-size:11.0pt">Quiescing by pausing (or suspending) the entire VM &#8211; =
as currently implemented using the<o:p></o:p></span></li></ol>
<p class=3D"MsoNormal" style=3D"margin-left:36.0pt;text-indent:36.0pt"><b><=
i><span style=3D"font-size:11.0pt">virsh suspend<o:p></o:p></span></i></b><=
/p>
<p class=3D"MsoNormal" style=3D"text-indent:36.0pt"><span style=3D"font-siz=
e:11.0pt">This is a disruptive option as it halts the VM's execution.<o:p><=
/o:p></span></p>
<p class=3D"MsoNormal" style=3D"text-indent:36.0pt"><span style=3D"font-siz=
e:11.0pt"><o:p>&nbsp;</o:p></span></p>
<ol style=3D"margin-top:0cm" start=3D"2" type=3D"1">
<li class=3D"MsoNormal" style=3D"mso-list:l2 level1 lfo1"><span style=3D"fo=
nt-size:11.0pt">Quiescing by freezing the file system inside the VM &#8211;=
 typically performed via the QEMU guest agent using the<o:p></o:p></span></=
li></ol>
<p class=3D"MsoNormal" style=3D"margin-left:72.0pt"><b><i><span style=3D"fo=
nt-size:11.0pt">domfsfreeze / domfsthaw<o:p></o:p></span></i></b></p>
<p class=3D"MsoNormal"><span style=3D"font-size:11.0pt">&nbsp;&nbsp;&nbsp;&=
nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; Thi=
s option is non-disruptive because it allows the VM to continue running whi=
le ensuring file system consistency.<o:p></o:p></span></p>
<p class=3D"MsoNormal"><span style=3D"font-size:11.0pt"><o:p>&nbsp;</o:p></=
span></p>
<p class=3D"MsoNormal"><span style=3D"font-size:11.0pt">Technically, the se=
cond option appears preferable. However, its implementation hinges on the f=
ollowing considerations:<o:p></o:p></span></p>
<p class=3D"MsoNormal"><span style=3D"font-size:11.0pt"><o:p>&nbsp;</o:p></=
span></p>
<ul style=3D"margin-top:0cm" type=3D"disc">
<li class=3D"MsoNormal" style=3D"mso-list:l1 level1 lfo2"><span style=3D"fo=
nt-size:11.0pt">The QEMU guest agent must be installed and running within t=
he guest OS. While this is often the case by default, it may not be present=
 in all Linux Flavors. Ensuring its availability
 is therefore a prerequisite.<o:p></o:p></span></li><li class=3D"MsoNormal"=
 style=3D"mso-list:l1 level1 lfo2"><span style=3D"font-size:11.0pt">In Wind=
ows environments, the QEMU guest agent freeze leverages VSS (Volume Shadow =
Copy Service), and in Linux, it uses fsfreeze. Since fsfreeze freezes I/O, =
I would like to
 understand if this temporary freeze might impact user operations. Addition=
ally, are there any alternative mechanisms to achieve a consistent backup w=
ithout relying solely on the QEMU guest agent?<o:p></o:p></span></li></ul>
<p class=3D"MsoNormal" style=3D"margin-left:36.0pt"><span style=3D"font-siz=
e:11.0pt"><o:p>&nbsp;</o:p></span></p>
<p class=3D"MsoNormal"><span style=3D"font-size:11.0pt">Could you please cl=
arify:<o:p></o:p></span></p>
<p class=3D"MsoNormal"><span style=3D"font-size:11.0pt"><o:p>&nbsp;</o:p></=
span></p>
<ul style=3D"margin-top:0cm" type=3D"disc">
<li class=3D"MsoNormal" style=3D"mso-list:l0 level1 lfo3"><span style=3D"fo=
nt-size:11.0pt">The potential impact on user operations during the fsfreeze=
 operation in Linux environments.<o:p></o:p></span></li><li class=3D"MsoNor=
mal" style=3D"mso-list:l0 level1 lfo3"><span style=3D"font-size:11.0pt">Whe=
ther there are alternative methods or improvements on the existing approach=
 to obtain VM-consistent backups without significant disruption or reliance=
 on the QEMU guest
 agent.<o:p></o:p></span></li></ul>
<p class=3D"MsoNormal" style=3D"margin-left:36.0pt"><span style=3D"font-siz=
e:11.0pt"><o:p>&nbsp;</o:p></span></p>
<p class=3D"MsoNormal"><span style=3D"font-size:11.0pt">Thank you for your =
assistance. I look forward to your valuable feedback.<o:p></o:p></span></p>
<p class=3D"MsoNormal"><span style=3D"font-size:11.0pt"><o:p>&nbsp;</o:p></=
span></p>
<p class=3D"MsoNormal"><span style=3D"font-size:11.0pt">Best regards,<o:p><=
/o:p></span></p>
<p class=3D"MsoNormal"><span style=3D"font-size:11.0pt">Raj.<o:p></o:p></sp=
an></p>
<p class=3D"MsoNormal"><span style=3D"font-size:11.0pt"><o:p>&nbsp;</o:p></=
span></p>
</div>
</body>
</html>

--_000_DS0PR06MB9231E15CAD02D2566513ECAA8397ADS0PR06MB9231namp_--

