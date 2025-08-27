Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E692BCA0FF6
	for <qemu-devel@archiver.kernel.org>; Wed, 27 Aug 2025 11:51:24 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1urEfh-0003W7-4k; Wed, 27 Aug 2025 07:50:33 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <yi.l.liu@intel.com>)
 id 1urEff-0003Vm-MJ
 for qemu-devel@nongnu.org; Wed, 27 Aug 2025 07:50:31 -0400
Received: from mgamail.intel.com ([198.175.65.12])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <yi.l.liu@intel.com>)
 id 1urEfV-0006E3-5X
 for qemu-devel@nongnu.org; Wed, 27 Aug 2025 07:50:30 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1756295421; x=1787831421;
 h=message-id:date:subject:to:cc:references:from:
 in-reply-to:content-transfer-encoding:mime-version;
 bh=scPMiV8ni4SkQad10OV+uqts0qo1Vc9uPDPwPOAbl9o=;
 b=XfHM6dHx+0IZoPslDoJj8dVQXcnQddntT836ivDMiUZLoepEq0yy7CH8
 7u0AhHHhHEyGFru96JXyq689wq5Sr247DNTqHsFp491ZhcDUgkSTrIyxL
 8qt+kUPG9vU8nN8m9uNtcPyOaSAG/dsSFoWAXASBbJTRCpDknhfRt0ay9
 9TX5dh0kwUhEd2DE7fL8FvBA6JMh0jtBTjLc762IFe/0QPGnc7NV0SPmT
 m5TtTAyDytwfZV3kquf2Bq1CmqmpqmAeN+qKltZc51doh04Skmu4XLYK0
 X9rRA6ceE3XCyR2o4t5X7sgDD6nzyFNkvU8DL2Lj5/Z1EdP8bC8PBTLUP Q==;
X-CSE-ConnectionGUID: lvsUCESkTqiJlzLcgw7mhQ==
X-CSE-MsgGUID: WJZAjgMrR3yf3dsfyqPEiA==
X-IronPort-AV: E=McAfee;i="6800,10657,11534"; a="69983949"
X-IronPort-AV: E=Sophos;i="6.18,214,1751266800"; d="scan'208";a="69983949"
Received: from orviesa007.jf.intel.com ([10.64.159.147])
 by orvoesa104.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 27 Aug 2025 04:50:11 -0700
X-CSE-ConnectionGUID: vKezN2xLRJelhGeg0mONKQ==
X-CSE-MsgGUID: DSMUxuqNQryLQWmvKZKUDA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.18,214,1751266800"; d="scan'208";a="169725469"
Received: from fmsmsx901.amr.corp.intel.com ([10.18.126.90])
 by orviesa007.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 27 Aug 2025 04:50:10 -0700
Received: from FMSMSX902.amr.corp.intel.com (10.18.126.91) by
 fmsmsx901.amr.corp.intel.com (10.18.126.90) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.17; Wed, 27 Aug 2025 04:50:09 -0700
Received: from fmsedg903.ED.cps.intel.com (10.1.192.145) by
 FMSMSX902.amr.corp.intel.com (10.18.126.91) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.17 via Frontend Transport; Wed, 27 Aug 2025 04:50:09 -0700
Received: from NAM11-CO1-obe.outbound.protection.outlook.com (40.107.220.87)
 by edgegateway.intel.com (192.55.55.83) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.17; Wed, 27 Aug 2025 04:50:09 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=UfOwVe67wxhjgQ2/RfWN7SKs9Y4p7rEKvQsoAk5CeniDyfKzPLUM0SCn6CdmVAmwdifhEvzYdWBpkZP/nyQIiYvdfEdZ3yVUtQXHflY47Ec3ilfHUPwRR3qCypKfTWpaMBbzyht8EZP/VAq3PchZiJDInBrMPnCyrOLHfGr9Xxt4on/32Rus3nSxtfru/0b2T60w9Z+x/veg3ddTTcY94L5llt/VNfGhGR+P9rfRH1bhmcVd0BMN/0FI+W3qIFnXJHHRG41D6IsspB9qgVfA01e+Y0GEHwpXJy3+gOodI+qN1aDi1m82XUR/tO6IdC8WNpt7P1XtP8H9Dj/2kQ41Mw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=XVSYxh0bUStAkbvRXTOLvwUDnVoqbuAu/UqD6GKSZwQ=;
 b=SH67KerZYxOsW9RU+CX/s5oLIgoItF0ZAH52BBQ3AYA+kOBUZ8f4vZ+sKRyyvVDz3M3SU76aHvZ3GK7AU/YpMD7w7B/IRGvAS9JEIicC5be6Nu7GSOykR3OB1WZsyq0VpEg/DBnWT5VlTT37JviBLudEjt6oXwbyEswNAmlCbNw4w7phnoIEM1HBzBtoY50e8XzsZrKNS49vMyPVizkmvf2AV6pfg4mDBaI3U+lNc+2zGBt6bYDeojFHTocfBZILDPdPqFCdfyDcpMHqX86ur/XJ5IWZMAKLtQppm8ZkHg2ydYKdVN0wI6rXdt5YyUqwHWrKK2G8iLQf1mrKxCnf7Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from BY5PR11MB3974.namprd11.prod.outlook.com (2603:10b6:a03:183::29)
 by SJ0PR11MB6693.namprd11.prod.outlook.com (2603:10b6:a03:44b::21)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9031.23; Wed, 27 Aug
 2025 11:50:07 +0000
Received: from BY5PR11MB3974.namprd11.prod.outlook.com
 ([fe80::fe0b:26f7:75b4:396]) by BY5PR11MB3974.namprd11.prod.outlook.com
 ([fe80::fe0b:26f7:75b4:396%5]) with mapi id 15.20.9073.010; Wed, 27 Aug 2025
 11:50:07 +0000
Message-ID: <fba0b1ce-13de-4c80-9f44-4adc07cc6934@intel.com>
Date: Wed, 27 Aug 2025 19:56:38 +0800
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v5 20/21] Workaround for ERRATA_772415_SPR17
To: Nicolin Chen <nicolinc@nvidia.com>, Zhenzhong Duan
 <zhenzhong.duan@intel.com>
CC: <qemu-devel@nongnu.org>, <alex.williamson@redhat.com>, <clg@redhat.com>,
 <eric.auger@redhat.com>, <mst@redhat.com>, <jasowang@redhat.com>,
 <peterx@redhat.com>, <ddutile@redhat.com>, <jgg@nvidia.com>,
 <joao.m.martins@oracle.com>, <clement.mathieu--drif@eviden.com>,
 <kevin.tian@intel.com>, <chao.p.peng@intel.com>
References: <20250822064101.123526-1-zhenzhong.duan@intel.com>
 <20250822064101.123526-21-zhenzhong.duan@intel.com>
 <aKkDXiSwWGgio0dM@Asurada-Nvidia>
Content-Language: en-US
From: Yi Liu <yi.l.liu@intel.com>
In-Reply-To: <aKkDXiSwWGgio0dM@Asurada-Nvidia>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: SI2PR01CA0041.apcprd01.prod.exchangelabs.com
 (2603:1096:4:193::15) To BY5PR11MB3974.namprd11.prod.outlook.com
 (2603:10b6:a03:183::29)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BY5PR11MB3974:EE_|SJ0PR11MB6693:EE_
X-MS-Office365-Filtering-Correlation-Id: 589e527d-de10-43be-9bfd-08dde55fde14
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|1800799024|376014|42112799006|366016|7416014; 
X-Microsoft-Antispam-Message-Info: =?utf-8?B?dGUrL3FhWGlzc0JtT3M0OHg0anFWdStpZ2tUd1A2UHdBLy9UTDVZRk1jaEQx?=
 =?utf-8?B?bGxFa2w4NllpVSthaVFPYUFyb3VHaTdNR0lMbTg4d0V1WFNlcXZEWFd1cGN3?=
 =?utf-8?B?Q2RaTWVvbm1KS3JGM2Z1a0Y5WnZET0Q3eWRkRGFFd3hVcHErWFV5WHE3dmV4?=
 =?utf-8?B?TzM0dVVpYkRCY1Y2ZW5vZ2FvS1BPS3ZrbEx2K2U1YVM4WVorRHk5OXlkdDVM?=
 =?utf-8?B?QnYxRitHdVYzVDJXZ0s2RTlKYVdFVnNsWEJROU1KNXh4VXNERlFjaWhiTGZx?=
 =?utf-8?B?ZHZXemZ4V0tiSE8xM0l3U3BTRVVrTmlkYWVsT0pGd1dRdUIyVUYxMThDQTdm?=
 =?utf-8?B?VXVleXhIaDEyZzYzT2wxaW1heVRLakk5RFI0cmRJZ1NxeGk3M0RwNjBlRzFP?=
 =?utf-8?B?aXliK1FlaXNyK1lSeUwzaGpQMEt5TFExaERodzR5b1p6RDBOVHF6RlRDV1hl?=
 =?utf-8?B?YjI4ZkxXM1M0b0xLN2RTZlJIWVQyTXo2L25Zbm1COFN5UVVCUXluOHdncnNN?=
 =?utf-8?B?Qm1BaXRNa1crVjBGdW5oVDRmaVA3WGYyMEJ0eDRlMVVDOEJnbi9CTHBKNlV4?=
 =?utf-8?B?eUg4VkdXUXJ3cm4yTHNmbmlKa3VpTXZtSy9PbVVZdW11SWRHbTJReHRsNU1y?=
 =?utf-8?B?LzBkazdqSkNPSzRYNmMxaVJLbFRUSnpLY3QySHFWRDZOQ3NOMmtjeUpkNTBv?=
 =?utf-8?B?bzZkNzlJcGtGS08vVDhEbTA4a0c3cFo5OUN6QWdBdXZ0KzVrWGt3ek8vNnFu?=
 =?utf-8?B?U0xXdVZWbGtQOVZZV3RhQVFTVzFBTmFmT2creEd6TjJXVm03ckhrUGFlbDA4?=
 =?utf-8?B?WHFNc25qejJlMWFjL3NqMjZsZ3ZCSk43ZGRVdkowelFpeU1rWitkZXpSaFRj?=
 =?utf-8?B?TW8ybCszbnloMXNBOWpnbVM4TUpTc2FqVE9YNUJnbG9pZXVwWlpnQ2o4YzJs?=
 =?utf-8?B?WS9Od3VHOTFnSEFZd0JxLzVPeUZIVnU1aDdoeGhnYjR3Y2s0bmcxTEpMWTBZ?=
 =?utf-8?B?dHRsNE12eGF1OUxnVlJrNHZmRTRvYU0zN3hlOUVzMU1IQXpQd3pqUWdmYSs4?=
 =?utf-8?B?NTRRTE10T3hsUHd6aWZvajdrNjVBZTVyVlFDeHpjNzYyLytBRERTUVV2VWxz?=
 =?utf-8?B?WTQ3ZDlLejBYRkprTWZnTG1odWNJQnkxT2pyUHRBVUpaTDgrditzcjlaWkhq?=
 =?utf-8?B?ZnNmcUlWY0tyTVN1YkJES3E2TzU2WVJuT3gwc1R0SGI1d3F1NUZqdXplZlRj?=
 =?utf-8?B?N2E2bEtwZTBOMk5OUXFPbElIYkh5eFNUeUMzdVlhZW41ZG8vcTZzMXhEZ3E3?=
 =?utf-8?B?dk4raDZ3YVVpdERmbWxXS2dRQ3BhRUp0YlV4ck9pWnFPa1phSkdTdlJTMGhy?=
 =?utf-8?B?M1BDZkx5YSt4aVpnazNwRFZrQzRXdThoMG56Y0ZXdVZMSXRTNmVDckVpZloy?=
 =?utf-8?B?M3ZRU0k2RERrcVRqV3UybjdlaUJoN2FISDJWTHNmcEt1OGxwRlcxdE1pSDlw?=
 =?utf-8?B?dnVIZXZMSnplajNaMUhNamF6dTVrK0pSSURjMldGa2NkWFdtOHQwYjNWdG5x?=
 =?utf-8?B?R1p6dW1DeVM5YzI3RSs5ZnVuWFQ2dG5ZTjRlTWJWWEVpajFSK0hpYW5kQVVu?=
 =?utf-8?B?aC9LZHBDZU5NckZnQUpyZWQzZk1iVnk2S2dPK1NobWdKbjM5V2hFTDUwM3VL?=
 =?utf-8?B?aFJyUTRvTi90TzR1dFlCTEphbTVtYWxrU0plMEI4QzBmT1VjTXdmNFM4aWdt?=
 =?utf-8?B?YXpzMWwwU3RKVTZXVlc3V1ZTTE1zcFljMXZpdVk1cHhiZ2oxTVF2VzJrUlB0?=
 =?utf-8?B?aFlkVzNaNW9id0g2MVNweGxScm5wWEtKdDA3ZjBra0Z0QVUyNWxSNko3NFVl?=
 =?utf-8?B?YnBmR3ptSWRpT0NFQTIwVkZOM253R0dwK01HaWVwN2dCUnZKUFk0V1c4N3g3?=
 =?utf-8?Q?akN4Pn9XSEU=3D?=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:BY5PR11MB3974.namprd11.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(1800799024)(376014)(42112799006)(366016)(7416014); DIR:OUT;
 SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?N282RUF5UVFrdmlyWnNrR0UzUmtyTTlKck1hTkVvclN1L1ppb29YL09oWkR4?=
 =?utf-8?B?WG9MTDk1ZThTZW5kb1QzS2l5S0MyMEhTZGZhdGtSblNtMHg5RnZMR1lRUlRB?=
 =?utf-8?B?ck0yNXpXcDA4OElpN1dZRllOaXpGZ3BnVklxaXZzQ1F6blFkcUNYclJRYXVa?=
 =?utf-8?B?QksvelNJdVhtdGZzaE5jejJZZHFndHVzdEQ1MUpwYWxSUk0xRXVYMkhwYXJY?=
 =?utf-8?B?M1hvZWw4RGVIVFY5ZnczMElzN1NUaVdSemY4T1ErdkhRV3FsNWlZSUcxZnZ5?=
 =?utf-8?B?Z0s3WmFGSGFId2ROaXdSTUR0T0k5aWhCY2ErN0NFZHZTb043bit1UGdSL1Nk?=
 =?utf-8?B?RmptOXZqM2dUSE4yWTYwbEV2Q0FlamxPK08zY0grSm1jcEZTa2VpWDJzVDFv?=
 =?utf-8?B?SlkzN3ZKb3k5aFpLemxiMVBzM1JoMWZzVUVwU1kwWmdtT2Q0anFZaURvN25E?=
 =?utf-8?B?ODZ2SUVGVW11REJFM0M4NHBZcGk1LzFvV1A5K09sRGJHRU4vTmlkSVBUQ2d1?=
 =?utf-8?B?b293ZUNvUWtHZlV4MlhoSUdIekQ1SmlVRnpVWVh3RSs4UDZMUmRGS2ZMbnlQ?=
 =?utf-8?B?Vk9nbW9RQjdJYlJZMEFwQkU1eDVIdEF1REVwalNmTDNVZjk2U2xBUDNuSFo5?=
 =?utf-8?B?NW9aLzUzQXl1bWVYazRVNzJYOGdwRzdJR2hIS1ppTEM3Q2NoelJUNFVSYThv?=
 =?utf-8?B?a0JJby96Ny9wTzZXaU04UFY4aCt2YXdUcFp6QllvSXVwY3hCOUdYOFUrUWVX?=
 =?utf-8?B?SnNlTzVOeDRtajlNcDFNWnJnR0ZjeExjSWYvZDBEZlMwR2paNlNzZTQxOGtW?=
 =?utf-8?B?NzhYZ1ZUMmpjR3RDYnNmaS9SRnV6SlhWQ1NCWnpBbTBGM09LRi96SmcycEo5?=
 =?utf-8?B?bnVjNDZZSzNUTmk0U3hKQ25aYWpiNnhsVWtIZ2h0YWhvS05ycFhEcFdMbXI3?=
 =?utf-8?B?YnVIRlIxbG9Ha0VtQ2VXZjFqQ3JVWW01TGNkZ1g4Y3ZwdTdxZW1YdDZwckRY?=
 =?utf-8?B?bGdkSHR5YUdFQk9FSzVjZStyRkFVdTI3S2VCMFA2UHFiWUlEenhJUVc1aWNJ?=
 =?utf-8?B?bjVDd0dZek8xTld4cWtkSUE3QitkNnloaTlaaVBxM2dSSUw4VHpvUVdMVkZx?=
 =?utf-8?B?M01vbnhyU0d1dGZYY1VkaWhOZkQ5LytEWm53eHlyZjlDaktxN0ZQTGpRK1lM?=
 =?utf-8?B?bUllQ2hjOFVIcCs1U2VmSEh3UWRINWY3eXlmbmJmQVRuL3lEMCtxcVFKSXlh?=
 =?utf-8?B?YksxeStTRkg2REVsb0tzVkZNNmwvVU05YzdEZ3dyWXBSWFF0RGJSa1RyTUN5?=
 =?utf-8?B?cnJrZ0RpUzdhVHlGNndQczY3a1dMZnJBSEtoZnhLd1M0cnV6RnFxSDJZZ0Ru?=
 =?utf-8?B?bzJlekEzQ3JyZWVWRm5ZRFI3dXNBMURwamFZbW9EUEltVm50b0xjUllWdzhF?=
 =?utf-8?B?eHhINlNmYzAyTFppNUVEZm0wclFJdUFEZy9kMHRBVUJlVGV5WmJnZnZ6MHo1?=
 =?utf-8?B?a1ZKcTV3SmRXVFdoQmNudW1LOUlYakpndTZveU1pZVYrRkRjNjdMb08rR0Jl?=
 =?utf-8?B?eFRrWlFKZGFpVGtpNlIyTVdtbW9PZHVjNytYakgvQ1EyUjAyRXZxK1A2czNy?=
 =?utf-8?B?U0toOVVNc09WcGZqTGJ6Z1NZVjk0YnJZNFBtZ1VmL3NKUG5XYWdYaTBuZW1U?=
 =?utf-8?B?NDZBejNPbmFxcVBNalZ2VWNRVFc5Rk9FbEZZbG0wYVVsSkJ5K1BzRG15KytO?=
 =?utf-8?B?dmhTaXRkSnRyblJyZ2RzaHBzMjJLclZhTzl1amRuVE5yTnY2VGZQdWJ3VGov?=
 =?utf-8?B?TWlWSXBtRWtXenZndUd2SGlKTlNNdWtkc1I0d05xanFEb0VEWFZaWjRLUXRu?=
 =?utf-8?B?SXkyTXVOTC9DSXFPeW41VUlxajZlTEdlcTM5QnovRGkzU0lHQlVpeEhNRnZk?=
 =?utf-8?B?d3dRbVdkQmpreHpGSGp1Mm5zRWV2UVptcTlleDRLc2tDTStWbi9yY1MxUkdI?=
 =?utf-8?B?OTZQcWRTK0huaUcrTUhMYXM5QmxPR3I5bjk4KzFyNU5GeS9Tbml6OG0rTkRj?=
 =?utf-8?B?Z1g0YTZMeXJQQ1h4U25wVlBvWXZFMDc3b3Y4SW1rbys5NFpsaUJkWVRtbHc3?=
 =?utf-8?Q?Ve8pvsHPQCsENWZZIa3Sxvu/f?=
X-MS-Exchange-CrossTenant-Network-Message-Id: 589e527d-de10-43be-9bfd-08dde55fde14
X-MS-Exchange-CrossTenant-AuthSource: BY5PR11MB3974.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 27 Aug 2025 11:50:07.0038 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: mgZQzTsY3Bd8mYyH2hVLUXSrcNkcinUTFa7PnJjeZ3JjXfUP5aH4pPIBtAVaYA3HfuEGPEvpIRCcYXtcB8hTTA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ0PR11MB6693
X-OriginatorOrg: intel.com
Received-SPF: pass client-ip=198.175.65.12; envelope-from=yi.l.liu@intel.com;
 helo=mgamail.intel.com
X-Spam_score_int: -43
X-Spam_score: -4.4
X-Spam_bar: ----
X-Spam_report: (-4.4 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_MED=-2.3, RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001,
 SPF_HELO_NONE=0.001, T_SPF_TEMPERROR=0.01 autolearn=ham autolearn_force=no
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



On 2025/8/23 07:55, Nicolin Chen wrote:
> On Fri, Aug 22, 2025 at 02:40:58AM -0400, Zhenzhong Duan wrote:
>> diff --git a/hw/vfio/iommufd.c b/hw/vfio/iommufd.c
>> index e503c232e1..59735e878c 100644
>> --- a/hw/vfio/iommufd.c
>> +++ b/hw/vfio/iommufd.c
>> @@ -324,6 +324,7 @@ static bool iommufd_cdev_autodomains_get(VFIODevice *vbasedev,
>>   {
>>       ERRP_GUARD();
>>       IOMMUFDBackend *iommufd = vbasedev->iommufd;
>> +    struct iommu_hw_info_vtd vtd;
> 
> VendorCaps vendor_caps;
> 
>>       uint32_t type, flags = 0;
>>       uint64_t hw_caps;
>>       VFIOIOASHwpt *hwpt;
>> @@ -371,10 +372,15 @@ static bool iommufd_cdev_autodomains_get(VFIODevice *vbasedev,
>>        * instead.
>>        */
>>       if (!iommufd_backend_get_device_info(vbasedev->iommufd, vbasedev->devid,
>> -                                         &type, NULL, 0, &hw_caps, errp)) {
>> +                                         &type, &vtd, sizeof(vtd), &hw_caps,
> 
> s/vtd/vendor_caps/g
> 
>> +                                         errp)) {
>>           return false;
>>       }
>>   
>> +    if (vtd.flags & IOMMU_HW_INFO_VTD_ERRATA_772415_SPR17) {
>> +        container->bcontainer.bypass_ro = true;
> 
> This circled back to checking a vendor specific flag in the core..
> 
> Perhaps we could upgrade the get_viommu_cap op and its API:
> 
> enum viommu_flags {
>      VIOMMU_FLAG_HW_NESTED = BIT_ULL(0),
>      VIOMMU_FLAG_BYPASS_RO = BIT_ULL(1),

hmmm. I'm not quite on this idea as the two flags have different sources.
One determined by vIOMMU config, one by the hardware limit. Reporting
them in one API is strange.  I think the bypass RO can be determined in
VFIO just like the patch has done. But it should check if vIOMMU has 
requested nested hwpt and also the reported hw_info::type is
IOMMU_HW_INFO_TYPE_INTEL_VTD.

	if ((flags & IOMMU_HWPT_ALLOC_NEST_PARENT) &&
             type == IOMMU_HW_INFO_TYPE_INTEL_VTD &&
             vtd.flags & IOMMU_HW_INFO_VTD_ERRATA_772415_SPR17) {
             container->bcontainer.bypass_ro = true;
          }

Regards,
Yi Liu

