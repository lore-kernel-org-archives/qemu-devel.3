Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0E9FCD64083
	for <qemu-devel@archiver.kernel.org>; Wed, 17 Dec 2025 07:21:56 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vVlqV-00084s-6v; Wed, 17 Dec 2025 02:21:15 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <zhenzhong.duan@intel.com>)
 id 1vVlqS-00081v-8l
 for qemu-devel@nongnu.org; Wed, 17 Dec 2025 02:21:13 -0500
Received: from mgamail.intel.com ([198.175.65.15])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <zhenzhong.duan@intel.com>)
 id 1vVlqF-00029n-VV
 for qemu-devel@nongnu.org; Wed, 17 Dec 2025 02:21:06 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1765956060; x=1797492060;
 h=from:to:cc:subject:date:message-id:references:
 in-reply-to:content-transfer-encoding:mime-version;
 bh=6onQnSYaSjzy6bu9j2cwG6QJ20eqWIqlkXqRLiN4YYY=;
 b=WLeftoaI6hRSPBEqHvSij1sMI7KsOEFcABWxQ8jYipvwhIXMvbvJ9Cm4
 XEUAIl6psj+qcEIHwL2yp4oJkFxfv+pXH/MqjY6D82wdvQpL28qC4s7/v
 BkjZOUpwBxeo3ZYogrx+qpToAwuv0/GbspjLL9n/9bZcaniDE0IJdNITw
 PX/7vc9Ld48pcMFtiR6CLXkl8QvHbFj+7XkhQLoprf3AUUBHrY2hbSCr2
 eYGXoS2UqJEBzVI07LFRkk2ZydI4BVPmHw2yvyZL1iQVMn1hdbbcoJpW0
 7vQxKxe0s8IL9FhFLVjtePAzUpn9/YusHG9qPie2H0CjIEMNUbkeC3Kqu w==;
X-CSE-ConnectionGUID: HDzWcLAJSpicXXnCKB5uuw==
X-CSE-MsgGUID: mVIZx/10RTSnp3bC4Pd//A==
X-IronPort-AV: E=McAfee;i="6800,10657,11644"; a="71518171"
X-IronPort-AV: E=Sophos;i="6.21,155,1763452800"; d="scan'208";a="71518171"
Received: from fmviesa001.fm.intel.com ([10.60.135.141])
 by orvoesa107.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 16 Dec 2025 23:20:56 -0800
X-CSE-ConnectionGUID: 4j+gIKrKRta6tJGVJ5DU+Q==
X-CSE-MsgGUID: 6YKCTa80T/eGI01yDkZUxw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.21,155,1763452800"; d="scan'208";a="229302693"
Received: from orsmsx903.amr.corp.intel.com ([10.22.229.25])
 by fmviesa001.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 16 Dec 2025 23:20:55 -0800
Received: from ORSMSX903.amr.corp.intel.com (10.22.229.25) by
 ORSMSX903.amr.corp.intel.com (10.22.229.25) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.29; Tue, 16 Dec 2025 23:20:54 -0800
Received: from ORSEDG901.ED.cps.intel.com (10.7.248.11) by
 ORSMSX903.amr.corp.intel.com (10.22.229.25) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.29 via Frontend Transport; Tue, 16 Dec 2025 23:20:54 -0800
Received: from DM1PR04CU001.outbound.protection.outlook.com (52.101.61.6) by
 edgegateway.intel.com (134.134.137.111) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.29; Tue, 16 Dec 2025 23:20:53 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=VgNhxqpgzlRAdK3QSHy9DC8Fgj1X9FnSBXHhW7dKHD1Wfs4um6aTjLem1KJ7w+LxXLuXncFFq9bYubb6HSdMgKLQpebxRShrgvbQB8SiCyc/BEi/iyN4gmopVl54k0iSxLJhEtlAf+OQEZywcAAK0XkL8LNKmDwncalv2G1EKzNl4ulXtOnfVISewdAI8uGcUUPJwhn/IIpnevlhBSGSMul3eQOJ0FZFdvJb+/pXwTm5L2F7I1g5Z5JrHy+V7/qL4XAEXBv6tM8CJghMZCh5nzMZpc7UDJ5ma4D56dWFDoxjgF5W8EP4k44jlMZfpHadO90V9URdGRYqzvIeRVZbQw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=7KZShzrFv6w+qt2xfysOhneac0zLmADbt/DcA3Y22q4=;
 b=F4VRnMgPZLcQB4FUwD+W0mVA3RXyDVaxCiw4A4U0AYJsrYguH+/yFbhyhKc01m/COCpHO1nMSI8IOprZSEhLLvWuLBIfKc2qtpRE2bPjVkZ8touN0j0UhZzi3FyZ0D8cV+TTZBUS2ZlT8bOL8jWfAO9XqZqxe+/HT9tpJUSQg9CZd1mxwKrAnRdCoVDwLNH00CKG21h41JBMPeuHgbOS3wddXKDS0AAGxB5Uy646DXyxq3lSYLYFtyx24ocYPDKzLr53bjnfJAAvrLkEPggZem7VUAnbNxPMXjRJ0bGFT0YqhCWy+A3Vli1TepQZNRz+5GO8NlrW7k9NQHRiVslKTw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Received: from IA3PR11MB9136.namprd11.prod.outlook.com (2603:10b6:208:574::12)
 by SJ5PPF162366726.namprd11.prod.outlook.com
 (2603:10b6:a0f:fc02::813) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9434.6; Wed, 17 Dec
 2025 07:20:50 +0000
Received: from IA3PR11MB9136.namprd11.prod.outlook.com
 ([fe80::604b:77a4:b1be:3f13]) by IA3PR11MB9136.namprd11.prod.outlook.com
 ([fe80::604b:77a4:b1be:3f13%7]) with mapi id 15.20.9434.001; Wed, 17 Dec 2025
 07:20:50 +0000
From: "Duan, Zhenzhong" <zhenzhong.duan@intel.com>
To: =?iso-8859-1?Q?C=E9dric_Le_Goater?= <clg@redhat.com>,
 "qemu-devel@nongnu.org" <qemu-devel@nongnu.org>
CC: "alex@shazbot.org" <alex@shazbot.org>, "eric.auger@redhat.com"
 <eric.auger@redhat.com>, "mst@redhat.com" <mst@redhat.com>,
 "jasowang@redhat.com" <jasowang@redhat.com>, "peterx@redhat.com"
 <peterx@redhat.com>, "ddutile@redhat.com" <ddutile@redhat.com>,
 "jgg@nvidia.com" <jgg@nvidia.com>, "nicolinc@nvidia.com"
 <nicolinc@nvidia.com>, "skolothumtho@nvidia.com" <skolothumtho@nvidia.com>,
 "joao.m.martins@oracle.com" <joao.m.martins@oracle.com>,
 "clement.mathieu--drif@eviden.com" <clement.mathieu--drif@eviden.com>, "Tian, 
 Kevin" <kevin.tian@intel.com>, "Liu, Yi L" <yi.l.liu@intel.com>, "Peng, Chao
 P" <chao.p.peng@intel.com>
Subject: RE: [PATCH v9 00/19] intel_iommu: Enable first stage translation for
 passthrough device
Thread-Topic: [PATCH v9 00/19] intel_iommu: Enable first stage translation for
 passthrough device
Thread-Index: AQHcbY9AReLaq+3KWEek0HB2hE9cArUivIcAgADTNdCAAGVSgIAAHtKw
Date: Wed, 17 Dec 2025 07:20:50 +0000
Message-ID: <IA3PR11MB91361CD5DE6DA4898C361DC092ABA@IA3PR11MB9136.namprd11.prod.outlook.com>
References: <20251215065046.86991-1-zhenzhong.duan@intel.com>
 <56e582e7-d14c-46f6-b2cb-4a328315d505@redhat.com>
 <IA3PR11MB913661A98BDF8BE7019277D192AAA@IA3PR11MB9136.namprd11.prod.outlook.com>
 <0b2f87ff-2c5f-4a1a-b4a6-db640f0bafb0@redhat.com>
In-Reply-To: <0b2f87ff-2c5f-4a1a-b4a6-db640f0bafb0@redhat.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: IA3PR11MB9136:EE_|SJ5PPF162366726:EE_
x-ms-office365-filtering-correlation-id: e5b29223-daed-488e-47f4-08de3d3cce50
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
 ARA:13230040|376014|7416014|1800799024|366016|38070700021; 
x-microsoft-antispam-message-info: =?iso-8859-1?Q?kQJtTofR3QfheRo8pxWpc3JO3xuErHFyq+0oSHFAVIL/339Jyb1ux0PawJ?=
 =?iso-8859-1?Q?hPs81h1gQBgoAjkp3yhuO8eCybl+470ewArbKh+mkLRQfWZvcS6VkHxNAu?=
 =?iso-8859-1?Q?1tkPvHH852+2YpZRzOWtL1XlhaUsWVVao/b33x40uNxZ+uLomRYScnBbAh?=
 =?iso-8859-1?Q?fJbN0Vu/o2nqoLpjzeXV43aXgxk+JUYeignxySM3XUFkMHPP6OEjK3VhgP?=
 =?iso-8859-1?Q?q8EsUhC5g953JOJbKiWz6gXQrbm8cMjOJqTNSy0/3CAjxR9f1zaTQ5Pw2P?=
 =?iso-8859-1?Q?vnxtWBwCeyWzfxT8DdUTT/eCZaoqGXDteGBfpp+FH2imwNUOo6icjt/GCh?=
 =?iso-8859-1?Q?mzxj7Qc+E0+rjYdqWw+KKJkhH/YOvw+LyvpeznnL5HwtGks3KTTIU1qrI/?=
 =?iso-8859-1?Q?VcYBHOZge5fU3AfA7hGKdmXLMZ7u6h+93q7j/5DR7vNC5LEW/2q7kpxRK7?=
 =?iso-8859-1?Q?cP6gKwDhKUrmrjBCsgMYaPVtlfbhg8+8Z3Y905izLXQFLJMnVQ5jHHhjkr?=
 =?iso-8859-1?Q?DvpY18EnUIJgtiu1DpIkWDLNiiTLsDro0AdW6c/8FIdsGX8eLWCMhFgM/J?=
 =?iso-8859-1?Q?MsDnHX8RW6I0gOUWv+KDnyGo4iBm0Mg3xWIH/dl8AMXnOWLk9O1TXgmit9?=
 =?iso-8859-1?Q?aR+84FL6LlbaKciXyLYdfHZhmqSRBcischBXJw6ZKbw92xRySrz8fxRZvb?=
 =?iso-8859-1?Q?ZOOWcX068OS37S7mF5UduCo/mUoRvSekuc3OM8MU6hPLPFrey3GClEfqqQ?=
 =?iso-8859-1?Q?QIcsEjGAbNfLrbt1+yOqDLiGl07auYmNfDG+/++d2qshsSNh/pS3K46NCW?=
 =?iso-8859-1?Q?UHF8bViamgu0RBmDIgRzQ2JTZdlmc8NyrOotjP0jhiL26VKVmHWkokbNJg?=
 =?iso-8859-1?Q?6hnzmIRXlDbMRNzm/X/mQSn4EYaRtAP+UV+BqCOePqGneW9Qei/WMdOdvE?=
 =?iso-8859-1?Q?F6GoMqfnvSJuWztLJe79ad8tFz4SwDOvtnLUVRH10Q0qVYXBYUTlm4O3lq?=
 =?iso-8859-1?Q?vYdH3gHuEDywBoFEJUS7Rq6XZOuEjoC78zXUmSRAbRYZeNoYFREUgZhh76?=
 =?iso-8859-1?Q?yRbUIf6zeyV0kWn7nABPEqAlqeziz8xMADrS+ihxWhCLkH4m8XhUMf3/d7?=
 =?iso-8859-1?Q?QTxJsqfwJ4jmDYDjHu5qEPQSgDZECajIyM2bce9w2+UMuXs50NKB5eVZWN?=
 =?iso-8859-1?Q?0TolS9l0wP65tyHYhjBrjB79vQ/aePi1t5DONfaJWypry0zScKEUDlMbSs?=
 =?iso-8859-1?Q?ueL1ji/oFGHK/d5aORQb92HkrMy5yR1jXT3hj6a7WHzDygkZACtOpNkhPa?=
 =?iso-8859-1?Q?DNMLa0AznHgtna95aCgqOS24lzIde+fUwnuO2bEUz18lxWuF3EyyjZyxo4?=
 =?iso-8859-1?Q?fPWa7VJuJ4F0g5ZjLlK+vckM7Aovz7hZeTQe88zEoNV8nV2gA36o15QiZD?=
 =?iso-8859-1?Q?WYz5oX4iwJ0IPdCF8MX3VRyefDyX4+VVw9w+81Nvh/FncgcQrUD8aXLoMz?=
 =?iso-8859-1?Q?sQh7KtD9kIayHkdqd4svC7+yoF5GKI39huHT+rtuYcjw=3D=3D?=
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:IA3PR11MB9136.namprd11.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(376014)(7416014)(1800799024)(366016)(38070700021); DIR:OUT;
 SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?iso-8859-1?Q?9du0YbqnD4l9sgJvYN5VxhMpBd11uih6ZF25PXRfo6/BUZ9tnaPnbimhqS?=
 =?iso-8859-1?Q?oaAPzFRrke9ox3djSFjzs2d1zs/6zXmL57NuSx+XwRfA82tXqgVcFhbxYr?=
 =?iso-8859-1?Q?boEwSP4i+4MWtAkrh40O+yKuKQsR/oNK4gpthR0jPllfykbyXrvQxDZqNp?=
 =?iso-8859-1?Q?eH2BQNqAn5yXjw7ilkc7atbrZVs8Cbz3AmR7MZkCb9bHEsOrGeBKwm8G53?=
 =?iso-8859-1?Q?C1lKPgQ28EEd0avFcN0AAmWpmdrZjPLfnGR8OhiuqgN50aiMO3MiNlJMuK?=
 =?iso-8859-1?Q?gpwv5GFgN7SKBzCjrrhRPQ/uzZJFV3VrD9w3bZvlTOtwKUXhlaEcOZKxtA?=
 =?iso-8859-1?Q?W+FVL0nIOdh170Gpr0ZKoB2vuS7qM09MRsSQ2TENFSlPrk5KwyEzVQa3jF?=
 =?iso-8859-1?Q?TBtri5f23cnPvgP7niQnKrQo17vjlmEVLEFGQ+YewOsxvbxcfPAn6rokG0?=
 =?iso-8859-1?Q?ZWYEgztVmOVy0Pia9I/EmXQ+7qtjuJ4EfD+3FSneWp04tGQ4LnXfYdkW8y?=
 =?iso-8859-1?Q?TuQr5O0S+M80DlCWuIgSxWEKNuqtC/Y3wzmLwahn/JQuTYY/Yrhl/wVZpJ?=
 =?iso-8859-1?Q?CRUQorsd9fS8BMTS7KmYIsumR6Jsk0/0IhJqp8NN3uKF7JA8JYSfxH4GiN?=
 =?iso-8859-1?Q?XLN0I8oo39LSwoHkY1qr9sguUwWitVJgLKrjrsvbBf++6nBmbDO6ngM09Q?=
 =?iso-8859-1?Q?FO2J60/MQiyl8FLnpN0rzeStQ2hAtA2aLc318rrp0gcLN5QX9lX0vLIqSV?=
 =?iso-8859-1?Q?MCk9vajW829e2lFC9k3DGnSRLZkT4oPAliLFrCPFDOVHNMmQ6VLqen7Hyd?=
 =?iso-8859-1?Q?KpUHwVbgYFMjlOk0HGQSbjkspmV2KZOSOFz5QCjOA7Kfz2Fno0J0pSLDmF?=
 =?iso-8859-1?Q?nGpymOss7FHTOeAt0MG7XAqwtWjdi9QgtHpzfr+Fh9NafY1qlm099z2owp?=
 =?iso-8859-1?Q?Sc27boPECn8jNudtQJJuDogeT253qVyrwI+8GfBbHbcvVgNELkQdjQm5nQ?=
 =?iso-8859-1?Q?V8GeJFnUeK9TMw+MrKyGxQ5DEUoPKxCooGCSZDPZqM4tKfK9UCnaJURsoJ?=
 =?iso-8859-1?Q?Ab4YlVYk24M/EOwmOaVxAasWSdXbkmRzQ515NXUaj0XAqRKgMKYECmyz7E?=
 =?iso-8859-1?Q?BIW57FyMyzZok1X2Z/KUfPB4MTxWxkoA1yPo6m65jAeLte1aYCeJBY5Ubl?=
 =?iso-8859-1?Q?DWV7L6d9VglEY9LyMGI9zSVWzAs0UPlqyj55cyKWH0n9TetsruGuk9XiRM?=
 =?iso-8859-1?Q?exKhqxP4/8ljNYVYZJzOPH1R88ZeO3b4MMNShntsubVFZiRTr4lfTCC8za?=
 =?iso-8859-1?Q?WgYAcXMm6fBz592BzuUYpEOEYNDCkVBWNOWrfdf1bAhziJ9dWAq29X3g7H?=
 =?iso-8859-1?Q?D0/LbbppLWhvI71664e1UtuPL1JKJ3gFRn7Kx+8Jdy47eMg9NVxNcU/+Vi?=
 =?iso-8859-1?Q?n4tPnIdF7SVTL0Z8u5v4ec7+xngPJdlO+WAeNrzjFlYWucWCghtd6yVgY3?=
 =?iso-8859-1?Q?IDoCHxRdUtS91LS09C15O4lIWYTvKDETIRGIOXzWI2ID8aSEq6TZm5MbDR?=
 =?iso-8859-1?Q?zsffK4Ne/auoujuxtW8bTGfQUjBg8AWXSv11M677Bi4K/sjmEcD2zMPFvi?=
 =?iso-8859-1?Q?O+x4nZAY3E8iRrMaX022GrYm/sNhxSNg+n?=
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: IA3PR11MB9136.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: e5b29223-daed-488e-47f4-08de3d3cce50
X-MS-Exchange-CrossTenant-originalarrivaltime: 17 Dec 2025 07:20:50.1851 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: Kf8V+dgnwW7FdfYb1wL5k1qdr0oSEJxA5c9jv6GwVv4yci1ZMDd0imIRXE3fMlfv1Jd1+XviyAalHuAiQBTAKIwZDG6BXIlMnHRiFRBGn+I=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ5PPF162366726
X-OriginatorOrg: intel.com
Received-SPF: permerror client-ip=198.175.65.15;
 envelope-from=zhenzhong.duan@intel.com; helo=mgamail.intel.com
X-Spam_score_int: -43
X-Spam_score: -4.4
X-Spam_bar: ----
X-Spam_report: (-4.4 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_MED=-2.3, RCVD_IN_MSPIKE_H2=0.001,
 RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001, RCVD_IN_VALIDITY_SAFE_BLOCKED=0.001,
 SPF_HELO_NONE=0.001, T_SPF_PERMERROR=0.01 autolearn=ham autolearn_force=no
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
>Subject: Re: [PATCH v9 00/19] intel_iommu: Enable first stage translation =
for
>passthrough device

...

>>>> Below is an example to enable first stage translation for passthrough
>>> device:
>>>>
>>>>       -M q35,...
>>>>       -device intel-iommu,x-scalable-mode=3Don,x-flts=3Don...
>>>>       -object iommufd,id=3Diommufd0 -device
>>> vfio-pci,iommufd=3Diommufd0,...
>>>
>>> What about libvirt support ? There are patches to enable IOMMUFD
>>> support with device assignment but I don't see anything related
>>> to first stage translation. Is there a plan ?
>>
>> I think IOMMUFD support in libvirt is non-trivial, good to know there is
>progress.
>> But I didn't find a match in libvirt mailing list,
>https://lists.libvirt.org/archives/search?q=3Diommufd
>> Do you have a link?
>
>Here  :
>
>
>https://lists.libvirt.org/archives/list/devel@lists.libvirt.org/thread/KFY=
UQGMX
>WV64QPI245H66GKRNAYL7LGB/

Thanks

>
>There might be an update. We should ask Nathan.
>
>> I think first stage support is trivial, only to support a new property
><...x-flts=3Don/off>.
>> I can apply a few time resource from my manager to work on it after this
>series is merged.
>> It's also welcome if anyone is interested to take it.
>
>ok. So, currently, we have no way to benefit from translation
>acceleration on the host unless we directly set the 'x-flts'
>property on the QEMU command line.

Yes, thanks for reminding.
I'll try add 'x-flts' support to libvirt to fill the gap recently,
I will take one week vacation starting this Friday, may try it after vacati=
on.

>
>>> This raises a question. Should ftls support be automatically enabled
>>> based on the availability of an IOMMUFD backend ?
>>
>> Yes, if user doesn't force it off, like <...iommufd=3D'off'> and IOMMUFD
>backend available, we can enable it automatically.
>
>The plan is to keep VFIO IOMMU Type1 as the default host IOMMU
>backend to maintain a consistent behavior. If an IOMMUFD backend
>is required, it should be set explicitly. One day we might revisit
>this choice and change the default. Not yet.

OK, maybe we need to maintain consistent behavior for intel_iommu too,
if first-stage is required, it should be set explicitly, if not set, defaul=
t to second stage(shadow page).

>
>
>>>> Test done:
>>>> - VFIO devices hotplug/unplug
>>>> - different VFIO devices linked to different iommufds
>>>> - vhost net device ping test
>>>> - migration with QAT passthrough
>>>
>>> Did you do any experiments with active mlx5 VFs ?
>>
>> No, there are only a few device drivers supporting VFIO migration and we
>only have QAT.
>> Let me know if you see issue on other devices.
>Since we lack libvirt integration (of flts), the tests need
>to be run manually which is more complex for QE. IOW, it will
>take more time but we should definitely evaluate other devices.

Oh, if you mean nesting feature test, we did play with different devices we=
 had,
ixgbevf, ICE vf, DSA and QAT. For VFIO migration with nesting, we only test=
ed QAT.

Thanks
Zhenzhong

