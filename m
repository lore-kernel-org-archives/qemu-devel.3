Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 00D6FC7115B
	for <qemu-devel@archiver.kernel.org>; Mon, 23 Jun 2025 03:30:35 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uTXsY-0007Qe-P8; Sun, 22 Jun 2025 23:29:54 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <zhenzhong.duan@intel.com>)
 id 1uTXsW-0007Mm-F6
 for qemu-devel@nongnu.org; Sun, 22 Jun 2025 23:29:52 -0400
Received: from mgamail.intel.com ([192.198.163.7])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <zhenzhong.duan@intel.com>)
 id 1uTXsT-0002fv-TC
 for qemu-devel@nongnu.org; Sun, 22 Jun 2025 23:29:52 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1750649390; x=1782185390;
 h=from:to:cc:subject:date:message-id:references:
 in-reply-to:content-transfer-encoding:mime-version;
 bh=Vo3YUQyEXnaaDqSDDN9yKjR3qE8MnobgDgxu5hHfWLA=;
 b=DFMdHCZdb+l/wfrkjyiB+cqZKjU6Jt4auR6CNImjzSR2a/SGPSnXZ7EA
 InF2S+2On+Wof32X6920zU+cFHPTehZ7u8Ei/RPyontDGhOBfGN7lcywD
 n/umrRnOE4mlSWpbbBholKT9AFPrsaclroJ8QYnaFcwF1W6Ti4f4mC/Vk
 cqBygHv0NtY3SyGSmcIo/89ieMiYqx2860hZE+uVdgzYZWl/F57pVDf7I
 1EwyFXSP2fBSawaTx3LD5Z1NqKJ2pZjvC3/Cf1Ht4/faynP6JpNfj9A29
 Np98+MEYY0So5gxV5VDs2GeWq+hkqtQzpcVPGlbtxzDNT13SK5DeISFN6 w==;
X-CSE-ConnectionGUID: 53uvGazeQkCLG8CNMGTzsw==
X-CSE-MsgGUID: +Ljh7WwqQSSe9MmMxvIcSg==
X-IronPort-AV: E=McAfee;i="6800,10657,11472"; a="78254214"
X-IronPort-AV: E=Sophos;i="6.16,258,1744095600"; d="scan'208";a="78254214"
Received: from orviesa008.jf.intel.com ([10.64.159.148])
 by fmvoesa101.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 22 Jun 2025 20:29:46 -0700
X-CSE-ConnectionGUID: 9m4k8w/gQ0yakxjB7Pi8fA==
X-CSE-MsgGUID: 7a3+tKkBQ/CjwgEahyNbeQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.16,258,1744095600"; d="scan'208";a="151989016"
Received: from orsmsx903.amr.corp.intel.com ([10.22.229.25])
 by orviesa008.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 22 Jun 2025 20:29:45 -0700
Received: from ORSMSX901.amr.corp.intel.com (10.22.229.23) by
 ORSMSX903.amr.corp.intel.com (10.22.229.25) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.25; Sun, 22 Jun 2025 20:29:45 -0700
Received: from ORSEDG902.ED.cps.intel.com (10.7.248.12) by
 ORSMSX901.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.25 via Frontend Transport; Sun, 22 Jun 2025 20:29:45 -0700
Received: from NAM04-BN8-obe.outbound.protection.outlook.com (40.107.100.77)
 by edgegateway.intel.com (134.134.137.112) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.25; Sun, 22 Jun 2025 20:29:45 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=B3jEd+/VsjSmKYWaE9FY4uWX0A3rVDFdKg5z/f7kbnQTNldpAJ6ZrBlYL49w1NpX2NGX5thDYHWg0vms1lLSBdS1AYXjjwxL0p95qBWyp6Ov3KXE55rIrs1oGXuxy3GYfg8Nt+44rTJg8zIRShoz6n3eRw+RrfneMbNo+hyYBs534FHFB/A7hK0ANACQra5bxPqjhMlD91Sx5jrrMsOWW1jhc8bDl5/08ZDUAls69uzxGWEj5HuaCFDJnW7ZLnI8tdsMuMwBbcsi7Us7FEYG3SaeVey260teaQEVmpuv2QiRkkmx4U+NWc7efbNqZO9XOCdzjosxXA0XaRyrZFMQfg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Vo3YUQyEXnaaDqSDDN9yKjR3qE8MnobgDgxu5hHfWLA=;
 b=B+5YL5FXFkXir2ky8mhKjdBM1T+9s96Od9RC9l+cWQwKJDE9/yQ1DdWmrbl2IF7QE4tuvDICkuHYzmiAmCrxNHY/7fAjXzuv/oRfghN56HYHVwGjExyK4dHGWQC9e5BbGv+29uNVbCMFWpM6kdyiLdSq0zY71/1eE5FvGwVgtHeUAEHeqALnHrnrMw/D0FC8mugrzYjtzX6bFJMLMRp6zlM6Fy6Cns/3Am6Dahbp20QIMuvQHETpA8X6MOo10TifceEwcwRykMDn4glHziocjkQ+SJ4z9h2d44BQZH7pW3mPAu02zNuqOg+tcAa5K0xK9gp87hU/MZpgH5jLNIt8qA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Received: from IA3PR11MB9136.namprd11.prod.outlook.com (2603:10b6:208:574::12)
 by BL3PR11MB6458.namprd11.prod.outlook.com (2603:10b6:208:3bd::5)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8857.28; Mon, 23 Jun
 2025 03:29:29 +0000
Received: from IA3PR11MB9136.namprd11.prod.outlook.com
 ([fe80::604b:77a4:b1be:3f13]) by IA3PR11MB9136.namprd11.prod.outlook.com
 ([fe80::604b:77a4:b1be:3f13%4]) with mapi id 15.20.8835.023; Mon, 23 Jun 2025
 03:29:29 +0000
From: "Duan, Zhenzhong" <zhenzhong.duan@intel.com>
To: "eric.auger@redhat.com" <eric.auger@redhat.com>, "qemu-devel@nongnu.org"
 <qemu-devel@nongnu.org>
CC: "alex.williamson@redhat.com" <alex.williamson@redhat.com>,
 "clg@redhat.com" <clg@redhat.com>, "mst@redhat.com" <mst@redhat.com>,
 "jasowang@redhat.com" <jasowang@redhat.com>, "peterx@redhat.com"
 <peterx@redhat.com>, "ddutile@redhat.com" <ddutile@redhat.com>,
 "jgg@nvidia.com" <jgg@nvidia.com>, "nicolinc@nvidia.com"
 <nicolinc@nvidia.com>, "shameerali.kolothum.thodi@huawei.com"
 <shameerali.kolothum.thodi@huawei.com>, "joao.m.martins@oracle.com"
 <joao.m.martins@oracle.com>, "clement.mathieu--drif@eviden.com"
 <clement.mathieu--drif@eviden.com>, "Tian, Kevin" <kevin.tian@intel.com>,
 "Liu, Yi L" <yi.l.liu@intel.com>, "Peng, Chao P" <chao.p.peng@intel.com>
Subject: RE: [PATCH v2 18/19] Workaround for ERRATA_772415_SPR17
Thread-Topic: [PATCH v2 18/19] Workaround for ERRATA_772415_SPR17
Thread-Index: AQHb4bREXWcQhYvsp0+/7r3D0pPW17QMNagAgAPjXwA=
Date: Mon, 23 Jun 2025 03:29:29 +0000
Message-ID: <IA3PR11MB91366EF1B3F2D45D1EEC1D859279A@IA3PR11MB9136.namprd11.prod.outlook.com>
References: <20250620071813.55571-1-zhenzhong.duan@intel.com>
 <20250620071813.55571-19-zhenzhong.duan@intel.com>
 <ec96eb95-f0d7-4d9e-986c-46367afef7fa@redhat.com>
In-Reply-To: <ec96eb95-f0d7-4d9e-986c-46367afef7fa@redhat.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: IA3PR11MB9136:EE_|BL3PR11MB6458:EE_
x-ms-office365-filtering-correlation-id: de5a99a2-7655-42e4-2e20-08ddb2062999
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
 ARA:13230040|1800799024|376014|7416014|366016|38070700018; 
x-microsoft-antispam-message-info: =?utf-8?B?OHRGcUsyc0hJRzkzTktUU1hrcUdPMXBkVnNRVjkzQjdobk8xN2Q3cEVXRXlI?=
 =?utf-8?B?dDhrQXBpUnNYNTVxaUV5Yk4vVWJJa0txc3JCMzhqditEMUVlUGhaMjZsQkh1?=
 =?utf-8?B?dDRKQ1FLRWRpSDRJelE3Q2tvL2w1aTVUK20reGE2ZFZBa1Bmd2w1Sjg0ckZU?=
 =?utf-8?B?L2ZZZGo2aTlBeStKdHo5em9TNmp0T2VOK3NZUVZVTTc0MTVtQVlUZzR6dWlk?=
 =?utf-8?B?RzJYUHp5MEhyem9IZFRYZjlEeCsxZ2FkNVZ1STNHa3dJL1JsN0tVOWh5QVhM?=
 =?utf-8?B?T2ZRQTNPSUptcHNWbTM0QXp6RVBnNkczSFJzTDU5WFJrNVBWLzhLeTZ6ZXZq?=
 =?utf-8?B?S1N2TUpWNU5CZEpmejNSSUhXSUt2WnQ0NkxSQm42WXRTSDFMRUZOcnFRVDFS?=
 =?utf-8?B?M29ZdzFmTFJPOXRMOXVMLy9DZGZMa1Rxak9SU1k0UWZLYitTTWt5NHlWMFhG?=
 =?utf-8?B?MktRWFNxN0Y5cWN2Q3ZCRmNmd2dkaUdTSmJVdWR5Zyt0SWNmRVMzS01iazN2?=
 =?utf-8?B?QnJST0tPYjlEeXR0ditHY3JHL1BUUlcyVmJYR2tlbkpmWnNFNGpXZW5PbG9U?=
 =?utf-8?B?R0JwZ2FrV0M3UjErOUNRUGVJVFROeldrV0Fnc0NrNnpnTlhoVnRMcURNNkFG?=
 =?utf-8?B?Zlhlem5YZzMxM0cwUWxLb0s4OVBqNkJOK2w3S3hDbmtYSEdjeVhZUmxPaFdC?=
 =?utf-8?B?bG8wQVBRbStZeVVtdGFMSTZHWlpIaFc2dXkwZURRZnVvU3JScnN2VzMyYU8y?=
 =?utf-8?B?dkhVSnc3Ty9sWkFpbG5nclhucklnYVpGRklvOFFJdUh0a2FDemo2UCtXNFBa?=
 =?utf-8?B?bVgrS3hXRDg5NXlXWG9sTThJNkw1d1BBeWoxelN5WldCMU5yc2JQV3V3YkRk?=
 =?utf-8?B?bzdHVzl1WUZ6UzBwUmNPekNBNTEvM01JK0hyOXpES0VCcDc3Q0NhaTFUdDRi?=
 =?utf-8?B?TDNJSExNRDZVTTdDK1NHcE9TQnRSeG5XdjlmUUllOVdTL1dRaTZXeTQ0K0dr?=
 =?utf-8?B?RkhnWlVlZm1VNDY2NlhMYkhiMlRJcDZWK2hrTjNSTDJmS3U0QTcxbWtiS3pm?=
 =?utf-8?B?dkR2eHNjbEd1V2FoWGpORUlTOUtaT0tuNHlVS29SNEREbEJYQ0Y5ckFUMHhS?=
 =?utf-8?B?TDFadWgwMERUMVRIK08weE9SRlloMXlVZXVlSVA3TDExZkJtaUlUZnk3cXhP?=
 =?utf-8?B?U09jU1FyN1pvRlFXZFNMMXVHN0ZHZGFsL3RUYnYwZWFhQXJnamRVWUw0U29h?=
 =?utf-8?B?Qy9Oa1doTkkxMGtuLzRjM2UvVFNRK2lheWdtQ04xdVFySEdsaGNNWEE3UkZy?=
 =?utf-8?B?R0NlRm42SzZ0T1RIWEJxTkM2T0RGMnl2L3g0eEYxcVNJYkt4bjlNV3FGMEIz?=
 =?utf-8?B?a0RKYU5wWUlKMTRMWnRIL0VwaUlGZFl4Zk5aMVFUSzdDbXhZR3NJSzFOaHJ5?=
 =?utf-8?B?cjdNK2lEeXVRV1IxaTdua0sxQ2lrWHk0dUhxMnhHQTM0b05TaldsM3BvYjlT?=
 =?utf-8?B?eU9VZStMdHREYWlOQy81ckt6TEdtc041VjFtS01tY01qd2VPeVJzQWQrempj?=
 =?utf-8?B?NVVNNnM1aW80aW90TmtHMEZCeGRIbVE4c0RuLzRMdHkwaUVmVHc3bklSWWdk?=
 =?utf-8?B?cWg0VkpzWUE0UEFHcTFNVU5pTUpvUkl4NXFuM0FSQktiOXZPandFRTl6V3BO?=
 =?utf-8?B?SEVnaS9PRGZmdkZrRWZWb1NmWkIzNHFwMEFEUWJzUGoyMHR4WG9uZ2J4TjZG?=
 =?utf-8?B?S1VoMHFXMDlIY25lK3EyZkFSaHpodlFFdllwMEFpSFpQRXAyVG5YcEpyOGVE?=
 =?utf-8?B?SXZOcHhqNjk0dzcwT1dUbm01bXYzdkwyKzZqNjBtUFpTQmk2c0FvZ3NnNHFi?=
 =?utf-8?B?Mjg1c0QyYXZhL1ZHc29YL3dnaXErL084NE91YzJsQXBzcXFocmVCMHhaRzhR?=
 =?utf-8?Q?REN9vTiIrxo2z3Zcp4nXVQRAxRWaDCD+?=
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:IA3PR11MB9136.namprd11.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(1800799024)(376014)(7416014)(366016)(38070700018); DIR:OUT;
 SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?SVpJbEJqa1RnUzB4cyszWC9WRGQ1S3pMQXRqWng3U1NuY0Y4dFBHcnIwemZh?=
 =?utf-8?B?eERqRi9JRUdzQmxoTHhTY2hHOGlyRVp2QVZOeTBjaWlOZ2pIZzhUTXI0Nmpo?=
 =?utf-8?B?K3NFY2t6ZlppdUpyNWNidFBRL3kvSEE5RE10aHVKYmc3RFNHb0g1bEFyVjJS?=
 =?utf-8?B?OFd3T2tGT0RjWDVsd2NsYnVJSTIvRVdxQVdBa001bUtiRVpCQi93SUpuUGNQ?=
 =?utf-8?B?d05xcXJid2ZvdVJoTHRVVUFoemNTazYzQnZHZ2ljUGh5VGNXZ2NZNWh4dWNo?=
 =?utf-8?B?T1BJNVJqYzUzQ3B3N25TaDRKdElxR2JQS2FsSDJFWTJsdzBjanhZMkNzbUVT?=
 =?utf-8?B?RGhpeGxNVURPSG83cWJDeS91RzRsVnJkM1VFd1E2OFRwMEZwcXFxV2dha2x0?=
 =?utf-8?B?VkNhQ1hsZFJmSHFiQ3ZONHRHRysxNVVtRk50UjVSWEF1RGxNbnZOU0hDVnRF?=
 =?utf-8?B?eTgzSDVWcHpsTHRwV3VZKzBvTWM1Y0dZai95WTgrY25ndTZCd0o5UGFGZ2Uy?=
 =?utf-8?B?elV0TWFRdW93WHJjZkcrdjZkczRkSm9NaFpjY0cwV0JFNE5oK0psNEdHcldm?=
 =?utf-8?B?bjZLQTh2R1ZtSlN1elljVHZlV1lYTW1NRVZrbTN5M1JKb3lZNElyV3BMYy8y?=
 =?utf-8?B?ZnFQOTErRGhoMFNVSXgzaXNpeHNKV3FWclYwQjJxZ3RyYVc1bW92ekRGWVZO?=
 =?utf-8?B?SG5XalhUSUJZTEVRR1VMN1hiMmtWOE5UVWdMK1ZEVE5oTVFqcTZBZzRSRTJk?=
 =?utf-8?B?WDlDems0Ykp1dFp5MFBUeCtuYzQxVEFRUjUwV1dKSDNVZGNJQlk0aHRNbWNI?=
 =?utf-8?B?ZE4rVHJ3Snc1WW1CZXBWK1lxSkFVajFnbGRkK0VST3RXMWpEYjA0Z3R2UjB1?=
 =?utf-8?B?M05vbE5IYnVUKytsRU5hRjBzdTRjaGxTeXduMlRETTZPWHNuajl4aXVkWDVu?=
 =?utf-8?B?ZmxQUXRhQnl0UU0zNjFHeFRrTW5VdFVXcFg5Y0RpWUJJbUErR1lFckRHeFhF?=
 =?utf-8?B?Tm93ZGw2eVFTMmNienMvMzN4SWk5OEQvQkVoSlN5TjYxNmt5alZIUUlhdUVP?=
 =?utf-8?B?NnF6aTQ2bnhBbVVRZVhIV2FXdnJ1ZVZucmkzOEUrZklMby9WTXA0RlU4TnF1?=
 =?utf-8?B?dWQ4cTJRWTZhRkpvc1NsdHp1Umh5UkNiRWhhMHpETXJmaFVreVhzZ3QrRlI5?=
 =?utf-8?B?cGdkenc4RHUyVzEzRThVbkt3Q2xXdkZrR3pVOUhLZ1VMUmVZR24xODl3RElJ?=
 =?utf-8?B?VUhFcWVHb0EyVzhzV01vajVzNEFENndWN25vS2RZSkxJZnBucFdiRU0vUksr?=
 =?utf-8?B?ZUpDcExhaGJuRyt1bnVCSEtEOUtKZFViODRGa3liNGYxMzBvSTFoR1RlR2Fs?=
 =?utf-8?B?UzBGNnNPNVBvRWJRTnYwM0h1akJQTUlpWDZBVSsvWWhhL1poSExlOVV6b2Mr?=
 =?utf-8?B?OXN0Skcra3MzRXBIUjA4ZnNJQ1dialZKeTI5cUhXWG4wR01DSmJLSWZMT3FR?=
 =?utf-8?B?a3RyY1kxWHI4dVA2ZGhCWFpzQjljTGJHUWx4bUNlOGViNnJtQTdKTUhPcXZ4?=
 =?utf-8?B?dHh1Z2tIbWo4cDhhdzlCTjMzL3FDQ2hrT01KNGNxSm5BY3hTNmdnMHphWklr?=
 =?utf-8?B?SGtKbDBqMndTK3EzZnBNaXllZ3lkT01BSytPNU5aQ3RWaU9FQmlxSGtxQ0Rk?=
 =?utf-8?B?WFcwbHJMK2hWdkJmNmp5dWxpdTJ3ZmtTdmJWT2Y1QlNHNjZpQjNZQkRiVk5k?=
 =?utf-8?B?eG1nSXJVeTRpWHd6SkdKelowandyWjNQMVZIRzdFNTVPdkhrZVhaZHdWVUFq?=
 =?utf-8?B?dGppTzFGTHFEaTB1QkRLcWF6blVQc0ZRdmduZ1A1NU9JUmd6K3dTeThJVFRn?=
 =?utf-8?B?VEE4K2JJTElrenlsTSs5VWc0WXdSdjRVRzZ5VGhHcTZqelY2REZwRXRxV3lr?=
 =?utf-8?B?VWJaRE42Nnp0Y3pDdEo3amJ3TGtKMkNkS2pIWGZpb0NDbXNpUTBqQW1scGJW?=
 =?utf-8?B?aWNiTTloYzREYkFBblIyRnJqeWhQemZXL3FvM3psMHN2VVdDR3dYaWtUUnNF?=
 =?utf-8?B?QWhsV0plN09Mc0c0WFdZSVc3SXB0WEF2bndjenNwMkQ2cmgyeW5yczl3RWtk?=
 =?utf-8?Q?nEgy49yiv6hdYGHN52LoSxnhG?=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: IA3PR11MB9136.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: de5a99a2-7655-42e4-2e20-08ddb2062999
X-MS-Exchange-CrossTenant-originalarrivaltime: 23 Jun 2025 03:29:29.3369 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: f0CPll3c1PG3fLieQzo/WYnOtLZe+Bv37ngJDnxvVTXeZM7FMg9ot0gNzha8Wq93w/67QHey8gOFkl/WYTh7x1hLc6Js5+2DcIYEev3F5kA=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BL3PR11MB6458
X-OriginatorOrg: intel.com
Received-SPF: pass client-ip=192.198.163.7;
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

DQoNCj4tLS0tLU9yaWdpbmFsIE1lc3NhZ2UtLS0tLQ0KPkZyb206IEVyaWMgQXVnZXIgPGVyaWMu
YXVnZXJAcmVkaGF0LmNvbT4NCj5TdWJqZWN0OiBSZTogW1BBVENIIHYyIDE4LzE5XSBXb3JrYXJv
dW5kIGZvciBFUlJBVEFfNzcyNDE1X1NQUjE3DQo+DQo+SGkgWmhlbnpob25nLA0KPg0KPk9uIDYv
MjAvMjUgOToxOCBBTSwgWmhlbnpob25nIER1YW4gd3JvdGU6DQo+PiBPbiBhIHN5c3RlbSBpbmZs
dWVuY2VkIGJ5IEVSUkFUQV83NzI0MTUsDQo+SU9NTVVfSFdfSU5GT19WVERfRVJSQVRBXzc3MjQx
NV9TUFIxNw0KPj4gaXMgcmVwb3JlZCBieSBJT01NVV9ERVZJQ0VfR0VUX0hXX0lORk8uIER1ZSB0
byB0aGlzIGVycmF0YSwgZXZlbiB0aGUNCj5yZWFkb25seQ0KPj4gcmFuZ2UgbWFwcGVkIG9uIHN0
YWdlLTIgcGFnZSB0YWJsZSBjb3VsZCBzdGlsbCBiZSB3cml0dGVuLg0KPg0KPkkgd291bGQgc3Bs
aXQgdGhpcyBwYXRjaCBpbnRvIGEgdmZpbyBvbmx5IHBhdGNoIGFuZCBhbiBpb21tdSBvbmUgdGhh
dA0KPnNldHMgYmNvbnRhaW5lci0+cmVhZG9ubHkgYWNjb3JkaW5nIHRvIHRoZSBmZXRjaGVkIGlu
Zm8uDQoNCldpbGwgZG8uDQoNCj4+DQo+PiBSZWZlcmVuY2UgZnJvbSA0dGggR2VuIEludGVsIFhl
b24gUHJvY2Vzc29yIFNjYWxhYmxlIEZhbWlseSBTcGVjaWZpY2F0aW9uDQo+PiBVcGRhdGUsIEVy
cmF0YSBEZXRhaWxzLCBTUFIxNy4NCj4+IGh0dHBzOi8vd3d3LmludGVsLmNvbS9jb250ZW50L3d3
dy91cy9lbi9jb250ZW50LWRldGFpbHMvNzcyNDE1L2NvbnRlbnQtDQo+ZGV0YWlscy5odG1sDQo+
dGhlIGxpbmsgZG9lcyBub3Qgd29yayBmb3IgbWUuDQoNClRoYXQncyBzdHJhbmdlLCB3aGF0IGFi
b3V0Og0KDQpodHRwczovL2VkYy5pbnRlbC5jb20vY29udGVudC93d3cvdXMvZW4vZGVzaWduL3By
b2R1Y3RzLWFuZC1zb2x1dGlvbnMvcHJvY2Vzc29ycy1hbmQtY2hpcHNldHMvZWFnbGUtc3RyZWFt
L3NhcHBoaXJlLXJhcGlkcy1zcGVjaWZpY2F0aW9uLXVwZGF0ZS8NCg0KPg0KPlBsZWFzZSBjb3Vs
ZCB5b3UgZXhwbGFpbiBpbiBlbmdsaXNoIHdoYXQgdGhlIGVycmF0YSBpcyBhYm91dCBhbmQgd2hh
dA0KPmFjdGlvbnMgbmVlZCB0byBiZSB0YWtlbiBjYXJlIGluIFZGSU8/DQo+DQo+U29ycnkgSSBm
YWlsZWQgdG8gdW5kZXJzdGFuZCAiDQo+DQo+RHVlIHRvIHRoaXMgZXJyYXRhLCBldmVuIHRoZSBy
ZWFkb25seQ0KPnJhbmdlIG1hcHBlZCBvbiBzdGFnZS0yIHBhZ2UgdGFibGUgY291bGQgc3RpbGwg
YmUgd3JpdHRlbi4NCg0KQ29weSB0aGUgZXhwbGFuYXRpb24gaW4gYWJvdmUgbGluazoNCg0KIlNQ
UjE3LiBSZW1hcHBpbmcgSGFyZHdhcmUgTWF5IFNldCBBY2Nlc3MvRGlydHkgQml0cyBpbiBhIEZp
cnN0LXN0YWdlDQpQYWdlLXRhYmxlIEVudHJ5DQoNClByb2JsZW06IFdoZW4gcmVtYXBwaW5nIGhh
cmR3YXJlIGlzIGNvbmZpZ3VyZWQgYnkgc3lzdGVtIHNvZnR3YXJlIGluDQpzY2FsYWJsZSBtb2Rl
IGFzIE5lc3RlZCAoUEdUVD0wMTFiKSBhbmQgd2l0aCBQV1NOUCBmaWVsZCBTZXQgaW4gdGhlDQpQ
QVNJRC10YWJsZS1lbnRyeSwgaXQgbWF5IFNldCBBY2Nlc3NlZCBiaXQgYW5kIERpcnR5IGJpdCAo
YW5kIEV4dGVuZGVkDQpBY2Nlc3MgYml0IGlmIGVuYWJsZWQpIGluIGZpcnN0LXN0YWdlIHBhZ2Ut
dGFibGUgZW50cmllcyBldmVuIHdoZW4NCnNlY29uZC1zdGFnZSBtYXBwaW5ncyBpbmRpY2F0ZSB0
aGF0IGNvcnJlc3BvbmRpbmcgZmlyc3Qtc3RhZ2UgcGFnZS10YWJsZQ0KaXMgUmVhZC1Pbmx5Lg0K
DQpJbXBsaWNhdGlvbjogRHVlIHRvIHRoaXMgZXJyYXR1bSwgcGFnZXMgbWFwcGVkIGFzIFJlYWQt
b25seSBpbiBzZWNvbmQtc3RhZ2UNCnBhZ2UtdGFibGVzIG1heSBiZSBtb2RpZmllZCBieSByZW1h
cHBpbmcgaGFyZHdhcmUgQWNjZXNzL0RpcnR5IGJpdCB1cGRhdGVzLg0KDQpXb3JrYXJvdW5kOiBO
b25lIGlkZW50aWZpZWQuIFN5c3RlbSBzb2Z0d2FyZSBlbmFibGluZyBuZXN0ZWQgdHJhbnNsYXRp
b25zDQpmb3IgYSBWTSBzaG91bGQgZW5zdXJlIHRoYXQgdGhlcmUgYXJlIG5vIHJlYWQtb25seSBw
YWdlcyBpbiB0aGUNCmNvcnJlc3BvbmRpbmcgc2Vjb25kLXN0YWdlIG1hcHBpbmdzLiINCg0KPg0K
PiINCj4+DQo+PiBTaWduZWQtb2ZmLWJ5OiBaaGVuemhvbmcgRHVhbiA8emhlbnpob25nLmR1YW5A
aW50ZWwuY29tPg0KPj4gLS0tDQo+PiAgaW5jbHVkZS9ody92ZmlvL3ZmaW8tY29udGFpbmVyLWJh
c2UuaCB8ICAxICsNCj4+ICBody92ZmlvL2lvbW11ZmQuYyAgICAgICAgICAgICAgICAgICAgIHwg
IDggKysrKysrKy0NCj4+ICBody92ZmlvL2xpc3RlbmVyLmMgICAgICAgICAgICAgICAgICAgIHwg
MTMgKysrKysrKysrLS0tLQ0KPj4gIDMgZmlsZXMgY2hhbmdlZCwgMTcgaW5zZXJ0aW9ucygrKSwg
NSBkZWxldGlvbnMoLSkNCj4+DQo+PiBkaWZmIC0tZ2l0IGEvaW5jbHVkZS9ody92ZmlvL3ZmaW8t
Y29udGFpbmVyLWJhc2UuaCBiL2luY2x1ZGUvaHcvdmZpby92ZmlvLQ0KPmNvbnRhaW5lci1iYXNl
LmgNCj4+IGluZGV4IGYwMjMyNjU0ZWUuLmU1YzUxYTUxYWMgMTAwNjQ0DQo+PiAtLS0gYS9pbmNs
dWRlL2h3L3ZmaW8vdmZpby1jb250YWluZXItYmFzZS5oDQo+PiArKysgYi9pbmNsdWRlL2h3L3Zm
aW8vdmZpby1jb250YWluZXItYmFzZS5oDQo+PiBAQCAtNTEsNiArNTEsNyBAQCB0eXBlZGVmIHN0
cnVjdCBWRklPQ29udGFpbmVyQmFzZSB7DQo+PiAgICAgIFFMSVNUX0hFQUQoLCBWRklPRGV2aWNl
KSBkZXZpY2VfbGlzdDsNCj4+ICAgICAgR0xpc3QgKmlvdmFfcmFuZ2VzOw0KPj4gICAgICBOb3Rp
ZmllcldpdGhSZXR1cm4gY3ByX3JlYm9vdF9ub3RpZmllcjsNCj4+ICsgICAgYm9vbCBieXBhc3Nf
cm87DQo+PiAgfSBWRklPQ29udGFpbmVyQmFzZTsNCj4+DQo+PiAgdHlwZWRlZiBzdHJ1Y3QgVkZJ
T0d1ZXN0SU9NTVUgew0KPj4gZGlmZiAtLWdpdCBhL2h3L3ZmaW8vaW9tbXVmZC5jIGIvaHcvdmZp
by9pb21tdWZkLmMNCj4+IGluZGV4IDgzYTYzMmJkZWUuLjIzODM5YTUxMWEgMTAwNjQ0DQo+PiAt
LS0gYS9ody92ZmlvL2lvbW11ZmQuYw0KPj4gKysrIGIvaHcvdmZpby9pb21tdWZkLmMNCj4+IEBA
IC0zMDYsNiArMzA2LDcgQEAgc3RhdGljIGJvb2wNCj5pb21tdWZkX2NkZXZfYXV0b2RvbWFpbnNf
Z2V0KFZGSU9EZXZpY2UgKnZiYXNlZGV2LA0KPj4gIHsNCj4+ICAgICAgRVJSUF9HVUFSRCgpOw0K
Pj4gICAgICBJT01NVUZEQmFja2VuZCAqaW9tbXVmZCA9IHZiYXNlZGV2LT5pb21tdWZkOw0KPj4g
KyAgICBzdHJ1Y3QgaW9tbXVfaHdfaW5mb192dGQgdnRkOw0KPj0ge307ID8NCg0KV2lsbCBkby4N
Cg0KPj4gICAgICB1aW50MzJfdCB0eXBlLCBmbGFncyA9IDA7DQo+PiAgICAgIHVpbnQ2NF90IGh3
X2NhcHM7DQo+PiAgICAgIFZGSU9JT0FTSHdwdCAqaHdwdDsNCj4+IEBAIC0zNDUsMTAgKzM0Niwx
NSBAQCBzdGF0aWMgYm9vbA0KPmlvbW11ZmRfY2Rldl9hdXRvZG9tYWluc19nZXQoVkZJT0Rldmlj
ZSAqdmJhc2VkZXYsDQo+PiAgICAgICAqIGluc3RlYWQuDQo+PiAgICAgICAqLw0KPj4gICAgICBp
ZiAoIWlvbW11ZmRfYmFja2VuZF9nZXRfZGV2aWNlX2luZm8odmJhc2VkZXYtPmlvbW11ZmQsIHZi
YXNlZGV2LQ0KPj5kZXZpZCwNCj4+IC0gICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAg
ICAgICAgICZ0eXBlLCBOVUxMLCAwLCAmaHdfY2FwcywgZXJycCkpIHsNCj4+ICsgICAgICAgICAg
ICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICZ0eXBlLCAmdnRkLCBzaXplb2YodnRkKSwg
Jmh3X2NhcHMsDQo+PiArICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICBl
cnJwKSkgew0KPj4gICAgICAgICAgcmV0dXJuIGZhbHNlOw0KPj4gICAgICB9DQo+Pg0KPj4gKyAg
ICBpZiAodnRkLmZsYWdzICYgSU9NTVVfSFdfSU5GT19WVERfRVJSQVRBXzc3MjQxNV9TUFIxNykg
ew0KPj4gKyAgICAgICAgY29udGFpbmVyLT5iY29udGFpbmVyLmJ5cGFzc19ybyA9IHRydWU7DQo+
PiArICAgIH0NCj4+ICsNCj4+ICAgICAgaWYgKGh3X2NhcHMgJiBJT01NVV9IV19DQVBfRElSVFlf
VFJBQ0tJTkcpIHsNCj4+ICAgICAgICAgIGZsYWdzID0gSU9NTVVfSFdQVF9BTExPQ19ESVJUWV9U
UkFDS0lORzsNCj4+ICAgICAgfQ0KPj4gZGlmZiAtLWdpdCBhL2h3L3ZmaW8vbGlzdGVuZXIuYyBi
L2h3L3ZmaW8vbGlzdGVuZXIuYw0KPj4gaW5kZXggZjQ5OGUyM2E5My4uYzY0YWE0NTM5ZSAxMDA2
NDQNCj4+IC0tLSBhL2h3L3ZmaW8vbGlzdGVuZXIuYw0KPj4gKysrIGIvaHcvdmZpby9saXN0ZW5l
ci5jDQo+PiBAQCAtMzY0LDcgKzM2NCw4IEBAIHN0YXRpYyBib29sDQo+dmZpb19rbm93bl9zYWZl
X21pc2FsaWdubWVudChNZW1vcnlSZWdpb25TZWN0aW9uICpzZWN0aW9uKQ0KPj4gICAgICByZXR1
cm4gdHJ1ZTsNCj4+ICB9DQo+Pg0KPj4gLXN0YXRpYyBib29sIHZmaW9fbGlzdGVuZXJfdmFsaWRf
c2VjdGlvbihNZW1vcnlSZWdpb25TZWN0aW9uICpzZWN0aW9uLA0KPj4gK3N0YXRpYyBib29sIHZm
aW9fbGlzdGVuZXJfdmFsaWRfc2VjdGlvbihWRklPQ29udGFpbmVyQmFzZSAqYmNvbnRhaW5lciwN
Cj4+ICsgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgTWVtb3J5UmVnaW9u
U2VjdGlvbiAqc2VjdGlvbiwNCj4+ICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAg
ICAgICAgY29uc3QgY2hhciAqbmFtZSkNCj4+ICB7DQo+PiAgICAgIGlmICh2ZmlvX2xpc3RlbmVy
X3NraXBwZWRfc2VjdGlvbihzZWN0aW9uKSkgew0KPj4gQEAgLTM3NSw2ICszNzYsMTAgQEAgc3Rh
dGljIGJvb2wNCj52ZmlvX2xpc3RlbmVyX3ZhbGlkX3NlY3Rpb24oTWVtb3J5UmVnaW9uU2VjdGlv
biAqc2VjdGlvbiwNCj4+ICAgICAgICAgIHJldHVybiBmYWxzZTsNCj4+ICAgICAgfQ0KPj4NCj4+
ICsgICAgaWYgKGJjb250YWluZXIgJiYgYmNvbnRhaW5lci0+YnlwYXNzX3JvICYmIHNlY3Rpb24t
PnJlYWRvbmx5KSB7DQo+PiArICAgICAgICByZXR1cm4gZmFsc2U7DQo+PiArICAgIH0NCj4+ICsN
Cj4+ICAgICAgaWYgKHVubGlrZWx5KChzZWN0aW9uLT5vZmZzZXRfd2l0aGluX2FkZHJlc3Nfc3Bh
Y2UgJg0KPj4gICAgICAgICAgICAgICAgICAgIH5xZW11X3JlYWxfaG9zdF9wYWdlX21hc2soKSkg
IT0NCj4+ICAgICAgICAgICAgICAgICAgIChzZWN0aW9uLT5vZmZzZXRfd2l0aGluX3JlZ2lvbiAm
IH5xZW11X3JlYWxfaG9zdF9wYWdlX21hc2soKSkpKSB7DQo+PiBAQCAtNDk0LDcgKzQ5OSw3IEBA
IHZvaWQgdmZpb19jb250YWluZXJfcmVnaW9uX2FkZChWRklPQ29udGFpbmVyQmFzZQ0KPipiY29u
dGFpbmVyLA0KPj4gICAgICBpbnQgcmV0Ow0KPj4gICAgICBFcnJvciAqZXJyID0gTlVMTDsNCj4+
DQo+PiAtICAgIGlmICghdmZpb19saXN0ZW5lcl92YWxpZF9zZWN0aW9uKHNlY3Rpb24sICJyZWdp
b25fYWRkIikpIHsNCj4+ICsgICAgaWYgKCF2ZmlvX2xpc3RlbmVyX3ZhbGlkX3NlY3Rpb24oYmNv
bnRhaW5lciwgc2VjdGlvbiwgInJlZ2lvbl9hZGQiKSkgew0KPj4gICAgICAgICAgcmV0dXJuOw0K
Pj4gICAgICB9DQo+Pg0KPj4gQEAgLTY1NSw3ICs2NjAsNyBAQCBzdGF0aWMgdm9pZCB2ZmlvX2xp
c3RlbmVyX3JlZ2lvbl9kZWwoTWVtb3J5TGlzdGVuZXINCj4qbGlzdGVuZXIsDQo+PiAgICAgIGlu
dCByZXQ7DQo+PiAgICAgIGJvb2wgdHJ5X3VubWFwID0gdHJ1ZTsNCj4+DQo+PiAtICAgIGlmICgh
dmZpb19saXN0ZW5lcl92YWxpZF9zZWN0aW9uKHNlY3Rpb24sICJyZWdpb25fZGVsIikpIHsNCj4+
ICsgICAgaWYgKCF2ZmlvX2xpc3RlbmVyX3ZhbGlkX3NlY3Rpb24oYmNvbnRhaW5lciwgc2VjdGlv
biwgInJlZ2lvbl9kZWwiKSkgew0KPj4gICAgICAgICAgcmV0dXJuOw0KPj4gICAgICB9DQo+Pg0K
Pj4gQEAgLTgxMiw3ICs4MTcsNyBAQCBzdGF0aWMgdm9pZCB2ZmlvX2RpcnR5X3RyYWNraW5nX3Vw
ZGF0ZShNZW1vcnlMaXN0ZW5lcg0KPipsaXN0ZW5lciwNCj4+ICAgICAgICAgIGNvbnRhaW5lcl9v
ZihsaXN0ZW5lciwgVkZJT0RpcnR5UmFuZ2VzTGlzdGVuZXIsIGxpc3RlbmVyKTsNCj4+ICAgICAg
aHdhZGRyIGlvdmEsIGVuZDsNCj4+DQo+PiAtICAgIGlmICghdmZpb19saXN0ZW5lcl92YWxpZF9z
ZWN0aW9uKHNlY3Rpb24sICJ0cmFja2luZ191cGRhdGUiKSB8fA0KPj4gKyAgICBpZiAoIXZmaW9f
bGlzdGVuZXJfdmFsaWRfc2VjdGlvbihOVUxMLCBzZWN0aW9uLCAidHJhY2tpbmdfdXBkYXRlIikg
fHwNCj4+ICAgICAgICAgICF2ZmlvX2dldF9zZWN0aW9uX2lvdmFfcmFuZ2UoZGlydHktPmJjb250
YWluZXIsIHNlY3Rpb24sDQo+PiAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAg
ICZpb3ZhLCAmZW5kLCBOVUxMKSkgew0KPj4gICAgICAgICAgcmV0dXJuOw0KPlRoYW5rcw0KPg0K
PkVyaWMNCg0K

