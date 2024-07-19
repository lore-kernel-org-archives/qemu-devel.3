Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 60DA2C3DA59
	for <qemu-devel@archiver.kernel.org>; Fri, 19 Jul 2024 03:40:37 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sUeTY-000100-Rv; Thu, 18 Jul 2024 23:40:08 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <zhenzhong.duan@intel.com>)
 id 1sUeTX-0000zU-BV
 for qemu-devel@nongnu.org; Thu, 18 Jul 2024 23:40:07 -0400
Received: from mgamail.intel.com ([192.198.163.18])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <zhenzhong.duan@intel.com>)
 id 1sUeTV-00050w-8U
 for qemu-devel@nongnu.org; Thu, 18 Jul 2024 23:40:07 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1721360405; x=1752896405;
 h=from:to:cc:subject:date:message-id:references:
 in-reply-to:content-transfer-encoding:mime-version;
 bh=3TLR1twKQe8zC2I63aMo+OUiw524/WA3WvzMcEZfhIM=;
 b=FUELsjO4JmokCjWsJs6f/V9wg4WxO8ITDa5OB+76dTRy4na6iVjbUSyF
 gjDLQR4+C+EUpk5Gzfc/rTGDxcRegW+0Tg5s6MAks6+hNTkGaPxEfvahb
 R2s9NZANuMjjogemNM8vvYrGdC6I78G6iB4XYwLyDdq70B+v4N96lJ8Y9
 g0+TprAaH7n4MHDVA6TxIIavbyQfZdOopUS3KbZi0SGStTGyN3qesRAjV
 l/yd4MDV8xFHu6YvV/WQo0Dx6JSVvGOSSFVqu+apVR9UUiVInIl82Ekhk
 +2KYaItVHY5VLK+rmhf4D+PjTn4Wp/k/IW5BXtbThrTpPB3ileyXutSB2 Q==;
X-CSE-ConnectionGUID: t1/T+L7sR2O1HnxjN4y9Rg==
X-CSE-MsgGUID: uPtFG/y6Rom1hRiMacsLsg==
X-IronPort-AV: E=McAfee;i="6700,10204,11137"; a="18581492"
X-IronPort-AV: E=Sophos;i="6.09,219,1716274800"; d="scan'208";a="18581492"
Received: from orviesa006.jf.intel.com ([10.64.159.146])
 by fmvoesa112.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 18 Jul 2024 20:40:03 -0700
X-CSE-ConnectionGUID: nK32GeSIQtCMMrwkuxeozw==
X-CSE-MsgGUID: I+h944yTRy2yX2q036btSw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.09,219,1716274800"; d="scan'208";a="51265211"
Received: from fmsmsx601.amr.corp.intel.com ([10.18.126.81])
 by orviesa006.jf.intel.com with ESMTP/TLS/AES256-GCM-SHA384;
 18 Jul 2024 20:40:03 -0700
Received: from fmsmsx612.amr.corp.intel.com (10.18.126.92) by
 fmsmsx601.amr.corp.intel.com (10.18.126.81) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.39; Thu, 18 Jul 2024 20:40:01 -0700
Received: from FMSEDG603.ED.cps.intel.com (10.1.192.133) by
 fmsmsx612.amr.corp.intel.com (10.18.126.92) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.39 via Frontend Transport; Thu, 18 Jul 2024 20:40:01 -0700
Received: from NAM10-MW2-obe.outbound.protection.outlook.com (104.47.55.47) by
 edgegateway.intel.com (192.55.55.68) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.39; Thu, 18 Jul 2024 20:40:01 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=PLDiab3Y5J3jLtTcA7oQEaVOj1OOQgEVJol5um7rzTwbndnOdtRyXbav8WGagmgZ1yJuQZjRM7xLr8hiU5Hy3VFpcvKvYRh4k5BBjudsbBcM4bNdon9kCP46TKLxccEHC1TuOvs1gJpCWrEVkuQtDQ+F5TMMInnsgufdmbNvqcpt9yVGSNfMOFCQZtMbJQTlAEFTJbPWMXJgSdMYdMwwD+p+23UW/N1H328bifCOx/iWCoIJBk+yT6i9h8bdUmqHgAuLFBm2dMRex7VtzI/Uo1mw1DWpubI4FRbYLJ2RCTWZpDCsVluI13tiwKzSBbwsuSL+nxHfkdnLxKlv777STg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=3TLR1twKQe8zC2I63aMo+OUiw524/WA3WvzMcEZfhIM=;
 b=MoUN3UXmYY5J9rOS9wYTpKWirhVukuV4CrabzUCey/Kvu8rsBXYpkmJD3YetDmCe4aL6J5MlD2hNQy2gS1SfHg+12GB5UA07rqkIL2FW1QGeQdv5GgaNNP1xljEilCl2os8lbU2biPGAhzF/0WTfWAJ/zNGdBxiedeVTPZBOZQqfEJhcCpnqr6yn9+O6Co0TpwHaTo+2ZEXUbXldze1Eb1tKBZUerRZTrvSNgfumvLNQHe8AQHiM8KeXfbsjHYyB9peZp3WJwI51bDFqHbOFQ5d9YlgAI/bUhwWb+A8AxRY9n2xp3kH/EjwMEsRyyyWGnkckbAzSTPTFeIpZOJC1lA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Received: from SJ0PR11MB6744.namprd11.prod.outlook.com (2603:10b6:a03:47d::10)
 by DM4PR11MB6262.namprd11.prod.outlook.com (2603:10b6:8:a7::22) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7784.14; Fri, 19 Jul
 2024 03:39:59 +0000
Received: from SJ0PR11MB6744.namprd11.prod.outlook.com
 ([fe80::fe49:d628:48b1:6091]) by SJ0PR11MB6744.namprd11.prod.outlook.com
 ([fe80::fe49:d628:48b1:6091%7]) with mapi id 15.20.7784.016; Fri, 19 Jul 2024
 03:39:59 +0000
From: "Duan, Zhenzhong" <zhenzhong.duan@intel.com>
To: "Liu, Yi L" <yi.l.liu@intel.com>, CLEMENT MATHIEU--DRIF
 <clement.mathieu--drif@eviden.com>, "qemu-devel@nongnu.org"
 <qemu-devel@nongnu.org>
CC: "alex.williamson@redhat.com" <alex.williamson@redhat.com>,
 "clg@redhat.com" <clg@redhat.com>, "eric.auger@redhat.com"
 <eric.auger@redhat.com>, "mst@redhat.com" <mst@redhat.com>,
 "peterx@redhat.com" <peterx@redhat.com>, "jasowang@redhat.com"
 <jasowang@redhat.com>, "jgg@nvidia.com" <jgg@nvidia.com>,
 "nicolinc@nvidia.com" <nicolinc@nvidia.com>, "joao.m.martins@oracle.com"
 <joao.m.martins@oracle.com>, "Tian, Kevin" <kevin.tian@intel.com>, "Peng,
 Chao P" <chao.p.peng@intel.com>, Paolo Bonzini <pbonzini@redhat.com>, Richard
 Henderson <richard.henderson@linaro.org>, Eduardo Habkost
 <eduardo@habkost.net>, Marcel Apfelbaum <marcel.apfelbaum@gmail.com>
Subject: RE: [PATCH v1 03/17] intel_iommu: Add a placeholder variable for
 scalable modern mode
Thread-Topic: [PATCH v1 03/17] intel_iommu: Add a placeholder variable for
 scalable modern mode
Thread-Index: AQHa2OtCWmQl4pZpx0e1R3JC4utGS7H8MJAAgAEmyHCAAAyqAIAAAulwgAABqiA=
Date: Fri, 19 Jul 2024 03:39:59 +0000
Message-ID: <SJ0PR11MB67448D180C7D00AD8F38EA4492AD2@SJ0PR11MB6744.namprd11.prod.outlook.com>
References: <20240718081636.879544-1-zhenzhong.duan@intel.com>
 <20240718081636.879544-4-zhenzhong.duan@intel.com>
 <e41c8b79-1b86-42de-b1d5-dce7ed29d422@eviden.com>
 <SJ0PR11MB6744F86F44C2C32C4B79C80A92AD2@SJ0PR11MB6744.namprd11.prod.outlook.com>
 <9c9dba22-df29-4121-8126-4707084b891b@intel.com>
 <SJ0PR11MB6744F4CAEA5A9627D79AFE2092AD2@SJ0PR11MB6744.namprd11.prod.outlook.com>
In-Reply-To: <SJ0PR11MB6744F4CAEA5A9627D79AFE2092AD2@SJ0PR11MB6744.namprd11.prod.outlook.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: SJ0PR11MB6744:EE_|DM4PR11MB6262:EE_
x-ms-office365-filtering-correlation-id: ace3e47f-eab2-42f9-13f5-08dca7a47714
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
 ARA:13230040|376014|7416014|366016|1800799024|38070700018; 
x-microsoft-antispam-message-info: =?utf-8?B?c1k5ZCtSOXVrWWxiUDZiZGUzQndQcEp3VkxsQmFobWN6a1pVUlBXKzREeUpR?=
 =?utf-8?B?MUpwMlowQ25peDJaNGdiN2JabGlqaFV1RlFKUjJOcGJSbXhaYjYwQmxSUkY0?=
 =?utf-8?B?R0VVc05jVG5qa0loUmNPSnNHNk1YY1UyeWhHVGdOZHB2QUxGQXpVM3gyZkty?=
 =?utf-8?B?K1g0ckR4b0pmeUhDcUIwQnExMkVZbjA5U3kzdzZybkZoRmdreDNQdDNYY2Ev?=
 =?utf-8?B?Ykh5emdxREp3cmpWSFIyQVY2VEtXWHkreGdReldQVElrU0xnVmM2NHU1Y2VP?=
 =?utf-8?B?ei9OQnF3d3lBRys2MCtNNmh4Q3k4Q0JKWlIwcjBhekdMZklITVRrZnVaS1pX?=
 =?utf-8?B?Q3dEZVpWb1RCb3FmZXY5ZURML2FKOFNITE9RRWJWMWlWcTFwdnVQT1JGSHlk?=
 =?utf-8?B?YzlGWkdPSzJSWFBoQ1dvckIxTVdvZFBFUlVvamIvRUlaQWlJZWdiallrRlpt?=
 =?utf-8?B?ZTNqSllqcWlNbU9RKzNFRGcvU0Q2cjAzUW5zcUU3OTFRamZaMkhhNTRpdzRo?=
 =?utf-8?B?OW5iRjNLOUdLWVZjeHVsT21jU1VoTzN1eUZBclkxc2toenFYUnp6REE4WEtl?=
 =?utf-8?B?bFlCcEJWbnNFVUVwT3ZsRmg1RDZud2JvUDZoWmlyOEtMbEVnTUN5dlc1SE9R?=
 =?utf-8?B?bGhPZHlEWjN3NnZFZlM3aXJPWG9oWDFMME1uTDBsUGZlSm93bkl5THNKcmJI?=
 =?utf-8?B?UHFCNVFVejFEVEdneUw0QjIzeG1BYWUxWEhYMTJ5OUdIVVlrK0xXNWszRU0r?=
 =?utf-8?B?VVozQmdGc3JaTDc3QzVwVnl6SFc1N053a0hpWWwwV1JnbW81UVJNcms4K2JD?=
 =?utf-8?B?ZU5BSXJiVUUvMm9PQzVUY2U0WHh1WVNuMkdTMXl6NnlLbDg1ek9nbTZpU0c4?=
 =?utf-8?B?TnljWnpYK0tEeHRadDY2UnU1L3oycDNMb1VvMjdJclJLU1R1M0RHUFp2M2RG?=
 =?utf-8?B?WDVhQXQzQnVGVDFEcVFZMXcrTVNjK0dpRVIzVml1RTBDeFc1d25OMkNqOVFW?=
 =?utf-8?B?MHJpby9UdXBwa3ArR3NVRjdCTGZoVVR6NFd2OFJ6elI3NUsweVdmS0tuemJW?=
 =?utf-8?B?UW9sV1pOL2pySWNmcDBHT0tvNm1uMmEvRTIvM2xIaGp6MDhKUU1wVDBHamZ1?=
 =?utf-8?B?Wis4RisvbVhGcEpybWxDdjNkQjZrR3pkaWR2Wm9PWGkwNFNnMFJFQjAyQkJX?=
 =?utf-8?B?ZzVqb21SZmZSRk1MOVBON3YyK0I3eVExRHJ0YTZva2IzZThvV0VtRTA3L29X?=
 =?utf-8?B?amVaWmk0ajVOQVgrSVZGN3ErSzl4YU53UU1pVVZ0RGEwUjg0SHdKWHpiZk5S?=
 =?utf-8?B?dHU1UEt0VE9mdGxvRFRoWGg1cXQvdml0QUZHNTZjcktaNWRYdlQrRi9UQk5u?=
 =?utf-8?B?K1V4akRZKzh0SXFDemR1STM5b0s3RGV3a0tYVm41d0w3N3VyNnc4amNvRVBB?=
 =?utf-8?B?MXBSZ2FEMnpkOTFFdUJpYjNzUDVRUmpnamRLUHVLTDZxOWh5UXVVaWxqN0ow?=
 =?utf-8?B?T1B4c21SREZ5TFhURUNCZzcyREJzemxRNFlYSklmRVBuZGhnUFRpeDc3NXJv?=
 =?utf-8?B?d1NiSC9qZW1idmozcXJYeWx5WmxJWUpTTzFaNHVxMHU5aUd4QUNqU2FPMWhC?=
 =?utf-8?B?MSsxRkY2QzlXdk94YTV0Tmc2dXFHVXZmc1pkajBqSlBNMlY1N0JiS0ZQemdi?=
 =?utf-8?B?blgxREg0bHNvYnplcXpDQzJoOEkxVkhFTlVEMkRkN0k4VDRoWjBxdjl1ajBP?=
 =?utf-8?B?cG9hbmFUN2ppLzVZVVh3RGNiYUxuWk8vU3hlVGVCU2RyQTh1eE1QRk9vM3cr?=
 =?utf-8?B?VnVnM3UzY2ZjZUZtd2FKQlUzaUJobVl3MU5GQkJlQXBDRHhlaFdiUWp1YmZM?=
 =?utf-8?B?eWZMc2Z5Y3ZIWWpuKzFKZ2oxeGJOL1A1NUhZUVV4SCtDOWc9PQ==?=
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:SJ0PR11MB6744.namprd11.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(376014)(7416014)(366016)(1800799024)(38070700018); DIR:OUT;
 SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?TlcyS1JrT3BPUlFCYklyWFNYZDEyblNmRVRhN0VlQ1NZU3N4MUI4cHNOMzFa?=
 =?utf-8?B?Nzk5ekxqQnBjMklIaFBmRDEyanRkVTR6KzRHRVR0Y21NWHNrV2U5Z2k5TlhV?=
 =?utf-8?B?dU1WamVRRmVKT0dySWR6MWF2V2E4Z05oVGlnaHRwaTA2VE5MdEZVQzlYdHZY?=
 =?utf-8?B?MXhCQzY2OTZQWjlUNm9IYXpLWW1WTVhvVWNJdlRPZHQ2SjdCcnlxOXhhVk8x?=
 =?utf-8?B?bDlGeE5DU0lvWGxKVllSbUd4cm5GZ1lUd2dOUElNbHBQMTNXUnZPNFVBSDNF?=
 =?utf-8?B?TDBzelJ5TU9FL1ZCMnVtSUdtempxZTk5bmZENlp3K1dMWHJNM00xNTJwMWFT?=
 =?utf-8?B?SWxOZS85NXdTeU04b0FGK1VFOXEvV0ptZ2pMVFJnZmxVcFMxdW1ZTEMxWmdx?=
 =?utf-8?B?WEJLY21YQk9xUHg0M1Y5Q1JBTW1xWnlsMjMzQVQyVDdNcEE1RDA1SGRWa2hS?=
 =?utf-8?B?a1hmUmhvT09LYWV6QU5qWkx6NkpaK21KRjlCek1zT2lqN0E5c0FCTThtRUVK?=
 =?utf-8?B?a2FhbElTWWlCS1dVdWkxdllhcHRrU3dqdy9BT0tiTSsxZCtoNk5rcFh5czRt?=
 =?utf-8?B?Vm9lQzZvWDcvWEZHWkJ4T29VZ255anJwbTU3SVNGWVpSVFpaT3N1ZU9jczEw?=
 =?utf-8?B?Uk9wTzJrMkNiUlI2ODNYK1g4OEd1VHJLTDd2dUdZVTVmL2wwRnVuV1Y2MDZP?=
 =?utf-8?B?ditIcTdHTGd0QkdtUGxseWFRaXFEVVU1dm55ZTRiWHQ1WTVUWWdDYVFDMGFR?=
 =?utf-8?B?ZHB6aVFNcHFWQ0FMS0V4RDcwOGdxbnU0YkM3L29QOGllWmlIRzl6M0lwbmFB?=
 =?utf-8?B?aXl4Tm9FaXJNdUZZaERwMlRNT01XNDBDeXcvZzE5TUx3SERiT1h0RnZHSGNz?=
 =?utf-8?B?MUlKMzROL20xWTRiemRsYzJhS0hyVlkzTVBkRTNVZGZaUmpSNUVVT0RMTSsz?=
 =?utf-8?B?RE9LTUFzOWlxeVNyOUlRMjV1NXNRVWZVOWdTM2JIOWk0dzE1VVRjNWZ2bmc5?=
 =?utf-8?B?eWduU1pMc3VqRXZjbkNjaFpzTEFoUW9Db01HbTFGS0hTc0xVL3dFYU5QZVp0?=
 =?utf-8?B?azVvcHAyNnZkOWtzR3gwZlFxakxpRGtsWmJqZHJxNTZJclh6dzI0UnFmRFF1?=
 =?utf-8?B?WVFMTWRtcGlkSXY1cWxKVFhKTitEdXJHUjRoV2pka3dFeFFKWUJqd0VaTmY5?=
 =?utf-8?B?cEJzOTNQSUVmdEJiclNNUnlHSE1zdk4wYk9sUU9PL3ZHeGlwWE5hSUV4Qk1W?=
 =?utf-8?B?ZTd5TlVsMXlISU1wZlh6MW9zVk96ZUtNVVVsaEhEbWdPWGZnWnl6WGdiaXNL?=
 =?utf-8?B?TnVPckh3YThMWHltdE13RkcrU01Od1BJOEdQSndBc0xmdndGVXFSWUhOS2E5?=
 =?utf-8?B?S3dmRk1jUElUWUVqMXBES1hLUzREOFhMQ2hVZkV3bWFYQ0pmQm1XOXNmNHZy?=
 =?utf-8?B?WGtUQTFzUHRoRFh5b3JOV2RHZTZRVFRhWTRHTytBWUlhVVRHMGswQU5ya2Ni?=
 =?utf-8?B?N3k0VFptWFdxM0Q4TzRiZXFKdmNnVkZUZmtwMFFqR3dWdTdweE1HUVJ6QmJE?=
 =?utf-8?B?bFgvT1kyb0dPKytuSkZRYWpSNkNhaXhWVUdUcUNUYjlPMnc5OVk2VUhqV0Rn?=
 =?utf-8?B?anJ5OUVjL0VzV0tlRGtua0RrenVPT1NaRWlqSFU2QjBIbzRYbHJkZzQ1TEhS?=
 =?utf-8?B?aWtBN2lDbmdUOXU2dnlRazFvaXdQQy9sTmUxRVpJcGovZ2JQdEFNMVJ1Qk9n?=
 =?utf-8?B?K2RGOEg3NFBaV0VKYk5ZS0JEUTJtejF4dnV6ejJoaXZ0d3QrTTE1NXpqRUdU?=
 =?utf-8?B?dE8zdFhDVFF4Y3NQTDQ1aVJaRm5VdUNjdEZUU2xVWkxtOXNCWU1sVzVaaTho?=
 =?utf-8?B?TXVZRnFwc2Y2T05DVlhFRkFWaFVtZzBqMUhqNUlWQ2EwQnQ2Nk52a1c3N2F1?=
 =?utf-8?B?Y29aa2VSeW9VRE5IQ25kKzBneFdGbnFZbnJQUkZmM1N4MGR4Mmx6N2dpbUJQ?=
 =?utf-8?B?TzFsUjd5TjlPdlltak9QQ29yVXJPZlEya1hRUHh5TTJzM3BkUVl6NjBvZFVD?=
 =?utf-8?B?MndWamlRVThBL2hkMnpBQTNOb2h3aENwYXlRczY2enJNaGhWS1NYclFXQ0J6?=
 =?utf-8?Q?+yzTqUb0jcU/92OrOprz+77Ty?=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: SJ0PR11MB6744.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: ace3e47f-eab2-42f9-13f5-08dca7a47714
X-MS-Exchange-CrossTenant-originalarrivaltime: 19 Jul 2024 03:39:59.3947 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: Z5XexA1ql5FayujFi+Q+hPwOAEPsXezIUfouhCK/1QaT8y8yJ9XMeA7nZWmsTulrAWfF2Dh+ORLvbOiJLwQXjnTcoIInMLmD+Wo1sS4w2Zc=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM4PR11MB6262
X-OriginatorOrg: intel.com
Received-SPF: pass client-ip=192.198.163.18;
 envelope-from=zhenzhong.duan@intel.com; helo=mgamail.intel.com
X-Spam_score_int: -43
X-Spam_score: -4.4
X-Spam_bar: ----
X-Spam_report: (-4.4 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
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

DQoNCj4tLS0tLU9yaWdpbmFsIE1lc3NhZ2UtLS0tLQ0KPkZyb206IER1YW4sIFpoZW56aG9uZ10N
Cj5TdWJqZWN0OiBSRTogW1BBVENIIHYxIDAzLzE3XSBpbnRlbF9pb21tdTogQWRkIGEgcGxhY2Vo
b2xkZXIgdmFyaWFibGUgZm9yDQo+c2NhbGFibGUgbW9kZXJuIG1vZGUNCj4NCj4NCj4NCj4+LS0t
LS1PcmlnaW5hbCBNZXNzYWdlLS0tLS0NCj4+RnJvbTogTGl1LCBZaSBMIDx5aS5sLmxpdUBpbnRl
bC5jb20+DQo+PlN1YmplY3Q6IFJlOiBbUEFUQ0ggdjEgMDMvMTddIGludGVsX2lvbW11OiBBZGQg
YSBwbGFjZWhvbGRlciB2YXJpYWJsZSBmb3INCj4+c2NhbGFibGUgbW9kZXJuIG1vZGUNCj4+DQo+
Pk9uIDIwMjQvNy8xOSAxMDo0NywgRHVhbiwgWmhlbnpob25nIHdyb3RlOg0KPj4+DQo+Pj4NCj4+
Pj4gLS0tLS1PcmlnaW5hbCBNZXNzYWdlLS0tLS0NCj4+Pj4gRnJvbTogQ0xFTUVOVCBNQVRISUVV
LS1EUklGIDxjbGVtZW50Lm1hdGhpZXUtLWRyaWZAZXZpZGVuLmNvbT4NCj4+Pj4gU3ViamVjdDog
UmU6IFtQQVRDSCB2MSAwMy8xN10gaW50ZWxfaW9tbXU6IEFkZCBhIHBsYWNlaG9sZGVyIHZhcmlh
YmxlDQo+PmZvcg0KPj4+PiBzY2FsYWJsZSBtb2Rlcm4gbW9kZQ0KPj4+Pg0KPj4+Pg0KPj4+Pg0K
Pj4+PiBPbiAxOC8wNy8yMDI0IDEwOjE2LCBaaGVuemhvbmcgRHVhbiB3cm90ZToNCj4+Pj4+IENh
dXRpb246IEV4dGVybmFsIGVtYWlsLiBEbyBub3Qgb3BlbiBhdHRhY2htZW50cyBvciBjbGljayBs
aW5rcywgdW5sZXNzDQo+PnRoaXMNCj4+Pj4gZW1haWwgY29tZXMgZnJvbSBhIGtub3duIHNlbmRl
ciBhbmQgeW91IGtub3cgdGhlIGNvbnRlbnQgaXMgc2FmZS4NCj4+Pj4+DQo+Pj4+Pg0KPj4+Pj4g
QWRkIGFuIG5ldyBlbGVtZW50IHNjYWxhYmxlX21vZGUgaW4gSW50ZWxJT01NVVN0YXRlIHRvIG1h
cmsNCj4+c2NhbGFibGUNCj4+Pj4+IG1vZGVybiBtb2RlLCB0aGlzIGVsZW1lbnQgd2lsbCBiZSBl
eHBvc2VkIGFzIGFuIGludGVsX2lvbW11DQo+cHJvcGVydHkNCj4+Pj4+IGZpbmFsbHkuDQo+Pj4+
Pg0KPj4+Pj4gRm9yIG5vdywgaXQncyBvbmx5IGEgcGxhY2VoaG9sZGVyIGFuZCB1c2VkIGZvciBj
YXAvZWNhcCBpbml0aWFsaXphdGlvbiwNCj4+Pj4+IGNvbXBhdGliaWxpdHkgY2hlY2sgYW5kIGJs
b2NrIGhvc3QgZGV2aWNlIHBhc3N0aHJvdWdoIHVudGlsIG5lc3RpbmcNCj4+Pj4+IGlzIHN1cHBv
cnRlZC4NCj4+Pj4+DQo+Pj4+PiBTaWduZWQtb2ZmLWJ5OiBZaSBMaXUgPHlpLmwubGl1QGludGVs
LmNvbT4NCj4+Pj4+IFNpZ25lZC1vZmYtYnk6IFpoZW56aG9uZyBEdWFuIDx6aGVuemhvbmcuZHVh
bkBpbnRlbC5jb20+DQo+Pj4+PiAtLS0NCj4+Pj4+ICAgIGh3L2kzODYvaW50ZWxfaW9tbXVfaW50
ZXJuYWwuaCB8ICAyICsrDQo+Pj4+PiAgICBpbmNsdWRlL2h3L2kzODYvaW50ZWxfaW9tbXUuaCAg
fCAgMSArDQo+Pj4+PiAgICBody9pMzg2L2ludGVsX2lvbW11LmMgICAgICAgICAgfCAzNCArKysr
KysrKysrKysrKysrKysrKysrKy0tLS0tLS0NCj4tLQ0KPj4tLQ0KPj4+Pj4gICAgMyBmaWxlcyBj
aGFuZ2VkLCAyNiBpbnNlcnRpb25zKCspLCAxMSBkZWxldGlvbnMoLSkNCj4+Pj4+DQo+Pj4+PiBk
aWZmIC0tZ2l0IGEvaHcvaTM4Ni9pbnRlbF9pb21tdV9pbnRlcm5hbC5oDQo+Pj4+IGIvaHcvaTM4
Ni9pbnRlbF9pb21tdV9pbnRlcm5hbC5oDQo+Pj4+PiBpbmRleCBjMGNhN2IzNzJmLi40ZTAzMzFj
YWJhIDEwMDY0NA0KPj4+Pj4gLS0tIGEvaHcvaTM4Ni9pbnRlbF9pb21tdV9pbnRlcm5hbC5oDQo+
Pj4+PiArKysgYi9ody9pMzg2L2ludGVsX2lvbW11X2ludGVybmFsLmgNCj4+Pj4+IEBAIC0xOTUs
NiArMTk1LDcgQEANCj4+Pj4+ICAgICNkZWZpbmUgVlREX0VDQVBfUEFTSUQgICAgICAgICAgICAg
ICgxVUxMIDw8IDQwKQ0KPj4+Pj4gICAgI2RlZmluZSBWVERfRUNBUF9TTVRTICAgICAgICAgICAg
ICAgKDFVTEwgPDwgNDMpDQo+Pj4+PiAgICAjZGVmaW5lIFZURF9FQ0FQX1NMVFMgICAgICAgICAg
ICAgICAoMVVMTCA8PCA0NikNCj4+Pj4+ICsjZGVmaW5lIFZURF9FQ0FQX0ZMVFMgICAgICAgICAg
ICAgICAoMVVMTCA8PCA0NykNCj4+Pj4+DQo+Pj4+PiAgICAvKiBDQVBfUkVHICovDQo+Pj4+PiAg
ICAvKiAob2Zmc2V0ID4+IDQpIDw8IDI0ICovDQo+Pj4+PiBAQCAtMjExLDYgKzIxMiw3IEBADQo+
Pj4+PiAgICAjZGVmaW5lIFZURF9DQVBfU0xMUFMgICAgICAgICAgICAgICAoKDFVTEwgPDwgMzQp
IHwgKDFVTEwgPDwgMzUpKQ0KPj4+Pj4gICAgI2RlZmluZSBWVERfQ0FQX0RSQUlOX1dSSVRFICAg
ICAgICAgKDFVTEwgPDwgNTQpDQo+Pj4+PiAgICAjZGVmaW5lIFZURF9DQVBfRFJBSU5fUkVBRCAg
ICAgICAgICAoMVVMTCA8PCA1NSkNCj4+Pj4+ICsjZGVmaW5lIFZURF9DQVBfRlMxR1AgICAgICAg
ICAgICAgICAoMVVMTCA8PCA1NikNCj4+Pj4+ICAgICNkZWZpbmUgVlREX0NBUF9EUkFJTiAgICAg
ICAgICAgICAgIChWVERfQ0FQX0RSQUlOX1JFQUQgfA0KPj4+PiBWVERfQ0FQX0RSQUlOX1dSSVRF
KQ0KPj4+Pj4gICAgI2RlZmluZSBWVERfQ0FQX0NNICAgICAgICAgICAgICAgICAgKDFVTEwgPDwg
NykNCj4+Pj4+ICAgICNkZWZpbmUgVlREX1BBU0lEX0lEX1NISUZUICAgICAgICAgIDIwDQo+Pj4+
PiBkaWZmIC0tZ2l0IGEvaW5jbHVkZS9ody9pMzg2L2ludGVsX2lvbW11LmgNCj4+Pj4gYi9pbmNs
dWRlL2h3L2kzODYvaW50ZWxfaW9tbXUuaA0KPj4+Pj4gaW5kZXggMWViMDVjMjlmYy4uNzg4ZWQ0
MjQ3NyAxMDA2NDQNCj4+Pj4+IC0tLSBhL2luY2x1ZGUvaHcvaTM4Ni9pbnRlbF9pb21tdS5oDQo+
Pj4+PiArKysgYi9pbmNsdWRlL2h3L2kzODYvaW50ZWxfaW9tbXUuaA0KPj4+Pj4gQEAgLTI2Miw2
ICsyNjIsNyBAQCBzdHJ1Y3QgSW50ZWxJT01NVVN0YXRlIHsNCj4+Pj4+DQo+Pj4+PiAgICAgICAg
Ym9vbCBjYWNoaW5nX21vZGU7ICAgICAgICAgICAgICAvKiBSTyAtIGlzIGNhcCBDTSBlbmFibGVk
PyAqLw0KPj4+Pj4gICAgICAgIGJvb2wgc2NhbGFibGVfbW9kZTsgICAgICAgICAgICAgLyogUk8g
LSBpcyBTY2FsYWJsZSBNb2RlIHN1cHBvcnRlZD8NCj4qLw0KPj4+Pj4gKyAgICBib29sIHNjYWxh
YmxlX21vZGVybjsgICAgICAgICAgIC8qIFJPIC0gaXMgbW9kZXJuIFNNIHN1cHBvcnRlZD8gKi8N
Cj4+Pj4+ICAgICAgICBib29sIHNub29wX2NvbnRyb2w7ICAgICAgICAgICAgIC8qIFJPIC0gaXMg
U05QIGZpbGVkIHN1cHBvcnRlZD8gKi8NCj4+Pj4+DQo+Pj4+PiAgICAgICAgZG1hX2FkZHJfdCBy
b290OyAgICAgICAgICAgICAgICAvKiBDdXJyZW50IHJvb3QgdGFibGUgcG9pbnRlciAqLw0KPj4+
Pj4gZGlmZiAtLWdpdCBhL2h3L2kzODYvaW50ZWxfaW9tbXUuYyBiL2h3L2kzODYvaW50ZWxfaW9t
bXUuYw0KPj4+Pj4gaW5kZXggMWNmZjhiMDBhZS4uNDBjYmQ0YTBmNCAxMDA2NDQNCj4+Pj4+IC0t
LSBhL2h3L2kzODYvaW50ZWxfaW9tbXUuYw0KPj4+Pj4gKysrIGIvaHcvaTM4Ni9pbnRlbF9pb21t
dS5jDQo+Pj4+PiBAQCAtNzU1LDE2ICs3NTUsMjAgQEAgc3RhdGljIGlubGluZSBib29sDQo+Pj4+
IHZ0ZF9pc19sZXZlbF9zdXBwb3J0ZWQoSW50ZWxJT01NVVN0YXRlICpzLCB1aW50MzJfdCBsZXZl
bCkNCj4+Pj4+ICAgIH0NCj4+Pj4+DQo+Pj4+PiAgICAvKiBSZXR1cm4gdHJ1ZSBpZiBjaGVjayBw
YXNzZWQsIG90aGVyd2lzZSBmYWxzZSAqLw0KPj4+Pj4gLXN0YXRpYyBpbmxpbmUgYm9vbCB2dGRf
cGVfdHlwZV9jaGVjayhYODZJT01NVVN0YXRlICp4ODZfaW9tbXUsDQo+Pj4+PiAtICAgICAgICAg
ICAgICAgICAgICAgICAgICAgICAgICAgICAgIFZURFBBU0lERW50cnkgKnBlKQ0KPj4+Pj4gK3N0
YXRpYyBpbmxpbmUgYm9vbCB2dGRfcGVfdHlwZV9jaGVjayhJbnRlbElPTU1VU3RhdGUgKnMsDQo+
Pj4+IFZURFBBU0lERW50cnkgKnBlKQ0KPj4+Pj4gICAgew0KPj4+PiBXaGF0IGFib3V0IHVzaW5n
IHRoZSBjYXAvZWNhcCByZWdpc3RlcnMgdG8ga25vdyBpZiB0aGUgdHJhbnNsYXRpb24gdHlwZXMN
Cj4+Pj4gYXJlIHN1cHBvcnRlZCBvciBub3QuDQo+Pj4+IE90aGVyd2lzZSwgd2UgY291bGQgYWRk
IGEgY29tbWVudCB0byBleHBsYWluIHdoeSB3ZSBleHBlY3QNCj4+Pj4gcy0+c2NhbGFibGVfbW9k
ZXJuIHRvIGdpdmUgdXMgZW5vdWdoIGluZm9ybWF0aW9uLg0KPj4+DQo+Pj4gV2hhdCBhYm91dCBi
ZWxvdzoNCj4+Pg0KPj4+IC8qDQo+Pj4gICAqVlREX0VDQVBfRkxUUyBpbiBlY2FwIGlzIHNldCBp
ZiBzLT5zY2FsYWJsZV9tb2Rlcm4gaXMgdHJ1ZSwgb3IgZWxzZQ0KPj5WVERfRUNBUF9TTFRTIGNh
biBiZSBzZXQgb3Igbm90IGRlcGVuZGluZyBvbiBzLT5zY2FsYWJsZV9tb2RlLg0KPj4+ICAgKlNv
IGl0J3Mgc2ltcGxlciB0byBjaGVjayBzLT5zY2FsYWJsZV9tb2Rlcm4gZGlyZWN0bHkgZm9yIGEg
UEFTSUQgZW50cnkNCj4+dHlwZSBpbnN0ZWFkIGVjYXAgYml0cy4NCj4+PiAgICovDQo+Pg0KPj5T
aW5jZSB0aGlzIGhlbHBlciBpcyBmb3IgcGFzaWQgZW50cnkgY2hlY2ssIHNvIHlvdSBjYW4ganVz
dCByZXR1cm4gZmFsc2UNCj4+aWYgdGhlIHBlJ3MgUEdUVCBpcyBTUy1vbmx5Lg0KPg0KPkl0IGRl
cGVuZHMgb24gd2hpY2ggc2NhbGFibGUgbW9kZSBpcyBjaG9zZWQuDQo+SW4gc2NhbGFibGUgbGVn
YWN5IG1vZGUsIFBHVFQgaXMgU1Mtb25seSBhbmQgd2Ugc2hvdWxkIHJldHVybiB0cnVlLg0KPg0K
Pj4NCj4+SXQgbWlnaHQgbWFrZSBtb3JlIHNlbnNlIHRvIGNoZWNrIHRoZSBlY2FwL2NhcCBoZXJl
IGFzIGFueWhvdyB0aGUNCj4+Y2FwYWJpbGl0eSBpcyBsaXN0ZWQgaW4gZWNhcC9jYXAuIFRoaXMg
bWF5IGFsc28gYnJpbmcgdXMgc29tZSBjb252ZW5pZW5jZS4NCj4+DQo+PlNheSBpbiB0aGUgZnV0
dXJlLCBpZiB3ZSB3YW50IHRvIGFkZCBhIG5ldyBtb2RlIChlLmcuIHNjYWxhYmxlIG1vZGUgMi4w
KQ0KPj50aGF0IHN1cHBvcnRzIGJvdGggRlMgYW5kIFNTIGZvciBndWVzdCwgd2UgbWF5IG5lZWQg
dG8gdXBkYXRlIHRoaXMgaGVscGVyDQo+PmFzIHdlbGwgaWYgd2UgY2hlY2sgdGhlIHNjYWxhYmxl
X21vZGVybi4gQnV0IGlmIHdlIGNoZWNrIHRoZSBlY2FwL2NhcCwgdGhlbg0KPj50aGUgZnV0dXJl
IGNoYW5nZSBqdXN0IG5lZWRzIHRvIGNvbnRyb2wgdGhlIGVjYXAvY2FwIHNldHRpbmcgYXQgdGhl
DQo+PmJlZ2lubmluZyBvZiB0aGUgdklPTU1VIGluaXQuIFRvIGtlZXAgdGhlIGNvZGUgYWxpZ25l
ZCwgeW91IG1heSBuZWVkIHRvDQo+PmNoZWNrIGVjYXAuUFQgYml0IGZvciBWVERfU01fUEFTSURf
RU5UUllfUFQuIDopDQo+DQo+T0ssIHdpbGwgYmUgbGlrZSBiZWxvdzoNCj4NCj4tLS0gYS9ody9p
Mzg2L2ludGVsX2lvbW11LmMNCj4rKysgYi9ody9pMzg2L2ludGVsX2lvbW11LmMNCj5AQCAtODI2
LDE0ICs4MjYsMTQgQEAgc3RhdGljIGlubGluZSBib29sDQo+dnRkX3BlX3R5cGVfY2hlY2soSW50
ZWxJT01NVVN0YXRlICpzLCBWVERQQVNJREVudHJ5ICpwZSkNCj4NCj4gICAgIHN3aXRjaCAoVlRE
X1BFX0dFVF9UWVBFKHBlKSkgew0KPiAgICAgY2FzZSBWVERfU01fUEFTSURfRU5UUllfRkxUOg0K
Pi0gICAgICAgIHJldHVybiBzLT5zY2FsYWJsZV9tb2Rlcm47DQo+KyAgICAgICAgcmV0dXJuICEh
KHMtPmVjYXAgJiBWVERfRUNBUF9GTFRTKTsNCj4gICAgIGNhc2UgVlREX1NNX1BBU0lEX0VOVFJZ
X1NMVDoNCj4tICAgICAgICByZXR1cm4gIXMtPnNjYWxhYmxlX21vZGVybjsNCj4rICAgICAgICBy
ZXR1cm4gISEocy0+ZWNhcCAmIFZURF9FQ0FQX0ZMVFMpIHx8ICEocy0+ZWNhcCAmIFZURF9FQ0FQ
X1NNVFMpOw0KDQpTb3JyeSB0eXBvIGVyciwgc2hvdWxkIGJlOg0KDQorICAgICAgICByZXR1cm4g
ISEocy0+ZWNhcCAmIFZURF9FQ0FQX1NMVFMpIHx8ICEocy0+ZWNhcCAmIFZURF9FQ0FQX1NNVFMp
Ow0KDQoNCj4gICAgIGNhc2UgVlREX1NNX1BBU0lEX0VOVFJZX05FU1RFRDoNCj4gICAgICAgICAv
KiBOb3Qgc3VwcG9ydCBORVNURUQgcGFnZSB0YWJsZSB0eXBlIHlldCAqLw0KPiAgICAgICAgIHJl
dHVybiBmYWxzZTsNCj4gICAgIGNhc2UgVlREX1NNX1BBU0lEX0VOVFJZX1BUOg0KPi0gICAgICAg
IHJldHVybiB4ODZfaW9tbXUtPnB0X3N1cHBvcnRlZDsNCj4rICAgICAgICByZXR1cm4gISEocy0+
ZWNhcCAmIFZURF9FQ0FQX1BUKTsNCj4gICAgIGRlZmF1bHQ6DQo+ICAgICAgICAgLyogVW5rbm93
biB0eXBlICovDQo+ICAgICAgICAgcmV0dXJuIGZhbHNlOw0KPg0KPlRoYW5rcw0KPlpoZW56aG9u
Zw0K

