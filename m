Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id AAA9CE9462A
	for <qemu-devel@archiver.kernel.org>; Tue, 10 Feb 2026 03:00:22 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vpdyW-0008KX-0s; Mon, 09 Feb 2026 21:59:40 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <zhenzhong.duan@intel.com>)
 id 1vpdyE-0007ce-B3
 for qemu-devel@nongnu.org; Mon, 09 Feb 2026 21:59:24 -0500
Received: from mgamail.intel.com ([192.198.163.13])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <zhenzhong.duan@intel.com>)
 id 1vpdyA-0004Bl-Tr
 for qemu-devel@nongnu.org; Mon, 09 Feb 2026 21:59:22 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1770692359; x=1802228359;
 h=from:to:cc:subject:date:message-id:references:
 in-reply-to:mime-version;
 bh=x6AWU01eyRdpfbYpm5lC9sqy7TGbQuBoxvHz4GNC67M=;
 b=i7sFpRK4zWNsQrqD8nsojCQI6W583hTkisZDXFYHEM6nHmC0gd8MGAio
 AJion1RTtrh1ZGajb9twfUpUD+2mDCyP7AOOlx4L7yNuE1twHiR2bojnx
 INuCaxb75aAqx4Lh5q9pFVbXjFfHH9oe/5t82sbflPKnGn1Mc82KVlc3A
 9DDdO8USqbmNgPnWqFrfe/m3v41Z9J0m5tx5nOdJrJ0FkIv6lHgdDY9/y
 UfFMjs1RY6zCf+8ItwtrhSwRP37JJtpiBO8PNF175TguMhrfgML9rKa8a
 fr9QPeH81M4xozoOYE185GjtpZey9q3Rl5tLLMWn2D5aKk1wzeSL05Ero A==;
X-CSE-ConnectionGUID: u45QbuJWRnyNuMRvEVRnjw==
X-CSE-MsgGUID: NXgRr/peTcqlowVo/ev9UQ==
X-IronPort-AV: E=McAfee;i="6800,10657,11696"; a="74417250"
X-IronPort-AV: E=Sophos;i="6.21,283,1763452800"; d="scan'208,217";a="74417250"
Received: from fmviesa002.fm.intel.com ([10.60.135.142])
 by fmvoesa107.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 09 Feb 2026 18:59:06 -0800
X-CSE-ConnectionGUID: lMX+pWk+RBqT5uTCVBrT1A==
X-CSE-MsgGUID: XOvktAl1S0mORr9Ioc6GZg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.21,283,1763452800"; 
 d="scan'208,217";a="234733897"
Received: from orsmsx903.amr.corp.intel.com ([10.22.229.25])
 by fmviesa002.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 09 Feb 2026 18:58:51 -0800
Received: from ORSMSX903.amr.corp.intel.com (10.22.229.25) by
 ORSMSX903.amr.corp.intel.com (10.22.229.25) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.35; Mon, 9 Feb 2026 18:58:50 -0800
Received: from ORSEDG901.ED.cps.intel.com (10.7.248.11) by
 ORSMSX903.amr.corp.intel.com (10.22.229.25) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.35 via Frontend Transport; Mon, 9 Feb 2026 18:58:50 -0800
Received: from CH1PR05CU001.outbound.protection.outlook.com (52.101.193.46) by
 edgegateway.intel.com (134.134.137.111) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.35; Mon, 9 Feb 2026 18:58:50 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=RVX+e7vx+uC6mVk8zOourEP6310Wm84UWlf8VwMH5JuS+XzaRl6cde6SUH6Jq/fvBIWLgsXTMABUeBFGvA5rLsAMrloUzNR94pwS3PlqNTAy5trOzqQadXZm1kscXAEKnXTWH+JDoK6bDMbzxTib7gg7okP5V9Ay4eSWnlr8I6+XVa6V9XS85kxIvXle3KFA+ZtTNicoBh9K3nbY/qNRJJNdzs9OSWDXaSosJ0eBiGV6aA/uc7y7tut/a2SDZm78FNOAfYX68JN+wseCmZpC6UBkMXU0OmPq2VaMieb2y3cq/03lAGPiUvTRsZGlAK/nk7QpsmO/u+Trl+n5pwBKWw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=XVj8cW35ga4OP5Z4XqHZolawNHvK8NUlHhvrnlyff5U=;
 b=TBxRuN/i//tYzaneDcKRK9yLCeHal1tN9r3ZWvcB4bzfCrCdFxOTJ5Tlzy8z6Sa3vY3hurWxLRZiN3omPKBrkbwo0jvfNg6Sz62BLDt+pbSc77xUK6EhHPdOjlbW84tpohcyJEUKy/AOZ0Vh9e+iknQZOw5LJN0E9pWIqKBCLvTRLu7YO0h9X7+KQ9OeAzVu9rVxDqP+M2gglTa0z2CCLVtngB7sVho/ybzyXbFU7wFvHcjmLe5E78gArmNFR1Yrl0kKz8urHLAH0mfJRSCXosKSGsAJvnFuEGPgn3EzFORAE2PbvnnoiHiLlzGpRxkvNrxcLjNYwec6JD1NHJmHtA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Received: from IA3PR11MB9136.namprd11.prod.outlook.com (2603:10b6:208:574::12)
 by DM4PR11MB5994.namprd11.prod.outlook.com (2603:10b6:8:5d::20) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9587.18; Tue, 10 Feb
 2026 02:58:46 +0000
Received: from IA3PR11MB9136.namprd11.prod.outlook.com
 ([fe80::37b4:37a9:4f3:518b]) by IA3PR11MB9136.namprd11.prod.outlook.com
 ([fe80::37b4:37a9:4f3:518b%5]) with mapi id 15.20.9587.017; Tue, 10 Feb 2026
 02:58:46 +0000
From: "Duan, Zhenzhong" <zhenzhong.duan@intel.com>
To: CLEMENT MATHIEU--DRIF <clement.mathieu--drif@eviden.com>,
 "qemu-devel@nongnu.org" <qemu-devel@nongnu.org>
CC: "pbonzini@redhat.com" <pbonzini@redhat.com>, "peterx@redhat.com"
 <peterx@redhat.com>, "david@redhat.com" <david@redhat.com>, "mst@redhat.com"
 <mst@redhat.com>, "jasowang@redhat.com" <jasowang@redhat.com>, "Tian, Kevin"
 <kevin.tian@intel.com>, "Liu, Yi L" <yi.l.liu@intel.com>,
 "joao.m.martins@oracle.com" <joao.m.martins@oracle.com>
Subject: RE: [PATCH] intel_iommu: Do not report recoverable faults to host
Thread-Topic: [PATCH] intel_iommu: Do not report recoverable faults to host
Thread-Index: AQHcmNSX9m4zaFg2WU+PK2nSuD+sw7V5913ggAAW34CAATGPEA==
Date: Tue, 10 Feb 2026 02:58:46 +0000
Message-ID: <IA3PR11MB9136EBBC0F6DE8B4E1B771619262A@IA3PR11MB9136.namprd11.prod.outlook.com>
References: <20260208082252.288-1-clement.mathieu--drif@eviden.com>
 <IA3PR11MB9136AACA4BFA95DBE6B92B599265A@IA3PR11MB9136.namprd11.prod.outlook.com>
 <PA4PR07MB7613E77A57763CA798D92AC28665A@PA4PR07MB7613.eurprd07.prod.outlook.com>
In-Reply-To: <PA4PR07MB7613E77A57763CA798D92AC28665A@PA4PR07MB7613.eurprd07.prod.outlook.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: MSIP_Label_ecb69475-382c-4c7a-b21d-8ca64eeef1bd_Enabled=True;
 MSIP_Label_ecb69475-382c-4c7a-b21d-8ca64eeef1bd_SiteId=7d1c7785-2d8a-437d-b842-1ed5d8fbe00a;
 MSIP_Label_ecb69475-382c-4c7a-b21d-8ca64eeef1bd_SetDate=2026-02-09T08:41:37.384Z;
 MSIP_Label_ecb69475-382c-4c7a-b21d-8ca64eeef1bd_Name=Eviden
 For Internal Use - All
 Employees; MSIP_Label_ecb69475-382c-4c7a-b21d-8ca64eeef1bd_ContentBits=1;
 MSIP_Label_ecb69475-382c-4c7a-b21d-8ca64eeef1bd_Method=Standard; 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: IA3PR11MB9136:EE_|DM4PR11MB5994:EE_
x-ms-office365-filtering-correlation-id: b4cd55b1-feaf-45ec-5a2f-08de68504eee
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
 ARA:13230040|366016|1800799024|10070799003|376014|7053199007|38070700021|8096899003;
x-microsoft-antispam-message-info: =?us-ascii?Q?K6GjTmyn84NlSocKYZnVn7yev45HVkpAh+cHY1SP5IQlxJY2DMdmUOzHHJBn?=
 =?us-ascii?Q?1x9C6JRmkGl0C0QGqeACNf8kntUK09hJ1gFkqcE+rCwxygp8R7SzS5kqTVUF?=
 =?us-ascii?Q?QzACD6/r7d/dvl0WVR3EMnmYtW29obMOtY6T1tHVjuRqSdz+nTxRMOJ5I74t?=
 =?us-ascii?Q?scLoOGz3gLosW86LiUMTUONTaTiISWmqeptOGyvMHwEVmLV0Vx2Rvx9AR7qZ?=
 =?us-ascii?Q?6BBEau417TxwQC3EsASE7zxkvS9H8iOsarDZTtpSYb9QPjy1aLeiKD2WwjbC?=
 =?us-ascii?Q?xtlH1NVmFDuhEsCgMHv/YOM4J567RSyqWAvMGuRg6k+GyvonhhG4875bQCWz?=
 =?us-ascii?Q?GN2wLuUdD2LJjytiEoy8Up506zXTsia0xFubx7q4Yn7ty47ixI/NkCqm58cL?=
 =?us-ascii?Q?2DTZ9Qm+AQu/MZtF9gen4JEc7jGLku7spxrpdeLiYwc3cZpXDtcD79U4weYQ?=
 =?us-ascii?Q?x84qfkE2NBpLAiFIDwwGEUfv/Xzyrw1d5s2+SaSavFyoIsY722M3bQp60rPZ?=
 =?us-ascii?Q?ZkX3AIoMeONpYHfOuW+RAguE7B6vKAlvwOT7epCAjdgNcnSPZyw6c9nFcV6x?=
 =?us-ascii?Q?2LaYbWJAaEzbH705YO+5OYpeHz92EZeCrcT+SrZxzxR1jK5BDt7zOyXOeo7g?=
 =?us-ascii?Q?6uBK7EyJA55gRw4E4cSaBMrS6qwpTtW9/3Ci34Rx7rVTSDsKuIuVlgL6TMlK?=
 =?us-ascii?Q?EzhanWWKzRdPtP7+KwPEiunhpmAiqLcd7t/40m2Wv/PHtHvw0dANvfUO7VRl?=
 =?us-ascii?Q?MHCDXwqSnUj5iJeQ1ZTUEOJGSzUWlszBrjLVS5XByo11t27JXV/qnafBX6XS?=
 =?us-ascii?Q?+5H32fgyEmKBmI84BUEYbvntoAzuh62zcV1yfvOczusNF+WNzriqcG4K0irv?=
 =?us-ascii?Q?ONauDkV05Vb70uqckXLGtyyBRNirnc4SPa+TGXBzwkYi1B1Bl72/iKb6wP7x?=
 =?us-ascii?Q?avMgiOEQvbxP4Xo/bOIs9h8CUGILrpbMaJ6uYCJWQ6QLZbtELbQRYZipkVb4?=
 =?us-ascii?Q?pdTxTYdrhj4+vUPIHTUqBmskFg61ybBJV8D1LaRwnKivms+nbR1PGVV90Wxd?=
 =?us-ascii?Q?oAAdqiAtni/51pM20rOyizc4yBgUyI3UfCscSKW/ma2vIAx/XDZXNr7Wl7ZQ?=
 =?us-ascii?Q?U0WG5blDHw0dTm4pTEQBD7PeAe+xzpdT45yoImocr8BV6zQ+cdf1diVXWCMW?=
 =?us-ascii?Q?8oCpMfg8bX64wpQdsF1ZO9MVLDh1HEP9VJ90D43RgdE9CuYi+/NQqx1vPXEI?=
 =?us-ascii?Q?2ox4fi/zJ+mjEO7+LAEbr7Q//8iyfYV9e5EY9v8Kj+PHBMBvEPgNRfIOXGX8?=
 =?us-ascii?Q?Y411FxYJTV28r9T83NHtIRgctM0dL3rA8G/sKWvWnG/sDTrsXdSBWpmgXz9Z?=
 =?us-ascii?Q?bSmcEIfCds5hceQT/FFB6+tDpH4z3NRRbaN0yrwUC0kdKYnArboxTgD+i8D2?=
 =?us-ascii?Q?OFA1JBRkEGP80OKSDWqebLOoTkowgz3KxSPc4orxxMPmWyvXikhqb/sipkrV?=
 =?us-ascii?Q?22znrc3mf5cjhoPkRxoRKpd1aEz7zFUYKW7/sfR9WY/pjkxDObbf5OMOkk+z?=
 =?us-ascii?Q?ZE0eQl5qUQyyON/y8FuPpI0WSLsDGEZcspE28S5YY+3qRhPR5Cfb6jdFRifL?=
 =?us-ascii?Q?DiFEIS5+jEnWbayU5qEI01Q=3D?=
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:IA3PR11MB9136.namprd11.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(366016)(1800799024)(10070799003)(376014)(7053199007)(38070700021)(8096899003);
 DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 2
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?qiVtp5Bwqq9fRZy/3fVlHzfDkTOn9vPpJB+t6X88ZPokGEW8CO4HlNL9im9C?=
 =?us-ascii?Q?jaDgcmzRbdrCU7aFNY4SD6SqGKYWAWVrf2+fbWmJfmv/Nbgz5zXZxQErO5cM?=
 =?us-ascii?Q?O4Y/F1lI5aoU3wYYnR9a/zqIBWiS1D57UYUvtddJLmaJ+mQb0K3CtKs52cqF?=
 =?us-ascii?Q?rUSU7b9yJMj2ttQfR4Jji5Czah8fOYULdgTPC0IlFin1C+HwSgCqKAmhx0E+?=
 =?us-ascii?Q?071QhzFa8BDA4zW6mQPyweXwhvzWFdZ/BkY2u3lJibb3YlvfPau5wwrVwbD2?=
 =?us-ascii?Q?zUHyb8sNWTNQ+s+CZdpQCKcRhgH6pMx/8gstojfJ6VkuUz9vTokplb9ZMJ1B?=
 =?us-ascii?Q?tW29q2Vqm8TUI97kdTH6++TY0iSxlHifW8Zve/aY65fgs4V8M5uMwBxANaX3?=
 =?us-ascii?Q?+3lHXRS2CP57Jq+O6hyBQTACX5Al/trYjPG7q3gj3v7djc/avf1Qbk9rU3Dn?=
 =?us-ascii?Q?7H3x1RKpvd2oedZwHIwxSGUjrzAfTrP8n5Pizg1vsiDIJA0f+Lsc+vZvWH97?=
 =?us-ascii?Q?20PWj+ntn27mVczqUFY4QucO1f4GlPY+rMdmoMxlRUpdneIPJNjEYhG+6SVo?=
 =?us-ascii?Q?rVbVErrWXjY2BOO8+AswmkEV12ezTDkaxjGQhDAwyM7Oj7E9ygbKvYd2qWVs?=
 =?us-ascii?Q?aC/kEHmwpZdwkzCrT+MHWW0nywbbQQIFmSywToXiH2DtZUMHVz/ySk1N23a/?=
 =?us-ascii?Q?kQn5U+iD6wfWfkMRq6QVxPPcXjZjVE7FEddTLkMxe4+6V2FwRru1WnZYLcqD?=
 =?us-ascii?Q?S09PaKxNlxvlxWhWNU4oygT7oyjJFs4RbpiwHtRReefiV4tFvuCHN5MkuHz2?=
 =?us-ascii?Q?CF8naCP3Uy95sGWt+LDs/eHGs/4tGfTb/2GNLx/LaeixwTpbK3luXpTBOgAN?=
 =?us-ascii?Q?fKlgqhaXaOeH9+GLrHi2ZtsCQjJ0vcY59FL7ptc+Dy9VeYiodTw26ShI4C6P?=
 =?us-ascii?Q?0/2+ehflawdxY9o3/ZKliyyKPvqQgyiPgoGtkjG9VrfzpGTLDc8cN5oX9rr3?=
 =?us-ascii?Q?utS7zBA1tbL05HhFRw7+WDXMcVVPFaOUM/u2OifLmTcea554SGvYR5gco2g2?=
 =?us-ascii?Q?2vGoAbWvr5yYSf9zafdRKjbcw86VB0Hz8m59c3FfwmrSW1YCDhkSTTwvEM4o?=
 =?us-ascii?Q?/fEBJ0kFz6MHkGGPmq66tdkC/5k7X9wveldVb5OzwOYcRa0OkrTcLW0Bq+w0?=
 =?us-ascii?Q?STmEj4S99OdI2DyvAMpDnXbtjmhUgF31sznxsA0wXZEox3qP4k3wy9pmbjDx?=
 =?us-ascii?Q?8RpH1AsqgcTDIL1lMQogN3irlBjn0OjkKY6mJqqjXE/WZNzrsy65gukrKWA2?=
 =?us-ascii?Q?aOVid00PeJZ2iI0Y2LWz5fv5UfwmyUalMGVCfucnAb/oh4WXsPi++5/o03j4?=
 =?us-ascii?Q?PY2yKnmsU175S/NKzErFoexKkyF3PcusG3Byxm1O6VTiRRe/uF2nT220fqMJ?=
 =?us-ascii?Q?lOpFyiKCa2I17p3caBoSAgOYJnLT3iafo3UniAwIS8TZ+P66ftrf90ExrdOj?=
 =?us-ascii?Q?TB6L6vvG60f6Ux2mZia3lLgo/a2JfrO3VPyLcAuxOSAMPsREfp/jVR/kzvCZ?=
 =?us-ascii?Q?xEZfCDolKWYLbRhTmEfqn1R0sBioA6bnDVyg46iGJVuPiiC32BciVVzgOvl8?=
 =?us-ascii?Q?PRknPH7AXICphyykhcBjTKNSCpNrvYdDM2Vy+qIVdK+SJRnMlOlks3i2las8?=
 =?us-ascii?Q?z/TI3CRCbX0UToRLckAnonsoHO7t56kjvI8Rwm1Au6YIhflef1te+fKPnQFS?=
 =?us-ascii?Q?fp8uZHtqLj30U/7yaW30PCDRlKUL4xosqLgZjfwmr2U5Pr4DdE0y3JZuWq6P?=
x-ms-exchange-antispam-messagedata-1: ywMqTSp6PZM+xQ==
Content-Type: multipart/alternative;
 boundary="_000_IA3PR11MB9136EBBC0F6DE8B4E1B771619262AIA3PR11MB9136namp_"
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: IA3PR11MB9136.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: b4cd55b1-feaf-45ec-5a2f-08de68504eee
X-MS-Exchange-CrossTenant-originalarrivaltime: 10 Feb 2026 02:58:46.3272 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 2FOM5bWxaWSw3GLNK3ezDQhQBJw/HFZQPtj0sNKrgqB4cq9zOY6tekZfdGSeEvyLHJQ6zUCg+DMLTtPgXew5ZMw6xapKlpE1H4nD51bZoU0=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM4PR11MB5994
X-OriginatorOrg: intel.com
Received-SPF: pass client-ip=192.198.163.13;
 envelope-from=zhenzhong.duan@intel.com; helo=mgamail.intel.com
X-Spam_score_int: -43
X-Spam_score: -4.4
X-Spam_bar: ----
X-Spam_report: (-4.4 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 HTML_MESSAGE=0.001, RCVD_IN_DNSWL_MED=-2.3,
 RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001, RCVD_IN_VALIDITY_SAFE_BLOCKED=0.001,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001 autolearn=ham autolearn_force=no
X-Spam_action: no action
X-BeenThere: qemu-devel@nongnu.org
X-Mailman-Version: 2.1.29
Precedence: list
List-Id: qemu development <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <https://lists.nongnu.org/archive/html/qemu-devel>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=subscribe>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org

--_000_IA3PR11MB9136EBBC0F6DE8B4E1B771619262AIA3PR11MB9136namp_
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable

Thanks Clement.

Reviewed-by: Zhenzhong Duan <zhenzhong.duan@intel.com>

From: CLEMENT MATHIEU--DRIF <clement.mathieu--drif@eviden.com>
Sent: Monday, February 9, 2026 4:42 PM
To: Duan, Zhenzhong <zhenzhong.duan@intel.com>; qemu-devel@nongnu.org
Cc: pbonzini@redhat.com; peterx@redhat.com; david@redhat.com; mst@redhat.co=
m; jasowang@redhat.com; Tian, Kevin <kevin.tian@intel.com>; Liu, Yi L <yi.l=
.liu@intel.com>; joao.m.martins@oracle.com
Subject: Re: [PATCH] intel_iommu: Do not report recoverable faults to host

Hi Zhenzhon,

Yes, you can have a look at table 26 of VT-d 4.1 or table 30 of VT-d 5.1.

These faults are descibed as follows:

"When remapping hardware detects a recoverable fault on a translation-reque=
st from Device-TLB, it is
not reported to software as a fault. Instead, remapping hardware sends a su=
ccessful translation
completion with limited or no permission/privileges"

In the aforementioned tables, such erros contain mentions like "Success wit=
h R=3DW=3DU=3DS=3D0" or "Success with effective permission".

cmd

________________________________
From: Duan, Zhenzhong <zhenzhong.duan@intel.com<mailto:zhenzhong.duan@intel=
.com>>
Sent: 09 February 2026 08:34
To: CLEMENT MATHIEU--DRIF <clement.mathieu--drif@eviden.com<mailto:clement.=
mathieu--drif@eviden.com>>; qemu-devel@nongnu.org<mailto:qemu-devel@nongnu.=
org> <qemu-devel@nongnu.org<mailto:qemu-devel@nongnu.org>>
Cc: pbonzini@redhat.com<mailto:pbonzini@redhat.com> <pbonzini@redhat.com<ma=
ilto:pbonzini@redhat.com>>; peterx@redhat.com<mailto:peterx@redhat.com> <pe=
terx@redhat.com<mailto:peterx@redhat.com>>; david@redhat.com<mailto:david@r=
edhat.com> <david@redhat.com<mailto:david@redhat.com>>; mst@redhat.com<mail=
to:mst@redhat.com> <mst@redhat.com<mailto:mst@redhat.com>>; jasowang@redhat=
.com<mailto:jasowang@redhat.com> <jasowang@redhat.com<mailto:jasowang@redha=
t.com>>; Tian, Kevin <kevin.tian@intel.com<mailto:kevin.tian@intel.com>>; L=
iu, Yi L <yi.l.liu@intel.com<mailto:yi.l.liu@intel.com>>; joao.m.martins@or=
acle.com<mailto:joao.m.martins@oracle.com> <joao.m.martins@oracle.com<mailt=
o:joao.m.martins@oracle.com>>
Subject: RE: [PATCH] intel_iommu: Do not report recoverable faults to host

Caution: External email. Do not open attachments or click links, unless thi=
s email comes from a known sender and you know the content is safe.


Hi Clement,

>-----Original Message-----
>From: Clement Mathieu--Drif <clement.mathieu--drif@eviden.com<mailto:cleme=
nt.mathieu--drif@eviden.com>>
>Subject: [PATCH] intel_iommu: Do not report recoverable faults to host
>
>Signed-off-by: Clement Mathieu--Drif <clement.mathieu--drif@eviden.com<mai=
lto:clement.mathieu--drif@eviden.com>>
>---
> hw/i386/intel_iommu.c | 26 ++++++++++++++++++++++++--
> 1 file changed, 24 insertions(+), 2 deletions(-)
>
>diff --git a/hw/i386/intel_iommu.c b/hw/i386/intel_iommu.c
>index dd00079a40..0735b24ac0 100644
>--- a/hw/i386/intel_iommu.c
>+++ b/hw/i386/intel_iommu.c
>@@ -1857,6 +1857,21 @@ static const bool vtd_qualified_faults[] =3D {
>     [VTD_FR_MAX] =3D false,
> };
>
>+static const bool vtd_recoverable_faults[] =3D {
>+    [VTD_FR_WRITE] =3D true,
>+    [VTD_FR_READ] =3D true,
>+    [VTD_FR_PASID_DIR_ENTRY_P] =3D true,
>+    [VTD_FR_PASID_ENTRY_P] =3D true,
>+    [VTD_FR_FS_PAGING_ENTRY_INV] =3D true,
>+    [VTD_FR_FS_PAGING_ENTRY_P] =3D true,
>+    [VTD_FR_FS_PAGING_ENTRY_RSVD] =3D true,
>+    [VTD_FR_PASID_ENTRY_FSPTPTR_INV] =3D true,
>+    [VTD_FR_FS_NON_CANONICAL] =3D true,
>+    [VTD_FR_FS_PAGING_ENTRY_US] =3D true,
>+    [VTD_FR_SM_WRITE] =3D true,

Which fault reason is classified as recoverable fault?
Is this documented somewhere?

Thanks
Zhenzhong

>+    [VTD_FR_MAX] =3D false,
>+};
>+
> /* To see if a fault condition is "qualified", which is reported to softw=
are
>  * only if the FPD field in the context-entry used to process the faultin=
g
>  * request is 0.
>@@ -1866,6 +1881,11 @@ static inline bool
>vtd_is_qualified_fault(VTDFaultReason fault)
>     return vtd_qualified_faults[fault];
> }
>
>+static inline bool vtd_is_recoverable_fault(VTDFaultReason fault, int iom=
mu_idx)
>+{
>+    return iommu_idx =3D=3D VTD_IDX_ATS && vtd_recoverable_faults[fault];
>+}
>+
> static inline bool vtd_is_interrupt_addr(hwaddr addr)
> {
>     return VTD_INTERRUPT_ADDR_FIRST <=3D addr && addr <=3D
>VTD_INTERRUPT_ADDR_LAST;
>@@ -2237,8 +2257,10 @@ static bool
>vtd_do_iommu_translate(VTDAddressSpace *vtd_as, PCIBus *bus,
>     }
>
>     if (ret_fr) {
>-        vtd_report_fault(s, -ret_fr, is_fpd_set, source_id,
>-                         addr, is_write, pasid !=3D PCI_NO_PASID, pasid);
>+        if (!vtd_is_recoverable_fault(-ret_fr, iommu_idx)) {
>+            vtd_report_fault(s, -ret_fr, is_fpd_set, source_id,
>+                            addr, is_write, pasid !=3D PCI_NO_PASID, pasi=
d);
>+        }
>         goto error;
>     }
>
>--
>2.53.0

--_000_IA3PR11MB9136EBBC0F6DE8B4E1B771619262AIA3PR11MB9136namp_
Content-Type: text/html; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable

<html xmlns:v=3D"urn:schemas-microsoft-com:vml" xmlns:o=3D"urn:schemas-micr=
osoft-com:office:office" xmlns:w=3D"urn:schemas-microsoft-com:office:word" =
xmlns:m=3D"http://schemas.microsoft.com/office/2004/12/omml" xmlns=3D"http:=
//www.w3.org/TR/REC-html40">
<head>
<meta http-equiv=3D"Content-Type" content=3D"text/html; charset=3Dus-ascii"=
>
<meta name=3D"Generator" content=3D"Microsoft Word 15 (filtered medium)">
<!--[if !mso]><style>v\:* {behavior:url(#default#VML);}
o\:* {behavior:url(#default#VML);}
w\:* {behavior:url(#default#VML);}
.shape {behavior:url(#default#VML);}
</style><![endif]--><style><!--
/* Font Definitions */
@font-face
	{font-family:"Cambria Math";
	panose-1:2 4 5 3 5 4 6 3 2 4;}
@font-face
	{font-family:DengXian;
	panose-1:2 1 6 0 3 1 1 1 1 1;}
@font-face
	{font-family:Calibri;
	panose-1:2 15 5 2 2 2 4 3 2 4;}
@font-face
	{font-family:Aptos;}
@font-face
	{font-family:"\@DengXian";
	panose-1:2 1 6 0 3 1 1 1 1 1;}
/* Style Definitions */
p.MsoNormal, li.MsoNormal, div.MsoNormal
	{margin:0in;
	font-size:12.0pt;
	font-family:"Aptos",sans-serif;}
a:link, span.MsoHyperlink
	{mso-style-priority:99;
	color:#467886;
	text-decoration:underline;}
span.EmailStyle21
	{mso-style-type:personal-compose;
	font-family:"Aptos",sans-serif;
	color:windowtext;}
.MsoChpDefault
	{mso-style-type:export-only;
	font-size:10.0pt;
	mso-ligatures:none;}
@page WordSection1
	{size:8.5in 11.0in;
	margin:1.0in 1.0in 1.0in 1.0in;}
div.WordSection1
	{page:WordSection1;}
--></style><!--[if gte mso 9]><xml>
<o:shapedefaults v:ext=3D"edit" spidmax=3D"1026" />
</xml><![endif]--><!--[if gte mso 9]><xml>
<o:shapelayout v:ext=3D"edit">
<o:idmap v:ext=3D"edit" data=3D"1" />
</o:shapelayout></xml><![endif]-->
</head>
<body lang=3D"EN-US" link=3D"#467886" vlink=3D"#96607D" style=3D"word-wrap:=
break-word">
<div class=3D"WordSection1">
<p class=3D"MsoNormal">Thanks Clement.<o:p></o:p></p>
<p class=3D"MsoNormal"><o:p>&nbsp;</o:p></p>
<p class=3D"MsoNormal">Reviewed-by: Zhenzhong Duan &lt;zhenzhong.duan@intel=
.com&gt;<o:p></o:p></p>
<p class=3D"MsoNormal"><o:p>&nbsp;</o:p></p>
<div style=3D"border:none;border-left:solid blue 1.5pt;padding:0in 0in 0in =
4.0pt">
<div>
<div style=3D"border:none;border-top:solid #E1E1E1 1.0pt;padding:3.0pt 0in =
0in 0in">
<p class=3D"MsoNormal"><b><span style=3D"font-size:11.0pt;font-family:&quot=
;Calibri&quot;,sans-serif">From:</span></b><span style=3D"font-size:11.0pt;=
font-family:&quot;Calibri&quot;,sans-serif"> CLEMENT MATHIEU--DRIF &lt;clem=
ent.mathieu--drif@eviden.com&gt;
<br>
<b>Sent:</b> Monday, February 9, 2026 4:42 PM<br>
<b>To:</b> Duan, Zhenzhong &lt;zhenzhong.duan@intel.com&gt;; qemu-devel@non=
gnu.org<br>
<b>Cc:</b> pbonzini@redhat.com; peterx@redhat.com; david@redhat.com; mst@re=
dhat.com; jasowang@redhat.com; Tian, Kevin &lt;kevin.tian@intel.com&gt;; Li=
u, Yi L &lt;yi.l.liu@intel.com&gt;; joao.m.martins@oracle.com<br>
<b>Subject:</b> Re: [PATCH] intel_iommu: Do not report recoverable faults t=
o host<o:p></o:p></span></p>
</div>
</div>
<p class=3D"MsoNormal"><o:p>&nbsp;</o:p></p>
<div>
<p class=3D"MsoNormal"><span style=3D"color:black">Hi Zhenzhon,<o:p></o:p><=
/span></p>
</div>
<div>
<p class=3D"MsoNormal"><span style=3D"color:black"><o:p>&nbsp;</o:p></span>=
</p>
</div>
<div>
<p class=3D"MsoNormal"><span style=3D"color:black">Yes, you can have a look=
 at table 26 of VT-d 4.1 or table 30 of VT-d 5.1.<o:p></o:p></span></p>
</div>
<div>
<p class=3D"MsoNormal"><span style=3D"color:black"><o:p>&nbsp;</o:p></span>=
</p>
</div>
<div>
<p class=3D"MsoNormal"><span style=3D"color:black">These faults are descibe=
d as follows:<o:p></o:p></span></p>
</div>
<div>
<p class=3D"MsoNormal"><span style=3D"color:black"><o:p>&nbsp;</o:p></span>=
</p>
</div>
<div>
<p class=3D"MsoNormal"><span style=3D"color:black">&quot;When remapping har=
dware detects a recoverable fault on a translation-request from Device-TLB,=
 it is<o:p></o:p></span></p>
</div>
<div>
<p class=3D"MsoNormal"><span style=3D"color:black">not reported to software=
 as a fault. Instead, remapping hardware sends a successful translation<o:p=
></o:p></span></p>
</div>
<div>
<p class=3D"MsoNormal"><span style=3D"color:black">completion with limited =
or no permission/privileges&quot;<o:p></o:p></span></p>
</div>
<div>
<p class=3D"MsoNormal"><span style=3D"color:black"><o:p>&nbsp;</o:p></span>=
</p>
</div>
<div>
<p class=3D"MsoNormal"><span style=3D"color:black">In the aforementioned ta=
bles, such erros contain mentions like &quot;Success with R=3DW=3DU=3DS=3D0=
&quot; or &quot;Success with effective permission&quot;.<o:p></o:p></span><=
/p>
</div>
<div>
<p class=3D"MsoNormal"><span style=3D"color:black"><o:p>&nbsp;</o:p></span>=
</p>
</div>
<div>
<p class=3D"MsoNormal"><span style=3D"color:black">cmd<o:p></o:p></span></p=
>
</div>
<div>
<p class=3D"MsoNormal"><span style=3D"color:black"><o:p>&nbsp;</o:p></span>=
</p>
</div>
<div class=3D"MsoNormal" align=3D"center" style=3D"text-align:center">
<hr size=3D"2" width=3D"98%" align=3D"center">
</div>
<div id=3D"divRplyFwdMsg">
<div>
<p class=3D"MsoNormal"><b><span style=3D"font-size:11.0pt;font-family:&quot=
;Calibri&quot;,sans-serif;color:black">From:</span></b><span style=3D"font-=
size:11.0pt;font-family:&quot;Calibri&quot;,sans-serif;color:black">&nbsp;D=
uan, Zhenzhong &lt;<a href=3D"mailto:zhenzhong.duan@intel.com">zhenzhong.du=
an@intel.com</a>&gt;<br>
<b>Sent:</b>&nbsp;09 February 2026 08:34<br>
<b>To:</b>&nbsp;CLEMENT MATHIEU--DRIF &lt;<a href=3D"mailto:clement.mathieu=
--drif@eviden.com">clement.mathieu--drif@eviden.com</a>&gt;;
<a href=3D"mailto:qemu-devel@nongnu.org">qemu-devel@nongnu.org</a> &lt;<a h=
ref=3D"mailto:qemu-devel@nongnu.org">qemu-devel@nongnu.org</a>&gt;<br>
<b>Cc:</b>&nbsp;<a href=3D"mailto:pbonzini@redhat.com">pbonzini@redhat.com<=
/a> &lt;<a href=3D"mailto:pbonzini@redhat.com">pbonzini@redhat.com</a>&gt;;
<a href=3D"mailto:peterx@redhat.com">peterx@redhat.com</a> &lt;<a href=3D"m=
ailto:peterx@redhat.com">peterx@redhat.com</a>&gt;;
<a href=3D"mailto:david@redhat.com">david@redhat.com</a> &lt;<a href=3D"mai=
lto:david@redhat.com">david@redhat.com</a>&gt;;
<a href=3D"mailto:mst@redhat.com">mst@redhat.com</a> &lt;<a href=3D"mailto:=
mst@redhat.com">mst@redhat.com</a>&gt;;
<a href=3D"mailto:jasowang@redhat.com">jasowang@redhat.com</a> &lt;<a href=
=3D"mailto:jasowang@redhat.com">jasowang@redhat.com</a>&gt;; Tian, Kevin &l=
t;<a href=3D"mailto:kevin.tian@intel.com">kevin.tian@intel.com</a>&gt;; Liu=
, Yi L &lt;<a href=3D"mailto:yi.l.liu@intel.com">yi.l.liu@intel.com</a>&gt;=
;
<a href=3D"mailto:joao.m.martins@oracle.com">joao.m.martins@oracle.com</a> =
&lt;<a href=3D"mailto:joao.m.martins@oracle.com">joao.m.martins@oracle.com<=
/a>&gt;<br>
<b>Subject:</b>&nbsp;RE: [PATCH] intel_iommu: Do not report recoverable fau=
lts to host<o:p></o:p></span></p>
</div>
<div>
<p class=3D"MsoNormal">&nbsp;<o:p></o:p></p>
</div>
</div>
<div>
<p class=3D"MsoNormal" style=3D"margin-bottom:12.0pt"><span style=3D"font-s=
ize:11.0pt">Caution: External email. Do not open attachments or click links=
, unless this email comes from a known sender and you know the content is s=
afe.<br>
<br>
<br>
Hi Clement,<br>
<br>
&gt;-----Original Message-----<br>
&gt;From: Clement Mathieu--Drif &lt;<a href=3D"mailto:clement.mathieu--drif=
@eviden.com">clement.mathieu--drif@eviden.com</a>&gt;<br>
&gt;Subject: [PATCH] intel_iommu: Do not report recoverable faults to host<=
br>
&gt;<br>
&gt;Signed-off-by: Clement Mathieu--Drif &lt;<a href=3D"mailto:clement.math=
ieu--drif@eviden.com">clement.mathieu--drif@eviden.com</a>&gt;<br>
&gt;---<br>
&gt; hw/i386/intel_iommu.c | 26 ++++++++++++++++++++++++--<br>
&gt; 1 file changed, 24 insertions(+), 2 deletions(-)<br>
&gt;<br>
&gt;diff --git a/hw/i386/intel_iommu.c b/hw/i386/intel_iommu.c<br>
&gt;index dd00079a40..0735b24ac0 100644<br>
&gt;--- a/hw/i386/intel_iommu.c<br>
&gt;+++ b/hw/i386/intel_iommu.c<br>
&gt;@@ -1857,6 +1857,21 @@ static const bool vtd_qualified_faults[] =3D {<b=
r>
&gt;&nbsp;&nbsp;&nbsp;&nbsp; [VTD_FR_MAX] =3D false,<br>
&gt; };<br>
&gt;<br>
&gt;+static const bool vtd_recoverable_faults[] =3D {<br>
&gt;+&nbsp;&nbsp;&nbsp; [VTD_FR_WRITE] =3D true,<br>
&gt;+&nbsp;&nbsp;&nbsp; [VTD_FR_READ] =3D true,<br>
&gt;+&nbsp;&nbsp;&nbsp; [VTD_FR_PASID_DIR_ENTRY_P] =3D true,<br>
&gt;+&nbsp;&nbsp;&nbsp; [VTD_FR_PASID_ENTRY_P] =3D true,<br>
&gt;+&nbsp;&nbsp;&nbsp; [VTD_FR_FS_PAGING_ENTRY_INV] =3D true,<br>
&gt;+&nbsp;&nbsp;&nbsp; [VTD_FR_FS_PAGING_ENTRY_P] =3D true,<br>
&gt;+&nbsp;&nbsp;&nbsp; [VTD_FR_FS_PAGING_ENTRY_RSVD] =3D true,<br>
&gt;+&nbsp;&nbsp;&nbsp; [VTD_FR_PASID_ENTRY_FSPTPTR_INV] =3D true,<br>
&gt;+&nbsp;&nbsp;&nbsp; [VTD_FR_FS_NON_CANONICAL] =3D true,<br>
&gt;+&nbsp;&nbsp;&nbsp; [VTD_FR_FS_PAGING_ENTRY_US] =3D true,<br>
&gt;+&nbsp;&nbsp;&nbsp; [VTD_FR_SM_WRITE] =3D true,<br>
<br>
Which fault reason is classified as recoverable fault?<br>
Is this documented somewhere?<br>
<br>
Thanks<br>
Zhenzhong<br>
<br>
&gt;+&nbsp;&nbsp;&nbsp; [VTD_FR_MAX] =3D false,<br>
&gt;+};<br>
&gt;+<br>
&gt; /* To see if a fault condition is &quot;qualified&quot;, which is repo=
rted to software<br>
&gt;&nbsp; * only if the FPD field in the context-entry used to process the=
 faulting<br>
&gt;&nbsp; * request is 0.<br>
&gt;@@ -1866,6 +1881,11 @@ static inline bool<br>
&gt;vtd_is_qualified_fault(VTDFaultReason fault)<br>
&gt;&nbsp;&nbsp;&nbsp;&nbsp; return vtd_qualified_faults[fault];<br>
&gt; }<br>
&gt;<br>
&gt;+static inline bool vtd_is_recoverable_fault(VTDFaultReason fault, int =
iommu_idx)<br>
&gt;+{<br>
&gt;+&nbsp;&nbsp;&nbsp; return iommu_idx =3D=3D VTD_IDX_ATS &amp;&amp; vtd_=
recoverable_faults[fault];<br>
&gt;+}<br>
&gt;+<br>
&gt; static inline bool vtd_is_interrupt_addr(hwaddr addr)<br>
&gt; {<br>
&gt;&nbsp;&nbsp;&nbsp;&nbsp; return VTD_INTERRUPT_ADDR_FIRST &lt;=3D addr &=
amp;&amp; addr &lt;=3D<br>
&gt;VTD_INTERRUPT_ADDR_LAST;<br>
&gt;@@ -2237,8 +2257,10 @@ static bool<br>
&gt;vtd_do_iommu_translate(VTDAddressSpace *vtd_as, PCIBus *bus,<br>
&gt;&nbsp;&nbsp;&nbsp;&nbsp; }<br>
&gt;<br>
&gt;&nbsp;&nbsp;&nbsp;&nbsp; if (ret_fr) {<br>
&gt;-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; vtd_report_fault(s, -ret_fr=
, is_fpd_set, source_id,<br>
&gt;-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbs=
p;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; =
addr, is_write, pasid !=3D PCI_NO_PASID, pasid);<br>
&gt;+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; if (!vtd_is_recoverable_fau=
lt(-ret_fr, iommu_idx)) {<br>
&gt;+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; vtd=
_report_fault(s, -ret_fr, is_fpd_set, source_id,<br>
&gt;+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbs=
p;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&=
nbsp;&nbsp;&nbsp; addr, is_write, pasid !=3D PCI_NO_PASID, pasid);<br>
&gt;+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; }<br>
&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; goto error;<br>
&gt;&nbsp;&nbsp;&nbsp;&nbsp; }<br>
&gt;<br>
&gt;--<br>
&gt;2.53.0<o:p></o:p></span></p>
</div>
</div>
</div>
</body>
</html>

--_000_IA3PR11MB9136EBBC0F6DE8B4E1B771619262AIA3PR11MB9136namp_--

