Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0F62FC25B10
	for <qemu-devel@archiver.kernel.org>; Sat, 11 May 2024 02:52:20 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1s5cpX-0004FH-4u; Fri, 10 May 2024 22:51:23 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <chen.zhang@intel.com>)
 id 1s5cpT-0004EI-QL
 for qemu-devel@nongnu.org; Fri, 10 May 2024 22:51:21 -0400
Received: from mgamail.intel.com ([192.198.163.11])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <chen.zhang@intel.com>)
 id 1s5cpR-0001bY-16
 for qemu-devel@nongnu.org; Fri, 10 May 2024 22:51:19 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1715395877; x=1746931877;
 h=from:to:cc:subject:date:message-id:references:
 in-reply-to:content-transfer-encoding:mime-version;
 bh=WyvY66pjTuM4NKus1nb0JE5kCSkPxAU1+mzNaAMt3cw=;
 b=nn7j61wXdzpELyNJuWJUBe7JlmidebIxtGZqAvUK/YbZ1/8AC0FKVVWU
 MXf5+HXOWgdTAjUQ7ZEPgXykfh1HkS8wnGOzQvhULnHWRTLCs+EExkp+2
 GWJlMvB7oXi7GQ59TrUUQpllbR4GnhgzMdXWSRj6Jvlwv7QxQr6CPX7Id
 H28whlTdLveqb1DYGg4Popxl37wM7T5eqxIY2WFALxQh3x6vsL3+l5JTn
 O/sLAhYA9/XJ6GO1AP4S0kZoQJ0/inY34filwJLvzHu1IeJrVRZmp7faN
 j2z2ewNdOqJM1psErt5lua4jPVPBp6emby395s6ScMTGgF9tzRZ+hnF2n A==;
X-CSE-ConnectionGUID: Afqdzoc8Sti+pF8aM7/kLA==
X-CSE-MsgGUID: Dd5BN3gsTQCVwQGuAJGDCQ==
X-IronPort-AV: E=McAfee;i="6600,9927,11069"; a="22002472"
X-IronPort-AV: E=Sophos;i="6.08,152,1712646000"; d="scan'208";a="22002472"
Received: from fmviesa010.fm.intel.com ([10.60.135.150])
 by fmvoesa105.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 10 May 2024 19:51:13 -0700
X-CSE-ConnectionGUID: I7NaV1wASbCBepL9VfpSjw==
X-CSE-MsgGUID: VWnBj0PRSueShXZCVKOP2Q==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.08,152,1712646000"; d="scan'208";a="29870343"
Received: from orsmsx601.amr.corp.intel.com ([10.22.229.14])
 by fmviesa010.fm.intel.com with ESMTP/TLS/AES256-GCM-SHA384;
 10 May 2024 19:51:12 -0700
Received: from orsmsx610.amr.corp.intel.com (10.22.229.23) by
 ORSMSX601.amr.corp.intel.com (10.22.229.14) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35; Fri, 10 May 2024 19:51:12 -0700
Received: from orsmsx602.amr.corp.intel.com (10.22.229.15) by
 ORSMSX610.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35; Fri, 10 May 2024 19:51:12 -0700
Received: from ORSEDG602.ED.cps.intel.com (10.7.248.7) by
 orsmsx602.amr.corp.intel.com (10.22.229.15) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35 via Frontend Transport; Fri, 10 May 2024 19:51:12 -0700
Received: from NAM11-BN8-obe.outbound.protection.outlook.com (104.47.58.171)
 by edgegateway.intel.com (134.134.137.103) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.35; Fri, 10 May 2024 19:51:11 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=PtVh9oUUZx3f+21HbuB4PbZ9c3WoxfKQLh1WV9DcDJQFvzsJDKZvOdc8vMFHEz0+X2k6GxQCIViU9gXYVTv/IsjFYJECUe7WYggq1KeAf9rslZ5aOsBfG2fGRN/qrWLZjyBhVuH4EpMKwOUZlVsqd8n1XXcfmJEjHmJcMV6NgpVJtwqYlt21rsgFT+TW2KfcQlRFSB1QYwZxG0Lic1klFKwj6hK7uURYlStS8E3b5rvlofCyT2ZlTcT75NM5mHgJlx0HFVNhHKSIryvf2bYb5ZZLt7yMH9O2+ptBh3mQXLc+lxgqAld09JP05ScQvkXOVqzlljLgOCTpe33RoAjBbA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=4oTZeNJlSGU+w9shV1g6fHfS07uxcZSiEVqqUhU1bGo=;
 b=INshzw9sR/+mNl/DrsAn1jSxOJXntpfmchBo9/1shgjziSPh0unwNqGNYmdRzBVov0dA1SjB9GjhS/gVJBNSmzCQrcTtwF0yZBteflhC84sKb8XLSucCESNOa0RQ4EGPlWaeotPL9WSRUD+xCXRznNNt2DvQA/ZBrkcZrnk7AYa90sqI/06uBG59+vLCVMw18SkX2EoQSZYxTx9kUjsOzsmR98izSkuxCHbRAvJXNYoKWvdITjWmiUrVUltBrVhDT3F6OGkCvcKX5g3h+3fpC1HeLBADBaiKXjvE1WGKkoSK5+i30H2eJNJAjgPheE73juo7Fu6mzGwTtluM1aXbKg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Received: from CYYPR11MB8432.namprd11.prod.outlook.com (2603:10b6:930:be::8)
 by CH3PR11MB8155.namprd11.prod.outlook.com (2603:10b6:610:164::21) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7544.55; Sat, 11 May
 2024 02:51:09 +0000
Received: from CYYPR11MB8432.namprd11.prod.outlook.com
 ([fe80::60a7:2a84:f3d8:2828]) by CYYPR11MB8432.namprd11.prod.outlook.com
 ([fe80::60a7:2a84:f3d8:2828%6]) with mapi id 15.20.7519.020; Sat, 11 May 2024
 02:51:09 +0000
From: "Zhang, Chen" <chen.zhang@intel.com>
To: Li Zhijian <lizhijian@fujitsu.com>, Peter Xu <peterx@redhat.com>, "Fabiano
 Rosas" <farosas@suse.de>
CC: "Zhang, Hailiang" <zhanghailiang@xfusion.com>, "qemu-devel@nongnu.org"
 <qemu-devel@nongnu.org>
Subject: RE: [PATCH 2/3] migration/colo: make colo_incoming_co() return void
Thread-Topic: [PATCH 2/3] migration/colo: make colo_incoming_co() return void
Thread-Index: AQHaocDiY8ApkZ9GJUqcbq28/aQGn7GRWJDw
Date: Sat, 11 May 2024 02:51:08 +0000
Message-ID: <CYYPR11MB8432B415EF223A67411BAEF29BE02@CYYPR11MB8432.namprd11.prod.outlook.com>
References: <20240509033106.1321880-1-lizhijian@fujitsu.com>
 <20240509033106.1321880-2-lizhijian@fujitsu.com>
In-Reply-To: <20240509033106.1321880-2-lizhijian@fujitsu.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: CYYPR11MB8432:EE_|CH3PR11MB8155:EE_
x-ms-office365-filtering-correlation-id: 3ddd4b83-766a-49ad-da07-08dc716535ec
x-ld-processed: 46c98d88-e344-4ed4-8496-4ed7712e255d,ExtAddr
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0; ARA:13230031|366007|1800799015|376005|38070700009;
x-microsoft-antispam-message-info: =?us-ascii?Q?ttlC9T6t4ktEAaxE05oL9hzS4vaIU7YcYd5flrvOwvA+8kwnglbKYR5bi3Pe?=
 =?us-ascii?Q?NwijVC/71Ve2uaSkYO7FPZvzqbHEHNJZ9GiegJ9IzzOC1HqxJcP/hQ2sYa+B?=
 =?us-ascii?Q?CnobrM93w/ouJI+FKhntse2McM2KLyrX57vyeSGmZU6rca35PPpIJJMZVl+W?=
 =?us-ascii?Q?xWDV1kjLyRbh+akXoau+qac88OLvAtsvb4grUMGwYwu9CqOitkHO6J5wiBWI?=
 =?us-ascii?Q?VBtAKPB4vPme21d2wZ+9JgVJnu/DI7WpbCsc94lhMPUbdwEFNw0upjsXAwvq?=
 =?us-ascii?Q?lGpJgtzObyD23dn/c94PwEoQO7gUc681pZXxeQzZ00oK8KP8bQsfWpO/XT5j?=
 =?us-ascii?Q?PI5zbiHQMGQY8ZuQZT2ouP3i9ExscZK1xJWulS0GylIKB1lKqIO2rwfnHqsx?=
 =?us-ascii?Q?qrKFOHK8N/CTBSFfUxvDYKox0h6Da+gxkN979mOd05iZ8RESF8FsTtY1hsZr?=
 =?us-ascii?Q?90v+gwKjpmQIMMlserkfuY9txU+wV2IoP0OBHquYR+BvG6iMhk/3y7gjmUqc?=
 =?us-ascii?Q?Q8XlikDLmSX9RTM7nexBqTvs/1S7uSESn2yKKjbA7ZTZ1qXye1B7EryJX2Pi?=
 =?us-ascii?Q?4oo7hy8X+B4nNNT7UziwpUZ/lFNJqhlPHI4qieexgPCiMG0Uf/22J8TPKG1p?=
 =?us-ascii?Q?e9O3HoTsXDsH+oHdQUep8J8YlvTtBKKtJsN3LZeV8T5tbRezpVePiJdMK7Ht?=
 =?us-ascii?Q?KDTnNdLoHJUzdbwnF3GC3s4BpWzo/uwOgz5z/UNS2q/vQ+b+fj7UskamdSb2?=
 =?us-ascii?Q?AXQQ4FX2PruiFemaUJ3cq0bmyI6WbveQl1W0e9QkZsAzC9tXmFjTxtxCGvsR?=
 =?us-ascii?Q?Ktms7seKKcKS2ir//uEmmwWlS5QMIxq3Lxt5hRFw9Amvmim+vVVSz21Ydtxc?=
 =?us-ascii?Q?2Youj7Z+UvnO1mq0AA4dLdxscJ9rVxUuzm9PrzQSpfHYftUS+bW3oWsq2zyV?=
 =?us-ascii?Q?tuXcRoSNkKYp2CRnHlHRo+ELnZZkTd6MQV6L6WPFsfXMZGnikKBmaUOD7Rwp?=
 =?us-ascii?Q?jF45uTEZjdBMN93bNNn4mbe8OtiHFjuk9OW4VwzzrvpaoHnckGfGgDB+bat+?=
 =?us-ascii?Q?dtUItdrBM93+EUfV3UUPbAU5kP7azfLYWDchey1o8/Hl99KAFLm9duj0CuUO?=
 =?us-ascii?Q?H1AbCGBNr+UY68soucN/CXwLVgoNfHbbZNUmB7JoCdv47mzr0GqlNX4uyc0v?=
 =?us-ascii?Q?PyVkPNc4M014HwJbjRVbbTFddYWo9KcM+9Zs755Lz/5qFT2CYP2rxYek6ZNv?=
 =?us-ascii?Q?faM8DXhofeXi+k+C0voiRGwMX2FChWowGz+FwYRvHNi75mP/4b5+hyUVF+ow?=
 =?us-ascii?Q?PXguG9EI4ljCgiqiFBhX/1RA7reNbj0CM32551hyW765vw=3D=3D?=
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:CYYPR11MB8432.namprd11.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230031)(366007)(1800799015)(376005)(38070700009); DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?jEOXtiuSxUjbbTe8lnjoJp/jaNnR4ZzSUXd4bflP/fjtt/4o+CvBhNVGh5u8?=
 =?us-ascii?Q?xS9xVXC4BCL0EG2MBlXAhUJvFPPBUamsFzBaktR4oIzRvddBfEYS0CotjWXN?=
 =?us-ascii?Q?9uXDWnWHiKwL1gPrMJOYyVaH2wHir5n1v6mO8+kP456ax3gnE2RoSZXEr4pq?=
 =?us-ascii?Q?wwb5jxlxG3UEkI/hM8vLL/1gBtZB7oKzBenbBkG4ydTyznEkiKE53v7tfKAB?=
 =?us-ascii?Q?qeDDBbSq+tm8z2oUl2hbvjUoYpdOTT/SNcV+otEMxqU6iDDqt0FRWLg7m0q7?=
 =?us-ascii?Q?HX3tzYoABcLFJjOCiE02cDBFHYgfLmXRp3FuThmZZGk/e8fMfWRMLpNULT/F?=
 =?us-ascii?Q?4mXBis7LVFbOIEL2eakzQG9rYuOoPLJEXrv62b6tNf+O2YkGOhgF6CXbV2qG?=
 =?us-ascii?Q?Sxl8FL8V+sOVNS33TYvl+6y8dxrY1WWTiiuuq4qRMPN2prISrX/OK44F3ouv?=
 =?us-ascii?Q?l/RBmQfdIGg6sgUeS+JTO9arM2LhxB9LxyrHkZSMloya4CF2XUqAfxqkTy0+?=
 =?us-ascii?Q?rLfK3KDLrHvGut6Li5T0a8qQfjhiX4PqEzmfPMSG5sh2uucg9K+Gs3LsPyuz?=
 =?us-ascii?Q?/bULAU7cf2VDdT4hvnbCmgHq7M7TvvJQQgP6rEWH2ArfqMa7kxpMFm9CBBHM?=
 =?us-ascii?Q?MOYBtBgXHebZipSs3/3imq+9nuwNBHdHGAF+D/VUbkFO9TS7Qqu7Vd/68oSq?=
 =?us-ascii?Q?taONuC+krYDilVbhtB6cuInLsyDRgpjTwzyuE1VjojjDfZJtD/KKgNYsjeMG?=
 =?us-ascii?Q?epbhQbm78KHFcTtIeFjFGDvKrDEIEnqdrGmV5AmCxHeHqoERcCZrXwJxqbOc?=
 =?us-ascii?Q?jnhBZFJ868ozwNt1nXiGN9jA87k56K2Slr7+6QvGjL8kPDmK60a6MNxtbsv+?=
 =?us-ascii?Q?kiazosoJiJocmmSgsjIgn7zIOgPQOQ96ytmxrZyB94p/hVpIz8ZYBK2sN4m4?=
 =?us-ascii?Q?HIf9uuW1teOfC21nze0QyhiG7mL/LQKacCNxUCdI69yDCnB37ZCEkY4HqZ/a?=
 =?us-ascii?Q?RhURBW5Er9PPBx+0Lvez2982WURnbtAN4R5UEZVUSNT1DpMXeFpcz8tvvKrU?=
 =?us-ascii?Q?8Xwb6/umOSuVCws4tPm5BFcJHI4v9/RLn81SDStR1x8JUPNeX6DfDgJK2Ofu?=
 =?us-ascii?Q?oEQu3dX5pCffjMrEoenpBVa+kI3e3XWobuOFSxOLmQ5smMQ0bIeXmtblP3MM?=
 =?us-ascii?Q?CcSONFKAIfcXLfjINX3bXccCJTlslELGi8pd//OV88INH0VNuKyJF5YLdMuz?=
 =?us-ascii?Q?+th3cDTJUMtc0gQTPJrxJWhnCvX1Pp3htINSWWETMnq3UQD6m5CyTnzhEqKH?=
 =?us-ascii?Q?xECVexugtYP1p5h3PgIteWfY0bVmh0Uxy0FLNSu7VblizLxkPMZIfH7HDIsr?=
 =?us-ascii?Q?8FlBUjCHgCHSfeTEes7lVDq+Ee9CNE38zCwNqvA2fe0Y023UoQWibhNSY0vx?=
 =?us-ascii?Q?lfsfsCofpm+WfhZrwNGIyFgjND9mTFxoHdUJqlFKbqa2TYQq1dbiEphcg/6N?=
 =?us-ascii?Q?1CyH4uOlbJhhz9UX99LhHjM5EghyMyCrKw4GV2QVHX0u00qZupqcvS0WCN2k?=
 =?us-ascii?Q?RYWij2UouzFXaSseTngR+Q8tNcyKeRyjDC6apxOa?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: CYYPR11MB8432.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 3ddd4b83-766a-49ad-da07-08dc716535ec
X-MS-Exchange-CrossTenant-originalarrivaltime: 11 May 2024 02:51:08.9557 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: s+WnZC4xa5dTAhhg2zGjdzrIAMWFepOxPtpJW52a8PZp6so89bmIB3mbZCEhO41WZH06JP8fYwmCDVGqlXwo8A==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH3PR11MB8155
X-OriginatorOrg: intel.com
Received-SPF: pass client-ip=192.198.163.11; envelope-from=chen.zhang@intel.com;
 helo=mgamail.intel.com
X-Spam_score_int: -49
X-Spam_score: -5.0
X-Spam_bar: -----
X-Spam_report: (-5.0 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.586,
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



> -----Original Message-----
> From: Li Zhijian <lizhijian@fujitsu.com>
> Sent: Thursday, May 9, 2024 11:31 AM
> To: Peter Xu <peterx@redhat.com>; Fabiano Rosas <farosas@suse.de>
> Cc: Zhang, Hailiang <zhanghailiang@xfusion.com>; qemu-
> devel@nongnu.org; Zhang, Chen <chen.zhang@intel.com>; Li Zhijian
> <lizhijian@fujitsu.com>
> Subject: [PATCH 2/3] migration/colo: make colo_incoming_co() return void
>=20
> Currently, it always returns 0, no need to check the return value at all.
> In addition, enter colo coroutine only if migration_incoming_colo_enabled=
() is
> true.
> Once the destination side enters the COLO* state, the COLO process will t=
ake
> over the remaining processes until COLO exits.
>=20
> Signed-off-by: Li Zhijian <lizhijian@fujitsu.com>

Reviewed-by: Zhang Chen <chen.zhang@intel.com>

> ---
>  migration/colo.c      | 9 ++-------
>  migration/migration.c | 6 +++---
>  2 files changed, 5 insertions(+), 10 deletions(-)
>=20
> diff --git a/migration/colo.c b/migration/colo.c index 5600a43d78..991806=
c06a
> 100644
> --- a/migration/colo.c
> +++ b/migration/colo.c
> @@ -929,16 +929,13 @@ out:
>      return NULL;
>  }
>=20
> -int coroutine_fn colo_incoming_co(void)
> +void coroutine_fn colo_incoming_co(void)
>  {
>      MigrationIncomingState *mis =3D migration_incoming_get_current();
>      QemuThread th;
>=20
>      assert(bql_locked());
> -
> -    if (!migration_incoming_colo_enabled()) {
> -        return 0;
> -    }
> +    assert(migration_incoming_colo_enabled());
>=20
>      qemu_thread_create(&th, "COLO incoming",
> colo_process_incoming_thread,
>                         mis, QEMU_THREAD_JOINABLE); @@ -954,6 +951,4 @@ i=
nt
> coroutine_fn colo_incoming_co(void)
>=20
>      /* We hold the global BQL, so it is safe here */
>      colo_release_ram_cache();
> -
> -    return 0;
>  }
> diff --git a/migration/migration.c b/migration/migration.c index
> b4a09c561c..6dc1f3bab4 100644
> --- a/migration/migration.c
> +++ b/migration/migration.c
> @@ -789,9 +789,9 @@ process_incoming_migration_co(void *opaque)
>          goto fail;
>      }
>=20
> -    if (colo_incoming_co() < 0) {
> -        error_setg(&local_err, "colo incoming failed");
> -        goto fail;
> +    if (migration_incoming_colo_enabled()) {
> +        /* yield until COLO exit */
> +        colo_incoming_co();
>      }
>=20
>      migration_bh_schedule(process_incoming_migration_bh, mis);
> --
> 2.31.1


