Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id BB260C54E49
	for <qemu-devel@archiver.kernel.org>; Wed,  6 Mar 2024 01:17:29 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rhftp-0006JB-Md; Tue, 05 Mar 2024 20:16:49 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <yuan1.liu@intel.com>)
 id 1rhfto-0006J3-Bf
 for qemu-devel@nongnu.org; Tue, 05 Mar 2024 20:16:48 -0500
Received: from mgamail.intel.com ([198.175.65.9])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <yuan1.liu@intel.com>)
 id 1rhftk-0007cb-V6
 for qemu-devel@nongnu.org; Tue, 05 Mar 2024 20:16:48 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1709687806; x=1741223806;
 h=from:to:cc:subject:date:message-id:references:
 in-reply-to:content-transfer-encoding:mime-version;
 bh=PvqVwpQ66wM1Of/uqLoY6dXRZzCMBtacrpLutdrcWvo=;
 b=bRIgRHth+CWq/nEhJXH/8AHgebUzjDoj37u+wi2Nw+5H8Wg38bFojeiT
 PzwPCxP0FX224j37ArSCZglHrcR5j1IqkL872QSD1FIfJ4/vtc46QceX5
 4pwu10RNtA3na3Qw9X854g7PsyoVjW0HT277H+3iRgfneYnjbpltWO/eR
 OWks5ug1T3Lj2G7npnheOD7NqEuepXgnayHNprFpOe4DhZfabX9NMzGN+
 8qHj3MaY+nhoanmIj/cB9mEqXL/gIxULLYOJNFWu9RZ+jeGN00pQXVUVD
 UZVy+kGOylGkk3hM/Y1g4e6Yrbn5dlVTvGzc7TT5z6R+SC6ahG1ti75Hz Q==;
X-IronPort-AV: E=McAfee;i="6600,9927,11004"; a="26736622"
X-IronPort-AV: E=Sophos;i="6.06,207,1705392000"; d="scan'208";a="26736622"
Received: from orviesa003.jf.intel.com ([10.64.159.143])
 by orvoesa101.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 05 Mar 2024 17:16:29 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.06,207,1705392000"; d="scan'208";a="14230326"
Received: from orsmsx601.amr.corp.intel.com ([10.22.229.14])
 by orviesa003.jf.intel.com with ESMTP/TLS/AES256-GCM-SHA384;
 05 Mar 2024 17:16:29 -0800
Received: from orsmsx601.amr.corp.intel.com (10.22.229.14) by
 ORSMSX601.amr.corp.intel.com (10.22.229.14) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35; Tue, 5 Mar 2024 17:16:28 -0800
Received: from ORSEDG602.ED.cps.intel.com (10.7.248.7) by
 orsmsx601.amr.corp.intel.com (10.22.229.14) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35 via Frontend Transport; Tue, 5 Mar 2024 17:16:28 -0800
Received: from NAM12-DM6-obe.outbound.protection.outlook.com (104.47.59.168)
 by edgegateway.intel.com (134.134.137.103) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.35; Tue, 5 Mar 2024 17:16:28 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=F0AnNbyJaqtXSEctb01GKMApdvtcFjLSff7S/hGehB4HmaPyR/kO+t5SJFHQTADQ9DMU6aXEMDVKXAWYSMV+rZMXX9IbvJHAhbvtd/Nd4j0xe6x174NolT3u5EVUB+nFijPm+ox40woWmED0F7lTqkA0YeUbJ29VuHoJz94srg8P+XwLyr9N38WO9CB2dSUh3/OYhvFLu/VhaRb2Vs5Blzrf7ZSr4uppKThK5Waa8tkCwHyyLCzxVtS49DRmOZTkfMdXj5fQqZn7LlWC+7IsmAhHD3SwMOCmcFgVDBYLSCrcBCCO2ZRjck0SNIeFFHZGcDxcoyN2IcpYP0KrtDHr2g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=12PoUuYQwmvCMDWihyk1/nmKHF17JCZsJx5IRJ5X3H8=;
 b=FFirEfpRpb10zUV/o6hqqIXzZeF0Sp6o6/Dumgxlhx+0YankcI5LV5tumS3SGy7klG4oCQa2qIzFHom/DwNbpZBWib2T6W758ze2Rg2o9sNh75K9XoWkf1+QjWtXVDxFXsvOaswkYPWq+Uc/13xEeYXicLGE8ca72L8hVgSBClbb0ZoJWgbnNsLe0lNhlNax5X7aHmlVwYLtwvtFiRWFM8XU1h3zzuQekBuLn7iuZqWYtHYjp/w2nNKZml4J05kxthj4K96DH2ZADWMsN5qNOJbnJ5wA14enPMOv+CbHLL/qXcnSodRi1TycQoMcXZp3Uy/UjiQygoclwXU6pCc5HQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Received: from PH7PR11MB5941.namprd11.prod.outlook.com (2603:10b6:510:13d::20)
 by SN7PR11MB7114.namprd11.prod.outlook.com (2603:10b6:806:299::18)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7362.24; Wed, 6 Mar
 2024 01:16:25 +0000
Received: from PH7PR11MB5941.namprd11.prod.outlook.com
 ([fe80::f0ec:877c:fd93:a04c]) by PH7PR11MB5941.namprd11.prod.outlook.com
 ([fe80::f0ec:877c:fd93:a04c%3]) with mapi id 15.20.7362.019; Wed, 6 Mar 2024
 01:16:25 +0000
From: "Liu, Yuan1" <yuan1.liu@intel.com>
To: Fabiano Rosas <farosas@suse.de>, "peterx@redhat.com" <peterx@redhat.com>
CC: "qemu-devel@nongnu.org" <qemu-devel@nongnu.org>, "hao.xiang@bytedance.com"
 <hao.xiang@bytedance.com>, "bryan.zhang@bytedance.com"
 <bryan.zhang@bytedance.com>, "Zou, Nanhai" <nanhai.zou@intel.com>
Subject: RE: [PATCH v4 2/8] migration/multifd: add get_iov_count in the
 multifd method
Thread-Topic: [PATCH v4 2/8] migration/multifd: add get_iov_count in the
 multifd method
Thread-Index: AQHabsC1Zs6yhFgmDkGz4exNY6Yo37EpmLYAgABQweA=
Date: Wed, 6 Mar 2024 01:16:25 +0000
Message-ID: <PH7PR11MB5941DE1B794B24DFAF017B3FA3212@PH7PR11MB5941.namprd11.prod.outlook.com>
References: <20240304140028.1590649-1-yuan1.liu@intel.com>
 <20240304140028.1590649-3-yuan1.liu@intel.com> <877cigig09.fsf@suse.de>
In-Reply-To: <877cigig09.fsf@suse.de>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: PH7PR11MB5941:EE_|SN7PR11MB7114:EE_
x-ms-office365-filtering-correlation-id: becbc485-0f06-49c6-92bb-08dc3d7b0b31
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: vTVag1P9DnkAx9yoZ+DaY0GZbX+KZQVqSQioiYyIM5wmdPljYMzshSbFtx3hl6Y67e+1k04eFxOvB/rJ6D4yxRQqDYK4UF24qzr0OkdEOiKsgC+DG+Igr5zAieti/8ICtQAlmBLF/xD+O7gMZipz/8lrW/3sM/9LWoBAitgdQf7VgqwFvTNKZxUROQPcN7vcSame50tI2hrXuUenlPdcm2vx3XZK+2zjUhmJGM92WRyH/JXOtihFHSacLpTaKPjanGiE9XEFEWO8UhXG+nlEwBCfCV05XHJEriY6xXm3Xi14Lqh81MhSN/aZxakCHYIpB/l9OwkM16tnejv5JXHLtZU04iQSl0OgIqm+P7Ioudcm2lkHektnMu3g9lSCUYOHMW3cAl3mAYRThAiA0+fe+MVmHGVuigpD527tWa1HAnIC7cJPG9Q5dZv1GHxO5Pah/dRlFrFVtNfnpejHlNwz7NtqOSpyicoUSsodQWkcOvNhA/6nRQTLGyYJ5RWVLGnz1UfqdvUUzwnfrI3tyzdVs1/rKa0T6Gr9VBdNNQaqPfhWUQf8RVV0KIQPT3jeVk9qA4yq+frQwn1xHNRiqr/eC1X7ZwfT8kW15y/IuKFZKPyoVOCGLcuEDYCMT6mJUyA3cVf0uUf0Ut/+iniMEI3zcCLcT4rs62IIgWUTcC65DqvvTTIe9ApVULxl1/0ckwSI2Pe6NUemCXV3QkNw56KESCPWTFA8EMLfkl+VRblmVWk=
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:PH7PR11MB5941.namprd11.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230031)(376005)(38070700009); DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?yb1Bgl6ZUmYMcDAjNcQUDoauYthSBsnClV0tnor+cQoEtI9rM3Bn/4EkNI9O?=
 =?us-ascii?Q?KHbFuk36z4yGWfaP9lTGj5qdrivMmP2PcGV0/M6Zbhx3UDU9Beahy0hlZLno?=
 =?us-ascii?Q?dxsGS4l/bwRtbdbOorQkPtk1qsdecN43sg8ySazhtOtoMMoXZj7xZgMKVZ/M?=
 =?us-ascii?Q?q8ajWne+/vDo0XlwcvUoR1BYOm0T5oLYS5PFP6bvN1BXy9KsdMxPnzwz+/of?=
 =?us-ascii?Q?vBIqoFLARNmTTgIYIvDo8bF0FTMqdP4p3BsBNNRiBcs5UVXimKZJt0YO4iIu?=
 =?us-ascii?Q?YrU1cGWENsejIt/4agFb4edCFaJxZcJRykm9H6r7fk89ig6o9D6gTnytX9DV?=
 =?us-ascii?Q?OcIHydDwfJm2futD2P6M5DK5lG/bFh3tlDF/uRZfUP+QE7FxcjgeH9yh/s2/?=
 =?us-ascii?Q?tkc3eZYlHmUeiU5RkwHioC3xUvEIm/iBi8RlUs0TzyyeeQyaGJnm6EagWpK/?=
 =?us-ascii?Q?KKrEhFrKC6QqCKgQoG0zYWAexlLQ/ttXCNvFL5pNXPMCiVTQMdHf7xPcfYnJ?=
 =?us-ascii?Q?wNMfnPNH80aHNiAy38FybwE7zgzUQZXPGmpg/CuOPRtUjimqeYzTBF0WHOLa?=
 =?us-ascii?Q?ROaeojCkhdKRv1S7/DOQDb9/bPwP7VMKDPYlAVka3b65JqHLr1OQVrVKIzxq?=
 =?us-ascii?Q?7ozRnLUXD+9A8jaDPo+PXXCpD7yT3IWZTjZ84VUKnZsEIi5CcwRQxpSYOuVF?=
 =?us-ascii?Q?5ST1O5yW/84fC6QvDiyHefsg8cgrmhW9C/6mRp5b3y2IJYPgZ3uujPINAcnX?=
 =?us-ascii?Q?c2btqrTXdeZ5OdAZQ4UEL4erAu8rY7ul/ouTcRKFIfAH/POE2xSIt9+txt49?=
 =?us-ascii?Q?dtZZEy6NyfBI2kHb+1XYYpq0ENvc7YATrhB/cAYtQFzDvyBY/sGM7jlhxNsD?=
 =?us-ascii?Q?ESsu9greNJrjgZQZtelX2pBKIz/yyOX4KHZoGtSfDcwCJhlWWhfybCImtcn2?=
 =?us-ascii?Q?9f0Bk47aOt5Uolyz62l4UbnCm+EXFnYcjTMwBYtUpOzeBUgVPBfgLR2cjog9?=
 =?us-ascii?Q?RA1872WI4KGZ1HkFQt9wXAKGwj0NraH26LMDHGU8mKKqMK9rKJsuiuFXL2ZV?=
 =?us-ascii?Q?WAtBtiQitphciMjulpykH7scZX7+zyWH+/Fmje5HF4jBD4CAG0XNTSDuHuiH?=
 =?us-ascii?Q?uCnjOAirTrVRyNu0pwSvZgJNOZJaI0PAFJwMs8D7/Y08Sh+rapWvrshPVUmD?=
 =?us-ascii?Q?qnSoawStnUcX2ke7Ml5vXMTaD5x9OPvAaPDw/5H87e7IK+8oEp77gJB6fFCR?=
 =?us-ascii?Q?YDAbp813ObuJHsLQCYbQ49b5+VnNcC6YB+2m/f0edSPsSFdZx3T+5gclEgTx?=
 =?us-ascii?Q?fFEv5dpPJXUYrYsLnsxuZ0pp59KzJ//IJoZmFBD84pOOGV7gw6Fbljus/3U3?=
 =?us-ascii?Q?XGGnArWVrxERa9IwkxD0heDilbEBKQkxCwmOoadtYbmywNt60DxKV8RRKP+O?=
 =?us-ascii?Q?ky51QSenmL2PIZuDe1LMWHyGqfpi3CWUfGQmt9u/gxgJm1av2LgiqrnVqPX8?=
 =?us-ascii?Q?tiu2R/3RR0Oofi2ws/mi+hvMs/60Wj08iE+AmHUSurzbFn9zCC9vaE6ZiBb3?=
 =?us-ascii?Q?TPYuv2r7dMVUEMby90W2uB5hJ5rLWooStmyyhTSv?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: PH7PR11MB5941.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: becbc485-0f06-49c6-92bb-08dc3d7b0b31
X-MS-Exchange-CrossTenant-originalarrivaltime: 06 Mar 2024 01:16:25.7633 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: S5ZlLG+Gx8ZS2+c7JIUoD3nYdlPj1nSU1N52+Q5SsbJ5jG2OfDY+WVssfTJMXPRgU1qMbR1+xqSONfPrwKppaQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SN7PR11MB7114
X-OriginatorOrg: intel.com
Received-SPF: pass client-ip=198.175.65.9; envelope-from=yuan1.liu@intel.com;
 helo=mgamail.intel.com
X-Spam_score_int: -26
X-Spam_score: -2.7
X-Spam_bar: --
X-Spam_report: (-2.7 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.568,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
 T_SCC_BODY_TEXT_LINE=-0.01 autolearn=ham autolearn_force=no
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
> Sent: Wednesday, March 6, 2024 4:24 AM
> To: Liu, Yuan1 <yuan1.liu@intel.com>; peterx@redhat.com
> Cc: qemu-devel@nongnu.org; hao.xiang@bytedance.com;
> bryan.zhang@bytedance.com; Liu, Yuan1 <yuan1.liu@intel.com>; Zou, Nanhai
> <nanhai.zou@intel.com>
> Subject: Re: [PATCH v4 2/8] migration/multifd: add get_iov_count in the
> multifd method
>=20
> Yuan Liu <yuan1.liu@intel.com> writes:
>=20
> > the new function get_iov_count is used to get the number of
> > IOVs required by a specified multifd method
> >
> > Different multifd methods may require different numbers of IOVs.
> > Based on streaming compression of zlib and zstd, all pages will be
> > compressed to a data block, so an IOV is required to send this data
> > block. For no compression, each IOV is used to send a page, so the
> > number of IOVs required is the same as the number of pages.
>=20
> Let's just move the responsibility of allocating p->iov to the client
> code. You can move the allocation into send_setup() and the free into
> send_cleanup().

Yes, this is a good way, I will implement it in the next version

> >
> > Signed-off-by: Yuan Liu <yuan1.liu@intel.com>
> > Reviewed-by: Nanhai Zou <nanhai.zou@intel.com>
> > ---
> >  migration/multifd-zlib.c | 18 +++++++++++++++++-
> >  migration/multifd-zstd.c | 18 +++++++++++++++++-
> >  migration/multifd.c      | 24 +++++++++++++++++++++---
> >  migration/multifd.h      |  2 ++
> >  4 files changed, 57 insertions(+), 5 deletions(-)
> >
> > diff --git a/migration/multifd-zlib.c b/migration/multifd-zlib.c
> > index 012e3bdea1..35187f2aff 100644
> > --- a/migration/multifd-zlib.c
> > +++ b/migration/multifd-zlib.c
> > @@ -313,13 +313,29 @@ static int zlib_recv_pages(MultiFDRecvParams *p,
> Error **errp)
> >      return 0;
> >  }
> >
> > +/**
> > + * zlib_get_iov_count: get the count of IOVs
> > + *
> > + * For zlib streaming compression, all pages will be compressed into a
> data
> > + * block, and an IOV is requested for sending this block.
> > + *
> > + * Returns the count of the IOVs
> > + *
> > + * @page_count: Indicate the maximum count of pages processed by
> multifd
> > + */
> > +static uint32_t zlib_get_iov_count(uint32_t page_count)
> > +{
> > +    return 1;
> > +}
> > +
> >  static MultiFDMethods multifd_zlib_ops =3D {
> >      .send_setup =3D zlib_send_setup,
> >      .send_cleanup =3D zlib_send_cleanup,
> >      .send_prepare =3D zlib_send_prepare,
> >      .recv_setup =3D zlib_recv_setup,
> >      .recv_cleanup =3D zlib_recv_cleanup,
> > -    .recv_pages =3D zlib_recv_pages
> > +    .recv_pages =3D zlib_recv_pages,
> > +    .get_iov_count =3D zlib_get_iov_count
> >  };
> >
> >  static void multifd_zlib_register(void)
> > diff --git a/migration/multifd-zstd.c b/migration/multifd-zstd.c
> > index dc8fe43e94..25ed1add2a 100644
> > --- a/migration/multifd-zstd.c
> > +++ b/migration/multifd-zstd.c
> > @@ -304,13 +304,29 @@ static int zstd_recv_pages(MultiFDRecvParams *p,
> Error **errp)
> >      return 0;
> >  }
> >
> > +/**
> > + * zstd_get_iov_count: get the count of IOVs
> > + *
> > + * For zstd streaming compression, all pages will be compressed into a
> data
> > + * block, and an IOV is requested for sending this block.
> > + *
> > + * Returns the count of the IOVs
> > + *
> > + * @page_count: Indicate the maximum count of pages processed by
> multifd
> > + */
> > +static uint32_t zstd_get_iov_count(uint32_t page_count)
> > +{
> > +    return 1;
> > +}
> > +
> >  static MultiFDMethods multifd_zstd_ops =3D {
> >      .send_setup =3D zstd_send_setup,
> >      .send_cleanup =3D zstd_send_cleanup,
> >      .send_prepare =3D zstd_send_prepare,
> >      .recv_setup =3D zstd_recv_setup,
> >      .recv_cleanup =3D zstd_recv_cleanup,
> > -    .recv_pages =3D zstd_recv_pages
> > +    .recv_pages =3D zstd_recv_pages,
> > +    .get_iov_count =3D zstd_get_iov_count
> >  };
> >
> >  static void multifd_zstd_register(void)
> > diff --git a/migration/multifd.c b/migration/multifd.c
> > index adfe8c9a0a..787402247e 100644
> > --- a/migration/multifd.c
> > +++ b/migration/multifd.c
> > @@ -209,13 +209,29 @@ static int nocomp_recv_pages(MultiFDRecvParams *p=
,
> Error **errp)
> >      return qio_channel_readv_all(p->c, p->iov, p->normal_num, errp);
> >  }
> >
> > +/**
> > + * nocomp_get_iov_count: get the count of IOVs
> > + *
> > + * For no compression, the count of IOVs required is the same as the
> count of
> > + * pages
> > + *
> > + * Returns the count of the IOVs
> > + *
> > + * @page_count: Indicate the maximum count of pages processed by
> multifd
> > + */
> > +static uint32_t nocomp_get_iov_count(uint32_t page_count)
> > +{
> > +    return page_count;
> > +}
> > +
> >  static MultiFDMethods multifd_nocomp_ops =3D {
> >      .send_setup =3D nocomp_send_setup,
> >      .send_cleanup =3D nocomp_send_cleanup,
> >      .send_prepare =3D nocomp_send_prepare,
> >      .recv_setup =3D nocomp_recv_setup,
> >      .recv_cleanup =3D nocomp_recv_cleanup,
> > -    .recv_pages =3D nocomp_recv_pages
> > +    .recv_pages =3D nocomp_recv_pages,
> > +    .get_iov_count =3D nocomp_get_iov_count
> >  };
> >
> >  static MultiFDMethods *multifd_ops[MULTIFD_COMPRESSION__MAX] =3D {
> > @@ -998,6 +1014,8 @@ bool multifd_send_setup(void)
> >      Error *local_err =3D NULL;
> >      int thread_count, ret =3D 0;
> >      uint32_t page_count =3D MULTIFD_PACKET_SIZE /
> qemu_target_page_size();
> > +    /* We need one extra place for the packet header */
> > +    uint32_t iov_count =3D 1;
> >      uint8_t i;
> >
> >      if (!migrate_multifd()) {
> > @@ -1012,6 +1030,7 @@ bool multifd_send_setup(void)
> >      qemu_sem_init(&multifd_send_state->channels_ready, 0);
> >      qatomic_set(&multifd_send_state->exiting, 0);
> >      multifd_send_state->ops =3D
> multifd_ops[migrate_multifd_compression()];
> > +    iov_count +=3D multifd_send_state->ops->get_iov_count(page_count);
> >
> >      for (i =3D 0; i < thread_count; i++) {
> >          MultiFDSendParams *p =3D &multifd_send_state->params[i];
> > @@ -1026,8 +1045,7 @@ bool multifd_send_setup(void)
> >          p->packet->magic =3D cpu_to_be32(MULTIFD_MAGIC);
> >          p->packet->version =3D cpu_to_be32(MULTIFD_VERSION);
> >          p->name =3D g_strdup_printf("multifdsend_%d", i);
> > -        /* We need one extra place for the packet header */
> > -        p->iov =3D g_new0(struct iovec, page_count + 1);
> > +        p->iov =3D g_new0(struct iovec, iov_count);
> >          p->page_size =3D qemu_target_page_size();
> >          p->page_count =3D page_count;
> >          p->write_flags =3D 0;
> > diff --git a/migration/multifd.h b/migration/multifd.h
> > index 8a1cad0996..d82495c508 100644
> > --- a/migration/multifd.h
> > +++ b/migration/multifd.h
> > @@ -201,6 +201,8 @@ typedef struct {
> >      void (*recv_cleanup)(MultiFDRecvParams *p);
> >      /* Read all pages */
> >      int (*recv_pages)(MultiFDRecvParams *p, Error **errp);
> > +    /* Get the count of required IOVs */
> > +    uint32_t (*get_iov_count)(uint32_t page_count);
> >  } MultiFDMethods;
> >
> >  void multifd_register_ops(int method, MultiFDMethods *ops);

