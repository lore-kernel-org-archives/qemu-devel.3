Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 82601CCF9F8
	for <qemu-devel@archiver.kernel.org>; Mon,  3 Nov 2025 15:20:27 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vFwLZ-0001hW-W6; Mon, 03 Nov 2025 10:19:55 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <skolothumtho@nvidia.com>)
 id 1vFwLD-0001RX-Vn; Mon, 03 Nov 2025 10:19:34 -0500
Received: from mail-northcentralusazlp170100001.outbound.protection.outlook.com
 ([2a01:111:f403:c105::1] helo=CH1PR05CU001.outbound.protection.outlook.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <skolothumtho@nvidia.com>)
 id 1vFwL4-0005DK-1Q; Mon, 03 Nov 2025 10:19:28 -0500
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=x2le4x7seAREgf9rT9tKDhgZHcZlWNKtH0kRgg6CS5m/qd3LwB0no43B+cFkGZnFF8hoG8A3/OQ1g9gyDhfbaSsoK7Mrv8BBm19yCK3ANJGy9AMUGlioIkOA+B6gILAlr1j/U75XWr2ohw3R5P5o2gvWFWfRzSpbKq8uifqtEHHyTbXQWth7VBFNoeiYq5iBQ530/NmnDND3ryuKT+tQdAeWZjXwMvP8Fh5Qb9Ihn9ggNtHiXcgsSnm7+1thmyNqUZZxkrmTJrpIZHz/p9+GlSPCr5uUrTSRW439F1V93o9ahXBJt/TCJN+C7H5+lMb9HpBWFUwnBp1UziStN/Qung==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=tp8FBtC5vmu4E+Vum0WlONsD88Mng5eGM0hoFUqKm4s=;
 b=M9p3w2sOZ+wkzK4s76/ngR8uvB+wCV85cowFiXwtyVGAe/aYQWG1muIhnAmcye/k787WDH0+8ohO6VOXBzEM36KlKlyb5a9knMg4LsApewvL79KA/XiK3ISRhRsGY+syLKS47dwKnjnuITBM/0X7854tLfSXbF6UR3aCR8n6PF6E55IG5qkhpNB+X7KbzltFPkXq3+xXo6fnObo2l118JHPNAs3g7vf98TVEyUVHseRFLA2r6mtmDvRG8ftzt3XpCy09M+t4nC837uzuGATOvob8nwKSrtETLJooiADca4iXz04vEVkng18cBk024WI/CPsXxn7l3HPeO/CT7oE0Pw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=tp8FBtC5vmu4E+Vum0WlONsD88Mng5eGM0hoFUqKm4s=;
 b=G1qg4++DUztBQY+wNIJxMXvdE9vPd7WfVcNn+6dVPX3GY/cPzu25ushSVyUsMJeEakE7UJAnvo9eTBBbDXyNuoQahlhuXY0iDKGH7Ep9DRqDJhUi/5E10ZItjAt/Z2pqHDR3lyAIzGT9CKsG5aTSV1NWebreYEYAOt8/S12IegSLG5XmkuXeVf6p8QpGAm0LavJtipRH5RflSzkWm4h7q8/W+V92ETbLDRAu89y95+ZddIlAb7LlTbfrnPsdAYwDDWAL182I437UDeuiaONDt8krkDFJVb8WE8/s7ahrmcQzjyGKYf75TIDi/9wjMTa+7VM+BTdx4EsIReAH1G93IA==
Received: from CH3PR12MB7548.namprd12.prod.outlook.com (2603:10b6:610:144::12)
 by DM4PR12MB7646.namprd12.prod.outlook.com (2603:10b6:8:106::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9275.16; Mon, 3 Nov
 2025 15:19:09 +0000
Received: from CH3PR12MB7548.namprd12.prod.outlook.com
 ([fe80::e8c:e992:7287:cb06]) by CH3PR12MB7548.namprd12.prod.outlook.com
 ([fe80::e8c:e992:7287:cb06%5]) with mapi id 15.20.9275.015; Mon, 3 Nov 2025
 15:19:09 +0000
From: Shameer Kolothum <skolothumtho@nvidia.com>
To: Nicolin Chen <nicolinc@nvidia.com>
CC: "qemu-arm@nongnu.org" <qemu-arm@nongnu.org>, "qemu-devel@nongnu.org"
 <qemu-devel@nongnu.org>, "eric.auger@redhat.com" <eric.auger@redhat.com>,
 "peter.maydell@linaro.org" <peter.maydell@linaro.org>, Jason Gunthorpe
 <jgg@nvidia.com>, "ddutile@redhat.com" <ddutile@redhat.com>,
 "berrange@redhat.com" <berrange@redhat.com>, Nathan Chen
 <nathanc@nvidia.com>, Matt Ochs <mochs@nvidia.com>, "smostafa@google.com"
 <smostafa@google.com>, "wangzhou1@hisilicon.com" <wangzhou1@hisilicon.com>,
 "jiangkunkun@huawei.com" <jiangkunkun@huawei.com>,
 "jonathan.cameron@huawei.com" <jonathan.cameron@huawei.com>,
 "zhangfei.gao@linaro.org" <zhangfei.gao@linaro.org>,
 "zhenzhong.duan@intel.com" <zhenzhong.duan@intel.com>, "yi.l.liu@intel.com"
 <yi.l.liu@intel.com>, Krishnakant Jaju <kjaju@nvidia.com>
Subject: RE: [PATCH v5 16/32] hw/arm/smmuv3-accel: Make use of
 get_msi_address_space() callback
Thread-Topic: [PATCH v5 16/32] hw/arm/smmuv3-accel: Make use of
 get_msi_address_space() callback
Thread-Index: AQHcSsIrjXBbXMOnGEeZTI7ujWw52LThEtsw
Date: Mon, 3 Nov 2025 15:19:08 +0000
Message-ID: <CH3PR12MB7548F44E394F3A1C93B02518ABC7A@CH3PR12MB7548.namprd12.prod.outlook.com>
References: <20251031105005.24618-1-skolothumtho@nvidia.com>
 <20251031105005.24618-17-skolothumtho@nvidia.com>
 <aQVM7egZ43UaUODf@Asurada-Nvidia>
In-Reply-To: <aQVM7egZ43UaUODf@Asurada-Nvidia>
Accept-Language: en-US, en-GB
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: CH3PR12MB7548:EE_|DM4PR12MB7646:EE_
x-ms-office365-filtering-correlation-id: c3234d4e-8228-4137-bf4a-08de1aec55ec
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
 ARA:13230040|7416014|376014|1800799024|366016|38070700021|7053199007; 
x-microsoft-antispam-message-info: =?us-ascii?Q?X4Kj/6+zbPkZb2gm5mnjlRh5HJQIxRZlv6iPs++LmMTIjv4l25W+SB9StzqO?=
 =?us-ascii?Q?btLKauOJPM3uaEOkVUZoxIozwCMsnM89JbS2MpcEXmQurFAZCc5LmzSvzEuN?=
 =?us-ascii?Q?yMTJnWjTntwpeE39IGa2IsIH5GRjLpIyXnf2MqHmE5f1QmCLRQhh0mIcqlWp?=
 =?us-ascii?Q?1ynJfZg0rgeqgEY0kH9LeScTJ+zVanpcVSrci6Jm7S9EH7L0k/J+Yi9+qzFk?=
 =?us-ascii?Q?y9GOh7ohpje4Fk9/0UhGj0XLZ67MJ7B+/08oKeSmg6pM/2hjkEXJAQF/ZRQ9?=
 =?us-ascii?Q?zbNa1OEcYfapYKuzSzQKp64b7F+KUCRDywNykRQqTY5owTrfkAxidEyNIVCN?=
 =?us-ascii?Q?mkTDJd5goXrQv8bQk8D/BcEw0TPuTnR5ZS8NN9Tg0a43sO4oAYNHbywncEhe?=
 =?us-ascii?Q?K9otzeFkyOilSrxtmCIoX+NPs4Fe3UGtwXVeq83pv+E8R5uSKaTBlNoUIKJx?=
 =?us-ascii?Q?yaczBnjTIXuUBEGjBfeqkt5OI0myMVKHsnhDXQT+1CVHPA5rtOnjSG1EJdl9?=
 =?us-ascii?Q?eqDBdhjVGJ165crC7Gv9bckNm31DTG4uI0EY0Iu8spWS68DxKYOWxumQuxRM?=
 =?us-ascii?Q?RQw+yrEP+ww2NVuDa6GplcVW2OkEjfyx6zbrIfS7op1Gq/Sj1u1YmHIkiJP/?=
 =?us-ascii?Q?zz/ZMdeuW+z2WfnIWpvHxpWBH+5VpySX0OL92nIbR+tRDMm65xJQ4Pb1sLrD?=
 =?us-ascii?Q?KgEg+gNxmgyxffiShl+ZxDIOCXELeiviVI9P5Yjm5wDRoR3RF3SM+HiFV9/J?=
 =?us-ascii?Q?4mjot0b654MgQRPCorcuKus3MNjvTn8Q5QbXio01jDOXLGSHHyktvhkz6vhy?=
 =?us-ascii?Q?g6lT+smoWbJ8kpe4HAHBVYcs6+3x9CzNsC6Pt2K2fSvk+0ozQwTKwjr3L7jZ?=
 =?us-ascii?Q?NlsMXWi/SC5fsr1/BgYOA4dFa4UOoOLDGR25uPoWVL9jhrckBDGsmW+jm/g4?=
 =?us-ascii?Q?++5iK4s0pGLKgUD7aysKyVy5jt9tbGL0jaMIySIREFXpvxitGjkXgCD8YSW+?=
 =?us-ascii?Q?GNk8h1DedV0tefJtrsxze8l6OF4ZMyMhnvWXcwvozPGcNihWcvLi6paJPoLq?=
 =?us-ascii?Q?eWldjXvAz/cGuoc/Q42wE+opNwq6LABWFYn/LM9eyKyP+IXobNX31JoKB90L?=
 =?us-ascii?Q?wTNYGjaIc1fZ0CpRP24Z63u6cfPPVa7MNLNmCUrqRCnZTGWK3ZN1VTl6tjv8?=
 =?us-ascii?Q?VBk3ENIr1PxjYoCNeC24J4M96CL+HUguc62KqJ6r7jkLLVrNWM4spr/r9O0Y?=
 =?us-ascii?Q?Ezn04GvcoX2Unbk2HZTZxt6vYgefn935DDuXXH79lMAMJvp8V4JUQzSMFguX?=
 =?us-ascii?Q?WugVToloiDILcGHbHRmYkWcn2lmut8mw3WidGZDorMRPo4ukj8rBaQKrRIuY?=
 =?us-ascii?Q?RG8624/w7P1E8UadRLPIju2P5r1//oHQLBxR27X4JqjRNUJ/OaAMFJKK+qJo?=
 =?us-ascii?Q?dSnx4qXAhEBKZwL4Zrs3WPe1yWrnqDw7WTd2xwyKaI8BaSkjST8BvIOedMWV?=
 =?us-ascii?Q?5vaDJC9tYTnAlv7p3NjpbvUWnB2l5Va7OhOP?=
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:CH3PR12MB7548.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(7416014)(376014)(1800799024)(366016)(38070700021)(7053199007);
 DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?cW+X6ObpYQZ+EAyA4RN5SlmmYmzVEbSQHMvN8iQocpIMkH83Gpyvf4sOxCWj?=
 =?us-ascii?Q?tV4k7Fca1waktAOGwpFjLjeQdR02syWY/EmeTZPYnxgXSCwaPjteERRzhGys?=
 =?us-ascii?Q?cUVVcm/bvLuPB0i5BMfEXz2qR9f07HOMLukzGpMa+VHCIbah9lQWMfepLllH?=
 =?us-ascii?Q?bUrp1sxIIPLzVoQaf0dXEhn2JT1caeHQRTk0Pg+DkE26iAjKK/vrREO58H3l?=
 =?us-ascii?Q?u4OdVPS50bWnx4RiyFiGZ1KiXK+sjOu7OZX8LzJEOrYi3cUq7Rcb5P3czm+L?=
 =?us-ascii?Q?mWhWN9OYYWa/feNO2VO+ArN4Vx+G0yDR0eoSXOdLMvafbDVqG886UI+Fzqi3?=
 =?us-ascii?Q?DLsitDI/3vLJ36JbQPYLcm+2HH8Tcwt04OU8nbhkxzxtvxhCrlTpUy3qVjUx?=
 =?us-ascii?Q?jZOUBN0HHL160mI0+0RLEN0lp++RiyqjCCW6wBdygK/9PqB/1JbFWhfE0ibr?=
 =?us-ascii?Q?B1wMgnfnRkxsHnec63NscrnqC3evRdibJ5VFIReOHLdbE1KWHU+G0VTgYR7R?=
 =?us-ascii?Q?dSU6lMtWuSjHHy6B538aELqm0T29+GbMXY1C80HBjLBAnlxl+BWgst9x+IsK?=
 =?us-ascii?Q?VmuUEw3nDvTAy3d5+4XSFUGd2qFdLixVi8WOBpgsyOvoIEibGrDbh2GibauQ?=
 =?us-ascii?Q?HMMtetlKB0rw/1ynkClNuz2gfdEpsSWip9aWXC3bH/A8YK65XslIdaHvRwoH?=
 =?us-ascii?Q?W4RhCTDQuPONo03d+2erPVfONkFO3OZ88H/h2A3x+ET604l0KFvxECyJqoVF?=
 =?us-ascii?Q?Devfmc+98K+1tPyk1d4LqMTA5u36CuBX7Ck5NluFOYf/j/Nyt1n942CtfiNm?=
 =?us-ascii?Q?Kc2+hvLWEqC1pLPuHXgOvFsc51yg1sh3qHGua6z3gzYZpn/GcSmONM+bwG3x?=
 =?us-ascii?Q?Vanw4vCmat4hVI+uSxye2TR6MiXpdHasbntPvymBNe/zpnzCMFIaAD+5Rj5a?=
 =?us-ascii?Q?mH3y9/vLp/zJaUL1DWyE68oLW0DPZhgOEwn+eUgi/PkKoKhZIQjuQ+NsFGNT?=
 =?us-ascii?Q?2MfKlIP4WlesdJ55IvVSW3S/iAfhv17uOfY7OvVSWD25Ae5942gTTRCa6pVp?=
 =?us-ascii?Q?Xub1YDf7/xqTCL247znxkkSSM73amtfgTIjrVDW25wXUzsjED0/sQa9NGNq0?=
 =?us-ascii?Q?GPcGxzICuubN0a6/3eqdME7ttcy/pvrgz/6lYGh154jI0p9lx/KlGrpf7aNP?=
 =?us-ascii?Q?/Lmq7o3Qv+Hc/C7ZdBPkwSJz3PqNthDXgExmv7sXY6vXdbdCYTPrFcEQxekm?=
 =?us-ascii?Q?kwiLa1fsf6gp+IdyjOyQbV2gzmR7c8p+s4CFjEXAAijWweY8qJeWpd6sMXBd?=
 =?us-ascii?Q?QgbVoE/USueILWcnV8xd96HIqMlETbpLmWtV7EGgL6AQ+IAlznxmipoI90LW?=
 =?us-ascii?Q?EdKqs+DGgERHFXfHwpPBpzwNpb9Xk8369TPgSrSSwBoAUMzBheYiIXw+Wqw9?=
 =?us-ascii?Q?W911Ii82/+SHEjvi/XGupRWL9kDhUeJ7i+z6BOklJqu5u2XHQMgU5ZAi20+l?=
 =?us-ascii?Q?9LNN1RqQYvV17fDi6ipJep3OZwuzHKZNZlg/BfVIefUmaEELNWkuN6ZkghfZ?=
 =?us-ascii?Q?h8bgRwCUWTQnK7wA4aTLE5xDd0Hor5dCA2VvjKgd?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: CH3PR12MB7548.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: c3234d4e-8228-4137-bf4a-08de1aec55ec
X-MS-Exchange-CrossTenant-originalarrivaltime: 03 Nov 2025 15:19:08.8951 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: IUzACd2o2S1AyKmICh/OqIMmYRJygZgIFC38ri4mlro1Yld//nNB6KR9nEI4ZNisGA2caYmzYG+26TZiGRRhEg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM4PR12MB7646
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
> From: Nicolin Chen <nicolinc@nvidia.com>
> Sent: 31 October 2025 23:58
> To: Shameer Kolothum <skolothumtho@nvidia.com>
> Cc: qemu-arm@nongnu.org; qemu-devel@nongnu.org;
> eric.auger@redhat.com; peter.maydell@linaro.org; Jason Gunthorpe
> <jgg@nvidia.com>; ddutile@redhat.com; berrange@redhat.com; Nathan
> Chen <nathanc@nvidia.com>; Matt Ochs <mochs@nvidia.com>;
> smostafa@google.com; wangzhou1@hisilicon.com;
> jiangkunkun@huawei.com; jonathan.cameron@huawei.com;
> zhangfei.gao@linaro.org; zhenzhong.duan@intel.com; yi.l.liu@intel.com;
> Krishnakant Jaju <kjaju@nvidia.com>
> Subject: Re: [PATCH v5 16/32] hw/arm/smmuv3-accel: Make use of
> get_msi_address_space() callback
>=20
> On Fri, Oct 31, 2025 at 10:49:49AM +0000, Shameer Kolothum wrote:
> > +static AddressSpace *smmuv3_accel_get_msi_as(PCIBus *bus, void
> *opaque,
> > +                                             int devfn)
> > +{
> > +    SMMUState *bs =3D opaque;
> > +    SMMUPciBus *sbus =3D smmu_get_sbus(bs, bus);
> > +    SMMUv3AccelDevice *accel_dev =3D smmuv3_accel_get_dev(bs, sbus, bu=
s,
> devfn);
> > +    SMMUDevice *sdev =3D &accel_dev->sdev;
> > +
> > +    /*
> > +     * If the assigned vfio-pci dev has S1 translation enabled by Gues=
t,
> > +     * return IOMMU address space for MSI translation. Otherwise, retu=
rn
> > +     * system address space.
> > +     */
> > +    if (accel_dev->s1_hwpt) {
> > +        return &sdev->as;
> > +    } else {
> > +        return &address_space_memory;
>=20
> Should we use the global shared_as? Or is this on purpose to align
> with the "&address_space_memory" in kvm_arch_fixup_msi_route()?

Yes, that's on purpose.

Another way to handle is, if  "address_space_memory" is complete no-no,=20
to return NULL here and handle it in pci_device_iommu_msi_address_space().

I like the current approach. Possibly can update the doc for get_msi_addres=
s_space()
In previous patch to make it clear that "&address_space_memory" should be=20
returned if no msi translation is required.

Thanks,
Shameer





