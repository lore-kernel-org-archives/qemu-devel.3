Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 39109C5B543
	for <qemu-devel@archiver.kernel.org>; Thu,  5 Jun 2025 03:03:47 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uN0sZ-0005xn-He; Wed, 04 Jun 2025 23:02:55 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <zhenzhong.duan@intel.com>)
 id 1uN0sX-0005xS-6G
 for qemu-devel@nongnu.org; Wed, 04 Jun 2025 23:02:53 -0400
Received: from mgamail.intel.com ([198.175.65.10])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <zhenzhong.duan@intel.com>)
 id 1uN0sU-0003A8-1V
 for qemu-devel@nongnu.org; Wed, 04 Jun 2025 23:02:52 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1749092570; x=1780628570;
 h=from:to:cc:subject:date:message-id:references:
 in-reply-to:content-transfer-encoding:mime-version;
 bh=CA2If2rV+ldxPm7mKpRG7WXxbocgebNiisfwthyVHk8=;
 b=g91mOG2xOsvDFT5YCueCQd+fj5HJKHlgEdBQ0OvGkYIe3CzI0b5bdKqc
 y/nuia/2lCQPXeby/1qpgank8+f33p1Lhw+RT7Z+fGYlqxua26T4wT8Sz
 yGbxEcAkBiXD4nAmlkqbEBpNaCyBZw5PdtgkeassKdyudk8UvpLZ+ZSEw
 7OWWMXbabOz2b6SIz+y0WorJFomoT72HY1MA/cY3Ih9P+9QbnwFMMHruw
 QyIdi3oxr11PLFeWX6i3IeH0R4rL+1vMZEAlYk9wrBDXnOJrSOgW16CLz
 uNA7lUnqXE4K1b5M8K1rTvHL9VHGLCAijnxWv4VwGQQePMIQKqIp+Gbs0 Q==;
X-CSE-ConnectionGUID: rL7qGgO9TeCLmdu02kWP7A==
X-CSE-MsgGUID: tjCvOniRSBOsLCmhxDqggw==
X-IronPort-AV: E=McAfee;i="6800,10657,11454"; a="68633478"
X-IronPort-AV: E=Sophos;i="6.16,211,1744095600"; d="scan'208";a="68633478"
Received: from orviesa001.jf.intel.com ([10.64.159.141])
 by orvoesa102.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 04 Jun 2025 20:02:42 -0700
X-CSE-ConnectionGUID: RRHRXpmYQnKuDk1EHyE2wQ==
X-CSE-MsgGUID: PJ7UyYFGQ4e8y+gM9cB3rQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.16,211,1744095600"; d="scan'208";a="182579636"
Received: from orsmsx901.amr.corp.intel.com ([10.22.229.23])
 by orviesa001.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 04 Jun 2025 20:02:42 -0700
Received: from ORSMSX901.amr.corp.intel.com (10.22.229.23) by
 ORSMSX901.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.25; Wed, 4 Jun 2025 20:02:41 -0700
Received: from orsedg603.ED.cps.intel.com (10.7.248.4) by
 ORSMSX901.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.25 via Frontend Transport; Wed, 4 Jun 2025 20:02:41 -0700
Received: from NAM12-MW2-obe.outbound.protection.outlook.com (40.107.244.83)
 by edgegateway.intel.com (134.134.137.100) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.55; Wed, 4 Jun 2025 20:02:40 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=GORQzNLEdX2rbpeBZI9Z+8H0tDiDcDDW5uQ6QThbFu7Szyes6dUxOwqlpKG5794iax85xZCdA7L6zWKB8fBcF06TYxJF82KDH28bnbGU57ddHeiuYjDBbqxVUIq7G0S++vsia28Ko/3X014GByPBmh1FQ94ff5HrZ1yeK+LQ6iaepoDPHvLJAuNLA+Moopt+YvESc4O7IE/QuGV7wVVGPmieh53LbonJONpAzb2fojyyPrQWSRCGW6JGYMBFJdQSkZnqZeeVTiPdqcGdmT4ojP2e5f5vcySAqOu1mJ/rqRK3z6611xB1voGKremnGQ/O1r4NlgJTftb+Tkoh8UYDDw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=CA2If2rV+ldxPm7mKpRG7WXxbocgebNiisfwthyVHk8=;
 b=Mdu1gsqJozLKOp/Lc7/ZzYi43P0MGop5lb/w77GpRMZU7SHQRHfOwkev6v1uR27JNqIQiV0hJoFhMXWEQGodQCH+urd1FoqxPb/iZaGqXeP+NK/Zppf3Z5E37+LZpsCNjt3beISqHe9/Na/T9rthUxbF79ijoURuqh7gcC9d+tjw5A7wQB2DGsfbdeBamWVBjp1HOdyCVLX7HoBrGKvNyhjZetdCzBEnf9gqrCrU0PFdQux4dgZd6YWqwtYpraUaD+dld+T9t7iYa8BgOHQuR4ajpJfKMivSQgUTaDPrmshGy2kscOkDHWcHEBVQ7zgtLk0VOJusYdX2zlhJVNwcZA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Received: from IA3PR11MB9136.namprd11.prod.outlook.com (2603:10b6:208:574::12)
 by CYXPR11MB8664.namprd11.prod.outlook.com (2603:10b6:930:e6::8) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8792.33; Thu, 5 Jun
 2025 03:02:20 +0000
Received: from IA3PR11MB9136.namprd11.prod.outlook.com
 ([fe80::604b:77a4:b1be:3f13]) by IA3PR11MB9136.namprd11.prod.outlook.com
 ([fe80::604b:77a4:b1be:3f13%4]) with mapi id 15.20.8769.037; Thu, 5 Jun 2025
 03:02:20 +0000
From: "Duan, Zhenzhong" <zhenzhong.duan@intel.com>
To: Steven Sistare <steven.sistare@oracle.com>, "qemu-devel@nongnu.org"
 <qemu-devel@nongnu.org>
CC: Alex Williamson <alex.williamson@redhat.com>, Cedric Le Goater
 <clg@redhat.com>, "Liu, Yi L" <yi.l.liu@intel.com>, Eric Auger
 <eric.auger@redhat.com>, "Michael S. Tsirkin" <mst@redhat.com>, "Marcel
 Apfelbaum" <marcel.apfelbaum@gmail.com>, Peter Xu <peterx@redhat.com>,
 Fabiano Rosas <farosas@suse.de>
Subject: RE: [PATCH V4 04/43] vfio/pci: vfio_pci_put_device on failure
Thread-Topic: [PATCH V4 04/43] vfio/pci: vfio_pci_put_device on failure
Thread-Index: AQHb0M9ffeBve8sbTkmcsVPSqsxgBbPxRJcggAA8BYCAAOO3kIAApHWAgADg0VA=
Date: Thu, 5 Jun 2025 03:02:20 +0000
Message-ID: <IA3PR11MB9136014A45DEE58E09ED31F0926FA@IA3PR11MB9136.namprd11.prod.outlook.com>
References: <1748546679-154091-1-git-send-email-steven.sistare@oracle.com>
 <1748546679-154091-5-git-send-email-steven.sistare@oracle.com>
 <IA3PR11MB913626075C1F4FA64AED3B63926DA@IA3PR11MB9136.namprd11.prod.outlook.com>
 <65ebacc7-ee7e-4c44-92fb-e75a0a6490a8@oracle.com>
 <IA3PR11MB913659879C0B2EFF7358B229926CA@IA3PR11MB9136.namprd11.prod.outlook.com>
 <aa0c0091-7db4-46f3-956a-03a9f1362c1f@oracle.com>
In-Reply-To: <aa0c0091-7db4-46f3-956a-03a9f1362c1f@oracle.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: IA3PR11MB9136:EE_|CYXPR11MB8664:EE_
x-ms-office365-filtering-correlation-id: 1aa9679d-eaa9-43a5-f067-08dda3dd6335
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0; ARA:13230040|376014|1800799024|366016|38070700018;
x-microsoft-antispam-message-info: =?utf-8?B?bitFb0JKMUlydEpUTDJwSUJPQ3haaGVwNXg5elRxSUdLdkJzbHZ2M1lUUGhY?=
 =?utf-8?B?RjV4Vkx4bFpGc09pVTFDbEVQYjVQUTE0YWNWR1hocWtXZXhmdTdqczFXRjU4?=
 =?utf-8?B?c2ZxRHlGSkMrRUVWeDQ4RHpxcFhHam15bm1USk9NaWZLL0xmY016NmF6T2dG?=
 =?utf-8?B?QVg5VktZb0JaTzVkRnp2Nzc5Q2J2ZFhQR1l1SDhnQWhTSGVIMmxPY3N1MnFx?=
 =?utf-8?B?amRuS0owWjJjdmxIbXBQbW5GcEdyUlVLRGRtem5IQ1BmN05JUUltT0c4WGF3?=
 =?utf-8?B?RDUyQmU0ZXZkcGdaV1RVdDNoRTdDQnAvYStwTGREUmVVbklzZ1MyODM0M2xr?=
 =?utf-8?B?dmtzRmNHcVJieWNqUURPYWY5clhOd3NweWt5ZFh2UGFWa2dUTVNvQUhoemtP?=
 =?utf-8?B?aEtlQWRheTBzUHAyWnBmSlBjK2xHOFJySE9UWE84dytZR1p0Z2dzTFNqcUFr?=
 =?utf-8?B?cjdpS0gyU1V2KzNPcVFLbE82dm5wbDI0cWNrWkQ5RmZpUzc0NFBLVkNRUjRS?=
 =?utf-8?B?eHdpNkJMZjhsMkJHR2hZQXBTZVkrNjQyQjV0TVhIR0hmVVJCN3F1b09CQVRM?=
 =?utf-8?B?OVVQd2RqVk1xWUlVVURCVCt5NlhKSWV2N3hBRHF5UzhoSDRIT3ZYZmQxeDFR?=
 =?utf-8?B?NFlzL1NDS0RuMUhGU0JFcjhQaWE1QXpPdnRxQnovTWFIZzZwZ0k5bHAvcGgx?=
 =?utf-8?B?b054WXUwdkgyRWRLbkxlNjdMd1R5cml1enFCbCt2SUVzMVR4TzMvQ21lSGF0?=
 =?utf-8?B?alc0eFprWFRMWTVQR3hjZFNtWFJtMlRlWklIOGFNT3gvbVlka1ZGRFI1dHhk?=
 =?utf-8?B?WCtRSGhIZjZlMVVTY0J0UUh6dmV3RHNOaHZRVGprTTJEWmhiUmd5a0dyZUEy?=
 =?utf-8?B?bXNKRTlNS3dJejAvem5Fb291NDFBMFptWDBDUnpnKy84VXVXeDZwZHhlQjJa?=
 =?utf-8?B?dWIyQjQ2T3VUekd6azdLZTVHdFBENWMwZk80dm5ERHZGUHpQSTJTVmRBQkZo?=
 =?utf-8?B?dFVUSUtDcjJvNTdPdVN4WWNENUdhVkNkamh0QVVHQjZxeGxjQzgzMUpzQXc2?=
 =?utf-8?B?L1lhdnV0SGYyYnN2b0xxSUdNMVU1Z0hqMnlycWdVRDZVNGpPZ2swd0VNcGcx?=
 =?utf-8?B?SlE2ai9PZlpJMEFtYmZXV1Q0d2MyOWtSbGJnU042aDFMVHpianBBOXVCQkdt?=
 =?utf-8?B?UkFneUNCYzZkaWRPdkgxMno4Y2w0SDUzMTdkWnZXMHFEd1hKeUhUS0MwMlZV?=
 =?utf-8?B?VzhIbHdNd3o2VnFmY3BhMDc0TzBwSjdKV0RHSEZ1dUtYQWk0RkthT2w3c1JF?=
 =?utf-8?B?NThxR3FRQlZxY3ViTnNRNWdjTFByc2VOZFFsNk5kUjBEVUdCYjR6aVNUbnBi?=
 =?utf-8?B?YXo0cWU4b1JzYzJUcjAraVdLK0J3R3dOUHAydGRTSXI5VGxVWm5EV2h0Z09j?=
 =?utf-8?B?S1pRUDJFUnJzQ0dLMkRvcW5tTlpTbE41b1JGZThyNUkzbHRoTy9qc2VJMjlD?=
 =?utf-8?B?TFdmSDlGTCtid2RtQjE2K2RCSi90Zmg4K2I1U0VvWHVadURjVkluampKaHdS?=
 =?utf-8?B?ekd4WWZ0bVdnRkZpV2xxNlhMdEpzZzRsdmlRT09WYXJOTkQzVy8vMUNJQ1d0?=
 =?utf-8?B?M3ZmbXVSNmFBVFFKcVJGQ3ZibkJxQWtFWHJOc2toam1HWlEza2VnWUdpZnhW?=
 =?utf-8?B?b09oRjVKTzZyc0ZNc3FHcWVJZkkyYzFRT05nRTdseDAxajNNWmdyKzlxY3BQ?=
 =?utf-8?B?b3lFMXZocFZESUNoRStmS1VlSkFLaUdXS2hGUFZUV1NvaE1xOG10d0Y0ZE9p?=
 =?utf-8?B?a0ptMWpkTk4waStkR2VXaEd6UmFoc0t1NWgrSitQSDczZTl5U085WEhUaWxj?=
 =?utf-8?B?SjJmOXN2elF4VERzTlVvQ2pNTlBIRHordGt2T2ZEZHNQdkxlYWFEQUNyb1lV?=
 =?utf-8?B?YlRnZjRaZ2F2R1YwUTRQeVVBY1IrVXNsREE2ekxrS05xY3A3Y3FPQnNzNytP?=
 =?utf-8?Q?F2ZyoDKUlnjt/dTUp1CcGUskEucH/Q=3D?=
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:IA3PR11MB9136.namprd11.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(376014)(1800799024)(366016)(38070700018); DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?eC9TMXhueDNrMEFkY3ViVXUxTER2TDBKWkhYeWRkRzNES3ZKcUhMVWZraEdp?=
 =?utf-8?B?NG9DNkptUlJwcXBvaCtYaWgya1dycEJ5SFpVZ3NQSFA3SGswdW1aQk1ob2px?=
 =?utf-8?B?N1dBSVRreGttSHF6WnNGaXVuK3grT0c4eXJtZGVIWUMzQWVWVUFXaUlidk4x?=
 =?utf-8?B?R2lrNDJta2RQa0ptaUE4TEFmTmRFamZ0aVM0d0lYQ1dyU0dBb1JZbHBweU13?=
 =?utf-8?B?UXgzTzRLdmdIRHlzcEExVnlQYXdld2czb2tIODJPeTY1MEg3ekZuUnR4R3Z3?=
 =?utf-8?B?c21OdlRHSUc0UDFHYXZkUlhEYkl6LzFkbHdic1dtSC82aWF2QVZ6S0l5NXlZ?=
 =?utf-8?B?V09pa1dlMWZVRlBrQVdHQTROQ283N1kxbTlZRm5RNDhGTUNtU3N0YjB2dmZR?=
 =?utf-8?B?d1RNaEV1N0tOVUJsV1lkZnZsSVBtVS9BdjJjQ3lqWkFqSXZDVlNjYVpUQXBO?=
 =?utf-8?B?KzZMdjhpU2JHeTVtb0Y4UFcrSWt5RVlFamI1aUlhbzJhbThuYkJCNjJvWlN6?=
 =?utf-8?B?aDJtV1I2NzRxZnNBSHFpd2g5bmdGOHd4VmkxY2VKMWJsbVNFbnBLelhSSDRX?=
 =?utf-8?B?WjJZWG5ybjJLTlorMjJBcHhLdGVDekJVUTRWOEVzR082blp5enZlNFVYRFJZ?=
 =?utf-8?B?WGlDSE5veHNkb3lXekZFMGdKZjMxYUNxa0lLRDVNcFB4Ump2NDdTWmE0NWow?=
 =?utf-8?B?eG4yMUoyNDJGbE5VaXB3VHdvMUo3R0dTMittSjNCeGRiSjJVbHRKV3lCTi8y?=
 =?utf-8?B?NWJzUW51a3VpNWRKUTREcEVXK2VXdWxoMG9DSkNSc1c3TGVBV0srY3JKam55?=
 =?utf-8?B?VzBnQW41UDgxRHF4Rm1yd1RSMVB0TG5WR1dTMWFGUmlzMG9ieWQrU2krQXQ1?=
 =?utf-8?B?NlYyUXdmaFRhbmoyMGJxblRNTG9rcHlwMDNxN3lhVTdFbXVoQmYzYlFDb1l1?=
 =?utf-8?B?RGExc2ZYazJROW5qU1QwSVlNMVFkdit2R1lsdzF6YTdUWkEvWnlSaHVnY3Nx?=
 =?utf-8?B?dVpqRzRveTBjenJCT1JhekdOR284WURkNkNQQWljTFhGdEltdkg4N0hJT0Jq?=
 =?utf-8?B?eUU1VEtlSEFWWVNrQjNZM0d2L0JMYXJLekM0Nmhra091ZnFpemJrajEyRXNq?=
 =?utf-8?B?UVpwbXhRSFZKTjVmTzlhY1JwUnRJN3RBcG1PcnB2T0VvM0gwMDJ3SWpCemF1?=
 =?utf-8?B?Mno1b1dWbm16ejczMjN2eWY3UzhYOUdGMGp0b0ZEMGY4YndrV2pWQVRwcjlt?=
 =?utf-8?B?U1BsWEkxZWl2cXlxdlFwc2dYQVdtbUdLTVpXWTVkZlRpbVNCcUFCeTlNVldQ?=
 =?utf-8?B?OGNRbmw4QXEyZmpVaGJrY0FJVHhrYW80ZGI0anZxaWxBRG8zZkxWaWF3TWhy?=
 =?utf-8?B?K01odFF1NFBZaEw2N1I1OFllL1RkQWQ3N21mRmR1Y3hGMEx3L3dDT0V6Vnhy?=
 =?utf-8?B?eS92QkllYXlRVDF4UGxabGdSRDBYc24vUFRxVDFNSjM1VjFJaTY0bjNIT0xh?=
 =?utf-8?B?V2Z6VnRYNXpXREg5QTlwVm41aWVFU2EvUWhMUTNmMVRJNEFpNnNyY2ZqbVVN?=
 =?utf-8?B?UjIreDdONmlxMXBpUkhtUEFPNnAxbDZVU2MyamV0S2N1a2pFMFA3bFM3NG42?=
 =?utf-8?B?R3pNL2lNelhZVEJ1TEhINDVjVW1EcCtSb1hOckE4WlpHYUtZSk1pdzhnMXJS?=
 =?utf-8?B?NE9XVEQ1dUMrYjQ2R0k5aUFTSFl1eFVWSEZ6YTJ5Zk5xQnpOQmpSdzFyeVAx?=
 =?utf-8?B?VEtCdFdlZFZJdGlwbUttTmdJVGtLL0M4SDIwUjdUT2x3c0dJMXZNRmZpMHc1?=
 =?utf-8?B?N0MxOXYrNEEzZUJDWWdoQXlpakhCWU4zd0NCWXRVeWJ5akg2clVTSkJDOTkr?=
 =?utf-8?B?Tk5FbktqWDYydkhsTkF3VzIyUXYxWFZPVVBYbUtDMXZaZWp5R20wbGVLdTZR?=
 =?utf-8?B?QUM1eldtZ1IvZVRnYllxWXBvYk5Id2g0VlBOQml5K0huVmUzbXVDb1czZ2FC?=
 =?utf-8?B?dzRGQlQ2V0s5N3BzQUUrUjBaQ3U4Q2k2TEZOa0VQbXdrdkhxZFdnNElMVVc2?=
 =?utf-8?B?VzhLRFg4REszUWwxVjNkMTZzelNFV0oxd1A4NEw0SnNLRkpHTXppeTRKaWxq?=
 =?utf-8?Q?Rn7KgpQEaQWL6UY65WQl9I2tx?=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: IA3PR11MB9136.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 1aa9679d-eaa9-43a5-f067-08dda3dd6335
X-MS-Exchange-CrossTenant-originalarrivaltime: 05 Jun 2025 03:02:20.3706 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: f2+UepMCL0GLjmjAwoMyTTd2ggA0YCTFnCgyUCMIpOQ/BEjfWSOn+gb3vvM86fcwVe31dniNruf8barPh8Lm9EmYDFrJXruJ1rv8ZUlX+jo=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CYXPR11MB8664
X-OriginatorOrg: intel.com
Received-SPF: pass client-ip=198.175.65.10;
 envelope-from=zhenzhong.duan@intel.com; helo=mgamail.intel.com
X-Spam_score_int: -44
X-Spam_score: -4.5
X-Spam_bar: ----
X-Spam_report: (-4.5 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.128,
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

DQoNCj4tLS0tLU9yaWdpbmFsIE1lc3NhZ2UtLS0tLQ0KPkZyb206IFN0ZXZlbiBTaXN0YXJlIDxz
dGV2ZW4uc2lzdGFyZUBvcmFjbGUuY29tPg0KPlN1YmplY3Q6IFJlOiBbUEFUQ0ggVjQgMDQvNDNd
IHZmaW8vcGNpOiB2ZmlvX3BjaV9wdXRfZGV2aWNlIG9uIGZhaWx1cmUNCj4NCj5PbiA2LzMvMjAy
NSAxMTo1NSBQTSwgRHVhbiwgWmhlbnpob25nIHdyb3RlOg0KPj4+IC0tLS0tT3JpZ2luYWwgTWVz
c2FnZS0tLS0tDQo+Pj4gRnJvbTogU3RldmVuIFNpc3RhcmUgPHN0ZXZlbi5zaXN0YXJlQG9yYWNs
ZS5jb20+DQo+Pj4gU3ViamVjdDogUmU6IFtQQVRDSCBWNCAwNC80M10gdmZpby9wY2k6IHZmaW9f
cGNpX3B1dF9kZXZpY2Ugb24gZmFpbHVyZQ0KPj4+DQo+Pj4gT24gNi8zLzIwMjUgNjo0MCBBTSwg
RHVhbiwgWmhlbnpob25nIHdyb3RlOg0KPj4+Pj4gLS0tLS1PcmlnaW5hbCBNZXNzYWdlLS0tLS0N
Cj4+Pj4+IEZyb206IFN0ZXZlIFNpc3RhcmUgPHN0ZXZlbi5zaXN0YXJlQG9yYWNsZS5jb20+DQo+
Pj4+PiBTdWJqZWN0OiBbUEFUQ0ggVjQgMDQvNDNdIHZmaW8vcGNpOiB2ZmlvX3BjaV9wdXRfZGV2
aWNlIG9uIGZhaWx1cmUNCj4+Pj4+DQo+Pj4+PiBJZiB2ZmlvX3JlYWxpemUgZmFpbHMgYWZ0ZXIg
dmZpb19kZXZpY2VfYXR0YWNoLCBpdCBzaG91bGQgY2FsbA0KPj4+Pj4gdmZpb19kZXZpY2VfZGV0
YWNoIGR1cmluZyBlcnJvciByZWNvdmVyeS4gIElmIGl0IGZhaWxzIGFmdGVyDQo+Pj4+PiB2Zmlv
X2RldmljZV9nZXRfbmFtZSwgaXQgc2hvdWxkIGZyZWUgdmJhc2VkZXYtPm5hbWUuICBJZiBpdCBm
YWlscw0KPj4+Pj4gYWZ0ZXIgdmZpb19wY2lfY29uZmlnX3NldHVwLCBpdCBzaG91bGQgZnJlZSB2
ZGV2LT5tc2l4Lg0KPj4+Pj4NCj4+Pj4+IFRvIGZpeCBhbGwsIGNhbGwgdmZpb19wY2lfcHV0X2Rl
dmljZSgpLg0KPj4+Pj4NCj4+Pj4+IFNpZ25lZC1vZmYtYnk6IFN0ZXZlIFNpc3RhcmUgPHN0ZXZl
bi5zaXN0YXJlQG9yYWNsZS5jb20+DQo+Pj4+PiAtLS0NCj4+Pj4+IGh3L3ZmaW8vcGNpLmMgfCAx
ICsNCj4+Pj4+IDEgZmlsZSBjaGFuZ2VkLCAxIGluc2VydGlvbigrKQ0KPj4+Pj4NCj4+Pj4+IGRp
ZmYgLS1naXQgYS9ody92ZmlvL3BjaS5jIGIvaHcvdmZpby9wY2kuYw0KPj4+Pj4gaW5kZXggYTFi
ZmRmZS4uN2QzYjlmZiAxMDA2NDQNCj4+Pj4+IC0tLSBhL2h3L3ZmaW8vcGNpLmMNCj4+Pj4+ICsr
KyBiL2h3L3ZmaW8vcGNpLmMNCj4+Pj4+IEBAIC0zMjk2LDYgKzMyOTYsNyBAQCBvdXRfdGVhcmRv
d246DQo+Pj4+PiAgICAgICB2ZmlvX2JhcnNfZXhpdCh2ZGV2KTsNCj4+Pj4+IGVycm9yOg0KPj4+
Pj4gICAgICAgZXJyb3JfcHJlcGVuZChlcnJwLCBWRklPX01TR19QUkVGSVgsIHZiYXNlZGV2LT5u
YW1lKTsNCj4+Pj4+ICsgICAgdmZpb19wY2lfcHV0X2RldmljZSh2ZGV2KTsNCj4+Pj4NCj4+Pj4g
RG91YmxlIGZyZWUsIHZmaW9fcGNpX3B1dF9kZXZpY2UoKSBpcyBhbHNvIGNhbGxlZCBpbiB2Zmlv
X2luc3RhbmNlX2ZpbmFsaXplKCkuDQo+Pj4NCj4+PiBJZiB2ZmlvX3JlYWxpemUgZmFpbHMgd2l0
aCBhbiBlcnJvciwgdmZpb19pbnN0YW5jZV9maW5hbGl6ZSBpcyBub3QgY2FsbGVkLg0KPj4+IEkg
dGVzdGVkIHRoYXQuDQo+Pg0KPj4gSGF2ZSB5b3UgdHJpZWQgd2l0aCBob3QgcGx1Z2dlZCBkZXZp
Y2U/DQo+DQo+Tm90IGJlZm9yZSwgYnV0IEkganVzdCB0cmllZCBpdCBub3csIHRoYW5rcyBmb3Ig
dGhlIHN1Z2dlc3Rpb24uDQo+U2FtZSByZXN1bHQgLS0gdmZpb19pbnN0YW5jZV9maW5hbGl6ZSBp
cyBub3QgY2FsbGVkLg0KDQpUaGF0J3Mgc3RyYW5nZSwgSSB0cmllZCBiZWxvdyBjaGFuZ2Ugd2l0
aCBob3RwbHVnIGEgZGV2aWNlIHRocm91Z2ggcW1wLCBJIHNlZSAidmZpb19pbnN0YW5jZV9maW5h
bGl6ZSBjYWxsZWQiDQoNCmRldmljZV9hZGQgdmZpby1wY2ksaG9zdD0wNDoxMC4xLGlkPXZmaW8w
LGJ1cz1yb290MCxpb21tdWZkPWlvbW11ZmQwDQoNCi0tLSBhL2h3L3ZmaW8vcGNpLmMNCisrKyBi
L2h3L3ZmaW8vcGNpLmMNCkBAIC0zMTY3LDYgKzMxNjcsOSBAQCBzdGF0aWMgdm9pZCB2ZmlvX3Jl
YWxpemUoUENJRGV2aWNlICpwZGV2LCBFcnJvciAqKmVycnApDQoNCiAgICAgdHJhY2VfdmZpb19t
ZGV2KHZiYXNlZGV2LT5uYW1lLCB2YmFzZWRldi0+bWRldik7DQoNCitlcnJvcl9zZXRnKGVycnAs
ICJmYWtpbmcgZXJyb3IgaW4gdmZpb19yZWFsaXplIik7DQorZ290byBlcnJvcjsNCisNCiAgICAg
aWYgKHZiYXNlZGV2LT5yYW1fYmxvY2tfZGlzY2FyZF9hbGxvd2VkICYmICF2YmFzZWRldi0+bWRl
dikgew0KICAgICAgICAgZXJyb3Jfc2V0ZyhlcnJwLCAieC1iYWxsb29uLWFsbG93ZWQgb25seSBw
b3RlbnRpYWxseSBjb21wYXRpYmxlICINCiAgICAgICAgICAgICAgICAgICAgIndpdGggbWRldiBk
ZXZpY2VzIik7DQpAQCAtMzMwMSw2ICszMzA0LDggQEAgZXJyb3I6DQogc3RhdGljIHZvaWQgdmZp
b19pbnN0YW5jZV9maW5hbGl6ZShPYmplY3QgKm9iaikNCiB7DQogICAgIFZGSU9QQ0lEZXZpY2Ug
KnZkZXYgPSBWRklPX1BDSV9CQVNFKG9iaik7DQorcHJpbnRmKCJ2ZmlvX2luc3RhbmNlX2ZpbmFs
aXplIGNhbGxlZFxuIik7DQorZXhpdCgxKTsNCg0KICAgICB2ZmlvX2Rpc3BsYXlfZmluYWxpemUo
dmRldik7DQogICAgIHZmaW9fYmFyc19maW5hbGl6ZSh2ZGV2KTsNCg==

