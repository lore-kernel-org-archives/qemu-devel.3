Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 552CFFF8855
	for <qemu-devel@archiver.kernel.org>; Tue,  5 May 2026 15:14:55 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wKHTK-0007ko-0M; Tue, 05 May 2026 11:14:06 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <skolothumtho@nvidia.com>)
 id 1wKHTG-0007k1-BF; Tue, 05 May 2026 11:14:03 -0400
Received: from mail-eastusazlp170120007.outbound.protection.outlook.com
 ([2a01:111:f403:c101::7] helo=BL0PR03CU003.outbound.protection.outlook.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <skolothumtho@nvidia.com>)
 id 1wKHTE-0001eN-Kh; Tue, 05 May 2026 11:14:02 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=UXx2AgMKbKVT6uZkkDIomkH5aOxAsLdhhcrIWr/W0CPWaZKOftSI/GD08VdysSOFgNGX9i/c9NTb5a/ZF6ffX+fhWN0S3LFY+AKTOvegJoeinNk0NEhsP/e6XI8tAms2aZhGfvnMwpe/C5C4gaNeeEuMqOASS1NSZbzhX94RncPU5cQ981slVy3N9e2tUwMGxgOK8ZQHI25iWvJ2pNszB2vg770akMfTKx9+UDTYBOLvmrW4saqIE0Srlh+fz2fMMvfPcmjlQBc3Zf3zaGlOZ3ZALjpQ5WpbiwMmlYhc4YIdpYg4UPdDoihYzJGur44k3jWV8u7gpYtcWsGxxsH5DQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=L6BG1nHw50KwSIj8FyVuUXs2TTMetdP67NDQCOmoCyw=;
 b=w7jcBACSYrKbugN9USZXalxZQMf0ats+iJ92qW/w6FAywvq1G2gQm841I32gmygUPs6n4CWZ2zzDEeEDe6iujlNaWT/nYNSffOYrpymC4//EaAnKgSjSSe2WGTZNcgqFtjSfPx7qtIC60x41qIBQYnF6F6snR0B9tw9bcHFGB2WZDzzIJiR3cuS9pB88MhwUmOB1mv0VEDPleycehFYMHyoB7LQi0l2zzHUtA8Hypv4pXt7+n2RQPHenjdVQ/9awWklw9oAoPSivca/4z5xaVRLY53m2t6aFyMJd7RIVWkTtey/0/n0uEL+KcqN357vPJZgviw6muHHZox/jQUkeGw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=L6BG1nHw50KwSIj8FyVuUXs2TTMetdP67NDQCOmoCyw=;
 b=bD8dY1x8KR3/MC1FyU7UGll3ikfmN+0xW6XXYzwFQhenwOfrvyvthbKoqgAXy/CSYGlhjQ8mH06hqE9Y1dB2i7o3fOanhkP363VQv3na6kr6oQQYixoUn8A+GrpPC2O+x/h7jAyPi8i870vOns+x8ExyB9DMbDzE5r7JPuaAxk8E45sCcNW4v+fai9aiCzsZHOJRCEOgP5LNXANEwJRGGNc5GOIZVd4S/EysC6jFfKkxckj0fPVBcGYylHL4X3pclavx6dXcxXSC+7g/QWK3LKk9pNo1FLLFV3zOQNtVpiQS4LeIrEZ8biE8INH4U+6cUEakGN6z2dfSdsHehSQ9Mw==
Received: from CH3PR12MB7548.namprd12.prod.outlook.com (2603:10b6:610:144::12)
 by BL1PR12MB5707.namprd12.prod.outlook.com (2603:10b6:208:386::10)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9870.27; Tue, 5 May
 2026 15:13:40 +0000
Received: from CH3PR12MB7548.namprd12.prod.outlook.com
 ([fe80::b710:d6a1:ab16:76de]) by CH3PR12MB7548.namprd12.prod.outlook.com
 ([fe80::b710:d6a1:ab16:76de%6]) with mapi id 15.20.9870.023; Tue, 5 May 2026
 15:13:40 +0000
From: Shameer Kolothum Thodi <skolothumtho@nvidia.com>
To: Nicolin Chen <nicolinc@nvidia.com>
CC: "qemu-arm@nongnu.org" <qemu-arm@nongnu.org>, "qemu-devel@nongnu.org"
 <qemu-devel@nongnu.org>, "eric.auger@redhat.com" <eric.auger@redhat.com>,
 "peter.maydell@linaro.org" <peter.maydell@linaro.org>, "clg@redhat.com"
 <clg@redhat.com>, "alex@shazbot.org" <alex@shazbot.org>, Nathan Chen
 <nathanc@nvidia.com>, Matt Ochs <mochs@nvidia.com>, Jiandi An
 <jan@nvidia.com>, Jason Gunthorpe <jgg@nvidia.com>,
 "jonathan.cameron@huawei.com" <jonathan.cameron@huawei.com>,
 "zhenzhong.duan@intel.com" <zhenzhong.duan@intel.com>, Krishnakant Jaju
 <kjaju@nvidia.com>, "phrdina@redhat.com" <phrdina@redhat.com>
Subject: RE: [PATCH v4 20/31] hw/arm/tegra241-cmdqv: Use mmap'd VINTF page0 as
 VCMDQ backing
Thread-Topic: [PATCH v4 20/31] hw/arm/tegra241-cmdqv: Use mmap'd VINTF page0
 as VCMDQ backing
Thread-Index: AQHczMa/jfzTjyAD+0CcG7hTHjM1ybX+uL4AgADqScA=
Date: Tue, 5 May 2026 15:13:40 +0000
Message-ID: <CH3PR12MB754892989B2A76D3D3A941D6AB3E2@CH3PR12MB7548.namprd12.prod.outlook.com>
References: <20260415105552.622421-1-skolothumtho@nvidia.com>
 <20260415105552.622421-21-skolothumtho@nvidia.com>
 <afk+zBZLQx+x+ODl@nvidia.com>
In-Reply-To: <afk+zBZLQx+x+ODl@nvidia.com>
Accept-Language: en-US, en-GB
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: CH3PR12MB7548:EE_|BL1PR12MB5707:EE_
x-ms-office365-filtering-correlation-id: bad4736d-7604-40f1-a82a-08deaab8e3b3
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
 ARA:13230040|1800799024|376014|366016|38070700021|18002099003|56012099003|22082099003;
x-microsoft-antispam-message-info: RELlBtopAvZXopyJIq4wOM4scoolV65/fRIPaUqT1g2OLqXievVvybM+Hp0x9ujth0/uQatvDd4UAVaXdGDGv90XhtQ66DuR86vOeVVV5Ztq9cjaMFj7t71r49oeUaOrZrGoNzlWIkKo82hUjo+okrEGEu9QxRfzbD9eA9BsyWBi0BLTkmwwjJUT5a0ztQU4WlAZ5fz6Xc/riusf4MKu4yhF7SvdVojnuXnJlNkFtXj7hdTF4O8kVaFx7ZJkjugsod1cm4qGBVdcEWq8KPFrQmyTJ4WhPLgJbXeJDpw4Iw6EpAUunqR7DgafWhLTlucdbljRzrjei22pg9ueRzDfPwO8ZRoUrUtDFwjKMYedbAaXdJQ5/GqjsdR614+iGTyVGSubV+Mfy419dUlbIZsetbHWShCCRmOqxKT6NUMO1mEoWqzW/4a1tbruJTYc/J+5PxwjUyqjKh5mm+ZAXjRHfLfDve4QIBlEI+Yjce1/phj9l55gsoN7a4xVed+FhrqBKrmxApLKFwrR2hibCOhKcibfJa9UGIo6m1TEJ0grcmEaUUDneAcueGRq/hsz8rStrr8JjhsiE09eXCmSFbQXHq35jhkY94h2OcGyBCUUtbYQeqk5Kayu6M9wzGES3B5LgV2DPSwwGQROorl9OuN7DpemzUfGzy5p/i6HjUjamx2PSt7X1OzYT/a7zJB0/8uwhH2p1RLyEsiFF0y+mQCKyMWgyAHEQ+kL/vhcrImsu/xnMlmcGKfzbWWGZDaAMJ0X
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:CH3PR12MB7548.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(1800799024)(376014)(366016)(38070700021)(18002099003)(56012099003)(22082099003);
 DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?g78lb7gk4dEETFgeQ/YXvb5/sh8hCU84/A+BJbFEvoPFaT9ZxbOZ2KNOnYGT?=
 =?us-ascii?Q?C4u3+4BHUgieIx4VzPJFzDviSnM4Iej9gAOSsZgOMLF7VURkrjw1rpZjH9Nb?=
 =?us-ascii?Q?pQU6n39S2I7rEZHmW9l4Fjl7L8TqepIRHNdffkEatboie7eW93QJeEiDTWkd?=
 =?us-ascii?Q?VjxZ7GJOkq3olzOMAYRs+5vDnp03AnjAxxS9j1QZKO5jfKqYCuUEql41GvQc?=
 =?us-ascii?Q?ouRqRCDQ61gj2s/F9Sd9HJF+mRrU9udBmE5ufRJvQLgeGBSphOFBrJU8t+q+?=
 =?us-ascii?Q?t4EhiUMzQ8BcxtQYdENe68AKw8pRcDxDKuWGdF68LM3PpXPstj8XDK8OinqU?=
 =?us-ascii?Q?e3xBAE4/DRty93DPinjgRCbOPE1E+nz9eLNjsZFAFAl9Aw355PMq+frSkO0H?=
 =?us-ascii?Q?sM4qIVl6zUv+O/r9qrBx+gZbl0TwJys6x1ra/BTLddUKUduwVMhuHhcpHgwL?=
 =?us-ascii?Q?YzBofv93lgp+0k3sQax6LsYlHfQB6f3+62L4l6/o+zMDjQPutU19GvlJ+nMA?=
 =?us-ascii?Q?5y/lfDEJZddFCRGujNxcsfCUnjkRsZnnmya/2kb4R/GDERwKdQ9aT8kLbw3T?=
 =?us-ascii?Q?Gh9YxSLWJBeg1igml4v04AOmgr1gpd6DHmZPkX47qIaaNwNYSm3b/9wNFqR/?=
 =?us-ascii?Q?rdNdT8jRT2gnRxMICCg1jCb0BhilobjN22QsYXdizmiLZ440pShiIjSDe0dD?=
 =?us-ascii?Q?ol9iRP/esbhGf5u6eAo088J3+I9Mfh/nE4Py8qSjn+hZAbaXGtPh5ZeObjIw?=
 =?us-ascii?Q?lPzmKkAQJF3BbHsn9keTk4pxhnBSDY366XLedx3Qd3oY6DmOtzsL4wTiLUHo?=
 =?us-ascii?Q?TzCSjjHzfGTZQINQF+46hayxiNGAv7UUR4XZgnUybCjOUmiV9J/DuH0ZkKIq?=
 =?us-ascii?Q?+aXhDRc8b6BTxBx3moKPsMNbZnKMYBsSsu+ceqRQy1SZ0Onx5b3fKqnYWL/x?=
 =?us-ascii?Q?Z1FJVdyqYDqyfejJomUCBnq2QsjiODCebtr7BgGHMO8pDcH112ITqguGGZdx?=
 =?us-ascii?Q?kkm1YDZUezmaXD0CdH+2BrUn8TvHkGx2a6acvL776nz92RI6kLGtbP36CTJh?=
 =?us-ascii?Q?v/sg7vPYXx/iH+UfqCGxxe6XKr388tvTGYmWa5KxYC3SQuKlWmaJl2jnZ3kO?=
 =?us-ascii?Q?XeVG+x72wM0SqclBa814O5CbR+AQBPToJMrJlmGJRqiBDwXImJaCQ+TFSoHI?=
 =?us-ascii?Q?LwtlC5H4LbgRqGp9kzLe3u4HICl5Rj/0VwguLG9nKzhYCiDYbI8YJhefC7pb?=
 =?us-ascii?Q?TmHYjCQBSL936u5hiGC+imggKI96SLTPm1X/DkH7yG10Gay+6oKmbt9Zre+8?=
 =?us-ascii?Q?yeXYFr0A4Lk1vqZ083XHuCb3vjjy8Brx+rQFXapOK8ai5+KBG1kaa5aWzuAG?=
 =?us-ascii?Q?eHzukcAKTXmKKPkqQZnkpk7TKYjj/r5J5p4edvmCX/3Sf9AtoT+vbu/ocRhQ?=
 =?us-ascii?Q?cBdpyAa2OF9ErVnw1r+husqNyGMdE92oSBV2cQQUeeUnUsYVjJqud/Pdk5ej?=
 =?us-ascii?Q?wIf2Ew6R/MU0xc4New/p2WJ0O2EAvXm+DZ0+wi+/Ma1y8IbZopa7KYPXGlgG?=
 =?us-ascii?Q?Vg1VlP96XNOxJBTR4Fj30bk4LYPC30fvXtXzhkoCgN38HAh2PJkCj/o8hgNc?=
 =?us-ascii?Q?Ni6F2LcFHsToucxrPfGkMMjeQPtPflydHLXZrrM01tyNp4NScnmyPhKHfsB9?=
 =?us-ascii?Q?7NxkU0Fwo1MmhMxIeaoUVPkCiovhbWnL5UWSaPPIuECqHldxbdRZg/6kXkX0?=
 =?us-ascii?Q?++5Rf7+Xew=3D=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: CH3PR12MB7548.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: bad4736d-7604-40f1-a82a-08deaab8e3b3
X-MS-Exchange-CrossTenant-originalarrivaltime: 05 May 2026 15:13:40.3865 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: oHf5sdXD4dMxsaHAUY6u3jfPUdIfQ4p9lMlzxfPsdFggvYG09LK7W+0RmPJOR88FzfYu9OoWykCuxmq4RgNx7w==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BL1PR12MB5707
Received-SPF: permerror client-ip=2a01:111:f403:c101::7;
 envelope-from=skolothumtho@nvidia.com;
 helo=BL0PR03CU003.outbound.protection.outlook.com
X-Spam_score_int: -24
X-Spam_score: -2.5
X-Spam_bar: --
X-Spam_report: (-2.5 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.443,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 SPF_NONE=0.001 autolearn=ham autolearn_force=no
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



> -----Original Message-----
> From: Nicolin Chen <nicolinc@nvidia.com>
> Sent: 05 May 2026 01:50
> To: Shameer Kolothum Thodi <skolothumtho@nvidia.com>
> Cc: qemu-arm@nongnu.org; qemu-devel@nongnu.org;
> eric.auger@redhat.com; peter.maydell@linaro.org; clg@redhat.com;
> alex@shazbot.org; Nathan Chen <nathanc@nvidia.com>; Matt Ochs
> <mochs@nvidia.com>; Jiandi An <jan@nvidia.com>; Jason Gunthorpe
> <jgg@nvidia.com>; jonathan.cameron@huawei.com;
> zhenzhong.duan@intel.com; Krishnakant Jaju <kjaju@nvidia.com>;
> phrdina@redhat.com
> Subject: Re: [PATCH v4 20/31] hw/arm/tegra241-cmdqv: Use mmap'd VINTF
> page0 as VCMDQ backing
>=20
> On Wed, Apr 15, 2026 at 11:55:41AM +0100, Shameer Kolothum wrote:
> > The pre-to-post-alloc transition is triggered by the BASE register
> > write that initiates IOMMU_HW_QUEUE_ALLOC. No cache-to-hardware
> > synchronisation is needed at transition time. The hardware mandated
> > init sequence requires BASE to be written first; PROD_INDX, CONS_INDX
> > and CONFIG.CMDQ_EN are programmed only after BASE and are therefore
> always post-alloc.
> >
> > Any pre-alloc writes to those registers update only the register
> > cache, which is discarded at the transition.
>=20
> Is "discard" the correct action?
>=20
> Guest OS might expect HW (VM) to retain what it writes to those
> page0 registers?

As explained above, I reached that conclusion based on spec p.174/175:

Under "Enabling the Virtual CMDQ" it specifies the init order as below:

- Program the VIRT_CMDQ_BASE=20
- Init the PROD_INDX/ CONS_INDX to 0 or a consistent value
- Program the VIRT_CMDQ_CONFIG to enable the CMDQ

Since we set up the HW QUEUE on BASE write, a spec compliant guest is
expected to program the Page0 registers as above after that, and we pass
those writes directly to the VINTF Page0. There are no GERRORN writes
before HW queue setup either.

Please let me know if there is still a case to sync the registers.

Thanks,
Shameer







