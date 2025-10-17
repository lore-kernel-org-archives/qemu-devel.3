Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5AD26CCD183
	for <qemu-devel@archiver.kernel.org>; Fri, 17 Oct 2025 02:32:39 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1v9aF3-0008TL-AC; Thu, 16 Oct 2025 22:30:53 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <zhenzhong.duan@intel.com>)
 id 1v9aF0-0008St-Ba
 for qemu-devel@nongnu.org; Thu, 16 Oct 2025 22:30:50 -0400
Received: from mgamail.intel.com ([198.175.65.11])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <zhenzhong.duan@intel.com>)
 id 1v9aEf-00076f-57
 for qemu-devel@nongnu.org; Thu, 16 Oct 2025 22:30:46 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1760668229; x=1792204229;
 h=from:to:cc:subject:date:message-id:references:
 in-reply-to:content-transfer-encoding:mime-version;
 bh=0Rtzn3GKzwMe6tdnTzIYAls1GRhe/r1GfLr4XDpT7xU=;
 b=dvyYx0DQEnuMS04JTi1c9u+58JaxT8u7YhnrVuwpnhaxXXtz3Mtt6UR+
 xIWtCZzS+jOmRekSwDTcQIightNviV70EwPFj1RLMfWnnUd1rn57f+P4i
 shrHxy4zQEBYwRfa0jxlIWijZZAF2tu60d+kS41+RklcfD6QpeIzhD44e
 L7Dk0o+dS2g2ZFrkDuvbdUbZ0L5Daw19tp2mdpNe8wcTgWh8xDHgLLnAh
 NDUFr5r74yTyoaj81fFXieGOGtFGJshbzRR87sh2hwwxrhMZBQh5pf+75
 LhO4UIluu7/CAuVEva8QdLwUFwO8x/Y8rXfAQnNfzfer4s3zA3JxtSg6r g==;
X-CSE-ConnectionGUID: Unmzuqg3Q267qvH6ZWORhg==
X-CSE-MsgGUID: jLpvVcoMSwi0fdrWzxbVYg==
X-IronPort-AV: E=McAfee;i="6800,10657,11584"; a="73160038"
X-IronPort-AV: E=Sophos;i="6.19,234,1754982000"; d="scan'208";a="73160038"
Received: from fmviesa009.fm.intel.com ([10.60.135.149])
 by orvoesa103.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 16 Oct 2025 19:30:14 -0700
X-CSE-ConnectionGUID: HScd0BVJRZ2FbyIM24Zcyw==
X-CSE-MsgGUID: fvGhlIuYSgW6EWqD365TRQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.19,234,1754982000"; d="scan'208";a="183089541"
Received: from fmsmsx902.amr.corp.intel.com ([10.18.126.91])
 by fmviesa009.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 16 Oct 2025 19:30:14 -0700
Received: from FMSMSX901.amr.corp.intel.com (10.18.126.90) by
 fmsmsx902.amr.corp.intel.com (10.18.126.91) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.27; Thu, 16 Oct 2025 19:30:13 -0700
Received: from fmsedg902.ED.cps.intel.com (10.1.192.144) by
 FMSMSX901.amr.corp.intel.com (10.18.126.90) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.27 via Frontend Transport; Thu, 16 Oct 2025 19:30:13 -0700
Received: from PH8PR06CU001.outbound.protection.outlook.com (40.107.209.15) by
 edgegateway.intel.com (192.55.55.82) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.27; Thu, 16 Oct 2025 19:30:13 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=YuyhRzg9ddBrBFJADAThykg5Uw18wHRStvGM9gVzq2xN/yvUs8vLBXbFtzseZlhRFLP3TMWgqM2sGVWUpKDFsCk7Ckv3132sULNElyLOhAZQR+MjdzA8fD91N/1EgM1eb5Jb/rKECHsicJFbYSc1OJA0qc6onS02v1B+INoOwtz8sUQN19PAl6LZo3maO6BBd9fRIoWYbBJcy5Avl3j7UBdTVz/l2E3A46FrdHtLOKiZZObOlVTcuMy5ie1HyWOOGtI9q++0+dKdjxISLg8ciTXKW1mVmGVyhS3AtzrxYvLe1r3Oz/v8K6X36izDTFqpOMcvC6WzjL0I+0sm91TA5Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=0Rtzn3GKzwMe6tdnTzIYAls1GRhe/r1GfLr4XDpT7xU=;
 b=uKWhPrGC2d8h+3LM59iIJWKTPP9UMVeXxOZZRVpL9xzVdn6ptkyNxQOhC7wve4GsAMVpKZXbQKhZQSAaAGG6TmSlW44kNjDAMCSduauM41I+oKwuhxcqwFmlwXIxThYzFIgSeiBS7Y7fSsSLmmFsDBB8fdwjWvoMLlIDiKN/sVsukL1Qv5QA/t1qQwoFHJtJ4bO5hiLd8xQCKi/3oUkvvyLGvBjKMPNTTLbyr5+mGecc3s7XjOF4gi9PF2bMoEXzjpG0NMM8P0OJo17EsnFExndZL+9CTyehGD3yYGj4RDyC6RDQA9WoQh4qd1md7fdRWj8K5vXZnIw9oqf5GdFdVw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Received: from IA3PR11MB9136.namprd11.prod.outlook.com (2603:10b6:208:574::12)
 by SJ2PR11MB7715.namprd11.prod.outlook.com (2603:10b6:a03:4f4::20)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9228.12; Fri, 17 Oct
 2025 02:30:05 +0000
Received: from IA3PR11MB9136.namprd11.prod.outlook.com
 ([fe80::604b:77a4:b1be:3f13]) by IA3PR11MB9136.namprd11.prod.outlook.com
 ([fe80::604b:77a4:b1be:3f13%7]) with mapi id 15.20.9228.010; Fri, 17 Oct 2025
 02:30:05 +0000
From: "Duan, Zhenzhong" <zhenzhong.duan@intel.com>
To: "Liu, Yi L" <yi.l.liu@intel.com>, "qemu-devel@nongnu.org"
 <qemu-devel@nongnu.org>
CC: "mst@redhat.com" <mst@redhat.com>, "jasowang@redhat.com"
 <jasowang@redhat.com>, "peterx@redhat.com" <peterx@redhat.com>,
 "clement.mathieu--drif@eviden.com" <clement.mathieu--drif@eviden.com>
Subject: RE: [PATCH v2 2/3] intel_iommu: Reset pasid cache when system level
 reset
Thread-Topic: [PATCH v2 2/3] intel_iommu: Reset pasid cache when system level
 reset
Thread-Index: AQHcPnDvdqCaHeKYh0qiRJL1HVG00rTEsPeAgADtIEA=
Date: Fri, 17 Oct 2025 02:30:05 +0000
Message-ID: <IA3PR11MB913667B7D9D76793B8CDC63292F6A@IA3PR11MB9136.namprd11.prod.outlook.com>
References: <20251016074544.377637-1-zhenzhong.duan@intel.com>
 <20251016074544.377637-3-zhenzhong.duan@intel.com>
 <4205373d-b583-4d6b-8004-d86e51082375@intel.com>
In-Reply-To: <4205373d-b583-4d6b-8004-d86e51082375@intel.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: IA3PR11MB9136:EE_|SJ2PR11MB7715:EE_
x-ms-office365-filtering-correlation-id: 194d93fd-c65b-4212-b43b-08de0d25152f
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0; ARA:13230040|1800799024|366016|376014|38070700021;
x-microsoft-antispam-message-info: =?utf-8?B?QU9HcWFGQWVXTjFpS3ZmVjVRM2xOaUdWOGppa2lldjdiWXdxeTVsbkl2MzlG?=
 =?utf-8?B?U05ZMlVNaUxiR1RGaDNIZTltdFhTeGgvYzkxMTRCSmtpYUYzekdTeDlhZjlJ?=
 =?utf-8?B?WVJwMUl3M3NuSXB6aUc3RHVRU0RQaENTVkIvRXEwVzlFdGEwOUptdHE2TWR6?=
 =?utf-8?B?cS9CZExMeUUwTFJQUEtDOVBQNERqL3VnRzZmY2xZUW00c2g3dWxNU1RST3Fx?=
 =?utf-8?B?YTFSemVGOExwQTQ4MUQ1WkVjUGlxd0M5NzI4QnVjY0MyWWFrcnU1cTRXNDVN?=
 =?utf-8?B?ZENGMWZBOHhGTEpMSk9YZm5SMmVHd3lCY0JnL3pmMUNHYTRtV01zZjIxeVA4?=
 =?utf-8?B?bFlST2NlV20xM3laLzU5bjB3ZndERFVCRlJ6VS8rUGNLNkpsWU81dmRRSFZU?=
 =?utf-8?B?Sk1LOEN6cGFSNENWaXVlU3hFRW1wMUhDcGUvSEFtOGxPTEpVazN1SmZTM1g2?=
 =?utf-8?B?NnlnTmtlVHk4WExZcnJqZWNqa0lVYUFKb0Q0TUJUUWFDckRUTjNwV1NIdlhX?=
 =?utf-8?B?N0taMUhmdHE2RXRLT2FidFFadnBScy9Xbko2WVpCKzNzcnJ0NjZ2RjZqWW1t?=
 =?utf-8?B?VHpiR2ROd1BNUFcvdHJzK2xQZ1MzUjlpRGlMd1hVTHMxM0FLVm1sbW1ZSzBG?=
 =?utf-8?B?N1FndTRCaTZFNkFTUTNEenZYYzJJVTRSdTZPRkVYSG5vZzlrQnFNWmd3SWg1?=
 =?utf-8?B?NzRFK2FIVmxCckxaM3ZNWDNyTVdoQ3YxRWd6d1BOeThpQTZCZzU0TU1TM2RP?=
 =?utf-8?B?dkYrM0VJYlNZc2UvQy90bTlDNkE3QVh1MHM4RkZmbXl0Mm0zc0pMc08vdE1F?=
 =?utf-8?B?T1JEYVV5VS9hbVFyTyswbk9mSzgwblp4OEtwdzQ5OFRnc0JxSWlyVEVVTmM1?=
 =?utf-8?B?ZkxjYnB2b3BGR090RWVJNHZpTDd1RzJFQVhJcUZtV3VPdWtUWW0zNUJLdU95?=
 =?utf-8?B?TzhnTWFMZEF6cWgrbjVFMzI5czlIaWlYcVJMOGRNRFBNd2lLYUdKRmhYVjdp?=
 =?utf-8?B?emduaGJnN2VpazNUNFdVcGRWZG9nYzVBUlZldFVxM0M4Qk5ZSG1nVGJwY0Nr?=
 =?utf-8?B?RlNjMlpvd0kyd1JCSEZaTkMzLy92Yk44SXk3ZGZNQXNrSmE5a1ptNkdOU2xP?=
 =?utf-8?B?cUxPQ3FTaTM2REVmbGsvOTdrUWhJK2lnTGpxWkgweldZQzBuWHF4UzNXL3Nt?=
 =?utf-8?B?a0hrRHRTNmh2enhYYjlreTdWRThUaHYyRDN3cGg0Z3BlSzB6NGtTMVpqRU5W?=
 =?utf-8?B?TXh1SE9NSVZzVHpDZWRGNSthZmJPbVFhM3duQlhPK2dWNHV6anVxSHpsWWw0?=
 =?utf-8?B?ellKdmNKNFhFODAwcGRNc2lsV0dYc3dGWWU4OHlaQktUa1RjZVdoM1VxLzJ3?=
 =?utf-8?B?U1l2ZXdVZVF6aC9abG5nNnZtWDVabmhQYzYvcGxRb2tXMHFLY1hIT3pZYlJQ?=
 =?utf-8?B?Um1wWTRuNFBnWkJ3aVRZNVJCL0xiNHM0aElJZk5EOEllQmNTcDBnQkx3NTIw?=
 =?utf-8?B?bWo2Ky9obGFTV1Flai9zTjdOTmNicFJCem52WWVhSVVqby9WYUgxc1dwUEJW?=
 =?utf-8?B?QkZmeExKNUJ0UDNCRXRyYzZ0K3NZcyt0VURCOGpoenJQUlh3U21xbTIxUWlx?=
 =?utf-8?B?VG9yYzN3RHo2TVN4V01SYVF6cjluclkxVHFWSDRRdFJLWmxXWUVkZ3YwM0Rm?=
 =?utf-8?B?YTRheHRVSDZVem1hVmhVbzgwTFU2RE5ZWVdZcVVRaFU0bWpIbHlhUkFhbVBs?=
 =?utf-8?B?bFZXcFJBQm9HazBXby9Ga3grV3NoekMrRXJuckpDbi9EeW0yWEpMSWsyVXBU?=
 =?utf-8?B?RnVPTlQrdC9JT0lrTDVYb0MyWHlrRUc3NlpCZjZoc3pHWFRsQ1l6dFJibzFF?=
 =?utf-8?B?Y0NRVWxoZVo4S2VjMGJqRnlWdFYrUkJHZVVjd1lSVXFjTTZxT0diYTIwektu?=
 =?utf-8?B?cTh6SnhZSlhHME1IMXI3d0IzQ05oamdFTFVja1pJalZ3cTVNSlhad1VkcUtD?=
 =?utf-8?B?YWJpR2NLc2JsSFlscFRDSHByUjFYcWFNOEx6RzdUdUI2T3hHZ1MzK3pEZ3BL?=
 =?utf-8?Q?rMelpb?=
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:IA3PR11MB9136.namprd11.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(1800799024)(366016)(376014)(38070700021); DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?ZFdBMWhiMGNMTmtxZGUyL3oxRzRDb1c3dG5ZODJaQzJETEM5aHFjMmprSjA4?=
 =?utf-8?B?UE9XLy9lMzNveU5GdlJheUIxVWdTcmFSS3R4NUt6cDdibmppNkNhdUk0YmVp?=
 =?utf-8?B?RGM2UUdOTDBBZDVXUjNxcVdYUWxVZzl2aytyQWRWZkYwTk9vQ1M3bU4xRnJ1?=
 =?utf-8?B?dFZHZjFaYkFZSVZudGVLR0pzclJlL0VwTHRjd0pEVGpIVlBHd2dUdGRQUnlT?=
 =?utf-8?B?dHFFTXdpRFJ6NVhmUDZPZUtybzI4M2ltcWxPK1RMaEVQMytLWktNZWxyNGVm?=
 =?utf-8?B?OHZHN0dUaW9TRE0ycVc5eUl2N3RWNDl6bGJpT0ZhRG44dkZIa1ZwdytRR3Y1?=
 =?utf-8?B?Mk0wK01TNlI4bTRiaXVwTVBGaWZCcWtsWEhNcjNKdVRzYUZobDNGaVlNdXlH?=
 =?utf-8?B?MEMwUTFIZzNidVFuYVVFZDhaMkNGWVIrQ0d0S0gwKzhCQ3E2YklNSlpOR1hz?=
 =?utf-8?B?M1p2YVIvQUwrdzFFaGFRbTFZY1dPclFST0gvSXBqTURiaVJUR09JbitvR3F1?=
 =?utf-8?B?SXhKOFMrVnlrdkxhRUI3Q3k0S0NDVzBQTDZMcVZDY21hVzFzeVk5RXUzb2V5?=
 =?utf-8?B?OVpDUWNJYlY5aVlDQ1RMWk52NjRQdlJHd1JVSy9wVkJZT3BKMzZwczJ4RmJ0?=
 =?utf-8?B?U1MxNVZ3aW9KaW5sek1MMlI5UGdwV2dmOVFCQ3dKWjZrN25VWW9QWTl6M2Jx?=
 =?utf-8?B?eFhKdEhRWGFGMUlHN3kvNUliZGdVMEp6amJyY1pnTTlPMGZScUtnaGRqcC93?=
 =?utf-8?B?bTV2cThFN2tXM2JrbHBpS2dleHcwZlNKR1k0SUpMRkRMVFZWWFBYNUZYYkkx?=
 =?utf-8?B?Y2prSHU0WnQwMVZiejdFdW85M0JTdTNvZUJ4dEFraFR4WWp4WHl3WEh4elJR?=
 =?utf-8?B?NU92YU9DdkhCNjVxSmVtcWFGRS9tNU00WWdnRzd4RHRQdEU0SmpzalZHMzlH?=
 =?utf-8?B?ZVZtVGM0Y3pvQTZmZ3RzSitpZVJEK2ViZ1J0ZG1JeGdldms4NzUvdkc2OXdk?=
 =?utf-8?B?cDRvWFV0UkF1WTROVGpWT2NLQXlNb2pzSzBkNWl5d2FtTmtHUjFzRFlBbG5r?=
 =?utf-8?B?UEN1c3IrWE1hRlI2Nk5MNFVZeUtKaUhpTVBBK1k0Tkl3Ky9RUVo1bEEzVVdC?=
 =?utf-8?B?UEJzVm13ZmpNbXNLeWhrR0s4eDU0ak1iNUVFUVJMRWxwMWx0WElocE1qSDVr?=
 =?utf-8?B?ajlOZitQZFhGb1IyMTdQZjM3Wmk3YW1DeldKRjRqUnN1K2d4SU83SEEzU0ZI?=
 =?utf-8?B?Slg4Y01UOGUzelFZTktkdC9ZOC95amcxdXowWk9SQU56UG1RTFpVUXgyZms5?=
 =?utf-8?B?MWZVMmdUeGxjdytiMk8wb0xXVWtRUVR0ZE81VmJ4NXhwbWtkeHo0ZjJ1TG9B?=
 =?utf-8?B?S2Q2Qkdad3F5c05DNm5SOU5ERzZNdEdveEJtYUFwd05oTDlIVktMYXNyUFpi?=
 =?utf-8?B?RUlCTGk1b3luc1BlamZYNHJpSS9tT012SGxXd1VYaWkrMGlZcG0wSGJMTy83?=
 =?utf-8?B?d1V0alFQS2lGZ216dXhzTlBWQVFGekh1SkZqVitkeWNtZWxSRkc1UllkTGNw?=
 =?utf-8?B?NU5nWlc2bmIwNk5JN1dLWHpxeGZwaUFuWkhpNnhnRFc5TDk4Z28vT0pod1RB?=
 =?utf-8?B?cElHeVk4YmlVSXA4NWw2cnpaeElpTWxYd2ZBRkpwQWdnb3lOTGUzWXFHVzhM?=
 =?utf-8?B?RlkrVWxpbXp2RnBiUnBsK1ZrbWxURDgvMm96bXo5YWNVN0ZRSTZlL2c4M0V4?=
 =?utf-8?B?M0ZITGszM2hBSSt4R1VMOUZORXRXV1l6NzVUdVYzcFRVdktVbUpoUlFXR3V4?=
 =?utf-8?B?SFJWWG1EeVNBaC9jcnE4Mk5TS1lUaEFQc3RQSEorRFRyU2dwWlYwV3NZTXpC?=
 =?utf-8?B?cDVGM0pZZW5LazRBRGNMTDdxbGQ3dElKM2hWMDBtc3E2SFJHd2RGZXBNeWpD?=
 =?utf-8?B?ckJ6d3VxanlRZ0JqcVdZQ2VPSTZIaCtoMFRxTEJvenNCbkt5Y0w2V1lDZlZP?=
 =?utf-8?B?VHRrRzA3NUhwSlVlcEorbHUyM0tIU2NTUkZQczJ3VVE3bU9WT3RvbU16Uzc2?=
 =?utf-8?B?eU9xRVFOZ2QrMHNJM2ZjSkt1a05rOW82YWxnMTFXbTl3NkJwRTVPL0ZySDdl?=
 =?utf-8?Q?6+L/niHUSVrrIqdN1CApJHaip?=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: IA3PR11MB9136.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 194d93fd-c65b-4212-b43b-08de0d25152f
X-MS-Exchange-CrossTenant-originalarrivaltime: 17 Oct 2025 02:30:05.3433 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: vI0jnI6zKvQ5UwxV+dWJZ0lL2Fac6AV9+5v22ClKraw0IjOaeX1r9gIEH+pGSXNDBtv6BwIMBvoJv/yOgXRiYP3d5K3vaafDq+jMpjgKnhg=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ2PR11MB7715
X-OriginatorOrg: intel.com
Received-SPF: pass client-ip=198.175.65.11;
 envelope-from=zhenzhong.duan@intel.com; helo=mgamail.intel.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
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

DQoNCj4tLS0tLU9yaWdpbmFsIE1lc3NhZ2UtLS0tLQ0KPkZyb206IExpdSwgWWkgTCA8eWkubC5s
aXVAaW50ZWwuY29tPg0KPlN1YmplY3Q6IFJlOiBbUEFUQ0ggdjIgMi8zXSBpbnRlbF9pb21tdTog
UmVzZXQgcGFzaWQgY2FjaGUgd2hlbiBzeXN0ZW0NCj5sZXZlbCByZXNldA0KPg0KPk9uIDIwMjUv
MTAvMTYgMTU6NDUsIFpoZW56aG9uZyBEdWFuIHdyb3RlOg0KPj4gUmVzZXQgcGFzaWQgY2FjaGUg
d2hlbiBzeXN0ZW0gbGV2ZWwgcmVzZXQuIEN1cnJlbnRseSB3ZSBkb24ndCBoYXZlIGFueQ0KPj4g
ZGV2aWNlIHN1cHBvcnRpbmcgUEFTSUQgeWV0LiBTbyBhbGwgYXJlIFBBU0lEXzAsIGl0cyB2dGRf
YXMgaXMgYWxsb2NhdGVkDQo+PiBieSBQQ0kgc3lzdGVtIGFuZCBuZXZlciByZW1vdmVkLCBqdXN0
IG1hcmsgcGFzaWQgY2FjaGUgaW52YWxpZC4NCj4+DQo+PiBTaWduZWQtb2ZmLWJ5OiBZaSBMaXUg
PHlpLmwubGl1QGludGVsLmNvbT4NCj4+IFNpZ25lZC1vZmYtYnk6IFpoZW56aG9uZyBEdWFuIDx6
aGVuemhvbmcuZHVhbkBpbnRlbC5jb20+DQo+PiAtLS0NCj4+ICAgaHcvaTM4Ni9pbnRlbF9pb21t
dS5jIHwgMTYgKysrKysrKysrKysrKysrKw0KPj4gICBody9pMzg2L3RyYWNlLWV2ZW50cyAgfCAg
MSArDQo+PiAgIDIgZmlsZXMgY2hhbmdlZCwgMTcgaW5zZXJ0aW9ucygrKQ0KPj4NCj4+IGRpZmYg
LS1naXQgYS9ody9pMzg2L2ludGVsX2lvbW11LmMgYi9ody9pMzg2L2ludGVsX2lvbW11LmMNCj4+
IGluZGV4IGM0N2YxM2I2NTkuLjA3YmMwYTc0OWMgMTAwNjQ0DQo+PiAtLS0gYS9ody9pMzg2L2lu
dGVsX2lvbW11LmMNCj4+ICsrKyBiL2h3L2kzODYvaW50ZWxfaW9tbXUuYw0KPj4gQEAgLTg3LDYg
Kzg3LDIxIEBAIHN0cnVjdCB2dGRfaW90bGJfa2V5IHsNCj4+ICAgc3RhdGljIHZvaWQgdnRkX2Fk
ZHJlc3Nfc3BhY2VfcmVmcmVzaF9hbGwoSW50ZWxJT01NVVN0YXRlICpzKTsNCj4+ICAgc3RhdGlj
IHZvaWQgdnRkX2FkZHJlc3Nfc3BhY2VfdW5tYXAoVlREQWRkcmVzc1NwYWNlICphcywNCj5JT01N
VU5vdGlmaWVyICpuKTsNCj4+DQo+PiArc3RhdGljIHZvaWQgdnRkX3Bhc2lkX2NhY2hlX3Jlc2V0
X2xvY2tlZChJbnRlbElPTU1VU3RhdGUgKnMpDQo+PiArew0KPj4gKyAgICBWVERBZGRyZXNzU3Bh
Y2UgKnZ0ZF9hczsNCj4+ICsgICAgR0hhc2hUYWJsZUl0ZXIgYXNfaXQ7DQo+PiArDQo+PiArICAg
IHRyYWNlX3Z0ZF9wYXNpZF9jYWNoZV9yZXNldCgpOw0KPj4gKw0KPj4gKyAgICBnX2hhc2hfdGFi
bGVfaXRlcl9pbml0KCZhc19pdCwgcy0+dnRkX2FkZHJlc3Nfc3BhY2VzKTsNCj4+ICsgICAgd2hp
bGUgKGdfaGFzaF90YWJsZV9pdGVyX25leHQoJmFzX2l0LCBOVUxMLCAodm9pZCAqKikmdnRkX2Fz
KSkgew0KPj4gKyAgICAgICAgVlREUEFTSURDYWNoZUVudHJ5ICpwY19lbnRyeSA9ICZ2dGRfYXMt
PnBhc2lkX2NhY2hlX2VudHJ5Ow0KPj4gKyAgICAgICAgcGNfZW50cnktPnZhbGlkID0gZmFsc2U7
DQo+PiArICAgIH0NCj4NCj5kbyB5b3UgaGF2ZSBhbnkgc3BlY2lhbCByZWFzb24gdG8gdXNlIHRo
aXMgdmVyc2lvbj8gVG8gbWUsIHRoZSBwcmlvcg0KPnZlcnNpb24gbG9va3MgYmV0dGVyLiBJIHRo
aW5rIGdsb2JhbCByZXNldCBhbHNvIG5lZWQgdG8gYmUgZm9sbG93ZWQNCj5ieSBzd2l0Y2ggYXMg
YW5kIGFzIHN5bmMuIHJpZ2h0PyBUaGUgcHJpb3IgdmVyc2lvbiBzdXBwb3J0cyBpdCBvbmNlDQo+
cGF0Y2ggMDMgaXMgYXBwbGllZC4NCg0KRHVyaW5nIHN5c3RlbSByZXNldCwgdnRkX3Jlc2V0X2V4
aXQoKSBjYWxscyB2dGRfYWRkcmVzc19zcGFjZV9yZWZyZXNoX2FsbCgpIHRvIGRvIHRoZSBzYW1l
IHdvcmssIGl0J3MgZHVwbGljYXRlZCBpZiBJIGRvIGl0IGFnYWluIGluIHBhY2hfY2FjaGVfcmVz
ZXQuDQoNClRoYW5rcw0KWmhlbnpob25nDQo=

