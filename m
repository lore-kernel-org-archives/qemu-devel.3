Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 276F6CD1284
	for <qemu-devel@archiver.kernel.org>; Fri, 29 Mar 2024 02:04:36 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rq1bK-0000PZ-TZ; Thu, 28 Mar 2024 22:04:14 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <yuan1.liu@intel.com>)
 id 1rq1bI-0000PB-Ay
 for qemu-devel@nongnu.org; Thu, 28 Mar 2024 22:04:12 -0400
Received: from mgamail.intel.com ([192.198.163.17])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <yuan1.liu@intel.com>)
 id 1rq1bE-0006rv-WF
 for qemu-devel@nongnu.org; Thu, 28 Mar 2024 22:04:12 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1711677849; x=1743213849;
 h=from:to:cc:subject:date:message-id:references:
 in-reply-to:content-transfer-encoding:mime-version;
 bh=CfDRgrHEVJbKqvZtfNMMpWmHKDzV0zD1e9G8VBTrVdY=;
 b=gaWfQdnvp2pA9qfGpp6Ixs7kr6DCbFf6K3BW/GcXyfkm+ufDxJPKnA47
 OoTahZwrJ5yDgnNWg3URkEA6V6UtZ2T/ts8E0BvUA23X5HO8Xf+MsE4gN
 gdhXwVM4Jvjdm3TobzbtUzqxPldocwRapIR81W4v4YQ4BuxrG4GfIMk6z
 RVjbmQ3q+UPN26v+YONlRkN2ABv5SWJp3eUoO0aWA4t94T3PViKvoZlSX
 xWYvv0S2fi8mPmv9BOI+ppiMd4v9ZoVDL+rZbhv6rxIb2YwKF3nwHOvMV
 AxxbUGrvpfxckkwYqoerKOOZTB9OzfQ5Gsu6K82XVNP2a/IVTrVc07L/n g==;
X-CSE-ConnectionGUID: hPcANLywSB6/x5bbts14qw==
X-CSE-MsgGUID: QIQjNiGVQbO6kcMh/43QoQ==
X-IronPort-AV: E=McAfee;i="6600,9927,11027"; a="6728321"
X-IronPort-AV: E=Sophos;i="6.07,162,1708416000"; 
   d="scan'208";a="6728321"
Received: from orviesa004.jf.intel.com ([10.64.159.144])
 by fmvoesa111.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 28 Mar 2024 19:04:04 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.07,162,1708416000"; d="scan'208";a="21580427"
Received: from fmsmsx601.amr.corp.intel.com ([10.18.126.81])
 by orviesa004.jf.intel.com with ESMTP/TLS/AES256-GCM-SHA384;
 28 Mar 2024 19:04:03 -0700
Received: from fmsmsx612.amr.corp.intel.com (10.18.126.92) by
 fmsmsx601.amr.corp.intel.com (10.18.126.81) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35; Thu, 28 Mar 2024 19:04:02 -0700
Received: from fmsmsx612.amr.corp.intel.com (10.18.126.92) by
 fmsmsx612.amr.corp.intel.com (10.18.126.92) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35; Thu, 28 Mar 2024 19:04:02 -0700
Received: from FMSEDG603.ED.cps.intel.com (10.1.192.133) by
 fmsmsx612.amr.corp.intel.com (10.18.126.92) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35 via Frontend Transport; Thu, 28 Mar 2024 19:04:02 -0700
Received: from NAM11-CO1-obe.outbound.protection.outlook.com (104.47.56.168)
 by edgegateway.intel.com (192.55.55.68) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.35; Thu, 28 Mar 2024 19:04:02 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=YoME6iSepmkwygha5xhQYsxozYQxRdWX1gqPQx8D4sQSiCDkayVzAIbFquf9UmxRvStx68p4GDgMAmcCsZin6aOZgcqiNi0+VhNcRr9uV0bwYfInSnm7euuEvaIABdKJ/PMD9K0dVlII4uuVH75yvnLv0b+GhioPqZsZzoSzJSYUss1Z2P3TQG+QCGtS62wcTbD7LDDJj3FQaI/HgWzCnDE06/XZQmcY+G1lodhwFgfOLaIfvvKcInGY0UqHBJeqjHJvjGtXgn8DFujx+bz9IardkvMqyDhkRmEwh7nuM54Qdc1Xl6pod4lxGzU+8ASobQRsH664P/6vA1d+mhRfDg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=CfDRgrHEVJbKqvZtfNMMpWmHKDzV0zD1e9G8VBTrVdY=;
 b=Hhs8xonEyKddnbizyA2VeBNmFHlSH5GW+kfCZsYCISpO4u5KUt3/2sG+AFCxMbGIv6lRCWNuwMkvK7+vW7oaNuFr3IstYczTgX82uWKfgKeKTjD/0iDuwWpgbahy5+LQW9BXLE6iHMeRooptmrADYfyJbk2K3S6IpBpUlhP65ByJ+YeO5jWSQpriiyerWe7w5+icQiyQsXZihb0kXrVatCeKqcDSE3V/BCs/9byzWwilFbaPeNhEpMawetsbNr6TETEC0JRy/QELFhVrORzpcLrkvuf2+pmfJAaCMgM0zMijv8e0XVeGR5p43dzVhcWm42JsixJVDuZCkk89Z/9pew==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Received: from PH7PR11MB5941.namprd11.prod.outlook.com (2603:10b6:510:13d::20)
 by PH7PR11MB8454.namprd11.prod.outlook.com (2603:10b6:510:30c::5)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7409.40; Fri, 29 Mar
 2024 02:04:00 +0000
Received: from PH7PR11MB5941.namprd11.prod.outlook.com
 ([fe80::f926:1804:73ce:ca52]) by PH7PR11MB5941.namprd11.prod.outlook.com
 ([fe80::f926:1804:73ce:ca52%4]) with mapi id 15.20.7409.010; Fri, 29 Mar 2024
 02:04:00 +0000
From: "Liu, Yuan1" <yuan1.liu@intel.com>
To: Peter Xu <peterx@redhat.com>
CC: =?utf-8?B?RGFuaWVsIFAuIEJlcnJhbmfDqQ==?= <berrange@redhat.com>,
 "farosas@suse.de" <farosas@suse.de>, "qemu-devel@nongnu.org"
 <qemu-devel@nongnu.org>, "hao.xiang@bytedance.com" <hao.xiang@bytedance.com>, 
 "bryan.zhang@bytedance.com" <bryan.zhang@bytedance.com>, "Zou, Nanhai"
 <nanhai.zou@intel.com>
Subject: RE: [PATCH v5 5/7] migration/multifd: implement initialization of qpl
 compression
Thread-Topic: [PATCH v5 5/7] migration/multifd: implement initialization of
 qpl compression
Thread-Index: AQHaeqFFcriI4s02jkWbmxh5d6Bh27FAcVgAgABDk6CAAA4OAIAACKEggABKaQCAAFH34IAA63wAgACmUnCAANqGYIAAJb8AgAgJ4oCAAGvF4IAA4LwAgAC0J5A=
Date: Fri, 29 Mar 2024 02:04:00 +0000
Message-ID: <PH7PR11MB594123F7EEFEBFCE219AF100A33A2@PH7PR11MB5941.namprd11.prod.outlook.com>
References: <ZfsCDhnYYmjxLTRW@x1n>
 <PH7PR11MB5941F8AE52DBD0F197798103A3332@PH7PR11MB5941.namprd11.prod.outlook.com>
 <ZftHtgpxOPNA8AYE@x1n>
 <PH7PR11MB5941186DCF12ED13130CBF5FA3322@PH7PR11MB5941.namprd11.prod.outlook.com>
 <ZfxSAgJECCOqtGRh@x1n>
 <PH7PR11MB594128C3B1C9ED66482DFEDEA3312@PH7PR11MB5941.namprd11.prod.outlook.com>
 <PH7PR11MB5941B5EB0C21FBFB6C8FFA16A3312@PH7PR11MB5941.namprd11.prod.outlook.com>
 <Zf20gJbSavpp93_b@x1n> <ZgRyxy3MhFp7PiH9@x1n>
 <PH7PR11MB59417CED1514B574523D6B1CA33B2@PH7PR11MB5941.namprd11.prod.outlook.com>
 <ZgWJtFtbpXDvelvh@x1n>
In-Reply-To: <ZgWJtFtbpXDvelvh@x1n>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: PH7PR11MB5941:EE_|PH7PR11MB8454:EE_
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: suPA9EbKdKr/fW6Uvjk3J2snh0SR/5/t1jzgbsjFM29D36HUvqcl8GWxCwwQ30FsOTNoelm7d6hut78hwJ358Mh//kEx7Mzo7lqZU6uMd9r6DVUj4boKXHxarxPu5HXRM9kY0hL33ZCws9FCT/45Hafz0vztqNaUYokNcSKm0tYy//xeApVSjqWwJ2CbCpDjhgWk7tdPOyzuCCqOIM5Nr8A17hDrubdv35TG9siOcd1sEMh+7+j4uRqYTaMTCkAIVeAY2aiikzjFDQ+3LNB7hzCIECzVgpCrTX3Itv9ezARaU7Bq9yHKuDAsR46LSh9FhPTYAQQaJaoY2PL7zDb1EtbkhG3pMZZQ/oVI7KmL9D5TcC4gcdQPUd5aDVhx+vBZCdwSUVkqMbgTF7sfh/CbcwoohhVDwmA/EopxA+hfa+jVwfayYbAcfFhyuQBW+FuVJWXr9UMExkb+LaxGhVj6L+x5Ho/YBt4eWUIUPEyuTsxjnpUzTC1IpqLXdDE5H45gEuvtRbbVHOYqAQWLQDBEMMgBJNTOQLjiAZQJoHSSL6XtG38rI6DOkbU4AO5gJqRAvegT5a/Yz51YJuE5M6x6P41vBlYMivZ5DwMOBAFG48s=
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:PH7PR11MB5941.namprd11.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230031)(376005)(1800799015)(366007); DIR:OUT; SFP:1102; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?VlVmODdlZ0R1RkxhaU5IODZReXFtVzVwcmJMc1BJRzc4VXNpbnkySnNJUVFU?=
 =?utf-8?B?YXY0cTRabHlVblplczluNUhUL1Z0cTZEZitENS80TkdQa2pYcEE2Uk5qQXdr?=
 =?utf-8?B?NHJTZGcrN0dmaTJTRTBRZ0VZeU4ycHJKSzlCVnJQVjRqNDRHT1gyS09SNW5M?=
 =?utf-8?B?UWJTblNmOTNWaEJ0T1FxN1V1d3BUYm5LdWlJb3pZMEgxdUV5Y2dRUVRYN094?=
 =?utf-8?B?WUk0RlpZZ0RrbGo5K215NDNCMUVvUFVvTG9xSlpLYW5TdTh6VEVNbmVYcVRk?=
 =?utf-8?B?b3hCRVUrdTBvK0YrSXM2VnNrc1Rra1hEZEs1VmhsbkdUSWlDYm91ZE02bTJ3?=
 =?utf-8?B?ZDZxb2dabWRyUmlycG9EMlFFTnNhTjlJMTZtNjI0QjJtamdWdWh5NFFOOVcv?=
 =?utf-8?B?QSsrQzRxdTJyazRHd1RMM0pua3NSS1JuYWlaUStPRnhoV1VJbFBJN2FRNmRw?=
 =?utf-8?B?dmZ3MU1SQWxOc3o5VGdhQ1FHc2krQTI5elhFSWRFTlgrT292Z0phQTBUMi9U?=
 =?utf-8?B?NTdrVmR0VXJkVjcwL0x3Z0lwR1FqUW5nZU9MQTkyUW9HaDJNZ3BxVDhNajJz?=
 =?utf-8?B?bXEvSzZYM0hETzI5WG9uOWxHSkRZWWFsY2h4aUVEMytFT2pnS0F4cHBJdUFa?=
 =?utf-8?B?Z29HeXBsMXJ5Y25WUU1KKzJuY0g1ZXNwRWlZaG5aOUN4S3gyTjFDaWUxaDZU?=
 =?utf-8?B?SlpwK3RPWGhmVDhZcnFOM3lRRmFRWHYzYWh1Mnc1dys5ZDN3cEVDb0Jldkd3?=
 =?utf-8?B?ZDdaQUVyOElEUEZOcjZ1dktxSUw2SVNQenVNYkFmTFJMdkxTU0F4WGhIRjdi?=
 =?utf-8?B?RHZFUmdUdVdycjh5QUZ4bCtoWUFHWGFmMU9OQ1ZMVXBDdzlRZEdNNDE5QWo2?=
 =?utf-8?B?cEQ3MmYvVnJtc2YzNlErNkpKdTdHT1NMTXIreHdvTk8yV0VWSE1KVnZ1Qm5D?=
 =?utf-8?B?akcyVXErdHBXM29KMWlsMVBKak5uRUJTdXZyWXRwMit0OFlWVlFkdTVqZVpl?=
 =?utf-8?B?TlhwakFSL0I0ZEowN3NuREM0SWFJQmZhSGluRW9wNXkwb3lzWjhqNEpsNkRp?=
 =?utf-8?B?UThPbG14OEt1ZjZRcWhuaGxPQjFuMlQ4KzVoNUs0TkRiZjlZOUlPV0txS3Fp?=
 =?utf-8?B?TWd0QUJlUXRmT1F5M3E2dlkvVEU1VmNITGhzVkw5YWZ1MHl5TkNOUTc2aE1t?=
 =?utf-8?B?T29rRDJHeFBCZHY1VkZLbWcyN1lOZzBEVWN0K1c0UkZiczB4QWNvWWFUR0Jr?=
 =?utf-8?B?U2NvMjFRY29ZdTBZR2FodDBrRkNRTEE3THFqMUlMelByUm1WQ1NVWlh1bGpI?=
 =?utf-8?B?SWN1S1pWQjJHYTVybTdDQjY5aW9MdnNldjJwTFF4dGpvNVhwVlFLdEJqNFZr?=
 =?utf-8?B?cTBjc2FJMjFNRS9DNWhCK1p5a2xQK2pPZDBoMFhGeHZIMTgvcGg3WVMySGEw?=
 =?utf-8?B?WldBb3BiaWgySlJ0dUptelRSa2J4QkoxQmsxODdCYkZwVVJVNkJBMHlsbWNK?=
 =?utf-8?B?WUN4eWlBdHRTNDhqaXV5MENFSGJXc0NLYm9kbUlyL2xRa1ZCSUVnZzlVcUxZ?=
 =?utf-8?B?SjlrZnJ3Nm1RaThHWUtHU3R4Z3pxWm5yMG52dzg2OTYvY0VacjFBdktBMUlS?=
 =?utf-8?B?Y0hXbVplNVlUbXJwRDZ1czdta2dsNWJkSURWNGJFR0lGazZYMCtXSWxZR2tx?=
 =?utf-8?B?VUEyN21aUEdSNU1vZ2Z3VEpLRFBRdDJrOUdXaE5pakRLQmlmaTM4ZjErOHJG?=
 =?utf-8?B?eDFhR3poQkFubkVqN29mMG1uTnFhdU14YzZjS0ExWHV3clJGbysxNmlrNzZZ?=
 =?utf-8?B?blI5UkIrcHVaTGlsMDZReFF1Q1h0L0JwM1VGcDhlNkJlSVVZS3BCT2RTSE1j?=
 =?utf-8?B?Qy9QZ3dUS2IzbVpKd09abVljMGlNN0l2cjBOaWpENFl2eGVrbU1rRy9tQVhs?=
 =?utf-8?B?NE5GSVd2RnZrN2xSZXRxU3VlcjhVd1ZKSDlkQmFieW1OR2Y0TXNFOU9RZW9t?=
 =?utf-8?B?K1pydFp0MEptcjhtUE8zRzFua0FmanAyTGVzNDRqQWlwVXZmZzk4N3drcVAz?=
 =?utf-8?B?c1JNTWNNNnpabzJERDBwYzc5Yi84WkhkOXR3eVk0ME5SWmdNVm9tRFdLZW1W?=
 =?utf-8?Q?43TXl/x7sBJ5/cIISi9jl24fO?=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: PH7PR11MB5941.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: b6bea1af-d148-4145-e74c-08dc4f947ff7
X-MS-Exchange-CrossTenant-originalarrivaltime: 29 Mar 2024 02:04:00.0407 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: gOavhzeoT8P6ga5Fg3NliRrqxRWwI9Uo3KZSEZB3ntmC7Ngjpu3gAssPD0IG1lxitF+R6AyFDg8L10V6CIQYlA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH7PR11MB8454
X-OriginatorOrg: intel.com
Received-SPF: pass client-ip=192.198.163.17; envelope-from=yuan1.liu@intel.com;
 helo=mgamail.intel.com
X-Spam_score_int: -28
X-Spam_score: -2.9
X-Spam_bar: --
X-Spam_report: (-2.9 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.08,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_LOW=-0.7, SPF_HELO_NONE=0.001,
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

PiAtLS0tLU9yaWdpbmFsIE1lc3NhZ2UtLS0tLQ0KPiBGcm9tOiBQZXRlciBYdSA8cGV0ZXJ4QHJl
ZGhhdC5jb20+DQo+IFNlbnQ6IFRodXJzZGF5LCBNYXJjaCAyOCwgMjAyNCAxMToxNiBQTQ0KPiBU
bzogTGl1LCBZdWFuMSA8eXVhbjEubGl1QGludGVsLmNvbT4NCj4gQ2M6IERhbmllbCBQLiBCZXJy
YW5nw6kgPGJlcnJhbmdlQHJlZGhhdC5jb20+OyBmYXJvc2FzQHN1c2UuZGU7IHFlbXUtDQo+IGRl
dmVsQG5vbmdudS5vcmc7IGhhby54aWFuZ0BieXRlZGFuY2UuY29tOyBicnlhbi56aGFuZ0BieXRl
ZGFuY2UuY29tOyBab3UsDQo+IE5hbmhhaSA8bmFuaGFpLnpvdUBpbnRlbC5jb20+DQo+IFN1Ympl
Y3Q6IFJlOiBbUEFUQ0ggdjUgNS83XSBtaWdyYXRpb24vbXVsdGlmZDogaW1wbGVtZW50IGluaXRp
YWxpemF0aW9uIG9mDQo+IHFwbCBjb21wcmVzc2lvbg0KPiANCj4gT24gVGh1LCBNYXIgMjgsIDIw
MjQgYXQgMDI6MzI6MzdBTSArMDAwMCwgTGl1LCBZdWFuMSB3cm90ZToNCj4gPiA+IC0tLS0tT3Jp
Z2luYWwgTWVzc2FnZS0tLS0tDQo+ID4gPiBGcm9tOiBQZXRlciBYdSA8cGV0ZXJ4QHJlZGhhdC5j
b20+DQo+ID4gPiBTZW50OiBUaHVyc2RheSwgTWFyY2ggMjgsIDIwMjQgMzoyNiBBTQ0KPiA+ID4g
VG86IExpdSwgWXVhbjEgPHl1YW4xLmxpdUBpbnRlbC5jb20+DQo+ID4gPiBDYzogRGFuaWVsIFAu
IEJlcnJhbmfDqSA8YmVycmFuZ2VAcmVkaGF0LmNvbT47IGZhcm9zYXNAc3VzZS5kZTsgcWVtdS0N
Cj4gPiA+IGRldmVsQG5vbmdudS5vcmc7IGhhby54aWFuZ0BieXRlZGFuY2UuY29tOyBicnlhbi56
aGFuZ0BieXRlZGFuY2UuY29tOw0KPiBab3UsDQo+ID4gPiBOYW5oYWkgPG5hbmhhaS56b3VAaW50
ZWwuY29tPg0KPiA+ID4gU3ViamVjdDogUmU6IFtQQVRDSCB2NSA1LzddIG1pZ3JhdGlvbi9tdWx0
aWZkOiBpbXBsZW1lbnQNCj4gaW5pdGlhbGl6YXRpb24gb2YNCj4gPiA+IHFwbCBjb21wcmVzc2lv
bg0KPiA+ID4NCj4gPiA+IE9uIEZyaSwgTWFyIDIyLCAyMDI0IGF0IDEyOjQwOjMyUE0gLTA0MDAs
IFBldGVyIFh1IHdyb3RlOg0KPiA+ID4gPiA+ID4gdm9pZCBtdWx0aWZkX3JlY3ZfemVyb19wYWdl
X3Byb2Nlc3MoTXVsdGlGRFJlY3ZQYXJhbXMgKnApDQo+ID4gPiA+ID4gPiB7DQo+ID4gPiA+ID4g
PiAgICAgZm9yIChpbnQgaSA9IDA7IGkgPCBwLT56ZXJvX251bTsgaSsrKSB7DQo+ID4gPiA+ID4g
PiAgICAgICAgIHZvaWQgKnBhZ2UgPSBwLT5ob3N0ICsgcC0+emVyb1tpXTsNCj4gPiA+ID4gPiA+
ICAgICAgICAgaWYgKCFidWZmZXJfaXNfemVybyhwYWdlLCBwLT5wYWdlX3NpemUpKSB7DQo+ID4g
PiA+ID4gPiAgICAgICAgICAgICBtZW1zZXQocGFnZSwgMCwgcC0+cGFnZV9zaXplKTsNCj4gPiA+
ID4gPiA+ICAgICAgICAgfQ0KPiA+ID4gPiA+ID4gICAgIH0NCj4gPiA+ID4gPiA+IH0NCj4gPiA+
ID4NCj4gPiA+ID4gSXQgbWF5IG5vdCBtYXR0ZXIgbXVjaCAod2hlcmUgSSBhbHNvIHNlZSB5b3Vy
IGJlbG93IGNvbW1lbnRzKSwgYnV0DQo+IGp1c3QNCj4gPiA+IHRvDQo+ID4gPiA+IG1lbnRpb24g
YW5vdGhlciBzb2x1dGlvbiB0byBhdm9pZCB0aGlzIHJlYWQgaXMgdGhhdCB3ZSBjYW4gbWFpbnRh
aW4NCj4gPiA+ID4gUkFNQmxvY2stPnJlY2VpdmVkbWFwIGZvciBwcmVjb3B5IChlc3BlY2lhbGx5
LCBtdWx0aWZkLCBhZmFpdQ0KPiBtdWx0aWZkDQo+ID4gPiA+IGRvZXNuJ3QgeWV0IHVwZGF0ZSB0
aGlzIGJpdG1hcC4uIGV2ZW4gaWYgbm9ybWFsIHByZWNvcHkgZG9lcyksIHRoZW4NCj4gaGVyZQ0K
PiA+ID4gPiBpbnN0ZWFkIG9mIHNjYW5uaW5nIGV2ZXJ5IHRpbWUsIG1heWJlIHdlIGNhbiBkbzoN
Cj4gPiA+ID4NCj4gPiA+ID4gICAvKg0KPiA+ID4gPiAgICAqIElmIGl0J3MgdGhlIDFzdCB0aW1l
IHJlY2VpdmluZyBpdCwgbm8gbmVlZCB0byBjbGVhciBpdCBhcyBpdA0KPiBtdXN0DQo+ID4gPiBi
ZQ0KPiA+ID4gPiAgICAqIGFsbCB6ZXJvcyBub3cuDQo+ID4gPiA+ICAgICovDQo+ID4gPiA+ICAg
aWYgKGJpdG1hcF90ZXN0KHJiLT5yZWNlaXZlZG1hcCwgcGFnZV9vZmZzZXQpKSB7DQo+ID4gPiA+
ICAgICAgIG1lbXNldChwYWdlLCAwLCAuLi4pOw0KPiA+ID4gPiAgIH0gZWxzZSB7DQo+ID4gPiA+
ICAgICAgIGJpdG1hcF9zZXQocmItPnJlY2VpdmVkbWFwLCBwYWdlX29mZnNldCk7DQo+ID4gPiA+
ICAgfQ0KPiA+ID4gPg0KPiA+ID4gPiBBbmQgd2UgYWxzbyBhbHdheXMgc2V0IHRoZSBiaXQgd2hl
biAhemVybyB0b28uDQo+ID4gPiA+DQo+ID4gPiA+IE15IHJhdGlvbmFsIGlzIHRoYXQgaXQncyB1
bmxpa2VseSBhIHplcm8gcGFnZSBpZiBpdCdzIHNlbnQgb25jZSBvcg0KPiBtb3JlLA0KPiA+ID4g
PiB3aGlsZSBPVE9IIGZvciB0aGUgMXN0IHRpbWUgd2UgcmVjZWl2ZSBpdCwgaXQgbXVzdCBiZSBh
IHplcm8gcGFnZSwNCj4gc28gbm8NCj4gPiA+ID4gbmVlZCB0byBzY2FuIGZvciB0aGUgMXN0IHJv
dW5kLg0KPiA+ID4NCj4gPiA+IFRoaW5raW5nIGFib3V0IHRoaXMsIEknbSB3b25kZXJpbmcgd2hl
dGhlciB3ZSBzaG91bGQgaGF2ZSB0aGlzDQo+IHJlZ2FyZGxlc3MuDQo+ID4gPiBJSVVDIG5vdyBt
dWx0aWZkIHdpbGwgYWx3YXlzIHJlcXVpcmUgdHdvIHBhZ2UgZmF1bHRzIG9uIGRlc3RpbmF0aW9u
DQo+IGZvcg0KPiA+ID4gYW5vbnltb3VzIGd1ZXN0IG1lbW9yaWVzIChJIHN1cHBvc2Ugc2htZW0v
aHVnZXRsYiBpcyBmaW5lIGFzIG5vIHplcm8NCj4gcGFnZQ0KPiA+ID4gaW4gdGhvc2Ugd29ybGRz
KS4gIEV2ZW4gdGhvdWdoIGl0IHNob3VsZCBiZSBmYXN0ZXIgdGhhbiBETUEgZmF1bHRzLCBpdA0K
PiA+ID4gc3RpbGwgaXMgdW53YW50ZWQuDQo+ID4gPg0KPiA+ID4gSSdsbCB0YWtlIGEgbm90ZSBt
eXNlbGYgYXMgdG9kbyB0byBkbyBzb21lIG1lYXN1cmVtZW50cyBpbiB0aGUgZnV0dXJlDQo+ID4g
PiBmaXJzdC4gIEhvd2V2ZXIgaWYgYW55b25lIHRoaW5rcyB0aGF0IG1ha2VzIHNlbnNlIGFuZCB3
YW50IHRvIGhhdmUgYQ0KPiBsb29rLA0KPiA+ID4gcGxlYXNlIHNheSBzby4gIEl0J2xsIGJlIG1v
cmUgdGhhbiB3ZWxjb21lZC4NCj4gPg0KPiA+IFllcywgSSB0aGluayB0aGlzIGlzIGEgYmV0dGVy
IGltcHJvdmVtZW50IHRvIGF2b2lkIHR3byBwYWdlIGZhdWx0cy4gSQ0KPiBjYW4gdGVzdA0KPiA+
IHRoZSBwZXJmb3JtYW5jZSBpbXBhY3Qgb2YgdGhpcyBjaGFuZ2Ugb24gU1ZNLWNhcGFibGUgZGV2
aWNlcyBhbmQgZ2l2ZQ0KPiBzb21lIGRhdGENCj4gPiBsYXRlci4gQXMgd2Ugc2F3IGJlZm9yZSwg
dGhlIElPVExCIGZsdXNoIG9jY3VycyB2aWEgQ09XLCB3aXRoIHRoZQ0KPiBjaGFuZ2UsIHRoZQ0K
PiA+IGltcGFjdCBvZiB0aGUgQ09XIHNob3VsZCBiZSBnb25lLg0KPiA+DQo+ID4gSWYgeW91IG5l
ZWQgbW9yZSB0ZXN0aW5nIGFuZCBhbmFseXNpcyBvbiB0aGlzLCBwbGVhc2UgbGV0IG1lIGtub3cN
Cj4gDQo+IE5vdGhpbmcgbW9yZSB0aGFuIHRoYXQuICBKdXN0IGEgaGVhZHMgdXAgdGhhdCBYaWFu
ZyB1c2VkIHRvIG1lbnRpb24gYSB0ZXN0DQo+IGNhc2Ugd2hlcmUgUmljaGFyZCB1c2VkIHRvIHN1
Z2dlc3QgZHJvcHBpbmcgdGhlIHplcm8gY2hlY2s6DQo+IA0KPiBodHRwczovL2xvcmUua2VybmVs
Lm9yZy9yL0NBQVlpYlhpYitUV25KcFYyMkU9YWRuY2RCbXdYSlJxZ1JqSlhLN1g3MUo9YkRmYQ0K
PiB4RGdAbWFpbC5nbWFpbC5jb20NCj4gDQo+IEFGQUlVIHRoaXMgc2hvdWxkIGJlIHJlc29sdmVk
IGlmIHdlIGhhdmUgdGhlIGJpdG1hcCBtYWludGFpbmVkLCBidXQgd2UgY2FuDQo+IGRvdWJsZSBj
aGVjay4gIElJVUMgdGhhdCdzIGV4YWN0bHkgdGhlIGNhc2UgZm9yIGFuIGlkbGUgZ3Vlc3QsIGlu
IHRoYXQNCj4gY2FzZQ0KPiBpdCBzaG91bGQgYmUgZXZlbiBmYXN0ZXIgdG8gc2tpcCB0aGUgbWVt
Y21wIHdoZW4gYml0IGNsZWFyLg0KPiANCj4gSWYgeW91J3JlIGdvaW5nIHRvIHBvc3QgdGhlIHBh
dGNoZXMsIGZlZWwgZnJlZSB0byBwb3N0IHRoYXQgYXMgYQ0KPiBzdGFuZGFsb25lDQo+IHNtYWxs
IHNlcmllcyBmaXJzdCwgdGhlbiB0aGF0IGNhbiBiZSBjb25zaWRlcmVkIG1lcmdlIGV2ZW4gZWFy
bGllci4NCj4gDQo+IFRoYW5rcyBhIGxvdCBmb3IgZG9pbmcgdGhpcy4NCg0KU3VyZSwgSSB3aWxs
IHByZXBhcmUgYSBzZXBhcmF0ZSBwYXRjaCBmb3IgdGhpcywgYW5kIHdlIGNhbiBoYXZlIGEgYmV0
dGVyIGRpc2N1c3Npb24NCm9uIGNvbmNyZXRlIGltcGxlbWVudGF0aW9uIGFuZCB0ZXN0IHJlc3Vs
dHMuIA0K

