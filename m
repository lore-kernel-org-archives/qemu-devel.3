Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 65B45D1CA18
	for <qemu-devel@archiver.kernel.org>; Tue,  5 Nov 2024 03:12:32 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1t89z0-0005Pw-Mw; Mon, 04 Nov 2024 22:11:55 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <zhenzhong.duan@intel.com>)
 id 1t89yx-0005Pd-1o
 for qemu-devel@nongnu.org; Mon, 04 Nov 2024 22:11:51 -0500
Received: from mgamail.intel.com ([192.198.163.8])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <zhenzhong.duan@intel.com>)
 id 1t89yt-0006Sr-Oy
 for qemu-devel@nongnu.org; Mon, 04 Nov 2024 22:11:50 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1730776308; x=1762312308;
 h=from:to:cc:subject:date:message-id:references:
 in-reply-to:content-transfer-encoding:mime-version;
 bh=EGWI20kVSXh14VlPmFI7m6m/mKJft88m5e2Emt86Suo=;
 b=AaaaXoyeAR72/MjeCIOFsqZsNOEr1fklQlhccq9P0+Mah58SIAil+csS
 ZJ2ph8rfB9aOdUnhB71eNtWfA3y4Vdk/NZNazUJ4aQiNhlyFXRnJtLPLP
 7tII7V5WLa86GSR28Ysom8F+VJIWQgOKpFiLetnb19kd8RDnjlmVaPWej
 /QZTq73RfKuCEcnQnv91zngNtFZQe1Ba3ZobEe8zdlzB7ZhVL4Mby/+is
 G8cEhbzLWpRE4aZ3GRePA254HkAalu5shGNJ5+SCTw3ok9vt16L9exp38
 nQ67bcSewnhTchJXeNMKQhY5fQYAWMUTpm2QM+BIgm0yHTvKrSVZ9PMBo w==;
X-CSE-ConnectionGUID: aW+t04IaSA6eHyjd5Bz6FA==
X-CSE-MsgGUID: VnIRXETzS3CEwNhRJK4veg==
X-IronPort-AV: E=McAfee;i="6700,10204,11246"; a="48012300"
X-IronPort-AV: E=Sophos;i="6.11,258,1725346800"; d="scan'208";a="48012300"
Received: from fmviesa002.fm.intel.com ([10.60.135.142])
 by fmvoesa102.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 04 Nov 2024 19:11:42 -0800
X-CSE-ConnectionGUID: ZeaKjdq8QGW6vocrVxARHA==
X-CSE-MsgGUID: xoa6EUc8QMeKJJXYM+wM4Q==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.11,258,1725346800"; d="scan'208";a="107190291"
Received: from orsmsx601.amr.corp.intel.com ([10.22.229.14])
 by fmviesa002.fm.intel.com with ESMTP/TLS/AES256-GCM-SHA384;
 04 Nov 2024 19:11:42 -0800
Received: from orsmsx602.amr.corp.intel.com (10.22.229.15) by
 ORSMSX601.amr.corp.intel.com (10.22.229.14) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.39; Mon, 4 Nov 2024 19:11:41 -0800
Received: from ORSEDG601.ED.cps.intel.com (10.7.248.6) by
 orsmsx602.amr.corp.intel.com (10.22.229.15) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.39 via Frontend Transport; Mon, 4 Nov 2024 19:11:41 -0800
Received: from NAM12-MW2-obe.outbound.protection.outlook.com (104.47.66.48) by
 edgegateway.intel.com (134.134.137.102) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.39; Mon, 4 Nov 2024 19:11:41 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=I/UsSV3dZfRMEv/qxRIABY+pylK09Rg42hHJEZU3Iy0JErsEvJ2GRqXJPRn0/aVDkNpF6Ysm3ymtVQD+b7L7vQkSh5SklCM/+n0D0UKsdaMt9djFgQn6ahvLxcviC6mbZyWw325/wMbCJ7Pu07UKZYdtkcK2KU/Fvlxe3TZ2p01d6kBOX2iFwCva2OwOqajuIw0eY2RzKrQslfWh/2WiqVxdZTxDcf33TzYuS48u0g5q7eRAfuyvxboUGsI3TsTG+kZyjEtHI5Vqp1m/0hZnWWrMIcEBOF1Kb9D7fl+waU9SPb8IMVG0n/cBK4ndZJrYjaKBqD7RUeNNta7P0UKY8A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=EGWI20kVSXh14VlPmFI7m6m/mKJft88m5e2Emt86Suo=;
 b=KxOo0O6en++EWCOX6m8ZD/z+26EbMpwSnLfCr5TW8sd6/UPJGWc3UB+Tk7F3uJHZOql7TACLg+ZNKSyoAtgHU/+e/+1rrZQZwc8xlDywnZn/Cjt0fLh9VaSSfdYaj7XlRIo/24y2NkT/9Hcb3jvSb7v6mZoxpv7LMs3HfD1SYBdzqXFYJ8lADXdF/4QLtcSLTtwVYP+YqAIjm34Un6t6/1MLVoA0ZCssHDJ6wMJ5LeeVqJ7ciWCAvQ6RWTR+9gS2QQ7zO4flrn4S0OcGwb9pO4n40wBCacSqR9o84MUWvFW+UzccencfNcVRWKTcXmp+R1ZjtI9tcQryB9ltdwWbSw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Received: from SJ0PR11MB6744.namprd11.prod.outlook.com (2603:10b6:a03:47d::10)
 by MW5PR11MB5857.namprd11.prod.outlook.com (2603:10b6:303:19d::17)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8114.30; Tue, 5 Nov
 2024 03:11:38 +0000
Received: from SJ0PR11MB6744.namprd11.prod.outlook.com
 ([fe80::fe49:d628:48b1:6091]) by SJ0PR11MB6744.namprd11.prod.outlook.com
 ([fe80::fe49:d628:48b1:6091%5]) with mapi id 15.20.8114.028; Tue, 5 Nov 2024
 03:11:38 +0000
From: "Duan, Zhenzhong" <zhenzhong.duan@intel.com>
To: "Liu, Yi L" <yi.l.liu@intel.com>, "qemu-devel@nongnu.org"
 <qemu-devel@nongnu.org>
CC: "alex.williamson@redhat.com" <alex.williamson@redhat.com>,
 "clg@redhat.com" <clg@redhat.com>, "eric.auger@redhat.com"
 <eric.auger@redhat.com>, "mst@redhat.com" <mst@redhat.com>,
 "peterx@redhat.com" <peterx@redhat.com>, "jasowang@redhat.com"
 <jasowang@redhat.com>, "jgg@nvidia.com" <jgg@nvidia.com>,
 "nicolinc@nvidia.com" <nicolinc@nvidia.com>, "joao.m.martins@oracle.com"
 <joao.m.martins@oracle.com>, "clement.mathieu--drif@eviden.com"
 <clement.mathieu--drif@eviden.com>, "Tian, Kevin" <kevin.tian@intel.com>,
 "Peng, Chao P" <chao.p.peng@intel.com>, Yi Sun <yi.y.sun@linux.intel.com>,
 Paolo Bonzini <pbonzini@redhat.com>, Richard Henderson
 <richard.henderson@linaro.org>, Eduardo Habkost <eduardo@habkost.net>, Marcel
 Apfelbaum <marcel.apfelbaum@gmail.com>
Subject: RE: [PATCH v4 15/17] intel_iommu: Introduce a property x-fls for
 scalable modern mode
Thread-Topic: [PATCH v4 15/17] intel_iommu: Introduce a property x-fls for
 scalable modern mode
Thread-Index: AQHbExuAfv1IrXwu+EKkvlrbZNnFPLKmvOsAgAAeNBCAABN0AIABSpGA
Date: Tue, 5 Nov 2024 03:11:38 +0000
Message-ID: <SJ0PR11MB6744C2B6BF0942C17720B23B92522@SJ0PR11MB6744.namprd11.prod.outlook.com>
References: <20240930092631.2997543-1-zhenzhong.duan@intel.com>
 <20240930092631.2997543-16-zhenzhong.duan@intel.com>
 <5cbe6426-e64c-45f1-b276-c7dbb70ff3ed@intel.com>
 <SJ0PR11MB6744F2BFCE29E91D6180609292512@SJ0PR11MB6744.namprd11.prod.outlook.com>
 <df02d9d4-3a54-449f-8d99-cca10bd28cf5@intel.com>
In-Reply-To: <df02d9d4-3a54-449f-8d99-cca10bd28cf5@intel.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: SJ0PR11MB6744:EE_|MW5PR11MB5857:EE_
x-ms-office365-filtering-correlation-id: b7661414-41cd-4562-24d5-08dcfd479015
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
 ARA:13230040|1800799024|366016|376014|7416014|38070700018; 
x-microsoft-antispam-message-info: =?utf-8?B?OXR0bmY0V0VrbDBKUzZXWmdPajFyZm9kNk4zQnhCa3pJQ0FQODFhK0VBUFNz?=
 =?utf-8?B?a09GaktmbllVR2lHdDV4TWcrRXVxbUxGWjVTc1FnTHIxa3IvYjBPT1ZtazdK?=
 =?utf-8?B?dDBPaGtZRXhMZ0Fhai81SitkZGVjTjFlU1RvQjVhMHA0dTZ6RERnY0Y1N0tp?=
 =?utf-8?B?NWJlVGlzTzd5RVA3alFmbXBtTEFmajQ1aGNabnZYSFYvQlMzMzJ0OFduZlJj?=
 =?utf-8?B?K1FGVGdMZml3aGlGbFpwSDJhd1ZpUVRzbVRsUjZGUUtld2ViYU5qMzR3NW5K?=
 =?utf-8?B?Y0N5djRnZXhPZDFEbDlrQjU4UWlSL2VmWDU0QXlnRWpHNzhIZjdTM3V5elJk?=
 =?utf-8?B?VThQaWFkbmxvc3FqcExvME5OaUF3dStpZElOcGtKUlFocVRjQVo5NkdBeDVr?=
 =?utf-8?B?VEFMUWJRYllXMVdrSk1ucTcxZ0s3YTFRSWU3dkhtVk9yTVEyWThhZlhxWWFy?=
 =?utf-8?B?QyswcUovL3ZXUXdQY2RLTnl1TW1zM3lIcTcwQjZyNmtNZ0ZUY1YrbnkzWS9C?=
 =?utf-8?B?NTFUd0xDZHJpbHpmNjRTaDhqaGpEYXFYbzhBNS9ueHBMa1dzT2RiQ1BRVTZk?=
 =?utf-8?B?S1VyUnBQbHNNT1dnRUN3cDMvclRXNldSbFMzNDdwejB1RjJkNFpuYlduRGxE?=
 =?utf-8?B?OUdqd2MweDRqU0xIcWxvYTFQeFMrTmY5b1phTFhzR0FvcHBvTG8zOENuRU1m?=
 =?utf-8?B?SHFuMUp5dlE4OWRjWXVWeGNneEg0SUViYVJhVW5WZENsSkV1NXBUNFRTRyt1?=
 =?utf-8?B?MG5wdElJQ1l6bVppc05wK0IzdHNwQzk1aDd3ZkZyQ1FZdThCVWdrcmdBcWxZ?=
 =?utf-8?B?MUhhSHpDdHVJYlJuM1BHZDJTbThQRUE1TVVqVEFVNnB3NTA4TDVudldBWmcy?=
 =?utf-8?B?Nk9pamgrK2piRGtTcVZlMW9Yd3RBb1k1RzUvajNLZ1VrSytkajZmNFkxR0Y1?=
 =?utf-8?B?ZEZoYlBHeEtFRkllN3V2cXk0T1Y5dEVTblFtQ1dvUXpRdEhMenlQdGk3QjV5?=
 =?utf-8?B?WUQrNDFhMWZtNjFaN0xLcjRVVDNtbVNHWTF0YjZlbHUwVW40NlJ4ak15N2Ro?=
 =?utf-8?B?Wmw3SjlHVUdubm5xeDJtS0NoUFArT2xUNStxWDV1M0J0NzBRSDlpcS8yY2xn?=
 =?utf-8?B?TzIzY0NlY1pqQjBsNkhCeHloRHc5NkRHZUhZYTFxdjlJbS9Cc25ERVBDUzdW?=
 =?utf-8?B?dlJQNkpjKzk3TVRJUnN3RzgvV1h1azBZaktSWjBDamtvMDBNTkFQcnVkYmNP?=
 =?utf-8?B?dERwMXdaalRvZmJCN1Q3WW95bjRISENTdHk1VXkwYlEvOW5UU3JUM00rL1BF?=
 =?utf-8?B?bE5Nb095b2J5dFQvclg5cGhIZHM2cFQ5TWEzeitVaUgyb3hBZzFpMUNkMjBK?=
 =?utf-8?B?ZFBobENDR09TUFJFN2pGZmhBbzdVSEtzV0xFV2dSeEhRMlV1STZNR1A2RERJ?=
 =?utf-8?B?S0s5WnVvOVJoWGF5RGlybnVSNldCTG84WW4vZEtJdk5LanRGMGRqWXVReVMx?=
 =?utf-8?B?bXpWVW54dCs4czdlSWVUZVhsaEFHd2ZnTitra1dCaXlQMWRBSUdNMlF6cHdu?=
 =?utf-8?B?dkVHRFFkNFN0NTREVXlhL0JYeklKTmM5U1IvaFJRRlBiS1N5c2xRSklvOFg3?=
 =?utf-8?B?ZlBha3NUU1c1TnBjdjdzeUtOdDk4SVNYZEtTTVNKNTg3N0c5Q1drWjlOMkUr?=
 =?utf-8?B?UHpUSjNNSUpkKzFpSFR4L3dud1RDRFJWT0pqTU9lajRHNzlabVJZNTliTGtB?=
 =?utf-8?B?SmFSYmtDVkhkMmd6OHhUQXVDZHVyejdoOFpvM2hZRzg2cEd0cVZFTkpMdGRi?=
 =?utf-8?Q?d+8v/vh4htLNgOKvkdFgnWyQF+/FI3aL4XGLI=3D?=
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:SJ0PR11MB6744.namprd11.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(1800799024)(366016)(376014)(7416014)(38070700018); DIR:OUT;
 SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?aVNwRXRSV1hEb0gzTjl1NXE1bGtJbkMyNmh0cDVmVmJvdEVDMjY2eTh3eE9p?=
 =?utf-8?B?WVlnRzhUbnk2NVlFcWZORTZoNWlobWtpWXJCaUJUTGtCWWxOVFpheTBQN2RE?=
 =?utf-8?B?dHZzZ3JBNm5GOTJkQndqMmJzTFgxczdQTG1WVWF1Y01HU2hNZWl3RjVwM2JJ?=
 =?utf-8?B?ejBvNXVnMU1UcXVUM3V1WHRveTlBd2xkSE54SHp2dUVnSk04d24vOEtXZWJI?=
 =?utf-8?B?SUtKZmRMS0ZTdXlCS1lCUlB6dnpPL3Y2YnBsSFlyai92aVBTTjN2T1NtRHBh?=
 =?utf-8?B?WXRxZVNJcGFsQll0VllZRVYwR0NtVlh1Y093REZQcHJ5NnpTbFlnTW5YMWhI?=
 =?utf-8?B?UGpTaHVwdnhwMFBtckxta3lHdkRxazFyYkZtbC9DSk1iNDRieG9adG1sYkZs?=
 =?utf-8?B?MGhjNzZNM0NIUzhneHFPL29iZkFKa0I3VDRwWU0zVlBvTmh4SGJoK0RrMzF6?=
 =?utf-8?B?UzVjc0F0SCtjdlBzRW5LNnpaUVFhRFdTRHRQLzV6c3ZaNE5uRVcyUEdGbk1P?=
 =?utf-8?B?cEJLOFBWRWZqcEtnYnVvMnllakd6cTZVK29BZk9oN0xDdnNyV2sxQzhvaUZx?=
 =?utf-8?B?ZVZXUHhTZitqWklZTkNGZTFiYkNhWTVDU0ZSbkpndTVKbXY3aGdpaGx0SlFF?=
 =?utf-8?B?bUFSQzlac0c4d2hjcHlOanZ2VDdWVnNPeXBwKzVoakpNcTd6Wjk1cTREaU9o?=
 =?utf-8?B?bk1ucGE3eW5rZExSZUlKVGhkbzVJZmhGUXlCbU9GdHR5M3NDZkd5eHFpMUd3?=
 =?utf-8?B?Q1JDbDR4bnQ0T0J5VUdxR3MwcVVOUGtqelVCMDZ5blJDT09ycmo4SGc5V1N2?=
 =?utf-8?B?YUtDSGtteWtKd0ttT29tNHlFbVR2MzdTcE94dlpsNXNYaCtNd0hrTFFCdjVR?=
 =?utf-8?B?UkFwbTZUdzI5NDlHeXZDSzRjaXpwSlBuUDIxc1NMRElGaEswVDArc09IQ3dX?=
 =?utf-8?B?NmRVVTB0UU1rMS9jbDc0eU9LYmJxMEJQa1JSaXB3U245NEdXeG4zV05XS0li?=
 =?utf-8?B?cGhJTHpMRUlVWFdjcGVrZElCcDR4c3lPZlp6aWk2MFp2SEhkOHdzYVdBRWww?=
 =?utf-8?B?M3F3bkd3ZEtxZGxrUHAyVUhoa1J0Q0Q2d2RkS2h0NTljUGp5YXVmb09qdlY2?=
 =?utf-8?B?Z0xNdUdsM3RBRGlUd3VzZXM5V2hobWVLVVAwTkxCN3dlbGU2S1JoL1dpaWF6?=
 =?utf-8?B?YXZGM1k4RE9PR2NrQUp0NDRvVGpFMkxMSDRYbGpoUkhEUmtsSGZRU3VQbzZI?=
 =?utf-8?B?by9KcHlyckQwdTRtRWNmYlM2NzFwTCtXNHpoSHpCcHFrZEpJdTlqSVFUVVIx?=
 =?utf-8?B?L2tOYmxWYzBZZDNTOE01Z3dWUlBXa1pqM3VReFY4blc4V1JHMk8xOHM1SXB0?=
 =?utf-8?B?cldteVFSTlhLMnoza0hKdTN3NkVPQnQwWUx2N3A1SThTQjRnN0ZMWFNwdFNZ?=
 =?utf-8?B?K0o3Vi82blRiOS9OOFdEZ2NBQWZ2WnRyQ01FMDBYMnNCblBvRjVCZnp6WFhw?=
 =?utf-8?B?Q2h3WlYyY1ViOVE2cTh0SHlZcElOdk9aYSt3Q2ppVVhEM3pacy9rYjBINW5z?=
 =?utf-8?B?TmxpSGlJQnMvWDlxc0JoK0RqYm5obFRxOVVpdjVCZnI2YmNib3lzWmRLR0pl?=
 =?utf-8?B?WlFRNjhUQjlTV1RzbHVtV2o2WG5Vdk9CbUxyLzNWZ0FSTHFwQzFJS3NkanlR?=
 =?utf-8?B?Ry82MWJ4dno1bG1FcDNGelloYVpJMHU4bEh3UzVqYURqeUdPWnhFKzhRNHdZ?=
 =?utf-8?B?RUFmQU1MMkhSWnRPY1hsRDBmS3U4SVUxbjVjNHBzcmFtL01PMHVibkRoYUNG?=
 =?utf-8?B?b2o3MU80TjBsamVQc3paMW9pNzVGVkgxdHpENTY3b1l1V1FPOW1zRWFOaE5L?=
 =?utf-8?B?WDBsNHZ3S0RyTHRlMklxa1lZMFBnWnAyZWZsRTRJempTNytOTk1jUXVtYkZU?=
 =?utf-8?B?dDFEc1FMdTEzbkZDZysxYnkwM0g0dmpCVHhmMUhidlUxdFBldHNKbGtOU2pj?=
 =?utf-8?B?Y2p0bkZHLzZiUWh5K1ViQ1JvMjQ2RExDVnVnN3pMdWh0aHgwbjNTQlpDNjN2?=
 =?utf-8?B?ZkMxTCtnZzFJR29HeGF5QXd3T1JYUFZVa2Q5SzM2bGJUbE1BR0c2VHZMZGxF?=
 =?utf-8?Q?hKHTzX01RYndZmMisy2A/sR/f?=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: SJ0PR11MB6744.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: b7661414-41cd-4562-24d5-08dcfd479015
X-MS-Exchange-CrossTenant-originalarrivaltime: 05 Nov 2024 03:11:38.1103 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: A7nYxXVI5u+F0MiJlj8G1qXkAxV9jqrEn5c0T5Hd2SKeGDY3m0mJOcCb83PSLK8m8L2WZQAlZYLK8+SRdWRTFFceKEWLbEoyLsZD1tq8MKQ=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MW5PR11MB5857
X-OriginatorOrg: intel.com
Received-SPF: pass client-ip=192.198.163.8;
 envelope-from=zhenzhong.duan@intel.com; helo=mgamail.intel.com
X-Spam_score_int: -46
X-Spam_score: -4.7
X-Spam_bar: ----
X-Spam_report: (-4.7 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.34,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_MED=-2.3, RCVD_IN_MSPIKE_H2=-0.001,
 RCVD_IN_VALIDITY_CERTIFIED_BLOCKED=0.001, RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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

DQoNCj4tLS0tLU9yaWdpbmFsIE1lc3NhZ2UtLS0tLQ0KPkZyb206IExpdSwgWWkgTCA8eWkubC5s
aXVAaW50ZWwuY29tPg0KPlNlbnQ6IE1vbmRheSwgTm92ZW1iZXIgNCwgMjAyNCAzOjIzIFBNDQo+
U3ViamVjdDogUmU6IFtQQVRDSCB2NCAxNS8xN10gaW50ZWxfaW9tbXU6IEludHJvZHVjZSBhIHBy
b3BlcnR5IHgtZmxzIGZvcg0KPnNjYWxhYmxlIG1vZGVybiBtb2RlDQo+DQo+T24gMjAyNC8xMS80
IDE0OjI1LCBEdWFuLCBaaGVuemhvbmcgd3JvdGU6DQo+Pg0KPj4NCj4+PiAtLS0tLU9yaWdpbmFs
IE1lc3NhZ2UtLS0tLQ0KPj4+IEZyb206IExpdSwgWWkgTCA8eWkubC5saXVAaW50ZWwuY29tPg0K
Pj4+IFNlbnQ6IE1vbmRheSwgTm92ZW1iZXIgNCwgMjAyNCAxMjoyNSBQTQ0KPj4+IFN1YmplY3Q6
IFJlOiBbUEFUQ0ggdjQgMTUvMTddIGludGVsX2lvbW11OiBJbnRyb2R1Y2UgYSBwcm9wZXJ0eSB4
LWZscyBmb3INCj4+PiBzY2FsYWJsZSBtb2Rlcm4gbW9kZQ0KPj4+DQo+Pj4gT24gMjAyNC85LzMw
IDE3OjI2LCBaaGVuemhvbmcgRHVhbiB3cm90ZToNCj4+Pj4gSW50ZWwgVlQtZCAzLjAgaW50cm9k
dWNlcyBzY2FsYWJsZSBtb2RlLCBhbmQgaXQgaGFzIGEgYnVuY2ggb2YgY2FwYWJpbGl0aWVzDQo+
Pj4+IHJlbGF0ZWQgdG8gc2NhbGFibGUgbW9kZSB0cmFuc2xhdGlvbiwgdGh1cyB0aGVyZSBhcmUg
bXVsdGlwbGUgY29tYmluYXRpb25zLg0KPj4+Pg0KPj4+PiBUaGlzIHZJT01NVSBpbXBsZW1lbnRh
dGlvbiB3YW50cyB0byBzaW1wbGlmeSBpdCB3aXRoIGEgbmV3IHByb3BlcnR5ICJ4LWZscyIuDQo+
Pj4+IFdoZW4gZW5hYmxlZCBpbiBzY2FsYWJsZSBtb2RlLCBmaXJzdCBzdGFnZSB0cmFuc2xhdGlv
biBhbHNvIGtub3duIGFzDQo+c2NhbGFibGUNCj4+Pj4gbW9kZXJuIG1vZGUgaXMgc3VwcG9ydGVk
LiBXaGVuIGVuYWJsZWQgaW4gbGVnYWN5IG1vZGUsIHRocm93IG91dCBlcnJvci4NCj4+Pj4NCj4+
Pj4gV2l0aCBzY2FsYWJsZSBtb2Rlcm4gbW9kZSBleHBvc2VkIHRvIHVzZXIsIGFsc28gYWNjdXJh
dGUgdGhlIHBhc2lkIGVudHJ5DQo+Pj4+IGNoZWNrIGluIHZ0ZF9wZV90eXBlX2NoZWNrKCkuDQo+
Pj4+DQo+Pj4+IFNpZ25lZC1vZmYtYnk6IFlpIExpdSA8eWkubC5saXVAaW50ZWwuY29tPg0KPj4+
PiBTaWduZWQtb2ZmLWJ5OiBZaSBTdW4gPHlpLnkuc3VuQGxpbnV4LmludGVsLmNvbT4NCj4+Pj4g
U2lnbmVkLW9mZi1ieTogWmhlbnpob25nIER1YW4gPHpoZW56aG9uZy5kdWFuQGludGVsLmNvbT4N
Cj4+Pg0KPj4+IE1heWJlIGEgU3VnZ2VzdGVkLWJ5IHRhZyBjYW4gaGVscCB0byB1bmRlcnN0YW5k
IHdoZXJlIHRoaXMgaWRlYSBjb21lcy4gOikNCj4+DQo+PiBXaWxsIGFkZDoNCj4+IFN1Z2dlc3Rl
ZC1ieTogSmFzb24gV2FuZyA8amFzb3dhbmdAcmVkaGF0LmNvbT4NCj4+DQo+Pj4NCj4+Pj4gLS0t
DQo+Pj4+ICAgIGh3L2kzODYvaW50ZWxfaW9tbXVfaW50ZXJuYWwuaCB8ICAyICsrDQo+Pj4+ICAg
IGh3L2kzODYvaW50ZWxfaW9tbXUuYyAgICAgICAgICB8IDI4ICsrKysrKysrKysrKysrKysrKyst
LS0tLS0tLS0NCj4+Pj4gICAgMiBmaWxlcyBjaGFuZ2VkLCAyMSBpbnNlcnRpb25zKCspLCA5IGRl
bGV0aW9ucygtKQ0KPj4+Pg0KPj4+PiBkaWZmIC0tZ2l0IGEvaHcvaTM4Ni9pbnRlbF9pb21tdV9p
bnRlcm5hbC5oDQo+Yi9ody9pMzg2L2ludGVsX2lvbW11X2ludGVybmFsLmgNCj4+Pj4gaW5kZXgg
MjcwMmVkZDI3Zi4uZjEzNTc2ZDMzNCAxMDA2NDQNCj4+Pj4gLS0tIGEvaHcvaTM4Ni9pbnRlbF9p
b21tdV9pbnRlcm5hbC5oDQo+Pj4+ICsrKyBiL2h3L2kzODYvaW50ZWxfaW9tbXVfaW50ZXJuYWwu
aA0KPj4+PiBAQCAtMTk1LDYgKzE5NSw3IEBADQo+Pj4+ICAgICNkZWZpbmUgVlREX0VDQVBfUEFT
SUQgICAgICAgICAgICAgICgxVUxMIDw8IDQwKQ0KPj4+PiAgICAjZGVmaW5lIFZURF9FQ0FQX1NN
VFMgICAgICAgICAgICAgICAoMVVMTCA8PCA0MykNCj4+Pj4gICAgI2RlZmluZSBWVERfRUNBUF9T
TFRTICAgICAgICAgICAgICAgKDFVTEwgPDwgNDYpDQo+Pj4+ICsjZGVmaW5lIFZURF9FQ0FQX0ZM
VFMgICAgICAgICAgICAgICAoMVVMTCA8PCA0NykNCj4+Pj4NCj4+Pj4gICAgLyogQ0FQX1JFRyAq
Lw0KPj4+PiAgICAvKiAob2Zmc2V0ID4+IDQpIDw8IDI0ICovDQo+Pj4+IEBAIC0yMTEsNiArMjEy
LDcgQEANCj4+Pj4gICAgI2RlZmluZSBWVERfQ0FQX1NMTFBTICAgICAgICAgICAgICAgKCgxVUxM
IDw8IDM0KSB8ICgxVUxMIDw8IDM1KSkNCj4+Pj4gICAgI2RlZmluZSBWVERfQ0FQX0RSQUlOX1dS
SVRFICAgICAgICAgKDFVTEwgPDwgNTQpDQo+Pj4+ICAgICNkZWZpbmUgVlREX0NBUF9EUkFJTl9S
RUFEICAgICAgICAgICgxVUxMIDw8IDU1KQ0KPj4+PiArI2RlZmluZSBWVERfQ0FQX0ZTMUdQICAg
ICAgICAgICAgICAgKDFVTEwgPDwgNTYpDQo+Pj4+ICAgICNkZWZpbmUgVlREX0NBUF9EUkFJTiAg
ICAgICAgICAgICAgIChWVERfQ0FQX0RSQUlOX1JFQUQgfA0KPj4+IFZURF9DQVBfRFJBSU5fV1JJ
VEUpDQo+Pj4+ICAgICNkZWZpbmUgVlREX0NBUF9DTSAgICAgICAgICAgICAgICAgICgxVUxMIDw8
IDcpDQo+Pj4+ICAgICNkZWZpbmUgVlREX1BBU0lEX0lEX1NISUZUICAgICAgICAgIDIwDQo+Pj4+
IGRpZmYgLS1naXQgYS9ody9pMzg2L2ludGVsX2lvbW11LmMgYi9ody9pMzg2L2ludGVsX2lvbW11
LmMNCj4+Pj4gaW5kZXggMDY4YTA4ZjUyMi4uMTQ1Nzg2NTVlMSAxMDA2NDQNCj4+Pj4gLS0tIGEv
aHcvaTM4Ni9pbnRlbF9pb21tdS5jDQo+Pj4+ICsrKyBiL2h3L2kzODYvaW50ZWxfaW9tbXUuYw0K
Pj4+PiBAQCAtODAzLDE2ICs4MDMsMTggQEAgc3RhdGljIGlubGluZSBib29sDQo+Pj4gdnRkX2lz
X2ZsX2xldmVsX3N1cHBvcnRlZChJbnRlbElPTU1VU3RhdGUgKnMsIHVpbnQzMl90IGxldmVsKQ0K
Pj4+PiAgICB9DQo+Pj4+DQo+Pj4+ICAgIC8qIFJldHVybiB0cnVlIGlmIGNoZWNrIHBhc3NlZCwg
b3RoZXJ3aXNlIGZhbHNlICovDQo+Pj4+IC1zdGF0aWMgaW5saW5lIGJvb2wgdnRkX3BlX3R5cGVf
Y2hlY2soWDg2SU9NTVVTdGF0ZSAqeDg2X2lvbW11LA0KPj4+PiAtICAgICAgICAgICAgICAgICAg
ICAgICAgICAgICAgICAgICAgIFZURFBBU0lERW50cnkgKnBlKQ0KPj4+PiArc3RhdGljIGlubGlu
ZSBib29sIHZ0ZF9wZV90eXBlX2NoZWNrKEludGVsSU9NTVVTdGF0ZSAqcywgVlREUEFTSURFbnRy
eQ0KPipwZSkNCj4+Pj4gICAgew0KPj4+PiAgICAgICAgc3dpdGNoIChWVERfUEVfR0VUX1RZUEUo
cGUpKSB7DQo+Pj4+IC0gICAgY2FzZSBWVERfU01fUEFTSURfRU5UUllfU0xUOg0KPj4+PiAtICAg
ICAgICByZXR1cm4gdHJ1ZTsNCj4+Pj4gLSAgICBjYXNlIFZURF9TTV9QQVNJRF9FTlRSWV9QVDoN
Cj4+Pj4gLSAgICAgICAgcmV0dXJuIHg4Nl9pb21tdS0+cHRfc3VwcG9ydGVkOw0KPj4+PiAgICAg
ICAgY2FzZSBWVERfU01fUEFTSURfRU5UUllfRkxUOg0KPj4+PiArICAgICAgICByZXR1cm4gISEo
cy0+ZWNhcCAmIFZURF9FQ0FQX0ZMVFMpOw0KPj4+PiArICAgIGNhc2UgVlREX1NNX1BBU0lEX0VO
VFJZX1NMVDoNCj4+Pj4gKyAgICAgICAgcmV0dXJuICEhKHMtPmVjYXAgJiBWVERfRUNBUF9TTFRT
KTsNCj4+Pj4gICAgICAgIGNhc2UgVlREX1NNX1BBU0lEX0VOVFJZX05FU1RFRDoNCj4+Pj4gKyAg
ICAgICAgLyogTm90IHN1cHBvcnQgTkVTVEVEIHBhZ2UgdGFibGUgdHlwZSB5ZXQgKi8NCj4+Pj4g
KyAgICAgICAgcmV0dXJuIGZhbHNlOw0KPj4+PiArICAgIGNhc2UgVlREX1NNX1BBU0lEX0VOVFJZ
X1BUOg0KPj4+PiArICAgICAgICByZXR1cm4gISEocy0+ZWNhcCAmIFZURF9FQ0FQX1BUKTsNCj4+
Pj4gICAgICAgIGRlZmF1bHQ6DQo+Pj4+ICAgICAgICAgICAgLyogVW5rbm93biB0eXBlICovDQo+
Pj4+ICAgICAgICAgICAgcmV0dXJuIGZhbHNlOw0KPj4+PiBAQCAtODYxLDcgKzg2Myw2IEBAIHN0
YXRpYyBpbnQNCj4+PiB2dGRfZ2V0X3BlX2luX3Bhc2lkX2xlYWZfdGFibGUoSW50ZWxJT01NVVN0
YXRlICpzLA0KPj4+PiAgICAgICAgdWludDhfdCBwZ3R0Ow0KPj4+PiAgICAgICAgdWludDMyX3Qg
aW5kZXg7DQo+Pj4+ICAgICAgICBkbWFfYWRkcl90IGVudHJ5X3NpemU7DQo+Pj4+IC0gICAgWDg2
SU9NTVVTdGF0ZSAqeDg2X2lvbW11ID0gWDg2X0lPTU1VX0RFVklDRShzKTsNCj4+Pj4NCj4+Pj4g
ICAgICAgIGluZGV4ID0gVlREX1BBU0lEX1RBQkxFX0lOREVYKHBhc2lkKTsNCj4+Pj4gICAgICAg
IGVudHJ5X3NpemUgPSBWVERfUEFTSURfRU5UUllfU0laRTsNCj4+Pj4gQEAgLTg3NSw3ICs4NzYs
NyBAQCBzdGF0aWMgaW50DQo+Pj4gdnRkX2dldF9wZV9pbl9wYXNpZF9sZWFmX3RhYmxlKEludGVs
SU9NTVVTdGF0ZSAqcywNCj4+Pj4gICAgICAgIH0NCj4+Pj4NCj4+Pj4gICAgICAgIC8qIERvIHRy
YW5zbGF0aW9uIHR5cGUgY2hlY2sgKi8NCj4+Pj4gLSAgICBpZiAoIXZ0ZF9wZV90eXBlX2NoZWNr
KHg4Nl9pb21tdSwgcGUpKSB7DQo+Pj4+ICsgICAgaWYgKCF2dGRfcGVfdHlwZV9jaGVjayhzLCBw
ZSkpIHsNCj4+Pj4gICAgICAgICAgICByZXR1cm4gLVZURF9GUl9QQVNJRF9UQUJMRV9FTlRSWV9J
TlY7DQo+Pj4+ICAgICAgICB9DQo+Pj4+DQo+Pj4+IEBAIC0zNzc5LDYgKzM3ODAsNyBAQCBzdGF0
aWMgUHJvcGVydHkgdnRkX3Byb3BlcnRpZXNbXSA9IHsNCj4+Pj4gICAgICAgICAgICAgICAgICAg
ICAgICAgIFZURF9IT1NUX0FXX0FVVE8pLA0KPj4+PiAgICAgICAgREVGSU5FX1BST1BfQk9PTCgi
Y2FjaGluZy1tb2RlIiwgSW50ZWxJT01NVVN0YXRlLCBjYWNoaW5nX21vZGUsDQo+Pj4gRkFMU0Up
LA0KPj4+PiAgICAgICAgREVGSU5FX1BST1BfQk9PTCgieC1zY2FsYWJsZS1tb2RlIiwgSW50ZWxJ
T01NVVN0YXRlLA0KPnNjYWxhYmxlX21vZGUsDQo+Pj4gRkFMU0UpLA0KPj4+PiArICAgIERFRklO
RV9QUk9QX0JPT0woIngtZmxzIiwgSW50ZWxJT01NVVN0YXRlLCBzY2FsYWJsZV9tb2Rlcm4sIEZB
TFNFKSwNCj4+Pj4gICAgICAgIERFRklORV9QUk9QX0JPT0woInNub29wLWNvbnRyb2wiLCBJbnRl
bElPTU1VU3RhdGUsIHNub29wX2NvbnRyb2wsDQo+Pj4gZmFsc2UpLA0KPj4+DQo+Pj4gYSBxdWVz
dGlvbjogaXMgdGhlcmUgYW55IHJlcXVpcmVtZW50IG9uIHRoZSBsYXlvdXQgb2YgdGhpcyBhcnJh
eT8gU2hvdWxkDQo+Pj4gbmV3IGZpZWxkcyBhZGRlZCBpbiB0aGUgZW5kPw0KPj4NCj4+IExvb2tl
ZCBvdmVyIHRoZSBoaXN0b3J5LCBzZWVtcyB3ZSBkaWRuJ3QgaGF2ZSBhbiBleHBsaWNpdCBydWxl
IGluIHZ0ZF9wcm9wZXJ0aWVzLg0KPj4gSSBwdXQgIngtZmxzIiBqdXN0IHVuZGVyICJ4LXNjYWxh
YmxlLW1vZGUiIGFzIHN0YWdlLTEgaXMgYSBzdWItZmVhdHVyZSBvZiBzY2FsYWJsZQ0KPm1vZGUu
DQo+PiBMZXQgbWUga25vdyBpZiB5b3UgaGF2ZSBwcmVmZXJlbmNlIHRvIGFkZCBpbiB0aGUgZW5k
Lg0KPg0KPkkgZG9uJ3QgaGF2ZSBhIHByZWZlcmVuY2UgZm9yIG5vdyBhcyBsb25nIGFzIGl0IGRv
ZXMgbm90IGJyZWFrIGFueQ0KPmZ1bmN0aW9uYWxpdHkuIEJUVy4gV2lsbCB4LWZsdCBvciB4LWZs
dHMgYmV0dGVyPw0KDQpTbyBmaXJzdCBsZXZlbCBzdXBwb3J0KGZscykgdnMuIGZpcnN0IGxldmVs
IHRyYW5zbGF0aW9uKGZsdCkgb3IgZmlyc3QgbGV2ZWwgdHJhbnNsYXRpb24gc3VwcG9ydChmbHRz
KSwNCmxvb2tzIHNhbWUgZm9yIG1lLCBidXQgSSBjYW4gY2hhbmdlIHRvIHgtZmx0IG9yIHgtZmx0
cyBpZiB5b3UgcHJlZmVyLg0KDQpUaGFua3MNClpoZW56aG9uZw0K

