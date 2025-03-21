Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B3BD1C35FFF
	for <qemu-devel@archiver.kernel.org>; Fri, 21 Mar 2025 09:45:42 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tvYw2-00080G-Bi; Fri, 21 Mar 2025 05:45:02 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <zhenzhong.duan@intel.com>)
 id 1tvYw1-0007zo-1o
 for qemu-devel@nongnu.org; Fri, 21 Mar 2025 05:45:01 -0400
Received: from mgamail.intel.com ([192.198.163.19])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <zhenzhong.duan@intel.com>)
 id 1tvYvy-0005pp-FZ
 for qemu-devel@nongnu.org; Fri, 21 Mar 2025 05:45:00 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1742550299; x=1774086299;
 h=from:to:cc:subject:date:message-id:references:
 in-reply-to:content-transfer-encoding:mime-version;
 bh=I+G+EwNC1RTAvDS9Xe6U8eja3OUu7POr4VBKze72PJM=;
 b=mWSz8UWlMJyZi8ksNluo590JEzwlgNaIWBvbEmXULrflGgSmdIT78AxA
 kHsBej/qTu1ewUqq9y8QzX5uvlV6rDIywFKoqT28AC6MGgR4zVItgfesJ
 Ilk+p8XwJc6d4M17zKNiG58vO9RB1syJp1qeIgfSovgczXJgvmProGqCH
 2CEB324MDmKNymAvTvNvAXmYo75dMAH/K9fYk9b5HhLJFf7g9/PHITXA8
 agVvjzhXagpAunHfdTsH3R0SAJ8dogXjCfZRVwz9kq9PfWxT+/eDdnJr2
 sx0+euSYFNFt1LWYnw8LygUkmCJdGLI7Jx6pgen5TfbeU69Glr9IG+OvO w==;
X-CSE-ConnectionGUID: 9SuRdUrGR/GokbnDb/WWdQ==
X-CSE-MsgGUID: S54XhXF/SRuH6fzeChIUoA==
X-IronPort-AV: E=McAfee;i="6700,10204,11379"; a="42975247"
X-IronPort-AV: E=Sophos;i="6.14,264,1736841600"; d="scan'208";a="42975247"
Received: from orviesa003.jf.intel.com ([10.64.159.143])
 by fmvoesa113.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 21 Mar 2025 02:44:55 -0700
X-CSE-ConnectionGUID: KP2KmO4eScCuZfdxdhT7QA==
X-CSE-MsgGUID: z5XKVeBATjebRPMUyByJqw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.14,264,1736841600"; d="scan'208";a="128185362"
Received: from orsmsx603.amr.corp.intel.com ([10.22.229.16])
 by orviesa003.jf.intel.com with ESMTP/TLS/AES256-GCM-SHA384;
 21 Mar 2025 02:44:54 -0700
Received: from orsmsx603.amr.corp.intel.com (10.22.229.16) by
 ORSMSX603.amr.corp.intel.com (10.22.229.16) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.44; Fri, 21 Mar 2025 02:44:54 -0700
Received: from orsedg603.ED.cps.intel.com (10.7.248.4) by
 orsmsx603.amr.corp.intel.com (10.22.229.16) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.44 via Frontend Transport; Fri, 21 Mar 2025 02:44:54 -0700
Received: from NAM11-DM6-obe.outbound.protection.outlook.com (104.47.57.170)
 by edgegateway.intel.com (134.134.137.100) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.44; Fri, 21 Mar 2025 02:44:53 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=W5Zpq/YhvuKyriLr4gLaRgT8LdIz2zwgBI14nkS3doCn9aCvf3QGmRzWHArtGwec2pbJIwqzuJQsjaADKyebPv7w6xrSkjHkR+RTtlk2oEEKHkDYU8TG/kRJd8f1+TOSh8WoRIt8aWfyBAgjuTCUKZ50bEpsfRfBRNMIRznGq7tqIlZWVZ9+uGhbqhnvxrpeFCx0ZpklsF9pRcT/HpzpIdNFt/oAXcqV3BMbrbK/t4njlFRuuY+hl4o0e8+VoycTYyTQkPzNf2uN4y07Hk8mBfDZhduBGfarMpn70iLjVC9oVRp31sg/jRbNBcKBovX1rn0ga1YMTkfCKJO+IYKHfA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=I+G+EwNC1RTAvDS9Xe6U8eja3OUu7POr4VBKze72PJM=;
 b=CF626z4EX76F5zdyUMJVzPtQmmCVxfREmCoBO7HyDdRdw862en8i5PcDAZhtSTKNSGXwtn9OiEw3Ib5kMHviLshJCVwGWS3LhzoHL5ApNY/wF3f0OzZ4Q0fViGcH+OwhdT1XVEpmIG2Pwrh+7UHI4lSv/cCXelvwm8tj07TOmF6pW65d2VMgfEMn9K4ni3OLFruUmSsukZKdTl7o/DTDd8saAkplakoyBGJkEEx4AwD/dUiP3vcHzTZHs0flxC7jeryuxF9PTVnmg7rYoolOFj2zF1LQBoyOuY2Fqd3EujiCtgeZKSlbiXebOQ4WncCl7LJ5OgJKfYemLITYdbeiHw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Received: from SJ0PR11MB6744.namprd11.prod.outlook.com (2603:10b6:a03:47d::10)
 by IA1PR11MB7366.namprd11.prod.outlook.com (2603:10b6:208:422::8)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8534.34; Fri, 21 Mar
 2025 09:44:18 +0000
Received: from SJ0PR11MB6744.namprd11.prod.outlook.com
 ([fe80::fe49:d628:48b1:6091]) by SJ0PR11MB6744.namprd11.prod.outlook.com
 ([fe80::fe49:d628:48b1:6091%6]) with mapi id 15.20.8534.034; Fri, 21 Mar 2025
 09:44:18 +0000
From: "Duan, Zhenzhong" <zhenzhong.duan@intel.com>
To: =?utf-8?B?Q8OpZHJpYyBMZSBHb2F0ZXI=?= <clg@redhat.com>,
 "qemu-devel@nongnu.org" <qemu-devel@nongnu.org>, Alex Williamson
 <alex.williamson@redhat.com>
CC: Avihai Horon <avihaih@nvidia.com>, Eric Auger <eric.auger@redhat.com>
Subject: RE: [PATCH for-10.1 24/32] vfio: Introduce new files for dirty
 tracking definitions and declarations
Thread-Topic: [PATCH for-10.1 24/32] vfio: Introduce new files for dirty
 tracking definitions and declarations
Thread-Index: AQHbl+v5GdaKalDSUk6u3PTGyZcGg7N7y3bwgAGM3YCAAAGQIA==
Date: Fri, 21 Mar 2025 09:44:18 +0000
Message-ID: <SJ0PR11MB6744BD888B5895CE7072D42E92DB2@SJ0PR11MB6744.namprd11.prod.outlook.com>
References: <20250318095415.670319-1-clg@redhat.com>
 <20250318095415.670319-25-clg@redhat.com>
 <SJ0PR11MB6744B94364FA17801C4C451592D82@SJ0PR11MB6744.namprd11.prod.outlook.com>
 <92f58be0-1ebe-417d-9921-5749d0eb9f10@redhat.com>
In-Reply-To: <92f58be0-1ebe-417d-9921-5749d0eb9f10@redhat.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: SJ0PR11MB6744:EE_|IA1PR11MB7366:EE_
x-ms-office365-filtering-correlation-id: 93fd9420-b683-4d23-8426-08dd685cf361
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0; ARA:13230040|366016|1800799024|376014|38070700018;
x-microsoft-antispam-message-info: =?utf-8?B?V1I4VEN4ekl5M0Z1LzI2SmNMR3BuNzdmd245REp3WG9CZk5JRnpWU2kvSW41?=
 =?utf-8?B?amVteTl5OGxKQTFSMWM0SFpaWjFRUzNFVGZVc2tseFlOSzVoeEM3andzcVFN?=
 =?utf-8?B?aGd1RWphQ1pCMmdNL1FKUXVKaGVWcWhaM0xURUZLa2pnaklXWVg3REFwMC9y?=
 =?utf-8?B?bnE5UzE1bUNPVjA5RWVxQ3JjZ09DNGc3c1QxdDdNaFEyOWRrODhZNmo0VnFV?=
 =?utf-8?B?dWxQa2lRTFZZYk5Za2FaOEI1VkRUVEVCOSs5cmcrR3dTQUJPZlBUL3pKY05i?=
 =?utf-8?B?dE1zdzcycWRycEoxRllVek1ZdHZGQkEzcmlxSHd6R1pOWkx4QVBOcE1zZ0NM?=
 =?utf-8?B?c0ZhTzBHaEVJaHUvS3Z2T0VmejlaeVJHSnJGSmx3UkVZeTBVL1hwa29zNjhF?=
 =?utf-8?B?VWJYN0FLNkN4ZTY5ZzV0Wnl0a0ptS1dhQVc2d1Q2Y1NWUjFpWFJDOWxIeHFC?=
 =?utf-8?B?MFRSK2UreWNhRGtncGdURnd5a1o3NURCa3VQSnNZRm0zeXhHUjFnd1A4cWxv?=
 =?utf-8?B?T1NSK1NRUk4xeUdQNzVvVFRDcEwyWGpiYWorYzBxVzhXQVNOOTFuZFhTcVpi?=
 =?utf-8?B?Tmw4QUwrcTJITFBPQ2x5NVRTZUxyZWtXTzFnWkZxTlhEUkVZYU04UTVMbU9O?=
 =?utf-8?B?ZE1VTzdKbVlnc0R3Sy9aWlpLSC9WMFk0WXNQRUszM0ttQlpKSEl6aGM4L0xY?=
 =?utf-8?B?cVJwM2VrYitrUW4xWFUrUzQvVUo5UGwvMFA2cmNPd2lqUHE5RUpDTmhIM3dB?=
 =?utf-8?B?NlNlTWpqd2FRYkdZc0VjNFlCd1JJVzNXakx1SDl1S24yMVk0eXJHM2pkTS91?=
 =?utf-8?B?WXBDM05YV1VMdlUycWJxNng0ejQxWWRFUFFYMmhabVNRejNhNzlNUVhKUUpM?=
 =?utf-8?B?Y0dSUWp4SW9xUktMZ0ZmOWdmR0IzRVNQNU1NOGhJekxCUXNxTzdmSEhqTEs1?=
 =?utf-8?B?TFdFZExGam5xWCs0YVRHSlU5TGhpZTVxUVpPQmEyaGxmMm5tT3pUTTM5cC82?=
 =?utf-8?B?Y3BZTzNnZFFxcFlTaUJpTXBlZitKMVFaaFdLOEd1cjRtM0N6YzhEYThSYXZu?=
 =?utf-8?B?L2NqQnRJSG41eEMxVGFwL1FWeHk5KzRCODJhNm1hNHJCSmNIQkduVW9uU21N?=
 =?utf-8?B?OGMxTWFKN3FMeC9OVHZDQTlWOW9uVUtpeFkzbWd0d2wvd2U5MlJ6QVhud0hD?=
 =?utf-8?B?M3RBVUFySlRyc1Jxbm1wTUxnNEJiSUtRUmxQdVl2M2VEdWpnY1FETGROUk03?=
 =?utf-8?B?WU5vaE5MeWdFRkJCMk1WRkh3VkUzaThpQTVIcml0ZEh6d2R1MDFZVjBRUkZw?=
 =?utf-8?B?Uk9GWFhURWZFMS9Sa2wwOU9LU1AvUmZvY2V5MzhKTXAvYzJpY0NYbVkxWFpv?=
 =?utf-8?B?REZKdHNEbzgyRFVleW9kalBWMk9kZHNrSVJRTWJwc0V2TTB4ZlZnNHBmakE3?=
 =?utf-8?B?VXh1cTlEQmFNVG1yVGZSVDV6cEVsdUNTbU51dlhSWktmT3lOOXdqQTAxR2RB?=
 =?utf-8?B?V1NQSXpidDBrZVExOHZqc3dqT3A4NU9CR2NvNE9pU3VoRzZyMUwxWVplVURs?=
 =?utf-8?B?QllIK3Y5akNrOE9uUGlmM3Z5VXJGcVZuZkJkNEhGalJFeCtpQ1NYdFNLdjFQ?=
 =?utf-8?B?NVBldXY0ejR3UDRWU05zN01HaUV2TGdKUHJYR1F2bFB0eFZXbzRNb3k1bUFu?=
 =?utf-8?B?QzhxVmVHUmg5RFkyd1JNQzgxUU13Wk8weWtzdUMvWXFPUTI0dHFiaG9WaWhk?=
 =?utf-8?B?STYzb1lPNFViWXd5L3lHb3VjdFUvNGlqbGdwMjhDSFphSkF5UnFGYzB2RVJP?=
 =?utf-8?B?d0hDbEpBTkM2UjFBRHZvRk52R0FWUitZR29JM2Y1aUpZWU9nMjkyOG8rTWx2?=
 =?utf-8?B?eWlQaUpKMjRRcmRuSWJicG5zdzhmNXFrNlkrYzM4clhzZ1lQaTBsOUFRWEpG?=
 =?utf-8?Q?rT81BxgCNu6wo5T/qvt4MyY80VEubaIi?=
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:SJ0PR11MB6744.namprd11.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(366016)(1800799024)(376014)(38070700018); DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?L25ORjk2MHZrR1lJWXRGdE44YjRKbnhnK1AyVGx2SEVHL3EwQ0RKSHExcnht?=
 =?utf-8?B?WXk0b3FPMHgvM1d1YkxQL0lmRkJmSnBDMTdCazlGeEd2dVhydnQybkpOSGFv?=
 =?utf-8?B?NmRYdDZQVUp5NitoYXlqTURRcmlNTUZ0THhrTWFlSnVrb2pCU3R3U0pya3Vw?=
 =?utf-8?B?LzR1OGdGbnpaSjc1UGhpOE5FNTd4WDlReU55TGxBVFBPd0pXN3cyeEJid1Ju?=
 =?utf-8?B?M3pJYTJFMm5GYUl0elJ5NldKeXBqMGZVb3RVVWR6Zk1ZdC9GQi9rYWRBZEJX?=
 =?utf-8?B?KzBGaGRUdXJ3bVRxZk9nRTRySkdzVU1YeGFTbkNhZXhPRk1QZXlidW9BU2tJ?=
 =?utf-8?B?RStGcTNrL1VHWHdXdXpzc2RYMTBDTE9ZcWg1Y2NPRURQUUc2NldSNFI3RHEw?=
 =?utf-8?B?Wk1ZV1MvZ3FjZmw2NlVUZ01nbDNMMDJSY3ZqeEFGNjVKK0ZyL1h5WHhwNXQ3?=
 =?utf-8?B?YXhiTXZEd1BNeWpiaTdHaGlONmRwWWxJYUNxOVBGSHR6c05xUGNUT0JyRzFK?=
 =?utf-8?B?UEszRXhoTm5RcjYvaFZFVnhYVmphVTEvcDFOcFFGM29McFBiaEhPR1FNN3h0?=
 =?utf-8?B?OWxCKy9va0F6NitVMUhCUlkyRWM2RkpOWWE5UFZoSVBWajVzZU5EaFdlSUtN?=
 =?utf-8?B?L3VpclBXTjFiRWNQNUtZdU1YNThzRkJMMXZicG8rWW1lNG1MQlUrUmxCR2gz?=
 =?utf-8?B?dzc2MlA0UFhFT1d1ZmppUVRORGJCWmF1TEpVb0c0S2t1c1R6V0RFQit6YWZI?=
 =?utf-8?B?SndoWDJlR1ZSeWRyV2dVT1hmK0JnRllMbU5HNnNVdXY1b2gvc3hmNFo1cEpK?=
 =?utf-8?B?K1ovbitvM2ttdytEQ0tFbDl3UkY5NVJEQUcvZS8vNE5GS3dFaGJYS2JCcXdV?=
 =?utf-8?B?Mm51SmVoOUQ5Ym55RG15a1h0SG1KUDlNTGZGdGp4NGJPUC9LNnAxR1hRMmlC?=
 =?utf-8?B?REExK1lhZlUxak5uVkFlSUVITWg1UzRJS1ZtVnlkUnhZQkZ6UUtEeVhqeGNL?=
 =?utf-8?B?WE80Mm1JQnJ1WDZudGY2WTZ5WGZrRWtvUXpxbDYxOVMyNWdaNTdDRVJZdGZD?=
 =?utf-8?B?aWN5T0ZHN1ZBRmJla1RnbElBL3NCR2FEeUR5Q3dOdjdnUHB3T1pUVk1UY3d3?=
 =?utf-8?B?cXpsbEo1K0kyanlwSTRxcG5aYk9xeXRqVUJrS21SWDZtbFpKMXl6am9XM3Rh?=
 =?utf-8?B?czB3ejdCNFFTOXFIYzBwdDFoNDZrY1o1YUNCMTY2aldhTjMyMWcwcHA1aThy?=
 =?utf-8?B?QUZvaVJBTkwzUjBXZlBZR0ZTOU1STXJWa1MvRUNGS3ZtaWw4UzFkcm4wb081?=
 =?utf-8?B?U2NMT0VnMllsN1RBN2trbVdjeElHMXl3eWdMcjJrOGZzYityWHdrMm1YOGFD?=
 =?utf-8?B?c3ljT1kxVG5Hbk5SaFdBRWxSZU9DRjB6WTRnU3dUMUlCZTNzZmxzOFFzQXVo?=
 =?utf-8?B?Rm16WGFYam1NQTNxM3lRT3lvSkRoUi9XaXdJUkNGTVRYVnhyOGs3TC9RTUp1?=
 =?utf-8?B?VmxEbm9WTXloNHhIRGJEeWF1cjFZMlhzcUE0dy9TTG9mZEpraXUxRGhYQ1dq?=
 =?utf-8?B?N2orSk9YdS8rYXNvcFZjMCtYT3B1cWNVN29pNTFSQlRUc29ReTFQOHZKeVdi?=
 =?utf-8?B?eXI2QlVIYWQ3NG5MRW15S3V0djg3Vy93NmRRbWZONVoyQzJwNER5cmpSMXRz?=
 =?utf-8?B?L1pIN1RYcFZyM1FVUTFzMy9HNGUwbUZ0aUVTdDl4U2tNeXMyam5YWjBjb0pk?=
 =?utf-8?B?dGwrUXZaM2loVmx0aVAyTUlKZjhibVBzVXY3dy9JU3JDR1dmVkd0WHhsaXF5?=
 =?utf-8?B?ZDlXOVVHVWtkK2k5d1lZVGc1YVRyZnM1L1l4ckRxWXVHcU9JcmFoNndJdHZD?=
 =?utf-8?B?SldwN3I3b1NLYnp6QUF1aCttbXRyU3RqK3ZjQ3RYeHNKQmlhTXNYVCt4ZWN3?=
 =?utf-8?B?YXMzZk5nNEtJdlJ5c2dNVm8wOFd6QW1KUG5mbERWVnBZbEdJMlFkNGw5Qjlq?=
 =?utf-8?B?UStvV005SFVZTkdIMXMrSEhOZ2dya3ZoVHFrc2t5SHFvdlNDSHZqcW9Ga2I3?=
 =?utf-8?B?TVJhY2R3akVYdmEvYU93Q0Vjck45UWsxYVBoL0cyd3JKTDI3U3J5Z0kyUUVQ?=
 =?utf-8?Q?zrv3uVjGZwLYZXtWwOZbIIfol?=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: SJ0PR11MB6744.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 93fd9420-b683-4d23-8426-08dd685cf361
X-MS-Exchange-CrossTenant-originalarrivaltime: 21 Mar 2025 09:44:18.5510 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: VBP1f8suKB0seAWwYai2UvYmEkRRcQ44AVMQgDnWU4Ci7xhtYVMYuz57trTJ1fIgL1+EDG8eCzl6jSpyP1/KOCBcHCDQGuIcthph2Uv6//Y=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA1PR11MB7366
X-OriginatorOrg: intel.com
Received-SPF: pass client-ip=192.198.163.19;
 envelope-from=zhenzhong.duan@intel.com; helo=mgamail.intel.com
X-Spam_score_int: -46
X-Spam_score: -4.7
X-Spam_bar: ----
X-Spam_report: (-4.7 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.332,
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

DQoNCj4tLS0tLU9yaWdpbmFsIE1lc3NhZ2UtLS0tLQ0KPkZyb206IEPDqWRyaWMgTGUgR29hdGVy
IDxjbGdAcmVkaGF0LmNvbT4NCj5TdWJqZWN0OiBSZTogW1BBVENIIGZvci0xMC4xIDI0LzMyXSB2
ZmlvOiBJbnRyb2R1Y2UgbmV3IGZpbGVzIGZvciBkaXJ0eSB0cmFja2luZw0KPmRlZmluaXRpb25z
IGFuZCBkZWNsYXJhdGlvbnMNCj4NCj5PbiAzLzIwLzI1IDEwOjUyLCBEdWFuLCBaaGVuemhvbmcg
d3JvdGU6DQo+Pg0KPj4NCj4+PiAtLS0tLU9yaWdpbmFsIE1lc3NhZ2UtLS0tLQ0KPj4+IEZyb206
IEPDqWRyaWMgTGUgR29hdGVyIDxjbGdAcmVkaGF0LmNvbT4NCj4+PiBTdWJqZWN0OiBbUEFUQ0gg
Zm9yLTEwLjEgMjQvMzJdIHZmaW86IEludHJvZHVjZSBuZXcgZmlsZXMgZm9yIGRpcnR5IHRyYWNr
aW5nDQo+Pj4gZGVmaW5pdGlvbnMgYW5kIGRlY2xhcmF0aW9ucw0KPj4+DQo+Pj4gRmlsZSAiY29t
bW9uLmMiIGhhcyBiZWVuIGVtcHRpZWQgb2YgbW9zdCBvZiBpdHMgZGVmaW5pdGlvbnMgYnkgdGhl
DQo+Pj4gcHJldmlvdXMgY2hhbmdlcyBhbmQgdGhlIG9ubHkgZGVmaW5pdGlvbnMgbGVmdCBhcmUg
cmVsYXRlZCB0byBkaXJ0eQ0KPj4+IHRyYWNraW5nLiBSZW5hbWUgaXQgdG8gImRpcnR5LXRyYWNr
aW5nLmMiIGFuZCBpbnRyb2R1Y2UgaXRzIGFzc29jaWF0ZWQNCj4+PiAiZGlydHktdHJhY2tpbmcu
aCIgaGVhZGVyIGZpbGUgZm9yIHRoZSBkZWNsYXJhdGlvbnMuDQo+Pj4NCj4+PiBDbGVhbnVwIGEg
bGl0dGxlIHRoZSBpbmNsdWRlcyB3aGlsZSBhdCBpdC4NCj4+Pg0KPj4+IFNpZ25lZC1vZmYtYnk6
IEPDqWRyaWMgTGUgR29hdGVyIDxjbGdAcmVkaGF0LmNvbT4NCj4+PiAtLS0NCj4+PiBody92Zmlv
L2RpcnR5LXRyYWNraW5nLmggICAgICAgICAgICAgICB8IDIyICsrKysrKysrKysrKysrKysrKysr
KysNCj4+PiBpbmNsdWRlL2h3L3ZmaW8vdmZpby1jb21tb24uaCAgICAgICAgICB8IDEwIC0tLS0t
LS0tLS0NCj4+PiBody92ZmlvL2NvbnRhaW5lci5jICAgICAgICAgICAgICAgICAgICB8ICAxICsN
Cj4+PiBody92ZmlvL3tjb21tb24uYyA9PiBkaXJ0eS10cmFja2luZy5jfSB8ICA1ICstLS0tDQo+
Pj4gaHcvdmZpby9pb21tdWZkLmMgICAgICAgICAgICAgICAgICAgICAgfCAgMSArDQo+Pj4gaHcv
dmZpby9tZXNvbi5idWlsZCAgICAgICAgICAgICAgICAgICAgfCAgMiArLQ0KPj4+IGh3L3ZmaW8v
dHJhY2UtZXZlbnRzICAgICAgICAgICAgICAgICAgIHwgIDIgKy0NCj4+PiA3IGZpbGVzIGNoYW5n
ZWQsIDI3IGluc2VydGlvbnMoKyksIDE2IGRlbGV0aW9ucygtKQ0KPj4+IGNyZWF0ZSBtb2RlIDEw
MDY0NCBody92ZmlvL2RpcnR5LXRyYWNraW5nLmgNCj4+PiByZW5hbWUgaHcvdmZpby97Y29tbW9u
LmMgPT4gZGlydHktdHJhY2tpbmcuY30gKDk5JSkNCj4+Pg0KPj4+IGRpZmYgLS1naXQgYS9ody92
ZmlvL2RpcnR5LXRyYWNraW5nLmggYi9ody92ZmlvL2RpcnR5LXRyYWNraW5nLmgNCj4+PiBuZXcg
ZmlsZSBtb2RlIDEwMDY0NA0KPj4+IGluZGV4DQo+Pj4NCj4wMDAwMDAwMDAwMDAwMDAwMDAwMDAw
MDAwMDAwMDAwMDAwMDAwMDAwLi40YjgzZGM1NGFiNTBkYWJmZmYwNDBkN2NjMw0KPj4+IGRiMjdi
ODBiZmUyZDNhDQo+Pj4gLS0tIC9kZXYvbnVsbA0KPj4+ICsrKyBiL2h3L3ZmaW8vZGlydHktdHJh
Y2tpbmcuaA0KPj4+IEBAIC0wLDAgKzEsMjIgQEANCj4+PiArLyoNCj4+PiArICogVkZJTyBkaXJ0
eSBwYWdlIHRyYWNraW5nIHJvdXRpbmVzDQo+Pj4gKyAqDQo+Pj4gKyAqIENvcHlyaWdodCBSZWQg
SGF0LCBJbmMuIDIwMjUNCj4+PiArICoNCj4+PiArICogU1BEWC1MaWNlbnNlLUlkZW50aWZpZXI6
IEdQTC0yLjAtb3ItbGF0ZXINCj4+PiArICovDQo+Pj4gKw0KPj4+ICsjaWZuZGVmIEhXX1ZGSU9f
RElSVFlfVFJBQ0tJTkdfSA0KPj4+ICsjZGVmaW5lIEhXX1ZGSU9fRElSVFlfVFJBQ0tJTkdfSA0K
Pj4+ICsNCj4+PiArZXh0ZXJuIGNvbnN0IE1lbW9yeUxpc3RlbmVyIHZmaW9fbWVtb3J5X2xpc3Rl
bmVyOw0KPj4+ICsNCj4+PiArYm9vbCB2ZmlvX2RldmljZXNfYWxsX2RpcnR5X3RyYWNraW5nX3N0
YXJ0ZWQoY29uc3QgVkZJT0NvbnRhaW5lckJhc2UNCj4+PiAqYmNvbnRhaW5lcik7DQo+Pj4gK2Jv
b2wgdmZpb19kZXZpY2VzX2FsbF9kZXZpY2VfZGlydHlfdHJhY2tpbmcoY29uc3QgVkZJT0NvbnRh
aW5lckJhc2UNCj4+PiAqYmNvbnRhaW5lcik7DQo+Pj4gK2ludCB2ZmlvX2RldmljZXNfcXVlcnlf
ZGlydHlfYml0bWFwKGNvbnN0IFZGSU9Db250YWluZXJCYXNlICpiY29udGFpbmVyLA0KPj4+ICsg
ICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICBWRklPQml0bWFwICp2Ym1hcCwgaHdh
ZGRyIGlvdmEsIGh3YWRkciBzaXplLA0KPj4+ICsgICAgICAgICAgICAgICAgICAgICAgICAgICAg
ICAgICAgICBFcnJvciAqKmVycnApOw0KPj4+ICtpbnQgdmZpb19nZXRfZGlydHlfYml0bWFwKGNv
bnN0IFZGSU9Db250YWluZXJCYXNlICpiY29udGFpbmVyLCB1aW50NjRfdA0KPmlvdmEsDQo+Pj4g
KyAgICAgICAgICAgICAgICAgICAgICAgICAgdWludDY0X3Qgc2l6ZSwgcmFtX2FkZHJfdCByYW1f
YWRkciwgRXJyb3IgKiplcnJwKTsNCj4+PiArDQo+Pj4gKyNlbmRpZiAvKiBIV19WRklPX0RJUlRZ
X1RSQUNLSU5HX0ggKi8NCj4+PiBkaWZmIC0tZ2l0IGEvaW5jbHVkZS9ody92ZmlvL3ZmaW8tY29t
bW9uLmggYi9pbmNsdWRlL2h3L3ZmaW8vdmZpby1jb21tb24uaA0KPj4+IGluZGV4DQo+Pj4NCj4x
ODRhNDIyOTE2ZjYyMjU5MTU4ZTg3NTllZmM0NzNhNWVmYjJiMmY3Li5jYzIwMTEwZDlkZThhYzE3
M2I2N2U2ZTg3OA0KPj4+IGQ0ZDYxODE4NDk3NDI2IDEwMDY0NA0KPj4+IC0tLSBhL2luY2x1ZGUv
aHcvdmZpby92ZmlvLWNvbW1vbi5oDQo+Pj4gKysrIGIvaW5jbHVkZS9ody92ZmlvL3ZmaW8tY29t
bW9uLmgNCj4+PiBAQCAtMTMwLDcgKzEzMCw2IEBAIFZGSU9EZXZpY2UgKnZmaW9fZ2V0X3ZmaW9f
ZGV2aWNlKE9iamVjdCAqb2JqKTsNCj4+Pg0KPj4+IHR5cGVkZWYgUUxJU1RfSEVBRChWRklPRGV2
aWNlTGlzdCwgVkZJT0RldmljZSkgVkZJT0RldmljZUxpc3Q7DQo+Pj4gZXh0ZXJuIFZGSU9EZXZp
Y2VMaXN0IHZmaW9fZGV2aWNlX2xpc3Q7DQo+Pj4gLWV4dGVybiBjb25zdCBNZW1vcnlMaXN0ZW5l
ciB2ZmlvX21lbW9yeV9saXN0ZW5lcjsNCj4+Pg0KPj4+ICNpZmRlZiBDT05GSUdfTElOVVgNCj4+
PiBpbnQgdmZpb19nZXRfcmVnaW9uX2luZm8oVkZJT0RldmljZSAqdmJhc2VkZXYsIGludCBpbmRl
eCwNCj4+PiBAQCAtMTQwLDE1ICsxMzksNiBAQCBpbnQgdmZpb19nZXRfZGV2X3JlZ2lvbl9pbmZv
KFZGSU9EZXZpY2UgKnZiYXNlZGV2LA0KPj4+IHVpbnQzMl90IHR5cGUsDQo+Pj4gYm9vbCB2Zmlv
X2hhc19yZWdpb25fY2FwKFZGSU9EZXZpY2UgKnZiYXNlZGV2LCBpbnQgcmVnaW9uLCB1aW50MTZf
dA0KPmNhcF90eXBlKTsNCj4+PiAjZW5kaWYNCj4+Pg0KPj4+IC1ib29sIHZmaW9fZGV2aWNlc19h
bGxfZGlydHlfdHJhY2tpbmdfc3RhcnRlZCgNCj4+PiAtICAgIGNvbnN0IFZGSU9Db250YWluZXJC
YXNlICpiY29udGFpbmVyKTsNCj4+PiAtYm9vbA0KPj4+IC12ZmlvX2RldmljZXNfYWxsX2Rldmlj
ZV9kaXJ0eV90cmFja2luZyhjb25zdCBWRklPQ29udGFpbmVyQmFzZQ0KPipiY29udGFpbmVyKTsN
Cj4+PiAtaW50IHZmaW9fZGV2aWNlc19xdWVyeV9kaXJ0eV9iaXRtYXAoY29uc3QgVkZJT0NvbnRh
aW5lckJhc2UgKmJjb250YWluZXIsDQo+Pj4gLSAgICAgICAgICAgICAgICBWRklPQml0bWFwICp2
Ym1hcCwgaHdhZGRyIGlvdmEsIGh3YWRkciBzaXplLCBFcnJvciAqKmVycnApOw0KPj4+IC1pbnQg
dmZpb19nZXRfZGlydHlfYml0bWFwKGNvbnN0IFZGSU9Db250YWluZXJCYXNlICpiY29udGFpbmVy
LCB1aW50NjRfdA0KPmlvdmEsDQo+Pj4gLSAgICAgICAgICAgICAgICAgICAgICAgICAgdWludDY0
X3Qgc2l6ZSwgcmFtX2FkZHJfdCByYW1fYWRkciwgRXJyb3IgKiplcnJwKTsNCj4+PiAtDQo+Pj4g
LyogUmV0dXJucyAwIG9uIHN1Y2Nlc3MsIG9yIGEgbmVnYXRpdmUgZXJybm8uICovDQo+Pj4gYm9v
bCB2ZmlvX2RldmljZV9nZXRfbmFtZShWRklPRGV2aWNlICp2YmFzZWRldiwgRXJyb3IgKiplcnJw
KTsNCj4+PiB2b2lkIHZmaW9fZGV2aWNlX3NldF9mZChWRklPRGV2aWNlICp2YmFzZWRldiwgY29u
c3QgY2hhciAqc3RyLCBFcnJvciAqKmVycnApOw0KPj4+IGRpZmYgLS1naXQgYS9ody92ZmlvL2Nv
bnRhaW5lci5jIGIvaHcvdmZpby9jb250YWluZXIuYw0KPj4+IGluZGV4DQo+Pj4NCj40ZTQxYTc0
NzY1NDlhMGM1ZTQ2NGU0OTlkMDU5ZGI1YWNhNmUzNDcwLi5lODhkZmUxMmVkZDZkZWU0NjljMDZl
ZTJlDQo+Pj4gNDZhYjljOGI1MDE5YWU3IDEwMDY0NA0KPj4+IC0tLSBhL2h3L3ZmaW8vY29udGFp
bmVyLmMNCj4+PiArKysgYi9ody92ZmlvL2NvbnRhaW5lci5jDQo+Pj4gQEAgLTM1LDYgKzM1LDcg
QEANCj4+PiAjaW5jbHVkZSAiaHcvdmZpby92ZmlvLWNvbnRhaW5lci5oIg0KPj4+ICNpbmNsdWRl
ICJoZWxwZXJzLmgiDQo+Pj4gI2luY2x1ZGUgImNwci5oIg0KPj4+ICsjaW5jbHVkZSAiZGlydHkt
dHJhY2tpbmcuaCINCj4+Pg0KPj4+ICNkZWZpbmUgVFlQRV9IT1NUX0lPTU1VX0RFVklDRV9MRUdB
Q1lfVkZJTw0KPj4+IFRZUEVfSE9TVF9JT01NVV9ERVZJQ0UgIi1sZWdhY3ktdmZpbyINCj4+Pg0K
Pj4+IGRpZmYgLS1naXQgYS9ody92ZmlvL2NvbW1vbi5jIGIvaHcvdmZpby9kaXJ0eS10cmFja2lu
Zy5jDQo+Pj4gc2ltaWxhcml0eSBpbmRleCA5OSUNCj4+PiByZW5hbWUgZnJvbSBody92ZmlvL2Nv
bW1vbi5jDQo+Pj4gcmVuYW1lIHRvIGh3L3ZmaW8vZGlydHktdHJhY2tpbmcuYw0KPj4+IGluZGV4
DQo+Pj4NCj5lZDJmMmVkODgzOWNhYWY0MGZhYmIwY2JiY2FhMWRmMmM1YjcwZDY3Li40NDFmOWQ5
YTA4YzA2YTg4ZGRhNDRlZjE0M2QNCj4+PiBjZWU1ZjBhODlhOTAwIDEwMDY0NA0KPj4+IC0tLSBh
L2h3L3ZmaW8vY29tbW9uLmMNCj4+PiArKysgYi9ody92ZmlvL2RpcnR5LXRyYWNraW5nLmMNCj4+
PiBAQCAtMjAsMTQgKzIwLDEwIEBADQo+Pj4NCj4+PiAjaW5jbHVkZSAicWVtdS9vc2RlcC5oIg0K
Pj4+ICNpbmNsdWRlIDxzeXMvaW9jdGwuaD4NCj4+PiAtI2lmZGVmIENPTkZJR19LVk0NCj4+PiAt
I2luY2x1ZGUgPGxpbnV4L2t2bS5oPg0KPj4+IC0jZW5kaWYNCj4+DQo+PiBJdCBsb29rcyB0aGlz
IGNoYW5nZSB1bnJlbGF0ZWQgdG8gdGhpcyBwYXRjaD8NCj4+DQo+Pj4gI2luY2x1ZGUgPGxpbnV4
L3ZmaW8uaD4NCj4+Pg0KPj4+ICNpbmNsdWRlICJody92ZmlvL3ZmaW8tY29tbW9uLmgiDQo+Pj4g
I2luY2x1ZGUgImh3L3ZmaW8vcGNpLmgiDQo+Pj4gLSNpbmNsdWRlICJleGVjL2FkZHJlc3Mtc3Bh
Y2VzLmgiDQo+Pg0KPj4gU2FtZSBoZXJlLg0KPg0KPnllcyBhbmQgbm8uIENvbW1pdCBsb2cgc2F5
cyA6DQo+DQo+ICAgQ2xlYW51cCBhIGxpdHRsZSB0aGUgaW5jbHVkZXMgd2hpbGUgYXQgaXQuDQo+
DQo+YnV0IGlmIHlvdSBwcmVmZXIgd2UgY2FuIGFkZHJlc3MgdGhlIGluY2x1ZGUgcHJvbGlmZXJh
dGlvbiBpbiBhIHBhdGNoDQo+b2YgaXRzIG93biA/DQoNCk5vIG5lZWQsIHRoaXMgaXMgZmluZSBh
bHJlYWR5Lg0KUHJldmlvdXNseSBJIHRob3VnaHQgYmV0dGVyIHRvIG1vdmUgaW50byAnW1BBVENI
IGZvci0xMC4xIDEzLzMyXSB2ZmlvOiBNb3ZlIFZGSU9BZGRyZXNzU3BhY2UgaGVscGVycyBpbnRv
IGNvbnRhaW5lci1iYXNlLmMnLA0KYnV0IEknbSB3cm9uZywgaXQncyBqdXN0IHB1cmVseSB1c2Vs
ZXNzIGNvZGUuDQoNClRoYW5rcw0KWmhlbnpob25nDQo=

