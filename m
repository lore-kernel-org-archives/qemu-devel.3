Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 57A01C28B30
	for <qemu-devel@archiver.kernel.org>; Thu, 20 Mar 2025 09:26:24 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tvC9q-0001ZC-Nh; Thu, 20 Mar 2025 05:25:46 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <zhenzhong.duan@intel.com>)
 id 1tvC9o-0001XG-HF
 for qemu-devel@nongnu.org; Thu, 20 Mar 2025 05:25:44 -0400
Received: from mgamail.intel.com ([198.175.65.13])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <zhenzhong.duan@intel.com>)
 id 1tvC9m-0004hG-J7
 for qemu-devel@nongnu.org; Thu, 20 Mar 2025 05:25:44 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1742462742; x=1773998742;
 h=from:to:cc:subject:date:message-id:references:
 in-reply-to:content-transfer-encoding:mime-version;
 bh=MWtc6iRyBDeI8IaHdObhxvlwPyM/yNbvx8/waxgZO60=;
 b=OmEp9eZdgLaKXouj3As9glRmNgL/qXthlcJFo6HjdCQPDtrBhie/Y8H4
 8mDZbrFVus6EGmc5dY4x6IgEpNL5NdN3DCsFnIqa2UFfR1Ng9S7YKspVs
 HJf+3tP2BaDph934fHXEjluxwBdBufVq5dHO85yOu4pEyepcvfSxUwT7s
 HrLAKslzAJ0IwRGHJS/A+PLQhVDnHWMB1Tx2Z+2WOxP0DUTXfktKo9CWj
 dZM0ijvM5zqZHng+wwIqRGOd32ZuZPQQAug5J0y1H77d/P0cciiVRWh8Z
 m03xT17SMNQtAmKckv/tGbZDjnCXObKBGupyHviGTh3qNtbJlO9Jq/upa w==;
X-CSE-ConnectionGUID: MkAZJbdvRpiaAMF7xZibwQ==
X-CSE-MsgGUID: bJSBmxVaR0q50VTgDEVAlQ==
X-IronPort-AV: E=McAfee;i="6700,10204,11378"; a="54675378"
X-IronPort-AV: E=Sophos;i="6.14,261,1736841600"; d="scan'208";a="54675378"
Received: from orviesa004.jf.intel.com ([10.64.159.144])
 by orvoesa105.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 20 Mar 2025 02:25:38 -0700
X-CSE-ConnectionGUID: AHUPCDAhQwit9t6Bs/HF6Q==
X-CSE-MsgGUID: VfYT+xAsTvm3r9eaTUwYvQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.14,261,1736841600"; d="scan'208";a="128102152"
Received: from orsmsx901.amr.corp.intel.com ([10.22.229.23])
 by orviesa004.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 20 Mar 2025 02:25:38 -0700
Received: from orsmsx601.amr.corp.intel.com (10.22.229.14) by
 ORSMSX901.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.2.1544.14; Thu, 20 Mar 2025 02:25:37 -0700
Received: from orsedg603.ED.cps.intel.com (10.7.248.4) by
 orsmsx601.amr.corp.intel.com (10.22.229.14) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.44 via Frontend Transport; Thu, 20 Mar 2025 02:25:37 -0700
Received: from NAM11-CO1-obe.outbound.protection.outlook.com (104.47.56.169)
 by edgegateway.intel.com (134.134.137.100) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.44; Thu, 20 Mar 2025 02:25:37 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=kdRmp4L3DVYy5DN+XtkkUh1RwnAOlr+6xqeYcVOSII7wk+WfHl2xIIeWi04N0Nbj2RSKXvGcIqIHieDPeQ5SDZY5Sf/PG7XE15S97H3IYha8R9rlYTvW6M7i5MkM6aI+8e76ee9uIAfrOqADH5MbpMUibSktNbQS7uzTehmWmgLM9F17NFLHmdrOfQAzyTx6xa7Wopv5LDncXHzHmH4OzBIlKFWfr2LxQ4eoAF8SSLw6wU1Ogh3gZaPsnuPt9u4FwvLbBpyKnWszgMHzDoq3dLmDOhwaUn6KNRgpTRmrYTVSjOH3Msl9Fn464zuNgfkjCVHVJMxQcosGiRQExnyBNQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=MWtc6iRyBDeI8IaHdObhxvlwPyM/yNbvx8/waxgZO60=;
 b=spxqWMFNCResBFGZ97xw4aanwSUy8UXG+dtOczis3CgUtpyGhWLhGQlcEvB6aOGzX74gcAs6HwcU/Kq7z820tCH8D7Pu/8Y1ALBkjCo+9knjkBM6ve3UN5JwVGniUXtKFgiF4GTZC49vEkHeIdpa0mG3VfaeaSIY6/9q0D2K2VJKka9CYwaetEU7QYx7WOUhuNvFtZsqnkcdji3W23Ptq8O6eNDW1w4J/I9nTHUdJlp4tDHmSooBjEafe9pwQn2ziH/9FrBAwGnbrd9XdjQ+DxWh+8sS71HcvhOo7/N69Y2+pwKTxWrQ1TVSjfC/pcyg93MjySSpkhclFHOt1QnP6w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Received: from SJ0PR11MB6744.namprd11.prod.outlook.com (2603:10b6:a03:47d::10)
 by SA0PR11MB4574.namprd11.prod.outlook.com (2603:10b6:806:71::11)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8534.35; Thu, 20 Mar
 2025 09:24:55 +0000
Received: from SJ0PR11MB6744.namprd11.prod.outlook.com
 ([fe80::fe49:d628:48b1:6091]) by SJ0PR11MB6744.namprd11.prod.outlook.com
 ([fe80::fe49:d628:48b1:6091%6]) with mapi id 15.20.8534.034; Thu, 20 Mar 2025
 09:24:54 +0000
From: "Duan, Zhenzhong" <zhenzhong.duan@intel.com>
To: =?utf-8?B?Q8OpZHJpYyBMZSBHb2F0ZXI=?= <clg@redhat.com>,
 "qemu-devel@nongnu.org" <qemu-devel@nongnu.org>, Alex Williamson
 <alex.williamson@redhat.com>
CC: Avihai Horon <avihaih@nvidia.com>, Eric Auger <eric.auger@redhat.com>
Subject: RE: [PATCH for-10.1 11/32] vfio: Introduce a new header file for
 VFIOcontainer declarations
Thread-Topic: [PATCH for-10.1 11/32] vfio: Introduce a new header file for
 VFIOcontainer declarations
Thread-Index: AQHbl+vj+sOPwtjyEE+UyjQGM3RrwLN7w+eg
Date: Thu, 20 Mar 2025 09:24:54 +0000
Message-ID: <SJ0PR11MB6744ADF311E245B39E08CB5492D82@SJ0PR11MB6744.namprd11.prod.outlook.com>
References: <20250318095415.670319-1-clg@redhat.com>
 <20250318095415.670319-12-clg@redhat.com>
In-Reply-To: <20250318095415.670319-12-clg@redhat.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: SJ0PR11MB6744:EE_|SA0PR11MB4574:EE_
x-ms-office365-filtering-correlation-id: 45bdb979-77a4-46fc-898c-08dd6791135c
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0; ARA:13230040|366016|1800799024|376014|38070700018;
x-microsoft-antispam-message-info: =?utf-8?B?QW1jcGRGS2pTTEJEZHA3dmpjWUV2OC9BeDdvVDE0a1g5SzFUNnNpN1A1Qndi?=
 =?utf-8?B?WThRWTVaYXMwWDhxN3duQUdKY3FJTjIyeERzWE92SFZwalhYN05RUS9FQ09O?=
 =?utf-8?B?dXlUTzQrOGtXV3NwKy9FSkxnRXQ3NVFJcFI3eGJtUUxJd1JtOVlJNWdxWVRm?=
 =?utf-8?B?dG1ENHd3YjFSTUZqVkhLZTczZWZKT1BWRkxybWFIcmtSUHk1QlphdW5xK3FF?=
 =?utf-8?B?M2JTZ1M0bWN1a1IyTENpWmNlMVc3Q2lCZVpTL3I1aTZGeGVEeXpkOUZtWVlR?=
 =?utf-8?B?VXNSb0plMitaTy9RajROK2xGcUZndlo0dk9jK0VGT0t6cjZJS2FvR05oUmhL?=
 =?utf-8?B?eEViVTU3dmo2TGdMcm5qQ3h2UG5EZHhzTVR3YjNrcEFwS2F6WThrS3FXSzBT?=
 =?utf-8?B?TVdCRGU2OEhzRGhSeUpuWTE3WE9aL2tsRFk4ZENkaUZ1N1pxRjhQaFlreG9K?=
 =?utf-8?B?R1EwRXd2Ri9Hd3NvVzFQNit3eS9kTnFTU1RxUVdRV0JJalRDRnluVm1BOFNk?=
 =?utf-8?B?QUpHVnpJbW9tMy9qWkpSNE54L29HWW5TMklJdUtUTlJEVUk0VEZHMlJhTFdT?=
 =?utf-8?B?S0xKU1pYU0xzWC9EWUVNSjNnQWlvbStzMUt2TXlDdEJlVHRhZSs4eVNnZmlZ?=
 =?utf-8?B?SGlQUFBIL1g2cjZxdTRCNmFjSDF1YWw0KzM5SXR5QTVSNnlyeEFSKzYzcWdj?=
 =?utf-8?B?WjB0RlA4OGZZTWFRZFN2dzlVcmxqbUxDQkV3MWp5Rmc2OEcrdXhVejBaS1lo?=
 =?utf-8?B?WW85ZUh6RDVwSDU3a3NPMWtJMHkwdTcyTFBiYlNNV0VycE9ERGczSmhjV0JH?=
 =?utf-8?B?MkZKd3kxcDJhWEdJZVNIVWZtR3F2U2s0dGMvTXp5Sk1NQ2ZPVEZVRFFsazBG?=
 =?utf-8?B?MWlCVndCRTRvT2p1dzg1ODF5SG1SNGNQSm1JbXJLelFTVGhmbWxnSitOeTlr?=
 =?utf-8?B?MEZmMUVYa0g0a1FxYzd4UnNCNHBtSWxqM3hHb1JFSGtBOVVzWFhhdE5sK1Bq?=
 =?utf-8?B?YXpOK0JLU3hoek5kOTMrMVFQbmJrQUliWXREdTA1SjA0NExxZUxjR00rRllz?=
 =?utf-8?B?Nm9VbGtET3hXcVpicGxOMWU5Wjhyd1hOSmdNNll0T2IyWEUrditXK08zMjI5?=
 =?utf-8?B?YkdKY1c3ejQwaitvZEdjNENnNFQ4VVhKZkI4QWcwS3BBbllHUnBVeWw5aWJE?=
 =?utf-8?B?RHdBdlhqLzVsdFNTdnNYU1U2cHJhbXpLZFlIWXRTTy95UlFQaEI1ODBtR0wv?=
 =?utf-8?B?b1IrWGVTOGpzYXRjNlAra1oyeXBYTmMzSVZyRXlYVEpEUGxMQnNjYnlhekJn?=
 =?utf-8?B?RndYNElPUFYvd2xpcWdpd0s0dm0yTzRSU0NsSDhKRlFhREJYUnNMM3NzUDVD?=
 =?utf-8?B?MEg1WVRJUG1qckhNZmhlbVFST2w1VmxzNUNUQjcwUnFwQkNjUXBxMi9lWmJI?=
 =?utf-8?B?S0xPbTVKOGhqa1ZoRWNISUJFQ2lyRHl2a3FyTDRmekFjVmwrZ3JReUZYS1JE?=
 =?utf-8?B?dXNaZkRiL2hmZmJ5STlQVklyQ0M3c3hYMHVCeGFQMzNlbEM3RTBoRVFlZDBo?=
 =?utf-8?B?cFRadVVYOVlIWVdJMzYwWHNrazNQREZNVVZKaUxJWVlMOXdZL0hmcCtDeHFQ?=
 =?utf-8?B?SmNrVGcvSWtpSXJMQjlMM2hMVE5ZeUIwMTFOdUhhOUlvN2p5TGpGRDYwSEpJ?=
 =?utf-8?B?aFl4TWpsY0VTVVhFc24yMnhLNUFKOS9hUnpYS0xNMzFUUGhsTk1KcVhXbzFi?=
 =?utf-8?B?N2U5VlZmc0hDbVM4a1NlRjhBQzVGaEluTmZERG5STytPdThqeGlSWEx1clFF?=
 =?utf-8?B?STUvQWdITVkyMml5UThzdWNpdGNwRzh5MGNlNWwybHhkWkg2bFBOQXZBT3Mx?=
 =?utf-8?B?SWdXODlUMnFBOGFNL05oeDkwOE0wQTdvMXJyanNPdlJGcnBMZnpzbDZDR2FF?=
 =?utf-8?Q?8pwD5Lce5LMtaIB6/qa1vQ9WdU85EqDD?=
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:SJ0PR11MB6744.namprd11.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(366016)(1800799024)(376014)(38070700018); DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?NEJMb2F6bUJrdS9SbjMyalVFM1JDUUJnTWZ6SDFmMFNCcnJzbHNMOEpzdXpy?=
 =?utf-8?B?Z0cwbWdMUEtlaU5EUGtoVVBnOXI4cjhvaFFMdUM0QURIRktrbURVYXlITkVt?=
 =?utf-8?B?Y1c5VS8wN2xYSzJieEZtaFJJUG5BWkczV093aGxEQnZTcy9MRFRGWW9WMDZu?=
 =?utf-8?B?clZUQUdncXVBQnpsZGR0SzVSbm1SZ1RvL3FaanBKTG11bmlBVTI0dThsS2Jp?=
 =?utf-8?B?QVE0VEdOejlpUVA4QUtzSG5FVHdYbG1PZU1FYnoxbjUvWjN6MXZNSnBaME5S?=
 =?utf-8?B?aE0wQTFNU082bFdJMlhvanlxMm9jZmdtRmQrMm5KbnVpZUkvZWFKcWYvVjRQ?=
 =?utf-8?B?c0xkdm8yVzlYWlRSMy9UUEI2MHNrRVVRekZkWlJhdWwrQm91VVJIWEwyY0Q5?=
 =?utf-8?B?bTJMaDczWkp6VUxibTJ6K3ZxZC9jZTN6d1NHbC9jNDg2blhNMzRhS2xIOEZM?=
 =?utf-8?B?OCtKRjVBQWpWd29aWDdyM005VS9VU25TWXdoQjgyK0dEWThCc3grU3R1TVIv?=
 =?utf-8?B?WDVmQjRFc0FHWlpTQlhvQmVVMXFjRDBUZmF4NThEcVFRd1BldlhwWDF1UFU4?=
 =?utf-8?B?a3hoeG5vNVVkL1pYYk5ud0VCb0NjNmRGdGpqK0tLa0ZCRXFBdXFRZzIzRnpV?=
 =?utf-8?B?enZpcjRvd1B0VksvMmlLc09STXQvRCthVDA0VHh4K08wMmMzazkwVFRyQ3dl?=
 =?utf-8?B?QzRUSWRTQXpRSHNneFR2UlUrcVc2OHQ2UDA4ZmRJVi9pWEhlZlJEdCtWN3J1?=
 =?utf-8?B?V2RzOGYrdDBnekppVkR2R3hqUjZSYkdsTnFmOEZJRjVuUXVxR2VGKzBxeTh2?=
 =?utf-8?B?Ni94R3RsTnZRa2pESEVwMGJ6Wk1HcUV6QldqelY2eEJ3OHcxcURhdU9pZTg0?=
 =?utf-8?B?MnkzYUI1cy90aTN3RUxJTkFsNFZoRU9sODZTeUpaRHFjS3EvcGFybWZOVWVN?=
 =?utf-8?B?Szc5dHcxbnUwK1dOSHRvenNobk5qMG94b2ZtRXE5SnA1bVdsY2NOTnlyeXBm?=
 =?utf-8?B?MXV6SlNJSDRLUm1jT0EzdkRhYnU4NU93YnVCSnJMcFQ4YmdzWXB4WXA3SmZl?=
 =?utf-8?B?c1ZvSWhjUzdEZjNQSEEzY1dkdCtaMHYzamR3eWdJSnc4WThhaXBQYkVvRmJq?=
 =?utf-8?B?a1NEVGx1ZXRTcTRSckRwOUpuT3JpU3NFVXBuZ0lUcjVLVW4yWjFhN1VqK3FC?=
 =?utf-8?B?R3gwaTlBSERtdlM4Q2oycXNqcU9MNVpSTERuRTFpN0szcEVqcHU1aWNFR3Uz?=
 =?utf-8?B?YXZTd056NHBKcVhiVisvaWFvOG91bVRaWU1iK2hDSzNZaW51Z1hFbnJLN3JR?=
 =?utf-8?B?UVNUMjJyd0ZJMm14NlhLL0VSeWpaYzk1Y1FQc05xeVZadEFjZGZOdkNqWjIz?=
 =?utf-8?B?elFsd2pJNVBEK1RnSGVIUFMvd0JMYWx0WUZjc3BFdXFHWEtyZHhERmZqWkQ5?=
 =?utf-8?B?RjY3UE9odTk2bEJyQVNPcUN2dDNRWktuaVRiQnMvN0JNaHAvdlZkNXp5V3ZP?=
 =?utf-8?B?YW1obnB5WHNRdG1uaXVSNE9nNzZtZWhScURhSUlvdDU1MEtrK3J6UCtlM2kx?=
 =?utf-8?B?ei9PcGdWWnVMd0pWaHBrVVZ1cnoweXV0OWg4TkR1WTRxTlpnUnJMcVJmTTlw?=
 =?utf-8?B?UGtSZkpac0UvNlZmSTBDRDVZYTUwaUdpWnd0UU9tYmEreU9jM01KOUxXVEc0?=
 =?utf-8?B?eVVWaDlSemtrZnFTZjFoU1NsWWNmUXZPWUUxaVhnQ1NZVVlscjY3bkN1TGdl?=
 =?utf-8?B?UllVYTZwdHlqd240VUZ5WHcvK1Z4V3R6UWNMaWFDWUo2bmNRTG1DckF1Uzhj?=
 =?utf-8?B?WU11ZWI4S0hhdjJUelZYcjVxODdLeEw2T3ovMG95SkFZSDN0RVdoUWZaS2JW?=
 =?utf-8?B?ZWVYSlFyVXNLYVF1M3hIYmtLcE1WZ0xBbTJGT2dtT2NLbUlrS0M5Qy91YTNT?=
 =?utf-8?B?Ujd4SUlMK2YwTHV2aFRiVXd6eUZLMGV6Rk5EeG1Mc01VYWp3S2x1Tld4blBX?=
 =?utf-8?B?S21nMHZQd2JVRlA5M1NOL0p2bFlsV05jVXY4c0FjSzd5NWRuQS9GNHdXSlVs?=
 =?utf-8?B?UmVSRXhaU2FvaTBreTdQU08wZW54M0dCM0MyQ0lyWXdjdStnN3FDV1ZMNlFj?=
 =?utf-8?Q?D9jfV81CF3tRJWfUc8+hceevd?=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: SJ0PR11MB6744.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 45bdb979-77a4-46fc-898c-08dd6791135c
X-MS-Exchange-CrossTenant-originalarrivaltime: 20 Mar 2025 09:24:54.8944 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: iHAEOj7M76+Tpvy+3AHirsmeu3PUGNjrXAoacDXq0m8YVyl7BUyJq6Oz4Rsuqbwve3DHuDU7hu7HmJ+pXKywEwgnTHVT5Rvta59wDCcPOOs=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA0PR11MB4574
X-OriginatorOrg: intel.com
Received-SPF: pass client-ip=198.175.65.13;
 envelope-from=zhenzhong.duan@intel.com; helo=mgamail.intel.com
X-Spam_score_int: -46
X-Spam_score: -4.7
X-Spam_bar: ----
X-Spam_report: (-4.7 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.337,
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
IDxjbGdAcmVkaGF0LmNvbT4NCj5TdWJqZWN0OiBbUEFUQ0ggZm9yLTEwLjEgMTEvMzJdIHZmaW86
IEludHJvZHVjZSBhIG5ldyBoZWFkZXIgZmlsZSBmb3INCj5WRklPY29udGFpbmVyIGRlY2xhcmF0
aW9ucw0KPg0KPkdhdGhlciBhbGwgVkZJT2NvbnRhaW5lciByZWxhdGVkIGRlY2xhcmF0aW9ucyBp
bnRvICJjb250YWluZXIuaCIgdG8NCj5yZWR1Y2UgZXhwb3N1cmUgb2YgVkZJTyBpbnRlcm5hbHMg
aW4gImh3L3ZmaW8vdmZpby1jb21tb24uaCIuDQo+DQo+VGhlc2UgZGVjbGFyYXRpb25zIGFyZSBt
YWRlIGF2YWlsYWJsZSBleHRlcm5hbGx5IGZvciBQUEMgYW5kIHMzOTB4Lg0KPg0KPlNpZ25lZC1v
ZmYtYnk6IEPDqWRyaWMgTGUgR29hdGVyIDxjbGdAcmVkaGF0LmNvbT4NCg0KUmV2aWV3ZWQtYnk6
IFpoZW56aG9uZyBEdWFuIDx6aGVuemhvbmcuZHVhbkBpbnRlbC5jb20+DQoNClRoYW5rcw0KWmhl
bnpob25nDQo=

