Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id EB0A1D132B5
	for <qemu-devel@archiver.kernel.org>; Mon,  4 Nov 2024 11:56:20 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1t7vgT-0004bl-Lt; Mon, 04 Nov 2024 06:55:49 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <zhenzhong.duan@intel.com>)
 id 1t7vgS-0004bX-DG
 for qemu-devel@nongnu.org; Mon, 04 Nov 2024 06:55:48 -0500
Received: from mgamail.intel.com ([192.198.163.11])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <zhenzhong.duan@intel.com>)
 id 1t7vgP-0003OI-KJ
 for qemu-devel@nongnu.org; Mon, 04 Nov 2024 06:55:48 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1730721346; x=1762257346;
 h=from:to:cc:subject:date:message-id:references:
 in-reply-to:content-transfer-encoding:mime-version;
 bh=xM7D2lvNnlrzj7K83ex4fjHcTsO1nSV4wLdoQDxI1lE=;
 b=a4+GXRURyybP6N9a1qCA2bqadNkgp+ntq713aB8smY2ChsHR1lzgYSQy
 6job0lPywVcit98IIoACieXaKW4pJoy/zZFraZZv52qxryykowwb9R1/i
 CrustG26t/YJoaUmq39NUTH7DabAtUdCw614fh+lYXBFYUmKy8QTEYw2O
 gKa5c+2fliwjDeJfJYVdDnc3gES1qNsVLi0+Om8g9w4H/Dargx4A7jKZP
 mRCodiCF24V4AJlhSf1sKn+dOzjkv2231jlpM8NxziInaJSXzH8gEkuUO
 uvRp0BjqMpOaXNGsqUjhBBl+XIdGnvRmZhrohuufIcn47fIOGyE/wVMUH A==;
X-CSE-ConnectionGUID: L7NeDvQQT52fFJeQEinCcA==
X-CSE-MsgGUID: Z9DDF+lsTTS0DZUHvKCP5w==
X-IronPort-AV: E=McAfee;i="6700,10204,11245"; a="40996616"
X-IronPort-AV: E=Sophos;i="6.11,256,1725346800"; d="scan'208";a="40996616"
Received: from orviesa002.jf.intel.com ([10.64.159.142])
 by fmvoesa105.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 04 Nov 2024 03:55:43 -0800
X-CSE-ConnectionGUID: ZMjJT2CrQ/qvMynVh9zx0A==
X-CSE-MsgGUID: SDAXfDp0QzKRZCBeyPXXOA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.11,257,1725346800"; d="scan'208";a="114421572"
Received: from orsmsx601.amr.corp.intel.com ([10.22.229.14])
 by orviesa002.jf.intel.com with ESMTP/TLS/AES256-GCM-SHA384;
 04 Nov 2024 03:55:43 -0800
Received: from orsmsx601.amr.corp.intel.com (10.22.229.14) by
 ORSMSX601.amr.corp.intel.com (10.22.229.14) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.39; Mon, 4 Nov 2024 03:55:42 -0800
Received: from ORSEDG601.ED.cps.intel.com (10.7.248.6) by
 orsmsx601.amr.corp.intel.com (10.22.229.14) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.39 via Frontend Transport; Mon, 4 Nov 2024 03:55:42 -0800
Received: from NAM11-CO1-obe.outbound.protection.outlook.com (104.47.56.169)
 by edgegateway.intel.com (134.134.137.102) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.39; Mon, 4 Nov 2024 03:55:42 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=YbDcralCwHfW/Z/waPGpiGfl48tNgTyQanfFcCkHXFsWmxX9n5ey3vGw2s0N8u7dojsfWt1V/Niv5BeE0EGzlxmpSySOtFfRv8TziCj93wazYpsLu8Huy+X7/XCMrUtwjFOEGzxOS9VvMYKIQT4YzNRDdLnVkvJI58Qk9dRxRofZS2XkFuki3NX5/bG0CphfULMBqw2PV07fBmZvst0VZ8N8sX18wD0YqWPrtKrcvRRHfJQ6/Nu3OZgelHtGvL11n4RYLu7FWbHKRZTeQdwqdHu1aDpgGrgpzdO9NBs5EHicgCdGt2hcQBtKMA2/WmAaO/GYNP5bfll+P0nmuA1WsQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=inJhXqwETR6/ur0urtPgSTkkb8RZ35YcBkTQnkzsAvQ=;
 b=nSCsV7XPS31mp4r2stqWixZJ4E9hdDEWjzhna1FSzgB0tkgGBf9SQ+XjqbCPyodzbZsW1d+9uAptGOpZNSOXCUZdYdo5/fOzNuqQTN4iwixxdWqt1qYGdqHG5yAsrfG6XD35Gay+H9mirYtVGxUBbq/nOMkagwxn0KZPqUBJChAU0jbY6rzSHQAPOa8mfuWdHVYpWVmeP+gNL256y9m/O3jrTDP1C9W3s9CQyEDPAfk5rnLNyEs7jv5R0M69BGQBDZFJEWQaXP3dYGtPY7FE7mx5OOb9MHiqv6cAtHZxGpjtGZZPrWTco1bjdusx5Ol1Q097+aWMk17N5iuR22OZQQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Received: from SJ0PR11MB6744.namprd11.prod.outlook.com (2603:10b6:a03:47d::10)
 by LV3PR11MB8458.namprd11.prod.outlook.com (2603:10b6:408:1bb::20)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8114.29; Mon, 4 Nov
 2024 11:55:40 +0000
Received: from SJ0PR11MB6744.namprd11.prod.outlook.com
 ([fe80::fe49:d628:48b1:6091]) by SJ0PR11MB6744.namprd11.prod.outlook.com
 ([fe80::fe49:d628:48b1:6091%5]) with mapi id 15.20.8114.028; Mon, 4 Nov 2024
 11:55:40 +0000
From: "Duan, Zhenzhong" <zhenzhong.duan@intel.com>
To: "Michael S. Tsirkin" <mst@redhat.com>
CC: "Liu, Yi L" <yi.l.liu@intel.com>, CLEMENT MATHIEU--DRIF
 <clement.mathieu--drif@eviden.com>, "qemu-devel@nongnu.org"
 <qemu-devel@nongnu.org>, "alex.williamson@redhat.com"
 <alex.williamson@redhat.com>, "clg@redhat.com" <clg@redhat.com>,
 "eric.auger@redhat.com" <eric.auger@redhat.com>, "peterx@redhat.com"
 <peterx@redhat.com>, "jasowang@redhat.com" <jasowang@redhat.com>,
 "jgg@nvidia.com" <jgg@nvidia.com>, "nicolinc@nvidia.com"
 <nicolinc@nvidia.com>, "joao.m.martins@oracle.com"
 <joao.m.martins@oracle.com>, "Tian, Kevin" <kevin.tian@intel.com>, "Peng,
 Chao P" <chao.p.peng@intel.com>, Paolo Bonzini <pbonzini@redhat.com>, Richard
 Henderson <richard.henderson@linaro.org>, Eduardo Habkost
 <eduardo@habkost.net>, Marcel Apfelbaum <marcel.apfelbaum@gmail.com>
Subject: RE: [PATCH v4 04/17] intel_iommu: Flush stage-2 cache in
 PASID-selective PASID-based iotlb invalidation
Thread-Topic: [PATCH v4 04/17] intel_iommu: Flush stage-2 cache in
 PASID-selective PASID-based iotlb invalidation
Thread-Index: AQHbExtWwxmDUGznNEuh9QEgt9JZFbKmoiIAgABQaICAABLpAIAAMdxwgAACCQCAAABSIA==
Date: Mon, 4 Nov 2024 11:55:39 +0000
Message-ID: <SJ0PR11MB6744765C7F68ABF7449E73F492512@SJ0PR11MB6744.namprd11.prod.outlook.com>
References: <20240930092631.2997543-1-zhenzhong.duan@intel.com>
 <20240930092631.2997543-5-zhenzhong.duan@intel.com>
 <3bb9da3b-f1de-4a3a-bdd8-37937ed15d50@intel.com>
 <14799ff1-8da4-4b42-921a-ad1198de1bdb@eviden.com>
 <119078eb-81f0-47a7-81b0-aaf6b7878581@intel.com>
 <SJ0PR11MB674422638A5915D608E9A80992512@SJ0PR11MB6744.namprd11.prod.outlook.com>
 <20241104065029-mutt-send-email-mst@kernel.org>
In-Reply-To: <20241104065029-mutt-send-email-mst@kernel.org>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: SJ0PR11MB6744:EE_|LV3PR11MB8458:EE_
x-ms-office365-filtering-correlation-id: c40eb793-7239-44ff-c178-08dcfcc79a7b
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
 ARA:13230040|7416014|376014|366016|1800799024|38070700018; 
x-microsoft-antispam-message-info: =?iso-8859-1?Q?HpQ8j4YWCJMR7UbTR4YqM06hTCDtyGVP0TFMv8z6t/uPBdhoTYpB4RPC0a?=
 =?iso-8859-1?Q?Oj1UpJ+QO3mWgEQYwRZv26EsIvz7BKScxvpXd2mNkwJuX+DjlINpvez8p0?=
 =?iso-8859-1?Q?oSFgsGOCNYdw/xo5WclZA7ct1r/P7P/S/Ly94pNJfgn68UtaX1aNgsidmt?=
 =?iso-8859-1?Q?vJrMC8IMaoZnrjEUc517iBZi3/MiFMmRFy3HpKP7dSC1awDoTs2PecFNSv?=
 =?iso-8859-1?Q?Q3/muFAL9gfCoYkX95oP/8LxiEBoSBCyLP+mnr+4F8tccvcD8PlFQJYXVS?=
 =?iso-8859-1?Q?YSntbstKqtCk9RujRGoIfucRqF6GE0TtBx1ewIFvAB+voJ1u/JOd0mxkJu?=
 =?iso-8859-1?Q?PCkHThWlCggeb8XwSc2LuKxf0NPTol418IItFBBBX3ZyHCSY+Jr2qa9Ra9?=
 =?iso-8859-1?Q?NKce7hZrfVcexhz23JdBSaKAOYUMq8KbbrGXl0xKrflNckFZgz0Da7LyT7?=
 =?iso-8859-1?Q?yBYMjH8pAvWA9p//hNzqlQTTV4ld1eT08dIx/41vzygQIXIlhbhklP3TQS?=
 =?iso-8859-1?Q?2Imi43ZriwCF+8ccZfWT+BlG//PQa0n0gafv6czgapFGEUXwH3PrA9TSv9?=
 =?iso-8859-1?Q?4JyWuamo6ilkZMDAAeXxHs/d07FMHTt3+T5/vp0C3x905dI6ghT0ZQrPqk?=
 =?iso-8859-1?Q?7Tkxp364vFHq4wdgxr/ZwSnB98DxNTm1hR1PsiNa5HD7usOAvni9C+ctK4?=
 =?iso-8859-1?Q?nEubJWaDsj95fKdIhnyOUDZQ7MQAP34ATZPgIjff3z4wi6/7goJOknB+y+?=
 =?iso-8859-1?Q?hfY61nPKX0Iv4b9WOwZrrO1/yXrZCRTdWVUq9iRxon8f5QOdQJnOCm0KGV?=
 =?iso-8859-1?Q?zn2ig0v/gur+2UKnRvVxmIl19A2SmcFz8ZvUDH6FOFr1onWhhsq8YwgOrM?=
 =?iso-8859-1?Q?SxyiILKLFGstZoQgXF8wAe9oEKy1L/RX6vxEwU6KxfqsQtPD5YKF6e98LE?=
 =?iso-8859-1?Q?ubEsxGfDbtwgR0Vzk11O2MmB/jqQhNfMbfW6ohZP+MCFi9KMTOnaAg8DyM?=
 =?iso-8859-1?Q?4p6Gt7Schjje1q8daif6H1hMNFjdLQrkUl4YYBN7D8sO4IjERCdkIQXPW8?=
 =?iso-8859-1?Q?DgEIgdzZMhZ9NJoXci5Qd/BsByA0U65CRePtXOfFVQ13dMgHgx0Y62/4IY?=
 =?iso-8859-1?Q?vRC6LFgmhj8ikI7T5R+PfnHqJbzl1aRGIyyw8Lj0fAdscmX5dbO4f0Mxf6?=
 =?iso-8859-1?Q?gPSTnbaQgkYqVWO99kHiwqA9eBbxU7xHWYHIM7UK3v1DL5Zygj8yo2l/yV?=
 =?iso-8859-1?Q?limSbRhYFTkedrwyR5lWdaOTfPSpjnXXVoFtgaepWMb+H7l65kAV2MWlOx?=
 =?iso-8859-1?Q?rEj0v3Wk7PL+uJL54FwJaDmFQwm5sk2Ez6mC3aIsX4hjVU+F3DLCcRsAA+?=
 =?iso-8859-1?Q?EYNR9/CX1xZsnYVRJZMgvOFMZwxXS3AadtUNS1nopWhiQ/QvWDl8M=3D?=
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:SJ0PR11MB6744.namprd11.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(7416014)(376014)(366016)(1800799024)(38070700018); DIR:OUT;
 SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?iso-8859-1?Q?k8c+mPRV2L4BMAvwiI8SvQWXVuTC5jijATVMUD+SsaqYA4NzLKxYiDady5?=
 =?iso-8859-1?Q?uEkcSTAaAHHrrGsfaRxbdyoyeJFCKr8C06OjPFiCMZLO21Kn1tUrnwiN8n?=
 =?iso-8859-1?Q?QuDwduq/4bT/4rsTiKvtFqlF/h+GUciCoNzAVWP9prTtHMrmJuZ6sCTsO+?=
 =?iso-8859-1?Q?lUb3PEn1UYYlFepT/+9OF5IMHui6To6amnzXSXcuQzf0eXQbYDUfOZNGBL?=
 =?iso-8859-1?Q?QL5McAtBq9KZ297tkoZLU3BmsyysJ6c2fAca5SMX3p7u1t5BN6Ly1txGlp?=
 =?iso-8859-1?Q?Mu0nn61rtzjfve+eGSKy5cAk3kBFmXPcRFVQeXlGhFi0CzqtODSIpcSE7C?=
 =?iso-8859-1?Q?Bg63ekZA2Vye2jde4bHy152zV2LsinL6VjnZwjz0BYQihz/ApQD9biT5Lg?=
 =?iso-8859-1?Q?AYvYRYyNL7MXKSujzTX0PNgemmJlirSVk2yLp8z96joksEclz59ZDDVGGU?=
 =?iso-8859-1?Q?1CkAXBinKK/kri3eL7FnWVxkDNshOjRDCmKk/Yzhu940hDIZ+vHdCrT85M?=
 =?iso-8859-1?Q?qZ0SGv1d7278AggVw4AuYzaQLEeYR6RUI0QKWL1N8HTsmiXmEiLshD6m1b?=
 =?iso-8859-1?Q?q2GEZCxugc6AIVAS0DsaCt5SBkOIz6cV1STWqh6A0MKyn5yIAUgK7WBDfl?=
 =?iso-8859-1?Q?tkAOOtL/hcHxtTh/9Vj+VLbXNr3IF5AbJnxzvQ8g6xIXaEpbZhFI5F4IKF?=
 =?iso-8859-1?Q?l6lOZfhY5agV1bj7pYWongBqMJL1ZbAxb5rEFkC+f7GOJjPDu4AOsawi2f?=
 =?iso-8859-1?Q?kEzSDCmoS0wob+MZlWAoFUDjQKjWGxcknvqamXYCSLlkuf39RtyF1R59dh?=
 =?iso-8859-1?Q?FHOW9KSVn7Mwk4RyNKwTaM/jLOhEYtNIvHSDR/ap0KdOYvZn8qflpxoT1a?=
 =?iso-8859-1?Q?FzNTyX5NuRVjOUQ09QLg9YRUu9TPJ1J6jVp+aV3OWigjDlHlC4B1eDkWgQ?=
 =?iso-8859-1?Q?BtLR5mDBM2A3YPEZUlvt6/1M2go4bgnqs/MPj/V+kL5wFjvRXHlmKUR/KE?=
 =?iso-8859-1?Q?JUoQQqhxGv/F8UZzDOJH5FtNi2avJ8E4W+gGymIqfLOVg02ONmJuWyJYW2?=
 =?iso-8859-1?Q?WFr+JkTF0JcG2fszxORF9eaagNgvJqdfrlsLoql6SfHd1h4mugLOpj4JEm?=
 =?iso-8859-1?Q?eonMjz8jxyW0KJYlJhgVTt7K2SmWzyeYDRkhRFeDYyA6FBbmVlROSZluZd?=
 =?iso-8859-1?Q?57EPCc3edMQ5fZ7M04NHAJcPTpsgfdkqM9C4bm1B/VeFuw+FzmCV/Ver1r?=
 =?iso-8859-1?Q?yCeMg2BphRYxTrXen9zkOpFqkDsQGJop4adJYVvYUL6RxE6eFBCi3X1p0s?=
 =?iso-8859-1?Q?/CYJHAauyYazLH+poHa6grEdRcc/qLpU4zETuEdus9mQ7SPPw7mPR7TB51?=
 =?iso-8859-1?Q?pDNx6JXvis78Z3HnAGXSzHb8tizXx3crB7HyUUzwgy8R8BHN1BfpH0k1Tw?=
 =?iso-8859-1?Q?MLP3HZLFRzj54elnscYFw/m9yNszNd3Yl6GqHFzHgG+pjGZ5h1W/Rxf/CK?=
 =?iso-8859-1?Q?sUvqbI4aakZEHayCodzbQnR0WM7lTtIbIU+owAh87KoYkXKMyjh2hCS2kq?=
 =?iso-8859-1?Q?DkWuabie0IHbf8Exu66TrABFaDbFHzaGXE4FI9GpY0v/d34Aa+2iRwddvK?=
 =?iso-8859-1?Q?ioq9FhIdUL1T1Slqc5CvMsow8E4y16RQWw?=
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: SJ0PR11MB6744.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: c40eb793-7239-44ff-c178-08dcfcc79a7b
X-MS-Exchange-CrossTenant-originalarrivaltime: 04 Nov 2024 11:55:39.9735 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: hfT8O3rweGVvgqs9h8GzFfyQSaHsqgWlgXSTsJA77fBMmLAu38TDO3aoHwGho2J+NxNCXFgs06HJgg/TMrWMZKUrwD55a7U2xJk5afOvz0c=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: LV3PR11MB8458
X-OriginatorOrg: intel.com
Received-SPF: pass client-ip=192.198.163.11;
 envelope-from=zhenzhong.duan@intel.com; helo=mgamail.intel.com
X-Spam_score_int: -46
X-Spam_score: -4.7
X-Spam_bar: ----
X-Spam_report: (-4.7 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.34,
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
>From: Michael S. Tsirkin <mst@redhat.com>
>Sent: Monday, November 4, 2024 7:51 PM
>Subject: Re: [PATCH v4 04/17] intel_iommu: Flush stage-2 cache in PASID-
>selective PASID-based iotlb invalidation
>
>On Mon, Nov 04, 2024 at 11:46:00AM +0000, Duan, Zhenzhong wrote:
>>
>>
>> >-----Original Message-----
>> >From: Liu, Yi L <yi.l.liu@intel.com>
>> >Sent: Monday, November 4, 2024 4:45 PM
>> >Subject: Re: [PATCH v4 04/17] intel_iommu: Flush stage-2 cache in PASID=
-
>> >selective PASID-based iotlb invalidation
>> >
>> >On 2024/11/4 15:37, CLEMENT MATHIEU--DRIF wrote:
>> >>
>> >>
>> >> On 04/11/2024 03:49, Yi Liu wrote:
>> >>> Caution: External email. Do not open attachments or click links, unl=
ess
>> >>> this email comes from a known sender and you know the content is saf=
e.
>> >>>
>> >>>
>> >>> On 2024/9/30 17:26, Zhenzhong Duan wrote:
>> >>>> Per spec 6.5.2.4, PADID-selective PASID-based iotlb invalidation wi=
ll
>> >>>> flush stage-2 iotlb entries with matching domain id and pasid.
>> >>>
>> >>> Also, call out it's per table Table 21. PASID-based-IOTLB Invalidati=
on of
>> >>> VT-d spec 4.1.
>> >>>
>> >>>> With scalable modern mode introduced, guest could send PASID-select=
ive
>> >>>> PASID-based iotlb invalidation to flush both stage-1 and stage-2 en=
tries.
>> >>>>
>> >>>> By this chance, remove old IOTLB related definitions which were unu=
sed.
>> >>>
>> >>>
>> >>>> Signed-off-by: Zhenzhong Duan <zhenzhong.duan@intel.com>
>> >>>> Reviewed-by: Cl=E9ment Mathieu--Drif<clement.mathieu--drif@eviden.c=
om>
>> >>>> Acked-by: Jason Wang <jasowang@redhat.com>
>> >>>> ---
>> >>>>  =A0 hw/i386/intel_iommu_internal.h | 14 ++++--
>> >>>>  =A0 hw/i386/intel_iommu.c=A0=A0=A0=A0=A0=A0=A0=A0=A0 | 88
>+++++++++++++++++++++++++++++++++-
>> >>>>  =A0 2 files changed, 96 insertions(+), 6 deletions(-)
>> >>>>
>> >>>> diff --git a/hw/i386/intel_iommu_internal.h b/hw/i386/
>> >>>> intel_iommu_internal.h
>> >>>> index d0f9d4589d..eec8090190 100644
>> >>>> --- a/hw/i386/intel_iommu_internal.h
>> >>>> +++ b/hw/i386/intel_iommu_internal.h
>> >>>> @@ -403,11 +403,6 @@ typedef union VTDInvDesc VTDInvDesc;
>> >>>>  =A0 #define VTD_INV_DESC_IOTLB_AM(val)=A0=A0=A0=A0=A0 ((val) & 0x3=
fULL)
>> >>>>  =A0 #define VTD_INV_DESC_IOTLB_RSVD_LO=A0=A0=A0=A0=A0 0xffffffff00=
00f100ULL
>> >>>>  =A0 #define VTD_INV_DESC_IOTLB_RSVD_HI=A0=A0=A0=A0=A0 0xf80ULL
>> >>>> -#define VTD_INV_DESC_IOTLB_PASID_PASID=A0 (2ULL << 4)
>> >>>> -#define VTD_INV_DESC_IOTLB_PASID_PAGE=A0=A0 (3ULL << 4)
>> >>>> -#define VTD_INV_DESC_IOTLB_PASID(val)=A0=A0 (((val) >> 32) &
>> >>>> VTD_PASID_ID_MASK)
>> >>>> -#define
>VTD_INV_DESC_IOTLB_PASID_RSVD_LO=A0=A0=A0=A0=A0 0xfff00000000001c0ULL
>> >>>> -#define VTD_INV_DESC_IOTLB_PASID_RSVD_HI=A0=A0=A0=A0=A0 0xf80ULL
>> >>>>
>> >>>>  =A0 /* Mask for Device IOTLB Invalidate Descriptor */
>> >>>>  =A0 #define VTD_INV_DESC_DEVICE_IOTLB_ADDR(val) ((val) &
>> >>>> 0xfffffffffffff000ULL)
>> >>>> @@ -433,6 +428,15 @@ typedef union VTDInvDesc VTDInvDesc;
>> >>>>  =A0 #define VTD_SPTE_LPAGE_L3_RSVD_MASK(aw) \
>> >>>>  =A0=A0=A0=A0=A0=A0=A0=A0=A0 (0x3ffff800ULL | ~(VTD_HAW_MASK(aw) | =
VTD_SL_IGN_COM))
>> >>>>
>> >>>> +/* Masks for PIOTLB Invalidate Descriptor */
>> >>>> +#define VTD_INV_DESC_PIOTLB_G=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 =
(3ULL << 4)
>> >>>> +#define VTD_INV_DESC_PIOTLB_ALL_IN_PASID=A0 (2ULL << 4)
>> >>>> +#define VTD_INV_DESC_PIOTLB_PSI_IN_PASID=A0 (3ULL << 4)
>> >>>> +#define VTD_INV_DESC_PIOTLB_DID(val)=A0=A0=A0=A0=A0 (((val) >> 16)=
 &
>> >>>> VTD_DOMAIN_ID_MASK)
>> >>>> +#define VTD_INV_DESC_PIOTLB_PASID(val)=A0=A0=A0 (((val) >> 32) & 0=
xfffffULL)
>> >>>> +#define VTD_INV_DESC_PIOTLB_RSVD_VAL0=A0=A0=A0=A0 0xfff000000000f1=
c0ULL
>> >>>> +#define VTD_INV_DESC_PIOTLB_RSVD_VAL1=A0=A0=A0=A0 0xf80ULL
>> >>>> +
>> >>>>  =A0 /* Information about page-selective IOTLB invalidate */
>> >>>>  =A0 struct VTDIOTLBPageInvInfo {
>> >>>>  =A0=A0=A0=A0=A0 uint16_t domain_id;
>> >>>> diff --git a/hw/i386/intel_iommu.c b/hw/i386/intel_iommu.c
>> >>>> index 9e6ef0cb99..72c9c91d4f 100644
>> >>>> --- a/hw/i386/intel_iommu.c
>> >>>> +++ b/hw/i386/intel_iommu.c
>> >>>> @@ -2656,6 +2656,86 @@ static bool
>> >>>> vtd_process_iotlb_desc(IntelIOMMUState *s, VTDInvDesc *inv_desc)
>> >>>>  =A0=A0=A0=A0=A0 return true;
>> >>>>  =A0 }
>> >>>>
>> >>>> +static gboolean vtd_hash_remove_by_pasid(gpointer key, gpointer va=
lue,
>> >>>> +=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=
=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 gpointer user_data)
>> >>>> +{
>> >>>> +=A0=A0=A0 VTDIOTLBEntry *entry =3D (VTDIOTLBEntry *)value;
>> >>>> +=A0=A0=A0 VTDIOTLBPageInvInfo *info =3D (VTDIOTLBPageInvInfo *)use=
r_data;
>> >>>> +
>> >>>> +=A0=A0=A0 return ((entry->domain_id =3D=3D info->domain_id) &&
>> >>>> +=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 (entry->pasid =3D=3D info->pasid=
));
>> >>>> +}
>> >>>> +
>> >>>> +static void vtd_piotlb_pasid_invalidate(IntelIOMMUState *s,
>> >>>> +=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=
=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 uint16_t domain_id, uin=
t32_t
>> >>>> pasid)
>> >>>> +{
>> >>>> +=A0=A0=A0 VTDIOTLBPageInvInfo info;
>> >>>> +=A0=A0=A0 VTDAddressSpace *vtd_as;
>> >>>> +=A0=A0=A0 VTDContextEntry ce;
>> >>>> +
>> >>>> +=A0=A0=A0 info.domain_id =3D domain_id;
>> >>>> +=A0=A0=A0 info.pasid =3D pasid;
>> >>>> +
>> >>>> +=A0=A0=A0 vtd_iommu_lock(s);
>> >>>> +=A0=A0=A0 g_hash_table_foreach_remove(s->iotlb, vtd_hash_remove_by=
_pasid,
>> >>>> +=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=
=A0=A0=A0=A0=A0=A0=A0=A0=A0 &info);
>> >>>> +=A0=A0=A0 vtd_iommu_unlock(s);
>> >>>> +
>> >>>> +=A0=A0=A0 QLIST_FOREACH(vtd_as, &s->vtd_as_with_notifiers, next) {
>> >>>> +=A0=A0=A0=A0=A0=A0=A0 if (!vtd_dev_to_context_entry(s, pci_bus_num=
(vtd_as->bus),
>> >>>> +=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=
=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 vtd_as->devfn, &ce) &&
>> >>>> +=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 domain_id =3D=3D vtd_get_domain_=
id(s, &ce, vtd_as->pasid)) {
>> >>>> +=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 uint32_t rid2pasid =3D VTD_CE_GE=
T_RID2PASID(&ce);
>> >>>> +
>> >>>> +=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 if ((vtd_as->pasid !=3D PCI_NO_P=
ASID || pasid !=3D rid2pasid) &&
>> >>>> +=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 vtd_as->pasid !=3D p=
asid) {
>> >>>> +=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 continue;
>> >>>> +=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 }
>> >>>> +
>> >>>> +=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 if (!s->scalable_modern) {
>> >>>> +=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 vtd_address_space_sy=
nc(vtd_as);
>> >>>> +=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 }
>> >>>> +=A0=A0=A0=A0=A0=A0=A0 }
>> >>>> +=A0=A0=A0 }
>> >>>> +}
>> >>>> +
>> >>>> +static bool vtd_process_piotlb_desc(IntelIOMMUState *s,
>> >>>> +=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=
=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 VTDInvDesc *inv_desc)
>> >>>> +{
>> >>>> +=A0=A0=A0 uint16_t domain_id;
>> >>>> +=A0=A0=A0 uint32_t pasid;
>> >>>> +
>> >>>> +=A0=A0=A0 if ((inv_desc->val[0] & VTD_INV_DESC_PIOTLB_RSVD_VAL0) |=
|
>> >>>> +=A0=A0=A0=A0=A0=A0=A0 (inv_desc->val[1] & VTD_INV_DESC_PIOTLB_RSVD=
_VAL1) ||
>> >>>> +=A0=A0=A0=A0=A0=A0=A0 inv_desc->val[2] || inv_desc->val[3]) {
>> >>>> +=A0=A0=A0=A0=A0=A0=A0 error_report_once("%s: invalid piotlb inv de=
sc val[3]=3D0x%"PRIx64
>> >>>> +=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=
=A0=A0=A0 " val[2]=3D0x%"PRIx64" val[1]=3D0x%"PRIx64
>> >>>> +=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=
=A0=A0=A0 " val[0]=3D0x%"PRIx64" (reserved bits unzero)",
>> >>>> +=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=
=A0=A0=A0 __func__, inv_desc->val[3], inv_desc->val[2],
>> >>>> +=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=
=A0=A0=A0 inv_desc->val[1], inv_desc->val[0]);
>> >>>> +=A0=A0=A0=A0=A0=A0=A0 return false;
>> >>>> +=A0=A0=A0 }
>> >>>
>> >>> Need to consider the below behaviour as well.
>> >>>
>> >>> "
>> >>> This
>> >>> descriptor is a 256-bit descriptor and will result in an invalid des=
criptor
>> >>> error if submitted in an IQ that
>> >>> is setup to provide hardware with 128-bit descriptors (IQA_REG.DW=3D=
0)
>> >>> "
>> >>>
>> >>> Also there are descriptions about the old inv desc types (e.g.
>> >>> iotlb_inv_desc) that can be either 128bits or 256bits.
>> >>>
>> >>> "If a 128-bit
>> >>> version of this descriptor is submitted into an IQ that is setup to =
provide
>> >>> hardware with 256-bit
>> >>> descriptors or vice-versa it will result in an invalid descriptor er=
ror.
>> >>> "
>> >>>
>> >>> If DW=3D=3D1, vIOMMU fetches 32 bytes per desc. In such case, if the=
 guest
>> >>> submits 128bits desc, then the high 128bits would be non-zero if the=
re is
>> >>> more than one desc. But if there is only one desc in the queue, then=
 the
>> >>> high 128bits would be zero as well. While, it may be captured by the
>> >>> tail register update. Bit4 is reserved when DW=3D=3D1, and guest wou=
ld use
>> >>> bit4 when it only submits one desc.
>> >>>
>> >>> If DW=3D=3D0, vIOMMU fetchs 16bytes per desc. If guest submits 256bi=
ts desc,
>> >>> it would appear to be two descs from vIOMMU p.o.v. The first 128bits
>> >>> can be identified as valid except for the types that does not requir=
es
>> >>> 256bits. The higher 128bits would be subjected to the desc sanity ch=
eck
>> >>> as well.
>> >>>
>> >>> Based on the above, I think you may need to add two more checks. If
>DW=3D=3D0,
>> >>> vIOMMU should fail the inv types that requires 256bits; If DW=3D=3D1=
, you
>> >>> should check the inv_desc->val[2] and inv_desc->val[3]. You've alrea=
dy
>> >>> done it in this patch.
>> >>>
>> >>> Thoughts are welcomed here.
>> >>
>> >> Good catch,
>> >> I think we should write the check in vtd_process_inv_desc
>> >> rather than updating the handlers.
>> >>
>> >> What are your thoughts?
>> >
>> >the first check can be done in vtd_process_inv_desc(). The second may
>> >be better in the handlers as the handlers have the reserved bits check.
>> >But given that none of the inv types use the high 128bits, so it is als=
o
>> >acceptable to do it in vtd_process_inv_desc(). Do add proper comment.
>>
>> Thanks Yi and Clement's suggestion, I'll send a small series to fix that
>> for upstream.
>>
>> BRs.
>> Zhenzhong
>
>Ok so you will send v5?

No, what Yi pointed out is an upstream issue, I'll send a small series(3 pa=
tches)
to fix that issue for upstream.

Thanks
Zhenzhong

