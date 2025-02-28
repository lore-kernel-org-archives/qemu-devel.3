Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 15A93C19776
	for <qemu-devel@archiver.kernel.org>; Fri, 28 Feb 2025 08:24:46 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tnvfA-0001uQ-W0; Fri, 28 Feb 2025 03:24:05 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <zhenzhong.duan@intel.com>)
 id 1tnvf9-0001u7-5B
 for qemu-devel@nongnu.org; Fri, 28 Feb 2025 03:24:03 -0500
Received: from mgamail.intel.com ([192.198.163.15])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <zhenzhong.duan@intel.com>)
 id 1tnvf6-0001rt-Kd
 for qemu-devel@nongnu.org; Fri, 28 Feb 2025 03:24:02 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1740731040; x=1772267040;
 h=from:to:cc:subject:date:message-id:references:
 in-reply-to:content-transfer-encoding:mime-version;
 bh=37JbQJ0ZQXmWPSDDXgEy5wRKy6zS1FBsXbT/0UNlRM8=;
 b=Whed9ei1BvaHtIP5NG7syGk6dhgZig5+i5ypg4V0z+FMD5F2LHIaMDpq
 4ncEtgyZyGADrg8vkLefzyesKZP7p5oAQN8Rai5lzSfNYMxKBNIl9B+vJ
 gYwpXwCizOLH8OVeJLt3gsJPxlbZg9leuumRqu/sNdv0RgWolHw1BuqRM
 BF/V+bdEu0tdWcH+kuvmwcBZT9UrUB8I8r79XGOe97FLjyRFLUFh5MPRM
 ZFo2QkNeOsXZ7LWT7rJojG2VCZ8LcruPQX9SIo1otvO8CdSWFRkGVHyQX
 k9axKVrFWv7WD6F1TDQrBEgL0WWglCO2K8wWc4gaeC+53ghVvJaUOz1yZ g==;
X-CSE-ConnectionGUID: znoDC1yGSpGB4k1UeQk1EQ==
X-CSE-MsgGUID: VjXB7+/uTfOIBN2BzVRW5w==
X-IronPort-AV: E=McAfee;i="6700,10204,11358"; a="41775976"
X-IronPort-AV: E=Sophos;i="6.13,321,1732608000"; d="scan'208";a="41775976"
Received: from fmviesa004.fm.intel.com ([10.60.135.144])
 by fmvoesa109.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 28 Feb 2025 00:23:57 -0800
X-CSE-ConnectionGUID: 4tRW3IwLR+O5nLXzUMSA9Q==
X-CSE-MsgGUID: ML9Rc+q0Qza3x1X5ZYEThQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.13,321,1732608000"; d="scan'208";a="122404417"
Received: from orsmsx603.amr.corp.intel.com ([10.22.229.16])
 by fmviesa004.fm.intel.com with ESMTP/TLS/AES256-GCM-SHA384;
 28 Feb 2025 00:23:57 -0800
Received: from ORSMSX903.amr.corp.intel.com (10.22.229.25) by
 ORSMSX603.amr.corp.intel.com (10.22.229.16) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.44; Fri, 28 Feb 2025 00:23:56 -0800
Received: from orsedg603.ED.cps.intel.com (10.7.248.4) by
 ORSMSX903.amr.corp.intel.com (10.22.229.25) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.14 via Frontend Transport; Fri, 28 Feb 2025 00:23:56 -0800
Received: from NAM04-BN8-obe.outbound.protection.outlook.com (104.47.74.47) by
 edgegateway.intel.com (134.134.137.100) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.44; Fri, 28 Feb 2025 00:23:56 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=SGTJ8VmdZyHZR35e8BxhJZ5OS7kuoMxWtm0CS0HjJicv9n+cUKosJGI9plzRnzZzVC9vSrecKHAuhWJXdhA1dmH8upbSFZ2x/nLzxaORBskLG4WvbKkF58iPv8asAgNxtvpuZUnwGvYHscpqsrBgkLLvr9ZSEw1rdlkq8gUZ9m/7JJ4wNdx8m5z+E7vIBSL0w5RZuNXXAKVk7b3LEvO5Re3TQ89fl9pdJ4lfPngFjYRHsQQfaNuEGxEN83sTPzbWhw2boOBRIo5qbmzujYXprQazkaQ8XB/uwueA9PBDMKVzYnA8FQMkBByr0/V5KmVcElAAjjVqE1Wl9mV4OdLRiQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=37JbQJ0ZQXmWPSDDXgEy5wRKy6zS1FBsXbT/0UNlRM8=;
 b=kVQV8FKBdLTl4X9JcigYTpkfkMsaG0lMQRmCx5juD93QQyJPZ0Uv4+PJObbPXDhFXg4wKEKyfML89Ej2hOKMYJjD2Ev2bnl3PAlERr0R1P4KrH9PS58XX6KZmyjQnc+17GG+W311lhyjQQpCpzYxjm3KC93Xwbpy8maVBXi+S3zZLgrvz+LxtE/m3K9lSP9h8Pu+mvMaeCalwuzX67FYY8TTWMk9zlI0dTilN3SGq9gkOi8cgRva36BlLV+XU0a4m/T7yftWn6HTomgIABnuiA7y6HyODU3zRVKEY+gaFLHgfdDgAuUQWNa0drOIi8smurppxev/t5YQhearx4Gh8A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Received: from SJ0PR11MB6744.namprd11.prod.outlook.com (2603:10b6:a03:47d::10)
 by CY5PR11MB6368.namprd11.prod.outlook.com (2603:10b6:930:38::14)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8489.22; Fri, 28 Feb
 2025 08:23:53 +0000
Received: from SJ0PR11MB6744.namprd11.prod.outlook.com
 ([fe80::fe49:d628:48b1:6091]) by SJ0PR11MB6744.namprd11.prod.outlook.com
 ([fe80::fe49:d628:48b1:6091%6]) with mapi id 15.20.8489.021; Fri, 28 Feb 2025
 08:23:53 +0000
From: "Duan, Zhenzhong" <zhenzhong.duan@intel.com>
To: "eric.auger@redhat.com" <eric.auger@redhat.com>, "qemu-devel@nongnu.org"
 <qemu-devel@nongnu.org>
CC: "alex.williamson@redhat.com" <alex.williamson@redhat.com>,
 "clg@redhat.com" <clg@redhat.com>, "mst@redhat.com" <mst@redhat.com>,
 "jasowang@redhat.com" <jasowang@redhat.com>, "peterx@redhat.com"
 <peterx@redhat.com>, "jgg@nvidia.com" <jgg@nvidia.com>, "nicolinc@nvidia.com"
 <nicolinc@nvidia.com>, "shameerali.kolothum.thodi@huawei.com"
 <shameerali.kolothum.thodi@huawei.com>, "joao.m.martins@oracle.com"
 <joao.m.martins@oracle.com>, "clement.mathieu--drif@eviden.com"
 <clement.mathieu--drif@eviden.com>, "Tian, Kevin" <kevin.tian@intel.com>,
 "Liu, Yi L" <yi.l.liu@intel.com>, "Peng, Chao P" <chao.p.peng@intel.com>
Subject: RE: [PATCH rfcv2 04/20] vfio/iommufd: Implement
 HostIOMMUDeviceClass::realize_late() handler
Thread-Topic: [PATCH rfcv2 04/20] vfio/iommufd: Implement
 HostIOMMUDeviceClass::realize_late() handler
Thread-Index: AQHbgqgAsyuaEs4MgECoK9vUFq/BQLNQf2WAgApxtpA=
Date: Fri, 28 Feb 2025 08:23:53 +0000
Message-ID: <SJ0PR11MB6744CD36311EA605D95B81B992CC2@SJ0PR11MB6744.namprd11.prod.outlook.com>
References: <20250219082228.3303163-1-zhenzhong.duan@intel.com>
 <20250219082228.3303163-5-zhenzhong.duan@intel.com>
 <48df132c-b96a-475e-92de-55084a684794@redhat.com>
In-Reply-To: <48df132c-b96a-475e-92de-55084a684794@redhat.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: SJ0PR11MB6744:EE_|CY5PR11MB6368:EE_
x-ms-office365-filtering-correlation-id: b622d968-65e4-4695-d493-08dd57d13ce7
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
 ARA:13230040|1800799024|366016|7416014|376014|38070700018; 
x-microsoft-antispam-message-info: =?utf-8?B?bDcrSy9heXhOOVY1SWFZOWpYRjRVc1h0Ni9JbDBWN0d6dU1pbWY3ZWFKUWFG?=
 =?utf-8?B?NEhBNmxvU1BrcDZVSUdmck8rT1l6WGE0K2ZWeGJweHllUnc3Si81OWU4UHlz?=
 =?utf-8?B?aVNxZDdxdjZrVkgzbTF6NmJHZjJHNHJQaEcwS0NZRWpUWUhwbXYxZTgzOVVG?=
 =?utf-8?B?d0NqVm12MStXVE5IdWFDMG4zTFFiWHM2WDRDL0k4QTdDMXJRWUtJbC9QWVpM?=
 =?utf-8?B?TXNlS05TZzZYUTdLY1RZak9OdEJFa1JiZWRwVENMQWxQYStUQU5LcTBJSktw?=
 =?utf-8?B?eWJCZHgyYkRyYjNpR1ZKQlhiQ3FiVGFDZEw2cFNEelZ6U2RMdkVLRFh0cHQy?=
 =?utf-8?B?ZjJ5Wmo1NjdFZXpDV1RqN1Z2S3pnbFRHYktQQ1FtWU9qU0h5aUVsSkw2L3Nx?=
 =?utf-8?B?TDZ4Q3RzMWZYamEyanoxTmgzK3BieGRFMm40RmxWOHFBQjRYbjh2ZlR6QWR3?=
 =?utf-8?B?Q0grdmd6aGRWWkRONUtvbTBvNlRNN2NBa1JCSG9hT0JLQm9oTkdHMGVOc1pn?=
 =?utf-8?B?S24vWnpyZStvR2xTRWpKVzAwNVhFQjN6VVBxYk9PM1hvZHFxUWZQWlI2c2hB?=
 =?utf-8?B?dVR0bnpiM0xTdnhuNm0zaHBabjdDMXkwNlc0VjhRYXIzdFJLVEh5M290VlZE?=
 =?utf-8?B?eTlkQ0Mza2p2SFl5cnkvUTk0UTNoZzVlbzE2UkY4RHdRZEM5ejZzSk1oOEcx?=
 =?utf-8?B?aklJT3VBMlEyWk9teUI1WWN1bE9ReGtGVEVWRGVNVStnbmxXeXZGRS9VMHJw?=
 =?utf-8?B?NHRTdjdjVndLZ2tUeWp1NS9ibFpvZkkrYno4R3B0V0JvN2djd1M2MlhLd3Jr?=
 =?utf-8?B?VUpiaTMzblJVTm5BcEd2R3JyR1RlSHJIeUxnOEhvTjhUanZTNFduL3BJNmND?=
 =?utf-8?B?V1AzSVdvYjhJY1FUSkMrSWZPM2IxQklRVDFXdjIvRVkrai96emZHUDVacXpY?=
 =?utf-8?B?bXpjdDNaWGlQVXU0aUg0clNsOFcxTFkzaGI4Slc3UWIxUzJLZmVGMnUzOWFG?=
 =?utf-8?B?ZUlEODlydzkxVzJ0aVB5bnZUcHdMc2U3QmlubW9XL2FGTHN6RGpCNTdQQnhy?=
 =?utf-8?B?VE9rU0xqSmVBbWoydE9IeGVuNFU4NUFsQ3NPVzhnYzVpYzVYV09BUnk1V3VR?=
 =?utf-8?B?WndET2I4dHMrOE9NVDBHai9ncjQwa1poaytpV1RyV3BybGVscDd2ZitYRnRr?=
 =?utf-8?B?SnJCTU5iZnZ2NERPOS9LMzU0bUpCSFlKS2dOMkYxNUVmckFaRVhGQ01vSGN2?=
 =?utf-8?B?N2liZjczVmxaMGRrcXNhbWhmUG05a2NqbjRyLzgxWlBUYSs5WHlBUDBTRUR2?=
 =?utf-8?B?amhWUi9HNDdPd2w5enJUcWNyOHYvVUV6Tk5Jelhpb1FwS3hzMktTZEdmU2hX?=
 =?utf-8?B?eHpMRCtoRmtKcXBsOUM5NXlNTTNQR3VHd1Q3WGkzRVNSNURSVC93blFpclo1?=
 =?utf-8?B?aEhHY1JZSmF5N3N5Ym9mc0IzbFJEQS9Mc0NzbW1CbzVZT0RnZDY2ZVVzRXNU?=
 =?utf-8?B?VWFkT2E5R2dHem1uQzhkYmE1ZHJ2d1hOMkNVOWY4MGVEazVPakhzRUFpQy9Y?=
 =?utf-8?B?ZmpoTjJYTzQwRW5PREFndzNBbkJlVmVoeGV0MlpDMzNJcks0MVJOMFJIK0lm?=
 =?utf-8?B?NHpLSDN2aEY4d3ArVk16bmp1cjE5MUo2aWU3a0h4VGI1SG03cDgzOUNpSHNh?=
 =?utf-8?B?QWtHZFJxWGl1a0pQTDczak5DbXE3TG90Uk5QbUZOaDkzRTNqYWNDUGZzMEl4?=
 =?utf-8?B?elJFTzJ5TGdMK3VuRUFZS0QyWVROZ010NmpNK21UUlJ0MG9aVUNIOU94OHVN?=
 =?utf-8?B?WVRpSFRwd1BESjdPcWM4aDBLdzBUWmJFNCtjNTh4OTNQVVRCQmFLbGdZSG91?=
 =?utf-8?B?TzZMUnpTRUxoOW9tc2lUdE0wRUNPSlRhNDJiYkR6ZkxQRE52ZXVsZnVCTkVM?=
 =?utf-8?Q?bkPLsy5i3bM=3D?=
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:SJ0PR11MB6744.namprd11.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(1800799024)(366016)(7416014)(376014)(38070700018); DIR:OUT;
 SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?OEtpVFZ1S3Jydk5WRkE2VVprZEp6aHMvLzdZanp5Qk0yRWU4S0p4UFFyMGk1?=
 =?utf-8?B?cS9FaGUwOGlLRHF1emZBbGR5cWRLYzNxcE1UQUJGWUt4MzBNZTZHY3pEa0Fs?=
 =?utf-8?B?OVRzYVIwVVk5UzZBUlhFcnFnRTdFUTg4V2lMMlUzWnU5UWZpNjlobWFUUVpY?=
 =?utf-8?B?YW5KMGdmNU9OaFUwZFBVVm4zOFgwN1Nic0ZBb0hjOXd2MTd4MTJzVzFrTnF1?=
 =?utf-8?B?RzMwQUNPTFhwNEx6NG5nZFBScmJjMDRqWlgrVmp2YjE5bUcwSURnOWRNa1Fm?=
 =?utf-8?B?WVozM2JKaUVnWDZSMU5lSStrWUs0Qjl5T2FjRDhMY05KcFRFdW82ZjJzaFFI?=
 =?utf-8?B?ZmVzY3IrdnEyRzdKUk4xbWoxTmlNYVBQZkNIUUVGUER2eEcwZ3F1a1lvMUN6?=
 =?utf-8?B?bXhuUU5oMmNlS1pqVVJQaERiS1ZRTU85cE1MYk0xMWV6Rzd0RG82UkZ6SFpk?=
 =?utf-8?B?Uk9kN201ZllKSVpzankxTGxGSnVNeGIxb0Y1U2JnS1VPNVN5T0xnZHRsTHBU?=
 =?utf-8?B?dHdqdSt1OHgzdGNOYTRjZ3ZwUVo5TVAzNnhIcml2dE04cUVPL1BNVmhKanJw?=
 =?utf-8?B?K1M1b1pWS3Q1Wk9VZkQ3WHNTUkVQRTMrVUs3cGdzelVLSm42dUFlKzBOeHBk?=
 =?utf-8?B?YTdiK3RJNy9hU2llaWV2b1k1NkRtZDFFbHNEdUVwaVR5ZGJqL3FDcVI0dHNj?=
 =?utf-8?B?OHpWVVBiRFhCam13eHdSRDFYci8rWWdZWnZqU2YvdGhmT1ZNV0RML2xOYmZ4?=
 =?utf-8?B?Y2VBbjQwOENJZyswTDlmMWRzV2Y5RWtYKzlCK3Jud3F6dk5wdzd2Y0Zzc0Nz?=
 =?utf-8?B?Z3d5RWxaYkUvTHh3L2ZUakhuSGtkL0FCakhxQmpIL09LcXNuaDdFRHhHcEFG?=
 =?utf-8?B?ekVPWWVoOUxFenB0SHBWVmhqTVdiZ3I5aW9xbnV0V25GcnJQcHdMVlA0VXN5?=
 =?utf-8?B?YjhpUDJLOW4rUVBFOHo0bk1yWWxEcG16ZHFEcDd0WUVKNm9nbGIxZ1JHOXBL?=
 =?utf-8?B?TlA3S0NENVhGa3pGSWFpM0tubWdPazBjSGJPcW5JMnRJZ0ZjM1FKbjErQWFH?=
 =?utf-8?B?TW8wc0xRc0tpV0JqUWNsbkJ5MnYvMkIyOGhheFFOdzZkWERjVHpwanYwUjlo?=
 =?utf-8?B?amVNSlRtQ2RmYTkzb0JQT3pFMFM5dU5la21MTUlEZGxlcmtkWDRzZkxzcUdW?=
 =?utf-8?B?YXpPak4vVTBpN1ZLckJtOVBTQUQvYm9kZkNiRVROQ2FxeE9XS1VaNkZhcldC?=
 =?utf-8?B?MVM0V1l1SnhpaU9FUC92RkFmUldFWHhuM01BaEd1ZG9HdWVtaTZNN3JacHZ0?=
 =?utf-8?B?UUNJQ0xDb1NRaDF6aUkyTHJBaU83OVVFYzI4TUpKd1Y5akU3MmRlNW5mcFZD?=
 =?utf-8?B?L2dFMjVrUDZXZ21kemhrLzBlUDVkZDB3TFZuSHUwdGdrc1NtanpBTWxCeW45?=
 =?utf-8?B?cEk1N2JHT3hjcGdqY2VQc2VPSkJtb2tuZDdKVzlwWk5JTmRXcHhKUGtiaURN?=
 =?utf-8?B?eVU5OXZnalVxVmp2bjZ0UnhwemYzT0RPbXZvdVdyZjZvcHVLS3JaL1lId08y?=
 =?utf-8?B?Y3RXazF3N1NMZHRsTzRBamtmK2k0dDVFdENNbWVjMWhtWjBWNUEzcWJQMUFh?=
 =?utf-8?B?bUVibVlzMG1pYW84RE1rME9COVZoOVdKYnA0V1ZFZzFoZkhQak9ZcVFjSDhZ?=
 =?utf-8?B?Yk9xUHJyWHFpUE9PcVNvK3kvdGtjWnYxdjF4elhMR0RKaW04ckpQRlBZVXAz?=
 =?utf-8?B?TnlldDh5K0VqakRodyt5SVFMNnhrdkZUN0VVK2ROUlhFU1BiMkpoK3h2MW5Q?=
 =?utf-8?B?YzdOaWhndFhjcllaQXRqRmdxYjVGR0wzNUNENVQvNWkzREhVZzJuYnhwUFhW?=
 =?utf-8?B?Y2IydUdWa0lVOGZMTlUwQ25rdjh6WmRwUnlyRklsYVZIYi9vMklmMm5qd0dD?=
 =?utf-8?B?ekJvWU04cXdZMDNmWXhSYmY1eXJ2d2pmcmNZZG1KVGRpaGZnRW5wWkc0Wis2?=
 =?utf-8?B?ck5wWDYvdU5pRFM3OGR3RVUweUxRU2RJNTFrWnJKckhmZ2NucENab0xyUmxy?=
 =?utf-8?B?cWRwMVNnOVJtMHNjZWxGdGN2MlcxSkxuRkQ1emM0Nk5lNHoycnJSdU1MQ0Z6?=
 =?utf-8?Q?j/rxRWyEcWbpwmtojaTRqBm2k?=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: SJ0PR11MB6744.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: b622d968-65e4-4695-d493-08dd57d13ce7
X-MS-Exchange-CrossTenant-originalarrivaltime: 28 Feb 2025 08:23:53.7362 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 6DMpwehzX6byYDxzL/xUrXLx72f2FFvNZDmr5rhkaHjQvpDuiZgxFta8ntZ7OHrWK+UkrqSCk3mP2lOwF8LYKSaC6o5kcv4STYcTMv/3U78=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY5PR11MB6368
X-OriginatorOrg: intel.com
Received-SPF: pass client-ip=192.198.163.15;
 envelope-from=zhenzhong.duan@intel.com; helo=mgamail.intel.com
X-Spam_score_int: -47
X-Spam_score: -4.8
X-Spam_bar: ----
X-Spam_report: (-4.8 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.438,
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

DQoNCj4tLS0tLU9yaWdpbmFsIE1lc3NhZ2UtLS0tLQ0KPkZyb206IEVyaWMgQXVnZXIgPGVyaWMu
YXVnZXJAcmVkaGF0LmNvbT4NCj5TdWJqZWN0OiBSZTogW1BBVENIIHJmY3YyIDA0LzIwXSB2Zmlv
L2lvbW11ZmQ6IEltcGxlbWVudA0KPkhvc3RJT01NVURldmljZUNsYXNzOjpyZWFsaXplX2xhdGUo
KSBoYW5kbGVyDQo+DQo+DQo+DQo+DQo+T24gMi8xOS8yNSA5OjIyIEFNLCBaaGVuemhvbmcgRHVh
biB3cm90ZToNCj4+IFRoZXJlIGFyZSB0aHJlZSBpb21tdWZkIHJlbGF0ZWQgZWxlbWVudHMgaW9t
bXVmZCBoYW5kbGUsIGRldmlkIGFuZA0KPg0KPlRoZXJlIGFyZSB0aHJlZSBpb21tdWZkIHNwZWNp
ZmljIG1lbWJlcnMgaW4gSG9zdElPTU1VRGV2aWNlDQo+SU9NTVVGRCB0aGF0IG5lZWQgdG8gYmUg
aW5pdGlhbGl6ZWQgYWZ0ZXIgYXR0YWNoIG9uIHJlYWxpemVfbGF0ZSgpIC4uLg0KDQpXaWxsIGRv
Lg0KDQpUaGFua3MNClpoZW56aG9uZw0KDQo+DQo+PiBod3B0X2lkLiBod3B0X2lkIGlzIHJlYWR5
IG9ubHkgYWZ0ZXIgVkZJTyBkZXZpY2UgYXR0YWNobWVudC4gRGV2aWNlDQo+PiBpZCBhbmQgaW9t
bXVmZCBoYW5kbGUgYXJlIHJlYWR5IGJlZm9yZSBhdHRhY2htZW50LCBidXQgdGhleSBhcmUgYWxs
DQo+PiBpb21tdWZkIHJlbGF0ZWQgc3R1ZmYsIGluaXRpYWxpemUgdGhlbSB0b2dldGhlciB3aXRo
IGh3cHRfaWQuDQo+Pg0KPj4gU2lnbmVkLW9mZi1ieTogWmhlbnpob25nIER1YW4gPHpoZW56aG9u
Zy5kdWFuQGludGVsLmNvbT4NCj4+IC0tLQ0KPj4gIGh3L3ZmaW8vaW9tbXVmZC5jIHwgMTQgKysr
KysrKysrKysrKysNCj4+ICAxIGZpbGUgY2hhbmdlZCwgMTQgaW5zZXJ0aW9ucygrKQ0KPj4NCj4+
IGRpZmYgLS1naXQgYS9ody92ZmlvL2lvbW11ZmQuYyBiL2h3L3ZmaW8vaW9tbXVmZC5jDQo+PiBp
bmRleCBkZjYxZWRmZmMwLi41MzYzOWJmODhiIDEwMDY0NA0KPj4gLS0tIGEvaHcvdmZpby9pb21t
dWZkLmMNCj4+ICsrKyBiL2h3L3ZmaW8vaW9tbXVmZC5jDQo+PiBAQCAtODI4LDYgKzgyOCwxOSBA
QCBzdGF0aWMgYm9vbA0KPmhpb2RfaW9tbXVmZF92ZmlvX3JlYWxpemUoSG9zdElPTU1VRGV2aWNl
ICpoaW9kLCB2b2lkICpvcGFxdWUsDQo+PiAgICAgIHJldHVybiB0cnVlOw0KPj4gIH0NCj4+DQo+
PiArc3RhdGljIGJvb2wgaGlvZF9pb21tdWZkX3ZmaW9fcmVhbGl6ZV9sYXRlKEhvc3RJT01NVURl
dmljZSAqaGlvZCwgdm9pZA0KPipvcGFxdWUsDQo+PiArICAgICAgICAgICAgICAgICAgICAgICAg
ICAgICAgICAgICAgICAgICAgIEVycm9yICoqZXJycCkNCj4+ICt7DQo+PiArICAgIFZGSU9EZXZp
Y2UgKnZkZXYgPSBvcGFxdWU7DQo+PiArICAgIEhvc3RJT01NVURldmljZUlPTU1VRkQgKmlkZXYg
PQ0KPkhPU1RfSU9NTVVfREVWSUNFX0lPTU1VRkQoaGlvZCk7DQo+PiArDQo+PiArICAgIGlkZXYt
PmlvbW11ZmQgPSB2ZGV2LT5pb21tdWZkOw0KPj4gKyAgICBpZGV2LT5kZXZpZCA9IHZkZXYtPmRl
dmlkOw0KPj4gKyAgICBpZGV2LT5od3B0X2lkID0gdmRldi0+aHdwdC0+aHdwdF9pZDsNCj4+ICsN
Cj4+ICsgICAgcmV0dXJuIHRydWU7DQo+PiArfQ0KPj4gKw0KPj4gIHN0YXRpYyBHTGlzdCAqDQo+
PiAgaGlvZF9pb21tdWZkX3ZmaW9fZ2V0X2lvdmFfcmFuZ2VzKEhvc3RJT01NVURldmljZSAqaGlv
ZCkNCj4+ICB7DQo+PiBAQCAtODUyLDYgKzg2NSw3IEBAIHN0YXRpYyB2b2lkIGhpb2RfaW9tbXVm
ZF92ZmlvX2NsYXNzX2luaXQoT2JqZWN0Q2xhc3MNCj4qb2MsIHZvaWQgKmRhdGEpDQo+PiAgICAg
IEhvc3RJT01NVURldmljZUNsYXNzICpoaW9kYyA9IEhPU1RfSU9NTVVfREVWSUNFX0NMQVNTKG9j
KTsNCj4+DQo+PiAgICAgIGhpb2RjLT5yZWFsaXplID0gaGlvZF9pb21tdWZkX3ZmaW9fcmVhbGl6
ZTsNCj4+ICsgICAgaGlvZGMtPnJlYWxpemVfbGF0ZSA9IGhpb2RfaW9tbXVmZF92ZmlvX3JlYWxp
emVfbGF0ZTsNCj4+ICAgICAgaGlvZGMtPmdldF9pb3ZhX3JhbmdlcyA9IGhpb2RfaW9tbXVmZF92
ZmlvX2dldF9pb3ZhX3JhbmdlczsNCj4+ICAgICAgaGlvZGMtPmdldF9wYWdlX3NpemVfbWFzayA9
IGhpb2RfaW9tbXVmZF92ZmlvX2dldF9wYWdlX3NpemVfbWFzazsNCj4+ICB9Ow0KDQo=

