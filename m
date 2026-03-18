Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8E770FCD0B4
	for <qemu-devel@archiver.kernel.org>; Wed, 18 Mar 2026 05:43:50 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1w2jgk-0003V7-9c; Wed, 18 Mar 2026 01:43:26 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <vivek.kasireddy@intel.com>)
 id 1w2jgh-0003Uf-Gh
 for qemu-devel@nongnu.org; Wed, 18 Mar 2026 01:43:23 -0400
Received: from mgamail.intel.com ([198.175.65.15])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <vivek.kasireddy@intel.com>)
 id 1w2jgf-0004hl-23
 for qemu-devel@nongnu.org; Wed, 18 Mar 2026 01:43:23 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1773812601; x=1805348601;
 h=from:to:cc:subject:date:message-id:references:
 in-reply-to:content-transfer-encoding:mime-version;
 bh=dFAEFUOZyj8yyXrvcXdPagv+4CV/naLWq0Wizp6EjKo=;
 b=WjxjTuaCpSH6irR/HGs4KDCd8MMqzbQMmiQ7OAFxpgiCJIafWL0U6znF
 LtfPwQRNHu11xVPIRN0jrTnyHs9dXWYynwWurzb3Jxaa1/DfFd0/zUA+A
 7lsVxAnW/xnq/f99gqD8CklRuWXR5E+iDBEpdCwZawIdRNI7T2EP0mvBh
 w7AZMjWMdhkr4hW5JaREiMhfydH7DBSppZoh+fNvaJL34OVpY+4BY+gmf
 IBqZ400BOrmm8FaFuQLP2qtllQ9WgipSS3syw/BGDWSjfL04c6Jp/0thj
 tnJcOWA7q8Qit5YEHS0G1m5sZdxOIvDECbg1T8ZCHvuIpMebA05AsHb7B Q==;
X-CSE-ConnectionGUID: cqGFgFZ+RSWwLntpHjPtvg==
X-CSE-MsgGUID: qm0tbowXSkqk/2sGqCqhQg==
X-IronPort-AV: E=McAfee;i="6800,10657,11732"; a="78468912"
X-IronPort-AV: E=Sophos;i="6.23,126,1770624000"; d="scan'208";a="78468912"
Received: from orviesa008.jf.intel.com ([10.64.159.148])
 by orvoesa107.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 17 Mar 2026 22:43:19 -0700
X-CSE-ConnectionGUID: IQ+vkjr/Sveg9UGaVR+uYQ==
X-CSE-MsgGUID: eMqgSKZ8T0uHf9VBzIZMsQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.23,126,1770624000"; d="scan'208";a="222555364"
Received: from fmsmsx901.amr.corp.intel.com ([10.18.126.90])
 by orviesa008.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 17 Mar 2026 22:43:18 -0700
Received: from FMSMSX903.amr.corp.intel.com (10.18.126.92) by
 fmsmsx901.amr.corp.intel.com (10.18.126.90) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.37; Tue, 17 Mar 2026 22:43:17 -0700
Received: from fmsedg901.ED.cps.intel.com (10.1.192.143) by
 FMSMSX903.amr.corp.intel.com (10.18.126.92) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.37 via Frontend Transport; Tue, 17 Mar 2026 22:43:17 -0700
Received: from BN8PR05CU002.outbound.protection.outlook.com (52.101.57.52) by
 edgegateway.intel.com (192.55.55.81) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.37; Tue, 17 Mar 2026 22:43:17 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=DTrW/Oz6QbsOOpa3mxISlYCQK60DX7S1GakLaVm2o5SjpawCood1alAMjrSB7rqX/AXK4DXoSUh/G268840KnhjRh4U/pWxGFrMGBxUhzuT7laLDULROA91S2IzxWUD32T7db+nRLAxDfCHsY0BiaqPJdFUEGw6cXnqNbZdMw/rdtsiijnL/buXtTrGHJVpbtbt4HNHAdt4X0UcCCB0kkPOvufHxlhkZI2hhiAO1LfrBfaCjjvvUDRh9MB0YOFBghZn8ADIQfZhRs8Jk5MoBlrxHDc9Gkc4OHNtIEJrX54DVARjh3Eau+cqOr7oe1GgUYxOHZ6nw/qF+pJhlUKKyyA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=dFAEFUOZyj8yyXrvcXdPagv+4CV/naLWq0Wizp6EjKo=;
 b=S9grVIOGsQMelhMq4/t7SfqKQXSWZ72T8meqMu5I6DV/n5aZyknLwmsYsHekoXE3o8HdN1VsCP0JExAERWvJ9wvfTaS42LpU6EW29UDYjLHx5u1LR1TEHYktLcoZdIDIv1jByQ2+XtZEQyQatZvNj4o2GRjKKQrRJv1SKXyR7DqFCyC4QM4uLodsAQCOaK03b2vCnvONDqSkrENModKBwLH5zlSBlQouOsxEITsNg+JpGC9Yp0OBAKmjtZn3rw7vJm67AylEC0G8YxBz8RiOGmAs/PK3muafLfu5VWOg39lAVaMXoOn9FOSV1uJPAf2r4zgPwMhN/9kFyGMtgkt6+g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Received: from CH3PR11MB7177.namprd11.prod.outlook.com (2603:10b6:610:153::8)
 by DS7PR11MB8853.namprd11.prod.outlook.com (2603:10b6:8:255::9) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9723.19; Wed, 18 Mar
 2026 05:43:12 +0000
Received: from CH3PR11MB7177.namprd11.prod.outlook.com
 ([fe80::b997:e226:4979:c035]) by CH3PR11MB7177.namprd11.prod.outlook.com
 ([fe80::b997:e226:4979:c035%5]) with mapi id 15.20.9723.018; Wed, 18 Mar 2026
 05:43:11 +0000
From: "Kasireddy, Vivek" <vivek.kasireddy@intel.com>
To: =?iso-8859-1?Q?C=E9dric_Le_Goater?= <clg@redhat.com>,
 "qemu-devel@nongnu.org" <qemu-devel@nongnu.org>
CC: Alex Williamson <alex@shazbot.org>
Subject: RE: [PATCH v11 06/10] vfio/region: Add a helper to get region index
 from memory region
Thread-Topic: [PATCH v11 06/10] vfio/region: Add a helper to get region index
 from memory region
Thread-Index: AQHcsQKuB9On+hMUHEShcdPuK+wOLrWy1jiAgAAFkQCAAFTzwA==
Date: Wed, 18 Mar 2026 05:43:11 +0000
Message-ID: <CH3PR11MB7177D2DF27382270C266DC97F84EA@CH3PR11MB7177.namprd11.prod.outlook.com>
References: <20260311025340.1335673-1-vivek.kasireddy@intel.com>
 <20260311025340.1335673-7-vivek.kasireddy@intel.com>
 <2f048542-173e-4b93-ba4e-f7ce75788f73@redhat.com>
 <fd123458-7468-4987-917a-1b04d8f690d2@redhat.com>
In-Reply-To: <fd123458-7468-4987-917a-1b04d8f690d2@redhat.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: CH3PR11MB7177:EE_|DS7PR11MB8853:EE_
x-ms-office365-filtering-correlation-id: 8545f0a9-a677-447f-9731-08de84b13e1a
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
 ARA:13230040|366016|1800799024|376014|38070700021|18002099003|56012099003|22082099003;
x-microsoft-antispam-message-info: 03QO6wUoUqPTXiRRG5iWEdhGddKoeLcfW7PVubqpxYI+BcdPtFaF+pZVN8LLzeLF6g4vAYKgge3zaRoeedqfChIWeN3UOk82cyAs66jTeIGcZof4WzaGj05Y2PoWgLIuJ66Sb9qlt6C57+bt2wPqzHXenC1kgwIwQf8KxamNOVckHOd7LxkcB/+ShEPF3xc3RwvIE1RdG1s5vAUBSiMC1BcxWOgW0WLNI8GkaIKQ6RVBM9PyRdrEcuBTjfhe8XVLUBfjhiHGT8K/ithPW6oFqbFTLPC0rm+fA0Ux+X5b9stAYbN+GnjmCz4A1K2F/19KX3xRXfhi3obsbzWEntnAqhjKPL+ROtGH1XdOZ0snXvhD0eeqypx9wCOyB3UQHyxr0Zs1HZbhKfuzZkhQ7fItP3kDcs9r0gBLRm9+ipmaHbTJiWuCGcRYYQQPc5y2ILuQ+cFtirJzPPAeUxnJkRJcOtunSAWV+ODDWsK7pxfg5prBY/270XhpBPezz0fO5Z8XFy8RVBim8yTA34ZjYsr4jbYB6CgAyuP0LHYxug/aQ6wramSmqYgEcQJpLd6bDcGfEhL++mObdWVx39MZqkgRvkE7tVQtyetJIEs0vf6TguSSAAMbGy7bC2IPyDMDSLl5O/x7jbj5C+EI2GeHOcS9jIKk8jI9jA4r6SNL0xb7rdeU+o++Km0ajo608NlbVvpT89NHMy/tDcQHudlrPx+hmeiwD9h4J+nIVhEUtgR1LXwkvrH9ATL/nQ0lwvq8U24ReSTFEPU1UwIpVzOE4Dbz3xHJvbrYK/217gXoyvA01uA=
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:CH3PR11MB7177.namprd11.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(366016)(1800799024)(376014)(38070700021)(18002099003)(56012099003)(22082099003);
 DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?iso-8859-1?Q?6+Bf+Ooy4lJZ2e2auNymlQfVlPrU+m9sg4BQbyaU1qXf0FumIu2KnhV54d?=
 =?iso-8859-1?Q?GRk9tdK29WLac4tK5tG7n8APTRG/S2Mrtq6H5it2KmcPqNJVMEv/0Dwi1w?=
 =?iso-8859-1?Q?UoCz3OE2EeNBi7Q67P4Fl9TA2en3zJwrOhZtah7YgwcUdp9kw3RB7ZlKMD?=
 =?iso-8859-1?Q?onLi0CUI0Cz+lhuTr6zp/iUcAYt4bIlauKJEphL7dP8LIY8PgiP9+cjNq7?=
 =?iso-8859-1?Q?l/BjNdlc+2WwKGmITSsHdigZ3rgLPMj5Yh90lXtKM1iOvvsmHck+x1KMob?=
 =?iso-8859-1?Q?9linmMkmj3DWTKSrr8ioyg/JqMo+AHnNmyKtBiFPN+Qp6uHVqiNzXcpQI9?=
 =?iso-8859-1?Q?M/QKOPtSOc5vOHbKs3KWpEPdOvV1xZjSVAoziOFOy6bkrKjMD4MQ52vzxm?=
 =?iso-8859-1?Q?hVVl3/DjqUeHYNSlxfTg3lP0SEMxpEFNgejQdpmB6Ag8KNLuz3fz2yh9iL?=
 =?iso-8859-1?Q?t0an9oPeKxHX6jSl5sQbHlPSxLnUokOlzyzWnVmfl6mA/9UhIEXhDEr8JF?=
 =?iso-8859-1?Q?iO6TGgPKS1dAk48T13KehwAk08wZ3MCr2nqab/2/I+sDHIuf80/UKHGQcL?=
 =?iso-8859-1?Q?NWBEPEppvG0AcE1a7K5/vJGciOni1N0KQom0L0CL8crPcNS780+RvBsMcI?=
 =?iso-8859-1?Q?IUJyPprfods/kYTDhaoCr/6rygA1T7rh/I+HGm1pnnNqaxOn00ETz7Eg3T?=
 =?iso-8859-1?Q?hDsW+it9AkJscoPkv2UjRBIp7HJv2Hn5V6cSqPrFTYeBruOZ+qpZAqHaQR?=
 =?iso-8859-1?Q?ZMCFE2kLWd2ZSw/z4jHMzQTAVf7mmXcDsinvuxBmdxYSX2K7VWe+abqsTF?=
 =?iso-8859-1?Q?wEfSvJoTx3A4YLN3JFUlFcTU54KkzRujC5CjaFKwlxKIe6+h3U0CtO24q1?=
 =?iso-8859-1?Q?8GI3JXEHm0Zu+f2aVczOo0twABp17mZod24vIgObuWmn9hmkbDOKVqQ0xB?=
 =?iso-8859-1?Q?INzM0KLAAHN2nqE8WWidzz4Et4OWsbykNqHelU/rIG/9NdF2kYgjhmhmKE?=
 =?iso-8859-1?Q?oBj6S9z94eIXffAI6OvmgabRVj9IxPRXTO8/5Xv7c8Tn8OfP5cq00orKO2?=
 =?iso-8859-1?Q?9Ce261vQ2cVOpB3VR0K8hT4qpqW3yxWmiy5oPJwmiAzadrXb/7g6zQw8Uj?=
 =?iso-8859-1?Q?WYQuE5cnsyf/VrYIrioF/EdXdLfXBh1pEe6QfUbUyv75gsH/pglcfeM5jw?=
 =?iso-8859-1?Q?qG66+CHFvH4yRBjPaS5o1rYXMKqoh8VDyrK1BXeueklN7PpcfBanPlDhUo?=
 =?iso-8859-1?Q?FkgPrb7ECcHGdX8TbkHch/DPKJBcEl9n3T8q969JUPfTnYjRikyENBU7OU?=
 =?iso-8859-1?Q?K+Ck3j9FxafMvHE5KPXGRh4JamPzw7qFZr70HjcqG+xXV1p6trv4vNjCyY?=
 =?iso-8859-1?Q?HMIFi/c+X+EWPwvSpc6rM0yYfQY3ueU5upBoT+i1mpW3It0Cx6mtnnh55T?=
 =?iso-8859-1?Q?j6Tjzb04ZA6VgJXZAXQT22H0z5j2l7AAYgzE+Ae6fNmIbvLbwXfxntmKl3?=
 =?iso-8859-1?Q?2knVkqhSJGnKztR/7duas5BfKR+NnuwAGf1jHJVpcYw7tMtstgh4XsFZbc?=
 =?iso-8859-1?Q?4ituesPWryQg2JwN1SrmWqryBy3T0E+2GtZB7Vynspi4i4j4GUE0G1fwE0?=
 =?iso-8859-1?Q?ssaHlq0SYVzkUoYI15NrwnuVXRV8vZMvqB9ImgpqL50ehfQBr2ia06GYJY?=
 =?iso-8859-1?Q?eA1Vv15e7KKsdYtLHCx+pkh0YmTGV+elrLzTXd+oZNJoSX5A3bb7QLsl9G?=
 =?iso-8859-1?Q?kFG5NWRrO360OiWznXoaTGNA6llnPu5+bp9J6U0ZHjK52nMOrJG5vEg1bD?=
 =?iso-8859-1?Q?lJ3ZSszx+A=3D=3D?=
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-Exchange-RoutingPolicyChecked: NjlG0UiOE09Bi2jLQw34lOvf58TK9+OXEck0NTrV0A8Q3pDKyfmsKq669/ssAhL6seMQ0PKWAw7tQr2nBHOpLq00pnv3iVGFfgjpxbsFncDxJ8/bfboaOLl1FKYuXXJ2q/KHfpm/knQ/NIMl1m2PJVYFwVLE8U9sitZ+wYsF9VBcpmsPwoBBIVkmDlNCtDWeShp5lFuYlo2Sc7H1QaxqiWZ7hKE79abu819B6I5lxWlPYEa298dZFzm51866LwvNO9APs2VPzsto8Nck0b9YVisdNOa+Dfd1XVSikWR4Rtb5Mp6TFIulS7CXoBiurSkJ7GJSL4E8hm7FWzqHtEnCkg==
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: CH3PR11MB7177.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 8545f0a9-a677-447f-9731-08de84b13e1a
X-MS-Exchange-CrossTenant-originalarrivaltime: 18 Mar 2026 05:43:11.8589 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: GrWyQV81HAYjquy1pIRep/o4eGlAvoKz/h3uu4zNlK7ixrusUrKdNflOzKXx170P7/KMWnHDzZWUMrmeXcquzwlNKSpjn6d5JGq7lz4bAkk=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS7PR11MB8853
X-OriginatorOrg: intel.com
Received-SPF: pass client-ip=198.175.65.15;
 envelope-from=vivek.kasireddy@intel.com; helo=mgamail.intel.com
X-Spam_score_int: -26
X-Spam_score: -2.7
X-Spam_bar: --
X-Spam_report: (-2.7 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_MED=-2.3, RCVD_IN_VALIDITY_RPBL_BLOCKED=0.819,
 RCVD_IN_VALIDITY_SAFE_BLOCKED=0.903, SPF_HELO_NONE=0.001,
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

> Subject: Re: [PATCH v11 06/10] vfio/region: Add a helper to get region
> index from memory region
>=20
> On 3/17/26 15:41, C=E9dric Le Goater wrote:
> > On 3/11/26 03:50, Vivek Kasireddy wrote:
> >> Having a way to figure out the region index (or bar) associated
> >> with a memory region is helpful in various scenarios. For example,
> >> this capability can be useful in retrieving the region info needed
> >> for mapping a part of a VFIO region or creating a dmabuf.
> >>
> >> Cc: Alex Williamson <alex@shazbot.org>
> >> Cc: C=E9dric Le Goater <clg@redhat.com>
> >> Signed-off-by: Vivek Kasireddy <vivek.kasireddy@intel.com>
> >> ---
> >> =A0 hw/vfio/region.c=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 | 14 +++++=
+++++++++
> >> =A0 include/hw/vfio/vfio-device.h | 10 ++++++++++
> >> =A0 2 files changed, 24 insertions(+)
> >>
> >> diff --git a/hw/vfio/region.c b/hw/vfio/region.c
> >> index 47fdc2df34..4cb92216ef 100644
> >> --- a/hw/vfio/region.c
> >> +++ b/hw/vfio/region.c
> >> @@ -539,3 +539,17 @@ void
> vfio_region_mmaps_set_enabled(VFIORegion *region, bool enabled)
> >> =A0=A0=A0=A0=A0 trace_vfio_region_mmaps_set_enabled(memory_region_name=
(re
> gion->mem),
> >> =A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=
=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 enabled);
> >> =A0 }
> >> +
> >> +int vfio_get_region_index_from_mr(MemoryRegion *mr)
> >
> >
> > I think you can move this routine as a static in device.c now. No need
> > to export a service.
>=20
> you can't because of vfio_region_ops.
>=20
> Returning a VFIORegion seems cleaner though.
I agree. Will make the change in the next version.

Thanks,
Vivek

>=20
> Thanks,
>=20
> C.
>=20
>=20
> >
> > Thanks,
> >
> > C.
> >
> >> +{
> >> +=A0=A0=A0 VFIORegion *region;
> >> +
> >> +=A0=A0=A0 while (mr->container) {
> >> +=A0=A0=A0=A0=A0=A0=A0 if (mr->ops =3D=3D &vfio_region_ops) {
> >> +=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 region =3D mr->opaque;
> >> +=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 return region->nr;
> >> +=A0=A0=A0=A0=A0=A0=A0 }
> >> +=A0=A0=A0=A0=A0=A0=A0 mr =3D mr->container;
> >> +=A0=A0=A0 }
> >> +=A0=A0=A0 return -1;
> >> +}
> >> diff --git a/include/hw/vfio/vfio-device.h b/include/hw/vfio/vfio-
> device.h
> >> index 828a31c006..596c7f5a10 100644
> >> --- a/include/hw/vfio/vfio-device.h
> >> +++ b/include/hw/vfio/vfio-device.h
> >> @@ -308,6 +308,16 @@ bool
> vfio_device_has_region_cap(VFIODevice *vbasedev, int region, uint16_t
> cap_t
> >> =A0 int vfio_device_get_irq_info(VFIODevice *vbasedev, int index,
> >> =A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=
=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 struct vfio_irq_info *info);
> >> +
> >> +/**
> >> + * Return the region index associated with a given MemoryRegion.
> The index
> >> + * can be useful in retrieving region info.
> >> + *
> >> + * @mr: MemoryRegion to use
> >> + *
> >> + * Returns the region index or -1 on error.
> >> + */
> >> +int vfio_get_region_index_from_mr(MemoryRegion *mr);
> >> =A0 #endif
> >> =A0 /* Returns 0 on success, or a negative errno. */
> >


