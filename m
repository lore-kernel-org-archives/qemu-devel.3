Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 255BAC83F03
	for <qemu-devel@archiver.kernel.org>; Wed,  9 Jul 2025 03:40:06 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uZLeS-00055W-Hs; Tue, 08 Jul 2025 23:39:20 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <zhenzhong.duan@intel.com>)
 id 1uZLeR-000553-18
 for qemu-devel@nongnu.org; Tue, 08 Jul 2025 23:39:19 -0400
Received: from mgamail.intel.com ([198.175.65.19])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <zhenzhong.duan@intel.com>)
 id 1uZLeO-00054C-AM
 for qemu-devel@nongnu.org; Tue, 08 Jul 2025 23:39:18 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1752032357; x=1783568357;
 h=from:to:cc:subject:date:message-id:references:
 in-reply-to:content-transfer-encoding:mime-version;
 bh=MM3kLd6vhr5HJw7f8f5Pi+Ra+QCC4xsxNhZbYVlazYE=;
 b=XTxlMlV0nJZSd+DepkZd6U4m6t9zVzmouJNKs1zlEg11PCParKGU1LpO
 i81wdqeefBKz4zN8BpuKRVJsaLgBjhc7mzLUFa/jKtH5Su6nJ16CbpiQL
 JJ6R1mhzubZtI0w4lcTaAfCR2DPlCc5pSnMtk4YsZ30zeER5px2PHqli8
 BXrDyY7bEoF29XivmaUSGsp8gpLydSS4lTXh50UeavGGQ1GnVe8CkES41
 jgMAqX8T8IUZ75X1GpqzMzhZmolGbqQ+iMuPvypBXAO8pr13PIIdI8y2I
 wZpMb4rev3DtsRUkPyzgmtMcA+W2OytC10/lzFmIkYfPpQJqAqRhRm0+D A==;
X-CSE-ConnectionGUID: Ttgh48yNQzKbrT4lgVDneQ==
X-CSE-MsgGUID: Yp2tdMRhRpWWPhdRY9dRNA==
X-IronPort-AV: E=McAfee;i="6800,10657,11487"; a="54139401"
X-IronPort-AV: E=Sophos;i="6.16,298,1744095600"; d="scan'208";a="54139401"
Received: from fmviesa002.fm.intel.com ([10.60.135.142])
 by orvoesa111.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 08 Jul 2025 20:39:13 -0700
X-CSE-ConnectionGUID: iawG5sRgSrSzALokAspBSw==
X-CSE-MsgGUID: H5Pmz2SJQkqQLTFhfB/YUQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.16,298,1744095600"; d="scan'208";a="179341909"
Received: from orsmsx903.amr.corp.intel.com ([10.22.229.25])
 by fmviesa002.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 08 Jul 2025 20:39:12 -0700
Received: from ORSMSX903.amr.corp.intel.com (10.22.229.25) by
 ORSMSX903.amr.corp.intel.com (10.22.229.25) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.25; Tue, 8 Jul 2025 20:39:11 -0700
Received: from ORSEDG901.ED.cps.intel.com (10.7.248.11) by
 ORSMSX903.amr.corp.intel.com (10.22.229.25) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.25 via Frontend Transport; Tue, 8 Jul 2025 20:39:11 -0700
Received: from NAM02-BN1-obe.outbound.protection.outlook.com (40.107.212.45)
 by edgegateway.intel.com (134.134.137.111) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.25; Tue, 8 Jul 2025 20:39:11 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=p6RyjnFBbdsdlAYXJgoueVK70vH1V8dj8+H0E4DnoxtsVxuDF9S6qj3mZ9Pw7AXJ45ydf4JLMUKd0YP5wa5xfw4X78MzPInh10gcPhl5wYNEM7yrRHMnKpr+XHhMRzC6ncZLr+a6VAa8hZ1G3GUSywZO9ub6KnUHipts8YqLeb3fVNGf25GCFiAKTwprIl14Xam7i0dhSBH/9j8R9P1GGj15UTYzwDApQ93xmGTWPVYWnY2LMl+qfj3HdmftoixsuLPJ99yv3Pi+huClUelT9LHeS2J9gD14TpI94OEMdInu+rJoxQ95IHN9QuOKbY1xBxh0ouPdmU/vFmth/wlsWg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=3OCQQXZPQzWJuRR+8k9fqcDaCd3NsSXJXVDg6fLmgoU=;
 b=f0gmggYvz7wkWcN7vmN9ewufBEO5Qi4Y4flJL8cCqzhPT0gPmyQvawDmocywmg7pq92i/jJTujahcJj8HN7REmK9A/razQ+iIR5rOfWyJ0NY/khSrIYrbloKHnE+M3t9/EbwKaryRtJZMJ/wMvUDgY1YB3qD0idPSNj35qzepOpBKksaJgb1Z/pC04Tx/aijnpP7r3suhAOieGZnKMYKau5IcHd5dvBWKA9w2C89gdjug2P1xtMKWa7G6dAbx3SrbG18eD+A/xSXGzVsIO4m0Utbrc16OL3108Vljd67VfR7FAXEpdIVCb920+48uNr0kvldGxAsUlOTAWvIURRjCA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Received: from IA3PR11MB9136.namprd11.prod.outlook.com (2603:10b6:208:574::12)
 by PH7PR11MB6355.namprd11.prod.outlook.com (2603:10b6:510:1fd::11)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8901.25; Wed, 9 Jul
 2025 03:38:50 +0000
Received: from IA3PR11MB9136.namprd11.prod.outlook.com
 ([fe80::604b:77a4:b1be:3f13]) by IA3PR11MB9136.namprd11.prod.outlook.com
 ([fe80::604b:77a4:b1be:3f13%4]) with mapi id 15.20.8835.023; Wed, 9 Jul 2025
 03:38:50 +0000
From: "Duan, Zhenzhong" <zhenzhong.duan@intel.com>
To: Nicolin Chen <nicolinc@nvidia.com>
CC: "qemu-devel@nongnu.org" <qemu-devel@nongnu.org>,
 "alex.williamson@redhat.com" <alex.williamson@redhat.com>, "clg@redhat.com"
 <clg@redhat.com>, "eric.auger@redhat.com" <eric.auger@redhat.com>,
 "mst@redhat.com" <mst@redhat.com>, "jasowang@redhat.com"
 <jasowang@redhat.com>, "peterx@redhat.com" <peterx@redhat.com>,
 "ddutile@redhat.com" <ddutile@redhat.com>, "jgg@nvidia.com" <jgg@nvidia.com>, 
 "shameerali.kolothum.thodi@huawei.com"
 <shameerali.kolothum.thodi@huawei.com>, "joao.m.martins@oracle.com"
 <joao.m.martins@oracle.com>, "clement.mathieu--drif@eviden.com"
 <clement.mathieu--drif@eviden.com>, "Tian, Kevin" <kevin.tian@intel.com>,
 "Liu, Yi L" <yi.l.liu@intel.com>, "Peng, Chao P" <chao.p.peng@intel.com>
Subject: RE: [PATCH v3 02/20] hw/pci: Introduce pci_device_get_viommu_cap()
Thread-Topic: [PATCH v3 02/20] hw/pci: Introduce pci_device_get_viommu_cap()
Thread-Index: AQHb7/hgTj57YS3o2ku1lrMH7qQqMLQo9AEAgAAucSA=
Date: Wed, 9 Jul 2025 03:38:49 +0000
Message-ID: <IA3PR11MB91367A742FD1F22D591D52069249A@IA3PR11MB9136.namprd11.prod.outlook.com>
References: <20250708110601.633308-1-zhenzhong.duan@intel.com>
 <20250708110601.633308-3-zhenzhong.duan@intel.com>
 <aG26VBqzOnLAWC5z@Asurada-Nvidia>
In-Reply-To: <aG26VBqzOnLAWC5z@Asurada-Nvidia>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: IA3PR11MB9136:EE_|PH7PR11MB6355:EE_
x-ms-office365-filtering-correlation-id: bf0707b1-0cec-454b-0b65-08ddbe9a1e55
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
 ARA:13230040|1800799024|366016|7416014|376014|38070700018; 
x-microsoft-antispam-message-info: =?us-ascii?Q?b25sMfFXOsosZe9hL0rkt0H6ucHYtUswX9plaq0wiEwSnT46OQ9DoWGcz2GX?=
 =?us-ascii?Q?R7yfi0fBD3Drn0OefuwvQ/+AITGJ6vZeyqFHHwdvLcDtBV7GwetZGXhFHtnu?=
 =?us-ascii?Q?36lQiqX3hYhIXzbA9N+jf5W0uwq6XZHmSa3s+eXpkkppQ6zSmamdH4kBQGbu?=
 =?us-ascii?Q?UcXxEeC+2LVbhGcCA64Ur0WfB6a2Tvcp7flMFVSN/317nsd49rI+sM3iuA05?=
 =?us-ascii?Q?5laJq2yuC19xRqhRf4C/tffiFf7/O2RKhLGW3+7H5JxkGB/4MJREbw8y/RGi?=
 =?us-ascii?Q?YnX2LR4AiFEgNhT1EMLvzOcdae1DG/AtPZuRstucWyxpLmXF1om2LVU+bdaS?=
 =?us-ascii?Q?QssKEUdp2inbgV5HxejBva0/Yxwm2JZcxMmj01dr1Az+Xtc2dYVNTZDWPwKb?=
 =?us-ascii?Q?dUsfger2PJj7rT5zZWzpFW+cdrZRQApK+qnnnChrU/annZ8bRiw989UJ8mnc?=
 =?us-ascii?Q?N6EvreoWZEM3M7/vzOr16svrcJt3n99P5rDNmyPb+oEd2F6JsLEr5zElGfJJ?=
 =?us-ascii?Q?9Uf8CyzdSC9Zj5zcvzCanKEGhWMgrdH2KyLExdKmfbB1yO+l0x1H15F2lZCB?=
 =?us-ascii?Q?ywtOuHwgvyAVOXiON+/+6sMv1+MszU0dwpwxJsO/L+3wJDRjRvLYx/cGTm1J?=
 =?us-ascii?Q?8ILth1H4BgbeWhQbL46c4S4WKSURDOjdYfpn5WfyPiqeL/i9FEdQ9iedB6VQ?=
 =?us-ascii?Q?Fi0P/nMa21hDyk/VUmP3y/l9w9sv/0FeHjmkL0VllHdVJmiimNjCAdZGDjN4?=
 =?us-ascii?Q?ZABJOUe7Alw/mIW50nzxWhIzRjxom3Kip26jImCrfqVK+cLHUAnBc0vyiwmm?=
 =?us-ascii?Q?rOTqgbPskmvlgpWHjt6XlAOkO5bab0tdAXplmzqBC+lo6XEgOYE2lhaWZ5HB?=
 =?us-ascii?Q?jqgWykwtjIQ4ZNp0iGTaDUegenJnhJKsUBt2kON0krfhiSvW7M00VUwGm/pX?=
 =?us-ascii?Q?TQJ4aoKy7D97ViGEctLLtOcDrAIUMO+AOR9dzUfFhacGnEFLuOw+nSf98c0X?=
 =?us-ascii?Q?N/vsQxoJ6SQ6sQB6PdkubdWWn8Sl9mvn5RsmWJXQdBxQnRlJ4Zi/hQ/Rj+Tg?=
 =?us-ascii?Q?IxhtRYf6Zk/Fb/W28P6oFYW7sP9/y1/DyiVunPgoU2//m3jdHtCn5ItqjAhr?=
 =?us-ascii?Q?1PDdwuaq4K4VmT+JVfgPu2j07jPpgqlJO9tNMXv+8IP/Bt30O3F7hOfmQT4t?=
 =?us-ascii?Q?a1BtspAaMACi2Qtx+FPN3Gzlr+A0wMHsxWlMq18unQJFGYTIMT/Kf10oY9Rt?=
 =?us-ascii?Q?fh50aakrvP+AgET7RMbvQ/poVm4128MsrXxPlYEp7RjlOgfkkRX/vFEs1Rzh?=
 =?us-ascii?Q?6htwje3bcGGU+Y2R5hKYgkfJ4xCL6F8gfLNDdms+lI3QEctMNaCQDmnMSsN/?=
 =?us-ascii?Q?1Po5hWGdZJ/GHtLw0RtOqn1B4yPCL1To1sULuc0flh4p7eZChPwDWcJeS8bp?=
 =?us-ascii?Q?NMqEOqfif6soB2z4ZJXF40+am6Dq2TYCFIS7MAAHQQ46fd9nPKrLTA=3D=3D?=
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:IA3PR11MB9136.namprd11.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(1800799024)(366016)(7416014)(376014)(38070700018); DIR:OUT;
 SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?Yh/Y6aowg35EswUIXSyIIVRiE74j1O0a+kzgfTdjpsBxyxEKI6s1cPM008eJ?=
 =?us-ascii?Q?3vfsTcZqwtXBZ+pkh2GO6/hqOnx0xv8k24j55HDz93XX2/FTSWR/Jzd5dUkw?=
 =?us-ascii?Q?3jI5XvrftHCYoh4QP04brLptDzpC8A+jDlGDhBX5NPHdr0kksogS5Ga1b5wt?=
 =?us-ascii?Q?0Abd6njAieD7kN+WEnS0b50k6y7/typOFUUd/uQ3IJp4fOV/OZLG2/YGe+Ye?=
 =?us-ascii?Q?zQ36DqYzUfqzmD+6aikNnv6LbkTN7g3ML7b+fDaSncCXfz9I4rhmFytXJ3lW?=
 =?us-ascii?Q?pEQt8j5CxQr0YSsUhdCx/nNYpljSJ6uR13fFqT7cpfPmwLredif8Cw2l7Bg4?=
 =?us-ascii?Q?6gfWKHGTMINHF+BLmr9E78Ejm++bSfdeANHvarCdY6Qezy43A41EFc5aoxF4?=
 =?us-ascii?Q?LOyF+Cb1gffa7deJNqESHf1Gr8B/1L6IVOLwxNonE6pxQUtysTGH9Vse4QIi?=
 =?us-ascii?Q?/iKnDzH9lK6Om7M8RBS8tRH5MLRSuZzt7VWGF/rEJ/TPzwK+xLU8K/FSR/iS?=
 =?us-ascii?Q?XTQrEQ/O8ywTXrHa6uLRLHIiZsKwdwfc2rWNiSJ8qA8ytjL4vjRA9kq50NCI?=
 =?us-ascii?Q?u9mwU49I9eOnjME22BX+R7vwdCF7s84XA++Hd9JIWBz/7z1LyFVN6yVKgWEk?=
 =?us-ascii?Q?ePcjEX7abtnjhRjM5YJx1IL7bXzFidilsL8VzskRzX0RDuCnYJXn1yi6tyga?=
 =?us-ascii?Q?IQPPfvnWehHJl8PVqU96p6MfSVXAYdOHze4mFx2rWqK8GGGoOt5CEIp+UGmb?=
 =?us-ascii?Q?VrjLPoadYmQ6zF0FXo14alqyPeQQ6gOXeuUAO25VaAvANMuaZF35mDrHy+zU?=
 =?us-ascii?Q?/trkYKEDrAu3O2w+QHgTAkpUa9jZq0Y3X7XQ3luTsxa14ZEwThf9bHF1iJal?=
 =?us-ascii?Q?6UmBlbFDIhxJKP/w+mgxAeZTwX6PiN0nVUgTGwD5B7HFqUpmVA8qHigMgar3?=
 =?us-ascii?Q?Wn+xBPGltKm1q2FhazzcHSMPl4i91R8+wqAGfFkyr3nPM7caHSSyiai2ueLC?=
 =?us-ascii?Q?N/zqIOevzoSbVRrNy/QHR4WudbkgYsXYPVUtL38JFVcwqDuYL/ErmoJ69jb9?=
 =?us-ascii?Q?C9PjnfEz2X11zSmYvM4sqCaN6uEmQ/+lm9AdvC3foduYTXl6I8eWMjenn1Sp?=
 =?us-ascii?Q?NABRqyk8DK0RbzbNogTKsLJuVENy6k33RL1/lY/Owj1Js7cER6Ccei6dKDjh?=
 =?us-ascii?Q?3OpHYfQOkWxQlVLq+sTh68KsrT+iMXchVGw/OcbkoRaxRCFO7Z8OdV4DBQm7?=
 =?us-ascii?Q?/RB+2UxP/WIeWBYtHfpRqOWvdjVzvj/ZFWGg3WW8/r0CrUOQ+jgz1jOrmj0j?=
 =?us-ascii?Q?gsDK4b6r555xYacPxHe0Uib9iaEIFbFRbcQanA4P/yZFKiA16eUqDiEnAcdw?=
 =?us-ascii?Q?zZB7uew46dUBM27NQBKzioosA99G9WQDrnZCbEmaBi8q7zVbQhMub4OMRiuq?=
 =?us-ascii?Q?NZ8aInP480KCcNtaS11bNVmsqdIdgcOfYJtaI3p2JFFbIRkocVBgSPoYaJG/?=
 =?us-ascii?Q?uKCNoXPiW1pHjgSakU6X+Ya0kwBZ5UCbNkWK6UfIJmYcOoNuzSRkm8o2cPYd?=
 =?us-ascii?Q?4rsvaeejw+q8b1cRw6jp8YTRMfzeYGAjM0Hx7e3Q?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: IA3PR11MB9136.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: bf0707b1-0cec-454b-0b65-08ddbe9a1e55
X-MS-Exchange-CrossTenant-originalarrivaltime: 09 Jul 2025 03:38:49.9416 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: ytFR4iKzif95IZ+lEMLHnneStjvcgwQDM/Dn6E2yGLcE5ZhON8aOiMVbkyDf2p/cXUuQ/4cYiSw/NyAK7Ca9k/aM1QGQLqmv8H+hzgQhDZE=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH7PR11MB6355
X-OriginatorOrg: intel.com
Received-SPF: pass client-ip=198.175.65.19;
 envelope-from=zhenzhong.duan@intel.com; helo=mgamail.intel.com
X-Spam_score_int: -43
X-Spam_score: -4.4
X-Spam_bar: ----
X-Spam_report: (-4.4 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_MED=-2.3, RCVD_IN_VALIDITY_CERTIFIED_BLOCKED=0.001,
 RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001, SPF_HELO_NONE=0.001,
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



>-----Original Message-----
>From: Nicolin Chen <nicolinc@nvidia.com>
>Subject: Re: [PATCH v3 02/20] hw/pci: Introduce
>pci_device_get_viommu_cap()
>
>On Tue, Jul 08, 2025 at 07:05:43AM -0400, Zhenzhong Duan wrote:
>> diff --git a/include/hw/iommu.h b/include/hw/iommu.h
>> new file mode 100644
>> index 0000000000..e80aaf4431
>> --- /dev/null
>> +++ b/include/hw/iommu.h
>> @@ -0,0 +1,16 @@
>> +/*
>> + * General vIOMMU capabilities, flags, etc
>> + *
>> + * Copyright (C) 2025 Intel Corporation.
>> + *
>> + * SPDX-License-Identifier: GPL-2.0-or-later
>> + */
>> +
>> +#ifndef HW_IOMMU_H
>> +#define HW_IOMMU_H
>> +
>> +enum {
>> +    VIOMMU_CAP_STAGE1 =3D BIT_ULL(0),  /* stage1 page table
>supported */
>> +};
>
>Thanks for this work. I am happy to see that we can share the
>common code that allocates a NESTING_PARENT in the core using
>this flag.
>
>Yet on ARM, a STAGE1 page table isn't always a nested S1, the
>hardware accelerated one. More often, it can be just a regular
>1-stage translation table via emulated translation code and an
>emulated iotlb.

What to return for an emulated device, VIOMMU_CAP_NESTED_S1 or 0?

>
>I think this flag should indicate that the vIOMMU supports a
>HW-accelerated nested S1 HWPT allocation/invalidation.

I'm OK to use VIOMMU_CAP_NESTED_S1 name. But still unclear which checks sho=
uld we have in .get_viommu_cap() callback to determine returning VIOMMU_CAP=
_NESTED_S1 or not,
as we know nesting support is determined by host IOMMU not vIOMMU.

Thanks
Zhenzhong

>
>So, perhaps:
>    /* hardware-accelerated nested stage-1 page table support */
>    VIOMMU_CAP_NESTED_S1 =3D BIT_ULL(0),
>?
>
>Nicolin

