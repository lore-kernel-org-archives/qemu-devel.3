Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 154A7D41C01
	for <qemu-devel@archiver.kernel.org>; Thu, 11 Dec 2025 07:52:54 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vTbTU-0002xk-BH; Thu, 11 Dec 2025 02:52:32 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <zhenzhong.duan@intel.com>)
 id 1vTbTS-0002xS-HS
 for qemu-devel@nongnu.org; Thu, 11 Dec 2025 02:52:30 -0500
Received: from mgamail.intel.com ([192.198.163.14])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <zhenzhong.duan@intel.com>)
 id 1vTbTP-0004oF-EF
 for qemu-devel@nongnu.org; Thu, 11 Dec 2025 02:52:30 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1765439547; x=1796975547;
 h=from:to:cc:subject:date:message-id:references:
 in-reply-to:content-transfer-encoding:mime-version;
 bh=VHSWRbULdgCz2btTrX8a4itod0maxCPApHUW08Ngwp4=;
 b=EVaO93ZJonevsT2FGEEQQqdmY99ljayeG1wv5xYuBXPs5dBU0OWlv8ba
 iONlpna+lqW+PKUK/rezbL9GKImfagH4AJsyzOwjOSRSq55FVlfHEeE+u
 ekfNgIQOxOwXF/v1M9GG+5PSW7SuvoX64ufMFvlSYp4R5lUtApXtlwo7A
 WAOVyXDLWbg5/enpl6vv9nrZZeAMyBS0VGfvSTCsG8ke4jgnqmE5ODrgX
 A6oDo1BsykknTgNh+ks+AtozyhDPU0qJrpizVDrJK7kWZfkbYdhSTmkyX
 LRPofvQ9LWpi7uI3Rj+UGJCMRMPPt6Kg47NecUcgAJ7YbshbETOW/qayR Q==;
X-CSE-ConnectionGUID: oNWsWAe7ThCtiRHUAWkHFw==
X-CSE-MsgGUID: VH3T1HBATj+F/5mAGXxs6Q==
X-IronPort-AV: E=McAfee;i="6800,10657,11638"; a="67456784"
X-IronPort-AV: E=Sophos;i="6.20,265,1758610800"; d="scan'208";a="67456784"
Received: from orviesa004.jf.intel.com ([10.64.159.144])
 by fmvoesa108.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 10 Dec 2025 23:52:25 -0800
X-CSE-ConnectionGUID: FrRzHg3ERgacOa1r29iHgA==
X-CSE-MsgGUID: tRfhjPV/TOKI+HQitV4zdg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.20,265,1758610800"; d="scan'208";a="201212105"
Received: from orsmsx901.amr.corp.intel.com ([10.22.229.23])
 by orviesa004.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 10 Dec 2025 23:52:25 -0800
Received: from ORSMSX902.amr.corp.intel.com (10.22.229.24) by
 ORSMSX901.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.29; Wed, 10 Dec 2025 23:52:23 -0800
Received: from ORSEDG901.ED.cps.intel.com (10.7.248.11) by
 ORSMSX902.amr.corp.intel.com (10.22.229.24) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.29 via Frontend Transport; Wed, 10 Dec 2025 23:52:23 -0800
Received: from BL0PR03CU003.outbound.protection.outlook.com (52.101.53.68) by
 edgegateway.intel.com (134.134.137.111) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.29; Wed, 10 Dec 2025 23:52:23 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=wVgprMimcg5lCU+OaumS/96Gr4A3GRj7hYQSowhfW+X9/bXmc5ctXtQe0/3CjvZuOTRonhszxSDvN7nzxJD9A3ztwgNC9mOuuA84iPgk2NZQ2rOCG682rKy6JucgUSBWflk+ZFyv1iAtl6reJgswQ1FQZxjMvXU3C1qLKGZqK0ZUFcCpT1bjG927FeWtAumIXZA8GT1q+oF1H5KuCBgkbObzndyrPF2hUzNwscWwosEdmVD/eIYtqGjUHyjKOErIyqVRnHLFwE+KV3P2/gmvhZ035lmlu2f05SWbB+gv/+kmnu66DPERf0Yl/h5AAmCa5nhCDKz8BqJvl+WJ4HkcRw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=VHSWRbULdgCz2btTrX8a4itod0maxCPApHUW08Ngwp4=;
 b=sQHEN9QDrP6eCQA1hu/TgjTPztm7ZlGVvNJX5Y8xe/FBIapNleSooHNfx6ydOijuAy7V+T8jiYcxvUXO/te2JXAnUiJRN1CyzvBu4WbSj/zYKsBp68T16i9i5qD3fLIE3gNQsM9X9gegKXJkswPS4JJa4DepEJit9afegeR3YrUpWn7KiDdSZJzZfE/GAprgRsYiyESgE8BiuxB3gBmJzy4QR1ceOQ8p6aQXJoq75ofG4B04NyfFfCXt7V4OXrCI+vL1IS2ReXgTtSM8vqzCuoIH/1Ubp+0165Bv30Sx5aB5zdt1Oi0eub5vUCJupvcydPn+i/0sd3VoZ62rPlmjrg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Received: from IA3PR11MB9136.namprd11.prod.outlook.com (2603:10b6:208:574::12)
 by DS0PR11MB7850.namprd11.prod.outlook.com (2603:10b6:8:fe::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9412.9; Thu, 11 Dec
 2025 07:52:09 +0000
Received: from IA3PR11MB9136.namprd11.prod.outlook.com
 ([fe80::604b:77a4:b1be:3f13]) by IA3PR11MB9136.namprd11.prod.outlook.com
 ([fe80::604b:77a4:b1be:3f13%7]) with mapi id 15.20.9412.005; Thu, 11 Dec 2025
 07:52:09 +0000
From: "Duan, Zhenzhong" <zhenzhong.duan@intel.com>
To: "eric.auger@redhat.com" <eric.auger@redhat.com>, "qemu-devel@nongnu.org"
 <qemu-devel@nongnu.org>, "jasowang@redhat.com" <jasowang@redhat.com>,
 "nicolinc@nvidia.com" <nicolinc@nvidia.com>
CC: "alex@shazbot.org" <alex@shazbot.org>, "clg@redhat.com" <clg@redhat.com>, 
 "mst@redhat.com" <mst@redhat.com>, "peterx@redhat.com" <peterx@redhat.com>,
 "ddutile@redhat.com" <ddutile@redhat.com>, "jgg@nvidia.com" <jgg@nvidia.com>, 
 "skolothumtho@nvidia.com" <skolothumtho@nvidia.com>,
 "joao.m.martins@oracle.com" <joao.m.martins@oracle.com>,
 "clement.mathieu--drif@eviden.com" <clement.mathieu--drif@eviden.com>, "Tian, 
 Kevin" <kevin.tian@intel.com>, "Liu, Yi L" <yi.l.liu@intel.com>, "Peng, Chao
 P" <chao.p.peng@intel.com>, Yi Sun <yi.y.sun@linux.intel.com>
Subject: RE: [PATCH v8 13/23] intel_iommu_accel: Bind/unbind guest page table
 to host
Thread-Topic: [PATCH v8 13/23] intel_iommu_accel: Bind/unbind guest page table
 to host
Thread-Index: AQHcV6YUvl2VrinOX0+Zg5ikN/IKE7UbSWMAgADSgeA=
Date: Thu, 11 Dec 2025 07:52:09 +0000
Message-ID: <IA3PR11MB9136F90FE5C93257ABB0772392A1A@IA3PR11MB9136.namprd11.prod.outlook.com>
References: <20251117093729.1121324-1-zhenzhong.duan@intel.com>
 <20251117093729.1121324-14-zhenzhong.duan@intel.com>
 <52703428-96c5-4b18-b7e8-ccc3c38e2cd2@redhat.com>
In-Reply-To: <52703428-96c5-4b18-b7e8-ccc3c38e2cd2@redhat.com>
Accept-Language: en-US
Content-Language: en-US
X-Mentions: jasowang@redhat.com,nicolinc@nvidia.com
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: IA3PR11MB9136:EE_|DS0PR11MB7850:EE_
x-ms-office365-filtering-correlation-id: 52208ed2-4bbf-4f51-9a6e-08de388a2fd4
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
 ARA:13230040|366016|7416014|376014|1800799024|38070700021; 
x-microsoft-antispam-message-info: =?utf-8?B?U2EzRGp6RTV1SGFsTk10V2M1d0M3OVU3NlpXRmdaSDlHL015MVdYWFN0OC9C?=
 =?utf-8?B?U3dCbFBPVU44WHI1ZlJ2R0ozeHJhWUdZOFBqdVh5UVZjUkNNQ0x0dDNjN1JL?=
 =?utf-8?B?TGtqNUR0NU1vOWRuZU5DdndsSXl0c1E1WVcrdjNLOGk4VVNzSEJndC90N1pL?=
 =?utf-8?B?ZVFLemRqRUpDNVdJZEc2c1dpeDNsUkxuQVpLTDVrYkZoNCtRMG1oS3dKU1JJ?=
 =?utf-8?B?NzBlWWJXUE9QaGJMVFhSQmxlZlUvdC9hVUpnMGdsN0pTVVU3U21sNWY0aFZG?=
 =?utf-8?B?a2gxVzBPNWt1S2o5Nno1TGFPbmZ6RjVORGV3V2k2NU03RGVXcUJLN045MUJ4?=
 =?utf-8?B?NW9TVmpHOGhUNkxha1lsZEV5eXplSWNNRXRXcEVJYWMvRjV5Yzg4c0duMmhZ?=
 =?utf-8?B?UVhuallUaHdLRVljbVlxdFEzejdhKzduRkJONys3VldmM0pNeENGdFpnQlZR?=
 =?utf-8?B?ajdwOW5lV0lDV0RXcldLYkpKendlOW9zQzQyL0RBaHhUcXNhRDFFWFZKa0dq?=
 =?utf-8?B?VHd1NDBwVXdPUysvVEI0d1p0cW5qeGZscWozZWx5Rk53VjRFSmNzUURNRFp6?=
 =?utf-8?B?djVyT1pEeU01b25pWnNRaUJuY2oxVXpxS1BnQlZwM20wQ0RGZklNZ2lMcCtC?=
 =?utf-8?B?Q3kzU2xISHMvbk90S042bEYrV1VNRm8ydGhyMS9oT0wvWE1ZSDZrZ0FZejMr?=
 =?utf-8?B?bHozdk1nN3NkK1U3V1RmNHZteXNIV0Zkd2xST29vaVJsU3Fsa0cxa25PZExw?=
 =?utf-8?B?ZXN4S3JxSm1kMXFqMXI3d1dVOVBpOUFUWC9XeFNWU3BDNjRqRkQyQldMUnhq?=
 =?utf-8?B?QU1vZUEyazlQVGhXcHhKbzR3RjF1VE9MK093Q0VyN3hNNEp3KzM4SktnVDBS?=
 =?utf-8?B?V1RrVE5Iajd4Tk15TGRicWMyWjVROVVUdmF5RmlDd1JTajNDdVpUVFVwcys3?=
 =?utf-8?B?ZjUzVmIvMC8yY0NUZmJJZjFEU3h2ZVVHdkYyQ21vRGRaN0dHamZtSXRZdlRG?=
 =?utf-8?B?MDJjbjc2TmdtMFUzU2RIVlJrcnYwNHFUcXU2Q0RhRlgrZ0RFcG9WQ3dNVi8x?=
 =?utf-8?B?WTRjdkdVTzI3cjVRYmd1WkdrM2kralZIT0tsUGwxNmVReTlnUG1WKzljWExh?=
 =?utf-8?B?OEZaaXBwekJBbU1vQjlGYTlVVW9RenlUbGNta0tISzlobnV4V0NCcTBwSVVH?=
 =?utf-8?B?Y3JML3RWRS82V2NMS1c2VlRQTmYzY1gxWEhONXJHT3FUTXVncTZwWWxKTVgr?=
 =?utf-8?B?Ty91bDc5VktwMzVuUTVuR25vYmhrWDlaRTRsSlVOYmtmeGE4cS9rVHl4K2pB?=
 =?utf-8?B?QlEyT2lIckFsVWt4bG1nS1lUMC8vY24yUGNBeGtOVGh1MU12Qm5YN05QSURw?=
 =?utf-8?B?MlVGd0d6N1gwVG1zeXpqZTUyVy9ObENzUVptRWZHamZxelBud1V1RWwxb0Vn?=
 =?utf-8?B?RW1ZNVk5ZDVtL0VXV1pDbk9kNGFUR01CcXN5SWF6QzJFdTBac01Lc1J2NHFT?=
 =?utf-8?B?bmxkaWlCbzc5TXNlNElsS3d4UEJKZHlLZjZZRDJyQmJJL0NkWHZYK0xuYWlF?=
 =?utf-8?B?M1dSbUkrNU0zMFdObFBDZGVPZWlncHRJVkJkN0FIbjFMcEczV2ZLTm5nOFFv?=
 =?utf-8?B?c3dXcWxEV1NhZWhqRHdHK1F5aC8vamNTdk1mdWs5dXNzQ2xTUW5yUFR1Risw?=
 =?utf-8?B?MTFSS0VDbXZ2OWNOSDNaZnRDSjhoUmN6WUlEcnh1SFJnUG9xd2dyTjNZbGNo?=
 =?utf-8?B?YVU5ZVJycjREZkV5MHI0Mkl0MXhLMVR1cCtnVUZKUDJrRmUxTW5ldStPVGlR?=
 =?utf-8?B?OHdLSWZtT0krc0ZzZmNwazdRN0QzMjFWRDVKU0ZSOVVWejRqQlMxcjNuUFhq?=
 =?utf-8?B?VUNYbklrN0IyYm4rNGhSaGtjcldubmFiS3dCU2dndlA4dzZnVTlyTENnU2F0?=
 =?utf-8?B?dTBQZzZ6MEhlNXRQa0huaTA5aVk3QVU3QUJPZ1hWYTVpVk01WlpXSGpQRnhN?=
 =?utf-8?B?T2ZKMUlPYXdZYlJzRkh6Zlc4QTZ3U0ExMTlrMXpONlhSVlZxVUpwWkdMK1M3?=
 =?utf-8?Q?mXx0Kv?=
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:IA3PR11MB9136.namprd11.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(366016)(7416014)(376014)(1800799024)(38070700021); DIR:OUT;
 SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?bFArY3h1SmhLWEI1SG9PZ0lqOG9uZ09RdXpWUGhSbEZqMzdxR2xhM0Nxc0xs?=
 =?utf-8?B?YUNoYTVqQ1VQb0owWVFuOGp5c3NGL0hjQjZmdWdDVFRXSVFBWjhxeUdjLytB?=
 =?utf-8?B?R1M4enFLT3FnR3pOVTF6UUZKcFJUdzZQYi8vckgzb2tNa29PbWJ0STlxck9R?=
 =?utf-8?B?UUU2OEdrd3ViYmIwdy9CdXpDZDNDSkZBU3E1aFBTVGx2VlQzS2hNbzNVbE5w?=
 =?utf-8?B?NTQzdWtxbW9XTzR2YU5LZFVyK0F2VWQ5Yit1RmxEQUZCU0NuajdYRy9CcGFu?=
 =?utf-8?B?QnhaSW5naVk4K2NNZ2JxdCtDc2xtUWpRNTQ2cm12eTlDaWRDNEd1TDB2SnM0?=
 =?utf-8?B?eGlud0hqQ0VTd29LTGk4ZzF6K3FCeUI5RU5FanZZcmdmY3BMeG1wQVlqNmZj?=
 =?utf-8?B?aUhCbDNpRFQyZGdNTnRyVGI5aUdpY0VuQWk2cHFLL201enoxWEZSSWJzK1JJ?=
 =?utf-8?B?andodFhER3dzZ2c0SVZYKzZUeWFnRTE4Z3F1WjNMcEhhc05ZejVpUElEd3Y3?=
 =?utf-8?B?cnRBOFhKQnNNQUd4YkZLam1LU0tuRkxlVTZzQVlISWUvZHJrdWgvcEY0c1JR?=
 =?utf-8?B?R0NMUll3QS8yZit4N0dlZ0tMME1lc0pERzhLQ01aZVh6eSsvQzFsWlUyRnFV?=
 =?utf-8?B?OXh0bEZoU3g1eXZ1YXd4TzdVSjJFamt4UlZFdVJkVlpEclFBaVJvM0gySkky?=
 =?utf-8?B?RjI5V1E3dUdJL2htd0ZaMEdlYXArREsrWGVoTzdKcjVwYWlLUXUwN0JPUUFl?=
 =?utf-8?B?WVBodFBJT0c3SE5ON2VianYxTTRJb2svN3U1dEd1V3NxbEJJcXhkZjg2dXQ4?=
 =?utf-8?B?bDBVdjY2U3ZOMG8xVTlac1dlbmtMVXJ0d3c2bG1wYi9lOVViTjg4dktXUHFV?=
 =?utf-8?B?R2V5WStpTlYzakVRQklVaU5wZnhGeEhNcC8rTXp1djEvaDBKMjRlWG44SVF0?=
 =?utf-8?B?NWMxbzZmdHd5SmRHYkUxODhEbFA0ajcyLzBqNVg3d2hrMmg3RjY0Q0VvcS9j?=
 =?utf-8?B?bDNhWnJOR0tUbnRpL2plSXJvSTQwb0QyeTk2dFphcGhoLzVJdU95NGVTVEww?=
 =?utf-8?B?b1NrZDJDMitnTm1mNitvc3E0UUZmU2ZXR2tsYWhyOElXUUdnUjFJQS9RSEJL?=
 =?utf-8?B?UmQ1ZHErc1R1Q1U0OG9JdG9jc0FkdWk4b0pYbTV1clZZU2RTd0NiQ1FheWV4?=
 =?utf-8?B?UkE5bU1vSUN1Y040NE9RelQvQmJqT2lOb1Btc1NvY2ZoWkFjYzZ5NkpUOFZY?=
 =?utf-8?B?TVVqRnJOSVk0NjlSZjJmSnVFQXpES2NiVFYyTmw4ekRnaStLdjd5aTc1T00z?=
 =?utf-8?B?M1NyTUtlVEhNNzhlSmZ2TlppZ01UbzlsYVg2aEI0WTRHZ1J5VW9SbW5pcmZz?=
 =?utf-8?B?eGpkUFVMZS9sNS92MjZKaVRHT3VLMkluWm1FMGVPazVEVWo4aTJPV0EwSmtE?=
 =?utf-8?B?WEkrRm1sbndZd0JFWjBOT3AzMFFwY3RhRGNFR3BLUkpXU1gzVGQ3cDhORVF4?=
 =?utf-8?B?OW1UbUZna1p6QVNTdzhPRUlhSkMybzBnenNqYVFOeWlqYVJOQnBtRHB3ZzV1?=
 =?utf-8?B?ZkZmcEJHSzlkVVhRZHo4cmMxNjlyR0FWYjJOL1F3MDFqT01COGhUeE01SDNv?=
 =?utf-8?B?YVVWemxZektWVWZFZys0WldCRFJTcjJHSlg3MzlHVmVXMGhZNURMTHhzcnYz?=
 =?utf-8?B?RC9EeG5zUExSdm5PNWVQb2xwUGxLOExqTzRRV3JuVGM2SGd2ZjUwSEI2bklP?=
 =?utf-8?B?aHNvei9qekNsSDd1NXV3d3BiNVdnZ25KbXBzNzA0Y3lXa0hSYzFWUWxzNE0w?=
 =?utf-8?B?OFMzaE5Nd1E4cnBqbjM1aG00dkJ4RmM3MXJhR0Y2N0RTY2piR1NJeE95b0tN?=
 =?utf-8?B?UmVzUkpjWDRPQzBxdVpGeXRaUWpVcmUrUDFwWVM0Rys2TEZ4NkxYdkhhM3Ur?=
 =?utf-8?B?Q0swRlpRWUUwaTJtTkVZWUNTa2g0MU4wNTV4Q1lIR3BWVzFZNE1BbFFvK2lW?=
 =?utf-8?B?MnZ3ZTF3dVAzdDhPcTBZbkpFb1FQMXRZTGs0YjBTcGZKem1RT21hL2E5S3dT?=
 =?utf-8?B?U0ZHSVZ3L2pKMERjd2dvQTFiVmhmYnI5WmRSZHI0bmlwRVNQVmZ5dzYxWXdu?=
 =?utf-8?Q?+PbFzkR2qt3bXoFyGU43bv06U?=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: IA3PR11MB9136.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 52208ed2-4bbf-4f51-9a6e-08de388a2fd4
X-MS-Exchange-CrossTenant-originalarrivaltime: 11 Dec 2025 07:52:09.1758 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: X7MqauaMwk1sNFbo9nowlNge0S+qqlPlCAIDOfgKuz/doxGH7gM3+sX87m4UWF6dHH9UTsc7xcrONNqinKMJZo+QmHyyCfiEpz6KyQPgSeI=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS0PR11MB7850
X-OriginatorOrg: intel.com
Received-SPF: pass client-ip=192.198.163.14;
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

SGkgRXJpYywNCg0KPi0tLS0tT3JpZ2luYWwgTWVzc2FnZS0tLS0tDQo+RnJvbTogRXJpYyBBdWdl
ciA8ZXJpYy5hdWdlckByZWRoYXQuY29tPg0KPlN1YmplY3Q6IFJlOiBbUEFUQ0ggdjggMTMvMjNd
IGludGVsX2lvbW11X2FjY2VsOiBCaW5kL3VuYmluZCBndWVzdCBwYWdlDQo+dGFibGUgdG8gaG9z
dA0KPg0KPkhpIFpoZW56aG9uZywNCj4NCj5PbiAxMS8xNy8yNSAxMDozNyBBTSwgWmhlbnpob25n
IER1YW4gd3JvdGU6DQo+PiBUaGlzIGNhcHR1cmVzIHRoZSBndWVzdCBQQVNJRCB0YWJsZSBlbnRy
eSBtb2RpZmljYXRpb25zIGFuZCBwcm9wYWdhdGVzDQo+PiB0aGUgY2hhbmdlcyB0byBob3N0IHRv
IGF0dGFjaCBhIGh3cHQgd2l0aCB0eXBlIGRldGVybWluZWQgcGVyIGd1ZXN0DQo+SU9NTVUNCj4+
IFBHVFQgY29uZmlndXJhdGlvbi4NCj4+DQo+PiBXaGVuIFBHVFQ9UFQsIGF0dGFjaCBQQVNJRF8w
IHRvIGEgc2Vjb25kIHN0YWdlIEhXUFQoR1BBLT5IUEEpLg0KPj4gV2hlbiBQR1RUPUZTVCwgYXR0
YWNoIFBBU0lEXzAgdG8gbmVzdGVkIEhXUFQgd2l0aCBuZXN0aW5nIHBhcmVudCBIV1BUDQo+PiBj
b21pbmcgZnJvbSBWRklPLg0KPj4NCj4+IENvLUF1dGhvcmVkLWJ5OiBZaSBMaXUgPHlpLmwubGl1
QGludGVsLmNvbT4NCj4+IFNpZ25lZC1vZmYtYnk6IFlpIExpdSA8eWkubC5saXVAaW50ZWwuY29t
Pg0KPj4gU2lnbmVkLW9mZi1ieTogWWkgU3VuIDx5aS55LnN1bkBsaW51eC5pbnRlbC5jb20+DQo+
PiBTaWduZWQtb2ZmLWJ5OiBaaGVuemhvbmcgRHVhbiA8emhlbnpob25nLmR1YW5AaW50ZWwuY29t
Pg0KPj4gLS0tDQo+PiAgaHcvaTM4Ni9pbnRlbF9pb21tdV9hY2NlbC5oICAgfCAgIDYgKysNCj4+
ICBpbmNsdWRlL2h3L2kzODYvaW50ZWxfaW9tbXUuaCB8ICAgMSArDQo+PiAgaHcvaTM4Ni9pbnRl
bF9pb21tdS5jICAgICAgICAgfCAgMjIgKysrKysrLQ0KPj4gIGh3L2kzODYvaW50ZWxfaW9tbXVf
YWNjZWwuYyAgIHwgMTE0DQo+KysrKysrKysrKysrKysrKysrKysrKysrKysrKysrKysrKw0KPj4g
IGh3L2kzODYvdHJhY2UtZXZlbnRzICAgICAgICAgIHwgICAzICsNCj4+ICA1IGZpbGVzIGNoYW5n
ZWQsIDE0MyBpbnNlcnRpb25zKCspLCAzIGRlbGV0aW9ucygtKQ0KPj4NCj4+IGRpZmYgLS1naXQg
YS9ody9pMzg2L2ludGVsX2lvbW11X2FjY2VsLmggYi9ody9pMzg2L2ludGVsX2lvbW11X2FjY2Vs
LmgNCj4+IGluZGV4IGRiZTZlZTY5ODIuLjFhMzk2YzUwYTAgMTAwNjQ0DQo+PiAtLS0gYS9ody9p
Mzg2L2ludGVsX2lvbW11X2FjY2VsLmgNCj4+ICsrKyBiL2h3L2kzODYvaW50ZWxfaW9tbXVfYWNj
ZWwuaA0KPj4gQEAgLTE2LDYgKzE2LDcgQEANCj4+ICBib29sIHZ0ZF9jaGVja19oaW9kX2FjY2Vs
KEludGVsSU9NTVVTdGF0ZSAqcywgVlRESG9zdElPTU1VRGV2aWNlDQo+KnZ0ZF9oaW9kLA0KPj4g
ICAgICAgICAgICAgICAgICAgICAgICAgICAgRXJyb3IgKiplcnJwKTsNCj4+ICBWVERIb3N0SU9N
TVVEZXZpY2UgKnZ0ZF9maW5kX2hpb2RfaW9tbXVmZChWVERBZGRyZXNzU3BhY2UgKmFzKTsNCj4+
ICtib29sIHZ0ZF9iaW5kX2d1ZXN0X3Bhc2lkKFZUREFkZHJlc3NTcGFjZSAqdnRkX2FzLCBFcnJv
ciAqKmVycnApOw0KPj4gICNlbHNlDQo+PiAgc3RhdGljIGlubGluZSBib29sIHZ0ZF9jaGVja19o
aW9kX2FjY2VsKEludGVsSU9NTVVTdGF0ZSAqcywNCj4+ICAgICAgICAgICAgICAgICAgICAgICAg
ICAgICAgICAgICAgICAgICAgVlRESG9zdElPTU1VRGV2aWNlDQo+KnZ0ZF9oaW9kLA0KPj4gQEAg
LTMwLDUgKzMxLDEwIEBAIHN0YXRpYyBpbmxpbmUgVlRESG9zdElPTU1VRGV2aWNlDQo+KnZ0ZF9m
aW5kX2hpb2RfaW9tbXVmZChWVERBZGRyZXNzU3BhY2UgKmFzKQ0KPj4gIHsNCj4+ICAgICAgcmV0
dXJuIE5VTEw7DQo+PiAgfQ0KPj4gKw0KPj4gK3N0YXRpYyBpbmxpbmUgYm9vbCB2dGRfYmluZF9n
dWVzdF9wYXNpZChWVERBZGRyZXNzU3BhY2UgKnZ0ZF9hcywgRXJyb3INCj4qKmVycnApDQo+PiAr
ew0KPj4gKyAgICByZXR1cm4gdHJ1ZTsNCj4+ICt9DQo+PiAgI2VuZGlmDQo+PiAgI2VuZGlmDQo+
PiBkaWZmIC0tZ2l0IGEvaW5jbHVkZS9ody9pMzg2L2ludGVsX2lvbW11LmgNCj5iL2luY2x1ZGUv
aHcvaTM4Ni9pbnRlbF9pb21tdS5oDQo+PiBpbmRleCA0MDEzMjI2NjVhLi44Y2U4ZmUxYjc1IDEw
MDY0NA0KPj4gLS0tIGEvaW5jbHVkZS9ody9pMzg2L2ludGVsX2lvbW11LmgNCj4+ICsrKyBiL2lu
Y2x1ZGUvaHcvaTM4Ni9pbnRlbF9pb21tdS5oDQo+PiBAQCAtMTA0LDYgKzEwNCw3IEBAIHN0cnVj
dCBWVERBZGRyZXNzU3BhY2Ugew0KPj4gICAgICBQQ0lCdXMgKmJ1czsNCj4+ICAgICAgdWludDhf
dCBkZXZmbjsNCj4+ICAgICAgdWludDMyX3QgcGFzaWQ7DQo+PiArICAgIHVpbnQzMl90IGZzX2h3
cHQ7DQo+bml0IHVzZSBmc19od3B0X2lkDQoNCldpbGwgZG8uDQoNCj4+ICAgICAgQWRkcmVzc1Nw
YWNlIGFzOw0KPj4gICAgICBJT01NVU1lbW9yeVJlZ2lvbiBpb21tdTsNCj4+ICAgICAgTWVtb3J5
UmVnaW9uIHJvb3Q7ICAgICAgICAgIC8qIFRoZSByb290IGNvbnRhaW5lciBvZiB0aGUgZGV2aWNl
DQo+Ki8NCj4+IGRpZmYgLS1naXQgYS9ody9pMzg2L2ludGVsX2lvbW11LmMgYi9ody9pMzg2L2lu
dGVsX2lvbW11LmMNCj4+IGluZGV4IDUxM2IyYzg1ZDQuLjM2NDQ5YmYxNjEgMTAwNjQ0DQo+PiAt
LS0gYS9ody9pMzg2L2ludGVsX2lvbW11LmMNCj4+ICsrKyBiL2h3L2kzODYvaW50ZWxfaW9tbXUu
Yw0KPj4gQEAgLTg4LDcgKzg4LDExIEBAIHN0YXRpYyB2b2lkDQo+dnRkX3Bhc2lkX2NhY2hlX3Jl
c2V0X2xvY2tlZChJbnRlbElPTU1VU3RhdGUgKnMpDQo+PiAgICAgIGdfaGFzaF90YWJsZV9pdGVy
X2luaXQoJmFzX2l0LCBzLT52dGRfYWRkcmVzc19zcGFjZXMpOw0KPj4gICAgICB3aGlsZSAoZ19o
YXNoX3RhYmxlX2l0ZXJfbmV4dCgmYXNfaXQsIE5VTEwsICh2b2lkICoqKSZ2dGRfYXMpKSB7DQo+
PiAgICAgICAgICBWVERQQVNJRENhY2hlRW50cnkgKnBjX2VudHJ5ID0gJnZ0ZF9hcy0+cGFzaWRf
Y2FjaGVfZW50cnk7DQo+PiAtICAgICAgICBwY19lbnRyeS0+dmFsaWQgPSBmYWxzZTsNCj4+ICsg
ICAgICAgIGlmIChwY19lbnRyeS0+dmFsaWQpIHsNCj4+ICsgICAgICAgICAgICBwY19lbnRyeS0+
dmFsaWQgPSBmYWxzZTsNCj4+ICsgICAgICAgICAgICAvKiBJdCdzIGZhdGFsIHRvIGdldCBmYWls
dXJlIGR1cmluZyByZXNldCAqLw0KPmNvdWxkIHlvdSBlbGFib3JhdGUgb24gdGhpcy4gV2h5IGlz
IGl0IG1vcmUgZmF0YWwgb24gcmVzZXQgdGhhdCBvbiBvdGhlcg0KPmNpcmN1bXN0YW5jZXMgd2hp
Y2ggZG8gbm90IGFib3J0Pw0KDQpEdXJpbmcgcmVzZXQsIHMtPmRtYXJfZW5hYmxlZCBhbmQgcGNf
ZW50cnktPnZhbGlkIGFyZSBib3RoIGZhbHNlLA0Kc28gdnRkX2JpbmRfZ3Vlc3RfcGFzaWQoKSBp
cyBhY3R1YWxseSBhIGNhbGwgdG8NCmhvc3RfaW9tbXVfZGV2aWNlX2lvbW11ZmRfYXR0YWNoX2h3
cHQoaWRldiwgaWRldi0+aHdwdF9pZCwgZXJycCkNCndoaWNoIGRvZXMgYXR0YWNobWVudCB0byBk
ZWZhdWx0IEhXUFQgY29udGFpbmluZyBzaGFkb3cgcGFnZSB0YWJsZS4NClRoaXMgc2hvdWxkIG5l
dmVyIGZhaWwgb3IgZWxzZSB3ZSBoYXZlIGNhdWdodCBpdCBpbiB2ZmlvX3BjaV9yZWFsaXplKCku
DQoNCkZvciB2dGRfYmluZF9ndWVzdF9wYXNpZCgpIGR1cmluZyBwYXNpZCBlbnRyeSBpbnZhbGlk
YXRpb24sIHRoZSBlcnJvciBjYW4NCmNvbWUgZnJvbSB3cm9uZyBmaXJzdCBzdGFnZSBjb25maWcg
YnkgZ3Vlc3QsIHdlIHNob3VsZCBpbmplY3QgZmF1bHQgZXZlbnQNCnRvIGd1ZXN0IGluc3RlYWQg
b2YgYWJvcnQgcWVtdSwgdGhpcyBpcyBjdXJyZW50bHkgbm90IGltcGxlbWVudGVkIHlldCBhbmQN
Cm1hcmtlZCBhcyBUT0RPLg0KDQo+PiArICAgICAgICAgICAgdnRkX2JpbmRfZ3Vlc3RfcGFzaWQo
dnRkX2FzLCAmZXJyb3JfZmF0YWwpOw0KPj4gKyAgICAgICAgfQ0KPj4gICAgICB9DQo+PiAgfQ0K
Pj4NCj4+IEBAIC0zMDc0LDYgKzMwNzgsOCBAQCBzdGF0aWMgdm9pZA0KPnZ0ZF9wYXNpZF9jYWNo
ZV9zeW5jX2xvY2tlZChncG9pbnRlciBrZXksIGdwb2ludGVyIHZhbHVlLA0KPj4gICAgICBWVERQ
QVNJREVudHJ5IHBlOw0KPj4gICAgICBJT01NVU5vdGlmaWVyICpuOw0KPj4gICAgICB1aW50MTZf
dCBkaWQ7DQo+PiArICAgIGNvbnN0IGNoYXIgKmVycl9wcmVmaXggPSAiQXR0YWNoaW5nIHRvIEhX
UFQgZmFpbGVkOiAiOw0KPj4gKyAgICBFcnJvciAqbG9jYWxfZXJyID0gTlVMTDsNCj4+DQo+PiAg
ICAgIGlmICh2dGRfZGV2X2dldF9wZV9mcm9tX3Bhc2lkKHZ0ZF9hcywgJnBlKSkgew0KPj4gICAg
ICAgICAgaWYgKCFwY19lbnRyeS0+dmFsaWQpIHsNCj4+IEBAIC0zMDk0LDcgKzMxMDAsOSBAQCBz
dGF0aWMgdm9pZA0KPnZ0ZF9wYXNpZF9jYWNoZV9zeW5jX2xvY2tlZChncG9pbnRlciBrZXksIGdw
b2ludGVyIHZhbHVlLA0KPj4gICAgICAgICAgICAgIHZ0ZF9hZGRyZXNzX3NwYWNlX3VubWFwKHZ0
ZF9hcywgbik7DQo+PiAgICAgICAgICB9DQo+PiAgICAgICAgICB2dGRfc3dpdGNoX2FkZHJlc3Nf
c3BhY2UodnRkX2FzKTsNCj4+IC0gICAgICAgIHJldHVybjsNCj4+ICsNCj4+ICsgICAgICAgIGVy
cl9wcmVmaXggPSAiRGV0YWNoaW5nIGZyb20gSFdQVCBmYWlsZWQ6ICI7DQo+PiArICAgICAgICBn
b3RvIGRvX2JpbmRfdW5iaW5kOw0KPj4gICAgICB9DQo+Pg0KPj4gICAgICAvKg0KPj4gQEAgLTMx
MjIsMTIgKzMxMzAsMjAgQEAgc3RhdGljIHZvaWQNCj52dGRfcGFzaWRfY2FjaGVfc3luY19sb2Nr
ZWQoZ3BvaW50ZXIga2V5LCBncG9pbnRlciB2YWx1ZSwNCj4+ICAgICAgaWYgKCFwY19lbnRyeS0+
dmFsaWQpIHsNCj4+ICAgICAgICAgIHBjX2VudHJ5LT5wYXNpZF9lbnRyeSA9IHBlOw0KPj4gICAg
ICAgICAgcGNfZW50cnktPnZhbGlkID0gdHJ1ZTsNCj4+IC0gICAgfSBlbHNlIGlmICghdnRkX3Bh
c2lkX2VudHJ5X2NvbXBhcmUoJnBlLCAmcGNfZW50cnktPnBhc2lkX2VudHJ5KSkgew0KPj4gKyAg
ICB9IGVsc2UgaWYgKHZ0ZF9wYXNpZF9lbnRyeV9jb21wYXJlKCZwZSwgJnBjX2VudHJ5LT5wYXNp
ZF9lbnRyeSkpIHsNCj4+ICsgICAgICAgIGVycl9wcmVmaXggPSAiUmVwbGFjaW5nIEhXUFQgYXR0
YWNobWVudCBmYWlsZWQ6ICI7DQo+PiArICAgIH0gZWxzZSB7DQo+PiAgICAgICAgICByZXR1cm47
DQo+PiAgICAgIH0NCj4+DQo+PiAgICAgIHZ0ZF9zd2l0Y2hfYWRkcmVzc19zcGFjZSh2dGRfYXMp
Ow0KPj4gICAgICB2dGRfYWRkcmVzc19zcGFjZV9zeW5jKHZ0ZF9hcyk7DQo+PiArDQo+PiArZG9f
YmluZF91bmJpbmQ6DQo+PiArICAgIC8qIFRPRE86IEZhdWx0IGV2ZW50IGluamVjdGlvbiBpbnRv
IGd1ZXN0LCByZXBvcnQgZXJyb3IgdG8gUUVNVSBmb3INCj5ub3cgKi8NCj4+ICsgICAgaWYgKCF2
dGRfYmluZF9ndWVzdF9wYXNpZCh2dGRfYXMsICZsb2NhbF9lcnIpKSB7DQo+PiArICAgICAgICBl
cnJvcl9yZXBvcnRmX2Vycihsb2NhbF9lcnIsICIlcyIsIGVycl9wcmVmaXgpOw0KPj4gKyAgICB9
DQo+PiAgfQ0KPj4NCj4+ICBzdGF0aWMgdm9pZCB2dGRfcGFzaWRfY2FjaGVfc3luYyhJbnRlbElP
TU1VU3RhdGUgKnMsDQo+VlREUEFTSURDYWNoZUluZm8gKnBjX2luZm8pDQo+PiBkaWZmIC0tZ2l0
IGEvaHcvaTM4Ni9pbnRlbF9pb21tdV9hY2NlbC5jIGIvaHcvaTM4Ni9pbnRlbF9pb21tdV9hY2Nl
bC5jDQo+PiBpbmRleCBlYmZjNTAzZDY0Li42NjU3MGVhOTE5IDEwMDY0NA0KPj4gLS0tIGEvaHcv
aTM4Ni9pbnRlbF9pb21tdV9hY2NlbC5jDQo+PiArKysgYi9ody9pMzg2L2ludGVsX2lvbW11X2Fj
Y2VsLmMNCj4+IEBAIC0xMyw2ICsxMyw3IEBADQo+PiAgI2luY2x1ZGUgImludGVsX2lvbW11X2lu
dGVybmFsLmgiDQo+PiAgI2luY2x1ZGUgImludGVsX2lvbW11X2FjY2VsLmgiDQo+PiAgI2luY2x1
ZGUgImh3L3BjaS9wY2lfYnVzLmgiDQo+PiArI2luY2x1ZGUgInRyYWNlLmgiDQo+Pg0KPj4gIGJv
b2wgdnRkX2NoZWNrX2hpb2RfYWNjZWwoSW50ZWxJT01NVVN0YXRlICpzLCBWVERIb3N0SU9NTVVE
ZXZpY2UNCj4qdnRkX2hpb2QsDQo+PiAgICAgICAgICAgICAgICAgICAgICAgICAgICBFcnJvciAq
KmVycnApDQo+PiBAQCAtNjgsMyArNjksMTE2IEBAIFZUREhvc3RJT01NVURldmljZQ0KPip2dGRf
ZmluZF9oaW9kX2lvbW11ZmQoVlREQWRkcmVzc1NwYWNlICphcykNCj4+ICAgICAgfQ0KPj4gICAg
ICByZXR1cm4gTlVMTDsNCj4+ICB9DQo+PiArDQo+PiArc3RhdGljIGJvb2wgdnRkX2NyZWF0ZV9m
c19od3B0KEhvc3RJT01NVURldmljZUlPTU1VRkQgKmlkZXYsDQo+PiArICAgICAgICAgICAgICAg
ICAgICAgICAgICAgICAgIFZURFBBU0lERW50cnkgKnBlLCB1aW50MzJfdA0KPipmc19od3B0LA0K
Pj4gKyAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICBFcnJvciAqKmVycnApDQo+PiArew0K
Pj4gKyAgICBzdHJ1Y3QgaW9tbXVfaHdwdF92dGRfczEgdnRkID0ge307DQo+PiArDQo+PiArICAg
IHZ0ZC5mbGFncyA9IChWVERfU01fUEFTSURfRU5UUllfU1JFKHBlKSA/IElPTU1VX1ZURF9TMV9T
UkUgOg0KPjApIHwNCj4+ICsgICAgICAgICAgICAgICAgKFZURF9TTV9QQVNJRF9FTlRSWV9XUEUo
cGUpID8NCj5JT01NVV9WVERfUzFfV1BFIDogMCkgfA0KPj4gKyAgICAgICAgICAgICAgICAoVlRE
X1NNX1BBU0lEX0VOVFJZX0VBRkUocGUpID8NCj5JT01NVV9WVERfUzFfRUFGRSA6IDApOw0KPj4g
KyAgICB2dGQuYWRkcl93aWR0aCA9IHZ0ZF9wZV9nZXRfZnNfYXcocGUpOw0KPj4gKyAgICB2dGQu
cGd0YmxfYWRkciA9ICh1aW50NjRfdCl2dGRfcGVfZ2V0X2ZzcHRfYmFzZShwZSk7DQo+PiArDQo+
PiArICAgIHJldHVybiBpb21tdWZkX2JhY2tlbmRfYWxsb2NfaHdwdChpZGV2LT5pb21tdWZkLCBp
ZGV2LT5kZXZpZCwNCj5pZGV2LT5od3B0X2lkLA0KPj4gKyAgICAgICAgICAgICAgICAgICAgICAg
ICAgICAgICAgICAgICAgMCwNCj5JT01NVV9IV1BUX0RBVEFfVlREX1MxLCBzaXplb2YodnRkKSwN
Cj4+ICsgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICZ2dGQsIGZzX2h3cHQs
IGVycnApOw0KPj4gK30NCj4+ICsNCj4+ICtzdGF0aWMgdm9pZCB2dGRfZGVzdHJveV9vbGRfZnNf
aHdwdChIb3N0SU9NTVVEZXZpY2VJT01NVUZEICppZGV2LA0KPj4gKyAgICAgICAgICAgICAgICAg
ICAgICAgICAgICAgICAgICAgIFZUREFkZHJlc3NTcGFjZSAqdnRkX2FzKQ0KPj4gK3sNCj4+ICsg
ICAgaWYgKCF2dGRfYXMtPmZzX2h3cHQpIHsNCj4+ICsgICAgICAgIHJldHVybjsNCj4+ICsgICAg
fQ0KPj4gKyAgICBpb21tdWZkX2JhY2tlbmRfZnJlZV9pZChpZGV2LT5pb21tdWZkLCB2dGRfYXMt
PmZzX2h3cHQpOw0KPj4gKyAgICB2dGRfYXMtPmZzX2h3cHQgPSAwOw0KPmlzIGl0IGEgdmFsaWQg
YXNzdW1wdGlvbiBhIHZhbGlkIElEIGNhbm5vdCBiZSBudWxsPyBJcyBpdCBkb2N1bWVudGVkDQo+
c29tZXdoZXJlPw0KDQpJIGRpZG4ndCBmaW5kIGl0IGluIHVBUEkgZG9jLCBidXQgaXQncyBoYXJk
IGNvZGVkIGluIGtlcm5lbDoNCg0KeGFfaW5pdF9mbGFncygmaWN0eC0+b2JqZWN0cywgWEFfRkxB
R1NfQUxMT0MxIHwgWEFfRkxBR1NfQUNDT1VOVCk7DQoNCkhpIEBqYXNvd2FuZ0ByZWRoYXQuY29t
LCBAbmljb2xpbmNAbnZpZGlhLmNvbSBkbyB5b3UgaGF2ZSBhIGd1aWRlbGluZSBvbiB0aGlzPw0K
Q291bGQgSSB0YWtlIHplcm8gaWQgcmVzZXJ2ZWQ/DQoNCj4+ICt9DQo+PiArDQo+PiArc3RhdGlj
IGJvb2wgdnRkX2RldmljZV9hdHRhY2hfaW9tbXVmZChWVERIb3N0SU9NTVVEZXZpY2UNCj4qdnRk
X2hpb2QsDQo+PiArICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICBWVERBZGRy
ZXNzU3BhY2UgKnZ0ZF9hcywNCj5FcnJvciAqKmVycnApDQo+PiArew0KPj4gKyAgICBIb3N0SU9N
TVVEZXZpY2VJT01NVUZEICppZGV2ID0NCj5IT1NUX0lPTU1VX0RFVklDRV9JT01NVUZEKHZ0ZF9o
aW9kLT5oaW9kKTsNCj4+ICsgICAgVlREUEFTSURFbnRyeSAqcGUgPSAmdnRkX2FzLT5wYXNpZF9j
YWNoZV9lbnRyeS5wYXNpZF9lbnRyeTsNCj4+ICsgICAgdWludDMyX3QgaHdwdF9pZDsNCj5uaXQg
aW5pdCB0b8KgaWRldi0+aHdwdF9pZA0KDQpXaWxsIGRvLg0KDQo+PiArICAgIGJvb2wgcmV0Ow0K
Pj4gKw0KPj4gKyAgICAvKg0KPj4gKyAgICAgKiBXZSBjYW4gZ2V0IGhlcmUgb25seSBpZiBmbHRz
PW9uLCB0aGUgc3VwcG9ydGVkIFBHVFQgaXMgRlNUIG9yIFBULg0KPj4gKyAgICAgKiBDYXRjaCBp
bnZhbGlkIFBHVFQgd2hlbiBwcm9jZXNzaW5nIGludmFsaWRhdGlvbiByZXF1ZXN0IHRvIGF2b2lk
DQo+PiArICAgICAqIGF0dGFjaGluZyB0byB3cm9uZyBod3B0Lg0KPj4gKyAgICAgKi8NCj4+ICsg
ICAgaWYgKCF2dGRfcGVfcGd0dF9pc19mc3QocGUpICYmICF2dGRfcGVfcGd0dF9pc19wdChwZSkp
IHsNCj4+ICsgICAgICAgIGVycm9yX3NldGcoZXJycCwgIkludmFsaWQgUEdUVCB0eXBlICVkIiwN
Cj4+ICsgICAgICAgICAgICAgICAgICAgKHVpbnQ4X3QpVlREX1NNX1BBU0lEX0VOVFJZX1BHVFQo
cGUpKTsNCj4+ICsgICAgICAgIHJldHVybiBmYWxzZTsNCj4+ICsgICAgfQ0KPj4gKw0KPj4gKyAg
ICBpZiAodnRkX3BlX3BndHRfaXNfcHQocGUpKSB7DQo+PiArICAgICAgICBod3B0X2lkID0gaWRl
di0+aHdwdF9pZDsNCj4+ICsgICAgfSBlbHNlIGlmICghdnRkX2NyZWF0ZV9mc19od3B0KGlkZXYs
IHBlLCAmaHdwdF9pZCwgZXJycCkpIHsNCj4+ICsgICAgICAgIHJldHVybiBmYWxzZTsNCj4+ICsg
ICAgfQ0KPmFuZA0KPg0KPmlmICh2dGRfcGVfcGd0dF9pc19mc3QocGUpKSB7DQo+ICAgIGlmICgo
IXZ0ZF9jcmVhdGVfZnNfaHdwdChpZGV2LCBwZSwgJmh3cHRfaWQsIGVycnApIHsNCj4gICAgICAg
IHJldHVybiBmYWxzZTsNCj4gICAgfQ0KPg0KPn0NCj50aGlzIHdpbGwgbWF0Y2ggZnJlZSBibG9j
ayBiZWxvdw0KDQpXaWxsIGRvDQoNCj4+ICsNCj4+ICsgICAgcmV0ID0gaG9zdF9pb21tdV9kZXZp
Y2VfaW9tbXVmZF9hdHRhY2hfaHdwdChpZGV2LCBod3B0X2lkLA0KPmVycnApOw0KPj4gKyAgICB0
cmFjZV92dGRfZGV2aWNlX2F0dGFjaF9od3B0KGlkZXYtPmRldmlkLCB2dGRfYXMtPnBhc2lkLCBo
d3B0X2lkLA0KPnJldCk7DQo+PiArICAgIGlmIChyZXQpIHsNCj4+ICsgICAgICAgIC8qIERlc3Ry
b3kgb2xkIGZzX2h3cHQgaWYgaXQncyBhIHJlcGxhY2VtZW50ICovDQo+PiArICAgICAgICB2dGRf
ZGVzdHJveV9vbGRfZnNfaHdwdChpZGV2LCB2dGRfYXMpOw0KPj4gKyAgICAgICAgaWYgKHZ0ZF9w
ZV9wZ3R0X2lzX2ZzdChwZSkpIHsNCj4+ICsgICAgICAgICAgICB2dGRfYXMtPmZzX2h3cHQgPSBo
d3B0X2lkOw0KPj4gKyAgICAgICAgfQ0KPj4gKyAgICB9IGVsc2UgaWYgKHZ0ZF9wZV9wZ3R0X2lz
X2ZzdChwZSkpIHsNCj4+ICsgICAgICAgIGlvbW11ZmRfYmFja2VuZF9mcmVlX2lkKGlkZXYtPmlv
bW11ZmQsIGh3cHRfaWQpOw0KPj4gKyAgICB9DQo+PiArDQo+PiArICAgIHJldHVybiByZXQ7DQo+
PiArfQ0KPj4gKw0KPj4gK3N0YXRpYyBib29sIHZ0ZF9kZXZpY2VfZGV0YWNoX2lvbW11ZmQoVlRE
SG9zdElPTU1VRGV2aWNlDQo+KnZ0ZF9oaW9kLA0KPj4gKyAgICAgICAgICAgICAgICAgICAgICAg
ICAgICAgICAgICAgICAgVlREQWRkcmVzc1NwYWNlICp2dGRfYXMsDQo+RXJyb3IgKiplcnJwKQ0K
Pj4gK3sNCj4+ICsgICAgSG9zdElPTU1VRGV2aWNlSU9NTVVGRCAqaWRldiA9DQo+SE9TVF9JT01N
VV9ERVZJQ0VfSU9NTVVGRCh2dGRfaGlvZC0+aGlvZCk7DQo+PiArICAgIEludGVsSU9NTVVTdGF0
ZSAqcyA9IHZ0ZF9hcy0+aW9tbXVfc3RhdGU7DQo+PiArICAgIHVpbnQzMl90IHBhc2lkID0gdnRk
X2FzLT5wYXNpZDsNCj4+ICsgICAgYm9vbCByZXQ7DQo+PiArDQo+PiArICAgIGlmIChzLT5kbWFy
X2VuYWJsZWQgJiYgcy0+cm9vdF9zY2FsYWJsZSkgew0KPj4gKyAgICAgICAgcmV0ID0gaG9zdF9p
b21tdV9kZXZpY2VfaW9tbXVmZF9kZXRhY2hfaHdwdChpZGV2LCBlcnJwKTsNCj4+ICsgICAgICAg
IHRyYWNlX3Z0ZF9kZXZpY2VfZGV0YWNoX2h3cHQoaWRldi0+ZGV2aWQsIHBhc2lkLCByZXQpOw0K
Pj4gKyAgICB9IGVsc2Ugew0KPj4gKyAgICAgICAgLyoNCj4+ICsgICAgICAgICAqIElmIERNQVIg
cmVtYXBwaW5nIGlzIGRpc2FibGVkIG9yIGd1ZXN0IHN3aXRjaGVzIHRvIGxlZ2FjeQ0KPm1vZGUs
DQo+PiArICAgICAgICAgKiB3ZSBmYWxsYmFjayB0byB0aGUgZGVmYXVsdCBIV1BUIHdoaWNoIGNv
bnRhaW5zIHNoYWRvdyBwYWdlDQo+dGFibGUuDQo+PiArICAgICAgICAgKiBTbyBndWVzdCBETUEg
Y291bGQgc3RpbGwgd29yay4NCj4+ICsgICAgICAgICAqLw0KPj4gKyAgICAgICAgcmV0ID0gaG9z
dF9pb21tdV9kZXZpY2VfaW9tbXVmZF9hdHRhY2hfaHdwdChpZGV2LA0KPmlkZXYtPmh3cHRfaWQs
IGVycnApOw0KPj4gKyAgICAgICAgdHJhY2VfdnRkX2RldmljZV9yZWF0dGFjaF9kZWZfaHdwdChp
ZGV2LT5kZXZpZCwgcGFzaWQsDQo+aWRldi0+aHdwdF9pZCwNCj4+ICsgICAgICAgICAgICAgICAg
ICAgICAgICAgICAgICAgICAgICAgICAgICAgcmV0KTsNCj4+ICsgICAgfQ0KPj4gKw0KPj4gKyAg
ICBpZiAocmV0KSB7DQo+PiArICAgICAgICB2dGRfZGVzdHJveV9vbGRfZnNfaHdwdChpZGV2LCB2
dGRfYXMpOw0KPj4gKyAgICB9DQo+PiArDQo+PiArICAgIHJldHVybiByZXQ7DQo+PiArfQ0KPj4g
Kw0KPj4gK2Jvb2wgdnRkX2JpbmRfZ3Vlc3RfcGFzaWQoVlREQWRkcmVzc1NwYWNlICp2dGRfYXMs
IEVycm9yICoqZXJycCkNCj5JIGZpbmQgaXQgYSBsaXR0bGUgYml0IGNvbmZ1c2luZyB0byBoYXZl
IGJpbmQgZG9pbmcgdGhlIHVuYmluZCB0b28uDQo+YXQgbGVhc3QgSSB3b3VsZCByZW5hbWUgaW50
byB2dGRfcHJvcGFnYXRlX2d1ZXN0X3Bhc2lkIG9yIHNvbWV0aGluZyBhbGlrZS4NCg0KSW5kZWVk
LCBJIGhhZCBldmVyIHRob3VnaHQgdG8gdXNlIHZ0ZF9iaW5kX3VuYmluZF9ndWVzdF9wYXNpZC4u
Lg0KdnRkX3Byb3BhZ2F0ZV9ndWVzdF9wYXNpZCBzb3VuZHMgYmV0dGVyLCB3aWxsIHVzZSBpdC4N
Cg0KVGhhbmtzDQpaaGVuemhvbmcNCg==

