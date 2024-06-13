Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 27C62C27C53
	for <qemu-devel@archiver.kernel.org>; Thu, 13 Jun 2024 01:07:27 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sHYvA-0000dq-7b; Wed, 12 Jun 2024 21:06:32 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <yuan1.liu@intel.com>)
 id 1sHYv7-0000dE-1h
 for qemu-devel@nongnu.org; Wed, 12 Jun 2024 21:06:29 -0400
Received: from mgamail.intel.com ([192.198.163.13])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <yuan1.liu@intel.com>)
 id 1sHYv4-0004pI-SZ
 for qemu-devel@nongnu.org; Wed, 12 Jun 2024 21:06:28 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1718240787; x=1749776787;
 h=from:to:cc:subject:date:message-id:references:
 in-reply-to:content-transfer-encoding:mime-version;
 bh=ubIFVU7BKdA0o4rBVd1oB7lwyi32Ub+b78qX2FOiKRg=;
 b=UuZHqxJ43b4N2wRSnSKGFFtTsY73mzH9J//S+S3xE+FdDO8wx0iNIUwj
 2jSURT7p6IL2MZkCyLfrp/3NzEd1SQ1mu0lUBbeI5+N26tPkuel0nkGmX
 H3t/P4PuEJjUcqXcSJrNuQ815VqEliYFqbPJO7ppBOjBOIB34AHhoOfsW
 X1616pi2NSJ9yLhOGeskGwOk/bMSC/h86ymurHcqmDU+UBjzfPjDVO6Mn
 bVxumvgzKGYeiTZ+buwzwM9Cqkk/5CbIiiK/erCTICociUxRNxQjBfnxK
 mSYBojdtnKZ/RR0h3TFC81T9Rr93SWMKLc0+bDhz+IfmUvazXa3XX162d g==;
X-CSE-ConnectionGUID: x6b4cHcaR7iJ7Oz12QThKg==
X-CSE-MsgGUID: 3aDOCOilTpuib3bilSQdWA==
X-IronPort-AV: E=McAfee;i="6700,10204,11101"; a="17958779"
X-IronPort-AV: E=Sophos;i="6.08,234,1712646000"; d="scan'208";a="17958779"
Received: from fmviesa009.fm.intel.com ([10.60.135.149])
 by fmvoesa107.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 12 Jun 2024 18:06:23 -0700
X-CSE-ConnectionGUID: h/WhVEGFQouw3CEmi+K1yA==
X-CSE-MsgGUID: I2Hc3w5cQJ+3pBIDH6JpUw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.08,234,1712646000"; d="scan'208";a="40069282"
Received: from fmsmsx601.amr.corp.intel.com ([10.18.126.81])
 by fmviesa009.fm.intel.com with ESMTP/TLS/AES256-GCM-SHA384;
 12 Jun 2024 18:06:23 -0700
Received: from fmsmsx611.amr.corp.intel.com (10.18.126.91) by
 fmsmsx601.amr.corp.intel.com (10.18.126.81) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.39; Wed, 12 Jun 2024 18:06:23 -0700
Received: from fmsmsx611.amr.corp.intel.com (10.18.126.91) by
 fmsmsx611.amr.corp.intel.com (10.18.126.91) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.39; Wed, 12 Jun 2024 18:06:22 -0700
Received: from fmsedg602.ED.cps.intel.com (10.1.192.136) by
 fmsmsx611.amr.corp.intel.com (10.18.126.91) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.39 via Frontend Transport; Wed, 12 Jun 2024 18:06:22 -0700
Received: from NAM02-DM3-obe.outbound.protection.outlook.com (104.47.56.41) by
 edgegateway.intel.com (192.55.55.71) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.39; Wed, 12 Jun 2024 18:06:22 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Zbd9zW6SUeK0cueKvEBobGg//W1qgTejuWUempOuGBmej0rnG+g7tUGx3VYLb/KwEGEiaVs60bKUB5OYg5NPINvhK2qliCrsUW6Kid44efGb3QdQSV5m4W707diT6C7TVBVXv3m5kmTnWW8l8asqvk5ICXGo3H1LQCpaCp51uTZHJLUGhB0eEBsjiJbcfhpMiv1vEiqZg5wh1PnATDQ1cCZ91QcJw7OtUw7aa4v7QUtkLngqMlyPb85Ekqn8hOVk8x7uhGfgCOM9eoGFY6rBcd4MBotp9fgNx4MFCcumJuDDUY/OziBbIiAG8vu1nWiPeFcF377IAx0YhvFTc36+tg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=ubIFVU7BKdA0o4rBVd1oB7lwyi32Ub+b78qX2FOiKRg=;
 b=Hu5fuGD7X01CNp4Ex3weGfWwY5pZf6DWq1AB5V0zTMC4lT/X1+HUhDTV+jASS9Cjty/byvptMLkQQXI0xW5GuAZBraxq/WR4T/yd3F/9XpYaH3oIaJ7DJzOIju5e2z6Ga7bAOWHf5Lx2O4woazkXUm9MbvsTZqbK3mnWmvLh3eN7WbuBLhVR0Lhe3V2pUqgZuQkgODQrnQLAve1QP8TCHIPIASfEsz5Pol6rAXS/R/Fzl6JXcXbcNgLqLGWKf7TGwj5y2spm5XLvG/aZHrzJZ9uXss88yrmjSJTCBlFEM3JlIQyT4Cxe8IH8W0/iQJn7fL1iCnUpilOHtHeej1FbQA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Received: from PH7PR11MB5941.namprd11.prod.outlook.com (2603:10b6:510:13d::20)
 by SA1PR11MB6685.namprd11.prod.outlook.com (2603:10b6:806:258::22)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7677.22; Thu, 13 Jun
 2024 01:06:20 +0000
Received: from PH7PR11MB5941.namprd11.prod.outlook.com
 ([fe80::2750:7e63:952:7f1d]) by PH7PR11MB5941.namprd11.prod.outlook.com
 ([fe80::2750:7e63:952:7f1d%6]) with mapi id 15.20.7633.037; Thu, 13 Jun 2024
 01:06:20 +0000
From: "Liu, Yuan1" <yuan1.liu@intel.com>
To: Fabiano Rosas <farosas@suse.de>, "peterx@redhat.com" <peterx@redhat.com>, 
 "pbonzini@redhat.com" <pbonzini@redhat.com>, "marcandre.lureau@redhat.com"
 <marcandre.lureau@redhat.com>, "berrange@redhat.com" <berrange@redhat.com>,
 "thuth@redhat.com" <thuth@redhat.com>, "philmd@linaro.org"
 <philmd@linaro.org>
CC: "qemu-devel@nongnu.org" <qemu-devel@nongnu.org>, "Zou, Nanhai"
 <nanhai.zou@intel.com>, "shameerali.kolothum.thodi@huawei.com"
 <shameerali.kolothum.thodi@huawei.com>
Subject: RE: [PATCH v8 4/7] migration/multifd: add qpl compression method
Thread-Topic: [PATCH v8 4/7] migration/multifd: add qpl compression method
Thread-Index: AQHau9WAUDA5tpJz9EiYCAgmVPYUwLHEMaOAgAABGQCAALBZ8A==
Date: Thu, 13 Jun 2024 01:06:20 +0000
Message-ID: <PH7PR11MB59413CE79F7F277D077B271CA3C12@PH7PR11MB5941.namprd11.prod.outlook.com>
References: <20240610102110.900410-1-yuan1.liu@intel.com>
 <20240610102110.900410-5-yuan1.liu@intel.com> <87msnqck32.fsf@suse.de>
 <87h6dycjwj.fsf@suse.de>
In-Reply-To: <87h6dycjwj.fsf@suse.de>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: PH7PR11MB5941:EE_|SA1PR11MB6685:EE_
x-ms-office365-filtering-correlation-id: 78248fc7-6ac8-4396-a8ea-08dc8b45091f
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0; ARA:13230034|376008|1800799018|366010|38070700012;
x-microsoft-antispam-message-info: =?us-ascii?Q?yHR2/w61PO9nXELy6HDBHITZpUH4kLdKlQMYlOfHuOkm4QjOGk1IFs7x+GHu?=
 =?us-ascii?Q?cRGoytho1Rqutn7OKqtB0V+9+DVp7gkWeDjo4Ipw5vriUsAvlC4CFa+xUDnk?=
 =?us-ascii?Q?8tHPM4MUVbnCpXSuCFz7goAj0uKaBJjeSKxn4Zk8XuajPlFulK1Nyjb1btZF?=
 =?us-ascii?Q?ziRTgNN5boQBRicGO13c8XQAqoEkZ7i/CnWqYd0kb+c1dCvF78bDTrBJvrav?=
 =?us-ascii?Q?PuqnhOduzQwisS/hTYqvOg4yxihudv4TORfapdwzpI6tIMhnhJelMu5JA+9p?=
 =?us-ascii?Q?XWUor9oYO2gGSwc3pdbkk2/WvNl54usw+5RiVesYFRl2GP0aJcHg2/RRmNbQ?=
 =?us-ascii?Q?tkJq60ghK16dPPHeqUtK4dJr8f2yeV1pGTdx0FZ1cvn4OABkTcW6D82kBCm0?=
 =?us-ascii?Q?DjfSeM6h4lvzCfbqqn8itO6OZ9mtmIYreWzIHuk6D1uhO/Y+nDgEa2p8Zvdk?=
 =?us-ascii?Q?rGOIzi20SlIPjqJ1O9sqai79Ugs8tBDrFqP78CYHddvfsBs9rxEe/uIld4nu?=
 =?us-ascii?Q?KboWkeICFr9OdtlwSh2mdsdEq14a8y27/nw8o7DadG7ZYPI7srR0MYlu2A3D?=
 =?us-ascii?Q?xZoGdDDf0RZ6gMrQo3Qwxdh5i2N2LiRAqatBNLMA44Hf6jMZQOACrDQ/d4zw?=
 =?us-ascii?Q?eYsEYF0s7mraiqk/kMkm9dG4xPjyMUzNIM6M8daLylfBCW3JQt4G+36k7zkt?=
 =?us-ascii?Q?KfkxvQ7qytASH5VIz5QaqmrO0DxtvKVEwkw6EP63msmBy1QfeugCVo8wfaDk?=
 =?us-ascii?Q?Tx9+xQE3xDzu8XgIT4Bb4w31FdvDA21Thl0T8qP1TQLJ4A1RcwL20ZZHISi1?=
 =?us-ascii?Q?3jugUo3pcBnZq7XAhviDqJ+RjpPYQqMO/E+rWcg7owQYxHKAA9Gt0BMJJauS?=
 =?us-ascii?Q?NyBP1XuPkFmjcGoff3mSsiC3bvCyj+Oro87jGAO3NNoADA4cDUP4WJ54PPpm?=
 =?us-ascii?Q?dHg+aeJIY98AXljTZGS0E0tiXx0Jn5bvkWzVJpisxSWxuaPj6Hxoir4jmrL9?=
 =?us-ascii?Q?36pmLrpFSfrhF8IwS5tAyKsfhNzVLzk9iycUkjLdLSsE00s9wO225yGDx8iI?=
 =?us-ascii?Q?0x2FcnbjMtYlISrhRUYeRdkNquDlu5cXYwHQTXnd4IUcA6z3UCcOARLGMd9J?=
 =?us-ascii?Q?aUbpr+IVOy8OidRXGLw2sNLVOJKTaikSd7/B8gtBSN4Pr1PtdJJyXfJVrhOf?=
 =?us-ascii?Q?RBTMB4FkVdd4GT1dA/w180FhmK3tku0ZnnQaTJakepn1cdmVOw0vsFFSHEvq?=
 =?us-ascii?Q?viNfPAB24V8L7NiWbKj5g7s54KJQO7/pyf3yIDYPPQYkB9rin1hyf/gPLagP?=
 =?us-ascii?Q?SnIIBylQZBe9VCImBXjdUB7/UbQ3/2Puims18bYlFZD0OuOY56J/SQs2CYjx?=
 =?us-ascii?Q?/41EWjM=3D?=
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:PH7PR11MB5941.namprd11.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230034)(376008)(1800799018)(366010)(38070700012); DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?njueG6jDCinzt9kygp+vNt3MxVjpQ6VXFaMUy2pOJ8Tj97s3Q2yt350Fykc7?=
 =?us-ascii?Q?rMTkvn43zu6BM4a19o/U5Jrt4ui9arTogq6DxMJCsEoV6ljMRBpikntbXQGg?=
 =?us-ascii?Q?+MeL4y9qVReu6dg9M9wVYFjuRy6Fh4U4B9KAibiFhGbGwg2BJMS5e+y8os8r?=
 =?us-ascii?Q?KmnZt32Rlc4JJDJziAbECYMkl3QKE7q47X9+x33adw8oy+5vNJFyp38DIQwx?=
 =?us-ascii?Q?I54CofstfXdDVODwtFd+i9Wijr2qi7iVU9CCHymVhyIvOw79dmCsQkr56ISy?=
 =?us-ascii?Q?dkI0EdA4uIL3hHWNDiIZ+ba1p3dRp6CkK+83Bzw1KPumxrzg5UqCuNab3Vjg?=
 =?us-ascii?Q?pGbQJmtMhOllvljZWifBiIJ0uKbbbRnIoq9j+WIxOGdxVjYZwooNXuv6kX/Y?=
 =?us-ascii?Q?bju6z+WMNceufvMGUvQYIFXT49F1/+NAQ1hXai2yWoYr99/YBNQCEy39JQD5?=
 =?us-ascii?Q?U5/0T+37MQ5hJkKO775X50jtHV1sKvjul60V4rHbIi1YULAYxMKir52AFtvi?=
 =?us-ascii?Q?hEnOupOozHUdEJhIG0CvazELsiVzs1+EF54EAAjRbyLF5CYA0iCLNoi7ngfT?=
 =?us-ascii?Q?CKlpdHsb2467UpyW49H2wuBMeg7wyDnCkHaoxa/jGep/Ce6zMEmHME0e5Rbd?=
 =?us-ascii?Q?lgIGQ/lmRkxIqvu8xSQFSVIRVNGozhQ8P7Yi0NHcjWL9DKBmdhoYoh5VqdM2?=
 =?us-ascii?Q?y+1Y3rmrcLZOCurgjcWdqQV1i8NcN3/dG4GTqbk41vag+ZPId38blzQaVnj7?=
 =?us-ascii?Q?v0o97CRLqRi54CQ2mtOSUz4VlbmCgOu9YCug6btXEtmkcGBZ1PAJBnKFKPs8?=
 =?us-ascii?Q?rK95c15/raMSY/6TtHC60HEqUQka1ucajFfA29Q7x9QpgPKYpZeSSjVEL3Gg?=
 =?us-ascii?Q?r1X5h/lPrlRKDI7zVcJbI7J2hm813HW7GL9VGsUrcAvJtUTU5+FpdYqECRhx?=
 =?us-ascii?Q?V0lPL+gvB5O3Pi9bdhLf+PnxlhpSMwdccyLws0rq14mrSnXoYDM1DJAF/ORQ?=
 =?us-ascii?Q?nmRjNZwHf1xr1pv5g/Txh1dFy4zi7tQJAH0DuDkvcehfjG5KnXf8d+8JDWk4?=
 =?us-ascii?Q?S3pGUb9M+5BhFCgA1I7UAlOW3C9MQH19vickuD+C3GwPwH4oEYcrGbHe79s1?=
 =?us-ascii?Q?J4RBtV5wmxNH0GczzuwGgLer9L9FoRPSaDV+vCv9Z8IbCTTF5IRcjeyx+8t0?=
 =?us-ascii?Q?mR5FbtD7wgy9Z6eDLeC/tqM7dIAA1UsVdnbatVw9Xt5ddorbINZFmhWp8AOa?=
 =?us-ascii?Q?Ej820/9hmQaq+K0+4rd+e/TPlLxkPSjFEN3OJX8LbxCLRZAQLZBVbTWNY4v1?=
 =?us-ascii?Q?Q3Dtgith2PGr7AXJRyC85clFB0aGIyb/VnXvk1lxxk8j2A9ngeS+zJUhejEl?=
 =?us-ascii?Q?3KZSDG/fYFCxasxPtuhS9ZtRXsqZAtPXxwDE6DR904o8Bd+iYzI9U4i5lAWQ?=
 =?us-ascii?Q?cx3HpkVZeb/PqMIuaRaxGrXVaGucxlCw7UloiLUPtkZ6zqjo1pBQLjEAT+2g?=
 =?us-ascii?Q?Fpofj5THjGa1NZVE1KLbsgvH5nHPI+8ZJ/g61hhCBihbZOYD3EYnBXpc5Rug?=
 =?us-ascii?Q?sIqCBr4zVbMzuTlqMuAOcmDRKYoWZlztVmTG61y+?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: PH7PR11MB5941.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 78248fc7-6ac8-4396-a8ea-08dc8b45091f
X-MS-Exchange-CrossTenant-originalarrivaltime: 13 Jun 2024 01:06:20.1248 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: mJQqX9XlGhd+PSzhfodFuIe/u3pobBCcS42znALLLFoJ9hzByKcfKwuORiAFfvPP/cdm06G6i/BOm3422V0sXQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA1PR11MB6685
X-OriginatorOrg: intel.com
Received-SPF: pass client-ip=192.198.163.13; envelope-from=yuan1.liu@intel.com;
 helo=mgamail.intel.com
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

> -----Original Message-----
> From: Fabiano Rosas <farosas@suse.de>
> Sent: Wednesday, June 12, 2024 10:31 PM
> To: Liu, Yuan1 <yuan1.liu@intel.com>; peterx@redhat.com;
> pbonzini@redhat.com; marcandre.lureau@redhat.com; berrange@redhat.com;
> thuth@redhat.com; philmd@linaro.org
> Cc: qemu-devel@nongnu.org; Liu, Yuan1 <yuan1.liu@intel.com>; Zou, Nanhai
> <nanhai.zou@intel.com>; shameerali.kolothum.thodi@huawei.com
> Subject: Re: [PATCH v8 4/7] migration/multifd: add qpl compression method
>=20
> Fabiano Rosas <farosas@suse.de> writes:
>=20
> > Yuan Liu <yuan1.liu@intel.com> writes:
> >
> >> add the Query Processing Library (QPL) compression method
> >>
> >> Introduce the qpl as a new multifd migration compression method, it ca=
n
> >> use In-Memory Analytics Accelerator(IAA) to accelerate compression and
> >> decompression, which can not only reduce network bandwidth requirement
> >> but also reduce host compression and decompression CPU overhead.
> >>
> >> How to enable qpl compression during migration:
> >> migrate_set_parameter multifd-compression qpl
> >>
> >> There is no qpl compression level parameter added since it only
> supports
> >> level one, users do not need to specify the qpl compression level.
> >>
> >> Signed-off-by: Yuan Liu <yuan1.liu@intel.com>
> >> Reviewed-by: Nanhai Zou <nanhai.zou@intel.com>
> >> Reviewed-by: Peter Xu <peterx@redhat.com>
> >> Reviewed-by: Fabiano Rosas <farosas@suse.de>
> >
> > I don't think I ever reviewed this patch. Please drop this when you
> > resubmit.
>=20
> Actually, just leave it. I thought you'd need to fix the output size on
> 6/7, but I saw you just moved it elsewhere. So no need to respin. I'll
> queue this version shortly unless anyone else has comments.

Got it and thank you for your review.

