Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5E2BDC04FFE
	for <qemu-devel@archiver.kernel.org>; Wed,  8 May 2024 06:36:28 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1s4auR-0004cC-5e; Wed, 08 May 2024 02:36:11 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <zhenzhong.duan@intel.com>)
 id 1s4auP-0004bz-Ju
 for qemu-devel@nongnu.org; Wed, 08 May 2024 02:36:09 -0400
Received: from mgamail.intel.com ([192.198.163.13])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <zhenzhong.duan@intel.com>)
 id 1s4auN-0002Ub-Qo
 for qemu-devel@nongnu.org; Wed, 08 May 2024 02:36:09 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1715150168; x=1746686168;
 h=from:to:cc:subject:date:message-id:references:
 in-reply-to:content-transfer-encoding:mime-version;
 bh=YOdYCPhuUzq2AVSFsIY5uLmx19k/BDcB82/DPzNaVqM=;
 b=i/Hv8RPx5pAKX5EO81uC3D7OxnbBMZD0BnCyTjH3rYYA2iiNrN8Eta3a
 ovsTg76MfYu9OYTRIJnwDSoUMqXzVywXQXas5iBU/FOJkG34D1jhXQxeK
 0SjCc++iE7dHUJZX95OCcDZhlGkm8sksx/slgASMaNzKbQgAGB6zxbv3N
 E3QrXOrJgXYqc5zMMsPGFOTZyJ4ydAyFR2gMMekd2H6r4a4ijAbxDSedI
 7A39Ss3jbVeraS+ItQlt2rKyxrPvEMCQk8b+bwKeMRNMYpbTjCLwvGTgH
 L8wswy/JM7y5f1Cs5CNMj1arMRbV2MHAjLUMek9cmTObsVA2ff6zMz2ic A==;
X-CSE-ConnectionGUID: Lre9vRr/TaG8uuZxyaagwA==
X-CSE-MsgGUID: aZK0880uRVKDVoHh79BPkg==
X-IronPort-AV: E=McAfee;i="6600,9927,11066"; a="13936874"
X-IronPort-AV: E=Sophos;i="6.08,144,1712646000"; d="scan'208";a="13936874"
Received: from orviesa009.jf.intel.com ([10.64.159.149])
 by fmvoesa107.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 07 May 2024 23:36:05 -0700
X-CSE-ConnectionGUID: g88Wiv6cQ8CyzR1us9AlMA==
X-CSE-MsgGUID: Zb7EBNYMQU2U+QOMYOhStw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.08,144,1712646000"; d="scan'208";a="28869249"
Received: from fmsmsx603.amr.corp.intel.com ([10.18.126.83])
 by orviesa009.jf.intel.com with ESMTP/TLS/AES256-GCM-SHA384;
 07 May 2024 23:36:04 -0700
Received: from fmsmsx611.amr.corp.intel.com (10.18.126.91) by
 fmsmsx603.amr.corp.intel.com (10.18.126.83) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35; Tue, 7 May 2024 23:36:04 -0700
Received: from fmsmsx610.amr.corp.intel.com (10.18.126.90) by
 fmsmsx611.amr.corp.intel.com (10.18.126.91) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35; Tue, 7 May 2024 23:36:03 -0700
Received: from FMSEDG603.ED.cps.intel.com (10.1.192.133) by
 fmsmsx610.amr.corp.intel.com (10.18.126.90) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35 via Frontend Transport; Tue, 7 May 2024 23:36:03 -0700
Received: from NAM10-BN7-obe.outbound.protection.outlook.com (104.47.70.101)
 by edgegateway.intel.com (192.55.55.68) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.35; Tue, 7 May 2024 23:36:03 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=cGbRJ18xZW1L53mhSKMWFrWa3ASW/uic0XLBtgBYsZcIj+n4n36pQBvd4+nh2nhWgcHqmAPn28T5nZT2IPxtbRRu5Eu52+IG9uvWW+sBLHpdtcdWDDaoo60C3dWwdGl9VizLFLgROVGIVN/G9it1QNb2GoJcrsz+6ld2YvDciO673bwA27xDcIaphV3+RH9RmqeKxw9PwucO9LWJ2cP/UCmLiXCOdErjhVEvDZZd2Ep6dPzJ85fxTd77lRTWI64QoQWPC7L8O9zYSnmbS1SoIU+UK8hggzGcZOh6lts0s8EjPXa+nlLDze63YmL2i8E3LBsx8eaNDADyDmdGuZfp2A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=YOdYCPhuUzq2AVSFsIY5uLmx19k/BDcB82/DPzNaVqM=;
 b=DEj5zuMqrIXDL4Jxi76J/TL2SGy5f87rMFT0lE508JmiNs0RdX7sgLhbbQ4ieCBs6sFMIS1yq0xK8gD96Nh+MKgcGJUtpS2Oqjwf9VIJFSezKXax5hG89KW9TjQoSPINWKKN4kP8/bZxO6gQYRjCdqU82j6i17v7YlZk899GvmeQeHngNwmH15ObG02ef++bDuDcNl2T4f5kM4fr6hnltojy4ffiO6LCu0nG9X1cbJEZz5O14SP7YL9O1RYkUT1aceuIBP6/oFZ8m3hQQt9k8LiOEnn1QOgR/Wa6EMKB8JY2iVBg16l3CddRPBGgIc8JLZ/afqQ8iiayBARYIjv1Yg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Received: from SJ0PR11MB6744.namprd11.prod.outlook.com (2603:10b6:a03:47d::10)
 by DS7PR11MB7835.namprd11.prod.outlook.com (2603:10b6:8:db::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7544.42; Wed, 8 May
 2024 06:36:01 +0000
Received: from SJ0PR11MB6744.namprd11.prod.outlook.com
 ([fe80::e4a3:76ce:879:9129]) by SJ0PR11MB6744.namprd11.prod.outlook.com
 ([fe80::e4a3:76ce:879:9129%7]) with mapi id 15.20.7544.041; Wed, 8 May 2024
 06:36:01 +0000
From: "Duan, Zhenzhong" <zhenzhong.duan@intel.com>
To: Jason Gunthorpe <jgg@nvidia.com>
CC: =?iso-8859-1?Q?C=E9dric_Le_Goater?= <clg@redhat.com>,
 "qemu-devel@nongnu.org" <qemu-devel@nongnu.org>, "alex.williamson@redhat.com"
 <alex.williamson@redhat.com>, "eric.auger@redhat.com"
 <eric.auger@redhat.com>, "mst@redhat.com" <mst@redhat.com>,
 "peterx@redhat.com" <peterx@redhat.com>, "jasowang@redhat.com"
 <jasowang@redhat.com>, "nicolinc@nvidia.com" <nicolinc@nvidia.com>,
 "joao.m.martins@oracle.com" <joao.m.martins@oracle.com>, "Tian, Kevin"
 <kevin.tian@intel.com>, "Liu, Yi L" <yi.l.liu@intel.com>, "Peng, Chao P"
 <chao.p.peng@intel.com>
Subject: RE: [PATCH v3 00/19] Add a host IOMMU device abstraction to check
 with vIOMMU
Thread-Topic: [PATCH v3 00/19] Add a host IOMMU device abstraction to check
 with vIOMMU
Thread-Index: AQHamgH7eck8+te5Z0qCq1cTh3hQ5rGFkZiAgAPqERCAAKvBgIAA6+uQgACkbwCAATbbEA==
Date: Wed, 8 May 2024 06:36:01 +0000
Message-ID: <SJ0PR11MB6744706ACB28CBDFF05FF51F92E52@SJ0PR11MB6744.namprd11.prod.outlook.com>
References: <20240429065046.3688701-1-zhenzhong.duan@intel.com>
 <c245b234-60d5-4ee6-a947-c7526d58698e@redhat.com>
 <SJ0PR11MB6744A435E58FC69DF37AA148921C2@SJ0PR11MB6744.namprd11.prod.outlook.com>
 <20240506120541.GG3341011@nvidia.com>
 <SJ0PR11MB6744C6038585F0014429C27292E42@SJ0PR11MB6744.namprd11.prod.outlook.com>
 <20240507115836.GL3341011@nvidia.com>
In-Reply-To: <20240507115836.GL3341011@nvidia.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: SJ0PR11MB6744:EE_|DS7PR11MB7835:EE_
x-ms-office365-filtering-correlation-id: a3910085-2444-4ecd-c0ce-08dc6f2920b7
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
 ARA:13230031|1800799015|7416005|366007|376005|38070700009; 
x-microsoft-antispam-message-info: =?iso-8859-1?Q?Nc8JK4EDTmvdrU1H/kV1hkzMayA1SeaA3UieEUY7YhmUa5JdamFeJVb2SE?=
 =?iso-8859-1?Q?YrdFN81JRr8fzJR4LwrVapzkXTfTOMxRHpN5dwqlSTVpON5G59E6ne05bY?=
 =?iso-8859-1?Q?ZaslRDV3J6ih/c/L+1h5ArL5DqPnV/BTEPl/TbpJ23gCPTdvMdNQNS7Exa?=
 =?iso-8859-1?Q?UTGPsFbJE0kTP9biekZTalxZl0Ojc/7foa4KPXaQ/Qoya+ESiMBvpo/FmE?=
 =?iso-8859-1?Q?348hY/q/0BEWRgGthkidN21XtNtu+Ou7RpPIn/Y1ZhJQDy9EY2H+AQ1o4q?=
 =?iso-8859-1?Q?SPizdhZc2u80zXMDf6jpgHJWj50kvdpbi8LQZOhU3JOl4L8QNJDWjlf5ij?=
 =?iso-8859-1?Q?VBKxOb+AymFYWbXO4XYroRuXgSVNsOvxZ20Ao8sjjqQ5iLZ7NNbHg74pYF?=
 =?iso-8859-1?Q?E0ZT3yO8P6IE/OW9Mdf5xOj8TjnxR4CiqJuObU2dCUPtmjjXn8Gsr2RUXg?=
 =?iso-8859-1?Q?CllsrzE3Gv7JWCBWcc6On1V+MXYNi9RRpQqVreS9APkFMtGjO0LRRGCfnP?=
 =?iso-8859-1?Q?5GxCRyFdE9xcGdwJY0ZSm7EtXCZkL/ksQJUs4r52MBaD91iuK1QBb5IU4E?=
 =?iso-8859-1?Q?sd3fGvhorIBWhpkfMONDSWhgZ3RPgL+1RMwGuXsR57+Kx2p0sqs5yP8eFU?=
 =?iso-8859-1?Q?VVIfgr+3Ly6XtNrZEWf/qN7/mCVGnpySWnQ0JERmh61sE+oVKSeQcc+ShY?=
 =?iso-8859-1?Q?sTKsUGaJwpEtJkHveyqA3RP+1iUEA64thWIEQd+98Qnwoik9NmWT9jJATV?=
 =?iso-8859-1?Q?7J1jkUVDVuhTh9usnBjAsxflQFoCMHGKYfGWlKF4ZW2kYKJ986SkhljY4/?=
 =?iso-8859-1?Q?J8a3ZPQhc7uEyJ7dE9ZYBOkkONFNdO0uY6kVusTGsyAw+XavEE6yA9YJO0?=
 =?iso-8859-1?Q?XMg/IiMB7ZF6WGiuMTGJUWd86fqt4tO4awxlVKwgLnCOUqVlilapBSyPbI?=
 =?iso-8859-1?Q?XHdCc4MRX89E/kotdAuJOgiaAvB2vCHNdgugH5SRMTsxZOE469wGBPiOT4?=
 =?iso-8859-1?Q?otOn6qQcgC+kIK5ohw6IrXWKVLg55oH1SJYSLXUH0n6UNIjMikqHyvALaz?=
 =?iso-8859-1?Q?HfFVLVn45apijLhU5f+vi9yYcDWwEZA9pjyhhOQQVVJc2wOnJ+zm3HNiB5?=
 =?iso-8859-1?Q?cufjiEWn3UZHIuHDXFofTFOkEZczGrxhExSRKZjFNuwNSgbuA4tzy1eP5Z?=
 =?iso-8859-1?Q?1VAedW7dYUpTy6xVzRW+maVR5M7EvIMkyCw9tOPTMidvKRWo3ctgFgw2XH?=
 =?iso-8859-1?Q?hF2BIKbhe2R93NRAQuyiurZQh8vHgQTz/5y1iFhsgWqjody8y+t9CbHu6T?=
 =?iso-8859-1?Q?GOmRhbIzzwCtXmK4IcwSQ3++uQjgnD9afFfVyW9vRDM7+A3iVWcX47q37m?=
 =?iso-8859-1?Q?8l038WN+GlfXVB4nxPLbGmbmtsxkM59A=3D=3D?=
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:SJ0PR11MB6744.namprd11.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230031)(1800799015)(7416005)(366007)(376005)(38070700009); DIR:OUT;
 SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?iso-8859-1?Q?fPp9KFbxlizrPZDriJo6jBhnuupYMEAAiAHpNVlJgvV0xxCxVr5dId/plQ?=
 =?iso-8859-1?Q?gOjsy0zqPJeMk7MER3yQoYHEHcgaL8xYuzKPJpRdIonfd7JkaRZLdNqpg2?=
 =?iso-8859-1?Q?adZUCI+ckcd1zBJNl7y/dhOeWyCnZh3ORgAI4XQ42Xovd9AWD5kYYctI7e?=
 =?iso-8859-1?Q?MpxHHZpGpJkdZdW0WeRKviovcFzUDDymsquDNTaIZttUGDRsAzg+jD81U7?=
 =?iso-8859-1?Q?0k5d5ktnVQ+8Bsv59g35/0mqRnCS1FrSxZkeUqOtMBttp2wWvQOsjl8U2W?=
 =?iso-8859-1?Q?L3Uw9oIQcfl+nPCuzCJg27stvMa3MQROwSgnGh44WF+uNOy8HksaxbDHOL?=
 =?iso-8859-1?Q?H/HjVPB95R02qpUMYhNvcuTU5PJ0di67pv7aef3k4qCIIEhlyoDXYg3U0G?=
 =?iso-8859-1?Q?My2sRoYyDddpfGn64DM85aRUUeookb3tCj/Wi8mSbCmLplwj8QbX/PLTR3?=
 =?iso-8859-1?Q?ds9tI8SaZvW4wo8tvqHL/hiDzYhp0NLQZcUX2EqCm7vuqMYBXzqYkqibKP?=
 =?iso-8859-1?Q?bF9XUadnnlGTsL5dF4AAIgYz4zOAJoJl5PYb9qE2dIRleHkoUmy0I2M8sf?=
 =?iso-8859-1?Q?4vEzzELFxfZoIehy1XBisPb5CwshpWO+IWmr4LDMElUlFKy+tJfqJD4rsl?=
 =?iso-8859-1?Q?/QEbtQUEmshqBtdQkbnLFXT58oaeBp24tfulpImrKJ68gbnvi3237wpnn3?=
 =?iso-8859-1?Q?nUvE8bP+O/adHt5SQijuboSGIp7NhnuvKX1HbkRFwoaAiHjdREV9K9lM3L?=
 =?iso-8859-1?Q?L1zMGDzxLExkbGY4ydlL9jeqrjtZvnZnoc/DCpxdwjsU8jAWJ2n/SmIo2g?=
 =?iso-8859-1?Q?e8ZcCx2ycFA08C95nD09RLDIdXpf27jP9CGSw8z1/fqSbLVTcgfRSmoltf?=
 =?iso-8859-1?Q?pfEuHcN6xOE8AcLz7W13kwfnGqoGpfaHtSgL0m1tQ1J7efAif7AXtLiW/X?=
 =?iso-8859-1?Q?ej9dlqg/LxtkLWz5J5Fdt6rclFQUe/oUVyMdTxbeDkfKbsoULG4/HdEWMm?=
 =?iso-8859-1?Q?nbhC0c4cxjYChL/+pHQP17FISJXXU6otRe66YxZtm1tNqVho+cjiHT5Jlx?=
 =?iso-8859-1?Q?SagFUuQr40GkN18z7auL0AV5CGsmDcE2M9CBSOe04BHEtNZvzo8Jza4DIN?=
 =?iso-8859-1?Q?K7P0gqYOxBTZ6S5P6o7h0BWDed1sBf6GBdsUrXecskaYoml5N6PBiGcJKB?=
 =?iso-8859-1?Q?m0xBwRg1egojF32Xj9HBLmJFMdIAmNY97xqlsEPmh1Sr5XKmiVmvLw/OcC?=
 =?iso-8859-1?Q?Tm8LgvtXC3ogdNra+dkyxP77d2ZUmC+0RMQN7uVlDGMQfJMOc8Q4FmHpGD?=
 =?iso-8859-1?Q?lhxT6rhiRe3QpWiZaS3sPfH5W8WyV1JD9GvUdjVuSaY090qiK9iuWrUfog?=
 =?iso-8859-1?Q?4XH9dKDx1M/yuRLMvqgu/jPQrmYwQ0IAzHhkdGHKIiHnDA7jLmOmPnScJq?=
 =?iso-8859-1?Q?SMJ95cvwnObOwoq1B9dYgnxEq4FPrWWhgOtE/qZ8c3bTZTWvxj5KVYURL5?=
 =?iso-8859-1?Q?39RgIDl8Oc15AX2U+z5sA0o/3Nu/wthKw/nfxElkKK72gNujg4YjW+HIsQ?=
 =?iso-8859-1?Q?LU5rvtuMstgJPBp0q214i22cdlWU+vL8XLQ4rE3RQ81qjHLgfMCRmOxVrF?=
 =?iso-8859-1?Q?4IgSBndS3fFXDTLFoEoIDMnBJOR2lUm4BD?=
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: SJ0PR11MB6744.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: a3910085-2444-4ecd-c0ce-08dc6f2920b7
X-MS-Exchange-CrossTenant-originalarrivaltime: 08 May 2024 06:36:01.2772 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: GHDsujZyK/DaYTXdoAGB8j0TilTgBfMezov/hePKUwGW/j3htQaYq6ppBbAfINbk6gVSiKJhCm6xk7wQgEfkwBaRrjP36JKXrxn/m8yErAc=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS7PR11MB7835
X-OriginatorOrg: intel.com
Received-SPF: pass client-ip=192.198.163.13;
 envelope-from=zhenzhong.duan@intel.com; helo=mgamail.intel.com
X-Spam_score_int: -49
X-Spam_score: -5.0
X-Spam_bar: -----
X-Spam_report: (-5.0 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.581,
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



>-----Original Message-----
>From: Jason Gunthorpe <jgg@nvidia.com>
>Subject: Re: [PATCH v3 00/19] Add a host IOMMU device abstraction to
>check with vIOMMU
>
>On Tue, May 07, 2024 at 02:24:30AM +0000, Duan, Zhenzhong wrote:
>> >On Mon, May 06, 2024 at 02:30:47AM +0000, Duan, Zhenzhong wrote:
>> >
>> >> I'm not clear how useful multiple iommufd instances support are.
>> >> One possible benefit is for security? It may bring a slightly fine-gr=
ained
>> >> isolation in kernel.
>> >
>> >No. I don't think there is any usecase, it is only harmful.
>>
>> OK, so we need to limit QEMU to only one iommufd instance.
>
>I don't know about limit, but you don't need to do extra stuff to make
>it work.
>
>The main issue will be to get all the viommu instances to share the
>same iommufd IOAS for the guest physical mapping. Otherwise each
>viommu should be largely unware of the others sharing (or not) a
>iommufd.

I see.

>
>If you can structure things properly it probably doesn't need a hard
>limit, it will just work worse.

OK, thanks for clarify.
The extra code to support multiple instances in intel_iommu is trivial.
So I'd like to keep this flexibility to user just like cdev. User can confi=
gure
QEMU cmdline to use one IOMMUFD instance easily whenever they want.

Thanks
Zhenzhong

