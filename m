Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0CFD0CF07A5
	for <qemu-devel@archiver.kernel.org>; Thu, 10 Oct 2024 05:39:25 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sylsl-0003A8-WB; Thu, 10 Oct 2024 01:38:40 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <zhenzhong.duan@intel.com>)
 id 1sylsj-00039g-7A
 for qemu-devel@nongnu.org; Thu, 10 Oct 2024 01:38:37 -0400
Received: from mgamail.intel.com ([192.198.163.14])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <zhenzhong.duan@intel.com>)
 id 1sylsg-0004o0-6Y
 for qemu-devel@nongnu.org; Thu, 10 Oct 2024 01:38:36 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1728538714; x=1760074714;
 h=from:to:cc:subject:date:message-id:references:
 in-reply-to:content-transfer-encoding:mime-version;
 bh=9xa2HW+5TEjnVR4pbfO7JHJdZe4fGelPrK2g5Qe86T0=;
 b=AZm4TlyiZQDUlZVjk4jPNv8YMvMFsn+oMLPAo7cKdnFXVUV6/yzrgPGE
 E/428Yrmah08Xntjf/K95VvcEi67QaDKlzSig5E2m5nTFffWquyJGgwj+
 uuvI0+0kiyKRULXhA67MMwGsJZ3OXP83Is/3oJdBUEgxpMZhHRvjcEIuB
 LN0DuJTwYf5Fub7C+YCqnf+e2hamqAFmOmg1VmiL8fm9YsW0clcL7L58j
 sR016Dj08xpHWq+C35vTXL+Hfp+acBjWCDgtmiWz98ZtzIwKDwbHRuSwp
 8lDo3YGaYvFvUSHIMPdtfvlQ/eSO5x72023uvK20dItImiGpDNB0jpO3M A==;
X-CSE-ConnectionGUID: EcumI1RFSE+wrKUSbZF0dw==
X-CSE-MsgGUID: I063UJ/ER6SAgWcb++LkmA==
X-IronPort-AV: E=McAfee;i="6700,10204,11220"; a="28033146"
X-IronPort-AV: E=Sophos;i="6.11,192,1725346800"; d="scan'208";a="28033146"
Received: from orviesa010.jf.intel.com ([10.64.159.150])
 by fmvoesa108.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 09 Oct 2024 22:38:29 -0700
X-CSE-ConnectionGUID: l4hP/U9LRcmCbubL4BXFkA==
X-CSE-MsgGUID: aFsOg+rdR0yx5cREUSnuPg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.11,192,1725346800"; d="scan'208";a="76374477"
Received: from orsmsx603.amr.corp.intel.com ([10.22.229.16])
 by orviesa010.jf.intel.com with ESMTP/TLS/AES256-GCM-SHA384;
 09 Oct 2024 22:38:29 -0700
Received: from orsmsx612.amr.corp.intel.com (10.22.229.25) by
 ORSMSX603.amr.corp.intel.com (10.22.229.16) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.39; Wed, 9 Oct 2024 22:38:28 -0700
Received: from orsmsx610.amr.corp.intel.com (10.22.229.23) by
 ORSMSX612.amr.corp.intel.com (10.22.229.25) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.39; Wed, 9 Oct 2024 22:38:27 -0700
Received: from ORSEDG601.ED.cps.intel.com (10.7.248.6) by
 orsmsx610.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.39 via Frontend Transport; Wed, 9 Oct 2024 22:38:27 -0700
Received: from NAM12-MW2-obe.outbound.protection.outlook.com (104.47.66.46) by
 edgegateway.intel.com (134.134.137.102) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.39; Wed, 9 Oct 2024 22:38:10 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=ns/JMtwEc74RIWs6VeLBSyzw1r27cmed138u/uu+WKK3ZMUnp5FMvnhkPHvtlOypa1pnMwC7ydHT5kPV9ZkTG32kqugZvHOxwVnxiFnE6GEsE+WNpN9tFGpl+Bb1EjSR3NRah8huVzh+rcqgMJUfNW28NkWV6UKnWiEEhcSKZWV5oHQU5vlxNN9/nI8EISgAn9WonGXxCiuCNY6BOIPKnO+NXBKxvznLIuPABLaG2UePjvyqS5QGJ1ddZuDDc6IqUUF2pUV+LJycHsHhCnikkuahRkBi+YC0xlS5m5YuXXuoc7ul9aW/oftacFSU/odoEZcbsKP22nlkee3waKYGeA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=9xa2HW+5TEjnVR4pbfO7JHJdZe4fGelPrK2g5Qe86T0=;
 b=SvObapsOjXvlA8KhHoLyF4zxfu8NzXuh3ahrp74RlTFLN+MxuzNajvPNd+hj3xpi1aqP7npvTE7p1Eh9G0zorjJckgZJrCfcDzbp1IIbmG8tzHoMiX4dJQujT+IWtgMY6yCZHwXvKmv7C5zN7CXs0VgH/11ElOuY/10i19zNriu36AnSg/Ddx1qhcuLJmePw6+vDMYfftPGUEzkdsl36HLPlfi514/wBLJP2yDKCYbh1f/dUfNLayerEzJE4JgcX3JgayRGY22lJyYl619a8NxYcApkNXa7ExxJ6X16xpqzyZky2d9jr6dNVzv9GzzLaVYLANl58+ZMaDYmpi1L07w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Received: from SJ0PR11MB6744.namprd11.prod.outlook.com (2603:10b6:a03:47d::10)
 by DM4PR11MB8227.namprd11.prod.outlook.com (2603:10b6:8:184::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8026.24; Thu, 10 Oct
 2024 05:38:03 +0000
Received: from SJ0PR11MB6744.namprd11.prod.outlook.com
 ([fe80::fe49:d628:48b1:6091]) by SJ0PR11MB6744.namprd11.prod.outlook.com
 ([fe80::fe49:d628:48b1:6091%5]) with mapi id 15.20.8026.020; Thu, 10 Oct 2024
 05:38:03 +0000
From: "Duan, Zhenzhong" <zhenzhong.duan@intel.com>
To: Jason Wang <jasowang@redhat.com>
CC: "qemu-devel@nongnu.org" <qemu-devel@nongnu.org>, "Peng, Chao P"
 <chao.p.peng@intel.com>, "Liu, Yi L" <yi.l.liu@intel.com>, "Michael S.
 Tsirkin" <mst@redhat.com>, =?utf-8?B?Q2zDqW1lbnQgTWF0aGlldS0tRHJpZg==?=
 <clement.mathieu--drif@eviden.com>, Marcel Apfelbaum
 <marcel.apfelbaum@gmail.com>, Paolo Bonzini <pbonzini@redhat.com>, "Richard
 Henderson" <richard.henderson@linaro.org>, Eduardo Habkost
 <eduardo@habkost.net>
Subject: RE: [PATCH] intel_iommu: Remove Transient Mapping (TM) field from
 second-level page-tables
Thread-Topic: [PATCH] intel_iommu: Remove Transient Mapping (TM) field from
 second-level page-tables
Thread-Index: AQHbEwXWWUU0GF+m1066oPlDXudFH7J+IyAAgAAdbFA=
Date: Thu, 10 Oct 2024 05:38:03 +0000
Message-ID: <SJ0PR11MB674461BA6DC44CA98E41E40A92782@SJ0PR11MB6744.namprd11.prod.outlook.com>
References: <20240930065245.2993767-1-zhenzhong.duan@intel.com>
 <CACGkMEuN0A8i1N2S8j+m1vx+Noy9Yxvt5TxHD3NYL2hHQKcRKA@mail.gmail.com>
In-Reply-To: <CACGkMEuN0A8i1N2S8j+m1vx+Noy9Yxvt5TxHD3NYL2hHQKcRKA@mail.gmail.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: SJ0PR11MB6744:EE_|DM4PR11MB8227:EE_
x-ms-office365-filtering-correlation-id: e2c6598a-6979-4c0a-361b-08dce8edb5d5
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0; ARA:13230040|1800799024|376014|366016|38070700018;
x-microsoft-antispam-message-info: =?utf-8?B?WmNIMjFNeExjZmVEZGVDTkF3eHdNSkFuMzl4bmY0WmhUVFJIZ1dDcnhuRU5S?=
 =?utf-8?B?RXJSMnQ5MTdHMC8veHV5V2dlaTZKbDc1TmZJTkdhZTVTZ0VZNDFSdjN3dzc5?=
 =?utf-8?B?TjExR3pJQmd3aUp4bnFhMkpTMHFQWXRtN0pzbFJMenJ3S1IyU1BZd1VIbDl0?=
 =?utf-8?B?eU9WMUoyUVRQNkEzTS9QbklYMzlFZEpwRnpwNWg1RXZNN1pWNDlHaWlLL1VZ?=
 =?utf-8?B?UTR0Q2NIUHpSdXkxUi9qTk5STEMvamdBZ2ZsNGZCZ3p6eWZCbzNIdmRRYllw?=
 =?utf-8?B?aVd0RVdLaERKRnlTMWhDMFZXazQ3WXJjclV0cFZIQnAyM3VGSUtGRHN3QXpa?=
 =?utf-8?B?SG5HMnU3Z0xIRHo1eGpwY3M5L3hSNWlXM1Q3dStPcmxoWXdKWjA1TG1nblky?=
 =?utf-8?B?NklDdmF6NmtUWExVNzQ4L1kyRmpnTk1kMkZ6WGhoOUNoeWppZ2tFdzdMK2lH?=
 =?utf-8?B?cHY5eTgvaFY1eTljdHU2V3R1cjRjNUJXWk4yc21LdU5IcVdIZ0p0Y1ZmZHlX?=
 =?utf-8?B?YkQvZXp5ZURHUnJodUtac09JQWdEdXR1dlQxcjJCSGg5dlJsaVhFTTBmWlV3?=
 =?utf-8?B?V0RleFFWd05rbStjZzhKY0p2bkhNMHJUKytUelNZbVRtY2tLVUFFVjFwRFZz?=
 =?utf-8?B?ZlVyUncxckN6eGlEOWZXemR6NGxVbDNpVEhZM3RQL0xzMGlxR2RseXEvc2Jr?=
 =?utf-8?B?SUZ6Q0I3R01iMk5tUEZFWjhodmM2QUlpTmttZEZDdkg5YlBLRFBhMHpRTngx?=
 =?utf-8?B?a3c1TFBnQmJLZDloUUgvZXRRSU50bTRmZ2MzYitvRUJIYjJKdWFIMnEyaHZR?=
 =?utf-8?B?Sm9YUDRJbFFyUUNXSXczcjUzOVhoNlBPZldOdStQZ2gwR0tKRnhuSi9kQjA5?=
 =?utf-8?B?ZVVjKzlXMnFIajNma3JLN2MzMGlwb2cxKzZtVVdWWFRmOWJ3ZmI2WlpKSXha?=
 =?utf-8?B?ZmprbzdEYlg0TEYxY0VEKytkZ1J0cS8za0xmQkhMcVJUQ1crajJxQ0RtTEtG?=
 =?utf-8?B?bEtRMlRpYTBHd0lRd1hjZm1UQ3J6enkxRmU4TS9IRjZZVXp4ZTZrZ2Z3VFU1?=
 =?utf-8?B?N2pkM05NVkU3WWFyU253eTNGT0t2Vmp2RjROS1VZWm5WQ3NYN0Jka3FoaDNs?=
 =?utf-8?B?bXNUSGhYeG9lZ1lKRStUeHRsV3BxSGpzOUJXYWFZUWNJTDlkUm9DWU9Ub24z?=
 =?utf-8?B?Um43NlVTZ2FWMTdDWWhIL3VSc1JlQXZOMld0dGdDZGFxMXJuMWtJcWZLQ3h4?=
 =?utf-8?B?V1dHZDFkYkVwQlFzT1Nlb1NCMVVmZHFBVURnc1BENHhkbGlacFg1YUNyNVVp?=
 =?utf-8?B?aTdheHhqUFhpWmNFNkVkTVhTRU1uR0N2bis3QklJc210dk1SK3V0dGRHNUR0?=
 =?utf-8?B?ZlZ2Mm03U2RVaGwrRjNYN2VRTFVPdXBPWXBKdEZkK1NtMzhNMXB4UFNMS0to?=
 =?utf-8?B?NE1ZQk01SGJmSVlJTWFZdWd4ZzNIc2MrWjNoU0o5ZTZMaHRpZ0xpbzBUVEJM?=
 =?utf-8?B?bUlabUJCWExCa0Y0dHFhZGVZc3NLaEZaSTdYMXZNWm4vQlpoZ3Rtc20yV2NJ?=
 =?utf-8?B?Q2t6ekZINlpGSXpRc3NzUzlKdjJ2OEt2Y1FaQ1pad0M1QmRCRFdLc25PRDVO?=
 =?utf-8?B?UE4vSENWdUFyZGlsY2hHTXF0Q1hGUmx3Rlh5Si9LMVpHblJabTVtQlFKbWJS?=
 =?utf-8?B?MEVYQlQ5WHNRVnNxTjBRS09CNWtTOEtzbVJPR3pELzV3RjMyZHBkS0lOeVBj?=
 =?utf-8?B?SWRrRnh1SzZSMnNhTHhWYi9RalBObUFZS3JxS1ZlZ3ZKMzBPMWFzUklMdW84?=
 =?utf-8?B?Y2JjZnpsNGxHalVpazN2dz09?=
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:SJ0PR11MB6744.namprd11.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(1800799024)(376014)(366016)(38070700018); DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?MGgvTlVEUTRJb3BnUmRDUmxvQWhaU01EN3JGUVFmbFJNTHBTVlBWLzZReXJk?=
 =?utf-8?B?L21FNFY1TGhmSzdNRWxiS3lTMTJ4TlAyb3YybWhPMEE1eGRlZ3d3SW9aY1Jx?=
 =?utf-8?B?MDRPQTl3NHJ2UnhVdkE4WjgxOUFCN254VGtLRVhZS2gxUXJNa1BZSGduTDhB?=
 =?utf-8?B?Qkt6UDBNQ3VZOUZSMERKMG4yNTJlSmtwaGpKa1pFMmZmcHdBUW50OVVjdGMr?=
 =?utf-8?B?QUswQit2MXdkWVMvcmROdkZqQVVqM2pQUUdVVGFjTTk2UlpaOVhwRS9pRTRn?=
 =?utf-8?B?UzFyeDZLSlFVaVlNa0E3ZkZIeWVGaisyVTVQcHNCamZheWw5TmdTMGs4VDZF?=
 =?utf-8?B?N1NkRHNIdy9EaHk1K3dlMjAzZXUrOHM2OTNNVktOUUVYS0pMY1JLVWFSVFZZ?=
 =?utf-8?B?dS9TbFJIREdKNU8zSGFtWVNidWRnejRybm1BZmNVS1hzRHJHWFYvZnBHMDNm?=
 =?utf-8?B?MnRuaUx3a2NGZEVTWGdjMlhVUVpHOWNWcHZ0c3ZyS1BRZFlOVC96OHFQTzNJ?=
 =?utf-8?B?eGpaY2N6OGV4OEFwQmtOZWtCNjltMFJRbFg0eGNENHc1aExYZGpEdWsyWUFM?=
 =?utf-8?B?RGptbGw0a2I0M1RFUnF2MElQQlNMbExJWmh0YjhsSDVXSXBQZGp4VTQ2c0dn?=
 =?utf-8?B?a1F5NXd5SStQZ3VyMTUxbnlBRDlTelFJV3VxTzBFczdaaUthVzFZOWttOWJi?=
 =?utf-8?B?K1NWT29WaDh0TVZOWEk0WGxhT3J0SHByN2w5SzdpcjNOWGJiVzNtZHY4Y3d3?=
 =?utf-8?B?bWlscW9Wd1pBbCtwdWsxVDI2d2hJMDNYajZjcWxhQnNwczlXSnpnUmk0TkM0?=
 =?utf-8?B?T3l6QWVTM3BpWTgyaGJ0T0RIVXFqeEI3MDBlRlZpaUUxSEYvcWhjcU1ncHUx?=
 =?utf-8?B?WGRZM0NQRkJHTjFpelNlQk02bk9kV2JNdTlNSFY2aERqWmlqamIxcWoxbVJB?=
 =?utf-8?B?VzdrWTlJTWtoYnpFYVhvd085bVFhZS9oeEt6Mkw0QmgrZ3h4WE5IUHR5Mnln?=
 =?utf-8?B?QmQyTWdwZk05UVV2eVZtMit2TW5lNjdMaW5vOFBxY0dzYms5b3hpb1ZheEdZ?=
 =?utf-8?B?TjJ0eHFmWEZQZFNQREEyd2U4YXRnSTNxRFhFNkR2Rnd0M0g3WjV0VFJEVmdm?=
 =?utf-8?B?RlNwOElEVUM5VVdVZEZlRnRPTWExTFhaS0drT2s3Nm1vMC9rb1MwVE95cFVz?=
 =?utf-8?B?eHJnRmovcFV0MUJyaHpGOFZiV3dlZ0lRM216RUdtWkEvSVBrTG1RNWxraXdZ?=
 =?utf-8?B?Yi9MY2F4WGN3UmlYbkR6N202ZUdycTVGc2F2NE9qakNXR1VOcS9YU2Y1Mlpy?=
 =?utf-8?B?TzRUOXJ6VEFJdXlUYTRjK25zTDJjWExVVkw4Sm1VUXg2YVBDM2FPOHpUOExR?=
 =?utf-8?B?eS8yMHlrN1lkenllcWtqUnlMVFFseWhQbHdTZ0svbHJoSjBIWDYwcW9wTTVZ?=
 =?utf-8?B?aFg3cVJOd0VzTVB2bHlOKzgzK2puY1hVZmtvTkZIZnh0RFRqUWtHN1kzQ3Ro?=
 =?utf-8?B?MWFYY2d4SWxYOXl3bS9BUW9TaTFxRkJ0LzFqTjNoQWttU2gzK21qR2cvOXB2?=
 =?utf-8?B?ZVJ4VHBlangrd0JXTC9sbXc1S0dyTklDaUxreG9xOHdyQWxzM09mVStRSzJM?=
 =?utf-8?B?YjhDV1Z0YjIwY0ttS0ZLUnRCWnB3bjFSOEFHanZLV0RNVjNoUG0xanBOU0Fx?=
 =?utf-8?B?aTN2RllKS0NPdEpVMXRPL1hlelZKS1EvU2xvYnlyZy9PK0xIajhpeXBkYWpD?=
 =?utf-8?B?bXlHOFNiemh0UXVKaVVvcWN2cjdSeXJHeXBtNG5jSlZONUt0b0QyUW9oL3pr?=
 =?utf-8?B?elhtUjRia0lXcjZRV0tNSU9HZUxTSU5hcERzOUlGeXlnY0NweTlJd3NQbFNT?=
 =?utf-8?B?ejNVdzNVWVJSUVY5MTlpY25JZGRKQnU0dzM2dXp0Y1J2R3U4ZXhzL0NkYnhT?=
 =?utf-8?B?c2UxUEJNKzA3d3E0MkNyVTRKQmx6T2ZFSytOR1d2dldnZ2VpN05qcjJlc0ZS?=
 =?utf-8?B?aFcxS2tIMkVEY3E1ckRyQUJ2UmFLbmxpWFRiOGFqZVUzeGFIanNkcWxUdlFz?=
 =?utf-8?B?eDJmVlBYVnd2b2U1cVRTUmV2bURMWWNZTHZva0lmb2NaWSsyazArVmh3N21s?=
 =?utf-8?Q?FIKFdM1PiSSbtAwQ+ZH4SyYmV?=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: SJ0PR11MB6744.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: e2c6598a-6979-4c0a-361b-08dce8edb5d5
X-MS-Exchange-CrossTenant-originalarrivaltime: 10 Oct 2024 05:38:03.5172 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: ztG0e+6d43ABi72S4G0QPT8okPltnKSjmsB93BhQMNDAsGxNIkg+KTEl3nLiim4/Upgl54/2Ch4xBEMQQTWfaypQYFshfthSga46wso4Pew=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM4PR11MB8227
X-OriginatorOrg: intel.com
Received-SPF: pass client-ip=192.198.163.14;
 envelope-from=zhenzhong.duan@intel.com; helo=mgamail.intel.com
X-Spam_score_int: -44
X-Spam_score: -4.5
X-Spam_bar: ----
X-Spam_report: (-4.5 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.151,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_MED=-2.3, RCVD_IN_MSPIKE_H2=-0.001,
 RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001, RCVD_IN_VALIDITY_SAFE_BLOCKED=0.001,
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

DQoNCj4tLS0tLU9yaWdpbmFsIE1lc3NhZ2UtLS0tLQ0KPkZyb206IEphc29uIFdhbmcgPGphc293
YW5nQHJlZGhhdC5jb20+DQo+U3ViamVjdDogUmU6IFtQQVRDSF0gaW50ZWxfaW9tbXU6IFJlbW92
ZSBUcmFuc2llbnQgTWFwcGluZyAoVE0pIGZpZWxkDQo+ZnJvbSBzZWNvbmQtbGV2ZWwgcGFnZS10
YWJsZXMNCj4NCj5PbiBNb24sIFNlcCAzMCwgMjAyNCBhdCAyOjU24oCvUE0gWmhlbnpob25nIER1
YW4NCj48emhlbnpob25nLmR1YW5AaW50ZWwuY29tPiB3cm90ZToNCj4+DQo+PiBWVC1kIHNwZWMg
cmVtb3ZlZCBUcmFuc2llbnQgTWFwcGluZyAoVE0pIGZpZWxkIGZyb20gc2Vjb25kLWxldmVsIHBh
Z2UtDQo+dGFibGVzDQo+PiBhbmQgdHJlYXQgdGhlIGZpZWxkIGFzIFJlc2VydmVkKDApIHNpbmNl
IHJldmlzaW9uIDMuMi4gVXBkYXRlIGNvZGUgdG8gbWF0Y2gNCj4+IHNwZWMuDQo+DQo+U29tZSBx
dWVzdGlvbnM6DQo+DQo+MSkgSXMgdGhlcmUgYSB2ZXJzaW9uIHJlZ2lzdGVyIGZvciB2dGQgc28g
ZHJpdmVyIGNhbiBrbm93PyBPdGhlcndpc2UNCj53ZSBtYXkgYnJlYWsgbWlncmF0aW9uIGNvbXBh
dGliaWxpdHkgc2lsZW50bHkuDQoNCldlIGhhdmUgYSBWRVJTSU9OIHJlZ2lzdGVyLCBidXQgaXQn
cyB1bnJlbGF0ZWQgdG8gcmV2aXNpb24uIFlpIGNhbiBmaXggbWUgaWYgSSB1bmRlcnN0YW5kIHdy
b25nLg0KDQpCaXQgVlREX1NMX1RNIGlzIG5vdCBlbXVsYXRlZCBpbiB2SU9NTVUgYnV0IE9TIGNh
biBzZXQgaXQsIGluZGVlZCBhIHBvc3NpYmlsaXR5IHRvIGJyZWFrIG1pZ3JhdGlvbi4NCg0KPjIp
IElzIHRoZXJlIGFueSB1c2VyIGZvciB0aGF0IGZpZWxkIGluIHRoZSBwYXN0Pw0KDQpUbyBiZSBo
b25lc3QsIEkgZG9uJ3Qga25vdy4gTGludXggZG9lc24ndCBzZXQgaXQuDQoNCj4gSWYgeWVzLCB3
ZSBwcm9iYWJseSBuZWVkIGEgbmV3IHBhcmFtZXRlciBmb3IgdGhpcy4NCg0KV2lsbCB0cnksIGUu
Zy4sICJ4LXN0YWxlLXRtIi4NCg0KVGhhbmtzDQpaaGVuemhvbmcNCg0KPg0KPlRoYW5rcw0KPg0K
Pj4NCj4+IFRoaXMgZG9lc24ndCBpbXBhY3QgZnVuY3Rpb24gb2YgdklPTU1VIGFzIHRoZXJlIHdh
cyBubyBsb2dpYyB0byBlbXVsYXRlDQo+PiBUcmFuc2llbnQgTWFwcGluZy4NCj4+DQo+PiBTdWdn
ZXN0ZWQtYnk6IFlpIExpdSA8eWkubC5saXVAaW50ZWwuY29tPg0KPj4gU2lnbmVkLW9mZi1ieTog
Wmhlbnpob25nIER1YW4gPHpoZW56aG9uZy5kdWFuQGludGVsLmNvbT4NCj4+IC0tLQ0KPj4gIGh3
L2kzODYvaW50ZWxfaW9tbXVfaW50ZXJuYWwuaCB8IDEzICsrKy0tLS0tLS0tLS0NCj4+ICBody9p
Mzg2L2ludGVsX2lvbW11LmMgICAgICAgICAgfCAxMSArKystLS0tLS0tLQ0KPj4gIDIgZmlsZXMg
Y2hhbmdlZCwgNiBpbnNlcnRpb25zKCspLCAxOCBkZWxldGlvbnMoLSkNCj4+DQo+PiBkaWZmIC0t
Z2l0IGEvaHcvaTM4Ni9pbnRlbF9pb21tdV9pbnRlcm5hbC5oDQo+Yi9ody9pMzg2L2ludGVsX2lv
bW11X2ludGVybmFsLmgNCj4+IGluZGV4IDEzZDVkMTI5YWUuLmM4MThjODE5ZmUgMTAwNjQ0DQo+
PiAtLS0gYS9ody9pMzg2L2ludGVsX2lvbW11X2ludGVybmFsLmgNCj4+ICsrKyBiL2h3L2kzODYv
aW50ZWxfaW9tbXVfaW50ZXJuYWwuaA0KPj4gQEAgLTQxMiw5ICs0MTIsNyBAQCB0eXBlZGVmIHVu
aW9uIFZUREludkRlc2MgVlRESW52RGVzYzsNCj4+ICAvKiBSc3ZkIGZpZWxkIG1hc2tzIGZvciBz
cHRlICovDQo+PiAgI2RlZmluZSBWVERfU1BURV9TTlAgMHg4MDBVTEwNCj4+DQo+PiAtI2RlZmlu
ZSBWVERfU1BURV9QQUdFX0wxX1JTVkRfTUFTSyhhdywgZHRfc3VwcG9ydGVkKSBcDQo+PiAtICAg
ICAgICBkdF9zdXBwb3J0ZWQgPyBcDQo+PiAtICAgICAgICAoMHg4MDBVTEwgfCB+KFZURF9IQVdf
TUFTSyhhdykgfCBWVERfU0xfSUdOX0NPTSB8DQo+VlREX1NMX1RNKSkgOiBcDQo+PiArI2RlZmlu
ZSBWVERfU1BURV9QQUdFX0wxX1JTVkRfTUFTSyhhdykgXA0KPj4gICAgICAgICAgKDB4ODAwVUxM
IHwgfihWVERfSEFXX01BU0soYXcpIHwgVlREX1NMX0lHTl9DT00pKQ0KPj4gICNkZWZpbmUgVlRE
X1NQVEVfUEFHRV9MMl9SU1ZEX01BU0soYXcpIFwNCj4+ICAgICAgICAgICgweDgwMFVMTCB8IH4o
VlREX0hBV19NQVNLKGF3KSB8IFZURF9TTF9JR05fQ09NKSkNCj4+IEBAIC00MjMsMTMgKzQyMSw5
IEBAIHR5cGVkZWYgdW5pb24gVlRESW52RGVzYyBWVERJbnZEZXNjOw0KPj4gICNkZWZpbmUgVlRE
X1NQVEVfUEFHRV9MNF9SU1ZEX01BU0soYXcpIFwNCj4+ICAgICAgICAgICgweDg4MFVMTCB8IH4o
VlREX0hBV19NQVNLKGF3KSB8IFZURF9TTF9JR05fQ09NKSkNCj4+DQo+PiAtI2RlZmluZSBWVERf
U1BURV9MUEFHRV9MMl9SU1ZEX01BU0soYXcsIGR0X3N1cHBvcnRlZCkgXA0KPj4gLSAgICAgICAg
ZHRfc3VwcG9ydGVkID8gXA0KPj4gLSAgICAgICAgKDB4MWZmODAwVUxMIHwgfihWVERfSEFXX01B
U0soYXcpIHwgVlREX1NMX0lHTl9DT00gfA0KPlZURF9TTF9UTSkpIDogXA0KPj4gKyNkZWZpbmUg
VlREX1NQVEVfTFBBR0VfTDJfUlNWRF9NQVNLKGF3KSBcDQo+PiAgICAgICAgICAoMHgxZmY4MDBV
TEwgfCB+KFZURF9IQVdfTUFTSyhhdykgfCBWVERfU0xfSUdOX0NPTSkpDQo+PiAtI2RlZmluZSBW
VERfU1BURV9MUEFHRV9MM19SU1ZEX01BU0soYXcsIGR0X3N1cHBvcnRlZCkgXA0KPj4gLSAgICAg
ICAgZHRfc3VwcG9ydGVkID8gXA0KPj4gLSAgICAgICAgKDB4M2ZmZmY4MDBVTEwgfCB+KFZURF9I
QVdfTUFTSyhhdykgfCBWVERfU0xfSUdOX0NPTSB8DQo+VlREX1NMX1RNKSkgOiBcDQo+PiArI2Rl
ZmluZSBWVERfU1BURV9MUEFHRV9MM19SU1ZEX01BU0soYXcpIFwNCj4+ICAgICAgICAgICgweDNm
ZmZmODAwVUxMIHwgfihWVERfSEFXX01BU0soYXcpIHwgVlREX1NMX0lHTl9DT00pKQ0KPj4NCj4+
ICAvKiBJbmZvcm1hdGlvbiBhYm91dCBwYWdlLXNlbGVjdGl2ZSBJT1RMQiBpbnZhbGlkYXRlICov
DQo+PiBAQCAtNTM2LDYgKzUzMCw1IEBAIHR5cGVkZWYgc3RydWN0IFZURFJvb3RFbnRyeSBWVERS
b290RW50cnk7DQo+PiAgI2RlZmluZSBWVERfU0xfVyAgICAgICAgICAgICAgICAgICAgKDFVTEwg
PDwgMSkNCj4+ICAjZGVmaW5lIFZURF9TTF9QVF9CQVNFX0FERFJfTUFTSyhhdykgKH4oVlREX1BB
R0VfU0laRSAtIDEpICYNCj5WVERfSEFXX01BU0soYXcpKQ0KPj4gICNkZWZpbmUgVlREX1NMX0lH
Tl9DT00gICAgICAgICAgICAgIDB4YmZmMDAwMDAwMDAwMDAwMFVMTA0KPj4gLSNkZWZpbmUgVlRE
X1NMX1RNICAgICAgICAgICAgICAgICAgICgxVUxMIDw8IDYyKQ0KPj4NCj4+ICAjZW5kaWYNCj4+
IGRpZmYgLS1naXQgYS9ody9pMzg2L2ludGVsX2lvbW11LmMgYi9ody9pMzg2L2ludGVsX2lvbW11
LmMNCj4+IGluZGV4IDA4ZmUyMTg5MzUuLmViNWFhMmIyZDUgMTAwNjQ0DQo+PiAtLS0gYS9ody9p
Mzg2L2ludGVsX2lvbW11LmMNCj4+ICsrKyBiL2h3L2kzODYvaW50ZWxfaW9tbXUuYw0KPj4gQEAg
LTQxMTEsOCArNDExMSw2IEBAIHN0YXRpYyB2b2lkIHZ0ZF9jYXBfaW5pdChJbnRlbElPTU1VU3Rh
dGUgKnMpDQo+PiAgICovDQo+PiAgc3RhdGljIHZvaWQgdnRkX2luaXQoSW50ZWxJT01NVVN0YXRl
ICpzKQ0KPj4gIHsNCj4+IC0gICAgWDg2SU9NTVVTdGF0ZSAqeDg2X2lvbW11ID0gWDg2X0lPTU1V
X0RFVklDRShzKTsNCj4+IC0NCj4+ICAgICAgbWVtc2V0KHMtPmNzciwgMCwgRE1BUl9SRUdfU0la
RSk7DQo+PiAgICAgIG1lbXNldChzLT53bWFzaywgMCwgRE1BUl9SRUdfU0laRSk7DQo+PiAgICAg
IG1lbXNldChzLT53MWNtYXNrLCAwLCBETUFSX1JFR19TSVpFKTsNCj4+IEBAIC00MTM3LDE2ICs0
MTM1LDEzIEBAIHN0YXRpYyB2b2lkIHZ0ZF9pbml0KEludGVsSU9NTVVTdGF0ZSAqcykNCj4+ICAg
ICAgICogUnN2ZCBmaWVsZCBtYXNrcyBmb3Igc3B0ZQ0KPj4gICAgICAgKi8NCj4+ICAgICAgdnRk
X3NwdGVfcnN2ZFswXSA9IH4wVUxMOw0KPj4gLSAgICB2dGRfc3B0ZV9yc3ZkWzFdID0gVlREX1NQ
VEVfUEFHRV9MMV9SU1ZEX01BU0socy0+YXdfYml0cywNCj4+IC0gICAgICAgICAgICAgICAgICAg
ICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgIHg4Nl9pb21tdS0+ZHRfc3VwcG9ydGVkKTsN
Cj4+ICsgICAgdnRkX3NwdGVfcnN2ZFsxXSA9IFZURF9TUFRFX1BBR0VfTDFfUlNWRF9NQVNLKHMt
PmF3X2JpdHMpOw0KPj4gICAgICB2dGRfc3B0ZV9yc3ZkWzJdID0gVlREX1NQVEVfUEFHRV9MMl9S
U1ZEX01BU0socy0+YXdfYml0cyk7DQo+PiAgICAgIHZ0ZF9zcHRlX3JzdmRbM10gPSBWVERfU1BU
RV9QQUdFX0wzX1JTVkRfTUFTSyhzLT5hd19iaXRzKTsNCj4+ICAgICAgdnRkX3NwdGVfcnN2ZFs0
XSA9IFZURF9TUFRFX1BBR0VfTDRfUlNWRF9NQVNLKHMtPmF3X2JpdHMpOw0KPj4NCj4+IC0gICAg
dnRkX3NwdGVfcnN2ZF9sYXJnZVsyXSA9IFZURF9TUFRFX0xQQUdFX0wyX1JTVkRfTUFTSyhzLQ0K
Pj5hd19iaXRzLA0KPj4gLSAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAg
ICAgICAgICAgICB4ODZfaW9tbXUtPmR0X3N1cHBvcnRlZCk7DQo+PiAtICAgIHZ0ZF9zcHRlX3Jz
dmRfbGFyZ2VbM10gPSBWVERfU1BURV9MUEFHRV9MM19SU1ZEX01BU0socy0NCj4+YXdfYml0cywN
Cj4+IC0gICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAg
eDg2X2lvbW11LT5kdF9zdXBwb3J0ZWQpOw0KPj4gKyAgICB2dGRfc3B0ZV9yc3ZkX2xhcmdlWzJd
ID0gVlREX1NQVEVfTFBBR0VfTDJfUlNWRF9NQVNLKHMtDQo+PmF3X2JpdHMpOw0KPj4gKyAgICB2
dGRfc3B0ZV9yc3ZkX2xhcmdlWzNdID0gVlREX1NQVEVfTFBBR0VfTDNfUlNWRF9NQVNLKHMtDQo+
PmF3X2JpdHMpOw0KPj4NCj4+ICAgICAgaWYgKHMtPnNjYWxhYmxlX21vZGUgfHwgcy0+c25vb3Bf
Y29udHJvbCkgew0KPj4gICAgICAgICAgdnRkX3NwdGVfcnN2ZFsxXSAmPSB+VlREX1NQVEVfU05Q
Ow0KPj4gLS0NCj4+IDIuMzQuMQ0KPj4NCg0K

