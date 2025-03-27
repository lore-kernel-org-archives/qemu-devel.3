Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0EA4FC3600B
	for <qemu-devel@archiver.kernel.org>; Thu, 27 Mar 2025 09:52:51 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1txjul-0005TH-K3; Thu, 27 Mar 2025 05:52:44 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <zhenzhong.duan@intel.com>)
 id 1txjud-0005QF-K9
 for qemu-devel@nongnu.org; Thu, 27 Mar 2025 05:52:37 -0400
Received: from mgamail.intel.com ([192.198.163.14])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <zhenzhong.duan@intel.com>)
 id 1txjub-00022Q-5u
 for qemu-devel@nongnu.org; Thu, 27 Mar 2025 05:52:35 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1743069153; x=1774605153;
 h=from:to:cc:subject:date:message-id:references:
 in-reply-to:content-transfer-encoding:mime-version;
 bh=YJwfZwr4LGMv8jXIhrliI54/ItXUiUeOTYZyQjovk4k=;
 b=TOIuBQsHJfMwFKqeRJu2kavcT+6touGDK7Xc4srlm0+rYibapmQoXOUg
 qS0WzopvSjS7AacHt8wkz6fFF/qHjshxZ0Z3kXJF8MDXEea9tz0YEJsQA
 eU3GYNsKSkTW0bAaAjArb3HF2bOLrfHRcCnXwUS2Cc/I7arUJ8wxyB4xJ
 3ZuQpio2AXOSbSgQE7WtVdvkoxcJPCJt/NnNp8YJiNFIdgf3lDjNaNPJP
 Jf6NJrMfmwRTi6xhQyxuhofAh8EDsvUjDNuuJfJvJyKOl5ntZKRQ49ELa
 UMUW8hXq3GKXuLF+3j7RKv1whga45rHvVtMswkBUOeP05/XFbDmvE0jtY w==;
X-CSE-ConnectionGUID: CZj2XUqMR1yo/aJ9ytZy6w==
X-CSE-MsgGUID: XfSLStFQQ1WJGtYEScuUqg==
X-IronPort-AV: E=McAfee;i="6700,10204,11385"; a="44574440"
X-IronPort-AV: E=Sophos;i="6.14,280,1736841600"; d="scan'208";a="44574440"
Received: from orviesa008.jf.intel.com ([10.64.159.148])
 by fmvoesa108.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 27 Mar 2025 02:52:27 -0700
X-CSE-ConnectionGUID: THFDzDuKQIGxdyooH2u0gw==
X-CSE-MsgGUID: qibq1ygXRgS0MaE6c5h6VQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.14,280,1736841600"; d="scan'208";a="126016982"
Received: from orsmsx601.amr.corp.intel.com ([10.22.229.14])
 by orviesa008.jf.intel.com with ESMTP/TLS/AES256-GCM-SHA384;
 27 Mar 2025 02:52:26 -0700
Received: from ORSMSX902.amr.corp.intel.com (10.22.229.24) by
 ORSMSX601.amr.corp.intel.com (10.22.229.14) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.44; Thu, 27 Mar 2025 02:52:26 -0700
Received: from orsedg603.ED.cps.intel.com (10.7.248.4) by
 ORSMSX902.amr.corp.intel.com (10.22.229.24) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.14 via Frontend Transport; Thu, 27 Mar 2025 02:52:26 -0700
Received: from NAM11-CO1-obe.outbound.protection.outlook.com (104.47.56.169)
 by edgegateway.intel.com (134.134.137.100) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.44; Thu, 27 Mar 2025 02:52:25 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=NGelZVuDD7sq7ebh4fdniymPKGo/DlCiuBifmsQnmSdFPv6Qgq+5pUNQKg2/oSRuZV84aGGDawDEMbbpXC1dLsLXnZNGCSyzFlLi51CxgXJaLdz+WkGSv4TyU3AwZrA1r5F7PVtOaG+1QFCKjqxbzeXwyeFCoaL91kXPu4pBO6Ic1WZXoBDN6+NMYGK8PJY/75LuGYFN1J/L2LfwKTIBgLPBX383UlknOMMSlpJVUkgZlnHL5Ec6QL517rMSPKMPHyA05QWGw4EfFhC1xPTI55WYBaVOPTKk4UKfqXsoa+vFp+a5CmL9OeQzQ/urCZQgHU3K9P/Nge+Zn6eGwyCwCQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=YJwfZwr4LGMv8jXIhrliI54/ItXUiUeOTYZyQjovk4k=;
 b=t1tgpyMc8hlGizWQk4FhLmmGCLj0x052e6bnOFuEVj2o0BTKTVq/QDVCsgzzcEyiU+wXZO3hlrpgSP6keVIsuPHUoNTx8IOm3IK8n8PAZfqJJ3l12BfIpqKvpQAhF56Im4q++tZ/86kubjtd01rshhxrbiehaOuNEXb7p7CTGJ71AwOGDbqJjWvI963jZ2uH79nOE4yRUX8s3eolibpCZgeMtyfbxmgz9yuzQe/IBBLSqHiFvVgFNJ15scXuYSnmroakDneZ0JZbArkanGII63ObdttJZMEtSsF6Q1IVV+B6xyyVlgT3wvM2ugqFcEzHLb8GOQOf8OApRee+DIu/kw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Received: from SJ0PR11MB6744.namprd11.prod.outlook.com (2603:10b6:a03:47d::10)
 by DM4PR11MB7182.namprd11.prod.outlook.com (2603:10b6:8:112::6) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8534.44; Thu, 27 Mar
 2025 09:52:23 +0000
Received: from SJ0PR11MB6744.namprd11.prod.outlook.com
 ([fe80::fe49:d628:48b1:6091]) by SJ0PR11MB6744.namprd11.prod.outlook.com
 ([fe80::fe49:d628:48b1:6091%6]) with mapi id 15.20.8534.043; Thu, 27 Mar 2025
 09:52:22 +0000
From: "Duan, Zhenzhong" <zhenzhong.duan@intel.com>
To: =?utf-8?B?Q8OpZHJpYyBMZSBHb2F0ZXI=?= <clg@redhat.com>,
 "qemu-devel@nongnu.org" <qemu-devel@nongnu.org>, Alex Williamson
 <alex.williamson@redhat.com>
CC: Avihai Horon <avihaih@nvidia.com>, Eric Auger <eric.auger@redhat.com>,
 John Levon <john.levon@nutanix.com>, Joao Martins <joao.m.martins@oracle.com>
Subject: RE: [PATCH for-10.1 v2 17/37] vfio: Move vfio_get_info_dma_avail()
 into helpers.c
Thread-Topic: [PATCH for-10.1 v2 17/37] vfio: Move vfio_get_info_dma_avail()
 into helpers.c
Thread-Index: AQHbniQanW5uNPlGdUiw/XC+8KMjZrOGv4Wg
Date: Thu, 27 Mar 2025 09:52:22 +0000
Message-ID: <SJ0PR11MB6744C09D99FC07184B1190FD92A12@SJ0PR11MB6744.namprd11.prod.outlook.com>
References: <20250326075122.1299361-1-clg@redhat.com>
 <20250326075122.1299361-18-clg@redhat.com>
In-Reply-To: <20250326075122.1299361-18-clg@redhat.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: SJ0PR11MB6744:EE_|DM4PR11MB7182:EE_
x-ms-office365-filtering-correlation-id: ce4ef74b-0d9f-46c5-38ac-08dd6d15127e
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
 ARA:13230040|1800799024|366016|376014|7053199007|38070700018; 
x-microsoft-antispam-message-info: =?utf-8?B?SzRiTVk5ZCt0eTRrQXM5WndQbS9IRlVrOW1qTHdadHl5Y2trbVI3NjZDR0dO?=
 =?utf-8?B?TDRVZ2hLbWU3V3JmQTlxYkUyWVRQRGJBU0RwUkZsb0xrNTJmNy9LOSsvbGEv?=
 =?utf-8?B?QXdlOXIxeDlobHFtZkhSSkZ4SWJNTVZobk02UGtDaW1semRFblB5emFydlcv?=
 =?utf-8?B?YmRKMzh5eUYxY01jSDEzbjZlUXB2OHlTYWtTd0xuUVhhSkEya1VJRmRKRWFN?=
 =?utf-8?B?NVhNMVJQSTVEbUVHVThrK2NNS3RYMUdPTUJhMzFiV0tMSld5ZWhUWkZpcHVa?=
 =?utf-8?B?OStXbFNoc3pMdlcwNnRwWTFRM3ZTVXBhVEVTVmlnRU1IdXFid3lrNWVqcWhv?=
 =?utf-8?B?ZzYvUEFsME84MHBnRHdpaWRXUHdJMDRQVTZZMTFzZFpVdVRMTHpzNG1wQWNr?=
 =?utf-8?B?QmRwY25BeTdRc3lXOGVUT21kZ0lsT1F0Nmt1MFRLUzRkZXNhaHYrcnJZZEdK?=
 =?utf-8?B?Mys3dFU2MlZQUXhOMGNYWldTdHlkUlFxMXBPL1JZb3RJRXcvVnF1UXlxMWgy?=
 =?utf-8?B?dXJLOWMva3RGbTkwaVN1dVRCMUJtN1pJeitmQ2hpdHQvaDNRbG9aUmQ2ZWNL?=
 =?utf-8?B?bXFUVTc2OXFBc3lCU1ZNcWg1c0RBSTdXbzlBbzhFaUgxMVRBZndwdllnQ05G?=
 =?utf-8?B?ajh2VE9yeXpNc1oyVHRzcEdkT0ZXZE1hK2VuMzRYcnVtbnlhUTc2MG5qMlJJ?=
 =?utf-8?B?d0d0UUkwck5YQTY2aU1kdVVMSEhOL0ZMV1FKeGNxQVdlYW4rbGNXLy9hRmdP?=
 =?utf-8?B?NUhrTjRZeEFZeWRFZndpWG42UXJkbmlPZi9rTkFZQU1aUFhETXpEb29ZQytN?=
 =?utf-8?B?TFZQUkxiVjM1b3NES1BTYzFPTnF3enJMeEoyTDVVMjgwMG5UbkloZXpuaXMz?=
 =?utf-8?B?aWR0cTF0dTNDR2lkMzRiRk9ZaFZzVmtDclRhRms0WnN4ODRVYTFJVkdyRDFy?=
 =?utf-8?B?SXh1MFl4WFNEV1pYdWNtVUtoaHdySnlucVk3NHRRVk9FZkFFWGpDOEFPYzVY?=
 =?utf-8?B?OGdtNXRXZmRSN05RaXh2eEFiV1FSczR4RFRiTkdxSDZjdW1SVmZsK2lSWHIx?=
 =?utf-8?B?UUtqS3VmYXV0SVZwVHFnVTA1R0ppeGZ5cG4wMlZOam1pYVhPNFlZTVZsNGlU?=
 =?utf-8?B?Tmp3cy9kVUsvOUdYUjhRKzI0QTJoQkIzNE9PQjkxL3MzcHZCVSt4NGRhc0FS?=
 =?utf-8?B?K1o0aGNqcSsvWTVPNzY3eW9FbGlubGFwVHdXQm92UitnSU0zZ29abVkvNjVZ?=
 =?utf-8?B?aVVsWnZyV2JVdmJHazhXQVphRnpRT1lOa0VlQVBUUWVMVVBpMVNkWk5SWkxs?=
 =?utf-8?B?cUhERUIwWDRJN25COHFoemtqeHdvREE0V0ZaSEtvWjhub0NwVjJzZ1dMeTJX?=
 =?utf-8?B?T3l0RXhaNHlkYTNRVVRCQkRNeHNqL0VEWXBaaUFKWDBicVFsKzN5MTlQOGw0?=
 =?utf-8?B?UVpUbU90NEVBc29CaGE1VHFEQ0trNUQ1ZzlYWlR2bUcwckhDZHp4OHg1aUVO?=
 =?utf-8?B?SFJmMlRoTE9Dc2I1bjM1QlJUWnM3MmZyN0JBaSs5M0VqY0xBank4Y3AwUkdX?=
 =?utf-8?B?V0RKQUIwZUdKZHRsK0c0MFU4NTYwZkJZZ3dEQ2JiTG5menZVbFJ2RWE3S2I2?=
 =?utf-8?B?ZXRWTVhtZUNIVlVmaGhQT1gzbTF4SjUyeW1ldENHT3l5Q2pQRXFlakpwdzl3?=
 =?utf-8?B?cm4vK2Rqd3RocVJBQlcwa0E0dmFoQ2ZYeU4wcHF1am1NUjJsMGxraS9nU1lt?=
 =?utf-8?B?aDRtOWsrbzJRZW9iWi9oc2dBUnp1SXk3b04xZmVUSXJaTDJGbzkvc3RzdzFx?=
 =?utf-8?B?TUlIOThBTHdUaGRDYkh3eWNpRzFhYmtMalhUcWFUR3V1anQwN1BibjZNcDY2?=
 =?utf-8?B?ZGhQTzBtUGc2ODEraVpMK2g3ZHFZd0lUNFBzSHlldm90RkhLZE9XMFRHWita?=
 =?utf-8?Q?4LpVP1djjzxA72xotSkQSWq1fp5QmQn7?=
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:SJ0PR11MB6744.namprd11.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(1800799024)(366016)(376014)(7053199007)(38070700018); DIR:OUT;
 SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?alpmTGRTYlFVME5QNit0cG9mSVYrR1E4K3JwaUVyK3ZIUmNIVXg4TU5oVHpS?=
 =?utf-8?B?WUlnWFhIVnR2S3FmTm10cmNBc2ZBbFkxanJ0VEpub1JKWFBtSDBnTlVwd2ZO?=
 =?utf-8?B?dDBxZWZITU5uWnZhTVBMaGZnV3lOMjdvbUIvNzZQR0JaMEdUd0VSUGpYdFQ5?=
 =?utf-8?B?NGVFSHlwb0hscmhPTjhBM1o1R1ZpRG1abXpYZXdxODJKMjFpS2R0M3lIRFJP?=
 =?utf-8?B?WnoyaFcrU25WUmJKNnR1WHVoaDdnN2lscEQrdldqUVhjRitVTnhZeHJVRmw0?=
 =?utf-8?B?YmNwSkpmbVZkRFAvODNFK0xwWjFzSmZuSktJVkxDMkc3QnljcFpSbU91a09L?=
 =?utf-8?B?RUhWbGJrazI2dDZpYVhpTlNzeXF1S2cyRm9vNTVqL3BFOTZMeG5PazB2WTYz?=
 =?utf-8?B?UkdaUEF3QjFjdXFYYmk1QjlWV2luMmtXT0ZUSGExR0tGUTFjUlN2Tm9YQ09k?=
 =?utf-8?B?QjN2V20vYlQzWFVMRTdMYURuajUyOEtEdytRQmRHTGlvQVpDc3NsaWViMVlJ?=
 =?utf-8?B?d29WQUxTaVJxOFkxajdkZDNwL2s2bDA3K3hKV2lpbnhOblhYQVNpSFM3MVJE?=
 =?utf-8?B?QUJFSUlxdTBRWlpNbzhOa3ZrN3BmMDNIdVpVUFcwQ3lkSnhNTHovRFZGQWho?=
 =?utf-8?B?ZVlWU2J3dmlHWjB0NVRmYk15QUVKZnUvcHN3WkVOalp1K0p6ajFaN3M1Z0Vz?=
 =?utf-8?B?ZzRONVJMNmJnWFpVMW1SWmJ6WkY1KzVyZFdKbGRFK2RLdmFURXcvb2R3YTli?=
 =?utf-8?B?emtUaWtBVEdTbXkybzF4MVp1cjdyT2wySkFMeVhZcytsRDVicTZ2SUErR1Qr?=
 =?utf-8?B?aDdEdnpGNzJJbVczUW9SSVYrNEFJU3I5VUk4TFpJT2xvRm13bGpFRkVCQ1I1?=
 =?utf-8?B?VVl6V095VGkvTmUvQm4xWGYxQnNxSlhyYzg5WkJ4NzJWNi9kWFhza0pKZkVR?=
 =?utf-8?B?SHBwaS9tR0NmNjZjYzhIcE84WVliNVdQYUJNOXZEVFQ5SElTbkFRTFhYMWN6?=
 =?utf-8?B?T2dEaXhhUUE3YldnMkxSRldiMUFwamtXaDU2VkF1MXUyeW1YaHc3VXBvVWV5?=
 =?utf-8?B?cWZXZVh5Q2p0cmtuZm8wRUdacXFkVHpqc0I0K0dUR0M0ekJXRnFxSm9qYmtX?=
 =?utf-8?B?Z1JXL0FHcG8vUEpDLzRMRWZVejdscXJYUW5ZZUZXU2dmcmJ3aUZEalQ1Y1gy?=
 =?utf-8?B?UnN6Y3JscUx1L1htcDZzOTJiRXNVU0RVTytSODNWMlU0bjVsMzV1OXQ3L0di?=
 =?utf-8?B?UkNRMzlnWjd0N2VFR2pkZ21lUGF2YlA1QVI4dHpwYXRNU09MTkQ0My84UHVD?=
 =?utf-8?B?UU1nV24rMGFpZjJSMHRkUmhQckMrOU9pb0R1eEtzcTZSR2NaRGFEMjNhdHNJ?=
 =?utf-8?B?OVlkWHlwOVNDYjBPbUxZMmlMbk1JR3UwU29RNmRPNzlKR09COHRPSk8vMmlS?=
 =?utf-8?B?ak5UdVNUMFR2WWhoaGppVWlMRGk0Qk1KTSs3ZlN2dlpCT2JQKzFSMmlyMmhD?=
 =?utf-8?B?WFAvV0I1UUM3cXdJWHdtSGkxbVIzN25IVEFFQmQ1Q0F1a00xOXV1WnZ6TTg1?=
 =?utf-8?B?QThjeTZ5OXVkMzBNNzVLZloxazg5TER6WUJQWXovTzZ1YVJ1TzNGY1Z2RDJh?=
 =?utf-8?B?SnNBSDhtZ05HL1FLWlozeC82TitpZFdHRFNyQUNVOXM3cFlxZkU1Vy9xVXVD?=
 =?utf-8?B?TFVrTWtQSXVEdHRnQXF3YXJDMGtRZ3l2c2l0SE9xMGMxdUhwTGJXQmJpMGJU?=
 =?utf-8?B?REJkK25qNDh6M3FOS2RWVHRDNForSEd2aWZ6bk1XMG0xUi8zQ2lGQ2ZRRnR5?=
 =?utf-8?B?dnVkaU9PNnBaK1JmUm14MXlVeVVzZ1pBalB5YWpMRmlndkJJUVRjYUZjYTV0?=
 =?utf-8?B?dGpVUUdWdnJQZ3hUY2lXMFYrUUVSTG1Rc0l5SkFxUkl0enR5eGF2QzEvNjlC?=
 =?utf-8?B?emlyUDMwUHg0bXl1bWRvSHlvdzhXK3M1RW54MXIvWVB3aWg1ck43c1RMdHRZ?=
 =?utf-8?B?c0VwVzF1WCtuekpvajF3VGtBaXVVaUg3Tjl2a285ZEhwbTZtM0MyT3RocDNS?=
 =?utf-8?B?L29UMEVTTkltNFVvVjFTbUR6dzZrNk5zcXBFNFRteFVKcng3QzdEU0orMGdT?=
 =?utf-8?Q?2tgjujDEE+4t9OSH5Z7IeXAqN?=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: SJ0PR11MB6744.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: ce4ef74b-0d9f-46c5-38ac-08dd6d15127e
X-MS-Exchange-CrossTenant-originalarrivaltime: 27 Mar 2025 09:52:22.8060 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: rzH8ZbBl2x3Md3mqMAfV/pXOvKlTmYk2Wu0Vih5igAbHeN6bxXot/aYkPw7Sl33ZG4j/FAD/WB2NkZtoHbUbSvQSRC5XXHtGefgkj8OhxwI=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM4PR11MB7182
X-OriginatorOrg: intel.com
Received-SPF: pass client-ip=192.198.163.14;
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

DQoNCj4tLS0tLU9yaWdpbmFsIE1lc3NhZ2UtLS0tLQ0KPkZyb206IEPDqWRyaWMgTGUgR29hdGVy
IDxjbGdAcmVkaGF0LmNvbT4NCj5TdWJqZWN0OiBbUEFUQ0ggZm9yLTEwLjEgdjIgMTcvMzddIHZm
aW86IE1vdmUgdmZpb19nZXRfaW5mb19kbWFfYXZhaWwoKSBpbnRvDQo+aGVscGVycy5jDQo+DQo+
dmZpb19nZXRfaW5mb19kbWFfYXZhaWwoKSBpcyBhIGxvdyBsZXZlbCByb3V0aW5lIHNpbWlsYXIg
dG8gdGhlIG90aGVyDQo+cm91dGluZXMgZXh0cmFjdGluZyBjYXBhYmlsaXRpZXMgZnJvbSAnc3Ry
dWN0IHZmaW9faW9tbXVfdHlwZTFfaW5mbycuDQo+SXQgYmVsb25ncyB0byBmaWxlICJoZWxwZXJz
LmMiLg0KPg0KPlJldmlld2VkLWJ5OiBKb2huIExldm9uIDxqb2huLmxldm9uQG51dGFuaXguY29t
Pg0KPkxpbms6IGh0dHBzOi8vbG9yZS5rZXJuZWwub3JnL3FlbXUtZGV2ZWwvMjAyNTAzMTgwOTU0
MTUuNjcwMzE5LTE3LQ0KPmNsZ0ByZWRoYXQuY29tDQo+U2lnbmVkLW9mZi1ieTogQ8OpZHJpYyBM
ZSBHb2F0ZXIgPGNsZ0ByZWRoYXQuY29tPg0KDQpSZXZpZXdlZC1ieTogWmhlbnpob25nIER1YW4g
PHpoZW56aG9uZy5kdWFuQGludGVsLmNvbT4NCg0KVGhhbmtzDQpaaGVuemhvbmcNCg0K

