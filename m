Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9E334C71155
	for <qemu-devel@archiver.kernel.org>; Wed, 18 Jun 2025 02:52:15 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uRitb-0001nc-BV; Tue, 17 Jun 2025 22:51:27 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <zhenzhong.duan@intel.com>)
 id 1uRitY-0001nM-JB
 for qemu-devel@nongnu.org; Tue, 17 Jun 2025 22:51:24 -0400
Received: from mgamail.intel.com ([198.175.65.18])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <zhenzhong.duan@intel.com>)
 id 1uRitU-0006oQ-NB
 for qemu-devel@nongnu.org; Tue, 17 Jun 2025 22:51:23 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1750215080; x=1781751080;
 h=from:to:cc:subject:date:message-id:references:
 in-reply-to:content-transfer-encoding:mime-version;
 bh=g38LJIeN3xVNtSFoMMRHBPwwmYAZdhliu9oR/rFpnLY=;
 b=XSN8j9bgP8sKituqPllYGhFc5kwOg15CaPWTiPR0e/onrUsGsYy9BwnI
 0lG55TOqYgiwBFA4B5/Ri8+B2QU1mJBga+BRWzdGoa17fvvc6zM82d6c1
 dsG71lBBeOPIxhAwM+tTcFz22CW9cK2YEwttSiSHUQiSnHbz8fjKDEo8B
 5kC9BAVxRJmNV3+sLdgs1FEBr7veYo6wWxo8zo1fJm02e2NLpN3rm6Crh
 fA66BXDfpp/TRCK3rzPYn0BhH8BmipfFQ4BNLKcmP460UOykMdjcBy12Z
 /pX45tZ2l5SgxMH4jf4Qxw0OO33EuesCbL2iPVEVXBOt2Mo3zMYsmvhRb A==;
X-CSE-ConnectionGUID: eQf9JJMURSyMXkFm77aQ7g==
X-CSE-MsgGUID: 9Nh7JjItT7WtmPCZ9+QKmA==
X-IronPort-AV: E=McAfee;i="6800,10657,11467"; a="52555846"
X-IronPort-AV: E=Sophos;i="6.16,245,1744095600"; d="scan'208";a="52555846"
Received: from fmviesa001.fm.intel.com ([10.60.135.141])
 by orvoesa110.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 17 Jun 2025 19:51:17 -0700
X-CSE-ConnectionGUID: X6XG2G4JRMiyozOHXrFDpg==
X-CSE-MsgGUID: OdRsQi4+SnWazY8Yj484KQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.16,245,1744095600"; d="scan'208";a="180113144"
Received: from orsmsx903.amr.corp.intel.com ([10.22.229.25])
 by fmviesa001.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 17 Jun 2025 19:51:16 -0700
Received: from ORSMSX901.amr.corp.intel.com (10.22.229.23) by
 ORSMSX903.amr.corp.intel.com (10.22.229.25) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.25; Tue, 17 Jun 2025 19:51:15 -0700
Received: from ORSEDG901.ED.cps.intel.com (10.7.248.11) by
 ORSMSX901.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.25 via Frontend Transport; Tue, 17 Jun 2025 19:51:15 -0700
Received: from NAM10-BN7-obe.outbound.protection.outlook.com (40.107.92.80) by
 edgegateway.intel.com (134.134.137.111) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.25; Tue, 17 Jun 2025 19:51:14 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=EBRGOv18j7K9OcSgY0JvmqwrZgDJ6hZoiaWeUI+HYVSSK0lIH0a9EoP1nuL8E+f4d2tqzzgr4AR7VPbSG0EIDl9wyyLRsTzplelS9rPUyDWUqcvstG+HbnDVUExcjp9CrfbPsaWlMgQFsjEzQg3PTiDrGFYXQbrso5XrTx00P3eEWamnCSaeG2RI2JP6nBR6MnXBBySkLV4wNGBiCfF1cWtSDh4QQauL1eGleRovcBd8SENINMy6bBk7EsnwHpdW/f80vUDSZCMK2lZSxGz69IHpLrfecPU+PL20yNl7RUdCueKvb7fkLZRjLyfKWYJ2jbqRSp3611v5wC4Zb198JA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=g38LJIeN3xVNtSFoMMRHBPwwmYAZdhliu9oR/rFpnLY=;
 b=MFug3n+cf2cPrBOWF9j1cdfuHlLEzrc0kiE/TfUOgxRjMutenCbnJ5f4MCJv2Cl/bfgsEjWinJrrSOLDX7ltXVGMPeutIzGyNC07jDIEtRD9y39Q1VAMbTbi/QcbsF5aIcIH62ZlNT2kgQyvRtt2lQRxKvSK9w4f4522GddETAaAtns18GE5TEyB7bciCg0tN433GQNOL+6a7sv4WQfxXP3sWtqmkaYFwwwcVfzALWz74/ioHtVrcr/3Xi2DdnrxvUG1gMPFFQgIIdGjc3yajGpxTt9f3M2cDv3vTShmI0Fc+h8EqMRlZaBStEsemhPI04YmnCmNpfsCD5erg2cywg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Received: from IA3PR11MB9136.namprd11.prod.outlook.com (2603:10b6:208:574::12)
 by SJ0PR11MB6814.namprd11.prod.outlook.com (2603:10b6:a03:483::14)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8835.28; Wed, 18 Jun
 2025 02:51:06 +0000
Received: from IA3PR11MB9136.namprd11.prod.outlook.com
 ([fe80::604b:77a4:b1be:3f13]) by IA3PR11MB9136.namprd11.prod.outlook.com
 ([fe80::604b:77a4:b1be:3f13%4]) with mapi id 15.20.8835.023; Wed, 18 Jun 2025
 02:51:06 +0000
From: "Duan, Zhenzhong" <zhenzhong.duan@intel.com>
To: Jason Gunthorpe <jgg@nvidia.com>, "Liu, Yi L" <yi.l.liu@intel.com>
CC: Nicolin Chen <nicolinc@nvidia.com>, Peter Xu <peterx@redhat.com>,
 "qemu-devel@nongnu.org" <qemu-devel@nongnu.org>, "alex.williamson@redhat.com"
 <alex.williamson@redhat.com>, "clg@redhat.com" <clg@redhat.com>,
 "eric.auger@redhat.com" <eric.auger@redhat.com>, "mst@redhat.com"
 <mst@redhat.com>, "jasowang@redhat.com" <jasowang@redhat.com>,
 "ddutile@redhat.com" <ddutile@redhat.com>,
 "shameerali.kolothum.thodi@huawei.com"
 <shameerali.kolothum.thodi@huawei.com>, "joao.m.martins@oracle.com"
 <joao.m.martins@oracle.com>, "clement.mathieu--drif@eviden.com"
 <clement.mathieu--drif@eviden.com>, "Tian, Kevin" <kevin.tian@intel.com>,
 "Peng, Chao P" <chao.p.peng@intel.com>, Yi Sun <yi.y.sun@linux.intel.com>,
 Marcel Apfelbaum <marcel.apfelbaum@gmail.com>, Paolo Bonzini
 <pbonzini@redhat.com>, Richard Henderson <richard.henderson@linaro.org>,
 Eduardo Habkost <eduardo@habkost.net>
Subject: RE: [PATCH rfcv3 15/21] intel_iommu: Bind/unbind guest page table to
 host
Thread-Topic: [PATCH rfcv3 15/21] intel_iommu: Bind/unbind guest page table to
 host
Thread-Index: AQHbykJMfKt9Mfha3Ee+klVeu6JiiLPdsMoAgAIQvoCAAPjWAIADz6UAgACqsQCAAnMkMIAdyAkAgAAnT2CAAUAogIAAnTaAgAAHYQCAAAImgIAA45xA
Date: Wed, 18 Jun 2025 02:51:06 +0000
Message-ID: <IA3PR11MB91362AB9244BDD8CE09D00D69272A@IA3PR11MB9136.namprd11.prod.outlook.com>
References: <0f8087f4-0c97-440d-84d2-f3f017f81041@intel.com>
 <aDDk1NYwJXaAdUQI@Asurada-Nvidia>
 <29f5f434-1fe3-4b5e-91d1-f153e1e98602@intel.com>
 <aDSmcvZ08jNOSr05@Asurada-Nvidia>
 <SJ0PR11MB6744340B889FF65D3BD5B8459267A@SJ0PR11MB6744.namprd11.prod.outlook.com>
 <aE+wCIG8KHb3u1lV@nvidia.com>
 <IA3PR11MB91369A0E98CC76ABDBA365809270A@IA3PR11MB9136.namprd11.prod.outlook.com>
 <aFDdkxPODYnyG0Vo@nvidia.com> <20250617123707.GW1174925@nvidia.com>
 <de5baefb-515a-47e3-9e4b-16bca4dbec5e@intel.com>
 <20250617131113.GX1174925@nvidia.com>
In-Reply-To: <20250617131113.GX1174925@nvidia.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: IA3PR11MB9136:EE_|SJ0PR11MB6814:EE_
x-ms-office365-filtering-correlation-id: 7e6ae1b9-e54c-423a-0bff-08ddae12f8cc
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
 ARA:13230040|7416014|376014|1800799024|366016|38070700018; 
x-microsoft-antispam-message-info: =?us-ascii?Q?sTMUEtCbXiLvy50HAN0QGC4iGoWO5EnLAF6d/KFSSBrLFPh4vdOR/tHE3VxJ?=
 =?us-ascii?Q?Cs0P8fA+8VXzLu1HW0ZPlWX/0VaGwKxF8hL31meg90OzOt61ZrOXBwpGmhmv?=
 =?us-ascii?Q?ByxoiKZarChrXCHJL7A7AV8wTrJlOys1ZDVVUfE7xrM4Vu7VKYdDuXzeA+TT?=
 =?us-ascii?Q?Ym20SdpkKXu7iTO9YHhGzCwE767CQzG/c5JFP0lrHNv4uqSfpKLhgmT7yf6a?=
 =?us-ascii?Q?zY8Ei4wK4CEorD7Ng8Us2vgwbEf5ThN2W5AYyzHqYva56WutPjwkXWEP5zue?=
 =?us-ascii?Q?6UHkbUunAPRhKn9A/jJe4Rx/CRfb6ZXeDM0/jcA2/uNGWbcXbHLB4dxOpkC2?=
 =?us-ascii?Q?JCUed/mVAyvlzARZEPMhNM/peD2oM5G5mOXKiJHem41dMXfubsRP6YxWI2e6?=
 =?us-ascii?Q?elmgMAcWaevNkL7FiuJaVW7B07WqrDlXTemw76+9MaKamO7gqzsTzFyrm7vI?=
 =?us-ascii?Q?5TLebKScvczVB8Ax7/9jom2+Ka+FWelE/bV0gmR/R40XsOdZKKvuQ1zyZ0OX?=
 =?us-ascii?Q?Gqbp4u2x+qfPIzUN9+6a1kPV/oc6T8UM/ai1nR0l2CSE2ofbR20rmfoMtzza?=
 =?us-ascii?Q?Rzf14BQTJJFBVCBFSUvAMnB3AuaSizqhUMXfiGAeIYnu2PlgPE75l+9qVDXK?=
 =?us-ascii?Q?K8ynQ5048kRhmPD8zhrVXKxHtPujCeYsaz3eskO5ezCGFw/CCKL1SCbb0Zt+?=
 =?us-ascii?Q?nOvIBkcQmqW4K2hZmvT63ndX2q/QdsaD8Cco2sWAfHw8VfaGj3PQAg+LPXVZ?=
 =?us-ascii?Q?99MZ8M5Zybtrz6WaVtSjnJodSusLYJ/PPxZzAsWQy6vE7nhELHhxtXlqK1l1?=
 =?us-ascii?Q?PwgCDZpzOoJ6Bk5Mf2a5wU0yNu2JBWGztvRmmOwPs9V9+tMOwjILOsc14b8g?=
 =?us-ascii?Q?uAB+4afwRGHRR+4HxMjPt95A5jv9zq4Z+I4EVVKU5YXz11WmsoM7dpTGCN7E?=
 =?us-ascii?Q?8Ox4bnrJpmr2bxQuT5xkBokBY6Y9cemJmZytzQhy+ESdMl1wO8PpWug4SflP?=
 =?us-ascii?Q?2XXuve68uvowZ7s5Scft6Md2HUAZuD8/3FfFzPE+X4JdDC5Y06Bo4qEwH/cq?=
 =?us-ascii?Q?eKJQTRHTyOVNSPHlcb13/9SfRFaNl6NPnhAAzpbZ/UQeC/eIlsLgOAJTZUcc?=
 =?us-ascii?Q?LH92THIZLue1pSnV9T3J4r/6zHQjh8UHAiIb7tk8EvyFQCh0OxGF96aWiAOD?=
 =?us-ascii?Q?At3Ddo5Cx7x4OB7I9KCZS6xWb9SOlfM5L5VHZ2XEu0zovLDW74Zo4Yv21MZo?=
 =?us-ascii?Q?lxaLZ6Thj70L0EJam0WxonKkUOLf195ZEd6fZe8la61E6PQw6vgLwewMKYHs?=
 =?us-ascii?Q?1O5YTdJtGHIr6CsbRZrOSLG0C98qjtf3MCXRxps6bsclxsX4NYNLdPwBAVIE?=
 =?us-ascii?Q?SufGqGIWdyW0joit6tlEH8WZ7rXoR4DIaV1++mP/6ao8JBbOREnDHH5wR8I7?=
 =?us-ascii?Q?Yp9+qX4l1xIkypcblKxOMxdxH21njIGPkCo9+i3nXLplxc3sm60Hkg=3D=3D?=
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:IA3PR11MB9136.namprd11.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(7416014)(376014)(1800799024)(366016)(38070700018); DIR:OUT;
 SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?HrMKtNOOdQhEx11RPr9x3X36tF0qvHyCTLpAe6+hvBYAuK+s0DypgEt1Vr7y?=
 =?us-ascii?Q?mi24TTkv7ifXECUg3R9XPkHoRtFfSF1xD9d5ZTjuOrDUbVUjbc+UjGeTv6Gi?=
 =?us-ascii?Q?vrrjnhyww2Tk+f/iC7FeVIyRvYGCiBr1yQCeDh76dbvNlW+lb6V+Cx3/umk2?=
 =?us-ascii?Q?pB/0dFHtitQbSXV0o6kM8MFqFPo4U2iCLH02TEBGss+T6JOrhEmSNmtq8Fwm?=
 =?us-ascii?Q?5ceY3cB9HLIB7Gk4asdTX8Idjp+xFY5GG6ToNYX0/gs2KDcm5+lcZkNIqSAM?=
 =?us-ascii?Q?sKDi+i/rse5z95cbIMj9Eh2il3Qvu0FFvHRK3shV7I7njb2M/61X7BXLrZuL?=
 =?us-ascii?Q?hgX/4UBP3c75plD6W3PSywYzwE43X3n0lSIyxmNWPDiGz7qK6p4amzaUdmZh?=
 =?us-ascii?Q?Es4mULfYaFZi+ldSzwZ3t9TBUB3Ep9kU4NdQidOuaMi01neHFlmBWUYXEIid?=
 =?us-ascii?Q?SAM2911WKIqcxJn19t3OZaWCSozN3mTSiOvydY0svVgntJAdfy2XNHpBX8g/?=
 =?us-ascii?Q?LvVlMoBCd3BhxvRe2SgHpRz+iUI108CQKzTxwEUIUlBkpr9f5SrGI8SZPUoY?=
 =?us-ascii?Q?/RO8uK4LFaVgio7xi08sr1Dbrq5iCJGjP74SUd9gI9fwkO/mQ1afNgppNhA4?=
 =?us-ascii?Q?wDUH4FUOdYQTWxv9lrB5ZeMspz5z6+JIVs20ePvH9LLorrm9xPqOgo8OUKbm?=
 =?us-ascii?Q?8ZVraDMGLCZUBUTJJ+PsFKZfv2kFh2N0LjmQ1w7HGtly1N2wTnkt8PfV6iAH?=
 =?us-ascii?Q?wdfjy/sI644RukZnlIUIQb73AuY81KcYW2/sDzmv6Q2hxIa6ClDGVT3FHCDv?=
 =?us-ascii?Q?jBSQbr2YH4wduZQeflcNdpjS7J7MJNZ7PHUV4wTOUFKFRUNqeWCzsGjiDHYL?=
 =?us-ascii?Q?vjlxEcGEtid+wzrjFCVvba5VwWToqSv+NO+tpkfm3ZWe2C5SpiKO+EXE/ICZ?=
 =?us-ascii?Q?W6+3e9+vPKrYeStSd6dFE9Mb3biVubJ1D9sJ3uSnsEkfu5iXZp470nG4GM3V?=
 =?us-ascii?Q?fC2lXHjSzrMJIPwS4xPUxIFgxFktvch23t2S6khhfjathktuH6v1HuPSRAGR?=
 =?us-ascii?Q?69RHThd9800P4leWS1AjWkp3gsQx4fefBGcTtq1Q6uAnOv565cWdXIhi0RRf?=
 =?us-ascii?Q?T21pxXGcm4yIwLV1Gll2dQDYz93WFnqBIJXlc2jF59am4HNhvaJctWCrk2mD?=
 =?us-ascii?Q?Y7dIfheX6Q3jLncazN3j7qSClutnbVhHPejpJ0MDvFUBIZ930jyUKbNQkzHU?=
 =?us-ascii?Q?K1HwNXVXY/R1uP+A8s0BbmUr5NQ4bFDgWnTuLBxzkZFT2LOe7ye0+va1Ll3U?=
 =?us-ascii?Q?tZuY467xoN9PlL3OkmpAqqeximdbThuR82t6DY34q+0hKhIUX/0tuotv7Ttd?=
 =?us-ascii?Q?Y+t8Wc9vUbETA7Ppzu2hyLkmxpKLG6qkTrv2Xh9D4EYJ+EYtnd/RWsAI+Ric?=
 =?us-ascii?Q?3uNRbBa0jjTsEC2lMo5wu5BIunNAGvmfPjoP0+P5abN+2E9ju1TaNC81m3pE?=
 =?us-ascii?Q?chd3YS0eeWIUJ7dBe2cT2dhGjJn7exJfIOwokIy6aarZSh0SW48RZxB9Fd56?=
 =?us-ascii?Q?CkEusmJWy8xo4dGAqaLJWgpf4jE98CduWp0rxXol?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: IA3PR11MB9136.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 7e6ae1b9-e54c-423a-0bff-08ddae12f8cc
X-MS-Exchange-CrossTenant-originalarrivaltime: 18 Jun 2025 02:51:06.2715 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: K15T5kLVZ46Wt4chuFci0QlBIf6CCALtReZjkamHjF5WEZsQ21W/Ve78STLZmAz3nZxPhfVWFKM7BqZ0InIZbpkegwjul63NZ4kEGypvS+8=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ0PR11MB6814
X-OriginatorOrg: intel.com
Received-SPF: pass client-ip=198.175.65.18;
 envelope-from=zhenzhong.duan@intel.com; helo=mgamail.intel.com
X-Spam_score_int: -62
X-Spam_score: -6.3
X-Spam_bar: ------
X-Spam_report: (-6.3 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-1.89,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_MED=-2.3, RCVD_IN_VALIDITY_CERTIFIED_BLOCKED=0.001,
 RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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



>-----Original Message-----
>From: Jason Gunthorpe <jgg@nvidia.com>
>Subject: Re: [PATCH rfcv3 15/21] intel_iommu: Bind/unbind guest page table=
 to
>host
>
>On Tue, Jun 17, 2025 at 09:03:32PM +0800, Yi Liu wrote:
>> > I suggest fixing the Linux driver to refuse to run in sm_on mode if
>> > the HW supports scalable mode and ecap_slts =3D false. That may not be
>> > 100% spec compliant but it seems like a reasonable approach.
>>
>> running sm_on with only ecap_flts=3D=3Dtrue is what we want here. We wan=
t
>> the guest use stage-1 page table hence it can be used by hw under the
>> nested translation mode. While this page table is only available in sm_o=
n
>> mode.
>>
>> If we want to drop the legacy mode usage in virtualization environment, =
we
>> might let linux iommu driver refuse running legacy mode while ecap_slts =
is
>> false. I suppose HW is going to advertise both ecap_slts and ecap_flts. =
So
>> this will just let guest get rid of using legacy mode.
>>
>> But this is not necessary so far. As the discussion going here, we inten=
d
>> to reuse the GPA HWPT allocated by VFIO container as well.[1] This is no=
w
>> aligned with Nic and Shameer.
>
>I think it is an issue, nobody really wants to accidently start
>supporting and using shadow mode just because the VM is misconfigured.
>
>What is desirable is to make this automatic and ensure we stay in the
>nesting configuration only.

This will break QEMU's back compatibility. Current QEMU supports legacy
mode when ecap_flts=3D=3Dtrue, but a newer QEMU not?

Thanks
Zhenzhong

