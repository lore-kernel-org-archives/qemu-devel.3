Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2E8C7C3600B
	for <qemu-devel@archiver.kernel.org>; Thu, 27 Mar 2025 09:38:46 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1txjh5-0006vH-Bv; Thu, 27 Mar 2025 05:38:35 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <zhenzhong.duan@intel.com>)
 id 1txjh2-0006pc-0j
 for qemu-devel@nongnu.org; Thu, 27 Mar 2025 05:38:34 -0400
Received: from mgamail.intel.com ([192.198.163.18])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <zhenzhong.duan@intel.com>)
 id 1txjh0-0000Ev-CC
 for qemu-devel@nongnu.org; Thu, 27 Mar 2025 05:38:31 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1743068310; x=1774604310;
 h=from:to:cc:subject:date:message-id:references:
 in-reply-to:content-transfer-encoding:mime-version;
 bh=oCkIiI1O7bVA4oJn9enqipa1fU/9dB9lWdPAG8Wee80=;
 b=JVrOZAGa1Fbk/QerSOOvyb24prgzc/Snq+9pBKjqdDK20kJpxczt1JoU
 T/y3K6DemM4l7emoixDtGpIrTT4J9VHWUFvkMKm4YHbnycKJy+6pVh7C0
 Lyn7mMnc5vHEnGcTJ4OyKEfTF5QVwfSOC08t3+CJufLUQJmGoHvfRAtUx
 xw7P36OiMOzowGbIgZt8ALC9dP+fkPfp9TttZgh36yn0nZlM/GMGIiEvn
 d1epGOtU1J+iV5e8VBocqPLI5L2L3hXU2kLAI6VHcj+8Cp0TxpVSE0yhz
 obEAEEFvBpPpRKV6HZwopQQ7paR1s5lY/vMctAKHQjNbwwOulGOEROQJ4 g==;
X-CSE-ConnectionGUID: 8Fbq0W1+TveMussRTzFF+g==
X-CSE-MsgGUID: yaVTVlbqQXOMyDRm4Yv34A==
X-IronPort-AV: E=McAfee;i="6700,10204,11385"; a="43632142"
X-IronPort-AV: E=Sophos;i="6.14,280,1736841600"; d="scan'208";a="43632142"
Received: from orviesa004.jf.intel.com ([10.64.159.144])
 by fmvoesa112.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 27 Mar 2025 02:38:27 -0700
X-CSE-ConnectionGUID: kkYGL7mwQBSw0vCHICiIWw==
X-CSE-MsgGUID: HaojJ0ZYQVS6atfYxvKzVg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.14,280,1736841600"; d="scan'208";a="130151538"
Received: from orsmsx601.amr.corp.intel.com ([10.22.229.14])
 by orviesa004.jf.intel.com with ESMTP/TLS/AES256-GCM-SHA384;
 27 Mar 2025 02:38:27 -0700
Received: from ORSMSX901.amr.corp.intel.com (10.22.229.23) by
 ORSMSX601.amr.corp.intel.com (10.22.229.14) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.44; Thu, 27 Mar 2025 02:38:26 -0700
Received: from orsedg603.ED.cps.intel.com (10.7.248.4) by
 ORSMSX901.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.14 via Frontend Transport; Thu, 27 Mar 2025 02:38:26 -0700
Received: from NAM11-CO1-obe.outbound.protection.outlook.com (104.47.56.170)
 by edgegateway.intel.com (134.134.137.100) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.44; Thu, 27 Mar 2025 02:38:24 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=E/rU50+x0RRHsoyxriy9tQZuACM9CmYfMBveDcPceTFztjdEWAsW9BDEb9mN/nNEJyaTHQaSPJV/62CLHsVTqO0iSRfqa06N0Dl987x4SJlDQDOzB2rjM4ilyjbBBHvNMgVENSRNavcYb4cfVOfLh5lAwId8H+vAOEhOcjHKGbt/qXetQUr9YVbNDe892G4Zz3IdH1MVG7VV56XzSN2T8E3AXMlPknEx8RkBF+oAEQtWIbL0cmXZD0Ya9lfezc+7AvnBdVFuGYheOqxmNtxUuCodIL1D2AWZO5rFFULd4QxEehunTjv1qL8ukiX3mSkE5TKBImoiwKKstq4uEY/YbA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=WjNnsFCBrtNWqdwjFIQWFiYExkAc8Z5c/xzonHTwG30=;
 b=JhBRKXjbwcvYYCnb+DGluDamAkBIYnRJkbXUF+MckeqRbV8FOSobM0Y22IamOkWD46ADBWhaK9Nyg2/2KZ5ACbFBVR8NDkiu1G3xA+lyDEe0JPrXUJO5glhMl6ldmdkVKbkLp4eTPOOFhmwpAyvB3u4uh/WQ2ZgnIEuDYnMSmnFcnF6Ft5InCi3nWQajqcnIrn7DYWD0Jq+GcVrjFr6m1DA+Dad+SfCgy9QIia/Di/hetyNYYFrh9wWOSp1LXhfu/sEhMmMqTfISiJN4Aju0LNIMytHRZmBx9+bpKUeIfKBWgXdgm1b97n/92M4ouToxa9DH/0uj1EBJ2hGoSwBp7A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Received: from SJ0PR11MB6744.namprd11.prod.outlook.com (2603:10b6:a03:47d::10)
 by MW6PR11MB8337.namprd11.prod.outlook.com (2603:10b6:303:248::21)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8534.44; Thu, 27 Mar
 2025 09:37:51 +0000
Received: from SJ0PR11MB6744.namprd11.prod.outlook.com
 ([fe80::fe49:d628:48b1:6091]) by SJ0PR11MB6744.namprd11.prod.outlook.com
 ([fe80::fe49:d628:48b1:6091%6]) with mapi id 15.20.8534.043; Thu, 27 Mar 2025
 09:37:51 +0000
From: "Duan, Zhenzhong" <zhenzhong.duan@intel.com>
To: =?iso-8859-1?Q?C=E9dric_Le_Goater?= <clg@redhat.com>,
 "qemu-devel@nongnu.org" <qemu-devel@nongnu.org>, Alex Williamson
 <alex.williamson@redhat.com>
CC: Avihai Horon <avihaih@nvidia.com>, Eric Auger <eric.auger@redhat.com>,
 John Levon <john.levon@nutanix.com>, Joao Martins <joao.m.martins@oracle.com>
Subject: RE: [PATCH for-10.1 v2 14/37] vfio: Move VFIOAddressSpace helpers
 into container-base.c
Thread-Topic: [PATCH for-10.1 v2 14/37] vfio: Move VFIOAddressSpace helpers
 into container-base.c
Thread-Index: AQHbniQUo95OJXUSxEGsJKa5P9z8CLOGqz9A
Date: Thu, 27 Mar 2025 09:37:51 +0000
Message-ID: <SJ0PR11MB67445C1C439D9CE883012DDC92A12@SJ0PR11MB6744.namprd11.prod.outlook.com>
References: <20250326075122.1299361-1-clg@redhat.com>
 <20250326075122.1299361-15-clg@redhat.com>
In-Reply-To: <20250326075122.1299361-15-clg@redhat.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: SJ0PR11MB6744:EE_|MW6PR11MB8337:EE_
x-ms-office365-filtering-correlation-id: 835ab2fa-fcf5-48e5-cd7c-08dd6d130af8
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0; ARA:13230040|366016|1800799024|376014|38070700018;
x-microsoft-antispam-message-info: =?iso-8859-1?Q?TsTMgHh26HzqchmKfsI5yNpGm9B/YAm+i8+mT7ZjADEQ7Oi+h/+H75n07w?=
 =?iso-8859-1?Q?stHuqcJu2sJxePg9a6lqCVzgAVQ8ktVvJaDt6u1enuWSg7CCrfIjL5RVc0?=
 =?iso-8859-1?Q?9JLjVN2qk8RTWlWQuTbQDMepbTFAIYw4OA5LO91LStCnmjpkH6USnkYIpg?=
 =?iso-8859-1?Q?zosC/pOuaVUJeXnzcdfU1c10rcZxkIREQkhDZXlzxGtRzXy0N7E9aJYKAn?=
 =?iso-8859-1?Q?wVutXsCVFAuphM7MB3wY6ZJpDyEEZuGVV/787idAAX1l571jnBtWlMQY9I?=
 =?iso-8859-1?Q?bpGfoytV9nz71n/+F2OyzRTrnjOHrFA3qD5nGNB/sE3+wpIr27kLhDJg2l?=
 =?iso-8859-1?Q?fBw2TCFuoMO4n98dQCm0XHnpEUJgE3KLq2iFXwCdnTF9icyw2nsuAjWL/+?=
 =?iso-8859-1?Q?m8q4EXn+NjCnWIQe3N43jKAL9mC5V0J5nXHT1Cwws3j9HEnZDQViGLOkUQ?=
 =?iso-8859-1?Q?2DBS4LNybLHqJ2x05VuviTTK3TQfd4dEvfEI6CXvDGEN3casDTUSt16fAx?=
 =?iso-8859-1?Q?/3rtPYmWUGrgrC1NAi7ZT95CsjjP1zAZqR6wlqebIEQDNKq2R9+ShNlCp0?=
 =?iso-8859-1?Q?VcWkMOPraC9zwP6Ma/B+ghbMGsmrjb+gGVHX0TOzqSihyQGDiv/s/6cvBZ?=
 =?iso-8859-1?Q?tuK0oDz2HcO9jbY89NsUjsrVIOzpVexjHU7HptpOu+WNvpkCxn9Z7B2ul2?=
 =?iso-8859-1?Q?+fovq0sN/R3bm1kpNGZUv0SsKmWYEbhYmbrdU0I0OnSYOsRBrdePlBhzO4?=
 =?iso-8859-1?Q?R60ufmHOZVwU9CB/UJEEyr9SQajd7w+Jf8ErBBMKkKIrGA6iMarAaXAOKR?=
 =?iso-8859-1?Q?u4QSx0H0w0HhfDPaVN1gv06Do65bCL4u6yFarjmWtjnq4UByYvp8f6RaEV?=
 =?iso-8859-1?Q?M0aRx+YJNm2GcbT9gUcOzjPzCdBMJk4Q1tRgXBwSeVnaGWY5F+AEWznoOp?=
 =?iso-8859-1?Q?sZ5WkwVKSrJ1m7YDIi106mWzxXBCCgJbgs77EgIc2VLnAPVR6U5VxpV/E+?=
 =?iso-8859-1?Q?X3rsFQPHLIX4C94mnfHsv6IP7UhrazRafACglz3E334t+fQmW5gOU8k7lm?=
 =?iso-8859-1?Q?rIRpkXV8pxoa+GrZbJ7vIXoHNxU8hF63KPPRi251z36+G8w9j/x5MPVMYN?=
 =?iso-8859-1?Q?ihKPt7bQ0t3j15s4QpEDMiM9lEhka0pgoMwXQI1Xh4Y1K4cQDYI8HS8o8T?=
 =?iso-8859-1?Q?gLcW7B96eyXiS6YOA+tXhIPSGKoSHqwKIy33TfQASuFOF+ZHhc2OF1EkAE?=
 =?iso-8859-1?Q?oPLhLECSxWe/3Oa6zETxi40HbV00bqll0yyuUkklmSiUbVU/bab3AxgDMp?=
 =?iso-8859-1?Q?zmFzJU448lB85JSbYoCjN6JKWCZKQlJmHWe9rCEdfWp30vRsSlSsPBH+KX?=
 =?iso-8859-1?Q?cyGejO15EouFdaqdeAfeg+T77Y7TKRQDSsVcNLRD0tc4WJSBEG8UNe1cSs?=
 =?iso-8859-1?Q?ngQ3YqsKQaFfMq398td1BAfZYpZnpYPvrl+/3euxa1woTeTZ2WsLl3fVnw?=
 =?iso-8859-1?Q?JayoC453X8GcrNJM9kWSmR?=
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:SJ0PR11MB6744.namprd11.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(366016)(1800799024)(376014)(38070700018); DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?iso-8859-1?Q?L0Wcjpuifcz1mcrqGGK6OebvMzaRvQaS9cSQz1CNpZcKDY/KJ9eVmLkUqC?=
 =?iso-8859-1?Q?EmNGUxUP/KpDV4HXX9Zn6tyMXIKjcFj5RUtQ2/XOkqk1yJg/FzTFacQDHm?=
 =?iso-8859-1?Q?0PfiC4PuBcikT1fhSVwypMBO+yxYdZL9xXQYptFQ2qoQU2hMdOLnjZi61D?=
 =?iso-8859-1?Q?Ymu0Eb6AK/5/7YdzqWruHYRO+3UBx3/POCgpNqvK75xjfp8LbMFxbAzkmj?=
 =?iso-8859-1?Q?ejrbyDrk8SxVnImjoyUaty5zxvNDSU+K5bU1siCgCxikObdd4sCjU5oOQ3?=
 =?iso-8859-1?Q?DXdA+Xfuk0wXrcdxTBZhJuzRencEFUXUCntcJ4ZWhI6qPO2I1RRJL3MHM3?=
 =?iso-8859-1?Q?vVMm90XnKZ63r4EdNDRl7aaq9BNOZm1hMDgQ7kC44eVfJo8CcgWzjzkFDw?=
 =?iso-8859-1?Q?rCjQjw5UWY9fUaJ1rlS0Mb/5dEbsvrAPsZUMgN1ZAX/bx1/7CC9qqHBWEH?=
 =?iso-8859-1?Q?4cH1iLQgsMtdjQ8GFDxuLfb1jJjfxv04xDNrAxWd7i2rFiueVkIYBiAeZy?=
 =?iso-8859-1?Q?CdvKfq/XDwOpalCgGSgXyvjVWkjUfy0x4dzYL5WF4BmibITFzyaQLzoE+y?=
 =?iso-8859-1?Q?cTOCUAWxEYVLPQt+p6hkdy4jvwkV7erb5nG2o9vpCmqhLAA/myy3v18nqI?=
 =?iso-8859-1?Q?rLerXXcp5gB0rOWh7X5C4JqqIsZitS+rWxQ8EwU/e+T06/i9geVprgHbix?=
 =?iso-8859-1?Q?kyHktIajjqoPKskphONVArwat8cdlYo6bu1wz26+PuEp8jFVLLc9CZ9wqe?=
 =?iso-8859-1?Q?fTYqE9weaqjBwGhVj+sBCtyv9ZWsxOl7f9tXbY7c89WFy0F2n8VRu6rfj3?=
 =?iso-8859-1?Q?GIg8d0OShpgkjTi5rdwzXyQNOFbEU1kDiN24EazMD+Tcuf/FqwtgrAbaU1?=
 =?iso-8859-1?Q?grc47vN4ZXNSO4fHw3brX4Z0prlCcwZeNps7TY/o7witjs62ZASPaMSJeR?=
 =?iso-8859-1?Q?jxWb/FtOi6d7VxHQm0uQuho/AmB1MkvFjOEF4R8Blim7/TelzMzJ6BnnVd?=
 =?iso-8859-1?Q?M01Hf3JL4i+WMKjvoDE12KcOQIesysNW0dtb6o0oo+omkRixBxFouQc4so?=
 =?iso-8859-1?Q?xgz7X9Na35DLpAMhYnOxBkOzMwObusu6aMI4UiX9DK45Lhj8JBhVPq2Zuh?=
 =?iso-8859-1?Q?RsKKSxUQOu009UVLOqbMfCbsUphLcortsaZRWZW5gtUR8mH0/Kq32GyyYI?=
 =?iso-8859-1?Q?ggm4Coeo/ujhdch1Yu+ljCoBMJl9OwXODChq7YrUzQvvv50WDEAZb9negD?=
 =?iso-8859-1?Q?Tc8hNPh7ABjMst/TozP78x3MeCvL/BQrMVCQfHbJDBD5KUCLhZI1W20z/2?=
 =?iso-8859-1?Q?rkeai1Hv68+Bl1XtU0QRlbPOrmvPz4AWM7HflP78BSvfHekBv6PqUuRGyW?=
 =?iso-8859-1?Q?GxmVsvILrIlMhWmBdfn8XhoAakLKCRceFh/QfLMHH9x0cVd4SYPQTO+X9b?=
 =?iso-8859-1?Q?3CmJZNGKBw614bnttMvCvFLmVdGLLsSPq3x8iXGn9+0j9KSkQdKzHsFyM2?=
 =?iso-8859-1?Q?LDL9Oe2X54PkawrX9z3N42VMiw/GkOL2CKA42EDkEq1N4eDyqtQ2fz6nJ5?=
 =?iso-8859-1?Q?v3K1Ntm2e3Yj+Vkgxwk1WgLeA67GfIrMqLRirZwwtPiImuBy7HrKJsLuuE?=
 =?iso-8859-1?Q?Xx+ehF/ZUx/eoB5z2jqzNLjVQdQLMz1Wbd?=
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: SJ0PR11MB6744.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 835ab2fa-fcf5-48e5-cd7c-08dd6d130af8
X-MS-Exchange-CrossTenant-originalarrivaltime: 27 Mar 2025 09:37:51.1782 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: Ky/lzA/chZOLsoKQZU/jHAyXQG0clZA5Lcq54HT2G7c/+NOK0ru/eAOpUZ5PZFc0oFZP9tnx5pJhUnStgqBj4Dj4wgsZVuBiSFPdOAxBHfI=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MW6PR11MB8337
X-OriginatorOrg: intel.com
Received-SPF: pass client-ip=192.198.163.18;
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
>From: C=E9dric Le Goater <clg@redhat.com>
>Subject: [PATCH for-10.1 v2 14/37] vfio: Move VFIOAddressSpace helpers int=
o
>container-base.c
>
>VFIOAddressSpace is a common object used by VFIOContainerBase which is
>declared in "hw/vfio/vfio-container-base.h". Move the VFIOAddressSpace
>related services into "container-base.c".
>
>While at it, rename :
>
>  vfio_get_address_space -> vfio_address_space_get
>  vfio_put_address_space -> vfio_address_space_put
>
>to better reflect the namespace these routines belong to.
>
>Signed-off-by: C=E9dric Le Goater <clg@redhat.com>

Reviewed-by: Zhenzhong Duan <zhenzhong.duan@intel.com>

Thanks
Zhenzhong

