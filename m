Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 95BCEC27C4F
	for <qemu-devel@archiver.kernel.org>; Tue, 11 Jun 2024 03:24:34 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sGs7C-0002co-BO; Mon, 10 Jun 2024 23:24:06 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <zhenzhong.duan@intel.com>)
 id 1sGs7A-0002RY-LQ; Mon, 10 Jun 2024 23:24:04 -0400
Received: from mgamail.intel.com ([198.175.65.10])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <zhenzhong.duan@intel.com>)
 id 1sGs78-0006xv-Mc; Mon, 10 Jun 2024 23:24:04 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1718076243; x=1749612243;
 h=from:to:cc:subject:date:message-id:references:
 in-reply-to:content-transfer-encoding:mime-version;
 bh=8kRSutajglmhTxEbAcYeJTQgPViCoigjRiRhgfEeDW8=;
 b=X8z8J6xGm+xnBA1vNigAZNfiShtlw3lNBeLYnCWJa7Ufe+BurUU/c8ey
 YsfQFWDHpm/ZLrfHoDmbjOUvF6tdZ4sy/R2bTARzgARhEi6X3WmG82p1/
 TwZaXTq0+iBJdLIrs5G7v/Iz4Ai0rgi6g6iJCbUkSCWYzNXMspQg5oy3j
 UAGL3y14A+WSJAIN9y7ubamL9crX8urhgBzMihQBGXceNl1E7M8wpcntd
 sK22ceN12RvCSFKXLMLfKksM76v1A9nwJjYpORCSVg17VzHpKgR5jZ1qu
 Ip/QUaHZ8VnH2m6SwENV2hhZlf0oiRwnR4kP8bQCgh9gT0gOol4PeDZtI Q==;
X-CSE-ConnectionGUID: anG1ZU88RyufuzYL3q9hcQ==
X-CSE-MsgGUID: vmjhOVFnRuSn1Cx7LM82ng==
X-IronPort-AV: E=McAfee;i="6600,9927,11099"; a="32250049"
X-IronPort-AV: E=Sophos;i="6.08,227,1712646000"; d="scan'208";a="32250049"
Received: from fmviesa009.fm.intel.com ([10.60.135.149])
 by orvoesa102.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 10 Jun 2024 20:24:00 -0700
X-CSE-ConnectionGUID: MqYUIypSR5uBiUUvWGj6lQ==
X-CSE-MsgGUID: 1OzpdlRWSHm56r0Vx0zb2g==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.08,227,1712646000"; d="scan'208";a="39380969"
Received: from orsmsx601.amr.corp.intel.com ([10.22.229.14])
 by fmviesa009.fm.intel.com with ESMTP/TLS/AES256-GCM-SHA384;
 10 Jun 2024 20:23:53 -0700
Received: from orsmsx612.amr.corp.intel.com (10.22.229.25) by
 ORSMSX601.amr.corp.intel.com (10.22.229.14) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.39; Mon, 10 Jun 2024 20:23:48 -0700
Received: from orsmsx601.amr.corp.intel.com (10.22.229.14) by
 ORSMSX612.amr.corp.intel.com (10.22.229.25) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.39; Mon, 10 Jun 2024 20:23:46 -0700
Received: from ORSEDG602.ED.cps.intel.com (10.7.248.7) by
 orsmsx601.amr.corp.intel.com (10.22.229.14) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.39 via Frontend Transport; Mon, 10 Jun 2024 20:23:46 -0700
Received: from NAM11-CO1-obe.outbound.protection.outlook.com (104.47.56.168)
 by edgegateway.intel.com (134.134.137.103) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.39; Mon, 10 Jun 2024 20:23:46 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=MlhHY0vQ/XiryF/p5geh3yCgZw/rwoRkfRnmqJY0Mp98Q+pd1Y46QLv11VbnYCOb/gUN6NQrl+IVzTo29YUwGWaIyniqYUElQg7B+eFtUZBi69/ktq1ofiKt3mpWTs9Ct3TivkBG597bs1a9csTacbZGKX1xPrKd5s2Q2XzPpTHk71Yg0xPNGhgWY5BOpbGclILozmU+cerayu/G6/nBkT2oDya8ZqMH2sN6qb4vNHqWFC3HTHKJw/L97iYIpi1MOlakmwH/kPtFlvkLxnqSPd2+eWNm4aqd3ArU9GBOr0GakiSLBs60AIQEIlDmdk5DogLYVuD/mQtUst4wN5Qi7A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=F7wf8t92GybOSkA1vb5Hjn5/f2EETU8QiXzFgfkeIos=;
 b=bZuU/EzibAPr1tQOZkOFJEirJqHn8rrxzjK5VESrf5NQOg6/XyPrZiKnpi2vs7/x1DdHF3WS7nMg+TVHCeBNWvRHPkeS2x1Gbvr4ERgbnaGzyovATwBOhxutghf13IYt7jquQCEl15/LUmH3Oz1g29gco10lenWs64baJEpWGQ+NxpkV+rd+I8YjXKZcFTTB9FTZ4tBkyeYBts+8v2K/xBHqn4iGDZRYkYkiTRZE+Cap9BtBnxHenfLFzzEav8w6+7ZSfAq0Wzxbq9XGouUHO+rKOcZ2pIvvoDvm8EM5prhOOyXFZkyaxem5b0zM31c18U4l7m/A+mDh64ORgER/TQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Received: from SJ0PR11MB6744.namprd11.prod.outlook.com (2603:10b6:a03:47d::10)
 by BL1PR11MB5238.namprd11.prod.outlook.com (2603:10b6:208:313::8)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7633.36; Tue, 11 Jun
 2024 03:23:39 +0000
Received: from SJ0PR11MB6744.namprd11.prod.outlook.com
 ([fe80::fe49:d628:48b1:6091]) by SJ0PR11MB6744.namprd11.prod.outlook.com
 ([fe80::fe49:d628:48b1:6091%7]) with mapi id 15.20.7633.036; Tue, 11 Jun 2024
 03:23:39 +0000
From: "Duan, Zhenzhong" <zhenzhong.duan@intel.com>
To: Eric Auger <eric.auger@redhat.com>, "eric.auger.pro@gmail.com"
 <eric.auger.pro@gmail.com>, "qemu-devel@nongnu.org" <qemu-devel@nongnu.org>,
 "qemu-arm@nongnu.org" <qemu-arm@nongnu.org>, "mst@redhat.com"
 <mst@redhat.com>, "jean-philippe@linaro.org" <jean-philippe@linaro.org>,
 "imammedo@redhat.com" <imammedo@redhat.com>, "peter.maydell@linaro.org"
 <peter.maydell@linaro.org>, "clg@redhat.com" <clg@redhat.com>,
 "yanghliu@redhat.com" <yanghliu@redhat.com>
CC: "alex.williamson@redhat.com" <alex.williamson@redhat.com>,
 "jasowang@redhat.com" <jasowang@redhat.com>, "pbonzini@redhat.com"
 <pbonzini@redhat.com>, "berrange@redhat.com" <berrange@redhat.com>
Subject: RE: [RFC v2 7/7] memory: Remove IOMMU MR iommu_set_iova_range API
Thread-Topic: [RFC v2 7/7] memory: Remove IOMMU MR iommu_set_iova_range API
Thread-Index: AQHauOieLfRG0cUjjkCzzblThErE+bHB66MQ
Date: Tue, 11 Jun 2024 03:23:39 +0000
Message-ID: <SJ0PR11MB6744F41BD94DBB413EB5B9E792C72@SJ0PR11MB6744.namprd11.prod.outlook.com>
References: <20240607143905.765133-1-eric.auger@redhat.com>
 <20240607143905.765133-8-eric.auger@redhat.com>
In-Reply-To: <20240607143905.765133-8-eric.auger@redhat.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: SJ0PR11MB6744:EE_|BL1PR11MB5238:EE_
x-ms-office365-filtering-correlation-id: fd426abf-9cd8-43fa-9522-08dc89c5e37d
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
 ARA:13230031|7416005|1800799015|366007|376005|921011|38070700009; 
x-microsoft-antispam-message-info: =?us-ascii?Q?Zde8AnaZFAopJob/lx+IILz+YDOApjSGFesZSSrmwXUT+WkxqY+3LU4cY3AY?=
 =?us-ascii?Q?BR8Tr/7GuGIRR7Pyje42yK3/78+FLogF6u+ktj5X6/TLBAwkzU6lxPu/cGr4?=
 =?us-ascii?Q?wSLyPMdkhCrg2rlVPoh3PDjzG6iyBYVNmdLVYr5+890W68SmIbjg8gIQttmB?=
 =?us-ascii?Q?1kS1bj9gmwRlw9I0bXIbivIqkVtFmpz4BxBIIRStRcBgSujWb6Db0pry0dIN?=
 =?us-ascii?Q?FBpAjjKTkwCzl/FCdQmHwse2vYarwy6gFO/qZlF24LNbTWaLyDofvd9CRvvx?=
 =?us-ascii?Q?B0jQctpLbL19ja9cP8ksy1SdxdLnJA7UI002HfFHsBZ9lS96LJNruMkkbDIC?=
 =?us-ascii?Q?uhNtFMNPS0KYcGIkCPmGIhY9xQA4fYzniIDha5Jv7vbpFlrf9oVPZ5qZa3Xu?=
 =?us-ascii?Q?bCpCsj0Ou92EKDgAVKVUk4pH+ELydNHrHYULW3g1mwWlUNdOjQsvJVZzrIZL?=
 =?us-ascii?Q?6hR6K4mfAWkX8nq/6P4ZoeBCWUSm/fUmWdRoHW7ZIccFvnetaAfVK4UAJq24?=
 =?us-ascii?Q?BBjsfsletrA9vVH75QE9R48Xn9hN45S+2HAv+8roBbSKjUB10ObBvAZgiVBD?=
 =?us-ascii?Q?SeokcPsXz/HUKpAqmoujAqJHViJgYebnWAz2bpEyC37rpPRTbPJfkVvzsXA6?=
 =?us-ascii?Q?Dump5vKMVctNF/ORo7C9ZjRACuvccOGQ/KNklo0raov2b17hqeqfqTU7QKCw?=
 =?us-ascii?Q?i7f1fqCGvJNTlc7NwCKMAIw35dfi0HenwpTuZ3krpw2BMFJVN768ll8d8aHL?=
 =?us-ascii?Q?Di+mFRvuosEvUrdratS3oa6i7apGzSKMOQLhGzmVVoXoQCezxxx7YV0rae+5?=
 =?us-ascii?Q?2EAFnOMmKylXzBH612RPbKdxIyWM+8ieVaZevXqLJbZsPgjwqm1NV5RSK/GR?=
 =?us-ascii?Q?PMGOKemuPrMh+zvUNbIOjavrNuYj2DR4ftQPWlPC/bi79aWarxqIaPaalgY7?=
 =?us-ascii?Q?QdIffTajftG/PvHWllpDbAiwZbxQuXm+eBYZazO22smBpzYEuaL+NCuUWCJr?=
 =?us-ascii?Q?BdqEX37fH7co6TuyaSXmd3N1HZnJr+KiRiOoSY5MIRCDJ4B5I9nfX7wOT2SH?=
 =?us-ascii?Q?uD2S6jN6ajgBgDO7kCtVimZBvxvvM9rh+//8f+c5iSVcMKK7V1mh2xlgqcDn?=
 =?us-ascii?Q?fBdtSdTOoRt/2gAbXM9OfRlF81AKfLyVYTZV5g2ddPxa6ljwVt66nQuzCmUe?=
 =?us-ascii?Q?N73iDpty2pe9vESg0ouO8gRIfDF93NlYd8P+CjBCJEGc7rmMVjJHLWZZCw4I?=
 =?us-ascii?Q?hvlcR6A3xIfGie1PCOSuDrO3OiPV+YM+eWZZ2nDQx+oOMBSw5UbPHyh28jQG?=
 =?us-ascii?Q?be+g+hLR+5szyYJ6KQ2hgoXikrXGvFaFPIQeGE5BWSwRgoNyQ9LUczQ958BZ?=
 =?us-ascii?Q?if8eRm5F7FQM5fid45mublTPTEk6?=
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:SJ0PR11MB6744.namprd11.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230031)(7416005)(1800799015)(366007)(376005)(921011)(38070700009);
 DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?bSJO8+vbABeUkMGu2h1j0cV57IUi/vf2anuWhSQ9rVIkJGkV/rmRRfdNzsMg?=
 =?us-ascii?Q?0DgHCGYk8JKBA8D34PeOWdxZS6s3NHYVfxuNAQdkLwXKByAIpQckjHVNI4tS?=
 =?us-ascii?Q?tKtAOip+uR2dL8SEs8lUdEMXBW+IRv3w+/KyfvOAjYVY1ccaI9XjzXJMIkZY?=
 =?us-ascii?Q?3Ykftnz5Ta4nfelg3Tc+pL5EdJGVvuzOkZnGX24BPd1F7Z+y4EeKqZGAkzUF?=
 =?us-ascii?Q?LflK39wqvrgG15MigMXZdTOQQgOCGIneyIi4v9UF+E88olPyr0ybrW16smYb?=
 =?us-ascii?Q?jxpF20c3spq70vsnjBfHRWVptBY9f4znYCTK0T/DgtJzoWiniTSdK87JGLmt?=
 =?us-ascii?Q?hPiyqV5GC69TQN+xuimCRjfCDeshnLZtS4uT5wTeKCuTUucqbeByIm8Adm/T?=
 =?us-ascii?Q?f0HilIYtJ8N+p42PKhL5AdkPHn6HfcOcpwHXFzGMSTPX4wrUhraFZyx6v5Hp?=
 =?us-ascii?Q?8oX+uI6OoJl4iNIOhnJ0DKcMvtt7dB/RHVssLnsKLMq2hwTn/KbHph5q0RsQ?=
 =?us-ascii?Q?+UT4FPBAIsOaqLYQSfxyA7qHQykibEgCvdFK1Ifta5EL3mpiTW4kiTEIjX/G?=
 =?us-ascii?Q?XVu8JWyhtw6j/nkeBUBh8LWy9MgsvhxmvbbDhPFKjvEEW9IUpDrmVME29QSP?=
 =?us-ascii?Q?XQrr7lfDRSktV5AwmP9ACKKI9BZvOrU8zr3y0GJIUQTW89MNQ9K6mkUunCW/?=
 =?us-ascii?Q?CMFdD537Qp/aPRBmbPBPdHe1shIuwZ4zHpor1a53ngmrc24qZq9KkqVTuNGY?=
 =?us-ascii?Q?9Lv6nwEuXo5/08HJfDrr2Q3peY8TIYY4cTUgKVofMKzHZvjwOyJRMbrqA+/c?=
 =?us-ascii?Q?qe1FmlL82hP0qz6OSaE9G3aEptvRrjrqGh6LVKKayGXlyqgLwyvyG1Q2MKtK?=
 =?us-ascii?Q?sHPrmOKpEmqolyLoUo/0bIkqRqgJDmUgtatYa0PHYgP5ScbBUcLS3bxyB4Qk?=
 =?us-ascii?Q?jMTGZmKRUwzbR7Pa2jkJsKzpFxsRNp8DqO3TMP+cYNgiCM4HPXFQ3ccNwd9p?=
 =?us-ascii?Q?nGGsb7L+xsn35Z8j3ugb36GUgdSvVyu4VIRfgH3j+LrElfHejn6d5ilwIqhq?=
 =?us-ascii?Q?ZAEGLK5qCIGcTEN33OnyzUuHFRy+GqZTLxFC2Tcb6Ds3db/0GOIu6tg29LiU?=
 =?us-ascii?Q?CjR7kL5c873NJleC5B1HbJTiizupJV7R+Ss0nv/0ADolXj86c061xW52vFud?=
 =?us-ascii?Q?L6kjRYw9xmc+NrgocUjuJ5GTjvmW9mNnEWpJ+FBf5VkQj1uLKLYkUk1s8r07?=
 =?us-ascii?Q?DQHqKVtncsDniAvD5samu3Gtb3xprbv3Jy5+/kxJOiMNZWHzU4rgngjno/9n?=
 =?us-ascii?Q?IlNBRBijkS91oDdlkqX148kXSWmIJ5JyZ4nQmYUd3yI4iKxC8IOgxy2PiWfE?=
 =?us-ascii?Q?kIBQbSwnDmOTPmWBEG2CnfWLxl6X+ETAZsxKdRNd5E9Tz/5oCKRu6Kcb4EIx?=
 =?us-ascii?Q?icN7r0vqV8d9UBetb6ODOQmyJwG5oQVLvqOEP8ALK+GUIomd9g8vv31zzYzT?=
 =?us-ascii?Q?HDV48Rx6x0ziNqezUbAto54JpRMsLl5YUW0L1DOKlpBnfPI5cqa72tQyF02o?=
 =?us-ascii?Q?CPrviy8qRIUe1x90Fk0bEiSXe6BL3ZolwsacFiZj?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: SJ0PR11MB6744.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: fd426abf-9cd8-43fa-9522-08dc89c5e37d
X-MS-Exchange-CrossTenant-originalarrivaltime: 11 Jun 2024 03:23:39.7748 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: PlIZ02IEjfIcf12cAlTiW8puadZrGyWbnnGcyvotwoeXaQfZOTuypgAhjTntjtPOkhPGwF0eDMwBOWogdwdsV8/jiaFykTfEqRKxaoTeDwo=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BL1PR11MB5238
X-OriginatorOrg: intel.com
Received-SPF: pass client-ip=198.175.65.10;
 envelope-from=zhenzhong.duan@intel.com; helo=mgamail.intel.com
X-Spam_score_int: -45
X-Spam_score: -4.6
X-Spam_bar: ----
X-Spam_report: (-4.6 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.143,
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



>-----Original Message-----
>From: Eric Auger <eric.auger@redhat.com>
>Subject: [RFC v2 7/7] memory: Remove IOMMU MR iommu_set_iova_range
>API
>
>Since the host IOVA ranges are now passed through the
>PCIIOMMUOps set_host_resv_regions and we have removed
>the only implementation of iommu_set_iova_range() in
>the virtio-iommu and the only call site in vfio/common,
>let's retire the IOMMU MR API and its memory wrapper.
>
>Signed-off-by: Eric Auger <eric.auger@redhat.com>

Reviewed-by: Zhenzhong Duan <zhenzhong.duan@intel.com>=20

Thanks
Zhenzhong

>---
> include/exec/memory.h | 32 --------------------------------
> system/memory.c       | 13 -------------
> 2 files changed, 45 deletions(-)
>
>diff --git a/include/exec/memory.h b/include/exec/memory.h
>index 9cdd64e9c6..35d772e52b 100644
>--- a/include/exec/memory.h
>+++ b/include/exec/memory.h
>@@ -530,26 +530,6 @@ struct IOMMUMemoryRegionClass {
>      int (*iommu_set_page_size_mask)(IOMMUMemoryRegion *iommu,
>                                      uint64_t page_size_mask,
>                                      Error **errp);
>-    /**
>-     * @iommu_set_iova_ranges:
>-     *
>-     * Propagate information about the usable IOVA ranges for a given
>IOMMU
>-     * memory region. Used for example to propagate host physical device
>-     * reserved memory region constraints to the virtual IOMMU.
>-     *
>-     * Optional method: if this method is not provided, then the default =
IOVA
>-     * aperture is used.
>-     *
>-     * @iommu: the IOMMUMemoryRegion
>-     *
>-     * @iova_ranges: list of ordered IOVA ranges (at least one range)
>-     *
>-     * Returns 0 on success, or a negative error. In case of failure, the=
 error
>-     * object must be created.
>-     */
>-     int (*iommu_set_iova_ranges)(IOMMUMemoryRegion *iommu,
>-                                  GList *iova_ranges,
>-                                  Error **errp);
> };
>
> typedef struct RamDiscardListener RamDiscardListener;
>@@ -1945,18 +1925,6 @@ int
>memory_region_iommu_set_page_size_mask(IOMMUMemoryRegion
>*iommu_mr,
>                                            uint64_t page_size_mask,
>                                            Error **errp);
>
>-/**
>- * memory_region_iommu_set_iova_ranges - Set the usable IOVA ranges
>- * for a given IOMMU MR region
>- *
>- * @iommu: IOMMU memory region
>- * @iova_ranges: list of ordered IOVA ranges (at least one range)
>- * @errp: pointer to Error*, to store an error if it happens.
>- */
>-int memory_region_iommu_set_iova_ranges(IOMMUMemoryRegion
>*iommu,
>-                                        GList *iova_ranges,
>-                                        Error **errp);
>-
> /**
>  * memory_region_name: get a memory region's name
>  *
>diff --git a/system/memory.c b/system/memory.c
>index 9540caa8a1..248d514f83 100644
>--- a/system/memory.c
>+++ b/system/memory.c
>@@ -1914,19 +1914,6 @@ int
>memory_region_iommu_set_page_size_mask(IOMMUMemoryRegion
>*iommu_mr,
>     return ret;
> }
>
>-int memory_region_iommu_set_iova_ranges(IOMMUMemoryRegion
>*iommu_mr,
>-                                        GList *iova_ranges,
>-                                        Error **errp)
>-{
>-    IOMMUMemoryRegionClass *imrc =3D
>IOMMU_MEMORY_REGION_GET_CLASS(iommu_mr);
>-    int ret =3D 0;
>-
>-    if (imrc->iommu_set_iova_ranges) {
>-        ret =3D imrc->iommu_set_iova_ranges(iommu_mr, iova_ranges, errp);
>-    }
>-    return ret;
>-}
>-
> int memory_region_register_iommu_notifier(MemoryRegion *mr,
>                                           IOMMUNotifier *n, Error **errp)
> {
>--
>2.41.0


