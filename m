Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8EFCACAC587
	for <qemu-devel@archiver.kernel.org>; Fri, 12 Sep 2025 02:14:05 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uwtIX-0005sK-Kb; Thu, 11 Sep 2025 22:14:01 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1)
 (envelope-from <prvs=343c7b6c6=wilfred.mallawa@wdc.com>)
 id 1uwtIU-0005lO-7M; Thu, 11 Sep 2025 22:13:58 -0400
Received: from esa3.hgst.iphmx.com ([216.71.153.141])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1)
 (envelope-from <prvs=343c7b6c6=wilfred.mallawa@wdc.com>)
 id 1uwtIN-0005FP-Gn; Thu, 11 Sep 2025 22:13:57 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
 d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
 t=1757643231; x=1789179231;
 h=from:to:cc:subject:date:message-id:references:
 in-reply-to:content-id:content-transfer-encoding: mime-version;
 bh=bzvl8LFZ8OpSAhtIwXRPOs5wM+Kyk6XTPErvXBxl8ss=;
 b=jgCK5aCLaA+Y2EAgQgNEYUlALmzoDmaB80/3pjN9l08q3P12JKcbhDek
 5/VnSJ99mLVHV7tMMawyohTOExi9hDPul1+7ZUAl/YJCLNGPbii5bpPRm
 AfGcSjwiaOVS2sG03o1oJ7PD9aSHjpBnWtM+oSIt76AYUNXpSeyDUbYrv
 X7K6+fpFGKTDW67FN7X4OpufM32SmPBEGIx0Sn3c1QtvOfABOhd4v3E3h
 E+LBfK7/wvKeuuzVapoIzbLgi87Y9/iwO0Pdq5+dHdHeUKEYqeJKQtkEa
 ZlCLFHsh+dYZxt6Y28dKcgRX6or6L+ACDjjQclDDLsLdP4LB9b2ReMb3U g==;
X-CSE-ConnectionGUID: uKQu1lCEQgeUds5l/kVbbQ==
X-CSE-MsgGUID: ILXq3izgQUqUpfCNv/jyDw==
X-IronPort-AV: E=Sophos;i="6.18,258,1751212800"; d="scan'208";a="117294469"
Received: from mail-northcentralusazon11013007.outbound.protection.outlook.com
 (HELO CH4PR04CU002.outbound.protection.outlook.com) ([40.107.201.7])
 by ob1.hgst.iphmx.com with ESMTP; 12 Sep 2025 10:13:39 +0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=cuqmZ2D3zAjD82Fcjdks82q8Ety1nQShu2AapPNizl0D+8RypOaXgaz5DRLoYSnXHQ1D/7nK29kKzsQERfTo0fglAccEmxy0kBFlfPOncmkSPAYG+l4wqZuBzT/ZivdFsXkyikzm3CNzZDswzVxH+zETsxsfzPRqu1Q0wDFfOIi9yQ1KOL/2JmrVBy6/kf0qQlipCV79GZ99bzk4Ko9ctimUTdZ+B/9eP1aSGCTB++3+ExZOnKxx4r6lW/La7pA5SW4Y6UZM0e3my96ZVjZUf1w+Ya8gikCmTwFBHGRy2TWfcHFMMGqKinfMpQAtW66tfQD3c8l4ZmOGRGw3wQ/SLA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=bzvl8LFZ8OpSAhtIwXRPOs5wM+Kyk6XTPErvXBxl8ss=;
 b=GH+EICX9RL8v6g3L+Vge/bbgciWABMSjpMxuzeW3a5KIwM/nfsIbeBzepuQ9gNGR7kSIP5CyZuOwhzmz81ohgq7UIsl0drokSO2SAjh7Jag4rBDJEP21a2JLXoKNcZcWA7GphhE7AKYAb0p8udXc0ovFMXyo87tCCsFJz4HhIRnaxND/x4FImgDtTFWrE9gUZiSAcny7WPB828r0YSzgBNd5UlFh9n/R1Yqn6morR3s3BYvZ8e/cFt4tNG8BToL3Euv4dRZU/+Lav2QPtlzfxPR7BmI5zvAfR089CUrNiK3uZ6Tf0MDHt2exEe3uVikBjgApXqNDqbjRK6TkpXx0gg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=wdc.com; dmarc=pass action=none header.from=wdc.com; dkim=pass
 header.d=wdc.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=sharedspace.onmicrosoft.com; s=selector2-sharedspace-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=bzvl8LFZ8OpSAhtIwXRPOs5wM+Kyk6XTPErvXBxl8ss=;
 b=AQSWhhFU/BcwHL3se8+B/kY+E2yp75MmOSBAZ1kBz1hUQKmtB29koLvSgad356HM6Pie11izYXim1OCyBnWJYmhv1ZBcvlK9OsDP1WtKzc8L2+BO0VX/Na6+uYHqTxsjlqMmXbruwRpuHbMgBHVCb1bJcx26uncICk5uevu5k5k=
Received: from PH0PR04MB8549.namprd04.prod.outlook.com (2603:10b6:510:294::20)
 by PH7PR04MB8682.namprd04.prod.outlook.com (2603:10b6:510:24d::7)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9094.22; Fri, 12 Sep
 2025 02:13:37 +0000
Received: from PH0PR04MB8549.namprd04.prod.outlook.com
 ([fe80::5b38:4ce0:937:6d5e]) by PH0PR04MB8549.namprd04.prod.outlook.com
 ([fe80::5b38:4ce0:937:6d5e%4]) with mapi id 15.20.9031.014; Fri, 12 Sep 2025
 02:13:36 +0000
From: Wilfred Mallawa <wilfred.mallawa@wdc.com>
To: "its@irrelevant.dk" <its@irrelevant.dk>
CC: "hreitz@redhat.com" <hreitz@redhat.com>, Alistair Francis
 <Alistair.Francis@wdc.com>, "philmd@linaro.org" <philmd@linaro.org>,
 "stefanha@redhat.com" <stefanha@redhat.com>, "fam@euphon.net"
 <fam@euphon.net>, "qemu-devel@nongnu.org" <qemu-devel@nongnu.org>,
 "foss@defmacro.it" <foss@defmacro.it>, "kwolf@redhat.com" <kwolf@redhat.com>, 
 "qemu-block@nongnu.org" <qemu-block@nongnu.org>, "mst@redhat.com"
 <mst@redhat.com>, "jonathan.cameron@huawei.com"
 <jonathan.cameron@huawei.com>, "kbusch@kernel.org" <kbusch@kernel.org>,
 "marcel.apfelbaum@gmail.com" <marcel.apfelbaum@gmail.com>
Subject: Re: [PATCH v6 5/5] hw/nvme: connect SPDM over NVMe Security Send/Recv
Thread-Topic: [PATCH v6 5/5] hw/nvme: connect SPDM over NVMe Security Send/Recv
Thread-Index: AQHcIuGhcTqCkD26+UqwKX4VzXMh57SNhWkAgAFKg4A=
Date: Fri, 12 Sep 2025 02:13:36 +0000
Message-ID: <a16e627152815e95e6795ea5e685c2042910fadc.camel@wdc.com>
References: <20250911060031.124683-1-wilfred.opensource@gmail.com>
 <20250911060031.124683-6-wilfred.opensource@gmail.com>
 <aMJsjobzyBEuny43@AALNPWKJENSEN.aal.scsc.local>
In-Reply-To: <aMJsjobzyBEuny43@AALNPWKJENSEN.aal.scsc.local>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=wdc.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: PH0PR04MB8549:EE_|PH7PR04MB8682:EE_
x-ms-office365-filtering-correlation-id: f27f17af-9b15-4777-98e0-08ddf1a1fb54
wdcipoutbound: EOP-TRUE
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
 ARA:13230040|1800799024|19092799006|366016|376014|7416014|38070700021; 
x-microsoft-antispam-message-info: =?utf-8?B?akRTTDJIbEJIa2xxL1ZKWGhYendGYzJUTkJ4WEd4ZlAwdnJ4UUttSWJ1c1pp?=
 =?utf-8?B?cTc3ZjJnVXZ4YVlqSFA2RU9QaFEvVFRlN0VBdktZSHdwS2N4dklJQTNIL3RU?=
 =?utf-8?B?TVYxWCtXdXBQaGhPNnNWRHQwek5qbEMwbnA4YzdoWG9YKzFWemxMNzFqYnBy?=
 =?utf-8?B?RU01SVB3akhKdVF2RzMreTFUYWdYVjFaclhRTWpWdy90dUlZZDVIdHZlamwz?=
 =?utf-8?B?Ti9tY2FMU0ZscVBSaFBOVWtXb2FJOE4yYkpjam5YTjU5aVpSN2pFTm00aitP?=
 =?utf-8?B?MFVDVmEzU05kM3lQRjN3NHAxVGljOS9XaXJISElkR3h5Wi9ZUHg4L3B6OWVz?=
 =?utf-8?B?Wi8zbmRVVE9zTEwzamdiSGVObXZualdjU1RCbjRRVlVLUnlPMmMzZW9ndDBl?=
 =?utf-8?B?R2s0alVLdUM3NUZ5OUFRb0Rlb1huMTY3bXhQd29OS0pDZi9zZG1Zaml0WXZr?=
 =?utf-8?B?M3lKY1RGL2FObXZFL3FaOEhBbDgwSnFpUlNWcW1wMDFYblJrMHpzOTV4bUpT?=
 =?utf-8?B?SnlCTG9RTnRPVFl1emtrUCtpS3lOeTBhcG9PQ3hvYW4rYzdNZmVNa3k3TGg2?=
 =?utf-8?B?Mm9YTC81aCtjd01ScWVLMFZBY3IwU3JCSkdTYXA1UXRManBLdWJRUHU1dHdH?=
 =?utf-8?B?dmhLQkNCMDBDYTF1blo1UTZCZ3ZWM1BCSGIwODhlN0Z6TW5PR0MraFg4L1RT?=
 =?utf-8?B?ZWdSSkZsYStjMHBudTl6UXdzZGFBMFZvYzRyaUtyU2tJL2NwUUdpVXh0Q2k5?=
 =?utf-8?B?VTdKelplNTAvdWxlSDg4VkpweWJwWTMwUVd2OTJpYXhYYXVndHJzc21NOXJV?=
 =?utf-8?B?WlVpZmRtZ0NvZ1hzVjBrYy9yWGNxNWZmOTdiaHZOTHBZUFdHckxTOGhPcDA1?=
 =?utf-8?B?SFVEQkQxNlpSKzBPaHIrK3JlNEo0RGlZdjVxV2xkTjMxVzVlVmphRERHdm92?=
 =?utf-8?B?Yys3ZWVQZzNkTWNKTzZHdzZPZkExUTRZdnFqTW5GZm9JRTY1NWI1anNyM29m?=
 =?utf-8?B?TW5TZ2FNeU04QktVbUcySlRwTnZXd25aRHZUWGdsblY3RTIxUGduekxVSzd6?=
 =?utf-8?B?U0M4NmNtb0dPakMvOXRKLzgyUWIzLzlpWDd0czExUE9pWU1xenhuWWJ6NDda?=
 =?utf-8?B?TlRHQW5ER25DZVEwSXZiL3Q0ZXBDSGY4LzZIeUVnT1ZyRjN6b2ZTMnpqK0pw?=
 =?utf-8?B?bFV4dWtMRU9FdWx3eG0vK1J1bDVyMjNzc3Rxa3pDTlo5dEVmdVBRYU44c3hs?=
 =?utf-8?B?Y0VvUEluS1VQcGgreDFCVGVNQjFDQy9XMTRvTkV0TGRFbTQ2SGdTblI1OXUw?=
 =?utf-8?B?MTJrYWNTOWRRdnIrOTB4YVcwbEtXOGFFd0NRWjhma0tCWERuSHNVOWRKbTlD?=
 =?utf-8?B?MmZDZ0swWnJWUE1SRElOYzlDc0JvbnhuenBBc095T29wR05oZEh3TFFJU2hz?=
 =?utf-8?B?SGVraDhLQzBhK3dKYXhwOHFvelRJY2tTZlUwL0lGWW9QWThNZmFMY0FIMDNR?=
 =?utf-8?B?cktzWktrVUVWcXllb0oyb0FRREdrZmxaN1IxckhDbGtkZldvand2bE8veDJB?=
 =?utf-8?B?TENETVI1NFB5TFJhN1gvdkdEV0c5ZkhHaU42eDg2aExpbUZySlhIeHJzQzFk?=
 =?utf-8?B?RFNnTE1zUzJWY1o1NW5pNHlXYWZPdHJhVWNTVGZuSUhFTEtLbTJZM2hzNFEw?=
 =?utf-8?B?WEFKcG9iUFNOQzdqUXhqM09WaHlCbjRtd09TdElpb3FJaStLam9DYlF4TEFC?=
 =?utf-8?B?cjVJdmtYQWIzTzVyc0JuZ3hsNVg5OWMyQk9tVS9MRnp2TFVzeUV0VmRWSUtZ?=
 =?utf-8?B?UUZBMWg5MW1jQ2VuMFlkdDdkVmMxbzBaNE5iUmNKNDBBdS9jdWVMQ3F5NHpP?=
 =?utf-8?B?eXVJd1NrOTJydkhFVzNoZk8yb08zUk0rVG5JbGNTajRpcVBhYlRvenpNb3Ax?=
 =?utf-8?B?WkJHVUFvQ1dpODFzNURHSVFmQ1pZaDBLcUc5MmZ6SkJVUzhHb0F5cXFrcXdV?=
 =?utf-8?Q?Xm1deF+OymAHTxX6zk7lf95no6C+kc=3D?=
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:PH0PR04MB8549.namprd04.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(1800799024)(19092799006)(366016)(376014)(7416014)(38070700021);
 DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?Q0xWd0hlaU9pL2FxNTNhMXpyVHUreWhVQW5jZ0lDdWFzSU1TdVN1RStUYS9H?=
 =?utf-8?B?KzRhdFJGTGFQZ1NhMStoQzZhVG8vajROMHFGa240NUo5Vm9HVE84MkZnMlA1?=
 =?utf-8?B?ZzlwZ2VlOXdSdW9GSm1wb2FLT0krSUlpWU1tTHpldHZveW9xMlNpYzBuYlhZ?=
 =?utf-8?B?Zk55cnFJWitiWDBDVDF2ZHpEQjZxNE1jSTY4TThNbGdmSGorbTY0Mm5HNFB3?=
 =?utf-8?B?SGI3V2ZnSlR0UG5TK2EwWDkwb3BHRzZONjBOZE0wS2lSVkdWa3lZMDMzWGJa?=
 =?utf-8?B?MHd5YXRZd1NqeCs4MGpibm9VNTFYbGdYa1R0c3lVQ1g5TDl0Um42Si9oM1FN?=
 =?utf-8?B?UEg5d3RGbHZXNEp5anlidUg3UkYwRlBmRDRudzYzZXROVHBTbVdFOHBaQ2F5?=
 =?utf-8?B?Qzh6VGwranFzSWFnUXQxd3Q4dDlIeVVacDlFdWIwOHhsanZ4ekZ4TDNxRWw2?=
 =?utf-8?B?ZEx1aGVEeEswSkpzZlp2ZWRRRjNYa3pleWlhZFViVitvT3ZxZjFDZjBpUEZL?=
 =?utf-8?B?dWpIY1REU0txNi9UOFR4QkFsdU9vZFp6VjRua0Q5bGNnZnFkSFJUV3lWQkgy?=
 =?utf-8?B?YWZxRzBZM3E5QjIzZ1pPNUR4dzFaZ004QitHVFowTlNDamNnWXhYYTVNaDNQ?=
 =?utf-8?B?bUE2Tmg3UG52Y0xUODYvREREWGYzRTZiOURPY0lId09HcFBkcU9ubG5KSDdj?=
 =?utf-8?B?T25yZWdYMmk0eExIYUxXa0g5RkhvbVJZaGpCT21mT3JSNENHNnU4d255ZUFZ?=
 =?utf-8?B?bzVYb1h0UVNoOGM1UjJSVWxJZExNQ0ZsRjRDR05meklYeUlzRUsrUm80QkZm?=
 =?utf-8?B?RlNiVFZZYXluS0RZc0VITGw3elZUYWJrUm9zV2J2K0VQUjNqMGl2UmdGUEZq?=
 =?utf-8?B?dHlraVhGWlhraTl2OEJRMG8xcjFZbXFuVGRGNHhDd08xSDdCNU02UUN6QWJt?=
 =?utf-8?B?eTBZeGtVdFUwZEl6ZEQyemorczFNVko5aFlWQ2Jzb3c0WnNNdWU1aFk0U20r?=
 =?utf-8?B?dklBVGJmVGxZZDhqRGJKOWIvM2JoaGRMNzhuTVlxL2pPdGdpNStwOUF4UGY5?=
 =?utf-8?B?R0ExZ0lOZDJQb3ZFTUxTKysremJiMmw5THV0SWZESDFuYnl0b2JCczhpaHEv?=
 =?utf-8?B?OWRHWGhNRjBGYzFDUDRHTDArMXRaQ1lZVEhLZ3paWXQ0QmhnQk10NDhoZk8y?=
 =?utf-8?B?MDdGT3dUK2tJQyt2aXY1bDRnUUU2WjdzTjMrUmFXUmdHcGI0N3ArQ29GdWh2?=
 =?utf-8?B?R1BZeUkxWnFaVndKaHhpYVpBSU5kQ2lTZExmV3hna1JYRDdZaE5KSVREcmh2?=
 =?utf-8?B?NVpkU09HMlZKME5EbVZvTHF3YTNETTloWGhmSmN5cyt2SGZxUm9xV1I4N3Rw?=
 =?utf-8?B?cXQ5QktqTHFEU0VDdU5ZRzhoUHhjYy8wTTZrZUg0ZjBVZEpzSkVOeldmTEI1?=
 =?utf-8?B?OVF1dTQvaGxHR2lNdXFBS1YzdkltUEFhK3plUHFML1N5Um01dGV6dDd3d1pI?=
 =?utf-8?B?YXJ6Y0M5dlpKWVNpNXlkMjBRNlpvUmYxRmxibDgwM2s4SFEwMjZOTUdPaWxG?=
 =?utf-8?B?MGtuVDNZdjVwL1pXS0NsS0Jha2xjVXQxM3AzVWltbFhIOVE4c0dIZFlST3Fo?=
 =?utf-8?B?ZFlqaHZzeDJBZGNmNWpUZkhJNzAwT1R3RnI5enpDUzdOaUNySkJPTzZOelpQ?=
 =?utf-8?B?c3IraHFBdWV4czEzTmVFeHcyelRidVhvbDVyN1kyZlpuSjlNcmpnejFVSkVJ?=
 =?utf-8?B?dmxUbXQ5akk1VmpRM3VBNlYyZUJOZ2FjVWNmeVA5Y2xaR2UrSkozUjFHQXNk?=
 =?utf-8?B?WTVFdVBsMVRibTRjM3BQcitwT2Nma1QxU1pmTkZJalp3cXVqdEM1MERud1dh?=
 =?utf-8?B?NysrL3JIdE5vaDBWKzNMWlVNTFNzQURnU3RzNExkdHhvY1QyYzR3Mk1zZ1ht?=
 =?utf-8?B?bHF6K3pTMTVmcGNSdXp3MlJQUjVwbVRhMVV4Q2c1a2pwd3c4TEdaZlNuMkIx?=
 =?utf-8?B?blE5eFNORlNJUnB2a2l4dWZIU0xoV1EyUmY2cHVnWDA4cGo4SmJhWXFuTGpu?=
 =?utf-8?B?OENCQUhzb05ndUFVajMvMm5oRjBLeU9JWGxIbUl6cXBqSDVkdVM5MFREajAr?=
 =?utf-8?B?eFgvS3AwbTgxY2hXRHVMc2svandtKzhRREt1NFd2Y1JQZDR4WStKdTZUMU9s?=
 =?utf-8?B?b1E9PQ==?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <4A687609BABFF74BB68D8ED08EB79E6F@namprd04.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: zh0SEDOQ30w1i8U0JYGS4MOtFlU6jcnRGB4gG5HPWbFbgwHFq2ovIsPy+XmtHt3C7rDn1jrsXG6RXuw8q0Boo7PdOpzy8lr0dEFnpDRUFE7FoKJZVO5wTDxnad3D7ngXxRArAD57WtbNUdKo1nDYBHYSbEC0ljqzGpaPFYmJ0LUSl0FEIgu7c1G2o3cL7Vt7KGm6emSygxORnfnxISjFMH1xXdmIgRjXqNDxg6kQu5kq0ZFTY7SGUJl2qSWTViTlAcppmkv9UaS2ruNUHwwS8aoruAArGjhhYowZ1Fny34BPQmgRStz6GqsDGZ2CLu7rDzEQD0U4AchHcFiR/D+Jj3IWGYdFldLWd1svtu2eo/Tl4nwTnSWXkKZIblvrF5LsIlwFq5ErfExQGmxFoUCiiduzyaPVuoleDV7MTG07VQIsE7t5wcP+q2neMhh3jjUxvRq16C9CiMKSTlMbN/NXX6bORP5kQFcQw29K4Ep0aToddv++V0ALvnvrJgs5i3x7LJ8URq4/BsnB3p2Xi9EsPgvD6VR3M3us/69mA2GF80gA0aUNyUpwsOesAtJlV0T+frr+mcVzy8fIf3cpJAZhkCRn/3udjVM3PnftUGvDLwal42TTepq+V45wecVh/dsC
X-OriginatorOrg: wdc.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: PH0PR04MB8549.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: f27f17af-9b15-4777-98e0-08ddf1a1fb54
X-MS-Exchange-CrossTenant-originalarrivaltime: 12 Sep 2025 02:13:36.4526 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: b61c8803-16f3-4c35-9b17-6f65f441df86
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: y4GY14WsqjSBmcyt/g7D40mTjW+dId67Mx3hiQVhlberMNeLUqftCwrifJR+X9tTahd6gK033ifTGhUmghJhEA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH7PR04MB8682
Received-SPF: pass client-ip=216.71.153.141;
 envelope-from=prvs=343c7b6c6=wilfred.mallawa@wdc.com; helo=esa3.hgst.iphmx.com
X-Spam_score_int: -43
X-Spam_score: -4.4
X-Spam_bar: ----
X-Spam_report: (-4.4 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_MED=-2.3, RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001,
 RCVD_IN_VALIDITY_SAFE_BLOCKED=0.001, SPF_HELO_PASS=-0.001,
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

T24gVGh1LCAyMDI1LTA5LTExIGF0IDA4OjMwICswMjAwLCBLbGF1cyBKZW5zZW4gd3JvdGU6DQo+
IE9uIFNlcCAxMSAxNjowMCwgV2lsZnJlZCBNYWxsYXdhIHdyb3RlOg0KPiA+IEZyb206IFdpbGZy
ZWQgTWFsbGF3YSA8d2lsZnJlZC5tYWxsYXdhQHdkYy5jb20+DQo+ID4gDQo+ID4gVGhpcyBwYXRj
aCBleHRlbmRzIHRoZSBleGlzdGluZyBzdXBwb3J0IHdlIGhhdmUgZm9yIE5WTWUgd2l0aCBvbmx5
DQo+ID4gRG9FDQo+ID4gdG8gYWxzbyBhZGQgc3VwcG9ydCB0byBTUERNIG92ZXIgdGhlIE5WTWUg
U2VjdXJpdHkgU2VuZC9SZWN2DQo+ID4gY29tbWFuZHMuDQo+ID4gDQo+ID4gV2l0aCB0aGUgbmV3
IGRlZmluaXRpb24gb2YgdGhlIGBzcGRtLXRyYW5zYCBhcmd1bWVudCwgdXNlcnMgY2FuDQo+ID4g
c3BlY2lmeQ0KPiA+IGBzcGRtX3RyYW5zPW52bWVgIG9yIGBzcGRtX3RyYW5zPWRvZWAuIFRoaXMg
YWxsb3dzIHVzIHRvIHNlbGVjdCB0aGUNCj4gPiBTUERNDQo+ID4gdHJhbnNwb3J0IHJlc3BlY3Rp
dmVseS4gU1BETSBvdmVyIHRoZSBOVk1lIFNlY3VyaXR5IFNlbmQvUmVjdg0KPiA+IGNvbW1hbmRz
DQo+ID4gYXJlIGRlZmluZWQgaW4gdGhlIERNVEYgRFNQMDI4Ni4NCj4gPiANCj4gPiBTaWduZWQt
b2ZmLWJ5OiBXaWxmcmVkIE1hbGxhd2EgPHdpbGZyZWQubWFsbGF3YUB3ZGMuY29tPg0KPiA+IFJl
dmlld2VkLWJ5OiBKb25hdGhhbiBDYW1lcm9uIDxqb25hdGhhbi5jYW1lcm9uQGh1YXdlaS5jb20+
DQo+IA0KPiBMR1RNLiBPbmUgc21hbGwgbml0IGJlbG93IHRoYXQgSSBjYW4gZml4IHdoZW4gbWVy
Z2luZyBpZiBhbm90aGVyDQo+IHJldmlzaW9uIGlzIG5vdCByb2xsZWQuDQpIZXkgS2xhdXMsDQoN
CkkndmUgc2VudCBhIFY3IHdpdGggdGhpcyBhZGRyZXNzZWQuIFRoYW5rcyBmb3IgdGhlIGZlZWRi
YWNrIQ0KDQpSZWdhcmRzLA0KV2lsZnJlZA0KDQpbLi4uXQ0K

