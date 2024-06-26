Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 567C4C27C4F
	for <qemu-devel@archiver.kernel.org>; Wed, 26 Jun 2024 15:57:13 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sMV0j-0004YU-Ad; Wed, 26 Jun 2024 11:56:41 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <tony.luck@intel.com>)
 id 1sMV0h-0004Y7-IX
 for qemu-devel@nongnu.org; Wed, 26 Jun 2024 11:56:39 -0400
Received: from mgamail.intel.com ([198.175.65.16])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <tony.luck@intel.com>)
 id 1sMV0f-0002Qf-TW
 for qemu-devel@nongnu.org; Wed, 26 Jun 2024 11:56:39 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1719417398; x=1750953398;
 h=from:to:cc:subject:date:message-id:references:
 in-reply-to:content-transfer-encoding:mime-version;
 bh=mr71hbbdf9kS5sZ5q1yK7DIWG7pz0f/gchYfhiZuJm4=;
 b=M2Pqk96MsVweUqkq3/dzK+uhP3rOKwbWolz/ugzeUH3YGZTlp4Rzgsgf
 sGzDeSr2YSIawEdMLs4S5WhIgUwKleB0shcncrJ7ZvtKxroSPRBNvJtUb
 W+NuTzqnhnoo2auFC0kZfEJlVpY4ndUIaKxDpHEMlGoTz62yRO+vP3e8q
 IE0ZtIevCVneV1lNnbgeNxgaFzEAZwo/ViHL8ahgSre1TxsUX0fP1BjnA
 J8mvhTmc6nridoLpF8NvFQ0K2zkd1LnMm0a/9ApsIz9QXheX54W4ZOukF
 bVITnVBnA1ikSWcgIe1XKYsSN3wrhjsKISVIuUFpFkni1rpiaX6sY3dLz Q==;
X-CSE-ConnectionGUID: 0AM+8UxuThGBTxDfzH9f8w==
X-CSE-MsgGUID: /KS3O2SCRdyh+/F+RcOq6g==
X-IronPort-AV: E=McAfee;i="6700,10204,11115"; a="16634682"
X-IronPort-AV: E=Sophos;i="6.08,267,1712646000"; d="scan'208";a="16634682"
Received: from fmviesa001.fm.intel.com ([10.60.135.141])
 by orvoesa108.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 26 Jun 2024 08:56:34 -0700
X-CSE-ConnectionGUID: 3+GwYWIjTwKWR9tz/NKS7Q==
X-CSE-MsgGUID: 62r7eKt0RruUsq9sDCBShQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.08,267,1712646000"; d="scan'208";a="75236600"
Received: from fmsmsx602.amr.corp.intel.com ([10.18.126.82])
 by fmviesa001.fm.intel.com with ESMTP/TLS/AES256-GCM-SHA384;
 26 Jun 2024 08:56:33 -0700
Received: from fmsmsx611.amr.corp.intel.com (10.18.126.91) by
 fmsmsx602.amr.corp.intel.com (10.18.126.82) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.39; Wed, 26 Jun 2024 08:56:33 -0700
Received: from fmsmsx602.amr.corp.intel.com (10.18.126.82) by
 fmsmsx611.amr.corp.intel.com (10.18.126.91) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.39; Wed, 26 Jun 2024 08:56:32 -0700
Received: from FMSEDG603.ED.cps.intel.com (10.1.192.133) by
 fmsmsx602.amr.corp.intel.com (10.18.126.82) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.39 via Frontend Transport; Wed, 26 Jun 2024 08:56:32 -0700
Received: from NAM02-DM3-obe.outbound.protection.outlook.com (104.47.56.40) by
 edgegateway.intel.com (192.55.55.68) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.39; Wed, 26 Jun 2024 08:56:32 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=XypZhp0c8c8km3ldfUOc+ibwk1kU1J4qcSp3SE1bDKHIS7GXegTMpZ3YhlNB55m2+aNWOtBKwt+gj2bStJ4Rm5bN24yEWOjw4yMZ8SaHE5uRIuLYQB3eWOZg9VT+Hbqjh8jJWBX7P5k/WpJqIL2ZUvtSPsnvZURcfexqvz5XH8IinKegoTCerlOShKkWkoolSnke0A9LTP/ifqaPHYpKDwVDPh2Z28monGitYLi1waPpJCgSAJd/NjkCCNcTL5hC4p0rJLejJocAvxCfs77BETOBsJ/NzvJfTa2UeHZ+obiqHHui4yRrL66xHHnj7h9iui1BO0syUfkrr8IGGEaVZA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=mr71hbbdf9kS5sZ5q1yK7DIWG7pz0f/gchYfhiZuJm4=;
 b=cNOhfRRKsHrvDRT6cuJYc8UPvGRneWI/lft7ujBr1jQBJO292U8TAAZ/2itNI7unuZEAeHxQFfaJnux0iqIueYIEKL4fR8GzLVGbu/gruG7Bn8cr8Hxvt6QFF4MW4VAct5xhMPcUSBFKenrPNYWLtPvb5vDhjCG3ZfbnLySgZcJrvPtQyaA8mHMRAB1ZkU8b9ib6vV8Zkis7nCc3Am2QWJfVRTRhBueto8T7nPGm7ULXrElrfLcCo/JliQs9DLeN5aY8vgcsFFYOpTMqwKPlqz7b/11c3qAAJJfZbTzQ/+vY/hG2N4NmgOEAxycaM47KG02/hNB+gLFto85vGO8Nog==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Received: from SJ1PR11MB6083.namprd11.prod.outlook.com (2603:10b6:a03:48a::9)
 by PH8PR11MB7118.namprd11.prod.outlook.com (2603:10b6:510:216::6)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7698.32; Wed, 26 Jun
 2024 15:56:29 +0000
Received: from SJ1PR11MB6083.namprd11.prod.outlook.com
 ([fe80::acfd:b7e:b73b:9361]) by SJ1PR11MB6083.namprd11.prod.outlook.com
 ([fe80::acfd:b7e:b73b:9361%5]) with mapi id 15.20.7698.025; Wed, 26 Jun 2024
 15:56:29 +0000
From: "Luck, Tony" <tony.luck@intel.com>
To: Shiyang Ruan <ruansy.fnst@fujitsu.com>, Jonathan Cameron
 <Jonathan.Cameron@Huawei.com>, "Williams, Dan J" <dan.j.williams@intel.com>
CC: "qemu-devel@nongnu.org" <qemu-devel@nongnu.org>,
 "linux-cxl@vger.kernel.org" <linux-cxl@vger.kernel.org>, "dave@stgolabs.net"
 <dave@stgolabs.net>, "Weiny, Ira" <ira.weiny@intel.com>, "Schofield, Alison"
 <alison.schofield@intel.com>, "Jiang, Dave" <dave.jiang@intel.com>, "Verma,
 Vishal L" <vishal.l.verma@intel.com>, Borislav Petkov <bp@alien8.de>, "James
 Morse" <james.morse@arm.com>, Mauro Carvalho Chehab <mchehab@kernel.org>,
 Robert Richter <rric@kernel.org>, "linux-edac@vger.kernel.org"
 <linux-edac@vger.kernel.org>, Miaohe Lin <linmiaohe@huawei.com>, "Naoya
 Horiguchi" <nao.horiguchi@gmail.com>, "linux-mm@kvack.org"
 <linux-mm@kvack.org>
Subject: RE: [RFC PATCH] cxl: avoid duplicating report from MCE & device
Thread-Topic: [RFC PATCH] cxl: avoid duplicating report from MCE & device
Thread-Index: AQHawzOz2XZytMimJk6HWFfyu84XE7HSgzIAgAAMqwCAAAwS4IAG+qyAgACkv6A=
Date: Wed, 26 Jun 2024 15:56:29 +0000
Message-ID: <SJ1PR11MB6083829FC72B2230C1CB1599FCD62@SJ1PR11MB6083.namprd11.prod.outlook.com>
References: <20240618165310.877974-1-ruansy.fnst@fujitsu.com>
 <20240620180239.00004d41@Huawei.com>
 <6675bf92116ed_57ac294a@dwillia2-xfh.jf.intel.com.notmuch>
 <20240621194506.000024aa@Huawei.com>
 <SJ1PR11MB6083837A8588894E49FEBC7BFCC92@SJ1PR11MB6083.namprd11.prod.outlook.com>
 <bc58d99a-785f-4bb3-a9c9-9cf50ea7e06d@fujitsu.com>
In-Reply-To: <bc58d99a-785f-4bb3-a9c9-9cf50ea7e06d@fujitsu.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: SJ1PR11MB6083:EE_|PH8PR11MB7118:EE_
x-ms-office365-filtering-correlation-id: 12164152-7736-4da8-3545-08dc95f88b28
x-ld-processed: 46c98d88-e344-4ed4-8496-4ed7712e255d,ExtAddr
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
 ARA:13230038|366014|376012|7416012|1800799022|38070700016; 
x-microsoft-antispam-message-info: =?utf-8?B?eVREWENDaEp1QnhYUUFiRndwNWdPZk9LWmladG54R0NJYi82K3FSUjZpUER6?=
 =?utf-8?B?aEtzbFUwN2RlcXBkOGliU2RFVUNDNUhzUW5Tdi9OOFZiNjZTMytCY09BcjVx?=
 =?utf-8?B?dGxjWTAxK0pQTmpzOTFxMFdTT2ZWVTRjemhZdk1XcXk1WGtpRjJYZjZnVzRq?=
 =?utf-8?B?NUdlL0lSUlJ0L0VxelJtalBqY09hMkFvbmJGSnZ2RWFTYlArc2oxNVcrN3dB?=
 =?utf-8?B?bWd5emFnYW1ER1JOTFh0VWd4TStzMkNieXdncWQwRWtSd2R0dWRPU0tCQ1d0?=
 =?utf-8?B?bDNoU2I5OGRsUFV0cUpiNXBEc3RGTW1IazFwbkxFc0JKbHBQbkRVM0hPTTJ5?=
 =?utf-8?B?MC85dm5zYThQU1QwOVg1MjNLZVhFVzNaVERTV2ZWdnAyMVVuL3hYUXNIZWNX?=
 =?utf-8?B?dkRDbFFaUHk1YWcvR05yK3RLNkRvTTBMZE9OSFNwYTNZNWJpaVJiUlBBSXNn?=
 =?utf-8?B?b2QxVmxMN0JuTldBNGY2WDZndXpWa3hHRi92NEdjc0RUSmg2UDdrY2tQY2ox?=
 =?utf-8?B?d2xud2tNbTZhblB0bjZxVVVaUzJsQTV1ZUtZTG5DMnd5OWxsdVorUUtrYkxH?=
 =?utf-8?B?bmV3c3hZcDkzM2t4bUk1d3MxWEZ3ZU45dzRob2JrNkdTVW4zdm5DRkl4dnZ6?=
 =?utf-8?B?b2NSNWRYL05lRnRLbEEvS1gxU2JmZjFRVmhvbWtXMzZYZkpybkpObGdsSTZ6?=
 =?utf-8?B?b0Q0MFJVK1lyZjFuY2MxWXhvQ0hyenc0dTIycTVhWjJhSFVlUHpRdVZOZy9l?=
 =?utf-8?B?TUdZOURKVktyT2o2QWt2S0k4Q1FGLzVDU0w1TzkrSGg5RnB6dytFNmhjZmR0?=
 =?utf-8?B?alk5eWlPdXBsaklYYktCSEJsdFU0WDdEaFlyWWlHMi94N3daVFkyeUhxZXpD?=
 =?utf-8?B?cjU5LzZqQVlUdzd2aHhzKzZUUjlFNHFTcjZTRkhhUXNEWTQxSnJmMW9xTUxE?=
 =?utf-8?B?YmcyUC85MnVqYjN2Z1NSb240M2VxUW1qaDBCdmRSLzM1TXR0QjBaLy96M1Q5?=
 =?utf-8?B?SDU2U1hJWkVxK1JtMHp2aGtGbzNRMUdqZVgyWWtXUlA0OWZmUXZ4UkNwTzJs?=
 =?utf-8?B?S2xsNG05YVY5ZW9JMHZDc0lyb1Zzem1vUEJzTzNZdUppdDdsMWhkVGpmREkx?=
 =?utf-8?B?Q1I3UEhlNUo2aFlGQjNSZ3RuR2RucHROTUM1OWptZGJPbWRZZ1BKQXZaRHRo?=
 =?utf-8?B?NXdVdktnRHdBVk5IclJEclp4SmhlejRQOUwxV0ErS0d3SXdzWGN5ZGxkdGRy?=
 =?utf-8?B?ZVNSNWdsdDVwc29EWVBTYXFyRFkzcG4yelh6clVSMnRRdTR2Q2c2S3V4Q1pl?=
 =?utf-8?B?TlR5LzE3cTNRN3lrQWdQcENoK2k3ZUdveXlXa0xSWDFJU2FydTQ5eEQ5NHEz?=
 =?utf-8?B?NngwTHYxYlZIQjlBMXh0V2ZaUnRIblB0R0g3YlFxMG9yZHZ1U2lqNmlMa2xk?=
 =?utf-8?B?enIrbnM2Vi9HMTc5dGNXNmczbnh6VG1ZaWRScG5aZ1h1ekdFOFNDRzRQM1R2?=
 =?utf-8?B?YlpVWVJ6Vm1td1BVR2d2YXJtZzhIeGx5VnBPRCtGbVo1Ui9uU2d0emc4MHNW?=
 =?utf-8?B?d3JDZDRrUjhCYW8raEVLc3oyNjZZMXZETXd2NExtWEJJQTYrWkVOKzNrTXNY?=
 =?utf-8?B?REZjaVc3OG9IeDJ2dHlVNEdXaWtPeVkyL2RqVEJqdy9rS0lUNm1YYlVXWk0r?=
 =?utf-8?B?K2xkblhuaVdIVVhJYytlUzFtSi81TERuemJSZS9vcXFIYWRBOXMzQll6Ty93?=
 =?utf-8?B?UW9qQStnZmtyME5EMCtVV2IwR0FlNi95dXduVG1VZkc4MHJKOENVYVk2R3c5?=
 =?utf-8?Q?ZbG/K+v3o+pUeMIBTDumHfubgDxHq8zYVv6bA=3D?=
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:SJ1PR11MB6083.namprd11.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230038)(366014)(376012)(7416012)(1800799022)(38070700016); DIR:OUT;
 SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?SzBlcHhnUkQyd2JmVUM1bDdmSXU0dWV5V0xUMDY4VlNXTytSMEp1c3BVSERZ?=
 =?utf-8?B?b20wVWFFYUhFN0RJZ08wYy9SbzYxSzRPWWhucldESEdLTWFSL0JSd2VMOEdE?=
 =?utf-8?B?SXd3WlJGc0xLN2Nva1l3WlhGbWYra0ZkT2N5Njc0WjRwMEM3SlVLK09Gd0VU?=
 =?utf-8?B?c3lxdHoydkljblpYcFg4NFVmUDJNbXRoRWF4YWFXejc3WGNDcE5PYzlIU2JJ?=
 =?utf-8?B?ckJyc2gzVVFPWHlGZVpLRWFaa1U2Mk41bzFPblhNVFJoQ0JGU2lNNngxZnYz?=
 =?utf-8?B?b01wa3VhdU5RSW84QytGWTBOTWRJUitNM2lOVVo2SHVRZzhYN2EyR2U2YUEv?=
 =?utf-8?B?V28xVkJUMi84c3JZY0g4T1FmZ1VFWjVhakhVRXBrN01rV0wzbmVDY0drTnVo?=
 =?utf-8?B?Z1BYamF1RmpXSmhESkx5anMwd0ZqcWhNSVY2eHNvaU1BMkxYK1dGSFFFbXFE?=
 =?utf-8?B?R3FYRzVlZEJ1cEtWdW54OUdNdC8rNXQvamxnVVRNMW5ieEd2OGJVTjQxdncv?=
 =?utf-8?B?SGJxSER2V3U4T2k1U1FjQkwrbzcyZmU4WVZMV0RrM2NkdVVxK1hQMmpKVEIy?=
 =?utf-8?B?TnVuRmtnRjhBdzhwOGJkWVp1UWxSMzBORlZRK1VieG1xRnJwL2kwdVR6VDFr?=
 =?utf-8?B?NjBpRFFVQnBmN3h3Q1BmWUJlN0tYMml5dVRKVGJGYTdoQUZsZDFkYXd4cS9Z?=
 =?utf-8?B?TVRsejREM2xqOTNZckJyQ3lrTWwvOGVCNzZtc0xETERocDFicFF5eFlPV0R5?=
 =?utf-8?B?RUxCcU5zQWZOTkJvT1pJMkVmSzVzUFpsc2g4SGY3UmJmTUFhc0VLLzcwdTg2?=
 =?utf-8?B?d0JWUGVMNkpHVWdzTE9IeWp0MisrWUVXRENwazlucnFyZEROTmI1N2FRZmJJ?=
 =?utf-8?B?NUpVY3RHVG1YYVZQV0wwbVJFT3RBMVZNVHIvWFVOTFFWbXhOSTF5TmZDVDh2?=
 =?utf-8?B?YW5EUkNrM3JUbHNPaGw3Y1FjNDRrQk5JOUN5bHpJa1hVT2xReEdUY1NFUWpn?=
 =?utf-8?B?T3VSTDBYdFVGNGRWWVl1YngwSUZORFZPUDBMQ0RuVFdPY25wL2IwNlFuZlcz?=
 =?utf-8?B?eXFoWC9XVURsdXhHZnAvaUVIMXpJWDQwU3pOeVpLZFhET0NKQU5ySzhKYkZR?=
 =?utf-8?B?U2RPZjBHWU1RcFFGNzk2Vit1VUkyaStyUVI2YU9BMlZkTzdtck4ybTRhaVd2?=
 =?utf-8?B?MHVpM0tTM1FQRGlpdlBUZk5adVJUVjJBSUhtRVE4NE80ZVpjU1EraUpWUEg4?=
 =?utf-8?B?bkFwam1sanJFc2hBNXgwQzdhd25hNmJydHpKeXRCNW0xNHdTKzBlbFZIRlBH?=
 =?utf-8?B?cWpYbkUyUmRCakszYm05OTd5V1JFWGhyc20yTmhwdmhoV2M5SnpSTnl3MXNE?=
 =?utf-8?B?cW5xNlJlajZRMVpZTVRBb3FQa0VrbFVrSkVNV0tHSnQxdU04SkY2YkV3b0ht?=
 =?utf-8?B?REZsY3BESGxoSXhEYmg4Wk1vUWhnd2JzOEZRaHZwbGUvZW5keU1FMTlOcUdM?=
 =?utf-8?B?Z0JmUDhFcEVrd1ptNkdmM3hWZ2JTdHEwTkJTZ2ZJNzcvYjBhdWpRZ0RNRVNx?=
 =?utf-8?B?TjFKNGI5d2tHeXYrMjU4dk5LU3pwamNMWXFzd3BVVXA3bVk4Z3FERE5hN1M1?=
 =?utf-8?B?cHJGbnhiNGtKK1BSS0JGOThFTnV4c1RXZXc5TzBFTy9tOW5JazRSTlpXd3oz?=
 =?utf-8?B?Qk5CdVdHS04rR3RlTXNJOWQ5aVkyUURGMXVPRUtRYXcvQTNlU2IyeWQ0Yk9t?=
 =?utf-8?B?UGxXUWY3b0d5d0JFUmJUbzFzWmowcWc3QVV3RDdiblJLdUJxZXpvQ1Z5cXo1?=
 =?utf-8?B?R0crLzNMSklkRFJJeHhGemlLMjhZTWVkTjdJZXJhWFZLWk81QXZWbHBweTJt?=
 =?utf-8?B?aXduWHA5amZkN1BYcU9mNXdMakhOZzBXN0loeUJnY05LQlRYVzE5aXRTVFJL?=
 =?utf-8?B?K0NGOW5hbDFhY0RqK0ltdEg1YjJ5VHVTQmRaZ1lrcjZuRVRoTUZTNmlSaHl5?=
 =?utf-8?B?WXBRUDJPVXkvY1RCZkRiMHdCZjNKZDcySXpqU0VvTWxKeW5HblVFTlRqZ0pw?=
 =?utf-8?B?RjJOUm5NV2JkQy9OdHhzS01obXQxU3FYcjJQcEtGQkZzZ0pNWml4LzRJVUow?=
 =?utf-8?Q?TkDMmvzbNXZNTSSvNTUJQIKkT?=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: SJ1PR11MB6083.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 12164152-7736-4da8-3545-08dc95f88b28
X-MS-Exchange-CrossTenant-originalarrivaltime: 26 Jun 2024 15:56:29.8644 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: U+yT4OP34WjPNjecu5OEkUQgBqeT6iuG1YvPcYa7Y7oc8iTVvLuOsq/vqGRfhcHzSJBbcs309F866y8AlqNKjw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH8PR11MB7118
X-OriginatorOrg: intel.com
Received-SPF: pass client-ip=198.175.65.16; envelope-from=tony.luck@intel.com;
 helo=mgamail.intel.com
X-Spam_score_int: -45
X-Spam_score: -4.6
X-Spam_bar: ----
X-Spam_report: (-4.6 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.207,
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

Pj4gU28gcmVjb3ZlcnkgaGFzIHNvbWUgcmlzaywgYnV0IHZlcnkgbGl0dGxlIHVwc2lkZSBiZW5l
Zml0Lg0KPg0KPiBTaW5jZSB0aGUgaGFyZHdhcmUgcHJvdmlkZXMgdGhlIGluc3RydWN0aW9uKENQ
VSkvY29tbWFuZChDWEwpIHRvIGNsZWFyIA0KPiB0aGUgcG9pc29uLCB3ZSBjb3VsZCBtYWtlIHRo
ZSBmdW5jdGlvbiB3b3JrLCBhdCBsZWFzdCBhcyBhbiBvcHRpb25hbCANCj4gZmVhdHVyZS4gIFRo
ZW4gdXNlcnMgY291bGQgZGVjaWRlIHRvIHVzZSBpdCBvciBub3QgYWZ0ZXIgZXZhbHVhdGluZyB0
aGUgDQo+IHJpc2sgYW5kIGJlbmVmaXQuDQo+DQo+IEkgdGhpbmsgZG9pbmcgcmVjb3ZlcnkgaXMg
YW4gaW1wcm92ZW1lbnQgc3RlcCwgYW5kIG1heSBuZWVkIGEgbG90IG9mIA0KPiBkaXNjdXNzaW9u
LiAgSSdtIG5vdCBzdXJlIGlmIHdlIGNvdWxkIHJlYWNoIGEgY29uY2x1c2lvbiBpbiB0aGlzIHRo
cmVhZC4gDQo+ICBKdXN0IGhvcGUgbW9yZSBjb21tZW50cyBvbiB0aGUgb3JpZ2luYWwgcHJvYmxl
bSAoZHVwbGljYXRlIHJlcG9ydCkgdG8gDQo+IHNvbHZlIGluIHRoaXMgcGF0Y2guDQoNClBvc3Qg
YSBwYXRjaCB0byBpbXBsZW1lbnQgcG9pc29uIGNsZWFyaW5nL3JlY292ZXJ5IHdpdGggc29tZSB3
YXkgdG8gb3B0LWluDQp0byBnZXQgdGhlIGRpc2N1c3Npb24gc3RhcnRlZC4gSWYgaXQgZG9lc24n
dCBhZGQgdG9vIG11Y2ggY29tcGxleGl0eSBwZXJoYXBzDQppdCB3aWxsIGJlIGFjY2VwdGVkLg0K
DQotVG9ueQ0K

