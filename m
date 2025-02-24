Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1FE83C021B2
	for <qemu-devel@archiver.kernel.org>; Mon, 24 Feb 2025 01:44:47 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tmNWJ-0004WE-RX; Sun, 23 Feb 2025 20:44:31 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <zhenzhong.duan@intel.com>)
 id 1tmNWH-0004Vv-Al
 for qemu-devel@nongnu.org; Sun, 23 Feb 2025 20:44:29 -0500
Received: from mgamail.intel.com ([198.175.65.11])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <zhenzhong.duan@intel.com>)
 id 1tmNWD-0002ZW-Hm
 for qemu-devel@nongnu.org; Sun, 23 Feb 2025 20:44:28 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1740361466; x=1771897466;
 h=from:to:cc:subject:date:message-id:references:
 in-reply-to:content-transfer-encoding:mime-version;
 bh=+j+WyRvM5lw9MBW0Zc5zi4S51nkMMrpGQB6Q7W3Oa9c=;
 b=ddAcT4W4u/QLjR1uPI54AekpOm3JBFVFlJtWFA/hnqjxFrSEn6ET09fd
 xDt5iehHO493QlLJXxSDVRDrG8UyxJGO3Kcr66G8riJ8CAXNDVRS7XmpH
 arKaTU7DP72m3bRNapJdGKdtNhHl8TzZs3qg+fQWJARWMavBhkJEZsm/U
 ucQVi9M4qrpugf1XYsQeJBOqZzTvaMJN9my1QZOKxKB+iJBo46XrAAunO
 7avBmFCYRbcSbqSOH22iIyfEUSy9KjbWdXDuvi50KF+TcW8KAuAPUtZlP
 goOvP8IPlSTcPBFfk3uk0eDKCQJ0eAP1xGL/oeaXffetKhShUO4Ttl3Fh Q==;
X-CSE-ConnectionGUID: KeLWjQj3RiSGajFXHRvgvA==
X-CSE-MsgGUID: be024LBWSJWBxVrC5vkR1Q==
X-IronPort-AV: E=McAfee;i="6700,10204,11354"; a="51320448"
X-IronPort-AV: E=Sophos;i="6.13,309,1732608000"; d="scan'208";a="51320448"
Received: from fmviesa001.fm.intel.com ([10.60.135.141])
 by orvoesa103.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 23 Feb 2025 17:44:19 -0800
X-CSE-ConnectionGUID: g2ZdQ92TSlyF1DenL9MfmA==
X-CSE-MsgGUID: 9kP1otngSkOIg9xGF/ELGg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.12,224,1728975600"; d="scan'208";a="146811285"
Received: from orsmsx903.amr.corp.intel.com ([10.22.229.25])
 by fmviesa001.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 23 Feb 2025 17:44:19 -0800
Received: from ORSMSX901.amr.corp.intel.com (10.22.229.23) by
 ORSMSX903.amr.corp.intel.com (10.22.229.25) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.14; Sun, 23 Feb 2025 17:44:18 -0800
Received: from orsedg603.ED.cps.intel.com (10.7.248.4) by
 ORSMSX901.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.14 via Frontend Transport; Sun, 23 Feb 2025 17:44:18 -0800
Received: from NAM11-CO1-obe.outbound.protection.outlook.com (104.47.56.171)
 by edgegateway.intel.com (134.134.137.100) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.44; Sun, 23 Feb 2025 17:44:17 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=enlOPkzyPIxS6eXukvFdgqNTL5EUTtf6j61TB2xNC53/1JeQXTv4g5WPHbonealjoX3+2cOSLMo26rFT0BIEoTKk5jJhfPrplgvAPD/Gt89Q8exaIpzTGtPHFBMlhsXhPKXuzWHvPdLjpZ5RmwV9qurM2pWfy2VwvqOutpljUk8/iqXDYeB1R+RFRkyZrFbocgsGOtUp2VVLgxy6wgBPnfC+IxWHO9fxvZxj89WuwYtnbs957Vfm9RhMbDXxmJNTliio3Mivji1P7pKaGtbFptLrYaWfktgasatENpC67HOU+sPGU5CDE6tK3QLh6u2PepubxogtIPaOgNHcUJkcJw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=+j+WyRvM5lw9MBW0Zc5zi4S51nkMMrpGQB6Q7W3Oa9c=;
 b=gWwvikAk8Z0Y7a12jD7L3cI6siY1kolmyr0qQwDI39vqE1JKVpV0GEuvCkUVI2NjpQbJlBC120cysAhugtaNZ0/U5JtPziPZZyFB0U0tVLWXeaw2iND1QrM+Z3DA/F+wYy6Fe0uCo2KbNxD7pAUQvNY/vC4NsjnB00RPi43Iic1rlcMvbKGaBCAnDQNhjFuxDu4kT8JtZ7EM02BOI+bp04Ht8IaurzjjsCviFMGM4EwUxnOv8AgdZ24wM5tTzsobb2LbmAkdUy79r1iLmfbYOtMeEfdZEPYB3lS3STcOuRzd2PVsvxY238R6oq4xVNZ70MvBwpg+iIwIr6f56hVzxw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Received: from SJ0PR11MB6744.namprd11.prod.outlook.com (2603:10b6:a03:47d::10)
 by BY1PR11MB8078.namprd11.prod.outlook.com (2603:10b6:a03:52a::6)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8466.19; Mon, 24 Feb
 2025 01:43:58 +0000
Received: from SJ0PR11MB6744.namprd11.prod.outlook.com
 ([fe80::fe49:d628:48b1:6091]) by SJ0PR11MB6744.namprd11.prod.outlook.com
 ([fe80::fe49:d628:48b1:6091%6]) with mapi id 15.20.8466.016; Mon, 24 Feb 2025
 01:43:58 +0000
From: "Duan, Zhenzhong" <zhenzhong.duan@intel.com>
To: Alex Williamson <alex.williamson@redhat.com>, "qemu-devel@nongnu.org"
 <qemu-devel@nongnu.org>
CC: "eric.auger.pro@gmail.com" <eric.auger.pro@gmail.com>,
 "eric.auger@redhat.com" <eric.auger@redhat.com>, "clg@redhat.com"
 <clg@redhat.com>, "mst@redhat.com" <mst@redhat.com>,
 "marcel.apfelbaum@gmail.com" <marcel.apfelbaum@gmail.com>
Subject: RE: [PATCH 0/5] PCI: Implement basic PCI PM capability backing
Thread-Topic: [PATCH 0/5] PCI: Implement basic PCI PM capability backing
Thread-Index: AQHbg+m+nRNmjH0400OYBR4ExabG1rNVsWTw
Date: Mon, 24 Feb 2025 01:43:58 +0000
Message-ID: <SJ0PR11MB6744F8EB2DF730794A34CEAA92C02@SJ0PR11MB6744.namprd11.prod.outlook.com>
References: <20250220224918.2520417-1-alex.williamson@redhat.com>
In-Reply-To: <20250220224918.2520417-1-alex.williamson@redhat.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: SJ0PR11MB6744:EE_|BY1PR11MB8078:EE_
x-ms-office365-filtering-correlation-id: 46eb1e47-6b3a-4eba-dc51-08dd5474b4b1
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0; ARA:13230040|376014|1800799024|366016|38070700018;
x-microsoft-antispam-message-info: =?utf-8?B?OW9nMUVwQitoSGFWN3hSM0ZrbmR3THRQeEtDbzBKVVRrbUN3WFNaVCtudlpx?=
 =?utf-8?B?aURFOWptTTVhMEUwcjJNNmZ4TUl6WlUrZG1NQkdsQVN4UnkxM3lMdHh2cDZV?=
 =?utf-8?B?eUU3aTMyRTZDWHNLK2VJUG1YNE5FeUlZRk9YS01tWjJ5R3hLTk9oMExPNWFl?=
 =?utf-8?B?OTdnV0REczFTTFVLaTY1SzdQV1hyTUZjMFh4RXBaOEM3TVVxaWlqV2hpRTh2?=
 =?utf-8?B?dDRnTjlaSXViQ1JUZ241Nk01ZGdCeHhCeGRiOTFxa05pZ0pSc2Y0Y1ptOTNQ?=
 =?utf-8?B?c1diMTNoR210TW5wc0xCT1dwZFU4NkliWUxSaWtvVm1sa3R6eHA0OGpxV2Za?=
 =?utf-8?B?OUNqY1laMVdvajlON0xiV3h1aXFUaUtwU0t0UCtNR00ycU5GZzgrZGpnVjls?=
 =?utf-8?B?bEVUcTkyNElqRVQwMFc4T1RqeVBIZGo4RzVPTlBsQTA5akMwWDIzRUEwaEZP?=
 =?utf-8?B?YVRwTnFpc1RGMmxoa3BNQzdZWUlIQzlYNWFkUTYra3k4SW95eHVueG5FTTZs?=
 =?utf-8?B?V3FOdHFMV28vVTlSNHBJWWhIcE15NWFHcE15Z3JCSERRd21DeEFqcWtTS1Ax?=
 =?utf-8?B?NkhzajYweVM1K3RSNTQzdlFlSS82a3JxdUdrL0czTmM4S0pML1dzaU5pUWUw?=
 =?utf-8?B?WXYvSzR3WFlHaDNRV3FSYXI2QnNjb3hmWkRwS1FZaGNicW0vYlRaaEJRZWxr?=
 =?utf-8?B?VU8vQndnSnhCalRQNVl6MVUwOGYzMGI2dnpweDVTQVI2R3prZmh2ZTlTbm1i?=
 =?utf-8?B?M3I4cTg0T3RlWWJOUFUxdDVuQmpVVGk0M0tCcHRWYVRlT2k3ZmJ5OFFLMjVj?=
 =?utf-8?B?TkNKL0xaK2VGMUxvaHRoZVZ0YVA5dUJ0QmczVUtGV2Y0K2dkUHA0di9jYU1a?=
 =?utf-8?B?aWdhL0xPTHVpWi9Vbk4wa2I5c3BncVFmNERCUWNhOU02dlNLbEVwak9YRkdN?=
 =?utf-8?B?bkc5RXp1MEVKWnZEY092a2ttUkpId3BDbUtmemZScHJjRmpJd2FCNlR0U2tx?=
 =?utf-8?B?VHBDYWxEeVhHS3kzb3A1RU8zbWtUWUMwbFVHUllEV3BHelBCeXgwQ0o1Ykdl?=
 =?utf-8?B?dk15M1pEQVk4WVJnOVFMMDJ5T3V4OUVwUlFUNjBJOWVhbGtsZVExY2Q0SStI?=
 =?utf-8?B?NEd5MnFVa3VWa1lIcC9wcE9iQVQzazlXVmJqYlZwRXVWU3cyc0wwWjIwRkxR?=
 =?utf-8?B?andCU0sxbVozeDR0YllOVERFclR2Z3VFVUkvMzdQZDc1YWZ6eDZCMitxTDNj?=
 =?utf-8?B?OHB5aUNWTFN6RDNZUy9zellqK1ZQd2RYKy9SbmpzN042QkhYbnlsSTVUWEZK?=
 =?utf-8?B?OVk3S0JzTi96YlpXOEN1WkVlTVdObEluQTFOUks0OUZBMVpnUk9kYi9DcSth?=
 =?utf-8?B?SlY3eEZwdkVRQ0h6MlJGQlVsZDJWN256SlNLeWlWRGNDVEJvRm1Pa2I2T1lP?=
 =?utf-8?B?ZVRNKysxdFhacW1XQytXQjZDUktTcDNWMTZRdVpUa0lsRVN0MGxKVGFkdGhR?=
 =?utf-8?B?WGRnZEJpbkRneEM2Y0s5MEpTRWpxZEFuMzYrTmxsdmVybVg3amdwc3RGN0Zw?=
 =?utf-8?B?elFsbTZFcUFlRkpQdndmcFVuRitkWW9BTGFNMjVDTk04UWd4VUdhLzFZbUls?=
 =?utf-8?B?T1FLaCtmUkhvRlZpYlZUenBvNkV3Z0RTNUkrTXV0WUtNdmVsVFdZSGM3MExD?=
 =?utf-8?B?a0g2NjlDSXpxZ21UNnBmY3NUeUdTUStDS2p3Ny9PKzdUTjhpNHZ6YzBoZlRG?=
 =?utf-8?B?T0ZOODdSZEFJL09HZEZSVzRScGdQKytHcVFFWW9tT2hZRXJObzR2QVdXeVR2?=
 =?utf-8?B?WDF0WjlKY2doc3VRZnM3VUs0VkxSbjBGNVFUUnZjZS9kNHNlNW95b0lGaXdH?=
 =?utf-8?B?eEtvNS9FMlc5ZndYMys2ckFFSHRxWFN0dnhndzc4azRTN1R6V2FsS0E3R05B?=
 =?utf-8?Q?RHvc6AHqArenLfCvfQ4NK2/1Mx/Gjhot?=
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:SJ0PR11MB6744.namprd11.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(376014)(1800799024)(366016)(38070700018); DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?R2t0MnY4TnM5dGJlYllCbzBEZnNZMllEUGlYMUY3dGJHN2FGQURTR3dnWlN5?=
 =?utf-8?B?QVY2cjN6OERIUjhHMnZIR3dPR1lvNTQ3UDI0aUx0djZxWGVhK3RIZ0p0TFAr?=
 =?utf-8?B?d3F6WGQ4OWpoZVRWdTNac0JCTDZwS2Y5U21CMHE5anVxWUZlNmVwSlVBUjhL?=
 =?utf-8?B?YlhQOEVnd1ZsbEhhTHdnajRsVUg4Z3Q1cGxReGZPYzN5MWxaVWRxbzRDeTc0?=
 =?utf-8?B?V2ZCdStzWGVsUWgxQ05JYm9SRE10ZXdQdlVka3dWUmg4NUdhQjVJMlN1aDFw?=
 =?utf-8?B?dWpjVnlsem1TaVkzNkpoZXpxd09hVFFaYWlrQkphL0dJeUorb0tueXJQbXJU?=
 =?utf-8?B?Y0YwdXd2L3A3cXdtdWNmL282YXUwMjNFczQ5MUV5cGZ5N0VxRDdPNldPajIr?=
 =?utf-8?B?Yy9PanlENEM2TnR1NlBMN2paaDV0VUxTM0F2dDIwWUtOUXhETllia0pTWnhG?=
 =?utf-8?B?eEtiU0xpcWduVXdGK1ZtUElnV09FTHM0aUdtQ3dwTDBXNVhRWDNOTXFmY01x?=
 =?utf-8?B?bk90cEdoeWt6MkZCdTJRNW9leHpvOEgvTFlHRkZpZFVjMzNjaVNqUWdSZ3Jh?=
 =?utf-8?B?MFE0eGRzWG5uNjJ5d2grbDdsVmZYR3VYWDV2UG1LN3VsR3FxS09QYmd2NTgz?=
 =?utf-8?B?dklTL2p3WktVeUJYMjk4dzg1eDNiL1BxbC9uc1Z6ekJtTnl0TEs1QTExbTYy?=
 =?utf-8?B?ZVV4Wnl0c0sreUxMSXdRQ2pzK09qK0xsamlLVlFlMTBXNElvdTE3bU80YlhR?=
 =?utf-8?B?dkdORmxiNFlmd014Ynh6K0c2bXlWQ0VGY0VUVFNidGdjd0hzWjdaV2FvNGp2?=
 =?utf-8?B?WDBIcUR4T1dHM3RNaHVUZzBZK0p4eVc3VUZRaW1VWFhqT0JoUUJ2SzRPeFhT?=
 =?utf-8?B?QndDazJ0R1ZOWHZBYVNaaVRmN2xQUzBtVFRDNE1FbXRpUGtyVnNhWk1sY1Jy?=
 =?utf-8?B?K0p6YXRFTmVMOEVLRTUxdFF1REZ2WFJPazlWdmh0YnVVMzdBOWFCYjYxZ0Q4?=
 =?utf-8?B?MHI1U0hOcXB0azhPSWhFZktzRkxxdzN5R1FVT1U5WFN2VkhUNXA0U2xvS1FR?=
 =?utf-8?B?MnpvMjdXWmpNY05CTkZObkpldHBJVzA3TzNNRWpNZi9BUnBsUERzeitLYm4z?=
 =?utf-8?B?TGx2SVFnWjh3RyswWVJ6ak5ONCt5Y0ZySTVNMGhEa2ZxdTE4UkQxVEE2T3Jz?=
 =?utf-8?B?QzJCNFJEeXl6eEJDbUY5d091K1lBaTh0VndXYkFJKy9qY3Y5WVRrcWo4cFB2?=
 =?utf-8?B?VnZIOUJTamlqeEdLeUlINFU3bUx4N1hyUDFDd0swR1hLR2V3ZWxVbnhDWmZD?=
 =?utf-8?B?VS9CUFVMQkNaY3FPNGFDV0VSQ3RJNkZzUTd5S1QvbGlMQk0wK0R0UXhjRjh4?=
 =?utf-8?B?SGNZcXIyNnE0WEE3N2Q1dHFFWE1UUDcwZkN0U2VZWDRyQXUvUzViZXdhbUU0?=
 =?utf-8?B?TkI0VkREMHpPeUhWd2dxWFF6WENZNDBBV2R0UlVSQ1c0bzNEdkNRRGhyVmsy?=
 =?utf-8?B?RVJsdmFlWjE0cEszc0hBWTJwbEtNOXcyVEVjMlRiMks3THJrWXE4dHVCMjZs?=
 =?utf-8?B?VjdabkNDVFpvTFhZcHBxQ3kzNTVnMjhVMXEzcUkvd1lPV3A1djRpbVpIakdj?=
 =?utf-8?B?T3JNU1RjcmdqdUYxdkhTSExFUm1FaEgzOXoxUXgyZFFNWUs5OFBsWWU5Y3Z5?=
 =?utf-8?B?M1pDYVhiSmhuaEVWVkYrMEVURjNHdW1lclFtam9zKzV1cGFIbGlHUzhqTjY4?=
 =?utf-8?B?UFFmc3gvUkR1NGRYKzE4U283OGt3SG9UUFFvOGpRVmFJK0N2OU5XeFNOMm9I?=
 =?utf-8?B?dlFVTFEwakZqTjl0RjVQSUZxck5ySDVSbTNZeEJxdlltZ1pWMFhub0pBdVJG?=
 =?utf-8?B?T0RUUitXV3hnM004aTJua1VPQ095Rnl5KzNUYW04RkFJWUplajBTNGJpbnJX?=
 =?utf-8?B?RVNJY3hlSDRLQWpBNkI5QmpjNnZxTmVyMDhkb0I5SjAxYlB6ZVpkTmFwcFps?=
 =?utf-8?B?NUs0ZEw5aUhYaDE3Q2l2WWsrNWJTVStwRGJhSmZYbFJHRFp3QVFVU3B2eFlI?=
 =?utf-8?B?cTZ4U3VoSWRZRldVcEJNYjdVbVpnZWczMVBOZ0gxdDVaU1kzeGpscEVFMUZl?=
 =?utf-8?Q?ZesTEfCS9iJTxa28XI1Gj707S?=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: SJ0PR11MB6744.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 46eb1e47-6b3a-4eba-dc51-08dd5474b4b1
X-MS-Exchange-CrossTenant-originalarrivaltime: 24 Feb 2025 01:43:58.0704 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: YX6C4FmuwfDsxkKCT21MzWB6Qgf2cWaLaPDua2GS+cvjyGj4t2N1s6+pYxU2wvlqzR8uyJ9yX6sCYNXies45Tm6DaSlFce+shPehL95eIJo=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BY1PR11MB8078
X-OriginatorOrg: intel.com
Received-SPF: pass client-ip=198.175.65.11;
 envelope-from=zhenzhong.duan@intel.com; helo=mgamail.intel.com
X-Spam_score_int: -47
X-Spam_score: -4.8
X-Spam_bar: ----
X-Spam_report: (-4.8 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.446,
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

DQoNCj4tLS0tLU9yaWdpbmFsIE1lc3NhZ2UtLS0tLQ0KPkZyb206IEFsZXggV2lsbGlhbXNvbiA8
YWxleC53aWxsaWFtc29uQHJlZGhhdC5jb20+DQo+U3ViamVjdDogW1BBVENIIDAvNV0gUENJOiBJ
bXBsZW1lbnQgYmFzaWMgUENJIFBNIGNhcGFiaWxpdHkgYmFja2luZw0KPg0KPkVyaWMgcmVjZW50
bHkgaWRlbnRpZmllZCBhbiBpc3N1ZVsxXSB3aGVyZSBkdXJpbmcgZ3JhY2VmdWwgc2h1dGRvd24N
Cj5vZiBhIFZNIGluIGEgdklPTU1VIGNvbmZpZ3VyYXRpb24sIHRoZSBndWVzdCBkcml2ZXIgcGxh
Y2VzIHRoZSBkZXZpY2UNCj5pbnRvIHRoZSBEMyBwb3dlciBzdGF0ZSwgdGhlIHZJT01NVSBpcyB0
aGVuIGRpc2FibGVkLCB0cmlnZ2VyaW5nIGFuDQo+QWRkcmVzc1NwYWNlIHVwZGF0ZS4gIFRoZSBk
ZXZpY2UgQkFScyBhcmUgc3RpbGwgbWFwcGVkIGludG8gdGhlIEFTLA0KPmJ1dCB0aGUgdmZpbyBo
b3N0IGRyaXZlciByZWZ1c2VzIHRvIERNQSBtYXAgdGhlIE1NSU8gc3BhY2UgZHVlIHRvIHRoZQ0K
PmRldmljZSBwb3dlciBzdGF0ZS4NCj4NCj5UaGUgcHJvcG9zZWQgc29sdXRpb24gaW4gWzFdIHdh
cyB0byBza2lwIG1hcHBpbmdzIGJhc2VkIG9uIHRoZQ0KPmRldmljZSBwb3dlciBzdGF0ZS4gIEhl
cmUgd2UgdGFrZSBhIGRpZmZlcmVudCBhcHByb2FjaC4gIFRoZSBQQ0kgc3BlYw0KPmRlZmluZXMg
dGhhdCBkZXZpY2VzIGluIEQxLzIvMyBwb3dlciBzdGF0ZSBzaG91bGQgcmVzcG9uZCBvbmx5IHRv
DQo+Y29uZmlndXJhdGlvbiBhbmQgbWVzc2FnZSByZXF1ZXN0cyBhbmQgYWxsIG90aGVyIHJlcXVl
c3RzIHNob3VsZCBiZQ0KPmhhbmRsZWQgYXMgYW4gVW5zdXBwb3J0ZWQgUmVxdWVzdC4gIEluIG90
aGVyIHdvcmRzLCB0aGUgbWVtb3J5IGFuZA0KPklPIEJBUnMgYXJlIG5vdCBhY2Nlc3NpYmxlIGV4
Y2VwdCB3aGVuIHRoZSBkZXZpY2UgaXMgaW4gdGhlIEQwIHBvd2VyDQo+c3RhdGUuDQo+DQo+VG8g
ZW11bGF0ZSB0aGlzIGJlaGF2aW9yLCB3ZSBjYW4gZmFjdG9yIHRoZSBkZXZpY2UgcG93ZXIgc3Rh
dGUgaW50bw0KPnRoZSBtYXBwaW5nIHN0YXRlIG9mIHRoZSBkZXZpY2UgQkFScy4gIFRoZXJlZm9y
ZSB0aGUgQkFSIGlzIG1hcmtlZA0KPmFzIHVubWFwcGVkIGlmIGVpdGhlciB0aGUgcmVzcGVjdGl2
ZSBjb21tYW5kIHJlZ2lzdGVyIGVuYWJsZSBiaXQgaXMNCj5jbGVhciBvciB0aGUgZGV2aWNlIGlz
IG5vdCBpbiB0aGUgRDAgcG93ZXIgc3RhdGUuDQo+DQo+SW4gb3JkZXIgdG8gaW1wbGVtZW50IHRo
aXMsIHRoZSBQb3dlclN0YXRlIGZpZWxkIG9mIHRoZSBQTUNTUg0KPnJlZ2lzdGVyIGJlY29tZXMg
d3JpdGFibGUsIHdoaWNoIGFsbG93cyB0aGUgZGV2aWNlIHRvIGFwcGVhciBpbg0KPmxvd2VyIHBv
d2VyIHN0YXRlcy4gIFRoaXMgYWxzbyB0aGVyZWZvcmUgaW1wbGVtZW50cyBEMyBzdXBwb3J0DQo+
KGluc29mYXIgYXMgdGhlIEJBUiBiZWhhdmlvcikgZm9yIGFsbCBkZXZpY2VzIGltcGxlbWVudGlu
ZyB0aGUgUE0NCj5jYXBhYmlsaXR5LiAgVGhlIFBDSSBzcGVjIHJlcXVpcmVzIEQzIHN1cHBvcnQu
DQo+DQo+QW4gYXNwZWN0IHRoYXQgbmVlZHMgYXR0ZW50aW9uIGhlcmUgaXMgd2hldGhlciB0aGlz
IGNoYW5nZSBpbiB0aGUNCj53bWFzayBhbmQgUE1DU1IgYml0cyBiZWNvbWVzIGEgcHJvYmxlbSBm
b3IgbWlncmF0aW9uLCBhbmQgaG93IHdlDQo+bWlnaHQgc29sdmUgaXQuICBGb3IgYSBndWVzdCBt
aWdyYXRpbmcgb2xkLT5uZXcsIHRoZSBkZXZpY2Ugd291bGQNCj5hbHdheXMgYmUgaW4gdGhlIEQw
IHBvd2VyIHN0YXRlLCBidXQgdGhlIHJlZ2lzdGVyIGJlY29tZXMgd3JpdGFibGUuDQo+SW4gdGhl
IG9wcG9zaXRlIGRpcmVjdGlvbiwgaXMgaXQgcG9zc2libGUgdGhhdCBhIGRldmljZSBjb3VsZA0K
Pm1pZ3JhdGUgaW4gYSBsb3cgcG93ZXIgc3RhdGUgYW5kIGJlIHN0dWNrIHRoZXJlIHNpbmNlIHRo
ZSBiaXRzIGFyZQ0KPnJlYWQtb25seSBpbiBvbGQgUUVNVT8gIERvIHdlIG5lZWQgYW4gb3B0aW9u
IGZvciB0aGlzIGJlaGF2aW9yIGFuZCBhDQo+bWFjaGluZSBzdGF0ZSBidW1wLCBvciBhcmUgdGhl
cmUgYWx0ZXJuYXRpdmVzPw0KPg0KPlRoYW5rcywNCj5BbGV4DQo+DQo+WzFdaHR0cHM6Ly9sb3Jl
Lmtlcm5lbC5vcmcvYWxsLzIwMjUwMjE5MTc1OTQxLjEzNTM5MC0xLQ0KPmVyaWMuYXVnZXJAcmVk
aGF0LmNvbS8NCj4NCj5BbGV4IFdpbGxpYW1zb24gKDUpOg0KPiAgaHcvcGNpOiBCYXNpYyBzdXBw
b3J0IGZvciBQQ0kgcG93ZXIgbWFuYWdlbWVudA0KPiAgcGNpOiBVc2UgUENJIFBNIGNhcGFiaWxp
dHkgaW5pdGlhbGl6ZXINCj4gIHZmaW8vcGNpOiBEZWxldGUgbG9jYWwgcG1fY2FwDQo+ICBwY2ll
LCB2aXJ0aW86IFJlbW92ZSByZWR1bmRhbnQgcG1fY2FwDQo+ICBody92ZmlvL3BjaTogUmUtb3Jk
ZXIgcHJlLXJlc2V0DQoNCkZvciB0aGUgd2hvbGUgc2VyaWVzLA0KDQpSZXZpZXdlZC1ieTogWmhl
bnpob25nIER1YW4gPHpoZW56aG9uZy5kdWFuQGludGVsLmNvbT4NCg0KVGhhbmtzDQpaaGVuemhv
bmcNCg==

