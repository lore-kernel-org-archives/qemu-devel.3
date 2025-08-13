Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id ABC20CA0EE0
	for <qemu-devel@archiver.kernel.org>; Wed, 13 Aug 2025 06:59:22 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1um5R1-00042T-9r; Wed, 13 Aug 2025 02:58:07 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <zhenzhong.duan@intel.com>)
 id 1um5Qw-000419-UM
 for qemu-devel@nongnu.org; Wed, 13 Aug 2025 02:58:03 -0400
Received: from mgamail.intel.com ([198.175.65.11])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <zhenzhong.duan@intel.com>)
 id 1um5Qb-00028G-MA
 for qemu-devel@nongnu.org; Wed, 13 Aug 2025 02:57:58 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1755068262; x=1786604262;
 h=from:to:cc:subject:date:message-id:references:
 in-reply-to:content-transfer-encoding:mime-version;
 bh=bgR3Fu6R2Om7gcCHAVCRjAy8bc9hHbmee/L7O96xtyU=;
 b=USKjtHgiFM1VTWwOfVxBw/7bIJUX+ySGNqpogolMa/0uFUr7bygMQoqC
 mQv3t/qvPhsmp1gegGa6WooIRptXh1dYpd2o0D6qFtnm4g9I3qgMOdzGh
 gwy5Q43XXWiaqSyALuE4/LLRL13iBjyxfEAjirWgI8ZDhtoZo5Pv5YQVA
 /olXwsUAlYt8n3tY/THanXiWbpsgX5uoaEdh3NXJ79pIod27CIkQVTcJ7
 xSWrW0w1CwamgnuizuOeS71bW0EqhS/pwmlohH6Nq9uwP6lL4x5HoDdFD
 m9ILnyyDKK1Gnl/ronC/EYNd6fv1qIweQQFyP0mCxKF1Eut/GebE1TVjX w==;
X-CSE-ConnectionGUID: FxawTALzSLSw+7vxQrrSXQ==
X-CSE-MsgGUID: U4PYsK79QV2FwIVa9+D6ww==
X-IronPort-AV: E=McAfee;i="6800,10657,11520"; a="67619895"
X-IronPort-AV: E=Sophos;i="6.17,285,1747724400"; d="scan'208";a="67619895"
Received: from fmviesa005.fm.intel.com ([10.60.135.145])
 by orvoesa103.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 12 Aug 2025 23:57:32 -0700
X-CSE-ConnectionGUID: j80Ay/WZTlGnuj996X/M8Q==
X-CSE-MsgGUID: k1wYU0ZWRVmCXo2f5pJ9Qg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.17,285,1747724400"; d="scan'208";a="170600381"
Received: from fmsmsx901.amr.corp.intel.com ([10.18.126.90])
 by fmviesa005.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 12 Aug 2025 23:57:31 -0700
Received: from FMSMSX901.amr.corp.intel.com (10.18.126.90) by
 fmsmsx901.amr.corp.intel.com (10.18.126.90) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.17; Tue, 12 Aug 2025 23:57:30 -0700
Received: from fmsedg901.ED.cps.intel.com (10.1.192.143) by
 FMSMSX901.amr.corp.intel.com (10.18.126.90) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.17 via Frontend Transport; Tue, 12 Aug 2025 23:57:30 -0700
Received: from NAM12-BN8-obe.outbound.protection.outlook.com (40.107.237.67)
 by edgegateway.intel.com (192.55.55.81) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1748.26; Tue, 12 Aug 2025 23:57:29 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=DbnxsgVqBhPY5tYzG2yshYHnJDdHh7OVjtJMxc7SwX3zsvoO7eIkCN5HloxFKq1zvx6C2kSo2XQRB5PrfmF6GQw6QLEUbS5tx5ZMrjDquWQ1TGm00a+OE7mSKyrzq7KNMoVBpowyJ64uVPMTuHmA2naXeIJ8vOn+xQpLXDEC3Ve9YVkYYnEwBflqv16P17aRIFd1+3VrhofSUg1o8SS2s7BYm+1jCF+mMarMwlHbqJkB3rqKSP+OHEZwjzvzG+h4jaX+pKpu+AdEYeDRMVJuRCNvUvj0ljO41uzZQRrXBEXzHsnVxX5wrBwAVfDcBBoP/su6w/On0/q4za8aBsUH6w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=bgR3Fu6R2Om7gcCHAVCRjAy8bc9hHbmee/L7O96xtyU=;
 b=MCgCPDMhYn8MhwfTrPnqwIHXX/mYlkTQLr2uy9hpCNtDBRFSvvDri3JKVlhE/FRylr0AKfxztUXyobTJUu7l4H0NhkRFlpNQEjImy/S9BufIcC7iQoeoxYtdLP70MmWrBL3NSGeFCaaCkpfUd8MVMdrQs5wp+v6hD+wUq37hC29zGe0IVOwAU7xT9puBDBmjWjACJXHOCrOUR4DMGXRo20+CVAoOt313OnoU4gvAuK+1W2LzOF9S+1B67XGC1NXiX2vPG29yIJNPGNke8oWlT1W6vfiylWUANuzDaFva9ztxtRn1lI4SeQl+8TwG6dxbvocOvhIIfUfevdkLk9pbqQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Received: from IA3PR11MB9136.namprd11.prod.outlook.com (2603:10b6:208:574::12)
 by DM3PPF01A5BE19B.namprd11.prod.outlook.com (2603:10b6:f:fc00::f04)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9031.13; Wed, 13 Aug
 2025 06:57:22 +0000
Received: from IA3PR11MB9136.namprd11.prod.outlook.com
 ([fe80::604b:77a4:b1be:3f13]) by IA3PR11MB9136.namprd11.prod.outlook.com
 ([fe80::604b:77a4:b1be:3f13%4]) with mapi id 15.20.9031.014; Wed, 13 Aug 2025
 06:57:22 +0000
From: "Duan, Zhenzhong" <zhenzhong.duan@intel.com>
To: Jim Shu <jim.shu@sifive.com>
CC: "qemu-devel@nongnu.org" <qemu-devel@nongnu.org>,
 "alex.williamson@redhat.com" <alex.williamson@redhat.com>, "clg@redhat.com"
 <clg@redhat.com>, "eric.auger@redhat.com" <eric.auger@redhat.com>,
 "mst@redhat.com" <mst@redhat.com>, "jasowang@redhat.com"
 <jasowang@redhat.com>, "peterx@redhat.com" <peterx@redhat.com>,
 "ddutile@redhat.com" <ddutile@redhat.com>, "jgg@nvidia.com" <jgg@nvidia.com>, 
 "nicolinc@nvidia.com" <nicolinc@nvidia.com>,
 "shameerali.kolothum.thodi@huawei.com"
 <shameerali.kolothum.thodi@huawei.com>, "joao.m.martins@oracle.com"
 <joao.m.martins@oracle.com>, "clement.mathieu--drif@eviden.com"
 <clement.mathieu--drif@eviden.com>, "Tian, Kevin" <kevin.tian@intel.com>,
 "Liu, Yi L" <yi.l.liu@intel.com>, "Peng, Chao P" <chao.p.peng@intel.com>
Subject: RE: [PATCH v4 02/20] hw/pci: Introduce pci_device_get_viommu_cap()
Thread-Topic: [PATCH v4 02/20] hw/pci: Introduce pci_device_get_viommu_cap()
Thread-Index: AQHcAGojBHGmrySSMUmmVahA3JzrVrRgOjeAgAAAorA=
Date: Wed, 13 Aug 2025 06:57:22 +0000
Message-ID: <IA3PR11MB913693C2573362CD7F3F7B22922AA@IA3PR11MB9136.namprd11.prod.outlook.com>
References: <20250729092043.785836-1-zhenzhong.duan@intel.com>
 <20250729092043.785836-3-zhenzhong.duan@intel.com>
 <CALw707oaU-1uiVjV4k=RQLbXJWk2vhqDMX7+r=Mx=QhQQZE1Hg@mail.gmail.com>
In-Reply-To: <CALw707oaU-1uiVjV4k=RQLbXJWk2vhqDMX7+r=Mx=QhQQZE1Hg@mail.gmail.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: IA3PR11MB9136:EE_|DM3PPF01A5BE19B:EE_
x-ms-office365-filtering-correlation-id: 9dc8e72b-cca1-4164-fccd-08ddda36a73a
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
 ARA:13230040|7416014|376014|366016|1800799024|38070700018; 
x-microsoft-antispam-message-info: =?utf-8?B?VjB4ZnNnSzFZSW9NY0pwZXdnT1J3VHl0bWhVV0FzUUxaNEZ3dTVlRWtOWGNa?=
 =?utf-8?B?V0NQM3ZXL3NkY0pNVGk4ZXl4QnV4dUJ4RFdreU1nSGlReHpXVWpSMVdlUmhy?=
 =?utf-8?B?ejhBa0VkMEt0bHA2MEhpeFdRTjhpOTRDVXFiMlp2TUpXeDNMRUt5QjhHYTZ3?=
 =?utf-8?B?Q2hYL1R3Wk9DM1NReThXTG03L1RZb2E4RVhqdkUzY0I3aDZNM3VtYjNTcXQw?=
 =?utf-8?B?RUs5eWd4cDBnNm1NUktUVmE2S2ZCOHN3ZytBVmw3dGVBZEdwR3V1ZTNNeXBP?=
 =?utf-8?B?Tkk5ZVRJU2dOVXYvbW5uL2JEcnU0aHZGY3hvMnk4K0dDWFM2R0hGUUkyc21p?=
 =?utf-8?B?eG92OUdMVzRlbjVJWTRBaGdHN3pWZytvRE1wc3prVDhGNnVQZ3ZvaEpzU1dQ?=
 =?utf-8?B?Nm0zcXBFd01EbHNIK1JQUjc1aGpTQVhlc01BYWZ0ZjV5bUxWc3Z2YXd1YkZr?=
 =?utf-8?B?QW9DNmh0eXIvWEZqUHVJOWFaV3NmT3QwTjJOOFIzUGdhMVRPdis5enFHVGtZ?=
 =?utf-8?B?Sm9zZTN4bzVNMCsydkJIMmRhUTYya2x2S0xhNitqYWp2WHg1MHlyQU5xNXlh?=
 =?utf-8?B?ekVzN1VoRC9KeTZScCtDL2YwN0dROTJVK2lTYmk5K3V0anlVdUNjbXNkQ01E?=
 =?utf-8?B?RmRubzk1RnBTU3RWKzhQTW1ad1VEd1ZqeHUxMHlDNjk5UEF0RXlPbDVQajhh?=
 =?utf-8?B?OFRsTlVFamRqWi9JdlZvbmNhQThKSHFXRzBxUmdOS1lhb0w0VDBTTGdwNGRh?=
 =?utf-8?B?My9lWTVaUGRoaW5na2xWUjJpSHEwcEsxcEVmdy9KTWplUmtlS0tyZEY5ZTBR?=
 =?utf-8?B?TjM3SEdYbk1WRTFlTVREajNpK2ZKTmJ4RWhVYUxsVUE2cFNKZ3N4Ly93SWpU?=
 =?utf-8?B?RUxYU1hQaXI1Z3hxTXlsS1p4bDZpdXRpdkNoLy9GSmdHOUd1SDNGZW1TZjFj?=
 =?utf-8?B?V1BOcm1UWVNWTjVWYks0dmk3cm01TFZjWHlXZWRGelE1UkltcFc1MnhWRmdk?=
 =?utf-8?B?cEpOcitMN3BvbTV2T3I3QmVsNnlRd3RPK0x3dnZHVGJWdFFudXd4dU9qRHMw?=
 =?utf-8?B?Yngxd2Ewb1lyV0VoVHlHejVmWFpGbEdJQlJpQmpickdaYUdtR3dENmd2YXoz?=
 =?utf-8?B?Mng2NXNvazBYa2tmSzcxQVpiL0xlUFBjUFMwMUhIckt3dFMxcnlGSWN5aWds?=
 =?utf-8?B?cjczdUcrL3VMTGpHNFVlQjV3dERadS9jZHVxenp4M2tBb0o0MHVKaUdLUENT?=
 =?utf-8?B?OFh5bFdqWjFzRVIvWU93TEUwbElqNXdaLzJhL1hVbVJKUHJLQW9hUHJvOU1a?=
 =?utf-8?B?aUNqbzJHM0dDOEt4N3NycUN6ZXA0RXlmZ2tjeG5uZ1pCWk4wam1GcjZkS21W?=
 =?utf-8?B?SXlDOEtqd0VjaFJrMDlJS0k0VGpIVFg1MmtIbmZFbnFTZnJocngyQ0VhUVdB?=
 =?utf-8?B?L01uK0wvVnFjTUJlMlVZdlV5N25FV01RM3ViOW5HNmRkeERVckl6TnFNTDlr?=
 =?utf-8?B?bFY3bEdoZVFCdnpUTFlhZFFVcHVLRktSVWI0Rkd0cTNEMkpKYWY4elJsVHo1?=
 =?utf-8?B?bGJNMEpoK0NzUDJ6YmlZRzZSYjNlK0RnUkdIa1BBRFprdXdWVTBCcFphSzR5?=
 =?utf-8?B?RUtGSW80dkRkUVVCZnFZMTVaSmpFYTVQVTdKblRCZ1hWemljelB4R2g2MHpt?=
 =?utf-8?B?eThqaVpOV2VucjZCNVFjWWZ0ZnpRMHd1V3cxUUhtL0tDRkJDOWV1UjBVSnZq?=
 =?utf-8?B?Y2FGYkpLZUhQVFhZQm05WUxETmZOMkRBT0JYc2lhZXpRVXd0M0tCaUZPSDdq?=
 =?utf-8?B?NVZLeG5GOWp6UkxJbVo1Q0dxQ1dsY09VcGtTbDMxVkE0N050Y2tCNHg0MHRy?=
 =?utf-8?B?MmpPZ1A0ZGxoL2hFeFBudndCRHFRRUsyOW1yd1ZPV0psSVk1eldIa1ZSY25L?=
 =?utf-8?B?N0ZxWHROc3hRN25qY2pCSEwwL2FZSTdrVW5pa2hjaFpmaDZ0dUhaa2JLWmhp?=
 =?utf-8?Q?48aIugurblgtyTpMZaSGJ4618cMDAM=3D?=
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:IA3PR11MB9136.namprd11.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(7416014)(376014)(366016)(1800799024)(38070700018); DIR:OUT;
 SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?cU5NalN4QkhEa2REL25zZ042TFN6VHI0aHoyd0JYSlhIOVhKa1VMU3hqTWZi?=
 =?utf-8?B?QjA2ZEJWTEM5TmdmZ215aTVtMlQ5TGFDUnplU1hoWWthNERwLzg5VmVlZlZY?=
 =?utf-8?B?OWJ3Zm5jakY4dlYvdGJWOWNxNGRtWjFuaURRc05veXBIMHhDcFIvYUlNUlhO?=
 =?utf-8?B?QXh0QW9EM09QbnNyTXZHQnpXeWNUZ0U5aUplV1N2UU0yeUduUDNQN1MxdEh3?=
 =?utf-8?B?ODhrU1phWmFUTWZZa243QU9zbW0raFBlNmZXZzZRZVhPMjBtRUdlRXRrZWdt?=
 =?utf-8?B?ZmFFSGp5QUhuaXJ2c0tuenJ2b1E4Rzk2bjR1QnkyZFZ5SDlyRTlVeXdKR2hN?=
 =?utf-8?B?TXVMUHpzL3M1VTJSZndQSjJwRkExWWFIZUhTcjlzYVBpZzZiSlZoUUxYM3Zj?=
 =?utf-8?B?TWdIeENMd3VkbFkzNXVxTXNidzVHcHNmZGUxN0NzMHNQSHUxQjQzSU1lVURL?=
 =?utf-8?B?RC9IeVZ6N2pBUzg3VmNYN2dieVFqTUd6ejZwbHg1Qk8wN0tJcWhpNWVjdEpt?=
 =?utf-8?B?V0ZORk53UWs1RFVzUlEwRFpHSURycGViVDkzNHRPSFRKcTYxUm1scUZHaWgx?=
 =?utf-8?B?NEwrTUg3bEFBcmlnSUJIS1FWZjFCSFBOZXIrdVIvd1drVlo2RXI2UGE3MXBq?=
 =?utf-8?B?bWJpZG1GeGQ2YjRCVTYwZXIxN1JtYVZSSVpSYlNNSENNU3F6MEJVdlZkMExD?=
 =?utf-8?B?MUJ0eG8xWmQvU3luWC9UQm1JTjJiNzBGNnJZTnZrWFVzZHZVVCtjQk16cjhr?=
 =?utf-8?B?a3JwU2ZkVHhYRzdLK1dpQ25yMEVVckpWNHFhS3FUQ3BDdUVidDFMNzd0Ujhr?=
 =?utf-8?B?bGtCRFpmSFNscndqNVMvaCtaUGV6RnNjeUJtZ2F0RTR6dEp2T0lvVGFQUDNy?=
 =?utf-8?B?czZwY205OGhGalVFUGxrdkowcFg4Tk1EUE9FUXVSY3hQVTlBVjFTWnIzK0tX?=
 =?utf-8?B?c21nNFlCM1VKVmZML2FIbnBJaGpGeUprZzZaZ2tkYkIwTml5YjJqbkM1NDBX?=
 =?utf-8?B?WHdsSWYwbzAvaWVTYTN5N0Z2N0puazl0ZDdGRlpJK3lqVUpYaWhPYm9VMFlJ?=
 =?utf-8?B?WHNsTFpOMzhYekdOMmFOczhQM0s4SkxIQkgwM0h3djc1QWt0aFF4dy9GdFBi?=
 =?utf-8?B?ZTNqUW5ibHdzZHJwSC9EMzRmRXV6L1dMdys5d3ZRcWFkaDNqRTNNTE5CbEFa?=
 =?utf-8?B?SUNKekJ6dnBUZER1Sk4rMld5aDBueFhhL21FMHZOcUF4ZzB0K2x4cnc3ZFpT?=
 =?utf-8?B?YVhBZC85aGJ1c3IxK3Q1RzhLaG5NZXdZTFlnSnlJWDFSeVhYbjBLTnZicjBv?=
 =?utf-8?B?cTdINGJjVlYrMEVPT0lYbDRVS3M5RGk3eXhGL1pOUVJGRkE4UGFYeHVBdmJT?=
 =?utf-8?B?cDRoWmZzRHF1UWhyM1pidHRqZncvOUx4Nml6WkEyWEFEcXE2QVdqWXlRaENz?=
 =?utf-8?B?SkNrdU5DOEVZc3A5bFZGNXpRaS9Xa25OMVZPSmprT2xLV0NIczh2Njl6ck5z?=
 =?utf-8?B?Uis3OFQxYndFYjRlZ3QzUzJKdWNLVSttK2V5azY4UXNZU3J6QzRTcXJ0azdV?=
 =?utf-8?B?MzZRVFNqa0o4SnRnM2lSSFhxMEhSRW85dk55dkQyV3VrMkh4dU9iNWR0d3Zq?=
 =?utf-8?B?bzhIam1HbVJkQ3c3ZnNHYjZueWxLRThiVGxtajYwUUpiaE8zMW0xWjVxamJE?=
 =?utf-8?B?cEZ1emRsMXFleWFBc2RaWm9jbU9sUlNqMGg4aGxEZ3NURjE5emlMelI0ZGlN?=
 =?utf-8?B?TDZHKzVWUlA1bXo1TERlR0hIdDdpQUFrUW1BYjZkMDdLS1JTSzhKLzFmN2VV?=
 =?utf-8?B?NXpMNlJJTG5HTnBIeGNvNWsyMzNSTEg3VG1MMXVBSnhGOE9yRGx0TDhoOFZE?=
 =?utf-8?B?TWFTY3A0NWFXdU1Pa2pBVjVwcUJHR0ZBVE81Nk41eGxGZDNVOHJtdGJwY0x6?=
 =?utf-8?B?UmY2MTNMcGpQWW9JK2Z3cDlhcjRwOGdOdERYa1BpOXVuNXlBdmRqOGFFUjZh?=
 =?utf-8?B?d3AwS3Y5akU3TjQzWjVzVWk0T3VMa1M2ZjFUSTFybFdkZjBDWXc5Q1dQVXRL?=
 =?utf-8?B?UmRJakJjby9XMm90VGJiUmxNUndxaGpFR3RqcFlxRW9YMXhQODFiNW1UWDBW?=
 =?utf-8?Q?a8DLlSK5aRxRGxNdDFzERQtg9?=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: IA3PR11MB9136.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 9dc8e72b-cca1-4164-fccd-08ddda36a73a
X-MS-Exchange-CrossTenant-originalarrivaltime: 13 Aug 2025 06:57:22.4599 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 2fSWWjUQDv6xLfg4yIHUGalROt2V9op5C3sPta8J28Zcq+ThnkhXhnb3r9FVLNE9b1bp3CeDZtTLjuXQ2uFQaabshWSw8Oc91aTmDvFxQ9I=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM3PPF01A5BE19B
X-OriginatorOrg: intel.com
Received-SPF: pass client-ip=198.175.65.11;
 envelope-from=zhenzhong.duan@intel.com; helo=mgamail.intel.com
X-Spam_score_int: -43
X-Spam_score: -4.4
X-Spam_bar: ----
X-Spam_report: (-4.4 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_MED=-2.3, RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001,
 RCVD_IN_VALIDITY_SAFE_BLOCKED=0.001, SPF_HELO_NONE=0.001,
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

DQoNCj4tLS0tLU9yaWdpbmFsIE1lc3NhZ2UtLS0tLQ0KPkZyb206IEppbSBTaHUgPGppbS5zaHVA
c2lmaXZlLmNvbT4NCj5TdWJqZWN0OiBSZTogW1BBVENIIHY0IDAyLzIwXSBody9wY2k6IEludHJv
ZHVjZQ0KPnBjaV9kZXZpY2VfZ2V0X3Zpb21tdV9jYXAoKQ0KPg0KPkhpIFpoZW56aG9uZywNCj4N
Cj5PbiBUdWUsIEp1bCAyOSwgMjAyNSBhdCA1OjIx4oCvUE0gWmhlbnpob25nIER1YW4NCj48emhl
bnpob25nLmR1YW5AaW50ZWwuY29tPiB3cm90ZToNCj4+DQo+PiBJbnRyb2R1Y2UgYSBuZXcgUENJ
SU9NTVVPcHMgb3B0aW9uYWwgY2FsbGJhY2ssIGdldF92aW9tbXVfY2FwKCkgd2hpY2gNCj4+IGFs
bG93cyB0byByZXRyaWV2ZSBjYXBhYmlsaXRpZXMgZXhwb3NlZCBieSBhIHZJT01NVS4gVGhlIGZp
cnN0IHBsYW5uZWQNCj4+IGNhcGFiaWxpdHkgaXMgVklPTU1VX0NBUF9IV19ORVNURUQgdGhhdCBh
ZHZlcnRpc2VzIHRoZSBzdXBwb3J0IG9mIEhXDQo+PiBuZXN0ZWQgc3RhZ2UgdHJhbnNsYXRpb24g
c2NoZW1lLiBwY2lfZGV2aWNlX2dldF92aW9tbXVfY2FwIGlzIGEgd3JhcHBlcg0KPj4gdGhhdCBj
YW4gYmUgY2FsbGVkIG9uIGEgUENJIGRldmljZSBwb3RlbnRpYWxseSBwcm90ZWN0ZWQgYnkgYSB2
SU9NTVUuDQo+Pg0KPj4gZ2V0X3Zpb21tdV9jYXAoKSBpcyBkZXNpZ25lZCB0byByZXR1cm4gNjRi
aXQgYml0bWFwIG9mIHB1cmVseSBlbXVsYXRlZA0KPj4gY2FwYWJpbGl0aWVzIHdoaWNoIGFyZSBv
bmx5IGRlcmVybWluZWQgYnkgdXNlcidzIGNvbmZpZ3VyYXRpb24sIG5vIGhvc3QNCj4+IGNhcGFi
aWxpdGllcyBpbnZvbHZlZC4gUmVhc29ucyBhcmU6DQo+Pg0KPj4gMS4gdGhlcmUgY2FuIGJlIG1v
cmUgdGhhbiBvbmUgaG9zdCBJT01NVXMgd2l0aCBkaWZmZXJlbnQgY2FwYWJpbGl0aWVzDQo+PiAy
LiB0aGVyZSBjYW4gYWxzbyBiZSBtb3JlIHRoYW4gb25lIHZJT01NVXMgd2l0aCBkaWZmZXJlbnQg
dXNlcg0KPj4gICAgY29uZmlndXJhdGlvbiwgZS5nLiwgYXJtIHNtbXV2My4NCj4+IDMuIFRoaXMg
aXMgbWlncmF0aW9uIGZyaWVuZGx5LCByZXR1cm4gdmFsdWUgaXMgY29uc2lzdGVudCBiZXR3ZWVu
IHNvdXJjZQ0KPj4gICAgYW5kIHRhcmdldC4NCj4+IDQuIEl0J3MgdG9vIGxhdGUgZm9yIFZGSU8g
dG8gY2FsbCBnZXRfdmlvbW11X2NhcCgpIGFmdGVyIHNldF9pb21tdV9kZXZpY2UoKQ0KPj4gICAg
YmVjYXVzZSB3ZSBuZWVkIGdldF92aW9tbXVfY2FwKCkgdG8gZGV0ZXJtaW5lIGlmIGNyZWF0aW5n
IG5lc3RlZA0KPnBhcmVudA0KPj4gICAgaHdwdCBvciBub3QgYXQgYXR0YWNoaW5nIHN0YWdlLCBt
ZWFud2hpbGUgaGlvZCByZWFsaXplIG5lZWRzIGlvbW11ZmQsDQo+PiAgICBkZXZpZCBhbmQgaHdw
dF9pZCB3aGljaCBhcmUgcmVhZHkgYWZ0ZXIgYXR0YWNoX2RldmljZSgpLg0KPj4gICAgU2VlIGJl
bG93IHNlcXVlbmNlOg0KPj4NCj4+ICAgICAgYXR0YWNoX2RldmljZSgpDQo+PiAgICAgICAgZ2V0
X3Zpb21tdV9jYXAoKQ0KPj4gICAgICAgIGNyZWF0ZSBod3B0DQo+PiAgICAgIC4uLg0KPj4gICAg
ICBjcmVhdGUgaGlvZA0KPj4gICAgICBzZXRfaW9tbXVfZGV2aWNlKGhpb2QpDQo+Pg0KPj4gU3Vn
Z2VzdGVkLWJ5OiBZaSBMaXUgPHlpLmwubGl1QGludGVsLmNvbT4NCj4+IFNpZ25lZC1vZmYtYnk6
IFpoZW56aG9uZyBEdWFuIDx6aGVuemhvbmcuZHVhbkBpbnRlbC5jb20+DQo+PiAtLS0NCj4+ICBN
QUlOVEFJTkVSUyAgICAgICAgICB8ICAxICsNCj4+ICBpbmNsdWRlL2h3L2lvbW11LmggICB8IDE3
ICsrKysrKysrKysrKysrKysrDQo+PiAgaW5jbHVkZS9ody9wY2kvcGNpLmggfCAyNSArKysrKysr
KysrKysrKysrKysrKysrKysrDQo+PiAgaHcvcGNpL3BjaS5jICAgICAgICAgfCAxMSArKysrKysr
KysrKw0KPj4gIDQgZmlsZXMgY2hhbmdlZCwgNTQgaW5zZXJ0aW9ucygrKQ0KPj4gIGNyZWF0ZSBt
b2RlIDEwMDY0NCBpbmNsdWRlL2h3L2lvbW11LmgNCj4+DQo+PiBkaWZmIC0tZ2l0IGEvTUFJTlRB
SU5FUlMgYi9NQUlOVEFJTkVSUw0KPj4gaW5kZXggMzc4NzlhYjY0ZS4uODQwY2IxZTYwNCAxMDA2
NDQNCj4+IC0tLSBhL01BSU5UQUlORVJTDQo+PiArKysgYi9NQUlOVEFJTkVSUw0KPj4gQEAgLTIz
MDQsNiArMjMwNCw3IEBAIEY6IGluY2x1ZGUvc3lzdGVtL2lvbW11ZmQuaA0KPj4gIEY6IGJhY2tl
bmRzL2hvc3RfaW9tbXVfZGV2aWNlLmMNCj4+ICBGOiBpbmNsdWRlL3N5c3RlbS9ob3N0X2lvbW11
X2RldmljZS5oDQo+PiAgRjogaW5jbHVkZS9xZW11L2NoYXJkZXZfb3Blbi5oDQo+PiArRjogaW5j
bHVkZS9ody9pb21tdS5oDQo+PiAgRjogdXRpbC9jaGFyZGV2X29wZW4uYw0KPj4gIEY6IGRvY3Mv
ZGV2ZWwvdmZpby1pb21tdWZkLnJzdA0KPj4NCj4+IGRpZmYgLS1naXQgYS9pbmNsdWRlL2h3L2lv
bW11LmggYi9pbmNsdWRlL2h3L2lvbW11LmgNCj4+IG5ldyBmaWxlIG1vZGUgMTAwNjQ0DQo+PiBp
bmRleCAwMDAwMDAwMDAwLi4wMjFkYjUwZGI1DQo+PiAtLS0gL2Rldi9udWxsDQo+PiArKysgYi9p
bmNsdWRlL2h3L2lvbW11LmgNCj4+IEBAIC0wLDAgKzEsMTcgQEANCj4+ICsvKg0KPj4gKyAqIEdl
bmVyYWwgdklPTU1VIGNhcGFiaWxpdGllcywgZmxhZ3MsIGV0Yw0KPj4gKyAqDQo+PiArICogQ29w
eXJpZ2h0IChDKSAyMDI1IEludGVsIENvcnBvcmF0aW9uLg0KPj4gKyAqDQo+PiArICogU1BEWC1M
aWNlbnNlLUlkZW50aWZpZXI6IEdQTC0yLjAtb3ItbGF0ZXINCj4+ICsgKi8NCj4+ICsNCj4+ICsj
aWZuZGVmIEhXX0lPTU1VX0gNCj4+ICsjZGVmaW5lIEhXX0lPTU1VX0gNCj4+ICsNCj4NCj5Db3Vs
ZCB3ZSBpbmNsdWRlIGhlYWRlciAicWVtdS9iaXRvcHMuaCIgaGVyZSB0byB1c2UgYEJJVF9VTEwo
KWAgaW4gdGhpcyBmaWxlPw0KPk9yIGl0IHdpbGwgZ2V0IGNvbXBpbGUgZXJyb3Igd2hlbiBpbmNs
dWRpbmcgaXQgaW4gdGhlIG90aGVyIElPTU1VLg0KDQpPaCwgdGhhbmtzIGZvciBwb2ludCBvdXQs
IGZpeGVkIGF0IGh0dHBzOi8vZ2l0aHViLmNvbS95aWxpdTE3NjUvcWVtdS9jb21taXRzL3poZW56
aG9uZy9pb21tdWZkX25lc3RpbmcudjUud2lwLw0KDQpCUnMsDQpaaGVuemhvbmcNCg==

