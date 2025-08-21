Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5D3BBCA0EF8
	for <qemu-devel@archiver.kernel.org>; Thu, 21 Aug 2025 08:59:47 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1up18d-0000To-Fv; Thu, 21 Aug 2025 04:59:15 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <zhenzhong.duan@intel.com>)
 id 1up18b-0000Ss-TA
 for qemu-devel@nongnu.org; Thu, 21 Aug 2025 04:59:14 -0400
Received: from mgamail.intel.com ([192.198.163.9])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <zhenzhong.duan@intel.com>)
 id 1up18X-0002ta-9v
 for qemu-devel@nongnu.org; Thu, 21 Aug 2025 04:59:13 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1755766749; x=1787302749;
 h=from:to:cc:subject:date:message-id:references:
 in-reply-to:content-transfer-encoding:mime-version;
 bh=8zntbl0dvFWh3BE5YuF/h8G+xkUdt59DyxGjVfz573k=;
 b=acPacvcKLbHHNbddWxdSyo7iyHqMjJBR79WCqP6sQphcOy2T0Oz+7EjC
 u+uSedOyK9iTS/h2T1iDRF3NbqAIav2AS2Ka1aNHekLYAsOaPR5u/GReA
 Ju7RVQMOQGPlLmqtfWUwRRpNqnHQAc28g9o4s4U9h1qkYjj2reCLYDN6K
 vHczhr0YX3GhBSaHpamA93AI9hv8EJW0Jt+2mJk1H9WrBzxivMPq8W6Kh
 3tL7XUZoaMsrQI3ZIRnVGrqC7OAU32nEiLuLQqVxh0asfan/Fe690KpEK
 yBNz760gGj7Ut6z/KBxuiOIzpS/cGVX5C3xSm+Mcg8GOCD4NFmZZvJAnm Q==;
X-CSE-ConnectionGUID: onKyRbrFQ7yWPY5Pl1tPIA==
X-CSE-MsgGUID: ZNqyrsZnS1KboLvb/fu+kQ==
X-IronPort-AV: E=McAfee;i="6800,10657,11527"; a="68752971"
X-IronPort-AV: E=Sophos;i="6.17,306,1747724400"; d="scan'208";a="68752971"
Received: from fmviesa008.fm.intel.com ([10.60.135.148])
 by fmvoesa103.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 21 Aug 2025 01:59:04 -0700
X-CSE-ConnectionGUID: NxmVctdaRaWokIEX8k+g3A==
X-CSE-MsgGUID: RgChM/j0SbmYnm8DXAWs0Q==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.17,306,1747724400"; d="scan'208";a="168726106"
Received: from fmsmsx902.amr.corp.intel.com ([10.18.126.91])
 by fmviesa008.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 21 Aug 2025 01:59:03 -0700
Received: from FMSMSX903.amr.corp.intel.com (10.18.126.92) by
 fmsmsx902.amr.corp.intel.com (10.18.126.91) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.17; Thu, 21 Aug 2025 01:59:03 -0700
Received: from fmsedg903.ED.cps.intel.com (10.1.192.145) by
 FMSMSX903.amr.corp.intel.com (10.18.126.92) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.17 via Frontend Transport; Thu, 21 Aug 2025 01:59:03 -0700
Received: from NAM12-MW2-obe.outbound.protection.outlook.com (40.107.244.50)
 by edgegateway.intel.com (192.55.55.83) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.17; Thu, 21 Aug 2025 01:59:03 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=t1fEhaDqCWtI/5sYhuFXH3KnftlNelfwA+awVGMxA4zaCs3+mLy9FQ5BXSoxLzDFG4/KRLzfagxqKkA2hZXFut2dTZlMoCfEwbXCA4H9YBpjq5CjeJvEcD39Jp82KQDA6NXkI6SsL2IyLF9u5DNhFAllfvpalIwOCMNscS681jTqvkN0Qfq4WReNEUqtr6aM3GH2eoXeltFmeYS+mvdqKUfFCHwC25yyiFeAbGD1K4lOsYpzJFljAgLzu0NRohtNJl+Kc1bigijN5Ox11XDAG8FyOgXHXQq0m2S4KTo25tCc5racjmBOLKXpWpDhHWzpJ08+4E+8hw3D3KdF71ZvaQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=8zntbl0dvFWh3BE5YuF/h8G+xkUdt59DyxGjVfz573k=;
 b=h4xZpuq/gYtmWMzQ6eswn937pBOkXgekrvOapPPQulGlQmN/UIADAx3ancq6s1xwDQf9Vo2mSJxKATIvTAa1q9EnKs87oZaJP9LzkQs/lambYjgt0kvFg6vraUx3JxiAo8FZrjy1sTvZo+/1+7S8PpVz3l7ZrpiTlaofTV49YZWx3RD98str9FaItjLxdT1Vhju81+gMd2pKa2t1eHBlSKcEyHIstg6+NjZAsODPOxlvRpLgPmBSBMX7pqsbSzpDdI9vxT/gvsWBLyUNInQuF+wBluFxWnp/3JmgbXBmeM6Ai5DiY2nBXMmdqR3NW+bhpHo3CZBGTvsSct4l4KNT3g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Received: from IA3PR11MB9136.namprd11.prod.outlook.com (2603:10b6:208:574::12)
 by CH3PR11MB8382.namprd11.prod.outlook.com (2603:10b6:610:173::14)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9052.15; Thu, 21 Aug
 2025 08:58:56 +0000
Received: from IA3PR11MB9136.namprd11.prod.outlook.com
 ([fe80::604b:77a4:b1be:3f13]) by IA3PR11MB9136.namprd11.prod.outlook.com
 ([fe80::604b:77a4:b1be:3f13%4]) with mapi id 15.20.9052.014; Thu, 21 Aug 2025
 08:58:56 +0000
From: "Duan, Zhenzhong" <zhenzhong.duan@intel.com>
To: "eric.auger@redhat.com" <eric.auger@redhat.com>, "Liu, Yi L"
 <yi.l.liu@intel.com>, "qemu-devel@nongnu.org" <qemu-devel@nongnu.org>
CC: "alex.williamson@redhat.com" <alex.williamson@redhat.com>,
 "clg@redhat.com" <clg@redhat.com>, "mst@redhat.com" <mst@redhat.com>,
 "jasowang@redhat.com" <jasowang@redhat.com>, "peterx@redhat.com"
 <peterx@redhat.com>, "ddutile@redhat.com" <ddutile@redhat.com>,
 "jgg@nvidia.com" <jgg@nvidia.com>, "nicolinc@nvidia.com"
 <nicolinc@nvidia.com>, "shameerali.kolothum.thodi@huawei.com"
 <shameerali.kolothum.thodi@huawei.com>, "joao.m.martins@oracle.com"
 <joao.m.martins@oracle.com>, "clement.mathieu--drif@eviden.com"
 <clement.mathieu--drif@eviden.com>, "Tian, Kevin" <kevin.tian@intel.com>,
 "Peng, Chao P" <chao.p.peng@intel.com>
Subject: RE: [PATCH v4 00/20] intel_iommu: Enable stage-1 translation for
 passthrough device
Thread-Topic: [PATCH v4 00/20] intel_iommu: Enable stage-1 translation for
 passthrough device
Thread-Index: AQHcAGod+i7KqE+Pt02Tk9KMC5fQ97Rs1sxggAAZoID////vgIAAAUVw
Date: Thu, 21 Aug 2025 08:58:56 +0000
Message-ID: <IA3PR11MB9136CBABE33C586570CCC1659232A@IA3PR11MB9136.namprd11.prod.outlook.com>
References: <20250729092043.785836-1-zhenzhong.duan@intel.com>
 <DS4PPF93A1BBECD1D6A6FEA7C800E6EDD069232A@DS4PPF93A1BBECD.namprd11.prod.outlook.com>
 <5d3d46b3-ce2d-455a-b8bd-57213f9ea093@intel.com>
 <5ebbfbde-cf12-4bf8-b01a-253ea4ed5dee@redhat.com>
In-Reply-To: <5ebbfbde-cf12-4bf8-b01a-253ea4ed5dee@redhat.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: IA3PR11MB9136:EE_|CH3PR11MB8382:EE_
x-ms-office365-filtering-correlation-id: b6512f7a-1127-4652-d30a-08dde090f5fb
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
 ARA:13230040|1800799024|7416014|366016|376014|38070700018; 
x-microsoft-antispam-message-info: =?utf-8?B?NGpjVTcwS3VHQ21IbnlDM1FDNVV0Q2ZKbkJBdVFRaldXSlIzNXRpcUd0dytN?=
 =?utf-8?B?QU53bnZZTEFaZ0p6MUtIdWhxcndReVkrVE1RanZoTjVrV0w5eUJKdEtXZWFl?=
 =?utf-8?B?SWdlZEgyVmtyTkZVc0dNY1VZMUlnNy9GZUJVWEVJTFBwN1kvSmxZaU1pQWhE?=
 =?utf-8?B?akJtbGVKSGZBWEs5Z0V6Mzc4UWtNUG5pSUJjRnF2dE9URmpOM2VFMm5TU0Zv?=
 =?utf-8?B?anV4SUxlRDhnUTN1bHN2dWtJYm9IR0RQekhIQyt1a3M4TkNoRTMwbVMxY3hF?=
 =?utf-8?B?RnhWaFg2aERaTnJKL3ZUTys0SWNsT05qSFA3RytpMFRNSGgzTnF1YmpyTXg0?=
 =?utf-8?B?Y21temtPZFBxVm8rUGY1bURyVkR5VXVGQ1BPemwzV2ppSkl6d2RYdVI5S2dj?=
 =?utf-8?B?cDluNGpwUWljS1VQeW9aVVdCWVVDQWp0U2g3aGdFYU8yZkUrRWQ4YTluak1j?=
 =?utf-8?B?aml5WDR5bGo0MTFWVUx1Z0tjSzIrbnVvdFFJSXhVVnR2MmozTnZyL1NDbVpT?=
 =?utf-8?B?aE1FZmJON2JMQkJ0REZrTkpMeTVYWTRmdlFVNGZiSjdUVzhSM1dHcmtUUnJh?=
 =?utf-8?B?em9jMVQwL0VwRkhDOEdMajlKK0JKT2tGNStlZ2EzUHRvdHdGZjdqb2pzQldJ?=
 =?utf-8?B?Vzg5NCtEcHdRV0swZDJ4TndzWXZaakV5eDFnRFBQb2pPenphODNvMEtuT3px?=
 =?utf-8?B?MlZOUDVJUnhEM1l4NXdYM1pqME5tZ1JKbzc0NVMwZTJGWHVIVHZNREhrRHZ3?=
 =?utf-8?B?Rk9Od3k1cUhaYkJCK1E2eCt5dGZWb1JzdFFENTJUaHBzd1A1cXBRY1c3ajR4?=
 =?utf-8?B?RXp0c3ZSRGpQRElqVnVvT05KUUpwcFhjTk01QjdYclJISFVFR2Q0aGZhTW8w?=
 =?utf-8?B?akVzVVR2OVR5c1poc0lDTEsyRDl4SFpKMXIvMHgxUTN5cUwvM0hpa3U2VVI3?=
 =?utf-8?B?N0R4QUNLOWZVOCtoQm0xTmJ2Y2Q1SEszL05hVDg5bXRxWDB1NzhxREttVW92?=
 =?utf-8?B?TnJzemc3Z01ZREZDMmhvSG1zUnhva0dnaDd2MGptSTNEWVdMVVF5ZmxoR1B6?=
 =?utf-8?B?cEZ3akx0QTNSRkNjRmxoTjUraHVrZUttQkMyaVNMWWlaeUptSUpYbTFQRnFJ?=
 =?utf-8?B?QUROMkpIbXFtdFFyNU9OZVVJTlJKVDVWTUw1RVlGQmRVTDhuT0x4b25PRzhY?=
 =?utf-8?B?aksvM2tmUU9KcjhackdZQ0w4UWEvaWpBQThyd1JsWGlYamFxWlZJUTF3VmIw?=
 =?utf-8?B?dWtPaTFBcitmV3VzUWMzajVzNks3OVRsNnpSTDd1NEVvRXNEYWgvdUNMWFVW?=
 =?utf-8?B?RDZtVXRjdGtFcnhKYmUxcWRsQW5yMDJESVROYUpaZDNDT0xKdlZ2cTdYa2t4?=
 =?utf-8?B?SlN3L1FNWHNPK1J1WkJFZFFYWGV4cHZLRklrUW1sUjFMOEZDenNjd2ZoYlhp?=
 =?utf-8?B?VE4wVTF3dzlMQXk1eGVQZTZTK0xEbHpFbFk2cDlQR3hMVmIrVEVFVklBT1NQ?=
 =?utf-8?B?ZUNiaFJVQWhBcU5EaWdLalJXV2tCMnRsam1EMmxiL2hWRi9rSDRrY1FuV21z?=
 =?utf-8?B?SkZRc0pDY2tLY1Z6dUpaY1FrZ0xrT2M5THJRaGx0aUN4aDNBTm80WFdORmVQ?=
 =?utf-8?B?NzJpR3RqNUppbzJheXUzVUk3M1JnVXViOWtDM1lWTHROLzNTQ2NlMmdqQUtk?=
 =?utf-8?B?QzdGank0SzV1Z2s0MmFRRHNINnZMZEhHbVd4VjFVd1JMWkdaU251bnFOTytP?=
 =?utf-8?B?L3pmRkJhY2RBaVdxcEJSVlhFMksxZ0RqclpjN3l0eDRYSW15azFYTUdmbHFh?=
 =?utf-8?B?YzNSenlsL3FPOHJpdFpBMkdlZlFidGt1TDVXU0NhN1JGMkxLRDhlU2JNNzRO?=
 =?utf-8?B?UGFGcHo3U09LR2RqZVd5VzE5Um81MjJvNjBqbFoxWnEvc0tHQU5JalFYaGFE?=
 =?utf-8?B?V0lBdytrWmU5MHoxS3htdngyTy9aOUFEM05UaEs0dzErdEw2dERueGVsWUJj?=
 =?utf-8?B?eGVJN2ZyM1FnPT0=?=
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:IA3PR11MB9136.namprd11.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(1800799024)(7416014)(366016)(376014)(38070700018); DIR:OUT;
 SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?T1V4N1lKeG5hQTVnd3dUVG83MURvQXFxOWhuWUZ2eWN1YWtoZjFTeUpaY1oy?=
 =?utf-8?B?cEpoak9nRUxLRWtubWxwV2hoY2hTYXdkeDR0YVZJdGxja2FxS1hTdVoxWXY3?=
 =?utf-8?B?VEhITXFSc016ZG9Ic3NLdTlmdUVyRU9nalczQmxWR2MzQytXdXhXcUxVY1E2?=
 =?utf-8?B?KzVRSHRoYitLRUIySzVoekxIR2tvQXhnWVB0QTdtMFpwNWw4WU8vSTIyT1Jj?=
 =?utf-8?B?UmpaYlpsaWJiVm1IMkl6aU1aN1M5YXNBcU1yOUZPMlQ3Nlp3TithZFpBM09n?=
 =?utf-8?B?TjFXWlNVNVpyZlJNQlBZZkQ3SUNDN2plOW91bzNWTUZ2QVVnZlB3b01sU0J4?=
 =?utf-8?B?K1pCZTBwVUJXN1BvZ1YvcE04S3k1aGxPUnFPNUNlZGpMYUZjeC9MZzBZVXNw?=
 =?utf-8?B?VDlMWVVwNnBNU3JnZWlFREZQMHQ1QXR4aEZhMFdwY3NOK3h0QWhQd1dWU0Vi?=
 =?utf-8?B?MzdMWHd1VkluaDJONHJlNC9KTXQyM1drTjlEZlpvNmpNckFMem80Yk1jem5n?=
 =?utf-8?B?SnMxS2tiY085cjdYUk1ZV055d3R4YkMyUXZhcEc5RHpVcEFEckE1bzdPb0RH?=
 =?utf-8?B?bGlkdXZiRk9mYitrK1lEVTVaMTFjOTVkS0FNYjhjdE0zYmp4ZURLNzRYbUZy?=
 =?utf-8?B?UTZJUWcvcjZpWDh6b2k5aGNBZXlXVng2NGJVVitJR3V2NkxwTUx3bzlUaXB6?=
 =?utf-8?B?dEp2U3NPTEtwWTlURHRMWEh0MFh6UUxEcmhUM1BwYjQwU0lxTCtTSlZjQ3Uz?=
 =?utf-8?B?bWJNeTV1amxlVmRML0R4YUJXM0xBZDA2WGxyUXgzT09kY1ZpRzZ6QWJhZTR5?=
 =?utf-8?B?dVpsODdFMWlwck1ZTDZZcEMvUlpuQURhZzNCUHR4d2tIUG9odlJjNVNMeWY4?=
 =?utf-8?B?UDJPenYwelZZRkg0YU9VbTBpWExuSmJzSm1HSVBXQ0dENlA5bG9MRlVtWXI5?=
 =?utf-8?B?VkJFUGdBdFZoNFhIM1JiejU3UndFN1Q0dWZTeWdESHp1c3g5UnNCaWVMeHdo?=
 =?utf-8?B?ZmVjMStCa1FYU0pldFJ0OUFacHJoN0NoYnUrQ2ZRcjh5YkdBNG82clYvNW5Q?=
 =?utf-8?B?Z2xVZGxXeTRkRXk0N092UUNGSXozN3RZbVUyMUFWcjI1Q29hYVRncHlONU1h?=
 =?utf-8?B?VGVvaEpZQVVudFZKOCs1c3crTEt5ZUx0a3RSYytlalZEQ3VDdG15OFJ6MU5o?=
 =?utf-8?B?ZnZxZy9YQTkxMW1NMmVhTUxKOFk3WVBMUWhQckI5KzlKQnFLWWxha285WndW?=
 =?utf-8?B?QzdobmRoa2NOcTA2SlZ5TTVFajNWcHVmL3Ywb0UzWVpjdmRMbmxBTzJMMUgr?=
 =?utf-8?B?KzdWemxseThhTytEY3JhNHNQdHdxb0FOUm92Y2hoQVFEamVmeVdOTE1SWngz?=
 =?utf-8?B?NlBCVUhOZnp2Zllvc3dSYnhMQ1lGT3BCRERUcXZsUVpQcENFT0J6VXVzQVAv?=
 =?utf-8?B?N3dqMm8vTGdGeFpMMnczM1JUOTZHdFpOYXllZCs2b0dadWJYRS9JQi9qVWx1?=
 =?utf-8?B?bDZINWhtVDRQTUVSOUN0VkpDQ1N2Q1lWeUtXeDlvTWN4UXdNL2RvQll4OURB?=
 =?utf-8?B?dTk4eXI1TzZsb3pmSEd2djZhS2trU1diTVdXRlYwRmpUTS82NjFKVzVyKzFy?=
 =?utf-8?B?MzZ1YjFodWdxd0lYNzBKeGtxdG5XeVNKSHFodkxoclhQTDJaZUdJT2FwVmdi?=
 =?utf-8?B?VEpvSGZOWW1TZ3MydWI4QklXK2pTSmVNTVlESmdTaXlzTElYcWVNYUgrMFFN?=
 =?utf-8?B?OEpYSCtWZVRMZ3drU0xETDMrVkgwUklFUkVUQnI1b0ljVXpXUHlycVcvV3l6?=
 =?utf-8?B?dy9FWENHazJkMUlyZytaZ1Z3MktvZG9pR2xpd0Q2YWtzcWpIcTRxTjJEOVVz?=
 =?utf-8?B?N2k4aTc2Z2J1UUNURnloN2hRUWFqZ0wvczF2eFZTMXFUT3dOUkw5eG5HbVF1?=
 =?utf-8?B?WVFJMnVKV0VVVXdJNS9FTS9Xdk1DZzFMc1p5cTFveEFvbWppckZLWU1YbC9R?=
 =?utf-8?B?ZFpBVytXZGdjTGdKaE50UEJNUE95SXF0Y1VET3N4bGRPMlJrK1l5Z3pyWkFQ?=
 =?utf-8?B?RFlFOWRRL2ZvWEVEVmNkeGkwQVJzRjVDTm5nU2tWamJhTjVSOVZxbG45dUs3?=
 =?utf-8?Q?vbutZJBw+197eHwZU61weh29p?=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: IA3PR11MB9136.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: b6512f7a-1127-4652-d30a-08dde090f5fb
X-MS-Exchange-CrossTenant-originalarrivaltime: 21 Aug 2025 08:58:56.2992 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 1U6DpJJ18s6vFAR0+y/Rw1ladjfOBq1tQBGaoyKuuAUI/9ek9/PWe/CxA04pwicpN0i/VjxHNoaltmiO67whm2S9JefGylwsIcKd87RiYI0=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH3PR11MB8382
X-OriginatorOrg: intel.com
Received-SPF: pass client-ip=192.198.163.9;
 envelope-from=zhenzhong.duan@intel.com; helo=mgamail.intel.com
X-Spam_score_int: -43
X-Spam_score: -4.4
X-Spam_bar: ----
X-Spam_report: (-4.4 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
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

SGkgRXJpYywgWWksDQoNCj4tLS0tLU9yaWdpbmFsIE1lc3NhZ2UtLS0tLQ0KPkZyb206IEVyaWMg
QXVnZXIgPGVyaWMuYXVnZXJAcmVkaGF0LmNvbT4NCj5TdWJqZWN0OiBSZTogW1BBVENIIHY0IDAw
LzIwXSBpbnRlbF9pb21tdTogRW5hYmxlIHN0YWdlLTEgdHJhbnNsYXRpb24gZm9yDQo+cGFzc3Ro
cm91Z2ggZGV2aWNlDQo+DQo+DQo+DQo+T24gOC8yMS8yNSAxMDo1MCBBTSwgWWkgTGl1IHdyb3Rl
Og0KPj4gT24gMjAyNS84LzIxIDE1OjE5LCBEdWFuLCBaaGVuemhvbmcgd3JvdGU6DQo+Pj4gS2lu
ZGx5IHBpbmcsIGFueSBtb3JlIGNvbW1lbnRzPw0KPj4NCj4+IERvIHlvdSBoYXZlIGVub3VnaCBj
b21tZW50cyBmb3IgYSBuZXcgdmVyc2lvbi4gSSBwbGFuIHRvIGhhdmUgYSBsb29rDQo+PiBlaXRo
ZXIgdGhpcyB2ZXJzaW9uIG9yIGEgbmV3IHZlcnNpb24gbmV4dCB3ZWVrLiA6KQ0KPnNhbWUgZm9y
IG1lIDstKQ0KDQpJJ2xsIHNlbmQgdjUgcGVyIE1pY2hhZWwncyBzdWdnZXN0aW9uIGJ5IGVuZCBv
ZiB0aGlzIHdlZWsuDQoNClRoYW5rcw0KWmhlbnpob25nDQo=

