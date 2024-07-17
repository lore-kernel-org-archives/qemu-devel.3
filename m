Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3B9B0C3DA59
	for <qemu-devel@archiver.kernel.org>; Wed, 17 Jul 2024 01:38:11 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sTtcC-0007CL-4l; Tue, 16 Jul 2024 21:37:56 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <zhenzhong.duan@intel.com>)
 id 1sTtcA-0007Bj-6W
 for qemu-devel@nongnu.org; Tue, 16 Jul 2024 21:37:54 -0400
Received: from mgamail.intel.com ([198.175.65.21])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <zhenzhong.duan@intel.com>)
 id 1sTtc8-0001fh-Bk
 for qemu-devel@nongnu.org; Tue, 16 Jul 2024 21:37:53 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1721180272; x=1752716272;
 h=from:to:cc:subject:date:message-id:references:
 in-reply-to:content-transfer-encoding:mime-version;
 bh=GjF4erukrOw4iQu9WV58w3sD0nO++Kee4j2CRoA3URo=;
 b=hzXdXNhuWy7S6/N3ONMUrJYa3AnIJtyXYp/Xo2e05TE143xpCZtSR13X
 mHIixZ8NsA0GFR3YfWNCzvCPjJbz6zkV0lHs1gN7BT60BAtjbPJoXeX73
 L48SNghWwfPNeCxrVusnFeWd3n1HgGMrrufdw+2fjC2RDQS6lqLhcFL9H
 f+myw1RlQnAhdyacHwOiyiFGkn9wXNXHpzVBsNAnzP31NKiWB9mLZrN6h
 DjuTX0EO8JHm12IHiEr173xaSOYUC+s/4oOrBRgU0hBRXtpv02emzhrwM
 yjgYd3c08iEPcGxUAQ4TbqShLwHKPUG73pj/8KDnb9LEVD3wNw05Txdnm A==;
X-CSE-ConnectionGUID: u2W/U3OwTrqAhGsTIRsiuQ==
X-CSE-MsgGUID: Msi8dcfqSN6F4N13fsCbHw==
X-IronPort-AV: E=McAfee;i="6700,10204,11135"; a="18612698"
X-IronPort-AV: E=Sophos;i="6.09,213,1716274800"; d="scan'208";a="18612698"
Received: from orviesa001.jf.intel.com ([10.64.159.141])
 by orvoesa113.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 16 Jul 2024 18:37:47 -0700
X-CSE-ConnectionGUID: tKBK+i9PTymIS9uw7Lnm7w==
X-CSE-MsgGUID: wr71bD6GRcCbcwrsPO2HoA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.09,213,1716274800"; d="scan'208";a="87696940"
Received: from fmsmsx603.amr.corp.intel.com ([10.18.126.83])
 by orviesa001.jf.intel.com with ESMTP/TLS/AES256-GCM-SHA384;
 16 Jul 2024 18:37:47 -0700
Received: from fmsmsx611.amr.corp.intel.com (10.18.126.91) by
 fmsmsx603.amr.corp.intel.com (10.18.126.83) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.39; Tue, 16 Jul 2024 18:37:46 -0700
Received: from fmsmsx602.amr.corp.intel.com (10.18.126.82) by
 fmsmsx611.amr.corp.intel.com (10.18.126.91) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.39; Tue, 16 Jul 2024 18:37:46 -0700
Received: from FMSEDG603.ED.cps.intel.com (10.1.192.133) by
 fmsmsx602.amr.corp.intel.com (10.18.126.82) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.39 via Frontend Transport; Tue, 16 Jul 2024 18:37:46 -0700
Received: from NAM10-DM6-obe.outbound.protection.outlook.com (104.47.58.100)
 by edgegateway.intel.com (192.55.55.68) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.39; Tue, 16 Jul 2024 18:37:46 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=R0zmcpj7WPPOD8oEKH7Tv/ETWvFEnRrcbY3USxoW/GVHv+J9NQgZeM7rDPzPwKe7SNTuh156jQYpAiyGwmPcd4VtGSIDq1WfiA49/t5BtK5Y5Slgsj71KBbdIpUGfjpbSeCvEsVbRrhNOeDLqc75S5KoQ/ksJW0B2b75UxLgbxjotxw5B2OQzst0FXKhfbZAKlf9BOrrpnKaw0eQfRbPQ8gL7EsfGehj8FZS4J1ZrZU+bghzmVahH0YoOP77fWZfdhN/6RZt9Sg76Cxlly+1sWbyQC1LIMDFsAuUpmr8woqVcYButRkdTcnhSDh2ie03uL5CjizkHspcxk3J9J6VyQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Fy5Ql0gYQ/XLZFLK2kJiEgSJmGgtsPnuuLm0Rqle7WY=;
 b=O1qZFGsPA7cC5IV4ltYdlFNPadedyg1T08NI0eMgghGtiNZuFp3k64le11tXPq1BSv4i6TKiLedpLgAvK6Ki0VvXRRcwITVW4QA+Sg/5TIHGc1+rET2WUGBxoAcIWFNih8ZA0wbpqYUVY/tDSBk7YYkTd5Afx2q5zXE3D28z+BQrNtwQK9+uDLCOGwL3Nktw7irbL9yYUwtbRRiKNRLFWPWL5gJNqAphMbp0T5nOba5RNStllMwDs8gGJ1lDIKfeZtTaDzvTv2RX4zyamqbfMQEnoDxCNckfAerGBsyfB+0/YgvCUekddT/fu0ceLAW1UcvjSKwl55kAKU+yQQ5vyg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Received: from SJ0PR11MB6744.namprd11.prod.outlook.com (2603:10b6:a03:47d::10)
 by DS0PR11MB8136.namprd11.prod.outlook.com (2603:10b6:8:159::5) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7762.28; Wed, 17 Jul
 2024 01:37:44 +0000
Received: from SJ0PR11MB6744.namprd11.prod.outlook.com
 ([fe80::fe49:d628:48b1:6091]) by SJ0PR11MB6744.namprd11.prod.outlook.com
 ([fe80::fe49:d628:48b1:6091%7]) with mapi id 15.20.7784.016; Wed, 17 Jul 2024
 01:37:44 +0000
From: "Duan, Zhenzhong" <zhenzhong.duan@intel.com>
To: Joao Martins <joao.m.martins@oracle.com>, "qemu-devel@nongnu.org"
 <qemu-devel@nongnu.org>
CC: "Liu, Yi L" <yi.l.liu@intel.com>, Eric Auger <eric.auger@redhat.com>,
 "Alex Williamson" <alex.williamson@redhat.com>, Cedric Le Goater
 <clg@redhat.com>, Jason Gunthorpe <jgg@nvidia.com>, Avihai Horon
 <avihaih@nvidia.com>
Subject: RE: [PATCH v4 04/12] vfio/iommufd: Return errno in
 iommufd_cdev_attach_ioas_hwpt()
Thread-Topic: [PATCH v4 04/12] vfio/iommufd: Return errno in
 iommufd_cdev_attach_ioas_hwpt()
Thread-Index: AQHa1FFOW0kJJ0uUFUGTC0WkSmMh9rH6KwzA
Date: Wed, 17 Jul 2024 01:37:44 +0000
Message-ID: <SJ0PR11MB67441CA96B0EA59C14CCF2E092A32@SJ0PR11MB6744.namprd11.prod.outlook.com>
References: <20240712114704.8708-1-joao.m.martins@oracle.com>
 <20240712114704.8708-5-joao.m.martins@oracle.com>
In-Reply-To: <20240712114704.8708-5-joao.m.martins@oracle.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: SJ0PR11MB6744:EE_|DS0PR11MB8136:EE_
x-ms-office365-filtering-correlation-id: dafc65ea-2773-46a6-eb9f-08dca6010e6e
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0; ARA:13230040|1800799024|366016|376014|38070700018;
x-microsoft-antispam-message-info: =?us-ascii?Q?yaWVxaRR91G1oOL862o6OrdlVqO6bfocuhMwTNK1SDtaUJQCE9eDiRuWcxOc?=
 =?us-ascii?Q?VuIrkaSad87+ZNECQyt+P9EcD0x0aQndw6jF6mdDgVvjaNq+HWoJ0rBZFmwW?=
 =?us-ascii?Q?558XmwuAmNvCXxjqR00GSwUjKLaxLw3q2aRb+dxRUfAfK/+NSKy3GH1Jlio6?=
 =?us-ascii?Q?ggLnUs+kpibG+gTOx29WMkiQK9AhW5faYOpblRjPnDj+AQL85ZhfD54oO9WG?=
 =?us-ascii?Q?e/67pNhigYXhm0oJiP7RnxjS37Yoa359I8wwxRhgC6HQ5c9VRplOIU2gOWjq?=
 =?us-ascii?Q?kRll/yXEkN38JPQ5Lb9SriybXe0oJfxPV76u2kuHT86bQSLbcfokVdRzfBTr?=
 =?us-ascii?Q?ACFZRwe+dt9B5xugQqfdnUG762KhFILp/RZhSzb+xoRhILvd+CDgWmwPINy6?=
 =?us-ascii?Q?aBXulheFhephHhxnYcCiTrtHB5bUajebFPaNSDnbfW290b9Cb/nG+YJ6TG1R?=
 =?us-ascii?Q?qGrDbI1TImZtKZynqaDBFwugZiGNtldx41HbveKKXaOb12eh23XhRgrsUeGb?=
 =?us-ascii?Q?3oSEjMFdKmEKXTd9/oNSQ4NQLVX6vfKbDFudRgH03N9FQI2/nstKRhDrdzzP?=
 =?us-ascii?Q?5/I6OfABaHL/BU45J2JdUphBYCfNsnakjE8aIJQsJrs3dAktkiIazwLXrBdZ?=
 =?us-ascii?Q?zRC5EPwUw0NOiuGganVYC8p3pYUeX/wqirIN2xJA/pSg0ZIMv90cjxGANVq6?=
 =?us-ascii?Q?DvZIiZShFGmFgLyIoFkOMGO9PrBz6uGAndTQGTkadjG/eUv48X9Cymas+ruV?=
 =?us-ascii?Q?DnciRqhDdmtBLAM4pRlEiveZXv3AwCbAfWmXx8S/LhBKClkM3VQKGF0maehJ?=
 =?us-ascii?Q?0/ZitSUDpaAkJ7eSHb7rG+04m9y3H5UZ7jLGbnAIizMzQEjMOeidqMBQAjXS?=
 =?us-ascii?Q?pywrG9OMq5wERQdJc+0WzjSSR1Wu32/1XTA5aik9PX0ffTKIuqV9s9KsffRG?=
 =?us-ascii?Q?FJGkYMWILqVXTa0HG8OiewCu/TmSG3SOeJJpQudceRfOsy8YjUoc/jT08OQW?=
 =?us-ascii?Q?WdLv0kckJkafj2Zi0yBOkaZTWMk37pagzZrQjnHXGfviMo40qb4DAmXnI/20?=
 =?us-ascii?Q?S7L7JSdJr6Z1m2Qk/aokCpJ+J2pQJevEV5XZ5AErBtRAxUzT3FbBTdSPr9vq?=
 =?us-ascii?Q?Tb4Yl9dvWmgTtMieRja2r0gLcAAHeLc7WKUqz7x54kpuDsujTQeqdmYqITea?=
 =?us-ascii?Q?uL79haMpYOqqFORWuWRotF2zU5232xSKy3T4dhidMEj1EEzqL4i9zos2AdpA?=
 =?us-ascii?Q?czCz8i6tZjctEz82DMGp0k99BV88mgtCXMHwAEXqRGC9sY0H/86D/kD58PXZ?=
 =?us-ascii?Q?g3fUvx4X0hw5H+Lq4FOFLsWMf8xxpOMC5S9gcaPeCKy9IQ5PZuqHaU5Zc6Qb?=
 =?us-ascii?Q?3S+HwYcFat5aqL7S3N9wUQwrjAfQ/IyW9beoscxeDIZbxb3nrQ=3D=3D?=
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:SJ0PR11MB6744.namprd11.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(1800799024)(366016)(376014)(38070700018); DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?pFrvBg7lEaEts6bItZ0apqosjDMfcpVkFLU2teRCNRuar+vL8MQwit+61bbk?=
 =?us-ascii?Q?P7wp0MT4O5FWTFW89JmDVV9RcMHyzbUZcIVEvj/zx8R+pV9438EecOYEXjql?=
 =?us-ascii?Q?UOg4ohOKcgrUVT6Dnx/UM0VwqpNu4eeRVGdWE631aXhWe0o32/9ghvd2T5Nt?=
 =?us-ascii?Q?caI6kfSnGKIGwxCF+gWdVNLkcHTXY2KV2oDxTjb7eKtKBkmwPeoeMt3JztJx?=
 =?us-ascii?Q?mgKVTcDyk2rv5ba0Ljw+0+NxLM4ZT9Q1bDlmcXnbQb1lp1DgnUHWjvgUhYiR?=
 =?us-ascii?Q?83kVgOlNEix6t3mX0t0MPAny29wZjH8mCdx3IhNQkyqOchS1xqtD5gMLf+P2?=
 =?us-ascii?Q?PT/1Rg9RD7ZLwHihlq7rrvaoiGqZtLtbwL6K/8zNV/J1EBSRDUaayjH+6yC/?=
 =?us-ascii?Q?Vgy2fnYnE/kPd8qfc0JZLLH/yHjWvPWg2kyVFDfuPc/jsoh6x1L6voBk8NgW?=
 =?us-ascii?Q?lpz03wkYbjcoe+ZNQ8qZbzwrT6UlKyzuVgaKVu314mJMP36/Aae45wK0wVLo?=
 =?us-ascii?Q?GWFqtyt/NniP6w/VAEtXGRrbx21awp7OCxpxZARIBgJ31HJLwL2nos88rb6Q?=
 =?us-ascii?Q?grPnuDlmiWHgUtF7rQOhZd4bGgJpKB1UqWZxWk7sRMioQifh6XPZb0xBJ/Gm?=
 =?us-ascii?Q?3MmQMdDYVH5DNgLMo6FpMHl5plNgc6ZEFBn4icPA9VjjVe0etqBEkZkBjmNr?=
 =?us-ascii?Q?8NnWKuzlrMqk5WXHJS57nEUG/wS+OkPU3fvzDcOgzivUAXqZIUEw2uGRvA9E?=
 =?us-ascii?Q?M2nnfUAL/SM3WKqk6VRFknj18PjYayhm80gRdTRXuPKjpNUx0vTlpu6Cch08?=
 =?us-ascii?Q?4MHuHq2KGf0LRPgMtbKzDCAl+FysnXDwkV8KtrEQPbbTq9qJl/8EyTTqsGDs?=
 =?us-ascii?Q?Q5bwkZixue9p0PSP8KqsmDrEae0jQhBQ6CCrW541lzPkzvHjl+2Afyqncb12?=
 =?us-ascii?Q?DpWDBXtMM1RXisy0jB5ZW+lrYgp/yEJ726pGjF9jSHjn/Oa3c3Vg0jgbvpvY?=
 =?us-ascii?Q?uzpGzOAlYIGYUNjWN0438c/W3n2vwJQwhzULrBCjIcLY6fBk2R+pNxMqEgIT?=
 =?us-ascii?Q?bg04cECjl3BFYnseM/E1gt1f3aHHK9TB7TK7Xbir6Pz0C1bANLFj21x3dTib?=
 =?us-ascii?Q?j8gRLJCAU5e3VAhHi3yCrPEJ3l4ebLpXfEVPQz03wMg50bCJD4DG0YTC0VOv?=
 =?us-ascii?Q?mnmj7hB43AKCz+vWG53FiGgZwsx26nW4u+7Zre21dFHw/PrbrZyjPR10HYbO?=
 =?us-ascii?Q?HC2F5cwPReBl+rCvPVeRSnow7NF0CnthqhHeB6fZfSf+1smpiRUrohJRJKgy?=
 =?us-ascii?Q?OdzhwdWDU4N4NytVNAj/73G8tbH+j7h2g3kn4xegqLVgVvvfqS8PR6T1HgYa?=
 =?us-ascii?Q?hwsNlOl0FH6nHB6gxol7zjbyTiuvqmBkKkEfzN6mSFAzcm3K1MUWNt9IDd94?=
 =?us-ascii?Q?b7cbcCik1ar4NWKcSHixxoQRqFZ0kFnrJ52Z4qxHDaxUGPMBKcDoaJwBWY33?=
 =?us-ascii?Q?8L5cAVAxRdv4njwD84w/VqtbhDMzRKHAiGLIthenEYVWLndYAZLCn3udqNOy?=
 =?us-ascii?Q?CjnS9osARKJCfbc6tGpJVhl7Rs3kl1ftYBfFUP6e?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: SJ0PR11MB6744.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: dafc65ea-2773-46a6-eb9f-08dca6010e6e
X-MS-Exchange-CrossTenant-originalarrivaltime: 17 Jul 2024 01:37:44.6821 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: jtpddwvmEql2Yq+1x0Jf195zfrB05kFKumzj/+5lqDgbn1uq9/qor9G8+/7Kwkn3fGiISdZ0MmOvKadqwWyImZQRA0doaPgVu7N6jBy8+yY=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS0PR11MB8136
X-OriginatorOrg: intel.com
Received-SPF: pass client-ip=198.175.65.21;
 envelope-from=zhenzhong.duan@intel.com; helo=mgamail.intel.com
X-Spam_score_int: -43
X-Spam_score: -4.4
X-Spam_bar: ----
X-Spam_report: (-4.4 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
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



>-----Original Message-----
>From: Joao Martins <joao.m.martins@oracle.com>
>Subject: [PATCH v4 04/12] vfio/iommufd: Return errno in
>iommufd_cdev_attach_ioas_hwpt()
>
>In preparation to implement auto domains have the attach function
>return the errno it got during domain attach instead of a bool.
>
>-EINVAL is tracked to track domain incompatibilities, and decide whether
>to create a new IOMMU domain.
>
>Signed-off-by: Joao Martins <joao.m.martins@oracle.com>

Reviewed-by: Zhenzhong Duan <zhenzhong.duan@intel.com>

Thanks
Zhenzhong

>---
> hw/vfio/iommufd.c | 8 ++++----
> 1 file changed, 4 insertions(+), 4 deletions(-)
>
>diff --git a/hw/vfio/iommufd.c b/hw/vfio/iommufd.c
>index 604eaa4d9a5d..077dea8f1b64 100644
>--- a/hw/vfio/iommufd.c
>+++ b/hw/vfio/iommufd.c
>@@ -172,7 +172,7 @@ out:
>     return ret;
> }
>
>-static bool iommufd_cdev_attach_ioas_hwpt(VFIODevice *vbasedev,
>uint32_t id,
>+static int iommufd_cdev_attach_ioas_hwpt(VFIODevice *vbasedev,
>uint32_t id,
>                                          Error **errp)
> {
>     int iommufd =3D vbasedev->iommufd->fd;
>@@ -187,12 +187,12 @@ static bool
>iommufd_cdev_attach_ioas_hwpt(VFIODevice *vbasedev, uint32_t id,
>         error_setg_errno(errp, errno,
>                          "[iommufd=3D%d] error attach %s (%d) to id=3D%d"=
,
>                          iommufd, vbasedev->name, vbasedev->fd, id);
>-        return false;
>+        return -errno;
>     }
>
>     trace_iommufd_cdev_attach_ioas_hwpt(iommufd, vbasedev->name,
>                                         vbasedev->fd, id);
>-    return true;
>+    return 0;
> }
>
> static bool iommufd_cdev_detach_ioas_hwpt(VFIODevice *vbasedev, Error
>**errp)
>@@ -216,7 +216,7 @@ static bool
>iommufd_cdev_attach_container(VFIODevice *vbasedev,
>                                           VFIOIOMMUFDContainer *container=
,
>                                           Error **errp)
> {
>-    return iommufd_cdev_attach_ioas_hwpt(vbasedev, container->ioas_id,
>errp);
>+    return !iommufd_cdev_attach_ioas_hwpt(vbasedev, container->ioas_id,
>errp);
> }
>
> static void iommufd_cdev_detach_container(VFIODevice *vbasedev,
>--
>2.17.2


