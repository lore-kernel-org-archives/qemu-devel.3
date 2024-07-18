Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 395D8C3DA60
	for <qemu-devel@archiver.kernel.org>; Thu, 18 Jul 2024 07:51:33 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sULuy-0004MT-B6; Thu, 18 Jul 2024 03:51:12 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <zhenzhong.duan@intel.com>)
 id 1sULuw-0004LY-Mo
 for qemu-devel@nongnu.org; Thu, 18 Jul 2024 03:51:10 -0400
Received: from mgamail.intel.com ([198.175.65.21])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <zhenzhong.duan@intel.com>)
 id 1sULur-0007na-1N
 for qemu-devel@nongnu.org; Thu, 18 Jul 2024 03:51:10 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1721289065; x=1752825065;
 h=from:to:cc:subject:date:message-id:references:
 in-reply-to:content-transfer-encoding:mime-version;
 bh=OAicxTIQ3Y/JcPltehRsoIdBynoQ4yV8oLWDnLZWitg=;
 b=DI8DQGfkVQfBxagxhQy5Q8/jRUP6YZW4+2KyNNRMIq6Hdsgw2uDIr0v0
 JZbgCuMOXKmuxqz+7ridYl8IEa8wRBycqpVveZm0zDNXrqBxYvQgT8anh
 BHBAy56Fiyc2T63+lhPN7Pk24Ao6FyUcmKjGg3e/jls/qhgUTnWm+/vsz
 /8hzh31SiP2acyUvwqZHiYgToaao6uUhPDAAz59XcgEFPHICiMOOr2ubt
 Y5pnm9K5FI8ZLXlmzG3ALRHYoMLZUbRQlPmhQHvWBaBg5qFSq2hF5W4EH
 qtv608ST3nIWn5EnBwWRnwafbIlFnxRJ2pe1+uMuQe2wNOhvwG3oeFXfU Q==;
X-CSE-ConnectionGUID: ieHQbaQcSN6N+cy5kKupig==
X-CSE-MsgGUID: fPYm5YsZRhSLoM/VQdCWkA==
X-IronPort-AV: E=McAfee;i="6700,10204,11136"; a="18792444"
X-IronPort-AV: E=Sophos;i="6.09,217,1716274800"; d="scan'208";a="18792444"
Received: from fmviesa006.fm.intel.com ([10.60.135.146])
 by orvoesa113.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 18 Jul 2024 00:51:00 -0700
X-CSE-ConnectionGUID: mPaVzavvTpq551/qi/tb5Q==
X-CSE-MsgGUID: 3I1n17PqS3+xwmuh3Tf10w==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.09,217,1716274800"; d="scan'208";a="50399169"
Received: from orsmsx602.amr.corp.intel.com ([10.22.229.15])
 by fmviesa006.fm.intel.com with ESMTP/TLS/AES256-GCM-SHA384;
 18 Jul 2024 00:50:59 -0700
Received: from orsmsx612.amr.corp.intel.com (10.22.229.25) by
 ORSMSX602.amr.corp.intel.com (10.22.229.15) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.39; Thu, 18 Jul 2024 00:50:59 -0700
Received: from orsmsx611.amr.corp.intel.com (10.22.229.24) by
 ORSMSX612.amr.corp.intel.com (10.22.229.25) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.39; Thu, 18 Jul 2024 00:50:58 -0700
Received: from orsedg603.ED.cps.intel.com (10.7.248.4) by
 orsmsx611.amr.corp.intel.com (10.22.229.24) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.39 via Frontend Transport; Thu, 18 Jul 2024 00:50:58 -0700
Received: from NAM12-DM6-obe.outbound.protection.outlook.com (104.47.59.169)
 by edgegateway.intel.com (134.134.137.100) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.39; Thu, 18 Jul 2024 00:50:58 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=lF8lvQE0hljPIyAh5FT1SP0iL3ZZi5SqEz1yws8gmw8SDVXc6fb1Vqy/yZ9RQhbWPvHu+symCNCJUkGVzXlqspa35hjrt/4tdMOZ9id4D6V1/fpcUCJ0SmVnW3Jvab5f0+6K7b4jYn85TBpIfd8yrF4HR86kbWMKT8j4WafPRvBDallUetDLCDBRO3DdsTSiSYYLmEi+PDyvHsTeEy518zpxc7s88/SHJrXHeKiFBHH/UxauR0wHaXUs38MTmYRFn62elbYAUzr49bri19hNGwU1gJlfpRZRldW+a0oXDe9OWfE7gDCmebe6PhqkYxZlrB5lklNMPIeUYoVhLtNvlQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=OAicxTIQ3Y/JcPltehRsoIdBynoQ4yV8oLWDnLZWitg=;
 b=AzVi7EkV/ogvHeE4Fwfx/lIinNcX4BB3oytgYRNbyTgM34XpFId+phRjOjzpZ9lBoavZqZdvQDWXweGcdu1oJ5Vgc/JBa28Wrn4RISzIZ/0GH7XhxE+ZAYHl+MuHm6NvFRuHtJSK8XgzP/tNmg8buFtZtRULbHDfYUENIjyuKkADwA+ivOtb9cV4189qXXh6f42oEXXQ8nozUJ9VyuKz+AL7VsizNdgVCnbGrSovMXPxHdpBM3pSuo8Zdw6lCKtKmIZmkDdY0DYur0vofJOpoQvvlsQ+fqQ/X7wsmew0prcuj46No3B4tkfYpcjQt67VQTMu2tfUZRp6ycOaUbqygA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Received: from SJ0PR11MB6744.namprd11.prod.outlook.com (2603:10b6:a03:47d::10)
 by SJ1PR11MB6155.namprd11.prod.outlook.com (2603:10b6:a03:45e::10)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7762.29; Thu, 18 Jul
 2024 07:50:54 +0000
Received: from SJ0PR11MB6744.namprd11.prod.outlook.com
 ([fe80::fe49:d628:48b1:6091]) by SJ0PR11MB6744.namprd11.prod.outlook.com
 ([fe80::fe49:d628:48b1:6091%7]) with mapi id 15.20.7784.016; Thu, 18 Jul 2024
 07:50:54 +0000
From: "Duan, Zhenzhong" <zhenzhong.duan@intel.com>
To: Joao Martins <joao.m.martins@oracle.com>, "qemu-devel@nongnu.org"
 <qemu-devel@nongnu.org>, Cedric Le Goater <clg@redhat.com>
CC: "Liu, Yi L" <yi.l.liu@intel.com>, Eric Auger <eric.auger@redhat.com>,
 "Alex Williamson" <alex.williamson@redhat.com>, Jason Gunthorpe
 <jgg@nvidia.com>, Avihai Horon <avihaih@nvidia.com>
Subject: RE: [PATCH v4 00/12] hw/iommufd: IOMMUFD Dirty Tracking
Thread-Topic: [PATCH v4 00/12] hw/iommufd: IOMMUFD Dirty Tracking
Thread-Index: AQHa1FFDRkoLjK7NzkiqN4/11c+RQLH5B1sQgAATWgCAAwp2cA==
Date: Thu, 18 Jul 2024 07:50:54 +0000
Message-ID: <SJ0PR11MB6744EED1FFDFE02D1C496DF392AC2@SJ0PR11MB6744.namprd11.prod.outlook.com>
References: <20240712114704.8708-1-joao.m.martins@oracle.com>
 <SJ0PR11MB6744C37D32B04773DCD00FCF92A22@SJ0PR11MB6744.namprd11.prod.outlook.com>
 <c7537753-43c2-4bba-a5e8-79975f91bde1@oracle.com>
In-Reply-To: <c7537753-43c2-4bba-a5e8-79975f91bde1@oracle.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: SJ0PR11MB6744:EE_|SJ1PR11MB6155:EE_
x-ms-office365-filtering-correlation-id: 0958b109-0bdd-4f12-1be8-08dca6fe5a09
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0; ARA:13230040|366016|1800799024|376014|38070700018;
x-microsoft-antispam-message-info: =?utf-8?B?QVJGaSs5SE5ON3FJZ2xqaU82WXQvbkdQalBlVmxiR0l3ajZSUTVtY01yeHpr?=
 =?utf-8?B?MjJ6OVBBaHowSUhUM2JkZ2pyQ2pGUUl5TDBzcDFmQ2lsQkN3aVIybkMzQ1E2?=
 =?utf-8?B?NzhZWVdtbTc2SUZtOGF3cjE5RS85SFJ3ZU02Nmw1TmdiSWNNRml6Q1RrYngr?=
 =?utf-8?B?VGNnaE1YMUdMLzJ5NFUwZzAwTWI3bnBRY1pMUFh5VTkvcFI3a1QwNkdvZy9r?=
 =?utf-8?B?MlU2Q29FaDNLUFRBc2tXSC9EUzR5aTluYjdWSTZNaXF6RVFlSmN0RVR0cGg3?=
 =?utf-8?B?S3FSR3ZER0JFMXVUZHN0VXFxRnVsRzk3dms5SnY4Lzl5UGlVbkJzc0hVNTVv?=
 =?utf-8?B?NXBibW9DL3pWdnBmLzRkN1lEVjJCWHF5V2Flb2tuV0lWZVRZSjA5a0djSjIr?=
 =?utf-8?B?V1NxQWZJQzJtVDhuNHFTczVTRkRaUDRCTkdEcjRFejlwVDJWUUxJR1Bqcmdm?=
 =?utf-8?B?a1BUR3pGUFZQdGdHNit1YkRTcVJ6RFJvRzJDdWVYQ243KzNjc1FxY1lDMWpn?=
 =?utf-8?B?dW5LekErVkxvd0g0YlRpdDA1R3Jna1ROM0dTRXFBc25DeGJORTZMUXkyK2c4?=
 =?utf-8?B?UU10eldoSWJqU2p0WThHTEdrVlAyelc4RUpoTjV5eERZWUhONDU4NkVHeit5?=
 =?utf-8?B?SkxrK3VmT3VmV3p5MVFYM01hZFpSU2V5M0JnM2ZpYkkyZi9FTExjalh5RVB4?=
 =?utf-8?B?TDN0K0d1Wi9yWkV6cVhmaCs4ZU1jam5JM05nUytsekdTQmdudXl5aDFqRDdV?=
 =?utf-8?B?dkp3M2tYNlg4YVhsNlhKWVVvY2FaTTZSMG5ZemlBcU5qU2V6c3R6RForbTlI?=
 =?utf-8?B?ZEJhc3hubnpSdVNEOUNLOVFtUFozS3NaK1RFc0x5SW1pMEpEeG9vY2ZhQWpw?=
 =?utf-8?B?QnI4QzdzbUZGNDczZGlBbzlFUGw3VEFhdy9iVURZc2Z4cFh0UE9aOUlQUm5y?=
 =?utf-8?B?TU9IK1JQVzZzM2FPdEtpUUw0KzhtZnRUa2hYcXhxQ1V5OFV4SG5rZE53MHJ3?=
 =?utf-8?B?SEVtWHdVM0xEclZYM2hhazE4MHBjNnU1bllWUmd5aW0vaDJ1azliTzhWTUVF?=
 =?utf-8?B?QmUzVER1VTNHUUI2OGdSSXB1MC8zdmZ1N2hHUU5WdzJ3OThlYlliRjUydXdn?=
 =?utf-8?B?d0M1MktJSm1hTHgwUlN0UGgrN05LUVRibzFld0p3OTZGMXZVOWZDTWY3dkMv?=
 =?utf-8?B?aVZXZ0VNZDdJaUYrRTFGTmFUeVk4SnJROFR6VS9ub2NZKzd6VmRpOEliYkhG?=
 =?utf-8?B?SzlNc01oekQxOXhDWG9wbTROZzFkU1FFZmJvQ09Pa1Rick1sT1ZURHV1OUZr?=
 =?utf-8?B?RWtOQkRLbUJsN2FvSEx0bEwxd3RhazVZVExtNjdMT0RpZytpalk0b1dDZTdE?=
 =?utf-8?B?UUdhSmd5alV0bVpQaTU0RTAwcFVDbTdIVmh3cERZSHF3SlRPdTJMbUpLQ0Vq?=
 =?utf-8?B?QzZPNW82ZUZBK2V5blZtd1I5WjBBWjl1ZXFQbXBsZk5PZnpOQTl2SncrdnM0?=
 =?utf-8?B?bVNiT2NBN2Q2eHMvbEdpUXcyUWpkVS9jMlBTK3RNUjIydGc2OGUveHRUVzB0?=
 =?utf-8?B?R2lQN1VWejlwVGZHZk1uY1kwQWZZZjBQQVRHdTY1b3IyRUIyeWJPczJ0N283?=
 =?utf-8?B?dVFONE5maWYwTXBmRFZJWXQ2TnN0dXlaY3FiTVpkd3lBYkZ2KzNnSHM4eTZD?=
 =?utf-8?B?SktYNlpqSEVWVTNTeWppTTQ3SFFRb0xQSUM0MGM1c3FLcCtNRGt4MUk2bDJQ?=
 =?utf-8?B?TGc4b2hSTllyYmVoNTl4UExTOGhaU1N1aXR2czBzcFN2ejlaTmJEakhLK2Zj?=
 =?utf-8?B?YU5vdkR6S2YvbnMrWXRrZ3lHbHlIWnNXV2w0NTN3VFZGSkxKMnNyRlRFV1Nz?=
 =?utf-8?B?dThKbEhNOWdza2V4WGdSYWZZWC81R3g5QzAyV0Y0M0NRQ3c9PQ==?=
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:SJ0PR11MB6744.namprd11.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(366016)(1800799024)(376014)(38070700018); DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?TEt0Y2F6OVdpM1NaS243YVBjRTJPbCt2czBhc1ZBQlVvbVlJMHlwcnkxMVdY?=
 =?utf-8?B?bnU4eWVjUkl0Mng4TTh5cUFPR0VDamJsaU9yMVRwWEs2aVFObGx6cTVUOCtz?=
 =?utf-8?B?RTViblJiWWswYk9HZVdsQ0pWaWx0ZnJYblpJa3Nvc0lXMXUzRHUrMXJkUDha?=
 =?utf-8?B?OVlYK3Rya1BmQUZrbFZDM1NaTm1keHAzYWlGK1VYYXZPKzhxZEtqdnBscVNU?=
 =?utf-8?B?Zm1WMVBSd2Z1VFB2Y2N0YjBtakFxVTlBVFdxdVBIbjVSWExBMUV6cEFmaEp1?=
 =?utf-8?B?eVdDeUQzWWVza3RITmhvcDMyL2xWS2dEeE45c25TTUEvL2J5RTBZRzZja1RV?=
 =?utf-8?B?ZlZ5V2FSMTJ0M2crQjYwenAvOEVlN0RXVWtYckNkcWh3NlJXUWJRaXhzaHVJ?=
 =?utf-8?B?NUFXSGNjT3UwWnpVMG1ZYysxVWdmbmFaZ3I4VGs5SjhiblVLdG5STW1LeUpv?=
 =?utf-8?B?R1BUUll6eFdGSVRVSnNRbDQ4YXRORk0yeU9Nb2NRZ0RzeldLeWJPLzRtTkRW?=
 =?utf-8?B?TFdEMFlvLytaby9hQzk2SFpXRFZpaGVVZDJqVVEzU2RHbEhqUS8zbW8zSi91?=
 =?utf-8?B?cjZwVTVRait6azNVcWpsYjhBc05ZVXlwM1BDK3pQcVczdzFmUHJmN054bTRD?=
 =?utf-8?B?cHRDUkJXSCtrZ08wY1k2aEJPQXJvWmRtaEF5T2kzaHRKZWNvcEptVmlkbDhH?=
 =?utf-8?B?Zm1vREwrMythOVRBbjIwU1MxUktxQmVrcTBiYUhVOUdIZGlrb0VMUjBPWkZh?=
 =?utf-8?B?b3Nleld5b0Vqck9IQjNIVmVSRHVnWkQ1YmI5Qk1qZUVYK3J6YW10czlaMTQr?=
 =?utf-8?B?NDZNV1RtaVk3S3lVNjRZWC92N1JCLzFrdGw5dVpYZGh3SVkzVk5QR1c1cExi?=
 =?utf-8?B?OUM4eWt5VXBIN295WkduUjhML2hnc0w3cHlldXcxRG5FTUlZMGg5SFFWaG1B?=
 =?utf-8?B?eUVVK0YwdEFURWt2K1NTeVdtQzAxczVJVGp1enU0bzVISFMrak5va2x5Y05X?=
 =?utf-8?B?RjhBZXAwMVEwQyt6bEEzUG4vZ0RQUkl0cm9jb3Btb2RLTzl5Q2R0bnRKWlJX?=
 =?utf-8?B?T2xUNzFCR1BIYVF5WEs3RE1TUkNveGV2a2Irblo1SzR2cFdtK1JuZ3Zvc3N5?=
 =?utf-8?B?MHY3d2RhOHJ4R1hJWEo2NUoyUVB1emZ5bmVLdDJFYWhuY0QwQ0NuQ3o1K3hO?=
 =?utf-8?B?SWZyVkUwNnFwak9TUmt0WUhNVFExckNVT0d2TTEvekkvek9NWitUN1prMm5o?=
 =?utf-8?B?WVpNTUkwcFFuVWtMSU8zUjhzbHh4WWgzbnhmd2ZoM2V6ZytKZFF4N2xITm9C?=
 =?utf-8?B?Q2Y0MCt0c1ppVllHY045ZG5DdUxVMG9wT1IxWFduTkJvSTlJVkZIZjdyME9l?=
 =?utf-8?B?TkFLQmRZUnlxaC9FWmIxL2NkaFFzQ01ETHcxUWVVa2dkNElNQXlWTTNiUlEz?=
 =?utf-8?B?NEJIUWR5cHRYVEp5NXpzU3EvYTJHYUsxVWFGUDRtU2dZbGN6d28rdHNBL3Zt?=
 =?utf-8?B?aDFoN0xaUzV4S1dubjlEaU1qcGJlWXhlR3FYaHV1eWRRbWYxdTJpVUxCOHE0?=
 =?utf-8?B?Y0IrRUZxSlB5cUp2QVNiNmtxUmd0VDEvN3VYRDRKc0oxT2UyWGh0dkZsYmEz?=
 =?utf-8?B?ZTdLQ0lIY25ObXJRek5OOFN1VGFtTFBRYUZGNlZEYUEwRjlsTG5LQ1JwQSt4?=
 =?utf-8?B?Q3AxK0c0L1Q2T0lTbTBwODV2NVBneFJleVB4Yi9MR002aHlPNjU2QkR5cUh4?=
 =?utf-8?B?WXRWNUFhdjVhTXdKckZSaU5Kd2d5eVoyclVZKzBzcE93Zmx1Wjl4aGd4WVBP?=
 =?utf-8?B?WkNBRnhDVExSWWdpcWt4ZmtjMGxwaExrZ1ZvSVlManlTbFNoYTZNR2RTb2hF?=
 =?utf-8?B?VTVab3pEN3d1VnJ2MnEwZWFxOGczSE5QWTBWUHpWa1JsalhHcmR1Snp2ME4z?=
 =?utf-8?B?THMzVlFzTG53RjdxOVhRM2tnZUR6Rk4xVUdZUTVjSEtOWmxTMHo0Y1pYMDN5?=
 =?utf-8?B?TGIzeDJlVWtrVGZ1am1kczltT2hlZHVLRXR2RnZLQkthYVprdVRvZ0czaTFj?=
 =?utf-8?B?WGMvSTJXeHltOS92MURDQ2hMajc3N3huNk9JcnpaL2dicytvUjVET1psbC9B?=
 =?utf-8?Q?EkAW24l+ab40e8LwNzUhhCL7Z?=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: SJ0PR11MB6744.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 0958b109-0bdd-4f12-1be8-08dca6fe5a09
X-MS-Exchange-CrossTenant-originalarrivaltime: 18 Jul 2024 07:50:54.1735 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: jX0RaadGZT61vV2J3RryIvBLKu034/YY2gKbcC1HaIxYxRyUwldkqJLFSR8MtECi9zHMCd4zv4oexRPFg/GjYxWTU/KfrOc+MZDwKrchKqA=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ1PR11MB6155
X-OriginatorOrg: intel.com
Received-SPF: pass client-ip=198.175.65.21;
 envelope-from=zhenzhong.duan@intel.com; helo=mgamail.intel.com
X-Spam_score_int: -43
X-Spam_score: -4.4
X-Spam_bar: ----
X-Spam_report: (-4.4 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_MED=-2.3, SPF_HELO_NONE=0.001,
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

DQoNCj4tLS0tLU9yaWdpbmFsIE1lc3NhZ2UtLS0tLQ0KPkZyb206IEpvYW8gTWFydGlucyA8am9h
by5tLm1hcnRpbnNAb3JhY2xlLmNvbT4NCj5TdWJqZWN0OiBSZTogW1BBVENIIHY0IDAwLzEyXSBo
dy9pb21tdWZkOiBJT01NVUZEIERpcnR5IFRyYWNraW5nDQo+DQo+T24gMTYvMDcvMjAyNCAwOToy
MCwgRHVhbiwgWmhlbnpob25nIHdyb3RlOg0KPj4NCj4+DQo+Pj4gLS0tLS1PcmlnaW5hbCBNZXNz
YWdlLS0tLS0NCj4+PiBGcm9tOiBKb2FvIE1hcnRpbnMgPGpvYW8ubS5tYXJ0aW5zQG9yYWNsZS5j
b20+DQo+Pj4gU3ViamVjdDogW1BBVENIIHY0IDAwLzEyXSBody9pb21tdWZkOiBJT01NVUZEIERp
cnR5IFRyYWNraW5nDQo+Pj4NCj4+PiBUaGlzIHNtYWxsIHNlcmllcyBhZGRzIHN1cHBvcnQgZm9y
IElPTU1VIGRpcnR5IHRyYWNraW5nIHN1cHBvcnQgdmlhIHRoZQ0KPj4+IElPTU1VRkQgYmFja2Vu
ZC4gVGhlIGhhcmR3YXJlIGNhcGFiaWxpdHkgaXMgYXZhaWxhYmxlIG9uIG1vc3QgcmVjZW50DQo+
eDg2DQo+Pj4gaGFyZHdhcmUuIFRoZSBzZXJpZXMgaXMgZGl2aWRlZCBvcmdhbml6ZWQgYXMgZm9s
bG93czoNCj4+Pg0KPj4+ICogUGF0Y2ggMS0yOiBGaXhlcyBhIHJlZ3Jlc3Npb24gaW50byBtZGV2
IHN1cHBvcnQgd2l0aCBJT01NVUZELiBUaGlzDQo+Pj4gICAgICAgICAgICAgb25lIGlzIGluZGVw
ZW5kZW50IG9mIHRoZSBzZXJpZXMgYnV0IGhhcHBlbmVkIHRvIGNyb3NzIGl0DQo+Pj4gICAgICAg
ICAgICAgd2hpbGUgdGVzdGluZyBtZGV2IHdpdGggdGhpcyBzZXJpZXMNCj4+DQo+PiBJIGd1ZXNz
IFZGSU8gYXAvY2N3IG1heSBuZWVkIGZpeGVzIHRvby4NCj4+IFdpbGwgeW91IGhlbHAgb24gdGhh
dCBvciBJIGNhbiB0YWtlIGl0IGlmIHlvdSB3YW50IHRvIGZvY3VzIG9uIGRpcnR5IHRyYWNraW5n
Lg0KPj4gVGhlIGZpeCBtYXkgYmUgdHJpdmlhbCwganVzdCBhc3NpZ24gVkZJT0RldmljZS0+bWRl
diA9IHRydWUuDQo+Pg0KPg0KPklmIHlvdSBoYXZlIHNvbWV0aGluZyBpbiBtaW5kIGFscmVhZHkg
YnkgYWxsIG1lYW5zIGdvIGFoZWFkLg0KDQpPSywgd2lsbCBiZSBhZnRlciB5b3VyICdkaXJ0eSB0
cmFja2luZycgdjUgYXMgdGhlcmUgaXMgZGVwZW5kZW5jeS4NCg0KPg0KPkJ1dCBmcm9tIHRoZSBj
b2RlIGFyZSB3ZSBzdXJlIHRoZXNlIGFyZSBtZGV2IGJ1cyBkZXZpY2VzPyBDZXJ0YWlubHkgYXJl
DQo+Z3JlcHBpbmcNCj53aXRoICdtZGV2JyBidXQgdW5jbGVhciBpZiB0aGF0J3MgYWJicmV2aWF0
aW9uIGZvciAnTXkgRGV2aWNlJyBvciBhY3R1YWxseSBidXMNCj5tZGV2L21lZGlhdGVkLWRldmlj
ZT8NCg0KSSB0aGluayBzbywgZG9jcy9zeXN0ZW0vczM5MHgvdmZpby1bYXB8Y2N3XS5yc3Qgc2hv
d3MgL3N5cy9idXMvbWRldg0KDQpUaGFua3MNClpoZW56aG9uZw0K

