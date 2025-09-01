Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A7AABCA0FFD
	for <qemu-devel@archiver.kernel.org>; Mon,  1 Sep 2025 03:32:35 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1usvHB-0005iY-8x; Sun, 31 Aug 2025 23:32:13 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <zhenzhong.duan@intel.com>)
 id 1usvH9-0005iA-Oi
 for qemu-devel@nongnu.org; Sun, 31 Aug 2025 23:32:11 -0400
Received: from mgamail.intel.com ([192.198.163.16])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <zhenzhong.duan@intel.com>)
 id 1usvH8-0003ob-1g
 for qemu-devel@nongnu.org; Sun, 31 Aug 2025 23:32:11 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1756697530; x=1788233530;
 h=from:to:cc:subject:date:message-id:references:
 in-reply-to:content-transfer-encoding:mime-version;
 bh=BEYcMfaqFkk4ogD+j0eE2WEeuHs3mCHZcje4s3c3AdE=;
 b=bEwYme6QZ9rmEPMLno9twNwYs3rl8TbJ5Kj+2vgUyxq2dFSpW1QL/GK5
 mDOJmFlFm5zcXOd4WBCNhmLJkDizSAYZGZgT3vLw8qj81oyFUYYHc9NyS
 rlmISeMe8d7x+FkVTwBsZs25tEEw0q7+pL6ipXsh3LxC7ycSgpDmGiP3G
 m9o0iHqdrXZzfmMY8M5jtyUBQCmN4IS0nHQR4q2djbvP+WV9ytnGBExjT
 t2QY7fcKsoP5o2kQjMdFxK2s/9Qo4Vj4CzS6od4Kq2NemBgL3bYuIIP+p
 CT7DP0cK/n8s7mvTNtTumwQuLDDT5WxlP42clW1lmocRR2n3L1LjeQxyr g==;
X-CSE-ConnectionGUID: FWNZFIwqTVq4SWkqO4ptSg==
X-CSE-MsgGUID: /d/UpQSmS6+Z0m5QfkW8dA==
X-IronPort-AV: E=McAfee;i="6800,10657,11539"; a="46461667"
X-IronPort-AV: E=Sophos;i="6.18,225,1751266800"; d="scan'208";a="46461667"
Received: from fmviesa003.fm.intel.com ([10.60.135.143])
 by fmvoesa110.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 31 Aug 2025 20:32:07 -0700
X-CSE-ConnectionGUID: tOJQHJ20Q3+xdIER6bAFYA==
X-CSE-MsgGUID: 8QJqMT7lRDa2oJMX+oKBMg==
X-ExtLoop1: 1
Received: from orsmsx902.amr.corp.intel.com ([10.22.229.24])
 by fmviesa003.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 31 Aug 2025 20:32:06 -0700
Received: from ORSMSX901.amr.corp.intel.com (10.22.229.23) by
 ORSMSX902.amr.corp.intel.com (10.22.229.24) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.17; Sun, 31 Aug 2025 20:32:05 -0700
Received: from ORSEDG901.ED.cps.intel.com (10.7.248.11) by
 ORSMSX901.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.17 via Frontend Transport; Sun, 31 Aug 2025 20:32:05 -0700
Received: from NAM04-DM6-obe.outbound.protection.outlook.com (40.107.102.85)
 by edgegateway.intel.com (134.134.137.111) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.17; Sun, 31 Aug 2025 20:32:03 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=uHDfYqpL627mzCaz6rtOIX8naHR3y7sL1lvopxv7DuYBb7mfM76OWphxZsjVAMvO1VQ8h7xveWDUv3HlWE7hALPUYB36ufU0S+BqtbHcBFF28UEFV7miwE85BnVyIdO7nzRgViECdxCqlih3Q5seKcqJPkg3IjNxGh/0myTgcggmhxTEc2T+NNpTWFc8V8YrIUCBFgcj/aA34ATEFxHSENaVEBtO9Lnw83VWLwbuKGh6NdgOE5ylUKxZcKmh+H5dnHNSci5BohJZnz1pZ4ATEIChStrf2xr7e2atf/smhnK0uO6nZSCHvL6FJS+89/+3ca3OSVVBhHifgCyyThNI1Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=h2dZmtBoXiYuedy1nP104BKDQPdvtQKzz7BP/J+HxZc=;
 b=cCD9X9FNf/gRkmAPfifDxeSwnGEMy6dLteYktMjjM0kpSb7yuDXvYjOU0urAc9+sDGxGn13YNHd4oDhNKe3iFjO2lyrPiLN4ZDXla4D99QiZAWjyH2FlU+7qiTC6On/gUzseVk0tbbtUHjor/UallbcZTb7dv7mOwrkufTy1kxqsqEFKqS+wWWxaAa/ZQfhEqDqIuvn8ME/1Y6KvK412nWGepgars4A0AWXTXxqAggUWtlPYHxrJkSz7jURKTrUvY71+ODpqCKGfQ0fJfIhdPVJdukxS3K+eQiGEcWwDgsDs8YIEKO51sZ2fe4I9HqAl8cjVKYhZZA1BBevXAbnFZw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Received: from IA3PR11MB9136.namprd11.prod.outlook.com (2603:10b6:208:574::12)
 by IA4PR11MB8992.namprd11.prod.outlook.com (2603:10b6:208:56e::17)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9073.21; Mon, 1 Sep
 2025 03:31:56 +0000
Received: from IA3PR11MB9136.namprd11.prod.outlook.com
 ([fe80::604b:77a4:b1be:3f13]) by IA3PR11MB9136.namprd11.prod.outlook.com
 ([fe80::604b:77a4:b1be:3f13%4]) with mapi id 15.20.9052.019; Mon, 1 Sep 2025
 03:31:56 +0000
From: "Duan, Zhenzhong" <zhenzhong.duan@intel.com>
To: Nicolin Chen <nicolinc@nvidia.com>
CC: "Liu, Yi L" <yi.l.liu@intel.com>, Eric Auger <eric.auger@redhat.com>,
 "qemu-devel@nongnu.org" <qemu-devel@nongnu.org>, "alex.williamson@redhat.com"
 <alex.williamson@redhat.com>, "clg@redhat.com" <clg@redhat.com>,
 "mst@redhat.com" <mst@redhat.com>, "jasowang@redhat.com"
 <jasowang@redhat.com>, "peterx@redhat.com" <peterx@redhat.com>,
 "ddutile@redhat.com" <ddutile@redhat.com>, "jgg@nvidia.com" <jgg@nvidia.com>, 
 "joao.m.martins@oracle.com" <joao.m.martins@oracle.com>,
 "clement.mathieu--drif@eviden.com" <clement.mathieu--drif@eviden.com>, "Tian, 
 Kevin" <kevin.tian@intel.com>, "Peng, Chao P" <chao.p.peng@intel.com>
Subject: RE: [PATCH v5 02/21] hw/pci: Introduce pci_device_get_viommu_cap()
Thread-Topic: [PATCH v5 02/21] hw/pci: Introduce pci_device_get_viommu_cap()
Thread-Index: AQHcEy/SWdP0XuMIEEmlrKJvbaEB37R2YPIAgAACfoCAABL+AIAAAI8AgAAxxICAARvqgIAACdtggAEaboCAABozgIAEp8vAgAAHq4CAAAjDsA==
Date: Mon, 1 Sep 2025 03:31:56 +0000
Message-ID: <IA3PR11MB91363A1E47BDE61A6227DC799207A@IA3PR11MB9136.namprd11.prod.outlook.com>
References: <32c0a5e1-6529-4978-a0e1-32940e806dc0@intel.com>
 <e6300798-19a6-417b-902f-57fa7ae20355@redhat.com>
 <1ee98764-d57f-4ff9-9018-f07d8ee5d68d@intel.com>
 <153e1475-6678-415c-86bf-b7251cb59f3f@redhat.com>
 <aK8kqQOV28V36wtM@Asurada-Nvidia>
 <ecd95fc6-ce8f-484e-b685-d78a382f1705@intel.com>
 <IA3PR11MB913632FB83D138289BB718C2923BA@IA3PR11MB9136.namprd11.prod.outlook.com>
 <IA3PR11MB9136978139DB0DA6A2A06C82923AA@IA3PR11MB9136.namprd11.prod.outlook.com>
 <aLEd/YAwfhXD2Lro@Asurada-Nvidia>
 <IA3PR11MB9136C7C18941F5DFDA44FCF79207A@IA3PR11MB9136.namprd11.prod.outlook.com>
 <aLUMK1P3fQ7ZGMDl@Asurada-Nvidia>
In-Reply-To: <aLUMK1P3fQ7ZGMDl@Asurada-Nvidia>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: IA3PR11MB9136:EE_|IA4PR11MB8992:EE_
x-ms-office365-filtering-correlation-id: af538223-5510-41d0-4562-08dde9081a53
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
 ARA:13230040|366016|1800799024|376014|7416014|38070700018; 
x-microsoft-antispam-message-info: =?us-ascii?Q?6V0+kp6q+K2GzUEsT+JgE48NwFhx+qdOQ0+SKToELa6EB9LAKRHCx0B0+rtO?=
 =?us-ascii?Q?2UaN0v90vblZMnLCOFofDdS+OaxSg5c8F1qeqYK/kP1pKsgp5njp36z/UvcA?=
 =?us-ascii?Q?sqskAcbeHOYsbz6IETF5sSFy1Div2uTh83sduzP6bAmZ7WBo1Tazj7Boqpqx?=
 =?us-ascii?Q?hfcsGHeoluiawQl8Ez9bWYbC7JtbcNI7TFAzr2aW/HsBJ3DJS0virjV9LwBr?=
 =?us-ascii?Q?l6rjrBzxYHUmGoA8wO+pe3e9CJBnmBY7FA/MkHtZmU03TlyvmZftZgnhSGCM?=
 =?us-ascii?Q?4X5aFapE4vm7i5FBOymp3W4oksabXLC7qpw5uMkboNsoAffVFLmvjANqX8lH?=
 =?us-ascii?Q?T2JMtplGodJL9OgTnUhGieKe/q9/D5IX9WKkbT1AmZX9PREgI+JCZkaANX7B?=
 =?us-ascii?Q?7waLkTJfyaSsvVGsUIy2qIV/4CDu2O7cHrSy/NMk8fEtyldGXCJb5r2fzD49?=
 =?us-ascii?Q?TYTMl6RsuCSb8rHcucOV71lpTIGFyDI7pFG/FUw4CqjUUdX0jLzCh2YsWYhS?=
 =?us-ascii?Q?s4g3ffDxN8sdwY7ExUg3xQ44LFYbCJN/kU8h+xrc74VUK4/ByvBRXf2zPELK?=
 =?us-ascii?Q?DgivLCjrz54mD6WPLLhyt13zrF3Fe7j2o2yLILTUE4e4agVRmoG1fKQHimlX?=
 =?us-ascii?Q?9ECJ8VvNrc45pS3yzINmu/JkeRzcd1zhzspkCw3pFFGT/b30dFUKydHPSwpt?=
 =?us-ascii?Q?8lKhLBrayY6cleb4ZKDw+AIIg6clPD1yjZrUYm+UV0JUy3QdVjjXfe6yzyFr?=
 =?us-ascii?Q?jKJik5vLtwgWuePAJ1m9tR+4RNCXZK/n0PqCAJ5SQNAbvr0QczlJFT0tah2w?=
 =?us-ascii?Q?1356HqSTrimn8sYkU6JNH/uet9tx5FyhwRHrI4104BsYYXwrYvOKSMkzT0BH?=
 =?us-ascii?Q?HfMBqJdn4iY7d0fGz5lT+ToON6JVEdXl3+pZ9uKHW8ZCz4Yw+CS18L889p5E?=
 =?us-ascii?Q?NaTchwzUlQGQ2plt6xT5egGJ7Sqt0be6eaKE8TOTfmrqkRuae62+cg00DQQO?=
 =?us-ascii?Q?py/2znxjeydIgTDO48fGt9nZfotjA1Y9JU1LZ2ai62HccppaaFH5wFOfx6JA?=
 =?us-ascii?Q?fROxsErP2uuFa97iIHinH18utnIfCyqZR8/CSRchB/I3Ek37ev4K1pEnoiPE?=
 =?us-ascii?Q?WLLw7YqoN1YrYBzRdU1MOg/Ngurwpoy5FEYa6afMIDNqqWjt7FkBXkoD/zTq?=
 =?us-ascii?Q?kcbMGbzpUBZIQ1onrg1JKvbgInF9uRSqcGNWe4QIovttteX6yDKOxjQ3Kjul?=
 =?us-ascii?Q?mycHYk8eCe1rlm0q+vJ1Yh0/BwqIwDdrkPgoo3NVQIt74WBr+YrKwdug/b1B?=
 =?us-ascii?Q?Sz+MA63+luF0ZATMLBj2sPB4Z0+5wOa3XqJN4mxv/k6Py8iVZ+OKDTK5DODh?=
 =?us-ascii?Q?E49iW67we97il5rsHife6wM+4tqVXPfT0toXeItIFaDnfH+tblvVRJ2gI2ju?=
 =?us-ascii?Q?4xvnSEAUTpC0coFhmsPwxJlj2MBYpUQYrZiRdTJA73RMJHXrPjippG8yNZS2?=
 =?us-ascii?Q?JLP4LOhAMtZ42NU=3D?=
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:IA3PR11MB9136.namprd11.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(366016)(1800799024)(376014)(7416014)(38070700018); DIR:OUT;
 SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?WmGmiJp1Rc7HFT2RigUi7i29ZCCuFFoIBvYxMg386fcBnTUmWSfhtdBSEKNZ?=
 =?us-ascii?Q?y3yHlanjQm+al4vS9pSF9FbeZisFvo1rbyHl04tr3n8ym6jv5F0PJ6FWvkvY?=
 =?us-ascii?Q?2mXML116oG7zAKYo/un4Iu1UJrDzVPcDdXpG/fHdnYrwVtgO48zLzfxAsQJs?=
 =?us-ascii?Q?0IrS1q/8z+W3Dl2qPHqV8v5D1rS2tL9uhUKMSkkrdEXzVNKli1YfsTLMW/HA?=
 =?us-ascii?Q?4wO4E65uyYvsKI4tcTfpEEgtcCIqDYl16CP0ZAkUTjwGHQzxWKnf2rbYKfY/?=
 =?us-ascii?Q?vgStc/axuyYhFFU7bGLE/c1/qDAs1SE4Eo/n5DjNxZGIK95AYqCr/dAwzpg5?=
 =?us-ascii?Q?ogMLWMCAPrs9lu3dzaY+jNbQGgRULjk9oye1Vda7V0KPCxZfCwA09yBzUG8W?=
 =?us-ascii?Q?ZyUe9uVXJ8lKCvY7+Hjwrj5WHLfbKtZUbXGtCxnVVX/u+ikZbx/UWGh6pXZn?=
 =?us-ascii?Q?JPN1v8w1fGMYNlwWPHg3jSMrA+Y7BRIjKJsKZTaG0/lbO3OrlZD0qsXLo8Ys?=
 =?us-ascii?Q?j8iIsUAfxSgHSnTwcfS1GX4MIlvucdX5EWliNaF1Cfbh+KQE3j2FKPFOqo9z?=
 =?us-ascii?Q?JJwUCOQP8YG5gFPEjIATGp/3WODtlQPO0bxbXavpBp+WvD2r1h0ol/IVWf8y?=
 =?us-ascii?Q?tZlJuUe+/xMg2IlgQdajor5D9i/6nYO1BHNLS3gJhpii+k1z9qsNsIZFApGX?=
 =?us-ascii?Q?xS/jrIey1e3wO350NbuhtRTPl1KlT//m2DM/O1ggE1FEqlfKgyAIhxiXlvHZ?=
 =?us-ascii?Q?GgXCef5ALsiBelpDzVAuENyFKOpZaQhOsJLjjmU4JRJbiNhobGSHGB4nF8TJ?=
 =?us-ascii?Q?LrqZ2PLJC32hvXtAoc3oEnuhoM7codKSZLzMk1rqr/c4jvFYap1Sj6UdDRgM?=
 =?us-ascii?Q?DF2/NlG4q7Zo9izb3TYz4PJ6DkswEnSkqBAY100g+32j5j3cRI2yyRTmFQpy?=
 =?us-ascii?Q?6c580EX/YIQGz1P4QB1ZpbPK2dkSRwjF6YJE0fmL4FpaWMTcxpOqm+MU3X99?=
 =?us-ascii?Q?LMWa2k9OiKwpoMhh0/WZQkXwlpZFknxmbQ424cVwVG3GeZFfD0n1Zzze+CIc?=
 =?us-ascii?Q?q476w7Ch6OLDFYy6txFQyOJBxSbrgN42lg1faCF8t7/fltZtU/hKKWKkKInb?=
 =?us-ascii?Q?5dDgbq1yKZW8AAryH+xgSQF9GK4uEE261Sm5/jPc29mvwSddjcao0tdCPhFg?=
 =?us-ascii?Q?eXZgjNl7HScMDBHrQ7FZnTIhXgzCHT1EC1bphthNuWaeDFScSlMy1Jb1abiJ?=
 =?us-ascii?Q?DorMHq5XhSH59cvqkgpPy2pXJoYSo4/9+4LhNnSd1PnwiSlKTS1NjFYHX5E/?=
 =?us-ascii?Q?NjBrOlrglLaWOgDE737USSsbu/ROovolhFLVctxdIpiturqpZRp8GlVZFRcz?=
 =?us-ascii?Q?xd/2Rm9AylJTHNALz5AqkbBmGNPFLEY1sT8iTXHSwNjx/0K850SdEbRLV0/s?=
 =?us-ascii?Q?9q5/e/rpS1MXDUM82aUFgkRHvdgvPzrIDfTpTLpeAhYzGujsRtsXHuyIciHf?=
 =?us-ascii?Q?HdDPouM0x6omw93OdgAMUcN8auQDK0kP1WE57dvbQQ+PqveTzKyMK6rPDj0y?=
 =?us-ascii?Q?qL9anTM2pKwYiAWCa4uReAOtUgXAVVPwCA4uQ5je?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: IA3PR11MB9136.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: af538223-5510-41d0-4562-08dde9081a53
X-MS-Exchange-CrossTenant-originalarrivaltime: 01 Sep 2025 03:31:56.7011 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: fZypuyaClbzos7BfM9gxo3X6P16ljMO8XUZr9eYWjbHdGiSQkQePY6xBjZN+nqtcSQPs9ciKI4uDY1QPnOe7vuBo0QyH2gys69SwaN3X3qI=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA4PR11MB8992
X-OriginatorOrg: intel.com
Received-SPF: pass client-ip=192.198.163.16;
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



>-----Original Message-----
>From: Nicolin Chen <nicolinc@nvidia.com>
>Subject: Re: [PATCH v5 02/21] hw/pci: Introduce
>pci_device_get_viommu_cap()
>
>On Mon, Sep 01, 2025 at 02:35:29AM +0000, Duan, Zhenzhong wrote:
>> >> I just noticed this change will conflict with your suggestion of usin=
g
>> >HW_NESTED terminology.
>> >> Let me know if you agree with this change or not?
>> >
>> >It wouldn't necessarily conflict. VIOMMU_FLAG_WANT_NESTING_PARENT
>> >is a request, interchangeable with
>VIOMMU_FLAG_SUPPORT_HW_NESTED,
>> >i.e. a cap.
>> >
>> >At the end of the day, they are fundamentally the same thing that
>> >is to tell the core to allocate a nesting parent HWPT. The former
>> >one is just more straightforward, avoiding confusing terms such as
>> >"stage-1" and "nested".
>> >
>> >IMHO, you wouldn't even need the comments in the other thread, as
>> >the flag explains clearly what it wants and what the core is doing.
>> >
>> >Also, once you use the "want" one, the "HW_NESTED" terminology will
>> >not exist in the code.
>>
>> OK, will use the *_flags and _WANT_* style, do you have suggestions
>> for the name of vfio_device_viommu_get_nested() since "HW_NESTED"
>> terminology will not exist, what about
>vfio_device_get_viommu_flags_W_N_P()?
>
>I don't see it very necessary to have a specific API per flag. So,
>it could be just:
>
>    uint64_t viommu_flags =3D vfio_device_get_viommu_flags(vbasedev);
>
>    if (viommu_flags & VIOMMU_FLAG_WANT_NEST_PARENT) {
>        flags |=3D IOMMU_HWPT_ALLOC_NEST_PARENT;
>    }
>?

OK, make sense.

Thanks
Zhenzhong

