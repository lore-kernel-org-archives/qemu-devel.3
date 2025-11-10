Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D736FCCFA13
	for <qemu-devel@archiver.kernel.org>; Mon, 10 Nov 2025 11:55:15 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vIQU7-00024m-VZ; Mon, 10 Nov 2025 06:55:00 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <zhenzhong.duan@intel.com>)
 id 1vIQDo-0006Ju-He
 for qemu-devel@nongnu.org; Mon, 10 Nov 2025 06:38:11 -0500
Received: from mgamail.intel.com ([198.175.65.21])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <zhenzhong.duan@intel.com>)
 id 1vIQDl-0000AW-Mk
 for qemu-devel@nongnu.org; Mon, 10 Nov 2025 06:38:08 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1762774686; x=1794310686;
 h=from:to:cc:subject:date:message-id:references:
 in-reply-to:content-transfer-encoding:mime-version;
 bh=YVdBw07YjGnuCZckVEs+DdzjiN3jmY47h9vtsnoZFPE=;
 b=PGqcIa3hGY7UL9KsFLXEcTKaU5cRSVAm6D79UO9Ns4/HYt/0ZD7ZK0LA
 QDhme9XvX340NdIjjlZXfx6kRHRGllMcS/f9QVUhDLR5/+hYrg/YfCT9F
 bzhfWGWpPdLC1wMIhqso+8AH9gSYsgMDdi/U0Vg7ckqJAgyhxh96RLNvz
 Sdao+BFFeeGk9qWiOWpqIUeImhay0I4w+vNyfmSZ0BQTQQ6yVMgXsl20q
 Tx+r3vPqWqSYEDSqNFowcfXeiUCS+ulVA5eyELGuwrnlFuiKyS5Awbd/1
 xEIvMY1IYKt3+XWF83dqkXdodnh91PWH1tudVnIoRT2z+zVKbOfLM8/FD g==;
X-CSE-ConnectionGUID: hxmmaLn1So6Xh6nfbMSdEw==
X-CSE-MsgGUID: j7Q9NJJ7R2CrcQP5KVs4lA==
X-IronPort-AV: E=McAfee;i="6800,10657,11531"; a="64732495"
X-IronPort-AV: E=Sophos;i="6.17,312,1747724400"; d="scan'208";a="64732495"
Received: from fmviesa007.fm.intel.com ([10.60.135.147])
 by orvoesa113.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 10 Nov 2025 03:38:03 -0800
X-CSE-ConnectionGUID: Dchu9ppWQJyvx5frfX0C1Q==
X-CSE-MsgGUID: hUi97I6cQ0iTtbSvsLn9KQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.19,293,1754982000"; d="scan'208";a="188294791"
Received: from orsmsx901.amr.corp.intel.com ([10.22.229.23])
 by fmviesa007.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 10 Nov 2025 03:38:01 -0800
Received: from ORSMSX902.amr.corp.intel.com (10.22.229.24) by
 ORSMSX901.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.27; Mon, 10 Nov 2025 03:38:01 -0800
Received: from ORSEDG901.ED.cps.intel.com (10.7.248.11) by
 ORSMSX902.amr.corp.intel.com (10.22.229.24) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.27 via Frontend Transport; Mon, 10 Nov 2025 03:38:01 -0800
Received: from SN4PR0501CU005.outbound.protection.outlook.com (40.93.194.45)
 by edgegateway.intel.com (134.134.137.111) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.27; Mon, 10 Nov 2025 03:38:00 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=QUIB3ERSbTNhtkeiQedz8ZamGq0zz8WOhHjBsuogaOWJV0In5cvW/D54iPkuhuoeBj9H25D9D5wkuzDVCEED/9LUkdoBrwP0bjOkvZGvxaf/dUo5UixMUJQ95f2VWHsetEztgNyn7LKj5b1iC7VvYl6jERDBmLsL2DN9o9vjnaLUID70tSBc8HZ85xnw0LtOWp5J7aACQ2HrDmsX8jkBdd5BUdXk2EOpW3B1wEfc7kvj8FLi6ZfuexIR81F0q/dZumF+gZVcjQOJe3A/+zRpCn5NIJt2WVpCeTlrxQekcyCCm/K3LQSP0LL2B0h+k35kbK/cGFd7ffP43p8FyDtemg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=YVdBw07YjGnuCZckVEs+DdzjiN3jmY47h9vtsnoZFPE=;
 b=Bvm67vJPd+QtqWGKXydM7Nz4g8jrJmMz1aaNP8S0W1nmCh8QPCF1pgsktDs4EYCFl0SA/5FE6AON0lTRImKiv6H566mhnivHSwpLrKdl3q8GKjtmD6TGPB2SUMLunSfK+40/L6sHDIQjul6WJS5m8fV3dZdUCdwmoTUCvd39LcVFUOq4wO48kKvnH/hhlgdsyDfE0Grdquj492MfD9Cl1SvHjxuhhlWRcpYSPiYqROiG1kBqAxF1VWO45OeV8lgAoAMQJb8mk+6NKQFuBBtRLRqSpGBXZu80QZ9Ft6cBqLnyUNZFikfWDffUu8xGliAc3c6RzfFYDuxIhCfqau5l2A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Received: from IA3PR11MB9136.namprd11.prod.outlook.com (2603:10b6:208:574::12)
 by SJ0PR11MB5103.namprd11.prod.outlook.com (2603:10b6:a03:2d3::11)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9298.16; Mon, 10 Nov
 2025 11:37:58 +0000
Received: from IA3PR11MB9136.namprd11.prod.outlook.com
 ([fe80::604b:77a4:b1be:3f13]) by IA3PR11MB9136.namprd11.prod.outlook.com
 ([fe80::604b:77a4:b1be:3f13%7]) with mapi id 15.20.9298.015; Mon, 10 Nov 2025
 11:37:58 +0000
From: "Duan, Zhenzhong" <zhenzhong.duan@intel.com>
To: "Liu, Yi L" <yi.l.liu@intel.com>, "qemu-devel@nongnu.org"
 <qemu-devel@nongnu.org>
CC: "alex.williamson@redhat.com" <alex.williamson@redhat.com>,
 "clg@redhat.com" <clg@redhat.com>, "mst@redhat.com" <mst@redhat.com>,
 "jasowang@redhat.com" <jasowang@redhat.com>,
 "clement.mathieu--drif@eviden.com" <clement.mathieu--drif@eviden.com>,
 "eric.auger@redhat.com" <eric.auger@redhat.com>, "joao.m.martins@oracle.com"
 <joao.m.martins@oracle.com>, "avihaih@nvidia.com" <avihaih@nvidia.com>, "Hao, 
 Xudong" <xudong.hao@intel.com>, "Cabiddu, Giovanni"
 <giovanni.cabiddu@intel.com>, "Gross, Mark" <mark.gross@intel.com>, "Van De
 Ven, Arjan" <arjan.van.de.ven@intel.com>
Subject: RE: [PATCH v2 7/8] vfio/migration: Add migration blocker if VM memory
 is too large to cause unmap_bitmap failure
Thread-Topic: [PATCH v2 7/8] vfio/migration: Add migration blocker if VM
 memory is too large to cause unmap_bitmap failure
Thread-Index: AQHcPz9SC8XcAJsaGECSqxaSSWzx7bTLABYAgAEnpACAH7zFgIAABfdQ
Date: Mon, 10 Nov 2025 11:37:58 +0000
Message-ID: <IA3PR11MB913676508E781F80EE0C9A3592CEA@IA3PR11MB9136.namprd11.prod.outlook.com>
References: <20251017082234.517827-1-zhenzhong.duan@intel.com>
 <20251017082234.517827-8-zhenzhong.duan@intel.com>
 <49ac485e-4704-40a9-a574-9bcfdc1f33fd@intel.com>
 <IA3PR11MB9136B8DEF2A5D413E121F13D92F2A@IA3PR11MB9136.namprd11.prod.outlook.com>
 <a7c79221-6872-4f43-bc7a-d9b6f57248da@intel.com>
In-Reply-To: <a7c79221-6872-4f43-bc7a-d9b6f57248da@intel.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: IA3PR11MB9136:EE_|SJ0PR11MB5103:EE_
x-ms-office365-filtering-correlation-id: 395cdeeb-ce12-4c11-f7fb-08de204d9916
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0; ARA:13230040|1800799024|376014|366016|38070700021;
x-microsoft-antispam-message-info: =?utf-8?B?M1pIUWdlM0l6VnM0R2tyTWhnVEpWSGZwZ3Ayd3kyRkdzc1ZlQzNsTm5sbzdR?=
 =?utf-8?B?N0hvQ1VCeWZVVjFyT1JMdHc2OVI4bmxncklBTEpBUzhKNlpBNUlqMHNXbGh6?=
 =?utf-8?B?ZjY1WXY0TFZ5cENseTV3YitxOFExZ1g3U0hscVhzOEVxdFFRQ0pRZkd2Snhs?=
 =?utf-8?B?M0pRNUp0SmR3R3pGQ0hqcXFITmhTOFFGTzJvR1F3d29CT3hFb1p2d1NZcExH?=
 =?utf-8?B?NnkzU1hZS1NTMlNEbHhFTVNxc2dITWJJUkZ3WkF2ZWQ3R2VEcUh6Q1l3RCtX?=
 =?utf-8?B?cDBCbkphWjNJZ08yMnZBNVpiVmkwbnJxOWlsVmxZNTlFUEI4RTh1Q1h5cXR0?=
 =?utf-8?B?WHo3Y0pEblQyenZTcklQS0lneFNRazdQejEwY0dTdzg2S1dRNlZNMFBvYk9D?=
 =?utf-8?B?U0pBNmZRNzFhTkZ2cTFHd1N2dzZ3TjM2bUYyLzRJVlBrTEZGZUN3VzhEQ1ow?=
 =?utf-8?B?dXd4VUlJZnRyODFVVHVONjQ1akV5djBvOEx6Z29Ic3kvSC9nZXlxOVpqZ2JV?=
 =?utf-8?B?dlRsUUMrTHhBWVdSbkVQWEJGem4reVdPaVlDS1NhQ3ZERUwwVmJlOHV1V1RY?=
 =?utf-8?B?SElHWXBSa2xEVWF2cFRHZGFVVlZEbis3eG5JMGFDTU5HRGdpcklybERiS3py?=
 =?utf-8?B?dzNQOUVic2UyTjlBMnlsL29UbGJaZ3o0eVB5OE93T1VqZjF4WHQ5OXJjQ1FD?=
 =?utf-8?B?V0o4ZVd4dGV1eEF4Tjl1VTJacitIRGd2UXdDVnc1b0ZGbk9Ca1JMZWtDbjRj?=
 =?utf-8?B?cG1qTVRFRFp1QzFoejcxL1JiYXVDNXNqTWVsWkhoT2VYeTk0Ry95MDhGYjZl?=
 =?utf-8?B?c1RrNEw4OTc2Yy9iQWYwY0NXd3VsNzRicFppb1FwTTVFWG4wdkk5cG5qN2Vo?=
 =?utf-8?B?OHkvdGFLcVh4UW9NMkdWVkFsMzYwSXE0K0RSdDN0cUs5bHhoZm12czVwV1U1?=
 =?utf-8?B?d3dWZ1BOTGVBM0VCK1A1L1k2U0loa0RJYUwxV3hBTVZPUyt5WVJkOVlWZlJm?=
 =?utf-8?B?emZKZEdBTVpCdjZVUlo2ZUhaWC9JS3B0WmE1c0s2am8rRDA3WkIxMW8yZ3RO?=
 =?utf-8?B?YmI1TTJQOFB6YW1vQXlUOFNyWnppNjEwei9DdlluRHdHemdOVHpEQWFJS2Qz?=
 =?utf-8?B?Q1U1djZjbTQ1TEZselQ1N2I1M2VVU0pSN2JNRmpqRkFFN0N2OVpmMHc4dUk1?=
 =?utf-8?B?WEExMDhwVWRwam8xU2Qwd2xjVGVSY0pNTFBsQzJtL1p6TjFkbFI1NDdwRG4r?=
 =?utf-8?B?V09HN0dKSHpsTzVNTWxYTFJQMERmODE3TGlVNlZmOVNoZGh0Qk96emNlV3ox?=
 =?utf-8?B?TWZFcnVBQ2ZIUFNBbUpWS0tmcUEwMkhUaVpTVng5RjMwY0hNeUJ4bjFESTEr?=
 =?utf-8?B?cHR1ai9QSXh0MDJrVitOU1ZyMG45bmltRGpCQ2N1VmZRa3BTMXFZcmRjbkhW?=
 =?utf-8?B?b0dBT3NCblhkQW94MktTeU9udHZTY2YwLzNCanFYc0dZY3cxSHRHd0lDVmJ1?=
 =?utf-8?B?TG5jL0w3RzJ4Rm14YkVVcDFIc1dBaThMMTlmR0Y2QXUrZXB4VjBPb3NXdUJY?=
 =?utf-8?B?Y21YSmZTUlJyRWVrQThuYjdlQ2xld0xQc3p3WGthR3RFSHhYMlRlZVVYMlhl?=
 =?utf-8?B?TXZEZDNJOE45dVdtTUZwOUNxMUNxd1NpbU5PWnR4M2ZuQm9FUTJ4dlplNTJV?=
 =?utf-8?B?dVg4YmV4cmJhL1N0ZWtvSzFkSllMYndHdG0yODlUUFUzaFJ0cHBKRGlYbTJR?=
 =?utf-8?B?cGx5MDY4RkF4anFNU2dKYk1BSVFXcHZEMXpXeHZJMFIzT3BBWkplb2xsbTND?=
 =?utf-8?B?WmdtMGROSzM3emZjSWFKQ1RIbFVIbW9EZnBNbDF0WVlRbmExL0tVMEpzaHZU?=
 =?utf-8?B?QTEwZnhiMEpxaVZsZ3ArSVVONmZiWU83UTRVd0JScTQ4bnJ4NFQ4SGJoRmRu?=
 =?utf-8?B?dUhtUHRzWngwMVpvNXY3RXlndTNMV1NQMTh4djhMeTJkSkVOQjd1U3E2ZFB6?=
 =?utf-8?B?NnE0SHFjMWRjVTk0bWlwMDlrUjlGL2gwOWNHT2Q2SmxDRmNLaFVWWmR6R0pZ?=
 =?utf-8?Q?uZfaGx?=
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:IA3PR11MB9136.namprd11.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(1800799024)(376014)(366016)(38070700021); DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?c3R6Sm5LQmtGTk56M25tZ1NyRElsOWIwbHFjODZQSm8xS2xqNS9ML09lbnZJ?=
 =?utf-8?B?Ylkyb1hyS1hTTzlCSlprR1AzT0NQem9IOGt6eGlOa2ljU0xHdzN3NkFyQW05?=
 =?utf-8?B?bHFMR0xWaFVQcHdmK1RoZUgzVGpadkJaZ1k0YzZZYTVJdmJHOHphbWRrQk1K?=
 =?utf-8?B?M1NwYTNjN3ZQKytGZ0JPcnVmRU9RRHNMaUxHczA5MlRhbHNkM1VOU2x6QzFN?=
 =?utf-8?B?NlgybjZYWjNaMCszdkdxdkJtampYUkVEMmYreGdoOGE3a0oyZkpnR1Zyc3BO?=
 =?utf-8?B?SjArcTdjeFVmR0VhSC8vQ0hheGxOK1lwNmJJZEh1S3cyQnY4a0R1RWRJQ0Vs?=
 =?utf-8?B?aVRYdUlRTVAreE9IOGlkbWg5N3ZUYmlJMklOMUNOS2FLMjZ6czhhekZJa0Ux?=
 =?utf-8?B?b09odTJqNzNTd2pCYjg1SU9PclF6SHNVald5cnNFT25jbmVpNS9yd3JHWTgx?=
 =?utf-8?B?UlI4a2MrZXRPbk1EYmVCNno4QzVCbWlodGdOWjJ3Y01naDNEQWVFTjBWMU15?=
 =?utf-8?B?djVSVDNDTmkvYWZmN0YzUEtOS2orMUxTdjJGdHdvZDhDb2xDM3hwTHlZK0dl?=
 =?utf-8?B?YkNqREEzSjBDQnB5cWlvQ2g3Q2djS040Nno2VzVYTnJmdGJ0Zk0wUzlFNHc3?=
 =?utf-8?B?QlBUMXJBOGltMHJMNzdVWTVadi8vLzJIS3Vma2RVNmxab2JoMXlZenMyQTFu?=
 =?utf-8?B?VnFUUml4NjBJV0d0RVFSdk5FdmFqVmgrWEE2ZEJYRmx5T3EvT29BRllVNzVo?=
 =?utf-8?B?VFFnejRsS2lEUks1cUZsRUo5Qy9RU2VTM3ZJWmlwRUhLSHhobG94SHFrVjNr?=
 =?utf-8?B?c01FVnZXdDVOdVRpS29RbUd3aGFpOFNWcW52M0dwODdZOG1IK0o2eisveEJE?=
 =?utf-8?B?SWNqb2MrOTdqZ2RoU0lBSDJvVjFxZmVvVFJscjBIRnM4RWVXeWViQlZzcDBu?=
 =?utf-8?B?UzZodkpZT1M0bnRZYmZSd3R2NFE1K2pqd1RIU2oyZGIzWlUxUmlyTTRIbW9M?=
 =?utf-8?B?dWtMZjNOcms0OFRyRnVWcklOc29FdkVDZDc1QldEeDlhYVVtNUgyTEVIdFo0?=
 =?utf-8?B?cVRsbFdkNmZWazN2N0VXUHNzVCs0OG5Kd1czc2dkbHJwZUZQbDdhUUU0MjZP?=
 =?utf-8?B?YktRSlJrME5nQVRtQzZNMDl0TS9VaDBUNWxuVGs5ZjEremE4SFowWWgyc3Zi?=
 =?utf-8?B?QmcwM3o4M2dOZmc1SjBlcWtVUTRISTFyRlMwcmpYS2VITWRvYzhqZ2hnOW85?=
 =?utf-8?B?aE90Q1cwcXo3RkdJdU5Scyt3V1Y5TWxTbm9qSnZPOStIcWVWQ3VLTkllM0lu?=
 =?utf-8?B?QnRYWThiUVBJSU11YU45S3Nab1I5bXdpclJ3RVRRTVg1TzJCOUY2VWxpSThF?=
 =?utf-8?B?Q0ZHY2NaK2tITTNlZVRGeVZ0YmhlTTczcDdudGFVWnJsQnYrTU5VTXZDTE44?=
 =?utf-8?B?UUJHWnk5VnRvdUo1Q01ScjJyTEtEcURXNTg2ak1ibStsNkw1V1JqNEpTZGJs?=
 =?utf-8?B?ejdURlNSOGtXdFA4RUZsRW42TjFQWkFnMjFqTnZTQmlwd1d2RnRGTVBTODFO?=
 =?utf-8?B?NGpNeVNid3dQRk5sSElLM21QZi9TNnVrVXVMUGJMc2xoZ2VZd1gxelV4cjZx?=
 =?utf-8?B?cGYwZmpLZTd0NzJkN1Y1azdaczNjaGFQZjV0Tkx5Vmtsbng2ZUU0Y1NnRlg3?=
 =?utf-8?B?Z2MycFdWa0tNVU5taGI1bklyUThkaitvSm5sRDhTcjNCV0JpZzVLbVl1eDAy?=
 =?utf-8?B?RitQcVpYRE53eGh1UkRxeEFHb2l3SHRrdWl3Z3dWOStrY0RvL1JUZXZjd1hX?=
 =?utf-8?B?SjEzWnJrQ3NVM2JSUDRXWXhRRDNKNGk1SVBwMW9OVVQ3cXNybnVXd2NUWmty?=
 =?utf-8?B?RE9vVVltOVJ0bVc5b3F3SVFOdmNoZ1V5RWVjWnczT1UzT2xoTGlPd05WSEo0?=
 =?utf-8?B?MjJ4U21MU1cyRDFoeUdSRUZvMHBNeXYxUjUyZERpVjJOaS9Gc3hXRTJDVmxz?=
 =?utf-8?B?WWxpQnE3WTN1V2ZxcWE4OEpYYjh2cnpJNDZVMGVuSDJJWnlTMXRadm1qbU8v?=
 =?utf-8?B?QVQ0NSs1Ulg4VnhINnFiRFdyYzBMNmVjdXdTMzBkZjEzOGcyd0JEMExCUGVR?=
 =?utf-8?Q?KRmso4QYHQYGMRo7ispXf3S9N?=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: IA3PR11MB9136.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 395cdeeb-ce12-4c11-f7fb-08de204d9916
X-MS-Exchange-CrossTenant-originalarrivaltime: 10 Nov 2025 11:37:58.5600 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: wurtMTYzih7MLZ8Q7qC23oW0eGYeeW18xcfttxfwCUdcgUIwax18lukdSMzgihmba5LVf1pa0oQfrMoblg2IqjIp5c9zKzBz0oVTZD6zSmE=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ0PR11MB5103
X-OriginatorOrg: intel.com
Received-SPF: pass client-ip=198.175.65.21;
 envelope-from=zhenzhong.duan@intel.com; helo=mgamail.intel.com
X-Spam_score_int: -43
X-Spam_score: -4.4
X-Spam_bar: ----
X-Spam_report: (-4.4 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
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

DQoNCj4tLS0tLU9yaWdpbmFsIE1lc3NhZ2UtLS0tLQ0KPkZyb206IExpdSwgWWkgTCA8eWkubC5s
aXVAaW50ZWwuY29tPg0KPlN1YmplY3Q6IFJlOiBbUEFUQ0ggdjIgNy84XSB2ZmlvL21pZ3JhdGlv
bjogQWRkIG1pZ3JhdGlvbiBibG9ja2VyIGlmIFZNDQo+bWVtb3J5IGlzIHRvbyBsYXJnZSB0byBj
YXVzZSB1bm1hcF9iaXRtYXAgZmFpbHVyZQ0KPg0KPk9uIDIwMjUvMTAvMjEgMTY6MjUsIER1YW4s
IFpoZW56aG9uZyB3cm90ZToNCj4+DQo+Pg0KPj4+IC0tLS0tT3JpZ2luYWwgTWVzc2FnZS0tLS0t
DQo+Pj4gRnJvbTogTGl1LCBZaSBMIDx5aS5sLmxpdUBpbnRlbC5jb20+DQo+Pj4gU3ViamVjdDog
UmU6IFtQQVRDSCB2MiA3LzhdIHZmaW8vbWlncmF0aW9uOiBBZGQgbWlncmF0aW9uIGJsb2NrZXIg
aWYgVk0NCj4+PiBtZW1vcnkgaXMgdG9vIGxhcmdlIHRvIGNhdXNlIHVubWFwX2JpdG1hcCBmYWls
dXJlDQo+Pj4NCj4+PiBPbiAyMDI1LzEwLzE3IDE2OjIyLCBaaGVuemhvbmcgRHVhbiB3cm90ZToN
Cj4+Pj4gV2l0aCBkZWZhdWx0IGNvbmZpZywga2VybmVsIFZGSU8gdHlwZTEgZHJpdmVyIGxpbWl0
cyBkaXJ0eSBiaXRtYXAgdG8gMjU2TUINCj4+Pj4gZm9yIHVubWFwX2JpdG1hcCBpb2N0bCBzbyB0
aGUgbWF4aW11bSBndWVzdCBtZW1vcnkgcmVnaW9uIGlzIG5vIG1vcmUNCj4+PiB0aGFuDQo+Pj4+
IDhUQiBzaXplIGZvciB0aGUgaW9jdGwgdG8gc3VjY2VlZC4NCj4+Pj4NCj4+Pj4gQmUgY29uc2Vy
dmF0aXZlIGhlcmUgdG8gbGltaXQgdG90YWwgZ3Vlc3QgbWVtb3J5IHRvIDhUQiBvciBlbHNlIGFk
ZCBhDQo+Pj4+IG1pZ3JhdGlvbiBibG9ja2VyLiBJT01NVUZEIGJhY2tlbmQgZG9lc24ndCBoYXZl
IHN1Y2ggbGltaXQsIG9uZSBjYW4NCj51c2UNCj4+Pj4gSU9NTVVGRCBiYWNrZWQgZGV2aWNlIGlm
IHRoZXJlIGlzIGEgbmVlZCB0byBtaWdyYXRpb24gc3VjaCBsYXJnZSBWTS4NCj4+Pj4NCj4+Pj4g
U3VnZ2VzdGVkLWJ5OiBZaSBMaXUgPHlpLmwubGl1QGludGVsLmNvbT4NCj4+Pj4gU2lnbmVkLW9m
Zi1ieTogWmhlbnpob25nIER1YW4gPHpoZW56aG9uZy5kdWFuQGludGVsLmNvbT4NCj4+Pj4gLS0t
DQo+Pj4+ICAgIGh3L3ZmaW8vbWlncmF0aW9uLmMgfCAzNw0KPisrKysrKysrKysrKysrKysrKysr
KysrKysrKysrKysrKysrKysNCj4+Pj4gICAgMSBmaWxlIGNoYW5nZWQsIDM3IGluc2VydGlvbnMo
KykNCj4+Pj4NCj4+Pj4gZGlmZiAtLWdpdCBhL2h3L3ZmaW8vbWlncmF0aW9uLmMgYi9ody92Zmlv
L21pZ3JhdGlvbi5jDQo+Pj4+IGluZGV4IDRjMDZlM2RiOTMuLjExMDZjYTc4NTcgMTAwNjQ0DQo+
Pj4+IC0tLSBhL2h3L3ZmaW8vbWlncmF0aW9uLmMNCj4+Pj4gKysrIGIvaHcvdmZpby9taWdyYXRp
b24uYw0KPj4+PiBAQCAtMTYsNiArMTYsNyBAQA0KPj4+PiAgICAjaW5jbHVkZSA8c3lzL2lvY3Rs
Lmg+DQo+Pj4+DQo+Pj4+ICAgICNpbmNsdWRlICJzeXN0ZW0vcnVuc3RhdGUuaCINCj4+Pj4gKyNp
bmNsdWRlICJody9ib2FyZHMuaCINCj4+Pj4gICAgI2luY2x1ZGUgImh3L3ZmaW8vdmZpby1kZXZp
Y2UuaCINCj4+Pj4gICAgI2luY2x1ZGUgImh3L3ZmaW8vdmZpby1taWdyYXRpb24uaCINCj4+Pj4g
ICAgI2luY2x1ZGUgIm1pZ3JhdGlvbi9taXNjLmgiDQo+Pj4+IEBAIC0xMTUyLDYgKzExNTMsMzUg
QEAgc3RhdGljIGJvb2wgdmZpb192aW9tbXVfcHJlc2V0KFZGSU9EZXZpY2UNCj4+PiAqdmJhc2Vk
ZXYpDQo+Pj4+ICAgICAgICByZXR1cm4gdmJhc2VkZXYtPmJjb250YWluZXItPnNwYWNlLT5hcyAh
PQ0KPj4+ICZhZGRyZXNzX3NwYWNlX21lbW9yeTsNCj4+Pj4gICAgfQ0KPj4+Pg0KPj4+PiArc3Rh
dGljIGJvb2wgdmZpb19kaXJ0eV90cmFja2luZ19leGNlZWRfbGltaXQoVkZJT0RldmljZSAqdmJh
c2VkZXYpDQo+Pj4+ICt7DQo+Pj4+ICsgICAgVkZJT0NvbnRhaW5lciAqYmNvbnRhaW5lciA9IHZi
YXNlZGV2LT5iY29udGFpbmVyOw0KPj4+PiArICAgIHVpbnQ2NF90IG1heF9zaXplLCBwYWdlX3Np
emU7DQo+Pj4+ICsNCj4+Pj4gKyAgICBpZiAoIW9iamVjdF9keW5hbWljX2Nhc3QoT0JKRUNUKGJj
b250YWluZXIpLA0KPj4+IFRZUEVfVkZJT19JT01NVV9MRUdBQ1kpKSB7DQo+Pj4+ICsgICAgICAg
IHJldHVybiBmYWxzZTsNCj4+Pj4gKyAgICB9DQo+Pj4+ICsNCj4+Pj4gKyAgICBpZiAoIWJjb250
YWluZXItPmRpcnR5X3BhZ2VzX3N1cHBvcnRlZCkgew0KPj4+PiArICAgICAgICByZXR1cm4gdHJ1
ZTsNCj4+Pj4gKyAgICB9DQo+Pj4+ICsgICAgLyoNCj4+Pj4gKyAgICAgKiBWRklPIHR5cGUxIGRy
aXZlciBoYXMgYSBsaW1pdGF0aW9uIG9mIGJpdG1hcCBzaXplIG9uDQo+dW5tYXBfYml0bWFwDQo+
Pj4+ICsgICAgICogaW9jdGwoKSwgY2FsY3VsYXRlIHRoZSBsaW1pdCBhbmQgY29tcGFyZSB3aXRo
IGd1ZXN0IG1lbW9yeSBzaXplDQo+dG8NCj4+Pj4gKyAgICAgKiBjYXRjaCBkaXJ0eSB0cmFja2lu
ZyBmYWlsdXJlIGVhcmx5Lg0KPj4+PiArICAgICAqDQo+Pj4+ICsgICAgICogVGhpcyBsaW1pdCBp
cyA4VEIgd2l0aCBkZWZhdWx0IGtlcm5lbCBhbmQgUUVNVSBjb25maWcsIHdlIGFyZSBhDQo+Yml0
DQo+Pj4+ICsgICAgICogY29uc2VydmF0aXZlIGhlcmUgYXMgVk0gbWVtb3J5IGxheW91dCBtYXkg
YmUgbm9uY29uc2VjdXRpdmUNCj4+PiBvciBWTQ0KPj4+PiArICAgICAqIGNhbiBydW4gd2l0aCB2
SU9NTVUgZW5hYmxlZCBzbyB0aGUgbGltaXRhdGlvbiBjb3VsZCBiZQ0KPnJlbGF4ZWQuDQo+Pj4g
T25lDQo+Pj4+ICsgICAgICogY2FuIGFsc28gc3dpdGNoIHRvIHVzZSBJT01NVUZEIGJhY2tlbmQg
aWYgdGhlcmUgaXMgYSBuZWVkIHRvDQo+Pj4gbWlncmF0ZQ0KPj4+PiArICAgICAqIGxhcmdlIFZN
Lg0KPj4+PiArICAgICAqLw0KPj4+PiArICAgIHBhZ2Vfc2l6ZSA9IDEgPDwgY3R6NjQoYmNvbnRh
aW5lci0+ZGlydHlfcGdzaXplcyk7DQo+Pj4NCj4+PiBTaG91bGQgdXNlIHFlbXVfcmVhbF9ob3N0
X3BhZ2Vfc2l6ZSgpIGhlcmU/DQo+Pg0KPj4gaG1tLCBJIHRoaW5rIGl0J3MgaG9zdCBtbXUgcGFn
ZSBzaXplIHdoaWNoIGlzIG5vdCBhcyBhY2N1cmF0ZSBhcyB0aGUgaW9tbXUNCj5wYWdlIHNpemVz
PyBoZXJlIHdlIHdhbnQgdGhlIGlvbW11IG9uZXMuDQo+DQo+SSBzYXcgdmZpb19sZWdhY3lfcXVl
cnlfZGlydHlfYml0bWFwKCkgdXNlcyBxZW11X3JlYWxfaG9zdF9wYWdlX3NpemUoKQ0KPnRob3Vn
aCBrZXJuZWwgZW5mb3JjZXMgbWluIGlvbW11IHBhZ2Ugc2l6ZS4gU2hhbGwgd2UgbGV0DQo+cWVt
dV9yZWFsX2hvc3RfcGFnZV9zaXplKCkgdXNlIGlvbW11IHBhZ2Ugc2l6ZSBpbnN0ZWFkIG9mIGNw
dSBwYWdlDQo+c2l6ZT8NCg0KcWVtdV9yZWFsX2hvc3RfcGFnZV9zaXplKCkgaXMgdXNlZCBpbiB2
ZmlvX2xlZ2FjeV9xdWVyeV9kaXJ0eV9iaXRtYXAoKQ0KYmVjYXVzZSBwaHlzaWNhbF9tZW1vcnlf
c2V0X2RpcnR5X2xlYml0bWFwKCkgb25seSBzdXBwb3J0cyB0aGF0IHNpemUsDQpzbyB3ZSBzaG91
bGRuJ3QgY2hhbmdlIGl0Lg0KDQpiY29udGFpbmVyLT5kaXJ0eV9wZ3NpemVzIHNob3VsZCBhbHdh
eXMgY29udGFpbnMgcWVtdV9yZWFsX2hvc3RfcGFnZV9zaXplKCkNCm9yIGVsc2UgaW9jdGwoVkZJ
T19JT01NVV9ESVJUWV9QQUdFUykgd2lsbCBmYWlsLiBTbyBhYm92ZSBjb2RlIGlzIHNhbWUgZWZm
ZWN0DQphcyB1c2luZyBxZW11X3JlYWxfaG9zdF9wYWdlX3NpemUoKS4gQnV0IEkgdGhpbmsgaXQn
cyBjbGVhcmVyIGZvciByZWFkZXJzIHVzaW5nDQppb21tdSBpbmZvcm1hdGlvbiBmb3IgY2FsY3Vs
YXRpbmcgaGVyZS4NCg0KVGhhbmtzDQpaaGVuemhvbmcNCg==

