Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A2B37CCFA03
	for <qemu-devel@archiver.kernel.org>; Mon,  3 Nov 2025 15:44:36 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vFwho-0002z6-FF; Mon, 03 Nov 2025 10:42:52 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <skolothumtho@nvidia.com>)
 id 1vFwhm-0002yV-8Z; Mon, 03 Nov 2025 10:42:50 -0500
Received: from mail-westus3azlp170120001.outbound.protection.outlook.com
 ([2a01:111:f403:c107::1] helo=PH8PR06CU001.outbound.protection.outlook.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <skolothumtho@nvidia.com>)
 id 1vFwhh-0001x4-TC; Mon, 03 Nov 2025 10:42:48 -0500
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=VaWzL2Izw7qiuDHlSVcQAe/8Vjl4WkaglqhUj0nNpiDV+MeFDwV0SgHoyY/O8zGTQHabw6Q5oknWEfc1y5tLTS8dPpv66qNlhurassvgfzgznD3HAJ+OYr9lZQrlJYCJfRmgbjly1A26WE/ejN1/lzuAbWoRd0NRcEGuniTg8+8eyff7FKPCxw8i5C7iJWOv0WrlP7S8fQFUiy1t79Le+gX5u0gLV+SnjNaf1ExLj8sbFA1hp4AFHKmtvEsc8OFZ4E57OAtP/v2CgANNQFnvEoe0XVSkKlDYhx9+mkQm4VZbs6sF41qLYqhMeIq7BRPGI+So612hL6Mdau8h1NwLdg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=RZyrTZIdNw7cwVp3NtCqzk6utPv0zJrpM9Yv9ib1YMw=;
 b=liM2AoQ+y50tmKfDKrEwU0z2MgX9QgNuyVjcSrBQ1YnaRw7N+I6Iiq13R7i3gHrsil1EeP65eB8sQNobgdjkYpzp5KgIGGmPna6xb/SG71Z9eVS7P/R0KcFnOclhYIBSfLIvzhRqiERVOoBfnwuWk8T77y72U+6tf16UkSM02T1tryHe+flW/S3mXDo/sGB0NCsJhWKMiJMn0kAWc1KjR0cUkutpXwA49qVRY/gOMLS4eo7LnOZsdtJ5Miy8710sr7m6dnnvxu+yhR3oJ/OLlM6mTMfDyd1h0q35woKu6RkJ0KG6KPchhKUIrakMjAybN+FETUYeAty+0RQC1gpfcg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=RZyrTZIdNw7cwVp3NtCqzk6utPv0zJrpM9Yv9ib1YMw=;
 b=WR1YLCZpZESjuWIRK08bqwQEK/f18qtQL3RfEb9bLTgvEUzWzVEbTm+SzaP/88o56lQhGD4NrJGN4+F/cKVJqkaVz3Y3byICQwCwOnMeMVwkioXuy7zbSAYZ5D1YZyUpHO0steNQ3oEdV6wbIhwHescEgbxvrkCTwc54YNgRKkpvw51r3Q70CvG6zkHvR/RLx+tP1vWCMs4Xs1gID9t4y0HcG39Dgswty+x73XRzbud/C4LOJEmHWIc1Ck0euxG0U9KdwJn028vBv+ZdcJzFr35ycQuNgVx4+d4v4f74xGXWC4ToszeAkRDrfyu+MzoC+z5T9qxbe6OM3sCag1r82A==
Received: from CH3PR12MB7548.namprd12.prod.outlook.com (2603:10b6:610:144::12)
 by PH7PR12MB5855.namprd12.prod.outlook.com (2603:10b6:510:1d6::11)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9275.14; Mon, 3 Nov
 2025 15:42:32 +0000
Received: from CH3PR12MB7548.namprd12.prod.outlook.com
 ([fe80::e8c:e992:7287:cb06]) by CH3PR12MB7548.namprd12.prod.outlook.com
 ([fe80::e8c:e992:7287:cb06%5]) with mapi id 15.20.9275.015; Mon, 3 Nov 2025
 15:42:32 +0000
From: Shameer Kolothum <skolothumtho@nvidia.com>
To: Zhangfei Gao <zhangfei.gao@linaro.org>
CC: "qemu-arm@nongnu.org" <qemu-arm@nongnu.org>, "qemu-devel@nongnu.org"
 <qemu-devel@nongnu.org>, "eric.auger@redhat.com" <eric.auger@redhat.com>,
 "peter.maydell@linaro.org" <peter.maydell@linaro.org>, Jason Gunthorpe
 <jgg@nvidia.com>, Nicolin Chen <nicolinc@nvidia.com>, "ddutile@redhat.com"
 <ddutile@redhat.com>, "berrange@redhat.com" <berrange@redhat.com>, Nathan
 Chen <nathanc@nvidia.com>, Matt Ochs <mochs@nvidia.com>,
 "smostafa@google.com" <smostafa@google.com>, "wangzhou1@hisilicon.com"
 <wangzhou1@hisilicon.com>, "jiangkunkun@huawei.com" <jiangkunkun@huawei.com>, 
 "jonathan.cameron@huawei.com" <jonathan.cameron@huawei.com>,
 "zhenzhong.duan@intel.com" <zhenzhong.duan@intel.com>, "yi.l.liu@intel.com"
 <yi.l.liu@intel.com>, Krishnakant Jaju <kjaju@nvidia.com>
Subject: RE: [PATCH v5 19/32] hw/arm/smmuv3-accel: Get host SMMUv3 hw info and
 validate
Thread-Topic: [PATCH v5 19/32] hw/arm/smmuv3-accel: Get host SMMUv3 hw info
 and validate
Thread-Index: AQHcSzqeYy7W457IFUWBjdVMst7UZ7ThF4wA
Date: Mon, 3 Nov 2025 15:42:31 +0000
Message-ID: <CH3PR12MB7548CA41C51C4B6C01CDBA73ABC7A@CH3PR12MB7548.namprd12.prod.outlook.com>
References: <20251031105005.24618-1-skolothumtho@nvidia.com>
 <20251031105005.24618-20-skolothumtho@nvidia.com>
 <CABQgh9ENUvSJ5UiPGDbdQ_VPm5PtdFVmEM_27Z9QEb4O29cKwQ@mail.gmail.com>
In-Reply-To: <CABQgh9ENUvSJ5UiPGDbdQ_VPm5PtdFVmEM_27Z9QEb4O29cKwQ@mail.gmail.com>
Accept-Language: en-US, en-GB
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: CH3PR12MB7548:EE_|PH7PR12MB5855:EE_
x-ms-office365-filtering-correlation-id: 87bcfe67-2359-44fa-8f2f-08de1aef9a2b
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
 ARA:13230040|366016|1800799024|7416014|376014|38070700021; 
x-microsoft-antispam-message-info: =?utf-8?B?dXVJSXZYeWJ4RlhzQndKZ2IyMFhwdGY2RFg0RSs3NzZ4dEhkR0tGaHF6SXI5?=
 =?utf-8?B?azBhSENDOEdZZUt2RDJXZ0Q1eE96NENLN1VoRUU1SFJ1dU9ST3kwN0ZNTTJv?=
 =?utf-8?B?bmpsalZSNldMaDFXWVBYN0JKUm04dmdtbE0rLzlJMUNjcGNLaXBKdzhnRlRp?=
 =?utf-8?B?MmlTQVRWeEh3Znh4T0wwMCtzajJBYWc3bFpXUUtmZ2tveGhMV0dLcTFaZG93?=
 =?utf-8?B?VzAxUW12TXJVMmdKRzB0UTBXZ2ZoSjVDMHVQYVY3djhzenkyTXdzcURXU0Ra?=
 =?utf-8?B?Y2twZmp2WjY3NmgrR0toaDkxRkNobWRERlJjMkdyNTFGd0pmY0dEQWk2K2ow?=
 =?utf-8?B?S2w0ZEN2NG1KQk8wZkxDV20vdk5aVkIvd1ZoUHJZTVRVbFM2MEx1YitENjN1?=
 =?utf-8?B?Sk12SG5hT2RoYWJINVdLMStLRlM5UEhiRU50TEpDMUN2QWQ5dEhWV0w0aEJu?=
 =?utf-8?B?QnNCR2YrMkpoYW1PdDVLLzRBb2I0R1N4bTJBZEpaakVJeUFQOUVFNkZEMXdn?=
 =?utf-8?B?MURvdFU0WjhwUWk2MlVKODhOSlNBRU5TNEQvZzVjaCtHeE16QktyZHRjMmdB?=
 =?utf-8?B?Wi9xZ3M5cWYzVUkzblU4M1M4SmdRdU1LTW9MUlpnOEE3SXVuYzFjZkk1Wkti?=
 =?utf-8?B?aUlQS1MrUytlQ01ZMVowRm1JbEQyYzQweVdIQ29uNmQ2ZjIxSURteHU3cHBH?=
 =?utf-8?B?dll4RFRxQVJ6QnFJSGZISXdMY3lQTnNwQzhWeGxlN0c5V1lVUnliSUh4VXEv?=
 =?utf-8?B?a0s1M2t0TnNJU1Iva0dneHVYS1gxUWVCYmJybXRDdHRiZkkyNnFEZ3hUSDBH?=
 =?utf-8?B?VGxBdG5ROVlJODdYaEVpOXhwNmFsUmcrdkh3VGFpaitOMXNZY3FNOVVWTktF?=
 =?utf-8?B?MXd4eXVWNVFrQ2x2bGtWSi9JdytubWZJWmpIeDBMNXlwY1kvNncxa2NkTGxQ?=
 =?utf-8?B?S1hQelgrbFNGd1pMTkI5RXpvSEJiUG1QN3k1VUtQMTZNS0xBVnU3MDhpNnlF?=
 =?utf-8?B?UlhiRXJ6TndhT0NZRHBwc2JTTU13T3JnSk44M09SZ2dVallCQ3F6UkowcUtt?=
 =?utf-8?B?VG9ZcnJ1WGVCZGh1VGpOeGdIb3dVZHpISVJzQmJ2bzgyQnJ2SlBhWDBLczJj?=
 =?utf-8?B?bWpmb2E3dERGaGhQMEx1T0pJcWxqTUdSRGhqdWU2R05mU0c3TEd3QnpDVHZJ?=
 =?utf-8?B?dEpVcENoaURhNUs1YUpzaVFEY0NZZnhkTm96c3pKS0tySnAweTBHTmFlTHA0?=
 =?utf-8?B?RDgrMkUza0E5WFh6UmUxdTNVVDFXUVI3c3pUcUtwNnZyRVE2T0s4Sy9sTmVL?=
 =?utf-8?B?ZzBKdFRVcjJxSVM5N0NYcjhLMksvTDFNTzhPR1dOY1pSVmp0TXFkQ1NJVVlL?=
 =?utf-8?B?NVk4WERLSXUrczdwZnZJVTByN3c5VnhXTnFRK0VrL3N4QnlTS3o0djNkbVRQ?=
 =?utf-8?B?aDlYczZVU3VBc2Y2d1EvYWxEYWkva3JJVkVOSWRZcE9QS0U2Q3FBZUlOTk0z?=
 =?utf-8?B?Yk9FczJYeS9sTTdnTFl1aFpxdzh5UjNwalErMEdnVGpjM1VTcnNMejR6MmdP?=
 =?utf-8?B?cDlpd1JoZEpwVGV2N1VGKzF5eG9YVzZYaDJ5MlJOSnAvSG1FekxvMkp6bTRu?=
 =?utf-8?B?bzg0VW9ZcFdpWGhhUGdLWjFQdzJKYS90NlhBZ1dNb1RxejdpbGYybUNqblBJ?=
 =?utf-8?B?ZC83VllMWHNQSmNjOUhxalNsSFdRbDcxcC9wb1RBak1ZYUhWOFMzYkN2cUxP?=
 =?utf-8?B?RDVmUHhieDJSL3pzZ21PbzVzanRUQ213aGJweTZyKzZ1cEYxRkJYU2dUQUo4?=
 =?utf-8?B?M0hRUlo3MUFzUURvWVNVcTJRdW5ycVdCZmw0aHJGMi9nY05IL01wNnBybEZh?=
 =?utf-8?B?NVRVeUJBckR0MHNVQlVRdFg4OGxnanFINW4wOWg0SmNFc3dKcW1rWTMrWUhW?=
 =?utf-8?B?TFRBR3RacTZuWnZVK3dIS0FwRllTWCs4MU94dzdDWmxFbS9DMWNrWTJJRFJD?=
 =?utf-8?B?VkZoU2tDQXg0Mko3WW9zWVo1b3pBa0YxdEU5UGFxalllcTZ4YU5OZTd1QUpD?=
 =?utf-8?Q?/n3liE?=
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:CH3PR12MB7548.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(366016)(1800799024)(7416014)(376014)(38070700021); DIR:OUT;
 SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?OHZFa0x5b3diT0IyM3JjVUZhekpKTitTMldLVU5PYXVOZ3k1M1BCU2VhUjJy?=
 =?utf-8?B?VTRGQVk4NFVlYnMyUEVYUDFLdUo5c1dkM0VHUktiT1dNWWtsdUo1WGM1SEVR?=
 =?utf-8?B?cUN6clZ3OUQ1U3dJcjE4cHFCcGJjQmtxaUVsTkNjc243enhsZ3JWbStVZHZB?=
 =?utf-8?B?NE5EYVREMUZrMDRGbDZxb0QyUkl0ZlVFeGppUU9OOElmQ1ZWUU9qcERQS2Vx?=
 =?utf-8?B?VWxMbytrTzZPL28xNUUyUHN3dHNOZjdwMFlGa0dJZ3AxMWtuYURmVmtTZDNa?=
 =?utf-8?B?K281Z0pMNHF3Zlg4d3M5QzZKSkR6cWlkcmRMNDU0bUhqcU83NGlEZkk3T3Ru?=
 =?utf-8?B?VXMvd3A0bzdzL08xaWhwZm9ubHg5RkFxWWE1MEFrUll3S2RiaTlIMnBJRXZp?=
 =?utf-8?B?blJmR1g0K0pRRlY3VUw2b0xDS20veXFhdTlpcTErM1NjR0pJTE4wb29QeVVz?=
 =?utf-8?B?dHUrcS80TWMxcjRzVmg2RkUvT1I1VmlSdmlGbTY5bThHaUoxQWdUWk9IbDhN?=
 =?utf-8?B?NUthaFQ2Z2hhci9iTTZvZDhmYzBFalFWUXNGSHIzRG4vbmg4dWZRTko3cVht?=
 =?utf-8?B?aVZxUC9uNm1RcDlRQTBFMGJwQklSUzN5MlFzdGpvN2ptczdiakxLMzRaZDhv?=
 =?utf-8?B?aFNRNjlVWTBOMkM4OUdVMmcycVg5emtUemtmazBzR2VPbm5CYVhhV0ZqRU5Y?=
 =?utf-8?B?a1oyeHZibjVhWDYrWFpPS215TXRodEVHK3VaMEJkNGZPY1JraWpoamtMOXVp?=
 =?utf-8?B?cWZwTktRd1Y4Q3BNS3BRZ0tEZDdiYVNsYWVhMExxVEZCRU53SWVabVRoT1Zn?=
 =?utf-8?B?VTM5a0R1QTdiOGg5ZitZQUtvcTFLYjRNN25zQmhIbG1iN1I1UktnODVJOU5S?=
 =?utf-8?B?eUtTR3RVNTVuWkNPdG8yR1pORjZLbWU2ZXVwMDlOK2w3OU1YdjRObGxuSmcv?=
 =?utf-8?B?elVRaVBQT09wZkZiNHJsRVRPMFl4ckZBYTBkaGFMeGYxSElSd1ptOVB1TkJ3?=
 =?utf-8?B?elRUNnpwMzNqaUFBaUNwSk1acVZnQWVYbnhMMjkrc0lzUUtpbENPWEw5dFBJ?=
 =?utf-8?B?UUwyWEN4OGxNRFRpRXlaVGlTYnRURXZCZC84OTd3ZjBhL0tLb0c5aUFHbFB6?=
 =?utf-8?B?OVZMcTJmNkdlNTJlSW53S25tVFZTa1FYRVJ3TnRhS2hnMDg1MVNoNFZUSVBP?=
 =?utf-8?B?NW5tNGFmSFhialJ1MHUyVzJtYkxiQlk1SC9VUlA3dExobWpDa1NaS3NUYkhX?=
 =?utf-8?B?eW5NdkhMQ0RqQjZ2L0dqMW84a2M2NE53UW5OcUNFZXpaVjlRbmZ2dGpoSFgr?=
 =?utf-8?B?SFRxSjVBR0RjbXhPOUtENk10cEYwSlBqQmc5VEVZRHNXdzEwQkJyOWc3Z25w?=
 =?utf-8?B?eE5ERHRtRXBnYlY0bmU2NTFZWGNJdUdVdFl6T3BSUnN3KzVMM1Njc0l5N0FR?=
 =?utf-8?B?LzBXMmE4ZmxwS0pRL0JOZG5JOFhEbi83U1Q4bnhHekR3Z3JrTTVkcVB1REFv?=
 =?utf-8?B?VlFZc2t1cjRhSDRzbGFnTHY3dGgwUkVtTjYzQ0NTRUUvYWRXREdhcU11bURU?=
 =?utf-8?B?Ui9SK2hVNFB3R2twU1VXWWxrZEIvRlUzZGZYOG9OUHpiVy9adVBCNHNQUEU5?=
 =?utf-8?B?WlNjWHdYR3BRQkJ4Vkhia0g1Mlk1VHYzalhsWWpEcExoMnVrdXdxK05oMGd5?=
 =?utf-8?B?cWZuZVRodDlKZE9IZzByaXF6Z09iUDBCVVI2aE1zQk9USUxmLzlwb3pDQVFQ?=
 =?utf-8?B?cThLNlROV0pGSEw0aXZNNkMwZzE5TUtnTllmSjBaRVJDcUlXSjc3elBndThE?=
 =?utf-8?B?dEpWVWY5a3RlL3J2NTIzWTJMRXNWZGxobmFDdTNWQTlGRjFMKzFTYUtQYTF3?=
 =?utf-8?B?dkpxTGMrR0dOQXlyRmtXZEI1M3gveG8rNUZreWsvNUZDR0pDUUVUNWtsMlZ4?=
 =?utf-8?B?U2FBQko3M1FueElUNitKbGJyc0x4Wm5ZNEFFTGY4djRqMjE4RW5wN1c1R2NT?=
 =?utf-8?B?dmlEYk9nNnQ3NXdyallPTktDc09TYTEvUVE2dDdMVmYwVmFaZlNLbnd2N0or?=
 =?utf-8?B?TXdrVWlkdjB6ZG9CbExqalFTOEs5eEIrTTk2RjQ4Q2xrTTdkTzRWYXpjUXZI?=
 =?utf-8?Q?oz+wJPy5ZkxJvhE5VvB8G6rE1?=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: CH3PR12MB7548.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 87bcfe67-2359-44fa-8f2f-08de1aef9a2b
X-MS-Exchange-CrossTenant-originalarrivaltime: 03 Nov 2025 15:42:31.8598 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: cPXXa2H+AknAqZO1/W7/0d63Q8WfhhvHJdoWdn6MhNLpXGJZw8qz4bi9DTz7EolVoQ2KBDaquU9g8qmlZFATeA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH7PR12MB5855
Received-SPF: permerror client-ip=2a01:111:f403:c107::1;
 envelope-from=skolothumtho@nvidia.com;
 helo=PH8PR06CU001.outbound.protection.outlook.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 SPF_HELO_NONE=0.001, SPF_NONE=0.001 autolearn=ham autolearn_force=no
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

DQoNCj4gLS0tLS1PcmlnaW5hbCBNZXNzYWdlLS0tLS0NCj4gRnJvbTogWmhhbmdmZWkgR2FvIDx6
aGFuZ2ZlaS5nYW9AbGluYXJvLm9yZz4NCj4gU2VudDogMDEgTm92ZW1iZXIgMjAyNSAxNDoyMA0K
PiBUbzogU2hhbWVlciBLb2xvdGh1bSA8c2tvbG90aHVtdGhvQG52aWRpYS5jb20+DQo+IENjOiBx
ZW11LWFybUBub25nbnUub3JnOyBxZW11LWRldmVsQG5vbmdudS5vcmc7DQo+IGVyaWMuYXVnZXJA
cmVkaGF0LmNvbTsgcGV0ZXIubWF5ZGVsbEBsaW5hcm8ub3JnOyBKYXNvbiBHdW50aG9ycGUNCj4g
PGpnZ0BudmlkaWEuY29tPjsgTmljb2xpbiBDaGVuIDxuaWNvbGluY0BudmlkaWEuY29tPjsNCj4g
ZGR1dGlsZUByZWRoYXQuY29tOyBiZXJyYW5nZUByZWRoYXQuY29tOyBOYXRoYW4gQ2hlbg0KPiA8
bmF0aGFuY0BudmlkaWEuY29tPjsgTWF0dCBPY2hzIDxtb2Noc0BudmlkaWEuY29tPjsNCj4gc21v
c3RhZmFAZ29vZ2xlLmNvbTsgd2FuZ3pob3UxQGhpc2lsaWNvbi5jb207DQo+IGppYW5na3Vua3Vu
QGh1YXdlaS5jb207IGpvbmF0aGFuLmNhbWVyb25AaHVhd2VpLmNvbTsNCj4gemhlbnpob25nLmR1
YW5AaW50ZWwuY29tOyB5aS5sLmxpdUBpbnRlbC5jb207IEtyaXNobmFrYW50IEphanUNCj4gPGtq
YWp1QG52aWRpYS5jb20+DQo+IFN1YmplY3Q6IFJlOiBbUEFUQ0ggdjUgMTkvMzJdIGh3L2FybS9z
bW11djMtYWNjZWw6IEdldCBob3N0IFNNTVV2MyBodw0KPiBpbmZvIGFuZCB2YWxpZGF0ZQ0KPiAN
Cj4gRXh0ZXJuYWwgZW1haWw6IFVzZSBjYXV0aW9uIG9wZW5pbmcgbGlua3Mgb3IgYXR0YWNobWVu
dHMNCj4gDQo+IA0KPiBIaSwgU2hhbWVlcg0KPiANCj4gT24gRnJpLCAzMSBPY3QgMjAyNSBhdCAx
ODo1NCwgU2hhbWVlciBLb2xvdGh1bQ0KPiA8c2tvbG90aHVtdGhvQG52aWRpYS5jb20+IHdyb3Rl
Og0KPiA+DQo+ID4gSnVzdCBiZWZvcmUgdGhlIGRldmljZSBnZXRzIGF0dGFjaGVkIHRvIHRoZSBT
TU1VdjMsIG1ha2Ugc3VyZSBRRU1VDQo+ID4gU01NVXYzIGZlYXR1cmVzIGFyZSBjb21wYXRpYmxl
IHdpdGggdGhlIGhvc3QgU01NVXYzLg0KPiA+DQo+ID4gTm90IGFsbCBmaWVsZHMgaW4gdGhlIGhv
c3QgU01NVXYzIElEUiByZWdpc3RlcnMgYXJlIG1lYW5pbmdmdWwgZm9yDQo+IHVzZXJzcGFjZS4N
Cj4gPiBPbmx5IHRoZSBmb2xsb3dpbmcgZmllbGRzIGNhbiBiZSB1c2VkOg0KPiA+DQo+ID4gICAt
IElEUjA6IFNUX0xFVkVMLCBURVJNX01PREVMLCBTVEFMTF9NT0RFTCwgVFRFTkRJQU4sIENEMkws
IEFTSUQxNiwNCj4gVFRGDQo+ID4gICAtIElEUjE6IFNJRFNJWkUsIFNTSURTSVpFDQo+ID4gICAt
IElEUjM6IEJCTUwsIFJJTA0KPiA+ICAgLSBJRFI1OiBWQVgsIEdSQU42NEssIEdSQU4xNkssIEdS
QU40Sw0KPiA+DQo+ID4gRm9yIG5vdywgdGhlIGNoZWNrIGlzIHRvIG1ha2Ugc3VyZSB0aGUgZmVh
dHVyZXMgYXJlIGluIHN5bmMgdG8gZW5hYmxlDQo+ID4gYmFzaWMgYWNjZWxlcmF0ZWQgU01NVXYz
IHN1cHBvcnQuDQo+ID4NCj4gPiBTaWduZWQtb2ZmLWJ5OiBTaGFtZWVyIEtvbG90aHVtIDxza29s
b3RodW10aG9AbnZpZGlhLmNvbT4NCj4gPiAtLS0NCj4gPiAgaHcvYXJtL3NtbXV2My1hY2NlbC5j
IHwgMTAwDQo+ID4gKysrKysrKysrKysrKysrKysrKysrKysrKysrKysrKysrKysrKysrKysrDQo+
ID4gIDEgZmlsZSBjaGFuZ2VkLCAxMDAgaW5zZXJ0aW9ucygrKQ0KPiA+DQo+ID4gZGlmZiAtLWdp
dCBhL2h3L2FybS9zbW11djMtYWNjZWwuYyBiL2h3L2FybS9zbW11djMtYWNjZWwuYyBpbmRleA0K
PiA+IGEyZGVkYTNjMzIuLjhiOWY4OGRkOGUgMTAwNjQ0DQo+ID4gLS0tIGEvaHcvYXJtL3NtbXV2
My1hY2NlbC5jDQo+ID4gKysrIGIvaHcvYXJtL3NtbXV2My1hY2NlbC5jDQo+ID4gQEAgLTI4LDYg
KzI4LDk4IEBAIE1lbW9yeVJlZ2lvbiByb290Ow0KPiA+ICBNZW1vcnlSZWdpb24gc3lzbWVtOw0K
PiA+ICBzdGF0aWMgQWRkcmVzc1NwYWNlICpzaGFyZWRfYXNfc3lzbWVtOw0KPiA+DQo+ID4gK3N0
YXRpYyBib29sDQo+ID4gK3NtbXV2M19hY2NlbF9jaGVja19od19jb21wYXRpYmxlKFNNTVV2M1N0
YXRlICpzLA0KPiA+ICsgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICBzdHJ1Y3QgaW9t
bXVfaHdfaW5mb19hcm1fc21tdXYzICppbmZvLA0KPiA+ICsgICAgICAgICAgICAgICAgICAgICAg
ICAgICAgICAgICBFcnJvciAqKmVycnApIHsNCj4gDQo+ID4gKyAgICAvKiBRRU1VIFNNTVV2MyBz
dXBwb3J0cyBhcmNoaXRlY3R1cmUgdmVyc2lvbiAzLjEgKi8NCj4gPiArICAgIGlmIChpbmZvLT5h
aWRyIDwgcy0+YWlkcikgew0KPiA+ICsgICAgICAgIGVycm9yX3NldGcoZXJycCwgIkhvc3QgU01N
VXYzIGFyY2hpdGVjdHVyZSB2ZXJzaW9uIG5vdCBjb21wYXRpYmxlIik7DQo+ID4gKyAgICAgICAg
cmV0dXJuIGZhbHNlOw0KPiA+ICsgICAgfQ0KPiANCj4gV2h5IGhhcyB0aGlzIHJlcXVpcmVtZW50
Pw0KDQpSaWdodC4gVGhhdCB3YXMgYWRkZWQgYmFzZWQgb24gYSBjb21tZW50IGZyb20gRXJpYyBo
ZXJlLA0KaHR0cHM6Ly9sb3JlLmtlcm5lbC5vcmcvYWxsL2I2MTA1NTM0LTRhMTctNDcwMC1iYjBi
LWU5NjFiYWJkMTBiYkByZWRoYXQuY29tLw0KDQo+IFdlIGhhdmUgU01NVXYzIHZlcnNpb24gMy4w
IGFuZCBpbmZvLT5haWRyID0gMC4NCj4gYW5kIHFlbXUgZmFpbHMgdG8gYm9vdCBoZXJlLg0KDQpI
bW0uLiBJdCBpcyB0cnVlIHRoYXQgdGhlcmUgYXJlIGhhcmR3YXJlIG91dCB0aGVyZSB3aGljaCBp
bXBsZW1lbnRzIGEgY3Jvc3MNCnNlY3Rpb24gb2YgZmVhdHVyZXMgZnJvbSBhcmNoaXRlY3R1cmUg
cmV2aXNpb25zLg0KDQpTaW5jZSB3ZSBhcmUgY2hlY2tpbmcgdGhlIElEIHJlZ2lzdGVycyB0aGF0
IG1hdHRlcnMgaGVyZSBpbmRpdmlkdWFsbHkgYW55d2F5LA0KSSBhbSBub3Qgc3VyZSB3aGV0aGVy
IHdlIHNob3VsZCByZXN0cmljdCB0aG9zZSB3aXRoIEFJRFIgbWlzbWF0Y2ggb3IganVzdA0Kd2Fy
biB0aGUgdXNlci4NCg0KVGhhbmtzLA0KU2hhbWVlcg0KDQoNCg0K

