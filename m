Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D9005CCA470
	for <qemu-devel@archiver.kernel.org>; Wed,  8 Oct 2025 10:16:16 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1v6RCX-0000lz-JN; Wed, 08 Oct 2025 06:15:17 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <zhenzhong.duan@intel.com>)
 id 1v6RCW-0000lq-1E
 for qemu-devel@nongnu.org; Wed, 08 Oct 2025 06:15:16 -0400
Received: from mgamail.intel.com ([198.175.65.10])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <zhenzhong.duan@intel.com>)
 id 1v6RCT-0003jW-5E
 for qemu-devel@nongnu.org; Wed, 08 Oct 2025 06:15:15 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1759918513; x=1791454513;
 h=from:to:cc:subject:date:message-id:references:
 in-reply-to:content-transfer-encoding:mime-version;
 bh=IMiU0Qcwy/Qr/qqdTEyIIeyWm8JqQi2yceXWgEFSjSc=;
 b=CpZ7kD8Xoh7GqZcvbhlSHi2QbkeQ5OUIy6Waoa5jdXjyHb2a/5bU+aRn
 lx/sj9oHnYaeIn2BhDMkCPgzCuhUKb5pVGTtcqFzonQcHdanyM97JnaQ/
 1WnIg1XyyjG/ZpkQiLREh60DGxmBAb0IukOHGlkdLqpKHJJNJHTXRVJ4U
 nRpW5XM5Kl4Nqh9fCx6Q+f7B3ha71pakbWH8tKEQFVowR5Mac62P3xnfe
 bdglEZhNRm/sQbUdTv+ksgiiBLuJpstso24c9l5vVtPshTxZdesb4yyr0
 C9r3GUXTUMv8Wv5Doh3UtFmbwofpjffgeWMADBg0m0byaDfD2esFB1cxo g==;
X-CSE-ConnectionGUID: BQdHc2jdS3+w268Sxjx6+g==
X-CSE-MsgGUID: 0KuBsShkR562yy0D57jbvA==
X-IronPort-AV: E=McAfee;i="6800,10657,11575"; a="79543251"
X-IronPort-AV: E=Sophos;i="6.18,323,1751266800"; d="scan'208";a="79543251"
Received: from orviesa003.jf.intel.com ([10.64.159.143])
 by orvoesa102.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 08 Oct 2025 03:15:08 -0700
X-CSE-ConnectionGUID: 4GeTRtbMSnaGjQtvwXKQog==
X-CSE-MsgGUID: Rh3NoOENQWCj7AdFfdKVZA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.18,323,1751266800"; d="scan'208";a="184437528"
Received: from fmsmsx903.amr.corp.intel.com ([10.18.126.92])
 by orviesa003.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 08 Oct 2025 03:15:08 -0700
Received: from FMSMSX903.amr.corp.intel.com (10.18.126.92) by
 fmsmsx903.amr.corp.intel.com (10.18.126.92) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.27; Wed, 8 Oct 2025 03:15:07 -0700
Received: from fmsedg901.ED.cps.intel.com (10.1.192.143) by
 FMSMSX903.amr.corp.intel.com (10.18.126.92) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.27 via Frontend Transport; Wed, 8 Oct 2025 03:15:07 -0700
Received: from DM1PR04CU001.outbound.protection.outlook.com (52.101.61.50) by
 edgegateway.intel.com (192.55.55.81) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.27; Wed, 8 Oct 2025 03:15:07 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=gikI8baZEdOB7mBTfzNvSyZYTljj92wCdNaTtiE27X2KX9KlTVARYcEfJohKu4IVxa8qSKKheHJGLWJ8EjQFPFhAZk2zEZQ4bEzGU0xVzRqf4ma4v4sZvsAuNxRohcR94MmMNF7qerwYg9OlOHoicPLsqVDX+7eSqh/+rWIhUZGtu0V+TdcLpxGAJ5Qg1KeFGH8yGRm9FdVrRoga0fN5xZuHbxRVdDwLw3irUh7bdU7h6DGhMsx/PTv69jw4qXDUc3YsSAP1zdMsU1nJXsJomuPMt302iOdbIFmyO5UK3xTGwxcnART+waMZQfX43MPtUOz4JLKsZMEd8tv4DM+l8w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=IMiU0Qcwy/Qr/qqdTEyIIeyWm8JqQi2yceXWgEFSjSc=;
 b=UCxp22JDFXsosMrxDF/oe9prl65BlV6gpJkSh1JHKx7x9lz4P9tjNlGMXn1bKh/TRM4O6Nzdo8vhJhaGqQaG4mOrOVFYZVEHqli6UQGPLejQR79i+sNqGPisED5ZI+fvD2GmZpuE1NnhW3fWf81d2itKybitAfkASh0gKv3RRZpIm3hwnpnHZzY8YwhYFuEfUFD3epwNoV7H1C1NH7oJYQBCh9U5vQk/jUvIt+fbi+/yOVYqOfjYZaucNM1bja4S9vU7zXCtpNIBUHX2MIEH1RbkE5KyzgG1p+67rQhC82LneA6VUYC+uEOZdSRdL7JgV0yY4yC0Vv28fYvwQ74cnw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Received: from IA3PR11MB9136.namprd11.prod.outlook.com (2603:10b6:208:574::12)
 by MW3PR11MB4635.namprd11.prod.outlook.com (2603:10b6:303:2c::20)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9203.9; Wed, 8 Oct
 2025 10:15:01 +0000
Received: from IA3PR11MB9136.namprd11.prod.outlook.com
 ([fe80::604b:77a4:b1be:3f13]) by IA3PR11MB9136.namprd11.prod.outlook.com
 ([fe80::604b:77a4:b1be:3f13%4]) with mapi id 15.20.9115.020; Wed, 8 Oct 2025
 10:15:01 +0000
From: "Duan, Zhenzhong" <zhenzhong.duan@intel.com>
To: =?iso-8859-1?Q?C=E9dric_Le_Goater?= <clg@redhat.com>,
 "qemu-devel@nongnu.org" <qemu-devel@nongnu.org>
CC: "alex.williamson@redhat.com" <alex.williamson@redhat.com>,
 "eric.auger@redhat.com" <eric.auger@redhat.com>, "mst@redhat.com"
 <mst@redhat.com>, "jasowang@redhat.com" <jasowang@redhat.com>, "Liu, Yi L"
 <yi.l.liu@intel.com>, "clement.mathieu--drif@eviden.com"
 <clement.mathieu--drif@eviden.com>
Subject: RE: [PATCH v2 3/3] pci: Fix wrong parameter passing to
 pci_device_get_iommu_bus_devfn()
Thread-Topic: [PATCH v2 3/3] pci: Fix wrong parameter passing to
 pci_device_get_iommu_bus_devfn()
Thread-Index: AQHcMPMpFqyBZGAvGkmYWOoGpuHXMLSs5leAgAFmflA=
Date: Wed, 8 Oct 2025 10:15:00 +0000
Message-ID: <IA3PR11MB9136D667E09323B8E2DEF17F92E1A@IA3PR11MB9136.namprd11.prod.outlook.com>
References: <20250929034206.439266-1-zhenzhong.duan@intel.com>
 <20250929034206.439266-4-zhenzhong.duan@intel.com>
 <a87df072-82a9-4913-a385-0458c3d0994a@redhat.com>
In-Reply-To: <a87df072-82a9-4913-a385-0458c3d0994a@redhat.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: IA3PR11MB9136:EE_|MW3PR11MB4635:EE_
x-ms-office365-filtering-correlation-id: 09c86e81-75f3-44ae-3bab-08de06538a8e
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0; ARA:13230040|376014|1800799024|366016|38070700021;
x-microsoft-antispam-message-info: =?iso-8859-1?Q?URoVPH1uRQBRYFHfMncr11BSO1MnQlZfORFlVRhYtnRhxqfc5zYdNnuKdu?=
 =?iso-8859-1?Q?Wo0sIu5phdmLt7s6UBwJIes2SllPo3+yjkZZzfZ7ZiKESIiKlbixnAkHpU?=
 =?iso-8859-1?Q?xu+jyE6J1HxulfN8ZYJMSY5mTQi9U4UCqcEvXEzit9YIshd/eLkuyqbCdz?=
 =?iso-8859-1?Q?+SrP8DhbjQR2v9mKtyMSEMmYAOeM2FbwtRjoY2Sl1vy+upapVG2F06wizC?=
 =?iso-8859-1?Q?iW6tTvxcpU9GGMMB9akFCKA9hTCn80Gapg0tFLG8UVOyS5bS+u1OGgTq9V?=
 =?iso-8859-1?Q?+6PU8kBsmOmE6WZewzUPP9Xs/SKn820ilHmk3tUIa0uH4OAuRteaDmz9Cq?=
 =?iso-8859-1?Q?rrxD/Jbbmu4XyjoyQzlQlce0lFtyAwbAbXTZ587PXpe4DHFQtnZD6oRAJa?=
 =?iso-8859-1?Q?vpg/KVnErv1T1kEyiJw511XkquOGjz6LI8KHI0oXeQK0a+KEwCEDNAvJ73?=
 =?iso-8859-1?Q?mQQfA6Z5VsmsNlFUCYbH/n0vMgVZffwNxriOy5l5uwYiIa8ZCjtVTuB678?=
 =?iso-8859-1?Q?c6Xm77JULmh0ONO59cy8gKWJBtbOk52dQiy8XhZ4IJhtPz091kNSKhTQ/s?=
 =?iso-8859-1?Q?+qOQHKPZ5JLPEpElLbfG5fivDLHp8KXaaE63AC2IWkTQCr519QAKs1X2zF?=
 =?iso-8859-1?Q?JTGG/kXgyckGaU+lMbH9mHZ4fXUYIQLH1ktSkLUzRL7+i5MZeNXa5ohpp2?=
 =?iso-8859-1?Q?us6e1s+3LN1YeDAbIS3VYUoi+k8gZZ8NTWIldJsxk4SNlLLAI6i2ikiWHU?=
 =?iso-8859-1?Q?iAzznGtPbcFyOZAIkXZTlzdonO+IdUFiwl6aDGqJVV4fCexqKpj+RYGkbj?=
 =?iso-8859-1?Q?pJ38lA+J9pPxbgL5sam1kagdHWt2FrGizBnFyM1PC7jS08K5G8UDYojX3j?=
 =?iso-8859-1?Q?vQpYY9HASWIOj6LqZUPliAG8OKKvNhbSKjGG1t4Cdh2E3/smA2orhancKv?=
 =?iso-8859-1?Q?syBjkMVVTiNZWZWLIzdBxosmNIBXY3BNSBgKmq2KwoHVYoyJiPTeaXn6kA?=
 =?iso-8859-1?Q?T8oILYYDcKjbbUaUnQQscfMXfE7xOQcrqFdA8SKZZCM8erOY6btm9HGuDW?=
 =?iso-8859-1?Q?DJOA6BiYLkTWA4W8+cj0588e7PYIqHSkbKKed6wBdHp/l2ypGxsEtCrnVm?=
 =?iso-8859-1?Q?nwOGgS1MwQ8HknJnZEfBX7dNvs603Pce687vwJrD6gBgCfHNUVFQgerjin?=
 =?iso-8859-1?Q?QrW/e5QX85wsuqcKaFnXb1aZuDRJSbiWMHqRmScXTxncANsdRfILVxg0Aa?=
 =?iso-8859-1?Q?G++IPHyVS3IuosQO/y7sqMU0ds7yfsH9ZM6GA2OSDtOtThplu50KpqAC7R?=
 =?iso-8859-1?Q?msA4tjmiBxJ9xRDuF2Oqh2CGu+A1WuKS1y978zeGZy2w9Ssh2Y7NBMmD/Y?=
 =?iso-8859-1?Q?yIASUrKwZ4fcmVMgvUqQF3gNh7zcN6ra1+bPu4rbD+2faTWZbzwDP0hZSw?=
 =?iso-8859-1?Q?XyjXi/MdU//i/xlyRD8YBKh94WtS7qB4qCi8PmhcS7vvdTRmI52ULbKBVd?=
 =?iso-8859-1?Q?EkNh2/ilWw16kZxVjsPA69v6anvSpDsT/+vSd6sMio4KwA29ZWm2iqH5m+?=
 =?iso-8859-1?Q?9DXlZ+kfxzMzY/0PUi2w2+TGMU8I?=
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:IA3PR11MB9136.namprd11.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(376014)(1800799024)(366016)(38070700021); DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?iso-8859-1?Q?VmVc1ohnGWeHmx5vsxbLsGdUOKShmzOL4+PuJEuQRCW+8MHScXZ4yvCQDh?=
 =?iso-8859-1?Q?bnWnUAzhpd1wdCVYtapjfgguQjAOcAR+hMcngcb1N9SnkOYU8TugT50r9A?=
 =?iso-8859-1?Q?GfhjQDF9LaeThJPtpnXQTWubbEMYHH2cuoAZgZ3Ay93AVJtVCyAcBDlGRs?=
 =?iso-8859-1?Q?SQwV1wIfCZ5UGkNboGoRV/NOFcH4iNdrS8DqGYjxUdn2pAE8B5zZbYvRCz?=
 =?iso-8859-1?Q?OWeQwbzTiZdSomwO7/eQghQBKGp1+wudMgPLdEUVcEFk2hZqVqoRoLM/jU?=
 =?iso-8859-1?Q?lcTs31bMyzU9XS2pBoVUSlH6eMu999Z9uhaDTSmNHRed1eTMul/x9yaUX6?=
 =?iso-8859-1?Q?nFq8W8Vi1OgbUkWOvq0c4SsuIdksNU5iWnv3u77FsOxGZokjqRckeBQ5e+?=
 =?iso-8859-1?Q?xXvGzdB7fSXPPbLytJQ9j26UmRrCklWqBk0D5MU7QuWJyO1OacgdgUYVVN?=
 =?iso-8859-1?Q?qG+/GHWZ/+Ybd3eQcDSsqCCdc1ulSlgQskbhlXFcfROyqotTrZOmfJc1pm?=
 =?iso-8859-1?Q?0p3O9/5FzvuYihQYQB8DC1yimC2sXGOUnuYbzG9UGzyy74expz1SkuX9yF?=
 =?iso-8859-1?Q?xJ/Xer3uaSAfQNXIPXkYcNkV1D4lp7+EkwIkbpzrSZG4N+j3qOQhgmTABo?=
 =?iso-8859-1?Q?pOR6LcTCNOaPTeI5cc7iKFDzU93IQqgC21pOBgaZcFhUh8/gdBoUF7i7yF?=
 =?iso-8859-1?Q?7686wTG5BfNDX1meeSDJgo/Q8bWrBvti6ls8Qz8d3MWyJg+GdVnXMgGQMm?=
 =?iso-8859-1?Q?vt0mFeh6Wdl91DoS5d4i9Cgv2JtkaT6Y7I0U6opnf8tHSkqODC0KFS1BCK?=
 =?iso-8859-1?Q?nN3rVemkmDkdDMMV2SOacYZAuE2nz6MDt8lAw3iacR+fwZ4k2y2odr78G9?=
 =?iso-8859-1?Q?Z4Uw43NKvOjkSM5sZfIuUwElAS7/fjTMvZM0v+UhZFz4vmxH7GjX2NFrFQ?=
 =?iso-8859-1?Q?k97M4rz1lNKw3vDcv1EtU/tXvtwPk0f0lxXzMZ/zX8r9ezhK/Th/H5Bb9Z?=
 =?iso-8859-1?Q?ufGhzAr0Uq0zBefiI4dzUXaS1Touv/ghKi9lrcHgP28NAROWX1BsBlSUoU?=
 =?iso-8859-1?Q?OXKgD2tI1bfgR8Vhk3TJ9D8hNniksqr2cLILe3v+cYw8OICLgE2/coFFWW?=
 =?iso-8859-1?Q?H4JpIFDSP+I1IJUy1mx9nyV80RCkNDe871QdofESyXAzIoMtBa7mk2Tksd?=
 =?iso-8859-1?Q?bOEigAbqFY17sK9Aa1iBTiYRaCzzHjeT937e8EyuAaEOh48tOatVGtdBt9?=
 =?iso-8859-1?Q?oYFueIYu3+fhqa2V1v5asaxEp7HB/92m799RVvpoJ8CZOheqc30MM+L5Fs?=
 =?iso-8859-1?Q?d9rdote6XxhWINyQVMaCRdX7h2sPCdALBOCUHN4ncxD4LbrQQPCngl8fJw?=
 =?iso-8859-1?Q?Gz6tmPjImeWoZaLy3mY6rioObcFMk7ekWHz68t0VzyMy/CU6GdtqLOeAjY?=
 =?iso-8859-1?Q?tjpu7jc6+MeN2fWQafgRb56lVHps1R/VUgM+jJ1vlLRAxDXdbRqHbDXS0Q?=
 =?iso-8859-1?Q?3p2LcWc3uTZp4fzo0bTOTKikrV/r029HCK0GqV5ZJC+nYin32tCgeEBcg7?=
 =?iso-8859-1?Q?sJOLMf/xRLJavyLKS94j8LW4rFuhQNcoi8HxaGVHGPoGe1QmPnmqbOxMnl?=
 =?iso-8859-1?Q?aH45k7vKNk3VBXNUXwL2Ly7c69FfSmNzJY?=
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: IA3PR11MB9136.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 09c86e81-75f3-44ae-3bab-08de06538a8e
X-MS-Exchange-CrossTenant-originalarrivaltime: 08 Oct 2025 10:15:00.9603 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: Lc4fURR3ISpeJEydYcMsZL1ISxi4EeZ33ZIn+UrSEDvYm2nbOUCFibpjBatGRwze2AXEG7QLe1FzIMO/inJKsgfbLDFrlJFHQa2h+CXtIUo=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MW3PR11MB4635
X-OriginatorOrg: intel.com
Received-SPF: pass client-ip=198.175.65.10;
 envelope-from=zhenzhong.duan@intel.com; helo=mgamail.intel.com
X-Spam_score_int: -47
X-Spam_score: -4.8
X-Spam_bar: ----
X-Spam_report: (-4.8 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.422,
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
>From: C=E9dric Le Goater <clg@redhat.com>
>Subject: Re: [PATCH v2 3/3] pci: Fix wrong parameter passing to
>pci_device_get_iommu_bus_devfn()
>
>On 9/29/25 05:42, Zhenzhong Duan wrote:
>> The 2nd parameter of pci_device_get_iommu_bus_devfn() about root
>PCIBus
>> backed by an IOMMU for the PCI device, the 3rd is about aliased PCIBus
>> of the PCI device.
>>
>> Meanwhile the 3rd and 4th parameters are optional, pass NULL if they
>> are not needed.
>>
>> Signed-off-by: Zhenzhong Duan <zhenzhong.duan@intel.com>
>
>The commit log should mention potential consequences of this change.

Without fix, the callback function may not be called as iommu_ops is set
for iommu_bus rather than bus. Luckily, there is no user of those
functions yet, so no real issue currently.

>
>Will this fix need to be backported ? up to ~9.1

I think no need, Clement could correct me if above explanation is wrong.

Thanks
Zhenzhong

