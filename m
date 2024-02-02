Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 40133C4828E
	for <qemu-devel@archiver.kernel.org>; Fri,  2 Feb 2024 06:47:19 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rVnK6-0004Rp-3b; Fri, 02 Feb 2024 01:46:50 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <zhenzhong.duan@intel.com>)
 id 1rVnK1-0004QS-Tu; Fri, 02 Feb 2024 01:46:46 -0500
Received: from mgamail.intel.com ([192.55.52.115])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <zhenzhong.duan@intel.com>)
 id 1rVnJw-00012l-3d; Fri, 02 Feb 2024 01:46:45 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1706856400; x=1738392400;
 h=from:to:cc:subject:date:message-id:references:
 in-reply-to:content-transfer-encoding:mime-version;
 bh=lX4SOPKDi3ndUptnR7dxBqfndjJ5SbGEdF5Gd7LgMms=;
 b=WAN0j+29V1tF74nkg5BANVrUAgMAQeKM9ND1+CWdmplcQRcRlNG9TyeK
 rIetYHoKWZ6OobszUAfpLg+/nXbS4f1i7GTaZrQUSLjBnYyYf/GWBudDn
 YlxbiSAHWIYhKPJmfYRhBdbl2oksFmQHSfhyg7qbhuThJW6Fu8JLNMvzT
 M3trGfFkrVrapxca60nu/+FRpy5/j7o4bMpM7x3le+Ao5Hl0yIAVKNHRl
 1ljLOatxwofIbrUiD+O9C6cZBoc32qSg6MSrn0IWFib0qyGCBi2V0x8w3
 Xn+3atSgL0DQ+9a8mrAkKf/YQyVJXiQY9nOBztsXRce6roBeOtVzeYl/3 A==;
X-IronPort-AV: E=McAfee;i="6600,9927,10971"; a="403699455"
X-IronPort-AV: E=Sophos;i="6.05,237,1701158400"; d="scan'208";a="403699455"
Received: from fmsmga004.fm.intel.com ([10.253.24.48])
 by fmsmga103.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 01 Feb 2024 22:45:38 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10971"; a="859340669"
X-IronPort-AV: E=Sophos;i="6.05,237,1701158400"; d="scan'208";a="859340669"
Received: from orsmsx602.amr.corp.intel.com ([10.22.229.15])
 by fmsmga004.fm.intel.com with ESMTP/TLS/AES256-GCM-SHA384;
 01 Feb 2024 22:45:38 -0800
Received: from orsmsx603.amr.corp.intel.com (10.22.229.16) by
 ORSMSX602.amr.corp.intel.com (10.22.229.15) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35; Thu, 1 Feb 2024 22:45:37 -0800
Received: from ORSEDG601.ED.cps.intel.com (10.7.248.6) by
 orsmsx603.amr.corp.intel.com (10.22.229.16) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35 via Frontend Transport; Thu, 1 Feb 2024 22:45:37 -0800
Received: from NAM10-BN7-obe.outbound.protection.outlook.com (104.47.70.100)
 by edgegateway.intel.com (134.134.137.102) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.35; Thu, 1 Feb 2024 22:45:37 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=YZ91XL1U9W47V2sQagR2sQwfh84fciNSvxQlczk282F2iS9gsMfSqDW/R+8l3iLl2r/ifc4hTKs264H/FGEhZiFEczRj+YGBcKa9Lw8E6lLrGL1ZbLpxY3j1xUn+gUE5R6O79Q/p4KGtLcI35HJsbnEJErU1BbLhtoQaJBo/+WhcKfsYSznzDpHlcZTBmbTHgf6lMmH4cxePPw8j9d5fWr2yK/qQ/Uw1hL20E17klks1pbcx4VKBirqAK2ZtqpiFHZ1ev359hOxyaaiIhWrehw1ZhizdBV73Jn2OQhv+CO+Ea8ABJHzRrVO4tftBgcrSr30EfnSm6Ua/svK6VmHyxA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=lX4SOPKDi3ndUptnR7dxBqfndjJ5SbGEdF5Gd7LgMms=;
 b=XIInL52JOX8wfCxa1JkRMrHMKMPIAMtMwvLXYzNP51eUVVIUvP1kdLcaVA+RAxiO8Y/kxu9AcehQjpQe90RuOgzQnS3aM48jyYGEm5XsIgXGt1g2HsuLmFNud/h84H7va5+fVlaC+2UZYDUC7BPJ1mqhBsyoB5qhhNg4If4V8/iACHSwWy6PSwN7dFTp3H2n1q28kxafvYzXrLOHIZd9Eg/0n3jZZ4y45KF9I+SptLVdC6cAagnBCkf7gDApZKm+UsmlEp4wvm2ky+P2OynZUaCnuqneU3gPKysfmcpQFHqYKQpjiRiL/ERIbb2k4gQf1e9MKs+2hszVuqsCk3TMtA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Received: from SJ0PR11MB6744.namprd11.prod.outlook.com (2603:10b6:a03:47d::10)
 by SN7PR11MB7044.namprd11.prod.outlook.com (2603:10b6:806:29b::5)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7249.29; Fri, 2 Feb
 2024 06:45:35 +0000
Received: from SJ0PR11MB6744.namprd11.prod.outlook.com
 ([fe80::d7ca:7979:6536:7ac3]) by SJ0PR11MB6744.namprd11.prod.outlook.com
 ([fe80::d7ca:7979:6536:7ac3%5]) with mapi id 15.20.7228.029; Fri, 2 Feb 2024
 06:45:35 +0000
From: "Duan, Zhenzhong" <zhenzhong.duan@intel.com>
To: Eric Auger <eric.auger@redhat.com>, "eric.auger.pro@gmail.com"
 <eric.auger.pro@gmail.com>, "qemu-devel@nongnu.org" <qemu-devel@nongnu.org>,
 "qemu-arm@nongnu.org" <qemu-arm@nongnu.org>, "jean-philippe@linaro.org"
 <jean-philippe@linaro.org>, "alex.williamson@redhat.com"
 <alex.williamson@redhat.com>, "peter.maydell@linaro.org"
 <peter.maydell@linaro.org>, "yanghliu@redhat.com" <yanghliu@redhat.com>
CC: "mst@redhat.com" <mst@redhat.com>, "clg@redhat.com" <clg@redhat.com>,
 "jasowang@redhat.com" <jasowang@redhat.com>
Subject: RE: [PATCH v2 2/3] virtio-iommu: Trace domain range limits as
 unsigned int
Thread-Topic: [PATCH v2 2/3] virtio-iommu: Trace domain range limits as
 unsigned int
Thread-Index: AQHaVSx7YpksTBjVN02DQNMqx0G3g7D2nBeA
Date: Fri, 2 Feb 2024 06:45:35 +0000
Message-ID: <SJ0PR11MB6744D3EA020ABCEDE8806A5592422@SJ0PR11MB6744.namprd11.prod.outlook.com>
References: <20240201163324.564525-1-eric.auger@redhat.com>
 <20240201163324.564525-3-eric.auger@redhat.com>
In-Reply-To: <20240201163324.564525-3-eric.auger@redhat.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: SJ0PR11MB6744:EE_|SN7PR11MB7044:EE_
x-ms-office365-filtering-correlation-id: ddf32af6-9fe0-485d-35d5-08dc23ba8f18
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: oX/gNHlmQYKWTY7777G12TAZuwO1nrp8hx2zxeuhVGH0RVsKVi8r3PR+LLJBmaEjxxtv++9NjC80Xm18VmAF58mO0WCwhs9Aoamu55tRekY9jozpQG8qpJgO4jxsyYXnk2aKZu31pzBb44esFPQxvWtbLEC0+aAQ6QmozULsrISA0D2Gc/m2xTx7iGSphdoT7ZRmLZAu9d4LNL9dmTUTJbNRJgF4KP6SLH3eivzKY4vndA8Vj5Q4FepyKYqpDIQK/JRru9krSEid4ltI+TICJikZHKchgFpBx7+JIKBM1xTh2RLAwwTwctgFct7date+7pYJjq5VuC/MCUUnIJVExlHQQzOu37iglNpRxummmb/jm6g9zZHp9xHcOojz+ND3zBp6VCaAw7hlnJV2eeZiCu4LTM8sYCTb5sD8XiB4c7Ivc4M7SaVvD7lrpR2XgTEJxp84lNbye6+e66W7fmgXwvFAGj44y7RXlHkOErBfxPb17oSgEyFTotmwZrtkuoD2h4JDs6bmSp8wgUUZzzhA3g/VhmJs1HesGPiw8su0o80l4zX2nZMvY4UuzC51wZKkmdyCc9OumUIH5gWm5I19aQTq2UXgCjd2GHkK4aXyxM5SeCdUfxROd15jbsf/Le6o
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:SJ0PR11MB6744.namprd11.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230031)(136003)(39860400002)(346002)(396003)(376002)(366004)(230922051799003)(1800799012)(451199024)(186009)(64100799003)(83380400001)(41300700001)(9686003)(26005)(38100700002)(122000001)(52536014)(8676002)(4326008)(5660300002)(8936002)(7416002)(2906002)(478600001)(316002)(76116006)(54906003)(71200400001)(64756008)(66446008)(66476007)(66556008)(6506007)(7696005)(66946007)(110136005)(38070700009)(86362001)(33656002)(82960400001)(55016003);
 DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?8vnl6ya+yWnkXqS++xFt+hH1JUerF8dNIGlgEa8rkqtJiDmdXy1MgRN0B+lA?=
 =?us-ascii?Q?eor36YixQd2VRMkvq3lXT5iLaF2UsYD9z148WS7dad2m6wI0qdPMK4MmHEFq?=
 =?us-ascii?Q?mQmN75gV5f/zWaLDlWdMKSkjR+iBBKse38Q8CuZvKkxOYzw1+TZQPptb4oz3?=
 =?us-ascii?Q?3v8bfjadFFeWGvYyXXYUFZpPIbNikxtMJz0gjWlJuAILlrtfLo+rMan8Fzl6?=
 =?us-ascii?Q?m6Y0xaeT3aTk5Lu2nwLL1I/4NN1iNgUgH6vZFjjhcfefVUCAco9M3MiwTq0X?=
 =?us-ascii?Q?MR9jxUtoZ45SGSbzLrbjzqDqA9nFYPkba6E48xEiAEbgencvIa/lQymJhudO?=
 =?us-ascii?Q?siZvLrBbsC+JHsIYpjdrnVFyI7P6umMY6UmTX5DQ18wgNdaKb1+wpmGgZbzH?=
 =?us-ascii?Q?UhBzIv/1R1JAQU3A9Kuil4kIFr6EfpwcnT1MVkSb8hsB1eXJlotVcEsScPVj?=
 =?us-ascii?Q?QRpX58a8zBgh2XvyQ2YrSYMOgqy8TWs3wAgXwl0S3xyoA+qb4wwk8Q+LkWVl?=
 =?us-ascii?Q?D5xNkkCdN/KBnslkXvUkywryv/QRqvjGphwjq02ALAjY6Mb1UnW+2MLCsQos?=
 =?us-ascii?Q?0UPbdqceENa1crZoonpoqcm9s88hpdlETPSeOpFinLpJ51qCO3eMTzkSVj2O?=
 =?us-ascii?Q?gYdzslCpPVMG2YWQEusp+c47NXRzs9Jrn/zmvbW8/qeEd0pw3B1vHy03Q3gJ?=
 =?us-ascii?Q?wkGEfv9EORFixbLQRfZK6iVMBbonuSd3Vk+SXfjiX0c5H5K8ZDGxkgYGthzt?=
 =?us-ascii?Q?/SZzE3C78OxbJKiLN7A+Nev+WaPDqf8Ew/F4MDc5xsxJXaOY2nQyy59CtFkn?=
 =?us-ascii?Q?eaMtIiaKke1mmbrlwGMaPNlMJWhszU3sgGAU5ATkmD6NF3IR+F27NPWqFfbW?=
 =?us-ascii?Q?7TbGoVEJ6A0LTnMU6TMFrvj/XFJQRzYshMPGMb0u7JIDiYdESWuJAqRMFdYt?=
 =?us-ascii?Q?wpZOMM/QXNgR67j05+Lsed1ABGqA6TeMM+HMCsc++BpUome24x/bI/X00C4u?=
 =?us-ascii?Q?d/2ukL6AvIIITlH/fsH2AIOB5SEwei3BHUMPtpR8UaSkEUjYy7Kgh8cu/snC?=
 =?us-ascii?Q?DSs+60pmBixIevMZFET/pDSBJlSQj1e0IIqeGt2pOyH/WsnKE+ll23Nz2LqE?=
 =?us-ascii?Q?nkyMypXl+Ir/gx3xMjC1ABzMnIjba2HtPFfqNLX3QtLwaZ2c1ajdRb8Xnrc6?=
 =?us-ascii?Q?1FTS0723qzD489qhIMUey2AeZ/pwnY/OTxutetgdslAkcDcgERf1w95G+1sA?=
 =?us-ascii?Q?17BHtHOjHEtrv4IqwwTXQdOoWji2/j+Ohoj06ZX3gpJH9a96TpAAqUI3no5D?=
 =?us-ascii?Q?T2yTHkik8oFzHPV0KjmpQ4y2PgEWIsyCfAQtfFIqPae1hQeobOqMT1Bghfob?=
 =?us-ascii?Q?S4xw+yLvf7uyEmUmELcXdNvnEbVM3somKC/XrdmOqOGDOzyPynCMBg//A5da?=
 =?us-ascii?Q?mCsN1fM27UEovfyVnxCAIC1h5nKL0AG9E1a9108UaQaHgsacjgmx6hvMs0V3?=
 =?us-ascii?Q?Gd2z0ToGPB+6p6bYeyCzWrhHKfZnQZNSh2t1Yia9iIc+axvRO/efr/rEM7uA?=
 =?us-ascii?Q?FDQljT4eA7MzCpqyoSLDHOJA/L9nX7S1qHn+vNw9?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: SJ0PR11MB6744.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: ddf32af6-9fe0-485d-35d5-08dc23ba8f18
X-MS-Exchange-CrossTenant-originalarrivaltime: 02 Feb 2024 06:45:35.0276 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: mE6vfn2jY1fRqMYXuzIvdCHhq1LCt53cJrqP7f+lCFIApkQcHNxo4VeTaoLI2fMsl1xh5fAKB+p3voKYqzBNDtky2QopERrr0zOpwOupe4c=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SN7PR11MB7044
X-OriginatorOrg: intel.com
Received-SPF: pass client-ip=192.55.52.115;
 envelope-from=zhenzhong.duan@intel.com; helo=mgamail.intel.com
X-Spam_score_int: -56
X-Spam_score: -5.7
X-Spam_bar: -----
X-Spam_report: (-5.7 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-1.292,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_MED=-2.3, SPF_HELO_NONE=0.001, T_SCC_BODY_TEXT_LINE=-0.01,
 T_SPF_TEMPERROR=0.01 autolearn=ham autolearn_force=no
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
>Subject: [PATCH v2 2/3] virtio-iommu: Trace domain range limits as
>unsigned int
>
>Use %u format to trace domain_range limits.
>
>Signed-off-by: Eric Auger <eric.auger@redhat.com>

Reviewed-by: Zhenzhong Duan <zhenzhong.duan@intel.com>

Thanks
Zhenzhong

>---
> hw/virtio/trace-events | 2 +-
> 1 file changed, 1 insertion(+), 1 deletion(-)
>
>diff --git a/hw/virtio/trace-events b/hw/virtio/trace-events
>index 77905d1994..2350849fbd 100644
>--- a/hw/virtio/trace-events
>+++ b/hw/virtio/trace-events
>@@ -111,7 +111,7 @@ virtio_iommu_device_reset(void) "reset!"
> virtio_iommu_system_reset(void) "system reset!"
> virtio_iommu_get_features(uint64_t features) "device supports
>features=3D0x%"PRIx64
> virtio_iommu_device_status(uint8_t status) "driver status =3D %d"
>-virtio_iommu_get_config(uint64_t page_size_mask, uint64_t start,
>uint64_t end, uint32_t domain_start, uint32_t domain_end, uint32_t
>probe_size, uint8_t bypass) "page_size_mask=3D0x%"PRIx64" input range
>start=3D0x%"PRIx64" input range end=3D0x%"PRIx64" domain range start=3D%d
>domain range end=3D%d probe_size=3D0x%x bypass=3D0x%x"
>+virtio_iommu_get_config(uint64_t page_size_mask, uint64_t start,
>uint64_t end, uint32_t domain_start, uint32_t domain_end, uint32_t
>probe_size, uint8_t bypass) "page_size_mask=3D0x%"PRIx64" input range
>start=3D0x%"PRIx64" input range end=3D0x%"PRIx64" domain range start=3D%u
>domain range end=3D%u probe_size=3D0x%x bypass=3D0x%x"
> virtio_iommu_set_config(uint8_t bypass) "bypass=3D0x%x"
> virtio_iommu_attach(uint32_t domain_id, uint32_t ep_id) "domain=3D%d
>endpoint=3D%d"
> virtio_iommu_detach(uint32_t domain_id, uint32_t ep_id) "domain=3D%d
>endpoint=3D%d"
>--
>2.41.0


