Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D8B39C04FFE
	for <qemu-devel@archiver.kernel.org>; Fri, 17 May 2024 16:57:26 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1s80sf-0004Cd-NQ; Fri, 17 May 2024 12:56:29 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <dongwon.kim@intel.com>)
 id 1s80se-0004CQ-NS
 for qemu-devel@nongnu.org; Fri, 17 May 2024 12:56:28 -0400
Received: from mgamail.intel.com ([192.198.163.14])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <dongwon.kim@intel.com>)
 id 1s80sc-0001v7-Lc
 for qemu-devel@nongnu.org; Fri, 17 May 2024 12:56:28 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1715964986; x=1747500986;
 h=from:to:cc:subject:date:message-id:references:
 in-reply-to:content-transfer-encoding:mime-version;
 bh=NOR/GzGcDXiyfEPDn6daMtRbBp6AD/idHC11ZS5wCj4=;
 b=llEkkWmjTwaD5NC0M5S/fKRBV5U3lCgUa4wqCbDdw5fM9JrzpRHQiFRV
 JRR8w2r4VtVZ4SbJm1Kv7qYxCbBGQYSd/34omcR9KWIQDxkGJ5GuOWAJO
 89lfVn0EQVta6pmEjN9Rb16uXemOQ/5UWOXpp7xRCM0uasiyIQ2YWV//M
 Xd112robCTlS5dq79LQapeh//b8/kYo/gmZyWps52wdz/EdbdfFtMGIuJ
 XrjzAUOJIjqGjMUQ1rXxKKV1f390x8A0F4qfxkOByPWWJwX8CZ/p+rT8j
 3yo8CDn+/shAJpNfkyjlpKOAjXf9zBxxpcshFBMh/stwm6UElNC0E+sr5 g==;
X-CSE-ConnectionGUID: YQOkcEO/RkKFjuphiGmKLw==
X-CSE-MsgGUID: bFMGUxN/Suq20YuIcdkKNQ==
X-IronPort-AV: E=McAfee;i="6600,9927,11075"; a="12369823"
X-IronPort-AV: E=Sophos;i="6.08,168,1712646000"; d="scan'208";a="12369823"
Received: from fmviesa005.fm.intel.com ([10.60.135.145])
 by fmvoesa108.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 17 May 2024 09:56:21 -0700
X-CSE-ConnectionGUID: +jwt8Z+hS3qMmTRAZ3oEvA==
X-CSE-MsgGUID: uMnX/WjKRPaaECWinH6ulg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.08,168,1712646000"; d="scan'208";a="36266430"
Received: from orsmsx603.amr.corp.intel.com ([10.22.229.16])
 by fmviesa005.fm.intel.com with ESMTP/TLS/AES256-GCM-SHA384;
 17 May 2024 09:56:20 -0700
Received: from orsmsx612.amr.corp.intel.com (10.22.229.25) by
 ORSMSX603.amr.corp.intel.com (10.22.229.16) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.39; Fri, 17 May 2024 09:56:19 -0700
Received: from orsmsx603.amr.corp.intel.com (10.22.229.16) by
 ORSMSX612.amr.corp.intel.com (10.22.229.25) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.39; Fri, 17 May 2024 09:56:19 -0700
Received: from orsedg603.ED.cps.intel.com (10.7.248.4) by
 orsmsx603.amr.corp.intel.com (10.22.229.16) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.39 via Frontend Transport; Fri, 17 May 2024 09:56:19 -0700
Received: from NAM12-BN8-obe.outbound.protection.outlook.com (104.47.55.168)
 by edgegateway.intel.com (134.134.137.100) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.35; Fri, 17 May 2024 09:56:19 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Z9Su628+WHCC9UI1IIBlqiTHm77H420Eg/tOG91pL6irrj0uWLgfMM7jOPxK+k8/66GndOqYAAD7WTKZ5RzAIzTDBVZriM0qVdXD/XYVOUgGJflg/qZqmh572ZAKwnOEBjuMZ0NDhK2XI5wp/a3HS14q2bTpFBBy2X5yYOygnJQXAWHPR9aL7t5UcNS/ezWhkv6ggc59YzWiVxkpKqPS3pKOjd0dQZcWunvH2oeY1JZGDQOs+F4LQJ+cJsoksnF9ROQXG59delv8iW31KPDpFBt2rq4heAGHMSEf8JPzEjWrrapb2o1jHbd+obHsGXZbAr+ed3DLjN46nncQjqzAiQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=NOR/GzGcDXiyfEPDn6daMtRbBp6AD/idHC11ZS5wCj4=;
 b=AfWYGdVeNdFB8V7B2AZ+eZtGlUwgcWrRHTXuZ4Ljq4k6vs1Wk3Cou0OybUTXN2oYWZX7QNqtJ/hZxgl/C4C4hd1P8OwsEQkFIUh42DcjC1EUAVHUNnkFP7Urm1SfLXE6UpYKyun8FEE5woAbYr/jtjbG/rEzcE86zQLPIFjpXvVUQD1K8jHnyTLg9522x7bG6vk4/QsLHHKcyU35U7Crm+ku0kpaWvWVt/p+7StavWmxavM7liorWx2jsDk3pBL66lr/2Ocb9uN6E10k/zXDZm0lYyo+fyGwhfu3ojV5KujL+P3lNtBEd3scQblaHnIVdmrm9wl77Mlj6azL5CIUdw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Received: from PH8PR11MB6879.namprd11.prod.outlook.com (2603:10b6:510:229::22)
 by SJ0PR11MB5088.namprd11.prod.outlook.com (2603:10b6:a03:2df::17)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7587.30; Fri, 17 May
 2024 16:56:17 +0000
Received: from PH8PR11MB6879.namprd11.prod.outlook.com
 ([fe80::bd3d:59f2:9d29:346]) by PH8PR11MB6879.namprd11.prod.outlook.com
 ([fe80::bd3d:59f2:9d29:346%5]) with mapi id 15.20.7544.052; Fri, 17 May 2024
 16:56:17 +0000
From: "Kim, Dongwon" <dongwon.kim@intel.com>
To: =?utf-8?B?UGhpbGlwcGUgTWF0aGlldS1EYXVkw6k=?= <philmd@linaro.org>,
 "qemu-devel@nongnu.org" <qemu-devel@nongnu.org>
CC: =?utf-8?B?Q8OpZHJpYyBMZSBHb2F0ZXI=?= <clg@redhat.com>,
 =?utf-8?B?TWFyYy1BbmRyw6kgTHVyZWF1?= <marcandre.lureau@redhat.com>
Subject: RE: [PULL 1/5] ui/console: Only declare variable fence_fd when
 CONFIG_GBM is defined
Thread-Topic: [PULL 1/5] ui/console: Only declare variable fence_fd when
 CONFIG_GBM is defined
Thread-Index: AQHaqGtiW91qmVUOEEW1ZhYCeQbix7GboKXg
Date: Fri, 17 May 2024 16:56:17 +0000
Message-ID: <PH8PR11MB6879DBBFE51029D42E2DA0E4FAEE2@PH8PR11MB6879.namprd11.prod.outlook.com>
References: <20240517150227.32205-1-philmd@linaro.org>
 <20240517150227.32205-2-philmd@linaro.org>
In-Reply-To: <20240517150227.32205-2-philmd@linaro.org>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: PH8PR11MB6879:EE_|SJ0PR11MB5088:EE_
x-ms-office365-filtering-correlation-id: c147793e-0d68-43b0-0962-08dc769244f8
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0; ARA:13230031|366007|1800799015|376005|38070700009;
x-microsoft-antispam-message-info: =?utf-8?B?YlB4bFRYVjJQVWYxUStielpqOGt3Y0dpbyt3MStEQnZabVppTk8ycWdUaXFk?=
 =?utf-8?B?QlVjaEtZT2hmdXU4VmxVNnRzY0oreFVhN0hUMUhDb003VkwrRnFrcUVJcWFw?=
 =?utf-8?B?K00zUVBzSzh0eG9IczQxd2ZidVZEWFpDQkI3UmdaRE55TmdheTdVWWNYMmdU?=
 =?utf-8?B?ektpK2ZDT2VrZU40aVBVOU5uS0dCQ0JxWEYwOTZ0bUJuNnNHK2U0aHExNldS?=
 =?utf-8?B?N0l5Zno5SzRlWVZTY0NUeGRGdW9UWFhCd2ZHbjlDV3hzSlorZlRJZmpFdEpX?=
 =?utf-8?B?VVZsU1Fjd1NNdWJRcGY1Y3FPaDRhSjBkNzcyckFES0Frb3Mzdmw2amlFNEk0?=
 =?utf-8?B?RGN2bjVsbDQ3MU5Ra0YxZjhhOFIrZWFMSDR4MzNZOGNlWGhjVlBKUUlGd2xH?=
 =?utf-8?B?UnpvdndmMW0yOUpCYW5WYW92M2RmWXk4UEZsa0FmdnRNNmZwcER4dWNqWE5I?=
 =?utf-8?B?bU0vbTFNM2xOWHpLWCtyNFF6V3NpZ2lnM1c0eTZMWDZuL2YyemhhVmN1cVlR?=
 =?utf-8?B?ejZXNi9ZcENYZnFkcmFoQXF3K21iYjVzbkxoNFF4TzVKVU4vTWlYUFNucUtl?=
 =?utf-8?B?NldlQ0pVdlRPTmwyMDdiV3V3bjdJQUNWL0o3WC8yK1F0azRkWGliT0lvOFY5?=
 =?utf-8?B?bnlQa0tOWFhSQlJ2YVNlN05NdXV0REN2bXBkbmN1Y1hqckJmYW8xclY3NDI4?=
 =?utf-8?B?Ujh1dlh3VkVXVmNabTlCdzFYbGJWVkZtRDFyc1E1RkU5OXV3Y3EvWlZPOUVt?=
 =?utf-8?B?TjJhNk1OM002ZDFyalVvS3NPWE9Ea0JrYjdZWWVVQ05wUlJmSVlNdmdSNStQ?=
 =?utf-8?B?RmFXaHhhRVZLOWF3OFM4YTZnclplL3RSdHVTVU9HdFJpWldNRWVFS2xqSHhX?=
 =?utf-8?B?eGtIbFlIRithRjdTb2NNcU5FMU4vNnBCdk94N1owaGxHbGVqeTJSMmhLSEx1?=
 =?utf-8?B?aGVneStZL24wZEQ4cW53enhyWDhZSTBPVnl4ZDVpNkVmNnVLeW1reS96OGpa?=
 =?utf-8?B?Q0ZDdGZYZ2I2OVhLQ3BnYWxpK1crU3duRkJmZ21mVDE3VXpkQmNneUwwVHU2?=
 =?utf-8?B?VjN2V09TcnpWdGxleWl5dlczUkVZSW1xTXd0WTh1RHQxL1hEQkhLNWY1eEp0?=
 =?utf-8?B?bld0NVVaNGhUTWI4Tm51eGZya3BrKzlsYnBNa3dBeXJxbFhPLytjVkFEQndQ?=
 =?utf-8?B?WTA4M1QxMnRYK1FLWFplZHdVbzNmeG5VckEraDNlWWVTUE1EVFh2QkR5N3pN?=
 =?utf-8?B?eGZnQVhQeWMydjJwckpabkc0WFdocStKbGtNVjczSHFFcDhjdmtKbUNwUVkz?=
 =?utf-8?B?SWRXSEx6SXZuQitIU3BjZlFIeDZ2VXRWblVqSVV4bUErM2E0MjQrTkg4b2dX?=
 =?utf-8?B?cmNmNlJ3UWhCa2d6cFZ3Qm5zZFE0dGIyTFA5V1gyU3QxM1A5WGxJRk5EdUhR?=
 =?utf-8?B?ZzhUNTdyRUFORENjWGZHM2s1ZHdhTWNoVU4ycjZkb1haT1dOejE1MHdlR0ZK?=
 =?utf-8?B?ei9jY1hkeFFwUTVNV3V6d1hhVWZlU2Nua1NCQkxRNEF5TmJhZUYyd0kzTHov?=
 =?utf-8?B?UG1IL2hQb1ZQY0Z4MnV6R3o3bXBKdjlOa1hLRGZ0VkF0UEw2QVQ3eWJzTHE0?=
 =?utf-8?B?Zm5JM0RGMlQ4YjczdHpoNmZYd2J6MjJXQjFBWUpLV05Lcjd0Z0g4OFZwNklU?=
 =?utf-8?B?VFdsUkdIR1YxNGo4d25VRlpBclo0WGJxaUhEeDU4WWZPWStIa0FhUUt2ckdh?=
 =?utf-8?B?K0NnaGdkcjBmSHpJd2NxK2xkdEo0TFJBSTN0dkxoajRRQzdoMUtRR2gvMjBW?=
 =?utf-8?B?ektOTWxaZjBHUWJEZDk1Zz09?=
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:PH8PR11MB6879.namprd11.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230031)(366007)(1800799015)(376005)(38070700009); DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?a1hmNWpHZXE4aW5NNW5GVHBOZERVK2QxQmJIYm1yek9TSkRmdTNTbmZDTGR0?=
 =?utf-8?B?QmxTYytqWmtuMEc3TDZUclV4WHVrS2hZMUZqRFRDaTJXVThDRDdvckFRWXhr?=
 =?utf-8?B?QlA0ZmUzSTVFRTlRc0kxdUI3Q1ltMm1KUHYxS0RHWk9xTS9iTFJ1bzRPOTly?=
 =?utf-8?B?RVFodE9ndXpMbEV4aUNNeFJlTThIdG9zSkNpQWl3eHJqVGhGeGd4U00vQnVa?=
 =?utf-8?B?V0lKd01VaDZXeVlYVHBxZVZlbC9yRUhka3hqajBuY09oTDcxdW9ZVFVvaDFQ?=
 =?utf-8?B?MFhUUk8zOHpnN3IraDZlamlZUDBRaUwrNXhwSWFXOHh6QklFdEQ4QURDcWg3?=
 =?utf-8?B?dDBBRHdzdkRxeXFRbEpyOG4wTHlSV1ZrR3lqamlvalJCeVFydDNneTN5NHZh?=
 =?utf-8?B?dWk0Z1dyd2ZhVDNicXBpZDZEVzU3MGpOaTduR0c5R1FIRjd6c2xiTWZkaVR5?=
 =?utf-8?B?cncwbnZrWk5jdmZ0SXhlUUxnWmtHTUQvVG9vZnZLcXA4ZkFYTERPbFN2V1Z3?=
 =?utf-8?B?d2RncmlaWk5LekZDTDFBekczak9Tc0ZWaFRpeDFrUmZUN1VMNklyL0JxLzZs?=
 =?utf-8?B?dXB2ZXF5amlWQUVMN2dVVUtiYSt0VTRJa3ZoMnNyUWgyR2JuYmlMRlhKS0RT?=
 =?utf-8?B?WWxzL2grcHpYTlFZcVE0bHFsVW8rdjV2R2ZSS1R1alppcXdndUN6TEdFOUZ4?=
 =?utf-8?B?NW9oZUExdmcyUU5Ic0p5Q2VIbUE4Q3J2Mk5YVE5JeW9IR1RqclR6SVpOeUJt?=
 =?utf-8?B?UWxJQzNhZW1IdFdnTTNnTkNyMS80YkxvVjBkb2UwMHNVN0o2SURsVmZTMnJI?=
 =?utf-8?B?eDhkZjFyenk5aWNaNWRpZk12b2dBTElwUGRwWFRRejdtdGEvbkdFSi9EVzZT?=
 =?utf-8?B?aUg3RlFLSnNwQnBsL0syMTRxcXEvdThmTzlwQU81WHJFbDNDektFS045UUdi?=
 =?utf-8?B?WDFzOWlyR3dTSUNYUEpnSVlUS204YjVud2ZSSTV5c2ltcVk0Y2h1OFBSQU9I?=
 =?utf-8?B?VTBzY1kwZm5XQ0wxamI2Z0x6RGFFL2s2dWpVSWl2eUdSK2ErZE11WHJzak1T?=
 =?utf-8?B?QWFTVGMzVHV1c3daT1F1aDhiK1d4QmYvV3FURnN2dG56Z3hGcFNNaGJzcnVJ?=
 =?utf-8?B?WG84bE1HQ0xGK2ljeDVGVWtNa29ubDZuZVdkNVI1ZGdnL2Jlbkc5bWZQQndU?=
 =?utf-8?B?M1dNb003djVzdGNJSTFhczVaalAzZEJxOTc2SGJ4MUNUYlQzcU42REpqUW1r?=
 =?utf-8?B?VFI3bVhKYUs0SFFSN292UVhmY3hWRWVmZ1gyRjVucFRKUGRTUzZ5T2tSWm9B?=
 =?utf-8?B?TkpYZExpb0tWZHlYQkZjd3M1NUxhNmg5WXhVL2dEUm9CbCtVQkdRQW5YcEMr?=
 =?utf-8?B?eU9jTHVKaENrYWdKZWlaeElNWHEwNW1hY2JtRytVdmxaUENYMGlKUnBmV0FR?=
 =?utf-8?B?U3hTaTBWRDBxZTFPd3JMblI4em9xampMeE9UQVgvVmJ4aGY1d0loT1FDejhC?=
 =?utf-8?B?em83TURKUXdBRHJRNWIxWlp1VTY3MlBrVlBGUVhKZ1BkSVJ0L1daUUl5MWtI?=
 =?utf-8?B?eElDemN5b21jRGRDY29qNXp1MVYwZEJUSEZpZmZlZU5nUHJmcjJOZ2JpckZL?=
 =?utf-8?B?VTAwbGdWb2VNV0kvUVA1MGF3YUNhM0grUk9GM2FFcEU2VDFldmFodjNzeG5T?=
 =?utf-8?B?Wk43Qml3aXMxN2lXY1BHVTRSelNvUHJCUy9xR0kzSEYrNGZ5Z0kxOG9ZMGIx?=
 =?utf-8?B?UWlsVDUySGk1c3dUcG45dEIxL0c0eDlXUzArZWpwcmY4K3VjOFV3T3dZTFRP?=
 =?utf-8?B?MW5LWEhwTHhuOWtCQWMxSkhDWlJWZUZKRnBuaTdGNmMxZWhTYU1GT2VCenlV?=
 =?utf-8?B?VDBkek1DTE1DNE44ZkZDU0N6WUkwc2JhbTVLR1FKZnoyQit2bUZkVDNuRjFP?=
 =?utf-8?B?d2VBaFdmdGtFZEYyUGMrY3RLOFMzZjAvVTdyS0RhZ2N4SCtiRVRwOEJrWjFH?=
 =?utf-8?B?RVBCSFI4b1lCOHdxc29DdzBjN3BReGxqRTBNeWNLbk9zNEtZckFYSk5BdFVu?=
 =?utf-8?B?OVJSU05HSjNTSGxPdFl3NzlGWVlPZVJxWkhRcjNQdkhmdU9mTGZ1WWludVJB?=
 =?utf-8?Q?mw29gvFRbEQKCW7RtgcLHJOb4?=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: PH8PR11MB6879.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: c147793e-0d68-43b0-0962-08dc769244f8
X-MS-Exchange-CrossTenant-originalarrivaltime: 17 May 2024 16:56:17.3837 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: wcVNXSH0EZCbYkq4kpaymOe0/fBKcnnMNHIhOCranURpRnj7GM+dXfAemJgj1Lx5W8s9A3ElP4WeetHdgkKhrw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ0PR11MB5088
X-OriginatorOrg: intel.com
Received-SPF: pass client-ip=192.198.163.14;
 envelope-from=dongwon.kim@intel.com; helo=mgamail.intel.com
X-Spam_score_int: -30
X-Spam_score: -3.1
X-Spam_bar: ---
X-Spam_report: (-3.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.996,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
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

VGhhbmtzIGFuZCBzb3JyeSBmb3IgbWlzc2luZyB0aGlzIGluIHRoZSBvcmlnaW5hbCBjb21taXQu
DQoNCkFja2VkLWJ5OiBEb25nd29uIEtpbSA8ZG9uZ3dvbi5raW1AaW50ZWwuY29tPg0KDQo+IC0t
LS0tT3JpZ2luYWwgTWVzc2FnZS0tLS0tDQo+IEZyb206IFBoaWxpcHBlIE1hdGhpZXUtRGF1ZMOp
IDxwaGlsbWRAbGluYXJvLm9yZz4NCj4gU2VudDogRnJpZGF5LCBNYXkgMTcsIDIwMjQgODowMiBB
TQ0KPiBUbzogcWVtdS1kZXZlbEBub25nbnUub3JnDQo+IENjOiBDw6lkcmljIExlIEdvYXRlciA8
Y2xnQHJlZGhhdC5jb20+OyBLaW0sIERvbmd3b24NCj4gPGRvbmd3b24ua2ltQGludGVsLmNvbT47
IE1hcmMtQW5kcsOpIEx1cmVhdQ0KPiA8bWFyY2FuZHJlLmx1cmVhdUByZWRoYXQuY29tPjsgUGhp
bGlwcGUgTWF0aGlldS1EYXVkw6kNCj4gPHBoaWxtZEBsaW5hcm8ub3JnPg0KPiBTdWJqZWN0OiBb
UFVMTCAxLzVdIHVpL2NvbnNvbGU6IE9ubHkgZGVjbGFyZSB2YXJpYWJsZSBmZW5jZV9mZCB3aGVu
DQo+IENPTkZJR19HQk0gaXMgZGVmaW5lZA0KPiANCj4gRnJvbTogQ8OpZHJpYyBMZSBHb2F0ZXIg
PGNsZ0ByZWRoYXQuY29tPg0KPiANCj4gVGhpcyB0byBhdm9pZCBhIGJ1aWxkIGJyZWFrYWdlIDoN
Cj4gDQo+IC4uL3VpL2d0ay1lZ2wuYzogSW4gZnVuY3Rpb24g4oCYZ2RfZWdsX2RyYXfigJk6DQo+
IC4uL3VpL2d0ay1lZ2wuYzo3Mzo5OiBlcnJvcjogdW51c2VkIHZhcmlhYmxlIOKAmGZlbmNlX2Zk
4oCZIFstV2Vycm9yPXVudXNlZC12YXJpYWJsZV0NCj4gICAgNzMgfCAgICAgaW50IGZlbmNlX2Zk
Ow0KPiAgICAgICB8ICAgICAgICAgXn5+fn5+fn4NCj4gDQo+IEZpeGVzOiBmYTY0MjY4MDViMTIg
KCJ1aS9jb25zb2xlOiBVc2UgcWVtdV9kbWFidWZfc2V0Xy4uKCkgaGVscGVycyBpbnN0ZWFkIikN
Cj4gQ2M6IERvbmd3b24gS2ltIDxkb25nd29uLmtpbUBpbnRlbC5jb20+DQo+IENjOiBNYXJjLUFu
ZHLDqSBMdXJlYXUgPG1hcmNhbmRyZS5sdXJlYXVAcmVkaGF0LmNvbT4NCj4gU2lnbmVkLW9mZi1i
eTogQ8OpZHJpYyBMZSBHb2F0ZXIgPGNsZ0ByZWRoYXQuY29tPg0KPiBSZXZpZXdlZC1ieTogUGhp
bGlwcGUgTWF0aGlldS1EYXVkw6kgPHBoaWxtZEBsaW5hcm8ub3JnPg0KPiBNZXNzYWdlLUlEOiA8
MjAyNDA1MTUxMDA1MjAuNTc0MzgzLTEtY2xnQHJlZGhhdC5jb20+DQo+IFNpZ25lZC1vZmYtYnk6
IFBoaWxpcHBlIE1hdGhpZXUtRGF1ZMOpIDxwaGlsbWRAbGluYXJvLm9yZz4NCj4gLS0tDQo+ICB1
aS9ndGstZWdsLmMgfCAyICstDQo+ICAxIGZpbGUgY2hhbmdlZCwgMSBpbnNlcnRpb24oKyksIDEg
ZGVsZXRpb24oLSkNCj4gDQo+IGRpZmYgLS1naXQgYS91aS9ndGstZWdsLmMgYi91aS9ndGstZWds
LmMgaW5kZXggMDQ3M2Y2ODljOS4uOTgzMWMxMGUxYiAxMDA2NDQNCj4gLS0tIGEvdWkvZ3RrLWVn
bC5jDQo+ICsrKyBiL3VpL2d0ay1lZ2wuYw0KPiBAQCAtNjgsOSArNjgsOSBAQCB2b2lkIGdkX2Vn
bF9kcmF3KFZpcnR1YWxDb25zb2xlICp2YykNCj4gICAgICBHZGtXaW5kb3cgKndpbmRvdzsNCj4g
ICNpZmRlZiBDT05GSUdfR0JNDQo+ICAgICAgUWVtdURtYUJ1ZiAqZG1hYnVmID0gdmMtPmdmeC5n
dWVzdF9mYi5kbWFidWY7DQo+ICsgICAgaW50IGZlbmNlX2ZkOw0KPiAgI2VuZGlmDQo+ICAgICAg
aW50IHd3LCB3aCwgd3M7DQo+IC0gICAgaW50IGZlbmNlX2ZkOw0KPiANCj4gICAgICBpZiAoIXZj
LT5nZnguZ2xzKSB7DQo+ICAgICAgICAgIHJldHVybjsNCj4gLS0NCj4gMi40MS4wDQoNCg==

