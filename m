Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A0A30CCF9E3
	for <qemu-devel@archiver.kernel.org>; Tue,  4 Nov 2025 19:47:09 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vGMzY-000152-TV; Tue, 04 Nov 2025 14:46:56 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <skolothumtho@nvidia.com>)
 id 1vGMzW-00013E-9r; Tue, 04 Nov 2025 14:46:54 -0500
Received: from mail-southcentralusazlp170120001.outbound.protection.outlook.com
 ([2a01:111:f403:c10d::1] helo=SN4PR2101CU001.outbound.protection.outlook.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <skolothumtho@nvidia.com>)
 id 1vGMzU-0007OS-Ku; Tue, 04 Nov 2025 14:46:54 -0500
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=AFj+OObATrbP6kOGmMDVpicLZVv8QnwJlJxPPB/JaUIWYOpT02Ly2FgihdHoPVWSffv4ciB042vjtyOkRUrAXIzjKvUvG8LqLWjquaoY+3cC+Ge/xgI1rHLGqiK0JgXBrPIDsZbli2tjHxW7nQ+ADNjv5jEPPspfDvQmDjixKXAgh7xbyJ+iTnzbFpKE7x3L0i1edGzCoXNlN7GeDo1UeqC6FaDejIlOuOU0obDtbpdiWzs9kNr4K/zAEXt+rdmLnsgVkArlSXq2LxomK8heYIgRNgJ8FNrd1FswkLNTZs5LukPTedg5Y8kYAl5ZM8//cdCym667iLuw8OPtW5dgLw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=ZKtl+nhFeqKp7Cp46zret0sF2OtQu4bfvLZ3NYx43cE=;
 b=GrsreEt45Yr0ySxY8HmDhjnKUebwbaeQwU5vmBQvGuFPKGx4Onm6kWcXw6NgfWBItEQCBtxIK5ah7+D4JoU3WNCKQhL2zNxfxFmTOk4D4k7ybVfABOWqiFhCCm/YH96yEtJWH0YKGIE9Ur07GIhrqTf/aoxV74AZ6zMDv9qXuMAF1a9bm9GjqWRmnTHPYuvizjsobVXPIefa5KvkyIREl1QrHR64bXeKp/PCFKNPJ2mFMrjWbcKkPsxwRNpJAR7yUGF8842W3lwLe6DAk+oBGrPRJQTFXGHTXi57VOM5byP8UFi4hI21cUnQoRBv68hWvqTe1/8fkED90xTWG+41eg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ZKtl+nhFeqKp7Cp46zret0sF2OtQu4bfvLZ3NYx43cE=;
 b=BUK5beO4o4sMqL1/UiE6Pwzo3nbQK+qhWBIO0sfrc0R34vdw671JTY+qmhDNoi1ilYayrYQ/f9W56tfyr9CvYS2OcxdoOJzVcaVx5rX7Pttm9J5BS6DPjG3cSaboOBGR8kGhob2nLWekv0m60X3cnpaY3ukEjsTgC5R1jPdLErT9cIIjaSaN+splpGztn1VaAybOh+/uSZ0AC0xKAA+5oB6xrby9jKn1Nk8hYuxjRG1T2pTWtqxpp4CXmsB4eAnRtRoADv4k7j/PWDqHxAP6KziC085EL4XEyQOLVyweKs+WbqhWUB9e9iW3imRj2YW4lXnO1zIHctUue0x4ayXHOQ==
Received: from CH3PR12MB7548.namprd12.prod.outlook.com (2603:10b6:610:144::12)
 by LV5PR12MB9804.namprd12.prod.outlook.com (2603:10b6:408:303::8)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9275.16; Tue, 4 Nov
 2025 19:46:46 +0000
Received: from CH3PR12MB7548.namprd12.prod.outlook.com
 ([fe80::e8c:e992:7287:cb06]) by CH3PR12MB7548.namprd12.prod.outlook.com
 ([fe80::e8c:e992:7287:cb06%5]) with mapi id 15.20.9275.015; Tue, 4 Nov 2025
 19:46:46 +0000
From: Shameer Kolothum <skolothumtho@nvidia.com>
To: Jason Gunthorpe <jgg@nvidia.com>, Nicolin Chen <nicolinc@nvidia.com>
CC: Eric Auger <eric.auger@redhat.com>, "qemu-arm@nongnu.org"
 <qemu-arm@nongnu.org>, "qemu-devel@nongnu.org" <qemu-devel@nongnu.org>,
 "peter.maydell@linaro.org" <peter.maydell@linaro.org>, "ddutile@redhat.com"
 <ddutile@redhat.com>, "berrange@redhat.com" <berrange@redhat.com>, Nathan
 Chen <nathanc@nvidia.com>, Matt Ochs <mochs@nvidia.com>,
 "smostafa@google.com" <smostafa@google.com>, "wangzhou1@hisilicon.com"
 <wangzhou1@hisilicon.com>, "jiangkunkun@huawei.com" <jiangkunkun@huawei.com>, 
 "jonathan.cameron@huawei.com" <jonathan.cameron@huawei.com>,
 "zhangfei.gao@linaro.org" <zhangfei.gao@linaro.org>,
 "zhenzhong.duan@intel.com" <zhenzhong.duan@intel.com>, "yi.l.liu@intel.com"
 <yi.l.liu@intel.com>, Krishnakant Jaju <kjaju@nvidia.com>
Subject: RE: [PATCH v5 15/32] hw/pci/pci: Introduce optional
 get_msi_address_space() callback
Thread-Topic: [PATCH v5 15/32] hw/pci/pci: Introduce optional
 get_msi_address_space() callback
Thread-Index: AQHcTZUAOcFtPNqTvke2OSuQhL/9/rTikUkAgAAEzmCAAAPhgIAAAELQgAAFgACAAAGOMIAABOGAgAAa6oCAAAheAIAABHqAgAADPACAAAnHgIAAA3aAgAAJxwCAAAD7gIAAAKQQ
Date: Tue, 4 Nov 2025 19:46:46 +0000
Message-ID: <CH3PR12MB75487B28A865028A45757447ABC4A@CH3PR12MB7548.namprd12.prod.outlook.com>
References: <20251104151234.GG1537560@nvidia.com>
 <CH3PR12MB754877D400D19E57AFB16D0BABC4A@CH3PR12MB7548.namprd12.prod.outlook.com>
 <20251104153535.GH1537560@nvidia.com> <aQoz2+bLMJWNoVwx@Asurada-Nvidia>
 <20251104174152.GI1537560@nvidia.com> <aQo+oT0GvhDqtTuT@Asurada-Nvidia>
 <20251104180928.GK1537560@nvidia.com> <aQpJi37XslsYV+Ez@Asurada-Nvidia>
 <20251104185651.GL1537560@nvidia.com> <aQpUpv3Rde0PCCIv@Asurada-Nvidia>
 <20251104193521.GM1537560@nvidia.com>
In-Reply-To: <20251104193521.GM1537560@nvidia.com>
Accept-Language: en-US, en-GB
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: CH3PR12MB7548:EE_|LV5PR12MB9804:EE_
x-ms-office365-filtering-correlation-id: a25c964b-b533-410d-0386-08de1bdae34b
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
 ARA:13230040|366016|376014|7416014|1800799024|38070700021; 
x-microsoft-antispam-message-info: =?us-ascii?Q?yGaR3MXBcEdIvEoIp9wA8uCF8mNZqd5Aw6BdU4eQG6Y5kWAFiZ1LNzVrAwIJ?=
 =?us-ascii?Q?FwqQNaHl7nls3Qlxwqn/ka1Uk14qVjkDW7SEA93V/fT934iBIkncm64pqdKk?=
 =?us-ascii?Q?JezzWCM6lL/AFo+Dm1Ux/YIjkI9OiaNlq8GhAyIADzVbfax606izIGXjgemU?=
 =?us-ascii?Q?SOdBmxA+WOgPF8PnkgN/x3OBrwdi8SPXAiTdVyHfbgtyt5hmOcBdPta586jV?=
 =?us-ascii?Q?s2j51S+lO/oKYQj+sLZaj6K5qPitXj4nQNOYLFnxw1AUJT4w7bDvMGLXHxkU?=
 =?us-ascii?Q?xN+W1bs3foJ+Kqr9hjYlSTFaMsxrFEuCfynMwynuihIU9fgovh3GivuINh9T?=
 =?us-ascii?Q?rjICYo+/l4XqrS0y6ye307EGltRZGBpe0hoQ6tw2+MgSF5xzbTtQQys4ajfl?=
 =?us-ascii?Q?lVKWM2H8rDWtoiLnVoTOoi4qKDkR+C0MUAWwDX0LVm2BTw3im35am9gTUp1Z?=
 =?us-ascii?Q?X5f8YxC5P4ia92RBpJTpCHPL0PHKLdkhI2j0Re0ZnptYnerJpIEmQOOxv+V8?=
 =?us-ascii?Q?PhfIEc89kPwIYp6h8l2NHc6DhKrvrfA4iWMzZVxGfirjYGF5llldAYO3O2AA?=
 =?us-ascii?Q?2hGeMwLUN8sxm3B2ZThHfJnaXIWW9mp5NROXtxWF7zePsY2n0zpbV38diV/A?=
 =?us-ascii?Q?0kBxlqimRX1RWNyUVmIDajq58FbuduV0STHoJoMURph3ixjDie/75/weT5sJ?=
 =?us-ascii?Q?wl0le7TfzSP4QhQ++pTZBgAcrRQkOrSvfO0DAG9jSUDCnDH+id4FAVGxVviB?=
 =?us-ascii?Q?KuViK7Vf5tCEnWKqMn3lUNPv+Ul0V+l3Ab1ZMmxz0ytzwF71373HfXcxtZ9i?=
 =?us-ascii?Q?fYqDjBP0oahnbiEhrnRxghw3RgIZ/MSuQpeH6TjzGdBds8HXZh2PqGV+YmiP?=
 =?us-ascii?Q?E9nrBMYorM3RVQZnr3o2u6dS1FyFIaVff5FLr8w2TzgKXudNKAB4lE4lapSf?=
 =?us-ascii?Q?hoBICwvgSU4OSWA5KuFK7qYDAvdtlc8leVL1GB3EgShLkRnDRE9CiL7WALx8?=
 =?us-ascii?Q?+dqaYL1T+SnSxG/P4CjzkUxuSwZ/78DkgEr+xJmh2NIaSCyo90oaVzdUM3Up?=
 =?us-ascii?Q?lxTARNZ4iaaYSBUlIGa/njsfshaS+kzdSd4npautvLLnl8mWf08k+5m7eySD?=
 =?us-ascii?Q?CQQlsfQL6tKbrf5yh64ekpgNdkopz94Fkcq0T6e/aQJnbCd/xdYe6Hw7+ETL?=
 =?us-ascii?Q?TuYw9OwykcH6v+pAhaffJ3keNF5tWjvD6TWipX8g1c5SoY8Yib3JIWPAn0Sg?=
 =?us-ascii?Q?tIihzw/LdCOJE4XkrQn6cEKrNM07ofm8RlCv7nAj/NG8hw518AW/TcyblDoD?=
 =?us-ascii?Q?1mn1L3NCA9hyDm2x5+O9yQ2qGNs3TJPE+ITTS98zL4n0h2I+Esm6PeLZdEPj?=
 =?us-ascii?Q?65GLPEMzAPyJTjEBAbCWNnj7eXi2tm6GP617hzxRbA9lRr4ZJfpR4v4WZRAU?=
 =?us-ascii?Q?OQKu8DQZGYMNrs9W8gMBmRnGm6jKm7Pg6W8Tox5rzVK3Hf8z2rv0E6vTJGRu?=
 =?us-ascii?Q?YxJ/DGL3OyYCrTYjo87SBkfqygfeU2E6AuW5?=
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:CH3PR12MB7548.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(366016)(376014)(7416014)(1800799024)(38070700021); DIR:OUT;
 SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?8fvzSo3E/BE0Nvs5eqxMoUkV8u/YtaMBJg0SW/nnm2qD1N/i8xmtQKuvA4IR?=
 =?us-ascii?Q?MlTtlJiEHI0HTWfwn10aulYfn7XX9oxu3a0rMChrLD/dS3aKfFbc7fn5pPPL?=
 =?us-ascii?Q?ePzu/6A8VDOLSVP7mrGy1SiREBgb896GTuDmK7enmlaT7/XgPPt2DSEbnEre?=
 =?us-ascii?Q?MwMaqi8BiK3mv7OsRQKyG8K5qpzASckrp/1QQLyJpoLFPl64R9bY1ys1Aib/?=
 =?us-ascii?Q?X+wSvHYWG2/W+565+HxheuEdMLttSuMQD3/lXIud3hEpZy5ND3JhCrCmV+Od?=
 =?us-ascii?Q?RMmxEa2sv4a7LnuH7A8mfUVbZ5rTiDDeBoTXctpWNWJDUFwaP62QwC7HVMvy?=
 =?us-ascii?Q?2CNqns3OhdRlBvSWSuVz1p4uJ+qsW7p4yP+PQ81DeBwfV0yp3PFnjgcjXXbp?=
 =?us-ascii?Q?281QTHXOTIBBIeXc9NoFQaRFwmktIsJp+t342n183SlPFCDZ51kG+VBZWH0+?=
 =?us-ascii?Q?dxilyPzkuKPc6E5tqLTNuQgPuzOo6Z7+wbnW5vhDRY1bTyM2Ywt060/ebfaP?=
 =?us-ascii?Q?1kQZTQ1Mod8qCXPgKULAs5QO5LxsQV7pbJVOVZagvMgflMFuS6fJePHhOjOj?=
 =?us-ascii?Q?el2jsf0zr5tW3o0ARuZ07evW3GenTCgQ4ukFPbiQLmJM2Ia6aIL09v3edyWB?=
 =?us-ascii?Q?6Sm/qYY2xyTGkIUNTa4pa58Khq0LQZqd+TR5KL+haoKDfCzeOq1AORHwViCT?=
 =?us-ascii?Q?5pbe5L9BuiR639YlMdg/OZotfvDdHE7XLxTryY7/HGZxEixVf5g8SZIM8AcP?=
 =?us-ascii?Q?XATjy4glFavWWzZmVQP5wg8BZnYIti0z0M/gKcO2DSIjnfe+y5ntHePswUaS?=
 =?us-ascii?Q?C3Cvs1EpK2TP+KxGwiOxTQtgHDR14VpAecLLbQKv/NMnuxBTVuDbC7zBwbND?=
 =?us-ascii?Q?NxC97Lc1TBNS2Fvme+SBXR7NYPIpX9ZkUwaEkMFp1ustUsLeS7UJ5zpavLzA?=
 =?us-ascii?Q?qpuoB7JXuKsO+R3ze5gFO/2HhfLAKQ8X+9Lvf5dv4u1IAOofYi+Y4VQ7+C88?=
 =?us-ascii?Q?N1w7HkRzt6MMM/ABo7V0i1aQ2s/D6CbewJepCpKXLAyJtX07oTUoqYMcJh/X?=
 =?us-ascii?Q?APpALdMf+jszOOr/uiXFE3nyXK4qFwjDYXgadiTzanOUUVXVWOSTCUX+Be6x?=
 =?us-ascii?Q?l3su2UdMyDPb6dNUS2msFilxlJgewoJ2F45Iksfs06f5bm8h+9ukCulpM9s1?=
 =?us-ascii?Q?7cY4+o0gfv6nj/jvSuyQ6YSuO1DM1axI7vIzaYaH5aW4gABTbDL3qQA+bhp7?=
 =?us-ascii?Q?RgYuw0IwSO3NKXqboXqaJA0C+2Yy9Ur5e3ddlUwnKlQAcHWILCfzj+3qDkT3?=
 =?us-ascii?Q?5SoruFBGNH1K8pqkX/0ViRDEF4kE+i6GzqhdTB8x4iaM+0nxtUnzzsx2C+ws?=
 =?us-ascii?Q?ILtZzQRX+FxOrGIZqV1sFYp5Fn75i6Ux4BmNQHzktg2xot1jKkbrsj0U2jAQ?=
 =?us-ascii?Q?5vn3M/+WkWPhfOpY+QcfRxHvYdlrkVEyYuTSvEFuzazj5hMHRe644RRoGGpQ?=
 =?us-ascii?Q?rhSHJalaIWE7vJ2MV7tDcDmWcQEJgm7GNG7m4CSWV2OfFdnVGD4cF8FX8NeM?=
 =?us-ascii?Q?Yz4/1FFRfsQCAj05Iq8HWOiRpMRqUVc9AWnopTdx?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: CH3PR12MB7548.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: a25c964b-b533-410d-0386-08de1bdae34b
X-MS-Exchange-CrossTenant-originalarrivaltime: 04 Nov 2025 19:46:46.3138 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: SQIQ9YcnzIBQ7ID3jzhpeFXuDaDqKPhkd0y25P9srlwjtdsFKlUARz3V6GM5wG4IwYAvwefDUbH/EW5g4+sZrQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: LV5PR12MB9804
Received-SPF: permerror client-ip=2a01:111:f403:c10d::1;
 envelope-from=skolothumtho@nvidia.com;
 helo=SN4PR2101CU001.outbound.protection.outlook.com
X-Spam_score_int: -18
X-Spam_score: -1.9
X-Spam_bar: -
X-Spam_report: (-1.9 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.788,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 FORGED_SPF_HELO=1, SPF_HELO_PASS=-0.001,
 SPF_NONE=0.001 autolearn=ham autolearn_force=no
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



> -----Original Message-----
> From: Jason Gunthorpe <jgg@nvidia.com>
> Sent: 04 November 2025 19:35
> To: Nicolin Chen <nicolinc@nvidia.com>
> Cc: Shameer Kolothum <skolothumtho@nvidia.com>; Eric Auger
> <eric.auger@redhat.com>; qemu-arm@nongnu.org; qemu-
> devel@nongnu.org; peter.maydell@linaro.org; ddutile@redhat.com;
> berrange@redhat.com; Nathan Chen <nathanc@nvidia.com>; Matt Ochs
> <mochs@nvidia.com>; smostafa@google.com; wangzhou1@hisilicon.com;
> jiangkunkun@huawei.com; jonathan.cameron@huawei.com;
> zhangfei.gao@linaro.org; zhenzhong.duan@intel.com; yi.l.liu@intel.com;
> Krishnakant Jaju <kjaju@nvidia.com>
> Subject: Re: [PATCH v5 15/32] hw/pci/pci: Introduce optional
> get_msi_address_space() callback
>=20
> On Tue, Nov 04, 2025 at 11:31:50AM -0800, Nicolin Chen wrote:
> > On Tue, Nov 04, 2025 at 02:56:51PM -0400, Jason Gunthorpe wrote:
> > > On Tue, Nov 04, 2025 at 10:44:27AM -0800, Nicolin Chen wrote:
> > > > KVM would always get the IRQ from HW, since the HW is programmed
> > > > correctly. But if gIOVA->vITS is not mapped, i.e. gIOVA is given
> > > > incorrectly, it can't inject the IRQ.
> > >
> > > But this is a software interrupt, and I think it should still just
> > > ignore vMSI's address and assume it is mapped to a legal ITS
> > > page. There is just no way to validate it.
> > >
> > > Even SW MSI shouldn't fail because the vMSI has some weird IOVA in it
> > > that isn't mapped in the S2. That's wrong and is something the guest
> > > is permitted to do.
> >
> > Hmm, that feels like a self-correction? But in a baremetal case,
> > if HW is programmed with a weird IOVA, interrupt would not work,
> > right?
>=20
> Right, but qemu has no way to duplicate that behavior unless it walks
> the full s1 and s2 page tables, which we have said it isn't going to
> do.
> So it should probably just ignore this check and assume the IOVA is
> set properly, exactly the same as if it was HW injected using the RMR.

TBH, I am a bit lost here. Anyway, this is my understanding.

If we ignore and don't return the correct doorbell (gPA) here,=20
Qemu will end up invoking KVM_SET_GSI_ROUTING with wrong doorbell
which sets up the in-kernel vgic irq routing information. And when HW
raises the IRQ, KVM can't inject it properly.

Thanks,
Shameer

=20



