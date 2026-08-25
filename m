Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 069ABC5B572
	for <qemu-devel@archiver.kernel.org>; Tue, 25 Aug 2026 04:04:39 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wyiOI-0005ef-QZ; Tue, 25 Aug 2026 00:04:02 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1)
 (envelope-from <prvs=690dc056c=Alistair.Francis@wdc.com>)
 id 1wyiOG-0005eQ-Vp; Tue, 25 Aug 2026 00:04:01 -0400
Received: from esa1.hgst.iphmx.com ([68.232.141.245])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1)
 (envelope-from <prvs=690dc056c=Alistair.Francis@wdc.com>)
 id 1wyiOE-00078Z-Kb; Tue, 25 Aug 2026 00:04:00 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
 d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
 t=1787630638; x=1819166638;
 h=from:to:cc:subject:date:message-id:references:
 in-reply-to:content-id:content-transfer-encoding: mime-version;
 bh=QBCy6J57ufw6Bty8qJyWROjXm4/GULgFX3kyLZ/eQW4=;
 b=j0Nnb7xEjQK9zw0zu45xslCI4+L4Gyq/Df3GyK7rlUqqofgwiW8OmBFB
 4dx5j9MMTN0bw4VEOD15yghEYEt5i5uQKxGI0q2QRajecockP8IYp2SWB
 ya7SZ5zDRve08il9fy210AS3xSmYIu3PuTWYda98/snOBfeiUYWyYzBTO
 dW2Od9ZZOn7/htAgMGjxMLmA/fwsI8PZoyYgA+z3eHlU0Ce6ZcbIkr+zs
 fjm1u0tNywBuqfr8rve4Xr4mnbQcsvZhfYGWcUIYRewOPdDkxJqitzjRU
 fvi7X5Knwq7LEoFIX3rrXqSpXncGlkgD6YRg2M1P7JWB3PhoGQmv5BrA9 w==;
X-CSE-ConnectionGUID: 7tT0lrLTSSmCd53nieAg5A==
X-CSE-MsgGUID: S5ghiSGeQO+l480e9RO/4g==
X-IronPort-AV: E=Sophos;i="6.25,241,1779120000"; d="scan'208";a="153972640"
Received: from mail-westus3azon11011053.outbound.protection.outlook.com (HELO
 PH0PR06CU001.outbound.protection.outlook.com) ([40.107.208.53])
 by ob1.hgst.iphmx.com with ESMTP/TLS/ECDHE-RSA-AES128-GCM-SHA256;
 25 Aug 2026 12:03:53 +0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=m+MCCC/b8Md0tVVb1afLlViv8GjYkqFeXpRfzIBPdUAN4eAIAP9e3w/X1QIOUKso9uem/Y1+TnSqyI9gSO5i2azOnd1tEtim8GBunlvAf5PLvq//eGP3hdjKYDwR3g3eBTcZjwxPRPiHYSx/vEfkaaHdZiKnuWdfa/XQN8VEoZBnggyBmp1SAqou2hSyyX6XsyU4mEpM6MBxj1/HRjaRSeVlF/KRagJiyx+BnhzgFPVP9KrzeqBGe/m5/fHzgRvRRPLxbn3+NcGGDrW6ihR82xOa9PV+Rmo9NE968+VG+V6z0IGFQCUXyyyZKnnjIaN4b9smWE/pv5AjNDWj7o07Ew==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=QBCy6J57ufw6Bty8qJyWROjXm4/GULgFX3kyLZ/eQW4=;
 b=McFtoiHL3I0h2cg2lq0jtBs1H+A58mvixhLZ6VPFwxiK6vpFofMihbrd65IqJlVEyOoPYf66UjD+COD3MNdK3QThZIEZrPw73LDp0MHq3AZWcqd2VW4J1UYKWJbbwl5PiHpk40VXrvj6eC0zUK+wa+cjS10DFFQIOfUXtE9PASm1ZdA8s6VCf8F7s6FRV5BLyAgsOcM2bVc3QPxhpqOrIgADumP4aG6H6TvI57v0Jdc/KXj6hyxGj4lZgGHv0iVWddaCUNBDJpo8RM1N42BfXzm6IIqtzLBx5l60i1pnQsg5pQF9NzsKC8UEEqCsvrKgoy7Ogxli1lZPCPNJ8z9QJQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=wdc.com; dmarc=pass action=none header.from=wdc.com; dkim=pass
 header.d=wdc.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=sharedspace.onmicrosoft.com; s=selector2-sharedspace-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=QBCy6J57ufw6Bty8qJyWROjXm4/GULgFX3kyLZ/eQW4=;
 b=FsPLOdXymB7J9hDcbfVXRimj1Efmp6TclskHqVoeq6JCgFOkpo5wsQu6mKCrwKWzrS2lC1Iv7IY2wRWCF/6BXABod7ejewRFvSVYEQh5HHBh/wxBWKUYdbS0EU2Mwubzq5JYcfa/qAtTXViz3KAkMERp3cQf3eU0mQV4VSSNH2Y=
Received: from BY1PR04MB9561.namprd04.prod.outlook.com (2603:10b6:a03:5b6::11)
 by LV0PR04MB9859.namprd04.prod.outlook.com (2603:10b6:408:32a::21)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.339.12; Tue, 25 Aug
 2026 04:03:38 +0000
Received: from BY1PR04MB9561.namprd04.prod.outlook.com
 ([fe80::3869:e494:2fa8:9888]) by BY1PR04MB9561.namprd04.prod.outlook.com
 ([fe80::3869:e494:2fa8:9888%5]) with mapi id 15.21.0360.005; Tue, 25 Aug 2026
 04:03:38 +0000
From: Alistair Francis <Alistair.Francis@wdc.com>
To: "daniel.barboza@oss.qualcomm.com" <daniel.barboza@oss.qualcomm.com>,
 "qemu-devel@nongnu.org" <qemu-devel@nongnu.org>
CC: "qemu-riscv@nongnu.org" <qemu-riscv@nongnu.org>,
 "chao.liu@processmission.com" <chao.liu@processmission.com>,
 "liwei1518@gmail.com" <liwei1518@gmail.com>, "zhiwei_liu@linux.alibaba.com"
 <zhiwei_liu@linux.alibaba.com>
Subject: Re: [PATCH 0/5] target/riscv: support Debug 0.13 and 1.0
Thread-Topic: [PATCH 0/5] target/riscv: support Debug 0.13 and 1.0
Thread-Index: AQHdJQfGmBVWjgIh7U+NxUIVx6GckbauQ1mA
Date: Tue, 25 Aug 2026 04:03:38 +0000
Message-ID: <c8d1d6adb2cfbb409ce257171cebdf0421d9a27a.camel@wdc.com>
References: <20260805182506.2943757-1-daniel.barboza@oss.qualcomm.com>
In-Reply-To: <20260805182506.2943757-1-daniel.barboza@oss.qualcomm.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
user-agent: Evolution 3.60.2 (by Flathub.org) 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=wdc.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: BY1PR04MB9561:EE_|LV0PR04MB9859:EE_
x-ms-office365-filtering-correlation-id: 8d0d5cad-6592-4683-4f42-08df025dd7ce
wdcipoutbound: EOP-TRUE
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
 ARA:13230040|366016|1800799024|19092799006|376014|10070799003|23010399003|22082099003|18002099003|11063799006|56012099006|38070700021|10067099003;
x-microsoft-antispam-message-info: AmFeKKT1yn7I9EmmlKEdwFy1gWAkn+yY6H96/5nC/sK4myTN5k0Ew/Tsuc5ibOfu+FCDNm7YzxT/GnqRqlUxKe/nYXOzJzeJJPbIQOhEJT9XocU+lyHy0FNJsYjk9vW8gbRE2tUIL7JI3BXdJRchV74nwYuYl+LlCehDtUwgU4djpXKp3KHcPFW75VBeBS2AXhwkj+C9iIHvOR9vocvzrbSxLsFNyEcGch6RMjVhEXD4S29CjRV8Xl1UdUpzWeKRc051m2D0dR7xbT5krntfiuNFKpY7EQom8/OP+OqJyRcN9bZuRKgjVnkOKE5crzZV8rN29nZ4Ig0dbz7Q5WP+hWfxqnyy3JbevOGVRzxGk1WWn5AFv884HMxR85C6iwQFgDm4QIJyc5TSp38uNNXIzVgv3kY1/25dEk80bwj+889y6OwZLHu2GKXTbUZfDbcwU2sfMPQC7QyPYVKkat/nHOlyVDEYT4gF6f/14PTKx+rpahBj72UUvDSmNhlvM7U3oIboP+unLep3a4ZDmaL1k4DubD0jmeUGb1bEgBml0nKzklZw9tjVcn82udl/VryVGBKybyPLwRysRztZZOUg25DeyTc/LXqd7itlwrZeEh2fLjUH0E9FyVxYSLfjRpoLOy1G08Yvyf2vpEx7E4hHuYEiy+8P0kYkgitF0DF/0is=
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:BY1PR04MB9561.namprd04.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(366016)(1800799024)(19092799006)(376014)(10070799003)(23010399003)(22082099003)(18002099003)(11063799006)(56012099006)(38070700021)(10067099003);
 DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 2
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?aGMzQzZNUGJtNngzaFlJVFQwc0VRckl3MmVMdkJReU1kRldIbFg0WjNTU1V2?=
 =?utf-8?B?ZEhpZzluY213aTdER3h1Ui9qZ2VraFlid0RXT2ZzU1J0ZjMwdGpNaTc0dEQ2?=
 =?utf-8?B?ajhzM1ZkMWJpZUZoandJYSs3QUI5WnhWM1pqcm12UjczdmFaNHVyQjdRZXRN?=
 =?utf-8?B?eVJSKzczZHd6bmRpcWVEMXYxV3BBSTdzMStJUG9hNUVVd1lyVmhLOXJDeTl3?=
 =?utf-8?B?WGU5OGEwaTZDN3B0SU1TVWt4ajdOTXg2U3d2YlAvZVJKV0VFSDhKWkNSdHdy?=
 =?utf-8?B?amM0RkUwUTF4WWxPY2NxUFY0am9sZWlySFBYV1FhMU9SZEpMS1phb2ZhR2x3?=
 =?utf-8?B?S0ZLTW5hODdEK2tXalhYR1ZDSVZkN2pKeldoMlBSVXRpOHU1ZE13M09OYVh5?=
 =?utf-8?B?Q0ZwNnRLeUp5SXJtRzBqSVk4a2VldjNEM3pQczFtYXJ3b05nT2hBNi9USGgv?=
 =?utf-8?B?bUVaMmh3a1JrRUhRQTNkazBpMXExcEZSU3ZrZFNsY0tVYkdkTFBGSllaVjVV?=
 =?utf-8?B?TXU2VE1pQ0oyLzlpc1l4Q3NrMFdFbXE1TXY2a0c3VXpvNDBhYVc5OXdqV1Aw?=
 =?utf-8?B?QjhpL1pDZitvOCt2OUpCMHhDT1lMQ015VGdmSjY4eWFyVFV0dUhHTEFleVIr?=
 =?utf-8?B?eFpjaEZqZ21ncXVHU0dlYU8ydWhCNjFLWVBaWVB2MEM2N2NSQ3ZvWnlIVmZB?=
 =?utf-8?B?UENxMktLOGQzQ1FhcmM1RE9LeDFHdTZkdDdpdUg4ZnQ4WTE0WGs4RDYzdGZB?=
 =?utf-8?B?ejBKcHRHOEpvWkh2bHNJWlQyUnplZGVSbW1hekxoOVlaZzdTVjJXUkV1ekdn?=
 =?utf-8?B?Tm5EL3lMUGtqSVgySzQ1YllEdG0zRUk3Smc1dGl5bmVtYWpsdDROVEQzNkdD?=
 =?utf-8?B?UzFIWTVBck51N05FNFRSYUxEUUpiM2FKeENGeWtwUFhiaklOam5hYjJXa2RD?=
 =?utf-8?B?THdoZjd6aWd0UEVhblA4ZDBZWHk2UnJuR0JVU0V3TGlRNjJYS3I3MjlRYnF2?=
 =?utf-8?B?SkQxajV4L1F1ZmtXMWVNM0xjVVgzUWQvLzJxajk4TUtjTXFIYXduZTVEZld6?=
 =?utf-8?B?bXl2b3RVaTFKSWdaZFUxZ2ZiTzlDb3ZiYzM4blhjd1c3aXNCZDRZU0VYaU5w?=
 =?utf-8?B?L1ZoVFllYTQxTVczc0owTWFsa2ZiOURMSkxURDZxRHlFM1lhZzlQKzJ0M0E3?=
 =?utf-8?B?ci9xMjlPYmJWQlRpY0d2SFQyNzRjUVVXNkZQcGhkeU1iMmg3WnRPVFVscFZ5?=
 =?utf-8?B?cURWdnNDdFFVWjAySGhmNkJVY3lPbTMycUxYUU1YN25OTzlFSVZyaE5Mbkxu?=
 =?utf-8?B?bkRibUVDL0N2b2haOW1jR0EvekNZMmVRN3RkUk5NcXJOYzVUdUhzeXJNbVUy?=
 =?utf-8?B?WEVta3V3a2JCdGR5cnQvb2VKemp5L0VkMHZmWlRUbmo1Q1NMSnorMllFZi9H?=
 =?utf-8?B?SUIxRXk1YlIwY25RVlJlVUQ4TGJ3Tnh2N1ZmRkhmRzRJWFByZnY1S0ZiUWdj?=
 =?utf-8?B?V2s0c1RqcjM0aWc3ZlhpamJQUE5scEg2SDZ4ZlZwRVl6TDNCVENxQUlBa01v?=
 =?utf-8?B?c3UwK0dPZnlickNzSjdkaWY4dEtwZjhLb0NPVkg1YUlUbys5TjQyZFczZ3Ux?=
 =?utf-8?B?TjRvekVrbEtIeUdrN2EyNXE2WkU4YnM0RktOWWRIeThzNVU5M3ZLc1NkbVM3?=
 =?utf-8?B?cmY2N0VuSG85N1ZxQzNJSG52K1NpeVZ5UTVLQTNtYjZlazhGQnIzN2MrNzll?=
 =?utf-8?B?SG1KTmRUc2hKNjdJV1pXb1RjS3lIaGo3NlphNk9nMlF0Tk1GcFhFYzNudURE?=
 =?utf-8?B?ZVdLRjhzVjdNWDJZb1FvekFLZURaNGF4UThUcVUxQzltT1RMeGRRUFFSdGZy?=
 =?utf-8?B?VlNFaGliYzFTVXdQdFE2OFZHL21lQUdBbTF2WXNHcnA1SHpWYUdEejBPeENI?=
 =?utf-8?B?ZG5ka2EvdmQ1REYrKy9PL2lVTXNtQVk4OGIwM0QyMU9YYjFNVm1LbnA5U2Iz?=
 =?utf-8?B?MTdaRm5aRDI1Vnk0QTdNSmFoQVRqUytvRW1kMjlmdmNvd3B4VW1DVDl5cTlj?=
 =?utf-8?B?aWdjNkswMjRQdUlpdUJ2TEdDY1J0Mi80UWNDSVdmMWZvK1ZjWExzUHNsRkhv?=
 =?utf-8?B?VHAwZU5IMU1Ea3hBdEJKZGFLSERRZVRTaTQ1OU5IRUMzcnE0TmF4aTdDVXNx?=
 =?utf-8?B?bjZyL3ViRkRJVWVzbDJIRW5YVzJUUUtXdVhrYk1pRyt3Y1pSQmRNMmZROEFV?=
 =?utf-8?B?dGdOSWRtS2htaTRaR2VaNnNjbGowN29uQjl5QzVRNlN5SHJCdjJRVSttNktr?=
 =?utf-8?B?bURYSVl3K0hCcWtobkhUVlJuaXp5Ylc1bStRVTRYSlJrakEvTzNuNkhDZ3pv?=
 =?utf-8?Q?leQ2Y7+vBwvSmGEsyBMdPgcHw8TTnZBZ76VNRNaw5LQ+u?=
x-ms-exchange-antispam-messagedata-1: OIaMHsV5qoeN8rucFYGhTCt6o6igL8+74F4=
Content-Type: text/plain; charset="utf-8"
Content-ID: <D32C4C5A94AAC047B9AA7D0C1FA29368@namprd04.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-Exchange-RoutingPolicyChecked: IByV1g2tON6JpuYuyNoOfRdN+mgXpkaytsVw5zPTwb6a67OZS9xj7R8hFRqpZF+eQdW+1SAFBPuvj1LHgLh/COkDkf5xMuVA36kSzdCcBk2pWN1fGWJqga/E5aoUeEnleO0BGLUXg/8TzDpxJuUVFKVVdnhiIJw6WyCgGedOrAIk6r0rzfoZ5O6EC+zNi6jDNW4epI85oIZ3t7pv/CDJ+J0r3Uo0gIV/ybF+XSHOgPY8R3GYzpyjNaacYEedFnyQ03vv3ezmiuHIG2m4hUQopRsWk8znQfnWjoxYD5vc2a/64jdKoDV2+LAbKlId7ahIgTNZuoqsv/eeaPBCpuRyQA==
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: Ww2wdDCQ0mgi1XgEu8X/rOgJPI7k2Lk+lq0dRCHTWrDWBmgqLcVJZKnu0AJe1GiIA0UvaMFJArdYJ3k8PM6jx1pYVOIRKhUDNLU47xzfYfu+CtLj1sgLNZ8gyyIL89VPMh+kSGY395gScswnlrDJVj2sDI3FB1CY03RoASL9ET3fGNiD7B3JkAfGNsCi4X5z7zSQe92EhIRxqNSiCBef5Yl5CeKa5S2JmResQ8XQ1srQURDF3ibujngUoFBEAlCjCfqwwStqBDuc6L3ItOZDp0tdo9gXmWcRG+PJiTzVNV4epibFMHci8O/4zwM3+ETNg8by3KKnXu5kf8XqVcKfMzjFR+QVm7uO9V5gJ32k0cKFW5wMTjTRGPk3hY8a4xvhqf8A9pMOi6SFglvxb0M4I44zf+3L7FFmnRY/5c68e1+hADfSRv7axXC+NWEntiUjW5OKr6E19tkfUgpsEKm1ta0xHP8n59rJyKcFghU8J7mgABwX4JyBiCckchJsC6EKLrfYw9gw5WAPE//t9p3Ix797y+McR/WRSdiUT0J2ViUPzT1YjGclEnKwYDgArOoCrEJ90oJmKmXjBkENJTbHU1MG97Ck4P6SOw/7j+zw8hWgI2qeR1A0pSKEECuKXYE0
X-OriginatorOrg: wdc.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: BY1PR04MB9561.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 8d0d5cad-6592-4683-4f42-08df025dd7ce
X-MS-Exchange-CrossTenant-originalarrivaltime: 25 Aug 2026 04:03:38.5299 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: b61c8803-16f3-4c35-9b17-6f65f441df86
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: zGNgxY7izKSWfkJSHsXe0Dh3Db0u7S7lQq3mbhLxT44JJE+PNRp4KSvD6ujhFETXtO9GsgX/RNXfCSd+m8SW6lfySBGXaeoAvLEi0aAovLI=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: LV0PR04MB9859
Received-SPF: pass client-ip=68.232.141.245;
 envelope-from=prvs=690dc056c=Alistair.Francis@wdc.com;
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

T24gV2VkLCAyMDI2LTA4LTA1IGF0IDE1OjI1IC0wMzAwLCBEYW5pZWwgSGVucmlxdWUgQmFyYm96
YSB3cm90ZToNCj4gSGksDQo+IA0KPiBUaGlzIHNob3J0IHNlcmllcyBhZGRzIHN1cHBvcnQgZm9y
IERlYnVnIDAuMTMgYW5kIERlYnVnIDEuMC7CoCBUaGUNCj4gbW90aXZhdGlvbiBpcyBzaW1wbGU6
IHdlIG5lZWQgRGVidWcgMS4wIHRvIGNvbXBsZXRlIHR1ZSB1cHN0cmVhbWluZw0KPiBvZg0KPiBz
ZGV4dCwgd2hpY2ggaXMgYWxyZWFkeSBmdWxseSByZXZpZXdlZCBhbmQgYWNrZWQgZm9yIGF3aGls
ZSBbMV0sIGFuZA0KPiB0aGVuIHByb2NlZWQgd2l0aCB0aGUgdXBzdHJlYW1pbmcgb2YgdGhlIFJJ
U0MtViBTZXJ2ZXIgUmVmIGJvYXJkDQo+IChjdXJyZW50bHkgb24gdjg6IFsyXSkuDQo+IA0KPiBU
aGUgd29yayBpcyBiYXNlZCBpbiBzZWN0aW9uIDEuMi4xLjIgIkluY29tcGF0aWJsZSBDaGFuZ2Vz
IGZyb20gMC4xMw0KPiB0bw0KPiAxLjAiIG9mIHRoZSByYXRpZmllZCAxLjAgc3BlYyBbM10uwqAg
SXQgZW5kZWQgYmVpbmcgc2ltcGxlciB0aGFuDQo+IGFudGljaXBhdGVkIGJlY2F1c2Ugd2UgZG9u
J3QgaW1wbGVtZW50IG1vc3Qgb2YgdGhlIHJlZ2lzdGVycy9iaXRzDQo+IHRoYXQNCj4gYXJlIGJh
Y2t3YXJkcyBpbmNvbXBhdGlibGUuwqAgSSBhZGRlZCBkb2MgY2hhbmdlcyB0byBleHBsYWluIHRo
ZQ0KPiByYXRpb25hbGUgdXNlZC4NCj4gDQo+IEFmdGVyIHRoaXMgc2VyaWVzOg0KPiANCj4gLSAn
ZXh0X3NkdHJpZycgcmVmZXJzIHRvIERlYnVnIDEuMC7CoCBUaGUgbGVnYWN5ICdkZWJ1ZycgZmxh
ZyByZWZlcnMNCj4gdG8NCj4gwqAgRGVidWcgMC4xMzsNCj4gLSBzZXR0aW5nIGJvdGggZmxhZ3Mg
ZW5hYmxlcyBEZWJ1ZyAxLjAsIGkuZS4gJ2V4dF9zZHRyaWcnIHRha2VzDQo+IMKgIHByZWNlZGVu
Y2UuDQo+IA0KPiBNeSBob3BlIGlzIHRoYXQgdGhpcyBzcGxpdCB3aWxsIG1ha2UgaXQgZWFzaWVy
IHRvIHRvIG1vdmUgYXdheSBmcm9tDQo+IERlYnVnIDAuMTMgaW4gdGhlIGZ1dHVyZSBvbmNlIHRo
ZXJlJ3Mgbm8gbW9yZSBkZW1hbmQgZm9yIGl0Lg0KPiANCj4gUGF0Y2hlcyBiYXNlZCBvbiBtYXN0
ZXIuDQo+IA0KPiBbMV0NCj4gaHR0cHM6Ly9sb3JlLmtlcm5lbC5vcmcvcWVtdS1kZXZlbC9jb3Zl
ci4xNzc1OTU5MDk2LmdpdC5jaGFvLmxpdS56ZXZvcm5AZ21haWwuY29tLw0KPiBbMl0NCj4gaHR0
cHM6Ly9sb3JlLmtlcm5lbC5vcmcvcWVtdS1kZXZlbC8yMDI2MDYxMDIxNDEzMy4xODgyNTYzLTEt
ZGFuaWVsLmJhcmJvemFAb3NzLnF1YWxjb21tLmNvbS8NCj4gWzNdDQo+IGh0dHBzOi8vZG9jcy5y
aXNjdi5vcmcvcmVmZXJlbmNlL2RlYnVnL3YxLjAvX2F0dGFjaG1lbnRzL3Jpc2N2LWRlYnVnLXNw
ZWNpZmljYXRpb24ucGRmDQo+IA0KPiBEYW5pZWwgSGVucmlxdWUgQmFyYm96YSAoNSk6DQo+IMKg
IHRhcmdldC9yaXNjdjogc3BsaXQgJ2RlYnVnJyBhbmQgJ3NkdHJpZycgZmxhZ3MNCj4gwqAgdGFy
Z2V0L3Jpc2N2L3RjZy9kZWJ1Zy5jOiBhZGQgRGVidWcgMS4wICdwZW5kaW5nJyBiaXQNCj4gwqAg
dGFyZ2V0L3Jpc2N2L3RjZy9kZWJ1ZzogYWRqdXN0ICd0aW1pbmcnIGJpdCBmb3IgRGVidWcgMS4w
DQo+IMKgIHRhcmdldC9yaXNjdi90Y2cvZGVidWc6IHNldCB0aW5mbyB2ZXJzaW9uIGlmIHNkdHJp
ZyBlbmFibGVkDQo+IMKgIGRvY3Mvc3BlY3M6IGFkZCBSSVNDLVYgQ1BVIERlYnVnIHN1cHBvcnQg
aW5mbw0KDQpUaGFua3MhDQoNCkFwcGxpZWQgdG8gcmlzY3YtdG8tYXBwbHkubmV4dA0KDQpBbGlz
dGFpcg0KDQo+IA0KPiDCoGRvY3Mvc3BlY3MvaW5kZXgucnN0wqDCoMKgwqDCoMKgwqDCoMKgwqDC
oMKgwqAgfMKgIDEgKw0KPiDCoGRvY3Mvc3BlY3MvcmlzY3YtZGVidWcucnN0wqDCoMKgwqDCoMKg
wqAgfCA2OA0KPiArKysrKysrKysrKysrKysrKysrKysrKysrKysrKysrDQo+IMKgdGFyZ2V0L3Jp
c2N2L2NwdS5jwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgIHwgMjEgKysrKysrKy0tLQ0K
PiDCoHRhcmdldC9yaXNjdi9jcHVfY2ZnX2ZpZWxkcy5oLmluYyB8wqAgMSArDQo+IMKgdGFyZ2V0
L3Jpc2N2L21hY2hpbmUuY8KgwqDCoMKgwqDCoMKgwqDCoMKgwqAgfMKgIDIgKy0NCj4gwqB0YXJn
ZXQvcmlzY3YvdGNnL2Nzci5jwqDCoMKgwqDCoMKgwqDCoMKgwqDCoCB8wqAgMiArLQ0KPiDCoHRh
cmdldC9yaXNjdi90Y2cvZGVidWcuY8KgwqDCoMKgwqDCoMKgwqDCoCB8IDUxICsrKysrKysrKysr
KysrKysrKysrKy0tDQo+IMKgdGFyZ2V0L3Jpc2N2L3RjZy9kZWJ1Zy5owqDCoMKgwqDCoMKgwqDC
oMKgIHzCoCA2ICsrLQ0KPiDCoHRhcmdldC9yaXNjdi90Y2cvdGNnLWNwdS5jwqDCoMKgwqDCoMKg
wqAgfMKgIDMgKy0NCj4gwqA5IGZpbGVzIGNoYW5nZWQsIDE0MiBpbnNlcnRpb25zKCspLCAxMyBk
ZWxldGlvbnMoLSkNCj4gwqBjcmVhdGUgbW9kZSAxMDA2NDQgZG9jcy9zcGVjcy9yaXNjdi1kZWJ1
Zy5yc3QNCg==

