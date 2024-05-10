Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D418EC25B10
	for <qemu-devel@archiver.kernel.org>; Fri, 10 May 2024 14:24:32 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1s5RA7-000220-In; Fri, 10 May 2024 10:23:51 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <yuan1.liu@intel.com>)
 id 1s5RA4-00021n-QU
 for qemu-devel@nongnu.org; Fri, 10 May 2024 10:23:48 -0400
Received: from mgamail.intel.com ([192.198.163.16])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <yuan1.liu@intel.com>)
 id 1s5R9y-0002fT-Rb
 for qemu-devel@nongnu.org; Fri, 10 May 2024 10:23:48 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1715351023; x=1746887023;
 h=from:to:cc:subject:date:message-id:references:
 in-reply-to:content-transfer-encoding:mime-version;
 bh=23SFm/ms6/U9n8XCg3bMle8WXuWjE3LqD1WeTcI25sE=;
 b=X8EWdSS43B3rzhi/DvoUMEJiQkm/cih8NG0RHbSpgC4Zm9wiXcgNSmKl
 9yIf5Tpg/OG6vn4HkVeof2zX3+RHAkTYZBXxWUJASb7XpuKXl8O/MFXcF
 XBvwtdj/YEHwl5qWfpHeQ0T/9rdM4q9vI+1KyFK1np0umE9iS0vuxuhhM
 CGWtyH/uY2emr6UzHUElQ+GBOe8p8RO00SDuEw+KcQXsWXfFxmv9+cIWB
 yfXgbFNBR3jPu7J3h9DKlMOidb3HFbXc8ZxnLIudA08VSUtFuVaTeyl0Q
 MHexnfqZXv3nIZ/CjG9XyAihvHDUDiv4ocw/fRHINpuV7CnGwu3r6Nq+F g==;
X-CSE-ConnectionGUID: A+74qbpETyGYOcau3wpjWw==
X-CSE-MsgGUID: OtjqLYt9Qg+Fpbp1eWfDQw==
X-IronPort-AV: E=McAfee;i="6600,9927,11068"; a="11467473"
X-IronPort-AV: E=Sophos;i="6.08,151,1712646000"; d="scan'208";a="11467473"
Received: from orviesa003.jf.intel.com ([10.64.159.143])
 by fmvoesa110.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 10 May 2024 07:23:38 -0700
X-CSE-ConnectionGUID: KlWViV3jS5CwsgWnGZToLQ==
X-CSE-MsgGUID: /lSpOpVBTLuWMceSmBGijQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.08,151,1712646000"; d="scan'208";a="34281406"
Received: from fmsmsx601.amr.corp.intel.com ([10.18.126.81])
 by orviesa003.jf.intel.com with ESMTP/TLS/AES256-GCM-SHA384;
 10 May 2024 07:23:39 -0700
Received: from fmsmsx611.amr.corp.intel.com (10.18.126.91) by
 fmsmsx601.amr.corp.intel.com (10.18.126.81) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35; Fri, 10 May 2024 07:23:37 -0700
Received: from fmsmsx603.amr.corp.intel.com (10.18.126.83) by
 fmsmsx611.amr.corp.intel.com (10.18.126.91) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35; Fri, 10 May 2024 07:23:37 -0700
Received: from fmsedg602.ED.cps.intel.com (10.1.192.136) by
 fmsmsx603.amr.corp.intel.com (10.18.126.83) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35 via Frontend Transport; Fri, 10 May 2024 07:23:37 -0700
Received: from NAM10-DM6-obe.outbound.protection.outlook.com (104.47.58.100)
 by edgegateway.intel.com (192.55.55.71) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.35; Fri, 10 May 2024 07:23:37 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=f7d2/xXYUK5f066ADHYQ9oR6BcM2eoBp5HyWfoKw3s97W5y+KJ4RnooXUa4/dRLeT0+8WRNRnMa0okLRK5KdKe1jsKK1hdC11l7JwJLSnJy9eZ2h6j3sUNaQbiaVUkRHQZY7a7aaiCVhL+Qu7z6Iz7Zs3/S/WnQhGZmWy3tvdvMEpxweEtxFmsoxtfC18pie0JCovyU7fh4buiTKHHiPJBP6oZQ/DKzNesSztcVTwbVe4DYqXCNvjtdDpe4zRtH2aTKZ164STQxvnfbYgTf9FvPePf+Yl226CFiyAJ/C7c7qMFg+xP5+DW1MTddcIsxqg1svrF5j7a6f+6YDxiD4fQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=23SFm/ms6/U9n8XCg3bMle8WXuWjE3LqD1WeTcI25sE=;
 b=akhNR073/wWv1Du2LBbqM5fxqpG+LcKP/XIYZhIk763MtfP6MXQVx3ZMfJaE5STWeQV/A3FxgCi15fZIthZyYsvNT078kAyMZsfmda3J0j5U7aMN8p0n+BJp9cI3MPdFvz6BhU5NF+gZjnw19JtJb1HvcRKYq2ug3OAigXHWGTImPJvkYtZNHzpXzX4mJZ0Vly8HTKMaIrrY3sVLA4YbDnZfbyy0uanfZUnYm0RTbwM3I1bMe1W+w5Fz3ZDUKbHl9A/YwCodrAKWy3MirId8Ce4stOIYITv1r5HEXadQL2pIvGgcnFtW3XnFEj9qQtLWVUjyqOMFyqpU1BAOPG+gXQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Received: from PH7PR11MB5941.namprd11.prod.outlook.com (2603:10b6:510:13d::20)
 by PH0PR11MB4773.namprd11.prod.outlook.com (2603:10b6:510:33::7) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7544.47; Fri, 10 May
 2024 14:23:35 +0000
Received: from PH7PR11MB5941.namprd11.prod.outlook.com
 ([fe80::2750:7e63:952:7f1d]) by PH7PR11MB5941.namprd11.prod.outlook.com
 ([fe80::2750:7e63:952:7f1d%5]) with mapi id 15.20.7544.041; Fri, 10 May 2024
 14:23:35 +0000
From: "Liu, Yuan1" <yuan1.liu@intel.com>
To: Fabiano Rosas <farosas@suse.de>, "peterx@redhat.com" <peterx@redhat.com>
CC: "qemu-devel@nongnu.org" <qemu-devel@nongnu.org>, "Zou, Nanhai"
 <nanhai.zou@intel.com>
Subject: RE: [PATCH v6 4/7] migration/multifd: add qpl compression method
Thread-Topic: [PATCH v6 4/7] migration/multifd: add qpl compression method
Thread-Index: AQHan5HW4oxA7r1XDEay+mc/qBRBW7GQiPqAgAABusA=
Date: Fri, 10 May 2024 14:23:35 +0000
Message-ID: <PH7PR11MB594138F9F08B7889647DA9B8A3E72@PH7PR11MB5941.namprd11.prod.outlook.com>
References: <20240505165751.2392198-1-yuan1.liu@intel.com>
 <20240505165751.2392198-5-yuan1.liu@intel.com> <87frupkb7k.fsf@suse.de>
In-Reply-To: <87frupkb7k.fsf@suse.de>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: PH7PR11MB5941:EE_|PH0PR11MB4773:EE_
x-ms-office365-filtering-correlation-id: 39b58b1b-8b37-442d-204d-08dc70fcc73f
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0; ARA:13230031|1800799015|376005|366007|38070700009;
x-microsoft-antispam-message-info: =?us-ascii?Q?V1TjkvHoYpoXN8QjbTJtMrV6L2h9254crvhgkn3TmdCZ0Lsj+YvfRl3ACrva?=
 =?us-ascii?Q?fcpC04YuCXNmbRC8oE1xcdYQdxAtum9ExuAoJsXk7iygnBE/dL7rokzWrzf6?=
 =?us-ascii?Q?zMG5kXQnY/gMTdcDeqibI4vcbSf2ZN1/AJhyT6kwUXVr5RatfQOBx9rr622c?=
 =?us-ascii?Q?zcRCi4JDaBM6d5xtLHLBw9UzZIE76qf9csM2JD54Dm0/b47bH+BkZI+faVsu?=
 =?us-ascii?Q?zWKGNpCzYAno/4JzA+pWsjG1nZ5fcq3cohNpBKbbbvqGo5jVROMZJRwllitA?=
 =?us-ascii?Q?5zKYYOk047ZPg6ah7zN46LQG4plIfSreBKCiIriE2ngYm7dEpZeI//jbB9YI?=
 =?us-ascii?Q?ZCV5Ok4RGd4lmbCcmfYV1GnGQDXy3tOszJ5IQQBc+4KTyIefE618lDRLQhTW?=
 =?us-ascii?Q?2JnroKZRckgzTnqt1OPb/bfwmBK2URU+BAgTGyAbK5b7BL1ToAZzwSbqnWop?=
 =?us-ascii?Q?bS6r9e8xxnlakDCxJ/y0LVhP9KI77NzMijoC3e4ARrDFdsRjKsOQ5krmStdX?=
 =?us-ascii?Q?TZ1fv+N+Os4MrIt7mia8hTO+F/kgd6jGbM+p08+Ya9d3yzKKTz4OLZiLyjc6?=
 =?us-ascii?Q?NDrKUFZLYtpmVb+xuZGmOpotxLeoIkdbQ8Kjm8XdTbaPAPlo5kxGteTkGUa/?=
 =?us-ascii?Q?paMy6zIJQX7/xjLPsrFguikcRCDguIX/aAA5x2u2t6KBIHDrAKW9gi1m0ue8?=
 =?us-ascii?Q?X1uz/igzero5D3QG96HO3QvxXa8I5hMuXUnw9+G7GYS91v7Uk/kFY3H8Oyj4?=
 =?us-ascii?Q?uW6K2FLASexgH+3TlMXg2FyEUM+1jse7ifb3O8rBWiIAHiQKvDlb6H9H3E9f?=
 =?us-ascii?Q?NwBJNzmtu9ew77exmkbviFpYO1abNuSDXkvV62LYzDUggl4OFeaaeJlP/GKR?=
 =?us-ascii?Q?KQ02eFSR2avuiwUvlt6surhwHQnCki8TBTMBfv9hrWgky/4qipY0+/V38TvM?=
 =?us-ascii?Q?Lcwk91YI2LHsJa1Xmvn4je/guwmOH/5f0TJy7e4DyxBEwSF6fBT948slMRbT?=
 =?us-ascii?Q?/AT98bKWs5CoVx+vs92e3uFWSFBEylpUBytF1nkEi8B70w/x9qtgBh7xn5MQ?=
 =?us-ascii?Q?a2edBU9YTnddk9TFuK3aVmb0kxsEfTZMCbsNrEdZpK+95T0yqSWACFZrNVAK?=
 =?us-ascii?Q?/8DxOimuZByLYOC2E6Mc72bdLXSVar/S6f2Iyon0YEQ/2pxHmR+Y0zqe2y+e?=
 =?us-ascii?Q?8tvuWdRaurIYoGPa4YnOEZTOttPLQcZFQcVtpoX5v0pcXnNwUj7PI5oU2Di4?=
 =?us-ascii?Q?eF/edrpJWNl17SwfghSrYYgOHzQyfYA3Nt+uivq8O1OfWB8YtEwWv07DA+9d?=
 =?us-ascii?Q?O8rtoeHvOnzEskTTQrXKpTgAcV7iLFP0dxVipJWB1wMbYA=3D=3D?=
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:PH7PR11MB5941.namprd11.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230031)(1800799015)(376005)(366007)(38070700009); DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?vkZ9O+/KfTezfbOvvTy48JNG0OlX6GaHMaXj69S9sRIp3BL+BelrHfHnN1CL?=
 =?us-ascii?Q?isVLdDu0ObQEnbmk1HVKygjgOTRlKS0Nv2BfA/IKZXEYhtUOVR598pkOwtTZ?=
 =?us-ascii?Q?5NkNz3+z4pkfqR5ltvdcIVBn1ew4BgBVW/vXUBhCU03GaKtBoPCqiw7S02kA?=
 =?us-ascii?Q?flKb3hutaU9TGYyZIJiO2ZjEcHng7bFgokEnMHscfuK4Nbf5V2l7ZnksTZu6?=
 =?us-ascii?Q?570lz0YD0yXK694nA/cYymzxyHzIigR0gnFQcX0PN24Fl3f/msjMW9iR5Pq5?=
 =?us-ascii?Q?oNKDh/MtPL3rv4IMXoGbtLrW9lSr9E7drd074YW+k1oLEiDlE5KBXIorEyhg?=
 =?us-ascii?Q?8uyn8fK6MIe6f4+3GACiVcx/7RfdZqCdVUB/mmwHbc3M9FqLp8gZ3TkbQvHI?=
 =?us-ascii?Q?r6SeTol6vUveaNcoSLSQFp/bbg2pnR9jWrWPO/MzqlfgVyN5a0SBWQ+l/Fr8?=
 =?us-ascii?Q?67MqT2V1u/n5+AqpOqUJiwu4b5Q11y8fggjoxJ21XjxU5cefmVHl55CAuXsQ?=
 =?us-ascii?Q?OCppMdE2/c/m2v+P/FmRhZ87PsXtzj5JAu+Pqyddru4F8RFaZ/tYtB1+gtFV?=
 =?us-ascii?Q?tmmRIA8mSgotziK1KNA074/4HwudYrH6q9+CDgYI7wZXIJ7hfuZTKM6WOWnl?=
 =?us-ascii?Q?6vXRxr3zmjgXcy/YIMLfp2308z9aaJlCk2jAtw944krmXTdvVVxWPnkVdQkq?=
 =?us-ascii?Q?MEJnFDMjZvBbuysztb50y5o1eRqO2krmE4PqsNGvyhDd8OhaDJUnP8XGUwr2?=
 =?us-ascii?Q?+Cf58+xy/pkao0VCVqOTMGku9MjPr4bvxCIwoq84nQrqdTtnhXC+cP2PauEn?=
 =?us-ascii?Q?6+0Oe8pkW+7lxmHvFzRJgAlwW3zLkgz8LVX1QHWBayq7rglEOWBcWW8BiCN8?=
 =?us-ascii?Q?7Ypw5zTom4/0Wa3+cSJv5Y8dNiHztvJ5tSDPhbIiDE5QGYFgj3Jd0nH1w7Yc?=
 =?us-ascii?Q?TIyTNCVfoI0FKsye5hkh4jORCOWZUBAZCWpIWB5EpG7ressojJ2bD9Z5ELcO?=
 =?us-ascii?Q?Z/f3BCx6dsd3k7zCRv/4U9KksNc93HKNk8zDX2Jmv9niWYH7BM3+iSTQPIK6?=
 =?us-ascii?Q?+BTDo+gyxdGIuL0IAa5+4V09Y5qtrNbjr9nbOHSOA4CSI3J5fuxNErZ6pwJE?=
 =?us-ascii?Q?vpX8lhi6C3IaiUIke7BZ9eH4JawK5qZvJiwCSfBxhok8nKr/rm4/hiHShDH7?=
 =?us-ascii?Q?M0JKL9LnEhu2d6cTNUltPELaNYHn0QJOnQEM0aUDdSr7fPrUh0TmEXCi9ydU?=
 =?us-ascii?Q?7hQsRXvNIw7faXnQPBVvWrCawWZF2Yuc8iFUTl0J93SIchDsPVLeAYHaElRk?=
 =?us-ascii?Q?tbz0mZkoBY2zSj3tG8AA/cdwuPQ/skiREZaZyjlomqfpiOINZ0tBgpDRmmoG?=
 =?us-ascii?Q?Aqc9JOkUqbbkc5WsNcnnpErfeAhGQErSJ1T3+MR3PjG8HvLghUB8TYK+553g?=
 =?us-ascii?Q?ZwFZ18+9+uTwwgVoj+OrGAWV8z9Qvmob9lukE8jPPMxLTnhzFPNHjP6QeVXV?=
 =?us-ascii?Q?IdFzzKd96ZvnlWRZSE01GAJ/N2heEEvMQ85JVyXQGYt/g5jt1Rwz7SwDkzSf?=
 =?us-ascii?Q?OgCNOUk3cYoaD3MNqwaTmCwiO3MnCafQzyt9lB1v?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: PH7PR11MB5941.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 39b58b1b-8b37-442d-204d-08dc70fcc73f
X-MS-Exchange-CrossTenant-originalarrivaltime: 10 May 2024 14:23:35.6246 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: NwA1c6NQFeIgDA3Zosw3dr8rTtyRjqqGwo8Dg0oetgM4OThr0NyUKktd5xCpA4WfCQguT49JMcyGK8s23fsYTg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH0PR11MB4773
X-OriginatorOrg: intel.com
Received-SPF: pass client-ip=192.198.163.16; envelope-from=yuan1.liu@intel.com;
 helo=mgamail.intel.com
X-Spam_score_int: -49
X-Spam_score: -5.0
X-Spam_bar: -----
X-Spam_report: (-5.0 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.586,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_MED=-2.3, SPF_HELO_NONE=0.001,
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

> -----Original Message-----
> From: Fabiano Rosas <farosas@suse.de>
> Sent: Friday, May 10, 2024 10:12 PM
> To: Liu, Yuan1 <yuan1.liu@intel.com>; peterx@redhat.com
> Cc: qemu-devel@nongnu.org; Liu, Yuan1 <yuan1.liu@intel.com>; Zou, Nanhai
> <nanhai.zou@intel.com>
> Subject: Re: [PATCH v6 4/7] migration/multifd: add qpl compression method
>=20
> Yuan Liu <yuan1.liu@intel.com> writes:
>=20
> > add the Query Processing Library (QPL) compression method
> >
> > Introduce the qpl as a new multifd migration compression method, it can
> > use In-Memory Analytics Accelerator(IAA) to accelerate compression and
> > decompression, which can not only reduce network bandwidth requirement
> > but also reduce host compression and decompression CPU overhead.
> >
> > How to enable qpl compression during migration:
> > migrate_set_parameter multifd-compression qpl
> >
> > The qpl method only supports one compression level, there is no qpl
> > compression level parameter added, users do not need to specify the
> > qpl compression level.
> >
> > Signed-off-by: Yuan Liu <yuan1.liu@intel.com>
> > Reviewed-by: Nanhai Zou <nanhai.zou@intel.com>
>=20
> There's an r-b from Peter that you forgot to bring along in this version
> of the series.

Yes, this patch has received r-b from Peter Xu in the previous version.
Sorry, I forgot this, I will add it next time.
Thank you very much for the reminder.


