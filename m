Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id CD17BC87FC9
	for <qemu-devel@archiver.kernel.org>; Mon, 28 Jul 2025 13:24:54 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1ugNpo-00037P-Kh; Mon, 28 Jul 2025 09:24:08 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <zhenzhong.duan@intel.com>)
 id 1ugNMD-0001L5-Ga
 for qemu-devel@nongnu.org; Mon, 28 Jul 2025 08:53:33 -0400
Received: from mgamail.intel.com ([198.175.65.17])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <zhenzhong.duan@intel.com>)
 id 1ugNMA-00069X-OV
 for qemu-devel@nongnu.org; Mon, 28 Jul 2025 08:53:33 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1753707210; x=1785243210;
 h=from:to:cc:subject:date:message-id:references:
 in-reply-to:content-transfer-encoding:mime-version;
 bh=BZdkH0SVynynS/zDSI8M53/ADvybXiQfX9K4N0JJIqw=;
 b=DNZibo24kP8aWpOpnccyiDWisv+rOPIhWollCa+dhjjylZA8oR9EWBKb
 1iHOSsWmUb87g740ia1kgPsBHel+taZCKtXD+FAUv6ubc9/9OuN6Lw1X7
 z+BX39Y1p7GvGvcV4T9yyepTHHPw4TYoAPeDON5m5eC2I95jgHM7ng64s
 Pyx0pO5v+rxKJI+hx6gz15DU8uKtSaVQg1RYKsoD4osFGB8oWdGTwtcvD
 PbhNLPcnZhNG5Rn7/cN0YSl5H6wC3l6RdOTBI+8eTHO8SvgGc7EoyaRrN
 1CLy4g1CIObRoj5Wd9S82//L8h2Mor2KtJ7oIZ2rEPlxcvzaHb9MqU6DP g==;
X-CSE-ConnectionGUID: 5R9t9Nv3TVKcPFZY5/uifQ==
X-CSE-MsgGUID: DAwC2KqoRza96xsleQEiXg==
X-IronPort-AV: E=McAfee;i="6800,10657,11505"; a="55921363"
X-IronPort-AV: E=Sophos;i="6.16,339,1744095600"; d="scan'208";a="55921363"
Received: from orviesa004.jf.intel.com ([10.64.159.144])
 by orvoesa109.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 28 Jul 2025 05:53:27 -0700
X-CSE-ConnectionGUID: YdMEskicTiSSUUYRtWENBQ==
X-CSE-MsgGUID: oy41zAZuSqKabgiLgRCFRA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.16,339,1744095600"; d="scan'208";a="166884715"
Received: from orsmsx901.amr.corp.intel.com ([10.22.229.23])
 by orviesa004.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 28 Jul 2025 05:53:28 -0700
Received: from ORSMSX902.amr.corp.intel.com (10.22.229.24) by
 ORSMSX901.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1748.26; Mon, 28 Jul 2025 05:53:26 -0700
Received: from ORSEDG901.ED.cps.intel.com (10.7.248.11) by
 ORSMSX902.amr.corp.intel.com (10.22.229.24) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1748.26 via Frontend Transport; Mon, 28 Jul 2025 05:53:26 -0700
Received: from NAM12-BN8-obe.outbound.protection.outlook.com (40.107.237.49)
 by edgegateway.intel.com (134.134.137.111) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1748.26; Mon, 28 Jul 2025 05:53:25 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=HEiJkt7FwjcCCE1CLUVYF6tI4CBYayayHMzZegwc1aXL8T2l0rOdZDHstEwy9Pg8CrL82w/KN5PgIJ9DF+nax5g8/4/e+M0Vt5nPKr2znKIyfiYqPPiGSrs1Aq8a8AlFI9vPY33Ftk5gJ3Omq5GYfxKOYYgA3ciUpjaTAaUDqQz/pvfWr7LK4B4K2nSXSkw+ORkL4BdNJG/pFUgEPYONxk2DZ237YdeVcPUZphIfn5RKZ3IL9K0y5pNSnqCI0AeeagCZauLkUkY/S1YutfOsIWcTquFNssqPuSt6e+8EzF0wRSyIKGS3goA4ePLmJZ/xLi1PzBg/QUdZuwmbh2sHKQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=BZdkH0SVynynS/zDSI8M53/ADvybXiQfX9K4N0JJIqw=;
 b=uq2cbXA2IJmpq5q3b+yTVe+B4TH5FUtgBEMq2eHml/Od6YqgOfEeowgcCQXyqVpqlWjzqOUy0CA5oZO+J/UfAkYX0Wg8ku60aDNz2PpwRwS+BLRZP217tO2P4P5gq1Y5yZen2CE6xmhx/xpXCirhGS53RZt6sbGRyp3khNQtP/hYKZCc9q2V9TFGMTrurUDME736ohiJYgu6HFDeuQC++aDJTdq/UKDYj2311GCKYWByyC54E/g+1BAci+L1RnLJtxf37tC27d9R4YWaqrqiv2Bh4qE6fjQpbsCsWR2ycSoTPtCcqOFbypmjBJH6voKCkivQiq3V2YGV4kKlF/8dMA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Received: from IA3PR11MB9136.namprd11.prod.outlook.com (2603:10b6:208:574::12)
 by MW5PR11MB5762.namprd11.prod.outlook.com (2603:10b6:303:196::14)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8964.27; Mon, 28 Jul
 2025 12:53:17 +0000
Received: from IA3PR11MB9136.namprd11.prod.outlook.com
 ([fe80::604b:77a4:b1be:3f13]) by IA3PR11MB9136.namprd11.prod.outlook.com
 ([fe80::604b:77a4:b1be:3f13%4]) with mapi id 15.20.8943.028; Mon, 28 Jul 2025
 12:53:17 +0000
From: "Duan, Zhenzhong" <zhenzhong.duan@intel.com>
To: =?utf-8?B?Q8OpZHJpYyBMZSBHb2F0ZXI=?= <clg@redhat.com>,
 "qemu-devel@nongnu.org" <qemu-devel@nongnu.org>
CC: "alex.williamson@redhat.com" <alex.williamson@redhat.com>,
 "philmd@linaro.org" <philmd@linaro.org>, "wangyanan55@huawei.com"
 <wangyanan55@huawei.com>, "Liu, Zhao1" <zhao1.liu@intel.com>,
 "slp@redhat.com" <slp@redhat.com>, "pbonzini@redhat.com"
 <pbonzini@redhat.com>, "richard.henderson@linaro.org"
 <richard.henderson@linaro.org>, "mst@redhat.com" <mst@redhat.com>,
 "eduardo@habkost.net" <eduardo@habkost.net>, "marcel.apfelbaum@gmail.com"
 <marcel.apfelbaum@gmail.com>, "shahuang@redhat.com" <shahuang@redhat.com>,
 "Peng, Chao P" <chao.p.peng@intel.com>
Subject: RE: [PATCH] vfio/pci: Fix regression due to unexisting property
 use-legacy-x86-rom
Thread-Topic: [PATCH] vfio/pci: Fix regression due to unexisting property
 use-legacy-x86-rom
Thread-Index: AQHb/7tH928wmNXXCEGFpAckeAJjwLRHd+cAgAAE1FA=
Date: Mon, 28 Jul 2025 12:53:17 +0000
Message-ID: <IA3PR11MB9136873A48AC915500934D20925AA@IA3PR11MB9136.namprd11.prod.outlook.com>
References: <20250728122906.39703-1-zhenzhong.duan@intel.com>
 <424a42b6-5013-4b95-9d85-37d99ebdfe93@redhat.com>
In-Reply-To: <424a42b6-5013-4b95-9d85-37d99ebdfe93@redhat.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: IA3PR11MB9136:EE_|MW5PR11MB5762:EE_
x-ms-office365-filtering-correlation-id: f642434e-99b0-41c9-aa21-08ddcdd5b947
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
 ARA:13230040|1800799024|366016|7416014|376014|38070700018; 
x-microsoft-antispam-message-info: =?utf-8?B?V2dXTmhOYUFrVHcvbGQwRDFZbjhpcTIrcWNGc1VwS2MwWWxzUG9ZSmxmYzVP?=
 =?utf-8?B?akNRUjZGRG5nbUVjN0ZlcFpNejluTGo1ZUpvMXg4M0xvS2RyK2wzUTFJVVRl?=
 =?utf-8?B?V1l2TmZkNGtqNFJQK0laQnR1S090N0tpeWJ6UGhxMkI5UEI0YnBHclZWcWZs?=
 =?utf-8?B?OWdVdGV0V09SQmFBL2RRRFp0T1BvVHVzS0YxRTJDcVhDcVFYSzZvWE9vcWJu?=
 =?utf-8?B?MUF3c2FNYjB2VFBCS2JGSHRMN0ltaFppL2cvc3A5dEFrSnlBNVRhMUE1VEV4?=
 =?utf-8?B?UDlWSEJ4T1luTnNEbitsWFM2V0RkdklUZlgyRkpBRFhhWFRkYWlqOGVMeGFU?=
 =?utf-8?B?V0EybVNsZDl5TktLa1dBaDF2ZnhiOU0weE82VWFxYnNkOW5xSWRHZDh4UVFq?=
 =?utf-8?B?cEEwRVRCeXQ4ZDBwOGxsQmsvRGZVenduWWV4QnYvaVVpRFB5NGVSVy9kb2Rt?=
 =?utf-8?B?QjNrS0cwSkkwZVRZU1oyZTVyT2pHOUZhZlNzSVpWd0svOUI2NkNaeUhwbGFs?=
 =?utf-8?B?NWhxR1ZzQkJpTU9vd1NDc1RSUm5VaDJrdm5BOFgwRzY5bnd5L3lZYStLUitU?=
 =?utf-8?B?ejJsUm52WGNSL1piTnU1RGFGT2tHNC9GbitVV0pzM2tlQTlmNVdtVmJZVDlR?=
 =?utf-8?B?QjVnUFVjR2ZuU1phUEpYNkFnOXN2a1lKcU5aM2Zkd1liYlcvU1pyQXhnSUNY?=
 =?utf-8?B?NG9reUI4RTVQUDE5VUhnT2ROWFkvRCtubDJKNFcvRHdWN3VMUGtWeWRRNFU0?=
 =?utf-8?B?cU1SaS9XVUtmMVd2TGRHemhJYTZGdG93UGpjRnZ6REZVL0FMbDJMQnQ2VU9O?=
 =?utf-8?B?SUJFN3RiVXh0M3E0Vmt1TlhtTW8yRi82RU9Od2NJcCtlMlBBOVl6MnlEUlNq?=
 =?utf-8?B?VU1QaEtZRmJMdTNFQnZSUDUvY2pQdHZuMjVsS1VjMk56MGhmTGNqdjdKTzh2?=
 =?utf-8?B?VElGZXF2TGx6NzZ3TGRrNFcyMEVBL0crZDdldmZ4R3BLdUFHaUNZTHQ3VWVL?=
 =?utf-8?B?ZCs3S0N2eTgwbTE3NnFCWUpVOEJUM2s5eEVkUEwyZHdCUU1IY2I0S3c0REhy?=
 =?utf-8?B?dmVzNU5rS3ZJdi9YRnh1ekU5eVZOSUJkSXAxNTlkaUNzREU5OEtudE16dWpz?=
 =?utf-8?B?dFlyMFAvYXBNb0JJTElJMEpiTzBwRXpGNUJleVhGeUZVRysvaFRraVVQOE56?=
 =?utf-8?B?YUpReFp4NUpvVW4wMjA3MDJmcHpjMFhZV0pzSlhUWDRKeTkraGZCQXNYdkE2?=
 =?utf-8?B?aTdNd0lmeEVSb1NaOWpieE1sSDl6VE5MSzV2enlibGN4N0lNV0F3OHJsejNw?=
 =?utf-8?B?b3haTUdBNE5lRC85QmxVaHZOUkJsd0lwNXNpVmRlWWtTSG1kSndPRDBtNFhR?=
 =?utf-8?B?cHkvTFNFN2t6a1MwY2I5aXFlcmtFWVAxY1pFYkxEQUo4dG1vamJQZ0pzWkNz?=
 =?utf-8?B?S0tIN3l4c1g1Rk1tOWFVMGFJQXVQeWpqUjFxd3hnZWVFdXJZOVpNUllzd2dM?=
 =?utf-8?B?MTBuV01qSnlFdXZ3NklRQmpzN3ZOaittNThWVVdIMmVGTys4T3dOYjFmVEZr?=
 =?utf-8?B?OEFRL2pxWDhSelZrVkhjOXZkcndLc1J5OGlHV01yZ25RODhHYU1xR2FkdjNp?=
 =?utf-8?B?UGx4M0J0d1cvc2x3YjRQVXlDcGxkOWNKWDk2SVRDZm5kK0swZHRhRFZIMjlH?=
 =?utf-8?B?V1FUVllzN1lzSFIrTU1XeC96ckdnUk1Md0txaE5Ld0xpczZleGt0NzFiYjVK?=
 =?utf-8?B?ZXprb253aDd0bkJCckdVV2RaTXl2KzM2b3Q1YlNtMVVOSUduNSs1RXZ5R2sx?=
 =?utf-8?B?Yk4xUmVNS21QN1Y2QUhWSEJWVWtXUEx3RVA3QWd5QkY3NmZ6cXZEYVpmUk5G?=
 =?utf-8?B?RXp3ZDdhWjJZbDhjK0o0ZUIyNUdHWkdYelZOY1kvbVpzbVBhNzZFRlJwSUs1?=
 =?utf-8?B?ZXRITVBnbGNQczNrcXlRakhtcHZVbkY2UDYrT2x5Q21hWDF2VDNPdzkzMDhm?=
 =?utf-8?Q?OHEEErMU+gtTzdLeBeTA+CIDqlCw60=3D?=
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:IA3PR11MB9136.namprd11.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(1800799024)(366016)(7416014)(376014)(38070700018); DIR:OUT;
 SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?Q1Y1bWFPRnovSVJVS3Y5eU44QUJOMXdOSW43NjByNEUwS2NuOFBZS1FKRW8r?=
 =?utf-8?B?TWJJcmNrR2s4b1AzU2NVNjNyT3hQUkFKNXNXUGp5Vm5TUzJsYi8zS1g5eDd2?=
 =?utf-8?B?RGxiajViVjdmazMxYllHUzRoaWY3OGJqNUFxd0ZTWjlTVGJOTWZ4VGNxaTdu?=
 =?utf-8?B?bmFYUUpjR2RqeXhTSEFwSG5lMHRyb1Y3dEFQVHJacy9ORjQwOXRpNTVFc2xv?=
 =?utf-8?B?TXRKVXdGdGw4cktQMEh3MWdpRld2L1JYeVZHQU1BaUhuVmQ3T1JsN0FzbWtn?=
 =?utf-8?B?aTgvZ2xXYzdPRW9ZZURKYmgxaWRWYjgybW9qcXplY3ZOUzN5d2ErMDlDSzY3?=
 =?utf-8?B?aWJsVzBYbUtsWW0ydXQ4anBsa25QV2xvNzZVQllEOVdQNjNoSkJ4cFBzSlZV?=
 =?utf-8?B?QTV1L0FBcWlESXpvN3lNWDNxYTUyT21XV0dPVDVkZHhBRWJ0eVVaTFFZaHFl?=
 =?utf-8?B?NU1GeVBuTGIwMEdHSXI4TnY0bkg5cXl6NUxDTko3NTBrbkFSUUcyQm5CT1hW?=
 =?utf-8?B?Ri80QnZSV0hOOFZ0RWVad0hHRDltQ2R6UnhibThSck9oNTRYZXRlSWxpcUpm?=
 =?utf-8?B?UHhuWU1xVyt1ZVZxQ1RHMk5MWFdUb3QvREpaUjB1c25aR3AwbXpuTVQ4d2lQ?=
 =?utf-8?B?S2lPdDJ6R1ZXZ1JZd0h1ak9aL2hZL3M1QXN3WkdIeWhqVFZFM04wN1Fnb1A4?=
 =?utf-8?B?ZGpqZm1EdmdiWUJzTlJTNkFWQTNPbkQ3OXNVTjVSYTBsUi9YblV2VWUyMSt6?=
 =?utf-8?B?MTNlNWg3ZURWb2JsYXVsODJIN2MrMzVCVmZ6TFBtMGZnUk5McjJTbG1nS0la?=
 =?utf-8?B?K2F0QldYWm0zanRhQkJGVHZqQ3VIQXl2YnB2OURQQmxJcDJyNkdkVkVWZnhy?=
 =?utf-8?B?eHo1K1VQbEJKSEt1amdjUEtCcUVIdFp5MzAxNm5pV2hXdFJLUDN3V1VmRC9r?=
 =?utf-8?B?K1psK0JvZGs0blAzWEYvYzF2cjBJNTRTNU1qc3FySzd5dTNWSDA3aUY0UW1s?=
 =?utf-8?B?ajRtdWpCZjcvK295ZnAzbGdtdEJEdVM2QzNuYlZWbkFSUzVhLzY0b0lDMDQ1?=
 =?utf-8?B?Sko1Vkc0UGJvZnl6RXloUmNUUnloS1U3TEtiR0RReit4QlAwQzNrY1VCa1dB?=
 =?utf-8?B?c1lYRzZMV0YzdHNid1ViaVZMeG9pL1JNTUx4S3o4ZnN6Sk8zQ2pJTDIxOWtR?=
 =?utf-8?B?Y3ViZWxXNWpaRWwwaVVZUUZieGdvN3ZKY2R1OW9XRFBWK0tSanBGb0ZUdEJu?=
 =?utf-8?B?TEhYNzFvTWcxZ2FpK3V6NEJOZDdWT3VuWlMzYm9sYkQzdnc3RzlMMHlaTVU2?=
 =?utf-8?B?aWtGT29KQmNjdWtZWGx5VFRnZkdwY2RnZi93WnIwanpRMURUOW1NbUJWQktv?=
 =?utf-8?B?dmhWMGR0bHkzUzdwQzNreWdmMUhMUWhEZ3Q4dDhySzU4TDBOeDR3UEwzTVR4?=
 =?utf-8?B?aGZ3THdPUGZoUmF3WS96aTFmcFFRL0FYa0FYaitPY0VYUUFEUFpZdjVVQzhw?=
 =?utf-8?B?UjJVckJWY2d5OUp6QXJzWGhDWDd4TjRaWUpFMGZ0UE4rRkhLdjR5N1RmSUN4?=
 =?utf-8?B?aDI0c0VyT1B0YmxUSHlyS2FiQVYxdjJaTXNteFV2SVZPeWNQWG9Ra3E3TWkv?=
 =?utf-8?B?YjRFcmF6OVpLV2dVUjdjUmdUdElHVEhMK3FYV2FYM01qWlQ5TlUyaENwd3lJ?=
 =?utf-8?B?N3NLZDdXSVRpWHUxU3h3TEtSMDRJZTgwMDV3d1U2T1Q3OFNDMWR4NWp1K3BS?=
 =?utf-8?B?VTFmaHhYK0FYVDVRUFFyWEJIZE5JZm1VYkVZR0QraE5zSnVHRkV3V2JOZTJh?=
 =?utf-8?B?L1lzVTR6dTk0RWhRbU9LZUp3YWxvN2V4NEFRU0RHZnpQdnR1NEVzamNyS1ZS?=
 =?utf-8?B?ekN4blBKRjh2ZUlWWENOTTdjYVJFempBeUZMTzVDR25sRmlpUTR3ZnNxTFhh?=
 =?utf-8?B?SjBKbS82dlcxdWpsaW9xeGlsSFpBNlY4cDk5MHZjQjdPKzYySHZVM2F1T1NS?=
 =?utf-8?B?WTdoOUdlcEk3TEh6d3hnSkdGSi9nYlFEeG9wY2xXQUxjL2tsZ0hZWW54Qnd4?=
 =?utf-8?B?L0hVaFNac2RJYVZ5MEtpK3JNL2pOd0ZzZllGeEcwL1NTWVA2VFlEejBYbjhj?=
 =?utf-8?Q?4NR/xU5KXvaLO0BSXuM9TgNzh?=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: IA3PR11MB9136.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: f642434e-99b0-41c9-aa21-08ddcdd5b947
X-MS-Exchange-CrossTenant-originalarrivaltime: 28 Jul 2025 12:53:17.6211 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: BUIjZo6ysJAPfINkPJA5qi8FdE8UPvkx/Pj06+h2Rh2clKdLtJpokHhdSFbo2aO7GqoxIkOyfz0ZUA+W+JAXzxM0q3rqTBfmWqea3gLT3xA=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MW5PR11MB5762
X-OriginatorOrg: intel.com
Received-SPF: pass client-ip=198.175.65.17;
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
IDxjbGdAcmVkaGF0LmNvbT4NCj5TdWJqZWN0OiBSZTogW1BBVENIXSB2ZmlvL3BjaTogRml4IHJl
Z3Jlc3Npb24gZHVlIHRvIHVuZXhpc3RpbmcgcHJvcGVydHkNCj51c2UtbGVnYWN5LXg4Ni1yb20N
Cj4NCj5IZWxsbyBaaGVuemhvbmcsDQo+DQo+T24gNy8yOC8yNSAxNDoyOSwgWmhlbnpob25nIER1
YW4gd3JvdGU6DQo+PiBUWVBFX1ZGSU9fUENJIGRvZXNuJ3QgaGF2ZSBwcm9wZXJ0eSB1c2UtbGVn
YWN5LXg4Ni1yb20sIGJ1dA0KPj4gVFlQRV9WRklPX1BDSV9OT0hPVFBMVUcgaGFzLiBUaGUgY29t
cGF0aWJpbGl0eSBjb25maWcgbGVhZHMgdG8NCj4+IFNJR0FCUlQgb24gbmV3IFFFTVUuDQo+Pg0K
Pj4gVGhlIGRlZmF1bHQgdmFsdWUgb2YgZWxlbWVudCB1c2VfbGVnYWN5X3g4Nl9yb20gZm9yIFRZ
UEVfVkZJT19QQ0kgaXMNCj4+IGFscmVhZHkgZmFsc2UsIHNvIG5vIG5lZWQgZXh0cmEgcHJvY2Vz
c2luZy4NCj4+DQo+PiBGaXhlczogZDVmY2YwZDk2MGQ4ICgiaHcvaTM4NjogQWRkIHRoZSByYW1m
YiByb21maWxlIGNvbXBhdGliaWxpdHkiKQ0KPj4gU2lnbmVkLW9mZi1ieTogWmhlbnpob25nIER1
YW4gPHpoZW56aG9uZy5kdWFuQGludGVsLmNvbT4NCj4NCj4NCj5GaXggaXMgaGVyZSA6DQo+DQo+
DQo+aHR0cHM6Ly9sb3JlLmtlcm5lbC5vcmcvcWVtdS1kZXZlbC8yMDI1MDcyMzA2MjcxNC4xMjQ1
ODI2LTEtY2xnQHJlZGhhdA0KPi5jb20vDQoNCkFoLCB0aGFua3MgQ8OpZHJpYywgZ29vZCB0byBz
ZWUgdGhpcywgSSBzaG91bGQgaGF2ZSBjaGVja2VkIHZmaW8tbmV4dCBmaXJzdC4NCg0KQlJzLA0K
Wmhlbnpob25nDQo=

