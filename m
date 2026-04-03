Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B7D1FD730B1
	for <qemu-devel@archiver.kernel.org>; Fri,  3 Apr 2026 07:34:38 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1w8Z28-0001fw-Gp; Fri, 03 Apr 2026 03:33:36 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <zhenzhong.duan@intel.com>)
 id 1w8Z26-0001fH-LW; Fri, 03 Apr 2026 03:33:34 -0400
Received: from mgamail.intel.com ([198.175.65.21])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <zhenzhong.duan@intel.com>)
 id 1w8Z24-00072e-CH; Fri, 03 Apr 2026 03:33:34 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1775201613; x=1806737613;
 h=from:to:cc:subject:date:message-id:references:
 in-reply-to:content-transfer-encoding:mime-version;
 bh=6/06HHZbWzyCxZqSNKCwtu7oUtQhRTeLWTU+mnc2JTI=;
 b=gjGoeWRHUdPxy+Ok/NnF9sB99VuIR8HghDBfZs7Q+vFMqI0+ppB07Rfp
 POc+mIuBgl0Hxm+iF5tGinSVOUKP/c1yNt+VMuoD1zXV4SkPkopJf4Qci
 IYHdiWkGjplr7OOSD7jG7zrWxmB+OIwW50yphldNfhsUhjYXaU9umBpMW
 9v98YvqSb6jo/rd4WA5GjQjF0nm6r/fUveshNDNtG+vvIyjYeYAff5htM
 tjap6qQDeuNTL9TS6jmnr4dHMJ+PGLg1oCODTNsurzg7CuD0hjVFl0B++
 YqRJEmVmyGqWDzN0LASaT+0iEM6Ybg5RU2QXjzZXm2/K1Mv1zasrkg8m5 g==;
X-CSE-ConnectionGUID: O+sS6IlFTUyaLPyfH5zQ7w==
X-CSE-MsgGUID: GaeJrYSESHyH628cW1Syiw==
X-IronPort-AV: E=McAfee;i="6800,10657,11747"; a="76149117"
X-IronPort-AV: E=Sophos;i="6.23,157,1770624000"; d="scan'208";a="76149117"
Received: from fmviesa005.fm.intel.com ([10.60.135.145])
 by orvoesa113.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 03 Apr 2026 00:33:29 -0700
X-CSE-ConnectionGUID: EgDESWL1Rry/nAhQ174l5w==
X-CSE-MsgGUID: NKF7KcfBRym9qo1tKaIKkw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.23,157,1770624000"; d="scan'208";a="232001455"
Received: from fmsmsx902.amr.corp.intel.com ([10.18.126.91])
 by fmviesa005.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 03 Apr 2026 00:33:28 -0700
Received: from FMSMSX902.amr.corp.intel.com (10.18.126.91) by
 fmsmsx902.amr.corp.intel.com (10.18.126.91) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.37; Fri, 3 Apr 2026 00:33:27 -0700
Received: from fmsedg901.ED.cps.intel.com (10.1.192.143) by
 FMSMSX902.amr.corp.intel.com (10.18.126.91) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.37 via Frontend Transport; Fri, 3 Apr 2026 00:33:27 -0700
Received: from BN1PR04CU002.outbound.protection.outlook.com (52.101.56.40) by
 edgegateway.intel.com (192.55.55.81) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.37; Fri, 3 Apr 2026 00:33:26 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=I0AIwiX5lJ5ciuyZpdBgTU+glxXYHMaXJI/tpC6i6DsKtLT1l1je0z8FjPUQZJD7dTAC/CCLQEtz9ldQPvNjWqIme4i9Qd4+UkTaL/7YGILv6Rp1uWlYoDYzSDjYA/GFEFT8zWnoZmxnteZOfsjiEmEpbQqjW9mxxMeGN/Ha+VnPRLQZwc/OMjN4UObBgXc21Gsb0vEgdUUs14btrE4/ZVrIZCM7rHnMkB7hDRwdH2W9yFDY01492ogHQs5vD8fwYXfPZrCi7Hhj8qg+vIMDklPhUCV++hM9VXMffiQ2dcVE94BqWmYyClHpZHrHYotSxa5HFPiGgX6TPApCDUpg2A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=prMPGjR/+BcUn5EfEm5pbUQYpCoJxrNr2OVfIWTdHc4=;
 b=Sj47t+nQ03MBkW5CyN2qMPye7q7qpda7ptKEx2HB+MADRvWJ+rIKXw9/mDsQ/Bz6m4qWwjQ9THwN4eYP+agQRKa5S3hR33kkD7eE2FjdpN0ZvYiFvGtlgdiI5OQF+gn7QULQNslyomv14oCd6O1aBLcbBW0iI96v/eikNCMlImW+y6ndL9h0keZKTMhoaB7wd0w5CBqXa3nbA7TOw7JXoHiqSdV75ZKdOTFkgzZNFrX7EzR4KDBOaSCTeFZq8mImi+K2/YIFsnhnUvoTsSl/HbkBu5QBThFudX6X47m37SOFwk5YU3Uno549WPgVzesW72aNQM2wwtZWzQNakMMXIw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Received: from IA3PR11MB9136.namprd11.prod.outlook.com (2603:10b6:208:574::12)
 by DM6PR11MB4706.namprd11.prod.outlook.com (2603:10b6:5:2a5::15) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9769.20; Fri, 3 Apr
 2026 07:33:18 +0000
Received: from IA3PR11MB9136.namprd11.prod.outlook.com
 ([fe80::37b4:37a9:4f3:518b]) by IA3PR11MB9136.namprd11.prod.outlook.com
 ([fe80::37b4:37a9:4f3:518b%5]) with mapi id 15.20.9769.011; Fri, 3 Apr 2026
 07:33:18 +0000
From: "Duan, Zhenzhong" <zhenzhong.duan@intel.com>
To: Shameer Kolothum <skolothumtho@nvidia.com>, "qemu-arm@nongnu.org"
 <qemu-arm@nongnu.org>, "qemu-devel@nongnu.org" <qemu-devel@nongnu.org>
CC: "eric.auger@redhat.com" <eric.auger@redhat.com>,
 "peter.maydell@linaro.org" <peter.maydell@linaro.org>, "clg@redhat.com"
 <clg@redhat.com>, "nicolinc@nvidia.com" <nicolinc@nvidia.com>,
 "nathanc@nvidia.com" <nathanc@nvidia.com>, "mochs@nvidia.com"
 <mochs@nvidia.com>, "jan@nvidia.com" <jan@nvidia.com>, "jgg@nvidia.com"
 <jgg@nvidia.com>, "zhangfei.gao@linaro.org" <zhangfei.gao@linaro.org>, "Liu,
 Yi L" <yi.l.liu@intel.com>
Subject: RE: [PATCH] hw/vfio/iommufd: Control dirty tracking for nesting
 parent HWPT
Thread-Topic: [PATCH] hw/vfio/iommufd: Control dirty tracking for nesting
 parent HWPT
Thread-Index: AQHcwbPw1GepVXR9ZE+ge6WyOpzldrXM9KAQ
Date: Fri, 3 Apr 2026 07:33:18 +0000
Message-ID: <IA3PR11MB913645595AA06064691C7EEB925EA@IA3PR11MB9136.namprd11.prod.outlook.com>
References: <20260401084133.56266-1-skolothumtho@nvidia.com>
In-Reply-To: <20260401084133.56266-1-skolothumtho@nvidia.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: IA3PR11MB9136:EE_|DM6PR11MB4706:EE_
x-ms-office365-filtering-correlation-id: 9c0d286f-f3ba-4dbd-81c7-08de91534682
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
 ARA:13230040|376014|366016|1800799024|7416014|38070700021|22082099003|18002099003|56012099003;
x-microsoft-antispam-message-info: a92eaBrsS0NME/WznVh8m86jqj3EUSRBCXihiraDHCp0dDlBs7hAgRABAPZgjOfs20Kp/UxX3i74bQ5fLUKmIwnu2cb58E8hZxaPtt10p45mrfDkS2TnsmKJHkN9m6WkSFyLtpxduxDaTLw7lJGWvczxxfsx9fCcbz7dbXObGcrTEjxO/GF0AzZbxRKz947lu6uAwsyKiKj+iOnSfrwwtIbrFdBPSgosm0ko4miXP5j4f2mt6Fm1X4LINVS/KpDZ69FPwVigORALGu3Z/d80iK8iox1H2KbbYgcVV4oDjOGpV+WgMLK7kiD3jkRWZP8iSjsoIjn2w7LmDk7Dl32MppcZVxCN2qHkPg+XJDbXlexri+GOJ4+EjDKtSd9oKYfH9AOaoymZbyHaDcksHuTUV8CalXahSdf3EICxeuSfrSEHviQ9qk35pWnizpDkSc2cVdy5OAfmRkll72WGPGitMXd5ykJopH7RpKbZeYWadn3t3g0nI6PFVB14xJzTfzE3wX0EZ244mDRTV4olmZ4atxlK8el/6PRScXoUlbjMHczS/Nrkt0zSUv6+PCNlUSEoMGfDglL6ruOBAbLyfQ3X3ZeiNEBo+gcMnXjdww8MayiJTaPBPsrcVcCIGfy/wPcLJGWxKTTKCWgMfsBr/CeVlzPw7pBtsZY4+6YjVaaawTSZk/akZnZrtmJDpQQkCJHHrgpx1tqPDltD+V7uVxSCV5sAotX7a8MacJa8QWBOhlkvNtGViJmDjE/PeU9fO1hIz0uGpaNM1fQZBewteDOK03AX7HIMGiyH0xOG+1Yya40=
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:IA3PR11MB9136.namprd11.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(376014)(366016)(1800799024)(7416014)(38070700021)(22082099003)(18002099003)(56012099003);
 DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?C8oLVS5TeXQh+0X3215on+l2KZdBHdlQ/ffeo9Ed6FjriR+WL2fVubq3YBMM?=
 =?us-ascii?Q?FShSC1OjTmId+NphbgMTJ4c/WauS2/QmFwpEHVx97P2on/lDoyVbdPF8Zd7x?=
 =?us-ascii?Q?wcU6VjtBjTYbw60oI61+tKr2/0KFBQSS4i7kNZw4SWNsZYM5vfjAYjvH7i5j?=
 =?us-ascii?Q?TpHXd4w/b36PTzAviki6PjZ2MI9MASKlLjc/HK+WgGotKhrzVioKK/AgarSR?=
 =?us-ascii?Q?j0XyKzc/Bzwz+cLJBWSmR7xhO0HiEU5L83vpL44xh/XxCGgghQbxMj8Mr9sH?=
 =?us-ascii?Q?28FoKhf3uwbqRG66BAIHWphbvTH0a1t0OcxsVjsJv0/UhKC3jufMyky+B8L7?=
 =?us-ascii?Q?37qjL/7+OFDaejiLAYab0HhF6JinnkkDuuJcxPWGyouPQ4vxbD2+S/7M2het?=
 =?us-ascii?Q?UcC8ogAd1UmIc4IrMZ89PV/i52ZdK5AvoQOVCDtNSl88HpFD49nJojfd8ss1?=
 =?us-ascii?Q?TZhhJsfbmXQviQ+OUd49ojTyGBXLy11JgeoaHGoxKb6+W1qch8gi95rX7k8f?=
 =?us-ascii?Q?fSlNjYf35orQ3bOAJ39rzuOlqNg/7/hctu72cwUi+L5eFlhtCZMAIjerekLy?=
 =?us-ascii?Q?uOAKi+yDFcQWCCFKGJJyvc/T1FOSka8M+nEFsIbHCksI/17RzAqgWVqCjccH?=
 =?us-ascii?Q?MDGqqNXFcs+FzE4Iu926Or4dXSSkd3Fs64T0486IbM5rh9md6QsGSwUDNlei?=
 =?us-ascii?Q?5gpUW3n+7yHlr72yRxn/NwTvDOpYI1kcKLlQejR3uKlmsIM2vrliVzilh37O?=
 =?us-ascii?Q?2jqa7DkGg7oluOpzUI8w5F0KOMjMGQxyYmpLveXE4lCp/GBNBxDDTPeR5QUj?=
 =?us-ascii?Q?c+xAa2uefb0l0c8XuZieUZAT2iS3m4eqIwes4lR1qh0/1lz9KP/BJRT/4G9Q?=
 =?us-ascii?Q?eVofrt5uGo5bqkVu0zIC2iCl8L8xq/Q6KQ7P5vXCafLBcsaPqlaE3Q2Lk6tr?=
 =?us-ascii?Q?teUuusb81NBcFDi1+nlDTmiRJQ5UJZfIhKig/9BuvlG9+zdy5ovrFYlG0C8d?=
 =?us-ascii?Q?jKEZB7JVLZkSowIPLEaHfTs5H8ucYVR2WJvRoQVzd9kUWhYdXhtZ7GXDSoEo?=
 =?us-ascii?Q?M/W034xq8ZNbEc7bsc/eqkcQ/xFH+fBSlRDxdBXMW4AEwvG/nbbSweKx1eUF?=
 =?us-ascii?Q?6jQzm2JdTZkwBL5X0IBCBi5k67cK2YQ1Q0btnxKj6FrG0oSq72R/eiEti9n4?=
 =?us-ascii?Q?lrX/HZBt6ZmfSapu3a+EquwqAfW0o8OViGcCwKYxdSSgTg8osyx6+Slri8Id?=
 =?us-ascii?Q?6gUKZaG2s5sxh6KtV8zN61vQltWcCOXAdfDfVVQ6gYjIs0YHxq/K3TD0hzju?=
 =?us-ascii?Q?3eiM5G5Z8XOEjyRVp9rlcFDcqqZzsitef3lwgjiUC9YCwhDLicdMEjFcSBWf?=
 =?us-ascii?Q?ZSWMUE0BhavQYdlqJIW/OOmfhFYHcK8gHR/70k3wcF11tgwzvOnKAre5nxed?=
 =?us-ascii?Q?EMqJpRKyiBfbk/sP2VIj1U7Y0pA62y7JRysx9vc3J3BRVGzWJ3vG7/VL1V3l?=
 =?us-ascii?Q?1QBvpJjkTo7Agh0kpixMIvB5vXOEMjWS8McrU8zOPIyZaxWQ5n5uJidZV2z2?=
 =?us-ascii?Q?NzooR6nSdveNV370MvfzBFIzwfdQh5SlEZx9I+Gx50ShHCXvxXS+pfM5G3Xf?=
 =?us-ascii?Q?j2247uw8sL+1M0Dsf4gYlzflMmV7xVMYDTYxyniydzkBCx0dsJQLR/1cS+1S?=
 =?us-ascii?Q?kRolxgROWomie+AuXkotoPB9GY/9WUbLTV6J5tknA22vSuWKBJTykAcqIBWP?=
 =?us-ascii?Q?1+V0Oea1CQ=3D=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-Exchange-RoutingPolicyChecked: f77TAyWOZw51iBzCwGkEB+YnkSHmtHk0B/6RZ3dGMhpL1ryfoJua9kLtFD3sGvlSHUV6at8oev7dnV3DvipAfj6+D4uh6rg5JQOTXZlh8s26KlNHA+7SvOMsGH7fj2ITrMaWQ3CO3heoh+7p7xv5fX6CyWxK2NczMdgl/Tc81CqtCESHqCdRuLM6/eSk+IFMwe3nqjjBD3fa/9fHwuF/mXlUP1XpqPj6vzy6ni7ipmUFOX0Nq6qrkjnYkCc8geIFVlHRqjVpkfzWuh+ez8c+tlZXggRK6FWP+YR4RAMHmzeJjAUpYeK5e+hH6qOrlcdHFdkyjm6hSK2DPiKCKyJBYQ==
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: IA3PR11MB9136.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 9c0d286f-f3ba-4dbd-81c7-08de91534682
X-MS-Exchange-CrossTenant-originalarrivaltime: 03 Apr 2026 07:33:18.4019 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: ZAI1jVEk70AHyqPLxfwEXjI6ve5Guib8L/IXXMoZxyIYioLO6zAeDq5pVsepcIS1kNHaImx73UTaKUDdWPqAKa6H9LAwNI0wWvPW+CVMTec=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR11MB4706
X-OriginatorOrg: intel.com
Received-SPF: pass client-ip=198.175.65.21;
 envelope-from=zhenzhong.duan@intel.com; helo=mgamail.intel.com
X-Spam_score_int: -48
X-Spam_score: -4.9
X-Spam_bar: ----
X-Spam_report: (-4.9 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.542,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_MED=-2.3, RCVD_IN_VALIDITY_CERTIFIED_BLOCKED=0.001,
 RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001, SPF_HELO_NONE=0.001,
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
>From: Shameer Kolothum <skolothumtho@nvidia.com>
>Subject: [PATCH] hw/vfio/iommufd: Control dirty tracking for nesting paren=
t HWPT
>
>QEMU smmuv3 accel does not support live migration yet, so dirty
>tracking for the nesting parent HWPT is not useful.
>
>Also, nested vIOMMU use cases can break on some platforms. For
>example, SMMUv3 with HTTU may advertise dirty tracking capability,
>but the kernel supports it only for stage-1. Requesting dirty
>tracking for a nesting parent HWPT (stage-2) can fail.
>
>Add a vIOMMU flag to explicitly request dirty tracking for the
>nesting parent HWPT. For nested cases, dirty tracking is enabled
>only when requested by the vIOMMU.
>
>Non-nested cases and Intel vIOMMU keep the existing behavior.
>
>Fixes: fc6dafb98cec ("hw/arm/smmuv3: Implement get_viommu_cap() callback")
>Signed-off-by: Shameer Kolothum <skolothumtho@nvidia.com>

Reviewed-by: Zhenzhong Duan <zhenzhong.duan@intel.com>

Thanks
Zhenzhong

>---
> include/hw/core/iommu.h       |  2 ++
> include/hw/vfio/vfio-device.h |  1 +
> hw/i386/intel_iommu.c         |  7 +++++--
> hw/vfio/device.c              | 11 +++++++++++
> hw/vfio/iommufd.c             | 11 +++++++++--
> 5 files changed, 28 insertions(+), 4 deletions(-)
>
>diff --git a/include/hw/core/iommu.h b/include/hw/core/iommu.h
>index 86af315c15..cd59a367ce 100644
>--- a/include/hw/core/iommu.h
>+++ b/include/hw/core/iommu.h
>@@ -21,6 +21,8 @@ enum viommu_flags {
>     /* vIOMMU needs nesting parent HWPT to create nested HWPT */
>     VIOMMU_FLAG_WANT_NESTING_PARENT =3D BIT_ULL(0),
>     VIOMMU_FLAG_PASID_SUPPORTED =3D BIT_ULL(1),
>+    /* vIOMMU needs dirty tracking on the nesting parent HWPT for nested =
use */
>+    VIOMMU_FLAG_WANT_NESTING_DIRTY_TRACKING =3D BIT_ULL(2),
> };
>
> /* Host IOMMU quirks. Extracted from host IOMMU capabilities */
>diff --git a/include/hw/vfio/vfio-device.h b/include/hw/vfio/vfio-device.h
>index 828a31c006..a95c5bf503 100644
>--- a/include/hw/vfio/vfio-device.h
>+++ b/include/hw/vfio/vfio-device.h
>@@ -268,6 +268,7 @@ void vfio_device_prepare(VFIODevice *vbasedev,
>VFIOContainer *bcontainer,
> void vfio_device_unprepare(VFIODevice *vbasedev);
>
> bool vfio_device_get_viommu_flags_want_nesting(VFIODevice *vbasedev);
>+bool vfio_device_get_viommu_flags_want_nesting_dirty(VFIODevice
>*vbasedev);
> bool vfio_device_get_host_iommu_quirk_bypass_ro(VFIODevice *vbasedev,
>                                                 uint32_t type, void *caps=
,
>                                                 uint32_t size);
>diff --git a/hw/i386/intel_iommu.c b/hw/i386/intel_iommu.c
>index 4924aa4375..5ec5ed82d7 100644
>--- a/hw/i386/intel_iommu.c
>+++ b/hw/i386/intel_iommu.c
>@@ -4831,9 +4831,12 @@ static void vtd_dev_unset_iommu_device(PCIBus
>*bus, void *opaque, int devfn)
> static uint64_t vtd_get_viommu_flags(void *opaque)
> {
>     IntelIOMMUState *s =3D opaque;
>-    uint64_t flags;
>+    uint64_t flags =3D 0;
>
>-    flags =3D s->fsts ? VIOMMU_FLAG_WANT_NESTING_PARENT : 0;
>+    if (s->fsts) {
>+        flags =3D VIOMMU_FLAG_WANT_NESTING_PARENT |
>+                VIOMMU_FLAG_WANT_NESTING_DIRTY_TRACKING;
>+    }
>
>     return flags;
> }
>diff --git a/hw/vfio/device.c b/hw/vfio/device.c
>index 973fc35b59..8f7ae919a5 100644
>--- a/hw/vfio/device.c
>+++ b/hw/vfio/device.c
>@@ -522,6 +522,17 @@ void vfio_device_unprepare(VFIODevice *vbasedev)
>     vbasedev->bcontainer =3D NULL;
> }
>
>+bool vfio_device_get_viommu_flags_want_nesting_dirty(VFIODevice *vbasedev=
)
>+{
>+    VFIOPCIDevice *vdev =3D vfio_pci_from_vfio_device(vbasedev);
>+
>+    if (vdev) {
>+        return !!(pci_device_get_viommu_flags(PCI_DEVICE(vdev)) &
>+                  VIOMMU_FLAG_WANT_NESTING_DIRTY_TRACKING);
>+    }
>+    return false;
>+}
>+
> bool vfio_device_get_viommu_flags_want_nesting(VFIODevice *vbasedev)
> {
>     VFIOPCIDevice *vdev =3D vfio_pci_from_vfio_device(vbasedev);
>diff --git a/hw/vfio/iommufd.c b/hw/vfio/iommufd.c
>index 131612eb83..231635cdc7 100644
>--- a/hw/vfio/iommufd.c
>+++ b/hw/vfio/iommufd.c
>@@ -349,6 +349,7 @@ static bool iommufd_cdev_autodomains_get(VFIODevice
>*vbasedev,
>     ERRP_GUARD();
>     IOMMUFDBackend *iommufd =3D vbasedev->iommufd;
>     VFIOContainer *bcontainer =3D VFIO_IOMMU(container);
>+    bool viommu_nesting, viommu_nesting_dirty;
>     uint32_t type, flags =3D 0;
>     uint64_t hw_caps;
>     VendorCaps caps;
>@@ -402,8 +403,14 @@ static bool iommufd_cdev_autodomains_get(VFIODevice
>*vbasedev,
>         return false;
>     }
>
>+    viommu_nesting =3D vfio_device_get_viommu_flags_want_nesting(vbasedev=
);
>+    viommu_nesting_dirty =3D
>+        vfio_device_get_viommu_flags_want_nesting_dirty(vbasedev);
>+
>     if (hw_caps & IOMMU_HW_CAP_DIRTY_TRACKING) {
>-        flags =3D IOMMU_HWPT_ALLOC_DIRTY_TRACKING;
>+        if (!viommu_nesting || viommu_nesting_dirty) {
>+            flags |=3D IOMMU_HWPT_ALLOC_DIRTY_TRACKING;
>+        }
>     }
>
>     /*
>@@ -411,7 +418,7 @@ static bool iommufd_cdev_autodomains_get(VFIODevice
>*vbasedev,
>      * force to create it so that it could be reused by vIOMMU to create
>      * nested HWPT.
>      */
>-    if (vfio_device_get_viommu_flags_want_nesting(vbasedev)) {
>+    if (viommu_nesting) {
>         flags |=3D IOMMU_HWPT_ALLOC_NEST_PARENT;
>
>         if (vfio_device_get_host_iommu_quirk_bypass_ro(vbasedev, type,
>--
>2.43.0


