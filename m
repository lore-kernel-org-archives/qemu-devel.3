Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 888A2C5AD49
	for <qemu-devel@archiver.kernel.org>; Thu, 29 May 2025 07:17:44 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uKXVt-0002y4-Eu; Thu, 29 May 2025 03:17:17 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <zhenzhong.duan@intel.com>)
 id 1uKXVr-0002xr-0s
 for qemu-devel@nongnu.org; Thu, 29 May 2025 03:17:15 -0400
Received: from mgamail.intel.com ([192.198.163.17])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <zhenzhong.duan@intel.com>)
 id 1uKXVo-0004I6-Qv
 for qemu-devel@nongnu.org; Thu, 29 May 2025 03:17:14 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1748503033; x=1780039033;
 h=from:to:cc:subject:date:message-id:references:
 in-reply-to:content-transfer-encoding:mime-version;
 bh=pdb7tCv+d2npu7KlF1AV7u5CoLXHVr9RU6SEoIbDe/E=;
 b=TTek6quadr6hQNOtbTYldDBnxtrD1c9UC1mdAfEUIyPlEegoZLqMOGxo
 8jIQQMCUQk9HwpBuflA9kt1A9ASdTYtkGJD2IlutrDNk7bApthMsOzeX2
 dWG8k86kuMQNLZGy3Mrh9MncZlrfdicw3fS2XAlN8Z2qY4BYtDZZUj36U
 PqZs4DFrlRKv1pfrWM2Gilsv7J6LniEGpUsLUDA+kgaBQRK9lKL1VGNPt
 /MOoAgMyS8C4kzt0lQqJM7gOxwggq07zxYpNjU7AQtSjnzeVTTuKm4JAB
 H4YuQbAEMe7koKBTLvo2nzyen1BgqMEHXRX8j21p6KKP6vtguE9XhibKz Q==;
X-CSE-ConnectionGUID: 2EiRVQZqRBec1PTuVBdrnQ==
X-CSE-MsgGUID: nCirF8GQT1qEQg0Ir7R73A==
X-IronPort-AV: E=McAfee;i="6700,10204,11447"; a="50477369"
X-IronPort-AV: E=Sophos;i="6.15,323,1739865600"; d="scan'208";a="50477369"
Received: from orviesa001.jf.intel.com ([10.64.159.141])
 by fmvoesa111.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 29 May 2025 00:17:10 -0700
X-CSE-ConnectionGUID: lpFuAhleT52a7QK1Axvlzg==
X-CSE-MsgGUID: kSIkzU7kReG5Q4cbJJO4fQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.15,323,1739865600"; d="scan'208";a="180677997"
Received: from orsmsx901.amr.corp.intel.com ([10.22.229.23])
 by orviesa001.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 29 May 2025 00:17:10 -0700
Received: from ORSMSX901.amr.corp.intel.com (10.22.229.23) by
 ORSMSX901.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.25; Thu, 29 May 2025 00:17:09 -0700
Received: from orsedg603.ED.cps.intel.com (10.7.248.4) by
 ORSMSX901.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.25 via Frontend Transport; Thu, 29 May 2025 00:17:09 -0700
Received: from NAM10-MW2-obe.outbound.protection.outlook.com (40.107.94.80) by
 edgegateway.intel.com (134.134.137.100) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.55; Thu, 29 May 2025 00:17:08 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=C3YB5G36hsSKq8KMmSHrwyU3F77l6zqpy1EC2mCHttMYfdWo4BbIOvpLSV/tmJXS+gYJ9LuEIYHj4aSOA5uQ+//qMZAy70v6zh2EG6OSsw9EJ80ltKwSCULebr9LM7aJc0sKqLwquaO9rZ3eEL975UAnAVj9DMVtndv5+5pobA+rOaiUkmbMB6PsG//6i9MuFUKsaWZIpMgieMwuFZ2czwJSOR6stAixH56xBpryZ1pZztL8FwigmGpwwE9fq7+wkzjEUGeJJIelQavvKC+VcOQzNPiD/XQ9OOo05+J+y+UAlnYx8ji7SFVn9ubd18lvPODdx9RjB5ImWZE09+WAZQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=pdb7tCv+d2npu7KlF1AV7u5CoLXHVr9RU6SEoIbDe/E=;
 b=ULLbBh+vz34ns0KISowEDPMpBH/V7YPD5E8Ts1EJflqjTeDfKj0aLP9GMzDrS2kCpn0Z1E22Eb6kKQDy2eqOAu0G6izka2ix9woNyIAq+8ZKg01DUryQftKakkZa+er0FvX/b4sjX/f+vGLNhYvt80cjtXpHUWsif93t+Wxf0t2okqgjydVrOn5qRrczFSa7z0UqoaaJNV9QIfJPZ/crObLWgLdMuOrtBngQwO7Aibuafday2j6YEHar52+iJiRebfUKBQMHe2RbhyLvnKTjeYi7y1rs7MEGWDZVTVndgzDRUjp6nlPB1acOfYmqC+sVRT4CbmrZnzbXFNoeIBy+1Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Received: from SJ0PR11MB6744.namprd11.prod.outlook.com (2603:10b6:a03:47d::10)
 by CH3PR11MB8773.namprd11.prod.outlook.com (2603:10b6:610:1cb::13)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8769.26; Thu, 29 May
 2025 07:16:39 +0000
Received: from SJ0PR11MB6744.namprd11.prod.outlook.com
 ([fe80::fe49:d628:48b1:6091]) by SJ0PR11MB6744.namprd11.prod.outlook.com
 ([fe80::fe49:d628:48b1:6091%4]) with mapi id 15.20.8769.021; Thu, 29 May 2025
 07:16:39 +0000
From: "Duan, Zhenzhong" <zhenzhong.duan@intel.com>
To: =?utf-8?B?Q8OpZHJpYyBMZSBHb2F0ZXI=?= <clg@redhat.com>,
 "qemu-devel@nongnu.org" <qemu-devel@nongnu.org>
CC: "alex.williamson@redhat.com" <alex.williamson@redhat.com>,
 "eric.auger@redhat.com" <eric.auger@redhat.com>, "mst@redhat.com"
 <mst@redhat.com>, "jasowang@redhat.com" <jasowang@redhat.com>,
 "peterx@redhat.com" <peterx@redhat.com>, "ddutile@redhat.com"
 <ddutile@redhat.com>, "jgg@nvidia.com" <jgg@nvidia.com>,
 "nicolinc@nvidia.com" <nicolinc@nvidia.com>,
 "shameerali.kolothum.thodi@huawei.com"
 <shameerali.kolothum.thodi@huawei.com>, "joao.m.martins@oracle.com"
 <joao.m.martins@oracle.com>, "clement.mathieu--drif@eviden.com"
 <clement.mathieu--drif@eviden.com>, "Tian, Kevin" <kevin.tian@intel.com>,
 "Liu, Yi L" <yi.l.liu@intel.com>, "Peng, Chao P" <chao.p.peng@intel.com>,
 Marcel Apfelbaum <marcel.apfelbaum@gmail.com>, Paolo Bonzini
 <pbonzini@redhat.com>, Richard Henderson <richard.henderson@linaro.org>,
 Eduardo Habkost <eduardo@habkost.net>
Subject: RE: [PATCH v1 6/6] iommufd: Implement query of host VTD IOMMU's
 capability
Thread-Topic: [PATCH v1 6/6] iommufd: Implement query of host VTD IOMMU's
 capability
Thread-Index: AQHbz5buCGwWhF6sSk+GqhmJbLA3lbPn3JAAgAFS1aA=
Date: Thu, 29 May 2025 07:16:39 +0000
Message-ID: <SJ0PR11MB6744C42955663E7F19F048C89266A@SJ0PR11MB6744.namprd11.prod.outlook.com>
References: <20250528060409.3710008-1-zhenzhong.duan@intel.com>
 <20250528060409.3710008-7-zhenzhong.duan@intel.com>
 <96b8cd22-df17-4c3a-b28e-cf75268b6451@redhat.com>
In-Reply-To: <96b8cd22-df17-4c3a-b28e-cf75268b6451@redhat.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: SJ0PR11MB6744:EE_|CH3PR11MB8773:EE_
x-ms-office365-filtering-correlation-id: 5af308c1-1011-443f-4d1e-08dd9e80c196
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
 ARA:13230040|7416014|376014|1800799024|366016|38070700018; 
x-microsoft-antispam-message-info: =?utf-8?B?blY0ZFlvckcrOWxLZFFYeGQrT1RmWXpVZDB1NW1LRWQ1UDlrcTlIUDNGazA5?=
 =?utf-8?B?V3paQTg0TFIrY2JPUUx3RmNSL0s3U011ZXZWNjZzZitrNThWaDlLOUg0YjV4?=
 =?utf-8?B?MVZnMS9ieS9UbllFc1VPT1ZyTVNrRDRoOTNDMmxLUGsvcGF5QjhxQmcvNncz?=
 =?utf-8?B?eStOWkt0NkpPdW9FWG80MGIvL2lJSS91UWM5NjBYYS9ybHRiaFNVSzhCM29T?=
 =?utf-8?B?ZTBNeCsycm5lSks2Ti9GdlBwdVBlZmJtblFXSmxRbVV2L25jajBEMStjZVFE?=
 =?utf-8?B?QTJ2aE5jOFczSnlWSHI0NGtTTnF1enlWZDhFcWRXc1dXOWw0TWJSWlZQb3RU?=
 =?utf-8?B?WXlCRC9KZ1lJaE5SdWpxd1V3bnRpZ3BJTmVaTVR5bG5jYWp5UTRZV2ZIOGdn?=
 =?utf-8?B?RnQyRUNvTmRSYTFkdHlsLzQxTjgxa09aNy9ZVnBaSzBkeitVbjZXWnZyc29M?=
 =?utf-8?B?TWU5eXArT0o5TEU5S1MxSmZPZlZVenNGNUlROVNJQmx5aU9rbVNHK2Q3ZjlM?=
 =?utf-8?B?ZXdiaTJBT0lxWW1ZU1JHeWM3YnBYMTVhTTl5TGltYmFNWXFjU2tJSzhOeVl4?=
 =?utf-8?B?ZlhHekF6WUJDS3pKZ0xUbzFuMW8zOW9aUWErK3grKzYza3NWUVV0VEZ1SFBJ?=
 =?utf-8?B?cXg0d1lCY3RUSlRFZXNIeUZpNitzNEp1NG83SUUrZGdMNmFUeEtIdnp4UWtG?=
 =?utf-8?B?MEN2NnFNU2dkSjhGZHdONjJmdVE1OTFVWmdPbkpFQ0kxVnRTL3JuZ2VCTi9T?=
 =?utf-8?B?YXVxOGpJeWdzcW0yOUIxNk0wYUVXekJEVmpYNmZEdWVRYjFFb2FSNmtSYVZH?=
 =?utf-8?B?RWRRWTN6MzVUc2RQcGcwNDl1VEZpZWZ3amZkZFJlRWhhK3VQUHNrZm1wRmFE?=
 =?utf-8?B?YldZN2lkc1ZkdmRWVW1ZMzdMdXNXbXRwbjJTcExRdlJSYS84TTZSVFVvaUhB?=
 =?utf-8?B?THBqTE5JOHJzNStGTHdSVkV5ajJJSXliNytWYUtPcTRtQi9KOWhCUzg3OGNu?=
 =?utf-8?B?R0VWV2QxTFl4QTlERllTV1diZmIwSnpJZEltYURka1ZnZElHYmFHLythY3Z3?=
 =?utf-8?B?MVJENFdPNjJQbjhRRFgrZGlxbXlZc3FjZ0hucldzaTVRUmpKMzZHb3FackJT?=
 =?utf-8?B?WHBwVWJ4MUE3M25ucWZSRVY3d3hublR6eVJkbU9vN0lNRjRyOFBZRWxYZXRS?=
 =?utf-8?B?bTFCalZGYW5DOXdmbzY3YVdJRXhML3V5eHAzODIwak04aGNhNTYyaWZsQ1ZJ?=
 =?utf-8?B?Z2VMemRFZmNJVkVaWitRakc3K1NhQ1MvcktKWUpzTytIT2FsR1JHeFRGREZv?=
 =?utf-8?B?d0FDY3gvNkM3RHNDdUtWaFliaEdOTEdRMlY4STBsTkY0ZU5WWmk0NThoV3hx?=
 =?utf-8?B?Y1Z4amE0cFhGWldEQk5NQlJjQjdYL0dnT0V2S0FpSnQwbHNQVjB0RnJFdC9D?=
 =?utf-8?B?ZUNtQjZBNVNLUnVCbXdDZmM0NFhnWTBGSHNxaktxQVc4R3Q1RXdqY09rWDZT?=
 =?utf-8?B?Z00vVm5ySkEvODczVGlDSGFzd0tNMUcrRUMxTmRER2tueW5GcE9YdFF3Mmcz?=
 =?utf-8?B?TmM5QWVWMFYxUkpBUThZdEU0dEo2aWk4eUtRSnhGVHQyR29sUGdsRmZIRGNY?=
 =?utf-8?B?WlRXbEZxRnQyckpnK3VvZGtmdGxNanlWMTQrNnEvOWpCN2kwMVRxMFhEQWIv?=
 =?utf-8?B?VjdzNVJHUnJCKytoTUo1Q3JlY3o0Rk94QllaYmtrbHlrU3hubSs5V1VSWTNG?=
 =?utf-8?B?aFI2dnZsVk9iV0E0N1NVSTRHZjF1Tzl4MG04K2xYZG1yZi9kbThBalpObDBu?=
 =?utf-8?B?eTNWdTdLaWg1dzBBcFcrQTFHd3FuZGhFd1JTalBLVkhBZHYvTTgyV0RkbW9P?=
 =?utf-8?B?bnRzVUNHZVBQRU1rVmZlZDFnNGwrUGxScDMvVVdsa0F2V3R5dENoZ1JvaUFh?=
 =?utf-8?B?bnpxZ3lCdVdhN0NWb3dTU2NLT3BqSVJ1ZEc1cU11TlZWNmRGTE9Pb2p3cVdJ?=
 =?utf-8?Q?e+tdm468+F5a3duYJu/0PByBcyMNvc=3D?=
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:SJ0PR11MB6744.namprd11.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(7416014)(376014)(1800799024)(366016)(38070700018); DIR:OUT;
 SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?cmc1bU1ISjRUNVVjNmEzdzV6QjZ0Smw5U3l2V1VEMHA1NmtVQUZHRUJJbGRq?=
 =?utf-8?B?RGNHZzdMYlJNNnpTTUJzOWtZMHhsOExtNXkvbzdaaDdzZkM2dzJxdCtRKzdW?=
 =?utf-8?B?Ylg2YllvMlorUGhkY3VOZjZEeVBSY0JnUjlhN2E2MFVKNEI4Yy8xUkt1TzRB?=
 =?utf-8?B?VE1qdlVLMW1oYjJVNzJSZXJQbXhNMDRNc29sbkYydkJ1ZHYvTStjZGVnQmJM?=
 =?utf-8?B?Z3JFNnF2NFQ0R2c4K1RHeWIvUmRvdGh4WVVoY2w3Slh1M1VtVHM3d01xekxp?=
 =?utf-8?B?b3NqTzRhckdldGIxRGdZcTcvdXQ4YzdKanpxdzBZZzBkYkJia3JWZ2hxYnNv?=
 =?utf-8?B?WU4yWXF2QzZsL2xJQy9WSVJZYWwvMnV2YXdISitsbkdxbHY1L0V6d2Y2UVFB?=
 =?utf-8?B?SHFnMnVueGg0K1QvS2VzMnhHVjdVUWQva1g3cmEzU1h2Sms2T2ZUSTEwZDhT?=
 =?utf-8?B?bzk5b1JaTk9uelNBcmFDK0FDUmJKYTVCQkRVWVkzSnZiRjBnSzl4SjNrUFk5?=
 =?utf-8?B?SitFQlFxa0xSUFRyL3BOQ2ZQNFBVSmJERWQ0aWJKckRUSkduNlAwaFQ2TUhH?=
 =?utf-8?B?UmY4UzY5R0M1RHc1d0RZR1VYTlgyekFEU3NRS0pkc004dWFIRXFJTS90bXNL?=
 =?utf-8?B?c3pPN3dwczNIdGo1NmVSS3Ryak41S3BHZFpZdnUvSE5BdURjbFF6QVBSZ1hJ?=
 =?utf-8?B?TTdJSHdDRVZER0czK280Q3kvdTk1TXF3SWVKdmgxblphWHlRdWYzNFZ1SDdy?=
 =?utf-8?B?K1d2RTdBVHhaMjg3TVBIWmc2ZHlaUWZCYk44RnplTENhTGZNLzBIcHdyM1ND?=
 =?utf-8?B?NE1jYkduanowSHREQ3hxRC9oN3lDVlJyWW9UcEVBYWlsb1BpR0ZRMHM2TlhQ?=
 =?utf-8?B?Qmh4YVhoV3l0V3J5a2I2ZjJaZ0MwWEZXZytDQkV0cVFYU3dKOHJmQWt4dk1E?=
 =?utf-8?B?QWwzWWdMYTJGRDZrMzNKYnQzN1RlOFZqME5ZZG4zU2x0YkJ6OFJ2aCtpS0tO?=
 =?utf-8?B?N1NVWUNQTHNJcGdNL1NoNmYwU24xVW9xbGRSVEszWFZveU52QnJUNUhGb1Zq?=
 =?utf-8?B?M3NpWWZuQStsL2U0Y0ErLzg0Q3JteTEySW1qcmJjMzg3ZlFLTkZFVytNUldD?=
 =?utf-8?B?RndpOUd0WXo3bE5KU0J6N2NUQmV4VzVsaFY5Z05vZmRLa1JpRVE1OVFEdFRw?=
 =?utf-8?B?RWtxWUpLckRjOG9UWS96cmRCRUkwY2VKamlYbElwMWhNZFlnRm9VQVFWOEpS?=
 =?utf-8?B?c3dxdmxSN1JNaGlaaXBnYjY3NmNrR2M5MTJjZTA4aTlxMEJYOENBQXNDV0xt?=
 =?utf-8?B?d1lZamtQQUU1K1NoZzBBaExqU0ZieFRHNndGYjBQRjh2c0krc0xDTktuNGg5?=
 =?utf-8?B?NmRIOFhkZG9lYnNEaEVhcHdDRVhxcjFNcVV2VmdDeXVzVEZvUXJzNzdGMk9p?=
 =?utf-8?B?T2tXMUtqZzhwTmI1a3Z5T0owL0FqSG9OaVYwS01VUTNtMEx1Vmt4MWRtY0RH?=
 =?utf-8?B?UWJkbTBta25tb1VGUWY5Nkk0WVkwNTNTTHR5KzBXYy9zU2RxeTA1d1gxN1JT?=
 =?utf-8?B?L2xEWWVBTDlpYlp1UE1rckpNVEgyR2xSalNtTDE3aWVnaTFGM1JEaGtjQ0dN?=
 =?utf-8?B?STF3R2FVS2FFZXY1a3NsVHNoNTNNaWt3UHlncDJ2Y3dDT0o5TmlvbXdmTE9j?=
 =?utf-8?B?dnN4cjFQTGZlaUFnbm5WYWtZNVJLVksxSmtURkNHTnQwbDUyNndDdUxOZjdK?=
 =?utf-8?B?elBtSzRZVGg4cm02bUxzUzdrZVp0VnRPYkFFcVhZRFlNYVVCTm53L1RWYXJa?=
 =?utf-8?B?SEFJU1BJYWNoaFFlVTdNOGJXWEVOMHZFdzNTOTNVVWxlRzVtLzI2Z0gyc2c0?=
 =?utf-8?B?WHBkTk80bXNBVEJkS3F5UG10Z01YWXdyclhlWDlnMDloV213elBvMnVlS3F0?=
 =?utf-8?B?OFRCMUZNUEhxTGx6WEJTVkpSM0RDcWM0RXVvUGExZkJZUmViUDVEc2U2emlM?=
 =?utf-8?B?MHd5aTlxZkNXSWxma0Y2anZsQW8vUyt1V2tUR0tKa3VhS2pBUEZ2WWFlTlNL?=
 =?utf-8?B?M3pjMkZ3eG9YR09HcUMyRkxST0NtbnBqelpCaXdqTmdLZ1ltVEhBYkdWWVBr?=
 =?utf-8?Q?AA14mM7QpBDEKcwXsjC1HE80f?=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: SJ0PR11MB6744.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 5af308c1-1011-443f-4d1e-08dd9e80c196
X-MS-Exchange-CrossTenant-originalarrivaltime: 29 May 2025 07:16:39.7153 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 55jQdTcHZBsIKZT9RBo3gxrDoJHM7c5g0mXds1ypaNb0zcw/eophTcyszalZT2eJZEdmKR0OiM0tcUlqnvzw5C3JLpHAIhoSAfnOq10SvCY=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH3PR11MB8773
X-OriginatorOrg: intel.com
Received-SPF: pass client-ip=192.198.163.17;
 envelope-from=zhenzhong.duan@intel.com; helo=mgamail.intel.com
X-Spam_score_int: -72
X-Spam_score: -7.3
X-Spam_bar: -------
X-Spam_report: (-7.3 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-2.904,
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

DQoNCj4tLS0tLU9yaWdpbmFsIE1lc3NhZ2UtLS0tLQ0KPkZyb206IEPDqWRyaWMgTGUgR29hdGVy
IDxjbGdAcmVkaGF0LmNvbT4NCj5TdWJqZWN0OiBSZTogW1BBVENIIHYxIDYvNl0gaW9tbXVmZDog
SW1wbGVtZW50IHF1ZXJ5IG9mIGhvc3QgVlREIElPTU1VJ3MNCj5jYXBhYmlsaXR5DQo+DQo+T24g
NS8yOC8yNSAwODowNCwgWmhlbnpob25nIER1YW4gd3JvdGU6DQo+PiBJbXBsZW1lbnQgcXVlcnkg
b2YgSE9TVF9JT01NVV9ERVZJQ0VfQ0FQX1tORVNUSU5HfEZTMUdQfEVSUkFUQV0NCj5mb3IgSU9N
TVVGRA0KPj4gYmFja2VkIGhvc3QgVlREIElPTU1VIGRldmljZS4NCj4+DQo+PiBRdWVyeSBvbiB0
aGVzZSBjYXBhYmlsaXRpZXMgaXMgbm90IHN1cHBvcnRlZCBmb3IgbGVnYWN5IGJhY2tlbmQgYmVj
YXVzZSB0aGVyZQ0KPj4gaXMgbm8gcGxhbiB0byBzdXBwb3J0IG5lc3Rpbmcgd2l0aCBsZWdhY3kg
YmFja2VuZCBiYWNrZWQgaG9zdCBkZXZpY2UuDQo+Pg0KPj4gU2lnbmVkLW9mZi1ieTogWmhlbnpo
b25nIER1YW4gPHpoZW56aG9uZy5kdWFuQGludGVsLmNvbT4NCj4+IC0tLQ0KPj4gICBody9pMzg2
L2ludGVsX2lvbW11X2ludGVybmFsLmggICAgIHwgIDEgKw0KPj4gICBpbmNsdWRlL3N5c3RlbS9o
b3N0X2lvbW11X2RldmljZS5oIHwgIDcgKysrKysrDQo+PiAgIGJhY2tlbmRzL2lvbW11ZmQuYyAg
ICAgICAgICAgICAgICAgfCAzOSArKysrKysrKysrKysrKysrKysrKysrKysrKysrLS0NCj4+ICAg
MyBmaWxlcyBjaGFuZ2VkLCA0NSBpbnNlcnRpb25zKCspLCAyIGRlbGV0aW9ucygtKQ0KPj4NCj4+
IGRpZmYgLS1naXQgYS9ody9pMzg2L2ludGVsX2lvbW11X2ludGVybmFsLmggYi9ody9pMzg2L2lu
dGVsX2lvbW11X2ludGVybmFsLmgNCj4+IGluZGV4IGU4YjIxMWU4YjAuLjJjZGE3NDQ3ODYgMTAw
NjQ0DQo+PiAtLS0gYS9ody9pMzg2L2ludGVsX2lvbW11X2ludGVybmFsLmgNCj4+ICsrKyBiL2h3
L2kzODYvaW50ZWxfaW9tbXVfaW50ZXJuYWwuaA0KPj4gQEAgLTE5MSw2ICsxOTEsNyBAQA0KPj4g
ICAjZGVmaW5lIFZURF9FQ0FQX1BUICAgICAgICAgICAgICAgICAoMVVMTCA8PCA2KQ0KPj4gICAj
ZGVmaW5lIFZURF9FQ0FQX1NDICAgICAgICAgICAgICAgICAoMVVMTCA8PCA3KQ0KPj4gICAjZGVm
aW5lIFZURF9FQ0FQX01ITVYgICAgICAgICAgICAgICAoMTVVTEwgPDwgMjApDQo+PiArI2RlZmlu
ZSBWVERfRUNBUF9ORVNUICAgICAgICAgICAgICAgKDFVTEwgPDwgMjYpDQo+PiAgICNkZWZpbmUg
VlREX0VDQVBfU1JTICAgICAgICAgICAgICAgICgxVUxMIDw8IDMxKQ0KPj4gICAjZGVmaW5lIFZU
RF9FQ0FQX1BBU0lEICAgICAgICAgICAgICAoMVVMTCA8PCA0MCkNCj4+ICAgI2RlZmluZSBWVERf
RUNBUF9TTVRTICAgICAgICAgICAgICAgKDFVTEwgPDwgNDMpDQo+PiBkaWZmIC0tZ2l0IGEvaW5j
bHVkZS9zeXN0ZW0vaG9zdF9pb21tdV9kZXZpY2UuaA0KPmIvaW5jbHVkZS9zeXN0ZW0vaG9zdF9p
b21tdV9kZXZpY2UuaA0KPj4gaW5kZXggMTBmY2NjMTBiZS4uYzI3NzBjYjQ2OSAxMDA2NDQNCj4+
IC0tLSBhL2luY2x1ZGUvc3lzdGVtL2hvc3RfaW9tbXVfZGV2aWNlLmgNCj4+ICsrKyBiL2luY2x1
ZGUvc3lzdGVtL2hvc3RfaW9tbXVfZGV2aWNlLmgNCj4+IEBAIC0yOSw2ICsyOSwxMCBAQCB0eXBl
ZGVmIHVuaW9uIFZlbmRvckNhcHMgew0KPj4gICAgKg0KPj4gICAgKiBAaHdfY2FwczogaG9zdCBw
bGF0Zm9ybSBJT01NVSBjYXBhYmlsaXRpZXMgKGUuZy4gb24gSU9NTVVGRCB0aGlzDQo+cmVwcmVz
ZW50cw0KPj4gICAgKiAgICAgICAgICAgdGhlIEBvdXRfY2FwYWJpbGl0aWVzIHZhbHVlIHJldHVy
bmVkIGZyb20gSU9NTVVfR0VUX0hXX0lORk8NCj5pb2N0bCkNCj4+ICsgKg0KPj4gKyAqIEB2ZW5k
b3JfY2FwczogaG9zdCBwbGF0Zm9ybSBJT01NVSB2ZW5kb3Igc3BlY2lmaWMgY2FwYWJpbGl0aWVz
IChlLmcuIG9uDQo+PiArICogICAgICAgICAgICAgICBJT01NVUZEIHRoaXMgcmVwcmVzZW50cyBy
YXcgdmVuZG9yIGRhdGEgZnJvbSBkYXRhX3VwdHINCj4+ICsgKiAgICAgICAgICAgICAgIGJ1ZmZl
ciByZXR1cm5lZCBmcm9tIElPTU1VX0dFVF9IV19JTkZPIGlvY3RsKQ0KPj4gICAgKi8NCj4+ICAg
dHlwZWRlZiBzdHJ1Y3QgSG9zdElPTU1VRGV2aWNlQ2FwcyB7DQo+PiAgICAgICB1aW50MzJfdCB0
eXBlOw0KPj4gQEAgLTExNiw2ICsxMjAsOSBAQCBzdHJ1Y3QgSG9zdElPTU1VRGV2aWNlQ2xhc3Mg
ew0KPj4gICAgKi8NCj4+ICAgI2RlZmluZSBIT1NUX0lPTU1VX0RFVklDRV9DQVBfSU9NTVVfVFlQ
RSAgICAgICAgMA0KPj4gICAjZGVmaW5lIEhPU1RfSU9NTVVfREVWSUNFX0NBUF9BV19CSVRTICAg
ICAgICAgICAxDQo+PiArI2RlZmluZSBIT1NUX0lPTU1VX0RFVklDRV9DQVBfTkVTVElORyAgICAg
ICAgICAgMg0KPj4gKyNkZWZpbmUgSE9TVF9JT01NVV9ERVZJQ0VfQ0FQX0ZTMUdQICAgICAgICAg
ICAgIDMNCj4+ICsjZGVmaW5lIEhPU1RfSU9NTVVfREVWSUNFX0NBUF9FUlJBVEEgICAgICAgICAg
ICA0DQo+Pg0KPj4gICAjZGVmaW5lIEhPU1RfSU9NTVVfREVWSUNFX0NBUF9BV19CSVRTX01BWCAg
ICAgICA2NA0KPj4gICAjZW5kaWYNCj4+IGRpZmYgLS1naXQgYS9iYWNrZW5kcy9pb21tdWZkLmMg
Yi9iYWNrZW5kcy9pb21tdWZkLmMNCj4+IGluZGV4IGIxMTRmYjA4ZTcuLjYzMjA5NjU5ZjMgMTAw
NjQ0DQo+PiAtLS0gYS9iYWNrZW5kcy9pb21tdWZkLmMNCj4+ICsrKyBiL2JhY2tlbmRzL2lvbW11
ZmQuYw0KPj4gQEAgLTIxLDYgKzIxLDcgQEANCj4+ICAgI2luY2x1ZGUgImh3L3ZmaW8vdmZpby1k
ZXZpY2UuaCINCj4+ICAgI2luY2x1ZGUgPHN5cy9pb2N0bC5oPg0KPj4gICAjaW5jbHVkZSA8bGlu
dXgvaW9tbXVmZC5oPg0KPj4gKyNpbmNsdWRlICJody9pMzg2L2ludGVsX2lvbW11X2ludGVybmFs
LmgiDQo+Pg0KPj4gICBzdGF0aWMgdm9pZCBpb21tdWZkX2JhY2tlbmRfaW5pdChPYmplY3QgKm9i
aikNCj4+ICAgew0KPj4gQEAgLTM2NCw2ICszNjUsNDEgQEAgYm9vbA0KPmhvc3RfaW9tbXVfZGV2
aWNlX2lvbW11ZmRfZGV0YWNoX2h3cHQoSG9zdElPTU1VRGV2aWNlSU9NTVVGRCAqaWRldiwNCj4+
ICAgICAgIHJldHVybiBpZGV2Yy0+ZGV0YWNoX2h3cHQoaWRldiwgZXJycCk7DQo+PiAgIH0NCj4+
DQo+PiArc3RhdGljIGludCBoaW9kX2lvbW11ZmRfZ2V0X3Z0ZF9jYXAoSG9zdElPTU1VRGV2aWNl
ICpoaW9kLCBpbnQgY2FwLA0KPj4gKyAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAg
IEVycm9yICoqZXJycCkNCj4+ICt7DQo+PiArICAgIHN0cnVjdCBpb21tdV9od19pbmZvX3Z0ZCAq
Y2FwcyA9ICZoaW9kLT5jYXBzLnZlbmRvcl9jYXBzLnZ0ZDsNCj4+ICsNCj4+ICsgICAgc3dpdGNo
IChjYXApIHsNCj4+ICsgICAgY2FzZSBIT1NUX0lPTU1VX0RFVklDRV9DQVBfTkVTVElORzoNCj4+
ICsgICAgICAgIHJldHVybiAhIShjYXBzLT5lY2FwX3JlZyAmIFZURF9FQ0FQX05FU1QpOw0KPj4g
KyAgICBjYXNlIEhPU1RfSU9NTVVfREVWSUNFX0NBUF9GUzFHUDoNCj4+ICsgICAgICAgIHJldHVy
biAhIShjYXBzLT5jYXBfcmVnICYgVlREX0NBUF9GUzFHUCk7DQo+PiArICAgIGNhc2UgSE9TVF9J
T01NVV9ERVZJQ0VfQ0FQX0VSUkFUQToNCj4+ICsgICAgICAgIHJldHVybiBjYXBzLT5mbGFncyAm
IElPTU1VX0hXX0lORk9fVlREX0VSUkFUQV83NzI0MTVfU1BSMTc7DQo+PiArICAgIGRlZmF1bHQ6
DQo+PiArICAgICAgICBlcnJvcl9zZXRnKGVycnAsICIlczogdW5zdXBwb3J0ZWQgY2FwYWJpbGl0
eSAleCIsIGhpb2QtPm5hbWUsIGNhcCk7DQo+PiArICAgICAgICByZXR1cm4gLUVJTlZBTDsNCj4+
ICsgICAgfQ0KPj4gK30NCj4NCj4NCj5UaGlzIGlzIGludGVsIHNwZWNpZmljLiBXaHkgbm90IGhh
bmRsZSB0aGVzZSBjYXBhYmlsaXRpZXMgZGlyZWN0bHkgZnJvbQ0KPnZ0ZF9jaGVja19oaW9kKCkg
dW5kZXIgaHcvaTM4Ni9pbnRlbF9pb21tdS5jID8NCg0KRG8geW91IG1lYW4gY2hlY2tpbmcgaGlv
ZC0+Y2Fwcy52ZW5kb3JfY2Fwcy52dGQuZWNhcC9jYXBfcmVnIGRpcmVjdGx5DQppbiBpbnRlbF9p
b21tdS5jIGFuZCBkcm9wIHZlbmRvciBjYXAgY2hlY2tpbmcgYnkgLmdldF9jYXAoKT8gVGhhdCdz
IGZpbmUNCmlmIHdlIGRvbid0IGhhdmUgcGxhbiB0byBzdXBwb3J0IHZpcnRpby1pb21tdSBxdWVy
eWluZyB2ZW5kb3IgY2FwcyBpbiBhDQpzdGFuZGFyZCB3YXkuDQoNClRoYW5rcw0KWmhlbnpob25n
DQo=

