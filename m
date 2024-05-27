Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6E942C25B7A
	for <qemu-devel@archiver.kernel.org>; Mon, 27 May 2024 03:17:40 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sBQrE-0008NK-1o; Sun, 26 May 2024 23:17:08 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <zhenzhong.duan@intel.com>)
 id 1sBQrC-0008N5-DL
 for qemu-devel@nongnu.org; Sun, 26 May 2024 23:17:06 -0400
Received: from mgamail.intel.com ([192.198.163.7])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <zhenzhong.duan@intel.com>)
 id 1sBQr9-0004mh-Ns
 for qemu-devel@nongnu.org; Sun, 26 May 2024 23:17:06 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1716779824; x=1748315824;
 h=from:to:cc:subject:date:message-id:references:
 in-reply-to:content-transfer-encoding:mime-version;
 bh=dovuWRR1DBibkdpUsXUuOCxPtH5RnJdMSuAGZsZCo+Q=;
 b=QdeAh3nxl282FrJwsaZjlbyxgwAMqRk43PVe6D+GAI0bK8IyX4iqcRvG
 HbQpZmstc7VDuOaHeeQH9gDjC7cznjl/aHTWZeKnWVJyuTuxBEjNfP1P2
 /9JL3xVtCXXirK2Ru/GMHIM3HNqe0ivVtaRuHm/THL96rpc03t4wxRqdq
 JPj9yMXnUCfXGbmML82jHv906Qzu6K74LWAtceuEX4wmyVWa7PGy6IptM
 QxxdZ/ULHuvZUHDF7LH90vlIrXhrgolf/IoH1hemQmCJlZjH/49ayU/hO
 zt6xl4I/K3iCX22JOt0z2IO1JKVygALQwx0fRJDM2V2QxhWgn01qZYKMk w==;
X-CSE-ConnectionGUID: WcyRyerzQja5oBfqdwB7aw==
X-CSE-MsgGUID: Ly0NVDnnSviKG4/0o2HWTg==
X-IronPort-AV: E=McAfee;i="6600,9927,11084"; a="38462888"
X-IronPort-AV: E=Sophos;i="6.08,191,1712646000"; d="scan'208";a="38462888"
Received: from orviesa006.jf.intel.com ([10.64.159.146])
 by fmvoesa101.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 26 May 2024 20:17:00 -0700
X-CSE-ConnectionGUID: U+HjjkFCQBeqYlUWpNx93w==
X-CSE-MsgGUID: 5DaaGodeROSD5AWa4I1FJg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.08,191,1712646000"; d="scan'208";a="35113101"
Received: from orsmsx602.amr.corp.intel.com ([10.22.229.15])
 by orviesa006.jf.intel.com with ESMTP/TLS/AES256-GCM-SHA384;
 26 May 2024 20:17:00 -0700
Received: from orsmsx611.amr.corp.intel.com (10.22.229.24) by
 ORSMSX602.amr.corp.intel.com (10.22.229.15) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.39; Sun, 26 May 2024 20:16:59 -0700
Received: from orsmsx610.amr.corp.intel.com (10.22.229.23) by
 ORSMSX611.amr.corp.intel.com (10.22.229.24) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.39; Sun, 26 May 2024 20:16:59 -0700
Received: from ORSEDG602.ED.cps.intel.com (10.7.248.7) by
 orsmsx610.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.39 via Frontend Transport; Sun, 26 May 2024 20:16:59 -0700
Received: from NAM04-BN8-obe.outbound.protection.outlook.com (104.47.74.40) by
 edgegateway.intel.com (134.134.137.103) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.39; Sun, 26 May 2024 20:16:59 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=VPpfXssJn5Iswu/DD98Pc5t3qmaYj1D21Enr/d1sAYn0qL0WWy4hhxXtzb54ThZtuaWGx1EceI4iLdFdaOLSdpcxZn4ZAymlneHoiJIMvQiJqQQlTHDXoYtaBmovoB8kYz4hZvcGRmmBrZrL4Zr7Hn6ogy6Gtq/t5p+UcmxGUq5KlTavMvcGjrXqRILOr/InwTn7dSiQ9sMnWbRxD0/kZplrNIoexURCz1GFgC/RkZd5DttHx6h+qHfO5bz84amfgnb8QfLqdMGY4mtC1BEWNn3/Ig6XgqUr0JPxnZZqJIh/PAo1WQY/nTDGnSTJzqccspQ1OfiSFPUP9H9HgRUmHA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=dovuWRR1DBibkdpUsXUuOCxPtH5RnJdMSuAGZsZCo+Q=;
 b=UhuX741nRV48ISyxymiaatN3XvSTILwmU7X0t0lauyiUogJPPl+h7TrQXrXPGvSZT3/ah9r7NrCrf5dEM28SheLyHFwH8ywMXup2WM9HfZTRrk41hYirBlbJrL9CMkPqeIkYnnwnunwhAxJaSwVFl9gC6pnYqH1DRqL7XCfCdbPVjlJ0onAj5kEeP7PO4M0sNNFbt43jMiYY9HqH3uNtz+kMKhba16r0cArsMfGWuNU+tLvs4Jo++xuStE1tS73thXFWKw6CBBribl+2d1WkIVM4dnSiROxB8n33PzPJnvejFvkZsKC/UqsZwXnVxb46cGuAYVaOk6+vh5nhoXIV1g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Received: from SJ0PR11MB6744.namprd11.prod.outlook.com (2603:10b6:a03:47d::10)
 by PH8PR11MB6754.namprd11.prod.outlook.com (2603:10b6:510:1c9::6)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7611.29; Mon, 27 May
 2024 03:16:56 +0000
Received: from SJ0PR11MB6744.namprd11.prod.outlook.com
 ([fe80::fe49:d628:48b1:6091]) by SJ0PR11MB6744.namprd11.prod.outlook.com
 ([fe80::fe49:d628:48b1:6091%7]) with mapi id 15.20.7611.025; Mon, 27 May 2024
 03:16:56 +0000
From: "Duan, Zhenzhong" <zhenzhong.duan@intel.com>
To: CLEMENT MATHIEU--DRIF <clement.mathieu--drif@eviden.com>,
 "qemu-devel@nongnu.org" <qemu-devel@nongnu.org>
CC: "alex.williamson@redhat.com" <alex.williamson@redhat.com>,
 "clg@redhat.com" <clg@redhat.com>, "eric.auger@redhat.com"
 <eric.auger@redhat.com>, "mst@redhat.com" <mst@redhat.com>,
 "peterx@redhat.com" <peterx@redhat.com>, "jasowang@redhat.com"
 <jasowang@redhat.com>, "jgg@nvidia.com" <jgg@nvidia.com>,
 "nicolinc@nvidia.com" <nicolinc@nvidia.com>, "joao.m.martins@oracle.com"
 <joao.m.martins@oracle.com>, "Tian, Kevin" <kevin.tian@intel.com>, "Liu, Yi
 L" <yi.l.liu@intel.com>, "Peng, Chao P" <chao.p.peng@intel.com>, "Paolo
 Bonzini" <pbonzini@redhat.com>, Richard Henderson
 <richard.henderson@linaro.org>, Eduardo Habkost <eduardo@habkost.net>,
 "Marcel Apfelbaum" <marcel.apfelbaum@gmail.com>
Subject: RE: [PATCH rfcv2 15/17] intel_iommu: Set default aw_bits to 48 in
 scalable modren mode
Thread-Topic: [PATCH rfcv2 15/17] intel_iommu: Set default aw_bits to 48 in
 scalable modren mode
Thread-Index: AQHarBEV7fzcj969MkGY/4SYZ11o5LGmbFMAgAPrKfA=
Date: Mon, 27 May 2024 03:16:56 +0000
Message-ID: <SJ0PR11MB6744454F40A7E7E56967E2F092F02@SJ0PR11MB6744.namprd11.prod.outlook.com>
References: <20240522062313.453317-1-zhenzhong.duan@intel.com>
 <20240522062313.453317-16-zhenzhong.duan@intel.com>
 <f80e5a23-5006-4fd6-8bd4-60a114c316e8@eviden.com>
In-Reply-To: <f80e5a23-5006-4fd6-8bd4-60a114c316e8@eviden.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: SJ0PR11MB6744:EE_|PH8PR11MB6754:EE_
x-ms-office365-filtering-correlation-id: 45ad6ef1-f0c8-40d3-7d63-08dc7dfb76fb
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
 ARA:13230031|366007|1800799015|376005|7416005|38070700009; 
x-microsoft-antispam-message-info: =?utf-8?B?VGpMRnVvcGIrdVZ2Mmg3N3NORWl5cGh2UG1XZ3ZkSVVSbzE1MEhNTFVNa3M4?=
 =?utf-8?B?MjN5RHBPZ1ZUZ3FiZFJwVG9qUWUzZ3pETzBhcTJyT3ZZTlgxbm9lS3kvMm5J?=
 =?utf-8?B?ekU1VFNrYzI1MXVzZkhvMWt3eWZ2dDRETXN5VCtWRzdPeG13OVEvM0FyYmFK?=
 =?utf-8?B?Y2RVNnRON0M1Y2x2SVJTR0hnVUtMUUczblRydHNIT3A5Q1VleGRmVWdaVUFi?=
 =?utf-8?B?NU11SDdydXFQN01VNGRVR0JUUXU2bWNaMzlGeXlqcWtCZFpVcGVmbUFYL3Yw?=
 =?utf-8?B?dVdsaG9haXlYV05DNkhHSThoSFlkN2hHb3p3M0JiRGdYYmJNbmt5UkdTMXZV?=
 =?utf-8?B?UUQ2UnJKSFBMWGxsRjRMSWNlK1ArUWZEWVdXMnNSNW1PemhyZEd5b2RXc2V0?=
 =?utf-8?B?TnNSUzRoZWQxZkg0UWxPbU5wYndHaWd0MXlVb2g1ZFRVT1A5NWxDU1Nha2tH?=
 =?utf-8?B?ZGphbk00bzQyN2JEZ0pCUmFqcnZVS0dtaDhjbmlSUEdPbExXUVdkOFlCcXlx?=
 =?utf-8?B?M3NZSHQ2WnBDSENkSENxOC9teEo1T0tjY295enRtUGppemNYd2hxeDFWdHVJ?=
 =?utf-8?B?cUl0Y3JycE5pU0hJVExkWk9MTzFRSEdGQ0h4b0wxMnR0cEJBN04xa0h2OUc1?=
 =?utf-8?B?Y01QZENuRTNWVlIxMDZNRThvVW5xRngrcWZZczZxOWt1K08yZmxUOTY4aldO?=
 =?utf-8?B?ZkJDVUpSV2xlR0pKblBxdEtFZVkxSW41T2dzYzBBY0J5NVU4QzlXaG5FU1Q4?=
 =?utf-8?B?SXN5a0pFNnRSME1jcjlNaG5lMGtWRktIVWhCUDhXSmVOQjJiRUVNeE9MVWZX?=
 =?utf-8?B?dXNQOEJka3Nxa2VuU1dIRzEvejZ0OGtwVzhGSE4rKy96SXRoTUtjMEM2ZjEz?=
 =?utf-8?B?ajcweXFwVk5mTXNJZXE5RGJOeGNvTTM5aG52ZG5DcmlBTmRkU0EyYUZVQnFn?=
 =?utf-8?B?dzNQakN2NWplcWpPK1BuUFM0TUhCUW8xSXYzZmJzdmxER0R1UjB2cXpKL0di?=
 =?utf-8?B?SnprT1VXYzhtNFEwYkNyZjRvSTIxVUN4Y3RvNGF5SFY5OGdUU1pteGdEMGtz?=
 =?utf-8?B?VkFWNUppa3Q2YXczQVkzNHRIUVdlN0t4eEluSy9uY0FlL1QrbDJwdzBwUnYx?=
 =?utf-8?B?QnQrb01FczBrV0VYazRINU5IbjNUV2pqdE80V2FDZERiQURhTlNOQjdZUjZY?=
 =?utf-8?B?aGZpVjExUzdZTjhXMGxiQlBIemJJcDVjM3ZZdjJwV3I1NjljMlM1Wi81Uks3?=
 =?utf-8?B?clNMUXhlNEZsNUpxUlZmaG0wQmxhNjgyUTRjWENLMnhFZUpGYkpBam9VMkdN?=
 =?utf-8?B?UWh5WTRqeVBySTN4MWR0SEJwWC9YSTBCWlZ5RCswcWJSd0QxREJ5TlRNbHhR?=
 =?utf-8?B?Nk0zbVhvQWR6cFJlQnlpeGQ0WWduZy8rY1BPZGg4Uk9NVlpZWU11U1Njek14?=
 =?utf-8?B?bnBtSG5rZFNTekJ1Qk1DclFRTVRROWZuV2ZJNG1zM1gvWG5hSmNUbW53cDVr?=
 =?utf-8?B?WVUzaEFDdmJzTjhOOTFnUUJnT0ZDNHNSY0NFTndKYjgrS3N5ZUVaWTU2TmlO?=
 =?utf-8?B?Uk8yVThiN2V6bS96N05KOTR4VFdOd215cG1SYmJMUzFoV1c1cHFxYjQ2N2FN?=
 =?utf-8?B?ODBYNDhNbFFIcEZLVGlIblZ1Q2h5bnZSek91RzBEcDdDQXo3RlpXMHhwN2hV?=
 =?utf-8?B?U1ByeFZkRXVQNHkvbUU1R0c5SEdXS040cWhUb2V6eVQ4YnhUMW9pSEdjZU9S?=
 =?utf-8?B?Ni9SUGJ0UU5zNTlucU1ZRnQ5RmhtTkEvQXUxd01mS1FCTEVVYzFTM1ZpblJ4?=
 =?utf-8?B?OHVaaUd4Q1pEdVhMMFROZz09?=
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:SJ0PR11MB6744.namprd11.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230031)(366007)(1800799015)(376005)(7416005)(38070700009); DIR:OUT;
 SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?RDNadWlrTWg5eFJRZVJoQ3oxUElGb29ROEZ3SEwyOW9WdkFSNGJ2TktvRjN3?=
 =?utf-8?B?YnpRdnB2bEdVYU1HNTl3OU02WEI5Qk9qc0ZPa3BqblNSL05IRll2VlhpZzF4?=
 =?utf-8?B?SWdleWJYSWg4TE4wQVkxa3VHaE9jOWJXL3VHZmRHVzFiM1hGY2hpMEhzVTNY?=
 =?utf-8?B?WWlnV292d1NnNU5rQ1pZcHc0U3BUaW41L3F6ejREL2lwc1FMRU1waVNTWVg1?=
 =?utf-8?B?dEV3QnBvZmIyWXV6T0YxanphT21hb1BieHN2SGt6ZUFURUVtS0tOaVhDc0NW?=
 =?utf-8?B?UmI0NVpvczhnanYyYW5WTHRkZzI2dm42dDJlT0h0RG1MRjFzRXdydWNzcU8x?=
 =?utf-8?B?M2xYVENwNHl0akhYM3ZJbFNGQ3NrWkc2cEtGeVBlVWROQU1NMC8rTXdFTENl?=
 =?utf-8?B?VE9pWnIzSTQrNnRydGt5ODBoeDJGbFpESVV0UmpqZlhIdmRsUnJlbm1sMmFv?=
 =?utf-8?B?NDVER0VaQzZRd0dpNEdPSUwyZFIvQ3krd3NNZGt3dHBEREg3REFsS25OQllk?=
 =?utf-8?B?R09yVFB2dWgxU1I5Ujdxck5yQ0J0Ri9TcS8vbjgxVlFpd3ppRDR2NnhpQVdD?=
 =?utf-8?B?a1hja01HU1hwbTV1Nk9tTjlYMjJJcUthbStpUHo1SUJ4ME9vUHo3WUxPK2FC?=
 =?utf-8?B?WXJrbVYxZi9WSzFaOEJFOXQ1SWRoN2tOUnI4SjJkZjd4ZHpBa1MwZ2hiS2dk?=
 =?utf-8?B?ekMwa3FhWVlXbFdjUkp2ZEdlanR0VFNPZGZVRmVRUW1IUWNmRjBPbUVsYnpG?=
 =?utf-8?B?eTJ0Y2RzM0tGN3U0dzI5TWNLV1JkZEtvY3NQeGlSd0xIbHNNb2VTbEp2STNV?=
 =?utf-8?B?UWc4QkpYWm1xMGlOYlRrK0lVcnNKUXNTTUd3aG42YlhwWDJEQWJSN3FuYkwy?=
 =?utf-8?B?WS9CdDVibHdONmU5TVpXanFqc0tNNzdUMTVIUmRpZUUyNU5IclBYbmRLQmc1?=
 =?utf-8?B?b2ptZjhqNG1HcHdhSEhoc1dHR2hBZ3o5NmJPT09Fc3NlOFpRZll4MEJBOUpJ?=
 =?utf-8?B?eHVLNWNkWkJxb2tMeXZHRjJ0dGFxTmliNXJqZE43ak1jSUxUQisySGFTNkdz?=
 =?utf-8?B?eXJKcEJDRmF1U3RXWGQwcHVhQmZaVkZQUnZyblpBR3FZWUJQOEVVZlBBY0Y1?=
 =?utf-8?B?c3o0SFJoT08ySXNYNnAvYVM4S3FlcTNEdVBHWnY0c2hlWHc2OGx5alE1WHdr?=
 =?utf-8?B?UWF3ajJ4eHA2TFd5YTFXeEltOU9hQVBNZGtzcm4zSkZaeER2SlBqSnQ4TUF3?=
 =?utf-8?B?S2hCR0tmbTkvY21RaVpmL3hTZXpxQTFYVjFwRkRHTEZBeDQ4TzhzWmxnaGE3?=
 =?utf-8?B?MkloUWdCWE85YWF3SDJnN1dtN1d6SUlTQmdtajZNR01DQysxM3lCaWRSMHIr?=
 =?utf-8?B?T0xyL29sZWlmeGVXNFVETEVnc1Z2ajdackRnV21xY2RmM3NFOU5YOXM0OTFK?=
 =?utf-8?B?Q1hjRXRDaFNjbTM1ajAyLzVjVWQwSk9NeXcvRDF1L1ZFZ25pUmRWN1dkMitW?=
 =?utf-8?B?Nk9LTlVha2VPZG5WWkNIUkd5TjRUU1pSaStlaUVJREZMSTU2eEdQU29QVzRO?=
 =?utf-8?B?bjVwMmRKYlBnMGN6TjNuVG1hTG9abU11NHdMTU8rWldCVWNuNlBoUFZjSzJV?=
 =?utf-8?B?UXdxSlNmSmpiTHYxZVRtbWtsazM2MUVaZ2hrOC81ZVNXc2lkNWNwVDFWZHRM?=
 =?utf-8?B?cXYwMjE1YkpFNEdwbm1DTExDM28zSktiWDNPa3BKRzQzeG9yVUdJTlE0bG15?=
 =?utf-8?B?bGVSbU41cGd6ZnFwNWppZEdSZEhlSTRkeDJoY0Y2K0sxMjVZa0tNMVFldUlP?=
 =?utf-8?B?OHVGN21rQ3UrTWFiZ253am8xUmNRYlNHSkdlbXlhZ1NjK25LejMrQmMySlQx?=
 =?utf-8?B?dVVocXBqM0tTVWNpWFRaNG9WeFZub2FMYk5tSzEvcjRMSlRmbm1zdyttMU9L?=
 =?utf-8?B?bHU1cmJxRC9wTkhybmVZOC9mZTUzVUNvS2RxeFgzbERoUE5mV2dzUDdsWW9C?=
 =?utf-8?B?RzM3bVZXOURLL2JVZEZraTlmUFp1WEZIOWhmZFlKNEU4ZFBNUnJqbmVXL3JS?=
 =?utf-8?B?SlRodnRGR09OSGNNVm1lQU5GL1A0ellTWEFDdm1QSzZuVmpZZFNOV3pIcm56?=
 =?utf-8?Q?lgCqQA4cHQCFDnM2rIUttb7tF?=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: SJ0PR11MB6744.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 45ad6ef1-f0c8-40d3-7d63-08dc7dfb76fb
X-MS-Exchange-CrossTenant-originalarrivaltime: 27 May 2024 03:16:56.6167 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: LRudokuZWkLfFhg8f5BrjLuFldKyQYNJZQceJyr1eaQlp52A1m7iTO+kvWKP0QJDqoALYyNqMPwWgg8F2Zf2ja8+y9SSTJS1IKVd/94ho48=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH8PR11MB6754
X-OriginatorOrg: intel.com
Received-SPF: pass client-ip=192.198.163.7;
 envelope-from=zhenzhong.duan@intel.com; helo=mgamail.intel.com
X-Spam_score_int: -45
X-Spam_score: -4.6
X-Spam_bar: ----
X-Spam_report: (-4.6 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.145,
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

SGkgQ2xlbWVudCwNCg0KPi0tLS0tT3JpZ2luYWwgTWVzc2FnZS0tLS0tDQo+RnJvbTogQ0xFTUVO
VCBNQVRISUVVLS1EUklGIDxjbGVtZW50Lm1hdGhpZXUtLWRyaWZAZXZpZGVuLmNvbT4NCj5TZW50
OiBGcmlkYXksIE1heSAyNCwgMjAyNCA5OjU3IFBNDQo+VG86IER1YW4sIFpoZW56aG9uZyA8emhl
bnpob25nLmR1YW5AaW50ZWwuY29tPjsgcWVtdS0NCj5kZXZlbEBub25nbnUub3JnDQo+Q2M6IGFs
ZXgud2lsbGlhbXNvbkByZWRoYXQuY29tOyBjbGdAcmVkaGF0LmNvbTsgZXJpYy5hdWdlckByZWRo
YXQuY29tOw0KPm1zdEByZWRoYXQuY29tOyBwZXRlcnhAcmVkaGF0LmNvbTsgamFzb3dhbmdAcmVk
aGF0LmNvbTsNCj5qZ2dAbnZpZGlhLmNvbTsgbmljb2xpbmNAbnZpZGlhLmNvbTsgam9hby5tLm1h
cnRpbnNAb3JhY2xlLmNvbTsgVGlhbiwNCj5LZXZpbiA8a2V2aW4udGlhbkBpbnRlbC5jb20+OyBM
aXUsIFlpIEwgPHlpLmwubGl1QGludGVsLmNvbT47IFBlbmcsIENoYW8gUA0KPjxjaGFvLnAucGVu
Z0BpbnRlbC5jb20+OyBQYW9sbyBCb256aW5pIDxwYm9uemluaUByZWRoYXQuY29tPjsgUmljaGFy
ZA0KPkhlbmRlcnNvbiA8cmljaGFyZC5oZW5kZXJzb25AbGluYXJvLm9yZz47IEVkdWFyZG8gSGFi
a29zdA0KPjxlZHVhcmRvQGhhYmtvc3QubmV0PjsgTWFyY2VsIEFwZmVsYmF1bSA8bWFyY2VsLmFw
ZmVsYmF1bUBnbWFpbC5jb20+DQo+U3ViamVjdDogUmU6IFtQQVRDSCByZmN2MiAxNS8xN10gaW50
ZWxfaW9tbXU6IFNldCBkZWZhdWx0IGF3X2JpdHMgdG8gNDggaW4NCj5zY2FsYWJsZSBtb2RyZW4g
bW9kZQ0KPg0KPkhpIFpoZW56aG9uZw0KPg0KPk9uIDIyLzA1LzIwMjQgMDg6MjMsIFpoZW56aG9u
ZyBEdWFuIHdyb3RlOg0KPj4gQ2F1dGlvbjogRXh0ZXJuYWwgZW1haWwuIERvIG5vdCBvcGVuIGF0
dGFjaG1lbnRzIG9yIGNsaWNrIGxpbmtzLCB1bmxlc3MgdGhpcw0KPmVtYWlsIGNvbWVzIGZyb20g
YSBrbm93biBzZW5kZXIgYW5kIHlvdSBrbm93IHRoZSBjb250ZW50IGlzIHNhZmUuDQo+Pg0KPj4N
Cj4+IEFjY29yZGluZyB0byBWVEQgc3BlYywgc3RhZ2UtMSBwYWdlIHRhYmxlIGNvdWxkIHN1cHBv
cnQgNC1sZXZlbCBhbmQNCj4+IDUtbGV2ZWwgcGFnaW5nLg0KPj4NCj4+IEhvd2V2ZXIsIDUtbGV2
ZWwgcGFnaW5nIHRyYW5zbGF0aW9uIGVtdWxhdGlvbiBpcyB1bnN1cHBvcnRlZCB5ZXQuDQo+PiBU
aGF0IG1lYW5zIHRoZSBvbmx5IHN1cHBvcnRlZCB2YWx1ZSBmb3IgYXdfYml0cyBpcyA0OC4NCj4+
DQo+PiBTbyBkZWZhdWx0IGF3X2JpdHMgdG8gNDggaW4gc2NhbGFibGUgbW9kZXJuIG1vZGUuIElu
IG90aGVyIGNhc2VzLA0KPj4gaXQgaXMgc3RpbGwgZGVmYXVsdCB0byAzOSBmb3IgY29tcGF0aWJp
bGl0eS4NCj4+DQo+PiBBZGQgYSBjaGVjayB0byBlbnN1cmUgdXNlciBzcGVjaWZpZWQgdmFsdWUg
aXMgNDggaW4gbW9kZXJuIG1vZGUNCj4+IGZvciBub3cuDQo+Pg0KPj4gU2lnbmVkLW9mZi1ieTog
Wmhlbnpob25nIER1YW4gPHpoZW56aG9uZy5kdWFuQGludGVsLmNvbT4NCj4+IC0tLQ0KPj4gICBo
dy9pMzg2L2ludGVsX2lvbW11LmMgfCAxNiArKysrKysrKysrKysrKystDQo+PiAgIDEgZmlsZSBj
aGFuZ2VkLCAxNSBpbnNlcnRpb25zKCspLCAxIGRlbGV0aW9uKC0pDQo+Pg0KPj4gZGlmZiAtLWdp
dCBhL2h3L2kzODYvaW50ZWxfaW9tbXUuYyBiL2h3L2kzODYvaW50ZWxfaW9tbXUuYw0KPj4gaW5k
ZXggZTA3ZGFhYmE5OS4uYTRjMjQxZWE5NiAxMDA2NDQNCj4+IC0tLSBhL2h3L2kzODYvaW50ZWxf
aW9tbXUuYw0KPj4gKysrIGIvaHcvaTM4Ni9pbnRlbF9pb21tdS5jDQo+PiBAQCAtMzc0OCw3ICsz
NzQ4LDcgQEAgc3RhdGljIFByb3BlcnR5IHZ0ZF9wcm9wZXJ0aWVzW10gPSB7DQo+PiAgICAgICAg
ICAgICAgICAgICAgICAgICAgICAgICBPTl9PRkZfQVVUT19BVVRPKSwNCj4+ICAgICAgIERFRklO
RV9QUk9QX0JPT0woIngtYnVnZ3ktZWltIiwgSW50ZWxJT01NVVN0YXRlLCBidWdneV9laW0sDQo+
ZmFsc2UpLA0KPj4gICAgICAgREVGSU5FX1BST1BfVUlOVDgoImF3LWJpdHMiLCBJbnRlbElPTU1V
U3RhdGUsIGF3X2JpdHMsDQo+PiAtICAgICAgICAgICAgICAgICAgICAgIFZURF9IT1NUX0FERFJF
U1NfV0lEVEgpLA0KPj4gKyAgICAgICAgICAgICAgICAgICAgICAweGZmKSwNCj55b3UgY291bGQg
ZGVmaW5lIGEgY29uc3RhbnQgZm9yIHRoaXMgaW52YWxpZCB2YWx1ZQ0KDQpTdXJlLCBtYXliZSBW
VERfSE9TVF9BRERSRVNTX1dJRFRIX1VOREVGSU5FRD8NCg0KVGhhbmtzDQpaaGVuemhvbmcNCg0K
Pj4gICAgICAgREVGSU5FX1BST1BfQk9PTCgiY2FjaGluZy1tb2RlIiwgSW50ZWxJT01NVVN0YXRl
LCBjYWNoaW5nX21vZGUsDQo+RkFMU0UpLA0KPj4gICAgICAgREVGSU5FX1BST1BfQk9PTCgieC1z
Y2FsYWJsZS1tb2RlIiwgSW50ZWxJT01NVVN0YXRlLA0KPnNjYWxhYmxlX21vZGUsIEZBTFNFKSwN
Cj4+ICAgICAgIERFRklORV9QUk9QX0JPT0woInNub29wLWNvbnRyb2wiLCBJbnRlbElPTU1VU3Rh
dGUsDQo+c25vb3BfY29udHJvbCwgZmFsc2UpLA0KPj4gQEAgLTQ2NjMsNiArNDY2MywxNCBAQCBz
dGF0aWMgYm9vbA0KPnZ0ZF9kZWNpZGVfY29uZmlnKEludGVsSU9NTVVTdGF0ZSAqcywgRXJyb3Ig
KiplcnJwKQ0KPj4gICAgICAgICAgIH0NCj4+ICAgICAgIH0NCj4+DQo+PiArICAgIGlmIChzLT5h
d19iaXRzID09IDB4ZmYpIHsNCj4+ICsgICAgICAgIGlmIChzLT5zY2FsYWJsZV9tb2Rlcm4pIHsN
Cj4+ICsgICAgICAgICAgICBzLT5hd19iaXRzID0gVlREX0hPU1RfQVdfNDhCSVQ7DQo+PiArICAg
ICAgICB9IGVsc2Ugew0KPj4gKyAgICAgICAgICAgIHMtPmF3X2JpdHMgPSBWVERfSE9TVF9BV18z
OUJJVDsNCj4+ICsgICAgICAgIH0NCj4+ICsgICAgfQ0KPj4gKw0KPj4gICAgICAgaWYgKChzLT5h
d19iaXRzICE9IFZURF9IT1NUX0FXXzM5QklUKSAmJg0KPj4gICAgICAgICAgIChzLT5hd19iaXRz
ICE9IFZURF9IT1NUX0FXXzQ4QklUKSAmJg0KPj4gICAgICAgICAgICFzLT5zY2FsYWJsZV9tb2Rl
cm4pIHsNCj4+IEBAIC00NjcxLDYgKzQ2NzksMTIgQEAgc3RhdGljIGJvb2wNCj52dGRfZGVjaWRl
X2NvbmZpZyhJbnRlbElPTU1VU3RhdGUgKnMsIEVycm9yICoqZXJycCkNCj4+ICAgICAgICAgICBy
ZXR1cm4gZmFsc2U7DQo+PiAgICAgICB9DQo+Pg0KPj4gKyAgICBpZiAoKHMtPmF3X2JpdHMgIT0g
VlREX0hPU1RfQVdfNDhCSVQpICYmIHMtPnNjYWxhYmxlX21vZGVybikgew0KPj4gKyAgICAgICAg
ZXJyb3Jfc2V0ZyhlcnJwLCAiU3VwcG9ydGVkIHZhbHVlcyBmb3IgYXctYml0cyBhcmU6ICVkIiwN
Cj5zcGVjaWZ5ICdpbiBtb2Rlcm4gbW9kZScgaW4gdGhlIG1lc3NhZ2U/DQo+PiArICAgICAgICAg
ICAgICAgICAgIFZURF9IT1NUX0FXXzQ4QklUKTsNCj4+ICsgICAgICAgIHJldHVybiBmYWxzZTsN
Cj4+ICsgICAgfQ0KPj4gKw0KPj4gICAgICAgaWYgKHMtPnNjYWxhYmxlX21vZGUgJiYgIXMtPmRt
YV9kcmFpbikgew0KPj4gICAgICAgICAgIGVycm9yX3NldGcoZXJycCwgIk5lZWQgdG8gc2V0IGRt
YV9kcmFpbiBmb3Igc2NhbGFibGUgbW9kZSIpOw0KPj4gICAgICAgICAgIHJldHVybiBmYWxzZTsN
Cj4+IC0tDQo+PiAyLjM0LjENCj4+DQo+I2NtZA0K

