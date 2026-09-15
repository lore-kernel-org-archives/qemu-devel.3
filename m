Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 334F9C88E75
	for <qemu-devel@archiver.kernel.org>; Tue, 15 Sep 2026 18:54:23 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1x6YHk-0001j5-Mx; Tue, 15 Sep 2026 14:53:40 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <dongwon.kim@intel.com>)
 id 1x6YHb-0001ab-1h
 for qemu-devel@nongnu.org; Tue, 15 Sep 2026 14:53:31 -0400
Received: from mgamail.intel.com ([192.198.163.15])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <dongwon.kim@intel.com>)
 id 1x6YHZ-0002ky-0j
 for qemu-devel@nongnu.org; Tue, 15 Sep 2026 14:53:30 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1789498409; x=1821034409;
 h=from:to:cc:subject:date:message-id:references:
 in-reply-to:content-transfer-encoding:mime-version;
 bh=LXpyVne+1dJfJxkbJNgbU4raenCCiMatxbirpe1Txb4=;
 b=c5MY5obrbvFviMutXYh0vqlUfXmdMQwq4555tKKNb6fAoZ3o7S2aNC0g
 8GM2WoZDU9CF10OJCm0jjbmyyF8kzrMaz6IrbbODJpN5S1tw1F9xDyFez
 ZxCvURMGsSZV4CKkdMLcmYxBjJeAPrkA9zox7JH+H0IkbpFWvnTQCS2UK
 NOc1KXnl/U7YYjaFBfoItEW+NDGonSdA6J1wXNRzh7tAJp6yFYvdbY0uY
 liVx6jKGyEghZm2++etHZ8k+t88TP9VT6yoCZWzNXdf39TmsQ651MJV6t
 R8nhprPsUGYULz1LbFI7ltT+V9IkwrVTobXAv4uv/bTxf9bASY8yYD/LZ g==;
X-CSE-ConnectionGUID: 8PeYKjN7Sbuad0NRs8lZ3A==
X-CSE-MsgGUID: gHyPqZbASBKzq4dxrLxKqw==
X-IronPort-AV: E=McAfee;i="6800,10657,11905"; a="90008836"
X-IronPort-AV: E=Sophos;i="6.27,103,1787036400"; d="scan'208";a="90008836"
Received: from orviesa006.jf.intel.com ([10.64.159.146])
 by fmvoesa109.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 15 Sep 2026 11:53:22 -0700
X-CSE-ConnectionGUID: l8EeK73gRi2f5q/5EmA2vg==
X-CSE-MsgGUID: KX3+EnBoQUuT+qx7aOtAcQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.27,103,1787036400"; d="scan'208";a="271313011"
Received: from orsmsx903.amr.corp.intel.com ([10.22.229.25])
 by orviesa006.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 15 Sep 2026 11:53:22 -0700
Received: from ORSMSX901.amr.corp.intel.com (10.22.229.23) by
 ORSMSX903.amr.corp.intel.com (10.22.229.25) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.46; Tue, 15 Sep 2026 11:53:21 -0700
Received: from ORSEDG902.ED.cps.intel.com (10.7.248.12) by
 ORSMSX901.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.46 via Frontend Transport; Tue, 15 Sep 2026 11:53:21 -0700
Received: from BN8PR05CU002.outbound.protection.outlook.com (52.101.57.42) by
 edgegateway.intel.com (134.134.137.112) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.46; Tue, 15 Sep 2026 11:53:21 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=SkmyMYndXD704p6Dz78vYAPu5bnEzjS/S5GF6+dUudwSAc1Le/Dn6IHC2ik/Yrq7rRaChRu3epj4NE3kW+ejgunBpc30g+4ZDNze/LJACG2dmLV/O2sbzKKSRtF4b2WRTP/tGylai2PmPR9nXAEWAQSFFajK2LS5Pqt8mk4z0DvssnJ3SMdqTJJb7HZKAW8q1Qd+Z+/jRBUgby/I037rm4B+9aqBLiBFZDeXtIbuAUQxTOtJzr/Hi5KE9qTZSmOadIAhna4lQyEuHLLHTCWJ4T/TyOjw5Uly0Rdjx5ZhPYMcRqdWzOPPF/wLHoZe+MFU1asiKdZEScNmm7DjTcjW2w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=LXpyVne+1dJfJxkbJNgbU4raenCCiMatxbirpe1Txb4=;
 b=T2z9o5/0i7+EJPh9SL2/CtVLzbXlzyxQJevyJrN3F8QPksLDup/qv3JYmq9iSpGKhwJIMfQUaVTPWf+jrSez9ky7mjFkhIeVBoXjdeT0i4YCMG+1PIJvxleLqTr0PtUdUA4V9lPSiLZwWFLZ8LTq2wkwBYMKv8XzYGtr0AagJVdeq12nWVPrdP4+PHO4DFmw/e9upXoTNj+A61MfH7NhEz9latA0xx3p+K6iZ6VowR0l20i1TeIPO88l2EkMlcX6dbz8j2Q6jJ2ifCdxc7r3xZlQ6ad5UI0fUkQYG0poR7Elou2haevvRfMTNS30R9UyrNr5x0hJHeV80XdEjk1kqw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Received: from PH0PR11MB5112.namprd11.prod.outlook.com (2603:10b6:510:3b::18)
 by SN7PR11MB6775.namprd11.prod.outlook.com (2603:10b6:806:264::21)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.428.9; Tue, 15 Sep
 2026 18:53:12 +0000
Received: from PH0PR11MB5112.namprd11.prod.outlook.com
 ([fe80::4307:5ef8:b6f9:44c5]) by PH0PR11MB5112.namprd11.prod.outlook.com
 ([fe80::4307:5ef8:b6f9:44c5%3]) with mapi id 15.21.0406.007; Tue, 15 Sep 2026
 18:53:09 +0000
From: "Kim, Dongwon" <dongwon.kim@intel.com>
To: =?utf-8?B?TWFyYy1BbmRyw6kgTHVyZWF1?= <marcandre.lureau@gmail.com>
CC: "qemu-devel@nongnu.org" <qemu-devel@nongnu.org>
Subject: RE: [PATCH 2/2] ui/gtk: register "Grab Input" shortcut to accel_group
Thread-Topic: [PATCH 2/2] ui/gtk: register "Grab Input" shortcut to accel_group
Thread-Index: AQHdRHn4aT4xKUCsCk29o7ezkul5RbbPc0qAgACKQ9A=
Date: Tue, 15 Sep 2026 18:53:09 +0000
Message-ID: <PH0PR11MB5112EE907640113235A6A707FABA2@PH0PR11MB5112.namprd11.prod.outlook.com>
References: <20260804090847.18871-1-dongwon.kim@intel.com>
 <20260804090847.18871-2-dongwon.kim@intel.com>
 <CAJ+F1C+T-j9qVD9sHSQdYEvw3LQYRGHo7=L4MgsaUhhZbr+LJg@mail.gmail.com>
In-Reply-To: <CAJ+F1C+T-j9qVD9sHSQdYEvw3LQYRGHo7=L4MgsaUhhZbr+LJg@mail.gmail.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: PH0PR11MB5112:EE_|SN7PR11MB6775:EE_
x-ms-office365-filtering-correlation-id: 7dbed676-b919-41ca-737e-08df135a9614
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
 ARA:13230040|376014|1800799024|23010399003|366016|6133799003|18002099003|22082099003|38070700021|10067099003|11063799006|56012099006|5023799004|4143699003;
x-microsoft-antispam-message-info: RLfjk2vY3jr1ENQqPbkYBBRi9JZxL8lBUkxViWVZfjc4Xzbg0KO0rvXZzO8eXvLG2hLjOfekqL96IbLlHuda3CbQLi6w0owA4fImViuk93KxnALJ4oH1n+Qv/WgaoMCPfPTAWEbb4VxbWmmicVvHyQQ4N4bDq34i5OS2qALk0Z/ct3O8DRrxEImxtnfuMu3vjSxRIiqPKXUlySkMyvtZOEmr6TLp37bTtm6nFv1dtka0peA2jC43jqDJ+PG3AgRX0mjrMbnWBgzM+VviB/+G2ppZZYFnoXiOM4z1tQzaoN458uDiy/wMwt8BiCLEAkKNlMs1f/qRPW9Fu+Gke8o6FRnMxoe+HwublwWEbO0P5XZe7JHtW/RPx4Y5q3Frc93yiwo8910HcXT4KeuvGrGpAH+wKMPCEA8+8X+Eid/QgxEkZIdQfWlXafWn2VgD2S9qPO+k4a714Vtr8BT7xBHUEaTZyN+PLfr87yILKG4P8hpqkhJYZUy+dYepU3gfiJqUrMqtIKUMv0qlCejWIe3q//hiGjGqds3B+rYdr5Cbzt5K4OM9wYH0cmi2tZvkJQL5UZ1mmLq9GSM7O9GoiMEfj0AbKpR4glxWpIkK4k2My/eQmeB2JwOcaogdChDkxbml+FTwdjFaeoo8YarR/Gk0bT0YMwjS5iVB7CR8bqDULWQ=
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:PH0PR11MB5112.namprd11.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(376014)(1800799024)(23010399003)(366016)(6133799003)(18002099003)(22082099003)(38070700021)(10067099003)(11063799006)(56012099006)(5023799004)(4143699003);
 DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?KzdRQzFybk5IZndtTVFaQXl2bmx5ZitiMURvTVFEWWdUMkhWTTFHVGNjeUdM?=
 =?utf-8?B?bG9uOUhEQzhZZGxoNU16dVpOSS9BdFN6aittbDdpTmVwZ3VGQ3VsczhPUnEr?=
 =?utf-8?B?VWptbS9XRkJDUVptRytmWmhxSnk3ZDNML0F5OG9lMjhFVkJURjk0WW8xTjFV?=
 =?utf-8?B?d0Zkb0dDanQyUjVLU3ZwdGN4bE14Uk9NQ3FEOUZaQkxQTndNWkRYRjdMbkVI?=
 =?utf-8?B?SXhydUR2N0ZJU01tdXBPRnIxQ1dSRVlGUTM3VFN4dlFVMUpqZTVoZDRkQXdk?=
 =?utf-8?B?bmlRNEorcVpHUGZOWEE0dEFUcHEyVHEyOEFUbXo3L3B5d1IycEpHUGdtTzJi?=
 =?utf-8?B?TzRRM29zZ29ZL21VYkcrMTBOVVJHSTRadWxFMHhiVGluZEx4TTBkbTlscjBY?=
 =?utf-8?B?OTBTK1VicXd6bEZPQW9UckR2OXNncjVFRzlDV3NiU1hEZlBKMGdvN2NtZ3Ft?=
 =?utf-8?B?akFrVkFmdjJ0bGpqMHA1VXcxQlJ5OUFiZFZYNDJsNHp5blZqWVNtQUY3ejR6?=
 =?utf-8?B?YXhmVG1qdUkxQytPODJWWHdoN25CT0tPUUNUWjVtUE93V1RnSVVJeXJRb04w?=
 =?utf-8?B?MmhNc3VzVWNqQkU5djFIallIU2VVcFJSb29kNSt4aFY4RDBELzBHb0RGaWt1?=
 =?utf-8?B?aTYxZWFXTTJINWt4THI3eVFrbUxmY3dqdUVhMXRJN2JXMmFRM0N4RjhXekpu?=
 =?utf-8?B?WkxWWUxMWUhlaGVXRVg3OWJFd1JMM254UVJhU0V1YXJHSXVrZGtvUDdRaW0x?=
 =?utf-8?B?ZmJiYTlqc2wwNG5ja0Vrc3E0UGxnT2xBVEZKRm5KYlRMeHdLY2UyRjZUVEVV?=
 =?utf-8?B?eVNlOWF1djNPT2FmMGlyQ1dxM2pid05WdHVXelRvWjIvcnRsalpiWmk3R1Nj?=
 =?utf-8?B?L0pVelU3dU8xSEJwbjI3bjBuR0laVTRGQlZ3cXEyTVNqOFE1QnVRNWRML2ky?=
 =?utf-8?B?MVoyQW9SZExmRmxlSy8wU0Jpd2ZDY3QzS3JQSkFIamFGd1BWV1REbXFZM0tj?=
 =?utf-8?B?ZCtUdktQRUNaeU52bUYxVUl5Y3BWSmlzSWZGZlhxQ3lpdkFQbVc0ZGhheE5W?=
 =?utf-8?B?dDkwM2s2cW1reUtsUUsxRng2TEpvNElRUU0wMXR1cXRoUlQwMHorOFZsSjI5?=
 =?utf-8?B?ay9uNmd0a3pHdGtZYzcySlFEUEhUNDdnazAwYnlxM3doaUsveHZOZmphZW9v?=
 =?utf-8?B?MmVrcUVCVVh5MTlWKzFETzlPS2lDZ3FJaFNEQ2NtQ1NWaXJKejRHSmdFbGkw?=
 =?utf-8?B?VkpxOHQ3Z0NkWHozTkNZMnNnMHhYaGVScVcvb1ByUnNBUGJKZXZod1phVCtI?=
 =?utf-8?B?dmJxbVl1V3llbmdQelZzVjBIZWR5ellpejkzeWxIcUxSM1l6ckswTUlBN01y?=
 =?utf-8?B?OEtPWUpEZ2Jkc2Z5ZG8ybjh4MHdOcDFpdHhyN0k4Q2hqVHp6anNTSTZXOC9G?=
 =?utf-8?B?azhieTh5WHNYZXdqYS91VTJNL2p4ZkVXcWs1YjVOM3Z0bDN0SWFsZ3cwU0ZC?=
 =?utf-8?B?VlYxOFhremh3bit2blZCQ3JQM1RyU2hzVGRvNXVXbldGUEtYVXRHTXdlS05p?=
 =?utf-8?B?NS9iaHhqVFY4emVYN0ptZjVnNUt6aHJKdDhtTitwV3diQzlzUWtKOXpTazMz?=
 =?utf-8?B?S1VXb0lURkZMSW5KWnpIMEUxd3dIL2c1bTZ5RXRPOUM3M2ZGcVRpOGhhRnBY?=
 =?utf-8?B?OVptTjA0Qnc1K2ErNFkraVJNeTVJOFZFTEZWNzVEekhqUnBvVEIzTXNyNUNQ?=
 =?utf-8?B?NVl2azhnNkRZc2x4T05FVUVpdEtXaENlSThaN3NxUDg1LzhOTUdHSnJxTzJV?=
 =?utf-8?B?aG5Ecmp0a0NXQ0pjb0ZSUFBMOC8xeWJRNDV3UzNDOS9YNndBOHlJRTI4OE10?=
 =?utf-8?B?TUkxUEJ3Wlo4bHc5WmtpZjJ1RXgxWDdVSnpNWnVxVDhkeG4xS294N2Eya1Ew?=
 =?utf-8?B?dk1jNW55TVYzSnQybjJlUjZWQXJZOHd6VU8wLzU2ZnhlcTFoWHhVdmZEbFNs?=
 =?utf-8?B?cnY4UDBKSVQ2Sk9vY3psZ21qQlJJWWp5bkpCbGhoWDBwL1F5V0NMY3FvL1BT?=
 =?utf-8?B?bGc1WlkreFVzbElRVUVLWmNTSXB6UHc0bkdndTA1UjEzazg3dUZCcjlUczdG?=
 =?utf-8?B?REJjd3ozVWRIczBiRWNiek9qa0xHMXhQMWRFZldRd2piUkszM2dWRG13UHJ6?=
 =?utf-8?B?ZkFsYlRJTUoycGxiWVhaWjdEQkhyTjV4TXhCOFJkaEJZTWNxeVMvNi9ycFFP?=
 =?utf-8?B?Si9PRUVHK1ZaWXdVVTFsc0RvL085NU00Y2FWNTlEYWEvNFZVRzlXc3k5RTJt?=
 =?utf-8?Q?qKPsmlJ78dmxLZ7Z+b?=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-Exchange-RoutingPolicyChecked: sTsFpF3v98ejk2UmLKr4iS8HsSHSsomVEINKz6atC3L58MXqoXaHTXnnggep4+hLY7SiMES759se5Ll21vPcUIfGCCbRvXBN63OdeSJDkmElZ7FJlE4zvQIgHlmfSlaJCbALN+NvrmzzA6JDNTXiGVcngu5Hd508Rb1gDw3QdDTSIVqk8stw9Z0PjnfYRt344DIO4m2aiweuVS7/pY8BxSYzHne4unL/tFCAHRVom8+bhVV/6lLtxgZ0YlobsqpwmLyLrCRf1TS+TvlDo1jb54YFj4PE8MGO+7tTU0gNxZH40b6K/aVkkoezw4e/5Ppsxa8QCZ5tNCFIyXIqPI1yVA==
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: PH0PR11MB5112.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 7dbed676-b919-41ca-737e-08df135a9614
X-MS-Exchange-CrossTenant-originalarrivaltime: 15 Sep 2026 18:53:09.5458 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: WMKBfmZmjlU32MhItb9upXiLX1higXR4EhPrpQOtGoza4FYkfPbisfCLcR/5nbqnOHYMn+TNH73iFX+wsz6KJQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SN7PR11MB6775
X-OriginatorOrg: intel.com
Received-SPF: pass client-ip=192.198.163.15;
 envelope-from=dongwon.kim@intel.com; helo=mgamail.intel.com
X-Spam_score_int: -43
X-Spam_score: -4.4
X-Spam_bar: ----
X-Spam_report: (-4.4 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_MED=-2.3, SPF_HELO_NONE=0.001,
 SPF_NONE=0.001 autolearn=ham autolearn_force=no
X-Spam_action: no action
X-BeenThere: qemu-devel@nongnu.org
X-Mailman-Version: 2.1.29
Precedence: list
List-Id: qemu development <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <https://lists.nongnu.org/archive/html/qemu-devel>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=subscribe>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org

SGkgTWFyYy1BbmRyw6ksDQoNCj4gU3ViamVjdDogUmU6IFtQQVRDSCAyLzJdIHVpL2d0azogcmVn
aXN0ZXIgIkdyYWIgSW5wdXQiIHNob3J0Y3V0IHRvIGFjY2VsX2dyb3VwDQo+IA0KPiBIaQ0KPiAN
Cj4gT24gTW9uLCBTZXAgMTQsIDIwMjYgYXQgMTA6NTHigK9QTSA8ZG9uZ3dvbi5raW1AaW50ZWwu
Y29tPiB3cm90ZToNCj4gPg0KPiA+IEZyb206IERvbmd3b24gS2ltIDxkb25nd29uLmtpbUBpbnRl
bC5jb20+DQo+ID4NCj4gPiBUaGUgIkdyYWIgSW5wdXQiIHNob3J0Y3V0IGtleSBjdXJyZW50bHkg
ZmFpbHMgdG8gdHJpZ2dlciB3aGVuIHRoZQ0KPiA+IHdpbmRvdyBpcyBpbiBmdWxsc2NyZWVuIG1v
ZGUgYmVjYXVzZSB0aGUgbWVudWJhciBpcyBoaWRkZW4sIHdoaWNoDQo+ID4gZGlzYWJsZXMgR3Rr
QWNjZWxNYXAtYmFzZWQgc2hvcnRjdXRzIGFzc29jaWF0ZWQgd2l0aCBpdC4NCj4gPg0KPiA+IFRv
IGVuc3VyZSB0aGUgYWNjZWxlcmF0b3IgcmVtYWlucyBhY3RpdmUgaW4gZnVsbHNjcmVlbiwgY29u
bmVjdCBpdA0KPiA+IGRpcmVjdGx5IHRvIHMtPmFjY2VsX2dyb3VwIGFuZCBleHBsaWNpdGx5IHNl
dCB0aGUgaG90a2V5IGRpc3BsYXkgb24NCj4gPiB0aGUgbWVudSBpdGVtIGxhYmVsLg0KPiA+DQo+
ID4gQ2M6IE1hcmMtQW5kcsOpIEx1cmVhdSA8bWFyY2FuZHJlLmx1cmVhdUByZWRoYXQuY29tPg0K
PiA+IFNpZ25lZC1vZmYtYnk6IERvbmd3b24gS2ltIDxkb25nd29uLmtpbUBpbnRlbC5jb20+DQo+
ID4gLS0tDQo+ID4gIHVpL2d0ay5jIHwgMjAgKysrKysrKysrKysrKysrLS0tLS0NCj4gPiAgMSBm
aWxlIGNoYW5nZWQsIDE1IGluc2VydGlvbnMoKyksIDUgZGVsZXRpb25zKC0pDQo+ID4NCj4gPiBk
aWZmIC0tZ2l0IGEvdWkvZ3RrLmMgYi91aS9ndGsuYw0KPiA+IGluZGV4IDNjOTcyMGEzMzAuLjJm
ODNjNTU3ZDggMTAwNjQ0DQo+ID4gLS0tIGEvdWkvZ3RrLmMNCj4gPiArKysgYi91aS9ndGsuYw0K
PiA+IEBAIC0xODc4LDYgKzE4NzgsMTIgQEAgc3RhdGljIHZvaWQgZ2RfbWVudV9ncmFiX2lucHV0
KEd0a01lbnVJdGVtDQo+ICppdGVtLCB2b2lkICpvcGFxdWUpDQo+ID4gICAgICBnZF91cGRhdGVf
Y3Vyc29yKHZjKTsNCj4gPiAgfQ0KPiA+DQo+ID4gK3N0YXRpYyB2b2lkIGdkX2FjY2VsX2dyYWJf
aW5wdXQodm9pZCAqb3BhcXVlKSB7DQo+IA0KPiBodHRwczovL2RvY3MuZ3RrLm9yZy9ndGszL21l
dGhvZC5BY2NlbEdyb3VwLmNvbm5lY3QuaHRtbA0KPiBUaGUgc2lnbmF0dXJlIHVzZWQgZm9yIHRo
ZSBjbG9zdXJlIGlzIHRoYXQgb2YgR3RrQWNjZWxHcm91cEFjdGl2YXRlLg0KPiANCj4gVGhpcyBt
ZWFucyB0aGF0IG90aGVyIGtleSBldmVudHMgY291bGQgcG90ZW50aWFsbHkgYmUgdHJpZ2dlcmVk
LiBJdCBzaG91bGQNCj4gcmV0dXJuIHRydWUgKGhhbmRsZWQpLg0KDQpZZWFoIFRoaXMgd2lsbCBi
ZSB1cGRhdGVkIGluIHYyLiANCg0KVGhhbmtzLA0KRFcNCg0KPiANCj4gDQo+ID4gKyAgICBHdGtE
aXNwbGF5U3RhdGUgKnMgPSBvcGFxdWU7DQo+ID4gKyAgICBndGtfbWVudV9pdGVtX2FjdGl2YXRl
KEdUS19NRU5VX0lURU0ocy0+Z3JhYl9pdGVtKSk7DQo+ID4gK30NCj4gPiArDQo+ID4gIHN0YXRp
YyB2b2lkIGdkX2NoYW5nZV9wYWdlKEd0a05vdGVib29rICpuYiwgZ3BvaW50ZXIgYXJnMSwgZ3Vp
bnQgYXJnMiwNCj4gPiAgICAgICAgICAgICAgICAgICAgICAgICAgICAgZ3BvaW50ZXIgZGF0YSkg
IHsgQEAgLTI1NTcsNiArMjU2Myw3IEBADQo+ID4gc3RhdGljIHZvaWQgZ2RfY3JlYXRlX21lbnVf
dmlldyhHdGtEaXNwbGF5U3RhdGUgKnMsIERpc3BsYXlPcHRpb25zDQo+ID4gKm9wdHMpICB7DQo+
ID4gICAgICBHdGtXaWRnZXQgKnZpZXdfbWVudTsNCj4gPiAgICAgIEd0a1dpZGdldCAqc2VwYXJh
dG9yOw0KPiA+ICsgICAgR3RrV2lkZ2V0ICpjaGlsZDsNCj4gPiAgICAgIFFlbXVDb25zb2xlICpj
b247DQo+ID4gICAgICBib29sIHpvb21fdG9fZml0ID0gZmFsc2U7DQo+ID4gICAgICBpbnQgdmMs
IGk7DQo+ID4gQEAgLTI2MTUsMTIgKzI2MjIsMTUgQEAgc3RhdGljIHZvaWQNCj4gZ2RfY3JlYXRl
X21lbnVfdmlldyhHdGtEaXNwbGF5U3RhdGUgKnMsIERpc3BsYXlPcHRpb25zICpvcHRzKQ0KPiA+
ICAgICAgZ3RrX21lbnVfc2hlbGxfYXBwZW5kKEdUS19NRU5VX1NIRUxMKHZpZXdfbWVudSksDQo+
ID4gcy0+Z3JhYl9vbl9ob3Zlcl9pdGVtKTsNCj4gPg0KPiA+ICAgICAgcy0+Z3JhYl9pdGVtID0g
Z3RrX2NoZWNrX21lbnVfaXRlbV9uZXdfd2l0aF9tbmVtb25pYyhfKCJfR3JhYg0KPiBJbnB1dCIp
KTsNCj4gPiAtICAgIGd0a19tZW51X2l0ZW1fc2V0X2FjY2VsX3BhdGgoR1RLX01FTlVfSVRFTShz
LT5ncmFiX2l0ZW0pLA0KPiA+IC0gICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAiPFFF
TVU+L1ZpZXcvR3JhYiBJbnB1dCIpOw0KPiA+IC0gICAgZ3RrX2FjY2VsX21hcF9hZGRfZW50cnko
IjxRRU1VPi9WaWV3L0dyYWIgSW5wdXQiLCBHREtfS0VZX2csDQo+ID4gLSAgICAgICAgICAgICAg
ICAgICAgICAgICAgICBIT1RLRVlfTU9ESUZJRVJTKTsNCj4gPiAgICAgIGd0a19tZW51X3NoZWxs
X2FwcGVuZChHVEtfTUVOVV9TSEVMTCh2aWV3X21lbnUpLCBzLT5ncmFiX2l0ZW0pOw0KPiA+IC0N
Cj4gPiArICAgIGd0a19hY2NlbF9ncm91cF9jb25uZWN0KHMtPmFjY2VsX2dyb3VwLCBHREtfS0VZ
X2csDQo+IEhPVEtFWV9NT0RJRklFUlMsIDAsDQo+ID4gKyAgICAgICAgICAgICAgICAgICAgICAg
ICAgICBnX2NjbG9zdXJlX25ld19zd2FwKEdfQ0FMTEJBQ0soZ2RfYWNjZWxfZ3JhYl9pbnB1dCks
DQo+ID4gKyAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgIHMs
IE5VTEwpKTsNCj4gPiArICAgIGNoaWxkID0gZ3RrX2Jpbl9nZXRfY2hpbGQoR1RLX0JJTihzLT5n
cmFiX2l0ZW0pKTsNCj4gPiArICAgIGlmIChHVEtfSVNfQUNDRUxfTEFCRUwoY2hpbGQpKSB7DQo+
ID4gKyAgICAgICAgZ3RrX2FjY2VsX2xhYmVsX3NldF9hY2NlbChHVEtfQUNDRUxfTEFCRUwoY2hp
bGQpLA0KPiA+ICsgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgR0RLX0tFWV9nLCBI
T1RLRVlfTU9ESUZJRVJTKTsNCj4gPiArICAgIH0NCj4gPiAgICAgIHNlcGFyYXRvciA9IGd0a19z
ZXBhcmF0b3JfbWVudV9pdGVtX25ldygpOw0KPiA+ICAgICAgZ3RrX21lbnVfc2hlbGxfYXBwZW5k
KEdUS19NRU5VX1NIRUxMKHZpZXdfbWVudSksIHNlcGFyYXRvcik7DQo+ID4NCj4gPiAtLQ0KPiA+
IDIuNDMuMA0KPiA+DQo+ID4NCj4gDQo+IA0KPiAtLQ0KPiBNYXJjLUFuZHLDqSBMdXJlYXUNCg==

