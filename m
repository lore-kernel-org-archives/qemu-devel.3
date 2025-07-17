Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 15C19C83F1A
	for <qemu-devel@archiver.kernel.org>; Thu, 17 Jul 2025 07:17:15 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1ucIr8-0005t5-Dy; Thu, 17 Jul 2025 03:16:38 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <zhenzhong.duan@intel.com>)
 id 1ucIqm-0005bI-Sv
 for qemu-devel@nongnu.org; Thu, 17 Jul 2025 03:16:26 -0400
Received: from mgamail.intel.com ([192.198.163.7])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <zhenzhong.duan@intel.com>)
 id 1ucIqf-0007K8-LB
 for qemu-devel@nongnu.org; Thu, 17 Jul 2025 03:16:13 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1752736570; x=1784272570;
 h=from:to:cc:subject:date:message-id:references:
 in-reply-to:content-transfer-encoding:mime-version;
 bh=Db5PcU6THRDEctAaMTYUlup3D/keN2NcWYsKEWuhkuQ=;
 b=j4JU/JESUqAA/cPnlcnRmXdaNUk9qVj+/gKnnx1keuHzjdkT+I8iwvms
 mpQoh0y+pu4kBP2BzKAeAKUW3NIFwW8xbmTQhoqKC6mZUl7S/UcpmYNkh
 gIwIT1vECpX4BSXFudJSpA6tq0bE8K7JZqgegCllEtGZuatxjMG9+u2og
 8T0hAITUxLG4cby14r2OfMcezJ9SwQ728RkcqpLgqjX2uhezalg52J018
 nvXaV8zAA4FB8e+4cEYgQz1bZRhXhAH87I7sc3dGJhCcKAMPv33z6vKUY
 VEHY9WyKexvo8gGY7varQDAjq4kGPmfcyNxRQZvDFwfvHb5HIRHWP7VKB g==;
X-CSE-ConnectionGUID: OiHUyTmjQBe9g56Rv7P4sQ==
X-CSE-MsgGUID: OVRX67KVRNml/GGHWYDR6A==
X-IronPort-AV: E=McAfee;i="6800,10657,11493"; a="80447678"
X-IronPort-AV: E=Sophos;i="6.16,318,1744095600"; d="scan'208";a="80447678"
Received: from fmviesa002.fm.intel.com ([10.60.135.142])
 by fmvoesa101.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 17 Jul 2025 00:16:03 -0700
X-CSE-ConnectionGUID: D4MFv+TGQmisNzeF2mmKfA==
X-CSE-MsgGUID: IJmOdWhyQQWhkfsC2kz/Cw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.16,318,1744095600"; d="scan'208";a="181411821"
Received: from orsmsx902.amr.corp.intel.com ([10.22.229.24])
 by fmviesa002.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 17 Jul 2025 00:16:01 -0700
Received: from ORSMSX901.amr.corp.intel.com (10.22.229.23) by
 ORSMSX902.amr.corp.intel.com (10.22.229.24) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1748.26; Thu, 17 Jul 2025 00:16:00 -0700
Received: from ORSEDG901.ED.cps.intel.com (10.7.248.11) by
 ORSMSX901.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1748.26 via Frontend Transport; Thu, 17 Jul 2025 00:16:00 -0700
Received: from NAM11-DM6-obe.outbound.protection.outlook.com (40.107.223.44)
 by edgegateway.intel.com (134.134.137.111) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1748.26; Thu, 17 Jul 2025 00:15:59 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=PaGeVISvoq4VkwgWLFiBNDhHZ3wwHsh87GkSWpD5Q7CHMHaN0bylltbELkGzKv4qIVqUY3kaMM60MdTI8jEM6LaJxAlw5cOIYKjc1G5H6kr+82wQokUtJiw4UtwlJJ2W9+i1EAylKFULPYgFaaGCy2eLPjq8Zf6P3BtF43qGodpLLBZwtl1c4TYmuOfwY3UKf/ZfC3qKAmanm54WBnEGl4FU8m3GOpfKRSUbTW56SExM0sdLRO3qSgRLLAzpdSPokPeb/tZk8CwtHxF0cFrbZq696TufBe3GKvMlR8UK8jggvS70AW0fKBfDHO6qarCmzJ03BT+pRcK9x8T1pPbjmg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Db5PcU6THRDEctAaMTYUlup3D/keN2NcWYsKEWuhkuQ=;
 b=yW3alDl5FVIi4bo+pq1J/ShRM41W3olYJIiuSlaV+uZBTLRBTx+cWf8+A+d+6QhfZyCggidehuB4JFrtK+/P45eHWbFhKgmoqD+48tP2KJTQ6vd1McBwsh69j/2bNaX2GLnYyVQLRl1sbyrXCXM4T14P++1gtwkZX51mFD9dy1Fb9ty5/U2FaQmNZqf4UlYFL3TX0jfMr6+llGXi/vQ42tWhD4UTKShnaJK6j5bXROtORsQVJRD1wgKAkvK8oKeaJAr+wskwP1KkcaOlCg/dN4Mb6h292Hs0mUtMtwv6FCUtNIRsikreAv0iAL5Fb3zouEGNNxS3w/s2qSw5N5f3jg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Received: from IA3PR11MB9136.namprd11.prod.outlook.com (2603:10b6:208:574::12)
 by CH3PR11MB8344.namprd11.prod.outlook.com (2603:10b6:610:17f::13)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8922.39; Thu, 17 Jul
 2025 07:15:43 +0000
Received: from IA3PR11MB9136.namprd11.prod.outlook.com
 ([fe80::604b:77a4:b1be:3f13]) by IA3PR11MB9136.namprd11.prod.outlook.com
 ([fe80::604b:77a4:b1be:3f13%4]) with mapi id 15.20.8835.023; Thu, 17 Jul 2025
 07:15:43 +0000
From: "Duan, Zhenzhong" <zhenzhong.duan@intel.com>
To: "eric.auger@redhat.com" <eric.auger@redhat.com>, "qemu-devel@nongnu.org"
 <qemu-devel@nongnu.org>
CC: "alex.williamson@redhat.com" <alex.williamson@redhat.com>,
 "clg@redhat.com" <clg@redhat.com>, "mst@redhat.com" <mst@redhat.com>,
 "jasowang@redhat.com" <jasowang@redhat.com>, "peterx@redhat.com"
 <peterx@redhat.com>, "ddutile@redhat.com" <ddutile@redhat.com>,
 "jgg@nvidia.com" <jgg@nvidia.com>, "nicolinc@nvidia.com"
 <nicolinc@nvidia.com>, "shameerali.kolothum.thodi@huawei.com"
 <shameerali.kolothum.thodi@huawei.com>, "joao.m.martins@oracle.com"
 <joao.m.martins@oracle.com>, "clement.mathieu--drif@eviden.com"
 <clement.mathieu--drif@eviden.com>, "Tian, Kevin" <kevin.tian@intel.com>,
 "Liu, Yi L" <yi.l.liu@intel.com>, "Peng, Chao P" <chao.p.peng@intel.com>, "Yi
 Sun" <yi.y.sun@linux.intel.com>
Subject: RE: [PATCH v3 11/20] intel_iommu: Handle PASID entry adding
Thread-Topic: [PATCH v3 11/20] intel_iommu: Handle PASID entry adding
Thread-Index: AQHb7/hz6o7ZBTJZckyFejkMVFRyhrQ1Ac0AgADyyZA=
Date: Thu, 17 Jul 2025 07:15:43 +0000
Message-ID: <IA3PR11MB9136FD574F165562C18B80E29251A@IA3PR11MB9136.namprd11.prod.outlook.com>
References: <20250708110601.633308-1-zhenzhong.duan@intel.com>
 <20250708110601.633308-12-zhenzhong.duan@intel.com>
 <242b731f-3f83-47e7-8beb-dd92d2f7aee5@redhat.com>
In-Reply-To: <242b731f-3f83-47e7-8beb-dd92d2f7aee5@redhat.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: IA3PR11MB9136:EE_|CH3PR11MB8344:EE_
x-ms-office365-filtering-correlation-id: 83c72a45-f3e6-43fc-fd85-08ddc501be7b
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
 ARA:13230040|7416014|376014|366016|1800799024|38070700018; 
x-microsoft-antispam-message-info: =?utf-8?B?YVQxRnZPVDEvVGYzNWM0bUF2N1owR0pSUXZIckJyMFlaaVVBNDFnT2dXMUhv?=
 =?utf-8?B?V3hoQndtRlBHdE1QOERaN2pBclF6Qm5tTUR6dDNma3pGOTlZaGRPRVJaNXpK?=
 =?utf-8?B?dmZYU2FzUThqZXlLSEJlREd3cnI0eTlXc3BXZytiUUhpYUdzTExiZFZnTXB4?=
 =?utf-8?B?emtDeXJCN1orRDJRaW42QnM4dVYwaS9vbEVTcEdYWDczRmNoMTF0MGdaS2JM?=
 =?utf-8?B?YUtjK0NLOXN4TUpqa1l4Qmx6a0NlMEFBZUdxdndBc1VrRlppL1RSbkhTdkV0?=
 =?utf-8?B?ZTFwY2FKQzIvTWt2d2VBNHlra0tnS2Q2UGN5ZGRJTEVNcjJONUkydEN6MXgz?=
 =?utf-8?B?MTBsdWtuVyszZlJkaHNna3EzM3IvV3UzZkJQU3Qyc3cya0xzcERIb0V1UWRS?=
 =?utf-8?B?bm9PbkNBdG1KSEYvZ2RpZ2dyandDZ3l6RjVmdjhhSGl4QVpDUDJwZk13dWVn?=
 =?utf-8?B?bXZxT2JUNHZBZlZTd2RUOFlVMWNCdVdnNGhnc2xFUDUzMTZDUldMRGF4N2RV?=
 =?utf-8?B?aVhTZGVSNWkyMVphcC9YOHQyODVNcHczcnVZWXBwQ3NwWEpqTHdSTWRDL1RP?=
 =?utf-8?B?M1ZpRGxtUkpUTjArbnNHMFVBQ3RnMnkvUUJWNmlmbHRZeGpFK0tBajg2dFha?=
 =?utf-8?B?UmVXTXIwRU5ZZ21RaE4rd0kra1N0THprc3hPK2R2emZrbmdYTWVMdFZzWHpD?=
 =?utf-8?B?NDBEd2h1REo5MzZtQ3RGSjlLd0I5cHE2SVRsUDlqRWZBby9RM3lNLzVidCtF?=
 =?utf-8?B?cTRwREpJTnpWTUE3THlkNEFCRFgwVnNnb1g1V2J0M1VobWZhc2VmNkJwbFpM?=
 =?utf-8?B?STM0NStwLzM2cm5RSjB1RzN6NGRnMnBzSU5hVnlEUFlwOUFOYklVcUY4cHU2?=
 =?utf-8?B?aUt6Ylc2SVJMTmhISzAzRUhtdkVyUkN5UStCd25tQ3FZbXBxOVJMRExtaCtl?=
 =?utf-8?B?eFFrWTBYdWRyUnVGeHIwcWU2MXNnM0lMK2JlVVgvUWQ0Q1BCb3kwK2FSM01l?=
 =?utf-8?B?cFRyMEYvM1I3bHozUWlmVm8wYVZMZFBHb2RabUxhUGJsUGRKaGZjMHNpYUxL?=
 =?utf-8?B?STRMWFhmODFFelJ4ODVnUTJXcEwvVGtmZ29RVzZXa2Myc1kreGw0VDgxblJu?=
 =?utf-8?B?TnExZUtWdWJWeEFIK1d1Q1RJWWRkOXB5aExVTjhkblJ5S2c4TEJHZGR3ZHNs?=
 =?utf-8?B?MUhadk1SL0lyMmk2T1hWV0N4MmF1WHlNODlhUTdhNkFJby9zS25LWnhBQ1hT?=
 =?utf-8?B?TjZWNVpGMk94WVFueGZUc3k2VExscWJVTUVIV0hqbFEvbzNtVWJzT0pjTkRn?=
 =?utf-8?B?amJNYnpVNm9BbFRSNXNBWENodTNXVnF5ckhJUlVheFBSY1BnQ20vTnFxbk5F?=
 =?utf-8?B?a2t4V0x0U0pPK09GaGZHK3MyRjZiSWlyMzN0R2p1UExzTHNyVWozUkNuV3FQ?=
 =?utf-8?B?TXBtLzc1clNjR1B1c0hrd3NxdE5LZHpaL04rUW5hbzRBMUtRYW12aWJVU2Zs?=
 =?utf-8?B?S2FTbFhnMVQyZk5CSWk0S0lUOWQwbEQrTE5BVXU0SUZkUjJYVDB2eEhSSXdO?=
 =?utf-8?B?emxqTVZRNUNLbitndklxUW5lZEEzZStLaVIydUk1ZTRiMlRtTEV6LzdCdWNW?=
 =?utf-8?B?VVRWWGFMUjJOWkhhSFU5VjVPdGtXRjlJc0ZkUW9vdWdLaDQvTVdETTlLbmFm?=
 =?utf-8?B?cThkUFdjMUswZlBreFJvUWx0a2VLZnpWWk9KdVVLMUZUSzRUSTh2TVpINTdx?=
 =?utf-8?B?bWtPQnlRRHFJQ25XSkszS0VMaE5odmpjaXd3RFgzVzhCdUVNSkF3MU0yajZo?=
 =?utf-8?B?Q1pqc0w0VzEwa3pjNll4TitsK3o4eTRITVZ1bCt1clp2U1NZdmRIMzJsUk5D?=
 =?utf-8?B?VS9sTTlBelRnWDZETSsrSFBpWVhUZmxIOGxVcTdVbW9OUy81b1pPSXBjUlpU?=
 =?utf-8?B?dzNza05TYk1XT3VTY2pNNllvQk5FWHdKRndQZVNGekNnWGk0aUZWTm1LeW45?=
 =?utf-8?B?NFEzRmNQTWVRPT0=?=
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:IA3PR11MB9136.namprd11.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(7416014)(376014)(366016)(1800799024)(38070700018); DIR:OUT;
 SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?VjdXMkVhYmp1WjlzN0NZSjNhWExRc0s2eXBBSk9Eak8wSFR2YlJ3R2dxVlgy?=
 =?utf-8?B?bGtLVUd2OTdCUnVpaUo0TzlnUEtOSVk1clFOdWNPZy9oenBUajJKY2xrNU5a?=
 =?utf-8?B?RzNRWVBlTEZ6MWR0WGhBL0puYThlME9jRFc1UHBsa1hmUnhFV1hYekxwcE5M?=
 =?utf-8?B?b2FsVy9kYXpjYVlnZFNBZDk5VEJJVHZoL0owWGxRTWYwVVB1dXVqMXplYWFi?=
 =?utf-8?B?aFA3c1M3aGFINVhOQUtCVEwwUGpPRUd0d0lFNDlaNkF4OUt2ZWRYdVNnQmR2?=
 =?utf-8?B?Q1hwUklrOVdwMHh1WHpsRThhLzgrSEpGeCttQXZzdXZOeDhhTFBaT2tEVDZK?=
 =?utf-8?B?UEZlTThha3ZrSko4U0RFM3lydlVSdHpuQ2ZRd3RWZ3hPK1BUMXdmOHViaFJG?=
 =?utf-8?B?dGRCRWVEMVZJR1hZeHd5MW9Fd1J6V05OaFg1VGhvbTROb0RpTEsxR215K2Mw?=
 =?utf-8?B?Q2xhTjcvNXVoZG9Kd1pOaGZPNWxCQ2gyWlpRSzkxYXV0dDRBV2kreTBPMWJw?=
 =?utf-8?B?V3ZBQzF4Vk5qNWRJU3ROVnRxdHdBRmh6ZDhEZmJGYTVPdlRSSzYreVY0akxu?=
 =?utf-8?B?anVvcHQ4L3JYU081RmNWVG44ODU0d0tHUVM0Q1RjcjdQRFVLaWx3Q1g0blRR?=
 =?utf-8?B?V1U3TVF2bFYwVzNyc0VTUWR3VzlIY2EzZVhaN2VlRkhYWFgzQmQ3SkErdDJ6?=
 =?utf-8?B?VDIxSHp2cHZZam5BT2pmVTA0N3NKVEgzMXpuSCtvRUZXcFRqUWdIUGJIS1Vm?=
 =?utf-8?B?QXR6MlJUcmxpeWJodVA4OHNDSlRSMk4xazZjUDJtMlhXQUVXdk1xanlRQm9q?=
 =?utf-8?B?cFlITm02MDFUVk1tRVMyd2dTcm0zcWE5TERUVk5kQUw4RkJYSFJoUEpFSE1w?=
 =?utf-8?B?enE3YVdzWEFsaFA2RFZQT0lxMkV6Qk1vdm9uYXNNbkxkanUrTlA4YkpHaC8v?=
 =?utf-8?B?QkpNSVVlY2hJUzFpVi85ZWlXQmRDdHdaOXQvT0NzNTlqd25CRHU5UExUcVNW?=
 =?utf-8?B?QVk3NGJobmd1bDF0Q0Z2Ly9EQzRXeVZ4ZTE1UGtHZHd3aGZ0RmhEN0x0K0ZF?=
 =?utf-8?B?RlJteThFUHpSbTgxVS9weGtEYXNieUk4TXhWc3ZCcDhUQ2FVaG5ud2E0eURp?=
 =?utf-8?B?RGltMHpnMFBWUXNNanBEaVNScUhTQU8yajdMYjhHN1BmbkdYV2lIa1h5eVN4?=
 =?utf-8?B?TWtmS0JvTXdUUVZSVDduNVhKaDlubzVvc0dHN29zNlY3MnNYemcreFljWDE2?=
 =?utf-8?B?d0xmcEwza3NUak9XdmRpNUFnSFpEZ0FmK0lhbDI0dVYxVFdCVDdHUXZ6eUd6?=
 =?utf-8?B?MldLdFY3UkpUcktFLzYvM1lRa2NkRXU0MXFQUXRocnBJWTFWUDVyVlpobFM1?=
 =?utf-8?B?akR5UmFPdXBGQ0lwZEJYUG9nMmVKemVNYTlUTUx1MTZtaDU0RXpWMnlaMnBu?=
 =?utf-8?B?bUNxQWxvcWhNRGcwRDdLQmF4clVLbzlrRGowQW9iVmpjd2RrQWdQOWZxWDV3?=
 =?utf-8?B?RFU0MTFoR0NmenVOc1pFT3FOTWNkd2RBTEc2TnBRN1Myc3VGbWN1NVVUdnJ4?=
 =?utf-8?B?T0w4cVA2ZU1Pa3poa0xNaXhZa0R1OXJydWxOVzJvdkxGZlpsbVNVeFhDb1RY?=
 =?utf-8?B?dzl2eHZkV3F3TUxNOE1qZUc2MGZVRFdPOHhBTjFrM3dsajQ2VmlYMzZLcFlu?=
 =?utf-8?B?WWk0UmlHaEY3d0JlTEpnQXFhOXQrYXJvK2dpWUQ4NnlhL2V1RE5MejlNRjhL?=
 =?utf-8?B?WEZXcHZWOHE0cERjbWNTRm9iRnFkMjlVb1V3Zm1tVm5rRzJnOCtwQXNjWCt3?=
 =?utf-8?B?R3BOZC9VN0k3c2JWQysrSEh4RDJ3MFZndlljSTA2ME51RVA5djhOSUR4TWZk?=
 =?utf-8?B?R0pLa1lVbFp3WGN2ZWowQVN6c0swbVAxN1VyTWROMGVSVjE4Slp2aTVRcDBo?=
 =?utf-8?B?M2c2L0pVVVFoVGJCbGJ0T0szblBQZUdmaGNlTGV5ZUFFUGJieWFpRFZZRXV6?=
 =?utf-8?B?VUp5SXN0dW4wRjhITXFFNU1hUUtxZ2tBZ01BOWlvbWNwRnA5bW9zbjU0Zlp4?=
 =?utf-8?B?bVZjeC82QWgyMXo0NDF4Ukt6SFpOVWp4YURNS2ZtRUdtM2xIbTFic2hWaU1m?=
 =?utf-8?Q?6cP2yBJ1NvyvXzSu7jm31hQkk?=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: IA3PR11MB9136.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 83c72a45-f3e6-43fc-fd85-08ddc501be7b
X-MS-Exchange-CrossTenant-originalarrivaltime: 17 Jul 2025 07:15:43.7641 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: oEmPftziyDWQ4nKgPVF6nsAuYV5fhtVrFlEUkmmvcpLi34Xyj8YqCJ1C0HVR6X4Du6ilHPL6e7engtAaYzllKyF1/nnLaTjYCLjCKLZNvdU=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH3PR11MB8344
X-OriginatorOrg: intel.com
Received-SPF: pass client-ip=192.198.163.7;
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

SGkgRXJpYywNCg0KPi0tLS0tT3JpZ2luYWwgTWVzc2FnZS0tLS0tDQo+RnJvbTogRXJpYyBBdWdl
ciA8ZXJpYy5hdWdlckByZWRoYXQuY29tPg0KPlN1YmplY3Q6IFJlOiBbUEFUQ0ggdjMgMTEvMjBd
IGludGVsX2lvbW11OiBIYW5kbGUgUEFTSUQgZW50cnkgYWRkaW5nDQo+DQo+SGkgWmhlbnpob25n
LA0KPg0KPk9uIDcvOC8yNSAxOjA1IFBNLCBaaGVuemhvbmcgRHVhbiB3cm90ZToNCj4+IFdoZW4g
Z3Vlc3QgbW9kaWZpZXMgYSBQQVNJRCBlbnRyeSwgUUVNVSB3aWxsIGNhcHR1cmUgdGhlIGd1ZXN0
IHBhc2lkDQo+c2VsZWN0aXZlDQo+PiBwYXNpZCBjYWNoZSBpbnZhbGlkYXRpb24sIGFsbG9jYXRl
IG9yIHJlbW92ZSBhIFZUREFkZHJlc3NTcGFjZSBpbnN0YW5jZQ0KPnBlciB0aGUNCj4+IGludmFs
aWRhdGlvbiByZWFzb25zOg0KPg0KPmNvbW1pdCBtc2c6IGludGVsX2lvbW11OiBIYW5kbGUgUEFT
SUQgZW50cnkgYWRkaXRpb24/DQo+U2FtZSBmb3IgcHJldmlvdXMgcGF0Y2gsIGllLiB1c2Ugbm91
bnMNCj4+DQo+PiAgICAgYSkgYSBwcmVzZW50IHBhc2lkIGVudHJ5IG1vdmVkIHRvIG5vbi1wcmVz
ZW50DQo+PiAgICAgYikgYSBwcmVzZW50IHBhc2lkIGVudHJ5IHRvIGJlIGEgcHJlc2VudCBlbnRy
eQ0KPj4gICAgIGMpIGEgbm9uLXByZXNlbnQgcGFzaWQgZW50cnkgbW92ZWQgdG8gcHJlc2VudA0K
Pmp1c3QgZm9jdXMgb24gYyB0byBhdm9pZCBleHRyYSBub2lzZT8NCj4+DQo+PiBUaGlzIGhhbmRs
ZXMgYykgYnkgZ29pbmcgdGhyb3VnaCBlYWNoIHBhc3N0aHJvdWdoIGRldmljZSBhbmQgZWFjaCBw
YXNpZC4NCj5XaGVuDQo+PiBhIG5ldyB2YWxpZCBwYXNpZCBlbnRyeSBpcyBmb3VuZGVkLCBmaW5k
IG9yIGNyZWF0ZSBhIHZ0ZF9hcyBhbmQgY2FjaGUgcGFzaWQNCj5pcyBmb3VuZCwgaWRlbnRpZnkg
YW4gZXhpc3RpbmcgdnRkX2FzIG9yIGNyZWF0ZSBhIG5ldyBvbmUgYW5kIHVwZGF0ZSBpdHMNCj5j
b3JyZXNwb25kaW5nIGNhY2hlZCBwYXNpZCBlbnRyeS4NCg0KV2lsbCBkbyBhbGwgYWJvdmUuDQoN
Cj4+IGVudHJ5IGluIGl0Lg0KPj4NCj4+IFNpZ25lZC1vZmYtYnk6IFlpIExpdSA8eWkubC5saXVA
aW50ZWwuY29tPg0KPj4gU2lnbmVkLW9mZi1ieTogWWkgU3VuIDx5aS55LnN1bkBsaW51eC5pbnRl
bC5jb20+DQo+PiBTaWduZWQtb2ZmLWJ5OiBaaGVuemhvbmcgRHVhbiA8emhlbnpob25nLmR1YW5A
aW50ZWwuY29tPg0KPj4gLS0tDQo+PiAgaHcvaTM4Ni9pbnRlbF9pb21tdS5jICAgICAgICAgIHwg
MTcwDQo+KysrKysrKysrKysrKysrKysrKysrKysrKysrKysrKystDQo+PiAgaHcvaTM4Ni9pbnRl
bF9pb21tdV9pbnRlcm5hbC5oIHwgICAyICsNCj4+ICAyIGZpbGVzIGNoYW5nZWQsIDE2OSBpbnNl
cnRpb25zKCspLCAzIGRlbGV0aW9ucygtKQ0KPj4NCj4+IGRpZmYgLS1naXQgYS9ody9pMzg2L2lu
dGVsX2lvbW11LmMgYi9ody9pMzg2L2ludGVsX2lvbW11LmMNCj4+IGluZGV4IDViZGE0MzlkZTYu
LmNmMmM5NTliNjAgMTAwNjQ0DQo+PiAtLS0gYS9ody9pMzg2L2ludGVsX2lvbW11LmMNCj4+ICsr
KyBiL2h3L2kzODYvaW50ZWxfaW9tbXUuYw0KPj4gQEAgLTgyNiw2ICs4MjYsMTEgQEAgc3RhdGlj
IGlubGluZSBib29sDQo+dnRkX3BlX3R5cGVfY2hlY2soSW50ZWxJT01NVVN0YXRlICpzLCBWVERQ
QVNJREVudHJ5ICpwZSkNCj4+ICAgICAgfQ0KPj4gIH0NCj4+DQo+PiArc3RhdGljIGlubGluZSB1
aW50MzJfdCB2dGRfc21fY2VfZ2V0X3BkdF9lbnRyeV9udW0oVlREQ29udGV4dEVudHJ5DQo+KmNl
KQ0KPj4gK3sNCj4+ICsgICAgcmV0dXJuIDFVIDw8IChWVERfU01fQ09OVEVYVF9FTlRSWV9QRFRT
KGNlKSArIDcpOw0KPj4gK30NCj4+ICsNCj4+ICBzdGF0aWMgaW5saW5lIGJvb2wgdnRkX3BkaXJl
X3ByZXNlbnQoVlREUEFTSUREaXJFbnRyeSAqcGRpcmUpDQo+PiAgew0KPj4gICAgICByZXR1cm4g
cGRpcmUtPnZhbCAmIDE7DQo+PiBAQCAtMTY0Nyw5ICsxNjUyLDkgQEAgc3RhdGljIGdib29sZWFu
DQo+dnRkX2ZpbmRfYXNfYnlfc2lkX2FuZF9pb21tdV9wYXNpZChncG9pbnRlciBrZXksIGdwb2lu
dGVyIHZhbHVlLA0KPj4gIH0NCj4+DQo+PiAgLyogVHJhbnNsYXRlIGlvbW11IHBhc2lkIHRvIHZ0
ZF9hcyAqLw0KPj4gLXN0YXRpYyBpbmxpbmUNCj4+IC1WVERBZGRyZXNzU3BhY2UgKnZ0ZF9hc19m
cm9tX2lvbW11X3Bhc2lkX2xvY2tlZChJbnRlbElPTU1VU3RhdGUNCj4qcywNCj4+IC0gICAgICAg
ICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICB1aW50MTZfdCBzaWQsDQo+
dWludDMyX3QgcGFzaWQpDQo+PiArc3RhdGljIFZUREFkZHJlc3NTcGFjZQ0KPip2dGRfYXNfZnJv
bV9pb21tdV9wYXNpZF9sb2NrZWQoSW50ZWxJT01NVVN0YXRlICpzLA0KPj4gKw0KPnVpbnQxNl90
IHNpZCwNCj4+ICsNCj51aW50MzJfdCBwYXNpZCkNCj4+ICB7DQo+PiAgICAgIHN0cnVjdCB2dGRf
YXNfcmF3X2tleSBrZXkgPSB7DQo+PiAgICAgICAgICAuc2lkID0gc2lkLA0KPj4gQEAgLTMyMDYs
NiArMzIxMSwxNjIgQEAgcmVtb3ZlOg0KPj4gICAgICByZXR1cm4gdHJ1ZTsNCj4+ICB9DQo+Pg0K
PkkgdGhpbmsgdGhpcyB3b3VsZCBkZXNlcnZlIGEgZG9jIGNvbW1lbnQgZXhwbGFpbmluZyBpdCBy
ZXRyaWV2ZXMvY3JlYXRlcw0KPnZ0ZF9hcyBhbmQgYXNzb2NpYXRlZCBjYWNoZWQgUEUgZm9yIFBB
U0lEIHJhbmdlIHdpdGhpbiBbc3RhcnQsIGVuZF0gdGhhdA0KPm1hdGNoZXMgQGluZm8gdHlwZS9k
aWQuIEFsc28geW91IG1heSBkb2N1bWVudCB0aGF0IHRoZSAiX29uZSIgbWVhbnMgaXQNCj53YWxr
cyBhIHNpbmdsZSBTTSBwYWdlIHRhYmxlIGJldHdlZW4gc3RhcnQvZW5kwqAgKGlmIG15IHVuZGVy
c3RhbmRpbmcgaXMNCj5jb3JyZWN0KQ0KDQpXaWxsIGRvLg0KDQo+PiArc3RhdGljIHZvaWQgdnRk
X3NtX3Bhc2lkX3RhYmxlX3dhbGtfb25lKEludGVsSU9NTVVTdGF0ZSAqcywNCj4+ICsgICAgICAg
ICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgZG1hX2FkZHJfdCBwdF9iYXNlLA0KPj4g
KyAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICBpbnQgc3RhcnQsDQo+PiAr
ICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgIGludCBlbmQsDQo+PiArICAg
ICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgIFZURFBBU0lEQ2FjaGVJbmZvDQo+
KmluZm8pDQo+PiArew0KPj4gKyAgICBWVERQQVNJREVudHJ5IHBlOw0KPj4gKyAgICBpbnQgcGFz
aWQgPSBzdGFydDsNCj4+ICsNCj4+ICsgICAgd2hpbGUgKHBhc2lkIDwgZW5kKSB7DQo+PiArICAg
ICAgICBpZiAoIXZ0ZF9nZXRfcGVfaW5fcGFzaWRfbGVhZl90YWJsZShzLCBwYXNpZCwgcHRfYmFz
ZSwgJnBlKQ0KPj4gKyAgICAgICAgICAgICYmIHZ0ZF9wZV9wcmVzZW50KCZwZSkpIHsNCj4+ICsg
ICAgICAgICAgICBpbnQgYnVzX24gPSBwY2lfYnVzX251bShpbmZvLT5idXMpLCBkZXZmbiA9IGlu
Zm8tPmRldmZuOw0KPj4gKyAgICAgICAgICAgIHVpbnQxNl90IHNpZCA9IFBDSV9CVUlMRF9CREYo
YnVzX24sIGRldmZuKTsNCj4+ICsgICAgICAgICAgICBWVERQQVNJRENhY2hlRW50cnkgKnBjX2Vu
dHJ5Ow0KPj4gKyAgICAgICAgICAgIFZUREFkZHJlc3NTcGFjZSAqdnRkX2FzOw0KPj4gKw0KPj4g
KyAgICAgICAgICAgIHZ0ZF9pb21tdV9sb2NrKHMpOw0KPj4gKyAgICAgICAgICAgIC8qDQo+PiAr
ICAgICAgICAgICAgICogV2hlbiBpbmRleGVkIGJ5IHJpZDJwYXNpZCwgdnRkX2FzIHNob3VsZCBo
YXZlIGJlZW4NCj5jcmVhdGVkLA0KPj4gKyAgICAgICAgICAgICAqIGUuZy4sIGJ5IFBDSSBzdWJz
eXN0ZW0uIEZvciBvdGhlciBpb21tdSBwYXNpZCwgd2UgbmVlZA0KPnRvDQo+SSB0aG91Z2h0IGlv
bW11IHBhc2lkIHdhcyByaWQycGFzaWQsIGFzIG9wcG9zZWQgdG8gcmVndWxhciBQQ0kgcGFzaWRz
Lg0KDQpZZXMsIGZvciBQQ0kgcGFzaWQsIGl0J3MgUENJX05PX1BBU0lELg0KDQpUaGFua3MNClpo
ZW56aG9uZw0K

