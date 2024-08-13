Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 34599C52D7B
	for <qemu-devel@archiver.kernel.org>; Tue, 13 Aug 2024 07:14:30 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sdlir-0006ss-KS; Tue, 13 Aug 2024 03:13:37 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <clement.mathieu--drif@eviden.com>)
 id 1sdlip-0006pv-JR
 for qemu-devel@nongnu.org; Tue, 13 Aug 2024 03:13:35 -0400
Received: from smarthost4.eviden.com ([80.78.11.85])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <clement.mathieu--drif@eviden.com>)
 id 1sdlij-0003gi-BX
 for qemu-devel@nongnu.org; Tue, 13 Aug 2024 03:13:35 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=eviden.com; i=@eviden.com; q=dns/txt; s=mail;
 t=1723533209; x=1755069209;
 h=from:to:cc:subject:date:message-id:references:
 in-reply-to:content-id:content-transfer-encoding: mime-version;
 bh=4GOwmMEiUT9ITsEE7Ki40xROJeei8T6lvBNXZcM2lxo=;
 b=nt+YyOmhMdEB23Hn+/6WvWaPEeUS1VsFI6rjWyXtDUpdquFskjseesfA
 N5UUcLz+q3FZzZ6TJ1IcywRgyk/2Ct6mNk4QwE8wLXe/MDo17KkzHX2zD
 BEvWDKFrAp57oqGcr+DwJ4gSNwVlakk8Ox0IvEiu6Qu6UVlDs4wSzcdIK
 +Ve6XgCGKtxSSREYqebsD3XfScQdKm8gC8fq5rZlEMVdw8hGIk2sEutkP
 7eX0eqHzlyBa+cPftubCgJ/9hTLVW8dHKR7fTQEhnyTQSPPVaq/znCGSt
 dhDPlNdwIihbjGXqSz4Dxp6bHRUYMAgTxyLE8P4hJwBTnVwJp/FNnirm/ g==;
X-IronPort-AV: E=Sophos;i="6.09,285,1716242400"; d="scan'208";a="18467148"
X-MGA-submission: =?us-ascii?q?MDFFx0+98Mt2qKDo09kyceemHlWcamovpjYKKn?=
 =?us-ascii?q?p0+9xAsXlLKdlD4JI64GWlMSpalEwDZlc6oRGxA5VteIodPm+B2RtZpj?=
 =?us-ascii?q?a66T1hIT/gGqoLNBnTez641n5majb6OSL1SG2+SxbBRGaS4juP79Iybk?=
 =?us-ascii?q?EFgUEOWcI2aC+Oo4PUWORCIQ=3D=3D?=
Received: from mail-am0eur02lp2234.outbound.protection.outlook.com (HELO
 EUR02-AM0-obe.outbound.protection.outlook.com) ([104.47.11.234])
 by smarthost4.eviden.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 13 Aug 2024 09:13:25 +0200
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=PzldbBhsSu4XoW9IvdsEt8XZ3T+Ebrq6lhqcSXHJbSsnDsNEqLTGYJSh8y3nvh5sN8efqR0YVkzXZuhvkySKW0CgoEgmCk7sCppB0L+O7z7dGaWklanfTKGE7M2I86WRKG2kSNlsCgYgPwlIPwnSNX0EOV4JUD32dKvEL5W/Cq8Yp3OIgHgqrVjIOWZwiHX5BdcI5MOPf+WjHiQieLYfz3YNpLANKcPJot9Lv8AkFYCcgdSuzA+vX18oPusPC1J1a7glnF7isZUlYK33XBf9+kkcbsyFb3MCNazcU7Rk5yg4QO+OfK87tUl0IVzC53qcKn6cDx0KX27sbtDERWRBXQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=4GOwmMEiUT9ITsEE7Ki40xROJeei8T6lvBNXZcM2lxo=;
 b=ctMW2pqC1BqrE2FYNf50rL4MMb/Ezd8/mgE6oNVnnslt/QRpFMTPNTyzJBc/lbaBXE4enY156d5//RORaepBNu1yHoL+0zynZQdRRJHxQztni1mtq/dJagqu6g/jNt3oBncHAZDKfzTgmxK8VSBSKEXEo3XFboNw7v6pdyV+/WpIuACsKstJCpkf0N1SJpVRneg2m8Wg/veqxTCh3RqWUhHH3SMGsKiQxJ1+rEjgsftmOGTvYrgx9i+ycQPOXPP3IGEfU5QiWa+Tf29N+QD3Ton9ipimn1HIUMKP9Edu1JBy8/GKDjdTd/ptSDGKWoYBLWrOL0OQwD1RulSAUnVR+w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=eviden.com; dmarc=pass action=none header.from=eviden.com;
 dkim=pass header.d=eviden.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Eviden.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=4GOwmMEiUT9ITsEE7Ki40xROJeei8T6lvBNXZcM2lxo=;
 b=AzDqFYllKxo0zsrujX7m6nVdPJbGQFCl+T6LDR/9zLp/24TCSq0u+yXRCcqEnpkFeeKiV4T/NA5Ehnq2n4NBmAMM11oX3ykhobAQ4XBp/GIapxvbwyJCaMTOJzsr+lE9BoDNH0rKFWB1HZgCGvLfz1fMbAI5ji19PXwhmoMRkdNL32c6G8/eSqX63D9Ss2kWFUsGfupGpzPmKi1JfZWW4cV+GA1z/0c8DrvcUMocpRISb3n93TWEj5bx8+lTYfGzG9Fzn95JE1NoJqDenrMoYFiyx7cxC0+XS7+jbN88zRDng3M3hPNLF/o8Ks3PPc6BiXI9R8CFJhzjpGe1PoYJPg==
Received: from AM8PR07MB7602.eurprd07.prod.outlook.com (2603:10a6:20b:24b::7)
 by AM8PR07MB7396.eurprd07.prod.outlook.com (2603:10a6:20b:24d::23)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7849.22; Tue, 13 Aug
 2024 07:13:24 +0000
Received: from AM8PR07MB7602.eurprd07.prod.outlook.com
 ([fe80::fbd7:ca71:b636:6f9d]) by AM8PR07MB7602.eurprd07.prod.outlook.com
 ([fe80::fbd7:ca71:b636:6f9d%7]) with mapi id 15.20.7849.021; Tue, 13 Aug 2024
 07:13:24 +0000
From: CLEMENT MATHIEU--DRIF <clement.mathieu--drif@eviden.com>
To: "Duan, Zhenzhong" <zhenzhong.duan@intel.com>, "qemu-devel@nongnu.org"
 <qemu-devel@nongnu.org>
CC: "alex.williamson@redhat.com" <alex.williamson@redhat.com>,
 "clg@redhat.com" <clg@redhat.com>, "eric.auger@redhat.com"
 <eric.auger@redhat.com>, "mst@redhat.com" <mst@redhat.com>,
 "peterx@redhat.com" <peterx@redhat.com>, "jasowang@redhat.com"
 <jasowang@redhat.com>, "jgg@nvidia.com" <jgg@nvidia.com>,
 "nicolinc@nvidia.com" <nicolinc@nvidia.com>, "joao.m.martins@oracle.com"
 <joao.m.martins@oracle.com>, "Tian, Kevin" <kevin.tian@intel.com>, "Liu, Yi
 L" <yi.l.liu@intel.com>, "Peng, Chao P" <chao.p.peng@intel.com>, Paolo
 Bonzini <pbonzini@redhat.com>, Richard Henderson
 <richard.henderson@linaro.org>, Eduardo Habkost <eduardo@habkost.net>, Marcel
 Apfelbaum <marcel.apfelbaum@gmail.com>
Subject: Re: [PATCH v2 04/17] intel_iommu: Flush stage-2 cache in
 PASID-selective PASID-based iotlb invalidation
Thread-Topic: [PATCH v2 04/17] intel_iommu: Flush stage-2 cache in
 PASID-selective PASID-based iotlb invalidation
Thread-Index: AQHa5wD3t0aSWs4KZku3dYcmr1ZjXrIZx6uAgAOKqACAACXlAIAHBk8AgABT+AA=
Date: Tue, 13 Aug 2024 07:13:24 +0000
Message-ID: <92631633-27ac-4f46-adb9-e0cca90321b6@eviden.com>
References: <20240805062727.2307552-1-zhenzhong.duan@intel.com>
 <20240805062727.2307552-5-zhenzhong.duan@intel.com>
 <d245008c-ef6e-4a58-bcbc-869aa4901cf4@eviden.com>
 <ecfaec89-bdfd-0512-b9e4-d2dc237a9c56@intel.com>
 <1b46fc72-7e51-4585-865e-1d32b2ae6997@eviden.com>
 <SJ0PR11MB6744A4015D28C6BFAD241B2792862@SJ0PR11MB6744.namprd11.prod.outlook.com>
In-Reply-To: <SJ0PR11MB6744A4015D28C6BFAD241B2792862@SJ0PR11MB6744.namprd11.prod.outlook.com>
Accept-Language: en-GB, fr-FR, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=eviden.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: AM8PR07MB7602:EE_|AM8PR07MB7396:EE_
x-ms-office365-filtering-correlation-id: 34f9a3c9-9a56-481c-834c-08dcbb676bf1
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
 ARA:13230040|7416014|376014|366016|1800799024|38070700018; 
x-microsoft-antispam-message-info: =?utf-8?B?aUtHVnZkUFY3ZDN3UGFVWThhRXBESjZlNUZBT1JhOEtjWE9qdzNvUkQ0Sjg5?=
 =?utf-8?B?UENzd1AxVzI4cnpyQmQzaVp0ZmxJUmxGOVBSeTIyTk9pTVB6cTNCd2hRL1kz?=
 =?utf-8?B?aURyYXFDanNNbUtSMGJjMWthdFQwWFVRY3BRRDRiU3BhYUZ5ZVpoejBPck5p?=
 =?utf-8?B?dEV2SS90YkRwYzd3eXZkb3pvRHdtZWRRd1A0Zlh0VFQwZENCVmRUb21sRmxH?=
 =?utf-8?B?MTFpbVBWYVJhVGhUdE1Oc1RVUFROM0JUaHJTNWd4RFZlbTVZNVVYZ2MvT1ly?=
 =?utf-8?B?bTNQTVNCTlU3MDErSzVwMmxLUitKWU13MjR5M0pKazN6Q0VZcFl4NmVKNG5M?=
 =?utf-8?B?ajhJNEV3UE9VZDVIMlNGV1NqSDdFbWZvbzN0S2RKQlhXUkVodFIwWHl0emJp?=
 =?utf-8?B?TEVoSzBiYi9reUxpb0J6VituSWQ1MHZjR3RxcUI0b1JwOUdwanM3Z1hHem11?=
 =?utf-8?B?Qnk1azUyV0FYY3JwUUZQUmZsREtKZllKZzVTUm16d3hwSUMvTG5ic0ZZaHha?=
 =?utf-8?B?OVpNVDFCN095djU1RmMyK0dXM0RmRnFlTy9Pak40aEdGV1V0eTNKQ3IzZnFP?=
 =?utf-8?B?Y3BoRGd1dUp2Y0J4cmZLc3Y3M1pISGRsK2MxelJkb09ZK0FWaUtFYW9sOG9y?=
 =?utf-8?B?RndYMzVkMnhJWXM3dEVrL3JtVG54a0xlVzBnZjZrSVRQbUZWdnp4QmNjTFFo?=
 =?utf-8?B?MEs1SDhIYXpTRkkyejFyTFJHMVlicTVVTDYyd080ZDg1UmtsSE50M3Jmc05v?=
 =?utf-8?B?TkpnK1FQL3hweWh2cFpCcUdMVHRiYkFiYk16Ui92bUdzS0picWxGVUIwZ0Qy?=
 =?utf-8?B?bDlSU3N1ZTR6L1NHeG1PZ0k4Q2dBVTlLVitpNmJQUjZBcGs5MlFNaVRMRTZM?=
 =?utf-8?B?aW1hRzVPSk5LNnUxTU9ML01Xcnl0VVJkTnBKL0c0TzZtbVZVYmdUMnBJNUll?=
 =?utf-8?B?RVVkdy91YnhpNFBwdHhSRTdMdW5RU1pVSmFSSSsySVh1akgwN3RVMGFSS21t?=
 =?utf-8?B?QmNDWFJJTWxKVnA4eWtPSW90bjRlNStMMTFoWVRUMTdvTTFLcDdBeFc5SzZt?=
 =?utf-8?B?Sks5ZGRjZ05GVTh6QmVnWVpkb3RyTDFkTXB4bGYva2Fldm5FdUZra0RZOWRZ?=
 =?utf-8?B?WnFEU3dpa2p1b0wvNERXVzFwVmgwdENvejRjRXdZM0FYVk1nQjJBZVR1VU1G?=
 =?utf-8?B?Qk9ER0FNZVlGazlJalJlR0tmSy8rcVc5NGZ3ZFZNdFZMaHFQRWQrb0xNWVp6?=
 =?utf-8?B?c1F0WXd3TzBPN1F1eVc3ckg3L3ZvQkNlOGx1eFhMczZqU1djYTZWOERLbzMy?=
 =?utf-8?B?N1hZd2tYRnQ1YUhJQ1F4UVlCS0VwRzZtMU5Rb3FuZUpzZW5ObFErQnpSS0Jv?=
 =?utf-8?B?aGNJYU1jWlpCREcwQ1NhSHMyZlZBVFgxbENsZ3JOUTNPcWtKVTMybGpIdC9U?=
 =?utf-8?B?SmxiK2M1NW5TaUlKQVJ5RUxOc1NVY3VDRXFOT05DNWltT25qMW1HQm55bDZ5?=
 =?utf-8?B?eWJCdzZ2ayszY2tGRWRLamZQVnM4RWx3ck1Rcm5TLzc2YmZBRTYzb0diaTlh?=
 =?utf-8?B?RVBNOFQ1Z0ljOVF5OUUzZVBCWkJyeE00cDNWSW8zUVowQ2FpTnRSZDdPY0tJ?=
 =?utf-8?B?RzA2ZlU2QmRvMUpoVnZlRzl1OUEzS3F5QVo4UnhTSStlS0VpUXN3L2ZmcWZV?=
 =?utf-8?B?eHcvMmtLbC9XWDcxbTl5djRmeWRqN2V5Z0k4Tk1IUkx2N3Z1OVZKMkVMWmRy?=
 =?utf-8?B?YkQ5SzROUW9aWXltcnk3ZnBQcWxHR3g4bDlNZ2FZclg0bEorZzBlVGV4Wk1o?=
 =?utf-8?Q?Zo+PTwsZ0A6tJ+eLwNjNdjxMPVF0GyPInEAw4=3D?=
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:AM8PR07MB7602.eurprd07.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(7416014)(376014)(366016)(1800799024)(38070700018); DIR:OUT;
 SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?b0pyeVU2WS9kaHRIeDB1S2RSSWd1Y0VwQW4yNWhQQjdvVWhveXM0TS9BZGhs?=
 =?utf-8?B?Z1RxRS9lMnVyNElXU3ZQQktsc256MlAvbmpzVGtLZzhoOVhOSlFsSzNGQWNv?=
 =?utf-8?B?S1FadXN4Q3JtdGpwbVdDcjhHYVNxK2I0QkRPWEZzenhtN1hoQlNKNHdYMy96?=
 =?utf-8?B?ZUhvd21INWVmMFBqdy9QMlpNODBWZVJvelc5Z2RDSWNIL0tQb095dmFJQjRj?=
 =?utf-8?B?cEU5SU1BVFNWZWZiMno2cnAxYVgzN2pJOFp4eXM1ekluMmlvT3M2NktRd3U3?=
 =?utf-8?B?ajNBTThMdXlGMGlyTHRZTDl1QklvWUF3RXVTWGJZa29TZUNSRU9WYzg4aWxp?=
 =?utf-8?B?RUZjbis3NkpBcmNTdHN4VmQwTU5Tc0VvMDFicDdDTW1IbVpZMldpYjNBQ3JD?=
 =?utf-8?B?S1pDNmt6U0RSYm11ak1OOFhUa1VUemJ5SlU4d0VhbFJ6TXRmajJjYTEyTXJB?=
 =?utf-8?B?S1RqZlRjTEkxb2JUWm9hVmt6RzM5NytFYzFDMVlYUEtYVlI1Zi81bW1kbmVI?=
 =?utf-8?B?c251aDV5cXdnYXRZdkZOeC9UbWV6dllzQ2VRT2ZxUGFwbUdORyt4ZzdPYVow?=
 =?utf-8?B?SGV4U1lGQ1VLVktGeHdqNE1WS0x5ZU5KUVdoanRwQ1NpN1hLQ09Qbzc5N0Rs?=
 =?utf-8?B?NFRrY2MvcTRsUldnak5xSHdObXZCSW95dG1rQ0FLRjN5MytCSFVMb2pmVit0?=
 =?utf-8?B?c2VxSVRld2lMNUpGenhnVWV2aVlzWjJ2UmpxQmJ4OHJ3NDhPVzlqcFNYLy9Y?=
 =?utf-8?B?ZCtYSllqTWxRNHVHSHV4OWtjQjA2dnpYR3BxMGlPbnBvcHNNNGE5VXNzNEpy?=
 =?utf-8?B?L2pJOER3Wm0zTHdNN0J6WStzZit4NkRMc1hpaFlKa0kyS2p3OEJIdnUzdi9O?=
 =?utf-8?B?S3h4R1o5c0lMM2ZFYUI3T3hHTG9ZUUxiNzc2VkprcnF0NFlETHUrN0JVK0NS?=
 =?utf-8?B?SGRZOHA1UzFFR2tyaFZlSnhtdEhCWXFNUFFLbVlPbVhaelJPWnZqcS9iVGpt?=
 =?utf-8?B?cEoxZlpFd0sydzdCYnAzZlJLajg4VU15cUlpNnZ4dEp0QXNoR0ZaVm5DdlVs?=
 =?utf-8?B?blVmbGRQdVdObTU0RWFObmdIeWFDYlYzKzBJbGpKWHJKdmVCczBYSExCb0o2?=
 =?utf-8?B?bVBGNEloL2JKNUVmei9XTVkydERyMEg3TXUyMkdaNDlTbUFQZVdiNmZDVE53?=
 =?utf-8?B?WlpuTXdteDRub1k3cFNnRzhkcHFFamNBWERtSnF6bjlDUEk1cXNsQ2pIaDNz?=
 =?utf-8?B?by9UTG4vQlczN3lBRDRtT0dwNFFHemUrSncydkZmdjRMcmVDOGhJdGZYY3E1?=
 =?utf-8?B?b0k2dTI4M2twcG0yaHl1Z1J1bnE0V3FZOFlPenBVeFB6RTZjWkk0bFZMLzY1?=
 =?utf-8?B?cWFmaDRmZCtCU25QaEVlZ1hQQXljQmJ1M3U3cldpNzBmbytUY0hCeU92OVRC?=
 =?utf-8?B?bGYvR2M3YWsweWlFdlBNc2U0bVd0UTVWM09zemorTWV5MmxqeERjWmFmUi9W?=
 =?utf-8?B?SHUya1JLRjV3ME5hRDFnNWdQOUdLcjBhZVo5em9tVmEvaitLb28yajdiVjg1?=
 =?utf-8?B?UG1vMU1ZdHg5NnUyeWd2SUZOSlFHODJ1NVBBZ0RLTG9YaTlDTEtlUytvMXRE?=
 =?utf-8?B?VkY1cVJBU1F2UnRLdm85blI2MW5TdGp2Tm9MMzZ3ek9YSmM0V1FydjY5b2pT?=
 =?utf-8?B?OFI2ZDI4Z2E2NVV0WG9NUzk3bFVPelM5WGdNOEtmamZqQzZ4WldmR0VrNE5D?=
 =?utf-8?B?bHVGbG5CTnFiRG95YnlXZzdsMEh1c0FDUFNaTE1oT3dtVmEyS2FVNFVNYkl6?=
 =?utf-8?B?V2JxeUxuc1pybE5veVNlN29mRGFFeE5oSVpwWkI0ZnROSzFXeWtkZG5XZDl3?=
 =?utf-8?B?dGpJbk83bzNaWktWZzNhTEJrM1dzMEtjUVhGTFd1MDh4T09qS3dWZldBUDVp?=
 =?utf-8?B?U2RoWC9EQ0p5SExaM3Z1TDg5MEsvczNYRnl1TTNmb1Y4OWEyL09hY21FbC9y?=
 =?utf-8?B?Z3p4MlA0eFBwWnAzRTNTT0R2MkdTaWZRblBMeVBKeHl4MVFReWZVQXVKUnhr?=
 =?utf-8?B?blJ4K0tJN3RvT1BYQVRGMTlWYW12c1FqT2J5VzZseVlReXU3aURUaVZkYzVm?=
 =?utf-8?B?eGI5UFFENWxXK3FvaWNLb21vRityT2FlTnRmV3JhZUUxUWxaczhBeUpmMFNp?=
 =?utf-8?Q?tjW+t9IMsuRfXqjBrNhds/A=3D?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <99BD6D1BC7DC0649B7881E7F12E1C448@eurprd07.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: eviden.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: AM8PR07MB7602.eurprd07.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 34f9a3c9-9a56-481c-834c-08dcbb676bf1
X-MS-Exchange-CrossTenant-originalarrivaltime: 13 Aug 2024 07:13:24.6738 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 7d1c7785-2d8a-437d-b842-1ed5d8fbe00a
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: HwSLbNqNp5s046MIxPgaMmNgQm2GFi7nhsXVLgAvqH43OTROgQhEilsF1Z3T1iwxDLanqIu6MdgzxzdIEW+Q8qf4hrqG/mFmOoUh5zhIUlVRC04BoKEDNtUX4RGZJMMK
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM8PR07MB7396
Received-SPF: pass client-ip=80.78.11.85;
 envelope-from=clement.mathieu--drif@eviden.com; helo=smarthost4.eviden.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001, RCVD_IN_VALIDITY_SAFE_BLOCKED=0.001,
 SPF_HELO_PASS=-0.001, T_SCC_BODY_TEXT_LINE=-0.01,
 T_SPF_TEMPERROR=0.01 autolearn=ham autolearn_force=no
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

DQoNCk9uIDEzLzA4LzIwMjQgMDQ6MTIsIER1YW4sIFpoZW56aG9uZyB3cm90ZToNCj4gQ2F1dGlv
bjogRXh0ZXJuYWwgZW1haWwuIERvIG5vdCBvcGVuIGF0dGFjaG1lbnRzIG9yIGNsaWNrIGxpbmtz
LCB1bmxlc3MgdGhpcyBlbWFpbCBjb21lcyBmcm9tIGEga25vd24gc2VuZGVyIGFuZCB5b3Uga25v
dyB0aGUgY29udGVudCBpcyBzYWZlLg0KPg0KPg0KPj4gLS0tLS1PcmlnaW5hbCBNZXNzYWdlLS0t
LS0NCj4+IEZyb206IENMRU1FTlQgTUFUSElFVS0tRFJJRiA8Y2xlbWVudC5tYXRoaWV1LS1kcmlm
QGV2aWRlbi5jb20+DQo+PiBTdWJqZWN0OiBSZTogW1BBVENIIHYyIDA0LzE3XSBpbnRlbF9pb21t
dTogRmx1c2ggc3RhZ2UtMiBjYWNoZSBpbiBQQVNJRC0NCj4+IHNlbGVjdGl2ZSBQQVNJRC1iYXNl
ZCBpb3RsYiBpbnZhbGlkYXRpb24NCj4+DQo+Pg0KPj4NCj4+IE9uIDA4LzA4LzIwMjQgMTQ6NDAs
IER1YW4sIFpoZW56aG9uZyB3cm90ZToNCj4+PiBDYXV0aW9uOiBFeHRlcm5hbCBlbWFpbC4gRG8g
bm90IG9wZW4gYXR0YWNobWVudHMgb3IgY2xpY2sgbGlua3MsDQo+Pj4gdW5sZXNzIHRoaXMgZW1h
aWwgY29tZXMgZnJvbSBhIGtub3duIHNlbmRlciBhbmQgeW91IGtub3cgdGhlIGNvbnRlbnQNCj4+
PiBpcyBzYWZlLg0KPj4+DQo+Pj4NCj4+PiBPbiA4LzYvMjAyNCAyOjM1IFBNLCBDTEVNRU5UIE1B
VEhJRVUtLURSSUYgd3JvdGU6DQo+Pj4+IE9uIDA1LzA4LzIwMjQgMDg6MjcsIFpoZW56aG9uZyBE
dWFuIHdyb3RlOg0KPj4+Pj4gQ2F1dGlvbjogRXh0ZXJuYWwgZW1haWwuIERvIG5vdCBvcGVuIGF0
dGFjaG1lbnRzIG9yIGNsaWNrIGxpbmtzLA0KPj4+Pj4gdW5sZXNzIHRoaXMgZW1haWwgY29tZXMg
ZnJvbSBhIGtub3duIHNlbmRlciBhbmQgeW91IGtub3cgdGhlIGNvbnRlbnQNCj4+Pj4+IGlzIHNh
ZmUuDQo+Pj4+Pg0KPj4+Pj4NCj4+Pj4+IFBlciBzcGVjIDYuNS4yLjQsIFBBRElELXNlbGVjdGl2
ZSBQQVNJRC1iYXNlZCBpb3RsYiBpbnZhbGlkYXRpb24gd2lsbA0KPj4+Pj4gZmx1c2ggc3RhZ2Ut
MiBpb3RsYiBlbnRyaWVzIHdpdGggbWF0Y2hpbmcgZG9tYWluIGlkIGFuZCBwYXNpZC4NCj4+Pj4+
DQo+Pj4+PiBXaXRoIHNjYWxhYmxlIG1vZGVybiBtb2RlIGludHJvZHVjZWQsIGd1ZXN0IGNvdWxk
IHNlbmQgUEFTSUQtDQo+PiBzZWxlY3RpdmUNCj4+Pj4+IFBBU0lELWJhc2VkIGlvdGxiIGludmFs
aWRhdGlvbiB0byBmbHVzaCBib3RoIHN0YWdlLTEgYW5kIHN0YWdlLTINCj4+Pj4+IGVudHJpZXMu
DQo+Pj4+Pg0KPj4+Pj4gQnkgdGhpcyBjaGFuY2UsIHJlbW92ZSBvbGQgSU9UTEIgcmVsYXRlZCBk
ZWZpbml0aW9uLg0KPj4+Pj4NCj4+Pj4+IFNpZ25lZC1vZmYtYnk6IFpoZW56aG9uZyBEdWFuIDx6
aGVuemhvbmcuZHVhbkBpbnRlbC5jb20+DQo+Pj4+PiAtLS0NCj4+Pj4+ICAgICBody9pMzg2L2lu
dGVsX2lvbW11X2ludGVybmFsLmggfCAxNCArKystLS0NCj4+Pj4+ICAgICBody9pMzg2L2ludGVs
X2lvbW11LmMgICAgICAgICAgfCA4MQ0KPj4+Pj4gKysrKysrKysrKysrKysrKysrKysrKysrKysr
KysrKysrKw0KPj4+Pj4gICAgIDIgZmlsZXMgY2hhbmdlZCwgOTAgaW5zZXJ0aW9ucygrKSwgNSBk
ZWxldGlvbnMoLSkNCj4+Pj4+DQo+Pj4+PiBkaWZmIC0tZ2l0IGEvaHcvaTM4Ni9pbnRlbF9pb21t
dV9pbnRlcm5hbC5oDQo+Pj4+PiBiL2h3L2kzODYvaW50ZWxfaW9tbXVfaW50ZXJuYWwuaA0KPj4+
Pj4gaW5kZXggOGZhMjdjN2YzYi4uMTllNGVkNTJjYSAxMDA2NDQNCj4+Pj4+IC0tLSBhL2h3L2kz
ODYvaW50ZWxfaW9tbXVfaW50ZXJuYWwuaA0KPj4+Pj4gKysrIGIvaHcvaTM4Ni9pbnRlbF9pb21t
dV9pbnRlcm5hbC5oDQo+Pj4+PiBAQCAtNDAyLDExICs0MDIsNiBAQCB0eXBlZGVmIHVuaW9uIFZU
REludkRlc2MgVlRESW52RGVzYzsNCj4+Pj4+ICAgICAjZGVmaW5lIFZURF9JTlZfREVTQ19JT1RM
Ql9BTSh2YWwpICAgICAgKCh2YWwpICYgMHgzZlVMTCkNCj4+Pj4+ICAgICAjZGVmaW5lIFZURF9J
TlZfREVTQ19JT1RMQl9SU1ZEX0xPIDB4ZmZmZmZmZmYwMDAwZmYwMFVMTA0KPj4+Pj4gICAgICNk
ZWZpbmUgVlREX0lOVl9ERVNDX0lPVExCX1JTVkRfSEkgICAgICAweGY4MFVMTA0KPj4+Pj4gLSNk
ZWZpbmUgVlREX0lOVl9ERVNDX0lPVExCX1BBU0lEX1BBU0lEICAoMlVMTCA8PCA0KQ0KPj4+Pj4g
LSNkZWZpbmUgVlREX0lOVl9ERVNDX0lPVExCX1BBU0lEX1BBR0UgICAoM1VMTCA8PCA0KQ0KPj4+
Pj4gLSNkZWZpbmUgVlREX0lOVl9ERVNDX0lPVExCX1BBU0lEKHZhbCkgICAoKCh2YWwpID4+IDMy
KSAmDQo+Pj4+PiBWVERfUEFTSURfSURfTUFTSykNCj4+Pj4+IC0jZGVmaW5lIFZURF9JTlZfREVT
Q19JT1RMQl9QQVNJRF9SU1ZEX0xPDQo+PiAweGZmZjAwMDAwMDAwMDAxYzBVTEwNCj4+Pj4+IC0j
ZGVmaW5lIFZURF9JTlZfREVTQ19JT1RMQl9QQVNJRF9SU1ZEX0hJICAgICAgMHhmODBVTEwNCj4+
Pj4+DQo+Pj4+PiAgICAgLyogTWFzayBmb3IgRGV2aWNlIElPVExCIEludmFsaWRhdGUgRGVzY3Jp
cHRvciAqLw0KPj4+Pj4gICAgICNkZWZpbmUgVlREX0lOVl9ERVNDX0RFVklDRV9JT1RMQl9BRERS
KHZhbCkgKCh2YWwpICYNCj4+Pj4+IDB4ZmZmZmZmZmZmZmZmZjAwMFVMTCkNCj4+Pj4+IEBAIC00
MzgsNiArNDMzLDE1IEBAIHR5cGVkZWYgdW5pb24gVlRESW52RGVzYyBWVERJbnZEZXNjOw0KPj4+
Pj4gICAgICAgICAgICAgKDB4M2ZmZmY4MDBVTEwgfCB+KFZURF9IQVdfTUFTSyhhdykgfCBWVERf
U0xfSUdOX0NPTSB8DQo+Pj4+PiBWVERfU0xfVE0pKSA6IFwNCj4+Pj4+ICAgICAgICAgICAgICgw
eDNmZmZmODAwVUxMIHwgfihWVERfSEFXX01BU0soYXcpIHwgVlREX1NMX0lHTl9DT00pKQ0KPj4+
Pj4NCj4+Pj4+ICsvKiBNYXNrcyBmb3IgUElPVExCIEludmFsaWRhdGUgRGVzY3JpcHRvciAqLw0K
Pj4+Pj4gKyNkZWZpbmUgVlREX0lOVl9ERVNDX1BJT1RMQl9HICAgICAgICAgICAgICgzVUxMIDw8
IDQpDQo+Pj4+PiArI2RlZmluZSBWVERfSU5WX0RFU0NfUElPVExCX0FMTF9JTl9QQVNJRCAgKDJV
TEwgPDwgNCkNCj4+Pj4+ICsjZGVmaW5lIFZURF9JTlZfREVTQ19QSU9UTEJfUFNJX0lOX1BBU0lE
ICAoM1VMTCA8PCA0KQ0KPj4+Pj4gKyNkZWZpbmUgVlREX0lOVl9ERVNDX1BJT1RMQl9ESUQodmFs
KSAgICAgICgoKHZhbCkgPj4gMTYpICYNCj4+Pj4+IFZURF9ET01BSU5fSURfTUFTSykNCj4+Pj4+
ICsjZGVmaW5lIFZURF9JTlZfREVTQ19QSU9UTEJfUEFTSUQodmFsKSAgICAoKCh2YWwpID4+IDMy
KSAmIDB4ZmZmZmZVTEwpDQo+Pj4+PiArI2RlZmluZSBWVERfSU5WX0RFU0NfUElPVExCX1JTVkRf
VkFMMCAweGZmZjAwMDAwMDAwMGYxYzBVTEwNCj4+Pj4gV2h5IGRpZCB0aGlzIHZhbHVlIGNoYW5n
ZSBzaW5jZSBsYXN0IHBvc3Q/IFRoZSAndHlwZScgZmllbGQgc2hvdWxkDQo+Pj4+IGFsd2F5cyBi
ZSB6ZXJvIGluIHRoaXMgZGVzYw0KPj4+IFllcywgdHlwZVs2OjRdIGFyZSBhbGwgemVybyBmb3Ig
YWxsIGV4aXN0aW5nIGludmFsaWRhdGlvbiB0eXBlLiBCdXQgdGhleQ0KPj4+IGFyZSBub3QgcmVh
bCByZXNlcnZlZCBiaXRzLg0KPj4+DQo+Pj4gU28gSSByZW1vdmVkIHRoZW0gZnJvbSBWVERfSU5W
X0RFU0NfUElPVExCX1JTVkRfVkFMMC4NCj4+IE90aGVyIG1hc2tzIGNvbnNpZGVyIHRoZXNlIHpl
cm9lcyBhcyByZXNlcnZlZC4NCj4+IEkgdGhpbmsgd2Ugc2hvdWxkIGRvIHRoZSBzYW1lLg0KPj4g
Rm9yIGluc3RhbmNlLCBjb250ZXh0IGNhY2hlIGludmFsaWRhdGlvbiBpcyA6ICNkZWZpbmUNCj4+
IFZURF9JTlZfREVTQ19DQ19SU1ZEIDB4ZmZmYzAwMDAwMDAwZmZjMFVMTA0KPiBZZXMsIEknbGwg
bWFrZSBhIHNlcGFyYXRlIHBhdGNoIHRvIGZpeCBpdC4NCk9vcHMsIEkganVzdCBzYXcgeW91ciBw
YXRjaCwgc29ycnkgZm9yIHRoZSBtaXN1bmRlcnN0YW5kaW5nISENCkkgdGhpbmsgd2Ugc2hvdWxk
IGNvbnRpbnVlIHRyZWF0aW5nIHRoZXNlIGJpdHMgYXMgcmVzZXJ2ZWQgYmVjYXVzZSB0aGUgDQpk
ZXNjcmlwdG9yIHR5cGUgZGV0ZWN0aW9uIGNvZGUgb25seSBjaGVja3MgdGhlIDQgTFNCLg0KPg0K
PiBUaGFua3MNCj4gWmhlbnpob25nDQo=

