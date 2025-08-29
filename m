Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C6279CA0FFF
	for <qemu-devel@archiver.kernel.org>; Sat, 30 Aug 2025 15:10:51 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1usN3L-0001X6-CB; Sat, 30 Aug 2025 10:59:39 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <zhenzhong.duan@intel.com>)
 id 1uro6A-00044w-Vw
 for qemu-devel@nongnu.org; Thu, 28 Aug 2025 21:40:15 -0400
Received: from mgamail.intel.com ([198.175.65.17])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <zhenzhong.duan@intel.com>)
 id 1uro67-0002n6-RS
 for qemu-devel@nongnu.org; Thu, 28 Aug 2025 21:40:14 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1756431612; x=1787967612;
 h=from:to:cc:subject:date:message-id:references:
 in-reply-to:content-transfer-encoding:mime-version;
 bh=wEWu6YgC6bRJa3LaFbw9DOKJLJzeeV2S/WrrOs71Mbk=;
 b=HcpB1wa0Pa3zk4YxBQakw5CQZ/XZC1+0OmatirLhEA1MUjzULyfhu4Xy
 L2CPAISp6YjhWi7ydTJ2uiSLzmPkZTWVcW2Hitc7XGGrYK009/qjzpyox
 QO2DNrHGOMOzM20ytJ7knPzscfgxtTkSSns3E0kGCapDQJOJ2vKsKm/ie
 B5/b6rimzYk+f+F6jSwyZ5+GP3r9Wd5A4aWDLEPCAI1lOMykBZBK/w/yQ
 WgqNdOapWjNM+qM2/C0BSGLU78gvVRYpQt33hbD51Q4EOrkfhInoY2fwM
 fAER+l9IW/QVqbkGCI440tUUMJmURYnmtFbgulyNt5vqYNqbhlXxOodEF w==;
X-CSE-ConnectionGUID: ckijQk7iTxyfgX4C6v0H9A==
X-CSE-MsgGUID: uyqA8KwKTDCMiK0GeXGfxw==
X-IronPort-AV: E=McAfee;i="6800,10657,11531"; a="58660052"
X-IronPort-AV: E=Sophos;i="6.17,312,1747724400"; d="scan'208";a="58660052"
Received: from fmviesa008.fm.intel.com ([10.60.135.148])
 by orvoesa109.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 28 Aug 2025 18:40:07 -0700
X-CSE-ConnectionGUID: STGy6HDzRDCxer68lKYMKw==
X-CSE-MsgGUID: tCxPp2MnQ7OMWPRRZHXSIQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.18,221,1751266800"; d="scan'208";a="170648080"
Received: from orsmsx901.amr.corp.intel.com ([10.22.229.23])
 by fmviesa008.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 28 Aug 2025 18:40:06 -0700
Received: from ORSMSX902.amr.corp.intel.com (10.22.229.24) by
 ORSMSX901.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.17; Thu, 28 Aug 2025 18:40:05 -0700
Received: from ORSEDG901.ED.cps.intel.com (10.7.248.11) by
 ORSMSX902.amr.corp.intel.com (10.22.229.24) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.17 via Frontend Transport; Thu, 28 Aug 2025 18:40:05 -0700
Received: from NAM12-MW2-obe.outbound.protection.outlook.com (40.107.244.83)
 by edgegateway.intel.com (134.134.137.111) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.17; Thu, 28 Aug 2025 18:40:05 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=Hk3AvoELFlWVrUntDwZZpQB3R1PFz6dkF83oIzGTp3jfafj+BNjRw/CEDohxsPXiss1A25eT3FPaMdygx07WW6zhEsiETzIlEu2bt5Q/7AfISZqbM1XU/godrS8lrzJzyY4qxI35R1BiUyDiv3pXNpuMAOusqGibHb4M0sJCurpiNqOiId0kmscV3csp58dXhS6hWr+bTKJwUVeZ8tkXzFTBgDykwqOuRN7jEiTP9c3H4U66dP5TMXoW+4yEKNfuCRK8jYkmLtSZM2F40wcm/89PGmSc/OG4JJJerMmD4WzZlUOHV42aK4pawKj3Yq5pod6tIu62YmDXM2z6r5O6NQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=wEWu6YgC6bRJa3LaFbw9DOKJLJzeeV2S/WrrOs71Mbk=;
 b=st0DYE6GCQeJToaaX2yvg+zLTqxa4RfZ/7YTbuSNPNYsdjWDZOXKPBbG93H8cpqTtaIz/pqN9SgDZgM3gzN/kwtvtJVE4+nXzYqZQtwWlzwoK8R7l/zQleZbuJQW5SKwWsHon8Uhm2gjOgHQ1fEgzyZtk4mWj1wcO5EE4mu0oFJy49hbmnCV4ICzzlSkI6fjmL502OiX8OnVS+4ODQkm6cuxFs13FJxXd4VPvgB3YkuEnzRSF4aQgRnV7QJPro3f938oxPgb9Uo+MPs7AEVJJ2On9PDenfdp5J2p0Hqm8RiRCYZvy5J36yF/2NM51OWnFa8u/gKtZc4IiBzLUfLeFg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Received: from IA3PR11MB9136.namprd11.prod.outlook.com (2603:10b6:208:574::12)
 by DS4PPF6F32BC4DA.namprd11.prod.outlook.com (2603:10b6:f:fc02::2e)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9073.15; Fri, 29 Aug
 2025 01:40:01 +0000
Received: from IA3PR11MB9136.namprd11.prod.outlook.com
 ([fe80::604b:77a4:b1be:3f13]) by IA3PR11MB9136.namprd11.prod.outlook.com
 ([fe80::604b:77a4:b1be:3f13%4]) with mapi id 15.20.9052.019; Fri, 29 Aug 2025
 01:40:01 +0000
From: "Duan, Zhenzhong" <zhenzhong.duan@intel.com>
To: "eric.auger@redhat.com" <eric.auger@redhat.com>, "qemu-devel@nongnu.org"
 <qemu-devel@nongnu.org>
CC: "alex.williamson@redhat.com" <alex.williamson@redhat.com>,
 "clg@redhat.com" <clg@redhat.com>, "mst@redhat.com" <mst@redhat.com>,
 "jasowang@redhat.com" <jasowang@redhat.com>, "peterx@redhat.com"
 <peterx@redhat.com>, "ddutile@redhat.com" <ddutile@redhat.com>,
 "jgg@nvidia.com" <jgg@nvidia.com>, "nicolinc@nvidia.com"
 <nicolinc@nvidia.com>, "joao.m.martins@oracle.com"
 <joao.m.martins@oracle.com>, "clement.mathieu--drif@eviden.com"
 <clement.mathieu--drif@eviden.com>, "Tian, Kevin" <kevin.tian@intel.com>,
 "Liu, Yi L" <yi.l.liu@intel.com>, "Peng, Chao P" <chao.p.peng@intel.com>
Subject: RE: [PATCH v5 05/21] vfio/iommufd: Force creating nested parent domain
Thread-Topic: [PATCH v5 05/21] vfio/iommufd: Force creating nested parent
 domain
Thread-Index: AQHcEy/cU7h1NYrEmkakGdO2tRUzdbR2aqYAgAFwmOCAADX2gIAA0VKg
Date: Fri, 29 Aug 2025 01:40:01 +0000
Message-ID: <IA3PR11MB9136713B0F6F9DD8D5751294923AA@IA3PR11MB9136.namprd11.prod.outlook.com>
References: <20250822064101.123526-1-zhenzhong.duan@intel.com>
 <20250822064101.123526-6-zhenzhong.duan@intel.com>
 <93a7a387-ae57-488e-b341-2beea67bf78e@redhat.com>
 <IA3PR11MB9136E928181D1B95F5AD39AB923BA@IA3PR11MB9136.namprd11.prod.outlook.com>
 <ff8022d1-6363-43c7-b095-cf8f0a692a16@redhat.com>
In-Reply-To: <ff8022d1-6363-43c7-b095-cf8f0a692a16@redhat.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: IA3PR11MB9136:EE_|DS4PPF6F32BC4DA:EE_
x-ms-office365-filtering-correlation-id: 4282b2e1-22a1-4200-b0cb-08dde69cf892
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
 ARA:13230040|1800799024|366016|7416014|376014|38070700018; 
x-microsoft-antispam-message-info: =?utf-8?B?eDVBYzVmY0JOMXJCT2tndW5rNU1kV0UwY3lYZjdqMENISk82djBieGlIODVM?=
 =?utf-8?B?WjZqa1AyWmJONmt4UWdCa25lS3QzSERBSG0yN0M4REFFc0RHUXVVTTU2MkJa?=
 =?utf-8?B?OURRM0dzWVoyR1M5OGtwcFZvMzRxdUhQTi9SZ09QU0ZZU1Qzd1UwWExKb1ZW?=
 =?utf-8?B?eFQyUk9XeG9oVHkvQWhUNmRmZHJVU2hUcmg2NzJ0eTQ0UjJhTEN6VzlkVXBl?=
 =?utf-8?B?YUpSRE5GMWVzbWtHaXkzTDVqS2hCNmFnUis1ZmVrUTcyNGZrUnIyYm9ScWVo?=
 =?utf-8?B?YzR3Y0s1L24xWnBwd2pPV2djbGloNWMzQlJSKzFIRklZRG5PQmJoL1ZpQ2w5?=
 =?utf-8?B?ck9FVENMaEdJMmY4WHBLK1R3RVVaL0NIYzFqcGRueDB5VnhyYWtIdFY3S1BQ?=
 =?utf-8?B?MlNJeHdnYTZnMlZxZ0NPWVl3dHFHSkdRVU9SRCtwcWJ2UTRBR0hWR0Z4Y3N6?=
 =?utf-8?B?QTl2UVdLekRjKzVtN1ZFM1M4SzZpcmdiSHFoS3hOVnp3L0J0alJCNzAwNy9j?=
 =?utf-8?B?dGJ1Z3F2ZURBZGtnYWMyZEVRZXlBT1hmQnFRQVA0YytrZm1JMndSbGpaTGtv?=
 =?utf-8?B?SFRuMjlnWWp5QkhHd1pJWWpxc093VnIrbnpWMTVDdFJJVnU1UjNQd1ZidW1m?=
 =?utf-8?B?ZHBnMy9ZaUlhNTdnd09YQ3dtc0dtYzR4c2tvYzF2TGhJRExwM21HOGZnS0Zi?=
 =?utf-8?B?STVwUzZyWWxqenZkTVB2TytER29Vbys4RlkvWVpxbS8zNmZYckw5ME9lQUpx?=
 =?utf-8?B?d0E5NitRa0ZSZ2RQZHlIZ0daOEFvR1VXSzFwOC9nYnVYb2ZpbGdEYThOdHRV?=
 =?utf-8?B?dzRkdk1Jd1BuaGhQMUNaa08zbUtjTjB4a1QvNXlwVjB5aEJVaTFwWWp4N0cx?=
 =?utf-8?B?R3ZBUFhGZ25jcHpVdkFKT0FtZlJxMmFPWGlzRm05bmdxaTRCVWU2UTYzeUFG?=
 =?utf-8?B?L3VkL3BIN2czTlE2OEJSM2V6VDNPbGQyaTFpN1BCTm55aENtNk5GN0daVE1a?=
 =?utf-8?B?SG43eGkxN0VsaGlFdTY0Q3ZtemFtODc4aldTVnBQSXlOdWdsdjAwRW9qOENp?=
 =?utf-8?B?VXlYUmprVDE4RUpXNWFxMjBTUm1VUFNkTEpvcGx6OWZKWFVqWU1Bb29IeC9Y?=
 =?utf-8?B?c3F3MTNLZUJmeXZtS2xpaHBnbHNkNjlLLzdhSnIzN2J3ck1KK3gwVFZtUmlO?=
 =?utf-8?B?TWdubFBmV1B2ZWREQXRXRHpUMTFhT2JaU2hTWTQyZ2tjUDF1eWRUb25NSkl0?=
 =?utf-8?B?QjNPczVvWi9jYmVPbEFJeHVjYm5GYyt0U0VrRlVucm9GeTFJelJjV0dSR0Zi?=
 =?utf-8?B?RnVNcW9LbGRqSk1CWjhQMEtUOVpqRnFBYTY4OWxqUi8xZVRyUmdaL08yd2xz?=
 =?utf-8?B?V0xrc1J6R1VyZGptNEdkcDhleExJUGhDMVUrOVRKV2RraUlZd0dhbGQ1NkMy?=
 =?utf-8?B?ZCt3eTNxMDR0VkRSdnBySDRTem5Da0hIUDNsQkFqQ2JrRzI3TEltb3NBc0h4?=
 =?utf-8?B?TzRmczA0Lzg2a0F2QkRTVmtINzBxQ01ZZGZRalZKaXVsSXNiZzhGTnFsVHNR?=
 =?utf-8?B?cEVTbW9DQ09QdmFRZFlhbXFRVlR0OHpYeklOMjZwaG1ZRHUvSzBOZkpDM2Q2?=
 =?utf-8?B?N2YzbldJVEc1OTIySTBaRUhkZTJLeEI3TFdXRmlYWW5ERHdhSlFsWlB6R1ZZ?=
 =?utf-8?B?S0QvZ1NzTHFPTDNlZVFpL1NCS3VDOWdmcVBLVUhRbHNDT2grWVdIaU92NmJo?=
 =?utf-8?B?ZVJPZFNsTXJ6OGFuZThFcFhFWnI0Y3RyRWRnWG15d3g5bDh2dWZpeFdubjhZ?=
 =?utf-8?B?Tm5Cd2lTbkhJVXJqci9OUXpaQzFJRFRYWGNodXY5YURqMG84cEg0RWsrWThR?=
 =?utf-8?B?aG5yNnlRcDZXMDdXS0pITkUvMlNBTi9IUUVIY1Z2WlZjc2xpUWNRU3p6bTJE?=
 =?utf-8?B?RXFkeDM4L1RWY0xQSnNJa2pwc0dxY1ZDZWg1VGlaYlVTQTdRdmx1MVZKWlJX?=
 =?utf-8?B?bXhaR2hJTFZBPT0=?=
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:IA3PR11MB9136.namprd11.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(1800799024)(366016)(7416014)(376014)(38070700018); DIR:OUT;
 SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?SDlpT0tqbmtkeG1xSWRaZ3M0aWlLa3JqOXZTYVdxNlR3OU90K0U3USthRmVz?=
 =?utf-8?B?cEZPUnhEcHhWUERzZ0RxSElyUnpCTCtLZktyaVRFbUJQZzJoUGtaQjdWYWwy?=
 =?utf-8?B?ak5XcU43bEN5bFM4M25zVkJrWVVUNGtOQXI1SU9oNUpXVElTaXNoZWcrNzc0?=
 =?utf-8?B?dXludXc2MzNnMlpxRXI5Q3hQUFN4ZXMrYnRUaHdybDZwNTVzcktReG00QjZT?=
 =?utf-8?B?QkY0YmtQZEM3Wm54UHdQS2dGSGpMdFNtUjFWUWYyYUc0eUpIYVRsTTRlVjhk?=
 =?utf-8?B?R3BjM3U0MmdZQXN1U1RUOURZR0lHbFQwZmEzaUgrTHNvemNGMmNERU10Vm1S?=
 =?utf-8?B?bjZ3WTVLMm53TkpWN2t3VzhlNGJQSWFoeWVBcnBqTHF6a1Z3RkFEZFphVTJI?=
 =?utf-8?B?dFRscEJ5ZW5WMlBtbHZzUHN4RXFsSTdZa3NKM2I1SGVtdVNvdjc1eGh5Zjk2?=
 =?utf-8?B?U0J4bjNYYnM3dE9XMzBSc2dNcndNSHZZdGR1ZVhKQ3VabGpxZCs4QnkyL3VC?=
 =?utf-8?B?TEFZdmk0bWRUbG5sV3NMeUdEWXRSRHdRL1lReUNYV0o2WUdBM1JURS9RYlhr?=
 =?utf-8?B?THgwdFFldk4ydXBUVTVqTUFLY3JKZUZscEFjU2kwM2orbm5jS0ZFWlZBcllk?=
 =?utf-8?B?NDF6ZzhBbmN1KzgwRDBvbklLeExQZ294bmhSYjk5Z2lwYXA4MTFqUHRQNkYw?=
 =?utf-8?B?bjFEN2hJenFOTERab0R5ck93bVBQNncvUjJZS0pTQzVxWHM0QWJKS2YyU0NN?=
 =?utf-8?B?OVFMUFRQbDdmcXYxd094WklyNFdycGZ2R3JkWi9TMi9aTmNSdE5zWTFCZXRn?=
 =?utf-8?B?ZEt1MlQxKzJnckZBN0sra241QXpsOWdBVjVUUHFFbnl4VzhLNkl4eFRMSE5K?=
 =?utf-8?B?cmJzZnVPVzFCekwvaW9VbGZ5cXBKSHU1YjM0SHhmQUhUK0ZGckZvNzEwbDEx?=
 =?utf-8?B?dVMvR09RREduekwyNkxBQlBkU0JmcDQ3Vm9tTi9pRy8vZHM1bDhSeXJWWE54?=
 =?utf-8?B?dkhVSmF1QVBLNDRwcWFFOWllNFFrcFRoVDVTemV1dTdkTGxqZmpFenhnaVJM?=
 =?utf-8?B?ZmxFZ2dQV1VYSVdmVUZZWGw5NUVQam9Kb2FXVkkzNlRGL2FPbmxwOGdtR2ZW?=
 =?utf-8?B?cnAvM3FhWFVoNGZRQW9WejBHN1FLc1dCTjM3a0dFV3Z1akpoMUg2QTJPOUk2?=
 =?utf-8?B?NG9pZ0NZMXlhdmxKWXV1eFJCdEVId1NqTnVYTGdlc29mSlhhOXJFNDJhdHN3?=
 =?utf-8?B?L1BxdlVzM3FCZlBqck5aQi9CMms0UWRCY0I4c1l0VnM5dC8rQ29FdFpYSFNq?=
 =?utf-8?B?WFRQNXVRSDlnNmRjaEV4ZTFvemptZ0wzVC9XSFM0MGxnNnY0emJGVDZKR0s2?=
 =?utf-8?B?UDNKdGZYTVB6alB0UW9KQ0Y1M1NNSzZXV2ZVRlF0a2VKeS84ZHM4d0dOWXl2?=
 =?utf-8?B?TXU1SWlpQm10bVovWis0bVlKUW5sVWJxZHNsanJYdTVvRjdxcWRSL0JPSWdV?=
 =?utf-8?B?ZUVQMkpOeGYwNXQwMVhEeVVnVkNFNUtCbGV0WkZaOFFOdUFOZHl4blFNQmc2?=
 =?utf-8?B?ZEE5MWlrWllyamRESW9qY25tLzRCYWlIaTZ2VFZ4Z0hHVkY5TFBnK1crTG1X?=
 =?utf-8?B?K3NwNDgxYXRoN3ZDcXhvUmF0V1crU1ZvRUlsVm54Z2FIaUVPcXJGT0crZFA0?=
 =?utf-8?B?MjdqNTZqMGp1c1g5dURqK3liM0ZTeFNYZ3ZscjJnUnFxQTgxdjVDeTk0a0cv?=
 =?utf-8?B?OUlXV3BMeGxDTW5vQ25zU21kSWhXYmEwOWtUeDRSLzhuRDZGWkt5Qml2dWVi?=
 =?utf-8?B?eXNkQXo3anloNk9RQnEwbWJNclo5MStueHpuSUcvb1o3UkxrbW45V0R1OTFP?=
 =?utf-8?B?dG5mTU9IeGlEdzFIMFNxaXNWNWREV3hoMnVWKzZtN0ladkd4MVF6U3RaVXNp?=
 =?utf-8?B?UHk1NXI5MENWSHJ2SFRVdWZGMWl0QlM0Z1JmaEwwT1JzNUpBSHlNVTBCUUFn?=
 =?utf-8?B?VFpVYXJzUndVa0lDYm9sSnRHc2NUaENUc3B6T3BQd2RCOXVXUWkrT1BiL0xT?=
 =?utf-8?B?NDB3T1VTZitWYWNDam5uUW9zbVZpcGc4bXpxd1FsLzJFeklERGJyL0FoS05p?=
 =?utf-8?Q?O9UlYtKrfLpYHc6+QbyVL/+oX?=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: IA3PR11MB9136.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 4282b2e1-22a1-4200-b0cb-08dde69cf892
X-MS-Exchange-CrossTenant-originalarrivaltime: 29 Aug 2025 01:40:01.5919 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 1Qf23zsZ/fBDA7/pG790AQhvU2BEDCqmrjZsIyk0pYu/4h8otaumfzDqwUqxoQz6naMKLOLfS4gVq7Pb6EinU8JZWYNJSzA+0NPLgwFvspQ=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS4PPF6F32BC4DA
X-OriginatorOrg: intel.com
Received-SPF: pass client-ip=198.175.65.17;
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

DQoNCj4tLS0tLU9yaWdpbmFsIE1lc3NhZ2UtLS0tLQ0KPkZyb206IEVyaWMgQXVnZXIgPGVyaWMu
YXVnZXJAcmVkaGF0LmNvbT4NCj5TdWJqZWN0OiBSZTogW1BBVENIIHY1IDA1LzIxXSB2ZmlvL2lv
bW11ZmQ6IEZvcmNlIGNyZWF0aW5nIG5lc3RlZCBwYXJlbnQNCj5kb21haW4NCj4NCj4NCj4NCj5P
biA4LzI4LzI1IDExOjUzIEFNLCBEdWFuLCBaaGVuemhvbmcgd3JvdGU6DQo+PiBIaSBFcmljLA0K
Pj4NCj4+PiAtLS0tLU9yaWdpbmFsIE1lc3NhZ2UtLS0tLQ0KPj4+IEZyb206IEVyaWMgQXVnZXIg
PGVyaWMuYXVnZXJAcmVkaGF0LmNvbT4NCj4+PiBTdWJqZWN0OiBSZTogW1BBVENIIHY1IDA1LzIx
XSB2ZmlvL2lvbW11ZmQ6IEZvcmNlIGNyZWF0aW5nIG5lc3RlZCBwYXJlbnQNCj4+PiBkb21haW4N
Cj4+Pg0KPj4+IEhpIFpoZW56aG9uZywNCj4+Pg0KPj4+IE9uIDgvMjIvMjUgODo0MCBBTSwgWmhl
bnpob25nIER1YW4gd3JvdGU6DQo+Pj4+IENhbGwgcGNpX2RldmljZV9nZXRfdmlvbW11X2NhcCgp
IHRvIGdldCBpZiB2SU9NTVUgc3VwcG9ydHMNCj4+PiBWSU9NTVVfQ0FQX0hXX05FU1RFRCwNCj4+
Pj4gaWYgeWVzLCBjcmVhdGUgbmVzdGVkIHBhcmVudCBkb21haW4gd2hpY2ggY291bGQgYmUgcmV1
c2VkIGJ5IHZJT01NVSB0bw0KPj4+IGNyZWF0ZQ0KPj4+PiBuZXN0ZWQgZG9tYWluLg0KPj4+Pg0K
Pj4+PiBJbnRyb2R1Y2UgaGVscGVyIHZmaW9fZGV2aWNlX3Zpb21tdV9nZXRfbmVzdGVkIHRvIGZh
Y2lsaXRhdGUgdGhpcw0KPj4+PiBpbXBsZW1lbnRhdGlvbi4NCj4+Pj4NCj4+Pj4gSXQgaXMgc2Fm
ZSBiZWNhdXNlIGV2ZW4gaWYgVklPTU1VX0NBUF9IV19ORVNURUQgaXMgcmV0dXJuZWQsIHMtPmZs
dHMNCj5pcw0KPj4+PiBmb3JiaWRkZW4gYW5kIFZGSU8gZGV2aWNlIGZhaWxzIGluIHNldF9pb21t
dV9kZXZpY2UoKSBjYWxsLCB1bnRpbCB3ZQ0KPnN1cHBvcnQNCj4+Pj4gcGFzc3Rocm91Z2ggZGV2
aWNlIHdpdGggeC1mbHRzPW9uLg0KPj4+Pg0KPj4+PiBTdWdnZXN0ZWQtYnk6IE5pY29saW4gQ2hl
biA8bmljb2xpbmNAbnZpZGlhLmNvbT4NCj4+Pj4gU3VnZ2VzdGVkLWJ5OiBZaSBMaXUgPHlpLmwu
bGl1QGludGVsLmNvbT4NCj4+Pj4gU2lnbmVkLW9mZi1ieTogWmhlbnpob25nIER1YW4gPHpoZW56
aG9uZy5kdWFuQGludGVsLmNvbT4NCj4+Pj4gLS0tDQo+Pj4+ICBpbmNsdWRlL2h3L3ZmaW8vdmZp
by1kZXZpY2UuaCB8ICAyICsrDQo+Pj4+ICBody92ZmlvL2RldmljZS5jICAgICAgICAgICAgICB8
IDEyICsrKysrKysrKysrKw0KPj4+PiAgaHcvdmZpby9pb21tdWZkLmMgICAgICAgICAgICAgfCAg
OCArKysrKysrKw0KPj4+PiAgMyBmaWxlcyBjaGFuZ2VkLCAyMiBpbnNlcnRpb25zKCspDQo+Pj4+
DQo+Pj4+IGRpZmYgLS1naXQgYS9pbmNsdWRlL2h3L3ZmaW8vdmZpby1kZXZpY2UuaCBiL2luY2x1
ZGUvaHcvdmZpby92ZmlvLWRldmljZS5oDQo+Pj4+IGluZGV4IDZlNGQ1Y2NkYWMuLmVjZDgyYzE2
YzcgMTAwNjQ0DQo+Pj4+IC0tLSBhL2luY2x1ZGUvaHcvdmZpby92ZmlvLWRldmljZS5oDQo+Pj4+
ICsrKyBiL2luY2x1ZGUvaHcvdmZpby92ZmlvLWRldmljZS5oDQo+Pj4+IEBAIC0yNTcsNiArMjU3
LDggQEAgdm9pZCB2ZmlvX2RldmljZV9wcmVwYXJlKFZGSU9EZXZpY2UgKnZiYXNlZGV2LA0KPj4+
IFZGSU9Db250YWluZXJCYXNlICpiY29udGFpbmVyLA0KPj4+PiAgdm9pZCB2ZmlvX2RldmljZV91
bnByZXBhcmUoVkZJT0RldmljZSAqdmJhc2VkZXYpOw0KPj4+Pg0KPj4+PiArYm9vbCB2ZmlvX2Rl
dmljZV92aW9tbXVfZ2V0X25lc3RlZChWRklPRGV2aWNlICp2YmFzZWRldik7DQo+Pj4gSSB3b3Vs
ZCBzdWdnZXN0IHZmaW9fZGV2aWNlX3Zpb21tdV9oYXNfZmVhdHVyZV9od19uZXN0ZWQgb3INCj5z
b21ldGhpbmcNCj4+PiBhbGlrZQ0KPj4+IGdldCB1c3VhbGx5IG1lYW5zIHRvdSB0YWtlIGEgcmVm
IGNvdW50IGFzc29jaWF0ZWQgd2l0aCBhIHB1dA0KPj4gU3VyZS4NCj4+DQo+Pj4+ICsNCj4+Pj4g
IGludCB2ZmlvX2RldmljZV9nZXRfcmVnaW9uX2luZm8oVkZJT0RldmljZSAqdmJhc2VkZXYsIGlu
dCBpbmRleCwNCj4+Pj4gICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgc3RydWN0IHZm
aW9fcmVnaW9uX2luZm8gKippbmZvKTsNCj4+Pj4gIGludCB2ZmlvX2RldmljZV9nZXRfcmVnaW9u
X2luZm9fdHlwZShWRklPRGV2aWNlICp2YmFzZWRldiwgdWludDMyX3QNCj4+PiB0eXBlLA0KPj4+
PiBkaWZmIC0tZ2l0IGEvaHcvdmZpby9kZXZpY2UuYyBiL2h3L3ZmaW8vZGV2aWNlLmMNCj4+Pj4g
aW5kZXggMDhmMTJhYzMxZi4uM2VlYjcxYmQ1MSAxMDA2NDQNCj4+Pj4gLS0tIGEvaHcvdmZpby9k
ZXZpY2UuYw0KPj4+PiArKysgYi9ody92ZmlvL2RldmljZS5jDQo+Pj4+IEBAIC0yMyw2ICsyMyw3
IEBADQo+Pj4+DQo+Pj4+ICAjaW5jbHVkZSAiaHcvdmZpby92ZmlvLWRldmljZS5oIg0KPj4+PiAg
I2luY2x1ZGUgImh3L3ZmaW8vcGNpLmgiDQo+Pj4+ICsjaW5jbHVkZSAiaHcvaW9tbXUuaCINCj4+
Pj4gICNpbmNsdWRlICJody9ody5oIg0KPj4+PiAgI2luY2x1ZGUgInRyYWNlLmgiDQo+Pj4+ICAj
aW5jbHVkZSAicWFwaS9lcnJvci5oIg0KPj4+PiBAQCAtNTA0LDYgKzUwNSwxNyBAQCB2b2lkIHZm
aW9fZGV2aWNlX3VucHJlcGFyZShWRklPRGV2aWNlDQo+Pj4gKnZiYXNlZGV2KQ0KPj4+PiAgICAg
IHZiYXNlZGV2LT5iY29udGFpbmVyID0gTlVMTDsNCj4+Pj4gIH0NCj4+Pj4NCj4+Pj4gK2Jvb2wg
dmZpb19kZXZpY2VfdmlvbW11X2dldF9uZXN0ZWQoVkZJT0RldmljZSAqdmJhc2VkZXYpDQo+Pj4+
ICt7DQo+Pj4+ICsgICAgVkZJT1BDSURldmljZSAqdmRldiA9IHZmaW9fcGNpX2Zyb21fdmZpb19k
ZXZpY2UodmJhc2VkZXYpOw0KPj4+PiArDQo+Pj4+ICsgICAgaWYgKHZkZXYpIHsNCj4+Pj4gKyAg
ICAgICAgcmV0dXJuICEhKHBjaV9kZXZpY2VfZ2V0X3Zpb21tdV9jYXAoJnZkZXYtPnBkZXYpICYN
Cj4+Pj4gKyAgICAgICAgICAgICAgICAgIFZJT01NVV9DQVBfSFdfTkVTVEVEKTsNCj4+Pj4gKyAg
ICB9DQo+Pj4+ICsgICAgcmV0dXJuIGZhbHNlOw0KPj4+PiArfQ0KPj4+PiArDQo+Pj4+ICAvKg0K
Pj4+PiAgICogVHJhZGl0aW9uYWwgaW9jdGwoKSBiYXNlZCBpbw0KPj4+PiAgICovDQo+Pj4+IGRp
ZmYgLS1naXQgYS9ody92ZmlvL2lvbW11ZmQuYyBiL2h3L3ZmaW8vaW9tbXVmZC5jDQo+Pj4+IGlu
ZGV4IDhjMjcyMjJmNzUuLmU1MDNjMjMyZTEgMTAwNjQ0DQo+Pj4+IC0tLSBhL2h3L3ZmaW8vaW9t
bXVmZC5jDQo+Pj4+ICsrKyBiL2h3L3ZmaW8vaW9tbXVmZC5jDQo+Pj4+IEBAIC0zNzksNiArMzc5
LDE0IEBAIHN0YXRpYyBib29sDQo+Pj4gaW9tbXVmZF9jZGV2X2F1dG9kb21haW5zX2dldChWRklP
RGV2aWNlICp2YmFzZWRldiwNCj4+Pj4gICAgICAgICAgZmxhZ3MgPSBJT01NVV9IV1BUX0FMTE9D
X0RJUlRZX1RSQUNLSU5HOw0KPj4+PiAgICAgIH0NCj4+Pj4NCj4+Pj4gKyAgICAvKg0KPj4+PiAr
ICAgICAqIElmIHZJT01NVSBzdXBwb3J0cyBzdGFnZS0xIHRyYW5zbGF0aW9uLCBmb3JjZSB0byBj
cmVhdGUgbmVzdGVkDQo+Pj4gcGFyZW50DQo+Pj4gSSB3b3VsZCByYXRoZXIgbm90IHVzZSBhbm90
aGVyIHRlcm1pbm9sb2d5IGhlcmUuIFlvdSBwcmV2aW91c2x5IHVzZWQNCj4+PiBod19uZXN0ZWQs
IEkgdGhpbmsgdGhhdCdzIGJldHRlci4gQWxzbyBiZWFyIGluIG1pbmQgdGhhdCBzbW11IHN1cHBv
cnRzDQo+Pj4gUzEsIFMyIGFuZCBTMStTMiBpbiBlbXVsYXRlZCBjb2RlLg0KPj4gV2hhdCBhYm91
dCAnbmVzdGluZyBwYXJlbnQnIHRvIG1hdGNoIGtlcm5lbCBzaWRlIHRlcm1pbm9sb2d5LCBwZXIg
Tmljb2xpbidzDQo+c3VnZ2VzdGlvbjoNCj4+DQo+PiBJbiBrZXJuZWwga2RvYy91QVBJLCB3ZSB1
c2U6DQo+PiAgLSAibmVzdGluZyBwYXJlbnQiIGZvciBzdGFnZS0yIG9iamVjdA0KPj4gIC0gIm5l
c3RlZCBod3B0IiwgIm5lc3RlZCBkb21haW4iIGZvciBzdGFnZS0xIG9iamVjdA0KPkkgc3RpbGwg
dGhpbmsgdGhhdCBzaW5jZSB5b3UgcXVlcmllZCB0aGUgSFdfTkVTVEVEIGNhcCBpdCBtYWtlcyBz
ZW5zZSB0bw0KPmNvbnRpbnVlIHVzaW5nIGl0LiBUaGlzIGNhbiBjb21lIGFsb25nIHdpdGggdGhl
IGtlcm5lbCB0ZXJtaW5vbG9neSB0aG91Z2guDQoNCk9LLCBsaWtlIGJlbG93LCBkbyBJIHVuZGVy
c3RhbmQgcmlnaHQ/DQoNCisgICAgLyoNCisgICAgICogSWYgdklPTU1VIHN1cHBvcnRzIHN0YWdl
LTEgdHJhbnNsYXRpb24sIGZvcmNlIHRvIGNyZWF0ZSBod19uZXN0ZWQNCisgICAgICogKGFrYS4g
bmVzdGluZyBwYXJlbnQgaW4ga2VybmVsKSBkb21haW4gd2hpY2ggY291bGQgYmUgcmV1c2VkIGJ5
DQorICAgICAqIHZJT01NVSB0byBjcmVhdGUgbmVzdGVkIGRvbWFpbi4NCisgICAgICovDQoNClRo
YW5rcw0KWmhlbnpob25nDQo=

