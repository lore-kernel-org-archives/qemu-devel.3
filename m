Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 54BDCC54E58
	for <qemu-devel@archiver.kernel.org>; Wed, 20 Mar 2024 15:33:17 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rmxwH-000282-KG; Wed, 20 Mar 2024 11:33:13 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <yuan1.liu@intel.com>)
 id 1rmxwE-00027N-Cu
 for qemu-devel@nongnu.org; Wed, 20 Mar 2024 11:33:10 -0400
Received: from mgamail.intel.com ([192.198.163.18])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <yuan1.liu@intel.com>)
 id 1rmxwC-0003hy-KZ
 for qemu-devel@nongnu.org; Wed, 20 Mar 2024 11:33:10 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1710948788; x=1742484788;
 h=from:to:cc:subject:date:message-id:references:
 in-reply-to:content-transfer-encoding:mime-version;
 bh=IxjmeAdh5/rQEqZXxw45oC3nwE+30j5B1AmSoroUdOo=;
 b=iXQoFDKW8qAZ50/jzifWRikptXnWIHkGT34S4VZ60NCc3vCmp1dWVq7c
 vI82RmOR18AHDGPk/sDHRlW7nt/A/n26B7/WzOMtzkc3qqnlJuUtQdDx2
 Tb4mBflt4jzeczdcyTAkUBdKgcFOvJ4NVVBLbS7Q6g7EFPYJhC76vBCQ+
 d6HhdqUSFqXQ3zxE5TlClgVa54/E4/LVVluA6skKc8ij/KDWbV5npR8qV
 iUeoYxoiTDLoATIYaviudb0QVnHr/hr4pzKntTcDK9EFFDrNgpSzv7rIo
 BFqRzDfEEnAJ4lsXq29jzKfQ0y6Hptd/CbYt7JWG1wlpI4WUBx0G4D5qk g==;
X-IronPort-AV: E=McAfee;i="6600,9927,11019"; a="5718227"
X-IronPort-AV: E=Sophos;i="6.07,140,1708416000"; 
   d="scan'208";a="5718227"
Received: from fmviesa007.fm.intel.com ([10.60.135.147])
 by fmvoesa112.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 20 Mar 2024 08:33:07 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.07,140,1708416000"; d="scan'208";a="14174238"
Received: from fmsmsx602.amr.corp.intel.com ([10.18.126.82])
 by fmviesa007.fm.intel.com with ESMTP/TLS/AES256-GCM-SHA384;
 20 Mar 2024 08:32:55 -0700
Received: from fmsmsx611.amr.corp.intel.com (10.18.126.91) by
 fmsmsx602.amr.corp.intel.com (10.18.126.82) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35; Wed, 20 Mar 2024 08:32:54 -0700
Received: from fmsedg602.ED.cps.intel.com (10.1.192.136) by
 fmsmsx611.amr.corp.intel.com (10.18.126.91) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35 via Frontend Transport; Wed, 20 Mar 2024 08:32:54 -0700
Received: from NAM10-MW2-obe.outbound.protection.outlook.com (104.47.55.100)
 by edgegateway.intel.com (192.55.55.71) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.35; Wed, 20 Mar 2024 08:32:54 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=mvbaCDhFz1kd6h/vr+cySCT1nZwP5oJhr9bnxm06k7tJnoYT+SEg24vVbXowpHQkJGre8JxOJ0VB0hbN1GaCWW6g4X0FmuA9ybFgayOuXzCD3UCt4QmhvuFr45i1RrJJ7Ftz7Wp/6B7hr/pE4DQDdLTYVEDXP13F8paDGLhdL8UY7vnB37+zv8RbL56sKn3PGQb/naMrvWdSb/k/qHbRIH+innjq63ebpS6w1RUq8a0TE/5OEAn2NBsqjjWE6W8jdDT4ewzcPnGLeKET6jgQo9hAFNs58wIQ7O1lVupzG9h9n3kZyW6lhwnEr99XqDBYlNb4dhsYjRr/t6JwYU4b1g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=E2DsAWMFW41KsWpl4HTNSRZXIRLdsNNgpHzpzwAKwPw=;
 b=N3OGKTnTn1n3npkFVTPSQoJFLzEgqjEa4peukb28Zbpwwyz5FmQiggj8YH31xgavsa/IwKYXbBaZebzike//+lBQ/GZsWqdOs+4GV2lc20F0IL6ORAH9jEn0AgjxnVDLciWf/170lpLiGiUrWmUQ3a6jzhRDMCZyF3BqFvScrndYoGrFCjrFz+bFKlkOOGU3yMgITxZgO+wJyME/WsoBoM7aD3Zu/+pzQ1FqoLxL9lX5TVGH8QDD8BticWi+EKoInX4EDdFug7r7IqSD3wFPFCvJcwsiJQyPeIEMFigVQH8uJ29McVSpJS0w41Rs1GZD4ZOnodmbHE/KHcf2evjKUg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Received: from PH7PR11MB5941.namprd11.prod.outlook.com (2603:10b6:510:13d::20)
 by DS7PR11MB6293.namprd11.prod.outlook.com (2603:10b6:8:97::19) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7409.11; Wed, 20 Mar
 2024 15:32:52 +0000
Received: from PH7PR11MB5941.namprd11.prod.outlook.com
 ([fe80::f926:1804:73ce:ca52]) by PH7PR11MB5941.namprd11.prod.outlook.com
 ([fe80::f926:1804:73ce:ca52%4]) with mapi id 15.20.7409.010; Wed, 20 Mar 2024
 15:32:52 +0000
From: "Liu, Yuan1" <yuan1.liu@intel.com>
To: Fabiano Rosas <farosas@suse.de>, "peterx@redhat.com" <peterx@redhat.com>
CC: "qemu-devel@nongnu.org" <qemu-devel@nongnu.org>, "hao.xiang@bytedance.com"
 <hao.xiang@bytedance.com>, "bryan.zhang@bytedance.com"
 <bryan.zhang@bytedance.com>, "Zou, Nanhai" <nanhai.zou@intel.com>
Subject: RE: [PATCH v5 2/7] migration/multifd: put IOV initialization into
 compression method
Thread-Topic: [PATCH v5 2/7] migration/multifd: put IOV initialization into
 compression method
Thread-Index: AQHaeqFCBxn/jaoc2UCkYujkP9hGgbFAvnoAgAADoSA=
Date: Wed, 20 Mar 2024 15:32:52 +0000
Message-ID: <PH7PR11MB59413EC4811386DB5B2794D6A3332@PH7PR11MB5941.namprd11.prod.outlook.com>
References: <20240319164527.1873891-1-yuan1.liu@intel.com>
 <20240319164527.1873891-3-yuan1.liu@intel.com> <87bk79lynr.fsf@suse.de>
In-Reply-To: <87bk79lynr.fsf@suse.de>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: PH7PR11MB5941:EE_|DS7PR11MB6293:EE_
x-ms-office365-filtering-correlation-id: 507c9f83-dad4-4ece-f1f1-08dc48f301cf
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: he/peXjl0cVVa+74mf2dQubImNamW6KWvwnPS2T/5HogbaLWG6LRWkMx9CIkXBBdLUc4MO2PomKgE/mDDNjRYz5kOT2z5ls3j43b7hNROJIL05INU5L5SypnY2Jln+YObS7YgT2rndwTrmHwCQkHDhN97EcMRRccQ2nfUYB1qPYvtLTIf0BtQ9ncnGsg2ccR3Bw0MVL09Ih0NnC+2E6tsltoqfiRxWOGpz0ELcj0elGw1/NlsJdxgbcit7SmwhsRZfNAA3uSfUE4Ejo1mEqAUy7iBszVhnW47R2CPIt/obf5OJlxyVHY/NDKq5qpjeDVjbCkT0pLI9ya7djO1sNa1V9ZQnhy7nnCX21fSSxDm7lM1y4sExLcmMZYyfRNNOwx4SAm3lJ4zv9VL4ZyeMjQ/VDHXgL5qpmKFWKHAyBtvfoPbih1Tdb8I1UEgA7p+TuFgVgsJMLs9R5T1zZ1kup5BfDrsuYJubW1Fzhlk/hVNVG93OnpY1kBRpJ/voaL6EWdzFqDL9v4/3+IV9Izo1GA74P889eWH388Y0P9kqQJ0HjzSd440qMXTo9XvhMJTmSjIFoU+w9GDcR6w1x8aN0KNQ0vut8dV01VrGTRY6YD60y2Xjvt6pQDRs+7wYMnXG5B9VLl94Z9QrhpjSlTvsZD1Sq+V7oEzxMcbtpafezQ9Ab102+bbHNwxBEW/RDaXSQY0BpnmPBx6ksx1k1hT8LhhQ==
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:PH7PR11MB5941.namprd11.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230031)(366007)(1800799015)(376005)(38070700009); DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?gdxj3LxIwNNrMZ5xbVwQ2Z9GiCiaEsEX2UP4vQkGvV77dnKT3XONAJyU+2Qy?=
 =?us-ascii?Q?gW7AFwEvZz687feuiGe1F4EBvMPqCTQL+1/Qvu9RzIzXZjVLSnVjW+0RykSw?=
 =?us-ascii?Q?qIOyq/tEm32Kt4OfIIiildTtMFlip09CKw288+4dUSdjRRf7/85AAPvI8Ixm?=
 =?us-ascii?Q?XSKFcLoYIPWAh2NlYYpfu18ojp8X/PoiSzHjR+GeSNaZbiTZXRhd6yJ6mhqA?=
 =?us-ascii?Q?LJZt5dC6ktQzAc50gUW+N1v6aUf8NwBPyYVZtdtEjvkwc71FjXPV3fKbfp3Q?=
 =?us-ascii?Q?1bgR9Sd3OVLzpatQI+EW2vNaIVZ16iiKsMRVg7w5d0ePtT2nHKJWmQw37G8o?=
 =?us-ascii?Q?B28jGVtDpYp6OekTQCztT376lJhbTq+N1v4JjW/uAg7UJ4Ugd/743ZH4r/cQ?=
 =?us-ascii?Q?uroR6Zmfq6yDfMFH6wb3V43yd0xoufHfjJiIIbuvel3yBvyHNtVU2Nuu12Cz?=
 =?us-ascii?Q?+tVKjaQuzwxGa71x04IyQhBXvaogdmDMFjn5eaM+ngdFcg1WEroBH5l4jT/R?=
 =?us-ascii?Q?zFBHHVO5T6J21qiF7z5Vj4kSziB5z41CO7agm/VI1CoE6vAsEDrsEuvGRO0z?=
 =?us-ascii?Q?kUJOGPcCF4hUF3GJOj6QtCYDCxQXzS4zJGkTAKdBEvlUIM5/gSO4ZNyV8sNB?=
 =?us-ascii?Q?vMobRsLcEXVOUHdrimorrgFGaBvMN6dLIHH8pt7ItXaxfnCM+4t09TF0HHx+?=
 =?us-ascii?Q?Vb4Sk+y//zqdDPUTO80nTzpYzQVwKmIxIfRIsHS0/08JP2xtaFuly/+LRuMR?=
 =?us-ascii?Q?1Ac7QL0or89E3lgxK/mwWI8yBA39ftN5RMJhKg4FQIGHY65BpFmY+u2f6KT2?=
 =?us-ascii?Q?L7DDD6ybcBZGupVLOX1VBygY/qi/Z1X9fD4K5Lf8G2e2QSmWHtBfQVxsUBe3?=
 =?us-ascii?Q?D6kpRv2DNU/MOOGpCzEm9pveARWk9BMke9GedXRLHZ4Nz2ZUUizWeqBHEdkO?=
 =?us-ascii?Q?DWLiIgKN6dy36srtYt/bungSfwsfweslt/SICdv+61nO1fR9R4YWZGbwYwbX?=
 =?us-ascii?Q?Sg8xvO3GbZahjldI1T6ImVq4vgysb1CnkQZuSJaZFg4UEzzp7lJzAG5stnm3?=
 =?us-ascii?Q?7D83yXL8B3OL8HCNs637TA84cqm9i4jMDk/rxWJqU5Zi/f/Voat/rXX/oIBb?=
 =?us-ascii?Q?enjF72AzFHA6LhVh5EiXMIwQ/9iMXsE25z9fnuHaWDDVqubiyCmLboJlagzD?=
 =?us-ascii?Q?eTSfcGKMxaZNDwl35n16GIIzAz+L/ig9nGvqQXXRa00Mk41EZiHLNT/AqjB1?=
 =?us-ascii?Q?kufMNVgHxg324bjRaHUyXqGqpre2F1dr99Nncn/xZUJWqFd7AQrV2NpI5DzT?=
 =?us-ascii?Q?rdurwIvI6+YVPU5I7oteyIesgf8M2RgkOOrQu/Gp7qUXC8aKJfrCSbQChgw9?=
 =?us-ascii?Q?3+ckjdfYxDlgmhKyUpAM+16y1/K9YVJ68V2V/pEAzGGGugjQ3MiuufGYntQc?=
 =?us-ascii?Q?Nw0Fbw922KrwaXf0vFua2IwHvR+eWE7HARBMg1E3d/DIjJnppP1C8gJ/+u9U?=
 =?us-ascii?Q?qbsaFG149EIdPEsaUjASepuwRtNW0LOiuracBDEeiJv/6jDZzVT7oBqtV670?=
 =?us-ascii?Q?WFvptsRzR68MTMNoap+VUGSJ5U+ChZK7yc2zBVwd?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: PH7PR11MB5941.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 507c9f83-dad4-4ece-f1f1-08dc48f301cf
X-MS-Exchange-CrossTenant-originalarrivaltime: 20 Mar 2024 15:32:52.4318 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: KPjyAEfpmTdX/mGqKo76pgmd/KbiCXELpSL7NLlzb0naznFiK3LH7F0uD3oqSUqQ59LVaZmZ0Nx8B7q+fDdHSw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS7PR11MB6293
X-OriginatorOrg: intel.com
Received-SPF: pass client-ip=192.198.163.18; envelope-from=yuan1.liu@intel.com;
 helo=mgamail.intel.com
X-Spam_score_int: -24
X-Spam_score: -2.5
X-Spam_bar: --
X-Spam_report: (-2.5 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.417,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H2=-0.001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001, T_SCC_BODY_TEXT_LINE=-0.01 autolearn=ham autolearn_force=no
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

> -----Original Message-----
> From: Fabiano Rosas <farosas@suse.de>
> Sent: Wednesday, March 20, 2024 11:19 PM
> To: Liu, Yuan1 <yuan1.liu@intel.com>; peterx@redhat.com
> Cc: qemu-devel@nongnu.org; hao.xiang@bytedance.com;
> bryan.zhang@bytedance.com; Liu, Yuan1 <yuan1.liu@intel.com>; Zou, Nanhai
> <nanhai.zou@intel.com>
> Subject: Re: [PATCH v5 2/7] migration/multifd: put IOV initialization int=
o
> compression method
>=20
> Yuan Liu <yuan1.liu@intel.com> writes:
>=20
> > Different compression methods may require different numbers of IOVs.
> > Based on streaming compression of zlib and zstd, all pages will be
> > compressed to a data block, so two IOVs are needed for packet header
> > and compressed data block.
> >
> > Signed-off-by: Yuan Liu <yuan1.liu@intel.com>
> > Reviewed-by: Nanhai Zou <nanhai.zou@intel.com>
> > ---
> >  migration/multifd-zlib.c | 4 ++++
> >  migration/multifd-zstd.c | 6 +++++-
> >  migration/multifd.c      | 8 +++++---
> >  3 files changed, 14 insertions(+), 4 deletions(-)
> >
> > diff --git a/migration/multifd-zlib.c b/migration/multifd-zlib.c
> > index 99821cd4d5..8095ef8e28 100644
> > --- a/migration/multifd-zlib.c
> > +++ b/migration/multifd-zlib.c
> > @@ -70,6 +70,10 @@ static int zlib_send_setup(MultiFDSendParams *p,
> Error **errp)
> >          goto err_free_zbuff;
> >      }
> >      p->compress_data =3D z;
> > +
> > +    assert(p->iov =3D=3D NULL);
> > +    /* For packet header and zlib streaming compression block */
> > +    p->iov =3D g_new0(struct iovec, 2);
> >      return 0;
> >
> >  err_free_zbuff:
> > diff --git a/migration/multifd-zstd.c b/migration/multifd-zstd.c
> > index 02112255ad..9c9217794e 100644
> > --- a/migration/multifd-zstd.c
> > +++ b/migration/multifd-zstd.c
> > @@ -52,7 +52,6 @@ static int zstd_send_setup(MultiFDSendParams *p, Erro=
r
> **errp)
> >      struct zstd_data *z =3D g_new0(struct zstd_data, 1);
> >      int res;
> >
> > -    p->compress_data =3D z;
> >      z->zcs =3D ZSTD_createCStream();
> >      if (!z->zcs) {
> >          g_free(z);
> > @@ -77,6 +76,11 @@ static int zstd_send_setup(MultiFDSendParams *p,
> Error **errp)
> >          error_setg(errp, "multifd %u: out of memory for zbuff", p->id)=
;
> >          return -1;
> >      }
> > +    p->compress_data =3D z;
> > +
> > +    assert(p->iov =3D=3D NULL);
> > +    /* For packet header and zstd streaming compression block */
> > +    p->iov =3D g_new0(struct iovec, 2);
> >      return 0;
> >  }
> >
> > diff --git a/migration/multifd.c b/migration/multifd.c
> > index 0179422f6d..5155e02ae3 100644
> > --- a/migration/multifd.c
> > +++ b/migration/multifd.c
> > @@ -1181,9 +1181,11 @@ bool multifd_send_setup(void)
> >              p->packet =3D g_malloc0(p->packet_len);
> >              p->packet->magic =3D cpu_to_be32(MULTIFD_MAGIC);
> >              p->packet->version =3D cpu_to_be32(MULTIFD_VERSION);
> > -
> > -            /* We need one extra place for the packet header */
> > -            p->iov =3D g_new0(struct iovec, page_count + 1);
> > +            /* IOVs are initialized in send_setup of compression metho=
d
> */
> > +            if (!migrate_multifd_compression()) {
> > +                /* We need one extra place for the packet header */
> > +                p->iov =3D g_new0(struct iovec, page_count + 1);
> > +            }
>=20
> This^ should go into nocomp_send_setup:
>=20
> static int nocomp_send_setup(MultiFDSendParams *p, Error **errp)
> {
>     if (migrate_zero_copy_send()) {
>         p->write_flags |=3D QIO_CHANNEL_WRITE_FLAG_ZERO_COPY;
>     }
>=20
>     if (multifd_use_packets()) {
>         /* We need one extra place for the packet header */
>         p->iov =3D g_new0(struct iovec, p->page_count + 1);
>     } else {
>         p->iov =3D g_new0(struct iovec, p->page_count);
>     }
>=20
>     return 0;
> }

Yes, this is better, I will fix this in the next version,
thanks for your comments.

> >          } else {
> >              p->iov =3D g_new0(struct iovec, page_count);
> >          }

