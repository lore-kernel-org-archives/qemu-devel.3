Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5B1B1CA1002
	for <qemu-devel@archiver.kernel.org>; Mon,  1 Sep 2025 09:10:46 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1ut0WI-0002PR-Jv; Mon, 01 Sep 2025 05:08:10 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <zhenzhong.duan@intel.com>)
 id 1ut0Tm-0000IG-Qt
 for qemu-devel@nongnu.org; Mon, 01 Sep 2025 05:05:38 -0400
Received: from mgamail.intel.com ([192.198.163.9])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <zhenzhong.duan@intel.com>)
 id 1ut0Tj-0006Ox-Gz
 for qemu-devel@nongnu.org; Mon, 01 Sep 2025 05:05:34 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1756717532; x=1788253532;
 h=from:to:cc:subject:date:message-id:references:
 in-reply-to:content-transfer-encoding:mime-version;
 bh=B0fdRZyCNHE6fB5kFO6GXVHs2QLUm0XSA192KP0FHXQ=;
 b=hGywDsfq9xREBQ55ZWQEpxotIoXb1Rto7JB2WAw6+H/ntAHTwEZK5ClC
 RSqWx43LDdEQEvhTmD58utPDjQkOrxdp2EFzeaXZR5r0Qgnpq3ZI4y6BE
 yvl3AJ7LBxE/EEUj9yWLtZ94Dmuu9HCWLaohX7jt8qhB+1+3h62Yzt0l7
 iPwuViLniDgVXZUTK5G32y0XEVztIRDybbpRVwlt7PgKeP5GFP2JdYK/z
 cbO2CNEPN9GmCCmDWE+2gxH2Zs/GVmTNJARTLk5KVdFI82Fphfr1nbFzr
 RfXBFa8OpljjKMHoQeiI3DNDBj8YEKSOQBNVn82mRCsMb40X6D+8Ko/1L w==;
X-CSE-ConnectionGUID: sgX7aR0yTciZQ5mmInwP/A==
X-CSE-MsgGUID: 1raynYWBRV+byrWI11iFVg==
X-IronPort-AV: E=McAfee;i="6800,10657,11539"; a="69676022"
X-IronPort-AV: E=Sophos;i="6.18,225,1751266800"; d="scan'208";a="69676022"
Received: from fmviesa007.fm.intel.com ([10.60.135.147])
 by fmvoesa103.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 01 Sep 2025 02:05:06 -0700
X-CSE-ConnectionGUID: NYsKVSOISJmTuH7+4lDVSA==
X-CSE-MsgGUID: l16acfHoQ5O0T4IjTaOc/w==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.18,225,1751266800"; d="scan'208";a="170514660"
Received: from orsmsx903.amr.corp.intel.com ([10.22.229.25])
 by fmviesa007.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 01 Sep 2025 02:05:06 -0700
Received: from ORSMSX903.amr.corp.intel.com (10.22.229.25) by
 ORSMSX903.amr.corp.intel.com (10.22.229.25) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.17; Mon, 1 Sep 2025 02:05:05 -0700
Received: from ORSEDG903.ED.cps.intel.com (10.7.248.13) by
 ORSMSX903.amr.corp.intel.com (10.22.229.25) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.17 via Frontend Transport; Mon, 1 Sep 2025 02:05:05 -0700
Received: from NAM02-BN1-obe.outbound.protection.outlook.com (40.107.212.71)
 by edgegateway.intel.com (134.134.137.113) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.17; Mon, 1 Sep 2025 02:05:04 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=cXuCEyW+vhNvQIFuGO0fSNpUolW9CRjelttjD18SbOthM/MLOhVUIVF3H9+uSjgZNeRQvplHRJZHuCMQa2qT+kNYYwjfvi6o6A1qLg69JgmiXEWudc09p/Okkqba/GCEyFwFSVyWEFSqDxx/S+srxyFS5tW2EBkkZj942kzeXc7AZ6OdAXjHYw2Kms2iFRHAYvybIkzXs81fOgJqFUpd4+oeLdsf7pymnKDTj8fsimyj2LqONgQK9abNnCJV8MSV8U98OT4XvDayMVdyr6pZGWcGY3kkhMzM9FCkEc/i1Fa3E39xCYb5d+amzz+E8bXLI/KgVcTUypz29N56Awn7mA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=B0fdRZyCNHE6fB5kFO6GXVHs2QLUm0XSA192KP0FHXQ=;
 b=vLI/p25TwftNTTJObVJZKWLlVoLaQ0bTDZwo7KhyjsIcBvP+LKoiTHi7tQrsaISgoLdeakjAMoRKCbR6lpcv8fISD3sD5ywc9/f90PfL5jU7Fbgrhad/OVy723aCgC9mOHuKSRf0S1SkUC/twka/Hh9QXzPXax+74aDoG2uudzPds3IK/hb36YrDIplo7VII1+BIwbH6MDP3vPnu2UfxHrpJIEFiaq9l9tkdCzS2ZjwB9cS6IFAnROj0ASlyXhD6ezR94vkhRgoSUsnQq+6LpaQG1O2XHslRZwDUC31LBsf3q+biJsF+adEu1q4BeNPxJFzHMi2vO3yWZDx0JN0H7Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Received: from IA3PR11MB9136.namprd11.prod.outlook.com (2603:10b6:208:574::12)
 by BL1PR11MB5255.namprd11.prod.outlook.com (2603:10b6:208:31a::9)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9052.19; Mon, 1 Sep
 2025 09:04:57 +0000
Received: from IA3PR11MB9136.namprd11.prod.outlook.com
 ([fe80::604b:77a4:b1be:3f13]) by IA3PR11MB9136.namprd11.prod.outlook.com
 ([fe80::604b:77a4:b1be:3f13%4]) with mapi id 15.20.9052.019; Mon, 1 Sep 2025
 09:04:57 +0000
From: "Duan, Zhenzhong" <zhenzhong.duan@intel.com>
To: "eric.auger@redhat.com" <eric.auger@redhat.com>, "qemu-devel@nongnu.org"
 <qemu-devel@nongnu.org>
CC: "alex.williamson@redhat.com" <alex.williamson@redhat.com>,
 "clg@redhat.com" <clg@redhat.com>, "mst@redhat.com" <mst@redhat.com>,
 "jasowang@redhat.com" <jasowang@redhat.com>, "peterx@redhat.com"
 <peterx@redhat.com>, "ddutile@redhat.com" <ddutile@redhat.com>,
 "jgg@nvidia.com" <jgg@nvidia.com>, "nicolinc@nvidia.com"
 <nicolinc@nvidia.com>, "joao.m.martins@oracle.com"
 <joao.m.martins@oracle.com>, "clement.mathieu--drif@eviden.com"
 <clement.mathieu--drif@eviden.com>, "Tian, Kevin" <kevin.tian@intel.com>,
 "Liu, Yi L" <yi.l.liu@intel.com>, "Peng, Chao P" <chao.p.peng@intel.com>, "Yi
 Sun" <yi.y.sun@linux.intel.com>
Subject: RE: [PATCH v5 13/21] intel_iommu: Introduce a new pasid cache
 invalidation type FORCE_RESET
Thread-Topic: [PATCH v5 13/21] intel_iommu: Introduce a new pasid cache
 invalidation type FORCE_RESET
Thread-Index: AQHcEy/sHzESN2PaVUaf+PZg8LLkc7R2uPqAgAdfciA=
Date: Mon, 1 Sep 2025 09:04:57 +0000
Message-ID: <IA3PR11MB9136F4D92083262040F74F8E9207A@IA3PR11MB9136.namprd11.prod.outlook.com>
References: <20250822064101.123526-1-zhenzhong.duan@intel.com>
 <20250822064101.123526-14-zhenzhong.duan@intel.com>
 <c53b7bc6-fe76-4357-9eba-56f4c3111fa9@redhat.com>
In-Reply-To: <c53b7bc6-fe76-4357-9eba-56f4c3111fa9@redhat.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: IA3PR11MB9136:EE_|BL1PR11MB5255:EE_
x-ms-office365-filtering-correlation-id: 1ba7c565-4697-4a62-9532-08dde9369f99
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
 ARA:13230040|1800799024|376014|7416014|366016|38070700018; 
x-microsoft-antispam-message-info: =?utf-8?B?MXFlci8ycWNVYmU3YmFhb0RLbnR5aEFRS2UyTHhmQlA4bEtQWlZQbUpqeVdH?=
 =?utf-8?B?U3Zjc2NETTN2akZLbEdXQUhvZmVpNnpQMzhBc2MyTmtRc1djd0txKzF5cVhu?=
 =?utf-8?B?V29MUHNIRnoydnkrRWJ0TFdVQXV3MFFCbFYrckdEUnZZejE3R085NGplZjRh?=
 =?utf-8?B?aTZJNkhRM2N4MjVUbnZjUHRLRTNOQUM5UWUvT3Jja0hGL25MM0l0OEpES0xG?=
 =?utf-8?B?RWxIUjBkRGphT1c4MnJBL0V1SmVEYm1LaGp5TkZ4QUF2KytMbUYzSVR0Wjdh?=
 =?utf-8?B?cTBRdnB5VzN1a1JBZzRKNU1EMndQdFZodWtabmxxTVVXT1VGQjJ2SFk1THFk?=
 =?utf-8?B?WWZHK1A2NUNSZkZXVnkzdXAreVpnRVNpRVE2cnR6SHo0dnAzRDh6cURGK2JR?=
 =?utf-8?B?YmdCdnJ3SWVqVktIVldBZDA2Rkp3TTRaV0g1M09HeEFKN0tFd3BDejIwck9V?=
 =?utf-8?B?UlNmNEFWYTkramd5aW1STE5PZTl6Si85aUhydVAvWjQ0U05IVVhFTnFnVlRo?=
 =?utf-8?B?WVhka1lYb0paS0lhMHZyS3pQMEtvZVRvclRTQ0pDQnZDdG5WYklFSktkOVV0?=
 =?utf-8?B?UVBBMXcwa0dMb1kxRGtYNHVUVm1zd1RZd3JZM2RLb1B6NndORWttM1N1YmNl?=
 =?utf-8?B?WEw5N1RJK1hVUVpzRnQ3Wm5yMEFGTHN1OWhVNFhyZTI5aVo3UDZIR2ZxdU40?=
 =?utf-8?B?azFiYUVqWWlwMUZlUGNaSThNVEZlMis4M3RUMWhncnpQVjdISnlmMDJZWE52?=
 =?utf-8?B?SVU0UGdjOC9yZE8yTDIrSUdFNU0xMTF5SmFiTW4zbndaMVRrWE0zU04yVE9Y?=
 =?utf-8?B?emhiRGc3L3c2Vzc3NmdWZ2d5N05XTkFsN1pBNnY0eUVkd3lNYUM1eTY3a2hS?=
 =?utf-8?B?Ym1mWDh6RnZjell5eXpuUzFtbXhLaFp4RHFtU2FaSmJzZ2dudnFrNnpJMm04?=
 =?utf-8?B?bG1GQVFNV1RZbUxFd2xaV2hQelNYWVpnTE5TK3Q1Y2FzTTdqZmRoK0JoY2tD?=
 =?utf-8?B?MHUxNSs3QXhicWFrdktaR1NsRG5zWElMMVNxWkM2bjA3TVJoZEYrcktrWnZt?=
 =?utf-8?B?R1Vqa1cxVFl5c3FzVTNmOGZMK0grTy9BNjlwYlpwbWM4bXdGRHpxbStRVExS?=
 =?utf-8?B?YlQ0ZUVoTlM1YW5GZ0lHc3JhTXo1bHVibk1QWG5kSEpSTUoxNDR5ZnZWM25z?=
 =?utf-8?B?ajA2bEhzakJCN3ZDOTREOTJTUytCcm5ERVRVM3hkdjRDTGk0bUZFY1pjR0dh?=
 =?utf-8?B?RDE5dzg5SnIwWVhHek1EYkJLK0t5dENpT0NJQlNLWWlDR1A5N3liZys0dTVr?=
 =?utf-8?B?U3M1OUtNTU1hUWFueE5yZnRGNUFXNjFQbTcyTUova2dXRjRDbTB4RFVYTHZw?=
 =?utf-8?B?YU1SdzVVKytROGF2cW1oTW5iWnQvV1VpZnlvTnJrWkh3V3I3OWR0RkNzcndF?=
 =?utf-8?B?QXF2Q3pUcjVOWkJqN1JhdUVQZzVDdGxIcTIxcHlNczhvOEV2YVpMRFJoRmZ0?=
 =?utf-8?B?Q0ZrN3g1dkNQcFJkMjlhMXFVV2hPd2lWWjJtUEoxYTI5SGQ4b29WZ1prcEY5?=
 =?utf-8?B?ZlQ2citNZlFKQzNoK2I0Z2VmOERRcGN4dHphazloSURQR1hPMFptcUtjTytH?=
 =?utf-8?B?VldtdWh1cG00cjdSWTk5MXgwMnR1RHRnR0ZhMy8xUHJyNXlUUjV5aEtScGRI?=
 =?utf-8?B?cTY4RDF3U2RXeGcxU211RERJdWMrdWVsZm5salJPOUFuQWxMRVZGOUU3enZq?=
 =?utf-8?B?MTdzS3RrVXpMRHd5Q2ZjWEM2cll4anROeTB3aENwRVNmaDRBVnBvZTErdGhv?=
 =?utf-8?B?Y1Y0QlFjQnliYmdPQ2FEd0pEeEZoYmtTK1pobmlqbXcwTHV0dmFvMmZYRk5j?=
 =?utf-8?B?dUVkbnZweE9jRkNMNVc1T3NCN1dicEJQUHFhSVhzN0hZVkNuTlpDY1lWSDd2?=
 =?utf-8?B?WjZqVkw5UkJXVnZTK3NHV0VzWk5ldzBxT2huZWd1MjVKeWxMMFlJN2hYQk1m?=
 =?utf-8?Q?oMxnXKyO/9pKQMslonnoi/oa3QpJm0=3D?=
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:IA3PR11MB9136.namprd11.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(1800799024)(376014)(7416014)(366016)(38070700018); DIR:OUT;
 SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?WitXd1lVZm9HdVJ6R2gzR2hpMkFjWXNuREJNMEdITEVYSDFSRUQwRXJpSTd1?=
 =?utf-8?B?VkhzdW11c3pHR3FkbExJRjQyYjZMalJGbjFVQm92Nlgzc3MwSDhaRlJmUEVL?=
 =?utf-8?B?MTJEL1VXaFgvRlpnTUV6TVNWcTFaTytYYTdGMWJsaThVSHpJcHhnTGI3cy9N?=
 =?utf-8?B?eVN5WENBb3VUM1ptcTRCYU5KTnpSRER2L0xxSVM1Q01kMk91RitndEdJeWl6?=
 =?utf-8?B?cVRobHRQbkx0blE5ZlVWT0s1Y0NyWHhWeXFKa3VjUXZyM0thdFBlR3NFUHdX?=
 =?utf-8?B?Y3pHdkQ5TEtQTWgranptaWFVek1udmNiK3dCWU50RWlEL2VnYURFR2Z5K0pa?=
 =?utf-8?B?QjJyeGtPOGRZS3ZCL01UdDZObjlaZWlEZkxIbnE4UUE3UXNkZEhtMVcybGph?=
 =?utf-8?B?Z2VJcFMrKzhvVUQvalZCcHV5UHl3RCtlQXZDQkpUU3FKVGhSREdUeXRFQklE?=
 =?utf-8?B?aDdQNnlPc0I1dktvUUhIazV5dWlQRzE1b2pRdzZRblp1enBrRzZpWUhMTmI2?=
 =?utf-8?B?ZHlPQklIa3RUK3ExeGtUbU5MdmJYR1FLQTZoeXp3UHFEbEdnZjF3UkZITEpz?=
 =?utf-8?B?aG4xdFNZZjZKL0JDbEl1ODdscGJIN1FQQ3pZN2lLWmNsanlJOUFzOGEzZ2dI?=
 =?utf-8?B?UTBnWFpXa2o0N3J5eTdJKzlwVTlBNkxxUzVGVGJQdHBrekd0Vit3cjYwZDBh?=
 =?utf-8?B?TlU5S3dROUJMdkdFZE94TU1SNlhFQURqRnk4MnVBbi9GbzY1NVFzaTg3N084?=
 =?utf-8?B?eG5iZ2phelY2UllLWGxBVitYUUMyanZsWjZ2NlQ4QkdKcHJHN1NoTGNld3dE?=
 =?utf-8?B?ZTExNHJ6WFg4UFp2SHkwZ3RSQ1RwNmsxRTVOcTFzVmp6eXBNQlAwbkxNMjk4?=
 =?utf-8?B?RTV0UVdLQ3YrSE1odGFzdFM3ditUV1hoRXpuOVdoYktlQThQZ2M0RkloSlht?=
 =?utf-8?B?TlYxNjFMa2JCVis0V05hQ3hlVlpPVlhybkNjTEJoSGV3bHR0TWE1L2JiYmZO?=
 =?utf-8?B?Z1hVY0NDYXZLMzhxNHB0STRjSGRDZXhFU0xFVEdYWllGa29FUVBGRkFoTFpN?=
 =?utf-8?B?NHdnYkx2QVJ2YzAzYmFIUEFsemY4ZmgxS05OUEpTczIwNlZ0YW85NmdWak1H?=
 =?utf-8?B?MmFLd213NXIrbCt4S3FMYzJJNTVzWHpTeW5TL3kzcDJRMjN6VVVWZnVMeVBa?=
 =?utf-8?B?d1dTNjZDckgzNjZUQkNsOXJlbDBvdjIvbDZWUkx1SHBpYlFPWXFxR0ExaWwx?=
 =?utf-8?B?NTRJdXlXU3JreWl6NkcvU09BMFhGNzI4MTQzaG5PVzdwamVza2t1Nkppc3Nu?=
 =?utf-8?B?dmZNM1Q3R2hmUUI3T1ZHeStzZzhDOVNOME82bFU5cEZsU2VzTEZvQ1ZSMHhX?=
 =?utf-8?B?MXkxTHc3NTI2U2dpMWh2ZGcyRlpYMk9tZEl2WGl3dWl5L01kQ28ya2QwRnhO?=
 =?utf-8?B?VmYzY0s2Z1BmVzlXaFcwR2ZpeDZRNk0yL2RoL1NGcEhwL1BCUXdWWmpLVmF4?=
 =?utf-8?B?MmhYMTVnczUxZVM1TlNsT2t3eWp1UFRrWHArME40dEZaYWJxSlFoWUdBNDFP?=
 =?utf-8?B?dWZuLzJGM1hwa1Nhc0VLUXdWUkljZGg2WVdKd2xLOHFwbzBCblREZm5QcHZj?=
 =?utf-8?B?Q3IyQlBLQ2NydlAyVUp3VlJ1ckx2UFpUTWMrVjF4SktxSXFWQWNJYVB2WkY1?=
 =?utf-8?B?eVQrNkliaUhwTGJ6UmNVOThsaVd5THNBMWxxdjhXSTcwU1VReDhGWXV2eWNu?=
 =?utf-8?B?OXBURGQ5T0RZQ0hzTkNTNnl2bDlIMW5TUzVaVU1aVTJISGp5U3M4RnRaY0RI?=
 =?utf-8?B?NUVlbWljU1M5T2tTWmVOZXRLcGZTZCtKTkpDc2t0djEyQ0tHbVMreEJmeWZL?=
 =?utf-8?B?dGFldFBBVkhNem1yV1IzVHZibWhqQklEbThhVkJCQ2tyWkM5ZlVFQS9qa3Q3?=
 =?utf-8?B?SnVCYWExVmlwM3VHbWxZbko2Y1FUOElkaDB4bjZzYytRUUZGWFNMUGpXekFr?=
 =?utf-8?B?MlVVN20rNHJVZHhVeThZazg0aHhYSDhGZGFtZnZxekdOdGdFWnVaOTd2SGMr?=
 =?utf-8?B?cE5VL2xaK2twOWkwRlA2MHlaRm53eDJjN3VlOGtsdHAwUmF1YW15QzBpQTFw?=
 =?utf-8?Q?u52G9VJNXYo4b08uzSAudD9mT?=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: IA3PR11MB9136.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 1ba7c565-4697-4a62-9532-08dde9369f99
X-MS-Exchange-CrossTenant-originalarrivaltime: 01 Sep 2025 09:04:57.1182 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: h0d8m4Tqn6GF2Lk4yaHXu6RKKVxqr7YBiB/qMRorN561vCaXwsZ2K4BXzmRCam5WS85LSmGKNdaWNGV2tY8raTeqYe2yXhXwm91CQ6QOOm0=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BL1PR11MB5255
X-OriginatorOrg: intel.com
Received-SPF: pass client-ip=192.198.163.9;
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

DQoNCj4tLS0tLU9yaWdpbmFsIE1lc3NhZ2UtLS0tLQ0KPkZyb206IEVyaWMgQXVnZXIgPGVyaWMu
YXVnZXJAcmVkaGF0LmNvbT4NCj5TdWJqZWN0OiBSZTogW1BBVENIIHY1IDEzLzIxXSBpbnRlbF9p
b21tdTogSW50cm9kdWNlIGEgbmV3IHBhc2lkIGNhY2hlDQo+aW52YWxpZGF0aW9uIHR5cGUgRk9S
Q0VfUkVTRVQNCj4NCj5IaSBaaGVuemhvbmcsDQo+DQo+T24gOC8yMi8yNSA4OjQwIEFNLCBaaGVu
emhvbmcgRHVhbiB3cm90ZToNCj4+IEZPUkNFX1JFU0VUIGlzIGRpZmZlcmVudCBmcm9tIEdMT0JB
TF9JTlYgd2hpY2ggdXBkYXRlcyBwYXNpZCBjYWNoZSBpZg0KPj4gdW5kZXJseWluZyBwYXNpZCBl
bnRyeSBpcyBzdGlsbCB2YWxpZCwgaXQgZHJvcHMgYWxsIHRoZSBwYXNpZCBjYWNoZXMuDQo+Pg0K
Pj4gRk9SQ0VfUkVTRVQgaXNuJ3QgYSBWVEQgc3BlYyBkZWZpbmVkIGludmFsaWRhdGlvbiB0eXBl
IGZvciBwYXNpZCBjYWNoZSwNCj4+IG9ubHkgdXNlZCBpbnRlcm5hbGx5IGluIHN5c3RlbSBsZXZl
bCByZXNldC4NCj4+DQo+PiBTaWduZWQtb2ZmLWJ5OiBZaSBMaXUgPHlpLmwubGl1QGludGVsLmNv
bT4NCj4+IFNpZ25lZC1vZmYtYnk6IFlpIFN1biA8eWkueS5zdW5AbGludXguaW50ZWwuY29tPg0K
Pj4gU2lnbmVkLW9mZi1ieTogWmhlbnpob25nIER1YW4gPHpoZW56aG9uZy5kdWFuQGludGVsLmNv
bT4NCj4+IC0tLQ0KPj4gIGh3L2kzODYvaW50ZWxfaW9tbXVfaW50ZXJuYWwuaCB8ICA5ICsrKysr
KysrKw0KPj4gIGh3L2kzODYvaW50ZWxfaW9tbXUuYyAgICAgICAgICB8IDI1ICsrKysrKysrKysr
KysrKysrKysrKysrKysNCj4+ICBody9pMzg2L3RyYWNlLWV2ZW50cyAgICAgICAgICAgfCAgMSAr
DQo+PiAgMyBmaWxlcyBjaGFuZ2VkLCAzNSBpbnNlcnRpb25zKCspDQo+Pg0KPj4gZGlmZiAtLWdp
dCBhL2h3L2kzODYvaW50ZWxfaW9tbXVfaW50ZXJuYWwuaA0KPmIvaHcvaTM4Ni9pbnRlbF9pb21t
dV9pbnRlcm5hbC5oDQo+PiBpbmRleCBmYjJhOTE5ZTg3Li5jNTEwYjA5ZDFhIDEwMDY0NA0KPj4g
LS0tIGEvaHcvaTM4Ni9pbnRlbF9pb21tdV9pbnRlcm5hbC5oDQo+PiArKysgYi9ody9pMzg2L2lu
dGVsX2lvbW11X2ludGVybmFsLmgNCj4+IEBAIC01NjksNiArNTY5LDE1IEBAIHR5cGVkZWYgZW51
bSBWVERQQ0ludlR5cGUgew0KPj4gICAgICBWVERfUEFTSURfQ0FDSEVfRE9NU0kgPSBWVERfSU5W
X0RFU0NfUEFTSURDX0dfRFNJLA0KPj4gICAgICBWVERfUEFTSURfQ0FDSEVfUEFTSURTSSA9IFZU
RF9JTlZfREVTQ19QQVNJRENfR19QQVNJRF9TSSwNCj4+ICAgICAgVlREX1BBU0lEX0NBQ0hFX0dM
T0JBTF9JTlYgPQ0KPlZURF9JTlZfREVTQ19QQVNJRENfR19HTE9CQUwsDQo+PiArDQo+PiArICAg
IC8qDQo+PiArICAgICAqIEludGVybmFsbHkgdXNlZCBQQVNJRCBjYWNoZSBpbnZhbGlkYXRpb24g
dHlwZSBzdGFydHMgaGVyZSwNCj4+ICsgICAgICogMHgxMCBpcyBsYXJnZSBlbm91Z2ggYXMgaW52
YWxpZGF0aW9uIHR5cGUgaW4gcGNfaW52X2Rlc2MNCj4+ICsgICAgICogaXMgMmJpdHMgaW4gc2l6
ZS4NCj4+ICsgICAgICovDQo+PiArDQo+PiArICAgIC8qIFJlc2V0IGFsbCBQQVNJRCBjYWNoZSBl
bnRyaWVzLCB1c2VkIGluIHN5c3RlbSBsZXZlbCByZXNldCAqLw0KPj4gKyAgICBWVERfUEFTSURf
Q0FDSEVfRk9SQ0VfUkVTRVQgPSAweDEwLA0KPkkgYW0gbm90IHZlcnkga2VlbiBvbiBhZGRpbmcg
c3VjaCBhbiBhcnRpZmljYWwgZW51bSB2YWx1ZSB0aGF0IGRvZXMgbm90DQo+ZXhpc3QgaW4gdGhl
IHNwZWMuDQo+DQo+V2h5IG5vdCBzaW1wbHkgaW50cm9kdWNlIGFub3RoZXIgZnVuY3Rpb24gKGlu
c3RlYWQgb2YNCj52dGRfZmx1c2hfcGFzaWRfbG9ja2VkKSB0aGF0IGRvZXMgdGhlIGNsZWFudXAu
IFRvIG1lIGl0IHdvdWxkIGJlDQo+Y2xlYW5lci4gVGhhbmtzIEVyaWMNCg0KR29vZCBzdWdnZXN0
aW9ucywgd2lsbCBkby4NCg0KVGhhbmtzDQpaaGVuemhvbmcNCg==

