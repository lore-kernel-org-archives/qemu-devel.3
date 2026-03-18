Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D1F8CFCD0C6
	for <qemu-devel@archiver.kernel.org>; Wed, 18 Mar 2026 07:37:37 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1w2lSb-000835-V5; Wed, 18 Mar 2026 03:36:57 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <zhenzhong.duan@intel.com>)
 id 1w2lSZ-00082i-Kx
 for qemu-devel@nongnu.org; Wed, 18 Mar 2026 03:36:55 -0400
Received: from mgamail.intel.com ([192.198.163.19])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <zhenzhong.duan@intel.com>)
 id 1w2lSW-0005CV-Vh
 for qemu-devel@nongnu.org; Wed, 18 Mar 2026 03:36:55 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1773819413; x=1805355413;
 h=from:to:cc:subject:date:message-id:references:
 in-reply-to:content-transfer-encoding:mime-version;
 bh=2QGf46Ji0zzWAPpuj5OsDVVVKnENoh+HYNTKuGRekXg=;
 b=Ju+LJ6BZSZXc0IehQZnO0+8smEaoabSCARIXKNObQdzwF2IafysbGmUP
 uUelMGkxhman11gKX/O8y/B7xsgX70VNUYwAPw7WkHjDyZgJjnHQ/RPgA
 zcCgnspILjbecyGHbviJ1IaxV9nxzR7dn6N7dWECleNANDha9yQx74Lfy
 XBjqpUWjRZcMX00CjUDv2tRsGN4UQauaeO5V+AM4OREU5Te0/7QalIIg3
 kxn4Inx9gltadmFMzSQ6XEWCAo1YBUjUsaqXdT3vwL8VAU7GMVL0umSs8
 mR0nf2qkOCJI+bVSlNVGEfxJmcN3GaWsPXJX0ABDUFiXkelJjk38hbcw9 A==;
X-CSE-ConnectionGUID: OcMcyYmJSQCaX8MUR2Hdww==
X-CSE-MsgGUID: z0fn+A8RS+uQxTk6R2MjmQ==
X-IronPort-AV: E=McAfee;i="6800,10657,11732"; a="73886235"
X-IronPort-AV: E=Sophos;i="6.23,127,1770624000"; d="scan'208";a="73886235"
Received: from fmviesa008.fm.intel.com ([10.60.135.148])
 by fmvoesa113.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 18 Mar 2026 00:36:47 -0700
X-CSE-ConnectionGUID: ePesRMqRRcuG3ro7cW0pIg==
X-CSE-MsgGUID: Jew+/Q1fSxS3qZ5Pj4chZg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.23,127,1770624000"; d="scan'208";a="219985420"
Received: from orsmsx901.amr.corp.intel.com ([10.22.229.23])
 by fmviesa008.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 18 Mar 2026 00:36:47 -0700
Received: from ORSMSX903.amr.corp.intel.com (10.22.229.25) by
 ORSMSX901.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.37; Wed, 18 Mar 2026 00:36:45 -0700
Received: from ORSEDG902.ED.cps.intel.com (10.7.248.12) by
 ORSMSX903.amr.corp.intel.com (10.22.229.25) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.37 via Frontend Transport; Wed, 18 Mar 2026 00:36:45 -0700
Received: from PH8PR06CU001.outbound.protection.outlook.com (40.107.209.51) by
 edgegateway.intel.com (134.134.137.112) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.37; Wed, 18 Mar 2026 00:36:43 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=mVOb5kzmHMcb9Mbli7yZzzaptgFYJumz1XpFDqZjS1dxy4dZ9nQQuP3H/9WP4ak+VusUfBRcF6UZMOrCa8yQT7wJHnRlllB9Yx5QuM0PNlgmKoURBAYgyywROf3Zrdhq2mVQL53Lo9pgl3WEPPNGwVHSN7ETx9HR1awmhg5+t5ae7hA+Ho4zQMEysp+s3mu5d74BiaFwqUcCAXUZ7yQYmxnHWUAGO+Nq5+uIN9BSr9mI0zJATZ2NL/NxVgKVpKa2wz7CiyXuElvaVXMmQ9UhSd+8AMpKqNqHtZrOqHJSIh+qOAxYmLE+rKK6vnWBoY+kWQb+fYI/L3cbKn3PJe+QLA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=DhovkzMvltIxBCS9Fh0L0ij4CC1oPEEMXyrLIebijq0=;
 b=dC+MM5dqB0CKMGOVjc1/P1UESXYey7pzpvij1ppwxY0vh/6nLrPdbhMEamucidHdR++rIvTUQTlk3rH/xeXU/NNLsKOmr/HLE9+ZxQRQSmA48QwNYW1j+kJaMKwFtUQ/EEtZ6iZLhB8/9BqxyRXsbVkVr6dA6r7qyXYd2XmnU3aN0SCyWkxqUSA6CKqjgLlS6pPxNwx15dwVpB3ZWNCI88viifYA/xkiTYi5HDfi5JnA2PUj+6tZiwAyhftjsIm87W5iABRo9hR831QpUORcSZH3NNoAsvaH7c9f21X33JjmOg/VeNqO0AnIS4XKnM6BtoOti53SlyA6/DIpn/hbXw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Received: from IA3PR11MB9136.namprd11.prod.outlook.com (2603:10b6:208:574::12)
 by CH3PR11MB8433.namprd11.prod.outlook.com (2603:10b6:610:168::14)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9723.19; Wed, 18 Mar
 2026 07:36:41 +0000
Received: from IA3PR11MB9136.namprd11.prod.outlook.com
 ([fe80::37b4:37a9:4f3:518b]) by IA3PR11MB9136.namprd11.prod.outlook.com
 ([fe80::37b4:37a9:4f3:518b%5]) with mapi id 15.20.9723.013; Wed, 18 Mar 2026
 07:36:41 +0000
From: "Duan, Zhenzhong" <zhenzhong.duan@intel.com>
To: Pierrick Bouvier <pierrick.bouvier@linaro.org>, "qemu-devel@nongnu.org"
 <qemu-devel@nongnu.org>
CC: =?iso-8859-1?Q?C=E9dric_Le_Goater?= <clg@redhat.com>, "Liu, Yi L"
 <yi.l.liu@intel.com>, Alex Williamson <alex@shazbot.org>, Eric Auger
 <eric.auger@redhat.com>, "philmd@linaro.org" <philmd@linaro.org>
Subject: RE: [PATCH 1/2] backends/iommufd.c: report error when /dev/iommu is
 not available
Thread-Topic: [PATCH 1/2] backends/iommufd.c: report error when /dev/iommu is
 not available
Thread-Index: AQHctmGHiBHM8iMR00eLUFzvqqaWNrWz5tXg
Date: Wed, 18 Mar 2026 07:36:41 +0000
Message-ID: <IA3PR11MB913683DE47A156F52C77AE7C924EA@IA3PR11MB9136.namprd11.prod.outlook.com>
References: <20260317225751.1325098-1-pierrick.bouvier@linaro.org>
 <20260317225751.1325098-2-pierrick.bouvier@linaro.org>
In-Reply-To: <20260317225751.1325098-2-pierrick.bouvier@linaro.org>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: IA3PR11MB9136:EE_|CH3PR11MB8433:EE_
x-ms-office365-filtering-correlation-id: 5ecc7bd0-aa26-4f7a-5b1b-08de84c118c7
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
 ARA:13230040|376014|366016|1800799024|18002099003|22082099003|56012099003|38070700021;
x-microsoft-antispam-message-info: 3SNgKLzCD71HqbXWiKLaG6uvsY2CXxLgM3WkblFgraRFdJpWe0YCwJlsBvYt9FK7kzmKfSes7GfPWK+LZu0dHiKKodu3TIB8ZENBb/dzzn/s3kKJFvdGNMGux40bG3E5F6CUf4XSDyVJLm+lqT99zn1OF+HzQov45BynwfuizHz7Cdfc5KmieDOCKJ4oaJMCAwKoxg9IhDn2MF1ZE1pH+uAocPqcctHUIUFe54IhowukAZcYcesUuvkqTF0Z6sbE7ZGxQ6h6vZ4FXquRyaf4+UWQr40G63NUicxkwNYL40+VxHfYiFWjjgpOACrQHXBS+SMCN5jultAXhHKINoBF1g97Syecep8DjUyKW2jar/PwBUvi+vnDwPS0rFj3x3BDWkajnJokSa3EoRAKyYvo4zY4/uAGR7un16EXXTWgMCT9Uq+TNyXL1M2tXS9sFNSXOihwHY07qbMVyQchRHWV+aNBjfQHPkqo2oLFEgeRqCR3aOGKdx2QxB1m3hZQ/wVYu2oE6gfpB7ekNdHyfCK3m+xG2Knqv8Us+JSvW5tH1YpBMtvRwasdxvAN5Dsd2NVG+54psE7EmXxpPerERpQveijMtuCS45q9AIVqCBzT6Mx6/pa05XiUBlREOln3RjGRvUF6jz07u6aBZc4DGjHSLthiQmgT/CqDQkrC9vo66PHyxmCwg4vEiGhgfEKK3BN7/CXTfSAFE8Sz5Ci9GIcMGJ37qMklHzpLEeQuE7BsyD5hM1IJXKGuw3KUCYZeMovplR3KUO3YuQPWcHsAXTRdV+9uL0OS7P3zLRPg/7h/hP8=
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:IA3PR11MB9136.namprd11.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(376014)(366016)(1800799024)(18002099003)(22082099003)(56012099003)(38070700021);
 DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?iso-8859-1?Q?yka2/CTn7YUiPkXLM8XINmUVfUnq5wWRW+TztY9ZXgthf2saeoQV9u2g1W?=
 =?iso-8859-1?Q?DUHQ9JX/HmFIvNe6UtIdT1TyfhuHbQ5seSXRS3z5m/E0HHXIin4PyCV/ap?=
 =?iso-8859-1?Q?QjHQ3828kdahvHO4wD7ouA7yLxe5txz1uoJlIzBcpcrRioMxudmUKfOp5H?=
 =?iso-8859-1?Q?OVnGE0fcqQdDWvb1Aauf34VlvpRiKpWSm7FnGt/gcVcVcEAjWH73CT1ewT?=
 =?iso-8859-1?Q?bLcq/gz2M9Hnf7OpBKMpyizfDKY3I9ODgN215Tne6jXd6L3LFKTgiGNTyu?=
 =?iso-8859-1?Q?7kNStHukENtPCiisgkKDUJAZ/ntk2It0AlTxZMhGrg7jIoAzmyzvqnSqbw?=
 =?iso-8859-1?Q?r+ykI7feQJNHU7mZhgRRJIIsTG0J4PkMsaJdCRp/zNJ+YbY0WBG8izsf3M?=
 =?iso-8859-1?Q?8iSpt2jnSzXBUrZJ7juUWAU0H6Rlfw6VEH3AaGAhhklK00O3hBZU0UfcM+?=
 =?iso-8859-1?Q?uZH8QcN6tgdQNU24NZtauqKdsp6UUO4o9UmX+BTylZD7oKh2SVC7NoG6A4?=
 =?iso-8859-1?Q?SHe+V30csZ4D+pOePRVgOGJq21sYQIqzM33wr1vc59qhwT8ZWuvP2V2ji5?=
 =?iso-8859-1?Q?eytmOtrpgcOxIsnAIxiJ1qLOApWl9RIVQN0JawtAY6QP3ntmp/k1So2Uw7?=
 =?iso-8859-1?Q?1LaYhSzLQqUxnPI9apLVyzeA/VF4OKPg0fAmRr3AISRiAI5yvmoRi0jlIm?=
 =?iso-8859-1?Q?kTHOPLb5AYS3JqCW9KrkePJf8G0HIwlbARI+w7epQqdAlIrHvcO+k9YJf8?=
 =?iso-8859-1?Q?kjzowaJagsLeuIb8moTIKz5brgOIbrealqSdGCeLkorPTU+PC3t2jY0L9N?=
 =?iso-8859-1?Q?ywQkmmIzOZpxPsPcQSuu9v6TE2x0rs3Y3epwFhbtV0ALfBUKh8IgAg/VkH?=
 =?iso-8859-1?Q?XzHx6zJu1qv5I1AP80UU+xw2zSkx6tQE9GKBIEe4YiDcr53m1JwFglqD2b?=
 =?iso-8859-1?Q?Rl2BrtNrp0+foY7iaBnxQyuCr8yEuShkjxd2pxciRZRPIuaVf0xCszCtvi?=
 =?iso-8859-1?Q?QKqq7ouN4wxqvACP15zAHjTTphiVuSZvhGMQeKD6oS8YvgYl+yJPhs8/7T?=
 =?iso-8859-1?Q?7x8B8dxn9Xf4NvOKJOMX4p/DPWrefJrYGM+O7dtBDEi3zm3OqjamwoQMPa?=
 =?iso-8859-1?Q?D3Yqpp7dQ3FbtfZM4kq/rqzL3biEzmBpdsPcyinPtsQqarOXBDmPc7Niez?=
 =?iso-8859-1?Q?Pse9pxHdieCxeORnJlJ1B5CFnPl6ZV9PAmMb+eai80AYl0mOVE5lLvgt60?=
 =?iso-8859-1?Q?emk0gDUYgMZ1W1eJWhXRZw6mWSiabzsRWI2DPy/okFm2uEvLY06wl3PkP6?=
 =?iso-8859-1?Q?wdk1PwyzEVeShZMjmfYcQkkuZYkn+vIEfRjPkrBZDZIc2M3fCoRimd5fnG?=
 =?iso-8859-1?Q?GRIw7IjTD0MSd5eLjQEA3UKdipLBU7VBa8iai+l/Kq2esfA0p6yZbC2mBd?=
 =?iso-8859-1?Q?NGTAxUz9af3YvOG5HunqXl/mozdIiZfa7WTapPqu4Dw/CWDVUBvhNoGZSm?=
 =?iso-8859-1?Q?SUuRNZRes/VbOqChpv5bXcAX7uTEgM1WtoP5bwFUe4kewZysPQ6swEWSjW?=
 =?iso-8859-1?Q?INCQuFqoIaC1UomWj47KSkcvjwb2DuqOB0SvW6mn5IqvOdt8XjOuWNOmkU?=
 =?iso-8859-1?Q?LjrX6yS2ts9zuC6abdX6yqu5ZfUKnLxN1PXYvQP6yWtyglgqfPfircE8TC?=
 =?iso-8859-1?Q?KuEYu4iAv5F9cFfrZLBLtzdEEY9fN6U1IC8g2AIPs+Q+0S5ZMk3EJHSK4N?=
 =?iso-8859-1?Q?Z3tziqWxdgMUJNbCc9xKLp5JJijcaTeyuwPKUA8LXoLCgzE8XrnDcE/ZpF?=
 =?iso-8859-1?Q?PcwEisbL0w=3D=3D?=
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-Exchange-RoutingPolicyChecked: JzpoptSwHnamDxzLX4dhCMIc+EOtMEjiFqYz8c6MfADahz2Pq/hIKYsSLcDiYKbRQF9sc1dTMWYoK0xaII0WzpEYo7azWNfrVAFtqtUis9ry/8ebIa9GnEUuZ7+yjwzBwbZnj+fhS/rMPLyS23Fu2rahKxSyT9nHDGP08IgO2oND7UKkAbg0Tw/EqHb1l+gXRz/vj6Uu6IqNR4OALkqEvVhofOJwGWLKH/Oy4ZREirFiiPQgGMfzOg/OBrmw+8Ne4c8UPMuUPmAnXp/3YtieS/SMKp0PeazRGNd7o0d0fQJRZ/5fLtH2ylgAwACvnZjC8vduiPbW4zuMe0jKvJ4q/Q==
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: IA3PR11MB9136.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 5ecc7bd0-aa26-4f7a-5b1b-08de84c118c7
X-MS-Exchange-CrossTenant-originalarrivaltime: 18 Mar 2026 07:36:41.2096 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: Jrs0BF7y+mHnx728fFVo5lVmz+p5UHca2viKv0hrtwkjFRVltZ7XgmrH9M575T1ikiGGoafcGY6uvoArcByEUdXKEnkWIPKydihE5eoC5os=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH3PR11MB8433
X-OriginatorOrg: intel.com
Received-SPF: pass client-ip=192.198.163.19;
 envelope-from=zhenzhong.duan@intel.com; helo=mgamail.intel.com
X-Spam_score_int: -26
X-Spam_score: -2.7
X-Spam_bar: --
X-Spam_report: (-2.7 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_MED=-2.3, RCVD_IN_VALIDITY_RPBL_BLOCKED=0.819,
 RCVD_IN_VALIDITY_SAFE_BLOCKED=0.903, SPF_HELO_NONE=0.001,
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



>-----Original Message-----
>From: Pierrick Bouvier <pierrick.bouvier@linaro.org>
>Subject: [PATCH 1/2] backends/iommufd.c: report error when /dev/iommu is n=
ot
>available
>
>In case current kernel does not support /dev/iommu, qemu will probably
>fail first because /sys/bus/pci/devices/*/vfio-dev/ is not present,
>since QEMU opens it before /dev/iommu.
>
>Instead, report an error directly when initializing iommufd object, to
>inform user that kernel does not support it, with a hint about missing
>CONFIG_IOMMUFD.
>
>Signed-off-by: Pierrick Bouvier <pierrick.bouvier@linaro.org>
>---
> backends/iommufd.c | 5 +++++
> 1 file changed, 5 insertions(+)
>
>diff --git a/backends/iommufd.c b/backends/iommufd.c
>index acfab907c03..c4eb3de1307 100644
>--- a/backends/iommufd.c
>+++ b/backends/iommufd.c
>@@ -32,6 +32,11 @@ static void iommufd_backend_init(Object *obj)
> {
>     IOMMUFDBackend *be =3D IOMMUFD_BACKEND(obj);
>
>+    if (!g_file_test("/dev/iommu", G_FILE_TEST_EXISTS)) {
>+        error_setg(&error_fatal, "/dev/iommu does not exist"
>+                                 " (is your kernel config missing CONFIG_=
IOMMUFD?)");

If hot add an iommufd object with object_add QMP, may this kill QEMU instan=
ce?

Thanks
Zhenzhong

>+    }
>+
>     be->fd =3D -1;
>     be->users =3D 0;
>     be->owned =3D true;
>--
>2.47.3


