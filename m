Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id F3932C3ABDD
	for <qemu-devel@archiver.kernel.org>; Tue, 20 May 2025 09:14:51 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uHJ2y-0005fT-Qv; Tue, 20 May 2025 05:14:04 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <zhenzhong.duan@intel.com>)
 id 1uHJ2w-0005f0-Ae
 for qemu-devel@nongnu.org; Tue, 20 May 2025 05:14:02 -0400
Received: from mgamail.intel.com ([192.198.163.18])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <zhenzhong.duan@intel.com>)
 id 1uHJ2t-0000lr-1K
 for qemu-devel@nongnu.org; Tue, 20 May 2025 05:14:01 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1747732439; x=1779268439;
 h=from:to:cc:subject:date:message-id:references:
 in-reply-to:content-transfer-encoding:mime-version;
 bh=+knm7nm0lNondE6deOLLYS/tDpYRFnxt1E38mnBORII=;
 b=lwYpjY4s2Bv7SSIqq+Xxfs6MYuVtIdSGLecjzuqtPbfz8uDb27hG9Pr2
 M07nWCJyS5ks5K/y2kClDd5xW4d9r8nmwW+og6BBbx+KzAkM4G5/Jh4n5
 8eLlrMaL7k2hq90MJKplThgzFbfZNyPEKiDJr6NG5D38goiTxkPoCLbDH
 yUYVlwNprQlnZVXfyTnE/QbfZ303f71rFX56hlS/6D0+vI/PGwluEtrqE
 ZYGrcep8I3xrtBzB5JXOPv9wVWWt8hc2QmGyFwkqRC4BbxCdiqZpAme2y
 +UL+KlX7XucmA/HW1WRJX+qufVEai9rT/EVCZ3+h0H0BMqshlAKSbLs+b w==;
X-CSE-ConnectionGUID: kRnmmmY5Sv+ETeJSlkEiOg==
X-CSE-MsgGUID: 0BTh9hukSta4qZEIGXQkeA==
X-IronPort-AV: E=McAfee;i="6700,10204,11438"; a="48908965"
X-IronPort-AV: E=Sophos;i="6.15,302,1739865600"; d="scan'208";a="48908965"
Received: from orviesa010.jf.intel.com ([10.64.159.150])
 by fmvoesa112.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 20 May 2025 02:13:54 -0700
X-CSE-ConnectionGUID: FrQB1ReRT6SA0GaWcRlm/w==
X-CSE-MsgGUID: 4CE5enEHSy2OHpn38GgkwA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.15,302,1739865600"; d="scan'208";a="139474644"
Received: from orsmsx901.amr.corp.intel.com ([10.22.229.23])
 by orviesa010.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 20 May 2025 02:13:54 -0700
Received: from ORSMSX901.amr.corp.intel.com (10.22.229.23) by
 ORSMSX901.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.25; Tue, 20 May 2025 02:13:53 -0700
Received: from ORSEDG601.ED.cps.intel.com (10.7.248.6) by
 ORSMSX901.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.25 via Frontend Transport; Tue, 20 May 2025 02:13:53 -0700
Received: from NAM10-DM6-obe.outbound.protection.outlook.com (104.47.58.48) by
 edgegateway.intel.com (134.134.137.102) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.55; Tue, 20 May 2025 02:13:53 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=rq68DxHaFnsT2owygZDeop4rdKjxJkYlV7P8Y5iIehaWsDVodnDoan5bkoCGhS0tfj0V3D4yPsh8KCQDq8MnJBuny00zNErr1Q4DfX2IxlmCZnpcf+RH4IB37M27elpl+8GZEWNZczQExofIzzoBR8RgbzYXViCi9c2leI7cE+KKkrp8Tkc616/t9Gn87op1NNiq7qQmKMYLKb/pkAeOf0d55GjfV02isCPy0DlMx//GSfFQdWkQ9TlKWBkxWtBMGrmVA6WD38ow05jOq6TVcfFf8SzVfHmsn6D7sGeVagL54npLZdE0e56gofZ6LoGKdc7NhLG3gyAbvL1uY+4lCA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=pimwRGfse4pAFFJL7eYXQmqtsCrHWYNr36nH05ovQ6g=;
 b=IQsVYSYj27SGXxS4dOLMgV98O26b5xa0nV+eDvZe1aVSdKN2qdl9gLOQluKc5tpaPnJNY2Nywg1+w1x9v5MdoruwCWixP5GK4M619Eq9FOC+lxvdxx3XHd247ArQGY7k8f/Gy9RI9YUqI9TgzshpDrAoHHe/rWWE1vuypbCFaJjn1yMZ+UtwENcoh8ji1QnljnWC0NeoF2ZXFqg1r9xvvyxug7hSIrxGfLY2mvIq5m7tIp9a9WEKcAspnynpW0vPnnO7HXC7xqyMtlouT4VOUvNwpTLd8OglQyC70C9mr4Nj/ivcjUkXqs9oM/AJCq9Tcxi4FbtE7SKIyhzDrafKqQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Received: from SJ0PR11MB6744.namprd11.prod.outlook.com (2603:10b6:a03:47d::10)
 by MN0PR11MB6034.namprd11.prod.outlook.com (2603:10b6:208:375::17)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8746.30; Tue, 20 May
 2025 09:13:44 +0000
Received: from SJ0PR11MB6744.namprd11.prod.outlook.com
 ([fe80::fe49:d628:48b1:6091]) by SJ0PR11MB6744.namprd11.prod.outlook.com
 ([fe80::fe49:d628:48b1:6091%4]) with mapi id 15.20.8746.030; Tue, 20 May 2025
 09:13:44 +0000
From: "Duan, Zhenzhong" <zhenzhong.duan@intel.com>
To: Donald Dutile <ddutile@redhat.com>, "qemu-devel@nongnu.org"
 <qemu-devel@nongnu.org>
CC: "alex.williamson@redhat.com" <alex.williamson@redhat.com>,
 "clg@redhat.com" <clg@redhat.com>, "eric.auger@redhat.com"
 <eric.auger@redhat.com>, "mst@redhat.com" <mst@redhat.com>,
 "jasowang@redhat.com" <jasowang@redhat.com>, "peterx@redhat.com"
 <peterx@redhat.com>, "jgg@nvidia.com" <jgg@nvidia.com>, "nicolinc@nvidia.com"
 <nicolinc@nvidia.com>, "shameerali.kolothum.thodi@huawei.com"
 <shameerali.kolothum.thodi@huawei.com>, "joao.m.martins@oracle.com"
 <joao.m.martins@oracle.com>, "clement.mathieu--drif@eviden.com"
 <clement.mathieu--drif@eviden.com>, "Tian, Kevin" <kevin.tian@intel.com>,
 "Liu, Yi L" <yi.l.liu@intel.com>, "Peng, Chao P" <chao.p.peng@intel.com>
Subject: RE: [PATCH rfcv2 00/20] intel_iommu: Enable stage-1 translation for
 passthrough device
Thread-Topic: [PATCH rfcv2 00/20] intel_iommu: Enable stage-1 translation for
 passthrough device
Thread-Index: AQHbgqfz4Rpn6VXaXUyU2i30ijbHzrOUqMgAgB4y5XCAJ8dZAIABIE0w
Date: Tue, 20 May 2025 09:13:44 +0000
Message-ID: <SJ0PR11MB6744D7EC0B34ED5D5DC679C2929FA@SJ0PR11MB6744.namprd11.prod.outlook.com>
References: <20250219082228.3303163-1-zhenzhong.duan@intel.com>
 <eacfc52a-2dee-49a8-8994-67b738ece68d@redhat.com>
 <SJ0PR11MB6744472953C10F7858FF406F929CA@SJ0PR11MB6744.namprd11.prod.outlook.com>
 <6b9c1f0a-be56-451e-bb8d-833b402b78d8@redhat.com>
In-Reply-To: <6b9c1f0a-be56-451e-bb8d-833b402b78d8@redhat.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: SJ0PR11MB6744:EE_|MN0PR11MB6034:EE_
x-ms-office365-filtering-correlation-id: 49f91d0f-55da-4fb1-c630-08dd977e9ee3
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
 ARA:13230040|7416014|376014|1800799024|366016|38070700018; 
x-microsoft-antispam-message-info: =?us-ascii?Q?P+Iv0MLciE+lw+wvZFKaQzCF2FbEsvuNKISqNlX0X9GkLxoJ8UwNjeNrBnKj?=
 =?us-ascii?Q?lRt+OAevP3IwMr6KLo+txgvaIaBYS+0deaejsItxU3wHU7Z33r5Dw5idT9oj?=
 =?us-ascii?Q?+FB49xM5zlHX6bg8oJTDDzwo8AelclCL2Iu8UyA98keJZDCIVjgnM2TytG6H?=
 =?us-ascii?Q?UVkMAWoIfxPBYWaKDFsG5q5KGEL9XZtpqTyhldZeUAiBTdTXlHX3AbnH+pxR?=
 =?us-ascii?Q?sb+HeaeoFQ9lebvX+H5pZbbXMxvl9OC4FeF2nRXe+wCscq7HVnPx7OiakYWg?=
 =?us-ascii?Q?yAeBfC7f8pwwcH3XmEup8qHzKk1zIFAobHZ/C8wgycH9qbwLHS7dkL+a7Wcr?=
 =?us-ascii?Q?EIMnykzqHjW578CnawPMs1SjGZ9Tb+8dbRCfL5hT7PidpP6/zWQw+4BydbN5?=
 =?us-ascii?Q?6OiTTvnIatafxjJTpRWgfMk2pBQpFcBcEIjFJGEL9cizlCjRIUGHGCWmo2ip?=
 =?us-ascii?Q?Pij0kXb1VnVzTezbmuY4r15yO9hhfoBcNIyuRAz8fmEKuXzJsNETzJrlS18/?=
 =?us-ascii?Q?vvS96JhXptIRtZugNoLyJGNYwp5FDjq4+aqD1N0cGs3GyaRbYo6OiKOwBzqI?=
 =?us-ascii?Q?GzY/qZr7H9xdQu6z6hEgzcmWlKu3KPls7itnylx+9zQn9++WK6uBBp5u5/O+?=
 =?us-ascii?Q?axiDZ40DjI8Gn0DMgctcjNYtpqe1YOqtXEqLTnJwzD3WbohDwc41c2pbW5QZ?=
 =?us-ascii?Q?KQlwjGrs7akn2bxxFABZdUEaOJcxjXNt2ZgqzegLS1nPwLm8ZWkvR9OkQ0fB?=
 =?us-ascii?Q?uExUyGS+j9TB/nQid47FnWnN3DqCvjCcLHREW0ebPQCeIB+dKCrd+8RrcZZJ?=
 =?us-ascii?Q?phsd5jGfwyyYVZeOjsKHwkjTQT+b3mHPmxnSQGw7rP/7550Gjkx4bRTu7LM/?=
 =?us-ascii?Q?ofZ60VUIqrzOXunlp1VK35X0XzXWOWMafnCLX2BUJgBlo6pVDr7jZtExC0Hq?=
 =?us-ascii?Q?Bka0WkVPwDDricHhU/Lseez8Wjo1Vllz0sk8egQrmvDQcosfmI8qu5j/95j7?=
 =?us-ascii?Q?kiYB7fDsymLgYuJ9/mqEwL4FKkjCWTVf5CmBWPKtJdT1047jGQZwAzzaNUop?=
 =?us-ascii?Q?gs3LkhvuNAMUDQGGlmbjyCQymmshZIbjDR/T1xrwspRhEXqpG7g5HfAjKz9S?=
 =?us-ascii?Q?zwRgukgi7b8f6C0ckKhP6AckeoDQtHiHMDsYqXLwKrxZXaOnupBZI2YN9QY+?=
 =?us-ascii?Q?A/voIEqXYDP7pOBdxqgJ77/GrpmkWcfKFKVKli0MlBcej9+icwDhwcx1jgxk?=
 =?us-ascii?Q?9kz4W1/v8Ydil8TQo3R7K9lMAyYHVknRQ4CyWCahl9mq1Az2gs8OPzxA/UqA?=
 =?us-ascii?Q?yBc8iw+U6J8jFJPo9DkwAi7aC2Qeh+eU0Mdf13lUZkxhOJEGfC3WIXSNYQPE?=
 =?us-ascii?Q?wZRbIBxCLm1eH0OpxmrBHm2d7gN/+NfRejwt25Fye3H6UxjUOmzKIRLXEEmS?=
 =?us-ascii?Q?CJDgvjR0lTs=3D?=
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:SJ0PR11MB6744.namprd11.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(7416014)(376014)(1800799024)(366016)(38070700018); DIR:OUT;
 SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?SlNeu54anejJ6yIpalW7pii1DQWU9xMJCCGTMZuR98IULU6J75qK6hct9duC?=
 =?us-ascii?Q?IIEWFbMQDI65Bn31L+8Ugv1q6WveNIaIEv84MVZNUQBNGw982Xe11+C3xbT6?=
 =?us-ascii?Q?U739e99jlFKaj8V8hsFaI/znyDFvOswMmtB7gxuLrR/J+z2bFvPxS2w1gjMv?=
 =?us-ascii?Q?+/OjjsiPHys6riXZUNMl1mJtreKk49jPXf/sonR7SYagnwHLUQIPultHn+xn?=
 =?us-ascii?Q?m6RUOs8kT6WLzTdFNiL+UoUW49iNGo8bEwjbVWTOzdl2uF5IJdEcut2LCpyC?=
 =?us-ascii?Q?JZfEYsR78v+MeKnfJJ3Xh9sr7dDSDykuMRx1TK6p/ElkUnRvr5YJ3xf4d/P5?=
 =?us-ascii?Q?jSXSQfz7gOPmk4Jj+tEj4OdUDHpBWLuDU5cE1ZZNdqoD8Y3uk2DGZ+o0zJBK?=
 =?us-ascii?Q?H0V2o9Nl8gkIc7rHCHXZ8uzbrrlpL5SNKcEzwjz24holXz3rj1uCwsfVwbAV?=
 =?us-ascii?Q?yNRGoQ11TLj/Iy4sIydL/KfMrqK2Vlr6dxb7J8LM473IiZmIAGoqU9BaFBFZ?=
 =?us-ascii?Q?HYYD9u4Rer2OGsMVw+u4NK4s1ATphZDiICzL/9ur0B2q04RVbDB1+T1IYgMu?=
 =?us-ascii?Q?zjVPNWflzPCLIT5qBWr5OZtWVQgm6TBt0D3rIJwUGlSpXAhatVCyPZtahuW+?=
 =?us-ascii?Q?nfM998Mb7/aUKpT3o+wu3OJnJGixWA1lIS4V2hH1jF1yUKiooQ6mNqE3mPJX?=
 =?us-ascii?Q?00yXULFSCsExItkxLdxuiWxXDOEYcH/QVLDr41JmTABYwL9+IU5Jh7fs22XN?=
 =?us-ascii?Q?gWS9o6YTDFtmitgOMjeHukStrQlSd9fhW0rcUJaG6bYOJj2K8puMPvbBbDDZ?=
 =?us-ascii?Q?x5c/PrQTKhrHqUkl9HvADAh3+AoLGDwUbz8hD9pXd7b52AFT7W4X23cKDyBd?=
 =?us-ascii?Q?0W5eN2REDyP2R2duU6qqLmykWSpa24OOlSmsUV34FzeVTdIlDwaQTpUvNs7w?=
 =?us-ascii?Q?v2aTG05QC2HuDGavL8rB3APmGoTuwU3rvf7oWQ7cVbH6rG0jFMPFJLHeW0Y9?=
 =?us-ascii?Q?6fzx+++vOFTOmwNRVFZlgv7TR7N0WaEZOCErIK7vzCIcXJ/vEG0Ksi+pIKG0?=
 =?us-ascii?Q?SoNTPhjluv92dnGSOwAryiXKwIJArOQ8SkQ9Batjin/Mb9MDGW3T1jyWHpbs?=
 =?us-ascii?Q?x5sh/5CRJ5aNOfEMsowyrG2tr2YiZfbI1IpJ4gAuePkcQLUIzJZRDipWyssd?=
 =?us-ascii?Q?8HqSBgN6SUuBMsEdFL2gEWgSgUL/3QwWfCzuEQdaX1MvBRLHcHE0SdYs0uAU?=
 =?us-ascii?Q?OSjdIoW9YTS0JiuN42owIAO9GGI/cbEYnL0G1y7cOefbHWmsACKV2o88OiDf?=
 =?us-ascii?Q?80tHzJMwxenCCHeq5031F6oqWfSDtViaJFduHkIBWOF7xk8JJbf66AnLsBYs?=
 =?us-ascii?Q?8Wmq5Z7oyXKfw/ibvec6ppWhIUTghAqi+veZAZ+q7AXLIkwmMG2pvElLYo3A?=
 =?us-ascii?Q?CBrdDmmAGyYNpFEuUY+4ffnkj22zB/a0iTHxVoYUG6tkjj2Wocy9wfAlUuMK?=
 =?us-ascii?Q?UkkZGXMlRDffKPNgLUbMpgQeBupRte0khlrQWq1JNJHESeiFwByCzk7TNuj2?=
 =?us-ascii?Q?B+Rg46m0LKnLCL0HYr46ViV2EqoGk6cVFgS3uMuN?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: SJ0PR11MB6744.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 49f91d0f-55da-4fb1-c630-08dd977e9ee3
X-MS-Exchange-CrossTenant-originalarrivaltime: 20 May 2025 09:13:44.3641 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: +yix2SKFRjwDqPHoGmCgXuPKV9QZufcdJ4uFMWklA4SJTvocovGPpSfEySHYpCMuDZceyxICD4L25pQu/dHMwY0u7Y0zQIa8YMnMmM0bru4=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN0PR11MB6034
X-OriginatorOrg: intel.com
Received-SPF: pass client-ip=192.198.163.18;
 envelope-from=zhenzhong.duan@intel.com; helo=mgamail.intel.com
X-Spam_score_int: -44
X-Spam_score: -4.5
X-Spam_bar: ----
X-Spam_report: (-4.5 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.13,
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
>From: Donald Dutile <ddutile@redhat.com>
>Subject: Re: [PATCH rfcv2 00/20] intel_iommu: Enable stage-1 translation f=
or
>passthrough device
>
>Hey Zhenzhong,
>Thanks for feedback. replies below.
>- Don
>
>On 5/19/25 4:37 AM, Duan, Zhenzhong wrote:
>> Hi Donald,
>>
>>> -----Original Message-----
>>> From: Donald Dutile <ddutile@redhat.com>
>>> Subject: Re: [PATCH rfcv2 00/20] intel_iommu: Enable stage-1 translatio=
n for
>>> passthrough device
>>>
>>> Zhenzhong,
>>>
>>> Hi!
>>> Eric asked me to review this series.
>>> Since it's rather late since you posted will summarize review feedback
>>> below/bottom.
>>>
>>> - Don
>>>
>>> On 2/19/25 3:22 AM, Zhenzhong Duan wrote:
...

>>>            Did you ever put some tracing in to capture avg hits in cach=
e? ... if so,
>add
>>> as a comment.
>>>            Otherwise, looks good.
>>>
>>> Patch 11: Apologies, I don't know what 'flts' stands for, and why it is=
 relative
>to 2-
>>> stage mapping, or SIOV.  Could you add verbage to explain the use of it=
, as the
>>> rest of this patch doesn't make any sense to me without the background.
>>> The patch introduces hw-info-type (none or intel), and then goes on to =
add a
>>> large set of checks; seems like the caps & this checking should go toge=
ther
>(split
>>> for each cap; put all caps together & the check...).
>>
>> OK, will do. There are some explanations in cover-letter.
>> For history reason, old vtd spec define stage-1 as first level then swit=
ch to first
>stage.
>>
>So 'flts' is 'first level then switch' .

Sorry for confusion, it stands for 'first level translation support'.

>
>>>
>>> Patch 12: Why isn't HostIOMMUDevice extended to have another iommu-
>specif
>>> element, opaque in HostIOMMUDevice, but set to specific IOMMU in use?
>e.g.
>>> void *hostiommustate;
>>
>> Yes, that's possible, but we want to make a generic interface between
>VFIO/VDPA and vIOMMU.
>>
>ok. I don't understand how VFIO & VPDA complicate that add.

IIUC, the hostiommustate provided by VFIO and VDPA may be different format.
By using a general interface like .get_cap(), we hide the resolving under V=
FIO and
VDPA backend. This is like the KVM extension checking between QEMU and KVM.

FYI, there was some discuss on the interface before,
see https://lists.gnu.org/archive/html/qemu-devel/2024-04/msg02658.html

>
>>>
>>> Patch 13: Isn't PASID just an extension/addition of BDF id? and doesn't=
 each
>>> PASID have its own address space?
>>
>> Yes, it is.
>>
>>> So, why isn't it handle via a uniqe AS cache like 'any other device'?  =
Maybe I'm
>>> thinking too SMMU-StreamID, which can be varying length, depending on
>>> subsystem support.  I see what appears to be sid+pasid calls to do the =
AS
>lookups;
>>> hmm, so maybe this is the generalized BDF+pasid AS lookup?  if so, mayb=
e a
>>> better description stating this transition to a wider stream-id would s=
et the
>code
>>> context better.
>>
>> Not quite get..
>>
>I'm looking for a better description that states the AS cache lookup is br=
oadened
>from bdf
>to bdf+pasid.

Guess you mean vtd_as_from_iommu_pasid(), it's a variant of vtd_find_add_as=
().
We support AS cache lookup by bdf+pasid for a long time, see vtd_find_add_a=
s().

>
>>> As for the rest of the (400 intel-iommu) code, I'm not that in-depth in=
 intel-
>iommu
>>> to determine if its all correct or not.
>>>
>>> Patch 14: Define PGTT; the second paragraph seem self-contradicting -- =
it says
>it
>>> uses a 2-stage page table in each case, but it implies it should be dif=
ferent.  At
>580
>>> lines of code changes, you win! ;-)
>>
>> The host side's using nested or only stage-2 page table depends on PGTT'=
s
>setting in guest.
>>
>Thanks for clarification.
>
>>>
>>> Patch 15: Read-only and Read/write areas have different IOMMUFDs?  is t=
hat
>an
>>> intel-iommu requriement?
>>>            At least this intel-iommu-errata code is only in hw/i386/<> =
modules.
>>
>> No, if ERRATA_772415, read-only areas should not be mapped, so we alloca=
te a
>new VTDIOASContainer to hold only read/write areas mapping.
>> We can use same IOMMUFDs for different VTDIOASContainer.
>>
>ah yes; I got hung-up on different mappings, and didn't back up to AS-cont=
ainer
>split & same IOMMUFD.
>
>>>
>>> Patch 16: Looks reasonable.  What does the 'SI' mean after "CACHE_DEV",
>>> "CACHE_DOM" & "CACHE_PASID" ? -- stream-invalidation?
>>
>> VTD_PASID_CACHE_DEVSI stands for 'pasid cache device selective invalidat=
ion',
>> VTD_PASID_CACHE_DOMSI means 'pasid cache domain selective invalidation'.
>>
>That explanation helps. :)  maybe put a short blurb in the commit log, or =
code,
>so one doesn't have to be a ninja-VTD spec consumer to comprehend those
>(important) diffs.

Good idea, will do.

>
>> Thanks
>> Zhenzhong
>>
>Again, thanks for the reply.
>Looking fwd to the rfcv3 (on list) or move to v1-POST.

Thanks for your comments!

BRs,
Zhenzhong

