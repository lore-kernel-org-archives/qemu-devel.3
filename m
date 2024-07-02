Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 79506C3065C
	for <qemu-devel@archiver.kernel.org>; Tue,  2 Jul 2024 05:54:33 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sOWRV-0007u9-Oo; Tue, 02 Jul 2024 01:52:41 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <clement.mathieu--drif@eviden.com>)
 id 1sOWRU-0007tr-Ml
 for qemu-devel@nongnu.org; Tue, 02 Jul 2024 01:52:40 -0400
Received: from smarthost3.eviden.com ([80.78.11.84])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <clement.mathieu--drif@eviden.com>)
 id 1sOWRS-0006Tu-Jo
 for qemu-devel@nongnu.org; Tue, 02 Jul 2024 01:52:40 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=eviden.com; i=@eviden.com; q=dns/txt; s=mail;
 t=1719899559; x=1751435559;
 h=from:to:cc:subject:date:message-id:references:
 in-reply-to:content-id:content-transfer-encoding: mime-version;
 bh=wllwYGVimOAK1sNkbxPQGXJMOd3677JZSN8l+Hwiayc=;
 b=GbPeYpZEy9aH+fPO+kvZMvWfrKRDvjQ9rRN+QXNUqmJp/RySmS/tHsWK
 nMaJU4qtXM6yuzHTpQeqmvkw/E/9j5zS8VUJ3fZJzuqCDRfOrL1liOH3R
 +SJurssY1J1TdJTG29AqbHavBSbFgDqNyMIancwQxMDiSc8TbHaCv1WjN
 5MdeK/2x0w862jC1BcBKpnCyZlEWIB36UIB/wR8aqr26YcgSmQK6VCFM+
 TCGA1RXtuebgwNYdPWxteUENsC+J7dBwWJ4H7OZ6SD1fjuyjk7yJqljTR
 ZT+5ZxXM4I7oqNL0IFkQcHSTcWKWdctS1DhDLu4mIwr/tLPd1iEjZPhqv g==;
X-IronPort-AV: E=Sophos;i="6.09,178,1716242400"; d="scan'208";a="15721575"
X-MGA-submission: =?us-ascii?q?MDGH6fPb9mMKieNzRlN5vVTjME4UMR1ZovjHMd?=
 =?us-ascii?q?qc7t0wafBIxqzXVR1IdxYdraHDQnpllBvzzGNSPD8ahExOnBgiZdbC9x?=
 =?us-ascii?q?4fnA73p86DgcIyi6F81auoap/bloYpR6IJvkCkfDkycfiTQBwiacG29B?=
 =?us-ascii?q?J5nns/MRlw80n0+Y5BMxeODg=3D=3D?=
Received: from mail-am6eur05lp2110.outbound.protection.outlook.com (HELO
 EUR05-AM6-obe.outbound.protection.outlook.com) ([104.47.18.110])
 by smarthost3.eviden.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 02 Jul 2024 07:52:33 +0200
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=U5SuRbyDbqmow8rEzMus8qujezFL+qFJRSdOlPfTvmWJkdfK1RtxtzNw2VE0B7qeq8U/7LperbpKVG2b0umBeKVVbG0MIF9BTcaAZhdyowTdtqP/VXatNJmede3tYO7lH32dN+w617oYF/F9Aocf3wcFAYSLzvNNAVfYSGaB3isLai7FIjC3vTVBJgaPSh2ScZlNiurtQQdmv14wZC6kBORohJcROdHB8/U0p1KZlXS3+BPLv7olU5DmsiRD8Z3k65lix3GMRqfmUz2HY3oMp30uNkFyriXHrVbGEVSuYevOByQbi3UwkT9oXNsUPOgxm8VMJP/DIOInNxUAWNqE/w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=wllwYGVimOAK1sNkbxPQGXJMOd3677JZSN8l+Hwiayc=;
 b=ShvA1NzpSAzU90D5GyU800Fajk4/rfUe6d9EpTswqLfrmDyEloiwgUUsdSQCcbzioGH52Lptqed2ZE32HzLcTfBhUWSdgdmfbLyxI1Z6x7Sw2IgHdanT3nHton93RJFczCR9B/prOh4iwGXxdYE/+Vd+Ic9f5WCS8qnu9jLGmndZLO6AJR1GxcOnyavZywrJQC3/pAJNO+ijjngopq5iV/TCEWMeB5JOKyV6pmM5QJa97YTP9Q00eTohGXFgcRjIKAvE0zsyFV+5aFEtCd0Xm05A2Sn3Ro3vf3VNB1McNra17tC/cw5T7HKHc7Z7h2pB2dMlMKvKURBj7d9/vQ+DUQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=eviden.com; dmarc=pass action=none header.from=eviden.com;
 dkim=pass header.d=eviden.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Eviden.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=wllwYGVimOAK1sNkbxPQGXJMOd3677JZSN8l+Hwiayc=;
 b=L4VF0TDFip2xnX9M7X7kH8s8uplYNALEiEz6lWYGyBhAs0ptCEJkYmTaRYef0HT3x7BvuwQoY1w7TrGPwwpEUsG/vCIeipVZsQQsJOjrH6P0nEwMu7KtRD0CnLJ1KNwCgC9oFr9J5XlqIcyoeufh8f/A1huVUSoTBE3x55xOeSiC3uG2u4yRmpeHaZuF6URwu3PNDfifTYfAS1b+lqokR+9eGBEJgnGithQmQnyd9wINURlSFruPEJUU97gisqupGXwlmECzqHHyoc0X9onVSwM59FFWrS/jh2m5+yBfd+i3+TbpJgpTtvhgxb5ngOuG9zL6dAKXoU2QbZFW/ON3Uw==
Received: from AM8PR07MB7602.eurprd07.prod.outlook.com (2603:10a6:20b:24b::7)
 by AS8PR07MB7080.eurprd07.prod.outlook.com (2603:10a6:20b:239::10)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7741.21; Tue, 2 Jul
 2024 05:52:31 +0000
Received: from AM8PR07MB7602.eurprd07.prod.outlook.com
 ([fe80::fbd7:ca71:b636:6f9d]) by AM8PR07MB7602.eurprd07.prod.outlook.com
 ([fe80::fbd7:ca71:b636:6f9d%4]) with mapi id 15.20.7741.017; Tue, 2 Jul 2024
 05:52:31 +0000
From: CLEMENT MATHIEU--DRIF <clement.mathieu--drif@eviden.com>
To: "qemu-devel@nongnu.org" <qemu-devel@nongnu.org>
CC: "jasowang@redhat.com" <jasowang@redhat.com>, "zhenzhong.duan@intel.com"
 <zhenzhong.duan@intel.com>, "kevin.tian@intel.com" <kevin.tian@intel.com>,
 "yi.l.liu@intel.com" <yi.l.liu@intel.com>, "joao.m.martins@oracle.com"
 <joao.m.martins@oracle.com>, "peterx@redhat.com" <peterx@redhat.com>,
 "mst@redhat.com" <mst@redhat.com>, CLEMENT MATHIEU--DRIF
 <clement.mathieu--drif@eviden.com>
Subject: [PATCH ats_vtd v5 01/22] intel_iommu: fix FRCD construction macro.
Thread-Topic: [PATCH ats_vtd v5 01/22] intel_iommu: fix FRCD construction
 macro.
Thread-Index: AQHazEQHGsQhBlP7LEGqilns4McPCA==
Date: Tue, 2 Jul 2024 05:52:31 +0000
Message-ID: <20240702055221.1337035-2-clement.mathieu--drif@eviden.com>
References: <20240702055221.1337035-1-clement.mathieu--drif@eviden.com>
In-Reply-To: <20240702055221.1337035-1-clement.mathieu--drif@eviden.com>
Accept-Language: en-GB, fr-FR, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=eviden.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: AM8PR07MB7602:EE_|AS8PR07MB7080:EE_
x-ms-office365-filtering-correlation-id: 7579553c-357f-405d-dcfd-08dc9a5b29de
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0; ARA:13230040|1800799024|366016|376014|38070700018;
x-microsoft-antispam-message-info: =?utf-8?B?b28yb0RUdWVvRGVqTEt6VVR6Y3BQeCtqVGI1TVkwTXBYVWt4SThDYmlBais2?=
 =?utf-8?B?M0svQzNKSzJnQm9SR1R5cVBDbkFYcW1yY0tFeWlBcnk0NWJYS2owamdUR0Rr?=
 =?utf-8?B?d21jR1VNMklVVFVHclFsNUxwTnZMdEVtUjZTVFFMUzY5M29XMGg5OVBQVUEr?=
 =?utf-8?B?cWIwR1k3aFVjY1BiNktzeitZUXRONjFTS0g5bUhnbDQ3YzI4azRPRmsyMWxL?=
 =?utf-8?B?cGl6cmJUT0gzUTl2bnkrWnlXNHNCV3crMFloTk9DNVNtQjVPUUZoNm4rb3VO?=
 =?utf-8?B?ZkluekVOUlNPa05jTVB1VkhFYmxLVXkxa0ZncW96Z0N2UGZ1ck4yWkFJTnJL?=
 =?utf-8?B?SElkVHNoUTVURHFTUHcycjlCRWVGU2RwZTFCMzBGNFhOT0tNMGQ2aGZ0WEtl?=
 =?utf-8?B?SU03Q3ZiUUhsc3ZrNWdlbFdPVFlzampZc20xeHZSQVpXQVdsc1JiWUZ2bFpY?=
 =?utf-8?B?NHUzRFNXRUFXaWQ1WGpOem5VaGRwYSs4MGlnTDhUMlBjRVFvYWNENjIwblh5?=
 =?utf-8?B?MSsrbHgzSUNYTi9BMi9Hb1lqTnJaUS93eC9NWlBTR2tvMXViK3d1aERJd1l2?=
 =?utf-8?B?Wm5nT2J5VGNvbzJIM1E0V2YrNFcxckYyU2hzcEY3cjh1TkZoMnorOUMzUk8w?=
 =?utf-8?B?aWc5MjYrcytTeGZiNGQwYkZielZtczkyUkh5V2NyZ1VUYTJDYXZyazBTTjUy?=
 =?utf-8?B?ZklNTjZLaGtPSFlZaEN4dGhmK25ucVdrdm5OZGVjaUlZTFlZN09vK3ZGQ2Zp?=
 =?utf-8?B?YW5iNjcvV1l3djRkYlF2K0hiNVMyUHNzalNCbFB6Vktyd05rSVRCakxudG5x?=
 =?utf-8?B?SlFvTDJsWGFGTXM0dWlFWVYyYU0vWHA1cllXYndDWm5mK01XWjJ2aktNSm1I?=
 =?utf-8?B?QnN1bFBLSTR0L2tFdml0ZlpsZDkyNWJWcEdPL3JERUNIQytpTTM0ZlZzd0U0?=
 =?utf-8?B?SkxlT0dPNkdXSU1tYW51dVlsY0QzNW5COStIWHBiN3pKc2orZlI4eWlFT08y?=
 =?utf-8?B?anJVMTl0Q3JEV1NWWWpzTGhEc01ES2FjL0NWN2FHUDJlZENBTkNsYW4ydUZr?=
 =?utf-8?B?RnYrVTV2Z2d4NXI2MHBmb1ZHTHZQK2JsbVhTVVJBaTNsbTl5QTNFZE16SUJF?=
 =?utf-8?B?bnFrbzVZb0NrRnJWR1RyUlRuZ3luY3c5TmhrSW5aVENqYkhseDNyQjZMLzcv?=
 =?utf-8?B?ODI5TE1yRzNmeXVXY0NmL3ppQXpmR0N2V2o1REV2QWUvQW13WGJhRHpQdk5G?=
 =?utf-8?B?NnE4L1VNVWFSYXdSTXR1MFBkdFhmcEcwd1FHdS8vTXp1M2w1YlppUGh0Uk9i?=
 =?utf-8?B?VXBhek9CdzJkVUsrVmJLRjVZYzFIcXQ2NTViSkFTMkFXa2hkQi9BZit4RmhS?=
 =?utf-8?B?cmpRcXZYYTBiYnpqRlJtNUJ5bWtaL0dXM216OERvdGdVS1dXb3ZkMEJaVCtx?=
 =?utf-8?B?UGhsK3VVVmh0OS9zYmltMVVjbDZ5R3FIaE92NGhjdGEwSC9VWlhiaE1kcVFD?=
 =?utf-8?B?RmFuM3dNMjNwZUhMSHlkRG4xZVpQMFptd1ZLcmpQenQ5NmQzQUdwVWxIbU1J?=
 =?utf-8?B?dXFsOFpRelBSWlQwUjZLZis5TVFvVi92WWY5MDZmNmM1V1ZSRWZHV2U1WjRD?=
 =?utf-8?B?T2FLekZKT1A0S1NOZzErL3llSk1OTUVGdFlhWmk2YnZvUjRjZ0xEZXgyZC9S?=
 =?utf-8?B?UHNYUk1CYU8vUHRPMjN0SlFQRDhyejNxWVhBWjVKdGpEYmdkRFQ1b3YzQlVV?=
 =?utf-8?B?cG8vZWxtblVObjZ5Q0tGaGhZZC94dEZWQ25PUFZJYnd6QzZsZWFRSTU1SGll?=
 =?utf-8?B?WTBhSWdwVEtKdFprdlZlVkRhUlAvTEk0WGo5NWtlR1pLd1lpcW83UlhTdFRE?=
 =?utf-8?B?Qk5uTFFHdy83NFNwREkzeXBseGF6UHlsTVhlYTh3MmxUaFE9PQ==?=
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:AM8PR07MB7602.eurprd07.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(1800799024)(366016)(376014)(38070700018); DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?dnk2bE1nQW1BOTJiMUFWZFp3NG00WmlnK1F6bGhicXBaYWRJZWVQa2NhR2Mr?=
 =?utf-8?B?RU5oUWNYNnRpMjFQMENLQzdySmZvYXpkZUcwQXBLZGwraHhqTlg1cDFHM2Vj?=
 =?utf-8?B?eThRa3BscTV0bzRZTWkwVi8yNTFySVc1YzZaZDdPQjJYZEVIK3ZWTGF1ZkFv?=
 =?utf-8?B?RU55c3FPdUlMOEhGTTJkMGVJMEZnZXArdUsraEJlS1NoTGVJSWdaYmRWN3NG?=
 =?utf-8?B?WWFTdEV1VFh3bUp0S0k0ZGhnU0hSL1hHY0JIUC91VUpZTi9KUXA3aFNFdVlj?=
 =?utf-8?B?TXFaM1lCd2RORzBLVGZ4WGc4cjJjMTYyNXFKNDFHMFd6MjZIMmJFZ1N6cmxu?=
 =?utf-8?B?Rk5ETHIyQUJ5QWh1OXRLMHZVMjdjcG02STR0WWp3N2d6S0hpcnBDYzdCK2xz?=
 =?utf-8?B?UG5jWWc3VGZ0Y1ZnYnBVK0hvTmpHUFRKeHY2WWhudDJiaytpbTAxVDZnZU1G?=
 =?utf-8?B?ZXh5Zmo3OTZoU0V4SjZpY3VLdE14dm1PeVFvNTVqaWpVeVRqZU1ySDVnM21B?=
 =?utf-8?B?MzFoQzZuVGZoRnZDeWZoZkQ1cWdxWjk3Z2wydU51ZjJNWmZmMG0rbVlzQk42?=
 =?utf-8?B?L0lmYlY0ZmpPWE9OZy82MjRTb1g5N2ZxbUttYnZHUEUwdlJNS0Z2U3RabHgz?=
 =?utf-8?B?dytzRU9INU10VkR1U0l1SGZFWm5LOG15eVFhTWNDRzZYZ2pmY2F6SlMrb0hI?=
 =?utf-8?B?U3J0Q2JJMDB6cGJadld1ZXNabkNRUXFuNkUyUUpWaXdxNkxjMG9WYWNEMTFm?=
 =?utf-8?B?SFdDQWZ3M3VrbWNQZ3dlUjBCY2JtVWZRdWkzTlUxa3FSM05JaXU5QlRQNEl0?=
 =?utf-8?B?SEdFU2ZOMFNGQ2NxRXFkVHJDS2RyNlczVHFkZGo4N1Y3ZnE4UlV2M2lIV2ZE?=
 =?utf-8?B?M2tCbHVsSkdZczJYUndscE52Q3lmMy9vWWZrY2tYTS90WW9pY3J6YW53ZWtY?=
 =?utf-8?B?aEZSRWU0MWdiQ0RzNVFIZEM5a1hlZXdlTmNzZGtMcGQ2N0RONlVjcDVObjZW?=
 =?utf-8?B?VWgyRVdqY21IMStLVjBnVjRDSlluc2REZko1RHd5OUpPd3FSMHdTRUk1azNn?=
 =?utf-8?B?WUlLazlBS1VVY0QrUGNrZXdKQThuZXV6WFpnN3R2RkZpdk53NUZ2ZGpZQ0Vo?=
 =?utf-8?B?WGp3TG5NYncwa24xN3JmTnBFU3lQWTMyY0xwSmg5c0VNQ2wzcXd1d3FTVlJl?=
 =?utf-8?B?b21TSFJiYzJKOVMydzF3QXlKNzIrQm9UN1hEcnFFL29VNlo4Z3l6QzZubEpj?=
 =?utf-8?B?TGVGeE1wZzF5VkhlNUErbThxUExQVURUQnVhQkVYS1kvR0p3U0JXUkVFYlFX?=
 =?utf-8?B?YVZSL0ROUm5TY0llZXJiSFpEelFxakZSNEVBT1cvdElhdVJ5amdncHdBeFZu?=
 =?utf-8?B?ODFZZDVaYit4dkhzN3VLOHpyYVZFaWNRSjg5dTBrSUJIanJ5dDAvLzA2ak9i?=
 =?utf-8?B?ZnpNQXV4Qy8zYzBNUHZPNGQyakNOVy9ZZlJiRkdjSmdpc3lPQlZjSThmUHhk?=
 =?utf-8?B?TmphZW9Kb3I5OUlWMkZXNHNIdTQwQXF4OFBrTVFXNHBWcUJBQWVBWHJZMFRN?=
 =?utf-8?B?ekdUaU84ZDNqK3NjVU9UcjF0Q2tMOGdXajJvOEdNV1FpU2JPWDdvZXNFN3Fa?=
 =?utf-8?B?Z21vTFluUmlUMkYvWEpvc1k3cHB5amI2bFgxQmxDdVh0eHMvTFVhNUdJakZp?=
 =?utf-8?B?aHN3b2lBL3pDNndGOHZRZnJtN1c5Nzk5OUp2dUpXaGs4aDZnOGJGQjl4RWxi?=
 =?utf-8?B?TTZycHhtK29lSGhLSXUzNTFPRWtDRkNlRjRMdFFYaGppQUc4SCtHYXRlTjJw?=
 =?utf-8?B?bnZ5OGR1ZlF1cXltckJWY0Y2U1dLLzBYM3oxbjNOV2VuWnp2Nm95Y05oang1?=
 =?utf-8?B?RS9kWWl5WXlEUjdnT2VzdkZiUUd4NHlJWnRSYVBQWDNwdEdkSURISExhS1Iy?=
 =?utf-8?B?dmhZZTVzSzRXQkdTRll0Y1RtenFaN3lnb3NQeWFYdTh4dWRmTmpSTzRjR0Zp?=
 =?utf-8?B?dHlKcXJSYUZjN2VMN1pGOEcyVG1BNW5RM0Z2U3laQVFDeXdGL0ZmM0xLa0Ry?=
 =?utf-8?B?MmdNRmgzUklzdkY2T2VVVDc0ZThJSFEySC9kTzR1VWJGaWI0cTlncXA5clE2?=
 =?utf-8?B?enBTTkh4VEhHTEV3ZG9vRlFrN1BoWXd0YzZpd1E2VHVQL3BrZ1dxekpYTzVr?=
 =?utf-8?Q?7KGBAG/oXMsjoaEYevoyfKw=3D?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <C42543566FE070468466543F84FBAA62@eurprd07.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: eviden.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: AM8PR07MB7602.eurprd07.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 7579553c-357f-405d-dcfd-08dc9a5b29de
X-MS-Exchange-CrossTenant-originalarrivaltime: 02 Jul 2024 05:52:31.4848 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 7d1c7785-2d8a-437d-b842-1ed5d8fbe00a
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: MNl8AnIAx7Gj/UX5yrdQ9Jl+wcPIfDBpwftBlHzVOY7F/K8Bs1Gd22uNTBVXxI9gonpw5AzCJIJaaFP7rkkY16AdtuGMGErkMgZBBY60CiOnYUEga7cGcPjpLefoo289
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AS8PR07MB7080
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

RnJvbTogQ2zDqW1lbnQgTWF0aGlldS0tRHJpZiA8Y2xlbWVudC5tYXRoaWV1LS1kcmlmQGV2aWRl
bi5jb20+DQoNClRoZSBjb25zdGFudCBtdXN0IGJlIHVuc2lnbmVkLCBvdGhlcndpc2UgdGhlIHR3
bydzIGNvbXBsZW1lbnQNCm92ZXJyaWRlcyB0aGUgb3RoZXIgZmllbGRzIHdoZW4gYSBQQVNJRCBp
cyBwcmVzZW50DQoNClNpZ25lZC1vZmYtYnk6IENsw6ltZW50IE1hdGhpZXUtLURyaWYgPGNsZW1l
bnQubWF0aGlldS0tZHJpZkBldmlkZW4uY29tPg0KLS0tDQogaHcvaTM4Ni9pbnRlbF9pb21tdV9p
bnRlcm5hbC5oIHwgMiArLQ0KIDEgZmlsZSBjaGFuZ2VkLCAxIGluc2VydGlvbigrKSwgMSBkZWxl
dGlvbigtKQ0KDQpkaWZmIC0tZ2l0IGEvaHcvaTM4Ni9pbnRlbF9pb21tdV9pbnRlcm5hbC5oIGIv
aHcvaTM4Ni9pbnRlbF9pb21tdV9pbnRlcm5hbC5oDQppbmRleCBlODM5NjU3NWViLi5iMTlmMTRl
ZjYzIDEwMDY0NA0KLS0tIGEvaHcvaTM4Ni9pbnRlbF9pb21tdV9pbnRlcm5hbC5oDQorKysgYi9o
dy9pMzg2L2ludGVsX2lvbW11X2ludGVybmFsLmgNCkBAIC0yNzIsNyArMjcyLDcgQEANCiAvKiBG
b3IgdGhlIGxvdyA2NC1iaXQgb2YgMTI4LWJpdCAqLw0KICNkZWZpbmUgVlREX0ZSQ0RfRkkodmFs
KSAgICAgICAgKCh2YWwpICYgfjB4ZmZmVUxMKQ0KICNkZWZpbmUgVlREX0ZSQ0RfUFYodmFsKSAg
ICAgICAgKCgodmFsKSAmIDB4ZmZmZlVMTCkgPDwgNDApDQotI2RlZmluZSBWVERfRlJDRF9QUCh2
YWwpICAgICAgICAoKCh2YWwpICYgMHgxKSA8PCAzMSkNCisjZGVmaW5lIFZURF9GUkNEX1BQKHZh
bCkgICAgICAgICgoKHZhbCkgJiAweDFVTEwpIDw8IDMxKQ0KICNkZWZpbmUgVlREX0ZSQ0RfSVJf
SURYKHZhbCkgICAgKCgodmFsKSAmIDB4ZmZmZlVMTCkgPDwgNDgpDQogDQogLyogRE1BIFJlbWFw
cGluZyBGYXVsdCBDb25kaXRpb25zICovDQotLSANCjIuNDUuMg==

