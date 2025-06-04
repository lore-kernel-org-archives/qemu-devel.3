Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C3C8EC5B549
	for <qemu-devel@archiver.kernel.org>; Wed,  4 Jun 2025 03:42:14 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uMf0Q-0007qx-Gf; Tue, 03 Jun 2025 23:41:34 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <zhenzhong.duan@intel.com>)
 id 1uMf0O-0007qT-07
 for qemu-devel@nongnu.org; Tue, 03 Jun 2025 23:41:33 -0400
Received: from mgamail.intel.com ([192.198.163.11])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <zhenzhong.duan@intel.com>)
 id 1uMf0L-0005YU-Ns
 for qemu-devel@nongnu.org; Tue, 03 Jun 2025 23:41:31 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1749008490; x=1780544490;
 h=from:to:cc:subject:date:message-id:references:
 in-reply-to:content-transfer-encoding:mime-version;
 bh=pvDvLgkE6UAs5N2CcADp4gb49HJWlF7O0zkB2plcDOI=;
 b=gjGb8blqCLIZKIpyIS3si2pYTujdLwM6IO7dv2xc4rIHbuKFO0ubVbmr
 dzUniYviTriRxl7i8c436itXvqXsTKEKgHfioHxLjEWbRelqtbRqFGE/7
 q8vFPaKCDOGQAxyghoSAQpGDq8PAK5gQGywmjkFd2tLqD2ieOEHaPZwH7
 /tu4G5/etdza6SvaJtS2crgyr+L0iSh4m5NVvIfgdiv/6Nvh7taEY+DZb
 jp6zI+4DbxylX8qtNZxOyt9A5LLiSfRfzwn6+u0dnWU1Hz9FiqfXVXCjM
 wo9ynDODNctQ8p/iWP1lj20kEUTdcV3Se2nKTGk7aPNNZFnsZbeMLPMll Q==;
X-CSE-ConnectionGUID: hwGMChxtSIiDPBLP29dOCQ==
X-CSE-MsgGUID: g4OZlr1eRXuDWHa41x/Tsw==
X-IronPort-AV: E=McAfee;i="6700,10204,11453"; a="61693686"
X-IronPort-AV: E=Sophos;i="6.16,208,1744095600"; d="scan'208";a="61693686"
Received: from fmviesa006.fm.intel.com ([10.60.135.146])
 by fmvoesa105.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 03 Jun 2025 20:41:25 -0700
X-CSE-ConnectionGUID: VVgnMJXdSTCjhuRDhUhnaA==
X-CSE-MsgGUID: 5gfK3ohXSUOp9LwLVF9Law==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.16,208,1744095600"; d="scan'208";a="144925180"
Received: from orsmsx903.amr.corp.intel.com ([10.22.229.25])
 by fmviesa006.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 03 Jun 2025 20:41:24 -0700
Received: from ORSMSX901.amr.corp.intel.com (10.22.229.23) by
 ORSMSX903.amr.corp.intel.com (10.22.229.25) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.25; Tue, 3 Jun 2025 20:41:23 -0700
Received: from orsedg603.ED.cps.intel.com (10.7.248.4) by
 ORSMSX901.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.25 via Frontend Transport; Tue, 3 Jun 2025 20:41:23 -0700
Received: from NAM11-CO1-obe.outbound.protection.outlook.com (40.107.220.59)
 by edgegateway.intel.com (134.134.137.100) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.55; Tue, 3 Jun 2025 20:41:23 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=tHgUGvRZWetAyLf7pMFxWgJIp18U81SkX8V3nYo2I0dhqKToZlEEU0OK3moNkPkLjC3BFVVMf0bYE6VJtyuw93Ed8xFINGFy4Rb94xodPDXl+2xd9bV2CT2W1uy1PzcprBfFovGQc6ui+K+rSd7/EbbfoWXBXa/vL3OZxyMeHDU0uXgtKr58AEud1FygtRhLjV/GtQRQB4nJDXKL3PmV+BcecS21rhvyUYUJv+jHT858OVg/JvO5b/UofoghH6ONxr7/6Nk5QnLxR+EowoCI3rsHIrJY0bU+eKEr4i3t29fG/huaNo7W+Zdrz1lIrj9PYJDhoq+Z/XUgalxQ6EnUSQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=pvDvLgkE6UAs5N2CcADp4gb49HJWlF7O0zkB2plcDOI=;
 b=A1Q0fqM5NuR1Bpec/++Ip++yZKnWGen0i+49MLmz9o2d65wnGbaxuswROCI+n2yPfPwj7YaRG//1Dk7/9BMB1Kv3IbosOIgDCzDFRmCkg9dpNanVKfjAmd7UqAYTF67Ew6xNCcnyJYfJ9kl5JjpkYWbVj25r7pXN6VJPJ/+pP3yEqfgtinQoE1mZkiEz67mpVVLoniE97SWxnfX5v+RXdAM9owc56RiCTBaayL9aORzXQ7CFq3VtLdFqGwvKarCiQJ84Y5kCP2LBIGrrHnshXnHvbJJxRzGIFe13f0TFSwEgTOIi8SAOeJDvP052AGLTtQ03XJKFo6PFfYIfUiU7pw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Received: from IA3PR11MB9136.namprd11.prod.outlook.com (2603:10b6:208:574::12)
 by DM4PR11MB7253.namprd11.prod.outlook.com (2603:10b6:8:10f::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8792.34; Wed, 4 Jun
 2025 03:41:21 +0000
Received: from IA3PR11MB9136.namprd11.prod.outlook.com
 ([fe80::604b:77a4:b1be:3f13]) by IA3PR11MB9136.namprd11.prod.outlook.com
 ([fe80::604b:77a4:b1be:3f13%4]) with mapi id 15.20.8769.037; Wed, 4 Jun 2025
 03:41:21 +0000
From: "Duan, Zhenzhong" <zhenzhong.duan@intel.com>
To: "eric.auger@redhat.com" <eric.auger@redhat.com>, "qemu-devel@nongnu.org"
 <qemu-devel@nongnu.org>
CC: "alex.williamson@redhat.com" <alex.williamson@redhat.com>,
 "clg@redhat.com" <clg@redhat.com>, "mst@redhat.com" <mst@redhat.com>,
 "jasowang@redhat.com" <jasowang@redhat.com>, "peterx@redhat.com"
 <peterx@redhat.com>, "ddutile@redhat.com" <ddutile@redhat.com>,
 "jgg@nvidia.com" <jgg@nvidia.com>, "nicolinc@nvidia.com"
 <nicolinc@nvidia.com>, "shameerali.kolothum.thodi@huawei.com"
 <shameerali.kolothum.thodi@huawei.com>, "joao.m.martins@oracle.com"
 <joao.m.martins@oracle.com>, "clement.mathieu--drif@eviden.com"
 <clement.mathieu--drif@eviden.com>, "Tian, Kevin" <kevin.tian@intel.com>,
 "Liu, Yi L" <yi.l.liu@intel.com>, "Peng, Chao P" <chao.p.peng@intel.com>
Subject: RE: [PATCH v2 4/4] vfio/iommufd: Save vendor specific device info
Thread-Topic: [PATCH v2 4/4] vfio/iommufd: Save vendor specific device info
Thread-Index: AQHb0Ua612Cm81Yp40OXGB9SHe7n8rPxZrYAgAD7fgA=
Date: Wed, 4 Jun 2025 03:41:21 +0000
Message-ID: <IA3PR11MB9136157971C78CC5C3CBE563926CA@IA3PR11MB9136.namprd11.prod.outlook.com>
References: <20250530093512.3959484-1-zhenzhong.duan@intel.com>
 <20250530093512.3959484-5-zhenzhong.duan@intel.com>
 <5fa661fe-5400-4d13-8ba8-ce15f806b017@redhat.com>
In-Reply-To: <5fa661fe-5400-4d13-8ba8-ce15f806b017@redhat.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: IA3PR11MB9136:EE_|DM4PR11MB7253:EE_
x-ms-office365-filtering-correlation-id: a92b754a-25e5-4a3a-a14e-08dda319ac4b
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
 ARA:13230040|376014|7416014|366016|1800799024|38070700018; 
x-microsoft-antispam-message-info: =?utf-8?B?QUV1QUpEczlqZFExL1hEMk0wTkg0ODdmME05bmNEQ2p4NTJSa2xqNHdqMW1Q?=
 =?utf-8?B?VTBpYjZwekFmMVlYdlpoWXg2dHl4MkU2a2JSb2d4am45Wko2d3FXbElDaXlx?=
 =?utf-8?B?ZTVWU3BTY1VjK2JLaEt4VU5HSmdSVW9IY1pRaHF4Y2VSNitxcVNrNkJSbVVF?=
 =?utf-8?B?aDBlWTJQNS9tSXloaE1OZXY0OUtmZEdEZmZRYWFRQ1Mwc1N1STJTdjVsNWhN?=
 =?utf-8?B?TjU3bWVPOXJiY0luc2I0Skk2S0ZqN1BOV2h1ZnZJTVdqNE54R3FOaytkcWxa?=
 =?utf-8?B?ZEpER3RlM0JIVDl4SlFqTzFiQnpEOTV1ams3Tmt4MkVIUzdEcHhkTnV5ZHJP?=
 =?utf-8?B?OU1kMDBjWlI5WGwybENkMkRFcStwQ3dsdWR0bTVqSVBvRVZoSkJmTXJVMjI0?=
 =?utf-8?B?NjBTOHdJUldYaVhOZGRGck82eFlWMmdLTFR4d1lhQTN0bUM1d29yUngrV0Zh?=
 =?utf-8?B?OUM0Nk9vdHR1VWRuL3pTeGhYcFYzZXQwQzlMcWtwZmhhYUl1dHJYUWQxaTRP?=
 =?utf-8?B?aS9ETXBCL2J6NjZrTkN1YVg0OVVPSTJ5bkg1bW0vV3VtQ2hmYmJndGZ1YzUx?=
 =?utf-8?B?Qlo1WFdlSDBUZzhBT2NtdFBGTi9DVnhFKy92ZE5hVXlyZ0dNZENpaVNkMG12?=
 =?utf-8?B?ZkxYMU1yZ3hNQlMwL1lxQ1YweEZ3SEpoTldXNGNZbzNRNGx3emRjdXhTamg3?=
 =?utf-8?B?czB2V0tQVTBLSm1pSFJzcHNjeEFQM204WEtEWHVBSVhDMnJiRnJ1bjE4NXZi?=
 =?utf-8?B?dmRpVU5DQTdWT0lNODhPWlBwV2FNRFplWmpwR3p5SWUza0huM2p1ZkdrRDVV?=
 =?utf-8?B?eU1ha1d4Rm96R2tFNnpKdmkwMjJSUVdaTkFxYy8xUm5ZR3JaMWdLc1FMMVAx?=
 =?utf-8?B?RmJ4MWRaUkJicktrcXFKWkdpMDdZdEpPdFFIMEYvcUdOcmtGN0JEdTdTSC9T?=
 =?utf-8?B?elVFeVJQaEtqUEpmVWhEckpSNnBZdVRyL1hPaTRWMkp0Y0NWaUZzd1Bjc1FX?=
 =?utf-8?B?aXZuYVJWL3hqTXlObW5acVE4UW5rS1phNi9yRWtPOEMzbkJuaVhFT2JHRHVl?=
 =?utf-8?B?bjg0QUFKc0FLMjdpTGdCQjdQNjZzRURwQVh2SGxwc2VDZndrbWtzTTFmY0VO?=
 =?utf-8?B?S0RoMVBibHhWbWlyQURHWW9MYlFGYmpLVVRwQkxBbG5FRUJHMVorQWgrVWM2?=
 =?utf-8?B?WHV3Qzd6RnRtZ3F5ZkFkUS9ubE15akxOMStnZVNneFE4UE42MVBpMVNFMWM2?=
 =?utf-8?B?dTVsc1hoNHUvZGcrTTkxQVczcG9FVnkwbjRlNVNtTDVtb2orQWJ1MEVqdmZZ?=
 =?utf-8?B?OXIwTjBZSkhTUUJjck9uWDlWSHFva0FGRFR1REtBOHpZNnVIUEtHcG1nZlNl?=
 =?utf-8?B?Z0FTNlFGTjRnVFpFTlRrTHcxUHI1cHB6SXdJSVQ2V1JLY1pVRzUwcmQxbGh0?=
 =?utf-8?B?dFBObUJpazJ4K1hUaG9yS0RVb24zeFBNaFhmem1MUmdmSVVPaUp3cVNNQ0lt?=
 =?utf-8?B?Q3Z5cEM2SVBCL3YrU0xCZFRzUXBqTFlIbzM1M3hhZWhUakFUSzM0U0FxUkw5?=
 =?utf-8?B?NkJieXFXWkQ3TkF6TVo0QUpEdlBUVE9WT3ZUbVd2N3hBc3BIVkI3czlLNDda?=
 =?utf-8?B?bXFmY245clU3eEY2NG5CWklDaDkzTGlUR2tyS2FaSDVIRnZVY2drYlJNcFlt?=
 =?utf-8?B?L01COTNkMlFYSm9MQWJ3TWlEOUcyWlQ3UmVjSDREa0ZINHAwS0Vvd0x4Z3Fn?=
 =?utf-8?B?Z2UxRkFRRFdVeUlKMHpZTmJJRVoraTh6UUhPNTcwZjY5Ym9wd1NhM0FKMlhr?=
 =?utf-8?B?N2hBKy9xMW5RMDlrL29KOTR6RnJrZjQ4b0tDWWJYNy9OczZtN2Q0K0V1V2ZH?=
 =?utf-8?B?cGxtaktMSUpmWU1KaEtGMlVqYWVlWDJxR3QxWjlLZ1Y3SmRKUzdGMlJRYTAw?=
 =?utf-8?B?TWM3UXN0UC8yRmYzNFp2cTVjUllnYWpFcWtNZkVEcUNQNlZ6dlFQYjRiRjlV?=
 =?utf-8?Q?pBNHhnb85dGSBBnHxXxP7dacgWteIc=3D?=
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:IA3PR11MB9136.namprd11.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(376014)(7416014)(366016)(1800799024)(38070700018); DIR:OUT;
 SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?Q2Zmd0pjRG1scHl1Y09Qa1RIeC9pOVN2UXdEbkhyM3lienFZMCtDZFdKcjZO?=
 =?utf-8?B?Mkd3NmFjalBVa0EyNXMxSm90azBVZWwrNUJabHA2Z0JYWVIwT0FoQVBubmJP?=
 =?utf-8?B?dHc2U3hrUkpLeERIZUcxNzVvT2xqTFAzN1VTOUIyTUJVM0FqSGgxQ2Fhc3BR?=
 =?utf-8?B?Q0U0Y3RUNUwxajhjaHZ6NEpmU0lOYUtjUFVubmphRktpYUZKSVJHMVFOQmlS?=
 =?utf-8?B?cGdaUXNqVTI3Y2pOU3RYQU96cC83ekxJSkxOakVBV2FoMlBNWkpISmh1NHcv?=
 =?utf-8?B?dFhEQ3Z5ZlNMS2lLT3JoaEppZEJVdHFpeExld2xhbXFIQnI5NmxKMEcxcTJC?=
 =?utf-8?B?c2l4bWtzNitMK3BmWUpJZVRmazh3dEVmWHVMTG9XTzdOa0hQdDYvek1uNUZ2?=
 =?utf-8?B?M2ZSZVMwbmtTRDVITm1qclNCUjNYTlRscW9wUzlRYjRvVVpEdFExTXlBNWhq?=
 =?utf-8?B?SnZvVG9YODFBNm1xa1BSRnhFcVplbkJPaXBrR3Q4U3Q0bi8wb1pNOFZwNlVR?=
 =?utf-8?B?d2NDTWpqcWlqLzN4T0ozYy92NUpWTDdWSm9JanVmWG1BZEx6RGoxamJHNUhX?=
 =?utf-8?B?VFZxRG9kSFJxN3c0MmRNalhUWkRRNUNGSUp5RnpwUWZORlBXZE83NHdmcVJl?=
 =?utf-8?B?dWE3bnNScWhlV2x4MkMvQXJ1Tk8xWjEvdmlRSkVrU0V2NXRUeWMvNGVRcnI5?=
 =?utf-8?B?OW9hUjcvQUhKUzJxaUFxRVlBZ2dPdWtsOEl0c2ZKb3kwMFcyZERwUjB3cmtx?=
 =?utf-8?B?UEhOUHNLQTN2OWs2aGxRZHhnWWNsNlpjRGNKbUtPbXdRS29ueVFLallPdDBZ?=
 =?utf-8?B?Rms2VnBiVGZNakY0OG0yLzV1R01vUnJFYzU3bjNyVE9kOGs5akZEZldGZEFE?=
 =?utf-8?B?M0hmZ1E5SkoxUFJOWHpvbjRFRzdXeFRuU0xtcTJoTUc2SjlTUDBUUFFacUJB?=
 =?utf-8?B?S3ZrcHJ4eHg5N2hCT2lZMXRjeW5lNDQzWkRWYlVTeDlMRlVlSEVCaWtVY1dZ?=
 =?utf-8?B?aFBOaUlHcDAxLzRsdnhoNkpKN2J4dnQwYm5rcU1HOXFuVnFQQk9PYnBPR2xI?=
 =?utf-8?B?cDhDMUh3dmhScFB2SENpRDhGTi9lMnkwRUZZOG5KUVFHMlNBMzN4L3BFUlVh?=
 =?utf-8?B?NSt3WDhYdjZ1L0NNYysrMCtja2hETkNzVFdpVVJBaG1BWU1xcXhONDhreG56?=
 =?utf-8?B?NkgyL3U5aCtNaldXUXp4Sy93a0h4UVg0ai85VUM5djdTYjRWWXNqc1BzZnhU?=
 =?utf-8?B?Z2JrSDFJbXE4OW05ZlRRa093NEE3VGtyNllmQ3VMcm4rOUtDd1JkZDExU2pD?=
 =?utf-8?B?QTVzY0JOMktpTlBEdkg5eHd0bVNKYUhBL2xqNXBDZ2prQTV6SkVSMlExYW9K?=
 =?utf-8?B?VnlGZEpGZnZSak1rRnBNL2NNOVAvVm5VKzlMS1FmSGJkaXBWZW1lWW80S1RH?=
 =?utf-8?B?T1cyRC9ybDJjQWw3a2hzWGVFWEc4S0NEelZ0Z1VBRmoxMGlyQTVLR0syMU5t?=
 =?utf-8?B?MnJnbG5CcHkyUldaNiswWGxZL1hEWXJzdWpMdTVwYjl6UlpDbkJVS2dMNnI5?=
 =?utf-8?B?NldieUFWcHlMMGlBdkJHZVdNdHZ5WERFUVlCWGpOSFZoOXJHdjRqQnFqKzBB?=
 =?utf-8?B?VlZxMklhRlR1U0JtWDlsZXNTZHB3VEpPYUc0cmFya0x6NXJ4VFJPYWRYbUky?=
 =?utf-8?B?NkRXNjdJbXduZGx6bHdYOVJCS2lMMGFTWEYrV1JNc1F5cjdrMUp6V1Z4U2Ix?=
 =?utf-8?B?NEFHbDdnUFpucyswdlNGZHFxOG9zYkVLZVZYcWRtNlpVcm51elRKaHJMSHBL?=
 =?utf-8?B?dEJSamxaa3g5eEtWNXY2ZDVIZlV3a0owV2M5N1QzM1I4aGJFZFU0eUVPckxX?=
 =?utf-8?B?aGJQOFpGV3BjV2FHb1hqZlZsSG1ZZWlBMFBYQ0l5Z3BnNFkzeGxoUUpWR1Rm?=
 =?utf-8?B?RndVendEM1NncmE4dzFPQW9VM1RHcjdJWTI5MXRHbUVTVHgxdUFnWU13YmVr?=
 =?utf-8?B?VE9LdytBUXROZUVIbHRveElBUnEyWjVBczUzUXI4b095YTJtSEFIY1IxQW81?=
 =?utf-8?B?OSt2S04vemUvUTBmQ3dFRGNnNGpVd1NGUkNtWFQxR203MHZnbUJ0STduaFRq?=
 =?utf-8?Q?86Avw/9BbHLWF/kB3Q3CUrq7R?=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: IA3PR11MB9136.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: a92b754a-25e5-4a3a-a14e-08dda319ac4b
X-MS-Exchange-CrossTenant-originalarrivaltime: 04 Jun 2025 03:41:21.6513 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: w0WKXSMBvgebl+SqRYLaU8FkA28E0v7EES5yPNTvyIgt86/ySET0yrJLFfiQBlM3HKWXOQFNK6Sg3Fv76kraC2KNOq3cp253lk0Pz/T/blM=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM4PR11MB7253
X-OriginatorOrg: intel.com
Received-SPF: pass client-ip=192.198.163.11;
 envelope-from=zhenzhong.duan@intel.com; helo=mgamail.intel.com
X-Spam_score_int: -44
X-Spam_score: -4.5
X-Spam_bar: ----
X-Spam_report: (-4.5 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.128,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_MED=-2.3, RCVD_IN_MSPIKE_H2=0.001,
 RCVD_IN_VALIDITY_CERTIFIED_BLOCKED=0.001, RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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
ciA8ZXJpYy5hdWdlckByZWRoYXQuY29tPg0KPlN1YmplY3Q6IFJlOiBbUEFUQ0ggdjIgNC80XSB2
ZmlvL2lvbW11ZmQ6IFNhdmUgdmVuZG9yIHNwZWNpZmljIGRldmljZSBpbmZvDQo+DQo+SGkgWmhl
bnpob25nLA0KPg0KPk9uIDUvMzAvMjUgMTE6MzUgQU0sIFpoZW56aG9uZyBEdWFuIHdyb3RlOg0K
Pj4gU29tZSBkZXZpY2UgaW5mb3JtYXRpb24gcmV0dXJuZWQgYnkgaW9jdGwoSU9NTVVfR0VUX0hX
X0lORk8pIGFyZSB2ZW5kb3INCj4+IHNwZWNpZmljLiBTYXZlIHRoZW0gYXMgcmF3IGRhdGEgaW4g
YSB1bmlvbiBzdXBwb3J0aW5nIGRpZmZlcmVudCB2ZW5kb3JzLA0KPj4gdGhlbiB2ZW5kb3IgSU9N
TVUgY2FuIHF1ZXJ5IHRoZSByYXcgZGF0YSB3aXRoIGl0cyBmaXhlZCBmb3JtYXQgZm9yDQo+PiBj
YXBhYmlsaXR5IGRpcmVjdGx5Lg0KPj4NCj4+IEJlY2F1c2UgSU9NTVVfR0VUX0hXX0lORk8gaXMg
b25seSBzdXBwb3J0ZWQgaW4gbGludXgsIHNvIGRlY2xhcmUgdGhvc2UNCj4+IGNhcGFiaWxpdHkg
cmVsYXRlZCBzdHJ1Y3R1cmVzIHdpdGggQ09ORklHX0xJTlVYLg0KPj4NCj4+IFN1Z2dlc3RlZC1i
eTogRXJpYyBBdWdlciA8ZXJpYy5hdWdlckByZWRoYXQuY29tPg0KPj4gU3VnZ2VzdGVkLWJ5OiBO
aWNvbGluIENoZW4gPG5pY29saW5jQG52aWRpYS5jb20+DQo+PiBTaWduZWQtb2ZmLWJ5OiBaaGVu
emhvbmcgRHVhbiA8emhlbnpob25nLmR1YW5AaW50ZWwuY29tPg0KPj4gLS0tDQo+PiAgaW5jbHVk
ZS9zeXN0ZW0vaG9zdF9pb21tdV9kZXZpY2UuaCB8IDExICsrKysrKysrKysrDQo+PiAgaHcvdmZp
by9pb21tdWZkLmMgICAgICAgICAgICAgICAgICB8ICA4ICsrKy0tLS0tDQo+PiAgMiBmaWxlcyBj
aGFuZ2VkLCAxNCBpbnNlcnRpb25zKCspLCA1IGRlbGV0aW9ucygtKQ0KPj4NCj4+IGRpZmYgLS1n
aXQgYS9pbmNsdWRlL3N5c3RlbS9ob3N0X2lvbW11X2RldmljZS5oDQo+Yi9pbmNsdWRlL3N5c3Rl
bS9ob3N0X2lvbW11X2RldmljZS5oDQo+PiBpbmRleCA4MDljY2VkNGJhLi4xMGZjY2MxMGJlIDEw
MDY0NA0KPj4gLS0tIGEvaW5jbHVkZS9zeXN0ZW0vaG9zdF9pb21tdV9kZXZpY2UuaA0KPj4gKysr
IGIvaW5jbHVkZS9zeXN0ZW0vaG9zdF9pb21tdV9kZXZpY2UuaA0KPj4gQEAgLTE0LDYgKzE0LDEz
IEBADQo+Pg0KPj4gICNpbmNsdWRlICJxb20vb2JqZWN0LmgiDQo+PiAgI2luY2x1ZGUgInFhcGkv
ZXJyb3IuaCINCj4+ICsjaWZkZWYgQ09ORklHX0xJTlVYDQo+PiArI2luY2x1ZGUgImxpbnV4L2lv
bW11ZmQuaCINCj4+ICsNCj4+ICt0eXBlZGVmIHVuaW9uIFZlbmRvckNhcHMgew0KPj4gKyAgICBz
dHJ1Y3QgaW9tbXVfaHdfaW5mb192dGQgdnRkOw0KPj4gKyAgICBzdHJ1Y3QgaW9tbXVfaHdfaW5m
b19hcm1fc21tdXYzIHNtbXV2MzsNCj4+ICt9IFZlbmRvckNhcHM7DQo+Pg0KPj4gIC8qKg0KPj4g
ICAqIHN0cnVjdCBIb3N0SU9NTVVEZXZpY2VDYXBzIC0gRGVmaW5lIGhvc3QgSU9NTVUgZGV2aWNl
IGNhcGFiaWxpdGllcy4NCj4+IEBAIC0yNiw3ICszMyw5IEBADQo+PiAgdHlwZWRlZiBzdHJ1Y3Qg
SG9zdElPTU1VRGV2aWNlQ2FwcyB7DQo+PiAgICAgIHVpbnQzMl90IHR5cGU7DQo+PiAgICAgIHVp
bnQ2NF90IGh3X2NhcHM7DQo+PiArICAgIFZlbmRvckNhcHMgdmVuZG9yX2NhcHM7DQo+bWlzc2lu
ZyB0aGUgZG9jIGNvbW1lbnQgdXBkYXRlIGZvciBuZXcgZmllbGQgdmVuZG9yX2NhcHMNCg0KR29v
ZCBjYXRjaCwgd2lsbCBhZGQuIFRoYW5rcw0KDQpaaGVuemhvbmcNCg0KPg0KPk90aGVyd2lzZQ0K
Pg0KPlJldmlld2VkLWJ5OiBFcmljIEF1Z2VyIDxlcmljLmF1Z2VyQHJlZGhhdC5jb20+DQo+DQo+
VGhhbmtzDQo+DQo+RXJpYw0KPg0KPg0KPj4gIH0gSG9zdElPTU1VRGV2aWNlQ2FwczsNCj4+ICsj
ZW5kaWYNCj4+DQo+PiAgI2RlZmluZSBUWVBFX0hPU1RfSU9NTVVfREVWSUNFICJob3N0LWlvbW11
LWRldmljZSINCj4+ICBPQkpFQ1RfREVDTEFSRV9UWVBFKEhvc3RJT01NVURldmljZSwgSG9zdElP
TU1VRGV2aWNlQ2xhc3MsDQo+SE9TVF9JT01NVV9ERVZJQ0UpDQo+PiBAQCAtMzgsNyArNDcsOSBA
QCBzdHJ1Y3QgSG9zdElPTU1VRGV2aWNlIHsNCj4+ICAgICAgdm9pZCAqYWdlbnQ7IC8qIHBvaW50
ZXIgdG8gYWdlbnQgZGV2aWNlLCBpZS4gVkZJTyBvciBWRFBBIGRldmljZSAqLw0KPj4gICAgICBQ
Q0lCdXMgKmFsaWFzZWRfYnVzOw0KPj4gICAgICBpbnQgYWxpYXNlZF9kZXZmbjsNCj4+ICsjaWZk
ZWYgQ09ORklHX0xJTlVYDQo+PiAgICAgIEhvc3RJT01NVURldmljZUNhcHMgY2FwczsNCj4+ICsj
ZW5kaWYNCj4+ICB9Ow0KPj4NCj4+ICAvKioNCj4+IGRpZmYgLS1naXQgYS9ody92ZmlvL2lvbW11
ZmQuYyBiL2h3L3ZmaW8vaW9tbXVmZC5jDQo+PiBpbmRleCBkNjYxNzM3YzE3Li5mYmY0N2NhYjA5
IDEwMDY0NA0KPj4gLS0tIGEvaHcvdmZpby9pb21tdWZkLmMNCj4+ICsrKyBiL2h3L3ZmaW8vaW9t
bXVmZC5jDQo+PiBAQCAtODM0LDE2ICs4MzQsMTQgQEAgc3RhdGljIGJvb2wNCj5oaW9kX2lvbW11
ZmRfdmZpb19yZWFsaXplKEhvc3RJT01NVURldmljZSAqaGlvZCwgdm9pZCAqb3BhcXVlLA0KPj4g
ICAgICBWRklPRGV2aWNlICp2ZGV2ID0gb3BhcXVlOw0KPj4gICAgICBIb3N0SU9NTVVEZXZpY2VJ
T01NVUZEICppZGV2Ow0KPj4gICAgICBIb3N0SU9NTVVEZXZpY2VDYXBzICpjYXBzID0gJmhpb2Qt
PmNhcHM7DQo+PiArICAgIFZlbmRvckNhcHMgKnZlbmRvcl9jYXBzID0gJmNhcHMtPnZlbmRvcl9j
YXBzOw0KPj4gICAgICBlbnVtIGlvbW11X2h3X2luZm9fdHlwZSB0eXBlOw0KPj4gLSAgICB1bmlv
biB7DQo+PiAtICAgICAgICBzdHJ1Y3QgaW9tbXVfaHdfaW5mb192dGQgdnRkOw0KPj4gLSAgICB9
IGRhdGE7DQo+PiAgICAgIHVpbnQ2NF90IGh3X2NhcHM7DQo+Pg0KPj4gICAgICBoaW9kLT5hZ2Vu
dCA9IG9wYXF1ZTsNCj4+DQo+PiAtICAgIGlmICghaW9tbXVmZF9iYWNrZW5kX2dldF9kZXZpY2Vf
aW5mbyh2ZGV2LT5pb21tdWZkLCB2ZGV2LT5kZXZpZCwNCj4+IC0gICAgICAgICAgICAgICAgICAg
ICAgICAgICAgICAgICAgICAgICAgICZ0eXBlLCAmZGF0YSwgc2l6ZW9mKGRhdGEpLA0KPj4gKyAg
ICBpZiAoIWlvbW11ZmRfYmFja2VuZF9nZXRfZGV2aWNlX2luZm8odmRldi0+aW9tbXVmZCwgdmRl
di0+ZGV2aWQsICZ0eXBlLA0KPj4gKyAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAg
ICAgICAgdmVuZG9yX2NhcHMsIHNpemVvZigqdmVuZG9yX2NhcHMpLA0KPj4gICAgICAgICAgICAg
ICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgJmh3X2NhcHMsIGVycnApKSB7DQo+PiAgICAg
ICAgICByZXR1cm4gZmFsc2U7DQo+PiAgICAgIH0NCg0K

