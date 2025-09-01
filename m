Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E4DF4CA0FE8
	for <qemu-devel@archiver.kernel.org>; Mon,  1 Sep 2025 03:18:24 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1usv3Q-0000rU-RT; Sun, 31 Aug 2025 23:18:00 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <zhenzhong.duan@intel.com>)
 id 1usv3K-0000qU-MK
 for qemu-devel@nongnu.org; Sun, 31 Aug 2025 23:17:54 -0400
Received: from mgamail.intel.com ([192.198.163.15])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <zhenzhong.duan@intel.com>)
 id 1usv3G-0002LM-Ng
 for qemu-devel@nongnu.org; Sun, 31 Aug 2025 23:17:53 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1756696670; x=1788232670;
 h=from:to:cc:subject:date:message-id:references:
 in-reply-to:content-transfer-encoding:mime-version;
 bh=4hvldhP6LDY1OGqiTAlIYxWosAgewgvWpmWffDFwdSA=;
 b=Vr3RwnYob2Hi1ox6jPV6pI44AxvypO4ldY0TJcce1eXIky61ld/EnzHo
 wPVBQjjRt8Ve4l0+S6vfPpDGYoxNYSfAwpMsKXGbk+ObOHDcE7iy7LMuV
 AdZBAu1fm4lU7fSkA/Glhea7vJC9x9G39LnYa2SPdIaRF6P0GKldUxY5E
 zFb+zYl0sd9u3+NJfKts68kL5wCuoGVDc7/4VEnXJi3ESlqzoqQc5vQWz
 Y3em8KMSeMONM2/hgYwNVn4l6/G8nrXh8tTKxJBe3Xa7eJTQJchDr3+/i
 6Et2mrUMtz/hpJp1aCxJ/zyNMIjBrOPjwLfZEGXDb0NQDI7BfYbPzryf9 g==;
X-CSE-ConnectionGUID: 8dmPuvJIRHiew33/X1YlKA==
X-CSE-MsgGUID: mSoaZu0ERt+G74vMT+n+qw==
X-IronPort-AV: E=McAfee;i="6800,10657,11539"; a="58991334"
X-IronPort-AV: E=Sophos;i="6.18,225,1751266800"; d="scan'208";a="58991334"
Received: from orviesa009.jf.intel.com ([10.64.159.149])
 by fmvoesa109.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 31 Aug 2025 20:17:47 -0700
X-CSE-ConnectionGUID: GSFGTIQmR6ac/yahjMw3zw==
X-CSE-MsgGUID: DHicFKgkTvCAQcM0vfhHWQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.18,225,1751266800"; d="scan'208";a="170419772"
Received: from fmsmsx903.amr.corp.intel.com ([10.18.126.92])
 by orviesa009.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 31 Aug 2025 20:17:47 -0700
Received: from FMSMSX902.amr.corp.intel.com (10.18.126.91) by
 fmsmsx903.amr.corp.intel.com (10.18.126.92) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.17; Sun, 31 Aug 2025 20:17:46 -0700
Received: from fmsedg901.ED.cps.intel.com (10.1.192.143) by
 FMSMSX902.amr.corp.intel.com (10.18.126.91) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.17 via Frontend Transport; Sun, 31 Aug 2025 20:17:46 -0700
Received: from NAM10-DM6-obe.outbound.protection.outlook.com (40.107.93.57) by
 edgegateway.intel.com (192.55.55.81) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.17; Sun, 31 Aug 2025 20:17:45 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=TLr7lA6wWIPg/dqRxj/tfnTKs962seQUm1LEskJ9a6NyIOAgTPn+Aa+kxmeGb5oPa1kmkPQm6GT5Bk7snKtbaqV5W6szlwIVK+lprHVozeAwZQznRvEbW6Jsj1SFrGkgOE4uY/lSh+cz/1Mp0S6Pw6oYooowWGUYyqM1/efhm1vOXm1iXC41XeGR8f+0559c32HVkca/1qNgeOwiQ1/+zYSxR8aK1BFKANEtwOj8tUU3RQJqUcR4p3GUrzR3AqHVhWz19cJ0Jru09j7RKCllf8oF3TjVwSdmiOR2B/xSHRG7kbbfRAia9YecBTEvowe04MNatxq9RDqXwo9C6tNW0w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=4hvldhP6LDY1OGqiTAlIYxWosAgewgvWpmWffDFwdSA=;
 b=IVEQPJK+sFRxLbLnONd5+zWS1ItUdTJPALhC2TuPaB5aO/03BVItIiGs2MSZe6WMjEfOTTaZrm4MAzYUAYT2tvkspyfIatYsku/Lvw5VGYwVLVhcp2b/ecYmhxLoZ1rKl2RT14ssA/csDmhRTuR+LCSqyGeOuarYz/ztVJIMttO0QOWP+jsxB58NVbrTfsAmPvYgNqahAqC0qoqSOSI0KMlL28XK0IX2yAGSYtM/Beddj29nlPJFTU43o9AjHPxY3hPpAkihY/f6apwTfCDIFOsONcJ34xfW5vYS+oqPOsqEMWNJuBFbRz8TVRoQNWM2Fm9KltTSApxqLDNpFT7a9w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Received: from IA3PR11MB9136.namprd11.prod.outlook.com (2603:10b6:208:574::12)
 by IA1PR11MB7199.namprd11.prod.outlook.com (2603:10b6:208:418::21)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9073.21; Mon, 1 Sep
 2025 03:17:42 +0000
Received: from IA3PR11MB9136.namprd11.prod.outlook.com
 ([fe80::604b:77a4:b1be:3f13]) by IA3PR11MB9136.namprd11.prod.outlook.com
 ([fe80::604b:77a4:b1be:3f13%4]) with mapi id 15.20.9052.019; Mon, 1 Sep 2025
 03:17:42 +0000
From: "Duan, Zhenzhong" <zhenzhong.duan@intel.com>
To: "eric.auger@redhat.com" <eric.auger@redhat.com>, "qemu-devel@nongnu.org"
 <qemu-devel@nongnu.org>
CC: "alex.williamson@redhat.com" <alex.williamson@redhat.com>,
 "clg@redhat.com" <clg@redhat.com>, "mst@redhat.com" <mst@redhat.com>,
 "jasowang@redhat.com" <jasowang@redhat.com>, "peterx@redhat.com"
 <peterx@redhat.com>, "ddutile@redhat.com" <ddutile@redhat.com>,
 "jgg@nvidia.com" <jgg@nvidia.com>, "nicolinc@nvidia.com"
 <nicolinc@nvidia.com>, "joao.m.martins@oracle.com"
 <joao.m.martins@oracle.com>, "clement.mathieu--drif@eviden.com"
 <clement.mathieu--drif@eviden.com>, "Tian, Kevin" <kevin.tian@intel.com>,
 "Liu, Yi L" <yi.l.liu@intel.com>, "Peng, Chao P" <chao.p.peng@intel.com>, "Yi
 Sun" <yi.y.sun@linux.intel.com>
Subject: RE: [PATCH v5 11/21] intel_iommu: Handle PASID entry removal and
 update
Thread-Topic: [PATCH v5 11/21] intel_iommu: Handle PASID entry removal and
 update
Thread-Index: AQHcEy/oRsc7Lu/sH0aYzDboCey+yrR2loCAgAcd4yA=
Date: Mon, 1 Sep 2025 03:17:42 +0000
Message-ID: <IA3PR11MB9136E44B94B992854AC4593F9207A@IA3PR11MB9136.namprd11.prod.outlook.com>
References: <20250822064101.123526-1-zhenzhong.duan@intel.com>
 <20250822064101.123526-12-zhenzhong.duan@intel.com>
 <2c150f38-6404-4b1b-912b-8f39658081f1@redhat.com>
In-Reply-To: <2c150f38-6404-4b1b-912b-8f39658081f1@redhat.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: IA3PR11MB9136:EE_|IA1PR11MB7199:EE_
x-ms-office365-filtering-correlation-id: 921d0f63-f0f9-4715-3c2f-08dde9061d5b
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
 ARA:13230040|366016|7416014|376014|1800799024|38070700018; 
x-microsoft-antispam-message-info: =?utf-8?B?aC9EK3VoOXJHendmM0YxeFJINWxWS01rem9EakVGNlQwTDJPYlZRTzZpcnFW?=
 =?utf-8?B?NmhlSjBoTXRlVzVid1FaSUIvVWFDeUV4SDh3STJyaGJlRjZBWmhHeHBsQURF?=
 =?utf-8?B?UkgwNUdCU0k3TFlDSmJPazZqaW5IbjZ4TDc1NXFtUHlGSHVTRm8zYVROQk9E?=
 =?utf-8?B?NmhEQXMwY0MwMi9aVFdaRFFIU1puZFpHUzk5N2ZmdVZSUHZ2aHBBNWxiY29C?=
 =?utf-8?B?ckdvTUZZdFdmOUgvSDBYaU13UU0vOUZ6SEtjYzdDQ1NzejQvK3FHY1M0TTcz?=
 =?utf-8?B?UHNiSkc5T3BlbVU2QWFUeU9Zd3EvYnJHdFhTclZQQTVmaDh0QzNmNkIyNStl?=
 =?utf-8?B?QTkyMXNSbFNianpxU09UaFJNays0RGQ2a0ZFN3I1V005ZVdRYU1VMnRGOVgy?=
 =?utf-8?B?djVIRnduS2I1Q3hhWDlTNlhIbmZDL0xTTDJEYjc1SEZFQ01hTzl1SnByaEhY?=
 =?utf-8?B?Y1ZRUytsTEd4NEJ4KytYREd4NVBiK2ljcFhRVU9jcWU4VWl5dGhRT3Y0TWNj?=
 =?utf-8?B?TU9YNGRYVWxsbU85Ym4xeVIwRWVhcUgvcEhvZTVaWWFlNzhqSUJGREVZZlBL?=
 =?utf-8?B?OGR1bWs0VEpoUUtneXU0TEJudWxKYUdnSVZBQ2gzZHlpUGhXUmlpb2MyVGx5?=
 =?utf-8?B?WHRteXBlWGdlRmhvbGVtYTRodSs4TmswWXVma0pWRm02WGJ3TkFhZitncU1I?=
 =?utf-8?B?WWJkYzYvdHB6Z0I4aVBVQ05aTFV0V05vUnpzNXFZZEExU2tGaEY2eGxVVm9r?=
 =?utf-8?B?OTkwZTdRazFBK1V3RzZlNmtjUHVZenY2bzRUS0d6R3U5UGV6Ni9zQzhaZkVw?=
 =?utf-8?B?YU84MkxLRHhtcHhBU2Y5SEt5bjhNdytZK3kvMGNFMGRoSmd6a2ZCSSs3V1Rv?=
 =?utf-8?B?U2h4TkR6cDFtZmNUaGZtcGJJUnhjaDQ1ZlBRSjQ4WE1pM1U5T0lFSUFQYlFy?=
 =?utf-8?B?dVV6ZU5VVUl3RWNzQmFJQ204YXV2TWJVcENaTndNdituMjZoRjNiTWVtWlBw?=
 =?utf-8?B?cUZtcW1qc3psUzZIM1QrbndhSlFGeTJSVUNXTFQ1Q2xFeU9NOEo1M3hibGR1?=
 =?utf-8?B?cEt6ODBFdmluY2ZWRTUrVWJlTkgyZWp4VXV0V09DNmUxU3ZrczFJaW1pOW9T?=
 =?utf-8?B?YmJ4bExNWVAxL3dPOHNEWGF3M2lzbExyTFl6OFZkWnBYY04zaVVqQnFHM2Vi?=
 =?utf-8?B?MjB6b0ZsU2tpM1NpWGxQVzArUEVDUU1aU001UWgzZlJjeW9yendPalQ5RVpS?=
 =?utf-8?B?c0hDN0t4UnhoalNRTHBRQXhtVzd5Y3BoNXlEcjhMM1NhWHlZeERkSnQ1UVlJ?=
 =?utf-8?B?VU5EUTVlaEd4TVVKV2p3WDVBLzV5WWVXNXJBZUZLckowdXFiQTJBRTN5N3Y3?=
 =?utf-8?B?NDcyZzBLd1FQMVFmQWEyY3RweHlLWkRlcnBYWUxSaXQvSjFPUXdBSklZQ2FN?=
 =?utf-8?B?WUpwOUIyejdjeGZOakFCdTRxb2FTV252Y2Jiazk0bC9SN1NLTnMzRFBpcXFI?=
 =?utf-8?B?c0EzRmx1QVFTSzFiSHBEU3puNnhNYXVTNCtkQ0hCYXlxMGxsWU8rYkZDSGtG?=
 =?utf-8?B?ejNrdVZiVFYvM1dvSUZ2WTRzMXhzSGdmU25MOGpOM1pUbmhXUTZQTlQyRTZm?=
 =?utf-8?B?UzZVOUg4aTMyRDRzT0JmUmlza05xTUlzQ0V5Rms4U1JJRUNSMFJxaEZQdHlT?=
 =?utf-8?B?QWwrNzM0NzFSM0xBOXRINVlac0VYRmZONzVaRld6QVFnRzA4bVl2ZFdtZlJj?=
 =?utf-8?B?YjY0NkhpTkhVREZ0cGpnei9SWVdZSlFFQlNQV09BVW9XamJlQ1dMZWFSMkcw?=
 =?utf-8?B?ejVqMkE5TGhPR2dwUThpN2czRENhSnpXNC9raVQ2NHl3V0htVHBGSStZQzBy?=
 =?utf-8?B?ZmkyYnVNTXp4MlBDWTRKL21jb0F0dWRhbnMrUXBtdkg2dTNBd1ZsMit4VmZL?=
 =?utf-8?B?M1I4SWFwMkxsM3dENkEwbkpsRmdIS09MR2pPRFdxUUhCQ3hLSjRqT092dmlz?=
 =?utf-8?Q?ZppUMGhe9hJHNCIe7yTQyRymdXqLIU=3D?=
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:IA3PR11MB9136.namprd11.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(366016)(7416014)(376014)(1800799024)(38070700018); DIR:OUT;
 SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?NDBtZzlrNWRYU0w4RTIyZjRBMlA2Uml0dXN4Nnp1WC9QRlkxQTdUcDdKTlhF?=
 =?utf-8?B?eWd3anJucWJkTVpzc2ZQTmp1N1RvWUJGYnFOYWxPVjNPTUZ3SnBQNThvTVNF?=
 =?utf-8?B?dlpRTmRlLzFGckIvbm54YWdJZzF6Yzl2SzFhNGZheW9DdUxZeVNGOUZTZVMx?=
 =?utf-8?B?SFhzNDJ0bVdzdjgvbnBFVWVLMWY3d204NVFmdHhiVUdTOEhnODRJbTc5S056?=
 =?utf-8?B?dlE5S2QrNitwWG5rQktKcXZlNmRhZk5UcGozdFZiVFdSZjBGekZaeVJzNmNv?=
 =?utf-8?B?U0ZkZ3UxenpLYnBxVDBlQjVqbWsyUEVLN1VkUmxmRGZ1QVJnQ1lLTWFUQjdZ?=
 =?utf-8?B?ZVBaSjNKM241RksvU1FWSUhIdDJvV20wazVLRnd6K2JhNDAzSUJiSTNzTWJD?=
 =?utf-8?B?eTJpWXB3SzRUR1U3SjV2ZzRuRmRBRVJ2dm54Nm1wRHhYTUduMzlYNnc4R0h1?=
 =?utf-8?B?dzlJUGI4TEM2M3Y2cDErQ2dDZmJmZDNVelZ4MkRmMWx4VlFsWmFNbFhTUHM2?=
 =?utf-8?B?REZYc2M3Vk4zYWVPNWpHRHpOcDVQYk1jcVhKaGZ4UmhjYVI4dm8vQ1VUNm1i?=
 =?utf-8?B?aGJBZU10WitqYWhKakVHUTY1Mjh3Vy95eE5kRzlMaXBteVd0QkYxTHN3MXEy?=
 =?utf-8?B?Z3ZadUxQVzdwZnFuUEFSV0Z5MHhTN0NoSmxocVd5TEhUL2JlSjhFam5XOWl6?=
 =?utf-8?B?Sit1M0dmUlpEMDFrdUdmalMzVmRrbUxBQiswNkd1TlFJeHhyZ0FXTFN5ZnZB?=
 =?utf-8?B?dlByelBCb0tUMnllckRwWUlqT3ZhMWhEdFJDRm9hTDhBdFFYbmcwcjc5dVpG?=
 =?utf-8?B?dFY5b3YvVTdSTWt0ZkVRK2RaSU1oN25WWjFpRjFuS3psbzVaZjk1b3dZc2th?=
 =?utf-8?B?djJ2ckdJM3UwajJhRERMbUpZZjZoS21rZFVOVFdNR0RubnZjeVVvcnQwN3k1?=
 =?utf-8?B?REZsdHl0eXVxRkhMblcvY3dESG4ycko3Qm02V1Y3NUdkdGI2V1p6S0xiejdI?=
 =?utf-8?B?Q1o2OHBOZStTOW44OG94Q0lJRDM0ZkdGcjZhNHBRVmZhWC8wUjVVUnJScnlY?=
 =?utf-8?B?UEo2VlNyeGZuU25ESWJsdjMxbEY3cS80NWx6VFB2SDd0c01GcFg1RTMxL2xv?=
 =?utf-8?B?V0trc3EzTHc3eGZTclpoMFRicHJQUGFzaVlxZ3dmdEJIS043ZWtYTkZYbUha?=
 =?utf-8?B?b1d5QWVFTjVwN2JYckl0K0dlL0hwaTdKZkRqMHU1SmJWS2pLVisrUkNubWkx?=
 =?utf-8?B?WEdvZ0RFa1F4VTNzU0xHSTBTSmhvc3dWNGJJdnRuNHRSb3lrR2xuNVg3cDIr?=
 =?utf-8?B?UmVUdUVFRHlqQm5McHQydkRnMlMyekpaaVhyRHd3Y2JvNjJ5YnpBQzBLNnJn?=
 =?utf-8?B?b0xjdEdWR0xjSElMcExjdVJNbzdUdmowcHJibjJjOFhzWmVUU1R4bTBWV0w0?=
 =?utf-8?B?L2E3S1FuN3ZZdnNuQ3AyVkVUc0lxZ3lydlVPRkJJSUM2NHVzRlB6WTVTNXg2?=
 =?utf-8?B?a0s2WDd1bjd6SVUwWVJFcW1EclNRTUhHWndUKzJhdGpGazlQeUMvbUUvRC9j?=
 =?utf-8?B?Z3VFNVNlaW12dExFd3RTMHl6T2dyRFdsMFU3akpnSjM4MlpxR09qK2lVQ2dX?=
 =?utf-8?B?M0hRVVVWVkYrakU3YlVqNHlxSno3bFNVUm5XK2NGMjdBZVNCNFlsR1lrbWFM?=
 =?utf-8?B?YkEwaU9Wa3pGRitDYmtFWkRCbGpzdzc1aE1DVVJRL2JpT1A4YkhKaWRzaklW?=
 =?utf-8?B?WkF4aUFCQW9kMEw1NkNVU1IzSjh6MFRDWGVmU2xIalpzUU1jRDdSWUxSRjNG?=
 =?utf-8?B?WitMczdad0w3MEFUR1JCWUUyUXhZVkF3OFIzbDEybjYyZ3QvSjhzLzJLbUIr?=
 =?utf-8?B?QTRDcUdiVTlqN05JVGR4QlBWdmFvMENlOWorNlFNRVNYVFIvQzVTSmFqeVpJ?=
 =?utf-8?B?SlZTTkZMUWprWlVJZ0lpZC9BQ1p0N1crSkhTbVVQb3BwbTBPVXRkRVIvZmxN?=
 =?utf-8?B?dE5sQjA3dTN0VG1YelNXUjNPdTFHQllxd3NRL0xXYWVvclhsb0lBU2JhNXZt?=
 =?utf-8?B?WmtvK0tTZmVLNG1IeUxJMGVNRUd1NjhRdERHcmdGWnZldDc1emcweTM4M3BT?=
 =?utf-8?Q?pmm1cxqWOL/YpGRrpZlXVeae3?=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: IA3PR11MB9136.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 921d0f63-f0f9-4715-3c2f-08dde9061d5b
X-MS-Exchange-CrossTenant-originalarrivaltime: 01 Sep 2025 03:17:42.7668 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: k/802mEW7zUYaEUEEW+/GWOhWFfyAzRNpZLBJoHUM7Dy7u1XLHirsO63e9kq3MPcFzZDERQMAYtfQGcO5vb+qh/zWm9YG30JTdwr1xaMrqI=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA1PR11MB7199
X-OriginatorOrg: intel.com
Received-SPF: pass client-ip=192.198.163.15;
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
YXVnZXJAcmVkaGF0LmNvbT4NCj5TdWJqZWN0OiBSZTogW1BBVENIIHY1IDExLzIxXSBpbnRlbF9p
b21tdTogSGFuZGxlIFBBU0lEIGVudHJ5IHJlbW92YWwgYW5kDQo+dXBkYXRlDQpzbmlwLi4uDQoN
Cj4+ICsNCj4+ICsvKg0KPj4gKyAqIFRoaXMgZnVuY3Rpb24gaXMgYSBsb29wIGZ1bmN0aW9uIHdo
aWNoIHJldHVybiB2YWx1ZSBkZXRlcm1pbmVzIGlmDQo+d2hvc2UgcmV0dXJuZWQgdmFsdWUgZGV0
ZXJtaW5lcyB3aGV0aGVyIGN1cnJlbnQgdnRkX2FzIGl0ZXJhdG9yIG1hdGNoZXMNCj50aGUgcGFz
aWQgY2FjaGUgZW50cnkgaW5mbyBwYXNzZWQgaW4gdXNlcl9kYXRhIGFuZCBuZWVkcyB0byBiZSBy
ZW1vdmVkDQo+ZnJvbSB0aGUgcGFzaWQgY2FjaGUuDQoNCldpbGwgZG8uDQoNCj4+ICsgKiB2dGRf
YXMgaW5jbHVkaW5nIGNhY2hlZCBwYXNpZCBlbnRyeSBpcyByZW1vdmVkLg0KPj4gKyAqDQo+PiAr
ICogRm9yIFBDSV9OT19QQVNJRCwgd2hlbiBjb3JyZXNwb25kaW5nIGNhY2hlZCBwYXNpZCBlbnRy
eSBpcyBjbGVhcmVkLA0KPj4gKyAqIGl0IHJldHVybnMgZmFsc2Ugc28gdGhhdCB2dGRfYXMgaXMg
cmVzZXJ2ZWQgYXMgaXQncyBvd25lZCBieSBQQ0kNCj4+ICsgKiBzdWItc3lzdGVtLiBGb3Igb3Ro
ZXIgcGFzaWQsIGl0IHJldHVybnMgdHJ1ZSBzbyB2dGRfYXMgaXMgcmVtb3ZlZC4NCj4+ICsgKi8N
Cj4+ICtzdGF0aWMgZ2Jvb2xlYW4gdnRkX2ZsdXNoX3Bhc2lkX2xvY2tlZChncG9pbnRlciBrZXks
IGdwb2ludGVyIHZhbHVlLA0KPj4gKyAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAg
ICAgIGdwb2ludGVyIHVzZXJfZGF0YSkNCj4+ICt7DQo+PiArICAgIFZURFBBU0lEQ2FjaGVJbmZv
ICpwY19pbmZvID0gdXNlcl9kYXRhOw0KPj4gKyAgICBWVERBZGRyZXNzU3BhY2UgKnZ0ZF9hcyA9
IHZhbHVlOw0KPj4gKyAgICBWVERQQVNJRENhY2hlRW50cnkgKnBjX2VudHJ5ID0gJnZ0ZF9hcy0+
cGFzaWRfY2FjaGVfZW50cnk7DQo+PiArICAgIFZURFBBU0lERW50cnkgcGU7DQo+PiArICAgIHVp
bnQxNl90IGRpZDsNCj4+ICsgICAgdWludDMyX3QgcGFzaWQ7DQo+PiArICAgIGludCByZXQ7DQo+
PiArDQo+PiArICAgIGlmICghcGNfZW50cnktPnZhbGlkKSB7DQo+PiArICAgICAgICByZXR1cm4g
ZmFsc2U7DQo+PiArICAgIH0NCj4+ICsgICAgZGlkID0gVlREX1NNX1BBU0lEX0VOVFJZX0RJRCgm
cGNfZW50cnktPnBhc2lkX2VudHJ5KTsNCj4+ICsNCj4+ICsgICAgaWYgKHZ0ZF9hc190b19pb21t
dV9wYXNpZF9sb2NrZWQodnRkX2FzLCAmcGFzaWQpKSB7DQo+PiArICAgICAgICBnb3RvIHJlbW92
ZTsNCj4+ICsgICAgfQ0KPj4gKw0KPj4gKyAgICBzd2l0Y2ggKHBjX2luZm8tPnR5cGUpIHsNCj4+
ICsgICAgY2FzZSBWVERfUEFTSURfQ0FDSEVfUEFTSURTSToNCj4+ICsgICAgICAgIGlmIChwY19p
bmZvLT5wYXNpZCAhPSBwYXNpZCkgew0KPj4gKyAgICAgICAgICAgIHJldHVybiBmYWxzZTsNCj4+
ICsgICAgICAgIH0NCj4+ICsgICAgICAgIC8qIGZhbGwgdGhyb3VnaCAqLw0KPj4gKyAgICBjYXNl
IFZURF9QQVNJRF9DQUNIRV9ET01TSToNCj4+ICsgICAgICAgIGlmIChwY19pbmZvLT5kaWQgIT0g
ZGlkKSB7DQo+PiArICAgICAgICAgICAgcmV0dXJuIGZhbHNlOw0KPj4gKyAgICAgICAgfQ0KPj4g
KyAgICAgICAgLyogZmFsbCB0aHJvdWdoICovDQo+PiArICAgIGNhc2UgVlREX1BBU0lEX0NBQ0hF
X0dMT0JBTF9JTlY6DQo+PiArICAgICAgICBicmVhazsNCj4+ICsgICAgZGVmYXVsdDoNCj4+ICsg
ICAgICAgIGVycm9yX3NldGcoJmVycm9yX2ZhdGFsLCAiaW52YWxpZCBwY19pbmZvLT50eXBlIGZv
ciBmbHVzaCIpOw0KPj4gKyAgICB9DQo+PiArDQo+PiArICAgIC8qDQo+PiArICAgICAqIHBhc2lk
IGNhY2hlIGludmFsaWRhdGlvbiBtYXkgaW5kaWNhdGUgYSBwcmVzZW50IHBhc2lkIGVudHJ5IHRv
DQo+cHJlc2VudA0KPj4gKyAgICAgKiBwYXNpZCBlbnRyeSBtb2RpZmljYXRpb24uIFRvIGNvdmVy
IHN1Y2ggY2FzZSwgdklPTU1VIGVtdWxhdG9yDQo+bmVlZHMgdG8NCj4+ICsgICAgICogZmV0Y2gg
bGF0ZXN0IGd1ZXN0IHBhc2lkIGVudHJ5IGFuZCBjb21wYXJlcyB3aXRoIGNhY2hlZCBwYXNpZA0K
PmVudHJ5LA0KPj4gKyAgICAgKiB0aGVuIHVwZGF0ZSBwYXNpZCBjYWNoZS4NCj4+ICsgICAgICov
DQo+PiArICAgIHJldCA9IHZ0ZF9kZXZfZ2V0X3BlX2Zyb21fcGFzaWQodnRkX2FzLCBwYXNpZCwg
JnBlKTsNCj4+ICsgICAgaWYgKHJldCkgew0KPj4gKyAgICAgICAgLyoNCj4+ICsgICAgICAgICAq
IE5vIHZhbGlkIHBhc2lkIGVudHJ5IGluIGd1ZXN0IG1lbW9yeS4gZS5nLiBwYXNpZCBlbnRyeSB3
YXMNCj5tb2RpZmllZA0KPj4gKyAgICAgICAgICogdG8gYmUgZWl0aGVyIGFsbC16ZXJvIG9yIG5v
bi1wcmVzZW50LiBFaXRoZXIgY2FzZSBtZWFucw0KPmV4aXN0aW5nDQo+PiArICAgICAgICAgKiBw
YXNpZCBjYWNoZSBzaG91bGQgYmUgcmVtb3ZlZC4NCj4+ICsgICAgICAgICAqLw0KPj4gKyAgICAg
ICAgZ290byByZW1vdmU7DQo+PiArICAgIH0NCj4+ICsNCj4+ICsgICAgLyoNCj4+ICsgICAgICog
VXBkYXRlIGNhY2hlZCBwYXNpZCBlbnRyeSBpZiBpdCdzIHN0YWxlIGNvbXBhcmVkIHRvIHdoYXQn
cyBpbiBndWVzdA0KPj4gKyAgICAgKiBtZW1vcnkuDQo+PiArICAgICAqLw0KPj4gKyAgICBpZiAo
IXZ0ZF9wYXNpZF9lbnRyeV9jb21wYXJlKCZwZSwgJnBjX2VudHJ5LT5wYXNpZF9lbnRyeSkpIHsN
Cj4+ICsgICAgICAgIHBjX2VudHJ5LT5wYXNpZF9lbnRyeSA9IHBlOw0KPj4gKyAgICB9DQo+PiAr
ICAgIHJldHVybiBmYWxzZTsNCj4+ICsNCj4+ICtyZW1vdmU6DQo+PiArICAgIHBjX2VudHJ5LT52
YWxpZCA9IGZhbHNlOw0KPj4gKw0KPj4gKyAgICAvKg0KPj4gKyAgICAgKiBEb24ndCByZW1vdmUg
YWRkcmVzcyBzcGFjZSBvZiBQQ0lfTk9fUEFTSUQgd2hpY2ggaXMgY3JlYXRlZCBmb3INCj5QQ0kN
Cj4+ICsgICAgICogc3ViLXN5c3RlbS4NCj4+ICsgICAgICovDQo+PiArICAgIGlmICh2dGRfYXMt
PnBhc2lkID09IFBDSV9OT19QQVNJRCkgew0KPj4gKyAgICAgICAgcmV0dXJuIGZhbHNlOw0KPj4g
KyAgICB9DQo+PiArICAgIHJldHVybiB0cnVlOw0KPj4gK30NCj4+ICsNCj4+ICsvKg0KPj4gKyAq
IEZvciBhIFBBU0lEIGNhY2hlIGludmFsaWRhdGlvbiwgdGhpcyBmdW5jdGlvbiBoYW5kbGVzIGJl
bG93IHNjZW5hcmlvczoNCj4+ICsgKiBhKSBhIHByZXNlbnQgY2FjaGVkIHBhc2lkIGVudHJ5IG5l
ZWRzIHRvIGJlIHJlbW92ZWQNCj4+ICsgKiBiKSBhIHByZXNlbnQgY2FjaGVkIHBhc2lkIGVudHJ5
IG5lZWRzIHRvIGJlIHVwZGF0ZWQNCj4+ICsgKi8NCj4+ICtzdGF0aWMgdm9pZCB2dGRfcGFzaWRf
Y2FjaGVfc3luYyhJbnRlbElPTU1VU3RhdGUgKnMsDQo+VlREUEFTSURDYWNoZUluZm8gKnBjX2lu
Zm8pDQo+PiArew0KPj4gKyAgICBpZiAoIXMtPmZsdHMgfHwgIXMtPnJvb3Rfc2NhbGFibGUgfHwg
IXMtPmRtYXJfZW5hYmxlZCkgew0KPj4gKyAgICAgICAgcmV0dXJuOw0KPj4gKyAgICB9DQo+PiAr
DQo+PiArICAgIHZ0ZF9pb21tdV9sb2NrKHMpOw0KPj4gKyAgICAvKg0KPj4gKyAgICAgKiBhLGIp
OiBsb29wIGFsbCB0aGUgZXhpc3RpbmcgdnRkX2FzIGluc3RhbmNlcyBmb3IgcGFzaWQgY2FjaGUg
cmVtb3ZhbA0KPj4gKyAgICAgICBvciB1cGRhdGUuDQo+PiArICAgICAqLw0KPj4gKyAgICBnX2hh
c2hfdGFibGVfZm9yZWFjaF9yZW1vdmUocy0+dnRkX2FkZHJlc3Nfc3BhY2VzLA0KPnZ0ZF9mbHVz
aF9wYXNpZF9sb2NrZWQsDQo+PiArICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICBwY19p
bmZvKTsNCj4+ICsgICAgdnRkX2lvbW11X3VubG9jayhzKTsNCj4+ICt9DQo+PiArDQo+PiArc3Rh
dGljIGJvb2wgdnRkX3Byb2Nlc3NfcGFzaWRfZGVzYyhJbnRlbElPTU1VU3RhdGUgKnMsDQo+PiAr
ICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICBWVERJbnZEZXNjICppbnZfZGVzYykN
Cj4+ICt7DQo+PiArICAgIHVpbnQxNl90IGRpZDsNCj4+ICsgICAgdWludDMyX3QgcGFzaWQ7DQo+
PiArICAgIFZURFBBU0lEQ2FjaGVJbmZvIHBjX2luZm87DQo+PiArICAgIHVpbnQ2NF90IG1hc2tb
NF0gPSB7VlREX0lOVl9ERVNDX1BBU0lEQ19SU1ZEX1ZBTDAsDQo+VlREX0lOVl9ERVNDX0FMTF9P
TkUsDQo+PiArICAgICAgICAgICAgICAgICAgICAgICAgVlREX0lOVl9ERVNDX0FMTF9PTkUsDQo+
VlREX0lOVl9ERVNDX0FMTF9PTkV9Ow0KPj4gKw0KPj4gKyAgICBpZiAoIXZ0ZF9pbnZfZGVzY19y
ZXNlcnZlZF9jaGVjayhzLCBpbnZfZGVzYywgbWFzaywgdHJ1ZSwNCj4+ICsgICAgICAgICAgICAg
ICAgICAgICAgICAgICAgICAgICAgICAgX19mdW5jX18sICJwYXNpZCBjYWNoZSBpbnYiKSkNCj57
DQo+PiArICAgICAgICByZXR1cm4gZmFsc2U7DQo+PiArICAgIH0NCj4+ICsNCj4+ICsgICAgZGlk
ID0gVlREX0lOVl9ERVNDX1BBU0lEQ19ESUQoaW52X2Rlc2MpOw0KPj4gKyAgICBwYXNpZCA9IFZU
RF9JTlZfREVTQ19QQVNJRENfUEFTSUQoaW52X2Rlc2MpOw0KPj4gKw0KPj4gKyAgICBzd2l0Y2gg
KFZURF9JTlZfREVTQ19QQVNJRENfRyhpbnZfZGVzYykpIHsNCj4+ICsgICAgY2FzZSBWVERfSU5W
X0RFU0NfUEFTSURDX0dfRFNJOg0KPj4gKyAgICAgICAgdHJhY2VfdnRkX3Bhc2lkX2NhY2hlX2Rz
aShkaWQpOw0KPj4gKyAgICAgICAgcGNfaW5mby50eXBlID0gVlREX1BBU0lEX0NBQ0hFX0RPTVNJ
Ow0KPj4gKyAgICAgICAgcGNfaW5mby5kaWQgPSBkaWQ7DQo+PiArICAgICAgICBicmVhazsNCj4+
ICsNCj4+ICsgICAgY2FzZSBWVERfSU5WX0RFU0NfUEFTSURDX0dfUEFTSURfU0k6DQo+PiArICAg
ICAgICAvKiBQQVNJRCBzZWxlY3RpdmUgaW1wbGllcyBhIERJRCBzZWxlY3RpdmUgKi8NCj4+ICsg
ICAgICAgIHRyYWNlX3Z0ZF9wYXNpZF9jYWNoZV9wc2koZGlkLCBwYXNpZCk7DQo+PiArICAgICAg
ICBwY19pbmZvLnR5cGUgPSBWVERfUEFTSURfQ0FDSEVfUEFTSURTSTsNCj4+ICsgICAgICAgIHBj
X2luZm8uZGlkID0gZGlkOw0KPj4gKyAgICAgICAgcGNfaW5mby5wYXNpZCA9IHBhc2lkOw0KPj4g
KyAgICAgICAgYnJlYWs7DQo+PiArDQo+PiArICAgIGNhc2UgVlREX0lOVl9ERVNDX1BBU0lEQ19H
X0dMT0JBTDoNCj4+ICsgICAgICAgIHRyYWNlX3Z0ZF9wYXNpZF9jYWNoZV9nc2koKTsNCj4+ICsg
ICAgICAgIHBjX2luZm8udHlwZSA9IFZURF9QQVNJRF9DQUNIRV9HTE9CQUxfSU5WOw0KPj4gKyAg
ICAgICAgYnJlYWs7DQo+PiArDQo+PiArICAgIGRlZmF1bHQ6DQo+PiArICAgICAgICBlcnJvcl9y
ZXBvcnRfb25jZSgiaW52YWxpZCBncmFudWxhcml0eSBmaWVsZCBpbiBQQVNJRC1jYWNoZQ0KPmlu
dmFsaWRhdGUgIg0KPj4gKyAgICAgICAgICAgICAgICAgICAgICAgICAgImRlc2NyaXB0b3IsIGhp
OiAweCUiUFJJeDY0IiBsbzogMHglIg0KPlBSSXg2NCwNCj4+ICsgICAgICAgICAgICAgICAgICAg
ICAgICAgICBpbnZfZGVzYy0+dmFsWzFdLCBpbnZfZGVzYy0+dmFsWzBdKTsNCj53aGF0J3MgdGhl
IHBvaW50IG9mIHByaW50aW5nIHRoZSAybmQgNjRiPyBMb29raW5nIGF0IEZpZ3VyZSA2LTIgaW4g
dGhlDQo+c3BlYyAoNi41LjIuMi4gUEFTSUQtY2FjaGUgaW52YWxpZGF0ZSBkZXNjcmlwdG9yKSBp
dCBkb2VzIG5vdCBzZWVtIHRvDQo+Y29udGFpbiBhbnl0aGluZz8NCg0KSSB0aGluayBpdCdzIGEg
dHJhZGl0aW9uIGluIGludGVsX2lvbW11LmMgdG8gcHJpbnQgaGkgYW5kIGxvdyBmb3IgMTI4Yml0
IG9yIHZhbFszLTBdIGZvciAyNTZiaXQgaW52X2Rlc2MsIGV2ZW4gdGhvdWdoIGhpIG1heSBiZSBy
ZXNlcnZlZC4NCg0KPg0KPkJlc2lkZXMgSSByZWFkIGluIHRoZSBzcGVjOg0KPkRvbWFpbi1JRCAo
RElEKTogVGhlIERJRCBmaWVsZCBpbmRpY2F0ZXMgdGhlIHRhcmdldCBkb21haW4taWQuIEhhcmR3
YXJlDQo+aWdub3JlcyBiaXRzIDMxOigxNitOKSwgd2hlcmUgTiBpcyB0aGUgZG9tYWluLWlkIHdp
ZHRoIHJlcG9ydGVkIGluIHRoZQ0KPkNhcGFiaWxpdHkgUmVnaXN0ZXIuDQo+DQo+SG93IGRvIHlv
dSBtYWtlIHN1cmUgTiBpcyBzYW1lIG9uIGJvdGggcElPTU1VIGFuZCB2SU9NTVU/DQoNClRoZXJl
IGlzIG5vIHJlbGF0aW9uc2hpcCBiZXR3ZWVuIHBJT01NVSdzIGFuZCB2SU9NTVUncyBESUQuIGhv
c3QgYW5kIGd1ZXN0IGtlcm5lbCBtYW5hZ2UgdGhlaXIgRElEIHNlcGFyYXRlbHkuDQoNClRoYW5r
cw0KWmhlbnpob25nDQo=

