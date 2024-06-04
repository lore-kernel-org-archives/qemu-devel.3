Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C6342C25B7E
	for <qemu-devel@archiver.kernel.org>; Tue,  4 Jun 2024 07:51:52 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sEOwz-000625-Lx; Tue, 04 Jun 2024 03:51:21 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <zhenzhong.duan@intel.com>)
 id 1sEOwx-00061Z-7z
 for qemu-devel@nongnu.org; Tue, 04 Jun 2024 03:51:19 -0400
Received: from mgamail.intel.com ([198.175.65.13])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <zhenzhong.duan@intel.com>)
 id 1sEOwu-0001JB-95
 for qemu-devel@nongnu.org; Tue, 04 Jun 2024 03:51:19 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1717487477; x=1749023477;
 h=from:to:cc:subject:date:message-id:references:
 in-reply-to:content-transfer-encoding:mime-version;
 bh=YNUbrXoKMEI+rLkkEw6toH++HAIzW/2TnsA/EoFwUMo=;
 b=e13Fxw48uxD6vx13RctDxAIwrbRsRzPeL12f3v2JiN5X0IhS7K3JxFWI
 O8RlCpEPDHsxPP6mnRPF8jwFjb+srkrarSVVmVRpuXloOffu3M6mCiNhs
 ptx/XtFI1VjXCEn/tbfkkEtI+K6qBp/UrxlMcyC4eiBA3RUzGBEUs8TCi
 pS7I6hL/KKJT5LEsKaUFwkHoszitXjdFXOJvLp9Fv8i6YDFbmFqdS3i4E
 ifKgQueppUHab90AzpId/kLruMI9Tr6pvuBzC9+6yWDb9nfLoJNj8Ol4A
 z+2bwFOW12VysfebOoDGUiwCP8exXZhxysJd9h6M7M3BpspwmITiwLWc1 w==;
X-CSE-ConnectionGUID: w/jrLiS1TSOC8Ik7m570yw==
X-CSE-MsgGUID: kIF+NGxYR72CnXzoOgvLHg==
X-IronPort-AV: E=McAfee;i="6600,9927,11092"; a="25126287"
X-IronPort-AV: E=Sophos;i="6.08,213,1712646000"; d="scan'208";a="25126287"
Received: from orviesa006.jf.intel.com ([10.64.159.146])
 by orvoesa105.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 04 Jun 2024 00:51:13 -0700
X-CSE-ConnectionGUID: 0rnQYFS1QUm9LtDWksMoMw==
X-CSE-MsgGUID: sw2ZDgwASzOxocMvNIHdNA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.08,213,1712646000"; d="scan'208";a="37621308"
Received: from fmsmsx602.amr.corp.intel.com ([10.18.126.82])
 by orviesa006.jf.intel.com with ESMTP/TLS/AES256-GCM-SHA384;
 04 Jun 2024 00:51:12 -0700
Received: from fmsmsx612.amr.corp.intel.com (10.18.126.92) by
 fmsmsx602.amr.corp.intel.com (10.18.126.82) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.39; Tue, 4 Jun 2024 00:51:11 -0700
Received: from fmsmsx612.amr.corp.intel.com (10.18.126.92) by
 fmsmsx612.amr.corp.intel.com (10.18.126.92) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.39; Tue, 4 Jun 2024 00:51:11 -0700
Received: from FMSEDG603.ED.cps.intel.com (10.1.192.133) by
 fmsmsx612.amr.corp.intel.com (10.18.126.92) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.39 via Frontend Transport; Tue, 4 Jun 2024 00:51:11 -0700
Received: from NAM11-CO1-obe.outbound.protection.outlook.com (104.47.56.169)
 by edgegateway.intel.com (192.55.55.68) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.39; Tue, 4 Jun 2024 00:51:10 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=gXEy99q/LYrRiXwznLxuO0wffXfXa4W1+2TKqlOsScNH18GDgJOkX3J8ZjaxbXDNuuDn9RGx9BnDCdtYrGwAkZ22cT8F25dQ+3V8WuzL+NssvWSnshMiJnbJ9cQIzqabMZ27hkbfKm5OnMGlJwFjnvz4wGxMpnWLOR9BCVYut7iUcxXuyYqR9B7uD9yK9bUYGpR4tbafpa3BvlkxjAKYIGQE0yRKv8hHhQr+LTxwkrtMpy0O+vml49jgbWuoZFyTEoh01Aer2z2SXr6hIC6VpeXX/Ig2ldSQOv19uc07lL2/S8DlbiKxWuyo/vuszwb5G2aM4VxuoQXyrlYkQDKyNA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=YNUbrXoKMEI+rLkkEw6toH++HAIzW/2TnsA/EoFwUMo=;
 b=OrlaE2UHvFOMMh6G5qtAA03234vDt8AhahRlGlCq4EYxFgueqVoQo5h7+cyakQEeVnL9gvjwrDZckNv0gdVn3Dk7hRNqftWmHm+8D4T8waugi7LMmMCgGxeiRvSKijN+fC7J0ON6j9XBb8QQWb90cXO8XYbseg1nOghzMKYbS5Wfb6wx2lQ2jug2Tvl5H0aTiWxind2ur/s47WL40+HLHjsQbsplLrLPwJGaZX/4NWAZNtq9csljscXuDcq7jMmkUL95KxDDDCNjgWWoDAD6HUDKDsSK2yrLfXQG90stPkzfHl+O03QkgoOSr1SPjg+v/XV9aVInNQtDaLairhk3QQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Received: from SJ0PR11MB6744.namprd11.prod.outlook.com (2603:10b6:a03:47d::10)
 by IA1PR11MB7918.namprd11.prod.outlook.com (2603:10b6:208:3ff::8)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7633.24; Tue, 4 Jun
 2024 07:51:03 +0000
Received: from SJ0PR11MB6744.namprd11.prod.outlook.com
 ([fe80::fe49:d628:48b1:6091]) by SJ0PR11MB6744.namprd11.prod.outlook.com
 ([fe80::fe49:d628:48b1:6091%7]) with mapi id 15.20.7633.021; Tue, 4 Jun 2024
 07:51:02 +0000
From: "Duan, Zhenzhong" <zhenzhong.duan@intel.com>
To: "eric.auger@redhat.com" <eric.auger@redhat.com>, "qemu-devel@nongnu.org"
 <qemu-devel@nongnu.org>
CC: "alex.williamson@redhat.com" <alex.williamson@redhat.com>,
 "clg@redhat.com" <clg@redhat.com>, "mst@redhat.com" <mst@redhat.com>,
 "peterx@redhat.com" <peterx@redhat.com>, "jasowang@redhat.com"
 <jasowang@redhat.com>, "jgg@nvidia.com" <jgg@nvidia.com>,
 "nicolinc@nvidia.com" <nicolinc@nvidia.com>, "joao.m.martins@oracle.com"
 <joao.m.martins@oracle.com>, "clement.mathieu--drif@eviden.com"
 <clement.mathieu--drif@eviden.com>, "Tian, Kevin" <kevin.tian@intel.com>,
 "Liu, Yi L" <yi.l.liu@intel.com>, "Peng, Chao P" <chao.p.peng@intel.com>,
 Marcel Apfelbaum <marcel.apfelbaum@gmail.com>
Subject: RE: [PATCH v6 09/19] vfio/iommufd: Implement
 HostIOMMUDeviceClass::realize() handler
Thread-Topic: [PATCH v6 09/19] vfio/iommufd: Implement
 HostIOMMUDeviceClass::realize() handler
Thread-Index: AQHatX026AiY+etA/U+I5iKUsGNWX7G16AIAgAEAAYCAAE9NAIAAAqHg
Date: Tue, 4 Jun 2024 07:51:02 +0000
Message-ID: <SJ0PR11MB67449D7B5FFAB6104F050D9092F82@SJ0PR11MB6744.namprd11.prod.outlook.com>
References: <20240603061023.269738-1-zhenzhong.duan@intel.com>
 <20240603061023.269738-10-zhenzhong.duan@intel.com>
 <e20c3fce-5a5a-4efb-9383-9ed7c9c6ef32@redhat.com>
 <SJ0PR11MB67441F9E6629728ABBF7655092F82@SJ0PR11MB6744.namprd11.prod.outlook.com>
 <999a8b13-61e9-4c5d-a02b-a608487f7114@redhat.com>
In-Reply-To: <999a8b13-61e9-4c5d-a02b-a608487f7114@redhat.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: SJ0PR11MB6744:EE_|IA1PR11MB7918:EE_
x-ms-office365-filtering-correlation-id: 75a744a4-a589-4b65-1d39-08dc846b14b8
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
 ARA:13230031|376005|1800799015|7416005|366007|38070700009; 
x-microsoft-antispam-message-info: =?utf-8?B?R1hyTFJrYXlWSzdLSVRUWTFqTytCb2hOcW9DbC9JU3ZBWWkyVGYzZ05id085?=
 =?utf-8?B?b3dHUEs2OWRzL0djd0JkZk1hTW9ZZ1RTdXhyaTg1dnIzS0w3OStiYlJMdnEz?=
 =?utf-8?B?Yk8wV2dYVTNTMEtrVEtRb3FqOXJzY3NEYUNjOGVYUDFxa3R0MmxUZWVXMXZQ?=
 =?utf-8?B?c0VSUjV4K3VKVVk5ZkJjSnJYMS9tZyt4L2xMc3pPdlhFMHdsY3hVaG1sOHJh?=
 =?utf-8?B?WWZERlBYMGY2QnlhLzJNdTV4V3NSNjVNU2NIQlZKdytWdzRlZmJLb214WjZC?=
 =?utf-8?B?eHc5a0FyMGNicjVxNXYzS3FLZHFZR09BUzd6NHBqTTRNMzVFWTBsMHcweDd3?=
 =?utf-8?B?azZxVUVDbHNDQmNSVDdkSnhBNU1TMm9lbkRLZVcvbHVoYVJIQXREcndzNjZ0?=
 =?utf-8?B?SHNpaFNDK2xlbHBCREpZVnduazlJc1dlSVNqME1OcWE5NURtQkxvVHArdlZ6?=
 =?utf-8?B?NHVkcThOTDR2UVVxMEZDblJMb3RKekxYSTF3dDJra3Arc3Y0akZKUTdGZGp1?=
 =?utf-8?B?SThndDIvMUxUTEhaVTR2QkJyNHp6TlFGdUJnVEJlNkY0ZUFoZmhXZzE2RWp4?=
 =?utf-8?B?NmxEazRtamNZVm5LeVJad2dDMDFXZFl0VlloaWl2TTBFcm44cGI5WExTS0Vr?=
 =?utf-8?B?ayt3QStaV1I3Nm9HSFZQWEtnTDhXVGh0WjU3blhMV0NKVEltVys0MkVDK1J4?=
 =?utf-8?B?QVBHOEt5UlpUSE9qU0p6MStzSUJBWmFxRDVmbkh5YVRiZ3pYTTlTRm1aUC9E?=
 =?utf-8?B?OWRVYXUrcW5wMTA0RW5RS3hEc1FDcE9ycEZ2VjR1SGNzZTFoU1lBckR3eEpn?=
 =?utf-8?B?WmpWMEhlZHByZVZOeS9EMENpNWJUNFZhQ2p2Tkl3WFVJaDJwaTgyLzBBY3lO?=
 =?utf-8?B?alpqZ0xBRWFBTFpTSkhNYktzQVRyMCtiY1ZJWm4xMDhPUXpUdWkzY0tiRXZa?=
 =?utf-8?B?bUplY1dEUjZEUlVLNkZUVU5LcEs0MDQxcGFUSVpyaUtTdjgyRXZqTEg4cnRD?=
 =?utf-8?B?ak0vSXIreHBZVW0zMWsrLzdlOTRaWkhPZWdOOVhmb0xTNjRVcWRlNEJheDln?=
 =?utf-8?B?YjlHR2VjczJGZXdtMHJGSDZTRk5GQlltSFB3YXcwNElidy9NRDJ5WkM3OFV3?=
 =?utf-8?B?Um1CV2NsVVIvRVNta054WDNFMmZVMC80YU5TQlRCbEQ2b1lXM1JNUUFYV1Ay?=
 =?utf-8?B?djl6M2JiMmRqd3l6aVNhVUNWRzJybVVBdEI3aUNwSXpodFpOdmZqeGlMZFNQ?=
 =?utf-8?B?TWYxMUttd1ptVU03R2hIMHIxTnU1czdMUk4wY1lVeUxSaHVHODA1RXRpVHJN?=
 =?utf-8?B?Vk9oYXRNdm5UZHpPK2o5M2VOcWhjWmEyQjQ2bWJKVTEwcVR6TUszUWZHQ1dz?=
 =?utf-8?B?ZFdFWThmRGN2V1ZaYlhoeFJJcWxLUWpseUpTYUtacmNTdU4yd2lLa3htcHdU?=
 =?utf-8?B?V2xQUVBhSGdxMXc3eVVjVWw2UVhZMVMxNlBVbk1vZkI3UXFXYmltNndjam1T?=
 =?utf-8?B?SGJuanlnQjVuYm1tREVTWG91UXFzc1IxZnBROFN3djI4K0tjU1JUQlM0M0pB?=
 =?utf-8?B?NWp4RWVsSTZ4RitQajZVMktraGRMSk96M2dBK29oR0MvT0RXTXdSa3p0Nksx?=
 =?utf-8?B?anpRUy8weWgyZmYzWFkvelFHdTFjbmVGYXcyRmlaZ2p1UUlMeUdNWE9wc21S?=
 =?utf-8?B?TGNISmVKYms3RjFvaFJaa2VqQVlUT1lHbEljVzRTRnFyeGQyMFc2anFYUXVD?=
 =?utf-8?B?Z1c5ZnNXNFQ4UlVsYkpoYS9yclJES2ZWNXF0MUpkRkFRMURQNEJyTXZ1UVpm?=
 =?utf-8?B?VG5QUzU0OWhFN01wRUtVdz09?=
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:SJ0PR11MB6744.namprd11.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230031)(376005)(1800799015)(7416005)(366007)(38070700009); DIR:OUT;
 SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?SVhxK25YOWFvZlhPb256Q0dNd0tLY0VkbUlPOXdyMWJyNS9KN1VVdW56Y1hs?=
 =?utf-8?B?Z1JGRER5UDdiS3lBem8xQjZRbUs0TW9hRnliMWJWN08zaUE0U3JHc3JvRzJN?=
 =?utf-8?B?cXcwMkV5dVduVjRMSXpFTnRxejJPRmhFUVpjYW5oK1JtQ1g2WWdWMXp1dGl3?=
 =?utf-8?B?UG9UQ29VN3o3UVlTbkhIZVNXdlRlWGFoWVdUbWFlVnFidGw2dDV1NGV5MWRn?=
 =?utf-8?B?OUFvSGdmWENsOEkydHp4RjdMVldHUmxwYnE2aVZNa2ExR1NvTDJFVUJuakZi?=
 =?utf-8?B?dndsaDV3Sks1bHY5Ny9udXJaa1YrWEF0SkV3TkNaK3JjM09LcWhoVndsaDFE?=
 =?utf-8?B?UnJzcFlDYWIzd2tVQWFjUnF1aGRnRVptakhSUWFmVGVGUVJaYVR6aTcrelRK?=
 =?utf-8?B?alkxalZyWUhXTDdHRlZ2Y3ZZclUwQlIreFJITitmYzZMMlVjaFBKTVVIcjBR?=
 =?utf-8?B?cUdHM2FFU2NJZ05WQ3ZuUi9ud0s0S25DNkhoeDc1b1kwSlhXSDhNUEs4Q3kx?=
 =?utf-8?B?dVFkTGhtVjl1YjlKc0RYdlpmYU9oQkZpS0ZnTVoxYnFuM3hYZUdGRklRRUlm?=
 =?utf-8?B?eGgyY0NZR3A0QUMyZ1hwcGptMEorT09CdUwvaXhSS2MwdmVYVGY1TitsWmxL?=
 =?utf-8?B?bUEzMzlRbk1tc1l1b1NDWUR5QTdQNTRDb2dlbXNBWGVHdDB3N3JKVnlDOVlH?=
 =?utf-8?B?aHJaT3FuNW15bllUL04zQ20vT2hPZVpZcHZkbUFLVkxQZ3VjTU44QldkN3hV?=
 =?utf-8?B?cDF4Y3VESHRYVXBBR3A1U1hVT2JKaEZHOHpqTTJ0ZnFoMXI1ZGEzNFpIZlFz?=
 =?utf-8?B?b1dRRjVWMmFHNy9ja2FSS0hWQ1Rka2pFaDZGNkN3Q2F1UnVqYXNGT0JkeHZa?=
 =?utf-8?B?dzk1Um11VTJCODZHdTdDM3VKZFdRcnErM01Ndk1xQXZzeXduNGxoSDhmMHI3?=
 =?utf-8?B?Y1dJT1E2ekFQbm15NjRkZkQrUmUxeks5TmdhZlRzdFhCUC9mVXB4YXJxMGhs?=
 =?utf-8?B?RFp4N09CV2FveVhiYVNwT0FDQkR4V2p0NzMzQU5UdXNRZHBZVlk3cFB5NlI4?=
 =?utf-8?B?cnBTdTFaOTFIME1KTDZFYTZjWXdFZnFPK054VVE5aHFudmVUb3FSbkx6R2Iy?=
 =?utf-8?B?VldFajN3SzNRZEZrVnlrQnhPalhyQ2RsTWNXOHVUOFlzU0hjUFUzRm5HS2xl?=
 =?utf-8?B?RWM3cWZ6Mnc0MEZUczFGYXo4TDFHdHVnWW5ocjdlRkdKdUVaejRWaGFTMkMx?=
 =?utf-8?B?TnBJQ3ptdmJuZ21qV0hkUEVUR256ZjZwdlRvQ3pFT2FBZTZIRERscm1LclIw?=
 =?utf-8?B?a0F1WldrY2drWXBONjl4SEV2RGRvSlNlSEdRT2ZJd3FaMHB2RDdjQkNuOU5v?=
 =?utf-8?B?NGk4VHViMUM0VDVmQkljcXA5Qm9wUGVUaFEwS2p0ZDJoeDYwN0lPTW54YmJo?=
 =?utf-8?B?eVJybi9TbXpFQ09uNlp1K2VVV3Q4QndCTERLV3JwRXp1emJXZkdaMjNSblA1?=
 =?utf-8?B?QllkaG9idkZLNitGb2M2aHc0OW1OVFYxL3E3WTNvV2pQaDBMVk16ZG15NmlE?=
 =?utf-8?B?T0diWVE4aHBXeFZHQnJGd3gxREx4VzY1bE10ZHo1Y20yL3ExWFZNUGliTGUw?=
 =?utf-8?B?cXJVNWF5ci9rWm9uUHNZU2kvclZlN2x6UzhRRG5XRUtFbTdmeGduWTA1YnF5?=
 =?utf-8?B?M2d2UWxXRU1GVEpQYkpGNWNsTXJLZTJBcEVnd0xVb0tDUHpNa2ZlNU9lNVpZ?=
 =?utf-8?B?VU52TG4wMjNVUHIvdXlqRzlOVG10cnNpelZEVGdrWTdaM3NBdUh6MElEVDJR?=
 =?utf-8?B?WTQ0K3ExNTYyNTkzTVRjaVRWTkpMV3FXRzUybGMxblFad2ZDWFRLMTZlS0wr?=
 =?utf-8?B?OWE3RWdXK3c4SEdXSnlORHE3Unp2R1laN3VtZ2Z0K01JOVdSU0QzR3ZoV2R0?=
 =?utf-8?B?T0h3bDNLbnJuclRyWWpmK0YwWnFxdWJSVlBXd0pSbVh5VW5TdVNacnA2TWpC?=
 =?utf-8?B?Vy8zNVp2MHczRSs1NXoxTk1qbjNHK3VFQlA5NmZSelBHZGhVZWs3S1U4Q0VG?=
 =?utf-8?B?bVVsR0dVSlZTZ3ppMUlneFgvdVlJWVlDUFduYkhyYWlVZ2xYZGNFNFltckZy?=
 =?utf-8?Q?n3qll4mF/o3hEK5y4uL5yir0h?=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: SJ0PR11MB6744.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 75a744a4-a589-4b65-1d39-08dc846b14b8
X-MS-Exchange-CrossTenant-originalarrivaltime: 04 Jun 2024 07:51:02.3585 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: BVFuzmJQkV8TnaM6bLLziH4PQggEYFxdYxscMPfTHHSyE9a6XNGewnvEcmBtIPs/51S4atKFkI4qYnNoe//9wtMWbchP3KDdFMEULv6Jfzs=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA1PR11MB7918
X-OriginatorOrg: intel.com
Received-SPF: pass client-ip=198.175.65.13;
 envelope-from=zhenzhong.duan@intel.com; helo=mgamail.intel.com
X-Spam_score_int: -43
X-Spam_score: -4.4
X-Spam_bar: ----
X-Spam_report: (-4.4 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
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

DQoNCj4tLS0tLU9yaWdpbmFsIE1lc3NhZ2UtLS0tLQ0KPkZyb206IEVyaWMgQXVnZXIgPGVyaWMu
YXVnZXJAcmVkaGF0LmNvbT4NCj5TdWJqZWN0OiBSZTogW1BBVENIIHY2IDA5LzE5XSB2ZmlvL2lv
bW11ZmQ6IEltcGxlbWVudA0KPkhvc3RJT01NVURldmljZUNsYXNzOjpyZWFsaXplKCkgaGFuZGxl
cg0KPg0KPg0KPg0KPk9uIDYvNC8yNCAwNDo1OCwgRHVhbiwgWmhlbnpob25nIHdyb3RlOg0KPj4N
Cj4+PiAtLS0tLU9yaWdpbmFsIE1lc3NhZ2UtLS0tLQ0KPj4+IEZyb206IEVyaWMgQXVnZXIgPGVy
aWMuYXVnZXJAcmVkaGF0LmNvbT4NCj4+PiBTdWJqZWN0OiBSZTogW1BBVENIIHY2IDA5LzE5XSB2
ZmlvL2lvbW11ZmQ6IEltcGxlbWVudA0KPj4+IEhvc3RJT01NVURldmljZUNsYXNzOjpyZWFsaXpl
KCkgaGFuZGxlcg0KPj4+DQo+Pj4gSGkgWmhlbnpob25nLA0KPj4+DQo+Pj4gT24gNi8zLzI0IDA4
OjEwLCBaaGVuemhvbmcgRHVhbiB3cm90ZToNCj4+Pj4gSXQgY2FsbHMgaW9tbXVmZF9iYWNrZW5k
X2dldF9kZXZpY2VfaW5mbygpIHRvIGdldCBob3N0IElPTU1VDQo+Pj4+IHJlbGF0ZWQgaW5mb3Jt
YXRpb24gYW5kIHRyYW5zbGF0ZSBpdCBpbnRvIEhvc3RJT01NVURldmljZUNhcHMNCj4+Pj4gZm9y
IHF1ZXJ5IHdpdGggLmdldF9jYXAoKS4NCj4+Pj4NCj4+Pj4gSW50cm9kdWNlIG1hY3JvIFZURF9N
R0FXX0ZST01fQ0FQIHRvIGdldCBNR0FXIHdoaWNoIGVxdWFscw0KPnRvDQo+Pj4+IChhd19iaXRz
IC0gMSkuDQo+Pj4+DQo+Pj4+IFNpZ25lZC1vZmYtYnk6IFpoZW56aG9uZyBEdWFuIDx6aGVuemhv
bmcuZHVhbkBpbnRlbC5jb20+DQo+Pj4+IC0tLQ0KPj4+PiAgaW5jbHVkZS9ody9pMzg2L2ludGVs
X2lvbW11LmggfCAgMSArDQo+Pj4+ICBody92ZmlvL2lvbW11ZmQuYyAgICAgICAgICAgICB8IDM3
DQo+Pj4gKysrKysrKysrKysrKysrKysrKysrKysrKysrKysrKysrKysNCj4+Pj4gIDIgZmlsZXMg
Y2hhbmdlZCwgMzggaW5zZXJ0aW9ucygrKQ0KPj4+Pg0KPj4+PiBkaWZmIC0tZ2l0IGEvaW5jbHVk
ZS9ody9pMzg2L2ludGVsX2lvbW11LmgNCj4+PiBiL2luY2x1ZGUvaHcvaTM4Ni9pbnRlbF9pb21t
dS5oDQo+Pj4+IGluZGV4IDdmYTBhNjk1YzguLjdkNjk0YjA4MTMgMTAwNjQ0DQo+Pj4+IC0tLSBh
L2luY2x1ZGUvaHcvaTM4Ni9pbnRlbF9pb21tdS5oDQo+Pj4+ICsrKyBiL2luY2x1ZGUvaHcvaTM4
Ni9pbnRlbF9pb21tdS5oDQo+Pj4+IEBAIC00Nyw2ICs0Nyw3IEBAIE9CSkVDVF9ERUNMQVJFX1NJ
TVBMRV9UWVBFKEludGVsSU9NTVVTdGF0ZSwNCj4+PiBJTlRFTF9JT01NVV9ERVZJQ0UpDQo+Pj4+
ICAjZGVmaW5lIFZURF9IT1NUX0FXXzQ4QklUICAgICAgICAgICA0OA0KPj4+PiAgI2RlZmluZSBW
VERfSE9TVF9BRERSRVNTX1dJRFRIICAgICAgVlREX0hPU1RfQVdfMzlCSVQNCj4+Pj4gICNkZWZp
bmUgVlREX0hBV19NQVNLKGF3KSAgICAgICAgICAgICgoMVVMTCA8PCAoYXcpKSAtIDEpDQo+Pj4+
ICsjZGVmaW5lIFZURF9NR0FXX0ZST01fQ0FQKGNhcCkgICAgICAoKGNhcCA+PiAxNikgJiAweDNm
VUxMKQ0KPj4+Pg0KPj4+PiAgI2RlZmluZSBETUFSX1JFUE9SVF9GX0lOVFIgICAgICAgICAgKDEp
DQo+Pj4+DQo+Pj4+IGRpZmYgLS1naXQgYS9ody92ZmlvL2lvbW11ZmQuYyBiL2h3L3ZmaW8vaW9t
bXVmZC5jDQo+Pj4+IGluZGV4IGU0YTUwN2Q1NWMuLjlkMmU5NWUyMGUgMTAwNjQ0DQo+Pj4+IC0t
LSBhL2h3L3ZmaW8vaW9tbXVmZC5jDQo+Pj4+ICsrKyBiL2h3L3ZmaW8vaW9tbXVmZC5jDQo+Pj4+
IEBAIC0yNSw2ICsyNSw3IEBADQo+Pj4+ICAjaW5jbHVkZSAicWVtdS9jdXRpbHMuaCINCj4+Pj4g
ICNpbmNsdWRlICJxZW11L2NoYXJkZXZfb3Blbi5oIg0KPj4+PiAgI2luY2x1ZGUgInBjaS5oIg0K
Pj4+PiArI2luY2x1ZGUgImh3L2kzODYvaW50ZWxfaW9tbXVfaW50ZXJuYWwuaCINCj4+Pj4NCj4+
Pj4gIHN0YXRpYyBpbnQgaW9tbXVmZF9jZGV2X21hcChjb25zdCBWRklPQ29udGFpbmVyQmFzZSAq
YmNvbnRhaW5lciwNCj4+PiBod2FkZHIgaW92YSwNCj4+Pj4gICAgICAgICAgICAgICAgICAgICAg
ICAgICAgICByYW1fYWRkcl90IHNpemUsIHZvaWQgKnZhZGRyLCBib29sIHJlYWRvbmx5KQ0KPj4+
PiBAQCAtNjE5LDYgKzYyMCw0MSBAQCBzdGF0aWMgdm9pZA0KPj4+IHZmaW9faW9tbXVfaW9tbXVm
ZF9jbGFzc19pbml0KE9iamVjdENsYXNzICprbGFzcywgdm9pZCAqZGF0YSkNCj4+Pj4gICAgICB2
aW9jLT5wY2lfaG90X3Jlc2V0ID0gaW9tbXVmZF9jZGV2X3BjaV9ob3RfcmVzZXQ7DQo+Pj4+ICB9
Ow0KPj4+Pg0KPj4+PiArc3RhdGljIGJvb2wgaGlvZF9pb21tdWZkX3ZmaW9fcmVhbGl6ZShIb3N0
SU9NTVVEZXZpY2UgKmhpb2QsIHZvaWQNCj4+PiAqb3BhcXVlLA0KPj4+PiArICAgICAgICAgICAg
ICAgICAgICAgICAgICAgICAgICAgICAgICBFcnJvciAqKmVycnApDQo+Pj4+ICt7DQo+Pj4+ICsg
ICAgVkZJT0RldmljZSAqdmRldiA9IG9wYXF1ZTsNCj4+Pj4gKyAgICBIb3N0SU9NTVVEZXZpY2VD
YXBzICpjYXBzID0gJmhpb2QtPmNhcHM7DQo+Pj4+ICsgICAgZW51bSBpb21tdV9od19pbmZvX3R5
cGUgdHlwZTsNCj4+Pj4gKyAgICB1bmlvbiB7DQo+Pj4+ICsgICAgICAgIHN0cnVjdCBpb21tdV9o
d19pbmZvX3Z0ZCB2dGQ7DQo+Pj4+ICsgICAgfSBkYXRhOw0KPj4+PiArDQo+Pj4+ICsgICAgaWYg
KCFpb21tdWZkX2JhY2tlbmRfZ2V0X2RldmljZV9pbmZvKHZkZXYtPmlvbW11ZmQsIHZkZXYtDQo+
PmRldmlkLA0KPj4+PiArICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAm
dHlwZSwgJmRhdGEsIHNpemVvZihkYXRhKSwgZXJycCkpIHsNCj4+Pj4gKyAgICAgICAgcmV0dXJu
IGZhbHNlOw0KPj4+PiArICAgIH0NCj4+Pj4gKw0KPj4+PiArICAgIGNhcHMtPnR5cGUgPSB0eXBl
Ow0KPj4+PiArDQo+Pj4+ICsgICAgc3dpdGNoICh0eXBlKSB7DQo+Pj4+ICsgICAgY2FzZSBJT01N
VV9IV19JTkZPX1RZUEVfSU5URUxfVlREOg0KPj4+PiArICAgICAgICBjYXBzLT5hd19iaXRzID0g
VlREX01HQVdfRlJPTV9DQVAoZGF0YS52dGQuY2FwX3JlZykgKyAxOw0KPj4+IFBsZWFzZSBjYW4g
eW91IHJlbWluZCBtZSBvZiB3aHkgeW91IGNhbid0IHJldXNlIHRoZSBpb3ZhX3Jhbmdlcw0KPm1l
dGhvZC4NCj4+PiBpc24ndCBpdCBnZW5lcmljIGVub3VnaD8NCj4+IFllcywgaW92YV9yYW5nZXMg
bWV0aG9kIGlzIG9ubHkgZm9yIGlvdmFfcmFuZ2VzLCB3ZSB3YW50IHRvIG1ha2UNCj4+IEhvc3RJ
T01NVURldmljZS5nZXRfY2FwKCkgYSBjb21tb24gaW50ZXJmYWNlLg0KPj4NCj4+IFdoZW4gd2Ug
d2FudCB0byBwYXNzIGlvdmFfcmFuZ2VzLCB3ZSBjYW4gYWRkDQo+SE9TVF9JT01NVV9ERVZJQ0Vf
Q0FQX0lPVkFfUkFOR0VTDQo+PiBhbmQgSG9zdElPTU1VRGV2aWNlLmlvdmFfcmFuZ2VzLg0KPg0K
PkkgcmF0aGVyIG1lYW50IHRoYXQgaW92YV9yYW5nZXMgaXMgcGFydCBvZiBWRklPQ29udGFpbmVy
QmFzZSBhbmQgeW91DQo+Y291bGQgcmV1c2UgdGhlIHRlY2huaWNzIHVzZWQgaW4gaGlvZF9sZWdh
Y3lfdmZpb19yZWFsaXplLCByZWx5aW5nIG9uIGENCj5jb21tb24gaGVscGVyIGluc3RlYWQgb2Yg
dXNpbmcNCj4NCj5WVERfTUdBV19GUk9NX0NBUChkYXRhLnZ0ZC5jYXBfcmVnKS4gRG9lc24ndCBp
dCB3b3JrPw0KR2V0IHlvdXIgcG9pbnQuDQpZZXMsIEl0IGRvZXMgd29yayBhbmQgc2hvdWxkIGhh
dmUgc2FtZSByZXN1bHQuDQpUaGF0IG1lYW5zIGlvbW11ZmQgYmFja2VuZCBzdXBwb3J0IHR3byB3
YXlzIHRvIGdldCBhd19iaXRzLg0KDQpPbmx5IHJlYXNvbiBpcyBJIGZlZWwgVlREX01HQVdfRlJP
TV9DQVAoZGF0YS52dGQuY2FwX3JlZykgaXMgYSBiaXQgc2ltcGxlcg0KYW5kIHRoZXJlIGFyZSBv
dGhlciBiaXRzIHBpY2tlZCBpbiBuZXN0aW5nIHNlcmllcywgc2VlOg0KDQogICAgY2FzZSBJT01N
VV9IV19JTkZPX1RZUEVfSU5URUxfVlREOg0KICAgICAgICBjYXBzLT5hd19iaXRzID0gVlREX01H
QVdfRlJPTV9DQVAoZGF0YS52dGQuY2FwX3JlZykgKyAxOw0KICAgICAgICBjYXBzLT5uZXN0aW5n
ID0gISEoZGF0YS52dGQuZWNhcF9yZWcgJiBWVERfRUNBUF9ORVNUKTsNCiAgICAgICAgY2Fwcy0+
ZnMxZ3AgPSAhIShkYXRhLnZ0ZC5jYXBfcmVnICYgVlREX0NBUF9GUzFHUCk7DQogICAgICAgIGNh
cHMtPmVycmF0YSA9IGRhdGEudnRkLmZsYWdzICYgSU9NTVVfSFdfSU5GT19WVERfRVJSQVRBXzc3
MjQxNV9TUFIxNzsNCg0KSSdtIGZpbmUgdG8gdXNlIGlvdmFfcmFuZ2VzIHRvIGNhbGN1bGF0ZSBh
d19iaXRzIGZvciBpb21tdWZkIGJhY2tlbmQgaWYgeW91IHByZWZlciB0aGF0Lg0KDQpUaGFua3MN
ClpoZW56aG9uZw0K

