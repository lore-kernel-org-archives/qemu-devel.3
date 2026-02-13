Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 73B96EF48E6
	for <qemu-devel@archiver.kernel.org>; Fri, 13 Feb 2026 08:43:35 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vqolm-0007Tf-GW; Fri, 13 Feb 2026 03:43:22 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <zhenzhong.duan@intel.com>)
 id 1vqoll-0007TV-3R
 for qemu-devel@nongnu.org; Fri, 13 Feb 2026 03:43:21 -0500
Received: from mgamail.intel.com ([198.175.65.11])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <zhenzhong.duan@intel.com>)
 id 1vqolh-0001A5-VK
 for qemu-devel@nongnu.org; Fri, 13 Feb 2026 03:43:20 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1770972198; x=1802508198;
 h=from:to:cc:subject:date:message-id:references:
 in-reply-to:content-transfer-encoding:mime-version;
 bh=AZtmg1aUkzMRl7yH3fnT7qrvYdJhmEDwX8Ci3c51MZQ=;
 b=ITq2TvsDaoseX7uN3X+L7g6/lIzbRfcWKmWgbR1yM5qSoN2ibDy7sH45
 o9Em+r2ILJX5Dxgaz/h81cy1IwHDapvhcIS6cbUZj3ynpuOcsh1nkg4zi
 NufLQXXVHid5UcXJR1oIQQ5s+Upm285+MJf7cO5wng3LI7cMJD3JUl6Hv
 BfbgMrl/zLlCc8Ypx1jh7HqOXBxEZCYlq3I+UMLujl3b99zJGWmOkgMWE
 C6TM29z/PVJyB0g4hdxUwLUS8HTIN5xv7dXLIVKQvuIzD9IGcxI6/dQNE
 8AqU0ytrDkVp5rBmfL5r23Ai5rD5/2w3krYxVzwSfI8hBSpXI6jUHssMd A==;
X-CSE-ConnectionGUID: NO1RDZW0TNWg+tWE++J+RA==
X-CSE-MsgGUID: kEPdCd4PTnyPD1lejCyDbA==
X-IronPort-AV: E=McAfee;i="6800,10657,11699"; a="82480053"
X-IronPort-AV: E=Sophos;i="6.21,288,1763452800"; d="scan'208";a="82480053"
Received: from orviesa001.jf.intel.com ([10.64.159.141])
 by orvoesa103.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 13 Feb 2026 00:43:12 -0800
X-CSE-ConnectionGUID: 9Oj2Y3QASzWKAOy3u3zMZw==
X-CSE-MsgGUID: EMsWpYEMQI+9uyuM+DObcw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.21,288,1763452800"; d="scan'208";a="250535141"
Received: from fmsmsx903.amr.corp.intel.com ([10.18.126.92])
 by orviesa001.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 13 Feb 2026 00:43:12 -0800
Received: from FMSMSX901.amr.corp.intel.com (10.18.126.90) by
 fmsmsx903.amr.corp.intel.com (10.18.126.92) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.35; Fri, 13 Feb 2026 00:43:11 -0800
Received: from fmsedg901.ED.cps.intel.com (10.1.192.143) by
 FMSMSX901.amr.corp.intel.com (10.18.126.90) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.35 via Frontend Transport; Fri, 13 Feb 2026 00:43:11 -0800
Received: from MW6PR02CU001.outbound.protection.outlook.com (52.101.48.28) by
 edgegateway.intel.com (192.55.55.81) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.35; Fri, 13 Feb 2026 00:43:11 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=tyioqrOxH7xQLrous2fYBT5yuK5XNwbhllh/tiSqjvUnkVWU7Ws/xynCeO5hUcdhRwxNLE5dCkEhdmAC6al+61SE5G8uaAOBteQJjr28MahgSuU51XYXX1qCt5iWHH2Fs9Mk8NV/llBTf3Q3RVbgQ2h6GctFz0KPKROvv0eMss1+thhxcNbyRB8dJVCWfG8iOO3RTKfVwtkfHUHhY7C12LegNQgHMYStGSbYKnWzvsnqb1mhOeBYMHcG08at7QPdznxv6Idn3SO7+DpuPz87i0KeD1UvDlgHzg67Q0PjKtBrHDd/68jEv8xQwVvLJ75bzpKTtvZhAbtlOARopcG6rQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=AZtmg1aUkzMRl7yH3fnT7qrvYdJhmEDwX8Ci3c51MZQ=;
 b=cgk9tHtJK2JTGkLT+M2ZeQJE/nOhf+c44J8ifpUaz6aXBvZqcBfyFKlvaKypFgI9DbMmPFC/Y48V5lS5S32cZMTq2Vs3WXkG6VSOgXrRWxXjfa6NK03+1DyUoOMRZUpkc5Qf2CpiXcQk03v0GCA3fWOWg9drl402NXAOiX0MddXIA+1HA5d5HgbFfr5VTVfnmw3PhJKKfdzmJSXamMnZ8NW6PEczY+My6b2iN9XQOOmlVmnU+2nY/EC9I0L46LixNmOp8mNca84Pa7eBCD3VZK43jmvWXTtQxaxVuA1dhGJwp2FdkPOchYX/JFjA76EQN4Wwup0I+nt5wdLkL6DWFQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Received: from IA3PR11MB9136.namprd11.prod.outlook.com (2603:10b6:208:574::12)
 by DM4PR11MB5327.namprd11.prod.outlook.com (2603:10b6:5:392::22) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9611.10; Fri, 13 Feb
 2026 08:43:03 +0000
Received: from IA3PR11MB9136.namprd11.prod.outlook.com
 ([fe80::37b4:37a9:4f3:518b]) by IA3PR11MB9136.namprd11.prod.outlook.com
 ([fe80::37b4:37a9:4f3:518b%5]) with mapi id 15.20.9611.012; Fri, 13 Feb 2026
 08:43:03 +0000
From: "Duan, Zhenzhong" <zhenzhong.duan@intel.com>
To: Clement Mathieu--Drif <clement.mathieu--drif@eviden.com>,
 "qemu-devel@nongnu.org" <qemu-devel@nongnu.org>
CC: "alex@shazbot.org" <alex@shazbot.org>, "clg@redhat.com" <clg@redhat.com>, 
 "eric.auger@redhat.com" <eric.auger@redhat.com>, "mst@redhat.com"
 <mst@redhat.com>, "jasowang@redhat.com" <jasowang@redhat.com>,
 "jgg@nvidia.com" <jgg@nvidia.com>, "nicolinc@nvidia.com"
 <nicolinc@nvidia.com>, "skolothumtho@nvidia.com" <skolothumtho@nvidia.com>,
 "joao.m.martins@oracle.com" <joao.m.martins@oracle.com>, "Tian, Kevin"
 <kevin.tian@intel.com>, "Liu, Yi L" <yi.l.liu@intel.com>, "Hao, Xudong"
 <xudong.hao@intel.com>
Subject: RE: [RFC PATCH 05/14] intel_iommu: Change pasid property from bool to
 uint8
Thread-Topic: [RFC PATCH 05/14] intel_iommu: Change pasid property from bool
 to uint8
Thread-Index: AQHclk1PoAq5mUodfUSsvYfD19vxArV+uyyAgAACQKCAABNIgIABDNWQgABZvgCAABGA4A==
Date: Fri, 13 Feb 2026 08:43:03 +0000
Message-ID: <IA3PR11MB9136B8106B0070F03CF9C32B9261A@IA3PR11MB9136.namprd11.prod.outlook.com>
References: <20260205031133.74357-1-zhenzhong.duan@intel.com>
 <20260205031133.74357-6-zhenzhong.duan@intel.com>
 <4ecdbe5bb0b3a945b3534e8535186280aa8f4f66.camel@eviden.com>
 <IA3PR11MB913635BBC7B506CD40FADD779260A@IA3PR11MB9136.namprd11.prod.outlook.com>
 <02bb4c9d859caec478e36d3c6cde6561ba3032ca.camel@eviden.com>
 <IA3PR11MB9136315AB6D784819ECF18C89261A@IA3PR11MB9136.namprd11.prod.outlook.com>
 <eaebbfc58b626db6f946615a6e1d4ba13d6c5b84.camel@eviden.com>
In-Reply-To: <eaebbfc58b626db6f946615a6e1d4ba13d6c5b84.camel@eviden.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: IA3PR11MB9136:EE_|DM4PR11MB5327:EE_
x-ms-office365-filtering-correlation-id: 38f7ea9c-7cc0-44fc-bbff-08de6adbe6b0
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
 ARA:13230040|1800799024|376014|7416014|366016|7053199007|38070700021; 
x-microsoft-antispam-message-info: =?utf-8?B?NUdtWU41UmZaaWFoRThQbmhmeWwzbnJLMDdXNVRxOHNNeE9Ud1ZEWWR3c3dE?=
 =?utf-8?B?TUpva21renlta0dOb1dNVENRUVVHd01nL2tIM3F6aDhrSFJTZkUycFl0NkNS?=
 =?utf-8?B?THpjN2hwbng3MXo1NU9TRUpGZGtDVDlUQ25PbS9VTTNTVDRrQkhPNEREUkk2?=
 =?utf-8?B?WFkwTVZYcnRvMjNlQ3J3aHU3aFR2bmduRHNLNHpjVnh5S3VPMUhMeGV2dVp2?=
 =?utf-8?B?Z1lkWlh5QU5MUU9Vd1NJZTU5cVRxandJRFUzdnozTEZ5QnA1Y1RzUlFzNDc2?=
 =?utf-8?B?SDZvM1doZCtTS3dFRUFja3JyU1BtZ3NqQjd6dmlKVngyeHNZV2pSMDZYeFph?=
 =?utf-8?B?ZTZsWUd4Z2Y1V04vVENoTElJQm1PeWNJY2pPN1BNUlpRemE2ejJqeXYrTHph?=
 =?utf-8?B?NDlTdnBSRDlVY0h3UVpldmRpVVBlWnFKL0ordVZBK2Y5Y2g3L2VPNVU2cHhi?=
 =?utf-8?B?ajZPVXNiZ25BTnNTZ0srTVhYWDR6Wnd3aU9BY0NQVnU3YUdMc0Zqd29PNVpp?=
 =?utf-8?B?T29NazNWU1BZL2h3YXV1cXdsbW1VdHlGam55V1A0SkdNZmZPTlV5NU9LV3dX?=
 =?utf-8?B?YTV5aUFodTQrSmZ1S0o1TUV2L1VQMVBIbEVmVStWSGtWZmgzYkRKSzUxcFFF?=
 =?utf-8?B?NjBIV0Z5OHVrY3FMbzlrT3NFanE0OCtlZjJvRlRqVGVxcHo5dFpuRktyWTFq?=
 =?utf-8?B?UVV1TTFuc3dKbndncjZLRllmR3BDUE52UEpobk9RNWwwblhMN2xGQUM0bkVG?=
 =?utf-8?B?bG5nZUFMOVJlYU55TkVEa3FlYlY4Znh3S09MUkVRc2hLTHVHSCtERGtGUUNh?=
 =?utf-8?B?M0Q5KzB2N3RsWjJ2cndSQ0Q4Wi8yc0k1Q1gxVGVVOUlHdU5lRHQ0R1l3bWcr?=
 =?utf-8?B?cGYwZ3dBS0RTWS9lLzNnTy9MRGpPYkg1N1VXUnUrYlFMOXByZWRLNjZ4WFMw?=
 =?utf-8?B?aXJGSVVzOG81ajFhQytVWFhXdmtvbG5mb1ViSndOU3RsdnAwUmF2MTR6VkhQ?=
 =?utf-8?B?SURCamZLVE9pKzJFa0hHcWpESzdvV3M3Yi9xUk91bnB3dTdCMTlUcGxhaG1E?=
 =?utf-8?B?RTAzOWZvRXlDbjZVa2s3ekZDaUF2NExQWm9EWU9neEdvS1MrUFpzb0FoR1Rq?=
 =?utf-8?B?S29NU2ZpbTRDcXVZRHovVGsrcklnK2xVdmdvRnJqaGRaNHJKQUNCOXVxMHFT?=
 =?utf-8?B?UVl3cGZxdGk0R0RmeXk3L0JuUUFzSW5ocXlQNWRJb1lmbVlHNlVBMUorVmNZ?=
 =?utf-8?B?MytEbys3TGJteFlZVDRQZlg0Y05kQUlsc2ZDY1JKZzlOalA0MzVDSTRTRXNZ?=
 =?utf-8?B?QXZTQllScmhOc050b1RmcGFIMk00UlVmZ2czLzRMajh3dDloS0EwbXViWE1v?=
 =?utf-8?B?ZFNNYjBySUpJSThtclRZeDBnY1N3WG16YzhpaExBYUhTcFFyYmlMcXJJSnVu?=
 =?utf-8?B?c2Z0STFKNDFkdWRhUHIvd2FZYnhuemJMSVlyUEtKY2ViaXZCL2hYN0s5a0wy?=
 =?utf-8?B?WnBtcjdYMnZ1cTNkbHYzY0UrNmVQZi9pc1FlUGg5bUxuZ1BPa1lGTXlwTFBG?=
 =?utf-8?B?TUtsTzlVRVNxeWVJYXhacklpKzBqU0dadVNhd3h5ZzhSSlNjZVJKTHV0blZY?=
 =?utf-8?B?dnd4Wk5SazByUmtWamt4bFNjSFUxQk9uQ01sTVJWaFREYjNiSEd0VmY2M1dL?=
 =?utf-8?B?dHNDeFdCYnhxY3JTRHRRS2R6NDRwNGR5N0tDRDc1WS9iUDV0dVRVM2dlUlZq?=
 =?utf-8?B?UmczNS9uR29wRDhodzNnektRbmFCVC9xbzlXeElnaktUSWxWbUpaWloyR01k?=
 =?utf-8?B?blM0RnVCU29EbDI2UlBoMXZYNnVvYkFmZG1UZ0dYTGJrT0Q0d200S0hOZGc5?=
 =?utf-8?B?bkY2MEprd05hNVpFdGhqMkJPbEJReFJBSjdPNjJqS1dJYWl1a01UTG9mTC9Z?=
 =?utf-8?B?aFdLNUFIVkJDZHRDNGFSa3h2Q0x0VTU0YmgzNnU5b3lDTWFGRlZ2djgwREhh?=
 =?utf-8?B?U2V0WmhsQU85V3l0T0d3RmtxRXpxOVRtbDFnTTRsbXppVjdveHVac2lBY2hz?=
 =?utf-8?B?WURKcElBbkZXRlRrZmJ5clBpT1Z0Smpnd2VsbE15dklWeEZlZ21xdFJ4cXAy?=
 =?utf-8?B?dWdBeXI5ZVJ1S0dTejA3dHFFS3F2a3VtRGhJM0J3eVhrQktQa25tNGVFV05M?=
 =?utf-8?Q?4x7csDBX6ev46AYo8G9p7Yo=3D?=
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:IA3PR11MB9136.namprd11.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(1800799024)(376014)(7416014)(366016)(7053199007)(38070700021);
 DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?OWlVSDZ0NUZRcXVmYmx4Nm12Q0ZHN2hMK3ZNTXkwK3BYQmY5ekNLajVQdzNw?=
 =?utf-8?B?VzhoOGNKbEMxQzNEOHVrL2FTREM2aXlMWGhMS0NVTnFMWkE4NVM0UW1nL2lE?=
 =?utf-8?B?YS9ycGNmOFlEMWpucHdKNTl0Znp3anUxb2F6Y0l3UW1UdDBlK1g1cTZldldX?=
 =?utf-8?B?Y0x4aHRrbzFaUjVzWU0reWxtVjZyNTRpQVN5VmdsbmpxSnFWYnBWWUV3Nm9p?=
 =?utf-8?B?ZHVhREJ6bTBhSFU5VDg2WUpEUnNPb1U2VGphTUJaWElkNlUwMzQweEdiZ21U?=
 =?utf-8?B?WnNsRTNHb05YdlNqTXZKT0lMdTY3WnZYZjFTZGRURng5SVVBVXJZa3ZBUFBU?=
 =?utf-8?B?RG9WK3RPV1oycmRDS0w0QnVpS21uWUJQNEs3UTZ4MEdWU0tJSE5xcWFseWFC?=
 =?utf-8?B?Y3FmcDZFVnNWMEpRY3lQNmdIRzJPdDd3Wm1TY3l2UTRtZ3p6UTk1OXlvMGFC?=
 =?utf-8?B?dVFHUVRrL2s4L2hCRmRqeUZ1WUFhQUNORE1wNS9mWGFmZWdnM2N6TjR6ekpq?=
 =?utf-8?B?bFlUYUxTN3hjUGhoWUMzaWxTOVRLRHV5NmcxdWR0TEIrRkU1VXp0ZGp4anFT?=
 =?utf-8?B?aXVXVTdEVW5EK1NhYVZWVEpnckIybkNXKzlmeUxxRENtcFpKYTBqRGVjancr?=
 =?utf-8?B?M25mOGVJa3d3UC85Nkk5eFM1OTNjQXgrZS9KOW9RMDZmQWhSYm5nUHFsem5E?=
 =?utf-8?B?OHlQUkwxQURieEIxZmhxRGFPOGYzeEpWWGxyaU1Kd0F3VzF1UHd5cXo1R0NI?=
 =?utf-8?B?dlpsOWFCem55UE9sSVppVFFLOGNOWW9xV0pLNFdBZVp1R0hVZ2F4ZXViUVF4?=
 =?utf-8?B?VjA2YmdjYXZScHJTaWV4V2lrRXlkam9hRTBONTFqMllCYXZNVVFIcXVTc2h2?=
 =?utf-8?B?d0pWdVVSQ0RKOGFua3FqdGREVHg0MmFoaVIxRXhaQWc0VEpveUZRc3lDQm1h?=
 =?utf-8?B?S1lBUlB5SURWTngrTm41YjNnV1hOdzhlSDl6aEZVTXdRLzdCZmwxY25nb0du?=
 =?utf-8?B?L00rVGZkWVFaZWtOUHBkNzhRUmZQOUJia0xuRWtueU56ckRSTzJvazdGNkNL?=
 =?utf-8?B?aE9yTVBod1JkVDd5TWhCNUZmeDFkWDJyRTdheE5FTk1zNEtuRWFSZ2YrVWtH?=
 =?utf-8?B?MUo4QWlXYVVvNjRuTVVlMXJ2aFVUdE1KNHRFVzVETitOelVZUE5sQ3oyNzhH?=
 =?utf-8?B?cHZQWXdTb3o0MkZ0aEdGOHRxZmlGRkozUmRQcWhocW4rNi9nSHpaSmZkcjV2?=
 =?utf-8?B?SU9hMkJaL1l1TE02SnlybUp3UDNWVldOakNIZjJXUzVMcGdERjU1Zm1jdmNh?=
 =?utf-8?B?ODZGa3RJTDREU2VOb0F6c0h1a2ZpTTllNk9GOWdmTmdwRHlMai9FVWxSNU1V?=
 =?utf-8?B?RXpMYlhwUDR3WjlMMmlIWUQ0dEZ0aWNHMHZEdTE4b0puOXpEWVVieS9OZnRX?=
 =?utf-8?B?YUF6L0p5UUp2M09WbDlJTXlkS2FQSmx0VndwMUVWaFZaNTBQcWQyZGhQLzhy?=
 =?utf-8?B?S0p6NmY5NE5rUmJqZXZiOGd3alJOSzJ5bXpHbUgyWVljcnFlcWZzT09rQkwr?=
 =?utf-8?B?cVVoc1daYis1bHNBK3NqdExkaWtXVU9wRm1UaFpIbUZobCt0b3ppaVMxdzZr?=
 =?utf-8?B?YmZwTGpCTHREOFNVUGpwUDRQdy9VU3VYVFJlR2d2NVd2TlVNWVlTWjEvN3pT?=
 =?utf-8?B?UlNhUTBXVytpVU1KU3FpbXloeUxTVWRoOXlJMFZ3QjN5UTBxVGg5bmVwbmxG?=
 =?utf-8?B?VDZzZmtkbnJ5eVdHZm5oMzJpUUpGRXB2MlpETnljS3oxeUs3QkoxYlZ6czVa?=
 =?utf-8?B?bkxMRmV3MFFyQnJkU0RjdERHeHhzMTlkZ1I0eVpjOHV1RkpQaXV0enlCenJK?=
 =?utf-8?B?bk1KRm04UnMxcEw5UGpieHFrTFJLYktmaG9CdzlFOVo1ejNIdXVNNm5ZL0ZM?=
 =?utf-8?B?MmU0c3lUTFd5b3JuUlQ2c1NiS0lPUWtCY3FCbkh0ZlJVKzgxbzhXZHhtK25K?=
 =?utf-8?B?OWNUd3oyOGs5dzRyV3ZMTXEvN3o5WDZ6Yis1aHhQL2ZnRkUrbG9UaHFKS012?=
 =?utf-8?B?NVBwSG5SMndxT0lOWXFLSXVnVnhTWmpuRXVWN1ViNjJWNnBGRGtkVFNaOU5y?=
 =?utf-8?B?dUlHcjlKUGQ1UmF3ZTN4ckxjNk9seDNvU2RpdDN4WmpFRDY3d21WNnAxWTNW?=
 =?utf-8?B?T3hhcWZsVS9LclNPU1IwMlk5eVZOUGFVQWt3dVNKeUNJVEEzajJVNGxvQmtU?=
 =?utf-8?B?RDNxL3cxSGdyWWNFVkJ4RTJaU3NOMGZHUDRWSkMzbnNLZ214TU52Nk9xcFFj?=
 =?utf-8?B?WGFaQm1VdksrdUNuOHZDZ3AvOVl5L1lwM3NCRnRPRFgwTnVrZjVpUT09?=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: IA3PR11MB9136.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 38f7ea9c-7cc0-44fc-bbff-08de6adbe6b0
X-MS-Exchange-CrossTenant-originalarrivaltime: 13 Feb 2026 08:43:03.3471 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: rEZDqpjXJLsnglI4lCMvWoQh/3+8A9cjXtj5f3g+rtzqGiXqnEPhgSuDyB3F7yftRHfNMeZ3JyhQOXTObsXZVO70ZMdPeOpisL7rMJEJ9/c=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM4PR11MB5327
X-OriginatorOrg: intel.com
Received-SPF: pass client-ip=198.175.65.11;
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

DQoNCj4tLS0tLU9yaWdpbmFsIE1lc3NhZ2UtLS0tLQ0KPkZyb206IENsZW1lbnQgTWF0aGlldS0t
RHJpZiA8Y2xlbWVudC5tYXRoaWV1LS1kcmlmQGV2aWRlbi5jb20+DQo+U3ViamVjdDogUmU6IFtS
RkMgUEFUQ0ggMDUvMTRdIGludGVsX2lvbW11OiBDaGFuZ2UgcGFzaWQgcHJvcGVydHkgZnJvbSBi
b29sIHRvDQo+dWludDgNCj4NCj4NCj5PbiBGcmksIDIwMjYtMDItMTMgYXQgMDE6MjEgKzAwMDAs
IER1YW4sIFpoZW56aG9uZyB3cm90ZToNCj4+DQo+Pg0KPj4NCj4+ID4gLS0tLS1PcmlnaW5hbCBN
ZXNzYWdlLS0tLS0NCj4+ID4gRnJvbTogQ2xlbWVudCBNYXRoaWV1LS1EcmlmIDxbY2xlbWVudC5t
YXRoaWV1LS0NCj5kcmlmQGV2aWRlbi5jb21dKG1haWx0bzpjbGVtZW50Lm1hdGhpZXUtLWRyaWZA
ZXZpZGVuLmNvbSk+DQo+PiA+IFN1YmplY3Q6IFJlOiBbUkZDIFBBVENIIDA1LzE0XSBpbnRlbF9p
b21tdTogQ2hhbmdlIHBhc2lkIHByb3BlcnR5IGZyb20gYm9vbA0KPnRvDQo+PiA+IHVpbnQ4DQo+
PiA+DQo+PiA+DQo+PiA+IE9uIFRodSwgMjAyNi0wMi0xMiBhdCAwODoxNiArMDAwMCwgRHVhbiwg
Wmhlbnpob25nIHdyb3RlOg0KPj4gPg0KPj4gPiA+DQo+PiA+ID4NCj4+ID4gPg0KPj4gPiA+DQo+
PiA+ID4gPiAtLS0tLU9yaWdpbmFsIE1lc3NhZ2UtLS0tLQ0KPj4gPiA+ID4gRnJvbTogQ2xlbWVu
dCBNYXRoaWV1LS1EcmlmIDxbY2xlbWVudC5tYXRoaWV1LS0NCj4+ID4gPg0KPj4gPg0KPj4gPiBb
ZHJpZkBldmlkZW4uY29tXShtYWlsdG86ZHJpZkBldmlkZW4uY29tKV0obWFpbHRvOltjbGVtZW50
Lm1hdGhpZXUtLQ0KPmRyaWZAZXZpZGVuLmNvbV0obWFpbHRvOmNsZW1lbnQubWF0aGlldS0tZHJp
ZkBldmlkZW4uY29tKSk+DQo+PiA+DQo+PiA+ID4NCj4+ID4gPiA+IFN1YmplY3Q6IFJlOiBbUkZD
IFBBVENIIDA1LzE0XSBpbnRlbF9pb21tdTogQ2hhbmdlIHBhc2lkIHByb3BlcnR5IGZyb20NCj5i
b29sDQo+PiA+ID4NCj4+ID4NCj4+ID4gdG8NCj4+ID4NCj4+ID4gPg0KPj4gPiA+ID4gdWludDgN
Cj4+ID4gPiA+DQo+PiA+ID4gPg0KPj4gPiA+ID4gT24gV2VkLCAyMDI2LTAyLTA0IGF0IDIyOjEx
IC0wNTAwLCBaaGVuemhvbmcgRHVhbiB3cm90ZToNCj4+ID4gPiA+DQo+PiA+ID4gPg0KPj4gPiA+
ID4gPiAneC1wYXNpZC1tb2RlJyBpcyBhIGJvb2wgcHJvcGVydHksIHdlIG5lZWQgYW4gZXh0cmEg
J3BzcycgcHJvcGVydHkgdG8NCj4+ID4gPiA+ID4gcmVwcmVzZW50IFBBU0lEIHNpemUgc3VwcG9y
dGVkLiBCZWNhdXNlIHRoZXJlIGlzIG5vIGFueSBkZXZpY2UgaW4gUUVNVQ0KPj4gPiA+ID4gPiBz
dXBwb3J0aW5nIHBhc2lkIGNhcGFiaWxpdHkgeWV0LCBubyBndWVzdCBjb3VsZCB1c2UgdGhlIHBh
c2lkIGZlYXR1cmUNCj4+ID4gPiA+ID4gdW50aWwgbm93LCAneC1wYXNpZC1tb2RlJyB0YWtlcyBu
byBlZmZlY3QuDQo+PiA+ID4gPiA+DQo+PiA+ID4gPiA+IFNvIGluc3RlYWQgb2YgYW4gZXh0cmEg
J3BzcycgcHJvcGVydHkgd2UgY2FuIHVzZSBhIHNpbmdsZSAncGFzaWQnDQo+PiA+ID4gPiA+IHBy
b3BlcnR5IG9mIHVpbnQ4IHR5cGUgdG8gcmVwcmVzZW50IGlmIHBhc2lkIGlzIHN1cHBvcnRlZCBh
bmQgdGhlIFBBU0lEDQo+PiA+ID4gPiA+IGJpdHMgc2l6ZS4gQSB2YWx1ZSBvZiBOID4gMCBtZWFu
cyBwYXNpZCBpcyBzdXBwb3J0ZWQgYW5kIE4gLSAxIGlzIHRoZQ0KPj4gPiA+ID4gPiB2YWx1ZSBp
biBQU1MgZmllbGQgaW4gRUNBUCByZWdpc3Rlci4NCj4+ID4gPiA+ID4NCj4+ID4gPiA+ID4gU2ln
bmVkLW9mZi1ieTogWmhlbnpob25nIER1YW4NCj4+ID4gPiA+DQo+PiA+ID4gPg0KPj4gPiA+ID4N
Cj4+ID4gPg0KPj4gPg0KPj4gPg0KPjxbW1t6aGVuemhvbmcuZHVhbkBpbnRlbC5jb21dKG1haWx0
bzp6aGVuemhvbmcuZHVhbkBpbnRlbC5jb20pXShtYWlsdG86W3poZW4NCj56aG9uZy5kdWFuQGlu
dGVsLmNvbV0obWFpbHRvOnpoZW56aG9uZy5kdWFuQGludGVsLmNvbSkpXShtYWlsdG86W3poZW4N
Cj4+ID4NCj5bemhvbmcuZHVhbkBpbnRlbC5jb21dKG1haWx0bzp6aG9uZy5kdWFuQGludGVsLmNv
bSldKG1haWx0bzpbemhlbnpob25nLmR1YW4NCj5AaW50ZWwuY29tXShtYWlsdG86emhlbnpob25n
LmR1YW5AaW50ZWwuY29tKSkpPg0KPj4gPg0KPj4gPiA+DQo+PiA+ID4gPg0KPj4gPiA+ID4NCj4+
ID4gPiA+ID4gLS0tDQo+PiA+ID4gPiA+IMKgaHcvaTM4Ni9pbnRlbF9pb21tdV9pbnRlcm5hbC5o
IHwgMSAtDQo+PiA+ID4gPiA+IMKgaW5jbHVkZS9ody9pMzg2L2ludGVsX2lvbW11LmjCoCB8IDIg
Ky0NCj4+ID4gPiA+ID4gwqBody9pMzg2L2ludGVsX2lvbW11LmPCoMKgwqDCoMKgwqDCoMKgwqAg
fCA0ICsrLS0NCj4+ID4gPiA+ID4gwqAzIGZpbGVzIGNoYW5nZWQsIDMgaW5zZXJ0aW9ucygrKSwg
NCBkZWxldGlvbnMoLSkNCj4+ID4gPiA+ID4NCj4+ID4gPiA+ID4gZGlmZiAtLWdpdCBhL2h3L2kz
ODYvaW50ZWxfaW9tbXVfaW50ZXJuYWwuaA0KPj4gPiA+ID4NCj4+ID4gPg0KPj4gPg0KPj4gPiBi
L2h3L2kzODYvaW50ZWxfaW9tbXVfaW50ZXJuYWwuaA0KPj4gPg0KPj4gPiA+DQo+PiA+ID4gPg0K
Pj4gPiA+ID4gPiBpbmRleCBhMmNhNzlmOTI1Li43MWNiM2I2NjJlIDEwMDY0NA0KPj4gPiA+ID4g
PiAtLS0gYS9ody9pMzg2L2ludGVsX2lvbW11X2ludGVybmFsLmgNCj4+ID4gPiA+ID4gKysrIGIv
aHcvaTM4Ni9pbnRlbF9pb21tdV9pbnRlcm5hbC5oDQo+PiA+ID4gPiA+IEBAIC0xOTQsNyArMTk0
LDYgQEANCj4+ID4gPiA+ID4gwqAjZGVmaW5lIFZURF9FQ0FQX1BSU8KgwqDCoMKgwqDCoMKgwqDC
oMKgwqDCoMKgwqDCoCAoMVVMTCA8PCAyOSkNCj4+ID4gPiA+ID4gwqAjZGVmaW5lIFZURF9FQ0FQ
X01ITVbCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgICgxNVVMTCA8PCAyMCkNCj4+ID4gPiA+
ID4gwqAjZGVmaW5lIFZURF9FQ0FQX1NSU8KgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoCAo
MVVMTCA8PCAzMSkNCj4+ID4gPiA+ID4gLSNkZWZpbmUgVlREX0VDQVBfUFNTwqDCoMKgwqDCoMKg
wqDCoMKgwqDCoMKgwqDCoMKgICg3VUxMIDw8IDM1KSAvKiBsaW1pdDogTWVtVHhBdHRyczo6cGlk
DQo+Ki8NCj4+ID4gPiA+ID4gwqAjZGVmaW5lIFZURF9FQ0FQX1BBU0lEwqDCoMKgwqDCoMKgwqDC
oMKgwqDCoMKgwqAgKDFVTEwgPDwgNDApDQo+PiA+ID4gPiA+IMKgI2RlZmluZSBWVERfRUNBUF9T
TVRTwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoCAoMVVMTCA8PCA0MykNCj4+ID4gPiA+ID4g
wqAjZGVmaW5lIFZURF9FQ0FQX1NTVFPCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgICgxVUxM
IDw8IDQ2KQ0KPj4gPiA+ID4gPiBkaWZmIC0tZ2l0IGEvaW5jbHVkZS9ody9pMzg2L2ludGVsX2lv
bW11LmgNCj4+ID4gPiA+DQo+PiA+ID4NCj4+ID4NCj4+ID4gYi9pbmNsdWRlL2h3L2kzODYvaW50
ZWxfaW9tbXUuaA0KPj4gPg0KPj4gPiA+DQo+PiA+ID4gPg0KPj4gPiA+ID4gPiBpbmRleCA2YzYx
ZmQzOWM3Li41ZTU3NzllNDYwIDEwMDY0NA0KPj4gPiA+ID4gPiAtLS0gYS9pbmNsdWRlL2h3L2kz
ODYvaW50ZWxfaW9tbXUuaA0KPj4gPiA+ID4gPiArKysgYi9pbmNsdWRlL2h3L2kzODYvaW50ZWxf
aW9tbXUuaA0KPj4gPiA+ID4gPiBAQCAtMzE1LDcgKzMxNSw3IEBAIHN0cnVjdCBJbnRlbElPTU1V
U3RhdGUgew0KPj4gPiA+ID4gPiDCoMKgwqDCoCBib29sIGJ1Z2d5X2VpbTvCoMKgwqDCoMKgwqDC
oMKgwqDCoMKgwqDCoMKgwqDCoCAvKiBGb3JjZSBidWdneSBFSU0gdW5sZXNzIGVpbT1vZmYgKi8N
Cj4+ID4gPiA+ID4gwqDCoMKgwqAgdWludDhfdCBhd19iaXRzO8KgwqDCoMKgwqDCoMKgwqDCoMKg
wqDCoMKgwqDCoCAvKiBIb3N0L0lPVkEgYWRkcmVzcyB3aWR0aCAoaW4gYml0cykgKi8NCj4+ID4g
PiA+ID4gwqDCoMKgwqAgYm9vbCBkbWFfZHJhaW47wqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDC
oMKgwqAgLyogV2hldGhlciBETUEgci93IGRyYWluaW5nIGVuYWJsZWQgKi8NCj4+ID4gPiA+ID4g
LcKgwqDCoCBib29sIHBhc2lkO8KgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKg
wqAgLyogV2hldGhlciB0byBzdXBwb3J0IFBBU0lEICovDQo+PiA+ID4gPiA+ICvCoMKgwqAgdWlu
dDhfdCBwYXNpZDvCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgIC8qIFBBU0lEIHN1
cHBvcnRlZCBpbiBiaXRzLCAwIGlmIG5vdCAqLw0KPj4gPiA+ID4gPiDCoMKgwqDCoCBib29sIGZz
MWdwO8KgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqAgLyogRmlyc3QgU3Rh
Z2UgMS1HQnl0ZSBQYWdlIFN1cHBvcnQgKi8NCj4+ID4gPiA+ID4NCj4+ID4gPiA+ID4gwqDCoMKg
wqAgLyogVHJhbnNpZW50IE1hcHBpbmcsIFJlc2VydmVkKDApIHNpbmNlIFZURCBzcGVjIHJldmlz
aW9uIDMuMiAqLw0KPj4gPiA+ID4gPiBkaWZmIC0tZ2l0IGEvaHcvaTM4Ni9pbnRlbF9pb21tdS5j
IGIvaHcvaTM4Ni9pbnRlbF9pb21tdS5jDQo+PiA+ID4gPiA+IGluZGV4IGU4YTZmNTBhNWEuLjkx
NmViMGFmNWEgMTAwNjQ0DQo+PiA+ID4gPiA+IC0tLSBhL2h3L2kzODYvaW50ZWxfaW9tbXUuYw0K
Pj4gPiA+ID4gPiArKysgYi9ody9pMzg2L2ludGVsX2lvbW11LmMNCj4+ID4gPiA+ID4gQEAgLTQx
NTEsNyArNDE1MSw3IEBAIHN0YXRpYyBjb25zdCBQcm9wZXJ0eSB2dGRfcHJvcGVydGllc1tdID0g
ew0KPj4gPiA+ID4gPiDCoMKgwqDCoCBERUZJTkVfUFJPUF9CT09MKCJ4LXNjYWxhYmxlLW1vZGUi
LCBJbnRlbElPTU1VU3RhdGUsDQo+PiA+ID4gPg0KPj4gPiA+DQo+PiA+DQo+PiA+IHNjYWxhYmxl
X21vZGUsDQo+PiA+DQo+PiA+ID4NCj4+ID4gPiA+DQo+PiA+ID4gPiBGQUxTRSksDQo+PiA+ID4g
Pg0KPj4gPiA+ID4NCj4+ID4gPiA+ID4gwqDCoMKgwqAgREVGSU5FX1BST1BfQk9PTCgieC1mbHRz
IiwgSW50ZWxJT01NVVN0YXRlLCBmc3RzLCBGQUxTRSksDQo+PiA+ID4gPiA+IMKgwqDCoMKgIERF
RklORV9QUk9QX0JPT0woInNub29wLWNvbnRyb2wiLCBJbnRlbElPTU1VU3RhdGUsDQo+c25vb3Bf
Y29udHJvbCwNCj4+ID4gPiA+DQo+PiA+ID4gPg0KPj4gPiA+ID4gZmFsc2UpLA0KPj4gPiA+ID4N
Cj4+ID4gPiA+DQo+PiA+ID4gPiA+IC3CoMKgwqAgREVGSU5FX1BST1BfQk9PTCgieC1wYXNpZC1t
b2RlIiwgSW50ZWxJT01NVVN0YXRlLCBwYXNpZCwgZmFsc2UpLA0KPj4gPiA+ID4gPiArwqDCoMKg
IERFRklORV9QUk9QX1VJTlQ4KCJwYXNpZCIsIEludGVsSU9NTVVTdGF0ZSwgcGFzaWQsIDApLA0K
Pj4gPiA+ID4gPiDCoMKgwqDCoCBERUZJTkVfUFJPUF9CT09MKCJkbWEtZHJhaW4iLCBJbnRlbElP
TU1VU3RhdGUsIGRtYV9kcmFpbiwNCj50cnVlKSwNCj4+ID4gPiA+ID4gwqDCoMKgwqAgREVGSU5F
X1BST1BfQk9PTCgic3RhbGUtdG0iLCBJbnRlbElPTU1VU3RhdGUsIHN0YWxlX3RtLCBmYWxzZSks
DQo+PiA+ID4gPiA+IMKgwqDCoMKgIERFRklORV9QUk9QX0JPT0woImZzMWdwIiwgSW50ZWxJT01N
VVN0YXRlLCBmczFncCwgdHJ1ZSksDQo+PiA+ID4gPiA+IEBAIC00OTgxLDcgKzQ5ODEsNyBAQCBz
dGF0aWMgdm9pZCB2dGRfY2FwX2luaXQoSW50ZWxJT01NVVN0YXRlICpzKQ0KPj4gPiA+ID4gPiDC
oMKgwqDCoCB9DQo+PiA+ID4gPiA+DQo+PiA+ID4gPiA+IMKgwqDCoMKgIGlmIChzLT5wYXNpZCkg
ew0KPj4gPiA+ID4gPiAtwqDCoMKgwqDCoMKgwqAgcy0+ZWNhcCB8PSBWVERfRUNBUF9QQVNJRCB8
IFZURF9FQ0FQX1BTUzsNCj4+ID4gPiA+ID4gK8KgwqDCoMKgwqDCoMKgIHMtPmVjYXAgPSBWVERf
RUNBUF9QQVNJRCB8IGRlcG9zaXQ2NChzLT5lY2FwLCAzNSwgNSwgcy0+cGFzaWQgLQ0KPjEpOw0K
Pj4gPiA+ID4NCj4+ID4gPiA+DQo+PiA+ID4gPg0KPj4gPiA+ID4gSSB0aGluayB0aGlzIGlzIGEg
Yml0IGRhbmdlcm91cywgdGhlIE1lbVR4QXR0cnMgb25seSBhbGxvdyB1cCB0byA4IGJpdHMuDQo+
PiA+ID4gPiBXZSBoYXZlIGEgY29tbWVudCBuZXh0IHRvIHRoZSBkZWZpbml0aW9uIG9mIFZURF9F
Q0FQX1BTUyBhYm91dCB0aGlzLg0KPj4gPiA+DQo+PiA+ID4NCj4+ID4gPg0KPj4gPiA+IENvdWxk
IHlvdSBlbGFib3JhdGUgd2hhdCBkYW5nZXJvdXMgZG8geW91IHNlZSBpZiBzLT5wYXNpZCA+IDg/
DQo+PiA+ID4gTWVtVHhBdHRycyBvbmx5IGFsbG93IHVwIHRvIDhiaXRzLCB0aGVuIE1heCBQQVNJ
RCBXaWR0aCBpbiBlbXVsYXRlZA0KPmRldmljZSdzDQo+PiA+ID4gUEFTSUQgY2FwYWJpbGl0eSBS
ZWdpc3RlciBpcyBubyBtb3JlIHRoYW4gOC4gRW11bGF0ZWQgZGV2aWNlIHNob3VsZCBuZXZlcg0K
PnNlbmQNCj4+ID4gPiBhIFJlcXVlc3Qtd2l0aC1wYXNpZCB3aXRoIHBhc2lkID4gMjU1Lg0KPj4g
PiA+DQo+PiA+ID4gSGFyZCBjb2RlIFZURF9FQ0FQX1BTUyB0byA4IGJpdHMgd2lsbCBtYWtlIHVz
IG5vdCBhYmxlIHRvIHV0aWxpemUgdGhlIGZ1bGwNCj5wYXNpZA0KPj4gPiA+IHNwYWNlIG9mIHBh
c3N0aHJvdWdoIGRldmljZSBpZiBpdCBoYXMgbGFyZ2VyIE1heCBQQVNJRCBXaWR0aCB2YWx1ZSBp
biBwYXNpZA0KPj4gPg0KPj4gPiBjYXBhYmlsaXR5Lg0KPj4gPg0KPj4gPiA+DQo+PiA+DQo+PiA+
DQo+PiA+IFRoZSBwcmV2aW91cyBhcHByb2FjaCB3YXMgdG8gbWFrZSBzdXJlIHRoYXQgdGhlIGtl
cm5lbCBuZXZlciBhbGxvY2F0ZXMgYSB0b28NCj4+ID4gbGFyZ2UgcGFzaWQNCj4+ID4gYnkgbGlt
aXRpbmcgdGhlIHdpZHRoIGluIHRoZSBpb21tdSBpbnN0ZWFkIG9mIGRvaW50IGl0IGluIHRoZSBk
ZXZpY2VzLiBZb3VyIHBhdGNoDQo+PiA+IHNlZW1zIHRvDQo+PiA+IHJldmVyc2UgdGhlIHByb2Js
ZW0uIElzIGl0IHNvbWV0aGluZyB3ZSBhcmUgcmVhZHkgdG8gYWNjZXB0Pw0KPj4NCj4+DQo+PiBO
b3QgZ2V0IHlvdXIgY29uY2Vybi4gRGVmaW5lIGEgaGFyZCBjb2RlZCBsaW1pdCBsb29rcyBhbiBv
dmVya2lsbC4NCj4+IEhvdyB5b3UgZGVmaW5lIHRvbyBsYXJnZSBoZXJlLCBsYXJnZXIgdGhhbiBN
SU4oaW9tbXUuVlREX0VDQVBfUFNTLCBkZXZpY2Uncw0KPk1heCBQQVNJRCBXaWR0aCk/DQo+DQo+
T2ggeWVwLCB5b3UgYXJlIHJpZ2gsIG15ICJ0b28gbGFyZ2UiIGlzIG5vdCB2ZXJ5IGV4cGxpY2l0
Lg0KPkkgbWVhbiB0b28gbGFyZ2UgdG8gYmUgcGFzc2VkIGZyb20gYW4gZW11bGF0ZWQgZGV2aWNl
LCBhbGwgdGhlIHdheSBkb3duIHRvIHRoZQ0KPmlvbW11LCB0aHJvdWdoIE1lbVR4QXR0cnMuDQo+
DQo+Pg0KPj4gSUlVQywga2VybmVsIHNob3VsZCB0YWtlIE1JTihpb21tdS5WVERfRUNBUF9QU1Ms
IGRldmljZSdzIE1heCBQQVNJRCBXaWR0aCkNCj5hcyB0aGUgdXBwZXIgbGltaXQNCj4+IG9mIHBh
c2lkIHJhbmdlLg0KPg0KPlllcywgdGhhdCdzIHRydWUuDQo+T3VyIGN1cnJlbnQgaW1wbGVtZW50
YXRpb24gbWFrZXMgc3VyZSB0aGF0IHRoaXMgTUlOIGlzIGFsd2F5cyBzbWFsbGVyIHRoYW4gd2hh
dA0KPmZpdHMgaW4gTWVtVHhBdHRycy4NCj5UaGlzIGlzIGFsd2F5cyB0aGUgY2FzZSBhcyBwc3Mg
aXMgc21hbGwgZW5vdWdoLg0KPg0KPkluY3JlYXNpbmcgcHNzIG1lYW5zIHRoYXQgaXQncyBub3cg
dXAgdG8gZGV2aWNlcyB0byBrbm93IHRoYXQgdGhlIGF0dHJzIGNhbm5vdA0KPmNhcnJ5IGEgZnVs
bC13aWR0aCBwYXNpZA0KPmFuZCBleHBvc2UgYSBsb3dlciBwYXNpZCBzaXplIHRvIG1ha2Ugc3Vy
ZSB0aGUga2VybmVsIG5ldmVyIGFsbG9jYXRlcyBhbiBvdXQtb2YtDQo+cmFuZ2UgcGFzaWQuDQoN
Ckkgc2VlIHlvdXIgY29uY2Vybi4NCkxvb2tlZCBpbnRvIFJJU0MtViBlbXVsYXRpb24gc2VyaWVz
IGh0dHBzOi8vbG9yZS5rZXJuZWwub3JnL3FlbXUtZGV2ZWwvMjAyNDEwMDQxNTU3MjEuMjE1NDYy
Ni00LWRiYXJib3phQHZlbnRhbmFtaWNyby5jb20vDQp3aGljaCBpbnRyb2R1Y2VkIE1lbVR4QXR0
cnMucGlkLCBpdCBsb29rcyBNZW1UeEF0dHJzLnBpZCBpcyBvbmx5IHVzZWQgYnkgUklTQy1WLA0K
RS5nLiwgb25seSByaXNjdl9pb21tdV9tZW1vcnlfcmVnaW9uX2luZGV4KCkgcmV0dXJucyBhdHRy
cy5waWQgYW5kIHBhc3MgaXQgdG8gaW1yYy0+dHJhbnNsYXRlKCkuDQoNCkZvciBWVEQgYW5kIG90
aGVyIHZJT01NVXMsIHdlIGNyZWF0ZSBkaWZmZXJlbnQgQWRkcmVzc1NwYWNlIGZvciBkaWZmZXJl
bnQgcGFzaWQsDQpXaGVuIGNhbGwgaW1yYy0+dHJhbnNsYXRlKCkgY2FsbGJhY2ssIGl0J3MgZW5v
dWdoIHRvIGdvIGFoZWFkIHdpdGggQWRkcmVzc1NwYWNlLA0Kd2UgZG9uJ3QgcGFzcyBpbiBwYXNp
ZCB0aHJvdWdoIGlvbW11X2lkeCBwYXJhbWV0ZXIuDQoNCj4NCj5UaGlzIGEgYml0IG1vcmUgZGFn
ZXJvdXMgZm9yIGRldmljZSBpbXBsZW1lbnRvcnMgYnV0IEkgZG9uJ3Qgc2VlIGFueSBvdGhlciB3
YXkgdG8NCj5tYWtlIGFjY2VsIHdvcmsgd2l0aG91dCB0aGlzIGNoYW5nZS4gSSBqdXN0IHdhbnRl
ZCB0byBtYWtlIHN1cmUgdGhhdCB5b3Ugbm90aWNlZA0KPnRoZSBkZXNpZ24gc2hpZnQgYmVoaW5k
IHlvdXIgcGF0Y2guDQoNCkkgdGhpbmsgaXQncyBub3QgYW4gaXNzdWUgd2l0aCBWVEQgYXMgZXhw
bGFpbmVkIGFib3ZlLg0KDQo+DQo+YnR3LCB3aHkgZG8gd2UgbmVlZCB0byBwYXNzIHRoZSBhY3R1
YWwgdmFsdWUgb24gdGhlIGNvbW1hbmQgbGluZT8gQ291bGRuJ3Qgd2UNCj5mZXRjaCB0aGUgcHNz
IHN1cHBvcnRlZCBieQ0KPnRoZSB1bmRlcmx5aW5nIGhhcmR3YXJlIGFuZCB1c2UgdGhlIHNhbWUg
dmFsdWU/DQoNCkJlY2F1c2Ugd2UgY2FuIGhhdmUgaGV0ZXJvZ2VuZW91cyBJT01NVXMgb24gaG9z
dCwgUFNTIGNhbiBiZSBkaWZmZXJlbnQgYmV0d2VlbiB0aGVtLg0KTWVhbndoaWxlLCB0YWtlIG1p
Z3JhdGlvbiBpbnRvIGNvbnNpZGVyYXRpb24sIGl0IG5lZWRzIHRvIGJlIGNvbmZpZ3VyYWJsZSBi
eSB1c2VyLg0KDQpUaGFua3MNClpoZW56aG9uZw0KDQo+DQo+VGhhbmtzIQ0KPmNtZA0KPg0KPj4N
Cj4+IFdlIGFsc28gaGF2ZSBwYXRjaDEyIHRvIGVuc3VyZSB2SU9NTVUncyBwYXNpZCB1cHBlciBs
aW1pdCBub3QgYmlnZ2VyIHRoYW4NCj5ob3N0IHNpZGU6DQo+Pg0KPj4gQEAgLTY0LDYgKzY1LDEz
IEBAIGJvb2wgdnRkX2NoZWNrX2hpb2RfYWNjZWwoSW50ZWxJT01NVVN0YXRlICpzLA0KPlZUREhv
c3RJT01NVURldmljZSAqdnRkX2hpb2QsDQo+PiDCoMKgwqDCoMKgwqDCoMKgIHJldHVybiBmYWxz
ZTsNCj4+IMKgwqDCoMKgIH0NCj4+DQo+PiArwqDCoMKgIC8qIE9ubHkgZG8gdGhlIGNoZWNrIHdo
ZW4gaG9zdCBkZXZpY2Ugc3VwcG9ydCBQQVNJRHMgKi8NCj4+ICvCoMKgwqAgaWYgKGNhcHMtPm1h
eF9wYXNpZF9sb2cyICYmIHMtPnBhc2lkID4gaHBhc2lkKSB7DQo+PiArwqDCoMKgwqDCoMKgwqAg
ZXJyb3Jfc2V0ZyhlcnJwLCAiUEFTSUQgYml0cyBzaXplICVkID4gaG9zdCBJT01NVSBQQVNJRCBi
aXRzIHNpemUgJWQiLA0KPj4gK8KgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoCBz
LT5wYXNpZCwgaHBhc2lkKTsNCj4+ICvCoMKgwqDCoMKgwqDCoCByZXR1cm4gZmFsc2U7DQo+PiAr
wqDCoMKgIH0NCj4+DQo+PiBUaGFua3MNCj4+IFpoZW56aG9uZw0K

