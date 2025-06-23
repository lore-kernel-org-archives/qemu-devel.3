Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 85DF5C7115B
	for <qemu-devel@archiver.kernel.org>; Mon, 23 Jun 2025 08:26:33 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uTcVL-0004A1-Im; Mon, 23 Jun 2025 04:26:15 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <zhenzhong.duan@intel.com>)
 id 1uTcVI-00049b-WE
 for qemu-devel@nongnu.org; Mon, 23 Jun 2025 04:26:13 -0400
Received: from mgamail.intel.com ([198.175.65.17])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <zhenzhong.duan@intel.com>)
 id 1uTcVH-0000KO-Ab
 for qemu-devel@nongnu.org; Mon, 23 Jun 2025 04:26:12 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1750667172; x=1782203172;
 h=from:to:cc:subject:date:message-id:references:
 in-reply-to:content-transfer-encoding:mime-version;
 bh=0SgDmlgAJBVqb6DiI+qBRObbh83qglPOZyKb6ZxHbj0=;
 b=RLpl/0laU2XVhN40rb2MOur4gr0kqJbC3kswMgb8PJgJ+UgK5wU2EYOI
 q9dwkvbuwsHNfZ7GuRRhgIbcckP27dwe2RaNl0PzuXWTlkc28hC9F3PVb
 1Ml3Vo32+V8pQ5oPkShYSncFK+gPxmKmJ/5boMMWYXWm4kjrDILqrraBO
 GrHPUdlH7VIRf98V6EQS4jSvf+HGbR4s5wiBTR8w1Jf9m0a+6BY/yKfc7
 mpbIX/npIeGxdWNp/n7d9MJ7OW5yqENAuGG7oPn7MloKM+JMfP86822aB
 Qz6Ty5vuRMPqCXKK85TCJ71dRJBXMOGVJOcvYiWnPqsJnzlrEF5RGQpxY w==;
X-CSE-ConnectionGUID: H2uUV661RaGQn+EDZXDcWg==
X-CSE-MsgGUID: VIY+jEsrS7+vB4rVdZAS8g==
X-IronPort-AV: E=McAfee;i="6800,10657,11472"; a="52832858"
X-IronPort-AV: E=Sophos;i="6.16,258,1744095600"; d="scan'208";a="52832858"
Received: from fmviesa002.fm.intel.com ([10.60.135.142])
 by orvoesa109.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 23 Jun 2025 01:26:10 -0700
X-CSE-ConnectionGUID: q3DKn2RRQNCcH+bUeW3GZg==
X-CSE-MsgGUID: C5YsSKNBQBCyoYpvsS/Jhg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.16,258,1744095600"; d="scan'208";a="175138218"
Received: from orsmsx901.amr.corp.intel.com ([10.22.229.23])
 by fmviesa002.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 23 Jun 2025 01:26:09 -0700
Received: from ORSMSX902.amr.corp.intel.com (10.22.229.24) by
 ORSMSX901.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.25; Mon, 23 Jun 2025 01:26:08 -0700
Received: from ORSEDG902.ED.cps.intel.com (10.7.248.12) by
 ORSMSX902.amr.corp.intel.com (10.22.229.24) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.25 via Frontend Transport; Mon, 23 Jun 2025 01:26:08 -0700
Received: from NAM04-MW2-obe.outbound.protection.outlook.com (40.107.101.57)
 by edgegateway.intel.com (134.134.137.112) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.25; Mon, 23 Jun 2025 01:26:07 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=KflkVH8Pf7BMJZvACdI1Le3Qd2SqqIIumIamhX/znpHG9cpAROEn/FzmfMcigkj1W3LxVclanF7EoN7ZHsSvhcHDMUpSEwrOiUo85epR/vIgy1Roc7XDEskV+TPuJpKpAGlYx2wlwFIt0++7Wl4BugyWCmxi+VX5EJ/rgQf57hhtj8DrzFNtAJ763a30qqWOy3CB1lfCb+E4lzIdHLwnCzuLGEZUWtwOPsl1FKH5ud3uUtwQRVgPppjOYxmobKRYniuGeZgYaUNiU+FtZc1fR2ysdr27vFVD4zjHdePaixCVRruo4sNuU+g6WT4U83NrO6SVPDSo9WcS/Rl0/JVkZQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=0SgDmlgAJBVqb6DiI+qBRObbh83qglPOZyKb6ZxHbj0=;
 b=U0s811y3m/Mi57JM3IDbCjY2svG2CTznjrtH5spoYKP+/fInYiOt8vFgseZj1qzeiBoFOz7mxIJMmRfKFbsU2HIKOdpgAGCSZNegiyf8hlcmHP4FRzqO4LO3z0bwjgNFUighUasITNBwTuzqIHvLDNkI6kbw4lCzEB3j8JvmPWc3mhDKWpNfvntBZ0jeI/AdI0ietTWK+QgS2AIsjGzk55qZab7EDvXjS0cPnif1BrV5DcuVXsnpihHfv33fm6N1LVbnvtpOmQmK9qyiDxGfNlayQBIVwpQ0kV1FHLDj1Eu6S7BTSjs3iFczI5Av/MoYwdNDWLEl2zVPyYJj6SQVBQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Received: from IA3PR11MB9136.namprd11.prod.outlook.com (2603:10b6:208:574::12)
 by PH0PR11MB5064.namprd11.prod.outlook.com (2603:10b6:510:3b::15)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8857.26; Mon, 23 Jun
 2025 08:25:52 +0000
Received: from IA3PR11MB9136.namprd11.prod.outlook.com
 ([fe80::604b:77a4:b1be:3f13]) by IA3PR11MB9136.namprd11.prod.outlook.com
 ([fe80::604b:77a4:b1be:3f13%4]) with mapi id 15.20.8835.023; Mon, 23 Jun 2025
 08:25:52 +0000
From: "Duan, Zhenzhong" <zhenzhong.duan@intel.com>
To: Steve Sistare <steven.sistare@oracle.com>, "qemu-devel@nongnu.org"
 <qemu-devel@nongnu.org>
CC: Alex Williamson <alex.williamson@redhat.com>, Cedric Le Goater
 <clg@redhat.com>, "Liu, Yi L" <yi.l.liu@intel.com>, Eric Auger
 <eric.auger@redhat.com>, "Michael S. Tsirkin" <mst@redhat.com>, "Marcel
 Apfelbaum" <marcel.apfelbaum@gmail.com>, Peter Xu <peterx@redhat.com>,
 Fabiano Rosas <farosas@suse.de>
Subject: RE: [PATCH V5 26/38] vfio/iommufd: invariant device name
Thread-Topic: [PATCH V5 26/38] vfio/iommufd: invariant device name
Thread-Index: AQHb2h4KAHTHs3bF+0SdX2uhrr4RObQQfJOg
Date: Mon, 23 Jun 2025 08:25:52 +0000
Message-ID: <IA3PR11MB9136706B44732E4DF6578BB79279A@IA3PR11MB9136.namprd11.prod.outlook.com>
References: <1749569991-25171-1-git-send-email-steven.sistare@oracle.com>
 <1749569991-25171-27-git-send-email-steven.sistare@oracle.com>
In-Reply-To: <1749569991-25171-27-git-send-email-steven.sistare@oracle.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: IA3PR11MB9136:EE_|PH0PR11MB5064:EE_
x-ms-office365-filtering-correlation-id: a0ad49da-1cd1-475e-13b0-08ddb22f915f
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0; ARA:13230040|376014|366016|1800799024|38070700018;
x-microsoft-antispam-message-info: =?utf-8?B?NVNHaUxBWjVtUjU4M0FMTmdmV1luekp2dGVsTFlGZmVGTUdMR1pMSjFBU05r?=
 =?utf-8?B?MEJjejkyVHVNZ2FVaU1nVHkvUWg0Vk5kNzBHL0xjMEdocXAxNFVHNlZJbkF2?=
 =?utf-8?B?RkNlM2R3Tm9EWEhvbDEwdVNLM0N3ZnNOM1plNkl0NXE1WlFBSFNvRXpnSmw4?=
 =?utf-8?B?bW42LzE1UEUvZlIxN0s1dno1SEVEbXM2VWRKaHlkaG5TZHBEYkVFTU9rOGRz?=
 =?utf-8?B?Z0JhajhWMlhuRzhKUkRKNGl3UFdxUTVCRnlWbnFDclVnZDU5WFRyaDdReWZ4?=
 =?utf-8?B?Y0R4eGNPTm9DMGZmUGx2YlhKR2hnczQrREdYMGo2OXlBT2x3NGhqdDZUOGgx?=
 =?utf-8?B?c1d0QTlrenQ3dVJaVWhJSlpnV2o2bHBkUVp6bjVMa0Q1YkVuVXRWUURMZm50?=
 =?utf-8?B?NmQwSE5ibC9VVWxXVjV0b2J3MjJaWkJ0NVpsSDBoblVBSisyTDMrTFJmVzE4?=
 =?utf-8?B?dlZqSmVGc3U2eGtoL2Q2Nm02YnVNVTg0a3hRNHZnUDhxM2ljVk01N0l1S2lq?=
 =?utf-8?B?ZGNFajBlRGdMRjNWc3YrL0hkQnlLZzZIUERHZXZJNVRpWG1XVHBXNzR5Z0FK?=
 =?utf-8?B?K2dzVUx5OGF2Z3FPbFpxSEYzdytqTTJBK2xDMWZLc0VyYXlMYU5pZUhpTGc0?=
 =?utf-8?B?bktCdzBMZm0yMVU3QWVmQ2hibG45RWJMV1czK0Rld2ZVV1ZEbGE5WHBhcTZG?=
 =?utf-8?B?YlNlZE5Jck4wZnRiYlpuamp3czVkT3VVWEIwQ1pNeVQ0WVdrNXZCcEtwRGdX?=
 =?utf-8?B?MnVaQjFMYjVQNVE2YzVZeGVxbkxXUmhzeEhIU2ZzTjh4OStqOG9JdHkzYm9i?=
 =?utf-8?B?V1ZCdnhQTmt6TGlIU3c1ZEtNSWhoQ1N4K21TYllLbFlKOUZ0Zkd6bXhKRkdq?=
 =?utf-8?B?c0dDZDNhdytSTTVLM2pKYkxuYzJiMkJxZ0Y1UXRFYUdhazAzL1dTQTZ3ZjND?=
 =?utf-8?B?OFIwWk93RWJpRnZpWjdoN1J5YngvMnNLU0lNNWtMZzJmUi9YaXh5dUFXK2Q3?=
 =?utf-8?B?SVhNV2VnaUMrcGpHQ0Q0bGUyejUzZnJscmFlTkZHR09KV2R4Sy9GZEpsSWQv?=
 =?utf-8?B?U1lQcUJlY3pMS1J5SDZZd3orTG9vWkZhRW91YWxlTDducXp3all4c1dWTFZO?=
 =?utf-8?B?UkM5dWNPR1dBdDBMMWpNbHl5cFRmMzNFTnA3cDgrb29BeVkrcmx4VlV5dlU2?=
 =?utf-8?B?SFFhMkUyVmJlanFlaXlmU21MZlRpVkRiMFN0c01LNWxRS1Q3MXNOdWU1clM2?=
 =?utf-8?B?clVuMzd1U0VDazVKRmRYTzF6aXNkMkpKYm5QMXFaRFRiSUZiY2FSQ09vamIv?=
 =?utf-8?B?MDVLcEZQbnBWODFKWHBoVUFFWCt3VUZCbS8xNUpQZFFWKzQvQXlnUDRpV2Jk?=
 =?utf-8?B?QWp2WE9EK1ZyZk5Wd0FrQXRseFJUZEtRUzFnaUtDT2lYblJoZk5pcnFuOHp5?=
 =?utf-8?B?VXV0d1FXVHBSUjltQ1dTbXpSNFhsMVNpZGRZK3JocG5aeFhKYUp6c2U4clZI?=
 =?utf-8?B?bk40bVRSL2VtWGRtdVQ0L3lQcVgxNkVOeW5iS2F4RVkvVG9hb0NjWTBKOGt4?=
 =?utf-8?B?c1k0STIrRjRZOXFsbnM0WHgvSzZaVFdWU2hsa3BCTFZwUXBYaVQyNU5KS2Jk?=
 =?utf-8?B?VEp4Z0FLYjBrRVBKUU5KbllsNjAxK0o1YUxsSTRBdVJ6ajJXcGNqb0VnTHhM?=
 =?utf-8?B?M2tHZExNWmdIL3hLamJ6dmZtVU5PbEREWE5TNGx3S044b05HZ3R2UU1BWExK?=
 =?utf-8?B?VktkVzBtZUVhNzZDdGkyQ2JvTGg3Qy9NRVB4K3FPcDlINW5zNk1CQ0x1TXVx?=
 =?utf-8?B?Z3lpeDdkT2F5SUNDcUYwdnB2c0Mzc1FHMVZiVlczMVJYNnFRTzJSdU1iYlNl?=
 =?utf-8?B?NVhZd1NoTVF1RVNua0hsWFY2enhHS0MrYjVnd2VrMGhqYW05a2VjSXJSQUJz?=
 =?utf-8?B?aHdYOFVMcDJJaDVOSUpoYk5KQTVoZVVxbUJyUXhpcDluSHRRb1kxTkNqSFR3?=
 =?utf-8?Q?VG6y0A+raPNCnqfUoU2PVgYHbbqlv8=3D?=
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:IA3PR11MB9136.namprd11.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(376014)(366016)(1800799024)(38070700018); DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?S1l2WjhTUUNueEMybWxBNEpVY3hFMVB2WStubW9mc1dTd2tIRDAxVGNvditB?=
 =?utf-8?B?S0Evak1YNHZZRWNUaWg3d0E3STdhUWNxWS9HTWJNZ09hNkFkeTVJdTJwTkM5?=
 =?utf-8?B?UUNnbXdUVHlGV0xzZ1d4QTB4YmpWOGtqQ2pCcktiRE04WkorTXN6UmtWTjFQ?=
 =?utf-8?B?WmN1V2NHUlg5SjZWaURjb0NNeEM0M1ROUXcrQjFjYVA5enVERDFPbWFMaE1h?=
 =?utf-8?B?R215YVdvSmZ1ZTBOWFhwN2w5SXoyMDRWOHVpVjRkWk5ydkVxMWFkdU4rNTJm?=
 =?utf-8?B?clVvQTlQNnk2T3R0S3kyT3EraWplTVRDajRlRlVSUEUyaDFxK3V5S2lSL2FD?=
 =?utf-8?B?QjRqMXltYnFzNDdUbXlvTksyMGRGM1JCSjJWMWZpNEhoVGdSSGxYYXRGS1RB?=
 =?utf-8?B?OFJYUk9EQURJcjJENzRJUlM2STRaU0JLSlZoMzlYSkZRUnpyaEpNZDZnd24v?=
 =?utf-8?B?Wlk2Y0JvdGdtcTBsZzFuTEF4a3p4clZLVWlabjJQOExvNWxUbXdrakZyNDgy?=
 =?utf-8?B?L1VIUWE4TkdjZEpnMzhYcHlQUFpmY1ltWjc3UzlidnR4cURRMGVwMVBQbkpU?=
 =?utf-8?B?TFUwc1BFN2dCMDVSWjBNTVczQmUwKzRkRE81aFNKOGYzNlhoaWFkRkk2elF1?=
 =?utf-8?B?KzlrT1FYd3lKMXAzRkFFUVY2a0F2T0FuR1FJcGE0Vzcwb21pcHAvRXNjZE5K?=
 =?utf-8?B?anNLRlJSelRPejB5YmhxcGVJNWlzTW9rUS9URGdHMXQ4UUdsZ1RnZkNNazNN?=
 =?utf-8?B?SnEveTZzUzlyNU43T1BJTERkYW9Hb1RiVHRNRVRwbXdXZzl2aWg5WHRRSmlm?=
 =?utf-8?B?MlZ4YjhjdVFvRDFNcTlxdkpzUjJzWXUzT3ZpRzZaOHBOdjhQYkxaMDgyVGxs?=
 =?utf-8?B?bVN0bHhyaVhDaE84Z2ZYaURuVGRYd2hqN1BhMHpBNHFaU3JaMEhXKzVVQVd0?=
 =?utf-8?B?YXdXQkpkTFk2WW8xNUxRQVJKcjd3L0VlZDljUklVMGJ3Q3BqL2d5Z0tXMDJy?=
 =?utf-8?B?M1ZLeVhnQTFCdUVQeW5UbE5pbjJibFBNTjRnUVA2b0c0eklBNmR0bmRNdTRS?=
 =?utf-8?B?dlowMkd6OU9pcm94cXRva0kwZzd1L3NITE9hS1dCVzBvVTExSGxZM2VKbEdG?=
 =?utf-8?B?dFg3aVRXUDh6UzZ2TlQrb24zTGtJNmNYUEpJTnlkd0hxQk5vbnpSYythWHNY?=
 =?utf-8?B?UVlIT1RDWE9rcEZqMnZleExuZ2tCS3Q1djlDY3FBUWJWbEtzRXhSdW5qcUhZ?=
 =?utf-8?B?d08zdURrck1LZUI4WDZJUjdES0NRaitlVW1kYXplcnczOUlFQzRXdmh2K3Qv?=
 =?utf-8?B?UmNQS2pvOStIbi9tUEl2SndGNmRORSs0Nk1uSk94UHJaeko4MDhuNWRyL2h4?=
 =?utf-8?B?UEU0aHF4SVQ2UWdTYXphRnVERnRVSHZvUGJPa3A3K0pvSm9wQjUyc0cvdEt0?=
 =?utf-8?B?V2FRUW93MzN6MklMaThrRkNlOTNYMU80WnVZQjJueGxORkdybittY0U3M281?=
 =?utf-8?B?Nmt4dlBNUG0zYW1Nb2RSdWlvNWpvcm1SamxXRk9UbEp1VjlxaG1OZTErbFJR?=
 =?utf-8?B?eGVvNlJiYmlZWTdlcDZncTlIdWZiZGZXTmNHMVRTZTJ1NGJlRWl0dXNsUVFX?=
 =?utf-8?B?YlY3aXM3MnllcGNFUXRmTENGb3VSQUdNZTJ4b3lrTi9lWksxM04zMGx5SjFS?=
 =?utf-8?B?VFZ5R3E5QTE0bFJXTkl5NmpBbXJoSzlubHg3SHJ3emxVQkJ4emIvR2F5eWJE?=
 =?utf-8?B?cUhDeHFYSEZ0cWVkbmJvdkFWVWdyaCtmWGJvTndwd3RLOVZyN0xKNVdQMlQ5?=
 =?utf-8?B?dkdQdDdUZWFJSmV1bVZxSXdsWHRRRDVQMkU3dGJQM0U5aTJsMy84OTRNSG5t?=
 =?utf-8?B?cXRzcjlZQmRSeFBkazB0dDFhY3RRZmtGeENLeGcwaS8rYTVMeGkwYkp3TTg2?=
 =?utf-8?B?Q1NzMjBxSHE0Vy9MNTlFMkMzbzlwT1FPWGtiODFzeXAxenlvMmxRODBkTTZk?=
 =?utf-8?B?TlhJS2tDL2lzOXJmSDl4K0hwZEdOeDV6dk9FVlp0R3puL2xielhYZ2NPbnc3?=
 =?utf-8?B?WjFGSmhaRzAyelJvYnp4dkx6Zm5OSHppME1MWHc2UkVQR0hhNFZrNzNTMGh1?=
 =?utf-8?Q?fxiMPPQRZlJNoc/k8CkQxf06Y?=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: IA3PR11MB9136.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: a0ad49da-1cd1-475e-13b0-08ddb22f915f
X-MS-Exchange-CrossTenant-originalarrivaltime: 23 Jun 2025 08:25:52.8237 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: iQi5MuYZQpnfVbP9ODqKBt+jTaA0I39Aczy1VvhFpiS3wotO8YXWTF3cPgoGmutfz5pO9e4v0RGNyrp1H24wWpcY0/+HPO2+fh83meRj4SA=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH0PR11MB5064
X-OriginatorOrg: intel.com
Received-SPF: pass client-ip=198.175.65.17;
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

DQoNCj4tLS0tLU9yaWdpbmFsIE1lc3NhZ2UtLS0tLQ0KPkZyb206IFN0ZXZlIFNpc3RhcmUgPHN0
ZXZlbi5zaXN0YXJlQG9yYWNsZS5jb20+DQo+U3ViamVjdDogW1BBVENIIFY1IDI2LzM4XSB2Zmlv
L2lvbW11ZmQ6IGludmFyaWFudCBkZXZpY2UgbmFtZQ0KPg0KPmNwci10cmFuc2ZlciB3aWxsIHVz
ZSB0aGUgZGV2aWNlIG5hbWUgYXMgYSBrZXkgdG8gZmluZCB0aGUgdmFsdWUNCj5vZiB0aGUgZGV2
aWNlIGRlc2NyaXB0b3IgaW4gbmV3IFFFTVUuICBIb3dldmVyLCBpZiB0aGUgZGVzY3JpcHRvcg0K
Pm51bWJlciBpcyBzcGVjaWZpZWQgYnkgYSBjb21tYW5kLWxpbmUgZmQgcGFyYW1ldGVyLCB0aGVu
DQo+dmZpb19kZXZpY2VfZ2V0X25hbWUgY3JlYXRlcyBhIG5hbWUgdGhhdCBpbmNsdWRlcyB0aGUg
ZmQgbnVtYmVyLg0KPlRoaXMgY2F1c2VzIGEgY2hpY2tlbi1hbmQtZWdnIHByb2JsZW06IG5ldyBR
RU1VIG11c3Qga25vdyB0aGUgZmQNCj5udW1iZXIgdG8gY29uc3RydWN0IGEgbmFtZSB0byBmaW5k
IHRoZSBmZCBudW1iZXIuDQo+DQo+VG8gZml4LCBjcmVhdGUgYW4gaW52YXJpYW50IG5hbWUgYmFz
ZWQgb24gdGhlIGlkIGNvbW1hbmQtbGluZSBwYXJhbWV0ZXIsDQo+aWYgaWQgaXMgZGVmaW5lZC4g
IFRoZSB1c2VyIHdpbGwgbmVlZCB0byBwcm92aWRlIHN1Y2ggYW4gaWQgdG8gdXNlIENQUi4NCj4N
Cj5TaWduZWQtb2ZmLWJ5OiBTdGV2ZSBTaXN0YXJlIDxzdGV2ZW4uc2lzdGFyZUBvcmFjbGUuY29t
Pg0KPlJldmlld2VkLWJ5OiBDw6lkcmljIExlIEdvYXRlciA8Y2xnQHJlZGhhdC5jb20+DQoNClJl
dmlld2VkLWJ5OiBaaGVuemhvbmcgRHVhbiA8emhlbnpob25nLmR1YW5AaW50ZWwuY29tPg0KDQpU
aGFua3MNClpoZW56aG9uZw0K

