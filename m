Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 561B8C4345F
	for <qemu-devel@archiver.kernel.org>; Tue, 16 Apr 2024 03:42:47 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rwZhv-0004CW-46; Mon, 15 Apr 2024 23:42:07 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <zhenzhong.duan@intel.com>)
 id 1rwZht-0004CL-Pc
 for qemu-devel@nongnu.org; Mon, 15 Apr 2024 23:42:05 -0400
Received: from mgamail.intel.com ([192.198.163.9])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <zhenzhong.duan@intel.com>)
 id 1rwZhq-00035k-P5
 for qemu-devel@nongnu.org; Mon, 15 Apr 2024 23:42:05 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1713238922; x=1744774922;
 h=from:to:cc:subject:date:message-id:references:
 in-reply-to:content-transfer-encoding:mime-version;
 bh=qzBg0mNdQA5o8F0AaNWIn1TUTBskZBk588zKjGJ+dZs=;
 b=WJskn9ePsmiCrDDGvQJgjah9xV/c5ugZUCh92O/6Qae54eIu6b2nY3xa
 6clOdS7hFL0mTZxS3+TkzCKUS5CYe8WOEOJSTBgzMs/etnzUXrYpjHGWT
 4wUszSvznPyMUa0Q2MVAfoRWEG5NvJRsQWfs8aKZUB4jdu2aeTyOOoXe7
 t5MbRx6R5bZ6BWS10RPbaT0rRgS3DsgHhcp05wmgpSD2oBgltRdw72RCU
 BqGHVRgBJq7MNtWOdGMFgC8T396jpvWdKeZSUD21kzNenpgOFxE+sB/N0
 Op/H8X9MapcL56LeF4eHZeTbwVS7Y6GH1NyQruqE+W3ew4RKcrxLfBJRl g==;
X-CSE-ConnectionGUID: e2rE5ArtSb6ffjuO6KOvww==
X-CSE-MsgGUID: M+yLwlUWTkOwAfSXVmbBnw==
X-IronPort-AV: E=McAfee;i="6600,9927,11045"; a="19364700"
X-IronPort-AV: E=Sophos;i="6.07,204,1708416000"; d="scan'208";a="19364700"
Received: from orviesa001.jf.intel.com ([10.64.159.141])
 by fmvoesa103.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 15 Apr 2024 20:41:59 -0700
X-CSE-ConnectionGUID: 3DEIYecqSIeqceZZWddcDQ==
X-CSE-MsgGUID: lsZWtl7aQ1KMupEpXRKl4g==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.07,204,1708416000"; d="scan'208";a="59571096"
Received: from orsmsx602.amr.corp.intel.com ([10.22.229.15])
 by orviesa001.jf.intel.com with ESMTP/TLS/AES256-GCM-SHA384;
 15 Apr 2024 20:41:59 -0700
Received: from orsmsx610.amr.corp.intel.com (10.22.229.23) by
 ORSMSX602.amr.corp.intel.com (10.22.229.15) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35; Mon, 15 Apr 2024 20:41:58 -0700
Received: from orsmsx610.amr.corp.intel.com (10.22.229.23) by
 ORSMSX610.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35; Mon, 15 Apr 2024 20:41:58 -0700
Received: from ORSEDG601.ED.cps.intel.com (10.7.248.6) by
 orsmsx610.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35 via Frontend Transport; Mon, 15 Apr 2024 20:41:58 -0700
Received: from NAM10-DM6-obe.outbound.protection.outlook.com (104.47.58.101)
 by edgegateway.intel.com (134.134.137.102) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.35; Mon, 15 Apr 2024 20:41:57 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=EaSxWVbZ0F2kPjZvkUhJoVCE/URpCLjgJcTVFK7dBczUX6uYWHmAOABrA6Fd1PJKQvWYnPXFhHQgYAm9txQNIzyXl80WZIZxJWRQh2DAz05vNzY6ucKK9oA8FoGG5joP8lyhO5ItidTI3wbsbE2+XJyZ6bVmOkVQqg0PSIH3Md3vNcVlnEA3wYtkW9bWdwvlzwXnl5yuxobOfgrWRm4cT0u25jPe9V2MdWDXna3N/OTtyH+1Zg5NRdDDEAB+EvE0MtVK9W55islqbRTDfA2w7B3DFRq35toCrTCtRZFGzdsbr0AoQHAguoLgLL/xBVuPza1Z4ZgNZfMBbEtN6k8zGA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=qzBg0mNdQA5o8F0AaNWIn1TUTBskZBk588zKjGJ+dZs=;
 b=JESn4MvatuJVYrh99M9JRAkDHOmxHU8PezAYTmPhs5Ty2D08PFTYswc14UyCYZ/BFmHK6RW0BxLIPDFi0ZsV9qPtzgeiwsEI7R64AtnsIOYauTNq7HDwi0hFWibUNRvfsHdiyP74hbgOacdwhsJtSFzqdfpglYHMby0X8eczSzYTZo6mxDGw7w8ES6PsA+oL6z9kgfkZhbVl3XJN7pMCjSg2kxg/bzR3hR/zLmMpOhdDveQj2V/Mn7iaJ+Mprj0U8SJXqUD2TYvGwcJ2ZSKpv75Eni25AIZyODKkXL7b9wVaTB90KyUjXARSi38Yw1IeBf1pFeAHFgHt0YmyVtSNCQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Received: from SJ0PR11MB6744.namprd11.prod.outlook.com (2603:10b6:a03:47d::10)
 by SA0PR11MB4685.namprd11.prod.outlook.com (2603:10b6:806:9e::7) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7472.31; Tue, 16 Apr
 2024 03:41:55 +0000
Received: from SJ0PR11MB6744.namprd11.prod.outlook.com
 ([fe80::e4a3:76ce:879:9129]) by SJ0PR11MB6744.namprd11.prod.outlook.com
 ([fe80::e4a3:76ce:879:9129%7]) with mapi id 15.20.7472.025; Tue, 16 Apr 2024
 03:41:55 +0000
From: "Duan, Zhenzhong" <zhenzhong.duan@intel.com>
To: =?utf-8?B?Q8OpZHJpYyBMZSBHb2F0ZXI=?= <clg@redhat.com>,
 "qemu-devel@nongnu.org" <qemu-devel@nongnu.org>
CC: "alex.williamson@redhat.com" <alex.williamson@redhat.com>,
 "eric.auger@redhat.com" <eric.auger@redhat.com>, "peterx@redhat.com"
 <peterx@redhat.com>, "jasowang@redhat.com" <jasowang@redhat.com>,
 "mst@redhat.com" <mst@redhat.com>, "jgg@nvidia.com" <jgg@nvidia.com>,
 "nicolinc@nvidia.com" <nicolinc@nvidia.com>, "joao.m.martins@oracle.com"
 <joao.m.martins@oracle.com>, "Tian, Kevin" <kevin.tian@intel.com>, "Liu, Yi
 L" <yi.l.liu@intel.com>, "Peng, Chao P" <chao.p.peng@intel.com>
Subject: RE: [PATCH v2 02/10] vfio: Introduce HIODLegacyVFIO device
Thread-Topic: [PATCH v2 02/10] vfio: Introduce HIODLegacyVFIO device
Thread-Index: AQHaiYzptKOfpLfFEUmXEx9ocl3VJrFpUwqAgADyPPA=
Date: Tue, 16 Apr 2024 03:41:55 +0000
Message-ID: <SJ0PR11MB67448DE106AEE894D080D3F492082@SJ0PR11MB6744.namprd11.prod.outlook.com>
References: <20240408081230.1030078-1-zhenzhong.duan@intel.com>
 <20240408081230.1030078-3-zhenzhong.duan@intel.com>
 <9869ac57-56c6-41b7-a2c6-d42a5ba475ee@redhat.com>
In-Reply-To: <9869ac57-56c6-41b7-a2c6-d42a5ba475ee@redhat.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: SJ0PR11MB6744:EE_|SA0PR11MB4685:EE_
x-ms-office365-filtering-correlation-id: 7e3bafdf-eb07-4599-64b2-08dc5dc729a2
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: 2+XtOM84uPoO/8UxpzQJXNUZ6VyAG0RBeiogBm/42tkooyNLcCHWgInVIZMawJsPV4h3hVU4elRPDOGaTsUkcnefaRx4e7mNdeisShCQ5GI8/6naQ5QWtbzrKQTMK8HshlFrJOOrxN0op3GaxwgD0kmmbyuTv/94eX46sPDN2HwpAHKUUiWpvEoTupzZ8ZCZ8ILNjI9wPD3BUb89I5FRQckQyA70fohfYfq0W1+FdUZsklL8l8Qo+CXkTVIYseRIpwSNYJsY6rJkurTFgMbihCkYVtSpos1Ko659roINgDYDHLqDQ8BvxScwqmDRVEbW0zd0yxBkXCKLUutOMU4mqvTaxSrW4jfoP4xCwafppAD8ozffqAI5C6K1vRSwRwfUSRNWKvbI1XIt6Vx3iI3dwS/voR+AqfvzgmS6f2H9gi/xA612Bn1Orf6xtxNNbXrS2mykAW9aV6HBRATd6UbvNw8N1nTPhf0eYt16svvnIcYgu51Kipw7TUdxov3I47it4iZf6winu1MOh66Z/gkNwXo/B0fL4cg0zUUNIFCuWvcqNe0z8rnOaKA2+hWqgHZP5gOsWbeqQJG4l/x/oFw9pCDDgLHcJV49KiRvO62ZCj+yaMUGP2994OjWyd9lKDLr6XwYbHKL4zOWZbQplUIkNrixhLpmDB9CWBsukTmOJR8zAy8wnHwtYSFUkDn/qtVQvmHs/2GfuG7Mh5hWOfTp0w==
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:SJ0PR11MB6744.namprd11.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230031)(376005)(7416005)(1800799015)(366007)(38070700009); DIR:OUT;
 SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?ZTlueWw1NXZnaFlERStIVmVxbzVHNkpYMHdhSFgyVXlWOStNUVhzQTBuT2t2?=
 =?utf-8?B?a0hnaXlBOWdabVhpTWEyVGpWSTEydWpwcmVkbnJzcm1tQklmMkZhRktPbncx?=
 =?utf-8?B?TjdGNU4zcjhPUVVscFFzS1NrbjUyclA4c1IwMnpFSWVJMjV5MERwMUw0ZGI1?=
 =?utf-8?B?bHpCWUxHLy9TZDJVNjl4YXZDenVDWTBXR3VNUjVqVVZ4UXJQQnJkWkV1WXph?=
 =?utf-8?B?Q3RUditTSWNVREdLZnNyS1o2UzhtMzBoYWpNUHRxSE1XM3lUejdMMktKRkFV?=
 =?utf-8?B?SjJzT0ZONWk3dlFNK1ZnMzNOcEp5LzJpUkFiNHcrdWlNYzZ4Wmg0Z0NmRmV6?=
 =?utf-8?B?UnRrWEliaDM0LzA4VXhOZTY5U2NsZ2VXQkU4L21EbzBoaDV6L04wQWt0K0dE?=
 =?utf-8?B?YWE0NUlqcldBN0xPMkxISEVURm5ETUowWitGb21vTW9EQTR3T04xME5aNjVj?=
 =?utf-8?B?Tmo4Z2F1c01lODFpVjVYY3RwSTRZSUczRC90dzJGdDR0MDFNTXpXVlRjc2Q1?=
 =?utf-8?B?a3FIcFE5L2tpbnhDdDVOdXBqK1d6bitkeEdCNUtVUVFFNDkrU0pTeDZySWZ3?=
 =?utf-8?B?U0kxUkNWWWNNSzdYcVl1OFR6MitiQTE4T1hTOFVJZHdjU0k2WTcwU1hidmx6?=
 =?utf-8?B?RHp3dWgyY0hIU1o3ZEs3SWF2ZWNlZVJ4ZFhNUzIxZ2p6a1hCS1pQNnFsVUdY?=
 =?utf-8?B?V3V0dDQrSGZ2T3dOak1tZ3ZKMkVEQ1ZRUFhld2w3cFZhZERjUXpvTCtLTHUw?=
 =?utf-8?B?QVBUUGJSRlczR2I4TGFTYjg1TDk2Vm4wL0FXZ0NEY1lMTUE0L1V3N3FPcUk3?=
 =?utf-8?B?dHZid05jb0tmK0dqLzJ5Z003b0J5aVF0cFEzd1duVXJKbXk5am9Sa1BvcklD?=
 =?utf-8?B?ZlZUV08rMWR6T2RnK3NiVlV5RmFmbHJGdklLVUVtQXJBanB4UjU4aVhpbGVx?=
 =?utf-8?B?YmhIaDgxeEFWenJWM3VVTW9MbDlFREJzaWNvdG5WZ0lycHFBVzd5SUg1aC9H?=
 =?utf-8?B?OHAyMFJkc3JCOFMyL0pnUk4xaWR0WGhLVjhjQUJZdkYza2syMlp6T1l1all0?=
 =?utf-8?B?R3lxdXBaMUdEUjgxaiswU3dXTUJxSDRadkFQVDVpT2t2TkdQQUZvSklDOUUz?=
 =?utf-8?B?aGJwMG5FaHBCd1lhTjgwa3I2bDRVdHNMTmthb2IrbndKRUIxSnc0UUs4Mnpk?=
 =?utf-8?B?ZzhzYUwvZ0xaQSs0eTlNalBWQVVQb1d6NEtSNytqQWZBNTBDS2hsdVF4bmpP?=
 =?utf-8?B?ZmJDVXUySnpOVWpMaDhod25YUmYrZUxaTVBjNzRaUE9LRjdFWE1DWHZnY092?=
 =?utf-8?B?d3puNlYvaFNJMElUYTlJU1N6YlU0ZWRhamJlcGx4dUxQckNvaXBCbzVHM1lG?=
 =?utf-8?B?dW5UdDZ2QVlFSEc1YlJuV0VsOVY5UHVybVk2N2poMWRnL3dkS2I1WTcwY1VG?=
 =?utf-8?B?WUNYZkd1NHlOWit6ZWJKS2g2YUhQZm90NTFGSFhNQk1QMVNqUS8xTWZqbWtq?=
 =?utf-8?B?L3Y4RWRIYXdGNFNzNXZCRkRtWUhaRXA3ZWVqdXI1dEoySUFOaGFKbVdRTjFh?=
 =?utf-8?B?V3E1cm1nSmZVOVlCOHkrMnlzUmJpTmpvNGFCWVdsYkozWW9tODhVTkhhMmxR?=
 =?utf-8?B?V3NoRmg5RnNJZFZHdXloQllCSHpIZTJ6ekNXODhBSDJMRHlLNjhXQldvbngz?=
 =?utf-8?B?QWdxYWplVmQwTXJtdThDMnJnUUFoYWx6S2VMTjJyNTJYZjBqUUZjTFV6bWl1?=
 =?utf-8?B?N2l2clRUcnNWbnhrQXdVNlBqdi9vZldNdXVWNnhrQkJTcXcwYlFUT3pLVklT?=
 =?utf-8?B?VE9aQ1hZUXpFeXdWaU5ia0lVWjFlS09reTVxVlAxRzhOend0Z09DN213RjBy?=
 =?utf-8?B?VStrN3NncHlocVArRVhJcG9OcENyNjQxbkhvdGFTcHpHbzZhODI4dUVpRldX?=
 =?utf-8?B?SlJnemJLWE5pZDJzL0VhYUNGVTMwbzdRNDVQcDQ2N1VqbDFWa1ZXRDM4QW9n?=
 =?utf-8?B?WERTN2JBeFc0TVU3YkRyNk9JUEtxVW4yTjhEYktDaUNVdERsU2orVTBrelhB?=
 =?utf-8?B?TnBXUytab1AzWGN0eGVBMlhaZGE0WCtaQzd5a1I5Q3lMbEQyRlZXMElxNmcw?=
 =?utf-8?Q?L+WJuq4cB4d3HaQVv8HAwmlg2?=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: SJ0PR11MB6744.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 7e3bafdf-eb07-4599-64b2-08dc5dc729a2
X-MS-Exchange-CrossTenant-originalarrivaltime: 16 Apr 2024 03:41:55.7598 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: AGhmwmVo8rDn6UGXdHfkYsDxqSlvVZQClBK77XowFSlHto6kXz/Wss5RQ1HgGX4mSlfV8OviGHIClLJ34SFM0/YlHwxxUT68UYzTOiupqNk=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA0PR11MB4685
X-OriginatorOrg: intel.com
Received-SPF: pass client-ip=192.198.163.9;
 envelope-from=zhenzhong.duan@intel.com; helo=mgamail.intel.com
X-Spam_score_int: -49
X-Spam_score: -5.0
X-Spam_bar: -----
X-Spam_report: (-5.0 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-2.185,
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

SGkgQ8OpZHJpYywNCg0KPi0tLS0tT3JpZ2luYWwgTWVzc2FnZS0tLS0tDQo+RnJvbTogQ8OpZHJp
YyBMZSBHb2F0ZXIgPGNsZ0ByZWRoYXQuY29tPg0KPlN1YmplY3Q6IFJlOiBbUEFUQ0ggdjIgMDIv
MTBdIHZmaW86IEludHJvZHVjZSBISU9ETGVnYWN5VkZJTyBkZXZpY2UNCj4NCj5PbiA0LzgvMjQg
MTA6MTIsIFpoZW56aG9uZyBEdWFuIHdyb3RlOg0KPj4gSElPRExlZ2FjeVZGSU8gcmVwcmVzZW50
cyBhIGhvc3QgSU9NTVUgZGV2aWNlIHVuZGVyIFZGSU8gbGVnYWN5DQo+PiBjb250YWluZXIgYmFj
a2VuZC4NCj4+DQo+PiBJdCBpbmNsdWRlcyBhIGxpbmsgdG8gVkZJT0RldmljZS4NCj4+DQo+PiBT
dWdnZXN0ZWQtYnk6IEVyaWMgQXVnZXIgPGVyaWMuYXVnZXJAcmVkaGF0LmNvbT4NCj4+IFN1Z2dl
c3RlZC1ieTogQ8OpZHJpYyBMZSBHb2F0ZXIgPGNsZ0ByZWRoYXQuY29tPg0KPj4gU2lnbmVkLW9m
Zi1ieTogWmhlbnpob25nIER1YW4gPHpoZW56aG9uZy5kdWFuQGludGVsLmNvbT4NCj4+IC0tLQ0K
Pj4gICBpbmNsdWRlL2h3L3ZmaW8vdmZpby1jb21tb24uaCB8IDExICsrKysrKysrKysrDQo+PiAg
IGh3L3ZmaW8vY29udGFpbmVyLmMgICAgICAgICAgIHwgMTEgKysrKysrKysrKy0NCj4+ICAgMiBm
aWxlcyBjaGFuZ2VkLCAyMSBpbnNlcnRpb25zKCspLCAxIGRlbGV0aW9uKC0pDQo+Pg0KPj4gZGlm
ZiAtLWdpdCBhL2luY2x1ZGUvaHcvdmZpby92ZmlvLWNvbW1vbi5oIGIvaW5jbHVkZS9ody92Zmlv
L3ZmaW8tDQo+Y29tbW9uLmgNCj4+IGluZGV4IGI5ZGE2YzA4ZWYuLmYzMDc3MmY1MzQgMTAwNjQ0
DQo+PiAtLS0gYS9pbmNsdWRlL2h3L3ZmaW8vdmZpby1jb21tb24uaA0KPj4gKysrIGIvaW5jbHVk
ZS9ody92ZmlvL3ZmaW8tY29tbW9uLmgNCj4+IEBAIC0zMSw2ICszMSw3IEBADQo+PiAgICNlbmRp
Zg0KPj4gICAjaW5jbHVkZSAic3lzZW11L3N5c2VtdS5oIg0KPj4gICAjaW5jbHVkZSAiaHcvdmZp
by92ZmlvLWNvbnRhaW5lci1iYXNlLmgiDQo+PiArI2luY2x1ZGUgInN5c2VtdS9ob3N0X2lvbW11
X2RldmljZS5oIg0KPj4NCj4+ICAgI2RlZmluZSBWRklPX01TR19QUkVGSVggInZmaW8gJXM6ICIN
Cj4+DQo+PiBAQCAtMTQ3LDYgKzE0OCwxNiBAQCB0eXBlZGVmIHN0cnVjdCBWRklPR3JvdXAgew0K
Pj4gICAgICAgYm9vbCByYW1fYmxvY2tfZGlzY2FyZF9hbGxvd2VkOw0KPj4gICB9IFZGSU9Hcm91
cDsNCj4+DQo+PiArI2RlZmluZSBUWVBFX0hJT0RfTEVHQUNZX1ZGSU8gVFlQRV9IT1NUX0lPTU1V
X0RFVklDRSAiLWxlZ2FjeS0NCj52ZmlvIg0KPg0KPkkgd291bGQgcHJlZmVyIHRvIGtlZXAgdGhl
IHByZWZpeCBUWVBFX0hPU1RfSU9NTVVfREVWSUNFLg0KDQpXaWxsIGRvLg0KDQo+DQo+PiArT0JK
RUNUX0RFQ0xBUkVfU0lNUExFX1RZUEUoSElPRExlZ2FjeVZGSU8sIEhJT0RfTEVHQUNZX1ZGSU8p
DQo+PiArDQo+PiArLyogQWJzdHJhY3Rpb24gb2YgVkZJTyBsZWdhY3kgaG9zdCBJT01NVSBkZXZp
Y2UgKi8NCj4+ICtzdHJ1Y3QgSElPRExlZ2FjeVZGSU8gew0KPg0KPnNhbWUgaGVyZQ0KDQpTaG91
bGQgSSBkbyB0aGUgc2FtZSBmb3IgYWxsIHRoZSBIb3N0SU9NTVVEZXZpY2UgYW5kIEhvc3RJT01N
VURldmljZUNsYXNzIHN1Yi1zdHJ1Y3R1cmVzPw0KDQpUaGUgcmVhc29uIEkgdXNlZCAnSElPRCcg
YWJicmV2aWF0aW9uIGlzIHNvbWUgZnVuY3Rpb24gbmFtZXMgYmVjb21lIGV4dHJlbWVseSBsb25n
DQphbmQgZXhjZWVkIDgwIGNoYXJhY3RlcnMuIEUuZy46DQoNCkBAIC0xMTQ4LDkgKzExNDgsOSBA
QCBzdGF0aWMgdm9pZCB2ZmlvX2lvbW11X2xlZ2FjeV9jbGFzc19pbml0KE9iamVjdENsYXNzICpr
bGFzcywgdm9pZCAqZGF0YSkNCiAgICAgdmlvYy0+cGNpX2hvdF9yZXNldCA9IHZmaW9fbGVnYWN5
X3BjaV9ob3RfcmVzZXQ7DQogfTsNCg0KLXN0YXRpYyBpbnQgaGlvZF9sZWdhY3lfdmZpb19nZXRf
aG9zdF9pb21tdV9pbmZvKEhvc3RJT01NVURldmljZSAqaGlvZCwNCi0gICAgICAgICAgICAgICAg
ICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICB2b2lkICpkYXRhLCB1aW50MzJfdCBsZW4s
DQotICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgRXJyb3Ig
KiplcnJwKQ0KK3N0YXRpYyBpbnQgaG9zdF9pb21tdV9kZXZpY2VfbGVnYWN5X3ZmaW9fZ2V0X2hv
c3RfaW9tbXVfaW5mbyhIb3N0SU9NTVVEZXZpY2UgKmhpb2QsDQorICAgICAgICAgICAgICAgICAg
ICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgIHZvaWQgKmRhdGEsIHVp
bnQzMl90IGxlbiwNCisgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAg
ICAgICAgICAgICAgICAgICAgRXJyb3IgKiplcnJwKQ0KIHsNCiAgICAgVkZJT0RldmljZSAqdmJh
c2VkZXYgPSBISU9EX0xFR0FDWV9WRklPKGhpb2QpLT52ZGV2Ow0KICAgICAvKiBpb3ZhX3Jhbmdl
cyBpcyBhIHNvcnRlZCBsaXN0ICovDQpAQCAtMTE3Myw3ICsxMTczLDcgQEAgc3RhdGljIHZvaWQg
aGlvZF9sZWdhY3lfdmZpb19jbGFzc19pbml0KE9iamVjdENsYXNzICpvYywgdm9pZCAqZGF0YSkN
CiB7DQogICAgIEhvc3RJT01NVURldmljZUNsYXNzICpoaW9jID0gSE9TVF9JT01NVV9ERVZJQ0Vf
Q0xBU1Mob2MpOw0KDQotICAgIGhpb2MtPmdldF9ob3N0X2lvbW11X2luZm8gPSBoaW9kX2xlZ2Fj
eV92ZmlvX2dldF9ob3N0X2lvbW11X2luZm87DQorICAgIGhpb2MtPmdldF9ob3N0X2lvbW11X2lu
Zm8gPSBob3N0X2lvbW11X2RldmljZV9sZWdhY3lfdmZpb19nZXRfaG9zdF9pb21tdV9pbmZvOw0K
IH07DQoNCkkgZGlkbid0IGZpbmQgb3RoZXIgd2F5IHRvIG1ha2UgaXQgbWVldCB0aGUgODAgY2hh
cnMgbGltaXRhdGlvbi4gQW55IHN1Z2dlc3Rpb25zIG9uIHRoaXM/DQoNCj4NCj4+ICsgICAgLyo8
IHByaXZhdGUgPiovDQo+PiArICAgIEhvc3RJT01NVURldmljZSBwYXJlbnQ7DQo+PiArICAgIFZG
SU9EZXZpY2UgKnZkZXY7DQo+DQo+SXQgc2VlbXMgdG8gbWUgdGhhdCB0aGUgYmFjayBwb2ludGVy
IHNob3VsZCBiZSBvbiB0aGUgY29udGFpbmVyIGluc3RlYWQuDQo+TG9va3MgbW9yZSBjb3JyZWN0
IGNvbmNlcHR1YWxseS4NCg0KWWVzLCB0aGF0IG1ha2VzIHNlbnNlIGZvciBsZWdhY3kgVkZJTywg
YXMgaW92YV9yYW5nZXMsIHBnc2l6ZXMgZXRjIGFyZSBhbGwgc2F2ZWQgaW4gYmNvbnRhaW5lci4N
Cg0KPg0KPg0KPj4gK307DQo+PiArDQo+PiAgIHR5cGVkZWYgc3RydWN0IFZGSU9ETUFCdWYgew0K
Pj4gICAgICAgUWVtdURtYUJ1ZiBidWY7DQo+PiAgICAgICB1aW50MzJfdCBwb3NfeCwgcG9zX3ks
IHBvc191cGRhdGVzOw0KPj4gZGlmZiAtLWdpdCBhL2h3L3ZmaW8vY29udGFpbmVyLmMgYi9ody92
ZmlvL2NvbnRhaW5lci5jDQo+PiBpbmRleCA3N2JkZWMyNzZlLi40NDAxOGVmMDg1IDEwMDY0NA0K
Pj4gLS0tIGEvaHcvdmZpby9jb250YWluZXIuYw0KPj4gKysrIGIvaHcvdmZpby9jb250YWluZXIu
Yw0KPj4gQEAgLTExNDMsMTIgKzExNDMsMjEgQEAgc3RhdGljIHZvaWQNCj52ZmlvX2lvbW11X2xl
Z2FjeV9jbGFzc19pbml0KE9iamVjdENsYXNzICprbGFzcywgdm9pZCAqZGF0YSkNCj4+ICAgICAg
IHZpb2MtPnBjaV9ob3RfcmVzZXQgPSB2ZmlvX2xlZ2FjeV9wY2lfaG90X3Jlc2V0Ow0KPj4gICB9
Ow0KPj4NCj4+ICtzdGF0aWMgdm9pZCBoaW9kX2xlZ2FjeV92ZmlvX2NsYXNzX2luaXQoT2JqZWN0
Q2xhc3MgKm9jLCB2b2lkICpkYXRhKQ0KPj4gK3sNCj4+ICt9Ow0KPg0KPklzIGl0IHByZWZlcmFi
bGUgdG8gaW50cm9kdWNlIHJvdXRpbmVzIHdoZW4gdGhleSBhcmUgYWN0dWFsbHkgdXNlZnVsLg0K
PlBsZWFzZSBkcm9wIHRoZSAuY2xhc3NfaW5pdCBkZWZpbml0aW9uLg0KDQpTdXJlLg0KDQpUaGFu
a3MNClpoZW56aG9uZw0KDQo+DQo+VGhhbmtzLA0KPg0KPkMuDQo+DQo+DQo+PiArDQo+PiAgIHN0
YXRpYyBjb25zdCBUeXBlSW5mbyB0eXBlc1tdID0gew0KPj4gICAgICAgew0KPj4gICAgICAgICAg
IC5uYW1lID0gVFlQRV9WRklPX0lPTU1VX0xFR0FDWSwNCj4+ICAgICAgICAgICAucGFyZW50ID0g
VFlQRV9WRklPX0lPTU1VLA0KPj4gICAgICAgICAgIC5jbGFzc19pbml0ID0gdmZpb19pb21tdV9s
ZWdhY3lfY2xhc3NfaW5pdCwNCj4+IC0gICAgfSwNCj4+ICsgICAgfSwgew0KPj4gKyAgICAgICAg
Lm5hbWUgPSBUWVBFX0hJT0RfTEVHQUNZX1ZGSU8sDQo+PiArICAgICAgICAucGFyZW50ID0gVFlQ
RV9IT1NUX0lPTU1VX0RFVklDRSwNCj4+ICsgICAgICAgIC5pbnN0YW5jZV9zaXplID0gc2l6ZW9m
KEhJT0RMZWdhY3lWRklPKSwNCj4+ICsgICAgICAgIC5jbGFzc19pbml0ID0gaGlvZF9sZWdhY3lf
dmZpb19jbGFzc19pbml0LA0KPj4gKyAgICB9DQo+PiAgIH07DQo+Pg0KPj4gICBERUZJTkVfVFlQ
RVModHlwZXMpDQoNCg==

