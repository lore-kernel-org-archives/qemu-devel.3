Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 34AACCD342F
	for <qemu-devel@archiver.kernel.org>; Fri,  8 May 2026 09:49:31 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wLHpV-0002xq-6m; Fri, 08 May 2026 05:49:10 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <zhenzhong.duan@intel.com>)
 id 1wLHpL-0002ua-3h
 for qemu-devel@nongnu.org; Fri, 08 May 2026 05:48:59 -0400
Received: from mgamail.intel.com ([198.175.65.18])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <zhenzhong.duan@intel.com>)
 id 1wLHpH-0007N3-VO
 for qemu-devel@nongnu.org; Fri, 08 May 2026 05:48:58 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1778233736; x=1809769736;
 h=from:to:cc:subject:date:message-id:references:
 in-reply-to:content-transfer-encoding:mime-version;
 bh=v0RrenxCrPD8tElNHkXcvGoQ8sBWOGUi7hEgTDELs9s=;
 b=guH5cHUsg5nSZusIMw9sZBhVnGO0YVs7rab9G+P4AU3rJWk36XZGLot+
 QucCqDHH+Nng/GMWlXIWTddhhguva6GiGbWHQws/arnWXkbWlhGb8vVg8
 epyz1Q9wUhBvUo06DwX/5Q8SJccBWWGZ9ZsE4G4yHraclV/eQxX4twqBK
 rA/9oi5zSKjwD5yKkwILfUYj+K3TIey8i8pSxzBGT1GFvcOrA0DUPReYZ
 SbFPYKMgqHYFeksmfD7BLNNPp0ToQyTA0/tsesIYcqWq88844WS+mwOQO
 lcWKTBm6u34cgRr91erasqFCLf6d7Kxu196AA6eEX8KQzc44OdXNimWrM Q==;
X-CSE-ConnectionGUID: 3F93DGHWT4ufUjBxE6d+Hg==
X-CSE-MsgGUID: +djB9LMUSheWYXI1IvZVNQ==
X-IronPort-AV: E=McAfee;i="6800,10657,11779"; a="79218880"
X-IronPort-AV: E=Sophos;i="6.23,223,1770624000"; d="scan'208";a="79218880"
Received: from orviesa002.jf.intel.com ([10.64.159.142])
 by orvoesa110.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 08 May 2026 02:48:53 -0700
X-CSE-ConnectionGUID: SfCdfq7ZTnyOSDD6/irCoQ==
X-CSE-MsgGUID: 7Q9cO4fJR9GBBON9Q3Jujg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.23,223,1770624000"; d="scan'208";a="267100054"
Received: from fmsmsx901.amr.corp.intel.com ([10.18.126.90])
 by orviesa002.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 08 May 2026 02:48:52 -0700
Received: from FMSMSX901.amr.corp.intel.com (10.18.126.90) by
 fmsmsx901.amr.corp.intel.com (10.18.126.90) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.37; Fri, 8 May 2026 02:48:52 -0700
Received: from fmsedg901.ED.cps.intel.com (10.1.192.143) by
 FMSMSX901.amr.corp.intel.com (10.18.126.90) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.37 via Frontend Transport; Fri, 8 May 2026 02:48:52 -0700
Received: from CO1PR03CU002.outbound.protection.outlook.com (52.101.46.60) by
 edgegateway.intel.com (192.55.55.81) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.37; Fri, 8 May 2026 02:48:52 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=RhORTwLYINI8aI1j2fdRj/dR89fv1hQgk0tzrWYkEO2NL9JTe1xpeHUylYy1e4JWL5dPyUxpO7+wPD1/QYtL08G7yRw1F/PaOUKB/Y7zZHo4AtJaDPQMn7LDvSPjvAPjexMjFi1hV/FkcvB3P5YLGpsq5yR1I2+Eewbq+ZSFmr8o3BUin+fhrh+CRqfvCpL6WAeYDnUdWVeVaJcP/LiqeYwRON8pgwtparZh2kadZ/1dgN+jVDtpfR8eE/zN4hzEQ7CC7BPJh+e/I2b8l2uqCW5uWgJj9WLF3LUS6Tfp5GXVzZ2bQ76Pdae687tfxysgw/6XU825nE9Q6j/95e73eA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=v0RrenxCrPD8tElNHkXcvGoQ8sBWOGUi7hEgTDELs9s=;
 b=oH6q7szEIPKm6rxp0WWgC2eyKAGnntbBiONpNlHMszNIPk6ZhXT0NgNtjqcwX0nj03EQ/c/L/s+AvJ3PFcWDqhrSpacy8Ns+Qp3AJXCq2t3b7qQi4ARSOiph0bHNoINPI570oCJUNiiidbGemgSh0Yn3BzNfW6dR01qAACSyOfvCOJ0DSUcHGzgHDARXVD65ToXtZeEL3mXy7gLtd4+ZWHdfFcZ0mjKpkf3ZTrAbK2UnlZtx2a6FnS2A5SzOAePumJD4UifxoYAGar7nZedCS76CFIu4aHoijtZk9lXUdPkxy2vFnvvUP3LXCzYiMKErrVUZQ3wi35vCpr8tkymNfw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Received: from IA3PR11MB9136.namprd11.prod.outlook.com (2603:10b6:208:574::12)
 by CH8PR11MB9484.namprd11.prod.outlook.com (2603:10b6:610:2c1::17)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9891.19; Fri, 8 May
 2026 09:48:50 +0000
Received: from IA3PR11MB9136.namprd11.prod.outlook.com
 ([fe80::37b4:37a9:4f3:518b]) by IA3PR11MB9136.namprd11.prod.outlook.com
 ([fe80::37b4:37a9:4f3:518b%5]) with mapi id 15.20.9891.008; Fri, 8 May 2026
 09:48:50 +0000
From: "Duan, Zhenzhong" <zhenzhong.duan@intel.com>
To: "Liu, Yi L" <yi.l.liu@intel.com>, "qemu-devel@nongnu.org"
 <qemu-devel@nongnu.org>
CC: "alex@shazbot.org" <alex@shazbot.org>, "clg@redhat.com" <clg@redhat.com>, 
 "eric.auger@redhat.com" <eric.auger@redhat.com>, "mst@redhat.com"
 <mst@redhat.com>, "jasowang@redhat.com" <jasowang@redhat.com>,
 "jgg@nvidia.com" <jgg@nvidia.com>, "skolothumtho@nvidia.com"
 <skolothumtho@nvidia.com>, "joao.m.martins@oracle.com"
 <joao.m.martins@oracle.com>, "clement.mathieu--drif@bull.com"
 <clement.mathieu--drif@bull.com>, "Tian, Kevin" <kevin.tian@intel.com>, "Hao, 
 Xudong" <xudong.hao@intel.com>, "nicolinc@nvidia.com" <nicolinc@nvidia.com>
Subject: RE: [PATCH v4 03/15] vfio/iommufd: Create nesting parent hwpt with
 IOMMU_HWPT_ALLOC_PASID flag
Thread-Topic: [PATCH v4 03/15] vfio/iommufd: Create nesting parent hwpt with
 IOMMU_HWPT_ALLOC_PASID flag
Thread-Index: AQHc2HDsdHmvyEbLYUuUhfmf5MuDZbYD6uOAgAACq0A=
Date: Fri, 8 May 2026 09:48:50 +0000
Message-ID: <IA3PR11MB9136A1D023CC692E998D29AA923D2@IA3PR11MB9136.namprd11.prod.outlook.com>
References: <20260430071315.354333-1-zhenzhong.duan@intel.com>
 <20260430071315.354333-4-zhenzhong.duan@intel.com>
 <b53f4500-5ebd-45d8-a554-8fe22a060544@intel.com>
In-Reply-To: <b53f4500-5ebd-45d8-a554-8fe22a060544@intel.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: IA3PR11MB9136:EE_|CH8PR11MB9484:EE_
x-ms-office365-filtering-correlation-id: d1ef4a35-72a7-4394-5d6b-08deace7021e
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
 ARA:13230040|10070799003|1800799024|7416014|376014|366016|38070700021|22082099003|56012099003|18002099003;
x-microsoft-antispam-message-info: Lvzi9expn/8bP/Zm8DN0sN+J3B6iwzjAsEgDG46Sba/uN8A7rvvm2Xms5faKN14aeSDoHT6iUt/J1Ep7iQa08EA7fe4XYoldjwUgVxUzMQnfbhI+LtBW6kGKEoUd+uMelh86PJhByEi8Od/3KBk8Rsil2n9cF4nGWuhuqeYoUCDzcVyGf4+f9bxcWIpLe1dLC392zhgdBW+YeQAYtJyROpfejTmfbnB5VkBVvIg3kAPoFzCdoLGQHLOYR9TYwwGm14Pv9cQIUG0cVJPCwBDlmv5/Fi5MTBf/8/ymb7dVBGs0g4r2bHa3cPlT3cDy7tbpRd4R5SGmA6IgPk5Txqy5JKB8qdnQw1HeEVyADLaDNYrKZ7t77GOWpTCsW+pYFJ7mEa9epEJBJRI6Aj6z9AJ9+zVRBQA1MdnFxNnaa+DtzgQ6M+z7JqFic44WQyrUCRbK1+uJb6ZqKQOMxl8+13tccmOuNZPK1GtScMM7mf4jDjtVEXSiHYQRcuiR65d8kRNz9eaj1qUeRPXfmD15rzp+7KkKPRAouNA2QLafZ2PKhXXXTko0nlbG90GAFCPSaMszq0ZGL+S7qqM7htDYDdvYlGMRBUKgXujUrlmVMasAHVeovKwXoHHb4wLx8gghVtDyOu0Ti/4Tlgjnzee4jm4MB7E3djByK6Tkj7k55i9O4GH0oPIP25MhQoNy5boL7VZVxaDuud+V2xoxiM7YLQLv9JTy3lxOlFMCC70dyqczhnmbc9OmOiV15d5DQwzC42X0
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:IA3PR11MB9136.namprd11.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(10070799003)(1800799024)(7416014)(376014)(366016)(38070700021)(22082099003)(56012099003)(18002099003);
 DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 2
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?TWp6Qmk5YXN0eEoyNGlNSE1JQWZtUWk1aWw3Y3dqK05MR3Vab2RFb1F2RTgx?=
 =?utf-8?B?NWhPclRHblhGcENWNHcyYVRqNTA1QlEzVzFFcmVTczIyYlZNUG90TUlodHlK?=
 =?utf-8?B?cFFjTExEMXl0dGo0eEZFVDFtT0NSMXJXSEZJNXVGOW9CR3VKUHVBY0k3em91?=
 =?utf-8?B?YmxncDlsWlFoZHVzMWFjdzdwU0tsNWlCWXRrd1VzVUc5WFRXc3VaRnUwdlNV?=
 =?utf-8?B?aHlYcisyOFI0TmdZcENuSno0dFVJeXJnZVl2aXFhenpkSStNL0JYckpOV0cz?=
 =?utf-8?B?REJrdG1GU2t0ajBlOGVwZDAyVWVFeDd3cFhUak5qeFNRZEJvTTY0SVlLeFBU?=
 =?utf-8?B?OVRFUzFEMU5jM3owbHYyUlB4RlM4STFrY2ltNndHQkhzblpjWmRBanBSS3Ry?=
 =?utf-8?B?ZGRRTXdPV1NsanhseTRhMEpmd29BUStoTEgrekdjYWc5Rzd5MDBQdVlzM244?=
 =?utf-8?B?R3Focm5vVm1ldko0MDVYN0k5blNYZzEyL0NuWE11Ync5emNKaTZZWE5MMlJw?=
 =?utf-8?B?dU1ZWFJJUlFSLzE5dVh3SURXQlBod3ExWm81cXdkdHZkTk5RNWlBekNhRW5a?=
 =?utf-8?B?ZnJwMXNnNDVVaW4rNllzTXpZcGdETys5T1RVVHFlUVdxbUVMQVpQdDBsK0Fq?=
 =?utf-8?B?RExMTVhUNndBQjM0dkU3MkpXK09yRzdydXgrWGtEaE9laEZiL0JPRzFZcmZQ?=
 =?utf-8?B?WDJlck1PaWtiOE5jQXdWUVprSzA0YVVXN0dRWU9TdDBiRjduYWZpcGpySk1i?=
 =?utf-8?B?cnNxd1c5ZUYzUzlhVWNPTDRHN0x5cUVodFhhTUdCZXpvaEJYa0RHcGlVN3Rl?=
 =?utf-8?B?ZWdvTjYweUpSRjJUNVQ0WXJhcWtKaXZVSkM1OUw3ZXNNT1JxTUFjd0tIVHlh?=
 =?utf-8?B?WGpTT0k2N0tzbVpJUWhMSjRMREZOUDNQSTMxcUlCYUhVNFIvK2JDRThXZjFj?=
 =?utf-8?B?Tk1Bc0RRbE5zbWdIaUV4SjgxcUFEaExBc3JxZU9teDdoQ2dpalQwbjRzaXZY?=
 =?utf-8?B?dFFjTGNmbDJHZ2FqbVNtdnRiY3JkeFd3Q1dpK0REdTNScm5pOEZTSU4wNHB3?=
 =?utf-8?B?SmpvWmx1VENVdWVQYnQ4NVZFc3VXbzRFUVpHUW1kdWEzWkNnQ1pLZXJ2cHRu?=
 =?utf-8?B?NTlvWU9qU3d5RHBscEpvR1ljZmNic0JEU1YxOGVhTDRTWnpuNUc1Ni9wWi8v?=
 =?utf-8?B?YVU3QWJCb0J2YjRvNlBoY0tvZjB5d05nc3ova09lZVdkeWlNLyt3QXhCeVQx?=
 =?utf-8?B?Yy8xa2lRcXIvTjVmV0ZVM3dzWFBGZnJ3L3pBMkxJYzZFV2tPU25KMm9XTzNJ?=
 =?utf-8?B?eGdkdVg0TGYvRHFpU3JTYXN1YlA3RFZ0UU91UWkwSXlaWXNJeVN0MllMbW9M?=
 =?utf-8?B?WktZb0dWT2dwWjcxbUlPOXoxWU0vMW1tbnJGVnF6ajJNV29qa1pwOXpMcmFK?=
 =?utf-8?B?QXBaSFVTYktsa0dDSTY1UTZjRndlMGJkdzNsbStRK29WNCtIblVXR1h5aTFE?=
 =?utf-8?B?Z3Vzd0g2L0xEdjlESnBQNnRyb0J0VklBbmxWTGlHSWpmN014R2dWbTdCZEY2?=
 =?utf-8?B?c01XWHF0MjZBYUJKR1Z1SlBOTUZ4dGxZcEhtYitZSy9PR1M5VDJtSVlJcGMz?=
 =?utf-8?B?SEVER1JCTUpnTU1GaEFDMmdLc2kxenZpOWM3a2RSTjFKNnVUUXpZRXVmNVE2?=
 =?utf-8?B?MTdJVmpncTJpRThyUGEyYnE4QWY0UHZPUTNWNkIrVUw2aTN3T2JUQTdlakpx?=
 =?utf-8?B?Y21KV3JhMXFYVmYwNkZzRW1LaGdZUnl5S3VjeXR1eVZXNkh1K2dRNjZOZmEr?=
 =?utf-8?B?c3YxaWdYR0Nzb1N3alNCY1NOUU5rQy9WRVAyV25VM2lxY081Z3VkQXlmN2Uw?=
 =?utf-8?B?QWJNenlCenZ5dDlvaUorZEdCMHJCMmFFdEdIeWg2U3BmbnhOa1V0WmtHVVdO?=
 =?utf-8?B?UU5oTXVoQk9rT1VncEZ5TndsbVRad0lHTng1VUlOYmNPNVFUREw3ZlVqRUpW?=
 =?utf-8?B?c21tc2ZvWDk3Z3ZmOTdrbzV3MjdBUW8yT1NsRnllaFRSNWtLNjkwZHZVS1R4?=
 =?utf-8?B?dm44eE5LTkxkVDZiOEhhSFNicjhCNzU4UkpnbDNicSs2TEJOL1VZcWNBbFpm?=
 =?utf-8?B?blVrNUVTb21BY3N3a08rV0NHU09GdStzdEJkTlYwQzdyeDhkS2hkYjFqTkVS?=
 =?utf-8?B?UDcvc0FUVTVjYitaL0FLem9QVWptWWx0M2h1djZ0L1NTMVlwbEE2MlROcU9E?=
 =?utf-8?B?aHZQTXpzN1BKalIvdUFmcUxPNHNQbWpJQnZ5bjdNaDVTelJZNzFEYThla000?=
 =?utf-8?B?SExiUmMwajZhd2xJbHBkb3Z2NXBLOW1LV0pkM3kvNlo5UGU5MWhqeTNhQ1c3?=
 =?utf-8?Q?dmo8vvDOPZ668poMYzPk+G8igqzNJVZIrp2k4KGD30BNO?=
x-ms-exchange-antispam-messagedata-1: +lxqWcz6s7SWxA==
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-Exchange-RoutingPolicyChecked: AA9NeFZ+ZvlFtxlAaNaCcsAxJOJpH6yBBwxJOqKD9KGYejJS/UVd1MQMsx3GA/i6Er9lpc7e5j/BP+r1PvgUZ7AmsHNez+x7flRRJ/QlezIIG/8oIB3H6QxLw5xEB+AqFJCmySLzDHD33Y+tKLdo1QXSeDEbjlap3/Y1i0W+wJUhdjN7sQqBwKnXcxe7ChArJemkkLqwKS3cxNjHs7zkKWlAHGkn+w8w3+kEc27u9L0qHUJYagAcLJeuSoA1Fb+GnNc5J0lHBirt1Pbi1151Kiy3p8hq9ao6EfW2wwVOc+nzbFLEBO3EO1iLvf3xPjZ3gNabmr8upJgNnm3eg8UElA==
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: IA3PR11MB9136.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: d1ef4a35-72a7-4394-5d6b-08deace7021e
X-MS-Exchange-CrossTenant-originalarrivaltime: 08 May 2026 09:48:50.5643 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: gUOIzv/S3yQj4H5zZDEgvPea7fjQp2qoh/RatBtvecHpCp/0LBp0Blwj5ZykAecq3UAF2cULCPSShGhtKzY9y5u66uiv9wSJvaA/yygOs7s=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH8PR11MB9484
X-OriginatorOrg: intel.com
Received-SPF: pass client-ip=198.175.65.18;
 envelope-from=zhenzhong.duan@intel.com; helo=mgamail.intel.com
X-Spam_score_int: -47
X-Spam_score: -4.8
X-Spam_bar: ----
X-Spam_report: (-4.8 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.438,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_MED=-2.3, SPF_HELO_NONE=0.001,
 SPF_NONE=0.001 autolearn=ham autolearn_force=no
X-Spam_action: no action
X-BeenThere: qemu-devel@nongnu.org
X-Mailman-Version: 2.1.29
Precedence: list
List-Id: qemu development <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <https://lists.nongnu.org/archive/html/qemu-devel>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=subscribe>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org

DQoNCj4tLS0tLU9yaWdpbmFsIE1lc3NhZ2UtLS0tLQ0KPkZyb206IExpdSwgWWkgTCA8eWkubC5s
aXVAaW50ZWwuY29tPg0KPlN1YmplY3Q6IFJlOiBbUEFUQ0ggdjQgMDMvMTVdIHZmaW8vaW9tbXVm
ZDogQ3JlYXRlIG5lc3RpbmcgcGFyZW50IGh3cHQgd2l0aA0KPklPTU1VX0hXUFRfQUxMT0NfUEFT
SUQgZmxhZw0KPg0KPk9uIDQvMzAvMjYgMTU6MTIsIFpoZW56aG9uZyBEdWFuIHdyb3RlOg0KPj4g
V2hlbiBib3RoIGRldmljZSBhbmQgdklPTU1VIGhhdmUgUEFTSUQgZW5hYmxlZCwgdGhlbiBndWVz
dCBtYXkgc2V0dXANCj4+IHBhc2lkIGF0dGFjaGVkIHRyYW5zbGF0aW9uLg0KPg0KPnMvcGFzaWQg
YXR0YWNoZWQgdHJhbnNsYXRpb24vcGFzaWQgdXNhZ2VzIHN1Y2ggYXMgU1ZNLw0KDQpXaWxsIGRv
Lg0KDQo+DQo+PiBWRklPIG5lZWRzIHRvIGJlIGF3YXJlIG9mIHBvdGVudGlhbCBwYXNpZCB1c2Fn
ZSBhbmQgc2hvdWxkIGF0dGFjaCB0aGUNCj4+IG5vbi1wYXNpZCBwYXJ0IG9mIHBhc2lkLWNhcGFi
bGUgZGV2aWNlIHRvIGh3cHQgZmxhZ2dlZCB3aXRoDQo+PiBJT01NVV9IV1BUX0FMTE9DX1BBU0lE
Lg0KPj4NCj4+IEFSTSBTTU1VIGRvZXNuJ3Qgc3VwcG9ydCBJT01NVV9IV1BUX0FMTE9DX1BBU0lE
LCBvbmx5IFZURCBuZWVkIGl0LiBTbw0KPj4gd2UgY2FuJ3QgY2hlY2sgdGhlIGV4aXN0aW5nIHZJ
T01NVSBmbGFnIFZJT01NVV9GTEFHX1BBU0lEX1NVUFBPUlRFRCB0bw0KPj4gZGV0ZXJtaW5lIGlm
IHNldCBmbGFnIElPTU1VX0hXUFRfQUxMT0NfUEFTSUQuIEluc3RlYWQsIGludHJvZHVjZSBhIG5l
dw0KPj4gZmxhZyBWSU9NTVVfRkxBR19XQU5UX1BBU0lEX0FUVEFDSCB3aGljaCB3aWxsIG9ubHkg
YmUgZXhwb3NlZCBieSBWVEQuDQo+Pg0KPj4gT3Bwb3J0dW5pc3RpY2FsbHkgYWRkIGRvY3VtZW50
YXRpb24gZm9yIFZJT01NVV9GTEFHX1BBU0lEX1NVUFBPUlRFRA0KPj4gYW5kIGV4cGxhaW4gdGhl
IGRpZmZlcmVuY2Ugd2l0aCBWSU9NTVVfRkxBR19XQU5UX1BBU0lEX0FUVEFDSC4NCj4+DQo+PiBT
aWduZWQtb2ZmLWJ5OiBaaGVuemhvbmcgRHVhbiA8emhlbnpob25nLmR1YW5AaW50ZWwuY29tPg0K
Pj4gUmV2aWV3ZWQtYnk6IFlpIExpdSA8eWkubC5saXVAaW50ZWwuY29tPg0KPj4gVGVzdGVkLWJ5
OiBYdWRvbmcgSGFvIDx4dWRvbmcuaGFvQGludGVsLmNvbT4NCj4+IC0tLQ0KPj4gICBpbmNsdWRl
L2h3L2NvcmUvaW9tbXUuaCAgICAgICB8IDExICsrKysrKysrKysrDQo+PiAgIGluY2x1ZGUvaHcv
dmZpby92ZmlvLWRldmljZS5oIHwgIDEgKw0KPj4gICBody92ZmlvL2RldmljZS5jICAgICAgICAg
ICAgICB8IDExICsrKysrKysrKysrDQo+PiAgIGh3L3ZmaW8vaW9tbXVmZC5jICAgICAgICAgICAg
IHwgIDggKysrKysrKy0NCj4+ICAgNCBmaWxlcyBjaGFuZ2VkLCAzMCBpbnNlcnRpb25zKCspLCAx
IGRlbGV0aW9uKC0pDQo+Pg0KPj4gZGlmZiAtLWdpdCBhL2luY2x1ZGUvaHcvY29yZS9pb21tdS5o
IGIvaW5jbHVkZS9ody9jb3JlL2lvbW11LmgNCj4+IGluZGV4IDc3NzM5ZDQyMTQuLjIwZDZkNzkw
NjIgMTAwNjQ0DQo+PiAtLS0gYS9pbmNsdWRlL2h3L2NvcmUvaW9tbXUuaA0KPj4gKysrIGIvaW5j
bHVkZS9ody9jb3JlL2lvbW11LmgNCj4+IEBAIC0yMCw5ICsyMCwyMCBAQA0KPj4gICBlbnVtIHZp
b21tdV9mbGFncyB7DQo+PiAgICAgICAvKiB2SU9NTVUgbmVlZHMgbmVzdGluZyBwYXJlbnQgSFdQ
VCB0byBjcmVhdGUgbmVzdGVkIEhXUFQgKi8NCj4+ICAgICAgIFZJT01NVV9GTEFHX1dBTlRfTkVT
VElOR19QQVJFTlQgPSBCSVRfVUxMKDApLA0KPj4gKyAgICAvKg0KPj4gKyAgICAgKiB2SU9NTVUg
c3VwcG9ydHMgUEFTSUQgY2FwYWJpbGl0eSwgVkZJTyBjaGVja3MgdGhpcyBmbGFnIGFuZCBzeW50
aGVzaXplDQo+PiArICAgICAqIGEgUEFTSUQgY2FwYWJpbGl0eS4NCj4+ICsgICAgICovDQo+PiAg
ICAgICBWSU9NTVVfRkxBR19QQVNJRF9TVVBQT1JURUQgPSBCSVRfVUxMKDEpLA0KPj4gICAgICAg
LyogdklPTU1VIG5lZWRzIGRpcnR5IHRyYWNraW5nIG9uIHRoZSBuZXN0aW5nIHBhcmVudCBIV1BU
IGZvciBuZXN0ZWQgdXNlDQo+Ki8NCj4+ICAgICAgIFZJT01NVV9GTEFHX1dBTlRfTkVTVElOR19E
SVJUWV9UUkFDS0lORyA9IEJJVF9VTEwoMiksDQo+PiArICAgIC8qDQo+PiArICAgICAqIHZJT01N
VSByZXF1ZXN0cyBvdGhlciBzdWItc3lzdGVtIGxpa2UgVkZJTyB0byBjcmVhdGUgYSBIV1BUIHRo
YXQgY2FuDQo+YmUNCj4+ICsgICAgICogdXNlZCB3aXRoIFBBU0lEIGF0dGFjaG1lbnQuIFZJT01N
VV9GTEFHX1BBU0lEX1NVUFBPUlRFRCBjYW4ndCBiZQ0KPnVzZWQNCj4+ICsgICAgICogZm9yIHRo
aXMgcHVycG9zZSBhcyBQQVNJRCBhdHRhY2htZW50IGlzIG5lZWRlZCBieSBWVEQgSU9NTVUgYnV0
IG5vdA0KPkFSTQ0KPj4gKyAgICAgKiBTTU1VLg0KPj4gKyAgICAgKi8NCj4+ICsgICAgVklPTU1V
X0ZMQUdfV0FOVF9QQVNJRF9BVFRBQ0ggPSBCSVRfVUxMKDMpLA0KPg0KPmluc3RlYWQgb2YgaGF2
aW5nIGEgZmxhZywgaXMgdGhlcmUgYW55IGNoYW5jZSB0byBsZXQgdmZpbyBjaGVjayB0aGUNCj5z
dHJ1Y3QgaW9tbXVfaHdfaW5mbzo6dHlwZT8gSXQgYXBwZWFycyB0aGF0IG9ubHkNCj5JT01NVV9I
V19JTkZPX1RZUEVfSU5URUxfVlREIGhhcyBleHBsaWNpdCBwYXNpZCBhdHRhY2guDQoNCkkgcmVt
ZW1iZXIgQ2VkcmljIGRpZG4ndCBsaWtlIHZlbmRvciBzcGVjaWZpYyBjb2RlIGluIHRoaXMgY29t
bW9uIGZpbGXwn5iKDQpUaGUgb3RoZXIgcmVhc29uIGlzIHRoaXMgY291bGQgYmUgZWFzaWx5IGV4
dGVuZGVkIHRvIG90aGVyIGlvbW11IHdoaWNoIG5lZWQgcGFzaWQgYXR0YWNoIGluIGZ1dHVyZS4N
Cg0KVGhhbmtzDQpaaGVuemhvbmcNCg==

