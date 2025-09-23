Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C3649CAC5B0
	for <qemu-devel@archiver.kernel.org>; Tue, 23 Sep 2025 09:51:19 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1v0zfT-0006Eh-91; Tue, 23 Sep 2025 05:50:39 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <zhenzhong.duan@intel.com>)
 id 1v0zfN-0006DR-Vt
 for qemu-devel@nongnu.org; Tue, 23 Sep 2025 05:50:34 -0400
Received: from mgamail.intel.com ([198.175.65.9])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <zhenzhong.duan@intel.com>)
 id 1v0zfF-0007IH-IZ
 for qemu-devel@nongnu.org; Tue, 23 Sep 2025 05:50:32 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1758621026; x=1790157026;
 h=from:to:cc:subject:date:message-id:references:
 in-reply-to:content-transfer-encoding:mime-version;
 bh=NAcIfR/QMzDHtpgtV7j+FMP4pe5lrmQJ6kkYI0dMiwQ=;
 b=ZCKFkISwXsIPQ4ejvBo20mSAZawI8QWLF9HAuwueXoslqw4VRgD+FhN8
 b7vdWnn7JYGDDFSrueRPxWodFQMIuLumxujlLHkEOI5TGkKAWrpLZxyfX
 asoCQMFUfzDHC6eFFN1REcze9JpCrE8eVDYIv7A8yaqcE0o70eEcUbUhF
 u5sHXxDwGeHygGkBxHNYXHUII4+xZb4qsmXwyMntH636oqG2LNTVFrZyj
 KhBVBGXhIXAASI96L0kgjCjGJr2m4i3be9VaU8lF5gcPppwWMJi7c0GbV
 TTsvZZ3XqD6UJILZtD+0YFpLv0N2OodL0MHCURP0yPJMuiZa3DWYO0wBV g==;
X-CSE-ConnectionGUID: 49BJqXlJQOuoEpnJnc6xdg==
X-CSE-MsgGUID: vHxqr1mBSb21PD+Iy6a98g==
X-IronPort-AV: E=McAfee;i="6800,10657,11561"; a="83500381"
X-IronPort-AV: E=Sophos;i="6.18,287,1751266800"; d="scan'208";a="83500381"
Received: from orviesa010.jf.intel.com ([10.64.159.150])
 by orvoesa101.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 23 Sep 2025 02:50:19 -0700
X-CSE-ConnectionGUID: mDnnObXCS3ig5f8m+A301A==
X-CSE-MsgGUID: a0H2xC+QRtqjNMYTdS9EIA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.18,287,1751266800"; d="scan'208";a="176014593"
Received: from orsmsx901.amr.corp.intel.com ([10.22.229.23])
 by orviesa010.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 23 Sep 2025 02:50:19 -0700
Received: from ORSMSX901.amr.corp.intel.com (10.22.229.23) by
 ORSMSX901.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.17; Tue, 23 Sep 2025 02:50:18 -0700
Received: from ORSEDG901.ED.cps.intel.com (10.7.248.11) by
 ORSMSX901.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.17 via Frontend Transport; Tue, 23 Sep 2025 02:50:18 -0700
Received: from DM1PR04CU001.outbound.protection.outlook.com (52.101.61.45) by
 edgegateway.intel.com (134.134.137.111) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.17; Tue, 23 Sep 2025 02:50:18 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=v+dhLvEtY7aiPREV8hC0P3ATzXT+znP2hN1mn7CW8/lZngznjE1Rf+YBUyiZ9anRAYxc1Q2oHiMfboS/p/r6Me3BjUm674eyLJ7aGhfUEIGkYi6SMBmsssEaRWffv9VlAqFWebOD82E0p31kjUyW0ECHpH3Q0spPO+pHMS5vhrE3LJFoPZcLaARohtp5D6L7DTvOYRqGwIsJulu1KDE0OTCw5BL6jeE7D08DvATcoDiQq2Udy+ODpAeBwSk/BMfIhhe3jKPFJ/mxJp4CiUYqodKgKc6IbHQRy3tCqOhbANafyWgWVTwgELIlBk1EehvjI9Yf+s0krfL8wKgNBn/hFA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=NAcIfR/QMzDHtpgtV7j+FMP4pe5lrmQJ6kkYI0dMiwQ=;
 b=YqLwMq26ngjt59xmaxyKHOfvToyrp8JosqfIAREAFIJv2Xv7lPt5oTHo7aGmxNZH08jes1e7vXsaw2wwIGXV0gvhuARuS9Bcu40JOGqnLAPLwMPmCF6F0gF7CfSwCdREJpQiEmDTC66rBAoLuQWizFaCzNeVL8mqUEczOsp4XIQGPhPptxvniB/V3uOGsf/ei59benjddITtnZGGQ6Nn7b6jsacEEN0k04g/vWpfb6InEoCV56xQt+T6k0C5YPZMtowJ1QQJffUyY21PvnX+r8sMCsEdwFihfNVWkUAaAn7C9RkbPeU6SH/OLsf8moQv+vTmDmaf+3FTovFe9jMkRA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Received: from IA3PR11MB9136.namprd11.prod.outlook.com (2603:10b6:208:574::12)
 by SN7PR11MB6728.namprd11.prod.outlook.com (2603:10b6:806:264::9)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9137.19; Tue, 23 Sep
 2025 09:50:15 +0000
Received: from IA3PR11MB9136.namprd11.prod.outlook.com
 ([fe80::604b:77a4:b1be:3f13]) by IA3PR11MB9136.namprd11.prod.outlook.com
 ([fe80::604b:77a4:b1be:3f13%4]) with mapi id 15.20.9115.020; Tue, 23 Sep 2025
 09:50:15 +0000
From: "Duan, Zhenzhong" <zhenzhong.duan@intel.com>
To: =?utf-8?B?Q8OpZHJpYyBMZSBHb2F0ZXI=?= <clg@redhat.com>,
 "qemu-devel@nongnu.org" <qemu-devel@nongnu.org>
CC: "alex.williamson@redhat.com" <alex.williamson@redhat.com>,
 "mst@redhat.com" <mst@redhat.com>, "jasowang@redhat.com"
 <jasowang@redhat.com>, "Liu, Yi L" <yi.l.liu@intel.com>,
 "clement.mathieu--drif@eviden.com" <clement.mathieu--drif@eviden.com>,
 "eric.auger@redhat.com" <eric.auger@redhat.com>, "joao.m.martins@oracle.com"
 <joao.m.martins@oracle.com>, "avihaih@nvidia.com" <avihaih@nvidia.com>, "Hao, 
 Xudong" <xudong.hao@intel.com>, "Cabiddu, Giovanni"
 <giovanni.cabiddu@intel.com>, "Gross, Mark" <mark.gross@intel.com>, "Van De
 Ven, Arjan" <arjan.van.de.ven@intel.com>
Subject: RE: [PATCH 1/5] vfio/iommufd: Add framework code to support getting
 dirty bitmap before unmap
Thread-Topic: [PATCH 1/5] vfio/iommufd: Add framework code to support getting
 dirty bitmap before unmap
Thread-Index: AQHcIfvimBrBaa+XB0KbskuA8pwIdbSaTDWAgAHZT1CAAsvsAIABMVswgABKiYCAACyLUA==
Date: Tue, 23 Sep 2025 09:50:14 +0000
Message-ID: <IA3PR11MB91368C70CDC1C2F21A058AB4921DA@IA3PR11MB9136.namprd11.prod.outlook.com>
References: <20250910023701.244356-1-zhenzhong.duan@intel.com>
 <20250910023701.244356-2-zhenzhong.duan@intel.com>
 <ee5c9d7c-a85e-4da4-bd5a-a59951a19a06@redhat.com>
 <IA3PR11MB91368AE2A58185BE00627E149212A@IA3PR11MB9136.namprd11.prod.outlook.com>
 <e0a2c3f0-eb14-4d06-9658-23208ee6e870@redhat.com>
 <IA3PR11MB9136A7B487A547CB5EAD9FEE921DA@IA3PR11MB9136.namprd11.prod.outlook.com>
 <d1345c59-e9aa-479e-a71e-aa1f427bd059@redhat.com>
In-Reply-To: <d1345c59-e9aa-479e-a71e-aa1f427bd059@redhat.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: IA3PR11MB9136:EE_|SN7PR11MB6728:EE_
x-ms-office365-filtering-correlation-id: a4f12993-3cbb-4b14-957b-08ddfa8698a5
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0; ARA:13230040|366016|376014|1800799024|38070700021;
x-microsoft-antispam-message-info: =?utf-8?B?V001RHYwTExReHh6Y3ZEeXhZWVJBNjJPeG5XRHEvU2Rab0xxaitkeCtQNHpt?=
 =?utf-8?B?WWZoenozM2JteTFsYXlJQ2tKaTFVQzNqdWtmREk0YjNVcFNNeWRwblBPUDZG?=
 =?utf-8?B?aC9JNlhkWTRYalV2NXEvWE1zZ0x5dCs4VjVNV2VNTVU4aVdtK051YXdBbEtI?=
 =?utf-8?B?cUZTYkxiUnphV3o1L2VDMnVNbVB5elAzc1p5dm1VTVR4cUdIR3pGaWlNNVdp?=
 =?utf-8?B?Mmh6UHpIQ1FyLzN5YitSUSt6TFdBZHUwRzljV29xWEFwY3k4SnVxNFJiSXNj?=
 =?utf-8?B?UTBYMThCOFZSUWQwT05qQ1F2L3pNeHNHdVlsbXJ3VW43RGFxaU5zWnNYUm43?=
 =?utf-8?B?K3ZlZmQySm9GQklOT2NSSHNlQzJCbUVDcUdIY3Y4WUJMdmpTSTZIRzdrZWsv?=
 =?utf-8?B?dFAvMTJkNnd6TVE3MlBnZGZOdlV5ZGQySlBEOEtQdTI3YXMzYUkwNHZaajBl?=
 =?utf-8?B?Sk8vaDZGNWRvOGdYRlVKRW1HSC9Cd0xCdFpEVWhqSStnYmJadzRlNGlEV0V1?=
 =?utf-8?B?MExBUCs4Z05tOFVBZitudmhqYkJvRnNhRHZyY1BKc1gyc3o4aE11NWhTYnNV?=
 =?utf-8?B?SE9JWm1wdk1xUUxVQlhmUThpOW1Ebyt1U2FMbmxmVENRZmMxc3F2eitHc3dQ?=
 =?utf-8?B?RG8rclBLRmlHRG1pK2tUMTh2STcvajhTYkRhWkpIRU9TQ08vU29NWnMrR01E?=
 =?utf-8?B?WXVKQVdHVnVPZUZnaTNyejBuZWgreVlDZW8zb3V2cXQwaDd3d1BGcWZIS0Zq?=
 =?utf-8?B?SmlTQzQweUgxUkI0SXh1QTlRM3g0by9VRTJRSTRRczVaNStKSVAxUUNxNkdi?=
 =?utf-8?B?eEkzaGt2Q3Q1anNNVkswZlRHUGxBSVRoajYvNEp4d2pKc0ZXZlRiYlhMWmdW?=
 =?utf-8?B?SDYzUVdoV0VnMktkblYwQU1TUFBKdnp6NzV3WHMza2h5c0VNUGN5azVlcWFl?=
 =?utf-8?B?amVOVHZ4V3pTSFlyMG1Ma1V5ZjFYb2Yzd0ZnZDNFYjN0NjJtN284ZEZvQ1NJ?=
 =?utf-8?B?ekpYNW5GcWN2blFQQXlValc4eWY3VnY5dzhvb2dZQ1JmZmQycjMreDUreENv?=
 =?utf-8?B?d3NJdTYwVXV4ZFFpVDArcXNncG0xdTlVRSt5MGFXYnJzVnZGSDJPb0pLLzhP?=
 =?utf-8?B?aWplamU3RldGYy9pV0R4WGJZa09Jd0lGNVlrZUJBTS9rQmVxMXhVSHhwVjZh?=
 =?utf-8?B?dlZHVzhyd0l0OTZsb1JSWUFpQnVCWEpWTFJYdFJ5SVkyaVE2a3JjckUyb0Za?=
 =?utf-8?B?SlJBdnFxVlYvRGgrVDIvb2F4UlJ5VEtZWTZzSVMxTFY1YkYwN2txelFKcDlx?=
 =?utf-8?B?ZUhST21rTWd5aVJORmdRSVJWbVRDcjE1Q0c2Z0tQVFNSdUkwQjdJdGV6UTlK?=
 =?utf-8?B?S0NIczRPMnZyaFJuQWZnNGkrREtZWUxKRkYwdkVUR1Z3SWRvaGpzeGJ0eDho?=
 =?utf-8?B?WkFIQVF3Q0NiUGtidTNXTEVXMUo0eXpNeW1tNWxKcWtSQ2NvbWp5blF5ODFR?=
 =?utf-8?B?NDRmNitQQm5pZHM1dlRuK3J4cE9Tcit3MEVxS1U1S2RtL2lXUHM0T2VBdmYv?=
 =?utf-8?B?SUlpZFFHQkg4bHBvY2prMElCOVVmVE5LWlhQR25HbHN2T2JKQSsrbXpIblVS?=
 =?utf-8?B?NG1tLzBZbVZUa2pVWWh2MkwvYzhFM2ZMVTBvNGxxNjUzT1ZyTkdCdDFjdmEv?=
 =?utf-8?B?cEl2NTF3TStTUW1wblBsdWRLME9IMkliMVlVazJsMGNPZHJvT29ITzFrYUIv?=
 =?utf-8?B?cVErWVhaOGc4blhVU1ZhRk9uK2V0anNjeEI5RDBnYVA5emcrUDNLNlEvZVBa?=
 =?utf-8?B?ZXJ1SDM4RTR6N0JhbUYrb2dta2IrVUpQSWUydXdoTnZBOXRuYlFNbkxQanlO?=
 =?utf-8?B?SWcyZktvTkxXMUV5R0x5VzNXdE5mUENXR2hDYXlsOFhSSFVDQ0JiZmhhZTQr?=
 =?utf-8?B?VGg2TDljWGhhVlgrdWw1WUlyRjFhcjVpMnFGMmJ1R1hJNGQ5OXlhcUkvaWhi?=
 =?utf-8?Q?nfxXEWgtUmvr/FMnRpsvq8lBqIHGCE=3D?=
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:IA3PR11MB9136.namprd11.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(366016)(376014)(1800799024)(38070700021); DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?enF0M29nOWgrNkt3Ymd2UTRwTVlWdEd4ZzJjRjJkQ1BxTXBGNmpQM25nZXlF?=
 =?utf-8?B?czA5cVc2RDU3NFBYMVBOL2NaUkRNR01TUDFldTFhVC9CbFFCeC9XaTRsZjQ1?=
 =?utf-8?B?OUdQOWNqUHJHM0VuZmtROHM5eHBTYzVaR2JPSmZCblgwRWdXaUN6QjFyblBM?=
 =?utf-8?B?VHlyRXYvL09UOE9uRm1iYktZT0UxWVRRcU8zRXBlUUYzSkowVXRrREsrWXZC?=
 =?utf-8?B?YUsxZmlGSER3QjdUeXRNQVdqQTFDNDN6RG5RVFNvSjJ2T216dzhEOURYbU5l?=
 =?utf-8?B?Y1B5WWZGc2hiZjMzSGtlWkN1bFBycVRicE1xWldmeTgzcVllYlJSUzJuU3l5?=
 =?utf-8?B?dW9zVmhNSzlRYkxLVlFKTk5XTHZXZy9nZDlUeDVtWXNyZk1TdFVmbWx2Q25U?=
 =?utf-8?B?MXZGSXpWcXo0Qit4NGpNM1N0UWF2bkh6MDljR2cxQTU2M1NFTEdBY3haWlBm?=
 =?utf-8?B?bFN0ZjdvWXVyOHlBZ3V4MzBvWUZVRTk5Sm15RzUxZEpTTzY2L2tlUGxCTGZO?=
 =?utf-8?B?MlhXK2R6L1dCUEZmQS9aRGg2bCt1ZFBXQVFjVG5qbWs1ZSt2aWpBNnJUaW9S?=
 =?utf-8?B?dmNVT3VuT0t0V0gyUkxSRmEvUHdsSlJqbk4zTXhlTEFoUzRQU3hnSjZDUW8y?=
 =?utf-8?B?YWhtbDRXcmFBMVRybUgrMmV5RUZpOVQ2VlFmWXRVdVEyZnFBYkcxYkV1MVhq?=
 =?utf-8?B?ZzdORU1IRmtnR1huSERiWmtKenFkajlJYTZ2SEt4b3FEUTZYVTZDUTR6ZlVn?=
 =?utf-8?B?bFNlcitseFNKMFhIN1RsZWEyZWdlY1N2ZGhUbE8zNXZJUGxKU2tidU1DcTdF?=
 =?utf-8?B?YlZtR2NZRWhySFpkMjRIc3grRzFSc1dBdEVhRHhEczlEQzNONThqeFdFZ1FP?=
 =?utf-8?B?S205YktGMndPOHVYMEI2ejliaUZDaWZaSVM2QUZkcWJPK3d2dGZKTFhOWUN4?=
 =?utf-8?B?YnRhMVdBUlhyZE5JbWFnbnByNTV2aXdlcEQxU0Z3SXd6aWUyQUR2RDRUTVBJ?=
 =?utf-8?B?K1hIQ0M4aU5XUWVhWjFqaEIzYk9sVlFGVzRaNjd0LzhXWVByTUI4bHBIbWNr?=
 =?utf-8?B?ek5tZ2NSVWlPeEdhMWlVTWJoOW52bnpvKzdyRmtGcXRLdHJoQnl3cllOS0Ev?=
 =?utf-8?B?RlZOczViSGtlb2ZoREliTVRHZnZxYjF6UnNJTFpJT2x2eDQveGJwQi9BYTBB?=
 =?utf-8?B?TkJ6YWFsMmlpL0ozSnk5a1RlcTVPZmdLTzVCVG56Yi9zUWVkSlNGRURTNXg5?=
 =?utf-8?B?U1JlQjdLTmtJRExmUkRoVXMwSHcyVlRoNE0wa0oxNGFVNm9WdlgxM2hhai9H?=
 =?utf-8?B?bXpma0Y0Zyt3TW5OWHh1MldoaXMvYmRLemlwdVFLckF5R1kyMGpiYWFtdVhL?=
 =?utf-8?B?U0YvdDhxdEJ1WXZGOXcrNDRiVnNWUHNTNjlvZkIwZU5IcndiWURhZ0xzL3cx?=
 =?utf-8?B?Skx6RVJ6ZjJsd0NzaFJ3TlMwejYzUkFCdnBWOGhTZkFPdG9nRFAyMlVLbFVM?=
 =?utf-8?B?Q3BVVCtCYmdZSkVEUkZZUll3VUIyTXIzdmVKSGt5dXpVanpvTGtHUFhMbGk5?=
 =?utf-8?B?Mmc2UUFJakp2NCtvMXZuY0VnbDZ5cWdHY1RFUmh6OFVRVFdHTW55VGp5YXVl?=
 =?utf-8?B?YkpqVjlSUmliOU44MGxuT0dLdDNKakFDbUhmb0NJVzdtSGJZMG1mYmd5ck5L?=
 =?utf-8?B?K0E4WnF0a1pkLzdUM3hEUWUrazdJd1NOSFJhT1RtSlM4L1RYYXZBdnZsRzhk?=
 =?utf-8?B?c0hjdFBCWm5jQjBVZDJxdUtWYVk5anlTV2M3TGpQeE94NGNIRDZJZUgrd3NB?=
 =?utf-8?B?eGlQbW5ZZ0h4SzNVb3FJMFZLNGtoWWlzajJKUzJBNG93WDJhbkZBbXA3Q0Jx?=
 =?utf-8?B?LzZVZ29tRzVRMHVxRy9tMkxqdmc2V1hBV2VicktHaW1vdjRqb1VIZzA2YTh5?=
 =?utf-8?B?ckdac1pKQkVwRDZLMmlpcStaV1FaK3hmUDZmS1BZdHZqWWNGa3MwS01IcDBL?=
 =?utf-8?B?NTY3UzV4MG5udEZtd1lWNFN0VDE1UzdWbTlSb2FVakVzZFBYSC8welR4QVgv?=
 =?utf-8?B?U2dRRFFrTlpqcDZ3ZTVQQ1lkV3dsVmsxaENiV1pOMHFReUhOV0tWWTJiZkhl?=
 =?utf-8?Q?ohhcmhn8tpKPWLK+mL9zxoupE?=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: IA3PR11MB9136.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: a4f12993-3cbb-4b14-957b-08ddfa8698a5
X-MS-Exchange-CrossTenant-originalarrivaltime: 23 Sep 2025 09:50:14.9569 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: tFYLc3ogimjIqW8qFzHSwjp3mnj+3WmYIEDzF1bnIcv1PvshDg3QoNWdaiqN/bCePPX9UtnT8nOFNdQPjB5/Gsh5EQdWrhl5BHYddLEdxwQ=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SN7PR11MB6728
X-OriginatorOrg: intel.com
Received-SPF: pass client-ip=198.175.65.9;
 envelope-from=zhenzhong.duan@intel.com; helo=mgamail.intel.com
X-Spam_score_int: -47
X-Spam_score: -4.8
X-Spam_bar: ----
X-Spam_report: (-4.8 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.442,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_MED=-2.3, RCVD_IN_VALIDITY_CERTIFIED_BLOCKED=0.001,
 RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001, SPF_PASS=-0.001,
 T_SPF_HELO_TEMPERROR=0.01 autolearn=ham autolearn_force=no
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

DQoNCj4tLS0tLU9yaWdpbmFsIE1lc3NhZ2UtLS0tLQ0KPkZyb206IEPDqWRyaWMgTGUgR29hdGVy
IDxjbGdAcmVkaGF0LmNvbT4NCj5TdWJqZWN0OiBSZTogW1BBVENIIDEvNV0gdmZpby9pb21tdWZk
OiBBZGQgZnJhbWV3b3JrIGNvZGUgdG8gc3VwcG9ydA0KPmdldHRpbmcgZGlydHkgYml0bWFwIGJl
Zm9yZSB1bm1hcA0KPg0KPk9uIDkvMjMvMjUgMDQ6NDUsIER1YW4sIFpoZW56aG9uZyB3cm90ZToN
Cj4+DQo+Pg0KPj4+IC0tLS0tT3JpZ2luYWwgTWVzc2FnZS0tLS0tDQo+Pj4gRnJvbTogQ8OpZHJp
YyBMZSBHb2F0ZXIgPGNsZ0ByZWRoYXQuY29tPg0KPj4+IFN1YmplY3Q6IFJlOiBbUEFUQ0ggMS81
XSB2ZmlvL2lvbW11ZmQ6IEFkZCBmcmFtZXdvcmsgY29kZSB0byBzdXBwb3J0DQo+Pj4gZ2V0dGlu
ZyBkaXJ0eSBiaXRtYXAgYmVmb3JlIHVubWFwDQo+Pj4NCj4+PiBPbiA5LzIyLzI1IDA1OjE3LCBE
dWFuLCBaaGVuemhvbmcgd3JvdGU6DQo+Pj4+IEhpIENlZHJpYywNCj4+Pj4NCj4+Pj4+IC0tLS0t
T3JpZ2luYWwgTWVzc2FnZS0tLS0tDQo+Pj4+PiBGcm9tOiBDw6lkcmljIExlIEdvYXRlciA8Y2xn
QHJlZGhhdC5jb20+DQo+Pj4+PiBTdWJqZWN0OiBSZTogW1BBVENIIDEvNV0gdmZpby9pb21tdWZk
OiBBZGQgZnJhbWV3b3JrIGNvZGUgdG8gc3VwcG9ydA0KPj4+Pj4gZ2V0dGluZyBkaXJ0eSBiaXRt
YXAgYmVmb3JlIHVubWFwDQo+Pj4+Pg0KPj4+Pj4gSGVsbG8gWmhlbnpob25nDQo+Pj4+Pg0KPj4+
Pj4gT24gOS8xMC8yNSAwNDozNiwgWmhlbnpob25nIER1YW4gd3JvdGU6DQo+Pj4+Pj4gQ3VycmVu
dGx5IHdlIHN1cHBvcnQgZGV2aWNlIGFuZCBpb21tdSBkaXJ0eSB0cmFja2luZywgZGV2aWNlIGRp
cnR5DQo+Pj4+Pj4gdHJhY2tpbmcgaXMgcHJlZmVycmVkLg0KPj4+Pj4+DQo+Pj4+Pj4gQWRkIHRo
ZSBmcmFtZXdvcmsgY29kZSBpbiBpb21tdWZkX2NkZXZfdW5tYXBfb25lKCkgdG8gY2hvb3NlDQo+
Pj4gZWl0aGVyDQo+Pj4+Pj4gZGV2aWNlIG9yIGlvbW11IGRpcnR5IHRyYWNraW5nLCBqdXN0IGxp
a2UNCj52ZmlvX2xlZ2FjeV9kbWFfdW5tYXBfb25lKCkuDQo+Pj4+Pg0KPj4+Pj4gSSB3b25kZXIg
aWYgY29tbWl0IDU2N2Q3ZDNlNmJlNSAoInZmaW8vY29tbW9uOiBXb3JrIGFyb3VuZCBrZXJuZWwN
Cj4+Pj4+IG92ZXJmbG93IGJ1ZyBpbiBETUEgdW5tYXAiKSBjb3VsZCBiZSByZW1vdmVkIG5vdyB0
byBtYWtlIHRoZSBjb2RlDQo+Pj4+PiBjb21tb24gdG8gYm90aCBWRklPIElPTU1VIFR5cGUxIGFu
ZCBJT01NVUZEIGJhY2tlbmRzLg0KPj4+Pg0KPj4+PiBJIGFtIG5vdCBjbGVhciBpZiB0aGVyZSBp
cyBvdGhlciByZWFzb24gdG8ga2VlcCB0aGUgd29ya2Fyb3VuZCwgYnV0IHRoZQ0KPj4+IG9yaWdp
bmFsDQo+Pj4+IGtlcm5lbCBpc3N1ZSBoYWQgYmVlbiBmaXhlZCB3aXRoIGJlbG93IGNvbW1pdDoN
Cj4+Pj4NCj4+Pj4gY29tbWl0IDU4ZmVjODMwZmMxOTIwODM1NDg5NWQ5ODMyNzg1NTA1MDQ2ZDZj
MDENCj4+Pj4gQXV0aG9yOiBBbGV4IFdpbGxpYW1zb24gPGFsZXgud2lsbGlhbXNvbkByZWRoYXQu
Y29tPg0KPj4+PiBEYXRlOiAgIE1vbiBKYW4gNyAyMjoxMzoyMiAyMDE5IC0wNzAwDQo+Pj4+DQo+
Pj4+ICAgICAgIHZmaW8vdHlwZTE6IEZpeCB1bm1hcCBvdmVyZmxvdyBvZmYtYnktb25lDQo+Pj4+
DQo+Pj4+ICAgICAgIFRoZSBiZWxvdyByZWZlcmVuY2VkIGNvbW1pdCBhZGRzIGEgdGVzdCBmb3Ig
aW50ZWdlciBvdmVyZmxvdywNCj5idXQgaW4NCj4+Pj4gICAgICAgZG9pbmcgc28gcHJldmVudHMg
dGhlIHVubWFwIGlvY3RsIGZyb20gZXZlciBpbmNsdWRpbmcgdGhlIGxhc3QNCj5wYWdlDQo+Pj4g
b2YNCj4+Pj4gICAgICAgdGhlIGFkZHJlc3Mgc3BhY2UuICBTdWJ0cmFjdCBvbmUgdG8gY29tcGFy
ZSB0byB0aGUgbGFzdCBhZGRyZXNzDQo+b2YNCj4+PiB0aGUNCj4+Pj4gICAgICAgdW5tYXAgdG8g
YXZvaWQgdGhlIG92ZXJmbG93IGFuZCB3cmFwLWFyb3VuZC4NCj4+Pj4NCj4+Pj4gICAgICAgRml4
ZXM6IDcxYTdkM2Q3OGUzYyAoInZmaW8vdHlwZTE6IHNpbGVuY2UgaW50ZWdlciBvdmVyZmxvdw0K
Pndhcm5pbmciKQ0KPj4+PiAgICAgICBMaW5rOiBodHRwczovL2J1Z3ppbGxhLnJlZGhhdC5jb20v
c2hvd19idWcuY2dpP2lkPTE2NjIyOTENCj4+Pj4gICAgICAgQ2M6IHN0YWJsZUB2Z2VyLmtlcm5l
bC5vcmcgIyB2NC4xNSsNCj4+Pj4gICAgICAgUmVwb3J0ZWQtYnk6IFBlaSBaaGFuZyA8cGV6aGFu
Z0ByZWRoYXQuY29tPg0KPj4+PiAgICAgICBEZWJ1Z2dlZC1ieTogUGV0ZXIgWHUgPHBldGVyeEBy
ZWRoYXQuY29tPg0KPj4+PiAgICAgICBSZXZpZXdlZC1ieTogRGFuIENhcnBlbnRlciA8ZGFuLmNh
cnBlbnRlckBvcmFjbGUuY29tPg0KPj4+PiAgICAgICBSZXZpZXdlZC1ieTogUGV0ZXIgWHUgPHBl
dGVyeEByZWRoYXQuY29tPg0KPj4+PiAgICAgICBUZXN0ZWQtYnk6IFBldGVyIFh1IDxwZXRlcnhA
cmVkaGF0LmNvbT4NCj4+Pj4gICAgICAgUmV2aWV3ZWQtYnk6IENvcm5lbGlhIEh1Y2sgPGNvaHVj
a0ByZWRoYXQuY29tPg0KPj4+PiAgICAgICBTaWduZWQtb2ZmLWJ5OiBBbGV4IFdpbGxpYW1zb24g
PGFsZXgud2lsbGlhbXNvbkByZWRoYXQuY29tPg0KPj4+Pg0KPj4+Pj4NCj4+Pj4+IEkgYXNrZWQg
QWxleCBhbmQgUGV0ZXIgaW4gYW5vdGhlciB0aHJlYWQuDQo+Pj4+DQo+Pj4+IEp1c3QgY3VyaW91
cyBvbiB0aGUgYW5zd2VyLCBtYXkgSSBhc2sgd2hpY2ggdGhyZWFkPw0KPj4+DQo+Pj4gQWNjb3Jk
aW5nIHRvIEFsZXgsIHRoZSBRRU1VIHdvcmthcm91bmQgY2FuIGJlIHJlbW92ZWQgOg0KPj4+DQo+
Pj4NCj5odHRwczovL2xvcmUua2VybmVsLm9yZy9xZW11LWRldmVsLzIwMjUwOTE5MTAyNDQ3Ljc0
OGUxN2ZlLmFsZXgud2lsbGlhbXMNCj4+PiBvbkByZWRoYXQuY29tLw0KPj4+DQo+Pj4+IGJ0dzog
SSBqdXN0IGZvdW5kIHVubWFwcGluZyBpbiBoYWx2ZXMgc2VlbXMgdW5uZWNlc3NhcnkgYXMgYm90
aA0KPmJhY2tlbmRzDQo+Pj4gb2Yga2VybmVsIHNpZGUgc3VwcG9ydCB1bm1hcF9hbGwgbm93Lg0K
Pj4+Pg0KPj4+PiAgICAgICBpZiAodW5tYXBfYWxsKSB7DQo+Pj4+ICAgICAgICAgICAvKiBUaGUg
dW5tYXAgaW9jdGwgZG9lc24ndCBhY2NlcHQgYSBmdWxsIDY0LWJpdCBzcGFuLiAqLw0KPj4+PiAg
ICAgICAgICAgSW50MTI4IGxsc2l6ZSA9IGludDEyOF9yc2hpZnQoaW50MTI4XzJfNjQoKSwgMSk7
DQo+Pj4+DQo+Pj4+ICAgICAgICAgICByZXQgPSB2ZmlvX2xlZ2FjeV9kbWFfdW5tYXBfb25lKGJj
b250YWluZXIsIDAsDQo+Pj4gaW50MTI4X2dldDY0KGxsc2l6ZSksDQo+Pj4+ICAgICAgICAgICAg
ICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgIGlvdGxiKTsNCj4+Pj4NCj4+Pj4gICAgICAg
ICAgIGlmIChyZXQgPT0gMCkgew0KPj4+PiAgICAgICAgICAgICAgIHJldCA9IHZmaW9fbGVnYWN5
X2RtYV91bm1hcF9vbmUoYmNvbnRhaW5lciwNCj4+PiBpbnQxMjhfZ2V0NjQobGxzaXplKSwNCj4+
Pj4NCj5pbnQxMjhfZ2V0NjQobGxzaXplKSwNCj4+PiBpb3RsYik7DQo+Pj4+ICAgICAgICAgICB9
DQo+Pj4+DQo+Pj4+ICAgICAgIH0gZWxzZSB7DQo+Pj4+ICAgICAgICAgICByZXQgPSB2ZmlvX2xl
Z2FjeV9kbWFfdW5tYXBfb25lKGJjb250YWluZXIsIGlvdmEsIHNpemUsDQo+Pj4gaW90bGIpOw0K
Pj4+PiAgICAgICB9DQo+Pj4NCj4+PiBHb29kLiBTbyB3ZSBjYW4gc2ltcGx5IGJvdGggYmFja2Vu
ZHMgaXQgc2VlbXMuDQo+DQo+KmlmeQ0KPg0KPj4NCj4+IFdpbGwgeW91IGhhbmRsZSB0aGVtIG9y
IG5vdD8gSSBtZWFuIHRoZSB3b3JrYXJvdW5kIHJlbW92aW5nIGFuZA0KPnVubWFwcGluZ19hbGwg
b3B0aW1pemF0aW9uLg0KPg0KPkkgY2FuIHJldmVydCA1NjdkN2QzZTZiZTUgKCJ2ZmlvL2NvbW1v
bjogV29yayBhcm91bmQga2VybmVsIG92ZXJmbG93DQo+YnVnIGluIERNQSB1bm1hcCIpIGJ1dCwg
QUZBSUNULCB0aGUgInVubWFwIERNQXMgaW4gaGFsdmVzIiBtZXRob2QgKHNlZQ0KPjFiMjk2YzNk
ZWY0Yikgc2hvdWxkIGJlIGtlcHQuDQoNCk9LLCBsZXQgbWUgdGFrZSB0aGUgdW5tYXBfYWxsIHBh
cnQuIEZvciBleGFtcGxlLCBmb3IgaW9tbXVmZCwgaXQgY2FuIGJlIHNpbXBsaWZpZWQgdG86DQot
LS0gYS9ody92ZmlvL2lvbW11ZmQuYw0KKysrIGIvaHcvdmZpby9pb21tdWZkLmMNCkBAIC02Nywx
OSArNjcsOCBAQCBzdGF0aWMgaW50IGlvbW11ZmRfY2Rldl91bm1hcChjb25zdCBWRklPQ29udGFp
bmVyQmFzZSAqYmNvbnRhaW5lciwNCg0KICAgICAvKiB1bm1hcCBpbiBoYWx2ZXMgKi8NCiAgICAg
aWYgKHVubWFwX2FsbCkgew0KLSAgICAgICAgSW50MTI4IGxsc2l6ZSA9IGludDEyOF9yc2hpZnQo
aW50MTI4XzJfNjQoKSwgMSk7DQotICAgICAgICBpbnQgcmV0Ow0KLQ0KLSAgICAgICAgcmV0ID0g
aW9tbXVmZF9iYWNrZW5kX3VubWFwX2RtYShjb250YWluZXItPmJlLCBjb250YWluZXItPmlvYXNf
aWQsDQotICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgIDAsIGludDEyOF9n
ZXQ2NChsbHNpemUpKTsNCi0NCi0gICAgICAgIGlmIChyZXQgPT0gMCkgew0KLSAgICAgICAgICAg
IHJldCA9IGlvbW11ZmRfYmFja2VuZF91bm1hcF9kbWEoY29udGFpbmVyLT5iZSwgY29udGFpbmVy
LT5pb2FzX2lkLA0KLSAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAg
aW50MTI4X2dldDY0KGxsc2l6ZSksDQotICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAg
ICAgICAgICAgICBpbnQxMjhfZ2V0NjQobGxzaXplKSk7DQotICAgICAgICB9DQotDQotICAgICAg
ICByZXR1cm4gcmV0Ow0KKyAgICAgICAgYXNzZXJ0KCFpb3ZhICYmICFzaXplKTsNCisgICAgICAg
IHNpemUgPSBVSU5UNjRfTUFYOw0KICAgICB9DQoNCiAgICAgLyogVE9ETzogSGFuZGxlIGRtYV91
bm1hcF9iaXRtYXAgd2l0aCBpb3RsYiBhcmdzIChtaWdyYXRpb24pICovDQoNClRoYW5rcw0KWmhl
bnpob25nDQo=

