Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1802DC3064D
	for <qemu-devel@archiver.kernel.org>; Tue,  2 Jul 2024 05:53:48 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sOWRl-00083R-Fl; Tue, 02 Jul 2024 01:52:57 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <clement.mathieu--drif@eviden.com>)
 id 1sOWRg-00081c-3l
 for qemu-devel@nongnu.org; Tue, 02 Jul 2024 01:52:52 -0400
Received: from smarthost1.eviden.com ([80.78.11.82])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <clement.mathieu--drif@eviden.com>)
 id 1sOWRe-0006cX-3a
 for qemu-devel@nongnu.org; Tue, 02 Jul 2024 01:52:51 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=eviden.com; i=@eviden.com; q=dns/txt; s=mail;
 t=1719899571; x=1751435571;
 h=from:to:cc:subject:date:message-id:references:
 in-reply-to:content-id:content-transfer-encoding: mime-version;
 bh=fcrGvIymbVDEDf72GNfFZEeTZnuVqowT/D0J4yl/qfI=;
 b=YZmG9asopiH5+ssWrQEECu+xMXpRjrdT8ZUe2Bzi9pN4FcpExv5HP1k3
 UFZGaF7JaR8aF8QlHZye+elh4rY+PnOi3YGIA8ombq5XAAym4UwSTxBjP
 cyOfdXezNDkgYIAia/eTQYLtqbTt9v029LAxXuDatFJ3ZCJ66+zHlgQbd
 m7VpLrWe1njZzOhiaPQlc2uiAV9Eiq01cvKGPe8Gfaeqp/vOHpFR1uH1G
 GFKPKqGx3CurIQIv1lbiSSLLBMn/0A7quvsk30pYwgIRORaAKU2pYHx6m
 pxikLkKJtL/MgnOIl1L58dMFltSQsr4SMGO83iypyL0VMnYvvE2k3SBuY Q==;
X-IronPort-AV: E=Sophos;i="6.09,178,1716242400"; d="scan'208";a="15715683"
X-MGA-submission: =?us-ascii?q?MDFRmtchDG0XCPWEeqe39yVZtqV5mWR2LJSdqZ?=
 =?us-ascii?q?uIhsluVHB9P6R992InG5svM5qi/qBcjNtncZlDXL66+wBlewlVEtUa0V?=
 =?us-ascii?q?3vr/IziSgx3Xn1qDY6fpI3o4XHN/8SM6KjGYL+GqDvKwokJwUg+1RXga?=
 =?us-ascii?q?O0lnLK5D0sZ/y65kwRPMxObA=3D=3D?=
Received: from mail-db8eur05lp2104.outbound.protection.outlook.com (HELO
 EUR05-DB8-obe.outbound.protection.outlook.com) ([104.47.17.104])
 by smarthost1.eviden.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 02 Jul 2024 07:52:50 +0200
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=EUiQMWta4bnbe4k1z2EhGo4IHZiYV0ri1OnaGT6fK4K1GpF7wpvhs2AO3G4ATjuoe2VfOFw5V2gW/apqaDWLQY/arjaZbye0qM+NmfhnjSrOSHV8O4CgCtvMXO51FNO1xQdgvgSv3J+VVQq9eRiLOc1D0I3WkEkO1JM7N0oJUxyZuIdkhrnHJ99Xu24AFljEhFcnhnCk3pBi/KoKxzwZB4l7bN17AhyoqIu6dFBjilq63w4JCh/5F3wUdiMvdoh4g6kiW8hHRNiIIzGlPNty3z4Yw+JvCctpBmggc9r7gDTHcBeQ9jXuTVcSbbBxmk5q8mL8e1RP6noxmX/p2C5QFQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=fcrGvIymbVDEDf72GNfFZEeTZnuVqowT/D0J4yl/qfI=;
 b=Y55cjIihjQe7WIijHGYmoaXL+XuD1EWY5ZvqiYbBQP2uzyM9yUUyEhdz/9NNckVRpikdrzlij9e8QQ2izrfxps6gLVRaElJyXIhaQ59xy6lxGQWZcbiTwEwHdqEjngGYQgUFzmJkjw1rg2L2fMNVeR6sFw8bhl9M9vYlm3CqQCPPmWhGPwf62gNnTuevD2XXy2N383jAMXuoMTI156xZLaj2F27KRPFR3SPU+JE//tPJhwOTNSJCsngzfClITxR+vvoKpA7JwjKl8gmi4aqBDrrVe4rHshHY88ryqNCIdy4aPNjswP/w9bOcCgWkjKvCDfpq9zkdQoObnXSRYUwP6g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=eviden.com; dmarc=pass action=none header.from=eviden.com;
 dkim=pass header.d=eviden.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Eviden.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=fcrGvIymbVDEDf72GNfFZEeTZnuVqowT/D0J4yl/qfI=;
 b=bQW90S1217L8KB5ovFHOcc9lo61cAVYckTQeZ5hjsxb3hbnrQKdjhcPTuvPWBcW5rUpRnzGkcPu8hv2RODtYb6XiBnLj7wDBM98WriXCcjdh7hcUgeBBtfdHL5k9zvKyI8MHZYeIdtbYmIfYHIk+PxlfZLZDXHqxkDa1UX2lP2VTzPhD6y4e9TNZkRHP6OL034whGozb9b/WskADAs/6UOH2lYbNtf3JM//iD+GKYChX4ayloDBzDUlSQmr+7NeukMboqrXwvzz460K9W02DWscpgB76IJvNJe6zWJcF+W940OyxZX8t9zN/vZXFhh50UqGS/SJ6cA9Vidvs7ow9RA==
Received: from AM8PR07MB7602.eurprd07.prod.outlook.com (2603:10a6:20b:24b::7)
 by AM7PR07MB6215.eurprd07.prod.outlook.com (2603:10a6:20b:13d::7)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7741.21; Tue, 2 Jul
 2024 05:52:46 +0000
Received: from AM8PR07MB7602.eurprd07.prod.outlook.com
 ([fe80::fbd7:ca71:b636:6f9d]) by AM8PR07MB7602.eurprd07.prod.outlook.com
 ([fe80::fbd7:ca71:b636:6f9d%4]) with mapi id 15.20.7741.017; Tue, 2 Jul 2024
 05:52:46 +0000
From: CLEMENT MATHIEU--DRIF <clement.mathieu--drif@eviden.com>
To: "qemu-devel@nongnu.org" <qemu-devel@nongnu.org>
CC: "jasowang@redhat.com" <jasowang@redhat.com>, "zhenzhong.duan@intel.com"
 <zhenzhong.duan@intel.com>, "kevin.tian@intel.com" <kevin.tian@intel.com>,
 "yi.l.liu@intel.com" <yi.l.liu@intel.com>, "joao.m.martins@oracle.com"
 <joao.m.martins@oracle.com>, "peterx@redhat.com" <peterx@redhat.com>,
 "mst@redhat.com" <mst@redhat.com>, CLEMENT MATHIEU--DRIF
 <clement.mathieu--drif@eviden.com>
Subject: [PATCH ats_vtd v5 22/22] intel_iommu: add support for ATS
Thread-Topic: [PATCH ats_vtd v5 22/22] intel_iommu: add support for ATS
Thread-Index: AQHazEQQ+8Pi8kxvokGHkqBN3Nk9bA==
Date: Tue, 2 Jul 2024 05:52:46 +0000
Message-ID: <20240702055221.1337035-23-clement.mathieu--drif@eviden.com>
References: <20240702055221.1337035-1-clement.mathieu--drif@eviden.com>
In-Reply-To: <20240702055221.1337035-1-clement.mathieu--drif@eviden.com>
Accept-Language: en-GB, fr-FR, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=eviden.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: AM8PR07MB7602:EE_|AM7PR07MB6215:EE_
x-ms-office365-filtering-correlation-id: 3478fdd3-5434-495b-8b02-08dc9a5b3306
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0; ARA:13230040|366016|1800799024|376014|38070700018;
x-microsoft-antispam-message-info: =?utf-8?B?WWhjVlo1dDNCaG5DSktyWWRFTGNjalVaZ1ZaWHJHRDdubTBDOFViVDAzSVp3?=
 =?utf-8?B?STh3M3hnUC9IVnJxU1FIUzlubVdjZU53UTFPZk8raS8rYTY1YUwrK3k5ZDlp?=
 =?utf-8?B?VmIrRUYrOEFuRjZzSnRtLzk0RmZ2bEpGVWdZbHAzMVZJZGlaUHpFZC9Sb0xL?=
 =?utf-8?B?UFo5VXdTRG9WS1BaNU9sMFJDRVZaekIyUE1aejNJMTVqOEFsWm9HNER0cEp4?=
 =?utf-8?B?cXRaRDlubDBQd2hBVTFjOU5KZjNXQThZYmdWbGRvVWJyYlVwS003ckhKM21r?=
 =?utf-8?B?OEFwNkhWdHdidmVuZHdnVmhHYmxzTjZoVy9SRTRpMkJqRnhYbnUvTWxKdnlm?=
 =?utf-8?B?UzBBU0VMTGEwOW5GdGpLbTUyVFp1d3VlaFRNb2hELzZTSk1ZT1FjSnBDdml5?=
 =?utf-8?B?UWNWcS9BeEJvTmk0MGZJa1l4aVV0Z092Q1RoL3dFcWgvNDRYZ0UyY0g5MU5h?=
 =?utf-8?B?ZlUwaGhTRG5KTUJuUm9UcitTaHZlQjVqNUg1YTRhc1VnVkI4d2ZXeWhNeGho?=
 =?utf-8?B?bWpIb2ozU2U1Z05Zd0ttUHlxd2xIeXExSXVGdkxzcGh1ZndUS0tMZlhsb3BR?=
 =?utf-8?B?M1hQOFVsQ3dncG85VjV6TStSZlNzWDR3SjZpaTlmMEQ2NTBlWEY0TnV0YVZy?=
 =?utf-8?B?K09oL3NVZzlPaGVJYTd0WWtmdjVzVTlwVDR6eXFNbStYZ1Q3VGdHanJUTXll?=
 =?utf-8?B?R2E2dExjZkJwdjZvU2l1QUhZaXBUdUNuc0xOV1RBbnFrbjZWQUxteHVJbHFp?=
 =?utf-8?B?WllZWnZXUmh6VWErOWQ1UmFzSkozVGxIN0x5UkdvQjFSUkt0RWNyNEJWNENU?=
 =?utf-8?B?VWxFOVM4V0FoZm1nMUZXbjJEd3JvRm4xWS84NnJpaURpVHBNSmluOXdyYXow?=
 =?utf-8?B?SklDMk1yV3NDNFArS0RjWlpXVkl1dTNCMkR2WmFJcmtGTkFJTVBlSHRnSjV5?=
 =?utf-8?B?cUw0QTdSVkhMRTZidGxYelF5Z0QyZDh4cU1WcmNtRENmbTM3V1pqSTVkUkk1?=
 =?utf-8?B?UWd4bmh6UnRkRllhb0lCaEFORGduWkorTHJzaTVQeGwxdDlTMmxoZm4wZ0t5?=
 =?utf-8?B?cnl4L1o2OUdaVGhFQjJBMGtEVjJSd3FieHZRM0U1Zms2dkVDMUJYRzBzRnNY?=
 =?utf-8?B?SVR1cThCbDJMd0t3UkJzcjJ0d1JITTFWakxhOFlteWE5S2RBZFQwSjRCRXJL?=
 =?utf-8?B?b1duUGhTZWcwNDhHVU9nYUxvSzhLa2NGajkvN0hoWUM2OE4yK2lRcDJtcVJN?=
 =?utf-8?B?NjNnTjZrRWhTdVpwb2ZLb2FRREhyQlF6Y25hbWx0aEw2eCtDcGlJTy9CU1Bl?=
 =?utf-8?B?Mm01RFg4bXNvTUJta08vb09WQ28vNWdVbzE0N1Jjdlg0MzZHSHE1ZEdjSXpv?=
 =?utf-8?B?aklzOGZRM29hUktNZ2NPV2tyZDlQbEZjZkJ1Uzhzdi90aS9SdTJDYU5ZN3Vq?=
 =?utf-8?B?UFRuTmU0b0RoUzM0QlRMLzNHU0NIMDY0Z2IzSVVxMGU0OHA0Nnpya1hGQTJm?=
 =?utf-8?B?T1dBUW9DSmhhdk1wUlBtRjQ2OHRHNS9qNEFsakxqUVBQQ3p4TUJTSFlCamV6?=
 =?utf-8?B?VThhL2IyWjRxN2dlWG8zVEdJVi8wVmN1MlZWYUlxU3pUSzB4MDZyODRJU3F0?=
 =?utf-8?B?MGNWOHN4WGlRbnQ3S2hhejJ2RVJ6ZHMwd2xvUU5PVFh4eEUzVWd2VnhqSzB1?=
 =?utf-8?B?UndEOFNtQkVTeVNrQU5hc0ZScXN5SHY1RExsbDJKWWZrb3p6bDhHNmdoVVdQ?=
 =?utf-8?B?aVFyUFRqUFF2bHBvS0ZFTHQvYlE1ZWZQTGVUTkhMTkhtTDJjRVA1VzZjVWNB?=
 =?utf-8?B?WnRQeUFmc3VhTEY0SmpNTFRWbCs1SmpKVXgwYnI2RFZ5T3l1Yk9FaVAzQm41?=
 =?utf-8?B?YXdZME11d2M0QTZxQzk4UlJMZXN6VFRvQUI1MXBVZCszekE9PQ==?=
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:AM8PR07MB7602.eurprd07.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(366016)(1800799024)(376014)(38070700018); DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?WVcydlpEaXl1QmNpOC9QVlRJMGJHK2YxblNsTks3OEd3U3JocHIraEtwSTh3?=
 =?utf-8?B?cEJhMHRnREFrdEtuanp3QXZLbkdhSDJ4SldWakpsNGVFL3ExVlhHWTNFbjFN?=
 =?utf-8?B?V1UycDJvRjZuais0SThjQTBUU3Y3QW5NVVUrSGN1VEZadnRWclBjL2czV0xw?=
 =?utf-8?B?Wm1ZL2x3WlhvRlIyKytVMGZMTTZtM1czRWFaWG5kU2ZYYlErRzlkWjErQVd5?=
 =?utf-8?B?Nk16Vlhrb2xhQ01hRWljeENiWndYTm4wa2dXMXpTUGVyVFgwa3laaDAySU9x?=
 =?utf-8?B?b1BHYjVNTFlldWF6dU50R3JQTzVDa0NiWjhQTGZ1MEMwZDVGeWFQWFg5ZnQx?=
 =?utf-8?B?RzNnc2hhVi90ZTlza2MrTklPbC9FTGp6aHhHcVgyVjgvVVNUaTN5NTlwT2xJ?=
 =?utf-8?B?NGVleVJ5c2VUWHpWc0ltWWR4aiswdnowY0JDcGlCTk0wZ2hza2l3OWRlUWYx?=
 =?utf-8?B?MENqQmdQTEttMm9Sd3V6YzVvYitCejBMNkY5VjlRdUFyM1NCR0JEcEFRdEJB?=
 =?utf-8?B?cnJPOG5sWngyMGpDNDFxWEtoWlB3YWZvaXRzUUM0aFcxZzVYMUNOLzNJQ0dV?=
 =?utf-8?B?Z3VvN1l4bTNvUno2QWdBNkRQS2N2VU9CRUhmNWV4UDNhSmRvdmtDOGMvSVha?=
 =?utf-8?B?Sk5kTSs4Tnk0Q080U3ZqUTdCbjR1bGZTYW9mcG1pV0NYZFBkWkN5L1Nsb1Q3?=
 =?utf-8?B?SjloLzk2NXlibjJBT2NpZC80TFpQSmJXWGNDWnBYQ0pITHBxdHpFWWVxSEFq?=
 =?utf-8?B?T1BERCtrU0RUUW0ySzlPb2p4clRkK3EzYTA4WDlrZ0NRZG1oN2hnaG5iTE1J?=
 =?utf-8?B?cTRVa1p1dTZGUVFVaHJiQ3RDdUdrM2tPZWJGQndCRlhvSndvVEhodEpYN2tJ?=
 =?utf-8?B?U0E4NXBFbmp3Zm5OcG1wL3Ntai9XR0c2TWRKdFJ4SUNFcG5YWTVaTFhpSk5X?=
 =?utf-8?B?QWMydVJnOXFLR0NjQlM2V0pnTFQ2aE8zQTlKY0pPeWZucGhPRU85RVJuS1c4?=
 =?utf-8?B?eVJsTzdYY21LakRvZ0QyMVUwa1N6emdMdjlhd3RmOXNKZ3oydFpBdlVGN00v?=
 =?utf-8?B?eHNYRStrYUQ2Q3k4bGN3ODdCL0JjeFZHSmkzdnk0UkREcVpNenJSeXFUdUl0?=
 =?utf-8?B?OVY2MlNlSkVjVmRQdnVMQjFPMWlzb0JOR09QVDFvajViclMxYTN4Y010U1I2?=
 =?utf-8?B?WlBuN2J2cWhTWHIveUFHQUZGWk9jMnd1UXJ5RWp6Wmk5K3dBVnZpNU51UXVS?=
 =?utf-8?B?dHdZMGtOVVpDT2lMdkJhdkZCelErdkZhdzB2LzZHYUJRQzEwcDQ5aHhNbSsz?=
 =?utf-8?B?MTMxK29TSHV3Y0RCdzN2V0ZjVVdHVWNmMjdwNnlUbExaUGl5ckNKSFRLUjVl?=
 =?utf-8?B?RkJ6R3B6bmNkbUZEcTFGcVArRkNqWTgvdk15bVhDZXlNbDV1RHVHaDM3UjZq?=
 =?utf-8?B?dldhUnR2ck5WQXhLZEdZUkI0KzhiTEFMbW83VlpzM3hUb2Y2WTg4bjlTOGhI?=
 =?utf-8?B?QlEyTTVMK1N0eVRHcmNLbzMxbFBEcXVBWlhWakpXaFNUWEYwSUxpY3V1cVdU?=
 =?utf-8?B?NXRtMnlSWG4xSzkzcXRydHE2YlloRjY5TjV2c2w3NytrZnhtZW1Nc0lySzR2?=
 =?utf-8?B?UEQ0OEh2bitnMnVzeG42MEZ5TmNDVUlneDNDUFJWWjRzY2hValpORzlTUEJK?=
 =?utf-8?B?Wkl3ekpKb2tiOS9vUk01QXFNNzVWTlhZQStZQWI2WTR6MURHVTNxKzJ6T2NL?=
 =?utf-8?B?S3FvTEdVS3VPcldHM2NDczRCSDRxZ0tyeC9XQUk1cDhYbjRqbEd5bVJ0NndW?=
 =?utf-8?B?VGxKd1pncWpUanVWRGpSdDFObEtvRlZQdDdGUUl6WDlrUGVmWGtQNWh6VXhJ?=
 =?utf-8?B?alB0eHdJV3RraWVWMWIwdlQvSjNmQmhKUG1NazBwbFZpRnY3TlFEZFExVjBE?=
 =?utf-8?B?aVA2MGQ2N0RGZHVWdExSQTd6YnN0cG85cTQ0YWFkUlFKdGpxdi9PdHJoR1FW?=
 =?utf-8?B?ektUSjg4dXJ5TU9CNW1tbEtQbngzKzVITURvSnhHMHlyYXNmR2k3dTI2UmZl?=
 =?utf-8?B?WDJUcURKc3RQQUIvVzYwVW9pRVhnVlRxVDFWb3FZVklZNjZsSG5FREZVZWYw?=
 =?utf-8?B?b2k4UVpaWG5CSFUrdzZNcXdGZ2hQVTQyeGVYWHcrM3dyZ1Aya1R1b0dMS0F6?=
 =?utf-8?Q?2RCQi1/Kbg0Wq2AS28IshvY=3D?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <BF1C2AEDFC275548AC0DE39AAC40CFDE@eurprd07.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: eviden.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: AM8PR07MB7602.eurprd07.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 3478fdd3-5434-495b-8b02-08dc9a5b3306
X-MS-Exchange-CrossTenant-originalarrivaltime: 02 Jul 2024 05:52:46.7992 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 7d1c7785-2d8a-437d-b842-1ed5d8fbe00a
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: gXXxaq/ycJBmddgUqmYtc1Fwyg5z5Kr29MJQ6ausZm2O7kg5sEm0+XtpzjsESSObK1KUjGJ6W6FgwRE18aR4hsEpAdKYCSUNgnaHxrivPDUmWVwsLQAcBTfVKxUlgCaq
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM7PR07MB6215
Received-SPF: pass client-ip=80.78.11.82;
 envelope-from=clement.mathieu--drif@eviden.com; helo=smarthost1.eviden.com
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
bWF0aGlldS0tZHJpZkBldmlkZW4uY29tPg0KLS0tDQogaHcvaTM4Ni9pbnRlbF9pb21tdS5jICAg
ICAgICAgIHwgNzUgKysrKysrKysrKysrKysrKysrKysrKysrKysrKysrKystLQ0KIGh3L2kzODYv
aW50ZWxfaW9tbXVfaW50ZXJuYWwuaCB8ICAxICsNCiAyIGZpbGVzIGNoYW5nZWQsIDczIGluc2Vy
dGlvbnMoKyksIDMgZGVsZXRpb25zKC0pDQoNCmRpZmYgLS1naXQgYS9ody9pMzg2L2ludGVsX2lv
bW11LmMgYi9ody9pMzg2L2ludGVsX2lvbW11LmMNCmluZGV4IDlhMWJjZTlhZTIuLjE5MWQ3Y2Yw
YTkgMTAwNjQ0DQotLS0gYS9ody9pMzg2L2ludGVsX2lvbW11LmMNCisrKyBiL2h3L2kzODYvaW50
ZWxfaW9tbXUuYw0KQEAgLTU0MDUsMTIgKzU0MDUsMTAgQEAgc3RhdGljIHZvaWQgdnRkX3JlcG9y
dF9pcl9pbGxlZ2FsX2FjY2VzcyhWVERBZGRyZXNzU3BhY2UgKnZ0ZF9hcywNCiAgICAgYm9vbCBp
c19mcGRfc2V0ID0gZmFsc2U7DQogICAgIFZURENvbnRleHRFbnRyeSBjZTsNCiANCi0gICAgYXNz
ZXJ0KHZ0ZF9hcy0+cGFzaWQgIT0gUENJX05PX1BBU0lEKTsNCi0NCiAgICAgLyogVHJ5IG91dCBi
ZXN0IHRvIGZldGNoIEZQRCwgd2UgY2FuJ3QgZG8gYW55dGhpbmcgbW9yZSAqLw0KICAgICBpZiAo
dnRkX2Rldl90b19jb250ZXh0X2VudHJ5KHMsIGJ1c19uLCB2dGRfYXMtPmRldmZuLCAmY2UpID09
IDApIHsNCiAgICAgICAgIGlzX2ZwZF9zZXQgPSBjZS5sbyAmIFZURF9DT05URVhUX0VOVFJZX0ZQ
RDsNCi0gICAgICAgIGlmICghaXNfZnBkX3NldCAmJiBzLT5yb290X3NjYWxhYmxlKSB7DQorICAg
ICAgICBpZiAoIWlzX2ZwZF9zZXQgJiYgcy0+cm9vdF9zY2FsYWJsZSAmJiB2dGRfYXMtPnBhc2lk
ICE9IFBDSV9OT19QQVNJRCkgew0KICAgICAgICAgICAgIHZ0ZF9jZV9nZXRfcGFzaWRfZnBkKHMs
ICZjZSwgJmlzX2ZwZF9zZXQsIHZ0ZF9hcy0+cGFzaWQpOw0KICAgICAgICAgfQ0KICAgICB9DQpA
QCAtNjA0MSw2ICs2MDM5LDc1IEBAIHN0YXRpYyBJT01NVU1lbW9yeVJlZ2lvbiAqdnRkX2dldF9t
ZW1vcnlfcmVnaW9uX3Bhc2lkKFBDSUJ1cyAqYnVzLA0KICAgICByZXR1cm4gJnZ0ZF9hcy0+aW9t
bXU7DQogfQ0KIA0KK3N0YXRpYyBJT01NVVRMQkVudHJ5IHZ0ZF9pb21tdV9hdHNfZG9fdHJhbnNs
YXRlKElPTU1VTWVtb3J5UmVnaW9uICppb21tdSwNCisgICAgICAgICAgICAgICAgICAgICAgICAg
ICAgICAgICAgICAgICAgICAgICAgICBod2FkZHIgYWRkciwNCisgICAgICAgICAgICAgICAgICAg
ICAgICAgICAgICAgICAgICAgICAgICAgICAgICBJT01NVUFjY2Vzc0ZsYWdzIGZsYWdzLA0KKyAg
ICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgIGludCBpb21tdV9p
ZHgpDQorew0KKyAgICBJT01NVVRMQkVudHJ5IGVudHJ5Ow0KKyAgICBWVERBZGRyZXNzU3BhY2Ug
KnZ0ZF9hcyA9IGNvbnRhaW5lcl9vZihpb21tdSwgVlREQWRkcmVzc1NwYWNlLCBpb21tdSk7DQor
DQorICAgIGlmICh2dGRfaXNfaW50ZXJydXB0X2FkZHIoYWRkcikpIHsNCisgICAgICAgIHZ0ZF9y
ZXBvcnRfaXJfaWxsZWdhbF9hY2Nlc3ModnRkX2FzLCBhZGRyLCBmbGFncyAmIElPTU1VX1dPKTsN
CisgICAgICAgIGVudHJ5LmlvdmEgPSAwOw0KKyAgICAgICAgZW50cnkudHJhbnNsYXRlZF9hZGRy
ID0gMDsNCisgICAgICAgIGVudHJ5LmFkZHJfbWFzayA9IH5WVERfUEFHRV9NQVNLXzRLOw0KKyAg
ICAgICAgZW50cnkucGVybSA9IElPTU1VX05PTkU7DQorICAgICAgICBlbnRyeS5wYXNpZCA9IFBD
SV9OT19QQVNJRDsNCisgICAgfSBlbHNlIHsNCisgICAgICAgIGVudHJ5ID0gdnRkX2lvbW11X3Ry
YW5zbGF0ZShpb21tdSwgYWRkciwgZmxhZ3MsIGlvbW11X2lkeCk7DQorICAgIH0NCisgICAgcmV0
dXJuIGVudHJ5Ow0KK30NCisNCitzdGF0aWMgc3NpemVfdCB2dGRfaW9tbXVfYXRzX3JlcXVlc3Rf
dHJhbnNsYXRpb24oSU9NTVVNZW1vcnlSZWdpb24gKmlvbW11LA0KKyAgICAgICAgICAgICAgICAg
ICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICBib29sIHByaXZfcmVxLCBib29sIGV4ZWNf
cmVxLA0KKyAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICBo
d2FkZHIgYWRkciwgc2l6ZV90IGxlbmd0aCwNCisgICAgICAgICAgICAgICAgICAgICAgICAgICAg
ICAgICAgICAgICAgICAgICAgICAgYm9vbCBub193cml0ZSwNCisgICAgICAgICAgICAgICAgICAg
ICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgSU9NTVVUTEJFbnRyeSAqcmVzdWx0LA0KKyAg
ICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICBzaXplX3QgcmVz
dWx0X2xlbmd0aCwNCisgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAg
ICAgICAgdWludDMyX3QgKmVycl9jb3VudCkNCit7DQorICAgIElPTU1VQWNjZXNzRmxhZ3MgZmxh
Z3MgPSBJT01NVV9BQ0NFU1NfRkxBR19GVUxMKHRydWUsICFub193cml0ZSwgZXhlY19yZXEsDQor
ICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgIHByaXZf
cmVxLCBmYWxzZSwgZmFsc2UpOw0KKyAgICBzc2l6ZV90IHJlc19pbmRleCA9IDA7DQorICAgIGh3
YWRkciB0YXJnZXRfYWRkcmVzcyA9IGFkZHIgKyBsZW5ndGg7DQorICAgIElPTU1VVExCRW50cnkg
ZW50cnk7DQorDQorICAgICplcnJfY291bnQgPSAwOw0KKw0KKyAgICB3aGlsZSAoKGFkZHIgPCB0
YXJnZXRfYWRkcmVzcykgJiYgKHJlc19pbmRleCA8IHJlc3VsdF9sZW5ndGgpKSB7DQorICAgICAg
ICBlbnRyeSA9IHZ0ZF9pb21tdV9hdHNfZG9fdHJhbnNsYXRlKGlvbW11LCBhZGRyLCBmbGFncywg
MCk7DQorICAgICAgICBpZiAoIUlPTU1VX1RMQl9FTlRSWV9UUkFOU0xBVElPTl9FUlJPUigmZW50
cnkpKSB7IC8qIFRyYW5zbGF0aW9uIGRvbmUgKi8NCisgICAgICAgICAgICBpZiAobm9fd3JpdGUp
IHsNCisgICAgICAgICAgICAgICAgLyogVGhlIGRldmljZSBzaG91bGQgbm90IHVzZSB0aGlzIGVu
dHJ5IGZvciBhIHdyaXRlIGFjY2VzcyAqLw0KKyAgICAgICAgICAgICAgICBlbnRyeS5wZXJtICY9
IH5JT01NVV9XTzsNCisgICAgICAgICAgICB9DQorICAgICAgICAgICAgLyoNCisgICAgICAgICAg
ICAgKiA0LjEuMiA6IEdsb2JhbCBNYXBwaW5nIChHKSA6IFJlbWFwcGluZyBoYXJkd2FyZSBwcm92
aWRlcyBhIHZhbHVlDQorICAgICAgICAgICAgICogb2YgMCBpbiB0aGlzIGZpZWxkDQorICAgICAg
ICAgICAgICovDQorICAgICAgICAgICAgZW50cnkucGVybSAmPSB+SU9NTVVfR0xPQkFMOw0KKyAg
ICAgICAgfSBlbHNlIHsNCisgICAgICAgICAgICAqZXJyX2NvdW50ICs9IDE7DQorICAgICAgICB9
DQorICAgICAgICByZXN1bHRbcmVzX2luZGV4XSA9IGVudHJ5Ow0KKyAgICAgICAgcmVzX2luZGV4
ICs9IDE7DQorICAgICAgICBhZGRyID0gKGFkZHIgJiAofmVudHJ5LmFkZHJfbWFzaykpICsgKGVu
dHJ5LmFkZHJfbWFzayArIDEpOw0KKyAgICB9DQorDQorICAgIC8qIEJ1ZmZlciB0b28gc21hbGwg
Ki8NCisgICAgaWYgKGFkZHIgPCB0YXJnZXRfYWRkcmVzcykgew0KKyAgICAgICAgcmV0dXJuIC1F
Tk9NRU07DQorICAgIH0NCisgICAgcmV0dXJuIHJlc19pbmRleDsNCit9DQorDQorc3RhdGljIHVp
bnQ2NF90IHZ0ZF9nZXRfbWluX3BhZ2Vfc2l6ZShJT01NVU1lbW9yeVJlZ2lvbiAqaW9tbXUpDQor
ew0KKyAgICByZXR1cm4gVlREX1BBR0VfU0laRTsNCit9DQorDQogc3RhdGljIFBDSUlPTU1VT3Bz
IHZ0ZF9pb21tdV9vcHMgPSB7DQogICAgIC5nZXRfYWRkcmVzc19zcGFjZSA9IHZ0ZF9ob3N0X2Rt
YV9pb21tdSwNCiAgICAgLmdldF9hZGRyZXNzX3NwYWNlX3Bhc2lkID0gdnRkX2hvc3RfZG1hX2lv
bW11X3Bhc2lkLA0KQEAgLTYyNDYsNiArNjMxMyw4IEBAIHN0YXRpYyB2b2lkIHZ0ZF9pb21tdV9t
ZW1vcnlfcmVnaW9uX2NsYXNzX2luaXQoT2JqZWN0Q2xhc3MgKmtsYXNzLA0KICAgICBpbXJjLT50
cmFuc2xhdGUgPSB2dGRfaW9tbXVfdHJhbnNsYXRlOw0KICAgICBpbXJjLT5ub3RpZnlfZmxhZ19j
aGFuZ2VkID0gdnRkX2lvbW11X25vdGlmeV9mbGFnX2NoYW5nZWQ7DQogICAgIGltcmMtPnJlcGxh
eSA9IHZ0ZF9pb21tdV9yZXBsYXk7DQorICAgIGltcmMtPmlvbW11X2F0c19yZXF1ZXN0X3RyYW5z
bGF0aW9uID0gdnRkX2lvbW11X2F0c19yZXF1ZXN0X3RyYW5zbGF0aW9uOw0KKyAgICBpbXJjLT5n
ZXRfbWluX3BhZ2Vfc2l6ZSA9IHZ0ZF9nZXRfbWluX3BhZ2Vfc2l6ZTsNCiB9DQogDQogc3RhdGlj
IGNvbnN0IFR5cGVJbmZvIHZ0ZF9pb21tdV9tZW1vcnlfcmVnaW9uX2luZm8gPSB7DQpkaWZmIC0t
Z2l0IGEvaHcvaTM4Ni9pbnRlbF9pb21tdV9pbnRlcm5hbC5oIGIvaHcvaTM4Ni9pbnRlbF9pb21t
dV9pbnRlcm5hbC5oDQppbmRleCAxMTdkYzk2ZDIyLi5kNDgzMTUyMmVkIDEwMDY0NA0KLS0tIGEv
aHcvaTM4Ni9pbnRlbF9pb21tdV9pbnRlcm5hbC5oDQorKysgYi9ody9pMzg2L2ludGVsX2lvbW11
X2ludGVybmFsLmgNCkBAIC0xOTQsNiArMTk0LDcgQEANCiAjZGVmaW5lIFZURF9FQ0FQX01ITVYg
ICAgICAgICAgICAgICAoMTVVTEwgPDwgMjApDQogI2RlZmluZSBWVERfRUNBUF9ORVNUICAgICAg
ICAgICAgICAgKDFVTEwgPDwgMjYpDQogI2RlZmluZSBWVERfRUNBUF9TUlMgICAgICAgICAgICAg
ICAgKDFVTEwgPDwgMzEpDQorI2RlZmluZSBWVERfRUNBUF9OV0ZTICAgICAgICAgICAgICAgKDFV
TEwgPDwgMzMpDQogI2RlZmluZSBWVERfRUNBUF9QU1MgICAgICAgICAgICAgICAgKDE5VUxMIDw8
IDM1KQ0KICNkZWZpbmUgVlREX0VDQVBfUEFTSUQgICAgICAgICAgICAgICgxVUxMIDw8IDQwKQ0K
ICNkZWZpbmUgVlREX0VDQVBfU01UUyAgICAgICAgICAgICAgICgxVUxMIDw8IDQzKQ0KLS0gDQoy
LjQ1LjI=

