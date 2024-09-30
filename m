Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 39292CF649D
	for <qemu-devel@archiver.kernel.org>; Mon, 30 Sep 2024 09:54:07 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1svD5y-0006Qz-Mt; Mon, 30 Sep 2024 05:53:35 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <zhenzhong.duan@intel.com>)
 id 1svD5v-0006QB-Si
 for qemu-devel@nongnu.org; Mon, 30 Sep 2024 05:53:31 -0400
Received: from mgamail.intel.com ([192.198.163.9])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <zhenzhong.duan@intel.com>)
 id 1svD5q-0001Op-Px
 for qemu-devel@nongnu.org; Mon, 30 Sep 2024 05:53:30 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1727690006; x=1759226006;
 h=from:to:cc:subject:date:message-id:references:
 in-reply-to:content-transfer-encoding:mime-version;
 bh=vsHtDISqsaYj6vtFNmykQ3U0YQUl1kng9TP4kSRx1nY=;
 b=iFN+G8L4ASG4WdKwVHw4DkOLIgtceOwcNmBypHemYeAHG+kJkS11wkdd
 zrE0S0GEiv6jm4S3MkZYnOUz/rWJwg3LokSaPA7XA3Tqce5Fldwlj9GwC
 FSgU8vzcavOpIcy1LzdSLsnU4Cr5uHx6wQtiVsz+lGgkAO3GbkrRhU1mN
 aOg0UNQLO1hOxDuLErxAaO5q9sGE2WqVgDXTgYdJboL0DHHZWCw3LMzUO
 1IQd1kdXi9EsoZbMRahXbanrF/IVuVMPq7Vm2feBxanq3tn/kkR6sWa1/
 byX1DbdFXSg1Rt3Vz+36hYeyFcPpNLalTMbhvZ4ke9kuYIszKHEACtJEe g==;
X-CSE-ConnectionGUID: a0QUupWhSRepyhXgvoaivQ==
X-CSE-MsgGUID: QwzsuskxSoyl9XNCLdtI0A==
X-IronPort-AV: E=McAfee;i="6700,10204,11210"; a="37443607"
X-IronPort-AV: E=Sophos;i="6.11,165,1725346800"; d="scan'208";a="37443607"
Received: from fmviesa007.fm.intel.com ([10.60.135.147])
 by fmvoesa103.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 30 Sep 2024 02:53:24 -0700
X-CSE-ConnectionGUID: spA/G7jLQHq1LOalKmp3Lw==
X-CSE-MsgGUID: ZvtZf4cgRTi79qffwODwtw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.11,165,1725346800"; d="scan'208";a="72915865"
Received: from orsmsx601.amr.corp.intel.com ([10.22.229.14])
 by fmviesa007.fm.intel.com with ESMTP/TLS/AES256-GCM-SHA384;
 30 Sep 2024 02:53:23 -0700
Received: from orsmsx610.amr.corp.intel.com (10.22.229.23) by
 ORSMSX601.amr.corp.intel.com (10.22.229.14) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.39; Mon, 30 Sep 2024 02:53:23 -0700
Received: from orsmsx610.amr.corp.intel.com (10.22.229.23) by
 ORSMSX610.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.39; Mon, 30 Sep 2024 02:53:23 -0700
Received: from orsedg603.ED.cps.intel.com (10.7.248.4) by
 orsmsx610.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.39 via Frontend Transport; Mon, 30 Sep 2024 02:53:23 -0700
Received: from NAM10-MW2-obe.outbound.protection.outlook.com (104.47.55.41) by
 edgegateway.intel.com (134.134.137.100) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.39; Mon, 30 Sep 2024 02:53:10 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=MR5BeaXEro1IhRd+9vlyW6y5uaw4DW8jv+6USKS1iixFL+Uvxv9QMpfJCbDhe5Z/qY7fNPOpO4YF1Od1D2cymyPZwKhdh5Dbp7W2pcFXx9rN7kx6JAU3qByDLEoZi+Kx6JCFkf96kg+ueEY/HDgSDe9H0P+ipLREjsFiPyCKHA1TBdJISz7P1GquW3PiUAfIrM4DlSMfW0+JGTGyUkCuOlUDbGAtIy5iLC8ZNrAopWSjX/H4GlY/ZCtZHHjh56AMqASHe84k4vmDFz+9XNQQLNfWONJlxOfJoEWzsUwsoD3DkrUbBfDFhAqIJm4eDwAh7vovCcbVSqlWv7xRRCh+OA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=vsHtDISqsaYj6vtFNmykQ3U0YQUl1kng9TP4kSRx1nY=;
 b=yvTwCHTD8h+AUYeo0koeaW5ivKG0JbCg2BITZzBbRgwp/HU4eY8cl9uYHQgEyeT4oeGpWx69sWcxSLFHXs5x+iiWSj3oEOV/CjRAx6AMFyeVBbpo47b6gXKFO32UrMcp3q7p7yPhvEtdKkmhiPUlOSdnntz5trbAO3wjdT9mO1jdAd1cCrYj9OKVFgCwcRn8xevyHugIOQRE5HZlJdupQufvvBjmJtE5d7zzP81CVE0NVNCPLBQODIsFZKmbKQrc9a3NXF+8WEN3hEMRDMPNRJJalxjESXZw+TjMgh5frmtQlXLJoxGiZ+lD4WkJlHN0/2WpYiWl70aiXM/CqvJLeA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Received: from SJ0PR11MB6744.namprd11.prod.outlook.com (2603:10b6:a03:47d::10)
 by PH8PR11MB8014.namprd11.prod.outlook.com (2603:10b6:510:23a::15)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8005.26; Mon, 30 Sep
 2024 09:52:43 +0000
Received: from SJ0PR11MB6744.namprd11.prod.outlook.com
 ([fe80::fe49:d628:48b1:6091]) by SJ0PR11MB6744.namprd11.prod.outlook.com
 ([fe80::fe49:d628:48b1:6091%4]) with mapi id 15.20.8005.024; Mon, 30 Sep 2024
 09:52:43 +0000
From: "Duan, Zhenzhong" <zhenzhong.duan@intel.com>
To: "qemu-devel@nongnu.org" <qemu-devel@nongnu.org>
CC: "alex.williamson@redhat.com" <alex.williamson@redhat.com>,
 "clg@redhat.com" <clg@redhat.com>, "eric.auger@redhat.com"
 <eric.auger@redhat.com>, "mst@redhat.com" <mst@redhat.com>,
 "peterx@redhat.com" <peterx@redhat.com>, "jasowang@redhat.com"
 <jasowang@redhat.com>, "jgg@nvidia.com" <jgg@nvidia.com>,
 "nicolinc@nvidia.com" <nicolinc@nvidia.com>, "joao.m.martins@oracle.com"
 <joao.m.martins@oracle.com>, "clement.mathieu--drif@eviden.com"
 <clement.mathieu--drif@eviden.com>, "Tian, Kevin" <kevin.tian@intel.com>,
 "Liu, Yi L" <yi.l.liu@intel.com>, "Peng, Chao P" <chao.p.peng@intel.com>,
 Thomas Huth <thuth@redhat.com>, Marcel Apfelbaum
 <marcel.apfelbaum@gmail.com>, Laurent Vivier <lvivier@redhat.com>, "Paolo
 Bonzini" <pbonzini@redhat.com>
Subject: RE: [PATCH v4 17/17] tests/qtest: Add intel-iommu test
Thread-Topic: [PATCH v4 17/17] tests/qtest: Add intel-iommu test
Thread-Index: AQHbExuH9pKx2wVrkUOIJ/h6FlaWFLJwFg6A
Date: Mon, 30 Sep 2024 09:52:42 +0000
Message-ID: <SJ0PR11MB674463B923080B829C43710892762@SJ0PR11MB6744.namprd11.prod.outlook.com>
References: <20240930092631.2997543-1-zhenzhong.duan@intel.com>
 <20240930092631.2997543-18-zhenzhong.duan@intel.com>
In-Reply-To: <20240930092631.2997543-18-zhenzhong.duan@intel.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: SJ0PR11MB6744:EE_|PH8PR11MB8014:EE_
x-ms-office365-filtering-correlation-id: 4a01fe0e-242f-43f0-d78d-08dce135a0ff
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
 ARA:13230040|1800799024|366016|376014|7416014|38070700018; 
x-microsoft-antispam-message-info: =?utf-8?B?Wk96em9ybkRDMGhWNzRnSGhJUEhsMG1Uc1lIRHgrbVhRWFlaTi9wakdVVE9m?=
 =?utf-8?B?bk45Z2hjYjIyRmE3MFhoNWVaOThVenhQdC9sU3ExbUplNEFaUFYrVU00eEZD?=
 =?utf-8?B?SFJzUWZpR21PQThaWXZVZGw3bTNTaVZVRTdTV1N2am12bDBiM2I3NSt3S3FB?=
 =?utf-8?B?Q3FXWFpzRlRMSmJ4dmkyZTA4WEVldkdLRnRpMEsvdXRrUHJsSVJBWTQvVk0v?=
 =?utf-8?B?dkFIQjZzK1BqOS8vTkJLV1lCdnJNZVlod09rWkp2UDI4V1ZvLzRBT002WGdj?=
 =?utf-8?B?Z3ZuaGxQZEZabFlxaE9IMWVWOEw0YU1mWk5IMTltVU1lbTEvczhDU0l0Mzd5?=
 =?utf-8?B?R05uREZFNU45TGUwb3ZUTHJHMTI5dncvckZQL1JyR2lvRDJGSnUwOVZjTHdF?=
 =?utf-8?B?Vll1T0dmWEJSaVJxWFZGbVhQdEg2cGFpQ3ZSemVsRTdycUgyTnQ2NDBwUDdq?=
 =?utf-8?B?WnlqMHJiLzhoVy9vSXltUmI4b05wcC9Gd1lpblI2MGE3emwvb3NlY2dWNXVT?=
 =?utf-8?B?dWE4UExQSUNwYkhZbjEyR21Hd1lhaWsvRy9ZVnJjZnlReURJb21FMktuckV4?=
 =?utf-8?B?MkU5aWRid2UyTTN0bU9LbysrV3Q0R1FTMDRtU01tNTJxQ3NIclpqRXRTcWl6?=
 =?utf-8?B?QzVWRXd2M1NTNGhidSs3VG1Odm1GUDMxUUhmb1RqUTBIZlo3cmw3aHZDa3Bx?=
 =?utf-8?B?SEhCTDFBYUNKTzVXS1VLYWowVWJqWDFmMlFNdTNrRUxONjI5TFNidU9iMXI3?=
 =?utf-8?B?eDVJV0pmb2MrbkoydWNvTzc2TVNNb2hKV3V3Q0VFUGRNUjlvMEg0VVVWVGZs?=
 =?utf-8?B?QjZjVzFPbkU0TGNhOHlkemlsaW5mSy8zdFpqME5WS3B3R2FVZGl4a3VFZ04w?=
 =?utf-8?B?NEFvZnNqcktoUTBVY3F1RnpRZzJaTW40d0gwT2RhWWR0dDg4Q1ZDbHFwbksy?=
 =?utf-8?B?aXlaNzlYWkVBMk44R0RaOEtqL3RxWWJnYzVkVWh5ZFBBQkpUdTZ5aEsvWkNL?=
 =?utf-8?B?bU16Q3BiZGlXWE9VQ2pzS2h6MXlYRGdGMU9YbzFpdWRPNjBTTE5tcWRyMlA1?=
 =?utf-8?B?R05MVnVvbHJ3cXl6ZWJTKzJ3MmdNU2Z3ZEd2dzZDcGZxNlJWWmVaQWxZcVc2?=
 =?utf-8?B?TWdab0U4bmEwY2xtZ2JQYkNodVlwUkJtM2tHNkxUNW84ckp1MnFpNHJaN3ZU?=
 =?utf-8?B?YzAwUVpob0NraEt3aUtwODZxWWQ1SHUwNmNHdVRiYk8vWVdOMVhicS9zRHQ5?=
 =?utf-8?B?Q2lnZFI0bDBSNHlvZW9nR3g0ZWdCYjFQelZuWnFFbDU3V0I0K3ZJWEpQL1E4?=
 =?utf-8?B?VXNxMU5TN3lCa3ZEOGF6VnBJQTNiVjBWNnc3NlVWbzJESnhRSWsxMVAzSUVK?=
 =?utf-8?B?R3VUb2tkV0J1V3hld21Gam12enM1dTlsaHpScStkKzZ2a0YzOHhCakUvK3Fy?=
 =?utf-8?B?ZjFIMk9qd3ppZkt0eFRXQkhwQUxkQ3RKWkwzV2taWVNoMDVnMXJuQU8xQ2Fx?=
 =?utf-8?B?TTRGdXlRYnZYUzJieCtQbFRXTGdvcWJkTjFPbjVPU014NHNHQVkwRUF1aitB?=
 =?utf-8?B?Qk9PaTh1NXY3djBPT2FvemFUYjByK2lGcTdKRVczNFJBcCtad2lQRTFTaHR6?=
 =?utf-8?B?RDNMMEExL1Z5dmxLTmxHU091VFJvLzdvZ3lwZUQrdXowN0hIWk04WncxWkV0?=
 =?utf-8?B?RmFDQldnSk5WSUhBR2tsYjVCcnZqUC9abHp6ak5hUE1pYzJtVnZYMGdGQ0M4?=
 =?utf-8?B?dHBaZUs4REt3S0IvU3Bld1Qrc1o4UXk0S1MxWldWSjhMamw2VnBtZk9rb0hJ?=
 =?utf-8?B?YUdlVVErYlYwTVJMZWlJZE1iZFpzOEVKbjdHQjhEU1MyUVZiRklQOThOUzVK?=
 =?utf-8?B?UWRLeGZmRXFkYXZ5M0dGU2NiRi9GYmN4d3RwQVhMaVhCOHc9PQ==?=
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:SJ0PR11MB6744.namprd11.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(1800799024)(366016)(376014)(7416014)(38070700018); DIR:OUT;
 SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?UWhQR1FWeXRydGRBTXNSMGQ4b0VyKzJJckUzdHhsRlVWNkdMYUhsUWR2YVZU?=
 =?utf-8?B?VSt1eFl1OHRkNWpTTUo0RDNMcksvQ3ByUytEcmFkN3pzcDk5cnVkVU5oejRN?=
 =?utf-8?B?cmlpSG9RM2c1c2VSZ1diQnd6L2JwelAzS3djamc2TUluQjRPZkJTMExrTXZv?=
 =?utf-8?B?dHZmSENMVHVWVUx5dUE3WW9YcVh0dmZzL3dtM0FIMEFLSnVOZU1RQVdmeXZr?=
 =?utf-8?B?R2dTb3dqVGZkVnQ1dHBZa2N1NW91Y2VwNDd5MERtNGFqaU5yMExGQjNQZEZU?=
 =?utf-8?B?Z2VhNXdQaE1nTmk5OWgyblJCalVHaVJlUHVVN0FzcnUrTXQvUWJra3orMWVB?=
 =?utf-8?B?TE5XUjRvR2xwTFk5VTMwUVNyTHhla1JUQ2x2YWJQYkdOcjNNa2VLUEE4d0dv?=
 =?utf-8?B?dEc1ZDhaS01JL2lzVGxvVG9KNFo1aURjRGlsR2pPcjlGNXdDWk9BdGs4aWlu?=
 =?utf-8?B?UlJmWEh6Zy94Vk1NOXpzT2Eyekl0VVI3Ulh3V2o1OGJzZjhhM0EyQ3M3NzZ4?=
 =?utf-8?B?Z243NmpnaTNXazBXR0prbDA4MWJjTVdmNnVoYVF3a1ZTQ3pjMk9hK01UK1JG?=
 =?utf-8?B?ME1BTU51T20rK2IrYW5KMXczWmlCT3d0VGNuQnpiQTRJTHVzc1ZKRU1tcFZD?=
 =?utf-8?B?bEFrdWxwdVdDOGJNVXhQWUx3K2V5Tmp0MVo3cHNnSTV1TTdLOE9NOFl3R2Fr?=
 =?utf-8?B?Sy9jcFhhZVBwc1ZFOTE2VEwvUHlsZlBkNFBjRWVzbUZzeG85c1NWN1JnZUhu?=
 =?utf-8?B?U0NqSGdERlV1SS9HeEExTUtCUlU1MW1Qdmxsb0tuWUtPbXVYMmZDNjBhYWdx?=
 =?utf-8?B?YkNwQVZXUEVkZmRwMHJCQmxsU3VGeEdydnE3QnNxQ1BackFsRE4yR2FRaUJP?=
 =?utf-8?B?dlhDeU5aRGl6NnZBbCtzOFAzWkRZMkIwZU5ReXB6ay91YUN6LzVqVnQ0Rzd4?=
 =?utf-8?B?eldtL2xMYStnekZpclB6TjY2bFNEQWFPaVVuU3Q5U1RDSEdhQ1NWd2NyR2hr?=
 =?utf-8?B?bVZTcnVmQjU4emViTUVKQnRJWVdsem5iYnJlUWlVRkw4aC8wamZzTjFIaW52?=
 =?utf-8?B?eVFya0xkVHZtM3FrQ2QrdnRnczRjdHRUZ3pUYnF2dk1ZckxGWjk3MVdSN0gw?=
 =?utf-8?B?SXRYekVVTktCUzdiUVhoVGc4U0dMWnV3bUN6OEtsak5DSE5uQTNBQVVhaEFs?=
 =?utf-8?B?NVJRS085WWd4S294bEMxbjFadHQrYkIzTCtVRm9ETEI4blJBT2hjYzZOU2pT?=
 =?utf-8?B?VnhwK25EVmpSQ2FMYUloWFVqS0EyVzZ3cDAvRHoyTTBVVkIxVTBibGFlcGg2?=
 =?utf-8?B?eXZ6bElhalJWY1c4ZmlONjI5TG9hd0dxaFB3MjVEMlZPaGtoSkJ5YzR5N3lD?=
 =?utf-8?B?bmM2a1A4OCt6Z0d2dG1YVHp4Sm5uMTh4c0Yvd3RJaUF1Y1hyaVhLZU1GeHFy?=
 =?utf-8?B?akZaS2JnRzZJejZhRGNSU3BuV0E5eExIcjIzYWlmd0t1SWh6ZDBmSFFrcDJ5?=
 =?utf-8?B?ckJ1ZW94a3VRRVNKOTh4VDdYYmFrQm9EVHB0N3BHbVJHMU9VVldocm1YNVBN?=
 =?utf-8?B?aFc1b3lhQmgwaHFQRHhWWnAwakZSbUlmb1pTYzM2ZGR2bjhYbER0aXoxRWcr?=
 =?utf-8?B?QTJGRkZpU0wzeUxqdEFYaHhQL3ExS3hCVmY3MlQzVDRvdHhJNFZDTnZlS3VC?=
 =?utf-8?B?TCsyMXBHWTVMVG1LKysxaWtSdDkxNlNXNVZCMUczQjRsMUF1SFpidzdRUVor?=
 =?utf-8?B?VVF6KytUa0JZZ0ZETTNZMUdQeTdzbm1tMGExUVA1S0NtUDZSM0dsVXM0Z0s3?=
 =?utf-8?B?ekUzSnV2cVJ2T09Ob1QxdjRCYTIvYTdDWTl2bWFabUl0RzZxdnR4cDVPaUpO?=
 =?utf-8?B?NE55d3pnd0o1eTJ1WEd5bXNTc1ByR1RBZWk4UXFobXJnOG1Wa0NKL0RhcVJH?=
 =?utf-8?B?SWFhUEMvdldNUkdtR1JTL2xya0JCR1R4MVAyMWhYazVpSUtZVUliMU56OEZh?=
 =?utf-8?B?dk5WS2I0WTZSZnhSWVlpVUQrdzJ4SlgrMDJ3SG00YVV2Tkw0Wi9zYXZzdFNi?=
 =?utf-8?B?KzI1VTFIeUpRcG9nYjhBTVFEOEJ3TGovTTk2OVpRWC8vU00zUHlRQlU4VFA5?=
 =?utf-8?Q?RsibiGDVeKMhKDJjDAoaNFgQ5?=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: SJ0PR11MB6744.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 4a01fe0e-242f-43f0-d78d-08dce135a0ff
X-MS-Exchange-CrossTenant-originalarrivaltime: 30 Sep 2024 09:52:43.0050 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: gvSDb68NqV8PuW06vvI5jOO3RjI9rvwrJcE18g1I+gngaxuaAkosIhrqxJVc4/qORJV2puBWhOt3k3QxkIDjuz+Vycx0iUf8H5nUh1WFyhE=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH8PR11MB8014
X-OriginatorOrg: intel.com
Received-SPF: pass client-ip=192.198.163.9;
 envelope-from=zhenzhong.duan@intel.com; helo=mgamail.intel.com
X-Spam_score_int: -21
X-Spam_score: -2.2
X-Spam_bar: --
X-Spam_report: (-2.2 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.095,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_VALIDITY_CERTIFIED_BLOCKED=0.001, RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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

U29ycnksIGZvcmdvdCB0byB1cGRhdGUgdG8gbmV3IHBhcmFtZXRlciAieC1zY2FsYWJsZS1tb2Rl
PW9uLHgtZmxzPW9uIiwgd2lsbCByZXNlbmQgdGhpcyBwYXRjaCBvbmx5Lg0KDQpUaGFua3MNClpo
ZW56aG9uZw0KDQo+LS0tLS1PcmlnaW5hbCBNZXNzYWdlLS0tLS0NCj5Gcm9tOiBEdWFuLCBaaGVu
emhvbmcgPHpoZW56aG9uZy5kdWFuQGludGVsLmNvbT4NCj5TdWJqZWN0OiBbUEFUQ0ggdjQgMTcv
MTddIHRlc3RzL3F0ZXN0OiBBZGQgaW50ZWwtaW9tbXUgdGVzdA0KPg0KPkFkZCB0aGUgZnJhbWV3
b3JrIHRvIHRlc3QgdGhlIGludGVsLWlvbW11IGRldmljZS4NCj4NCj5DdXJyZW50bHkgb25seSB0
ZXN0ZWQgY2FwL2VjYXAgYml0cyBjb3JyZWN0bmVzcyBpbiBzY2FsYWJsZQ0KPm1vZGVybiBtb2Rl
LiBBbHNvIHRlc3RlZCBjYXAvZWNhcCBiaXRzIGNvbnNpc3RlbmN5IGJlZm9yZQ0KPmFuZCBhZnRl
ciBzeXN0ZW0gcmVzZXQuDQo+DQo+U2lnbmVkLW9mZi1ieTogWmhlbnpob25nIER1YW4gPHpoZW56
aG9uZy5kdWFuQGludGVsLmNvbT4NCj5BY2tlZC1ieTogVGhvbWFzIEh1dGggPHRodXRoQHJlZGhh
dC5jb20+DQo+UmV2aWV3ZWQtYnk6IENsw6ltZW50IE1hdGhpZXUtLURyaWY8Y2xlbWVudC5tYXRo
aWV1LS1kcmlmQGV2aWRlbi5jb20+DQo+QWNrZWQtYnk6IEphc29uIFdhbmcgPGphc293YW5nQHJl
ZGhhdC5jb20+DQo+LS0tDQo+IE1BSU5UQUlORVJTICAgICAgICAgICAgICAgICAgICB8ICAxICsN
Cj4gaW5jbHVkZS9ody9pMzg2L2ludGVsX2lvbW11LmggIHwgIDEgKw0KPiB0ZXN0cy9xdGVzdC9p
bnRlbC1pb21tdS10ZXN0LmMgfCA2NQ0KPisrKysrKysrKysrKysrKysrKysrKysrKysrKysrKysr
KysNCj4gdGVzdHMvcXRlc3QvbWVzb24uYnVpbGQgICAgICAgIHwgIDEgKw0KPiA0IGZpbGVzIGNo
YW5nZWQsIDY4IGluc2VydGlvbnMoKykNCj4gY3JlYXRlIG1vZGUgMTAwNjQ0IHRlc3RzL3F0ZXN0
L2ludGVsLWlvbW11LXRlc3QuYw0KPg0KPmRpZmYgLS1naXQgYS9NQUlOVEFJTkVSUyBiL01BSU5U
QUlORVJTDQo+aW5kZXggNjJmNTI1NWY0MC4uMzMxYjdjN2ExMyAxMDA2NDQNCj4tLS0gYS9NQUlO
VEFJTkVSUw0KPisrKyBiL01BSU5UQUlORVJTDQo+QEAgLTM2NzksNiArMzY3OSw3IEBAIFM6IFN1
cHBvcnRlZA0KPiBGOiBody9pMzg2L2ludGVsX2lvbW11LmMNCj4gRjogaHcvaTM4Ni9pbnRlbF9p
b21tdV9pbnRlcm5hbC5oDQo+IEY6IGluY2x1ZGUvaHcvaTM4Ni9pbnRlbF9pb21tdS5oDQo+K0Y6
IHRlc3RzL3F0ZXN0L2ludGVsLWlvbW11LXRlc3QuYw0KPg0KPiBBTUQtVmkgRW11bGF0aW9uDQo+
IFM6IE9ycGhhbg0KPmRpZmYgLS1naXQgYS9pbmNsdWRlL2h3L2kzODYvaW50ZWxfaW9tbXUuaA0K
PmIvaW5jbHVkZS9ody9pMzg2L2ludGVsX2lvbW11LmgNCj5pbmRleCA0ZDZhY2IyMzE0Li5hMTg1
ODg5OGYxIDEwMDY0NA0KPi0tLSBhL2luY2x1ZGUvaHcvaTM4Ni9pbnRlbF9pb21tdS5oDQo+Kysr
IGIvaW5jbHVkZS9ody9pMzg2L2ludGVsX2lvbW11LmgNCj5AQCAtNDcsNiArNDcsNyBAQCBPQkpF
Q1RfREVDTEFSRV9TSU1QTEVfVFlQRShJbnRlbElPTU1VU3RhdGUsDQo+SU5URUxfSU9NTVVfREVW
SUNFKQ0KPiAjZGVmaW5lIFZURF9IT1NUX0FXXzQ4QklUICAgICAgICAgICA0OA0KPiAjZGVmaW5l
IFZURF9IT1NUX0FXX0FVVE8gICAgICAgICAgICAweGZmDQo+ICNkZWZpbmUgVlREX0hBV19NQVNL
KGF3KSAgICAgICAgICAgICgoMVVMTCA8PCAoYXcpKSAtIDEpDQo+KyNkZWZpbmUgVlREX01HQVdf
RlJPTV9DQVAoY2FwKSAgICAgICgoY2FwID4+IDE2KSAmIDB4M2ZVTEwpDQo+DQo+ICNkZWZpbmUg
RE1BUl9SRVBPUlRfRl9JTlRSICAgICAgICAgICgxKQ0KPg0KPmRpZmYgLS1naXQgYS90ZXN0cy9x
dGVzdC9pbnRlbC1pb21tdS10ZXN0LmMgYi90ZXN0cy9xdGVzdC9pbnRlbC1pb21tdS10ZXN0LmMN
Cj5uZXcgZmlsZSBtb2RlIDEwMDY0NA0KPmluZGV4IDAwMDAwMDAwMDAuLjYxMzFlMjAxMTcNCj4t
LS0gL2Rldi9udWxsDQo+KysrIGIvdGVzdHMvcXRlc3QvaW50ZWwtaW9tbXUtdGVzdC5jDQo+QEAg
LTAsMCArMSw2NSBAQA0KPisvKg0KPisgKiBRVGVzdCB0ZXN0Y2FzZSBmb3IgaW50ZWwtaW9tbXUN
Cj4rICoNCj4rICogQ29weXJpZ2h0IChjKSAyMDI0IEludGVsLCBJbmMuDQo+KyAqDQo+KyAqIEF1
dGhvcjogWmhlbnpob25nIER1YW4gPHpoZW56aG9uZy5kdWFuQGludGVsLmNvbT4NCj4rICoNCj4r
ICogVGhpcyB3b3JrIGlzIGxpY2Vuc2VkIHVuZGVyIHRoZSB0ZXJtcyBvZiB0aGUgR05VIEdQTCwg
dmVyc2lvbiAyIG9yIGxhdGVyLg0KPisgKiBTZWUgdGhlIENPUFlJTkcgZmlsZSBpbiB0aGUgdG9w
LWxldmVsIGRpcmVjdG9yeS4NCj4rICovDQo+Kw0KPisjaW5jbHVkZSAicWVtdS9vc2RlcC5oIg0K
PisjaW5jbHVkZSAibGlicXRlc3QuaCINCj4rI2luY2x1ZGUgImh3L2kzODYvaW50ZWxfaW9tbXVf
aW50ZXJuYWwuaCINCj4rDQo+KyNkZWZpbmUgQ0FQX01PREVSTl9GSVhFRDEgICAgKFZURF9DQVBf
RlJPIHwgVlREX0NBUF9ORlIgfA0KPlZURF9DQVBfTkQgfCBcDQo+KyAgICAgICAgICAgICAgICAg
ICAgICAgICAgICAgIFZURF9DQVBfTUFNViB8IFZURF9DQVBfUFNJIHwgVlREX0NBUF9TTExQUykN
Cj4rI2RlZmluZSBFQ0FQX01PREVSTl9GSVhFRDEgICAoVlREX0VDQVBfUUkgfCAgVlREX0VDQVBf
SVIgfA0KPlZURF9FQ0FQX0lSTyB8IFwNCj4rICAgICAgICAgICAgICAgICAgICAgICAgICAgICAg
VlREX0VDQVBfTUhNViB8IFZURF9FQ0FQX1NNVFMgfCBWVERfRUNBUF9GTFRTKQ0KPisNCj4rc3Rh
dGljIGlubGluZSB1aW50NjRfdCB2dGRfcmVnX3JlYWRxKFFUZXN0U3RhdGUgKnMsIHVpbnQ2NF90
IG9mZnNldCkNCj4rew0KPisgICAgcmV0dXJuIHF0ZXN0X3JlYWRxKHMsIFEzNV9IT1NUX0JSSURH
RV9JT01NVV9BRERSICsgb2Zmc2V0KTsNCj4rfQ0KPisNCj4rc3RhdGljIHZvaWQgdGVzdF9pbnRl
bF9pb21tdV9tb2Rlcm4odm9pZCkNCj4rew0KPisgICAgdWludDhfdCBpbml0X2NzcltETUFSX1JF
R19TSVpFXTsgICAgIC8qIHJlZ2lzdGVyIHZhbHVlcyAqLw0KPisgICAgdWludDhfdCBwb3N0X3Jl
c2V0X2NzcltETUFSX1JFR19TSVpFXTsgICAgIC8qIHJlZ2lzdGVyIHZhbHVlcyAqLw0KPisgICAg
dWludDY0X3QgY2FwLCBlY2FwLCB0bXA7DQo+KyAgICBRVGVzdFN0YXRlICpzOw0KPisNCj4rICAg
IHMgPSBxdGVzdF9pbml0KCItTSBxMzUgLWRldmljZSBpbnRlbC1pb21tdSx4LXNjYWxhYmxlLW1v
ZGU9bW9kZXJuIik7DQo+Kw0KPisgICAgY2FwID0gdnRkX3JlZ19yZWFkcShzLCBETUFSX0NBUF9S
RUcpOw0KPisgICAgZ19hc3NlcnQoKGNhcCAmIENBUF9NT0RFUk5fRklYRUQxKSA9PSBDQVBfTU9E
RVJOX0ZJWEVEMSk7DQo+Kw0KPisgICAgdG1wID0gY2FwICYgVlREX0NBUF9TQUdBV19NQVNLOw0K
PisgICAgZ19hc3NlcnQodG1wID09IChWVERfQ0FQX1NBR0FXXzM5Yml0IHwgVlREX0NBUF9TQUdB
V180OGJpdCkpOw0KPisNCj4rICAgIHRtcCA9IFZURF9NR0FXX0ZST01fQ0FQKGNhcCk7DQo+KyAg
ICBnX2Fzc2VydCh0bXAgPT0gVlREX0hPU1RfQVdfNDhCSVQgLSAxKTsNCj4rDQo+KyAgICBlY2Fw
ID0gdnRkX3JlZ19yZWFkcShzLCBETUFSX0VDQVBfUkVHKTsNCj4rICAgIGdfYXNzZXJ0KChlY2Fw
ICYgRUNBUF9NT0RFUk5fRklYRUQxKSA9PSBFQ0FQX01PREVSTl9GSVhFRDEpOw0KPisNCj4rICAg
IHF0ZXN0X21lbXJlYWQocywgUTM1X0hPU1RfQlJJREdFX0lPTU1VX0FERFIsIGluaXRfY3NyLA0K
PkRNQVJfUkVHX1NJWkUpOw0KPisNCj4rICAgIHFvYmplY3RfdW5yZWYocXRlc3RfcW1wKHMsICJ7
ICdleGVjdXRlJzogJ3N5c3RlbV9yZXNldCcgfSIpKTsNCj4rICAgIHF0ZXN0X3FtcF9ldmVudHdh
aXQocywgIlJFU0VUIik7DQo+Kw0KPisgICAgcXRlc3RfbWVtcmVhZChzLCBRMzVfSE9TVF9CUklE
R0VfSU9NTVVfQUREUiwgcG9zdF9yZXNldF9jc3IsDQo+RE1BUl9SRUdfU0laRSk7DQo+KyAgICAv
KiBFbnN1cmUgcmVnaXN0ZXJzIGFyZSBjb25zaXN0ZW50IGFmdGVyIGhhcmQgcmVzZXQgKi8NCj4r
ICAgIGdfYXNzZXJ0KCFtZW1jbXAoaW5pdF9jc3IsIHBvc3RfcmVzZXRfY3NyLCBETUFSX1JFR19T
SVpFKSk7DQo+Kw0KPisgICAgcXRlc3RfcXVpdChzKTsNCj4rfQ0KPisNCj4raW50IG1haW4oaW50
IGFyZ2MsIGNoYXIgKiphcmd2KQ0KPit7DQo+KyAgICBnX3Rlc3RfaW5pdCgmYXJnYywgJmFyZ3Ys
IE5VTEwpOw0KPisgICAgcXRlc3RfYWRkX2Z1bmMoIi9xMzUvaW50ZWwtaW9tbXUvbW9kZXJuIiwN
Cj50ZXN0X2ludGVsX2lvbW11X21vZGVybik7DQo+Kw0KPisgICAgcmV0dXJuIGdfdGVzdF9ydW4o
KTsNCj4rfQ0KPmRpZmYgLS1naXQgYS90ZXN0cy9xdGVzdC9tZXNvbi5idWlsZCBiL3Rlc3RzL3F0
ZXN0L21lc29uLmJ1aWxkDQo+aW5kZXggMzEwODY1ZTQ5Yy4uOGE5MjhjYWY3MCAxMDA2NDQNCj4t
LS0gYS90ZXN0cy9xdGVzdC9tZXNvbi5idWlsZA0KPisrKyBiL3Rlc3RzL3F0ZXN0L21lc29uLmJ1
aWxkDQo+QEAgLTkwLDYgKzkwLDcgQEAgcXRlc3RzX2kzODYgPSBcDQo+ICAgKGNvbmZpZ19hbGxf
ZGV2aWNlcy5oYXNfa2V5KCdDT05GSUdfU0IxNicpID8gWydmdXp6LXNiMTYtdGVzdCddIDogW10p
ICsNCj5cDQo+ICAgKGNvbmZpZ19hbGxfZGV2aWNlcy5oYXNfa2V5KCdDT05GSUdfU0RIQ0lfUENJ
JykgPyBbJ2Z1enotc2RjYXJkLXRlc3QnXSA6IFtdKQ0KPisgICAgICAgICAgICBcDQo+ICAgKGNv
bmZpZ19hbGxfZGV2aWNlcy5oYXNfa2V5KCdDT05GSUdfRVNQX1BDSScpID8gWydhbTUzYzk3NC10
ZXN0J10gOiBbXSkgKw0KPlwNCj4rICAoY29uZmlnX2FsbF9kZXZpY2VzLmhhc19rZXkoJ0NPTkZJ
R19WVEQnKSA/IFsnaW50ZWwtaW9tbXUtdGVzdCddIDogW10pICsNCj5cDQo+ICAgKGhvc3Rfb3Mg
IT0gJ3dpbmRvd3MnIGFuZCAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAg
ICAgICAgICAgICAgICAgICAgICAgICBcDQo+ICAgIGNvbmZpZ19hbGxfZGV2aWNlcy5oYXNfa2V5
KCdDT05GSUdfQUNQSV9FUlNUJykgPyBbJ2Vyc3QtdGVzdCddIDogW10pICsNCj5cDQo+ICAgKGNv
bmZpZ19hbGxfZGV2aWNlcy5oYXNfa2V5KCdDT05GSUdfUENJRV9QT1JUJykgYW5kDQo+XA0KPi0t
DQo+Mi4zNC4xDQoNCg==

