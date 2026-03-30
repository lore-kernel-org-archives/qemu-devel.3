Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 97F50FB3CE3
	for <qemu-devel@archiver.kernel.org>; Mon, 30 Mar 2026 09:07:31 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1w78aH-0002pB-Kc; Mon, 30 Mar 2026 05:06:59 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <zhenzhong.duan@intel.com>)
 id 1w78a5-0002ol-5h
 for qemu-devel@nongnu.org; Mon, 30 Mar 2026 05:06:45 -0400
Received: from mgamail.intel.com ([198.175.65.21])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <zhenzhong.duan@intel.com>)
 id 1w78Zw-0008EU-Bp
 for qemu-devel@nongnu.org; Mon, 30 Mar 2026 05:06:43 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1774861596; x=1806397596;
 h=from:to:cc:subject:date:message-id:references:
 in-reply-to:content-transfer-encoding:mime-version;
 bh=00acWUiLQaKlgtyPsagAvlBbviT9omPuDXM8NjM+Hpw=;
 b=nCnmr3tZjZjauTB73zUBidr0pZpeBxkkDn0PE2XTlKyhTXx8g3bpeFZD
 4O0tfIt0eGDzRgiZohZmtFDtIjFCs58kASstkwp9F/GWD8WWYL6u3zTHM
 v81Fii50TrFzuTQG0eBsL6p5QYA9m3i9o+SBRJuaEhtN2QdEyVW1pQkow
 jaSdvvYHevfpRvEOqGWxGeFX4/W/cqRppOWu6B3KT66PvocTqfGVIKaI9
 wQO5eVLRWZj6Zkp1FzufHb2RCqGvA35jeiTekdF0KM6LdIFYCN1Z3gIA5
 BuBxiXmoFfrh/yoKKAN5jix1TqvKCBH7h4bOnORcL7FWd60ydgQVfXWTc g==;
X-CSE-ConnectionGUID: gfv3rTDARSmVrKNjn9PusA==
X-CSE-MsgGUID: ZwWDOoRYTieNhbEtWXawBw==
X-IronPort-AV: E=McAfee;i="6800,10657,11743"; a="75735895"
X-IronPort-AV: E=Sophos;i="6.23,149,1770624000"; d="scan'208";a="75735895"
Received: from fmviesa010.fm.intel.com ([10.60.135.150])
 by orvoesa113.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 30 Mar 2026 02:06:32 -0700
X-CSE-ConnectionGUID: jVW4VLOTSOen7wtEtDHSEA==
X-CSE-MsgGUID: OaRzUnHLQYiWTT+qRZKOeQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.23,149,1770624000"; d="scan'208";a="221601620"
Received: from orsmsx902.amr.corp.intel.com ([10.22.229.24])
 by fmviesa010.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 30 Mar 2026 02:06:31 -0700
Received: from ORSMSX903.amr.corp.intel.com (10.22.229.25) by
 ORSMSX902.amr.corp.intel.com (10.22.229.24) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.37; Mon, 30 Mar 2026 02:06:31 -0700
Received: from ORSEDG901.ED.cps.intel.com (10.7.248.11) by
 ORSMSX903.amr.corp.intel.com (10.22.229.25) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.37 via Frontend Transport; Mon, 30 Mar 2026 02:06:31 -0700
Received: from MW6PR02CU001.outbound.protection.outlook.com (52.101.48.35) by
 edgegateway.intel.com (134.134.137.111) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.37; Mon, 30 Mar 2026 02:06:30 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=eRDbwmxRc5+ns1d81R+sii9izf3p87Vtt5xAhV8Y8L6lJOPJci6EzMfRWZrb5yA6PZfz+jMm+yeplW95138Evub4IbvYwzx3OENNNLGyz7MHmRBt43EkMT7I92zHUOdx4W4oIWdmxwb0uyHIFS9gkMRXzPI2qcR+2SUXWQW1EwUpK8fxd/PLgx8D0UvcZRwlC3MYZy2QdWl31vtPWzByGeEG80d4RnMnvLCE86bZNoOUlbsd0Eo02W3mtBVQ5GbIPnxuytU93fsPwbhYY6ZRawVwc4h+pbpwHvjfnVNkILJoYawaeqlupJTVyerNlYvbL44ni1JpaGEjGFx3UNQUhw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=0139W0dZB6M7h8UkryoMHNgQuCRDdcZAKDzFTIcz2/o=;
 b=mi/JXcysbl2SidO6PqfIe8ysrqrSmJG1s2kG0LxVPwKEvV3JKPuMAZrLYMDguT+1d3wVVs5Nn+v4eDTqaXdggJmdpT56yvNaRoGxe7jD48uLeRS0VFBfz31nyiOMlZqDj+4gwXtugTWQHaY9/BIHkp/WdcaGuHvLWZz1ECFyXv8KBYZmmIKEzwuIZw+MSY/pkHsDEUKDe9iMmWn2CPGMyip9kF7GMmP66w570hHALSXm32e3rMEhC4EmXSsxLiDWpd5O2ll/gbeUpQdx/ysikMIddmCBV3ieIZkxDrRGEegZbb1A672xLvi4/grF+OtnueXafpQSUlqeZu3XSFICpA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Received: from IA3PR11MB9136.namprd11.prod.outlook.com (2603:10b6:208:574::12)
 by DS4PPFD667CEBB6.namprd11.prod.outlook.com (2603:10b6:f:fc02::53)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9769.10; Mon, 30 Mar
 2026 09:06:29 +0000
Received: from IA3PR11MB9136.namprd11.prod.outlook.com
 ([fe80::37b4:37a9:4f3:518b]) by IA3PR11MB9136.namprd11.prod.outlook.com
 ([fe80::37b4:37a9:4f3:518b%5]) with mapi id 15.20.9769.011; Mon, 30 Mar 2026
 09:06:28 +0000
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
Subject: RE: [PATCH v2 13/14] intel_iommu_accel: Add pasid bits size check
Thread-Topic: [PATCH v2 13/14] intel_iommu_accel: Add pasid bits size check
Thread-Index: AQHcvQCxKbPjgyV7HkeBvKBZPm3mc7XBy4KAgABjKVA=
Date: Mon, 30 Mar 2026 09:06:28 +0000
Message-ID: <IA3PR11MB913609282D514B085ABFA3279252A@IA3PR11MB9136.namprd11.prod.outlook.com>
References: <20260326091130.321483-1-zhenzhong.duan@intel.com>
 <20260326091130.321483-14-zhenzhong.duan@intel.com>
 <0ae09582-4e0d-4fcd-a7ad-5b6b0b470b93@intel.com>
In-Reply-To: <0ae09582-4e0d-4fcd-a7ad-5b6b0b470b93@intel.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: IA3PR11MB9136:EE_|DS4PPFD667CEBB6:EE_
x-ms-office365-filtering-correlation-id: 38d1f700-170f-4cc1-1902-08de8e3ba0fd
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
 ARA:13230040|366016|1800799024|376014|7416014|38070700021|18002099003|56012099003|22082099003;
x-microsoft-antispam-message-info: PupYQmcaOoKk5YAqsjQeRR9u+mqTfz7eV4CxIDHyDKYgwhLEfAsLbZwvNBDzQOB5SQb/hRskRdAMtRj3xc/9K1wQ2BhinIEetGjfzTxtmBLvyE2CGGCg4suUoe889lbFCiPBzGfddRh/wualcPxqrnmNY+g6ri/Vq7uXTJm4bXH83jVlFZOk6XPyUAzOaflsAKXtofcjjqX+EpqSdB6AWrkFOfDnp5ahjLXWsZcsU3p5kKwv8N/VV1A8Nc1f7nvecUaH9h0IPL30Kyu+IaZcgo2+5pmtbqu4J3cDjVuZvAnrGpTFx5eOTCrhlDSCZNa3NeExCx+FwkIXwyL4Ogw9EitBs+5l3+g0Y+b4QG5niH73aqbZ6zN9wQYZNqHvDhH1LBO4zj5C86gmxcCTTKOfsEU98AbxQaIP4VEwxsisICJvdTc6jcBoF4/F8WTElUePWiUE22BJ6NkOCWM+vSICgQl3fmCEL2ng+BV4KAknRv5ZZveAU8a52tYSYFuRwwYPgBzNAmD3/rgOpSVqc2MXF/aPLIab5gFQIV51yk3+HlXy5I6ZkgUbmqG5tiwPQl3UEZ9qkKvjkUadheh5N7DNxwvWkmYqs4Jfpt4aZc3PDICeAp3FC71nlzap9pbpdz/sCNFugw1o2iEyF6ZXaQCAG/OBa3AgmSYWCVdT/HyXcZ2pozKv1MVqDY0wF6It3DwcARjvcJOfgdexahhUngO9LPpSUHqNpHHp5nlsKpwmYWh0hFrd3UJloP8xApLoVcHbA9ekn4pxmp/8N+VXeMb32RvZ0gpOrpNhRM++L3Zn+Pk=
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:IA3PR11MB9136.namprd11.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(366016)(1800799024)(376014)(7416014)(38070700021)(18002099003)(56012099003)(22082099003);
 DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?yR+Cx4gOouf5Gpe9k7ncbOI5j+DlqugTHai9bvSctnwTwRjR27hEjewvkywe?=
 =?us-ascii?Q?u3kNy3LYRHFWdR10aDCA+bXUsmjl9f8mlAVaq/sjFauJUR4Z95eH51sE0WGH?=
 =?us-ascii?Q?wzGwq5dHGfjPwQbP3+sKKMtK3tmUs5Z/CQg2tVGTcLOdpjFwEc2fnC29C1U3?=
 =?us-ascii?Q?R9Kx0H6wFHxuLutLa8oycko7qTFcBufly5PVK/AH/tB93CTLnURrO2GODxOJ?=
 =?us-ascii?Q?2i3t8bxDShs2we1F69u3wWkeOtakxeLYM5iphifmhqueKEellv/7tcaGrVTg?=
 =?us-ascii?Q?Xoci/h4qhPhxNWG8B4ebGaVVAVEWfleYyWC0+328NNX6g3YO670EG06N3PO8?=
 =?us-ascii?Q?L3Y8Qle6wYYOFQZSLeeXS2w7kQCsGuDeNmwn/aUK6JBqS57k0gSs0+D9YgB0?=
 =?us-ascii?Q?+qUMDHJpPqDlxdeVyVm7umu4cZ7yKO710+LRMTe2n3vOh2MPyf2kMeYExofo?=
 =?us-ascii?Q?HLAobqyUKWp4iXNPVjcwdeQM4736AOzO1Oepa/7kcduTy5Bnb5ASMhQSDa1E?=
 =?us-ascii?Q?/8T0YlOhwGm0kQGnPwJcpnCa+XI873/MS4psEeVKIenBwrhMkclap2YeKnG4?=
 =?us-ascii?Q?7IKszJo3dASzaXsSt7QqCVo5Em9fuiaD443tl7/drhGgWHDPLVTeS5Nt9uwm?=
 =?us-ascii?Q?H7qep3IA2PAreWO9+2CQifX3/hWdSf0AwZspi8RGrheO6e28vTw4g2qrVd6J?=
 =?us-ascii?Q?B+OnjCJNvHOLGyuTfihB46nq01x1l34a/AHkRT+Ubtx0e/TqGZASREfXmuEF?=
 =?us-ascii?Q?8s03znhRyyOAkf83+k4jVKDnO4WVWIYkb8vYFvB+MdhJW4BVKNMAR6HrlyQ0?=
 =?us-ascii?Q?zSQGKCxARgEfLUu0Q+lh1nbNWnUKhwGjSII0dUy8kphR+hjpwYNJ2+2L64Ry?=
 =?us-ascii?Q?wy7JeCtZV6CLo08XVU1qMJf4chz3/b1Av9Q48dQg4eeVl3A5Gcz1XCxr/Nqd?=
 =?us-ascii?Q?6KYhAeYCfipgByjEyl2yI1pMl00sLudjE97prba2Q6tdhAsNyQe04kJQRMO+?=
 =?us-ascii?Q?eVzmnImS40SzWdlHM3yasndWh6tSUPxiceOpCA8kHZD/h7GwmIclzH2ytuIR?=
 =?us-ascii?Q?VFtrN4ob703iwgRz18L6I4ICf8Ee4JtAenn7qmGDKbw3lqzaGsEddXg5nU8T?=
 =?us-ascii?Q?3WHceSO7wrOy5UghXz038HOrtLZgqsZ4YBOzTOnt+kLgcOkVxv62jyIXxHNH?=
 =?us-ascii?Q?XAoMJv8twuzElcifMmU+Ho9zvanT2QCFsu3Fw8EF9pubA2ofEPIx77bJzYyu?=
 =?us-ascii?Q?ejWXHZUswgVlcu7dJTKvnC9lL7jLIaL2xX2kL1dViwR4lGKlxcBRT2Ex46X0?=
 =?us-ascii?Q?oJ6d9jCK3Dqvjt6BaVhSkZSPqnrDO98loYTQ3KOtOGcDlNRk8/iZHLC9P5F8?=
 =?us-ascii?Q?7wYme+o5T412J7MuIl4x8ik1B2fdw8hhgQGYe+dYrhPI0RA7eOdL1hnILxql?=
 =?us-ascii?Q?1yGZ9KQdMNDxHw5uc1DLuQXxWhVT1lr74cc4dgq6xlDLqTfu5HnCqW8Khesh?=
 =?us-ascii?Q?mPqUQIIOyDTRJwzCLwb032PR8Dbaa5Cfhka8CY0tkaYa5ZHoj0COwSL2esnd?=
 =?us-ascii?Q?3jeDisNunEKN0vU7+wRWKxn4OAg5HC8yK3X5oQ4oWFFIjWzA+XXPiQe6WN3y?=
 =?us-ascii?Q?DVunh4jxZ3i3eBblIn2ABV8yy9iIX/awixrwJ7Iv+oZ6Y9ijgZe7ENOc9WzS?=
 =?us-ascii?Q?8KEV/nY9VdL66XNwJr60Ae9+dlpT7Fok4HoQMoM/xyAjn9bRVvI1enxYh+om?=
 =?us-ascii?Q?gEx7VCHf9A=3D=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-Exchange-RoutingPolicyChecked: uIEnupKqMqpWiZDgQC1Wv5V1sybwCiYYCZummmjgiiVN23VAk2s9j08dog61Hu8yrTGjwTH7O/Iv+GUnvNrd+keYfJxqedxBHuJnH24kIyvynTDtscdlVdMS1CDgTD0zVGsiopVNv1dh2pO/rLx2UzR59FhwY4trqn6v+ij8GJKDlFCp6gPYAIThhnhOmUSizbsfuzQsRwp/5xdd4daTcFPAmIJ4nlIbjhcrPxnQeKKHBE3k+cEG8xdfmpcGPzeCUHLKvzavuUdGoCt0XIbOElBIqC5SPB9QtvSA2/V1e/j7LiVvh0agMJTchaRkChcutvoouKVm/GD2dJ03qVXQIQ==
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: IA3PR11MB9136.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 38d1f700-170f-4cc1-1902-08de8e3ba0fd
X-MS-Exchange-CrossTenant-originalarrivaltime: 30 Mar 2026 09:06:28.7710 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: kcaLAhLWaw3K+cUHhKuDM6O0Rke9xaDKwzub1mOC6QzaeM0iOKfSZWvISM0A5/x9TtVaAzz6w+L39dvMOGp4inenqXvvJoanx8oZzcuOMVA=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS4PPFD667CEBB6
X-OriginatorOrg: intel.com
Received-SPF: pass client-ip=198.175.65.21;
 envelope-from=zhenzhong.duan@intel.com; helo=mgamail.intel.com
X-Spam_score_int: -28
X-Spam_score: -2.9
X-Spam_bar: --
X-Spam_report: (-2.9 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.54,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_MED=-2.3, RCVD_IN_VALIDITY_CERTIFIED_BLOCKED=1,
 RCVD_IN_VALIDITY_RPBL_BLOCKED=1, SPF_HELO_NONE=0.001,
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
>Subject: Re: [PATCH v2 13/14] intel_iommu_accel: Add pasid bits size check
>
>On 3/26/26 17:11, Zhenzhong Duan wrote:
>> If pasid bits size is bigger than host side, host could fail to emulate
>> all bindings in guest. Add a check to fail device plug early.
>>
>> Pasid bits size should also be no more than 20 bits according to PCI spe=
c.
>
>this has been enforced in the prior patch. right? hence just drop it. Or
>you may be merge them into one patch.

Yes, will delete it.

>
>>
>> Signed-off-by: Zhenzhong Duan <zhenzhong.duan@intel.com>
>> ---
>>   hw/i386/intel_iommu_internal.h | 1 +
>>   hw/i386/intel_iommu_accel.c    | 8 ++++++++
>>   2 files changed, 9 insertions(+)
>>
>> diff --git a/hw/i386/intel_iommu_internal.h b/hw/i386/intel_iommu_intern=
al.h
>> index f3cb6cff1c..d11064b527 100644
>> --- a/hw/i386/intel_iommu_internal.h
>> +++ b/hw/i386/intel_iommu_internal.h
>> @@ -196,6 +196,7 @@
>>   #define VTD_ECAP_SRS                (1ULL << 31)
>>   #define VTD_ECAP_NWFS               (1ULL << 33)
>>   #define VTD_ECAP_SET_PSS(x, v)      ((x)->ecap =3D deposit64((x)->ecap=
, 35, 5, v))
>> +#define VTD_ECAP_PSS(ecap)          extract64(ecap, 35, 5)
>
>perhaps VTD_ECAP_GET_PSS. I'm also wondering if we should have a set
>of macros to get other caps as well. Like "s->ecap & VTD_ECAP_SMTS"
>may be VTD_EAP_GET_SMTS(s->ecap, VTD_ECAP_SMTS)".

Currently VTD_ECAP_PSS is an implicit VTD_ECAP_GET_PSS like other definitio=
ns.

I'm not sure if we should follow arm's style to use VTD_ECAP_GET_PSS or vtd=
's style to use VTD_ECAP_PSS.

Thanks
Zhenzhong

>
>>   #define VTD_ECAP_PASID              (1ULL << 40)
>>   #define VTD_ECAP_PDS                (1ULL << 42)
>>   #define VTD_ECAP_SMTS               (1ULL << 43)
>> diff --git a/hw/i386/intel_iommu_accel.c b/hw/i386/intel_iommu_accel.c
>> index 2fd26690b9..e73695ff83 100644
>> --- a/hw/i386/intel_iommu_accel.c
>> +++ b/hw/i386/intel_iommu_accel.c
>> @@ -44,6 +44,7 @@ bool vtd_check_hiod_accel(IntelIOMMUState *s,
>VTDHostIOMMUDevice *vtd_hiod,
>>       HostIOMMUDevice *hiod =3D vtd_hiod->hiod;
>>       struct HostIOMMUDeviceCaps *caps =3D &hiod->caps;
>>       struct iommu_hw_info_vtd *vtd =3D &caps->vendor_caps.vtd;
>> +    uint8_t hpasid =3D VTD_ECAP_PSS(vtd->ecap_reg) + 1;
>>       PCIBus *bus =3D vtd_hiod->bus;
>>       PCIDevice *pdev =3D bus->devices[vtd_hiod->devfn];
>>
>> @@ -64,6 +65,13 @@ bool vtd_check_hiod_accel(IntelIOMMUState *s,
>VTDHostIOMMUDevice *vtd_hiod,
>>           return false;
>>       }
>>
>> +    /* Only do the check when host device support PASIDs */
>> +    if (caps->max_pasid_log2 && s->pasid > hpasid) {
>> +        error_setg(errp, "PASID bits size %d > host IOMMU PASID bits si=
ze %d",
>> +                   s->pasid, hpasid);
>> +        return false;
>> +    }
>> +
>>       if (pci_device_get_iommu_bus_devfn(pdev, &bus, NULL, NULL)) {
>>           error_setg(errp, "Host device downstream to a PCI bridge is "
>>                      "unsupported when x-flts=3Don");


