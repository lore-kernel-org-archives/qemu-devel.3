Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 75D62C77B7F
	for <qemu-devel@archiver.kernel.org>; Mon, 23 Jun 2025 09:08:45 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uTd9l-0002LH-LH; Mon, 23 Jun 2025 05:08:01 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <zhenzhong.duan@intel.com>)
 id 1uTd9j-0002L0-Bf
 for qemu-devel@nongnu.org; Mon, 23 Jun 2025 05:07:59 -0400
Received: from mgamail.intel.com ([198.175.65.12])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <zhenzhong.duan@intel.com>)
 id 1uTd9g-00064a-Pa
 for qemu-devel@nongnu.org; Mon, 23 Jun 2025 05:07:58 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1750669677; x=1782205677;
 h=from:to:cc:subject:date:message-id:references:
 in-reply-to:content-transfer-encoding:mime-version;
 bh=QyFFsgDFWsNti7SSe6Sv7Wb7xL34zfy4jjSMZy7mHTM=;
 b=Q5jQmB2iwBUa1kqxW9Op9Od4vGCzp73mxE11K38ad6ayYLE9TjdfHpQ4
 P/14/C60GVra0UTlobNAQID6dhJ8x9aJkMUFy1c9XcQe12tJ4MHfEGiOS
 z78FwqsLmlQWycVlBmgvjsKIa1D2CJ7yeUI4uSvYfb0iG80u1Bx0/bAQx
 IOKy0luFJXJDPoznJCvNtMhYengWSnkc2rmRZiNKcqzjObZH8Ls1xSHOm
 PQJbJWXPkYOqN9EaUQcUahu1ceYgRhxFEghSDXbLt53znuXihldX+BVkG
 kZb1saHYRvaKD/Xx59TPnxoRvTeDBs61yFTVdgW+QWzkL3VZs5AZJkUBv w==;
X-CSE-ConnectionGUID: dPwbZFQRSNumI6r8GH0Oow==
X-CSE-MsgGUID: 06id3oPXQ3KxrA2C+vXJOg==
X-IronPort-AV: E=McAfee;i="6800,10657,11472"; a="64299857"
X-IronPort-AV: E=Sophos;i="6.16,258,1744095600"; d="scan'208";a="64299857"
Received: from orviesa006.jf.intel.com ([10.64.159.146])
 by orvoesa104.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 23 Jun 2025 02:07:54 -0700
X-CSE-ConnectionGUID: lmR+3KIZRHKKedHfIm2DRA==
X-CSE-MsgGUID: Hs5QJxSUTy20gvQtmvTphA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.16,258,1744095600"; d="scan'208";a="151012240"
Received: from orsmsx901.amr.corp.intel.com ([10.22.229.23])
 by orviesa006.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 23 Jun 2025 02:07:54 -0700
Received: from ORSMSX903.amr.corp.intel.com (10.22.229.25) by
 ORSMSX901.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.25; Mon, 23 Jun 2025 02:07:52 -0700
Received: from ORSEDG902.ED.cps.intel.com (10.7.248.12) by
 ORSMSX903.amr.corp.intel.com (10.22.229.25) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.25 via Frontend Transport; Mon, 23 Jun 2025 02:07:52 -0700
Received: from NAM12-BN8-obe.outbound.protection.outlook.com (40.107.237.46)
 by edgegateway.intel.com (134.134.137.112) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.25; Mon, 23 Jun 2025 02:07:52 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=c5SF+wf2CgAMEWuUCU+2Qs8AnUxcjGcCRqUhi4A1F9A3Ut6LtRClrAzD1DOlCGDXPgVstftApTpoRW9/aLHGHb3X8CGWzoPfebffr3WmldyAps4GWNY8U+r2ALKjjgZciHB3oWQKLk9LhH3rP5fGozMNc7v/+yDRXSbtXgHbUTrq5lYV84rka2ZSBFNskn9GMehk17K5DJAquJZCjDO5HrxGt9xgzbdHVnWO3DEjov1kfvx9XjwIote0WpJkuNtsGS7w2Eo/emo8C1jyTTurV2vDxEeLx4qMpQwrTq+yZIZpSniaH8yat0fM7/zkTY2/FpKfkPBnrMzTPUbkS+q36g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=QyFFsgDFWsNti7SSe6Sv7Wb7xL34zfy4jjSMZy7mHTM=;
 b=rQ1W5M2zqw3xzSwGYhuJYwf74kbWZ+tM6Gr/A34zAy/pS1wNBdwXat2bJf+isox7jpW/ZAisOBuNv9Fgp+nbxW0cE+8C+JIkZpzmgIthe6wvpuN4zUbhN8JHifbvQJF7eG8Yn+AhHTYolB4bZj2rfAhNiD6JUfcgbp83Zcc6ust6YnEgPYfQ6uD03Fa+QP+tIXBQKohR2klVfcll1dCnpN1lVc0qEpAkcgVA1P12q9GaU8mBJ9URWpMgay20yOV5lYk8DR8rWc2jiFnZKa0vy7eTXDx28vgAMJ0joCwGqxWSFuBh4UaX6KEybnYd1DmNK5+ADUaHEU/jfXzGgpaf3Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Received: from IA3PR11MB9136.namprd11.prod.outlook.com (2603:10b6:208:574::12)
 by SJ1PR11MB6129.namprd11.prod.outlook.com (2603:10b6:a03:488::12)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8857.21; Mon, 23 Jun
 2025 09:07:50 +0000
Received: from IA3PR11MB9136.namprd11.prod.outlook.com
 ([fe80::604b:77a4:b1be:3f13]) by IA3PR11MB9136.namprd11.prod.outlook.com
 ([fe80::604b:77a4:b1be:3f13%4]) with mapi id 15.20.8835.023; Mon, 23 Jun 2025
 09:07:49 +0000
From: "Duan, Zhenzhong" <zhenzhong.duan@intel.com>
To: Steve Sistare <steven.sistare@oracle.com>, "qemu-devel@nongnu.org"
 <qemu-devel@nongnu.org>
CC: Alex Williamson <alex.williamson@redhat.com>, Cedric Le Goater
 <clg@redhat.com>, "Liu, Yi L" <yi.l.liu@intel.com>, Eric Auger
 <eric.auger@redhat.com>, "Michael S. Tsirkin" <mst@redhat.com>, "Marcel
 Apfelbaum" <marcel.apfelbaum@gmail.com>, Peter Xu <peterx@redhat.com>,
 Fabiano Rosas <farosas@suse.de>
Subject: RE: [PATCH V5 04/38] vfio/container: preserve descriptors
Thread-Topic: [PATCH V5 04/38] vfio/container: preserve descriptors
Thread-Index: AQHb2h3yaet/vzjiqU6M73o4eM+8UrQQh2JA
Date: Mon, 23 Jun 2025 09:07:49 +0000
Message-ID: <IA3PR11MB9136FA577AEC8E5D138B0E249279A@IA3PR11MB9136.namprd11.prod.outlook.com>
References: <1749569991-25171-1-git-send-email-steven.sistare@oracle.com>
 <1749569991-25171-5-git-send-email-steven.sistare@oracle.com>
In-Reply-To: <1749569991-25171-5-git-send-email-steven.sistare@oracle.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: IA3PR11MB9136:EE_|SJ1PR11MB6129:EE_
x-ms-office365-filtering-correlation-id: b63d557c-a955-41fe-3264-08ddb2356d7e
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0; ARA:13230040|366016|376014|1800799024|38070700018;
x-microsoft-antispam-message-info: =?utf-8?B?K0ZGUFdjNmJWeERBMWFEVTZ2ejM5U0ZsUzJQNEp5SEErTklvYUY4SjdJV2Mr?=
 =?utf-8?B?UU5LTGprRnlKNWRTNlB6OHhhaXhUUTJubDFDem1ENW1QWGp4dW02U2xpbzRV?=
 =?utf-8?B?cnUwbHFFZFB2Q1V3cUNUSitUMWpiZmRRZWZ5aWd5bCswZHBvQlVyT1pBNERV?=
 =?utf-8?B?SExvaldJbEQ4QlZBVGh3Y3NmQk52QVpSOVdMMHFiVGc0aWhzL1VmWHpHZFJK?=
 =?utf-8?B?TllmdzloMkJua1BUSG1rc29LbTVXUVRyUEYwdjgyTTE3eVQ4Mmk2SzA0UFV0?=
 =?utf-8?B?L25vM0UxbEZ1UHRsWlgyYjhTcVNMaXFQRVhYL3dMVUhhamNHUE5yZWloWXNG?=
 =?utf-8?B?YTlhZ00rUUxXZjMxc2w3Nnp2UzZTYTVENHhscjJXUUhFcTlibzEyUFRKcDlz?=
 =?utf-8?B?WlJZNVpJUVd1dGwyWUdlV0hSODRuQzF1bUJqWnZxczYrOEU5NC9weFAwUnhN?=
 =?utf-8?B?WHB2QWlsakRNWWJ5NnF0SjY0ZUMwVkJ6RVcrWWZUTTFGQ01obUszNmZFaFp3?=
 =?utf-8?B?VmkwWXMxbko1YTd4R3hiZ2pLZGZ1OXhWSjBRZmEvZllVejc0c2Zoa2dHRXdi?=
 =?utf-8?B?OGRySWF0eEhHYTk4d1pYMkVWTDNtRjZQWTBudGUyWWFHcG5HT1B2RFhZM1gv?=
 =?utf-8?B?Z2xva0NDbVNCRGdvaTZXaFNoR2VZQVlvWUV3eittd0lIOGtSaGo2QytRdmxo?=
 =?utf-8?B?M25QWnVZdXJkSzBSSjhmU3pnVVpXSmhTZmY4ZmNHdlJYMEgzMVlqb09SL2tU?=
 =?utf-8?B?LzQzcEVFVjlzQy9Sd2RmeGJCT09VaXZBbkxrVXh0MEVVODRpRUZWZjN6eWxO?=
 =?utf-8?B?TTU4S2pYN2w4dC9od3B2NWNkekdGSFRMV3NVVGN2UG43cDVidWZuNDBuazQ5?=
 =?utf-8?B?dHJoam5BQXFQNVdiYWZaMEc1c213T3RkZkJ5ZlZIeDFqRWV2Wlp4OXJ3TG4r?=
 =?utf-8?B?ZmhCQVhWandjdjM2UVp1a2hPN0xKbzk2V2dnakRWZXJiUUw4bXpjbVFWSklx?=
 =?utf-8?B?RTJ0ak1oU3dXYXFRaEZlV0w0OFh3cVRnZXV3RHRwdm14VkhuRjhyZGJ0UElF?=
 =?utf-8?B?cHBpM2hFVk5UUjJVTWhiUVgxamlSQ0lrNFhIbTdHOWZtbGZaQUJodE9IamFX?=
 =?utf-8?B?RFJRQlFpRjFRRzYxbWdJQVRva2M5bDZ3MmcyNnRINUZ3bjNhM21sZFErY01v?=
 =?utf-8?B?MS9HZnIzbVBRcFRLcmNweStDQktCZ0ltVGhZSDdCU2JXbEFVNTRQNXJVSzVt?=
 =?utf-8?B?bk9QcTRyZG1GMHRCcUlCUHNKbEpzSkxBOFBJVnNySy9tYURWcW9yWHVlZzEw?=
 =?utf-8?B?eTRUelFlYitFaDcwaTlOUDJmclhVdHFQTHFRYnp3TzAvbkJkOUVHNU9GYlg3?=
 =?utf-8?B?czdab0RienpDaElTNS95K3NoMnhjeU10RHN0Q1RadFNhcCswY3hDY1Jtdi9U?=
 =?utf-8?B?UjloWnFrdXhYcEUxMnJhU25NUkFwZWdJanZUYzJrUVlGdjd4dkIyYVA4TmVP?=
 =?utf-8?B?YmRid3B1TVUrWUlqOTd6TnFtNjFjWk9PbWNLblZINm84Rk9ZNm5hbFdtQjhs?=
 =?utf-8?B?R0xielZVMU9mVjg2b3NnRlBEZmtyQ2phVzVLell3aEtVd2dkTDZvZC9JdkVS?=
 =?utf-8?B?TUJucXRkWFpobEFXRlgvdVlXQWtMMmYycmMwdm8xTjBUdDFPbFJFNTZXWnY5?=
 =?utf-8?B?RndNb0FWUy8xZXVaclFRYzYvUDZZM1pBYUwyMGgvZXE1QkNZMHJNZTBubVl0?=
 =?utf-8?B?UkdkNWIvSlZDdFRVOVRSTnA4M2IwU3ZqbWI1S29NeUZoai9WTE5hRnFXdVdN?=
 =?utf-8?B?TWJHZ09rcS96TEJEeHIwb0FNaVVlNE1ua2NJcGY5cTBqdVJqOEJCTzBOZFM3?=
 =?utf-8?B?VVRvSmlZWVVHeUNsSjF6a1ZLRE9pYWJPWlZielE5K2h6NHN2RTUxdHI4MitX?=
 =?utf-8?B?K2ZSM04vUFlKWGh6YUJmbjdhZnYwWlRXMktGMG5uMzJ5VExjTE9MREdmMG5x?=
 =?utf-8?Q?Sn3xhucDOPoLCKdodyYLj5NT8YBKrg=3D?=
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:IA3PR11MB9136.namprd11.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(366016)(376014)(1800799024)(38070700018); DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?VmZ4alFlckdCT2JNV2grSzFWN0Roc2pRdTUrVHRFS2Z3M0pUODgyajJpL2Vw?=
 =?utf-8?B?RGVaUGMzVXJuaHpGa0hmUFdNK3lCQ2EwYlUrWE9NNzBsRzNmQ3UzdGNzUDVP?=
 =?utf-8?B?MlZoazNyWm5UTkRVei81ckV0YnorZSt3bURuZUNNWWt3Y0VPakx5Nzd6UnJv?=
 =?utf-8?B?cVd4VG8wWERmN2xETHI1QjIrTThRSThZMmJXUDBYOWo4OGlFeGhjdDV0SHZP?=
 =?utf-8?B?c1ppalhWbVllTEVKOUpDVEZGUVA5eitlbTNIREoxRURhZTY1bi9ZYkFEaUQz?=
 =?utf-8?B?dlZnVTRsNEFmTXJNZC9BdjRCcnhoS3FyeHdUMEUzVU94Ump5UVBVQVgwbGlh?=
 =?utf-8?B?bDA4THhHb3pYRTFTMnNFMm5rSU5ZK0xDRkJkd1B3MTFZcXc0bjVUaWwrNmdP?=
 =?utf-8?B?S1JkNXJmWXg3dUg1ZWMxRlhuUW1va2N0cnFIVUhFTldmZXdRaDRGTDFDSldl?=
 =?utf-8?B?TjdRc25sam81THZUL1BvL0NsOTVGbURvQzlzd1BkQWZwK1dWZThWWmxJMWg3?=
 =?utf-8?B?YUZLNW1NY08zNTQ4YkdISEJySjdvZUJhU3o2alcrLzg1MkVQZ0Nxa05LQkRh?=
 =?utf-8?B?cjRvdHdVRHZOVERvTUtZMVNuTTRURkY4YUNENEx2ZGpnb0R1N1ZGWnJ1djZQ?=
 =?utf-8?B?MkFiTTNKQzZjOWIwSlRpYXlFQkZXdnFTWis2ZnNwbTlSbHhDZExjMXUraXF5?=
 =?utf-8?B?QzRPVzh6R3Naenl4VENBUUhUQlN1U1NyZng0eStydDQ1SjV4c1ZxalFvbU82?=
 =?utf-8?B?aWtIR0QrSVhMZ3lRRHQ4M2NkSzJ4aTg2WnB5TGh0ZnU0VDZTUWtkUUFQbk1Y?=
 =?utf-8?B?ajBxNlgyY0lRMWRJZkxJZWZUTUdUdnNWNjhZemJIY2YyU2FpMkNTakVOLy9y?=
 =?utf-8?B?UjhXVHlBdXFEcjBDdUZRbUNHR3BITklaMGRpNTQ1b2Q4NnM3U1ZFSlRLcXVq?=
 =?utf-8?B?Z3Q2c0lSUEx3UGRpeXdBb2xtN2NlYllBaGp0TGZnT2xXNjRFc0wwOUlaeU1h?=
 =?utf-8?B?SzFJa0xMU3UzOWlFSTlaMjJmbHE4UVh4V1JMbVBDSHlUTkl3ZlcwdnFScWFB?=
 =?utf-8?B?OUhWZmloeTZKM3VpODBCb1phV2lEWkpZMFUrLy9RclBWM2JXZUc2MTNoWDdB?=
 =?utf-8?B?R253OFhjOW5EZGxlOE1nZ3o3bDZyMHdYbEl3N3JGVzkxL09tRkdjOEptOGVz?=
 =?utf-8?B?Qk5Rc0hhQUhZaWZqcytrQ1Q4ajZKOVJ0WTJUUXEwdFJQcXFQVHRidmgvWkpx?=
 =?utf-8?B?dnpxVytpcGQwWWNtSVRvMFY3MGxBcHQ4S0dLZ1g0YWludWhCZVJjUlNQTE5D?=
 =?utf-8?B?QnlkYk5ma29oNG5lQi9OK25oR3FsbU5Fb0loVUtXTDZUUVhKQUc0cHFMcVZO?=
 =?utf-8?B?ME9BOVYyQ1M0ZmwvakU0b25Hb1JGV3doSWFDMzA4VDh0VW1OSXFWNkFDZVBN?=
 =?utf-8?B?QTFQYk5rSkc4cklmb29tYnF6STJPWm4rWU56L3BsUHFydElremIxYlp3Mm1w?=
 =?utf-8?B?NWpqb0ZUVHc0V0t1MC9Jc0tnSUhWUjA3U0JLeTRYa2d5UExnSDBDbDhxb25Y?=
 =?utf-8?B?bnhpbndXRFpzZ0Z4RUlnNG9xWG4vd25xYmMvdmJxcmsrcEd6cWZrVmc2U1Nj?=
 =?utf-8?B?SjZZTm5HeHlZdnFVY0kwZmNYb0h4T3ZUSXRtZzJQR2tadzIxZExDU0hMZjNq?=
 =?utf-8?B?UWhkcytJc2l0dk1PbnhRT1BMUmRaODZZRHFzR1ovYk42SXpaaTlkNUFlTzd6?=
 =?utf-8?B?Y0czdXZMNXZkTXBRTkJnNWo0Y1AyM1pnaFZvMUtBZlRSUWJQU1N3VE9BbFZW?=
 =?utf-8?B?T2tWeGwvdkNuUVptczFaenNlU2FIWnhDbVRyS3l4aVJkOU15VTN6b1FPMWZZ?=
 =?utf-8?B?VjM1VjFJdnpaR1lOc0dLMXEvMXpqdFVzWk12b3JSY3cwTmZhSk9uWXU5LzMv?=
 =?utf-8?B?L3FOZ2YzRDdEYmxtMXkxdkRPQndvWkhsUnV3VmF1eXpJK1JqQklqbTltR2Vz?=
 =?utf-8?B?RmxrRFVEWDZGS1p4UTZscnlZSkl2VzM1TFB6cGh4NmhXdjlqZkRaekVWMWdF?=
 =?utf-8?B?YWFoZ1d6YlpuWll3Y3dyaFdSemZMTVQvMFJlZEs3QUR3SitMbWNSSndQMXlV?=
 =?utf-8?B?dERPTEtlSjdBY2h4cWQrK2ZqUFhNRTNJSGdpM1VlYVFDY3Vvd3RISnhCODRB?=
 =?utf-8?B?WUE9PQ==?=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: IA3PR11MB9136.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: b63d557c-a955-41fe-3264-08ddb2356d7e
X-MS-Exchange-CrossTenant-originalarrivaltime: 23 Jun 2025 09:07:49.5944 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: rgiKExPos6cm/AyMh7ym7EiRW7KqqUmPpF7xsknmFn9szCvHnpluloLavQiqtiW4mqg9Tuw5u4eU6zxIc9Y5UbCMqplgsXi0lRBFvMuLQTI=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ1PR11MB6129
X-OriginatorOrg: intel.com
Received-SPF: pass client-ip=198.175.65.12;
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

DQoNCj4tLS0tLU9yaWdpbmFsIE1lc3NhZ2UtLS0tLQ0KPkZyb206IFN0ZXZlIFNpc3RhcmUgPHN0
ZXZlbi5zaXN0YXJlQG9yYWNsZS5jb20+DQo+U3ViamVjdDogW1BBVENIIFY1IDA0LzM4XSB2Zmlv
L2NvbnRhaW5lcjogcHJlc2VydmUgZGVzY3JpcHRvcnMNCj4NCj5BdCB2ZmlvIGNyZWF0aW9uIHRp
bWUsIHNhdmUgdGhlIHZhbHVlIG9mIHZmaW8gY29udGFpbmVyLCBncm91cCwgYW5kIGRldmljZQ0K
PmRlc2NyaXB0b3JzIGluIENQUiBzdGF0ZS4gIE9uIHFlbXUgcmVzdGFydCwgdmZpb19yZWFsaXpl
KCkgZmluZHMgYW5kIHVzZXMNCj50aGUgc2F2ZWQgZGVzY3JpcHRvcnMuDQo+DQo+RHVyaW5nIHJl
dXNlLCBkZXZpY2UgYW5kIGlvbW11IHN0YXRlIGlzIGFscmVhZHkgY29uZmlndXJlZCwgc28gb3Bl
cmF0aW9ucw0KPmluIHZmaW9fcmVhbGl6ZSB0aGF0IHdvdWxkIG1vZGlmeSB0aGUgY29uZmlndXJh
dGlvbiwgc3VjaCBhcyB2ZmlvIGlvY3RsJ3MsDQo+YXJlIHNraXBwZWQuICBUaGUgcmVzdWx0IGlz
IHRoYXQgdmZpb19yZWFsaXplIGNvbnN0cnVjdHMgcWVtdSBkYXRhDQo+c3RydWN0dXJlcyB0aGF0
IHJlZmxlY3QgdGhlIGN1cnJlbnQgc3RhdGUgb2YgdGhlIGRldmljZS4NCj4NCj5TaWduZWQtb2Zm
LWJ5OiBTdGV2ZSBTaXN0YXJlIDxzdGV2ZW4uc2lzdGFyZUBvcmFjbGUuY29tPg0KPlJldmlld2Vk
LWJ5OiBDw6lkcmljIExlIEdvYXRlciA8Y2xnQHJlZGhhdC5jb20+DQo+UmV2aWV3ZWQtYnk6IFpo
ZW56aG9uZyBEdWFuIDx6aGVuemhvbmcuZHVhbkBpbnRlbC5jb20+DQo+LS0tDQo+IGluY2x1ZGUv
aHcvdmZpby92ZmlvLWNwci5oIHwgIDYgKysrKysNCj4gaHcvdmZpby9jb250YWluZXIuYyAgICAg
ICAgfCA2NyArKysrKysrKysrKysrKysrKysrKysrKysrKysrKysrKysrKy0tLS0tLS0tLS0NCj4t
DQo+IGh3L3ZmaW8vY3ByLWxlZ2FjeS5jICAgICAgIHwgNDIgKysrKysrKysrKysrKysrKysrKysr
KysrKysrKysNCj4gMyBmaWxlcyBjaGFuZ2VkLCAxMDAgaW5zZXJ0aW9ucygrKSwgMTUgZGVsZXRp
b25zKC0pDQo+DQo+ZGlmZiAtLWdpdCBhL2luY2x1ZGUvaHcvdmZpby92ZmlvLWNwci5oIGIvaW5j
bHVkZS9ody92ZmlvL3ZmaW8tY3ByLmgNCj5pbmRleCBkNGUwYmQ1Li41YTJlNWY2IDEwMDY0NA0K
Pi0tLSBhL2luY2x1ZGUvaHcvdmZpby92ZmlvLWNwci5oDQo+KysrIGIvaW5jbHVkZS9ody92Zmlv
L3ZmaW8tY3ByLmgNCj5AQCAtMTMsNiArMTMsNyBAQA0KPg0KPiBzdHJ1Y3QgVkZJT0NvbnRhaW5l
cjsNCj4gc3RydWN0IFZGSU9Db250YWluZXJCYXNlOw0KPitzdHJ1Y3QgVkZJT0dyb3VwOw0KPg0K
PiB0eXBlZGVmIHN0cnVjdCBWRklPQ29udGFpbmVyQ1BSIHsNCj4gICAgIEVycm9yICpibG9ja2Vy
Ow0KPkBAIC0zMCw0ICszMSw5IEBAIGJvb2wgdmZpb19jcHJfcmVnaXN0ZXJfY29udGFpbmVyKHN0
cnVjdCBWRklPQ29udGFpbmVyQmFzZQ0KPipiY29udGFpbmVyLA0KPiAgICAgICAgICAgICAgICAg
ICAgICAgICAgICAgICAgICBFcnJvciAqKmVycnApOw0KPiB2b2lkIHZmaW9fY3ByX3VucmVnaXN0
ZXJfY29udGFpbmVyKHN0cnVjdCBWRklPQ29udGFpbmVyQmFzZSAqYmNvbnRhaW5lcik7DQo+DQo+
K2ludCB2ZmlvX2Nwcl9ncm91cF9nZXRfZGV2aWNlX2ZkKGludCBkLCBjb25zdCBjaGFyICpuYW1l
KTsNCj4rDQo+K2Jvb2wgdmZpb19jcHJfY29udGFpbmVyX21hdGNoKHN0cnVjdCBWRklPQ29udGFp
bmVyICpjb250YWluZXIsDQo+KyAgICAgICAgICAgICAgICAgICAgICAgICAgICAgIHN0cnVjdCBW
RklPR3JvdXAgKmdyb3VwLCBpbnQgZmQpOw0KPisNCj4gI2VuZGlmIC8qIEhXX1ZGSU9fVkZJT19D
UFJfSCAqLw0KPmRpZmYgLS1naXQgYS9ody92ZmlvL2NvbnRhaW5lci5jIGIvaHcvdmZpby9jb250
YWluZXIuYw0KPmluZGV4IDkzY2RmODAuLjVjYWFlNGMgMTAwNjQ0DQo+LS0tIGEvaHcvdmZpby9j
b250YWluZXIuYw0KPisrKyBiL2h3L3ZmaW8vY29udGFpbmVyLmMNCj5AQCAtMzEsNiArMzEsOCBA
QA0KPiAjaW5jbHVkZSAic3lzdGVtL3Jlc2V0LmgiDQo+ICNpbmNsdWRlICJ0cmFjZS5oIg0KPiAj
aW5jbHVkZSAicWFwaS9lcnJvci5oIg0KPisjaW5jbHVkZSAibWlncmF0aW9uL2Nwci5oIg0KPisj
aW5jbHVkZSAibWlncmF0aW9uL2Jsb2NrZXIuaCINCj4gI2luY2x1ZGUgInBjaS5oIg0KPiAjaW5j
bHVkZSAiaHcvdmZpby92ZmlvLWNvbnRhaW5lci5oIg0KPiAjaW5jbHVkZSAidmZpby1oZWxwZXJz
LmgiDQo+QEAgLTQyNSw3ICs0MjcsMTIgQEAgc3RhdGljIFZGSU9Db250YWluZXIgKnZmaW9fY3Jl
YXRlX2NvbnRhaW5lcihpbnQgZmQsDQo+VkZJT0dyb3VwICpncm91cCwNCj4gICAgICAgICByZXR1
cm4gTlVMTDsNCj4gICAgIH0NCj4NCj4tICAgIGlmICghdmZpb19zZXRfaW9tbXUoZmQsIGdyb3Vw
LT5mZCwgJmlvbW11X3R5cGUsIGVycnApKSB7DQo+KyAgICAvKg0KPisgICAgICogRHVyaW5nIENQ
UiwganVzdCBzZXQgdGhlIGNvbnRhaW5lciB0eXBlIGFuZCBza2lwIHRoZSBpb2N0bHMsIGFzIHRo
ZQ0KPisgICAgICogY29udGFpbmVyIGFuZCBncm91cCBhcmUgYWxyZWFkeSBjb25maWd1cmVkIGlu
IHRoZSBrZXJuZWwuDQo+KyAgICAgKi8NCj4rICAgIGlmICghY3ByX2lzX2luY29taW5nKCkgJiYN
Cj4rICAgICAgICAhdmZpb19zZXRfaW9tbXUoZmQsIGdyb3VwLT5mZCwgJmlvbW11X3R5cGUsIGVy
cnApKSB7DQo+ICAgICAgICAgcmV0dXJuIE5VTEw7DQo+ICAgICB9DQo+DQo+QEAgLTU5Miw2ICs1
OTksMTEgQEAgc3RhdGljIGJvb2wgdmZpb19jb250YWluZXJfZ3JvdXBfYWRkKFZGSU9Db250YWlu
ZXINCj4qY29udGFpbmVyLCBWRklPR3JvdXAgKmdyb3VwLA0KPiAgICAgZ3JvdXAtPmNvbnRhaW5l
ciA9IGNvbnRhaW5lcjsNCj4gICAgIFFMSVNUX0lOU0VSVF9IRUFEKCZjb250YWluZXItPmdyb3Vw
X2xpc3QsIGdyb3VwLCBjb250YWluZXJfbmV4dCk7DQo+ICAgICB2ZmlvX2dyb3VwX2FkZF9rdm1f
ZGV2aWNlKGdyb3VwKTsNCj4rICAgIC8qDQo+KyAgICAgKiBSZW1lbWJlciB0aGUgY29udGFpbmVy
IGZkIGZvciBlYWNoIGdyb3VwLCBzbyB3ZSBjYW4gYXR0YWNoIHRvIHRoZSBzYW1lDQo+KyAgICAg
KiBjb250YWluZXIgYWZ0ZXIgQ1BSLg0KPisgICAgICovDQo+KyAgICBjcHJfcmVzYXZlX2ZkKCJ2
ZmlvX2NvbnRhaW5lcl9mb3JfZ3JvdXAiLCBncm91cC0+Z3JvdXBpZCwgY29udGFpbmVyLT5mZCk7
DQoNCkkga25vdyB0aGlzIGlzIGFscmVhZHkgbWVyZ2VkLiBKdXN0IG91dCBvZiBjdXJpb3VzLCBJ
dCBsb29rcyBjcHJfc2F2ZV9mZCBpcyBlbm91Z2g/DQoNClpoZW56aG9uZw0K

