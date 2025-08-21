Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6F30ECA0EFA
	for <qemu-devel@archiver.kernel.org>; Thu, 21 Aug 2025 08:52:10 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1up118-0005wK-1L; Thu, 21 Aug 2025 04:51:30 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <zhenzhong.duan@intel.com>)
 id 1up10w-0005jH-Ji
 for qemu-devel@nongnu.org; Thu, 21 Aug 2025 04:51:20 -0400
Received: from mgamail.intel.com ([198.175.65.16])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <zhenzhong.duan@intel.com>)
 id 1up10n-0002Dc-1O
 for qemu-devel@nongnu.org; Thu, 21 Aug 2025 04:51:16 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1755766269; x=1787302269;
 h=from:to:cc:subject:date:message-id:references:
 in-reply-to:content-transfer-encoding:mime-version;
 bh=PtB2+w0tisebu7vtfjeG/0W0KQkgUYUpKfsZoPfsqRw=;
 b=Ez8ikQk/VegNAgdI5k9B7XtIkgo6KCx+L+5n4pvyKfxfn+yB5LExePTT
 97rMYgCLTOZfb5B8zQbxuQG8YTM9WQpkKVnrZEISIkWPkynb7mWpYi3uP
 i57LMsthQusm4ehQL1WaiYfQPeQUjikINc7alOH/+2JyQkAeXNJtzCY6R
 5FNgl+9ICoHxXarvgPn+on+QeAPgi5jSBC6qJJ5qCYybWhDUFxt2t55Hr
 XKN+KQ+tEGkjasEFybOZSwc4VdSVWfHFCJDlgqsmCESpUic1m7LbFZhvU
 nQREBx4WxEJrYV6lDx7qbIBTTyPuNBskf3+rJmHVV0dXrrOektLFGoyYu g==;
X-CSE-ConnectionGUID: 1D8rFYe3Ty+b3G4W+16SoQ==
X-CSE-MsgGUID: 8uuFx3K1TCSMyQOgP10vgA==
X-IronPort-AV: E=McAfee;i="6800,10657,11527"; a="58195256"
X-IronPort-AV: E=Sophos;i="6.17,306,1747724400"; d="scan'208";a="58195256"
Received: from fmviesa010.fm.intel.com ([10.60.135.150])
 by orvoesa108.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 21 Aug 2025 01:51:01 -0700
X-CSE-ConnectionGUID: r5dSaoO4SxWqOgiKm0CgQw==
X-CSE-MsgGUID: dnL6UpFbRjKHWIDB+t1oWA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.17,306,1747724400"; d="scan'208";a="169160789"
Received: from fmsmsx903.amr.corp.intel.com ([10.18.126.92])
 by fmviesa010.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 21 Aug 2025 01:51:01 -0700
Received: from FMSMSX901.amr.corp.intel.com (10.18.126.90) by
 fmsmsx903.amr.corp.intel.com (10.18.126.92) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.17; Thu, 21 Aug 2025 01:51:01 -0700
Received: from fmsedg902.ED.cps.intel.com (10.1.192.144) by
 FMSMSX901.amr.corp.intel.com (10.18.126.90) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.17 via Frontend Transport; Thu, 21 Aug 2025 01:51:01 -0700
Received: from NAM02-DM3-obe.outbound.protection.outlook.com (40.107.95.79) by
 edgegateway.intel.com (192.55.55.82) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.17; Thu, 21 Aug 2025 01:51:00 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=ItLSs2Q6pBPvJtePToGRsmf6JE6q9ajqGRnFc2d3NURf466TBU725qcijfy2pH9Q70bM9P72hFLLN3+xwBQ5V4TpBeG0E4/dUwFxcfeY/SrqDIdLG9+/oDXNdpcbVsd1Ok8YZcVH7v1l8Fhy8rYVETh2KV42bg59rjnWJdrQlTHPkXuqZe8Fd/ezINlom5Gc9m2IKCrDoxs74Q2LhC6I9z1pre7i9wvqF/YaWLwecPyjrAVS2WVlcuJl7MD2xJyfI+WEN6w/VTmL6LR/3u5kfL7CetVVmR4T3BV77vqaPIn7XFo2j94j3fsIOLnEVTqXoMmJNaRMD8GqqDn1A9iUYQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=PtB2+w0tisebu7vtfjeG/0W0KQkgUYUpKfsZoPfsqRw=;
 b=WBK/f7KWNvOEabnnKq3h+wHmfERNeIT6RX2XgfureRlK/tf+GEDiMtqFsCJOEDFrxSKvkRb7wxKK23qNK1oOHw7Cp+ieLftBoeZklMrf+zBwV9SYFQpm2Pk20GQDIZUazdGBc2r9GDuOYZoXN/4KlqBsUedStLBEcpDRC/6m/wIyXTIyra3Vm8Zr6oHdt0va2wHXGq+Cx9ASLWz3/R3XV8SqxtsDcFAu3hsYQp8I83XX+YUpd+IozcRKPhW73YGJqpoq+k6SaFGjWbQbiIHIRZpHwCut/XYmVPR+mdcBCw4MaJJ7MnD/v/gvHd/Y679O41oNSvHcTR4uvxokTmNI8w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Received: from IA3PR11MB9136.namprd11.prod.outlook.com (2603:10b6:208:574::12)
 by CH3PR11MB8382.namprd11.prod.outlook.com (2603:10b6:610:173::14)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9052.15; Thu, 21 Aug
 2025 08:50:58 +0000
Received: from IA3PR11MB9136.namprd11.prod.outlook.com
 ([fe80::604b:77a4:b1be:3f13]) by IA3PR11MB9136.namprd11.prod.outlook.com
 ([fe80::604b:77a4:b1be:3f13%4]) with mapi id 15.20.9052.014; Thu, 21 Aug 2025
 08:50:58 +0000
From: "Duan, Zhenzhong" <zhenzhong.duan@intel.com>
To: "Liu, Yi L" <yi.l.liu@intel.com>, "qemu-devel@nongnu.org"
 <qemu-devel@nongnu.org>
CC: "alex.williamson@redhat.com" <alex.williamson@redhat.com>,
 "clg@redhat.com" <clg@redhat.com>, "eric.auger@redhat.com"
 <eric.auger@redhat.com>, "mst@redhat.com" <mst@redhat.com>,
 "jasowang@redhat.com" <jasowang@redhat.com>, "peterx@redhat.com"
 <peterx@redhat.com>, "ddutile@redhat.com" <ddutile@redhat.com>,
 "jgg@nvidia.com" <jgg@nvidia.com>, "nicolinc@nvidia.com"
 <nicolinc@nvidia.com>, "shameerali.kolothum.thodi@huawei.com"
 <shameerali.kolothum.thodi@huawei.com>, "joao.m.martins@oracle.com"
 <joao.m.martins@oracle.com>, "clement.mathieu--drif@eviden.com"
 <clement.mathieu--drif@eviden.com>, "Tian, Kevin" <kevin.tian@intel.com>,
 "Peng, Chao P" <chao.p.peng@intel.com>
Subject: RE: [PATCH v4 00/20] intel_iommu: Enable stage-1 translation for
 passthrough device
Thread-Topic: [PATCH v4 00/20] intel_iommu: Enable stage-1 translation for
 passthrough device
Thread-Index: AQHcAGod+i7KqE+Pt02Tk9KMC5fQ97Rs1sxggAAZoID///7QAA==
Date: Thu, 21 Aug 2025 08:50:58 +0000
Message-ID: <IA3PR11MB913683ADE6EE0BABF0585AF69232A@IA3PR11MB9136.namprd11.prod.outlook.com>
References: <20250729092043.785836-1-zhenzhong.duan@intel.com>
 <DS4PPF93A1BBECD1D6A6FEA7C800E6EDD069232A@DS4PPF93A1BBECD.namprd11.prod.outlook.com>
 <5d3d46b3-ce2d-455a-b8bd-57213f9ea093@intel.com>
In-Reply-To: <5d3d46b3-ce2d-455a-b8bd-57213f9ea093@intel.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: IA3PR11MB9136:EE_|CH3PR11MB8382:EE_
x-ms-office365-filtering-correlation-id: 578bea33-66b1-463f-7c26-08dde08fd900
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
 ARA:13230040|1800799024|366016|376014|7416014|38070700018; 
x-microsoft-antispam-message-info: =?us-ascii?Q?u69Rd4T9s0f7Y7fexDkLfzcF6S/i15nbvszOP+2ToqGaYLi3d3CDqBgKYyv/?=
 =?us-ascii?Q?aj1mpmpLg3ssdtQJ2GrEerMdatYg/GfasOe1OdjNBDe68hLnwhaXO/tNVAbu?=
 =?us-ascii?Q?5jjjpgMxzHn+DGfvI2CvqBaQbqq4yjMLmjsDdgnP2XQ75dESLrc33A0p6CFA?=
 =?us-ascii?Q?hrrxPceAT6TbarhJ28aExRdw/u6OScGuPHkuXe6fkknGKB5pbK3KWWUt14WV?=
 =?us-ascii?Q?98gK9ZDkC7jCO/vYaN9er08W96GbZ/m0dbb4hdvV9RibuY6X+r57mevSBAGk?=
 =?us-ascii?Q?EKfFyPK7UyQOBeuNa3OmP9Mgd/cIR9Crgp+uxHtfwtXRkf99lUC7h27YpYp9?=
 =?us-ascii?Q?eLbht0KBg8g7q30QGW/AjdzKwY5Ii7Tp16F2mKS83HnO7N2ZhQW2MYYkPSjZ?=
 =?us-ascii?Q?L8UW4+JBTMV70XSmH1cTzEaF9JHnex8fliH2kTKV5CR1eeTQj6jwZ1fSuGnW?=
 =?us-ascii?Q?U9XeddrsOGYRKhBQNiv8qxMf7gFcBehiNJTaCCXSpkrlI85fsO2zFnNGZe5u?=
 =?us-ascii?Q?rfDqfIOGS4So3K/LnzUVUzGpFuBGW18Kl1Gum8DEaAU72p6R0/L+/udEMHVQ?=
 =?us-ascii?Q?WLTI+SF4QY8+11M0zHCOo6gH0Pva/iku1Y5IBcBNmbHounjb24TKEhAWVp6Q?=
 =?us-ascii?Q?tBuaghgoJ46lLB9feMUkuxEapl5mMhnFX3P0DkkCEQEkp3Z4um2esoJQb+2C?=
 =?us-ascii?Q?jvn+0iSDqVX5yGLmVWrLy6wrwoMgN8CM4fwlSYWtCTd5mYSiMnqoj3X03Y6j?=
 =?us-ascii?Q?x44PxORqJU/DfCRAq10QcGyRKCzRCwdBuJwzD7k/b6rXvTX9nFfGrtdP0KrG?=
 =?us-ascii?Q?rZwCVApoN129ytwaUaCPQLfX5a/mQaCxJRlpaH1gQ9cyrRoLYRAii8Wevf2W?=
 =?us-ascii?Q?sX4R/N+EqyQja6XNPj//xxxeiNwcLflW1Frij+E+bYMJ3wZXDXX4gj/sWMEI?=
 =?us-ascii?Q?+eAbm+7FEeDoJEqsIRvRS/H3c2g1sUiHqzOl+mYTxZtKVkzqdxvtfOHUiNb1?=
 =?us-ascii?Q?/pA49cCzY7LJ4nfdT2SiiVnbUiwtI/gTCWaA/L5jkEKVsyYnW6v72ACEPyBk?=
 =?us-ascii?Q?MWUi9kLtcLhhqYZ2I1AybJNe8ARQrdAqouQJwbpHxPGEdWCReM6ZRQ2+ABj1?=
 =?us-ascii?Q?lMP7uJB63pMbfg//QyHmtrcwz/R/o89PaLuUQc83PnqgEGLRquOS4aDORmxA?=
 =?us-ascii?Q?H757lTumnkwJ+wF3GHI99l4aHaOq18tXe3uukccd9b/7jZO6dHRmIM4+KVid?=
 =?us-ascii?Q?1K6N5JkhmwZUN4Pq8veiw0upSyVmQk2cT/SqrKUWVVoJTRWNdtDVbtR3biQn?=
 =?us-ascii?Q?e+W/jPq20agOBNM5+UCnlmssAnCwGqIZtQx5zZQQdY0c13ywa8ItjKoJzUsJ?=
 =?us-ascii?Q?+jJ3+h9uDUA10ZcTGu2zrWsYJ9HjOvsxrpLqyR4RtArNzWaLE/ZDLj7HFVnM?=
 =?us-ascii?Q?SjsawworgtlZZUql4OtWh7VGwARmRstg/PrNioDHPTZTt0yn1rVBA4xowL0V?=
 =?us-ascii?Q?g85AmFg17zmVeqI=3D?=
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:IA3PR11MB9136.namprd11.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(1800799024)(366016)(376014)(7416014)(38070700018); DIR:OUT;
 SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?Tj1o/jyRkvVf7A2hUVOH+FUYBsab5v1XB6O4MeXoMYf3NhD/oZeDovSMYOSK?=
 =?us-ascii?Q?YcXZfUPx80LAqUA/YaHYgEKu2nm0dfVOI7ky+FwnP3nIDpPDvhG28vqY4n3g?=
 =?us-ascii?Q?t3NJw+ZxSVr8gs20tqPV12Pcp7I4Ax8T3jqjHbXQpWLwr7taoxGBRiYMUy7L?=
 =?us-ascii?Q?CBBL2CVcOwf8FSJLf+2P0vL1ZFq0AJSALVSzzbRVrUmUY17Kck0QnwCZGDo0?=
 =?us-ascii?Q?C266BS6gVjj96V8ZPA43Kvzc76CFRbxdca9l6u649HfLYhPfYrlByprjLSWq?=
 =?us-ascii?Q?AkVkX60Id4zSNe0U8tb27DFIkZAOk2p81btqEI8wzCiw+YDjfFreyUVFka06?=
 =?us-ascii?Q?Ncp2aXmF2ROkUNefHS6XtRCuKmduY439Itp38+yaD4tdiwYk1dB6VsT/ci3A?=
 =?us-ascii?Q?lZmDfAlxEIjuBU3K1rw/fzQasWWO4ojF49w0APjzADiQLoaakNi2/kKspiEf?=
 =?us-ascii?Q?ZBOHErGHpz6ohvTnlIjz06zR8+pj58bFMxmdZ/SlKNUpODjpytOuJemEaUlG?=
 =?us-ascii?Q?ejIckAUJ58iNR7ayylLeYYT9/iGmt9P0epkMhT6P7L1z/kqpn/y2iZ8lZm00?=
 =?us-ascii?Q?4VYBDafRzWrDvbkowM5lKRM8kPE0VJUCTeeOSkkNpR4uIXQbBYR+ZP+bQ2YR?=
 =?us-ascii?Q?6cCFecEjhOhbRnioOPVgXphxbx9VVKxSwPKmJmohwobpUP1bMjj+YTftoslc?=
 =?us-ascii?Q?C3O3aQ2A+0XcxIo63jAyAL26FfSGheiv+0DEePKLXpLNXlyvXzD7D/6p+lIO?=
 =?us-ascii?Q?SGAsf8DZIVvZ0yxc3dNOMiT4DM/T1DApPNuJ919QRNYYwUZb9ohBcFD8oHvS?=
 =?us-ascii?Q?YbW2fWy6Q5hwY2xpKBs+IqnjiXz/V1SJScKM9E9JZ1nCU14dPXaHZbiX/YdI?=
 =?us-ascii?Q?2OAtQkR40f1TghZNhh7/bjXSM6qKnljvrkCztIxIyFjkDCCzuWbN96aArnHR?=
 =?us-ascii?Q?MkGcljdGpjMcKZoOnJPCxydOgnD3YDB8OWplLKFnLZLc88ZykD6BtFkniIjH?=
 =?us-ascii?Q?WvLP6nml9+NfWuE9/AYW2wfOlqeFqhGsoXqZaUwrLVIn4KWMazT6UAzrLF4S?=
 =?us-ascii?Q?bL1ahyGG1kXPlvbHlvdxWsFLQgNEPn7yRTtnm1CMGmMgrT2JyDMiPXQ1NlMt?=
 =?us-ascii?Q?NIH70eZID8tVvkTurPViRu2oNzh15/3t1EsFhlxDnzHS7JTyCgABdCwT3ASJ?=
 =?us-ascii?Q?HL3deSPOyyZkRgM5oaa7i0hVs7v83sYybIHD3/2SLM8556tQA0qdPo1zFR+C?=
 =?us-ascii?Q?hnV7jRbVtN2n9Yi7EGQA6GZB1isbc/Lsj/h1hA16qKUfxZ6rp3cBJAPXXlsG?=
 =?us-ascii?Q?X0rfhlc7vd+bWhuZIG+rIonL+Z3TWq6d9r9v6AuJtoMDCewubDxthQFdR9oy?=
 =?us-ascii?Q?d9ZS6PIF3/NCv+tQpnacu6q2mK3By90AStaIBildFuVmRbp3YTUGW7pKQvE6?=
 =?us-ascii?Q?GDCWA7qBFkaHUGYinCC8VhNSGeEpAyVaR/UnzdeOE8FNav6mDQIuNUdocF+4?=
 =?us-ascii?Q?gM5awWwOusrVWXG9+88ZSry4tGi7xqtCR6RWVf7sSw5SwcyNUYr3Y9y12Jwx?=
 =?us-ascii?Q?bNoxdqUOVkCP0hlAMO8mHnItLtnWynatKs67kZ9g?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: IA3PR11MB9136.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 578bea33-66b1-463f-7c26-08dde08fd900
X-MS-Exchange-CrossTenant-originalarrivaltime: 21 Aug 2025 08:50:58.1827 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 9tB5LiPjuHSZsn5QXlniXGAToOW/hO0cGwpkNIk1OBf6XwkHmFX3FhaXlnC5b4RsLSHU018zel2z908pW1wUb6XHwjUjeZTg9a2kCJ0s6cw=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH3PR11MB8382
X-OriginatorOrg: intel.com
Received-SPF: pass client-ip=198.175.65.16;
 envelope-from=zhenzhong.duan@intel.com; helo=mgamail.intel.com
X-Spam_score_int: -43
X-Spam_score: -4.4
X-Spam_bar: ----
X-Spam_report: (-4.4 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
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
>From: Liu, Yi L <yi.l.liu@intel.com>
>Subject: Re: [PATCH v4 00/20] intel_iommu: Enable stage-1 translation for
>passthrough device
>
>On 2025/8/21 15:19, Duan, Zhenzhong wrote:
>> Kindly ping, any more comments?
>
>Do you have enough comments for a new version. I plan to have a look
>either this version or a new version next week. :)

That's appreciated, thanks Yi. I think not, there are only a few comments f=
rom Cedric for VFIO related patches.

Zhenzhong

