Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8F01EC25B75
	for <qemu-devel@archiver.kernel.org>; Thu,  6 Jun 2024 10:20:17 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sFADT-0003YG-0V; Thu, 06 Jun 2024 06:19:31 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <zhenzhong.duan@intel.com>)
 id 1sFADO-0003Xm-NS
 for qemu-devel@nongnu.org; Thu, 06 Jun 2024 06:19:27 -0400
Received: from mgamail.intel.com ([192.198.163.11])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <zhenzhong.duan@intel.com>)
 id 1sFADM-0007DQ-1R
 for qemu-devel@nongnu.org; Thu, 06 Jun 2024 06:19:25 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1717669164; x=1749205164;
 h=from:to:cc:subject:date:message-id:references:
 in-reply-to:content-transfer-encoding:mime-version;
 bh=h5A+LhbTY4RNjaJR3+zMKl84f/DoJKdka3nORVFWoFE=;
 b=aqygtE75lQZE4VVzFU/GarlGTbh6bjbUFH0CoeO0/ehiEeMwiwtqcxA1
 nehHnYri/cfg706lCBGgM2tAkEjQg8Fmi0Yg5g5ZeKa7rZS2dgWNUHhir
 u94oLzly28K7kxO81csNKBHWizYEsoz8psvCtrZkF4lx5h0W2qD0yLGBB
 P9WTGuC2Xj+PWL6RmraIc+4uY0zFpLjPVtKxttqA+xoRWXYJIlPvqIYcR
 h5kDpQMiA6T6HXEpODPMDmx+Z7v7TUF1n6+iO8PbGTB53Pg50aMDgeMaL
 yGaxhgQLy2/3wae4rbM8dojwFzI8enVzvRNHBZvQ5hdotFyS6VcX5Ls9o A==;
X-CSE-ConnectionGUID: gZcRBROTTPOodQoyCZARvw==
X-CSE-MsgGUID: lY4gTm48Q669/DZBh6/5dw==
X-IronPort-AV: E=McAfee;i="6600,9927,11094"; a="24959891"
X-IronPort-AV: E=Sophos;i="6.08,218,1712646000"; d="scan'208";a="24959891"
Received: from orviesa009.jf.intel.com ([10.64.159.149])
 by fmvoesa105.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 06 Jun 2024 03:19:16 -0700
X-CSE-ConnectionGUID: DGnVcLCyTxqW/6VpSfyIHA==
X-CSE-MsgGUID: 9cOxY3eNTzKr3rB5s/KITA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.08,218,1712646000"; d="scan'208";a="37983227"
Received: from fmsmsx602.amr.corp.intel.com ([10.18.126.82])
 by orviesa009.jf.intel.com with ESMTP/TLS/AES256-GCM-SHA384;
 06 Jun 2024 03:19:12 -0700
Received: from fmsmsx612.amr.corp.intel.com (10.18.126.92) by
 fmsmsx602.amr.corp.intel.com (10.18.126.82) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.39; Thu, 6 Jun 2024 03:19:11 -0700
Received: from fmsmsx603.amr.corp.intel.com (10.18.126.83) by
 fmsmsx612.amr.corp.intel.com (10.18.126.92) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.39; Thu, 6 Jun 2024 03:19:10 -0700
Received: from FMSEDG603.ED.cps.intel.com (10.1.192.133) by
 fmsmsx603.amr.corp.intel.com (10.18.126.83) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.39 via Frontend Transport; Thu, 6 Jun 2024 03:19:10 -0700
Received: from NAM04-BN8-obe.outbound.protection.outlook.com (104.47.74.43) by
 edgegateway.intel.com (192.55.55.68) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.39; Thu, 6 Jun 2024 03:19:10 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Rb4ISapuaaM43ju3ghHJrkSCEhlVzZ1Htu2dc3J51D0fobBKnCGFY2j+v5cb4jwVfooxBgapch+gv10CtLxVlLPfzLWUlQP3H5P+YBTrvQpGkvJNqLvpvtChi5XZE9nGQ/5BGSSQticRphvqY6yWj44shZY65ONLPzgXP0uhwHCDzcMiczdJE9WMGCv6qedj38mIhIfnaj3sqzQrRzGELd6TQp1IB7j2ELP2tDlqPEru9Q0OyTQ4tYQxNiJ9EljeTo1psgRk0/ylM+ISmjDIEmlDrmlh+xRH00ZsBa1Q3BEZ7e5qJ8muEePoRj0wbvtMXWFfBz7apZDvulcwSyYg9g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=h5A+LhbTY4RNjaJR3+zMKl84f/DoJKdka3nORVFWoFE=;
 b=XOSWJeEY2oLP/ReFOMl4crdajohxgHmX2Z1kv5/B/6l+skkeDjJJyemJbvST/42V421uK6VroHv6ymPZno0HLBdu7UwkMDtRF7r1NuR7K2ENXM4cB9dPhIf3/OFkmeHmgM3fZfCyJnXhDcJOJxZ3aOmkvvpGRDNIc1yF/emnGcbBs/YmsEH1zOQfqOV0HMj3ItzVoBgta721ZFjCi8lprWrZ0HXHesdi5UQKeSgn0vReAI2J+70vu1QQwt14cA7Gp+8axpEr5cHl1slMvEodhU1esUdegshYW2c4xyKfeZR+k4A8iuHgh9QUTKKOz1FJNO5SBCBPU4AL8v3NwdCVXQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Received: from SJ0PR11MB6744.namprd11.prod.outlook.com (2603:10b6:a03:47d::10)
 by CH3PR11MB7770.namprd11.prod.outlook.com (2603:10b6:610:129::6)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7633.34; Thu, 6 Jun
 2024 10:19:07 +0000
Received: from SJ0PR11MB6744.namprd11.prod.outlook.com
 ([fe80::fe49:d628:48b1:6091]) by SJ0PR11MB6744.namprd11.prod.outlook.com
 ([fe80::fe49:d628:48b1:6091%7]) with mapi id 15.20.7633.033; Thu, 6 Jun 2024
 10:19:07 +0000
From: "Duan, Zhenzhong" <zhenzhong.duan@intel.com>
To: "eric.auger@redhat.com" <eric.auger@redhat.com>, "qemu-devel@nongnu.org"
 <qemu-devel@nongnu.org>
CC: "alex.williamson@redhat.com" <alex.williamson@redhat.com>,
 "clg@redhat.com" <clg@redhat.com>, "mst@redhat.com" <mst@redhat.com>,
 "peterx@redhat.com" <peterx@redhat.com>, "jasowang@redhat.com"
 <jasowang@redhat.com>, "jgg@nvidia.com" <jgg@nvidia.com>,
 "nicolinc@nvidia.com" <nicolinc@nvidia.com>, "joao.m.martins@oracle.com"
 <joao.m.martins@oracle.com>, "clement.mathieu--drif@eviden.com"
 <clement.mathieu--drif@eviden.com>, "Tian, Kevin" <kevin.tian@intel.com>,
 "Liu, Yi L" <yi.l.liu@intel.com>, "Peng, Chao P" <chao.p.peng@intel.com>,
 Marcel Apfelbaum <marcel.apfelbaum@gmail.com>
Subject: RE: [PATCH v6 09/19] vfio/iommufd: Implement
 HostIOMMUDeviceClass::realize() handler
Thread-Topic: [PATCH v6 09/19] vfio/iommufd: Implement
 HostIOMMUDeviceClass::realize() handler
Thread-Index: AQHatX026AiY+etA/U+I5iKUsGNWX7G6fB+AgAABvoCAAAHcoA==
Date: Thu, 6 Jun 2024 10:19:07 +0000
Message-ID: <SJ0PR11MB674434415F6EBFD6FD68324192FA2@SJ0PR11MB6744.namprd11.prod.outlook.com>
References: <20240603061023.269738-1-zhenzhong.duan@intel.com>
 <20240603061023.269738-10-zhenzhong.duan@intel.com>
 <09ba18e0-9d91-4e04-b291-0412d00a108d@redhat.com>
 <48775516-3c3f-4c1d-a573-cf6649a66aa8@redhat.com>
In-Reply-To: <48775516-3c3f-4c1d-a573-cf6649a66aa8@redhat.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: SJ0PR11MB6744:EE_|CH3PR11MB7770:EE_
x-ms-office365-filtering-correlation-id: 5c1da6ba-15c8-4c37-13c9-08dc86121976
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
 ARA:13230031|376005|7416005|1800799015|366007|38070700009; 
x-microsoft-antispam-message-info: =?utf-8?B?TDJvajRFbmM4Q3pXNEp1U1R2Y1ZkQUJxWm03VzRCdU1rMlZyMkJvM0NxMHZK?=
 =?utf-8?B?MEQ4ZWpEbG1yT05kNG5QWHlRMGZhcHJ3ZGZPTmRSbTIxd1RyS3BjeURiN3oy?=
 =?utf-8?B?WndCbVFRTmtudWpoaFhOYnFJQitQWXJrYWowYzY0MkxGSTQvNkk0VlVlSkdG?=
 =?utf-8?B?b2dDREYxZGVzLzQ5S3RvSVh1ZDFwYStsNkRBVFZzQW1peHNqWU1FSm9NNFY1?=
 =?utf-8?B?SFBLRjZmZU9JNWtxZGV6Q3JIdzlCNW9IZGRZYXFuRHhDUnJBdmNlZWhLM2R1?=
 =?utf-8?B?RDZmZUtZUUZHd3Y4U3hiZjlQdkxNdmNDZm5XSnJGdDViVU5aM0xtYVlMZnpG?=
 =?utf-8?B?aVhoZUZVemd1REl6WHRNVWV6a3BsQmNwQzZPYkhhQkk1Q2JST0ErYWJXK3NV?=
 =?utf-8?B?OHNId1MvenRNZSs2VlNsbFkvSGh3SXBkSEltUXR5ZjVVdU9JRFpMZ3UzeCtV?=
 =?utf-8?B?MjlFOW81WTR2TzBFbTV6NCtQNXBqb2szS3lrQ2h4allETTRHeURwYkxqaHR1?=
 =?utf-8?B?SkxHNVk5Tm90ZklwaE5iSitTbUpJMk52QkFRQ3lqMktPVm4xVjlhNjNlajZs?=
 =?utf-8?B?cnZ5L3o3UHFCMUw0ZG12L096d0RFTHhqdWNBczZZNHJZM3dBYkNQRWZWdVEz?=
 =?utf-8?B?KzJzUE5MU0tvUFhUUFk0UDhFV2d6MDZZc3ZqRjVGZnZQTlNLcG9oMWloVDB6?=
 =?utf-8?B?aHNocWt2S3U1eFpYYTE2MjhFcFFoc05nNkxNMklhUk42VUp1MFRIYU5IL0hl?=
 =?utf-8?B?d01hdWdmSGhuNzNqNlBoUjBLTEFuU3pJTldiWWVvVHFEVldxbk5ycVJKWWRT?=
 =?utf-8?B?d3ZZbDl1aHZDTFJ5R3lueHVGTklUS1VzdUtON2JPOFpyYXNkR01TcHdqWnJV?=
 =?utf-8?B?NVoxZXh0MzlwMUtKcEhZWWhQVzNrajI5WDdQSkhZREdUaWhWcEY1dENBbHJT?=
 =?utf-8?B?aEl6ZW9xM2IwUE93Q3luY055SHRVK01JRmVsczBDQm5HOWkxN1pOdUd0SkJG?=
 =?utf-8?B?azUwSmNzRldLdU9QRkxGeGVEY2JBRFFoanJnOFRCQ0FYWjJzWDlLK3JWMitB?=
 =?utf-8?B?ZmljaVZJRkZDWEtZRCtyT3dXcDhxTld4Skg2ZVpldEJWMFJqT0hGb2R6MjBU?=
 =?utf-8?B?N0dSbzRPUzJTZDhMckJFaEpFaXdzTjhXZkpxSjVkQ1lOU2UzaEdzODRXWEJQ?=
 =?utf-8?B?Q3p1TDc4RUd3NDhVUitrcjdNYjhTd2o3MEtrVlczK1lvdGNQTmxwTUZhWFBO?=
 =?utf-8?B?N2RMcEJTOVVNdldNQWpKNW1VWlZmREk4d3h6M2VwaVVzTG9QUC8xOTlQc2hX?=
 =?utf-8?B?Sm5oVkpjTEgzTXdnK25XLzFKeXN2VGtFRUhVQkRhTkJoQWZDYmN0Sm9jd1Rw?=
 =?utf-8?B?ZnNDa0l4L1VJQVBkWE15endMY0gvbitKUTlvcEZYMjVxRmtzSUZPTTRUSHl3?=
 =?utf-8?B?VHpQbXppdVYrQVlxd1RuTDNnRzJDcHpSaFZ1S2FwV09sazBDUHk3RFZzekNu?=
 =?utf-8?B?K3JBWXZZaDF5S0Iza1dXV0lRenJDNjZJMXNjQy9Sd1l2NnhuMlhRWVJPUmQ5?=
 =?utf-8?B?WlN2Z0FLaGsyOUFQUk93UEJnSWhRbFkxc0NKQWhpUlBZWEh1TFZ3NFkwNU9M?=
 =?utf-8?B?Qk9QclBYbmJ6dXdPSkErQW0ydllXQkh5T210OS9ob0RWUElIZTNWTTdxNEl3?=
 =?utf-8?B?ZzdnSytnUXEvS1lOQ0M2S2NEdTFBb0VnMjM4UWpIcmMyMHpuc3JFOXZWUDBt?=
 =?utf-8?B?K0N0cm9mSHpNbFhKcjdzWSszNGNkSW1IV0pzck9Tam9RT1g5SWdmSGRQRlA0?=
 =?utf-8?Q?O7vCOj9jdHqAy3eGuutQf7hGOavslXcLz1SSY=3D?=
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:SJ0PR11MB6744.namprd11.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230031)(376005)(7416005)(1800799015)(366007)(38070700009); DIR:OUT;
 SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?ZmVuSWUyVWx2KzRhN09KTFZoSjhKNTgxY0QxV1VsV2lGUGtHNEVlT0ZpYnN2?=
 =?utf-8?B?b0RCVEpKUjJ0b2cxS21DVytZemF3Kyt1dFdvMkhVNHFHZWZHNXNXL3licXJr?=
 =?utf-8?B?L25GbW9sR1RVS1Vyd0RKSmRLeHAyazFwQjk2THJBMFIwU25SNXM2MXZralBM?=
 =?utf-8?B?UGxBRE8ybVFJVXhyemhNZG1YRWhuUUx2MHNRZFhyMTcxMCtucGgzcFFxZnZq?=
 =?utf-8?B?Yzcvc0JWNElVeGRWRUE4Ykp3eWQwaDRTcUptMU16d2RLSk0wa09HcWtxYUR1?=
 =?utf-8?B?aVUxYlNPTkFwK3JScndvVUlic2lpZHhzQlRJb0d0WHUwRzV6K1V3KzF5WVY1?=
 =?utf-8?B?eFlqNUNjS21XaHNXZ211MUVNYW11ZXZyMy9JbEJGcFBMblR5ZFhSYXpxMTkx?=
 =?utf-8?B?S245Qy9xUEVtMmhJMmJTMS90UTNTVkJmVFBLbmZlWGNQYjNHMTRPellkTTZn?=
 =?utf-8?B?UGowUzJuRDI3Y3VIN3laU29TaWJqOURua1JBSWJISzJEWGx1RWhGNS9TMG1L?=
 =?utf-8?B?VDJjUW12YXVBTlVJWG9JRkZCWDFQbFVoamJ1ZmhhdlZXQ0ZNa0Y0ZFZEaWVW?=
 =?utf-8?B?VEJEZS9EMW1ndjh4ekhIbmdqZ3Z3b1R5anNQTGwza1hqVzdEaU5DcTBkWEtk?=
 =?utf-8?B?Q0traTRlK21MeHkwbGF0cFM4QXJQSCtWeDhhSnBSYi9DTVB1elI2anhERG1O?=
 =?utf-8?B?RmpNdzBsUDQvTm1QRWVNQSs5d2c0MnRWdHB0T01RQzQ3aitlRWJVOExYMUFU?=
 =?utf-8?B?aDJsRllMSElCZzM5ZmVuSmNRZWZuNjNZVURtTTlPU2NVcnRFYk5jYTBtaWVS?=
 =?utf-8?B?NHYybldjcHFnS0hqaUpPbGJMTS9ac1JEWWsyNlFmT0NMRlZBR2FOVEJJcEpL?=
 =?utf-8?B?Wnd2aWpqczNZRW5XZVRhZ3hTdHpNNklYdXdjOTd6dEpVY2NNWXAwbHZVZnAw?=
 =?utf-8?B?RGZKUWFKMW03enhtOXV0WjFISEx1eUo3RkxRQVFkTHgrZUlqTm55dTQvWFU1?=
 =?utf-8?B?eUUzU3JRZVg5akxrYktWaTU3UDI1Y0tPUmYrNjBaVktIaldSdUVUNTNDbm9W?=
 =?utf-8?B?UU9FZHNwa3dzcExBQktiS1RJQmN4dWtCK1oydFBHUUJMaXZxMjBjTVYwTjNJ?=
 =?utf-8?B?ZWZvM25nTGtMT2Foek5JUXNJR0REcnFveWtUd2pNVitMVnpVOFg2TVJoYzhN?=
 =?utf-8?B?akVOUks4U0NLUDNKMUVDcHdoeCtReUZuWkFJNmNYR2k4dUlIT2FlZG1ITklh?=
 =?utf-8?B?S082Ykl6UjlEandFcDRUZmZjWHB4MXltRW9oOUdpNnFzekozRE9zWEhONHZ3?=
 =?utf-8?B?RVloM2dEWmZLUXRyUUo1MWs2WGRMNFIrVlc4OWRPeHcyNkpwQ3pxakFwWUhL?=
 =?utf-8?B?ektMd1g3MVNkTHZvb2hOZFpwbUxpTlBoRE1lb0h6c0x4RjZWZjdGK21UNzBt?=
 =?utf-8?B?aktlTnRvTzZnQWtuMUtDckxzb1ZzbFBrT2ZnTFpBaE43TU1kWlVmS0FOemRp?=
 =?utf-8?B?Y3RBaExOYlhjVzNJamdMMXl2MC9IUWVLYWhpN3lFbXNvWFgzM2thUEZOYnda?=
 =?utf-8?B?REpLOXNpTUVqMVhXQytBdW1Db2s4Ly84ZnhkWlAreUhlQ08xamxOV3BWNVJM?=
 =?utf-8?B?Lzg1QTVQankwTmhEVXFMNzczQVRNTGwxQ1J2RFNWNU9aWUt5cjRub2Fmcktv?=
 =?utf-8?B?VDVTbXU4TlhmWjdzTkkwb1JlNzYyMmY3TFRrb0NqR0xOUlI2ZkNaM0FQMXQv?=
 =?utf-8?B?Uk9lOU9vMWsxeUJPUU1xQ04vQlQxczhYMXZNMVJ5SnQyT1V1MHRlaWwzWStZ?=
 =?utf-8?B?ZkxKK1ljeWdZb0JqcEtSNUJPcVlrVG8yQVJtS1dDTGk4L3BURHVIYTczbDNO?=
 =?utf-8?B?MzRSWGdFb1g1eUNaMUk2UDU1NTA0aS9kZVJoQkdRVjZ1ME84UnFtWDg1NFhR?=
 =?utf-8?B?UjJNTUIzS0NpdzB5Z1NEV3dnU1d3VC94OThLcGNpaXB0NkpuZGN5Sk9VaE5R?=
 =?utf-8?B?YzM3VWppWEVBOEgxOXFRemJMSjJNU29jOG9kOWhRWThYOXFmdVVIcXdOZVhJ?=
 =?utf-8?B?b0l6UTd3L3h0QmE0b1JLYVVFUkRjcGNldmVFSk9GVnBHdDVUaXBVaGF4OE1u?=
 =?utf-8?Q?iHxV8cHxz6o3n0ggNyWFqZA7I?=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: SJ0PR11MB6744.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 5c1da6ba-15c8-4c37-13c9-08dc86121976
X-MS-Exchange-CrossTenant-originalarrivaltime: 06 Jun 2024 10:19:07.4454 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: V2y14us/UqwCbKujZe/uqQiD/+EVWh+qg+rbuid2tL+ppAAimnCq6t3Ioy2B31p66ScnqSDUHf2RS6/g+JOR1jVghZUAL+vjImL3cylF0k0=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH3PR11MB7770
X-OriginatorOrg: intel.com
Received-SPF: pass client-ip=192.198.163.11;
 envelope-from=zhenzhong.duan@intel.com; helo=mgamail.intel.com
X-Spam_score_int: -43
X-Spam_score: -4.4
X-Spam_bar: ----
X-Spam_report: (-4.4 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_MED=-2.3, SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
 T_SCC_BODY_TEXT_LINE=-0.01 autolearn=ham autolearn_force=no
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

SGkgRXJpYywNCg0KPi0tLS0tT3JpZ2luYWwgTWVzc2FnZS0tLS0tDQo+RnJvbTogRXJpYyBBdWdl
ciA8ZXJpYy5hdWdlckByZWRoYXQuY29tPg0KPlN1YmplY3Q6IFJlOiBbUEFUQ0ggdjYgMDkvMTld
IHZmaW8vaW9tbXVmZDogSW1wbGVtZW50DQo+SG9zdElPTU1VRGV2aWNlQ2xhc3M6OnJlYWxpemUo
KSBoYW5kbGVyDQo+DQo+DQo+DQo+T24gNi82LzI0IDExOjI2LCBFcmljIEF1Z2VyIHdyb3RlOg0K
Pj4gSGkgWmhlbnpob25nLA0KPj4gT24gNi8zLzI0IDA4OjEwLCBaaGVuemhvbmcgRHVhbiB3cm90
ZToNCj4+PiBJdCBjYWxscyBpb21tdWZkX2JhY2tlbmRfZ2V0X2RldmljZV9pbmZvKCkgdG8gZ2V0
IGhvc3QgSU9NTVUNCj4+PiByZWxhdGVkIGluZm9ybWF0aW9uIGFuZCB0cmFuc2xhdGUgaXQgaW50
byBIb3N0SU9NTVVEZXZpY2VDYXBzDQo+Pj4gZm9yIHF1ZXJ5IHdpdGggLmdldF9jYXAoKS4NCj4+
Pg0KPj4+IEludHJvZHVjZSBtYWNybyBWVERfTUdBV19GUk9NX0NBUCB0byBnZXQgTUdBVyB3aGlj
aCBlcXVhbHMgdG8NCj4+PiAoYXdfYml0cyAtIDEpLg0KPj4+DQo+Pj4gU2lnbmVkLW9mZi1ieTog
Wmhlbnpob25nIER1YW4gPHpoZW56aG9uZy5kdWFuQGludGVsLmNvbT4NCj4+PiAtLS0NCj4+PiAg
aW5jbHVkZS9ody9pMzg2L2ludGVsX2lvbW11LmggfCAgMSArDQo+Pj4gIGh3L3ZmaW8vaW9tbXVm
ZC5jICAgICAgICAgICAgIHwgMzcNCj4rKysrKysrKysrKysrKysrKysrKysrKysrKysrKysrKysr
Kw0KPj4+ICAyIGZpbGVzIGNoYW5nZWQsIDM4IGluc2VydGlvbnMoKykNCj4+Pg0KPj4+IGRpZmYg
LS1naXQgYS9pbmNsdWRlL2h3L2kzODYvaW50ZWxfaW9tbXUuaA0KPmIvaW5jbHVkZS9ody9pMzg2
L2ludGVsX2lvbW11LmgNCj4+PiBpbmRleCA3ZmEwYTY5NWM4Li43ZDY5NGIwODEzIDEwMDY0NA0K
Pj4+IC0tLSBhL2luY2x1ZGUvaHcvaTM4Ni9pbnRlbF9pb21tdS5oDQo+Pj4gKysrIGIvaW5jbHVk
ZS9ody9pMzg2L2ludGVsX2lvbW11LmgNCj4+PiBAQCAtNDcsNiArNDcsNyBAQCBPQkpFQ1RfREVD
TEFSRV9TSU1QTEVfVFlQRShJbnRlbElPTU1VU3RhdGUsDQo+SU5URUxfSU9NTVVfREVWSUNFKQ0K
Pj4+ICAjZGVmaW5lIFZURF9IT1NUX0FXXzQ4QklUICAgICAgICAgICA0OA0KPj4+ICAjZGVmaW5l
IFZURF9IT1NUX0FERFJFU1NfV0lEVEggICAgICBWVERfSE9TVF9BV18zOUJJVA0KPj4+ICAjZGVm
aW5lIFZURF9IQVdfTUFTSyhhdykgICAgICAgICAgICAoKDFVTEwgPDwgKGF3KSkgLSAxKQ0KPj4+
ICsjZGVmaW5lIFZURF9NR0FXX0ZST01fQ0FQKGNhcCkgICAgICAoKGNhcCA+PiAxNikgJiAweDNm
VUxMKQ0KPj4+DQo+Pj4gICNkZWZpbmUgRE1BUl9SRVBPUlRfRl9JTlRSICAgICAgICAgICgxKQ0K
Pj4+DQo+Pj4gZGlmZiAtLWdpdCBhL2h3L3ZmaW8vaW9tbXVmZC5jIGIvaHcvdmZpby9pb21tdWZk
LmMNCj4+PiBpbmRleCBlNGE1MDdkNTVjLi45ZDJlOTVlMjBlIDEwMDY0NA0KPj4+IC0tLSBhL2h3
L3ZmaW8vaW9tbXVmZC5jDQo+Pj4gKysrIGIvaHcvdmZpby9pb21tdWZkLmMNCj4+PiBAQCAtMjUs
NiArMjUsNyBAQA0KPj4+ICAjaW5jbHVkZSAicWVtdS9jdXRpbHMuaCINCj4+PiAgI2luY2x1ZGUg
InFlbXUvY2hhcmRldl9vcGVuLmgiDQo+Pj4gICNpbmNsdWRlICJwY2kuaCINCj4+PiArI2luY2x1
ZGUgImh3L2kzODYvaW50ZWxfaW9tbXVfaW50ZXJuYWwuaCINCj4+Pg0KPj4+ICBzdGF0aWMgaW50
IGlvbW11ZmRfY2Rldl9tYXAoY29uc3QgVkZJT0NvbnRhaW5lckJhc2UgKmJjb250YWluZXIsDQo+
aHdhZGRyIGlvdmEsDQo+Pj4gICAgICAgICAgICAgICAgICAgICAgICAgICAgICByYW1fYWRkcl90
IHNpemUsIHZvaWQgKnZhZGRyLCBib29sIHJlYWRvbmx5KQ0KPj4+IEBAIC02MTksNiArNjIwLDQx
IEBAIHN0YXRpYyB2b2lkDQo+dmZpb19pb21tdV9pb21tdWZkX2NsYXNzX2luaXQoT2JqZWN0Q2xh
c3MgKmtsYXNzLCB2b2lkICpkYXRhKQ0KPj4+ICAgICAgdmlvYy0+cGNpX2hvdF9yZXNldCA9IGlv
bW11ZmRfY2Rldl9wY2lfaG90X3Jlc2V0Ow0KPj4+ICB9Ow0KPj4+DQo+Pj4gK3N0YXRpYyBib29s
IGhpb2RfaW9tbXVmZF92ZmlvX3JlYWxpemUoSG9zdElPTU1VRGV2aWNlICpoaW9kLCB2b2lkDQo+
Km9wYXF1ZSwNCj4+PiArICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICBFcnJv
ciAqKmVycnApDQo+Pj4gK3sNCj4+PiArICAgIFZGSU9EZXZpY2UgKnZkZXYgPSBvcGFxdWU7DQo+
PiBJIHRoaW5rIGl0IHdvdWxkIG1ha2Ugc2Vuc2UgdG8gc3RvcmUgdmRldiBpbiBoaW9kLiBUaGlz
IHdvdWxkIGFsbG93IHRvDQo+PiBwb3N0cG9uZSBzb21lIGNvbXB1dGF0aW9ucyBpbiB0aGUgSG9z
dElPTU1VRGV2aWNlIG9wcyBpbnN0ZWFkIG9mDQo+ZG9pbmcNCj4+IGV2ZXJ5dGhpbmcgaW4gdGhl
IHJlYWxpemUuDQo+PiBGb3IgaW5zdGFuY2UgdG8gcmV0cmlldmUgdGhlIHVzYWJsZSBpb3ZhX3Jh
bmdlcyBJIHdpbGwgbmVlZCB0byBhY2Nlc3MNCj4+IHRoZSBiYXNlIGNvbnRhaW5lciBpbiB0aGUg
YXNzb2NpYXRlZCBvcHMuDQo+DQo+dGhpcyB3b3VsZCBuZWVkIHRvIGJlIG9wYXF1ZSBzaW5jZSB0
aGUgYWdlbnQgZGV2aWNlIGNhbiBiZSBlaXRoZXINCj5WRklPRGV2aWNlIG9yIFZEUEEgb2JqZWN0
IHRob3VnaA0KDQpUaGlzIHdpbGwgZ2l2ZSB2SU9NTVUgYWNjZXNzIHRvIGFsbCBWRklPRGV2aWNl
IG9yIFZEUEEgb2JqZWN0IGVsZW1lbnRzDQphbmQgSSdtIG5vdCBzdXJlIGlmIFZEUEEgc3VwcG9y
dHMgaW92YV9yYW5nZXMuDQpXaGF0IGFib3V0IGV4cG9zaW5nIG9ubHkgd2hhdCB3ZSBuZWVkLCBs
aWtlIGJlbG93Lg0KSWYgVkRQQSBkb2Vzbid0IHN1cHBvcnQgaW92YV9yYW5nZXMsIGdldF9jYXAo
KSBzaG91bGQgcmV0dXJuIDAuDQoNCi0tLSBhL2luY2x1ZGUvc3lzZW11L2hvc3RfaW9tbXVfZGV2
aWNlLmgNCisrKyBiL2luY2x1ZGUvc3lzZW11L2hvc3RfaW9tbXVfZGV2aWNlLmgNCkBAIC0zMiw2
ICszMiw3IEBAIHR5cGVkZWYgc3RydWN0IEhvc3RJT01NVURldmljZUNhcHMgew0KICAgICBib29s
IG5lc3Rpbmc7DQogICAgIGJvb2wgZnMxZ3A7DQogICAgIHVpbnQzMl90IGVycmF0YTsNCisgICAg
R0xpc3QgKmlvdmFfcmFuZ2VzOw0KIH0gSG9zdElPTU1VRGV2aWNlQ2FwczsNCg0KICNkZWZpbmUg
VFlQRV9IT1NUX0lPTU1VX0RFVklDRSAiaG9zdC1pb21tdS1kZXZpY2UiDQpAQCAtOTYsNiArOTcs
NyBAQCBzdHJ1Y3QgSG9zdElPTU1VRGV2aWNlQ2xhc3Mgew0KICNkZWZpbmUgSE9TVF9JT01NVV9E
RVZJQ0VfQ0FQX05FU1RJTkcgICAgICAgICAgIDINCiAjZGVmaW5lIEhPU1RfSU9NTVVfREVWSUNF
X0NBUF9GUzFHUCAgICAgICAgICAgICAzDQogI2RlZmluZSBIT1NUX0lPTU1VX0RFVklDRV9DQVBf
RVJSQVRBICAgICAgICAgICAgNA0KKyNkZWZpbmUgSE9TVF9JT01NVV9ERVZJQ0VfQ0FQX0lPVkFf
UkFOR0VTICAgICAgIDUNCg0KIC8qKg0KICAqIGVudW0gaG9zdF9pb21tdV9kZXZpY2VfaW9tbXVf
aHdfaW5mb190eXBlIC0gSU9NTVUgSGFyZHdhcmUgSW5mbyBUeXBlcw0KZGlmZiAtLWdpdCBhL2h3
L3ZmaW8vY29udGFpbmVyLmMgYi9ody92ZmlvL2NvbnRhaW5lci5jDQppbmRleCAyNmU2ZjdmYjRm
Li40YzNlOWU0NWMzIDEwMDY0NA0KLS0tIGEvaHcvdmZpby9jb250YWluZXIuYw0KKysrIGIvaHcv
dmZpby9jb250YWluZXIuYw0KQEAgLTExNDUsNiArMTE0NSw3IEBAIHN0YXRpYyBib29sIGhpb2Rf
bGVnYWN5X3ZmaW9fcmVhbGl6ZShIb3N0SU9NTVVEZXZpY2UgKmhpb2QsIHZvaWQgKm9wYXF1ZSwN
Cg0KICAgICBoaW9kLT5uYW1lID0gZ19zdHJkdXAodmRldi0+bmFtZSk7DQogICAgIGhpb2QtPmNh
cHMuYXdfYml0cyA9IHZmaW9fZGV2aWNlX2dldF9hd19iaXRzKHZkZXYpOw0KKyAgICBoaW9kLT5j
YXBzLmlvdmFfcmFuZ2VzID0gdmRldi0+YmNvbnRhaW5lci0+aW92YV9yYW5nZXM7DQoNCiAgICAg
cmV0dXJuIHRydWU7DQogfQ0KQEAgLTExNTcsNiArMTE1OCw4IEBAIHN0YXRpYyBpbnQgaGlvZF9s
ZWdhY3lfdmZpb19nZXRfY2FwKEhvc3RJT01NVURldmljZSAqaGlvZCwgaW50IGNhcCwNCiAgICAg
c3dpdGNoIChjYXApIHsNCiAgICAgY2FzZSBIT1NUX0lPTU1VX0RFVklDRV9DQVBfQVdfQklUUzoN
CiAgICAgICAgIHJldHVybiBjYXBzLT5hd19iaXRzOw0KKyAgICBjYXNlIEhPU1RfSU9NTVVfREVW
SUNFX0NBUF9JT1ZBX1JBTkdFUzoNCisgICAgICAgIHJldHVybiAxOw0KICAgICBkZWZhdWx0Og0K
ICAgICAgICAgZXJyb3Jfc2V0ZyhlcnJwLCAiJXM6IHVuc3VwcG9ydGVkIGNhcGFiaWxpdHkgJXgi
LCBoaW9kLT5uYW1lLCBjYXApOw0KICAgICAgICAgcmV0dXJuIC1FSU5WQUw7DQoNClRoYW5rcw0K
Wmhlbnpob25nDQo=

