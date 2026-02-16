Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B41EAE63F37
	for <qemu-devel@archiver.kernel.org>; Mon, 16 Feb 2026 08:42:18 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vruAu-0005DQ-8S; Mon, 16 Feb 2026 03:41:48 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <skolothumtho@nvidia.com>)
 id 1vruAm-0005Cg-MH; Mon, 16 Feb 2026 03:41:40 -0500
Received: from mail-southcentralusazlp170130001.outbound.protection.outlook.com
 ([2a01:111:f403:c10c::1] helo=SA9PR02CU001.outbound.protection.outlook.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <skolothumtho@nvidia.com>)
 id 1vruAk-00066j-Rf; Mon, 16 Feb 2026 03:41:40 -0500
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=GRf2XXWCMoZatA5UGKvjXfphoeDf7cEsqPcYT6d959SrFivxytuWal51Q/crflSqtonLmqJ+ufDq6vERM9v5R8iE3MuMQxt5qATa0BJ8gR7k1nyfYuoP/STViSVW6h1sSk7jjAq4GydYNW/zFql63kJVlLKMu8uzTbvNtMRFfI36u+WX7Y12CsBp8vwOpnaSfqIxEnVHr7LaZx2EplGPxBnSsv9vmDXJDsGoRzFbYD+IjQsmWe/BLUepw9bDahEJwueouiAlqCPdAeVwgzRNncFf1ZldIHAiOTv7Moqncu+S5Dh7F8Lt9xa4JUSNcG45dvNKWx57l+wUquhTLekWQg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Ex3/HMbkJqctp9Xi+yOaaM3hmKAmilabqPtOe983nfQ=;
 b=IfdpUgUAtGehAduOklcYT0G0er98Co12FxtrUcsA70U2T2Jdb/4Xa5F3HFwr3mk0zqTOLrcgZn4yk3Hxq3iedhxzsbxE4b1/VePpT7eglWsMNq/UMxjFn23BQYqyc5h/7b8snLez4jQzK/kzJRpL1YsA7HrBrft5q7zMbngNmHHdHt1NUZ5axIjxK0cJeODiA7DFoeZl7bJ3jyuBoSpFmLN+h3ayrVR/6zT6X1uplGO2QzASy7ziUmV+mV0FWjZPQigx3nD/UEH3+cGgG158brcVFQKY+iimus88bIDTXo3SWCaMYPLqFr5/v7RR/TcTyXcVXuTwFUnSqWjnh1H/yw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Ex3/HMbkJqctp9Xi+yOaaM3hmKAmilabqPtOe983nfQ=;
 b=ggaelLFn7TcelfP1/YcVAUJbaXBz7EfKkzIfyTEjI8biNwEjNrAdZS3D9PyfQ/kWP9hJOhvo6/ieT3sHSGcTTXIIIQYGps0gVqQlZR7zpABf6A5PtGspm6CJUX4gJcH5qGHUoPhsj00nd3VrWdE+mLzvGla4jn0eKM8jyjXAA2rGMMRpvBBLHVe3tyGtKP/Xe8ej1zvN+fLIKamdYRo921BaG7fTkoB/jpHCK0zqFur+eXEsUiNyfkXL4nF561Aq+pS908FsZjKLSZ040IAZ6kDfXIaiLinVZiI5gBTW/ARh1y3nV5fikJ9Ra7GIxbOg690+WqiQezHEc9xZOIvNPw==
Received: from CH3PR12MB7548.namprd12.prod.outlook.com (2603:10b6:610:144::12)
 by PH7PR12MB7985.namprd12.prod.outlook.com (2603:10b6:510:27b::5)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9611.16; Mon, 16 Feb
 2026 08:41:32 +0000
Received: from CH3PR12MB7548.namprd12.prod.outlook.com
 ([fe80::b710:d6a1:ab16:76de]) by CH3PR12MB7548.namprd12.prod.outlook.com
 ([fe80::b710:d6a1:ab16:76de%5]) with mapi id 15.20.9611.013; Mon, 16 Feb 2026
 08:41:32 +0000
From: Shameer Kolothum Thodi <skolothumtho@nvidia.com>
To: Nicolin Chen <nicolinc@nvidia.com>
CC: "qemu-arm@nongnu.org" <qemu-arm@nongnu.org>, "qemu-devel@nongnu.org"
 <qemu-devel@nongnu.org>, "eric.auger@redhat.com" <eric.auger@redhat.com>,
 "peter.maydell@linaro.org" <peter.maydell@linaro.org>, "clg@redhat.com"
 <clg@redhat.com>, "alex@shazbot.org" <alex@shazbot.org>, Nathan Chen
 <nathanc@nvidia.com>, Matt Ochs <mochs@nvidia.com>, Jiandi An
 <jan@nvidia.com>, Jason Gunthorpe <jgg@nvidia.com>,
 "jonathan.cameron@huawei.com" <jonathan.cameron@huawei.com>,
 "zhangfei.gao@linaro.org" <zhangfei.gao@linaro.org>,
 "zhenzhong.duan@intel.com" <zhenzhong.duan@intel.com>, Krishnakant Jaju
 <kjaju@nvidia.com>
Subject: RE: [PATCH v2 15/24] hw/arm/tegra241-cmdqv: map VINTF page0 MMIO
 region
Thread-Topic: [PATCH v2 15/24] hw/arm/tegra241-cmdqv: map VINTF page0 MMIO
 region
Thread-Index: AQHcl3fx/GgCj1yKDEmRXsQ/+bgrSLWBS9+AgAOwBIA=
Date: Mon, 16 Feb 2026 08:41:31 +0000
Message-ID: <CH3PR12MB7548C2DCA4D321D7FDE23754AB6CA@CH3PR12MB7548.namprd12.prod.outlook.com>
References: <20260206144823.80655-1-skolothumtho@nvidia.com>
 <20260206144823.80655-16-skolothumtho@nvidia.com>
 <aY+ufT8pR/N+c8q8@nvidia.com>
In-Reply-To: <aY+ufT8pR/N+c8q8@nvidia.com>
Accept-Language: en-US, en-GB
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: CH3PR12MB7548:EE_|PH7PR12MB7985:EE_
x-ms-office365-filtering-correlation-id: 50dec21c-b3cb-41e5-2079-08de6d372f80
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
 ARA:13230040|366016|376014|1800799024|7053199007|38070700021; 
x-microsoft-antispam-message-info: =?us-ascii?Q?yAyyaK7p4nI6w9sm7f0N0v6zYPi25uBcYvOtb4Wv6oo1dORsVPiZnf7OUGuR?=
 =?us-ascii?Q?D1F/tUj0yQ2ubR5GRQfVbvcWUFYsTY+/aygNl2KdCi3vqtUvs9jgvNQxwTXm?=
 =?us-ascii?Q?t9k4RWnTdbsWU0pnuqKO8Q6ZcnkPYLY1zrUtThD4vECqyy5rhtLFMSRzHqCI?=
 =?us-ascii?Q?EdDWBamfjcUKYZEHWD5hyxH/rT2UQwnqHz5ujsLwrqHNhq8VxdIeZSGWzdft?=
 =?us-ascii?Q?xYR+s1zPek+VHcO9JyfZBZ2mC9s3leGn48aEs7fGrBCUxlOS7aHPuMcuJdO/?=
 =?us-ascii?Q?KjZJLZa1E3TcwWQEj5tHYtVenfXj9ai5nW8Gym/zgoyas/U1hnAktGPcmQX8?=
 =?us-ascii?Q?erw5jxdbPhBD4pqApKr51rdN7/KrAyOIKtph90b2H0LdF+kIB5BQw1Dric04?=
 =?us-ascii?Q?sihn/Diit1Wb3ma3tRfVpRZdSjS27oUq4P/6/i7mSJVTMzRH7fHtAZXGFmww?=
 =?us-ascii?Q?0WVIuaJz8sKM5uzLU4RsS277rsFqe5MWhb1LO5Eu4S7/wKrxSlttCFCi/JJN?=
 =?us-ascii?Q?DTjSs9QZGfFun2v4TSx0dgiB+d1VwWarZJZegkopbu9mJbzF23MuMi3OWSTI?=
 =?us-ascii?Q?/3VfmO7qQz1WQo8BqU50qhmu8pAbvnZmGTnmrRsY1kMkkSw/DaGuI+HZjvJc?=
 =?us-ascii?Q?dyUwL1YkEEdVjZj4I9AiLvmEgG8LqanjPsQiLcFilaXOC//lSg4aCPFLXJZ5?=
 =?us-ascii?Q?R5rK2YyZTFW5yhBQ7qTayNNdk8I6nxT/vChS3fMh5k0mpx/3pOx4jJ1fUPCi?=
 =?us-ascii?Q?710CnVxwdYlRi9kOLJEuE425a8Y/oML5EDOzBoFcsxUMIgxXYMEqKhLp51SY?=
 =?us-ascii?Q?HmgcBbK5Id8PVGZYcFkPelnks3ltNocTjm3zkeSvPRbx02nvV8FaCc/6NBnI?=
 =?us-ascii?Q?MtLE94MRVgOw5BQWs+hOc2BX6MV4gMaGNs+OcZ2tOuo2N6oeZj66A1SrYt2U?=
 =?us-ascii?Q?bWxFAVHsd5o4jNjX0+Dm1mf543hPMRST0Sd5v+kajb2ygRysxMMxdg09Zr7S?=
 =?us-ascii?Q?OQ8tfWq77ajHxgVkSgfHrkK8P288nC/Z2L5faTzhCmiPDTH8WIXrRddOB/Dx?=
 =?us-ascii?Q?1Q18aO+D2gd6n3h1KygsWP71akcxsCms19HXQNcZIMIrgVK1BB+qCcA8/M5w?=
 =?us-ascii?Q?oU9dDnX2/uZZ8vBiMmNW5zcUzywr89JGX2FLIy2niJCdFnTP3l6fiJtyRDZr?=
 =?us-ascii?Q?R3gUdfAr7VcQn+/PP5/iZ/CuVkCe3O6ANj2FD8g7K8OAs4IRYmcHbkK7O+f+?=
 =?us-ascii?Q?QUsc7tCaVk4fT3kY20GEUieuWJgtgIOpxioIGrwiuKIYrdBhtSBZQo6YwuFW?=
 =?us-ascii?Q?vrLnd2YsiA2FeFzw6Xu7WKmaDRKVaLl3NOc7HKT1/Zlz5VElrhaWMBFCsY1G?=
 =?us-ascii?Q?GiM6F91xNsFnUiNI+mLyk4+wiAG1ns1Yxkpg4N51oPCwxLriE4l2emqG5HyA?=
 =?us-ascii?Q?sfvLbZ2pcnqqYaXrKCNPWHYaEMXt/c2zfyKVTheaMhEplGIXkt+q/ESnwSOU?=
 =?us-ascii?Q?Q46BQq/sNzN0QulvRZl5BNbAvvGiCRs0LBoq754qGWlurdV9ngGgHrQHTDAu?=
 =?us-ascii?Q?iEKuhsghX97CfP4/fswUBaK8cYbHIVXSssxnWQGCRkmXrZKAYO9tBtvX9/4S?=
 =?us-ascii?Q?6Y7d2QchGeFKsEFTN83Ey90=3D?=
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:CH3PR12MB7548.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(366016)(376014)(1800799024)(7053199007)(38070700021); DIR:OUT;
 SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?wE9+yB12oTfB2UQe68aUT/AUV7O/RCiVo7g4uAbx2QzjY1K+CxZMoldGVgs6?=
 =?us-ascii?Q?ef5hiELeiHpEZ5RuDZw/SgPSMLlcDGMuhXwBjNdHDmg7mIXeyRIfPaHQT0xH?=
 =?us-ascii?Q?E7VN0rmqbx6zqjs5cuDdEgNgFvklvU/oOqAplTFB3yl/6TebA1Rm7oMVi32B?=
 =?us-ascii?Q?1HV93yelQZNxxamD+teDc/PSf+mdWdhj1H4Fv0NOS8wm+MwWo9ndv7shkd1P?=
 =?us-ascii?Q?WjJiWqAlVR8LW3pNdDTXKTFnk3VRfYll4QkigsXDMBdkkH3giy34PT6b7NEc?=
 =?us-ascii?Q?42BuBrxyPfmzp/3H2I2xdrIVjNtvqiSbcs0wEv9s7uH6pF7vYmG9HIhPgdqe?=
 =?us-ascii?Q?GmX/luVrm5vgU9qo05GgD4ZutLXsw/uWtoayKfjJH65GEewPuFgpTPE3BC5N?=
 =?us-ascii?Q?tsrvGdjZk3RCwKxMy6FsIJScKBgmWhHFfF8v8rFz2qTm7RMc99lauHoRRuTf?=
 =?us-ascii?Q?dAfsB5uKCi3uAl3w1M6vYFEzKdyxrc9ak1cYCHht1U/0eixQZQmgu8Btnrd4?=
 =?us-ascii?Q?v+ag+o5GEG5hR6XEUt8k8ZYNZarppNSS/wOt1D7y8fE3Zob/VN1Bh3b6flt6?=
 =?us-ascii?Q?FMU4FeoY+jCZmKX/NYKUCffWvkijRmXtMdUdbn1C40RLfoDAyhLM78x5pObC?=
 =?us-ascii?Q?nC1TMG2AfXg2ksOCtRN8XO6yT7fPNBV5P+t3y/UrC08X1G/hzF0pDNKtXQEO?=
 =?us-ascii?Q?ugfxL6ltupO6cSHEgExV+IptHicOqtvnFDBGoXe+sQPgE0GrXMi2qpR+Ktzq?=
 =?us-ascii?Q?1TWA6gPPGl4bUAe1lhPmhVoAE07nD6Q6L9RhSf2fdNIYM6WscmUiG02FQwZI?=
 =?us-ascii?Q?8kR4wvUzKEHBJM3CfedteDcFh2xlbJVu0bMqrTcIfybqzFSr8JQP1pi+CpFz?=
 =?us-ascii?Q?61eJIeVaYwDtZCde9dAIf99KxJjVlErFjqoELKFHy1vXWbzedy4CanNmVziO?=
 =?us-ascii?Q?SbREwAGvZCbQPS8vgB1Gh4ZIJc5cb0e2jOrzFwaJzkB/ljMfAQKsmGk6Zn3v?=
 =?us-ascii?Q?qh6Asys1ukMsaiCOrqX6FnjIufjpUV1MmH9yr5iU42rvkjrPvXKbNKKWF3ba?=
 =?us-ascii?Q?mX+A58sPzLQKlCKuOQprJ2zDwiCvX/6gwtS89DLs7udT5gbvlXpzTvxDay5h?=
 =?us-ascii?Q?NqvWGmfTuUXIgPVR01fLOk0AV7vqToLpD5amwSTbOyc/71sV7XN82Wp9sw0a?=
 =?us-ascii?Q?iHsEh6Np2BOe6g6/P/DCHj8l9u/Wye9JGsIdLVUh7pKJrFVeOWRV1VawQ3k+?=
 =?us-ascii?Q?CeJK1HaffYKUQB6+dsMdVtxozrBA1PqmGGwW4PgBrlqY3t8gtm0qHMHCXO7S?=
 =?us-ascii?Q?L42XuovBVR5swwyIK69M+AEAX2p3+yrf/ZwrIGIS8PYWfMQ1KqpIeJrCewsZ?=
 =?us-ascii?Q?7VW1czX7KqwRjuoATzBIYMv8ZBQoyCLcU/S0YuUsinV5uRNoJC2LOaU2uTbB?=
 =?us-ascii?Q?pjihyESMElkVyHZ4th518hP7IzNw3PW4QKibrfYgvUJft8w4gWMZ5jKKyQP1?=
 =?us-ascii?Q?q+4VkUf8i/2Rm9wSbj3IgZAB7thdr0tmCDpx3HWaVEdzn+8epHV7N5jM3jCd?=
 =?us-ascii?Q?pne4FpANrfsfPka9PlkMSj3iiauCxvTxT2DBtF1kyNkrMR5EPa8gSYBsitkO?=
 =?us-ascii?Q?zTEhbLCP7pCbVtUpB/iw2x1nHL2tWkWZ+QSNlU0mlJrRrR07jOwZ4PMULpLO?=
 =?us-ascii?Q?c6Vni6yTdRixzjU9wT7QduWvJvEvvy4iWUBlrE2wmwP677a/ZZGTPpjUcD/g?=
 =?us-ascii?Q?XYB3AP6Mhg=3D=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: CH3PR12MB7548.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 50dec21c-b3cb-41e5-2079-08de6d372f80
X-MS-Exchange-CrossTenant-originalarrivaltime: 16 Feb 2026 08:41:32.0203 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 0S0Ud+QKo6Ahwv9/YaN2ro9AXcZeMDPp7rB8x+0h7j/ohedCWDtCtuIPCPbbmgHF8hyp9KYodBFFdlWdUkfwSg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH7PR12MB7985
Received-SPF: permerror client-ip=2a01:111:f403:c10c::1;
 envelope-from=skolothumtho@nvidia.com;
 helo=SA9PR02CU001.outbound.protection.outlook.com
X-Spam_score_int: -10
X-Spam_score: -1.1
X-Spam_bar: -
X-Spam_report: (-1.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 FORGED_SPF_HELO=1, SPF_HELO_PASS=-0.001,
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



> -----Original Message-----
> From: Nicolin Chen <nicolinc@nvidia.com>
> Sent: 13 February 2026 23:07
> To: Shameer Kolothum Thodi <skolothumtho@nvidia.com>
> Cc: qemu-arm@nongnu.org; qemu-devel@nongnu.org;
> eric.auger@redhat.com; peter.maydell@linaro.org; clg@redhat.com;
> alex@shazbot.org; Nathan Chen <nathanc@nvidia.com>; Matt Ochs
> <mochs@nvidia.com>; Jiandi An <jan@nvidia.com>; Jason Gunthorpe
> <jgg@nvidia.com>; jonathan.cameron@huawei.com;
> zhangfei.gao@linaro.org; zhenzhong.duan@intel.com; Krishnakant Jaju
> <kjaju@nvidia.com>
> Subject: Re: [PATCH v2 15/24] hw/arm/tegra241-cmdqv: map VINTF page0
> MMIO region
>=20
> On Fri, Feb 06, 2026 at 02:48:14PM +0000, Shameer Kolothum wrote:
> > +static void tegra241_cmdqv_map_vintf_page0(Tegra241CMDQV *cmdqv)
> > +{
> > +    char *name;
> > +
> > +    if (cmdqv->vintf_page0_mapped) {
> > +        return;
> > +    }
> > +
> > +    name =3D g_strdup_printf("%s vintf-page0",
> > +                           memory_region_name(&cmdqv->mmio_cmdqv));
> > +    memory_region_init_ram_device_ptr(&cmdqv->mmio_vintf_page0,
> > +                                      memory_region_owner(&cmdqv->mmio=
_cmdqv),
> > +                                      name, VINTF_REG_PAGE_SIZE,
> > +                                      cmdqv->vintf_page0);
> > +    memory_region_add_subregion_overlap(&cmdqv->mmio_cmdqv,
> 0x30000,
> > +                                        &cmdqv->mmio_vintf_page0, 1);
>=20
> I wonder if you see this:
>=20
> [    0.853123] arm-smmu-v3 arm-smmu-v3.0.auto: allocated 524288 entries
> for vcmdq0
> [    0.854739] arm-smmu-v3 arm-smmu-v3.0.auto: allocated 524288 entries
> for vcmdq1
> iommufd_backend_alloc_vdev  iommufd=3D142 dev_id=3D1 viommu_id=3D4
> virt_id=3D0x200 vdev_id=3D8 (0)
> iommufd_cdev_attach_ioas_hwpt  [iommufd=3D142] Successfully attached
> device 0009:01:00.0 (143) to id=3D6
> smmuv3_accel_install_ste vSID=3D0x200 ste type=3Dbypass hwpt_id=3D0x6
> iommufd_viommu_alloc_eventq  iommufd=3D142 viommu_id=3D4 type=3D1
> veventq_id=3D9 veventq_fd=3D153 (0)
> iommufd_backend_alloc_hw_queue  iommufd=3D142 viommu_id=3D4
> queue_type=3D1 index=3D0 addr=3D0xe2000000 size=3D0x800000 queue_id=3D10 =
(0)
> vfio_listener_region_add_ram region_add [ram] 0xc0b0000 - 0xc0bffff
> [0xfffff7f00000]
> iommufd_backend_map_dma  iommufd=3D142 ioas=3D2 iova=3D0xc0b0000
> size=3D0x10000 addr=3D0xfffff7f00000 readonly=3D0 (-1)
> qemu-system-aarch64: warning: IOMMU_IOAS_MAP failed: Bad address, PCI
> BAR?

Yes. Eric has reported this earlier here:
https://lore.kernel.org/qemu-devel/CH3PR12MB7548771111FF5AC450CB8721AB8EA@C=
H3PR12MB7548.namprd12.prod.outlook.com/

IIUC, we are using memory_region_init_ram_device_ptr() to avoid trapping
accesses to this MMIO space. However, this marks the region as RAM, and
when it is added via memory_region_add_subregion_overlap(), the VFIO
listener attempts to DMA MAP it. But, the QEMU/kernel does not provide
 dma-buf support for this register space.

This region represents VINTF page0 registers and is accessed by the CPU
only. My understanding is, there is no expected device DMA or P2P use case
targeting it, so an IOMMU_IOAS_MAP for this region should not be required
and can be ignored. Please let me know if that is not the case.

Thanks,
Shameer

> [Switching to Thread 0xffffdd7aee80 (LWP 52426)]
>=20
> Thread 38 "qemu-system-aar" hit Breakpoint 2, vfio_container_region_add
> (bcontainer=3D0xaaaaaf1220a0, section=3D0xffffdd7ade00, cpr_remap=3Dfalse=
) at
> ../hw/vfio/listener.c:620
> 620             error_setg(&err, "vfio_container_dma_map(%p,
> 0x%"HWADDR_PRIx", "
> (gdb) bt
> #0  vfio_container_region_add (bcontainer=3D0xaaaaaf1220a0,
> section=3D0xffffdd7ade00, cpr_remap=3Dfalse) at ../hw/vfio/listener.c:620
> #1  0x0000aaaaab8a9290 in vfio_listener_region_add
> (listener=3D0xaaaaaf1220d0, section=3D0xffffdd7ade00) at ../hw/vfio/liste=
ner.c:492
> #2  0x0000aaaaab3035f8 in address_space_update_topology_pass
> (as=3D0xaaaaaefa6de0, old_view=3D0xffffec5171b0, new_view=3D0xffffc800141=
0,
> adding=3Dtrue) at ../system/memory.c:1030
> #3  0x0000aaaaab303974 in address_space_set_flatview
> (as=3D0xaaaaaefa6de0) at ../system/memory.c:1106
> #4  0x0000aaaaab303bd4 in memory_region_transaction_commit () at
> ../system/memory.c:1158
> #5  0x0000aaaaab3084e0 in memory_region_update_container_subregions
> (subregion=3D0xaaaaaefa7b00) at ../system/memory.c:2653
> #6  0x0000aaaaab3085a0 in memory_region_add_subregion_common
> (mr=3D0xaaaaaefa79e0, offset=3D196608, subregion=3D0xaaaaaefa7b00) at
> ../system/memory.c:2668
> #7  0x0000aaaaab308644 in memory_region_add_subregion_overlap
> (mr=3D0xaaaaaefa79e0, offset=3D196608, subregion=3D0xaaaaaefa7b00, priori=
ty=3D1)
> at ../system/memory.c:2685
> #8  0x0000aaaaab570f68 in tegra241_cmdqv_map_vintf_page0
> (cmdqv=3D0xaaaaaefa79c0) at ../hw/arm/tegra241-cmdqv.c:275
> #9  0x0000aaaaab571188 in tegra241_cmdqv_setup_vcmdq
> (cmdqv=3D0xaaaaaefa79c0, index=3D0, errp=3D0xffffdd7ae0e8) at
> ../hw/arm/tegra241-cmdqv.c:317
> #10 0x0000aaaaab571550 in tegra241_cmdqv_write_vcmdq
> (cmdqv=3D0xaaaaaefa79c0, offset0=3D131072, index=3D0, value=3D3791650835,
> size=3D4, errp=3D0xffffdd7ae0e8) at ../hw/arm/tegra241-cmdqv.c:378
> #11 0x0000aaaaab571a60 in tegra241_cmdqv_write
> (opaque=3D0xaaaaaefa79c0, offset=3D131072, value=3D3791650835, size=3D4) =
at
> ../hw/arm/tegra241-cmdqv.c:484
>=20
> Nicolin

