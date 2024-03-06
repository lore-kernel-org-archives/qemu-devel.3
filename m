Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id F41BDC5475B
	for <qemu-devel@archiver.kernel.org>; Wed,  6 Mar 2024 03:27:04 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rhhvH-00044w-Sh; Tue, 05 Mar 2024 22:26:27 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <zhenzhong.duan@intel.com>)
 id 1rhhvE-00044j-0w; Tue, 05 Mar 2024 22:26:24 -0500
Received: from mgamail.intel.com ([198.175.65.20])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <zhenzhong.duan@intel.com>)
 id 1rhhvA-0005HK-NM; Tue, 05 Mar 2024 22:26:23 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1709695581; x=1741231581;
 h=from:to:cc:subject:date:message-id:references:
 in-reply-to:content-transfer-encoding:mime-version;
 bh=uTxz5h+vrMOgrxQynDeIPUl6awg7UzCni0FhjBVFMDs=;
 b=HrEVTm3w1Mrnnxf8/rZMWKIcuyLaGSEzI7WJ3ueFLKngbBzaLr3ier/Q
 3O2ASXDtEM0kHgXIeOM8W/26cxjFFEfiTv6x1NPsm1wH+ACe0atVl3evp
 MHR1PSV0EKB+XNuZ1YfjwC1PZIL+RMiILYJnqRbjATd4WA8GIlhEMWsz8
 JRPHgQAE/ibdeo3u0BU4QqlPoB53abKU7GXQQcyZQe5mOA783Ruho5Hiv
 CtLxHA6dS+0aDVv3yJi9t8qBAqb7AQfa76xlpduOi7CtToLEuJ+szmPvP
 mU8FmrOOPAGfDd1afFayffDIw8oUkFxqgJv8KPc1UjvzgchwhvC7NqD/G Q==;
X-IronPort-AV: E=McAfee;i="6600,9927,11004"; a="4172700"
X-IronPort-AV: E=Sophos;i="6.06,207,1705392000"; 
   d="scan'208";a="4172700"
Received: from fmviesa003.fm.intel.com ([10.60.135.143])
 by orvoesa112.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 05 Mar 2024 19:25:15 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.06,207,1705392000"; d="scan'208";a="14169606"
Received: from fmsmsx603.amr.corp.intel.com ([10.18.126.83])
 by fmviesa003.fm.intel.com with ESMTP/TLS/AES256-GCM-SHA384;
 05 Mar 2024 19:25:11 -0800
Received: from fmsmsx610.amr.corp.intel.com (10.18.126.90) by
 fmsmsx603.amr.corp.intel.com (10.18.126.83) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35; Tue, 5 Mar 2024 19:25:10 -0800
Received: from fmsmsx610.amr.corp.intel.com (10.18.126.90) by
 fmsmsx610.amr.corp.intel.com (10.18.126.90) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35; Tue, 5 Mar 2024 19:25:09 -0800
Received: from fmsedg602.ED.cps.intel.com (10.1.192.136) by
 fmsmsx610.amr.corp.intel.com (10.18.126.90) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35 via Frontend Transport; Tue, 5 Mar 2024 19:25:09 -0800
Received: from NAM04-MW2-obe.outbound.protection.outlook.com (104.47.73.169)
 by edgegateway.intel.com (192.55.55.71) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.35; Tue, 5 Mar 2024 19:25:07 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=UFz48G/bmX0wM4KVk9LJi5ZtoARKhvZqh4d2eOX0k+QtgBgCH1aiLJo+le+EdKkHsOFDksJlbRzLMVZhkcAu6cb7xvD13CrUOoPX3JJ3y3Ry4w6kapNMi+OfvznRFmwSAf3poy87JNwvD/OYs7lnMAUzr2fn18lFLn+KxnrHIvyloOSwozStyefBH8zX4BqIub7rcgrR23kDMyqeCxW0HyfbgV9tCfuhOlkaRXkZ6SiNV9sxsFk+OsyoEGRSTSC6W2OT2XW41NS4g5hql4hjq9YqQPygwWhVSsyVaAC16agIZPS86JBOvwjK2NipnMMazBxZENVovSGUTBV7O7x5nA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=qUL5YT/mSvQ7QjFpAu6w4mfuq4SIe/hC4UiBpIFcuOo=;
 b=VhXWIX2FNomdrlPH4dOHcVS+MNtYYZBHZHudI5p5zmlT9BWSfdwvOmEtZ/cspKuksMPFVrthi0IWOARfUpaWgJgeixc90F0BTpIWhdq7H3dRg9W/7NOCQvrZGijUUG9qc0qknMwFyZ6jcgYiq6MO0YB+kUue+3v5jI6ZLBXjHuMWm9xSNKkN0c9aGSjrXV48/5n/+En+vsnX2BmDTl5vus6MlhGAYk7TcnWokHKVgLvCYP4yQmdwl7cEpS/fNQ/coP8RUjAnTPkTOWjrFYMRZCAk7CwVId4c/lcD38i8a0neKD9sm1PVUGdyaMX7ZgSZ67XGOanO9nO6Pb2zu27B7A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Received: from SJ0PR11MB6744.namprd11.prod.outlook.com (2603:10b6:a03:47d::10)
 by IA1PR11MB7725.namprd11.prod.outlook.com (2603:10b6:208:3fd::13)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7362.24; Wed, 6 Mar
 2024 03:25:05 +0000
Received: from SJ0PR11MB6744.namprd11.prod.outlook.com
 ([fe80::c0f3:15d4:d7f6:a72a]) by SJ0PR11MB6744.namprd11.prod.outlook.com
 ([fe80::c0f3:15d4:d7f6:a72a%4]) with mapi id 15.20.7362.019; Wed, 6 Mar 2024
 03:25:05 +0000
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
Subject: RE: [PATCH v6 8/9] hw/arm/virt: Set virtio-iommu aw-bits default
 value to 48
Thread-Topic: [PATCH v6 8/9] hw/arm/virt: Set virtio-iommu aw-bits default
 value to 48
Thread-Index: AQHabygk5E2/3wpKVEOSHjFvlm1f7rEqDTVw
Date: Wed, 6 Mar 2024 03:25:05 +0000
Message-ID: <SJ0PR11MB674472228A664E543C15CD7092212@SJ0PR11MB6744.namprd11.prod.outlook.com>
References: <20240305180734.48515-1-eric.auger@redhat.com>
 <20240305180734.48515-9-eric.auger@redhat.com>
In-Reply-To: <20240305180734.48515-9-eric.auger@redhat.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: SJ0PR11MB6744:EE_|IA1PR11MB7725:EE_
x-ms-office365-filtering-correlation-id: 25e248c1-85c8-4897-f647-08dc3d8d048b
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: 5lG/e7ETTHEVhw8A90PgfnsYx+H3qNWnR4EbxiQF1aDsNEPuimnzvrPfloFagxcxD2N7Ixo3aLwfF5YcX7FuBUa4VMhCDwQMKpUSZNA+WRPbhrM5QFS21qe3EhzTp2S8Fgv15tqdIK9kQ6+X2kp2flEub4uTkJSPvOZvkxByS+JOlVWDrKXo6cxqtyHuuMcvk1YOPCv0+hMU6E5ciM53X3QVtglpCjLwJC0IgYQ6x48deOb9ePXeN5HxQU4sEGQvqoIEaUKrm3emcRl5vP91EuK1AxvkRUcdHH168xPDM5fhFCNFX7jgFCBZSl4k3ikccvqJMIdT8i9e3cBq1cC8w7ji/tzwEbtnGB6xxhwgDG4+8X+it/gM4kgElrI1Z4tTPcj6wgpnv2Df4F+L/7HFNQx5epuTLlGhA0U1zHsYf2mR0Dupd7tLgb5biyrbSwN3ZiMHwdTqbdvYHfdHcZmXYyzDN2891NtiVBqswFTuOMzUUdebPsaG2HDt9hdZa04j0kR2vkIPaUMUw6qANIg0feGKNUophDm9d0d3fDhhuUDbOTU98LoimnWbm6zKHWHiXrguW22vEx63yTt96icMTDvVX+rkN3+5ntngpSarhiTPtm6x6gJ4rQ9rMjwp66t+yqwZnp/vDfmTCgM++g4ZDuI3FQA9j02poPlhr4eCioDisFg4nS7Nouoalc4UsHrjZDmgNc9KhGXIazlxVAvGKN9al0TAkZypMLGdETnWJg8=
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:SJ0PR11MB6744.namprd11.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230031)(376005)(921011)(38070700009); DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?D31p3/k33I6UyDHzzS+mavLjnnV1OWe0/GEa3qT5hxzhjNgiX3Umv+bESosV?=
 =?us-ascii?Q?Mcf306A2zTLpzgTMjtZDjcV5l/WEtGwooPjDGC3VwxvMzKqoTyOABJlVVVdE?=
 =?us-ascii?Q?OdHXGkyHBX4NMwEmw/e5RFl/HWXea8eXuNZRwwUBwfMnQs+HEFHHxyQfISS5?=
 =?us-ascii?Q?YR1HhAeQpksPUiwzJwfnIcp2S3II1n9DmopSTWuUyY4OCCUufyplLyRKdFAM?=
 =?us-ascii?Q?+Ni97KlCOzGNsDm0ylKC2qG9fQSUkDUggvNRNqcjPLOJL2zy8VvgCI5NWVsJ?=
 =?us-ascii?Q?nEuJSzm49OauBK41QX9p2m+SnJYWS6WJlYNgj0avzCAGxHuSz/rs5Of9diNA?=
 =?us-ascii?Q?7+vfxdG3ZMdx4OyvpIzoKdAbJ4sJcyG41E4/Jf+u4GVA5sGES80uhDd9D6dW?=
 =?us-ascii?Q?oAVvucGM/qKfii03/eO8BdHzBTMudCk/QDiymQbnX4gzdynceO5FEJeLp2+K?=
 =?us-ascii?Q?fTrUN5rC6FrOJu4hfFYeI4QQboBRKgfhIOEwNr9236HOtjqYuN5tEpem/MkL?=
 =?us-ascii?Q?S5Vj1sVgfEugkQ109IO2MYgn1nZQ06l1y2WG0tB8zBgDh4q1r6iXWKBLgXrA?=
 =?us-ascii?Q?nFyakJ4SDcLewuwmk4OlHOnIQ/VxYSQio3GcDKE+eQmx0ZFJi+5qTyrIy5nG?=
 =?us-ascii?Q?d7tlHI96CDsPM8vPhht2UriI0qHSrqHJgikMXTLDnaTjDNCyF3R+Z5pLWyJD?=
 =?us-ascii?Q?SBE/K/VKG++p1Uhm3ZhWvkXEpeXmDua68JPyeu92dwjf6Mx4119ebhZHcm7s?=
 =?us-ascii?Q?OtrSHbXcy31jhbNhUatE8zVbIKOFn1VdJWzcBSm4+Vg+Tx5rLhOwbnxZtdxW?=
 =?us-ascii?Q?AGRxuOY3YGQxe6FnoPjL2a030/NpgHJDKoJurMf+q8BEIHScu8lHw6pwAOjZ?=
 =?us-ascii?Q?3pBUBt1Bod+8jBelOJn0N8iXHGmUE7xUFz7Xs7zIa5Kl8xv55b/Qqc7CmLge?=
 =?us-ascii?Q?uHfenlsaNfyKOMaHY48Y4o9xaOYYc6hR3Ko9oHLIBfbLW1ghTLuM5M0NPrwU?=
 =?us-ascii?Q?Zoh6YJV+r3cxrg6lfehiXE2HKdNCI/9LORSeW9iR844jgJDTCySthsZGB8wg?=
 =?us-ascii?Q?0gTYlupOLsQG8qkE6ktnyEdsjU/Y/iwjKmfRkfHeYx1v1zoSjWpP0HJcm0Xw?=
 =?us-ascii?Q?aPxxfwYgxxGlTcG9xq7zdw6IH5i2UfduYXdyLH/7tm4IW+KAxGil+tonKgja?=
 =?us-ascii?Q?YR0/KkZ3A4F/QSfxyvRqdX6EbaujEMQBFvc6LWNZ3DgLiehbuAnCJSxHQ2tw?=
 =?us-ascii?Q?TfPgsGT6ilkOg+oSWeFX9F7IoBiTzIPfWotqV9p0cmXKhoBaeXn2vKBbq7yC?=
 =?us-ascii?Q?yY1vTuxhF9+ifljCOLNJJDCLfF5bj8NjWv5YKFqx57VEFnTAbx92q3nzzCA2?=
 =?us-ascii?Q?SAsaWMIvAAvsIFjItyGQIumpz32onLCrMK/E4oNjO9lJSRU6UDCf+1qz9JjD?=
 =?us-ascii?Q?sfznnOpkD26BhlUlEnS4GB8XDP9YY6ouHCRLUUVXVHb+km40TDG8IbFDlt52?=
 =?us-ascii?Q?xK2bOXQWJpjIqalfKbKmflDCdQAPRAKxxiZGQF0uzOaekL2ciYV5or0rtvzt?=
 =?us-ascii?Q?EIiSIpOWatPmMK+KebqcHyOa13xymLuqv2RpFp0W?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: SJ0PR11MB6744.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 25e248c1-85c8-4897-f647-08dc3d8d048b
X-MS-Exchange-CrossTenant-originalarrivaltime: 06 Mar 2024 03:25:05.5507 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: tGNIzylLeFux4lqq6AhyWv10QJ5+dr0QsqOWm/TYFaU4MsBpRBYX/qZoapVHQF4a2bodEGeEe8Z4HB0qApXZXBpXOGibO/Dbk3pOQzuN0e0=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA1PR11MB7725
X-OriginatorOrg: intel.com
Received-SPF: pass client-ip=198.175.65.20;
 envelope-from=zhenzhong.duan@intel.com; helo=mgamail.intel.com
X-Spam_score_int: -26
X-Spam_score: -2.7
X-Spam_bar: --
X-Spam_report: (-2.7 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.568,
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
>Subject: [PATCH v6 8/9] hw/arm/virt: Set virtio-iommu aw-bits default valu=
e
>to 48
>
>On ARM we set 48b as a default (matching SMMUv3 SMMU_IDR5.VAX =3D=3D 0).
>
>hw_compat_8_2 is used to handle the compatibility for machine types
>before 9.0 (default was 64 bits).
>
>Signed-off-by: Eric Auger <eric.auger@redhat.com>
>---
> hw/arm/virt.c | 17 +++++++++++++++++
> 1 file changed, 17 insertions(+)
>
>diff --git a/hw/arm/virt.c b/hw/arm/virt.c
>index 0af1943697..dcfb25369b 100644
>--- a/hw/arm/virt.c
>+++ b/hw/arm/virt.c
>@@ -85,11 +85,28 @@
> #include "hw/char/pl011.h"
> #include "qemu/guest-random.h"
>
>+GlobalProperty arm_virt_compat[] =3D {
>+    { TYPE_VIRTIO_IOMMU_PCI, "aw-bits", "48" },
>+};
>+const size_t arm_virt_compat_len =3D G_N_ELEMENTS(arm_virt_compat);

This can be static, otherwise,

Reviewed-by: Zhenzhong Duan <Zhenzhong.duan@intel.com>

Thanks
Zhenzhong

>+
>+/*
>+ * This cannot be called from the virt_machine_class_init() because
>+ * TYPE_VIRT_MACHINE is abstract and mc->compat_props
>g_ptr_array_new()
>+ * only is called on virt non abstract class init.
>+ */
>+static void arm_virt_compat_set(MachineClass *mc)
>+{
>+    compat_props_add(mc->compat_props, arm_virt_compat,
>+                     arm_virt_compat_len);
>+}
>+
> #define DEFINE_VIRT_MACHINE_LATEST(major, minor, latest) \
>     static void virt_##major##_##minor##_class_init(ObjectClass *oc, \
>                                                     void *data) \
>     { \
>         MachineClass *mc =3D MACHINE_CLASS(oc); \
>+        arm_virt_compat_set(mc); \
>         virt_machine_##major##_##minor##_options(mc); \
>         mc->desc =3D "QEMU " # major "." # minor " ARM Virtual Machine"; =
\
>         if (latest) { \
>--
>2.41.0


