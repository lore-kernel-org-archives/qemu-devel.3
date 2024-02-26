Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 063C9C48BF6
	for <qemu-devel@archiver.kernel.org>; Mon, 26 Feb 2024 07:30:16 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1reVQT-0008Rc-Ed; Mon, 26 Feb 2024 02:29:25 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <zhenzhong.duan@intel.com>)
 id 1reVQR-0008RL-UZ
 for qemu-devel@nongnu.org; Mon, 26 Feb 2024 02:29:23 -0500
Received: from mgamail.intel.com ([198.175.65.12])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <zhenzhong.duan@intel.com>)
 id 1reVQP-0002eI-97
 for qemu-devel@nongnu.org; Mon, 26 Feb 2024 02:29:23 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1708932562; x=1740468562;
 h=from:to:cc:subject:date:message-id:references:
 in-reply-to:content-transfer-encoding:mime-version;
 bh=1I380j3q722C7AMneptKbTLFOFJ+l8vbD0k+qXQDNwY=;
 b=DIXpj0gg9arq+SX5lAMDnzIfQDevC2eIuzlJcx78mSoWRD/rv9sOmNlv
 FapVUBhYUetssYSIXQdmMrUL0SgaFoCxHak+v9iZVCTlkCgabSPDa5NIK
 VkuBf/LGS3YDB8wh/q3HkgaQOgc4wYRBeehhpILcuLagH3NX+IMxop+0Z
 F/ivfmo68ot/GrjpLkN+7SA/sAU/vCVwZAdXl/M4LDEuWbLF+RQBVNuBx
 S05N8+AxKN3++shJIZLZdpoXsoZyd6SGFM3DAKrys/6XylwCEloz3UEPn
 gFKfaVou7RYySVZsrcZotJxy3InC8nCmbLff9jRVI613/RjoGd4raFqpJ w==;
X-IronPort-AV: E=McAfee;i="6600,9927,10995"; a="14634650"
X-IronPort-AV: E=Sophos;i="6.06,185,1705392000"; d="scan'208";a="14634650"
Received: from orviesa010.jf.intel.com ([10.64.159.150])
 by orvoesa104.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 25 Feb 2024 23:29:19 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.06,185,1705392000"; 
   d="scan'208";a="6574437"
Received: from fmsmsx603.amr.corp.intel.com ([10.18.126.83])
 by orviesa010.jf.intel.com with ESMTP/TLS/AES256-GCM-SHA384;
 25 Feb 2024 23:29:18 -0800
Received: from fmsmsx611.amr.corp.intel.com (10.18.126.91) by
 fmsmsx603.amr.corp.intel.com (10.18.126.83) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35; Sun, 25 Feb 2024 23:29:17 -0800
Received: from fmsedg601.ED.cps.intel.com (10.1.192.135) by
 fmsmsx611.amr.corp.intel.com (10.18.126.91) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35 via Frontend Transport; Sun, 25 Feb 2024 23:29:17 -0800
Received: from NAM12-DM6-obe.outbound.protection.outlook.com (104.47.59.168)
 by edgegateway.intel.com (192.55.55.70) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.35; Sun, 25 Feb 2024 23:29:16 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=RwKXx2SBj+GUKehmVoa+kjfugOlAv5qPJjAptZaFQJoy86tdd9XISR/Tu+FocGaB/HuA2aXnfrTnElzBrUdcE9AV6QiahYU+FfORsx4fnJfappqGQjc4ZfrsS8qa0RPph3jqnSv84K2fYr3kYXUgH5EpYkEQmyuWqjFdXWaHDXxpfEZUTn5CYdUors+xjp1eIkMxxh+/sOWKKY3Wkpf4VoVbp73yc9a7Woo7t2N7moHHpP2nLYbqd2LfEwwVVBs4ZFNBgbCSnrg3g/ePoRZHxUybElHklSg8zNOqiA992XVRdAbrwF5RKtvdygEO/iR/JelpGDMQLRKcayD3OOTSvQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=TePfv0KawJkwgLBv8xPtaC+WOc3VqrJ2LK42ce9z1sM=;
 b=L/fsYINpzcl4cvJIL6LngrkHvIeh5ckAFccBUqFMPKe0IoHDjVqsn1jVuEUl6bJsz+CdFxSr3pJmkOIKoMlR8VgqCq6o8GrETI7me2K0J9GFt1vTtDRNiyIbSAIRhp5jPU3/HvXfU/bgGByi7Z8rIGJfP52D0zKbFRS3WSaALMieTT2IZ6wmo9SwC8Vrnvk9WxYdrGSH/jCF9DEQYg30DaLdeFPO0diug9faVSErgCaLNLttHkgqnvzrQxUUcO2yPDqFWxC1jdvzaHDE/g4tE5njH+qJo6A0q5yUJuud2TfHWVoCrnGKWAZGtjzP27r6pXte+WwBkcoYiMC+xSbenA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Received: from SJ0PR11MB6744.namprd11.prod.outlook.com (2603:10b6:a03:47d::10)
 by BN9PR11MB5546.namprd11.prod.outlook.com (2603:10b6:408:103::10)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7339.13; Mon, 26 Feb
 2024 07:29:15 +0000
Received: from SJ0PR11MB6744.namprd11.prod.outlook.com
 ([fe80::c0f3:15d4:d7f6:a72a]) by SJ0PR11MB6744.namprd11.prod.outlook.com
 ([fe80::c0f3:15d4:d7f6:a72a%4]) with mapi id 15.20.7339.009; Mon, 26 Feb 2024
 07:29:15 +0000
From: "Duan, Zhenzhong" <zhenzhong.duan@intel.com>
To: Joao Martins <joao.m.martins@oracle.com>, "qemu-devel@nongnu.org"
 <qemu-devel@nongnu.org>
CC: "Liu, Yi L" <yi.l.liu@intel.com>, Eric Auger <eric.auger@redhat.com>, Alex
 Williamson <alex.williamson@redhat.com>, Cedric Le Goater <clg@redhat.com>,
 Paolo Bonzini <pbonzini@redhat.com>, "Daniel P . Berrange"
 <berrange@redhat.com>, Eduardo Habkost <eduardo@habkost.net>, Eric Blake
 <eblake@redhat.com>, Markus Armbruster <armbru@redhat.com>, Jason Gunthorpe
 <jgg@nvidia.com>, Avihai Horon <avihaih@nvidia.com>
Subject: RE: [PATCH RFCv2 1/8] backends/iommufd: Introduce helper function
 iommufd_device_get_hw_capabilities()
Thread-Topic: [PATCH RFCv2 1/8] backends/iommufd: Introduce helper function
 iommufd_device_get_hw_capabilities()
Thread-Index: AQHaXbtgjLVWomWoWkW3kUi8UpCu07EcTbbw
Date: Mon, 26 Feb 2024 07:29:14 +0000
Message-ID: <SJ0PR11MB6744CF6315A3BD4906C115F8925A2@SJ0PR11MB6744.namprd11.prod.outlook.com>
References: <20240212135643.5858-1-joao.m.martins@oracle.com>
 <20240212135643.5858-2-joao.m.martins@oracle.com>
In-Reply-To: <20240212135643.5858-2-joao.m.martins@oracle.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: SJ0PR11MB6744:EE_|BN9PR11MB5546:EE_
x-ms-office365-filtering-correlation-id: 0ce595c4-a4c6-4c79-c96c-08dc369ca28e
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: BXSYcmcSLJ+BUf5VN3gXZKf6MJMbz/AGu5jvZwqbkbzaaoHA6Y2599HVV2VEiyvHekm6CxY3v6oZ/efT4mE/ZyV6Vwe+u+Q5zQjyfNdo4EaIFAti7RaFxmSFGohcWjFU4eLCKTT6j7i6AX/AzKxfq5qm+9p0B/NOG70IR2meApUn3l0iHFEkFFxuZ3OxbTt09aeN8A5CmiqjrtDj4MLCUc5X7y4Cii6eRnUQLyPHjTh0S0V2aZnuUxaUC5h/Mv76qRwqhByX5bMxVhOYqo7iARioTXRJfPYyEU7jfcYzIKVcSIZOPrvcl8kXLI0h6t8yg6tcL8KKpVxGzdrx50+9YeOOPuadUNy8uIYu1rfRt4OStjEp4iW9Kds1legnLO7jxVY1I3u0MSt+FWRme1xb8Lu0q0seHX3cmqVOdc3RvGWqe4yAy+rwBvk6NMk9mYDuD9v/esu9nsz0r2ReDDL9hoS5/c7OxFIsboGEE1WdLogLXjeQyADCjv8MElnVey1W8dQUGJ4sYwtCzOK1cwi9grYzfPuBTgWj40rAC9l0yjuIHFXR/vw7urMGTAoqc+Vz/VaXZgp5Ky2fTkVCJ3ZcsjqrsRRLkv37kiuUEQXYWAjUuGcbBy/01Jb2W8NT3TIdHnp6LiBY93edbdNoMoffIQjm3GA+jnLUlTFXDHYKmGDr3uvjJFfmlRr4/u4PLApZm9k0L6HaMfYRT50/uvB3ag==
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:SJ0PR11MB6744.namprd11.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230031)(38070700009); DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?vbNLs0HkV8EjAfJworgoCV6x+LspxDsMenFJ+oPv5vRMHgxXBltjI60uiPTY?=
 =?us-ascii?Q?0oJbmsAtcRWTCVnNJGaJhmb8aL8PP5z9jdLThkMwpWT3lP56mo4Af+ab/qUA?=
 =?us-ascii?Q?jIsg7ULQ+YGajhHEWUbL7l0SQzYO+yuhVxUCktTWQg9nUArHrh3OGmg8NYYb?=
 =?us-ascii?Q?P0f37gaC0QT3nDV9qvU0lAmfyU9L7ybhZZekswcFPu8ZE6Y42j7Q8UN/eK0n?=
 =?us-ascii?Q?shmjyoB0tDi84oGXSEHQSj4uwvIqEYzB1xOdRWcfeHiYnIcRffoFahOyQ70X?=
 =?us-ascii?Q?qD9vxxtu5lF1YnWKk7oQjrTX4+yRWsMVbszG++UpiDq4z48l0oz3lcRyvjZu?=
 =?us-ascii?Q?tBBlnAXqrAi4vInvNw7u2ntGcWRDcF07iGjTtxlbpqdrVLWL/qBOXWeWA7oF?=
 =?us-ascii?Q?i/1m0CMtxk2R8gk3Bm0y0uR6b+gCEnehudRn+AD6dAa5piJzEM0owOqx7S8D?=
 =?us-ascii?Q?Elbd//3PbcKvifrjdGlbAiofOsY7hI4NWXWuCA+XhhmYecnoxlwfEe0IfXsw?=
 =?us-ascii?Q?VNSLtEd4W24sGQzuH7rVyKV8PFW/Z0t7uugndqJhFhP9M+y9bk9HOp9CSrPi?=
 =?us-ascii?Q?HJ+2dg98sCmLNECCAOh7depvovJgsfT3uCyh6KSB4j5PzwRHeAUywqVHnzkK?=
 =?us-ascii?Q?Cmk5VPT+nRSpzoxy/nEuvb+IRw/tXl89HlCFVv9sWMYus/HtVBgFHrYDMQxP?=
 =?us-ascii?Q?V2B8wy/tzOR/LJjzNu9ykQjBqCkNmaqiJAwD/Dd8b/MUsUcsxKUp0+sggDm2?=
 =?us-ascii?Q?KGuOW1XwHJMvJv+ncfZUsLiGTMn/E5z2C+ItkJr2N9+sQHmiBgxn2CS65+tC?=
 =?us-ascii?Q?IHwiVYvc0A9vGkxjoRrnqC83BP17tgaVaiZDuzWLUyqyH4VTZBJm6UbZjxOy?=
 =?us-ascii?Q?ETw0UOuIRyaWZHbZW3yg+BcD9RZA9/1oL2lFUlwOsxkFGXtGk0auysIuP5O/?=
 =?us-ascii?Q?z8NBylRZC8r/9hRqfliECAyGB363oVyAKVrDhF4Bm21oqknhAaxyoTrCg7qK?=
 =?us-ascii?Q?XzTqzMXJP8wFpNXR5Iyf37nYTzHhC/LHAR07YEBcuNYN37W4XQaJu7YWCURW?=
 =?us-ascii?Q?R7+isYvFizra2+HyAhqFJMv1ChLSr9SZUpd9d2W3asM3d9erYdaAfzjeB0pb?=
 =?us-ascii?Q?KiQGtncgLaP2AHqHe7rGSDVRFRBz0Who/JTKdxILRyUsvMQw48ryOMpp+3PC?=
 =?us-ascii?Q?zHA+5vuyraxsqRIw+4pjXnkwC5uhSXDpIa5eXbh3UpyMRtsZb+Ol3fAOOOiH?=
 =?us-ascii?Q?fnysYuuyyFq+DRozjfCQD7eOCHMPGt9i3qMwhpqL/WWGqFJu3IEme6ix2nHO?=
 =?us-ascii?Q?LvOQCjDwmZkZV0xQobg3LVGn1ueom276FV+XtWSkncZ6YcVklSMDUo0XBlHa?=
 =?us-ascii?Q?VzvZ8b8jjk9xL6OFPRiUwx+PC1PBQ8DYXKxqft/o+skipjgzc/3mvzW/w9/Y?=
 =?us-ascii?Q?rFrlvodMFKjRGWsdr3XzWGN5AMqnupy6pNlz4Eux4tzn+13oc1wjtHq6Cof/?=
 =?us-ascii?Q?5DHWP0vPF61iz94uxpMoFGL1cxP+aLhG5AmhQzT8Jpjuka59CPpB/NPz3w1I?=
 =?us-ascii?Q?Ur2jn5BXz/qevkC66JwLorz0tJtFLJSY+ay0S0sO?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: SJ0PR11MB6744.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 0ce595c4-a4c6-4c79-c96c-08dc369ca28e
X-MS-Exchange-CrossTenant-originalarrivaltime: 26 Feb 2024 07:29:14.9456 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: Ij6DwD10KlcbuP2/wBRfIWuAuaMS1GlyvjBBlE2LG3uWhERpvq1Cu7D1AAA/tKLzL0e6vP6Z8civJ3DRsK5d6lKILa6Q9ULN6yts3ZWtgQc=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BN9PR11MB5546
X-OriginatorOrg: intel.com
Received-SPF: pass client-ip=198.175.65.12;
 envelope-from=zhenzhong.duan@intel.com; helo=mgamail.intel.com
X-Spam_score_int: -21
X-Spam_score: -2.2
X-Spam_bar: --
X-Spam_report: (-2.2 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.097,
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

Hi Joao,

>-----Original Message-----
>From: Joao Martins <joao.m.martins@oracle.com>
>Subject: [PATCH RFCv2 1/8] backends/iommufd: Introduce helper function
>iommufd_device_get_hw_capabilities()
>
>The new helper will fetch vendor agnostic IOMMU capabilities supported
>both by hardware and software. Right now it is only iommu dirty
>tracking.
>
>Signed-off-by: Joao Martins <joao.m.martins@oracle.com>
>---
> backends/iommufd.c       | 25 +++++++++++++++++++++++++
> include/sysemu/iommufd.h |  2 ++
> 2 files changed, 27 insertions(+)
>
>diff --git a/backends/iommufd.c b/backends/iommufd.c
>index d92791bba935..8486894f1b3f 100644
>--- a/backends/iommufd.c
>+++ b/backends/iommufd.c
>@@ -237,3 +237,28 @@ void iommufd_device_init(IOMMUFDDevice *idev)
>     host_iommu_base_device_init(&idev->base, HID_IOMMUFD,
>                                 sizeof(IOMMUFDDevice));
> }
>+
>+int iommufd_device_get_hw_capabilities(IOMMUFDDevice *idev, uint64_t
>*caps,
>+                                       Error **errp)
>+{
>+    struct iommu_hw_info info =3D {
>+        .size =3D sizeof(info),
>+        .flags =3D 0,
>+        .dev_id =3D idev->devid,
>+        .data_len =3D 0,
>+        .__reserved =3D 0,
>+        .data_uptr =3D 0,
>+        .out_capabilities =3D 0,
>+    };
>+    int ret;
>+
>+    ret =3D ioctl(idev->iommufd->fd, IOMMU_GET_HW_INFO, &info);
>+    if (ret) {
>+        error_setg_errno(errp, errno,
>+                         "Failed to get hardware info capabilities");
>+    } else {
>+        *caps =3D info.out_capabilities;
>+    }
>+
>+    return ret;
>+}

This helper is redundant with https://lists.gnu.org/archive/html/qemu-devel=
/2024-02/msg00031.html
We have to get other elements in info in nesting series, so mind using that=
 helper
Instead to avoid redundancy? I can move that patch ahead for your usage.

Thanks
Zhenzhong

>diff --git a/include/sysemu/iommufd.h b/include/sysemu/iommufd.h
>index c3f346976039..4afe97307dbe 100644
>--- a/include/sysemu/iommufd.h
>+++ b/include/sysemu/iommufd.h
>@@ -47,4 +47,6 @@ typedef struct IOMMUFDDevice {
> } IOMMUFDDevice;
>
> void iommufd_device_init(IOMMUFDDevice *idev);
>+int iommufd_device_get_hw_capabilities(IOMMUFDDevice *idev, uint64_t
>*caps,
>+                                       Error **errp);
> #endif
>--
>2.39.3


