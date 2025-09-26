Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6A536CAC5B5
	for <qemu-devel@archiver.kernel.org>; Fri, 26 Sep 2025 02:56:37 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1v1ybh-0003DW-0W; Thu, 25 Sep 2025 22:54:49 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <zhenzhong.duan@intel.com>)
 id 1v1ybf-0003DN-Id
 for qemu-devel@nongnu.org; Thu, 25 Sep 2025 22:54:47 -0400
Received: from mgamail.intel.com ([198.175.65.17])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <zhenzhong.duan@intel.com>)
 id 1v1ybR-0001YW-LB
 for qemu-devel@nongnu.org; Thu, 25 Sep 2025 22:54:47 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1758855274; x=1790391274;
 h=from:to:cc:subject:date:message-id:references:
 in-reply-to:content-transfer-encoding:mime-version;
 bh=FwAJlzUOuXirT5zXCTY6L1xkJQQNlUDBRkhTbb5yuqU=;
 b=FYllZ7Z8cbrqhXByjInQpX7YJcNcpVKY33+hjjFaaOrMBjeVFpnOF7t0
 4usl3by36abXuJuK2LDRSEr+ea3e2WBvCylCxQ0TxopNpbF/7EG62OQmk
 DiQS/AINn6q8HrjitVKIoPpQA84+BA+nsZiqRvmF+Y74GjNCA9A4XI91S
 EB+mAuGl9zjQ9LAKI1Vw8MHY89mrK2ZlDTii+aei7soSF7nZhuJEWn3MP
 XCFXmb/wKSciSw5NGWwh/cFs5xichWEGywBkaQEH1a5+hjh4bkfpyzkKU
 Rozh3ZdA7CMx7t7vOp03bhHFfAn5NyFrbYSb487X2jJtPsVKCrTos9A21 w==;
X-CSE-ConnectionGUID: J+y1vlpRRqa7nWNLQSk+KA==
X-CSE-MsgGUID: pWTK9z2oRAeEG2N/gMa+Ag==
X-IronPort-AV: E=McAfee;i="6800,10657,11531"; a="61137896"
X-IronPort-AV: E=Sophos;i="6.17,312,1747724400"; d="scan'208";a="61137896"
Received: from orviesa006.jf.intel.com ([10.64.159.146])
 by orvoesa109.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 25 Sep 2025 19:54:27 -0700
X-CSE-ConnectionGUID: HhSG0yyETV+7UwbxoViZag==
X-CSE-MsgGUID: pHtjoSHQQFm1ufW3PYKmpA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.18,293,1751266800"; d="scan'208";a="176616712"
Received: from orsmsx902.amr.corp.intel.com ([10.22.229.24])
 by orviesa006.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 25 Sep 2025 19:54:28 -0700
Received: from ORSMSX903.amr.corp.intel.com (10.22.229.25) by
 ORSMSX902.amr.corp.intel.com (10.22.229.24) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.27; Thu, 25 Sep 2025 19:54:26 -0700
Received: from ORSEDG903.ED.cps.intel.com (10.7.248.13) by
 ORSMSX903.amr.corp.intel.com (10.22.229.25) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.27 via Frontend Transport; Thu, 25 Sep 2025 19:54:26 -0700
Received: from SJ2PR03CU001.outbound.protection.outlook.com (52.101.43.62) by
 edgegateway.intel.com (134.134.137.113) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.27; Thu, 25 Sep 2025 19:54:26 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=GS4KHM9lOmX/hH2NWZvfJDut3Pu+2Vlyxil3kwVxKq7FyRhFnJ9IMZhf7FVMVEDRDnp4pPnnZZIZ3f0ok1zbVN6rd0ZTSK+huUNK9G+YyI6jg0TSVrP4tcgN9PSSdT2DhIPbCAyYxIrsYDf/xztLW8OFN+zS47YnefDaG7xfpkbS4J+GtJmlZrx8MjxSIdvlZE1FX2WkdAXpIsYlzTo4mhoSAlQeNOtoICE6l3Zg2211WbSabXqEDaxofsnXLoKR9P56EwtGUAnGiyi3DoCJHYzDB4FTCcObF7tinsM04A5qfZyamdqDLP0vxhSiSic+OUCKVtzVlSvr/rM7gh+Zlw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=w0kCJDInIX1kwvyYEHOHE5KRBoC9XZ1Mpza8DsyCwdg=;
 b=riPO/5YJn7XVBiu8e1CCX7b1PGiQgLOlmCU/hwRKdWZi1DdvbotuBF9Q54eu0wGii97Sx/C5QLQK42HY2CfF4FAUhSWxwhD025eAvFma0q/RlByl3zRpkyWNQZa9DF2AelP24CphryTMYUb70FHKKsqzkvE1YvfZJLnqQXxFhs06UsLR73Q9HbywKXPYog32vrDSr0gCy1drAFKH7EMHyPHXBiGkWKBJ/H5z4hBhTzXew8E2X8B97V7qqoCdSPAyG05ISOwKP95yqqxDdiT/74q3Em1TrNrxk1o8+2famudcaveVSLEyPbCyYOfYwiDk4UWVtt31pmKIU6d1sxKh0Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Received: from IA3PR11MB9136.namprd11.prod.outlook.com (2603:10b6:208:574::12)
 by PH0PR11MB7524.namprd11.prod.outlook.com (2603:10b6:510:281::18)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9137.20; Fri, 26 Sep
 2025 02:54:24 +0000
Received: from IA3PR11MB9136.namprd11.prod.outlook.com
 ([fe80::604b:77a4:b1be:3f13]) by IA3PR11MB9136.namprd11.prod.outlook.com
 ([fe80::604b:77a4:b1be:3f13%4]) with mapi id 15.20.9115.020; Fri, 26 Sep 2025
 02:54:24 +0000
From: "Duan, Zhenzhong" <zhenzhong.duan@intel.com>
To: Nicolin Chen <nicolinc@nvidia.com>
CC: "qemu-devel@nongnu.org" <qemu-devel@nongnu.org>,
 "alex.williamson@redhat.com" <alex.williamson@redhat.com>, "clg@redhat.com"
 <clg@redhat.com>, "eric.auger@redhat.com" <eric.auger@redhat.com>,
 "mst@redhat.com" <mst@redhat.com>, "jasowang@redhat.com"
 <jasowang@redhat.com>, "peterx@redhat.com" <peterx@redhat.com>,
 "ddutile@redhat.com" <ddutile@redhat.com>, "jgg@nvidia.com" <jgg@nvidia.com>, 
 "skolothumtho@nvidia.com" <skolothumtho@nvidia.com>,
 "joao.m.martins@oracle.com" <joao.m.martins@oracle.com>,
 "clement.mathieu--drif@eviden.com" <clement.mathieu--drif@eviden.com>, "Tian, 
 Kevin" <kevin.tian@intel.com>, "Liu, Yi L" <yi.l.liu@intel.com>, "Peng, Chao
 P" <chao.p.peng@intel.com>
Subject: RE: [PATCH v6 18/22] iommufd: Introduce a helper function to extract
 vendor capabilities
Thread-Topic: [PATCH v6 18/22] iommufd: Introduce a helper function to extract
 vendor capabilities
Thread-Index: AQHcKHqbGlodRerImUCRhKTrW5zabrShNDgAgABuqOCAAGZpAIACwmIw
Date: Fri, 26 Sep 2025 02:54:24 +0000
Message-ID: <IA3PR11MB913650BC45038C89C1114071921EA@IA3PR11MB9136.namprd11.prod.outlook.com>
References: <20250918085803.796942-1-zhenzhong.duan@intel.com>
 <20250918085803.796942-19-zhenzhong.duan@intel.com>
 <aNL4zruHP8P8ExrM@Asurada-Nvidia>
 <IA3PR11MB9136B5015A5396E5FC782B8C921CA@IA3PR11MB9136.namprd11.prod.outlook.com>
 <aNOriuyx9Fhw7aMI@Asurada-Nvidia>
In-Reply-To: <aNOriuyx9Fhw7aMI@Asurada-Nvidia>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: IA3PR11MB9136:EE_|PH0PR11MB7524:EE_
x-ms-office365-filtering-correlation-id: a93e7818-80c4-4c63-9f75-08ddfca8002f
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
 ARA:13230040|1800799024|366016|376014|7416014|38070700021; 
x-microsoft-antispam-message-info: =?us-ascii?Q?tn/UmX0ULg5wKi8zXSSngmU10Z8euaw4w3H9G6N8TiSqcL8ZWMOpNzHthLIL?=
 =?us-ascii?Q?tFOulluhBjZgRHkLy4tay4rF9jSs2WTwYjSZMnd3UhiG4rg4TZbstkznKFfr?=
 =?us-ascii?Q?v+aQzQO3mMMwDUe4YLfzD/AsGSDQ6zn9GTOxwp4RY59z2MfKeYxNOoPy21wE?=
 =?us-ascii?Q?LiRHF0C24SKkmNSooWjoCtrGezT+Tyi9LSTXuE8ynPomKvV7hUk9JTPc0TTT?=
 =?us-ascii?Q?VSCwLixXn+NKkvdtZ32h2QVFsDwyMAemyzgppVdbO+juc4/A1G7R91A0Va7u?=
 =?us-ascii?Q?D1IY6b2m7d/tBQ78yFPN+LJ3qQyAvpr7Md/V1IylbaZU/xbsIhO0A69lVpUF?=
 =?us-ascii?Q?ndZ+LTsNaYsI2BsMatMvs2+KoGmt/AwzgJSijWqHC7quowJqAXwssbwSkHf6?=
 =?us-ascii?Q?1JTCXtDtgbZ8JMY40u13znIFoSo8bvWUq768oYQ2//cuN0PPoHEVMMBuAmKB?=
 =?us-ascii?Q?BEaqvvugIzBK5kHT7OCAxbgXVFTA2UvecArOD/xBYwH2pHELMK5R1eY63P3U?=
 =?us-ascii?Q?6Dy29y+noxcAYJ0eJYboVgtaSQnrwUIU6z3PLhZSpA68R7iJ3vaMHm/RiSY7?=
 =?us-ascii?Q?VDmHPtHXbPMUIAO43++Ir2VjZ+JaR7bZuRtUEh4czBYqcVlEGAqVQDCk5UUX?=
 =?us-ascii?Q?EwYNIHL1Qhp6k2pN7KkFJBABG0mCC9e+C0XeLITcBFMbImQZ1Bejb77Ffg5V?=
 =?us-ascii?Q?iFfsGs24c1pf2q1+SQWYvFwCwUIxfko+6fDqakmodr1R7vuKXh88lzFoLL/f?=
 =?us-ascii?Q?9zk/7yLuIqVF8Kzi68VLzK779Jx2fQrYjFZtXVaqKrf1+7/nnZgdRRF2q/Rz?=
 =?us-ascii?Q?AWUkpeuck/ZnJlrhghJMAbeLXZgSvdnXFwOIS3KpfYdZ1JqqHxlJW6FNS0RQ?=
 =?us-ascii?Q?6FNjifhtJmhomVCbuYfAY79/mkjWXRTvT4haOHy3FrBtAio0LCuXdtyew7MH?=
 =?us-ascii?Q?cSIjD/1mL1GiSt3weFb6+tqPY2Cs8mNz+Y6m6LfOnUZ3u2CCUsjMdJZn8D6p?=
 =?us-ascii?Q?P6ndnAgHhnM9AQG5jV82X3bAqDbmm7xcKbsv87hUro/SyjD+GFDKapvI1/nQ?=
 =?us-ascii?Q?jzHBF4AudBaurRy6b4rrcTz+g+sRI0WpXD/xA3aucKnDws1KAeLjIdjBN1iW?=
 =?us-ascii?Q?ck2/EynmNddMgItA/2dOEOTQs/Qc20BYKSr4vUoaAdv2ZH+lGRjxy6Yc+Wki?=
 =?us-ascii?Q?hz3OhuX3q1p/CVuCNVrhV5H6rbT+L6tOkusopqg/4J47rcmHVMc7VFRBAiXI?=
 =?us-ascii?Q?gdY8qsh6EPIhGR9XOT07o8FO2oDNvZ29IYklkWbLHL1XSZIA9z+rri3Pc8nW?=
 =?us-ascii?Q?CNKI6oTGCE6IBW/RtAkoW2QkioS9vP1v2uOnv0MJKRkVxydCOMoTk/beEGcJ?=
 =?us-ascii?Q?/uspiRVJ8gueXwWyVZGAjghsth2gq6xopmA4IW9GowFlXsgB8zoyJFO3Li3C?=
 =?us-ascii?Q?97Cj0OcZRwAzYpzIkRAkWCVDy/XqRthuUUZcyu+/Cr3WYlq0beflkV1PT4JX?=
 =?us-ascii?Q?WE7xv7vSLVSK3UA=3D?=
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:IA3PR11MB9136.namprd11.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(1800799024)(366016)(376014)(7416014)(38070700021); DIR:OUT;
 SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?pKysJkHXjxugbfKLT0zrakF0rN6nXrWcV1c5VXTxxgo87mMFYlWwmiJCjOiB?=
 =?us-ascii?Q?k1Vieu1D2JJ6PvdFrXkACHrl74pBLxj5COrE04JREaXGBl/iFDFi5d2JvhFa?=
 =?us-ascii?Q?G1DGkg7L751AJGg4g5tAHCLPsbhZS32S4R5N8CasWX9ysNHo5rm0FIojxJux?=
 =?us-ascii?Q?pEZprTz/EXpeET4hL0OZXq6hixcYESkS5iU+3CLmtveeobRWXNc4uWIJhqxb?=
 =?us-ascii?Q?LgfIMRqA+QMkPb9baLGKWw5dOC1p+FOq+gEVmgK6MVKLrfJ6AyZmDpISQ+HG?=
 =?us-ascii?Q?qnnyDlbIG35gjh849SsN02z3awdDQED2LCIwhudPyyp3S+YBT8EWePGVeh4n?=
 =?us-ascii?Q?+Cv5avDNwjT6p+G6UU5KS199VuiOh8+I8Z81MyPU2/oH8s8KGiAfM2/91ytC?=
 =?us-ascii?Q?ZD2BD/+81cWL5tjUvOtC6nI8AeB+wACGZEPPoJHHbijSHqAqSeof9fT38uy7?=
 =?us-ascii?Q?Vi5AeFXJB6GBrlvN9uXzBfuHYQTiLwwdSXIBcJ1OLa3DE/x3XXjyoqC1rw+m?=
 =?us-ascii?Q?rGmgeJHXRmkl49DBgvx4Aqmu9tQPHUxXm30nWr1YcnUG9hEo0Z/rPj514Flh?=
 =?us-ascii?Q?dA6c+RwK6IbT/cU98mnW6ohVFrNlGIK1tVE4tmgASwMRnd3jKM5Z7ojl325Q?=
 =?us-ascii?Q?/4DJCXLgVGfnWn4lDiqvFg4MPn2hl/VQgxKDYYsBW+jqQOr/iEcqrQamj5IG?=
 =?us-ascii?Q?IOrZ5JF/4fd7tcM6rfPyDdLgn84abohgPCsqpEwQcyuqu3zjXV6SCnQaof9w?=
 =?us-ascii?Q?UnEph/g+Fg+5d7ckVJSJKRbrSutEibTS714OmNQrNEOm+o7Ap2Nd6RJKgPEe?=
 =?us-ascii?Q?ZCMlvF+6OhTs0VnXX/S8lQSIwDXMRCUn1jfTBmwD+eW6N4NTLeTOqEaDAMXq?=
 =?us-ascii?Q?3SV/N8U5ceFYuYxQsSiTvhtwfNzYJXH0OoEswjW4gHgBcwcr16HRz8Rn7SyK?=
 =?us-ascii?Q?D0z5xwJz9DIjszc0d4NTinKvIIOZhz7tPxshk9D89OH0wzVNFi8CAnRmeKPw?=
 =?us-ascii?Q?zmCbm73652v7ly1vtGwuv3SKjWjdCrPN6vNYkn2C1iB9/2+QPWqLXhSehHfb?=
 =?us-ascii?Q?XGqDxqsOHItrSQ8qZ6Xek2p1CAGeygrq7r5a2ozUngJUd/QDskfc+SXGzd1D?=
 =?us-ascii?Q?uJgXpRH84UwRvt1i3XMIdVcqoUAP4j73lNOWd0YGl/HLtaOcW4My5Ha0i9ER?=
 =?us-ascii?Q?au1n7aWpj880ya/BZIbQ2PA5PZ+wRgQr9FouhbHJtgi1j3Ij0r6tyLZ4edEF?=
 =?us-ascii?Q?eg9Fdx75uh3hNnQThHk5i820rP3I2cI2mUksLgStbtystUjZJtGMw8/4Ctnw?=
 =?us-ascii?Q?1caiB+Q6miGGnK6S/WKC/OxHqkU/Th2ReqQB4xPtFAWuAJ4qQy1FQj36jdcf?=
 =?us-ascii?Q?buEmdKSXFp2lP99D2+vyW2o5EUADVX2WCDoMwx2wMUoHKYxppuKNrwyP8nUT?=
 =?us-ascii?Q?9GSFEdCxJ7IL6VaFlXqH9ysE680quGp9TLZCOUU/zPSARRfLQ+fl6q3At7OQ?=
 =?us-ascii?Q?Cuzv+txHvlF5fw2oo9uMGvhLciOdrHAO3V2CObQ3CTHzuIQhvzfWTDZZXX3g?=
 =?us-ascii?Q?hou/3lMyD3hjavg4q0vb6IoKaiYGXRSJizZYZRFl?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: IA3PR11MB9136.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: a93e7818-80c4-4c63-9f75-08ddfca8002f
X-MS-Exchange-CrossTenant-originalarrivaltime: 26 Sep 2025 02:54:24.4170 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: Pg2b7H5gsH5hQ01K9RR9ubRVFIUhju/97IXybkuf25aOKscA0nuWS+mAu9Y37n0jaSVCVIg4a5NrPFPO0jpFTc+H0eeKs+RG9BcB00hdPkU=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH0PR11MB7524
X-OriginatorOrg: intel.com
Received-SPF: pass client-ip=198.175.65.17;
 envelope-from=zhenzhong.duan@intel.com; helo=mgamail.intel.com
X-Spam_score_int: -47
X-Spam_score: -4.8
X-Spam_bar: ----
X-Spam_report: (-4.8 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.445,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_MED=-2.3, RCVD_IN_VALIDITY_CERTIFIED_BLOCKED=0.001,
 RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001, SPF_PASS=-0.001,
 T_SPF_HELO_TEMPERROR=0.01 autolearn=ham autolearn_force=no
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
>From: Nicolin Chen <nicolinc@nvidia.com>
>Subject: Re: [PATCH v6 18/22] iommufd: Introduce a helper function to
>extract vendor capabilities
>
>On Wed, Sep 24, 2025 at 08:05:36AM +0000, Duan, Zhenzhong wrote:
>> >uint64_t host_iommu_extract_quirks(enum iommu_hw_info_type,
>> >VendorCaps *caps)
>> >{
>> >    uint64_t quirks =3D 0;
>> >
>> >#if defined(CONFIG_VTD)
>>
>> I have applied all suggested change except CONFIG_VTD here as it's a
>device config and iommufd.c is device agnostic, it doesn't recognize
>CONFIG_VTD.
>>
>> ../backends/iommufd.c:419:13: error: attempt to use poisoned
>"CONFIG_VTD"
>>
>> I thought this is trivial and OK for not having CONFIG_VTD?
>
>Hmm.. I didn't expect that. It seems that QEMU does encourage
>moving all vendor specific code to vendor specific file :-/

This make me think CONFIG_VTD should not be used here, it controls
intel_iommu emulation, we may have a custom virtual machine without
virtual intel_iommu but still need to check host IOMMU.

If we do want a control, maybe kind of CONFIG_HOST_VTD rather than CONFIG_V=
TD.

>
>Anyway, I think it's fine to drop the ifdef. The VTD type and
>cap structure are defined in the shared uAPI header.

Agree.

Thanks
Zhenzhong

