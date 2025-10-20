Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1DAE9CCD199
	for <qemu-devel@archiver.kernel.org>; Mon, 20 Oct 2025 10:02:06 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vAmhg-0004w2-B4; Mon, 20 Oct 2025 06:01:24 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <zhenzhong.duan@intel.com>)
 id 1vAmha-0004rx-Ui
 for qemu-devel@nongnu.org; Mon, 20 Oct 2025 06:01:20 -0400
Received: from mgamail.intel.com ([192.198.163.19])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <zhenzhong.duan@intel.com>)
 id 1vAmhX-0003jp-I3
 for qemu-devel@nongnu.org; Mon, 20 Oct 2025 06:01:18 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1760954476; x=1792490476;
 h=from:to:cc:subject:date:message-id:references:
 in-reply-to:content-transfer-encoding:mime-version;
 bh=wVjENVvMmF43LMaThUpCxN+C9TY+0Iz/DAFyjvhgeKs=;
 b=UWTdxt/yYQaQgV9XviOcWny7ZIeNG1INwU8KD1EueEQKO8aly03Gc5sf
 GUGdwVy576hfYmBmEtxHPZse5FVj7A5cksVTGce1eqbksqBNPA9vYp3pE
 MZ/w0YBp+5UV7uOhLnj5V+Noqw/DyY56M82YKcIx3jtatVUyCdAQYPhQZ
 yEZktDYkmZFClRJf/Dh9eZJ+ZqPal/BgyhIJ3m6YwS0lL83KqikGg4vIa
 6h9GmtEvf58DvwVAduu0/Ct0sH4TLzb5ViqTM25eaUKhoXT7KuTfiTqF9
 HzEg2xA2j0MZFKQOhWodWuVk6lyqVTAfmzSuHO9LabdM3fXRwCZYyJRDe g==;
X-CSE-ConnectionGUID: f7fUvQ7URPCUh4Pf7FWbKA==
X-CSE-MsgGUID: QDDfN6kOSQmz8h4OsLFrWw==
X-IronPort-AV: E=McAfee;i="6800,10657,11587"; a="62100869"
X-IronPort-AV: E=Sophos;i="6.19,242,1754982000"; d="scan'208";a="62100869"
Received: from orviesa010.jf.intel.com ([10.64.159.150])
 by fmvoesa113.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 20 Oct 2025 03:01:11 -0700
X-CSE-ConnectionGUID: KV72wlWpTGWZ/cXQpYJXhQ==
X-CSE-MsgGUID: NBWTdNmdTZKs9PypexoRYQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.19,242,1754982000"; d="scan'208";a="182481395"
Received: from fmsmsx901.amr.corp.intel.com ([10.18.126.90])
 by orviesa010.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 20 Oct 2025 03:01:10 -0700
Received: from FMSMSX902.amr.corp.intel.com (10.18.126.91) by
 fmsmsx901.amr.corp.intel.com (10.18.126.90) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.27; Mon, 20 Oct 2025 03:01:09 -0700
Received: from fmsedg902.ED.cps.intel.com (10.1.192.144) by
 FMSMSX902.amr.corp.intel.com (10.18.126.91) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.27 via Frontend Transport; Mon, 20 Oct 2025 03:01:09 -0700
Received: from SA9PR02CU001.outbound.protection.outlook.com (40.93.196.7) by
 edgegateway.intel.com (192.55.55.82) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.27; Mon, 20 Oct 2025 03:01:05 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=uRMu5WWk2xM4buMS//Ih6ZjaIXzRHpSbvt7NfqPri7BGWu5SzYoLP8sCkm2rpctwMDo5vncf4E8HVgKJlEli0pPZnOYp7tIaD2A1Hn2HKv5y9Ktfszr/D102cYSpJYWhdNr1m3+BOdE8XDOvasm3JJQ5IAeNN04nOWCwvyJzR2wr+J3iAQ+TgXHhvEWr8EZYVwvJGr5ji0JaMWFf1+KNTw4Xi+yBjHY3Tzt/An10P0zmz8qHyNvo2ScQL8wQKNS0a6WlhHS8Vi/MqOk74ngSlTbVsjE1h3qukc1apa4SaWBRttXQ0kWnlhfdeZGgQ3WX0AtWsVownm4nGUO8tFa0jA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=wVjENVvMmF43LMaThUpCxN+C9TY+0Iz/DAFyjvhgeKs=;
 b=C0KKXZ95Qj8meBS4X+mpXKjIPTpgC5Esrl/T/HM1L9qnerQ0yV4d0VkP+yXNESFV1cSTDP+FPjpT5Gzw6ZH+fvf4OfH5GsIHcb1Vpi2quQKS5j9tUbcjA/XgddemjAgQJIxoRSGQfCoBl7xNouDgM3ySFRe0TgH1uPPKJj7l7wM2MHws2AnbcVyDbBNwCJiMv/CYKrKz9EuqhSRARzYVnF8E7i4/OU0vkCVGhBhOzp0tx7WzqCtHN59HKNt200XFDBZefY8+1/YoNHsIl99p4YBkiuTHkUPYYGqWDbRVOnRHM1Ghhap8ZYyKFrotukTz6h8G31mpq/u0RufcI8Z/tQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Received: from IA3PR11MB9136.namprd11.prod.outlook.com (2603:10b6:208:574::12)
 by SJ0PR11MB7156.namprd11.prod.outlook.com (2603:10b6:a03:48d::7)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9228.16; Mon, 20 Oct
 2025 10:00:57 +0000
Received: from IA3PR11MB9136.namprd11.prod.outlook.com
 ([fe80::604b:77a4:b1be:3f13]) by IA3PR11MB9136.namprd11.prod.outlook.com
 ([fe80::604b:77a4:b1be:3f13%7]) with mapi id 15.20.9228.015; Mon, 20 Oct 2025
 10:00:57 +0000
From: "Duan, Zhenzhong" <zhenzhong.duan@intel.com>
To: Avihai Horon <avihaih@nvidia.com>, "qemu-devel@nongnu.org"
 <qemu-devel@nongnu.org>
CC: "alex.williamson@redhat.com" <alex.williamson@redhat.com>,
 "clg@redhat.com" <clg@redhat.com>, "mst@redhat.com" <mst@redhat.com>,
 "jasowang@redhat.com" <jasowang@redhat.com>, "Liu, Yi L"
 <yi.l.liu@intel.com>, "clement.mathieu--drif@eviden.com"
 <clement.mathieu--drif@eviden.com>, "eric.auger@redhat.com"
 <eric.auger@redhat.com>, "joao.m.martins@oracle.com"
 <joao.m.martins@oracle.com>, "Hao, Xudong" <xudong.hao@intel.com>, "Cabiddu,
 Giovanni" <giovanni.cabiddu@intel.com>, "Gross, Mark" <mark.gross@intel.com>, 
 "Van De Ven, Arjan" <arjan.van.de.ven@intel.com>
Subject: RE: [PATCH v2 2/8] vfio/iommufd: Query dirty bitmap before DMA unmap
Thread-Topic: [PATCH v2 2/8] vfio/iommufd: Query dirty bitmap before DMA unmap
Thread-Index: AQHcPz9AHxjDhXJoaU+pD8P7evxfy7TKtKsAgAAb3aA=
Date: Mon, 20 Oct 2025 10:00:57 +0000
Message-ID: <IA3PR11MB9136BCC9994E40C674FE495792F5A@IA3PR11MB9136.namprd11.prod.outlook.com>
References: <20251017082234.517827-1-zhenzhong.duan@intel.com>
 <20251017082234.517827-3-zhenzhong.duan@intel.com>
 <e620aadd-c70b-43d3-9832-0cc1fc9d7c3c@nvidia.com>
In-Reply-To: <e620aadd-c70b-43d3-9832-0cc1fc9d7c3c@nvidia.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: IA3PR11MB9136:EE_|SJ0PR11MB7156:EE_
x-ms-office365-filtering-correlation-id: 70186015-b795-4919-4926-08de0fbf90bc
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0; ARA:13230040|1800799024|376014|366016|38070700021;
x-microsoft-antispam-message-info: =?utf-8?B?aWo5WWljVnpmd2JIaDNBNGYyT3UrMTA5bnZzcWk1ZkxuRTlrYTBwME1mY0Nq?=
 =?utf-8?B?OVF2ZGFYblljaDR3YUhXVHU5ODNyZmNRRjNUcUNwcUNEOVc3VHVBeG9pS1ov?=
 =?utf-8?B?ZHlySmlQZ3FpMnltVWpuVFJ1QVJ6Vzk4a2pBclVTcVBuYmRPN09Ub051SzY1?=
 =?utf-8?B?eEpNMkliSENvdzB1TGpZeTJsVmh0L01BcVFKVTNidVRTWmhuakRBSmVaa1Fa?=
 =?utf-8?B?YktQdnFVMU1YUVZ4RmJjU0xHWjZraVFGSnEwR2VrendCSXBFYTdRdEdSNE5H?=
 =?utf-8?B?QTRCZURwUGM4dVJHVk4rZjFFWlBWSVJwbExKN0FITFBEL29qN015Q21yR1BH?=
 =?utf-8?B?T3JTaG41cGRQWi9MRWhGNXFNNVJVWTZ2YmxFRVU1eisrNmd1ck1pT2RsUjdT?=
 =?utf-8?B?SWhrMyt2OGhPeU8yOVlTQW9Cb0E0Zkh0MTMxb3U3Y2NUVzc0bTlzRmlucTg5?=
 =?utf-8?B?SkFBZENoSy9jTlBTb0FvMjB0bVoxdklWOHMyUktyU3JYUW93VnlESVVEZVBW?=
 =?utf-8?B?dlNMWkF3em9LNi9CZnlPWE9KL0liaEtUdjdyN0pHYlIzVTZra29LNGQ4N1Qz?=
 =?utf-8?B?YkdPNUpveW5yZldDWE43ZDlvOTRFOFNuVUxEc0M5S2FKZmRkVU5lZ1RtOHB0?=
 =?utf-8?B?NWhlSU5kVktJbXlNZkdBWWNFdW1JQ2FRUGZLcFlCY1ArekEwSGpiSGh1NW4v?=
 =?utf-8?B?Um5YZEN5WHZ5VFAzcm9jYkxkT0JNMDlvQVFlNDlCcFhBbXRlZ1Z5d2lyOHBZ?=
 =?utf-8?B?bHVpTUFnTnNVUE1yZ3ZSczM4M0xnVmlwMk1TaGhaV0hIWExva1RMWkk0TEkz?=
 =?utf-8?B?TW5yZHp3c0dtSHQ0bHY1dlBNaWMrOXF2b1NnY2xTZVdHVGhFU0hPOGl3QkJG?=
 =?utf-8?B?RVpDMkZTU2VtV3lpRXEvWUt3WTlSY0QxbExNWlQvTEJ0bEtUVnVOcWdVVk5w?=
 =?utf-8?B?OVNHU1g1N0N2b1R1QVVoaWhTT01VZzFIc3ZHejJXYmpBWlVOOEtmdFUxV1dO?=
 =?utf-8?B?dkl6MnFvbW00c2xnM1RsbFhpZlhTdlYwRStpZWREckRpelliY0VGYzV6WFM3?=
 =?utf-8?B?V01MRUVNQTNRalNVSlJ1ODdoZGlscUZhSVU1TC9zZ2psZlZyL1Z0NnNhVUsy?=
 =?utf-8?B?a3B3SDh6RGhKeFZnT0wyYVdvelFwTzdyRjdGaTFranpya1NjcXhHMjkyYk9F?=
 =?utf-8?B?disrWHZyb2tMMndFdlUyaVlCUkdNNlNuNXNLNXpoelhtMTJacEVFQ3gzb1NE?=
 =?utf-8?B?U09IRnFWUjZ5SWJGS3FLOFhNMUVOeXJjellwVkpmWkE0cXNHQTRsNzRqNzRI?=
 =?utf-8?B?dFRpLzFJd1ZjRnhkckZTZEtHOTNiN1JiNHkvNVdzTzBxdTBuaEwvTTAvTkd5?=
 =?utf-8?B?amM2UjRROEhNVnUwOFV3SDEwMTBISlQzVlFwSDdmU25VSUUyTDZRckFndkM2?=
 =?utf-8?B?Rk9id1E2ZHdPNjVEbVRlV0dIRUp6NFNaSW5ZcG95ZjdCTUt6Qzc0akFuMWVl?=
 =?utf-8?B?Rkp2NUlrTEVnSVVOelk3U2t1OXFMODFHTlNGR1dXcnFTYkw0WlBVOHNmMUJ6?=
 =?utf-8?B?MmdSYnpxREh3alF5aS9Hd2JZbHd5Z0FGb2kzQ3Z2U1V5WUVDRTdFMlVPUE9x?=
 =?utf-8?B?U3VOelFXWTZialVvOE9aRkxJS0M3amFSc2FMN2dPR24xYVJzajl0aWRtUVkw?=
 =?utf-8?B?Q0JFTFlONWdPVDl1bTdrbzlTa05ySVNrVGdvVHJhekhMdkNUSnVTNk9nemUv?=
 =?utf-8?B?TlZ4ZFZyT3FlVE93dGV1UnY4NzkrZm43MU1iNVROcFB5NHlvU00wWk9wZTVO?=
 =?utf-8?B?Qm9xUHhrQytNTGQyVWhuVmJkRmlWMEVHZkYrTUJNYXdhaldNVllhY0RKQjJi?=
 =?utf-8?B?eHRwckpjd2hNZ2hsOHl3NFdicnppTEMrMUVtY1hVU3V6dFhUc2tVR3BVTVNP?=
 =?utf-8?B?UW1hS1V2V3Q1clhHK0VVd3RvNndzV0w3MGt5b2o1Z0RlN29VQXVYYW1HZVJV?=
 =?utf-8?B?YVVLNFZ1YmdBNENKanVOb2lGTTBKckg1V3lodW9lWWJHeG0zV0lvQVh3TFVG?=
 =?utf-8?Q?4oK2VK?=
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:IA3PR11MB9136.namprd11.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(1800799024)(376014)(366016)(38070700021); DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?T01Xb3BiK3hOOEY1WnUwWlA3aVJSUWc4QWNuU3grRlhNUnFBMisrSXJyWFhh?=
 =?utf-8?B?SDl0cW1XL3pLV29JOUNBdlI0dFdRZWgrVWNVR0M0dHhrVVIyaFU2TW1IZUJu?=
 =?utf-8?B?WmNlMTVWTXZQdWlxSWxocjQ3aHFGTTJmSVFEZUkyaVJvNnBVY0Erd1dRR1Mx?=
 =?utf-8?B?RkIwOFMySGlIdkxXVmFVOFQxdmYyYmZXVFhtSHlpYnNVa2NMSWsvOWRrUTE4?=
 =?utf-8?B?VEcxM21ZWHVUaTQ5eGhRVm5Jd0FaTmdFTDJzeDVSWCtUUmlMaHFXT1hXbjQz?=
 =?utf-8?B?VFIrRFFMMDl4dHlxbUNMcVhXN3gzNzZnVktCUkY1aU10WXZWdUg5S1J0Z3Br?=
 =?utf-8?B?eDZoOWttQWpnOGg2RUw0TWc5V213Rk16NmZNdkptZnNza2V2SXlGN1I0Mkth?=
 =?utf-8?B?WSs0bHNEaUw0V3pRbDlGYUxpQUJsak84cGVrYmFrRmlhNlYyT0xZMlozWUpT?=
 =?utf-8?B?TUd0QlBKQ21XSlJzR3NHQjVGT2t4NENUMExJem1OUFVSbm5FSmNvRTlMbjdG?=
 =?utf-8?B?YnJCbCtiNmN6SHdkNE5yamRBVFcvaWNseG91d1YrTVpxQyswaTFQd3hJTlQ1?=
 =?utf-8?B?UHdsMHVRSjBZcnhHb3pSVjh0R0c4WGdzR1VxOERRdVJGRzVFLzUxclJLeWVR?=
 =?utf-8?B?Q3pURng1MXIxZGVMd0s0OHVmUFpBemt5anNhREtJYzNlbjAxY0dGSXdCN2F3?=
 =?utf-8?B?YmJkOUVqZzh6Tzh4SURjT1MxOGloUkc2RHFMNDYvUFIzSElEc2RzKzlHTUFu?=
 =?utf-8?B?d2drKzJQRHQ2dFFQQzk4cU1sb2pwbjkrOFdLbEVqK1BoU21KamsyREJSM3dM?=
 =?utf-8?B?NkFpZVduYUpPR2M1UmFpY1lod3NoMVQ5cGVZQzNySlVYVm1jaXN2Sis2VWtn?=
 =?utf-8?B?MXRaSWlKWkZpRkNUMVh6T0NoU0dqWFR2TnBxbElhb2xQakFuN0l1MDRWZTdL?=
 =?utf-8?B?dHdTTnVFWHVsTGgvZGNRUXRyNHlaNVIwVVNPQVU4Vis4Uk15cU40dXpQY3Vy?=
 =?utf-8?B?dzhQUjJLZDB4M0xCV0FDcTZtd0cyY2hCdkxkSit3TVlZZ3NUcytHNVMxbzhi?=
 =?utf-8?B?WjNwdEwxMVA5NHU1d3QvWGQ5THVMNzgzVnpaUEczWDlSVlRSREFrVjNOTXFL?=
 =?utf-8?B?TFY0ZXp6dEhEdkpSUVJ6WDZDc2s5NGlwUFlXdXlhTG82a0RUS0lISEtwdXl6?=
 =?utf-8?B?eENNKytFZ2RBK1E3elVGMTFNeXNDdmJJdEVXWU5OWUs2U0JHbWsyODBoVk1W?=
 =?utf-8?B?U3VrY1NHdDhUL211UG4xc2dlbllJaGN2MGNmcTh2OEdpcEFZb1lqRlJqa2ZG?=
 =?utf-8?B?ODAvUHdodXF0NGJOQlFhY1FjTWo5andaZjdqLzVlSjl6U1RyTitwWUZCczBh?=
 =?utf-8?B?dW1NMlFJWmZYTkV0VUdzd3M2RURQb2llb3l0RjBXQkVxTEx2OUpaMjlqdFBv?=
 =?utf-8?B?Vi8rYzBrUjFqSk1ZR1YxYkV3UUtVSE5kSDdCYXAvZEg1cENGQU9SZjhFZzlM?=
 =?utf-8?B?MTZzdFNJY2NZa09iWjZYVmlESHZFRTljcVVGeHg1T0VLYVFxQ1NmOU1tM0gw?=
 =?utf-8?B?NTFSdllPMDd1am1zQ1BUdGNRclh6eEVGTFdnQ1RPczNZNnZLWmRhUnBZbUE1?=
 =?utf-8?B?cjJzMmdHQzNpeXQyUitVUXJLdG9qT0tiV1FHSUlJbWdIeE1TWmdnZ29SRFp4?=
 =?utf-8?B?Q2JLUElxdnIwbWNlNnNwTlpoVm9vTWdiLzVlampYSHo2cXkyK2VZdXF5WnZa?=
 =?utf-8?B?cTJjc1ZiQitDSFNNMjVpRXhXMEhQdFhhTWovZmxORk5TSVBlclU4WjFNbkd5?=
 =?utf-8?B?NHVwNFhYd1ZIUytXR01SWDc1bC9EWGQwVFRsVmQ1UFA1S0hnK29EUVBZKzFh?=
 =?utf-8?B?a2pYeFljOUtheFkrWll5Zi9kN3ZFMWZLZ2FMMUJRRk9KNXdBQkJKNzlZRE15?=
 =?utf-8?B?WlA1eUJjVjZLbkpkU2dJb2twNDhwN2ZnRXJhUnBYNm5ZSjJnay82Rlc3U2ZU?=
 =?utf-8?B?bkRsQy82SHFuZ3NFTmk2dWxNYTlXa2FVQTJPakFTdVFhV013elpHTlRZY0d4?=
 =?utf-8?B?MDJ2RURWTkwrb1QrREl0NittR3FHcHNLaStBWjEvaHVDSUwydVZuQmxUOEov?=
 =?utf-8?Q?Hoa6muGGVn2tyRYkRN6du+fIe?=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: IA3PR11MB9136.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 70186015-b795-4919-4926-08de0fbf90bc
X-MS-Exchange-CrossTenant-originalarrivaltime: 20 Oct 2025 10:00:57.4020 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: tg65rI/PzawoGcyjFFoWcPzBkUGN7cFjXRqshjn44aA4Yi8favNM+sdOmmubbYO+0a9N5+lSiz+dGa5tBTlzkP+m+jxLXxyRYjs9vQtL0EU=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ0PR11MB7156
X-OriginatorOrg: intel.com
Received-SPF: pass client-ip=192.198.163.19;
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

SGkNCg0KPi0tLS0tT3JpZ2luYWwgTWVzc2FnZS0tLS0tDQo+RnJvbTogQXZpaGFpIEhvcm9uIDxh
dmloYWloQG52aWRpYS5jb20+DQo+U3ViamVjdDogUmU6IFtQQVRDSCB2MiAyLzhdIHZmaW8vaW9t
bXVmZDogUXVlcnkgZGlydHkgYml0bWFwIGJlZm9yZSBETUENCj51bm1hcA0KPg0KPkhpLA0KPg0K
Pk9uIDE3LzEwLzIwMjUgMTE6MjIsIFpoZW56aG9uZyBEdWFuIHdyb3RlOg0KPj4gRXh0ZXJuYWwg
ZW1haWw6IFVzZSBjYXV0aW9uIG9wZW5pbmcgbGlua3Mgb3IgYXR0YWNobWVudHMNCj4+DQo+Pg0K
Pj4gV2hlbiBhIGV4aXN0aW5nIG1hcHBpbmcgaXMgdW5tYXBwZWQsIHRoZXJlIGNvdWxkIGFscmVh
ZHkgYmUgZGlydHkgYml0cw0KPj4gd2hpY2ggbmVlZCB0byBiZSByZWNvcmRlZCBiZWZvcmUgdW5t
YXAuDQo+Pg0KPj4gSWYgcXVlcnkgZGlydHkgYml0bWFwIGZhaWxzLCB3ZSBzdGlsbCBuZWVkIHRv
IGRvIHVubWFwcGluZyBvciBlbHNlIHRoZXJlDQo+PiBpcyBzdGFsZSBtYXBwaW5nIGFuZCBpdCdz
IHJpc2t5IHRvIGd1ZXN0Lg0KPj4NCj4+IENvLWRldmVsb3BlZC1ieTogSm9hbyBNYXJ0aW5zIDxq
b2FvLm0ubWFydGluc0BvcmFjbGUuY29tPg0KPj4gU2lnbmVkLW9mZi1ieTogSm9hbyBNYXJ0aW5z
IDxqb2FvLm0ubWFydGluc0BvcmFjbGUuY29tPg0KPj4gU2lnbmVkLW9mZi1ieTogWmhlbnpob25n
IER1YW4gPHpoZW56aG9uZy5kdWFuQGludGVsLmNvbT4NCj4+IFRlc3RlZC1ieTogWHVkb25nIEhh
byA8eHVkb25nLmhhb0BpbnRlbC5jb20+DQo+PiBUZXN0ZWQtYnk6IEdpb3Zhbm5pbyBDYWJpZGR1
IDxnaW92YW5uaS5jYWJpZGR1QGludGVsLmNvbT4NCj4+IC0tLQ0KPj4gICBody92ZmlvL2lvbW11
ZmQuYyB8IDggKysrKysrKy0NCj4+ICAgMSBmaWxlIGNoYW5nZWQsIDcgaW5zZXJ0aW9ucygrKSwg
MSBkZWxldGlvbigtKQ0KPj4NCj4+IGRpZmYgLS1naXQgYS9ody92ZmlvL2lvbW11ZmQuYyBiL2h3
L3ZmaW8vaW9tbXVmZC5jDQo+PiBpbmRleCA5NzZjMGE4ODE0Li40MDRlNjI0OWNhIDEwMDY0NA0K
Pj4gLS0tIGEvaHcvdmZpby9pb21tdWZkLmMNCj4+ICsrKyBiL2h3L3ZmaW8vaW9tbXVmZC5jDQo+
PiBAQCAtNzQsNyArNzQsMTMgQEAgc3RhdGljIGludCBpb21tdWZkX2NkZXZfdW5tYXAoY29uc3QN
Cj5WRklPQ29udGFpbmVyICpiY29udGFpbmVyLA0KPj4gICAgICAgaWYgKGlvdGxiICYmIHZmaW9f
Y29udGFpbmVyX2RpcnR5X3RyYWNraW5nX2lzX3N0YXJ0ZWQoYmNvbnRhaW5lcikpIHsNCj4+ICAg
ICAgICAgICBpZg0KPighdmZpb19jb250YWluZXJfZGV2aWNlc19kaXJ0eV90cmFja2luZ19pc19z
dXBwb3J0ZWQoYmNvbnRhaW5lcikgJiYNCj4+ICAgICAgICAgICAgICAgYmNvbnRhaW5lci0+ZGly
dHlfcGFnZXNfc3VwcG9ydGVkKSB7DQo+PiAtICAgICAgICAgICAgLyogVE9ETzogcXVlcnkgZGly
dHkgYml0bWFwIGJlZm9yZSBETUEgdW5tYXAgKi8NCj4+ICsgICAgICAgICAgICByZXQgPSB2Zmlv
X2NvbnRhaW5lcl9xdWVyeV9kaXJ0eV9iaXRtYXAoYmNvbnRhaW5lciwgaW92YSwNCj5zaXplLA0K
Pj4gKw0KPmlvdGxiLT50cmFuc2xhdGVkX2FkZHIsDQo+PiArDQo+JmxvY2FsX2Vycik7DQo+PiAr
ICAgICAgICAgICAgaWYgKHJldCkgew0KPj4gKyAgICAgICAgICAgICAgICBlcnJvcl9yZXBvcnRf
ZXJyKGxvY2FsX2Vycik7DQo+PiArICAgICAgICAgICAgfQ0KPj4gKyAgICAgICAgICAgIC8qIFVu
bWFwIHN0YWxlIG1hcHBpbmcgZXZlbiBpZiBxdWVyeSBkaXJ0eSBiaXRtYXAgZmFpbHMgKi8NCj4+
ICAgICAgICAgICAgICAgcmV0dXJuIGlvbW11ZmRfYmFja2VuZF91bm1hcF9kbWEoYmUsIGlvYXNf
aWQsIGlvdmEsDQo+c2l6ZSk7DQo+DQo+SWYgcXVlcnkgZGlydHkgYml0bWFwIGZhaWxzLCBzaG91
bGRuJ3Qgd2UgdW5tYXAgYW5kIHJldHVybiB0aGUgcXVlcnkNCj5iaXRtYXAgZXJyb3IgdG8gZmFp
bCBtaWdyYXRpb24/IE90aGVyd2lzZSwgbWlncmF0aW9uIG1heSBzdWNjZWVkIHdpdGgNCj5zb21l
IGRpcnRpZWQgcGFnZXMgbm90IGJlaW5nIG1pZ3JhdGVkLg0KDQpPaCwgZ29vZCBjYXRjaC4gV2ls
bCBtYWtlIGJlbG93IGNoYW5nZToNCg0KLS0tIGEvaHcvdmZpby9pb21tdWZkLmMNCisrKyBiL2h3
L3ZmaW8vaW9tbXVmZC5jDQpAQCAtNjUsNyArNjUsNyBAQCBzdGF0aWMgaW50IGlvbW11ZmRfY2Rl
dl91bm1hcChjb25zdCBWRklPQ29udGFpbmVyICpiY29udGFpbmVyLA0KICAgICB1aW50MzJfdCBp
b2FzX2lkID0gY29udGFpbmVyLT5pb2FzX2lkOw0KICAgICBib29sIG5lZWRfZGlydHlfc3luYyA9
IGZhbHNlOw0KICAgICBFcnJvciAqbG9jYWxfZXJyID0gTlVMTDsNCi0gICAgaW50IHJldDsNCisg
ICAgaW50IHJldCwgdW5tYXBfcmV0Ow0KDQogICAgIGlmICh1bm1hcF9hbGwpIHsNCiAgICAgICAg
IHNpemUgPSBVSU5UNjRfTUFYOw0KQEAgLTgyLDcgKzgyLDE0IEBAIHN0YXRpYyBpbnQgaW9tbXVm
ZF9jZGV2X3VubWFwKGNvbnN0IFZGSU9Db250YWluZXIgKmJjb250YWluZXIsDQogICAgICAgICAg
ICAgICAgIGVycm9yX3JlcG9ydF9lcnIobG9jYWxfZXJyKTsNCiAgICAgICAgICAgICB9DQogICAg
ICAgICAgICAgLyogVW5tYXAgc3RhbGUgbWFwcGluZyBldmVuIGlmIHF1ZXJ5IGRpcnR5IGJpdG1h
cCBmYWlscyAqLw0KLSAgICAgICAgICAgIHJldHVybiBpb21tdWZkX2JhY2tlbmRfdW5tYXBfZG1h
KGJlLCBpb2FzX2lkLCBpb3ZhLCBzaXplKTsNCisgICAgICAgICAgICB1bm1hcF9yZXQgPSBpb21t
dWZkX2JhY2tlbmRfdW5tYXBfZG1hKGJlLCBpb2FzX2lkLCBpb3ZhLCBzaXplKTsNCisNCisgICAg
ICAgICAgICAvKg0KKyAgICAgICAgICAgICAqIElmIGRpcnR5IHRyYWNraW5nIGZhaWxzLCByZXR1
cm4gdGhlIGZhaWx1cmUgdG8gVkZJTyBjb3JlIHRvDQorICAgICAgICAgICAgICogZmFpbCB0aGUg
bWlncmF0aW9uLCBvciBlbHNlIHRoZXJlIHdpbGwgYmUgZGlydHkgcGFnZXMgbWlzc2VkDQorICAg
ICAgICAgICAgICogdG8gYmUgbWlncmF0ZWQuDQorICAgICAgICAgICAgICovDQorICAgICAgICAg
ICAgcmV0dXJuIHVubWFwX3JldCA/IDogcmV0Ow0KICAgICAgICAgfQ0KDQoNClRoYW5rcw0KWmhl
bnpob25nDQo=

