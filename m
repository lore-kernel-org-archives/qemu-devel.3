Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 174BDC3DA49
	for <qemu-devel@archiver.kernel.org>; Wed, 17 Jul 2024 02:39:32 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sTuYz-0000KD-2v; Tue, 16 Jul 2024 22:38:42 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <zhenzhong.duan@intel.com>)
 id 1sTuYx-0000Jf-Ik
 for qemu-devel@nongnu.org; Tue, 16 Jul 2024 22:38:39 -0400
Received: from mgamail.intel.com ([198.175.65.10])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <zhenzhong.duan@intel.com>)
 id 1sTuYu-0005aY-Q8
 for qemu-devel@nongnu.org; Tue, 16 Jul 2024 22:38:39 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1721183916; x=1752719916;
 h=from:to:cc:subject:date:message-id:references:
 in-reply-to:content-transfer-encoding:mime-version;
 bh=3q6hhDYxbz105mM5SBQS1whu6dbBSRv6iAYCTwKZ5sU=;
 b=adencBrvkp9DhE0ELcqHacRxmqCzt3BBb3pcapbmHk3M3gsX3gxkCYm3
 XqmI3XxdY6pNmuuXsrCWMwZgn4wrMbmP8qH8LDBum/LQc0iQ8Id8rgCXn
 H89ivO3gMG0BHRXUYh+hEUd/fWt5uVhGHxnh5oGLMqglI6/IhdcqJuRXK
 XbD5Fo6o2O8bC+hFKznI8xl67yyBLU6VOKbNnBMjfmx+VLPR+VzuLebyW
 l78sTpV1ONXStjtrrMM1lo1JfSWIAdMLGA2WFW0QWWSvuGvjhOs+pnGnM
 YgZ4csxQPzS9rBNeRuolfMYynrSw5J2WDCwlMi8vhh7RIadILKnDxGZzr g==;
X-CSE-ConnectionGUID: BOB2WJfcQ/+9WsKCJ6Lfdg==
X-CSE-MsgGUID: 4KAL6uloTgySbJZPNGNFGg==
X-IronPort-AV: E=McAfee;i="6700,10204,11135"; a="36102270"
X-IronPort-AV: E=Sophos;i="6.09,213,1716274800"; d="scan'208";a="36102270"
Received: from orviesa006.jf.intel.com ([10.64.159.146])
 by orvoesa102.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 16 Jul 2024 19:38:34 -0700
X-CSE-ConnectionGUID: /DZ6gGz6SimkPCMtCTuZKw==
X-CSE-MsgGUID: JpX81LURRraO5Kdu77i5mg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.09,213,1716274800"; d="scan'208";a="50574653"
Received: from fmsmsx601.amr.corp.intel.com ([10.18.126.81])
 by orviesa006.jf.intel.com with ESMTP/TLS/AES256-GCM-SHA384;
 16 Jul 2024 19:38:34 -0700
Received: from fmsmsx601.amr.corp.intel.com (10.18.126.81) by
 fmsmsx601.amr.corp.intel.com (10.18.126.81) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.39; Tue, 16 Jul 2024 19:38:33 -0700
Received: from fmsedg602.ED.cps.intel.com (10.1.192.136) by
 fmsmsx601.amr.corp.intel.com (10.18.126.81) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.39 via Frontend Transport; Tue, 16 Jul 2024 19:38:33 -0700
Received: from NAM04-MW2-obe.outbound.protection.outlook.com (104.47.73.168)
 by edgegateway.intel.com (192.55.55.71) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.39; Tue, 16 Jul 2024 19:38:33 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=NSaMkSE6Kysqw7KatjBGJEmYSn0XV6oIdncZjaetzzjJ6aAFht5kLSlF/Vb6Xt2QDTBB0tR9TsD9rSU2Fhm9BRTrhvAJLWuhPfIUraFVq7bSpIXceNHNUwB9tHKxrioNpj+hokcPIkl0k6roM3iOlNIEY8ZstEP1qfNsHibr634F/9veN16gwdEre2RrVrwkGBx4FEpX1X9v0Q92qQJmFq2vjP9XEfiL+aOG7JnFI5KTCHErAcUGig2xYmrYQ82cKNdz8cAcbxhLTwTIS8mKzDwwHkoJ2uubAEHLWlKHsYH1LEO4He6iqdKtT9DQaTzfyjFSDEPhlkw+U/QANuhAYQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=k7AT1y4QuPr6JeGESwEnL/SQ8oG1YbAMw1qkQlm9/3s=;
 b=jqcFpAX5xmDX0dwcMc96AU1QiHj3qTfyEQm+be1HpTSg81KWV92f9rz6NIhkDnxo2EVKy0Wp0TxlQmy8r9rbEwqAVsMrp6CU51jhPiS0uBseLfr7aHHikUNps+amaOCgf2mMpkFUFnEE231C/z6YWGgT+zzK6zG1ef9V7U3jp08cXv1PFy4T7Q9/Wc/ummnr7SBmARVrHR+roQf7cBZZ8wtGNzpLUTszcM+DrKx8IVUyeCzqlFFFiYXy7LUyMG+3yItY6XDsCPf9FiwDWKvu3A/PTZa/xAUSautg4AUZZWGiC9h3vjrm2z4ab7E5K7qkwyf18GJvuZwvc8B20Bdtow==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Received: from SJ0PR11MB6744.namprd11.prod.outlook.com (2603:10b6:a03:47d::10)
 by DS0PR11MB7577.namprd11.prod.outlook.com (2603:10b6:8:142::20) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7762.27; Wed, 17 Jul
 2024 02:38:26 +0000
Received: from SJ0PR11MB6744.namprd11.prod.outlook.com
 ([fe80::fe49:d628:48b1:6091]) by SJ0PR11MB6744.namprd11.prod.outlook.com
 ([fe80::fe49:d628:48b1:6091%7]) with mapi id 15.20.7784.016; Wed, 17 Jul 2024
 02:38:25 +0000
From: "Duan, Zhenzhong" <zhenzhong.duan@intel.com>
To: Joao Martins <joao.m.martins@oracle.com>, "qemu-devel@nongnu.org"
 <qemu-devel@nongnu.org>
CC: "Liu, Yi L" <yi.l.liu@intel.com>, Eric Auger <eric.auger@redhat.com>, Alex
 Williamson <alex.williamson@redhat.com>, Cedric Le Goater <clg@redhat.com>,
 Jason Gunthorpe <jgg@nvidia.com>, Avihai Horon <avihaih@nvidia.com>
Subject: RE: [PATCH v4 11/12] vfio/migration: Don't block migration device
 dirty tracking is unsupported
Thread-Topic: [PATCH v4 11/12] vfio/migration: Don't block migration device
 dirty tracking is unsupported
Thread-Index: AQHa1FFf2/DG8eO1r0muhqTtcmW9tLH6O9Cw
Date: Wed, 17 Jul 2024 02:38:25 +0000
Message-ID: <SJ0PR11MB674456F8871EAC781732D0CD92A32@SJ0PR11MB6744.namprd11.prod.outlook.com>
References: <20240712114704.8708-1-joao.m.martins@oracle.com>
 <20240712114704.8708-12-joao.m.martins@oracle.com>
In-Reply-To: <20240712114704.8708-12-joao.m.martins@oracle.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: SJ0PR11MB6744:EE_|DS0PR11MB7577:EE_
x-ms-office365-filtering-correlation-id: fea494e0-a9a2-4aa5-720a-08dca609888d
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0; ARA:13230040|1800799024|376014|366016|38070700018;
x-microsoft-antispam-message-info: =?us-ascii?Q?LwcWKZfLPsMhF+HvayoVFOholVX0VoRT77A7AIFEALmrK6AqEDgCl3gluvTc?=
 =?us-ascii?Q?6/Su90CaSBAMIKqUB58+k7czMaR92LhQCK9/E33s3fqN+nOioSHzsoRGXYwM?=
 =?us-ascii?Q?XfpooNdfv7UNJ83b1EI7pSEmOkJoaF4DrB0M6LYV8+dPpIHF++pTwlYjjPc6?=
 =?us-ascii?Q?pj2B3omt/L+4LRnEbeiMwoqmmMT93tfCRX2sRWFDo3X68cV8Le1oWo0+tFEt?=
 =?us-ascii?Q?2mN8QvsX4zgsdYCsadv4yBFHHdGdVAzeZWEb2F0KEYlNkV+bmhQ98Wc7sbsH?=
 =?us-ascii?Q?qp63WCSRU2jyRjOqd4Fle/UkvbI1mG1USD2KO7pCFMR0lIbCukXEAhAA4sOZ?=
 =?us-ascii?Q?xM9L8IvJx3Fsn+fPMcxxaJggwc8OZcizyPC4Z0P46ib6W6AK29SJgA/xtw5Z?=
 =?us-ascii?Q?n5PBmuhuPJqQfoXQ17cqw4uimCd/vHiJn6hDdrS9YvqD5vFAx/Sis+ZDDEIG?=
 =?us-ascii?Q?nPbRZxh7t4kNg5LJcgEEASOnYwIBpHUMI7vnOJb3eCuC6IryVd/Qo86zIosA?=
 =?us-ascii?Q?LWrH3ktVe+zmhXyAZxf3NbpPkSk7f/6zaTSw0dl/n0B5xwaZ+glKOo9FiPnA?=
 =?us-ascii?Q?LO1+zBfUsuEZaBSv2CtJY0JFBUKRuFzYtLrrOEwz3ouE9hOsZCvztLenqny4?=
 =?us-ascii?Q?soRT8epjyowOf7DZX9rLVeMQtELB8hHzA2GXJOzDBB4p1wGLBECiTLIeBH70?=
 =?us-ascii?Q?mB9Rr4WWRjWieYhp+PUYPPes6tNdCLeBz7RAzwwkcXgRtsIsGuNwL9ymWz6Y?=
 =?us-ascii?Q?QnODbJAsZEKRDV0sgFcBXblWl60etcadtvxVy+oDKHsu7xoZlf6bQbQ+tl2m?=
 =?us-ascii?Q?om7k/D++Ii4DSZ54NsN2pqtguaSTGdI4CdBZQf4aCmESFt/5FlnsSadiXjQE?=
 =?us-ascii?Q?wcf1HsWtYzPT/C47Fb86X36AW2bcIl3uoBVsfQYDgWYgvP9tTmgChJd+pxFc?=
 =?us-ascii?Q?zauKlhwa00owkWRmOGzSfVYahbuu2BSAgwVhvr2/gT7w1x8r3sfU8LEYdj2+?=
 =?us-ascii?Q?SNSRo1GOMg799RDiPSbRrtJBxyxoDSdpxHYOW4pF8NdhKiuCUsffWCgLA08W?=
 =?us-ascii?Q?U1DWlAEu2L3QJOTYe2BO3JJhm35lFOF9c19XAKywe9dpYilvGS6HK4TmMkxL?=
 =?us-ascii?Q?F+4QLPdJ9TjGg0xr+Ghq+em/WiqzLZEyBobtAQ8cpT2fWwYlnZ90o4fS/R6P?=
 =?us-ascii?Q?cDAaP6yy+TNg8Co7q54De0bjoMfz4rKM2smSPYbBQAB3HrtDpllvAe+lfrlO?=
 =?us-ascii?Q?uB8dF9EG8711kDuG7Iy2FdFJTJVMlCUNirCU3Yd7Jj2abQY6WwdK2wb5Em0h?=
 =?us-ascii?Q?ZCgHMsiG17F6c4S9BKE74kO1oBrcC81mgZMu1YnaJ2Yd6ZJZ8CkPpXLidTDY?=
 =?us-ascii?Q?8ONL6Q3/uGR0AiI7YghGpRS3ZlV6ivwRyp/MdcuA1y+hWuU8zg=3D=3D?=
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:SJ0PR11MB6744.namprd11.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(1800799024)(376014)(366016)(38070700018); DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?Bx5AW2IWZgB0/iO2K/blQq92OFx+CG+54YEQeUiogOCLwxr/p5nsYGdXuXU1?=
 =?us-ascii?Q?dc37ZorVkH1ThGJwmBhcLbJFhFfuLyfgXxtWrOFtjsO/IH1VWGLxxZABmkAD?=
 =?us-ascii?Q?qWpgykd9vF5uwFgHut5TN91DC3/Vr6axcgt3D+J+JtoNuxRGleMISw9Liwx+?=
 =?us-ascii?Q?you+r/FBFM7bD/GMhQAwGZ75l/5CHAbINYYZVd+OtrTtrzRwt7CfeHYfGPdU?=
 =?us-ascii?Q?xjwzeQBGfU6bnEInqX3P04pfEOEvdhyjySOJnXtx5xok1MgsCgxxFFOYKQOr?=
 =?us-ascii?Q?ZWCmxh8KE4Pibl3X9g/NffiN/c+WC0WJbu/Y49py8/A2F3YTou4dlyL3vDSp?=
 =?us-ascii?Q?v64mDZ7uIXyEs9lfdhf2sROti2/S5r+u4TIDyX6l6KJYV7wQNRV4G1tKUDkp?=
 =?us-ascii?Q?9ZjgzfcOqCcINy7JJNc1ZKTKAZ5LVD6SdKbJjMPg+5Li1jbeXDADGKAjTuYy?=
 =?us-ascii?Q?8QaBN49I4pfnKGBcXMavaxfQGir2DRCHNYwWkN5MPDfJGUoG3Wq3ontOVhU6?=
 =?us-ascii?Q?d9jNJVPN8PPf8KhkHxIGPNgU/zbVEWS5pcVU3Ca2c+Op3TAwdWhMfsH0FRMJ?=
 =?us-ascii?Q?dsy30atAbpiwNk676VDUNVe9WmtRIVdjNuehchNgVf2cJlDz/jpE6WkQdW9I?=
 =?us-ascii?Q?ot5RAIfVrqvuxCS8HwulFdmsb7OWtwKyiuBK32SMhtkrM3/UIAxGs8b+k1LX?=
 =?us-ascii?Q?ZTFE+/8HjPwyG5FwjZHUCInOr8elKvBxs25+fYmTeJXw8FPAuCnxG7w7k/u2?=
 =?us-ascii?Q?3mGiIQ9D5tMS8Kx8ZUWYx09LRr78vku5pJJrJbrNl4GqNVTqtoJcuaoCFxjS?=
 =?us-ascii?Q?vzucoMwfhDaOa6aPgfu3xNOZzwhd4uOKW3hIPS/cx5m6hn3wd97Djl+5Qf6o?=
 =?us-ascii?Q?LvWn66K2SCgINWeQuEy844jFhHGF8V+nA7EUN1Rds0LRcXNsenM+jc+P0Y7w?=
 =?us-ascii?Q?AcchuDY2Qhsvkp9jx6sYCskcHaVT5ZWTCVoyXYJz7MXzw1WHHf2a3Hv+VcT3?=
 =?us-ascii?Q?Te9DgobnS3CenLwWbw2K3i0dfZ/rx2ZZ7/Ah+nxE9MPGqxVQTBjb5nd2KzPF?=
 =?us-ascii?Q?ec8v/mmHCEYNkVZcUFiQh3fbDncTxCAmW2jpbdfAlT4e+iU0VXR31SOZvv4y?=
 =?us-ascii?Q?t2um3IJ9mzXPYKr5U0eukHGhOlhFgcDbnpD+DuedIsHKAw3VNUU6soE9tZR+?=
 =?us-ascii?Q?c8k48ra0m38uXW1U+miruicexMhfALV7mjCuVm8nV9IKQLFbMq2ySs3KcbmE?=
 =?us-ascii?Q?a9iwfK8qtDrb5y95RoIjwhXyFu6j7vGhKXFhaGbKv/3rOvi9kXWSCZbMsbOa?=
 =?us-ascii?Q?VGT/HwwxnUuRpo4z42R+viNWLVm1rtlwilUk9zAuvWw5PyK0aJfDs9X8RGza?=
 =?us-ascii?Q?Pc0NCEFJdB578EPa7fi8VM7pboyfZDNXFwB0azh4oT1M25DO1h2wKq1aKjGh?=
 =?us-ascii?Q?qb7GRrSgKViHcQIDWxM81IV/x1EQ57pcpPh57AGdJXOE4iQJEXTiilO9A+5T?=
 =?us-ascii?Q?PFeTTOvVgrKoDkyJfnhqWVxf8WLZGvWZPRGJQS62nWNQiooEAopLEbT4Vu7B?=
 =?us-ascii?Q?ru79of28PjXGNwrVd19W9A6tBQGwT+Mc5okxJOCl?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: SJ0PR11MB6744.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: fea494e0-a9a2-4aa5-720a-08dca609888d
X-MS-Exchange-CrossTenant-originalarrivaltime: 17 Jul 2024 02:38:25.5531 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: Ccvl/Jc2xACqQrN5rqwOldAqZxOdUVoiQKWpXAVEi+DHP6aBxvPsdCgXUyLQjV25Hfwg4RSeU8HHWMCAPGHHtoV9Z+8gBMXkld8JzbJZukE=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS0PR11MB7577
X-OriginatorOrg: intel.com
Received-SPF: pass client-ip=198.175.65.10;
 envelope-from=zhenzhong.duan@intel.com; helo=mgamail.intel.com
X-Spam_score_int: -43
X-Spam_score: -4.4
X-Spam_bar: ----
X-Spam_report: (-4.4 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_MED=-2.3, SPF_HELO_NONE=0.001,
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
>From: Joao Martins <joao.m.martins@oracle.com>
>Subject: [PATCH v4 11/12] vfio/migration: Don't block migration device dir=
ty
>tracking is unsupported
>
>By default VFIO migration is set to auto, which will support live
>migration if the migration capability is set *and* also dirty page
>tracking is supported.
>
>For testing purposes one can force enable without dirty page tracking
>via enable-migration=3Don, but that option is generally left for testing
>purposes.
>
>So starting with IOMMU dirty tracking it can use to acomodate the lack of
>VF dirty page tracking allowing us to minimize the VF requirements for
>migration and thus enabling migration by default for those too.
>
>Signed-off-by: Joao Martins <joao.m.martins@oracle.com>
>---
> hw/vfio/migration.c | 3 ++-
> 1 file changed, 2 insertions(+), 1 deletion(-)
>
>diff --git a/hw/vfio/migration.c b/hw/vfio/migration.c
>index 34d4be2ce1b1..ce3d1b6e9a25 100644
>--- a/hw/vfio/migration.c
>+++ b/hw/vfio/migration.c
>@@ -1036,7 +1036,8 @@ bool vfio_migration_realize(VFIODevice
>*vbasedev, Error **errp)
>         return !vfio_block_migration(vbasedev, err, errp);
>     }
>
>-    if (!vbasedev->dirty_pages_supported) {
>+    if (!vbasedev->dirty_pages_supported &&
>+        !vbasedev->bcontainer->dirty_pages_supported) {
>         if (vbasedev->enable_migration =3D=3D ON_OFF_AUTO_AUTO) {
>             error_setg(&err,
>                        "%s: VFIO device doesn't support device dirty trac=
king",

I'm not sure if this message needs to be updated, " VFIO device doesn't sup=
port device and IOMMU dirty tracking"

Same for the below:

warn_report("%s: VFIO device doesn't support device dirty tracking"

