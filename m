Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1B4DBD132B5
	for <qemu-devel@archiver.kernel.org>; Mon,  4 Nov 2024 12:04:32 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1t7vo5-0000NP-7u; Mon, 04 Nov 2024 07:03:41 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <zhenzhong.duan@intel.com>)
 id 1t7vnn-0008Vm-1t
 for qemu-devel@nongnu.org; Mon, 04 Nov 2024 07:03:25 -0500
Received: from mgamail.intel.com ([192.198.163.15])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <zhenzhong.duan@intel.com>)
 id 1t7vnj-0004Ma-Mr
 for qemu-devel@nongnu.org; Mon, 04 Nov 2024 07:03:22 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1730721800; x=1762257800;
 h=from:to:cc:subject:date:message-id:references:
 in-reply-to:content-transfer-encoding:mime-version;
 bh=ZpVeWMWRqYEd0G131+25q6bJFtF5GFJ99d6rfqz27XE=;
 b=CRMvhHf9zDe+YQzCLFsZqBCbJPGXwVtb+fcoEFVSR/dV2jhdH0hxe5uy
 xqBiXRdO5eQjjbrQO/kB/iZj/A1m9kK5ncuPPHexSrp2cWeok6vhWNVt0
 FHXx8zP7jI2XJl6AuGsNELirmE+msK+rnsbnl5M9WB2GTCIqHJY2IItu/
 oYQ+CC7A+NPrMHUFmcZr4fPpvx6OsNYjk2pfMBzt94UBGdsUdDDuPkpRr
 tT+SuFM5HDgUnRryhe6PmbJ6QS9//YaOOOAGfnlBSjFg1ctRoxL1r0I0i
 hS5IQBN8479SPKsuEiTA6l7BuaS5bDLv2ofsRIUQGvlQedarFYKXnqR3x Q==;
X-CSE-ConnectionGUID: s19rLr6NQte/86uLrrB2wQ==
X-CSE-MsgGUID: 9bfdWbjrSMikdevXvLpFww==
X-IronPort-AV: E=McAfee;i="6700,10204,11245"; a="30524216"
X-IronPort-AV: E=Sophos;i="6.11,257,1725346800"; d="scan'208";a="30524216"
Received: from orviesa010.jf.intel.com ([10.64.159.150])
 by fmvoesa109.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 04 Nov 2024 04:03:17 -0800
X-CSE-ConnectionGUID: RS6majgqR7K7BH8uMk9JgQ==
X-CSE-MsgGUID: kldIkQdyS26Yg8ccViBD6A==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.11,257,1725346800"; d="scan'208";a="83567587"
Received: from fmsmsx603.amr.corp.intel.com ([10.18.126.83])
 by orviesa010.jf.intel.com with ESMTP/TLS/AES256-GCM-SHA384;
 04 Nov 2024 04:03:16 -0800
Received: from fmsmsx601.amr.corp.intel.com (10.18.126.81) by
 fmsmsx603.amr.corp.intel.com (10.18.126.83) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.39; Mon, 4 Nov 2024 04:03:15 -0800
Received: from fmsedg601.ED.cps.intel.com (10.1.192.135) by
 fmsmsx601.amr.corp.intel.com (10.18.126.81) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.39 via Frontend Transport; Mon, 4 Nov 2024 04:03:15 -0800
Received: from NAM02-SN1-obe.outbound.protection.outlook.com (104.47.57.41) by
 edgegateway.intel.com (192.55.55.70) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.39; Mon, 4 Nov 2024 04:03:15 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=rfS0fX5geKZ73rvqe0iCKv0nPi9plAUkYIXigoaTdLR+c3iCQzHTqOY9JOQ48rEiOVaV5OAOwgb7H+gQ9UKvjpIwj37W6oSExm3c65qjgGyv7H544DGjOJVe/H2rQ+ZT7xV8zakov6dY30h8D7HGN47pOZe02WLdqe1G2zR0eET4KDK24ycg9OcZfAs5QuPGJdzoEHyqh7m2a8mg+u64N22typuYic53U76x/4CakzAj5QxRB8BTdkKZf67HOzjMkvZ2uDIVov/A6lrowjl+F7kyE+TK5qZGOa2cRxkRV6eyeq3li6dE3I4ou0QAbgC6ang0pE9Yg3CCV+4SK9z6hA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=wTTfZ/zwQkUMB41JCmaPXUBN1rvjr16m59mpcCLjkFM=;
 b=U770UUAJ2uDrb/saKmrNwLYTML+LdvGIcq2poOj+tBVXSSFxKfJahAXMQs8VYmeWl7DcxHASv0KYeTAmrVUlEO3krxSkpIqusFc9w99Kaxz42xJsHm4G4GuToRqVuB30ypJG5s/HJx3zDJ1IRWLq1Wbfy+NxnyRxZlS0/pbNAPoxClXKfmmbyTde4iNxc3OMST4y0O+x8aRJOOVN01iTLmUSW2u6t+rtl1g0Olgme6AfkivhbwYpYbTKkgetQSCdt/bDHAcfMQvFY9kXlokY7aDWtsTTpSn0CZiNAkxxpC+Y3pej1PxCMXz3IlPHojz0sM4m5Ez63QO0E5xI9Ov6VA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Received: from SJ0PR11MB6744.namprd11.prod.outlook.com (2603:10b6:a03:47d::10)
 by CO1PR11MB4897.namprd11.prod.outlook.com (2603:10b6:303:97::20)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8114.31; Mon, 4 Nov
 2024 12:03:13 +0000
Received: from SJ0PR11MB6744.namprd11.prod.outlook.com
 ([fe80::fe49:d628:48b1:6091]) by SJ0PR11MB6744.namprd11.prod.outlook.com
 ([fe80::fe49:d628:48b1:6091%5]) with mapi id 15.20.8114.028; Mon, 4 Nov 2024
 12:03:12 +0000
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
Thread-Index: AQHbExtWwxmDUGznNEuh9QEgt9JZFbKmoiIAgABQaICAABLpAIAAMdxwgAACCQCAAABSIIAAAqOAgAAAZhA=
Date: Mon, 4 Nov 2024 12:03:12 +0000
Message-ID: <SJ0PR11MB67445A374E7CB950B30BD45A92512@SJ0PR11MB6744.namprd11.prod.outlook.com>
References: <20240930092631.2997543-1-zhenzhong.duan@intel.com>
 <20240930092631.2997543-5-zhenzhong.duan@intel.com>
 <3bb9da3b-f1de-4a3a-bdd8-37937ed15d50@intel.com>
 <14799ff1-8da4-4b42-921a-ad1198de1bdb@eviden.com>
 <119078eb-81f0-47a7-81b0-aaf6b7878581@intel.com>
 <SJ0PR11MB674422638A5915D608E9A80992512@SJ0PR11MB6744.namprd11.prod.outlook.com>
 <20241104065029-mutt-send-email-mst@kernel.org>
 <SJ0PR11MB6744765C7F68ABF7449E73F492512@SJ0PR11MB6744.namprd11.prod.outlook.com>
 <20241104070102-mutt-send-email-mst@kernel.org>
In-Reply-To: <20241104070102-mutt-send-email-mst@kernel.org>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: SJ0PR11MB6744:EE_|CO1PR11MB4897:EE_
x-ms-office365-filtering-correlation-id: cb06d7d5-9677-413d-0297-08dcfcc8a871
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
 ARA:13230040|366016|1800799024|376014|7416014|38070700018; 
x-microsoft-antispam-message-info: =?iso-8859-1?Q?PVkgPIuWjsXeNKmPtFYTBnRORRMFolQrqK3j+5oL502xMbvHWMg4R5Qgrn?=
 =?iso-8859-1?Q?+yKjNrb61yCMdhqpTEnFhN0+8A0VmFqOgT1yZQ9WYPi/rsmBhT7P8UrLef?=
 =?iso-8859-1?Q?tMRaoJyzWvpDeNJnf2fC88vXhq65OOtmUfw1+8EQo74cfg5n8UKID1kx45?=
 =?iso-8859-1?Q?zwFbXGn/0N40axbtlzZon8mu5WooeFZoFxQUJZtUg7T4pMIZiDBFRYV5wf?=
 =?iso-8859-1?Q?tNEac9o6tVuTLTBCx+P9kYkvouHg8romNc4HKLIh6fpnuE5JVfd3e6ow3d?=
 =?iso-8859-1?Q?Zd2+KMnLCjt+lsp6iHwNyuMr5Ur08vaT/a7bGu35x/B5GGT1lkZK8NlcJE?=
 =?iso-8859-1?Q?QtOIwE30qM84jxf6vuSK0CgiKC8/8HJ7qgPNSb7cOKGaTgnsQUKk4RyarM?=
 =?iso-8859-1?Q?OtpAlagtY0ZcfztZ9wbqUjn4IHsZtBwDjejM3aFSugQf3l2VyW7mRWlReK?=
 =?iso-8859-1?Q?59v4qddztirXdiHGaWyL7T2M+lMINf7yDLuQ/AVk9QMFBPm8OYpyXdM+sF?=
 =?iso-8859-1?Q?0Cx87vz6YcFIOL/AHetVKXHJ57UJ8jb7zuq0VjnQLKQ5HYxPZ5CPc8TeMJ?=
 =?iso-8859-1?Q?nc+6WrJjr75d4zuxUOzNBZJBZjYaoEVT9GbUvDE4qem0jFF+uBmQ7TQ7zI?=
 =?iso-8859-1?Q?4gyPIwdtZUwGy6nlLXcxU5FiFEEtrDGTpTOc+NTHhqzHq995xel9gxEZgT?=
 =?iso-8859-1?Q?ET7a9KICN6yvb0lnY9tEazOM/IfYUG53OvKwapYAjzpNNAts3MInUntc5Z?=
 =?iso-8859-1?Q?fBOi9//9YCe7xE4NexpvVVABrts+Yp12ZZbN4jAdaxIqn2hmm8yPfeVog3?=
 =?iso-8859-1?Q?YNHjeEUEzqf4qQjTCMhxs1Mw5/iEMBqIE5FLy+h1w1k0yvpxTrkTfeYx+D?=
 =?iso-8859-1?Q?DUkda4XYivFgv/Cr97DPw8fXLDdFCShDdYMlpmf7cAwwve64PFP+ENH7GO?=
 =?iso-8859-1?Q?ibtX6FM3BdcRGqP6MxjofkTTFxQ7nXxUCFf9ZIlhcNzMTHtIfJ4fk1kfk+?=
 =?iso-8859-1?Q?nqllV7ijHgYh0Z7LPkrAG6nSiJlbqNVOt47MAExBue5mR18DdegZ6KMxnr?=
 =?iso-8859-1?Q?C3WYxn5V6Xqvbc0m3Nf3qLUZPWxXSj5l6W8c0I9oC5F19Mdq2/oY6oswbT?=
 =?iso-8859-1?Q?sUBTxEstUPwSL86gbj2ym3CpFytL+6zA9zLUtNFqyhTJ6YOGErCbWDaTKb?=
 =?iso-8859-1?Q?zCCSIH7tq++ixAo4YAiI9NfJ/O0nIdVQhj+sFwyht04QGSgqqGFlfXBIRd?=
 =?iso-8859-1?Q?3ZKOET+gGsxfDT2yj0i91UeYeNzfOKTbEhbzLUNka3P/dnk5R9nVZ+/mK+?=
 =?iso-8859-1?Q?qNo4pdWY8q1YT9+vKHFHlpKtMR/SgfF4yMKTBzbZcMoPjPZ65bFgZXpWgT?=
 =?iso-8859-1?Q?IX2RGJJJNNvoiS93SMUFqHLHCu9661G/Q8yHECEqvKGs5iIV14Wng=3D?=
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:SJ0PR11MB6744.namprd11.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(366016)(1800799024)(376014)(7416014)(38070700018); DIR:OUT;
 SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?iso-8859-1?Q?A2UlCo6VLv8XAqPjL223AEzPp/5Eq+3Saw0hgx9k/HQKQkPgxiZOMvalPe?=
 =?iso-8859-1?Q?KYL1D1Y7BEcKfs7Bu09PiVxDwPT5B+MLPranW5EI4EDwOuhrdWQiuvZonf?=
 =?iso-8859-1?Q?Mq9cN3hVrHbfJ2NInTL8GqXHQ9G4SmfpzSZNT033iuYKDXSyEMl7CJJwl2?=
 =?iso-8859-1?Q?UqViX+aC0io9ZPA5U0GfNZUpv3vJjHTYwRijUfbz5CQo+Z4OJhYqCwqB+l?=
 =?iso-8859-1?Q?QA89tDR1Z8Xq1KgyjOZ92IuRw2W0HftMliNAugyJjjnN5oz0MFtq8p9Oat?=
 =?iso-8859-1?Q?6G7qn4go0gLCEBEB7iMwzem2QTUbgM3SX9LHSXY90dtdEGoH+FidngquBI?=
 =?iso-8859-1?Q?MdlWmVaZpn677OxEqEhX18PXYO02X0mrnuipu8jDv9a5V5tfH75b7Sffci?=
 =?iso-8859-1?Q?VdnuFQlDDEqmUM2cd+ALJ+1NP+HU3Yb7VX7S2UgSwOI0Ms81Yygr/Ygc3g?=
 =?iso-8859-1?Q?asb0o/Cr48eZLLmUYwK1BSBgfoZUx2gK/vbCe+uCr3+C5HCuFYaIZ+7Aqi?=
 =?iso-8859-1?Q?iyzQz/1+MjW4xPkZqPEvZeOLMCztBrrEvIDeHPzQ2Fs2jWJ/odmJk+Il6i?=
 =?iso-8859-1?Q?GdG0E8b1o9TsZki14RbuBfhUVHI0pKGJigM+fewFCZXpTd7Im1le0yaVLW?=
 =?iso-8859-1?Q?J57UijIFjirJyyZ/ZjUbK39qId99FSKYKWlag/kdCNahTTc3hYGs4Z4TIi?=
 =?iso-8859-1?Q?vfXebM21nSWpPbCAW6Vy2mNpuoUnuMVjz3xhv7v0g1WLjpIChcMQRjAnnE?=
 =?iso-8859-1?Q?m5ZT2M5zE25oME2hJyeKArsZf2J1nb6U2XlVNla9UdVAKKPuhT+PDQ3t/V?=
 =?iso-8859-1?Q?3kNBhNCjA4Cjl24mJco10ScE7VPS2MsaAp7yG0KimyqXmw1mlc9smVh9uh?=
 =?iso-8859-1?Q?1CLTh/sMU8UIwOLlZkhZXWLG5AkF1KGAUz70p34SzTU20heM6Dg3NmvqAL?=
 =?iso-8859-1?Q?u46wWkIkjZsxzD5/T3HDkB/nzysyqleZ3y9Krc8CCuRltNI9hGk6OssvZC?=
 =?iso-8859-1?Q?U5nnbCaigzNqU5FjkZBEEDFvbpBebkBYNWH9NTazF1iXdSoB8PF9vKzzdS?=
 =?iso-8859-1?Q?GaAddk2vHN6qM1x5knA5GEmDH6qjEhTFeCKu3aVCls7JXZbKCVN5N5xBD8?=
 =?iso-8859-1?Q?JY974bc/KhZ3yooCuPYtJ16MPFDZ8h37o5eT4NhAFtBx/9wPVkmXDXbnd+?=
 =?iso-8859-1?Q?BeTZCyM2MTBtITg9xGvN4JGj3Uz1rxjk5nr6udGth+7UJRW3XhJ3UWUq+z?=
 =?iso-8859-1?Q?wDDcPwSSKMEuW79krv8kVyK19Z3WujpfMukVFJh8MI3BGa0sIygeOMd8yJ?=
 =?iso-8859-1?Q?2bjmO6JRo+jcL1DvYh8wCXzrywmaod+uXzhGJlzZ+Ypfc8/2n5qFsVoxvo?=
 =?iso-8859-1?Q?GStl/RvHH+u3rMDPu5YQQvCbOXPEIC38XpZIyznZfdQLODScMrvssDw9K0?=
 =?iso-8859-1?Q?ciPIPvMpJ5g2g+4TKYV8cNuHmBqpJOerM109PGVsZYMxhQsRCyLXh8kgJ+?=
 =?iso-8859-1?Q?7zWQR+FvpXOAHByZ5V1ht1bE4wM+JSBL0dFHzQOnC+DkHh1MvOxE+LVoDj?=
 =?iso-8859-1?Q?nnnR29T0onBvyKh0Z2zJoIeqtQgsV6qO5e9iWorcHOg16LGWjebn5wDpna?=
 =?iso-8859-1?Q?0L5628OuW9ZJUFn3EAFu69+X2UykaR/THx?=
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: SJ0PR11MB6744.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: cb06d7d5-9677-413d-0297-08dcfcc8a871
X-MS-Exchange-CrossTenant-originalarrivaltime: 04 Nov 2024 12:03:12.9204 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: Ez8TjAKqXSezlikLu/PKJV0cFf7jkv7JdRl3AKNdAda2UzfDA7ALhfQJ+yKs+GDIzJcAUTNhn04toHvGhLXjlR1TrqTM7ePwSUinbmolYG0=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CO1PR11MB4897
X-OriginatorOrg: intel.com
Received-SPF: pass client-ip=192.198.163.15;
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
>Sent: Monday, November 4, 2024 8:01 PM
>Subject: Re: [PATCH v4 04/17] intel_iommu: Flush stage-2 cache in PASID-
>selective PASID-based iotlb invalidation
>
>On Mon, Nov 04, 2024 at 11:55:39AM +0000, Duan, Zhenzhong wrote:
>>
>>
>> >-----Original Message-----
>> >From: Michael S. Tsirkin <mst@redhat.com>
>> >Sent: Monday, November 4, 2024 7:51 PM
>> >Subject: Re: [PATCH v4 04/17] intel_iommu: Flush stage-2 cache in PASID=
-
>> >selective PASID-based iotlb invalidation
>> >
>> >On Mon, Nov 04, 2024 at 11:46:00AM +0000, Duan, Zhenzhong wrote:
>> >>
>> >>
>> >> >-----Original Message-----
>> >> >From: Liu, Yi L <yi.l.liu@intel.com>
>> >> >Sent: Monday, November 4, 2024 4:45 PM
>> >> >Subject: Re: [PATCH v4 04/17] intel_iommu: Flush stage-2 cache in PA=
SID-
>> >> >selective PASID-based iotlb invalidation
>> >> >
>> >> >On 2024/11/4 15:37, CLEMENT MATHIEU--DRIF wrote:
>> >> >>
>> >> >>
>> >> >> On 04/11/2024 03:49, Yi Liu wrote:
>> >> >>> Caution: External email. Do not open attachments or click links, =
unless
>> >> >>> this email comes from a known sender and you know the content is =
safe.
>> >> >>>
>> >> >>>
>> >> >>> On 2024/9/30 17:26, Zhenzhong Duan wrote:
>> >> >>>> Per spec 6.5.2.4, PADID-selective PASID-based iotlb invalidation=
 will
>> >> >>>> flush stage-2 iotlb entries with matching domain id and pasid.
>> >> >>>
>> >> >>> Also, call out it's per table Table 21. PASID-based-IOTLB Invalid=
ation of
>> >> >>> VT-d spec 4.1.
>> >> >>>
>> >> >>>> With scalable modern mode introduced, guest could send PASID-
>selective
>> >> >>>> PASID-based iotlb invalidation to flush both stage-1 and stage-2=
 entries.
>> >> >>>>
>> >> >>>> By this chance, remove old IOTLB related definitions which were
>unused.
>> >> >>>
>> >> >>>
>> >> >>>> Signed-off-by: Zhenzhong Duan <zhenzhong.duan@intel.com>
>> >> >>>> Reviewed-by: Cl=E9ment Mathieu--Drif<clement.mathieu--
>drif@eviden.com>
>> >> >>>> Acked-by: Jason Wang <jasowang@redhat.com>
>> >> >>>> ---
>> >> >>>>  =A0 hw/i386/intel_iommu_internal.h | 14 ++++--
>> >> >>>>  =A0 hw/i386/intel_iommu.c=A0=A0=A0=A0=A0=A0=A0=A0=A0 | 88
>> >+++++++++++++++++++++++++++++++++-
>> >> >>>>  =A0 2 files changed, 96 insertions(+), 6 deletions(-)
>> >> >>>>
>> >> >>>> diff --git a/hw/i386/intel_iommu_internal.h b/hw/i386/
>> >> >>>> intel_iommu_internal.h
>> >> >>>> index d0f9d4589d..eec8090190 100644
>> >> >>>> --- a/hw/i386/intel_iommu_internal.h
>> >> >>>> +++ b/hw/i386/intel_iommu_internal.h
>> >> >>>> @@ -403,11 +403,6 @@ typedef union VTDInvDesc VTDInvDesc;
>> >> >>>>  =A0 #define VTD_INV_DESC_IOTLB_AM(val)=A0=A0=A0=A0=A0 ((val) & =
0x3fULL)
>> >> >>>>  =A0 #define VTD_INV_DESC_IOTLB_RSVD_LO=A0=A0=A0=A0=A0 0xfffffff=
f0000f100ULL
>> >> >>>>  =A0 #define VTD_INV_DESC_IOTLB_RSVD_HI=A0=A0=A0=A0=A0 0xf80ULL
>> >> >>>> -#define VTD_INV_DESC_IOTLB_PASID_PASID=A0 (2ULL << 4)
>> >> >>>> -#define VTD_INV_DESC_IOTLB_PASID_PAGE=A0=A0 (3ULL << 4)
>> >> >>>> -#define VTD_INV_DESC_IOTLB_PASID(val)=A0=A0 (((val) >> 32) &
>> >> >>>> VTD_PASID_ID_MASK)
>> >> >>>> -#define
>> >VTD_INV_DESC_IOTLB_PASID_RSVD_LO=A0=A0=A0=A0=A0 0xfff00000000001c0ULL
>> >> >>>> -#define VTD_INV_DESC_IOTLB_PASID_RSVD_HI=A0=A0=A0=A0=A0 0xf80UL=
L
>> >> >>>>
>> >> >>>>  =A0 /* Mask for Device IOTLB Invalidate Descriptor */
>> >> >>>>  =A0 #define VTD_INV_DESC_DEVICE_IOTLB_ADDR(val) ((val) &
>> >> >>>> 0xfffffffffffff000ULL)
>> >> >>>> @@ -433,6 +428,15 @@ typedef union VTDInvDesc VTDInvDesc;
>> >> >>>>  =A0 #define VTD_SPTE_LPAGE_L3_RSVD_MASK(aw) \
>> >> >>>>  =A0=A0=A0=A0=A0=A0=A0=A0=A0 (0x3ffff800ULL | ~(VTD_HAW_MASK(aw)=
 | VTD_SL_IGN_COM))
>> >> >>>>
>> >> >>>> +/* Masks for PIOTLB Invalidate Descriptor */
>> >> >>>> +#define VTD_INV_DESC_PIOTLB_G=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=
=A0 (3ULL << 4)
>> >> >>>> +#define VTD_INV_DESC_PIOTLB_ALL_IN_PASID=A0 (2ULL << 4)
>> >> >>>> +#define VTD_INV_DESC_PIOTLB_PSI_IN_PASID=A0 (3ULL << 4)
>> >> >>>> +#define VTD_INV_DESC_PIOTLB_DID(val)=A0=A0=A0=A0=A0 (((val) >> =
16) &
>> >> >>>> VTD_DOMAIN_ID_MASK)
>> >> >>>> +#define VTD_INV_DESC_PIOTLB_PASID(val)=A0=A0=A0 (((val) >> 32) =
&
>0xfffffULL)
>> >> >>>> +#define
>VTD_INV_DESC_PIOTLB_RSVD_VAL0=A0=A0=A0=A0 0xfff000000000f1c0ULL
>> >> >>>> +#define VTD_INV_DESC_PIOTLB_RSVD_VAL1=A0=A0=A0=A0 0xf80ULL
>> >> >>>> +
>> >> >>>>  =A0 /* Information about page-selective IOTLB invalidate */
>> >> >>>>  =A0 struct VTDIOTLBPageInvInfo {
>> >> >>>>  =A0=A0=A0=A0=A0 uint16_t domain_id;
>> >> >>>> diff --git a/hw/i386/intel_iommu.c b/hw/i386/intel_iommu.c
>> >> >>>> index 9e6ef0cb99..72c9c91d4f 100644
>> >> >>>> --- a/hw/i386/intel_iommu.c
>> >> >>>> +++ b/hw/i386/intel_iommu.c
>> >> >>>> @@ -2656,6 +2656,86 @@ static bool
>> >> >>>> vtd_process_iotlb_desc(IntelIOMMUState *s, VTDInvDesc *inv_desc)
>> >> >>>>  =A0=A0=A0=A0=A0 return true;
>> >> >>>>  =A0 }
>> >> >>>>
>> >> >>>> +static gboolean vtd_hash_remove_by_pasid(gpointer key, gpointer
>value,
>> >> >>>> +=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=
=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 gpointer user_dat=
a)
>> >> >>>> +{
>> >> >>>> +=A0=A0=A0 VTDIOTLBEntry *entry =3D (VTDIOTLBEntry *)value;
>> >> >>>> +=A0=A0=A0 VTDIOTLBPageInvInfo *info =3D (VTDIOTLBPageInvInfo *)=
user_data;
>> >> >>>> +
>> >> >>>> +=A0=A0=A0 return ((entry->domain_id =3D=3D info->domain_id) &&
>> >> >>>> +=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 (entry->pasid =3D=3D info->pa=
sid));
>> >> >>>> +}
>> >> >>>> +
>> >> >>>> +static void vtd_piotlb_pasid_invalidate(IntelIOMMUState *s,
>> >> >>>> +=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=
=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 uint16_t domain_id, =
uint32_t
>> >> >>>> pasid)
>> >> >>>> +{
>> >> >>>> +=A0=A0=A0 VTDIOTLBPageInvInfo info;
>> >> >>>> +=A0=A0=A0 VTDAddressSpace *vtd_as;
>> >> >>>> +=A0=A0=A0 VTDContextEntry ce;
>> >> >>>> +
>> >> >>>> +=A0=A0=A0 info.domain_id =3D domain_id;
>> >> >>>> +=A0=A0=A0 info.pasid =3D pasid;
>> >> >>>> +
>> >> >>>> +=A0=A0=A0 vtd_iommu_lock(s);
>> >> >>>> +=A0=A0=A0 g_hash_table_foreach_remove(s->iotlb,
>vtd_hash_remove_by_pasid,
>> >> >>>> +=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=
=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 &info);
>> >> >>>> +=A0=A0=A0 vtd_iommu_unlock(s);
>> >> >>>> +
>> >> >>>> +=A0=A0=A0 QLIST_FOREACH(vtd_as, &s->vtd_as_with_notifiers, next=
) {
>> >> >>>> +=A0=A0=A0=A0=A0=A0=A0 if (!vtd_dev_to_context_entry(s, pci_bus_=
num(vtd_as->bus),
>> >> >>>> +=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=
=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 vtd_as->devfn, &ce) &&
>> >> >>>> +=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 domain_id =3D=3D vtd_get_doma=
in_id(s, &ce, vtd_as->pasid)) {
>> >> >>>> +=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 uint32_t rid2pasid =3D VTD_CE=
_GET_RID2PASID(&ce);
>> >> >>>> +
>> >> >>>> +=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 if ((vtd_as->pasid !=3D PCI_N=
O_PASID || pasid !=3D rid2pasid) &&
>> >> >>>> +=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 vtd_as->pasid !=
=3D pasid) {
>> >> >>>> +=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 continue;
>> >> >>>> +=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 }
>> >> >>>> +
>> >> >>>> +=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 if (!s->scalable_modern) {
>> >> >>>> +=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 vtd_address_space=
_sync(vtd_as);
>> >> >>>> +=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 }
>> >> >>>> +=A0=A0=A0=A0=A0=A0=A0 }
>> >> >>>> +=A0=A0=A0 }
>> >> >>>> +}
>> >> >>>> +
>> >> >>>> +static bool vtd_process_piotlb_desc(IntelIOMMUState *s,
>> >> >>>> +=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=
=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 VTDInvDesc *inv_desc)
>> >> >>>> +{
>> >> >>>> +=A0=A0=A0 uint16_t domain_id;
>> >> >>>> +=A0=A0=A0 uint32_t pasid;
>> >> >>>> +
>> >> >>>> +=A0=A0=A0 if ((inv_desc->val[0] & VTD_INV_DESC_PIOTLB_RSVD_VAL0=
) ||
>> >> >>>> +=A0=A0=A0=A0=A0=A0=A0 (inv_desc->val[1] & VTD_INV_DESC_PIOTLB_R=
SVD_VAL1) ||
>> >> >>>> +=A0=A0=A0=A0=A0=A0=A0 inv_desc->val[2] || inv_desc->val[3]) {
>> >> >>>> +=A0=A0=A0=A0=A0=A0=A0 error_report_once("%s: invalid piotlb inv=
 desc val[3]=3D0x%"PRIx64
>> >> >>>> +=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=
=A0=A0=A0=A0 " val[2]=3D0x%"PRIx64" val[1]=3D0x%"PRIx64
>> >> >>>> +=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=
=A0=A0=A0=A0 " val[0]=3D0x%"PRIx64" (reserved bits unzero)",
>> >> >>>> +=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=
=A0=A0=A0=A0 __func__, inv_desc->val[3], inv_desc->val[2],
>> >> >>>> +=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=
=A0=A0=A0=A0 inv_desc->val[1], inv_desc->val[0]);
>> >> >>>> +=A0=A0=A0=A0=A0=A0=A0 return false;
>> >> >>>> +=A0=A0=A0 }
>> >> >>>
>> >> >>> Need to consider the below behaviour as well.
>> >> >>>
>> >> >>> "
>> >> >>> This
>> >> >>> descriptor is a 256-bit descriptor and will result in an invalid =
descriptor
>> >> >>> error if submitted in an IQ that
>> >> >>> is setup to provide hardware with 128-bit descriptors (IQA_REG.DW=
=3D0)
>> >> >>> "
>> >> >>>
>> >> >>> Also there are descriptions about the old inv desc types (e.g.
>> >> >>> iotlb_inv_desc) that can be either 128bits or 256bits.
>> >> >>>
>> >> >>> "If a 128-bit
>> >> >>> version of this descriptor is submitted into an IQ that is setup =
to provide
>> >> >>> hardware with 256-bit
>> >> >>> descriptors or vice-versa it will result in an invalid descriptor=
 error.
>> >> >>> "
>> >> >>>
>> >> >>> If DW=3D=3D1, vIOMMU fetches 32 bytes per desc. In such case, if =
the guest
>> >> >>> submits 128bits desc, then the high 128bits would be non-zero if =
there is
>> >> >>> more than one desc. But if there is only one desc in the queue, t=
hen the
>> >> >>> high 128bits would be zero as well. While, it may be captured by =
the
>> >> >>> tail register update. Bit4 is reserved when DW=3D=3D1, and guest =
would use
>> >> >>> bit4 when it only submits one desc.
>> >> >>>
>> >> >>> If DW=3D=3D0, vIOMMU fetchs 16bytes per desc. If guest submits 25=
6bits
>desc,
>> >> >>> it would appear to be two descs from vIOMMU p.o.v. The first 128b=
its
>> >> >>> can be identified as valid except for the types that does not req=
uires
>> >> >>> 256bits. The higher 128bits would be subjected to the desc sanity=
 check
>> >> >>> as well.
>> >> >>>
>> >> >>> Based on the above, I think you may need to add two more checks. =
If
>> >DW=3D=3D0,
>> >> >>> vIOMMU should fail the inv types that requires 256bits; If DW=3D=
=3D1, you
>> >> >>> should check the inv_desc->val[2] and inv_desc->val[3]. You've al=
ready
>> >> >>> done it in this patch.
>> >> >>>
>> >> >>> Thoughts are welcomed here.
>> >> >>
>> >> >> Good catch,
>> >> >> I think we should write the check in vtd_process_inv_desc
>> >> >> rather than updating the handlers.
>> >> >>
>> >> >> What are your thoughts?
>> >> >
>> >> >the first check can be done in vtd_process_inv_desc(). The second ma=
y
>> >> >be better in the handlers as the handlers have the reserved bits che=
ck.
>> >> >But given that none of the inv types use the high 128bits, so it is =
also
>> >> >acceptable to do it in vtd_process_inv_desc(). Do add proper comment=
.
>> >>
>> >> Thanks Yi and Clement's suggestion, I'll send a small series to fix t=
hat
>> >> for upstream.
>> >>
>> >> BRs.
>> >> Zhenzhong
>> >
>> >Ok so you will send v5?
>>
>> No, what Yi pointed out is an upstream issue, I'll send a small series(3=
 patches)
>> to fix that issue for upstream.
>>
>> Thanks
>> Zhenzhong
>
>Also ok. There's still gonnu be v5 because of other comments, right?

Right.

Thanks
Zhenzhong

