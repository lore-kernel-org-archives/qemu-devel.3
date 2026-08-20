Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 52DE2C5DF81
	for <qemu-devel@archiver.kernel.org>; Thu, 20 Aug 2026 04:44:25 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wwud7-0001Zt-5b; Thu, 20 Aug 2026 00:43:53 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1)
 (envelope-from <prvs=685c7dad1=Alistair.Francis@wdc.com>)
 id 1wwud6-0001Zg-7V; Thu, 20 Aug 2026 00:43:52 -0400
Received: from esa1.hgst.iphmx.com ([68.232.141.245])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1)
 (envelope-from <prvs=685c7dad1=Alistair.Francis@wdc.com>)
 id 1wwud4-00030Y-7U; Thu, 20 Aug 2026 00:43:51 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
 d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
 t=1787201030; x=1818737030;
 h=from:to:subject:date:message-id:references:in-reply-to:
 content-id:content-transfer-encoding:mime-version;
 bh=PvMSJDmebMfZ+ktTp8SrBfoCU1Cars1NLjNr2yCEjU4=;
 b=ZDALkTCOH0cfxv4+s9z7pLYgNuEy0a/BC8dVdGEwTteQTkLa429Vr2ab
 RrsS8vI6bf6d87ZYpyoWIL4ClxWWuNLMx2kUrHV4bPBnBoi2SbBqxHvm6
 rqBSjS3TzmNRucHpDRnl7wiHrOAzMuOe4h6I7H+DXeADgHm5jDZkkCenL
 0Hp99I4siY0KIOoGFLrzL2SCdtl+IcWhLKyGPj68sCzSJ+39GRKZM5qcu
 /XApLWWoIkvC8O9n1mWzISXr9YAK5Gp4pOHRuhEe5GWe7XyIW1D4kx+hm
 MmbTFwcWsZnNl3xiHXSwsjJiJBsDTWN0zyRip1lF8vRV9rzy713qL5pEX Q==;
X-CSE-ConnectionGUID: RQRQkv6nQoayuXyG2YhyaA==
X-CSE-MsgGUID: VhzxlcluTnyr9Xf4VcXBYA==
X-IronPort-AV: E=Sophos;i="6.25,232,1779120000"; d="scan'208";a="153664156"
Received: from mail-eastus2azon11010070.outbound.protection.outlook.com (HELO
 BN1PR04CU002.outbound.protection.outlook.com) ([52.101.56.70])
 by ob1.hgst.iphmx.com with ESMTP/TLS/ECDHE-RSA-AES128-GCM-SHA256;
 20 Aug 2026 12:43:44 +0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=Uahzqn6U4e97MTFaVfr/cTFwgLcCRGnJRKiYD6JXaxD3mre0SEnNuSTXmN+UwJzvNidXiYHk6PaQTydRJdByXEjBm8JM2HwbNd1FGHmjUQ7NKWsUfeDDGjXWm4c3+dbV79+w1bkraIRJbU6oFzUno35uV3SXKDKgxDN35g9EhTwcpIO4+wOhDIdqPwUbiPPWNWvNxAXaXoVkgFQ1ipLhNmNnFZ+tcSPUmE11d1ps9Q3xLxFhJ1/Tdwpo9v2Co1ZYGPukQf4SuyYAR24tLbVGQBqASvEcz+p8c209jP621ZH5h/YHZk+lcV5mvmJVzGMMoO9MmC4mp0NylmpVgQX1hQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=PvMSJDmebMfZ+ktTp8SrBfoCU1Cars1NLjNr2yCEjU4=;
 b=dGdzs8q/uGHg0PTyoOxmNe6/aTrM50DMJ03/KKtJ16cBEE4bSQRLZk02VdUtLf6M0MUuAh6ffNAo7rhvS6roxK2RUHlLwr+qhFsqxacsqeXNdtC3xAi8Unh/6b8ktbovGcooibKGq2VaoT2L1WaWC8ZRZkrWrjTSc/3FJg3OKX2gu0Zjq7rl662J4GV5CiO5fNkZaH7iUFho0ksJcAPbZT3zqQDIp5+G1hAAj7ppiOi3//7Tuj32WsQVdIPknWbXQ6eAdzU8rtCF+7+iA36FRaW+Zp3Aomgkq6AIWFoO5QrUMWIQI6En7PwD6YZ8PKoXLgrEVSEU4R4ni8m7lAuBbA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=wdc.com; dmarc=pass action=none header.from=wdc.com; dkim=pass
 header.d=wdc.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=sharedspace.onmicrosoft.com; s=selector2-sharedspace-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=PvMSJDmebMfZ+ktTp8SrBfoCU1Cars1NLjNr2yCEjU4=;
 b=laJVwPD8vNej45MfLUTGoQCNXN4xBdYtej4gazrry4USKgOiZAFbe/EltHoAPV5n0xewIjYp+ugpXJrlx/n84W/AAYmIa4KKZl1NFh9D/9IixRD0J/Kef8qb7T9n56y1VNGQQjBmXB9gBKs/K8kiG6V36GVAo8w+naiOSqL3KIc=
Received: from BY1PR04MB9561.namprd04.prod.outlook.com (2603:10b6:a03:5b6::11)
 by CH8PR04MB993885.namprd04.prod.outlook.com (2603:10b6:610:2eb::5)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.339.10; Thu, 20 Aug
 2026 04:43:41 +0000
Received: from BY1PR04MB9561.namprd04.prod.outlook.com
 ([fe80::3869:e494:2fa8:9888]) by BY1PR04MB9561.namprd04.prod.outlook.com
 ([fe80::3869:e494:2fa8:9888%5]) with mapi id 15.21.0339.007; Thu, 20 Aug 2026
 04:43:41 +0000
From: Alistair Francis <Alistair.Francis@wdc.com>
To: "qemu-devel@nongnu.org" <qemu-devel@nongnu.org>,
 "daniel.barboza@oss.qualcomm.com" <daniel.barboza@oss.qualcomm.com>,
 "qemu-riscv@nongnu.org" <qemu-riscv@nongnu.org>,
 "chao.liu@processmission.com" <chao.liu@processmission.com>,
 "zhiwei_liu@linux.alibaba.com" <zhiwei_liu@linux.alibaba.com>,
 "palmer@dabbelt.com" <palmer@dabbelt.com>, "liwei1518@gmail.com"
 <liwei1518@gmail.com>, "frederic.petrot@univ-grenoble-alpes.fr"
 <frederic.petrot@univ-grenoble-alpes.fr>
Subject: Re: [PATCH 0/2] target/riscv: Handle [ms]status updates for rv128
Thread-Topic: [PATCH 0/2] target/riscv: Handle [ms]status updates for rv128
Thread-Index: AQHdL8l15AaC+gDBHkykvsTTbHllkLamXV4A
Date: Thu, 20 Aug 2026 04:43:41 +0000
Message-ID: <95a50349667ed9fbdea78af8a03f5f8d527b7833.camel@wdc.com>
References: <20260819105655.33391-1-frederic.petrot@univ-grenoble-alpes.fr>
In-Reply-To: <20260819105655.33391-1-frederic.petrot@univ-grenoble-alpes.fr>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
user-agent: Evolution 3.60.2 (by Flathub.org) 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=wdc.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: BY1PR04MB9561:EE_|CH8PR04MB993885:EE_
x-ms-office365-filtering-correlation-id: b8ff26e9-9b07-499d-717a-08defe759c11
wdcipoutbound: EOP-TRUE
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
 ARA:13230040|1800799024|366016|376014|19092799006|23010399003|10070799003|10067099003|11063799006|56012099006|18002099003|22082099003|38070700021;
x-microsoft-antispam-message-info: B8JFZAvdKkLecXjrdBf1NhpjHeGc6sBGQ41ymed4cmexuuOc5rxjPIYBGiLiyIEe4+3RBTRdadBzjwp/9ZOL1xWkJBMV4+U2jixdErmgX3qLQR8nqJakOKhs6k0IBcgFgfzDGzH+9BERvH/KHBmRX+SyJj3vncjHI2N15emaGFZ1awvxnADY6tZjXBtPA/IQQskOk1rs3i5otoF5WXvjdCI1Jj+Fg7yPAqIqmzS1AEXttUfeD7qeYOyguvYbZ/9+v2zEzEc31lIhsCkBLUeFFNHrbSseW8/m6PSavD8GqNFpveXKL8PZFeVQ5EYVnXftYqbCDhURwgMp5GRDDYoeLUHPmdzbX0SR7rae7fmIu9i1TJAVPjTSconB2KvlwD37VOSXl7Mo8eM5FtaeIVYc17Jcr4EPgeum5T8+QaI/TcJ5hhN5RoRshpoLIaQnIEo6TVLwW6p0nZMhHDHQznvLjbwdycIynmPb58FmcrHeY/dhMrR1EsQ/1JySV7kYN4oa0+xhkTMszJi3MwCI6bThohN26euZP0VC8mzb00M4k54SAGrpwjzDLSJRkwofnJEBiBmoZAP1WqBvgwBJ2Alr5xa8W85V1Qxp/d3hoSBwbA4eaxP7boL6VdsXT7jls3R7RIobEX+3+uTjhumIdsvlok3/vxtaeU5bFo5iSZzxVXVD0Q9uHsfOP1RenR5YabJD7ruBNIyrpX/o9IjmtFzy01Ap881pKVLyFIpQafHAxAk=
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:BY1PR04MB9561.namprd04.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(1800799024)(366016)(376014)(19092799006)(23010399003)(10070799003)(10067099003)(11063799006)(56012099006)(18002099003)(22082099003)(38070700021);
 DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 2
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?OXVnUldDZENmOForT09MUTFTYlNHWDE2QU9ybjg3R2o0enpQTXZJUlh1MWh4?=
 =?utf-8?B?N3U2eTVkNm9KUG5nWlRLTTYreXd2aDlsb3ZtbEIvM05PMVJFRDZQam1Od2VW?=
 =?utf-8?B?bkZLeitjM3c2Ujlpc2diWWsrY0ZBYzlWMXZmNTdFQnFNOFVENXBXSXd0LzVR?=
 =?utf-8?B?NGk2Z0NYMTBPUTZuaVJ5Y3Z6ODFBeVZ0bEhUYUxOZlNMamVLQi9DYlNETXF1?=
 =?utf-8?B?TGpRRnQ3akQzT2g5OW4rT3VFRWZYa1NVRVdCanNQbnpBYUFteDZJSjM2a3RH?=
 =?utf-8?B?YUF6M3BmOHlvemRJK204Y0ZJOGhZUG9INlFBTnFRS2xJVEV4a1BuOVo3MG5F?=
 =?utf-8?B?Ukx4V2RlZU1aL2hkK3pKZmRUbnlnUFJoaHZrT2dYczVrZldJYVljNThsYlBa?=
 =?utf-8?B?TGZzRGdEVzdiTml5QWJrZ00zS0xGZ3NPVWFQTS91R0dtTGlVWUlSL3BibURH?=
 =?utf-8?B?dVdzWTNBNnArSUVDUVdRaEZ5VXBPNmh0YWZDSm1ibE9GWDE3SVdBNGcyd29F?=
 =?utf-8?B?MmFML09pelQ3aWo5bzd5NTB6aTBLeFR5eEczcVdjeDRKc3BlMGpUcUtkVlVw?=
 =?utf-8?B?NHQrZTg2THU5dHhialo0bk1tSHdJTndGOWZpb0hHK3d2OTdsS3NDYTFRb1By?=
 =?utf-8?B?T1hWUVVyWXFmWkVxa2lTcVlTZkRTVWVqZERWVGZLMC9UU2FaTWdSWCtReXBt?=
 =?utf-8?B?V3BEbDU4UC9KRnJheCt0amdxQTBkTVN5S044ZndxMmFJaWJsNmtWaTdkVVBp?=
 =?utf-8?B?Q3NTVkNCWk1DV0ZYOC94NXFBSnpGWndwMXBhRU41OFJ5bndJUmZZcCt1UFFv?=
 =?utf-8?B?LzFnTmxCYW5nMCtUR2l6WHBzc1RLTmhuOXphcXpsY1BGMW5lZG0zUytxZjNv?=
 =?utf-8?B?RjVVUGVRWXhoL1dIUW5VRjJHTEpBQW1rOEc5d3llQVJjQ3k5ZFN5YnZoNHFR?=
 =?utf-8?B?bFVGVXB3ZTJsb0x0aGZWRG5wMXlHM0NJTnp2OWxRVXFrVGxzZWhjbHZ5eVdu?=
 =?utf-8?B?TGw5L2FRbmhPTWNiTXZTQUIySWhsc2ZwcHJFVXVTa3VlRm9rTEhWNit0RWRZ?=
 =?utf-8?B?UG02Y1lnUlZNbHZKRnZSYktTVWdtYzlEN1NGOEZEY0ZOTHRWZTdOMXUybDdP?=
 =?utf-8?B?cjlwMzhOUkJrMDdNdDNyS1BWdHpHdjBvemlndTJXRjdBUU1YcjdqSTN6ZWJj?=
 =?utf-8?B?aU5tcXg5YmczYWExZDFqSkZtbGFBLzBJcFgvVzNNOUVsN0ZmbkdnN3A0OXdu?=
 =?utf-8?B?QndBMlNzUExVQ1JFNjVFbDl5Q0FPQTBMNlJ6WSsxSDJYSWtoKzQ1SnNMZ1c1?=
 =?utf-8?B?emZNeE1DRmpOemRUaXNTWWlJZElYSmJ3aFNXQjk1bFg0eVRJSDhiMFRHWGZQ?=
 =?utf-8?B?ZXhVVklEbDZwM0hIUXdvdGlEV0JOZStiYTQrbjQ4QllURFJXeUhyL2sxb1lO?=
 =?utf-8?B?RE9FeWQvZm9nMDVtZGwyZUIxWktoeEhJandFUzhUS1c3alFVMThiQXQ2cWVZ?=
 =?utf-8?B?ejduU0dNUkRDOGFCN0xsaDMwLzlRVW5nRGJDODJVU0ZvTEQxMzRXbGJOdGlK?=
 =?utf-8?B?TmxhTkZpeDA5aHU5cGNnbXB1NG41U0twaXRZME1IU042YU9za1plemJZaG5Z?=
 =?utf-8?B?Z293dEYvTzRzNWNmVjl1emFocFArN2dQa3Y3THY0KzFKWWdzNDE1TlJGQTZv?=
 =?utf-8?B?ZDYvYjIvV2FpMExSbGRCNXg0bHBTMURyZlRaMHpONkNtSjZzWERxSzB1M0d0?=
 =?utf-8?B?ZFhiZFVWOGplclBVcjdmeDQrS1lxWDhxbE5kOHRvVGZ6NmpaSlNZMG01cTNi?=
 =?utf-8?B?WEF4cC82TG9RQXVLa2Y5QUxZRFRtU1ZVbVVpS0xrVFJlaXpOVFhMa0c2TzFU?=
 =?utf-8?B?aGxlRC85bWNlcCtrUGEwaE8vQWlFOHRqcThoMVZnSFQ4alZmZG9WbGsrVnJi?=
 =?utf-8?B?c2pGdzRaV0xMcVp5T1BDTGQyWGFnR2M3ZzN3UnNhWHdiQVg5dGtMelZmWjh4?=
 =?utf-8?B?RUZadEhuc01UV1lSQXRmWkVneXBYRVVjV1h6bkdyS0R6RVZhOUF0a2U0SlpG?=
 =?utf-8?B?Vk9ZRkYzdi83UlVJWXVPWmU4TTB2UDdyWjNsaGdEeGZmalN2NUVhL3FJc1gy?=
 =?utf-8?B?QUkyZ1FPbmVXeUZJV1lFZFNhNDVDNk9pZTljUWFBeEYrUEQrcWU2eUxDcGRI?=
 =?utf-8?B?TWM0dFU4b1BRZ3BYYk9wL0FKUlNwUGRCWXk2NTZYRWRMLzNrak5YeUk2dmtt?=
 =?utf-8?B?WmdBQ2xXdUpRdWFaeEhpTExNdzBQRlJXNTVKby81ZG53c3JmT2VhMHZKWEtn?=
 =?utf-8?B?QWE0UHduVGpRcDNiazAvMlN0U3RTZm5YdEtMZTdtREdRSzJqcG1tWXNzbVZG?=
 =?utf-8?Q?JOfNstRtNun/ACz2qV5+s30byzSaD5Hhm6i6Mc2SVUlvP?=
x-ms-exchange-antispam-messagedata-1: LFpCg99p8EmVW56sWR1hH6gzaMCzHgwCe8M=
Content-Type: text/plain; charset="utf-8"
Content-ID: <2B0F2373CFB36745BC4D450CF903C02D@namprd04.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-Exchange-RoutingPolicyChecked: dywFLd65PIn+E+Tt6FWGrODdUTR3TpbW2WBJQui+ALKj17UsFSo0fM05LMlEXri3ro2moq/BJBXxTGYuB1rhgwdg1sMkJH92vNBTIJZa5yDwpKBieU+AmbzwCU+ZELjDs0icT1stgZaknRaTLRWEdl42AZfjE6b9Iyq5bU6rdIxrGcqxeOU2dnaXEBkbBXnyuyXPF8WKfL5RTo6rTmphy+8aJZCjXEeH5tlWtXXkmgmPt8XFCiueemvjk6BQLHy2V8WzdWft2QIo3TW95qMl8NNIF5n8ghUN2+3Y5atYTeL2Vrym0g2dZrYgk7lzcdaeDEeuHAYMllzaYwFm67btHg==
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: Z7bQuBKrN0UmCYRvspSWh6TFHg6CNsIWQmcYnlakIOvnpnwfAl8fkZLzadFGrEtPSpQpDIySSdRdhfeUTqAiYNQ2pWOUyWVrW9hecIc4W7SrnXu8l/UH2Za2bD89cGph6MOwYk3vyJyLX9C0NHwujNHipxSLlLOsloGwM7KKJ/MS52+HIEicdPv+PRX+lXh7cFiJnxfy0p718F/EEX+zWb2BTg0IRX3irKf86ZuByoaYRq4sqWMp00RhFEFY8gPibrtmUb0Q8w4dzl+l9g+Usz1lSjnEzNQ0ul8r4iislE5m+o+hQo6pKIAxHqNu3WpnLcgj4lNW9kqRdTQurMooHI5EpR0tUspL31iKULk2U08io58DC5FQtkOJW9h3GMPPOIgt4RlF1lEU73L6ZPZbj2FPCMvIlWFZR1VXwTw09lSbxIe/PG+OfqdEbh7/HZVcUQDKU+3X4bobaEuP0AOCY7OBpDAUo15tknu6QAIO/32diIKwDT0Xa2H+pfpRbRk1T46frHoBINEg663pRcbbQn+m0ulvKZeMvL0Uw1modGV+BJcYVJDUdrqJ2Nh9QkrZloCxjMsmdoJLp2kQ9jXGO5RcLxNelVe5Ug4wpoepnpUR0f+ZJEDB2olbXTT60Lhv
X-OriginatorOrg: wdc.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: BY1PR04MB9561.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: b8ff26e9-9b07-499d-717a-08defe759c11
X-MS-Exchange-CrossTenant-originalarrivaltime: 20 Aug 2026 04:43:41.6069 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: b61c8803-16f3-4c35-9b17-6f65f441df86
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: O+TvccOgfw2qNWD9VCKOb6Yrnl1gnTJb+OLFFjRLg170l+2zRdeK7ByVov+ZrokV/bBNhmNhLyrEwCBgaCVj9opFLL3QnCxBfraYeRJCC0g=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH8PR04MB993885
Received-SPF: pass client-ip=68.232.141.245;
 envelope-from=prvs=685c7dad1=Alistair.Francis@wdc.com;
 helo=esa1.hgst.iphmx.com
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

T24gV2VkLCAyMDI2LTA4LTE5IGF0IDEyOjU2ICswMjAwLA0KZnJlZGVyaWMucGV0cm90QHVuaXYt
Z3Jlbm9ibGUtYWxwZXMuZnIgd3JvdGU6DQo+IEZyb206IEZyw6lkw6lyaWMgUMOpdHJvdCA8ZnJl
ZGVyaWMucGV0cm90QHVuaXYtZ3Jlbm9ibGUtYWxwZXMuZnI+DQo+IA0KPiBDb3JyZWN0IHNzdGF0
dXMgdXBkYXRlIGFuZCBhbGxvdyBzdXBwb3J0IGZvciBydjEyOCBpbiBtc3RhdHVzLA0KPiBwcm92
aWRlZCB0aGUgY3B1IGlzIGFuIHJ2MTI4Lg0KPiANCj4gQ2hhbmdlcyBjb21wYXJlZCB0byB2MToN
Cj4gLSBhZGQgY292ZXIgbGV0dGVyDQo+IC0gYWRkIHRoZSBSZXZpZXdlZC1ieSB0YWdzDQo+IA0K
PiBGcsOpZMOpcmljIFDDqXRyb3QgKDIpOg0KPiDCoCB0YXJnZXQvcmlzY3Y6IEZpeCBzc3RhdHVz
IHVwZGF0ZSBpbiBydjEyOA0KPiDCoCB0YXJnZXQvcmlzY3Y6IEFsbG93IFVYTCB0byBiZSAzIGlu
IG1zdGF0dXMgb24gcnYxMjgNCg0KVGhhbmtzIQ0KDQpBcHBsaWVkIHRvIHJpc2N2LXRvLWFwcGx5
Lm5leHQNCg0KQWxpc3RhaXINCg0KPiANCj4gwqB0YXJnZXQvcmlzY3YvdGNnL2Nzci5jIHwgOCAr
KysrLS0tLQ0KPiDCoDEgZmlsZSBjaGFuZ2VkLCA0IGluc2VydGlvbnMoKyksIDQgZGVsZXRpb25z
KC0pDQo=

