Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0659610BA431
	for <qemu-devel@archiver.kernel.org>; Fri, 27 Mar 2026 07:42:02 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1w61pI-0001Io-4l; Fri, 27 Mar 2026 03:41:52 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <zhenzhong.duan@intel.com>)
 id 1w61pG-0001Gp-By
 for qemu-devel@nongnu.org; Fri, 27 Mar 2026 03:41:50 -0400
Received: from mgamail.intel.com ([198.175.65.13])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <zhenzhong.duan@intel.com>)
 id 1w61pE-0007Pn-3B
 for qemu-devel@nongnu.org; Fri, 27 Mar 2026 03:41:50 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1774597308; x=1806133308;
 h=from:to:cc:subject:date:message-id:references:
 in-reply-to:content-transfer-encoding:mime-version;
 bh=d2+fihMUVq3fdyEnkteNsyC98MQZ42sUUIQEDORxYKk=;
 b=HowXqnCDYdqaphnlwXXrAZmpCiTUDz030adkxfM+6IiGx9AqbEcIFebb
 LeTVBQZARFKcWXhie3UhXVhe8QyRD+uYCl6n6dV5KSckva3IKGFBESIod
 2CixoWpl71rrzVs8Gbef6uNH500Ddc1fbcCLT8Lwd1vqEcrGwc0xEL7EH
 ndRhhOlORzIgmXw4J6Wa8SjFm+HO5lKihTwjUWcQgXAA6D2oUEUqqDUaj
 +4wLDtUfP25EgXThwLZqJQzDwHDPQV1Gcyo9fYDCeNmFkaHS50X3QqURj
 3SxqZTjnyeenEZ3FJu3qWaCh2WFkDUYZouPRxPU10w5nujCNuiTIvIY/8 g==;
X-CSE-ConnectionGUID: kbZvtGRRSFuZtpHHvjN94A==
X-CSE-MsgGUID: gbUJqcnoReWacAeo7YC8Gw==
X-IronPort-AV: E=McAfee;i="6800,10657,11741"; a="86743083"
X-IronPort-AV: E=Sophos;i="6.23,143,1770624000"; d="scan'208";a="86743083"
Received: from fmviesa002.fm.intel.com ([10.60.135.142])
 by orvoesa105.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 27 Mar 2026 00:41:45 -0700
X-CSE-ConnectionGUID: 0a3BzIAlSGu7SQ/Q5MrL2Q==
X-CSE-MsgGUID: YR4tsFprSGWnlDWByNLkWQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.23,143,1770624000"; d="scan'208";a="248290171"
Received: from fmsmsx901.amr.corp.intel.com ([10.18.126.90])
 by fmviesa002.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 27 Mar 2026 00:41:45 -0700
Received: from FMSMSX902.amr.corp.intel.com (10.18.126.91) by
 fmsmsx901.amr.corp.intel.com (10.18.126.90) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.37; Fri, 27 Mar 2026 00:41:44 -0700
Received: from fmsedg903.ED.cps.intel.com (10.1.192.145) by
 FMSMSX902.amr.corp.intel.com (10.18.126.91) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.37 via Frontend Transport; Fri, 27 Mar 2026 00:41:44 -0700
Received: from PH0PR06CU001.outbound.protection.outlook.com (40.107.208.68) by
 edgegateway.intel.com (192.55.55.83) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.37; Fri, 27 Mar 2026 00:41:43 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=khET8AKfXPqvLNMWi/qCV1U7dWnjfg87//PJVrTDv6uOntl0SdU8IV6sYchC4wOu/EgSjhG4mR+uB82LidCcsArBlxW0W29gr6XTu2F2Tss4RS5gjn/gDilQQEU7lLZhRbiZUIEgtdYTX3z06v2MWvyCYjrQ5rr/PUQmodvWYvbDtBPYNTPMBv+Tqm4a+pBZD8rRIGKvi9bCMUBs5Jwu6Lr3xqpPj3RqKaGQm7s6XXjgzvC3KpfkevMslJs7P0izsnDhDrwH+Fzl89MZSZA42QL6q2TUaaajkh9YsHucEP8U5i5jM7VAogQcQ6I6H2+UD0UBKklqx6MwO60m0js3Pg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=cPF45cwDY3qQmGHTJIxAQTJHL7bNCWtxpbclbtIJyWY=;
 b=Zve1NA9f5FLPhzpPhqlug88TwGpiLhtdvHMmjEJl529rObWjbZTkQGh+gCYkpKcKrN5rXr5SNPMOhLa7URs81MOVYM0h/NiOiLbj57ewC+rtRE2jcVSTAA6CCVqCAwjEDHmwbKaeLTdZ6VKrWp8fy7QTxN+e03hAW6XyjURspc/9VHfIP7+9sbVyFFX5gp8ATHYKOmY7WsyJojPUtM3ESmbUKlqOGifisg+uLZqHhVxC3M47FNmMajKg7C5ofID00hM04rTNxtl6EoSCFIbqlwIVCEm4e/qTCKO2j/coxNCmVR8vTqv18jR0eL2lhPgclaQFMP66t2LGBVtU2ycVtQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Received: from IA3PR11MB9136.namprd11.prod.outlook.com (2603:10b6:208:574::12)
 by DM4PR11MB6430.namprd11.prod.outlook.com (2603:10b6:8:b6::15) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9769.8; Fri, 27 Mar
 2026 07:41:41 +0000
Received: from IA3PR11MB9136.namprd11.prod.outlook.com
 ([fe80::37b4:37a9:4f3:518b]) by IA3PR11MB9136.namprd11.prod.outlook.com
 ([fe80::37b4:37a9:4f3:518b%5]) with mapi id 15.20.9723.013; Fri, 27 Mar 2026
 07:41:41 +0000
From: "Duan, Zhenzhong" <zhenzhong.duan@intel.com>
To: "Liu, Yi L" <yi.l.liu@intel.com>, "qemu-devel@nongnu.org"
 <qemu-devel@nongnu.org>
CC: "alex@shazbot.org" <alex@shazbot.org>, "clg@redhat.com" <clg@redhat.com>, 
 "eric.auger@redhat.com" <eric.auger@redhat.com>, "mst@redhat.com"
 <mst@redhat.com>, "jasowang@redhat.com" <jasowang@redhat.com>,
 "jgg@nvidia.com" <jgg@nvidia.com>, "nicolinc@nvidia.com"
 <nicolinc@nvidia.com>, "skolothumtho@nvidia.com" <skolothumtho@nvidia.com>,
 "joao.m.martins@oracle.com" <joao.m.martins@oracle.com>,
 "clement.mathieu--drif@bull.com" <clement.mathieu--drif@bull.com>, "Tian,
 Kevin" <kevin.tian@intel.com>, "Hao, Xudong" <xudong.hao@intel.com>
Subject: RE: [PATCH v2 05/14] intel_iommu: Change pasid property from bool to
 uint8
Thread-Topic: [PATCH v2 05/14] intel_iommu: Change pasid property from bool to
 uint8
Thread-Index: AQHcvQCgehCPY5Pj9ESirtJFLqeecbXBys4AgAAcKIA=
Date: Fri, 27 Mar 2026 07:41:41 +0000
Message-ID: <IA3PR11MB9136B433BE767113C5F4CF8D9257A@IA3PR11MB9136.namprd11.prod.outlook.com>
References: <20260326091130.321483-1-zhenzhong.duan@intel.com>
 <20260326091130.321483-6-zhenzhong.duan@intel.com>
 <e5422d16-8728-47e3-b2e7-c8f1a076a2e5@intel.com>
In-Reply-To: <e5422d16-8728-47e3-b2e7-c8f1a076a2e5@intel.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: IA3PR11MB9136:EE_|DM4PR11MB6430:EE_
x-ms-office365-filtering-correlation-id: b3691445-a927-45d3-ba77-08de8bd44972
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
 ARA:13230040|366016|1800799024|7416014|376014|56012099003|22082099003|18002099003|38070700021;
x-microsoft-antispam-message-info: sGwWEa37E8TPVT7o9bQrdLjy0rDyZPB/Imhs8uCFdVjP3UfwyKzYPX90/j2U/hZiqCimJX0VUCyNftx0xrnAewGg3UShhjC+ssxSA8KURQEJrg6qjgGjh+DJKNOp7fCFGt325fDwXXMsFrKpFmgGCpzZO5q8XjYF537QKJEumJF5RCJwD/QJg40EyPv/IJ8NxneA1jgFonUvPR9Ab2m1r5QWhSPH2qgfKklJwVFwuZmeES2OIfud82Ft9S6SXMBKR58IgwExaFEcGAR35clJbDlr0mhzTLcwEV29eceKXRffwFB//W69O8SBtAysMD765jEY68enQJieFqUwYeo3II4YWSV8OY7fR4yKg7CJpYTgGlZIgsbYN26+hfZn2FBmVBCtw2KC9Lby21NDJU+kCfhUZLQi+4m4wAtwUaodlnicPzyqSDQlNDrjpjnuy3/+fj/a+z1V6N5AuTaD8JdRcXnC5kYNyu8ypfLIsSmi+i6EJvMt85v936+1pt4F3dlqSIkYxbfL973eAS8oi4hy77cq2Dd1qnofM1e3cF9BvoKL+kgo4ud0vSc8+OHQ0wWhxIpMzBDgEHxCmoKKsuSmWwPpDmod4xdvmx/4n6RZBGz3ZYMahDeV4wxgq7Ec5OdixETbPc0yN5P3Gkb+3YRhRfM1nvOcjhSbfh9pFCrBxgv9+GU7YMF1Ma4AKVjxHpISkj7GvEMMQbyzKz4vU2oHmwZU1iii95IBxyNinC9R4axnj9zFcshQYVMJJubEqQ8GnEOcx/aIwnzKR3Hc6Se+7aW+e9AG7SWS6kVWI99bzo8=
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:IA3PR11MB9136.namprd11.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(366016)(1800799024)(7416014)(376014)(56012099003)(22082099003)(18002099003)(38070700021);
 DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?q+1sajAFdoF5ZRx7j13skzkLbZ2QN5qUJJukDh/m7JH5psEUXcNyqjqSSXH8?=
 =?us-ascii?Q?qrDuG4V/Damibxe/WhbfZXo2+ViF2sMH+lPqtMZjV61+B3WPVQRY6odb/chD?=
 =?us-ascii?Q?402vsTA1gJjGha7RHVyw4DwNFPm+SVYIROPZxHUiy77UyQkJuHfu1JSu8maV?=
 =?us-ascii?Q?0gIKbe75uy57DDvgs3FSiugHx9ECihNpAHkpTegEgiG5FHqs7BWLmxBFg7nU?=
 =?us-ascii?Q?hU+O+JcYt6imEpY9W3ufbjO3Y0werTN1crb+7quCdsGQ4rJuUEPxDsBuy7H3?=
 =?us-ascii?Q?By9me1IjMvBO/803mbyGbwS1/0uSrEhvxR2OuYwQ2NbUxWVN0ZEAvrCp923D?=
 =?us-ascii?Q?LN9Ifs5CwNqBWQWX6usDgtyf/QbeNfixf/G+7s64gMVatrdHhT0PZhX2yvJs?=
 =?us-ascii?Q?+mQK1juHtKBnS0nTn9n7BhKLrQaTHezE29qSsN1uwU7NhiuHseYgFn6kcLUy?=
 =?us-ascii?Q?d2IS0MZ/ot/rcsAdug3d8KG0WC350ufKzeu6nuC20CfmXYe6bkXaNib2qJGw?=
 =?us-ascii?Q?XXpmACZs5do2rAnKiOF9aExSj2FjEmuRCK4r5x48bTpwvewskEzK62/QxDnd?=
 =?us-ascii?Q?0xJG091d7lA2YgtcIyLSkD473ixFsWgHOI7IZV8GXiRlynHdnWP2X9MuRRcz?=
 =?us-ascii?Q?kQeBsDtEcpwmSWsK+p6c1ADqIYFydBCIcRrtaLWk36S8NneNqFTTaxevFSZj?=
 =?us-ascii?Q?6bvjqO8mnfxOGNXvbwk93exq3hzCvfd73cvPuxg1yo/ypQXQDaXbXVUNllxH?=
 =?us-ascii?Q?aQwrb96eFsGQpKnhc99Do6AXSTtHz9ibLssTIViQ0Lv6LsVqrpRsZNOdJwiX?=
 =?us-ascii?Q?2qycAVt5oDy/mQuA2BCMz6rSofujohvETk1aaLdgvYcaELojPtvCrZAsP9oy?=
 =?us-ascii?Q?l1ar9r8YmBKqeQOr7mlU/TPxUMyYVbkEvkgop2x5A9ud9gp6W4nXFH7J0mco?=
 =?us-ascii?Q?A2RRteBITvhOa3ioCiePiIUb/hQQhddjokOVuSL8MezKZiccqP1Hg1S3Dh0X?=
 =?us-ascii?Q?0NnMqR7f/F4vQ+WK+Qiq+mdZYyn7NZ5vmNLAjYH9BZ5YlGNyQRWSLP7oFkPH?=
 =?us-ascii?Q?FmNfvwHgoXmrU6hMjSDFTe7V6VbVQd1+luvGa+IgiKv4rLHKu935lig8Ecs9?=
 =?us-ascii?Q?E3BIYlmENqGQ/i6gS7JuL95yZdpA0SN0XjnaT8I5ODEPOyq60HLh+110IRPa?=
 =?us-ascii?Q?w1cy7yBvopY88lPJ7LWQQgKew2vXc0ikhyWfhz25T7lMQRYrCndChxu1hwjl?=
 =?us-ascii?Q?9MCQRO6l85sdnOAEENwCr+eLtyj7BgvtQTDWTd81WZ81aBA6QLQm0bDqqGCE?=
 =?us-ascii?Q?GqZj3ydxkIDgD48Cwsh+/9SoZLZiFB279Bz/o66ISbf3lBC178wr/3JoWL7G?=
 =?us-ascii?Q?2vjwvUg2KkmgNteJL6WCUseEPcjM0bYbxHtTlhSDe5cMgx0tEQ/GcW7EcCJX?=
 =?us-ascii?Q?ZOcpZVAy1yRfEhlVNUJsn3Gw/aNoKIeO9zS8A24l74m7vERb4GJGjtm0WrG3?=
 =?us-ascii?Q?rxUXsgekwB47cxKj2lg2R2kGHsV3b1M3f9arQRtu7ga9eltAqECJZlm9/2f6?=
 =?us-ascii?Q?aI6CjRD8cdupzqnBjBS/LsLQV6FyE0JBBcjJpUl4MaaxV7QY67o3mWJ6DNZx?=
 =?us-ascii?Q?F92lq0jpzcvOEpcKlacwUGW0vW2ZbIS/wI19sg1OKOnMfI2RZ9uuCTneJ5IE?=
 =?us-ascii?Q?qlxIw4nUQjZKRZPs89t6tbmjlkll1tBTN+WjWoPLkRY06SG6Z0w0X0xs6xcr?=
 =?us-ascii?Q?+s9KmK7oQA=3D=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-Exchange-RoutingPolicyChecked: qSK5npjRk7I0LmK0S8zd44sHbwKcDTHKqgtmUy/uFkKByMgLaz/T2nA0cXJPLyOC4GPO2/w384V5HJB45DX9xMCQ94w0Us1+uav7q+jI8dDkDlrPiBrXC0OrhvOUAWVnsfZTjnCrFTWqXd90sYswic8hZt2eZN91Mic2OkMAJNmuvUI2fCPPGx9GF6v0b7sYhzLBCutxEfi0qxFQAuwkU0DzfE//m0/eYyTAqizPYr1VtOs9En9gKneDmcek2srGNgD9eb8+IuZOggY9P1u3XndCPf8Y3INPhKD6afblh9MpqAg3vG1aJjcWeTMpiDHri7TJSvNKtdj+5/u2MZB3Bw==
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: IA3PR11MB9136.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: b3691445-a927-45d3-ba77-08de8bd44972
X-MS-Exchange-CrossTenant-originalarrivaltime: 27 Mar 2026 07:41:41.4343 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 4tuWxEQFOX2G9lnXSz/V4zFxVmuMf0S2oiqjTm0sLp06d5jGcNlnhQMYP8SbfxbrqXE6R0v6sBbLEg4vqeKzbWUt3/kbP5OvSUcBVfNfhdI=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM4PR11MB6430
X-OriginatorOrg: intel.com
Received-SPF: pass client-ip=198.175.65.13;
 envelope-from=zhenzhong.duan@intel.com; helo=mgamail.intel.com
X-Spam_score_int: -43
X-Spam_score: -4.4
X-Spam_bar: ----
X-Spam_report: (-4.4 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_MED=-2.3, RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001,
 RCVD_IN_VALIDITY_SAFE_BLOCKED=0.001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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



>-----Original Message-----
>From: Liu, Yi L <yi.l.liu@intel.com>
>Subject: Re: [PATCH v2 05/14] intel_iommu: Change pasid property from bool=
 to
>uint8
>
>On 3/26/26 17:11, Zhenzhong Duan wrote:
>> 'x-pasid-mode' is a bool property, we need an extra 'pss' property to
>> represent PASID size supported. Because there is no any device in QEMU
>> supporting pasid capability yet, no guest could use the pasid feature
>> until now, 'x-pasid-mode' takes no effect.
>>
>> So instead of an extra 'pss' property we can use a single 'pasid'
>> property of uint8 type to represent if pasid is supported and the PASID
>> bits size. A value of N > 0 means pasid is supported and N - 1 is the
>> value in PSS field in ECAP register.
>>
>> PASID bits size should also be no more than 20 bits according to PCI spe=
c.
>>
>> Signed-off-by: Zhenzhong Duan <zhenzhong.duan@intel.com>
>> ---
>>   hw/i386/intel_iommu_internal.h |  2 +-
>>   include/hw/i386/intel_iommu.h  |  2 +-
>>   hw/i386/intel_iommu.c          | 11 +++++++++--
>>   3 files changed, 11 insertions(+), 4 deletions(-)
>>
>> diff --git a/hw/i386/intel_iommu_internal.h b/hw/i386/intel_iommu_intern=
al.h
>> index 11a53aa369..db4f186a3e 100644
>> --- a/hw/i386/intel_iommu_internal.h
>> +++ b/hw/i386/intel_iommu_internal.h
>> @@ -195,7 +195,7 @@
>>   #define VTD_ECAP_MHMV               (15ULL << 20)
>>   #define VTD_ECAP_SRS                (1ULL << 31)
>>   #define VTD_ECAP_NWFS               (1ULL << 33)
>> -#define VTD_ECAP_PSS                (7ULL << 35) /* limit: MemTxAttrs::=
pid */
>> +#define VTD_ECAP_SET_PSS(x, v)      ((x)->ecap =3D deposit64((x)->ecap,=
 35, 5, v))
>
>does this change still meet the limit commented by "* limit:
>MemTxAttrs::pid */"?

VTD doesn't use MemTxAttrs::pid. Clement asked same question, see my reply =
at
https://lore.kernel.org/qemu-devel/IA3PR11MB9136B8106B0070F03CF9C32B9261A@I=
A3PR11MB9136.namprd11.prod.outlook.com/

>
>>   #define VTD_ECAP_PASID              (1ULL << 40)
>>   #define VTD_ECAP_PDS                (1ULL << 42)
>>   #define VTD_ECAP_SMTS               (1ULL << 43)
>> diff --git a/include/hw/i386/intel_iommu.h b/include/hw/i386/intel_iommu=
.h
>> index e44ce31841..95c76015e4 100644
>> --- a/include/hw/i386/intel_iommu.h
>> +++ b/include/hw/i386/intel_iommu.h
>> @@ -314,7 +314,7 @@ struct IntelIOMMUState {
>>       bool intr_eime;                 /* Extended interrupt mode enabled=
 */
>>       OnOffAuto intr_eim;             /* Toggle for EIM cabability */
>>       uint8_t aw_bits;                /* Host/IOVA address width (in bit=
s) */
>> -    bool pasid;                     /* Whether to support PASID */
>> +    uint8_t pasid;                  /* PASID supported in bits, 0 if no=
t */
>>       bool fs1gp;                     /* First Stage 1-GByte Page Suppor=
t */
>>
>>       /* Transient Mapping, Reserved(0) since VTD spec revision 3.2 */
>> diff --git a/hw/i386/intel_iommu.c b/hw/i386/intel_iommu.c
>> index f395fa248c..a7b676cd13 100644
>> --- a/hw/i386/intel_iommu.c
>> +++ b/hw/i386/intel_iommu.c
>> @@ -4203,7 +4203,7 @@ static const Property vtd_properties[] =3D {
>>       DEFINE_PROP_BOOL("x-scalable-mode", IntelIOMMUState, scalable_mode=
,
>FALSE),
>>       DEFINE_PROP_BOOL("x-flts", IntelIOMMUState, fsts, FALSE),
>>       DEFINE_PROP_BOOL("snoop-control", IntelIOMMUState, snoop_control,
>false),
>> -    DEFINE_PROP_BOOL("x-pasid-mode", IntelIOMMUState, pasid, false),
>> +    DEFINE_PROP_UINT8("pasid", IntelIOMMUState, pasid, 0),
>>       DEFINE_PROP_BOOL("svm", IntelIOMMUState, svm, false),
>>       DEFINE_PROP_BOOL("stale-tm", IntelIOMMUState, stale_tm, false),
>>       DEFINE_PROP_BOOL("fs1gp", IntelIOMMUState, fs1gp, true),
>> @@ -5042,7 +5042,8 @@ static void vtd_cap_init(IntelIOMMUState *s)
>>       }
>>
>>       if (s->pasid) {
>> -        s->ecap |=3D VTD_ECAP_PASID | VTD_ECAP_PSS;
>> +        VTD_ECAP_SET_PSS(s, s->pasid - 1);
>> +        s->ecap |=3D VTD_ECAP_PASID;
>>       }
>>   }
>>
>> @@ -5583,6 +5584,12 @@ static bool vtd_decide_config(IntelIOMMUState *s,
>Error **errp)
>>           return false;
>>       }
>>
>> +    if (s->pasid > PCI_EXT_CAP_PASID_MAX_WIDTH) {
>> +        error_setg(errp, "PASID width %d, exceed Max PASID Width %d all=
owed "
>> +                   "in PCI spec", s->pasid, PCI_EXT_CAP_PASID_MAX_WIDTH=
);
>
>s/exceed/exceeds/

Will do.

Thanks
Zhenzhong

