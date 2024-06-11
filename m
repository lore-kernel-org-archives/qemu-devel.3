Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4BD98C27C55
	for <qemu-devel@archiver.kernel.org>; Tue, 11 Jun 2024 03:23:54 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sGs6m-0001e7-1v; Mon, 10 Jun 2024 23:23:40 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <zhenzhong.duan@intel.com>)
 id 1sGs6k-0001cF-P7; Mon, 10 Jun 2024 23:23:38 -0400
Received: from mgamail.intel.com ([192.198.163.18])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <zhenzhong.duan@intel.com>)
 id 1sGs6i-0006fo-Rt; Mon, 10 Jun 2024 23:23:38 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1718076217; x=1749612217;
 h=from:to:cc:subject:date:message-id:references:
 in-reply-to:content-transfer-encoding:mime-version;
 bh=2ldoq6QT3Pe26rIHHR5/LTMnvBAmaeGHDGyh77q6fMc=;
 b=GflRs9DP8AnmGOZEGSGkt/cdtpwD0Z3twbapJ3yXkTAU4czf/gny8tfJ
 2r/QXYHbp/j37q7coGSFgO/uJu+btXzLLWP7HCsGCNxIqGQsSaxSw88uH
 WHWI7w0d3iqbel4CKxByZbZWdFNDvIZWXmDR0ThN0itu/wnEUO0f8LSsm
 lXMs/uL4xN7HWyiq4HttIHBGUdTa0j82GHR0EeZNSQ8grl6rT2aajAKq+
 mC3xTJsJ5TQGxZgW1P7gNCV9LLN15xXD/iOoZgJx5Yg8OzUEKDls4QGsw
 +tVl/CmGfBRd++oE491nY6jU6+BVS7Cz2WQ6uVR7xzLwXokkVdqiPFLnu g==;
X-CSE-ConnectionGUID: ZzSnLxxSTdCAwf8KYqssEg==
X-CSE-MsgGUID: ewtBozqfQc6Napwy3cr2IA==
X-IronPort-AV: E=McAfee;i="6600,9927,11099"; a="14489246"
X-IronPort-AV: E=Sophos;i="6.08,227,1712646000"; d="scan'208";a="14489246"
Received: from orviesa006.jf.intel.com ([10.64.159.146])
 by fmvoesa112.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 10 Jun 2024 20:23:35 -0700
X-CSE-ConnectionGUID: wLzOz8dKRy+4Cl8dLxPTvQ==
X-CSE-MsgGUID: xHKs4rfZTSa3FC4dRL5EhQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.08,227,1712646000"; d="scan'208";a="39732386"
Received: from fmsmsx601.amr.corp.intel.com ([10.18.126.81])
 by orviesa006.jf.intel.com with ESMTP/TLS/AES256-GCM-SHA384;
 10 Jun 2024 20:23:35 -0700
Received: from fmsmsx610.amr.corp.intel.com (10.18.126.90) by
 fmsmsx601.amr.corp.intel.com (10.18.126.81) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.39; Mon, 10 Jun 2024 20:23:34 -0700
Received: from FMSEDG603.ED.cps.intel.com (10.1.192.133) by
 fmsmsx610.amr.corp.intel.com (10.18.126.90) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.39 via Frontend Transport; Mon, 10 Jun 2024 20:23:34 -0700
Received: from NAM11-CO1-obe.outbound.protection.outlook.com (104.47.56.168)
 by edgegateway.intel.com (192.55.55.68) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.39; Mon, 10 Jun 2024 20:23:33 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=gab6XVv2+D7hhbSHdvE21tHoaR8UshUVbYilxODhpGrlOTjAMbCGINg85xxZupdo2UfSLAet8wWyxW95TvdB+8XIDWimmCtsYNuOvpSRLh17Tx/9Nz3ceWzX+/+aBypxhtkGfI07qH2RpxP5/CCJxbf8QITXXxGlglmKaxkQhwdzZlpqFYSO/VHWiN6ZsDsRTZqTgXA5dSe0EGe0iLaJItxApn5b/3KocWZn7/V3iC5VXPcdDfzXe9xKStGyGdZ4xJOh++XFce+nnhpLntv36fjAWGQqZpbC3bLLNbN8VMq+1dljgHU2MhvZ/xbySBgzYxbbSAMeh9Vys6xCKsAoyg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=U5dB0GCgXuGmeBRmXY690+BVkDTDO8pQonMi4exEFi8=;
 b=IQWG9CCLbselTJpBFKAz07jKyJb0+NBejsEJgg4zyfNNEBB2OlbD6SZiLoOXUxi46aHiaflsvNHd43VjdPG8TQqeMGAsTToy/l692LbqIfEoiqa4zEBCbsh95TTwEVj41WhzxLdoH2O0EYygeKacQIionz3iBcAEuUb0dWBz3j9tB6htuU0Eh7XRsC/l8SEr9H5/hahTFpfnIVdh179AzGzF2kTfLmHKKfYUaDJlWyeveQ8RUNt7YY6y2/aA0N29+NKCbTzMJiNv7Tg/zyBddbCJ0dmD3/cnohgCbS/091phlLTKYp/6YfuWcfROJD/Afl49vA/5QevhCdcWeENhwQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Received: from SJ0PR11MB6744.namprd11.prod.outlook.com (2603:10b6:a03:47d::10)
 by BL1PR11MB5238.namprd11.prod.outlook.com (2603:10b6:208:313::8)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7633.36; Tue, 11 Jun
 2024 03:23:27 +0000
Received: from SJ0PR11MB6744.namprd11.prod.outlook.com
 ([fe80::fe49:d628:48b1:6091]) by SJ0PR11MB6744.namprd11.prod.outlook.com
 ([fe80::fe49:d628:48b1:6091%7]) with mapi id 15.20.7633.036; Tue, 11 Jun 2024
 03:23:27 +0000
From: "Duan, Zhenzhong" <zhenzhong.duan@intel.com>
To: Eric Auger <eric.auger@redhat.com>, "eric.auger.pro@gmail.com"
 <eric.auger.pro@gmail.com>, "qemu-devel@nongnu.org" <qemu-devel@nongnu.org>,
 "qemu-arm@nongnu.org" <qemu-arm@nongnu.org>, "mst@redhat.com"
 <mst@redhat.com>, "jean-philippe@linaro.org" <jean-philippe@linaro.org>,
 "imammedo@redhat.com" <imammedo@redhat.com>, "peter.maydell@linaro.org"
 <peter.maydell@linaro.org>, "clg@redhat.com" <clg@redhat.com>,
 "yanghliu@redhat.com" <yanghliu@redhat.com>
CC: "alex.williamson@redhat.com" <alex.williamson@redhat.com>,
 "jasowang@redhat.com" <jasowang@redhat.com>, "pbonzini@redhat.com"
 <pbonzini@redhat.com>, "berrange@redhat.com" <berrange@redhat.com>
Subject: RE: [RFC v2 6/7] hw/vfio: Remove
 memory_region_iommu_set_iova_ranges() call
Thread-Topic: [RFC v2 6/7] hw/vfio: Remove
 memory_region_iommu_set_iova_ranges() call
Thread-Index: AQHauOiVPtdt/fiVO0eo06xaY0ED07HB644w
Date: Tue, 11 Jun 2024 03:23:27 +0000
Message-ID: <SJ0PR11MB674446A23A312F07E0E64CAC92C72@SJ0PR11MB6744.namprd11.prod.outlook.com>
References: <20240607143905.765133-1-eric.auger@redhat.com>
 <20240607143905.765133-7-eric.auger@redhat.com>
In-Reply-To: <20240607143905.765133-7-eric.auger@redhat.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: SJ0PR11MB6744:EE_|BL1PR11MB5238:EE_
x-ms-office365-filtering-correlation-id: 4b454920-0944-4a8e-033e-08dc89c5dc03
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
 ARA:13230031|7416005|1800799015|366007|376005|921011|38070700009; 
x-microsoft-antispam-message-info: =?us-ascii?Q?QN46j4G7uNod4YZuycyc6FvTgh9rc/EKFu0AJ3NgxTnaAeDLY3W7JiB5Qhpn?=
 =?us-ascii?Q?ZirJwDJyl1Gj4YByFKpC5V5QQ31nL6e3FfBnR6zC6gf6NS22/Gn84AroZz66?=
 =?us-ascii?Q?qwVId6wxUf83wNyPXVEltW61u/c/zoX1bxcM3SjxZ9i/UCs+KkNvlIUsUc6N?=
 =?us-ascii?Q?b/ijiK+Sqyuju0runFNmsUN5noF2TGkm1+b8bG8ARytp0MEiHxyrGsvbBVTR?=
 =?us-ascii?Q?0vFuiReZibRrdcZFrw6DaWBe6W5B2noMmuppQlI/c6yj8OglAM0hwVhh6F0B?=
 =?us-ascii?Q?xMlt7RLOzMORmIkUYxf14Twu0VB+FSxwvwKra5R1AZrMOHgT+b0Kfqnnoe42?=
 =?us-ascii?Q?eGCK96YR5y2RO/H2uyVGsveg2w+ym6DcimMjhMx46HRoravODICxfmygG0Vn?=
 =?us-ascii?Q?Mk9sd8xwp9OED7n7aiYyVzrgIP3KR9SgX34fSWHI9UvvvhZpJseE2kbtj+wT?=
 =?us-ascii?Q?0LYtWNoCVPoQ1rXNfOaQa96ZbRONx5BJcrCU+/t/pHwL7HcWj4eB4NEwiQ69?=
 =?us-ascii?Q?gGy3i8tUShUm0f9bbp7DnLuinWy9BBvFvN6quwtZQ7KzL13dsoRGG87NglsC?=
 =?us-ascii?Q?vjxk8jQHgALOUTUuLYNLPA+A9IZravRv7M758cYgcHNLxVHNE4WpZYBwo7Ho?=
 =?us-ascii?Q?2cIJGILCY0DRXATb/YRyQ17riXlMe0j4vh9ZJUKqu0+/+v87Rrdy9BsRpwcW?=
 =?us-ascii?Q?uibBy4Xhp4JFI4YxlknDlAiVpVhrhW9AwIE6IZyTORTJKSdBsPhSg3chI8xf?=
 =?us-ascii?Q?1sZD+uFSrcPcAEWMj2fSoNc29vdGQTFaPV+wU349Y+E4HNfDzHgHW5ksKxms?=
 =?us-ascii?Q?JF24msPPUwfcm0n2B+PpadvSKU6XYi8cjk5B1Ly33ZY2z5GB39hAACSdsaml?=
 =?us-ascii?Q?uwAAkrZguX7RexP8PV/frNy/e7tMaxG9m5Zfrc6K2irNuaGZLuj67o5PRdIz?=
 =?us-ascii?Q?DyVDCDXo2UCbei1l2QpJrDkSZ9b4Qtt/BA6DxGhBj5uEbk5KAXnoaW6Nt1Ux?=
 =?us-ascii?Q?/VwvfVfSNfarrSsSRD2hm9lrEKBEsfHBRXLgD65kLa7HLEn3thPo1BVDH85h?=
 =?us-ascii?Q?rr+APcj9TBxmaT37pcgDQIfveKyWKjEz/ysMFtVmefpHVIfyBsFqUO7rviY0?=
 =?us-ascii?Q?A8hQAiF9mhdMjSnYS9U5euDZEIpAY+EciC8HfHP0V7kz5dC4yWlQbsbP+LR+?=
 =?us-ascii?Q?JIsSW2l2ZAbK8Dw1uaO/Wwb5gV9y8j9netvIilKQaL68R+nz5vLpdUX3PCKI?=
 =?us-ascii?Q?qVNA5pcXB1EOcmkDIoGG6r2eIckqCKjpUn0obJ2Eu9imagfO2Zf5pbYwhB2g?=
 =?us-ascii?Q?UBaMXTF7+/75pV6zmZgzPMGdZ0Lru63oj3dJxpaqvv2SxMZ1+HvXZabHvtEF?=
 =?us-ascii?Q?+EEV3O9JqVnSSs9KdMHWMd+PVmke?=
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:SJ0PR11MB6744.namprd11.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230031)(7416005)(1800799015)(366007)(376005)(921011)(38070700009);
 DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?gYZbxWZlhf5RE0h/dfkiVaChIXWjN5O0Djux0ZipIXzuKMI3oRgFlvGu9gM9?=
 =?us-ascii?Q?nt9zfJ8tcEHeeAJNMbzULRsIk+ZA+bpUhmRSFPGfHfcL4kVGdSZp8LlYVEg/?=
 =?us-ascii?Q?IQBPtACLklJFnrNMU419RCoeuD780GtPnEtkAMEc7R/p/oL+LqmBX1lvj7zV?=
 =?us-ascii?Q?R+hkjF1YCFrI/2zAA2mhYEBfcN7PgB848u1cfb3F/GwWqoXejm8MqSGzh9mR?=
 =?us-ascii?Q?SA8SJXtGVA0IbpgqNavE3oQy8zz+XMQr3q+CUcVHW5rYGb+HW6y7cgnz8A95?=
 =?us-ascii?Q?41M6YQahXp9C59lJJAB5bApajVafYLhIlGlOoDHrALY1oKI9F9qXlqYizat3?=
 =?us-ascii?Q?uGHJ+SyQ/PoZl4dCZ1SQ/+P74sDmQ6FZ5yaQXDmZR0JLCRZXXymHo/0ggerX?=
 =?us-ascii?Q?MUpkbcI6rBaixL+AmFPA8q6b+B+UDMOqWMTX86yrE5/f+o3xyYP3YeYTyvzI?=
 =?us-ascii?Q?uuPGaR0lvlgLtKHFmz5P1XXbnxCdVjNfEmc2gMtD/9I4GeFIUErpSps899CL?=
 =?us-ascii?Q?yaQX8YkfamVZ2JPx5QoOWX0Gjug//ebyS1XYUB/PhFt7t3kAVzQreISlgbJ+?=
 =?us-ascii?Q?5nd+VGCHnNRBmtA9LzqPnoPQOKxdJuFQ7BLKXRuHdvo2V1LwTSBT9U3R/qd9?=
 =?us-ascii?Q?1CRiFWBs3LsJEn9M12WkDtJWIOoJCpZHa7qpREUgD5Xo2A4MoCfccV+cDlOx?=
 =?us-ascii?Q?e4PpQuiapvbdcFYwZUsrtPgReyKG+DjWE0QUvwj0R9ePTBePi4wbISHoESXu?=
 =?us-ascii?Q?3s9TNW1iEffIz3CwpA0NoT8rwnguUw/X2JWTIVmLR9MvqWFF6FflyohK4eRS?=
 =?us-ascii?Q?02RMYxoAJifqaWY4+NxsEP78IWdppXSrTG5onD3AHoNPN8IM/OFIoTW6Hy7p?=
 =?us-ascii?Q?CKWV+bUobkQxqny4X/c+XoBujItGXeRpW2m7UmEhP2OHIammdvKRcG162zcv?=
 =?us-ascii?Q?d1U9l0UYDrV0gQNKpanhX51MXLo9VthzyBXWBWHGaeXIx/0PsDwpE+OFt8z1?=
 =?us-ascii?Q?tXuDDPExvETtwKU9ZZFzDFXHNf3FwLZVf/jEGQ6PWX+/ExsyEp4co6xPAXNE?=
 =?us-ascii?Q?oiH7HGSNSS705ETMraPiJ18Yo194zfExukSoan5u8qBXyzITpDLriWmHUfM+?=
 =?us-ascii?Q?+0y7ppQvDv6rhIOZ5Yy5WGgELSboeiHIALe6p8SLkYX8FelHPq5FLwDQWvXY?=
 =?us-ascii?Q?/x48dfL6NqaMbhcZ2nUd6cIqFot8g5cQKP06+x4174/B/wQgcCwmWWNnHC25?=
 =?us-ascii?Q?jYQbCiD+TQtO3vOT2iS4kOs2bSktfNa/gpzybNyxhFEEAy8QOARpSJrSNZb2?=
 =?us-ascii?Q?taKsh+oJvxdd7bFdBozZyNLk7vHfqMXuaKpVUQdJ6v7s7RbaP0L7JoisS40a?=
 =?us-ascii?Q?nVt0WXkV2ABeeR7iHW5fOFhVmq4X7i/yQoEdv4J/c2xyFGnecn5Swygn9oa5?=
 =?us-ascii?Q?QTKh3Rf/R6WtrlS7MR0EkJJKPj6AAlWxGqBz4h/XyYTE1fWcGD3qeGGo/y5/?=
 =?us-ascii?Q?91b2lDniraid/BQab5rQ9YX8k8JhA2JrnVfNfuk6GceCSRVNMsOe2HxQ5sKy?=
 =?us-ascii?Q?8SKroBlHubYf3C2gfqAzdNCw1hkHTQh0FwZQ5rUA?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: SJ0PR11MB6744.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 4b454920-0944-4a8e-033e-08dc89c5dc03
X-MS-Exchange-CrossTenant-originalarrivaltime: 11 Jun 2024 03:23:27.2407 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: OrFhE/+gsMMTkJE/2mg0vRJ9283DXx76WjgZsJwJOacyDa8EgrSG1wJmD7Nh5JtUGeetugq7ympE4AEqdXpzTfNxp4MSf3YU7OiHEX1mSYc=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BL1PR11MB5238
X-OriginatorOrg: intel.com
Received-SPF: pass client-ip=192.198.163.18;
 envelope-from=zhenzhong.duan@intel.com; helo=mgamail.intel.com
X-Spam_score_int: -45
X-Spam_score: -4.6
X-Spam_bar: ----
X-Spam_report: (-4.6 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.143,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_MED=-2.3, SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
 T_SCC_BODY_TEXT_LINE=-0.01 autolearn=ham autolearn_force=no
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
>From: Eric Auger <eric.auger@redhat.com>
>Subject: [RFC v2 6/7] hw/vfio: Remove
>memory_region_iommu_set_iova_ranges() call
>
>As we have just removed the only implementation of
>iommu_set_iova_ranges IOMMU MR callback in the virtio-iommu,
>let's remove the call to the memory wrapper. Usable IOVA ranges
>are now conveyed through the PCIIOMMUOps in VFIO-PCI.
>
>Signed-off-by: Eric Auger <eric.auger@redhat.com>

Reviewed-by: Zhenzhong Duan <zhenzhong.duan@intel.com>=20

Thanks
Zhenzhong

>---
> hw/vfio/common.c | 10 ----------
> 1 file changed, 10 deletions(-)
>
>diff --git a/hw/vfio/common.c b/hw/vfio/common.c
>index f20a7b5bba..9e4c0cc95f 100644
>--- a/hw/vfio/common.c
>+++ b/hw/vfio/common.c
>@@ -630,16 +630,6 @@ static void
>vfio_listener_region_add(MemoryListener *listener,
>             goto fail;
>         }
>
>-        if (bcontainer->iova_ranges) {
>-            ret =3D memory_region_iommu_set_iova_ranges(giommu-
>>iommu_mr,
>-                                                      bcontainer->iova_ra=
nges,
>-                                                      &err);
>-            if (ret) {
>-                g_free(giommu);
>-                goto fail;
>-            }
>-        }
>-
>         ret =3D memory_region_register_iommu_notifier(section->mr,
>&giommu->n,
>                                                     &err);
>         if (ret) {
>--
>2.41.0


