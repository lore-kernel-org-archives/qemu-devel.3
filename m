Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 954BFE6FE2F
	for <qemu-devel@archiver.kernel.org>; Tue, 23 Dec 2025 20:44:14 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vY9E3-0006Sg-Pl; Tue, 23 Dec 2025 15:43:23 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <vivek.kasireddy@intel.com>)
 id 1vY9E1-0006SQ-LV; Tue, 23 Dec 2025 15:43:21 -0500
Received: from mgamail.intel.com ([198.175.65.17])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <vivek.kasireddy@intel.com>)
 id 1vY9Dz-0001pu-Ay; Tue, 23 Dec 2025 15:43:21 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1766522600; x=1798058600;
 h=from:to:cc:subject:date:message-id:references:
 in-reply-to:content-transfer-encoding:mime-version;
 bh=tVKsia0kV/tAur2UTtU/C/5Q3xtDvJZSHlxkLC3t5wg=;
 b=KCt80X0nVmJSJfjELjjWo/n6RrlgfcrQq+7HXUUD6/qATBZJl4OfRHJE
 w9vdXQXgIOxEqj/yunExH1v2jp7VqdiLSKQxkGqANR1oO9zYefFHU6sWK
 Y15aOblKP7Hpj1JRxn8irC+a6OLZfQ/W9K8cVGOCJAyuRAmSGdTjfuDTM
 3L/Qiv33F4m5t5eHcKY/LIcggSufc03itaJQn3BUoeF6XIe8jJQqNDcaQ
 9FZry/9uz8YZ+kwItCYBmS4pUcuzVn9tcEBGmuZ8Vv+f0UDNA5/t2PwtV
 WKS8rZSKO48uFyyBOdpBX7FeDPsc2RjsspN7mkjG/sWCdIKPqAzifCtmn Q==;
X-CSE-ConnectionGUID: SLm9vqUKTsGCJJ4FFPRGcw==
X-CSE-MsgGUID: 7JvvV77iQqG+8HSuTFuaWQ==
X-IronPort-AV: E=McAfee;i="6800,10657,11651"; a="68355725"
X-IronPort-AV: E=Sophos;i="6.21,171,1763452800"; d="scan'208";a="68355725"
Received: from orviesa001.jf.intel.com ([10.64.159.141])
 by orvoesa109.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 23 Dec 2025 12:43:15 -0800
X-CSE-ConnectionGUID: AGmqSjHcTfiMNwGVdudwNw==
X-CSE-MsgGUID: TDqBAbF8Qli3pdJh7Na3Uw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.21,171,1763452800"; d="scan'208";a="237267413"
Received: from fmsmsx903.amr.corp.intel.com ([10.18.126.92])
 by orviesa001.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 23 Dec 2025 12:43:14 -0800
Received: from FMSMSX902.amr.corp.intel.com (10.18.126.91) by
 fmsmsx903.amr.corp.intel.com (10.18.126.92) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.29; Tue, 23 Dec 2025 12:43:13 -0800
Received: from fmsedg901.ED.cps.intel.com (10.1.192.143) by
 FMSMSX902.amr.corp.intel.com (10.18.126.91) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.29 via Frontend Transport; Tue, 23 Dec 2025 12:43:13 -0800
Received: from SA9PR02CU001.outbound.protection.outlook.com (40.93.196.19) by
 edgegateway.intel.com (192.55.55.81) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.29; Tue, 23 Dec 2025 12:43:13 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=H+McVA6eVTV9kqcNLcQxi1UDtlrlmlfFpWgd/k/pKR8SKOdyJY4l1mVWjUUYfgKFDTpwlHKcfGl9foROT9iRUon7Cf51V+SgssJoRkc/m7mOeSNh+OD/CF8S6kdRia1ZmGBflmJic3QHLqdLiFnj9YkQjv9T5E6Br6Rnp1hTcBSJwlXUxFTG/LTn0uM7MMkqBdG+NJJt7qEWvfKzvcDfX+YovPsIitAz5NTvXakA7ZtmXpJ8o7nXl7Z/bBrY84DBzOTi7zJLXxEvoph8mjTGyYhwoIySeQL30h9jGrMOywdf8p+3b59BaJSdvgP2yUPBTAN2qPstJtlgExTpmgg28g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=YJGjKDUMhsrvh4TgMExCRexBQGulNynmI6J1ZuUU+9g=;
 b=h0z4b0o1bqCpPMolxzVWDebZjZPzJtSYfnPdv9TyH91fD3eWaeaL33g4U7rCj5pcgpFoa432hErS60enM5moAa042OZOdzmdP/dTpKqNPw3hklcAfYG+Ti26qdSxY9yROOStwnSaNDfwUV0Uhv3NzZ++ws48UDa7oCoMlE+EWDiEcru9remooviK9Gp5tJjPoeJRTKfabhY+aVYKCo5+OdZ08VzFYiedIKsOe1lcjatASyNillf+cc0c9qJoJKyEVxwtFYEkuo4K+I8D5cBZLGlkWkYV0YFPiE7WOdSoaj76gpRiuaPSvuaPBP2cPqriClJ0ZdOVxT4dRd0CFbYYww==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Received: from CH3PR11MB7177.namprd11.prod.outlook.com (2603:10b6:610:153::8)
 by SA0PR11MB4542.namprd11.prod.outlook.com (2603:10b6:806:9f::20)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9434.11; Tue, 23 Dec
 2025 20:43:12 +0000
Received: from CH3PR11MB7177.namprd11.prod.outlook.com
 ([fe80::b997:e226:4979:c035]) by CH3PR11MB7177.namprd11.prod.outlook.com
 ([fe80::b997:e226:4979:c035%5]) with mapi id 15.20.9434.009; Tue, 23 Dec 2025
 20:43:11 +0000
From: "Kasireddy, Vivek" <vivek.kasireddy@intel.com>
To: Shameer Kolothum <skolothumtho@nvidia.com>,
 =?iso-8859-1?Q?C=E9dric_Le_Goater?= <clg@redhat.com>, "qemu-arm@nongnu.org"
 <qemu-arm@nongnu.org>, "qemu-devel@nongnu.org" <qemu-devel@nongnu.org>
CC: "eric.auger@redhat.com" <eric.auger@redhat.com>, "alex@shazbot.org"
 <alex@shazbot.org>, "clg@redhat.com" <clg@redhat.com>, "cohuck@redhat.com"
 <cohuck@redhat.com>, "mst@redhat.com" <mst@redhat.com>, "nicolinc@nvidia.com"
 <nicolinc@nvidia.com>, "nathanc@nvidia.com" <nathanc@nvidia.com>,
 "mochs@nvidia.com" <mochs@nvidia.com>, "jgg@nvidia.com" <jgg@nvidia.com>,
 "kjaju@nvidia.com" <kjaju@nvidia.com>
Subject: RE: [PATCH 3/3] hw/vfio/region: Create dmabuf for PCI BAR per region
Thread-Topic: [PATCH 3/3] hw/vfio/region: Create dmabuf for PCI BAR per region
Thread-Index: AQHcc1F9g7crGC62iUWwtkTmHwfxGbUvq5Tg
Date: Tue, 23 Dec 2025 20:43:11 +0000
Message-ID: <CH3PR11MB717754BE949E8270DC18A8F0F8B5A@CH3PR11MB7177.namprd11.prod.outlook.com>
References: <20251222135357.143339-1-skolothumtho@nvidia.com>
 <20251222135357.143339-4-skolothumtho@nvidia.com>
In-Reply-To: <20251222135357.143339-4-skolothumtho@nvidia.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: CH3PR11MB7177:EE_|SA0PR11MB4542:EE_
x-ms-office365-filtering-correlation-id: 723ce7ab-1675-44e6-5c79-08de4263e364
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
 ARA:13230040|1800799024|366016|7416014|376014|38070700021; 
x-microsoft-antispam-message-info: =?iso-8859-1?Q?c3l9PlfCIAVzS1MXDLQ1rrMHONdllK/U7ZUG+mo+xu1ZCPMgaeqjnvTLPh?=
 =?iso-8859-1?Q?KFcpN/48dIh84PVS7wur71JbKu8g8lU0l4xeCS9RM5EEDQ94g4ScyBRLLB?=
 =?iso-8859-1?Q?Lwjm/Ik9YcjYe1PFzwpjRv0Q0jRt3IizK66pqS8IgiVh0ha94v1p/SxVq5?=
 =?iso-8859-1?Q?svTgFwHIpnZHmc6g2GEipVwt4T0RysnAEC2jCdM7O8cj1064343KYYK047?=
 =?iso-8859-1?Q?EC+MSkVukAlzsd+VQ8twDaa762KWFa1f3KiCKrzMiulNwNaEk9Cms1Z9ik?=
 =?iso-8859-1?Q?dWh491dB45B8Du3jkO/M2awTGX+V55eGRkLpCxntkrBLNfl/QgUk8Uev37?=
 =?iso-8859-1?Q?yT5/JEyx7oupxK4PzsXETDC3l0RkQb8dtbPsmTMNBzGLtO2rOf6Vf07y9R?=
 =?iso-8859-1?Q?BUwIi8njBkUtDp99ddyTb9d2uZI2aT4NOZ0sGfgrVeNEbZBVAzqdKzpsZX?=
 =?iso-8859-1?Q?YsSSq3w0Y5zkcbsRAN8SxbHB+sP1GmankwVzzgeM5lgLCxg3OJk3kbsuse?=
 =?iso-8859-1?Q?571GEljfoJLp4xesyHbigtcYwhSrD6zErhYZl5IRltbxvTxrdYMZ0ngLtL?=
 =?iso-8859-1?Q?Ei7Sc95TaSZimf0cYB5GZZxx6UuIxWFoS/fZCUSZ9LTN9Ydn5q9WkPcsB8?=
 =?iso-8859-1?Q?5LG6Nz3nj6nicx7XMMvwukrHzegGQZLQJ0f4pSiP2PF5RBB6i80JhaL9VJ?=
 =?iso-8859-1?Q?S3k88cTx2CHYWqu8zkZMH4P538oAwaI0ExzX7edaA/7jR338l1LmHY+fxS?=
 =?iso-8859-1?Q?uPqem4oI0KqJGyDKS3fyNmAVbdNLs2xPMC9J/cvzeCeF3J06AF2KuRtApe?=
 =?iso-8859-1?Q?23AcCG6kCm65ZeGMJ5hRonfq4LUKVGzhfEnGOYObmZq7kRIUaFo6Esed/f?=
 =?iso-8859-1?Q?8SspgpxdmnPbxs6APgMkzcSZYVb+BnE2NkY8DLEKCmeQBSTWg4MUYGBXs5?=
 =?iso-8859-1?Q?+60UsWPVtSN/qA9KFk3WDuvVXRt7WiC+BPFV5/0KT5Oy2EHEMsvvq8jnFD?=
 =?iso-8859-1?Q?RDMF8iRY2+r5Mmp1emAanxqj9z9xUToNtRUKP0cW4zz9mmoZvojugeNp9/?=
 =?iso-8859-1?Q?m/K6sdXMVK2f5RACKhPtdsjqOgwamqIuQEx6aW3tvp+KwycoM33QrLzW66?=
 =?iso-8859-1?Q?sHF2Eq7woVcwFDLuuNCrRNPLxf5zsYsKsYW/PhlrIrtoiDSLeOEJVbeEol?=
 =?iso-8859-1?Q?gXFo2a11Nn5jy0988PDaU3Wu/OomF3rS5zRleBulYp6rao7fnCILPJKWzn?=
 =?iso-8859-1?Q?JBOc7LYiRmMele0SpGtm5+UOvRJBWAekWvvl+jv6qItIjy4M60djo/ILDP?=
 =?iso-8859-1?Q?gKiHdHJV+rNFgxOtVQ4X9X1uzNKJx8Zb5j2d1/+WHxGhDonY88win0dfAD?=
 =?iso-8859-1?Q?ILsUxM2re9KejfNRmvpYCAnmnpuxFStWxMVjdk3vauybGSPN0V9NxVNHTb?=
 =?iso-8859-1?Q?hDx1rHmL/WusHlXLPVPERDsHdqD5PHKQsigljcnNw1BhMqREuaN0dO/6hu?=
 =?iso-8859-1?Q?pWmJVEQxSy+5h0u6FTOEd3BCl9SjNNLvjWHTnGvnZgJ8XVmvpxuNzX2QW5?=
 =?iso-8859-1?Q?VrXTme02SNYA8uTeYz2p0sNF5JZa?=
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:CH3PR11MB7177.namprd11.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(1800799024)(366016)(7416014)(376014)(38070700021); DIR:OUT;
 SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?iso-8859-1?Q?U6VEl9UuOzZDl29eSj2P+OD8wcvhfylrpOQ+K3JG9+PpVo00GaD3shvkXE?=
 =?iso-8859-1?Q?54VeymG0BXA7cIii4YgWHWiXtZbQZs9y37jB/NNKF3yYE9Vit38EyCouS3?=
 =?iso-8859-1?Q?zD9tA78fzXkuO94sfTG22ynHjf5fnJaNbh3Rpj+fwywscFf/NEIPOV0iIv?=
 =?iso-8859-1?Q?MV9TmcVBCUq/Gt43Rx1w4U3LsfNwMZL4VPp7YhMkH5wxiS24K5Oe1taK6o?=
 =?iso-8859-1?Q?Lbn/G/TmwWIahCVbLJlV+en25iLZmoejWE1FACtu2I+seBwHsKp+ENt6D2?=
 =?iso-8859-1?Q?epNYTk+hfvJrh91dsH594DykJu7vygKUvANoTK+pWwJQni+tLwv1LzQpda?=
 =?iso-8859-1?Q?mXYLU/bjjOW3gi8cI8G2Mx2UHq2k4epgHZyBjCowGPuNQvzE7sAc/owWgt?=
 =?iso-8859-1?Q?nb1ZZRn/+uKgDkcLEx+D97XTEy9JlVvv3O5oUSm0CP5Vt+f9Lum7m37uAK?=
 =?iso-8859-1?Q?xNszim2TMGffAxNE8ej6jcLUwMigEDmcJr3U5DdV3KoAlP0owd2SMOnmfP?=
 =?iso-8859-1?Q?qvRdm5LtzULVYJI9YARQEoPCdAomM/neX7YehTzNt4NZnxmHIVDp0oDDtJ?=
 =?iso-8859-1?Q?Xldip1rOkIcglaOuJ/zgeAyDaQQ96H7Tcck7OwT+DDtichrIwdXBTGmJmt?=
 =?iso-8859-1?Q?BqFCqWuVairI4wEABit0xpvJc/dG5zieP9Df2zL/B6WB+ZcX/Qe32m/nUm?=
 =?iso-8859-1?Q?0lxICM0syzQmjM4f1YE2rwVv7dZOkRrHhdp1nWvUB/6SAkV0ANVCr9eqDS?=
 =?iso-8859-1?Q?Kj8m9krOO37JafqFM+bCeQd9CLNM4TPfaUFbabINZO/l79RSKA+j5o0tkb?=
 =?iso-8859-1?Q?FvxQsYq3GAKyMhJAv7AnpH/A0Ue3Ghc9nBdG3xX0wVQslT9b7lvp1jFVL0?=
 =?iso-8859-1?Q?jqUZdjSt4+nnW4giek4iGZiVOYo7SQGpBnuKbLHlHdO7aR9d9j5zgQri0Y?=
 =?iso-8859-1?Q?YBcLY9cl02NAwi76BEYtnG1X6ohoC4IbTqa6HxmCbmsHQyPcTxWRj1jgxZ?=
 =?iso-8859-1?Q?KmJIgyAblzLn7Jb0IbHCshL/h4AZzEgf1tsZqSAN8gmPVIjaLNmjJQkRfv?=
 =?iso-8859-1?Q?j5r2YuhCHXRRYPZ6YAmSRP74U0ssKHTKxyhjbUUF1KiuqdG6vO6/S2WBmw?=
 =?iso-8859-1?Q?dcNbEg5eEQOVpOAW7lN3dVyZ9oJ3PBd/itpVRYqSPF0gcZYKR8CW0JRqLo?=
 =?iso-8859-1?Q?NGIu36VU9tuWo7bsaZf3NY3v3K0Lzo/tIXuzIWdur2tLaQKwRTQ65ZDqIs?=
 =?iso-8859-1?Q?M+wdqpDSVOs5ix+OaatLlCMMGR5c28PONE5MgsYR7Sc0NdflYruiPVBYLe?=
 =?iso-8859-1?Q?rCz1mHQzlF4G2ia/fifrwmPY9aTtFLY78Zwfn0iOd4twY1cdQAf+oIaWZn?=
 =?iso-8859-1?Q?NMoiU4FzsPS2RHjecLI/MW3JgQRMmoqeWNYNvoRytX8h/eLkIGfSIw5Nfb?=
 =?iso-8859-1?Q?4j/n3c8nRDKo8eLtD9fFWAm217EbMO1e23J83JmY4h4c1uga/YCYjTIJ8g?=
 =?iso-8859-1?Q?L/PuzBi9zBAUHezaPgfRzsQrqoGi0fhV0ukOpsMgUYWzqI20+CxQ4rHmH0?=
 =?iso-8859-1?Q?Wf1J+cRYm41i//6GK22Q1l1yu+mNtRNu3JoTkk+iGKU7LcE6nFlhBfwt+Z?=
 =?iso-8859-1?Q?X9ZRyawy7BCjcoYmkTRwX5lirhX0lCoVhi2ELmiMgTfO/1QWvRz3fxAzmV?=
 =?iso-8859-1?Q?pw/nMldNz/vUMzjrnOrvMtdv07TYmD83JfbXrkqjXDwdLHjzmMo6JKkFW0?=
 =?iso-8859-1?Q?H6k79+iYpClVYRj8eiuHqmzrfSmhn/Ps9RDUYHalEH/oMRfpcH2uGVcFX0?=
 =?iso-8859-1?Q?N5OZ6qcVVQ=3D=3D?=
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: CH3PR11MB7177.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 723ce7ab-1675-44e6-5c79-08de4263e364
X-MS-Exchange-CrossTenant-originalarrivaltime: 23 Dec 2025 20:43:11.6589 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: B0vw7oQUn6pW/NKGmfI2q0MNyIlWVJkBrk/uiBKET1OeHCsahRAO90cuODNx8bD5QrRbePoSlQpNM2V6NYTw1GQVypjswX5trHHcfVffysA=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA0PR11MB4542
X-OriginatorOrg: intel.com
Received-SPF: pass client-ip=198.175.65.17;
 envelope-from=vivek.kasireddy@intel.com; helo=mgamail.intel.com
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

Hi Shameer, Cedric,

> Subject: [PATCH 3/3] hw/vfio/region: Create dmabuf for PCI BAR per region
>=20
> From: Nicolin Chen <nicolinc@nvidia.com>
>=20
> Linux now provides a VFIO dmabuf exporter to expose PCI BAR memory for
> P2P
> use cases. Create a dmabuf for each mapped BAR region after the mmap is
> set
> up, and store the returned fd in the region's RAMBlock. This allows QEMU
> to
> pass the fd to dma_map_file(), enabling iommufd to import the dmabuf and
> map
> the BAR correctly in the host IOMMU page table.
>=20
> If the kernel lacks support or dmabuf setup fails, QEMU skips the setup
> and continues with normal mmap handling.
>=20
> Signed-off-by: Nicolin Chen <nicolinc@nvidia.com>
> Signed-off-by: Shameer Kolothum <skolothumtho@nvidia.com>
> ---
>  hw/vfio/region.c     | 57
> +++++++++++++++++++++++++++++++++++++++++++-
>  hw/vfio/trace-events |  1 +
>  2 files changed, 57 insertions(+), 1 deletion(-)
>=20
> diff --git a/hw/vfio/region.c b/hw/vfio/region.c
> index b165ab0b93..6949f6779c 100644
> --- a/hw/vfio/region.c
> +++ b/hw/vfio/region.c
> @@ -29,6 +29,7 @@
>  #include "qemu/error-report.h"
>  #include "qemu/units.h"
>  #include "monitor/monitor.h"
> +#include "system/ramblock.h"
>  #include "vfio-helpers.h"
>=20
>  /*
> @@ -238,13 +239,52 @@ static void vfio_subregion_unmap(VFIORegion
> *region, int index)
>      region->mmaps[index].mmap =3D NULL;
>  }
>=20
> +static int vfio_region_create_dma_buf(VFIORegion *region)
Would it make sense to consolidate this implementation with the one from my
series: https://lore.kernel.org/qemu-devel/20251122064936.2948632-7-vivek.k=
asireddy@intel.com/
so that it is a bit more generic and can also be invoked from outside of VF=
IO?

Or, is it ok to have two dmabuf implementations: one that is internal to VF=
IO
and takes a VFIORegion as input like this one and another one that takes a
VFIODevice and iovec as input and can be invoked externally?

Thanks,
Vivek

> +{
> +    g_autofree struct vfio_device_feature *feature =3D NULL;
> +    VFIODevice *vbasedev =3D region->vbasedev;
> +    struct vfio_device_feature_dma_buf *dma_buf;
> +    size_t total_size;
> +    int i, ret;
> +
> +    g_assert(region->nr_mmaps);
> +
> +    total_size =3D sizeof(*feature) + sizeof(*dma_buf) +
> +                 sizeof(struct vfio_region_dma_range) * region->nr_mmaps=
;
> +    feature =3D g_malloc0(total_size);
> +    *feature =3D (struct vfio_device_feature) {
> +        .argsz =3D total_size,
> +        .flags =3D VFIO_DEVICE_FEATURE_GET |
> VFIO_DEVICE_FEATURE_DMA_BUF,
> +    };
> +
> +    dma_buf =3D (void *)feature->data;
> +    *dma_buf =3D (struct vfio_device_feature_dma_buf) {
> +        .region_index =3D region->nr,
> +        .open_flags =3D O_RDWR,
> +        .nr_ranges =3D region->nr_mmaps,
> +    };
> +
> +    for (i =3D 0; i < region->nr_mmaps; i++) {
> +        dma_buf->dma_ranges[i].offset =3D region->mmaps[i].offset;
> +        dma_buf->dma_ranges[i].length =3D region->mmaps[i].size;
> +    }
> +
> +    ret =3D vbasedev->io_ops->device_feature(vbasedev, feature);
> +    for (i =3D 0; i < region->nr_mmaps; i++) {
> +        trace_vfio_region_dmabuf(region->vbasedev->name, ret, region->nr=
,
> +                                 region->mem->name, region->mmaps[i].off=
set,
> +                                 region->mmaps[i].size);
> +    }
> +    return ret;
> +}
> +
>  int vfio_region_mmap(VFIORegion *region)
>  {
>      int i, ret, prot =3D 0;
>      char *name;
>      int fd;
>=20
> -    if (!region->mem) {
> +    if (!region->mem || !region->nr_mmaps) {
>          return 0;
>      }
>=20
> @@ -305,6 +345,21 @@ int vfio_region_mmap(VFIORegion *region)
>                                 region->mmaps[i].size - 1);
>      }
>=20
> +    ret =3D vfio_region_create_dma_buf(region);
> +    if (ret < 0) {
> +        if (ret =3D=3D -ENOTTY) {
> +            warn_report_once("VFIO dmabuf not supported in kernel");
> +        } else {
> +            error_report("%s: failed to create dmabuf: %s",
> +                         memory_region_name(region->mem), strerror(errno=
));
> +        }
> +    } else {
> +        MemoryRegion *mr =3D &region->mmaps[0].mem;
> +        RAMBlock *ram_block =3D mr->ram_block;
> +
> +        ram_block->fd =3D ret;
> +    }
> +
>      return 0;
>=20
>  no_mmap:
> diff --git a/hw/vfio/trace-events b/hw/vfio/trace-events
> index 1e895448cd..592a0349d4 100644
> --- a/hw/vfio/trace-events
> +++ b/hw/vfio/trace-events
> @@ -117,6 +117,7 @@ vfio_device_put(int fd) "close vdev->fd=3D%d"
>  vfio_region_write(const char *name, int index, uint64_t addr, uint64_t
> data, unsigned size) " (%s:region%d+0x%"PRIx64", 0x%"PRIx64 ", %d)"
>  vfio_region_read(char *name, int index, uint64_t addr, unsigned size,
> uint64_t data) " (%s:region%d+0x%"PRIx64", %d) =3D 0x%"PRIx64
>  vfio_region_setup(const char *dev, int index, const char *name, unsigned
> long flags, unsigned long offset, unsigned long size) "Device %s, region =
%d
> \"%s\", flags: 0x%lx, offset: 0x%lx, size: 0x%lx"
> +vfio_region_dmabuf(const char *dev, int fd, int index,  const char *name=
,
> unsigned long offset, unsigned long size) "Device %s, dmabuf fd %d region
> %d \"%s\", offset: 0x%lx, size: 0x%lx"
>  vfio_region_mmap_fault(const char *name, int index, unsigned long offset=
,
> unsigned long size, int fault) "Region %s mmaps[%d], [0x%lx - 0x%lx], fau=
lt:
> %d"
>  vfio_region_mmap(const char *name, unsigned long offset, unsigned long
> end) "Region %s [0x%lx - 0x%lx]"
>  vfio_region_exit(const char *name, int index) "Device %s, region %d"
> --
> 2.43.0
>=20


