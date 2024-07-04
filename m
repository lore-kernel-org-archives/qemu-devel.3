Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C9584C30653
	for <qemu-devel@archiver.kernel.org>; Thu,  4 Jul 2024 04:26:14 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sPE2W-0004CU-Ja; Thu, 04 Jul 2024 00:25:48 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <clement.mathieu--drif@eviden.com>)
 id 1sPE2U-0004Bm-VK
 for qemu-devel@nongnu.org; Thu, 04 Jul 2024 00:25:46 -0400
Received: from smarthost3.eviden.com ([80.78.11.84])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <clement.mathieu--drif@eviden.com>)
 id 1sPE2E-0004rL-KL
 for qemu-devel@nongnu.org; Thu, 04 Jul 2024 00:25:46 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=eviden.com; i=@eviden.com; q=dns/txt; s=mail;
 t=1720067130; x=1751603130;
 h=from:to:cc:subject:date:message-id:references:
 in-reply-to:content-id:content-transfer-encoding: mime-version;
 bh=ahCKY1g2SeLN86MblZmeYPPkKa2DMAlsXkEP3yMNKp8=;
 b=qexbnSf57Q37eqRMEKPXLMhCjw33KYqTZo3We0d4Bx2MRfXgQfyeHKI7
 XG44YnMuhEnC5rWP8bLVW7bZl3Vq3LL5YVjFCjBA2TEhu8T2cqKnmVRhD
 uaJ2DeFNySwwOHnb6u08uCVDH/P19JnzbHCPOduyThRuHoCyw4AqGPuh4
 Zyywn+m/rMRPJNy0AUH6EqarK+lHoNFXa1UZBIhdffHdqsQB6Q6s95dLs
 EYYF+ZWbbIfeOJIdeGLGNZmfgaHxl+uYuq/iPFn35eftf0Wgu3B3P7BMO
 MfYKfG19qQPjvVUY+tlrB60tqfLmJaGK9rEffi9FejZ0XIElmKj6GE/Rx Q==;
X-IronPort-AV: E=Sophos;i="6.09,183,1716242400"; d="scan'208";a="15866171"
X-MGA-submission: =?us-ascii?q?MDE5qMZVYrjEpfIudS58ZH45dqwnFXuURK8mJq?=
 =?us-ascii?q?IN8OUK7kf5WT+tlZPo55YhS5PXZkZeeNSjCPYexG+Jru1J2TgGm/0wIk?=
 =?us-ascii?q?EKObSPnDLZIfjN7rGhctStB7yR65/NgcL6DL8aJtWnRCtv0Yq6H69yN3?=
 =?us-ascii?q?jcTJ2L+xVAPQGRvsoKKkmqJA=3D=3D?=
Received: from mail-am0eur02lp2235.outbound.protection.outlook.com (HELO
 EUR02-AM0-obe.outbound.protection.outlook.com) ([104.47.11.235])
 by smarthost3.eviden.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 04 Jul 2024 06:25:26 +0200
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=KoCbJ5j2pz6UvR2hi2HVPoGS8EZX2T8y6KwA0lxYtQV0m/lOu2ndMMIUYGlaKT/EM1Xi14fksVvkcoXGf6lFnXnJku+PpdC75+eL1oR72843aOQt3ltoHL9NKsSTgPa+Oj/WPxIl73HG4g10F/q5qkjW3BMv+sFQVrxf+cDxL7lQuONpteiqsMqF2mzwFmxvbaEgP/HTkdNHWdKwXFX6LgjUoFgsKe+fdqgUDcSuYAGnwoLtDquyx2TS5auOy2cArHmac2J1LtnpGpdCsYoFAFkQ1VcePJOy5kEwvwvOnnrIXHtK6oT1NJ09FUNPSyYfgBwlw2KOVLXfzCQp+ZSvmg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=ahCKY1g2SeLN86MblZmeYPPkKa2DMAlsXkEP3yMNKp8=;
 b=UuRQPqlel6jFEcghpxJjknY+T/Q5DjETtUJHt8dhDb2Laqk/OYvpXXGmFMlHKWDvt73f6Hn1K4pmc5/lCsc8QGyU3W9Yx+W4+Gzi/0a0yFEI4gGHA95FZFC7Mds+vDYDoROsMyQDxkA2o9q6fnobUtSEwijhbNITPTwt8xG54fLt5SsTWZ9AAYZ4oo1ROxxz8y1ICn7V6xTpYgWCwELikdwgiddP1Nf5raJxrVAc3hX+BUN/b2aLqjVR5/AJW1RXtOtxBhowsFyhXE3A17mH1mCVG+kG4Es7eeV4tLWavLK5qH48/8IMrZ5aa+SDwkXwiVfP1q+964m5EPXbAzmt5Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=eviden.com; dmarc=pass action=none header.from=eviden.com;
 dkim=pass header.d=eviden.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Eviden.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ahCKY1g2SeLN86MblZmeYPPkKa2DMAlsXkEP3yMNKp8=;
 b=fLHS0CwHNlovfAzrsEcgLzQ/H31+JSOcXLx+BZL/rdGVpHJILuv8cRfLkteSixc9Qg58DUPcEPOJL02ODZlEodzRW3lqWpeRGOzHUc9fKpNPDKW+cfjh3m8KWrf4SdTZRK9h/qP/7eQKHYQGjErkMvDCoE3G7sU8ehIxoHdzIUW2yzDh/WpifeibRXOsr89xXeXqHbTRgke3kA7vb4AhmUSAmrRs+AfZ8F26kIuvrGQBp8uEAYBsyBqixeD7bMeX+Um0AkWVjekmEdlIt0NXJcY/uxdgS1uWDd1ofEaZlkWLr9PHhdMgfuw/0SlCIZbUS0IsZvJn3AWLZNmulwM8Ww==
Received: from AM8PR07MB7602.eurprd07.prod.outlook.com (2603:10a6:20b:24b::7)
 by DB9PR07MB8636.eurprd07.prod.outlook.com (2603:10a6:10:30b::6) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7741.25; Thu, 4 Jul
 2024 04:25:25 +0000
Received: from AM8PR07MB7602.eurprd07.prod.outlook.com
 ([fe80::fbd7:ca71:b636:6f9d]) by AM8PR07MB7602.eurprd07.prod.outlook.com
 ([fe80::fbd7:ca71:b636:6f9d%4]) with mapi id 15.20.7741.017; Thu, 4 Jul 2024
 04:25:25 +0000
From: CLEMENT MATHIEU--DRIF <clement.mathieu--drif@eviden.com>
To: Yi Liu <yi.l.liu@intel.com>, "qemu-devel@nongnu.org"
 <qemu-devel@nongnu.org>
CC: "jasowang@redhat.com" <jasowang@redhat.com>, "zhenzhong.duan@intel.com"
 <zhenzhong.duan@intel.com>, "kevin.tian@intel.com" <kevin.tian@intel.com>,
 "joao.m.martins@oracle.com" <joao.m.martins@oracle.com>, "peterx@redhat.com"
 <peterx@redhat.com>, "mst@redhat.com" <mst@redhat.com>
Subject: Re: [PATCH ats_vtd v5 06/22] pcie: add helper to declare PASID
 capability for a pcie device
Thread-Topic: [PATCH ats_vtd v5 06/22] pcie: add helper to declare PASID
 capability for a pcie device
Thread-Index: AQHazEQJfH+RmlRl2EizMPPk04nn5LHk6eKAgAER94A=
Date: Thu, 4 Jul 2024 04:25:25 +0000
Message-ID: <44af05a1-76dd-4be4-b0ea-fd6c03bc0f12@eviden.com>
References: <20240702055221.1337035-1-clement.mathieu--drif@eviden.com>
 <20240702055221.1337035-7-clement.mathieu--drif@eviden.com>
 <d2bed39c-9c5c-4336-bc42-2bf422aab7cc@intel.com>
In-Reply-To: <d2bed39c-9c5c-4336-bc42-2bf422aab7cc@intel.com>
Accept-Language: en-GB, fr-FR, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=eviden.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: AM8PR07MB7602:EE_|DB9PR07MB8636:EE_
x-ms-office365-filtering-correlation-id: 7bf08d23-53f1-48af-d9c7-08dc9be153e5
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0; ARA:13230040|376014|1800799024|366016|38070700018;
x-microsoft-antispam-message-info: =?utf-8?B?NTlZTGFuOEFCT3N6TUs4LzF1SDN1SVBDbUkreE1CQlpYNzdhQmNkZWtpQnBK?=
 =?utf-8?B?bzYzNitjbCt3MzhtR3pJbHRHK3B1bzdHU29wNHRXY1hqRWk2bTBRdkpRWDNy?=
 =?utf-8?B?UWRaVU9pdEZtc2lEbXJsSCtlbjVMNnJOOFVhSlh0RWFRTjBhS1FQc2pBR0g4?=
 =?utf-8?B?c3hzOWh5TmtUVWdBNUZFUFBsVDJSYStEblNBd0ZTQitXUG1wWVR4V293S09r?=
 =?utf-8?B?RkhPMEhJZnZjbTAxUURTVG5MVFZmNThvemdtVjNTSm5DZWJJQUJxait3VU1o?=
 =?utf-8?B?VlRXOGRwYjJKZjB0cHRkaWttZENTZzZMZzRGQ2lUc2FtR1kwQVRmSnFFcGdu?=
 =?utf-8?B?azE3WGlDck50WERZOWNTT2RCREQzSnZpU2w0b0pjUmRYNFdPN0dMNWZqazZs?=
 =?utf-8?B?KzFEUWRkRW02eUxqbjZadVR5ZHJBckRpWFJWQU5BOWJ4SFVkZHNpMkRwS1d6?=
 =?utf-8?B?cVp2S2MybHVlSTZqSFZ6elJtMks1YXp0TzN5NlhBUDV3R0d6Q2JwYVg5SmZi?=
 =?utf-8?B?S1grUlZyZ2J0ZXRyWjBuNE1udU1qOFJsZS9LNW1EUXNrVElyYTFhcm84RnVk?=
 =?utf-8?B?SXcybWcwRVZjOGMxTXo5RWZGMW1xcDlGeW5zeEpyQlhDdG9HdFhBSUtOeGhp?=
 =?utf-8?B?Rk1BdEE4NVpLSko2a25QZUErWWY1OUdFNEFKaUVEVEIwemNxM21KWUNRN29l?=
 =?utf-8?B?SHY2am1Db2ExZkc5Y2xTNW1hQjNSZ3hMRFVaelRPZDRrTkFVV2xVZllFL1Nz?=
 =?utf-8?B?TDVmMzdIUTVOQkhqNTBLL0Q2cmpORXptU3BwY1ZBelJ2aGFRa2pTK09pWUNk?=
 =?utf-8?B?bE9jVEdiMS8xMjBUdlhsMHd4SHNIdjlEcVhsdFlpc2pqUkhyL2VIWW5iWE0w?=
 =?utf-8?B?K21KY3dmOTN2QlRMQ0VONkw0ZWRacWo2Mmt5Z1RQczEyRDB2VW5mNFAxUHhk?=
 =?utf-8?B?azVnL0NRam5CMFhlUHVTU0lNaVhlSnFpMjBUWkxpcnFhNGY1NU9zYmtQMWs1?=
 =?utf-8?B?Y2xodGNQOW1QTlhMaXJVQXQ4T1R6YmM3VE93SldmSExab3Bvd3hzT0Z5eUpr?=
 =?utf-8?B?NTk2ZGNYZE1VMUFTRVlXYS9xc1VIU0lFQ0hQMWg5eHJTakFEZjFtRVJwbHNS?=
 =?utf-8?B?clV4bGpZa3hiQTFwb2ZVUWdKQ3RUQldCclQ3YUxTZlZ0WUxnTU9QNG1PTnhk?=
 =?utf-8?B?dkNJTlIxNXlxQWpRaUxJMjEyMnFvdjBtQUlMb0JCQkFkbDB0VU9tRlcvSXU4?=
 =?utf-8?B?RXRneWdLZUhyZFVleU9PRWxFM3FpOUhCTHNkUU5jQWdUNkZ4Sm5QeWF0TDFu?=
 =?utf-8?B?UTd6UWxMeDd1TFhpS0tlSzZrdy9QOHo2aGNqYnZxU3AvMDRLdWFIV2xaa0hq?=
 =?utf-8?B?T25GdGhjbG8rME9rcnVXYUYxaUtibDNiaEhCTTdJRFlTTDV4NlhWTEVUZDNo?=
 =?utf-8?B?L1VnK1pIazF1TzZUNmhaVkljQkVEZjFweDNUc2J3WElmSTdDUmRDVmMwenRQ?=
 =?utf-8?B?NHNXdTErWTgyejVCSE82bUN5NTdOblZLOS9CZ2M3djB3R01qekNuZU1ZaFo1?=
 =?utf-8?B?UndLU2hRUDBXTzB1R2hmYmorRHREelpSQ2FxRG5tdlFER1NQamw3c1BrMW5P?=
 =?utf-8?B?KzJvZmU4RWJPRWhjVjZmREZ2WEw2elUvMjlDTnRoaCtFcStqaE85ZGtvYjdr?=
 =?utf-8?B?cytJM3UydDNBUnlxRHMrT0p5NDRzQTVCNWdSNmd3Wm53dVdONWNxOWFiNlV2?=
 =?utf-8?B?K045RVVDWVMxZ3hLNm1TdjFyWXRLdFJQeGlIOVVDTSsyZ3RFQSs5OUNLYjF0?=
 =?utf-8?B?aU50dDFNZDUwK0ZhbnFwQitzcFpQbGJ2cVBOOUU0QlVKdHkvUWdBc1N4WUE4?=
 =?utf-8?B?WlA2d1ZXdlJQOUxaQTBuSUJqU3B1MVNVNGgyMVF3cW5lckE9PQ==?=
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:AM8PR07MB7602.eurprd07.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(376014)(1800799024)(366016)(38070700018); DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?M2hnZEprMVl6NTVPVHk2b3ZEemdkOUFjRmdKOXV4Y3VmMWJuWjdTSjArZkpn?=
 =?utf-8?B?VTBJdjl5dTVXaStKYUQ1NzFtUHlObGgrUERrTXh1UlljdWxDRnZ3alo5Qzcw?=
 =?utf-8?B?aklhbTZMNzRKTDRLTVhnMVgyRmw5b0pmMk1JYWFlZng2OUxpd1ZrbWxqVGFr?=
 =?utf-8?B?TVFTOW5MU0pHdDBaa3VUcSt6eDY3blp1Q1pvcHhOU3NNc3YvMitoa2cvVktB?=
 =?utf-8?B?dzdnQURTVXM3dFY0d1RFbFdTNjdFK1hsVFMxcmJWSHZrQkhZSkNpaU1abEpO?=
 =?utf-8?B?dTJmTkZUUEhXa3FSRDZTL0pFTVBxV2RUOUVZbGpKTHVsL1pzaVVZeVhwUUZG?=
 =?utf-8?B?UjdyL2xHbi9wMDN6M0hneE1SRDVFNkpvTGlXcVF6WUlZVHc2MjRITHRzRmVl?=
 =?utf-8?B?T1hieVFsTjk3TzdMRFM3TGtBa0p5djJnU2pSTkhSdmF5Y0FxdHZVS0hsMmND?=
 =?utf-8?B?STBTZ1puaklQRXZRM0NUZTIzdUVRU0VFSzhZL2RaYjAyaUp0Z0RWSVZVRVc3?=
 =?utf-8?B?MkZmMzIzTGVGM3dZRmt0c3gvMzdOcmJwKzlLdEN2ZjNtQm1tajlPejhzUkJ1?=
 =?utf-8?B?NjNJeFBHaEI2RFdzejJWQ2hxZkNiMkx5MDdvTy8vMjUvaWFJUTZIaFd5YitY?=
 =?utf-8?B?WGtFS01ibFc1QVBHYjBMb1RxQ0Y4NEszdldHMkxVc1lEZVFJcEl2ODhCYSs0?=
 =?utf-8?B?SnBHUkVhU3dXZEhJL1dEN01OQ0tNV0JtS0g3TFppMUk3Y3VqQjNXVHNFTEJM?=
 =?utf-8?B?YmU3ZVpPNFh6bjAzRXcwUVNHVTRrcW5BZ2w3TnRqbUtIYTdtNGRreE10QnJn?=
 =?utf-8?B?RW9XYW5yQm9RdVVYMHFwUTg1WDFoU3FnMjN5a0ErL2hzaXNhenhhZVlJK3g3?=
 =?utf-8?B?dmpyZE9iMTZDcUV6R0p0YWZaZVRGZ3hFZk5sZDVUQ2JCS2pGc1VHQTBaQlpV?=
 =?utf-8?B?S21HY0RnQmtseE1OSjR2ZnM3NkRtWW5GeFdHSWdhUFlMdEcrV01mWVNNM0RJ?=
 =?utf-8?B?Mnhab1FJeEM0Wm15N2tUOHRRaU0weVRnRWpRS0xuY0VlUGYva1A4NGU4bVVD?=
 =?utf-8?B?cTR0cUQveGZrM3pFYU9pRUQ5dDY4YktJbjNzV056VXMyVkpNRjMzdGk1MGNn?=
 =?utf-8?B?QVhMeHV2dWt6d1ZBcW9seU8xSzYyM282UytUcnZmWG5zZjRySnI3OGdDQ1lo?=
 =?utf-8?B?ZGhlcm9aUndWRDcwc3oxRXNQL1dOQk1wcXVmdXhlY2VLdW1VbWE4NzY0NXg1?=
 =?utf-8?B?d1BuZFF0VXlTL1pPemNCTkJWQ1hyU0NpR29KdU81SExsdU5kWWtNd1VzaGtX?=
 =?utf-8?B?VGlkcHUrR2xUSmhLSFBFNkpWbmRpM01aSXp6dzNzNE1SZENBQlJwUmtTK0FT?=
 =?utf-8?B?T0ZWMEFrZkZsbVFrWlZmMEJFN01wMmlpQVZQTnJOUkliOTNiUFRLYjNyc3pS?=
 =?utf-8?B?cmw5NXpXMFBLWFUyNUxvL0VjQnFtbVlPNmMzTVRUN0pqR25jMHVOWXdQTVdz?=
 =?utf-8?B?WjI2cDI1UHVTOW81Z055ajd0QjRSYWM1azRUa09jN0dEMEJUamo5aFlJTitN?=
 =?utf-8?B?b1d4NW5IMkZzTnQvSHV6WlRNM0twSkhqdnNnYXZZWEh2ZjJIUnJINjZnbURY?=
 =?utf-8?B?ZlhwR1FjWkdlMlc0NFFOSjh0a0xFbGNtTTkyQWhaUEM1V2tPK2VpNlBLVGEy?=
 =?utf-8?B?V25ONmRMWXB1L3FXeTBadWEyd2lFczVwOGJKRklrUFBIaDJiSy9qZlJ6dEFQ?=
 =?utf-8?B?OC81L3VDc0hRaUREOEhGMEtIMEZRRUJDeWlKS0pXY0ZvNjZuMXV0ditpTWEr?=
 =?utf-8?B?SFE2L055bW9uTEJCMGZoNWdxL1YyQ21ZUUlxMTBHWlhLOWhqRHVPS3I0cWVV?=
 =?utf-8?B?ZEZjSEU4di9lYmU4Tm5jN1hZRmR4YnltZnJGSUlnNUp3TzlrOWpmMW1EWHBj?=
 =?utf-8?B?MUk4M3IrenArU09GbXBocWpTZHlRbTVjK0VLUFJPU2FiQjFTWnQyZ2JuODV5?=
 =?utf-8?B?YnpDMXByRmdBaXAydlZFQmQ3L2ZXZmc1b2NJQmxmS3ZsZzlQdW1uOFFNcFV5?=
 =?utf-8?B?ZkZPclFDYTYrd3hFZHljZ29iWWJTbk1GVVRjUnc4NW9Xd3BMTFVITGYxbWt4?=
 =?utf-8?B?RFpVRWpYWFByYkhtcXV0bUw2Tk5wU0NHU0dFZHc4V3hSVTBudSt2dkREanFZ?=
 =?utf-8?Q?t6MHYDolRdIPw1alMIzIULg=3D?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <58C124787395ED4895170B14089280E9@eurprd07.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: eviden.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: AM8PR07MB7602.eurprd07.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 7bf08d23-53f1-48af-d9c7-08dc9be153e5
X-MS-Exchange-CrossTenant-originalarrivaltime: 04 Jul 2024 04:25:25.6916 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 7d1c7785-2d8a-437d-b842-1ed5d8fbe00a
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 2ImZVOGwwEWZZdkGc0HzvrMh6nK/RdOnsVR/2hjdo56DTBZ0W6NSUpCSqT87bFb6NPZ0oCAy79fNqIjRiL/KhQL7EBxcUEkT0AiF3EYpEtWXGlmdFvj67daiy8/xpkOg
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DB9PR07MB8636
Received-SPF: pass client-ip=80.78.11.84;
 envelope-from=clement.mathieu--drif@eviden.com; helo=smarthost3.eviden.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, SPF_HELO_PASS=-0.001,
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

DQpPbiAwMy8wNy8yMDI0IDE0OjA0LCBZaSBMaXUgd3JvdGU6DQo+IENhdXRpb246IEV4dGVybmFs
IGVtYWlsLiBEbyBub3Qgb3BlbiBhdHRhY2htZW50cyBvciBjbGljayBsaW5rcywgDQo+IHVubGVz
cyB0aGlzIGVtYWlsIGNvbWVzIGZyb20gYSBrbm93biBzZW5kZXIgYW5kIHlvdSBrbm93IHRoZSBj
b250ZW50IA0KPiBpcyBzYWZlLg0KPg0KPg0KPiBPbiAyMDI0LzcvMiAxMzo1MiwgQ0xFTUVOVCBN
QVRISUVVLS1EUklGIHdyb3RlOg0KPj4gRnJvbTogQ2zDqW1lbnQgTWF0aGlldS0tRHJpZiA8Y2xl
bWVudC5tYXRoaWV1LS1kcmlmQGV2aWRlbi5jb20+DQo+Pg0KPj4gU2lnbmVkLW9mZi1ieTogQ2zD
qW1lbnQgTWF0aGlldS0tRHJpZiA8Y2xlbWVudC5tYXRoaWV1LS1kcmlmQGV2aWRlbi5jb20+DQo+
PiAtLS0NCj4+IMKgIGh3L3BjaS9wY2llLmPCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDC
oMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoCB8IDI0ICsrKysrKysrKysrKysrKysrKysrKysrDQo+
PiDCoCBpbmNsdWRlL2h3L3BjaS9wY2llLmjCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDC
oMKgwqDCoMKgIHzCoCA2ICsrKysrLQ0KPj4gwqAgaW5jbHVkZS9ody9wY2kvcGNpZV9yZWdzLmjC
oMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqAgfMKgIDMgKysrDQo+PiDCoCBpbmNsdWRlL3N0
YW5kYXJkLWhlYWRlcnMvbGludXgvcGNpX3JlZ3MuaCB8wqAgMSArDQo+PiDCoCA0IGZpbGVzIGNo
YW5nZWQsIDMzIGluc2VydGlvbnMoKyksIDEgZGVsZXRpb24oLSkNCj4+DQo+PiBkaWZmIC0tZ2l0
IGEvaHcvcGNpL3BjaWUuYyBiL2h3L3BjaS9wY2llLmMNCj4+IGluZGV4IDRiMmYwODA1YzYuLmQ2
YTA1MmI2MTYgMTAwNjQ0DQo+PiAtLS0gYS9ody9wY2kvcGNpZS5jDQo+PiArKysgYi9ody9wY2kv
cGNpZS5jDQo+PiBAQCAtMTE3NywzICsxMTc3LDI3IEBAIHZvaWQgcGNpZV9hY3NfcmVzZXQoUENJ
RGV2aWNlICpkZXYpDQo+PiDCoMKgwqDCoMKgwqDCoMKgwqAgcGNpX3NldF93b3JkKGRldi0+Y29u
ZmlnICsgZGV2LT5leHAuYWNzX2NhcCArIFBDSV9BQ1NfQ1RSTCwgDQo+PiAwKTsNCj4+IMKgwqDC
oMKgwqAgfQ0KPj4gwqAgfQ0KPj4gKw0KPj4gKy8qIFBBU0lEICovDQo+PiArdm9pZCBwY2llX3Bh
c2lkX2luaXQoUENJRGV2aWNlICpkZXYsIHVpbnQxNl90IG9mZnNldCwgdWludDhfdCANCj4+IHBh
c2lkX3dpZHRoLA0KPj4gK8KgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqAg
Ym9vbCBleGVjX3Blcm0sIGJvb2wgcHJpdl9tb2QpDQo+PiArew0KPj4gK8KgwqDCoCBhc3NlcnQo
cGFzaWRfd2lkdGggPD0gUENJX0VYVF9DQVBfUEFTSURfTUFYX1dJRFRIKTsNCj4+ICvCoMKgwqAg
c3RhdGljIGNvbnN0IHVpbnQxNl90IGNvbnRyb2xfcmVnX3J3X21hc2sgPSAweDA3Ow0KPj4gK8Kg
wqDCoCB1aW50MTZfdCBjYXBhYmlsaXR5X3JlZyA9IHBhc2lkX3dpZHRoOw0KPj4gKw0KPj4gK8Kg
wqDCoCBwY2llX2FkZF9jYXBhYmlsaXR5KGRldiwgUENJX0VYVF9DQVBfSURfUEFTSUQsIFBDSV9Q
QVNJRF9WRVIsIA0KPj4gb2Zmc2V0LA0KPj4gK8KgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDC
oMKgwqDCoMKgwqDCoMKgwqAgUENJX0VYVF9DQVBfUEFTSURfU0laRU9GKTsNCj4+ICsNCj4+ICvC
oMKgwqAgY2FwYWJpbGl0eV9yZWcgPDw9IFBDSV9QQVNJRF9DQVBfV0lEVEhfU0hJRlQ7DQo+PiAr
wqDCoMKgIGNhcGFiaWxpdHlfcmVnIHw9IGV4ZWNfcGVybSA/IFBDSV9QQVNJRF9DQVBfRVhFQyA6
IDA7DQo+PiArwqDCoMKgIGNhcGFiaWxpdHlfcmVnIHw9IHByaXZfbW9kwqAgPyBQQ0lfUEFTSURf
Q0FQX1BSSVYgOiAwOw0KPj4gK8KgwqDCoCBwY2lfc2V0X3dvcmQoZGV2LT5jb25maWcgKyBvZmZz
ZXQgKyBQQ0lfUEFTSURfQ0FQLCBjYXBhYmlsaXR5X3JlZyk7DQo+PiArDQo+PiArwqDCoMKgIC8q
IEV2ZXJ5dGhpbmcgaXMgZGlzYWJsZWQgYnkgZGVmYXVsdCAqLw0KPj4gK8KgwqDCoCBwY2lfc2V0
X3dvcmQoZGV2LT5jb25maWcgKyBvZmZzZXQgKyBQQ0lfUEFTSURfQ1RSTCwgMCk7DQo+PiArDQo+
PiArwqDCoMKgIHBjaV9zZXRfd29yZChkZXYtPndtYXNrICsgb2Zmc2V0ICsgUENJX1BBU0lEX0NU
UkwsIA0KPj4gY29udHJvbF9yZWdfcndfbWFzayk7DQo+PiArDQo+PiArwqDCoMKgIGRldi0+ZXhw
LnBhc2lkX2NhcCA9IG9mZnNldDsNCj4+ICt9DQo+DQo+IHNlZW1zIG5vIHVzZXIgb2YgdGhpcyBo
ZWxwZXIgaW4gdGhpcyBzZXJpZXMuIElmIHllcywgeW91IG1heSBkcm9wIHRoaXMNCj4gcGF0Y2gg
YW5kIGluY2x1ZGUgaXQgd2hlbiB0aGVyZSBpcyBhIGNhbGxlciBvZiBpdC4NCllvdSBhcmUgcmln
aHQsIEkgd2lsbCBtb3ZlIGl0IHRvIHRoZSBzZXJpZXMgdGhhdCBpbXBsZW1lbnRzIHRoZSBTVk0g
ZGVtbyANCmRldmljZQ0KPg0KPj4gZGlmZiAtLWdpdCBhL2luY2x1ZGUvaHcvcGNpL3BjaWUuaCBi
L2luY2x1ZGUvaHcvcGNpL3BjaWUuaA0KPj4gaW5kZXggNWVkZGI5MDk3Ni4uYjg3MDk1OGM5OSAx
MDA2NDQNCj4+IC0tLSBhL2luY2x1ZGUvaHcvcGNpL3BjaWUuaA0KPj4gKysrIGIvaW5jbHVkZS9o
dy9wY2kvcGNpZS5oDQo+PiBAQCAtNzIsOCArNzIsOSBAQCBzdHJ1Y3QgUENJRXhwcmVzc0Rldmlj
ZSB7DQo+PiDCoMKgwqDCoMKgIHVpbnQxNl90IGFlcl9jYXA7DQo+PiDCoMKgwqDCoMKgIFBDSUVB
RVJMb2cgYWVyX2xvZzsNCj4+DQo+PiAtwqDCoMKgIC8qIE9mZnNldCBvZiBBVFMgY2FwYWJpbGl0
eSBpbiBjb25maWcgc3BhY2UgKi8NCj4+ICvCoMKgwqAgLyogT2Zmc2V0IG9mIEFUUyBhbmQgUEFT
SUQgY2FwYWJpbGl0aWVzIGluIGNvbmZpZyBzcGFjZSAqLw0KPj4gwqDCoMKgwqDCoCB1aW50MTZf
dCBhdHNfY2FwOw0KPj4gK8KgwqDCoCB1aW50MTZfdCBwYXNpZF9jYXA7DQo+Pg0KPj4gwqDCoMKg
wqDCoCAvKiBBQ1MgKi8NCj4+IMKgwqDCoMKgwqAgdWludDE2X3QgYWNzX2NhcDsNCj4+IEBAIC0x
NTAsNCArMTUxLDcgQEAgdm9pZCBwY2llX2NhcF9zbG90X3VucGx1Z19jYihIb3RwbHVnSGFuZGxl
ciANCj4+ICpob3RwbHVnX2RldiwgRGV2aWNlU3RhdGUgKmRldiwNCj4+IMKgwqDCoMKgwqDCoMKg
wqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoCBFcnJvciAqKmVy
cnApOw0KPj4gwqAgdm9pZCBwY2llX2NhcF9zbG90X3VucGx1Z19yZXF1ZXN0X2NiKEhvdHBsdWdI
YW5kbGVyICpob3RwbHVnX2RldiwNCj4+IMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKg
wqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqAgRGV2aWNlU3RhdGUg
KmRldiwgRXJyb3IgKiplcnJwKTsNCj4+ICsNCj4+ICt2b2lkIHBjaWVfcGFzaWRfaW5pdChQQ0lE
ZXZpY2UgKmRldiwgdWludDE2X3Qgb2Zmc2V0LCB1aW50OF90IA0KPj4gcGFzaWRfd2lkdGgsDQo+
PiArwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoCBib29sIGV4ZWNfcGVy
bSwgYm9vbCBwcml2X21vZCk7DQo+PiDCoCAjZW5kaWYgLyogUUVNVV9QQ0lFX0ggKi8NCj4+IGRp
ZmYgLS1naXQgYS9pbmNsdWRlL2h3L3BjaS9wY2llX3JlZ3MuaCBiL2luY2x1ZGUvaHcvcGNpL3Bj
aWVfcmVncy5oDQo+PiBpbmRleCA5ZDNiNjg2OGRjLi4wYTg2NTk4ZjgwIDEwMDY0NA0KPj4gLS0t
IGEvaW5jbHVkZS9ody9wY2kvcGNpZV9yZWdzLmgNCj4+ICsrKyBiL2luY2x1ZGUvaHcvcGNpL3Bj
aWVfcmVncy5oDQo+PiBAQCAtODYsNiArODYsOSBAQCB0eXBlZGVmIGVudW0gUENJRXhwTGlua1dp
ZHRoIHsNCj4+IMKgICNkZWZpbmUgUENJX0FSSV9WRVLCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDC
oMKgwqDCoMKgwqDCoMKgIDENCj4+IMKgICNkZWZpbmUgUENJX0FSSV9TSVpFT0bCoMKgwqDCoMKg
wqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgIDgNCj4+DQo+PiArLyogUEFTSUQgKi8NCj4+ICsjZGVm
aW5lIFBDSV9QQVNJRF9WRVLCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqAgMQ0K
Pj4gKyNkZWZpbmUgUENJX0VYVF9DQVBfUEFTSURfTUFYX1dJRFRIwqDCoMKgwqAgMjANCj4+IMKg
IC8qIEFFUiAqLw0KPj4gwqAgI2RlZmluZSBQQ0lfRVJSX1ZFUsKgwqDCoMKgwqDCoMKgwqDCoMKg
wqDCoMKgwqDCoMKgwqDCoMKgwqAgMg0KPj4gwqAgI2RlZmluZSBQQ0lfRVJSX1NJWkVPRsKgwqDC
oMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqAgMHg0OA0KPj4gZGlmZiAtLWdpdCBhL2luY2x1
ZGUvc3RhbmRhcmQtaGVhZGVycy9saW51eC9wY2lfcmVncy5oIA0KPj4gYi9pbmNsdWRlL3N0YW5k
YXJkLWhlYWRlcnMvbGludXgvcGNpX3JlZ3MuaA0KPj4gaW5kZXggYTM5MTkzMjEzZi4uNDA2ZGNl
OGU4MiAxMDA2NDQNCj4+IC0tLSBhL2luY2x1ZGUvc3RhbmRhcmQtaGVhZGVycy9saW51eC9wY2lf
cmVncy5oDQo+PiArKysgYi9pbmNsdWRlL3N0YW5kYXJkLWhlYWRlcnMvbGludXgvcGNpX3JlZ3Mu
aA0KPj4gQEAgLTkzNSw2ICs5MzUsNyBAQA0KPj4gwqAgI2RlZmluZcKgIFBDSV9QQVNJRF9DQVBf
RVhFQyAweDAwMDLCoCAvKiBFeGVjIHBlcm1pc3Npb25zIFN1cHBvcnRlZCAqLw0KPj4gwqAgI2Rl
ZmluZcKgIFBDSV9QQVNJRF9DQVBfUFJJViAweDAwMDTCoCAvKiBQcml2aWxlZ2UgTW9kZSBTdXBw
b3J0ZWQgKi8NCj4+IMKgICNkZWZpbmXCoCBQQ0lfUEFTSURfQ0FQX1dJRFRIwqDCoMKgwqDCoMKg
wqAgMHgxZjAwDQo+PiArI2RlZmluZcKgIFBDSV9QQVNJRF9DQVBfV0lEVEhfU0hJRlTCoCA4DQo+
PiDCoCAjZGVmaW5lIFBDSV9QQVNJRF9DVFJMwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqAgMHgw
NsKgwqDCoCAvKiBQQVNJRCBjb250cm9sIA0KPj4gcmVnaXN0ZXIgKi8NCj4+IMKgICNkZWZpbmXC
oCBQQ0lfUEFTSURfQ1RSTF9FTkFCTEXCoMKgwqDCoMKgIDB4MDAwMcKgIC8qIEVuYWJsZSBiaXQg
Ki8NCj4+IMKgICNkZWZpbmXCoCBQQ0lfUEFTSURfQ1RSTF9FWEVDwqDCoMKgwqDCoMKgwqAgMHgw
MDAywqAgLyogRXhlYyBwZXJtaXNzaW9ucyANCj4+IEVuYWJsZSAqLw0KPg0KPiAtLSANCj4gUmVn
YXJkcywNCj4gWWkgTGl1

