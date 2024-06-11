Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4EFFBC27C4F
	for <qemu-devel@archiver.kernel.org>; Tue, 11 Jun 2024 03:23:58 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sGs6M-0001He-2t; Mon, 10 Jun 2024 23:23:14 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <zhenzhong.duan@intel.com>)
 id 1sGs6K-0001Gs-O7; Mon, 10 Jun 2024 23:23:12 -0400
Received: from mgamail.intel.com ([192.198.163.18])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <zhenzhong.duan@intel.com>)
 id 1sGs6I-0006Z5-M9; Mon, 10 Jun 2024 23:23:12 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1718076190; x=1749612190;
 h=from:to:cc:subject:date:message-id:references:
 in-reply-to:content-transfer-encoding:mime-version;
 bh=0LH6O07AjPSgOGwC2DYlClDwWF025Jn0TJ/QYUC8UDk=;
 b=d9t6qvnDi2bMcM3ZM+islAA+ANouUuVA9zEm4vfUI8Y2EmPUtogBLHE0
 9PncrwB3Phcr5xl3bn0sgcJpCbtpmFTQ7ZnzWcsAMpq32l34zVU0TxW9X
 RCaW45KqzuDfLYenBbeV6dI7tMEUo3/YQtkUkthy0talaBUZzjei7MBh/
 MbbQaOiv0vqGSsckZsUVov4eTUcLuXwRwZc55lnqqpZeCrUl2/D3Bohz9
 syCcmcY1VhFuc3EtgeUz0zCx79bBg3oRPbfP0QRR+8/FBqXHigHYd1U0G
 NJ1ctiFIAynogihT5QKZnpJRTb6AFjN4fhfrdgphyAt/LGKUuK+3EFrtD Q==;
X-CSE-ConnectionGUID: rDRHcGwuRJazQ3MH9A9VbQ==
X-CSE-MsgGUID: QfOJaCTtRT6oRafe6VHBFw==
X-IronPort-AV: E=McAfee;i="6600,9927,11099"; a="14489193"
X-IronPort-AV: E=Sophos;i="6.08,227,1712646000"; d="scan'208";a="14489193"
Received: from orviesa006.jf.intel.com ([10.64.159.146])
 by fmvoesa112.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 10 Jun 2024 20:23:08 -0700
X-CSE-ConnectionGUID: 71F/xB7LRfK9V8RzLktT8w==
X-CSE-MsgGUID: oodZQnQVQPKQn/r/RR3z/w==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.08,227,1712646000"; d="scan'208";a="39732251"
Received: from fmsmsx601.amr.corp.intel.com ([10.18.126.81])
 by orviesa006.jf.intel.com with ESMTP/TLS/AES256-GCM-SHA384;
 10 Jun 2024 20:23:08 -0700
Received: from fmsmsx601.amr.corp.intel.com (10.18.126.81) by
 fmsmsx601.amr.corp.intel.com (10.18.126.81) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.39; Mon, 10 Jun 2024 20:23:07 -0700
Received: from FMSEDG603.ED.cps.intel.com (10.1.192.133) by
 fmsmsx601.amr.corp.intel.com (10.18.126.81) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.39 via Frontend Transport; Mon, 10 Jun 2024 20:23:07 -0700
Received: from NAM11-CO1-obe.outbound.protection.outlook.com (104.47.56.168)
 by edgegateway.intel.com (192.55.55.68) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.39; Mon, 10 Jun 2024 20:23:06 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=jJpFw89VgyQCWEHYT5HMlPz/pOF0XCOe+26B7uj5AGYsFGCcLLdds6DINZTVtWpywL0rJ4f0Ghdq7IDPEyEr3J/PlDua1XAkyoz9a1NxE7lKnbXv5cefndrF8MnDd15r79mcFqOFEdEncXmpXCFtgnXKsUknh8zflax+hdsnmf+5S3NB1qazx4UfWZVgMHvlgYNURRKBtqHe1mkDfdXGnYnfpQgvCxrejKJzLC0dsZB6pyCNatMHuTEKDVU9sZMHIOzySk4+pdCTNzLnDUhkiiSn6MGlvwDHqG013qvADBG7bEOlxhcGsT2AZ6TNmxrliRwPkSiXW0qSUOMTAnfCng==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=W7+VIuvcgZg7IbMvOMDe00VmCZjNZKYCzuZTLApzHBc=;
 b=TAjfJxFFgdCBiKkaGhoODkyukmau0+NFeuaGMHCHvy9PiTaDegs1x5MoDhZvwZfyD3KI/MeC01fMbADUr6U1vB3PnwcC4pilPuro5Z1rgkQa7okUjXASDn1m52d/CxJL82y6z17J58Xagx5eDqSk6IWXqiFHLRqkpnAsC7Lkshm9IS6xXZpozki4oiUWnyeaBvXfzRarSSeJQ52lw8w3iaceCS0e4o8pYYM/mneUqJW+EkyQWy6GS8t34h6ztNUvS1MnshiyP252d8UUjb7vcffpCRHXnvhKewootgx0YaabMg2CfIzMgQd/UdscRoO6iAq1yyOIxwpjaJrzOEGOOg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Received: from SJ0PR11MB6744.namprd11.prod.outlook.com (2603:10b6:a03:47d::10)
 by BL1PR11MB5238.namprd11.prod.outlook.com (2603:10b6:208:313::8)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7633.36; Tue, 11 Jun
 2024 03:23:00 +0000
Received: from SJ0PR11MB6744.namprd11.prod.outlook.com
 ([fe80::fe49:d628:48b1:6091]) by SJ0PR11MB6744.namprd11.prod.outlook.com
 ([fe80::fe49:d628:48b1:6091%7]) with mapi id 15.20.7633.036; Tue, 11 Jun 2024
 03:23:00 +0000
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
Subject: RE: [RFC v2 5/7] virtio-iommu: Remove the implementation of
 iommu_set_iova_range
Thread-Topic: [RFC v2 5/7] virtio-iommu: Remove the implementation of
 iommu_set_iova_range
Thread-Index: AQHauOiUYZRBFnN2LUqjB0YQdpImarHB63Ig
Date: Tue, 11 Jun 2024 03:22:59 +0000
Message-ID: <SJ0PR11MB6744AA7B3548780C81413B2D92C72@SJ0PR11MB6744.namprd11.prod.outlook.com>
References: <20240607143905.765133-1-eric.auger@redhat.com>
 <20240607143905.765133-6-eric.auger@redhat.com>
In-Reply-To: <20240607143905.765133-6-eric.auger@redhat.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: SJ0PR11MB6744:EE_|BL1PR11MB5238:EE_
x-ms-office365-filtering-correlation-id: 95f0e820-0238-4c7e-e5a2-08dc89c5cbc4
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
 ARA:13230031|7416005|1800799015|366007|376005|921011|38070700009; 
x-microsoft-antispam-message-info: =?us-ascii?Q?KJXXNSUHKy1Sw2ZuGl14QyJM6E/5VhzeMbL2h6drY1G9BL9lpOLTsG0wS1hI?=
 =?us-ascii?Q?0K6bNamlfDNX83b3ZVQbG13/rzwULYdI4+fBSmQqNsefH3R8d/BOAxJdc+z/?=
 =?us-ascii?Q?cKC+feyjrQK9GIybRt+p1OdSlHggRENnFBG87Dhqw5o/fPORYNVMBlHx+UvY?=
 =?us-ascii?Q?s7LSEmAZXQCxc0G9YyEsbXOBnl6mfg0SsSYboeNFsYQ9w+k/hIm5OCesZuQW?=
 =?us-ascii?Q?wMllgSWGemSSOF7WPL4nlN0R1JqQpUUO8PgI+PFG+IX8HKP8dUFg3k2nZmom?=
 =?us-ascii?Q?5e0bk0TeJubLdjOHfVvnopinZG7oDYeRWik+8gzGt0Blia8VMzJSFTI5MS6i?=
 =?us-ascii?Q?Z3fjdD84g22mKgNuiXYT4NejO1WAyXk8sLBSY/wyyovg7wPlupnRDjnbB2z0?=
 =?us-ascii?Q?wTKIqfwTU9ts/KGXp6yD/qE1QGjPM1z7JEZh7HR8EJjTfOjruK7xi/ZjRlD9?=
 =?us-ascii?Q?QmZGhaWuauYOgizbOc3HT15bdPtqq9/AXToK2ca/7gJ2XJu4JvKiOTnx/E2a?=
 =?us-ascii?Q?BfdnVI8lIJZcuvL5+tusGXFSu1p58miLCHIFfpMcIg5L7IynnBXMf35+9V0W?=
 =?us-ascii?Q?c9V4NpQzyTpnNKqXre/WuW+vZOltuVh5l0RjzYhgDiGbbFX441oHPhOH9WLd?=
 =?us-ascii?Q?JToSTej+xQI591dfvZc/BipYOS1AePQpOUcHZJjyfMU4w2TykXpGBGyEJzAm?=
 =?us-ascii?Q?46vfdwq5BjimgRbKgaubA9naWt6Ouldba9g4ndWpW3RV+851/Iav1yOR6WPr?=
 =?us-ascii?Q?DqNbCCJv7hEYFQ5h4fBRAhnq8XlrLK6re3ilQs99ENFAFLN38DsxNu4cvj0r?=
 =?us-ascii?Q?WdOLHwA94aLqHYLFHiIJ8gNX9k+JnTFN3SiU8GTwo2bR6tOYXXOmtFhhgsHZ?=
 =?us-ascii?Q?uLHaRgjVaJGSOojn9JVzmPaykL2NbPPCbfPlyWiYeD1gWH82pu87LSD3VLRk?=
 =?us-ascii?Q?0OpLSqW7TojLK9rEALIpa9/NPplMgSFskZtHBIbIoPL6vSuwiyl5TouVgQO/?=
 =?us-ascii?Q?AnZtvvZ0rprySPFtpMmZjuJhLiJ4SedxyfyRxud/iyRg8ZhE+qDpFe26gXGp?=
 =?us-ascii?Q?ck8k8K6LvpRhEmRMt0w8ssxizQlTvdAC0D3FhyVDKZm/s4Gug34oOUgbpCdZ?=
 =?us-ascii?Q?1xsmScX7spdkqOHDTIAqMr3eVPRMkrc4DFUwwq/TijXj+RE7ISOQU3qcv11H?=
 =?us-ascii?Q?wHAh055MTlA/p78TGUr4OyfT6okOpjb8H2phRIOkPtNU0aC4q8f3VhD3O+dv?=
 =?us-ascii?Q?izmkIfRBM05sg68Ad3x66Jj09v4ThATThh7SHVSj34k/hcQksdzWhZ6UX1zK?=
 =?us-ascii?Q?XHYcO0O8KoGEzqUm6COfL4WDB/hzetU6evlfwoemQoewGpjVHoagsZ+KCydh?=
 =?us-ascii?Q?0uN5qxia1P19foZIS1e2CHT6cKLD?=
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:SJ0PR11MB6744.namprd11.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230031)(7416005)(1800799015)(366007)(376005)(921011)(38070700009);
 DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?ggdX/ijV3VQ6q0jDebrtOQA2rgW3IFfFL0ivmXhUiR8rqF3Tdv9t8cc/77Eq?=
 =?us-ascii?Q?P3KiIOhi6YcEj0p39XbglAHvB7vjmTUlCyqEQAxTZvQSmo6tizpq57MO+2QB?=
 =?us-ascii?Q?LE699k6ZLXdibduTgEszz+H4hXJJGzGck7TWejd7+Bb/LJJkrCJiA0xOK0Ju?=
 =?us-ascii?Q?aH9AStwCkDdve+oZKIRzQZL2zkoWnrooOeJnxIJx18yJX9Rhz6PzO4WOfxxw?=
 =?us-ascii?Q?9xucQmjKaHhCNa1fuzZr/ykHjxpVa0RMyfnmXjg6ThTNDt4I1W5omu0eMNvA?=
 =?us-ascii?Q?BlRwdszMG7rg2tq9VEbLg+WMUr763BP8jnKY8zCj0eumg2Z8fF+/f0kgVGtn?=
 =?us-ascii?Q?dRwgBeizFf4DI+2w5GZcl6Qx9h6HgohUKVTQVm8ug0dVgJjGGYkykIb01240?=
 =?us-ascii?Q?ZTECYHWRN4EjNoCb2bFIF/rfbDMAydKJMP8E/cv+s9yn9o9+lUTuLs36nswJ?=
 =?us-ascii?Q?T6VkvNhmOVRQVbCKjE9Z6sTwpTJRrNs1x8whqnhc1Q5iQy025r2HfcH9DO2q?=
 =?us-ascii?Q?5ZXelrUC33YifpWHOxJ8qaeGYs5UiiFTR/2leJdRThRBXVsCYXSzgXyoXLVu?=
 =?us-ascii?Q?Rod1p0p1XbGg/PLbHn7uOPgl2LHX8dZWzFZIrY2r0QfKPn46ERL8o0W2e1Ms?=
 =?us-ascii?Q?C3N46YRf7DpcUxpzqVSEmSE16dp6h71kqWBQtq1vPLBx6ZECKwqkg1vi3M5o?=
 =?us-ascii?Q?HvvAypg2NLqiY/J+AhniCB003YgzRnsWICV4t10+JW9xSLh19+txzjrTsVXY?=
 =?us-ascii?Q?RLEwIsezkfAnhqCPWSOsYEr/qVK8ZM+gb+/5WlDwM4rRJOX6HN6JwFF6tdKO?=
 =?us-ascii?Q?/fR+I62KEVtZ+uLjwkcZDGhJ+74ZllszpJF9zzmStcmNZj74axJrLXZLqw0f?=
 =?us-ascii?Q?oRKmkoeQnPYl+ut0U6abPxJQXnJYPRjw3JibziS3DCKSxt2VkW6mLnFFAU/l?=
 =?us-ascii?Q?5XnRM0/QU/37aSB8iXyeK9ukPjUmmEWZL4BOjD23+HBSZdjNZuvJVLCZpDxR?=
 =?us-ascii?Q?jq4tcsdU5/Jl5WIr93BmODDYDTr/hoL85eHGL90hDOMoidUycDbtSlr1mF4p?=
 =?us-ascii?Q?Jo8YHu+mr4L+4tfkoKHMsylULpeAEhJo6eiy/TQNc1CWTCxQTCjPIaWFPNbl?=
 =?us-ascii?Q?PUKQVfKbkbf3BT5lZWM4i1N8rR9VClIkYGsKBdyl7ZqWvbbaJ22sHrvCgmR8?=
 =?us-ascii?Q?G8q6fK4p4XYOwX3zH74bWI5oeNb+3Bv9W/kiqbgM3n08QmqWoakHdtpxT6v4?=
 =?us-ascii?Q?bQ6wHA/disooZDKfxJGbehU6kLiuRTcGdf+XYddm693h7mc6uhu2BiD2f+Xa?=
 =?us-ascii?Q?1LfskG820sN0hDoI9mqzNqje5SLSJrLmzF5ZAg2OxxK//9vtaF+YGVJOLYOp?=
 =?us-ascii?Q?Gs6hldB2UT/TqUtLTOfPI8Z4dv05fyO6gd0qoeH3grIU5+LAKuNyKQkJaCJn?=
 =?us-ascii?Q?iKGvVQTWIM+Qhlika4uUoEFcYi/k5zug4Pcm1sZJrxBaslmbpZxUPuJs+PwD?=
 =?us-ascii?Q?e/KgUT1BpRl7ttEYpemXNAP2xKZuotWRrhN7Sbv9xOmfoG7NLpwfiH+Iy1dz?=
 =?us-ascii?Q?psKTlYWlDu6bxCXWuW8WRwxM5jK/seh14fOiYPMZ?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: SJ0PR11MB6744.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 95f0e820-0238-4c7e-e5a2-08dc89c5cbc4
X-MS-Exchange-CrossTenant-originalarrivaltime: 11 Jun 2024 03:22:59.9823 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: NCyd/ndm+i0c4+XbDQg3aFmZs+wnyYMu7ehSwnEQi7m+t98ZgTh2LnHcuKO6/7Xkc3qEQBRSzJr78/uhprEiMSzRwKeWlnrShlWDQuuOy84=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BL1PR11MB5238
X-OriginatorOrg: intel.com
Received-SPF: pass client-ip=192.198.163.18;
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
>Subject: [RFC v2 5/7] virtio-iommu: Remove the implementation of
>iommu_set_iova_range
>
>Now that we use PCIIOMMUOps to convey information about usable IOVA
>ranges we do not to implement the iommu_set_iova_ranges IOMMU MR
>callback.
>
>Signed-off-by: Eric Auger <eric.auger@redhat.com>

Reviewed-by: Zhenzhong Duan <zhenzhong.duan@intel.com>=20

Thanks
Zhenzhong

>---
> hw/virtio/virtio-iommu.c | 67 ----------------------------------------
> 1 file changed, 67 deletions(-)
>
>diff --git a/hw/virtio/virtio-iommu.c b/hw/virtio/virtio-iommu.c
>index 33e9682b83..643bbb060b 100644
>--- a/hw/virtio/virtio-iommu.c
>+++ b/hw/virtio/virtio-iommu.c
>@@ -1360,72 +1360,6 @@ static int
>virtio_iommu_set_page_size_mask(IOMMUMemoryRegion *mr,
>     return 0;
> }
>
>-/**
>- * virtio_iommu_set_iova_ranges: Conveys the usable IOVA ranges
>- *
>- * The function turns those into reserved ranges. Once some
>- * reserved ranges have been set, new reserved regions cannot be
>- * added outside of the original ones.
>- *
>- * @mr: IOMMU MR
>- * @iova_ranges: list of usable IOVA ranges
>- * @errp: error handle
>- */
>-static int virtio_iommu_set_iova_ranges(IOMMUMemoryRegion *mr,
>-                                        GList *iova_ranges,
>-                                        Error **errp)
>-{
>-    IOMMUDevice *sdev =3D container_of(mr, IOMMUDevice, iommu_mr);
>-    GList *current_ranges =3D sdev->host_resv_ranges;
>-    GList *l, *tmp, *new_ranges =3D NULL;
>-    int ret =3D -EINVAL;
>-
>-    /* check that each new resv region is included in an existing one */
>-    if (sdev->host_resv_ranges) {
>-        range_inverse_array(iova_ranges,
>-                            &new_ranges,
>-                            0, UINT64_MAX);
>-
>-        for (tmp =3D new_ranges; tmp; tmp =3D tmp->next) {
>-            Range *newr =3D (Range *)tmp->data;
>-            bool included =3D false;
>-
>-            for (l =3D current_ranges; l; l =3D l->next) {
>-                Range * r =3D (Range *)l->data;
>-
>-                if (range_contains_range(r, newr)) {
>-                    included =3D true;
>-                    break;
>-                }
>-            }
>-            if (!included) {
>-                goto error;
>-            }
>-        }
>-        /* all new reserved ranges are included in existing ones */
>-        ret =3D 0;
>-        goto out;
>-    }
>-
>-    if (sdev->probe_done) {
>-        warn_report("%s: Notified about new host reserved regions after
>probe",
>-                    mr->parent_obj.name);
>-    }
>-
>-    range_inverse_array(iova_ranges,
>-                        &sdev->host_resv_ranges,
>-                        0, UINT64_MAX);
>-    rebuild_resv_regions(sdev);
>-
>-    return 0;
>-error:
>-    error_setg(errp, "IOMMU mr=3D%s Conflicting host reserved ranges set!=
",
>-               mr->parent_obj.name);
>-out:
>-    g_list_free_full(new_ranges, g_free);
>-    return ret;
>-}
>-
> static void virtio_iommu_system_reset(void *opaque)
> {
>     VirtIOIOMMU *s =3D opaque;
>@@ -1751,7 +1685,6 @@ static void
>virtio_iommu_memory_region_class_init(ObjectClass *klass,
>     imrc->replay =3D virtio_iommu_replay;
>     imrc->notify_flag_changed =3D virtio_iommu_notify_flag_changed;
>     imrc->iommu_set_page_size_mask =3D virtio_iommu_set_page_size_mask;
>-    imrc->iommu_set_iova_ranges =3D virtio_iommu_set_iova_ranges;
> }
>
> static const TypeInfo virtio_iommu_info =3D {
>--
>2.41.0


