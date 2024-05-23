Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 01A5DC41513
	for <qemu-devel@archiver.kernel.org>; Thu, 23 May 2024 08:44:06 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sA42m-00072N-JH; Thu, 23 May 2024 04:43:25 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <zhenzhong.duan@intel.com>)
 id 1sA42X-000700-Tk; Thu, 23 May 2024 04:43:11 -0400
Received: from mgamail.intel.com ([198.175.65.15])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <zhenzhong.duan@intel.com>)
 id 1sA42V-000634-M1; Thu, 23 May 2024 04:43:09 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1716453788; x=1747989788;
 h=from:to:cc:subject:date:message-id:references:
 in-reply-to:content-transfer-encoding:mime-version;
 bh=U/xK7qPPeer1CquugC8DWuDQxz7LvXm5KsUzBDM6P6w=;
 b=d0+t3NlKCWRERY/Lo65eslPeQxK9sE0jmRZufV1FMIkegbFzXOXGyPbX
 cYnUTOGjZL8V2PiDaGEzXjeaI/2QAdqQiJaeJyLwTySxiDpLVK0BOFz1z
 b3fFmnftBT3t82SEtHrz4VcqtqsNxGvGkcULNbVUMCHExSwIh9eO56cKH
 pY/sfPjIVgWrTOyFXY0WaGefNmB/a2WV95lbqLjL/8/J04FB+667c2ZXV
 6GBHcraqRdc4ARbvfEjlSmB5mnQcCXb/R0m/OxOlbGBbBYe9zmEjLtr8B
 Ken1dVlrTjLyHB3rY6AEoXPWIg5SAmibSW1/n1SN+jImNPFH8EV6vi8AT Q==;
X-CSE-ConnectionGUID: HuZytcJTT4e0OY27c5y35A==
X-CSE-MsgGUID: n5MaKY1oSW2ccv+JEfaCBA==
X-IronPort-AV: E=McAfee;i="6600,9927,11080"; a="16543661"
X-IronPort-AV: E=Sophos;i="6.08,182,1712646000"; d="scan'208";a="16543661"
Received: from orviesa005.jf.intel.com ([10.64.159.145])
 by orvoesa107.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 23 May 2024 01:43:04 -0700
X-CSE-ConnectionGUID: eTDoKtg0QMmaH5Pl7R0/ug==
X-CSE-MsgGUID: ScTZBbjITeyR9lBBrJXLqg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.08,182,1712646000"; d="scan'208";a="38422818"
Received: from orsmsx601.amr.corp.intel.com ([10.22.229.14])
 by orviesa005.jf.intel.com with ESMTP/TLS/AES256-GCM-SHA384;
 23 May 2024 01:43:04 -0700
Received: from orsmsx611.amr.corp.intel.com (10.22.229.24) by
 ORSMSX601.amr.corp.intel.com (10.22.229.14) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.39; Thu, 23 May 2024 01:43:03 -0700
Received: from ORSEDG602.ED.cps.intel.com (10.7.248.7) by
 orsmsx611.amr.corp.intel.com (10.22.229.24) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.39 via Frontend Transport; Thu, 23 May 2024 01:43:03 -0700
Received: from NAM12-BN8-obe.outbound.protection.outlook.com (104.47.55.168)
 by edgegateway.intel.com (134.134.137.103) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.39; Thu, 23 May 2024 01:43:03 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=YQbwhUrYIRlFdwBfuIeXjQLHz1+x/J/eI6H2VztQ0RAWwOSRFGpiFzhrqohDzG7g4PLYDJeuFsziYkB4lw/QOkdvilhdwrfW9tRPyMZd0pfBuLc4ujhMjR2hxYi4AZIpumZ+rijjUzLvzduUQUThbjxjTIV9YA4NvI4zkuAhCpNcRrhFPBuId3TqCwIhllJFGfXf8W2fQOL6jVY7UnkiF/2Ouc0HQMJFSgyBxdAG9t18TCM4rVMkihHtfyVuNaiqwNwIgDI0+jy4m+ItV8EOT1I9XxlGlWlvlbfMFZghKY7KR7JRi+WplldaolMQ0V+t8m4pRoCMgvfQi3pAaFAuoQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=U/xK7qPPeer1CquugC8DWuDQxz7LvXm5KsUzBDM6P6w=;
 b=KdzaEGwpaXrS4N5+6SvFWzNwZ6DaErIWuh4Fsu8ia9b8ekmk6doJw3aO1Wvd/DrqO5MK3lrg9RNjG2VhgNoKJwqF2nlGTHoBbf5uFaIamR2xDsDX0PAY4f+b8pcNyCycd4RZwzRH7SuLNOP0mltuPWv44nx86v5ebRNFoMYC6w6cX32n+q32ORRj4T8Yy37cF7M8Z1a46bTRZHPVWl84LSDKWhADvzY5uzojIJSJYEclDBJYmzYm/bhRn+25RTb41410+NGCLGaAIyJ4VbJjc7rAWu/v7eYuwRdib8poP7pKQJA+qdF3wdiLRnlwvdFoDpAjiOStb8A/fWjpna6QXg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Received: from SJ0PR11MB6744.namprd11.prod.outlook.com (2603:10b6:a03:47d::10)
 by CO1PR11MB4849.namprd11.prod.outlook.com (2603:10b6:303:90::13)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7611.19; Thu, 23 May
 2024 08:43:01 +0000
Received: from SJ0PR11MB6744.namprd11.prod.outlook.com
 ([fe80::fe49:d628:48b1:6091]) by SJ0PR11MB6744.namprd11.prod.outlook.com
 ([fe80::fe49:d628:48b1:6091%7]) with mapi id 15.20.7611.016; Thu, 23 May 2024
 08:43:01 +0000
From: "Duan, Zhenzhong" <zhenzhong.duan@intel.com>
To: =?utf-8?B?Q8OpZHJpYyBMZSBHb2F0ZXI=?= <clg@redhat.com>,
 "qemu-devel@nongnu.org" <qemu-devel@nongnu.org>
CC: "qemu-s390x@nongnu.org" <qemu-s390x@nongnu.org>, Thomas Huth
 <thuth@redhat.com>, Matthew Rosato <mjrosato@linux.ibm.com>, Eric Farman
 <farman@linux.ibm.com>, Tony Krowiak <akrowiak@linux.ibm.com>
Subject: RE: [PATCH 1/7] hw/s390x/ccw: Make s390_ccw_get_dev_info() return a
 bool
Thread-Topic: [PATCH 1/7] hw/s390x/ccw: Make s390_ccw_get_dev_info() return a
 bool
Thread-Index: AQHarGnH9vGgD5RKmkyDXCVdBjnL/7GkgT6A
Date: Thu, 23 May 2024 08:43:01 +0000
Message-ID: <SJ0PR11MB6744D719CBE3576CC46F43B892F42@SJ0PR11MB6744.namprd11.prod.outlook.com>
References: <20240522170107.289532-1-clg@redhat.com>
 <20240522170107.289532-2-clg@redhat.com>
In-Reply-To: <20240522170107.289532-2-clg@redhat.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: SJ0PR11MB6744:EE_|CO1PR11MB4849:EE_
x-ms-office365-filtering-correlation-id: bed76949-59a2-47c8-61d6-08dc7b045ab7
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0; ARA:13230031|1800799015|366007|376005|38070700009;
x-microsoft-antispam-message-info: =?utf-8?B?SFBUMjlZWUlMUG1tbGZFMCs3aDUwa2Y2ZXhIT2s0bldlQm9MbngxODNwSkJ5?=
 =?utf-8?B?K1N5bnptN3FFT1Rib3p1WWhzRHRQUzNSc2t3UXp2WnFpKzhZK2picy9hOEIr?=
 =?utf-8?B?V1ZqNjJNc3JQNXBINGNpaEc3OThoMU55a2RDWW5ycTJtbTN3cFVlSlpmZkF4?=
 =?utf-8?B?bHUyMEh6VUN5aGUvOEJMT3lucWtFME5pSXo4VmIxYmRVelZlZU4rR2c5M1pn?=
 =?utf-8?B?WTFxMHNxTEdkY25MdkpVZ1lBVU01Y3ljRnZSbFI4cUd0Rm1oV0xLcmRMYWVm?=
 =?utf-8?B?bUk4dnhJRFZhVk9WSzJhV2J1Y0xsbW1UOE9aMTRjRFR1WEJ1eDhSeUI4MWNG?=
 =?utf-8?B?MWI3aWpyWFZVOE1WZTB4S3gwYjUxMXE2Z0VFYlBmbk5sMm11U21RRXk1M05B?=
 =?utf-8?B?WFlSN1RZWGNQa3VwY0JJZC9XZThnYXN5SUhsTFBXRndNQ042TGhzWXRHbUFK?=
 =?utf-8?B?enJtMUdBaW5KQm9jR1I2N3lsY25KSnFRWTdmQWh0L0dLZWI2Sk1UbWdRTUpH?=
 =?utf-8?B?SnRKR1RPTVdVZnMrbUdtU1NXNnlUUmZxYlMyWEcwVzFMWDBhUkdKN1U3WXB6?=
 =?utf-8?B?Sjg0SnFEVjc5VmNYd1NMZS9uNVlydDdrTm5HT0pMSWdsS0hheWppaVNzOTNF?=
 =?utf-8?B?a1hRT0J4c3lsNmtEZTdJZUJRZUxobnQ2Uzl5K0JYWktodHk2WTFGOEVVcEZp?=
 =?utf-8?B?LzJWekN1c3c0K1ZDZHpRcFd5N0hVQVRIeHB1UVY0Z1ZsR1NRK0t1SmlDK010?=
 =?utf-8?B?RlloVlVUNjdoa0Nxd1pOZEN2TVlNdENNbVB0S01VWVQ1OE9SVDRCR3kxY29x?=
 =?utf-8?B?QTBhaVFscGthZll0aGVFWHFVUnZVZFE2ZXo5cHgzUUlQRG43bEJ0cGpBR2tO?=
 =?utf-8?B?U25wSlVSTkFyaHVHYTd5Q2FaNXFPQzVaOTZPSzlEc1ZjaDFWWWQwcDBseW5h?=
 =?utf-8?B?TjI2NDBoOCs5WC9ady9MditYbDJpaG16MGNJckNjNUcwM1N1VzFCb2JPS1Rt?=
 =?utf-8?B?d0RGeUVPYTR0OXE1SGhqaGpDKzdlUTlXMnh0N1dpSUkwbVBIWStEZWpteDdt?=
 =?utf-8?B?bVMwTGJrL1V6VFpteFpicGt3SjRydElyaTFJUXg5QUE0TkdiVkMvY25zUzVO?=
 =?utf-8?B?ZFBra25tcFljKzZRMGF3YVR6UHFFRC83WkxDMkYwWWlDVEMxOEZMN1ZXdi9B?=
 =?utf-8?B?OTA4ckw2bXR1ektOZWQ1dGNkbnBtcXBQVTRoR0hDMVUwbEhNWTNPMDVsYWJq?=
 =?utf-8?B?U0FFdkdzOE50WkNOQ3F5YlBqOGFUV09sM1dQU2YvT2hJYXkycXNVblh0NXll?=
 =?utf-8?B?MXBvb21lczdTbk14bFhPWkJ4SHRRZkZiMkN0bnJrdmdhVXhtb1hOK2ZzeTJG?=
 =?utf-8?B?Ly9sZTErV09ZQ1lFQmVObDFjT3kxRlZwb3VDamxaL2tZNWkzdVczYkZMTU5q?=
 =?utf-8?B?ME1yWTlSdVZsOVVrZmZZaC96SzRMWEpEbzVPUFZaUnppTFN6OVdrbWlHaDQz?=
 =?utf-8?B?aGUwYVNUQWhxNWlBNW1lUmRXQk1ucC9Ea3Z4SG1VM2g2VzgvRnllMERlSlhS?=
 =?utf-8?B?VitGVFJ0dHhrSnYvb0pML1ZwVnNHWjRRbWZjYzhoWlZGYTBuWXVqTlFyVStJ?=
 =?utf-8?B?c29DQXBqcGxjbXREVWIvWUFWNzIvck5NOHJMNWVXU2tXd3hiOWF6MWI2ZXBr?=
 =?utf-8?B?L2xoTXp1WW9OYzlwcm5KMFArVkpuZ0duZUhEdU1DY3BLVE1UWTV0OERvb1lZ?=
 =?utf-8?B?aCtVUVNDamZkaWJvVk9QcDEyckdPWHBwYmYzVDJXVVZrdkl6OFM0SWFUN0F2?=
 =?utf-8?B?TWJ4TmpabEs5cWNlOXJmZz09?=
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:SJ0PR11MB6744.namprd11.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230031)(1800799015)(366007)(376005)(38070700009); DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?UUpoUU16YVp0aEtDTGJXeVQ2VWVMWGpTbDhaaTZZZlBYTW8vaHRtYnJoV0NX?=
 =?utf-8?B?TjcwaU5PZXNtS2ZLMDRDcmEwQ2h0MnIzMjN1d1BHeXVYdHdiVTdtYmNKOS8w?=
 =?utf-8?B?K0g4TlNqVExmMmJyL0ZaYmt2R0NGU3ZJMGFhUVZRenlPOWxxZ29wMDZWUlMz?=
 =?utf-8?B?Rkt0SlJaRTBwTFczcHFpcVVWVzJab092K0N1bjRzZTUxWjIyUlVjaUNXaE5i?=
 =?utf-8?B?Z2tzSHdicFFHd2NkMTNjMnN0TXVtV25lL0VraUk5RHREZmRaYi9YR3hLN0t5?=
 =?utf-8?B?dDNQcDVkS1RaZXhUdGU3eFVrY2Znc1JDNmI5UkV2dmY5QWI0RTBxakM2ZjdP?=
 =?utf-8?B?OUNaL25iUTlkNmphNXZzenJhWjdlNHNLdTZPTjUzV25iUFFUeS9JNnYxdjBX?=
 =?utf-8?B?bldwYzZtNC9xYks5WHErOXEySktRTkFVK0ozWFNhaFJjNG05Q3lYYS8vQTdn?=
 =?utf-8?B?YVNWLzcrK2lVdG0xUUpjaE85T0RYZWZUVXhVeW01WmFiSlJBL1pNVWFrUC82?=
 =?utf-8?B?SjBvTXdhaStZN1ZDS3c4MUIzeXBqVHlIb2xlaE9OMDEyYzEzcDNPdHhJd3JM?=
 =?utf-8?B?cVRiZE5WbDl4WVRZYTFWUFEzYUhpUWFKZE9nRmp3ZzFRbE8wb09JaUNJNEYx?=
 =?utf-8?B?MkE2TWJBdU56ZkYwRTJMM0F1NUROZ2NGS3NUUEZMQUc4K1RUVUo0NzExRllo?=
 =?utf-8?B?RXlkMkhsdm9saVcvOUhOc3NuMFp1RkdxRkR5Ukp3RGZPMW9tdUNjeE9vWW9H?=
 =?utf-8?B?R2J6b2xIa0kzdktldmhPUUg5NXpvL2hlb2U4ZW5kd282SzN6aWYrdk1abTdq?=
 =?utf-8?B?RnFMZ2poZEFJelIwdGQ5ZnZJanNYOUZ1Zmt6VjdaL0t2aGg0RWxBUUREZTNr?=
 =?utf-8?B?MEYzUzlYWENJdzJsbDR5OUVKYmZHaGEvYWx5UlowSFQ2ODV0L1ZoQi9WV3lX?=
 =?utf-8?B?cUlQS0NGc0lNcEt0NnpSdGFDZzc5SVhBTGZIcEp1U0VFbHAwR05PYWxIK2ta?=
 =?utf-8?B?bnpCMUtJeEJRZE1NbjFqU1pnTHl2c3BjeEtQTWxXTEx6cGo0RTM2WEdISHN2?=
 =?utf-8?B?QVNWQ0FrYTRFYmZrUjk2QUIybjcwSUpuNWZlK0dxTlBjWmtWWU81VDFmc1Vv?=
 =?utf-8?B?ZWptcWdILzd1bzdKeUVWTVA4RXhPRzQxdXBSMWpoRWhIcGVXeFRaNGZWYjlo?=
 =?utf-8?B?Y2NwM2doNzJJTlVRc0xCR0JXaVJNWFdsTWNsR1l2SkMvRlhSeHdVRmtTazdv?=
 =?utf-8?B?emsvR0tDaFUyS09iLzFKYUFjZ0orK2FMNmtNWGFyaUJVSGJZTjZvSUN6SC9I?=
 =?utf-8?B?elorTlk1eDFrbHp2bnpSdDc5dlg0R1BMVGp4Ungva0JYdFRpeHVPV0tvT0V4?=
 =?utf-8?B?ODkvYVI2N3JucjhLZHdBa1FuT1RIVnNQZnEvVzlPelZHQUthak4xbDZIU0JR?=
 =?utf-8?B?MFFKMnJWVHM2TXA3bTZoUS8wZ0J2Z1ZqdVA3TmFOYXovSzVJYnloclVERkdS?=
 =?utf-8?B?UlFzeE1mbk1xYXI1dHVNYnNCd2R3VlpNcTc1bGR0Tmk4cGJxd1VkT0hLQWMz?=
 =?utf-8?B?VjlOL3pQbUNLaXNXY210eHUrOTVpQktPYkdWV2tZVWlKYW9TVkx5SndFVkVO?=
 =?utf-8?B?RHRpdnZLcjF0UWRyR1N6eFNrZ2owdTE4K21lM3d3UEl1V0Y3c0pIOW5wT1d1?=
 =?utf-8?B?RzFRRkkyZGtYMnF5L2dDZkFpTmp3c0lEN0xYRDZSWHhVR0JuWmRrV3NnVHpv?=
 =?utf-8?B?T0s2eWN2eGoxK21rVk9NU3FKMjRISkx4ZzNDZ2VMOE10aytlUHN4RnhYeDRC?=
 =?utf-8?B?cFgxLzJmeGduNEs1dEowYjNVcFd5TWE4TVNoY0dGb3dKYmg5TXFQcUhKcENV?=
 =?utf-8?B?a3pXcGVLaTdMRC80MUwycGpTZTMrTG9qOUVFUzc4Vk1zV2FDbnN5L1kzWjdC?=
 =?utf-8?B?cXBpN1RHSC9VNURUcG1JZkJ3K3RDVndFZVBMTHkwSGNZWDRiQU1XNnB1UWF6?=
 =?utf-8?B?c2MzL1ZsQjBHK1RTKy81S01zTTNmNkxudDBPajgvMEZTUTJsZXlhaFBLQWFl?=
 =?utf-8?B?V0psVjVnWXZ5QjAzOXg5Mk0yeGw3cDNDV0ZkcjVGeFZKMDFFcmRPMEhDVm1x?=
 =?utf-8?Q?TUg5ovVRaHXAknNkaAuapGQpf?=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: SJ0PR11MB6744.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: bed76949-59a2-47c8-61d6-08dc7b045ab7
X-MS-Exchange-CrossTenant-originalarrivaltime: 23 May 2024 08:43:01.1201 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: yVdSmP2wenqYoRPLaLlwe3u3V3T6h4BFtuZ29T0Ye5tEKnNG00BGK0kwh0JNjMsJc+HN+nf7hDxVOgAKBQ1CIhvdRBlQkft1UoCo3lrc45g=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CO1PR11MB4849
X-OriginatorOrg: intel.com
Received-SPF: pass client-ip=198.175.65.15;
 envelope-from=zhenzhong.duan@intel.com; helo=mgamail.intel.com
X-Spam_score_int: -43
X-Spam_score: -4.4
X-Spam_bar: ----
X-Spam_report: (-4.4 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_MED=-2.3, SPF_HELO_NONE=0.001,
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

DQoNCj4tLS0tLU9yaWdpbmFsIE1lc3NhZ2UtLS0tLQ0KPkZyb206IEPDqWRyaWMgTGUgR29hdGVy
IDxjbGdAcmVkaGF0LmNvbT4NCj5TdWJqZWN0OiBbUEFUQ0ggMS83XSBody9zMzkweC9jY3c6IE1h
a2UgczM5MF9jY3dfZ2V0X2Rldl9pbmZvKCkgcmV0dXJuDQo+YSBib29sDQo+DQo+U2luY2UgczM5
MF9jY3dfZ2V0X2Rldl9pbmZvKCkgdGFrZXMgYW4gJ0Vycm9yICoqJyBhcmd1bWVudCwgYmVzdA0K
PnByYWN0aWNlcyBzdWdnZXN0IHRvIHJldHVybiBhIGJvb2wuIFNlZSB0aGUgcWFwaS9lcnJvci5o
IFJ1bGVzDQo+c2VjdGlvbi4gV2hpbGUgYXQgaXQsIG1vZGlmeSB0aGUgY2FsbCBpbiBzMzkwX2Nj
d19yZWFsaXplKCkuDQo+DQo+U2lnbmVkLW9mZi1ieTogQ8OpZHJpYyBMZSBHb2F0ZXIgPGNsZ0By
ZWRoYXQuY29tPg0KDQpSZXZpZXdlZC1ieTogWmhlbnpob25nIER1YW4gPHpoZW56aG9uZy5kdWFu
QGludGVsLmNvbT4NCg0KVGhhbmtzDQpaaGVuemhvbmcNCg0KPi0tLQ0KPiBody9zMzkweC9zMzkw
LWNjdy5jIHwgMTIgKysrKysrLS0tLS0tDQo+IDEgZmlsZSBjaGFuZ2VkLCA2IGluc2VydGlvbnMo
KyksIDYgZGVsZXRpb25zKC0pDQo+DQo+ZGlmZiAtLWdpdCBhL2h3L3MzOTB4L3MzOTAtY2N3LmMg
Yi9ody9zMzkweC9zMzkwLWNjdy5jDQo+aW5kZXgNCj41MjYxZTY2NzI0ZjFjYzMxNTdiOTQxM2Iw
ZDVmZGY1Mjg5YzkyNTAzLi5hMDZlOTFkZmIzMThlMzUwMDMyNDgNCj41MTQ4OGM1NjgwNmZhNDZj
MDhkIDEwMDY0NA0KPi0tLSBhL2h3L3MzOTB4L3MzOTAtY2N3LmMNCj4rKysgYi9ody9zMzkweC9z
MzkwLWNjdy5jDQo+QEAgLTcxLDcgKzcxLDcgQEAgSU9JbnN0RW5kaW5nIHMzOTBfY2N3X3N0b3Jl
KFN1YmNoRGV2ICpzY2gpDQo+ICAgICByZXR1cm4gcmV0Ow0KPiB9DQo+DQo+LXN0YXRpYyB2b2lk
IHMzOTBfY2N3X2dldF9kZXZfaW5mbyhTMzkwQ0NXRGV2aWNlICpjZGV2LA0KPitzdGF0aWMgYm9v
bCBzMzkwX2Njd19nZXRfZGV2X2luZm8oUzM5MENDV0RldmljZSAqY2RldiwNCj4gICAgICAgICAg
ICAgICAgICAgICAgICAgICAgICAgICAgIGNoYXIgKnN5c2ZzZGV2LA0KPiAgICAgICAgICAgICAg
ICAgICAgICAgICAgICAgICAgICAgRXJyb3IgKiplcnJwKQ0KPiB7DQo+QEAgLTg0LDEyICs4NCwx
MiBAQCBzdGF0aWMgdm9pZCBzMzkwX2Njd19nZXRfZGV2X2luZm8oUzM5MENDV0RldmljZQ0KPipj
ZGV2LA0KPiAgICAgICAgIGVycm9yX3NldGcoZXJycCwgIk5vIGhvc3QgZGV2aWNlIHByb3ZpZGVk
Iik7DQo+ICAgICAgICAgZXJyb3JfYXBwZW5kX2hpbnQoZXJycCwNCj4gICAgICAgICAgICAgICAg
ICAgICAgICAgICAiVXNlIC1kZXZpY2UgdmZpby1jY3csc3lzZnNkZXY9UEFUSF9UT19ERVZJQ0Vc
biIpOw0KPi0gICAgICAgIHJldHVybjsNCj4rICAgICAgICByZXR1cm4gZmFsc2U7DQo+ICAgICB9
DQo+DQo+ICAgICBpZiAoIXJlYWxwYXRoKHN5c2ZzZGV2LCBkZXZfcGF0aCkpIHsNCj4gICAgICAg
ICBlcnJvcl9zZXRnX2Vycm5vKGVycnAsIGVycm5vLCAiSG9zdCBkZXZpY2UgJyVzJyBub3QgZm91
bmQiLCBzeXNmc2Rldik7DQo+LSAgICAgICAgcmV0dXJuOw0KPisgICAgICAgIHJldHVybiBmYWxz
ZTsNCj4gICAgIH0NCj4NCj4gICAgIGNkZXYtPm1kZXZpZCA9IGdfcGF0aF9nZXRfYmFzZW5hbWUo
ZGV2X3BhdGgpOw0KPkBAIC05OCwxMyArOTgsMTQgQEAgc3RhdGljIHZvaWQgczM5MF9jY3dfZ2V0
X2Rldl9pbmZvKFMzOTBDQ1dEZXZpY2UNCj4qY2RldiwNCj4gICAgIHRtcCA9IGdfcGF0aF9nZXRf
YmFzZW5hbWUodG1wX2Rpcik7DQo+ICAgICBpZiAoc3NjYW5mKHRtcCwgIiUyeC4lMXguJTR4Iiwg
JmNzc2lkLCAmc3NpZCwgJmRldmlkKSAhPSAzKSB7DQo+ICAgICAgICAgZXJyb3Jfc2V0Z19lcnJu
byhlcnJwLCBlcnJubywgIkZhaWxlZCB0byByZWFkICVzIiwgdG1wKTsNCj4tICAgICAgICByZXR1
cm47DQo+KyAgICAgICAgcmV0dXJuIGZhbHNlOw0KPiAgICAgfQ0KPg0KPiAgICAgY2Rldi0+aG9z
dGlkLmNzc2lkID0gY3NzaWQ7DQo+ICAgICBjZGV2LT5ob3N0aWQuc3NpZCA9IHNzaWQ7DQo+ICAg
ICBjZGV2LT5ob3N0aWQuZGV2aWQgPSBkZXZpZDsNCj4gICAgIGNkZXYtPmhvc3RpZC52YWxpZCA9
IHRydWU7DQo+KyAgICByZXR1cm4gdHJ1ZTsNCj4gfQ0KPg0KPiBzdGF0aWMgdm9pZCBzMzkwX2Nj
d19yZWFsaXplKFMzOTBDQ1dEZXZpY2UgKmNkZXYsIGNoYXIgKnN5c2ZzZGV2LCBFcnJvcg0KPioq
ZXJycCkNCj5AQCAtMTE2LDggKzExNyw3IEBAIHN0YXRpYyB2b2lkIHMzOTBfY2N3X3JlYWxpemUo
UzM5MENDV0RldmljZSAqY2RldiwNCj5jaGFyICpzeXNmc2RldiwgRXJyb3IgKiplcnJwKQ0KPiAg
ICAgaW50IHJldDsNCj4gICAgIEVycm9yICplcnIgPSBOVUxMOw0KPg0KPi0gICAgczM5MF9jY3df
Z2V0X2Rldl9pbmZvKGNkZXYsIHN5c2ZzZGV2LCAmZXJyKTsNCj4tICAgIGlmIChlcnIpIHsNCj4r
ICAgIGlmICghczM5MF9jY3dfZ2V0X2Rldl9pbmZvKGNkZXYsIHN5c2ZzZGV2LCAmZXJyKSkgew0K
PiAgICAgICAgIGdvdG8gb3V0X2Vycl9wcm9wYWdhdGU7DQo+ICAgICB9DQo+DQo+LS0NCj4yLjQ1
LjENCg0K

