Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id CF1BEC04FFE
	for <qemu-devel@archiver.kernel.org>; Mon, 20 May 2024 07:56:58 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1s8xsU-0001Jp-Jg; Mon, 20 May 2024 03:56:14 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <zhenzhong.duan@intel.com>)
 id 1s8xrS-0001FP-Dx
 for qemu-devel@nongnu.org; Mon, 20 May 2024 03:55:10 -0400
Received: from mgamail.intel.com ([198.175.65.18])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <zhenzhong.duan@intel.com>)
 id 1s8xrQ-0002ug-5n
 for qemu-devel@nongnu.org; Mon, 20 May 2024 03:55:10 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1716191708; x=1747727708;
 h=from:to:cc:subject:date:message-id:references:
 in-reply-to:content-transfer-encoding:mime-version;
 bh=MmyYFaftKaJTQ999L1Tu4s1BN3pdTl6Ddala9VS9+6c=;
 b=YIUBpMe7C5vEtj08eNy8/womomjyI4xjmAy4zEyls1+XEnHTb/7c9CWN
 M+qtG6rPOmkdm+tAGy6wqJKh36ReNPdNsfb6nfg8uGWX7Q4uuxLUToyNz
 LwKHss7AjKQTIrtF90RmDYS+Ii/eT2S8NuXKFcwrTWhjkTgHO/LZRqT71
 87bqBNZiafby42XfBt//eB+sH+qNFlzHz0O/VVmFTvR8Flb4KG2YiWDS8
 1TfWq1LNzOBM4H1he3g7h5/QrzRsnYywfLHIurlL9kcuaUmDxCr5EXLEe
 Y2Qt0P42WAyrMpz+3esP2VFMYCwM9Ui3U57OGZ0D5EZ8CKkW5ZygdZ/vy w==;
X-CSE-ConnectionGUID: RYRAaNuGQcmqkMtA9ksSLA==
X-CSE-MsgGUID: XxJWk+u7ROay24rXObSMLg==
X-IronPort-AV: E=McAfee;i="6600,9927,11077"; a="12474486"
X-IronPort-AV: E=Sophos;i="6.08,174,1712646000"; d="scan'208";a="12474486"
Received: from fmviesa002.fm.intel.com ([10.60.135.142])
 by orvoesa110.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 20 May 2024 00:55:05 -0700
X-CSE-ConnectionGUID: /Xfggz3OQieKyiA419Tu8w==
X-CSE-MsgGUID: VdSBtt9CTU+dbUlVlbMXdA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.08,174,1712646000"; d="scan'208";a="55677535"
Received: from orsmsx603.amr.corp.intel.com ([10.22.229.16])
 by fmviesa002.fm.intel.com with ESMTP/TLS/AES256-GCM-SHA384;
 20 May 2024 00:55:04 -0700
Received: from orsmsx611.amr.corp.intel.com (10.22.229.24) by
 ORSMSX603.amr.corp.intel.com (10.22.229.16) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.39; Mon, 20 May 2024 00:55:03 -0700
Received: from orsmsx602.amr.corp.intel.com (10.22.229.15) by
 ORSMSX611.amr.corp.intel.com (10.22.229.24) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.39; Mon, 20 May 2024 00:55:03 -0700
Received: from ORSEDG601.ED.cps.intel.com (10.7.248.6) by
 orsmsx602.amr.corp.intel.com (10.22.229.15) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.39 via Frontend Transport; Mon, 20 May 2024 00:55:03 -0700
Received: from NAM12-MW2-obe.outbound.protection.outlook.com (104.47.66.41) by
 edgegateway.intel.com (134.134.137.102) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.39; Mon, 20 May 2024 00:55:03 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=QwyyaYSkWxTVlgxNBLLHZs17gxMS1DbP9gj2dUDFhY431ehUWgxMbPdpoEC1lL0sFCTqy0mL9dO3tCtzaVeshVBC1GkHAXraXVHXy/fhgHoBPbKd0tj7ZtuKD2SE/DsI20ry4mU1AslTOKAsrzWVub+dN3eH8hHdxfPLiYeqvKrntC5KDyVAVh/chXCqCfmIXmJO8GxrLDqMsZ5cwJ5KvB90rIg0VQNx/SSJJsYaDAmpqAV9UmgcFc4lfplMqLYLAjPeZEN7PhKKiT8Hb2HI5wNF1gF+mi22xgtO5DmIzbKaWaqVbDpSGyWtdQxv/wlHxjCweLAgti4Swu9Kk8XXuA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=MmyYFaftKaJTQ999L1Tu4s1BN3pdTl6Ddala9VS9+6c=;
 b=DJZpdxz1X1zpi+WSJSS+KzDgUTe5RxpZ44aZcukGrWfKT1WMVvI0wl/lur4gVUANJkGtIc3Ln+Wyf8bEbSJ6m7ZbvJT9Bboan7PNRloE9JRaPDhN7N/19ZYTcTLlG4J/UTViqUqjw0cz9/gSyQ8akfmTkedoJ9Me9foqwtK/kCb/Cx05QBEa+MgnQMvjDCWQb8DeHmF4OLL0ZWkO3uXYcicu5FNZ3xFeLP6jCBN/zieB/tppdJCbaMVvzSi2bGiZHH2I7vToAz4gRECaGsAX49i0k11AVAVAJJxY7cALLhj65ufaPSj4Zu3Ma1NdppsyQWoYH0lfeGv+1jCzkPTaSw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Received: from SJ0PR11MB6744.namprd11.prod.outlook.com (2603:10b6:a03:47d::10)
 by SJ0PR11MB6575.namprd11.prod.outlook.com (2603:10b6:a03:477::8)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7587.36; Mon, 20 May
 2024 07:55:01 +0000
Received: from SJ0PR11MB6744.namprd11.prod.outlook.com
 ([fe80::21df:af3:be1d:722e]) by SJ0PR11MB6744.namprd11.prod.outlook.com
 ([fe80::21df:af3:be1d:722e%4]) with mapi id 15.20.7587.030; Mon, 20 May 2024
 07:55:01 +0000
From: "Duan, Zhenzhong" <zhenzhong.duan@intel.com>
To: "Liu, Yi L" <yi.l.liu@intel.com>, Jason Wang <jasowang@redhat.com>
CC: "qemu-devel@nongnu.org" <qemu-devel@nongnu.org>, "Peng, Chao P"
 <chao.p.peng@intel.com>, Yu Zhang <yu.c.zhang@linux.intel.com>, "Michael S.
 Tsirkin" <mst@redhat.com>, Paolo Bonzini <pbonzini@redhat.com>, "Richard
 Henderson" <richard.henderson@linaro.org>, Eduardo Habkost
 <eduardo@habkost.net>, Marcel Apfelbaum <marcel.apfelbaum@gmail.com>
Subject: RE: [PATCH] intel_iommu: Use the latest fault reasons defined by spec
Thread-Topic: [PATCH] intel_iommu: Use the latest fault reasons defined by spec
Thread-Index: AQHaqESnRiGl1jiq20uiRV0AFydhKrGfTQkAgAAs2mCAAA5PgIAANw/A
Date: Mon, 20 May 2024 07:55:01 +0000
Message-ID: <SJ0PR11MB67441CF18BB3C90C222808DB92E92@SJ0PR11MB6744.namprd11.prod.outlook.com>
References: <20240517102334.81943-1-zhenzhong.duan@intel.com>
 <CACGkMEvTomFeC1bM3SfY1zGhQ_5i15r6CY6M3jVzau6niNUf_w@mail.gmail.com>
 <SJ0PR11MB6744AECEAA6F9319259B0DF192E92@SJ0PR11MB6744.namprd11.prod.outlook.com>
 <DS0PR11MB752917B52B66A6EF10C10678C3E92@DS0PR11MB7529.namprd11.prod.outlook.com>
In-Reply-To: <DS0PR11MB752917B52B66A6EF10C10678C3E92@DS0PR11MB7529.namprd11.prod.outlook.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: SJ0PR11MB6744:EE_|SJ0PR11MB6575:EE_
x-ms-office365-filtering-correlation-id: 59079918-6988-4c58-801a-08dc78a22744
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0; ARA:13230031|366007|376005|1800799015|38070700009;
x-microsoft-antispam-message-info: =?utf-8?B?YVBucCtkK2liQTlNcjUvaW1rWXpZZWZ0ZmhOUXBDYkpEN0ZvRzhSQmVGYnkx?=
 =?utf-8?B?anpXUmVNdUplTXZqQjF3dzdiTklmL2lOcmp3b1NVUEM1RVBnbVQ2SmZXTHdC?=
 =?utf-8?B?T2NWdXVQemFuNXdMNU0ySWpQV1lia1ZNWUQxM0dwZEdRTXVZeTVVSEtUTjcv?=
 =?utf-8?B?MDVJUGl3NTh2NS91K2xVd0tieHlNUFl4YXRRbU9DYTBjSXpWYnJ4RmsxNnFZ?=
 =?utf-8?B?cUs2WEVlRjhzOThmOWpEUE9qM0VMSDhYb3Zvdlh2Mk0vMnBZTzEyb3U1ZTE3?=
 =?utf-8?B?c1Y2TGZBa2JDcnJUL2NyVlp5Z1QrZlQxSHNhczZrZVlwaG5GaTBLVFR2dXZK?=
 =?utf-8?B?T2k0SlhpRUNmTEVsWmdYdnVqUlBQVTR0d3Z3ZWUwUkk2ZjBvM1BuZGpQdUNO?=
 =?utf-8?B?NUdLaWZudW9wa3VhNmJTTi9qVVI3RWRHRUxmTUlsTlBNYlg5aVB2amdqYW1i?=
 =?utf-8?B?QTdPdDdlTGdVdGZmaGdDRWxlQzUzeWt2V2g1RG1RQzU5V1B6RStxUE1WRVpr?=
 =?utf-8?B?cmtqTVpBeWg2YU1RL09LYWc5ZVZaQ1dXZllncTFMbkJXR3FpUUVtOG5sTCtV?=
 =?utf-8?B?RmgzK1lNc3FEQUVLTU1ub3hCNjdpNzQ4d0FYZGczRjg5Q1lUeEpvMU5nQVZp?=
 =?utf-8?B?c3ozQXdzRi9LOFNBbmhWZ1RkVmhaMFlDWGVVd3ZXeDNaUjczMVVXcytWRDFE?=
 =?utf-8?B?QUIvWWowUGxVVnIyK1ltRmQ0YXpqK0RjOEZ3Vy9PcFZsMlQ0dDIxckpwckZP?=
 =?utf-8?B?ME9EVDM2V013UC9tV1NhRUpMblBhd3lpUXBUL3lKTTEzOXd2dWRpOFU2aFdY?=
 =?utf-8?B?YjBLUkQydkdweWtQYmxrOVZQbWlhTThCQ3ZGNzNydU9VVFdPd1hWVU10YTNB?=
 =?utf-8?B?MFd3a0l3RHZ2RHNMdiswTWU4S05XODNyYmdkazJRd2kzMzJIRlU1QVQ3cGJs?=
 =?utf-8?B?Ky9sendsN2JSQWt5SUNuMnd2L0ttQjdFRXF2OVg0WEc3a0FZV2V0WTdWcllV?=
 =?utf-8?B?SGlMNDhTL2tpczRqbml2SDl6d2pqalFMcDlvb0swV2twRVpUd2RMejVMQkdk?=
 =?utf-8?B?RmxqUzRObllWK2tJZnBmcStaTTBHZlg0dStjTjB6UGFxWEFMS3c5YWM2QWVB?=
 =?utf-8?B?ZUZYbURoTnBTdFZURjNScGlPUk4vYUQvS1pieHlmdG9IbzFmZ1VHUG0wazBy?=
 =?utf-8?B?SjFZUGpPR3ZreGVKQWdsOVIwOTAwcU5uTFZkM0gwYVltNDEyWkVEVG5pRUNZ?=
 =?utf-8?B?L0MwUU1UenFadWF4NkNUeFprcFlscTZ4TVZzK210akdkK0xOZUphWlN0d2VJ?=
 =?utf-8?B?T1dMSmZUcHRUaVAxbFR2QXR5Tk5reHpoTENJNVNqWWREbjh2RXh1Nm91T0ds?=
 =?utf-8?B?cGZtRW1xaHNaMVhDY0dWTXpqQTlYNldoZmlaWWRGN0Zia0Y1Wm5wSUlLM0xH?=
 =?utf-8?B?UVpjbUlScEdJcE5pZndSSU1tWlByejFlNGYzaTZKdTZNclVuVUpwSm8zV0Fv?=
 =?utf-8?B?d1RxYkNZVHRZRmxLNVNQUUVsZWU4UEZoNmdOckV3WEZ3dERtU1E3Nm9ObVBi?=
 =?utf-8?B?WFJ6YTdIZTZhTnVjUlJhMWY0d1Q3VDJlaE05cDkvZWtMYnV5bE1uWVNVSFBt?=
 =?utf-8?B?ZDBXVFZaRC9uck8yWWZQVnNhenI5RlpDSWxpdkwrTE5JTFZPckgxQ3J0Y01w?=
 =?utf-8?B?dDFVVWRuSzE2U0x6L2JETVRTc1NsZis4RnN5K0dPSStxdHQvWHJxenVsOE1m?=
 =?utf-8?B?aEVuOGlVVFIxVzhpWTcrL0s4OG16N2N6VlQvOGowdWZXVzN0dzc5eVdhR2E1?=
 =?utf-8?B?V1FPTGtPSUF6ZHVFRy95Zz09?=
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:SJ0PR11MB6744.namprd11.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230031)(366007)(376005)(1800799015)(38070700009); DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?aFVEcXE3ckpWVVdKYnVlS1UzWU8yQVdIMVBEZFUrUzdXMUNpNHN6a2kwaG5X?=
 =?utf-8?B?RytDTE53dnJ3S1R5alhnVTlScG5pSVVsNkt3N2VTWmhOTnJodjhUQVFsaFpa?=
 =?utf-8?B?L25nVmY2NEJzY3dWZG1OYkJiWVNmc0lvbGdOZGc3KzhLOFVPeDl2VEJCYVNS?=
 =?utf-8?B?SmZ5UkJ6VFg4N1BEZ2dNS0t3QUIrMGpCNURaaEdYU2ZJMFdpMzlnMi9ib3Rl?=
 =?utf-8?B?U3dOMTlSWGU3RjFHMzEyY3RpdkFYU0l2elZXUG5xaTlXQlN5VTU5a3Q5U1Vk?=
 =?utf-8?B?SzVnT1pFT25CWmNZM2dmSjFocGFBSzM3SFJPT3Mya1dwS3lVT0JMZk9sRWUw?=
 =?utf-8?B?ZmlsaTlyYWMrWkdyQjE4SnhOZ0hIczZ5NTRmV2JMRWxQN1BDMjU3ZktWcE0v?=
 =?utf-8?B?a3UxYmtQL05DeXdHc1BjeUVHZUdLdFAwcERwMzZqWXcrWWRpVlYrMFZicmg4?=
 =?utf-8?B?N3IyOEtwVEpWc3ZWNmI3UW1lblg0Uy9WNFQvd3d5TmRYWFV1ODBhUHM1blk5?=
 =?utf-8?B?TlRJR3RDTDRsZGlkcWdlSjFnVDJzNVlYVFRramw1ZURxSnJKcStUT1JCRkRP?=
 =?utf-8?B?VUVtTHhqb1AzWjMxaVl4NG8rMWZKRHcxRTJvcVcvQ3V2OXhXSGtjcHNkSE1G?=
 =?utf-8?B?SFRpNC9UdGV1V3hMWkE0YUk2aTVwWU4xQjZBWTRVSndNR0h3V2lWSFQ5OEFZ?=
 =?utf-8?B?Q0s2cmk2R0NmNHlpTG1NQldVRytabEVrRk1OdGM1ZkFYWmxVUlN6bVR3RFdI?=
 =?utf-8?B?dDFsQmFndlR3RTRTaDBBQWdsRmt1SGRJWjA5Q3B1cEIvSDNiQUpKTEN5VVUw?=
 =?utf-8?B?cG0rRjBDZUZIaGRXQW5iMVNOV3NRMXBvaUsyWGI5UDRnSE9Ub0k2bHE3TlpJ?=
 =?utf-8?B?elNudy9ick8vZnU1MXVhY2hYa080SnNyN3Z1Vzl3Nlp5Q0cvSUVOYXEzUmdR?=
 =?utf-8?B?eHdnUHFxY3NkN1l0cGZCM3lhQVZkY1BrZHNzb25DL0l5QU53NnZWWkVYWjNM?=
 =?utf-8?B?VURvT1NvZFl2WGxPNCtPTkxjcE1oWDBPM053RUI0MVdLWmpzeHpyUnVVUHhC?=
 =?utf-8?B?MXVPRlJaQlBWMXZMUWY1aHZINzZ5NGlpcE0xSFFBcnNVNDlxOGU1UUdGcVJS?=
 =?utf-8?B?OHFoRm9OY1R1OGIxUktML1lvWTZPd1U1OUQ1SXdtaUluVFFPc0RSYTE3M1pa?=
 =?utf-8?B?N3dVUnlGZ28wcnFpOFlBN2hEQmxJMFBSZmZoTGtjWmpnVFZPQldBTVROeEIw?=
 =?utf-8?B?L1lvVUtwaUorN1ZLVE5VdmFoYjZxVFFpUzJheDhZYUlzbkgveTFjVGxUV2FD?=
 =?utf-8?B?YTd4bFZ0dTlYRWRxN2xWMjF0MkFKZ0dvUDBVREVIRXlmM1FyWGkyQ2loOHJL?=
 =?utf-8?B?Vmd5dm9pUkhXb0xIald0Q1pxV3Z4TkpiNEJBanFWMU1MZUk0Y2xQN211K0Iy?=
 =?utf-8?B?V0YwZGs0aUlQRUhlVzU3SHNQVm82VitLcWtKbTk1RFdzaUN5eGxtbmZndG5E?=
 =?utf-8?B?bFVpNDc2b083NG1WVzRKdEFGNnZOVEp4TlloTHN3eEdNTis4S2tBWHNaNHFh?=
 =?utf-8?B?MzJZTWhZNnljSmg0ZEJJZS9xdythbG9UVXlTVU5HTjVWUnBmVG5QQWt5QXlD?=
 =?utf-8?B?aUpHcDAxM0NvdUFRWVdiOG5pM2lCVDNsaWhyQkZHQ2xxeU9IdzlCS0tvNDQv?=
 =?utf-8?B?ZE1qNEVWYjVVR2hEZUFJcExOVXZMZlNUR1E2eTFkaXZkaklpbjBCRWRFOVgy?=
 =?utf-8?B?YlpFb00xbno0QXVxeWZzRE4rQ2lNeGk3VHZkVTFkNzFYek1valE4YkpKT2xE?=
 =?utf-8?B?S1RBOXRhaGswMnVJMkxaaDF1bTFiQmJtbGd0bVBpbmV6WWxOdFBsSDRWaGk0?=
 =?utf-8?B?dWZRWTRMSE91RlRXKzFXTUlPb1lsZmpNY01ZUmtTMEVWYmdtTjUzSUc5cU9s?=
 =?utf-8?B?QUFIa3FHaUpiQlRCcVFBaVFibXRlcHBWQWQ5SGRjdm1yYkNrcHdZUHpFcVZY?=
 =?utf-8?B?S2hwU2x3T0tnYnArV0tCMVJtcytWczR1dnAzLzBubEpaMVB3bmtOeU43N0N2?=
 =?utf-8?B?dWpPRGI0RlZjZVpIdUFyek1HSVlWdDhGZjBsYmVJNndtbkVLaGwwdFl2bEZh?=
 =?utf-8?Q?1/rnO7UdfSykzlNxcoNafyBmY?=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: SJ0PR11MB6744.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 59079918-6988-4c58-801a-08dc78a22744
X-MS-Exchange-CrossTenant-originalarrivaltime: 20 May 2024 07:55:01.8461 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: Pi9pkY0PP3bgeLjG7iTjzqHiEzpYSV/gLBQ5EXf8xhyDMC+4o+Ldqqv9FTGIYGVeP3LIs9OjUW0uPCIwr7ZH4cp7p7qXRWfnsjHHU57m1bY=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ0PR11MB6575
X-OriginatorOrg: intel.com
Received-SPF: pass client-ip=198.175.65.18;
 envelope-from=zhenzhong.duan@intel.com; helo=mgamail.intel.com
X-Spam_score_int: -47
X-Spam_score: -4.8
X-Spam_bar: ----
X-Spam_report: (-4.8 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.383,
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

DQoNCj4tLS0tLU9yaWdpbmFsIE1lc3NhZ2UtLS0tLQ0KPkZyb206IExpdSwgWWkgTCA8eWkubC5s
aXVAaW50ZWwuY29tPg0KPlN1YmplY3Q6IFJFOiBbUEFUQ0hdIGludGVsX2lvbW11OiBVc2UgdGhl
IGxhdGVzdCBmYXVsdCByZWFzb25zIGRlZmluZWQgYnkNCj5zcGVjDQo+DQo+PiBGcm9tOiBEdWFu
LCBaaGVuemhvbmcgPHpoZW56aG9uZy5kdWFuQGludGVsLmNvbT4NCj4+IFNlbnQ6IE1vbmRheSwg
TWF5IDIwLCAyMDI0IDExOjQxIEFNDQo+Pg0KPj4NCj4+DQo+PiA+LS0tLS1PcmlnaW5hbCBNZXNz
YWdlLS0tLS0NCj4+ID5Gcm9tOiBKYXNvbiBXYW5nIDxqYXNvd2FuZ0ByZWRoYXQuY29tPg0KPj4g
PlNlbnQ6IE1vbmRheSwgTWF5IDIwLCAyMDI0IDg6NDQgQU0NCj4+ID5UbzogRHVhbiwgWmhlbnpo
b25nIDx6aGVuemhvbmcuZHVhbkBpbnRlbC5jb20+DQo+PiA+Q2M6IHFlbXUtZGV2ZWxAbm9uZ251
Lm9yZzsgTGl1LCBZaSBMIDx5aS5sLmxpdUBpbnRlbC5jb20+OyBQZW5nLCBDaGFvIFANCj4+ID48
Y2hhby5wLnBlbmdAaW50ZWwuY29tPjsgWXUgWmhhbmcgPHl1LmMuemhhbmdAbGludXguaW50ZWwu
Y29tPjsNCj5NaWNoYWVsDQo+PiA+Uy4gVHNpcmtpbiA8bXN0QHJlZGhhdC5jb20+OyBQYW9sbyBC
b256aW5pIDxwYm9uemluaUByZWRoYXQuY29tPjsNCj4+ID5SaWNoYXJkIEhlbmRlcnNvbiA8cmlj
aGFyZC5oZW5kZXJzb25AbGluYXJvLm9yZz47IEVkdWFyZG8gSGFia29zdA0KPj4gPjxlZHVhcmRv
QGhhYmtvc3QubmV0PjsgTWFyY2VsIEFwZmVsYmF1bQ0KPjxtYXJjZWwuYXBmZWxiYXVtQGdtYWls
LmNvbT4NCj4+ID5TdWJqZWN0OiBSZTogW1BBVENIXSBpbnRlbF9pb21tdTogVXNlIHRoZSBsYXRl
c3QgZmF1bHQgcmVhc29ucyBkZWZpbmVkIGJ5DQo+PiA+c3BlYw0KPj4gPg0KPj4gPk9uIEZyaSwg
TWF5IDE3LCAyMDI0IGF0IDY6MjbigK9QTSBaaGVuemhvbmcgRHVhbg0KPj4gPjx6aGVuemhvbmcu
ZHVhbkBpbnRlbC5jb20+IHdyb3RlOg0KPj4gPj4NCj4+ID4+IEZyb206IFl1IFpoYW5nIDx5dS5j
LnpoYW5nQGxpbnV4LmludGVsLmNvbT4NCj4+ID4+DQo+PiA+PiBDdXJyZW50bHkgd2UgdXNlIG9u
bHkgVlREX0ZSX1BBU0lEX1RBQkxFX0lOViBhcyBmYXVsdCByZWFzb24uDQo+PiA+PiBVcGRhdGUg
d2l0aCBtb3JlIGRldGFpbGVkIGZhdWx0IHJlYXNvbnMgbGlzdGVkIGluIFZULWQgc3BlYyA3LjIu
My4NCj4+ID4+DQo+PiA+PiBTaWduZWQtb2ZmLWJ5OiBZdSBaaGFuZyA8eXUuYy56aGFuZ0BsaW51
eC5pbnRlbC5jb20+DQo+PiA+PiBTaWduZWQtb2ZmLWJ5OiBaaGVuemhvbmcgRHVhbiA8emhlbnpo
b25nLmR1YW5AaW50ZWwuY29tPg0KPj4gPj4gLS0tDQo+PiA+DQo+PiA+SSB3b25kZXIgaWYgdGhp
cyBjb3VsZCBiZSBub3RpY2VkIGJ5IHRoZSBndWVzdCBvciBub3QuIElmIHllcyBzaG91bGQNCj4+
ID53ZSBjb25zaWRlciBzdGFydGluZyB0byBhZGQgdGhpbmcgbGlrZSB2ZXJzaW9uIHRvIHZ0ZCBl
bXVsYXRpb24gY29kZT8NCj4+DQo+PiBLZXJuZWwgb25seSBkdW1wcyB0aGUgcmVhc29uIGxpa2Ug
YmVsb3c6DQo+Pg0KPj4gRE1BUjogW0RNQSBXcml0ZSBOT19QQVNJRF0gUmVxdWVzdCBkZXZpY2Ug
WzIwOjAwLjBdIGZhdWx0IGFkZHINCj4weDEyMzQ2MDAwMDANCj4+IFtmYXVsdCByZWFzb24gMHg3
MV0gU006IFByZXNlbnQgYml0IGluIGZpcnN0LWxldmVsIHBhZ2luZyBlbnRyeSBpcyBjbGVhcg0K
Pg0KPlllcywgZ3Vlc3Qga2VybmVsIHdvdWxkIG5vdGljZSBpdCBhcyB0aGUgZmF1bHQgd291bGQg
YmUgaW5qZWN0ZWQgdG8gdm0uDQo+DQo+PiBNYXliZSBidW1wIDEuMCAtPiAxLjE/DQo+PiBNeSB1
bmRlcnN0YW5kaW5nIHZlcnNpb24gbnVtYmVyIGlzIG9ubHkgaW5mb3JtYXRpb25hbCBhbmQgaXMg
ZmFyIGZyb20NCj4+IGFjY3VyYXRlIHRvIG1hcmsgaWYgYSBmZWF0dXJlIHN1cHBvcnRlZC4gRHJp
dmVyIHNob3VsZCBjaGVjayBjYXAvZWNhcA0KPj4gYml0cyBpbnN0ZWFkLg0KPg0KPlNob3VsZCB0
aGUgdmVyc2lvbiBJRCBoZXJlIGJlIGFsaWduZWQgd2l0aCBWVC1kIHNwZWM/IElmIHllcywgaXQg
c2hvdWxkDQo+YmUgMy4wIGFzIHRoZSBzY2FsYWJsZSBtb2RlIHdhcyBpbnRyb2R1Y2VkIGluIHNw
ZWMgMy4wLiBBbmQgdGhlIGZhdWx0DQo+Y29kZSB3YXMgcmVkZWZpbmVkIHRvZ2V0aGVyIHdpdGgg
dGhlIGludHJvZHVjdGlvbiBvZiB0aGlzIHRyYW5zbGF0aW9uDQo+bW9kZS4gQmVsb3cgaXMgdGhl
IGEgc25pcHBldCBmcm9tIHRoZSBjaGFuZ2UgbG9nIG9mIFZULWQgc3BlYy4NCg0KT0ssIHRoZW4g
My4wIGlzIGEgYmV0dGVyIGNob2ljZS4gV2lsbCB1cGRhdGUgdmVyc2lvbi4NCkZvciBKYXNvbidz
IHF1ZXN0aW9uLCBldmVuIHRob3VnaCBtb3JlIGZhdWx0IHJlYXNvbnMgYXJlIGFkZGVkLA0KYnV0
IHRoZSByZWFzb24gbnVtYmVycyBhcmUgc3RpbGwgYmFja3dhcmQgY29tcGF0aWJsZSwNCnNvIG5v
IG5lZWQgdG8gZGVmaW5lIHJlYXNvbnMgcGVyIHZlcnNpb24uDQoNClRoYW5rcw0KWmhlbnpob25n
DQoNCj4NCj5KdW5lIDIwMTggMy4wDQo+4oCiIFJlbW92ZWQgYWxsIHRleHQgcmVsYXRlZCB0byBF
eHRlbmRlZC1Nb2RlLg0KPuKAoiBBZGRlZCBzdXBwb3J0IGZvciBzY2FsYWJsZS1tb2RlIHRyYW5z
bGF0aW9uIGZvciBETUEgUmVtYXBwaW5nLCB0aGF0DQo+ZW5hYmxlcyBQQVNJRGdyYW51bGFyIGZp
cnN0LWxldmVsLCBzZWNvbmQtbGV2ZWwsIG5lc3RlZCBhbmQgcGFzcy10aHJvdWdoDQo+dHJhbnNs
YXRpb24gZnVuY3Rpb25zLg0KPuKAoiBXaWRlbiBpbnZhbGlkYXRpb24gcXVldWUgZGVzY3JpcHRv
cnMgYW5kIHBhZ2UgcmVxdWVzdCBxdWV1ZSBkZXNjcmlwdG9ycw0KPmZyb20gMTI4IGJpdHMNCj50
byAyNTYgYml0cyBhbmQgcmVkZWZpbmVkIHBhZ2UtcmVxdWVzdCBhbmQgcGFnZS1yZXNwb25zZSBk
ZXNjcmlwdG9ycy4NCj7igKIgTGlzdGVkIGFsbCBmYXVsdCBjb25kaXRpb25zIGluIGEgdW5pZmll
ZCB0YWJsZSBhbmQgZGVzY3JpYmVkIERNQSBSZW1hcHBpbmcNCj5oYXJkd2FyZQ0KPmJlaGF2aW9y
IHVuZGVyIGVhY2ggY29uZGl0aW9uLiBBc3NpZ25lZCBuZXcgY29kZSBmb3IgZWFjaCBmYXVsdCBj
b25kaXRpb24gaW4NCj5zY2FsYWJsZW1vZGUgb3BlcmF0aW9uLg0KPuKAoiBBZGRlZCBzdXBwb3J0
IGZvciBBY2Nlc3NlZC9EaXJ0eSAoQS9EKSBiaXRzIGluIHNlY29uZC1sZXZlbCB0cmFuc2xhdGlv
bi4NCj7igKIgQWRkZWQgc3VwcG9ydCBmb3Igc3VibWl0dGluZyBjb21tYW5kcyBhbmQgcmVjZWl2
aW5nIHJlc3BvbnNlIGZyb20NCj52aXJ0dWFsIERNQQ0KPlJlbWFwcGluZyBoYXJkd2FyZS4NCj7i
gKIgQWRkZWQgYSB0YWJsZSBvbiBzbm9vcGluZyBiZWhhdmlvciBhbmQgbWVtb3J5IHR5cGUgb2Yg
aGFyZHdhcmUgYWNjZXNzDQo+dG8gdmFyaW91cw0KPnJlbWFwcGluZyBzdHJ1Y3R1cmVzIGFzIGFw
cGVuZGl4Lg0KPuKAoiBNb3ZlIFBhZ2UgUmVxdWVzdCBPdmVyZmxvdyAoUFJPKSBmYXVsdCByZXBv
cnRpbmcgZnJvbSBGYXVsdCBTdGF0dXMNCj5yZWdpc3Rlcg0KPihGU1RTX1JFRykgdG8gUGFnZSBS
ZXF1ZXN0IFN0YXR1cyByZWdpc3RlciAoUFJTX1JFRykuDQo+DQo+UmVnYXJkcy4NCj5ZaSBMaXUN
Cg==

