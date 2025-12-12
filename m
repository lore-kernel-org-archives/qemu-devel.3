Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id EC8EFD43366
	for <qemu-devel@archiver.kernel.org>; Fri, 12 Dec 2025 02:30:47 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vTsv0-0001ZX-60; Thu, 11 Dec 2025 21:30:07 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <zhenzhong.duan@intel.com>)
 id 1vTsup-0001XA-6M
 for qemu-devel@nongnu.org; Thu, 11 Dec 2025 21:29:55 -0500
Received: from mgamail.intel.com ([192.198.163.13])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <zhenzhong.duan@intel.com>)
 id 1vTsuj-0001kI-1u
 for qemu-devel@nongnu.org; Thu, 11 Dec 2025 21:29:54 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1765506589; x=1797042589;
 h=from:to:cc:subject:date:message-id:references:
 in-reply-to:content-transfer-encoding:mime-version;
 bh=4F4BHgqRFYL437vJfVe3HN4fjH0EVXnKYHbXBJX3aJM=;
 b=OX22kr83CFq3LCRs9xQbRmRmraxKKZBWjMCrJUalFwlJLQ9zrUqN4iCq
 Wh0ZqGu8yBJtnudknvyfgh7UTTAS3FIrncE1Wzpuws0Z9mt1Cm55yAH1O
 4Bzr2w2vT7IUBRUnZsg0Kt6WkVmVYcQkv0LXylJOpTKPN/z6I70+NngVY
 ZrD4dM/9B+eplAf7OQ7kh9rnM+RCFHTt43/WrF3gL3vTYIE7e7v7PIuu1
 t7CCbzTapwqi/gXmk5ca0KdsnIgz5dhIMxoHxhzTwM7avduPQUrQCo6W1
 kuBGUkAE+au2rhXjSeklYqm5aKJGXRBnLFLM4jwTdaqOtjtj96rWgO8mm w==;
X-CSE-ConnectionGUID: Ec0Vzy9TQc+RLylDBkMsVw==
X-CSE-MsgGUID: XQBQ7qgPS9i0OaZXosJTAg==
X-IronPort-AV: E=McAfee;i="6800,10657,11639"; a="70078549"
X-IronPort-AV: E=Sophos;i="6.21,141,1763452800"; d="scan'208";a="70078549"
Received: from orviesa001.jf.intel.com ([10.64.159.141])
 by fmvoesa107.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 11 Dec 2025 18:29:45 -0800
X-CSE-ConnectionGUID: BJEtHXrxRAGV+zQePJ7GrQ==
X-CSE-MsgGUID: mUhkYL0KTvC1ahq1faqgeQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.21,141,1763452800"; d="scan'208";a="234351626"
Received: from orsmsx903.amr.corp.intel.com ([10.22.229.25])
 by orviesa001.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 11 Dec 2025 18:29:46 -0800
Received: from ORSMSX903.amr.corp.intel.com (10.22.229.25) by
 ORSMSX903.amr.corp.intel.com (10.22.229.25) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.29; Thu, 11 Dec 2025 18:29:44 -0800
Received: from ORSEDG903.ED.cps.intel.com (10.7.248.13) by
 ORSMSX903.amr.corp.intel.com (10.22.229.25) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.29 via Frontend Transport; Thu, 11 Dec 2025 18:29:44 -0800
Received: from SA9PR02CU001.outbound.protection.outlook.com (40.93.196.67) by
 edgegateway.intel.com (134.134.137.113) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.29; Thu, 11 Dec 2025 18:29:44 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=Bp2Mvdj18gloMOJB2JCPco4qEBkafo7SJuplVG0b0ADChueI2ahmPGfR8CiC8XKpI8W6pNvwa3lH/vXS08ZRaSHYM9POLWXdBN2zusFzlkFBXReKrP15rmS4RUDUfP6oPq8PQnNQvC4mxmrfAsoDB6PfJRUftmBLuX0DO4U/e0XIR+NzFVDAfNbKtTETGn4r2MB2DkvGx9GivEOoaoEEqWTZfTX6RMxwI8QEyF8VMBVY50Iww80o4ZzgajMLTh6lWVEgEcViVUY/+Que+CokZjiZqjO28/uJtjSAjnjt/GWtVlrPjx85jDSk1ddFEj73wUPWcj0gxNAvLvj2VU7ifw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=4F4BHgqRFYL437vJfVe3HN4fjH0EVXnKYHbXBJX3aJM=;
 b=qpOy7Q+9TJ2fRPN8b1CRpDrH41mBPc1P1+6jTnAl9qfTzsmY3EigEBYvPdRl/mYNSyeKbdoyKRxb8pI82/oyg3QSnQD2lVSrPTqIo3/wj7HjcWzGskw83A6w0cFl4pKZxc65Wmf66uDjdkjaL5lvt3MO8whHpVQ4XtNW6RPcECeCAa0LHAIv2Z6SFzAcOhUnOr7YplI77UTHfvm54QtinAAZ+G15kWLdHwFUomWfRlIH7MOPi4gvpgXk6GqC3HdFLK73r6fJjASvWNm2eoSpWid2BmxDM4yCGVCw+9UwMsLK/2qPc8XExaiRMBGqatQAGdE/qZoPKsNUNJxPg6crCw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Received: from IA3PR11MB9136.namprd11.prod.outlook.com (2603:10b6:208:574::12)
 by PH7PR11MB7098.namprd11.prod.outlook.com (2603:10b6:510:20d::11)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9412.9; Fri, 12 Dec
 2025 02:29:35 +0000
Received: from IA3PR11MB9136.namprd11.prod.outlook.com
 ([fe80::604b:77a4:b1be:3f13]) by IA3PR11MB9136.namprd11.prod.outlook.com
 ([fe80::604b:77a4:b1be:3f13%7]) with mapi id 15.20.9412.005; Fri, 12 Dec 2025
 02:29:35 +0000
From: "Duan, Zhenzhong" <zhenzhong.duan@intel.com>
To: "eric.auger@redhat.com" <eric.auger@redhat.com>, "qemu-devel@nongnu.org"
 <qemu-devel@nongnu.org>
CC: "alex@shazbot.org" <alex@shazbot.org>, "clg@redhat.com" <clg@redhat.com>, 
 "mst@redhat.com" <mst@redhat.com>, "jasowang@redhat.com"
 <jasowang@redhat.com>, "peterx@redhat.com" <peterx@redhat.com>,
 "ddutile@redhat.com" <ddutile@redhat.com>, "jgg@nvidia.com" <jgg@nvidia.com>, 
 "nicolinc@nvidia.com" <nicolinc@nvidia.com>, "skolothumtho@nvidia.com"
 <skolothumtho@nvidia.com>, "joao.m.martins@oracle.com"
 <joao.m.martins@oracle.com>, "clement.mathieu--drif@eviden.com"
 <clement.mathieu--drif@eviden.com>, "Tian, Kevin" <kevin.tian@intel.com>,
 "Liu, Yi L" <yi.l.liu@intel.com>, "Peng, Chao P" <chao.p.peng@intel.com>
Subject: RE: [PATCH v8 09/23] intel_iommu_accel: Check for compatibility with
 IOMMUFD backed device when x-flts=on
Thread-Topic: [PATCH v8 09/23] intel_iommu_accel: Check for compatibility with
 IOMMUFD backed device when x-flts=on
Thread-Index: AQHcV6YKforrUDQa4EmwlqHgD985s7UbCwQAgAELprCAABQZgIABQPAg
Date: Fri, 12 Dec 2025 02:29:35 +0000
Message-ID: <IA3PR11MB91361B5893305C53B53E945F92AEA@IA3PR11MB9136.namprd11.prod.outlook.com>
References: <20251117093729.1121324-1-zhenzhong.duan@intel.com>
 <20251117093729.1121324-10-zhenzhong.duan@intel.com>
 <52074045-fe32-4fbf-b8a3-5037438649f7@redhat.com>
 <IA3PR11MB9136A94E3A6B29A2F35D57EA92A1A@IA3PR11MB9136.namprd11.prod.outlook.com>
 <ef46c714-28f6-413c-9270-6119a92a2849@redhat.com>
In-Reply-To: <ef46c714-28f6-413c-9270-6119a92a2849@redhat.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: IA3PR11MB9136:EE_|PH7PR11MB7098:EE_
x-ms-office365-filtering-correlation-id: 750b2a59-4556-451b-7aaf-08de39264a75
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
 ARA:13230040|376014|366016|7416014|1800799024|38070700021; 
x-microsoft-antispam-message-info: =?utf-8?B?U2xVbzBFNFZ4MW1TUmcyK1hKSGpwdlorOTQ3dUNRdCttZEVtaUQyQTFyMHpW?=
 =?utf-8?B?SUEzOU9ONXUybFFSeWVaWXhVRXU5Kys1Wm5kTklmejdLUG9NSVRuVy9pc09l?=
 =?utf-8?B?K0xZQTJUdDNTV3RMUXdpL3VVOUZDVmZna1lhUmtNNFNPNTRiRVRHcE5kWHNu?=
 =?utf-8?B?c0w4dEpwQmtCZ1UwSVhaUFdEb2lVcjJqcC83RnFtMHdGSVQzTzBhNkZ3dzNx?=
 =?utf-8?B?a3FhS0xrOFJsRk45RVUzNkRIUlJ1YUtxazFRNTRkU29WTnpoZi9tQmtQWlEz?=
 =?utf-8?B?ZEVXd1hBbGJONU9pOExLeUdnNzUrUFJITG1SQmRPN3U4azVia1VtRXJlaklW?=
 =?utf-8?B?WS9telNqcVFIZ0phd3FYZU55aTlNRURWelVIM1U1Y3JSN25xUDJFSlg5UE85?=
 =?utf-8?B?SG94ajZ1ZDZoMmJNdit5YkJ5SmNxWHorY2FqaXFQTzlBTjdVRUtUYkF2UjlL?=
 =?utf-8?B?SW1ZWXBxMzdvclA5dUIvNTJqQWZvNHgvZlg0WDJwOW9IdU1QRVVsb2lKSFQ4?=
 =?utf-8?B?OVo0ZFlGL0Y3WEd4Qzg1UkMyYWhmMG1YZElpRWlGa3NTQnZ2OG5yMndYOEFn?=
 =?utf-8?B?dDhFaEtmbXZCWjRQUnBTanNMNFJKS29PbVNZQTBuMXN3V3dHVGV3TWZGWWUx?=
 =?utf-8?B?WVF1MW83TktWM2Z0SzhWZ3FNeGNob09EUlRyYm11TlVXM3kwTFJjVDdZQk9k?=
 =?utf-8?B?L0FHRUxYMGtydTRhd3JyVi9PYWZsTXNtUi9VcWRMQUFmNzRDNDBuY2cyT2J0?=
 =?utf-8?B?MC83ekFtbW0yK3NlUm05QzFETS9XTTh5WWJRMnZ0emhrM3ErN1NOODUzWEts?=
 =?utf-8?B?YjF3S3lONm1EV1BieHdxRWpMV3lFTXhyVEkvT1NKb05UZ29LN0ZTZVpiOGs2?=
 =?utf-8?B?ZWZqb2FYOURMeHVuRElKejR1WE1aV2tBVTE2SnZ6dGxZQzNNRUhHQzBSeWhJ?=
 =?utf-8?B?WlpxdVlYY2x2VVh0MFRENjgrRFlqQlJtWkI3cXQ3TGk5Z2kvV085MWFQR3Vr?=
 =?utf-8?B?eUJ5M2gyNGt0QndERmhob3p5ZVRZdFZ6bWp2Q0ZVTHBIZlJ4RTFkRlNFeXZ1?=
 =?utf-8?B?M1kzY0VPcm83aythSkppbE5tNHdsZW1peWs5bWxLQmdFRlZ0WUZIKzQ0aGR0?=
 =?utf-8?B?c3pMakkyRUZIUHFvSy80R1JPNWgxNVRXT3RrcEpqdXQ4bGNvb1p3eEN4emo3?=
 =?utf-8?B?SWJTVWZRQUtPMWc3eEFCV2Y5Umw2RkZNMGY4alhqSDBhQkZoaXZQOWh2cks5?=
 =?utf-8?B?bmkvenlkVFIzRkVRWHdRMVJwdWR4QkVJOTMzUnViTEhNQWc2MndpVnpOSXRa?=
 =?utf-8?B?WjlnL0M5anNmSDlJOEpkcXVqYXNOdmExZWljOEJMcUlKN3pCRlNaRkh4WXRM?=
 =?utf-8?B?d2NQUWFrV2s0Y3BMM0YvNHdlM016QXdFTVgwQnBycy9iWldzSXRmRHJjSUEy?=
 =?utf-8?B?Z09VQzFEWloxanhEZ0N5T0k2QUthTzNFRzg3UmUvd0twc29LYWpOMCsyRGdT?=
 =?utf-8?B?ZlE5bFQ1a3V5cWp6MDBBZjdRNDR2TFVxWXpIL0VUWjEwK3hiMUpyU0pvWUNn?=
 =?utf-8?B?Y2RTVXJqc0lTd2E1RjFpeGs0bHV1OWpZU3I0U2s2NG1kQWIyTUNGYWVGbkln?=
 =?utf-8?B?bEJvVitUa3lsOFpVZTdXUytDaE44TDVVSEM3YlJudXZMNVR6YzBuWnNHUjFY?=
 =?utf-8?B?QnR5Ri8zempnVHVtKzNtbTJMY1lGNmRJbVdBODNUeGFGdkczbWdHc0QyYW51?=
 =?utf-8?B?anRrMjhMK0JwYnZ3UUl3WGRySERDODRyTnA5b2w5eVJVK1NvY0FuU1E5bm5k?=
 =?utf-8?B?eDd1NFBLcEdyUkNXR2pmamVXd2VDQWhYMTk4ODlLb1ROdFBlejJxMTJ3dGdY?=
 =?utf-8?B?d1NGdlczVTJSZytWR2pQaGVvNGI4a1dVOVRoRkpEVFVyTFpZdlhiTWFhQ05I?=
 =?utf-8?B?ZHdrdUJRTzlZMFVPTExUZCtMNnhGeHlQM1A0MVN4R2tNaEEwZmRqQ3RJdVhr?=
 =?utf-8?B?aEJORFNONjljdC8xVUdDNUYxLzVUelNPeEJvVTdFNWdpVEpYdDlVV09qWi9M?=
 =?utf-8?Q?I6W0jl?=
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:IA3PR11MB9136.namprd11.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(376014)(366016)(7416014)(1800799024)(38070700021); DIR:OUT;
 SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?R1Q4VEFnM001NW5SNVlxSmFDWk0xOTlDOU5sZHZWN3E2THY0bXY1Q0dHTml6?=
 =?utf-8?B?dkF5VVlqRmg5U3h0NVk1VVFGakJYZE9CcGduWGkyRU4wWDZ4Z3lEVHUvZzli?=
 =?utf-8?B?VGRjTmE2ZHEzSUthMlNKemd2dXgzZHdNNjdXdjdPa0xuVGdLUllKbXZKZzVt?=
 =?utf-8?B?UytPV3BWSW5EQThDem5NWGpsQ3pORWd4dXR2aXJDMXB0SmUzOUJaT1h2Y3h4?=
 =?utf-8?B?VkZHZ2I3L1FwL1hHRFcreUVHQWpMUU9lQ0NIN1B3SUdqbnMyVzg3TllmdGJC?=
 =?utf-8?B?WDRsL2dqWXUzRmIwQ1RmNzJuSGN4c1A3VG5TMkV5N0VMbndiYjNoc1N6Zlpk?=
 =?utf-8?B?R3RsMGZiK2dPbUswWUJmcksxK3JLYUJ2bFdtSDNjZTJ0WTBJRlprZjVxUzdX?=
 =?utf-8?B?bVJ1ZzhFRVNHak5HMTBIc3ZwWTk4M0o5TU5ORUo2aTlHekwxeVMrR2ZFLzJm?=
 =?utf-8?B?LytrSFh1eUdSZFBhSzVnVHJkZzFwVzF4Q29HL0RoSDM1R0pvcHlTb2FRSVQ5?=
 =?utf-8?B?VGNDTm5BRHhvOEJaVmdZUVY5TmFWOUJQWTl5WmVrWU9qNDNheml5TnJZRTdB?=
 =?utf-8?B?ZUxMbW1Lb1F4K05KVVc1OGczN3FsOGFIcEc0QWhKU20yaDd4MWFqTElJYW9u?=
 =?utf-8?B?UUJEM0VOUU50TWxhSDZ0NUpZYnVUS05WaGVxT3ZjQXUzWXRqN1AyUWhHTEYw?=
 =?utf-8?B?NmYxUlZIK2xKcnBJMjJGR243YnNJN2dObVZrRDBrL0VBMXAvbDQwY2VWN2s0?=
 =?utf-8?B?Z1liQjJ4WnNpWXIvY2JUME5ZNDd6YUNsS1JwZDJEaVd5UzkwWEtBaXFWa0JV?=
 =?utf-8?B?MlJGeHYyRXhuZlJzdlg4TkIzVVNZYlo0SnF6ankrMzlkTlRQWm8yMWdFVDU0?=
 =?utf-8?B?eUcvLzNYUFFyUEtSWkZzdzZPSlgzdjFiTFUyaC90cHlQZ0Y3Tlc4cysxb3RQ?=
 =?utf-8?B?UlRvaXg3OEFEQ3ZkbFJCcnZ6Q1kzOGg2czBsUC9yeHUyNDlYYWRrMmNtbXFm?=
 =?utf-8?B?d2RCUVJIV2xjM3F6MEJOM2YzNXFrbEJXU3plbCtQVXhvRVl6a1E3eGt0L3d0?=
 =?utf-8?B?bFAwZUVJVmNTN3NRd1EyZi83NExwaDlXN1AwMVhNZmhxbW8vbHcxRXZJUFVp?=
 =?utf-8?B?QmZXUHorRWhpN0VsTVVMMFlWVXpiL3ZhV3BUMzl2aWhiZ3Y1K1pmNlc2ME43?=
 =?utf-8?B?aEcza2ovNnJoSi9VQVVFU0FzaE91Z2Erb1lsekV1N1h5S0NtYVI4dW5WVnJR?=
 =?utf-8?B?V2NJTnNsUkpEVWYvYkFhdWlVM25zdDNUT0xpM2xXS2NMWXkrN0JxMTJOSFI3?=
 =?utf-8?B?NDRLMUlNSTAyOUZzeG83OWMvNU1UMVNvcHlHVnNrWkRTbm9jN1JjRzBrSWZH?=
 =?utf-8?B?ajhHZUs1UEJSMG5KanZJKzZBaEpmUW1TN2hpZ2pHWWNkc2RhdVd2T1hxcUN2?=
 =?utf-8?B?Nm93Y2dTNzVIc0N3WTJXSGI1bWVwNDRFbWttbjcvOVh4Tk9DazZydDEyb1hn?=
 =?utf-8?B?bUR0ZnJGejhjaDBRSVI5MkpNbFBYaU5CQUZPejV5RjA4OTMyNmpQSEREVW5q?=
 =?utf-8?B?RmFhV2t5SkxPcVROTnV2RFR3V2ZvR2w5ZjlTU1F3Tjg4MHI1MklrZEk1b0ho?=
 =?utf-8?B?SE02WDNDdkduVEVJNnZrMzk5dEtlMU85czVEL0hZeXFLRlpqYTJMTStqTHFS?=
 =?utf-8?B?aXpwZ2JyOGFyZGtUWVY0MGdMN0ZJUWprb0FpbDg2MTIxZVhSQXZleVZoVkpQ?=
 =?utf-8?B?czBtTWZRKzhYN1BsRjhKQXErWENMUjBNYUVzdFRkbGJEbGhDUVVqTHY5TWZU?=
 =?utf-8?B?cVlaUXJ4NnZJMmlWODlyaGd6M3dNdHF0QXhRUklLbHlQVWl6UWlrQlBRSmtu?=
 =?utf-8?B?UFVyWVJ0N2RiNGx5NDJZeU1lb0FNY2hrZTlxOWROMmdLTEkrQ0RvQm5HYUpH?=
 =?utf-8?B?MVJwUFR0R28zN2txMlR4WHRDTWN5YlpQSmV1Y3JRWjdjbWJ5Y0lNdXVENnFm?=
 =?utf-8?B?V01BUDM5YTFFLzBEMHh3Y1RLSXFsNEQ4WnhCcGxNZXpJbUttUXpyK2ROdGdF?=
 =?utf-8?B?WXZ2cVMxanRsejNCcUFlS0lMaHRBMStMRlI0UGdYM2pxclBOSWxBaGJnUW1I?=
 =?utf-8?Q?o91ux337UTNZQ+yYGSlM5MHkN?=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: IA3PR11MB9136.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 750b2a59-4556-451b-7aaf-08de39264a75
X-MS-Exchange-CrossTenant-originalarrivaltime: 12 Dec 2025 02:29:35.2639 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: pCYSj3iDMS59kKZg/CCuawfz7apTVeCx7tszK0IJzlSaBrK9fKWL+Csncbctk60PFkVDkL7up7Mxg6/eb0hcPOAerw5kcLXf6I/b7hlmBrs=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH7PR11MB7098
X-OriginatorOrg: intel.com
Received-SPF: pass client-ip=192.198.163.13;
 envelope-from=zhenzhong.duan@intel.com; helo=mgamail.intel.com
X-Spam_score_int: -43
X-Spam_score: -4.4
X-Spam_bar: ----
X-Spam_report: (-4.4 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_MED=-2.3, RCVD_IN_MSPIKE_H2=0.001,
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

DQoNCj4tLS0tLU9yaWdpbmFsIE1lc3NhZ2UtLS0tLQ0KPkZyb206IEVyaWMgQXVnZXIgPGVyaWMu
YXVnZXJAcmVkaGF0LmNvbT4NCj4+Pj4gZGlmZiAtLWdpdCBhL2h3L2kzODYvbWVzb24uYnVpbGQg
Yi9ody9pMzg2L21lc29uLmJ1aWxkDQo+Pj4+IGluZGV4IDQzNmIzY2U1MmQuLjYzYWU1N2JhYTUg
MTAwNjQ0DQo+Pj4+IC0tLSBhL2h3L2kzODYvbWVzb24uYnVpbGQNCj4+Pj4gKysrIGIvaHcvaTM4
Ni9tZXNvbi5idWlsZA0KPj4+PiBAQCAtMjEsNiArMjEsNyBAQCBpMzg2X3NzLmFkZCh3aGVuOiAn
Q09ORklHX1EzNScsIGlmX3RydWU6DQo+Pj4gZmlsZXMoJ3BjX3EzNS5jJykpDQo+Pj4+ICBpMzg2
X3NzLmFkZCh3aGVuOiAnQ09ORklHX1ZNTU9VU0UnLCBpZl90cnVlOiBmaWxlcygndm1tb3VzZS5j
JykpDQo+Pj4+ICBpMzg2X3NzLmFkZCh3aGVuOiAnQ09ORklHX1ZNUE9SVCcsIGlmX3RydWU6IGZp
bGVzKCd2bXBvcnQuYycpKQ0KPj4+PiAgaTM4Nl9zcy5hZGQod2hlbjogJ0NPTkZJR19WVEQnLCBp
Zl90cnVlOiBmaWxlcygnaW50ZWxfaW9tbXUuYycpKQ0KPj4+PiAraTM4Nl9zcy5hZGQod2hlbjog
J0NPTkZJR19WVERfQUNDRUwnLCBpZl90cnVlOg0KPj4+IGZpbGVzKCdpbnRlbF9pb21tdV9hY2Nl
bC5jJykpDQo+Pj4+ICBpMzg2X3NzLmFkZCh3aGVuOiAnQ09ORklHX1NHWCcsIGlmX3RydWU6IGZp
bGVzKCdzZ3gtZXBjLmMnLCdzZ3guYycpLA0KPj4+PiAgICAgICAgICAgICAgICAgICAgICAgICAg
ICAgICAgICBpZl9mYWxzZTogZmlsZXMoJ3NneC1zdHViLmMnKSkNCj4+Pj4NCj4+PiB3cnQgY29t
bWVudHMgbWFkZSBieSBDw6lkcmljIGluDQo+Pj4NCj5odHRwczovL2xvcmUua2VybmVsLm9yZy9h
bGwvSUEzUFIxMU1COTEzNkIxM0MwQzQ4RUYyOTNEM0I1OTlEOTJGQUFADQo+Pj4gSUEzUFIxMU1C
OTEzNi5uYW1wcmQxMS5wcm9kLm91dGxvb2suY29tLw0KPj4+IEkgc2VlIHlvdSBrZXB0IHRoZSBv
cmlnaW5hbCBhcHByb2FjaC4gSSBoYXZlIG5vIHN0cm9uZyBvcGluaW9uIG9uIHRoYXQuDQo+Pj4g
SSBsZXQgQ8OpZHJpYydzIGNvbW1lbnQgaWYgaGUgc3Ryb25nbHkgZGlzYWdyZWVzLg0KPj4gR3Vl
c3MgeW91IG1lYW4gYWRkaW5nICcjaW5jbHVkZSBDT05GSUdfREVWSUNFUyc/DQo+PiBJIGFkZGVk
IGl0IGluIGh3L2kzODYvaW50ZWxfaW9tbXVfYWNjZWwuaCwgc2VlIGFib3ZlLiBUaGVyZSBpcyBy
ZWZlcmVuY2UgdG8NCj4+IENPTkZJR19WVERfQUNDRUwgaW4gaW50ZWxfaW9tbXVfYWNjZWwuaCwg
SSB0aG91Z2h0IGl0J3MgYmV0dGVyIHRvIGFkZCBpdA0KPj4gdGhlcmUgaW5zdGVhZCBvZiBpbnRl
bF9pb21tdV9hY2NlbC5jDQo+DQo+Tm8gSSByYXRoZXIgbWVhbnQgQ8OpZHJpYydzIGNvbW1lbnQg
b24gZXh0ZW5kaW5nIEhvc3RJT01NVURldmljZUNsYXNzDQo+aW5zdGVhZCBvZiB1c2luZyBpb21t
dWZkIGRpcmVjdGx5IEVyaWMNCg0KSSBoYWQgZGlnZ2VkIEPDqWRyaWMncyBzdWdnZXN0aW9uLCBj
dXJyZW50bHkgSU9NTVVGRCBpcyB0aGUgb25seSBmcmVzaCBuZXcNCmFjY2VsIHJlbGF0ZWQgSU9N
TVUgYmFja2VuZC4gSSBmZWVsIGhhcmQgdG8gZm9yZXNlZSB3aGF0IGEgbmV3IGFjY2VsDQpiYWNr
ZW5kIGUuZywgSU9NTVVGRF92MiB3aWxsIGJlIGxpa2UsIHdoYXQgYSBjb21tb24gYWJzdHJhY3Qg
dG8gbWFrZQ0KYmV0d2VlbiB0aGVtLCBqdXN0IGxpa2UgdGhlIGJpZyBkaWZmZXJlbmNlIGJldHdl
ZW4gbGVnYWN5IFZGSU8gYW5kIElPTU1VRkQNCmJhY2tlbmQuIEkgdGhpbmsgd2UgY2FuIGFkZCB0
aGUgYWJzdHJhY3QgbGF5ZXIgd2hlbiBJT01NVUZEX3YyIGNvbWVzIGluDQp0aGUgZnV0dXJlLCBp
ZiBDw6lkcmljIGFncmVlcy4NCg0KVGhhbmtzDQpaaGVuemhvbmcNCg==

