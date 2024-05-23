Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 94FCFC25B75
	for <qemu-devel@archiver.kernel.org>; Thu, 23 May 2024 08:44:14 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sA43G-0007JY-W9; Thu, 23 May 2024 04:43:55 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <zhenzhong.duan@intel.com>)
 id 1sA43A-0007EU-EE; Thu, 23 May 2024 04:43:49 -0400
Received: from mgamail.intel.com ([198.175.65.15])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <zhenzhong.duan@intel.com>)
 id 1sA438-00066z-KT; Thu, 23 May 2024 04:43:48 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1716453827; x=1747989827;
 h=from:to:cc:subject:date:message-id:references:
 in-reply-to:content-transfer-encoding:mime-version;
 bh=MKazf4IPGzGSvPftz3mjT/WVhOW3V6KYdOWQX5ZB90U=;
 b=ncLeZ1wTetGSNWgdQTaFD3B3XjDBr0+ICGBSdkzs1aNc5s6NEwn8rP2n
 aXMMhPLphjpw9AOIwkZoz/ouIjoBKlAWf9sfjmW7mB+DztDS445OgQSHg
 t2SfIGyKzBFszKLHAw6yNMk7DJnVOyfnLvz/Y5N5gcEORu5ZRqFdevyBE
 l0DcZV28oqFRVmre6H5iWR1XW50dzkL72mjWNReqfbMAxHcJScKkVsS9A
 ans6XHCVpCWrXGLyihpdPoqAKvOg5R0StFtV+YiQ3Eihdr5WraSpd290U
 LKffD+85odJ7A0XZOBEjzLsIZDXWDIDikjbRN2l7NpgNl71/S/Y4u2uxQ A==;
X-CSE-ConnectionGUID: nfZSwSmdR9CWDdA4vXhLGA==
X-CSE-MsgGUID: ZrsDQXlTTn+YyqyG3bhKaA==
X-IronPort-AV: E=McAfee;i="6600,9927,11080"; a="16543757"
X-IronPort-AV: E=Sophos;i="6.08,182,1712646000"; d="scan'208";a="16543757"
Received: from orviesa005.jf.intel.com ([10.64.159.145])
 by orvoesa107.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 23 May 2024 01:43:45 -0700
X-CSE-ConnectionGUID: 3a31LWhhSNO1GYOLce7GMw==
X-CSE-MsgGUID: aaPYHkciSE2fjpkE2JqNeg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.08,182,1712646000"; d="scan'208";a="38423005"
Received: from orsmsx601.amr.corp.intel.com ([10.22.229.14])
 by orviesa005.jf.intel.com with ESMTP/TLS/AES256-GCM-SHA384;
 23 May 2024 01:43:45 -0700
Received: from orsmsx610.amr.corp.intel.com (10.22.229.23) by
 ORSMSX601.amr.corp.intel.com (10.22.229.14) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.39; Thu, 23 May 2024 01:43:44 -0700
Received: from orsedg603.ED.cps.intel.com (10.7.248.4) by
 orsmsx610.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.39 via Frontend Transport; Thu, 23 May 2024 01:43:44 -0700
Received: from NAM12-BN8-obe.outbound.protection.outlook.com (104.47.55.168)
 by edgegateway.intel.com (134.134.137.100) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.39; Thu, 23 May 2024 01:43:44 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=WaUTOU88GJR3XC3s9XGd8M4ROrXR6MpAvu5s0NYGoM6UXQ0wPGz5Pg8e1BXuF2DMsGUNAajR+q1ZKyKWDGyBykNV7qTTG7xhnF5E3yhS9hlOBqBQ5XVb3G4Y5kAx0PbrbBi0rzTa5NDTGjLiD1SU9yzj7pEjMjEA2YQBlOsAmWWRwtKRqSuF/RWE/v+t1OVET9RIgkXSXkSNB1xMHj0OIpamHbYfQ+6qOEui43sEXF/6T1e8mPTAYWJnnJIJ+SE/WSd3tskaabHrdK4zUpfGFfeAjgSuWTNJxk+QH9s5aa2I0RTAtpUZPV3WotWre86gE/Y5vhaPu2cFHZgE/jL/KA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=MKazf4IPGzGSvPftz3mjT/WVhOW3V6KYdOWQX5ZB90U=;
 b=fAZpqSYdLVdc8p9F0QstYGr234cY5+J3m+7JIm8k1TEt8EUDa9HfRgM64Ooq6R1WOnAqLGc3z74ExFQwHsG/iRW0LqUaiGx7Q0xnRDQiEpSRj8cP2JTcigRbIYMGRA2OdSErFYMFOkE1MTcMHAZFNMU6GZexeQKtAKWEWa/lzD4iRSFgLzwS6xFxIsF/BKBTUo3XLE6Hr6YS6pGonmGLz1YmPlReeVhWpLxo9kHIEHXh6ejEgy7Gnh70/Kk9b+kgu5NWaa8xLr47J+1OJJM5AB540bBpYIrlbksgN8l9tR3dlKeiJUwhVyz3Fu+MZ2JcerdFzo6U6aBWp+VZFH52Qw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Received: from SJ0PR11MB6744.namprd11.prod.outlook.com (2603:10b6:a03:47d::10)
 by CO1PR11MB4849.namprd11.prod.outlook.com (2603:10b6:303:90::13)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7611.19; Thu, 23 May
 2024 08:43:42 +0000
Received: from SJ0PR11MB6744.namprd11.prod.outlook.com
 ([fe80::fe49:d628:48b1:6091]) by SJ0PR11MB6744.namprd11.prod.outlook.com
 ([fe80::fe49:d628:48b1:6091%7]) with mapi id 15.20.7611.016; Thu, 23 May 2024
 08:43:42 +0000
From: "Duan, Zhenzhong" <zhenzhong.duan@intel.com>
To: =?utf-8?B?Q8OpZHJpYyBMZSBHb2F0ZXI=?= <clg@redhat.com>,
 "qemu-devel@nongnu.org" <qemu-devel@nongnu.org>
CC: "qemu-s390x@nongnu.org" <qemu-s390x@nongnu.org>, Thomas Huth
 <thuth@redhat.com>, Matthew Rosato <mjrosato@linux.ibm.com>, Eric Farman
 <farman@linux.ibm.com>, Tony Krowiak <akrowiak@linux.ibm.com>
Subject: RE: [PATCH 2/7] s390x/css: Make CCWDeviceClass::realize return bool
Thread-Topic: [PATCH 2/7] s390x/css: Make CCWDeviceClass::realize return bool
Thread-Index: AQHarGnLDsxz2xN9K02N+LblBY3usrGkgafA
Date: Thu, 23 May 2024 08:43:42 +0000
Message-ID: <SJ0PR11MB6744F53938B89F70AED5569692F42@SJ0PR11MB6744.namprd11.prod.outlook.com>
References: <20240522170107.289532-1-clg@redhat.com>
 <20240522170107.289532-3-clg@redhat.com>
In-Reply-To: <20240522170107.289532-3-clg@redhat.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: SJ0PR11MB6744:EE_|CO1PR11MB4849:EE_
x-ms-office365-filtering-correlation-id: 6b525d56-32f9-4742-d555-08dc7b047327
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0; ARA:13230031|1800799015|366007|376005|38070700009;
x-microsoft-antispam-message-info: =?utf-8?B?bWgvSlVjZmhzSFhDZVY1Um55Ujl3TmtBUm51b2ZBL0VCa2JXUHdiT014UFN5?=
 =?utf-8?B?eUUzeGdWaVh1akcxTkh0eTArMUJGVkFNZ0ZQY0Z2TXlaNWZycFRFVTM1MUc3?=
 =?utf-8?B?QWEwU1ZBQ3dkRG9NYmtGZlZ0RmlxQWw1MTJaWkt1M1Boc3VDMnlqUGFKaGdk?=
 =?utf-8?B?bVFuUVRWVnpTYXFmS3hMUFJxa0d4d09yR0tXOERxbUYvSzUwcFJ1R2d5V1Za?=
 =?utf-8?B?dkxmSWdyeGJQakZ4T1pncWpZWGdLb2RycFMrQlR2c3NFb3dUOStheFFGTlRL?=
 =?utf-8?B?SUY2bUYwbUxDOFhIcXgwaStzZFpGSFNnRkVGL0t5TkQ5THh5QWVMaTZOQTdI?=
 =?utf-8?B?anJXQldwUnlqZlFpaDF1KytpVHJITEhJeUlrR0ZLU1hSM0tkOUhoeWxRenk1?=
 =?utf-8?B?Q2lqSzF1ZnFKMGpLa2VGZ2dBL2w5L1h4Y1AwemhCWkVrMExNdUpzcFlNcWVD?=
 =?utf-8?B?cFFqaVRsWWpVbnZwL0Z4SjBWN2k3L3Z2UEVVSlZrTmRsNnR3STAra1NFaEE1?=
 =?utf-8?B?Y2xQVG5EUUNRdk5EcEkwUlJ4YkNyYVJaTFYvZHZLNU9UMy9JZ0E1Z0F6Y2VF?=
 =?utf-8?B?QlB2dVVVaWd0VC9RdllOQ2FjNnFmV3JVcTNXR3FydnB3TVRUSnozbDgxNFhk?=
 =?utf-8?B?d2tsbFEwZUNUb3Q5SGtVK3llYjN2aXRKYlJmOUM2d0lCS05KWTN3clF6b3RY?=
 =?utf-8?B?elFLRDJlMC9zb08zbFliZVd4T0Y5QkpvOEU0d0tGdDRjT0dhTkFEbU04dVM0?=
 =?utf-8?B?Y1g0bXdtSFFwMnQ3b2JweFdOdFZtTDVYSDh6ellXaStPYUlBVTVncWpvWTJq?=
 =?utf-8?B?NGpFOERxMmRVTU0rT2VLZVc4UlQyQzAvVEFKM2hYUWU3QmJJaS9kbHpldkJ0?=
 =?utf-8?B?dWxFb3VxWmtMS016WFVRN3NydGdsd25EMml3L1gyQ0k4MWhINGc4TG5sRUlk?=
 =?utf-8?B?YjVHTm5OWE1hVzdSMDIzcmVTWHZTV3crRW9tZTBVVWd2RGxaNVpFVEZOMFMv?=
 =?utf-8?B?OFgrL0FtR0t3N0xYWjdFZ01QbGdqWUdmbWdUWWJieWlxZUhVY1NJUXZSMkZY?=
 =?utf-8?B?UXgzSmE4S0ZXVlJpbHhnbmd1RWhxUmVudVd0aTlueDNPTlk0bVRoam1qWVlP?=
 =?utf-8?B?VUV5NnFha2RIV1A5eVlWQm1hbUlpV3VIbFZNVU5wbnQyNlZubGlsOGdWcHRw?=
 =?utf-8?B?OXVIbi9yankxUlMrbHFiMU4zTmxZRExwbDVOODBBeWhFN3ZHRFN4enFkRDhU?=
 =?utf-8?B?L0Nzc0gyYmpMN2hxM3hIZXhWRXFpaVV6M1BhUFI2RDlzSlhmaEZJRjZJdGtV?=
 =?utf-8?B?aXEyTlcrWERtTFdkcEMrai9JUEF5YjJNZmZYZEREa1prNERsYjgxNnB4VGt2?=
 =?utf-8?B?dXpmQ3c2U21tVkk5Um9lbHo2QWVqdkFBNFJ5bXM0NDNBaFlIV25QNTFiclI1?=
 =?utf-8?B?V08wOHJSUXdkNVNUU2IzbER2T2NlbUZjWnZTUmlMVGdGQ1UxMVdDak1KZm1H?=
 =?utf-8?B?TzlEbjhJOTNoMUl4VGZBaS9zNFgzUUR1Q0w3YS9sL3dGZjhIeWowcloxRXJI?=
 =?utf-8?B?TWR1Y2JMTngvUHFKUTU5V3lqdENkNEZSM1crbkJvTHQ1ZytZQ2JYWlBIME5v?=
 =?utf-8?B?QTZEMDl2aHdLTkE0ZzJISzYxT002TUlodUx3Z2VGMjUzRzFwc3ZjVUwySmJX?=
 =?utf-8?B?blBkbWhLUDZqL014MlpocFBaOEJKVjc1NnlOR0x0NTZMeWxIeVI1UkxpM2lm?=
 =?utf-8?B?b1FzeWcxd3lxQm5ScEQvMWZiT082eXFVTzN2ZjMrclh3WEQ4L0VEQXVlUGdP?=
 =?utf-8?B?NGl5SXlYQW1ic3pmaGtFZz09?=
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:SJ0PR11MB6744.namprd11.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230031)(1800799015)(366007)(376005)(38070700009); DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?NjlIcVQ1elNvUElmWldqaGxnZUJxd2FiSEV3T2pyMmVrOXNiYkYvN0pndWtB?=
 =?utf-8?B?VC9neW9jUzhrODhQWHZNTCtybWwyczBoQlFOdWJDZXEzUGZQZTBGQkpKUnVE?=
 =?utf-8?B?bEdDejBKSmdheGlKQm1sNThFOEFXcmlzMkV5SFhIK0tuZ3FqZk5qSm1mWkZn?=
 =?utf-8?B?blVNM29CcjlDMTBpbStUcUo2aDZ3THlrdklVTUcyaEErdit0QzZiRlRYZDFw?=
 =?utf-8?B?ZEQvYmYwU2RtQVVBSDQzczEwc2RhckcwWlJjaGRrVzJnbjRnaUo1a3JHTDRX?=
 =?utf-8?B?U21nUWJqcHFCZkVRdnpLVGVsbGVOZTB1UktTQkNrcGVrM0p0ZlRGcFd6VWc4?=
 =?utf-8?B?MFpMeXMzY0JoQVRzay9Oc3lNWklyaDRTVzhUNkwrWW5OUEhUSnJwd0Ivdms0?=
 =?utf-8?B?RGdNREhUYVNFemd6Nm1pV1FsQmlHcDUvMHlib1k3OWJPamdpOGpBWWtXMFpp?=
 =?utf-8?B?K2VYc3hNRXkvOE1nb2dsemJpSG5sZkNwTXdIalBNMkZGckp1aktEZjF4anl4?=
 =?utf-8?B?UWZoMmNJT0ZrSVB5UVRlRXFLNUlSOFduY2hxQlFHOFhVTnZUd25tWCsyWmpy?=
 =?utf-8?B?eFFaNDUrZjhUbEIrOGU4UGYwSjdPVi93ZlIwcm9sWmlSRkF1dlM2VEdlZzAx?=
 =?utf-8?B?YXA2a0piT0kzdGwvRkttWUVVSnRhOWdtSUE5V2ZHbmNWUjZDNGJEdWQwd3N0?=
 =?utf-8?B?MlhBNUozeTdpcE1wT2sxNjU2c2E4MzRwVVFzRE1mNm80Z3JtWWVXaXVocS84?=
 =?utf-8?B?UWQ2QUFaQnU5dytaeFdqSWZVaStlbWVEVjhzLzlzaEsyOGxHc2xlS0RUYTdi?=
 =?utf-8?B?bFk4RFdlVmxjNk54KzFZZkxnT3ZsWVhScW9yTzVEOFZSSXlxSmxnVWZqWnhV?=
 =?utf-8?B?VkVSczJnb2kvakQ3c0pVU1ExblNtZFF6S0lydmF5MkRtUnV4NDhxYzl0N1RM?=
 =?utf-8?B?WGZnempMTUdmL3JJSVFudWVWSFpiWk9uSzNFcy8vWEVZSnFNVXdFUGVEOUpV?=
 =?utf-8?B?RENSZlNYaTF3T0psZWxpbDQzcnAzdU1zWW11MWxUWTBGVEc2UVFHdlYrQ3VK?=
 =?utf-8?B?ZEpLUXJkcXEyeHlxSDRTMWxMRG5GRW1DcHdYbld3R21NbC9ZenFERjN4UUVH?=
 =?utf-8?B?Tm55enBIR2kwUkNUb1F6M3p5aG0xU0U1emNXeHJZRjVzeWhUMTh0d3BpNjB5?=
 =?utf-8?B?bFZsWVBYS1lBQkcxelFCc0plM0szM0gvaFZnRzVBVXA0czgzamFBRHo3aEYy?=
 =?utf-8?B?b3lGdjdpa2ZLWTVTVXRuWUozbzB2RFV0QlFMcC85VkRId0pYZ1puOUlQYUF2?=
 =?utf-8?B?QTJmb0R2d1d3YzZ2TTVxQ0IvSHZEb25HQ3dvclkxeFM4cWc1bVIyV09WbnZz?=
 =?utf-8?B?OXJYd2MzUGM2Z2dLa2Z2ejNJTHYzMksySmdla1BjSXVpa3NmeEl4eklISnV3?=
 =?utf-8?B?bVVCcTBaQ292Y1BJOUNJb09WL1dsTmUwWUs0Vm1DNnRQdDVVT0RMOEtXSkhy?=
 =?utf-8?B?bTFKWkc3Uis1Qm1MUGZtdWpuOXV4clFmdDRydWxSb2Q5V2M4V0FOMm94b3Y3?=
 =?utf-8?B?TFZ3c3gxaWFXdXZGUUo1eURrcTgva1FVUk9nektRR3FER0Q3c2FubXlYdHZG?=
 =?utf-8?B?Y2ZSbUw4SUgxVytOVEp6SFJnTTNhZ0hYeHE3b3AxWk1MMmV3SGFUQlQ5YS8w?=
 =?utf-8?B?dlhaYzJSWmk2R1IvYWVyMWUyRVkwc0Y2a1FtNXhkNWV3VEFvUE5UTzk4TWtN?=
 =?utf-8?B?U1RGcnFBcGlKY1BjRnVUSmc2eFdnK1FJZ2JOQnpOZnpqYTNBNTcwOE9zeExa?=
 =?utf-8?B?REZ4OGVPSVNKZmpkTGU1L3hycFlvTlRuSHlwdzhWYjlMZ0RpYlVFLzVNdVJD?=
 =?utf-8?B?VFd1TGd5VzJZYmRsbUM2dWJXTHZ1WDYzTmZCTjM2aE0rb0M4YUxacFVqYmZK?=
 =?utf-8?B?S3V3TzhsenNwVGo3Y2ZGQnk2dU9LSGZuQjZUOTIwUnJuL3JIYm53T0Z4cVNG?=
 =?utf-8?B?UGt1VkNQSXVFZ3RUVmRMSlBTTDNKc1hLRFFTeHFnWjQ3KzNpWXpKTVRYQ3pO?=
 =?utf-8?B?SHo0eG8xQ2F6VnlZV3ErbjNDUTE4aVFhME43MVVmV0ZUZFk1UGROamFweXQx?=
 =?utf-8?Q?5evlATAwToqFrrJj7vopM4uVZ?=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: SJ0PR11MB6744.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 6b525d56-32f9-4742-d555-08dc7b047327
X-MS-Exchange-CrossTenant-originalarrivaltime: 23 May 2024 08:43:42.1219 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: s7dGdncsj5w7POVi0NSK3+jhNU6rGC8HI1vGRExFcKZEufCwWMsBWi6m6UGmGz5Hf6xo+RkaqrThqCqXc5gOPO9NRRC4bPtErwaOJIoQ8zc=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CO1PR11MB4849
X-OriginatorOrg: intel.com
Received-SPF: pass client-ip=198.175.65.15;
 envelope-from=zhenzhong.duan@intel.com; helo=mgamail.intel.com
X-Spam_score_int: -43
X-Spam_score: -4.4
X-Spam_bar: ----
X-Spam_report: (-4.4 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_MED=-2.3, SPF_HELO_NONE=0.001,
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
IDxjbGdAcmVkaGF0LmNvbT4NCj5TdWJqZWN0OiBbUEFUQ0ggMi83XSBzMzkweC9jc3M6IE1ha2Ug
Q0NXRGV2aWNlQ2xhc3M6OnJlYWxpemUgcmV0dXJuIGJvb2wNCj4NCj5TaW5jZSB0aGUgcmVhbGl6
ZSgpIGhhbmRsZXIgb2YgQ0NXRGV2aWNlQ2xhc3MgdGFrZXMgYW4gJ0Vycm9yICoqJw0KPmFyZ3Vt
ZW50LCBiZXN0IHByYWN0aWNlcyBzdWdnZXN0IHRvIHJldHVybiBhIGJvb2wuIFNlZSB0aGUgYXBp
L2Vycm9yLmgNCj5SdWxlcyBzZWN0aW9uLiBXaGlsZSBhdCBpdCwgbW9kaWZ5IHRoZSBjYWxsIGlu
IHMzOTBfY2N3X3JlYWxpemUoKS4NCj4NCj5TaWduZWQtb2ZmLWJ5OiBDw6lkcmljIExlIEdvYXRl
ciA8Y2xnQHJlZGhhdC5jb20+DQoNClJldmlld2VkLWJ5OiBaaGVuemhvbmcgRHVhbiA8emhlbnpo
b25nLmR1YW5AaW50ZWwuY29tPg0KDQpUaGFua3MNClpoZW56aG9uZw0KDQo+LS0tDQo+IGh3L3Mz
OTB4L2Njdy1kZXZpY2UuaCB8IDIgKy0NCj4gaHcvczM5MHgvY2N3LWRldmljZS5jIHwgMyArKy0N
Cj4gaHcvczM5MHgvczM5MC1jY3cuYyAgIHwgMyArLS0NCj4gMyBmaWxlcyBjaGFuZ2VkLCA0IGlu
c2VydGlvbnMoKyksIDQgZGVsZXRpb25zKC0pDQo+DQo+ZGlmZiAtLWdpdCBhL2h3L3MzOTB4L2Nj
dy1kZXZpY2UuaCBiL2h3L3MzOTB4L2Njdy1kZXZpY2UuaA0KPmluZGV4DQo+NmRmZjk1MjI1ZGYx
MWM2M2Y5YjY2OTc1MDE5MDI2YjIxNWM4YzQ0OC4uNWZlZWIwZWU3YTI2OGI4NzA5MDQzYg0KPjVi
YmM1NmIwNmU3MDdhNDQ4ZCAxMDA2NDQNCj4tLS0gYS9ody9zMzkweC9jY3ctZGV2aWNlLmgNCj4r
KysgYi9ody9zMzkweC9jY3ctZGV2aWNlLmgNCj5AQCAtMzYsNyArMzYsNyBAQCBleHRlcm4gY29u
c3QgVk1TdGF0ZURlc2NyaXB0aW9uIHZtc3RhdGVfY2N3X2RldjsNCj4gc3RydWN0IENDV0Rldmlj
ZUNsYXNzIHsNCj4gICAgIERldmljZUNsYXNzIHBhcmVudF9jbGFzczsNCj4gICAgIHZvaWQgKCp1
bnBsdWcpKEhvdHBsdWdIYW5kbGVyICosIERldmljZVN0YXRlICosIEVycm9yICoqKTsNCj4tICAg
IHZvaWQgKCpyZWFsaXplKShDY3dEZXZpY2UgKiwgRXJyb3IgKiopOw0KPisgICAgYm9vbCAoKnJl
YWxpemUpKENjd0RldmljZSAqLCBFcnJvciAqKik7DQo+ICAgICB2b2lkICgqcmVmaWxsX2lkcyko
Q2N3RGV2aWNlICopOw0KPiB9Ow0KPg0KPmRpZmYgLS1naXQgYS9ody9zMzkweC9jY3ctZGV2aWNl
LmMgYi9ody9zMzkweC9jY3ctZGV2aWNlLmMNCj5pbmRleA0KPmZiOGMxYWNjNjRkNTAwMmM4NjFh
NDkxM2YyOTJkODM0NmRiZWYxOTIuLmE3ZDY4MmU1YWY5Y2U5MGU3ZTJmYWQ4DQo+YzI0YjMwZTM5
MzI4YzdjZjQgMTAwNjQ0DQo+LS0tIGEvaHcvczM5MHgvY2N3LWRldmljZS5jDQo+KysrIGIvaHcv
czM5MHgvY2N3LWRldmljZS5jDQo+QEAgLTMxLDkgKzMxLDEwIEBAIHN0YXRpYyB2b2lkIGNjd19k
ZXZpY2VfcmVmaWxsX2lkcyhDY3dEZXZpY2UgKmRldikNCj4gICAgIGRldi0+c3ViY2hfaWQudmFs
aWQgPSB0cnVlOw0KPiB9DQo+DQo+LXN0YXRpYyB2b2lkIGNjd19kZXZpY2VfcmVhbGl6ZShDY3dE
ZXZpY2UgKmRldiwgRXJyb3IgKiplcnJwKQ0KPitzdGF0aWMgYm9vbCBjY3dfZGV2aWNlX3JlYWxp
emUoQ2N3RGV2aWNlICpkZXYsIEVycm9yICoqZXJycCkNCj4gew0KPiAgICAgY2N3X2RldmljZV9y
ZWZpbGxfaWRzKGRldik7DQo+KyAgICByZXR1cm4gdHJ1ZTsNCj4gfQ0KPg0KPiBzdGF0aWMgUHJv
cGVydHkgY2N3X2RldmljZV9wcm9wZXJ0aWVzW10gPSB7DQo+ZGlmZiAtLWdpdCBhL2h3L3MzOTB4
L3MzOTAtY2N3LmMgYi9ody9zMzkweC9zMzkwLWNjdy5jDQo+aW5kZXgNCj5hMDZlOTFkZmIzMThl
MzUwMDMyNDg1MTQ4OGM1NjgwNmZhNDZjMDhkLi40YjhlZGU3MDFkZjkwOTQ5NzIwMjYNCj4yYjZm
YzFiNjVmNGU1MDVlMzRkIDEwMDY0NA0KPi0tLSBhL2h3L3MzOTB4L3MzOTAtY2N3LmMNCj4rKysg
Yi9ody9zMzkweC9zMzkwLWNjdy5jDQo+QEAgLTEzNyw4ICsxMzcsNyBAQCBzdGF0aWMgdm9pZCBz
MzkwX2Njd19yZWFsaXplKFMzOTBDQ1dEZXZpY2UgKmNkZXYsDQo+Y2hhciAqc3lzZnNkZXYsIEVy
cm9yICoqZXJycCkNCj4gICAgICAgICBnb3RvIG91dF9lcnI7DQo+ICAgICB9DQo+DQo+LSAgICBj
ay0+cmVhbGl6ZShjY3dfZGV2LCAmZXJyKTsNCj4tICAgIGlmIChlcnIpIHsNCj4rICAgIGlmICgh
Y2stPnJlYWxpemUoY2N3X2RldiwgJmVycikpIHsNCj4gICAgICAgICBnb3RvIG91dF9lcnI7DQo+
ICAgICB9DQo+DQo+LS0NCj4yLjQ1LjENCg0K

