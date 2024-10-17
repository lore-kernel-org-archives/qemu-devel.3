Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 65DE0D2F7FA
	for <qemu-devel@archiver.kernel.org>; Thu, 17 Oct 2024 07:58:57 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1t1LOZ-00067P-9A; Thu, 17 Oct 2024 03:58:07 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <zhenzhong.duan@intel.com>)
 id 1t1LOX-00066i-Cp
 for qemu-devel@nongnu.org; Thu, 17 Oct 2024 03:58:05 -0400
Received: from mgamail.intel.com ([198.175.65.12])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <zhenzhong.duan@intel.com>)
 id 1t1LOV-0008Cw-Eh
 for qemu-devel@nongnu.org; Thu, 17 Oct 2024 03:58:05 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1729151883; x=1760687883;
 h=from:to:cc:subject:date:message-id:references:
 in-reply-to:content-transfer-encoding:mime-version;
 bh=8Hg9o9Bj43W8ydZNrNX9aur737K9QgCrKNixsplZHXQ=;
 b=UF1rF8jYqsM6fEK3RllvF3SkZ7iahKJR4DlIM4uP/76NgoeZadlzIt/M
 ieohOz4Nsqdxqp1R54+agaaYy5E1tBRdUWcmV/46Yib+9kcY+6RQaR2tQ
 Y9mIpL5XaFY5w7WR84U4YniL7Fn6RMDa77gIz+WnKQM7pX7ZarwpBronp
 zaS8QaRlj2M/zMAuNpQ8hQ/FxS38Rig+qKrqXt2U5igdJleqs/Dn+bS31
 dk64iLmjWFB3XItlan3IzBDfvn6hm/upCrkxhjjAIgKmZoOY6DkWfMrlF
 y5GkPDNSXpNKa7v3sB/GQBQvxPnLYNry4ucWBQAF7/0x+cVCtssHzDzeN A==;
X-CSE-ConnectionGUID: QbSJ8iFURcafQ6dnmX7UPw==
X-CSE-MsgGUID: MSxDOLp3QUq1lmr53zndzQ==
X-IronPort-AV: E=McAfee;i="6700,10204,11227"; a="40024477"
X-IronPort-AV: E=Sophos;i="6.11,210,1725346800"; d="scan'208";a="40024477"
Received: from orviesa008.jf.intel.com ([10.64.159.148])
 by orvoesa104.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 17 Oct 2024 00:57:59 -0700
X-CSE-ConnectionGUID: 6yTPrlyEQO60EVC21iLhGQ==
X-CSE-MsgGUID: fMyFpbwSSKusp+0X7aV6xQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.11,210,1725346800"; d="scan'208";a="79292136"
Received: from fmsmsx603.amr.corp.intel.com ([10.18.126.83])
 by orviesa008.jf.intel.com with ESMTP/TLS/AES256-GCM-SHA384;
 17 Oct 2024 00:57:57 -0700
Received: from fmsmsx610.amr.corp.intel.com (10.18.126.90) by
 fmsmsx603.amr.corp.intel.com (10.18.126.83) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.39; Thu, 17 Oct 2024 00:57:56 -0700
Received: from fmsmsx602.amr.corp.intel.com (10.18.126.82) by
 fmsmsx610.amr.corp.intel.com (10.18.126.90) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.39; Thu, 17 Oct 2024 00:57:55 -0700
Received: from fmsedg601.ED.cps.intel.com (10.1.192.135) by
 fmsmsx602.amr.corp.intel.com (10.18.126.82) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.39 via Frontend Transport; Thu, 17 Oct 2024 00:57:55 -0700
Received: from NAM12-MW2-obe.outbound.protection.outlook.com (104.47.66.48) by
 edgegateway.intel.com (192.55.55.70) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.39; Thu, 17 Oct 2024 00:57:55 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=Bwt8LAU7ai9XrITSnA4D4bKtLjfZxezn8XSRGhAEJkGlesZe6ma6WfHM6+Gjf7I/itNArN6pNBS1Eo1xq3RUu6qwh6q1/CSk9g5s5Ht6zt36e8YZxujJHLo4F7eJPMkWqIu42ZkSVCEhq8X/+2yvV0kaLFp4VjfuLi1fhos/Inc5iv6YmxxP68aG9vI6CYyKX26zZdEHKyBWQVj2NjEMB0dXaLrEjDl9QGL9GdlzpMpwtPAlnd8Ig/T8XaFEkt+fdG/Sk05wSnw+lRkiN6t5hLwxvhpCmHeXsBoZRB46Xdv9aXpx+//TQMSLdTMpktSZ1Lw5nhfuySZLseHpXSyQcQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=8Hg9o9Bj43W8ydZNrNX9aur737K9QgCrKNixsplZHXQ=;
 b=P9vWnKW1E755nQi62zvOHptmZKP1NiguS4a+610GGyethEzJFvmFNZW0hYDSQjA7W5kN5ncJud1PPD6jp9UxmeNggP4jwE8CXORF875cSxi3O5+w0ClCvJ90hm1jw3AzaUkn54OxuollB4o7BwWkNIEWDdoyE/mu6WE4lyE096z1bi0bZT9JcKJP5ItMUye+3/72IdiI5FDZtwDuTquxCwJsXwGuNssHdIui5cOyRiF+FvM5KaJolQmtU98aM0sHWdVDt5l1rZ1lF5T5F8O0oSaE/9srpsxucbUeLPW0qmQE2Qx8yu73zRGel2u6UhxmCAD+waxQeQjcTA6DIJOOEQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Received: from SJ0PR11MB6744.namprd11.prod.outlook.com (2603:10b6:a03:47d::10)
 by SJ2PR11MB7597.namprd11.prod.outlook.com (2603:10b6:a03:4c6::10)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8069.17; Thu, 17 Oct
 2024 07:57:53 +0000
Received: from SJ0PR11MB6744.namprd11.prod.outlook.com
 ([fe80::fe49:d628:48b1:6091]) by SJ0PR11MB6744.namprd11.prod.outlook.com
 ([fe80::fe49:d628:48b1:6091%5]) with mapi id 15.20.8048.020; Thu, 17 Oct 2024
 07:57:53 +0000
From: "Duan, Zhenzhong" <zhenzhong.duan@intel.com>
To: Jason Wang <jasowang@redhat.com>
CC: "qemu-devel@nongnu.org" <qemu-devel@nongnu.org>, "Peng, Chao P"
 <chao.p.peng@intel.com>, "Liu, Yi L" <yi.l.liu@intel.com>, "Michael S.
 Tsirkin" <mst@redhat.com>, =?utf-8?B?Q2zDqW1lbnQgTWF0aGlldS0tRHJpZg==?=
 <clement.mathieu--drif@eviden.com>, Paolo Bonzini <pbonzini@redhat.com>,
 Richard Henderson <richard.henderson@linaro.org>, Eduardo Habkost
 <eduardo@habkost.net>, Marcel Apfelbaum <marcel.apfelbaum@gmail.com>
Subject: RE: [PATCH v2] intel_iommu: Introduce property "x-stale-tm" to
 control Transient Mapping (TM) field
Thread-Topic: [PATCH v2] intel_iommu: Introduce property "x-stale-tm" to
 control Transient Mapping (TM) field
Thread-Index: AQHbGuoFLuS8TSFiM0mt8z0EXrA2XrKKj32AgAAK/ZA=
Date: Thu, 17 Oct 2024 07:57:53 +0000
Message-ID: <SJ0PR11MB6744C0B9DE8D32354242099992472@SJ0PR11MB6744.namprd11.prod.outlook.com>
References: <20241010075354.3582221-1-zhenzhong.duan@intel.com>
 <CACGkMEt+M=nEiivOM4OPm6jxe9ygDm-41nDxQUCBMskETFAO8Q@mail.gmail.com>
In-Reply-To: <CACGkMEt+M=nEiivOM4OPm6jxe9ygDm-41nDxQUCBMskETFAO8Q@mail.gmail.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: SJ0PR11MB6744:EE_|SJ2PR11MB7597:EE_
x-ms-office365-filtering-correlation-id: 2cf59452-46d0-488b-9d25-08dcee81679a
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0; ARA:13230040|1800799024|376014|366016|38070700018;
x-microsoft-antispam-message-info: =?utf-8?B?a0V1K25GenRUMFJXTlpEeUdDV29EaXBVOVJ0YzRKUjJ4RUxJVXFLYTV3TnRU?=
 =?utf-8?B?bnBjVUdwdjcxOUNEUkxZRCt1WmlLWlNEU3VPeWxaZmxJeWRHa21YNUt5Qit5?=
 =?utf-8?B?ZU84NTQwY21XeGRjMXMzaFdDSGo4YUlDMytxdUpyWGJUMXBPQ3hjYUprbXl6?=
 =?utf-8?B?WUJBcVdndExoLzUyaUMrcy9MNFBFYWxXNEJuUjRJcWI5UXFodURxUEd5cU9U?=
 =?utf-8?B?dldWcjR2N25tamJ2RnZzZnNlRkdFOWFMMWVkL2Jtd1NEbVY0WUFkQlF2M3BG?=
 =?utf-8?B?SEF4N3JIOEM5bDJ6UERrWTMxakFBRU5kRXdPUHJqSnFkU1puOWNSTW1JYmpz?=
 =?utf-8?B?ZkVib3lEbitCS3c1VHNlQXQvcjFCRVlBVGhUWTJOSVV1UVBMTkhYQ2J3RlBx?=
 =?utf-8?B?TXA5Rm9NMkpCVnc4OG04QVZJQmUwazNuUFlFNUZIVEV3UXBFTkRKbS9DSUw2?=
 =?utf-8?B?MGpVSGZYaGhmNEVuWnB2L05ROE02RjZoVmZhQ0pKcTlvcU5qRTZJZS9uMzZB?=
 =?utf-8?B?NlFGdkxyaHpxU1lKN0pua3BSbWFmVkZHZjZTRlVIOTNKd1M0VzNDclcwT1dT?=
 =?utf-8?B?cmNPVVVRb2N3QkFvRkVMU3ltYWFuczRvZ2YwbWlmOUlIZ2VCS3RFWFdjREw1?=
 =?utf-8?B?cHhjMmZpOGE2K21EdlVqM2lqcXdTUExFQy9oSGpsQWZCcmNRcmFwZEJJcFMv?=
 =?utf-8?B?SkhRVDBENFZYTmwrVDQ5dHNWSDc0UjlTUDh3RlVqd0J6TzZZMlUydmFHbnA2?=
 =?utf-8?B?V2tXOEZ2THBZYmhDekY4SWZaWlhjK3Y3ZVZoMDlZTWRMOGJMTWxTTUcvNGFT?=
 =?utf-8?B?eURhMXNjL1cxU1ZDK2M2a2JULzZXVlFTVkhTbVM5Z0F2WDlFZUtVVk5Dbi82?=
 =?utf-8?B?aFRhN2pob1JsZXN1OVpyOFhyY2lEdUE0aENlbzJHSFRETk5iek9DZWlxOUoz?=
 =?utf-8?B?Q3p5bXlWT0pSR1g4QTNoZjRoemZUVGdPY3o2a24yMUFhTlRueGkzNlhPUG4v?=
 =?utf-8?B?bkNOVzdLbDZ1RHBFdmJzYnNvQnRrY1VjWlluLzNiY1pmaEJWQWllajJpVjh6?=
 =?utf-8?B?MWxucDJUdEJEZGdEYzFXdHJRQkd3TDRxRzdPa0VtTHRyWkxwYlgyNjZ3d1Yw?=
 =?utf-8?B?TUxyTXdLd3Baa252cEVsUTJ6cktSeW5rNnBKTm9adXQ4dVlXVmZWUmFRSFN4?=
 =?utf-8?B?cmZTVjFnZllpUmlwYWNaU09lNlVDWVhqQnZhL2NrWmp1ZEMxK3p1UXkrTHN3?=
 =?utf-8?B?YmJjY2p4MFpGRVd6TEZrRWV6RkdWQS9tL0xqZXdHbnRlaUhZeVNtdG50NjFN?=
 =?utf-8?B?VDJ1aTE3UGhZWnVJRmF3NjhEdEErWUUxdUIySG5sMnNtTWN2aWNNa2hydzJn?=
 =?utf-8?B?ZzFCQVpNMUNPMTY3L0liUDFQUGZzT3VPUVlucEhmZ1dRRVpHNGtGdE5sUkhV?=
 =?utf-8?B?NVFnVVNFZjJCM3lXRVljYzBhL3JOR0s1K1B4WGQzVGFDMDIyN0F4RnNGeGQ2?=
 =?utf-8?B?ZVFERm40SElJME1temg0Yjg4L3pCbFppT0F4MTluR2RxTTBCOFZPbHVaK2Zk?=
 =?utf-8?B?VnB4Y3UyelZaVk8wTWk2aC94NVA3dFFIUjFYSDdhRHV1OTN6dXpTd0FFLzlP?=
 =?utf-8?B?MncwQWpFYUlReDY0OVl0c2R3U2lmOHRMckh6ZkdRTUZleTNpWTFjQVFjbkdq?=
 =?utf-8?B?eFlzUFA3VmdhdFpMMG1SSit3WFBreG5oTWl5UGtLODVBMUV0UnJnYm9wZERY?=
 =?utf-8?B?RE1CZGdKQTNIOFdvWmhiVS9aamdGL3V4K25TWFNOZXl2SzBDamp5a3lCdVpL?=
 =?utf-8?Q?n4lGapA6mLPZq8jYHhKwmWDzzamnF/M6gN4JY=3D?=
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:SJ0PR11MB6744.namprd11.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(1800799024)(376014)(366016)(38070700018); DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?MXRZdWpNZzQ1WVFpR3BCMHV1dWdTcHNvYTg4ZWQrV1VnM2lzYU5QTldwR0ts?=
 =?utf-8?B?cUFsWTRJRThkT25kaVh3eHZOSVVzM0lyTzZIYXpYWnJ6REs5WUR0Y2ZRRE9X?=
 =?utf-8?B?U0xjMjRqbEZmVVJrMjIrRVVmWjJvckEyTlExaWEwZHlXQURhVkxuSGh0K053?=
 =?utf-8?B?SFdVRDRtV3BWTnFBVXRwUHBPK2hHNUcrdFZONGp3RUxUOWZ0cSttM3U0Qmw5?=
 =?utf-8?B?cnRXM3EwL2NseklxZjRzS0FGTmgvUFc3OWhyUFQ4aW5ndTlXK1RYRWxKV0lr?=
 =?utf-8?B?UW9MTkZ6Uk1JU3NxQmI5TmxzWHc5OUFNUHZlUjJLc2pMOFVsKzZLS0JaU1Y3?=
 =?utf-8?B?MXNTVWh3MFUrNHdzWkdqU1QxV1ozMGovditnaHlIQnREQmdPMjNMS1ZsNmVv?=
 =?utf-8?B?c3kzeis3TW5wQ2ZUWGpkUDNCcWlNL2k1TzVwRG5YTUxvZUZ4Q3dZQm9Oenc2?=
 =?utf-8?B?bnUwcWhsRTE0aEhlcU1idlI0NUZBdkVqTDV0b0QrUncvWnBnZXNrMjlqbEQw?=
 =?utf-8?B?SzFGRWllOWRvMS83VE8wMDlNK05NaHV5NVpTOXl3Njh5OHBIRTlxZE1ObFdv?=
 =?utf-8?B?L2d4ZWdwaWhuVUFJUkRQSmhwM1BHY0NrZHNzYmZPZjZDVVY2cU5nMkNvUkhl?=
 =?utf-8?B?a1krUnVNRkhldG54L2wzTU5kU2NVL21Fc3FSZXhSbXk2eXNyS0NyOVhBMStK?=
 =?utf-8?B?bHVpVTQ0WnlDbDdtUHdzL29XWnZtTGtRSVhPZXorcDIrYitzVFh0dHBzczdj?=
 =?utf-8?B?Tm12MmdraTNZVlZxQVNYanN2dVREaUFjcFN3RkhkQi93UzJhWm5iRFZlYjVS?=
 =?utf-8?B?c1dkb3hHWC9yUTlKRjg0dnJQSk9yUWdLdnZ0N3ZVV0FhbmJPQ0FNQm5ybFVE?=
 =?utf-8?B?RVF6blIxUmMvaUhqL1k1MzNFcE1nUUF0QjZaWnFXRitUc1RIYWo3SytSRlhj?=
 =?utf-8?B?aTVuZnIxb1ZPNVFwS2hvUDM2cUN1Z0Z4NUlhdFpCc3dvYTNaZ1VUR0plR0Zh?=
 =?utf-8?B?R2k4MVFmNzZNamtHak43MW9SZzg2dkdzT0ltYlRFWHRlMWNIOUg5c1FsbTc2?=
 =?utf-8?B?S0JsVnJsTi9SelZwSXIvRk4vVDMrRWUra3pUejVla2VQRzdheTQrWTc4bVlL?=
 =?utf-8?B?UHRUVEx2ZlUvaEZ3M0JWRjhERkoxcnd4N0hRWGtvUzRDVWdNZEc4bHU2S3c0?=
 =?utf-8?B?MU1GNU9OZmRzYmRXaVQ1VC8rUUd3a1lkL2I2aWpuVmxFYWt4ajE2dUtLK2R2?=
 =?utf-8?B?cmpxY2lXN0t3RlQweEwrTE9hcTlhMlFZUU9wM1l0YWpBbmpWeVczSEFFSEZR?=
 =?utf-8?B?YXpMby9EeS9nMzYvd3V5WTNVSTExcW1wWkpKTVcza0ZVS25DWGIyVkV0ZzRP?=
 =?utf-8?B?RzVuM1BNcHJtSEk3dTVZWWJCOExWR1hhRVVWV1p3VXppcWRPOWZaaTNoNHJW?=
 =?utf-8?B?NkZTMFBSbzVIWTBSb3Z6eWVsTHpFMDVlSU9ycmNncmJJNC9YOGp3WVArSEx6?=
 =?utf-8?B?VTZoT28vZm05SEw3d1R0ZFdzY01EOU1RS05jNTZYYkY3Wm9FTnlzRFJ4UWox?=
 =?utf-8?B?Mk1mcHFFVktnckN5MDhrV1FmL0RKcDAvd01DSFl3Sjg1TlkxYWF5TTZXSlp4?=
 =?utf-8?B?c1pVUVl6cHFOUWw5Q3I1bm16NnZDdEZ1eG0rTmg0Z0ZDdmx5RUZUQ1krU2J3?=
 =?utf-8?B?b0sxT3o5QkU2cDNWbnFTeUZVMUJnRGZ2T0phZDdKRThKTDZETXo2VmZaSGVF?=
 =?utf-8?B?TlpXeml5cUVFcTFoRlpiYU8rWDhIQ0ZrSUg5all5M2dTZ2tyY081R1VJYnBs?=
 =?utf-8?B?c1V0VFoyVmNTSnluWlRRUzJsaU5qQ29pNHpmdnVhTVhEUk9ZZll4eWJ6OHZn?=
 =?utf-8?B?Y0VxVDRadzNzWndHZG5QTGZscVkrdm5FU003dFVTci9YNk83NjA1ZExRYTBO?=
 =?utf-8?B?L0FaZXcwWWp0QUplTFR1eHNPNXZOOEZmWWlIRUxxNzBMcFp1ZTFPTUcvZlAv?=
 =?utf-8?B?Q0toWWY0TmpjblJUeEZHSlZKbmZOYlVYSHpqRDhodFRSUDZsTnlkZXB1OEox?=
 =?utf-8?B?ZXd5RFVDbWdNOTBlMENGb1BRK0RUbFJGcE1BSDRhczJTUUtETlJ0WU4xejR2?=
 =?utf-8?Q?tt69KFy9oxrOoZyEyaPp1/HmL?=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: SJ0PR11MB6744.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 2cf59452-46d0-488b-9d25-08dcee81679a
X-MS-Exchange-CrossTenant-originalarrivaltime: 17 Oct 2024 07:57:53.5785 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: MGt9rF/tQiRVGzphjvZTR0GrXQdqNrmWNPCOYg4OQicALdH6PSjBnIZe34xhVTN5FygypQl/OwUj9X3NHY44GJCM+jde3YMXPS+NkXy/thM=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ2PR11MB7597
X-OriginatorOrg: intel.com
Received-SPF: pass client-ip=198.175.65.12;
 envelope-from=zhenzhong.duan@intel.com; helo=mgamail.intel.com
X-Spam_score_int: -43
X-Spam_score: -4.4
X-Spam_bar: ----
X-Spam_report: (-4.4 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.038,
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

DQoNCj4tLS0tLU9yaWdpbmFsIE1lc3NhZ2UtLS0tLQ0KPkZyb206IEphc29uIFdhbmcgPGphc293
YW5nQHJlZGhhdC5jb20+DQo+U3ViamVjdDogUmU6IFtQQVRDSCB2Ml0gaW50ZWxfaW9tbXU6IElu
dHJvZHVjZSBwcm9wZXJ0eSAieC1zdGFsZS10bSIgdG8gY29udHJvbA0KPlRyYW5zaWVudCBNYXBw
aW5nIChUTSkgZmllbGQNCj4NCj5PbiBUaHUsIE9jdCAxMCwgMjAyNCBhdCAzOjU34oCvUE0gWmhl
bnpob25nIER1YW4gPHpoZW56aG9uZy5kdWFuQGludGVsLmNvbT4NCj53cm90ZToNCj4+DQo+PiBW
VC1kIHNwZWMgcmVtb3ZlZCBUcmFuc2llbnQgTWFwcGluZyAoVE0pIGZpZWxkIGZyb20gc2Vjb25k
LWxldmVsIHBhZ2UtdGFibGVzDQo+PiBhbmQgdHJlYXQgdGhlIGZpZWxkIGFzIFJlc2VydmVkKDAp
IHNpbmNlIHJldmlzaW9uIDMuMi4NCj4+DQo+PiBDaGFuZ2luZyB0aGUgZmllbGQgYXMgcmVzZXJ2
ZWQoMCkgd2lsbCBicmVhayBiYWNrd2FyZCBjb21wYXRpYmlsaXR5LCBzbw0KPj4gaW50cm9kdWNl
IGEgcHJvcGVydHkgIngtc3RhbGUtdG0iIHRvIGFsbG93IHVzZXIgdG8gY29udHJvbCB0aGUgc2V0
dGluZy4NCj4NCj5OaXQ6IEkgdGhpbmsgd2UgcHJvYmFibHkgZG9uJ3QgbmVlZCB0aGUgeCBwcmVm
aXg/IEFzIHdlIHRyeSB0bw0KPm1haW50YWluIHRoZSBjb21wYXRpYmlsaXR5IHZpYToNCj4NCj4+
ICsgICAgeyBUWVBFX0lOVEVMX0lPTU1VX0RFVklDRSwgIngtc3RhbGUtdG0iLCAib24iIH0sDQo+
DQo+Pw0KDQpJJ20gZmluZSB0byByZW1vdmUgaXQuIEJ1dCwNClRoZSBwcmVmaXggIngtIiBpcyB1
c2VkIHRvIGluZGljYXRlIHRoYXQgYSBmZWF0dXJlIGlzIGV4cGVyaW1lbnRhbC4NCkNvdWxkbid0
IHdlIGhhdmUgYSBwcm9wZXJ0eSBib3RoIGV4cGVyaW1lbnRhbCBhbmQgY29tcGF0aWJsZT8NCkkg
c2VlIGEgbG90IG9mIHN1Y2ggcHJvcGVydGllczoNCg0KIyBncmVwICJ4LSIgL3NkYi9xZW11L2h3
L2kzODYvcGMuYw0KICAgIHsgIklDSDktTFBDIiwgIngtc21pLXN3c21pLXRpbWVyIiwgIm9mZiIg
fSwNCiAgICB7ICJJQ0g5LUxQQyIsICJ4LXNtaS1wZXJpb2RpYy10aW1lciIsICJvZmYiIH0sDQog
ICAgeyBUWVBFX0lOVEVMX0lPTU1VX0RFVklDRSwgIngtc3RhbGUtdG0iLCAib24iIH0sDQogICAg
eyBUWVBFX1g4Nl9DUFUsICJ4LWFtZC10b3BvZXh0LWZlYXR1cmVzLW9ubHkiLCAiZmFsc2UiIH0s
DQogICAgeyBUWVBFX1g4Nl9DUFUsICJ4LWwxLWNhY2hlLXBlci10aHJlYWQiLCAiZmFsc2UiIH0s
DQogICAgeyAiSUNIOS1MUEMiLCAieC1rZWVwLXBjaS1zbG90LWhwYyIsICJmYWxzZSIgfSwNCiAg
ICB7IFRZUEVfWDg2X0NQVSwgIngtdmVuZG9yLWNwdWlkLW9ubHkiLCAib2ZmIiB9LA0KICAgIHsg
IklDSDktTFBDIiwgIngta2VlcC1wY2ktc2xvdC1ocGMiLCAidHJ1ZSIgfSwNCiAgICB7ICJJQ0g5
LUxQQyIsICJ4LXNtaS1jcHUtaG90dW5wbHVnIiwgIm9mZiIgfSwNCiAgICB7ICJJQ0g5LUxQQyIs
ICJ4LXNtaS1jcHUtaG90cGx1ZyIsICJvZmYiIH0sDQogICAgeyBUWVBFX1g4Nl9DUFUsICJ4LWlu
dGVsLXB0LWF1dG8tbGV2ZWwiLCAib2ZmIiB9LA0KICAgIHsgVFlQRV9YODZfQ1BVLCAieC1odi1z
eW5pYy1rdm0tb25seSIsICJvbiIgfSwNCiAgICB7IFRZUEVfWDg2X0NQVSwgIngtbWlncmF0ZS1z
bWktY291bnQiLCAib2ZmIiB9LA0KICAgIHsgVFlQRV9YODZfQ1BVLCAieC1odi1tYXgtdnBzIiwg
IjB4NDAiIH0sDQogICAgeyAiaTQ0MEZYLXBjaWhvc3QiLCAieC1wY2ktaG9sZTY0LWZpeCIsICJv
ZmYiIH0sDQogICAgeyAicTM1LXBjaWhvc3QiLCAieC1wY2ktaG9sZTY0LWZpeCIsICJvZmYiIH0s
DQogICAgeyAia3ZtY2xvY2siLCAieC1tYWNoLXVzZS1yZWxpYWJsZS1nZXQtY2xvY2siLCAib2Zm
IiB9LA0KICAgIHsgIklDSDktTFBDIiwgIngtc21pLWJyb2FkY2FzdCIsICJvZmYiIH0sDQoNClRo
YW5rcw0KWmhlbnpob25nDQo=

