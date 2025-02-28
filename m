Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B52D0C19776
	for <qemu-devel@archiver.kernel.org>; Fri, 28 Feb 2025 05:40:32 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tnt6D-0003qL-0D; Fri, 28 Feb 2025 00:39:49 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <zhenzhong.duan@intel.com>)
 id 1tnt67-0003pu-BI
 for qemu-devel@nongnu.org; Fri, 28 Feb 2025 00:39:44 -0500
Received: from mgamail.intel.com ([198.175.65.12])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <zhenzhong.duan@intel.com>)
 id 1tnt65-0007XR-Bs
 for qemu-devel@nongnu.org; Fri, 28 Feb 2025 00:39:43 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1740721182; x=1772257182;
 h=from:to:cc:subject:date:message-id:references:
 in-reply-to:content-transfer-encoding:mime-version;
 bh=MdWS+mqQ+a9ZgYM8EYXVvGiyAXcTmowZpvAKyEb8kqU=;
 b=fZQzACwGShEaunZ4NItg/TW/PpsofD0qyfjb3ioynERBAj5ZAcQ2Cc8B
 pQCobZtqqXxdBN83hjAQvOSGkkF/33+Iv/uhjuMt4qAhJiIbMawFl9CJU
 QyEyU+qfb8AzoFa1+sV/ZX9Dz7pZrUla64yfRXAkoCRSuoZtKFwHzNKaS
 jtPXTO6WPGR5+sL+mrUfgbJQZIAAIWdSikXHi7VyLPj5CaW1cC9BtuMvv
 BgW4b6A1oLkuqwfgdqJT8sLtGR2mVJ/qmo7Dv1N4eGxON8MKPLQj3E2sz
 fQWthwxJkOZJE044m+JcFfoUPlOUQEZQBr3DAOmuRZgWzzDTUp/Oh1+px Q==;
X-CSE-ConnectionGUID: DJ05fYVuSX61jVNWKAtNpg==
X-CSE-MsgGUID: qScs34SZQOOuKc9tDsA3dg==
X-IronPort-AV: E=McAfee;i="6700,10204,11358"; a="53031630"
X-IronPort-AV: E=Sophos;i="6.13,321,1732608000"; d="scan'208";a="53031630"
Received: from orviesa008.jf.intel.com ([10.64.159.148])
 by orvoesa104.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 27 Feb 2025 21:39:38 -0800
X-CSE-ConnectionGUID: 5akScpNVS5KLQJJVq9hGrQ==
X-CSE-MsgGUID: NZiONyVvQmqnnOU2I07zig==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.12,224,1728975600"; d="scan'208";a="118170181"
Received: from orsmsx901.amr.corp.intel.com ([10.22.229.23])
 by orviesa008.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 27 Feb 2025 21:39:35 -0800
Received: from orsmsx603.amr.corp.intel.com (10.22.229.16) by
 ORSMSX901.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.2.1544.14; Thu, 27 Feb 2025 21:39:33 -0800
Received: from ORSEDG601.ED.cps.intel.com (10.7.248.6) by
 orsmsx603.amr.corp.intel.com (10.22.229.16) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.44 via Frontend Transport; Thu, 27 Feb 2025 21:39:33 -0800
Received: from NAM10-DM6-obe.outbound.protection.outlook.com (104.47.58.48) by
 edgegateway.intel.com (134.134.137.102) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.44; Thu, 27 Feb 2025 21:39:33 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=cFj7jA/ZU0UFCvm5ZVvC1Ogw0F7QK+a5XJW7zSZtOXlA/SVg9zXVZVqF4VWtmgR2RaE3VyP7ozMdzJipYylUbPElpX4CE2GvjemWrVsRlz2hp9eeYSFDOyklfFwaAHhvo8m62Pk++HaPwNJTz9i3DVFIOSsIifN6l7KQjLcCGUpJy++88rIL5avNHlhfLtafNVo7aK/uc58+IZ+oMZlblFb3R1Rd4k0an+4QQQcGidgSrMFtpum+dJZiC/7akkSPnOPhbHhXrvv/G/TCsYSyTwRmuQUFMNcYWZxuSxC/fGHCfxJBTKTUdbNFb9Eipb5sbrPoSG+S2LkeJD9bAYJejw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=MdWS+mqQ+a9ZgYM8EYXVvGiyAXcTmowZpvAKyEb8kqU=;
 b=WmvMGVKiofZArzDJO40haXshQlPYjJTxn/qdBCEjbZyx44zzoPnoBUpI8ZJ+l9eWPN5rwiFTiLxLP038RdMYmPHw1ENHCZQrsT32FWY2AL4S1kpVO7y3pxIOH6gM7TdSLCPKPK3d/swFoEQtqu+WW+E+bv2VIWngiQwQaZMdF2V8WGvFMHBIsuKU+hkH0nIK2Jj+yPCX90ZlbrGthjOemJ2UZbtYO8R9Nsm4RJQEmhkoPSWxU/O84+voaBJUpSi0HJJU9nEkw9JFLqB6z+aBQTc0Scp1Q6Hb6qIITBwQUqfiSGuMdLlxBKlvXwrJIsQB3TM8r/qZwVNELeu/x/Q6EQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Received: from SJ0PR11MB6744.namprd11.prod.outlook.com (2603:10b6:a03:47d::10)
 by SA1PR11MB6757.namprd11.prod.outlook.com (2603:10b6:806:25c::13)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8466.20; Fri, 28 Feb
 2025 05:39:31 +0000
Received: from SJ0PR11MB6744.namprd11.prod.outlook.com
 ([fe80::fe49:d628:48b1:6091]) by SJ0PR11MB6744.namprd11.prod.outlook.com
 ([fe80::fe49:d628:48b1:6091%6]) with mapi id 15.20.8489.021; Fri, 28 Feb 2025
 05:39:31 +0000
From: "Duan, Zhenzhong" <zhenzhong.duan@intel.com>
To: "eric.auger@redhat.com" <eric.auger@redhat.com>, "qemu-devel@nongnu.org"
 <qemu-devel@nongnu.org>
CC: "alex.williamson@redhat.com" <alex.williamson@redhat.com>,
 "clg@redhat.com" <clg@redhat.com>, "mst@redhat.com" <mst@redhat.com>,
 "jasowang@redhat.com" <jasowang@redhat.com>, "peterx@redhat.com"
 <peterx@redhat.com>, "jgg@nvidia.com" <jgg@nvidia.com>, "nicolinc@nvidia.com"
 <nicolinc@nvidia.com>, "shameerali.kolothum.thodi@huawei.com"
 <shameerali.kolothum.thodi@huawei.com>, "joao.m.martins@oracle.com"
 <joao.m.martins@oracle.com>, "clement.mathieu--drif@eviden.com"
 <clement.mathieu--drif@eviden.com>, "Tian, Kevin" <kevin.tian@intel.com>,
 "Liu, Yi L" <yi.l.liu@intel.com>, "Peng, Chao P" <chao.p.peng@intel.com>
Subject: RE: [PATCH rfcv2 02/20] vfio/iommufd: Add properties and handlers to
 TYPE_HOST_IOMMU_DEVICE_IOMMUFD
Thread-Topic: [PATCH rfcv2 02/20] vfio/iommufd: Add properties and handlers to
 TYPE_HOST_IOMMU_DEVICE_IOMMUFD
Thread-Index: AQHbgqf30IKJpW40CkSspFKjs0TUmrNQeDEAgApxy0A=
Date: Fri, 28 Feb 2025 05:39:30 +0000
Message-ID: <SJ0PR11MB67447D5D7CDBCF28D05B50FF92CC2@SJ0PR11MB6744.namprd11.prod.outlook.com>
References: <20250219082228.3303163-1-zhenzhong.duan@intel.com>
 <20250219082228.3303163-3-zhenzhong.duan@intel.com>
 <854e0b68-b7aa-44e3-960c-00f3f2d80d44@redhat.com>
In-Reply-To: <854e0b68-b7aa-44e3-960c-00f3f2d80d44@redhat.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: SJ0PR11MB6744:EE_|SA1PR11MB6757:EE_
x-ms-office365-filtering-correlation-id: d63dad0d-4e9e-4a5d-911f-08dd57ba4635
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
 ARA:13230040|366016|1800799024|376014|7416014|38070700018; 
x-microsoft-antispam-message-info: =?us-ascii?Q?4QJZDBlFxAvaD7p9IpnOAB1SC4W6V0gzDoWJG3L2V1LVH3Ku9NoICKsXW+y4?=
 =?us-ascii?Q?rQbDd2aUTULe+56qMzPS7Was3UmnuLpPbI0VCNretsoq00TVW537cTvO1vl/?=
 =?us-ascii?Q?s3azve3XAF9biZJ4ASKpxKq79lzwn7l3PEHvkFLHlfEBYL42yFc5LETcLk/6?=
 =?us-ascii?Q?5g92Yhcej6PwyvOmSSFm/fowwMXlcR8i6Y1LYeEi4K+w/UBnqjKdcbgBfsIw?=
 =?us-ascii?Q?mzkbqDeHO02ami9qdMuXCedh+Pv+mrYPP1Bn7LRnnTiT8DPBDW397EGqwrnr?=
 =?us-ascii?Q?+TcHMyXVM7ZRYua19H1ji1Rx1L4lvcOFvqJdPcnDPG12w5qVne6CZkFLEFis?=
 =?us-ascii?Q?VSXESDbk96NeocervSvekxo0eJaBO8HrqFn944pcDIIvCFYu617JToGaxFGI?=
 =?us-ascii?Q?o6+3wizvKlp5uXi21yH+xioxOSJZG7QAN8IVrSACRNeYXFrG/rN3cVp8IM6b?=
 =?us-ascii?Q?8YGg7YNUQW1J8hWoMvjo988whzj4LKZw/Eq/RKJYMLUVJdttUikNo9fWzNdp?=
 =?us-ascii?Q?fPQnC7p7DORxeyScKj4EslhiaxeJKjFddEAgVuJRb2Z7UPW0i8k+0NFZJsxI?=
 =?us-ascii?Q?SemIQYH/L8ehP9stV0VCcykm2kMW6OpaqBE7bMTLwXUHOcL5cta0wc1xdOqB?=
 =?us-ascii?Q?UK5kIUiYey+/52bAm74eaL9fBNWIkn+d6DTQ/U4veN/GadWh6L1vWOJLKbr8?=
 =?us-ascii?Q?iDsC2k2kg1OOpSxGBNnM3VRirhbw/FZ6JxoHGM5m+ezeUPkFbua6h1tyW3Iu?=
 =?us-ascii?Q?ZDy2nTU8vIUFVuc7er0p6x5fCg4hICU1OlvvEQF3QabUring91TAC/C1u5Gy?=
 =?us-ascii?Q?8wPU5B6MBkMhbGFzCiqqSNCtqVmmA8UIYXWQOL76y/vV8zK0Sp/WALA8fw/D?=
 =?us-ascii?Q?pUHZCjXOnMBKgTUj/+ICcAX129rXdlb4mT8dPFRrLJqROAb4litRk4pI7cDl?=
 =?us-ascii?Q?IKqIo0CjT3i88HTFiLpccg0ROvAYCrXmrcrvPdXvHpzkijTfewYoysX64fhK?=
 =?us-ascii?Q?MHaTnPtpG1zdcO7X9oxQ98DjYq4EbfLHH5IJEcqCDvzIVtIMGb1m62KZa9xE?=
 =?us-ascii?Q?NSd2VrtZbx08+rIVPurh8UrW4H0AeixZqWndOZ2l4rjrOSwsXbnuTOQ+kv9K?=
 =?us-ascii?Q?Ulgym3JaeFG25yPgxjxBmvqpLeQ4Hd7FhVE24MpmaqUplYeZkWKBlc1tVZ90?=
 =?us-ascii?Q?jHZOsG2yxrnpz1bOBvRiZwKIK1toMtNmUUqTUWpaxfgGKJAMIJ897h0eW6LG?=
 =?us-ascii?Q?eSMDiMlddPFVUDozlenujjEfEI58l0AnxxUvDzMPvflcfzaq8LFJs3UIh/1c?=
 =?us-ascii?Q?lVZTHMbmhELiUEqkFmMkx8/Xmp80PZe6A/PXsKg90eva40s0vZvl6OeZhD2f?=
 =?us-ascii?Q?OdVG+jVFNys7vH00nAJlVoJJPRw4HPLNawgIQuC+sEjUgrCLEudfysZxxY+9?=
 =?us-ascii?Q?q5EZhy/vCDcUaYu5odIJ7CQ1LZLcbGEm?=
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:SJ0PR11MB6744.namprd11.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(366016)(1800799024)(376014)(7416014)(38070700018); DIR:OUT;
 SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?knmio0K5a752Ky4kR0N1EsrAwcUuQw4GWLY5gSEppsZ2N7VL2tJGylTDa0id?=
 =?us-ascii?Q?vGn8luHkPevm5TLZH4UhII64VAU/4PXmRsxCiVEN5nS/NJjvgJzL7NXUjb1u?=
 =?us-ascii?Q?p07Ly49dAuxuqxe4v428UjC/ftjjMaVBsCV9I5ftWGGf1dikGGyvGjrsGDKN?=
 =?us-ascii?Q?Ax8MFjDxvdW14ll2zqJL3AnWg48xMu1g/Aq7m+DtKNC/b7P8dZJQUXz4koy9?=
 =?us-ascii?Q?HToRVHVzjP76rlgYOStnWkyEt8qDUOvSpYcD/4KU+y+v7oIXZI6O/53qJNMq?=
 =?us-ascii?Q?Bi6ZgF0y2ENZE4IdnmAMFRP8De3Ztx+OQQ6G5eCwVrXwULvbanfOHWU58CR8?=
 =?us-ascii?Q?WLD1dQSFlCZrOOLquRSEPJfMGvkmarNrhE1ty54jrhPJaOn7Tx7VqaCNiXiB?=
 =?us-ascii?Q?soGFwybNX4WyX+X2uUU3utwGRXIs+UclYlMd2QkvKKTLaQzgdXoJwL970ejU?=
 =?us-ascii?Q?PXTRLhrk2ScQkKQVIEHIFi3fB6dRV1dsIevJ5njWxov4VYek7SBhYkil0mDb?=
 =?us-ascii?Q?tWAcWBnYt+Yy3LJBRmHEQXSN0pkzvwaJCx+hgdZcUQVDlVEW0N1HzyzVMzlV?=
 =?us-ascii?Q?m/BH4Lv6hG0ThbP/rhVDiWELvobJMF9or4ct466U3dxaR1JJJYbVOAkAvfVf?=
 =?us-ascii?Q?5lLt6Nnuhgj/UIbBGL5vLwXQmcF9A1Las7Qw0Dbp2EqL/8M/eCMI1ONeoGV5?=
 =?us-ascii?Q?1Q6pczkkHI+cey+F7b/Cq5iNYquSD37XnIOfmBS73Vnaw2Bjt3mH047fYMmw?=
 =?us-ascii?Q?7CKRtJnsOnDO7dbEFUiGkp7/0+9B2ANkLr2/8/IVUP37yNJ99zm/CjBQdXSq?=
 =?us-ascii?Q?1PaAVsm8MvRsVY7+U89FlVSdF+mBSmAnFOU0nCBknzS8+251xV2bm/u3Hh6v?=
 =?us-ascii?Q?LPDB8uvI+1uMpaG1mwY75fLT0nIKaWni8+WCNUDRk24EyL2htuvYPvJZEJFw?=
 =?us-ascii?Q?S+SsoA2Wv9j//fbIJdI4nW0s3A753MYI7LcTfmEqgL1OAZRZ6DtdVzPwEAJW?=
 =?us-ascii?Q?Wdz6ORfr3nk7cpJYYGZZyd86a2T8ixezocUi2Fe7xuR8cqaqh0GU5d0qZIlC?=
 =?us-ascii?Q?UfQ4Oyr7TSD0ZfAwPOiN+cFtR5StITzgsrrTec9WSnNocWc7NZmOzHeznbS0?=
 =?us-ascii?Q?/lGnRGWGPH2l1nVnCWVPf6fu9uh3bJPkl5qu35IxZQyKiZkj4gmOADcXz8Hl?=
 =?us-ascii?Q?6vYXWUQ6OcAqRBCnJBFlR2EbGKWNVp3gCnr+Blz6Be9/ZxnQx13pCI7ghLLI?=
 =?us-ascii?Q?8maHwAVmc9t2aE6eyIpB8wd52rsI05CkJGIKtiww4T0y4xp+nvT5hIVmjt76?=
 =?us-ascii?Q?r9Ha7anIA0uVwbva5IwAVTi5KHT18QWrxg2AMx/x0nhtzfcivxiMFH/IEy6w?=
 =?us-ascii?Q?rbxqCuHIGI1MUfBpd/68VwN44wKOCVz8o7d4ep4kyh9hNU/4/ogLO8VJQqr8?=
 =?us-ascii?Q?7GDu92Uff92KbrdR4uDYlceQrB9yJy9z2aThnxHBEztFeJUdBH9DGhEnGGed?=
 =?us-ascii?Q?c1YW8ZmFsRmQ8jCTFek9ypAhyVw/jiXF8gdKJexTSU5IIVmfI2/axJUnafRC?=
 =?us-ascii?Q?he+GmJYhgsE9D0upSQk8lpuS2tUTigtCpm4S9FN4?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: SJ0PR11MB6744.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: d63dad0d-4e9e-4a5d-911f-08dd57ba4635
X-MS-Exchange-CrossTenant-originalarrivaltime: 28 Feb 2025 05:39:30.9500 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: LE9Rdv3YDmiXDz+SXiZ7KGdpuwHYUb2zyLPwdRw2gRba1UxjBOv1vKf1xZUW3mEOKaJ+V3K3SaTvYeUAwNxFFfV8c9A5ODnNX3gQuI6XNFQ=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA1PR11MB6757
X-OriginatorOrg: intel.com
Received-SPF: pass client-ip=198.175.65.12;
 envelope-from=zhenzhong.duan@intel.com; helo=mgamail.intel.com
X-Spam_score_int: -47
X-Spam_score: -4.8
X-Spam_bar: ----
X-Spam_report: (-4.8 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.438,
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

Hi Eric,

>-----Original Message-----
>From: Eric Auger <eric.auger@redhat.com>
>Subject: Re: [PATCH rfcv2 02/20] vfio/iommufd: Add properties and handlers=
 to
>TYPE_HOST_IOMMU_DEVICE_IOMMUFD
>
>Hi Zhenzhong,
>
>
>On 2/19/25 9:22 AM, Zhenzhong Duan wrote:
>> New added properties include IOMMUFD handle, devid and hwpt_id.
>a property generally has an other meaning in qemu (PROP*).
>
>I would rather say you enhance HostIOMMUDeviceIOMMUFD object with 3 new
>members, specific to the iommufd BE + 2 new class functions.

Will do.

>
>
>> IOMMUFD handle and devid are used to allocate/free ioas and hwpt.
>> hwpt_id is used to re-attach IOMMUFD backed device to its default
>> VFIO sub-system created hwpt, i.e., when vIOMMU is disabled by
>> guest. These properties are initialized in .realize_late() handler.
>realize_late does not exist yet
>>
>> New added handlers include [at|de]tach_hwpt. They are used to
>> attach/detach hwpt. VFIO and VDPA have different way to attach
>> and detach, so implementation will be in sub-class instead of
>> HostIOMMUDeviceIOMMUFD.
>this is tricky to follow ...

I mean implementing [at|de]tach_hwpt in e.g., HostIOMMUDeviceIOMMUFDVFIO.

>>
>> Add two wrappers host_iommu_device_iommufd_[at|de]tach_hwpt to
>> wrap the two handlers.
>>
>> This is a prerequisite patch for following ones.
>would get rid of that sentence as it does not help much

Sure.

Thanks
Zhenzhong


