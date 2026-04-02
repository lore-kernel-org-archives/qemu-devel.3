Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 08105D39404
	for <qemu-devel@archiver.kernel.org>; Thu,  2 Apr 2026 09:31:36 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1w8EO3-0001ZP-0Z; Thu, 02 Apr 2026 05:30:52 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <zhenzhong.duan@intel.com>)
 id 1w8ENt-0001Y1-Kc
 for qemu-devel@nongnu.org; Thu, 02 Apr 2026 05:30:42 -0400
Received: from mgamail.intel.com ([192.198.163.17])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <zhenzhong.duan@intel.com>)
 id 1w8ENo-00035M-W0
 for qemu-devel@nongnu.org; Thu, 02 Apr 2026 05:30:40 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1775122237; x=1806658237;
 h=from:to:cc:subject:date:message-id:references:
 in-reply-to:content-transfer-encoding:mime-version;
 bh=NY4k+fPvmD5QSTOh/AAutxSScHk/jIDZxhP3r1nqI+Q=;
 b=HJRwLF3K+FPxZpQUyyPhctrlSGmee78tU3karGVpXIUXnhmLb2GmyT6L
 8oSclkfc681ZbptREUl4Cl0EnG8yVxnLi/APhs1v/cux2WFVHyw3Kn7RZ
 soXStBSGQZsfmrCw/JfTiZB8GLe0WGzejE0uGEAVLdzYetS6AdjPJcclt
 om3A6S1k+GVkUgLut4nHoEnbdpmeXFfCZYgbthE+3MIl6m6EyX6RCBOs8
 2LrG1OMI86KtQWcfWcNtEFKzr9BD2Zo/2a9OEVSj/+VCMg3P1UVGAivkR
 QZ38xiJleVQ/Epc7/I1sZZl7WAo71v6y+afQ304zyct0BPfxAVMfb3fXy w==;
X-CSE-ConnectionGUID: /7DIZjBlSHGkv2AdYoAXXQ==
X-CSE-MsgGUID: C0rQuj6lSXqmm2hD47Sf+g==
X-IronPort-AV: E=McAfee;i="6800,10657,11746"; a="76068175"
X-IronPort-AV: E=Sophos;i="6.23,155,1770624000"; d="scan'208";a="76068175"
Received: from orviesa010.jf.intel.com ([10.64.159.150])
 by fmvoesa111.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 02 Apr 2026 02:30:20 -0700
X-CSE-ConnectionGUID: lo2ecb2cQkqJCNh7kq02QQ==
X-CSE-MsgGUID: ifQ6985kQ4yPZvSoKiG+Xg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.23,155,1770624000"; d="scan'208";a="226096077"
Received: from fmsmsx901.amr.corp.intel.com ([10.18.126.90])
 by orviesa010.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 02 Apr 2026 02:30:20 -0700
Received: from FMSMSX903.amr.corp.intel.com (10.18.126.92) by
 fmsmsx901.amr.corp.intel.com (10.18.126.90) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.37; Thu, 2 Apr 2026 02:30:19 -0700
Received: from fmsedg901.ED.cps.intel.com (10.1.192.143) by
 FMSMSX903.amr.corp.intel.com (10.18.126.92) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.37 via Frontend Transport; Thu, 2 Apr 2026 02:30:19 -0700
Received: from CH1PR05CU001.outbound.protection.outlook.com (52.101.193.0) by
 edgegateway.intel.com (192.55.55.81) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.37; Thu, 2 Apr 2026 02:30:19 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=ElWqKw85a8je8y4alI+9K77MLIwDXyIOV3C8YdUPeq1h/89zYUJB7cDGF56Sdw4Rn6362qolj1VdNUT5qZ+Qb2Z1zNr8h/XNjYzqPSeQh4P4U8nWVk2MJ0Ws46lu19RPlpgXCftIv8bj3Djwikfw4JOrc8NHW8C6oR8DVyGRYiKwQcWHBBN01cEJPu9haZCsuL9gmBj98gdHRur36uVPCFA14m51lJN6cYt1qYGqHl0dTmS1ijgaXrZN3F/rJSmTO+xe+3If+4fAKZbCvDTl5HERwUjA5CG4WXAh5mZbTY/C6DVtqrnvLn0UCH5pzJnC1SC3EJtH1fw8A5pbCL4PrA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=NY4k+fPvmD5QSTOh/AAutxSScHk/jIDZxhP3r1nqI+Q=;
 b=dSgS/XKG/rlrGamL7id+wcXWpAewjNMHcUEZ80Xj7ZR97lLG2NdJUCWkhqd5BvW+h+S5DGy6b6ODO7eFAnjxz0HK9wajSjWyFN0/X1S+BnlYb4Kpr8l90bRuBpYdN/aZCUVPDrMHxU1+pb9RwQXOqhATVlIu9/vWB+Am10cNzs2djro2W9JSnjfrQ/KPHTQjD3BpCB9cfyJh5bKbK5uyIb7rOUTKBSEkzS5OIEb+CoZsuxL5Y4RD5MEmH+NDoNtWTg2w3b+1ae3w+XkJGZI/MTM61x/Gvz4XFSdCll00AJBhxXbVznrZgsYLVXS5r8fl1yckqZKRjoUA30O37VjX/A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Received: from IA3PR11MB9136.namprd11.prod.outlook.com (2603:10b6:208:574::12)
 by SJ0PR11MB6719.namprd11.prod.outlook.com (2603:10b6:a03:478::11)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9769.18; Thu, 2 Apr
 2026 09:30:16 +0000
Received: from IA3PR11MB9136.namprd11.prod.outlook.com
 ([fe80::37b4:37a9:4f3:518b]) by IA3PR11MB9136.namprd11.prod.outlook.com
 ([fe80::37b4:37a9:4f3:518b%5]) with mapi id 15.20.9769.011; Thu, 2 Apr 2026
 09:30:16 +0000
From: "Duan, Zhenzhong" <zhenzhong.duan@intel.com>
To: CLEMENT MATHIEU--DRIF <clement.mathieu--drif@bull.com>,
 "qemu-devel@nongnu.org" <qemu-devel@nongnu.org>
CC: "alex@shazbot.org" <alex@shazbot.org>, "clg@redhat.com" <clg@redhat.com>, 
 "eric.auger@redhat.com" <eric.auger@redhat.com>, "mst@redhat.com"
 <mst@redhat.com>, "jasowang@redhat.com" <jasowang@redhat.com>,
 "jgg@nvidia.com" <jgg@nvidia.com>, "nicolinc@nvidia.com"
 <nicolinc@nvidia.com>, "skolothumtho@nvidia.com" <skolothumtho@nvidia.com>,
 "joao.m.martins@oracle.com" <joao.m.martins@oracle.com>, "Tian, Kevin"
 <kevin.tian@intel.com>, "Liu, Yi L" <yi.l.liu@intel.com>, "Hao, Xudong"
 <xudong.hao@intel.com>
Subject: RE: [PATCH v1 11/13] intel_iommu_accel: drop _lock suffix in
 vtd_flush_host_piotlb_all_locked()
Thread-Topic: [PATCH v1 11/13] intel_iommu_accel: drop _lock suffix in
 vtd_flush_host_piotlb_all_locked()
Thread-Index: AQHcrRueV4S7cttZ6U6X0YZKvVaD9bW1kyWAgAAOusCAASn/8IARjtSAgAAGb3CAAaT2gIAADsPggAF/04CAABJpoA==
Date: Thu, 2 Apr 2026 09:30:16 +0000
Message-ID: <IA3PR11MB913636557EE4E37BDDEC1A049251A@IA3PR11MB9136.namprd11.prod.outlook.com>
References: <20260306034409.184873-1-zhenzhong.duan@intel.com>
 <20260306034409.184873-12-zhenzhong.duan@intel.com>
 <1b2b191e2f9f1315c883ed2de4fb9644a01c8713.camel@eviden.com>
 <IA3PR11MB9136F0D294E9FBE576E0CF91924FA@IA3PR11MB9136.namprd11.prod.outlook.com>
 <IA3PR11MB9136B3C106DDF70856F27FE6924CA@IA3PR11MB9136.namprd11.prod.outlook.com>
 <bdc0f51e1496c841a4f3392ec3e775e6a69b57e1.camel@eviden.com>
 <IA3PR11MB913601196392D72E02E5AB579253A@IA3PR11MB9136.namprd11.prod.outlook.com>
 <fb14a3f7f49e98683b666084aa3ae10b36ee4282.camel@eviden.com>
 <IA3PR11MB913614688F3DE7F70A09089A9250A@IA3PR11MB9136.namprd11.prod.outlook.com>
 <e2ef69de16fc315fdf0f1badd0119e47aeedc42e.camel@eviden.com>
In-Reply-To: <e2ef69de16fc315fdf0f1badd0119e47aeedc42e.camel@eviden.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: IA3PR11MB9136:EE_|SJ0PR11MB6719:EE_
x-ms-office365-filtering-correlation-id: 13d707c4-2d47-4264-1214-08de909a732a
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
 ARA:13230040|7416014|376014|1800799024|366016|38070700021|56012099003|22082099003|18002099003;
x-microsoft-antispam-message-info: D4xDL1DaZbKdpJu/i1hUEUPrilBDMm7QkCjDUN2Z5iWxExKG025V9z5KymUASYq7ExsP0kq9uI96GTCsa0n5//PE/CHw8dUdQ7sQ38mfx5jWu6d7WnfywZN6kvExIER28T8VS25DdsshcBEC6hCe+vM0LOfcF6OiilHi++npLzfuenFZ9qORaUKaR6dUjZjrMqThZcXSBlMQe/QYUcFflwiHoop8Kl1jBSGaWENehiN0DINUFRaG26iLVpINOWEtN7cngiQVzjIgnANMNs5AmnkmKsTj8QVtsK2IBqwRMwk62wqG0XiqD9SXhVfhf4r1a2M/21VtAGk0qUor1ijNNEDEwsOhZtvUsswpPSuSpkWgLWBzOr/lPMqRcPPHGjlBOwjKL2PCnPCVvciZwDMYJ+0bCuuelPN+BjeFsloSYwLmEYienOmyoTBuTFpiL0Y1Me+hA+vO0DBFaPuWoO3f8DN07aycfU2hLku3g4hiy3plLvzLekVylfzdyPw2acuy+yQ+ac15J9jg0yjYK28TNZVFtnM6otqhDLKPXMWsejzli4NAu4J42iVG1YXPmg95b8xu43/c1sOIOE4/3e1bolEzE9NvfhqbpaunvgwO/+ZAYjD0q1isAzJSAxji3+GlCKxwkQad/RzJEjDormn/UWDGowwmo3nAmP7zZ8FNPJmQPQ0fuG2jr5QzXbsfb+V0K1TqoBIqJMyIQVNlJkJiAvsJlZvOTSbtwHJEolbF9U8aeeMj5TZYBx8lXwnSbMmwifgxX/SkxurapH4u4MlBzmH+y4eTKCXWt2OMAd9LwaY=
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:IA3PR11MB9136.namprd11.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(7416014)(376014)(1800799024)(366016)(38070700021)(56012099003)(22082099003)(18002099003);
 DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?eml6dFdKQ0hHbnhSRitnVTNhQ0dtZmhFTURZOUlzZGJ5Wm9PWUZFOTYwOXJQ?=
 =?utf-8?B?QWc5MXlnN3NpUzRYOFpjRXJ4cGJzNE5sbXBvNEdTVDRyZ1diam5URzVvdlFM?=
 =?utf-8?B?U3R2eDFaRUdRMzdLZVlmZFYyYWp3a0tXWURxWGZKSDIxNVFnQ1lrZjFFcm1o?=
 =?utf-8?B?cE10YlpvRysyei9ZNllaYWp2NjV0Ym9iem1ML3FHQVNmUUdibXhaZ2J6c2Fs?=
 =?utf-8?B?a291Q1JoZytGZlBqWC81UStzY3VLVkhEZk41eitiL2cvZ0lIN0hPaEY5ZHZT?=
 =?utf-8?B?MU42cXRxbGQ0OFlCS1FYNE9rNFo0OU5HdkRQTlE1RDhIbm1zb0EyWjdCcDJE?=
 =?utf-8?B?eHJNODJNcUY1R3ArYmxTWDBLNy80bmhXY01sSXpJSWZGNmwxZkluS1h0V3pK?=
 =?utf-8?B?cWZWUWx5N2dHb1M1VC92YVBrQncxQk9COS9BSGgxYm1yekVSUzk1d0o2S0o5?=
 =?utf-8?B?S3dFVjBQUHdPZldzMFlkMGd5K1VkQThJeC9hazRKTEhSTEJFTFB5MXFDZ1hL?=
 =?utf-8?B?cGNWdVB1OTRkL2Z2QnZlZUw4d1lXcmhjeTdqZ0N4d1h3Y2VBVlBJUklTVTlQ?=
 =?utf-8?B?TjdQOVFqSy9Kcm5FUFM4ZEVEZGhaR291elBGTUo0enQ4bVBhamFreWJFeWg3?=
 =?utf-8?B?VmtUTzlUNloyblRhK2FrYytJQlpzM0hRODI4UTMzVlEwZUl4K1kzdEIrZjRM?=
 =?utf-8?B?OEw0YkgrNjBCdk95dENSVHlDVnhld3RlSm4xVWNyUk96QU1hWWNvU0s1bU04?=
 =?utf-8?B?WnN6bDE2TElPaFhkQmd2TDFqWjQwZ1J1K2MyUjA3MmtkbWkraUdKUm5mVTk4?=
 =?utf-8?B?NXNwdGtFN0g0WVEzdVRtWXlqYTlJSVBkQkk0L00xeksrcURJL3hPMHZScHBI?=
 =?utf-8?B?R2FadnRYUU5CMWdEbkJwTjZQLzZqSjdLK3g0Zy9FR3lTY0hmZitOUUZhVjhW?=
 =?utf-8?B?R3luMXVpcjhZdnE3amkrMmNrQTFPQUFFcTAxRUZDNTQxenFOSU94Vi9WeGJv?=
 =?utf-8?B?L3NTc2oyZGo5UUQraUl5dUdVemlWMW8yUy8wNHp4VHF2QWE1Q29MOTFRbGNs?=
 =?utf-8?B?bnB5WUNIZk1xb0pYelV6NFMvTy9hWDlyczI3KzhOKzZKYy9uOTlhbWxhTngw?=
 =?utf-8?B?N2lZemdmZTlhbU5EM0lGdUdIOUoxaHA0L1FuNlgxSFJsUEwvWjJzendEbGxR?=
 =?utf-8?B?NG5wbXFFdlNuZWpjWnZzSW9XNmp5eG96c3lheWlIeTFGL0x2NExzN2RJVjNa?=
 =?utf-8?B?SERwdDNvemtoOGNmNWI5WkhtTG8zcmU4blQrd3BHNXBDeDBxU29OYnFnVHpH?=
 =?utf-8?B?R3UzRENDb3BCWW0zVzdvLzdIVDlWNWRmVGhyY09jU0dUV2Q3d2hVM01ETVEz?=
 =?utf-8?B?ME9mdEZ3NVc0TGh1WWtBUTNQNzJzL1FIWUJFSThhU2lmUEwwNGZ0UkpSTmhU?=
 =?utf-8?B?RFlDK0ZMQ3RrWDFlYXZZR3dsQ29KTXVrY2NsdFdhV2VUcGhOY0MvU1JYWi9H?=
 =?utf-8?B?bkl3cjUybEZWVmhpc1J6eXNBQUEvTWQ5Y1oyTmhSTkt4c1R5anNaQ3phMXcw?=
 =?utf-8?B?ejA4eXNSckloRSt2UStqQmlWTzd5R3dLZXg2UTYvNHgvWlJydlNIQndwUzdO?=
 =?utf-8?B?UXBQOWU0SXc3dVlJYldZZllqMkdPOUV3ZGFSMGIrS3l4NENTTURsNTdmSXAx?=
 =?utf-8?B?WWJVS3Q2d3ozUmdNNlNDSG1ldFZTa0o2QVFPTFpwQWFSNTNFai9OSDZQdG53?=
 =?utf-8?B?RFliMmk2MUVFUi9jV0FBWU1YRVJTSTRpZWhWbWRySGo1UzJEa3FFeEJkRjdp?=
 =?utf-8?B?RTJDbUNIUmxSdm95WmNla3dIbGJnYjFGNkkxM3FGZkJyWDF3YkdSbFB3djhD?=
 =?utf-8?B?eW4ybE96WnV4NjdoemtJcG85eXFqWHptQk5Dd2NFdVg3WktMNWE0Q1g1MVRo?=
 =?utf-8?B?S2ZqZ1haODd6V0NrRFJuckt0dXBEZ01rQTlwUFd0cWRiWktiSjdpVy9zQXBj?=
 =?utf-8?B?T2VHN1V1VnRDc3FwbVJITG05WGFYdEE2OXNldHhNQW1jQVl2RkhubXU2TE51?=
 =?utf-8?B?YmlaZ1BjMmw1ajJKYmpmTklWSW56bWN5akFOWlBaSWJiaXoyeTVLNjlLTHlD?=
 =?utf-8?B?N3V1aTByU0FyUitOMWNMRjdEaExRZnpseUFNUk5hMWVNOGIrTFZnRWp2S2tD?=
 =?utf-8?B?UjhQakZpU3J2Z1ZXZnMxYXFGbTZQZzJOSHFjUWdWcmx4WUVVY1Eza2pMSXNJ?=
 =?utf-8?B?Q2w5ejE0Ull2VEhoWEdOUXp3SVJ2NXJFREI4NUFWdlZrNElpS25LeDRRSTdl?=
 =?utf-8?B?aEZqYzRLT0w5alJ4OXpEN1AvK1NwZHFKR3pzMmFuTlQzNDdNQnMzUT09?=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-Exchange-RoutingPolicyChecked: aISZ1Ecj3hJRc7DFuF8FX+OdwGquv6Abvsq4AZONIQpOta5Mj04l4cbNaRxbq22KSp88ZVD8jMbARv/pBpBd+L9vayiS9f3PniXIHh6Sr4OZDx2ASAp4Z+YT9U2HnHhf4yRxr/ClWjDknCG5/U/1Mok+bCz3p4XiUqpCFRtJQcZ0WpEdyqCGZSR068KE0NOvnKdKUzTzN92o0EBTVmN1M1f3MVc3iPqoC7inpZtMsZb6/c16QZSs8qc0GRWapNgmVolTqJS/S57mO7Ofz6JvpRogDmS7CjIJds2OwEh/5s9q3tgVNg5iMsDnIRqVDgcN1liQw/KlLpd/Sd9lMmV/gw==
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: IA3PR11MB9136.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 13d707c4-2d47-4264-1214-08de909a732a
X-MS-Exchange-CrossTenant-originalarrivaltime: 02 Apr 2026 09:30:16.4107 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 8jcSMiKYCVi359+K76cNj/2teBpEdr15mRO1X3SOu8scKae/A9JJ0wikswzyBuID4pj78IXOtMk0zwS7F55cCSvwwhyv3g2Uma4j7SuwHl0=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ0PR11MB6719
X-OriginatorOrg: intel.com
Received-SPF: pass client-ip=192.198.163.17;
 envelope-from=zhenzhong.duan@intel.com; helo=mgamail.intel.com
X-Spam_score_int: -28
X-Spam_score: -2.9
X-Spam_bar: --
X-Spam_report: (-2.9 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.54,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_MED=-2.3, RCVD_IN_VALIDITY_CERTIFIED_BLOCKED=1,
 RCVD_IN_VALIDITY_RPBL_BLOCKED=1, SPF_HELO_NONE=0.001,
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

DQoNCj4tLS0tLU9yaWdpbmFsIE1lc3NhZ2UtLS0tLQ0KPkZyb206IENMRU1FTlQgTUFUSElFVS0t
RFJJRiA8Y2xlbWVudC5tYXRoaWV1LS1kcmlmQGJ1bGwuY29tPg0KPlN1YmplY3Q6IFJlOiBbUEFU
Q0ggdjEgMTEvMTNdIGludGVsX2lvbW11X2FjY2VsOiBkcm9wIF9sb2NrIHN1ZmZpeCBpbg0KPnZ0
ZF9mbHVzaF9ob3N0X3Bpb3RsYl9hbGxfbG9ja2VkKCkNCj4NCj4NCj5PbiBXZWQsIDIwMjYtMDQt
MDEgYXQgMDk6MjMgKzAwMDAsIER1YW4sIFpoZW56aG9uZyB3cm90ZToNCj4+IEhpIENsZW1lbnQs
DQo+Pg0KPj4NCj4+ID4gLS0tLS1PcmlnaW5hbCBNZXNzYWdlLS0tLS0NCj4+ID4gRnJvbTogQ0xF
TUVOVCBNQVRISUVVLS1EUklGIDxbY2xlbWVudC5tYXRoaWV1LS0NCj5kcmlmQGJ1bGwuY29tXSht
YWlsdG86Y2xlbWVudC5tYXRoaWV1LS1kcmlmQGJ1bGwuY29tKT4NCj4+ID4gU3ViamVjdDogUmU6
IFtQQVRDSCB2MSAxMS8xM10gaW50ZWxfaW9tbXVfYWNjZWw6IGRyb3AgX2xvY2sgc3VmZml4IGlu
DQo+PiA+IHZ0ZF9mbHVzaF9ob3N0X3Bpb3RsYl9hbGxfbG9ja2VkKCkNCj4+ID4NCj4+ID4NCj4+
ID4gT24gVHVlLCAyMDI2LTAzLTMxIGF0IDA3OjE4ICswMDAwLCBEdWFuLCBaaGVuemhvbmcgd3Jv
dGU6DQo+PiA+DQo+PiA+ID4NCj4+ID4gPg0KPj4gPiA+DQo+PiA+ID4NCj4+ID4gPiA+IC0tLS0t
T3JpZ2luYWwgTWVzc2FnZS0tLS0tDQo+PiA+ID4gPiBGcm9tOiBDTEVNRU5UIE1BVEhJRVUtLURS
SUYgPFtjbGVtZW50Lm1hdGhpZXUtLQ0KPj4gPiA+DQo+PiA+DQo+PiA+IFtkcmlmQGJ1bGwuY29t
XShtYWlsdG86ZHJpZkBidWxsLmNvbSldKG1haWx0bzpbY2xlbWVudC5tYXRoaWV1LS0NCj5kcmlm
QGJ1bGwuY29tXShtYWlsdG86Y2xlbWVudC5tYXRoaWV1LS1kcmlmQGJ1bGwuY29tKSk+DQo+PiA+
DQo+PiA+ID4NCj4+ID4gPiA+IFN1YmplY3Q6IFJlOiBbUEFUQ0ggdjEgMTEvMTNdIGludGVsX2lv
bW11X2FjY2VsOiBkcm9wIF9sb2NrIHN1ZmZpeCBpbg0KPj4gPiA+ID4gdnRkX2ZsdXNoX2hvc3Rf
cGlvdGxiX2FsbF9sb2NrZWQoKQ0KPj4gPiA+ID4NCj4+ID4gPiA+DQo+PiA+ID4gPiBPbiBGcmks
IDIwMjYtMDMtMjAgYXQgMDQ6MDQgKzAwMDAsIER1YW4sIFpoZW56aG9uZyB3cm90ZToNCj4+ID4g
PiA+DQo+PiA+ID4gPg0KPj4gPiA+ID4gPiBIaSBDbGVtZW50LA0KPj4gPiA+ID4gPg0KPj4gPiA+
ID4gPg0KPj4gPiA+ID4gPg0KPj4gPiA+ID4gPg0KPj4gPiA+ID4gPiA+IC0tLS0tT3JpZ2luYWwg
TWVzc2FnZS0tLS0tDQo+PiA+ID4gPiA+ID4gRnJvbTogRHVhbiwgWmhlbnpob25nDQo+PiA+ID4g
PiA+ID4gU3ViamVjdDogUkU6IFtQQVRDSCB2MSAxMS8xM10gaW50ZWxfaW9tbXVfYWNjZWw6IGRy
b3AgX2xvY2sgc3VmZml4IGluDQo+PiA+ID4gPiA+ID4gdnRkX2ZsdXNoX2hvc3RfcGlvdGxiX2Fs
bF9sb2NrZWQoKQ0KPj4gPiA+ID4gPiA+DQo+PiA+ID4gPiA+ID4gSGkgQ2xlbWVudCwNCj4+ID4g
PiA+ID4gPg0KPj4gPiA+ID4gPiA+DQo+PiA+ID4gPiA+ID4NCj4+ID4gPiA+ID4gPg0KPj4gPiA+
ID4gPiA+ID4gLS0tLS1PcmlnaW5hbCBNZXNzYWdlLS0tLS0NCj4+ID4gPiA+ID4gPiA+IEZyb206
IENMRU1FTlQgTUFUSElFVS0tRFJJRiA8W2NsZW1lbnQubWF0aGlldS0tDQo+PiA+ID4gPiA+ID4N
Cj4+ID4gPiA+ID4gPg0KPj4gPiA+ID4gPg0KPj4gPiA+ID4gPg0KPj4gPiA+ID4NCj4+ID4gPiA+
DQo+PiA+ID4gPg0KPltbZHJpZkBidWxsLmNvbV0obWFpbHRvOmRyaWZAYnVsbC5jb20pXShtYWls
dG86W2RyaWZAYnVsbC5jb21dKG1haWx0bzpkcmlmQGJ1bGwuYw0KPm9tKSldKG1haWx0bzpbY2xl
bWVudC5tYXRoaWV1LS0NCj4+ID4gPg0KPj4gPg0KPj4gPiBbZHJpZkBidWxsLmNvbV0obWFpbHRv
OmRyaWZAYnVsbC5jb20pXShtYWlsdG86W2NsZW1lbnQubWF0aGlldS0tDQo+ZHJpZkBidWxsLmNv
bV0obWFpbHRvOmNsZW1lbnQubWF0aGlldS0tZHJpZkBidWxsLmNvbSkpKT4NCj4+ID4NCj4+ID4g
Pg0KPj4gPiA+ID4NCj4+ID4gPiA+DQo+PiA+ID4gPiA+DQo+PiA+ID4gPiA+DQo+PiA+ID4gPiA+
ID4NCj4+ID4gPiA+ID4gPg0KPj4gPiA+ID4gPiA+ID4gU3ViamVjdDogUmU6IFtQQVRDSCB2MSAx
MS8xM10gaW50ZWxfaW9tbXVfYWNjZWw6IGRyb3AgX2xvY2sgc3VmZml4IGluDQo+PiA+ID4gPiA+
ID4gPiB2dGRfZmx1c2hfaG9zdF9waW90bGJfYWxsX2xvY2tlZCgpDQo+PiA+ID4gPiA+ID4gPg0K
Pj4gPiA+ID4gPiA+ID4gdnRkX3Bpb3RsYl9wYWdlX2ludmFsaWRhdGUgY2FuIGJlIGNhbGxlZCBm
cm9tDQo+PiA+ID4gPiA+ID4gPiB2dGRfcHJpX3BlcmZvcm1faW1wbGljaXRfaW52YWxpZGF0aW9u
IHdpdGhvdXQgYW55IGxvY2suIFRodXMgd2UgY2FuDQo+Y2FsbA0KPj4gPiA+ID4gPiA+ID4gdnRk
X2ZsdXNoX2hvc3RfcGlvdGxiX2FsbF9hY2NlbCB1bmxvY2tlZC4gSXMgdGhlcmUgYSByaXNrIGlu
IGNhc2Ugb2YNCj4+ID4gPiA+ID4gPg0KPj4gPiA+ID4gPiA+DQo+PiA+ID4gPiA+DQo+PiA+ID4g
PiA+DQo+PiA+ID4gPg0KPj4gPiA+ID4NCj4+ID4gPiA+IGNvbmN1cnJlbnQgaG90DQo+PiA+ID4g
Pg0KPj4gPiA+ID4NCj4+ID4gPiA+ID4NCj4+ID4gPiA+ID4NCj4+ID4gPiA+ID4gPg0KPj4gPiA+
ID4gPiA+DQo+PiA+ID4gPiA+ID4gPiBwbHVnZ2luZyBvZiBhbm90aGVyIGRldmljZT8NCj4+ID4g
PiA+ID4gPg0KPj4gPiA+ID4gPiA+DQo+PiA+ID4gPiA+ID4NCj4+ID4gPiA+ID4gPg0KPj4gPiA+
ID4gPiA+IEdvb2QgY2F0Y2gsIGhvdHBsdWcgaXMgcHJvdGVjdGVkIGJ5IEJRTCwgYnV0IGlmIGFu
IGlvdGhyZWFkIGNvdWxkIHNlbmQNCj5QUkkNCj4+ID4gPiA+ID4NCj4+ID4gPiA+ID4NCj4+ID4g
PiA+DQo+PiA+ID4gPg0KPj4gPiA+ID4gcmVxdWVzdCwNCj4+ID4gPiA+DQo+PiA+ID4gPg0KPj4g
PiA+ID4gPg0KPj4gPiA+ID4gPg0KPj4gPiA+ID4gPiA+IHdlIHN1ZmZlciBmcm9tIHRoZSByYWNl
Lg0KPj4gPiA+ID4gPiA+DQo+PiA+ID4gPiA+ID4gSSB0aGluayB3ZSBjYW4gYnlwYXNzIHZ0ZF9w
cmlfcGVyZm9ybV9pbXBsaWNpdF9pbnZhbGlkYXRpb24oKSBmb3INCj4+ID4gPiA+ID4NCj4+ID4g
PiA+DQo+PiA+ID4NCj4+ID4NCj4+ID4gcGFzc3Rocm91Z2gNCj4+ID4NCj4+ID4gPg0KPj4gPiA+
ID4NCj4+ID4gPiA+ID4NCj4+ID4gPiA+ID4gPiBkZXZpY2UNCj4+ID4gPiA+ID4gPiB3aGljaCBk
b2Vzbid0IGNhY2hlIGlvdGxiIGVudHJ5IGluIFFFTVUgYnV0IGluIGhvc3QsIGxpa2U6DQo+PiA+
ID4gPiA+ID4NCj4+ID4gPiA+ID4gPiBAQCAtNTQwMSw3ICs1NDAxLDggQEAgc3RhdGljIGludCB2
dGRfcHJpX3JlcXVlc3RfcGFnZShQQ0lCdXMgKmJ1cywNCj4+ID4gPiA+ID4NCj4+ID4gPiA+DQo+
PiA+ID4NCj4+ID4NCj4+ID4gdm9pZA0KPj4gPg0KPj4gPiA+DQo+PiA+ID4gPg0KPj4gPiA+ID4g
Pg0KPj4gPiA+ID4gPiA+ICpvcGFxdWUsIGludCBkZXZmbiwNCj4+ID4gPiA+ID4gPiDCoMKgwqDC
oMKgwqDCoCByZXR1cm4gLUVOT1NQQzsNCj4+ID4gPiA+ID4gPiDCoMKgwqAgfQ0KPj4gPiA+ID4g
PiA+DQo+PiA+ID4gPiA+ID4gLcKgwqDCoCBpZiAodnRkX3ByaV9wZXJmb3JtX2ltcGxpY2l0X2lu
dmFsaWRhdGlvbih2dGRfYXMsIGFkZHIpKSB7DQo+PiA+ID4gPiA+ID4gK8KgwqDCoCBpZiAoIXZ0
ZF9maW5kX2hpb2RfaW9tbXVmZCh2dGRfYXMpICYmDQo+PiA+ID4gPiA+ID4gK8KgwqDCoMKgwqDC
oMKgIHZ0ZF9wcmlfcGVyZm9ybV9pbXBsaWNpdF9pbnZhbGlkYXRpb24odnRkX2FzLCBhZGRyKSkg
ew0KPj4gPiA+ID4gPiA+IMKgwqDCoMKgwqDCoMKgIHJldHVybiAtRUlOVkFMOw0KPj4gPiA+ID4g
PiA+IMKgwqDCoCB9DQo+PiA+ID4gPiA+DQo+PiA+ID4gPiA+DQo+PiA+ID4gPiA+DQo+PiA+ID4g
PiA+DQo+PiA+ID4gPiA+IEFmdGVyIGZ1cnRoZXIgdGhpbmtpbmcsIEkgZm91bmQgYWJvdmUgY2hh
bmdlIGRvZXNu4oCZdCByZXNvbHZlIHRoZSByYWNlIHlvdQ0KPj4gPiA+ID4NCj4+ID4gPiA+DQo+
PiA+ID4gPiBtZW50aW9uZWQuDQo+PiA+ID4gPg0KPj4gPiA+ID4NCj4+ID4gPiA+ID4NCj4+ID4g
PiA+ID4gQnV0IEkgdGhpbmsgdGhlIGlvdGhyZWFkIHNob3VsZCB0YWtlIEJRTCBiZWZvcmUNCj5j
YWxsaW5nIDo6cHJpX3JlcXVlc3RfcGFnZSgpLA0KPj4gPiA+ID4gPiBiZWNhdXNlIGl0IGlzIGEg
ZnVuY3Rpb24gY2hhbmdpbmcgdnRkIGRldmljZSBjb250ZXh0LCBlLmcuLCBQUVQgYW5kIFBSUw0K
Pj4gPiA+ID4NCj4+ID4gPg0KPj4gPg0KPj4gPiByZWdpc3RlciwNCj4+ID4NCj4+ID4gPg0KPj4g
PiA+ID4NCj4+ID4gPiA+ID4gcGFnZSBpbnZhbGlkYXRpb24gcXVldWUgYW5kIGlvdGxiIGVudHJp
ZXMuIFdlIHNob3VsZCBhbHdheXMgdGFrZSBCUUwNCj5iZWZvcmUNCj4+ID4gPiA+DQo+PiA+ID4g
Pg0KPj4gPiA+ID4gY2hhbmdpbmcNCj4+ID4gPiA+DQo+PiA+ID4gPg0KPj4gPiA+ID4gPiBjb250
ZXh0IG9mIGFueSBkZXZpY2UuIExldCBtZSBrbm93IGlmIHlvdSBoYXZlIGRpZmZlcmVudCBvcGlu
aW9ucy4NCj4+ID4gPiA+DQo+PiA+ID4gPg0KPj4gPiA+ID4NCj4+ID4gPiA+IERvIHlvdSBtZWFu
IHRoYXQgZXZlcnkgZW11bGF0ZWQgZGV2aWNlIHRoYXQgdHJpZ2dlcnMgYSBQUkkgcmVxdWVzdCBz
aG91bGQNCj4+ID4gPg0KPj4gPg0KPj4gPiBob2xkDQo+PiA+DQo+PiA+ID4NCj4+ID4gPiA+IHRo
ZSBCUUw/DQo+PiA+ID4gPiBJJ20gbm90IHN1cmUgdGhpcyBpcyBhIHZpYWJsZSBwYXR0ZXJuIGFz
IHRoZSBpbml0aWF0b3IgcHJvYmFibHkgYWxyZWFkeSBob2xkcyBhbg0KPj4gPiA+ID4gaW50ZXJu
YWwgbG9jaw0KPj4gPiA+ID4gYW5kIHRodXMgY2Fubm90IHRha2UgdGhlIEJRTCB3aXRob3V0IHJp
c2tpbmcgZGVhZGxvY2tzIHdpdGggY29uY3VycmVudA0KPj4gPiA+DQo+PiA+DQo+PiA+IE1NSU8g
Oi8NCj4+ID4NCj4+ID4gPg0KPj4gPiA+DQo+PiA+ID4gSUlVQywgcWVtdSBkb2Vzbid0IHN1cHBv
cnQgY29uY3VycmVudCBNTUlPIGVtdWxhdGlvbnMgeWV0LCB0aGV5IGFyZQ0KPnNlcmlhbGl6ZWQN
Cj4+ID4NCj4+ID4gYnkgQlFMLiBJZiB3ZSBkb24ndCB0YWtlIEJRTCBpbiBjYWxsIHNpdGUsIHRo
ZW4gd2UgbmVlZCBpdCBpbiBjYWxsZWUsIGxpa2U6DQo+PiA+DQo+PiA+ID4NCj4+ID4gPiBAQCAt
NTM1MSw2ICs1MzUxLDggQEAgc3RhdGljIGludCB2dGRfcHJpX3JlcXVlc3RfcGFnZShQQ0lCdXMg
KmJ1cywgdm9pZA0KPj4gPg0KPj4gPiAqb3BhcXVlLCBpbnQgZGV2Zm4sDQo+PiA+DQo+PiA+ID4g
wqDCoMKgwqAgSW50ZWxJT01NVVN0YXRlICpzID0gb3BhcXVlOw0KPj4gPiA+IMKgwqDCoMKgIFZU
REFkZHJlc3NTcGFjZSAqdnRkX2FzOw0KPj4gPiA+DQo+PiA+ID4gK8KgwqDCoCBCUUxfTE9DS19H
VUFSRCgpOw0KPj4gPiA+ICsNCj4+ID4gPiDCoMKgwqDCoCB2dGRfYXMgPSB2dGRfZmluZF9hZGRf
YXMocywgYnVzLCBkZXZmbiwgcGFzaWQpOw0KPj4gPiA+DQo+PiA+ID4gwqDCoMKgwqAgdWludDY0
X3QgcXVldWVfYWRkcl9yZWcgPSB2dGRfZ2V0X3F1YWQocywgRE1BUl9QUUFfUkVHKTsNCj4+ID4g
Pg0KPj4gPiA+DQo+PiA+ID4NCj4+ID4gPg0KPj4gPiA+ID4gT3RoZXJ3aXNlLCBpdCBtZWFucyB0
aGF0IHRoZSBkZXZpY2UgYWx3YXlzIHRha2VzIHRoZSBCUUwgYmVmb3JlIHRha2luZ8KgIGl0J3MN
Cj4+ID4gPg0KPj4gPg0KPj4gPiBvd24NCj4+ID4NCj4+ID4gPg0KPj4gPiA+ID4gbG9jay4NCj4+
ID4gPg0KPj4gPiA+DQo+PiA+ID4NCj4+ID4gPiBJIHRoaW5rIGl0J3MgdHJ1ZSBiZWNhdXNlIHdl
IGFsd2F5cyB0YWtlIEJRTCBiZWZvcmUgZW11bGF0aW9uIHN0YXJ0Lg0KPj4gPg0KPj4gPg0KPj4g
PiBUaGlzIGlzIHByZXR0eSBkYW5nZXJvdXMgSU1ITy4NCj4+ID4NCj4+ID4gVGhlIGVtdWxhdGVk
IGRldmljZSB0aGF0IGVuZHMgdXAgY2FsbGluZyB0aGlzIGZ1bmN0aW9uIHByb2JhYmx5IGhhcyBh
IGxvY2sgb24gaXRzDQo+PiA+IHNpZGUgYWxyZWFkeSwgbGV0J3MgY2FsbCBpdCBkZXZfbG9jay4N
Cj4+ID4NCj4+ID4gSSB0aGUgZGV2aWNlIGRvZXM6DQo+PiA+IAktIGxvY2soJmRldl9sb2NrKQ0K
Pj4gPiAJLSBzdGFydCBhIFBSSSByZXF1ZXN0DQo+PiA+IAktIGxvY2soJmJxbCkNCj4+DQo+Pg0K
Pj4gSSBoYXZlIHR3byBxdWVzdGlvbnM6DQo+Pg0KPj4gMS4gd2hpY2ggdGhyZWFkIG1heSBoYXZl
IGFib3ZlIHNlcXVlbmNlPw0KPj4gMi4gZG8gd2UgaGF2ZSB0byBwcm90ZWN0IFBSSSByZXF1ZXN0
IHdpdGggZGV2X2xvY2s/DQo+Pg0KPj4gUFJJIHN0YXRlIGlzIHByb3RlY3RlZCBieSBCUUwsIEkg
dGhpbmsgbm8gbmVlZCB0byBiZSBndWFyZGVkIGJ5IGRldl9sb2NrLiBNYXliZQ0KPnVubG9jayBk
ZXZfbG9jayBkdXJpbmcgUFJJPw0KPg0KPkRldmljZXMgdGhhdCBwZXJmb3JtIHN2bSBvcGVyYXRp
b25zIGluc3RlYWQgb2YgcmVndWxhciBkbWEgZW5kIHVwIHBlcmZvcm1pbmcgdGhpcw0KPmtpbmQg
b2Ygc2VxdWVuY2UuDQo+VGhlIGlzc3VlIGlzIHRoYXQgZGV2aWNlIHN0YXRlIGlzIGd1YXJkZWQg
YnkgdGhlIGRldmljZSBsb2NrLiBUaHVzLCB0YWtpbmcgdGhlIGJxbCBpbg0KPnRoZSBwcmkgY2Fs
bGJhY2sNCj5vZiB0aGUgaW9tbXUgcmVxdWlyZXMgdGhlIGRldmljZSB0byB1bmxvY2sgaXRzIG93
biBsb2NrIGJlZm9yZSBzdGFydGluZyB0aGUgUFJJDQo+b3BlcmF0aW9uIG9yIHRvIHJlbHkgb24N
Cj50aGUgYnFsIGFsbCB0aGUgdGltZSBpbnN0ZWFkIG9mIGl0cyBvd24gbG9jay4NCg0KWWVzLCB0
aGlzIGlzIGEgYml0IHRyaWNreS4NCg0KPg0KPkknbSBqdXN0IHRyeWluZyB0byBtYWtlIHN1cmUg
c3ZtIGRldmljZXMgd2lsbCBub3QgYmVjb21lIGltcG9zc2libGUgdG8gaW1wbGVtZW50DQo+anVz
dCBiZWNhdXNlIHRoZXkNCj5oYXZlIHRvIGJyZWFrIHRoZWlyIGZsb3cgYW5kIHVubG9jayBldmVy
eSB0aW1lIHRoZXkgdHJpZ2dlciBhIG1lbW9yeSBvcGVyYXRpb24uDQoNCk9LLCBpZiBkb24ndCB1
c2UgQlFMLCB3ZSBuZWVkIGFub3RoZXIgbG9jayB0byBwcm90ZWN0IFBSUSByZWxhdGVkIGRldmlj
ZSBzdGF0ZSwNCm9yIG1heWJlIGhhbmRsZSB0aGUgUFJJIHNlbmRpbmcgaW4gYm90dG9tIGhhbGYg
c28gd2UgZG9uJ3QgbmVlZCB0aGUgbG9jay4NCg0KQW55d2F5LCBpdCdzIG5vdCBhbiBpc3N1ZSB5
ZXQgdW50aWwgd2UgaGF2ZSBlbXVsYXRlZCBkZXZpY2Ugc3VwcG9ydGluZyBQUkkuDQoNCkZvciB0
aGUgcmFjZSB3aXRoIGRldmljZSBob3RwbHVnLCBJIGNhbiBkcm9wIHRoaXMgcGF0Y2gsIHRoZW4g
dGhlIGxvb3Agb24gcy0+dnRkX2hvc3RfaW9tbXVfZGV2DQp0aHJvdWdoIFBSSSBwYXRoIGlzIHN0
aWxsIHByb3RlY3RlZCBieSB2dGRfaW9tbXVfbG9jaygpLiBEb2VzIHRoYXQgbWFrZSBzZW5zZSBm
b3IgeW91Pw0KDQpUaGFua3MNClpoZW56aG9uZw0K

