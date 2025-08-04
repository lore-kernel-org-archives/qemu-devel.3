Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 60EBFC87FCB
	for <qemu-devel@archiver.kernel.org>; Mon,  4 Aug 2025 02:31:17 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uiky8-0005XG-Uz; Sun, 03 Aug 2025 22:30:33 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <zhenzhong.duan@intel.com>)
 id 1uikwI-0003rb-MQ
 for qemu-devel@nongnu.org; Sun, 03 Aug 2025 22:28:39 -0400
Received: from mgamail.intel.com ([198.175.65.17])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <zhenzhong.duan@intel.com>)
 id 1uikwG-00006W-UC
 for qemu-devel@nongnu.org; Sun, 03 Aug 2025 22:28:38 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1754274517; x=1785810517;
 h=from:to:cc:subject:date:message-id:references:
 in-reply-to:content-transfer-encoding:mime-version;
 bh=mZxJdskNqAB5pzosJx6jtUmLEQCbtUtKed76dnBINDs=;
 b=bfEsp9DYwfJ6tNVxpzrvdmqDQnUqCKPXXiNcGMPPKUOv/6kisH/wQoGC
 gl9MFxGLj3Kf3WbiiUjYramAh1ns272b8oVYLZINVea3kQEoUtMJJuW74
 Tt9u5cHuLpXjEUbMHfHyeW83B/rT+oCZSH01Pq0ypVruajeGkckqcDHxN
 wjGcN+Z/IMyktWMK2iFUWKZd6KRTiZdeTm9TF52K36jRlmoxyqP7cgGwE
 ZI4sWnx+kZgqzONoEj0fIvYxLrdU3P6HsuyUishbEgeRaShR0k+Qs7k48
 iewUf+37WKngIex8kk3yCARzsKdyoJ1piOhjiMjIg/1Dgb5ehIB5gjmUh g==;
X-CSE-ConnectionGUID: TGzFt2TUTeervsBnU21GmA==
X-CSE-MsgGUID: U7VX2v/LQRePIfaj3yKIfA==
X-IronPort-AV: E=McAfee;i="6800,10657,11511"; a="56488130"
X-IronPort-AV: E=Sophos;i="6.17,258,1747724400"; d="scan'208";a="56488130"
Received: from orviesa003.jf.intel.com ([10.64.159.143])
 by orvoesa109.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 03 Aug 2025 19:28:35 -0700
X-CSE-ConnectionGUID: r/ckaHWjTDmyVqR+txeb8Q==
X-CSE-MsgGUID: aHxnyT8/StSExMMHLxZsSg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.17,258,1747724400"; d="scan'208";a="168240238"
Received: from orsmsx903.amr.corp.intel.com ([10.22.229.25])
 by orviesa003.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 03 Aug 2025 19:28:34 -0700
Received: from ORSMSX903.amr.corp.intel.com (10.22.229.25) by
 ORSMSX903.amr.corp.intel.com (10.22.229.25) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1748.26; Sun, 3 Aug 2025 19:28:33 -0700
Received: from ORSEDG901.ED.cps.intel.com (10.7.248.11) by
 ORSMSX903.amr.corp.intel.com (10.22.229.25) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1748.26 via Frontend Transport; Sun, 3 Aug 2025 19:28:33 -0700
Received: from NAM02-DM3-obe.outbound.protection.outlook.com (40.107.95.60) by
 edgegateway.intel.com (134.134.137.111) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1748.26; Sun, 3 Aug 2025 19:28:32 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=rE7ZUQh+XuwHP9ROSwdCNX/WTZahZqeLuxWY5L5Ua5DGBe41tmq25h3tm/a5uBB7H/mDyAXJfUaIMjLAJ3yunLOKw62VQZfRIgWWnIegGxX1bAt1aNVr89MzURzHI94l45KYG5OeJX8IHlfwxoYJ9xIT2nBJtfrnPhYdfXwLfn5oVj8pBpMDYEhuRcpVJrHTgIsIz0Ssrm2BisQz7IIMsiTFK9e9trk+5glye9ENFta71J9iLlv8CZd9bslrJzAFY7SjvyLrsilDhsnK5MOBfd+sVh7fQyJbmWCjvrScE6L4H+hMGDbyPakGQL8GkFUg0nmkUoYyyNGfyArXdFFt8A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=mZxJdskNqAB5pzosJx6jtUmLEQCbtUtKed76dnBINDs=;
 b=QRo9JhJTj6o/AuujA8TSdFZ39H3bv88JpFAJ5EoCZpysHjRMEz5qsuKMIHnDhPH9cNgWeppdP12DwKjWI81A0LW/3OrfKA7mNH4Xtfon/oq1dz+kRsPDFlV4X5+WHJ19dgOdhSLOXdzrVVX69suq41GsmThnfKTx0H7gXTfeePaC6VfpB1yVc3CWN/xeFZiaF8VYnomLLXZG3YVwATkobAR/H/bRQLlddMRLpYFYShE1j5lZGv5aE+tr63cja2SODNqAhKcMkpkz3r5jhPwpkMeZN2XulC4xGHmINSOa9uxhUoLxMIfu01gh8XScEqIhQDP/7lLXbnDK6M7YyFvyig==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Received: from IA3PR11MB9136.namprd11.prod.outlook.com (2603:10b6:208:574::12)
 by DS7PR11MB6176.namprd11.prod.outlook.com (2603:10b6:8:98::7) with
 Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.8989.14; Mon, 4 Aug 2025 02:27:49 +0000
Received: from IA3PR11MB9136.namprd11.prod.outlook.com
 ([fe80::604b:77a4:b1be:3f13]) by IA3PR11MB9136.namprd11.prod.outlook.com
 ([fe80::604b:77a4:b1be:3f13%4]) with mapi id 15.20.8989.017; Mon, 4 Aug 2025
 02:27:49 +0000
From: "Duan, Zhenzhong" <zhenzhong.duan@intel.com>
To: =?utf-8?B?UGhpbGlwcGUgTWF0aGlldS1EYXVkw6k=?= <philmd@linaro.org>,
 "qemu-devel@nongnu.org" <qemu-devel@nongnu.org>
CC: "alex.williamson@redhat.com" <alex.williamson@redhat.com>,
 "clg@redhat.com" <clg@redhat.com>, "eric.auger@redhat.com"
 <eric.auger@redhat.com>, "Peng, Chao P" <chao.p.peng@intel.com>
Subject: RE: [PATCH v3] vfio: Introduce helper vfio_pci_from_vfio_device()
Thread-Topic: [PATCH v3] vfio: Introduce helper vfio_pci_from_vfio_device()
Thread-Index: AQHcAoz/W/Dqu93ZF0WSs3LZ3mV1R7RN1/mAgAPw9sA=
Date: Mon, 4 Aug 2025 02:27:49 +0000
Message-ID: <IA3PR11MB9136111A5500F519A376B2369223A@IA3PR11MB9136.namprd11.prod.outlook.com>
References: <20250801023533.1458644-1-zhenzhong.duan@intel.com>
 <83d920b8-1838-43c7-a86f-5f4e5e5980b3@linaro.org>
In-Reply-To: <83d920b8-1838-43c7-a86f-5f4e5e5980b3@linaro.org>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: IA3PR11MB9136:EE_|DS7PR11MB6176:EE_
x-ms-office365-filtering-correlation-id: 93d380a0-fd7c-498f-dae0-08ddd2fe819b
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0; ARA:13230040|1800799024|376014|366016|38070700018;
x-microsoft-antispam-message-info: =?utf-8?B?NGo5YzQ0TUpQMUtQSGpmaDhYKzFkVGNUWXNyTUZQOUdIbTl6YlFJRG9ZNDlF?=
 =?utf-8?B?SFZES1F3cnZxdmdBNEUyY0tSYWNObHRiQkFyci8yUHBzYTBEUmJ3NlJrWjlO?=
 =?utf-8?B?Q0RjSXhzNS9JOTd5OEl1bDBOanppK2huYzZlZ2JaSnZ6VkhZN3dhM2IyOXVC?=
 =?utf-8?B?ZGVPci91U1pPaldRNVloMUdXTTU4K0kwdFB5bEg3Qi84Ym9GcDdNeHNUVCsv?=
 =?utf-8?B?SjYyZWUzUUxlbnhDYUswbWNVVWZsamZYcURJOC9pbHRsUzlXVDJqVE16ZUdh?=
 =?utf-8?B?Mkk2ZWtFN0VnaWdLZ0V6bktja2pBVkg3Wm5uZWhyUTRRQU52bFk2dUhsODdZ?=
 =?utf-8?B?S3RxcmZ1bjZmTGFRVjZyWkUrdkRLSFNac0RQakZxUkRKL3FxQ2M0NHJGdEpi?=
 =?utf-8?B?WVkwUzFqc1NrRFExNlB6UjlHNEhqS2k0TWZMbWlHUTRoZm1sRmxyblF4RlBa?=
 =?utf-8?B?bzltS0JjL0pjakF5NWQ2K3pSR3VKNXBQRmZOVXRZN3NDai80czlLUnh1ckZ6?=
 =?utf-8?B?NzQ3ZG5TRW1qQndINTlBbmlCM1lQQjg1akpIdVpiT0duUlhVM010eFVPVzU5?=
 =?utf-8?B?Q24vSjluN0ZINmQ1T3JvS3FHZy8rVld5dkVYK3NIZU1McHBiSUJlbTZER2hC?=
 =?utf-8?B?TU9EZExZLzE0eERhc2xkSUYwVEpJcUVwd2FTSDlHa1JydE9xRFh0Qi9VYnNB?=
 =?utf-8?B?UkFCQXB5WGpjd0pRNnVrQnpnaXBFNU5IYllnMFRjWkc1ZmlkdEhLRFBrWHhI?=
 =?utf-8?B?U25XV1k2Sk0rY3FCZGdBaTJMUDljdFFueHRPUlVwMXVQSDV0cDVTNEtiejVk?=
 =?utf-8?B?VDJXNEdkUlJkL2JwR2xReFVIS2M4NjFVMlVZQVdVK3d1alZGZXN2cHZ4K3lR?=
 =?utf-8?B?WTlPZjNsSXc4VW96NU40MjVkK2g3MEdwK2s5ZCszbkVId05vVjFvRENTVzB3?=
 =?utf-8?B?d2JoVkZmTnF4Y1hsaFoxaHBaMkhjeEdVQ2IrMEpqZkNhRkNwOWEvY0NVRjda?=
 =?utf-8?B?a1FSdG9hbjZsZzhKa2tzbGZGc2RHdGl6MHpsbHltaXZaK3J4L3NuNXdtN3Jn?=
 =?utf-8?B?MUF4bUFKb1Zic1lQVEhMZXEzRkpVRGh6dDZWQVEzRXUvdDZ3UW9FMTgxbFhX?=
 =?utf-8?B?UjFoM2swOVJnSXdwNU9GaDlLWWNYeFRmOG82RVczeXFiWkZPVmsrd3BnZ2tr?=
 =?utf-8?B?ODlwUFUzMkc0Rm5jKzVMV3YyN1drUk1uMW1QUVN6UlhWbTByOGUrR1JvVllP?=
 =?utf-8?B?NTBMRkpsTTFNVG9Cb1UzZDVHK1J1VlZRL01kL2sxSHJEZnJxMjZtait3elVM?=
 =?utf-8?B?RVJkVlhaSjFDcFVFcnR6Qk5PeFdYaE1PZzEvZGZBQlc0S0dtaUU1QTlaTytV?=
 =?utf-8?B?VloxZHFyazF5ZDZpamUyYjdwOHIrMmxZbVdDbVlGejhUamVwYy9PMy9LUGtr?=
 =?utf-8?B?TU5UTmR6TWFZeDFReHUrV3pMaTJFMXBVeGRzKzR4OTJ3Rkxscm02QkVnY0hY?=
 =?utf-8?B?V01reDkydTlKMjEzSXFKNG13QWlkZ2ZPRXJHSzUvYUtPMnpaYnRobEpiWEZQ?=
 =?utf-8?B?Tm0yejhKQTBJWmF3NVVydFRRcmtHdGRtNC9QbGJRbWdPdmsyUk5mclVBQ0xJ?=
 =?utf-8?B?MWIreWU3UmV3OFNwcW5UY0FwNnJqTHN6eGF4MmVvMC9sbmNvVWFiQkd2ekpK?=
 =?utf-8?B?VHRHTnFlQzhGWkR5cDZ5cE9adzBrOUE2TjRta2RzRE43azc5VjVzcXdLUzJx?=
 =?utf-8?B?eDl0ckVmNGx2RldKUVJ3Ym93L1BGam5MMkJQZGFZNmordkNlNzN5LzQrMzlF?=
 =?utf-8?B?aCtORTFZQkwzbmVyUHArdlZtOEVNRUdFZmNOTHhGaGhJWFlrZCtpVFkyWjZy?=
 =?utf-8?B?SGgwRFFIb2syOTF5Tm1ZcXZ3ZzI3QmFkVmt3c3BuU1Y4akM0OWlZT2UzUGVx?=
 =?utf-8?B?K2dkVm10a2ZLdXRwdlFSVW01TmJKTXd0c2ZKeGVUM2ovQ1pSU0JXa09XZEF3?=
 =?utf-8?Q?GqYJxGQNKGP/sH5FXOXXw1akAP2eCE=3D?=
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:IA3PR11MB9136.namprd11.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(1800799024)(376014)(366016)(38070700018); DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?cWg3V3FqWGJWTHY5YWo0TGtuSmxkbHpKN0UvbVhtUzlFSE4yWGc1R0ZmYVMv?=
 =?utf-8?B?SE9tYXdIcGlHSUk3VnpKUzY3NUV6SmpJb2RwQzQzREcxL1NPUFM0U0xwencz?=
 =?utf-8?B?M1NBVGUzNkFUODZBN2FEd2Z4Wk9md0JsTEo4N29JcUIya2tKYU1kdmtVVitQ?=
 =?utf-8?B?RGVRNmZHbDQ3WG1ON2d4RUoxT0MzbmNRMkxZNm45ZXRPbDdvL1pjUzhsUmpX?=
 =?utf-8?B?ZWhjQUl0V21hTXRHZmJLdzBlUW13Nnp3RjRHb3crMDl5R0NuS2JyelZ0TGZY?=
 =?utf-8?B?QmJmUkxkTytiamhhRk4xRmNyVnJ4bUJCOTd2bzY3TlJpYlJNNmYwT1piYlI2?=
 =?utf-8?B?djRYNFpYTWQxb0Z2U1VFSFpEL0U4Uk9sUjZ2UGtnRHF6QW5hR3NWRGFiTzZC?=
 =?utf-8?B?V0tpcHhqNXY0dzE2YXhGeG5TNk5SZ3dYV1hONUxnZmVaaGJBSXB3aTJnS2ls?=
 =?utf-8?B?VEtHUzlNVnBqVlgzc2ZTWG53NTVGMGdOY1BHOEpmcWtMODBleFBiWDNwRlEx?=
 =?utf-8?B?Q3gwZUVmb0lVSnlQelQvYW1XdkZFUEowb0NMdmhpaDF0VFVPV0F1V1hPS0VR?=
 =?utf-8?B?aXpGWVdSYXpCekJ4V2pxUjg4d0g1SGdha25WYU5GbnZneUxubjJES0dWQitr?=
 =?utf-8?B?Q0RpOExvMk1uakg3MkpqZlR0dlNmVGdPM084RVhmT0lMQkJsaXZ5aEdhMEk4?=
 =?utf-8?B?akk4NGFYMWM4Y1lxT3loeml1RVUwb3BUN1VlcU5kMTZ6aTFIalUwTDlWbHpL?=
 =?utf-8?B?OVI2VzExTElvaEo2MzcwNkJXUXpaalFGMk4wVWhkMEdmTEZIUCtRS1BGMjBo?=
 =?utf-8?B?Uitra0RCaVlna0pJdGM5ZlpuMGdqSmgvL1pMVjg5bnVsUkRUOVdEaXFTYUFN?=
 =?utf-8?B?dndNcHlwOUNDQ0NPRlVZWVJIM25jZDhhbE9yVnR2Q3dMZ3BBbU40Q2R5VjM3?=
 =?utf-8?B?VlhSTk8zUm0rS2kxMFBnYlFwR2Y1bXJzTS9vK3JvRVp1U25IMTRrZXpZbjYx?=
 =?utf-8?B?YS9RcXR6UVplT2tHMEVhMkE5NVFqZWt6YjU2SmFKd3h3VHhVeGxJOU5waGoz?=
 =?utf-8?B?YkJQZWplTUwwbXp1OHRsenpEa0QxVjFicFJ0RmVWMHU2TTBxRTFibERQWWV3?=
 =?utf-8?B?MzZzdW1WdlY3WUFwdVlzcm02VkV3aFJEcUJod1RWbzljWElkQmVGSHFOVU41?=
 =?utf-8?B?NjNVcGsvbnBLd0FXbWQ2ZlpVcW81b2RKREtYUWgyQ1JnR2lCZFRtRVN3VUJB?=
 =?utf-8?B?bXNPT3U2Z1pxTHRTOGJSa0J1Q09waGlKTGZycVlsOUVDY2NJNlltYkFvV0Nk?=
 =?utf-8?B?OVU3QnNSRmNMTmtxbEkvd2MrYkVrZDlEMyt3Unc0bnlPWFNzdDczR1lqeE51?=
 =?utf-8?B?K1RoTlpXdUVUVTJBYVR4c3c4bHkvQ2V4WG84eWVTczdvSHZZcDBPRGg3b0NH?=
 =?utf-8?B?Q210UnhkZmdFdG5wWm1taWdJY3NpVHBzdWpKMG9KMC9pMmNLY29EaTJnbUVU?=
 =?utf-8?B?Z24wVkFWbVRFaEJ3M0hrREpjZSs3N3ZRWTFIYlJjT1JMOWc1c3h6d1ZDdWRV?=
 =?utf-8?B?djBCYS9wNk1YdHBYQXNKZ1hDM0FtUXJFUTNoY3pKTEpBVTB2OVcwVUVxa2ZF?=
 =?utf-8?B?OERobElJMFZtNFRrYWFoS2E3aHp0L1RHa1RmdHBpb2dDdTk4L2xyUml1Wmgw?=
 =?utf-8?B?UWlzVnVhZHg5TElDa1I1RnQ5U0Y5U0RpczVac2dVZmRVQ2R2eHRLeHFiVUk2?=
 =?utf-8?B?dnhRK2U4UXMzRGw0dm9QSGI5MDdSVEhPUmlJeldtdjVVY1h0RWNhQ1JlamJI?=
 =?utf-8?B?WmkwWFIxaEVxU1ZzWGRucUZGWEZJNVZaK0p2RXNJWmgvbjNZY1JjL29VWEly?=
 =?utf-8?B?aWQ3b1JTYytEQVFzVTNXOWNDVG9mc3NCUmg0ZnU2TlpXYm95d3RuVWJCOE1K?=
 =?utf-8?B?aXhkTlF2dzI2QnFzYm1qODVKd3lDTFVNU0RIM2Q1YXVycVV2YWxjQ1RUYmJC?=
 =?utf-8?B?c1UxdGF4VUp4UjRpVGhvRm1wTVpvZzNvK2Zpa3ZuV2YyQk04WG1Wd21UVE15?=
 =?utf-8?B?Qm5yS0d3WGkwME1oVlVjQlltZDM3WCs5UDc5cTgzd2tCSWJLOVhKRjltZnhF?=
 =?utf-8?Q?j0lykb0gxnt9J+QEDT8PnGing?=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: IA3PR11MB9136.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 93d380a0-fd7c-498f-dae0-08ddd2fe819b
X-MS-Exchange-CrossTenant-originalarrivaltime: 04 Aug 2025 02:27:49.3852 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: FWmok5Xkhw4DRMDV9E+NTu1MsMHkNxVAEIpE9LyqHf8sj9vNi0w0iOZZluaFIrDPot7d/79ZZc0EUswmDROVMpUPp5pAEDAE9Y9qgrTg19w=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS7PR11MB6176
X-OriginatorOrg: intel.com
Received-SPF: pass client-ip=198.175.65.17;
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

DQoNCj4tLS0tLU9yaWdpbmFsIE1lc3NhZ2UtLS0tLQ0KPkZyb206IFBoaWxpcHBlIE1hdGhpZXUt
RGF1ZMOpIDxwaGlsbWRAbGluYXJvLm9yZz4NCj5TdWJqZWN0OiBSZTogW1BBVENIIHYzXSB2Zmlv
OiBJbnRyb2R1Y2UgaGVscGVyIHZmaW9fcGNpX2Zyb21fdmZpb19kZXZpY2UoKQ0KPg0KPk9uIDEv
OC8yNSAwNDozNSwgWmhlbnpob25nIER1YW4gd3JvdGU6DQo+PiBJbnRyb2R1Y2UgaGVscGVyIHZm
aW9fcGNpX2Zyb21fdmZpb19kZXZpY2UoKSB0byB0cmFuc2Zvcm0gZnJvbSBWRklPRGV2aWNlDQo+
PiB0byBWRklPUENJRGV2aWNlLCBhbHNvIHRvIGhpZGUgbG93IGxldmVsIFZGSU9fREVWSUNFX1RZ
UEVfUENJIHR5cGUNCj5jaGVjay4NCj4+DQo+PiBTdWdnZXN0ZWQtYnk6IEPDqWRyaWMgTGUgR29h
dGVyIDxjbGdAcmVkaGF0LmNvbT4NCj4+IFNpZ25lZC1vZmYtYnk6IFpoZW56aG9uZyBEdWFuIDx6
aGVuemhvbmcuZHVhbkBpbnRlbC5jb20+DQo+PiAtLS0NCj4+IHYzOiBhZGQgb25lIGxpbmUgY29t
bWVudCB0byB0aGUgaGVscGVyDQo+PiB2MjogbW92ZSBoZWxwZXIgdG8gaHcvdmZpby9wY2kuW2hj
XQ0KPj4gICAgICByZW5hbWUgd2l0aCB2ZmlvX3BjaV8gcHJlZml4DQo+Pg0KPj4gICBody92Zmlv
L3BjaS5oICAgICAgIHwgMSArDQo+PiAgIGh3L3ZmaW8vY29udGFpbmVyLmMgfCA0ICsrLS0NCj4+
ICAgaHcvdmZpby9kZXZpY2UuYyAgICB8IDIgKy0NCj4+ICAgaHcvdmZpby9pb21tdWZkLmMgICB8
IDQgKystLQ0KPj4gICBody92ZmlvL2xpc3RlbmVyLmMgIHwgNCArKy0tDQo+PiAgIGh3L3ZmaW8v
cGNpLmMgICAgICAgfCA5ICsrKysrKysrKw0KPj4gICA2IGZpbGVzIGNoYW5nZWQsIDE3IGluc2Vy
dGlvbnMoKyksIDcgZGVsZXRpb25zKC0pDQo+Pg0KPj4gZGlmZiAtLWdpdCBhL2h3L3ZmaW8vcGNp
LmggYi9ody92ZmlvL3BjaS5oDQo+PiBpbmRleCA4MTQ2NWE4MjE0Li41Mzg0MmNiMTQ5IDEwMDY0
NA0KPj4gLS0tIGEvaHcvdmZpby9wY2kuaA0KPj4gKysrIGIvaHcvdmZpby9wY2kuaA0KPj4gQEAg
LTIxOSw2ICsyMTksNyBAQCB2b2lkIHZmaW9fcGNpX3dyaXRlX2NvbmZpZyhQQ0lEZXZpY2UgKnBk
ZXYsDQo+PiAgIHVpbnQ2NF90IHZmaW9fdmdhX3JlYWQodm9pZCAqb3BhcXVlLCBod2FkZHIgYWRk
ciwgdW5zaWduZWQgc2l6ZSk7DQo+PiAgIHZvaWQgdmZpb192Z2Ffd3JpdGUodm9pZCAqb3BhcXVl
LCBod2FkZHIgYWRkciwgdWludDY0X3QgZGF0YSwgdW5zaWduZWQNCj5zaXplKTsNCj4+DQo+DQo+
WypdDQo+DQo+PiArVkZJT1BDSURldmljZSAqdmZpb19wY2lfZnJvbV92ZmlvX2RldmljZShWRklP
RGV2aWNlICp2YmFzZWRldik7DQo+PiAgIHZvaWQgdmZpb19zdWJfcGFnZV9iYXJfdXBkYXRlX21h
cHBpbmdzKFZGSU9QQ0lEZXZpY2UgKnZkZXYpOw0KPj4gICBib29sIHZmaW9fb3B0X3JvbV9pbl9k
ZW55bGlzdChWRklPUENJRGV2aWNlICp2ZGV2KTsNCj4+ICAgYm9vbCB2ZmlvX2NvbmZpZ19xdWly
a19zZXR1cChWRklPUENJRGV2aWNlICp2ZGV2LCBFcnJvciAqKmVycnApOw0KPg0KPlF1b3RpbmcN
Cj5odHRwczovL2xvcmUua2VybmVsLm9yZy9xZW11LWRldmVsLzg3YmpwbDI1ZTYuZnNmQGRyYWln
LmxpbmFyby5vcmcvOg0KPg0KPiAgIEdlbmVyYWxseSBBUElzIHRvIHRoZSByZXN0IG9mIFFFTVUg
c2hvdWxkIGJlIGRvY3VtZW50ZWQgaW4gdGhlDQo+ICAgaGVhZGVycy4gQ29tbWVudHMgb24gaW5k
aXZpZHVhbCBmdW5jdGlvbnMgb3IgaW50ZXJuYWwgZGV0YWlscyBhcmUNCj4gICBmaW5lIHRvIGxp
dmUgaW4gdGhlIEMgZmlsZXMuDQoNCkkgc2VlLCB0aGFua3MNCg0KPg0KPj4gZGlmZiAtLWdpdCBh
L2h3L3ZmaW8vcGNpLmMgYi9ody92ZmlvL3BjaS5jDQo+PiBpbmRleCA0ZmE2OTJjMWEzLi44NTc2
MTU0NGJhIDEwMDY0NA0KPj4gLS0tIGEvaHcvdmZpby9wY2kuYw0KPj4gKysrIGIvaHcvdmZpby9w
Y2kuYw0KPj4gQEAgLTI4MjQsNiArMjgyNCwxNSBAQCBzdGF0aWMgaW50IHZmaW9fcGNpX2xvYWRf
Y29uZmlnKFZGSU9EZXZpY2UNCj4qdmJhc2VkZXYsIFFFTVVGaWxlICpmKQ0KPj4gICAgICAgcmV0
dXJuIHJldDsNCj4+ICAgfQ0KPj4NCj4+ICsvKiBUcmFuc2Zvcm0gZnJvbSBWRklPRGV2aWNlIHRv
IFZGSU9QQ0lEZXZpY2UuIFJldHVybiBOVUxMIGlmIGZhaWxzLiAqLw0KPg0KPlNvIHRoaXMgY29t
bWVudCBwcmVmZXJhYmx5IGdvZXMgaW4gWypdLiBPdGhlcndpc2UsDQoNCkZZSSwgQ2VkcmljIGhl
bHBlZCB0byBtYWtlIHRoZSBzdWdnZXN0ZWQgY2hhbmdlLCBzbyBJJ2xsIG5vdCBzZW5kIHY0Lg0K
aHR0cHM6Ly9naXRodWIuY29tL2xlZ29hdGVyL3FlbXUvY29tbWl0L2QwZWMxNWFmOWE1YzBhOGE5
YzFhN2E3MTkwM2ViNGUwMGNhZTcxYjENCg0KQlJzLA0KWmhlbnpob25nDQoNCj4NCj5SZXZpZXdl
ZC1ieTogUGhpbGlwcGUgTWF0aGlldS1EYXVkw6kgPHBoaWxtZEBsaW5hcm8ub3JnPg0KPg0KPj4g
K1ZGSU9QQ0lEZXZpY2UgKnZmaW9fcGNpX2Zyb21fdmZpb19kZXZpY2UoVkZJT0RldmljZSAqdmJh
c2VkZXYpDQo+PiArew0KPj4gKyAgICBpZiAodmJhc2VkZXYgJiYgdmJhc2VkZXYtPnR5cGUgPT0g
VkZJT19ERVZJQ0VfVFlQRV9QQ0kpIHsNCj4+ICsgICAgICAgIHJldHVybiBjb250YWluZXJfb2Yo
dmJhc2VkZXYsIFZGSU9QQ0lEZXZpY2UsIHZiYXNlZGV2KTsNCj4+ICsgICAgfQ0KPj4gKyAgICBy
ZXR1cm4gTlVMTDsNCj4+ICt9DQoNCg==

