Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4C3E5D58E7A
	for <qemu-devel@archiver.kernel.org>; Mon,  2 Mar 2026 09:32:18 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vwzcm-0000vr-MT; Mon, 02 Mar 2026 04:31:36 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <zhenzhong.duan@intel.com>)
 id 1vwzcX-0000sh-9K; Mon, 02 Mar 2026 04:31:21 -0500
Received: from mgamail.intel.com ([192.198.163.19])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <zhenzhong.duan@intel.com>)
 id 1vwzcS-0000mC-Li; Mon, 02 Mar 2026 04:31:21 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1772443876; x=1803979876;
 h=from:to:cc:subject:date:message-id:references:
 in-reply-to:content-transfer-encoding:mime-version;
 bh=Kd8f24utuXwEIZjXqwiq7QDIaz96z80EZYpsIdzk9J4=;
 b=RZ2wH+uX3VmB/gKzeEf0938vVpsWT2b+5NxQE7qNblQvnUxjiWY46YqR
 fQiJCHKuW4TK7c4tMbS7HD6c9iSDUG5j9UBaSZa4/KMmTapuKUj9O8zpG
 RKw3jpBWXFAQ/WMpd9lImtLWEdTue7LeoL4EfddJz4nGzBy2ffALJzGPM
 gdlgPiyMK8zgIGOfblrVbEquJFc5yi0qsvaASUN26UlarKrfS4tn0dtgD
 78Z1PmITi8Z2XQh4p6MEs3lVOwZish6deQk31/ZI11CFD2iDpVrIregAT
 a8NQ6r3cVFD2FtWponAgcx8UYQrt/Ro1y8ysfCgOHnWR96+ueXEHJiZ/Z A==;
X-CSE-ConnectionGUID: rs3Y7G6YRk2kviysDnMDRA==
X-CSE-MsgGUID: J5k8F9mtQ8y8O2M0WVzwgw==
X-IronPort-AV: E=McAfee;i="6800,10657,11716"; a="72473373"
X-IronPort-AV: E=Sophos;i="6.21,319,1763452800"; d="scan'208";a="72473373"
Received: from orviesa007.jf.intel.com ([10.64.159.147])
 by fmvoesa113.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 02 Mar 2026 01:31:05 -0800
X-CSE-ConnectionGUID: qV4+OgBfRZa/DIuNZ4lPVA==
X-CSE-MsgGUID: DpBlTzqvR8KU/xuV9BLn8Q==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.21,319,1763452800"; d="scan'208";a="217708412"
Received: from orsmsx903.amr.corp.intel.com ([10.22.229.25])
 by orviesa007.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 02 Mar 2026 01:31:05 -0800
Received: from ORSMSX903.amr.corp.intel.com (10.22.229.25) by
 ORSMSX903.amr.corp.intel.com (10.22.229.25) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.37; Mon, 2 Mar 2026 01:31:04 -0800
Received: from ORSEDG902.ED.cps.intel.com (10.7.248.12) by
 ORSMSX903.amr.corp.intel.com (10.22.229.25) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.37 via Frontend Transport; Mon, 2 Mar 2026 01:31:04 -0800
Received: from CH4PR04CU002.outbound.protection.outlook.com (40.107.201.54) by
 edgegateway.intel.com (134.134.137.112) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.37; Mon, 2 Mar 2026 01:31:03 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=sLuGqfduf6XzcIoRYzTWHmNTmAnAM45Qcg8hFmowp0gnEV7C5D8NEm1jc6o67s2NEBiavGcO4e4EfKTdor7EKSe3iRI2uY77NpQJN/aYT3tnvxFKdRH02AUvx9aTYORhf87OVSZmw5ZSlZgM9CzztnuLkoemsEBwyTiS9zfRNR7XBhuGjI+CRBSJ8rawDi5c7WJHTajrGzj55vCrdaEQC7xN5Tjy6xay1R8kiU71OYdr0133KM1LD+3sx0sC8RtbxecdrpxyDzNmLMAuYJ5Rl2ClwaqOJTCn38e5JSjWt2bvpXY3Ugg0WPCrFIys7Xy+J1k8nyPaqcva4XnqFMGWLA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=9KqGPuiXZ1OztwBRus0qOui4EjaSVDC1Pe2SRjWKkGY=;
 b=iIfP4HUR+mhJj5op7dhJGfh4I5gGcDNIyQ3z+4BpZMlwgapp0X0+fDXBeI+uRp8RMiUEHXg4Uh7XNTWwQit4q1E5y1xwqOZQ2KxRuRpuWa0ReRYz0rFH0634iTB1TcDYUm5Pa2VcaqPOU/TIObqQCWtZpGd+QksISGxmzSSsE5Tasanu9uv1dVoGoCRvVOiL2OJk8Fk1p6jyhkiI7wvW7ARVD9CWKSsnt0kv/y2pnybuEV470Jpqc36f1CFyvnIZYavtOGWm7IdNMm9xNayBgYdt/vcP9B/ZLSbzhPFq7pxo0dtgDPpACtM7eyCbOLStYM9xFFkFzitMEDJY/E0ghQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Received: from IA3PR11MB9136.namprd11.prod.outlook.com (2603:10b6:208:574::12)
 by LV4PR11MB9466.namprd11.prod.outlook.com (2603:10b6:408:2e3::11)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9654.15; Mon, 2 Mar
 2026 09:31:02 +0000
Received: from IA3PR11MB9136.namprd11.prod.outlook.com
 ([fe80::37b4:37a9:4f3:518b]) by IA3PR11MB9136.namprd11.prod.outlook.com
 ([fe80::37b4:37a9:4f3:518b%5]) with mapi id 15.20.9632.017; Mon, 2 Mar 2026
 09:31:01 +0000
From: "Duan, Zhenzhong" <zhenzhong.duan@intel.com>
To: Shameer Kolothum Thodi <skolothumtho@nvidia.com>, "qemu-arm@nongnu.org"
 <qemu-arm@nongnu.org>, "qemu-devel@nongnu.org" <qemu-devel@nongnu.org>
CC: "eric.auger@redhat.com" <eric.auger@redhat.com>,
 "peter.maydell@linaro.org" <peter.maydell@linaro.org>, Nicolin Chen
 <nicolinc@nvidia.com>, Nathan Chen <nathanc@nvidia.com>, Matt Ochs
 <mochs@nvidia.com>, Jiandi An <jan@nvidia.com>, Jason Gunthorpe
 <jgg@nvidia.com>, "jonathan.cameron@huawei.com"
 <jonathan.cameron@huawei.com>, "zhangfei.gao@linaro.org"
 <zhangfei.gao@linaro.org>, "philmd@linaro.org" <philmd@linaro.org>,
 Krishnakant Jaju <kjaju@nvidia.com>
Subject: RE: [PATCH v8 5/5] hw/arm/smmuv3-accel: Read and propagate host
 vIOMMU events
Thread-Topic: [PATCH v8 5/5] hw/arm/smmuv3-accel: Read and propagate host
 vIOMMU events
Thread-Index: AQHcpvxrPWY0EIaO2EyyMmxqBreJU7WXd1wAgAKmngCAANiH0A==
Date: Mon, 2 Mar 2026 09:31:01 +0000
Message-ID: <IA3PR11MB91365D6AF54A9D44998A9BD3927EA@IA3PR11MB9136.namprd11.prod.outlook.com>
References: <20260226084456.112142-1-skolothumtho@nvidia.com>
 <20260226084456.112142-6-skolothumtho@nvidia.com>
 <IA3PR11MB913652049863E1F32BE9C1319270A@IA3PR11MB9136.namprd11.prod.outlook.com>
 <CH3PR12MB754818FE668426F2078F25BCAB71A@CH3PR12MB7548.namprd12.prod.outlook.com>
In-Reply-To: <CH3PR12MB754818FE668426F2078F25BCAB71A@CH3PR12MB7548.namprd12.prod.outlook.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: IA3PR11MB9136:EE_|LV4PR11MB9466:EE_
x-ms-office365-filtering-correlation-id: d855ae5c-e7e3-488b-2cde-08de783e6b6b
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
 ARA:13230040|366016|1800799024|376014|7416014|38070700021; 
x-microsoft-antispam-message-info: vJAXguKfgMApbzKmkjpsl175tt2T7zf086BhRbKh/Q5pibgGoICGTW9uMtcn41axICrXI4qeJR8Jynu2hPlNEdveHLioTolpTc5vICg5a68OcgN9twPGsgE0BIXPsoBuV472T0zrtAhRd/VSMhTTim+LQcwDXGTbo3IIekjVWNkz0gUq822F0sIFSAPYOsTs1B0KnZFsKncguw8PrgjpTiw2U3p+OQsyrG8De5cHiPLaceYt6wIAf0cRwEPXwhhe/9l5jDhcWCktn3+E3RjsBOQMOeu6l567x1gPusaDoUkuguu/h6sOfbjPbbVTGctXyzUxr4f+jvaBnl5SxG38RTossF7k/ebvRQwYZu0RchOHWTpmfD0YY4iI+1zDqqXVtHW6iT+l3e/en7UFnB6JJa2wPFIvqqVUH/oPG7BuL/vI2xUJ24J7TKVgttbllFxT4e37DLMcnNch4j9HF9I6WdU87HHTt1D/S7d3fT65Sf/9FaIM02PBaU/GFcErk0m998q353odsuwmyAXJV6Snq2St8XMFiL8gXrM78PMa8u2Kt9e61WW0WFo/MFS+ia9nn4Dszy0QM1ox7AmjbDaQmoGcNYkpbaicau5kq9/MF1ejqmynroB9FdyxrEkovOmZUAzehHN9zmAvjJ99XRsknNAeQxoV7CiHeqdWvJCqNosTujyC+rgtE1G8y8yisWB2W9R/b8CSRTTHYDkDqtvCbw4rzbJaREtyoj1zquKS2NwDsZk+gvFWmnSEyIXql+/OOLhc0oCx5z4gHhsFkKtXJCl4yypztyYhyIEbDVqwpRfcigyfIRErDF9fvI0xgqQw
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:IA3PR11MB9136.namprd11.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(366016)(1800799024)(376014)(7416014)(38070700021); DIR:OUT;
 SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?srYnHWaobKHmrOFqMyU2J4Qc0T7JnILaNo517BjeKV+u+VBxCTJ60XreWF9W?=
 =?us-ascii?Q?bu0SIvFaLxOUG8P2n6QNr9L4B0kpNlzNDvbEbeQXg+C0XZz1V0MsuDVi2vlx?=
 =?us-ascii?Q?x+G1kVddb5h6Ec4/fVXXD0hdKHYovgGWsmrfxPO7hL6NHMULZatSeXO4xVns?=
 =?us-ascii?Q?xeNZKMNKXGjfgV045FqP6EUF6TO1/l7E61K1OGX0hCfPszk7O4zf07tJQT8M?=
 =?us-ascii?Q?rsXUAwwKbSjL9RbTEugpf2UCSUQH584RAObnxO8AX7jizDIlX5EH7xRjzVaU?=
 =?us-ascii?Q?mf5ZbJ3U0YcEWput1UXPWS9DAwbUu48paKAVd1wYwp8e3RZVemC5Ff9UK1eU?=
 =?us-ascii?Q?pG+6E5o6+LVtEYbZ8wGl9uvBENZOhhj8211A4kHEzS6p7vfCy6crqiWJnz9d?=
 =?us-ascii?Q?7z6y8HYFnyDPJ0aRqji9R1bC0ciG3euXGQlhKHj6Bom8w/mQR+hNxIuYgHii?=
 =?us-ascii?Q?Qa3CP5v+nDKuaeZH1decjpngZcjf9kN89VHj7Ts4vsaOR/vq2/kDBIx+URu5?=
 =?us-ascii?Q?yVtjbqhe7rFciOTL5WAr7zSwLNFkBYfDFuvsXjnT019F9pOPr00imQa2g3jE?=
 =?us-ascii?Q?BzLRqHtrSdx5t/Cv9KXuvqMNEZRUmDtv8c0TCcBb1NpLnZXk6dmK4xI060WS?=
 =?us-ascii?Q?8JQD7TKawv7d1JM4CpucXdC1F1IQvgDMvK50bs4Ived3ybluyEF2/sJTzwOs?=
 =?us-ascii?Q?ltRzfXWfEvpRDxTlbKJHz7MmbKQGBVGdh46EzO9wZ1N0gf6LbFpdI4b623kY?=
 =?us-ascii?Q?FwLF89lls+bhH32kaK+/FYoRou5pWMjvDP2n6x/1GfG3G0FhsfltLp8aKL4j?=
 =?us-ascii?Q?l4oP14VOilYGVfNfThdZRCXVD24UwrlsoMidacJRPpLJis2hi804iwlTvwe4?=
 =?us-ascii?Q?kNCvxX1SsEzMf+d3WJ0dEI0vXtIrr0wgd07YObB4pZ176E0yc/JIwv5E9FQq?=
 =?us-ascii?Q?1pY+wOLo4koMnKLaLdJOoky1QcJUGob/9cu+3vM1a668WJZd59lxzMeR5SB/?=
 =?us-ascii?Q?CTEZIJj1BO2L3r5MRxCzSpfSH6v7fEeQz/qU/5IVzGqZus4HLHkue1qoco5C?=
 =?us-ascii?Q?9GuJmPwpUo57G1fuhL4Rx5v2UeAdyuTmiN3pB4jcMMld3Q7YJbD4xz0KGADV?=
 =?us-ascii?Q?3tZ7YwOFRxDwRkHnVPxPK1M6W6ILU3TPzKkzwRWwHt19lANzhXHQMfxSTcKB?=
 =?us-ascii?Q?u9Hx/O6oK6xcGTRIbVfZ/9NnO8KgVzt3sNgGH3FV7LUd6dn7p+IPSXo9MDIS?=
 =?us-ascii?Q?qrS714F2Au0UTNEUmo92ZIlULDICz4pK7/6jIyUFv6nwdagMUT3BuYRXCynj?=
 =?us-ascii?Q?7hoskZxbVe5QjVjLoGDlvJZr53N6Y39Sw7cSsJEFyK2YZL/GKWo+FulZePvp?=
 =?us-ascii?Q?QM2rgZXYQCghI6SQTQJy15CQGT0xP4Uj+8UDvlFL3xvlfEMyujMl6+Y2DS16?=
 =?us-ascii?Q?nR8VVkCDGvHm1Ti6uXsxdpKOZx0/UroRLkqXpZGHhM/7SZIkBDA74ffUb8WI?=
 =?us-ascii?Q?SHeK56r3Hj+rxyu83RLA2G7LAYUIPwWghAfa3H6sqQHqkpQNWshLpT/dm9rj?=
 =?us-ascii?Q?DNVkLLcX103/RfoC8H02WDDxw0BvECgzSBKxqKPoLajmP/7crwdgK1hVx1zW?=
 =?us-ascii?Q?0ncXDtSCAzCva1CbdZO0uQFh21N5Btf5jNBJtxYAG9idygFpzBLwBD9ap/Ut?=
 =?us-ascii?Q?Pg3nOe/NPWERrnnrRYuDxQULyrY/C2o982H08L87oeTLGQd0d5zEE5j+hENL?=
 =?us-ascii?Q?mh2jQvbKWA=3D=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: IA3PR11MB9136.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: d855ae5c-e7e3-488b-2cde-08de783e6b6b
X-MS-Exchange-CrossTenant-originalarrivaltime: 02 Mar 2026 09:31:01.7694 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: Z4RIsIJsK4TtDrPJe93h4OYqdgB2Y4dF5CoBT1cV3AZi/I2OxynUwVEc16HSJNUdnQfaVzAJn9In+Sfq2QCCQR/artg7RLxo6tKV07ZFXAM=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: LV4PR11MB9466
X-OriginatorOrg: intel.com
Received-SPF: pass client-ip=192.198.163.19;
 envelope-from=zhenzhong.duan@intel.com; helo=mgamail.intel.com
X-Spam_score_int: -31
X-Spam_score: -3.2
X-Spam_bar: ---
X-Spam_report: (-3.2 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_MED=-2.3, RCVD_IN_VALIDITY_CERTIFIED_BLOCKED=0.012,
 RCVD_IN_VALIDITY_RPBL_BLOCKED=1.188, SPF_HELO_NONE=0.001,
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

Hi Shameer,

>-----Original Message-----
>From: Shameer Kolothum Thodi <skolothumtho@nvidia.com>
>Subject: RE: [PATCH v8 5/5] hw/arm/smmuv3-accel: Read and propagate host
>vIOMMU events
>
>Hi Zhenzhong,
>
>> -----Original Message-----
>> From: Duan, Zhenzhong <zhenzhong.duan@intel.com>
>> Sent: 28 February 2026 06:28
>> To: Shameer Kolothum Thodi <skolothumtho@nvidia.com>; qemu-
>> arm@nongnu.org; qemu-devel@nongnu.org
>> Cc: eric.auger@redhat.com; peter.maydell@linaro.org; Nicolin Chen
>> <nicolinc@nvidia.com>; Nathan Chen <nathanc@nvidia.com>; Matt Ochs
>> <mochs@nvidia.com>; Jiandi An <jan@nvidia.com>; Jason Gunthorpe
>> <jgg@nvidia.com>; jonathan.cameron@huawei.com;
>> zhangfei.gao@linaro.org; philmd@linaro.org; Krishnakant Jaju
>> <kjaju@nvidia.com>
>> Subject: RE: [PATCH v8 5/5] hw/arm/smmuv3-accel: Read and propagate host
>> vIOMMU events
>
>[...]
>
>> > static void smmuv3_accel_free_veventq(SMMUv3AccelState *accel)
>> > {
>> >     IOMMUFDVeventq *veventq =3D accel->veventq;
>> >@@ -397,6 +441,7 @@ static void
>> >smmuv3_accel_free_veventq(SMMUv3AccelState *accel)
>> >     if (!veventq) {
>> >         return;
>> >     }
>> >+    qemu_set_fd_handler(veventq->veventq_fd, NULL, NULL, NULL);
>> >     close(veventq->veventq_fd);
>> >     iommufd_backend_free_id(accel->viommu->iommufd, veventq-
>> >veventq_id);
>>
>> Did you ever see free_id failure here?
>
>So far I have not seen free_id() failure in my test setup.
>
> I'm working on PRQ using FAULTQ in
>> intel_iommu
>> and find a race condition, I suspect the same for vEVENTQ because both h=
ave
>> similar
>> implementation in kernel and qemu.
>>
>> qemu_set_fd_handler() is called to remove veventq_fd from epoll() but it=
's
>> async,
>> this can lead to releasing of veventq_fd delayed after free_id(veventq_i=
d),
>> during veventq_fd releasing, it drops reference of veventq_id but it's t=
oo late
>> and free_id(veventq_id) already failed.
>>
>> It's not easy to reproduce, we had a test case in guest to trigger FAULT=
Q
>> allocation
>> and freeing sequence in loops.
>
>From a quick look:
>
>qemu_set_fd_handler(fd, NULL, NULL, NULL) -> aio_set_fd_handler()
>
>aio_set_fd_handler() takes ctx->list_lock. For the delete case it sets
>node->pfd.events =3D 0 and then calls:
>
>ctx->fdmon_ops->update(ctx, node, new_node); where new_node =3D NULL
>
>In the epoll backend (util/fdmon-epoll.c) this results in:
>
>epoll_ctl(ctx->epollfd, EPOLL_CTL_DEL, old_node->pfd.fd, ...);
>
>As I understand it, epoll_ctl() is a synchronous syscall. When it returns,
>the fd has been removed from the epoll interest list in the kernel.

OK, I think I understand wrongly.

>
>Also, I think, aio_set_fd_handler() and aio_dispatch() run in the same thr=
ead for
>a given AioContext, and dispatch runs with ctx->list_lock held (via
>lockcnt). So looks like handler removal and dispatch are serialized at the=
 QEMU
>level.

I just found my scenario is a bit different from yours, aio_set_fd_handler(=
)
is called in vcpu thread and aio_dispatch() is called in main thread in my =
scenario.

>
>Do you see a specific window where the fd could still trigger after
>EPOLL_CTL_DEL returns?

No, just speculation.

>
>Could you confirm which fdmon backend you are using..poll, epoll, or
>io_uring?

There is no CONFIG_LINUX_IO_URING defined in my env.
GDB printed fdmon_poll_ops  for iohandler_ctx->fdmon_ops, I also set
breakpoint on fdmon_epoll_try_upgrade(), no catch, I think it was
using poll.

>
>One more question: is the FAULTQ register/unregister model identical to
>vEVENTQ in terms of allocation and teardown ordering?

register/unregister model are similar, see https://github.com/yiliu1765/qem=
u/commit/28b72d6b372555494d0e6a1ccfc97c80bc34423a
the full branch: https://github.com/yiliu1765/qemu/commits/zhenzhong/iommuf=
d_prq_wip/

> For vEVENTQ we only
>unregister when the last device is removed from the vIOMMU, typically via
>device_del hot unplug.

OK, this is different, register/unregister model is triggered in vcpu threa=
d
when guest send PASID table invalidation request in my scenario.

>
>Please let me know if you see a specific race case here that I may be
>missing.

Maybe this is a race case only in my scenario, I need to dig further.
Thanks for your analysis.

BRs,
Zhenzhong=20

