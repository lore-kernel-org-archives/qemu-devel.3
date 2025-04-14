Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id ABED1C369B2
	for <qemu-devel@archiver.kernel.org>; Mon, 14 Apr 2025 09:13:20 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1u4Frw-00033t-Gw; Mon, 14 Apr 2025 05:12:44 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <zhenzhong.duan@intel.com>)
 id 1u4Frv-0002zv-1s
 for qemu-devel@nongnu.org; Mon, 14 Apr 2025 05:12:43 -0400
Received: from mgamail.intel.com ([192.198.163.10])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <zhenzhong.duan@intel.com>)
 id 1u4Frs-0000Fq-H7
 for qemu-devel@nongnu.org; Mon, 14 Apr 2025 05:12:42 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1744621961; x=1776157961;
 h=from:to:cc:subject:date:message-id:references:
 in-reply-to:content-transfer-encoding:mime-version;
 bh=yEVV+V0ZtVy/IuhEqJ+9rKgJEi+el5BpVLqbfXYeZV4=;
 b=SrR9zxB2pPhNIWQXPXRDlFcmpuFSOOyvp09+WjAYsMn/ypHFsHy4EWWY
 vp51BewT52tOWVg+aYtUu1F0CWQABEjWMT6KMdXSvbDa7borP9E0bsFNA
 BquVJ8AJqN/vSMocoFVSnDiiTF98ykQGen6zAODN5Xx0INMYIXy/s5P7m
 GBQENit/LorhnUlnmNxkHTkNST/qDaSmJyhU4lPbKSu/4TRNDhHxXRYfG
 /LztJzC2JNi2ST2llAneO4hQT6ZeD+YUrK2T4AkUsbUjZRN/wxcUJAap6
 F70CePPD0qIpSDrJvvcfslHk4R3poGkCgqmaHpr0vdOUSORqT3Cd9f8U7 g==;
X-CSE-ConnectionGUID: u/KZL3OPT6Gva5zMKWMwSQ==
X-CSE-MsgGUID: GXDPtSbKSnuCp4rbP47z7A==
X-IronPort-AV: E=McAfee;i="6700,10204,11402"; a="57466729"
X-IronPort-AV: E=Sophos;i="6.15,211,1739865600"; d="scan'208";a="57466729"
Received: from orviesa002.jf.intel.com ([10.64.159.142])
 by fmvoesa104.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 14 Apr 2025 02:12:31 -0700
X-CSE-ConnectionGUID: lrDFjZVNSLaR1igM7Gu+/g==
X-CSE-MsgGUID: M8apn9/7Sy6f54LxEmzKSg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.15,211,1739865600"; d="scan'208";a="160719255"
Received: from orsmsx902.amr.corp.intel.com ([10.22.229.24])
 by orviesa002.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 14 Apr 2025 02:12:32 -0700
Received: from ORSMSX901.amr.corp.intel.com (10.22.229.23) by
 ORSMSX902.amr.corp.intel.com (10.22.229.24) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.14; Mon, 14 Apr 2025 02:12:30 -0700
Received: from orsedg603.ED.cps.intel.com (10.7.248.4) by
 ORSMSX901.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.14 via Frontend Transport; Mon, 14 Apr 2025 02:12:30 -0700
Received: from NAM12-MW2-obe.outbound.protection.outlook.com (104.47.66.43) by
 edgegateway.intel.com (134.134.137.100) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.44; Mon, 14 Apr 2025 02:12:30 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=jGSQZUAV2VsCbH/MAt9aZWdtEvzDxtMcOK2yUOe+AAlNvHAazGIkrZzefvcNikZuzehuYFTDg+bZTk1i40yvD56qUO2Rx5YAPZiSOFk1TGIsEBYp8KOi7PpeEPeytugFcU4aNt/fG7N8gAjdcuENISK25VrR+K+2hdzqKRGTH7qdPMdS6sV6sE6gMWr59qWEJKcIzBRQINDNPScnQQQHU7OfOMmKpo6XcleG2m0orPeoAzhX7HNneShpdefvzFv0ygawnEINRBLG4PYd47qKSpjYKbnWNZKdGNq/y6P9PgHaQ3c/uD75xMntIaWoO2/+VNEoRnti9KRkgfUFojeckw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=kfgwKVBgONOCh4tu2HjbmNmVuysfEfOxMr9iKY6Tqfo=;
 b=HLqXRJ03+7ihV6SHxhHALvFe+3OUFrfpIb6zODiCvYmM4074lo/8ZHhWIczIEBhh3bXaggW1mAWYvdP4m7mw1oCEip+8ZHOmkd44mEvUHbbBO5+1jJdB+EgBeUqZ040MC7Swza/Ka/z6BbjkFz+zdfDa67N6QTHxZfNTxX7TCbutV0eRG0s6R6kz13IZQ2zNQv9HBdbWxKxw/GWfeHUpJf7Bv6BUpYlo4TEVVMCZvi0Xijj/IvVuQIF7Js/FVNjieRaRgd8POWUI58LKrp1r8MwRSmARMPNa8kPWK3JO9RTqfdIHYQ6xg5ljntI5PuDOqCNti1yP1ILW/WRDNaDh0w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Received: from SJ0PR11MB6744.namprd11.prod.outlook.com (2603:10b6:a03:47d::10)
 by SA0PR11MB4528.namprd11.prod.outlook.com (2603:10b6:806:99::12)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8632.32; Mon, 14 Apr
 2025 09:12:03 +0000
Received: from SJ0PR11MB6744.namprd11.prod.outlook.com
 ([fe80::fe49:d628:48b1:6091]) by SJ0PR11MB6744.namprd11.prod.outlook.com
 ([fe80::fe49:d628:48b1:6091%3]) with mapi id 15.20.8632.030; Mon, 14 Apr 2025
 09:12:03 +0000
From: "Duan, Zhenzhong" <zhenzhong.duan@intel.com>
To: =?iso-8859-1?Q?Philippe_Mathieu-Daud=E9?= <philmd@linaro.org>,
 "qemu-devel@nongnu.org" <qemu-devel@nongnu.org>
CC: "alex.williamson@redhat.com" <alex.williamson@redhat.com>,
 "clg@redhat.com" <clg@redhat.com>, "eric.auger@redhat.com"
 <eric.auger@redhat.com>, "nicolinc@nvidia.com" <nicolinc@nvidia.com>,
 "joao.m.martins@oracle.com" <joao.m.martins@oracle.com>, "Peng, Chao P"
 <chao.p.peng@intel.com>, Donald Dutile <ddutile@redhat.com>
Subject: RE: [PATCH 2/5] vfio: Move realize() after attach_device()
Thread-Topic: [PATCH 2/5] vfio: Move realize() after attach_device()
Thread-Index: AQHbqstqg8dGaGNdUEq2y5NCdeSeyLOeSpaAgASOVUA=
Date: Mon, 14 Apr 2025 09:12:03 +0000
Message-ID: <SJ0PR11MB67444594B4E98ED3E020787592B32@SJ0PR11MB6744.namprd11.prod.outlook.com>
References: <20250411101707.3460429-1-zhenzhong.duan@intel.com>
 <20250411101707.3460429-3-zhenzhong.duan@intel.com>
 <a9fbd9ed-f107-4bde-adfd-26b51bac0442@linaro.org>
In-Reply-To: <a9fbd9ed-f107-4bde-adfd-26b51bac0442@linaro.org>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: SJ0PR11MB6744:EE_|SA0PR11MB4528:EE_
x-ms-office365-filtering-correlation-id: 8f2da9fd-7b06-40ec-3e92-08dd7b346c0e
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0; ARA:13230040|366016|376014|1800799024|38070700018;
x-microsoft-antispam-message-info: =?iso-8859-1?Q?KLFT5fdQILMkoGLVUJHsBS9k1h15FTjxLjVKJjMAlWc3Ub3S3i6wH3Di0n?=
 =?iso-8859-1?Q?ZaoB0iEyyJLvgXM4SahtnA00/7rWrLjtzB9C/IvzysrB8h4h5wUDvpXlm8?=
 =?iso-8859-1?Q?3iPyRdYjjuTqNmj2Jh8nu6PxmyrPgaueiSqEfSB2flBROjGaA9a5/a2tQ1?=
 =?iso-8859-1?Q?XHxNcRVHHqi2QFsvpXn6ZT2Cg1+bui7yey79y6xs5+EyaOEtIb9xB8I0X/?=
 =?iso-8859-1?Q?wRBiNurviPxQt5wyb9GWZ7Rkpx/osn4ThFmZ5g5w1Ep7tGzNuUzZgxh3Q6?=
 =?iso-8859-1?Q?oxBCdQYpxFgKSbFqQoCc0jZ3sl/KFTwsQLiH2up1daQ971o6Edpz5EpT8h?=
 =?iso-8859-1?Q?SpD2eoNosHlDJsvTas5yH/bE24IZR1XfKK3RezfpBIwnRY7SHbVtr16jIX?=
 =?iso-8859-1?Q?LuZ5oYrPkLJV6UvWwkj6Hm5e4+pvUWE6Zus6LB4J+sRKp+EyIqbhtl4BzA?=
 =?iso-8859-1?Q?V1xmPDUC/HXHxL6OtUqrKPTcwxgMkuUnxA+BOZ7wLihYgR8DE2nqyydhTj?=
 =?iso-8859-1?Q?pwFXfXzI2bqKUK/tDKkb6UV+RHKDIE19niiF8FhLa3Fhb3iyQEuzf5HMG5?=
 =?iso-8859-1?Q?rKFI9Lq9kWU2VX1k2guUuxapeukCUv87801xB9ybdWPuMavgSQnoubtCRy?=
 =?iso-8859-1?Q?XweOOIFV8lMct14yD0ODSPxRWJplYPNmKxiRkEyFMhTH3pExrpsd66atbm?=
 =?iso-8859-1?Q?zPiYqmyEW6CvSgvvaEiN601QNwzVUKOCtabe+T4VJtvaBLrBrU8k3JVVXM?=
 =?iso-8859-1?Q?HUeMffYYH4fc+wG68kob0FfCTa4IV1Sxx82j1vYgkS3bmofkbkqrzJp8pM?=
 =?iso-8859-1?Q?MmnOrj7/K/eM6qvj7yuzc9F9bnlrjrqL6VbcTL6e3Zlb5XrsxLy+jDqSlm?=
 =?iso-8859-1?Q?4ziDHmlZz1lLW5CLoDs+rwZSt5O/AaN3CEQ6bI+FnzPIV3h9rK3tiv3THX?=
 =?iso-8859-1?Q?n+QudaosUkZYgdt1WiOkeRLF/xBD/cDSeumirG8eb9jP69YBUFtLTfgr9F?=
 =?iso-8859-1?Q?pbIpW8wBHggmTGCQ9q3MRU7XE+7kS8ULukEQJ7bVMmdfWdIZcPTWvZXL5E?=
 =?iso-8859-1?Q?SFzebk3GxUpmou5iYQ3h98BJasJ2iWhjNbdEFNngDwUR1P0PawaaKuJY7f?=
 =?iso-8859-1?Q?vxAsXatyPxGRiroQZITO3Vkwp4ye6mjsleLPOOp+TO1oNRv5RkYtDSLsRz?=
 =?iso-8859-1?Q?YTr3dVSqpig7JDwx5S5aT9ElWV9oMh72tlUL0yvinT4rm56tC0BV4M8fh1?=
 =?iso-8859-1?Q?sUUKkbKxX+PeSNvaWm/I398lyxPLzFk4N9DQ+JGsKoWA/oUyH2lC4RmI4t?=
 =?iso-8859-1?Q?msLoItUlxabb4H/lY/2gvlKUo9Q7ajC6AUXeop8jgePii5ItnyHXuRAVrj?=
 =?iso-8859-1?Q?5RSX1chLeWojBbl+RTo4tt6Vee+eR4KChtt2TXo2LTdkjPCQ6RIfzCbeUT?=
 =?iso-8859-1?Q?B7GStixsPfqz0ZdRJYN4l6xWwzkHBEmLPu/zxp65smGZwWakFaPlr0Cjc9?=
 =?iso-8859-1?Q?WzAtNrOssWjF/UNz7OBCRyJ/wxJsIZRq3mz7Neg0KjTg=3D=3D?=
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:SJ0PR11MB6744.namprd11.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(366016)(376014)(1800799024)(38070700018); DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?iso-8859-1?Q?4YR3axH2AkNcUpsKRK/67fHG+KwlYlF4Kq87koF7aRORKfShXmPhLh27eg?=
 =?iso-8859-1?Q?QdAGWhSe6EWEvMl6VoQU0D8kqF9/3C4Zcg9YRpxX8SrHp8J8fN9cnsAP6b?=
 =?iso-8859-1?Q?A5cn/99/9Cavpz/NWOSXsqKpxvUtNNFGC8qOnHpkRbwHLhVO8ytJyI+zOt?=
 =?iso-8859-1?Q?sm2H0Wx2iWD+ex0xvhgjMeRkSo0z45mk8EjOuidNK4qd9EP9PNDc8NiXfT?=
 =?iso-8859-1?Q?62nfRvyStEM8uDUDqoyd/qtcsEe1qsuYxvaYKtNIiNX9LsC8naVRwi3kaa?=
 =?iso-8859-1?Q?/KXQQJjyGaSMBssrvFNmTfx2ot2y9I9JGHWS7uDTpgMVZTp9e12VWvEK6b?=
 =?iso-8859-1?Q?bsIsmXyBoIicktS5z/RvIHr2CxcfH5BjsfC4KVgvHqPMVO6d13SpVqEpjQ?=
 =?iso-8859-1?Q?x+X735zE5qBuLEV4RbRFSl3RVko26XgJk2zuXSE97TDn1lGwV71zaalrY3?=
 =?iso-8859-1?Q?SlxFEL+0tWsDIay5ki2YTv328o9x/cQxJ+0I6ZK+x2n1ul7NQF2UtKwiii?=
 =?iso-8859-1?Q?YwiBUaT8id7qBTGggaW3ZVr+6urRRcSZc6vPiCgnsgkIKhIA0jqpPZ4/9r?=
 =?iso-8859-1?Q?yW8tLwsYJyzJbSdbrV6suexjUNTWIRBjHCGNXskWCFKOILy7n6QLYPnnby?=
 =?iso-8859-1?Q?ua3LM8qsuyf4rlJthdvuCeOaMPckWUI8RDfxF+w9jpu5M3FGeDWxwX9S5b?=
 =?iso-8859-1?Q?IrEhyFbyq1Zx4rYsLfen6bZoMVG7ntKf2ROZsb5WxoG3NsmYmyKjfvrhT/?=
 =?iso-8859-1?Q?AOST36D9AHnPZvxLW5b1/1x78he1/1wcS4t9PbHcn7PsvDP/ruCiCIRqZQ?=
 =?iso-8859-1?Q?j50ErvddSaT1tO/2A367MG7EyAW7Fsny12lqUuYlnkZx0LPE5MK+zmMfNf?=
 =?iso-8859-1?Q?CjImFsotEyqVA8D39K4I+sy8qEV+1mT7KLZReUcXbJinH1iBo5Lav7vALD?=
 =?iso-8859-1?Q?Ergs3Qy9aBhm16eAtuNJohcaXSzpsCulAGu9AE8WIdVM2hYVjwgzwLzd+7?=
 =?iso-8859-1?Q?0lkBNwvApixDV+zBeOlULhvEJe+33BqAKY234wZaJCnC3m355op6bp7QtC?=
 =?iso-8859-1?Q?XIxDoPhkVCdTjjxZ1WrJXMBkEvhkGntcPcndaRqaiPNcU6FUN5l6RmXAkL?=
 =?iso-8859-1?Q?BSuXwlJNrZnENdjMdQw7J8Cvmr/8bABx/226qF2tv3B4B+d0mtLUKQ6EmR?=
 =?iso-8859-1?Q?BNYjbKyzCLSHnEWbNzcU0KE/cK5FxuWPmgnIRhGFzY/sVKnBnxXG3o+R10?=
 =?iso-8859-1?Q?EyJahw5FF+aia/OZDPbogAkbBXxYmqFbMwaD+NT31RNEnkMacseAOr1dpn?=
 =?iso-8859-1?Q?+XiUr5H7oBjPTB1oYkA+rcX2XClWHdl3/+jLiknaW/dAVCfX+OCsj8KaQb?=
 =?iso-8859-1?Q?cgc/bRdw8GW6YtHSACOMcZs9CkP6g2Xo5rVE/HZ+MhxYJWH05N+p6ynpcc?=
 =?iso-8859-1?Q?C4GqdZEuCVJBpoqas9EJjkL1kOX8Jfz21tkbv/Z5aVUzqDDKzBJubRw6Is?=
 =?iso-8859-1?Q?63uSh6EDFi5evYgE7pBxFYqatxeDo+zkh4FyJsbgGzUvh64sb1S8HXZn4b?=
 =?iso-8859-1?Q?Xm4jQ+MjNxhllkVqSDq3suEjmh9mEHopu93hsRsxWARK8LsR5sQTJhc4h/?=
 =?iso-8859-1?Q?AZGT83paIxfFKYp+CF8jYO6+B9hnnuvoa7?=
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: SJ0PR11MB6744.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 8f2da9fd-7b06-40ec-3e92-08dd7b346c0e
X-MS-Exchange-CrossTenant-originalarrivaltime: 14 Apr 2025 09:12:03.7606 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: QjVn/jNg0WaCB5/Zlzh5oAtjwYlth2vXqNnuxDuYUHC+4pPnq3tve6kwWXtXwGdoqOqj6XaRmwW9j4v7FD53o3TabHLTCdOe5Bk86hspXY8=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA0PR11MB4528
X-OriginatorOrg: intel.com
Received-SPF: pass client-ip=192.198.163.10;
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
>From: Philippe Mathieu-Daud=E9 <philmd@linaro.org>
>Subject: Re: [PATCH 2/5] vfio: Move realize() after attach_device()
>
>Hi,
>
>On 11/4/25 12:17, Zhenzhong Duan wrote:
>> Previously device attaching depends on realize() getting host iommu
>> capabilities to check dirty tracking support.
>>
>> Now we save a caps copy in VFIODevice and check that copy for dirty
>> tracking support, there is no dependency any more, move realize()
>> call after attach_device() call in vfio_device_attach().
>>
>> Drop vfio_device_hiod_realize() which looks redundant now.
>>
>> Suggested-by: C=E9dric Le Goater <clg@redhat.com>
>> Suggested-by: Donald Dutile <ddutile@redhat.com>
>> Signed-off-by: Zhenzhong Duan <zhenzhong.duan@intel.com>
>> ---
>>   include/hw/vfio/vfio-device.h |  1 -
>>   hw/vfio/container.c           |  4 ----
>>   hw/vfio/device.c              | 28 +++++++++++-----------------
>>   hw/vfio/iommufd.c             |  4 ----
>>   4 files changed, 11 insertions(+), 26 deletions(-)
>>
>> diff --git a/include/hw/vfio/vfio-device.h b/include/hw/vfio/vfio-device=
.h
>> index 09a7af891a..14559733c6 100644
>> --- a/include/hw/vfio/vfio-device.h
>> +++ b/include/hw/vfio/vfio-device.h
>> @@ -124,7 +124,6 @@ bool vfio_device_irq_set_signaling(VFIODevice
>*vbasedev, int index, int subindex
>>
>>   void vfio_device_reset_handler(void *opaque);
>>   bool vfio_device_is_mdev(VFIODevice *vbasedev);
>> -bool vfio_device_hiod_realize(VFIODevice *vbasedev, Error **errp);
>
>Pre-existing, but can we add documentation about what vfio_device_attach
>does, in particular in which state is the device once attached (or if
>attachment failed)?

Sure, it can be in a separate patch.

Thanks
Zhenzhong

>
>>   bool vfio_device_attach(char *name, VFIODevice *vbasedev,
>>                           AddressSpace *as, Error **errp);
>>   void vfio_device_detach(VFIODevice *vbasedev);


