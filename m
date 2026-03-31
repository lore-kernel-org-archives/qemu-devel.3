Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4D8D0FF60CF
	for <qemu-devel@archiver.kernel.org>; Tue, 31 Mar 2026 07:18:47 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1w7TMz-0006If-Q6; Tue, 31 Mar 2026 03:18:37 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <zhenzhong.duan@intel.com>)
 id 1w7TMu-0006H0-T2
 for qemu-devel@nongnu.org; Tue, 31 Mar 2026 03:18:35 -0400
Received: from mgamail.intel.com ([198.175.65.11])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <zhenzhong.duan@intel.com>)
 id 1w7TMs-00045I-Bp
 for qemu-devel@nongnu.org; Tue, 31 Mar 2026 03:18:32 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1774941511; x=1806477511;
 h=from:to:cc:subject:date:message-id:references:
 in-reply-to:content-transfer-encoding:mime-version;
 bh=nKyM3ndpB44WCH+iY0a+dD6byVPFrb+NDJDnmZetezo=;
 b=i/K9wkdl+vi3V0o79QQBbwVuva3BA2p0pDxo1M+zc9WxAaQt73q19/41
 0K9PuZx7bNIip/fsk2ztItv1183hMsrvK34THea/HSPFe69KEX27PrHQc
 suWrhBvvGk6On3Xh1yz702PZn2YxeJQo1WuZ3oe0K3kW7Fc3aubceRATb
 J7gfHflYWe4OYB2ZwG/d0Whk2NMDHbLSMvmkbrME2Z9Q9nRMxevu16KhA
 nleK9/44s2X4yJswQqYlCjRmVcBegGDaKOMIoS4x+xN9+CFU42RPwVk1M
 CaKPTFy8gkdtW3po8tv/j695ZruvoyOQGwe2lipAZuKq31iCHUsO3KE+a g==;
X-CSE-ConnectionGUID: D9NpN94LQsSZwABwLRAl7w==
X-CSE-MsgGUID: rXYehbc0TSm6zX3Su3PKgw==
X-IronPort-AV: E=McAfee;i="6800,10657,11744"; a="86245166"
X-IronPort-AV: E=Sophos;i="6.23,151,1770624000"; d="scan'208";a="86245166"
Received: from orviesa009.jf.intel.com ([10.64.159.149])
 by orvoesa103.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 31 Mar 2026 00:18:27 -0700
X-CSE-ConnectionGUID: 0mt0iheYS0muZtuiPxGX8w==
X-CSE-MsgGUID: QVscfPfoTcy7LHX+uCg9oQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.23,151,1770624000"; d="scan'208";a="226161574"
Received: from fmsmsx903.amr.corp.intel.com ([10.18.126.92])
 by orviesa009.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 31 Mar 2026 00:18:26 -0700
Received: from FMSMSX903.amr.corp.intel.com (10.18.126.92) by
 fmsmsx903.amr.corp.intel.com (10.18.126.92) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.37; Tue, 31 Mar 2026 00:18:25 -0700
Received: from fmsedg903.ED.cps.intel.com (10.1.192.145) by
 FMSMSX903.amr.corp.intel.com (10.18.126.92) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.37 via Frontend Transport; Tue, 31 Mar 2026 00:18:25 -0700
Received: from SN4PR0501CU005.outbound.protection.outlook.com (40.93.194.66)
 by edgegateway.intel.com (192.55.55.83) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.37; Tue, 31 Mar 2026 00:18:25 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=EgMZGx8XdE+mjuAvXeqH14ls5nn/NosO/k8UDZPVP2TaKgIcr0xfz3Dl1aozDPOnawfrTptLMqMQ7MF4ke+i/W/jjsE16P109WUMUy9KQ1n3D9yNy6Dt891z2e+W5s5JQnvwiQA/DmmRKKZUOpmkNRi2VIeALDwyFMeGwFNnqzU5MqkSMekHzW0SN+dI2AG72+Shtgg1JPJz8pjM4p67t7A29Eluq2Tucbp7jK2lwn+o43RestKPYm3rovpDkGBmA6d/lweseLSneGxwur3svsHzwjiqMymXMhxez+XWK3Bo/8Amn5ZF4G8mKlO1ROQkCWYEhuG4uZnHumQZxCxycQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=nKyM3ndpB44WCH+iY0a+dD6byVPFrb+NDJDnmZetezo=;
 b=KOSgveq70eNa51+z5qoQ0FjhKsmTPNR/4yVbX5qfhMa2lunIW8k8umN8eX70bkWRabpROyGHxy/isMMQVCQTKgDv/SD0Omi9DiT6M4NU2KHm7q2KdW0zp34XYViIruUk4OdvWWR4yAK/W/N5LzM7q0m28SOviyn4ieZbUv6Uu4K/QgG2kx1FN4jVbdZY6jVQix2i+SbqdYYuhwvS7ouOTAG4DvcQY4lKS0HOXMBQ0ush2m8pUL4BlAKBT2VA9d7TYNaW/Wyf7/y90lz+FXc5INfkT1iSYrvwBBOArYyp0fR7jLtzIdo8OUFBZOpL3RpyWBIsGplFTW/EK8cSnuR8ag==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Received: from IA3PR11MB9136.namprd11.prod.outlook.com (2603:10b6:208:574::12)
 by DS7PR11MB6223.namprd11.prod.outlook.com (2603:10b6:8:98::19) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9769.8; Tue, 31 Mar
 2026 07:18:18 +0000
Received: from IA3PR11MB9136.namprd11.prod.outlook.com
 ([fe80::37b4:37a9:4f3:518b]) by IA3PR11MB9136.namprd11.prod.outlook.com
 ([fe80::37b4:37a9:4f3:518b%5]) with mapi id 15.20.9769.011; Tue, 31 Mar 2026
 07:18:17 +0000
From: "Duan, Zhenzhong" <zhenzhong.duan@intel.com>
To: CLEMENT MATHIEU--DRIF <clement.mathieu--drif@bull.com>,
 "qemu-devel@nongnu.org" <qemu-devel@nongnu.org>
CC: "alex@shazbot.org" <alex@shazbot.org>, "clg@redhat.com" <clg@redhat.com>, 
 "eric.auger@redhat.com" <eric.auger@redhat.com>, "mst@redhat.com"
 <mst@redhat.com>, "jasowang@redhat.com" <jasowang@redhat.com>,
 "jgg@nvidia.com" <jgg@nvidia.com>, "nicolinc@nvidia.com"
 <nicolinc@nvidia.com>, "skolothumtho@nvidia.com" <skolothumtho@nvidia.com>,
 "joao.m.martins@oracle.com" <joao.m.martins@oracle.com>, "Tian, Kevin"
 <kevin.tian@intel.com>, "Liu, Yi L" <yi.l.liu@intel.com>, "Hao, Xudong"
 <xudong.hao@intel.com>
Subject: RE: [PATCH v1 11/13] intel_iommu_accel: drop _lock suffix in
 vtd_flush_host_piotlb_all_locked()
Thread-Topic: [PATCH v1 11/13] intel_iommu_accel: drop _lock suffix in
 vtd_flush_host_piotlb_all_locked()
Thread-Index: AQHcrRueV4S7cttZ6U6X0YZKvVaD9bW1kyWAgAAOusCAASn/8IARjtSAgAAGb3A=
Date: Tue, 31 Mar 2026 07:18:17 +0000
Message-ID: <IA3PR11MB913601196392D72E02E5AB579253A@IA3PR11MB9136.namprd11.prod.outlook.com>
References: <20260306034409.184873-1-zhenzhong.duan@intel.com>
 <20260306034409.184873-12-zhenzhong.duan@intel.com>
 <1b2b191e2f9f1315c883ed2de4fb9644a01c8713.camel@eviden.com>
 <IA3PR11MB9136F0D294E9FBE576E0CF91924FA@IA3PR11MB9136.namprd11.prod.outlook.com>
 <IA3PR11MB9136B3C106DDF70856F27FE6924CA@IA3PR11MB9136.namprd11.prod.outlook.com>
 <bdc0f51e1496c841a4f3392ec3e775e6a69b57e1.camel@eviden.com>
In-Reply-To: <bdc0f51e1496c841a4f3392ec3e775e6a69b57e1.camel@eviden.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: IA3PR11MB9136:EE_|DS7PR11MB6223:EE_
x-ms-office365-filtering-correlation-id: 5125b71f-52d9-4621-4320-08de8ef5ae76
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
 ARA:13230040|366016|376014|7416014|1800799024|38070700021|22082099003|56012099003|18002099003;
x-microsoft-antispam-message-info: Ras1WPD23Gkb5W63YuP0oVW5ycY07ZdUyJ8U8tM3NvAXJr9szU3p1wum/hurJNOAbLvML8aN0+zgxozUE+/4R2Xg/YyHosF9nJTw7l11t93GMeq09amH+zkN7cF08cTLYkGGub4J3v9SRJGC7F+KOxUerfVoNHVpFhdgbmbF5eIKclfhAAPY0eGEXmAtlbjrCXFthGfN8DLrGNxKO2DW3bhebToW4I2QaUcQsIejg34uon3aC8C1G4w6yKQZB6C+4hxDjqCpFCE6a58N+F0KzcInUXQ/nL8YHfQzI0d/81H8W/DLQca1eeadX5RxAmcvN1Me75jucTUxPvcFb42H/YMOQK8REB7G5fzZn/ZZIdcafltxFDzv2U68NCDNBzw8LeWtfcA9v19pIRM44RepZNSJpW7AVlIEgj/SAPsl9MBx3UUZeYcbWEoOJbGZee5OysxHt1jnmA/R8LxrjCTWfSlG//8KW1bxfiojoTwVd9E0SJHPnVoKN10kZ/njJADRzmtaMnHSevR4A6hBHqUNKK0yN3cLAswIAjwzHuvov6k/r03ycxRXbGpIRPOOMLGyx9RiaYfuormqPNrzW1vf9edMNnWTlO2L3+iIIA007LxNjnIUxXpJZ9Q/6D6XLJkzZt2ChJ12oK1EtIDCDDT5Xp71q3auC+giTh/XFb1ft0Vj/eBWmS2meLNB3Ak9/t6n5n4Tz5j2UlTPTAwxypL+HnsMHf+uP5P5JiiKM4+zm8n1cFX3bODYW9/kld8FkAHaI4k5QLi6LC4QjC2oTpiIK9PEDalv8N66GkiNnzgdKUs=
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:IA3PR11MB9136.namprd11.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(366016)(376014)(7416014)(1800799024)(38070700021)(22082099003)(56012099003)(18002099003);
 DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?OG94TksrenBvbjAvZ1F3dGtwaDJ0clNtN1cxYWxRUnlKREZwRU1nNEhBOSti?=
 =?utf-8?B?V28zcy9uSjNqVWw3M1E1QzBSOUlIVmExWXg3WTVPaFFtME96UFRvVlVEMTdt?=
 =?utf-8?B?MmFZSWM1K3AwYk5EY1lvalRldkM1VmdvNkdPSFhLMUo5L0RTZUtWYkx5S01z?=
 =?utf-8?B?R3BaVDRlcSt6NHQxYlNNck9yQi93OXR6WEZHTVRlbE5jZ2crWTJrZU9jL09t?=
 =?utf-8?B?K05DN3hYQ1hLYVFXbG14bi95V0t3TDJLeElzNUd0VHd0SlBQTXBzdzlhdzdL?=
 =?utf-8?B?WUlIQUd3K0xVQUo4aTZwYnRDeGYzNTdRdFMrWC9XcTlMNlE1c0V6eFBzVHNu?=
 =?utf-8?B?dGowODZBWnBrMFNHVGhKVXE1ekMyTE9HUzBZNUZqdTBBRWk3cGRYZkZYUVYy?=
 =?utf-8?B?K01rRE5PVlFVOHB5ZVowSlBnbFk5cVI1S3piSy9LamM3b0JYNmJIckxvZFRk?=
 =?utf-8?B?NEJ6bEVYbUt4cnZxNjBRMTljL3VvcVdLRTdnVmtWYjJoMndSeGJkZ0ZDbGht?=
 =?utf-8?B?Tkl2ZW1lSzF5YkptclFYRFlpUzlWcE02ZlJPV2xqK0hadnhRZ2tjT040OUtM?=
 =?utf-8?B?V1YzR3F5b2RUTjBSL2VPNW4wZ095TjVsM0EreWdJUTNNQVNSWS9UUWh4UXlW?=
 =?utf-8?B?ODg1WXp2WklWVzRCYzdVYTVtRjk4aHBxR3R1VWRYWENyR3RrUGZkNEgvcGI1?=
 =?utf-8?B?VUgwcjFPeFNWbEwrZjZHTytqblhCSGJyQTA1ZXVEUXEydEg3TUxMaTR4WERV?=
 =?utf-8?B?WGlCNS9ET0cyN0RhRkFvY2FNanZOaHE0YllDaGxzelU4ZG1NQkk4OUNVczBO?=
 =?utf-8?B?NnNLa2tNa2ltZmtjQ2FCNkphbDBScUtaMkUrazRWSkVJcUJoajZtSHJ4ajA5?=
 =?utf-8?B?QkZ5UituS3M3M2N6VXhRWlY0WnAxSytnNW5XUE1raTRqTm9wZzRCK2xHUzRt?=
 =?utf-8?B?ZEVzbi9VdGFzY3RPUHpqYmhQWkRDNVRlN2YxazFuSWdnOTRjYzVFWmxlS2NW?=
 =?utf-8?B?SERQVUVFRGFHQjJjTmM0Y3pMTkRnV3lyc1FZT2ZMcDQvRHg5b2tJV0R6Rzdp?=
 =?utf-8?B?RFZDWFZsLzVWVklGTUtUWnhpKzZXeFVJWXdaaUdqbklsYlNsQkQ4M2xKUkVm?=
 =?utf-8?B?djRGTFk0b0xOQjRVUVE2T2NlNlRVaXFFbmZxNGRTR09YM1U2RnhKcU95LzdX?=
 =?utf-8?B?clF1VjR0SWJWbFJQSk52bG05VUJsTlFGeW1aVWtJSzhUT2lwOFdnSER4TmpU?=
 =?utf-8?B?anA3YWxTcitWeEhZb1RNSEpISTMzOVArd1J1aFdCQnFZc2RHMCt1UVJCQXFy?=
 =?utf-8?B?RzVHN01oZmpXa3hNbXkzTTVlK2psem93VFk3N25EQWEvSm5CZ05aYmFmQnA5?=
 =?utf-8?B?MmQvQ3NVdktBQThCZFQyRnVYekVxT2NoeTRMdEFTY0dBUHhUTi9KbGE2bU1W?=
 =?utf-8?B?b25hUnhHME5XSmZrRVdIZ1gxMFJ1K2NLdTR4WFA0Vjc5NnFQQkZKMUY0YzdH?=
 =?utf-8?B?TWtiNHhXbEI0Z3ZDTmhvQUhVcS93UnlycGRkbEczeWhuYXdhbldLSXRySU1l?=
 =?utf-8?B?Y24weWdSODBUeVNZT2dCc2VLNFo4MGdaeDUva3NaZmZkU21QRHd1ZmsrbjFH?=
 =?utf-8?B?RCt3UjBzU1Y5aEJCTUpOY2wyODE0bURrTWNaNmFtWENoai9zVUdrM0tub2pW?=
 =?utf-8?B?UENkS01yT2J0TzJ4RVh0R2g3RmdsQ2ZNTlVXRXhReEp6Uld6N2xUc0tpdmZl?=
 =?utf-8?B?UjJQcUlvazJnaCtTbmFMSFA2R0kzZGhRR1FUYVVsSHk1Z2U2ZGZYc2JPdEhp?=
 =?utf-8?B?OFBYTHpjd2VVRVAySXBqZXpSSEtWeWptTU1EUXRHWGFzK25iYUJsUmR5Z3cy?=
 =?utf-8?B?UGI1Yk55aEVEQnh1Z1VlYjhuQWQxT2czRDZxempnWHBXMXBHRHk3SVg1ekd3?=
 =?utf-8?B?UHovT0VtZFo3YkJHR1NaL0taT0pMSXRQVmJ2MWhZa01GeHg4YWk4N0FZNHU0?=
 =?utf-8?B?MExVVk9LSzVlOHVtZS9BdFlCa0NkVWptMm5WMG5YZ2hiNVVaZjhETW5mTXVX?=
 =?utf-8?B?ZW5aa2MrRExwdXZ6VUk3T0FHSGs1VnhQeHBUR09sQ3k2eXpKb3U2T1c2Z2NQ?=
 =?utf-8?B?MzRpMXcrRzRVME4xV25xYlE1MVdoRk0zbkFid1FlVmVhU0ZhWkRINm1CTHND?=
 =?utf-8?B?VmtPMVM4YkZ2ZVkwWWVrdFJtczFqVkxGa2ZDOERZWTByZUNKaDZic2pJV1Zl?=
 =?utf-8?B?R3dVUDBPTHZTZFdTeTdkMURhMUVUdGthbkhQM1k1ODZsd2h3Mk82UXNuaXJG?=
 =?utf-8?B?NVFOWjlOTjhra0lFczhtRzNTVk8rVGY5L1pXUzRHbjBSbnJWVFV2Zz09?=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-Exchange-RoutingPolicyChecked: lQ5ReuqYAwxMnwzLEg5sG3QzxKI1BhjPslpLdadQTBJoPViOlKcsI6Vz1Bft2jOnscJ2FxO18lg2ijUy59XX4Z6+Jx6awMx6W2qmmCWP7KcnhfGyk3M0OWeKxyazzb3fS3C2/90CqFxniNKA5gx/FHdsy3nXE074dMWOTxgofR1P3VpvozzJ0w9gO3f1bO/5g4sSAiV+Kh6/Qxov/YjWdJei26gGV94D60cFlOIBf/8p7JRjYdmnLDmPyPuPUixnH2c2xeGneDVFjlIVphanRJKD5cyaVHZV9qLnuwxFb3rs69wwljiOgic+AnLN/oia4ZzNZGIBOaXMt5VjYFcb0A==
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: IA3PR11MB9136.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 5125b71f-52d9-4621-4320-08de8ef5ae76
X-MS-Exchange-CrossTenant-originalarrivaltime: 31 Mar 2026 07:18:17.7682 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: VLRK4iFSf0R4olzymgPDrgh5W25c82nkRylamXLAAwVTr6TbNrNgbbSc/8nWKYzWm4C/a51mkhTIj82Zg+aDCEgQ0Fv6Z/euONBS9kbLlnw=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS7PR11MB6223
X-OriginatorOrg: intel.com
Received-SPF: pass client-ip=198.175.65.11;
 envelope-from=zhenzhong.duan@intel.com; helo=mgamail.intel.com
X-Spam_score_int: -28
X-Spam_score: -2.9
X-Spam_bar: --
X-Spam_report: (-2.9 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.54,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_MED=-2.3, RCVD_IN_VALIDITY_CERTIFIED_BLOCKED=1,
 RCVD_IN_VALIDITY_RPBL_BLOCKED=1, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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

DQoNCj4tLS0tLU9yaWdpbmFsIE1lc3NhZ2UtLS0tLQ0KPkZyb206IENMRU1FTlQgTUFUSElFVS0t
RFJJRiA8Y2xlbWVudC5tYXRoaWV1LS1kcmlmQGJ1bGwuY29tPg0KPlN1YmplY3Q6IFJlOiBbUEFU
Q0ggdjEgMTEvMTNdIGludGVsX2lvbW11X2FjY2VsOiBkcm9wIF9sb2NrIHN1ZmZpeCBpbg0KPnZ0
ZF9mbHVzaF9ob3N0X3Bpb3RsYl9hbGxfbG9ja2VkKCkNCj4NCj4NCj5PbiBGcmksIDIwMjYtMDMt
MjAgYXQgMDQ6MDQgKzAwMDAsIER1YW4sIFpoZW56aG9uZyB3cm90ZToNCj4+IEhpIENsZW1lbnQs
DQo+Pg0KPj4NCj4+ID4gLS0tLS1PcmlnaW5hbCBNZXNzYWdlLS0tLS0NCj4+ID4gRnJvbTogRHVh
biwgWmhlbnpob25nDQo+PiA+IFN1YmplY3Q6IFJFOiBbUEFUQ0ggdjEgMTEvMTNdIGludGVsX2lv
bW11X2FjY2VsOiBkcm9wIF9sb2NrIHN1ZmZpeCBpbg0KPj4gPiB2dGRfZmx1c2hfaG9zdF9waW90
bGJfYWxsX2xvY2tlZCgpDQo+PiA+DQo+PiA+IEhpIENsZW1lbnQsDQo+PiA+DQo+PiA+DQo+PiA+
ID4gLS0tLS1PcmlnaW5hbCBNZXNzYWdlLS0tLS0NCj4+ID4gPiBGcm9tOiBDTEVNRU5UIE1BVEhJ
RVUtLURSSUYgPFtjbGVtZW50Lm1hdGhpZXUtLQ0KPmRyaWZAYnVsbC5jb21dKG1haWx0bzpjbGVt
ZW50Lm1hdGhpZXUtLWRyaWZAYnVsbC5jb20pPg0KPj4gPiA+IFN1YmplY3Q6IFJlOiBbUEFUQ0gg
djEgMTEvMTNdIGludGVsX2lvbW11X2FjY2VsOiBkcm9wIF9sb2NrIHN1ZmZpeCBpbg0KPj4gPiA+
IHZ0ZF9mbHVzaF9ob3N0X3Bpb3RsYl9hbGxfbG9ja2VkKCkNCj4+ID4gPg0KPj4gPiA+IHZ0ZF9w
aW90bGJfcGFnZV9pbnZhbGlkYXRlIGNhbiBiZSBjYWxsZWQgZnJvbQ0KPj4gPiA+IHZ0ZF9wcmlf
cGVyZm9ybV9pbXBsaWNpdF9pbnZhbGlkYXRpb24gd2l0aG91dCBhbnkgbG9jay4gVGh1cyB3ZSBj
YW4gY2FsbA0KPj4gPiA+IHZ0ZF9mbHVzaF9ob3N0X3Bpb3RsYl9hbGxfYWNjZWwgdW5sb2NrZWQu
IElzIHRoZXJlIGEgcmlzayBpbiBjYXNlIG9mDQo+Y29uY3VycmVudCBob3QNCj4+ID4gPiBwbHVn
Z2luZyBvZiBhbm90aGVyIGRldmljZT8NCj4+ID4NCj4+ID4NCj4+ID4gR29vZCBjYXRjaCwgaG90
cGx1ZyBpcyBwcm90ZWN0ZWQgYnkgQlFMLCBidXQgaWYgYW4gaW90aHJlYWQgY291bGQgc2VuZCBQ
UkkNCj5yZXF1ZXN0LA0KPj4gPiB3ZSBzdWZmZXIgZnJvbSB0aGUgcmFjZS4NCj4+ID4NCj4+ID4g
SSB0aGluayB3ZSBjYW4gYnlwYXNzIHZ0ZF9wcmlfcGVyZm9ybV9pbXBsaWNpdF9pbnZhbGlkYXRp
b24oKSBmb3IgcGFzc3Rocm91Z2gNCj4+ID4gZGV2aWNlDQo+PiA+IHdoaWNoIGRvZXNuJ3QgY2Fj
aGUgaW90bGIgZW50cnkgaW4gUUVNVSBidXQgaW4gaG9zdCwgbGlrZToNCj4+ID4NCj4+ID4gQEAg
LTU0MDEsNyArNTQwMSw4IEBAIHN0YXRpYyBpbnQgdnRkX3ByaV9yZXF1ZXN0X3BhZ2UoUENJQnVz
ICpidXMsIHZvaWQNCj4+ID4gKm9wYXF1ZSwgaW50IGRldmZuLA0KPj4gPiDCoMKgwqDCoMKgwqDC
oCByZXR1cm4gLUVOT1NQQzsNCj4+ID4gwqDCoMKgIH0NCj4+ID4NCj4+ID4gLcKgwqDCoCBpZiAo
dnRkX3ByaV9wZXJmb3JtX2ltcGxpY2l0X2ludmFsaWRhdGlvbih2dGRfYXMsIGFkZHIpKSB7DQo+
PiA+ICvCoMKgwqAgaWYgKCF2dGRfZmluZF9oaW9kX2lvbW11ZmQodnRkX2FzKSAmJg0KPj4gPiAr
wqDCoMKgwqDCoMKgwqAgdnRkX3ByaV9wZXJmb3JtX2ltcGxpY2l0X2ludmFsaWRhdGlvbih2dGRf
YXMsIGFkZHIpKSB7DQo+PiA+IMKgwqDCoMKgwqDCoMKgIHJldHVybiAtRUlOVkFMOw0KPj4gPiDC
oMKgwqAgfQ0KPj4NCj4+DQo+PiBBZnRlciBmdXJ0aGVyIHRoaW5raW5nLCBJIGZvdW5kIGFib3Zl
IGNoYW5nZSBkb2VzbuKAmXQgcmVzb2x2ZSB0aGUgcmFjZSB5b3UNCj5tZW50aW9uZWQuDQo+Pg0K
Pj4gQnV0IEkgdGhpbmsgdGhlIGlvdGhyZWFkIHNob3VsZCB0YWtlIEJRTCBiZWZvcmUgY2FsbGlu
ZyA6OnByaV9yZXF1ZXN0X3BhZ2UoKSwNCj4+IGJlY2F1c2UgaXQgaXMgYSBmdW5jdGlvbiBjaGFu
Z2luZyB2dGQgZGV2aWNlIGNvbnRleHQsIGUuZy4sIFBRVCBhbmQgUFJTIHJlZ2lzdGVyLA0KPj4g
cGFnZSBpbnZhbGlkYXRpb24gcXVldWUgYW5kIGlvdGxiIGVudHJpZXMuIFdlIHNob3VsZCBhbHdh
eXMgdGFrZSBCUUwgYmVmb3JlDQo+Y2hhbmdpbmcNCj4+IGNvbnRleHQgb2YgYW55IGRldmljZS4g
TGV0IG1lIGtub3cgaWYgeW91IGhhdmUgZGlmZmVyZW50IG9waW5pb25zLg0KPg0KPkRvIHlvdSBt
ZWFuIHRoYXQgZXZlcnkgZW11bGF0ZWQgZGV2aWNlIHRoYXQgdHJpZ2dlcnMgYSBQUkkgcmVxdWVz
dCBzaG91bGQgaG9sZA0KPnRoZSBCUUw/DQo+SSdtIG5vdCBzdXJlIHRoaXMgaXMgYSB2aWFibGUg
cGF0dGVybiBhcyB0aGUgaW5pdGlhdG9yIHByb2JhYmx5IGFscmVhZHkgaG9sZHMgYW4NCj5pbnRl
cm5hbCBsb2NrDQo+YW5kIHRodXMgY2Fubm90IHRha2UgdGhlIEJRTCB3aXRob3V0IHJpc2tpbmcg
ZGVhZGxvY2tzIHdpdGggY29uY3VycmVudCBNTUlPIDovDQoNCklJVUMsIHFlbXUgZG9lc24ndCBz
dXBwb3J0IGNvbmN1cnJlbnQgTU1JTyBlbXVsYXRpb25zIHlldCwgdGhleSBhcmUgc2VyaWFsaXpl
ZCBieSBCUUwuIElmIHdlIGRvbid0IHRha2UgQlFMIGluIGNhbGwgc2l0ZSwgdGhlbiB3ZSBuZWVk
IGl0IGluIGNhbGxlZSwgbGlrZToNCg0KQEAgLTUzNTEsNiArNTM1MSw4IEBAIHN0YXRpYyBpbnQg
dnRkX3ByaV9yZXF1ZXN0X3BhZ2UoUENJQnVzICpidXMsIHZvaWQgKm9wYXF1ZSwgaW50IGRldmZu
LA0KICAgICBJbnRlbElPTU1VU3RhdGUgKnMgPSBvcGFxdWU7DQogICAgIFZUREFkZHJlc3NTcGFj
ZSAqdnRkX2FzOw0KDQorICAgIEJRTF9MT0NLX0dVQVJEKCk7DQorDQogICAgIHZ0ZF9hcyA9IHZ0
ZF9maW5kX2FkZF9hcyhzLCBidXMsIGRldmZuLCBwYXNpZCk7DQoNCiAgICAgdWludDY0X3QgcXVl
dWVfYWRkcl9yZWcgPSB2dGRfZ2V0X3F1YWQocywgRE1BUl9QUUFfUkVHKTsNCg0KPg0KPk90aGVy
d2lzZSwgaXQgbWVhbnMgdGhhdCB0aGUgZGV2aWNlIGFsd2F5cyB0YWtlcyB0aGUgQlFMIGJlZm9y
ZSB0YWtpbmcgIGl0J3Mgb3duDQo+bG9jay4NCg0KSSB0aGluayBpdCdzIHRydWUgYmVjYXVzZSB3
ZSBhbHdheXMgdGFrZSBCUUwgYmVmb3JlIGVtdWxhdGlvbiBzdGFydC4NCg0KVGhhbmtzDQpaaGVu
emhvbmcNCg==

