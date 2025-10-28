Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7452ECCF9E0
	for <qemu-devel@archiver.kernel.org>; Tue, 28 Oct 2025 09:30:04 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vDg0p-000805-4P; Tue, 28 Oct 2025 05:29:07 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <zhenzhong.duan@intel.com>)
 id 1vDg0l-0007yT-T4
 for qemu-devel@nongnu.org; Tue, 28 Oct 2025 05:29:04 -0400
Received: from mgamail.intel.com ([192.198.163.13])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <zhenzhong.duan@intel.com>)
 id 1vDg0i-0003Jb-3x
 for qemu-devel@nongnu.org; Tue, 28 Oct 2025 05:29:03 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1761643740; x=1793179740;
 h=from:to:cc:subject:date:message-id:references:
 in-reply-to:content-transfer-encoding:mime-version;
 bh=+ISV3fLL3LRd0qwojQ2QtQOOUYDTkn/tKb6g+37oOwg=;
 b=W9K999wbPuZBQbTMZ2ii28j6WqhyO9y0gv785r5bMMKc4CtU57jsHzSc
 QBiuZqaDHohAiUSen4VGvckFB5h0OwxuQ2JrURi7lJnqmsJKZIGLli+56
 MWCmhtgAFnyGEljUDoxMVbtmG1/lhG20nQ0at9ATRTTFj5cADMVHMtRch
 HgQPB8+xhR9BWlL71FTanpQJNHRFQtJKExUvwBEqnPMUCtmSc8tirC5Pq
 v1bdY6B7/9NpNA5UrB6Vvcg9WADLHyPddc+xqE2xjl43z1PFmPuqJ9BXl
 0M7Odn73B9FpHIMsSMhW+Tl2LozdyOrU3ndW4MbCiUBHGyL3uVMucVoLu w==;
X-CSE-ConnectionGUID: ZiL/UzpAQlueeMzWBATSJQ==
X-CSE-MsgGUID: KWSojpJ8S324ogdYaMxpVA==
X-IronPort-AV: E=McAfee;i="6800,10657,11586"; a="66355076"
X-IronPort-AV: E=Sophos;i="6.19,261,1754982000"; d="scan'208";a="66355076"
Received: from orviesa004.jf.intel.com ([10.64.159.144])
 by fmvoesa107.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 28 Oct 2025 02:28:56 -0700
X-CSE-ConnectionGUID: RbWUDLk0TUe4C+0QMYzcXw==
X-CSE-MsgGUID: HVNbagcxSwqWsk20QQx61A==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.19,261,1754982000"; d="scan'208";a="189609384"
Received: from orsmsx902.amr.corp.intel.com ([10.22.229.24])
 by orviesa004.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 28 Oct 2025 02:28:56 -0700
Received: from ORSMSX901.amr.corp.intel.com (10.22.229.23) by
 ORSMSX902.amr.corp.intel.com (10.22.229.24) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.27; Tue, 28 Oct 2025 02:28:55 -0700
Received: from ORSEDG902.ED.cps.intel.com (10.7.248.12) by
 ORSMSX901.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.27 via Frontend Transport; Tue, 28 Oct 2025 02:28:55 -0700
Received: from PH0PR06CU001.outbound.protection.outlook.com (40.107.208.58) by
 edgegateway.intel.com (134.134.137.112) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.27; Tue, 28 Oct 2025 02:28:55 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=ZA6CQcYNUwkOjwrFBPltB5e5RNHyxo5hGhzYhjKK7P7HPSJtRI7EEV6+ti79O9dqFrOBQYmk1OOejVHDwaSOh8q2eA4Vn04XqEheALKm3milZ5QtE+b9/RgK+x0UsYyM1zLFGfSGclzmiH1prXZIIqsESxkt8PDM9YcCsH20szDp/T454gD0UyDW1q6BgacBDkw37xcyT0vTVbx6xd9eJE6mqn93+aH2xWh7YzGs0wl4l8ZWKs0oMml2s3iOBJM7YUJItu1vxX+Ld4G1/ZeKDxSTgJpNXMio51mZ19tHNEnMWgUVfgfi698Iq6Dfr8TIwl8dKJOkYReBqg/C55dNUg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=+ISV3fLL3LRd0qwojQ2QtQOOUYDTkn/tKb6g+37oOwg=;
 b=wAWWwiksrSDFGd40Q6Q+1msTNYhnTsqh8UvGHxW/pF8/ZVRI5wzlccyQcqP4tDPhHyu3cn9PJhMmtEahuqZ+LeRsW4PL6A821TLh1M8aJMKfslpSvEuh/FPxZxpY4OUjL8mZb//2fYo4N+Z+xoE6m0OF6O5kGmBj9YyPeFt3rv7StsV2WJuYrbVJSfh2EyB2AMijqwX8mGD/rZ70Ke7bMxUWawrcKGvBflMW39cNyCs+LOo1ok5gtUCjyfTyIl6x1UoGvYEW2hVqAOMjfIhkKFAu3JCc8z24y2Kj2dHp+cuT9womVrUfOFr3oWvuSx9LO67zSbuw7jWcaNHfhmriBg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Received: from IA3PR11MB9136.namprd11.prod.outlook.com (2603:10b6:208:574::12)
 by SJ0PR11MB5813.namprd11.prod.outlook.com (2603:10b6:a03:422::19)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9253.19; Tue, 28 Oct
 2025 09:28:53 +0000
Received: from IA3PR11MB9136.namprd11.prod.outlook.com
 ([fe80::604b:77a4:b1be:3f13]) by IA3PR11MB9136.namprd11.prod.outlook.com
 ([fe80::604b:77a4:b1be:3f13%7]) with mapi id 15.20.9253.017; Tue, 28 Oct 2025
 09:28:52 +0000
From: "Duan, Zhenzhong" <zhenzhong.duan@intel.com>
To: =?utf-8?B?Q8OpZHJpYyBMZSBHb2F0ZXI=?= <clg@redhat.com>,
 "qemu-devel@nongnu.org" <qemu-devel@nongnu.org>
CC: "alex.williamson@redhat.com" <alex.williamson@redhat.com>,
 "eric.auger@redhat.com" <eric.auger@redhat.com>, "mst@redhat.com"
 <mst@redhat.com>, "jasowang@redhat.com" <jasowang@redhat.com>,
 "peterx@redhat.com" <peterx@redhat.com>, "ddutile@redhat.com"
 <ddutile@redhat.com>, "jgg@nvidia.com" <jgg@nvidia.com>,
 "nicolinc@nvidia.com" <nicolinc@nvidia.com>, "skolothumtho@nvidia.com"
 <skolothumtho@nvidia.com>, "joao.m.martins@oracle.com"
 <joao.m.martins@oracle.com>, "clement.mathieu--drif@eviden.com"
 <clement.mathieu--drif@eviden.com>, "Tian, Kevin" <kevin.tian@intel.com>,
 "Liu, Yi L" <yi.l.liu@intel.com>, "Peng, Chao P" <chao.p.peng@intel.com>
Subject: RE: [PATCH v7 17/23] iommufd: Introduce a helper function to extract
 vendor capabilities
Thread-Topic: [PATCH v7 17/23] iommufd: Introduce a helper function to extract
 vendor capabilities
Thread-Index: AQHcRMKaUSVhoEqzPU6ka5EncKvfDLTRj2AAgAXBFaA=
Date: Tue, 28 Oct 2025 09:28:52 +0000
Message-ID: <IA3PR11MB91361CF5D5CDE271DC9AC97D92FDA@IA3PR11MB9136.namprd11.prod.outlook.com>
References: <20251024084349.102322-1-zhenzhong.duan@intel.com>
 <20251024084349.102322-18-zhenzhong.duan@intel.com>
 <ea677402-3548-4923-9e5a-49c8fc7ef9e7@redhat.com>
In-Reply-To: <ea677402-3548-4923-9e5a-49c8fc7ef9e7@redhat.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: IA3PR11MB9136:EE_|SJ0PR11MB5813:EE_
x-ms-office365-filtering-correlation-id: 8cfa127e-54c0-46bf-cc8a-08de160468eb
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
 ARA:13230040|1800799024|7416014|376014|366016|38070700021; 
x-microsoft-antispam-message-info: =?utf-8?B?VjFGM05zZVlYOXpSYmtKOHVSZEJvNFpINkdqWVNhcWdyMWNVUUJJcHdoeTFI?=
 =?utf-8?B?dFEwaS8vUjJROWM0SWhxUHV1S3RvVE0zeHVDRkRXVFRsYS9tdGZkS1I3Nmtr?=
 =?utf-8?B?eTBmN2k3VGJNNlNLM1NLR3luTnhjdnU5aDZkSkhidnR3WGkydWwxNUhzdktq?=
 =?utf-8?B?OWp2WjIvYy9ubkFXNWdHNmk4THBnOVNOb0dHRHdla082cHJwa3NOZDMyZzZQ?=
 =?utf-8?B?YzN3dHBsWXlDak9UVXpMaWpZRFVHZkUwSlZDbklTRDdHNnlDeXlhVkp0MXo1?=
 =?utf-8?B?QUtYa1krUWhpc3N4ek5UeWRKUHQrcEFVd0tVVmxadFNXSUJVVGlib1hnRys0?=
 =?utf-8?B?LzhaczhVSExmOEdhVmk1ZlF1UDdmZDVyZEtLQjhnTVBZNzBOdUlObUJoRE1o?=
 =?utf-8?B?dTFranJSUkxNa2wzZi9vOVZiL0Fzc0l1K3BmOWR2M1FsM2E0UFVRekU2Ny96?=
 =?utf-8?B?RWJYTUk5aWJHSVg2ZjE3RGcxd1F1ZGNYY1NFZ3VVczJ1TkdTUllqYmJ3ZjNm?=
 =?utf-8?B?UVNwclZtNnZEOG9SdU1DUExvZ1FpbVk2QnFoaVkzYTZPU3d6TDZUaTlodnM1?=
 =?utf-8?B?Ti8rSUY3eVoyc2wrc1RPRGFNQWM4bzU0cU9Ma3ZNelRQWjR3ZzhUaUltUUtU?=
 =?utf-8?B?QmljQi9COGhzQ3BHNCtzVks4L2FFeU8zT29kWGhPUXFlaUVVZDQ3ekhBUmht?=
 =?utf-8?B?Y1ZmaTk5M0d2MEl4aUhmQWppQW9TM2x5Yjl0YlphNzlRbFAzNkZqTEExMlVS?=
 =?utf-8?B?WFh1bmdQK1dEaEZqM3hMM2kvOWd4c0VLbGUvVlFHdmZWVEZwQ3lrcVJzMHNn?=
 =?utf-8?B?b2QzYW55TE5LUkdCakhMZVpRdkFjWngyOG9nQi9salJpdzFDcEdTS09aTE5V?=
 =?utf-8?B?NGpwQkFGYUZxWFdVZzhsQ2JHRXZ2NXZrK1B5L3Vkb1pjTCtqelVidHNPZVpQ?=
 =?utf-8?B?TG1Rc3lTNWd0RTVsNHp5VXJTT2hVQVlkM0d0WXhtN2huZkRtbmNXLzdKdVE0?=
 =?utf-8?B?TC96ZDh3cnVjZUgzQUFCRlloWFZRWXlnN21FcE9PU21kRlRBMzIzazRKaUJF?=
 =?utf-8?B?ODFkT2NmUnZVamxYdG9UNEJpY1UwelBOWWw0bjU5YzdSc3F1RitPRG0xL2Iv?=
 =?utf-8?B?YnlTM0lPU2lOdGNaL3lJdlRIb0x0aG5laTN4cWE1Q29xdUFKdFlFRFVyQWhy?=
 =?utf-8?B?V1N3NmlDU3J4SFdodkFZa3Y4dFBhVTNObFNKTUlmQURvYkh5VkZSRmVJNXVq?=
 =?utf-8?B?T3cvSzdRNmtyOTlrVkdpbzVsOE5JeEpWZXJHOFRlK0NVeUt0dmZ6a0kvOVVT?=
 =?utf-8?B?c3U2NHRxNDd5eWk1WnZuSzVkb1JuWTl3VUVwVnhiVlAwWitLeGFtREpFRllC?=
 =?utf-8?B?a2VWT1ozcDVYend0YWF0cWFIZDBWR280UmdNeUR3Vyt3eWVVQ3VVQldkWkJF?=
 =?utf-8?B?ekorcFhSajdpY0UrWDFhTXdFOU91aTRNZ3BkaHQxYkRWYm1UMHBEMmNTOGlv?=
 =?utf-8?B?VktlbjhCcGlHNE4vVnhja1U5NGZMWGpnZ09ramZ6MmV0cDJ6dUI3VlZaQm5h?=
 =?utf-8?B?RVh3SlUwWmI2WUtac3dMZ2p0bU5qbmp5NnVhWC9DZUVjMEc2ejhmOHM4eGhm?=
 =?utf-8?B?Rm9tdEVMcWxacHVveWIvS0w2Vjd5N00rblh4dExQR2paQzc0RzlUaCtEN2Y4?=
 =?utf-8?B?ZTB4SUF3VE5xeHVGSW5TbjhiK3hlTXFZUFQxcTVoNVRRWUVDaUlsTGIrRTJ3?=
 =?utf-8?B?eUF5b1psb1JvaHVnSXJEYlBiVm9EQ0NySjJxc01yZVZBTUYyVjhsR3NnbFNj?=
 =?utf-8?B?NW9MdEowUG9MYXZ0VEt2aUNMQVpxTHhkaDZjMmc0emU1Z0FwYk56c1lZM25y?=
 =?utf-8?B?MktBeTFpbWNFVENzaHljMHRSVnhGZzc5ek54UFJPRUlyVXFzNDFWZVJoai9P?=
 =?utf-8?B?N2I3aEZVK0gvK3BvK3NkY0FYYmlLVnNJa0tmNWtvT0h5VzZVdWV0cyswckZ5?=
 =?utf-8?B?d01ham44eHl2eUlic3B4azBCN1Y3YVhSM1lLdFdqOWIzdFQ0Q3NtbHZlSS9u?=
 =?utf-8?Q?mTjXKk?=
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:IA3PR11MB9136.namprd11.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(1800799024)(7416014)(376014)(366016)(38070700021); DIR:OUT;
 SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?cmdUckcvUzc2RTYvbDZFNkM4aUpiVlZBOGhxTk8rZCt0K3V5UkhIQVFGSldH?=
 =?utf-8?B?WCtUa2htWVYvU2ZXVUtFaE5iWmUxb2lKU0xNUUhJRDEvVGZaYStvV05FaDJa?=
 =?utf-8?B?Y3hWUmdadGRhdmJKL0hWcHA1bzZ0MXcxNnQxZ1gySGdwS1o5Y0ptN2hRNmlq?=
 =?utf-8?B?YmdCUEdVR25VMHcrcTNCb2JETHA2OWs4UkNpWlJIdnRmVmVzZlNJSjhET2lB?=
 =?utf-8?B?NjFoblN5MitEN2g2Sis5cElwZXRjTnVzZXVLNEJjazRFL29mQis1OUhNSHkv?=
 =?utf-8?B?N2xQMnBYZmtFenVEbGZVd1lTcE1JLzhvTHpJRDVGWDRLNnVmT1Z2bUNDRnNI?=
 =?utf-8?B?N1VOVGFiNUk3M0dQWGJhbm96VlNjRFdzNFpYWndBek9NRFo0Vm1EVGNJT2or?=
 =?utf-8?B?TGdFQjZaUjhSUzc1WDExenZQcFgzV3ZrVzhtSUxZb20raUh1NS8xTktqTTQw?=
 =?utf-8?B?aTVFckFPQjluejBoQjJHK3ptT0hpQlUwNnQ3SmgrcXc2R0VPT0xHK0RVSXZM?=
 =?utf-8?B?QnBiOGt0azFMMHIyQmlaUHBHcFNhYUw2WnVGTjg2bmZaVmJqNU4ySFdnT1d0?=
 =?utf-8?B?VGtQR2J4aWcxQW1ERVhHREpxNHZlamNla3c5RHN4R0ozMUpMK1drSWM0NEZr?=
 =?utf-8?B?VzZNZ0R3OTU1SjlBY2xzQkdSMmtoT0hTZjhqSThYQjc2RjdVS3hhUHVFUnE2?=
 =?utf-8?B?ODZZc3dmVHBvdFNxcVF1R0RSK0hPOExTUHB5Um5uUG9yNW9vNVliMGk1bkZo?=
 =?utf-8?B?cUpabForM0ZzWHBySTNCc2RSQVVQUlFFa2tRdlQvNytZYVg4MXlHZTdPVkZ3?=
 =?utf-8?B?eTh1OFc4OXFKRWcwaThWNXNBVmlOV3YxaUhZS1J5MmJMdTcyQ1g5d3hzQm5N?=
 =?utf-8?B?L0NYS0VmVU9sS0UvdDR1VnBXKy85bFZvY3F6YlV5dkpFTHR0c3BVZ3RDRy92?=
 =?utf-8?B?SzVTS3BMemgxMnc2YVhYd3hmM3V1bEdHYi8wMTljODh5V0gvQmZzV0s0czdG?=
 =?utf-8?B?VVpwNFhzanJ6VmRRZ1g3UFdJRThYYjVyRXJpL2V5d3pjbmhYZDdkZ2wwcnhQ?=
 =?utf-8?B?dnlhNjN0aDl6V1lsNmRKbE9MR0tJeXRSTDRPaWkvZ0VLc3RyYTlEVzJ6cmp6?=
 =?utf-8?B?SlY2M2Q5NDM0a2hYclVyNkFrUVJ1L0ozRmZuSHQvN2xQS21OSURnZWVIU0Q0?=
 =?utf-8?B?Y3FkMFQ3b2swK2lYS1VRV2FXZXBSeXhPZW1mT0w4VnlzR0VFdlZZMHhqYlBJ?=
 =?utf-8?B?Q2tPSG5qT1BMcTd0bzE5cjZwVkZlNVF1NEhzZWZTOW1ka3R6M1pObWd4VTVY?=
 =?utf-8?B?bkc5ZHNrWVBITVQ1aDJIVmtQWU5DMCtodDc2UUI2VDM3T3VLcVBzVncybEk0?=
 =?utf-8?B?bWFTd3JVTks1a0c1dzdCRHFaY2U0UEZsNVNwbUpIb1VPOFVXeWFRQUFleStt?=
 =?utf-8?B?WGlrUTVZbW5sVUJLbnhXbksxNG9walNUdWlQTzRweldOTkZrSUpLeU13dU5D?=
 =?utf-8?B?VVNYRytjcG1DRVhCRXFacGJHbmVDU3l1YklqS29YSGRNazdBYWw0Z2czRFNZ?=
 =?utf-8?B?blhGejNZOG85RnhERFNXVTgxeE5LSGRQSkVxaHBPY3dwZEJIcktyQ2RaRGpt?=
 =?utf-8?B?RDQ3V1p4R005cVhDTjBwTlVGT2h2WmVTVmp2bXEva211cnV1RytGcUo1WVZX?=
 =?utf-8?B?ZXY1VlBYNnJzc1ZISnZaSktkMzBuUnhaU1FBOUYyNmxUeUdyUGlCOHkrY3NF?=
 =?utf-8?B?dEVQQ0plNFFmTmZqclB2ZTQwcVJPWE10UkxmOFFHekhvK3htU3hmNnZEYWxh?=
 =?utf-8?B?QUQxOHN3ODlVRkxaMCthdDJxNjY4RWYxUzNQalRMck5YN09RZ1hIRDRLSUhE?=
 =?utf-8?B?cHp6OWUrcWFvT2trekJ1Q2hSSDl0VWhyRGgwNmlVZFpTMElTUUdoWVRVTUtG?=
 =?utf-8?B?ak1vZHB6S1lyaUR6WVlIU1o3Tlc2N0FHYS9HUHkyUlVPVTF2c1lkc1FnV2NK?=
 =?utf-8?B?bXBiK1RhbGo4SWJxSXdiekFBYlVvZmkydnM5TElicGZvbG05UjVJR1V3b05Z?=
 =?utf-8?B?dHhnRnhtbG5jQXNzR3YzYS9YUVNwVzk1OUQxRW5WaGZRakpjQkdINzREL0ZG?=
 =?utf-8?Q?ebZ7ADAIuhhyU6DZkQqIzzu2I?=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: IA3PR11MB9136.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 8cfa127e-54c0-46bf-cc8a-08de160468eb
X-MS-Exchange-CrossTenant-originalarrivaltime: 28 Oct 2025 09:28:52.8914 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: sak4/zzjO41BIF5Tw9daM7ljpz3awz9iEewvB15ue2BM7g2qeDQ4pIEEE+Av23WQcLrB3PnCoYCfso9Chb1HqPn0WUAEEUT/1tX/4zLpZRI=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ0PR11MB5813
X-OriginatorOrg: intel.com
Received-SPF: pass client-ip=192.198.163.13;
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

DQoNCj4tLS0tLU9yaWdpbmFsIE1lc3NhZ2UtLS0tLQ0KPkZyb206IEPDqWRyaWMgTGUgR29hdGVy
IDxjbGdAcmVkaGF0LmNvbT4NCj5TdWJqZWN0OiBSZTogW1BBVENIIHY3IDE3LzIzXSBpb21tdWZk
OiBJbnRyb2R1Y2UgYSBoZWxwZXIgZnVuY3Rpb24gdG8NCj5leHRyYWN0IHZlbmRvciBjYXBhYmls
aXRpZXMNCj4NCj5PbiAxMC8yNC8yNSAxMDo0MywgWmhlbnpob25nIER1YW4gd3JvdGU6DQo+PiBJ
biBWRklPIGNvcmUsIHdlIGNhbGwgaW9tbXVmZF9iYWNrZW5kX2dldF9kZXZpY2VfaW5mbygpIHRv
IHJldHVybiB2ZW5kb3INCj4+IHNwZWNpZmljIGhhcmR3YXJlIGluZm9ybWF0aW9uIGRhdGEsIGJ1
dCBpdCdzIG5vdCBnb29kIHRvIGV4dHJhY3QgdGhpcyByYXcNCj4+IGRhdGEgaW4gVkZJTyBjb3Jl
Lg0KPj4NCj4+IEludHJvZHVjZSBob3N0X2lvbW11X2V4dHJhY3RfcXVpcmtzKCkgdG8gaGVscCBl
eHRyYWN0aW5nIHRoZSByYXcgZGF0YSBhbmQNCj4+IHJldHVybiBhIGJpdG1hcCBpbiBpb21tdWZk
LmMgYmVjYXVzZSBpdCdzIHRoZSBwbGFjZSBkZWZpbmluZw0KPj4gaW9tbXVmZF9iYWNrZW5kX2dl
dF9kZXZpY2VfaW5mbygpLg0KPj4NCj4+IFRoZSBvdGhlciBjaG9pY2UgaXMgdG8gcHV0IHZlbmRv
ciBkYXRhIGV4dHJhY3RpbmcgY29kZSBpbiB2ZW5kb3IgdklPTU1VDQo+PiBlbXVsYXRpb24gZmls
ZSwgYnV0IHRoYXQgd2lsbCBtYWtlIHRob3NlIGZpbGVzIG1peGVkIHdpdGggdklPTU1VDQo+PiBl
bXVsYXRpb24gYW5kIGhvc3QgSU9NTVUgZXh0cmFjdGluZyBjb2RlLCBhbHNvIG5lZWQgYSBuZXcg
Y2FsbGJhY2sgaW4NCj4+IFBDSUlPTU1VT3BzLiBTbyB3ZSBjaG9vc2UgYSBzaW1wbGVyIHdheSBh
cyBhYm92ZS4NCj4+DQo+PiBTdWdnZXN0ZWQtYnk6IE5pY29saW4gQ2hlbiA8bmljb2xpbmNAbnZp
ZGlhLmNvbT4NCj4+IFNpZ25lZC1vZmYtYnk6IFpoZW56aG9uZyBEdWFuIDx6aGVuemhvbmcuZHVh
bkBpbnRlbC5jb20+DQo+PiBSZXZpZXdlZC1ieTogTmljb2xpbiBDaGVuIDxuaWNvbGluY0Budmlk
aWEuY29tPg0KPj4gLS0tDQo+PiAgIGluY2x1ZGUvaHcvaW9tbXUuaCAgICAgICAgICAgICAgICAg
fCAgNSArKysrKw0KPj4gICBpbmNsdWRlL3N5c3RlbS9ob3N0X2lvbW11X2RldmljZS5oIHwgMTUg
KysrKysrKysrKysrKysrDQo+PiAgIGJhY2tlbmRzL2lvbW11ZmQuYyAgICAgICAgICAgICAgICAg
fCAxMyArKysrKysrKysrKysrDQo+PiAgIDMgZmlsZXMgY2hhbmdlZCwgMzMgaW5zZXJ0aW9ucygr
KQ0KPj4NCj4+IGRpZmYgLS1naXQgYS9pbmNsdWRlL2h3L2lvbW11LmggYi9pbmNsdWRlL2h3L2lv
bW11LmgNCj4+IGluZGV4IDliOGJiOTRmYzIuLjZkNjE0MTA3MDMgMTAwNjQ0DQo+PiAtLS0gYS9p
bmNsdWRlL2h3L2lvbW11LmgNCj4+ICsrKyBiL2luY2x1ZGUvaHcvaW9tbXUuaA0KPj4gQEAgLTIy
LDQgKzIyLDkgQEAgZW51bSB2aW9tbXVfZmxhZ3Mgew0KPj4gICAgICAgVklPTU1VX0ZMQUdfV0FO
VF9ORVNUSU5HX1BBUkVOVCA9IEJJVF9VTEwoMCksDQo+PiAgIH07DQo+Pg0KPj4gKy8qIEhvc3Qg
SU9NTVUgcXVpcmtzLiBFeHRyYWN0ZWQgZnJvbSBob3N0IElPTU1VIGNhcGFiaWxpdGllcyAqLw0K
Pj4gK2VudW0gaG9zdF9pb21tdV9xdWlya3Mgew0KPj4gKyAgICBIT1NUX0lPTU1VX1FVSVJLX05F
U1RJTkdfUEFSRU5UX0JZUEFTU19STyA9IEJJVF9VTEwoMCksDQo+DQo+DQo+VGhpcyBob3N0IElP
TU1VIHF1aXJrIGRlZmluaXRpb24gaW4gYSB2SU9NTVUgaGVhZGVyIGZpbGUgaXMgbm90IHZlcnkN
Cj5jb25zaXN0ZW50Lg0KDQpJIHRha2UgaXQgYXMgZ2VuZXJhbCBJT01NTVUgaGVhZGVyLCBib3Ro
IHZJT01NVSBpbmZvIGFuZCBob3N0IElPTU1VIGluZm8gY2FuIGJlIHRoZXJlLg0KDQpUaGFua3MN
ClpoZW56aG9uZw0KDQo=

