Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5D124C25B74
	for <qemu-devel@archiver.kernel.org>; Tue,  4 Jun 2024 03:12:09 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sEKaY-00083m-8E; Mon, 03 Jun 2024 23:11:54 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <zhenzhong.duan@intel.com>)
 id 1sEKaW-00082Z-OL
 for qemu-devel@nongnu.org; Mon, 03 Jun 2024 23:11:53 -0400
Received: from mgamail.intel.com ([192.198.163.11])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <zhenzhong.duan@intel.com>)
 id 1sEKaU-00058I-1r
 for qemu-devel@nongnu.org; Mon, 03 Jun 2024 23:11:52 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1717470710; x=1749006710;
 h=from:to:cc:subject:date:message-id:references:
 in-reply-to:content-transfer-encoding:mime-version;
 bh=HXFndVHbJWYiiPk1bHvU6FpZUFJAB5oka9nU8a7ZjuE=;
 b=U7zwOAc2Cziy5saR/QaQIJcHwZ5qeLHr05bfS4mNaV9tFP+SmLbURP7f
 C8lG8D1z/wEyIjycHXtH3emKTOQbkRUXFJNzwMLmg61nKj2RjKKAFuIHK
 TvfksXT8RHSpRmVs1rzailgz3qOhAc+711Ub/PhScuZO/X+B/J7khZrCJ
 jgAy29JxgpXQdt41YuY+rbUTWWim3Q7d+Kygv8/PHu5wtwc7rV+rAk9XU
 U5O/psOK6oWISHPfHh6MMU0rzqSkpy3eQmnMJJIPPHQhmqZxcAkFiJbvD
 D7xpsB5lYcVrVbEnrUwfSZMDxtWLJ91ali4xBgw1qjc8K2ZQrC+B3C+E8 w==;
X-CSE-ConnectionGUID: Y3KudC3rTWKGQs/q0U4H/g==
X-CSE-MsgGUID: 3cQe7GB+Tzuc+jvxGxwKCA==
X-IronPort-AV: E=McAfee;i="6600,9927,11092"; a="24616438"
X-IronPort-AV: E=Sophos;i="6.08,213,1712646000"; d="scan'208";a="24616438"
Received: from orviesa009.jf.intel.com ([10.64.159.149])
 by fmvoesa105.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 03 Jun 2024 20:10:58 -0700
X-CSE-ConnectionGUID: MgyjvCXjRWKo3/0JRjmtnw==
X-CSE-MsgGUID: 3FLVyRnxSaK4RNhE3J42Wg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.08,213,1712646000"; d="scan'208";a="37147927"
Received: from orsmsx602.amr.corp.intel.com ([10.22.229.15])
 by orviesa009.jf.intel.com with ESMTP/TLS/AES256-GCM-SHA384;
 03 Jun 2024 20:10:58 -0700
Received: from orsmsx612.amr.corp.intel.com (10.22.229.25) by
 ORSMSX602.amr.corp.intel.com (10.22.229.15) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.39; Mon, 3 Jun 2024 20:10:57 -0700
Received: from orsmsx610.amr.corp.intel.com (10.22.229.23) by
 ORSMSX612.amr.corp.intel.com (10.22.229.25) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.39; Mon, 3 Jun 2024 20:10:57 -0700
Received: from ORSEDG602.ED.cps.intel.com (10.7.248.7) by
 orsmsx610.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.39 via Frontend Transport; Mon, 3 Jun 2024 20:10:57 -0700
Received: from NAM02-BN1-obe.outbound.protection.outlook.com (104.47.51.40) by
 edgegateway.intel.com (134.134.137.103) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.39; Mon, 3 Jun 2024 20:10:56 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=QintEmvmsxtXY2u0zAnGSPHNAFijUYTnOc0MG4TnT/V9OqKfg5z1YK3OuZQgM1r3gy/8IcS3nrpXVX4Q/U8/qMQHdCbg1UbyqiTvGDlWHHMdgyyg0N6GZ0AFdJajPnyrHeU3eDPtlptETzGi+m5fSClrtOesiCJEdlstCzdVSFtOgjNuVBKnZHmbqRZ4JMG4lMPrrEHvvqmd2tGCAid+CqcK3n+jcVX9rdcSDtVCyNWXJcXzxcul4Ucs6+shRrMUOglZwu97AcmaytRoe14fPsU8FjpTDttXqpbuqSRNKMvmpr2hfzuxv0dWbIkII/cCHtQ++BYHdFQ7+uulF7nAbg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=HXFndVHbJWYiiPk1bHvU6FpZUFJAB5oka9nU8a7ZjuE=;
 b=WYTk4e/mf45kS557VdES3BU798prUB0jPyu+7hSGfCzXPQ9YUeOXnTfXVBIrarbCL1wRfgEt6yNIM7dmgLLWy5/i+PQnFhItEvn+zpikY7s76uvutCVbCPPkCweyH4CesJUc7eYhyOrukrhGwHRlztLOO+6DMMtgPfpi6TVpdw3NAEWuDk/wBrXnbeJ8kQ5TgbfbYLzgS1KbKMWSXhCTthu7GVWqHRDEvojcHHz4rV6m1J+Nc4ZRmAitI6zgIdE0N6s+ppN4iyVlzqekpkxkhoWKLygTkETrJBKYkpXCjSOIt8VKDibNG2OaMQkc6r9bLGYcgHIc/j9EJKjzLfXrag==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Received: from SJ0PR11MB6744.namprd11.prod.outlook.com (2603:10b6:a03:47d::10)
 by SJ0PR11MB5007.namprd11.prod.outlook.com (2603:10b6:a03:2d2::8)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7633.27; Tue, 4 Jun
 2024 03:10:50 +0000
Received: from SJ0PR11MB6744.namprd11.prod.outlook.com
 ([fe80::fe49:d628:48b1:6091]) by SJ0PR11MB6744.namprd11.prod.outlook.com
 ([fe80::fe49:d628:48b1:6091%7]) with mapi id 15.20.7633.021; Tue, 4 Jun 2024
 03:10:50 +0000
From: "Duan, Zhenzhong" <zhenzhong.duan@intel.com>
To: =?utf-8?B?Q8OpZHJpYyBMZSBHb2F0ZXI=?= <clg@redhat.com>,
 "qemu-devel@nongnu.org" <qemu-devel@nongnu.org>
CC: "alex.williamson@redhat.com" <alex.williamson@redhat.com>,
 "eric.auger@redhat.com" <eric.auger@redhat.com>, "mst@redhat.com"
 <mst@redhat.com>, "peterx@redhat.com" <peterx@redhat.com>,
 "jasowang@redhat.com" <jasowang@redhat.com>, "jgg@nvidia.com"
 <jgg@nvidia.com>, "nicolinc@nvidia.com" <nicolinc@nvidia.com>,
 "joao.m.martins@oracle.com" <joao.m.martins@oracle.com>,
 "clement.mathieu--drif@eviden.com" <clement.mathieu--drif@eviden.com>, "Tian, 
 Kevin" <kevin.tian@intel.com>, "Liu, Yi L" <yi.l.liu@intel.com>, "Peng, Chao
 P" <chao.p.peng@intel.com>, Paolo Bonzini <pbonzini@redhat.com>
Subject: RE: [PATCH v6 01/19] backends: Introduce HostIOMMUDevice abstract
Thread-Topic: [PATCH v6 01/19] backends: Introduce HostIOMMUDevice abstract
Thread-Index: AQHatX0jqgrHzju/q0WIDks4ToP2p7G19MwAgAD5hEA=
Date: Tue, 4 Jun 2024 03:10:49 +0000
Message-ID: <SJ0PR11MB6744B93EB14D44E1E93CCFA892F82@SJ0PR11MB6744.namprd11.prod.outlook.com>
References: <20240603061023.269738-1-zhenzhong.duan@intel.com>
 <20240603061023.269738-2-zhenzhong.duan@intel.com>
 <753187fa-d165-46da-ba0c-f74683f5d850@redhat.com>
In-Reply-To: <753187fa-d165-46da-ba0c-f74683f5d850@redhat.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: SJ0PR11MB6744:EE_|SJ0PR11MB5007:EE_
x-ms-office365-filtering-correlation-id: 709e4223-b79c-4bd5-c86a-08dc8443efc7
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
 ARA:13230031|366007|376005|7416005|1800799015|38070700009; 
x-microsoft-antispam-message-info: =?utf-8?B?UEprNm5pME8zSis0KzV1ZTlib3MraDBJQUp3aTRPSWtKSjFtdkZXRS9nOVZB?=
 =?utf-8?B?bTBjQjdEeWZlN1VOcGZXS21lZEM5RmcrSjJNRjV0aGV4NVBOcUxSTnE4YjhY?=
 =?utf-8?B?UE5lNTJ1cjg1ZmxsdHczcGowelovNnFaSnZKekNWNVhBcG9nRkM0SFYvSndK?=
 =?utf-8?B?VE5tbWhEZDVMR0ZyaWVxQWVVYUFTWXVhQTZWVVB0MC9mRnMrR0lMYTlhMk9k?=
 =?utf-8?B?VVpPWjc5NjRBQU1hRWpNRVRBQURRODFGYy85b2NocG1HWkpkMisyQjlvQ2t5?=
 =?utf-8?B?dW9uYmg2eHNiV2tWYWYrdHIwNHpVQnVTZWhOMXZ1V1lGR3F0dlREWk1FbmhL?=
 =?utf-8?B?RGtHVjZBSm9KWU9EN1BqRVRPYitsTHZrZUw5QllIeEowYXVSaVpPRlRNS2xW?=
 =?utf-8?B?Z1hhelMvZk9MRnVLMXdlY3MxL1hxKzMrLzlHaXl3NVB0WGFoWG1MTnRaUDc4?=
 =?utf-8?B?S0ttWk05c29ISEpXMzg4S2UzMHNKTUVJcEJzeGpQaUtOK1ZSZGdoWis4MDFp?=
 =?utf-8?B?R0UwWGloTGM2UE80WkEraUk5NWhqMkJRNjB4UkJxVDZaWi92REl3NWo0SnZy?=
 =?utf-8?B?WWFnM0ordUQ0NHFXY3VETExJUmZxMzlDQ05YVnF6SnhUSkFhSWh3VGtsbmRs?=
 =?utf-8?B?dC8wM1lMZDVReG4xcVh5TVhmODZCSmkrMVZHUy9lbWNVUUhreURhb0gwK0U5?=
 =?utf-8?B?clE5a29aVHY3SEtESWFpTHUzQWlEZlN3OFFwM0NoelpVa0xURXdoeEpldEhM?=
 =?utf-8?B?NTlzWlVPVTNXVHpXMUZzcEY0MUFLSHNMTW1OcDhPVlUyYXBqZUNwTFl2d1Rw?=
 =?utf-8?B?V2VqSUVNZ2xIOTEvSDVheG94TkdCYXQ1VnZzQW95N0thRU50eG1BMEkva2Iy?=
 =?utf-8?B?ck5KMzRWRy9pWDVienpvYjMvYmVWQjV3OGNzcmtDbjVrdEZCcC95MXFVdGJm?=
 =?utf-8?B?YXFXWktRUm5zRFJjSjA5bDcySkxQb3RIRnlJYjQ0aGJFVGpVSncwRWdYaThv?=
 =?utf-8?B?dWl0dERTbXIrQzVDYjB5V1h0NUdqSGRzUG8zeFBWbDZyckpaL3g3Q1NGQmx1?=
 =?utf-8?B?UnFSOTFTdldtOTIvT1hnNjlvMjJMM2hSSmNmM1NQakpDMTNaeTVDekxrY2pn?=
 =?utf-8?B?V2k2dGtMd3RyYWhMby9mZDhLTkUvQ2p0T2NHMFFsN3hSWG5UYUZ3a3g2NDlp?=
 =?utf-8?B?cFdMQjA3T2VzZnRaRjM2OWxsZW1vOTVQNCtROHlVQkt1cnpNTlgyNmF6cm9W?=
 =?utf-8?B?NmZXSDE0dU9UZEh0UlpuRlBxT09VcytzcXJTZFkzaWlSZ3pVL0ViTlFNZVVw?=
 =?utf-8?B?N3pFMitPZmVMU2ZETmZNNkR5V1RKMklvdjdvbFB3UG5nbkd1djZqcUhYR095?=
 =?utf-8?B?OEozT1h4TERINjQybEdaZkkrY2ZtVm02Zi9OQWduSkVHSTExWkk5WktodW5j?=
 =?utf-8?B?OWhwRE1DSmpVZHM3SkFNdWZzcFFJNXdjenI4QU5qSVVTOVk1Z3dOeFBtRm12?=
 =?utf-8?B?Wit2Z2VOWDJvdzFHS09hbUhsUWZEbmJrRjJoVE9QbEFjNXRGZlJSSTZEVElq?=
 =?utf-8?B?QXZXRjNCZGFhOENSQkJwZDN5UndTbVpyZjlaa0pzWjJXdW5tMTNlRWU5R1V0?=
 =?utf-8?B?d25CODhRSEl1bHU4WjhPQkgxeVFRT2ZaMlVPS1NmMHZHVWlnd25jZEd0SHh3?=
 =?utf-8?B?RFdhTDQyZGU3cGdFbTZPZ1pwaTRoL3BLWDdhWUJaUmRmMVkyNHI3NjlBY25O?=
 =?utf-8?B?VWM5TllDVkRmOXlSNzRxMkRwVEE0UGtQYVJtUHg1emoxNlFVTkdwdmtiMVpI?=
 =?utf-8?B?SEQwYlgxOG1SVlpkL0tBdz09?=
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:SJ0PR11MB6744.namprd11.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230031)(366007)(376005)(7416005)(1800799015)(38070700009); DIR:OUT;
 SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?RFp4d1NEbVVKQVM4TTEzZ3lCTVVaVGI0NitZRXo3Sm5rbHFWMk5zR09NVThM?=
 =?utf-8?B?SFhqRVV5ZWlFU21xNUx5NDFHSEpIWUhmVm9IVHZjV3phcGFKWGhUSkZrVHRX?=
 =?utf-8?B?NDBudTI2Ulg2WDZxeng2OEVWeDVNamxtdnpXTVJBbnRkSVhBVVMvWnV0WlEx?=
 =?utf-8?B?Z1JyZEFJcnB6TlU0Q21xa3BHd2hZS0JIbWFFVHBEZHZNQkdSYWpyVjhRZ2NG?=
 =?utf-8?B?YU5DbEkxNUhEVVV3S0J0c1FuL0M2K0NnUy9CYXlRallVWE83VnR3ZFZYM0xN?=
 =?utf-8?B?WnRvOXJRdFc5c1NmZVdibzkrVlUzaWEvek5wUGllSVFJUVJxSjlBMzJRcmNi?=
 =?utf-8?B?dm8vbWxIWjNadU9vWFNFMUR2Q0dZUHdVU2ZDK3VSUUtidXZIb0wrUGNuNXla?=
 =?utf-8?B?R2pnSFk4RUtVMmM0R251cThDbzk4cDlxQzZBOHBtU3pxNDMwZFV1ZGtVOURn?=
 =?utf-8?B?SDAzWURERU9ERnBhUjRSWjJFaVA0ZksxSkRmbW1pNWpiMDE3MWw1VnBSVlVp?=
 =?utf-8?B?VmFsSWJISEdSVDNaWHF3VlpiRGNOUHNoaVZ6dEVseGlQc2hLb1psWXdhRkw1?=
 =?utf-8?B?UUowWkZLTUNSNzZqc0N5MExEbXdpaDdEZkpWM1NCVWg5STNWZkQ5cGVnaU42?=
 =?utf-8?B?aStaenpXUnhsaE8rZUlpTmpuR1c1a1pjakovSFZEMnhFV3Z5UXNMYlA3YTlG?=
 =?utf-8?B?SWQyT0NlWEdxaFgrZzIxTklVQzZicTkwM2N3Z2FhRDBXd20rSGZCVmhlYnlu?=
 =?utf-8?B?aGVmUkh5QmZhOTNpa0JVYnUzZFIrMkU1dzc0N2Z2N2w1blkwZFZnT3dIZU5E?=
 =?utf-8?B?N2J2TGVINXR0d3ZEM1dCNGVjWTdWU2M3OS9ycE14NjZQejNLdFBsZHdHVFp4?=
 =?utf-8?B?WUVXamdiODN6SUJxMXpGUmc4TDlaTERRNjFZWEZQbjJKd2s1YkVRSWxsNXFv?=
 =?utf-8?B?bFlLVTZBTzQ0TDNoYUxWT0ZpVXltbDdYWEZXUVJDdDhwdzRiTHVOaFJsZGxO?=
 =?utf-8?B?U1htRVZRVE94OHJVTHRVZlZVSlJ5Y285NGlMdUJZYkFOVklHR1pQR00zejhF?=
 =?utf-8?B?SUF3Nkt6MUtnYlBDbk9URldRZERvNHpxZ3dQRFNhTUEvam42ZW9CYkx5NEl2?=
 =?utf-8?B?eFVIdTh2bVR6dkNxYkFaeWtjaCtaMS81VkJSRE8vR0lOQW1UaHozTVc3R0h6?=
 =?utf-8?B?YVlZODl5RGJMa1NBazN5WGFodEhYWXRJZ1h0K0dCWDB1Mm9HYk5vOGJQdzFT?=
 =?utf-8?B?ZWFEbEVzN2dQdEZKWDNsN0Zsa1g5WnBOV1B1QWE5WGppdlZ1WWVMUVp5dkky?=
 =?utf-8?B?eTZDVU5RcUU4N3k3Yk83MjhJMEcrZkg4ZWRUdjU5MmlYZzJoaWRVVlE4b1cr?=
 =?utf-8?B?cVh1NDlxQkg1d3JrZlhKOWNmOFBQeDIrVDVkbkxJUHpCclN4VFl0ZmJ0SlM3?=
 =?utf-8?B?dnBZUStSOHlNWk0wZEVOc0IwcURTOUhpeDVUalRPNEY3WTk5d29UV3RGNzJ6?=
 =?utf-8?B?OVk0WW0vTWUxckpHTDU4RndSUVBYSkQ5L3NlZ2EyaXZPdCs4WU52ZDdjVWNp?=
 =?utf-8?B?UDd0SS9ibDI3V0kzRVk2Z09Dd0R2NkdQdHlPd29mWVFNTldTVnd0bGw2eTZm?=
 =?utf-8?B?R0J2cmdicEMreEQrRU84YWlweEdkRVBZYWJwQjlGL1IxOEowc0VhU1BMdURT?=
 =?utf-8?B?eXRZUXZjQ3l3TUw1ZzQ3TzEzdGg1M3FXMUl1OTRNL1VmWXl6MjJhQ0hmM2Ix?=
 =?utf-8?B?WmpDUWFlMncxclV1SUYwSTk5dUZUYjhPZ3U5MDNXOTllSFpDWG9qQVR0Rmhk?=
 =?utf-8?B?THgwQ1Z5aWZ2TXJ3QzJMc3dFcTFxbUNHTzl3UUk5Q1ZTWm1adWVTM2l3M1JF?=
 =?utf-8?B?VWJyRGtnNmVTL2FGWFV1ZDlQSjQrOXpNTGRnR01WdW0wR0Jyc0pWRCtYdkV0?=
 =?utf-8?B?MTl5QVAwdWxoTncvWUNYUHBiamp1QlRibm5sTWEvK1hjSlRGbW14WXpBeXYy?=
 =?utf-8?B?RFpJOWFpVUptTFVUUDN1QWQ0bTJWVTYrRnl2dHAvQnJXejlwMW1XUlQzUkk0?=
 =?utf-8?B?Njh6UEVUNG5heERtQ0s2Skc0TTMvV25LMEdpdUhESmYwSGkvMjRmZkxqZXBw?=
 =?utf-8?Q?NWkuodqzsDk005BX9KbuKbDDl?=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: SJ0PR11MB6744.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 709e4223-b79c-4bd5-c86a-08dc8443efc7
X-MS-Exchange-CrossTenant-originalarrivaltime: 04 Jun 2024 03:10:49.9700 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 6KQ14LVUxAr4Vbw+w8X460hVNcvdREWXzFdQGGWH6apTZOn3MmrxlAvfoLE1kGALLVGOc8I2JX7CaZQT51X2JL7etz6QSuY3QW4XO8I1eLc=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ0PR11MB5007
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

DQoNCj4tLS0tLU9yaWdpbmFsIE1lc3NhZ2UtLS0tLQ0KPkZyb206IEPDqWRyaWMgTGUgR29hdGVy
IDxjbGdAcmVkaGF0LmNvbT4NCj5TdWJqZWN0OiBSZTogW1BBVENIIHY2IDAxLzE5XSBiYWNrZW5k
czogSW50cm9kdWNlIEhvc3RJT01NVURldmljZQ0KPmFic3RyYWN0DQo+DQo+T24gNi8zLzI0IDA4
OjEwLCBaaGVuemhvbmcgRHVhbiB3cm90ZToNCj4+IEludHJvZHVjZSBIb3N0SU9NTVVEZXZpY2Ug
YXMgYW4gYWJzdHJhY3Rpb24gb2YgaG9zdCBJT01NVSBkZXZpY2UuDQo+Pg0KPj4gSW50cm9kdWNl
IC5yZWFsaXplKCkgdG8gaW5pdGlhbGl6ZSBIb3N0SU9NTVVEZXZpY2UgZnVydGhlciBhZnRlcg0K
Pj4gaW5zdGFuY2UgaW5pdC4NCj4+DQo+PiBJbnRyb2R1Y2UgYSBtYWNybyBDT05GSUdfSE9TVF9J
T01NVV9ERVZJQ0UgdG8gZGVmaW5lIHRoZSB1c2FnZQ0KPj4gZm9yIFZGSU8sIGFuZCBWRFBBIGlu
IHRoZSBmdXR1cmUuDQo+Pg0KPj4gU3VnZ2VzdGVkLWJ5OiBDw6lkcmljIExlIEdvYXRlciA8Y2xn
QHJlZGhhdC5jb20+DQo+PiBTaWduZWQtb2ZmLWJ5OiBaaGVuemhvbmcgRHVhbiA8emhlbnpob25n
LmR1YW5AaW50ZWwuY29tPg0KPj4gLS0tDQo+PiAgIE1BSU5UQUlORVJTICAgICAgICAgICAgICAg
ICAgICAgICAgfCAgMiArKw0KPj4gICBpbmNsdWRlL3N5c2VtdS9ob3N0X2lvbW11X2RldmljZS5o
IHwgNTENCj4rKysrKysrKysrKysrKysrKysrKysrKysrKysrKysNCj4+ICAgYmFja2VuZHMvaG9z
dF9pb21tdV9kZXZpY2UuYyAgICAgICB8IDMwICsrKysrKysrKysrKysrKysrKw0KPj4gICBiYWNr
ZW5kcy9LY29uZmlnICAgICAgICAgICAgICAgICAgIHwgIDUgKysrDQo+PiAgIGJhY2tlbmRzL21l
c29uLmJ1aWxkICAgICAgICAgICAgICAgfCAgMSArDQo+PiAgIDUgZmlsZXMgY2hhbmdlZCwgODkg
aW5zZXJ0aW9ucygrKQ0KPj4gICBjcmVhdGUgbW9kZSAxMDA2NDQgaW5jbHVkZS9zeXNlbXUvaG9z
dF9pb21tdV9kZXZpY2UuaA0KPj4gICBjcmVhdGUgbW9kZSAxMDA2NDQgYmFja2VuZHMvaG9zdF9p
b21tdV9kZXZpY2UuYw0KPj4NCj4+IGRpZmYgLS1naXQgYS9NQUlOVEFJTkVSUyBiL01BSU5UQUlO
RVJTDQo+PiBpbmRleCA0NDhkYzk1MWM1Li4xY2YyYjI1YmViIDEwMDY0NA0KPj4gLS0tIGEvTUFJ
TlRBSU5FUlMNCj4+ICsrKyBiL01BSU5UQUlORVJTDQo+PiBAQCAtMjE5Niw2ICsyMTk2LDggQEAg
TTogWmhlbnpob25nIER1YW4NCj48emhlbnpob25nLmR1YW5AaW50ZWwuY29tPg0KPj4gICBTOiBT
dXBwb3J0ZWQNCj4+ICAgRjogYmFja2VuZHMvaW9tbXVmZC5jDQo+PiAgIEY6IGluY2x1ZGUvc3lz
ZW11L2lvbW11ZmQuaA0KPj4gK0Y6IGJhY2tlbmRzL2hvc3RfaW9tbXVfZGV2aWNlLmMNCj4+ICtG
OiBpbmNsdWRlL3N5c2VtdS9ob3N0X2lvbW11X2RldmljZS5oDQo+PiAgIEY6IGluY2x1ZGUvcWVt
dS9jaGFyZGV2X29wZW4uaA0KPj4gICBGOiB1dGlsL2NoYXJkZXZfb3Blbi5jDQo+PiAgIEY6IGRv
Y3MvZGV2ZWwvdmZpby1pb21tdWZkLnJzdA0KPj4gZGlmZiAtLWdpdCBhL2luY2x1ZGUvc3lzZW11
L2hvc3RfaW9tbXVfZGV2aWNlLmgNCj5iL2luY2x1ZGUvc3lzZW11L2hvc3RfaW9tbXVfZGV2aWNl
LmgNCj4+IG5ldyBmaWxlIG1vZGUgMTAwNjQ0DQo+PiBpbmRleCAwMDAwMDAwMDAwLi4yYjU4YTk0
ZDYyDQo+PiAtLS0gL2Rldi9udWxsDQo+PiArKysgYi9pbmNsdWRlL3N5c2VtdS9ob3N0X2lvbW11
X2RldmljZS5oDQo+PiBAQCAtMCwwICsxLDUxIEBADQo+PiArLyoNCj4+ICsgKiBIb3N0IElPTU1V
IGRldmljZSBhYnN0cmFjdCBkZWNsYXJhdGlvbg0KPj4gKyAqDQo+PiArICogQ29weXJpZ2h0IChD
KSAyMDI0IEludGVsIENvcnBvcmF0aW9uLg0KPj4gKyAqDQo+PiArICogQXV0aG9yczogWmhlbnpo
b25nIER1YW4gPHpoZW56aG9uZy5kdWFuQGludGVsLmNvbT4NCj4+ICsgKg0KPj4gKyAqIFRoaXMg
d29yayBpcyBsaWNlbnNlZCB1bmRlciB0aGUgdGVybXMgb2YgdGhlIEdOVSBHUEwsIHZlcnNpb24g
Mi4gIFNlZQ0KPj4gKyAqIHRoZSBDT1BZSU5HIGZpbGUgaW4gdGhlIHRvcC1sZXZlbCBkaXJlY3Rv
cnkuDQo+PiArICovDQo+PiArDQo+PiArI2lmbmRlZiBIT1NUX0lPTU1VX0RFVklDRV9IDQo+PiAr
I2RlZmluZSBIT1NUX0lPTU1VX0RFVklDRV9IDQo+PiArDQo+PiArI2luY2x1ZGUgInFvbS9vYmpl
Y3QuaCINCj4+ICsjaW5jbHVkZSAicWFwaS9lcnJvci5oIg0KPj4gKw0KPj4gKyNkZWZpbmUgVFlQ
RV9IT1NUX0lPTU1VX0RFVklDRSAiaG9zdC1pb21tdS1kZXZpY2UiDQo+PiArT0JKRUNUX0RFQ0xB
UkVfVFlQRShIb3N0SU9NTVVEZXZpY2UsIEhvc3RJT01NVURldmljZUNsYXNzLA0KPkhPU1RfSU9N
TVVfREVWSUNFKQ0KPj4gKw0KPj4gK3N0cnVjdCBIb3N0SU9NTVVEZXZpY2Ugew0KPj4gKyAgICBP
YmplY3QgcGFyZW50X29iajsNCj4+ICt9Ow0KPj4gKw0KPj4gKy8qKg0KPj4gKyAqIHN0cnVjdCBI
b3N0SU9NTVVEZXZpY2VDbGFzcyAtIFRoZSBiYXNlIGNsYXNzIGZvciBhbGwgaG9zdCBJT01NVQ0K
PmRldmljZXMuDQo+PiArICoNCj4+ICsgKiBEaWZmZXJlbnQgdHlwZSBvZiBob3N0IGRldmljZXMg
KGUuZy4sIFZGSU8gb3IgVkRQQSBkZXZpY2UpIG9yIGRldmljZXMNCj4+ICsgKiB3aXRoIGRpZmZl
cmVudCBiYWNrZW5kIChlLmcuLCBWRklPIGxlZ2FjeSBjb250YWluZXIgb3IgSU9NTVVGRA0KPmJh
Y2tlbmQpDQo+PiArICogY2FuIGhhdmUgZGlmZmVyZW50IHN1Yi1jbGFzc2VzLg0KPj4gKyAqLw0K
Pj4gK3N0cnVjdCBIb3N0SU9NTVVEZXZpY2VDbGFzcyB7DQo+PiArICAgIE9iamVjdENsYXNzIHBh
cmVudF9jbGFzczsNCj4+ICsNCj4+ICsgICAgLyoqDQo+PiArICAgICAqIEByZWFsaXplOiBpbml0
aWFsaXplIGhvc3QgSU9NTVUgZGV2aWNlIGluc3RhbmNlIGZ1cnRoZXIuDQo+PiArICAgICAqDQo+
PiArICAgICAqIE1hbmRhdG9yeSBjYWxsYmFjay4NCj4+ICsgICAgICoNCj4+ICsgICAgICogQGhp
b2Q6IHBvaW50ZXIgdG8gYSBob3N0IElPTU1VIGRldmljZSBpbnN0YW5jZS4NCj4+ICsgICAgICoN
Cj4+ICsgICAgICogQG9wYXF1ZTogcG9pbnRlciB0byBhZ2VudCBkZXZpY2Ugb2YgdGhpcyBob3N0
IElPTU1VIGRldmljZSwNCj4+ICsgICAgICogICAgICAgICAgaS5lLiwgZm9yIFZGSU8sIHBvaW50
ZXIgdG8gVkZJT0RldmljZQ0KPj4gKyAgICAgKg0KPj4gKyAgICAgKiBAZXJycDogcGFzcyBhbiBF
cnJvciBvdXQgd2hlbiByZWFsaXplIGZhaWxzLg0KPj4gKyAgICAgKg0KPj4gKyAgICAgKiBSZXR1
cm5zOiB0cnVlIG9uIHN1Y2Nlc3MsIGZhbHNlIG9uIGZhaWx1cmUuDQo+PiArICAgICAqLw0KPj4g
KyAgICBib29sICgqcmVhbGl6ZSkoSG9zdElPTU1VRGV2aWNlICpoaW9kLCB2b2lkICpvcGFxdWUs
IEVycm9yICoqZXJycCk7DQo+PiArfTsNCj4+ICsjZW5kaWYNCj4+IGRpZmYgLS1naXQgYS9iYWNr
ZW5kcy9ob3N0X2lvbW11X2RldmljZS5jDQo+Yi9iYWNrZW5kcy9ob3N0X2lvbW11X2RldmljZS5j
DQo+PiBuZXcgZmlsZSBtb2RlIDEwMDY0NA0KPj4gaW5kZXggMDAwMDAwMDAwMC4uNDFmMmZkY2Uy
MA0KPj4gLS0tIC9kZXYvbnVsbA0KPj4gKysrIGIvYmFja2VuZHMvaG9zdF9pb21tdV9kZXZpY2Uu
Yw0KPj4gQEAgLTAsMCArMSwzMCBAQA0KPj4gKy8qDQo+PiArICogSG9zdCBJT01NVSBkZXZpY2Ug
YWJzdHJhY3QNCj4+ICsgKg0KPj4gKyAqIENvcHlyaWdodCAoQykgMjAyNCBJbnRlbCBDb3Jwb3Jh
dGlvbi4NCj4+ICsgKg0KPj4gKyAqIEF1dGhvcnM6IFpoZW56aG9uZyBEdWFuIDx6aGVuemhvbmcu
ZHVhbkBpbnRlbC5jb20+DQo+PiArICoNCj4+ICsgKiBUaGlzIHdvcmsgaXMgbGljZW5zZWQgdW5k
ZXIgdGhlIHRlcm1zIG9mIHRoZSBHTlUgR1BMLCB2ZXJzaW9uIDIuICBTZWUNCj4+ICsgKiB0aGUg
Q09QWUlORyBmaWxlIGluIHRoZSB0b3AtbGV2ZWwgZGlyZWN0b3J5Lg0KPj4gKyAqLw0KPj4gKw0K
Pj4gKyNpbmNsdWRlICJxZW11L29zZGVwLmgiDQo+PiArI2luY2x1ZGUgInN5c2VtdS9ob3N0X2lv
bW11X2RldmljZS5oIg0KPj4gKw0KPj4gK09CSkVDVF9ERUZJTkVfQUJTVFJBQ1RfVFlQRShIb3N0
SU9NTVVEZXZpY2UsDQo+PiArICAgICAgICAgICAgICAgICAgICAgICAgICAgIGhvc3RfaW9tbXVf
ZGV2aWNlLA0KPj4gKyAgICAgICAgICAgICAgICAgICAgICAgICAgICBIT1NUX0lPTU1VX0RFVklD
RSwNCj4+ICsgICAgICAgICAgICAgICAgICAgICAgICAgICAgT0JKRUNUKQ0KPj4gKw0KPj4gK3N0
YXRpYyB2b2lkIGhvc3RfaW9tbXVfZGV2aWNlX2NsYXNzX2luaXQoT2JqZWN0Q2xhc3MgKm9jLCB2
b2lkICpkYXRhKQ0KPj4gK3sNCj4+ICt9DQo+PiArDQo+PiArc3RhdGljIHZvaWQgaG9zdF9pb21t
dV9kZXZpY2VfaW5pdChPYmplY3QgKm9iaikNCj4+ICt7DQo+PiArfQ0KPj4gKw0KPj4gK3N0YXRp
YyB2b2lkIGhvc3RfaW9tbXVfZGV2aWNlX2ZpbmFsaXplKE9iamVjdCAqb2JqKQ0KPj4gK3sNCj4+
ICt9DQo+PiBkaWZmIC0tZ2l0IGEvYmFja2VuZHMvS2NvbmZpZyBiL2JhY2tlbmRzL0tjb25maWcN
Cj4+IGluZGV4IDJjYjIzZjYyZmEuLjM0YWIyOWU5OTQgMTAwNjQ0DQo+PiAtLS0gYS9iYWNrZW5k
cy9LY29uZmlnDQo+PiArKysgYi9iYWNrZW5kcy9LY29uZmlnDQo+PiBAQCAtMywzICszLDggQEAg
c291cmNlIHRwbS9LY29uZmlnDQo+PiAgIGNvbmZpZyBJT01NVUZEDQo+PiAgICAgICBib29sDQo+
PiAgICAgICBkZXBlbmRzIG9uIFZGSU8NCj4+ICsNCj4+ICtjb25maWcgSE9TVF9JT01NVV9ERVZJ
Q0UNCj4+ICsgICAgYm9vbA0KPj4gKyAgICBkZWZhdWx0IHkNCj4+ICsgICAgZGVwZW5kcyBvbiBW
RklPDQo+DQo+QW5kIHlvdSBjYW4gZHJvcCBIT1NUX0lPTU1VX0RFVklDRSBjb25maWcNCg0KV2ls
bCBkby4NCg0KPg0KPj4gZGlmZiAtLWdpdCBhL2JhY2tlbmRzL21lc29uLmJ1aWxkIGIvYmFja2Vu
ZHMvbWVzb24uYnVpbGQNCj4+IGluZGV4IDhiMmIxMTE0OTcuLjJlOTc1ZDY0MWUgMTAwNjQ0DQo+
PiAtLS0gYS9iYWNrZW5kcy9tZXNvbi5idWlsZA0KPj4gKysrIGIvYmFja2VuZHMvbWVzb24uYnVp
bGQNCj4+IEBAIC0yNSw2ICsyNSw3IEBAIGlmIGhhdmVfdmhvc3RfdXNlcg0KPj4gICBlbmRpZg0K
Pj4gICBzeXN0ZW1fc3MuYWRkKHdoZW46ICdDT05GSUdfVklSVElPX0NSWVBUTycsIGlmX3RydWU6
IGZpbGVzKCdjcnlwdG9kZXYtDQo+dmhvc3QuYycpKQ0KPj4gICBzeXN0ZW1fc3MuYWRkKHdoZW46
ICdDT05GSUdfSU9NTVVGRCcsIGlmX3RydWU6IGZpbGVzKCdpb21tdWZkLmMnKSkNCj4+ICtzeXN0
ZW1fc3MuYWRkKHdoZW46ICdDT05GSUdfSE9TVF9JT01NVV9ERVZJQ0UnLCBpZl90cnVlOg0KPmZp
bGVzKCdob3N0X2lvbW11X2RldmljZS5jJykpDQo+DQo+YW5kIEkgd291bGQgbW92ZSBob3N0X2lv
bW11X2RldmljZS5jIGJ1aWxkIHVuZGVyIGhvc3Rfb3MgPT0gJ2xpbnV4Jw0KDQpXaWxsIGRvLg0K
DQpUaGFua3MNClpoZW56aG9uZw0KDQo=

