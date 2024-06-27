Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1A28BC3064D
	for <qemu-devel@archiver.kernel.org>; Thu, 27 Jun 2024 11:33:30 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sMnN1-0001vP-VX; Thu, 27 Jun 2024 07:32:56 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <zhenzhong.duan@intel.com>)
 id 1sMnMz-0001v8-9D; Thu, 27 Jun 2024 07:32:53 -0400
Received: from mgamail.intel.com ([198.175.65.10])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <zhenzhong.duan@intel.com>)
 id 1sMnMt-0005vS-Vq; Thu, 27 Jun 2024 07:32:53 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1719487969; x=1751023969;
 h=from:to:subject:date:message-id:references:in-reply-to:
 content-transfer-encoding:mime-version;
 bh=ksg5VsWqYusGw9sHWhOAtssMyx0ZS9wIzEW9d0hu1vg=;
 b=Dz/sLayXzUP3wmoSjfyOWeuVHpKfeeKAQU7kOi0iUJyI/wMB85TjItyH
 NzyYF6JKZHoDiiNYitEq8Ipmo5upy1fVfzMUWjHVh3F6/JCIABz0qHRke
 rs82Gp3WbR9hPV6yqjhxqVb5z7lIM9ZMhU2JcMkmcpY6yOYHGjodbyiox
 qJOhykgft2clDr23+7FMivNvSj1PCRK4dlmeCwSw4gadmw9WvUxuXxDdf
 D9qbuJmvkEPlSGkfGOtXh/mi0qYxFIaf1qi8CdNLly7Dwliv4Ey8Zk/8M
 cXWZgX53Cx1QEY/XFC9YefWJUxgOJx2SaEEzGQW4x9M0B1KPi8t5PuQV1 g==;
X-CSE-ConnectionGUID: 0yhKLmh+QsKS+/1TaG15DA==
X-CSE-MsgGUID: 7SdzYWaKTzy++99we76c8w==
X-IronPort-AV: E=McAfee;i="6700,10204,11115"; a="34061602"
X-IronPort-AV: E=Sophos;i="6.09,270,1716274800"; d="scan'208";a="34061602"
Received: from orviesa007.jf.intel.com ([10.64.159.147])
 by orvoesa102.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 27 Jun 2024 04:32:44 -0700
X-CSE-ConnectionGUID: lTjIOT/RTNuYEwknGLcwlw==
X-CSE-MsgGUID: 3RrcNHV4Skaw7Rf8lPmUbA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.09,270,1716274800"; d="scan'208";a="45006328"
Received: from orsmsx601.amr.corp.intel.com ([10.22.229.14])
 by orviesa007.jf.intel.com with ESMTP/TLS/AES256-GCM-SHA384;
 27 Jun 2024 04:32:43 -0700
Received: from orsmsx610.amr.corp.intel.com (10.22.229.23) by
 ORSMSX601.amr.corp.intel.com (10.22.229.14) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.39; Thu, 27 Jun 2024 04:32:43 -0700
Received: from orsmsx610.amr.corp.intel.com (10.22.229.23) by
 ORSMSX610.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.39; Thu, 27 Jun 2024 04:32:42 -0700
Received: from ORSEDG602.ED.cps.intel.com (10.7.248.7) by
 orsmsx610.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.39 via Frontend Transport; Thu, 27 Jun 2024 04:32:42 -0700
Received: from NAM10-BN7-obe.outbound.protection.outlook.com (104.47.70.46) by
 edgegateway.intel.com (134.134.137.103) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.39; Thu, 27 Jun 2024 04:32:42 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Q+VxpVw408kGRPPJxwxqBeBcdH7XS/IVl4kxRIinWqmQtT7BS6UcoonId1mDZIOBnYOeIJ52cl+kUe5EWyu1GgCQkaANQsOPq+oTP3YG4RibUyjEm0zSo5bFFtTTYn+uW6NgXGl+ZDjFpUgLukNLCE8bQ/QAO99aWXuUO31sqDOoSHIYePdQxfYV5HPqcPcbz/Nz8Tr4aKzyJOIsM8JtdNFdi3z0HSAysdLtMAiPopdbYlrhEtpA8vfwJyrL5fYTpgs2bubneax5/Myi1q9M74uQ1kbKKuHE7gwHhjDNcObcG4Tx8CUT+L3i+F0ezhzsbrPQwoyIN/0GvREN3AK7/w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=VxgDTx4CxAUz/7uXKKFLXK4EIzJQ6ymsQ4lfvfB0jz4=;
 b=HYdemuh3EO+XP4l2DK+G2PJl0FPgm/ncIO8/wFypnN35s/5TPHHhu7syTUfwpafpeUTQ4mx0VKYonz0EpuK3vACmQzZqK2EE+K/ih3lcMOKHBXfTGWz6dtd9usBcbbxJ4QDSHkcD2LTYSEuFee0QDODEKP3N4lJAr6K74dWrdXQGrTW8DEVRihNDICapUFZ0Mg6j+Ru2+fzhD4tXZ3MMb71Leb0MTYXTk3XO47n7HxUFD0JRTf0DDfv5uUGsLls3WJrf+PcauGg7zmkQfhnt8YL5gwAlpIdQUm05bihH/imGvySFKTvLE32Rj+Mj5f+aK5n3khLpPasL06QzSQK3sw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Received: from SJ0PR11MB6744.namprd11.prod.outlook.com (2603:10b6:a03:47d::10)
 by PH8PR11MB7144.namprd11.prod.outlook.com (2603:10b6:510:22c::12)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7698.29; Thu, 27 Jun
 2024 11:32:39 +0000
Received: from SJ0PR11MB6744.namprd11.prod.outlook.com
 ([fe80::fe49:d628:48b1:6091]) by SJ0PR11MB6744.namprd11.prod.outlook.com
 ([fe80::fe49:d628:48b1:6091%7]) with mapi id 15.20.7698.025; Thu, 27 Jun 2024
 11:32:39 +0000
From: "Duan, Zhenzhong" <zhenzhong.duan@intel.com>
To: Eric Auger <eric.auger@redhat.com>, "eric.auger.pro@gmail.com"
 <eric.auger.pro@gmail.com>, "qemu-devel@nongnu.org" <qemu-devel@nongnu.org>,
 "qemu-arm@nongnu.org" <qemu-arm@nongnu.org>, "mst@redhat.com"
 <mst@redhat.com>, "jean-philippe@linaro.org" <jean-philippe@linaro.org>,
 "peter.maydell@linaro.org" <peter.maydell@linaro.org>, "clg@redhat.com"
 <clg@redhat.com>, "yanghliu@redhat.com" <yanghliu@redhat.com>,
 "alex.williamson@redhat.com" <alex.williamson@redhat.com>
Subject: RE: [PATCH 5/7] virtio-iommu : Retrieve page size mask on
 virtio_iommu_set_iommu_device()
Thread-Topic: [PATCH 5/7] virtio-iommu : Retrieve page size mask on
 virtio_iommu_set_iommu_device()
Thread-Index: AQHax6LKBvX7uw/giUeSptmn9QNAe7HbeTnw
Date: Thu, 27 Jun 2024 11:32:39 +0000
Message-ID: <SJ0PR11MB67447467D606CD472F155D4492D72@SJ0PR11MB6744.namprd11.prod.outlook.com>
References: <20240626082727.1278530-1-eric.auger@redhat.com>
 <20240626082727.1278530-6-eric.auger@redhat.com>
In-Reply-To: <20240626082727.1278530-6-eric.auger@redhat.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: SJ0PR11MB6744:EE_|PH8PR11MB7144:EE_
x-ms-office365-filtering-correlation-id: 93c6b454-262c-4a89-e703-08dc969cda27
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
 ARA:13230040|366016|376014|7416014|1800799024|921020|38070700018; 
x-microsoft-antispam-message-info: =?us-ascii?Q?A2XHsffjiVPF+Yr29vaxS1xUbQshIen2yR3rVcZC7n2NOWsMi4BK35HU4jQJ?=
 =?us-ascii?Q?ExQV4lvScQVUzAAbfXkdBl74W+DKnF/lluD41dl1iAZghR92nysk8pC2ZJ2c?=
 =?us-ascii?Q?VDTNmipzIDN7pH7nmfhmPZLLqqF9poCHviQAa+l/esQSqXVG4VqTstrrPCqu?=
 =?us-ascii?Q?AjLLBaAvfauvn3cuANE0D8K30OwnU891xl/SxLaU3nKUzARZpRA6jSUaKvO7?=
 =?us-ascii?Q?gVTDhL0RiIW7rlZhmkq8tt5pkLPQrc44QU7oKCD5ckOd5LltPltY7Piv4sXX?=
 =?us-ascii?Q?mCbaCU+ar/nFRdDfSvVVxS/611dH0UlB+NdvOdp11/UKZzRBvwN7tziTlvDa?=
 =?us-ascii?Q?G35A9jnuOcyxlkwnLJg8bTsMQgGxpytxi/XhqwvoKqr+h7cJIT6LHzROxREa?=
 =?us-ascii?Q?kchomuF4YHyuItBhDFOSYH8+WEC0bLTp0F9vX3U7Ber464bqvRmfDMik4mwO?=
 =?us-ascii?Q?DAXYpA7YsYM4nRezyX7mlNzmFnqEAcK6M7o97p3jPIk2KHNkP0hedjWINQEH?=
 =?us-ascii?Q?vhFhYJuOMGHHpRKgeYcbMEm0j5739d1wvq3CDqoMRvlGv+cJkoXDfL2sWMe2?=
 =?us-ascii?Q?EBiFmNFNS4/PT+2PkDXjlSGU4rbFR9JoO4umiIoRyn1AdQlKsc8cVuLfjtB9?=
 =?us-ascii?Q?B0fJq4OKekNiQ60kbuRb6ui6WatNY71Exw1l6ghrnFkIqIchPQ+pLUdVbGSK?=
 =?us-ascii?Q?zXq7i4TJ/KaWQP0KkCZAnoULjA16djKrpKsG1Zibkr8CnejHiUtosH2GQ9AX?=
 =?us-ascii?Q?kJ1k8Nso4x745atz5SwWKAlntxn+CuS9FeeZh6HKC2zFSTvKwxUuHSyyYK3Z?=
 =?us-ascii?Q?6yOdU2pBNAI4vz4jxmmSqYv3eUNZ9y+O8Yo+cw2bCerM0aBfG7wnsV7c2mZ4?=
 =?us-ascii?Q?IghEpwaknzZQqN91jsTi5PlX4Zj0XKR9afjlEY6N9l6VJeVFTCg8Y+OX8Pud?=
 =?us-ascii?Q?SBjRN0whIpV35YdyH/54yTqn01dOIYfzbPd7LvFb8g6IW8ghMAxCLxm+VZyY?=
 =?us-ascii?Q?O0cwZazdXb+9LhJvdLqko1LaCSyy9OiyzU3J7SGXF1sYvKhrKK8NjiXvXecK?=
 =?us-ascii?Q?X8VbKQ7TqaRNLxb+WOOFzPFExoS3NcL36gBT1eU4swOJ3QUqX2eQMk1lWjr+?=
 =?us-ascii?Q?E3dJzgsRgA/nCRZyUywQaKywDgdtUj8eDUUT8g+EwXydtSmRkKUfTGIKqZ6Z?=
 =?us-ascii?Q?7DxnUFj0WCtrvWkjyfXytclkQ4ouOs5Pwz24sLUUfEuC8jclRe+Vr3KFWgCj?=
 =?us-ascii?Q?TUu3q6guqszrai4HExcIi7ke4I/JQLBddlntAuvhJfx2xH4Prib31I5Mq+Kr?=
 =?us-ascii?Q?GTrTLvaP9BmYGwLsACCW1+2NQkRvOy0r+ig0UximIjMiTJ9vh3zbaIK3Ct/Y?=
 =?us-ascii?Q?un8r3UXhenUjU+dHCKqnOPtVfa0wCF8fwFDeaH8z3sVmLtMwzc8O0IzRvqrQ?=
 =?us-ascii?Q?33ZPkK8yvm8=3D?=
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:SJ0PR11MB6744.namprd11.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(366016)(376014)(7416014)(1800799024)(921020)(38070700018);
 DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?kG2k6uoRFUl/7DbsFkoHI83UMA/r4S/Dn4K7R9dAVWs0ynVMpMqtbq5xOifH?=
 =?us-ascii?Q?zHGYP195e8mcaJajL3YuSVAOfRUzUi2rLY5DYbMXuxxcCAMZ8kKSx3ukz6mt?=
 =?us-ascii?Q?GtZw6QqZIbfwYPn8jeO4IuFa2r3YuMs0GBnVkVTV5w+rFIctUjp72j9p5jTs?=
 =?us-ascii?Q?OPiJR1utx1NlYDVAWywCgn6y9YA40esVcSZBdVBozn1nalUVS1inJ8rLKTPb?=
 =?us-ascii?Q?MK5ic37s4DNbLPuHY6CyWKp+geEd0huQMJRQiQbF8W72gf/DhRZfCVgYtqj4?=
 =?us-ascii?Q?+BnT/oxhPMw0Vqyd1S0WhfKwnNrL63Y0hR6wsjCeLan+t3JTl1HSDdewJ2U5?=
 =?us-ascii?Q?7UjrsFgq5U3PUYbOHXpY7KMlDOTGVi5069utuiyTilr/7w8U0da8nVEvnFY5?=
 =?us-ascii?Q?24Z91owKU3Psn7oMGTtWYAKZpWprFUulKbLAjGOAz8ddtjnySjwGsGyHvLDc?=
 =?us-ascii?Q?6vmcS+9c7HxBQBqZDDW2IyYX909sgmmVjgnFLurXsbeDXCidajT1lyBvsxi/?=
 =?us-ascii?Q?iyPF9O1G21V4GAn3JE/j+6k6GXAE62wKluuDU8+/HDC8I8BJTZUmIOGrJXnM?=
 =?us-ascii?Q?tCej0J+6VXu7ZxG6iRwXhSE7eEjFyQ3JO4BAm4q4yPME7uCEp6l/MQmV31jY?=
 =?us-ascii?Q?I2JTyrUej7muPgdnuB4ssaUYokpZGIsB5mJ3kLDkFe3z0y5U5J46ulZ79ANj?=
 =?us-ascii?Q?ssnN2XZ6mrB8QowvRbvwxB+5ogH+i7SBUBFM7KDH735SNVqkrZmRLOFClUrS?=
 =?us-ascii?Q?uLKXVvOPFbJ/+E4AOPQLCcxr+x+reSvp9QKVEaZ0hcmTBdoyWyVrlZb2nQtX?=
 =?us-ascii?Q?+6aBTAePetWF4BU6FlgroZUkGA4+5x84GqUvJ5TxQz7zG+nWa2eGoeXA3r6E?=
 =?us-ascii?Q?2iVPQSNIZTjuWiF9e3wiXUCM/5brNiOcC74MSwqsAAtHkJZb9SowEBJvy9Ru?=
 =?us-ascii?Q?lad5Cxy15/kgXIVwkIATKoJ/vUb+FbzELdwiqX3LZVbV5oJFK/X0mGLPOLy7?=
 =?us-ascii?Q?81wqsS4r4XR04+vvF2hCCvYPC2Q6WL6mUbbRMT/x+bORdGgHBI99ae/lii5u?=
 =?us-ascii?Q?fMWrp1EDdS5qY0ZekgFPu0afl+Z326NDaFrs696LAV6ph2uyxE8px5NukjcS?=
 =?us-ascii?Q?5WJ/VS1wrlA+BTC622lIOoj6xb11LT8jqw3ezetl38plMYdTsapzFblFZeco?=
 =?us-ascii?Q?XMr7j9uTCAe6EqelE4oDNZorjyaVN/kzalAWspQG+sQ+nCW0OVWTuHN1Fn63?=
 =?us-ascii?Q?1y26fzCDSqhxtmS6DCyJe1De/G+9TQhy66Q8UG8X9pIf2o7pfxbvs3YHj+Dp?=
 =?us-ascii?Q?hWooLCwCb3QHvxC6ckmVpOcvYjivmaSl6gm1Qfwi87HcRE2ZAytedkPnN8Zr?=
 =?us-ascii?Q?wFNFXrgqWIqAPBq8c//bQXnAJfHMjzrufl6ygh8RCOosegIjY0vDv7q1hino?=
 =?us-ascii?Q?tS4euzIi5PQnfEvGw718N7T0iMuSPL2WdfseHN/rao+ABI+tBEKc1cuXg/SK?=
 =?us-ascii?Q?uQz5X4MRTkJUvhSv/Xy3bb1FkpdLbv47If2C9YQBOyJsvD+aulhETxmwUev5?=
 =?us-ascii?Q?pWWXjoMt43Jy1ynof1xZ6YpT4NK7nGR8/uUi5+lk?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: SJ0PR11MB6744.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 93c6b454-262c-4a89-e703-08dc969cda27
X-MS-Exchange-CrossTenant-originalarrivaltime: 27 Jun 2024 11:32:39.8516 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: gNkRcXmpR98b7LVC9zXiILSM4f0/D9N9+F1femGqH0pFyYsw1lfNs4ZGQW+tbwpGeem6Z4B0wxCzh4rpJKvz54RteRn8ulcLJBLvn75OfXc=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH8PR11MB7144
X-OriginatorOrg: intel.com
Received-SPF: pass client-ip=198.175.65.10;
 envelope-from=zhenzhong.duan@intel.com; helo=mgamail.intel.com
X-Spam_score_int: -45
X-Spam_score: -4.6
X-Spam_bar: ----
X-Spam_report: (-4.6 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.212,
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

Hi Eric,

>-----Original Message-----
>From: Eric Auger <eric.auger@redhat.com>
>Subject: [PATCH 5/7] virtio-iommu : Retrieve page size mask on
>virtio_iommu_set_iommu_device()
>
>Retrieve the Host IOMMU Device page size mask when this latter is set.
>This allows to get the information much sooner than when relying on
>IOMMU MR set_page_size_mask() call, whcih happens when the IOMMU
>MR
>gets enabled. We introduce check_page_size_mask() helper whose code
>is inherited from current virtio_iommu_set_page_size_mask()
>implementation. This callback will be removed in a subsequent patch.
>
>Signed-off-by: Eric Auger <eric.auger@redhat.com>
>---
> hw/virtio/virtio-iommu.c | 55
>++++++++++++++++++++++++++++++++++++++--
> hw/virtio/trace-events   |  1 +
> 2 files changed, 54 insertions(+), 2 deletions(-)
>
>diff --git a/hw/virtio/virtio-iommu.c b/hw/virtio/virtio-iommu.c
>index b8f75d2b1a..631589735a 100644
>--- a/hw/virtio/virtio-iommu.c
>+++ b/hw/virtio/virtio-iommu.c
>@@ -598,9 +598,39 @@ out:
>     return ret;
> }
>
>+static bool check_page_size_mask(VirtIOIOMMU *viommu, uint64_t
>new_mask,
>+                                 Error **errp)
>+{
>+    uint64_t cur_mask =3D viommu->config.page_size_mask;
>+
>+    if ((cur_mask & new_mask) =3D=3D 0) {
>+        error_setg(errp, "virtio-iommu reports a page size mask 0x%"PRIx6=
4
>+                   " incompatible with currently supported mask 0x%"PRIx6=
4,
>+                   new_mask, cur_mask);
>+        return false;
>+    }
>+    /*
>+     * Once the granule is frozen we can't change the mask anymore. If by
>+     * chance the hotplugged device supports the same granule, we can sti=
ll
>+     * accept it.
>+     */
>+    if (viommu->granule_frozen) {
>+        int cur_granule =3D ctz64(cur_mask);
>+
>+        if (!(BIT_ULL(cur_granule) & new_mask)) {
>+            error_setg(errp,
>+                       "virtio-iommu does not support frozen granule 0x%l=
lx",
>+                       BIT_ULL(cur_granule));
>+            return false;
>+        }
>+    }
>+    return true;
>+}
>+
> static bool virtio_iommu_set_iommu_device(PCIBus *bus, void *opaque,
>int devfn,
>                                           HostIOMMUDevice *hiod, Error **=
errp)
> {
>+    ERRP_GUARD();
>     VirtIOIOMMU *viommu =3D opaque;
>     HostIOMMUDeviceClass *hiodc =3D
>HOST_IOMMU_DEVICE_GET_CLASS(hiod);
>     struct hiod_key *new_key;
>@@ -623,8 +653,26 @@ static bool
>virtio_iommu_set_iommu_device(PCIBus *bus, void *opaque, int devfn,
>                                                 hiod->aliased_devfn,
>                                                 host_iova_ranges, errp);
>         if (ret) {
>-            g_list_free_full(host_iova_ranges, g_free);
>-            return false;
>+            goto error;
>+        }
>+    }
>+    if (hiodc->get_page_size_mask) {
>+        uint64_t new_mask =3D hiodc->get_page_size_mask(hiod);
>+
>+        if (check_page_size_mask(viommu, new_mask, errp)) {
>+            /*
>+             * The default mask depends on the "granule" property. For ex=
ample,
>+             * with 4k granule, it is -(4 * KiB). When an assigned device=
 has
>+             * page size restrictions due to the hardware IOMMU configura=
tion,
>+             * apply this restriction to the mask.
>+             */
>+            trace_virtio_iommu_update_page_size_mask(hiod->name,
>+                                                     viommu->config.page_=
size_mask,
>+                                                     new_mask);
>+            viommu->config.page_size_mask &=3D new_mask;

This is a bit different from original logic, it may update page_size_mask a=
fter frozen.
Will that make issue?

Except this question, for all other patches,

Reviewed-by: Zhenzhong Duan <zhenzhong.duan@intel.com>

Thanks
Zhenzhong

>+        } else {
>+            error_prepend(errp, "%s: ", hiod->name);
>+            goto error;
>         }
>     }
>
>@@ -637,6 +685,9 @@ static bool
>virtio_iommu_set_iommu_device(PCIBus *bus, void *opaque, int devfn,
>     g_list_free_full(host_iova_ranges, g_free);
>
>     return true;
>+error:
>+    g_list_free_full(host_iova_ranges, g_free);
>+    return false;
> }
>
> static void
>diff --git a/hw/virtio/trace-events b/hw/virtio/trace-events
>index 3cf84e04a7..599d855ff6 100644
>--- a/hw/virtio/trace-events
>+++ b/hw/virtio/trace-events
>@@ -132,6 +132,7 @@ virtio_iommu_notify_map(const char *name,
>uint64_t virt_start, uint64_t virt_end
> virtio_iommu_notify_unmap(const char *name, uint64_t virt_start,
>uint64_t virt_end) "mr=3D%s virt_start=3D0x%"PRIx64" virt_end=3D0x%"PRIx64
> virtio_iommu_remap(const char *name, uint64_t virt_start, uint64_t
>virt_end, uint64_t phys_start) "mr=3D%s virt_start=3D0x%"PRIx64"
>virt_end=3D0x%"PRIx64" phys_start=3D0x%"PRIx64
> virtio_iommu_set_page_size_mask(const char *name, uint64_t old,
>uint64_t new) "mr=3D%s old_mask=3D0x%"PRIx64" new_mask=3D0x%"PRIx64
>+virtio_iommu_update_page_size_mask(const char *name, uint64_t old,
>uint64_t new) "host iommu device=3D%s old_mask=3D0x%"PRIx64"
>new_mask=3D0x%"PRIx64
> virtio_iommu_notify_flag_add(const char *name) "add notifier to mr %s"
> virtio_iommu_notify_flag_del(const char *name) "del notifier from mr %s"
> virtio_iommu_switch_address_space(uint8_t bus, uint8_t slot, uint8_t fn,
>bool on) "Device %02x:%02x.%x switching address space (iommu
>enabled=3D%d)"
>--
>2.41.0


