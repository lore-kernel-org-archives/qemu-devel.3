Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1F11CC27C4F
	for <qemu-devel@archiver.kernel.org>; Tue, 11 Jun 2024 03:25:01 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sGs7p-0005Dh-17; Mon, 10 Jun 2024 23:24:45 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <zhenzhong.duan@intel.com>)
 id 1sGs7m-0004wK-E5; Mon, 10 Jun 2024 23:24:42 -0400
Received: from mgamail.intel.com ([198.175.65.13])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <zhenzhong.duan@intel.com>)
 id 1sGs7k-000727-EF; Mon, 10 Jun 2024 23:24:42 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1718076280; x=1749612280;
 h=from:to:cc:subject:date:message-id:references:
 in-reply-to:content-transfer-encoding:mime-version;
 bh=VQm0PExuDgYwGBbR++2Ja3nxHVbVwnIJ1l5el6Fu1lk=;
 b=Tg+Ta81gVrb6Z2NmiKvBlPLniRv7PREFVCGmzEoR7rAsPb+BUkyrz+RI
 UwLIcBzborrAH1LzoJjE5x00f2iPp3IIa8nIg3nK2rlXF+RazDgbwk3yv
 /HmjVUpTsR6X/QgVgpc/GVa78NWwdUVwg+LuSx1a/Dm+hqw+VHDfsS6P7
 kWT3nEqxUniyPl1YsfpcS20ied13gk86gFJBB8SdaWQy85fKKf8OHcmWE
 812wxqxuGLjK0WAjwS8E0/wSKTgXksSw+b9dyFMpv4lJ+m5j4Kdb+zQXg
 c2TUTkiFVXig/FeoFh6RD7lTtJr5J5Xxz+W6kcRuEf1S9Cs3yVtMu+0sk Q==;
X-CSE-ConnectionGUID: 3qsLpKhMSjGBNEbc6HlCag==
X-CSE-MsgGUID: Qnj1Bd01RoWjOB5WKa93dA==
X-IronPort-AV: E=McAfee;i="6600,9927,11099"; a="25881982"
X-IronPort-AV: E=Sophos;i="6.08,227,1712646000"; d="scan'208";a="25881982"
Received: from fmviesa010.fm.intel.com ([10.60.135.150])
 by orvoesa105.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 10 Jun 2024 20:24:38 -0700
X-CSE-ConnectionGUID: 6rf9IrzqQee+LTYBH30+5A==
X-CSE-MsgGUID: 4pyUflRJT7O/iPaK6nY5EQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.08,227,1712646000"; d="scan'208";a="39339380"
Received: from fmsmsx602.amr.corp.intel.com ([10.18.126.82])
 by fmviesa010.fm.intel.com with ESMTP/TLS/AES256-GCM-SHA384;
 10 Jun 2024 20:24:38 -0700
Received: from fmsmsx610.amr.corp.intel.com (10.18.126.90) by
 fmsmsx602.amr.corp.intel.com (10.18.126.82) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.39; Mon, 10 Jun 2024 20:24:37 -0700
Received: from fmsmsx612.amr.corp.intel.com (10.18.126.92) by
 fmsmsx610.amr.corp.intel.com (10.18.126.90) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.39; Mon, 10 Jun 2024 20:24:37 -0700
Received: from fmsedg601.ED.cps.intel.com (10.1.192.135) by
 fmsmsx612.amr.corp.intel.com (10.18.126.92) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.39 via Frontend Transport; Mon, 10 Jun 2024 20:24:37 -0700
Received: from NAM11-CO1-obe.outbound.protection.outlook.com (104.47.56.169)
 by edgegateway.intel.com (192.55.55.70) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.39; Mon, 10 Jun 2024 20:24:36 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=GY7rHitBy5P1InulXBY4S7h38qxg9aUD9PHof4S1vU2ZYwUg4CgDaI1yUXKnl5obWTFPBTUojS6XMbyCWE6JnIV8K2UhMN1L92DJmoA3xY6SC82r0Id8oPQMSUecPJkKigo0raF+x5Gt2ViSYPgKVjJTnqzVx8EIxJ1OiPRZvhjVipF4catFSniM9aWFZmrDBZ2nSKXFuFxRdWhNGjjlFaozxLyeMijNB3W0pfZ7mGj7YSjfhQ9EGxeqHGl7RpNJ6dxcdaXuA8z/E6nDDwNvQXYeU8XQmGbDsw19OwYzFwdpvSEg5L+hremd8Rg6K02YwMsR/ssaKuj/ZiNKJUIaJw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=3B7nLsa+BMf01opkdgOycVk06stvS8OEzh3Wh0Hpnug=;
 b=aTKJQAT4K4JNHhyfwWWMrmEaUAHdMhm4z/mIdAvYa7E7Kgg7civq9uIdeL4uY1w+ZnnWZticJMO3NhWN5Wqv3HTM47EL6ViFqm1JRcBpodzJmlOSGTs6XkPecWPRGy0sogmgER8JxfgtjEkIArIBJWspAz2hGYVGb4G4qamI+l2W0cvtXhEpMBHOeJCdEddUlgx3oTZ4oQZV6IqUffIMWPNqAV27ziNyiD4NwODXlnTMBH4w9gRmOPiRpeMhrX5s/TVdbCunOeNqq9mZum+TeXAf4Wf12hF8Kiyr3/wUPK47806Lr6VicBqHKlnHL9IuUil/BcJvvCJIYNT4wNu/8w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Received: from SJ0PR11MB6744.namprd11.prod.outlook.com (2603:10b6:a03:47d::10)
 by BL1PR11MB5238.namprd11.prod.outlook.com (2603:10b6:208:313::8)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7633.36; Tue, 11 Jun
 2024 03:24:35 +0000
Received: from SJ0PR11MB6744.namprd11.prod.outlook.com
 ([fe80::fe49:d628:48b1:6091]) by SJ0PR11MB6744.namprd11.prod.outlook.com
 ([fe80::fe49:d628:48b1:6091%7]) with mapi id 15.20.7633.036; Tue, 11 Jun 2024
 03:24:35 +0000
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
Subject: RE: [RFC v2 3/7] HostIOMMUDevice: Introduce get_iova_ranges callback
Thread-Topic: [RFC v2 3/7] HostIOMMUDevice: Introduce get_iova_ranges callback
Thread-Index: AQHauOiPvd02FCQ6yEOgMfr2gWIyg7HB6WFw
Date: Tue, 11 Jun 2024 03:24:35 +0000
Message-ID: <SJ0PR11MB67446074AA4133BDE258C40392C72@SJ0PR11MB6744.namprd11.prod.outlook.com>
References: <20240607143905.765133-1-eric.auger@redhat.com>
 <20240607143905.765133-4-eric.auger@redhat.com>
In-Reply-To: <20240607143905.765133-4-eric.auger@redhat.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: SJ0PR11MB6744:EE_|BL1PR11MB5238:EE_
x-ms-office365-filtering-correlation-id: 9bb2238e-ce26-447f-6431-08dc89c60473
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
 ARA:13230031|7416005|1800799015|366007|376005|921011|38070700009; 
x-microsoft-antispam-message-info: =?us-ascii?Q?dEggA3b3FoDvL8LCE5Ka2ld4UXl888yYVeeeSvIrOSLqgKhkXRA8xj75hMNE?=
 =?us-ascii?Q?gvMxeL1pa4qJVWy54nEJboNZztNpKla1pW3POqYwbAWQTE+LxPUOUduJ/ahn?=
 =?us-ascii?Q?UDzTHqK3ib2SZgfIWw3picywlCH9bazVEkfQ/1/ny9oUyWnCa58Bb2+rOsAX?=
 =?us-ascii?Q?2oU6+MJIAO8tftapaswdd1hwb02T4BaONB1ZEixHLr/DQstGCgWDen/bTsc+?=
 =?us-ascii?Q?TTj1jLRueURAngLgRc7J/mph5B0a3SWo5E47aJd97/q08+Ym3DEaSW31Htus?=
 =?us-ascii?Q?NyJFc7WQt2779VsoOPa2E4KJ5Dt01fnKORocJzWEX82IToRZGlWA/H48lw02?=
 =?us-ascii?Q?ivt9b57gEZzAyILoLoSCtk6vnNLwPj4UOaXPaASQpYkhEMbeoKroSzxXzhi0?=
 =?us-ascii?Q?WADLqomg+2YhTgFTvBaQ8WL4YXxadYxpkqpX+qXGnOYVN5IvezK0CIFsJuYw?=
 =?us-ascii?Q?5aoHxH4BA0ubY9sGjrhYdYcTdztWCj9OfA5xfnqpImyv19W1I2DKG/Ra0bI8?=
 =?us-ascii?Q?0xKI+MmPY9pAkDnv8S7XaSbxtxXs/8PPkJhF8W8OL4YYfjGoxSPf77K+Itke?=
 =?us-ascii?Q?dZ4MHC7lp/BBvuNpsve9FvAPNam/UN7lLWJ6IL5SBYOWg2WMi4yg10f6BpSl?=
 =?us-ascii?Q?hNUS9Nc6Z5jLZciIgCM13D9cjCej79fzPUXvCejNCONF3Rusc1fEyz89ihSa?=
 =?us-ascii?Q?IzhJgeuU8HVSK3GtJrpjaqa9uPQzwRbH/czxKwmt++s47p/YJtupncZyeXUh?=
 =?us-ascii?Q?Wn7PMBcwsocszgevF5Hza0w+bpGw8dkgg4HQ1YdumT9mlt0JfmgtifWUqveN?=
 =?us-ascii?Q?boK6eWYX8fE0vHkh3sx9Wiu8UTEqXxPCMB9X71IGy3uiGAGeDK1LqUXTvgaO?=
 =?us-ascii?Q?4hRQ4VcpAJhwknIl9MzmkBom4eOp6Cca3SaIdNQIOJipqN3dYdfvX/0qsg8Y?=
 =?us-ascii?Q?pEIYHZbFqaXzBOtne+t2K/W1zL4MW40KZMWWdKecVz9NgD8g5gBS0BF9uNk5?=
 =?us-ascii?Q?rKBMfkru3POoDNDy1cQTwD4XO/dDUh5XXwSdnlm0mirVW/lX7hZ6b59apvPF?=
 =?us-ascii?Q?QpHpabFOuJ1pcpcmulTC/4P1RsTEuMkIPOiIl/Xk7IgQE+JL9zIg+DGTB+Xn?=
 =?us-ascii?Q?/ZmH9Q1xJwiOzLFqrkVwKH6MFEK2PBsjG+Kyb+8ErPr5hB4OmMZ/M6S0vXcL?=
 =?us-ascii?Q?KfSJvBCxv4qa8jEw3H6lIAv+HkYlkUaveB+rRq7qYfQED372ycEh+fOPQ1Cp?=
 =?us-ascii?Q?c0YM1JErkaz0G2dF3K9i318wPuw03XLWwpSRuUSDcgdM7GV8+QAK5tK3O0nY?=
 =?us-ascii?Q?6M8vfwE2o9TUK9xIpYG4PRTtyf1+IjKdEv8dohW4rgnS+EqOIB5FITRzkHP+?=
 =?us-ascii?Q?1dbun2WLgdobCpwS4A2z1pfIjNkk?=
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:SJ0PR11MB6744.namprd11.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230031)(7416005)(1800799015)(366007)(376005)(921011)(38070700009);
 DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?3oCV676TJlW5Rwm0U2mazIHCPc5mv9JW9eWVyqc79HRAJaLZ/WRqM4rWnyML?=
 =?us-ascii?Q?yvIcVMHTl+qVgHWJe3ejds3zdAEZUJfqhjPjX5Q+QD9Czz5pYoOxSaHko/pw?=
 =?us-ascii?Q?DiBQgfaadNcptT2DbtRnwMBi4GmaRUoR5/TLmFOY5gaeQT4wlkoQn98UwEF5?=
 =?us-ascii?Q?NeuWcNS0tPSLmwWnyMv56d/BqiOrxUtaQclSgkKRy0ii1dWuHs0MzzYG2r7y?=
 =?us-ascii?Q?wzzV6zJVX1/jwjOu2ct1A6pSELSxq6q3bu+jeMd0+0M8Rv5eA+SOtQw3saye?=
 =?us-ascii?Q?Co3Uvs9P9lAfTqGbZDHd6wScigjKYmacMPExIeRG9w2Ixb3l6dTT5Mj1A7+2?=
 =?us-ascii?Q?F44k2GM1iEiOPn01GBXdNfm8GIS7+QWhJOX2pWVAHAv/iwJKPiX3UhCIOZ/K?=
 =?us-ascii?Q?78MrC9GFsE7NSjiXdxp3Oj1XV15BEiqpOdNUuKvCrluq78Tspz9YzZrAyytY?=
 =?us-ascii?Q?cTIgpd9eOvhF1x/DBRO7XuggrWCJHAZggv0UtoeBiRZQgdC/EDXfbF87gXru?=
 =?us-ascii?Q?17eKOcYuXO8rbOLTghxL93ltR3W+l06u7BH/be7HtW94nr84ljm0Bd43KePz?=
 =?us-ascii?Q?K6lOesOZbjoLLM/M9xOSOaXf3lNABZh8+i485bfWuY2aWb1XMo9kXvcduQqq?=
 =?us-ascii?Q?emXu37C4plm4MOf2lWuq6iHWcOoPwDOPn6exXBsHl6Dt0eWN+9uulGbegqkA?=
 =?us-ascii?Q?5R/w9hJWrS3lpgFOHK9MJgO1xOzF4JqM0vjHc4h/iPuVLGyWdGzKaSPp79Rc?=
 =?us-ascii?Q?Cewp/7wB+fB8pHkFI/1oGVyOcIvdcWXj0pSxOv22DwgYGFUX26USYqQ01SuA?=
 =?us-ascii?Q?rVXi53fBkrsoSgE3Dqawy0mdLism8C1p3zjg84l6aR8jVnkQSsPXpm+1xjJk?=
 =?us-ascii?Q?rteQ36htI7VBerh18QA1jRDZ6W9I5w4kilZwoiC5EED5OSieuleq/xV1LXqS?=
 =?us-ascii?Q?h5UXa6pvzrZCrPDLNoXjCCVR0iHXtMboiig2UgbdWW1KEUonJ3DzRxnEW9mO?=
 =?us-ascii?Q?ps0G+TslW8lxrKIjnF3k01WAJysEWOi+n3qWF6FJ51XV7uNY9yJJNLPt4/xc?=
 =?us-ascii?Q?UXsncPOCr/XMpghVZmkPbZBtalDFrN77TAh0X6oomiJIUaMtoiKpTZRVJie0?=
 =?us-ascii?Q?nGTNULu9cO3ox3PP9hjfpFv7LTxgcGFedy8IuWh3tLFnaw6EgA1DRqNqz4h3?=
 =?us-ascii?Q?7lLBal8hEo5rS1Vm2ELNvcpwdiUgiCZ8+aKADHO+tBI1bj/rY0staBRHRutE?=
 =?us-ascii?Q?GVAtusq8KS0fJy7f9vc75SYnE2ixqZs7Rj5IAdYGohZf6YfeVvVSIFZn/E6x?=
 =?us-ascii?Q?TSTPYCwqV9fuVy16HN4L2ZCpoHR3MlQUrCX1Ijc8efogKfBJvFpwS2hu/yK3?=
 =?us-ascii?Q?RuMT0sCHe0A473qTn0nYyvK9k7lxKsZv3yUN5ltNeOTyN6aM02rfVu467QFA?=
 =?us-ascii?Q?jHL16axREHpXfE00R0RIBH9O/WzIVLx7bebHbDKXO9jyT106jsa05xXBI3IW?=
 =?us-ascii?Q?XeiXJtc8CHeKkLvtrOwvmR20VzJguRSZyp9Efb1e3ApDdPBn/QkKMAugep3C?=
 =?us-ascii?Q?U4YEXsOOM5pEI5edx17ohFljoAc2CDsQZHbTTdlh?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: SJ0PR11MB6744.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 9bb2238e-ce26-447f-6431-08dc89c60473
X-MS-Exchange-CrossTenant-originalarrivaltime: 11 Jun 2024 03:24:35.0759 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: dPvY5M9zaModEQeh8jk13fbUjCKcU9g8Td0wz3coZHcIdZYiDzrI+2zKhsjzAMad7hooos5Y2um6IjT6Y1LREfJpXMQHUh/eLQhroNv2C+o=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BL1PR11MB5238
X-OriginatorOrg: intel.com
Received-SPF: pass client-ip=198.175.65.13;
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
>Subject: [RFC v2 3/7] HostIOMMUDevice: Introduce get_iova_ranges
>callback
>
>Introduce a new HostIOMMUDevice callback that allows to
>retrieve the usable IOVA ranges.
>
>Implement this callback in the legacy VFIO and IOMMUFD VFIO
>host iommu devices. This relies on the VFIODevice agent's
>base container iova_ranges resource.
>
>Signed-off-by: Eric Auger <eric.auger@redhat.com>
>---
> include/sysemu/host_iommu_device.h |  8 ++++++++
> hw/vfio/container.c                | 14 ++++++++++++++
> hw/vfio/iommufd.c                  | 14 ++++++++++++++
> 3 files changed, 36 insertions(+)
>
>diff --git a/include/sysemu/host_iommu_device.h
>b/include/sysemu/host_iommu_device.h
>index 3e5f058e7b..40e0fa13ef 100644
>--- a/include/sysemu/host_iommu_device.h
>+++ b/include/sysemu/host_iommu_device.h
>@@ -80,6 +80,14 @@ struct HostIOMMUDeviceClass {
>      * i.e., HOST_IOMMU_DEVICE_CAP_AW_BITS.
>      */
>     int (*get_cap)(HostIOMMUDevice *hiod, int cap, Error **errp);
>+    /**
>+     * @get_iova_ranges: Return the list of usable iova_ranges along with
>+     * @hiod Host IOMMU device
>+     *
>+     * @hiod: handle to the host IOMMU device
>+     * @errp: error handle
>+     */
>+    GList* (*get_iova_ranges)(HostIOMMUDevice *hiod, Error **errp);

Previous I thought expose iova_ranges directly in HostIOMMUDevice::caps.iov=
a_ranges,
But a new callback looks better for a Glist pointer.

> };
>
> /*
>diff --git a/hw/vfio/container.c b/hw/vfio/container.c
>index b728b978a2..edd0df6262 100644
>--- a/hw/vfio/container.c
>+++ b/hw/vfio/container.c
>@@ -1164,12 +1164,26 @@ static int
>hiod_legacy_vfio_get_cap(HostIOMMUDevice *hiod, int cap,
>     }
> }
>
>+static GList *
>+hiod_legacy_vfio_get_iova_ranges(HostIOMMUDevice *hiod, Error **errp)
>+{
>+    VFIODevice *vdev =3D hiod->agent;
>+    GList *l =3D NULL;

g_assert(vdev)?

>+
>+    if (vdev && vdev->bcontainer) {
>+        l =3D g_list_copy(vdev->bcontainer->iova_ranges);
>+    }
>+
>+    return l;
>+}
>+
> static void hiod_legacy_vfio_class_init(ObjectClass *oc, void *data)
> {
>     HostIOMMUDeviceClass *hioc =3D HOST_IOMMU_DEVICE_CLASS(oc);
>
>     hioc->realize =3D hiod_legacy_vfio_realize;
>     hioc->get_cap =3D hiod_legacy_vfio_get_cap;
>+    hioc->get_iova_ranges =3D hiod_legacy_vfio_get_iova_ranges;
> };
>
> static const TypeInfo types[] =3D {
>diff --git a/hw/vfio/iommufd.c b/hw/vfio/iommufd.c
>index dbdae1adbb..1706784063 100644
>--- a/hw/vfio/iommufd.c
>+++ b/hw/vfio/iommufd.c
>@@ -645,11 +645,25 @@ static bool
>hiod_iommufd_vfio_realize(HostIOMMUDevice *hiod, void *opaque,
>     return true;
> }
>
>+static GList *
>+hiod_iommufd_vfio_get_iova_ranges(HostIOMMUDevice *hiod, Error
>**errp)
>+{
>+    VFIODevice *vdev =3D hiod->agent;
>+    GList *l =3D NULL;
>+

Same here.

Thanks
Zhenzhong

>+    if (vdev && vdev->bcontainer) {
>+        l =3D g_list_copy(vdev->bcontainer->iova_ranges);
>+    }
>+
>+    return l;
>+}
>+
> static void hiod_iommufd_vfio_class_init(ObjectClass *oc, void *data)
> {
>     HostIOMMUDeviceClass *hiodc =3D HOST_IOMMU_DEVICE_CLASS(oc);
>
>     hiodc->realize =3D hiod_iommufd_vfio_realize;
>+    hiodc->get_iova_ranges =3D hiod_iommufd_vfio_get_iova_ranges;
> };
>
> static const TypeInfo types[] =3D {
>--
>2.41.0


