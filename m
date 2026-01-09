Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id F3595D167FA
	for <qemu-devel@archiver.kernel.org>; Fri,  9 Jan 2026 10:13:21 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1ve9UE-0003w3-Vn; Fri, 09 Jan 2026 05:12:55 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <zhenzhong.duan@intel.com>)
 id 1ve9UC-0003mW-OY; Fri, 09 Jan 2026 05:12:53 -0500
Received: from mgamail.intel.com ([192.198.163.7])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <zhenzhong.duan@intel.com>)
 id 1ve9UA-0004KL-7p; Fri, 09 Jan 2026 05:12:52 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1767953570; x=1799489570;
 h=from:to:cc:subject:date:message-id:references:
 in-reply-to:content-transfer-encoding:mime-version;
 bh=WwHDS3XXKtD8DGQtTdTL64HYIimnAo+xP2kkqHIjbCY=;
 b=XIF0nuRgIgnB2Z8KJA++ZqmMBIZyzx5nRamDLGDL7hPv8JdtuQ6Dqevy
 bz2jQhk6IWnK31u0w7d5RyDvjQLJXKzVaD8rmYxPDrGx74ewGYmeBx0Fm
 IIQXPZUJswtv+SfUWcG38lKlRbbpZWK1Ln3NTvraIZjW8gqRRxZnlZ6YD
 YYAdPj1/3mfIay8WbfHeBSbZtptk36tZu2n4EOSPKubPQD6uPFVWbUemW
 bkvHKQBzQtsnkFce4Gv8UsLUy2YPsjfRM/FzgSjXyWVnppUulNolr7uc1
 RMNmrs60ZBChNSzPJh6yRF1tYdcqVamaZBT+8HtxiZYmQ3hmKG7Y2PyM5 Q==;
X-CSE-ConnectionGUID: ObkKG3ALRuaEXoQBaY1XKw==
X-CSE-MsgGUID: vrhxqU+ASSimqtHcbI222w==
X-IronPort-AV: E=McAfee;i="6800,10657,11665"; a="94805625"
X-IronPort-AV: E=Sophos;i="6.21,212,1763452800"; d="scan'208";a="94805625"
Received: from fmviesa006.fm.intel.com ([10.60.135.146])
 by fmvoesa101.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 09 Jan 2026 02:12:46 -0800
X-CSE-ConnectionGUID: /LF6kLauTWyScU3qVz58cQ==
X-CSE-MsgGUID: tz4gRdecQwudoXsUw1zbnA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.21,212,1763452800"; d="scan'208";a="203352819"
Received: from orsmsx901.amr.corp.intel.com ([10.22.229.23])
 by fmviesa006.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 09 Jan 2026 02:12:46 -0800
Received: from ORSMSX901.amr.corp.intel.com (10.22.229.23) by
 ORSMSX901.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.29; Fri, 9 Jan 2026 02:12:45 -0800
Received: from ORSEDG902.ED.cps.intel.com (10.7.248.12) by
 ORSMSX901.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.29 via Frontend Transport; Fri, 9 Jan 2026 02:12:45 -0800
Received: from SN4PR2101CU001.outbound.protection.outlook.com (40.93.195.66)
 by edgegateway.intel.com (134.134.137.112) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.29; Fri, 9 Jan 2026 02:12:45 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=dRi0O+RHvedcTZPbIDeBB7JVfhfWpef+02uYAcTGC5HfkEKOSQ/dNG2ulyMjs2WJBqMqQfjhvytMrImoNbCAJJl3hkD+qAIGDqEsxsHIpisyeDaHnQ2QcheCDxsybTtT4iw+1LWBh/0uQOvTjecQ43N8ZNpQwAiKctT+WiXGyYb5Qn0h48AFz/GJgu7QQdXfSI3ofDquk+mNB+vv8ZoA0nwHPP5GhL+wanwBLpioEusRMumKDv8K2EEf30/BcT0N92udhsquqs60NYUgOWT3Ds2YbFwQI8CZFRDu9wzvyGeQXhNTy7MVtpPl9pNn5WeIcN55EZv04COocRT9ywD23g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=WwHDS3XXKtD8DGQtTdTL64HYIimnAo+xP2kkqHIjbCY=;
 b=Jf5A5Yh0ZNG31QFM0cpfGkPECTKAiVaT8luF2tWJ54C0YLjxiPnpZ7EXdrU/xQXyAO7Zmjp2h9YZ+ErhjYNCG0bEeSIdkjYE3OTYpnyobwfYAP0x8OKLFw8Uzu6y2cxHNPrpoin5fICP5wFrEDtaGlD0RAe9+aNiWIxl7XtwOEeH3ix78V4M+x+q3SDi7KQQiCWAYS2FWJKJiEiuIrSwVceQZJCwxecYJW7NpndhNOvU1urpU2ZoMMhebZ+LRe+g+/3dAyXUD8WbwJiomC0yxEZO+GML1O3BC/tAia5kxb4Ahqt13OEjL0A3ZhEXNdrgGOOM90wCKUCe7ZrpBmZPig==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Received: from IA3PR11MB9136.namprd11.prod.outlook.com (2603:10b6:208:574::12)
 by CYXPR11MB8712.namprd11.prod.outlook.com (2603:10b6:930:df::17)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9499.5; Fri, 9 Jan
 2026 10:12:42 +0000
Received: from IA3PR11MB9136.namprd11.prod.outlook.com
 ([fe80::604b:77a4:b1be:3f13]) by IA3PR11MB9136.namprd11.prod.outlook.com
 ([fe80::604b:77a4:b1be:3f13%7]) with mapi id 15.20.9456.013; Fri, 9 Jan 2026
 10:12:42 +0000
From: "Duan, Zhenzhong" <zhenzhong.duan@intel.com>
To: Shameer Kolothum <skolothumtho@nvidia.com>, "qemu-arm@nongnu.org"
 <qemu-arm@nongnu.org>, "qemu-devel@nongnu.org" <qemu-devel@nongnu.org>
CC: "eric.auger@redhat.com" <eric.auger@redhat.com>, "alex@shazbot.org"
 <alex@shazbot.org>, "clg@redhat.com" <clg@redhat.com>, "cohuck@redhat.com"
 <cohuck@redhat.com>, "mst@redhat.com" <mst@redhat.com>, Nicolin Chen
 <nicolinc@nvidia.com>, Nathan Chen <nathanc@nvidia.com>, Matt Ochs
 <mochs@nvidia.com>, Jason Gunthorpe <jgg@nvidia.com>, Krishnakant Jaju
 <kjaju@nvidia.com>
Subject: RE: [PATCH 3/3] hw/vfio/region: Create dmabuf for PCI BAR per region
Thread-Topic: [PATCH 3/3] hw/vfio/region: Create dmabuf for PCI BAR per region
Thread-Index: AQHcgIL1GDCpLYnc30ilWHbwOoJZ/bVIHDeAgAF7AAA=
Date: Fri, 9 Jan 2026 10:12:42 +0000
Message-ID: <IA3PR11MB9136783B1EC050DB8B655A2A9282A@IA3PR11MB9136.namprd11.prod.outlook.com>
References: <20251222135357.143339-1-skolothumtho@nvidia.com>
 <20251222135357.143339-4-skolothumtho@nvidia.com>
 <d043f6e1-8fa4-4215-95ed-7570ae002e11@intel.com>
 <CH3PR12MB75485C401917E76FF22E0122AB85A@CH3PR12MB7548.namprd12.prod.outlook.com>
In-Reply-To: <CH3PR12MB75485C401917E76FF22E0122AB85A@CH3PR12MB7548.namprd12.prod.outlook.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: IA3PR11MB9136:EE_|CYXPR11MB8712:EE_
x-ms-office365-filtering-correlation-id: 8516fcd8-7a53-47b5-6bd9-08de4f67a067
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
 ARA:13230040|376014|7416014|1800799024|366016|38070700021; 
x-microsoft-antispam-message-info: =?utf-8?B?RFQ5M01JZW9iUVlFbys4NEdYUFd1TGR3aGNSNk91dFJrZHp5ZVlnVXl4dXBF?=
 =?utf-8?B?Z2U0ei9PMUtGTE1WTTJWK0F3WUg3Ti95NFZuOTJhNjdmZjI1QWE3Szd2MW9m?=
 =?utf-8?B?cW52NTFrYnJidkthL3lUWnJUMG1xMUp1TXQ2WjVnaGQ2eEIweWx5QU83TG81?=
 =?utf-8?B?aWM5OHRVNis1a1RPQlFaZHVQZWpNcTFqRWttbXpXaE1vOVZlZnZOWlh4eXlU?=
 =?utf-8?B?Wk1URmViSzlDWURza3lKalNYM3dTWFpqaWV5U3N5ZG5MMU9PTlFoUVJkM2c0?=
 =?utf-8?B?V3c3MTB5YmVjVmNsYVd2K3RwczhWa2VLcVpuNm96REplcVFJcE02WG1kaHBh?=
 =?utf-8?B?MjZpajljY2Z3WS9EeGg4a2pNcTZYbWN3UkFhMmpuODNUOUtSU2NLTmh3RXdp?=
 =?utf-8?B?TVZyZlZzeXFMd3dReU5FVVc2bkowY2F3cldtQ2x2YXdqZXVuS0k4SG5jYmc4?=
 =?utf-8?B?b1NRdkF4VzJmKzROWi8rUUZReVVISnV3R3oyd0lzS0swZ01idWdxWTJacTZG?=
 =?utf-8?B?Z0RWemVWRDFxYWd4Q2hZL0xIUWNUc1JxR2l3QXIzNktNdlpRM3VYcVJiTEVC?=
 =?utf-8?B?bkRUeXh3NmZXSUI3bnZEUUdYRnZMNU9POFV0anVxSklRSXF4OGFSOTEzUUpV?=
 =?utf-8?B?SEVyem1xMnNVK2dUZEZkRVgyM3FEa0lIc3RTS1FlVEhSUUlSUXEvWDlLdmF6?=
 =?utf-8?B?aU53NitwSEhkaU11emYycDgyb0taeDR2V3NoRDA2SG9URjBtOHNQcXo4U3lX?=
 =?utf-8?B?ZHBPUHpzRG9sMnN3Sm1iQzN2R1hxRG1qUjVBS282TXk0YVNuTG0wU0Z2RVda?=
 =?utf-8?B?WVcvZEV0UmNTT3JmSWw0alRCVHR2b2tZYTVTMGJ4cnRoakRkUU5KRzcvQi9H?=
 =?utf-8?B?UFY3UkZXRGNWd0p0TW1xbk9taWxsSmJhNVljQzUyVmNUcHNxRVBSVzYveTlv?=
 =?utf-8?B?UllSZFM1VUt4QlBjL0lvVmdLTlJTUkhuaTEwOWZVNEY5MjRsVllJa1RhN0hO?=
 =?utf-8?B?Zm1kTlUwOFUwdE9ENFpHYmhPb1lsaHJYSmkwVnhhWnpvY2RBbktwcDRic3ND?=
 =?utf-8?B?V3VLamhtVUJ6aExFdUNlNHhjMFhzKzN4Q083Z2ZVZHZDaUxOOW43d3hodks1?=
 =?utf-8?B?VjhaNXBZZTBjRThxMmJTWERDRkNQNTcvVTNHdEdpcEE3Y0R1aERvNzR0U280?=
 =?utf-8?B?MXBLT3RtZndlaWhLMzFpNy84THFEdWJVcFpMK3R5TWJ6anlCd2JIQVBTbXdq?=
 =?utf-8?B?VEY5TDlEdFBtTW9jSmg5ckpIMmVsRC9JRi9BejF5YkE1WVhLTVBXcjJUSVl2?=
 =?utf-8?B?L1hTQktrUnZPRDM1cWpSdTdnWUZRV085YmlYeGFxNG05OG5xS2JHc0FuUys3?=
 =?utf-8?B?VFk4eG9VbE0zMTdYUFFvbEZKSndiejBNVTN0ZTFwdy9GQVN4OWw3M3dMQ21o?=
 =?utf-8?B?aW5HNGdkRnRQOCtpd0gydnZjb2I2NStJOWFlam12TjlZYW9Kdi9pUDRmdzNL?=
 =?utf-8?B?aVcxT2hXVDNWMWY2Mm5uTjJ6UEU5OEhUb214by9nU05LSHZoYXRtYVBYaklw?=
 =?utf-8?B?MzlkT0YwYTZjcml2RXE5NGNuMmFqaXhlYndLYWxzb1JFN2k4SXJxMS9UV0hl?=
 =?utf-8?B?REUvUWluM0VjSzQ0WDhLcFhvUUV2TjFWQjNyWTVReEl3bUlvc1UyVE1iektP?=
 =?utf-8?B?SjlDT1J0RzJCdldMVElXc0lKK1RWV0djNE5ybVdLQ1JXT1pVTXI2NXNsWGhq?=
 =?utf-8?B?aXhFdmxKMm9iYmYwdnlhZ1A5dVA5T3BYYzhYS1hFd2t6cjhhNFlFemxDM0Yx?=
 =?utf-8?B?Q3Y5VElzWE0xRGpPZGVvcEVEL2xkS3BUZy9LRFNzZ0grdDBEUlUwL1FmbndR?=
 =?utf-8?B?UVVWQ1k5NzRiT3Z5VytwRUZCbnh1UjhJNUlCTmM2ckxLYjdSOXBxV25xbGlF?=
 =?utf-8?B?ZDdpUHJoYVFoREpWMExPdlNyaVpXMGw2bWo2aG5uczROb3BBeUY2eE5DbHFV?=
 =?utf-8?B?N1dOSmpJdERlMFpqbVhZb1c1MkVUdTc0T2hXaSt5c0JPRzZVT2plQVBTbnkz?=
 =?utf-8?Q?mzpVVR?=
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:IA3PR11MB9136.namprd11.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(376014)(7416014)(1800799024)(366016)(38070700021); DIR:OUT;
 SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?OUsxSU4rQWlsZW5NdVJLb0I1ZjNaNlNsZ3gyTFBMZkg1UlhnWkJsNDRWeXBR?=
 =?utf-8?B?WFA4MTdtUkI4UzBURFdsb0lacDl5SnFKdGtSUThMa2E5MWNncEpMTkJHa1Y5?=
 =?utf-8?B?cjNxdWF5eHBCeVBJNnZKSkMyb0dEcnk4eEl0dFdCMkJCRGFKemFyVTk2YlZX?=
 =?utf-8?B?aFdTNVY5NEloLzFSTTRjQXZFV3c4SGVJaUxDeWtORFdOWEo0UngxREZZUVJu?=
 =?utf-8?B?TUhmL0MxY1FiYzkxNGdFTk8xTnZJeE9vYys2amk3Tmt0RFdiZ3Q4akgxU3oy?=
 =?utf-8?B?SmpZUUIrcUphZktKT1VJelQ2Z2t1R3lXWVJTRktjUmJDYWppY2twR1RKUFFp?=
 =?utf-8?B?VmY5a1JXbU9ESjBieGpML2FTZGhkZjlHZmNTSjh5clYxdmZ0RnJabjYrK2RK?=
 =?utf-8?B?a3plYWdEQzY1c2NuTDRkRERVYnJsM0dKRytxaHA1cTNwYWZ0di9hWm8vOVd1?=
 =?utf-8?B?b1lrcG9qNUlYUlV0cjFJSWRuaEIyeDByanc5aGJaY2l6aC82STJkNXdJVjNW?=
 =?utf-8?B?V0pVUjM1V2hzcDl6YkR0OWRSckNPZUc2eTRSeDU3M1VZZTZCTFhpeXdjR3pV?=
 =?utf-8?B?ODVWbjJoN0R4dFU1b3lSZVRDWE9qeVB5UFlwRlB3c21vb1BxeDJCWVFHTzJm?=
 =?utf-8?B?RFNsbGpNQlpmRHA3cDRpOUR3VXBhUGtIVkVOM1VGSVA3M2lVekE3dkZnZ1NE?=
 =?utf-8?B?TnRpbVhZNHpXeS9sSWhabnpLeGNZbGI3enExWlFJSnhDaFpGVzhicnNCSE9J?=
 =?utf-8?B?Q1dRNVBaK0w0eDhqQVRCY084SndVcjNkdmNlb2VvV1BZUVJWY0wwRnVKdnVt?=
 =?utf-8?B?dTdJb2t2NDZjKy9DbWZ1WUZuVjlUSDdjaWc4ZXFyQVVYdmpXTXJDZE41b1lT?=
 =?utf-8?B?OGJLZHZlR1ZKQjViLzRvTHNDdy84ZmczU3BWVmdqa1F1WGNsd3kzSUdjY0hZ?=
 =?utf-8?B?dnpsR1NaN3dhbU51M1ZTcmtMZWZYbHVRV1F3aTFPdFBzSDdkZDVQek55Ulpo?=
 =?utf-8?B?bExXdnRoRktiM3dnQnRudTdEenRUQy9iZUdFQ2dmTWc4OVVQdW9tSXBLZUUx?=
 =?utf-8?B?WENBWHNVWmNPN2FWRUcxL2pzU3dhMGoxZko5K2NJOW0rUUREVXFqU3IvVDJh?=
 =?utf-8?B?N3BiVjdvcVFkZzFVUU1WSk5xanZ5RlZoY09BcmwzQWlMaG9YSDEvT1hWWThM?=
 =?utf-8?B?UXYxS1VIVjFqQStYblNrOW5tWk4yRjM3VDNMQzFqREp5NXZKamVHNUdZTlZ3?=
 =?utf-8?B?Y0V0ODU4b1VrUGtJTVA4QzV5dkhDWmpyU3A3WkhrYllBdEJtVUtEMDcxS0lQ?=
 =?utf-8?B?dXc0WC9WUkVsM1B6b21Vb2oydkdsYWw4TTg4TklwZWRKZFA0WStlUXM2bmJO?=
 =?utf-8?B?cmtwcVpHRUhpQ2RjMEVEQXcyMFZLS3FlREtyUlVyRlBvc3VoUjJwVkoyVzFL?=
 =?utf-8?B?SjJHUXRnYlBsc2NRbHBtSFRyd0dVMGNibm95RHpjczNJZkt6bTlyNkh0cnVk?=
 =?utf-8?B?RVcxZWZzZ2N6aFVwVGdMenQ2K0pucHdwZ2R6MFRiTEwwUEZFdC9CTG1GcGRH?=
 =?utf-8?B?NzhKOC9oYkF6cU9PYlRsbE1iQVZKeWVNOVJudEZ3MHF2TFZ5WWVFclFqdnBp?=
 =?utf-8?B?UlBGRzRQbll1NHFhQlJJeTVFM0VCUnhYWDBOcFJnU284NldLMmh0TGtoZWhB?=
 =?utf-8?B?NmJTeTdWNlFPallUSWc1WTN2UWREYzlpUlpaSnJKVk5JaDJMeFltZjhmdkU4?=
 =?utf-8?B?WHlDc1crZmJwcUozYzJpU1YvaS95dkgwcTVsd2VMbXpWL3ByOXF2Y1VJSlVR?=
 =?utf-8?B?SFZVaExDRWhsNHc3amtLckFzZDJuMEZVM3NjaWZVL1loVGpSRnkySWF4cEdR?=
 =?utf-8?B?VzFPVStxUVY3SHI1dnoxUnFMaEVyK1hLM2FOQ2lFWVkvRXM1RlRGdHE5SXgy?=
 =?utf-8?B?eU5QVi9KeCtYM3o5Z216OVl5RDBLNDZ4cXltQjV2cjdid2tJVEZKdmpCem9B?=
 =?utf-8?B?UC9qVUt4b2d3U2kwU2FLamxkTFhUOUdRY1ZVUDZCNWQwNUtEM3NWN3VpNGs1?=
 =?utf-8?B?RTlrR0xOSFJPSW5TMFdoWFpRV0g4Vnc0M2hXRGNIc2s5b1RmaEZsZVVuTk5k?=
 =?utf-8?B?amlyTk1Vc1hkUXFUdDlYR0dMZ0M3eFh6dUlvdWVENzN2dzV4c3BxWUp3b2NS?=
 =?utf-8?B?Ny82bzNMK3JjSi9CbnRIRnd1ZUpIQU5ydlVaTTJnSEp5WlBGK1M2VVRuVzJo?=
 =?utf-8?B?Unp2akh2MXJwV1VQVG9KQjRpaWlTMGhRUytpNzhGcVJ4MUpjUUEzNWVlSkJC?=
 =?utf-8?B?MENxemIyMkowTFBSWHp1MGJzb21iQkJSWDlrclV1dE4vR2E2SHg5dz09?=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: IA3PR11MB9136.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 8516fcd8-7a53-47b5-6bd9-08de4f67a067
X-MS-Exchange-CrossTenant-originalarrivaltime: 09 Jan 2026 10:12:42.4410 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: XFqG139ewc/CXxJn8lkN7hIViS8L+8qwX4xaeX2W8IhZjpO8CD3Z1RfwBeuviJVYnB/ham/AEVIUpdb3KER7qZjblid5S9Ujo3gS75o57g0=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CYXPR11MB8712
X-OriginatorOrg: intel.com
Received-SPF: pass client-ip=192.198.163.7;
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

DQoNCj4tLS0tLU9yaWdpbmFsIE1lc3NhZ2UtLS0tLQ0KPkZyb206IFNoYW1lZXIgS29sb3RodW0g
PHNrb2xvdGh1bXRob0BudmlkaWEuY29tPg0KPlN1YmplY3Q6IFJFOiBbUEFUQ0ggMy8zXSBody92
ZmlvL3JlZ2lvbjogQ3JlYXRlIGRtYWJ1ZiBmb3IgUENJIEJBUiBwZXINCj5yZWdpb24NCj4NCj4N
Cj4NCj4+IC0tLS0tT3JpZ2luYWwgTWVzc2FnZS0tLS0tDQo+PiBGcm9tOiBEdWFuLCBaaGVuemhv
bmcgPHpoZW56aG9uZy5kdWFuQGludGVsLmNvbT4NCj4+IFNlbnQ6IDA4IEphbnVhcnkgMjAyNiAw
OTo0MQ0KPj4gVG86IFNoYW1lZXIgS29sb3RodW0gPHNrb2xvdGh1bXRob0BudmlkaWEuY29tPjsg
cWVtdS0NCj4+IGFybUBub25nbnUub3JnOyBxZW11LWRldmVsQG5vbmdudS5vcmcNCj4+IENjOiBl
cmljLmF1Z2VyQHJlZGhhdC5jb207IGFsZXhAc2hhemJvdC5vcmc7IGNsZ0ByZWRoYXQuY29tOw0K
Pj4gY29odWNrQHJlZGhhdC5jb207IG1zdEByZWRoYXQuY29tOyBOaWNvbGluIENoZW4NCj48bmlj
b2xpbmNAbnZpZGlhLmNvbT47DQo+PiBOYXRoYW4gQ2hlbiA8bmF0aGFuY0BudmlkaWEuY29tPjsg
TWF0dCBPY2hzIDxtb2Noc0BudmlkaWEuY29tPjsNCj4+IEphc29uIEd1bnRob3JwZSA8amdnQG52
aWRpYS5jb20+OyBLcmlzaG5ha2FudCBKYWp1IDxramFqdUBudmlkaWEuY29tPg0KPj4gU3ViamVj
dDogUmU6IFtQQVRDSCAzLzNdIGh3L3ZmaW8vcmVnaW9uOiBDcmVhdGUgZG1hYnVmIGZvciBQQ0kg
QkFSIHBlcg0KPj4gcmVnaW9uDQo+Pg0KPj4gRXh0ZXJuYWwgZW1haWw6IFVzZSBjYXV0aW9uIG9w
ZW5pbmcgbGlua3Mgb3IgYXR0YWNobWVudHMNCj4+DQo+Pg0KPj4gT24gMTIvMjIvMjAyNSA5OjUz
IFBNLCBTaGFtZWVyIEtvbG90aHVtIHdyb3RlOg0KPj4gPiBGcm9tOiBOaWNvbGluIENoZW4gPG5p
Y29saW5jQG52aWRpYS5jb20+DQo+PiA+DQo+PiA+IExpbnV4IG5vdyBwcm92aWRlcyBhIFZGSU8g
ZG1hYnVmIGV4cG9ydGVyIHRvIGV4cG9zZSBQQ0kgQkFSIG1lbW9yeQ0KPmZvcg0KPj4gPiBQMlAg
dXNlIGNhc2VzLiBDcmVhdGUgYSBkbWFidWYgZm9yIGVhY2ggbWFwcGVkIEJBUiByZWdpb24gYWZ0
ZXIgdGhlDQo+PiA+IG1tYXAgaXMgc2V0IHVwLCBhbmQgc3RvcmUgdGhlIHJldHVybmVkIGZkIGlu
IHRoZSByZWdpb27igJlzIFJBTUJsb2NrLg0KPj4gPiBUaGlzIGFsbG93cyBRRU1VIHRvIHBhc3Mg
dGhlIGZkIHRvIGRtYV9tYXBfZmlsZSgpLCBlbmFibGluZyBpb21tdWZkIHRvDQo+PiA+IGltcG9y
dCB0aGUgZG1hYnVmIGFuZCBtYXAgdGhlIEJBUiBjb3JyZWN0bHkgaW4gdGhlIGhvc3QgSU9NTVUg
cGFnZQ0KPj4gdGFibGUuDQo+PiA+DQo+PiA+IElmIHRoZSBrZXJuZWwgbGFja3Mgc3VwcG9ydCBv
ciBkbWFidWYgc2V0dXAgZmFpbHMsIFFFTVUgc2tpcHMgdGhlDQo+PiA+IHNldHVwIGFuZCBjb250
aW51ZXMgd2l0aCBub3JtYWwgbW1hcCBoYW5kbGluZy4NCj4+ID4NCj4+ID4gU2lnbmVkLW9mZi1i
eTogTmljb2xpbiBDaGVuIDxuaWNvbGluY0BudmlkaWEuY29tPg0KPj4gPiBTaWduZWQtb2ZmLWJ5
OiBTaGFtZWVyIEtvbG90aHVtIDxza29sb3RodW10aG9AbnZpZGlhLmNvbT4NCj4+ID4gLS0tDQo+
PiA+ICAgaHcvdmZpby9yZWdpb24uYyAgICAgfCA1Nw0KPj4gKysrKysrKysrKysrKysrKysrKysr
KysrKysrKysrKysrKysrKysrKysrKy0NCj4+ID4gICBody92ZmlvL3RyYWNlLWV2ZW50cyB8ICAx
ICsNCj4+ID4gICAyIGZpbGVzIGNoYW5nZWQsIDU3IGluc2VydGlvbnMoKyksIDEgZGVsZXRpb24o
LSkNCj4+ID4NCj4+ID4gZGlmZiAtLWdpdCBhL2h3L3ZmaW8vcmVnaW9uLmMgYi9ody92ZmlvL3Jl
Z2lvbi5jIGluZGV4DQo+PiA+IGIxNjVhYjBiOTMuLjY5NDlmNjc3OWMgMTAwNjQ0DQo+PiA+IC0t
LSBhL2h3L3ZmaW8vcmVnaW9uLmMNCj4+ID4gKysrIGIvaHcvdmZpby9yZWdpb24uYw0KPj4gPiBA
QCAtMjksNiArMjksNyBAQA0KPj4gPiAgICNpbmNsdWRlICJxZW11L2Vycm9yLXJlcG9ydC5oIg0K
Pj4gPiAgICNpbmNsdWRlICJxZW11L3VuaXRzLmgiDQo+PiA+ICAgI2luY2x1ZGUgIm1vbml0b3Iv
bW9uaXRvci5oIg0KPj4gPiArI2luY2x1ZGUgInN5c3RlbS9yYW1ibG9jay5oIg0KPj4gPiAgICNp
bmNsdWRlICJ2ZmlvLWhlbHBlcnMuaCINCj4+ID4NCj4+ID4gICAvKg0KPj4gPiBAQCAtMjM4LDEz
ICsyMzksNTIgQEAgc3RhdGljIHZvaWQgdmZpb19zdWJyZWdpb25fdW5tYXAoVkZJT1JlZ2lvbg0K
Pj4gKnJlZ2lvbiwgaW50IGluZGV4KQ0KPj4gPiAgICAgICByZWdpb24tPm1tYXBzW2luZGV4XS5t
bWFwID0gTlVMTDsNCj4+ID4gICB9DQo+PiA+DQo+PiA+ICtzdGF0aWMgaW50IHZmaW9fcmVnaW9u
X2NyZWF0ZV9kbWFfYnVmKFZGSU9SZWdpb24gKnJlZ2lvbikgew0KPj4gPiArICAgIGdfYXV0b2Zy
ZWUgc3RydWN0IHZmaW9fZGV2aWNlX2ZlYXR1cmUgKmZlYXR1cmUgPSBOVUxMOw0KPj4gPiArICAg
IFZGSU9EZXZpY2UgKnZiYXNlZGV2ID0gcmVnaW9uLT52YmFzZWRldjsNCj4+ID4gKyAgICBzdHJ1
Y3QgdmZpb19kZXZpY2VfZmVhdHVyZV9kbWFfYnVmICpkbWFfYnVmOw0KPj4gPiArICAgIHNpemVf
dCB0b3RhbF9zaXplOw0KPj4gPiArICAgIGludCBpLCByZXQ7DQo+PiA+ICsNCj4+ID4gKyAgICBn
X2Fzc2VydChyZWdpb24tPm5yX21tYXBzKTsNCj4+ID4gKw0KPj4gPiArICAgIHRvdGFsX3NpemUg
PSBzaXplb2YoKmZlYXR1cmUpICsgc2l6ZW9mKCpkbWFfYnVmKSArDQo+PiA+ICsgICAgICAgICAg
ICAgICAgIHNpemVvZihzdHJ1Y3QgdmZpb19yZWdpb25fZG1hX3JhbmdlKSAqDQo+cmVnaW9uLT5u
cl9tbWFwczsNCj4+ID4gKyAgICBmZWF0dXJlID0gZ19tYWxsb2MwKHRvdGFsX3NpemUpOw0KPj4g
PiArICAgICpmZWF0dXJlID0gKHN0cnVjdCB2ZmlvX2RldmljZV9mZWF0dXJlKSB7DQo+PiA+ICsg
ICAgICAgIC5hcmdzeiA9IHRvdGFsX3NpemUsDQo+PiA+ICsgICAgICAgIC5mbGFncyA9IFZGSU9f
REVWSUNFX0ZFQVRVUkVfR0VUIHwNCj4+IFZGSU9fREVWSUNFX0ZFQVRVUkVfRE1BX0JVRiwNCj4+
ID4gKyAgICB9Ow0KPj4gPiArDQo+PiA+ICsgICAgZG1hX2J1ZiA9ICh2b2lkICopZmVhdHVyZS0+
ZGF0YTsNCj4+ID4gKyAgICAqZG1hX2J1ZiA9IChzdHJ1Y3QgdmZpb19kZXZpY2VfZmVhdHVyZV9k
bWFfYnVmKSB7DQo+PiA+ICsgICAgICAgIC5yZWdpb25faW5kZXggPSByZWdpb24tPm5yLA0KPj4g
PiArICAgICAgICAub3Blbl9mbGFncyA9IE9fUkRXUiwNCj4+ID4gKyAgICAgICAgLm5yX3Jhbmdl
cyA9IHJlZ2lvbi0+bnJfbW1hcHMsDQo+PiA+ICsgICAgfTsNCj4+ID4gKw0KPj4gPiArICAgIGZv
ciAoaSA9IDA7IGkgPCByZWdpb24tPm5yX21tYXBzOyBpKyspIHsNCj4+ID4gKyAgICAgICAgZG1h
X2J1Zi0+ZG1hX3Jhbmdlc1tpXS5vZmZzZXQgPSByZWdpb24tPm1tYXBzW2ldLm9mZnNldDsNCj4+
ID4gKyAgICAgICAgZG1hX2J1Zi0+ZG1hX3Jhbmdlc1tpXS5sZW5ndGggPSByZWdpb24tPm1tYXBz
W2ldLnNpemU7DQo+PiA+ICsgICAgfQ0KPj4gPiArDQo+PiA+ICsgICAgcmV0ID0gdmJhc2VkZXYt
PmlvX29wcy0+ZGV2aWNlX2ZlYXR1cmUodmJhc2VkZXYsIGZlYXR1cmUpOw0KPj4NCj4+IHZiYXNl
ZGV2LT5pb19vcHMtPmRldmljZV9mZWF0dXJlIG1heSBiZSBOVUxMIGZvciBvdGhlciBiYWNrZW5k
IGxpa2UNCj52ZmlvLQ0KPj4gdXNlci4NCj4NCj5BaC4uT2suIEkgd2lsbCBhZGQgYSBjaGVjay4N
Cj4NCj4+DQo+PiA+ICsgICAgZm9yIChpID0gMDsgaSA8IHJlZ2lvbi0+bnJfbW1hcHM7IGkrKykg
ew0KPj4gPiArICAgICAgICB0cmFjZV92ZmlvX3JlZ2lvbl9kbWFidWYocmVnaW9uLT52YmFzZWRl
di0+bmFtZSwgcmV0LA0KPnJlZ2lvbi0+bnIsDQo+PiA+ICsgICAgICAgICAgICAgICAgICAgICAg
ICAgICAgICAgICByZWdpb24tPm1lbS0+bmFtZSwNCj5yZWdpb24tPm1tYXBzW2ldLm9mZnNldCwN
Cj4+ID4gKyAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgIHJlZ2lvbi0+bW1hcHNbaV0u
c2l6ZSk7DQo+PiA+ICsgICAgfQ0KPj4gPiArICAgIHJldHVybiByZXQ7DQo+PiA+ICt9DQo+PiA+
ICsNCj4+ID4gICBpbnQgdmZpb19yZWdpb25fbW1hcChWRklPUmVnaW9uICpyZWdpb24pDQo+PiA+
ICAgew0KPj4gPiAgICAgICBpbnQgaSwgcmV0LCBwcm90ID0gMDsNCj4+ID4gICAgICAgY2hhciAq
bmFtZTsNCj4+ID4gICAgICAgaW50IGZkOw0KPj4gPg0KPj4gPiAtICAgIGlmICghcmVnaW9uLT5t
ZW0pIHsNCj4+ID4gKyAgICBpZiAoIXJlZ2lvbi0+bWVtIHx8ICFyZWdpb24tPm5yX21tYXBzKSB7
DQo+Pg0KPj4gSnVzdCBjdXJpb3VzLCB3aGVuIHdpbGwgYWJvdmUgY2hlY2sgcmV0dXJuIHRydWU/
DQo+SSB0aGluayBgIXJlZ2lvbi0+bWVtYCBjb3ZlcnMgY2FzZXMgd2hlcmUgbm8gTWVtb3J5UmVn
aW9uIHdhcyBjcmVhdGVkDQo+KGUuZy4gemVybyBzaXplZCByZWdpb25zKS4gIEFuZCBucl9tbWFw
cyBjaGVja3MgcmVnaW9ucyB3aXRoIG1tYXANCj5zdXBwb3J0IGV4aXN0cyAoVkZJT19SRUdJT05f
SU5GT19GTEFHX01NQVAvIF9DQVBfU1BBUlNFX01NQVApLg0KDQpVbmRlcnN0b29kLCB0aGFua3Mu
DQoNCj4NCj4+DQo+PiA+ICAgICAgICAgICByZXR1cm4gMDsNCj4+ID4gICAgICAgfQ0KPj4gPg0K
Pj4gPiBAQCAtMzA1LDYgKzM0NSwyMSBAQCBpbnQgdmZpb19yZWdpb25fbW1hcChWRklPUmVnaW9u
ICpyZWdpb24pDQo+PiA+ICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgIHJlZ2lvbi0+
bW1hcHNbaV0uc2l6ZSAtIDEpOw0KPj4gPiAgICAgICB9DQo+PiA+DQo+PiA+ICsgICAgcmV0ID0g
dmZpb19yZWdpb25fY3JlYXRlX2RtYV9idWYocmVnaW9uKTsNCj4+ID4gKyAgICBpZiAocmV0IDwg
MCkgew0KPj4gPiArICAgICAgICBpZiAocmV0ID09IC1FTk9UVFkpIHsNCj4+ID4gKyAgICAgICAg
ICAgIHdhcm5fcmVwb3J0X29uY2UoIlZGSU8gZG1hYnVmIG5vdCBzdXBwb3J0ZWQgaW4NCj5rZXJu
ZWwiKTsNCj4+ID4gKyAgICAgICAgfSBlbHNlIHsNCj4+ID4gKyAgICAgICAgICAgIGVycm9yX3Jl
cG9ydCgiJXM6IGZhaWxlZCB0byBjcmVhdGUgZG1hYnVmOiAlcyIsDQo+PiA+ICsgICAgICAgICAg
ICAgICAgICAgICAgICAgbWVtb3J5X3JlZ2lvbl9uYW1lKHJlZ2lvbi0+bWVtKSwNCj5zdHJlcnJv
cihlcnJubykpOw0KPj4gPiArICAgICAgICB9DQo+PiA+ICsgICAgfSBlbHNlIHsNCj4+ID4gKyAg
ICAgICAgTWVtb3J5UmVnaW9uICptciA9ICZyZWdpb24tPm1tYXBzWzBdLm1lbTsNCj4+DQo+PiBE
byB3ZSBuZWVkIHRvIHN1cHBvcnQgcmVnaW9uLT5tbWFwc1sxXT8NCj4NCj5NeSB1bmRlcnN0YW5k
aW5nIGlzIGFsbCByZWdpb24tPm1tYXBzW10gZW50cmllcyBmb3IgYSBWRklPIHJlZ2lvbiBzaGFy
ZQ0KPnRoZSBzYW1lIFJBTUJsb2NrLiBBbmQgdGhlIGtlcm5lbCByZXR1cm5zIGEgc2luZ2xlIGRt
YWJ1ZiBmZCBwZXIgcmVnaW9uLA0KPm5vdCBwZXIgc3VicmFuZ2UuDQoNCk5vdCBnZXQsIGNhbiBS
QU1CbG9jayBoYXZlIGhvbGVzPw0KDQo+DQo+VGhhbmtzLA0KPlNoYW1lZXINCj4+DQo+PiBUaGFu
a3MNCj4+DQo+PiBaaGVuemhvbmcNCj4+DQo+PiA+ICsgICAgICAgIFJBTUJsb2NrICpyYW1fYmxv
Y2sgPSBtci0+cmFtX2Jsb2NrOw0KPj4gPiArDQo+PiA+ICsgICAgICAgIHJhbV9ibG9jay0+ZmQg
PSByZXQ7DQo+PiA+ICsgICAgfQ0KPj4gPiArDQo+PiA+ICAgICAgIHJldHVybiAwOw0KPj4gPg0K
Pj4gPiAgIG5vX21tYXA6DQo+PiA+IGRpZmYgLS1naXQgYS9ody92ZmlvL3RyYWNlLWV2ZW50cyBi
L2h3L3ZmaW8vdHJhY2UtZXZlbnRzIGluZGV4DQo+PiA+IDFlODk1NDQ4Y2QuLjU5MmEwMzQ5ZDQg
MTAwNjQ0DQo+PiA+IC0tLSBhL2h3L3ZmaW8vdHJhY2UtZXZlbnRzDQo+PiA+ICsrKyBiL2h3L3Zm
aW8vdHJhY2UtZXZlbnRzDQo+PiA+IEBAIC0xMTcsNiArMTE3LDcgQEAgdmZpb19kZXZpY2VfcHV0
KGludCBmZCkgImNsb3NlIHZkZXYtPmZkPSVkIg0KPj4gPiAgIHZmaW9fcmVnaW9uX3dyaXRlKGNv
bnN0IGNoYXIgKm5hbWUsIGludCBpbmRleCwgdWludDY0X3QgYWRkciwgdWludDY0X3QNCj4+IGRh
dGEsIHVuc2lnbmVkIHNpemUpICIgKCVzOnJlZ2lvbiVkKzB4JSJQUkl4NjQiLCAweCUiUFJJeDY0
ICIsICVkKSINCj4+ID4gICB2ZmlvX3JlZ2lvbl9yZWFkKGNoYXIgKm5hbWUsIGludCBpbmRleCwg
dWludDY0X3QgYWRkciwgdW5zaWduZWQgc2l6ZSwNCj4+IHVpbnQ2NF90IGRhdGEpICIgKCVzOnJl
Z2lvbiVkKzB4JSJQUkl4NjQiLCAlZCkgPSAweCUiUFJJeDY0DQo+PiA+ICAgdmZpb19yZWdpb25f
c2V0dXAoY29uc3QgY2hhciAqZGV2LCBpbnQgaW5kZXgsIGNvbnN0IGNoYXIgKm5hbWUsDQo+dW5z
aWduZWQNCj4+IGxvbmcgZmxhZ3MsIHVuc2lnbmVkIGxvbmcgb2Zmc2V0LCB1bnNpZ25lZCBsb25n
IHNpemUpICJEZXZpY2UgJXMsIHJlZ2lvbiAlZA0KPj4gXCIlc1wiLCBmbGFnczogMHglbHgsIG9m
ZnNldDogMHglbHgsIHNpemU6IDB4JWx4Ig0KPj4gPiArdmZpb19yZWdpb25fZG1hYnVmKGNvbnN0
IGNoYXIgKmRldiwgaW50IGZkLCBpbnQgaW5kZXgsICBjb25zdCBjaGFyDQo+Km5hbWUsDQo+PiB1
bnNpZ25lZCBsb25nIG9mZnNldCwgdW5zaWduZWQgbG9uZyBzaXplKSAiRGV2aWNlICVzLCBkbWFi
dWYgZmQgJWQNCj5yZWdpb24gJWQNCj4+IFwiJXNcIiwgb2Zmc2V0OiAweCVseCwgc2l6ZTogMHgl
bHgiDQo+PiA+ICAgdmZpb19yZWdpb25fbW1hcF9mYXVsdChjb25zdCBjaGFyICpuYW1lLCBpbnQg
aW5kZXgsIHVuc2lnbmVkIGxvbmcNCj5vZmZzZXQsDQo+PiB1bnNpZ25lZCBsb25nIHNpemUsIGlu
dCBmYXVsdCkgIlJlZ2lvbiAlcyBtbWFwc1slZF0sIFsweCVseCAtIDB4JWx4XSwgZmF1bHQ6DQo+
PiAlZCINCj4+ID4gICB2ZmlvX3JlZ2lvbl9tbWFwKGNvbnN0IGNoYXIgKm5hbWUsIHVuc2lnbmVk
IGxvbmcgb2Zmc2V0LCB1bnNpZ25lZA0KPmxvbmcNCj4+IGVuZCkgIlJlZ2lvbiAlcyBbMHglbHgg
LSAweCVseF0iDQo+PiA+ICAgdmZpb19yZWdpb25fZXhpdChjb25zdCBjaGFyICpuYW1lLCBpbnQg
aW5kZXgpICJEZXZpY2UgJXMsIHJlZ2lvbiAlZCINCg==

