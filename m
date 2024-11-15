Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 967F9D6DDEA
	for <qemu-devel@archiver.kernel.org>; Fri, 15 Nov 2024 08:48:42 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tBrzh-0005DJ-So; Fri, 15 Nov 2024 03:47:58 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <zhenzhong.duan@intel.com>)
 id 1tBrzf-0005D1-Tj
 for qemu-devel@nongnu.org; Fri, 15 Nov 2024 03:47:55 -0500
Received: from mgamail.intel.com ([198.175.65.14])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <zhenzhong.duan@intel.com>)
 id 1tBrzd-00052k-CS
 for qemu-devel@nongnu.org; Fri, 15 Nov 2024 03:47:55 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1731660474; x=1763196474;
 h=from:to:cc:subject:date:message-id:references:
 in-reply-to:content-transfer-encoding:mime-version;
 bh=PeKRZ6NLwq9B0N+J4lqOq6I/HOOUqgOzNlgRlBpFgO0=;
 b=SI9Gph6Loab2u5hCtGZPcy7e8RVGs3GBYy6KUiAcYjQ1MgXkfOBePWcX
 U9cht4qrULc6aVWcl8GLFGEfoM228WXf04p+/CGhXgQNUlCpOZatjVa9t
 PFYGA/kLNp6/wM+12ZgqRUfcMG7cIYh8MNMLj8JnwqcZd8zIjFSP7bvS6
 QvhgzVjmDayw7LDSJsXQVtTAsYACcll0KUj2iZ2WmAf49dXyeM+z3WeDO
 TI9vS099Lz7nir3/dUQAi6EPKlGezjOuyVgmrbsPxVcSI0MzbteEBx84z
 3AXmeFBHiCUo5IR3uTOgjEg2T8sBCeNM5ZAfXIzG3tyBYrc+5ws2o/ME6 w==;
X-CSE-ConnectionGUID: QkgAlsgGSuq0E5102XI0Lg==
X-CSE-MsgGUID: DstnGVtbTWW5kEbHoqDD7A==
X-IronPort-AV: E=McAfee;i="6700,10204,11256"; a="35424416"
X-IronPort-AV: E=Sophos;i="6.12,156,1728975600"; d="scan'208";a="35424416"
Received: from fmviesa006.fm.intel.com ([10.60.135.146])
 by orvoesa106.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 15 Nov 2024 00:47:51 -0800
X-CSE-ConnectionGUID: e9m98QWuT1iTjb2nlg883w==
X-CSE-MsgGUID: kW1+I0leSTWwO2zp5vJlmQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.12,156,1728975600"; d="scan'208";a="88070964"
Received: from orsmsx603.amr.corp.intel.com ([10.22.229.16])
 by fmviesa006.fm.intel.com with ESMTP/TLS/AES256-GCM-SHA384;
 15 Nov 2024 00:47:50 -0800
Received: from orsmsx601.amr.corp.intel.com (10.22.229.14) by
 ORSMSX603.amr.corp.intel.com (10.22.229.16) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.39; Fri, 15 Nov 2024 00:47:49 -0800
Received: from ORSEDG602.ED.cps.intel.com (10.7.248.7) by
 orsmsx601.amr.corp.intel.com (10.22.229.14) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.39 via Frontend Transport; Fri, 15 Nov 2024 00:47:49 -0800
Received: from NAM02-DM3-obe.outbound.protection.outlook.com (104.47.56.43) by
 edgegateway.intel.com (134.134.137.103) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.39; Fri, 15 Nov 2024 00:47:47 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=t2M2hArdki22vPVKSlO1Ceko4XjS216TxBMYtKH68ANfzddRQb5CqYLBqSfEI1a+p7tfavfiD/wzoQnLstSfCfyC4f3IzNiFx+LMyGQ8K4l7ZbM8Diqb4fORBjWeQiVwrRFgsre1IKFceH70RqyWtDSq9wrnXz6teS6EcqZaXgvXnevlGtdFq1t5DfBjaupZ1Awdzji7u8qHln0ZD4T0/Ei5LgxD2GmOAMiAgqklr677NpvXtGl72ueAFFlD5YKhAyEQGW3NVFf4doVHAw1WmSwDDfdZe0c/pkqUeY7TsO+msqXeieg2hNBya9pB8bxC7P3PtwQ2j8wt6f1KRQ1r+A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=PeKRZ6NLwq9B0N+J4lqOq6I/HOOUqgOzNlgRlBpFgO0=;
 b=MITxt0uQ3f+3O5Ve+qIsH2XaDczsNz/WYboeQRcHVL0DwC+JUZcyqdRLO7jb+fHv+CyuTfMmftU+raoOpzyLTJbXVROvLNhV7mEmtpKnjqAtVA47OKz4S1ErGAL8CoX3KldfZoVb4hEFRkztIpMJ0+jPxv7QLRVSVPpgv3izWE5PUwR47EES4AwojVl3DK9PhITduyNU1fP8jOFpqYPkLhsGumooDdx3CCPrw03wanwPAMUKV4E+0i36AIX5FXndU3Yx8RVA+Q0NCSPSsA6RKrp1eoLz4l0biMpkHQz15dLzLUbDFb6rDyjKSiVEThTFuD9ppzwQX+XK0eeqEdgpdA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Received: from SJ0PR11MB6744.namprd11.prod.outlook.com (2603:10b6:a03:47d::10)
 by IA0PR11MB8301.namprd11.prod.outlook.com (2603:10b6:208:48d::19)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8158.16; Fri, 15 Nov
 2024 08:47:45 +0000
Received: from SJ0PR11MB6744.namprd11.prod.outlook.com
 ([fe80::fe49:d628:48b1:6091]) by SJ0PR11MB6744.namprd11.prod.outlook.com
 ([fe80::fe49:d628:48b1:6091%5]) with mapi id 15.20.8158.013; Fri, 15 Nov 2024
 08:47:45 +0000
From: "Duan, Zhenzhong" <zhenzhong.duan@intel.com>
To: =?iso-8859-1?Q?C=E9dric_Le_Goater?= <clg@redhat.com>,
 "qemu-devel@nongnu.org" <qemu-devel@nongnu.org>
CC: Alex Williamson <alex.williamson@redhat.com>, Eric Auger
 <eric.auger@redhat.com>
Subject: RE: [PATCH v2] vfio/container: Fix container object destruction
Thread-Topic: [PATCH v2] vfio/container: Fix container object destruction
Thread-Index: AQHbNzlDLyY0lqaY+UeECcqAzz8Fg7K4Byng
Date: Fri, 15 Nov 2024 08:47:45 +0000
Message-ID: <SJ0PR11MB67443EEF494372594283AB5492242@SJ0PR11MB6744.namprd11.prod.outlook.com>
References: <20241115083440.2236669-1-clg@redhat.com>
In-Reply-To: <20241115083440.2236669-1-clg@redhat.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: SJ0PR11MB6744:EE_|IA0PR11MB8301:EE_
x-ms-office365-filtering-correlation-id: 9fef15f0-734e-4d0c-c2f5-08dd05522ceb
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0; ARA:13230040|376014|366016|1800799024|38070700018;
x-microsoft-antispam-message-info: =?iso-8859-1?Q?B5GLM5kKThCArSJdydTwe9C0Hm94D+yhLXpTsUrBK8fRCNjH1sZCtmV3HU?=
 =?iso-8859-1?Q?qolScHhaP4/AR0aShYIQSFPV3C9rEAquXz9xKBcSvIz2gYbd6PyNj0DdCK?=
 =?iso-8859-1?Q?1OZgEE6hr9f/ssQmFLUOG4Y3paMrY5jmqifV7d61bKg/Zv3seTLup4BUxR?=
 =?iso-8859-1?Q?5QoL4aCB7X8q931Ph1rDKbGhQPviOW17yFExdwpJjnAPRaUMv9W68moMKz?=
 =?iso-8859-1?Q?vW+BoOKBH4En9NbYFFjJXqSt77q8gtRQLAexgTgNNYIyy9c0JK66YBql6h?=
 =?iso-8859-1?Q?TqBCjaSNQzqPimsxL6OwLilnZR4YKPlWP9uaa4WjhKRTP5GoeKfn3+/9MH?=
 =?iso-8859-1?Q?OukbHsGekdjbX8YrY01zmyZ6bhzZ5yd0AJZ7ocRwJOq1NTOaFDM5Wd/C2o?=
 =?iso-8859-1?Q?8IXP+UOzjxDxukdJfpJg9e2Tsln998xqXEy1VdfdLoRVCGlp5kn5fEbgYg?=
 =?iso-8859-1?Q?wH5Zv18eSjhgCn5WCp8KNtseIR/5xvfKTMWvB2aIcqMCAhNfn94PGAvnoA?=
 =?iso-8859-1?Q?GyQVfGJFAkZ/uqwPA0gCVpM3Z7YXr3fq4jhsdVH0nKSb2QLtXQGDq6TcRq?=
 =?iso-8859-1?Q?FQyt0GOnKvlBo49nHSNglwF8Lvcl5cM+JmW4bR0NBO66gr6ipdkaWB9f3w?=
 =?iso-8859-1?Q?v3JU2JHEXzsC4M/BHXwycSnS1+U7Qx2rVHcKR7IYSp9H9I8iLPbVJEgx/F?=
 =?iso-8859-1?Q?VXDYzSU+J2akeg2sMLgH+M1lxGILPDbj/e/c8ZBGU32eXbwjrPCCuatif1?=
 =?iso-8859-1?Q?JEexnOoyb4BCsPpaE6yM3GynuGQ2+PPy7U/pq6AwAa/B6aGtXOsinG15iL?=
 =?iso-8859-1?Q?P8946znUfL/vCroWdmrweC5esGCMfZB13MvoKW0khISJ2h6RbQQ//Jwa/u?=
 =?iso-8859-1?Q?gLRLYUdPIjhg9aKPGFpRDvw738sXN10JQ/uiP4Cgx6aZt1dPKjLyATRtTF?=
 =?iso-8859-1?Q?UXRrINpDD1bwjSzevPsRFmjVjXbuqEkQ9ymXX6V8CZCmWlbn9TJkOFTqIo?=
 =?iso-8859-1?Q?CKjPlGxa3MG0chnofZPBhQ4N6ZMbongULTMXL5vBRrrQ0/V6Pai77/LwBw?=
 =?iso-8859-1?Q?PsfBvX5LOr5exxYZ4BOxrJX9Qf2WdEaJ56gmw2n7/BcvLZpA3JNxaDruLG?=
 =?iso-8859-1?Q?9v26UBmVv8bsTExtNef4Bdys/dRcglrqKjMkZYc5JftAo8frM+9iXMO24e?=
 =?iso-8859-1?Q?SifYTC2c/C4mNOxehR8WR6IV/w48f1qPGHi8LyXuSRUJu+4g5Rkboto255?=
 =?iso-8859-1?Q?6wyQ9gpGAzKeCcgM+J8re4l40noJYXO5NRQJsPkYRp6izLUWdVqdGUgfLA?=
 =?iso-8859-1?Q?9R24vGN07Oj653TLkrdedCV9HoTa9W93PxVBJwvyPCK74l3oR7UeTEJ5yp?=
 =?iso-8859-1?Q?q/7tfM/OqPHM5MrYScR98rTEFXAmjkahtBDd/Pt2vzG8Beh1RDrdg=3D?=
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:SJ0PR11MB6744.namprd11.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(376014)(366016)(1800799024)(38070700018); DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?iso-8859-1?Q?PFwXdYV/UFJsq9hwhF7sXE+/p1Lg64pRXcx6lH8G6x5UaUKfBf/ryR8avV?=
 =?iso-8859-1?Q?UP0gocl5mwMWtpio2rhIyc5qqnTvkgZsZAuVUnLOYtJkFErZCAevjsGKyw?=
 =?iso-8859-1?Q?4ZLESlW8rjCSwasU6OkwvXgHNH6XCcdDne7HZ6nvfIQag9HJ+6dl8YyV6k?=
 =?iso-8859-1?Q?6fUjKycWT2xHz1fa6T6Beb0cNRBrOsYK4oKukh0xhI3gVezZ6XpUWzzAUn?=
 =?iso-8859-1?Q?KKLP/5M8umubeeWGF4yGtAKrK/azT+DxKHDg11Rtovm8fL2idPZNsFg++0?=
 =?iso-8859-1?Q?EnxzTqlPxm3s6gI2NhfOM2SC1k0mZQOOtuDDD1xnDZmUJg7oX5a6CJL0bg?=
 =?iso-8859-1?Q?PGGTxc7mdwH9a2CkOlfx5JyLp1eIrqeDz7wEjmJQ7uICYNQTpve22dCAdX?=
 =?iso-8859-1?Q?h8S6OQLSpfnp8Z/fVy/SDMNMMO6mhp9SV6E9o6HqV+RPqmXVNEjMdikaCm?=
 =?iso-8859-1?Q?VAtZIiKvzMzLczt8uLI3fKuDoYqkLSO9KtQUKq60AS0Gjw6Ll3PK2cosQq?=
 =?iso-8859-1?Q?1/uSBj3Udr9139adO2mSuWMBmxqQakJg4qxN8aOTvFLYcO+KsVxPrZtLKD?=
 =?iso-8859-1?Q?o5GPqEG25gZt94WG9ZF/rOhBzEJboAskj5PcDdzFfed70bS+JzBBP7dSD8?=
 =?iso-8859-1?Q?vk7evNJfpOVvl+L3PB9AG8/bUPOSL8WR2hd8OqvuXK5zmmBG7w1+Wet1Ed?=
 =?iso-8859-1?Q?Yj2W/2YC5ovuxrb4cwu7+BqzXaFLLFbqmzrTp47IaU4Joj9naqeed1Glcb?=
 =?iso-8859-1?Q?S1pp6asg9WUHpGWKSU9fX9LoUzv8iA/SJFdYppLlH49fOl1Ni00snfnvVi?=
 =?iso-8859-1?Q?hats9Xgpvt232AEZD8djJSKoM1sqwOsH2eupt+GLoZ/EPUuhE1Q2UMkXp9?=
 =?iso-8859-1?Q?PdcYZ1p1byKGCqx4gEGyFPOO36TNrWleyXMkO2XRGFWbyyo5xH9FggjVF2?=
 =?iso-8859-1?Q?oH5xp9BoKkIJKZaO05hzF8o3NCpllWlB0GDswAbg95HnctbHh4UB0UaiFj?=
 =?iso-8859-1?Q?8lU4xVb/ShFZvvjoWfekCdjHHoGfd/7e8UmeUhNVN72BdYkfQ+JHtNvNIV?=
 =?iso-8859-1?Q?PCzmmzyPsY3DwgNBxEQnYynGdRHg+5YdWgaTXo6gTurcU2Rbb+eIvLLmSq?=
 =?iso-8859-1?Q?Ge08zbHV4K+O6E3Iyw2OfCPNbhEL27kHQDiUMzBPdsB5oM7dyIgELaBGZO?=
 =?iso-8859-1?Q?S3ZuL2WAweQhxgEeloqor0YNkwxQI8w/GeBNBejZhBagF6PHltXnPeAxFe?=
 =?iso-8859-1?Q?4hjgR2CfTehTP2b/VTvx6VzQo4OYne52WQBJEmalRRGDpTrQoEbujeSKG5?=
 =?iso-8859-1?Q?eG+m3v4gdD8ATu6qFqHbFdk0ng6sd+3XzyUYDGACkQk9UE79MxBHenndO3?=
 =?iso-8859-1?Q?DusxPyfXE151BxKaHKGrT5yUuD+G4RjeiJOKECON3v+7iyZyR0Sxu0pRIe?=
 =?iso-8859-1?Q?QcpGlSJZYRF6Vh+aDoD1UBtdeDhom1+vcClSbWhzBnGivioqYTRpJAeDqf?=
 =?iso-8859-1?Q?mlzSZI7Y9mWAlbZkl6XNx53b4lygL8XT2O44y8mo8lNwvEmcCuJHD4NUk+?=
 =?iso-8859-1?Q?o9GReG+mlwMGHJ0aAkf7bHnvMSXfoMkHO9EcfBr+jZSdOPSYrcFrlfywh5?=
 =?iso-8859-1?Q?YsUcYmrY3vtfqJQ7UFckvlH5+LEjWQhjkl?=
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: SJ0PR11MB6744.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 9fef15f0-734e-4d0c-c2f5-08dd05522ceb
X-MS-Exchange-CrossTenant-originalarrivaltime: 15 Nov 2024 08:47:45.5153 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: mVOj2wcuu1pVGj/k94wy8uc/aq4Wd7PRnWjTBtjLybyOrP0ASStnW8ayoz3B81bpUNi0QanRDAZ7/8a+En0jq/cZkumt+IfFiOKe1HMsDxw=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA0PR11MB8301
X-OriginatorOrg: intel.com
Received-SPF: pass client-ip=198.175.65.14;
 envelope-from=zhenzhong.duan@intel.com; helo=mgamail.intel.com
X-Spam_score_int: -44
X-Spam_score: -4.5
X-Spam_bar: ----
X-Spam_report: (-4.5 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.122,
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
>From: C=E9dric Le Goater <clg@redhat.com>
>Sent: Friday, November 15, 2024 4:35 PM
>Subject: [PATCH v2] vfio/container: Fix container object destruction
>
>When commit 96b7af4388b3 intoduced a .instance_finalize() handler,
>it did not take into account that the container was not necessarily
>inserted into the container list of the address space. Hence, if
>the container object is destroyed, by calling object_unref() for
>example, before vfio_address_space_insert() is called, QEMU may
>crash when removing the container from the list as done in
>vfio_container_instance_finalize(). This was seen with an SEV-SNP
>guest for which discarding of RAM fails.
>
>To resolve this issue, use the safe version of QLIST_REMOVE().
>
>Cc: Zhenzhong Duan <zhenzhong.duan@intel.com>
>Cc: Eric Auger <eric.auger@redhat.com>
>Fixes: 96b7af4388b3 ("vfio/container: Move vfio_container_destroy() to an
>instance_finalize() handler")
>Signed-off-by: C=E9dric Le Goater <clg@redhat.com>

Reviewed-by: Zhenzhong Duan <zhenzhong.duan@intel.com>

Thanks
Zhenzhong


