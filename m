Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A631BC3DA41
	for <qemu-devel@archiver.kernel.org>; Wed, 10 Jul 2024 02:33:55 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sRN8j-0002gn-W5; Tue, 09 Jul 2024 22:33:06 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <zhenzhong.duan@intel.com>)
 id 1sRN8f-0002Sl-La; Tue, 09 Jul 2024 22:33:01 -0400
Received: from mgamail.intel.com ([192.198.163.16])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <zhenzhong.duan@intel.com>)
 id 1sRN8d-0003JT-4L; Tue, 09 Jul 2024 22:33:01 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1720578779; x=1752114779;
 h=from:to:cc:subject:date:message-id:references:
 in-reply-to:content-transfer-encoding:mime-version;
 bh=8SzCyyITqk39Gz5HDmoyEWtDhi710KTQQdZWRJtz2Y8=;
 b=O0t522e1RENjmYTQkqGNCLKtdOXpVQLy1ftOBmCkUB7ZVEXq3+hYhMKI
 WAd7B1G8zQ5OOLL97HhJd1fQFfur7BYGUEFVd7QFvLEr5RVw0eSMy1q8S
 HKy2DrhYqbIoXwfVqT/qwkL/fpUDkF0wHGQUh6RkJPntvjF1tinOq+/z0
 h5fcOGuEGAtbswG4n5Im7o8N7ZASJ1Yg0e3E11ZLzvMXTQdaqU8ADU/ir
 Ev8vFUMc39DMp2zfNt/C9mWGKb1qH8RmgDvv+QqRv0ZyihlDLvC10hUlq
 FEgsAWUrxIGZAwMKSMdv7GatVbF7kAgk4UZ0gmC4D5rOBIPxORR3WFaEh w==;
X-CSE-ConnectionGUID: Oxl2D5ahSweYHYpVSIVuhQ==
X-CSE-MsgGUID: r8laCqtDTxSRSURIxryyaA==
X-IronPort-AV: E=McAfee;i="6700,10204,11128"; a="12464745"
X-IronPort-AV: E=Sophos;i="6.09,196,1716274800"; d="scan'208";a="12464745"
Received: from orviesa009.jf.intel.com ([10.64.159.149])
 by fmvoesa110.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 09 Jul 2024 19:32:55 -0700
X-CSE-ConnectionGUID: VdFRpc1NS1yPMbPpCI5yzA==
X-CSE-MsgGUID: L4G55g5aTCePCM7RYnm96A==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.09,196,1716274800"; d="scan'208";a="48141232"
Received: from orsmsx601.amr.corp.intel.com ([10.22.229.14])
 by orviesa009.jf.intel.com with ESMTP/TLS/AES256-GCM-SHA384;
 09 Jul 2024 19:32:55 -0700
Received: from orsmsx611.amr.corp.intel.com (10.22.229.24) by
 ORSMSX601.amr.corp.intel.com (10.22.229.14) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.39; Tue, 9 Jul 2024 19:32:54 -0700
Received: from ORSEDG601.ED.cps.intel.com (10.7.248.6) by
 orsmsx611.amr.corp.intel.com (10.22.229.24) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.39 via Frontend Transport; Tue, 9 Jul 2024 19:32:54 -0700
Received: from NAM12-BN8-obe.outbound.protection.outlook.com (104.47.55.175)
 by edgegateway.intel.com (134.134.137.102) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.39; Tue, 9 Jul 2024 19:32:53 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=dsPLjkEbF0NIMelsbvANK/rSud3OI2Cq1vit9mdtcgQxgiNrygkS9+3io84FlH0V3bkjkAk5l7XrRjWgUu+5ndhFlYWrbfXBfpyJJMhN4m5UppGBfoln7yHyB7p5ryB7Fr0wsAARce4w0yCb/MR4D6mLO652gLE2poVOexc3Yp9dGq0dCT5rN3yitM5u0ooF4E/yAVa9f0JaSAdqAVE5W6PFvP3JC7dBBuGK8GNzEY0ZV08cSa4xBtMfEupN+SdPaRwu6joQZMRdwfk57J/21xU9tRuCzOpEaBQNHoRe9gFaf+qA2N1chKZmwAoRFfp3ZnRSoBT9MHx+xdO4vsWyaA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=8SzCyyITqk39Gz5HDmoyEWtDhi710KTQQdZWRJtz2Y8=;
 b=Dqt+SZgOWxTebQC1IUl/uNkOOwd+TzRWi/jeeHMYNMQIa8j+278SWE7/wPL0Yo1ZC46HvZi1PTJoM1gHhRmka2endkLl2Bz0SwUhjk25KWl3b4Fepe5STayMyzEDvrIa6qfGNf5zLV/qhvSnmpesE4pOtk00YwtuxYisW3VluRis9nxDh9klWqNQH5RdaOHSmwyvdxfW/daQw03irbMaow1y2u2tE1rhy19tSDq0Mb+i8H9/unpObixdTuT/6DmcyDwfxhAaeDkJqvxne+HLEBGOEgqqJZz8OIkuJwnHE2JOfCNo5AjqvfEu2w4y0iI5qs6kPP79GkP4jn1qLqh0aw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Received: from SJ0PR11MB6744.namprd11.prod.outlook.com (2603:10b6:a03:47d::10)
 by DS7PR11MB5967.namprd11.prod.outlook.com (2603:10b6:8:72::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7741.35; Wed, 10 Jul
 2024 02:32:51 +0000
Received: from SJ0PR11MB6744.namprd11.prod.outlook.com
 ([fe80::fe49:d628:48b1:6091]) by SJ0PR11MB6744.namprd11.prod.outlook.com
 ([fe80::fe49:d628:48b1:6091%7]) with mapi id 15.20.7741.033; Wed, 10 Jul 2024
 02:32:51 +0000
From: "Duan, Zhenzhong" <zhenzhong.duan@intel.com>
To: Nicolin Chen <nicolinc@nvidia.com>, Eric Auger <eric.auger@redhat.com>,
 "Liu, Yi L" <yi.l.liu@intel.com>
CC: "peter.maydell@linaro.org" <peter.maydell@linaro.org>,
 "shannon.zhaosl@gmail.com" <shannon.zhaosl@gmail.com>, "mst@redhat.com"
 <mst@redhat.com>, "imammedo@redhat.com" <imammedo@redhat.com>,
 "anisinha@redhat.com" <anisinha@redhat.com>, "peterx@redhat.com"
 <peterx@redhat.com>, "qemu-arm@nongnu.org" <qemu-arm@nongnu.org>,
 "qemu-devel@nongnu.org" <qemu-devel@nongnu.org>, "jgg@nvidia.com"
 <jgg@nvidia.com>, "shameerali.kolothum.thodi@huawei.com"
 <shameerali.kolothum.thodi@huawei.com>, "jasowang@redhat.com"
 <jasowang@redhat.com>
Subject: RE: [PATCH RFCv1 02/10] hw/arm/virt: Add iommufd link to virt-machine
Thread-Topic: [PATCH RFCv1 02/10] hw/arm/virt: Add iommufd link to virt-machine
Thread-Index: AQHa0iQxh3isvFZx9UClGfWE5xTntrHvOrIg
Date: Wed, 10 Jul 2024 02:32:51 +0000
Message-ID: <SJ0PR11MB67442C5B2A2790C1ED968FDC92A42@SJ0PR11MB6744.namprd11.prod.outlook.com>
References: <cover.1719361174.git.nicolinc@nvidia.com>
 <df22fcd43e201fea97da8862b61614a2986ffa5e.1719361174.git.nicolinc@nvidia.com>
 <efec2974-ce96-4cb1-a00c-30fe93c5fa7b@redhat.com>
 <Zo1sblmS9+xlWObT@Asurada-Nvidia>
 <af440fe7-faf7-43a4-9f04-9d0059ef7e90@redhat.com>
 <Zo1xA9B8L3qLyGQO@Asurada-Nvidia>
In-Reply-To: <Zo1xA9B8L3qLyGQO@Asurada-Nvidia>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: SJ0PR11MB6744:EE_|DS7PR11MB5967:EE_
x-ms-office365-filtering-correlation-id: e9238c85-c269-4ba0-4a09-08dca0889858
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
 ARA:13230040|376014|1800799024|7416014|366016|38070700018; 
x-microsoft-antispam-message-info: =?us-ascii?Q?SEn6uLcwpOIEQGToFNWlXY1eyPhDmIq4E93l1Lz46qd/kbn7PJae8KtN1ubB?=
 =?us-ascii?Q?s7T+PUZtjt1ZiqN7sAbG5WfW0ZRP9g8RnyNSwv8lZFUY1J6IrN8Helnx0cAe?=
 =?us-ascii?Q?mktx2DQ/9ZSxQEMGXsPWPxbfW2VJ+grpzkhZy/tq5TdaPRIdY1jRfdrK8JCs?=
 =?us-ascii?Q?6fnIq+5mP2ply87O1xunlVkumt/yR37DEmKoX8KswXMIvMAxcnjUswUmyphB?=
 =?us-ascii?Q?m3waKQyLAfch8bgdXq4Qres/8Rfr42GS+cNcs8PFjDd1ns+KhTL/B9LSDExp?=
 =?us-ascii?Q?QLnsSDiNaWSRFq/LBJf1cGLzS4HpWLn3wFTVBgf3HdPyprHXlqPChNWDPZml?=
 =?us-ascii?Q?GA+E2iti0YIoTkFUm1T7FkX9kxekRvx5GAnwpS5g9j7oZsamWgXx3t11QmJG?=
 =?us-ascii?Q?61Fg/be87r9Tur3CEaRS8JxiLuPnIJ33rIrPCMmWql/c2FsBteqcB/HH6xaC?=
 =?us-ascii?Q?1uvkvca2kFbu6s2Pof4O1yE2d9//S0kYBywSEHLYr3k6Vq9xVX/Hjv5f/JAi?=
 =?us-ascii?Q?7g+AaXnJOYCuZlXKuF6rVECvQMrOBour3Fr3yFKxuJ+0nAt+tFanUCiRWDL7?=
 =?us-ascii?Q?Acjb36XsrLjYNym6C414NW4xp5AJdQ2M3JdK5TamAPaN7aQdxaYSRHYCGGqr?=
 =?us-ascii?Q?SgYAByw0OX5xyI2dqRgtZZL512FWQkaIROJhJbqe/eFYicxU1UovBb1G118s?=
 =?us-ascii?Q?RW6z+6eGYDUbrkZMY/6krAR5lmEMz25szaUFyELROn3UDC6aNXoG9KW4FLDC?=
 =?us-ascii?Q?FTyEQIwnEzY5zan7OS0P0A2ns9+lszjPYU1ZIf4wUbTDD8qkfoBPDxKFZDn5?=
 =?us-ascii?Q?Rufawtp7+n862bv5cJL4Y7pya8I/u72HFChE4ywT2IzMGgzYBtpmTP+X3GeV?=
 =?us-ascii?Q?tHBLwAn5yHchEKdqabZWhhAdVN/7abu3iD8Kc50wMX4qqTFKJqhoUdNl2lkB?=
 =?us-ascii?Q?QLOCDDwOw3Np/kqilUCGKLsOcTX6eALoQ0HkyJgfRlG6Vft+f4/9GRAM1yCE?=
 =?us-ascii?Q?SggZ909ee04mCW0TB0ZVXRIezUHYcYfYtpdc7esIeaEN2eXLi63DmDIi8AEK?=
 =?us-ascii?Q?Xzfn70i3lbnR1cilHGm7QkLG7xdfvpN7AqfKWHZju4ApAUXLdj6tf6YNE9U1?=
 =?us-ascii?Q?mKR513OwhuL1FKE12WWJaTl3g9wem8SAUvf3dM/0csgP6huxnIKO33KfEF4N?=
 =?us-ascii?Q?BGyV6hqMYGV9P9AMsK+fuHOsBrMD9hwulKZryCD80RYS/8stuRiXa1pccT9+?=
 =?us-ascii?Q?rrf3XFC3IKJttCIEycdmJVzmIPN0yo3TrG3rC+XboH57W8m62WDH1dAHhCLr?=
 =?us-ascii?Q?knp0k9emT/8y8VXkQBSx48+xcIpiLKnwRMvwx3p/L5YnrdNzI57iAyI39BGa?=
 =?us-ascii?Q?Upp/VpY=3D?=
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:SJ0PR11MB6744.namprd11.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(376014)(1800799024)(7416014)(366016)(38070700018); DIR:OUT;
 SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?k5huAn7IOP4DilsZvpOBGg5W7yNbDoJrz0A50BjGpCEliAHrDdL2fI2uD+fO?=
 =?us-ascii?Q?05lYVtKhqrEeJS3oYcXayVO18ewxtdef2fJ4DhuD30pN6Gy/BdqpCWTJ1Bwu?=
 =?us-ascii?Q?uyEsyRJGjIo0EbJMGkCH17KcWht3ks/AR2Nd4BKgHMT/ui9IVYclKI8tfGwO?=
 =?us-ascii?Q?JebFJUYjYE0Ek96MkDgafb83hy/FjStQXOYD6dxFQUNnMU5olbGbUy7uHQVV?=
 =?us-ascii?Q?x1USjHNX504hH7vXtIpuXKxzy7gi1BgyWMNlFF3S/hQLG+IvFMmujNf1tlRY?=
 =?us-ascii?Q?89HeZ/EeAYnnCQngkwc4pOMSBeGYN0kNxnPGFRvjNyhO4WQuEB9C9WhxYQIS?=
 =?us-ascii?Q?BqEOc9HmN3B7gzEVS7IjrbYLmlB97LU17xCer6Ot1Ww0o/ykfgTyZp/ezvdP?=
 =?us-ascii?Q?E0fcwE56uXN+WKMZXgG0MMwXK1BiiKk8dwjceeDPg/R4b76zyrvxRaI2vmkd?=
 =?us-ascii?Q?8CxwSAQfO/jarDyvxUscTBh4sH3Ws2o2Upton2EHpc21YahG6b+lASymi3rW?=
 =?us-ascii?Q?B164K+0HfDyaS5rYJvSjmO8NL7HAceKMfG/1PYQ1cyJL8Qkyyxn7cT/rSpyP?=
 =?us-ascii?Q?ywYDDXWV6TxE2i9mVMUyb5Swzbswidbr+Zf8RI6gqVnaJ+VFm7zkOGlZ8Wiy?=
 =?us-ascii?Q?yznM3A+knnocq9txOMxHKKYoYCo4Vx3BeBzsvHKJAQnJciSNMxZp0/O35xUl?=
 =?us-ascii?Q?3g+Gd65fPKNsBNaxkIznl9Z56KvpCu0XN0JTCmimA9H7dOtElAfVnKWUwSX/?=
 =?us-ascii?Q?BmQvbLVk/UdzZRzvWdASfR6Yq51TUeieJXFeZBh7BOmqCyR+45lSIwzq1qqG?=
 =?us-ascii?Q?bPkMm5g6R/EtS1mnpKXxG9iWnNtxKn6VUARmuIexMpTERd+WahzIcvPiv964?=
 =?us-ascii?Q?vv+GA2PZsUmRmJ5joR1TbaL+ldzosveJWqLdxtNlV2yaj5n14CUFsDOtal6f?=
 =?us-ascii?Q?B9h3VYLo8KY6WOwnVoGUxg7tCp2ijwl02kSiNiIeAyAC1GSEVTG5pZqw3OnP?=
 =?us-ascii?Q?ZRHfcD7z8zuXDdEOOj9/6t4W02lbBi6Mh7iJ9V45EUm4zxhqe/NQradQ8um7?=
 =?us-ascii?Q?41AxxmCug2LbP332SY0EK3YT+AhWEs/daIH5rTpnDlzS3kTS5QKBxAdH1CcK?=
 =?us-ascii?Q?keNgFveo834UwlUySxPUwLjmgWb2PvUOHnqjkEy6yVSakd81kSSiNaZOv0L/?=
 =?us-ascii?Q?bJqhFQocvUK4PIiNCFCdk83HD2ENY0mG0r37p9PZGoKgFJAge6aQNiUruqqD?=
 =?us-ascii?Q?30s72O/+2nxDxw3U442idlLpaHDejzvnyIV2C2SHOjayVXeKUt7AfzSgBpw3?=
 =?us-ascii?Q?hcyJHFhd+/x648/qWkn3EIWX6p24jbAZcl3Da11iCXXjNqYTKVFCJU7/1j9T?=
 =?us-ascii?Q?gdJQiEHB5djBujUZ4DyBPXIrgrQrby80YVS6n+/buK5OYcbD+FmHofdBl0W7?=
 =?us-ascii?Q?ia4I7+9fHguUAW6TLm8bPUmbpRloH4HrfQ7mPZvqJubhyQHgrCTbqP94aEnT?=
 =?us-ascii?Q?Jr/v6xyo9qcu5sId3a0EJZBtVe0fJEv+OBn9nFDL1Ewz1//d53EaGdaNLajU?=
 =?us-ascii?Q?y6Cfv1p9wUAi60aWQBKk/UBui7BF+a+PN1l2Vow0?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: SJ0PR11MB6744.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: e9238c85-c269-4ba0-4a09-08dca0889858
X-MS-Exchange-CrossTenant-originalarrivaltime: 10 Jul 2024 02:32:51.1505 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: Nk/BpUMoedWY5iEkO5kNt+kOnHjgQjVWTjf9/n8wao2EHuKb8MSqIkRMrtsqXolt127nFOqukbhT4G8+dN0KQCM0rCAdKk/JLE9Kak+6OGo=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS7PR11MB5967
X-OriginatorOrg: intel.com
Received-SPF: pass client-ip=192.198.163.16;
 envelope-from=zhenzhong.duan@intel.com; helo=mgamail.intel.com
X-Spam_score_int: -44
X-Spam_score: -4.5
X-Spam_bar: ----
X-Spam_report: (-4.5 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.144,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_MED=-2.3, SPF_HELO_NONE=0.001,
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

Hi Nicolin,

>-----Original Message-----
>From: Nicolin Chen <nicolinc@nvidia.com>
>Subject: Re: [PATCH RFCv1 02/10] hw/arm/virt: Add iommufd link to virt-
>machine
>
>On Tue, Jul 09, 2024 at 07:06:50PM +0200, Eric Auger wrote:
>> On 7/9/24 18:59, Nicolin Chen wrote:
>> > Hi Eric,
>> >
>> > Thanks for the comments!
>> >
>> > On Tue, Jul 09, 2024 at 11:11:56AM +0200, Eric Auger wrote:
>> >> On 6/26/24 02:28, Nicolin Chen wrote:
>> >>> A nested SMMU must use iommufd ioctls to communicate with the
>host-level
>> >>> SMMU instance for 2-stage translation support. Add an iommufd link
>to the
>> >>> ARM virt-machine, allowing QEMU command to pass in an iommufd
>object.
>> >> If I am not wrong vfio devices are allowed to use different iommufd's
>> >> (although there is no real benefice). So this command line wouldn't
>> >> match with that option.
>> > I think Jason's remarks highlighted that FD should be one per VM:
>> > https://lore.kernel.org/qemu-
>devel/20240503141024.GE3341011@nvidia.com/
>> OK I thought this was still envisionned althought not really meaningful.
>> By the way, please add Yi and Zhenzhong in cc since thre problematics
>> are connected I think.
>
>Yea.
>
>Yi/Zhenzhong, would you please shed some light on forwarding an
>iommufd handler to the intel_iommu code? IIRC, we did that at the
>beginning but removed it later?

IOMMUFD/devid/ioas handler is packaged in HostIOMMUDeviceIOMMUFD and passed=
 to vIOMMU, see https://github.com/yiliu1765/qemu/commit/02892a5b452382866e=
804c3db3bb392c8f8f500f

The whole nesting series is at https://github.com/yiliu1765/qemu/commits/zh=
enzhong/iommufd_nesting_rfcv2/

We gave the user flexibility to use different iommufd backends in one VM in=
 iommufd cdev series.=20
We want to be backward compatible in nesting series, the code change to sup=
port that is also trivial.

Thanks
Zhenzhong

>
>> >> Also while reading the commit msg it is not clear with the iommufd is
>> >> needed in the machine whereas the vfio iommufd BE generally calls
>those
>> >> ioctls.
>> > I think I forgot to revisit it. Both intel_iommu and smmu-common
>> > used to call iommufd_backend_connect() for counting, so there was
>> > a need to pass in the same iommufd handler to the viommu driver.
>> > For SMMU, since it is created in the virt code, we had to pass in
>> > with this patch.
>> >
>> > That being said, it looks like intel_iommu had removed that. So,
>> > likely we don't need an extra user counting for SMMU too.
>> OK at least it deserves some explanation about the "why"
>
>Yes, I agree that the commit message isn't good enough.
>
>Thanks
>Nicolin

