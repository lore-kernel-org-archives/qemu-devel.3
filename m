Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 711E1C54E4A
	for <qemu-devel@archiver.kernel.org>; Tue, 27 Feb 2024 03:49:27 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1reoSa-0007KU-7v; Mon, 26 Feb 2024 22:48:52 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <zhenzhong.duan@intel.com>)
 id 1reoSY-0007KF-6d; Mon, 26 Feb 2024 22:48:50 -0500
Received: from mgamail.intel.com ([198.175.65.15])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <zhenzhong.duan@intel.com>)
 id 1reoSV-0000JS-Bt; Mon, 26 Feb 2024 22:48:49 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1709005727; x=1740541727;
 h=from:to:cc:subject:date:message-id:references:
 in-reply-to:content-transfer-encoding:mime-version;
 bh=0E6rYdldv0ll8eCSOMJwJ2f9cpMx98KvgocU9cDTUr8=;
 b=bAMKCTGAN5WXw0fwwlhk8hnczES1sErxtqsZ4gT/et5RwpvnvxOHhwEC
 +MwqG8p6GagjcCQWqt6cd8Ii1GnyVsYvaWwVY+6JPOW+HIXGTki7kZy8p
 UVrkR/dgvGA6lmSI9Exze2xZ/5ZVuyG6kEBh9lrD9TVWkTVeMoMKDI7E8
 yFLnDSjHfGEdGUdwxHvqgbrkEStWjpUnvOpg7Gngr7ni+hykt/ysE+zvL
 261Inuar7SNaIxLqg8XuHpqFmU411XezioDsBDjsCZT/RtKCPUxp1Hpib
 g2r2jXLMC00rag8xKoBBRhUgjY9btC0k1Ng13qc7WK7somOrZqlUWHZ+h w==;
X-IronPort-AV: E=McAfee;i="6600,9927,10996"; a="7155753"
X-IronPort-AV: E=Sophos;i="6.06,187,1705392000"; 
   d="scan'208";a="7155753"
Received: from orviesa007.jf.intel.com ([10.64.159.147])
 by orvoesa107.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 26 Feb 2024 19:48:44 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.06,187,1705392000"; 
   d="scan'208";a="7251373"
Received: from orsmsx602.amr.corp.intel.com ([10.22.229.15])
 by orviesa007.jf.intel.com with ESMTP/TLS/AES256-GCM-SHA384;
 26 Feb 2024 19:48:44 -0800
Received: from orsmsx612.amr.corp.intel.com (10.22.229.25) by
 ORSMSX602.amr.corp.intel.com (10.22.229.15) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35; Mon, 26 Feb 2024 19:48:43 -0800
Received: from orsedg603.ED.cps.intel.com (10.7.248.4) by
 orsmsx612.amr.corp.intel.com (10.22.229.25) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35 via Frontend Transport; Mon, 26 Feb 2024 19:48:43 -0800
Received: from NAM11-DM6-obe.outbound.protection.outlook.com (104.47.57.168)
 by edgegateway.intel.com (134.134.137.100) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.35; Mon, 26 Feb 2024 19:48:43 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=ivyp+T8uUpHzE1USbCKIELRGn+vVs3K6tOpSbYI9Yvete7gLSezJOnD5MNoJxSx3Ubjlp+S8dPRPhXWWa1fZQfa4KdKstZumzQpcUkp6kABVpRWgHm8HtzhtqT7std/SZKFsasGfuK0MK/DozgHiNztvc39ru+WugSxI49UhZoTv02WL7vjcQBT3plMpb+dKRrPxKhsQQRvjbmuWrTzJM5PINka6SkYPx8UirbpelssI1WT9dHXtDKKT2ck7I51n3nntKYG0tIKeXOLzWYR54R7pVZgb+aKqbnqSXpL0lAF1KYlGrSA+eb3P54vJbdzV2cq7Vciz0eS2X8m7hNpV/w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=YaIJ5W0MsddMgUSLZ/snFM5B4BnsMf4hbxp+aESHHoU=;
 b=m9a9QZA+nlxrxwPEEC/O6IUhBJHSMotT4l3cOuAGw9oKljUtxDk0sXVhpNwR/Rv4Jw9i7oabBQLTmWcwnRLttZ9lWCuMnhhBVnUwkytNXgDEuQXirZY45eYI6c9fp5JpP97AGY+4/rYOcKw5dTT12hqJaNyts61x0wafq1JC8UtryrfwdkesGSlPCelrwCdb6yUEaRRH1jHG6EsLH36SrRtvqVkB2azgVoK4emJOTEHSJC1Cx9YhS3oYzgxo42KZenBjLPu9W3kOQencrtTQ04TRdKvDBywXwhZXowbACTDBlPyoE+PIgpF2PRGXd6ORE/rxFaU0dmp6YZD3Pt1BQw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Received: from SJ0PR11MB6744.namprd11.prod.outlook.com (2603:10b6:a03:47d::10)
 by SJ0PR11MB5087.namprd11.prod.outlook.com (2603:10b6:a03:2ad::22)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7339.24; Tue, 27 Feb
 2024 03:48:40 +0000
Received: from SJ0PR11MB6744.namprd11.prod.outlook.com
 ([fe80::c0f3:15d4:d7f6:a72a]) by SJ0PR11MB6744.namprd11.prod.outlook.com
 ([fe80::c0f3:15d4:d7f6:a72a%4]) with mapi id 15.20.7339.009; Tue, 27 Feb 2024
 03:48:40 +0000
From: "Duan, Zhenzhong" <zhenzhong.duan@intel.com>
To: Eric Auger <eric.auger@redhat.com>, "eric.auger.pro@gmail.com"
 <eric.auger.pro@gmail.com>, "qemu-devel@nongnu.org" <qemu-devel@nongnu.org>,
 "qemu-arm@nongnu.org" <qemu-arm@nongnu.org>, "mst@redhat.com"
 <mst@redhat.com>, "jean-philippe@linaro.org" <jean-philippe@linaro.org>,
 "peter.maydell@linaro.org" <peter.maydell@linaro.org>, "clg@redhat.com"
 <clg@redhat.com>, "yanghliu@redhat.com" <yanghliu@redhat.com>
CC: "alex.williamson@redhat.com" <alex.williamson@redhat.com>,
 "jasowang@redhat.com" <jasowang@redhat.com>, "pbonzini@redhat.com"
 <pbonzini@redhat.com>, "berrange@redhat.com" <berrange@redhat.com>
Subject: RE: [PATCH v5 2/3] virtio-iommu: Add a granule property
Thread-Topic: [PATCH v5 2/3] virtio-iommu: Add a granule property
Thread-Index: AQHaaN+i2XRdxKkYaEWBAabKFLLHpbEdjdLA
Date: Tue, 27 Feb 2024 03:48:40 +0000
Message-ID: <SJ0PR11MB6744600A58269DCDA7FFB0E492592@SJ0PR11MB6744.namprd11.prod.outlook.com>
References: <20240226181337.24148-1-eric.auger@redhat.com>
 <20240226181337.24148-3-eric.auger@redhat.com>
In-Reply-To: <20240226181337.24148-3-eric.auger@redhat.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: SJ0PR11MB6744:EE_|SJ0PR11MB5087:EE_
x-ms-office365-filtering-correlation-id: 51b3107e-f8d2-4d11-5b36-08dc3746fcc7
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: 9nzAZZhIIcUBmhVsOJ/9jEhHTyKW54XzDypYGPrGRDgEtCxMVd+4P0WR7xBLxsoOq0YiRSF/Io9MRqIrZgqH7KvqP24ZJSIM0unPF8QHufdLRiQClXj4GwNmIY8szAwLdb7BUFRUvUftTOs8rU6e3CjGO0ASODFN37IMv2HcNoIxlcvkw4ZpNra86oEkUv9pftB0rbe0OU5ZOARXIC6Mj8oMrrT/Uqy9EBgQcFRuyPZxeW0WMnB6Mtjyb5C+HCZ1y1SZnduy2pq3vNpgmev3oBYoBn3A9jjQvs8kPM3zIHkPb00r9x1ElsaCbiPZaovIw/ktFcEX4sw8jMAu9Fbb6zDqZ0dJd2Ktcd8S7AxvoMTAOjir0CgouU7pwEGw4sBflgKswU1l/SjT+6rR8X70HN6CJ/1hI9BxpdiSrvrQN7PR17oHFTAfvLikDcIowCDodLE/Ccr1ntV0R2BMS+A8yZv5kt88mVsAeqXpO0A4gprQTcmKLhsSTjp4cgyGLw363HsRk5cPXoU1OJGCtaaovCdUmKzbDoJsfFXQ/T4eTl3NZJpPmPtitCBUG/Htrn6sIDDZqVQTVoj6vRTFrPirr71Q1Xc1EnhalbzUlVf9AVP0Hp1xoB6U4i2wgV9Q6TLDgS8ud3dZDcfMBtcXBrjnUfFrhZybid8Iy4uTs2F0JihvLnncHitJaCNlg7RuUHxzXYtaoD0r5v21/TqD8wG0eZ17HczqKGatrXFstytz76Q=
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:SJ0PR11MB6744.namprd11.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230031)(38070700009); DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?3g+vXLgeHTATLO4Zn8oDMW4U6AqXkqptP2Zi6hBkCXjRRzaP/NxMfRwd9jxp?=
 =?us-ascii?Q?gtO6zaMuS+yDIfjAGMxy3vXhL8vgSWp+MJlyFx7d7YdrJOJd8B3fLuAy+QHe?=
 =?us-ascii?Q?drD7iPqHz40PFNlU7qFNouW08hCALMJLv94i+MN93VgK1AA/u+IDmgU5wEjL?=
 =?us-ascii?Q?ZE8KhTruyBGCwPjdQD/qReUcHlblm5cxHjES27y/g7Ha8OWsb7Jc+Di2b0tS?=
 =?us-ascii?Q?3gX6iyQ798IAvsaeVvVHy8FuvSCG9q+IH3vYxvh4QhLm4AKV2ijLTFeivLQg?=
 =?us-ascii?Q?D16tBANjnRIw5e4sb2VjwMcLueM1mHUuoqu49ezESsxXLxSf6Zrha8KOOk0r?=
 =?us-ascii?Q?qV6/YqwzEuBUPtqW07NiEoYMTUWVhwXqZkCp6sCLq9f2Wtl+rMI1szeSou1u?=
 =?us-ascii?Q?1glHWYDaT4APG6EvDGOFwu/XuDZXn46SEXH2VzDZprb9/9JoBAKOPJvN+Vl2?=
 =?us-ascii?Q?ADJaGAim/vwaRdYm4KdMBzfKJJNWVgasmXa7pj7rHP3ve9cxcvepup1N4J2W?=
 =?us-ascii?Q?4w0Ei7nI5eL69zSSs/H4sZQXbE4j3FOdamVAEBTJ52WGuZcJC8hhN2Cv0hRr?=
 =?us-ascii?Q?sam0WzyhdxqdxSZKBG7UDJjM395DOwIaVTA0rWGzQQohRtnd7BsSYO866CAG?=
 =?us-ascii?Q?4oKMs0V+vsnoQdoMwOr63UPR9w9M4IjapMwtQV+4KXGlrhxR4uIKGlMRipOm?=
 =?us-ascii?Q?7VBWI/q8a8SW5qv0DMbS28BC7Jmi6MbOz1rZwayFCO7N2zCI1rhYH/cU+0Z6?=
 =?us-ascii?Q?J7xwsbTZLkjZSDx6CQAJKWuZQu7emAe9Cy6cnz+L0nU4dIflNjQiU5hrX/G9?=
 =?us-ascii?Q?RSiOTyZYoTMt0Vp+OvHcWXo/dQScAbT3+/690x4m+4GbWFJnRw+FI1jzYcOg?=
 =?us-ascii?Q?9PQDYLjS0zKJ5nPsH62Y6fe+xkcEs3afWhjQN7Dzq2CrEk7DtWMYOdw3CspT?=
 =?us-ascii?Q?EI7OmJhXJ9frDLExKNJRNjlzU+JgZinjzD2x482nUwRuaXpoQKIUphRVu40Q?=
 =?us-ascii?Q?rIwoOqbvUP2CWwh8x6NSqNcyogGel0+so+8NfemhlLGM0o+fSe2UBgv2XOkV?=
 =?us-ascii?Q?luHeLsThQwb8IXPIjyPhKFkBafkF4FzP5/eK9sIqrEkKLruu7dQdqctwJOWe?=
 =?us-ascii?Q?DG5qxZqc4j5FIJh8+p0F90Vc2lcczIA81Z/Y51pjsZkPk5zpHygNmQREH74G?=
 =?us-ascii?Q?qlnXHWOrhkDcOWUdSxJwfFPsd16FGATQXv4vy5SYF5wTpibD4ks64ksQi4x0?=
 =?us-ascii?Q?peQGXJ+UFwCmJwO+nRenBVFIDhRVhjWjbmXKSNkQU/fmozff0mMwcp51tCZQ?=
 =?us-ascii?Q?6jC/UkP3R8V3NordPSHHjG6KnKcZgnA187zfNidlg/o6BHs+BSKGSR5xfVep?=
 =?us-ascii?Q?iRjCrUv9o5Tk3RttjP8gfF22KQamTukrkW5FRBp42ZGR+6S/jeGwORoGlNMa?=
 =?us-ascii?Q?tWVrsR4wrs510EI42DwlMTYte9sQJjWxvtZ6basaQUc7U/VBVNZMULSlIlwN?=
 =?us-ascii?Q?GXC/QAFR3+MgSz8SMfgIY3JXJ3lOW/dFn2M9xXh0073BYpKtqlxCXk4fDV12?=
 =?us-ascii?Q?9iO+hwJoz6UTdcaIhUcIbHFnweIwxq1wKWNnXRBd?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: SJ0PR11MB6744.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 51b3107e-f8d2-4d11-5b36-08dc3746fcc7
X-MS-Exchange-CrossTenant-originalarrivaltime: 27 Feb 2024 03:48:40.7432 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: DbKCHZiixrYYlnAMqcsVPvk/bf+jNOg7VY4ifw8NM3n+BGPWtS4+LGVNZ9koQDKmQXILa5UloF5dW3EvIkLH0nMoTRRrXl46WrnhEoQhBTc=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ0PR11MB5087
X-OriginatorOrg: intel.com
Received-SPF: pass client-ip=198.175.65.15;
 envelope-from=zhenzhong.duan@intel.com; helo=mgamail.intel.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.014,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
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
>Subject: [PATCH v5 2/3] virtio-iommu: Add a granule property
>
>This allows to choose which granule will be used by
>default by the virtio-iommu. Current page size mask
>default is qemu_target_page_mask so this translates
>into a 4K granule.
>
>Signed-off-by: Eric Auger <eric.auger@redhat.com>

Reviewed-by: Zhenzhong Duan <zhenzhong.duan@intel.com>

Thanks
Zhenzhong

>
>---
>v4 -> v5:
>- use -(n * KiB) (Phild)
>
>v3 -> v4:
>- granule_mode introduction moved to that patch
>---
> include/hw/virtio/virtio-iommu.h |  2 ++
> hw/virtio/virtio-iommu.c         | 28 +++++++++++++++++++++++++---
> qemu-options.hx                  |  3 +++
> 3 files changed, 30 insertions(+), 3 deletions(-)
>
>diff --git a/include/hw/virtio/virtio-iommu.h b/include/hw/virtio/virtio-
>iommu.h
>index 5fbe4677c2..f2785f7997 100644
>--- a/include/hw/virtio/virtio-iommu.h
>+++ b/include/hw/virtio/virtio-iommu.h
>@@ -24,6 +24,7 @@
> #include "hw/virtio/virtio.h"
> #include "hw/pci/pci.h"
> #include "qom/object.h"
>+#include "qapi/qapi-types-virtio.h"
>
> #define TYPE_VIRTIO_IOMMU "virtio-iommu-device"
> #define TYPE_VIRTIO_IOMMU_PCI "virtio-iommu-pci"
>@@ -67,6 +68,7 @@ struct VirtIOIOMMU {
>     Notifier machine_done;
>     bool granule_frozen;
>     uint8_t aw_bits;
>+    GranuleMode granule_mode;
> };
>
> #endif
>diff --git a/hw/virtio/virtio-iommu.c b/hw/virtio/virtio-iommu.c
>index 2ec5ef3cd1..33e0520bc8 100644
>--- a/hw/virtio/virtio-iommu.c
>+++ b/hw/virtio/virtio-iommu.c
>@@ -29,6 +29,7 @@
> #include "sysemu/reset.h"
> #include "sysemu/sysemu.h"
> #include "qemu/reserved-region.h"
>+#include "qemu/units.h"
> #include "qapi/error.h"
> #include "qemu/error-report.h"
> #include "trace.h"
>@@ -1115,8 +1116,8 @@ static int
>virtio_iommu_notify_flag_changed(IOMMUMemoryRegion *iommu_mr,
> }
>
> /*
>- * The default mask (TARGET_PAGE_MASK) is the smallest supported guest
>granule,
>- * for example 0xfffffffffffff000. When an assigned device has page size
>+ * The default mask depends on the "granule" property. For example, with
>+ * 4K granule, it is -(4 * KiB). When an assigned device has page size
>  * restrictions due to the hardware IOMMU configuration, apply this
>restriction
>  * to the mask.
>  */
>@@ -1313,7 +1314,26 @@ static void
>virtio_iommu_device_realize(DeviceState *dev, Error **errp)
>      * in vfio realize
>      */
>     s->config.bypass =3D s->boot_bypass;
>-    s->config.page_size_mask =3D qemu_target_page_mask();
>+
>+    switch (s->granule_mode) {
>+    case GRANULE_MODE_4K:
>+        s->config.page_size_mask =3D -(4 * KiB);
>+        break;
>+    case GRANULE_MODE_8K:
>+        s->config.page_size_mask =3D -(8 * KiB);
>+        break;
>+    case GRANULE_MODE_16K:
>+        s->config.page_size_mask =3D -(16 * KiB);
>+        break;
>+    case GRANULE_MODE_64K:
>+        s->config.page_size_mask =3D -(64 * KiB);
>+        break;
>+    case GRANULE_MODE_HOST:
>+        s->config.page_size_mask =3D qemu_real_host_page_mask();
>+        break;
>+    default:
>+        error_setg(errp, "Unsupported granule mode");
>+    }
>     if (s->aw_bits < 32 || s->aw_bits > 64) {
>         error_setg(errp, "aw-bits must be within [32,64]");
>     }
>@@ -1527,6 +1547,8 @@ static Property virtio_iommu_properties[] =3D {
>                      TYPE_PCI_BUS, PCIBus *),
>     DEFINE_PROP_BOOL("boot-bypass", VirtIOIOMMU, boot_bypass, true),
>     DEFINE_PROP_UINT8("aw-bits", VirtIOIOMMU, aw_bits, 0),
>+    DEFINE_PROP_GRANULE_MODE("granule", VirtIOIOMMU, granule_mode,
>+                             GRANULE_MODE_4K),
>     DEFINE_PROP_END_OF_LIST(),
> };
>
>diff --git a/qemu-options.hx b/qemu-options.hx
>index 3b670758b0..c7b43b67d5 100644
>--- a/qemu-options.hx
>+++ b/qemu-options.hx
>@@ -1179,6 +1179,9 @@ SRST
>     ``aw-bits=3Dval`` (val between 32 and 64, default depends on machine)
>         This decides the address width of IOVA address space. It defaults
>         to 39 bits on q35 machines and 48 bits on ARM virt machines.
>+    ``granule=3Dval`` (possible values are 4K, 8K, 16K, 64K and host)
>+        This decides the default granule to be be exposed by the
>+        virtio-iommu. If host, the granule matches the host page size.
>
> ERST
>
>--
>2.41.0


