Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9EE40C3DA59
	for <qemu-devel@archiver.kernel.org>; Fri, 19 Jul 2024 03:37:58 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sUeQn-00055b-Ph; Thu, 18 Jul 2024 23:37:17 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <zhenzhong.duan@intel.com>)
 id 1sUeQm-000554-Fb
 for qemu-devel@nongnu.org; Thu, 18 Jul 2024 23:37:16 -0400
Received: from mgamail.intel.com ([198.175.65.19])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <zhenzhong.duan@intel.com>)
 id 1sUeQi-00049t-Oa
 for qemu-devel@nongnu.org; Thu, 18 Jul 2024 23:37:16 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1721360233; x=1752896233;
 h=from:to:cc:subject:date:message-id:references:
 in-reply-to:content-transfer-encoding:mime-version;
 bh=k85q7s8B8azx1sQSLpOx0NCklxnKc2Hsi8lqHKB5ksM=;
 b=TxkKSRB9AO+58+j9WUyG2J7XuB8VpFaLxJJe5lGqESanSRC/3CljQGTw
 HbTTpgCuLCThA3BnYFeyethlrbhQE/IYhrzdcpXI3YF5Ae3fWxOAwCgMx
 1KPSEU66UAmhjBqi8563ZVrKsL4pC+9wXGtEd3bunIn02latJqkOgYlB6
 CcfTFIWwRHE/bXk7ubbESUjdc+QhhZBfCEtBmPvSC4CocBVCDEJNTTpg1
 HRqqLL7l8A746Id6OZNGp+7bD0vJhO/iI2j5Urq1oufW14HJZb2oWuoUM
 iYa9Mcg1Cujr2nhLvF7Ue/hEk9iAvty7irSztyZO743qJI8y5v0GQ7ROM w==;
X-CSE-ConnectionGUID: G+Crfdh0T3GljzkNRhHgnw==
X-CSE-MsgGUID: QPS9kVLiT06IV/Ea2xxNoA==
X-IronPort-AV: E=McAfee;i="6700,10204,11137"; a="18810540"
X-IronPort-AV: E=Sophos;i="6.09,219,1716274800"; d="scan'208";a="18810540"
Received: from fmviesa009.fm.intel.com ([10.60.135.149])
 by orvoesa111.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 18 Jul 2024 20:37:10 -0700
X-CSE-ConnectionGUID: O3APCX/sQkqNuS46M1Yl6w==
X-CSE-MsgGUID: M5ITYvpPTwqF8L+GGxaidA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.09,219,1716274800"; d="scan'208";a="50964877"
Received: from orsmsx601.amr.corp.intel.com ([10.22.229.14])
 by fmviesa009.fm.intel.com with ESMTP/TLS/AES256-GCM-SHA384;
 18 Jul 2024 20:37:10 -0700
Received: from orsmsx601.amr.corp.intel.com (10.22.229.14) by
 ORSMSX601.amr.corp.intel.com (10.22.229.14) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.39; Thu, 18 Jul 2024 20:37:08 -0700
Received: from ORSEDG601.ED.cps.intel.com (10.7.248.6) by
 orsmsx601.amr.corp.intel.com (10.22.229.14) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.39 via Frontend Transport; Thu, 18 Jul 2024 20:37:08 -0700
Received: from NAM12-DM6-obe.outbound.protection.outlook.com (104.47.59.169)
 by edgegateway.intel.com (134.134.137.102) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.39; Thu, 18 Jul 2024 20:37:08 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=PNXprWCSWj6EQwkLStFEtM/3HVp6SZRkBbQMC0jL/OhFWHHV45VtESLMpU9mRZdZYvq0exYmEarMw76lpgK1axhlyUCTf/+bMvGT1XFVEHHi51Zw7VStRGPJz8pZKOSE32vFUMDTG4xEvBeoXeaYnXgODioKfKiizCgKev/NAZ3EN8+xLJJpCPesegPBXfdZJGEwcwUc6m5fzviDWj2/I7X7FzGRk4SxubkmjEQpL3cwhE3RUj3vsIlggy/7YnxjJGtQatsY9JG/o8WvYnubxO2zjkTG2gX7aZ9Wcj0Pc7FdoZJzcyyXPRCk4GtodrFClzlbQTWU7+WE2waYcRBtLQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=k85q7s8B8azx1sQSLpOx0NCklxnKc2Hsi8lqHKB5ksM=;
 b=uYCYWGOl14NPRVMBd22Cb0nl2jFo9CpgaGOBJlLigNhMyXdq7IUzxprQpPDpSAN57sKIua7tlO3fBcwjGsUhaAhLcKABmldjU8bgAc0FZ7Lg9mobMWfuG1gjDy0wKB5Lnc6D4Q+uUkkQVEhYsqWUmu70rSgplOaq4rurvnGBMdZcn7fHlBZMjJTXkKZafUzJ7Y64y++BImbxG0boOAPcQLwEXbXE8NeXJ5TdMV7Ib27+vjRqtZT+IaY2HmC7HSp277gI9Eiu67+0EUc/NBwAPjaLBKsZWOWfWCHss3K7a1Coztmz9ZsvWF5Pqnh9R12xbr7jElVcduIBLRsV680/BQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Received: from SJ0PR11MB6744.namprd11.prod.outlook.com (2603:10b6:a03:47d::10)
 by SJ0PR11MB4973.namprd11.prod.outlook.com (2603:10b6:a03:2de::5)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7784.16; Fri, 19 Jul
 2024 03:37:06 +0000
Received: from SJ0PR11MB6744.namprd11.prod.outlook.com
 ([fe80::fe49:d628:48b1:6091]) by SJ0PR11MB6744.namprd11.prod.outlook.com
 ([fe80::fe49:d628:48b1:6091%7]) with mapi id 15.20.7784.016; Fri, 19 Jul 2024
 03:37:06 +0000
From: "Duan, Zhenzhong" <zhenzhong.duan@intel.com>
To: "Liu, Yi L" <yi.l.liu@intel.com>, CLEMENT MATHIEU--DRIF
 <clement.mathieu--drif@eviden.com>, "qemu-devel@nongnu.org"
 <qemu-devel@nongnu.org>
CC: "alex.williamson@redhat.com" <alex.williamson@redhat.com>,
 "clg@redhat.com" <clg@redhat.com>, "eric.auger@redhat.com"
 <eric.auger@redhat.com>, "mst@redhat.com" <mst@redhat.com>,
 "peterx@redhat.com" <peterx@redhat.com>, "jasowang@redhat.com"
 <jasowang@redhat.com>, "jgg@nvidia.com" <jgg@nvidia.com>,
 "nicolinc@nvidia.com" <nicolinc@nvidia.com>, "joao.m.martins@oracle.com"
 <joao.m.martins@oracle.com>, "Tian, Kevin" <kevin.tian@intel.com>, "Peng,
 Chao P" <chao.p.peng@intel.com>, Paolo Bonzini <pbonzini@redhat.com>, Richard
 Henderson <richard.henderson@linaro.org>, Eduardo Habkost
 <eduardo@habkost.net>, Marcel Apfelbaum <marcel.apfelbaum@gmail.com>
Subject: RE: [PATCH v1 03/17] intel_iommu: Add a placeholder variable for
 scalable modern mode
Thread-Topic: [PATCH v1 03/17] intel_iommu: Add a placeholder variable for
 scalable modern mode
Thread-Index: AQHa2OtCWmQl4pZpx0e1R3JC4utGS7H8MJAAgAEmyHCAAAyqAIAAAulw
Date: Fri, 19 Jul 2024 03:37:06 +0000
Message-ID: <SJ0PR11MB6744F4CAEA5A9627D79AFE2092AD2@SJ0PR11MB6744.namprd11.prod.outlook.com>
References: <20240718081636.879544-1-zhenzhong.duan@intel.com>
 <20240718081636.879544-4-zhenzhong.duan@intel.com>
 <e41c8b79-1b86-42de-b1d5-dce7ed29d422@eviden.com>
 <SJ0PR11MB6744F86F44C2C32C4B79C80A92AD2@SJ0PR11MB6744.namprd11.prod.outlook.com>
 <9c9dba22-df29-4121-8126-4707084b891b@intel.com>
In-Reply-To: <9c9dba22-df29-4121-8126-4707084b891b@intel.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: SJ0PR11MB6744:EE_|SJ0PR11MB4973:EE_
x-ms-office365-filtering-correlation-id: d70ea0ab-c99d-4288-77d4-08dca7a40fd4
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
 ARA:13230040|1800799024|7416014|366016|376014|38070700018; 
x-microsoft-antispam-message-info: =?utf-8?B?ZE9GVDN0eWpRL01HbWpXR1F6Y25IU0NPUnl4bHVmL2djQWVHRmxZSDltL2tj?=
 =?utf-8?B?a01DbENjQXhWVXZZSFNkWkcxSzFXZDRSbHdwOXJnR1pHZmlaMHNqclpJRHFx?=
 =?utf-8?B?cXRMcFQ1dVZHOFZ2TmJMaWRIcnhlTFppOFl2UkhvaEJhdENiRHZDcmpmM25U?=
 =?utf-8?B?dXk3NDJjL1J1VGtxTkRISitQN3QvMll4UmxVcW5ON2dCTFhvVjJqdFZ2Rk5T?=
 =?utf-8?B?Z29EcjkxblVtaCtPekNGeGw3eWhtczJLRmhkcGxKeDE5RlpmM3M2bElzbzBW?=
 =?utf-8?B?MmVyRnhtbURiZnZ2QmNsUnV4VW5sWHExSWdEeE5zRGJ0UlFaYk15VGtUMlgy?=
 =?utf-8?B?WFYzbkFkOVUwd0cwKzdQa0ovV0xha2dqR0d2TElNN3AxbGtBMlJVV1ovTjFX?=
 =?utf-8?B?TkNiS0JYWHRXR3M3UUV2cHc4bmtwdVkzeUlERndqbGV2STFhdFZYQzZGZS9M?=
 =?utf-8?B?TktqTnZOWitmc1RzY0x4U0JyazJmNXlQTHUydUtBODVyNHpVcGQ1YmQvcFF2?=
 =?utf-8?B?Qk02aUdTOW5tQjgvYlJGc05tSlZOM0tvelRqbWNoRi9jbmxQVVYxUXl0b0VM?=
 =?utf-8?B?bWhNSkV4a2kwWkhZUEE2SHM1bXFmVU5OZlVFQjZ1QXIrWWxRWVErTVQvZGRh?=
 =?utf-8?B?cEdNMWgvN1FxWUJKWXNqM0ZmeFcwZkdOTGU0UVNaTThrdXk4eGlMaENxaUt6?=
 =?utf-8?B?WUlPWXpwUDJHWGdhUUR3TnV1RmN6QjJqMG5pay8vV1NQQmdkd2RiT1EvcXdK?=
 =?utf-8?B?TXNVdnNrRmhOYlk1MjR5bnhTUEtUOUsvbWdPTnJJL0tjdURxU2N1ejFQdnE0?=
 =?utf-8?B?VlNTamVzOXhDdFVsRTVhOERLYnQ3SmozMmdkaWhzemlNdmdGOWRaUTNHZU8x?=
 =?utf-8?B?TG12anR3MVJNUklrU0l1U3dmLzB0Vm51MzBCdlh0dUMyQlhoTUpnVXBSNits?=
 =?utf-8?B?eEdxSVA5VXEzai85ajEva0MrS05HdVBUeGg0eW12TmtZczdNRzB5dlNhZlU2?=
 =?utf-8?B?b0FYTjl4NzVDYkQvSWpMS1NqY254OXhZb1NneEhEaURqWUoxM2tHZVY4dHo3?=
 =?utf-8?B?NkIxeU1WU2xndkxVbVRjNWpPZGhGcm5JTkkxM1VFOWVwY05EWU9SVXNuMldp?=
 =?utf-8?B?UTJGYUcyTG9LTVp3TFk2MXROd2VscnJHdEpGUTNMVDh3c1lQT2JXblVERFdQ?=
 =?utf-8?B?ZzhxTnZsUDdIdlNXczl0OEIxYVJRSGM3djJCVlhkREpjTVp3RWRXWG14djZY?=
 =?utf-8?B?d0F3anp0NmVGRzBDOTFWd010cVlDM1JCbEkvOSswL1RFZW9wQ0hiU09JS0Va?=
 =?utf-8?B?SDg1ZG9haVRiRGNNWXlGNXNXVlZMeHBhcVVQZy9RQzMvcWZJKzNRK2s2ejBn?=
 =?utf-8?B?VVhGQjROS2J1N25rOVJlTkZCMk1wRFBsMUhBazJEb21jOGFvbEo2M1drbXFR?=
 =?utf-8?B?cDIvaWdwaCtyMFdaMWlKdTYzeGY5b21Nb1dZcUJ2NGRFU3EzV2p0aFk3MHhy?=
 =?utf-8?B?Q25CTk15UGtvMVp3TlF6NndVMTJaVUQyc1NzM1lpY0VpRU1JSTMvbGwvRVhh?=
 =?utf-8?B?bVlhTXNLVXBkNm1qNnJRQzlrUHA1YWhabkdCMVdXaE4xZkpCTGxyWG5NY1Mr?=
 =?utf-8?B?cHg0d01kYXNWS3Jrbmxla0xyUlJkQzlsNXh3Rmc2NHdjdExNd3ExUk9MaFVj?=
 =?utf-8?B?WjV0N3U2bDZwUldGWkpIMmRwNE54TElsRml1eWdzYXZiZXhrbEJscGhKL0hF?=
 =?utf-8?B?TjErOXRDSHdPMXhsNm5ScGpIT3FxNEk0YzR4Zm1Pb2tzUjM4eEoxOHpnaFVt?=
 =?utf-8?B?WFo2M2N4L2FpcHdvNk9GWXhNYjlUSmRMaHVMYUpORHU3eXN2RDhVYlpSQUQz?=
 =?utf-8?B?RHJmcDhDeTNrSmVFcXIwNmxxN1diWC9yVEFwdFk0UjNWYUE9PQ==?=
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:SJ0PR11MB6744.namprd11.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(1800799024)(7416014)(366016)(376014)(38070700018); DIR:OUT;
 SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?b2ppWEtrbm1OUnU5ZGVtZWQzWGM3NjlrMXExakNYMkJVd29JcU1QNkc5NzBF?=
 =?utf-8?B?R3pBQnltUER0WVk1UW5Ud0M3RUZWUW1LZk1kbVo0U2lDR1dQVk4rUEx0dFh3?=
 =?utf-8?B?eENlNGdUY0xmQ0xIVzFuQ3ZDZUUwOWNwM3pmN0V1eHBQZXpUcmcyT1pzU0ZV?=
 =?utf-8?B?NjFTVEFWYWJ6ZTh0Y0ovempSV2NYRjliL1l6VnR5WkxUdkNLR0I5aXVnZDJ6?=
 =?utf-8?B?NCtBbkFiWHFqeGltSXJCMUd0RS9jbmZFUzMxajFWSGphNlFIUlc4OTVXbGpJ?=
 =?utf-8?B?Rk01dmVaMDJlNDlIS3J3Z0hGNHg1b1ZRaUhIM3BPdThBVXhwWldjdnNwT1JK?=
 =?utf-8?B?Q2t1YTZiT3BpbE1Qc1pBQUtyQkZHQWNrM01oTGtSYU9CWVlWZUVTaWErQ0Q1?=
 =?utf-8?B?cFlvMW9wb2xDd1Y3RjlSTm9pVDJ2bjZ6Z1N5bDMzMnVVRExBemM0N2JqajdI?=
 =?utf-8?B?VGZxZ2hZa0oxYi9GZjhQbEw5RjIyM3NpdmJoRzQ4QVJMSWg0OHNpS1BBeDZD?=
 =?utf-8?B?SkxVNnJUL1JEbU5wWnZ4RWxFSW54Vm93NEdKNVlDVjl0QTRaNjdObmJVbzdC?=
 =?utf-8?B?Yk9oVjB2czJnc1lQeEZNcHl2SHZ3MG1iZEVMRDR2ckpKaWY0MWE5czU2NzR5?=
 =?utf-8?B?Z2JPR1NrR3lySXF4TVhSbVhSbis2ZFRXbXhmODIwdGR1dnRjLzFjTzJmZlZr?=
 =?utf-8?B?TnJSYjczemR6U2FXYkFRZ0xjeUw0aTRMT3JrMTlqS0UvRDcyaEtRRnp1Q0Zo?=
 =?utf-8?B?R3gxems0ZGc3NXVlOXM3REdwZHpQek13TjNQbWJSM3VPaXJtV1NiblR4cFdV?=
 =?utf-8?B?VFZhZGpQRGN2ZDduWU9VTHpocVRNUGFXdUpNN2o1M2dTczVRRUZNUTNJVElG?=
 =?utf-8?B?T2orTmRSdFpXdnZ0c0dLQW5SeEltNXNieFIyS2ZaNzk4ZENFeEtXWHRzTjJI?=
 =?utf-8?B?QnIrNDVYZzdvMjIybWVqRTJGMS9nM2N2Wnp2eUlCZlFja0dCUUY3cjQ5Y25Q?=
 =?utf-8?B?aUMxYUprYkwrNDQxS3JhUzJEeFJZSmhnLzNTMmRqak1KL1VxSmNXTmVQby9Q?=
 =?utf-8?B?TjBQVnAwM2FyS05WQkI1QzZ0OUxyT05ZOWN1V3ZzS0FXbThKb2l3VVlKWVRi?=
 =?utf-8?B?YkJ3Tk9MR05peTY5a0YxVXZFMlllRWZ3NEF2dTlEMHhVNGh2dC9LR01Ta20v?=
 =?utf-8?B?c1N6dG44aWM2M2kzYkkrWUNNM2J3S3JJL0Yvekh3dkdMQjV6Z2M5ZWVtdE1E?=
 =?utf-8?B?WnprNVNuTGZqOFBQTmYwRFpyVHJ2RFBhVFlNendVNUhRYmZma1lwcWhlTXZv?=
 =?utf-8?B?T1UwOTd6S0xJTmlpVUtrVzR0SUlaMkJhdTZIajRPMHZTVFVLejY5NnpoQ2ZR?=
 =?utf-8?B?Z1F6dUJyNUNRQzRERUxvRGlmTllOdDllOCtpQzd1emVpVUg5SklHL2pVRFJ3?=
 =?utf-8?B?VFFtOHFjTDdFLzlKREZRMzQ1WEN6Qm1WY2dHRHU0RXBnQWoybUh6TWpkTkFR?=
 =?utf-8?B?V2h5RHhVSkNBdVJFRUtNM3RTT0FZaXVMUTB5NSsyYm94OHk0UUlqVVdsMGtG?=
 =?utf-8?B?UWlYUE03QXFrVSsvQzRNRnNiSHRBTk9tTlBMYkQ1MmtGSENZWG93Nk5mWmxW?=
 =?utf-8?B?TUVydk9DcUw2VnJCUWtDOTU4d0lSa0dMa2Z5N1RLcW9wRVdTL2xJV0JRWVYv?=
 =?utf-8?B?UU9NZ0FTNXVRS0FjMTVVS3krWXZGUTZOTHUySWgyaTN5cW81MEFLNzBKM3lj?=
 =?utf-8?B?WjZ1L2p5OWNZdERWRWVWY3RhcG5RWFUyTlkycXp6SWh1MGh2UXFVK1dIcFZp?=
 =?utf-8?B?UFZhQjZLKzg4SlJ2UU1RRjJYU2RZbDdvdGllS2dCc08rK2NkTE0vc2MxVmU2?=
 =?utf-8?B?aUloQWVCOUZWNUFzRldnbFVrUFhzRzNDbVFlQzlwcS9IbDZncHVKcll2UnpD?=
 =?utf-8?B?aVlXWHVLQ2JWT3dGSjZRMzIzRWJtdnMyV3ZJTnMrZkR6SWVYZ2l4N1ozYjJH?=
 =?utf-8?B?dE9wOHJYWVBSVnhtRWVTZkFNTGZNaGRGU2x1MlZkdHduSnZqbkI5cC9YWUUz?=
 =?utf-8?B?NDlFMktGQU14NUlrdktJaC9OMTlkTFExQldKNGpJWjZPUU83ZHNzMWFadVh0?=
 =?utf-8?Q?I3FqZ3tpg/lty3h0EspEKeoL0?=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: SJ0PR11MB6744.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: d70ea0ab-c99d-4288-77d4-08dca7a40fd4
X-MS-Exchange-CrossTenant-originalarrivaltime: 19 Jul 2024 03:37:06.1806 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: ai/KrHs5bR5cil074861deLd+QoIeWlTbAu2g3JJ91+LjrZoED+d5+ofoiNTY7jb/vIjyEt+S3BMzJ7ZQ04YIaPQeMvhVHv8OSKnit6cWU4=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ0PR11MB4973
X-OriginatorOrg: intel.com
Received-SPF: pass client-ip=198.175.65.19;
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

DQoNCj4tLS0tLU9yaWdpbmFsIE1lc3NhZ2UtLS0tLQ0KPkZyb206IExpdSwgWWkgTCA8eWkubC5s
aXVAaW50ZWwuY29tPg0KPlN1YmplY3Q6IFJlOiBbUEFUQ0ggdjEgMDMvMTddIGludGVsX2lvbW11
OiBBZGQgYSBwbGFjZWhvbGRlciB2YXJpYWJsZSBmb3INCj5zY2FsYWJsZSBtb2Rlcm4gbW9kZQ0K
Pg0KPk9uIDIwMjQvNy8xOSAxMDo0NywgRHVhbiwgWmhlbnpob25nIHdyb3RlOg0KPj4NCj4+DQo+
Pj4gLS0tLS1PcmlnaW5hbCBNZXNzYWdlLS0tLS0NCj4+PiBGcm9tOiBDTEVNRU5UIE1BVEhJRVUt
LURSSUYgPGNsZW1lbnQubWF0aGlldS0tZHJpZkBldmlkZW4uY29tPg0KPj4+IFN1YmplY3Q6IFJl
OiBbUEFUQ0ggdjEgMDMvMTddIGludGVsX2lvbW11OiBBZGQgYSBwbGFjZWhvbGRlciB2YXJpYWJs
ZQ0KPmZvcg0KPj4+IHNjYWxhYmxlIG1vZGVybiBtb2RlDQo+Pj4NCj4+Pg0KPj4+DQo+Pj4gT24g
MTgvMDcvMjAyNCAxMDoxNiwgWmhlbnpob25nIER1YW4gd3JvdGU6DQo+Pj4+IENhdXRpb246IEV4
dGVybmFsIGVtYWlsLiBEbyBub3Qgb3BlbiBhdHRhY2htZW50cyBvciBjbGljayBsaW5rcywgdW5s
ZXNzDQo+dGhpcw0KPj4+IGVtYWlsIGNvbWVzIGZyb20gYSBrbm93biBzZW5kZXIgYW5kIHlvdSBr
bm93IHRoZSBjb250ZW50IGlzIHNhZmUuDQo+Pj4+DQo+Pj4+DQo+Pj4+IEFkZCBhbiBuZXcgZWxl
bWVudCBzY2FsYWJsZV9tb2RlIGluIEludGVsSU9NTVVTdGF0ZSB0byBtYXJrDQo+c2NhbGFibGUN
Cj4+Pj4gbW9kZXJuIG1vZGUsIHRoaXMgZWxlbWVudCB3aWxsIGJlIGV4cG9zZWQgYXMgYW4gaW50
ZWxfaW9tbXUgcHJvcGVydHkNCj4+Pj4gZmluYWxseS4NCj4+Pj4NCj4+Pj4gRm9yIG5vdywgaXQn
cyBvbmx5IGEgcGxhY2VoaG9sZGVyIGFuZCB1c2VkIGZvciBjYXAvZWNhcCBpbml0aWFsaXphdGlv
biwNCj4+Pj4gY29tcGF0aWJpbGl0eSBjaGVjayBhbmQgYmxvY2sgaG9zdCBkZXZpY2UgcGFzc3Ro
cm91Z2ggdW50aWwgbmVzdGluZw0KPj4+PiBpcyBzdXBwb3J0ZWQuDQo+Pj4+DQo+Pj4+IFNpZ25l
ZC1vZmYtYnk6IFlpIExpdSA8eWkubC5saXVAaW50ZWwuY29tPg0KPj4+PiBTaWduZWQtb2ZmLWJ5
OiBaaGVuemhvbmcgRHVhbiA8emhlbnpob25nLmR1YW5AaW50ZWwuY29tPg0KPj4+PiAtLS0NCj4+
Pj4gICAgaHcvaTM4Ni9pbnRlbF9pb21tdV9pbnRlcm5hbC5oIHwgIDIgKysNCj4+Pj4gICAgaW5j
bHVkZS9ody9pMzg2L2ludGVsX2lvbW11LmggIHwgIDEgKw0KPj4+PiAgICBody9pMzg2L2ludGVs
X2lvbW11LmMgICAgICAgICAgfCAzNCArKysrKysrKysrKysrKysrKysrKysrKy0tLS0tLS0tLQ0K
Pi0tDQo+Pj4+ICAgIDMgZmlsZXMgY2hhbmdlZCwgMjYgaW5zZXJ0aW9ucygrKSwgMTEgZGVsZXRp
b25zKC0pDQo+Pj4+DQo+Pj4+IGRpZmYgLS1naXQgYS9ody9pMzg2L2ludGVsX2lvbW11X2ludGVy
bmFsLmgNCj4+PiBiL2h3L2kzODYvaW50ZWxfaW9tbXVfaW50ZXJuYWwuaA0KPj4+PiBpbmRleCBj
MGNhN2IzNzJmLi40ZTAzMzFjYWJhIDEwMDY0NA0KPj4+PiAtLS0gYS9ody9pMzg2L2ludGVsX2lv
bW11X2ludGVybmFsLmgNCj4+Pj4gKysrIGIvaHcvaTM4Ni9pbnRlbF9pb21tdV9pbnRlcm5hbC5o
DQo+Pj4+IEBAIC0xOTUsNiArMTk1LDcgQEANCj4+Pj4gICAgI2RlZmluZSBWVERfRUNBUF9QQVNJ
RCAgICAgICAgICAgICAgKDFVTEwgPDwgNDApDQo+Pj4+ICAgICNkZWZpbmUgVlREX0VDQVBfU01U
UyAgICAgICAgICAgICAgICgxVUxMIDw8IDQzKQ0KPj4+PiAgICAjZGVmaW5lIFZURF9FQ0FQX1NM
VFMgICAgICAgICAgICAgICAoMVVMTCA8PCA0NikNCj4+Pj4gKyNkZWZpbmUgVlREX0VDQVBfRkxU
UyAgICAgICAgICAgICAgICgxVUxMIDw8IDQ3KQ0KPj4+Pg0KPj4+PiAgICAvKiBDQVBfUkVHICov
DQo+Pj4+ICAgIC8qIChvZmZzZXQgPj4gNCkgPDwgMjQgKi8NCj4+Pj4gQEAgLTIxMSw2ICsyMTIs
NyBAQA0KPj4+PiAgICAjZGVmaW5lIFZURF9DQVBfU0xMUFMgICAgICAgICAgICAgICAoKDFVTEwg
PDwgMzQpIHwgKDFVTEwgPDwgMzUpKQ0KPj4+PiAgICAjZGVmaW5lIFZURF9DQVBfRFJBSU5fV1JJ
VEUgICAgICAgICAoMVVMTCA8PCA1NCkNCj4+Pj4gICAgI2RlZmluZSBWVERfQ0FQX0RSQUlOX1JF
QUQgICAgICAgICAgKDFVTEwgPDwgNTUpDQo+Pj4+ICsjZGVmaW5lIFZURF9DQVBfRlMxR1AgICAg
ICAgICAgICAgICAoMVVMTCA8PCA1NikNCj4+Pj4gICAgI2RlZmluZSBWVERfQ0FQX0RSQUlOICAg
ICAgICAgICAgICAgKFZURF9DQVBfRFJBSU5fUkVBRCB8DQo+Pj4gVlREX0NBUF9EUkFJTl9XUklU
RSkNCj4+Pj4gICAgI2RlZmluZSBWVERfQ0FQX0NNICAgICAgICAgICAgICAgICAgKDFVTEwgPDwg
NykNCj4+Pj4gICAgI2RlZmluZSBWVERfUEFTSURfSURfU0hJRlQgICAgICAgICAgMjANCj4+Pj4g
ZGlmZiAtLWdpdCBhL2luY2x1ZGUvaHcvaTM4Ni9pbnRlbF9pb21tdS5oDQo+Pj4gYi9pbmNsdWRl
L2h3L2kzODYvaW50ZWxfaW9tbXUuaA0KPj4+PiBpbmRleCAxZWIwNWMyOWZjLi43ODhlZDQyNDc3
IDEwMDY0NA0KPj4+PiAtLS0gYS9pbmNsdWRlL2h3L2kzODYvaW50ZWxfaW9tbXUuaA0KPj4+PiAr
KysgYi9pbmNsdWRlL2h3L2kzODYvaW50ZWxfaW9tbXUuaA0KPj4+PiBAQCAtMjYyLDYgKzI2Miw3
IEBAIHN0cnVjdCBJbnRlbElPTU1VU3RhdGUgew0KPj4+Pg0KPj4+PiAgICAgICAgYm9vbCBjYWNo
aW5nX21vZGU7ICAgICAgICAgICAgICAvKiBSTyAtIGlzIGNhcCBDTSBlbmFibGVkPyAqLw0KPj4+
PiAgICAgICAgYm9vbCBzY2FsYWJsZV9tb2RlOyAgICAgICAgICAgICAvKiBSTyAtIGlzIFNjYWxh
YmxlIE1vZGUgc3VwcG9ydGVkPyAqLw0KPj4+PiArICAgIGJvb2wgc2NhbGFibGVfbW9kZXJuOyAg
ICAgICAgICAgLyogUk8gLSBpcyBtb2Rlcm4gU00gc3VwcG9ydGVkPyAqLw0KPj4+PiAgICAgICAg
Ym9vbCBzbm9vcF9jb250cm9sOyAgICAgICAgICAgICAvKiBSTyAtIGlzIFNOUCBmaWxlZCBzdXBw
b3J0ZWQ/ICovDQo+Pj4+DQo+Pj4+ICAgICAgICBkbWFfYWRkcl90IHJvb3Q7ICAgICAgICAgICAg
ICAgIC8qIEN1cnJlbnQgcm9vdCB0YWJsZSBwb2ludGVyICovDQo+Pj4+IGRpZmYgLS1naXQgYS9o
dy9pMzg2L2ludGVsX2lvbW11LmMgYi9ody9pMzg2L2ludGVsX2lvbW11LmMNCj4+Pj4gaW5kZXgg
MWNmZjhiMDBhZS4uNDBjYmQ0YTBmNCAxMDA2NDQNCj4+Pj4gLS0tIGEvaHcvaTM4Ni9pbnRlbF9p
b21tdS5jDQo+Pj4+ICsrKyBiL2h3L2kzODYvaW50ZWxfaW9tbXUuYw0KPj4+PiBAQCAtNzU1LDE2
ICs3NTUsMjAgQEAgc3RhdGljIGlubGluZSBib29sDQo+Pj4gdnRkX2lzX2xldmVsX3N1cHBvcnRl
ZChJbnRlbElPTU1VU3RhdGUgKnMsIHVpbnQzMl90IGxldmVsKQ0KPj4+PiAgICB9DQo+Pj4+DQo+
Pj4+ICAgIC8qIFJldHVybiB0cnVlIGlmIGNoZWNrIHBhc3NlZCwgb3RoZXJ3aXNlIGZhbHNlICov
DQo+Pj4+IC1zdGF0aWMgaW5saW5lIGJvb2wgdnRkX3BlX3R5cGVfY2hlY2soWDg2SU9NTVVTdGF0
ZSAqeDg2X2lvbW11LA0KPj4+PiAtICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAg
IFZURFBBU0lERW50cnkgKnBlKQ0KPj4+PiArc3RhdGljIGlubGluZSBib29sIHZ0ZF9wZV90eXBl
X2NoZWNrKEludGVsSU9NTVVTdGF0ZSAqcywNCj4+PiBWVERQQVNJREVudHJ5ICpwZSkNCj4+Pj4g
ICAgew0KPj4+IFdoYXQgYWJvdXQgdXNpbmcgdGhlIGNhcC9lY2FwIHJlZ2lzdGVycyB0byBrbm93
IGlmIHRoZSB0cmFuc2xhdGlvbiB0eXBlcw0KPj4+IGFyZSBzdXBwb3J0ZWQgb3Igbm90Lg0KPj4+
IE90aGVyd2lzZSwgd2UgY291bGQgYWRkIGEgY29tbWVudCB0byBleHBsYWluIHdoeSB3ZSBleHBl
Y3QNCj4+PiBzLT5zY2FsYWJsZV9tb2Rlcm4gdG8gZ2l2ZSB1cyBlbm91Z2ggaW5mb3JtYXRpb24u
DQo+Pg0KPj4gV2hhdCBhYm91dCBiZWxvdzoNCj4+DQo+PiAvKg0KPj4gICAqVlREX0VDQVBfRkxU
UyBpbiBlY2FwIGlzIHNldCBpZiBzLT5zY2FsYWJsZV9tb2Rlcm4gaXMgdHJ1ZSwgb3IgZWxzZQ0K
PlZURF9FQ0FQX1NMVFMgY2FuIGJlIHNldCBvciBub3QgZGVwZW5kaW5nIG9uIHMtPnNjYWxhYmxl
X21vZGUuDQo+PiAgICpTbyBpdCdzIHNpbXBsZXIgdG8gY2hlY2sgcy0+c2NhbGFibGVfbW9kZXJu
IGRpcmVjdGx5IGZvciBhIFBBU0lEIGVudHJ5DQo+dHlwZSBpbnN0ZWFkIGVjYXAgYml0cy4NCj4+
ICAgKi8NCj4NCj5TaW5jZSB0aGlzIGhlbHBlciBpcyBmb3IgcGFzaWQgZW50cnkgY2hlY2ssIHNv
IHlvdSBjYW4ganVzdCByZXR1cm4gZmFsc2UNCj5pZiB0aGUgcGUncyBQR1RUIGlzIFNTLW9ubHku
DQoNCkl0IGRlcGVuZHMgb24gd2hpY2ggc2NhbGFibGUgbW9kZSBpcyBjaG9zZWQuDQpJbiBzY2Fs
YWJsZSBsZWdhY3kgbW9kZSwgUEdUVCBpcyBTUy1vbmx5IGFuZCB3ZSBzaG91bGQgcmV0dXJuIHRy
dWUuDQoNCj4NCj5JdCBtaWdodCBtYWtlIG1vcmUgc2Vuc2UgdG8gY2hlY2sgdGhlIGVjYXAvY2Fw
IGhlcmUgYXMgYW55aG93IHRoZQ0KPmNhcGFiaWxpdHkgaXMgbGlzdGVkIGluIGVjYXAvY2FwLiBU
aGlzIG1heSBhbHNvIGJyaW5nIHVzIHNvbWUgY29udmVuaWVuY2UuDQo+DQo+U2F5IGluIHRoZSBm
dXR1cmUsIGlmIHdlIHdhbnQgdG8gYWRkIGEgbmV3IG1vZGUgKGUuZy4gc2NhbGFibGUgbW9kZSAy
LjApDQo+dGhhdCBzdXBwb3J0cyBib3RoIEZTIGFuZCBTUyBmb3IgZ3Vlc3QsIHdlIG1heSBuZWVk
IHRvIHVwZGF0ZSB0aGlzIGhlbHBlcg0KPmFzIHdlbGwgaWYgd2UgY2hlY2sgdGhlIHNjYWxhYmxl
X21vZGVybi4gQnV0IGlmIHdlIGNoZWNrIHRoZSBlY2FwL2NhcCwgdGhlbg0KPnRoZSBmdXR1cmUg
Y2hhbmdlIGp1c3QgbmVlZHMgdG8gY29udHJvbCB0aGUgZWNhcC9jYXAgc2V0dGluZyBhdCB0aGUN
Cj5iZWdpbm5pbmcgb2YgdGhlIHZJT01NVSBpbml0LiBUbyBrZWVwIHRoZSBjb2RlIGFsaWduZWQs
IHlvdSBtYXkgbmVlZCB0bw0KPmNoZWNrIGVjYXAuUFQgYml0IGZvciBWVERfU01fUEFTSURfRU5U
UllfUFQuIDopDQoNCk9LLCB3aWxsIGJlIGxpa2UgYmVsb3c6DQoNCi0tLSBhL2h3L2kzODYvaW50
ZWxfaW9tbXUuYw0KKysrIGIvaHcvaTM4Ni9pbnRlbF9pb21tdS5jDQpAQCAtODI2LDE0ICs4MjYs
MTQgQEAgc3RhdGljIGlubGluZSBib29sIHZ0ZF9wZV90eXBlX2NoZWNrKEludGVsSU9NTVVTdGF0
ZSAqcywgVlREUEFTSURFbnRyeSAqcGUpDQoNCiAgICAgc3dpdGNoIChWVERfUEVfR0VUX1RZUEUo
cGUpKSB7DQogICAgIGNhc2UgVlREX1NNX1BBU0lEX0VOVFJZX0ZMVDoNCi0gICAgICAgIHJldHVy
biBzLT5zY2FsYWJsZV9tb2Rlcm47DQorICAgICAgICByZXR1cm4gISEocy0+ZWNhcCAmIFZURF9F
Q0FQX0ZMVFMpOw0KICAgICBjYXNlIFZURF9TTV9QQVNJRF9FTlRSWV9TTFQ6DQotICAgICAgICBy
ZXR1cm4gIXMtPnNjYWxhYmxlX21vZGVybjsNCisgICAgICAgIHJldHVybiAhIShzLT5lY2FwICYg
VlREX0VDQVBfRkxUUykgfHwgIShzLT5lY2FwICYgVlREX0VDQVBfU01UUyk7DQogICAgIGNhc2Ug
VlREX1NNX1BBU0lEX0VOVFJZX05FU1RFRDoNCiAgICAgICAgIC8qIE5vdCBzdXBwb3J0IE5FU1RF
RCBwYWdlIHRhYmxlIHR5cGUgeWV0ICovDQogICAgICAgICByZXR1cm4gZmFsc2U7DQogICAgIGNh
c2UgVlREX1NNX1BBU0lEX0VOVFJZX1BUOg0KLSAgICAgICAgcmV0dXJuIHg4Nl9pb21tdS0+cHRf
c3VwcG9ydGVkOw0KKyAgICAgICAgcmV0dXJuICEhKHMtPmVjYXAgJiBWVERfRUNBUF9QVCk7DQog
ICAgIGRlZmF1bHQ6DQogICAgICAgICAvKiBVbmtub3duIHR5cGUgKi8NCiAgICAgICAgIHJldHVy
biBmYWxzZTsNCg0KVGhhbmtzDQpaaGVuemhvbmcNCg==

