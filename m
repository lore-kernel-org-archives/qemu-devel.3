Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3355AC71155
	for <qemu-devel@archiver.kernel.org>; Fri, 20 Jun 2025 05:47:24 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uSUaX-0005bA-4T; Fri, 20 Jun 2025 01:46:57 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <zhenzhong.duan@intel.com>)
 id 1uSUaQ-0005ad-PY
 for qemu-devel@nongnu.org; Fri, 20 Jun 2025 01:46:50 -0400
Received: from mgamail.intel.com ([198.175.65.18])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <zhenzhong.duan@intel.com>)
 id 1uSUaO-0004I2-6v
 for qemu-devel@nongnu.org; Fri, 20 Jun 2025 01:46:50 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1750398408; x=1781934408;
 h=from:to:cc:subject:date:message-id:references:
 in-reply-to:content-transfer-encoding:mime-version;
 bh=Bci6b9lPDoXD5X6E/jwMrfy8zkB/pVzgv5+ith34O6Q=;
 b=Z6sBfQ4YM4tZenK8LAddBptzw3EOtJSsMCaB3+LjjCri0uoL/35yHlxO
 J397p3EjwsSb3fJK0mOt25seu8I6yujE+WvsOHmPO8WUEMdE1sl13KSqi
 VVKyl7LdM6QEWPNj1TUKHnB3fu7697LWD9c93B717sPwcLCiMhUGFo8a2
 inGmaIKvNv5/QzVbJ2Y1eh1aHUCfLRfKZRQIrNkbrAtfCNNODe8cj9GmV
 hXPSPPU7Qd7BNNPLeZJ87xzf8gdjnp9EalmNAr9s6EtO/6Ya9Cht1dQYb
 Aa1svBRirh16IZctrTbtwutrmVnUqtxM12cESTHleLOl9GueNznqxwN4D A==;
X-CSE-ConnectionGUID: yv1IyXWsS7ewKiOnKyy7hw==
X-CSE-MsgGUID: XOQknm1PShifw2/1puJ8uw==
X-IronPort-AV: E=McAfee;i="6800,10657,11469"; a="52796698"
X-IronPort-AV: E=Sophos;i="6.16,250,1744095600"; d="scan'208";a="52796698"
Received: from orviesa004.jf.intel.com ([10.64.159.144])
 by orvoesa110.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 19 Jun 2025 22:46:42 -0700
X-CSE-ConnectionGUID: RE8lMNwuS4quAp1kvXVsuA==
X-CSE-MsgGUID: M04ja5YxTpCUpNsXdl8PaA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.16,250,1744095600"; d="scan'208";a="155373359"
Received: from orsmsx903.amr.corp.intel.com ([10.22.229.25])
 by orviesa004.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 19 Jun 2025 22:46:43 -0700
Received: from ORSMSX901.amr.corp.intel.com (10.22.229.23) by
 ORSMSX903.amr.corp.intel.com (10.22.229.25) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.25; Thu, 19 Jun 2025 22:46:42 -0700
Received: from ORSEDG901.ED.cps.intel.com (10.7.248.11) by
 ORSMSX901.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.25 via Frontend Transport; Thu, 19 Jun 2025 22:46:42 -0700
Received: from NAM04-DM6-obe.outbound.protection.outlook.com (40.107.102.79)
 by edgegateway.intel.com (134.134.137.111) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.25; Thu, 19 Jun 2025 22:46:41 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=JWWOxkQxIXHbdoCmrYHrSKzzV2ZQIUf+GpFQ9/4HGCcvq5Ok0WigOp+UkCeZzwZsgA2XwhIEaufWbaJCbGqrUpdpofI8+gEIly+oHL/79/c6C7nxkJQNiBHI9ZyMLcSAUX4KvT/LmDG+rMiOPL70cUmGdY+tkbbpQQTRfDLrHn3gasVWaqBu/M4WldlrOxzEIlqOx9+X5TfQOrslH4T5JnuXLb6Ia2gRs9V67dBulKgLhUYncD7tuuXRyMRwqe1gVCICao2SKrbRf54LAJjKb2eHaTzQer/ozDTk/RyVM/03wBuB7OF/fsKfbv2FNCYaq2yuWdXUXB7aHEZEdkwIVQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Bci6b9lPDoXD5X6E/jwMrfy8zkB/pVzgv5+ith34O6Q=;
 b=tzNsBcAu+Y3YqLcJ8CCJQNvaGCm7zbAK8oUN09ekPl7IVok07cGL4G9pF+aIpAWUGnXO9F34FlRhbBgffF3sqAJZJxkcZIJ8EZEiIk5wPeeRABK7gpYR6eQ+ECdQEKqSBAsxYVA44fYbbwQAPECKeB0SaW5aapHfAFROORU55Gs4infFMnyCMBSKUgwqqjZv60A1dORsDCU1GSKcsxEYJWrjCUiXHJVsljR/2J4Q9cPRh62fPX/ONTaK26+ZikpXwW6T7jRAEHXDzk2uTDA1vB2BGdlZX7OuHQuNvzW1KNGPH1e3/6t6Ryt+bmkeWeNrYGfttiVloX9Ng5rbwrx8Ow==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Received: from IA3PR11MB9136.namprd11.prod.outlook.com (2603:10b6:208:574::12)
 by CY8PR11MB7268.namprd11.prod.outlook.com (2603:10b6:930:9b::9) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8835.26; Fri, 20 Jun
 2025 05:46:39 +0000
Received: from IA3PR11MB9136.namprd11.prod.outlook.com
 ([fe80::604b:77a4:b1be:3f13]) by IA3PR11MB9136.namprd11.prod.outlook.com
 ([fe80::604b:77a4:b1be:3f13%4]) with mapi id 15.20.8835.023; Fri, 20 Jun 2025
 05:46:39 +0000
From: "Duan, Zhenzhong" <zhenzhong.duan@intel.com>
To: =?utf-8?B?Q8OpZHJpYyBMZSBHb2F0ZXI=?= <clg@redhat.com>, Steven Sistare
 <steven.sistare@oracle.com>, "qemu-devel@nongnu.org" <qemu-devel@nongnu.org>
CC: Alex Williamson <alex.williamson@redhat.com>, "Liu, Yi L"
 <yi.l.liu@intel.com>, Eric Auger <eric.auger@redhat.com>, "Michael S.
 Tsirkin" <mst@redhat.com>, Marcel Apfelbaum <marcel.apfelbaum@gmail.com>,
 Peter Xu <peterx@redhat.com>, Fabiano Rosas <farosas@suse.de>
Subject: RE: [PATCH V5 00/38] Live update: vfio and iommufd
Thread-Topic: [PATCH V5 00/38] Live update: vfio and iommufd
Thread-Index: AQHb2h3xDEKw/qfkYEiV3UWx1ygU9bP8oyoAgAAF4YCAAVwCgIAABAAAgAEYnYCAC057AIABJ7vQ
Date: Fri, 20 Jun 2025 05:46:39 +0000
Message-ID: <IA3PR11MB9136AE500CF95C8DFF41AA17927CA@IA3PR11MB9136.namprd11.prod.outlook.com>
References: <1749569991-25171-1-git-send-email-steven.sistare@oracle.com>
 <0330df5e-8a9d-4fdf-bee8-a864eedac24d@redhat.com>
 <effe22b4-c6e4-41c2-b3e2-d03160560f86@redhat.com>
 <b6e11593-cd1b-4d51-9c17-37ccefccd094@redhat.com>
 <573aa339-1c40-43b4-997d-c3e4996caaec@oracle.com>
 <c95a3209-7517-4d70-b7a1-2aab1202f601@redhat.com>
 <d2cd7680-ff63-4baa-bda4-05d58bd263db@redhat.com>
In-Reply-To: <d2cd7680-ff63-4baa-bda4-05d58bd263db@redhat.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: IA3PR11MB9136:EE_|CY8PR11MB7268:EE_
x-ms-office365-filtering-correlation-id: bf31eda7-07f0-4c0a-2d35-08ddafbdd3b0
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0; ARA:13230040|366016|376014|1800799024|38070700018;
x-microsoft-antispam-message-info: =?utf-8?B?MWdPVVo5U2ZwMzMwWUNSMnAycks5UkxzUXdHTEVNc2kvK1VWb1lhMjNVYnds?=
 =?utf-8?B?dGZHUUo5TjFBc2FQVWs2cFdJUkZRVlV5OG5BUTlhQzY4UzNaWitxZzZRMTFa?=
 =?utf-8?B?UW1JZDhNVW4wbFpyM0ZZNVgwTEEwTWFPTVBPN0huRkdSVGxMdTdOb21WVDVZ?=
 =?utf-8?B?d1RXdHo4UkR5L2JUdFJyWGdGNi8zcVB5YS9Ubm1lUkpYNXdVNXBtck5ZeEQ4?=
 =?utf-8?B?YnRhdHViaVhyQ1ZHQjJDTmI3OXVDWW1Xd1RCZjFYOXJIbERWeUlLeTUvTFk4?=
 =?utf-8?B?YnlJWDZyWk9URk1oak5waGdvVFR2YWhQNlpoSW1kNXdDUTR6amNNK0hCa3BN?=
 =?utf-8?B?WjIxQkZ1cGdOejJEMHYxRk9veTVQT3JseE5GT0g3cHJ5T212d25XKytMRkkx?=
 =?utf-8?B?Q0NrdFZ0Uk5tdkFTRzJGS05YQkFpeXU3TGpLTE8yYWh2NHZWbUw2eG5LVGcv?=
 =?utf-8?B?TjZkZjJhVWwvUVpmWDVLSzFCVDVVNVFvLzM0ZXo1clEzQ3V5T0NMVXQwUVhv?=
 =?utf-8?B?ekdtb1VqRURrNkR3QUZKVDhNU3Z4NnVBcGVXRkJGZGNrL1NiYWNDVEMxNnVq?=
 =?utf-8?B?aWZNV2RodVR2d0dJZ3RZUmE2aUJKNFZoNGsxcktRU1Avc2x6Zjdodm9wa2Fn?=
 =?utf-8?B?SlNOelp5MTNWMUthQ3UxSkM1TWtSRXdkdHhiTmFGdUJFQjlWT2drOGdDOFZi?=
 =?utf-8?B?c2w3ZnZ0RFVzeldBL2ZMWUU1ZDNtY1ZjK1pQYUdOTFpPb3RDb0pkSlFDd3hO?=
 =?utf-8?B?V0V5cjlFZ3NKcnVOa1ZuRGl6TWR5ZE45UXo1K0hrKzlDbWFQVHVWMjlReWJ0?=
 =?utf-8?B?VGpPM1dFSTh5T0t1RlFtMWd4TENHREJPUTFCSHBLc0habTNTVEp6R3kyWGtj?=
 =?utf-8?B?dzRMUnVzNlU1elhoWXZEM1luRVJkVjl0djY3Z2xtVU1Sd0VKMjk3aEJBbnZI?=
 =?utf-8?B?N3QyRCtYajNkTXpoajNUZ1RETUl4MVhTbW5sR3o2VU90OVBjazk4Unl3NTRO?=
 =?utf-8?B?cFI5YVhJU2xEZXhtaTNEU3psZmlzVjB0WStnNHlYQTBnK2ErUXB4RkhRVmpT?=
 =?utf-8?B?TWZMeERrQ3lidlpnbCtEbmhUbU5PWHR4K2dhTU41bjdscWIxNHMwV0cxanRk?=
 =?utf-8?B?cTQxUXhWem9oQnRyZ3FlWmlLQ01wUGgxMmpCby93VGVxc0pxSnViR0tSOURG?=
 =?utf-8?B?ckNlNzBLN21OMUtXZnN0NTZmUy9CeUVJeFNyd1VCQkFUQ1BwOE9GVWI5U2hZ?=
 =?utf-8?B?Mno4WjZ1WmJWSzQyMExJQXE5WFpuajRDbWY3YVdnd3R6Ui9iclAvc1R2bnd4?=
 =?utf-8?B?YStxV0pvMTFHYTVFcFdFa3dUL3VHVlFuZjQ3ZDBJb1dTRUkzWm5oWm1CTkFw?=
 =?utf-8?B?N0Y0NkJPb3d0UlJjaEI5UHczemlCRG0rck4vNjNPZ3FWWFY1ZEc2c2VOTkUz?=
 =?utf-8?B?RjZIZVpmbjZKT3p1MFV5R01EVEVRZUFuTWZXQ1pPTWIzYm4wMTR3bzc5RmE2?=
 =?utf-8?B?UXhRSzFUQjMwUnBKMjlOeGdUR01UZjRrWkhuNisxY1ZvMUZWcU5vQW9xdE5Z?=
 =?utf-8?B?c3lyUXkxL0FKRy9MVTRGQ1pkTndjWDdpUk13eTMrOHA0bG9TV2pENndBQVVJ?=
 =?utf-8?B?bHVZd0p3UXBXT1BCQ2pHWVdGbjFKOHhTWGExTEljWTVaYXdseGRjQ3hOOUxi?=
 =?utf-8?B?andIcFJSTDZzU0VsQTN5VXhCSW52V09PR1BGdXZVb0xIWDJIS2xSU1dWb0RX?=
 =?utf-8?B?Q0dDWFNqd285bVlDQUEvRzhlWUhVU3Q5YkhuREcvVUNhWUF5cVhYMjl0SGdY?=
 =?utf-8?B?QksrOGtBU0dSSGR1RmpTQ2JoeXZrUTE1UGsybysyU05jVVF5RmxHZnN4NzN4?=
 =?utf-8?B?aGdiV1JMckV3REYwd1BabkpaT2lxM0lweENCcXRldDUrb21aT3lmRjNkSkVo?=
 =?utf-8?B?Y0R5YkVJbGFqb2NPdEcyeGI3bnQ2N1doRXd3eVYrQjEzSGQ0Wjc5S09ZVlla?=
 =?utf-8?Q?LA5zIYl3IQKe3insPO5gs6YGiBl1pE=3D?=
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:IA3PR11MB9136.namprd11.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(366016)(376014)(1800799024)(38070700018); DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?UTNwbWxGd296WnZOa2RKSkpVMmxJeXgzWXEvUFJSTG5kaDBEOE9KaDF1WFd6?=
 =?utf-8?B?dm9ocTdGYXFUaHhkT1lwdGYvalRWaEN1Rms2S1ptTXdXSCtCVmpTREpnajRP?=
 =?utf-8?B?N3RjT1lMaU9FdXBCNkphSGpmVWQ5MnZtc0hhaGZqbTcyR2RpbzZvcE15WWVB?=
 =?utf-8?B?cUNqM3lId1ZVdkZiQU54WmcvNlhrZjY1S0srQXJ4Z2ZMbEFYc3hZRWRxY0hr?=
 =?utf-8?B?VjUxbDY1NDBzRTBvZTQyVHIrSW9EM2QzWUNVV1dteXFqQnNjRnpuNmJET0hL?=
 =?utf-8?B?UFJQdjh2c2tWMWYza09HYy9XZ2s1QUpNS3N1YllMZ2RDWUh0ak9xeFhJeHVB?=
 =?utf-8?B?ZnlxN0xLUWE5alc4ZTZKTlM2ZWhwdURNby9hejZpNEJtdXN4QWxmbjZqU3NU?=
 =?utf-8?B?L2Nnd0F0YnNFdE04SUhHc2x4TjZEc2U0NFgvd0RmQlBxcGMySmxCOVVzNVVm?=
 =?utf-8?B?OG0rdVdZMW1KYzV6UWx4bm9zN3NyVjI0a0NOZHRyKzZEVm5JMWp4d3lDZTNn?=
 =?utf-8?B?ejZHMW9ibVc1Z1hqb0toUUtQTXpQdXdQT3o2eVpiY21UbGZLNXNkZGI5ZDMw?=
 =?utf-8?B?MmdLcTNyYTBuN1ZjSnFjVG80QWZEZE1UR2ZISHBxQ1V5bnZ6bmtjZEJIRmU4?=
 =?utf-8?B?N0gxQVg4dWRzUTEvNkZzbWNzWjlKQVE1MmhZeFVRTnZkUTAzOTQ3QWV2T0pT?=
 =?utf-8?B?emJRYjA1UUh5MTNHNmxsQnh5MnJ5VlA1a3NwRXpFNy9CZEV0SHpuZzRObjVn?=
 =?utf-8?B?Lys1NEE2V1E0dEhIeE5QQSsweWdoZnhCTVhBKzRWVVlnNUJoRmhacHVhVUJn?=
 =?utf-8?B?Tm1RMDRnYjJJeDViSlN1YmpMT21YcWpXMzJnRU44ejlQQjBVdHFId3BSSHRq?=
 =?utf-8?B?UXJ3YUhUVFgrNHAzWWlnNGI5bDRzNkpIU3ZqeGNlQ2ZmN3lNWXpjUStnWmxY?=
 =?utf-8?B?Y1Z4ZlFGNUpmSFhtV2RFOTREVUVoaUhKV29KQjA1UzQ2MWZ1MTU4Z1Zyc0tI?=
 =?utf-8?B?TTlDK3ROeGJiZVJibnlIeVB3a0VvODN5eVJldFBrNmhxMWhleGpEUktHaDVL?=
 =?utf-8?B?MFdxb0NoUjFlUzhvNzI5VzYvQ040bnRmblRZRyt3Z0tGejBDOEhVODRwYlpX?=
 =?utf-8?B?TDRUM1BIencralc0cmZiSWNGamczWDkyRThtdmlFQU8vbk45R3FDeldiUFNN?=
 =?utf-8?B?aUpabUl0QUQ0L3NCZzVQbDFyMnVTTVg4K1RVV1hteVdRUDBLY0o5cVVTRnhE?=
 =?utf-8?B?ZFdGb0pEakxVbCt1TVd4YmVGL1h3bVFEcTFMaFVqamF2MVNBWisxdThwN3Fm?=
 =?utf-8?B?U1RlMElPT2JTN2hJZ2Z0a0Irb1p1c2d1SzJJK3JNOExDaFpwdTVIYU96eG1x?=
 =?utf-8?B?eCtIMFd1blhlWE9OYmtjMHRTcXpySnFjallVYlZ2NFp6UHpybVdhWXpMcE9l?=
 =?utf-8?B?Vmxjb1dheUhyNzgxL1hpblVJdlJxOFo4Nk5WNVo5VG91R3FvYTRBbkJWTE5w?=
 =?utf-8?B?dk9YV042QjlhSzhvbnhKa1JGcGhvd0s1aElkMUNFcmJKTVBYUVdCeEI1L2Jv?=
 =?utf-8?B?NzI5SGVJeG1SOHIvanljKzZnT0xIRHRjK25aQWZ6TUxjUzFtanJQNC8zNUpD?=
 =?utf-8?B?MHZ6eXcxU2xMZHpHbDRsOENZMVlBaWtNMzI5NGkyajBIbzZaU3RFQWVmUGRz?=
 =?utf-8?B?cXdvT1FoNGl6OWpQRnJtU2JvMXlnS2lxTjUrQWpoWEpDUjBIYjZEKzg4MFdQ?=
 =?utf-8?B?RHhhUUlLcnkxQXFwSEl0amVVOHlnS2xldTlycXBHNEIxSFFKU0RKSjB4b2lT?=
 =?utf-8?B?RTd3dHVNVzV2YURhMnU3b2JvS3ZPSVhxOGJzSHV3Ukxicml2amkrbnhOeFha?=
 =?utf-8?B?bEZyanlHbDM3MFN5akovQVZ3TEk2UzIvOVFmQzhqeUJyK2UwVCtLVHN4a0tt?=
 =?utf-8?B?c3lsZktvK0NxVjJrSkpGREExemtiOElyTXJwVmdzK0JBcHBhZHY3eVNZdkk3?=
 =?utf-8?B?WGx5MmFvSmQyZ2ozSVBUSFVIZkZTQUV1MUR6VFNTS3M1SHJEaG1yUmlja20z?=
 =?utf-8?B?TWZPazlnbnJPam9Qdnh6anhiRzJuK1psUy9VMEF0NWFzeC9OY2tEeU93bXlk?=
 =?utf-8?Q?1cErmOBNKkjadDaWiSG9e5th+?=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: IA3PR11MB9136.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: bf31eda7-07f0-4c0a-2d35-08ddafbdd3b0
X-MS-Exchange-CrossTenant-originalarrivaltime: 20 Jun 2025 05:46:39.1308 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: FOWcftai3DEz7n3wfb2Oklcts0mLobz3g+G0woAwWwcMIS8UwzdW9/keH2Ab5ea8JvPesZzxCkvvz5HH419l2qzc3pq4oDDkx9uW8ihRcjE=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY8PR11MB7268
X-OriginatorOrg: intel.com
Received-SPF: pass client-ip=198.175.65.18;
 envelope-from=zhenzhong.duan@intel.com; helo=mgamail.intel.com
X-Spam_score_int: -62
X-Spam_score: -6.3
X-Spam_bar: ------
X-Spam_report: (-6.3 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-1.897,
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

SGkgQ8OpZHJpYywNCg0KPi0tLS0tT3JpZ2luYWwgTWVzc2FnZS0tLS0tDQo+RnJvbTogQ8OpZHJp
YyBMZSBHb2F0ZXIgPGNsZ0ByZWRoYXQuY29tPg0KPlN1YmplY3Q6IFJlOiBbUEFUQ0ggVjUgMDAv
MzhdIExpdmUgdXBkYXRlOiB2ZmlvIGFuZCBpb21tdWZkDQo+DQo+Wmhlbnpob25nLCBFcmljLA0K
Pg0KPk9uIDYvMTIvMjUgMDk6MjMsIEPDqWRyaWMgTGUgR29hdGVyIHdyb3RlOg0KPj4gT24gNi8x
MS8yNSAxNjozOSwgU3RldmVuIFNpc3RhcmUgd3JvdGU6DQo+Pj4gT24gNi8xMS8yMDI1IDEwOjI1
IEFNLCBDw6lkcmljIExlIEdvYXRlciB3cm90ZToNCj4+Pj4gT24gNi8xMC8yNSAxOTozOSwgQ8Op
ZHJpYyBMZSBHb2F0ZXIgd3JvdGU6DQo+Pj4+Pj4gU3RldmUsDQo+Pj4+Pj4NCj4+Pj4+PiBGb3Ig
dGhlIG5leHQgdmZpbyBQUiwgSSBwbGFuIHRvIHRha2UgcGF0Y2hlcyAxLTE3IHdoZW4gcGF0Y2gg
MTAgaXMNCj4+Pj4+PiB1cGRhdGVkLiBUaGUgcmVzdCBpcyBmb3IgbGF0ZXIgaW4gdGhpcyBjeWNs
ZQ0KPj4+Pj4NCj4+Pj4+IEFwcGxpZWQgMS0xNyB0byB2ZmlvLW5leHQuIFdhaXRpbmcgZm9yIGFu
IEFjayBmcm9tIE1pY2hhZWwuDQo+Pj4+DQo+Pj4+IEkgYW0gcGxhbmluZyB0byBzZW5kIGEgUFIg
d2l0aCB0aGlzIGZpcnN0IHBhcnQgdG8gZ2V0IG1vcmUgdmlzaWJpbGl0eS4NCj4+Pj4gVGhlcmUg
aXMgYSBzbGlnaHQgcmlzayBvZiBtZXJnaW5nIHVzZWxlc3MgY2hhbmdlcyBzaW5jZSBDUFIgaXMg
bm90DQo+Pj4+IGZ1bGx5IHJldmlld2VkLiBNeSBvcHRpbWlzdGljIG5hdHVyZSB0ZWxscyBtZSBp
dCBzaG91bGQgcmVhY2ggUUVNVSAxMC4xDQo+Pj4+IGFuZCB3ZSBoYXZlIHRpbWUgdG8gYWRqdXN0
Lg0KPj4+Pg0KPj4+PiBQbGVhc2UgZmVlbCBmcmVlIHRvIGludGVydmVuZSBpZiB5b3UgcHJlZmVy
IHRoZSBzZXJpZXMgdG8gYmUgZnVsbHkNCj4+Pj4gYXBwcm92ZWQvcmV2aWV3ZWQgYmVmb3JlIG1l
cmdpbmcuDQo+Pj4NCj4+PiBBIHBhcnRpYWwgbWVyZ2UgaXMgZmluZSB3aXRoIG1lLg0KPj4NCj4+
DQo+PiBOb3cgbWVyZ2VkLiBJIGFtIHdhaXRpbmcgZm9yIHNvbWUgZmVlZGJhY2sgb24gdGhlIElP
TU1VRkQgcGFydC4NCj4NCj5Xb3VsZCB5b3UgaGF2ZSBzb21lIHRpbWUgaW4gSnVuZSB0byB0YWtl
IGEgbG9vayA/DQoNClNvcnJ5LCBzaG9ydCBvZiBiYW5kd2lkdGggdGhpcyB3ZWVrLCBJJ2xsIHJl
dmlldyBpdCBuZXh0IHdlZWsuDQoNClRoYW5rcw0KWmhlbnpob25nDQo=

