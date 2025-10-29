Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 460C0CCD1BF
	for <qemu-devel@archiver.kernel.org>; Wed, 29 Oct 2025 07:40:19 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vE0mU-0004RZ-A5; Wed, 29 Oct 2025 03:39:42 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <zhenzhong.duan@intel.com>)
 id 1vE0mS-0004PQ-GI
 for qemu-devel@nongnu.org; Wed, 29 Oct 2025 03:39:40 -0400
Received: from mgamail.intel.com ([192.198.163.14])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <zhenzhong.duan@intel.com>)
 id 1vE0mQ-0000FK-0G
 for qemu-devel@nongnu.org; Wed, 29 Oct 2025 03:39:40 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1761723578; x=1793259578;
 h=from:to:cc:subject:date:message-id:references:
 in-reply-to:content-transfer-encoding:mime-version;
 bh=FiY2gJlnWzfSL5T4/9JQWshoDcF/k5icTe3ioGzbq14=;
 b=EZ0h2UAJjYz6q1HFY0c7mSUlN0KgBfo1/5Xu2exWhyBOieDq8QzWEtjE
 bLdD0iOgSaHIZTHms8WLdUgwcpjYPdAyGpsIv2HVj8DCtvCf3IHEakX9/
 BZJaI9qpkZIdNtUpqZ6KixGFkeTyukrtCh+YE0Tor47tRQovIr/EVjzN0
 dztBuZutlvAYCAR3pjc5fgqAgJIrH5t7VcevgFpK85uvDyq6SRtZ+rB91
 nUY9ijUvQanS51P4qvweupL0lj/iKVkzcKS7npQB9mwetSJb0ypF2uFAr
 l8Flt/bhq3IcSMME24p6rkOBOYHPrLVug9mUHpP0Bpqu43+TQ3MzmjXEG g==;
X-CSE-ConnectionGUID: NTrx3fGaSXSJa8O+p71BtQ==
X-CSE-MsgGUID: PIxMAu5TQBqvUjJZhUIaeA==
X-IronPort-AV: E=McAfee;i="6800,10657,11586"; a="63871391"
X-IronPort-AV: E=Sophos;i="6.19,263,1754982000"; d="scan'208";a="63871391"
Received: from fmviesa009.fm.intel.com ([10.60.135.149])
 by fmvoesa108.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 29 Oct 2025 00:39:31 -0700
X-CSE-ConnectionGUID: A1tVtTAETIKzjTc+M3HDlQ==
X-CSE-MsgGUID: ALvmfaCUSJeoWeHA9LVvyQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.19,263,1754982000"; d="scan'208";a="186040892"
Received: from fmsmsx903.amr.corp.intel.com ([10.18.126.92])
 by fmviesa009.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 29 Oct 2025 00:39:23 -0700
Received: from FMSMSX901.amr.corp.intel.com (10.18.126.90) by
 fmsmsx903.amr.corp.intel.com (10.18.126.92) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.27; Wed, 29 Oct 2025 00:39:22 -0700
Received: from fmsedg902.ED.cps.intel.com (10.1.192.144) by
 FMSMSX901.amr.corp.intel.com (10.18.126.90) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.27 via Frontend Transport; Wed, 29 Oct 2025 00:39:22 -0700
Received: from BYAPR05CU005.outbound.protection.outlook.com (52.101.85.29) by
 edgegateway.intel.com (192.55.55.82) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.27; Wed, 29 Oct 2025 00:39:22 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=NgmbLh7SzCknY5FiFZpv/EeZdpo0Bvh74uIU/9NjydjIK46ZPRpiaSuIup9THdbnnkg3kJ5eUY3TeaTc/o9idFG3NqU5uEW1PnJNFcrhI3Y3tcmmO1wqATriVJ/Z+If1pGB4ohHsmw6J/uovGY491Gn2wHtu6VTRtxq31vBtIph+cV9/vz8uEXjkhaJaMh86wDBeckzz71++Oq/xgazdTb6oLQdZ8d8HSFijSQ/NuHm0r9xK8u8EhXf3a0FAtK5yaTz4S7dlDGwcqXHvZNqPQqGKOHANVgjXdbhM5pKADQhelagHw/YQPGbNmyO3Z4gzsPyiM2ubAOWsf/e+Y1vNNw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=POdkBQU9Gx7Xgm40BlUR883XWPlT5ugT2Ei2zMLoqKY=;
 b=ehmPF/p2IM99GYxUvPLxvRFDfPZeH/R8vNr0+NoyG3HpT7PUVWSgOdLdM4GoTpbOBdTjU014SI/kMZQHDjiggGa2kjUXOR1JN7otO5RovEYf0VI0YCEOP5sm2TeHSLNS6aiC3Qni7YmByW7S60Xj1ec6D6AAZZE8Y7XbvNqgftcxpkaNZKdV2jiI9d+VMuY/4LqYikDOqrmK2iPnz4bC9SNFNpKJXnF3glAa6w7kipnHj3xUHFVYqCvmSiu7X4rT/OA9psyZTLFp8fjbjMhbZVCtMydWn8s9q/cqBdkUqjwOatXWnTOxrObAjc6xNB9B93BSa2s3oAT37FtS0g+1cg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Received: from IA3PR11MB9136.namprd11.prod.outlook.com (2603:10b6:208:574::12)
 by SA2PR11MB5196.namprd11.prod.outlook.com (2603:10b6:806:119::18)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9275.13; Wed, 29 Oct
 2025 07:39:21 +0000
Received: from IA3PR11MB9136.namprd11.prod.outlook.com
 ([fe80::604b:77a4:b1be:3f13]) by IA3PR11MB9136.namprd11.prod.outlook.com
 ([fe80::604b:77a4:b1be:3f13%7]) with mapi id 15.20.9275.013; Wed, 29 Oct 2025
 07:39:21 +0000
From: "Duan, Zhenzhong" <zhenzhong.duan@intel.com>
To: Avihai Horon <avihaih@nvidia.com>, "qemu-devel@nongnu.org"
 <qemu-devel@nongnu.org>
CC: "alex.williamson@redhat.com" <alex.williamson@redhat.com>,
 "clg@redhat.com" <clg@redhat.com>, "mst@redhat.com" <mst@redhat.com>,
 "jasowang@redhat.com" <jasowang@redhat.com>, "Liu, Yi L"
 <yi.l.liu@intel.com>, "clement.mathieu--drif@eviden.com"
 <clement.mathieu--drif@eviden.com>, "eric.auger@redhat.com"
 <eric.auger@redhat.com>, "joao.m.martins@oracle.com"
 <joao.m.martins@oracle.com>, "Hao, Xudong" <xudong.hao@intel.com>, "Cabiddu,
 Giovanni" <giovanni.cabiddu@intel.com>, Rohith S R <rohith.s.r@intel.com>,
 "Gross, Mark" <mark.gross@intel.com>, "Van De Ven, Arjan"
 <arjan.van.de.ven@intel.com>
Subject: RE: [PATCH v3 7/8] vfio/migration: Add migration blocker if VM memory
 is too large to cause unmap_bitmap failure
Thread-Topic: [PATCH v3 7/8] vfio/migration: Add migration blocker if VM
 memory is too large to cause unmap_bitmap failure
Thread-Index: AQHcRItd1NuuAkS0QkmUjZpJpRcNK7TV4BKAgAFErXCAAGvNgIAA2g/w
Date: Wed, 29 Oct 2025 07:39:21 +0000
Message-ID: <IA3PR11MB9136DC9FD1D8E8902CE526F992FAA@IA3PR11MB9136.namprd11.prod.outlook.com>
References: <20251024020922.13053-1-zhenzhong.duan@intel.com>
 <20251024020922.13053-8-zhenzhong.duan@intel.com>
 <df474b7c-b210-43ba-9c0f-97526aaf5f93@nvidia.com>
 <IA3PR11MB91368D67E7C5D853161B7D0292FDA@IA3PR11MB9136.namprd11.prod.outlook.com>
 <d1668b37-fb8b-44f0-9f85-fb68a999056a@nvidia.com>
In-Reply-To: <d1668b37-fb8b-44f0-9f85-fb68a999056a@nvidia.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: IA3PR11MB9136:EE_|SA2PR11MB5196:EE_
x-ms-office365-filtering-correlation-id: da9c7248-10d5-4cb2-eb13-08de16be4659
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0; ARA:13230040|366016|1800799024|376014|38070700021;
x-microsoft-antispam-message-info: =?iso-8859-1?Q?uswl1NAaPtUCWHDH7j6Y6pnY2mpQL8tN52r6ROhFpTKmMZ/5tEDIFERo4U?=
 =?iso-8859-1?Q?Y3cW+vUO5LejCuQF4Y9hmSh7XLi1FKkiNMbeyehnUHA7yCKcv0HlzDswsv?=
 =?iso-8859-1?Q?oWYj4Yhvzoz9I7WmRz2KiFTzfIHWGM6i5RuzIvVq0Wd+bfLtBLGE+HAzy2?=
 =?iso-8859-1?Q?W5xruTsUq2pfqCsgony13AbpDUB3iLELmmIuMxm/h5LW8RkHRyw0TOij7p?=
 =?iso-8859-1?Q?yParTsBKNYOEcmUIM+Ka0FUGO04fPmLZyTymWXQCQBpgwtyhKJ1K1mvU5G?=
 =?iso-8859-1?Q?oQMNu+gD2kVItTK3mEY23FaNTxJRUDQ9rqBo/CncqD5rCH/haxEfg2scTw?=
 =?iso-8859-1?Q?YoXiCOj/Bh6gHg4ijwhCJWXce9QZmSvaz+00LNqIfTlwPDbsD1jTVUfu/4?=
 =?iso-8859-1?Q?8jGBxWeCCMxzUv66nj+th9xHaZOlIyzPYgcC40XjCFCXs5P1Wn2C+0tmQw?=
 =?iso-8859-1?Q?6Om1N531m/0swn22Dse+9ANNNUE0btkPM1M3oF8l1tvgOiZ+hFW/ST2X42?=
 =?iso-8859-1?Q?Y3UxDf4E6FqUAx769LqJYwZbfN66cPoMXp2SuIsD8wYo/yyh9TxEPMH4qB?=
 =?iso-8859-1?Q?41TPCHAGW1UNW//pUO5Ott2jr8ThmhvJ/e5vCOcFEmYyPXhdKDzLd9pV9J?=
 =?iso-8859-1?Q?SSl/jWNA4qGztdBnm5lQlozysHm7Ylie62FOWGjmNX5KDGLvGmW3qC3GfJ?=
 =?iso-8859-1?Q?zK9wRBkissSs6OYd2wSk2jqjG8sC3ECTd8xk/SE7CvuZ06X1cF5iEwmbMA?=
 =?iso-8859-1?Q?qUw4rjXekftJ+YXwthQPslZPLhfvyUjs9fBmPbsWVDXVr+Sqdi2XH45DsZ?=
 =?iso-8859-1?Q?zNH9gnNm/fdJIsilc2Fi3Dv3GWWDk7fPn6sQhX+ozRyX1ze1iveBTduLuJ?=
 =?iso-8859-1?Q?WXySjL3au0YY7xrellZohJJYow+a9wmSTG7plPoQXSmvrX0bm1oqU9HpAl?=
 =?iso-8859-1?Q?bYwyChr//hUJ32fYDaGuQNzRIv77LoH9BWCruzrOLNbmheyArPZN14AkL2?=
 =?iso-8859-1?Q?haqZRCiiphgtYtHhCy+sNpEQ2a0huT3+VLrSfFVoAenN6IRb//eWnbNBWp?=
 =?iso-8859-1?Q?mcpyQA3Wv42XuNKLVZyhVCh0D3AM/9Ms8uUJdeO+fvTpzx115rJs07PPlt?=
 =?iso-8859-1?Q?B1pXuJQKL0pJnf2udpfbLb+jr+HBBxIeRAXwQo9kIkhLwTu8yzuEXwCqgQ?=
 =?iso-8859-1?Q?E3Bi9Ly6+KkkdncyUK784GyMFTXDW3zD4AJT/+I1WGWAybwIJRJx80CxuJ?=
 =?iso-8859-1?Q?eN/LDOm9FVUk9b/0dqocQEpLcv6Ea6AcUS9DNzTeOTjgywkVUvWLs7XOhV?=
 =?iso-8859-1?Q?ZrNzM1aadWjlbE5mRPqLueyybvx/L6sw+Jqu+eT+K4G6jg+KpfZ090zB+P?=
 =?iso-8859-1?Q?BYUsM0pUW7C20oseXvUTamm9dyOCEGhkbp1TmygnIQoWNNPvSp79fouJhM?=
 =?iso-8859-1?Q?4m/nfM7o+4NRyKseisCqCDyBsO3X7SH6IrJSPH1UNtu1/o3MGMDu20bHVd?=
 =?iso-8859-1?Q?J42wAC0hgwSBS8KfXepU+TZI5oqi+Q2HUviQIahqKMu6DCENeHnr1BSLrD?=
 =?iso-8859-1?Q?mYsDJDabsVWGuX0ny3nV209BRiTZ?=
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:IA3PR11MB9136.namprd11.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(366016)(1800799024)(376014)(38070700021); DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?iso-8859-1?Q?ct12ginDIxNexwwG6/bJCZ6bGZKKYmJXyb2VXLtiTw3VdukFBqi6uRcy8h?=
 =?iso-8859-1?Q?q13kLKq0yjNDamLAPRSgd67TGQo+QFqyXF3ds46tXsTybIdFW1eBDe+zyM?=
 =?iso-8859-1?Q?0aRvWgEa1EjEqUDzIDgSEKI26e/8oMh/9/8NQxv1YivUUjMM5LIG2pp4pV?=
 =?iso-8859-1?Q?dK7VOiSm5tvqzAccqbwiECMFoa4hPuFpKWbGt0RQzd5tsoOaNx7uAIfjly?=
 =?iso-8859-1?Q?pb6DhJPvR6aq8OKIsre2vxSQaY1wInjnmVdNdizESLrMUVf3Nwjoaih0PO?=
 =?iso-8859-1?Q?yS/7NvMfQ9cLFGSTtlujfxQbHhyDZa2CUbc+IoCZjzy/fgG3TsAQbyA7AK?=
 =?iso-8859-1?Q?hPBSez8I98sRFrbpZE3/TgxZR4Tf2xwwwSTFI1xsMWUUV7uf1rS089E8DD?=
 =?iso-8859-1?Q?PuZ8HNcfcRYgBmmPlZT3DxrQk7Fc2ggjWDlxbYrNUarlleVoa/GLMJ+bse?=
 =?iso-8859-1?Q?kIy39P8BJYKsP9llwc90q6V2lpYH4WmS2yoFoOYUxiWBYFTtD3Jw4XHpmq?=
 =?iso-8859-1?Q?KvqWP5IlJchHpPyiUUnLK+8pnyJGTaMughdH+wt3OE20PYA3DNzEUXq6xK?=
 =?iso-8859-1?Q?Wgg52ReoeQ52Noipx7VOoAmeQqaGEwOJNQlNC+FZYrLcoSjVmzbFuv1LO3?=
 =?iso-8859-1?Q?HJOxWrdsN+vHd0yegZOWHPpVaDKu+DINgCI0mYbAvQKpGp/6AvfrFfoc3+?=
 =?iso-8859-1?Q?VtG+60i1vn5WLZsvn6IqmKX/CO4Py4A05hTFr1DiHsoI2L0dZxfnygu+8F?=
 =?iso-8859-1?Q?1P4Wia5Nyk5L6dOySW4GbCrVm6NnIj5+vl85uITyXXjyE0ScFGotVBHN0u?=
 =?iso-8859-1?Q?323p/HtfBV6ExZq1KET3ym3wqzMGV6XiUey5+Fw2IKU0F3iSzNqfSpCqt7?=
 =?iso-8859-1?Q?jJDZmCpg6JnIOdqv35pI9JYOp5CjP/xHKKnU81NPG20u1EjKe3kEdnH2AA?=
 =?iso-8859-1?Q?4eCN11VimIdg7C6KiQ9B3MRjIm8WQci1BvHm03+/3H95w/rIfhMR6Mtmsr?=
 =?iso-8859-1?Q?6jF7x6DcXTXPXJs0BuwmQ6hsrrvApgWu9/BNPChI48nyPSmpstum0HS0r9?=
 =?iso-8859-1?Q?TX7WQLh1JE+OfCd4BxGlbluCi+mREJbuwEfVsjj0mVKSCVrhiW7CKUvlP3?=
 =?iso-8859-1?Q?gAudL8l7GUDKXkZwECGz9C+ibDiuBOKIsfvPRWSanJVhgZEjaO2+MgRzxc?=
 =?iso-8859-1?Q?ddRNK+lOSu/NC8XJ/gmFxE0ohrjuhDmoUal+9caD1/vyI3GWR1gtnc6aXu?=
 =?iso-8859-1?Q?ws3caW89y6JCsdQtk7C4VahLrE2nIid1hR6AhNCc57l7CFzShkowSo2FQ6?=
 =?iso-8859-1?Q?SEtJt/1FxHl/rOuRDNSMJzh7OG9Pe2P04aOaMlK6XWReYKctEklVlt7Nk8?=
 =?iso-8859-1?Q?c5lGgjEGrwsbfcYmLCrw8jevfI1j983hbR12k042A04L63kjTT0UhJh5TC?=
 =?iso-8859-1?Q?sT75mZ+MIqqzcgfhUihA6t7JeP+AmZk9sA4TLixsNM5/98U3AnK+ybCzsK?=
 =?iso-8859-1?Q?iBrK0Ce3YpIdBYxhGCcNuZtErCp5ziHTEFhUHeyvVhp7HS1L7iFQCigaKn?=
 =?iso-8859-1?Q?3U1XrdTI91tSTxQXzWBYyAHxnJMqzEu0LgDGvUdqsdjwcNGV6p6LdTj0lE?=
 =?iso-8859-1?Q?YnQ0ylih9iBXkNZ8itPG33yeEBabhvvod5?=
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: IA3PR11MB9136.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: da9c7248-10d5-4cb2-eb13-08de16be4659
X-MS-Exchange-CrossTenant-originalarrivaltime: 29 Oct 2025 07:39:21.2986 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: ZqJ8IIJvFtEB93eR0qRo1nBbbUQq8UCBvFgmwTusOEQuC89ftHnrL8JvAGM8t1yTE94yCR3bxMKdTiUJoESdYdk0EHY65x12sxFkc4jbnO4=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA2PR11MB5196
X-OriginatorOrg: intel.com
Received-SPF: pass client-ip=192.198.163.14;
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
>From: Avihai Horon <avihaih@nvidia.com>
>Subject: Re: [PATCH v3 7/8] vfio/migration: Add migration blocker if VM
>memory is too large to cause unmap_bitmap failure
>
>
>On 28/10/2025 11:32, Duan, Zhenzhong wrote:
>> External email: Use caution opening links or attachments
>>
>>
>> Hi
>>
>>> -----Original Message-----
>>> From: Avihai Horon <avihaih@nvidia.com>
>>> Subject: Re: [PATCH v3 7/8] vfio/migration: Add migration blocker if VM
>>> memory is too large to cause unmap_bitmap failure
>>>
>>> Hi,
>>>
>>> On 24/10/2025 5:09, Zhenzhong Duan wrote:
>>>> External email: Use caution opening links or attachments
>>>>
>>>>
>>>> With default config, kernel VFIO IOMMU type1 driver limits dirty bitma=
p
>to
>>>> 256MB for unmap_bitmap ioctl so the maximum guest memory region is
>no
>>> more
>>>> than 8TB size for the ioctl to succeed.
>>>>
>>>> Be conservative here to limit total guest memory to max value supporte=
d
>>>> by unmap_bitmap ioctl or else add a migration blocker. IOMMUFD
>backend
>>>> doesn't have such limit, one can use IOMMUFD backed device if there is=
 a
>>>> need to migration such large VM.
>>>>
>>>> Suggested-by: Yi Liu <yi.l.liu@intel.com>
>>>> Signed-off-by: Zhenzhong Duan <zhenzhong.duan@intel.com>
>>>> ---
>>>>    hw/vfio/iommufd.c   |  5 +++++
>>>>    hw/vfio/migration.c | 33 +++++++++++++++++++++++++++++++++
>>>>    2 files changed, 38 insertions(+)
>>>>
>>>> diff --git a/hw/vfio/iommufd.c b/hw/vfio/iommufd.c
>>>> index ba5c6b6586..8de765c769 100644
>>>> --- a/hw/vfio/iommufd.c
>>>> +++ b/hw/vfio/iommufd.c
>>>> @@ -633,6 +633,11 @@ skip_ioas_alloc:
>>>>        QLIST_INIT(&container->hwpt_list);
>>>>
>>>>        bcontainer =3D VFIO_IOMMU(container);
>>>> +
>>>> +    /* There is no limitation on dirty bitmap size in IOMMUFD */
>>>> +    bcontainer->max_dirty_bitmap_size =3D UINT64_MAX;
>>>> +    bcontainer->dirty_pgsizes =3D qemu_real_host_page_size();
>>>> +
>>>>        vfio_address_space_insert(space, bcontainer);
>>>>
>>>>        if (!iommufd_cdev_attach_container(vbasedev, container, errp))
>{
>>>> diff --git a/hw/vfio/migration.c b/hw/vfio/migration.c
>>>> index 4c06e3db93..44bab024b7 100644
>>>> --- a/hw/vfio/migration.c
>>>> +++ b/hw/vfio/migration.c
>>>> @@ -16,6 +16,7 @@
>>>>    #include <sys/ioctl.h>
>>>>
>>>>    #include "system/runstate.h"
>>>> +#include "hw/boards.h"
>>>>    #include "hw/vfio/vfio-device.h"
>>>>    #include "hw/vfio/vfio-migration.h"
>>>>    #include "migration/misc.h"
>>>> @@ -1152,6 +1153,31 @@ static bool vfio_viommu_preset(VFIODevice
>>> *vbasedev)
>>>>        return vbasedev->bcontainer->space->as !=3D
>>> &address_space_memory;
>>>>    }
>>>>
>>>> +static bool vfio_dirty_tracking_exceed_limit(VFIODevice *vbasedev)
>>>> +{
>>>> +    VFIOContainer *bcontainer =3D vbasedev->bcontainer;
>>>> +    uint64_t max_size, page_size;
>>>> +
>>> IIUC, this check is not relevant when using VFIO device dirty tracking,
>>> so maybe bail early if VFIO device dirty tracking is used?
>>> E.g.:
>>>
>>> if (vbasedev->dirty_pages_supported
>>> &&=A0vbasedev->device_dirty_page_tracking !=3D ON_OFF_AUTO_OFF) {
>>>      return false;
>>> }
>>>
>>> And replace this with vfio_device_dirty_pages_disabled() in patch #8?
>> OK, will do.
>> Previously, I thought 8TB is a size of super large that device dirty tra=
cking
>will never support due to hardware limit.
>
>Yes, it could be, but what confused me is that we check
>bcontainer->dirty_pages_supported also when using device DPT, although
>it's not relevant for it AFAIU.
>So even with memory size < 8TB, if device DPT is used and
>bcontainer->dirty_pages_supported =3D=3D false, migration would be blocked=
.

OK, that's an issue, will fix it.

Thanks
Zhenzhong

