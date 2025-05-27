Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 27B3FC54ED1
	for <qemu-devel@archiver.kernel.org>; Tue, 27 May 2025 04:19:25 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uJlm2-0000CM-U5; Tue, 27 May 2025 00:18:46 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <vivek.kasireddy@intel.com>)
 id 1uJlm0-0000C0-LK
 for qemu-devel@nongnu.org; Tue, 27 May 2025 00:18:44 -0400
Received: from mgamail.intel.com ([198.175.65.15])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <vivek.kasireddy@intel.com>)
 id 1uJllx-0006PG-EY
 for qemu-devel@nongnu.org; Tue, 27 May 2025 00:18:44 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1748319522; x=1779855522;
 h=from:to:cc:subject:date:message-id:references:
 in-reply-to:content-transfer-encoding:mime-version;
 bh=OaqysNKfQn+xXyDPdeRlbzCMv6djRd+wiCDXe3Evr8s=;
 b=RLJ8nBavCI5AAlQD2G6kKcC15AfF1tdvVP3YqwLBYcw9462gX+B+0QW+
 QHuQttowkUyPQ25HfVYfZ0aOeQ+V0GfecYVPmobdqWgZ3QoQ7sNVxdIqk
 FrlnNhziDQfK9hlQS5rcysQMY8Mq2Hg/JKtfyML8N4HDTmXGVm0GArDT0
 PTy5e1Z6Wn53loP//w1a3AYEgi6sxEG74VomsOvaH/6u3KdpGdxUnvMx5
 orJaFPCNMes3qKde4FAeJKST0cn1bxrXIUv89BjDlmgAsvU7NYf/oWuwL
 GCujoGoc43tgKeq4LemH0l9COcpjLRZ8eMMjpfBDPwfZs55ufe5ZoUUKH g==;
X-CSE-ConnectionGUID: Q5JSxvEqRSWvt0pkH1r1KQ==
X-CSE-MsgGUID: s4V1gbcQTAme17C69yC4vQ==
X-IronPort-AV: E=McAfee;i="6700,10204,11445"; a="53949384"
X-IronPort-AV: E=Sophos;i="6.15,317,1739865600"; d="scan'208";a="53949384"
Received: from orviesa002.jf.intel.com ([10.64.159.142])
 by orvoesa107.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 26 May 2025 21:18:37 -0700
X-CSE-ConnectionGUID: i1Ja6fplSQ2yFaBJMxAQeQ==
X-CSE-MsgGUID: n+04XpI0TrWI2Q83r0njog==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.15,317,1739865600"; d="scan'208";a="173565540"
Received: from orsmsx903.amr.corp.intel.com ([10.22.229.25])
 by orviesa002.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 26 May 2025 21:18:37 -0700
Received: from ORSMSX901.amr.corp.intel.com (10.22.229.23) by
 ORSMSX903.amr.corp.intel.com (10.22.229.25) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.25; Mon, 26 May 2025 21:18:36 -0700
Received: from orsedg603.ED.cps.intel.com (10.7.248.4) by
 ORSMSX901.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.25 via Frontend Transport; Mon, 26 May 2025 21:18:36 -0700
Received: from NAM11-BN8-obe.outbound.protection.outlook.com (40.107.236.59)
 by edgegateway.intel.com (134.134.137.100) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.55; Mon, 26 May 2025 21:18:36 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=UIdpXQwaOzLflT1OHjNB6Oc7wQvUCmzfXDgLTVNEY/6NEIz/NfnMeDvbyaLpWwhHWr9xI2sePk8kn20akEPHeNeeQENagfxvHwWvXXDzUQFNjdx16lplNehV3REfQ5oj3EWELQ8Qf+Y/eBc2MV87ZfK0ii5pt9yBxpEbwlMo+aF8nhXb5ICmnn8ZrtrqbTZqpV7ASDpto4V/eNf2+tc0USCz0UINQcRRy0k+OmwRETt+TzPJvhdAzN3drwMr9YxSeeDlISmM33a+SewB5p/oKn8MV3LKLNfx94lfE4J2OJFxe3xkIfh3Cyx3rM0cYE2bAgAz2lepawZMxZlX8a/MYA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=OaqysNKfQn+xXyDPdeRlbzCMv6djRd+wiCDXe3Evr8s=;
 b=AVyDO3KHstUEYamKjcsx7TwGdmoK1k+vhy0oKX622lzkj86KrVodx7aRJn4sQD1gfiJFEJT8bzs1mH6omOZ47ZgkJf9pfXEvHFdZ3pulrHhfpbFn7r9GQJ70GoSa93YLpsar5mjoquSDB8W3WKVQsdeNwCXB3q4E1MQPwe+0a1YRukRP20ZJmJtaR2ej4mc1QCCjeiKC4LmwaAoIqeyxzTbhslj1dySr/zrkCYDdJ0ZQMVhlXIwTWFiB9DlEw0NuizfLik1I420Q61xjJn/8e1FZdJh1MWEAtMezec7cfeUPpal7Gp2ELkDoANFoB4vtPiZ2KNnjHY2cnehZKBfblw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Received: from IA0PR11MB7185.namprd11.prod.outlook.com (2603:10b6:208:432::20)
 by PH7PR11MB6608.namprd11.prod.outlook.com (2603:10b6:510:1b3::18)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8769.20; Tue, 27 May
 2025 04:18:31 +0000
Received: from IA0PR11MB7185.namprd11.prod.outlook.com
 ([fe80::dd3b:ce77:841a:722b]) by IA0PR11MB7185.namprd11.prod.outlook.com
 ([fe80::dd3b:ce77:841a:722b%4]) with mapi id 15.20.8769.025; Tue, 27 May 2025
 04:18:31 +0000
From: "Kasireddy, Vivek" <vivek.kasireddy@intel.com>
To: =?utf-8?B?TWFyYy1BbmRyw6kgTHVyZWF1?= <marcandre.lureau@redhat.com>
CC: "qemu-devel@nongnu.org" <qemu-devel@nongnu.org>, Gerd Hoffmann
 <kraxel@redhat.com>, Dmitry Osipenko <dmitry.osipenko@collabora.com>,
 Frediano Ziglio <freddy77@gmail.com>, Michael Scherle
 <michael.scherle@rz.uni-freiburg.de>, "Kim, Dongwon" <dongwon.kim@intel.com>, 
 =?utf-8?B?QWxleCBCZW5uw6ll?= <alex.bennee@linaro.org>
Subject: RE: [PATCH v4 0/7] ui/spice: Enable gl=on option for non-local or
 remote clients
Thread-Topic: [PATCH v4 0/7] ui/spice: Enable gl=on option for non-local or
 remote clients
Thread-Index: AQHbxUP4M+8oOz9ls0CtOJP6SKDIHLPh6eCAgAOhd1A=
Date: Tue, 27 May 2025 04:18:31 +0000
Message-ID: <IA0PR11MB71857FDE669F676491836AE2F864A@IA0PR11MB7185.namprd11.prod.outlook.com>
References: <20250515024734.758335-1-vivek.kasireddy@intel.com>
 <CAMxuvayYXPg8OHEY3E_3BXo+whr7jmTghf3CWq0+EcH8WdRWtA@mail.gmail.com>
In-Reply-To: <CAMxuvayYXPg8OHEY3E_3BXo+whr7jmTghf3CWq0+EcH8WdRWtA@mail.gmail.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: IA0PR11MB7185:EE_|PH7PR11MB6608:EE_
x-ms-office365-filtering-correlation-id: a259f352-dcfd-4138-74a3-08dd9cd58a17
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0; ARA:13230040|366016|1800799024|376014|38070700018;
x-microsoft-antispam-message-info: =?utf-8?B?czVKcXRWUitzUFRLZFZWb1JNRmJJNFk3SHlXbHZjZm9sTVZaTjFrZlhEajho?=
 =?utf-8?B?WC92UkVOajdtZkhWcExWQnRpRUlhdGZ3WEVWbE85bm1abzRkVTJ6OFVsUGZM?=
 =?utf-8?B?R0UyK1kxR2RWT1ZVM1Zpa015THRTVGVybTUyeFlLY21ZWlMrN0duZGZDemlH?=
 =?utf-8?B?bG0xa3VQb0t5S3ZVaWs5Y2pEb0taVEl3K3kwUW9PR0wreHBrR3Q5K2p1VUpq?=
 =?utf-8?B?ZXZmNVdvL0JzQ1l0MjR4SktsVWovTitBbSt0VEhtc0VOT29zbGRIVlVnK3cz?=
 =?utf-8?B?TU9qekVUYkdKek5PLzh2a2RLMXBOU1MvWCtqdEpjQzFXYldWTkVQZjlYd3VP?=
 =?utf-8?B?ZEdUSnpmS2NVNHdOZ0swWnNzWEZOVWJzNWhxd0VmNWx6SXpPZlBWK2cyN3ps?=
 =?utf-8?B?UWg4YjNvMFM1UmhHTHFNam5LNVBxWWl1enk1U045K0EvNUtLaXNVRThCc00x?=
 =?utf-8?B?Z1UxS0RIazh5N3dCRVlQcTF3dC9ESWRjd1lENTNvbXdjSTlhOFZwWHNLd05V?=
 =?utf-8?B?T1p5YmxteldZQUt6UjhvZjF5aUZjdXRUeFNIeU8rSU56eXEwODdqa1VhMjFQ?=
 =?utf-8?B?Z3gxbDNvWVgralJaaU9QRWhFb1htSEdBeFU0K0JxOE56enJTZzVpN2ZYN20y?=
 =?utf-8?B?SjZYNHNZK1JxbEo4THVlRVkvUVV3dUtoK1lxQktrcjdIN2p5eTEwK3dmNUJI?=
 =?utf-8?B?Slo1RzEvVlRxSG9NSEgvbkwyMnN3TXBQRm5MUXZ3NXdBdkxFdndvTlUzQWV5?=
 =?utf-8?B?L29Qcy93ZnNEYjRCdTdqc2pyR2Njd0xMZlFYL0RZTkYvbVZKOEpMNkdES3c2?=
 =?utf-8?B?d05DbnF2RHY3M2UzdXBrei9pYWVMQk5ZSjBMRW5sTnlqeXRxb0UwWVNVY0xX?=
 =?utf-8?B?L20zamhJQmtYclNVSmROeFhYaGNWM3E1WjRaLzRISVk1K3BTdUZ3RmFBNmMv?=
 =?utf-8?B?dE1td2xZK1dIOVFOeWtQZ054d2E0TzVIYXhIVnJkaW5hcVFhUms5UXYvZmFS?=
 =?utf-8?B?V1RnN1BON0MvWmxEaDgyQ2FnajRVUkt1L28rUVZGMHFCc2ZSYW9Gb3RDa1pY?=
 =?utf-8?B?OVNzbm50dnVRdzBDd3NPdDJCU0lmL3doeEZHbTVxZlplelV6eDVFS2thaG5Y?=
 =?utf-8?B?WGlBaDVxT2YwZ0dyUkVaRzJWWCtVM1lmdVlrcjN2S1J2ZmZpa3lNNGRnelg2?=
 =?utf-8?B?NXhTaThEWEZ1YnhEVitwa1Z5N0E4V2JyRnNQdWFQNkZPejBzM1Q3R0pBUEx4?=
 =?utf-8?B?RjNaaWpFYUY4VS8zeG8xR0FiZ1VCNmFXcVk2WVd6YXlMU0VPTTFsclE5RVp6?=
 =?utf-8?B?STYrdnJQb3RIaHlLSUVIckllUU5UMkRjRFBlcUNaaDRZTld0NmdHdTNsTTZM?=
 =?utf-8?B?V2l5aDlZTTZOR1NsSkw0bGpGN2Nlc01wdXovbzlLL0dKZjhDZTFGV0lGcHYz?=
 =?utf-8?B?akNIT042dFd0M3ZDTTFjMFpGcTI2SE9rMjNZNnF3YUROYkxCeDRabUQ1UWhy?=
 =?utf-8?B?QkJQWlhhd2FCZlR2cDlWSFpwUnJHeG1oQ1VaYm5yOVpCYVpZdXlXK0RvM2JT?=
 =?utf-8?B?RXhkSTdDNGtJY29zN2lvYUQxUlErdnlKa3QxMk5yRDgyVTdJT2p0ZlhEanpt?=
 =?utf-8?B?VmZiM3pzT0gvWmJxTUc2WndWODI1aDRGd1phT052Y3M0emk5KzhwS1ZFbnl5?=
 =?utf-8?B?S0l1V3I2dDJwV0VoZlpFaWxsOGlKQnYyc04yU0xJTmM3anRlcU1zV08zVW1u?=
 =?utf-8?B?b3VQUnRFbFhFd2RUNjUxaml0RmZQbXZMYmZGS1VKYVpkY3ZWTHJWZVNmVFpW?=
 =?utf-8?B?MGZmT3FZNEhCOGYzY0xXV2lYVTFJSDRuZkRhYTdyMllhcTFhUXhSdDVtNXZB?=
 =?utf-8?B?blRpVXd3SFlXcnpFb3dTTTFhVDdRdExZTUVzS2hXeW9tdnVOcVM0YWV5dHhY?=
 =?utf-8?Q?PB5d6ZUf0T8=3D?=
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:IA0PR11MB7185.namprd11.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(366016)(1800799024)(376014)(38070700018); DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?SVEvWU5lN054MHZlcXdwTVZpcnQ3WGlTd0p2dDRmMDR1MFBnaXJpQTBnVmJk?=
 =?utf-8?B?eU51TU1BVmlyWFYyZmRjQ3BCbWM3TE1LVndzV2dxdXRpaTZPTGwzYVBkQzNJ?=
 =?utf-8?B?WkF4NFR5MjJVVlZmUTVFMUlkOHJQWjFjZWwxUzlGYmhBWUFWZW5TTjhmZUp6?=
 =?utf-8?B?bXcvRlIvSFpXZzhDUFFGRjZiTEsvWUdXRk4xTWN2cTg4ak1tdkZ2M0ZCY2FO?=
 =?utf-8?B?bFNDOEUzUVVYUkdVNURGQUtzU21kc21nY2Y0cGlnbE1JdlpkYVJ1MDZ2U2Vt?=
 =?utf-8?B?UTV1NDA5emRLMmJ1cXhzcnV6UHJMSklKcFVrcmJMOEhPUWRqcEFQVnhTOVBT?=
 =?utf-8?B?dFVCdGorc3JldkV3NTJTT1NJamNOYys3c0oyUVRUT0JWY1QwOWF0bWxXVW54?=
 =?utf-8?B?RTNwdzUyRFk5SjFJbjBkYk5Qck1wWEpQdW5VWUNkYlJoOHFYK3hUQ1FnQ28v?=
 =?utf-8?B?cFN1QVBsTE5FY0xZZEhPaTIxaWVFOGpyT2F4T3d2dDJFSU5FNkc2YWdMd1FK?=
 =?utf-8?B?d20ySnFBYXZKOUhFRUdmOGFZM3ljWnFPSXZES3c5UDR3OGRVWVlFcFJSM1lZ?=
 =?utf-8?B?NTZ4ZGZ5NStGT0s0c1M3c3VOVGVtVWRneUpyeXJ3d016UW5MbENMUDlVUzN5?=
 =?utf-8?B?Mmp0YlFpa1ROOEFIdWVJM2JuOWxmMjcwamJ3blRSV2NSNkRqK0RHcVRteU1a?=
 =?utf-8?B?V2RYS0xuZTVCbm9FeXZ0RDVMR3BsUDd5YkV0MTJHclovZ3AzbjYrMFVqSmNR?=
 =?utf-8?B?UGtBQm9ESkF6VFBzT2dhcmJQcWpINS9vUkVJQkEwVDRSbWNYNXVkSFNURE1G?=
 =?utf-8?B?OC91azRHb3cwQTUvTEUwSG1lUUIzam5HOElySnZaM1cwVkhwc1UzUE5wYm9x?=
 =?utf-8?B?bFNkczdaYUZ0YUFEWVFhaUtMRVYvWFZ6WjZxcmIvRExYL1NIck8vSzRISm1q?=
 =?utf-8?B?U3JVS0dSUndpaW1qRGVCQ0xFbHY1eUJWYmZURDRVUnJjMnJqNEhIRDdLRkMy?=
 =?utf-8?B?cXRXeXNSSDdVREZGcmVqWXJ0Rk5xMUFYM1pTMXB2SzhwQlZGcHlwMEZTTjl5?=
 =?utf-8?B?a211TWNKTi9SYy9qM2hnMkVjSHhiRkdLY1pMZWN0eGZxZFBTeTFyR25VK1lR?=
 =?utf-8?B?akVDb1BJSHRSbUhiTE1HQ3p2ZEJGZWE2b1p1T1dPczFTVDRDL2I3L1g3Tlpi?=
 =?utf-8?B?cUpuMVdCa3Mya3FCbEZKQlIybnU2YXJFdHZVc0xlMzN3OGdpRmt1djZJdUNh?=
 =?utf-8?B?OUQycmxNNU14eWZ1U0hpWjlFYWpOemhHaFluTytVNGZMdk5Bb1dYenpjRFJK?=
 =?utf-8?B?R1RhckluSzZkZGV6WEJwOEdRUk9JVHhrY2lwcFh2d2ErRjc1N2I2SVF4TWZr?=
 =?utf-8?B?WCtqeVE0OWVWb01kMkNsWlIya1NTaU4xdXVncmQvNnJEYW8yRk1OSEUxaFJs?=
 =?utf-8?B?YXUwNWNMcGpueWphdm5OZmlDVTJsd25iTjhBV29lb1FBYUhseGxReE0vaCt2?=
 =?utf-8?B?dmRReEtwNkFRK0w5NEgxNUNINWRkOEJWTHlIbHZUUEFMUlZ1V0lwTU5NVWE2?=
 =?utf-8?B?UDdUREVxWjNDa1lGcUtuaDJIaWxxbkx6VkpGYm5yR2ZMQ2lIMlJBRkkwRFBE?=
 =?utf-8?B?ZFN0QzZGam4wZ1RvV3hwRGNKSEQ1Y21GMGhxaDA0cWwrWEtqcENhUytLbFM1?=
 =?utf-8?B?QlpYNVRSTFRUamQrV1pFRUpCTTlQa3Y5MkxQUndudUs2Y1BpY2w0R2JBTXBR?=
 =?utf-8?B?ekZsLytUd2JKRGFQZzN2MElJamFCU0ZGMmhOV2YreUM0MFVVZnozTU9JUlJP?=
 =?utf-8?B?cXVDVTdSOUFBOXdPUENWVVY4bVBnRWNGSlZEL09XUkJHTDRjZXlDZURZcTFY?=
 =?utf-8?B?K09aQmFUUnpINGtUM0Yxc1o0Y1kwNlFuMi9XODQwM2h1dlVYeDE5TnpST0xL?=
 =?utf-8?B?ODcxSE9sVmF2WTBNZFRaRmFvREVuWDJnY3YzNVE4K2pVN0lUR3k5L3pNRUpQ?=
 =?utf-8?B?bWcrYWtWTnpFN1dKTEcwQ1lmT2ZHYVdwNVlJemlsL3U5UHg1S0FpSjRuV1ZU?=
 =?utf-8?B?c2ZoVzdud2RCdlNGSkRjVW5EVXRjTHFDYml1dFhXYWZzTmhjemg0NU83Y1Zn?=
 =?utf-8?Q?98BUtXwJ1LCOVqrKHgJ4etB36?=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: IA0PR11MB7185.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: a259f352-dcfd-4138-74a3-08dd9cd58a17
X-MS-Exchange-CrossTenant-originalarrivaltime: 27 May 2025 04:18:31.4904 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: K5Kes0iGRSXdlHKOKGpoqvu5x+aIjYbULzS+qQpkDHFpXs5Dthe1u14C8kJ0MEJMDkajPBjS79lW7iaukUOqWcCR1fVlFRqtflt85dsAZmQ=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH7PR11MB6608
X-OriginatorOrg: intel.com
Received-SPF: pass client-ip=198.175.65.15;
 envelope-from=vivek.kasireddy@intel.com; helo=mgamail.intel.com
X-Spam_score_int: -72
X-Spam_score: -7.3
X-Spam_bar: -------
X-Spam_report: (-7.3 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-2.903,
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

SGkgTWFyYy1BbmRyw6ksDQoNCj4gU3ViamVjdDogUmU6IFtQQVRDSCB2NCAwLzddIHVpL3NwaWNl
OiBFbmFibGUgZ2w9b24gb3B0aW9uIGZvciBub24tbG9jYWwgb3INCj4gcmVtb3RlIGNsaWVudHMN
Cj4gDQo+IEhpDQo+IA0KPiBPbiBUaHUsIE1heSAxNSwgMjAyNSBhdCA0OjQ54oCvQU0gVml2ZWsg
S2FzaXJlZGR5DQo+IDx2aXZlay5rYXNpcmVkZHlAaW50ZWwuY29tIDxtYWlsdG86dml2ZWsua2Fz
aXJlZGR5QGludGVsLmNvbT4gPiB3cm90ZToNCj4gDQo+IA0KPiAJVG8gYWRkcmVzcyB0aGUgbGlt
aXRhdGlvbiB0aGF0IHRoaXMgb3B0aW9uIGlzIGluY29tcGF0aWJsZSB3aXRoDQo+IAlyZW1vdGUg
Y2xpZW50cywgdGhpcyBwYXRjaCBzZXJpZXMgYWRkcyBhbiBvcHRpb24gdG8gc2VsZWN0IGENCj4g
CXByZWZlcnJlZCBjb2RlYyBhbmQgYWxzbyBlbmFibGUgZ2w9b24gb3B0aW9uIGZvciBjbGllbnRz
IHRoYXQNCj4gCWFyZSBjb25uZWN0ZWQgdmlhIHRoZSBuZXR3b3JrLiBJbiBvdGhlciB3b3Jkcywg
d2l0aCB0aGlzIG9wdGlvbg0KPiAJZW5hYmxlZCAoYW5kIHRoZSBiZWxvdyBsaW5rZWQgU3BpY2Ug
c2VyaWVzIG1lcmdlZCksIGl0IHdvdWxkIGJlDQo+IAlwb3NzaWJsZSB0byBoYXZlIFFlbXUgc2hh
cmUgYSBkbWFidWYgZmQgd2l0aCBTcGljZSwgd2hpY2ggd291bGQNCj4gCXRoZW4gZm9yd2FyZCBp
dCB0byBhIGhhcmR3YXJlIG9yIHNvZnR3YXJlIGJhc2VkIGVuY29kZXIgYW5kDQo+IAlldmVudHVh
bGx5IHNlbmQgdGhlIGRhdGEgYXNzb2NpYXRlZCB3aXRoIHRoZSBmZCB0byBhIGNsaWVudCB0aGF0
DQo+IAljb3VsZCBiZSBsb2NhdGVkIG9uIGEgZGlmZmVyZW50IG1hY2hpbmUuDQo+IA0KPiAJRXNz
ZW50aWFsbHksIHRoaXMgcGF0Y2ggc2VyaWVzIHByb3ZpZGVzIGEgaGFyZHdhcmUgYWNjZWxlcmF0
ZWQsDQo+IAlvcGVuc291cmNlIFZESSBvcHRpb24gZm9yIHVzZXJzIHVzaW5nIFFlbXUgYW5kIFNw
aWNlIGJ5IGxldmVyYWdpbmcNCj4gCXRoZSBpR1BVL2RHUFUgb24gdGhlIGhvc3QgbWFjaGluZSB0
byBlbmNvZGUgdGhlIEd1ZXN0IEZCIHZpYSB0aGUNCj4gCUdzdHJlYW1lciBmcmFtZXdvcmsuDQo+
IA0KPiANCj4gDQo+IA0KPiBmb3IgdjUsIHBsZWFzZSBmaXggdGhlIHBhdGNoZXMgdG8gcGFzcyBz
Y3JpcHRzL2NoZWNrcGF0Y2gucGwNCj4gPGh0dHA6Ly9jaGVja3BhdGNoLnBsPiAuDQpTdXJlLCB3
aWxsIGRvIHRoaXMgYW5kIGluY2x1ZGUgYWxsIHlvdXIgc3VnZ2VzdGlvbnMgaW4gdjUuDQoNClRo
YW5rcywNClZpdmVrDQoNCj4gDQo+IA0KPiANCj4gCXYzIC0+IHY0IChzdWdnZXN0aW9ucyBmcm9t
IE1hcmMtQW5kcsOpKToNCj4gCS0gQWRkIGEgbmV3IHBhcmFtZXRlciB0byBtYWtlIG1heF9yZWZy
ZXNoX3JhdGUgY29uZmlndXJhYmxlDQo+IAktIEhhdmUgc3VyZmFjZV9nbF9jcmVhdGVfdGV4dHVy
ZV9mcm9tX2ZkKCkgcmV0dXJuIGJvb2wgYWZ0ZXIgY2hlY2tpbmcNCj4gCSAgZm9yIGVycm9ycw0K
PiAJLSBSZW1vdmUgdGhlIGNoZWNrIGZvciBQSVhNQU5fcjVnNmI1KCkgaW4NCj4gc3BpY2VfZ2xf
cmVwbGFjZV9mZF90ZXh0dXJlKCkNCj4gCS0gUmVwb3J0IGVycm9ycyBpbiBzcGljZV9nbF9yZXBs
YWNlX2ZkX3RleHR1cmUoKSB3aGVuIHNvbWV0aW5nIGZhaWxzDQo+IAktIFVzZSBnbEdldEVycm9y
KCkgY29ycmVjdGx5IGJ5IGFkZGluZyBhbiBhZGRpdGlvbmFsIChkdW1teSkgY2FsbA0KPiAJICBi
ZWZvcmUgY2hlY2tpbmcgZm9yIGFjdHVhbCBlcnJvcnMgKERtaXRyeSkNCj4gCS0gQWRkIGEgbmV3
IHBhdGNoIHRvIGNoZWNrIGZkIHZhbHVlcyBpbiBlZ2xfZG1hYnVmX2V4cG9ydF90ZXh0dXJlKCkN
Cj4gCS0gUmViYXNlIG9uIFFlbXUgbWFzdGVyDQo+IA0KPiAJdjIgLT4gdjM6DQo+IAktIENoZWNr
IGZvciBlcnJvcnMgYWZ0ZXIgaW52b2tpbmcgZ2xJbXBvcnRNZW1vcnlGZEVYVCgpIHVzaW5nDQo+
IAkgIGdsR2V0RXJyb3IoKSBhbmQgcmVwb3J0IHRoZSBlcnJvciB0byB1c2VyIChEbWl0cnkpDQo+
IA0KPiAJdjEgLT4gdjI6DQo+IAktIFJlcGxhY2UgdGhlIG9wdGlvbiBuYW1lIHByZWZlcnJlZC1j
b2RlYyB3aXRoIHZpZGVvLWNvZGVjcyAoTWFyYy0NCj4gQW5kcsOpKQ0KPiAJLSBBZGQgYSB3YXJu
aW5nIHdoZW4gYW4gZmQgY2Fubm90IGJlIGNyZWF0ZWQgZnJvbSB0ZXh0dXJlIChNYXJjLQ0KPiBB
bmRyw6kpDQo+IAktIEFkZCBhIG5ldyBwYXRjaCB0byBibGl0IHRoZSBzY2Fub3V0IHRleHR1cmUg
aW50byBhIGxpbmVhciBvbmUgdG8NCj4gCSAgbWFrZSBpdCB3b3JrIHdpdGggdmlyZ2wNCj4gCS0g
UmViYXNlZCBhbmQgdGVzdGVkIGFnYWluc3QgdGhlIGxhdGVzdCBTcGljZSBtYXN0ZXINCj4gDQo+
IAlUZXN0ZWQgd2l0aCB0aGUgZm9sbG93aW5nIFFlbXUgcGFyYW1ldGVyczoNCj4gCS1kZXZpY2Ug
dmlydGlvLXZnYSxtYXhfb3V0cHV0cz0xLHhyZXM9MTkyMCx5cmVzPTEwODAsYmxvYj10cnVlDQo+
IAktc3BpY2UgcG9ydD0zMDAxLGdsPW9uLGRpc2FibGUtdGlja2V0aW5nPW9uLHZpZGVvLQ0KPiBj
b2RlY3M9Z3N0cmVhbWVyOmgyNjQNCj4gDQo+IAlhbmQgcmVtb3RlLXZpZXdlciAtLXNwaWNlLWRl
YnVnIHNwaWNlOi8veC54LngueDozMDAxIG9uIHRoZSBjbGllbnQgc2lkZS4NCj4gDQo+IAlBc3Nv
Y2lhdGVkIFNwaWNlIHNlcnZlciBNUiAobWVyZ2VkKToNCj4gCWh0dHBzOi8vZ2l0bGFiLmZyZWVk
ZXNrdG9wLm9yZy9zcGljZS9zcGljZS8tL21lcmdlX3JlcXVlc3RzLzIyOQ0KPiANCj4gCS0tLQ0K
PiAJQ2M6IEdlcmQgSG9mZm1hbm4gPGtyYXhlbEByZWRoYXQuY29tIDxtYWlsdG86a3JheGVsQHJl
ZGhhdC5jb20+DQo+ID4NCj4gCUNjOiBNYXJjLUFuZHLDqSBMdXJlYXUgPG1hcmNhbmRyZS5sdXJl
YXVAcmVkaGF0LmNvbQ0KPiA8bWFpbHRvOm1hcmNhbmRyZS5sdXJlYXVAcmVkaGF0LmNvbT4gPg0K
PiAJQ2M6IERtaXRyeSBPc2lwZW5rbyA8ZG1pdHJ5Lm9zaXBlbmtvQGNvbGxhYm9yYS5jb20NCj4g
PG1haWx0bzpkbWl0cnkub3NpcGVua29AY29sbGFib3JhLmNvbT4gPg0KPiAJQ2M6IEZyZWRpYW5v
IFppZ2xpbyA8ZnJlZGR5NzdAZ21haWwuY29tDQo+IDxtYWlsdG86ZnJlZGR5NzdAZ21haWwuY29t
PiA+DQo+IAlDYzogTWljaGFlbCBTY2hlcmxlIDxtaWNoYWVsLnNjaGVybGVAcnoudW5pLWZyZWli
dXJnLmRlDQo+IDxtYWlsdG86bWljaGFlbC5zY2hlcmxlQHJ6LnVuaS1mcmVpYnVyZy5kZT4gPg0K
PiAJQ2M6IERvbmd3b24gS2ltIDxkb25nd29uLmtpbUBpbnRlbC5jb20NCj4gPG1haWx0bzpkb25n
d29uLmtpbUBpbnRlbC5jb20+ID4NCj4gCUNjOiBBbGV4IEJlbm7DqWUgPGFsZXguYmVubmVlQGxp
bmFyby5vcmcNCj4gPG1haWx0bzphbGV4LmJlbm5lZUBsaW5hcm8ub3JnPiA+DQo+IA0KPiAJVml2
ZWsgS2FzaXJlZGR5ICg3KToNCj4gCSAgdWkvZWdsLWhlbHBlcnM6IEVycm9yIGNoZWNrIHRoZSBm
ZHMgaW4gZWdsX2RtYWJ1Zl9leHBvcnRfdGV4dHVyZSgpDQo+IAkgIHVpL3NwaWNlOiBBZGQgYW4g
b3B0aW9uIGZvciB1c2VycyB0byBwcm92aWRlIGEgcHJlZmVycmVkIGNvZGVjDQo+IAkgIHVpL3Nw
aWNlOiBFbmFibGUgZ2w9b24gb3B0aW9uIGZvciBub24tbG9jYWwgb3IgcmVtb3RlIGNsaWVudHMN
Cj4gCSAgdWkvc3BpY2U6IEFkZCBhbiBvcHRpb24gdG8gc3VibWl0IGdsX2RyYXcgcmVxdWVzdHMg
YXQgZml4ZWQgcmF0ZQ0KPiAJICB1aS9jb25zb2xlLWdsOiBBZGQgYSBoZWxwZXIgdG8gY3JlYXRl
IGEgdGV4dHVyZSB3aXRoIGxpbmVhciBtZW1vcnkNCj4gCSAgICBsYXlvdXQNCj4gCSAgdWkvc3Bp
Y2U6IENyZWF0ZSBhIG5ldyB0ZXh0dXJlIHdpdGggbGluZWFyIGxheW91dCB3aGVuIGdsPW9uIGlz
DQo+IAkgICAgZW5hYmxlZA0KPiAJICB1aS9zcGljZTogQmxpdCB0aGUgc2Nhbm91dCB0ZXh0dXJl
IGlmIGl0cyBtZW1vcnkgbGF5b3V0IGlzIG5vdCBsaW5lYXINCj4gDQo+IAkgaW5jbHVkZS91aS9j
b25zb2xlLmggICAgICAgfCAgIDIgKw0KPiAJIGluY2x1ZGUvdWkvc3BpY2UtZGlzcGxheS5oIHwg
ICA1ICsNCj4gCSBxZW11LW9wdGlvbnMuaHggICAgICAgICAgICB8ICAxMCArKw0KPiAJIHVpL2Nv
bnNvbGUtZ2wuYyAgICAgICAgICAgIHwgIDMyICsrKysrKw0KPiAJIHVpL2VnbC1oZWxwZXJzLmMg
ICAgICAgICAgIHwgICA2ICsrDQo+IAkgdWkvc3BpY2UtY29yZS5jICAgICAgICAgICAgfCAgMjcg
KysrKysNCj4gCSB1aS9zcGljZS1kaXNwbGF5LmMgICAgICAgICB8IDIxMiArKysrKysrKysrKysr
KysrKysrKysrKysrKysrKysrKysrLQ0KPiAtLQ0KPiAJIDcgZmlsZXMgY2hhbmdlZCwgMjc4IGlu
c2VydGlvbnMoKyksIDE2IGRlbGV0aW9ucygtKQ0KPiANCj4gCS0tDQo+IAkyLjQ5LjANCj4gDQo+
IA0KDQo=

