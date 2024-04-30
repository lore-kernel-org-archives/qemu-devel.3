Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 34BCFC4345F
	for <qemu-devel@archiver.kernel.org>; Tue, 30 Apr 2024 09:58:48 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1s1kFY-0005wk-DY; Tue, 30 Apr 2024 05:58:12 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <zhenzhong.duan@intel.com>)
 id 1s1kFV-0005wW-Mo
 for qemu-devel@nongnu.org; Tue, 30 Apr 2024 05:58:09 -0400
Received: from mgamail.intel.com ([198.175.65.16])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <zhenzhong.duan@intel.com>)
 id 1s1kFT-0000OD-CN
 for qemu-devel@nongnu.org; Tue, 30 Apr 2024 05:58:09 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1714471088; x=1746007088;
 h=from:to:cc:subject:date:message-id:references:
 in-reply-to:content-transfer-encoding:mime-version;
 bh=sMYGDfqpXllkgmKsdcWeV+fdUgtuzAuGt08VgUXHBEs=;
 b=Xk+Dwm5dOe7krWZbdj/YjsIqwYKk4i6W4MBdK/oPADjpusZbKT8OmmcJ
 Wul+Nma10XlVECcP+4P+d99M9bVk58RV/1kpt89eQqZ5FAqgL6Fa6gOTS
 fV4h8oPJCJ05Q6lPOWihEPOHy8GPJuz6IzAzx4YT9XlLfmsAmTc7Xmk1Y
 MHaQH8c86QsU0blzEpnvNsSl6qyy7pLIK+sxQlgtritp3+wXsNgKxzOld
 buH/hBBvFCpCXl5G3HwcZOtZ5mX3pPvGBDYHHaVUFqz3DgAY+E3x24G+H
 jG91JxfxbaXrywTsk9iSPdD+nnZKi8INzj77BNVAXAXgE46Irma3mJ8Q+ Q==;
X-CSE-ConnectionGUID: yUbr0pURT8KNuTRbBwYK1Q==
X-CSE-MsgGUID: SOJNo1qSR6CThn+pgPz1OQ==
X-IronPort-AV: E=McAfee;i="6600,9927,11059"; a="10288767"
X-IronPort-AV: E=Sophos;i="6.07,241,1708416000"; d="scan'208";a="10288767"
Received: from fmviesa005.fm.intel.com ([10.60.135.145])
 by orvoesa108.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 30 Apr 2024 02:58:06 -0700
X-CSE-ConnectionGUID: sTihRypIScWlugAULZB5nw==
X-CSE-MsgGUID: j5PLcHi9SVG+K/J900+rNA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.07,241,1708416000"; d="scan'208";a="30889320"
Received: from orsmsx602.amr.corp.intel.com ([10.22.229.15])
 by fmviesa005.fm.intel.com with ESMTP/TLS/AES256-GCM-SHA384;
 30 Apr 2024 02:58:04 -0700
Received: from orsmsx611.amr.corp.intel.com (10.22.229.24) by
 ORSMSX602.amr.corp.intel.com (10.22.229.15) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35; Tue, 30 Apr 2024 02:58:04 -0700
Received: from orsmsx601.amr.corp.intel.com (10.22.229.14) by
 ORSMSX611.amr.corp.intel.com (10.22.229.24) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35; Tue, 30 Apr 2024 02:58:03 -0700
Received: from orsedg603.ED.cps.intel.com (10.7.248.4) by
 orsmsx601.amr.corp.intel.com (10.22.229.14) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35 via Frontend Transport; Tue, 30 Apr 2024 02:58:03 -0700
Received: from NAM10-DM6-obe.outbound.protection.outlook.com (104.47.58.100)
 by edgegateway.intel.com (134.134.137.100) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.35; Tue, 30 Apr 2024 02:58:03 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=eSy1LZw4J1F5E+yzPLS6U5sWLhyT/ghbn84i+kPijuKW7MXfIDNDHZtbh7F8hL/8BWVOkgoPqKKQUcFYXAQjkIB/QhM+RmFj6JACGiyGqesRhyTIkoSdAACrNw2rpom/U8pxrI88/HLqcXuuZ6zPk1XNwbjRhZuRW6RAX7GVk1r1OKu5Mk4dV1/eXb6xoZ4xHXe8VGX3VrjN7x73B39M/Ue6TGFoqnwy7Iyw4zkAoceOC825CIGDgkq9p7pixyXaSXnwow+mCCo0seVWAQgxnPtr5JVj36PIP/zRmLzYVuoNBhdLOBYfsZHdDU8lADoTUdF0LOTNMrGpRMMaRPxuXg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=sMYGDfqpXllkgmKsdcWeV+fdUgtuzAuGt08VgUXHBEs=;
 b=FpJmlRIWD5M/N/O2DeodO1kNNXxvrUMgmcfFaw/ur/UxZl/nUAXC7CZma/Jolg2f3jdvFEBCGg9o+0O9mlwjgDI2Q18HaLJrnbDLo2VuhvlAkzLb5woQsg9LQ5e0/pdYmFfQdlWV+pVubNYO0NZt7cAOXw13Zfm7l/1e1nAsHidwyy67sSMcHiN/jxTGtoJ74pvw/VtqwZ/1x7kAjdgq1DxQ/MZlsk19f0BxDCw3HHPSlG+gqCEdJ0HcmH3JCYfWMbLdZIkK3hLZCvgyivhQBn64R51cQAU4oD5P8YIlSa4/QN/ZhfTITfi4t+n6/vm8jlIXu21RN8mLEstiJiyH6Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Received: from SJ0PR11MB6744.namprd11.prod.outlook.com (2603:10b6:a03:47d::10)
 by PH8PR11MB6951.namprd11.prod.outlook.com (2603:10b6:510:225::13)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7519.34; Tue, 30 Apr
 2024 09:58:02 +0000
Received: from SJ0PR11MB6744.namprd11.prod.outlook.com
 ([fe80::e4a3:76ce:879:9129]) by SJ0PR11MB6744.namprd11.prod.outlook.com
 ([fe80::e4a3:76ce:879:9129%7]) with mapi id 15.20.7519.031; Tue, 30 Apr 2024
 09:58:01 +0000
From: "Duan, Zhenzhong" <zhenzhong.duan@intel.com>
To: =?utf-8?B?Q8OpZHJpYyBMZSBHb2F0ZXI=?= <clg@redhat.com>,
 "qemu-devel@nongnu.org" <qemu-devel@nongnu.org>
CC: "alex.williamson@redhat.com" <alex.williamson@redhat.com>,
 "eric.auger@redhat.com" <eric.auger@redhat.com>, "mst@redhat.com"
 <mst@redhat.com>, "peterx@redhat.com" <peterx@redhat.com>,
 "jasowang@redhat.com" <jasowang@redhat.com>, "jgg@nvidia.com"
 <jgg@nvidia.com>, "nicolinc@nvidia.com" <nicolinc@nvidia.com>,
 "joao.m.martins@oracle.com" <joao.m.martins@oracle.com>, "Tian, Kevin"
 <kevin.tian@intel.com>, "Liu, Yi L" <yi.l.liu@intel.com>, "Peng, Chao P"
 <chao.p.peng@intel.com>
Subject: RE: [PATCH v3 06/19] range: Introduce range_get_last_bit()
Thread-Topic: [PATCH v3 06/19] range: Introduce range_get_last_bit()
Thread-Index: AQHamgIOvrV76aEjm0SX75m+BoKnwbGAkQuAgAAEJuA=
Date: Tue, 30 Apr 2024 09:58:01 +0000
Message-ID: <SJ0PR11MB67440124211B42A33071CAED921A2@SJ0PR11MB6744.namprd11.prod.outlook.com>
References: <20240429065046.3688701-1-zhenzhong.duan@intel.com>
 <20240429065046.3688701-7-zhenzhong.duan@intel.com>
 <bc6b71f7-242f-4de4-b440-67689039886a@redhat.com>
In-Reply-To: <bc6b71f7-242f-4de4-b440-67689039886a@redhat.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: SJ0PR11MB6744:EE_|PH8PR11MB6951:EE_
x-ms-office365-filtering-correlation-id: 09078a4e-dd93-4ab7-4d03-08dc68fc05cf
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
 ARA:13230031|1800799015|376005|7416005|366007|38070700009; 
x-microsoft-antispam-message-info: =?utf-8?B?MUtEY3dwa0xDNlhkaUhtV2ZnbnU5a05sMlg3eXpjV0FiZ3lPNTl3dWRTZU5h?=
 =?utf-8?B?TEE4R2pydit5ZDRqdDJpa29vaGlmdVRoeTNVTStxN2d1NXQ3ME02bkhINVI0?=
 =?utf-8?B?aTVrRk1yS0JVdXQvdGFsVWc3Z3lwWDRyS3VCY3ZEdmZqL21Yb0ZWU0Q1Zjhi?=
 =?utf-8?B?NGZPRlhwUGZXd2JXM01jOUVWMWpSbjQwbDVJek4wVHJlbjRBT3grd2c3VG1B?=
 =?utf-8?B?bFQ2bWMzMk9nZFgrSEczY2xWT2VoSUhteDd3eU5BKzZnS3dWL2c5Q1BxQ2RN?=
 =?utf-8?B?YXpOL0QrUy9GWlFlMlk1cklzN0l0QzVIdHpQUGFpengzcVZUdGhBWUlYUU1Z?=
 =?utf-8?B?RytwWEp6Tk92eUFkMkpaLzFER2Y1MGtJNS9kU1RMbkZROEVwZkVjd1BuTmZT?=
 =?utf-8?B?d3M1WFhuSGZySXI2QjJiOGRKNzhQTVhpZDR1U2M5dGFpL0diUWVPdnZPd3Vu?=
 =?utf-8?B?c0pHamZjdmVlTm5QSlJ3TG8wV0ZHVGFXRTNMNkhEbFA0dG1zSi9uSytYd050?=
 =?utf-8?B?Q1YvcDFjVUJqYTNpL1lqazExUWl0V1lWZ2t1OGdhNXJXUzQ5Tis4VkF4dHhY?=
 =?utf-8?B?c0MvaWpqVWMra2EvQm9Dc3cxVTZOUnBLZ0paMldiU3ltdTVmT25FUHlKNkRV?=
 =?utf-8?B?eGc3dzU1a29kNkx3YlptWGROYUxGemVrcnBPK25obU01bkV0RnJWWTFqQ0pj?=
 =?utf-8?B?Y3N6NmdMVDlCNXJRODBOazRVM0xMVUw5bHllNUhLZmxhMnVQeEg2QVlyQSt2?=
 =?utf-8?B?S051QUY5L3RZTlIxdVBrMVZnSUhFNVN4SEwrc3c3SFB3OCtwc3Y0N05iNWF1?=
 =?utf-8?B?YklhMjNMaStqbUJDL2Z0NmRXeFJUbFVGNjR2M3NvYjJyWGtITERJclZ3SzAv?=
 =?utf-8?B?UHo1SEtjS2RSeXNsMUlKOWV4SzA0TGdzbHd0dzduZHZmTlMwRGhsYmVhK0lk?=
 =?utf-8?B?bDJXNXFXaGRldnlEcDkwR1BMcXFpRTQza2V6NjRzczYzNEpRV09zZzc4M0s4?=
 =?utf-8?B?dno4TXBwU2Fxd1dPZEtVcVZEMllHL3Ayb0tRb0NYdnIrQkF3SXVxaU5KLzJY?=
 =?utf-8?B?aldXQ1prVWVUVGE4eGZvcHNxNmJlTFZNN0RiTWJuc2xrQlNGdXZIUnhqTDRD?=
 =?utf-8?B?Sm10bXdIQ0J2WW84NUg3VTBxRXVlT0pOUjlPWnlRY2xmUjd4ekk0SUMySlds?=
 =?utf-8?B?N3pxejczS0JJU0REVEpyYVowTXBrVVZheGIvU1pIaFlLa3M4UTl5cFFrK3Fu?=
 =?utf-8?B?UDB6cG1Sc25SS3JwQi9JRytFSE9KMVhDbXVNV3UvRTkxWkNCSm10YTM3MllM?=
 =?utf-8?B?ZzdrTHRxdFN6ZUx2Wmplc3BkRFFUYlFqM09sZjVmMmRkTUozMGpGc2ZtTDdG?=
 =?utf-8?B?UzcwcFptUDNCU0JZYXozT2dFVEM5V0ZaYWdaWUMzcndwamdCOEJIMGdaaWZ3?=
 =?utf-8?B?THczckJoMjhHVDYvNHdlRFZEdU9odzNveTM3U3ZpdXlQUWxtcGJzS1plamo2?=
 =?utf-8?B?VXZNVU9QSXpkYzR3dWk2bDJMcGc0aU5vMVpobmszbTZBL0d2QmVCOXltMk1C?=
 =?utf-8?B?Zys1ZzIzR2NOendVS2ZUYzdpRkUrYmFraWtVUWRHM3FZQXJiYTFla1YzQnpI?=
 =?utf-8?B?Rk5EZlhhNDlRVEwxSkY0VWpzTU93VXRqeU0yb3pDSG56a0pIUWtkYjdjYUxw?=
 =?utf-8?B?UnQ3Zit6WGRPdmlLNzdKZGdvbXA4ZFFSam9HS3BkQmxwZzNjem9JUFJMVUFS?=
 =?utf-8?B?Wnh1SnNycWJvYklGb3hqUUxoMUJTYjhTbFFEcVhxVDJPUzNnWXdEdkVjRHJs?=
 =?utf-8?B?VVdCd1BNb2t3QnNzbUp4dz09?=
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:SJ0PR11MB6744.namprd11.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230031)(1800799015)(376005)(7416005)(366007)(38070700009); DIR:OUT;
 SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?d0d6YjRQTjdvTnF5QTNyWGlVUGY3bFk0Y3d5UGdIekIrSnRyNFRmcmozM2NE?=
 =?utf-8?B?Vy9VdkFubmRtNU8yNllyTWplNWdVcWNtRGhGZmZvQ2pKOXV5OWNLODhYbFU3?=
 =?utf-8?B?MkdvcnEzQUZ6NUd2U01aTnlVcytaUU04d21SOXRkZTVpNVQvbENVVlJkeC9k?=
 =?utf-8?B?MXFXaGhKcm8wWmVNMmVpVEczOStSRWNaTW1uaFB3bnFhVDJuMmVXZCtYNWM3?=
 =?utf-8?B?OE1GMWR3N1BwcWh2cC9XTncrSkxneUJWNEgyOGhnY0NwYUZVLzl2TVQrL3RE?=
 =?utf-8?B?Njc2ZER1S01xVEZaalN4WG9Icm5YVS8vVkhpV3pEUGlQMjRqd1hBUTY0cWFu?=
 =?utf-8?B?VWYzN1duWFpnTTQ5YU1NK3I3QXYrWklqV1lKbzVKQkc4U3FxOWdoOVlSeGh3?=
 =?utf-8?B?K1R5RUVRajdPK3JRemYyME1BbHVHNDhTMUpneXJZbGtpalA3NHhML0RTZmVx?=
 =?utf-8?B?eHoxZ0hjTVlhd1F6SlNBdjZEckZ0WkZTUnFSOTF2STlORzIwVWZGVWFEMVM2?=
 =?utf-8?B?SkFjQUUrNzFTL0tTOC9JT2xSditQc3VhZHl4Zk9ncjdLL09ySjN6SW9pN2dn?=
 =?utf-8?B?QkdyM28yY2k3YWFtVklZQjZ5YjZ1TXhDTjBNQU1rRkx2c0c0OGI5azF6bS9N?=
 =?utf-8?B?ank0Nzl3T0NPQmhQdnZyUWJzZEhMaUhia2FvUWJnRElJM2ZCa1QxR0hBMERI?=
 =?utf-8?B?cXVrMWQ4WjFqenNzRG11M20vM3Z3VjNCSDN6NWlYWDQ4L0VaR0tuNnRHTmJj?=
 =?utf-8?B?MVljakU1bEZwaUNDS0xObkp6ZkhzVUY2bnAyd0gyTE5kZlNPR0ZydU9GYnNh?=
 =?utf-8?B?Nm1WeTRyNXUxditKQzlQRDcwZnRFSSt1c05nSjF6ZkY1RmZiMi83ZVBRNmY2?=
 =?utf-8?B?bStSc3RsUEJXYlpFV1VUQmdhMXlzUFlOUlNyQzd2TllqVTdaekZ0ZDFVVElI?=
 =?utf-8?B?MDV5NFRRWmNzQXpyY0FjV0FkZ2Z5dWs1SzBBdENwaEQ0eW02ZDZKYWU5UE9y?=
 =?utf-8?B?UjVhUTBXYU9zdzhtRURRanN4TVlzYWxKQUJOMElNb3ZOaWxZT0RHbmpXTnQ5?=
 =?utf-8?B?ZENOMEl3NDcvUGFjRjVMSnI2UjJwdlRhNVByWFIxSkdEeHRpdjVrVXBDWldX?=
 =?utf-8?B?NjRydTA4aTA3WWRPZGVGUmltUzBDN25vQWlvU1VQRFpENkNOOTJsSEo0d0tU?=
 =?utf-8?B?UFpTdFNnaXA2cVVlV3lMaG1lektvVlZrM1BQRFJLL1pSM1MzSFpQdHgySDZx?=
 =?utf-8?B?TmJOd2tSN25DV1BCcS9WRXY0Z3Z0dkltdk1kUUZuZUNPenlSSlV5WXpiQ0lj?=
 =?utf-8?B?aEhYV0E0bUM0SU9zZlFGc2duWDZPRzhPUEMrSmNNSGU3MnpENWRyem43L25o?=
 =?utf-8?B?Rm40bVZVUXZodU1MODcyZ2hsMTFwRTlFblUzU1dyVmhtVkpNUXJKRmJXTTdz?=
 =?utf-8?B?dTJETjFTYXBxazdjZHBjMTF6RjlrRFJsaTZ4V3lrS2ZYMmlJaG9QNVJ0SHlK?=
 =?utf-8?B?UlY3aXp2WHhSWTNWU2M3elNZOGsydk8zK1NwRFZINFJUbHBWejVuNlUzd3VH?=
 =?utf-8?B?R0FTcEVtWnZVWHJ6aUljaXMwQjJFVlRYZU5HUExpbE5ucTZoaHRmNG14ODZa?=
 =?utf-8?B?dUVaYkpWTmt5dVd1akt2d21CODJsa3FRMHhHT1JXSEVKemtsV1VyblgvUjY2?=
 =?utf-8?B?bFlRZ2M3SHlsUlBVcStuTVJNOTNMZDZtMlMzcVN1QkNtMjJ3c3UveHVDZm9T?=
 =?utf-8?B?aUxjdEloZVp1MjFkL1NHWWhTcWhacDNYVXZzZUdSSzhLRzZJck9nbUNnQ1pV?=
 =?utf-8?B?UkNzaXJoS2EyOGxtNXNMK2szU1d3WWx0MUh6V0k4R0lnUTYvYm1LZWg0OWow?=
 =?utf-8?B?MmlmaVZYd2ZkMnBFQTJkZEkvOGwvZzJXRmRRYW9UM2liM0l0aFdzVDhoWldY?=
 =?utf-8?B?NVdzZVpkWVZvUmJ1QW5NVmhEUVFxaEFPTmRhN0pRVUF1aWlVR1hFNUJYeTYv?=
 =?utf-8?B?WDJtcjFlQ0VGaWJ1OHdmOGliTFFDeGljWmZJV2RkTzBOcnhjVDdZSmFHYUZE?=
 =?utf-8?B?RXQxanYzL1ZMcGlKZ01adFpHeGxFOGJBTzd4N3ZYRUs5TWNmNjZwRWtRa3pj?=
 =?utf-8?Q?TmG+IVUSaE7w0a5lfYcMa8KI/?=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: SJ0PR11MB6744.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 09078a4e-dd93-4ab7-4d03-08dc68fc05cf
X-MS-Exchange-CrossTenant-originalarrivaltime: 30 Apr 2024 09:58:01.8127 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 2YylbmHDvGDBkLO9Iv+d3Omxu4+nbw1KIEUy2tCXmc0k8gtSAZQf4+zq8pqjNQ5Upj2z9MxijsrUjIpf/2e+UObmo3mwzL1zDBBhMiSMWAk=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH8PR11MB6951
X-OriginatorOrg: intel.com
Received-SPF: pass client-ip=198.175.65.16;
 envelope-from=zhenzhong.duan@intel.com; helo=mgamail.intel.com
X-Spam_score_int: -53
X-Spam_score: -5.4
X-Spam_bar: -----
X-Spam_report: (-5.4 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.987,
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

DQoNCj4tLS0tLU9yaWdpbmFsIE1lc3NhZ2UtLS0tLQ0KPkZyb206IEPDqWRyaWMgTGUgR29hdGVy
IDxjbGdAcmVkaGF0LmNvbT4NCj5TdWJqZWN0OiBSZTogW1BBVENIIHYzIDA2LzE5XSByYW5nZTog
SW50cm9kdWNlIHJhbmdlX2dldF9sYXN0X2JpdCgpDQo+DQo+T24gNC8yOS8yNCAwODo1MCwgWmhl
bnpob25nIER1YW4gd3JvdGU6DQo+PiBUaGlzIGhlbHBlciBnZXQgdGhlIGhpZ2hlc3QgMSBiaXQg
cG9zaXRpb24gb2YgdGhlIHVwcGVyIGJvdW5kLg0KPj4NCj4+IElmIHRoZSByYW5nZSBpcyBlbXB0
eSBvciB1cHBlciBib3VuZCBpcyB6ZXJvLCAtMSBpcyByZXR1cm5lZC4NCj4+DQo+PiBTdWdnZXN0
ZWQtYnk6IEPDqWRyaWMgTGUgR29hdGVyIDxjbGdAcmVkaGF0LmNvbT4NCj4+IFNpZ25lZC1vZmYt
Ynk6IFpoZW56aG9uZyBEdWFuIDx6aGVuemhvbmcuZHVhbkBpbnRlbC5jb20+DQo+PiAtLS0NCj4+
ICAgaW5jbHVkZS9xZW11L3JhbmdlLmggfCAxMSArKysrKysrKysrKw0KPj4gICAxIGZpbGUgY2hh
bmdlZCwgMTEgaW5zZXJ0aW9ucygrKQ0KPj4NCj4+IGRpZmYgLS1naXQgYS9pbmNsdWRlL3FlbXUv
cmFuZ2UuaCBiL2luY2x1ZGUvcWVtdS9yYW5nZS5oDQo+PiBpbmRleCAyMDVlMWRhNzZkLi44ZTA1
YmMxZDlmIDEwMDY0NA0KPj4gLS0tIGEvaW5jbHVkZS9xZW11L3JhbmdlLmgNCj4+ICsrKyBiL2lu
Y2x1ZGUvcWVtdS9yYW5nZS5oDQo+PiBAQCAtMjAsNiArMjAsOCBAQA0KPj4gICAjaWZuZGVmIFFF
TVVfUkFOR0VfSA0KPj4gICAjZGVmaW5lIFFFTVVfUkFOR0VfSA0KPj4NCj4+ICsjaW5jbHVkZSAi
cWVtdS9iaXRvcHMuaCINCj4+ICsNCj4+ICAgLyoNCj4+ICAgICogT3BlcmF0aW9ucyBvbiA2NCBi
aXQgYWRkcmVzcyByYW5nZXMuDQo+PiAgICAqIE5vdGVzOg0KPj4gQEAgLTIxNyw2ICsyMTksMTUg
QEAgc3RhdGljIGlubGluZSBpbnQgcmFuZ2VzX292ZXJsYXAodWludDY0X3QgZmlyc3QxLA0KPnVp
bnQ2NF90IGxlbjEsDQo+PiAgICAgICByZXR1cm4gIShsYXN0MiA8IGZpcnN0MSB8fCBsYXN0MSA8
IGZpcnN0Mik7DQo+PiAgIH0NCj4+DQo+PiArLyogR2V0IGhpZ2hlc3Qgbm9uLXplcm8gYml0IHBv
c2l0aW9uIG9mIGEgcmFuZ2UgKi8NCj4+ICtzdGF0aWMgaW5saW5lIGludCByYW5nZV9nZXRfbGFz
dF9iaXQoUmFuZ2UgKnJhbmdlKQ0KPj4gK3sNCj4+ICsgICAgaWYgKHJhbmdlX2lzX2VtcHR5KHJh
bmdlKSB8fCAhcmFuZ2UtPnVwYikgew0KPj4gKyAgICAgICAgcmV0dXJuIC0xOw0KPj4gKyAgICB9
DQo+PiArICAgIHJldHVybiBmaW5kX2xhc3RfYml0KCZyYW5nZS0+dXBiLCBzaXplb2YocmFuZ2Ut
PnVwYikpOw0KPg0KPlRoaXMgYnJlYWtzIGJ1aWxkcyBvbiAzMi1iaXQgaG9zdCBzeXN0ZW1zLg0K
DQpPaCwgSSBtaXNzZWQgMzJiaXQgYnVpbGQuIFRoYW5rcywgd2lsbCBmaXguDQoNClRoYW5rcw0K
emhlbnpob25nDQoNCj4NCj4NCj5UaGFua3MsDQo+DQo+Qy4NCj4NCj4NCj4+ICt9DQo+PiArDQo+
PiAgIC8qDQo+PiAgICAqIFJldHVybiAtMSBpZiBAYSA8IEBiLCAxIEBhID4gQGIsIGFuZCAwIGlm
IHRoZXkgdG91Y2ggb3Igb3ZlcmxhcC4NCj4+ICAgICogQm90aCBAYSBhbmQgQGIgbXVzdCBub3Qg
YmUgZW1wdHkuDQoNCg==

