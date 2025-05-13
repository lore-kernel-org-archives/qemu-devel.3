Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 74BBAC3ABCC
	for <qemu-devel@archiver.kernel.org>; Tue, 13 May 2025 15:49:19 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uErs5-0003gt-3Q; Tue, 13 May 2025 11:48:45 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <bchaney@akamai.com>)
 id 1uErru-0003f2-6j
 for qemu-devel@nongnu.org; Tue, 13 May 2025 11:48:35 -0400
Received: from mx0b-00190b01.pphosted.com ([67.231.157.127])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <bchaney@akamai.com>)
 id 1uErrs-0008Qr-1n
 for qemu-devel@nongnu.org; Tue, 13 May 2025 11:48:33 -0400
Received: from pps.filterd (m0409410.ppops.net [127.0.0.1])
 by m0409410.ppops.net-00190b01. (8.18.1.2/8.18.1.2) with ESMTP id
 54D5DA5V015480; Tue, 13 May 2025 16:48:21 +0100
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=akamai.com; h=cc
 :content-id:content-transfer-encoding:content-type:date:from
 :in-reply-to:message-id:mime-version:references:subject:to; s=
 jan2016.eng; bh=66L+IlFo70NTx0ZZlFBsKIPjyM8w8Qe+trpXcAY5Gh0=; b=
 dqMBAr0dO4pMOXl4jJEmaLT4rFiS2QKvvmxzEYYusDxuDLbLiTUo6jrBfnTAiJgR
 AaLbUBddsSIWT+Xv9Jbd9i+131WFKuCIsm7bgLkXgfB+32VMJntdfR52hZBABjRs
 89N/btgE+3dj4Pt51Ufv3QgWYMs3L1qAz2D7sYwYo8aptyRugYztj07ZtuUgmokj
 fiLhLoC2ioEm3BEtza+pjucMHBV8YrdKLSlLYiZDBhHp8Fl0WmwkQF+dedVoxbJl
 IyZDfQ0J86mTJ/egZdRTNJiE62G8ACY67FNsYk7vtb831Ib+8YO6PsIR4dp0BqeC
 xYx3mZw8IeB9vRUoYKt3sA==
Received: from prod-mail-ppoint7
 (a72-247-45-33.deploy.static.akamaitechnologies.com [72.247.45.33] (may be
 forged))
 by m0409410.ppops.net-00190b01. (PPS) with ESMTPS id 46jhq8x2pa-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Tue, 13 May 2025 16:48:20 +0100 (BST)
Received: from pps.filterd (prod-mail-ppoint7.akamai.com [127.0.0.1])
 by prod-mail-ppoint7.akamai.com (8.18.1.2/8.18.1.2) with ESMTP id
 54DErOci002825; Tue, 13 May 2025 11:48:19 -0400
Received: from email.msg.corp.akamai.com ([172.27.50.201])
 by prod-mail-ppoint7.akamai.com (PPS) with ESMTPS id 46j24xrk02-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Tue, 13 May 2025 11:48:19 -0400
Received: from ustx2ex-exedge3.msg.corp.akamai.com (172.27.50.214) by
 ustx2ex-dag4mb2.msg.corp.akamai.com (172.27.50.201) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.14; Tue, 13 May 2025 08:48:14 -0700
Received: from NAM12-DM6-obe.outbound.protection.outlook.com (72.247.45.132)
 by ustx2ex-exedge3.msg.corp.akamai.com (172.27.50.214) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.14 via Frontend Transport; Tue, 13 May 2025 10:48:14 -0500
Received: from SA0PR17MB4299.namprd17.prod.outlook.com (2603:10b6:806:e2::12)
 by SN7PR17MB6748.namprd17.prod.outlook.com (2603:10b6:806:2e5::14)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8722.28; Tue, 13 May
 2025 15:48:06 +0000
Received: from SA0PR17MB4299.namprd17.prod.outlook.com
 ([fe80::2d2f:3703:1db2:1d95]) by SA0PR17MB4299.namprd17.prod.outlook.com
 ([fe80::2d2f:3703:1db2:1d95%7]) with mapi id 15.20.8722.027; Tue, 13 May 2025
 15:48:06 +0000
From: "Chaney, Ben" <bchaney@akamai.com>
To: Peter Xu <peterx@redhat.com>
CC: "yury-kotov@yandex-team.ru" <yury-kotov@yandex-team.ru>,
 "dgilbert@redhat.com" <dgilbert@redhat.com>, "beata.michalska@linaro.org"
 <beata.michalska@linaro.org>, "richard.henderson@linaro.org"
 <richard.henderson@linaro.org>, "alex.bennee@linaro.org"
 <alex.bennee@linaro.org>, "peter.maydell@linaro.org"
 <peter.maydell@linaro.org>, "junyan.he@intel.com" <junyan.he@intel.com>,
 "stefanha@redhat.com" <stefanha@redhat.com>, "imammedo@redhat.com"
 <imammedo@redhat.com>, "mst@redhat.com" <mst@redhat.com>,
 "qemu-devel@nongnu.org" <qemu-devel@nongnu.org>, "pbonzini@redhat.com"
 <pbonzini@redhat.com>, "david@redhat.com" <david@redhat.com>,
 "philmd@linaro.org" <philmd@linaro.org>, "xiaoguangrong.eric@gmail.com"
 <xiaoguangrong.eric@gmail.com>, "Tottenham, Max" <mtottenh@akamai.com>,
 "Hunt, Joshua" <johunt@akamai.com>, "Glasgall, Anna" <aglasgal@akamai.com>
Subject: Re: live-migration performance regression when using pmem
Thread-Topic: live-migration performance regression when using pmem
Thread-Index: AQHbw1DYBGrB/0pV9U+SV8KgfbE6+LPPVs+AgAEcVwA=
Date: Tue, 13 May 2025 15:48:06 +0000
Message-ID: <777D8A12-8D44-4A67-B767-988C81C60D21@akamai.com>
References: <1385969E-EC2D-4262-9072-29F520D0DF81@akamai.com>
 <aCJC8U_TJXcQcPmk@x1.local>
In-Reply-To: <aCJC8U_TJXcQcPmk@x1.local>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: SA0PR17MB4299:EE_|SN7PR17MB6748:EE_
x-ms-office365-filtering-correlation-id: 8d99818b-be37-439b-df30-08dd92358dc7
x-ld-processed: 514876bd-5965-4b40-b0c8-e336cf72c743,ExtAddr
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
 ARA:13230040|10070799003|366016|1800799024|7416014|376014|38070700018; 
x-microsoft-antispam-message-info: =?utf-8?B?MVVrZjl0UkFZM1BQaU5iZGFuck9UREZrbDA1RWIwMzFYczFaNmlhbDNINFZz?=
 =?utf-8?B?WHRZL2c3QlNtNjM4cU9sTlRSY1ZuWkFGbTNhV0FDV2pkb2dLbldrRkFwUTA2?=
 =?utf-8?B?bG5FRDZUdG91aHlCMmIzWDFlQ1FCYldWa0NXc2lMZjlHT3BhelVtL3BoSzc1?=
 =?utf-8?B?ajNJTlY3eXlQTVBMdndtYjRuSEthVUVNbHdCTWl1U0VCQU5iZ1FpOFV5SU9W?=
 =?utf-8?B?Y1o4V0Z0K290L2laaXo5Vm9kak9kNjA4N01INmg3RUJ6SDJRRWpPaDhIa3hM?=
 =?utf-8?B?ckRSSTB0c1BqeUZEYVp5b0Y0QmVUSk1lcHdFQVc1b3luY3JLRFdmdVBYRlh4?=
 =?utf-8?B?c2RwZEw2T0VvUEl3NHVRcWRaS1BVTXhHbTk2YS81RTNZbHh5SXRNNDVsdkNa?=
 =?utf-8?B?UFduMVE0RTYwNFMzSFNUdWJYRzNUeGJqWGZRTFFScWw0ajNoZjBGTTRNQ1Z0?=
 =?utf-8?B?UVo3d1R4SXdyMXZFQnhCL1BjcU9rN1ZjUWJmNDVGcUtMZHhhWG5uRDFOVEU4?=
 =?utf-8?B?V2Z3UGxrM3UrZ2tTazdaWmNwZlBSQndxcTBtNzJmQ0YzNUZmWnd0eG04cFBP?=
 =?utf-8?B?THg0UmpSRy95OW1iclVjWFRyUFhtaVAvOU0ya01mT2hKWFlaWFF2MklsOU9C?=
 =?utf-8?B?VlhKN09HejE5andzRm9ER3RpdWpxcmM1eUJDQmw4QjFhcDR5d0RnYmMwQjFh?=
 =?utf-8?B?THFwN1drQmFpb1VmWjZKY3pLTkNXWkQ3NXFXMnFraWlqWGNGOUEzVWh1ZlVt?=
 =?utf-8?B?NUhWTEM3NERNSTFUN29tblJVWUg5b0puRHBhdTl6cXY3SC8rV1JWZHFibHdG?=
 =?utf-8?B?aFUzVUkwbkptUTR0NlphazVKNzVzbWtlNGZIOS9xbW5ENEN3MDBDdDdPWWdG?=
 =?utf-8?B?T2gyQXVnbFBEa0JRcUFLRXVRWEhWK2orS2RaR1BNUGthWkI0NVhJdC9tMHdW?=
 =?utf-8?B?YjNIUkRBQ1F3WnlONmp2SnpOTHVFQXlaSUVMcHdiU2tTQmIwaXNDUzM2OTFS?=
 =?utf-8?B?RWNyMEpjdmg1aUw0cGxDZGU5Z2xjQ0VVbGNnNVlCM09RUEVpblcvUDhXQzdQ?=
 =?utf-8?B?RnNUdnROWHBieDNlWFZrOHpKak1iN2cxbFNaUm5CWVpZZWFSaWZsVDVTT0pH?=
 =?utf-8?B?RGVoM0JzOTZ0V0hOTWtsT3UvOW8rWGtKNlQ1M1h3RnFPUnovUGtrbWJUaE1h?=
 =?utf-8?B?aG4wUW42TEdXMjloSmNKelZ5WFRBOVhoVDBwMy9iZHZudVVFUFcwd2JvQzdt?=
 =?utf-8?B?WnVybGRYelFJdWtFRS8vd2Vqc3E1SG1aOE9MQ1lJdEthWXJVNG8wc0ZzYUQ4?=
 =?utf-8?B?TzZxYWduUnRTcDJGTmsybThVZVpNWkwwWm1zRFp3UkhjSTloSmhsaUNtNnF4?=
 =?utf-8?B?V3lDcXRCdGxLSEdIR0JiRnc4RnR6cnBDYzFJRjJadHpCdm1PeE84S1Y0U29T?=
 =?utf-8?B?cmRuaVNXUnB3bEx6a0g3d0dkaUhiNnFsSDZ4aThCYktMTjdtOEVPbGpJRTFy?=
 =?utf-8?B?eVF2RHZBaVRENDZjMHpRZjdzTTc2T1ViWVE0OU1NWlZvS1Z2dGxZU0R3M1lv?=
 =?utf-8?B?eGNteExPU09XcDZNemp1RzVjenhRU0Z4ZXpOQjdCK2s2VWdCUU5ROE5GY09X?=
 =?utf-8?B?WGpDSjRmNzQwWUlwYng5VkNMMFZmWXhESUVjeFY2VGxQWU1Xd21JSXg1dGJr?=
 =?utf-8?B?SjhxdTV0U3pCVjRwL0NRVW8zY1ViS2R3eXZlSlhNMk1kSTdDUHA4SVo5dUFl?=
 =?utf-8?B?aFEzcU5mQldSTlJWcUlGb1RLVGVzTVBGekZPNmhneFNMSERtUytLdGR2SWZG?=
 =?utf-8?B?bFkrLzFDTE5FVFgrMGJ6UHNlZzBISXBUQWs5azBtbnFvdzNnemp3TlR6MW0x?=
 =?utf-8?B?UncyZTJ0YTN4dm5DblF0Z0laQTkrSEtpcm14U0YyT0V2MFdnT0UwYk1PVk95?=
 =?utf-8?B?ZWl5ckwyam1oSCtnVHJEM0I5SkhaMUpEV0ZzUjBpQkJDL2N2M1ViUVRHRnRD?=
 =?utf-8?B?a2swNGRjL05RPT0=?=
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:SA0PR17MB4299.namprd17.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(10070799003)(366016)(1800799024)(7416014)(376014)(38070700018);
 DIR:OUT; SFP:1102; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?N0FWWElSUCttWllyN3VhTEsyN0RaRDI5OWZuYTFBK0xUN3Y0YW9sdHFjWEQ1?=
 =?utf-8?B?LytxeGkwT0hFdnI3bkJ0MXRiWWsxUGZ0dE1NTDhlZEdEODhtK2krQ0xOR2wx?=
 =?utf-8?B?M0N3bUhLTlB3cS9EZXZ4ZW93SkM2Ujd4TVkxM0tGaDdnaHFiU1JQZStEOXlw?=
 =?utf-8?B?dHc2b0IwSUJFcGNXSDB0M3grMkNEODAvZlhQUmZTWFdlZWlXVEtsSm1sbzE1?=
 =?utf-8?B?RS8wYjFObkdDeFVkREVYRTdFb2RzdS9UU2dqWnlnY1JDZmxmdGxqNmVjeitQ?=
 =?utf-8?B?bHpYNEwzNG5wRlB0aDdKc29vNEE5U2pEVXBUUUlpQkNORmtKUHRRQWlsNkRw?=
 =?utf-8?B?eU1lWXZkc00xWFFCc3ErNEhHQ1dVaHZpc1BLYzg1QmN1THVHZVZKNlVlREFX?=
 =?utf-8?B?ckM1MHRnNnVsZGc0WjBjZmMyVU5IampHajZhVnI0MDIzc3dlb1h0clcyZS92?=
 =?utf-8?B?bU5iQm9majNHMlE2N2ZMaThzM25CR1JILytqelBVdlBPNmZXME5lYXczQWh6?=
 =?utf-8?B?VEF5TDFYem1uc2NKQjhVdDNKQTd3YnhqYWhvbXdUNVJXWmVYdEVQWnhGM0hO?=
 =?utf-8?B?WXRMTU82UTlxdDJ3bWhnRUNGUDNhUVBvS3NxcG1hcGJDdDRLWXFTTWdxTkJu?=
 =?utf-8?B?WWdSNlQ1ck1Ra1VhYjlSSUNSQkhTN1B2M2NzSUpnaUtFTzByT2ZNbjFwbGlT?=
 =?utf-8?B?SXFpMnZkQmo5OHV1S3gwcDRDemZDemczMnVOdXBUUEFsWG5IVTFMKzliM0pv?=
 =?utf-8?B?dkhNYVVMY0JZVXg1UjRNa2hVN3RoT3RqVC9BckloajFpaGQ2dFRocWNqd0l0?=
 =?utf-8?B?aWVXcTBvc3ZJaHZMcU9RQ1k5RGVwaXliSXpEODVScjFmSDlJbXdpdUNoN2ti?=
 =?utf-8?B?cGluWmVIYzVzb0dYS3hjelBnb3gvUG9ucGJGazA5WGdoc1lnaS9ldXU1MUlh?=
 =?utf-8?B?M0pYZDFReDQ0Kzl6WlZGSWI5Yk1ZOG8zTFZDWG5KdGc2YTNzV0FudU9mTUlk?=
 =?utf-8?B?QW9ranYzUEgyaE5iN2NOVUZrY01VYU0wUFJaYzRVUzdaK1cwKzJLMjUrVW14?=
 =?utf-8?B?ZUFJbDFkZXpDVUc0aG8ya2tFZnFZbjc3TFNNenZGWU9oT2ErcjdSNGFFRTlh?=
 =?utf-8?B?cEtWeXJYRU9CallpL1FNMms0ZjVuajBTOVk3Z2laWUxVMUlsako0RTFFVmdq?=
 =?utf-8?B?YWtBMnpucmZDRDNZNDRCUEFwSTdZd0pubngvSnd1bXJsVE8xWXdlbFB2Sldi?=
 =?utf-8?B?UUdwQkZXUVpXTXZTMEZCb3V6RUc4VjBQbXM4bWlyV3ppS3crTjZWekRRVVdW?=
 =?utf-8?B?TzJueGhrOHdsRjhOZ1cvOUFSRy8wTk9PWkxpcE5EdTFKNUlmbmFYdGN6Tzh5?=
 =?utf-8?B?ZVhsQ2NXTnhvczUzV1VSbGtZdGhmd0s2bENpdWxvYnZIVzZibWRmdGZJU0NP?=
 =?utf-8?B?OXI0ZnA0Y0lNcmJJUURHYm5lVUhsRUhibnFvemp5UjRPOHp2ZGJBWloxQ2cx?=
 =?utf-8?B?RXNmdE1uR3NSU3R1VmNLMGh3Uk5ZaDdHOEhWMmNsNStpeko0WjhBM0N2QnNm?=
 =?utf-8?B?U3JDVnE0dldUTWNrYTJualhPU2JtdTBxdkQ5dDNoZVNJYWFPMkNtQUNmZko3?=
 =?utf-8?B?VUVvZDB1K1IrK210ZXVBRmdtWmNWZDBRWVNZbExxMStiOFRwbzJ5REdpdDZT?=
 =?utf-8?B?c0dXUnJ6VEJ4WGg5K3VJWU16NGtzQWlOZmR5am42RnlTNStYL2NEQnlwMWs3?=
 =?utf-8?B?amRKUkE3cEpibExGSVJTT2Q4ZTBGejExVGJWSjZDVmtPaGJZVWFHRnVPd3g0?=
 =?utf-8?B?OUhSTUQ0NXFjd2Q4WnJkdmZIZEt3b0RzQm9wd01NaGVwU2xqa2lmN09GT3Zn?=
 =?utf-8?B?QXgzdEpoeUFpZjZ5V0doZndUZ0NjOXpCeDA3bDRRRU9wSVpvak4xTEpsSDFF?=
 =?utf-8?B?VlpmYitEU1puZnFoRWFSY2lBR2hHRUZSYVpnWm9iTGJXSlFrMHU1RWptNk4z?=
 =?utf-8?B?OVJRMWRiWTBlUk96OGdhZ3R4cFR3bWNFRVcrOVplTUhXd2VsRE5lcnZsUDZW?=
 =?utf-8?B?SEJGVFM5Vm14aytmVkJpRklKclBGNldyTkxaNEozYVRmZG5sbWprSDRxdzZq?=
 =?utf-8?B?b3RibTJrNDNYRFRlc0dvdjhBZXVIbGh3ZE4zZkswK1VKVXJCVk1mZ3d0VG11?=
 =?utf-8?B?OEZ3NmxUeUZrVmRza01aYlltT3ZKdVdrOExRYTlwQUpIZFErUXBOSkRWM2hS?=
 =?utf-8?B?dFJpYjlFQnBvUVJOZ0cwd3A2clJ3PT0=?=
arc-seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=yUvHBPdF3nj/9426udiaqd8r471thmSZSrV4Is+6ddyCwPVIgmhYLPf2T9wgsDqHy13AIl4oMydSGEfz+J5Bgzfj/yKrbzMYlClhwLGAozf3whZd9OwIG0mFyc/UEWVWeWZP9NPJFH3KRx/hgbFQ7TFS0YydHmkuh4DxSXvBwmAU1M3ffsPh4gx3TZsmEKvAM2EUwzinxVgNtZfQEX5GVa9BwvQxvjIOPFB0cuWscUnNOQPt4+t3pDoLwRESCEYL9QV4U+7xpGQ+SUU5GVe6FDUt/67Ih0a5xKY1tLU/f/FRseZrSs5yr8wK5K2yEC9lisbcPmXVeYnfQHOcn9KgpA==
arc-message-signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=d9hPyd/w8GnA2yX65s5RNsB0kNcZ7vBAkH06C018r64=;
 b=VEr99vWZGWjPxMz2Bw5LuKHjH1/InqjKtOMRYhPlxa8IWEiCPGAT+ymc1QNHK1hzr/ZAbQYsL3LpzLCfY4rZy5Ig5yo2zYukdVP5YwC1Mvuf9Ynu0P3/CmisEgjHSBd0xUuix8k3quDcn9/ZLWw2aOu8rZLoBKHkgmvfCmVRf3kNcMVztjMBK4nu3u+RoRBh6a+MuB9SInNDW8Gg8fNMPnl1VpzvDdR6HZu8jM3v5K516xw8N5xKrQCjvAu05j0E7hEneRjwzP32QKyzDPHKqENc+noOa8rkGwIZSxSHmvQWuqriwwFuT54pmPz9gHixK3DF7MI18BCrrL1PrYSCfg==
arc-authentication-results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=akamai.com; dmarc=pass action=none header.from=akamai.com;
 dkim=pass header.d=akamai.com; arc=none
dkim-signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=akamai365.onmicrosoft.com; s=selector1-akamai365-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=d9hPyd/w8GnA2yX65s5RNsB0kNcZ7vBAkH06C018r64=;
 b=QOk5KgvH2SQEXrYPMrdrCF+1q+VNN9OJ4B/67j99VZ6ls87sKqN+bn8G397Zdj7zUGpS19RAniL04BfkboT9b87tc2fTYYyQZKynKogOMSwpIU9razIr3GqEGzPyC/8kYoNpZrsSV9ke5upO9Db+W1LerHGTkORYQH+GCpfzj7I=
x-ms-exchange-crosstenant-authas: Internal
x-ms-exchange-crosstenant-authsource: SA0PR17MB4299.namprd17.prod.outlook.com
x-ms-exchange-crosstenant-network-message-id: 8d99818b-be37-439b-df30-08dd92358dc7
x-ms-exchange-crosstenant-originalarrivaltime: 13 May 2025 15:48:06.5489 (UTC)
x-ms-exchange-crosstenant-fromentityheader: Hosted
x-ms-exchange-crosstenant-id: 514876bd-5965-4b40-b0c8-e336cf72c743
x-ms-exchange-crosstenant-mailboxtype: HOSTED
x-ms-exchange-crosstenant-userprincipalname: iGyWumW3WE/o2G1QJ9MD6u6zuLedYKmhKiEyobBVMknrQjQlYmGOZ5EccIStnZ+w8cpk5Z9hExQ/Tu9he0AS5A==
x-ms-exchange-transport-crosstenantheadersstamped: SN7PR17MB6748
x-originatororg: akamai.com
Content-Type: text/plain; charset="utf-8"
Content-ID: <CF8CF410703C964F85675F1E72AFBD1F@namprd17.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1099,Hydra:6.0.736,FMLib:17.12.80.40
 definitions=2025-05-13_03,2025-05-09_01,2025-02-21_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 phishscore=0
 bulkscore=0 spamscore=0
 malwarescore=0 suspectscore=0 mlxlogscore=819 mlxscore=0 adultscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2504070000
 definitions=main-2505130150
X-Proofpoint-GUID: -R1z3YkhO0ZYfkyzK9qm9tdaImJEelBS
X-Proofpoint-ORIG-GUID: -R1z3YkhO0ZYfkyzK9qm9tdaImJEelBS
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwNTEzMDE1MCBTYWx0ZWRfX1+/+KG4SF87n
 tffggbAb53qqNUecGP3oCCwYvs7fHgPc6oVypEe+gIL2PmRwFi4PPetnyvySrBAEv4z9OcK3RNy
 KGd3QZHVvDLL0RJSVcgVtChVk0pXwEzx8CWBV+wtA0S14tnIbR69L+cB9NYbmzMK+LGtVH7Ee92
 Gk6K/bsC0a4Oinbg+bWGMxc9ymhnWFBvBA4Rxs7RjDZZK/nKyF0KvBYkUj1K0rxL/K3jBK87UQg
 DALCgoa3XWzf4GDrJjup7uLY1JiBztAMqx4HrGphdnfO0qEnUMBsrgrK9NunkU6NMh8ExpsNihk
 kFtZfpmf4jxBd3qDyATI6fqUYwOlsHtjrh/T2Zo6aBZzQ+QNCFwKHJpiQFnU/ecBkuNfWwSiBLH
 sI0j+JOLtfjNvzlT4pZeNaFLGtEVZhG6jRSNdtKqelqcbyMd+mBWPMnrtcjMUk1WpLySHcCp
X-Authority-Analysis: v=2.4 cv=LsmSymdc c=1 sm=1 tr=0 ts=682369c4 cx=c_pps
 a=3lD5tZmBJQAvN++OlPJl4w==:117 a=3lD5tZmBJQAvN++OlPJl4w==:17
 a=lCpzRmAYbLLaTzLvsPZ7Mbvzbb8=:19 a=wKuvFiaSGQ0qltdbU6+NXLB8nM8=:19
 a=Ol13hO9ccFRV9qXi2t6ftBPywas=:19 a=xqWC_Br6kY4A:10 a=IkcTkHD0fZMA:10
 a=dt9VzEwgFbYA:10 a=g1y_e2JewP0A:10 a=20KFwNOVAAAA:8 a=qLWNjtBpGqDRWf0WrbEA:9
 a=QEXdDO2ut3YA:10
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1099,Hydra:6.0.736,FMLib:17.12.80.40
 definitions=2025-05-13_03,2025-05-09_01,2025-02-21_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 suspectscore=0
 phishscore=0 clxscore=1015 lowpriorityscore=0
 mlxscore=0 impostorscore=0
 mlxlogscore=635 bulkscore=0 spamscore=0 malwarescore=0 priorityscore=1501
 adultscore=0 classifier=spam authscore=0 authtc=n/a authcc= route=outbound
 adjust=0 reason=mlx scancount=1 engine=8.19.0-2504070000
 definitions=main-2505130150
Received-SPF: pass client-ip=67.231.157.127; envelope-from=bchaney@akamai.com;
 helo=mx0b-00190b01.pphosted.com
X-Spam_score_int: -42
X-Spam_score: -4.3
X-Spam_bar: ----
X-Spam_report: (-4.3 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-1.549,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_LOW=-0.7, RCVD_IN_MSPIKE_H5=0.001, RCVD_IN_MSPIKE_WL=0.001,
 RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001, RCVD_IN_VALIDITY_SAFE_BLOCKED=0.001,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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

T24gNS8xMi8yNSwgMjo1MCBQTSwgIlBldGVyIFh1IiA8cGV0ZXJ4QHJlZGhhdC5jb20gPG1haWx0
bzpwZXRlcnhAcmVkaGF0LmNvbT4+IHdyb3RlOg0KDQoNCj4gV2hhdCB5b3Ugc2FpZCBtYWtlcyBz
ZW5zZSB0byBtZSwgYnV0IEknbSBuZWl0aGVyIHBtZW0gdXNlciBub3INCj4gZXhwZXJ0LiBMZXQn
cyB3YWl0IHRvIHNlZSB3aGV0aGVyIG90aGVycyB3b3VsZCBsaWtlIHRvIGNoaW1lIGluLg0KDQoN
Cj4gV2hhdCdzIHRoZSBmaXJzdCBiYWQgY29tbWl0IG9mIHRoZSByZWdyZXNzaW9uPyBJcyBpdCBz
aW5jZSB2MTAuMCByZWxlYXNlPw0KDQpIaSBQZXRlciwNCiAgICAgICAgV2UgYXJlIHN0aWxsIG9u
IGFuIG9sZCBicmFuY2ggKDcuMikuIFRoZSBpc3N1ZSBiZWdhbiB3aGVuIHdlIGVuYWJsZWQgcG1l
bSwgbm90IGFzIHRoZSByZXN1bHQgb2YgYSBjb2RlIGNoYW5nZS4NCg0KVGhhbmtzLA0KICAgICAg
ICBCZW4NCg0KDQoNCg0KDQo=

