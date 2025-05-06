Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 585A3C3ABC0
	for <qemu-devel@archiver.kernel.org>; Tue,  6 May 2025 09:26:10 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uCEYM-0002Q3-Da; Tue, 06 May 2025 05:25:30 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <zhenzhong.duan@intel.com>)
 id 1uCEYK-0002Pn-Np
 for qemu-devel@nongnu.org; Tue, 06 May 2025 05:25:29 -0400
Received: from mgamail.intel.com ([192.198.163.12])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <zhenzhong.duan@intel.com>)
 id 1uCEYG-0003fo-Sb
 for qemu-devel@nongnu.org; Tue, 06 May 2025 05:25:28 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1746523525; x=1778059525;
 h=from:to:cc:subject:date:message-id:references:
 in-reply-to:content-transfer-encoding:mime-version;
 bh=JwvtarslyNHiV8QQP2ReXiADF7SRgx/KK70BvJMxsMQ=;
 b=Y19qTdGj4dcwyCF9ROwczS2VoBXfN7+wALiJWuV6vwjcAV1KALUA1Yeo
 J8tnkzF3Pr0I1Jg22I2e+3e0oWaXP6LC6hyqwtrhVUiX52p2HGXwl1WUj
 MbpMSD5CuWnhJr+k+kWGduQ8HgC11u98y3a6OR3Lz5XSGEKpUWbpI3FA/
 BUCfiNLn9TuQ7EXTcYQWROufH8PLJepCwGa0HDMbtftK4b3rnWxyj7iOO
 qwelr+zFK545QOpWHTMWEQ8lJ9TIXFvw24VTMH8rfJxACpbQ97Ky+nPjr
 hnkYVwrzlU1el0HRQuc4wGvMmXhMD7TKG3xolzH49fL5DSo5ZYkozqzQg A==;
X-CSE-ConnectionGUID: lLSXz25JTQishOSrOSgvhQ==
X-CSE-MsgGUID: JdWzzxXlRXSgy/oWbWpA5Q==
X-IronPort-AV: E=McAfee;i="6700,10204,11424"; a="51985905"
X-IronPort-AV: E=Sophos;i="6.15,266,1739865600"; d="scan'208";a="51985905"
Received: from orviesa006.jf.intel.com ([10.64.159.146])
 by fmvoesa106.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 06 May 2025 02:25:10 -0700
X-CSE-ConnectionGUID: uYH6qFz1TMOGNQ4QMZvFzA==
X-CSE-MsgGUID: r8qZmZwpSE2DtvTcuvgdBQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.15,266,1739865600"; d="scan'208";a="135456947"
Received: from orsmsx902.amr.corp.intel.com ([10.22.229.24])
 by orviesa006.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 06 May 2025 02:25:10 -0700
Received: from ORSMSX902.amr.corp.intel.com (10.22.229.24) by
 ORSMSX902.amr.corp.intel.com (10.22.229.24) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.14; Tue, 6 May 2025 02:25:09 -0700
Received: from orsedg603.ED.cps.intel.com (10.7.248.4) by
 ORSMSX902.amr.corp.intel.com (10.22.229.24) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.14 via Frontend Transport; Tue, 6 May 2025 02:25:09 -0700
Received: from NAM12-DM6-obe.outbound.protection.outlook.com (104.47.59.171)
 by edgegateway.intel.com (134.134.137.100) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.44; Tue, 6 May 2025 02:25:09 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=QxYKYW2QdkOG8SnZrJ/swjA0XJo98oKbQxUBUXV07YY4vjEvpN58lWLOgxOksom53E2j9Rz9+5YlXwEuC0i8ey20JX6b7gZDfSIwTzQ8rCqzOhaBh9rNkH7JdZHrsGsfd0+yHJdH4Etlli6zAmVWcNNnp87GGe2Yu5h8ocV/lLEzroBUqosl2Lx44uhbdS5BEDb1GYp8hqoL03yBLOfas7OFYMtkZ/vuGQaUG/ZukpwlFC7ok5iQmIXEfmUcDekVKZeJ/855PhWllCp2Aw22+hemTm8zb9EsJIDySVuc/2cD46tI6BMtmjI5OLux392yJPtnfUMeI09qqzeFBsBqwg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=JwvtarslyNHiV8QQP2ReXiADF7SRgx/KK70BvJMxsMQ=;
 b=Eo4RnVr35eqeZNZbJJUKrljntO9gDEloLK1vNhrYMDzSZPOFFYFOO1S8AxsbTbfpZtWUtVszA2/XY84awmjp8G+qx3wzSx2/IjY1/XUAJFWoHXba1X4KZfjnixxwjit/JWHDof2y2wrHxlo7JzaMhLYQV/QQiy4MsE3YXWasoaHHPpw4Df37OWRoP/SHJe7+abkZE8/dGaq5ss12mpP6sofUpvyx1mi2VzBnEaDqRA30ixF80z/VtxWoG3+XzEEqOOcqcghgmB/xHEiv8qsf/k1JDIBZ3lhWtrPSmdhALmTFw195bdApoonpUjxJDEhFFMzt26vLrNUB/SxcZZOHEQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Received: from SJ0PR11MB6744.namprd11.prod.outlook.com (2603:10b6:a03:47d::10)
 by BL1PR11MB5270.namprd11.prod.outlook.com (2603:10b6:208:313::5)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8699.26; Tue, 6 May
 2025 09:25:06 +0000
Received: from SJ0PR11MB6744.namprd11.prod.outlook.com
 ([fe80::fe49:d628:48b1:6091]) by SJ0PR11MB6744.namprd11.prod.outlook.com
 ([fe80::fe49:d628:48b1:6091%4]) with mapi id 15.20.8699.022; Tue, 6 May 2025
 09:25:05 +0000
From: "Duan, Zhenzhong" <zhenzhong.duan@intel.com>
To: "eric.auger@redhat.com" <eric.auger@redhat.com>,
 =?utf-8?B?Q8OpZHJpYyBMZSBHb2F0ZXI=?= <clg@redhat.com>,
 "qemu-devel@nongnu.org" <qemu-devel@nongnu.org>
CC: "alex.williamson@redhat.com" <alex.williamson@redhat.com>,
 "nicolinc@nvidia.com" <nicolinc@nvidia.com>, "joao.m.martins@oracle.com"
 <joao.m.martins@oracle.com>, "Peng, Chao P" <chao.p.peng@intel.com>, "Liu, Yi
 L" <yi.l.liu@intel.com>
Subject: RE: [PATCH 1/5] vfio/iommufd: Save host iommu capabilities in
 VFIODevice.caps
Thread-Topic: [PATCH 1/5] vfio/iommufd: Save host iommu capabilities in
 VFIODevice.caps
Thread-Index: AQHbqstnyFbNUaToNUifB0k78FO5YLOeVAOAgCYIBYCAAPYMUA==
Date: Tue, 6 May 2025 09:25:05 +0000
Message-ID: <SJ0PR11MB6744427926074F6919D19DB392892@SJ0PR11MB6744.namprd11.prod.outlook.com>
References: <20250411101707.3460429-1-zhenzhong.duan@intel.com>
 <20250411101707.3460429-2-zhenzhong.duan@intel.com>
 <08b72d7a-2202-48bc-8b1b-78c93b3e7cfd@redhat.com>
 <e3882849-c769-4081-9872-7651d7092520@redhat.com>
In-Reply-To: <e3882849-c769-4081-9872-7651d7092520@redhat.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: SJ0PR11MB6744:EE_|BL1PR11MB5270:EE_
x-ms-office365-filtering-correlation-id: 0f49f3e7-f6db-4902-6dc7-08dd8c7fe311
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0; ARA:13230040|1800799024|376014|366016|38070700018;
x-microsoft-antispam-message-info: =?utf-8?B?Mi9MS1pNV2pQbFlibkQ3WXdGMlZWbnVKdGJtZ0IrbHp1MkRyeEtTdmFMRUJ4?=
 =?utf-8?B?S2JHbFl2MmZsN0hMdzZ1ZVpUcm4vZndCcjVpSUh6UXNhbVZhcFZkOXpBT2Yv?=
 =?utf-8?B?VG82ZHhYdWg5NjdSalVIMmxMc2l4NXpBTjEyZ3BuU0JKSUxoa1BsRGNKVkRo?=
 =?utf-8?B?WHV6c1ZIWWE1UDZybjZmcXVGUFQxZUJaazJZaDdwc0Ryb29uY0FyQ1p4OTRh?=
 =?utf-8?B?WTRjdE5iSFhGdFdBSmhmQTNLWjg0MmMvcFNwMXhReitkeDdrSHEzemJselM4?=
 =?utf-8?B?QS9jaTNvWjA3Rm9LSHhka0d6N2UwQStTYnJ1VFcyb2FUcU9oTjZZU1k5U0w4?=
 =?utf-8?B?a1Y5MjFwYUJ2cFFaVk5DSXNTU0lGWDd0SVNBSWIydVc2Vjg3ZDFmQWdlYU1J?=
 =?utf-8?B?ci8xL2p0akI1byt3QzhUMDluTy94KzdRNit0YzhnUDYyM1gyZFRxTlBZYlBy?=
 =?utf-8?B?MWVhNXBhWFZ2cTB6R0N5a0pzR0psS0szMDFLMWs0RnhGU3RLSG9lZFZKMG9j?=
 =?utf-8?B?RnR6SXhubkJSMUMwVnpoTVdxOTZsOTNXeVZxWSt4NllxZTNpL0RVREJqOStV?=
 =?utf-8?B?b3RMMlpVYWN1NkFsNGxUNGE5K0wwR0JvSnRhdEpGNG1ldGo2RnZ0UjE1Kzdm?=
 =?utf-8?B?UWNjc3NEWVEwT1lVVVRrZUNyUTJIMDdnZFRYY2RDR0Mra2RVTGswWGFkQ3Fw?=
 =?utf-8?B?ZkdhSTFUTU9Id2YycFZtejlMMmVyMTlnekN4ODY2dTJTcFVjeXZZK1hOYnhz?=
 =?utf-8?B?R0ZsTHNkMkptajdzZTc0YVU3aEt5bUtTb1BPUHhnOXZPZy9jNWpUN3p3NHVU?=
 =?utf-8?B?NEhKbzRHdEtITStQL1FTRlBjN3kzNEtIOFdYZFFpN0RlVERUTTVWNTh1enJr?=
 =?utf-8?B?NVNGYUx2Y04wSng0YnlRd29KOU1PeFQwV1BhLzZoN1o1cSsrUFMxY3RsV0Mz?=
 =?utf-8?B?VW1HbE1KOGJMU0xvUytrVWV5MTlBZFZaZ05wWlpQY2ZEcjNoZ29vSmdIaXFx?=
 =?utf-8?B?ODk1RFRJOHFHZUhzaDkwcXBlTVhnUkVJYWpOaXU2R2lNbnlHR3JhdU44OWVx?=
 =?utf-8?B?RGgxUktZeG90aVA0UUtBUTMvVkpGSkwvQkdOUnFEMXdYeFRrTFU5bGo1YU14?=
 =?utf-8?B?Q1BuNEN6N0lqaUpNVEh5NGJ1ZzVGbVR4MmtPR2Z5TUFHdDMrYjhBWmJsalc4?=
 =?utf-8?B?ZzE2VVova2Y3ZHJxcXo0aklNeFpXUDRDS290WEJkYUY2bVdkaW1Lc2l0THVK?=
 =?utf-8?B?ZE56RzN2RkVOdW1zT0cyaXJ3b3p2dytVVG0yU0JnTDdqYzByL3M4ZWlPYWY5?=
 =?utf-8?B?VnJKSkdyTkoySmxxYTdVR05xZDBydXo1SXFEeStjU1BHMEhZSHdsVWgrdXZi?=
 =?utf-8?B?UE9LcXhOSGJ5a0dMbi92aXBBQ1Njd3l4L3h5UlVubi9HVVd4aHBnbXJEd0Jz?=
 =?utf-8?B?OHEycGYxSjhGK0U5cXI0V3RtK0t6MmNzMGFjRlFxbElWR3A5VlVYbVpVMXdp?=
 =?utf-8?B?Uk9NTU5ERnpFWDBsNlQ5b1prNVJnUUxhNUttWWVnRmhTREZ3bDQwNjJ3OWxo?=
 =?utf-8?B?SGpmbkd2WmVpaWJFQlc5UjVNYXA4dUtFYktSZ3J3VmNDWjZBaytRS0gzeUZC?=
 =?utf-8?B?SHc4ZmVhR2s4aU1oMUVBWU9EaDBOcHNvYmVGL2FUQ3BFcWg0N1lDUTRuQnVO?=
 =?utf-8?B?aTByQmhYbkRmZ1NHOVdXYzdiYnEzM0prS1ZBcnJlSW9qYUJ2SmxIQ2Y2UU1s?=
 =?utf-8?B?YStveXBTVHhnTGM4bFcvUUNlK29QcWhUR3VMNzY4R05xTU94dzQzS05nVFdO?=
 =?utf-8?B?ajNhU2xlTkRQWGhlVlpVSnJXVm1leW1weTZsOWV0R0RjWjBxUUg1TjFlQndq?=
 =?utf-8?B?ekJOb0hmRmxCaVJERGNJVlVEaWYwU0I1ZE9lcWN0K28zSkx2dlNrSUZ4bWNS?=
 =?utf-8?B?UzQySmI5Q0dWRzVkUWFDcFBycWU0ZWFqcVFvdjRvSm1hVjVDQzRTU0Vvaktq?=
 =?utf-8?Q?t5urLQ3Mec7pZeFy6XFB5HGPPLon6k=3D?=
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:SJ0PR11MB6744.namprd11.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(1800799024)(376014)(366016)(38070700018); DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?bVE2ZnpGWmx4U0VGYVE5M2loVnZPVjV0dHhpQnJCVG9HSjRINlpFZUlZTjEz?=
 =?utf-8?B?WXZsbkNzT1ZwSzcxVHpKcU16M3BjSzM3Y3pEWmpqSlFkMlRvM25IVWRvcTFr?=
 =?utf-8?B?bFJkZ25EUW9uRzFSN0FhbWdCVGllWm9aZVpKT3VlQnIrT3NwUW5GUDNNMWx1?=
 =?utf-8?B?QmFQU1ErS1Q3RXZVa01OdjZ1UEphTmlQK1JtNFdCc3NNL0NWVlJGS2YzdTZ0?=
 =?utf-8?B?Y1JzMi95c3ZPRlNQYTV0Y01yRXd1SGtoNDZkWTFrSUVBdzZhNHlwcTYxbUtQ?=
 =?utf-8?B?a2xBbWtUSkMyVkpRVXVZdGJxL2hRQmltNi90ODVWdmZPeDNvMXhkSnFqSXhj?=
 =?utf-8?B?eWtpYXFZT3FUekVnVmpoVEdjdWs2TE9MMWtVbTJCOTQ1Wm1FUFRTb3YvcWVp?=
 =?utf-8?B?aGlkWjV1RU9Hc1lxOHVERjhJd0V3MlpVU3dJNEE2M3ViT3oyY3B5bG8vS1Jr?=
 =?utf-8?B?Y1kyVDljMXZIOVBSVnM5Wk95NENuOEhObS9INUZFWEdWdDd6Vlcrd0tWVDZx?=
 =?utf-8?B?UmhoenBWUmxTRnZJSUFNcms0SEdSdHBsRmR5R2d5d1ZMRWRQeHphaGRHanAw?=
 =?utf-8?B?a0VrK2wxZWdHS3dNZGxzRzBtdVRjQXY0N0U2VmhtMnlZYTM1Vkd4WDdZSndq?=
 =?utf-8?B?N3NxY3V2S2VXTEQ3Qzk1Y0NBYjFGZkppYnFZWC9VcWNhR1huVERwYlpKNExZ?=
 =?utf-8?B?cldDVmVuR3RZR3AyQURYdGVOak5yWUNiRkdhaFM3Q3pBZE9KNGh6bzRheGVz?=
 =?utf-8?B?dWtYYkVKNmd0MVVqd2wwWU10K25kOXFMak1HbkxjdU4rOFE0a3JFbDBabnh2?=
 =?utf-8?B?NlUwNUdWeTJHUUo2OXpYdXZScC9BRmd3dFl4WXg2QnhGcWtWbWloYjJueEJh?=
 =?utf-8?B?QnBUczlwcksycktLUGgvK2dtM25BTllRbllORzEzbEZBS1JhVlRRQmV4aWVW?=
 =?utf-8?B?UHFJNlF6b1lkZWdWcjA2cjQxakJvMC9WdDZjaHZrWjFHYXpDZU9pdXpUdnlm?=
 =?utf-8?B?TEpnWU1NOTJVdEJwaHJCQUUramZ1dlEwYzF3UTVTcmtCeGxFRUVyYXNWVWhJ?=
 =?utf-8?B?b2RrTFhsdE1JSllodFB4RnR5N1NvZnh3QnY2dloxQkZzdmdWNVVHMk5aOHp4?=
 =?utf-8?B?QWNlZ3lYTUpPQXhDcVZOcVA4MVMrREZpbzNSaWJDZlo0MzlPZ1A0Zy9zMnJj?=
 =?utf-8?B?cVc0Wm1DblBsTVpqbHFSYUNTdWxNc2IxNEtzcW1zaFl2QjJWK3R0UVRuSDk5?=
 =?utf-8?B?aXMrdmZrRDlGYVEwaEd4TUdHNUI2RzdzbTlkaGNCemQxV1Rqc3RMTnlpcTd5?=
 =?utf-8?B?c0pIWlk1ai9GQml2dlZ5M3F2eVkrMVpUNTZTcnNXWFNyNnhNT2lGcTl6aHpD?=
 =?utf-8?B?L3NRNUQySHFwWUJaVm5rZzlXQzlDVGVqWkRtL3EwU0FDMU1mSXpsMnNRN0dv?=
 =?utf-8?B?dVFsRklWMDlCYjVGWmhZSDJIMjNxN082USt1Y202MG9FVmV0WVdIMzNQc1Za?=
 =?utf-8?B?dG9kWnJTcmhoa2w2bmh4SE03YWVHMVc5SHcvYTNIWTlRbjUrUE8rdnk4T3JH?=
 =?utf-8?B?b2NzQ1JnT21OSDRKLzBRWThCeHBaUmVOUERNbDZEVUhwT1hsYUJyNXppSERJ?=
 =?utf-8?B?OVFzNmsyWVpaQ3JFYmM1ak93VmVVUGc4LzlUc09CclpVZHE2akNXR3ZEcmxO?=
 =?utf-8?B?MDVYZ1UydHgzNDVjdkpxU29OSDArYWRCOWlNak1Cb0ZxTnhqMlk3T3lKdnRl?=
 =?utf-8?B?cWs4R2hzaTB5ZHd3ZkYwZVRkT2xqMEUwWi94K2tiSXc3anNudGxJZ3BwQ0RY?=
 =?utf-8?B?WStqSnVXajA2UzJQZ1Z1bFRSL2M4Nlg5T0hGR0FjM1pWZXdrZjRKY2JBREZW?=
 =?utf-8?B?U2pGZm5PdUVaYUxBZzRmUnovaW5Oajl5LzhySllnVXRsZEMyN0V1aXJNYkpS?=
 =?utf-8?B?MkhYcExaRzBBWFhPZ3dCbEV6UnorWVo0UW5CeFg0ZlNsSSsrbUZ3WmtEUnNT?=
 =?utf-8?B?QjdIeCtid2lLY2M3N1BZS0MxQlBqbysvZmlWZklzUXlLUjlKMjY0OXdha2Fu?=
 =?utf-8?B?cElTcDM5bjA2ZHA5ZGZCZ1BlZm43Q1dOY2xYL3h6eHZ1L2NGcTNIdnNHQjAx?=
 =?utf-8?Q?1k7tnI9gYI6XfZwzV8+Vo9eNA?=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: SJ0PR11MB6744.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 0f49f3e7-f6db-4902-6dc7-08dd8c7fe311
X-MS-Exchange-CrossTenant-originalarrivaltime: 06 May 2025 09:25:05.4560 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 6dYWa/lMNuuqnV7e1UbpWZwSsFgry/FH55u3dsP87QC4eIQ6vhyxoQeZsMCuS8rrMlKlUXrPblgwYJqKKc5BIqbZcgBZSoEgwwQq2kBjJWk=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BL1PR11MB5270
X-OriginatorOrg: intel.com
Received-SPF: pass client-ip=192.198.163.12;
 envelope-from=zhenzhong.duan@intel.com; helo=mgamail.intel.com
X-Spam_score_int: -57
X-Spam_score: -5.8
X-Spam_bar: -----
X-Spam_report: (-5.8 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-1.414,
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
ciA8ZXJpYy5hdWdlckByZWRoYXQuY29tPg0KPlNlbnQ6IFR1ZXNkYXksIE1heSA2LCAyMDI1IDEy
OjE1IEFNDQo+VG86IEPDqWRyaWMgTGUgR29hdGVyIDxjbGdAcmVkaGF0LmNvbT47IER1YW4sIFpo
ZW56aG9uZw0KPjx6aGVuemhvbmcuZHVhbkBpbnRlbC5jb20+OyBxZW11LWRldmVsQG5vbmdudS5v
cmcNCj5DYzogYWxleC53aWxsaWFtc29uQHJlZGhhdC5jb207IG5pY29saW5jQG52aWRpYS5jb207
DQo+am9hby5tLm1hcnRpbnNAb3JhY2xlLmNvbTsgUGVuZywgQ2hhbyBQIDxjaGFvLnAucGVuZ0Bp
bnRlbC5jb20+OyBMaXUsIFlpIEwNCj48eWkubC5saXVAaW50ZWwuY29tPg0KPlN1YmplY3Q6IFJl
OiBbUEFUQ0ggMS81XSB2ZmlvL2lvbW11ZmQ6IFNhdmUgaG9zdCBpb21tdSBjYXBhYmlsaXRpZXMg
aW4NCj5WRklPRGV2aWNlLmNhcHMNCj4NCj5IaSBaaGVuemhvbmcsDQo+DQo+T24gNC8xMS8yNSAx
OjI4IFBNLCBDw6lkcmljIExlIEdvYXRlciB3cm90ZToNCj4+IE9uIDQvMTEvMjUgMTI6MTcsIFpo
ZW56aG9uZyBEdWFuIHdyb3RlOg0KPj4+IFRoZSBzYXZlZCBjYXBzIGNvcHkgY2FuIGJlIHVzZWQg
dG8gY2hlY2sgZGlydHkgdHJhY2tpbmcgY2FwYWJpbGl0eS4NCj4+Pg0KPj4+IFRoZSBjYXBhYmls
aXRpZXMgaXMgZ290dGVuIHRocm91Z2ggSU9NTVVGRCBpbnRlcmZhY2UsIHNvIGRlZmluZSBhDQo+
Pj4gbmV3IHN0cnVjdHVyZSBIb3N0SU9NTVVEZXZpY2VJT01NVUZEQ2FwcyB3aGljaCBjb250YWlu
cyB2ZW5kb3INCj4+PiBjYXBzIHJhdyBkYXRhIGluICJpbmNsdWRlL3N5c3RlbS9pb21tdWZkLmgi
Lg0KPj4+DQo+Pj4gVGhpcyBpcyBhIHByZXBhcmUgd29yayBmb3IgbW92aW5nIC5yZWFsaXplKCkg
YWZ0ZXIgLmF0dGFjaF9kZXZpY2UoKS4NCj4+Pg0KPj4+IFN1Z2dlc3RlZC1ieTogQ8OpZHJpYyBM
ZSBHb2F0ZXIgPGNsZ0ByZWRoYXQuY29tPg0KPj4+IFN1Z2dlc3RlZC1ieTogRXJpYyBBdWdlciA8
ZXJpYy5hdWdlckByZWRoYXQuY29tPg0KPj4+IFN1Z2dlc3RlZC1ieTogTmljb2xpbiBDaGVuIDxu
aWNvbGluY0BudmlkaWEuY29tPg0KPj4+IFNpZ25lZC1vZmYtYnk6IFpoZW56aG9uZyBEdWFuIDx6
aGVuemhvbmcuZHVhbkBpbnRlbC5jb20+DQo+Pj4gLS0tDQo+Pj4gwqAgaW5jbHVkZS9ody92Zmlv
L3ZmaW8tZGV2aWNlLmggfMKgIDEgKw0KPj4+IMKgIGluY2x1ZGUvc3lzdGVtL2lvbW11ZmQuaMKg
wqDCoMKgwqAgfCAyMiArKysrKysrKysrKysrKysrKysrKysrDQo+Pj4gwqAgaHcvdmZpby9pb21t
dWZkLmPCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqAgfCAxMCArKysrKysrKystDQo+Pj4gwqAgMyBm
aWxlcyBjaGFuZ2VkLCAzMiBpbnNlcnRpb25zKCspLCAxIGRlbGV0aW9uKC0pDQo+Pj4NCj4+PiBk
aWZmIC0tZ2l0IGEvaW5jbHVkZS9ody92ZmlvL3ZmaW8tZGV2aWNlLmgNCj4+PiBiL2luY2x1ZGUv
aHcvdmZpby92ZmlvLWRldmljZS5oDQo+Pj4gaW5kZXggNjY3OTdiNGM5Mi4uMDlhN2FmODkxYSAx
MDA2NDQNCj4+PiAtLS0gYS9pbmNsdWRlL2h3L3ZmaW8vdmZpby1kZXZpY2UuaA0KPj4+ICsrKyBi
L2luY2x1ZGUvaHcvdmZpby92ZmlvLWRldmljZS5oDQo+Pj4gQEAgLTc3LDYgKzc3LDcgQEAgdHlw
ZWRlZiBzdHJ1Y3QgVkZJT0RldmljZSB7DQo+Pj4gwqDCoMKgwqDCoCBib29sIGRpcnR5X3RyYWNr
aW5nOyAvKiBQcm90ZWN0ZWQgYnkgQlFMICovDQo+Pj4gwqDCoMKgwqDCoCBib29sIGlvbW11X2Rp
cnR5X3RyYWNraW5nOw0KPj4+IMKgwqDCoMKgwqAgSG9zdElPTU1VRGV2aWNlICpoaW9kOw0KPj4+
ICvCoMKgwqAgSG9zdElPTU1VRGV2aWNlSU9NTVVGRENhcHMgY2FwczsNCj4+DQo+PiBJTU8sIHRo
ZXNlIGNhcGFiaWxpdGllcyBiZWxvbmcgdG8gSG9zdElPTU1VRGV2aWNlIGFuZCBub3QgVkZJT0Rl
dmljZS4NCj5JIGRvIGFncmVlIHdpdGggQ8OpZHJpYyB0aGF0IGl0IGxvb2tzIGEgd3JvbmcgcGxh
Y2UgdG8gcHV0IHRoaXMgY2Fwcy4gSQ0KPmZlZWwgdGhpcyBzb21laG93IGJyZWFrcyB0aGUgYWJz
dHJhY3Rpb24gbGF5ZXJpbmcuDQoNClRoaXMgY2hhbmdlIHdhcyBkcm9wcGVkIGluICJbUEFUQ0gg
djIgMC81XSB2ZmlvOiBNb3ZlIHJlYWxpemUgYWZ0ZXIgYXR0YWNoX2RldiIuDQoNCj4NCj5Ob3cg
IltQQVRDSCB2MiAwLzVdIHZmaW86IE1vdmUgcmVhbGl6ZSBhZnRlciBhdHRhY2hfZGV2IiBoYXMg
bGFuZGVkLCBJDQo+dGhpbmsgaXQgd291bGQgaGVscCBpZiB5b3UgY291bGQgcmVzcGluIHdpdGgg
YSBjbGVhciBmdW5jdGlvbmFsIGdvYWwNCj5zdWNoIGFzIHRoZSBvbmUgdGFyZ2V0ZWQgaW5bUEFU
Q0ggdjIgMC81XSBDaGVjayBob3N0IElPTU1VIGNvbXBhdGlsaWJpdHkNCj53aXRoIHZJT01NVQ0K
PjxodHRwczovL2xvcmUua2VybmVsLm9yZy9hbGwvMjAyNDA0MDgwODQ0MDQuMTExMTYyOC0xLQ0K
PnpoZW56aG9uZy5kdWFuQGludGVsLmNvbS8+DQoNClNlZSBhIHJmY3YzIGNhbmRpZGF0ZSBhdCBs
aW5rIGh0dHBzOi8vZ2l0aHViLmNvbS95aWxpdTE3NjUvcWVtdS9jb21taXRzL3poZW56aG9uZy9p
b21tdWZkX25lc3RpbmdfcmZjdjMud2lwLyBmb3IgZXhhbXBsZSBpbXBsZW1lbnRhdGlvbi4NCg0K
SW4gdGhpcyBleGFtcGxlLCBJIHVzZWQgLmdldF9jYXAoKSBpbnRlcmZhY2UgZm9yIHZJT01NVSB0
byBnZXQgY2FwLiANCnZJT01NVSBjb3VsZCBhbHNvIGFjY2VzcyBIb3N0SU9NTVVEZXZpY2U6Okhv
c3RJT01NVURldmljZUNhcHMNCmRpcmVjdGx5IGFzIGl0J3MgcGFzc2VkIGZyb20gVkZJTyB0byB2
SU9NTVUgYWxvbmcgd2l0aCBIb3N0SU9NTVVEZXZpY2UuDQoNClRoYW5rcw0KWmhlbnpob25nDQo=

