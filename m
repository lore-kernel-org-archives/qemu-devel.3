Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id BF536CD4F57
	for <qemu-devel@archiver.kernel.org>; Thu, 13 Nov 2025 08:51:35 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vJT2O-000583-BG; Thu, 13 Nov 2025 03:50:40 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <zhenzhong.duan@intel.com>)
 id 1vJT1k-0004me-FB
 for qemu-devel@nongnu.org; Thu, 13 Nov 2025 03:50:02 -0500
Received: from mgamail.intel.com ([192.198.163.11])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <zhenzhong.duan@intel.com>)
 id 1vJT1i-0001Kc-1x
 for qemu-devel@nongnu.org; Thu, 13 Nov 2025 03:50:00 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1763023798; x=1794559798;
 h=from:to:cc:subject:date:message-id:references:
 in-reply-to:content-transfer-encoding:mime-version;
 bh=zsr8golORmJietntTT3qya81rLdFqkeczy9p8AdrpQo=;
 b=HQjYuiLOnbY+r/21cZDjUuDatLzRWPtoB87ePwMQQKHk8xeyBF8bIGWk
 T39U5A/9iA9iJwwxMrmfnKqze4q0BimlsmQDBfOeXSCEiefxHhg3SLyD6
 h7Md4y7RXqerE4/JCT4xrGwkRfgzGdeErfw/DilOWq5wZey1kTVOfDjXE
 nCxLcZRHbWzBnodgePXS7dj6jC7W8hQJyOWH8iV8l15c3vbLV36iJkm01
 1t2Q+HvWfJiMNCQpJsh8d0m7GoVoWAxHtBeQP6EOkXpeYuUr3a8YR6zdL
 v/w/1KNYOcAGJRqXOW2pSIRMFYqAd/JkCXTld3eOp6OI80ZwaWo4pldqH g==;
X-CSE-ConnectionGUID: OE86wPCHQVWkwzpHvnKGfQ==
X-CSE-MsgGUID: qtUATZdFSJKCzSa4Redtqg==
X-IronPort-AV: E=McAfee;i="6800,10657,11611"; a="75708315"
X-IronPort-AV: E=Sophos;i="6.19,301,1754982000"; d="scan'208";a="75708315"
Received: from fmviesa003.fm.intel.com ([10.60.135.143])
 by fmvoesa105.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 13 Nov 2025 00:49:56 -0800
X-CSE-ConnectionGUID: Zvef5AzGSJuO5NTgj9YqKw==
X-CSE-MsgGUID: +G3eWrbFTTK1YjyDDq+deA==
X-ExtLoop1: 1
Received: from orsmsx901.amr.corp.intel.com ([10.22.229.23])
 by fmviesa003.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 13 Nov 2025 00:49:56 -0800
Received: from ORSMSX901.amr.corp.intel.com (10.22.229.23) by
 ORSMSX901.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.27; Thu, 13 Nov 2025 00:49:55 -0800
Received: from ORSEDG903.ED.cps.intel.com (10.7.248.13) by
 ORSMSX901.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.27 via Frontend Transport; Thu, 13 Nov 2025 00:49:55 -0800
Received: from CY3PR05CU001.outbound.protection.outlook.com (40.93.201.63) by
 edgegateway.intel.com (134.134.137.113) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.27; Thu, 13 Nov 2025 00:49:55 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=Aa5s1WwbciD8py1ZSFgHkcfgvH70ED6bvDAUW6JyH57qCqQBQZOzgXT8ffAYxwMCjSTAGcbl6eeir0NCV3uszKGZk/F04f3JHDxTeEA5A6gM9w4LRh389jbdC7+OxxPrqHaO0qS6NtiWVMz+F7V3dk6Ncly4W8pvCTZVpb+EzluEHmhhnMyfmftrr16DvdDB9eD+iEfJjnfEoMIAt4SOdLaB8iTictYM5ugDgwAG8PyLgX4Rm7qJ+hJ0cgQBmgX1ajCb7zAmCBYlLLLdwmuMfHzloILat9ZcVAe0D0e4DwUoZOa7AtQ2SFyC6zEFXwp2RGBLaRrgyn+/8n97ut+fZA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=s2GGA8yOsbokEcXCkC1qrZxZsY7Ihh139eXlne46yy0=;
 b=G31qdgW+mJfH29FkWS/wPt/CbDtHlWTkWTYxjOVLPpARNHr2261emfqY+TwTtFJd3AMkSWj1Nlp8OORNJpixbMshhJQmu/jXFRMGBrpl+1E38NZCDY/j4Xa4iEtwjCWh0LKzaJyeSPCNJ8f6it0pext49ZCX4tOouubSBWWXioMWBmeLb7ihXEtU3gOhT+YHYU7ZDOjGAuMfoaeqtL8rfpMYJbiWkIuTrqSUhf9D3MkPfqg3fViYOQJjbvYK0Gf8R2NK1/7XXsT/doUQ/Qb73WdVIFYbyvjoLwiOIadyXrDKqZX41Tty3SEWSGrIGKGTFPMuZBBMwVpzyD7XqXkJ5Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Received: from IA3PR11MB9136.namprd11.prod.outlook.com (2603:10b6:208:574::12)
 by PH0PR11MB5926.namprd11.prod.outlook.com (2603:10b6:510:14d::14)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9320.17; Thu, 13 Nov
 2025 08:49:46 +0000
Received: from IA3PR11MB9136.namprd11.prod.outlook.com
 ([fe80::604b:77a4:b1be:3f13]) by IA3PR11MB9136.namprd11.prod.outlook.com
 ([fe80::604b:77a4:b1be:3f13%7]) with mapi id 15.20.9320.013; Thu, 13 Nov 2025
 08:49:46 +0000
From: "Duan, Zhenzhong" <zhenzhong.duan@intel.com>
To: Nicolin Chen <nicolinc@nvidia.com>
CC: "eric.auger@redhat.com" <eric.auger@redhat.com>, "qemu-devel@nongnu.org"
 <qemu-devel@nongnu.org>, "alex.williamson@redhat.com"
 <alex.williamson@redhat.com>, "clg@redhat.com" <clg@redhat.com>,
 "mst@redhat.com" <mst@redhat.com>, "jasowang@redhat.com"
 <jasowang@redhat.com>, "peterx@redhat.com" <peterx@redhat.com>,
 "ddutile@redhat.com" <ddutile@redhat.com>, "jgg@nvidia.com" <jgg@nvidia.com>, 
 "skolothumtho@nvidia.com" <skolothumtho@nvidia.com>,
 "joao.m.martins@oracle.com" <joao.m.martins@oracle.com>,
 "clement.mathieu--drif@eviden.com" <clement.mathieu--drif@eviden.com>, "Tian, 
 Kevin" <kevin.tian@intel.com>, "Liu, Yi L" <yi.l.liu@intel.com>, "Peng, Chao
 P" <chao.p.peng@intel.com>
Subject: RE: [PATCH v7 09/23] intel_iommu: Stick to system MR for IOMMUFD
 backed host device when x-flts=on
Thread-Topic: [PATCH v7 09/23] intel_iommu: Stick to system MR for IOMMUFD
 backed host device when x-flts=on
Thread-Index: AQHcRMKJBSJdriWV/0W9AV5g+if9pLTb8bsAgAAUFKCAB20/gIAM99Yg
Date: Thu, 13 Nov 2025 08:49:46 +0000
Message-ID: <IA3PR11MB913601A8CED05990D273CB7F92CDA@IA3PR11MB9136.namprd11.prod.outlook.com>
References: <20251024084349.102322-1-zhenzhong.duan@intel.com>
 <20251024084349.102322-10-zhenzhong.duan@intel.com>
 <d9eedc35-1548-4011-8eb3-5f6a4dcefe51@redhat.com>
 <IA3PR11MB9136B987085148D724C0144092F8A@IA3PR11MB9136.namprd11.prod.outlook.com>
 <aQq6W3EHf0rM0x2Z@Asurada-Nvidia>
In-Reply-To: <aQq6W3EHf0rM0x2Z@Asurada-Nvidia>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: IA3PR11MB9136:EE_|PH0PR11MB5926:EE_
x-ms-office365-filtering-correlation-id: 3db2ae69-ae23-4538-978f-08de229198eb
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
 ARA:13230040|1800799024|366016|7416014|376014|38070700021; 
x-microsoft-antispam-message-info: =?us-ascii?Q?p7RNHDfIjgIDO+RyF7P1w9e3gVYLoq8Bh7tDkbARglvvkuV80RW9EkacQOPH?=
 =?us-ascii?Q?56MOOk9jkinfjhaeP2TJ8uEdmnWvEgdyToWbHusEGopRqKHf9duA/R9Xk9Vg?=
 =?us-ascii?Q?BNgHpBgSZmtJXhwojggHOYRYbXJg64s0GPazfZdK1tSQ9FnUtkaxJYtCqEwV?=
 =?us-ascii?Q?oylJT1fRNlyLcVcm1+XpZ+HAj3q4iRTaLeSLbrZ3kP+n+PyyIA80HYEQ7Twe?=
 =?us-ascii?Q?rya4M2e+Ce9X0x0jhFLDA6vfR+LYOoYV0JKXJPXLJV0Wk+Od2izePE5uMZ+y?=
 =?us-ascii?Q?w+3HDLyNmWeYV1RNNV1CJtyuktVIqWOQRMciHWl5XT8PMAtQH/UlRtVmnnQo?=
 =?us-ascii?Q?cRwZOtoW6MdhQMHxWdw4tM095iorhpFwJYsUOwiWJk065eymMAlxQDqrzzzp?=
 =?us-ascii?Q?rCnXYcmZfp4+wlyxvVr4ifo2gmW7GAHYiT07w52553y5IozAOE1qzjX4+yaz?=
 =?us-ascii?Q?iwg5Z7hGZzEHgBTkZDHZ/MdcqWIHMJcgs9PBJ0RbDfA/WlPjqysS9qBPe2BV?=
 =?us-ascii?Q?HMoXT2LPZ39x3+kNFNiAb9CKhKfceRFtVX5KsYD0fLpfRVUt1E3tVAHgtBsh?=
 =?us-ascii?Q?7L7/R9/bONzzmVjIcpAYpbcUzHKejixGq4emFA8vrGPc/yV1AjqaPJP9arl+?=
 =?us-ascii?Q?a0CyZT0fkrjRPmS6UXtm+r9V8nZeZn9YbF6gil7ftl863naQ8X0qVwIzgE3K?=
 =?us-ascii?Q?YXZgWr60+DCr7SxkyZx1yg/lznGlHAnkPbCLtskpTNFK5+TDteZPJh/CL8BY?=
 =?us-ascii?Q?3R5GqjQELam97RMWT7j2QmKFhskSwoSNi6Wy1m2j1ddQ/wcrV8jtfGCW23j1?=
 =?us-ascii?Q?GYUQ4k6XU9KHaid/PSfVdp9x6Emz6tMt2hJCj9p2BUAFlB48z4JQALbuzuJk?=
 =?us-ascii?Q?MBqPpCriGW7gtEFgNyKd63JC8dD1fYO2tvKACOt9IfRDtPigtcGxS/z1P6fy?=
 =?us-ascii?Q?60M7BlHoqKvOIUh2AecefntlteBkIm6DaSGD3vEgUp1dzyT/xRTvHbACAT38?=
 =?us-ascii?Q?/N8enXj2jBCW+EZ27/fSrw9OkhghQX+66OjXLBvLvZs8Irn6LKrkuQSgF0p5?=
 =?us-ascii?Q?B/rigZBYP1Crou+QCzndESOnh188MUmyS4iMFW/QAu2AV39Vx/9Tx/vJiBJO?=
 =?us-ascii?Q?U+6agzg/5ZvOjCcxA/oWYo3qBPXAg0C2elhBQwBrimfgUZONd5icepoMbhOX?=
 =?us-ascii?Q?6RyiPWfZ91JlCovA1DztmgW47/4aFyERDsbqAzxcq2f25W5ufe8zvBXu6fUr?=
 =?us-ascii?Q?ml56ZiGuynK5yqD2BKUStVKlz/jC3vIdV5UQPUVTM04YeHOIy311H25SCK31?=
 =?us-ascii?Q?hsYuxc0IoG7iAbhyzEj0Gu97TtULJ0yso83I54SSZfzRzwabOtAmEYz2mSaU?=
 =?us-ascii?Q?4u6lACuaHQNzyLWDw7REjxchkTOpS5TSaHlnf8+qdCzVOmvyFYi6YITfwkN+?=
 =?us-ascii?Q?EUKlfCK2JeSY2eeyQzRxMxNnFPJ+4P9+4Uiit+9lSNBIJy6VZXol4Un4XN5U?=
 =?us-ascii?Q?7JQP8GwEja/2rzbJY1ozj0YUw0/lw1IYF+aC?=
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:IA3PR11MB9136.namprd11.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(1800799024)(366016)(7416014)(376014)(38070700021); DIR:OUT;
 SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?aKQKuBHg4hpKOX05RUntpxgXGOnAAXtf4p5KHpsYkCa4qj/6joeBrvBYlYIs?=
 =?us-ascii?Q?4iXdnlsvYjB6unQNssyAB7jtHVt0k87pYlpSzRdcANfb6iMsoTe1dtyWLLWc?=
 =?us-ascii?Q?8CicRUhnpx4XjjZWL6ifqTidNFsW3SZN3DvI27l53/tUQLRkHkpXB04TGJmu?=
 =?us-ascii?Q?6CiwH+TdCOMgqLGU0BcIUhF2ZhXLWoXIjCfx5+08J2tVJCgSU/B957QC1hRN?=
 =?us-ascii?Q?MmqxulrX6W6kPRRg+n6shqgM1UE9CrTAKN++aOFP6zEIgW8lRxFfRB9+7LQ+?=
 =?us-ascii?Q?He8cUza2kI4dvQ7bugbUZIiFNzPjuECgLx5gP5IJhlwNbj5UHTXv0YNXcFtL?=
 =?us-ascii?Q?nUOn8yLAR/YnYooIjbFbKXxHmfPLFIhpXPL5fYeeM0RUJgLniDIc/2ZcYJFN?=
 =?us-ascii?Q?og3ArW+Bqja1xAwqpoNLZEoSBRdX5u9FXQo3UoiDq/pTkHHpWcX+mbKQ37P+?=
 =?us-ascii?Q?1f/jDeoLkxUAiVeep1Y+NEv1CacFGVtRHqfCDFlmsi+yhjtARelIMchLXdyI?=
 =?us-ascii?Q?sJhJ4jque3rnT31o5E7KUnV8AQjjo1RkvZomD95oXb8KWPSReB2jA837DCfu?=
 =?us-ascii?Q?aK/o0chHXBFUAseZ023KF4GejPwNE6Peuvf6qBj0ITiW1UQsoilK4R46CvLN?=
 =?us-ascii?Q?A8euJFwTw6PE2STUAPjzkiVGGo4YSe+Mu9KnCoqsm4jyO70E/wnSQquso/Zl?=
 =?us-ascii?Q?S4mOEXRnS4om8GPAJYEHPOb/bqgxGZ7bKHNZflTwh+jjbQObW6E9KEJ2dMv6?=
 =?us-ascii?Q?v/xCE4WYvnQw9Khg9qrJm6wWmyuTgiYcQt3usCPxLDeRhB5cae2kGOS5e6Xp?=
 =?us-ascii?Q?H6K3JVAHT0R2dqhwoqUgMhIfRmJwwlTJjq/zh/93uA/W0S3h8SEABkGx/QoY?=
 =?us-ascii?Q?qHjSMP5wuRXntuSavYtYb98Wq3CyZY3mRBaS2y3FKuRKi6a6EtlDS1to97Po?=
 =?us-ascii?Q?xOWFGmelrosrI7j73U6U7iDg+Z3Qm/FKjbaUPiZPbqYuWDx6TtX2yllxp4zV?=
 =?us-ascii?Q?EWeJs9kFukn+B/QYoLQJ8dIUFo0Nyb+lNM8u/USULL/VhRy7AodSqUz8PIPm?=
 =?us-ascii?Q?Uoy+QX4/gRZUAMr49DQMOErQu7ufngBK/vKEAkG+6s6/Rtl1mjCnjcoVNqBo?=
 =?us-ascii?Q?n7WmjsFLkaDDNFQc4XAb2Qs1kiQB3c6+R7t2aieCCoFrWFQiEiQqzF1HZ+ND?=
 =?us-ascii?Q?HkR+InIXf9ZMVV4qLkEc5xOIRotJyrgGwnlJNn9BUhpUGoWQrsQTjoXH65R4?=
 =?us-ascii?Q?SPY9rNF9r+AwTEMbA8+ParHkhI1wZRRgpb/lKirbtDk/dm0dR3EVXC7XLtjw?=
 =?us-ascii?Q?fkIa9uegKCr8E462RRz9gevkZ2YAWLFbzq5JGo7rMU4jgEhy1osr5ujBdOX9?=
 =?us-ascii?Q?MMtu6HqoCIMw7v+1z/FHqvM2RJdkBjpOMRBWU/7IflIb841u2Br2faFs5Ilc?=
 =?us-ascii?Q?59x1LHBe0l9ukk3VoXbebYHqAMVkz8zPxiwvAIMLC0EW3n14FUXcub1bCs6i?=
 =?us-ascii?Q?eOO+4P5Wpqq4YqCbB3BfYRCWF42l5/s4tkqEWQto3kHPjKMjPHYbYmAtNCgx?=
 =?us-ascii?Q?27o80WzYHFkCQC6gt0grTsmu7GjzhuWJPMuYOtn7?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: IA3PR11MB9136.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 3db2ae69-ae23-4538-978f-08de229198eb
X-MS-Exchange-CrossTenant-originalarrivaltime: 13 Nov 2025 08:49:46.4262 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: esQ0mubr2ko91ubc4fqss7moaHBdt8A6h01gpDtC8FOA1Is0awolA/8Y66JEJsoHdZJYQ6hJI+T4XMgFQkY7FdHn1+QwINNehvZKZW0tFbA=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH0PR11MB5926
X-OriginatorOrg: intel.com
Received-SPF: pass client-ip=192.198.163.11;
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
>Subject: Re: [PATCH v7 09/23] intel_iommu: Stick to system MR for
>IOMMUFD backed host device when x-flts=3Don
>
>On Fri, Oct 31, 2025 at 09:52:16AM +0000, Duan, Zhenzhong wrote:
>> >> +    /*
>> >> +     * When guest enables scalable mode and sets up first stage page
>> >table,
>> >> +     * we stick to system MR for IOMMUFD backed host device. Then
>its
>> >> +     * default hwpt contains GPA->HPA mappings which is used
>directly if
>> >> +     * PGTT=3DPT and used as nesting parent if PGTT=3DFST. Otherwise=
 fall
>> >back
>> >> +     * to original processing.
>> >According to the above comment you have a S1 translation in place but
>> >you set use_iommu =3D false and use system MR?
>>
>> Yes, we have extended the usages of MRs under IOMMU AS with nesting.
>> In nesting mode, system MR on/off isn't aligned with S1 translation
>anymore.
>
>Does Intel vIOMMU need S1 translation when the working in the HW
>accelerated mode? I thought everything is handled by the HW..no?

It needs S1 translation for emulated device. For passthrough device, yes.

