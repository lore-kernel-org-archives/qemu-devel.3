Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0F940C47258
	for <qemu-devel@archiver.kernel.org>; Fri,  2 Feb 2024 06:52:46 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rVnPD-0005n8-C4; Fri, 02 Feb 2024 01:52:07 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <zhenzhong.duan@intel.com>)
 id 1rVnPB-0005mn-Vr; Fri, 02 Feb 2024 01:52:06 -0500
Received: from mgamail.intel.com ([192.198.163.17])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <zhenzhong.duan@intel.com>)
 id 1rVnP7-00040c-1v; Fri, 02 Feb 2024 01:52:05 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1706856721; x=1738392721;
 h=from:to:cc:subject:date:message-id:references:
 in-reply-to:content-transfer-encoding:mime-version;
 bh=xhezeetRjvgY+sfcGaOw6AsP7yVpeM3PU+rnnVkm5P8=;
 b=IwaAR2tkGABWKOyu2IM2N/BSvdkEjJoyuU7zJdHpe7/EIl9hISLUHw6z
 1Nm1kF/Al5NxOyIRtoWcjMg/7uot2oOOI4bL0j2tt2QceevhEhKuOoA7j
 +YqKbqWDWiOa+NlbeglsRO/G7V2QVoPZnP1hIkDNEnY62hDYXsYuKeeyQ
 yRACe+Gs2SZB+MaNUEeqmqj0Xq1yZHXp0jSBSPcMOxAWWJIqria2MurXb
 673evOsrcKvDDqC5bW/Vl2d7J7F2Ql2nNiarBQTTe4wz6uByvtyLY176L
 93y0+HGCpVbNeFxZlG2lorGRlq1FOw6bsRFMumI+Hdv0Iado+PxdQrSTr w==;
X-IronPort-AV: E=McAfee;i="6600,9927,10971"; a="10309"
X-IronPort-AV: E=Sophos;i="6.05,237,1701158400"; 
   d="scan'208";a="10309"
Received: from orviesa005.jf.intel.com ([10.64.159.145])
 by fmvoesa111.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 01 Feb 2024 22:51:59 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.05,237,1701158400"; 
   d="scan'208";a="4587582"
Received: from orsmsx603.amr.corp.intel.com ([10.22.229.16])
 by orviesa005.jf.intel.com with ESMTP/TLS/AES256-GCM-SHA384;
 01 Feb 2024 22:51:59 -0800
Received: from orsmsx610.amr.corp.intel.com (10.22.229.23) by
 ORSMSX603.amr.corp.intel.com (10.22.229.16) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35; Thu, 1 Feb 2024 22:51:58 -0800
Received: from orsmsx610.amr.corp.intel.com (10.22.229.23) by
 ORSMSX610.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35; Thu, 1 Feb 2024 22:51:57 -0800
Received: from ORSEDG601.ED.cps.intel.com (10.7.248.6) by
 orsmsx610.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35 via Frontend Transport; Thu, 1 Feb 2024 22:51:57 -0800
Received: from NAM10-BN7-obe.outbound.protection.outlook.com (104.47.70.101)
 by edgegateway.intel.com (134.134.137.102) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.35; Thu, 1 Feb 2024 22:51:57 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=R2rnk8jebpk/8c85t0lHzsCPqgDHEQOLStSk91xjM89pfEjc+hQ4ul9qEJpX1Yh86z2ywcabgEk3vCdaDmvLjO0cQkChz8XoFh0W6yuOtVdRe6dbgaJUimkTKQO0SXZCeJj4CcJFHfjDzP4YkmnAmzdR+hhDOLgspOnI61z8RRvw4HtPg/GhQdbYDezrNudz3Pug5RpUFkt/1zrRqm2zgSOD0hCEuYBGo3wztp1UtKFbt/hjirslhzG56eHoO0qYXCzZqOKvseI7lmjYnEb0DGv1qptUfEwxdQgrkQOOCpigE7pXuzykBx9oC/4GtKz+d0neyd9EuMUMGGOr8+aWEw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=ORR0168QcM8aABhGOW2VEN4xm9ClP5GtjBpfGroEpGo=;
 b=kWXS+dbxG7UMhkGvEgRQgUdI23lIVOPJ1I+PWOHxiXNGXS0JVd5mfADTT7ry3TqrpPjet58d6uWDBbt7eYwC0qMx7xobqUGIxPAb5gjh/hxbHa2ezAvE04YTF3YQMlAmfwZL96Qpq0zb8drslh5wucjcG4KxPAOQv56+/eq89xeIIOyEory9B5IH9WXDiP6B+cwQ7nbN77G9pZMzgMkFws5bZSp1HTARmI4WTcXC0Qez0DUa/eXy9pAfSrMPfSD2jRgXuSCFT2kftuzIbI9jbhiILwJgzscJT3JvKiztgjYlw6UCKYHiTjYugdgEkkhxzFh+rOzwzeVO35cPNsUYgw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Received: from SJ0PR11MB6744.namprd11.prod.outlook.com (2603:10b6:a03:47d::10)
 by SN7PR11MB7044.namprd11.prod.outlook.com (2603:10b6:806:29b::5)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7249.29; Fri, 2 Feb
 2024 06:51:55 +0000
Received: from SJ0PR11MB6744.namprd11.prod.outlook.com
 ([fe80::d7ca:7979:6536:7ac3]) by SJ0PR11MB6744.namprd11.prod.outlook.com
 ([fe80::d7ca:7979:6536:7ac3%5]) with mapi id 15.20.7228.029; Fri, 2 Feb 2024
 06:51:55 +0000
From: "Duan, Zhenzhong" <zhenzhong.duan@intel.com>
To: Eric Auger <eric.auger@redhat.com>, "eric.auger.pro@gmail.com"
 <eric.auger.pro@gmail.com>, "qemu-devel@nongnu.org" <qemu-devel@nongnu.org>,
 "qemu-arm@nongnu.org" <qemu-arm@nongnu.org>, "jean-philippe@linaro.org"
 <jean-philippe@linaro.org>, "alex.williamson@redhat.com"
 <alex.williamson@redhat.com>, "peter.maydell@linaro.org"
 <peter.maydell@linaro.org>, "yanghliu@redhat.com" <yanghliu@redhat.com>
CC: "mst@redhat.com" <mst@redhat.com>, "clg@redhat.com" <clg@redhat.com>,
 "jasowang@redhat.com" <jasowang@redhat.com>
Subject: RE: [PATCH v2 3/3] hw: Set virtio-iommu aw-bits default value on
 pc_q35_9.0 and arm virt
Thread-Topic: [PATCH v2 3/3] hw: Set virtio-iommu aw-bits default value on
 pc_q35_9.0 and arm virt
Thread-Index: AQHaVSx0/jaTLU9t70OK/XVUd/iC9bD2nIQg
Date: Fri, 2 Feb 2024 06:51:55 +0000
Message-ID: <SJ0PR11MB67443F341958AD061E9A144D92422@SJ0PR11MB6744.namprd11.prod.outlook.com>
References: <20240201163324.564525-1-eric.auger@redhat.com>
 <20240201163324.564525-4-eric.auger@redhat.com>
In-Reply-To: <20240201163324.564525-4-eric.auger@redhat.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: SJ0PR11MB6744:EE_|SN7PR11MB7044:EE_
x-ms-office365-filtering-correlation-id: 67386105-b93f-4a1a-615c-08dc23bb7197
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: 0nHa8P8PHnKFYPEC0sN279GCEim0VrL8PdHaYHRTFvbr/7oowLSMLWxANBEcp1MwTKxADZmBFctgljGBrri6kN2OZecL68YldV9q2Naw4Fd6IC3frQuEn/3IuHdpTp94f3hj79/k9LOkghybYro9LhjLCBJq/tz3IzoLcEXx0QJvtBf32Sp9mPeFZzJyb6P1YXAgo0iHfOPzs9+hOqY6JFHbuSxjjPZ8mA/H27u5hJsABF9nxaOA/jncPtXsDcNtpnJ+nImFhbx5jSb2jW1FCCTZOxDXCiWmr4ltMPHyY5iPgT+Ob6mslJWgNBCtm39j3K6ENvlXVzQOOrLRjRUsygEOgRgD3qrRt/+XbEQX8FpzFMxgfZfoIHV/DUvx8eShBNFIa/2RMxCKCfErkil+LtKrD6YKZSR+fAkXMgxEhQ5OWUINay4N35UyNMO3FTDatm15qhTDhxnmtnr0Wj/Wq9WMMCMmyTbfbO10TMFbtWLNollSiwc4jscyIOjfp9DlhwIvSwRdWmaNIWKSltfSodGHH9M1f6RDTaAXE797lZIbVtVRsZt3TO8KdLxCS6EYO0exuMMb7Z+juoKUp9atdZTSLDCV6egXR6IyqoppSSZp4O3JBCO0HaF4GmybJs9B
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:SJ0PR11MB6744.namprd11.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230031)(136003)(39860400002)(346002)(396003)(376002)(366004)(230922051799003)(1800799012)(451199024)(186009)(64100799003)(83380400001)(41300700001)(9686003)(26005)(38100700002)(122000001)(52536014)(8676002)(4326008)(5660300002)(8936002)(7416002)(2906002)(478600001)(316002)(76116006)(54906003)(71200400001)(64756008)(66446008)(66476007)(66556008)(6506007)(7696005)(66946007)(110136005)(38070700009)(86362001)(33656002)(82960400001)(55016003);
 DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?7WLDhQhKBrkm7LbmOQzTCtMpXWHFI/TiG94mZZ48Z2QjnPR8qdJqsh93WWFI?=
 =?us-ascii?Q?LdZB+bgWSZN162sqlmBeVRTgAyA3fRNjQ/vaPT+itT9BWxFR6F7P3fBjR5an?=
 =?us-ascii?Q?spI61HS7hTpoxuNE8LBNtAm/1FzfllaI1xaJY31lyWyMFw+IbpcrL2daLoHP?=
 =?us-ascii?Q?ZlAoIjbm7/Y3Hj3xs9Cldm3kdnRhKUVBeCIoEB3j1iiDpc3sFAGenI6MA3Nf?=
 =?us-ascii?Q?rV302LQtySTcu15rfDho8d8UlwaYObbtbr8djeva+9ydKwtxjDwS8GzulITI?=
 =?us-ascii?Q?0rK+Cf8dwprzKAPhUgjv8kdRfypyrU+y5XxGXMBNghEvd8GS24jhPNPq7Kfi?=
 =?us-ascii?Q?bJaf0rvfoFRwrTp7woB63NELJn0kuP9upF+LiEic28DNZw351R1CKE8i7aZ4?=
 =?us-ascii?Q?7u0275JhO5Ky1LSIqvxqYr/pW99Rn77oJaijPbhiC3+rbzbySGjcxiOSNZQs?=
 =?us-ascii?Q?wHJjL2V0vuDjOx9F4gKt0SX6q2qrt6HlkdzYc5uTL6Gv6c5Ikr8mIGOfOaWJ?=
 =?us-ascii?Q?oAkKsjwkKBZca9SMQL7gkXSa3UoAyavqYU29nz2OzsWHckfK/0qytEbwF6bq?=
 =?us-ascii?Q?fd3FIQUR1PKnhE78vygWXlq0bKMO/cMqe9d2FX9TjVwBsT/jvfMxE3vK84/U?=
 =?us-ascii?Q?WnVISkk3KPTLiAqQYIucwrY3QyPwLAUPoYPMfKktXMA7uMItExw/5j8+eHCS?=
 =?us-ascii?Q?rht4fpSyKEwGyCjkJ8IYq1J7QWUH6EBCsxWYyggD6tVIaeZ8ofBnykGJXEk1?=
 =?us-ascii?Q?L6osYaetfmbbVOVpVXixmk5n9Xf+jRomrp0T4LVa18X1G7gc4pzcaQy2+LqB?=
 =?us-ascii?Q?8QV9TBMFgaoext29DMy2qWC/ghzgqFJRpw0coHARXNPSSXex2YELUxNB5A9E?=
 =?us-ascii?Q?gmtQ0eQk9NLVCSDFddX/mEvPH1eC3SzJtCv7hWbbzJC9Wv3rFyKsS44bhbUc?=
 =?us-ascii?Q?gdCevJ5pai98j6EBrf/0BZ+2twB5lyC256xyZ5f/1xxhvlVpJnk1C+mwBIsg?=
 =?us-ascii?Q?P1Q0w//v6HcQtFZBHR0wDW5fEDHT6B2WLJ5bh1RSfMVURRuhUNXp0nulROAe?=
 =?us-ascii?Q?4k/beSKFP/eQhj8WgitPMa/rYURcWrBoXPiT09QWTuGSo4EwSGAHVAtn+wsc?=
 =?us-ascii?Q?7tYiiQ1a5LqNohRFSwdYkbQzJ84Z4L7U7nvQG+XnRpl1hxVuW5oCNzvNEBc8?=
 =?us-ascii?Q?EY7Ik7hc3HHRhmCEVc1h46wNvCMT8PhUeXZ5N7wwCJOZQ+6LjEpwGcp51MA4?=
 =?us-ascii?Q?jA6fhyNE43cqxN24DEUkzF5iglTCey6tH4ZmTnlTVIbwwLUkGMs4GC4HCZvs?=
 =?us-ascii?Q?iRI8uZn15ou6zrs1wmPTZkQJJ70WJXffaR5/p3a0seoWwfl+voz1BYTwCRVr?=
 =?us-ascii?Q?CbR03GUx9q91/iyCSzelbL7iwQ3TRDxDCb+Oa7TguebfdU0mLBrX5ukaR9hr?=
 =?us-ascii?Q?3kbWHroVcJ2jN+yz+PQtG67W6XwwNg9i3JkwRwAi7wS+4L4ogLrQ5de9vH5d?=
 =?us-ascii?Q?StGT/n3BRWz4NAPImWVOYnKwzVIDenSR5dLs9bg/nQENEfh1i+/Uiw1eLNKD?=
 =?us-ascii?Q?3/FPdFISM2pnbe+3IrIEXErXCbTXE1a7HHzmBBkk?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: SJ0PR11MB6744.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 67386105-b93f-4a1a-615c-08dc23bb7197
X-MS-Exchange-CrossTenant-originalarrivaltime: 02 Feb 2024 06:51:55.0953 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: UFz8DmwxQSJHvs3IpiHYmJjlai02iXDLq+6IvxQzSsBeQpOWexAMoqksfwPUD8pTM6TqQgZoVEScqM/DW/cImwpVivtkvfK7rkeX3pLbAAc=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SN7PR11MB7044
X-OriginatorOrg: intel.com
Received-SPF: pass client-ip=192.198.163.17;
 envelope-from=zhenzhong.duan@intel.com; helo=mgamail.intel.com
X-Spam_score_int: -16
X-Spam_score: -1.7
X-Spam_bar: -
X-Spam_report: (-1.7 / 5.0 requ) BAYES_00=-1.9, DKIM_INVALID=0.1,
 DKIM_SIGNED=0.1, SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
 T_SCC_BODY_TEXT_LINE=-0.01 autolearn=no autolearn_force=no
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

Hi Eric,

>-----Original Message-----
>From: Eric Auger <eric.auger@redhat.com>
>pc_q35_9.0 and arm virt
>
>Currently the default input range can extend to 64 bits. On x86,
>when the virtio-iommu protects vfio devices, the physical iommu
>may support only 39 bits. Let's set the default to 39, as done
>for the intel-iommu. On ARM we set 48b as a default (matching
>SMMUv3 SMMU_IDR5.VAX =3D=3D 0).
>
>We use hw_compat_8_2 to handle the compatibility for machines
>before 9.0 which used to have a virtio-iommu default input range
>of 64 bits.
>
>Of course if aw-bits is set from the command line, the default
>is overriden.
>
>Signed-off-by: Eric Auger <eric.auger@redhat.com>
>
>---
>
>v1 -> v2:
>- set aw-bits to 48b on ARM
>- use hw_compat_8_2 to handle the compat for older machines
>  which used 64b as a default
>---
> hw/arm/virt.c            | 6 ++++++
> hw/core/machine.c        | 5 ++++-
> hw/i386/pc.c             | 6 ++++++
> hw/virtio/virtio-iommu.c | 2 +-
> 4 files changed, 17 insertions(+), 2 deletions(-)
>
>diff --git a/hw/arm/virt.c b/hw/arm/virt.c
>index e6ead2c5c8..56539f2fc5 100644
>--- a/hw/arm/virt.c
>+++ b/hw/arm/virt.c
>@@ -2718,10 +2718,16 @@ static void
>virt_machine_device_pre_plug_cb(HotplugHandler *hotplug_dev,
>     } else if (object_dynamic_cast(OBJECT(dev), TYPE_VIRTIO_MD_PCI)) {
>         virtio_md_pci_pre_plug(VIRTIO_MD_PCI(dev), MACHINE(hotplug_dev),
>errp);
>     } else if (object_dynamic_cast(OBJECT(dev), TYPE_VIRTIO_IOMMU_PCI)) {
>+        uint8_t aw_bits =3D object_property_get_uint(OBJECT(dev),
>+                                                   "aw-bits", NULL);
>         hwaddr db_start =3D 0, db_end =3D 0;
>         QList *reserved_regions;
>         char *resv_prop_str;
>
>+        if (!aw_bits) {
>+            qdev_prop_set_uint8(dev, "aw-bits", 48);
>+        }
>+
>         if (vms->iommu !=3D VIRT_IOMMU_NONE) {
>             error_setg(errp, "virt machine does not support multiple IOMM=
Us");
>             return;
>diff --git a/hw/core/machine.c b/hw/core/machine.c
>index fb5afdcae4..70ac96954c 100644
>--- a/hw/core/machine.c
>+++ b/hw/core/machine.c
>@@ -30,9 +30,12 @@
> #include "exec/confidential-guest-support.h"
> #include "hw/virtio/virtio-pci.h"
> #include "hw/virtio/virtio-net.h"
>+#include "hw/virtio/virtio-iommu.h"
> #include "audio/audio.h"
>
>-GlobalProperty hw_compat_8_2[] =3D {};
>+GlobalProperty hw_compat_8_2[] =3D {
>+    { TYPE_VIRTIO_IOMMU_PCI, "aw-bits", "64" },
>+};
> const size_t hw_compat_8_2_len =3D G_N_ELEMENTS(hw_compat_8_2);
>
> GlobalProperty hw_compat_8_1[] =3D {
>diff --git a/hw/i386/pc.c b/hw/i386/pc.c
>index 803244e5cc..0e2bcb4840 100644
>--- a/hw/i386/pc.c
>+++ b/hw/i386/pc.c
>@@ -1458,6 +1458,8 @@ static void
>pc_machine_device_pre_plug_cb(HotplugHandler *hotplug_dev,
>     } else if (object_dynamic_cast(OBJECT(dev), TYPE_VIRTIO_MD_PCI)) {
>         virtio_md_pci_pre_plug(VIRTIO_MD_PCI(dev), MACHINE(hotplug_dev),
>errp);
>     } else if (object_dynamic_cast(OBJECT(dev), TYPE_VIRTIO_IOMMU_PCI)) {
>+        uint8_t aw_bits =3D object_property_get_uint(OBJECT(dev),
>+                                                   "aw-bits", NULL);
>         /* Declare the APIC range as the reserved MSI region */
>         char *resv_prop_str =3D g_strdup_printf("0xfee00000:0xfeefffff:%d=
",
>                                               VIRTIO_IOMMU_RESV_MEM_T_MSI=
);
>@@ -1466,6 +1468,10 @@ static void
>pc_machine_device_pre_plug_cb(HotplugHandler *hotplug_dev,
>         qlist_append_str(reserved_regions, resv_prop_str);
>         qdev_prop_set_array(dev, "reserved-regions", reserved_regions);
>
>+        if (!aw_bits) {
>+            qdev_prop_set_uint8(dev, "aw-bits", 39);
>+        }
>+
>         g_free(resv_prop_str);
>     }
>
>diff --git a/hw/virtio/virtio-iommu.c b/hw/virtio/virtio-iommu.c
>index 7870bdbeee..c468e9b13b 100644
>--- a/hw/virtio/virtio-iommu.c
>+++ b/hw/virtio/virtio-iommu.c
>@@ -1529,7 +1529,7 @@ static Property virtio_iommu_properties[] =3D {
>     DEFINE_PROP_LINK("primary-bus", VirtIOIOMMU, primary_bus,
>                      TYPE_PCI_BUS, PCIBus *),
>     DEFINE_PROP_BOOL("boot-bypass", VirtIOIOMMU, boot_bypass, true),
>-    DEFINE_PROP_UINT8("aw-bits", VirtIOIOMMU, aw_bits, 64),
>+    DEFINE_PROP_UINT8("aw-bits", VirtIOIOMMU, aw_bits, 0),

Not clear if virtio-iommu support other archs besides x86 and arm.
It looks on those archs, aw_bits is default 0 on machine 9.0 above
and will fails the check in realize?

Thanks
Zhenzhong

>     DEFINE_PROP_END_OF_LIST(),
> };
>
>--
>2.41.0


