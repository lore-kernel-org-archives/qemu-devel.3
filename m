Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 629CBC47258
	for <qemu-devel@archiver.kernel.org>; Fri,  2 Feb 2024 06:44:21 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rVnGl-0002o3-4d; Fri, 02 Feb 2024 01:43:23 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <zhenzhong.duan@intel.com>)
 id 1rVnGi-0002nq-Rh; Fri, 02 Feb 2024 01:43:21 -0500
Received: from mgamail.intel.com ([192.198.163.8])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <zhenzhong.duan@intel.com>)
 id 1rVnGg-0007vB-13; Fri, 02 Feb 2024 01:43:20 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1706856198; x=1738392198;
 h=from:to:cc:subject:date:message-id:references:
 in-reply-to:content-transfer-encoding:mime-version;
 bh=T6Tle9fsUwRYqzw/4MMYZw6t69zuTDX9zla+E95dA4g=;
 b=Wl7J1OH36FBUHBayDiwwHvfzHwNQTLLYv4iWD+9QB4kQDU9WEgkczNgz
 zaN0e8rOrXdcQqW1X2P+/Xii/Wonl62rcfkrBwVUCpUDdOXeiIQ5he695
 QLwcjf4nx/6DLWxqPhKh5nm4Nb39FvikMGtSxSpQ7ttJ8KI9XS3YWXWSA
 2OmJQRIednI24zH2PXp7VgLAuzIJy0PJrEX/zsZqcWHg3oivCbNTYE6Yc
 j4xqj/hqhMDlf+1Ak+MVQEfHovF4FI1VVLKefIN49HW800LSIA+uE+rwx
 9pp47N8dLFAG50y1R0G5Mz/LkMFHSZOal5UiHdq6QluyNrqqgFINT3l5a Q==;
X-IronPort-AV: E=McAfee;i="6600,9927,10971"; a="17626030"
X-IronPort-AV: E=Sophos;i="6.05,237,1701158400"; d="scan'208";a="17626030"
Received: from fmviesa004.fm.intel.com ([10.60.135.144])
 by fmvoesa102.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 01 Feb 2024 22:43:14 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.05,237,1701158400"; 
   d="scan'208";a="4620564"
Received: from fmsmsx602.amr.corp.intel.com ([10.18.126.82])
 by fmviesa004.fm.intel.com with ESMTP/TLS/AES256-GCM-SHA384;
 01 Feb 2024 22:43:14 -0800
Received: from fmsmsx610.amr.corp.intel.com (10.18.126.90) by
 fmsmsx602.amr.corp.intel.com (10.18.126.82) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35; Thu, 1 Feb 2024 22:43:14 -0800
Received: from fmsmsx610.amr.corp.intel.com (10.18.126.90) by
 fmsmsx610.amr.corp.intel.com (10.18.126.90) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35; Thu, 1 Feb 2024 22:43:13 -0800
Received: from fmsedg601.ED.cps.intel.com (10.1.192.135) by
 fmsmsx610.amr.corp.intel.com (10.18.126.90) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35 via Frontend Transport; Thu, 1 Feb 2024 22:43:13 -0800
Received: from NAM10-BN7-obe.outbound.protection.outlook.com (104.47.70.101)
 by edgegateway.intel.com (192.55.55.70) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.35; Thu, 1 Feb 2024 22:43:13 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=MGgI/Zm9SJggX/85TJGJmCG8oMG1M+EOzrW1kkuoF9+fiHfohQK/SW5YDDkLPTTuOJ7ENMR5zN3cXJZZIBmC/CixQ7HBQ9+OkwK0Cz36qWb+ynmmjFoXwuDymR3ZBIcTc9yWOPI3YTy1AZh64dUluS85VkD6aUpK7im3dpTiLgXuKQVz1BrFGDw9IaOV55/usnqxFiv/9TEquEVd4XVSqrOtfddJbJp3ktnLNdWbEQ7vW+a8NfxyH5RV9QS0I9ZyjDZg8/4LpKc8Im+HurvHbLsiI3waBspGwanDez/eWL2Tq9208jOm4F2P+cOdh9ybb1RbZ1aDRWTPamOssTei8A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=NLbArNK5PsFaCFvlkNaWbccvTI/z9UzTcNfwS4md01c=;
 b=klVnFjykA+9tqCq95LGTMWWA9hy3VVD1zAUDDBhgIzZ+H+gChFaKmoFmgcNA6lAfUMdr0S2Ay7iFMJRq75vs9/lbkqk6c3Ke1YdRNppPZfik644VRZFthFDhDAoh6BcToXbMYKQTcl2f+XhQFGcUvZCo0tGZ26QxryEpJepVLeQnyM0u8nb6mJGHpqjBXh4hFO4A8pFZ48ceE7tRYtN0DZyqdjb+TFdlo9JbFF3adX1h9iOS2PB89oODmb+dRB3nmDh6dZ8XUn/FiHj2Ud0PKvFNLUI+EcI0+nnR214RX7LhDuu6i9zTn1bujyAHP3V7SsbO2hGSaOQ3f/fWG13X5Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Received: from SJ0PR11MB6744.namprd11.prod.outlook.com (2603:10b6:a03:47d::10)
 by SN7PR11MB7044.namprd11.prod.outlook.com (2603:10b6:806:29b::5)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7249.29; Fri, 2 Feb
 2024 06:43:11 +0000
Received: from SJ0PR11MB6744.namprd11.prod.outlook.com
 ([fe80::d7ca:7979:6536:7ac3]) by SJ0PR11MB6744.namprd11.prod.outlook.com
 ([fe80::d7ca:7979:6536:7ac3%5]) with mapi id 15.20.7228.029; Fri, 2 Feb 2024
 06:43:11 +0000
From: "Duan, Zhenzhong" <zhenzhong.duan@intel.com>
To: Eric Auger <eric.auger@redhat.com>, "eric.auger.pro@gmail.com"
 <eric.auger.pro@gmail.com>, "qemu-devel@nongnu.org" <qemu-devel@nongnu.org>,
 "qemu-arm@nongnu.org" <qemu-arm@nongnu.org>, "jean-philippe@linaro.org"
 <jean-philippe@linaro.org>, "alex.williamson@redhat.com"
 <alex.williamson@redhat.com>, "peter.maydell@linaro.org"
 <peter.maydell@linaro.org>, "yanghliu@redhat.com" <yanghliu@redhat.com>
CC: "mst@redhat.com" <mst@redhat.com>, "clg@redhat.com" <clg@redhat.com>,
 "jasowang@redhat.com" <jasowang@redhat.com>
Subject: RE: [PATCH v2 1/3] virtio-iommu: Add an option to define the input
 range width
Thread-Topic: [PATCH v2 1/3] virtio-iommu: Add an option to define the input
 range width
Thread-Index: AQHaVSx0yUqNVvygo0KPZXA3zw9KwLD2m5iA
Date: Fri, 2 Feb 2024 06:43:11 +0000
Message-ID: <SJ0PR11MB6744E2DCD48321DD2F7BD4A392422@SJ0PR11MB6744.namprd11.prod.outlook.com>
References: <20240201163324.564525-1-eric.auger@redhat.com>
 <20240201163324.564525-2-eric.auger@redhat.com>
In-Reply-To: <20240201163324.564525-2-eric.auger@redhat.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: SJ0PR11MB6744:EE_|SN7PR11MB7044:EE_
x-ms-office365-filtering-correlation-id: b336e5e5-4108-42a1-22fd-08dc23ba3944
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: RKfa7BQ4tO2HO+tH+TFo17xZjaKj0eoAaiOtJ8qrd9BVgItexRsnIcwfCDMr2PRTFXkkBjWNvpjpxT2LFNlcGcmm8BtkNqzDOP6dq6MAh1vPnywD4+yWIbqj84on8vBpnBe0z9xusrCMj33VPYLDJtifksJisZmcOCRfambXBy7VRjJ+d5JFU3qWYKz0LKlMKcYA1s1j2Ah68IR1cOXqiMaNSlsdv+ZeVW1nyQmUNf+AnEyb7lutoDoQvaGK90waVVwDoRMbjuibp6PMHGqpuxOMRKWyGOrrBsFZNp58Yp62jxkCnSl3RtlMBxbcIzYoaVkILxuB8OgT+lJ8rFAqbVWiN+DYyvQoTTyBcopaYEbEZnqgBQYyC/i+ziQTb/KjBOASl9tkUchzCMUEDT2g3G18yqVFACRFrwnGhZ3VEL/E94qX4UL0gvW+n09XOgjUYsZgIApyCyMeWWs+G2KMNSkzgOEVMkf78mNXXR9TDu83p5j47Hl1BiiqNtWLYR+8wugU4J9o1Qc7VkmpoI8/a6xJopBmExW8+v0o9jYw6S/0tPVauZ4veQuLB1P44a7Ek8vydCa9gOMXeD/fmlDxzjkbHLiT3jhUsSdYu2ZH2Fnzh62IjK6IDMBmWQqsDMBM
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:SJ0PR11MB6744.namprd11.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230031)(366004)(376002)(396003)(346002)(39860400002)(136003)(230922051799003)(186009)(64100799003)(1800799012)(451199024)(55016003)(83380400001)(41300700001)(86362001)(82960400001)(33656002)(38070700009)(122000001)(26005)(38100700002)(9686003)(76116006)(478600001)(2906002)(316002)(110136005)(66946007)(7696005)(64756008)(71200400001)(54906003)(6506007)(66556008)(66476007)(66446008)(8676002)(52536014)(4326008)(8936002)(7416002)(5660300002);
 DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?0npJUXrSvugB4tp68hssqM195ygV7sQJ4nTsDXHyBQ2QBMHbgXy5G1mhkQfM?=
 =?us-ascii?Q?Sd8AFOQSwNH9dogkf/IPMCAHtCQzL9qqxeuUgmlb/RHHEYhqf8ImWjO/e9GO?=
 =?us-ascii?Q?BOLzHsDCxjXmzQTRMmHaaxkREi/o6o3xO1EXTSKDjipDJiXJRLTMKvND990A?=
 =?us-ascii?Q?/Cm5eRQLSQ6EKW4O5QyTyWoSEIfJyaih4zjwWsC44hy+9Lj1bhysNQYGYBfh?=
 =?us-ascii?Q?X3uv4OEdOYRV3AKBEB4o5aOHBZeA5uVfguqohDsWaF8h1e2TaTsVeAqWJDTo?=
 =?us-ascii?Q?EPDjXRJMN+6JO3d4uHiWNikxT/TVVw4H0qm6zdDOuqFz4VOoamb5X5FFSHa9?=
 =?us-ascii?Q?ma4zgaaLx5JRVRGv26Yo0vpjEGT8cmDvgV/FRPvjRsLgyPKm+pcL4CoP+r8Q?=
 =?us-ascii?Q?ZAz2VWLc4ayp5FHfesTFGqTgmQ/gM/u8NJqcv2prhHsHC8xDGsO9UYDRwTIp?=
 =?us-ascii?Q?30cUmUA93yfvNdhD6TXTeuV3xDti7SJjQCElyVnuQUv51vWKcPd1jHMPi0XS?=
 =?us-ascii?Q?euts8Ywn4epA5ZFoBfoSlChTi9TO9noaTQeGoyq5Ti4CaZzSys/aTPrb9wyv?=
 =?us-ascii?Q?PMqLeX28wbxueIZkbilZlU+wZx3eEREoTfQo0IyDx3S+nyZVsumQxTBUrKK0?=
 =?us-ascii?Q?9iztTMVlLtXYHZmk4iqAUIvTOJ9l4Q/W2+9861qnUA3FHb20OYRXPDJPcFhu?=
 =?us-ascii?Q?vCKXLUe+Gp9LJ4U0u0TgRhYFmQOgD2JoqlIV30qYx21GmkQI2UqUP5qWHgiw?=
 =?us-ascii?Q?zgfyLExCYwi8J9MvwmIQ9dYpkpHXBytHCOa7qQiTnfGEGoHdyhXK8sGQtq1z?=
 =?us-ascii?Q?gJ0TOiKtv7LRDo96qdBfFhz/HJaUh67k59aa3jxOH0OVEOtHlOJcVwE5zwo3?=
 =?us-ascii?Q?1biz+Xlm/mXhQTlNVbRAskZrILKLOunHU1bB2kjetw43sJ9UcY34AeNoouRB?=
 =?us-ascii?Q?HvpQpfqjJn0oY2xQTdq8eLyIbXzZPefINIAhemtp/eYck/Z52PQZNXj3l7k7?=
 =?us-ascii?Q?5+SxDUVjEipJhvJsXYlcggKm/XkpenzqHMdsJ+IDBL8HF0hPc8ne69eFKeHy?=
 =?us-ascii?Q?jlfba2IVoSNQ7MPq5UzNoOz4RrAWHZW34HsTSCkjYKoohsEhozR+dmsljW3R?=
 =?us-ascii?Q?4cZEaY7CRx9pfUNQE/pBfXArvoLPTaSLuDvtjumceD5rHBJ4wEojrQXAhN9F?=
 =?us-ascii?Q?wJbNg07GM2dgpfsR3XrqSzgPstVQbdbCr3OvjfujoPFUvyDk4ucUX90ZIfCg?=
 =?us-ascii?Q?YZ2HvKwVpYlkrnic2xXufxybABWfno+BP/ZSItMnhZFThOSLTh8XVGMT0TDi?=
 =?us-ascii?Q?/2237aY11i+Ot0rD8H9xkhSz+aA43dp5Ywt8S8tHSQ6GWIK8Dw5EXvaKnI/4?=
 =?us-ascii?Q?lAjXr7f2GMmIZvcp7o0NoVbR3zge7mSh2jJQMkwbeYyKH5v1HrdR2gRFoLOz?=
 =?us-ascii?Q?xPcLhGv2Jv+FTyQaDxe/rMdYz//lxRzdDtKbQ9E+u3hNeDJ77cnnIg31Dead?=
 =?us-ascii?Q?CEx6bbf8PWj46FpMztv/QRUQ/Or3y6RGQau6YaUYa36kvDxhzZfcLguBFu05?=
 =?us-ascii?Q?dXNU98fS7dj7zmY8wJRY0NxKKfCW7wb66BLFT+pv?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: SJ0PR11MB6744.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: b336e5e5-4108-42a1-22fd-08dc23ba3944
X-MS-Exchange-CrossTenant-originalarrivaltime: 02 Feb 2024 06:43:11.1232 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: oHPdTcn5qIwlU2LklYC9BLiA1MBjhODF549PW4iQh9SbORxYuIYCp3kJRGsrhRSowxjIdkTiEKMdwzcU1YPDymnThqrGAyPsN87OHh5HI8c=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SN7PR11MB7044
X-OriginatorOrg: intel.com
Received-SPF: pass client-ip=192.198.163.8;
 envelope-from=zhenzhong.duan@intel.com; helo=mgamail.intel.com
X-Spam_score_int: -33
X-Spam_score: -3.4
X-Spam_bar: ---
X-Spam_report: (-3.4 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-1.292,
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
>Subject: [PATCH v2 1/3] virtio-iommu: Add an option to define the input
>range width
>
>aw-bits is a new option that allows to set the bit width of
>the input address range. This value will be used as a default for
>the device config input_range.end. By default it is set to 64 bits
>which is the current value.
>
>Signed-off-by: Eric Auger <eric.auger@redhat.com>

Reviewed-by: Zhenzhong Duan <zhenzhong.duan@intel.com>

Thanks
Zhenzhong

>
>---
>
>v1 -> v2:
>- Check the aw-bits value is within [32,64]
>---
> include/hw/virtio/virtio-iommu.h | 1 +
> hw/virtio/virtio-iommu.c         | 7 ++++++-
> 2 files changed, 7 insertions(+), 1 deletion(-)
>
>diff --git a/include/hw/virtio/virtio-iommu.h b/include/hw/virtio/virtio-
>iommu.h
>index 781ebaea8f..5fbe4677c2 100644
>--- a/include/hw/virtio/virtio-iommu.h
>+++ b/include/hw/virtio/virtio-iommu.h
>@@ -66,6 +66,7 @@ struct VirtIOIOMMU {
>     bool boot_bypass;
>     Notifier machine_done;
>     bool granule_frozen;
>+    uint8_t aw_bits;
> };
>
> #endif
>diff --git a/hw/virtio/virtio-iommu.c b/hw/virtio/virtio-iommu.c
>index ec2ba11d1d..7870bdbeee 100644
>--- a/hw/virtio/virtio-iommu.c
>+++ b/hw/virtio/virtio-iommu.c
>@@ -1314,7 +1314,11 @@ static void
>virtio_iommu_device_realize(DeviceState *dev, Error **errp)
>      */
>     s->config.bypass =3D s->boot_bypass;
>     s->config.page_size_mask =3D qemu_real_host_page_mask();
>-    s->config.input_range.end =3D UINT64_MAX;
>+    if (s->aw_bits < 32 || s->aw_bits > 64) {
>+        error_setg(errp, "aw-bits must be within [32,64]");
>+    }
>+    s->config.input_range.end =3D
>+        s->aw_bits =3D=3D 64 ? UINT64_MAX : BIT_ULL(s->aw_bits) - 1;
>     s->config.domain_range.end =3D UINT32_MAX;
>     s->config.probe_size =3D VIOMMU_PROBE_SIZE;
>
>@@ -1525,6 +1529,7 @@ static Property virtio_iommu_properties[] =3D {
>     DEFINE_PROP_LINK("primary-bus", VirtIOIOMMU, primary_bus,
>                      TYPE_PCI_BUS, PCIBus *),
>     DEFINE_PROP_BOOL("boot-bypass", VirtIOIOMMU, boot_bypass, true),
>+    DEFINE_PROP_UINT8("aw-bits", VirtIOIOMMU, aw_bits, 64),
>     DEFINE_PROP_END_OF_LIST(),
> };
>
>--
>2.41.0


