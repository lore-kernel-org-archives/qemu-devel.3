Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 70828C3DA63
	for <qemu-devel@archiver.kernel.org>; Tue, 23 Jul 2024 05:12:37 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sW7oh-0004i9-9P; Tue, 23 Jul 2024 01:12:03 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <zhenzhong.duan@intel.com>)
 id 1sW7oX-0004As-L3
 for qemu-devel@nongnu.org; Tue, 23 Jul 2024 01:11:54 -0400
Received: from mgamail.intel.com ([198.175.65.19])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <zhenzhong.duan@intel.com>)
 id 1sW7oV-0001hV-Gv
 for qemu-devel@nongnu.org; Tue, 23 Jul 2024 01:11:53 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1721711512; x=1753247512;
 h=from:to:cc:subject:date:message-id:references:
 in-reply-to:content-transfer-encoding:mime-version;
 bh=/tWLJ6aZT1FkcNecWKC9SWhZG/IH69TJRtPud4UMuPo=;
 b=ZavXsUepzxqzzuVNtl2lhFDhri4+exS0YpIDmn1GZsAe84EJ0i0zua2K
 yfbax3sP13EZHgCyblGD42i1Qcu3rIgC4bCSuvsjGUnABz7S4KK7E4BL/
 vqu3uD7C2/g4VmdTPTY3THNHrmADdJQb359t4j9kXXN7xYHDcJZeq93vc
 CTKeTZeCTq/HNI9COIDKYzB5SRc9k6l3CxaDSQliEvwlzMcMU38Trip/M
 H881NJahMhsQmvvM+dBQHr4M3awcLdd2hLzNd6T7t+IhLwgiKLRXQF4MX
 KShF9vpapSmkeIkLOBH8R11vfWYz0lW18NApqvD4i/YPDgdRmNcLH1UYk A==;
X-CSE-ConnectionGUID: PDIhdozISpu7q0ZNNpKXLQ==
X-CSE-MsgGUID: 6+KxIgPFQESO0BRrtgPEUQ==
X-IronPort-AV: E=McAfee;i="6700,10204,11141"; a="19161534"
X-IronPort-AV: E=Sophos;i="6.09,229,1716274800"; d="scan'208";a="19161534"
Received: from fmviesa006.fm.intel.com ([10.60.135.146])
 by orvoesa111.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 22 Jul 2024 22:11:50 -0700
X-CSE-ConnectionGUID: w5Es3elAQdOwViRDC/q0Qg==
X-CSE-MsgGUID: lDNlp376RE2sHCIkb4S2yw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.09,229,1716274800"; d="scan'208";a="51763334"
Received: from fmsmsx602.amr.corp.intel.com ([10.18.126.82])
 by fmviesa006.fm.intel.com with ESMTP/TLS/AES256-GCM-SHA384;
 22 Jul 2024 22:11:49 -0700
Received: from fmsmsx610.amr.corp.intel.com (10.18.126.90) by
 fmsmsx602.amr.corp.intel.com (10.18.126.82) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.39; Mon, 22 Jul 2024 22:11:48 -0700
Received: from FMSEDG603.ED.cps.intel.com (10.1.192.133) by
 fmsmsx610.amr.corp.intel.com (10.18.126.90) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.39 via Frontend Transport; Mon, 22 Jul 2024 22:11:48 -0700
Received: from NAM10-DM6-obe.outbound.protection.outlook.com (104.47.58.100)
 by edgegateway.intel.com (192.55.55.68) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.39; Mon, 22 Jul 2024 22:11:48 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=QoMkTZQDGNQ+yTxpbBQ8sau0jhgEdrlcoHMvmkMdAu3u/vo8a0U37JZ0tLFPKHRNNhWrZZpzEEqVyX88vUMEC7OhIkQ2x5hjG/nNjkmBO6OD/Z9gfpHwIQoeSQPsgH7Xu5/GetyI0xl1RRkvC7YugALPBB8xYYTBAfHh4LkBkhoVK5+nZXuZXjhpRM5xffyEeBMOiThxBB3ylaNOIAmisuFg6cZ6aV84tzKGCFN8+FCF7U359W6lBrIEeO74QcApyR3F3XsUpf5NrjNw0EXnx3ZI/6Uds+HNgJCWSxZnns6jaZgsOYj7yb92FJxZ6CC11NAXOcQ45idWgK9w7QpxHQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=/tWLJ6aZT1FkcNecWKC9SWhZG/IH69TJRtPud4UMuPo=;
 b=fIK0//lAAdtCr/zCT9yFFx/uKhgZpMxqAlheTAauBmYei9c/ghB6WkIzPthM2UlvZ15ZvX2ZyGmOCZnrIc0kjxrx6iptXiMTuu0hNQPMQoayMRv8AEIvo2EJc4es25MIrKnr9p1i3rhdya7LhDOu5PEtTT9uTMtsfGAsU9XBXuwEKSi1bwSK/zVi2mnhLwaSlKlOfrLJzdcIs7R9WwnUbP5IRYyJ+m+zXolKnqy5LZCbvRybT9WfgAEM2GW/3eA0GhCQBzWTQbBbeXZ2LCnTcWhQLqBRVbwe4UNXQzrkiAbFactytqVomx6VnaHh61IQpj4eYuMef6XhQW9znnXFHA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Received: from SJ0PR11MB6744.namprd11.prod.outlook.com (2603:10b6:a03:47d::10)
 by PH7PR11MB6931.namprd11.prod.outlook.com (2603:10b6:510:206::15)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7762.29; Tue, 23 Jul
 2024 05:11:46 +0000
Received: from SJ0PR11MB6744.namprd11.prod.outlook.com
 ([fe80::fe49:d628:48b1:6091]) by SJ0PR11MB6744.namprd11.prod.outlook.com
 ([fe80::fe49:d628:48b1:6091%7]) with mapi id 15.20.7784.016; Tue, 23 Jul 2024
 05:11:46 +0000
From: "Duan, Zhenzhong" <zhenzhong.duan@intel.com>
To: Joao Martins <joao.m.martins@oracle.com>, "qemu-devel@nongnu.org"
 <qemu-devel@nongnu.org>
CC: "Liu, Yi L" <yi.l.liu@intel.com>, Eric Auger <eric.auger@redhat.com>, Alex
 Williamson <alex.williamson@redhat.com>, Cedric Le Goater <clg@redhat.com>,
 Jason Gunthorpe <jgg@nvidia.com>, Avihai Horon <avihaih@nvidia.com>
Subject: RE: [PATCH v6 3/9] vfio/iommufd: Add hw_caps field to
 HostIOMMUDeviceCaps
Thread-Topic: [PATCH v6 3/9] vfio/iommufd: Add hw_caps field to
 HostIOMMUDeviceCaps
Thread-Index: AQHa3HwY9BaQHIJxbkSqVv4e7hKwC7IDxJUA
Date: Tue, 23 Jul 2024 05:11:46 +0000
Message-ID: <SJ0PR11MB6744319B0074B745E5B94C5C92A92@SJ0PR11MB6744.namprd11.prod.outlook.com>
References: <20240722211326.70162-1-joao.m.martins@oracle.com>
 <20240722211326.70162-4-joao.m.martins@oracle.com>
In-Reply-To: <20240722211326.70162-4-joao.m.martins@oracle.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: SJ0PR11MB6744:EE_|PH7PR11MB6931:EE_
x-ms-office365-filtering-correlation-id: 553715ed-6350-4726-3e58-08dcaad5f33a
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0; ARA:13230040|366016|376014|1800799024|38070700018;
x-microsoft-antispam-message-info: =?utf-8?B?cTFqZVJtbmxkZ21LdUZ4TTlqeEZFOEYrdHl1UlBhUDVWc2FmNTN4N3N4NjZ2?=
 =?utf-8?B?dWZKTEttOXZ3dWlzRWk2Skx0cjBPTjFUTU5iZFBZVTdPdm9GeHViNEJmVlFF?=
 =?utf-8?B?SVVUYk42U0FyTE84N0VxemRGMCtqSmdCREFNWSs4SmNmdzRJOG9XcHpnSWdI?=
 =?utf-8?B?WnBSUEVNTEdrY2p3VkNBZWhlTXRFN1ZSakxMRldVYkJDeC9pUWNxMXppQnEw?=
 =?utf-8?B?QWE5ZnFkRFEzVFhNNmhDcUl0VWpVT2lXTDFWV1YyYnc5alVjekEwcVRJeVlT?=
 =?utf-8?B?SDJNM1ZqVWQwMUVhbXFMYllXVGVka3ptejFsU0x1WFZjLzgrc2VSSDMxVUMx?=
 =?utf-8?B?eldLQk1tdEpzZ0FKV0g1dG5pcWJ0Snd2VDRrb0pkVWpkMm5lVUtpV0xwbURW?=
 =?utf-8?B?bExVVUtBZ1lvWXQwcWJKNURvVjR2Qm92YzdpQlE5SitFTUpSWG5IYTFZa2kv?=
 =?utf-8?B?ZytXV2d4TU1UMittUkxvdUp6RVl6RmlvcWxza2lqVXRnUlozUm1vcGcySHQ4?=
 =?utf-8?B?OFBRRWFiWlo5TmdqcTFDUUd3L1dXaUtyZXNDMzl3ZWhncmJ0S0hzenNMektR?=
 =?utf-8?B?dzdHdkVDbjRnQlFpaGdLVmNJMEk4R0NQTzgremNoZHpBcGl5YlppOFptSHd4?=
 =?utf-8?B?VnpVemY4V2hsb0RKMHFhY2FVbVVDa2NMei9mZFo2Mnc3eUpReG8rb04vaWRN?=
 =?utf-8?B?NVRGVW01ZWNrVVVkM0VIdnlZZ1pNS2p5RXlTQUVlYUhEY3lwQzVHdXNoTVU4?=
 =?utf-8?B?b1R0RVBPcjYrVlFpV0NFZWpLQkI0VWdMZjh1enZJWGF4c2ZDRkdGMWNTTEps?=
 =?utf-8?B?YzFlQzNVNDVlVlR3eG9MWlZxaGZhUUJ5b3hrS21oNUVPd2JoKzZ4Z05oMkNS?=
 =?utf-8?B?SXBuYnNVYU5NdjQ3WlI1dHRoMmM0Y2xHUnByL0V6MlVWU2Fzcm02d2luWEpS?=
 =?utf-8?B?WnZ1R2VNNU8vUnZReHhaUzEvUkhNWTQ4dFFVWldXVGcra2ZicC8vNlZISzNJ?=
 =?utf-8?B?dEdDL3hoT2FpS0FiTWVlT2FQZXZGVEdCM055MGs4c0JuTDA2UzFoK0o5dVU1?=
 =?utf-8?B?WjBXVmNhbzRCejF3QnRKcW5uc2VJdUtVSWJNN3d6YTZrbUY4Rk4vc2k5K0xN?=
 =?utf-8?B?T09GMjhQNVhqSHFSSk5aOUxnWWNVK29LZDVmc0ZQWFRTMy91YWJnWlhDdzM0?=
 =?utf-8?B?dW1JaFYxWnRyTU1KakJyV3Vkcis0WDVBaG1NRDlaQnpHVVdoNTF6RUQxdHMv?=
 =?utf-8?B?aHdGRnp0TE00SkpPaFJyMGI1d0h5S3N6K0NtWDgrWjhWUzQ0cDNMYStsMjB2?=
 =?utf-8?B?UmppL1N2dWwwZHFlcGZNcDY1N2paVVBOVTFuNkp5eDM3UzYweEhUdkI4Y2tk?=
 =?utf-8?B?aEZyMXNDSXFxWmQ3SVYvRmdDbUs0dS8vRHdBNEpzUzJTY1dWZ3YzVWhGSThm?=
 =?utf-8?B?cVZqZUNudzVLMUdJWGhSKzczTDVuSUF0ZjlTVG82c05tTy9nVHlmdWJBMVFV?=
 =?utf-8?B?TnBOTTZHMTlDRjJIalZSK0N6UXplRFVxMXNZY1hWSHRzZFQ4YVRlS2tTQ0pn?=
 =?utf-8?B?RUhJU0c0MjBiUGpuakFaaExmL25YcThLdmhMY01wUE5SVUR6allMQ1doMXZZ?=
 =?utf-8?B?QzJiVmIySXBqYVNmRk8wdDV0aGNZR0syVlBEU0F2SUZXcmZkc1lWZUY3eThj?=
 =?utf-8?B?a3RMYmw1SHRnNS9NcndzZHVEOEcxWFo4ZTU0VDFubFYzSC9ndU1iV3VZaVRt?=
 =?utf-8?B?QXVwQ1phRWM1VzBpV2YvcXNEU0c4ZmpmKzg0N0dzR3RoTlJnb1AzZDRQaTlJ?=
 =?utf-8?B?dS9rcEtHdE94VVU3azF0UUR5T1RIOXFkb21WS2xIZkJUNWRoRFVPZTRHU1NS?=
 =?utf-8?B?dzhBSElYNXFQdW9YcUc0NlN5ZkJ6YUMrVVRuek5LeDJmZmc9PQ==?=
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:SJ0PR11MB6744.namprd11.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(366016)(376014)(1800799024)(38070700018); DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?bW04YXdWcGVuTDdiVk1QS0ZzVDNPYU5TejZjNGZKR1NUQzFyRUZreUwydlhq?=
 =?utf-8?B?UWFqVFhzVjFSNDI5Yk5wdWRNelpUVzRHRCtPcXFJSy81aHV2bHZicGxHSGNE?=
 =?utf-8?B?cnJvbEdKVmRKK0Y0NUs5cFJJNU52YmxiSkFLSHV5dWRSVzVndlZxSGVmTUVQ?=
 =?utf-8?B?RlRqZzQveUl6QnUrbjFsUjJCY0JuSklKTGd0R3NBOEhBZVJVYlAvSTc5ZjN0?=
 =?utf-8?B?cGNxdXNMRWdRZEp1d2VlcVA4aFZ4SmJSU2JZT2dUTjFUQy9IemRZeGg3VGtF?=
 =?utf-8?B?Mzdab2ZIMU5BVGs5SnZlbG1KczFXVHQwSkFNaFhwMlNzZXdpYU0vVThRUkdZ?=
 =?utf-8?B?M2c1Q1B2akdXOU9PVkRnS1BEa01LdUF2MTlJSEt6czAxTm15TkJRbi8rQjJZ?=
 =?utf-8?B?dnZWamxrUzB5emlpRFhsWFQ1akFzYkl1UHJVQldST2FxL1pSN1FkYUQrcHZX?=
 =?utf-8?B?TWUzMklnYTNtQ2lEUm9VLzdpUFhjMXZQYy9jKy9HOXNmZXhtVWRUdmZtbjFD?=
 =?utf-8?B?Z21nak90Y2Z5b3hZNlR4NzgwWjFYWkNrcm9uKzZnb1JacG9qUDhpbys5Tm9W?=
 =?utf-8?B?Sk1SOGJDMUQwNWN1a0FSbGlKWkMzQmJuNzFQZC94U0pldkZRcGh2ZEhsYnhH?=
 =?utf-8?B?SWk0WXJHajVMNExiN0lUeTY0Qy9IckxvbDVWL2xxM0dWRTdPZTNsRkREaE9C?=
 =?utf-8?B?N0V0cHJBb0VyM0UxR3I0UUtsTCtBem1RaXEwclZqYW43bmNtWUpTY2FPd21j?=
 =?utf-8?B?ZHRHOGtZQWFPQ0lRdmY5eU4zNkppSzlRbUtWMUUvcXF4TmJjeXYxbHJLSVhx?=
 =?utf-8?B?WWxNeUgwMjlzTUlxcFZGemFwNWJQbHVFeGRYSVJjR3NlZ3ZjbDloTUhSbU1E?=
 =?utf-8?B?RWxPSGlrcWdHN1Bsd1VWOXVNQ1VFN0FSeEN4ZUZaT1dsY3hJL3lSZ0pRSitT?=
 =?utf-8?B?TWdyODloZkhwNzlEMEl3UENiWmpBSW5OaEhlbVo2QzUyNmpKVkNFajl0T1Bw?=
 =?utf-8?B?WU0yQVlTM3lWUXU2b2Q1U3oyZ3RPL3o3eGt6ZVNmRThtRG9QbVB3QlJFWkIv?=
 =?utf-8?B?N0RtNXBoWmUrVURlaGV0YnRFNngyTkpPUUNDSGJicVFRTVZnbExKbDlwRks4?=
 =?utf-8?B?blJXa3VzSGs1RFBvS2UwYm93MWRzR0VNWHpWZ2FBM0FBMDNDcHR3N3FCeHpN?=
 =?utf-8?B?SU5naE5rdUUxL0hjancycktXaVNHT1NyenlDWENQY3R3TG1lcUhVTUtkaTdC?=
 =?utf-8?B?VldUWG5hcE1hTFBNYVNCTTdmeDY5M3o0bGlzci9aUUlpQmtwbWROYTRYbUs0?=
 =?utf-8?B?TGVzTHZnaGtKL3E5WUwxTHhidC9kSFJVa2l3WUZjK2h4bVVZMEZvZjhUdDJw?=
 =?utf-8?B?N3hySEs4RDltU3d2ZnNoUWREeUw4OEF1M2NOM1crTCs2ZHZ1TU5hZ0I3dGlx?=
 =?utf-8?B?MEMxUVk1R08wUnMwUUdTd09LUEdDeHBXd1dSSGJTTEpnYitBZ1NHbVIwQ2w1?=
 =?utf-8?B?L2FvcnE4WFBRVWl5Rnl6Z2x3bVl4TG10Rk5ydU5EaVVSb3h0QzFhcFhVVDRV?=
 =?utf-8?B?Mm8rRXFOVU0zSExkMVhRc1pQZjNWZmN2TVFpNjBIVy9zODZyWWp5SmlORzNN?=
 =?utf-8?B?c0RZTkx0VkhlVVpHdnVTajluU3Q1L2Z5OGUveE56WS8veDhISnRQa3hLTmIz?=
 =?utf-8?B?ZDBQTVZyYVFFSkQ3M25SUlQwSXpGQVU2anFrQW9mQ2x5aGluKzRWTmI3VW4x?=
 =?utf-8?B?ZlNEb0dtZzRNSExjUkI5VHJqWXdGL0gvZ3VDU29oemxwTWNWdVhjVjhCRGlO?=
 =?utf-8?B?UkdGTC9INTdYOWhqbHIvaVJVS2tUTitPTVlvRDdsYnlOTEVCMVV1UFVzQjZD?=
 =?utf-8?B?dkxqVDdkOUNvS2wzMGo3VGc3TEFxNFpHZ3U3eVc5bnRUbmdEL2pQeEcyalF4?=
 =?utf-8?B?TjFpeFQxVzFDUVNKaE56VWRYYnQ4cVh4MEd2TkhsL1FUbkRDVmprcjFsYjFV?=
 =?utf-8?B?bEkyVnVzZFlsWjRRbVhCTVNZT3l4bXQvTFZGU201RXQwVTllTlViaVlsMWdF?=
 =?utf-8?B?TjRtMGp5d3V3WUNXNmR2dXNoU3hZeVE2RjQ1Z2l4WkhhY3lqaXRYbmo0YWVv?=
 =?utf-8?Q?XzCwJRL/OXOqfDpOZl6l+IMPN?=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: SJ0PR11MB6744.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 553715ed-6350-4726-3e58-08dcaad5f33a
X-MS-Exchange-CrossTenant-originalarrivaltime: 23 Jul 2024 05:11:46.4569 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: FldVbSH2fSvKZ7IzJ9lF5uIwpcvi+6hQ2ENvp7OHmC8EDrxe48AR+vx64FBm3okM00tguMFFW7SzW5++yHk92RHG9pI1uf3g2MFqMk+HcMQ=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH7PR11MB6931
X-OriginatorOrg: intel.com
Received-SPF: pass client-ip=198.175.65.19;
 envelope-from=zhenzhong.duan@intel.com; helo=mgamail.intel.com
X-Spam_score_int: -44
X-Spam_score: -4.5
X-Spam_bar: ----
X-Spam_report: (-4.5 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.133,
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

DQoNCj4tLS0tLU9yaWdpbmFsIE1lc3NhZ2UtLS0tLQ0KPkZyb206IEpvYW8gTWFydGlucyA8am9h
by5tLm1hcnRpbnNAb3JhY2xlLmNvbT4NCj5TdWJqZWN0OiBbUEFUQ0ggdjYgMy85XSB2ZmlvL2lv
bW11ZmQ6IEFkZCBod19jYXBzIGZpZWxkIHRvDQo+SG9zdElPTU1VRGV2aWNlQ2Fwcw0KPg0KPlN0
b3JlIHRoZSB2YWx1ZSBvZiBAY2FwcyByZXR1cm5lZCBieSBpb21tdWZkX2JhY2tlbmRfZ2V0X2Rl
dmljZV9pbmZvKCkNCj5pbiBhIG5ldyBmaWVsZCBIb3N0SU9NTVVEZXZpY2VDYXBzOjpod19jYXBz
LiBSaWdodCBub3cgdGhlIG9ubHkgdmFsdWUgaXMNCj53aGV0aGVyIGRldmljZSBJT01NVSBzdXBw
b3J0cyBkaXJ0eSB0cmFja2luZw0KPihJT01NVV9IV19DQVBfRElSVFlfVFJBQ0tJTkcpLg0KPg0K
PlRoaXMgaXMgaW4gcHJlcGFyYXRpb24gZm9yIEhvc3RJT01NVURldmljZTo6cmVhbGl6ZSgpIGJl
aW5nIGNhbGxlZCBlYXJseQ0KPmR1cmluZyBhdHRhY2hfZGV2aWNlKCkuDQo+DQo+U2lnbmVkLW9m
Zi1ieTogSm9hbyBNYXJ0aW5zIDxqb2FvLm0ubWFydGluc0BvcmFjbGUuY29tPg0KPlJldmlld2Vk
LWJ5OiBDw6lkcmljIExlIEdvYXRlciA8Y2xnQHJlZGhhdC5jb20+DQoNClJldmlld2VkLWJ5OiBa
aGVuemhvbmcgRHVhbiA8emhlbnpob25nLmR1YW5AaW50ZWwuY29tPg0KDQpUaGFua3MNClpoZW56
aG9uZw0KDQo+LS0tDQo+IGluY2x1ZGUvc3lzZW11L2hvc3RfaW9tbXVfZGV2aWNlLmggfCA0ICsr
KysNCj4gaHcvdmZpby9pb21tdWZkLmMgICAgICAgICAgICAgICAgICB8IDEgKw0KPiAyIGZpbGVz
IGNoYW5nZWQsIDUgaW5zZXJ0aW9ucygrKQ0KPg0KPmRpZmYgLS1naXQgYS9pbmNsdWRlL3N5c2Vt
dS9ob3N0X2lvbW11X2RldmljZS5oDQo+Yi9pbmNsdWRlL3N5c2VtdS9ob3N0X2lvbW11X2Rldmlj
ZS5oDQo+aW5kZXggZDFjMTBmZjdjMjM5Li44MDljY2VkNGJhNWMgMTAwNjQ0DQo+LS0tIGEvaW5j
bHVkZS9zeXNlbXUvaG9zdF9pb21tdV9kZXZpY2UuaA0KPisrKyBiL2luY2x1ZGUvc3lzZW11L2hv
c3RfaW9tbXVfZGV2aWNlLmgNCj5AQCAtMTksOSArMTksMTMgQEANCj4gICogc3RydWN0IEhvc3RJ
T01NVURldmljZUNhcHMgLSBEZWZpbmUgaG9zdCBJT01NVSBkZXZpY2UgY2FwYWJpbGl0aWVzLg0K
PiAgKg0KPiAgKiBAdHlwZTogaG9zdCBwbGF0Zm9ybSBJT01NVSB0eXBlLg0KPisgKg0KPisgKiBA
aHdfY2FwczogaG9zdCBwbGF0Zm9ybSBJT01NVSBjYXBhYmlsaXRpZXMgKGUuZy4gb24gSU9NTVVG
RCB0aGlzDQo+cmVwcmVzZW50cw0KPisgKiAgICAgICAgICAgdGhlIEBvdXRfY2FwYWJpbGl0aWVz
IHZhbHVlIHJldHVybmVkIGZyb20NCj5JT01NVV9HRVRfSFdfSU5GTyBpb2N0bCkNCj4gICovDQo+
IHR5cGVkZWYgc3RydWN0IEhvc3RJT01NVURldmljZUNhcHMgew0KPiAgICAgdWludDMyX3QgdHlw
ZTsNCj4rICAgIHVpbnQ2NF90IGh3X2NhcHM7DQo+IH0gSG9zdElPTU1VRGV2aWNlQ2FwczsNCj4N
Cj4gI2RlZmluZSBUWVBFX0hPU1RfSU9NTVVfREVWSUNFICJob3N0LWlvbW11LWRldmljZSINCj5k
aWZmIC0tZ2l0IGEvaHcvdmZpby9pb21tdWZkLmMgYi9ody92ZmlvL2lvbW11ZmQuYw0KPmluZGV4
IDViYjYyMzg3OWFiZS4uNWUyZmMxY2UwODlkIDEwMDY0NA0KPi0tLSBhL2h3L3ZmaW8vaW9tbXVm
ZC5jDQo+KysrIGIvaHcvdmZpby9pb21tdWZkLmMNCj5AQCAtNzI0LDYgKzcyNCw3IEBAIHN0YXRp
YyBib29sDQo+aGlvZF9pb21tdWZkX3ZmaW9fcmVhbGl6ZShIb3N0SU9NTVVEZXZpY2UgKmhpb2Qs
IHZvaWQgKm9wYXF1ZSwNCj4NCj4gICAgIGhpb2QtPm5hbWUgPSBnX3N0cmR1cCh2ZGV2LT5uYW1l
KTsNCj4gICAgIGNhcHMtPnR5cGUgPSB0eXBlOw0KPisgICAgY2Fwcy0+aHdfY2FwcyA9IGh3X2Nh
cHM7DQo+DQo+ICAgICByZXR1cm4gdHJ1ZTsNCj4gfQ0KPi0tDQo+Mi4xNy4yDQoNCg==

