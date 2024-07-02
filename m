Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8336DC3064D
	for <qemu-devel@archiver.kernel.org>; Tue,  2 Jul 2024 05:53:32 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sOWRa-0007xr-Pj; Tue, 02 Jul 2024 01:52:46 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <clement.mathieu--drif@eviden.com>)
 id 1sOWRY-0007v3-5P
 for qemu-devel@nongnu.org; Tue, 02 Jul 2024 01:52:44 -0400
Received: from smarthost2.eviden.com ([80.78.11.83])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <clement.mathieu--drif@eviden.com>)
 id 1sOWRV-0006Uc-8E
 for qemu-devel@nongnu.org; Tue, 02 Jul 2024 01:52:43 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=eviden.com; i=@eviden.com; q=dns/txt; s=mail;
 t=1719899561; x=1751435561;
 h=from:to:cc:subject:date:message-id:references:
 in-reply-to:content-id:content-transfer-encoding: mime-version;
 bh=ypVe/9XWlbiYY67gHDpjPVysJYf8D8Q3GP6UPMoOP6s=;
 b=qjDPZ0CN7hNJlTneAfhWD6IGtIf6vu2zTXv/iIsurFLVoaab1WdRDZcV
 OBor1geSgTE2+sduCGRd7Xum29C0RFoWPizB28It0buCGKKNJjaySxUCt
 LKZgEaSdtyM5+UiaDJk7VnO6RPE7F1u0B6C+fIvocleHxAU58cRmIwrVY
 NqnR67EHhcNfelpI5mOB3Grvr3HQZA1R+nh/MwvSlF3/iMC8cjaniUlS8
 U1cZsky5o982TOgEXcrlQjyp3kJQ3gNXwHXj4iedvziZesAI+zyPNAWJr
 BrkFl4MMMh+TDavvyFv5QGgZ08vwZsvq/ZAXv2EgFMmFnJMaMagp7F/sY A==;
X-IronPort-AV: E=Sophos;i="6.09,178,1716242400"; d="scan'208";a="15721514"
X-MGA-submission: =?us-ascii?q?MDG1dW4DwTKg5X29Mnzgw2RyST+/lIrN+Prd27?=
 =?us-ascii?q?3oED4kOqyp0zaimp1u2B6tGAvRl3wIC8mo0x+gTNdyOK96utJY8O94gd?=
 =?us-ascii?q?L8ePPL2XhIc0im1qxsA2bd72nuMWLV9srRfZd78ZCMAWyDarTAecOWz/?=
 =?us-ascii?q?VZJTjhvr/gmfMsMWiw9DF6ZA=3D=3D?=
Received: from mail-am6eur05lp2104.outbound.protection.outlook.com (HELO
 EUR05-AM6-obe.outbound.protection.outlook.com) ([104.47.18.104])
 by smarthost2.eviden.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 02 Jul 2024 07:52:35 +0200
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=fLifgvqtK+AkNoVMzhXLSKQ6i/jpQqBsLfgUIS3W7uzYVVBh4W62oSYcXNjqXxcpVKaHHlfsaBaxM1nB16ofw9jpI6ZtP9FtKPtxPyXSiFNgwf18yJpVNPCsbEdEQZWxYo6N1XLc5n2PRd0nUCD8AY02RNg5id+nMNLg6gDLhEMk4X8fe10IpTmMeSvhQTweyJQf5IGn3RUsmF9ZryLHhn3YC07ySlVXvFu8lSCcVbhnByzZFiAKWfYnYRRF3vRMaqW8Yp6QH1aI8tm0RoiSHxo2xiNcOJc/j9IMORbwyEmndnuG8g1shdSDxfm3BsXW2Q61ARWTWhMSbjaKYP4ZKw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=ypVe/9XWlbiYY67gHDpjPVysJYf8D8Q3GP6UPMoOP6s=;
 b=dGb3YdoIbXyxnzPwgQxHQq7dVKFXdglMgPUZxCd+uHsbJ95h0erTwclU0A7EyIOo9gFmFs/LIUPPjGAiagv5//a2mm8GfGEizkIqUq9qf63m+yTohegbffzgcY3ip/cqH1+32mAxAq94n09r/xP+Vrxs9N508sDZn3gBmH0qXrUyF3KZorXXvZ6ZhYKcKtb+zOuZj0WaA6tBIoyptftPR+FxXbFyNsRUlnxbRMfN9HL8zE0RI8NY8Fp1yf98cM77p5oG0pIFc87/16F4GVOQhBVn6U+Y4tYh9gfw8w+GB68wOfzl5V9E+iH/MZdzKx+7Gpt49rvccH0kXeZWY/9x4A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=eviden.com; dmarc=pass action=none header.from=eviden.com;
 dkim=pass header.d=eviden.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Eviden.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ypVe/9XWlbiYY67gHDpjPVysJYf8D8Q3GP6UPMoOP6s=;
 b=NDsi1z542F84ln+w1jla/A+ze1gedTDZ4DuS2vnbNHIP4ncn9ZT1KNm/dgStVNx36/eLndLxJM55hk75L08e5AX8aJmS4Of0dYn5DGjg6WQLAa/3UdckQEEKgkQEREY2c8Ch5II72MKhvj+uLHwEPR54nZqNI5GZERcCt5noNmwEt6aMY2dchARegAc8JcoQ3ORI0orX5fPRbtHmDWDBhQbwvsvePktUJ6VDfCrba1CCF/5BbOUVFRvF2rGGa9NAr5sNeE5cXOfJLNllLSWy/kDFZt39gCBv/5GjdGAR07R2MBeR+SN8ApCsmgA/mlH09rGYpwvrCu+NehFsFCPPow==
Received: from AM8PR07MB7602.eurprd07.prod.outlook.com (2603:10a6:20b:24b::7)
 by AS8PR07MB7080.eurprd07.prod.outlook.com (2603:10a6:20b:239::10)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7741.21; Tue, 2 Jul
 2024 05:52:34 +0000
Received: from AM8PR07MB7602.eurprd07.prod.outlook.com
 ([fe80::fbd7:ca71:b636:6f9d]) by AM8PR07MB7602.eurprd07.prod.outlook.com
 ([fe80::fbd7:ca71:b636:6f9d%4]) with mapi id 15.20.7741.017; Tue, 2 Jul 2024
 05:52:34 +0000
From: CLEMENT MATHIEU--DRIF <clement.mathieu--drif@eviden.com>
To: "qemu-devel@nongnu.org" <qemu-devel@nongnu.org>
CC: "jasowang@redhat.com" <jasowang@redhat.com>, "zhenzhong.duan@intel.com"
 <zhenzhong.duan@intel.com>, "kevin.tian@intel.com" <kevin.tian@intel.com>,
 "yi.l.liu@intel.com" <yi.l.liu@intel.com>, "joao.m.martins@oracle.com"
 <joao.m.martins@oracle.com>, "peterx@redhat.com" <peterx@redhat.com>,
 "mst@redhat.com" <mst@redhat.com>, CLEMENT MATHIEU--DRIF
 <clement.mathieu--drif@eviden.com>
Subject: [PATCH ats_vtd v5 04/22] intel_iommu: do not consider wait_desc as an
 invalid descriptor
Thread-Topic: [PATCH ats_vtd v5 04/22] intel_iommu: do not consider wait_desc
 as an invalid descriptor
Thread-Index: AQHazEQIBXXzL7bpek6rQxeDAgf6ew==
Date: Tue, 2 Jul 2024 05:52:34 +0000
Message-ID: <20240702055221.1337035-5-clement.mathieu--drif@eviden.com>
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
x-ms-office365-filtering-correlation-id: c7d21eea-aa78-43c6-6826-08dc9a5b2b6f
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0; ARA:13230040|1800799024|366016|376014|38070700018;
x-microsoft-antispam-message-info: =?utf-8?B?aVExalNaMm1aQm4vSlRsaXdiVTR2allnR0hYOXZIR2s1bHhYUGo3NVFua0x0?=
 =?utf-8?B?VXFZanZTUE82eGNXVlJRZ1lYaVhIUGxVck5hSW5kcEthejBLNEdSRjFxSDZv?=
 =?utf-8?B?MFB6QUhtckhCODN6UDl1OG9IdVU0V25uRFFTcjVZSjJHUllXS0VsVEJEUUI0?=
 =?utf-8?B?K28zUlJ4Z0ZUZy9yNDJmWENFRmExK2VwMXFVWmc1NDNnT3h6L25qamZDb0JX?=
 =?utf-8?B?dXlwdGliMUthS0ZpVW5EaW5oRCtlOEtRdkgyK0NRN1ROZ2grSlZhb3paOWlW?=
 =?utf-8?B?RVMxWjZYRVF0K2h1NGI0aVJJOTlpNXN0dXJlaXB0QVFEUk5sVEVxRHJZYzlE?=
 =?utf-8?B?WmdYZVpZRzk3SGtheTQwUnAxVjUwSkdpY3E3M2lSdWFYbk1BcmZoYzYzQzds?=
 =?utf-8?B?WDZzcElPbzh3STQ2ZlBwb05wTUMzUndveStaMXpFNlJmMnRQY1k0UlEzSkgw?=
 =?utf-8?B?dG5seURFRE0vZUlDRDNLczdUZ1J2ZlczazZ6N1ZPRlVnMEVsTHRyUVdJeU93?=
 =?utf-8?B?SHhFY1lmMyt6TEhFYW9xaWYvSmllLzRXTmdYeWNPOTh6SCs0YVloZmV0cGpm?=
 =?utf-8?B?OGlxOVArVlV0VjBaSXFMZkp1ZmpxbVQ2MSt2Z2dHL1lmQ1lTaWpnNHNWbkN6?=
 =?utf-8?B?azRuRm16S2ZmeWNGanhRODBpQzVKYzcydFdvMVlOSTI4bTQwS09ja01sMzc3?=
 =?utf-8?B?bldYZjZjRXBLcnBTL1VEdXJWbUUxK0tVUmQwOVRKTy92YVlaeG1QdVEramha?=
 =?utf-8?B?eEx4WDNPbGJTajE4WGExcTYwWDZqTjVsL3Ewd3J4Qjdnd00za1ZDRG11MzFq?=
 =?utf-8?B?SFZUdGRqdVZENmZaajZ3SUJsc2xKRWR2dlBuTENDUUt1aUQ0TW1wdDdhbkVh?=
 =?utf-8?B?WGhjeEo4cEdack15RndleTNtUFVvOUNSK2FMeW0vYlBzSjhYRzRDTmw1bEl6?=
 =?utf-8?B?S2Z0ci8yN2NQenNMbklsUDZvRlNPam1JcWprUy82Yk9zMDhHM1d4LzlVQi9J?=
 =?utf-8?B?eE8vSHVPWUxMd3FBN1A5OEVCNTNWQXdmTHY1VUxBL3pBY05WaFE1UVZDRVFp?=
 =?utf-8?B?UVFUdW9hSlNBMFB2MStubnEzYlJpMGU2TEUxMlAvcmhYeWY4TnVYNVh3ZjNZ?=
 =?utf-8?B?ajhYZ2lRTzJScVlEVEJzYkxCTU5SNmp1TzkySEJMcnlOVnN1LzJiUU5YM2dv?=
 =?utf-8?B?Vm9MVGpWL1JIbmJkUmNDQzR5a1d0WE1qN3IySGJBSlF6SE54V2Ixa01lUzR3?=
 =?utf-8?B?djJPL0ppRURsQkxwWlhXajcvcXBWUUd1Mjc5c3pVUXhXRWgwNStuM2NiaS9S?=
 =?utf-8?B?Sk5NVkFRSFpDLzZISE5XTS9sdFFsQ2grQWZqUEpINnZpMTNmWmVRazhXTk5E?=
 =?utf-8?B?REdJYkxNS1BGT1RjeGFtUGlCdkp6MlM5b1JiNjlmSCtacy9Vd1hKNXl1ZnBs?=
 =?utf-8?B?cTY4RmFCSE5pUFV3UmdMWWZQYUQ1NVNIdDBkd3FTbFRsUW1wRndSRXZSM2N4?=
 =?utf-8?B?YkxaRUpFVGpBRDlOSlQvWlVNbC82RlJsUEd3aW9EVmRsMmNwL281TTA2RERD?=
 =?utf-8?B?TmRJbmlzdmh3NG1adE16MEZRWC9zTWVMSFpNK2lvdG81YzBPNWFHR0krVG4w?=
 =?utf-8?B?bzVLT3JMZUdpMHNpQWRHL3JHeWF3YS94VDF1VmFSUVZha2RGQUtPanEzb3ZU?=
 =?utf-8?B?N2ViNnJXVjkrNENyei9HSUZFckZmNE5EeUcvRDNZSEtkU0FSTG0rZ2o2TjBU?=
 =?utf-8?B?QTRXL1RIaU5zN0FYbHBnWTg0RWR5LzJPclFmV1FhQW5zQ1F5aDVSVmw5clZH?=
 =?utf-8?B?SkwwSGdLSzdBeGJSSnFoMUFScFFPTGI4aDNWQ1FYMUtzYkQrR0V5ZEs4TW9H?=
 =?utf-8?B?TGsxenlBQkJseVhaVmdwVTRtcExqVVF6Mk8vYnB2K1JuY3c9PQ==?=
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:AM8PR07MB7602.eurprd07.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(1800799024)(366016)(376014)(38070700018); DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?blhwY1M5b3RWRDRra0JEZHlWSE0xSGtqY2w4Vk5OUlpXS25CSVJwdCtQV2ds?=
 =?utf-8?B?L2dLNExsV1FTZlg4b0JFWm96ejNjTEw0d00wclA2OFYxMDFocytTejg1d3ZH?=
 =?utf-8?B?OEFscGViNzFXWnR6QmJmM2hEb2x5QlZvU0k1MWJ1QzlLd0hKYnoyKzBtRW1W?=
 =?utf-8?B?VWNtakRWenJMTEdUTlZ6VzZtbk5VWUlSS1BCM3NSaDFCelpRVW5UOWsxVkZN?=
 =?utf-8?B?Ull1eTVzQlpyeEkrUUhXM3Y4VEJaek5zWVNRcjN4eU9wTnBMVGd2eDZ3d04w?=
 =?utf-8?B?MXQxclZxZ0NNWmJUbklMb2NTdFB6V2Z0NDhzNmdaY1F1MlFCTFI4SEhIaThT?=
 =?utf-8?B?WDlxRGR4ZjZYMUNoVGxJUGNjMHRqNmQvTnJGTVBXSk5tR2VPRWMzSDFzbmVY?=
 =?utf-8?B?UVlYbUtPYzVUbmYzVGcvS0VydENhdC9RUmZIYUh3d2lRekJHTUtYNDhvWlNV?=
 =?utf-8?B?amhZc1M5V3FobVA0OXN0VDNxRlhSTWJJNFNxTGxLSXkxZ3VQK1VTc0NsUVo4?=
 =?utf-8?B?WWxsOVp6R2FSUkJNczFGUTkvZVp3WDQwaTk3WmlaQitYZ3BSbGJ3U04zcjhP?=
 =?utf-8?B?eVR2T091d0hkMzgvRUxBbFI5RDJTbWxGd3J3bG5jMy96OWlidzI5alVxRXRB?=
 =?utf-8?B?RmZJMkd5TWpXallSakkrNHhyL1VndDN0cnhrWkhMQk5EcjlNb3lHdEFSUXhS?=
 =?utf-8?B?VytzWlV6L0FhWm5pQWhpa1J4Y1FKeTVBcHVrMmNhL1laRmZWWjhXOTFyMXFE?=
 =?utf-8?B?Sm80RWFHVFJnVEFST3hqR1JUY0lsZlhlcThzNkpJeFMyN3lqcURCYXlCM1lr?=
 =?utf-8?B?RVFTWjZ1NE5MRy9VMWVCQWNOYkJzYkZveDRiSUxPcThOMXpUcHl3TURJYXF6?=
 =?utf-8?B?TlNYaFpuOFQwaDNNSTM2ajQrMzFRSG9rd2NsS0ZKM2NSckV2d0I1K0JIVWVm?=
 =?utf-8?B?d2ROSURpd0QzbkZaWk96YWU1aWdKSkFFYVg3TW5qTEhaNkhFSEkwa0pwbmM1?=
 =?utf-8?B?b25oQ2NROE80NWVJOGZjWlFZSTc1ZVBOdHhKOEExek9WUXNwNUlDTmNHWHd3?=
 =?utf-8?B?STVKbUdIS3gyK3E2YkZPN3h4TkhwcVAyd1UxYWIzaXlpVVU4UGR6NmoybmhB?=
 =?utf-8?B?NE15MEgrZmxOLytmZ2NTR1pKMFEvaWFvaWQreEFjRm8xU3BMSjVYS2V0WjBF?=
 =?utf-8?B?cDlFRW5ibjk3YWlRbEJxZ0gxcEhYZENRdnRsWmdaM09KQzNTZlVWbTJBSFJj?=
 =?utf-8?B?ZnpRYkpPWUVPUy81aDZPNGk5NUhpSGVheGl3VWVDcnloSWlhMi80OEJIanN6?=
 =?utf-8?B?THlWcnh4Rmg4anMyVVFXKzgvaUlqcE9FOG9nSU5KbXRySEdhdTc3UERSU0px?=
 =?utf-8?B?MXA4cS9ESFFSYUttbEF2dGM4ZEhWR2Vzb0RaOXdxSGxOVFFsM21qWHNzc0xv?=
 =?utf-8?B?eFJndndSVU5LWFFJQ0YwVjd1ZktlUXZ5ajdWdHZGcWk5cWZZTmEwc2FMZXFS?=
 =?utf-8?B?TG5zZDJzMnp2cWpPV1M3NEQ4WWZJOVlzaFRMK3J2YXNwOTMrMTMvdGZBWjU5?=
 =?utf-8?B?T29mc1o3Y0t1RDNpU09UUVo3bE1CblZYVUhYdGNyZlBlMG5YSG12UGt2RWYx?=
 =?utf-8?B?MHVwOXhPK29jemFjVDZZbXRCZFVlakJUbXNQeTI5aytrMGUyK0xIK2dya3d2?=
 =?utf-8?B?UFdjeXUwamM2LzZHUHhOdTQzS0luRWFtRkFQa2ZDOUpCaS9rY1I5K1VIcUQy?=
 =?utf-8?B?cWx2YzRIR2IzWmRaU3htRDVySkttQ3F0ZFZjczY4QmVObU1YMWE5a2J1UXFF?=
 =?utf-8?B?bkMzWDlsc3MxVFg4T2tiRzh4SGJkYVpSd2YwNU9ER3JnS1dzM2tsNVF5ZE8x?=
 =?utf-8?B?azF3RGU5blBEdzRTcWZUSUxJR3Fha1IyKzh2eS9RUGplbTVIR2U0Z0JVSmdC?=
 =?utf-8?B?MTY4c01TcHNycEw1SWNyQnBaN1p0bkxWeWZxeTZGd1cvQzZqVHRxVE03VThm?=
 =?utf-8?B?enBxSEJGVkZiMXJGRDB2TlB0UmF4bStTTGdCTWdjcGl1TWtpK3k0QjUwQmU5?=
 =?utf-8?B?VGNFdEUrbTZHUXphQTZMRzJSdzd6NFE4STJLUTJVTVhScEdZMlI0cVRCVCtN?=
 =?utf-8?B?eXBaaGpxWFZONUpwbm5PdWxPaEZ2aDdiNEloTDFQbVFsbkZjWFh0ajBwZ0ZI?=
 =?utf-8?Q?w1pmFIPIf2nCTX7M1mgRiWo=3D?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <70B36C38F22B714284A3C3B1861D21DF@eurprd07.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: eviden.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: AM8PR07MB7602.eurprd07.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: c7d21eea-aa78-43c6-6826-08dc9a5b2b6f
X-MS-Exchange-CrossTenant-originalarrivaltime: 02 Jul 2024 05:52:34.0728 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 7d1c7785-2d8a-437d-b842-1ed5d8fbe00a
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: bzerqBSa0zrt5OVfHLdKsULtrGkWnnYudfzAFi2b4zcnTQN5LtyAHy8IF3+8irtZd2WQLvaAe+khnKWFXTZr1ESEQT2EpkgpD5eRa8ajFOgF0lQ4MFN36LkFtjfNhN3x
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AS8PR07MB7080
Received-SPF: pass client-ip=80.78.11.83;
 envelope-from=clement.mathieu--drif@eviden.com; helo=smarthost2.eviden.com
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
bi5jb20+DQoNClNpZ25lZC1vZmYtYnk6IENsw6ltZW50IE1hdGhpZXUtLURyaWYgPGNsZW1lbnQu
bWF0aGlldS0tZHJpZkBldmlkZW4uY29tPg0KUmV2aWV3ZWQtYnk6IFpoZW56aG9uZyBEdWFuIDx6
aGVuemhvbmcuZHVhbkBpbnRlbC5jb20+DQotLS0NCiBody9pMzg2L2ludGVsX2lvbW11LmMgfCA1
ICsrKysrDQogMSBmaWxlIGNoYW5nZWQsIDUgaW5zZXJ0aW9ucygrKQ0KDQpkaWZmIC0tZ2l0IGEv
aHcvaTM4Ni9pbnRlbF9pb21tdS5jIGIvaHcvaTM4Ni9pbnRlbF9pb21tdS5jDQppbmRleCA5ODk5
NmVkZWRjLi43MWNlYmUyZmQzIDEwMDY0NA0KLS0tIGEvaHcvaTM4Ni9pbnRlbF9pb21tdS5jDQor
KysgYi9ody9pMzg2L2ludGVsX2lvbW11LmMNCkBAIC0zNTAwLDYgKzM1MDAsMTEgQEAgc3RhdGlj
IGJvb2wgdnRkX3Byb2Nlc3Nfd2FpdF9kZXNjKEludGVsSU9NTVVTdGF0ZSAqcywgVlRESW52RGVz
YyAqaW52X2Rlc2MpDQogICAgIH0gZWxzZSBpZiAoaW52X2Rlc2MtPmxvICYgVlREX0lOVl9ERVND
X1dBSVRfSUYpIHsNCiAgICAgICAgIC8qIEludGVycnVwdCBmbGFnICovDQogICAgICAgICB2dGRf
Z2VuZXJhdGVfY29tcGxldGlvbl9ldmVudChzKTsNCisgICAgfSBlbHNlIGlmIChpbnZfZGVzYy0+
bG8gJiBWVERfSU5WX0RFU0NfV0FJVF9GTikgew0KKyAgICAgICAgLyoNCisgICAgICAgICAqIFNX
ID0gMCwgSUYgPSAwLCBGTiA9IDENCisgICAgICAgICAqIE5vdGhpbmcgdG8gZG8gYXMgd2UgcHJv
Y2VzcyB0aGUgZXZlbnRzIHNlcXVlbnRpYWxseQ0KKyAgICAgICAgICovDQogICAgIH0gZWxzZSB7
DQogICAgICAgICBlcnJvcl9yZXBvcnRfb25jZSgiJXM6IGludmFsaWQgd2FpdCBkZXNjOiBoaT0l
IlBSSXg2NCIsIGxvPSUiUFJJeDY0DQogICAgICAgICAgICAgICAgICAgICAgICAgICAiICh1bmtu
b3duIHR5cGUpIiwgX19mdW5jX18sIGludl9kZXNjLT5oaSwNCi0tIA0KMi40NS4y

