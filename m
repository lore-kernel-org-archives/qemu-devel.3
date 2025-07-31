Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4F7D5C83F17
	for <qemu-devel@archiver.kernel.org>; Thu, 31 Jul 2025 08:50:37 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uhOyu-0001WT-B1; Thu, 31 Jul 2025 04:49:44 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <zhenzhong.duan@intel.com>)
 id 1uhOyq-0001RA-6E
 for qemu-devel@nongnu.org; Thu, 31 Jul 2025 04:49:40 -0400
Received: from mgamail.intel.com ([192.198.163.11])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <zhenzhong.duan@intel.com>)
 id 1uhOyn-0003ZX-9Y
 for qemu-devel@nongnu.org; Thu, 31 Jul 2025 04:49:39 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1753951777; x=1785487777;
 h=from:to:cc:subject:date:message-id:references:
 in-reply-to:content-transfer-encoding:mime-version;
 bh=9K9F/C7uW0XW93LfQUu879Sh8afLyilLpNuvbIFGA28=;
 b=V5xCN0ZidWhomX7DsspePZvMj0SN+HgMnepSL8JSNpGANRoEvXqnKSNU
 j8tplUHjj2gxtg286JQXG8cWxN9n162ap5wJM5xp3Q23lYFjyMOvIO9bN
 kXqT5TyWNW1nVfG0Ctti8cmpNT3NpUzUhLbgKHsZdJ/XUqgZHCKtA3uar
 KejoSOHzxDABo8MoUIlatJDA8ljOy/N0Sr/MwqpK3yYz/l4AW6sz+Oeoq
 AgZs7uqXWOqgLjvecKR3AxGNUxXRI9AZU93EwcGx851Ja+NiyBd5zzqPc
 X2T9EwGuCISQJkMlkoS/N7WE2E8xONOKNG9WdvbByZ+l9mDRuipJgubsj A==;
X-CSE-ConnectionGUID: nxwEvKRdRg+AkzsvvEAe6w==
X-CSE-MsgGUID: eiXos9uzTVGBV1UVoTS2rg==
X-IronPort-AV: E=McAfee;i="6800,10657,11507"; a="66832378"
X-IronPort-AV: E=Sophos;i="6.16,353,1744095600"; d="scan'208";a="66832378"
Received: from fmviesa010.fm.intel.com ([10.60.135.150])
 by fmvoesa105.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 31 Jul 2025 01:49:33 -0700
X-CSE-ConnectionGUID: TOV25cpCTAWnn0oKjlwsqQ==
X-CSE-MsgGUID: OQI435iwQVCZuvwtPceLng==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.16,353,1744095600"; d="scan'208";a="164005049"
Received: from orsmsx902.amr.corp.intel.com ([10.22.229.24])
 by fmviesa010.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 31 Jul 2025 01:49:32 -0700
Received: from ORSMSX903.amr.corp.intel.com (10.22.229.25) by
 ORSMSX902.amr.corp.intel.com (10.22.229.24) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1748.26; Thu, 31 Jul 2025 01:49:32 -0700
Received: from ORSEDG901.ED.cps.intel.com (10.7.248.11) by
 ORSMSX903.amr.corp.intel.com (10.22.229.25) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1748.26 via Frontend Transport; Thu, 31 Jul 2025 01:49:32 -0700
Received: from NAM10-MW2-obe.outbound.protection.outlook.com (40.107.94.81) by
 edgegateway.intel.com (134.134.137.111) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1748.26; Thu, 31 Jul 2025 01:49:31 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=YIYcQ9ou8Fs3jW07a3bu8WBDWXRmN27XlhaC+JWgjeN/z5loqRs9d7YKCe2JPCi9I9LUoVslEXuTdTVYWcC2V4KB4X6gnNxzTTkh+bQObIgzEtjP5/n/mBYkc0pwY/p87pKcYd7iskzEFzCfO2Qlr9o9K8PqrixoMJzEh7EkGtcvJujdL4vYcFl261FV4mMHm3PJx4HVLiP0CQad3Z7qtEjkmFlqhZK+ue0qdKFvgdtDwVggFbRW7qRjWoKffVbNXCxOSNdSdoGXVQP1LIdVcbsRBaJOhFR1TxBZnSjVnaKCpsZBuO0ZhXlizKII3uH7V4NUM6QI8cGWHCGyeBIFlg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=9K9F/C7uW0XW93LfQUu879Sh8afLyilLpNuvbIFGA28=;
 b=ctcaUZxsPTD332ZExsgOcWlK+61/T3E/RT4CdTfQ4wazjAy5dYJ30Xsjz+oVdqjxd69jHZRFLM3YshTDFJr0kb3IySrUgLE1DtpqEUK6aaR8oBwt/O7nlRJcr2YK4OhhLFXE9y+6eAXHHeRvkT/OeV5FEDaU+tkJ2QLLg8vVe2zvcEpIjYQaR/N5/8g9C/S1hnWEvC5iA94l/5aYS3JeSQVovvq4gBu6mgKpg4INJ8S3Wgk5xvhkyr47WJAGhGHPienLuNoOjPaUML5o/+T901cY2n81neRX+cSmM0HV1o0PDrC64bEQME8keNEdfOF6UsLdw6ipnE9+M5KokYpZzQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Received: from IA3PR11MB9136.namprd11.prod.outlook.com (2603:10b6:208:574::12)
 by DS0PR11MB6349.namprd11.prod.outlook.com (2603:10b6:8:ce::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8989.13; Thu, 31 Jul
 2025 08:49:29 +0000
Received: from IA3PR11MB9136.namprd11.prod.outlook.com
 ([fe80::604b:77a4:b1be:3f13]) by IA3PR11MB9136.namprd11.prod.outlook.com
 ([fe80::604b:77a4:b1be:3f13%4]) with mapi id 15.20.8989.010; Thu, 31 Jul 2025
 08:49:29 +0000
From: "Duan, Zhenzhong" <zhenzhong.duan@intel.com>
To: =?utf-8?B?UGhpbGlwcGUgTWF0aGlldS1EYXVkw6k=?= <philmd@linaro.org>,
 "qemu-devel@nongnu.org" <qemu-devel@nongnu.org>
CC: "alex.williamson@redhat.com" <alex.williamson@redhat.com>,
 "clg@redhat.com" <clg@redhat.com>, "eric.auger@redhat.com"
 <eric.auger@redhat.com>, "Peng, Chao P" <chao.p.peng@intel.com>
Subject: RE: [PATCH] vfio: Introduce helper vfio_device_to_vfio_pci()
Thread-Topic: [PATCH] vfio: Introduce helper vfio_device_to_vfio_pci()
Thread-Index: AQHcAcuhNMNJB0xuP0yfjOwZpiFjP7RL5e6AgAAFFsA=
Date: Thu, 31 Jul 2025 08:49:29 +0000
Message-ID: <IA3PR11MB91364FF957288A4DBC5A3F709227A@IA3PR11MB9136.namprd11.prod.outlook.com>
References: <20250731033123.1093663-1-zhenzhong.duan@intel.com>
 <1e5263cc-23fb-44cf-a8c1-f01b6fbb6ef3@linaro.org>
In-Reply-To: <1e5263cc-23fb-44cf-a8c1-f01b6fbb6ef3@linaro.org>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: IA3PR11MB9136:EE_|DS0PR11MB6349:EE_
x-ms-office365-filtering-correlation-id: e47c35b5-276a-4baf-bef6-08ddd00f298d
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0; ARA:13230040|1800799024|366016|376014|38070700018;
x-microsoft-antispam-message-info: =?utf-8?B?OTJyM3lrc2RPUFp5NXVWZm1TYmVndHNMRlhEL2ZkaFM3VkhsS05nZW40VDRp?=
 =?utf-8?B?K09EUVBXUEVQaXVXbnc4eElSSWJSZXdNbkhrQ3JtOXk2V2Y3Qi9qdHVSUzRV?=
 =?utf-8?B?Yms4TGJiR3F2NVJTYjJEVndtaEM4aFJiYm52QTBCcmRhaEVTUnd4VG8yQ0hB?=
 =?utf-8?B?OHNnL0RyaGtrUXl3d1UvSU1Fc2dWTGVNK29JZ3VaSm1VeHh1MGxlWnhQcDZ1?=
 =?utf-8?B?WXU5STVBcy9kYmtsdTljUEo4VnN3UXNDc0F3U0NId2R4bmZ6QUdzVVZaTDA4?=
 =?utf-8?B?cXVzWmdnR01LRENWSTFQdGJkbE40eEdhWjRUVjAxc3Brd3FyeTIyWnBndkRx?=
 =?utf-8?B?TFJyUWdPSmJTcmRqTmYrSzVaSnAva1o3MlUzclQ5L25TU2MwSS85ZUhMNjQ3?=
 =?utf-8?B?Tk81YUJ4SUJSUG1YOFRSRzhjYUNVSWR1Z3pXUW1VU1EvbDRhZ2VhTW51dlJO?=
 =?utf-8?B?bmpSUDF0ZGZhSVJFbXY0S3Z6Zm9NcmM0eHByR0xEQVUxSThMQ1JIMGRFTUZz?=
 =?utf-8?B?NkxINTI4TzVsQmovdzJydytaM1FSNEkvSmxWT1plNnNwLytJeG5hcnRQQnVO?=
 =?utf-8?B?MlRENmRlTjQ0Rm5zZlBHU25HQmMzalV5YUFPVUxiRWJWZGRVWXlxL0JvbTA4?=
 =?utf-8?B?Qk5CSThjSTRTaEx6WEUrWlhPbmJ2d1VXTURyd2RnZVEvb3Y5bGM5WEdYQmZH?=
 =?utf-8?B?N3dsbGpOZ21zcXF2TGlVZW9seVhMMXp6b2oyeENUOFB5L1pEL3Z3NnRWTFRV?=
 =?utf-8?B?akkreWFDN09STXk4K2ZSdndkWXlBdjI0MCtnMzBZQys4eGZQUm5IWFpTa25D?=
 =?utf-8?B?b3RPWU5ZSkY3OFZlUm5WbFZwOWV1MGtCL3dTRFJXb0VnbzBoODZCRG5tKzB6?=
 =?utf-8?B?QVZZWUdmK1AyR0NmaFI3ZU01cmMxaDJacytaeThGZHJLbmVwRWQ1Zko1LzIw?=
 =?utf-8?B?WjlKaTNIbVpxQ3FNYlJZV0d0RVlLZE5EbVJ4MDlPZVQ5MXQyQzVadW1mVi95?=
 =?utf-8?B?WEhtRklJMFR2NjAwNnM0Y0xkdHR5VHNkVy8zbzdaOTREeStvVWJuQmFVN1VB?=
 =?utf-8?B?QXkzaFFSbHdrRVl2N1FCOUxzRGZ4TEd3VjJvdW1YWHE1TGtOSTA2dG11dXhi?=
 =?utf-8?B?SGFOV3g2ZXJkeHdiclRsSDRhVzVrMmtEaDdjMUFxTUI2ZTVpWm9ISlZTOGh5?=
 =?utf-8?B?cFRuVVZOZ1NLYWRURGFPT2N0Q2h4c0szQmY2UkhoWXF4SjdoWEQ5S1kxSE5Q?=
 =?utf-8?B?RlFaMEJUMHgzcm9KOFhDOE53Q0k1T3J1Z3hHME53blVhL0VsbHJkVkN3RnR3?=
 =?utf-8?B?VWp5Q0RvWW93ekZmS3orNDVFOFByMWttSUxVbUg2RGgxbi9CMFRaaWhPNWEy?=
 =?utf-8?B?SnhCb0I3N1djK05ZZG9HTUgwS0VYWXhMUXlodFQ1cnFUeVVwaW5EckhrTitO?=
 =?utf-8?B?R3Vzc2dEQTB5VFF4eEhCM1pDcUZYWlhLQ01XMUF1YnQ4VGpXSkhJcmdJc3dG?=
 =?utf-8?B?dUtMdVBCZ0VhWXIxZ1NuUmhlUVZyNjZUeGJkSDJDU3BFNk42L0hxZkE1NWZu?=
 =?utf-8?B?aFEvQVZ3REE4Nit4QWsrL0tBMTVDdmd3bnNhMUVGWGtNL3diZDZLZEYrNlds?=
 =?utf-8?B?UC9UVzRqQlZ3dlZMcDJaRVpZSFYzSFRqTi8vdzluR0ljcUo5MFNVeHpEZVZo?=
 =?utf-8?B?V09VUS9Vc24rWTZoejZsYjdkQ3I5RDkySmZsWFJLMnNzKzFpRW9SbjlkSG81?=
 =?utf-8?B?azBrRFFkL01rQnc2VlIyTDVTVnQ3YXczQ1B3NHh5ZWV2bzdDTTQzVWVrTGRk?=
 =?utf-8?B?dEcyT05GUXlWMk1FbVRQZVJZMGw1WDM2TVA0citkT0J2WXR1eTlLZHdyVkx5?=
 =?utf-8?B?bEdTZFNCcDZaY0VIOTc1Y1hTSlhFcC9LdlBiU3pwY3IvVUxBK3FYZU5jK1pJ?=
 =?utf-8?B?U0VjdUFSTlZXN0RNVzBXVWlqL1NIRkZqR1RsTFJkZ2d6K1U2QlNENmxSVUl0?=
 =?utf-8?Q?Y4+agIa1X6AjLhDFBOfVdquVwRkpug=3D?=
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:IA3PR11MB9136.namprd11.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(1800799024)(366016)(376014)(38070700018); DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?WThnbkl5UjhUNDFSQnI3aDNYZDltYzlYRHpzTzBqUkRQdmx5ZWhUam1GcnNy?=
 =?utf-8?B?VGdWT3VWSkNLTDJLVjZOMHFMNkUzT2NpVkUyeUQ4TmRsaGdCcUY0dEpqUmZz?=
 =?utf-8?B?UC9YN1dTUnpoR2VnMGQzemVwdi9hbWk4d3VTWG5CQnFUeTJPTHIrczJPRmd0?=
 =?utf-8?B?Ulorb2ZSdzFJMGJBUDF3MCtiNHd0UjZub1VQVzNaZ0lOTlhhUUFwRUw5QXAx?=
 =?utf-8?B?RjA0Ukp4Z2tTY0hIWFNZTlFnMlpuY3ZqbXJGMUFOM05KVHhrRC91UVMyKys1?=
 =?utf-8?B?WnBEWFlMVitocFlXUEFvZWJzMVhqUmJ3RlNUZFlTVGdUTnlqaXY2OWhOdUhR?=
 =?utf-8?B?S05OdXppd2FBM0k2SXlOT1gyT1laNlJsUG8vRW9jSmhkeFMyS081NjZkazZW?=
 =?utf-8?B?ODhmWVVDWUtZWmtBaVZ6NlAzK1NmQVp2WE4rOFlxUzB6eWhrR1lRcHZ1V0ZB?=
 =?utf-8?B?a2dkUiswV2ZXcjVwRkcxU045dTFMczk1RElJNkM1blR6Vk9ydStSUkhQNitH?=
 =?utf-8?B?dlk1T1NEbHpnVlN3M2poREY2UEFGVU1tZ0xFMlRIR0dlTW1neFNta0UzYnhz?=
 =?utf-8?B?eEZEZzFIcVQ0Z0YrQ3ptSUhhTlg5Nko1ZjZ1SWVRR251L1ZHREYrMGtodG05?=
 =?utf-8?B?TUVod2NrdVRNeW0zSFdFTnJuemFYall5WUZ1T2pWQURtTzBsOFRVMVhjLzlO?=
 =?utf-8?B?dHZacTBnSG9XWUVrZzk5bUZxWXF0aFdUR0xPSExQMjB2bVlKUGF1SDJvTEFm?=
 =?utf-8?B?VTVEMFM2cXByb1RJc1ZrMXFDTWNEMzIycjdtYkM5a3MzbEUyL1YzaVhPMDkw?=
 =?utf-8?B?RGc5ZEd6dExEZzdtMTRYekExeHZhYjRTeGRlZDFTWUlDbTRvRnlWTUh2Mmp5?=
 =?utf-8?B?c3UxY0ZsQk1XUDBrK3kwUWIrWlpXbFFqdldhcTlSM1pITHdSV0cra0p2eTh3?=
 =?utf-8?B?NXR6SmZlWmsvOTV5Zm81SGtvYWZIeU5hR2U3YlpvQ1lCZzlKVVRJVm9PY1FS?=
 =?utf-8?B?b3NCcWRjTVRCZVVYTVEwamJvNzhBbEZiVjNCQ3lNM1RCVlpBZk9JWktMRXlV?=
 =?utf-8?B?eEl5WWYvYUNvbVJ4Rm1rY0FaQlc4ZEFBd1h4QTFkaWVPT3RoOUtXdzdRYjZM?=
 =?utf-8?B?Z0JBeDFJUnB2VDR2cW53WitxRHBZTFV0b0xBeDR2eUxxOXdPMmIzRm1nNlJQ?=
 =?utf-8?B?Tk1VMmEwVk5oY3dCQ25YQUlYdW45MFNzZWpjYmpVVENrZ3NYLzNiMnp4amYy?=
 =?utf-8?B?cnd4bktocmhVUWhjblkzWUJQWi9QeXJSaktSRUZyZUdPSUdGR3RWRjNJLzdx?=
 =?utf-8?B?VTVSb09hT1ZHMVdVcDg5VXdKdTVxb3FnT3JwNnRRcGlrblViZTB3NkwxNjBa?=
 =?utf-8?B?NWY0UHdGK1puUHU3R05iVS85eUpkTG00cDc1bHZGS1ZqWmJ6MG9HMDIxaVd6?=
 =?utf-8?B?RmtwcXg3ZmlUZWJuV2FNV2JrbGRyWmZXZzNTWkx0eGw3THAvd05LeFk1RnB1?=
 =?utf-8?B?eFVvMnlkdldYSkN1OVhDRm1JU1ZOd2FUa2dnN1JFcVM3cWFUSWhIOFBSTVdM?=
 =?utf-8?B?RmdpOGJoRmpnaDJVT3R0NWVXS3pxRThRQlJPUzE0TU9kR0JDcU9JalJnT3RI?=
 =?utf-8?B?clRBcDZRbnU5ME10bnJXSDd0S2tDUFgwTzNOZkJqVmdPaDVkaW1wWU9hRllD?=
 =?utf-8?B?S29CZjZkakFsd2hnaGEzUSsrbXNQSkVWYWVBWk1ZdUVha0dKYk00K1JyY3c4?=
 =?utf-8?B?NnZORnRra2Q1dlIxVmNacnI4ZkJJUXZGNVBIMTQ0SHN6clJpMVRUK29lZWJE?=
 =?utf-8?B?cTAzakxnUTkrQWsvaWlxSFd2bXVFdmloWVV4TEgvTHJjVmd4VGQ1MjdobDJ3?=
 =?utf-8?B?YkJ3Si85WVlHclQ2SnZEWVlUb3hwbEFWNThnSlcrR3Y4N1RVaHhyYkNSMjhv?=
 =?utf-8?B?djQ0bTcvRnZCMGhXMUpuZXBXblpRK2xLU0FmOWNCamVLTkpPSjBIZlZ6ZUdy?=
 =?utf-8?B?WnRFMzdLS1o0RStoaWllTmNkZUZOUXJLNjVJa25rTUdnaENCWk5uaTF6dFpR?=
 =?utf-8?B?SE1tVXJYWmZjMGpJTGZiMGkzbDhYRDZTVDROV0ZJUnNQN2kxZjlTNWdtc3Bi?=
 =?utf-8?Q?JxgDJ3cVAnFEZVkYO2umTXx8E?=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: IA3PR11MB9136.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: e47c35b5-276a-4baf-bef6-08ddd00f298d
X-MS-Exchange-CrossTenant-originalarrivaltime: 31 Jul 2025 08:49:29.6459 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 4Hwwq4fRBg6+JP+liHAliiVasOQwOzo/LhlOWY6SU+hVbyqz+R5QKJNVBMvDIic8zGZppEFJsIw3UZIPpfyCgWi55qBFOpW+AGQPljy92JY=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS0PR11MB6349
X-OriginatorOrg: intel.com
Received-SPF: pass client-ip=192.198.163.11;
 envelope-from=zhenzhong.duan@intel.com; helo=mgamail.intel.com
X-Spam_score_int: -43
X-Spam_score: -4.4
X-Spam_bar: ----
X-Spam_report: (-4.4 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
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

DQoNCj4tLS0tLU9yaWdpbmFsIE1lc3NhZ2UtLS0tLQ0KPkZyb206IFBoaWxpcHBlIE1hdGhpZXUt
RGF1ZMOpIDxwaGlsbWRAbGluYXJvLm9yZz4NCj5TdWJqZWN0OiBSZTogW1BBVENIXSB2ZmlvOiBJ
bnRyb2R1Y2UgaGVscGVyIHZmaW9fZGV2aWNlX3RvX3ZmaW9fcGNpKCkNCj4NCj5IaSwNCj4NCj5P
biAzMS83LzI1IDA1OjMxLCBaaGVuemhvbmcgRHVhbiB3cm90ZToNCj4+IEludHJvZHVjZSBoZWxw
ZXIgdmZpb19kZXZpY2VfdG9fdmZpb19wY2koKSB0byB0cmFuc2Zvcm0gZnJvbSBWRklPRGV2aWNl
IHRvDQo+PiBWRklPUENJRGV2aWNlLCBhbHNvIHRvIGhpZGUgbG93IGxldmVsIFZGSU9fREVWSUNF
X1RZUEVfUENJIHR5cGUgY2hlY2suDQo+Pg0KPj4gU3VnZ2VzdGVkLWJ5OiBDw6lkcmljIExlIEdv
YXRlciA8Y2xnQHJlZGhhdC5jb20+DQo+PiBTaWduZWQtb2ZmLWJ5OiBaaGVuemhvbmcgRHVhbiA8
emhlbnpob25nLmR1YW5AaW50ZWwuY29tPg0KPj4gLS0tDQo+PiAgIGluY2x1ZGUvaHcvdmZpby92
ZmlvLWRldmljZS5oIHwgIDEgKw0KPj4gICBody92ZmlvL2NvbnRhaW5lci5jICAgICAgICAgICB8
ICA0ICsrLS0NCj4+ICAgaHcvdmZpby9kZXZpY2UuYyAgICAgICAgICAgICAgfCAxMCArKysrKysr
KystDQo+PiAgIGh3L3ZmaW8vaW9tbXVmZC5jICAgICAgICAgICAgIHwgIDQgKystLQ0KPj4gICBo
dy92ZmlvL2xpc3RlbmVyLmMgICAgICAgICAgICB8ICA0ICsrLS0NCj4+ICAgNSBmaWxlcyBjaGFu
Z2VkLCAxNiBpbnNlcnRpb25zKCspLCA3IGRlbGV0aW9ucygtKQ0KPj4NCj4+IGRpZmYgLS1naXQg
YS9pbmNsdWRlL2h3L3ZmaW8vdmZpby1kZXZpY2UuaCBiL2luY2x1ZGUvaHcvdmZpby92ZmlvLWRl
dmljZS5oDQo+PiBpbmRleCA2ZTRkNWNjZGFjLi4wMGRmNDBkOTk3IDEwMDY0NA0KPj4gLS0tIGEv
aW5jbHVkZS9ody92ZmlvL3ZmaW8tZGV2aWNlLmgNCj4+ICsrKyBiL2luY2x1ZGUvaHcvdmZpby92
ZmlvLWRldmljZS5oDQo+PiBAQCAtMTU3LDYgKzE1Nyw3IEBAIGJvb2wgdmZpb19kZXZpY2VfYXR0
YWNoX2J5X2lvbW11X3R5cGUoY29uc3QNCj5jaGFyICppb21tdV90eXBlLCBjaGFyICpuYW1lLA0K
Pj4gICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgIEVycm9yICoqZXJycCk7
DQo+PiAgIHZvaWQgdmZpb19kZXZpY2VfZGV0YWNoKFZGSU9EZXZpY2UgKnZiYXNlZGV2KTsNCj4+
ICAgVkZJT0RldmljZSAqdmZpb19nZXRfdmZpb19kZXZpY2UoT2JqZWN0ICpvYmopOw0KPj4gK3N0
cnVjdCBWRklPUENJRGV2aWNlICp2ZmlvX2RldmljZV90b192ZmlvX3BjaShWRklPRGV2aWNlICp2
YmFzZWRldik7DQo+DQo+UGxlYXNlIHJldHVybiB0aGUgdHlwZWRlZiAobGlrZSBpbiB0aGUgaW1w
bGVtZW50YXRpb24pLCBub3QgdGhlIHN0cnVjdC4NCg0KVGhhdCB3aWxsIGJyZWFrIGJ1aWxkLiBW
RklPUENJRGV2aWNlIGlzIGRlZmluZWQgaW4gaW50ZXJuYWwgaGVhZGVyIGh3L3ZmaW8vcGNpLmgs
DQp3aGlsZSBpbmNsdWRlL2h3L3ZmaW8vdmZpby1kZXZpY2UuaCBpcyBwdWJsaWMgaGVhZGVyLCBJ
J20gbm90IHN1cmUgaWYgaXQncyByaWdodCB3YXkgdG8gaW5jbHVkZSBpbnRlcm5hbCBoZWFkZXIg
aW4gcHVibGljIGhlYWRlci4NCg0KPg0KPkEgb25lIGxpbmUgY29tbWVudCBkZXNjcmliaW5nIHdo
YXQgdGhpcyBoZWxwZXIgZG9lcyB3b3VsZCBoZSBoZWxwZnVsLg0KDQpXaWxsIGRvLg0KDQpUaGFu
a3MNClpoZW56aG9uZw0KDQo+DQo+UmVnYXJkcywNCj4NCj5QaGlsLg0KPg0KPj4gZGlmZiAtLWdp
dCBhL2h3L3ZmaW8vZGV2aWNlLmMgYi9ody92ZmlvL2RldmljZS5jDQo+PiBpbmRleCA1MmExOTk2
ZGM0Li5hNGY5YzkyMTZjIDEwMDY0NA0KPj4gLS0tIGEvaHcvdmZpby9kZXZpY2UuYw0KPj4gKysr
IGIvaHcvdmZpby9kZXZpY2UuYw0KPg0KPg0KPj4gQEAgLTQyOSw2ICs0MjksMTQgQEAgVkZJT0Rl
dmljZSAqdmZpb19nZXRfdmZpb19kZXZpY2UoT2JqZWN0ICpvYmopDQo+PiAgICAgICB9DQo+PiAg
IH0NCj4+DQo+PiArVkZJT1BDSURldmljZSAqdmZpb19kZXZpY2VfdG9fdmZpb19wY2koVkZJT0Rl
dmljZSAqdmJhc2VkZXYpDQo+PiArew0KPj4gKyAgICBpZiAodmJhc2VkZXYgJiYgdmJhc2VkZXYt
PnR5cGUgPT0gVkZJT19ERVZJQ0VfVFlQRV9QQ0kpIHsNCj4+ICsgICAgICAgIHJldHVybiBjb250
YWluZXJfb2YodmJhc2VkZXYsIFZGSU9QQ0lEZXZpY2UsIHZiYXNlZGV2KTsNCj4+ICsgICAgfQ0K
Pj4gKyAgICByZXR1cm4gTlVMTDsNCj4+ICt9DQoNCg==

