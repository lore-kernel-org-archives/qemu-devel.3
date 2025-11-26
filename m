Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3236AD0EE29
	for <qemu-devel@archiver.kernel.org>; Wed, 26 Nov 2025 05:46:36 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vO8Lh-00023X-Ic; Wed, 26 Nov 2025 00:45:53 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <zhenzhong.duan@intel.com>)
 id 1vO8Ld-00020X-RQ
 for qemu-devel@nongnu.org; Wed, 26 Nov 2025 00:45:51 -0500
Received: from mgamail.intel.com ([192.198.163.10])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <zhenzhong.duan@intel.com>)
 id 1vO8LY-0005rU-8k
 for qemu-devel@nongnu.org; Wed, 26 Nov 2025 00:45:48 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1764135944; x=1795671944;
 h=from:to:cc:subject:date:message-id:references:
 in-reply-to:content-transfer-encoding:mime-version;
 bh=Erku5VvaYNKD3uD4Pg0ZGKBdzor8bzJ2D9BuvKI3lCw=;
 b=UbGyn9gPsffCAkiVkbMlQZ0Xdb7O3UKNvPwTLLGxCo7mcjkn/YLuFK6d
 PU1+NUN5Mi7VQ5ZW+73gudcfWoxzapVCVzsVyH3VLw4S62d89/LLmLnWZ
 keEsp2ZF707bIP8OcEKFy8DPz3RIsW1Gs0jGUjoMHxicJZt/1nHmBy8rq
 dZhgumuqdLjQK4MfQYiZhx1uowGLgmNMRqUHsdw6SQhKRcg3ohIG9iSfI
 tSit/jkoutlq8LBHcS0QkV+zXGC1z//0KN9SRSjty8j0fBMlkqqYgQjQq
 +QrXfEZ41uASyi1pNd4SIAwMoFEEzDPHmLeaw3Xxj1g9L/3d+FGAovjrI Q==;
X-CSE-ConnectionGUID: rk/PzGmfR62cEoPgd80vKw==
X-CSE-MsgGUID: MdzkUm10R7qc2isDWQ6jlg==
X-IronPort-AV: E=McAfee;i="6800,10657,11624"; a="77529920"
X-IronPort-AV: E=Sophos;i="6.20,227,1758610800"; d="scan'208";a="77529920"
Received: from orviesa002.jf.intel.com ([10.64.159.142])
 by fmvoesa104.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 25 Nov 2025 21:45:38 -0800
X-CSE-ConnectionGUID: xasweGcORD+mW4pWM/e1bQ==
X-CSE-MsgGUID: fnu1QC4IT4iYO2oKm0dWhw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.20,227,1758610800"; d="scan'208";a="223546955"
Received: from fmsmsx902.amr.corp.intel.com ([10.18.126.91])
 by orviesa002.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 25 Nov 2025 21:45:37 -0800
Received: from FMSMSX902.amr.corp.intel.com (10.18.126.91) by
 fmsmsx902.amr.corp.intel.com (10.18.126.91) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.29; Tue, 25 Nov 2025 21:45:37 -0800
Received: from fmsedg901.ED.cps.intel.com (10.1.192.143) by
 FMSMSX902.amr.corp.intel.com (10.18.126.91) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.29 via Frontend Transport; Tue, 25 Nov 2025 21:45:37 -0800
Received: from PH0PR06CU001.outbound.protection.outlook.com (40.107.208.57) by
 edgegateway.intel.com (192.55.55.81) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.29; Tue, 25 Nov 2025 21:45:36 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=Sy1mmD8I+cBXWWO9QqPieJJr3OqnpLMrvJNQtBQ+A42UPOMcew8JumR5sqZNZJQliN3l8zPrVigSZ25+yHZXkcqnDZzdeMeyIp+fwuEmhd3h1Qp+m4zp+k5tI0tGroaWbti4JOyYnwctjJZtcj4KC1Tyt+jbRE6IIsULmZHg7Pe4/p6qgHQrz3sKeEUOsGEiWXTEijkcEIB8QI+Shi0O4BI2sAbT6g5etcPQZN8DNduh1PmV8EgWkacb2mAVjfLvA/4uz9PizrKgBFRA+Ia4yjoMfdZ6/WxULXT0kM7U9UnrWA8uzuwmENmaoZMvSzpQ7VGa/aCEdq8nXMjHY4GWJw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Erku5VvaYNKD3uD4Pg0ZGKBdzor8bzJ2D9BuvKI3lCw=;
 b=fz7tSwg6WRmcIMWe9Mvg+QfUFi38eG5LawTjhUhG6I23jFA+RflfV0EQMe7KBDRbFQTfpqkrb32/X7wUi2vz4cJRJ+kbCi/7nznAFV5j+1egCGeBd1BOH8mkuciaEYIKLMiVHzmi86z6YLH+IT0o8WEZ3ROSiLCq8bNpPWBeUTXI+2rRcK5HAkaTe6YYUNkZc7w1lODxVhO5axZENWhjK1z/1wkTgmbF3EUH5VLRAPpJRfw8ZyRBN4mKn76Rucvf5tGzY6JP6VwFTWZj0Ra3hz2POtYYstHTMhyCGYmjB4VgoQy62RxtiC7xaz8/w89PKvDuNFbj0wFu3LmCYsvGfQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Received: from IA3PR11MB9136.namprd11.prod.outlook.com (2603:10b6:208:574::12)
 by DS4PPFFCBF1B4C7.namprd11.prod.outlook.com (2603:10b6:f:fc02::62)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9366.11; Wed, 26 Nov
 2025 05:45:29 +0000
Received: from IA3PR11MB9136.namprd11.prod.outlook.com
 ([fe80::604b:77a4:b1be:3f13]) by IA3PR11MB9136.namprd11.prod.outlook.com
 ([fe80::604b:77a4:b1be:3f13%7]) with mapi id 15.20.9343.016; Wed, 26 Nov 2025
 05:45:29 +0000
From: "Duan, Zhenzhong" <zhenzhong.duan@intel.com>
To: "Liu, Yi L" <yi.l.liu@intel.com>, "qemu-devel@nongnu.org"
 <qemu-devel@nongnu.org>
CC: "alex@shazbot.org" <alex@shazbot.org>, "clg@redhat.com" <clg@redhat.com>, 
 "mst@redhat.com" <mst@redhat.com>, "jasowang@redhat.com"
 <jasowang@redhat.com>, "clement.mathieu--drif@eviden.com"
 <clement.mathieu--drif@eviden.com>, "eric.auger@redhat.com"
 <eric.auger@redhat.com>, "joao.m.martins@oracle.com"
 <joao.m.martins@oracle.com>, "avihaih@nvidia.com" <avihaih@nvidia.com>, "Hao, 
 Xudong" <xudong.hao@intel.com>, "Cabiddu, Giovanni"
 <giovanni.cabiddu@intel.com>, Rohith S R <rohith.s.r@intel.com>, "Gross,
 Mark" <mark.gross@intel.com>, "Van De Ven, Arjan"
 <arjan.van.de.ven@intel.com>
Subject: RE: [PATCH v5 7/9] vfio/listener: Construct iotlb entry when unmap
 memory address space
Thread-Topic: [PATCH v5 7/9] vfio/listener: Construct iotlb entry when unmap
 memory address space
Thread-Index: AQHcTtTPa4rii8pJDkCpIA0xaO+Q3bUDSA8AgAEfrmA=
Date: Wed, 26 Nov 2025 05:45:29 +0000
Message-ID: <IA3PR11MB9136CF89E7C99375F85E211892DEA@IA3PR11MB9136.namprd11.prod.outlook.com>
References: <20251106042027.856594-1-zhenzhong.duan@intel.com>
 <20251106042027.856594-8-zhenzhong.duan@intel.com>
 <6db6365a-225d-4fbb-ac20-d10c424d364b@intel.com>
In-Reply-To: <6db6365a-225d-4fbb-ac20-d10c424d364b@intel.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: IA3PR11MB9136:EE_|DS4PPFFCBF1B4C7:EE_
x-ms-office365-filtering-correlation-id: 7a08a385-2a35-498c-2840-08de2caf01f6
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0; ARA:13230040|366016|376014|1800799024|38070700021;
x-microsoft-antispam-message-info: =?utf-8?B?SEh1b3dGTGtYSW9GcFZmTjV0bkI2TzZwR1dCTHhVbGNMSlJqRlVtd29CZFNs?=
 =?utf-8?B?TlF3dkZLQkNHZXlaODZ5eWRWd2VNM05vdEdtdHBKYkw5S3NqQXROMEtiSC9C?=
 =?utf-8?B?RUg4V2xBVGc2T1IwUzRzdithQ1hIMjlIbFdrTE9sZVhnSHZMMHdvb0pJYk1X?=
 =?utf-8?B?dVdtQll2YWhBaTZocWFtbkUxNnh0T1V0S0o5TDdVRUZpdnE1UnJQQmxBbVFs?=
 =?utf-8?B?RGdLc2lEck9oYWtmc1drUmIwTUp6cnpjbFN4UUNLSUxra3RqblRsbWpPOTF6?=
 =?utf-8?B?am9hc0M3TmtvYUhTZ1RDQWd2Vit3VGJpQm10cjJaMWpRR3VUQlhGbWlLUEJk?=
 =?utf-8?B?aTEyK1dPRS80Sy9vR01Jank1dDFmNXNxZm5kdTJuY2lnQXpQNlFUMWlNUGxP?=
 =?utf-8?B?YmQ3RndMRisyNmpUSnJDREYvOVpKK2Z2eFplZ1ZEamxoRi8xVHo3eWhqZHlR?=
 =?utf-8?B?OWFhekovWEdyL0ZSUnFGNjUyaUNyQWE3SDNlVEZGYXFxVktHRmxjZ3lFNnl4?=
 =?utf-8?B?YW1VS2xhQWtvY3pMRnFZdnNmT0ExRUlHSmE2VldPNTJySU5RdzhoUENDZDg4?=
 =?utf-8?B?dkJyWE5UUWYzN2Q0SllBbncxUEZFYjlFaXZiRFdKWU14ZlVRaWpjM1BRcWUw?=
 =?utf-8?B?djk0YUFmdEFJUE5ReHNLa0cvVmU5N21FRmZST2FoQ1pTL0FrallhUnZoY0dS?=
 =?utf-8?B?a295djY5ZytSSHZlRnZzZzczY0k3SncwM2NMa2NXUFdwWVI3SWpKNW1seTFZ?=
 =?utf-8?B?SkVqQjFDS1ROWHQzOWVpdFNIZnZYdjhKL2RTL250UGdZRmo5NHRVT1lmbkVU?=
 =?utf-8?B?ZVp2RWJOZmNDemUzL2ZsQVdKK043bGoyK2FsVUJmTXhlTlh4WDl2c3lpcE9v?=
 =?utf-8?B?NmtmS1NVaCtodVhROHdSTUhmVTUwMUJvZlhxVmliSVBtR2k5eHBqTGRoRTEr?=
 =?utf-8?B?L1hMVDVhMkRlSkoyM2c5cVJhRHBQQmtpN1RORUJ1OE5JMUptYVRjTlp5bXJC?=
 =?utf-8?B?QXlzZ1Z6M1hxVExuZlFleTdMZ3JtbWd2SURqb1BSZ2ZvL1dyUmx4SjBpRUs0?=
 =?utf-8?B?WGk4a2V3czBhQXgzejdiakRNOWJmelp4NHMwbjVLc1ppQkVXeGM4VkpJTUcv?=
 =?utf-8?B?TXVrOUZYRkF3eHROejVsMEVXVUNyRnBIdHhVVXhaVTQ0Sy8vWWcxU2NZNGZT?=
 =?utf-8?B?UjM1WVZoZG9tckFLcktsZThBM3owTVEvZUdadVNxYTZVdm5oWHc4Qm5EbVdV?=
 =?utf-8?B?SGdPK2FaOXZKYS9MbUFFQzlQbm1tZnNzdllxeExyWVdRb0dWaEZqMlV4eWFy?=
 =?utf-8?B?ZjBubTdsM0t2SW9mZTJyT0ZZYzlaekNVdGRNZnBwN2dud3l0RzNSRVhSTXJJ?=
 =?utf-8?B?NHVLTUxmZEZmZ2kwckZSWWNIbjFQTFlnc3ZzRmtDaStOR0RuY2pBeHUzMTlB?=
 =?utf-8?B?ZjIvRmNKYnVVMEt4SzloNmdLdzdoRHdZTlRQNEI0NTNSay9EcnQvazRUa1Ex?=
 =?utf-8?B?OXRBQWtybzExVFZUY0hTRUJaWGdBRUpQWGlCUERrUjR3MnUrb1V5czhqMUND?=
 =?utf-8?B?TUcxczVZZjFHcFBqRmNrMWdsUXRzZTIxNEp2M0d3V3lmKy94ZVp3cWtuRjd4?=
 =?utf-8?B?ZS9UeXJYUFdoNXpoeWZwZWlHQmxpTnJlSnNCaHpycXQ1emtXN1lQam9OOG5H?=
 =?utf-8?B?WXFqaTF4bDNtanVzenBMektmMlpaem1sdytabWhEYUxlWjJTekpnYm92RWJM?=
 =?utf-8?B?VVI1SzQwbnZFNW1Zc1VudDY1Q1JZWVFuWmQyYUhFZlAyT01nazFCaVdBRlF0?=
 =?utf-8?B?blErWXNidHFqU3NmMm44L29mLytZOUgzaTZYNlVFUHpDM3ZyTlJ0Mm1zSk9E?=
 =?utf-8?B?anRtZW8yUjRrZ25jeUZtL2lWTmJMN1V6WHlUWHNzK2d4UGE5cEQ2Y0JVSWZ5?=
 =?utf-8?B?ZWE1enNhcWpzS2JPN2NRcU1EdjdVbWQxVWkvQmpGSXY0N0ZFaXFCaGxVdlNE?=
 =?utf-8?B?TVBtUEZBUHlQZU1VRnlyK3VqM0RYK1R1N2syZHBrd0VsV2V1RTl4d3VFYlNa?=
 =?utf-8?Q?A/diko?=
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:IA3PR11MB9136.namprd11.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(366016)(376014)(1800799024)(38070700021); DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?MTZiR1BrZDI0V0sxckw1aWFXUGppblZqaHJ3R3drTG1tblFHTnR2aXNYSTBN?=
 =?utf-8?B?eUpyZ0tpeEk0TjBZSWowSjVTQ3Nyb3ZzV0dVYW81Qk9wRnMrVlY4L0d5U2V5?=
 =?utf-8?B?L1p1Y0ViZUlDQWI2M0xpT093dC9ybkVLaDJDYlBlTEdic3gwQWY3SE52eTgy?=
 =?utf-8?B?Vk9kMHNuWnVWaWtQOHVkWjVRaDQzRkI2aDE2Y2VrQ0c2dW02VExVWTFBVjBq?=
 =?utf-8?B?d09yNm0rSGxzYXIyRlhWTVVRUkNxYXNKeWRpamtiOU5PVjErZTJFZTZhSU1O?=
 =?utf-8?B?VGFxTHljVlVaT2tTbk9yWjRtMUkxTlAxc0dTZEJmNUl5cEhYaFJYZ3FMRDRC?=
 =?utf-8?B?NFovRjFYRTlaakxHYmVNdEJ3MDBtTVV2cGkxb1Bod05kTHNxWFdnV3VsNzdI?=
 =?utf-8?B?dDNNazBBN3p2QzlvOC9EQVk0NUF3Mm5kYjl6eWhNZEhwenZlSnp3N0NzYjBr?=
 =?utf-8?B?TmlYVWhzcTYyVkF5MGRNU1RGMUw3UTRiYTdxdE9sMjBSbEZyK0EzdDlYUktF?=
 =?utf-8?B?d1RLY0VMTTRGeW9pR0xtTU10bnNOL3Y3SDIvV2FSY0s0SThLYXgvYjNockM2?=
 =?utf-8?B?eUE2R2tDSlhBcVR5U3RYaklJaW5zVWZlQng0ZThyM2p3M25jajgwdkR2TUlY?=
 =?utf-8?B?MERjQXQ0NHNoZTNpZEsyRitPRDJsMmV2Y2JlazF0ZW9rVXlMMm9QcDdLUWxj?=
 =?utf-8?B?aGZIZlNzNThuekVRblNLZlpERUluR2ljc0t5RzhpemJEb1VpazhkWGc3NGZZ?=
 =?utf-8?B?LzlsODJLT3BBSG96MmdiSFYrRENjejhxbTFZc3UxQ3RZVTZmMFhhckxQTXln?=
 =?utf-8?B?YnFYaVh2UDVOSzQ4TlBwbmF0SERERWl0WUdEakxkL3dBTVU2UjhlWjBZbC9E?=
 =?utf-8?B?Vzk2NnZUYWhYcDNQbGhjSTFSQkJLdmxZczQwUG4xSUVRdE1qR2NwTWJ6T3Jv?=
 =?utf-8?B?WnBSanNGUGtCUEhDcFdxYUYvZDhaWFB0QTB6QzZlUHJuQ2RUM29XS1pTWjJV?=
 =?utf-8?B?Zk4zczdQaUloVDA4STBHc05xdm0vV1RuWGsyYnJ0SmUrUzBlb2JFRjdtWTNv?=
 =?utf-8?B?QmhTVVBPQmZMVXkvVExiU0JaMnVMQ2oreGVtMCt6Um9jYnp6UjgwTEhwTHYz?=
 =?utf-8?B?eTcvMFZvOC9hQnVxMmVxcGJYUXRDTSt5Z0hLN1cxNVA5M29maUNEZi9pdCth?=
 =?utf-8?B?bkREYUt5RTgzdzNnSUhKSFVqQS83K2poa1VrUGp3YWhxYVlnUVVSdlJKSGV6?=
 =?utf-8?B?ZTJtZm9RajI0NXlhMGowUnhub2YvMG5haGdXbFMra1lub0VXQzQzNjg1ZGpB?=
 =?utf-8?B?Zmk0S3lRYitCQXRNbk43c3ZBSjJzZUpJdHRHcmFXc3VIb1plb01lbFc4SmdW?=
 =?utf-8?B?WDhpMU9vd08xSGo2ejVyYWFLbFMrdHprZW9yd3kwaElKMnNjbFhKTTJETmxX?=
 =?utf-8?B?dCtQbHRRSnZDYmpFSUFxdFQxSzBSeU8rMk1MQVk4TE5NaEI2RTlSVzZHQmp6?=
 =?utf-8?B?UmlvMHZORm9OZTZqaUxTUkQ5c01CNWhXRnNLdWhnbUpGOXB0ZUNOWVBiNE1H?=
 =?utf-8?B?ellmVDA2V1N6TTVHWkVSNWw5Rks4NHNTU3A4Ri9jZjlPRWYvTzl5MzE0dFNm?=
 =?utf-8?B?Z29vMTNZUjVpL2RIaHZLOEhGTjEyNXMyMGVtN1NJN0NBVmIrNTJiRDJXLzh0?=
 =?utf-8?B?VWFzUm5Ka0EyMkNZZit4NVk3S3lUZHAvWFdVVmVzOGhVNjhwcUVBdFoybVhG?=
 =?utf-8?B?Rm5aRWZjZ1VyZWRSWGYrSmloVGFFd1RvdURxa2J6NmpuVXFWbkRrUG5zY2hF?=
 =?utf-8?B?SUhkb1VIcVNYQ2lIbmZoQnJnQXZuVUR2aXYzbHVUQmlWeUsrMGtrajVQS2xM?=
 =?utf-8?B?N3JUNVZGcUJwOHhKS0F1SVg1RytpN2pQRENWajhRMkJMUmlYU0prTEo2b1kr?=
 =?utf-8?B?STdWRHMwNDlhNjVWOXEybWJFcFlvVEhRSElNNDEvSS9OMGlBdXFiUGNZeTZT?=
 =?utf-8?B?ZThnd254czhyY29kLzhRbFF2NVVHVEd6UXBRbTJOTFovN29wemI2NkpWaGJV?=
 =?utf-8?B?bTZiZ1g5Q2Zpbnh0YjdEZHdPZTIxalRxM1NWaDUvYlpEY2pZRjRmQUY1Ti9G?=
 =?utf-8?Q?XzC0jWfmr8PDiNhOi+9HFFRGT?=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: IA3PR11MB9136.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 7a08a385-2a35-498c-2840-08de2caf01f6
X-MS-Exchange-CrossTenant-originalarrivaltime: 26 Nov 2025 05:45:29.6928 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: PZnV09eKW0CaqG4A/SlHhuAHduIPJzy+AJtkxclAR0me3Ll75THmFN4kQe2OmnzHELvZq2Ig6M78Q5vdkZkj9Up8emfKS42gpBBzZLTycVM=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS4PPFFCBF1B4C7
X-OriginatorOrg: intel.com
Received-SPF: pass client-ip=192.198.163.10;
 envelope-from=zhenzhong.duan@intel.com; helo=mgamail.intel.com
X-Spam_score_int: -44
X-Spam_score: -4.5
X-Spam_bar: ----
X-Spam_report: (-4.5 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.152,
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
aXVAaW50ZWwuY29tPg0KPlN1YmplY3Q6IFJlOiBbUEFUQ0ggdjUgNy85XSB2ZmlvL2xpc3RlbmVy
OiBDb25zdHJ1Y3QgaW90bGIgZW50cnkgd2hlbiB1bm1hcA0KPm1lbW9yeSBhZGRyZXNzIHNwYWNl
DQo+DQo+T24gMjAyNS8xMS82IDEyOjIwLCBaaGVuemhvbmcgRHVhbiB3cm90ZToNCj4+IElmIGEg
VkZJTyBkZXZpY2UgaW4gZ3Vlc3Qgc3dpdGNoZXMgZnJvbSBwYXNzdGhyb3VnaChQVCkgZG9tYWlu
IHRvIGJsb2NrDQo+PiBkb21haW4sIHRoZSB3aG9sZSBtZW1vcnkgYWRkcmVzcyBzcGFjZSBpcyB1
bm1hcHBlZCwgYnV0IHdlIHBhc3NlZCBhDQo+TlVMTA0KPj4gaW90bGIgZW50cnkgdG8gdW5tYXBf
Yml0bWFwLCB0aGVuIGJpdG1hcCBxdWVyeSBkaWRuJ3QgaGFwcGVuIGFuZCB3ZSBsb3N0DQo+PiBk
aXJ0eSBwYWdlcy4NCj4NCj50aGlzIGlzIGEgZ29vZCBjYXRjaC4gOikgSGF2ZSB5b3Ugb2JzZXJ2
ZWQgcHJvYmxlbSBpbiB0ZXN0aW5nIG9yIGp1c3QNCj5pZGVudGlmaWVkIGl0IHdpdGggcGF0Y2gg
aXRlcmF0aW9uPw0KDQpQYXRjaCBpdGVyYXRpb24uDQoNCj4NCj4+IEJ5IGNvbnN0cnVjdGluZyBh
biBpb3RsYiBlbnRyeSB3aXRoIGlvdmEgPSBncGEgZm9yIHVubWFwX2JpdG1hcCwgaXQgY2FuDQo+
PiBzZXQgZGlydHkgYml0cyBjb3JyZWN0bHkuDQo+Pg0KPj4gRm9yIElPTU1VIGFkZHJlc3Mgc3Bh
Y2UsIHdlIHN0aWxsIHNlbmQgTlVMTCBpb3RsYiBiZWNhdXNlIFZGSU8gZG9uJ3QNCj4+IGtub3cg
dGhlIGFjdHVhbCBtYXBwaW5ncyBpbiBndWVzdC4gSXQncyB2SU9NTVUncyByZXNwb25zaWJpbGl0
eSB0byBzZW5kDQo+PiBhY3R1YWwgdW5tYXBwaW5nIG5vdGlmaWNhdGlvbnMsIGUuZy4sDQo+dnRk
X2FkZHJlc3Nfc3BhY2VfdW5tYXBfaW5fbWlncmF0aW9uKCkNCj4+DQo+PiBTaWduZWQtb2ZmLWJ5
OiBaaGVuemhvbmcgRHVhbiA8emhlbnpob25nLmR1YW5AaW50ZWwuY29tPg0KPj4gVGVzdGVkLWJ5
OiBHaW92YW5uaW8gQ2FiaWRkdSA8Z2lvdmFubmkuY2FiaWRkdUBpbnRlbC5jb20+DQo+PiAtLS0N
Cj4+ICAgaHcvdmZpby9saXN0ZW5lci5jIHwgMTUgKysrKysrKysrKysrKystDQo+PiAgIDEgZmls
ZSBjaGFuZ2VkLCAxNCBpbnNlcnRpb25zKCspLCAxIGRlbGV0aW9uKC0pDQo+Pg0KPj4gZGlmZiAt
LWdpdCBhL2h3L3ZmaW8vbGlzdGVuZXIuYyBiL2h3L3ZmaW8vbGlzdGVuZXIuYw0KPj4gaW5kZXgg
MjEwOTEwMTE1OC4uM2I0OGY2Nzk2YyAxMDA2NDQNCj4+IC0tLSBhL2h3L3ZmaW8vbGlzdGVuZXIu
Yw0KPj4gKysrIGIvaHcvdmZpby9saXN0ZW5lci5jDQo+PiBAQCAtNzEzLDE0ICs3MTMsMjcgQEAg
c3RhdGljIHZvaWQNCj52ZmlvX2xpc3RlbmVyX3JlZ2lvbl9kZWwoTWVtb3J5TGlzdGVuZXIgKmxp
c3RlbmVyLA0KPj4NCj4+ICAgICAgIGlmICh0cnlfdW5tYXApIHsNCj4+ICAgICAgICAgICBib29s
IHVubWFwX2FsbCA9IGZhbHNlOw0KPj4gKyAgICAgICAgSU9NTVVUTEJFbnRyeSBlbnRyeSA9IHt9
LCAqaW90bGIgPSBOVUxMOw0KPj4NCj4+ICAgICAgICAgICBpZiAoaW50MTI4X2VxKGxsc2l6ZSwg
aW50MTI4XzJfNjQoKSkpIHsNCj4+ICAgICAgICAgICAgICAgYXNzZXJ0KCFpb3ZhKTsNCj4+ICAg
ICAgICAgICAgICAgdW5tYXBfYWxsID0gdHJ1ZTsNCj4+ICAgICAgICAgICAgICAgbGxzaXplID0g
aW50MTI4X3plcm8oKTsNCj4+ICAgICAgICAgICB9DQo+PiArDQo+PiArICAgICAgICAvKg0KPj4g
KyAgICAgICAgICogRmFrZSBhbiBJT1RMQiBlbnRyeSBmb3IgaWRlbnRpdHkgbWFwcGluZyB3aGlj
aCBpcyBuZWVkZWQgYnkNCj5kaXJ0eQ0KPj4gKyAgICAgICAgICogdHJhY2tpbmcuIEluIGZhY3Qs
IGluIHVubWFwX2JpdG1hcCwgb25seSB0cmFuc2xhdGVkX2FkZHIgZmllbGQNCj5pcw0KPj4gKyAg
ICAgICAgICogdXNlZCB0byBzZXQgZGlydHkgYml0bWFwLg0KPg0KPkp1c3Qgc2F5IHN5bmMgZGly
dHkgaXMgbmVlZGVkIHBlciB1bm1hcC4gU28geW91IG1heSBhZGQgYSBjaGVjaw0KPmluX21pZ3Jh
dGlvbiBhcyB3ZWxsLiBJZiBub3QgaW4gbWlncmF0aW9uLCBpdCBpcyBubyBuZWVkZWQgdG8gZG8g
aXQuDQoNCkRpcnR5IHRyYWNraW5nIGlzIG5vdCBvbmx5IGZvciBtaWdyYXRpb24sIGJ1dCBhbHNv
IGRpdHJ5IHJhdGUvbGltaXQuIFNvIGEgbm9uLW51bGwgaW90bGINCmlzIGFsd2F5cyBwYXNzZWQg
Zm9yIHJhbSBNUi4gVGhhdCBpb3RsYiBwb2ludGVyIGlzIHVzZWQgb25seSB3aGVuDQp2ZmlvX2Nv
bnRhaW5lcl9kaXJ0eV90cmFja2luZ19pc19zdGFydGVkKCkgcmV0dXJuIHRydWUuDQoNCkkgY2Fu
IGFkZCBhIGNoZWNrIG9uIGdsb2JhbF9kaXJ0eV90cmFja2luZyBpZiB5b3UgcHJlZmVyIHRvIGFk
ZCBhIGNoZWNrLg0KDQo+DQo+PiArICAgICAgICAgKi8NCj4+ICsgICAgICAgIGlmICghbWVtb3J5
X3JlZ2lvbl9pc19pb21tdShzZWN0aW9uLT5tcikpIHsNCj4+ICsgICAgICAgICAgICBlbnRyeS5p
b3ZhID0gaW92YTsNCj4+ICsgICAgICAgICAgICBlbnRyeS50cmFuc2xhdGVkX2FkZHIgPSBpb3Zh
Ow0KPj4gKyAgICAgICAgICAgIGlvdGxiID0gJmVudHJ5Ow0KPj4gKyAgICAgICAgfQ0KPj4gKw0K
Pg0KPldoaWxlLCBJJ20gc3RpbGwgd29uZGVyaW5nIGhvdyB0byBkZWFsIHdpdGggaW9tbXUgTVIg
Y2FzZS4gTGV0J3Mgc2VlIGENCj5zY2VuYXJpbyBmaXJzdC4gV2hlbiBzd2l0Y2hpbmcgZnJvbSBE
TUEgZG9tYWluIHRvIFBULCBRRU1VIHdpbGwgc3dpdGNoDQo+dG8gUFQuIFRoaXMgc2hhbGwgdHJp
Z2dlciB0aGUgdmZpb19saXN0ZW5lcl9yZWdpb25fZGVsKCkgYW5kIHVucmVnaXN0ZXINCj50aGUg
aW9tbXUgbm90aWZpZXIuIFRoaXMgbWVhbnMgdklPTU1VIHNpZGUgbmVlZHMgdG8gZG8gdW5tYXAg
cHJpb3IgdG8NCj5zd2l0Y2hpbmcgQVMuIElmIG5vdCwgdGhlIGlvbW11IG5vdGlmaWVyIGlzIGdv
bmUgd2hlbiB2SU9NTVUgd2FudHMgdG8NCj51bm1hcCB3aXRoIGFuIElPVExCRXZlbnQuIEZvciB2
aXJ0dWFsIGludGVsX2lvbW11LCBpdCBpcyBjYWxsaW5nDQo+dnRkX2FkZHJlc3Nfc3BhY2VfdW5t
YXBfaW5fbWlncmF0aW9uKCkgcHJpb3IgdG8gY2FsbGluZw0KPnZ0ZF9zd2l0Y2hfYWRkcmVzc19z
cGFjZSgpLiBTbyBJIHRoaW5rIHlvdSBuZWVkIHRvIHR3ZWFrIHRoZSBpbnRlbF9pb21tdQ0KPmEg
Yml0IHRvIHN1aXQgdGhlIG9yZGVyIHJlcXVpcmVtZW50LiA6KQ0KDQpWVEQgZG9lc24ndCBzdXBw
b3J0IHN3aXRjaGluZyBmcm9tIERNQSBkb21haW4gdG8gUFQgYXRvbWljYWxseSwgc28gc3dpdGNo
ZXMNCnRvIGJsb2NrIGRvbWFpbiBpbiBiZXR3ZWVuLCBzZWUgaW50ZWxfaW9tbXVfYXR0YWNoX2Rl
dmljZSgpIGluIGtlcm5lbC4NCg0KU28gd2l0aCB0aGlzIHNlcXVlbmNlIGlzIERNQS0+YmxvY2st
PlBUIGRvbWFpbiwgd2UgaGF2ZSBndWFyYW50ZWVkIHRoZSBvcmRlcg0KeW91IHNoYXJlZD8gU2Vl
IHZ0ZF9wYXNpZF9jYWNoZV9zeW5jX2xvY2tlZCgpLg0KDQo+DQo+QlRXLiBzaG91bGQgdGhlIGlv
bW11IE1ScyBldmVuIGdvIHRvIHRoaXMgdHJ5X3VubWFwIGJyYW5jaD8gSSB0aGluayBmb3INCj5z
dWNoIE1ScywgaXQgcmVsaWVzIG9uIHRoZSB2SU9NTVUgdG8gdW5tYXAgZXhwbGljaXRseSAoaGVu
Y2UgdHJpZ2dlciB0aGUNCj52ZmlvX2lvbW11X21hcF9ub3RpZnkoKSkuDQoNClllcywgaXQncyB1
bm5lY2Vzc2FyeSwgYnV0IGl0J3MgaGFyZCBmb3IgVkZJTyB0byBkaXN0aW5ndWlzaCBpZiB0cnlf
dW5tYXAgaXMgZHVlIHRvDQpkb21haW4gc3dpdGNoIG9yIGEgcmVhbCB1bm1hcC4gSSB0aGluayBp
dCdzIGhhcm1sZXNzIGJlY2F1c2UgdGhlIHNlY29uZCB0cnlfdW5tYXANCnVubWFwcyBub3RoaW5n
Lg0KDQpUaGFua3MNClpoZW56aG9uZw0KDQo+DQo+PiAgICAgICAgICAgcmV0ID0gdmZpb19jb250
YWluZXJfZG1hX3VubWFwKGJjb250YWluZXIsIGlvdmEsDQo+aW50MTI4X2dldDY0KGxsc2l6ZSks
DQo+PiAtICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgTlVMTCwgdW5tYXBf
YWxsKTsNCj4+ICsgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICBpb3RsYiwg
dW5tYXBfYWxsKTsNCj4+ICAgICAgICAgICBpZiAocmV0KSB7DQo+PiAgICAgICAgICAgICAgIGVy
cm9yX3JlcG9ydCgidmZpb19jb250YWluZXJfZG1hX3VubWFwKCVwLA0KPjB4JSJIV0FERFJfUFJJ
eCIsICINCj4+ICAgICAgICAgICAgICAgICAgICAgICAgICAgICIweCUiSFdBRERSX1BSSXgiKSA9
ICVkICglcykiLA0KPg0KPlJlZ2FyZHMsDQo+WWkgTGl1DQo=

