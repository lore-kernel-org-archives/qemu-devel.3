Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E411FD1CA38
	for <qemu-devel@archiver.kernel.org>; Tue,  5 Nov 2024 06:39:01 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1t8DCJ-0005pt-Mu; Tue, 05 Nov 2024 01:37:52 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <clement.mathieu--drif@eviden.com>)
 id 1t8DC0-000557-47
 for qemu-devel@nongnu.org; Tue, 05 Nov 2024 01:37:33 -0500
Received: from smarthost3.eviden.com ([80.78.11.84])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <clement.mathieu--drif@eviden.com>)
 id 1t8DBv-0001uc-S5
 for qemu-devel@nongnu.org; Tue, 05 Nov 2024 01:37:31 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=eviden.com; i=@eviden.com; q=dns/txt; s=mail;
 t=1730788648; x=1762324648;
 h=from:to:cc:subject:date:message-id:references:
 in-reply-to:content-id:content-transfer-encoding: mime-version;
 bh=vqqFNzUEzIGEoXNsUaQHYvgqO7V2nRZnPV3ZMjA9tkI=;
 b=faH5E8WKKUWRA2w9z/fZfbUlMVFC+/5J9igkUHo8EArEYdTlZVmK5lPY
 D8tZOyyTch15sQf8X4N4kWMGbYJkhzztIGGV9xQuNw740LDqVwu01zeeh
 k4iGxEtDXFJa7z7RRXP/kEGtS1FDbV8GS4RF8GjGl93hN6Cxl/2qLbDGy
 ZBOst7ipYamlGZoWwDVDqSi0eRyExvinFm3snRdxm2GpdhrAax3/glzpq
 jugOvAdW3igN13vcH2zTcZ4D6ADHp9YK1nmMkg4b7B2tP2llKSwnHWO5L
 5nOMD9noJm/IhRl/UZlCxRGUqBURhKx5vXjB2vVz1qwiSrQgPl9swSIXt g==;
X-IronPort-AV: E=Sophos;i="6.11,259,1725314400"; d="scan'208";a="23825582"
X-MGA-submission: =?us-ascii?q?MDEPEc8Dq5LYl8HjgacOq/nQZLNPJNBb8bCAyq?=
 =?us-ascii?q?EZPab+IJFspJG/yzV7T6h8usSobLA4qZXkE1yqThX7vATeIvUhRUpxKu?=
 =?us-ascii?q?tYChFPIWYLd7DV+5c8Cx8eCYKmVJTg1fVbPvZy6cp3yzEG7mf29osOpT?=
 =?us-ascii?q?9C57ALNMJn3MNVAWXrQ6X2qg=3D=3D?=
Received: from mail-am6eur05lp2108.outbound.protection.outlook.com (HELO
 EUR05-AM6-obe.outbound.protection.outlook.com) ([104.47.18.108])
 by smarthost3.eviden.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 05 Nov 2024 07:37:25 +0100
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=ToUmQRiG/sHhmsFRl+X/fp+7WSGLZHx3MCENaedhqL0sB0vy5h4UUNUe2JYRh+62do86ee8s4e6l2KlGEfS2OuNzj0MtIrfL6G9Rgm7si0J7JFokQ4kr/7rxDE9fOJHzbg6uy9X+KUesnmhpg3sNug+Tq3XejCce+OdCiVi3BlHdTxk0h67v+xKQoezjhTKE14hmauU2femPcwVk4XewhZ55hUHCDf0RJj1W2mHTyljIUFiWzMRrVz8ntrTLimQdtC815k9uadFB9/tRWLtlazkCkZz5hjDoCTA8QjQ4Z0ejAnHk29ZfqQfbs8vkTuVvwW0gW74E3X/MJZorcAWgTQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=vqqFNzUEzIGEoXNsUaQHYvgqO7V2nRZnPV3ZMjA9tkI=;
 b=WyNdFPnF0y9E1HZCmf2bgedACe61Kw91KYYP97txXtLudarh26oE6AvcJx++/pNS7qfufcMAZahYP6UDRMiGCBT8EawjHetQP33QMlimXUpZiXMCvnQ4q+nzLHmC/ITh5DBFDG1J+yVOQ9XzAkD40yGknX6Hi3wUqB5GYFX/UIIa3MlcNpBxjicdI5S80akrtO9lwsglnjdyudblwYQyKg4VAkmtcAzHDEETHoxiWANytGH6mT825Qp3otc3lw4lCfvMnysfr3wAdJkMXIXdXm1DC2FzjLtyVGTVAPCHsQqduTec42nlhtWZUlgXLl8bKs0KGh9QHlc/wn5i2fJl1w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=eviden.com; dmarc=pass action=none header.from=eviden.com;
 dkim=pass header.d=eviden.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Eviden.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=vqqFNzUEzIGEoXNsUaQHYvgqO7V2nRZnPV3ZMjA9tkI=;
 b=BJYm30tj5kcvqres7lg/y9jFEA95A/8blgRopnnz5hIT6Yjkm13MSjT/Bqn880st1hZ2M0+1FLlyeCdM9lG2tSZeu/Pl5Tl3yCqf71WjeEbtwwL9OPtR3UUraXXD+9pkCviOQDEAKFxdKyxbSnCTr+lBWDT7duFdubE93NtnRjyLZ+B84nzoWtx+Adq6cAeHxipC3T9D4zWb1bBQVeakS5d6JhVRhQWJoDUeWTaY6sbMjGPXbMFPNJgXzzBVrbWyGxaicziMyUKdqLQuas+GZN6cjDaEfnIMshp85haD6Jf+muNpmXuEhw0Lu1e9k5IXTY2dluueAc8m3ZdBJwDcXQ==
Received: from AM8PR07MB7602.eurprd07.prod.outlook.com (2603:10a6:20b:24b::7)
 by DB9PR07MB9929.eurprd07.prod.outlook.com (2603:10a6:10:4c7::12)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8114.31; Tue, 5 Nov
 2024 06:37:23 +0000
Received: from AM8PR07MB7602.eurprd07.prod.outlook.com
 ([fe80::fbd7:ca71:b636:6f9d]) by AM8PR07MB7602.eurprd07.prod.outlook.com
 ([fe80::fbd7:ca71:b636:6f9d%5]) with mapi id 15.20.8114.031; Tue, 5 Nov 2024
 06:37:23 +0000
From: CLEMENT MATHIEU--DRIF <clement.mathieu--drif@eviden.com>
To: Zhenzhong Duan <zhenzhong.duan@intel.com>, "qemu-devel@nongnu.org"
 <qemu-devel@nongnu.org>
CC: "mst@redhat.com" <mst@redhat.com>, "jasowang@redhat.com"
 <jasowang@redhat.com>, "yi.l.liu@intel.com" <yi.l.liu@intel.com>,
 "chao.p.peng@intel.com" <chao.p.peng@intel.com>, Marcel Apfelbaum
 <marcel.apfelbaum@gmail.com>, Paolo Bonzini <pbonzini@redhat.com>, Richard
 Henderson <richard.henderson@linaro.org>, Eduardo Habkost
 <eduardo@habkost.net>
Subject: Re: [PATCH 3/3] intel_iommu: Add missed reserved bit check for IEC
 descriptor
Thread-Topic: [PATCH 3/3] intel_iommu: Add missed reserved bit check for IEC
 descriptor
Thread-Index: AQHbLrlf65NyNzizbEqpI60PwbRrSLKoPOMA
Date: Tue, 5 Nov 2024 06:37:23 +0000
Message-ID: <59a56936-e718-4ecd-8635-fb5638a34a04@eviden.com>
References: <20241104125536.1236118-1-zhenzhong.duan@intel.com>
 <20241104125536.1236118-4-zhenzhong.duan@intel.com>
In-Reply-To: <20241104125536.1236118-4-zhenzhong.duan@intel.com>
Accept-Language: en-GB, fr-FR, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=eviden.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: AM8PR07MB7602:EE_|DB9PR07MB9929:EE_
x-ms-office365-filtering-correlation-id: 7efef51a-6ef7-4673-c951-08dcfd644ead
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
 ARA:13230040|376014|7416014|366016|1800799024|38070700018; 
x-microsoft-antispam-message-info: =?utf-8?B?Rmt3OFcrdzhzUXV1ZzNyS0VkeG5HVi9RcGZjSFNqVnRGSzFSY3M5THRFSVpy?=
 =?utf-8?B?SjBVSDJNR25ZYUI4eVdENk1vNzlWdmovUVFTczNxYkZmb085QWppUlI5aDcy?=
 =?utf-8?B?MHVJSlYzWkY0V3pJVm5wbGdlL3dMVVZLZzZaa20rRjBOdnI4YnIrNkViazBh?=
 =?utf-8?B?UDBReXJEc0MySFBXR3Y0Z2xWV2wvQnZxMEsvYjNaVlR5M2dsamxIbGJSTFlR?=
 =?utf-8?B?U0lFeVQzYktFK09Uank0YWRIZ0FLRGtoZDk3SmcyV3hBZktNczkxYUkyR3kw?=
 =?utf-8?B?M3g3bVZvMUlXZ1kzbSthUEhSR0M2dS9mMENtckVSNkIxQk9HMUt5TTB5UlNq?=
 =?utf-8?B?UmhzZ2w1K1pNU004SHV5VmwwQ0hzcUpEak1renFNTW5SSmNsdFJ5QisrOW9Y?=
 =?utf-8?B?dzVzMnV0dGh4RkE2RmVodTBwUmJscmQyUHg1a2h0dE8xR00xdGhRVngvdWZS?=
 =?utf-8?B?dG91ZzM3YjdxaTI1TVhTREQxbzFlOUFIRkZUWFZJa2VIMTFaQVBUZ29RMmFZ?=
 =?utf-8?B?T2tTbmhQM3o1UXo5V2liaHR0VmExdTljeExtY2xTU2plUzFDSXFkREE3Wkc1?=
 =?utf-8?B?cXd4NWY3S012QjlZMmVudTlEdVJ5K2JoMHdJazBZelFka3lMejgrUWNPWVpS?=
 =?utf-8?B?aEZzT25CZmI0TGs2WWxVK01NMUYxN0RTUVo4bFRYL0NuaXdUYUU2VXpKeFhq?=
 =?utf-8?B?czhxTG5Pay96cXNoWCtHMENFV0ZJQk54amwwQTVPbTEyZ0hScUVxTktGYzNs?=
 =?utf-8?B?cTdmY2lqNmZxMGJ4QlVndis1QVdiWUdqVGdUM2FBSEpUM3VWTTZPVUhzRVJj?=
 =?utf-8?B?ZmJ6eVFjQ2Y0RlVnVmwrSjY4aHpYOXBCWHIrTGhZdTVmSGYzYW1iR3BNclJW?=
 =?utf-8?B?SXFnUGRCdnJyVkthd1VHaGVSZUtSZHE2eTRoV0FzSlUxWC8yRHlVN05zdVVx?=
 =?utf-8?B?U0M4ZlpIeDB2R2VydEZtZHJHZ3JsUlVxb3owM2VvL2pGWWxXZ1F6d0NjUHJE?=
 =?utf-8?B?UUlkTE85MGY5TmR0N2F2WWRYWXZsb28zcHlaK0E5dUdwVkFjU2JmNmRRZEtk?=
 =?utf-8?B?QnNVSVIzQmR2SEIwYUFDUHI0eVplaFBtcWt5ZHNlY0ZOcnRUN1FDVlpqbGlj?=
 =?utf-8?B?OVZtRXRWSDFUVDZPWGNWZUl2aElGMUZEL2dsSzV5LzNZYzN0RmM2TnJacTll?=
 =?utf-8?B?MVVuSVM4Y2xvMEV0ak9pR3Y4Szg2emVuR29UdzdzUnZJL28wWGh5bFZLVjVL?=
 =?utf-8?B?T1dmek9CYmsvN1gybDFlVEY3M1BObStKUlJrNmtYVnIyWHhSdENpMXFvM0VM?=
 =?utf-8?B?UGxQeE5VRFVNS0pyWlVRSHVMSmRoTSs0RW00WklVS2h3MXNuYzBPQ1N1QlAx?=
 =?utf-8?B?NFBVcEVtYlVaQ0xHdHdnc2M5V3YzcytnM21sUnhGNjA0bW1DOTA1TVJ5Q0FK?=
 =?utf-8?B?U2JVT0FmMDZYUm5kcytETm9BVnl4TTluY1krWUpEZVM5a3ZETnV5NlZIR1Bq?=
 =?utf-8?B?S05XUno4Sy9GL1pqSHFkK09JUWNhY1kxRGVZWXNjZ2FDMFFMZUxXbG5tclpk?=
 =?utf-8?B?QitpTXVWMURLSnZTUmJjbW9QRkRmQWlsVk9PLzgwZHhnbHd6VDkyU2FMTE9m?=
 =?utf-8?B?TVVpME9VQmJ3aWxNaWJtSjVId1QrME9xNnI2NHB4RUJkZWFKRUJDOWVrbXk5?=
 =?utf-8?B?TTFhMlVXNnprbWlNM084SmF6Y2xoSFpydjFrd0NGdkhZbjdSUmNvMlhkUTA0?=
 =?utf-8?B?ZmNZbkZuM1REWjloSDJtbzAwUWhCcWlnVk9FcUd0VDVhSllsRVpIUStVaUFr?=
 =?utf-8?Q?b7gR9WNcksO9aUfIvRCWc7WKGksg1BfUaxoRY=3D?=
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:AM8PR07MB7602.eurprd07.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(376014)(7416014)(366016)(1800799024)(38070700018); DIR:OUT;
 SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?UmJkd2tWbGpkNVFlclVqbWxDd1BGemdJdi9kZzRJa05EaXJ0N0lNdGcrd2FR?=
 =?utf-8?B?RGNRMGc2S0tvdVRPdG01akJaYjdrbnV5N3BMZUt4WU5sMmppc3JZWFVNelE4?=
 =?utf-8?B?dTZVRXozOGJWQnJ1bDBXTkZra210cURSMkZCTXRRS3BRNEpsUDVPRVB6YjFI?=
 =?utf-8?B?MUFMbWRpZW1FSVBmYmRRSlRyVzJ6VENESTRNdE14N3RnanJPbzRQR0pRSHow?=
 =?utf-8?B?VHVVbldaTVNvYWZKdk5waXZRV0hIdTBFNWFBZVU2aHJOTE9UUEI2V0lYcjdT?=
 =?utf-8?B?SzhtV2FKUkRHVXpFSVRodEZNdXc2S1FNaW9yam5vdEVBeCs4Qjk2RFI5RzJO?=
 =?utf-8?B?RUJGUWJoWmpDQWpla2J2ZHM4M0FoN1hHbDJGdHdnY0JqeWJRYS9OeFRnU3pC?=
 =?utf-8?B?R0ZXOVBXY1d6MXFyVGMxY0tsRklRaEV5SVFBYTBNWkZiczR4eDNEN3JsbE5Q?=
 =?utf-8?B?WjFlSjhGQXpBU2g4anJuSGh4Z0FpWmg4Mkloc3JHVllMN1JjRWdTTTNsRHZD?=
 =?utf-8?B?anRXQklNdnkzYUEvcGpCL0pnbms1TDUvaElsZ2JxbGs2SDU4WEFYMDZLQUVP?=
 =?utf-8?B?R21tMjlTN0ZwaE5SSmpEYkZkdm5rVGJWZVp3REVhVlJHWU4wL0dQbHRxWFY2?=
 =?utf-8?B?UGxMclpCaVA3MFdtTnF3TFlnL0dndkVzbXlRcDVtdTVkY2M3NlJ2dU9oRFZN?=
 =?utf-8?B?djVYWFNWalpkN1FZV0t2QmszTTNlbnlBS3A0U3l0VFgrK3QzWGk3L283YW94?=
 =?utf-8?B?RjRqOTZNa1UrbHBEaC9oNkZZblJ1Wk1ac1VpemJnUE41WExpYlp2L3ZoTng3?=
 =?utf-8?B?dVkydXpWY2F2UVpCVDdYblZmalZqL1d6VGt0NFRHNkU2OGkvZVY1VnhSUno2?=
 =?utf-8?B?dXJtUStPSG5NRktvM0hNOEg2NWtmYzkzRks4OHc1ZnJtcEdxRHNHazhDeVR5?=
 =?utf-8?B?YU1obVNhVnFqcFlDd0xqMUg1UnJibkRKQXlYOXRGWW0zQk1MUkljeGJCVnhl?=
 =?utf-8?B?MlBhWGxlck1YZGZEL0RVT1M0cUlEZDRxNzljZm5rRzZVQXZSeVRYUkpDMEl6?=
 =?utf-8?B?YnZIL0l0OER4dzlyOVovTmVqMCtpeitvZ0ZjZkc5cVVraEdoa0taZ1QwWS93?=
 =?utf-8?B?MVFUZTBvRVZhT0ljV284VGowamZzQkNNQzhId3I3K2xpc0VNMEYvbzk3YjRH?=
 =?utf-8?B?bDlDdVpaV0lXSnF6WTgvZFo3V0lWZkxMb1I4RFpSRU4wK25RY20wbmFLM1hL?=
 =?utf-8?B?dlpEdlFnYkQya0Zxd0IxOTF4R01uTkFQZytVTW1kMHR4QVhvdFR4YnFWajFU?=
 =?utf-8?B?R2JJejZ4MHdhUDVFbW1rK2YzRXREWm9wc1kxVWkrSE00b2I2THQzRWxsNkpp?=
 =?utf-8?B?YjRndEh4TndiTWRxVkw3L09NMytVWmlSR05udjdGbGliZ09oLy9raVJVR3JP?=
 =?utf-8?B?RkhzVEc5clVncmt1dk5mTS9qU3JWKzRpQkpTV0dnU1RKaWMvZUlpd2lkZjBE?=
 =?utf-8?B?UFIvalUzckUwWW83c0NRVjM1SmlWb1lOVDVwS0JWN3Y0RWhwVW9PQWlXZWk4?=
 =?utf-8?B?UVk4OERxdXJNblR1NmpOM3hYYmJabk9peFFLTVRYN2R1enpBSVU2Qm81d3VY?=
 =?utf-8?B?aDYyNWUzWkd2WEVTWlZiQ24xS1FxS2YyVUdqVDR3cWdnMkhCSi9BT3hXV3Rj?=
 =?utf-8?B?TGZsNEJEUTRaSDg1ZGhhcFpTM0RuOHhGYkRqR1V3bU1WRU9JZXloZTRYMGVL?=
 =?utf-8?B?N0ZIcU5hVTlpK3dvcEMwRmV5VWVZanNkMDYvWFgrWG84MFZSNHdTdDVHN2kx?=
 =?utf-8?B?WjBGc2lMOTZ6Mmh3cWxkaFdBYllSdW5ZaGZzMGxpd0ZKZmtKQm1kYTNNRk51?=
 =?utf-8?B?ZTZKVXFqcmVCd3dDR04vYjUwM1NaNkpJWDVJcXRpY014ekVFMHFTYXlZTFlK?=
 =?utf-8?B?TVVseEF1aDlxTFJXSEg4VFZBLzVYNmNRMEJTTmlHQTJ4dFNXcFNSRWpOK0ZY?=
 =?utf-8?B?ZmpWb0Y5T2FPUmZOdklyMTVtVkZBVS9iT2dhd29pMWEzR3Y3b04vTDRSNDBP?=
 =?utf-8?B?dWc5ckwyS0diM2FJRHFjM1RwUHBXZExxbXZtV2d3amZqQmNXVXM1RElNcU93?=
 =?utf-8?B?M05WY25iQzBxT3JZaDI3amtOZEZiaXhPMHpNMXFodXhsdEVlQ3RnQW5UZUpu?=
 =?utf-8?Q?Zu1gDI1tlYkMpPeFNr2vf34=3D?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <82C7F6F640A5CD4885D23A71FB7F5C3F@eurprd07.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: eviden.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: AM8PR07MB7602.eurprd07.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 7efef51a-6ef7-4673-c951-08dcfd644ead
X-MS-Exchange-CrossTenant-originalarrivaltime: 05 Nov 2024 06:37:23.7844 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 7d1c7785-2d8a-437d-b842-1ed5d8fbe00a
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: UiJk5VfRSx5FClSuULC4IGuOGd1QlBu0V1rSHf0xvzAFz23r0rqc43YyoJJjqibX5iMJ18LyOJ2TWr3Ui0+69Vujnu2FUTsHcaZEX/feOxE/4hQzvKzsI2FZoCG7zb6p
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DB9PR07MB9929
Received-SPF: pass client-ip=80.78.11.84;
 envelope-from=clement.mathieu--drif@eviden.com; helo=smarthost3.eviden.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_VALIDITY_CERTIFIED_BLOCKED=0.001, RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001,
 SPF_HELO_PASS=-0.001, SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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

SGksDQoNCmxndG0NCg0KVGhhbmtzDQpjbWQNCg0KDQoNCk9uIDA0LzExLzIwMjQgMTM6NTUsIFpo
ZW56aG9uZyBEdWFuIHdyb3RlOg0KPiBDYXV0aW9uOiBFeHRlcm5hbCBlbWFpbC4gRG8gbm90IG9w
ZW4gYXR0YWNobWVudHMgb3IgY2xpY2sgbGlua3MsIHVubGVzcyB0aGlzIGVtYWlsIGNvbWVzIGZy
b20gYSBrbm93biBzZW5kZXIgYW5kIHlvdSBrbm93IHRoZSBjb250ZW50IGlzIHNhZmUuDQo+DQo+
DQo+IElFQyBkZXNjcmlwdG9yIGlzIDEyOC1iaXQgaW52YWxpZGF0aW9uIGRlc2NyaXB0b3IsIG11
c3QgYmUgcGFkZGVkIHdpdGgNCj4gMTI4LWJpdHMgb2YgMHMgaW4gdGhlIHVwcGVyIGJ5dGVzIHRv
IGNyZWF0ZSBhIDI1Ni1iaXQgZGVzY3JpcHRvciB3aGVuDQo+IHRoZSBpbnZhbGlkYXRpb24gcXVl
dWUgaXMgY29uZmlndXJlZCBmb3IgMjU2LWJpdCBkZXNjcmlwdG9ycyAoSVFBX1JFRy5EVz0xKS4N
Cj4NCj4gRml4ZXM6IDAyYTJjYmM4NzJkZiAoIng4Ni1pb21tdTogaW50cm9kdWNlIElFQyBub3Rp
ZmllcnMiKQ0KPiBTaWduZWQtb2ZmLWJ5OiBaaGVuemhvbmcgRHVhbiA8emhlbnpob25nLmR1YW5A
aW50ZWwuY29tPg0KPiAtLS0NCj4gICBody9pMzg2L2ludGVsX2lvbW11X2ludGVybmFsLmggfCAz
ICsrKw0KPiAgIGh3L2kzODYvaW50ZWxfaW9tbXUuYyAgICAgICAgICB8IDggKysrKysrKysNCj4g
ICAyIGZpbGVzIGNoYW5nZWQsIDExIGluc2VydGlvbnMoKykNCj4NCj4gZGlmZiAtLWdpdCBhL2h3
L2kzODYvaW50ZWxfaW9tbXVfaW50ZXJuYWwuaCBiL2h3L2kzODYvaW50ZWxfaW9tbXVfaW50ZXJu
YWwuaA0KPiBpbmRleCA3NWNjZDUwMWIwLi40MzIzZmM1ZDZkIDEwMDY0NA0KPiAtLS0gYS9ody9p
Mzg2L2ludGVsX2lvbW11X2ludGVybmFsLmgNCj4gKysrIGIvaHcvaTM4Ni9pbnRlbF9pb21tdV9p
bnRlcm5hbC5oDQo+IEBAIC00MTAsNiArNDEwLDkgQEAgdHlwZWRlZiB1bmlvbiBWVERJbnZEZXNj
IFZUREludkRlc2M7DQo+ICAgI2RlZmluZSBWVERfSU5WX0RFU0NfREVWSUNFX0lPVExCX1JTVkRf
SEkgMHhmZmVVTEwNCj4gICAjZGVmaW5lIFZURF9JTlZfREVTQ19ERVZJQ0VfSU9UTEJfUlNWRF9M
TyAweGZmZmYwMDAwZmZlMGYxZjANCj4NCj4gKy8qIE1hc2tzIGZvciBJbnRlcnJ1cHQgRW50cnkg
SW52YWxpZGF0ZSBEZXNjcmlwdG9yICovDQo+ICsjZGVmaW5lIFZURF9JTlZfREVTQ19JRUNfUlNW
RCAgICAgICAgICAgMHhmZmZmMDAwMDA3ZmZmMWUwVUxMDQo+ICsNCj4gICAvKiBSc3ZkIGZpZWxk
IG1hc2tzIGZvciBzcHRlICovDQo+ICAgI2RlZmluZSBWVERfU1BURV9TTlAgMHg4MDBVTEwNCj4N
Cj4gZGlmZiAtLWdpdCBhL2h3L2kzODYvaW50ZWxfaW9tbXUuYyBiL2h3L2kzODYvaW50ZWxfaW9t
bXUuYw0KPiBpbmRleCAyZmMzODY2NDMzLi40YzBkMWQ3ZDQ3IDEwMDY0NA0KPiAtLS0gYS9ody9p
Mzg2L2ludGVsX2lvbW11LmMNCj4gKysrIGIvaHcvaTM4Ni9pbnRlbF9pb21tdS5jDQo+IEBAIC0y
NjkyLDYgKzI2OTIsMTQgQEAgc3RhdGljIGJvb2wgdnRkX3Byb2Nlc3NfaW90bGJfZGVzYyhJbnRl
bElPTU1VU3RhdGUgKnMsIFZUREludkRlc2MgKmludl9kZXNjKQ0KPiAgIHN0YXRpYyBib29sIHZ0
ZF9wcm9jZXNzX2ludl9pZWNfZGVzYyhJbnRlbElPTU1VU3RhdGUgKnMsDQo+ICAgICAgICAgICAg
ICAgICAgICAgICAgICAgICAgICAgICAgICAgIFZUREludkRlc2MgKmludl9kZXNjKQ0KPiAgIHsN
Cj4gKyAgICB1aW50NjRfdCBtYXNrWzRdID0ge1ZURF9JTlZfREVTQ19JRUNfUlNWRCwgVlREX0lO
Vl9ERVNDX0FMTF9PTkUsDQo+ICsgICAgICAgICAgICAgICAgICAgICAgICBWVERfSU5WX0RFU0Nf
QUxMX09ORSwgVlREX0lOVl9ERVNDX0FMTF9PTkV9Ow0KPiArDQo+ICsgICAgaWYgKCF2dGRfaW52
X2Rlc2NfcmVzZXJ2ZWRfY2hlY2socywgaW52X2Rlc2MsIG1hc2ssIGZhbHNlLA0KPiArICAgICAg
ICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgIF9fZnVuY19fLCAiaWVjIGludiIpKSB7DQo+
ICsgICAgICAgIHJldHVybiBmYWxzZTsNCj4gKyAgICB9DQo+ICsNCj4gICAgICAgdHJhY2VfdnRk
X2ludl9kZXNjX2llYyhpbnZfZGVzYy0+aWVjLmdyYW51bGFyaXR5LA0KPiAgICAgICAgICAgICAg
ICAgICAgICAgICAgICAgIGludl9kZXNjLT5pZWMuaW5kZXgsDQo+ICAgICAgICAgICAgICAgICAg
ICAgICAgICAgICAgaW52X2Rlc2MtPmllYy5pbmRleF9tYXNrKTsNCj4gLS0NCj4gMi4zNC4xDQo+
DQo=

