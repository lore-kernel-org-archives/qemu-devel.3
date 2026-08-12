Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 24654C5B567
	for <qemu-devel@archiver.kernel.org>; Wed, 12 Aug 2026 06:13:39 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wu2D6-0002kF-Jw; Wed, 12 Aug 2026 02:13:08 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <zhenzhong.duan@intel.com>)
 id 1wu2D4-0002jW-DJ
 for qemu-devel@nongnu.org; Wed, 12 Aug 2026 02:13:06 -0400
Received: from mgamail.intel.com ([192.198.163.17])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <zhenzhong.duan@intel.com>)
 id 1wu2D2-0001D4-9c
 for qemu-devel@nongnu.org; Wed, 12 Aug 2026 02:13:06 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1786515184; x=1818051184;
 h=from:to:cc:subject:date:message-id:references:
 in-reply-to:content-transfer-encoding:mime-version;
 bh=psQ7xe4AlI2Eeym5VW7SUwUZRUrgb9Eb5V+nEXo25pI=;
 b=lBROjWTOeJmESxBx2PfRBb2v1v1ua8zZH0q2Q5C2o8WuPMKz3V7AwTjx
 e2uKqfhLluDkv9JN9a6pMuWfbqvk5udpW66ZsPlcMb2EiicCD6rdjwsFW
 4lGxxI41CwDx+B4zXnCKzgd7sRkcay9m8sN+mosSeYDJhV/XWAkh3CLB1
 jilbgnE2XjSl58f33M56zCWqDcr66SNtBFjszepwfcrb6DHUe9YVZZqNc
 QztZF0zoKNoOB1WiU2AWhpXJCdWv6mC8S7RYuvfthlUUpPdvgBD7BhGi9
 bKKfPLNa1f6RlykIY5/jcg6i//Mgpd0XN2oJMHCOdQj525ZLNayHdvTZj Q==;
X-CSE-ConnectionGUID: 3fTVX9SnSZ2m9pysN8tvow==
X-CSE-MsgGUID: 4tZsVhr4Tl2RD88SEdAwcQ==
X-IronPort-AV: E=McAfee;i="6800,10657,11872"; a="86932536"
X-IronPort-AV: E=Sophos;i="6.25,218,1779174000"; d="scan'208";a="86932536"
Received: from orviesa001.jf.intel.com ([10.64.159.141])
 by fmvoesa111.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 11 Aug 2026 23:13:01 -0700
X-CSE-ConnectionGUID: cCQ1fWhoTsS9UjZqz1ABAQ==
X-CSE-MsgGUID: qazmucgOTSSxchRrb+5+eg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.25,218,1779174000"; d="scan'208";a="301788755"
Received: from orsmsx901.amr.corp.intel.com ([10.22.229.23])
 by orviesa001.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 11 Aug 2026 23:13:01 -0700
Received: from ORSMSX903.amr.corp.intel.com (10.22.229.25) by
 ORSMSX901.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.45; Tue, 11 Aug 2026 23:13:00 -0700
Received: from ORSEDG901.ED.cps.intel.com (10.7.248.11) by
 ORSMSX903.amr.corp.intel.com (10.22.229.25) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.45 via Frontend Transport; Tue, 11 Aug 2026 23:13:00 -0700
Received: from BN1PR04CU002.outbound.protection.outlook.com (52.101.56.52) by
 edgegateway.intel.com (134.134.137.111) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.45; Tue, 11 Aug 2026 23:13:00 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=zH0b39rXzgTktbM6hanYIAFcq85zH5z2lqJvYyfTHl477pBd815FKR/yx4F2DrUUWGVWIq1K4NbHc6ZLCSIuAXu76VOTYNGGP/VKg87cldxOiJR3rG7VqJEIP/quKvwnOOG55351mB/N7xL2kCXCJHV0eV6GRcCfXxJaYG6dACyk1K4kQcZJyNxU8NyYpfdBuryixOg4iYqM1552GphD5t/F3KCopGjKALEarLup8a14w9Zc5EHnAi47km5gC1sRFCotefsuhjBiJX3fOd6YSDcu4J/i99LmNobdbx9DatB/CGfrpwY1LHc64cJyuLZxH/JLbSoGH1Y81yDtuDD0hA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=psQ7xe4AlI2Eeym5VW7SUwUZRUrgb9Eb5V+nEXo25pI=;
 b=kVrdM1+vRJ5+KzPOm+z5P7HL4hE7Vx2FqaaFI1oHnZ9e6PXUDYlxWzGjYChHJiqbk5Ay0950hfzdB/u2lxf2gCP+CRdn+XBGeCeLObpg3axbENCUdkAH3jVjRxVGzoLkYL4rPCT5OJXKSdSpD9JhZmxspKzgidkRlPsaSwJsbgPakMH09USF83/yYDZpvoEVpAK3R39zeWxVkra0rWqejNqiZ7kGM+Rsz61qeoWg5Bg5hOkt+rfZ1qvl1TC2OyH1jzxUvelwuIvFQ2YHFQ2n5mG4Xp6d6lT+5cN6fxTDCPAc4EC4ktEGVZ7wm36Yq4hU28Jt/wH+YHRxeA4c0XRYLQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Received: from IA3PR11MB9136.namprd11.prod.outlook.com (2603:10b6:208:574::12)
 by MW5PR11MB5810.namprd11.prod.outlook.com (2603:10b6:303:192::22)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.315.12; Wed, 12 Aug
 2026 06:12:57 +0000
Received: from IA3PR11MB9136.namprd11.prod.outlook.com
 ([fe80::37b4:37a9:4f3:518b]) by IA3PR11MB9136.namprd11.prod.outlook.com
 ([fe80::37b4:37a9:4f3:518b%3]) with mapi id 15.21.0292.024; Wed, 12 Aug 2026
 06:12:56 +0000
From: "Duan, Zhenzhong" <zhenzhong.duan@intel.com>
To: =?utf-8?B?Q2zDqW1lbnQgTUFUSElFVS0tRFJJRg==?=
 <clement.mathieu--drif@bull.com>, "qemu-devel@nongnu.org"
 <qemu-devel@nongnu.org>
CC: "alex@shazbot.org" <alex@shazbot.org>, "clg@redhat.com" <clg@redhat.com>, 
 "eric.auger@redhat.com" <eric.auger@redhat.com>, "mst@redhat.com"
 <mst@redhat.com>, "jasowangio@gmail.com" <jasowangio@gmail.com>,
 "jgg@nvidia.com" <jgg@nvidia.com>, "nicolinc@nvidia.com"
 <nicolinc@nvidia.com>, "skolothumtho@nvidia.com" <skolothumtho@nvidia.com>,
 "joao.m.martins@oracle.com" <joao.m.martins@oracle.com>, "Tian, Kevin"
 <kevin.tian@intel.com>, "Liu, Yi L" <yi.l.liu@intel.com>, "Hao, Xudong"
 <xudong.hao@intel.com>
Subject: RE: [PATCH v3 4/6] intel_iommu_accel: Add PRQ injection for
 passthrough device
Thread-Topic: [PATCH v3 4/6] intel_iommu_accel: Add PRQ injection for
 passthrough device
Thread-Index: AQHdJXavK3P/m/cPtkO2/5hzNqPxn7aYbQ0AgAGG26A=
Date: Wed, 12 Aug 2026 06:12:56 +0000
Message-ID: <IA3PR11MB91365D3EA7D414CE859EE03E92DC2@IA3PR11MB9136.namprd11.prod.outlook.com>
References: <20260806073825.363468-1-zhenzhong.duan@intel.com>
 <20260806073825.363468-5-zhenzhong.duan@intel.com>
 <b576999a3a01460bbb7a66b2666e0f1dcbf3d8b9.camel@bull.com>
In-Reply-To: <b576999a3a01460bbb7a66b2666e0f1dcbf3d8b9.camel@bull.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: IA3PR11MB9136:EE_|MW5PR11MB5810:EE_
x-ms-office365-filtering-correlation-id: 62bdda16-4294-4ac1-1881-08def838c0ba
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
 ARA:13230040|7416014|376014|366016|23010399003|1800799024|4143699003|11063799006|38070700021|56012099006|10067099003|22082099003|18002099003;
x-microsoft-antispam-message-info: wyN50JFPmTyU823WQPrbtvUp/TLdpgYTstB0cJ8gLvKyPDlHFehR6fKzAHhIcXp27wq5TI06FwmkJYgKo1DugOoe1ryLpQwnp/8PYiuC5yRE20EGh3Db66jAeX+0Wa3Ig6FP/jRY9qiGL1o8825xFBtOLZl2zHp8mLDzEiNlVIqeYh9V/ZjGFEFQ2xFeBHq9YFH88b5FokfWJYB82R2rW8yiDe8/NH/jh89x04IHL0SuQ6zvm9joSCwEemEtSWKiwpfcR5hMr1My1pVzb8hMVCkwcTwn+pFbJMhfpXd8juRUIfRZ46NZEwQW/BfD+jVbWnQADrBqbA5fGTlexUXcvigW9akc4Z5awsW5XNm0we/ZlaOP2/IzrUJGKotDvnCVgFFytJtgERNHk0jKfIvYxyoG+gQgwfwz5cpTY4E3dxTyARtNrKNofID+0f4J9vhuyk3jWT0GO2wvEP+9Gx7mKCzDlDJxcnX/yhXERD7tfM6/Vwn1SbaEsqKJlLTwThRSQwOIewo7q2vFOuWHNcuZve2WhgeftNnLa4UF/Bo38QIkd+1OfauO5pcf0qoC1FNcn7tyyHY5+EBER4NrRlp6STiQulay4G3ati34KwUU44nE92yH6A17g8V9jcdvkbu7bG1JRyabT2EojIp7PqctLsEoOnAifjscX6Q08X6iARTJoCpCoqEAB+19Cw6QD7NDjCLgoQm/0h0HVj15NwW2sQT35gNxZM+/ji9mZeFN13o=
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:IA3PR11MB9136.namprd11.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(7416014)(376014)(366016)(23010399003)(1800799024)(4143699003)(11063799006)(38070700021)(56012099006)(10067099003)(22082099003)(18002099003);
 DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?YWRGYk95MVBoTG44UTZEeEpZMVFKdWM1b3NiTzN3Y1B2cGZUNkwvOVVwODJD?=
 =?utf-8?B?dlFzL3BmUG5nRVFMSVBUVGdHbmtlRDFRcTgxZGxhUlFFQ0tkSHB5RG9RU0h4?=
 =?utf-8?B?ZUNsV0l4RVAzVGRQblRORUJibVNWcnhZVFBwRFhyeXV6ZUVyK2djQm0xd2xp?=
 =?utf-8?B?NnV4UTNCaHptUU94SnNuSkZEczJqWmNXcEU4TDJ2SDNuNm1NTzEvUmlzVHNZ?=
 =?utf-8?B?TkxuVUtLalNEekpNTzhhcXJaMXRBM3NIdmIrV25ienRMYVo1SnlaaC9kTjJR?=
 =?utf-8?B?NzBwdndrTmJpRWRBMEpXUzJmTnFIUytDaWJ3Wm4zOWQzdTVpdUd0eXZ5WFo3?=
 =?utf-8?B?MHUxbDgxUXlheUNhWE9oUlIycWpBWFRUY05mbnREdzF6YlJEeEJWb2JXQVE1?=
 =?utf-8?B?S1lDMS9pYmMvdy9TeXhQZEM5MmpCcnJ0Y1B2K1VhclpjMm1zRVROMVhiakxG?=
 =?utf-8?B?dWxZLzNqVjVrZjhqeXVsaSs3UTJ6THkyK08wemRTeVdZT0doMis5WERmWVF5?=
 =?utf-8?B?ak4rVUNMMjY5NnVPSG5OOHI4VVpCbkF4Y1dRL2RlN0o2S0ZYUjBQd2hDaVV6?=
 =?utf-8?B?SVpKdmlScWpaR0tCM2JkdnJZTjlCNkxxQXUwS1lBY3VvZGxxRmtYeHVyd0xy?=
 =?utf-8?B?akc3UzM0bEJaU2tYU3Jmd2dQUE9vR0pDbTVMQzNpSG5GM205eGpyWDE5M2to?=
 =?utf-8?B?b1hnWmRtSkhhSVRhbGVKYWRjU0luejl0Ym11ckhLa3JDTDZoenRkK1lQNlIz?=
 =?utf-8?B?VFo5UTNOY3o4cXJQR0J5cE1UakFoOWFBSFRYV3cvQWFJdlpxR3lNd1ROTzdN?=
 =?utf-8?B?M2NqQjlpdGJxNkZQY3gvL2JZRTVMbnl5TkhENkdVSjNsRjJDeTU5U2F3OVkw?=
 =?utf-8?B?OU9XaFNSU1V5UE5LYWlSWkpvZ0sxRG1SK01FTzNlY0M1TDFFWk1XRkY4ZDJ3?=
 =?utf-8?B?eHdycXh6RlZpeWpyUGxJSXVvMVlvTWZmRTRsbnF2NjdMdmNSM1h0a0hXMkRL?=
 =?utf-8?B?bDNkNHdsMkFIUkpWc2owVFM2QnpUYWwzWlQrTUVnK2UzMHhVaE5VMmFjWVdX?=
 =?utf-8?B?RHFGTXdxZHZTMXVFLyt4N2taV21KYlJpOG5CV3ZqUnc2c3NNV2FMNUJ3dUh1?=
 =?utf-8?B?bWp2ZEs4Q2F1c2RlTWN6K2dvQ2FJTUhUdFgyVUJpZm14azZZSkJTQ2I5QWpE?=
 =?utf-8?B?T3RLNk1ncTJacTdTLzR0Zm1mRDFCaGR6Vm1vRVVmUGpjZ0RNSUsvZmxzLy9E?=
 =?utf-8?B?d1FaRW5QSWNITFUxcXQxTVQ4SUorVjVPNFc2UUdTeGlnNXRiMGYwZmVsYW9F?=
 =?utf-8?B?RkJwWUZUUXFnQVMreDd0dzcvbzV5cFh4UmJrMlk5cFd3Q0hYYUFvMFZVYlRs?=
 =?utf-8?B?K1RXYU15SDZVUE5BT08zYnRyYU1UL3hNM1VmYzZZQms0bVAxaDJFUGcwa2wr?=
 =?utf-8?B?cmxQRk15c1RZek84QjdlWWtQZ0RhbTJHSldtVk4yZGFoTGRUTW1wUkx0NDlo?=
 =?utf-8?B?d2hXVVRGbHpQcyt1RU1RcTA5ZitMSHFkakovVm14QWVpZ1A4ZGRTd2ZPQ3Nk?=
 =?utf-8?B?SG1CS2NHd1lQSnM5K01QYXlGcm9teUFkRkQvSWRPTUlSaHUzNkVsTng1cGdE?=
 =?utf-8?B?V1Z4LzZhemVUZEYvWlZEUy80aGwrZTdBVVJXUUZBSjRkVnlQN1hSUkdBNDhZ?=
 =?utf-8?B?bG9YUi8wUmFzNEFhSWs3dE1pV1gvVHBjRnEyWWFIUEYycTR0K2F6RWEzS1ZF?=
 =?utf-8?B?OS9sdm9xVC80YXdiVFFyMy9ZY3MzWUhDUStkWFpKbE9QWnVPcnlQYTlUZ1Bh?=
 =?utf-8?B?d05sbkVJM2s0eVZ4d1Y4b21sZktibFpNcEorSkxSNXJUbUwvYkR2bmF0dEk4?=
 =?utf-8?B?QVVEU2RpTnl6NEhSc1M0a29WMTJMdENHTDBOdWYxZGhFN2UxTGlONDhDZ0RK?=
 =?utf-8?B?alJ2S3YxNFFteHZQSmdxK1VuL0hZNEJFcnk1clFrOG1lcVBVRURnNXltekty?=
 =?utf-8?B?ZDZpNlpSbFhtdWo3TUI2SzZYSGxOaklvM2JwbEpWNXBtMUJPajFFUkQ0WWlI?=
 =?utf-8?B?ZW8vYVZ3L05Zd252MytINjRhMEZWeGhHM3BwUUdsZnJuSmZzNXJPaFJVeG1y?=
 =?utf-8?B?S3N2MHdxdXdRcEZmM01PNFI4anRHK21yR2FjSG1hTUpOUVcxSDVFeGFOcVBT?=
 =?utf-8?B?djlmeVhBcTdxRFZQejFCNzJoNUNZcE5mVTZxRzQzaWtsN0FtWmYzWWYvV2Ra?=
 =?utf-8?B?VVJRVlkyOHBmYVVDNTVrcjNzMkhXaUlXdkE3YkNuUDlwZGFJSmtHSVUxdHpD?=
 =?utf-8?B?WEp0SElDZjdWZXdSS1NNMDczMjFNSWM4MU5DUi90YUk3TlowRWVldz09?=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-Exchange-RoutingPolicyChecked: kkQZD0+cceV9UAbnfEiaY2xAbei7N4CssMOwAOWwW2DciuSrPJqcn/rFELJjCDaEu0tqe98fwlhC5yRrBesgtywBOz9Z0tTLP9LZN7VW8i0hJn1M1plCIKFSizUsawbY7ZLVse2tnGR4+kXA7hLaOtp3Z64oaeHTn775CkqjQ1kERhEB92NbUFoOQAvPiffNPDKKhAuUUvy3MURnnNGzk1MYHypNg/kOnlpce7X6LKitPLL7ZblRFJ/9TqYub7Q6pf9YczNty55HxU5aTsgAKFGhnZK/1whoD87RELoISsr7bm3HQnY2E9ZsJkXWIYNuo8X9If+gWp+aaax1ySCEUw==
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: IA3PR11MB9136.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 62bdda16-4294-4ac1-1881-08def838c0ba
X-MS-Exchange-CrossTenant-originalarrivaltime: 12 Aug 2026 06:12:56.8112 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: +fGYGLc8wkKKmyP2DlebQvTgcFyCo7Maozis8pcVjmPVCs9e4lPosLVV7N70ifZtt5Hm+7xLc3T8xJWIwfd5IAYmri2VjTdLSN9OiaCs6t0=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MW5PR11MB5810
X-OriginatorOrg: intel.com
Received-SPF: pass client-ip=192.198.163.17;
 envelope-from=zhenzhong.duan@intel.com; helo=mgamail.intel.com
X-Spam_score_int: -44
X-Spam_score: -4.5
X-Spam_bar: ----
X-Spam_report: (-4.5 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.102,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_MED=-2.3, SPF_HELO_NONE=0.001,
 SPF_NONE=0.001 autolearn=ham autolearn_force=no
X-Spam_action: no action
X-BeenThere: qemu-devel@nongnu.org
X-Mailman-Version: 2.1.29
Precedence: list
List-Id: qemu development <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <https://lists.nongnu.org/archive/html/qemu-devel>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=subscribe>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org

DQoNCj4tLS0tLU9yaWdpbmFsIE1lc3NhZ2UtLS0tLQ0KPkZyb206IENsw6ltZW50IE1BVEhJRVUt
LURSSUYgPGNsZW1lbnQubWF0aGlldS0tZHJpZkBidWxsLmNvbT4NCj5TdWJqZWN0OiBSZTogW1BB
VENIIHYzIDQvNl0gaW50ZWxfaW9tbXVfYWNjZWw6IEFkZCBQUlEgaW5qZWN0aW9uIGZvciBwYXNz
dGhyb3VnaA0KPmRldmljZQ0KPg0KPg0KPk9uIFRodSwgMjAyNi0wOC0wNiBhdCAwMzozOCAtMDQw
MCwgWmhlbnpob25nIER1YW4gd3JvdGU6DQo+PiBXaGVuIHRoZSBndWVzdCBlbmFibGVzIHRoZSBQ
UlEgaW4gdklPTU1VLCBhbGxvY2F0ZSBhIEZBVUxUUSBvYmplY3Qgc28gdGhhdA0KPj4gaG9zdC1z
aWRlIHJlY292ZXJhYmxlIGZhdWx0IGV2ZW50cyBjYW4gYmUgcmVjZWl2ZWQgYW5kIHByb3BhZ2F0
ZWQgYmFjayB0bw0KPj4gdGhlIGd1ZXN0Lg0KPj4NCj4+IEluc3RhbGwgYW4gZXZlbnQgaGFuZGxl
ciBvbiB0aGUgRkFVTFRRIGZkIHRvIHJlYWQgYW5kIHByb3BhZ2F0ZSBob3N0DQo+PiBnZW5lcmF0
ZWQgcmVjb3ZlcmFibGUgZmF1bHQgZXZlbnRzIHRvIHRoZSBndWVzdC4NCj4+DQo+PiBUaGUgaGFu
ZGxlciBydW5zIGluIFFFTVUncyBtYWluIGxvb3AsIHVzaW5nIGEgbm9uLWJsb2NraW5nIGZkIHJl
Z2lzdGVyZWQNCj4+IHZpYSBxZW11X3NldF9mZF9oYW5kbGVyKCkuDQo+Pg0KPj4gU2lnbmVkLW9m
Zi1ieTogWmhlbnpob25nIER1YW4NCj48W3poZW56aG9uZy5kdWFuQGludGVsLmNvbV0obWFpbHRv
OnpoZW56aG9uZy5kdWFuQGludGVsLmNvbSk+DQo+PiBUZXN0ZWQtYnk6IFh1ZG9uZyBIYW8NCj48
W3h1ZG9uZy5oYW9AaW50ZWwuY29tXShtYWlsdG86eHVkb25nLmhhb0BpbnRlbC5jb20pPg0KPj4g
LS0tDQo+PiDCoGh3L2kzODYvaW50ZWxfaW9tbXVfYWNjZWwuaMKgwqDCoCB8wqDCoCAyICsNCj4+
IMKgaHcvaTM4Ni9pbnRlbF9pb21tdV9pbnRlcm5hbC5oIHzCoMKgIDMgKw0KPj4gwqBody9pMzg2
L2ludGVsX2lvbW11LmPCoMKgwqDCoMKgwqDCoMKgwqAgfMKgwqAgNyArLQ0KPj4gwqBody9pMzg2
L2ludGVsX2lvbW11X2FjY2VsLmPCoMKgwqAgfCAxNjEgKysrKysrKysrKysrKysrKysrKysrKysr
KysrKysrKy0tDQo+PiDCoGh3L2kzODYvdHJhY2UtZXZlbnRzwqDCoMKgwqDCoMKgwqDCoMKgwqAg
fMKgwqAgMSArDQo+PiDCoDUgZmlsZXMgY2hhbmdlZCwgMTY0IGluc2VydGlvbnMoKyksIDEwIGRl
bGV0aW9ucygtKQ0KPj4NCj4+IGRpZmYgLS1naXQgYS9ody9pMzg2L2ludGVsX2lvbW11X2FjY2Vs
LmggYi9ody9pMzg2L2ludGVsX2lvbW11X2FjY2VsLmgNCj4+IGluZGV4IDQ2YzFhMjk0MDkuLmUw
MzE5NzQ5YTUgMTAwNjQ0DQo+PiAtLS0gYS9ody9pMzg2L2ludGVsX2lvbW11X2FjY2VsLmgNCj4+
ICsrKyBiL2h3L2kzODYvaW50ZWxfaW9tbXVfYWNjZWwuaA0KPj4gQEAgLTE4LDYgKzE4LDggQEAg
dHlwZWRlZiBzdHJ1Y3QgVlREQWNjZWxQQVNJRENhY2hlRW50cnkgew0KPj4gwqDCoMKgwqAgVlRE
UEFTSURFbnRyeSBwYXNpZF9lbnRyeTsNCj4+IMKgwqDCoMKgIHVpbnQzMl90IHBhc2lkOw0KPj4g
wqDCoMKgwqAgdWludDMyX3QgZnNfaHdwdF9pZDsNCj4+ICvCoMKgwqAgdWludDMyX3QgZmF1bHRf
aWQ7DQo+PiArwqDCoMKgIGludCBmYXVsdF9mZDsNCj4+IMKgwqDCoMKgIFFMSVNUX0VOVFJZKFZU
REFjY2VsUEFTSURDYWNoZUVudHJ5KSBuZXh0Ow0KPj4gwqB9IFZUREFjY2VsUEFTSURDYWNoZUVu
dHJ5Ow0KPj4NCj4+IGRpZmYgLS1naXQgYS9ody9pMzg2L2ludGVsX2lvbW11X2ludGVybmFsLmgg
Yi9ody9pMzg2L2ludGVsX2lvbW11X2ludGVybmFsLmgNCj4+IGluZGV4IDkyNGU5MWNiOGEuLjVl
YmMyMDRlOWEgMTAwNjQ0DQo+PiAtLS0gYS9ody9pMzg2L2ludGVsX2lvbW11X2ludGVybmFsLmgN
Cj4+ICsrKyBiL2h3L2kzODYvaW50ZWxfaW9tbXVfaW50ZXJuYWwuaA0KPj4gQEAgLTc4Niw0ICs3
ODYsNyBAQCBpbnQgdnRkX2Rldl90b19jb250ZXh0X2VudHJ5KEludGVsSU9NTVVTdGF0ZSAqcywN
Cj51aW50OF90IGJ1c19udW0sDQo+PiDCoFZUREFkZHJlc3NTcGFjZSAqdnRkX2dldF9hc19ieV9z
aWQoSW50ZWxJT01NVVN0YXRlICpzLCB1aW50MTZfdCBzaWQpOw0KPj4gwqBpbnQgdnRkX2Rldl9n
ZXRfcGVfZnJvbV9wYXNpZChJbnRlbElPTU1VU3RhdGUgKnMsIFBDSUJ1cyAqYnVzLCB1aW50OF90
DQo+ZGV2Zm4sDQo+PiDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDC
oMKgwqDCoMKgwqDCoMKgwqAgdWludDMyX3QgcGFzaWQsIFZURFBBU0lERW50cnkgKnBlKTsNCj4+
ICtpbnQgdnRkX3ByaV9yZXF1ZXN0X3BhZ2UoUENJQnVzICpidXMsIHZvaWQgKm9wYXF1ZSwgaW50
IGRldmZuLCB1aW50MzJfdCBwYXNpZCwNCj4+ICvCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKg
wqDCoMKgwqDCoMKgwqDCoMKgwqAgYm9vbCBwcml2X3JlcSwgYm9vbCBleGVjX3JlcSwgaHdhZGRy
IGFkZHIsIGJvb2wgbHBpZywNCj4+ICvCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKg
wqDCoMKgwqDCoMKgwqAgdWludDE2X3QgcHJnaSwgYm9vbCBpc19yZWFkLCBib29sIGlzX3dyaXRl
KTsNCj4+IMKgI2VuZGlmDQo+PiBkaWZmIC0tZ2l0IGEvaHcvaTM4Ni9pbnRlbF9pb21tdS5jIGIv
aHcvaTM4Ni9pbnRlbF9pb21tdS5jDQo+PiBpbmRleCA4MmMzYzNiMmMzLi5jYzhjOTIwNWRmIDEw
MDY0NA0KPj4gLS0tIGEvaHcvaTM4Ni9pbnRlbF9pb21tdS5jDQo+PiArKysgYi9ody9pMzg2L2lu
dGVsX2lvbW11LmMNCj4+IEBAIC01MzcwLDEwICs1MzcwLDkgQEAgc3RhdGljIGludA0KPnZ0ZF9w
cmlfcGVyZm9ybV9pbXBsaWNpdF9pbnZhbGlkYXRpb24oVlREQWRkcmVzc1NwYWNlICp2dGRfYXMs
DQo+PiDCoH0NCj4+DQo+PiDCoC8qIFBhZ2UgUmVxdWVzdCBEZXNjcmlwdG9yIDogNy40LjEuMSAq
Lw0KPj4gLXN0YXRpYyBpbnQgdnRkX3ByaV9yZXF1ZXN0X3BhZ2UoUENJQnVzICpidXMsIHZvaWQg
Km9wYXF1ZSwgaW50IGRldmZuLA0KPj4gLcKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKg
wqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgIHVpbnQzMl90IHBhc2lkLCBib29sIHByaXZf
cmVxLCBib29sIGV4ZWNfcmVxLA0KPj4gLcKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKg
wqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgIGh3YWRkciBhZGRyLCBib29sIGxwaWcsIHVp
bnQxNl90IHByZ2ksDQo+PiAtwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDC
oMKgwqDCoMKgwqDCoMKgwqDCoMKgwqAgYm9vbCBpc19yZWFkLCBib29sIGlzX3dyaXRlKQ0KPj4g
K2ludCB2dGRfcHJpX3JlcXVlc3RfcGFnZShQQ0lCdXMgKmJ1cywgdm9pZCAqb3BhcXVlLCBpbnQg
ZGV2Zm4sIHVpbnQzMl90IHBhc2lkLA0KPj4gK8KgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDC
oMKgwqDCoMKgwqDCoMKgwqDCoCBib29sIHByaXZfcmVxLCBib29sIGV4ZWNfcmVxLCBod2FkZHIg
YWRkciwgYm9vbCBscGlnLA0KPj4gK8KgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDC
oMKgwqDCoMKgwqDCoCB1aW50MTZfdCBwcmdpLCBib29sIGlzX3JlYWQsIGJvb2wgaXNfd3JpdGUp
DQo+PiDCoHsNCj4+IMKgwqDCoMKgIEludGVsSU9NTVVTdGF0ZSAqcyA9IG9wYXF1ZTsNCj4+IMKg
wqDCoMKgIFZUREFkZHJlc3NTcGFjZSAqdnRkX2FzOw0KPj4gZGlmZiAtLWdpdCBhL2h3L2kzODYv
aW50ZWxfaW9tbXVfYWNjZWwuYyBiL2h3L2kzODYvaW50ZWxfaW9tbXVfYWNjZWwuYw0KPj4gaW5k
ZXggZDJmNDFmMThmMS4uNzliZmU3NjNmYyAxMDA2NDQNCj4+IC0tLSBhL2h3L2kzODYvaW50ZWxf
aW9tbXVfYWNjZWwuYw0KPj4gKysrIGIvaHcvaTM4Ni9pbnRlbF9pb21tdV9hY2NlbC5jDQo+PiBA
QCAtOSw2ICs5LDcgQEANCj4+IMKgICovDQo+Pg0KPj4gwqAjaW5jbHVkZSAicWVtdS9vc2RlcC5o
Ig0KPj4gKyNpbmNsdWRlICJxZW11L2Vycm9yLXJlcG9ydC5oIg0KPj4gwqAjaW5jbHVkZSAic3lz
dGVtL2lvbW11ZmQuaCINCj4+IMKgI2luY2x1ZGUgImludGVsX2lvbW11X2ludGVybmFsLmgiDQo+
PiDCoCNpbmNsdWRlICJpbnRlbF9pb21tdV9hY2NlbC5oIg0KPj4gQEAgLTc3LDE0ICs3OCwxNTEg
QEAgVlRESG9zdElPTU1VRGV2aWNlDQo+KnZ0ZF9maW5kX2hpb2RfaW9tbXVmZChWVERBZGRyZXNz
U3BhY2UgKmFzKQ0KPj4gwqDCoMKgwqAgcmV0dXJuIE5VTEw7DQo+PiDCoH0NCj4+DQo+PiAtc3Rh
dGljIGJvb2wgdnRkX2NyZWF0ZV9mc19od3B0KFZUREhvc3RJT01NVURldmljZSAqdnRkX2hpb2Qs
DQo+PiAtwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDC
oMKgwqDCoMKgIFZURFBBU0lERW50cnkgKnBlLCB1aW50MzJfdCAqZnNfaHdwdF9pZCwNCj4+IC3C
oMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKg
wqAgRXJyb3IgKiplcnJwKQ0KPj4gK3N0YXRpYyB2b2lkIHZ0ZF9wcnFfcmVwb3J0X2ZhdWx0KFZU
REFjY2VsUEFTSURDYWNoZUVudHJ5ICp2dGRfcGNlLA0KPj4gK8KgwqDCoMKgwqDCoMKgwqDCoMKg
wqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqAgc3RydWN0IGlvbW11
X2h3cHRfcGdmYXVsdCAqZmF1bHQsIGludCBjbnQpDQo+PiArew0KPj4gK8KgwqDCoCBWVERIb3N0
SU9NTVVEZXZpY2UgKnZ0ZF9oaW9kID0gdnRkX3BjZS0+dnRkX2hpb2Q7DQo+PiArwqDCoMKgIC8q
IHZ0ZF9wcmlfcmVxdWVzdF9wYWdlKCkgYWNjZXB0IFBDSSBwYXNpZCBhcyBpbnB1dCAqLw0KPg0K
PldoYXQgYWJvdXQgYWRkaW5nIHRoaXMgY29tbWVudCB0byB0aGUgZG9jc3RyaW5nIG9mIHRoZSBm
dW5jdGlvbiBpdHNlbGY/DQoNClN1cmUsIHdpbGwgZG8uDQoNClRoYW5rcw0KWmhlbnpob25nDQo=

