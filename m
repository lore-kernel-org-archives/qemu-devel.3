Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 93735CA0FFD
	for <qemu-devel@archiver.kernel.org>; Mon,  1 Sep 2025 08:16:37 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uszhR-000188-Fl; Mon, 01 Sep 2025 04:15:37 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <zhenzhong.duan@intel.com>)
 id 1uszhN-00017W-Gx
 for qemu-devel@nongnu.org; Mon, 01 Sep 2025 04:15:34 -0400
Received: from mgamail.intel.com ([192.198.163.14])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <zhenzhong.duan@intel.com>)
 id 1uszhI-0005lR-Hy
 for qemu-devel@nongnu.org; Mon, 01 Sep 2025 04:15:32 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1756714529; x=1788250529;
 h=from:to:cc:subject:date:message-id:references:
 in-reply-to:content-transfer-encoding:mime-version;
 bh=IXN/jk4MDjfTGwwI4fMPpIkj1IdImAI0eBFB5+T6qgU=;
 b=BEIN+12p+C+hdhdWB6BQnimVsKUrKkKXsvTqpspJWRNYjtk8VoexqJJZ
 vlj4hPORps+DnW4bzprm5QuezHHBRBzYMqowxxAbc6NspuuJOup0gt726
 FpN4dPzotpqVKN5Ly8NQylIcQhGrXDYNzFY8TjVTodnY6gSioH12zcKfe
 zJQZzcq8zddZ/C5SnAcRQ0YdJLzti8If0qa68O8EvcUFSQd6BljY2oBka
 NohX4CHnHT1unZWnP9qIdcYTUB7rfwL/d3fseVncOK6w7SiN4QMqergCT
 XbomAdBd21nQJmRPqhCuKZtxP1BWDiBIkjFrYLzSKkQNAnjdg6qTb6Tka Q==;
X-CSE-ConnectionGUID: Za4sqibrSZyxFT3FZ+PzcA==
X-CSE-MsgGUID: B4jU0pUjQQC1I1cTXY4WZw==
X-IronPort-AV: E=McAfee;i="6800,10657,11539"; a="59026070"
X-IronPort-AV: E=Sophos;i="6.18,225,1751266800"; d="scan'208";a="59026070"
Received: from fmviesa005.fm.intel.com ([10.60.135.145])
 by fmvoesa108.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 01 Sep 2025 01:11:41 -0700
X-CSE-ConnectionGUID: pfNTadt9StW0xiv87iAuvg==
X-CSE-MsgGUID: Z52fokXjSm+FcYaxVkduNg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.18,225,1751266800"; d="scan'208";a="175330929"
Received: from fmsmsx902.amr.corp.intel.com ([10.18.126.91])
 by fmviesa005.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 01 Sep 2025 01:11:41 -0700
Received: from FMSMSX901.amr.corp.intel.com (10.18.126.90) by
 fmsmsx902.amr.corp.intel.com (10.18.126.91) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.17; Mon, 1 Sep 2025 01:11:40 -0700
Received: from fmsedg901.ED.cps.intel.com (10.1.192.143) by
 FMSMSX901.amr.corp.intel.com (10.18.126.90) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.17 via Frontend Transport; Mon, 1 Sep 2025 01:11:40 -0700
Received: from NAM11-CO1-obe.outbound.protection.outlook.com (40.107.220.69)
 by edgegateway.intel.com (192.55.55.81) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.17; Mon, 1 Sep 2025 01:11:39 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=i65Gguk4RQPZMXsDllwOEqFcKwrIHPJBU1OgF4TQcN2RpStVmwkx568jaysvW2MnHnTVEz4YvgKY35tDKsAjJEftEiYzIjpbMoT5QAh4G2vW5PjA7e0cmyHM+L1dvOoh5qYMDQI8QIdx98e/AzqgWTMXm/5LruBuLsnm95dMbQAcxjwHs3ZPrgEgblG3LtzxCCXV27c+wR8enMBoo/9Jxer1kvR2Ik0VF+UzWwiiUiZoLt1ioFriU4ot8FpNRp1IS3bPzRq0928LTcZH5GhQOSlmPIbWLEV81E0TqGocdAZ2yS+S/qlbUl1nzCsHI8zuTGH+q76EbXYZPFFFfDZcZQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=IXN/jk4MDjfTGwwI4fMPpIkj1IdImAI0eBFB5+T6qgU=;
 b=EI/HKebfDMn2OIsaDxOGVtsUhppWHm+j7ciyKGBaGI/zesZzJzUoT+Fybzmd72EI83ctoM+1Bqw0xXqz2CUnC/w9kAF/H9nDwCyiTSahEoNo4AG6S8w1iSV14Ovf5S6dMTgL8xKtnQbQOeaz9N3zT5ywNqGLwXKdvVBcyJw023bjq3AsfizI4c0bMRFGfGc/5lKciGypCDYhU5bN1uA8fhhGpL8Y+sTkP9E8aZ9a2X0iYeHl6ujb0STfMldNZ0iYN5NFsCmP7DKBnoz/iE8H+Z49mgx0WS4e9oo2R+RJXRaJpYh3b79hKQ5Oz0LyD980FsC1ouTrLCNFNJMYNb7iOg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Received: from IA3PR11MB9136.namprd11.prod.outlook.com (2603:10b6:208:574::12)
 by CH3PR11MB8493.namprd11.prod.outlook.com (2603:10b6:610:1bc::8)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9073.13; Mon, 1 Sep
 2025 08:11:37 +0000
Received: from IA3PR11MB9136.namprd11.prod.outlook.com
 ([fe80::604b:77a4:b1be:3f13]) by IA3PR11MB9136.namprd11.prod.outlook.com
 ([fe80::604b:77a4:b1be:3f13%4]) with mapi id 15.20.9052.019; Mon, 1 Sep 2025
 08:11:37 +0000
From: "Duan, Zhenzhong" <zhenzhong.duan@intel.com>
To: "Liu, Yi L" <yi.l.liu@intel.com>, "eric.auger@redhat.com"
 <eric.auger@redhat.com>, "qemu-devel@nongnu.org" <qemu-devel@nongnu.org>
CC: "alex.williamson@redhat.com" <alex.williamson@redhat.com>,
 "clg@redhat.com" <clg@redhat.com>, "mst@redhat.com" <mst@redhat.com>,
 "jasowang@redhat.com" <jasowang@redhat.com>, "peterx@redhat.com"
 <peterx@redhat.com>, "ddutile@redhat.com" <ddutile@redhat.com>,
 "jgg@nvidia.com" <jgg@nvidia.com>, "nicolinc@nvidia.com"
 <nicolinc@nvidia.com>, "joao.m.martins@oracle.com"
 <joao.m.martins@oracle.com>, "clement.mathieu--drif@eviden.com"
 <clement.mathieu--drif@eviden.com>, "Tian, Kevin" <kevin.tian@intel.com>,
 "Peng, Chao P" <chao.p.peng@intel.com>, Yi Sun <yi.y.sun@linux.intel.com>
Subject: RE: [PATCH v5 16/21] intel_iommu: Replay pasid bindings after context
 cache invalidation
Thread-Topic: [PATCH v5 16/21] intel_iommu: Replay pasid bindings after
 context cache invalidation
Thread-Index: AQHcEy/zmhvzV/GWN0uWVf68C3lMb7R32giAgAFuqwCABL9tgA==
Date: Mon, 1 Sep 2025 08:11:36 +0000
Message-ID: <IA3PR11MB9136319CC57353A1E2F0F26A9207A@IA3PR11MB9136.namprd11.prod.outlook.com>
References: <20250822064101.123526-1-zhenzhong.duan@intel.com>
 <20250822064101.123526-17-zhenzhong.duan@intel.com>
 <ed8f5d83-0bcf-4685-a362-cbb948b01baa@redhat.com>
 <eede18d2-e8fb-4bbd-b718-3f11544716ba@intel.com>
In-Reply-To: <eede18d2-e8fb-4bbd-b718-3f11544716ba@intel.com>
Accept-Language: en-US
Content-Language: en-US
X-Mentions: yi.l.liu@intel.com
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: IA3PR11MB9136:EE_|CH3PR11MB8493:EE_
x-ms-office365-filtering-correlation-id: 5560f48b-89b9-458f-cfee-08dde92f2c29
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
 ARA:13230040|7416014|376014|366016|1800799024|38070700018; 
x-microsoft-antispam-message-info: =?utf-8?B?T0ttM1pyR1haOEFIblA1ZjVuN3VzWFl6TXVIR1NVZEZPVVF6Rk5hVnFqd21J?=
 =?utf-8?B?V3ZHY2VXaFQ4ejduRnhtRXlxa0g0KzFaOUtmeTY4elZlbTNuZ2dJZStrMGRW?=
 =?utf-8?B?WUJPQWtQRkFhZUw3YWg0ODl5SlJhWnZ5Ulc2K2lpL2N2cE9wN3VKZ29CRXJM?=
 =?utf-8?B?OTBEOUZyS0tkcndia1NqOVl4Z3Qxc2hHYUNWblRDeHFocUl6cVN5YmwvN2gz?=
 =?utf-8?B?Z2FNa004Vk9NUERYS0cyTXlvS2NiKzlSVFpuWGgxNjdlQ1g5MVRsTUtYME5j?=
 =?utf-8?B?ekllSk5nOW0wL1RGZnNrSlVPQm54dWhDbWczUmgvejZTbVNzUUMyVEQxeDFJ?=
 =?utf-8?B?Z210ZXYycStURGxjZUs4QTNGdm12eFZiNGRHQUptSEFuN2xGRFNNNUttalc5?=
 =?utf-8?B?c1FKY3libjVHVXFGTGRjVXRSZUtNNXlSNXJIZGp6VGtpa1pHUENhUXBhbnp3?=
 =?utf-8?B?bFFtVFphRVdSSkEweEtRUlh5Y29YUlVMVmNDU0l4LytiSDhXZklZWVNrOERY?=
 =?utf-8?B?bmNKdXJwMExNaE5UaTZ0Tmw0ZHMyUVplcVU5QW5nT2wrQ0VKZUlCUHphb3Yz?=
 =?utf-8?B?VHFuUkJZK0t4eFBCa3IvMUN1K0JzRGVYaWdSeFJXbkpiQ0lRWkZYdzllOEQx?=
 =?utf-8?B?Q09zM08wMHBVa1UxR2l0bGJnK1lCOGlEV2didHBFZFNVeUJBTmM5dDBXbnJI?=
 =?utf-8?B?djhsOXgyaldkVFBQVE4zS0xsSjFTZG5WRjBBc1pYdzVaM2NLRjFKUTY1b3hB?=
 =?utf-8?B?US9mTUZtZmZBUFJ5aHlzY3dCeXdvbUlxQzd2bXJqczlqaWpYMVZRcVpkbVdr?=
 =?utf-8?B?MXg1bEp3MU11M0FBUmpKSnR6ait4dzlMSWtWcDNYU1VQTDNwZ0wvdDZRRFgv?=
 =?utf-8?B?bkVwTVlLc0ZuWkkxWFRteUhBak9Cejh2MjFCSVpoR0tXeUswQit6ZHhCWGlX?=
 =?utf-8?B?aHc5RUJYTVIzUFczaU8xbnhocnJLT0xCZWtYT1p6dCttYTZxRFg4NHNRNUxM?=
 =?utf-8?B?SW1US0tobDhCT05HYnh5M2FtVkxGY3N2UVJtYlp4c3dDc25RZnlvU2V1UVR6?=
 =?utf-8?B?aFZWcXNRODFrWm1oYWtvUWkyOUFwMjVaM3ovaUswOHVhMHo0Umg0VG8xc3cy?=
 =?utf-8?B?d0lCUzFwSHFlalhBbWF0OFZZbW0xYkt2MHBoQUszZUg1VmFyMkVBYTlOQzBX?=
 =?utf-8?B?bDZXN244YUVBeTlxTnhtUXJiR2o4TjR3NjFkLytvdWpubjFDa2F6eGFoMlVJ?=
 =?utf-8?B?a1E2QmUyZVl3Vi9KVDRQTDZtbG1mVTZjTEMxZXhGUm9BaWtIaXp5NnJkdGlX?=
 =?utf-8?B?OHFMbkdCMnZNL0NxazMwdnVHRks0ZmVraUkzL2FHK3hCditMMnh5cFJTOE1m?=
 =?utf-8?B?b3hXbk9kSTRrMTdVRW1aaCtyZndQWmU0QkxSSmdEc09yNHhBYVlLckpVZEIy?=
 =?utf-8?B?Y2Fsa3llK3pXOVdrcUdNWEYwU01aS1FRWGRPbk1Nd2Y4dWxwTFBaNW1qRDVj?=
 =?utf-8?B?SWxsem1ZbXlTeG9TS3ZVWm1DWUJCMzRQbWNaMjV4SFJPd2NCRjBCOHVaMnFx?=
 =?utf-8?B?OEFNUmJMVUhTSlVsS1A1Mlg1K3lBMGdPcDhaNzNPMXpDeHJGZUg5NmJTeXl5?=
 =?utf-8?B?TnJGbEZuNFFMNDBKZkRJVGNWMndMWTl0Nm5nQytGbmUwMDZjYUdDQkJ0Q2tL?=
 =?utf-8?B?WStkbFViRFNSbWszRTMyUlloZURpUmFDWGd4akEvanRLaUpRMkhLUiszV1Fp?=
 =?utf-8?B?bTNmWmZWSFZpdElRcmNWQnlPUW1SQ1U3OHp2SDFnWTFnRzdsbUJ3b01JeE1C?=
 =?utf-8?B?aVF6TTJNK2dwYTBxeXEyQ1IwcUd4VU8vcURYSlFBV2xCWjZkU1VXVnZ5SkRM?=
 =?utf-8?B?WmMyQ0ZZcmNUVzN4RGpqcDZUT1RUTG5saDhoT3I1cGRGakhpWU5rQlJSZ3dk?=
 =?utf-8?B?ejhRMTNqZjdLL1VCSU8zY0RwbUFJTlZRWHhjK0dtYnljbVBrWVFkZGJEa3ZC?=
 =?utf-8?Q?rqIjJ5nJiLtSS1jEI6Ka8xuud73NHI=3D?=
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:IA3PR11MB9136.namprd11.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(7416014)(376014)(366016)(1800799024)(38070700018); DIR:OUT;
 SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?SmFPKzFkMXU3T3hCOFZYM1dJVVV6TlJ6S0x1OFQ3YmdsWGRVM2QvSndOWUZS?=
 =?utf-8?B?ZmtxaFhjTFRmc3JHc0hCdzkxTEtKd1FjWlhyd21sWG5qa1VabU9CZVR1S1k2?=
 =?utf-8?B?YjlzdWwyMEI5T3ZZNnpkMjdpTk5rWVUzUXRUd3V5dllJREJOdGJtcllDeDBV?=
 =?utf-8?B?U3U2NTd0VGpqY20wUzhZbVFDeEZMTU5Cd0pKUUZDbXhLZVRRcGptVXNoY29z?=
 =?utf-8?B?Qy9pN21maTM3UU1OdkErMWdhQ0VQSTNJR25RS1pkei94WmxSWVRORjFFa2k2?=
 =?utf-8?B?ODlldFNhQzRaM2pFRkplRE9aUnRyNmNZQlRxOEdSQzlhWmFYQWdZMlE5SXZ6?=
 =?utf-8?B?bi9XamtvSlBWc2pQdW1WUm5Uek9abkxJckhnMW90N1M5L2VaWWFFUTBxQk5S?=
 =?utf-8?B?WkNabDdNTXF2Q244akpSa3Z1bmVSQ3RVVlJNaTNlQVUrdjFidXhzNVVqdEJv?=
 =?utf-8?B?ZWVpU1lBRC9pb0o3ODFzVjNBbXVaQ0ExTWdld1poQ3VhRnhCRlVua2YxT0kr?=
 =?utf-8?B?cFMzTlY0bHJ0cmtyYm9jUVZOOFJZaWpZWWtIK3Z0TlVlYm0raWRwYm9rYTY1?=
 =?utf-8?B?dlJyR1B2QTlrMDZEMGp3UW10b2xjb3NlTEgvTEtnZ1c1dTFsVnlzdjh1eWJI?=
 =?utf-8?B?UHpkVm90L0kySTRJekhrQkNHUHFZOTFEZTg4Tm5wU1hNelE2K0N1YWNDT1Qr?=
 =?utf-8?B?MXJyOHRldVd2TXZyenh5WEplYVdRc3ZHeVVFSUVSQWVaWDc1MG1Lb1hMbUVB?=
 =?utf-8?B?S1lWVWVQWmtlZmlab1ltK2dSVE5IOXdzQ00wNkpJblk5UzRUckMxM0xmbldm?=
 =?utf-8?B?ZXNFcHJDNjgwZmFoL0J1RDNnNkIxYUVDZGkxQ0RuTE5TbXg4Nm1WbmZmeWxz?=
 =?utf-8?B?bTNlY0E4dFJNWEFwNzVadzFoSVJ3U2ovbWdLZGpYYjMvTE1jeDhud1NKQXpw?=
 =?utf-8?B?eGphYXdIQ0FuYk1adGMybUkrTHZSa3hvaEg4TXlVSVk1K2hBeVYxNm5memls?=
 =?utf-8?B?bU5Yc21aM2VqZ1N1RFdtaDBMQ29zaldBMXMwSnBYdlI5WXNOY3pLeXByUG45?=
 =?utf-8?B?QzF2YnBpNkZsRXMybzA3VW5PSWE4R3pZbHRWWVlqQ1Q0YUpkd2RXUTl4eDl4?=
 =?utf-8?B?M0ttS0VpL3UvMHBVZVlGSll4eWJsYUFQck9yV0RuMGtFOEo2cGJZU0g2WktV?=
 =?utf-8?B?SEhXeUFGZ3BUZjFEZFBncTFhbGUxUlRuSVplSlpOWndlTW5IdFdiN2FHbFZz?=
 =?utf-8?B?UjVSZzJiTXRWSHJHTGVCRWVnYjdPeHAyK0VZcjFnWlI3U25LRU9FUEF5TkxN?=
 =?utf-8?B?QW85aUxid2JmU1BpZzBYMzEwb1BmTnNRRG5Sd2ZtLzA5eVl1REtMVTNOUHV2?=
 =?utf-8?B?VDdjYktTUG9Ta1Jud3NiQkFsTkxGUHFMMVM4WlFaSG9IbzZhSlFOUnkxRjJo?=
 =?utf-8?B?YnYwOVFDc0hiYU1hdzZCZW1ubG1adVA0T0pXNWpoMW5EZ1pQVHlXMWlZTVk1?=
 =?utf-8?B?UnZETWFMbGNyeXhDRGpkS2psSHA3a0FNNTZtSWlqOHlaMm8vcHFBMkRMSWJY?=
 =?utf-8?B?UXU1dDQ5TjVvbTcya01UdzhJb2QyWFJHcmc4ZDh0djd0SEhXeFdRazJZMzNl?=
 =?utf-8?B?WFdmY3dmN3lnYTJ0Sm4yOVNNWDVFaFFKd2duV2I2aXI3eE9HT3A2Yk9IUmdZ?=
 =?utf-8?B?aTQ4R3h6WG1kbnJhbVNtc0J0Rkd1TVdsMUFic2RnYzFYRzlPZ0VQMnc2aTYw?=
 =?utf-8?B?Zk5oaUFOYnVwNisvbHltenpjejJDelpJbmUwVjhnYnh0RFN1TjMydWtyVkNy?=
 =?utf-8?B?RDh4UlBORVFkZjVqd092Sk5lNDJiSzlsQll4YkZRSnd6ZjNaUHJXUkVJQUZG?=
 =?utf-8?B?VzRJOUtyZktvME1XaDRtSnFVK29oZS80MEdHck1oZjBSZHhuK3lMUWNoOG1h?=
 =?utf-8?B?NzdZOFBlZjZyWWJ3TjBkNmNCZ21CK0p5T3NVV204QjNkSXJxaWhvMUNsTXNp?=
 =?utf-8?B?NWpnTjUybHVheU1tRXdwZ2owNGJwditFK0xtZ09rZWR4eUNhZTk5MStweDBm?=
 =?utf-8?B?aFBFRGhoM3BjVU1aZU9NZWNmYjNKWThVMHFERksxaVRMUmJQWk5Ud1dXOE5m?=
 =?utf-8?Q?MP50S24kpwWyi91+XT13lkWvL?=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: IA3PR11MB9136.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 5560f48b-89b9-458f-cfee-08dde92f2c29
X-MS-Exchange-CrossTenant-originalarrivaltime: 01 Sep 2025 08:11:36.9626 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: d0nmyO9Hvc+SStl2tMLwwlz4Pi1POeFc5eSy6C9HGCuSyb68gw1nvlG1D3BYu4k8zo1wnuhVi9GIQM17//flgREOBTxCXvzl/138nws6Ico=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH3PR11MB8493
X-OriginatorOrg: intel.com
Received-SPF: pass client-ip=192.198.163.14;
 envelope-from=zhenzhong.duan@intel.com; helo=mgamail.intel.com
X-Spam_score_int: -43
X-Spam_score: -4.4
X-Spam_bar: ----
X-Spam_report: (-4.4 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_MED=-2.3, RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001,
 RCVD_IN_VALIDITY_SAFE_BLOCKED=0.001, SPF_HELO_NONE=0.001,
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

DQoNCj4tLS0tLU9yaWdpbmFsIE1lc3NhZ2UtLS0tLQ0KPkZyb206IExpdSwgWWkgTCA8eWkubC5s
aXVAaW50ZWwuY29tPg0KPlN1YmplY3Q6IFJlOiBbUEFUQ0ggdjUgMTYvMjFdIGludGVsX2lvbW11
OiBSZXBsYXkgcGFzaWQgYmluZGluZ3MgYWZ0ZXINCj5jb250ZXh0IGNhY2hlIGludmFsaWRhdGlv
bg0KPg0KPk9uIDIwMjUvOC8yOCAxNzo0MywgRXJpYyBBdWdlciB3cm90ZToNCj4+DQo+Pg0KPj4g
T24gOC8yMi8yNSA4OjQwIEFNLCBaaGVuemhvbmcgRHVhbiB3cm90ZToNCj4+PiBGcm9tOiBZaSBM
aXUgPHlpLmwubGl1QGludGVsLmNvbT4NCj4+Pg0KPj4+IFRoaXMgcmVwbGF5cyBndWVzdCBwYXNp
ZCBiaW5kaW5ncyBhZnRlciBjb250ZXh0IGNhY2hlIGludmFsaWRhdGlvbi4NCj4+PiBUaGlzIGlz
IGEgYmVoYXZpb3IgdG8gZW5zdXJlIHNhZmV0eS4gQWN0dWFsbHksIHByb2dyYW1tZXIgc2hvdWxk
IGlzc3VlDQo+Pj4gcGFzaWQgY2FjaGUgaW52YWxpZGF0aW9uIHdpdGggcHJvcGVyIGdyYW51bGFy
aXR5IGFmdGVyIGlzc3VpbmcgYSBjb250ZXh0DQo+Pj4gY2FjaGUgaW52YWxpZGF0aW9uLg0KPj4g
U28gaXMgdGhpcyBtYW5kYXRlZD8gSWYgdGhlIHNwZWMgbWFuZGF0ZXMgc3BlY2lmaWMgaW52YWxp
ZGF0aW9ucyBhbmQgdGhlDQo+PiBndWVzdCBkb2VzIG5vdCBjb21wbHkgd2l0aCB0aGUgZXhwZWN0
ZWQgaW52YWxpZGF0aW9uIHNlcXVlbmNlIHNoYWxsIHdlDQo+PiBkbyB0aGF0IGJlaGluZCB0aGUg
Y3VydGFpbj8NCj4NCj5JIHRoaW5rIHRoaXMgaXMgZm9sbG93aW5nIHRoZSBiZWxvdyBkZWNpc2lv
bi4gV2UgY2FuIGRpc2N1c3MgaWYgaXQncw0KPnJlYWxseSBuZWVkZWQgdG8gcmVwbGF5IHRoZSBw
YXNpZCBiaW5kLg0KPg0KPmQ0ZDYwN2U0MGQgKFBldGVyIFh1ICAgICAgICAgICAgICAgICAgICAg
MjAxNy0wNC0wNyAxODo1OToxNSArMDgwMA0KPjIzMjEpDQo+ICAgICAvKg0KPmRkNGQ2MDdlNDBk
IChQZXRlciBYdSAgICAgICAgICAgICAgICAgICAgIDIwMTctMDQtMDcgMTg6NTk6MTUgKzA4MDAN
Cj4yMzIyKSAgICAgICogRnJvbSBWVC1kIHNwZWMgNi41LjIuMSwgYSBnbG9iYWwgY29udGV4dCBl
bnRyeSBpbnZhbGlkYXRpb24NCj5kZDRkNjA3ZTQwZCAoUGV0ZXIgWHUgICAgICAgICAgICAgICAg
ICAgICAyMDE3LTA0LTA3IDE4OjU5OjE1ICswODAwDQo+MjMyMykgICAgICAqIHNob3VsZCBiZSBm
b2xsb3dlZCBieSBhIElPVExCIGdsb2JhbCBpbnZhbGlkYXRpb24sIHNvIHdlDQo+c2hvdWxkDQo+
ZGQ0ZDYwN2U0MGQgKFBldGVyIFh1ICAgICAgICAgICAgICAgICAgICAgMjAxNy0wNC0wNyAxODo1
OToxNSArMDgwMA0KPjIzMjQpICAgICAgKiBiZSBzYWZlIGV2ZW4gd2l0aG91dCB0aGlzLiBIb2V3
ZXZlciwgbGV0J3MgcmVwbGF5IHRoZSByZWdpb24gYXMNCj5kZDRkNjA3ZTQwZCAoUGV0ZXIgWHUg
ICAgICAgICAgICAgICAgICAgICAyMDE3LTA0LTA3IDE4OjU5OjE1ICswODAwDQo+MjMyNSkgICAg
ICAqIHdlbGwgdG8gYmUgc2FmZXIsIGFuZCBnbyBiYWNrIGhlcmUgd2hlbiB3ZSBuZWVkIGZpbmVy
IHR1bmVzDQo+Zm9yDQo+ZGQ0ZDYwN2U0MGQgKFBldGVyIFh1ICAgICAgICAgICAgICAgICAgICAg
MjAxNy0wNC0wNyAxODo1OToxNSArMDgwMA0KPjIzMjYpICAgICAgKiBWVC1kIGVtdWxhdGlvbiBj
b2Rlcy4NCj5kZDRkNjA3ZTQwZCAoUGV0ZXIgWHUgICAgICAgICAgICAgICAgICAgICAyMDE3LTA0
LTA3IDE4OjU5OjE1ICswODAwDQo+MjMyNykgICAgICAqLw0KPmRkNGQ2MDdlNDBkIChQZXRlciBY
dSAgICAgICAgICAgICAgICAgICAgIDIwMTctMDQtMDcgMTg6NTk6MTUgKzA4MDANCj4yMzI4KSAg
ICAgdnRkX2lvbW11X3JlcGxheV9hbGwocyk7DQoNCkkgaGF2ZSB0ZXN0ZWQgdGhpcyBzZXJpZXMg
d2l0aCB0aGlzIHBhdGNoIHJldmVydGVkLCBpdCB3b3JrcyB3aXRoIGd1ZXN0IGxpbnV4IGtlcm5l
bC4NCg0KUGVyc29uYWxseSwgSSBhbSBpbmNsaW5lZCB0byBzdG9wIGFkZGluZyB3b3JrYXJvdW5k
IGZvciBndWVzdCBrZW5yZWwgYnVnLCB0aGVyZSB3aWxsIGJlIG1vcmUgYW5kIG1vcmUgb3ZlciB0
aW1lIGFuZCBpdCBtYWtlcyBjdXJyZW50IGNvZGUgY29tcGxleCB1bm5lY2Vzc2FyaWx5LiBARXJp
YywgQExpdSwgWWkgTCB5b3VyIHRob3VnaHQ/DQoNClRoYW5rcw0KWmhlbnpob25nDQo=

