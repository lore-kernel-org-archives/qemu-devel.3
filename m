Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 81735CCD187
	for <qemu-devel@archiver.kernel.org>; Thu,  9 Oct 2025 10:13:35 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1v6nbw-0005YK-Bj; Thu, 09 Oct 2025 06:11:00 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <zhenzhong.duan@intel.com>)
 id 1v6nbu-0005YB-Qs
 for qemu-devel@nongnu.org; Thu, 09 Oct 2025 06:10:58 -0400
Received: from mgamail.intel.com ([198.175.65.12])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <zhenzhong.duan@intel.com>)
 id 1v6nbq-00078Z-Jb
 for qemu-devel@nongnu.org; Thu, 09 Oct 2025 06:10:58 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1760004655; x=1791540655;
 h=from:to:cc:subject:date:message-id:references:
 in-reply-to:content-transfer-encoding:mime-version;
 bh=ZO6nE7b1N3tceLo2uz01EA1vDkIdcTu58PuvmP1onug=;
 b=J9eJrHEXpgF8hODWPqNRVNFLjpZL3rlXhsat7G9TR1gCvpjMlKEum3dO
 aHSVRS3kJiqRYGR6dg6YTTlK1KJ8WaRECtXjjMzHSlWGSXCQ15cndZ4lF
 y0lhZq4CLhUjl5vVsxin48V8Tw497o1r6d3TCSXNoyaJ2dso/N5uE7PIh
 aa/FG0pcVOaA+K6bO9C6ZlD0DpSwMSZk0T83rOL1x7jXrwPWcHarEykCw
 oAb+w29d0PlSrnqHrthN4DF0J5O3B5Sd1K7r270eAZqRpfBCfAEWceyCK
 Y60ze2F3RQ7XwbnP0s3Hqywbgy/J0481FQ8ahxcy8UJElcJDCa91h/MkO w==;
X-CSE-ConnectionGUID: cGZNMiOxQ96CG6UEZhpzaw==
X-CSE-MsgGUID: y95zWrpIQfKg/vO4LrhT2w==
X-IronPort-AV: E=McAfee;i="6800,10657,11576"; a="73638046"
X-IronPort-AV: E=Sophos;i="6.19,215,1754982000"; d="scan'208";a="73638046"
Received: from orviesa004.jf.intel.com ([10.64.159.144])
 by orvoesa104.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 09 Oct 2025 03:10:45 -0700
X-CSE-ConnectionGUID: pa1ynLqFS0qX2Xug1HNmQw==
X-CSE-MsgGUID: 6z8EtiiETKOJHrh545SzCQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.19,215,1754982000"; d="scan'208";a="184943971"
Received: from orsmsx903.amr.corp.intel.com ([10.22.229.25])
 by orviesa004.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 09 Oct 2025 03:10:44 -0700
Received: from ORSMSX902.amr.corp.intel.com (10.22.229.24) by
 ORSMSX903.amr.corp.intel.com (10.22.229.25) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.27; Thu, 9 Oct 2025 03:10:44 -0700
Received: from ORSEDG903.ED.cps.intel.com (10.7.248.13) by
 ORSMSX902.amr.corp.intel.com (10.22.229.24) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.27 via Frontend Transport; Thu, 9 Oct 2025 03:10:44 -0700
Received: from CY7PR03CU001.outbound.protection.outlook.com (40.93.198.10) by
 edgegateway.intel.com (134.134.137.113) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.27; Thu, 9 Oct 2025 03:10:44 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=qvfd+hbFaLh0P4yUcOAYUq9qHwzW2s3Rw78ed4yE3ZXsXgMTSWjNblGZLKUhv81zQNa9B2z0Gzy0QDFAApwphvFGCzpbszdp5T3Ogp+qSUHhoRoJvLTt06IVmeHx/tu9mJQGk06qnELZtE/ynRV97ajCDXK9N1fXBs8fhjU6ZXRyMpiSz70JMm3+m7RQSiVL6Wuy/JqlHeQp6zV/zRmlWN8CU+3mc8Ed3IebuAcD89IPGbjwTn7lw5o5eG6k4TPegNoz1FRZNn+8FLu4TsfGGW84cP14PhRO+3iuPpP5C/h1EhQ/RJ+n944LPs4du95bJv4x98jWi15CMhPMj3Vq7A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=ZO6nE7b1N3tceLo2uz01EA1vDkIdcTu58PuvmP1onug=;
 b=K0XlfWwzwDZXv1LYCUfxHEIXzKQvkVtRogdBR5PZ4f1vga1BY3bXjZa96WNjtPvraFSsHTbtzpwAGIahKp9UK+Y06RlmmZENnd5LCk6h8SwpFIx3XH96Tv2qHlkwGDI/3hnxKwUYzwFN77AB/GnKeQ7MYItDF+hZ7ahSk2laHY1iyJtKyu4Nh2cveFfPkEV5YVT4i8EHGZ/TBGQbDJ7F2Ernayn3QeLDhqpwJQYdNwz4Y35vsObFAaZcGwKOBCezjacZeitt4y097xu0pn4tnpdVCSHQeVv3YQgdrQEtJqbbYiOSbPi9O8EpUSc1aSUiN6XJP8r6D6kVHnGcVyzarg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Received: from IA3PR11MB9136.namprd11.prod.outlook.com (2603:10b6:208:574::12)
 by DS0PR11MB8071.namprd11.prod.outlook.com (2603:10b6:8:12e::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9203.9; Thu, 9 Oct
 2025 10:10:42 +0000
Received: from IA3PR11MB9136.namprd11.prod.outlook.com
 ([fe80::604b:77a4:b1be:3f13]) by IA3PR11MB9136.namprd11.prod.outlook.com
 ([fe80::604b:77a4:b1be:3f13%4]) with mapi id 15.20.9115.020; Thu, 9 Oct 2025
 10:10:42 +0000
From: "Duan, Zhenzhong" <zhenzhong.duan@intel.com>
To: "eric.auger@redhat.com" <eric.auger@redhat.com>, "qemu-devel@nongnu.org"
 <qemu-devel@nongnu.org>
CC: "alex.williamson@redhat.com" <alex.williamson@redhat.com>,
 "clg@redhat.com" <clg@redhat.com>, "mst@redhat.com" <mst@redhat.com>,
 "jasowang@redhat.com" <jasowang@redhat.com>, "peterx@redhat.com"
 <peterx@redhat.com>, "ddutile@redhat.com" <ddutile@redhat.com>,
 "jgg@nvidia.com" <jgg@nvidia.com>, "nicolinc@nvidia.com"
 <nicolinc@nvidia.com>, "skolothumtho@nvidia.com" <skolothumtho@nvidia.com>,
 "joao.m.martins@oracle.com" <joao.m.martins@oracle.com>,
 "clement.mathieu--drif@eviden.com" <clement.mathieu--drif@eviden.com>, "Tian, 
 Kevin" <kevin.tian@intel.com>, "Liu, Yi L" <yi.l.liu@intel.com>, "Peng, Chao
 P" <chao.p.peng@intel.com>
Subject: RE: [PATCH v6 02/22] intel_iommu: Delete RPS capability related
 supporting code
Thread-Topic: [PATCH v6 02/22] intel_iommu: Delete RPS capability related
 supporting code
Thread-Index: AQHcKHp0iwytAPd7GEaLPCrEH2yhnbSr0SeAgAKGGXA=
Date: Thu, 9 Oct 2025 10:10:42 +0000
Message-ID: <IA3PR11MB91368FAFAEE280E24B5AD33892EEA@IA3PR11MB9136.namprd11.prod.outlook.com>
References: <20250918085803.796942-1-zhenzhong.duan@intel.com>
 <20250918085803.796942-3-zhenzhong.duan@intel.com>
 <2a12ee15-6314-4c03-ae2b-fb0e0809c924@redhat.com>
In-Reply-To: <2a12ee15-6314-4c03-ae2b-fb0e0809c924@redhat.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: IA3PR11MB9136:EE_|DS0PR11MB8071:EE_
x-ms-office365-filtering-correlation-id: a2493b1d-60e0-4d40-f77d-08de071c1ac3
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
 ARA:13230040|376014|7416014|366016|1800799024|38070700021; 
x-microsoft-antispam-message-info: =?utf-8?B?NUREdll6alJTczZFUVN5VHo5WCtEdndickhBY2Y2bUU1UUgrUUs1cUJMWEh0?=
 =?utf-8?B?R2p1NS9abjdCSHJmaThzWnhTN2pWaHFYdmpCTW0xYm9rMjZPMXZNNHhyVFlO?=
 =?utf-8?B?OUI5N1h3WmZwNDN2OGpJTnQvbUFkWXVkMG1XUWE0emNiQWNaSTg5YklwZHh6?=
 =?utf-8?B?VnlYc1BoSWRvaFAwU2Y4VW1PL21ZbXlaOWdBZVlWcmp0NzFxdVVDeENzdGVM?=
 =?utf-8?B?N3kxL0JyMlNUMWFFcHo0MVRyYTNxWlFFQW5EeFozZ1NvQXlIcTIwRVBHdmtN?=
 =?utf-8?B?Ky83MlZ6L0ltWTg2NnE2dmlSQ1RlTWNnMVNQRm5JNWgwUExmN1E3K05aUXN5?=
 =?utf-8?B?VGNYbk9JcXI5SmtUWXBBTXdNa084Zk1lbWNuTTBFNzBpbzhFdEYrbnI4dUFk?=
 =?utf-8?B?VE1FTjVYczN6UVhhRFVleWVaVERXMS83ajR4VVpSWkE3M3JidS8yN0NOZS9N?=
 =?utf-8?B?dFFYR215bExIdWlpQi9JUzdKNkhRRSt4ZlhuNkhPWUd6K2xYSkorZWVQdUpE?=
 =?utf-8?B?bENQRjViaEVQejRHSmlBc2FueXdwWmhkbW5adURQTzJKTnBZSFNBYXNyR1JO?=
 =?utf-8?B?NStKbG40b1pWbU4zSzFIS0psa0tIejFtSUN2Wk9yOEkyYmFONTdOVGVYRC9w?=
 =?utf-8?B?OHN6Yk1vR2lCdlFOcElWV0hiVVE1TW5MTGFVaTRxT2ZaTTJFVGV0UnRtQUJh?=
 =?utf-8?B?dFNDWE9RUGFXY0VxWWNneU90RVpTb2hTakdleHVCSG5kRVkzMEJZcjYxM24v?=
 =?utf-8?B?STRaVzdiRFJvL1NQN0hyUCtlMVUvUGFDYitWdGxEYS9rbVBobElIWmZYZ3BL?=
 =?utf-8?B?anNlcmhJQ3VGajhZK3BXQUNCYnd0cVZJRVBuOXFaaW4zZGJmM0JXWkhVY1BC?=
 =?utf-8?B?R3NGd0hoakdiTUFtaXc4a1lPV3dra2pDNkQ3VVlqV25JZUpzZWgrWE16VmZy?=
 =?utf-8?B?TG8xZmFRNk5SYkRyZ1BWSXdaOGEvelpybnJGS2hpbnhkU3hTMXRXWndWbzgw?=
 =?utf-8?B?cFhFRG5OUlMzaVBCTkJ2aXhQaUsvNlBwKzhCc0UzQUN2dkhCenBsb3JRdkF2?=
 =?utf-8?B?ZlZLQ2xlK2dDNCtrc1ljbFZtMWpRZ1g5a3ovMWFwWjZCMm4xVmQ3aGxSYnRB?=
 =?utf-8?B?QWF6cVlVMUZyY1dycmhNNkoxUkd3Y3hRaVBiT2JHRGxBc1lvSm5HUU1BaUZp?=
 =?utf-8?B?K1l3VlRZS21GaTN2YmNzbjdtVUNKcTJWdzE1OFhQakZyZmtXQ3VQbXFwRkh3?=
 =?utf-8?B?dXBzbGkvRXEvWEozbk8rN0hhTXd4djlpcitOWnpFbUxzelg4Q0tCSkk5bi9W?=
 =?utf-8?B?UzQ2LzhteVB1c1dpdWdva0szbkNPVDVpZDZwbit5dHRVcmdDL1lLWE9XMGVu?=
 =?utf-8?B?dmZ2djNUci9zaFFPdk0wYzRGMUVIUTY1ZGFjWXREdmRHRTJrVU9jTGFyQXBQ?=
 =?utf-8?B?ck9SWE1JR3cyNWpEYytPVkNkblhrNmk0Y2dUbFdTQzNjaWF1NXRwdm4xTGIr?=
 =?utf-8?B?TGZUaHJXa3FCU080WjJKYUNOWW5WTmo2RWxJYmpRdG9vajFWVm01UXJDSmZQ?=
 =?utf-8?B?TTgySVNpS0RMOWRkODdnVjZ3Qzh6SzNIaUJzUU5EOFdJSDBUa2I5dWowK2hF?=
 =?utf-8?B?dTRpdElWV3JFb3k0NkJjelhFOGVsdHlXYVM3OHVpNXc5WTVPS3doZ0R6ay9x?=
 =?utf-8?B?UUFKc0l3Y1NsL1o1QjNVK3hncmNSRXZEanBDRnZEc0U4cEFlN2FHdmhuNG9o?=
 =?utf-8?B?YmZTVWJtT2Jrdm5keG56R1FBNG9CdGVGbSs5RVRPRnBaaFEzeGRiQWV4NGpL?=
 =?utf-8?B?ZXRHV3hTeEdFc0Vib1BjVjVIVjduNUhybjExS0x4OTZEV0Y3K3Uvekxra1E5?=
 =?utf-8?B?OHA3ZURFaXZQdEpuRGpkOG5uY1lROWJmUnUzcEhiYkQ0Wk1hazVPamVuVi9F?=
 =?utf-8?B?NjZZTW50S3NENjRhbVpWWmFlaXBTcStmelp6N2VpMXpWYktaUERmdTdDUVRD?=
 =?utf-8?B?dGJTaDE1cUZDVHFYV3p1SjVQaHhNekZiVjdmZjlHNW1DMHp2Skx0NEhiQ3Bz?=
 =?utf-8?Q?TWGPdZ?=
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:IA3PR11MB9136.namprd11.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(376014)(7416014)(366016)(1800799024)(38070700021); DIR:OUT;
 SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?aGdCdCtMTzJQRmx1ZHNQM0tzM3krSmtUbjB3Y2lma3gxM3dyQnZzT3B4NTdv?=
 =?utf-8?B?aFFZSDQyQU1oanA5YkJ0MStzY2NmdnFmVlk2MWt2OVR5eitwZG5mNk5VRFdv?=
 =?utf-8?B?dVRFSktNd3Q2aFUxU3NsWGo3V1hiQXd6WHNIYnhrdTVWVjhpeHd4ZURwd0VK?=
 =?utf-8?B?ZlhPczlzZDk5Kzc3MkQ3OEg5WlA1dkJIMlEyandTQ2U1TFh3N0xqYmZ2UVYv?=
 =?utf-8?B?bWJFTG51Z1NheWtzeTN5QmZWbi9DM2J2ZXgyYml1UlI5UWwwQ2dYcjc2dWRL?=
 =?utf-8?B?dDBlbmVUempVT2xzeENoZEdnRm1SdTloRWlxSFA1Sm1ZQzNyTzJ6RVIzRFkz?=
 =?utf-8?B?cnpYV2tUS0JzZFNQeURqemFNSW1PK21NSXUydTlPYzJrRklHOFpGK3ZZZU5K?=
 =?utf-8?B?cjA4aURhR05ZMG1qQi9ZQkxJV01zRlhtUVV3ZFZycjhSQmN5MGJwU2hDUU5V?=
 =?utf-8?B?UEhxZDVmN3U4RlpmWW5aaFdMQjB1WlAwbHJacDI1OVltWEorbjR5YVpYa0RG?=
 =?utf-8?B?MitZbEZYbUE0VXd1MWR4UjNyUlFJQ0NZYmVFalk4Q2lrTGw2TjlHSkkrNzVl?=
 =?utf-8?B?dFV5M0c4cTZxdzIxckd2Q3NwUUM5KzY4ekkrbjBRd3haTWY2Q0wySTE5Q2lk?=
 =?utf-8?B?Mnhnd05DTG5VcENOaU40dWRxK1V1UkZwb0hUdzRIQ0h3dWhtVnRpUW91ZU9v?=
 =?utf-8?B?UURzZ29TUDZCdE5na1IyemdINzAzZit0U0NoWituZ1g3dEV6T2ZSdDVtVDVp?=
 =?utf-8?B?M3ZFMnZta0RvanhLV1FZM1JQdGh3YjhQZmllaWlmdU9haWlLazZoaG5HaHVp?=
 =?utf-8?B?TEw2TXphRFd1cnd3TWgydVRrbXVWRDU0bjZVU3F3TWFlb2NzSDhBeGkraU1i?=
 =?utf-8?B?SncwTUpoaGZXVG1Xb3MxV3JLTUZlZDZCNmhiMnNucDh5dWdtc3IrL243NTUw?=
 =?utf-8?B?MC9RVCtDSUJMYnRHS0NUKytjNmM0ZEpBU2k2NDVndjMyUXJJODdaOGUvQlBR?=
 =?utf-8?B?OVlXSnNwZTkxa2RWS1pzQ1liTzd2Q3ZjN2hGWVBEUHFzUzZWOTRpNGsvU3FM?=
 =?utf-8?B?aFlGQWYxQ1A0VmllZStYR0NtZ0NPNlhqZlJxT0RVT1h0RlVXWlprRDNyaUhw?=
 =?utf-8?B?RkF0dlZscW9CVUUya2cwempibWdRUEo0OUZOWEozcUdveHVhT01pT3F3VmtY?=
 =?utf-8?B?eEZac2F4Z2ljTFFjZG80SUJZODBISUhhYkErYnpZL2h5VjFyYVk3Um5VMjJX?=
 =?utf-8?B?NDZ2TzdWSzB5a0NlejlMU3VLcHh4LzFJQ3pFSk80QnNMUmpxUm5za04xM2ZB?=
 =?utf-8?B?TDRFUjU1bmhhaWlza0pMS28zR0wxUVdwMHpqbXNueTBTYk9sSDVqTDhsN3dD?=
 =?utf-8?B?Ti8zV2NNTmVQSGg1S3dDbFVHUjJQVnhQMFdRcTg5RStwQko2bmZwZkFiRTl5?=
 =?utf-8?B?ekN5WmRPN1grU2cwWWFkdGlDUUhqZlNFM2RIQXhQb1k5b0t3SUE2UjFHVy9T?=
 =?utf-8?B?RzI2Vjc3Y1FtU3NpUjdUNlhWT3VReFp2MWlFRlVQdEI1N3dNZUx5YzI4VU9T?=
 =?utf-8?B?UTZCVlUvam9NSHlEdWsyR25BaUQ1cGZXVzErcVVTeEh5ZjVNc1kzazU3UHBz?=
 =?utf-8?B?bUpaMVJuQ25Xa0NoWEkyZ1pXaUs3b1h4cUMvOG1oZVdDb015RHlYMnl0ZEZ2?=
 =?utf-8?B?ZlpaTk54K3hyOEhSdXVzcC9maVhtR0J4SDFndkZXZmh1cXhPejh3cFdqVjc5?=
 =?utf-8?B?cTN0VWhHeW5EcHc1WUNCL2hVMnB1ZWttVE1EcVovQXF4djFpYVZLaEVWcWIr?=
 =?utf-8?B?TU1OSTFIZmpTeEtqcUFZMlpKYnhBRGx6NXppa2lNN0tsTU9NMGNQQTdmS0xo?=
 =?utf-8?B?dDZXQXYzMnpWQkMzUnA3bEliZVU2VUk4ZFBRdmpjWmFqZnY3N0ZNcXRuNyt3?=
 =?utf-8?B?UDVkOTRHVlNCZXg0Q2laVGMzclRnM2NzdlU0cjFuK2lWUlNlMytsYStPY1ls?=
 =?utf-8?B?UmpyRHdUQVVNRFlDMndxelJTSG9LaWtGWk1tczlSY1ZpeVBhZVFHemNUQ3I3?=
 =?utf-8?B?V3JQTndXMysvVDVlMGxnVytYRjZXS0lFV2hSUHZFdGRFa3NMeGY5RHBTei9x?=
 =?utf-8?Q?5xp5EtSJuIbJ4qoZbLiNRkLNz?=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: IA3PR11MB9136.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: a2493b1d-60e0-4d40-f77d-08de071c1ac3
X-MS-Exchange-CrossTenant-originalarrivaltime: 09 Oct 2025 10:10:42.2259 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: eKa+vrTAX/ixVwKzzEwxgb/QUhZN/ax3AhjCKFXN0dKEqRTBn4UPfgb/XxNG6TrdBg0CL7Qd5gBynwF0355Zf8irxbi3v8MZfd7/UkOd8Ao=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS0PR11MB8071
X-OriginatorOrg: intel.com
Received-SPF: pass client-ip=198.175.65.12;
 envelope-from=zhenzhong.duan@intel.com; helo=mgamail.intel.com
X-Spam_score_int: -47
X-Spam_score: -4.8
X-Spam_bar: ----
X-Spam_report: (-4.8 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.442,
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
ciA8ZXJpYy5hdWdlckByZWRoYXQuY29tPg0KPlN1YmplY3Q6IFJlOiBbUEFUQ0ggdjYgMDIvMjJd
IGludGVsX2lvbW11OiBEZWxldGUgUlBTIGNhcGFiaWxpdHkgcmVsYXRlZA0KPnN1cHBvcnRpbmcg
Y29kZQ0KPg0KPkhpIFpoZW56aG9uZywNCj4NCj5PbiA5LzE4LzI1IDEwOjU3IEFNLCBaaGVuemhv
bmcgRHVhbiB3cm90ZToNCj4+IFJJRC1QQVNJRCBTdXBwb3J0KFJQUykgaXMgbm90IHNldCBpbiB2
SU9NTVUgRUNBUCByZWdpc3RlciwgdGhlIHN1cHBvcnRpbmcNCj4+IGNvZGUgaXMgdGhlcmUgYnV0
IG5ldmVyIHRha2UgZWZmZWN0Lg0KPnRha2VzDQoNCldpbGwgZG8NCg0KPj4NCj4+IE1lYW53aGls
ZSwgYWNjb3JkaW5nIHRvIFZURCBzcGVjIHNlY3Rpb24gMy40LjM6DQo+PiAiSW1wbGVtZW50YXRp
b25zIG5vdCBzdXBwb3J0aW5nIFJJRF9QQVNJRCBjYXBhYmlsaXR5IChFQ0FQX1JFRy5SUFMgaXMN
Cj4wYiksDQo+PiB1c2UgYSBQQVNJRCB2YWx1ZSBvZiAwIHRvIHBlcmZvcm0gYWRkcmVzcyB0cmFu
c2xhdGlvbiBmb3IgcmVxdWVzdHMgd2l0aG91dA0KPj4gUEFTSUQuIg0KPj4NCj4+IFdlIHNob3Vs
ZCBkZWxldGUgdGhlIHN1cHBvcnRpbmcgY29kZSB3aGljaCBmZXRjaGVzIFJJRF9QQVNJRCBmaWVs
ZCBmcm9tDQo+PiBzY2FsYWJsZSBjb250ZXh0IGVudHJ5IGFuZCB1c2UgMCBhcyBSSURfUEFTSUQg
ZGlyZWN0bHksIGJlY2F1c2UgUklEX1BBU0lEDQo+PiBmaWVsZCBpcyBpZ25vcmVkIGlmIG5vIFJQ
UyBzdXBwb3J0IGFjY29yZGluZyB0byBzcGVjLg0KPj4NCj4+IFRoaXMgc2ltcGxpZnkgdGhlIGNv
ZGUgYW5kIGRvZXNuJ3QgYnJpbmcgYW55IHBlbmFsdHkuDQo+c2ltcGxpZmllcw0KDQpXaWxsIGRv
DQoNCj4+DQo+PiBPcHBvcnR1bmlzdGljYWxseSwgcy9yaWQycGFzaWQvcmlkX3Bhc2lkIGFuZCBz
L1JJRDJQQVNJRC9SSURfUEFTSUQgYXMNCj4+IFZURCBzcGVjIHVzZXMgUklEX1BBU0lEIHRlcm1p
bm9sb2d5Lg0KPj4NCj4+IFN1Z2dlc3RlZC1ieTogWWkgTGl1IDx5aS5sLmxpdUBpbnRlbC5jb20+
DQo+PiBTaWduZWQtb2ZmLWJ5OiBaaGVuemhvbmcgRHVhbiA8emhlbnpob25nLmR1YW5AaW50ZWwu
Y29tPg0KPj4gLS0tDQo+PiAgaHcvaTM4Ni9pbnRlbF9pb21tdV9pbnRlcm5hbC5oIHwgIDEgLQ0K
Pj4gIGh3L2kzODYvaW50ZWxfaW9tbXUuYyAgICAgICAgICB8IDQ5ICsrKysrKysrKysrKystLS0t
LS0tLS0tLS0tLS0tLS0tLS0NCj4+ICAyIGZpbGVzIGNoYW5nZWQsIDE5IGluc2VydGlvbnMoKyks
IDMxIGRlbGV0aW9ucygtKQ0KPj4NCj4+IGRpZmYgLS1naXQgYS9ody9pMzg2L2ludGVsX2lvbW11
X2ludGVybmFsLmgNCj5iL2h3L2kzODYvaW50ZWxfaW9tbXVfaW50ZXJuYWwuaA0KPj4gaW5kZXgg
MzYwZTkzNzk4OS4uNmFiZTc2NTU2YSAxMDA2NDQNCj4+IC0tLSBhL2h3L2kzODYvaW50ZWxfaW9t
bXVfaW50ZXJuYWwuaA0KPj4gKysrIGIvaHcvaTM4Ni9pbnRlbF9pb21tdV9pbnRlcm5hbC5oDQo+
PiBAQCAtNTQ3LDcgKzU0Nyw2IEBAIHR5cGVkZWYgc3RydWN0IFZURFJvb3RFbnRyeSBWVERSb290
RW50cnk7DQo+PiAgI2RlZmluZSBWVERfQ1RYX0VOVFJZX0xFR0FDWV9TSVpFICAgICAxNg0KPj4g
ICNkZWZpbmUgVlREX0NUWF9FTlRSWV9TQ0FMQUJMRV9TSVpFICAgMzINCj4+DQo+PiAtI2RlZmlu
ZSBWVERfU01fQ09OVEVYVF9FTlRSWV9SSUQyUEFTSURfTUFTSyAweGZmZmZmDQo+PiAgI2RlZmlu
ZSBWVERfU01fQ09OVEVYVF9FTlRSWV9SU1ZEX1ZBTDAoYXcpICAoMHgxZTBVTEwgfA0KPn5WVERf
SEFXX01BU0soYXcpKQ0KPj4gICNkZWZpbmUgVlREX1NNX0NPTlRFWFRfRU5UUllfUlNWRF9WQUwx
DQo+MHhmZmZmZmZmZmZmZTAwMDAwVUxMDQo+Pg0KPj4gZGlmZiAtLWdpdCBhL2h3L2kzODYvaW50
ZWxfaW9tbXUuYyBiL2h3L2kzODYvaW50ZWxfaW9tbXUuYw0KPj4gaW5kZXggNzFiNzBiNzk1ZC4u
Yjk3NmIyNTFiYyAxMDA2NDQNCj4+IC0tLSBhL2h3L2kzODYvaW50ZWxfaW9tbXUuYw0KPj4gKysr
IGIvaHcvaTM4Ni9pbnRlbF9pb21tdS5jDQo+PiBAQCAtNDEsOCArNDEsNyBAQA0KPj4gICNpbmNs
dWRlICJ0cmFjZS5oIg0KPj4NCj4+ICAvKiBjb250ZXh0IGVudHJ5IG9wZXJhdGlvbnMgKi8NCj4+
IC0jZGVmaW5lIFZURF9DRV9HRVRfUklEMlBBU0lEKGNlKSBcDQo+PiAtICAgICgoY2UpLT52YWxb
MV0gJiBWVERfU01fQ09OVEVYVF9FTlRSWV9SSUQyUEFTSURfTUFTSykNCj4+ICsjZGVmaW5lIFJJ
RF9QQVNJRCAgICAwDQo+SSB3b3VsZCBjYWxsIHRoYXQgUklEX1BBU0lEXzAgdG8gbWFrZSBpdCBt
b3JlIGV4cGxpY2l0IGluIHRoZSBjb2RlDQo+b3IgZXZlbiBpdCBpcyBhIFBBU0lEIHRvIFBBU0lE
XzAgd291bGQgZG8gdGhlIGpvYiB0b28uDQoNCk9LLCB3aWxsIHVzZSBQQVNJRF8wDQoNCj4+ICAj
ZGVmaW5lIFZURF9DRV9HRVRfUEFTSURfRElSX1RBQkxFKGNlKSBcDQo+PiAgICAgICgoY2UpLT52
YWxbMF0gJiBWVERfUEFTSURfRElSX0JBU0VfQUREUl9NQVNLKQ0KPj4NCj4+IEBAIC05NTEsNyAr
OTUwLDcgQEAgc3RhdGljIGludCB2dGRfY2VfZ2V0X3Bhc2lkX2VudHJ5KEludGVsSU9NTVVTdGF0
ZQ0KPipzLCBWVERDb250ZXh0RW50cnkgKmNlLA0KPj4gICAgICBpbnQgcmV0ID0gMDsNCj4+DQo+
PiAgICAgIGlmIChwYXNpZCA9PSBQQ0lfTk9fUEFTSUQpIHsNCj4+IC0gICAgICAgIHBhc2lkID0g
VlREX0NFX0dFVF9SSUQyUEFTSUQoY2UpOw0KPj4gKyAgICAgICAgcGFzaWQgPSBSSURfUEFTSUQ7
DQo+PiAgICAgIH0NCj4+ICAgICAgcGFzaWRfZGlyX2Jhc2UgPSBWVERfQ0VfR0VUX1BBU0lEX0RJ
Ul9UQUJMRShjZSk7DQo+PiAgICAgIHJldCA9IHZ0ZF9nZXRfcGVfZnJvbV9wYXNpZF90YWJsZShz
LCBwYXNpZF9kaXJfYmFzZSwgcGFzaWQsIHBlKTsNCj4+IEBAIC05NzAsNyArOTY5LDcgQEAgc3Rh
dGljIGludCB2dGRfY2VfZ2V0X3Bhc2lkX2ZwZChJbnRlbElPTU1VU3RhdGUNCj4qcywNCj4+ICAg
ICAgVlREUEFTSURFbnRyeSBwZTsNCj4+DQo+PiAgICAgIGlmIChwYXNpZCA9PSBQQ0lfTk9fUEFT
SUQpIHsNCj4+IC0gICAgICAgIHBhc2lkID0gVlREX0NFX0dFVF9SSUQyUEFTSUQoY2UpOw0KPj4g
KyAgICAgICAgcGFzaWQgPSBSSURfUEFTSUQ7DQo+PiAgICAgIH0NCj4+ICAgICAgcGFzaWRfZGly
X2Jhc2UgPSBWVERfQ0VfR0VUX1BBU0lEX0RJUl9UQUJMRShjZSk7DQo+Pg0KPj4gQEAgLTE1MTAs
MTUgKzE1MDksMTQgQEAgc3RhdGljIGlubGluZSBpbnQNCj52dGRfY29udGV4dF9lbnRyeV9yc3Zk
X2JpdHNfY2hlY2soSW50ZWxJT01NVVN0YXRlICpzLA0KPj4gICAgICByZXR1cm4gMDsNCj4+ICB9
DQo+Pg0KPj4gLXN0YXRpYyBpbnQgdnRkX2NlX3JpZDJwYXNpZF9jaGVjayhJbnRlbElPTU1VU3Rh
dGUgKnMsDQo+PiArc3RhdGljIGludCB2dGRfY2VfcmlkX3Bhc2lkX2NoZWNrKEludGVsSU9NTVVT
dGF0ZSAqcywNCj4+ICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgVlREQ29udGV4
dEVudHJ5ICpjZSkNCj4+ICB7DQo+PiAgICAgIFZURFBBU0lERW50cnkgcGU7DQo+Pg0KPj4gICAg
ICAvKg0KPj4gICAgICAgKiBNYWtlIHN1cmUgaW4gU2NhbGFibGUgTW9kZSwgYSBwcmVzZW50IGNv
bnRleHQgZW50cnkNCj4+IC0gICAgICogaGFzIHZhbGlkIHJpZDJwYXNpZCBzZXR0aW5nLCB3aGlj
aCBpbmNsdWRlcyB2YWxpZA0KPj4gLSAgICAgKiByaWQycGFzaWQgZmllbGQgYW5kIGNvcnJlc3Bv
bmRpbmcgcGFzaWQgZW50cnkgc2V0dGluZw0KPj4gKyAgICAgKiBoYXMgdmFsaWQgcGFzaWQgZW50
cnkgc2V0dGluZyBhdCBSSURfUEFTSUQoMCkuDQo+cy9hdCBSSURfUEFTSUQoMCkgL2ZvciBQQVNJ
RF8wPw0KDQpTdXJlDQoNCj4+ICAgICAgICovDQo+PiAgICAgIHJldHVybiB2dGRfY2VfZ2V0X3Bh
c2lkX2VudHJ5KHMsIGNlLCAmcGUsIFBDSV9OT19QQVNJRCk7DQo+PiAgfQ0KPj4gQEAgLTE1ODEs
MTIgKzE1NzksMTEgQEAgc3RhdGljIGludA0KPnZ0ZF9kZXZfdG9fY29udGV4dF9lbnRyeShJbnRl
bElPTU1VU3RhdGUgKnMsIHVpbnQ4X3QgYnVzX251bSwNCj4+ICAgICAgICAgIH0NCj4+ICAgICAg
fSBlbHNlIHsNCj4+ICAgICAgICAgIC8qDQo+PiAtICAgICAgICAgKiBDaGVjayBpZiB0aGUgcHJv
Z3JhbW1pbmcgb2YgY29udGV4dC1lbnRyeS5yaWQycGFzaWQNCj4+IC0gICAgICAgICAqIGFuZCBj
b3JyZXNwb25kaW5nIHBhc2lkIHNldHRpbmcgaXMgdmFsaWQsIGFuZCB0aHVzDQo+PiAtICAgICAg
ICAgKiBhdm9pZHMgdG8gY2hlY2sgcGFzaWQgZW50cnkgZmV0Y2hpbmcgcmVzdWx0IGluIGZ1dHVy
ZQ0KPj4gLSAgICAgICAgICogaGVscGVyIGZ1bmN0aW9uIGNhbGxpbmcuDQo+PiArICAgICAgICAg
KiBDaGVjayBpZiB0aGUgcHJvZ3JhbW1pbmcgb2YgcGFzaWQgc2V0dGluZyBhdCBSSURfUEFTSUQo
MCkNCj5vZiBwYXNpZCAwPw0KDQpPSw0KDQo+PiArICAgICAgICAgKiBpcyB2YWxpZCwgYW5kIHRo
dXMgYXZvaWRzIHRvIGNoZWNrIHBhc2lkIGVudHJ5IGZldGNoaW5nDQo+PiArICAgICAgICAgKiBy
ZXN1bHQgaW4gZnV0dXJlIGhlbHBlciBmdW5jdGlvbiBjYWxsaW5nLg0KPj4gICAgICAgICAgICov
DQo+PiAtICAgICAgICByZXRfZnIgPSB2dGRfY2VfcmlkMnBhc2lkX2NoZWNrKHMsIGNlKTsNCj4+
ICsgICAgICAgIHJldF9mciA9IHZ0ZF9jZV9yaWRfcGFzaWRfY2hlY2socywgY2UpOw0KPj4gICAg
ICAgICAgaWYgKHJldF9mcikgew0KPj4gICAgICAgICAgICAgIHJldHVybiByZXRfZnI7DQo+PiAg
ICAgICAgICB9DQo+PiBAQCAtMjA5Nyw3ICsyMDk0LDcgQEAgc3RhdGljIGJvb2wNCj52dGRfZG9f
aW9tbXVfdHJhbnNsYXRlKFZUREFkZHJlc3NTcGFjZSAqdnRkX2FzLCBQQ0lCdXMgKmJ1cywNCj4+
ICAgICAgYm9vbCByZWFkcyA9IHRydWU7DQo+PiAgICAgIGJvb2wgd3JpdGVzID0gdHJ1ZTsNCj4+
ICAgICAgdWludDhfdCBhY2Nlc3NfZmxhZ3MsIHBndHQ7DQo+PiAtICAgIGJvb2wgcmlkMnBhc2lk
ID0gKHBhc2lkID09IFBDSV9OT19QQVNJRCkgJiYgcy0+cm9vdF9zY2FsYWJsZTsNCj4+ICsgICAg
Ym9vbCByaWRfcGFzaWQgPSAocGFzaWQgPT0gUENJX05PX1BBU0lEKSAmJiBzLT5yb290X3NjYWxh
YmxlOw0KPkkgYW0gbm90IGtlZW4gb2YgdGhlIHJpZF9wYXNpZCBuYW1lLiBJdCBkb2VzIG5vdCB0
ZWxsIHdoYXQgaXMgdGhlDQo+c2VtYW50aWMgb2YgdGhlIHZhcmlhYmxlLiByaWRfcGFzaWQgaXMg
YW4gYWN0dWFsIGZpZWxkIGluIHRoZSBDRS4NCj5kb2VzIHRoYXQgY2hlY2sgd2hldGhlciB3ZSBm
YWNlIGEgcmVxdWVzdCB3aXRob3V0IHBhc2lkIGluIHNjYWxhYmxlDQo+bW9kZS4gSWYgc28gSSB3
b3VsZCBjYWxsIHRoYXQgcmVxdWVzdF93b19wYXNpZF9zbSBvciBzb21ldGhpbmsgYWxpa2UNCg0K
T0sNCg0KPj4gICAgICBWVERJT1RMQkVudHJ5ICppb3RsYl9lbnRyeTsNCj4+ICAgICAgdWludDY0
X3QgeGxhdCwgc2l6ZTsNCj4+DQo+PiBAQCAtMjExMSw4ICsyMTA4LDggQEAgc3RhdGljIGJvb2wN
Cj52dGRfZG9faW9tbXVfdHJhbnNsYXRlKFZUREFkZHJlc3NTcGFjZSAqdnRkX2FzLCBQQ0lCdXMg
KmJ1cywNCj4+DQo+PiAgICAgIGNjX2VudHJ5ID0gJnZ0ZF9hcy0+Y29udGV4dF9jYWNoZV9lbnRy
eTsNCj4+DQo+PiAtICAgIC8qIFRyeSB0byBmZXRjaCBwdGUgZnJvbSBJT1RMQiwgd2UgZG9uJ3Qg
bmVlZCBSSUQyUEFTSUQgbG9naWMgKi8NCj4+IC0gICAgaWYgKCFyaWQycGFzaWQpIHsNCj4+ICsg
ICAgLyogVHJ5IHRvIGZldGNoIHB0ZSBmcm9tIElPVExCLCB3ZSBkb24ndCBuZWVkIFJJRF9QQVNJ
RCgwKSBsb2dpYyAqLw0KPkl0IGlzIHVuY2xlYXIgd2hhdCB0aGUgIlJJRF9QQVNJRCgwKSBsb2dp
YyIgaXMuIEFsbCB0aGUgbW9yZSBzbyB3ZSBub3cNCj5qdXN0IGhhdmUgdG8gc2V0IHRoZSBwYXNp
ZCB0byBQQVNJRF8wLg0KDQpZb3UgaGF2ZSBrZWVuIGluc2lnaHQsIHllcywgdGhpcyBwaWVjZSBv
ZiBjb2RlIGNvdWxkIGJlIGZ1cnRoZXIgc2ltcGxpZmllZC4NCldlIGRvbid0IG5lZWQgdG8gY2hl
Y2sgcmlkMl9wYXNpZCBhbnltb3JlLCBqdXN0IGluZGV4IGlvdGxiIGNhY2hlIGV2ZW4gZm9yIFBB
U0lEXzAuDQoNCj4+ICsgICAgaWYgKCFyaWRfcGFzaWQpIHsNCj4+ICAgICAgICAgIGlvdGxiX2Vu
dHJ5ID0gdnRkX2xvb2t1cF9pb3RsYihzLCBzb3VyY2VfaWQsIHBhc2lkLCBhZGRyKTsNCj4+ICAg
ICAgICAgIGlmIChpb3RsYl9lbnRyeSkgew0KPj4gICAgICAgICAgICAgIHRyYWNlX3Z0ZF9pb3Rs
Yl9wYWdlX2hpdChzb3VyY2VfaWQsIGFkZHIsDQo+aW90bGJfZW50cnktPnB0ZSwNCj4+IEBAIC0y
MTYwLDggKzIxNTcsOCBAQCBzdGF0aWMgYm9vbA0KPnZ0ZF9kb19pb21tdV90cmFuc2xhdGUoVlRE
QWRkcmVzc1NwYWNlICp2dGRfYXMsIFBDSUJ1cyAqYnVzLA0KPj4gICAgICAgICAgY2NfZW50cnkt
PmNvbnRleHRfY2FjaGVfZ2VuID0gcy0+Y29udGV4dF9jYWNoZV9nZW47DQo+PiAgICAgIH0NCj4+
DQo+PiAtICAgIGlmIChyaWQycGFzaWQpIHsNCj4+IC0gICAgICAgIHBhc2lkID0gVlREX0NFX0dF
VF9SSUQyUEFTSUQoJmNlKTsNCj4+ICsgICAgaWYgKHJpZF9wYXNpZCkgew0KPj4gKyAgICAgICAg
cGFzaWQgPSBSSURfUEFTSUQ7DQo+PiAgICAgIH0NCj4+DQo+PiAgICAgIC8qDQo+PiBAQCAtMjE4
OSw4ICsyMTg2LDggQEAgc3RhdGljIGJvb2wNCj52dGRfZG9faW9tbXVfdHJhbnNsYXRlKFZUREFk
ZHJlc3NTcGFjZSAqdnRkX2FzLCBQQ0lCdXMgKmJ1cywNCj4+ICAgICAgICAgIHJldHVybiB0cnVl
Ow0KPj4gICAgICB9DQo+Pg0KPj4gLSAgICAvKiBUcnkgdG8gZmV0Y2ggcHRlIGZyb20gSU9UTEIg
Zm9yIFJJRDJQQVNJRCBzbG93IHBhdGggKi8NCj4+IC0gICAgaWYgKHJpZDJwYXNpZCkgew0KPj4g
KyAgICAvKiBUcnkgdG8gZmV0Y2ggcHRlIGZyb20gSU9UTEIgZm9yIFJJRF9QQVNJRCgwKSBzbG93
IHBhdGggKi8NCj5QQVNJRF8wPw0KDQpXaXRoIHNpbXBsaWZpY2F0aW9uIGFzIGFib3ZlLCB0aGlz
IGNvZGUgaXMgdXNlbGVzcyBhbmQgd2lsbCBiZSBkZWxldGVkLg0KDQo+PiArICAgIGlmIChyaWRf
cGFzaWQpIHsNCj4+ICAgICAgICAgIGlvdGxiX2VudHJ5ID0gdnRkX2xvb2t1cF9pb3RsYihzLCBz
b3VyY2VfaWQsIHBhc2lkLCBhZGRyKTsNCj4+ICAgICAgICAgIGlmIChpb3RsYl9lbnRyeSkgew0K
Pj4gICAgICAgICAgICAgIHRyYWNlX3Z0ZF9pb3RsYl9wYWdlX2hpdChzb3VyY2VfaWQsIGFkZHIs
DQo+aW90bGJfZW50cnktPnB0ZSwNCj4+IEBAIC0yNDY0LDIwICsyNDYxLDE0IEBAIHN0YXRpYyB2
b2lkDQo+dnRkX2lvdGxiX3BhZ2VfaW52YWxpZGF0ZV9ub3RpZnkoSW50ZWxJT01NVVN0YXRlICpz
LA0KPj4gICAgICAgICAgcmV0ID0gdnRkX2Rldl90b19jb250ZXh0X2VudHJ5KHMsIHBjaV9idXNf
bnVtKHZ0ZF9hcy0+YnVzKSwNCj4+ICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAg
ICAgICB2dGRfYXMtPmRldmZuLCAmY2UpOw0KPj4gICAgICAgICAgaWYgKCFyZXQgJiYgZG9tYWlu
X2lkID09IHZ0ZF9nZXRfZG9tYWluX2lkKHMsICZjZSwNCj52dGRfYXMtPnBhc2lkKSkgew0KPj4g
LSAgICAgICAgICAgIHVpbnQzMl90IHJpZDJwYXNpZCA9IFBDSV9OT19QQVNJRDsNCj4+IC0NCj4+
IC0gICAgICAgICAgICBpZiAocy0+cm9vdF9zY2FsYWJsZSkgew0KPj4gLSAgICAgICAgICAgICAg
ICByaWQycGFzaWQgPSBWVERfQ0VfR0VUX1JJRDJQQVNJRCgmY2UpOw0KPj4gLSAgICAgICAgICAg
IH0NCj4+IC0NCj4+ICAgICAgICAgICAgICAvKg0KPj4gICAgICAgICAgICAgICAqIEluIGxlZ2Fj
eSBtb2RlLCB2dGRfYXMtPnBhc2lkID09IHBhc2lkIGlzIGFsd2F5cyB0cnVlLg0KPj4gICAgICAg
ICAgICAgICAqIEluIHNjYWxhYmxlIG1vZGUsIGZvciB2dGQgYWRkcmVzcyBzcGFjZSBiYWNraW5n
IGEgUENJDQo+PiAgICAgICAgICAgICAgICogZGV2aWNlIHdpdGhvdXQgcGFzaWQsIG5lZWRzIHRv
IGNvbXBhcmUgcGFzaWQgd2l0aA0KPj4gLSAgICAgICAgICAgICAqIHJpZDJwYXNpZCBvZiB0aGlz
IGRldmljZS4NCj4+ICsgICAgICAgICAgICAgKiBSSURfUEFTSUQoMCkgb2YgdGhpcyBkZXZpY2Uu
DQo+PiAgICAgICAgICAgICAgICovDQo+PiAgICAgICAgICAgICAgaWYgKCEodnRkX2FzLT5wYXNp
ZCA9PSBwYXNpZCB8fA0KPj4gLSAgICAgICAgICAgICAgICAgICh2dGRfYXMtPnBhc2lkID09IFBD
SV9OT19QQVNJRCAmJiBwYXNpZCA9PQ0KPnJpZDJwYXNpZCkpKSB7DQo+PiArICAgICAgICAgICAg
ICAgICAgKHZ0ZF9hcy0+cGFzaWQgPT0gUENJX05PX1BBU0lEICYmIHBhc2lkID09DQo+UklEX1BB
U0lEKSkpIHsNCj53b3VsZCBzdHJvbmdseSBzdWdnZXN0IHVzaW5nIFBBU0lEXzAgaW5zdGVhZA0K
DQpTdXJlLg0KDQpUaGFua3MNClpoZW56aG9uZw0KDQo+PiAgICAgICAgICAgICAgICAgIGNvbnRp
bnVlOw0KPj4gICAgICAgICAgICAgIH0NCj4+DQo+PiBAQCAtMjk3Niw5ICsyOTY3LDcgQEAgc3Rh
dGljIHZvaWQNCj52dGRfcGlvdGxiX3Bhc2lkX2ludmFsaWRhdGUoSW50ZWxJT01NVVN0YXRlICpz
LA0KPj4gICAgICAgICAgaWYgKCF2dGRfZGV2X3RvX2NvbnRleHRfZW50cnkocywgcGNpX2J1c19u
dW0odnRkX2FzLT5idXMpLA0KPj4gICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAg
ICAgdnRkX2FzLT5kZXZmbiwgJmNlKSAmJg0KPj4gICAgICAgICAgICAgIGRvbWFpbl9pZCA9PSB2
dGRfZ2V0X2RvbWFpbl9pZChzLCAmY2UsIHZ0ZF9hcy0+cGFzaWQpKSB7DQo+PiAtICAgICAgICAg
ICAgdWludDMyX3QgcmlkMnBhc2lkID0gVlREX0NFX0dFVF9SSUQyUEFTSUQoJmNlKTsNCj4+IC0N
Cj4+IC0gICAgICAgICAgICBpZiAoKHZ0ZF9hcy0+cGFzaWQgIT0gUENJX05PX1BBU0lEIHx8IHBh
c2lkICE9IHJpZDJwYXNpZCkgJiYNCj4+ICsgICAgICAgICAgICBpZiAoKHZ0ZF9hcy0+cGFzaWQg
IT0gUENJX05PX1BBU0lEIHx8IHBhc2lkICE9IFJJRF9QQVNJRCkNCj4mJg0KPj4gICAgICAgICAg
ICAgICAgICB2dGRfYXMtPnBhc2lkICE9IHBhc2lkKSB7DQo+PiAgICAgICAgICAgICAgICAgIGNv
bnRpbnVlOw0KPj4gICAgICAgICAgICAgIH0NCj5UaGFua3MNCj4NCj5FcmljDQoNCg==

