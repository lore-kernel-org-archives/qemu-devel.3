Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 41C26C83F03
	for <qemu-devel@archiver.kernel.org>; Wed,  9 Jul 2025 05:53:57 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uZNjs-0006OG-EG; Wed, 09 Jul 2025 01:53:06 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <zhenzhong.duan@intel.com>)
 id 1uZNjb-0006Lq-GL
 for qemu-devel@nongnu.org; Wed, 09 Jul 2025 01:52:50 -0400
Received: from mgamail.intel.com ([192.198.163.7])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <zhenzhong.duan@intel.com>)
 id 1uZNjY-0002Oy-7R
 for qemu-devel@nongnu.org; Wed, 09 Jul 2025 01:52:47 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1752040364; x=1783576364;
 h=from:to:cc:subject:date:message-id:references:
 in-reply-to:content-transfer-encoding:mime-version;
 bh=EnonoSuYYHFS92wAJJ1RZ8Pw1dJTvruGKg5KVX6B640=;
 b=LZZ7HCwwne5+rjQ2iOxho5j3DxxIfgR4JHD6+buE+zHr5sUM5inNWFBb
 fVHW+rEG945HLwWg0okMXHbfZ1gsEHQkvpuN4Qwb4MpiTFcJ04VFuy8vt
 xqRiNmH+MbrFhNSh4c6Fsc5ujd3uqmlwuTq0CIHc/3QQaMFYESKBtleUA
 FKnLVM/e4+4I7Yvm/aNnEoUaJCgFSxFNkGjxcNiBE3jl5BooOHZzWOIiB
 H3HOMLtUnWNpmkDN8+bgOb4ZfMLwrrol/Qvf5aypu32J9tMbOv/blw1pV
 EkGa28cvF/lu+0VpIyB3JGPBoOarDDGyEMRSnskwOLPJ1of7qOukbA2Vc Q==;
X-CSE-ConnectionGUID: 2Inswb/ER7ONV61CoXhtbA==
X-CSE-MsgGUID: GAFbDlXCT8KYpOMVnIEjRA==
X-IronPort-AV: E=McAfee;i="6800,10657,11487"; a="79728670"
X-IronPort-AV: E=Sophos;i="6.16,298,1744095600"; d="scan'208";a="79728670"
Received: from orviesa002.jf.intel.com ([10.64.159.142])
 by fmvoesa101.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 08 Jul 2025 22:52:41 -0700
X-CSE-ConnectionGUID: Tw6bWe8PQUipLDFINyN5CQ==
X-CSE-MsgGUID: tmhZF8eIQvyFJnfeW5hzEA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.16,298,1744095600"; d="scan'208";a="186689854"
Received: from orsmsx902.amr.corp.intel.com ([10.22.229.24])
 by orviesa002.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 08 Jul 2025 22:52:40 -0700
Received: from ORSMSX901.amr.corp.intel.com (10.22.229.23) by
 ORSMSX902.amr.corp.intel.com (10.22.229.24) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.25; Tue, 8 Jul 2025 22:52:40 -0700
Received: from ORSEDG902.ED.cps.intel.com (10.7.248.12) by
 ORSMSX901.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.25 via Frontend Transport; Tue, 8 Jul 2025 22:52:40 -0700
Received: from NAM12-BN8-obe.outbound.protection.outlook.com (40.107.237.54)
 by edgegateway.intel.com (134.134.137.112) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.25; Tue, 8 Jul 2025 22:52:39 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=b2rCBrsyK9AgxkhAW36ju6wUV+FWjNcrs/1RJutdrddRsRxuy1Upq+5potAkSpAAB0FcHWWLy0hvX+A4hG/JiT9XaVYyDmJtqZUo+tkt5poxxapY0zcB5UNZVkhIrCh0VxLN9JbZ0HCyG7QdApmBjRjbgeQsSlPy/Z5WxV2lXo0EzhGFyWypte/m9yQrgUPZcj23mUQZLg3XOEYbxu8h9ylJ1rD0sihVcKTLogQLwqbRNzvsUIvAdu7iT9Q369PNK9XR2v/qz79FXkFEbhPWRldmFKUV4p1zxA1NJmrvRpykWvzdYiC8lNUiBSdj0llYAw08t5XdgyzokzUMpb9MUw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=T4A74m5Mu9YBd4lc+w6rXT1oAiiW72Yw+7YnWGxTOVc=;
 b=ddLwPW1cSJ1+tLCU+HVDz5kRYnCfLz95hatYkrvKyI1bsRoK/kqixkgwTJ4EZTgLJl6EsP1ay/ziHVaWlJgkpT6vswipEtcI+5fc2NY3/ExB5Mxo3Vn77qI+npOlZsN7oNQGbp9JcmBluQZCEnflguZz9NdFMdnrV4QSG7tyDnXywp7b8xC/a0in/iCas2jbtcN9FUcMppF4Y9kOMccot2WFM6ldE3UvVHIgm6/9P77KJlGAG4mHXYOWhKm4/0uWW2Uswh5e9YizO6UwMC55huiJCZ9xptIS0LWhqwfUpouw41wwflXmYwNkoqbnodIWxynKTVcmUWPHIfrA+xbeOQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Received: from IA3PR11MB9136.namprd11.prod.outlook.com (2603:10b6:208:574::12)
 by SA1PR11MB8396.namprd11.prod.outlook.com (2603:10b6:806:38d::18)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8901.23; Wed, 9 Jul
 2025 05:52:29 +0000
Received: from IA3PR11MB9136.namprd11.prod.outlook.com
 ([fe80::604b:77a4:b1be:3f13]) by IA3PR11MB9136.namprd11.prod.outlook.com
 ([fe80::604b:77a4:b1be:3f13%4]) with mapi id 15.20.8835.023; Wed, 9 Jul 2025
 05:52:29 +0000
From: "Duan, Zhenzhong" <zhenzhong.duan@intel.com>
To: Nicolin Chen <nicolinc@nvidia.com>
CC: "qemu-devel@nongnu.org" <qemu-devel@nongnu.org>,
 "alex.williamson@redhat.com" <alex.williamson@redhat.com>, "clg@redhat.com"
 <clg@redhat.com>, "eric.auger@redhat.com" <eric.auger@redhat.com>,
 "mst@redhat.com" <mst@redhat.com>, "jasowang@redhat.com"
 <jasowang@redhat.com>, "peterx@redhat.com" <peterx@redhat.com>,
 "ddutile@redhat.com" <ddutile@redhat.com>, "jgg@nvidia.com" <jgg@nvidia.com>, 
 "shameerali.kolothum.thodi@huawei.com"
 <shameerali.kolothum.thodi@huawei.com>, "joao.m.martins@oracle.com"
 <joao.m.martins@oracle.com>, "clement.mathieu--drif@eviden.com"
 <clement.mathieu--drif@eviden.com>, "Tian, Kevin" <kevin.tian@intel.com>,
 "Liu, Yi L" <yi.l.liu@intel.com>, "Peng, Chao P" <chao.p.peng@intel.com>
Subject: RE: [PATCH v3 02/20] hw/pci: Introduce pci_device_get_viommu_cap()
Thread-Topic: [PATCH v3 02/20] hw/pci: Introduce pci_device_get_viommu_cap()
Thread-Index: AQHb7/hgTj57YS3o2ku1lrMH7qQqMLQo9AEAgAAucSCAAApvAIAAHMbA
Date: Wed, 9 Jul 2025 05:52:29 +0000
Message-ID: <IA3PR11MB9136FFF54A8044B427659AE29249A@IA3PR11MB9136.namprd11.prod.outlook.com>
References: <20250708110601.633308-1-zhenzhong.duan@intel.com>
 <20250708110601.633308-3-zhenzhong.duan@intel.com>
 <aG26VBqzOnLAWC5z@Asurada-Nvidia>
 <IA3PR11MB91367A742FD1F22D591D52069249A@IA3PR11MB9136.namprd11.prod.outlook.com>
 <aG3qCpUB8/Y7r9hT@Asurada-Nvidia>
In-Reply-To: <aG3qCpUB8/Y7r9hT@Asurada-Nvidia>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: IA3PR11MB9136:EE_|SA1PR11MB8396:EE_
x-ms-office365-filtering-correlation-id: 17399404-500c-4360-180c-08ddbeacca71
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
 ARA:13230040|366016|1800799024|376014|7416014|38070700018; 
x-microsoft-antispam-message-info: =?us-ascii?Q?s+XAzfiSYY9veJadV5ExSw/gwvnx1Qk25RSNsUW5brksIGeMdY2JpoG1wUji?=
 =?us-ascii?Q?l2mVq8i6IpcRiBJfOeHXpD92cgBD6Is3tTBv/tzmh501/HrK3rO8iVMLILA9?=
 =?us-ascii?Q?+8sL/0L1d1Bh0q3wvbjqTi+h3vlhZT7R2HZt9g+zbwMtrB/9IBNuSVR0aocI?=
 =?us-ascii?Q?pAVcU2b5RaJPOq/pcp6jcg8YOXTrUkvlc+TDyBm0qsdXomrn+IdQComzRkMH?=
 =?us-ascii?Q?sGUuZyihWnMV0MIpj8hi48p9UzSj6JpyheEQO0urZvVfbXxxUGsg2ffjFbiW?=
 =?us-ascii?Q?EYFFNJ9gphNBDB60h44WHogbMUj33K8g9u01XZCnxpK9f01iBmMKgJBEKXnG?=
 =?us-ascii?Q?61bNX8MLgAteDUE9oTl5HW+s5oUr2cafMjljBk3tUVTs73DHrMZm2e/BU+sy?=
 =?us-ascii?Q?rTwnaFoqPs0yqYMLsGayX2BQ7i7aJaGuHuY+p3TvUYvbyuE1qceYdGC2dvOy?=
 =?us-ascii?Q?hiW8yP9fdnHYOkLbi2vOiKnSHMRSccyNZJTmKmS5LlTZ10zX8bK/LwJyMqW1?=
 =?us-ascii?Q?aH6F4nSNGyJU8bw55IIYi+H3fJIF7iTx7iLqpTerLgb3nkS3NNbdgHKVJzar?=
 =?us-ascii?Q?/w9QgFK/p5+rqNOblaU3LgWpI2XOubFaVEdC60DHCH1BL6VzCZko6uS5NTa4?=
 =?us-ascii?Q?ahBcToi/NtByTjeUPMxzc8zI/IatfZiumUtjsPEgLEOEAbi+afPP5T8iKo6T?=
 =?us-ascii?Q?iBCieOKeyE8cr4JCqNmf3SwYucQIvQPd0g/Lhl6j5rpwxs/lHWgov9a/DUNB?=
 =?us-ascii?Q?6LnTobiMhGC6NSAOgHoo1t56lRvcKu+yW0O3iIv/847AaIqZaaJfGxMKr3u9?=
 =?us-ascii?Q?ILiWsQWTAfVu8BEKOC+BeuKu920zS0v0PoenJ+x6SAsywme+YpOsHtVlMcJ6?=
 =?us-ascii?Q?M7iFQN5Hnhl4qq5s4vskTLR/BCwTlzlxusw7GDypcswGuHVn2XsiXgpY838h?=
 =?us-ascii?Q?DMpAIUXFDMgNBCGNgd4wy1HzV1FhpLSX8E9KwrqhWjw4gvAJUuSRVoMWeupS?=
 =?us-ascii?Q?/hrjweSv0Bq2oHvNEXYwChT4gMlC4wK7IDAX1FZ1rhcNykenx1eZ5E2F4a2a?=
 =?us-ascii?Q?csZAzEyRtKJ4X4PH1DrzXQy0qbVQ19zPUtuXEvFzJq+l6n16xyH2HPQKhous?=
 =?us-ascii?Q?gr9OnJyOyt+KCRtnLsL2etXKg2MWAe5oVSVUX64aFNZmdLfRNfRCsCU5kzeU?=
 =?us-ascii?Q?HsHz5+/HjY8MRSC1MQgDZuovRe2BzTiF5zxhOm8AnWgQZ/6PtYAtNxho5XNA?=
 =?us-ascii?Q?GROzO9Zymk0s7NqZTaaudwn/OySMxObM5NTE1J+mGXjBocm9YPJQXBNfhucq?=
 =?us-ascii?Q?uWeUxMHh3Olr2a8aZ6DE+TL0PirqNfCrz2Mc5wh8MBIUaG4ZVacFUytOVGsW?=
 =?us-ascii?Q?KFWrjaNSliHUvt6ZTfXkCerL0zUP9rPbPvfmgeRsw9GnSgfBk9Lg+iNTTUvy?=
 =?us-ascii?Q?MX/tpSF5JbWx3lBHHibY140HO+XzcBEjMkrnJD0zbnCsvb0ruTvg0g=3D=3D?=
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:IA3PR11MB9136.namprd11.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(366016)(1800799024)(376014)(7416014)(38070700018); DIR:OUT;
 SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?N6SMLtO2sbSRI1IOfDr/8GZMFkKbascZ4zzkQuPQa1814vvjBDbiECf6fqHm?=
 =?us-ascii?Q?GzeQTMdPkXN+sxTnzkJWFHdnNO9z9iGETBUjXUT3Qy5+AJVP8ZWnZrFGb52p?=
 =?us-ascii?Q?7+E5ZbBHeKpgBvQWQoM+XXD4M+ERyNyxjKZ/0fAiTrwiEcGen8ViJhkwHdx2?=
 =?us-ascii?Q?RJbU62647dvZ3km/dpUuBT3CEErBfQXCE5MPNRNJbSDMghKhkgURwEti/uiQ?=
 =?us-ascii?Q?R6zCCp9vhTLcNRkBQ1WUIYc57J3fxnM7EdfhlLjLaDhVATkylqwDQj2lOqCa?=
 =?us-ascii?Q?kL0LIcRJmxf99ZW7z8gX2QgArNy3e9L7K/64nV6Y+E0RjiKvkHVcZu+c+3RR?=
 =?us-ascii?Q?L0pRz8OfkLK+DumgxvV111u+Hicu4JPaVfdLqBZ3XOV8yC5BPUWaXFdH202F?=
 =?us-ascii?Q?knrrgef0Aw0hrAg1RwzEHEh8mF6LcXUe4/83w5WJdmLSalczJxe/GXPocdxu?=
 =?us-ascii?Q?miTkjMdRHDSkl6HXgs3yx4zb4wwYTJjLnpGFYHqyyo1IusfOjcPadqw/JxvX?=
 =?us-ascii?Q?6GdtffAXcsHVW8aItzj6iD99f15lj31c4lr28Wlc75x/BgD733/+t33k+jEq?=
 =?us-ascii?Q?Ss+fV6TUW6f8GxEr2c5cBF/DrRUogM81OTrO75usEh4WynKKY0qfkOD9bSwJ?=
 =?us-ascii?Q?0eeMPoJ+XsNKrDlxFbP8zJRLAPWxC/xxSPOUIzrky4ZlwqnaeSzyGV9QHXSQ?=
 =?us-ascii?Q?4410N9XJ6jIoiq1HZaBPwQ50gvsrQSfX15zSOIc3478/n6Pz5AGY8ok5nca1?=
 =?us-ascii?Q?RRzwUCo0vgHRgmUrw577GIGB9Z1H56Uajn295YdouNkaJ62ChLdNbjP9xG1Q?=
 =?us-ascii?Q?80yI31aApTLxw1FnsOzFkTNyM9tFqJubMMCzpRJCGF+oVXxKCcOPlNn91qBM?=
 =?us-ascii?Q?Z23khLUrImM+11YmszpibyYGkBUefzy30MN2/6rHEPDTbVOLIEnNlF4YglT9?=
 =?us-ascii?Q?+inlTis6bIuh7ukzXqWDDVYDsGFjHHacXBD1fHpJpoXMkyhvURY470CeYJNT?=
 =?us-ascii?Q?vQUEuKJPxT+8A0QutQNggznitvtcNErQ3MV++9Z97/RXzUquR51pq+HYsckU?=
 =?us-ascii?Q?7tcwCSutj5uFp7LyGFKAvQitwI6P7tYlTgm6KD9FQk0xR3zCjcXlOS1RB7BJ?=
 =?us-ascii?Q?UtvYO6TSd6beFkFBd0yNnohKrsfmQ3arGD5M92FSduOuoRiko39RhxHzPiqa?=
 =?us-ascii?Q?p0q00OGDyKFzoQMvXVoBE/trXxljknoRYYwNQhH2yzTMz2qyfk9V0EIoVcC+?=
 =?us-ascii?Q?fA0Xuww7hUNsESVlY8/U1oeidml0XH5poVcVs4gzt+1lYPNAkgEEjGkfscNI?=
 =?us-ascii?Q?SsCkRr5fkpsJdpqIWKTdxc87uIfRISab9zqdi4elppA0dX00riuJRsvgNcvZ?=
 =?us-ascii?Q?+ULqWAuhAqff6AaFxH0LCdkrQxUyymRKvgU4L3Mcp5OMAVSMHZUjfrwIwPbq?=
 =?us-ascii?Q?54ebQPYD9OQghGtJ4X0zvsmyIn6S31Ij0yaNE7XNMnakfvlF+AkJ4VfeLVzF?=
 =?us-ascii?Q?+oJ6IpRs6BrOpqdwbI62+EB8JtpQePouNdgKjbJeCrsn9O68eqNZ3ipmk45o?=
 =?us-ascii?Q?6PgeHCF34P9y72V3+iPkuf2t6ZVsr8K3wnKzFGs8?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: IA3PR11MB9136.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 17399404-500c-4360-180c-08ddbeacca71
X-MS-Exchange-CrossTenant-originalarrivaltime: 09 Jul 2025 05:52:29.5921 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 8p3NMmcGX055DONRSb6kWpfaxtmCqDjI/FiqUvGOs4sGvZHQ4qFZ3HP5HklstQW5IkDSpy/Jl8AndcUgTiMdcprCF9s1QExdoaYx/GrpU7k=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA1PR11MB8396
X-OriginatorOrg: intel.com
Received-SPF: pass client-ip=192.198.163.7;
 envelope-from=zhenzhong.duan@intel.com; helo=mgamail.intel.com
X-Spam_score_int: -43
X-Spam_score: -4.4
X-Spam_bar: ----
X-Spam_report: (-4.4 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_MED=-2.3, RCVD_IN_VALIDITY_CERTIFIED_BLOCKED=0.001,
 RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001, SPF_HELO_NONE=0.001,
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
>From: Nicolin Chen <nicolinc@nvidia.com>
>Subject: Re: [PATCH v3 02/20] hw/pci: Introduce
>pci_device_get_viommu_cap()
>
>On Wed, Jul 09, 2025 at 03:38:49AM +0000, Duan, Zhenzhong wrote:
>> >> +enum {
>> >> +    VIOMMU_CAP_STAGE1 =3D BIT_ULL(0),  /* stage1 page table
>> >supported */
>> >> +};
>> >
>> >Thanks for this work. I am happy to see that we can share the
>> >common code that allocates a NESTING_PARENT in the core using
>> >this flag.
>> >
>> >Yet on ARM, a STAGE1 page table isn't always a nested S1, the
>> >hardware accelerated one. More often, it can be just a regular
>> >1-stage translation table via emulated translation code and an
>> >emulated iotlb.
>>
>> What to return for an emulated device, VIOMMU_CAP_NESTED_S1 or 0?
>
>It would be ideally 0, since the get_viommu_cap is a per VFIO/PCI
>device op. But I see the caller of pci_device_get_viommu_cap() in
>this series has already done the identification between "emulated"
>and "passthrough" devices?

We do allow emulated PCI device calling pci_device_get_viommu_cap().
It's just no such request for now.

>
>That being said, it doesn't hurt to run it again in the callback
>function.
>
>> >I think this flag should indicate that the vIOMMU supports a
>> >HW-accelerated nested S1 HWPT allocation/invalidation.
>>
>> I'm OK to use VIOMMU_CAP_NESTED_S1 name. But still unclear which
>> checks should we have in .get_viommu_cap() callback to determine
>> returning VIOMMU_CAP_NESTED_S1 or not,
>> as we know nesting support is determined by host IOMMU not vIOMMU.
>
>I would say it's determined by both the host and vIOMMU.
>
>This is a common API that may return other caps too: eventually
>there can be a case where vIOMMU has its get_viommu_cap callback
>function but doesn't implement HW nesting via iommufd, even if
>the host IOMMU driver supports nesting.

OK, will use VIOMMU_CAP_NESTED_S1.
But for VTD, we check nesting compatibility in .set_iommu_device callback,
in . get_viommu_cap, we will return VIOMMU_CAP_NESTED_S1 if vIOMMU support =
it, not checking for host IOMMU for simpler code.

Thanks
Zhenzhong

