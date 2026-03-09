Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3F363EFCD9A
	for <qemu-devel@archiver.kernel.org>; Mon,  9 Mar 2026 11:32:25 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vzYpg-0006sr-W9; Mon, 09 Mar 2026 07:31:33 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <skolothumtho@nvidia.com>)
 id 1vzYpf-0006ok-4u; Mon, 09 Mar 2026 07:31:31 -0400
Received: from mail-northcentralusazlp170100001.outbound.protection.outlook.com
 ([2a01:111:f403:c105::1] helo=CH1PR05CU001.outbound.protection.outlook.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <skolothumtho@nvidia.com>)
 id 1vzYpc-0007rR-Vi; Mon, 09 Mar 2026 07:31:30 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=LPdYwhKonpiF01z6BRRq7FnQyf/LxPA+l490ZrrkIWpLZK2CU5xlTTuTLBSESAR3o3tumDbPhRhvNJWHVOhEAENhpwP6Vb1PJiPZ1mDApj3In7auyunC608bDSB36Ndp96dq3jVRgcryCdzKYEi5Q+zkYalqbAChl9CYWYTtvcDnytWfT7g0SXt4U6tsYmUB3ysaRLodWjP6EHxPDpnV9WFeqpaPFshtYKcohDaew5wfuIS2fLIyKnx/WUxFlBMpnSEyNl4AM9w5GWivdjW/F64AGag1BJ2xEQNBkGUhuWtOvUn/C4ebc/MYbP9IbMiTW2kYxmREETF5GDICfRfZog==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=6thfEBdLWHsB9FFjvX8GW4ZMI+HzvwiH1X74DQRabJk=;
 b=V+His6OpJ8ynXQvIFFotKu6lcgY136RbexD44HOUh/ZqjE5RVjAPrhS/TpMGB+ZmAgn4ItpHlLYkJakyGuVdW3X7voqZVU/O1gswIM8kvN9CegYX429djmygyi+Onp7hyF3y1/ZTwaAT/b45EaD+vXNVkS7zNdzblIvFRTWIgGjCEnQCocWjab653tRGy7207EAl73MeGNloW5tjZzuCsKeb65VOCiLlAjofIFgeHczCI+aslIzx+vf24Gq/6HH42yiwA/qk2mqUn/x5Bx+ixdn8JA0n9U8e8k/rvZYk+PIxF5sirdBJSetbbxx6PzlQ6RbGFKSy1na/Ab6chJ5KVA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=6thfEBdLWHsB9FFjvX8GW4ZMI+HzvwiH1X74DQRabJk=;
 b=JEKA2uMe2Dl/0/YVVdCv1jEwwjg+iKSvWuEGcRlzG2ZG0vpSKjXTox7ibzwjzivtPWhf0KjB7JfUtwSYvzaJe2pNv6TTdRt9gK46WxDHNJrr+EUu5Z1i/3SHwoliVbjnXbuduvZ+sR3RFkX89gwSSD/PV3/4s24Bcaf2iuXPzEPV2hjCjftLcntKPr/0Rgu9MiDOQdqn4+yVAEzA33eQD72J4xU3c3p8O2+IwB340UiQ/IJSgH46hACGb4Og66CNUH0nMkFTgZ+i1iwWam4Vfp+URmgXTxf0+UPII/2iK8btsVJ3TTK5r8sIqY+awnEa4gDPce3/StjhMid4kguY9w==
Received: from CH3PR12MB7548.namprd12.prod.outlook.com (2603:10b6:610:144::12)
 by LV8PR12MB9714.namprd12.prod.outlook.com (2603:10b6:408:2a0::5)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9700.11; Mon, 9 Mar
 2026 11:31:23 +0000
Received: from CH3PR12MB7548.namprd12.prod.outlook.com
 ([fe80::b710:d6a1:ab16:76de]) by CH3PR12MB7548.namprd12.prod.outlook.com
 ([fe80::b710:d6a1:ab16:76de%5]) with mapi id 15.20.9700.010; Mon, 9 Mar 2026
 11:31:23 +0000
From: Shameer Kolothum Thodi <skolothumtho@nvidia.com>
To: "eric.auger@redhat.com" <eric.auger@redhat.com>, "qemu-arm@nongnu.org"
 <qemu-arm@nongnu.org>, "qemu-devel@nongnu.org" <qemu-devel@nongnu.org>
CC: "peter.maydell@linaro.org" <peter.maydell@linaro.org>, "clg@redhat.com"
 <clg@redhat.com>, "alex@shazbot.org" <alex@shazbot.org>, Nicolin Chen
 <nicolinc@nvidia.com>, Nathan Chen <nathanc@nvidia.com>, Matt Ochs
 <mochs@nvidia.com>, Jiandi An <jan@nvidia.com>, Jason Gunthorpe
 <jgg@nvidia.com>, "jonathan.cameron@huawei.com"
 <jonathan.cameron@huawei.com>, "zhangfei.gao@linaro.org"
 <zhangfei.gao@linaro.org>, "zhenzhong.duan@intel.com"
 <zhenzhong.duan@intel.com>, Krishnakant Jaju <kjaju@nvidia.com>,
 "phrdina@redhat.com" <phrdina@redhat.com>
Subject: RE: [PATCH v3 13/32] hw/arm/tegra241-cmdqv: Implement CMDQV vIOMMU
 alloc/free
Thread-Topic: [PATCH v3 13/32] hw/arm/tegra241-cmdqv: Implement CMDQV vIOMMU
 alloc/free
Thread-Index: AQHcpw4Fma2ObIHsrEy0JlTsVjwpILWmHESAgAAEM4A=
Date: Mon, 9 Mar 2026 11:31:22 +0000
Message-ID: <CH3PR12MB7548F5610D7F339C5DAD0E41AB79A@CH3PR12MB7548.namprd12.prod.outlook.com>
References: <20260226105056.897-1-skolothumtho@nvidia.com>
 <20260226105056.897-14-skolothumtho@nvidia.com>
 <ed5ca420-94e5-4e9e-a2c3-f59eb6ea8ada@redhat.com>
In-Reply-To: <ed5ca420-94e5-4e9e-a2c3-f59eb6ea8ada@redhat.com>
Accept-Language: en-US, en-GB
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: CH3PR12MB7548:EE_|LV8PR12MB9714:EE_
x-ms-office365-filtering-correlation-id: dc0af50f-bdec-4f6b-d282-08de7dcf646b
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
 ARA:13230040|7416014|366016|376014|1800799024|38070700021; 
x-microsoft-antispam-message-info: I99R+GmPt7TvYY6mEvNiL7YbWrsN75yxsk5vSRi+3ZBtQXMsjrBou9dD8qWsik7VGfIs7/dNwVWcanbyV9Ie8zMMiiYjUXnLGjiA/0sbaI3opjFnAZzVdMLnQJvAzVAURYkI28GQcvFWaCSg3ikTHeaCQXVKT/SOwVbermvC0RjQ5dsTSwA1OOBEUoR3iZRTAoqqwY1ADlggnOn5UsE64TZrm3CpnxuOsnuK1kJxwGSy6vMD2C7P8SLU5KyQCk8Qg5zjlbDaWj13Ix9v+7qeXaTjoFwtZDjJbHJMXJET8zyE3YroTcIsxGBgQl4gAOqAGSRlO2z11t0GMBFXC+wr0Wmy5bZUccbuC4KqaR7RXecY0+RI5+lD5Fz3DRI5FLvCArBIcsPZPfbauooS3wlTqFtx0CcXkF9bQyGZCxVDh6sShdyVk0xBRHGuEFpc1mFu2UJs2GO7a+piJdZhJAE1SIqe78JsUpSQvpJmNQ2wGHmVNr4Ck/uk2mXs3w0r1yiE/xiA/yw6AOqcfyQdsyjdI1k7ySMVdPnv4FrqM/3TKijug8h+hRr1ylMXJNYBD/0ikTL5KQZvXjqn8mQaMbpql8aPjNae9tZDkvat3ZV/qL6jz4Mlwvbnkx/pUGOJ/iIk1FAXEigx83j2SiPbNI2JyTVPGturnEc8SkhiHk8uzLFa3h2xYQSjPyGcU0tcAo0SO5H7O2+Yg/Rp/Hcqe0Qo+XV8Z/wEbbIcBc4AmHBTzYSVvWQjlZo2LMTJCrHx2yvRwNq9g7rHKg8X+ksnco/vxJWdMMgHg+yFBPrw6tFkHLI=
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:CH3PR12MB7548.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(7416014)(366016)(376014)(1800799024)(38070700021); DIR:OUT;
 SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?aEkwWDlVUVNnc0lkN1RKakJPOE9oZ2YwMlo4c25TNHBKZ3lIaGdkajhGVjYz?=
 =?utf-8?B?WkFPVzI2RW9vZSt3Z1IyVUFpY2MzODc3RHJva0p2S3RmencwOThwb3dmZnFZ?=
 =?utf-8?B?Z2EvdFpySUE5NnIxRzJUa0ZWc3phdW5RUDhLUVg4QmJ1V09kNTU4dzFKY3h3?=
 =?utf-8?B?RWdycVhhYWJHRVlEUDBycnFrS0xxdTBDaDhtK1c4ZG9iNDVlMkN3azRad2dF?=
 =?utf-8?B?ejhkTVRQK2E2Ykxad2ZoVFAxUERQZS9nN204Z2JTdUhzSCtHRkhROThuSVIr?=
 =?utf-8?B?QkNCRTdsbmNrcWJIZ0xIVUttRlQ4N0I3aWxFVnRLSWFITWlpOUtiOUlrZG1i?=
 =?utf-8?B?Yjk1dEdzN2VRSVgwbmNoKzMzOEJGYUR3SWliaXo1S2pVRlA4NmREOTdXckh6?=
 =?utf-8?B?K1hNZHRldG8veU5ydndETjQxSEZjVjFpTGxsNk4rd25lTWdvYUUwcTlNZWxT?=
 =?utf-8?B?RmdJdVZWblJNQmFUZ3Ywc09FYnltZmNuTHZNTmYxMThWRk9wWmx4RUZHSlJq?=
 =?utf-8?B?ZzNSR2IvOVl0d1o1amFwcWltRUQzNUEySS9ENmRQRmVIRmQyYU1yOHI2UlhD?=
 =?utf-8?B?TUNJSEc0bzRWT3dHSEZtZG5UMmUxd2xqaml1VHk0d0t0VmNLb2tlVUgycG83?=
 =?utf-8?B?dDBSenF1dzBQZVdQVVdFSVhJV0tDWklTNmFYSnFldGxrSzBFNDhRVHdVWStC?=
 =?utf-8?B?cWhwUlZKTzNxOS9pb3dlWi9QbXBOVE51ZC9kL1drTkRKRWZ2UnBGakt2RWZx?=
 =?utf-8?B?MXFoU2RCdHhDUlorMGRvazg4ajhVR3BudGlaR1FrL0IyNWZ0ODNZTi9HalBY?=
 =?utf-8?B?eUdjQU5lUUZLa2RJZVV6ZHRFSzlPWUw3c0dtTGl1WW5qVHN4TDhFY3NOd2cx?=
 =?utf-8?B?b3cwc25aN2hXVUM1dVdDR0hXd0hXZ3FDS01SZHhiM1BJclpiMGNSL3BuTHFB?=
 =?utf-8?B?SmdIb2k3NzYrMHU4QnIrY0pHTjNUTTUwS3U3UXpaN0VWYUtvUTc0K1Z2bldP?=
 =?utf-8?B?eHBiMVRId2RubUVCcG5NSUJoMXJrM3h4QTVzcFBXL2RhNDA0QXpQYTQxRFFJ?=
 =?utf-8?B?anhoVXNFcUJ5c3BXeXJrVlUyNnZCdUVoZFpoblE1SWhjQTVNZWtwU1BreVRB?=
 =?utf-8?B?QnJ4UTlzQW90eEt4K0ZOM3Y4THl3RHUvRnpFNUhQektGNlZJYjRCcGRRYU9D?=
 =?utf-8?B?ZjRKWE9DcTZ4ME1OMlBmMWRSZ0xKTHJ0WjVxMHdsWEd0azVBYU8xY1EzQjVn?=
 =?utf-8?B?YkgydTlqdFd3a1NSV3dlN0RmRUtYOGZGeTlqejVQYWt2dENNTERqeE1YQTM0?=
 =?utf-8?B?RkRiZVpsNHlSbGtNOVhOdTdxbjJDWG1tbWFFK0dUcTg1KzA5NWxOQUw3aVBJ?=
 =?utf-8?B?KzBQblVscG82QjNkT0tJRWpRVWJURFgyK3gveEdyME9iYUlqb1Z2UW1zV3Z4?=
 =?utf-8?B?QjRHdXlQbjdvdU1GUTFBdDhHdHNSZmRBdVBWcmVPOWdQYkZqRTVoNzdKMmVJ?=
 =?utf-8?B?THgxZVFQRzl2UWEvQ1NHZnFzc3I1amordHFieVhBcWltRnNVV0wxamJaeStq?=
 =?utf-8?B?bzZKS2k2c0hjUHN1d21QT2hFQmx5VURjNk03a2c3Y2ZySUdoOWgwM2Q1a04y?=
 =?utf-8?B?bTVHYzBGOUZaUVVuNGplTkczTWFRTkFWNm5taW0vOU9hYzEvc0RYYk9sMHpa?=
 =?utf-8?B?L0FWcEN4KzRBOUcwL3dXdGxhVHZSeTJUa3dQc3AwckhTRlBOVmRmbEtzODV6?=
 =?utf-8?B?WTcwRDZrSWdlY2F3RTJDRmlXZFFITHhSWEZ5SWhaNi9vbFpYcUIyanE2WGZ3?=
 =?utf-8?B?NXN1cFBSVVhZSDhhZHMyZTg4RUVEQVRtQjBxZW45Tnp5eTZaRlRwcWZPQUJN?=
 =?utf-8?B?L0pMRy9ja0x4d3haUXVwVEhRS1hXTVJ1d1VpMUw5Z01Jc1pzeXdhVzRiVG9T?=
 =?utf-8?B?UzFjU0xIOHZkQ3EwZEtVcG1mOXRKNkJlUWcyTVluWGZnUUY2dHNpaGpPZUFD?=
 =?utf-8?B?OG1uR0x4Tk5zdmd4dW1kU2pnaW52WDZ1amRGbHlLbzkweWpwZ2NuMUFlYWQy?=
 =?utf-8?B?bVkyY2lyMDNSblFnWGJHWkpaMHZSMlBsNmsvdWRmejl2RmJrcmdhd0dTbzVL?=
 =?utf-8?B?UFVzUVZzdmVJN3BqY29PQjAyTmJnOU1kcHJreUZBQVlWQUx5WGlscHdGVXVX?=
 =?utf-8?B?bWljTEliL0ZyVUxZeGJmeEhaSUx3UTZYb3BmZ0lScHdNalRVN0liMkFjQTZH?=
 =?utf-8?B?Q0FrTXhnbnJCc3U5eUQxbTdUK0dlMTBhVzQ0bjQ1TnAzMC84djMxRnVGelU2?=
 =?utf-8?B?SmJHR3I3alJoTWxELzI0Unh6Y1prbVVSUjU2dGZUZnhoTm5tSGdXZz09?=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: CH3PR12MB7548.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: dc0af50f-bdec-4f6b-d282-08de7dcf646b
X-MS-Exchange-CrossTenant-originalarrivaltime: 09 Mar 2026 11:31:22.9338 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: aJx85RyaoHmm1XV3ABQex17xRacy//OnBE9vOZvHwiKnGHbGDUaNE1A33x9JBgevb/MgLUnYAegPPoD109pwvg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: LV8PR12MB9714
Received-SPF: permerror client-ip=2a01:111:f403:c105::1;
 envelope-from=skolothumtho@nvidia.com;
 helo=CH1PR05CU001.outbound.protection.outlook.com
X-Spam_score_int: -10
X-Spam_score: -1.1
X-Spam_bar: -
X-Spam_report: (-1.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
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

DQoNCj4gLS0tLS1PcmlnaW5hbCBNZXNzYWdlLS0tLS0NCj4gRnJvbTogRXJpYyBBdWdlciA8ZXJp
Yy5hdWdlckByZWRoYXQuY29tPg0KPiBTZW50OiAwOSBNYXJjaCAyMDI2IDExOjA5DQo+IFRvOiBT
aGFtZWVyIEtvbG90aHVtIFRob2RpIDxza29sb3RodW10aG9AbnZpZGlhLmNvbT47IHFlbXUtDQo+
IGFybUBub25nbnUub3JnOyBxZW11LWRldmVsQG5vbmdudS5vcmcNCj4gQ2M6IHBldGVyLm1heWRl
bGxAbGluYXJvLm9yZzsgY2xnQHJlZGhhdC5jb207IGFsZXhAc2hhemJvdC5vcmc7IE5pY29saW4N
Cj4gQ2hlbiA8bmljb2xpbmNAbnZpZGlhLmNvbT47IE5hdGhhbiBDaGVuIDxuYXRoYW5jQG52aWRp
YS5jb20+OyBNYXR0DQo+IE9jaHMgPG1vY2hzQG52aWRpYS5jb20+OyBKaWFuZGkgQW4gPGphbkBu
dmlkaWEuY29tPjsgSmFzb24gR3VudGhvcnBlDQo+IDxqZ2dAbnZpZGlhLmNvbT47IGpvbmF0aGFu
LmNhbWVyb25AaHVhd2VpLmNvbTsNCj4gemhhbmdmZWkuZ2FvQGxpbmFyby5vcmc7IHpoZW56aG9u
Zy5kdWFuQGludGVsLmNvbTsgS3Jpc2huYWthbnQgSmFqdQ0KPiA8a2phanVAbnZpZGlhLmNvbT47
IHBocmRpbmFAcmVkaGF0LmNvbQ0KPiBTdWJqZWN0OiBSZTogW1BBVENIIHYzIDEzLzMyXSBody9h
cm0vdGVncmEyNDEtY21kcXY6IEltcGxlbWVudCBDTURRVg0KPiB2SU9NTVUgYWxsb2MvZnJlZQ0K
PiANCj4gRXh0ZXJuYWwgZW1haWw6IFVzZSBjYXV0aW9uIG9wZW5pbmcgbGlua3Mgb3IgYXR0YWNo
bWVudHMNCj4gDQo+IA0KPiBPbiAyLzI2LzI2IDExOjUwIEFNLCBTaGFtZWVyIEtvbG90aHVtIHdy
b3RlOg0KPiA+IEZyb206IE5pY29saW4gQ2hlbiA8bmljb2xpbmNAbnZpZGlhLmNvbT4NCj4gPg0K
PiA+IFJlcGxhY2UgdGhlIHN0dWIgaW1wbGVtZW50YXRpb24gd2l0aCByZWFsIHZJT01NVSBhbGxv
Y2F0aW9uIGZvcg0KPiA+IFRlZ3JhMjQxIENNRFFWLg0KPiA+DQo+ID4gRnJlZSB0aGUgdklPTU1V
IElEIG9uIHRlYXJkb3duLg0KPiA+DQo+ID4gU2lnbmVkLW9mZi1ieTogTmljb2xpbiBDaGVuIDxu
aWNvbGluY0BudmlkaWEuY29tPg0KPiA+IFNpZ25lZC1vZmYtYnk6IFNoYW1lZXIgS29sb3RodW0g
PHNrb2xvdGh1bXRob0BudmlkaWEuY29tPg0KPiA+IC0tLQ0KPiA+ICBody9hcm0vdGVncmEyNDEt
Y21kcXYuYyB8IDE5ICsrKysrKysrKysrKysrKysrLS0NCj4gPiAgMSBmaWxlIGNoYW5nZWQsIDE3
IGluc2VydGlvbnMoKyksIDIgZGVsZXRpb25zKC0pDQo+ID4NCj4gPiBkaWZmIC0tZ2l0IGEvaHcv
YXJtL3RlZ3JhMjQxLWNtZHF2LmMgYi9ody9hcm0vdGVncmEyNDEtY21kcXYuYyBpbmRleA0KPiA+
IDY5NTk3NjYxMjkuLmQ0ODc2MTJiYTIgMTAwNjQ0DQo+ID4gLS0tIGEvaHcvYXJtL3RlZ3JhMjQx
LWNtZHF2LmMNCj4gPiArKysgYi9ody9hcm0vdGVncmEyNDEtY21kcXYuYw0KPiA+IEBAIC0yNSwx
NCArMjUsMjkgQEAgc3RhdGljIHZvaWQgdGVncmEyNDFfY21kcXZfd3JpdGUodm9pZCAqb3BhcXVl
LA0KPiA+IGh3YWRkciBvZmZzZXQsIHVpbnQ2NF90IHZhbHVlLA0KPiA+DQo+ID4gIHN0YXRpYyB2
b2lkIHRlZ3JhMjQxX2NtZHF2X2ZyZWVfdmlvbW11KFNNTVV2M1N0YXRlICpzKSAgew0KPiA+ICsg
ICAgU01NVXYzQWNjZWxTdGF0ZSAqYWNjZWwgPSBzLT5zX2FjY2VsOw0KPiA+ICsgICAgSU9NTVVG
RFZpb21tdSAqdmlvbW11ID0gYWNjZWwtPnZpb21tdTsNCj4gPiArDQo+ID4gKyAgICBpZiAoIXZp
b21tdSkgew0KPiA+ICsgICAgICAgIHJldHVybjsNCj4gPiArICAgIH0NCj4gPiArICAgIGlvbW11
ZmRfYmFja2VuZF9mcmVlX2lkKHZpb21tdS0+aW9tbXVmZCwgdmlvbW11LT52aW9tbXVfaWQpOw0K
PiA+ICB9DQo+ID4NCj4gPiAgc3RhdGljIGJvb2wNCj4gPiAgdGVncmEyNDFfY21kcXZfYWxsb2Nf
dmlvbW11KFNNTVV2M1N0YXRlICpzLA0KPiBIb3N0SU9NTVVEZXZpY2VJT01NVUZEICppZGV2LA0K
PiA+ICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgdWludDMyX3QgKm91dF92aW9tbXVfaWQs
IEVycm9yICoqZXJycCkgIHsNCj4gPiAtICAgIGVycm9yX3NldGcoZXJycCwgIk5WSURJQSBUZWdy
YTI0MSBDTURRViBpcyB1bnN1cHBvcnRlZCIpOw0KPiA+IC0gICAgcmV0dXJuIGZhbHNlOw0KPiA+
ICsgICAgVGVncmEyNDFDTURRViAqY21kcXYgPSBzLT5zX2FjY2VsLT5jbWRxdjsNCj4gPiArDQo+
ID4gKyAgICBpZiAoIWlvbW11ZmRfYmFja2VuZF9hbGxvY192aW9tbXUoaWRldi0+aW9tbXVmZCwg
aWRldi0+ZGV2aWQsDQo+ID4gKw0KPiA+ICsgSU9NTVVfVklPTU1VX1RZUEVfVEVHUkEyNDFfQ01E
UVYsDQo+IGlmIHRoZSBvbmx5IHRoaW5rIHRoYXQgZGlmZmVycyBjb21wYXJlZCB0byBubyBjbWRx
IGlzIHRoZSB0eXBlLCBpZS4NCj4gDQo+IElPTU1VX1ZJT01NVV9UWVBFX1RFR1JBMjQxX0NNRFFW
IHZzDQo+IElPTU1VX1ZJT01NVV9UWVBFX1RFR1JBMjQxX0NNRFFWDQo+IA0KPiArIHBhc3Npbmcg
dHJ1ZSBhcmdzLCBtYXliZSB5b3UgY2FuIGp1c3QgcmVjb3JkIHRoZSB0eXBlIG9mIHRoZSBjbWRx
dg0KPiArIHRoYXQgaXMgYmVpbmcgdXNlZCBpbiB0aGUgc21tdV9hY2NlbCBkZXZpY2UuIFRoZW4g
eW91IGNhbiBnZXQgcmlkIG9mDQo+ICsgYWxsb2MgYW5kIGZyZWUNCg0KSXQgaXMgbm90IGp1c3Qg
dGhlIHR5cGUuIEJhc2VkIG9uIHRoZSB0eXBlIHdlIGFsc28gbmVlZCB0byBwYXNzLA0KDQogKiBA
ZGF0YV9sZW46IExlbmd0aCBvZiB0aGUgdHlwZSBzcGVjaWZpYyBkYXRhDQogKiBAX19yZXNlcnZl
ZDogTXVzdCBiZSAwDQogKiBAZGF0YV91cHRyOiBVc2VyIHBvaW50ZXIgdG8gYSBkcml2ZXItc3Bl
Y2lmaWMgdmlydHVhbCBJT01NVSBkYXRhDQogKg0KDQpBbmQgdGhlIGFib3ZlIGlzIGltcGxlbWVu
dGF0aW9uIHNwZWNpZmljLg0KDQpJZiBvdXIgaWRlYSBvZiB0aGUgIm9wcyIgaXMgdG8gYWxsb3cg
ZWFzaWVyIHN1cHBvcnQgZm9yIGRpZmZlcmVudCANCmltcGxlbWVudGF0aW9ucyBpbiBmdXR1cmUs
IGl0IHByb2JhYmx5IG1ha2VzIHNlbnNlIHRvIGtlZXAgdGhpcy4NCg0KVGhhbmtzLA0KU2hhbWVl
cg0KDQo+IA0KPiBFcmljDQo+IA0KPiANCj4gPiArICAgICAgICAgICAgICAgICAgICAgICAgICAg
ICAgICAgICAgICBpZGV2LT5od3B0X2lkLCAmY21kcXYtPmNtZHF2X2RhdGEsDQo+ID4gKyAgICAg
ICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgc2l6ZW9mKGNtZHF2LT5jbWRxdl9kYXRh
KSwgb3V0X3Zpb21tdV9pZCwNCj4gPiArICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAg
ICAgICBlcnJwKSkgew0KPiA+ICsgICAgICAgIHJldHVybiBmYWxzZTsNCj4gPiArICAgIH0NCj4g
PiArICAgIHJldHVybiB0cnVlOw0KPiA+ICB9DQo+ID4NCj4gPiAgc3RhdGljIHZvaWQgdGVncmEy
NDFfY21kcXZfcmVzZXQoU01NVXYzU3RhdGUgKnMpDQoNCg==

