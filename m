Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 85A27CCD187
	for <qemu-devel@archiver.kernel.org>; Tue, 14 Oct 2025 06:16:23 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1v8YJj-0004B0-Q3; Tue, 14 Oct 2025 02:15:27 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <zhenzhong.duan@intel.com>)
 id 1v8YJe-0004AD-67
 for qemu-devel@nongnu.org; Tue, 14 Oct 2025 02:15:22 -0400
Received: from mgamail.intel.com ([192.198.163.10])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <zhenzhong.duan@intel.com>)
 id 1v8YJa-0003aU-7a
 for qemu-devel@nongnu.org; Tue, 14 Oct 2025 02:15:21 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1760422518; x=1791958518;
 h=from:to:cc:subject:date:message-id:references:
 in-reply-to:content-transfer-encoding:mime-version;
 bh=SipdBojk/Os2GJkI1iS2/G4LDbuShYNGPFj8Of29PHU=;
 b=B41T8giqDJvUc9Uk36PWYpjUnu04PjFqQShrLkH44tOqhZGuqQemGibt
 bb/n3WV218HeowIw0yEr0XdX65q3kXSd2zY2pT+cn8/tYZQtRqJH6T88g
 vKJD/R2YFj25jEYG5s1ozULrHPklj9zhj4Xdx7cBr494X2nEuN2+xn9b/
 +TAlTSgKkYnDg5Aoxgm8g5QWAi/ERGOuuSDGfOIN6RyTAYNuSwhIsxxuo
 fX9xr9fQG3bE5XVwY3osC6beTjm7P+OYkKEMU6dic88pIOQQlv1e+sn79
 eGQ1+MreWj282rR5ocYw7tvV3ai/OFK0+0iGXFISI4nn5Ce0+bp9iFI3w Q==;
X-CSE-ConnectionGUID: XCS0Srn4RMKC/knHTqKGlA==
X-CSE-MsgGUID: beer0zX2Ska9vgxdJdD1wQ==
X-IronPort-AV: E=McAfee;i="6800,10657,11581"; a="73917475"
X-IronPort-AV: E=Sophos;i="6.19,227,1754982000"; d="scan'208";a="73917475"
Received: from fmviesa002.fm.intel.com ([10.60.135.142])
 by fmvoesa104.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 13 Oct 2025 23:15:15 -0700
X-CSE-ConnectionGUID: gkObas6xRwms1oYYeBiWCg==
X-CSE-MsgGUID: kcLHDxDkR5SAzaBaL4Arew==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.19,227,1754982000"; d="scan'208";a="205493139"
Received: from fmsmsx901.amr.corp.intel.com ([10.18.126.90])
 by fmviesa002.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 13 Oct 2025 23:15:15 -0700
Received: from FMSMSX901.amr.corp.intel.com (10.18.126.90) by
 fmsmsx901.amr.corp.intel.com (10.18.126.90) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.27; Mon, 13 Oct 2025 23:15:14 -0700
Received: from fmsedg902.ED.cps.intel.com (10.1.192.144) by
 FMSMSX901.amr.corp.intel.com (10.18.126.90) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.27 via Frontend Transport; Mon, 13 Oct 2025 23:15:14 -0700
Received: from SA9PR02CU001.outbound.protection.outlook.com (40.93.196.7) by
 edgegateway.intel.com (192.55.55.82) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.27; Mon, 13 Oct 2025 23:15:14 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=u1LKINvq4qUo0GLMran9/t9fq9ozFQgI3v2SI4G/enq3/5UVu/A9v08fq10aBE7KWCvHCopSxQW008w4SENdDtvKYkEB8f8EGtC++0wX7TNdWmecSK8YuZSgHc59s2YcN7aq3THW1B1b7sSM3CTXMWG0yQ3a8PVlaMGhyRTGEYGFqpJRTsGSB2yE332Z6ije8oKfjzj9F5/rr0b7oE5L8jz2cJD5lEqqteympfwchfpkcoek9Maf1AWyWEZICPRlrYwBGxN2Y+Y5YIkXNoCA+1n4+OrxROIkZBvDQOzKnWcRQxV/9NYJCcZUIKX6c+L74pAC4B62fMycFaJZ8B11+w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=SipdBojk/Os2GJkI1iS2/G4LDbuShYNGPFj8Of29PHU=;
 b=wRy1+8BbjbXKapmN9nQceqCyrFJ+bnJOf6zTBQ7iMK+D6Ci9MYg8UwsTpd/iDDYyohQ/eq/ZSl2VIjGLtwMBSk3SoRZ0RXd3i96G4Bux7aezckQT4QXTfGr/7npmWUy5ZtKOirmz1GNqEIUqnQfoXOUlQAXvHm/v7BBZ2GAzTVNFSBvo3mZSa/cupF0bKA1iL6N1XTWpWtJ78yGzjx4SzupsJtJmo5+Kw6xMXvP4FAyDliZEtqOU2zJE42NlcgHf/utXD4gikMI51LwLjefvQjWBgpfXEJKIAlEH+Ny5yFopgQinF6z/GWNQjYPNNk4HB4lxE4TbCxsDArBK5cmIBA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Received: from IA3PR11MB9136.namprd11.prod.outlook.com (2603:10b6:208:574::12)
 by CH3PR11MB8703.namprd11.prod.outlook.com (2603:10b6:610:1cd::11)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9203.13; Tue, 14 Oct
 2025 06:15:11 +0000
Received: from IA3PR11MB9136.namprd11.prod.outlook.com
 ([fe80::604b:77a4:b1be:3f13]) by IA3PR11MB9136.namprd11.prod.outlook.com
 ([fe80::604b:77a4:b1be:3f13%7]) with mapi id 15.20.9203.009; Tue, 14 Oct 2025
 06:15:11 +0000
From: "Duan, Zhenzhong" <zhenzhong.duan@intel.com>
To: "Liu, Yi L" <yi.l.liu@intel.com>, "qemu-devel@nongnu.org"
 <qemu-devel@nongnu.org>
CC: "alex.williamson@redhat.com" <alex.williamson@redhat.com>,
 "clg@redhat.com" <clg@redhat.com>, "eric.auger@redhat.com"
 <eric.auger@redhat.com>, "mst@redhat.com" <mst@redhat.com>,
 "jasowang@redhat.com" <jasowang@redhat.com>, "peterx@redhat.com"
 <peterx@redhat.com>, "ddutile@redhat.com" <ddutile@redhat.com>,
 "jgg@nvidia.com" <jgg@nvidia.com>, "nicolinc@nvidia.com"
 <nicolinc@nvidia.com>, "skolothumtho@nvidia.com" <skolothumtho@nvidia.com>,
 "joao.m.martins@oracle.com" <joao.m.martins@oracle.com>,
 "clement.mathieu--drif@eviden.com" <clement.mathieu--drif@eviden.com>, "Tian, 
 Kevin" <kevin.tian@intel.com>, "Peng, Chao P" <chao.p.peng@intel.com>
Subject: RE: [PATCH v6 14/22] intel_iommu: Add some macros and inline functions
Thread-Topic: [PATCH v6 14/22] intel_iommu: Add some macros and inline
 functions
Thread-Index: AQHcKHqXFmtIluodWUWcPlU/8kfXxrTABoKAgAFLLzA=
Date: Tue, 14 Oct 2025 06:15:11 +0000
Message-ID: <IA3PR11MB913608AC74B6A3E53437F37A92EBA@IA3PR11MB9136.namprd11.prod.outlook.com>
References: <20250918085803.796942-1-zhenzhong.duan@intel.com>
 <20250918085803.796942-15-zhenzhong.duan@intel.com>
 <50fcdab9-b635-43f4-b3ba-21fef152459b@intel.com>
In-Reply-To: <50fcdab9-b635-43f4-b3ba-21fef152459b@intel.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: IA3PR11MB9136:EE_|CH3PR11MB8703:EE_
x-ms-office365-filtering-correlation-id: 57ff9942-ae67-4f63-5941-08de0ae90857
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
 ARA:13230040|7416014|376014|1800799024|366016|38070700021; 
x-microsoft-antispam-message-info: =?utf-8?B?ZmZsRjhMRUdCSkl5UjdISjRBdzlnZGYzWXRFRlczSnM1UUxNTUxhZ1NOSi9K?=
 =?utf-8?B?YnRlOFBGNFBnUjhFbGVVbkovS2M1dVBCanQzZGRycURKSnpOd1VNbFlEemtt?=
 =?utf-8?B?NlZSazlzblpqN0h1WGJBNy9VL1lNdDNkNGpUQ3FkbXFsWUFNWVlER1BheDYv?=
 =?utf-8?B?VDkraUtObDc0WDRuZVB1dkxQSkIrUjdvdmxXeXBUYXdrWXovbndoZGlySUFt?=
 =?utf-8?B?bytsTVYwd252QU4xa1FwYUcxazdXcW9ZdXNUWmo5a2VJKzFVVnlZVTd0Zjkz?=
 =?utf-8?B?dyt5RExaOGltQXBSZ3JRVWtIekRmT1llYXQrckJTMkUvZTZ2eTZiVU5GaWFr?=
 =?utf-8?B?Q3AxZUFrak5EUHB5V1lWem5PTUs5eXRvUzh5SmZZZUs4Ny9meHgvc1lmWUtB?=
 =?utf-8?B?aDVaOHh6RFNJWEN1b3c4SWIrOHRPeWE0S2FpbkRZeEsrNUFFZ0VIVnlQb05a?=
 =?utf-8?B?VDN0NHF4dWJMWCs5ZTRrS1ZCLzB0SWtmQnpZRzQ3QjRuYkhOVWtBM0o3Y0FV?=
 =?utf-8?B?cC9FYkZteWVxcGFCZW5kcFExc2p6aTFTSW9ocm9OM0dWb25RZmNVdlFHcmQ4?=
 =?utf-8?B?ZjR2VmIwcSsyeTJjNS84RktGbXdLUUxxR2Q0NWNtQTlxTjk1U2hjVzJvS1Nn?=
 =?utf-8?B?aEpGc0xlZ0lBVTV1cFZaM1V2SGc5SDZ4RzZXdFh1R0JjMHhuSjFlQWJyN2tr?=
 =?utf-8?B?Kzg3a0ErazBiNnJueUNIZU1UZ1BvZFV5UHpCSFBDRXJSSU9ZSElqaUk1WGNU?=
 =?utf-8?B?Qk1DRWxmZUVEa0dCSkREZDhCTG1yblJ6R09CWEdEa3VmMVQwSmdIeU9IQUJ1?=
 =?utf-8?B?OUNUZ1FJNlFBV29lMmRnTnNwQmZndWM5RlBBM0dTMWp5aE9iYTZ4UHdjeG10?=
 =?utf-8?B?QnBhZkx6VFFPL0NuODNZdkFYY09pZTJYWWxaMm5FRE9hS3BYTmtWTE9kY213?=
 =?utf-8?B?TkY2U3pVREx6ekE3U3BTTXdwNXZCYVZMYURPZXJCK2JJaGh3NGU5S0tiVGR5?=
 =?utf-8?B?MWtuN041MVhUQksycXZPMm9HT0VrcE5SVkxmUWhOSTI2K1dIMHRXb2FIZ2ZB?=
 =?utf-8?B?VWF1K1dtcExPRjdidC8wNTlCa2hvdVJpNTZKWGk1WnY4U0czUTQ0Z1MveUdR?=
 =?utf-8?B?WlV4RFp4eUcrSE9TQy9VbTY5RXJSckJhWHpISDhwenlOa3JxSXI2RTdqOVZO?=
 =?utf-8?B?Sko2bDF2TjlrbFovY25JMXZZdWEvTkZ2Qm1lUnVFNzM2bFhabG10SFp5T3g4?=
 =?utf-8?B?RUN1T2M2N3FwL2lsbElaa2tQSjRSMkZuQjRaQ2VLeTFIWWwzMmJqWlVPUk9q?=
 =?utf-8?B?NUVzYm16cDBWeFN2RzBHZmZjTUIyR2g2VEdROFF3djJWQ1dxRnJmQTRjVnow?=
 =?utf-8?B?azRHbjg1dC90UENYamFYeHBSbGtkNDlocjRDc1dXcEZhQmh3SzNabXBmSy9l?=
 =?utf-8?B?QmI1dnhmSXZzWnFSYmZUOGtvbm1rc2lmZnkxeEwrQjJ4Y2hza3B6dnBYVDg4?=
 =?utf-8?B?UWdRS3NITTNiZFZTbDFWdlMxNEY2VUt1eVdLYTB1MEg3WEx6aFZQUHVlblAy?=
 =?utf-8?B?RGpLRWJ3OEhVSkNDU0tISHZlb2xEcDhwbnovS1BPYXdXOWpMSVNlVXVkbUZm?=
 =?utf-8?B?ZkVPZThaL2J6MDl4bTBlakJ2WWd2ekdtU1dvYm1YNlV4NGQvUXp2VkZKUHBH?=
 =?utf-8?B?UkJSU1FKOFUzNFRQc05wY3ZjdUZtaVM4U2JFWm5YQkpFRjVrS054WCtDRUto?=
 =?utf-8?B?Y0I4WjQ5NnByVEJEUDJaMnlQL2dJcTh1QTYvS1ZBZ09YVCtKbWt3aXB1c0g2?=
 =?utf-8?B?ZXU4VlhENTFtZTB1cithOUNTbmQ3SmxmYVJqMmFJRzdqNzZib1ZzbnF4VWo1?=
 =?utf-8?B?ZUdybGtQbXNJR3JiODk5ZHR0Zm1UVEY4cUVmWkl5UERmTlZPL1RaeVo5YWRw?=
 =?utf-8?B?VzNmU2JHOVdZWjM1b1hzWDBQZjFCcDJtWG1uQXIzY3pLL2JrSzhjY3d2Uk1a?=
 =?utf-8?B?SEx1TkNncTdLcnZpa0lySytxVXN1a1NXZCt3MThtWTZpeXVVUi81cEV4eDRh?=
 =?utf-8?Q?ynghuA?=
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:IA3PR11MB9136.namprd11.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(7416014)(376014)(1800799024)(366016)(38070700021); DIR:OUT;
 SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?TG1qWnVRSlFxbnl4L0loSU1QSFh3RjlkTnlSMnlFNDI5c2pZQlhSb1dXYTJJ?=
 =?utf-8?B?K2NBWmkrZEdQYVFpVXF1QjFEaTgvYjdvWkQ3L1AwVFJSVmYwSmVudlV5aUly?=
 =?utf-8?B?bkFHMmY5ODJRZUttUUlwdHQyTmJDWGMyS2Fqbll5UVhDZnZqck9YK3FQQ0Zl?=
 =?utf-8?B?ZEJ2WHFxR0dGQjRFSHhocndRZVI2SzhQSGZkQVBXL0lZNnRkSkp6ZnA0R0dI?=
 =?utf-8?B?U0trQit6NSsxQWl1Z2dZUjljczAyUXp2RGF4ZW9nSTUxRkFPTVM5eFdkWXNa?=
 =?utf-8?B?UCtMQi9pR3YxeSs1bm5nZFJHWWwvd2RPZ1dFMjkvVUZSMlZXV2RmckZ4ZkZU?=
 =?utf-8?B?MGlCUGZPbEs0djRycGR2RWkyUnFuSmJ5aWdFRE5saC9NckpXREpDR0JEVkJD?=
 =?utf-8?B?YjZsdkxXZ2cwcEp5aTR5VnRYRlV0UUhvaU9DV1hkdm1GaTNjRXkvcE8vNlBK?=
 =?utf-8?B?UmNpKzM0TDdnVEIxaTV1UlJYUzBrSUg2Mk80RVV3cjB1SFAraERkU29nd3Ev?=
 =?utf-8?B?d0hsZlA0Vld3MjRkQWxxb0x6TTcydVNpdXZFMmYrWjlIc2tBek9xU3RmbDA3?=
 =?utf-8?B?c2t6cjQrL1Fwa0thN2czanBtc2tUelhvT1lGUkZDU1FGOW1JOWsyOWhJRlA1?=
 =?utf-8?B?RkJpajJlK2tTR2ovblhFMUs4QlZFem9pdTQyUURQQnNtYTdQWDV3dVVrTjBl?=
 =?utf-8?B?NzdObStkWWJUWWt4TTJVYi9OWDNDdGpYekNxWURHZWdJZjVYL3ZJSXJBMmNo?=
 =?utf-8?B?KzNNQWd1MGRUMHozRDh0VFdUWVpJa1BFV29OdlhLZ1dYMWorMmhCcUhqWElt?=
 =?utf-8?B?OFh1c3JvTDc2cnRYRThuc0NWaGwrcU1pUVIyRXQzZCtaL00xRldXK2hXZisv?=
 =?utf-8?B?WXNsQXNvQVdzbExXNUxQZURHWmZTYkdwcWlYbVFndTI4VE5rdTBORWFxM2JG?=
 =?utf-8?B?aGpLRjBoWmpkY2VsRTJmckowcERKNzl6ZS83QmlWYXEzR3lMaWRvRC9kWWpB?=
 =?utf-8?B?V2tFT2pOaEFiZTllVHVjS3l5MTV6alVZZkpWT2lXeDR3bmVwU0gwU1ppbXE2?=
 =?utf-8?B?QW0zaUhnWWdTeERRSjIySW5xQlBGOFc2UWJsaTN3M2owaHBXWndveWVRcExF?=
 =?utf-8?B?emhsMnhIUVA4N1FIRFpzRS9yblBlSDRYc2dDUFJLVTU4dURqUktYUGVnYlkr?=
 =?utf-8?B?YVFJKzYyRllub0xDZDJNOE92Y1pzeWczS3NWY0ZMQUR2WUlLT21TZkpzcU9r?=
 =?utf-8?B?SFJUYVFXTGxoRVgrTWIxaUxXZ2V0UlgvMk9lRUNkR2YvNTcxUW00ZjY3K0My?=
 =?utf-8?B?MGxTaUF0MHlKaXorZlpiZ3h0Q0FGbEV1cys2SkdzeXpmeHZOZW9EcGlubk16?=
 =?utf-8?B?cGY0TlFXbG1maU0rQm0xTVp2TjRkR0RDTlJFOUdJbW5mRW1DL0ppWWovd1l0?=
 =?utf-8?B?UGZHVURVWmlRSFVtRDhPTUxqUnBGeTdZWFhXSmloYUhRaFIwZU5KNVUvTnE2?=
 =?utf-8?B?enpOTnB5djU2N1lubmhwY1dydVhkdFhLQUVtOVVDR25jc3RLOWtjc3pkVENC?=
 =?utf-8?B?eUEwWEJxZmNScG9LaEsvNE4yQk9aV00rcE1vMWlCN3JEVk9lWSs1YUhxRkI2?=
 =?utf-8?B?RmFBZ2tYTndOd2FvcTFZMmZhc1NLN201RDc4NW1BbldhR1M1MjlXNUpjY2hL?=
 =?utf-8?B?aVhFZWgvaTY3MEtza1VRVjdIdloySkRQVXcvdDhONm5UcVBjN1FBTEdyUS9m?=
 =?utf-8?B?a0FvR0dlbFVvMjFaVE1qb3lrdE8vOVNFUGovWWViV1dSVnlsZld2YnpjZDRO?=
 =?utf-8?B?K0syanREY1BFZWJPRVlRRnlaK2k3emxBV3V6dW5sbGFZVmY2YzZycmNoalp2?=
 =?utf-8?B?VmJkQkZmTUFaWXBzVUN3aUx0NnFoU1NhbW1rZnVuakxOU3FjYUJveVVacFI1?=
 =?utf-8?B?SjZlUTM1NlNGTGZqZThya3dma0lHSnVkdW9ERHJHWitTS29vYXkxbHN3UEVS?=
 =?utf-8?B?YnB1Z1NtQUpZL2I0T2FWVlFsSlJpZkh2ZGtNbHk2V0E3Nk9RYlp2bEQ5MG0r?=
 =?utf-8?B?dE5kNjlXN1hhczVaRnNhMEdRLzRvcE5hZFBMWG9UVWY4ajgremdLcnF2UXJG?=
 =?utf-8?Q?cMwRLBtM81VmsHuXZTmyyZvxv?=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: IA3PR11MB9136.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 57ff9942-ae67-4f63-5941-08de0ae90857
X-MS-Exchange-CrossTenant-originalarrivaltime: 14 Oct 2025 06:15:11.6514 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: S6vDsD+FAWKIH8lvHQefH5CqhYo4FRXb9VHw9CQB2iRUMZLTSe4j/ZhQxaTN+b+bVSuY45f4PKbDGCaqzND1CyxAiLu5omxEN1rTxySdxhs=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH3PR11MB8703
X-OriginatorOrg: intel.com
Received-SPF: pass client-ip=192.198.163.10;
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
aXVAaW50ZWwuY29tPg0KPlN1YmplY3Q6IFJlOiBbUEFUQ0ggdjYgMTQvMjJdIGludGVsX2lvbW11
OiBBZGQgc29tZSBtYWNyb3MgYW5kIGlubGluZQ0KPmZ1bmN0aW9ucw0KPg0KPk9uIDIwMjUvOS8x
OCAxNjo1NywgWmhlbnpob25nIER1YW4gd3JvdGU6DQo+PiBBZGQgc29tZSBtYWNyb3MgYW5kIGlu
bGluZSBmdW5jdGlvbnMgdGhhdCB3aWxsIGJlIHVzZWQgYnkgZm9sbG93aW5nDQo+PiBwYXRjaC4N
Cj4+DQo+PiBUaGlzIHBhdGNoIGFsc28gbWFrZSBhIGNsZWFudXAgdG8gY2hhbmdlIG1hY3JvDQo+
VlREX1NNX1BBU0lEX0VOVFJZX0ZTUE0NCj4+IHRvIHVzZSBleHRyYWN0NjQoKSBqdXN0IGxpa2Ug
d2hhdCBzbW11IGRvZXMsIGJlY2F1c2UgdGhpcyBtYWNybyBpcyB1c2VkDQo+PiBpbmRpcmVjdGx5
IGJ5IG5ldyBpbnRyb2R1Y2VkIGlubGluZSBmdW5jdGlvbnMuIEJ1dCB3ZSBkb2Vzbid0IGFpbSB0
bw0KPj4gY2hhbmdlIHRoZSBodWdlIGFtb3VudCBvZiBiaXQgbWFzayBzdHlsZSBtYWNybyBkZWZp
bml0aW9ucyBpbiB0aGlzIHBhdGNoLA0KPj4gdGhhdCBzaG91bGQgYmUgaW4gYSBzZXBhcmF0ZSBw
YXRjaC4NCj4+DQo+PiBTdWdnZXN0ZWQtYnk6IEVyaWMgQXVnZXIgPGVyaWMuYXVnZXJAcmVkaGF0
LmNvbT4NCj4+IFNpZ25lZC1vZmYtYnk6IFpoZW56aG9uZyBEdWFuIDx6aGVuemhvbmcuZHVhbkBp
bnRlbC5jb20+DQo+PiAtLS0NCj4+ICAgaHcvaTM4Ni9pbnRlbF9pb21tdV9pbnRlcm5hbC5oIHwg
IDYgKysrKystDQo+PiAgIGh3L2kzODYvaW50ZWxfaW9tbXUuYyAgICAgICAgICB8IDMwDQo+Kysr
KysrKysrKysrKysrKysrKysrKysrKysrLS0tDQo+PiAgIDIgZmlsZXMgY2hhbmdlZCwgMzIgaW5z
ZXJ0aW9ucygrKSwgNCBkZWxldGlvbnMoLSkNCj4+DQo+PiBkaWZmIC0tZ2l0IGEvaHcvaTM4Ni9p
bnRlbF9pb21tdV9pbnRlcm5hbC5oDQo+Yi9ody9pMzg2L2ludGVsX2lvbW11X2ludGVybmFsLmgN
Cj4+IGluZGV4IGQ0MDBiY2VlMjEuLjNkNWVlNWVkNTIgMTAwNjQ0DQo+PiAtLS0gYS9ody9pMzg2
L2ludGVsX2lvbW11X2ludGVybmFsLmgNCj4+ICsrKyBiL2h3L2kzODYvaW50ZWxfaW9tbXVfaW50
ZXJuYWwuaA0KPj4gQEAgLTU5Miw4ICs1OTIsMTIgQEAgdHlwZWRlZiBzdHJ1Y3QgVlREUEFTSURD
YWNoZUluZm8gew0KPj4gICAjZGVmaW5lIFZURF9TTV9QQVNJRF9FTlRSWV9BVyAgICAgICAgICA3
VUxMIC8qIEFkanVzdGVkDQo+Z3Vlc3QtYWRkcmVzcy13aWR0aCAqLw0KPj4gICAjZGVmaW5lIFZU
RF9TTV9QQVNJRF9FTlRSWV9ESUQoeCkgICAgICBleHRyYWN0NjQoKHgpLT52YWxbMV0sIDAsDQo+
MTYpDQo+Pg0KPj4gLSNkZWZpbmUgVlREX1NNX1BBU0lEX0VOVFJZX0ZTUE0gICAgICAgICAgM1VM
TA0KPj4gICAjZGVmaW5lIFZURF9TTV9QQVNJRF9FTlRSWV9GU1BUUFRSICAgICAgICh+MHhmZmZV
TEwpDQo+PiArI2RlZmluZSBWVERfU01fUEFTSURfRU5UUllfU1JFX0JJVCh4KSAgICBleHRyYWN0
NjQoKHgpLT52YWxbMl0sIDAsIDEpDQo+PiArLyogMDA6IDQtbGV2ZWwgcGFnaW5nLCAwMTogNS1s
ZXZlbCBwYWdpbmcsIDEwLTExOiBSZXNlcnZlZCAqLw0KPj4gKyNkZWZpbmUgVlREX1NNX1BBU0lE
X0VOVFJZX0ZTUE0oeCkgICAgICAgZXh0cmFjdDY0KCh4KS0+dmFsWzJdLCAyLA0KPjIpDQo+PiAr
I2RlZmluZSBWVERfU01fUEFTSURfRU5UUllfV1BFX0JJVCh4KSAgICBleHRyYWN0NjQoKHgpLT52
YWxbMl0sIDQsDQo+MSkNCj4+ICsjZGVmaW5lIFZURF9TTV9QQVNJRF9FTlRSWV9FQUZFX0JJVCh4
KSAgIGV4dHJhY3Q2NCgoeCktPnZhbFsyXSwgNywgMSkNCj4+DQo+PiAgIC8qIEZpcnN0IExldmVs
IFBhZ2luZyBTdHJ1Y3R1cmUgKi8NCj4+ICAgLyogTWFza3MgZm9yIEZpcnN0IExldmVsIFBhZ2lu
ZyBFbnRyeSAqLw0KPg0KPmhtbW0uIGlzIHRoaXMgbWlzc2VkIGJ5IHBhdGNoIDAyIHdoaWNoIGNs
ZWFucyB1cCB0aGUgRkwvU0wgbmFtaW5nIHRvDQo+RlMvU1M/DQoNCkdvb2QgY2F0Y2gsIGZpeGVk
LiBJIHRob3VnaHQgSSBoYWQgYWRkcmVzc2VkIGFsbCBvZiB0aGVt8J+Yig0KDQpUaGFua3MNClpo
ZW56aG9uZw0K

