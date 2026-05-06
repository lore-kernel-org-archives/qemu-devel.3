Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9EE7FCD342C
	for <qemu-devel@archiver.kernel.org>; Wed,  6 May 2026 20:15:08 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wKidI-00061s-41; Wed, 06 May 2026 16:14:12 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <skolothumtho@nvidia.com>)
 id 1wKidG-000611-AU; Wed, 06 May 2026 16:14:10 -0400
Received: from mail-northcentralusazlp170120005.outbound.protection.outlook.com
 ([2a01:111:f403:c105::5] helo=CH5PR02CU005.outbound.protection.outlook.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <skolothumtho@nvidia.com>)
 id 1wKid8-0005hp-Re; Wed, 06 May 2026 16:14:10 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=li+VF3tzLuHheS13Qz8m1Zxj4jUqVLXLzQFTJa1ta0AlmhJjf0lFXNC/7iQ7QiZSv9+agyreVcAeksjfSv5byjq+oIuvKXvmRk9cAWu1XSCihb5t7oBLF9Fi9Lvl0u48dEfh1H0UheGT9gIfYyAKwdqbLfFMy4mox0By2RKkb8REER4BsINI1OPUUja1vZ6XkO0XWqp1v5AumyX+jlZi2vmttkiihTdhfK9fQAo27xnioQs8rJO1aArXX4DoYBqp0KFQWdTIDIDwp1Ilv/xm83tjpXUJ7ZTOgyXtwmvAPAHfUJN0WPZt6JQekQLB8NPWwRl2hpjBD//jWn+lTmBBeQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=XI17mEdSfe9Ca0JGjR1EPppDhbo4qgMiagH0VDehULc=;
 b=nfkaxCVkxZqMobiJfW78o6I7F3Y2j1owqyoU49Mea7ez/SQfkfMpIQiEEYmzZ7s/3uu4RSKiyuOm7ut3At2gk2EBDSmW4H3rGLnMuDPOXcIt2tJWwOscwudq8fN+V0bdvVscc72HmbcRIcXb0OTji26F5ll7SWuMa7Fw2kA4bsF/QAe63dOlYqB4UBII44byJ+C+LPZfpFv8p2ncljy6mwMSVfJi9XdfQIH3lUIGaxraXmac+bShN4qtwiBwR8Ou/b0wsWtJXbLpR1c2VSf28f9BoCwhlD5+bjRb+epGWvgdUFHp7NzCu+HNkmAE7G6IJMfd4yS28hIpOcWL+4xPxQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=XI17mEdSfe9Ca0JGjR1EPppDhbo4qgMiagH0VDehULc=;
 b=bzhTk7BOpnqLU3RR6kKR+5ywsE43nAkQb0edF72Y/1BTkM6zBTeRs78ijwBShz2EpHoCqzeERacvwRhcyLsRVaOKCTMmMX23pxaxQEsguzWI2BH1uI6Z/lXHEbn35TflNdz1Ee80vthi80N5R1WZYZyZl3aySCSOXqQyEflruuPOY5gTjgr2n//GBXnj3/ubyqa3D4TEnq2OleIQvm3UJ8gEd0TLszcPXpsaw68PiFkkdans+030VsCLk+VfnQqf5MlMs7VeAIufH9M4Nb7UFaJ2qDFYZiM4YkTsUzHsELlsbGTDkkVxegeenvT3wllmSsny0PtIzTSuwrSPKTX4HA==
Received: from CH3PR12MB7548.namprd12.prod.outlook.com (2603:10b6:610:144::12)
 by IA4PR12MB9761.namprd12.prod.outlook.com (2603:10b6:208:550::6)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9891.15; Wed, 6 May
 2026 20:13:53 +0000
Received: from CH3PR12MB7548.namprd12.prod.outlook.com
 ([fe80::b710:d6a1:ab16:76de]) by CH3PR12MB7548.namprd12.prod.outlook.com
 ([fe80::b710:d6a1:ab16:76de%6]) with mapi id 15.20.9891.008; Wed, 6 May 2026
 20:13:53 +0000
From: Shameer Kolothum Thodi <skolothumtho@nvidia.com>
To: Nicolin Chen <nicolinc@nvidia.com>
CC: "eric.auger@redhat.com" <eric.auger@redhat.com>, "qemu-arm@nongnu.org"
 <qemu-arm@nongnu.org>, "qemu-devel@nongnu.org" <qemu-devel@nongnu.org>,
 "peter.maydell@linaro.org" <peter.maydell@linaro.org>, "clg@redhat.com"
 <clg@redhat.com>, "alex@shazbot.org" <alex@shazbot.org>, Nathan Chen
 <nathanc@nvidia.com>, Matt Ochs <mochs@nvidia.com>, Jiandi An
 <jan@nvidia.com>, Jason Gunthorpe <jgg@nvidia.com>,
 "zhenzhong.duan@intel.com" <zhenzhong.duan@intel.com>, Krishnakant Jaju
 <kjaju@nvidia.com>, "phrdina@redhat.com" <phrdina@redhat.com>
Subject: RE: [PATCH v4 20/31] hw/arm/tegra241-cmdqv: Use mmap'd VINTF page0 as
 VCMDQ backing
Thread-Topic: [PATCH v4 20/31] hw/arm/tegra241-cmdqv: Use mmap'd VINTF page0
 as VCMDQ backing
Thread-Index: AQHczMa/jfzTjyAD+0CcG7hTHjM1ybX+uL4AgADqScCAAFTSAIABAS7QgAB7YICAABgiwA==
Date: Wed, 6 May 2026 20:13:53 +0000
Message-ID: <CH3PR12MB7548FA36B3EB6386EDF09B3CAB3F2@CH3PR12MB7548.namprd12.prod.outlook.com>
References: <20260415105552.622421-1-skolothumtho@nvidia.com>
 <20260415105552.622421-21-skolothumtho@nvidia.com>
 <afk+zBZLQx+x+ODl@nvidia.com>
 <CH3PR12MB754892989B2A76D3D3A941D6AB3E2@CH3PR12MB7548.namprd12.prod.outlook.com>
 <afpKfEvuT3ZeBSiH@nvidia.com>
 <CH3PR12MB7548E76E38625713F6AE9F78AB3F2@CH3PR12MB7548.namprd12.prod.outlook.com>
 <afuJt4lDUQ6SxA6T@nvidia.com>
In-Reply-To: <afuJt4lDUQ6SxA6T@nvidia.com>
Accept-Language: en-US, en-GB
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: CH3PR12MB7548:EE_|IA4PR12MB9761:EE_
x-ms-office365-filtering-correlation-id: fb639442-006f-4c62-08ee-08deababfe8b
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
 ARA:13230040|1800799024|376014|366016|56012099003|22082099003|18002099003|38070700021;
x-microsoft-antispam-message-info: 3dpMSrI43RWPHskAnYp66NqhdnK9VUl8x/1C3WSlPWnB4Fq7Rfkx22mpPz+pP+y06PZs256tlfkZLJRWroF7Wmt8jnlfwJzk3P1AlXWKwLnY3iIbLnYxyNMkvLCHr9yFlYMHAoognUeBYfFOWdUZJYgR2ZceXC5IRwdXkYnlMCOkS+eYKkvhe9gstcCnY9Hrfl5OUoRxUny49w6vPhh0bwtT+QzCpZFtUIjL9KxN4o9qk2WCS3MfPxjI8zO7nBjzn00FokW2Rc8HIx7SzPwrwkksK7CQECdmNJxNqTfNbBg+NPRBGd/hl3Hs6Lm5LWrsH/SNXb/Sur3hhtjQ7zXKDqMoVs73nBWLmcEpNaB18AWyFbmE+YGDg9H0J+IUtcvscZ70dYS1adLjFpZ+PTitmtrCabcsVNBnktxgA0dyPWBTlOge9WYSWkJt3sIAWNSViG6dkKJPibuZ/tMs+zxTNqxiD+VbVTqQBXDFbkbEI0VJ0oFQVX76ECqto4W9cX0xRjmVmyqklgUNZpUBEiz+DmJrKtBbIpNUiNG+g/doyugY4BkKvKMuEdMlZIFKuMNyrko7iA9BiaFpL0642CYlAWiUxir1mNBDgm6sNI1RSXpB4klJTKESsLzfgtjeQ3w7Ps/SYNg5Q3/pns6I3MMTthxs2Y4TEieizOS2SvlTVSD1vA6SAzHuGFkLUeNxpxS6GPKKDD9Ctc+r10EZYBJTz5Kac8+Db0Ol8DFGKNHFEz+V+h80NMOwasok/NW5NFlM
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:CH3PR12MB7548.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(1800799024)(376014)(366016)(56012099003)(22082099003)(18002099003)(38070700021);
 DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?QkVPbWdiczlneHA0K3hxS2ZmY0pKTXFicjRsczhCbFBZdi9WNko2c091OFBF?=
 =?utf-8?B?S1JLWFZPek9jR1Y1M1BKMzFqb3BFcGd2R0NGUDJhdzV0bitKRmNXOU1jMHYv?=
 =?utf-8?B?ak9tT3NCQ25vcDlBY0RVTmozRVczOWNzdkp0VVFDRnZOVkp3NkFnbUlZb1pk?=
 =?utf-8?B?UFNSNmNidVdSRDM4bVpwMG1BM3RHbUJTYStpMmRuSU9KQ2F2YTdFYjQ2STgw?=
 =?utf-8?B?akFZbGd1Uk9ucmZPMy81TE5yc0ZnNGhCQmxkRXV6elYzOWxGRTJibXQ5Ykxt?=
 =?utf-8?B?L1BMa1RjOTY4bm4wMWpLMXY5SkV1c2VIWHdNV2tFMzU1RVRBSG02bmVlSGl5?=
 =?utf-8?B?a2xvbVFSSVNFR3RHTHBYMkJQS2xseG9sWnp1NzBWUTBHL2xMTHZoenRMVFNT?=
 =?utf-8?B?UDVGM3BtVWlVZGRGUzR0a2JIMk9jV1hPWHNtdks0djlPWWxGb2JsWC91RlJ0?=
 =?utf-8?B?SnBkaUJHU3RBZnZxU3M5M0kvK0U0c2piUDQ3ZE5vL0FMaWU2d01ZenFxN1pF?=
 =?utf-8?B?MjA4YnQrNzhLOFlUMDVrOFphaXpydFhwZzlaaEFPZ0ZSeHBaOGN2d2lLeWJK?=
 =?utf-8?B?aXAvaisyT1Y0ZXpLRFpuOXNQdzVYdGFaUndRamhEWGk1dDlpeEhQM2s0bm1S?=
 =?utf-8?B?K3dkUEw5Qm5EdU1Cc1gyTTBwZXdycWhveThtWkVpTjB5bVgrd3RXemdFMVp1?=
 =?utf-8?B?T3dhU2I1MStPc3VTOFlmWkZKaHVqZU1GUkg5em9FazhrK2owL25JNkhlc2R1?=
 =?utf-8?B?dEh6YnM1QmdvMDNSeEwvSEhNZFhXYmdQRzVORU5iMFFVUnZLRTh5OVVnWExE?=
 =?utf-8?B?dUdLTE03eGFTTVc1TFpyQUZoSUdNME05OTZsSVpDNENaNG9oUDFXZGptMTgz?=
 =?utf-8?B?T2ZpN1JBSWxuTVdTcm9VU09BNG1ubC90WSsvaVkvQnZrS0lvdWR2WnFkRzBr?=
 =?utf-8?B?TE1nWVYzN1FmRmVLNG1nczdvbFBQdGJVNlZYZnlUTldQcDFYcHRnSllGSmFl?=
 =?utf-8?B?amM4Q200ZVZXQ05FTU4vUU1SL215RVhkU3FrMDJNeURjUFFjRlM2L0ZwSUsz?=
 =?utf-8?B?YmVxNFBTeGd5QmJyNzZiYXVydCtYL3VoblIyWVF4azc1cVl3S1M1NkllK0ZN?=
 =?utf-8?B?OG4rUU1wTlBMOHFNMTY1cUZHOFdhQThkbkxHRWJlQ0tZZWZNYzRHMzBYWnhE?=
 =?utf-8?B?UDRSZ0QzNjN4VG1YUlBhVUs3ejJQUGxaQVFEbms5MVBLbno0V2tsUldpd04v?=
 =?utf-8?B?V0poVmIxa0xmMEZnOUw1dW8wcVRTTkRqTk1PR1g3NnRUcTlHYndQMEg2MjI0?=
 =?utf-8?B?Y0p0S0RGaFY0bUNmQWRSa2NJM0FpRDhPQm9VM0ZGNHBCMWwwWEZDQlg1bDNH?=
 =?utf-8?B?K0d5SlM4TG12bFdxQWU1eUtjTTRZdTRROXVxMzdrcUNySmdIUTFpelpvam5p?=
 =?utf-8?B?SWdOMjM2b3VqTUl6eUpKOFdJSDdmQ0JkV2UzMWwrcGZ2ZHFuODVCMjlBSHNo?=
 =?utf-8?B?dHh2YWo0M1p0cFprUElLUjRNbExkc3BNbElIL0R0ajdERDBiVVRmUUFOZ25N?=
 =?utf-8?B?V2Fsb1A4eUEwQzd6MVA3cHREQjd6ZjFOaFZPOGMzNlZYRStUNVplQ0ZLUWwx?=
 =?utf-8?B?U2hMRGg1VU1yendpT0pQbEZ6UzRPRUdoUk4rcVc5VzJwRWxEU0Fma0FreDlE?=
 =?utf-8?B?ZUdJQ2J1anlmZDV6eWREZkNsN2I2NzRqbWJ4Uk4xNHRCUnFmSXRsZ2dvTVph?=
 =?utf-8?B?QncyUkV0MGpBRVVhdXJqV1hxQnV4YXRYTEhzQWNQSVNObDV4M0tyY2dWMGE3?=
 =?utf-8?B?cXNtNnVGU0lxcnN0VGdaTlZNQ2RhRzUyUHNRYXcwM1ZjdWdaQ1dEbjBEZmpn?=
 =?utf-8?B?ZWIrNXp0REY1VWxIeG5tcklrYkxQR3NVNkxzTGllblBPNytNR2l3SWI5dWU1?=
 =?utf-8?B?SW5SQzdtOVM3QTFHWmZzOXRzckpqTGRtTWlVUFJ0akRWVDdEczQzczN0RENm?=
 =?utf-8?B?M2d3YmlWbEZBbXhxei9lenhmOEZ1Z0ZncGNjMFdLKzcwTWxvL3F2Yi9MQTg5?=
 =?utf-8?B?TndvalNBUC9qUnB2YndiRHRIWXMvaUpsQ2dyajQ1cDNySXJGNnJ3YTJKRXV3?=
 =?utf-8?B?RmxhUVgxNC9ZaHhkWjhOVXdwbDNGdnRLVEMzVnNnOHpjcDZSa2p4a1ZyOTlJ?=
 =?utf-8?B?SVRrbEhDTmlpancxSm1yRzZZa3FZcHZQYmdCZGhLK1NkUlNXRURYdVorSWxI?=
 =?utf-8?B?Z3dVcUgrYmlob3IvY3dNUnlQc3gyY1QxcUk3SWxNN2ZXSFdQMkZQSlFHRzJP?=
 =?utf-8?B?dmltam5KM1ZTT3B0SkhGOWpNbjRsUUpHNldiWC95T1FMTlpwWExRZz09?=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: CH3PR12MB7548.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: fb639442-006f-4c62-08ee-08deababfe8b
X-MS-Exchange-CrossTenant-originalarrivaltime: 06 May 2026 20:13:53.1030 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: FvUdJltr4wbndgZLgJmy4kNVRABVIo5Wz3GIpW9aNs9HCsHPdb16JUnXlHUdv1v/8Z5mDucFGmmodF5CjCar1Q==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA4PR12MB9761
Received-SPF: permerror client-ip=2a01:111:f403:c105::5;
 envelope-from=skolothumtho@nvidia.com;
 helo=CH5PR02CU005.outbound.protection.outlook.com
X-Spam_score_int: -14
X-Spam_score: -1.5
X-Spam_bar: -
X-Spam_report: (-1.5 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.443,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 FORGED_SPF_HELO=1, RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_PASS=-0.001,
 SPF_NONE=0.001 autolearn=no autolearn_force=no
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

DQoNCj4gLS0tLS1PcmlnaW5hbCBNZXNzYWdlLS0tLS0NCj4gRnJvbTogTmljb2xpbiBDaGVuIDxu
aWNvbGluY0BudmlkaWEuY29tPg0KPiBTZW50OiAwNiBNYXkgMjAyNiAxOTozNQ0KPiBUbzogU2hh
bWVlciBLb2xvdGh1bSBUaG9kaSA8c2tvbG90aHVtdGhvQG52aWRpYS5jb20+DQo+IENjOiBlcmlj
LmF1Z2VyQHJlZGhhdC5jb207IHFlbXUtYXJtQG5vbmdudS5vcmc7IHFlbXUtDQo+IGRldmVsQG5v
bmdudS5vcmc7IHBldGVyLm1heWRlbGxAbGluYXJvLm9yZzsgY2xnQHJlZGhhdC5jb207DQo+IGFs
ZXhAc2hhemJvdC5vcmc7IE5hdGhhbiBDaGVuIDxuYXRoYW5jQG52aWRpYS5jb20+OyBNYXR0IE9j
aHMNCj4gPG1vY2hzQG52aWRpYS5jb20+OyBKaWFuZGkgQW4gPGphbkBudmlkaWEuY29tPjsgSmFz
b24gR3VudGhvcnBlDQo+IDxqZ2dAbnZpZGlhLmNvbT47IHpoZW56aG9uZy5kdWFuQGludGVsLmNv
bTsgS3Jpc2huYWthbnQgSmFqdQ0KPiA8a2phanVAbnZpZGlhLmNvbT47IHBocmRpbmFAcmVkaGF0
LmNvbQ0KPiBTdWJqZWN0OiBSZTogW1BBVENIIHY0IDIwLzMxXSBody9hcm0vdGVncmEyNDEtY21k
cXY6IFVzZSBtbWFwJ2QgVklOVEYNCj4gcGFnZTAgYXMgVkNNRFEgYmFja2luZw0KPiANCj4gT24g
V2VkLCBNYXkgMDYsIDIwMjYgYXQgMDY6MTY6MDBBTSAtMDcwMCwgU2hhbWVlciBLb2xvdGh1bSBU
aG9kaSB3cm90ZToNCj4gPiA+IEZyb206IE5pY29saW4gQ2hlbiA8bmljb2xpbmNAbnZpZGlhLmNv
bT4NCj4gPiA+IENvdWxkIHRoaXMgYmUgYSBjYXNlOg0KPiA+ID4gIC0gV3JpdGUgdGhlIFBST0Rf
SU5EWC8gQ09OU19JTkRYIHdpdGggYSBjb25zaXN0ZW50IHZhbHVlICgweGYpDQo+ID4gPiAgLSBQ
cm9ncmFtIHRoZSBWSVJUX0NNRFFfQkFTRQ0KPiA+ID4gIC0gUmVhZCB0aGUgUFJPRF9JTkRYL0NP
TlNfSU5EWCwgZXhwZWN0aW5nIDB4Zg0KPiA+ID4gIC0gV3JpdGUgdGhlIFBST0RfSU5EWC8gQ09O
U19JTkRYIHdpdGggMHgwDQo+ID4gPiAgLSBQcm9ncmFtIHRoZSBWSVJUX0NNRFFfQ09ORklHIHRv
IGVuYWJsZSB0aGUgQ01EUQ0KPiA+DQo+ID4gWWVzLCBpZiBHdWVzdCBpcyBub3Qgc3BlYyBjb21w
bGlhbnQgdGhlbiB0aGlzIGNhbiBiZSBhbnkgb3JkZXIuDQo+ID4NCj4gPiBIb3dldmVyLA0KPiA+
DQo+ID4gPiAgLSBQcm9ncmFtIHRoZSBWSVJUX0NNRFFfQkFTRSAtLSBzdXBwb3NlIHdlIGNhbGwg
c2V0dXBfdmNtZHEoKQ0KPiANCj4gPiB0aGVuIGtlcm5lbCB3aWxsIHJlc2V0IFBST0QvQ09OUywg
cmlnaHQ/DQo+IA0KPiBCdXQgSSBkb24ndCBoYXZlIGFuIGltcHJlc3Npb24gdGhhdCBRRU1VIG9u
bHkgc3VwcG9ydHMgR3Vlc3QgdG8gcnVuDQo+IExpbnV4Li4uDQoNCk9oIG5vLCBJIHdhcyByZWZl
cnJpbmcgdG8gaG9zdCBrZXJuZWwgYmVoYXZpb3VyIG9uIElPTU1VX0hXX1FVRVVFX0FMTE9DDQpJ
T0NUTC4gSXQgc2VlbXMgdG8gcmVzZXQgUFJPRC9DT05TIHRvIHplcm8gaW4gdGhhdCBwYXRoIGFu
ZCBJIHRob3VnaHQNCml0IHdhcyBmb2xsb3dpbmcgc3BlYyBpbiB0aGF0IGNhc2UuDQoNCj4gDQo+
ID4gQWdhaW4sIHRoZSBxdWVzdGlvbiBpcyB3aGV0aGVyIHdlIHNob3VsZCBoYW5kbGUgYWxsIHRo
ZXNlIG5vbi1jb21wbGlhbnQNCj4gPiBjYXNlcyB0byBwcmV2ZW50IHRoZSBndWVzdCBmcm9tIHNo
b290aW5nIGl0c2VsZiBpbiB0aGUgZm9vdCwgb3Igc2ltcGx5DQo+ID4gcHJvcGFnYXRlIGFueSBo
YXJkd2FyZSBlcnJvciBldmVudHMgZHVlIHRvIHRoZSBub24tY29tcGxpYW50DQo+ID4gYmVoYXZp
b3VyLg0KPiANCj4gSSBkb24ndCByZWFsbHkgZmVlbCBpdCBjb252aW5jaW5nIHRvIGNhbGwgaXQg
bm9uLWNvbXBsaWFudC4gSFcgZG9lcw0KPiBub3QgZGlzYWxsb3cgdGhhdCBiZWhhdmlvdXIuIEFs
c28sIHRoZSBmbG93IGluIG15IGV4YW1wbGUgZG9lcyBub3QNCj4gc2hvb3QgaXRzZWxmIGluIHRo
ZSBmb290OiBpdCBiYXNpY2FsbHkgZm9sbG93cyB0aGUgc3BlYyByZWNvbW1lbmRlZA0KPiBmbG93
IGJ5IGFkZGluZyBhIHByZS13cml0ZSBiZWZvcmUgcHJvZ3JhbW1pbmcgQkFTRS4gVGhlIHJlbWFp
bmluZw0KPiBzdGVwcyBhcmUgc3RpbGwgZXhhY3RseSBmb2xsb3cgdGhlIHNwZWMgcmVjb21tZW5k
YXRpb24uIFllcywgaXQgaXMNCj4gb2RkIHRvIGRvIHNvLCBidXQgaXQgaXMgbm90IGluc2FuZSB5
ZXQuIFRoZXJlIG1pZ2h0IGJlIHNvbWUgc2ltaWxhcg0KPiBjb3JuZXIgY2FzZSB0byBleGlzdCBm
b3IgY2VydGFpbiByZWFzb25zIHRoYXQgd2UgY2FuJ3QgaW1hZ2luZSB5ZXQuDQo+IA0KPiBBbmQg
YWRkaW5nIHRoZXNlIHRvIG1ha2luZyB0aGUgUUVNVSBtb2RlbCBjbG9zZXIgdG8gYSByZWFsIEhX
IGlzbid0DQo+IHNlZW1pbmdseSB2ZXJ5IGNvbnZvbHV0ZWQ/IEknZCBmZWVkIHRoZSBzcGVjIHRv
IGFuIEFJIGFuZCBydW4gc29tZQ0KPiBhbmFseXNpcyB0byBzZWUgd2hhdCBlbHNlIHdlIG5lZWQg
dG8gY292ZXIgaGVyZS4NCg0KSSBkaWQgYXNrIENsYXVkZSBvbiB0aGUgbmVlZCB0byBzeW5jIHZz
IGRpc2NhcmQoZmVlZGluZyBzcGVjIGFuZCBhbGwNCnRoaXMgZGlzY3Vzc2lvbikgYW5kIGhhZCBz
b21lIGZ1bvCfmIoNCg0KMSlGaXJzdCwgaXQgc2FpZDoNCg0KVGhpcyBzY2VuYXJpbyB3cml0ZXMg
UFJPRF9JTkRYIGJlZm9yZSBCQVNFLCB3aGljaCBpcyBleHBsaWNpdGx5DQpub24tc3BlYy1jb21w
bGlhbnQg4oCUIFRSTSBwLjE3NSAiRW5hYmxpbmcgdGhlIFZpcnR1YWwgQ01EUSINCm1hbmRhdGVz
IEJBU0UgYXMgdGhlIGZpcnN0IHN0ZXAsIHdpdGggUFJPRF9JTkRYL0NPTlNfSU5EWA0KaW5pdGlh
bGl6YXRpb24gZm9sbG93aW5nLiBGb3IgYSBzcGVjLWNvbXBsaWFudCBndWVzdCwgUFJPRF9JTkRY
DQppcyBvbmx5IHdyaXR0ZW4gYWZ0ZXIgQkFTRSwgYXQgd2hpY2ggcG9pbnQgdmludGZfcHRyKCkg
aXMNCnZhbGlkIGFuZCB3cml0ZXMgZ28gZGlyZWN0bHkgdG8gaGFyZHdhcmUgd2l0aCBubyBkaXNj
YXJkDQppbnZvbHZlZC4NCg0KU3VwcG9ydGluZyB0aGlzIG5vbi1jb21wbGlhbnQgb3JkZXJpbmcg
d291bGQgcmVxdWlyZQ0KcmVwbGF5aW5nIGNhY2hlZCB2YWx1ZXMgYWZ0ZXIgYWxsb2MsIGFkZGlu
ZyBjb21wbGV4aXR5IGZvcg0KYmVoYXZpb3VyIHRoZSBzcGVjIGRvZXMgbm90IHBlcm1pdC4NCiAN
CjIpIEJ1dCB0aGVuIGFmdGVyIHNvbWUgcHJvbXB0IGl0IHNheXM6DQoNCkxvb2tpbmcgYXQgU01N
VXYzJ3MgcmVnaXN0ZXIgd3JpdGUgaGFuZGxlcnMsIFFFTVUgZG9lc24ndCBlbmZvcmNlDQphbnkg
cHJvZ3JhbW1pbmcgb3JkZXIgdGhlcmUgZWl0aGVyIOKAlCAgIHJlZ2lzdGVycyBhcmUgd3JpdHRl
biB0byBjYWNoZQ0KdW5jb25kaXRpb25hbGx5LiBDTURRViBzaG91bGQgZm9sbG93IHRoZSBzYW1l
IGNvbnZlbnRpb24uIFdpbGwgZml4IGJ5DQpyZXBsYXlpbmcgY2FjaGVkIFBST0RfSU5EWC9DT05T
X0lORFggdmFsdWVzIHRvIGhhcmR3YXJlIGFmdGVyDQphbGxvY19od19xdWV1ZSBzdWNjZWVkcywg
bWFraW5nIHRoZSBwcmUtdG8tcG9zdC1hbGxvYyB0cmFuc2l0aW9uDQp0cmFuc3BhcmVudCB0byB0
aGUgZ3Vlc3QuDQoNCjMpIEJ1dCBpdCBjaGFuZ2VzIHBvc2l0aW9uIGFnYWluIGlmIHlvdSBhc2sg
aW4gYSBkaWZmZXJlbnQgd2F5Og0KDQpTTU1VdjMgaGFzIG5vIGVxdWl2YWxlbnQgdHJhbnNpdGlv
biBwb2ludCB3aGVyZSBoYXJkd2FyZSB0YWtlcyBvdmVyLg0KSW4gQ01EUVYsIHRoZSBCQVNFIHdy
aXRlIGlzIGEgZnVuZGFtZW50YWwgdHJhbnNpdGlvbiDigJQgYmVmb3JlIGl0LA0KdGhlcmUgaXMg
bm8gaGFyZHdhcmUgcXVldWU7IGFmdGVyIGl0LCBoYXJkd2FyZSBvd25zIHRoZSByZWdpc3RlcnMu
DQpUaGUgQkFTRSB3cml0ZSBpcyBhIGZ1bmRhbWVudGFsIHRyYW5zaXRpb24gcG9pbnQg4oCUIGJl
Zm9yZSBpdCwgbm8NCmhhcmR3YXJlIHF1ZXVlIGV4aXN0czsgYWZ0ZXIgaXQsIGhhcmR3YXJlIG93
bnMgdGhlIFBhZ2UwIHJlZ2lzdGVycy4NClByZS1hbGxvYyB3cml0ZXMgdG8gUFJPRF9JTkRYL0NP
TlNfSU5EWCBhcmUgdW5kZWZpbmVkIGJlaGF2aW9yIGJ5DQpzcGVjLCBhbmQgImRpc2NhcmQiIGF0
IHRyYW5zaXRpb24gaXMgdGhlICAgY29ycmVjdCBjb25zZXF1ZW5jZS4NClRoZXJlJ3Mgbm90aGlu
ZyB0byAicHJlc2VydmUgYWNyb3NzIiBpbiB0aGUgU01NVXYzIGNhc2UuDQoNClNvIGl0IGdvZXMg
b24uLi4NCg0KSSB0aGluayB0aGUgc3BlYyBpcyB2YWd1ZSBhbmQgZG9lc27igJl0IGRlbWFuZCBh
IHN0cmljdCBvcmRlci4NClNvIG1heSBiZSBiZXR0ZXIgdG8gc3luYyB0aGUgcmVnaXN0ZXJzIGFm
dGVyIHRoZSBhbGxvYy4NCg0KVGhhbmtzLA0KU2hhbWVlcg0KDQoNCg0KDQo=

