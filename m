Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9E58FC25B74
	for <qemu-devel@archiver.kernel.org>; Tue,  4 Jun 2024 03:41:39 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sEL33-0003Rv-FP; Mon, 03 Jun 2024 23:41:21 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <zhenzhong.duan@intel.com>)
 id 1sEL32-0003Ri-4A
 for qemu-devel@nongnu.org; Mon, 03 Jun 2024 23:41:20 -0400
Received: from mgamail.intel.com ([198.175.65.21])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <zhenzhong.duan@intel.com>)
 id 1sEL2y-000252-RE
 for qemu-devel@nongnu.org; Mon, 03 Jun 2024 23:41:19 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1717472477; x=1749008477;
 h=from:to:cc:subject:date:message-id:references:
 in-reply-to:content-transfer-encoding:mime-version;
 bh=/X2T/90/vEskcupOjPX5ff0THSOdABkrvlHKCXuE5cs=;
 b=WvMPpYGbr2ZC8cPMcmH+YaMbLg1zDhEzORd41xGmTV3UsEuj1dOW7k6I
 XbFbHflk/bwWlZoOD4nZcXd0uhhBYDuZMnlBeEGYb9YTB9ELKHTXL5Aea
 3XCQK6tDHwSj+UnbLlKv7lgN6ZVbmsE7astTDdXAipwR3ZKdTFW+nnbRZ
 Gsi6Y9TN0JlT1BamJUDAa243XuXgQDTJwEFEdZ/EywOEnzQRTedZbog7A
 8K8vSJaHKuPdiD1HUoE4ODlU8VglppE/Ue8SLWET8Vz8bIaRDHeRp3hBh
 il1h7wht8NdTZLXWGiBmA31C9VmFYf5DW3oHAz/Ui1fSqilo/4NC6tPBW w==;
X-CSE-ConnectionGUID: 9GnLvkqMSseC2xIiZhwHZA==
X-CSE-MsgGUID: +eW4EmL7T8mZ5HwlrCM27A==
X-IronPort-AV: E=McAfee;i="6600,9927,11092"; a="13940200"
X-IronPort-AV: E=Sophos;i="6.08,213,1712646000"; d="scan'208";a="13940200"
Received: from fmviesa002.fm.intel.com ([10.60.135.142])
 by orvoesa113.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 03 Jun 2024 20:41:14 -0700
X-CSE-ConnectionGUID: 8rMWg2VOTOyBju8BIiJKSQ==
X-CSE-MsgGUID: FnOoRXGITvaTABOV6s+aBg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.08,213,1712646000"; d="scan'208";a="60264862"
Received: from fmsmsx602.amr.corp.intel.com ([10.18.126.82])
 by fmviesa002.fm.intel.com with ESMTP/TLS/AES256-GCM-SHA384;
 03 Jun 2024 20:41:13 -0700
Received: from fmsmsx601.amr.corp.intel.com (10.18.126.81) by
 fmsmsx602.amr.corp.intel.com (10.18.126.82) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.39; Mon, 3 Jun 2024 20:41:13 -0700
Received: from fmsedg601.ED.cps.intel.com (10.1.192.135) by
 fmsmsx601.amr.corp.intel.com (10.18.126.81) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.39 via Frontend Transport; Mon, 3 Jun 2024 20:41:13 -0700
Received: from NAM11-CO1-obe.outbound.protection.outlook.com (104.47.56.168)
 by edgegateway.intel.com (192.55.55.70) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.39; Mon, 3 Jun 2024 20:41:12 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=BYGpGC/IKizyVh5zIiIU+e/fPs+yeeW8KOwbqpeGQXKcW+ezeUbUNXVja0xCUhhUVU/xLE2yPbMq4fUqWvFKrGSiB4Q3BcHKyyXuqlouS6l5ORYW81z0RORdMKi6fc3DEgCg9IBP9tLuhJ5n3SEv8Fgp5LgspSXiDxEkIwY9GwoAusdHyrt9MGBBQvqFPIC8skj23wMHS7hcIwXEcnnSVhBECjT17Wvzfqm44dfKKWcn3d+lmT/3PitlwM8DAHsvB4V/00ePk5R08BOZrIRfKAaPK/A/rIsghIJFQ0wwobcdCknY0iKiX+E9MycyGGX76Hj+Vw9HOhC2Vmb4jxIsdw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=/X2T/90/vEskcupOjPX5ff0THSOdABkrvlHKCXuE5cs=;
 b=eBQt/mPmt4C0ZzUZL6J8hLoYInqdi15Bwdzm3bdku50BAfDIudVty3ErT2UH61b52sjopj/ua6cpngf9GFtt4Qwh+INr17nMgl/JGM8tTaT9JGBNtpp40E3zOOEad3vzWn0qh+lJsylHZbLnABGdWS8d2/hqVI7ydyKI+vNhOUvGkpI7okj/LeacTVdIu9ty/Z2v53U9qvXI6tem3TNFBQRV6ENwwOApwtCvpWCJYuU55GNejfUTlg9TIPEWtDwDAa+6NQKOm0V/KyF18scDWDH+wwXpVt5Y6tgF1KEeaQb/4aA/HcYX9l78RTBnT/lckhYYn6i+OYdO5BJcO/4CCA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Received: from SJ0PR11MB6744.namprd11.prod.outlook.com (2603:10b6:a03:47d::10)
 by DS0PR11MB6445.namprd11.prod.outlook.com (2603:10b6:8:c6::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7633.30; Tue, 4 Jun
 2024 03:41:10 +0000
Received: from SJ0PR11MB6744.namprd11.prod.outlook.com
 ([fe80::fe49:d628:48b1:6091]) by SJ0PR11MB6744.namprd11.prod.outlook.com
 ([fe80::fe49:d628:48b1:6091%7]) with mapi id 15.20.7633.021; Tue, 4 Jun 2024
 03:41:10 +0000
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
 Paolo Bonzini <pbonzini@redhat.com>
Subject: RE: [PATCH v6 01/19] backends: Introduce HostIOMMUDevice abstract
Thread-Topic: [PATCH v6 01/19] backends: Introduce HostIOMMUDevice abstract
Thread-Index: AQHatX0jqgrHzju/q0WIDks4ToP2p7G1/Q6AgAD5lKA=
Date: Tue, 4 Jun 2024 03:41:10 +0000
Message-ID: <SJ0PR11MB6744B4E79120793B23FC9C8692F82@SJ0PR11MB6744.namprd11.prod.outlook.com>
References: <20240603061023.269738-1-zhenzhong.duan@intel.com>
 <20240603061023.269738-2-zhenzhong.duan@intel.com>
 <43b7e164-9657-4368-9baa-fd83bedb2066@redhat.com>
In-Reply-To: <43b7e164-9657-4368-9baa-fd83bedb2066@redhat.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: SJ0PR11MB6744:EE_|DS0PR11MB6445:EE_
x-ms-office365-filtering-correlation-id: 656655fa-6a17-4380-e075-08dc84482cbc
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
 ARA:13230031|366007|376005|7416005|1800799015|38070700009; 
x-microsoft-antispam-message-info: =?utf-8?B?Y2dvV3JrYUNadXJ2TzllU0xuRjMwc0x2cXE4MElTdThGdEoyTTFtYTBWZ2RN?=
 =?utf-8?B?OUtaK0I1dC9zQ1dqK2VlelJuamozVFZ4bHVsdGl6VEdlNWNYSkRDQWlQYWNi?=
 =?utf-8?B?R3dpQVU0N25oNGJxYitlRzhBL1l3anN3dlBSUHUvaEE2b3FoMkxqWndLOE0v?=
 =?utf-8?B?OVdlTDlneVJZbzA5VUg3bXZQSHdlVGZFdFI1dmwwb3BzQWdGQ05GcW85aVYx?=
 =?utf-8?B?N0JtRTg0MnNPQXUrU2dQY3hUUnlVOUM3SEFFYmhPYW5LUzcrNGw1cjVrQUtt?=
 =?utf-8?B?KzVYclVzQlkzR0llTTNKdFNOckRKZWY4VXFEN2VTTmwwUWZyWU1OVEYzZVdU?=
 =?utf-8?B?L0ExTE1uMTBHbU5ldHZSV2pTRjVaSmxUUE9IbXdJUEsxdzFZNEVXWjBraFlW?=
 =?utf-8?B?M3Znb2hPM1ZSdXdzdFNYTytWN1k1Zm9uMlFLa1BiQzdlZTFQN2pYMEQ4WkZp?=
 =?utf-8?B?WmtCRkw1WXAzNFNuZzhtSm43bC9lUWU1TUNUUjFmTEhITlE5aXJrUkc3TU9D?=
 =?utf-8?B?bUcybGVEbWhtWnYrdWF2cUUvaUFDeGN1Zmlud0tJUVlPYUphZ2xyTXFNQ0lE?=
 =?utf-8?B?K1BTS3F0NHFjMGNyL2c4cEFXcXBlZzFGV1FaKy9zS3pjZ2FlZWdkVEtld1Rj?=
 =?utf-8?B?TkdydllETjFWbUIvbkV5WkZha1V4MWhGOFhoSWxSSGVxdEliUElTUTh1Umdh?=
 =?utf-8?B?YjdGelkvaTBWa3FCQjMvSUdtYnF5b1RObXBvRVdOSlU5c3ltVkp2K3dCMUYv?=
 =?utf-8?B?amdxendZOCt1NHNjWFJ0MDZtNDFTeXM3UGVjUTVGMWFaQkV5Zmx2TE1rRzhs?=
 =?utf-8?B?N0NPb2JDVHVLWFRTYzB0clFOY09xU1FzNllZVTdCc2w4WmhuWjhGTXFubjhP?=
 =?utf-8?B?Nzc5ZnhzZHV5TU8rV0kxcmZxM002SVlyZGxOSGxLSU5rd3Bza3gwWm1qdXlH?=
 =?utf-8?B?SzV0OHVTQU9MYmNuQUN4dHJCditxMEZPb0o2UFlrL3pkMmxZTzlVZ3ZrMzI4?=
 =?utf-8?B?RzZIaTRvNVgycU4rZFVucXZENWpIRmMzSEsxQU4wUUtrbHFMUU1ZMUpTWUVs?=
 =?utf-8?B?YWYrOHVQOThuVXpST1J6YXU4Y1NnVDYzQ0MxSnkycFFyaVJxY29VRGNBM3Fj?=
 =?utf-8?B?ZGNybFA3SWRNR2k5RllmMXJLVWNGQTU1eWZ6UGdjUExEUHBCOG81Y0tFeW9P?=
 =?utf-8?B?YXZnbDFremFCcXFHR0htSnZzTzRIcWczWTdZNmk2TDhMRFNjK3FaMUF3V2xy?=
 =?utf-8?B?eVc5a1VQWXFtQk4yVmo5d3hwNGZnWXAwVHFEMWJTTWhQcnJ3WnNvMmhzT2Jh?=
 =?utf-8?B?bk4xeUpvL2VkNUNpSlFMQWFVMzN5STlvbmhwa2hxTmlXT1l5Zno2S25uZE1F?=
 =?utf-8?B?QlJrNnZMYkpRZmo1NFF3bGdpcTVwY3kyd3I2UW5ua1AycC9zK3RwcDhFa1kr?=
 =?utf-8?B?bDhGN2FPMHFOY3Y4RzkvTXVlcXVXVnIreWhUbW9zbFh2MUtjMUdlbC9icWlY?=
 =?utf-8?B?SHR2d3RIbVBmSUZTUDdUS09KaTFidGd6allXb1g5SE5pem9CS2VMcjhkRWVr?=
 =?utf-8?B?UjFKS0VFSXRIeUdqRWwwWGtjbWFXNHcxclFWUW1FZk5pcHlhRm9vY2ZTWXE3?=
 =?utf-8?B?ZzVra3FGWHBWNlE2UlVXbEdJQUYzMGxxWW9lQkF5L0lISlJYN0UrWmRLZ3Nt?=
 =?utf-8?B?bVhPcDRCMGI4RVIyVTFxNGxXenhBN2YwcWtvaGV4S1JkM2FxamIyeEltNjA4?=
 =?utf-8?B?UTlZcGxPK0UrMEJkTVR2anNKMG1MNThKTXE2MEZ6NjJ2V0J2WFJyRkNMT01U?=
 =?utf-8?Q?39v13doplBmrFAu6r5x3fHgBWhafWjsB3GtYg=3D?=
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:SJ0PR11MB6744.namprd11.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230031)(366007)(376005)(7416005)(1800799015)(38070700009); DIR:OUT;
 SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?MXBhcFJmZXJ6OVg4cEdpZjh6WnhMU1lvVG91eGFVK01QWFN6YzVHNVVZUHZv?=
 =?utf-8?B?L2VOMXZpUkd5UGlvb2JzK2JjMW93T0Fua0ZycVNKN3RIKytHUjEzaUFCcnZl?=
 =?utf-8?B?VkFuZTRLUDFzaVFLZXI5SG9VeXNIVVlkSkZQZUROSDZaUjRnVGlDZkFVSFNi?=
 =?utf-8?B?T2JjQzhCSmF0bFoxeEhNUDFSQy9hN25mQTNpYVE3a2ZrVzNOOVdWdUNxVU1S?=
 =?utf-8?B?KzBYQ2l2dVl3aWJKQ21ZQkJGVzNIaHFuSWNNMC9xSFRZejJ0Zkc2YjUxYThS?=
 =?utf-8?B?VjArY3BEZGVsOG1rSmNkcjFvNzRZM2YzU1FxTGFiUFdXdmMrYjlPTlZDS0dQ?=
 =?utf-8?B?aUxaZjBGcGQzWWdlRWQ5VFNqTWQ5YjRaM3ZHSGV0akdRYlZnYU4rdHdkWGpk?=
 =?utf-8?B?WW8xa2R4Y2xudE05emxiOFlaeG5aQUE1a1drTFgyTUFFWnNiWXVkSHBWTlJM?=
 =?utf-8?B?MDNEQVZPL1ZXblFlS0lxb3E2VFdyVjRqbWE3d3lheEZkcWc5SjU2RjA0cG5N?=
 =?utf-8?B?ZmJ5TTlpa3NMRUFVeTU0V3FNRllVcEdEWmljVSszTE4vWkFzcjQ0TUxySFZ6?=
 =?utf-8?B?Z2dJV2VRWlk3N0liMC9zS3NGMlk0NEoxeDdJeStRdTkvQXFFV1pQVWlLQWRY?=
 =?utf-8?B?VWZZK0NnSnJqbnhRSkNRZm05UjFGc3V1anZLUHd0ck1aeFJBNkVIYTdKajJK?=
 =?utf-8?B?ZytMbWlvc2crT1FpMzdiYUZDL0ExZzFva3JmeHB3LzFRY1FxTmI3SHd0bm5J?=
 =?utf-8?B?M3J4NHUyRVd1K0syVGsyNGpKMitkb1A1bTk0ajYyR1IrUjZtWEEvczdXSVBT?=
 =?utf-8?B?RitQcVdzZ21XTzlHSDd1WGZKQTk0L05FQUJkUDJteVhFSXM5b3dBaUhmZ0I1?=
 =?utf-8?B?UmJuOW9nZ3FHbTRpUGV4T2E5alhQekxEUE5NU1VzeEg2dFlVb1UxVmRyMnF0?=
 =?utf-8?B?aHFjU3NBbFdyc1FBZU9VOHc5TnpmNk43UU9PUE45K3EvOC9sSzQrY2RtcWYr?=
 =?utf-8?B?ZzhjWGZYbFRiaTU4eVl5cUx2K1J4c1VlZmZaWGYwTUNydndzYVAyR3ZjOVBz?=
 =?utf-8?B?L0tEdlZMM0tUSWdiZVhQQWxpVDFNcjhUYktWRW1jcUtJQXdBZ2JTQTdyWUZn?=
 =?utf-8?B?RGFMYUt4dU5WL0JoWDhmSnFGL3JYVWVoUXZTQlRMMmlEdW1NQlZnMTVVN2N4?=
 =?utf-8?B?NmVPWmVlK0VlaG85bkkwbWxwU1BQYlpMR3NqQjZkMUQwU0JKNzZ0UDNaeHN3?=
 =?utf-8?B?dE9uVHNPVzJIQVhRL0doVnZRanN1VThiZkI5VVB5czFWNlNycjlxZndPdUQr?=
 =?utf-8?B?cG5ZZ1lVQTJWd2JGS0NGaitLZE41NkcxK3ZlcVNabjFnOVk4R2VncEhyRTNj?=
 =?utf-8?B?NFM1UHlOZzRoQ3hydE9ORXkrbWZSTHpWR1d4aXUwWjg0a2doV1c2dGJGb2pw?=
 =?utf-8?B?MjJXUWEyNXhGWHRzOFlpaThNUE9IMHNXejg4YU42Skx0eDViOFg5TXlNOHRS?=
 =?utf-8?B?cHQybWJxVzVzNGhLYzZtKzBON0pxcEQvbzRlVUs2SFB2ZVFRbVFSTDRWeDky?=
 =?utf-8?B?STUvZ3h0ZXRiWWxhWXZtRG94U0g2dWp0MVFGNHJRek1rK3BxM0FRcDMycjla?=
 =?utf-8?B?a0VYeU9jL0Vpajh5endkRlpzTmRKY0NPZU5seDNYbkFhVGs0a3Y5a2lzQnAy?=
 =?utf-8?B?OENLbTB3cnQzTXExODNRd2ZWdXZSM3l0ajkyYmxNdHpoY2lnYzVuWDBaMW5Q?=
 =?utf-8?B?amd2bDRScUZ2VU5neDM0V2FMNnZTRCs0Y0JRSG03NEMrZDBHMVlPQ3hxNTNj?=
 =?utf-8?B?b0JpZXJibCt1aDYrZDJSTm54S2xBZjUxWkhMaXdUNGNVVlV0OWF5NTlvVjV5?=
 =?utf-8?B?ck9QNlFUSU8rL3ZIQXFwcURDWEFFeFFKTk56dVdJd29mY0JGRWVXbWRROXFT?=
 =?utf-8?B?WUdONU4yVjRkbmdjTTRBcVVDQjF1WDJEMm1ETkhkNTV3RjIwVHV6TndraXVm?=
 =?utf-8?B?NVl1M1N4ME9IUVhXbDNpSTJ6QytRN3RDRTZyZWVQc0V0cHEwSU11b3VPdE9v?=
 =?utf-8?B?N0JjakJEOUFUcmdEemM1a3h4ZU4vb2NqckE1SkdNc28rWnE3R2E0WTJiakNO?=
 =?utf-8?Q?vUhnEcnPdy9VcKJ5QMBlgA7x1?=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: SJ0PR11MB6744.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 656655fa-6a17-4380-e075-08dc84482cbc
X-MS-Exchange-CrossTenant-originalarrivaltime: 04 Jun 2024 03:41:10.2644 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: Jr0ywux3s8e2iT1l5mn2lwPUGriy2zw30jzrZeFeh5b8DzZiFEavCXSNbOXVlGOPRGYfHz1UnYE7jyRSI7qUz/Lq0fYIWoU2cJrPO1uN/vg=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS0PR11MB6445
X-OriginatorOrg: intel.com
Received-SPF: pass client-ip=198.175.65.21;
 envelope-from=zhenzhong.duan@intel.com; helo=mgamail.intel.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
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

DQoNCj4tLS0tLU9yaWdpbmFsIE1lc3NhZ2UtLS0tLQ0KPkZyb206IEVyaWMgQXVnZXIgPGVyaWMu
YXVnZXJAcmVkaGF0LmNvbT4NCj5TdWJqZWN0OiBSZTogW1BBVENIIHY2IDAxLzE5XSBiYWNrZW5k
czogSW50cm9kdWNlIEhvc3RJT01NVURldmljZQ0KPmFic3RyYWN0DQo+DQo+DQo+DQo+T24gNi8z
LzI0IDA4OjEwLCBaaGVuemhvbmcgRHVhbiB3cm90ZToNCj4+IEludHJvZHVjZSBIb3N0SU9NTVVE
ZXZpY2UgYXMgYW4gYWJzdHJhY3Rpb24gb2YgaG9zdCBJT01NVSBkZXZpY2UuDQo+Pg0KPj4gSW50
cm9kdWNlIC5yZWFsaXplKCkgdG8gaW5pdGlhbGl6ZSBIb3N0SU9NTVVEZXZpY2UgZnVydGhlciBh
ZnRlcg0KPj4gaW5zdGFuY2UgaW5pdC4NCj4+DQo+PiBJbnRyb2R1Y2UgYSBtYWNybyBDT05GSUdf
SE9TVF9JT01NVV9ERVZJQ0UgdG8gZGVmaW5lIHRoZSB1c2FnZQ0KPj4gZm9yIFZGSU8sIGFuZCBW
RFBBIGluIHRoZSBmdXR1cmUuDQo+Pg0KPj4gU3VnZ2VzdGVkLWJ5OiBDw6lkcmljIExlIEdvYXRl
ciA8Y2xnQHJlZGhhdC5jb20+DQo+PiBTaWduZWQtb2ZmLWJ5OiBaaGVuemhvbmcgRHVhbiA8emhl
bnpob25nLmR1YW5AaW50ZWwuY29tPg0KPj4gLS0tDQo+PiAgTUFJTlRBSU5FUlMgICAgICAgICAg
ICAgICAgICAgICAgICB8ICAyICsrDQo+PiAgaW5jbHVkZS9zeXNlbXUvaG9zdF9pb21tdV9kZXZp
Y2UuaCB8IDUxDQo+KysrKysrKysrKysrKysrKysrKysrKysrKysrKysrDQo+PiAgYmFja2VuZHMv
aG9zdF9pb21tdV9kZXZpY2UuYyAgICAgICB8IDMwICsrKysrKysrKysrKysrKysrKw0KPj4gIGJh
Y2tlbmRzL0tjb25maWcgICAgICAgICAgICAgICAgICAgfCAgNSArKysNCj4+ICBiYWNrZW5kcy9t
ZXNvbi5idWlsZCAgICAgICAgICAgICAgIHwgIDEgKw0KPj4gIDUgZmlsZXMgY2hhbmdlZCwgODkg
aW5zZXJ0aW9ucygrKQ0KPj4gIGNyZWF0ZSBtb2RlIDEwMDY0NCBpbmNsdWRlL3N5c2VtdS9ob3N0
X2lvbW11X2RldmljZS5oDQo+PiAgY3JlYXRlIG1vZGUgMTAwNjQ0IGJhY2tlbmRzL2hvc3RfaW9t
bXVfZGV2aWNlLmMNCj4+DQo+PiBkaWZmIC0tZ2l0IGEvTUFJTlRBSU5FUlMgYi9NQUlOVEFJTkVS
Uw0KPj4gaW5kZXggNDQ4ZGM5NTFjNS4uMWNmMmIyNWJlYiAxMDA2NDQNCj4+IC0tLSBhL01BSU5U
QUlORVJTDQo+PiArKysgYi9NQUlOVEFJTkVSUw0KPj4gQEAgLTIxOTYsNiArMjE5Niw4IEBAIE06
IFpoZW56aG9uZyBEdWFuDQo+PHpoZW56aG9uZy5kdWFuQGludGVsLmNvbT4NCj4+ICBTOiBTdXBw
b3J0ZWQNCj4+ICBGOiBiYWNrZW5kcy9pb21tdWZkLmMNCj4+ICBGOiBpbmNsdWRlL3N5c2VtdS9p
b21tdWZkLmgNCj4+ICtGOiBiYWNrZW5kcy9ob3N0X2lvbW11X2RldmljZS5jDQo+PiArRjogaW5j
bHVkZS9zeXNlbXUvaG9zdF9pb21tdV9kZXZpY2UuaA0KPj4gIEY6IGluY2x1ZGUvcWVtdS9jaGFy
ZGV2X29wZW4uaA0KPj4gIEY6IHV0aWwvY2hhcmRldl9vcGVuLmMNCj4+ICBGOiBkb2NzL2RldmVs
L3ZmaW8taW9tbXVmZC5yc3QNCj4+IGRpZmYgLS1naXQgYS9pbmNsdWRlL3N5c2VtdS9ob3N0X2lv
bW11X2RldmljZS5oDQo+Yi9pbmNsdWRlL3N5c2VtdS9ob3N0X2lvbW11X2RldmljZS5oDQo+PiBu
ZXcgZmlsZSBtb2RlIDEwMDY0NA0KPj4gaW5kZXggMDAwMDAwMDAwMC4uMmI1OGE5NGQ2Mg0KPj4g
LS0tIC9kZXYvbnVsbA0KPj4gKysrIGIvaW5jbHVkZS9zeXNlbXUvaG9zdF9pb21tdV9kZXZpY2Uu
aA0KPj4gQEAgLTAsMCArMSw1MSBAQA0KPj4gKy8qDQo+PiArICogSG9zdCBJT01NVSBkZXZpY2Ug
YWJzdHJhY3QgZGVjbGFyYXRpb24NCj4+ICsgKg0KPj4gKyAqIENvcHlyaWdodCAoQykgMjAyNCBJ
bnRlbCBDb3Jwb3JhdGlvbi4NCj4+ICsgKg0KPj4gKyAqIEF1dGhvcnM6IFpoZW56aG9uZyBEdWFu
IDx6aGVuemhvbmcuZHVhbkBpbnRlbC5jb20+DQo+PiArICoNCj4+ICsgKiBUaGlzIHdvcmsgaXMg
bGljZW5zZWQgdW5kZXIgdGhlIHRlcm1zIG9mIHRoZSBHTlUgR1BMLCB2ZXJzaW9uIDIuICBTZWUN
Cj4+ICsgKiB0aGUgQ09QWUlORyBmaWxlIGluIHRoZSB0b3AtbGV2ZWwgZGlyZWN0b3J5Lg0KPj4g
KyAqLw0KPj4gKw0KPj4gKyNpZm5kZWYgSE9TVF9JT01NVV9ERVZJQ0VfSA0KPj4gKyNkZWZpbmUg
SE9TVF9JT01NVV9ERVZJQ0VfSA0KPj4gKw0KPj4gKyNpbmNsdWRlICJxb20vb2JqZWN0LmgiDQo+
PiArI2luY2x1ZGUgInFhcGkvZXJyb3IuaCINCj4+ICsNCj4+ICsjZGVmaW5lIFRZUEVfSE9TVF9J
T01NVV9ERVZJQ0UgImhvc3QtaW9tbXUtZGV2aWNlIg0KPj4gK09CSkVDVF9ERUNMQVJFX1RZUEUo
SG9zdElPTU1VRGV2aWNlLCBIb3N0SU9NTVVEZXZpY2VDbGFzcywNCj5IT1NUX0lPTU1VX0RFVklD
RSkNCj4+ICsNCj4+ICtzdHJ1Y3QgSG9zdElPTU1VRGV2aWNlIHsNCj4+ICsgICAgT2JqZWN0IHBh
cmVudF9vYmo7DQo+PiArfTsNCj4+ICsNCj4+ICsvKioNCj4+ICsgKiBzdHJ1Y3QgSG9zdElPTU1V
RGV2aWNlQ2xhc3MgLSBUaGUgYmFzZSBjbGFzcyBmb3IgYWxsIGhvc3QgSU9NTVUNCj5kZXZpY2Vz
Lg0KPj4gKyAqDQo+PiArICogRGlmZmVyZW50IHR5cGUgb2YgaG9zdCBkZXZpY2VzIChlLmcuLCBW
RklPIG9yIFZEUEEgZGV2aWNlKSBvciBkZXZpY2VzDQo+cy90eXBlL3R5cGVzDQpXaWxsIGZpeC4N
Cg0KPj4gKyAqIHdpdGggZGlmZmVyZW50IGJhY2tlbmQgKGUuZy4sIFZGSU8gbGVnYWN5IGNvbnRh
aW5lciBvciBJT01NVUZEDQo+YmFja2VuZCkNCj4+ICsgKiBjYW4gaGF2ZSBkaWZmZXJlbnQgc3Vi
LWNsYXNzZXMuDQo+d2lsbCBoYXZlIGRpZmZlcmVudCBpbXBsZW1lbnRhdGlvbnMgb2YgdGhlIEhv
c3RJT01NVURldmljZUNsYXNzPw0KV2lsbCBkby4NCg0KPj4gKyAqLw0KPj4gK3N0cnVjdCBIb3N0
SU9NTVVEZXZpY2VDbGFzcyB7DQo+PiArICAgIE9iamVjdENsYXNzIHBhcmVudF9jbGFzczsNCj4+
ICsNCj4+ICsgICAgLyoqDQo+PiArICAgICAqIEByZWFsaXplOiBpbml0aWFsaXplIGhvc3QgSU9N
TVUgZGV2aWNlIGluc3RhbmNlIGZ1cnRoZXIuDQo+PiArICAgICAqDQo+PiArICAgICAqIE1hbmRh
dG9yeSBjYWxsYmFjay4NCj4+ICsgICAgICoNCj4+ICsgICAgICogQGhpb2Q6IHBvaW50ZXIgdG8g
YSBob3N0IElPTU1VIGRldmljZSBpbnN0YW5jZS4NCj4+ICsgICAgICoNCj4+ICsgICAgICogQG9w
YXF1ZTogcG9pbnRlciB0byBhZ2VudCBkZXZpY2Ugb2YgdGhpcyBob3N0IElPTU1VIGRldmljZSwN
Cj4+ICsgICAgICogICAgICAgICAgaS5lLiwgZm9yIFZGSU8sIHBvaW50ZXIgdG8gVkZJT0Rldmlj
ZQ0KPlZGSU8gYmFzZSBkZXZpY2Ugb3IgVkRQQSBkZXZpY2U/DQpXaWxsIGRvLg0KDQo+PiArICAg
ICAqDQo+PiArICAgICAqIEBlcnJwOiBwYXNzIGFuIEVycm9yIG91dCB3aGVuIHJlYWxpemUgZmFp
bHMuDQo+PiArICAgICAqDQo+PiArICAgICAqIFJldHVybnM6IHRydWUgb24gc3VjY2VzcywgZmFs
c2Ugb24gZmFpbHVyZS4NCj4+ICsgICAgICovDQo+PiArICAgIGJvb2wgKCpyZWFsaXplKShIb3N0
SU9NTVVEZXZpY2UgKmhpb2QsIHZvaWQgKm9wYXF1ZSwgRXJyb3IgKiplcnJwKTsNCj4NCj5JIHRo
aW5rIEkgd291bGQgaW50cm9kdWNlIHRoZSBnZXRfY2FwIEFQSSBoZXJlIGFzIHdlbGwgdG8gZ2l2
ZSBhIG1pbmltYWwNCj5jb25zaXN0ZW5jeSB0byB0aGUgY2xhc3MgQVBJLg0KDQpPaywgd2lsbCBt
ZXJnZSBwYXRjaDYgaW50byB0aGlzIG9uZS4NCltQQVRDSCB2NiAwNS8xOV0gYmFja2VuZHMvaG9z
dF9pb21tdV9kZXZpY2U6IEludHJvZHVjZSBIb3N0SU9NTVVEZXZpY2VDYXBzDQoNClRoYW5rcw0K
Wmhlbnpob25nDQoNCj4+ICt9Ow0KPj4gKyNlbmRpZg0KPj4gZGlmZiAtLWdpdCBhL2JhY2tlbmRz
L2hvc3RfaW9tbXVfZGV2aWNlLmMNCj5iL2JhY2tlbmRzL2hvc3RfaW9tbXVfZGV2aWNlLmMNCj4+
IG5ldyBmaWxlIG1vZGUgMTAwNjQ0DQo+PiBpbmRleCAwMDAwMDAwMDAwLi40MWYyZmRjZTIwDQo+
PiAtLS0gL2Rldi9udWxsDQo+PiArKysgYi9iYWNrZW5kcy9ob3N0X2lvbW11X2RldmljZS5jDQo+
PiBAQCAtMCwwICsxLDMwIEBADQo+PiArLyoNCj4+ICsgKiBIb3N0IElPTU1VIGRldmljZSBhYnN0
cmFjdA0KPj4gKyAqDQo+PiArICogQ29weXJpZ2h0IChDKSAyMDI0IEludGVsIENvcnBvcmF0aW9u
Lg0KPj4gKyAqDQo+PiArICogQXV0aG9yczogWmhlbnpob25nIER1YW4gPHpoZW56aG9uZy5kdWFu
QGludGVsLmNvbT4NCj4+ICsgKg0KPj4gKyAqIFRoaXMgd29yayBpcyBsaWNlbnNlZCB1bmRlciB0
aGUgdGVybXMgb2YgdGhlIEdOVSBHUEwsIHZlcnNpb24gMi4gIFNlZQ0KPj4gKyAqIHRoZSBDT1BZ
SU5HIGZpbGUgaW4gdGhlIHRvcC1sZXZlbCBkaXJlY3RvcnkuDQo+PiArICovDQo+PiArDQo+PiAr
I2luY2x1ZGUgInFlbXUvb3NkZXAuaCINCj4+ICsjaW5jbHVkZSAic3lzZW11L2hvc3RfaW9tbXVf
ZGV2aWNlLmgiDQo+PiArDQo+PiArT0JKRUNUX0RFRklORV9BQlNUUkFDVF9UWVBFKEhvc3RJT01N
VURldmljZSwNCj4+ICsgICAgICAgICAgICAgICAgICAgICAgICAgICAgaG9zdF9pb21tdV9kZXZp
Y2UsDQo+PiArICAgICAgICAgICAgICAgICAgICAgICAgICAgIEhPU1RfSU9NTVVfREVWSUNFLA0K
Pj4gKyAgICAgICAgICAgICAgICAgICAgICAgICAgICBPQkpFQ1QpDQo+PiArDQo+PiArc3RhdGlj
IHZvaWQgaG9zdF9pb21tdV9kZXZpY2VfY2xhc3NfaW5pdChPYmplY3RDbGFzcyAqb2MsIHZvaWQg
KmRhdGEpDQo+PiArew0KPj4gK30NCj4+ICsNCj4+ICtzdGF0aWMgdm9pZCBob3N0X2lvbW11X2Rl
dmljZV9pbml0KE9iamVjdCAqb2JqKQ0KPj4gK3sNCj4+ICt9DQo+PiArDQo+PiArc3RhdGljIHZv
aWQgaG9zdF9pb21tdV9kZXZpY2VfZmluYWxpemUoT2JqZWN0ICpvYmopDQo+PiArew0KPj4gK30N
Cj4+IGRpZmYgLS1naXQgYS9iYWNrZW5kcy9LY29uZmlnIGIvYmFja2VuZHMvS2NvbmZpZw0KPj4g
aW5kZXggMmNiMjNmNjJmYS4uMzRhYjI5ZTk5NCAxMDA2NDQNCj4+IC0tLSBhL2JhY2tlbmRzL0tj
b25maWcNCj4+ICsrKyBiL2JhY2tlbmRzL0tjb25maWcNCj4+IEBAIC0zLDMgKzMsOCBAQCBzb3Vy
Y2UgdHBtL0tjb25maWcNCj4+ICBjb25maWcgSU9NTVVGRA0KPj4gICAgICBib29sDQo+PiAgICAg
IGRlcGVuZHMgb24gVkZJTw0KPj4gKw0KPj4gK2NvbmZpZyBIT1NUX0lPTU1VX0RFVklDRQ0KPj4g
KyAgICBib29sDQo+PiArICAgIGRlZmF1bHQgeQ0KPj4gKyAgICBkZXBlbmRzIG9uIFZGSU8NCj4+
IGRpZmYgLS1naXQgYS9iYWNrZW5kcy9tZXNvbi5idWlsZCBiL2JhY2tlbmRzL21lc29uLmJ1aWxk
DQo+PiBpbmRleCA4YjJiMTExNDk3Li4yZTk3NWQ2NDFlIDEwMDY0NA0KPj4gLS0tIGEvYmFja2Vu
ZHMvbWVzb24uYnVpbGQNCj4+ICsrKyBiL2JhY2tlbmRzL21lc29uLmJ1aWxkDQo+PiBAQCAtMjUs
NiArMjUsNyBAQCBpZiBoYXZlX3Zob3N0X3VzZXINCj4+ICBlbmRpZg0KPj4gIHN5c3RlbV9zcy5h
ZGQod2hlbjogJ0NPTkZJR19WSVJUSU9fQ1JZUFRPJywgaWZfdHJ1ZTogZmlsZXMoJ2NyeXB0b2Rl
di0NCj52aG9zdC5jJykpDQo+PiAgc3lzdGVtX3NzLmFkZCh3aGVuOiAnQ09ORklHX0lPTU1VRkQn
LCBpZl90cnVlOiBmaWxlcygnaW9tbXVmZC5jJykpDQo+PiArc3lzdGVtX3NzLmFkZCh3aGVuOiAn
Q09ORklHX0hPU1RfSU9NTVVfREVWSUNFJywgaWZfdHJ1ZToNCj5maWxlcygnaG9zdF9pb21tdV9k
ZXZpY2UuYycpKQ0KPj4gIGlmIGhhdmVfdmhvc3RfdXNlcl9jcnlwdG8NCj4+ICAgIHN5c3RlbV9z
cy5hZGQod2hlbjogJ0NPTkZJR19WSVJUSU9fQ1JZUFRPJywgaWZfdHJ1ZTogZmlsZXMoJ2NyeXB0
b2Rldi0NCj52aG9zdC11c2VyLmMnKSkNCj4+ICBlbmRpZg0KDQo=

