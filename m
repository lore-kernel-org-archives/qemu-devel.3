Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5589EFF6E8C
	for <qemu-devel@archiver.kernel.org>; Wed, 18 Mar 2026 08:41:57 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1w2mTB-00046h-EK; Wed, 18 Mar 2026 04:41:37 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <zhenzhong.duan@intel.com>)
 id 1w2mT9-00046H-NF
 for qemu-devel@nongnu.org; Wed, 18 Mar 2026 04:41:35 -0400
Received: from mgamail.intel.com ([192.198.163.18])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <zhenzhong.duan@intel.com>)
 id 1w2mT7-0005fS-Qw
 for qemu-devel@nongnu.org; Wed, 18 Mar 2026 04:41:35 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1773823294; x=1805359294;
 h=from:to:cc:subject:date:message-id:references:
 in-reply-to:content-transfer-encoding:mime-version;
 bh=0UiBf7dFlczgbaIeCcVIjxVYNqPjuK5xdnnrG7APlS8=;
 b=dxPjdxJtXGJjardGNoh5yaqEAULrB4nay/eu8hX8jgHwZGdIawC5vbMp
 tT43rnQkKWtOZuSjGkAdLYgCIyIGJdJLjPBjXCK6kjU/wHnCCxePU/Mvy
 P41OtnlE2h6V9F2dUwIxNWDB55Lelj+SNon/E5pmcIjT6fRfowvUA8xvp
 NdkWcbxM0w9DsK4nqaKFnwHb9Fbse2A73NTr9jZFzztd/TAttxjqqV/rY
 1trYoycRCL8cyWOiP/P61UahSu+iS26zFjgzloRBgEREA9YDWjcfCmicb
 1T3DpLpqsRoMwm/r4pw8YbqGhRRlwQQwZ06ELCPHCjV+uIH8I2FALVhMq w==;
X-CSE-ConnectionGUID: Z9H8BHHWRd2a2Np5L/7B3Q==
X-CSE-MsgGUID: VUx5Ak5KRK6kNcVTNvAZUQ==
X-IronPort-AV: E=McAfee;i="6800,10657,11732"; a="74052511"
X-IronPort-AV: E=Sophos;i="6.23,127,1770624000"; d="scan'208";a="74052511"
Received: from fmviesa006.fm.intel.com ([10.60.135.146])
 by fmvoesa112.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 18 Mar 2026 01:41:31 -0700
X-CSE-ConnectionGUID: ztqKmrHwQxmx+QH1WUstDw==
X-CSE-MsgGUID: asy9u6OTRVWo3IpLX5Iwuw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.23,127,1770624000"; d="scan'208";a="218156057"
Received: from fmsmsx901.amr.corp.intel.com ([10.18.126.90])
 by fmviesa006.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 18 Mar 2026 01:41:31 -0700
Received: from FMSMSX901.amr.corp.intel.com (10.18.126.90) by
 fmsmsx901.amr.corp.intel.com (10.18.126.90) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.37; Wed, 18 Mar 2026 01:41:30 -0700
Received: from fmsedg901.ED.cps.intel.com (10.1.192.143) by
 FMSMSX901.amr.corp.intel.com (10.18.126.90) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.37 via Frontend Transport; Wed, 18 Mar 2026 01:41:30 -0700
Received: from CH4PR04CU002.outbound.protection.outlook.com (40.107.201.18) by
 edgegateway.intel.com (192.55.55.81) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.37; Wed, 18 Mar 2026 01:41:30 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=O/ViPmIm5dotmk8izKT4gCobGNGiHYIqdjKg+TygGi1qYufZ8qEFXEV2H0SdyO9HEwvMlNyej8JK7xO4Xi0/zAve2MVnz701wxw4Z5wNLp4mO9bZd1K07SH8Zcb97pUa0cKG62v9ReJkgV2AKt+OjE99d0jBomPNGFxV0rSFillQZkgFbBrgr67/InWcbnGS8udeFKtSe19FtSTK9eASrNvOcsLKr61hK7BiPVxBi/XL/z4yuiSG7bHFz8RZTqO8tlz/61akYqS5p4swNe7HEPZvrj9GsiJbTybMNxskU1r0hOilm+4fTWPzPyalqMs5ZBZ1UY1VdgIpoOQRAFdYvQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=0UiBf7dFlczgbaIeCcVIjxVYNqPjuK5xdnnrG7APlS8=;
 b=dD1cPj9HSSUb4IWkSMCCsu36znHgIrNoPWR+C9otbmbIIrr+0RArRc/GS8Rosz68B4ml/HW+ClL6ibhUffpOOtLVc5Ipa2VPkiiiaRAZNmwLaiEF7vrwRlMtsmod1D9qAggQSoQT3nVV3Fj7BxB40CoInSUIkLcbp/gSzUCguE7cHx3V/B0FtmICSZhX1sm0uqhRyB6gP4/L8C/TviRLdw+poXNgVg/3/kT2Hq5HkpEIxyAZJQBhD5Ckyto5ESvULbljE6IeNOKa9Q7i8CSJK9hj3K/ycoeat6TIc0ynE7SaUL9Y5gXtOMtxmm4r//O02yY7Gbi84UwXAyx8HcMkgQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Received: from IA3PR11MB9136.namprd11.prod.outlook.com (2603:10b6:208:574::12)
 by IA1PR11MB6516.namprd11.prod.outlook.com (2603:10b6:208:3a0::15)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9723.16; Wed, 18 Mar
 2026 08:41:27 +0000
Received: from IA3PR11MB9136.namprd11.prod.outlook.com
 ([fe80::37b4:37a9:4f3:518b]) by IA3PR11MB9136.namprd11.prod.outlook.com
 ([fe80::37b4:37a9:4f3:518b%5]) with mapi id 15.20.9723.013; Wed, 18 Mar 2026
 08:41:27 +0000
From: "Duan, Zhenzhong" <zhenzhong.duan@intel.com>
To: Pierrick Bouvier <pierrick.bouvier@linaro.org>, "qemu-devel@nongnu.org"
 <qemu-devel@nongnu.org>
CC: =?iso-8859-1?Q?C=E9dric_Le_Goater?= <clg@redhat.com>, "Liu, Yi L"
 <yi.l.liu@intel.com>, Alex Williamson <alex@shazbot.org>, Eric Auger
 <eric.auger@redhat.com>, "philmd@linaro.org" <philmd@linaro.org>
Subject: RE: [PATCH 2/2] hw/vfio/iommufd.c: report hint to user when
 vfio-dev/vfio*/dev is missing
Thread-Topic: [PATCH 2/2] hw/vfio/iommufd.c: report hint to user when
 vfio-dev/vfio*/dev is missing
Thread-Index: AQHctmGK4xQ70RDKOEqmNMWY8DImybWz+K0Q
Date: Wed, 18 Mar 2026 08:41:27 +0000
Message-ID: <IA3PR11MB913625861BB8217A89F83D81924EA@IA3PR11MB9136.namprd11.prod.outlook.com>
References: <20260317225751.1325098-1-pierrick.bouvier@linaro.org>
 <20260317225751.1325098-3-pierrick.bouvier@linaro.org>
In-Reply-To: <20260317225751.1325098-3-pierrick.bouvier@linaro.org>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: IA3PR11MB9136:EE_|IA1PR11MB6516:EE_
x-ms-office365-filtering-correlation-id: f1c9fe52-aabb-4cd3-a54d-08de84ca2545
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
 ARA:13230040|376014|366016|1800799024|38070700021|22082099003|18002099003|56012099003;
x-microsoft-antispam-message-info: Nk9cfuc2MUlAxOoIGvSPCZazM1YlZp/7nNJfu3dvW3K1Ce9SyNCdUO+rkf40X/mW+/jg7nsONSjXc0kxyOcm6AMxJ/59o9Vf+wtrPCRdggh6sKoTfNKpxN4A50yYHjJ1eE9sBu6Rxgp5yyS+R9xvDWHNynVwrnQojOoxLYpk5OZ8K5BfwM24NowcQj7PcgHpECprDkCFjgeuhhpuCW/Q7hxPA0CPcf6fWh14b1wxjvkCu/E+LNDUzBNAHWexZiejqw42611o/363/+vsEkuMnvIEF468p46J3C1Nq3Qzka5rL6+5pz4zhIQaMyP7NyJa3LNZZL6HqkEZnHyMV/TDOWP1bwD39fyT8F0SpZwakmKQWpx+Pmg1rHBuc7IdHwbKHme+BevriPmXhGctPlkM0UuT0y4InRq/X59QDdcV4iDyda96VkkjqDRIIhihs462tIkG3W6K7siAoFrm2Qmpry3nl6aPwpH/5QytQs/CLNf1KEMHEdtf57U8NBKVhsbAZjYrUwIU3qsqgnsPTQcBBpdDAK9rFpF6JXOgD8VqQsdf/eZpAVuC3wpkelOpdvSJL+e70mGk5QcW8PfdniJPZLNyAp4+x2LVh5bXSyS5U3W6go6ohF6FPq3uyflmcdnslEhXgYeaVfBpCaJM8SAEMpJKluSn7nUpvO2GieWq1Cp5iK7tcy3soah4Spk9KGW9OhPv0DuxE42AFZa784HCwzwi8tZmqmwAF3w+fVe3WEOw3NkRC+FA1cxenjWSE2Nip+dGBdtf0oa357Vao8aX0ceYN79RltdvTTAERWhbsW4=
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:IA3PR11MB9136.namprd11.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(376014)(366016)(1800799024)(38070700021)(22082099003)(18002099003)(56012099003);
 DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?iso-8859-1?Q?DcxdpzDkXqMXmTR/PaWe+bzimn3kavytCVSTyMxrDuZ2a+DAGWz0m5/V0C?=
 =?iso-8859-1?Q?aU8HFmdjoqoZLUjFdiKjbgfU+moTi2oSzKE4ue4amAydl2zzh7dlJR9Ukt?=
 =?iso-8859-1?Q?Q0T9uWscdVUNchzx4WnXmapqSnXzj/X8ReiJVQAsD7XQaYopGUyffRZUKq?=
 =?iso-8859-1?Q?7ltSvCSoMdg9OD1jkbaiaGiNSoCijeU7dX0RmAL9WXX/5ff8q9vGDRwbAE?=
 =?iso-8859-1?Q?BTpit+g1Fj8csIJMQZPK+eUNOrHW104rYRwEqr98JRg2DQH8OnFHsNwXaZ?=
 =?iso-8859-1?Q?YLHbb7zIZUxYJKVLS02JX4rrgEIJOiRRDQf9sy+V6W9+VkfTLCu0NIR3y0?=
 =?iso-8859-1?Q?wedgj/kAz5d3mrFXBNyLLRliRKbcon2UTrW/5OMMnSLVja6othtBS58h4m?=
 =?iso-8859-1?Q?h95mwEVfJwWVFDEouoz7Uua+D6b3NGvQU/HcKJ1+CXF+qaknba6JGKoahx?=
 =?iso-8859-1?Q?vZrefCNKcOioH7ZLfgX6oAFibCEIWMX17gNm9rusLfoxcSZ3lpMNtH2Qwo?=
 =?iso-8859-1?Q?ZbD47VCEyj8H8PAvRTD7XEPldX2ZOsiTGCAfFSfkpVqGog+kPtQva7x03/?=
 =?iso-8859-1?Q?mVhVPaFhjr/28aL8WPab6rlL78pEPsy1YE0DKl65uiAhBcJL5AZLiSisM2?=
 =?iso-8859-1?Q?OvMxs4R5YRnre0nD7m47SQ4qB6dB+PHLjMfwymJyVbNg8meGhgkE4twAga?=
 =?iso-8859-1?Q?glZA2V/bfbk0JdkYvPzECjAZHMxIcJKuTXOaWkLeavBUe5s7QiD9oJ26OX?=
 =?iso-8859-1?Q?bf+YG9LspzOTZorih9i+28/cptUArgI6ksaWjI1fcXTGwJy93BEG79wNoY?=
 =?iso-8859-1?Q?Lurzx/0q81+G8Q8clDl/QPXm+BDuocqQxkbjMP3V7MoyOXGRuq6S/Ng6kH?=
 =?iso-8859-1?Q?VDSVwIJRN2hDbSlL54riRXGQA7C+8qCDM278i1q2vRBHjG1GGog9tWvUkA?=
 =?iso-8859-1?Q?vIn4gmm1E/p8VCVakFpl3uAqD4drpg62AUrTU4WRdcP7fVKuM0pa1gL80h?=
 =?iso-8859-1?Q?964xMCT0li0X3mxw7d4Y6erJ4oiuVXcyECWxOZrT/qYvKwdNTRCZdFOQGP?=
 =?iso-8859-1?Q?AJ27Rq/k8RMfpPV+aAObdog/7wi7FekYK8306yfH7PDAnyXd9Vdqj6Ia5v?=
 =?iso-8859-1?Q?xqZVdwJgW5zrsGLYEZHtGx9znzjzlVWWd6p3W436v3qJ+a10C4vingSpyn?=
 =?iso-8859-1?Q?v8nOnCkrxNmhiLSAVz5zqPfTWfzBG+2fDwAahj7FMdkCo2yJlIN3uBS8ai?=
 =?iso-8859-1?Q?R4+i6nz9lv+MhkCj3GQjax/lJD/bvhWxlDEdtREmofDBl4r5pq9xYu7sPW?=
 =?iso-8859-1?Q?ZqKnzXVS1dBDAEwpLLmcTMNVnu7T5QJBqP4iifmOG0XDx134zJsKZd3a6r?=
 =?iso-8859-1?Q?a9X8rCGtiMHsoFkhIt79ux46mHsmv3GrUrKUetzCYqmUf/4kgIYwhTky+1?=
 =?iso-8859-1?Q?PH8PWuQyWQeearSaF7U1UtJ9t2ret1B4Tiw0C/CziZBHjYDjIcXUeFeFpt?=
 =?iso-8859-1?Q?ti9td8VgF7mV8iK4xt8X97PJK3b7jxOvXJTaEzpHiDNq0zAO43peOtGR2T?=
 =?iso-8859-1?Q?x2JT0BvI/QQxbxJpe+o1JILlLY4uJVRypyxk3HxVoq61Hx5ci/is5HuXXM?=
 =?iso-8859-1?Q?juHD2SwGutjGxKsLuO7il17vm9OMACGh5Lr9Uiw8EhOduy9o0JAWzHZnzm?=
 =?iso-8859-1?Q?gissG0gmB3sHCgqGGJySIhyiRCDMIIU5lUDmaZ53eFNZs53fNHbjE6EyEV?=
 =?iso-8859-1?Q?rDm8wb5DxsFlByEdtakWy0vyuszmmK/YV9S9UZQiWO4gDsKYunEeChdcH5?=
 =?iso-8859-1?Q?FpEuZZdYIA=3D=3D?=
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-Exchange-RoutingPolicyChecked: kdGQCSWr0KjRU08FkXzYMutWqeNwwWEZ9F2VWvp8mM6mbHOM4bgj4OX3TP06vcvgtq9rlaTsiMeIWviQM2TOrDGXzWlSo2SDdUdX0pISOB+zgEzeq7ENTE4had0A51hXh3bw/edW+fIoaZv1YP/vnpIsqTNcvuXV+dJBLX0PLvyyUNJEs36ck3g0XAnvvJyqbt5hqLIKjGcKUgSaxZYOvs8rJ5avdG0F+XNBV3mZnQCNv/AWIf01R7xeWVoLR/LvKqyE93LrMnfrtWUnD9IxHds+NjWyASdjQlaUj0uE5e8dlxI3NyO76oMiS6d7nFlSt7Z+srRMcJeNvjk9brua4A==
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: IA3PR11MB9136.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: f1c9fe52-aabb-4cd3-a54d-08de84ca2545
X-MS-Exchange-CrossTenant-originalarrivaltime: 18 Mar 2026 08:41:27.6671 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: /gvLGPK+blD2CzaNNYq+IdmxtoT1J4Wn+AKpzsWW5ftydaLhp3Y2lSE83+/tS5lfWKrjToHDVOJSo59TChkv820AdWDoJnZiXO6QpchVFdM=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA1PR11MB6516
X-OriginatorOrg: intel.com
Received-SPF: pass client-ip=192.198.163.18;
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

>Subject: [PATCH 2/2] hw/vfio/iommufd.c: report hint to user when vfio-
>dev/vfio*/dev is missing
>
>Give a hint about missing kernel config CONFIG_VFIO_DEVICE_CDEV.
>
>Signed-off-by: Pierrick Bouvier <pierrick.bouvier@linaro.org>

Reviewed-by: Zhenzhong Duan <zhenzhong.duan@intel.com>

Zhenzhong

