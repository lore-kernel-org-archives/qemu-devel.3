Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id CD5FFCCF9E9
	for <qemu-devel@archiver.kernel.org>; Wed, 29 Oct 2025 07:38:45 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vE0kP-00038p-DE; Wed, 29 Oct 2025 03:37:33 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <zhenzhong.duan@intel.com>)
 id 1vE0kF-00037q-Lm
 for qemu-devel@nongnu.org; Wed, 29 Oct 2025 03:37:25 -0400
Received: from mgamail.intel.com ([192.198.163.19])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <zhenzhong.duan@intel.com>)
 id 1vE0k9-0008TU-FE
 for qemu-devel@nongnu.org; Wed, 29 Oct 2025 03:37:23 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1761723437; x=1793259437;
 h=from:to:cc:subject:date:message-id:references:
 in-reply-to:content-transfer-encoding:mime-version;
 bh=by0W94iiBlNIWnFMjLEhHkrDatEkuiaUntZOEJ7scwI=;
 b=OIkXrieckWUM6DmusM41P18FGsZq/eg/8ZTCCAZtTJlz3494gah0Si+D
 TAj33Fe7nZhaZ/6omP2fw6bE7x4QlvzlJvZwbyAge2DEZ9IAZUlIVCMMZ
 NNhGdMxj1/H7dlYdNCLMi3GW+K3N0+EwHLdwHdk7qtFKlUWqnFxwEsakJ
 Wb0jdhmEYkZkJ7bsMso4fRhzFaprg6EzPqZl+sErpAgWCoX8gexh0KfqO
 DGpmVWnJCLJ+FvgaaFmGB3gBbC3IVFTPWEQgmXfNFyLdwy3c2ekJ+lhTk
 7vppWPf6HxbmRAmy4p2brpEgfiLt7PuoQqJvEwlyXOtMgULPOjqaNi25R A==;
X-CSE-ConnectionGUID: otDpuUbZRZWxvaZw12HvqA==
X-CSE-MsgGUID: oImhsMTHSpK9U9mLFy2BEA==
X-IronPort-AV: E=McAfee;i="6800,10657,11586"; a="62863660"
X-IronPort-AV: E=Sophos;i="6.19,263,1754982000"; d="scan'208";a="62863660"
Received: from orviesa006.jf.intel.com ([10.64.159.146])
 by fmvoesa113.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 29 Oct 2025 00:37:09 -0700
X-CSE-ConnectionGUID: eZGvgzAgQr+1fH/aZc4Q5g==
X-CSE-MsgGUID: wpeay0WFSaGmio6QVx11+g==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.19,263,1754982000"; d="scan'208";a="184768513"
Received: from fmsmsx902.amr.corp.intel.com ([10.18.126.91])
 by orviesa006.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 29 Oct 2025 00:37:09 -0700
Received: from FMSMSX901.amr.corp.intel.com (10.18.126.90) by
 fmsmsx902.amr.corp.intel.com (10.18.126.91) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.27; Wed, 29 Oct 2025 00:37:08 -0700
Received: from fmsedg903.ED.cps.intel.com (10.1.192.145) by
 FMSMSX901.amr.corp.intel.com (10.18.126.90) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.27 via Frontend Transport; Wed, 29 Oct 2025 00:37:08 -0700
Received: from CH1PR05CU001.outbound.protection.outlook.com (52.101.193.71) by
 edgegateway.intel.com (192.55.55.83) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.27; Wed, 29 Oct 2025 00:37:08 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=Dt4hCBf94B7nzADEGIvvUC9i62wYNoP+1Ym4fH56J2it2M2ZsiK39+jlGTrrLOvclzuCzXj7XykRCQf003LabYKOX2GLqMMfmC9wAO6i0Ji793Ev5qNx/9DJgq2/gEaUhxdo7uwzzXigpXS4LugEk2Rm8x3X5OpZcuEzK8o+nZFu+fpbwrCc1YFPhuNHpozWE1/N+2ziKzeboIKJYPeeLEt8JybyX76IC36DRI85kA7YQnf7/IZYqj/CaYllRA5IKB5pSNOlipjX8TKRvqyKnVBgxTcKU3wE6JAlNF+y+6D3Ne4IjfkxBOFKvs1SG13pnz5qerlXu16XQq+ozZV+bg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=by0W94iiBlNIWnFMjLEhHkrDatEkuiaUntZOEJ7scwI=;
 b=lEYkTK+gX1ezOjN3cEXFkSoLnahFoEr0dO76LfttsJRcoWak4MImStTBP4jsGHvGy9Hjub9qILXrdEsK+w8SwpBK37J4pOpUfOhAMFPrLKFdv0XXdI9z5V6aW6uzWN+3e/kTuxc4NljC+6ngXKUbCnpaxN52DyhJ2KJjmLHO0g+PkmeeUVwRkbpGqj5kRsz/Aw7J0cP+sMeI6arJiqQ5UsQf/B6cM+BcYKORnoiHqrBBcjG+GO4n5hmo2rVbDkE/kvVlPMKMQtlGfui7ZmNQ3c/8WaQshyOP6h6cvXT31Si1PsDQ4fzfL8cNH+AHi7cpT6QbinByCuwLSwiM2if5sA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Received: from IA3PR11MB9136.namprd11.prod.outlook.com (2603:10b6:208:574::12)
 by SA2PR11MB5196.namprd11.prod.outlook.com (2603:10b6:806:119::18)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9275.13; Wed, 29 Oct
 2025 07:37:01 +0000
Received: from IA3PR11MB9136.namprd11.prod.outlook.com
 ([fe80::604b:77a4:b1be:3f13]) by IA3PR11MB9136.namprd11.prod.outlook.com
 ([fe80::604b:77a4:b1be:3f13%7]) with mapi id 15.20.9275.013; Wed, 29 Oct 2025
 07:37:01 +0000
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
Subject: RE: [PATCH v7 10/23] intel_iommu: Check for compatibility with
 IOMMUFD backed device when x-flts=on
Thread-Topic: [PATCH v7 10/23] intel_iommu: Check for compatibility with
 IOMMUFD backed device when x-flts=on
Thread-Index: AQHcRMKOrPBpswP/7Ee/sgxt4qHLnLTRjhcAgAcqkmA=
Date: Wed, 29 Oct 2025 07:37:01 +0000
Message-ID: <IA3PR11MB9136B13C0C48EF293D3B599D92FAA@IA3PR11MB9136.namprd11.prod.outlook.com>
References: <20251024084349.102322-1-zhenzhong.duan@intel.com>
 <20251024084349.102322-11-zhenzhong.duan@intel.com>
 <75c219b7-a778-4697-bc8f-fd5ebc5b04a8@redhat.com>
In-Reply-To: <75c219b7-a778-4697-bc8f-fd5ebc5b04a8@redhat.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: IA3PR11MB9136:EE_|SA2PR11MB5196:EE_
x-ms-office365-filtering-correlation-id: 4243f41d-7f93-4385-82a2-08de16bdf2ca
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
 ARA:13230040|366016|1800799024|7416014|376014|38070700021; 
x-microsoft-antispam-message-info: =?utf-8?B?M2VVWHl1dlFPWW9NdlBTMTBYMHlPcnBpNmVFSU1wdlhtbjRNeTRjVlRkSlJn?=
 =?utf-8?B?b0t5MzRsTzVEZ1ZxWHlKWjUxY2lYUXVYeE9rTzNUdHJOKzlDQnFvdGxNTWJv?=
 =?utf-8?B?RkNjeXU2c2dlU2R3RERBN3R2TzJZNnpvMUhUTEJ0Rk1mSkx0UXhQU1kxUzB3?=
 =?utf-8?B?YzEzazQwc3VBVW16YlB4UlRHSDJhSVVuYmtMemJseUQyNTEzWDlDeCt0cXhP?=
 =?utf-8?B?QzJ0Nk15R3cwNXh6YTgxVFYvWmZTaGIxSXpDYVJaSEJDS09LUlZoVEJ0N09U?=
 =?utf-8?B?dWVkdWYwWFp6ZzVnRzBqZzdFUldJM01LbzBWMGQ4b1I3c0xjMGpUdEdDUE9t?=
 =?utf-8?B?NEw1STBqNFJyaTN2bStpNDE0Z0hubmR1dlBOc1U5dHk0L3hoUndscjQ4cllU?=
 =?utf-8?B?Y251enpScU53cG16eWNyUzI1MDMrSk1VV05mU2JQZW0wcm5oNUNqNkIwUWtr?=
 =?utf-8?B?WjZJbzhPT3lPcXNibzgwZVB6SVg5SDYrWWgrMDlBekFyWncyVjdVN1FyZGNY?=
 =?utf-8?B?eHNydVZHM1FCbnF6SDgyR3dHS2JMRlRCNEdmQWF0TjhGZmJUdEJobklWc3I1?=
 =?utf-8?B?bzkwVFBJb2VRODc2MWl3UWp1STRCSkM1SG9MeU9iUkpodWtpaURxYTlPdWhi?=
 =?utf-8?B?UkJvZGlUaDBycktGa1Z2T3FSK0IrNjJmQ3FzR25TWXF1Y0o3cUw4S0hHQUhu?=
 =?utf-8?B?Y2RmTEUyWGdOaGNVSExpNHQxRGJzelh6KytQcW5MV0ZLalVKZHhRbE9ZRElB?=
 =?utf-8?B?NExLSWpOSG5UYzkweUdwcjc3b2hsUzhjYzY5NjJxWTZ5dUZtRkhPL3lFYWNx?=
 =?utf-8?B?eUJoMW8wZWx3a1pnSTFoMmFzNFM1eStVOGVoUkNWUkF3T0lNZFZYYzFtOVNQ?=
 =?utf-8?B?U096dTFubGs5UDRuTEhnUS8rTk1CT05CM0tCQ1Vjc2ZnT3lOTkJMY2tkLzFI?=
 =?utf-8?B?Q21takdyckNsZUNDQnZkS2h2dGlEY0RLeDlmSFlyMlpMRy8wR1lJemM2aDZj?=
 =?utf-8?B?dkhReisxYUZPNzFTaUU4dXBsTFU3NXpmZDczc0ZpTmRtemlpK1VHQkJacFpJ?=
 =?utf-8?B?Y0pOZVJSMmYyckJaZjJQNlJDU0V0K3FudkxzMVJQWVQ4bWdHR3dJdWR0L2NM?=
 =?utf-8?B?TUxncVhhSHlEbnl4SHZ6NTIrSUhnUjBqVHdaT29YUGwrVHR2MURibUNiMm9U?=
 =?utf-8?B?QmZiL01BTSsvVmNJUGVBUGh6dHhjTzZ4VlBsY0Z2Z0VHWHF0TUl4ZmZtZmt3?=
 =?utf-8?B?VmZ4QTV4bGsraFVWelphcENXTVRmbUVLTEIwVDQ5bzF1RHhHa2FhRVpaSGtY?=
 =?utf-8?B?NzdMaWljMHF2QXYxQjVPbFpwQ2JvOHBhengvYVlOY3lqeXp1a0hORjNEa0gr?=
 =?utf-8?B?VnRMRFJveFQ5WjZyU05CSklFdUpaVHZIZTRwN3ZZaTNRSkFxTTRzVG1kM2pI?=
 =?utf-8?B?bTh0SkRUZnJuS1pEZ3V2WFhHWmdhTHE5MStMVUg1WURzMXpwL0dNSmY4SnEx?=
 =?utf-8?B?QjErZU94QTFndndBbzR0Q0lUakhwV0gwVDl0MDE0Yi9OUHpRSjdGK2g5U1p2?=
 =?utf-8?B?U2lVTWlXcnlrckRtNSs5NUN6RC90Ymh2aEFrUEhIYXlRSU9sL0FmTHJTZ1Va?=
 =?utf-8?B?U3d2NXVnMzFJL3VqSGk3aEcyMEhvWkdBSzU4VlhJVWtoc1p0R09HTEV3YWI0?=
 =?utf-8?B?SWFwTXpGM2laVmNtcFV3QzU1amNpbnNJMUVhd1dCYXNCRXdrL1lxOGxiVzgv?=
 =?utf-8?B?Z25XYTBaU2JzOTRnYzJjMi9ubWh5dDFPVy9wMk1lUnQ1Y1poREpweDVEdkdD?=
 =?utf-8?B?Wk5nMTFTTzNZOHM5RzhBUFE1cFd0a1ZiN2VCeGNQc3o2WXQ1TFRkSWVyWXNw?=
 =?utf-8?B?YlBVdGo1ZjBDRlQwRHlBV1JhcHQ4WTNSWTRXTFpnMlpmOEU5T3ExOWJyQ0tX?=
 =?utf-8?B?U3Z2Wkh1Nlk1UVMvVkhFdW8ybmQvRm5CVHgrTjJhQm1IcHZhTEpENHZBS1hB?=
 =?utf-8?B?NVlDTXFtT2NkZm9aY0ZkNkQ3M2IxZnlscEt5S2VqUHc1dHRHOEQyd3ZHc0lW?=
 =?utf-8?Q?cbKSIQ?=
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:IA3PR11MB9136.namprd11.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(366016)(1800799024)(7416014)(376014)(38070700021); DIR:OUT;
 SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?L2RCSDNCU2JWSlg3RlpHenEvTkRSVkZ1cVI3OTg2TGVUWVc2aTN0L05Yc0Jx?=
 =?utf-8?B?WFAxVWtJNVhHVWFDTFF5Nmwwd2szaExvS1hGRUJZcXJZb09jQzVyYkloRTk2?=
 =?utf-8?B?ekhLNjNTOXpJSE9Da3dHQklJbmhBVVMxaHFMVThFSTR4MkhnUjMwelY4Qlgr?=
 =?utf-8?B?ZzY2SjJHeWVEZzBHcFpsL1YvOWF4SkkvUlEzZ21TSmJTWmZoRlVaaTRLd01t?=
 =?utf-8?B?L2llengrdDlhSjJTMThwd3dUNlhpSkU2a2piOFVIbFdURldwdzA5eU04SldE?=
 =?utf-8?B?c0ZWSDNMcWZ6TllBVzN3QXpqVWxFMUVsNkZVNGRGMXpGREc3SnRsMnhnYXVB?=
 =?utf-8?B?WjRpU29hUnQ5eGpJYzFyTG9XVWtsZFo0elR1SlVyajFldDBlaXNiNFBsWElk?=
 =?utf-8?B?NGVaNVpqZE9pQlZWS25BaGFlWkxabThXQTJ0QmVPdGtZWkJvVktLTnZncmJ3?=
 =?utf-8?B?WEtoMXUyam1SQzlRb2dTUjRhVWRCREJOelo4SmpPNWhFb3BqZlMraVArQmQx?=
 =?utf-8?B?ZkpnT2NieTdqL3dGRytGZ0Y2aFYyZkprMkcrSmdBUUI4ZlpoWU4zbjNCb093?=
 =?utf-8?B?WGp1U1NFcy96VDNWcWdXS3BiQ2ZUS3MvUHRlUUtqL3c3YjUvdjlrNnMwSWpY?=
 =?utf-8?B?d2dmU0ZxUzJDeUxRK0x6MkI0YlhtaVBkYTRhakQyaDFNVEx1bkl0Nm96MDVI?=
 =?utf-8?B?c1JUd0NWcmFFOUN6QnhDVWFXTVA3b1M2cHBWSndmbVplNFk1Z0N0NlN1c0Mz?=
 =?utf-8?B?dTh0SXNGZWZoRjUyaWhya20zQjJOTFQ3WUtkKytaOTRydjZTWmhmTHc0ckwz?=
 =?utf-8?B?R2FtSVczZXlKNzI0ejVWK3RycWdyLy81eitISGdIVXNzK3FndVRYMGowYWsx?=
 =?utf-8?B?U3hZOXRvWFgvb0d4Z3h5RXJsRTRpcEljdGpTQU45YS9aTTVOaHFOZXpYMUJG?=
 =?utf-8?B?MnQvSXFkVVJGZElmc2pPdVp0Q1piNEdCZzYydWdhYUVwOEtwUUxGYmNJSVIr?=
 =?utf-8?B?M0xicldvT1doNjgxUWRsNnkvTyt5eHJET0tHVTI3SUd1WWZMZWxpUk0rUVlT?=
 =?utf-8?B?ZlF4VmkwQmcrWFZmQUNkVFlNQm1kQVgrSEtUSXNPL3JqNkYvYllnL2doaWRq?=
 =?utf-8?B?cFlnVEdEY2JoazRLcDhORVRIQ21scXQyenRlV0gwVGptdWdQQWY5UmRpRkpt?=
 =?utf-8?B?VitkR2tHRG1KUUU2VWJsSzR1NGZ5Y3p0a2lQQ1hpYWw1cWhXRi8ybUg1QXYv?=
 =?utf-8?B?eitjN2RRb1hET1lGZzU3eGpsblVIN3o1S3FCOEZvd3IybXRrbmhrWnI1K2VE?=
 =?utf-8?B?YUhsMmRYdUMzR0o3bzI0MlQybExHaWp6eVROaVdlNnd4QVRXV0lZZ1hqRTVS?=
 =?utf-8?B?OXNKeCt3Tm1lbDRzTDJVRXhrR2N4STRsZVBjYnVKVlFCY0dWQUJBOVRGUXpC?=
 =?utf-8?B?SnUrdkh5V0t4UW5GYmNrQTZFa0VyMHlGWmFubkdDQXJpRG9sUW42alJ3RXBT?=
 =?utf-8?B?WEROWU1zNW10cThNSjlKem5EakppaTl1TXNDdE1WYVZMR2J1QU1MdjJURG12?=
 =?utf-8?B?SkpBQnRES1lGUm1hWGNiMXBaNWdBVmhPemxDZUpjVm4yOGEvdEgvUTBMZXRZ?=
 =?utf-8?B?dWdtUms2Q25wUFY2TG9uMXlMaUpHUkZ3dUZSZFVmd2JaZjM1b0hsdmlhTFpU?=
 =?utf-8?B?UjZSUi9melZTTmxHcFZkL3U2ZnJmeHJsTGRRejdtL0dyUFd1YjFyZTdQSzdh?=
 =?utf-8?B?dFppejFiSExMdnBCYUFJV1JsaUhCNmZob0VvQ3E2Z3pYUHB1N2plSU1kUklU?=
 =?utf-8?B?UUJ1bTY2b0xIVkFMZkFyZG8rUFgrR1ZHNEJFUlNJcnVvNWI4VVoyQVZwSkNH?=
 =?utf-8?B?bHl6RHB1RUhoSWg1QWpsUm9UKzFaWllwYkZtN3ZjenVPdU5OTXRQdHRzeFBN?=
 =?utf-8?B?MzNSYnI5bDNRemliTFo4QUdVbGxaZUp0UEJjRkhmWFIxQjZ1WEpYRHIyU2du?=
 =?utf-8?B?UVhFNWZodUtpMlFJdDhTN09LSE9mcEU0Q09sWE1LQzNkdUxDejMyVXU4T3V4?=
 =?utf-8?B?c243TGdaWm5tZUlEUy8rb3FpdnNuMHN6bXVUenhkMnp1OUNwZWdLWWZzWW9z?=
 =?utf-8?Q?FGCVaPlLxA5IHUz/qAiR/60xj?=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: IA3PR11MB9136.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 4243f41d-7f93-4385-82a2-08de16bdf2ca
X-MS-Exchange-CrossTenant-originalarrivaltime: 29 Oct 2025 07:37:01.1120 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: mPAu6+LJRxhQs5t00/Z0JVt873zcxhgc+abIJKmwnG3xzQYidgjgJEzfBR8UpyFRoeLKl0EpwXSvAB4SSE3iUq9RMHjgFG3qMXUDRiCfIjw=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA2PR11MB5196
X-OriginatorOrg: intel.com
Received-SPF: pass client-ip=192.198.163.19;
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
IDxjbGdAcmVkaGF0LmNvbT4NCj5TdWJqZWN0OiBSZTogW1BBVENIIHY3IDEwLzIzXSBpbnRlbF9p
b21tdTogQ2hlY2sgZm9yIGNvbXBhdGliaWxpdHkgd2l0aA0KPklPTU1VRkQgYmFja2VkIGRldmlj
ZSB3aGVuIHgtZmx0cz1vbg0KPg0KPk9uIDEwLzI0LzI1IDEwOjQzLCBaaGVuemhvbmcgRHVhbiB3
cm90ZToNCj4+IFdoZW4gdklPTU1VIGlzIGNvbmZpZ3VyZWQgeC1mbHRzPW9uIGluIHNjYWxhYmxl
IG1vZGUsIGZpcnN0IHN0YWdlIHBhZ2UNCj50YWJsZQ0KPj4gaXMgcGFzc2VkIHRvIGhvc3QgdG8g
Y29uc3RydWN0IG5lc3RlZCBwYWdlIHRhYmxlIGZvciBwYXNzdGhyb3VnaCBkZXZpY2VzLg0KPj4N
Cj4+IFdlIG5lZWQgdG8gY2hlY2sgY29tcGF0aWJpbGl0eSBvZiBzb21lIGNyaXRpY2FsIElPTU1V
IGNhcGFiaWxpdGllcw0KPmJldHdlZW4NCj4+IHZJT01NVSBhbmQgaG9zdCBJT01NVSB0byBlbnN1
cmUgZ3Vlc3QgZmlyc3Qgc3RhZ2UgcGFnZSB0YWJsZSBjb3VsZCBiZQ0KPnVzZWQgYnkNCj4+IGhv
c3QuDQo+Pg0KPj4gRm9yIGluc3RhbmNlLCB2SU9NTVUgc3VwcG9ydHMgZmlyc3Qgc3RhZ2UgMUdC
IGxhcmdlIHBhZ2UgbWFwcGluZywgYnV0DQo+aG9zdCBkb2VzDQo+PiBub3QsIHRoZW4gdGhpcyBJ
T01NVUZEIGJhY2tlZCBkZXZpY2Ugc2hvdWxkIGZhaWwuDQo+Pg0KPj4gRXZlbiBvZiB0aGUgY2hl
Y2tzIHBhc3MsIGZvciBub3cgd2Ugd2lsbGluZ2x5IHJlamVjdCB0aGUgYXNzb2NpYXRpb24gYmVj
YXVzZQ0KPj4gYWxsIHRoZSBiaXRzIGFyZSBub3QgdGhlcmUgeWV0LCBpdCB3aWxsIGJlIHJlbGF4
ZWQgaW4gdGhlIGVuZCBvZiB0aGlzIHNlcmllcy4NCj4+DQo+PiBOb3RlIHZJT01NVSBoYXMgZXhw
b3NlZCBJT01NVV9IV1BUX0FMTE9DX05FU1RfUEFSRU5UIGZsYWcgdG8NCj5mb3JjZSBWRklPIGNv
cmUgdG8NCj4+IGNyZWF0ZSBuZXN0aW5nIHBhcmVudCBIV1BULCBpZiBob3N0IGRvZXNuJ3Qgc3Vw
cG9ydCBuZXN0ZWQgdHJhbnNsYXRpb24sIHRoZQ0KPj4gY3JlYXRpb24gd2lsbCBmYWlsLiBTbyBu
byBuZWVkIHRvIGNoZWNrIG5lc3RlZCBjYXBhYmlsaXR5IGhlcmUuDQo+Pg0KPj4gUmV2aWV3ZWQt
Ynk6IFlpIExpdSA8eWkubC5saXVAaW50ZWwuY29tPg0KPj4gU2lnbmVkLW9mZi1ieTogWmhlbnpo
b25nIER1YW4gPHpoZW56aG9uZy5kdWFuQGludGVsLmNvbT4NCj4+IFJldmlld2VkLWJ5OiBFcmlj
IEF1Z2VyIDxlcmljLmF1Z2VyQHJlZGhhdC5jb20+DQo+PiAtLS0NCj4+ICAgaHcvaTM4Ni9pbnRl
bF9pb21tdS5jIHwgMjUgKysrKysrKysrKysrKysrKysrKysrKysrLQ0KPj4gICAxIGZpbGUgY2hh
bmdlZCwgMjQgaW5zZXJ0aW9ucygrKSwgMSBkZWxldGlvbigtKQ0KPj4NCj4+IGRpZmYgLS1naXQg
YS9ody9pMzg2L2ludGVsX2lvbW11LmMgYi9ody9pMzg2L2ludGVsX2lvbW11LmMNCj4+IGluZGV4
IGNlNGM1NDE2NWUuLjdkOTA4Y2RiNTggMTAwNjQ0DQo+PiAtLS0gYS9ody9pMzg2L2ludGVsX2lv
bW11LmMNCj4+ICsrKyBiL2h3L2kzODYvaW50ZWxfaW9tbXUuYw0KPj4gQEAgLTQ2MzYsOCArNDYz
NiwzMSBAQCBzdGF0aWMgYm9vbCB2dGRfY2hlY2tfaGlvZChJbnRlbElPTU1VU3RhdGUgKnMsDQo+
SG9zdElPTU1VRGV2aWNlICpoaW9kLA0KPj4gICAgICAgICAgIHJldHVybiB0cnVlOw0KPj4gICAg
ICAgfQ0KPj4NCj4+ICsjaWZkZWYgQ09ORklHX0lPTU1VRkQNCj4NCj4NCj5CZWZvcmUgdXNpbmcg
Q09ORklHX0lPTU1VRkQsICcjaW5jbHVkZSBDT05GSUdfREVWSUNFUycgc2hvdWxkIGJlIGRvbmUN
Cj5maXJzdC4gQnV0IGFzIHNhaWQgZWFybGllciwgdGhpcyBpcyBzb21ldGhpbmcgd2Ugd2FudGVk
IHRvIGF2b2lkIGluIHRoZQ0KPmludGVsLWlvbW11IG1vZGVsIHdoaWNoIGNhbiBoYXZlIGRpZmZl
cmVudCBob3N0IElPTU1VIGJhY2tlbmRzLg0KDQpBaCwgeWVzLCBzaG91bGQgaGF2ZSAnI2luY2x1
ZGUgQ09ORklHX0RFVklDRVMnIGluIHRoaXMgcGF0Y2guDQo+DQo+QXQgZmlyc3QgZ2xhbmNlLCBp
dCBzZWVtcyB0byBtZSB0aGF0IHRoZXNlIGNoYW5nZXMgdGFrZSB0aGUgZmFzdCBwYXRoDQo+YW5k
IGF2b2lkIGFuIGFic3RyYWN0IGxheWVyLiBJcyBpdCB0b28gY29tcGxleCB0byBrZWVwIG9uIHVz
aW5nDQo+SG9zdElPTU1VRGV2aWNlQ2xhc3MgPw0KDQpJdCBsb29rcyBxdWVzdGlvbiBpbiBwYXRj
aDEzIGlzIHNhbWUgYXMgaGVyZSwgc28gcmVwbHkgYWxsIGhlcmUuDQoNCldlIGNhbiBiZW5lZml0
IGZyb20gZXhwb3NpbmcgSU9NTVVGRCBpbiB2SU9NTVUsIGJlY2F1c2UgaW4gZm9yZXNlZWFibGUg
ZnV0dXJlLA0KaXQncyB0aGUgb25seSBiYWNrZW5kIHN1cHBvcnRpbmcgbmVzdGVkIEhXUFQsIGl0
J3Mgc3RyYWlnaHRmb3J3YXJkIGZvciB2SU9NTVUNCnRvIGNyZWF0ZSBuZXN0ZWQgSFdQVCBhbmQg
ZG8gYXR0YWNobWVudCB0aHJvdWdoIElPTU1VRkQuDQoNCk1vc3Qgb2YgdGhlIGNvZGUgZ3VhcmRl
ZCBieSBDT05GSUdfSU9NTVVGRCBhcmUgY29vcGVyYXRpb24gYmV0d2VlbiB2SU9NTVUNCmFuZCBJ
T01NVUZEIGJhY2tlbmQsIGl0J3MgaGFyZCB0byBhYnN0cmFjdCB0aGVtIHdpdGggY29tb24gY2Fs
bGJhY2tzIGludG8gVkZJTywNCndlIG5lZWQgdG8gdGFrZSBib3RoIHZ0ZCBhbmQgc21tdSBpbnRv
IGNvbnNpZGVyYXRpb24uDQoNCldlIGFyZSB1c2luZyBIb3N0SU9NTVVEZXZpY2Ugd2hlbmV2ZXIg
c3VpdGFibGUsIGl0J3MgdXNlZCBhcyBhIGNvbm5lY3Rpb24gYmV0d2Vlbg0KVkZJTyBhbmQgdklP
TU1VLCB3ZSBkbyBjYXBhYmlsaXR5IGNoZWNrIGFuZCBjYWxsIGF0dGFjaC9kZXRhY2hfZGV2IGNh
bGxiYWNrIHRocm91Z2ggaXQuDQoNClRoYW5rcw0KWmhlbnpob25nDQoNCg==

