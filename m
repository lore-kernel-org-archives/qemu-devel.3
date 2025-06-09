Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id AB8D6C61CE7
	for <qemu-devel@archiver.kernel.org>; Mon,  9 Jun 2025 03:07:00 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uOSqT-0005f0-3f; Sun, 08 Jun 2025 23:06:45 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <zhenzhong.duan@intel.com>)
 id 1uOSqR-0005cx-1V
 for qemu-devel@nongnu.org; Sun, 08 Jun 2025 23:06:43 -0400
Received: from mgamail.intel.com ([198.175.65.10])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <zhenzhong.duan@intel.com>)
 id 1uOSqN-0001i7-5V
 for qemu-devel@nongnu.org; Sun, 08 Jun 2025 23:06:42 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1749438399; x=1780974399;
 h=from:to:cc:subject:date:message-id:references:
 in-reply-to:content-transfer-encoding:mime-version;
 bh=QTnWuZs1gbwoTgjE5GUeNPknBZiMwXoTmnBcc+4jo0g=;
 b=cJ/wITmf3wEw/UIob4npdA/YWG1zwoEhL9kuYU42Z7vAr8JFUDGCf5h1
 af4PDdKHRNuY4IIFPSxGlEyLPtCJXZbrVxyGprt250H3OXqeDx4f4lq3T
 jOCFJez5vS+2Z1VfDzlRsk8LRqgoVSfIoE6QAlI/ohxPR+3UR8yLIxhMX
 4kFHCGkmhaj8NZQZA9f81VxpzgVBBmZ/hBNqifEc7/ufSHh4eko29JlO2
 lrhJ/SYD7dJaXQGt6Mc3uXUZyON+XX3XcLKchghnXNCdL14FLKJhgAGJW
 kyBC94G7fkegyIdLi+pHfqgA1E2mxC5B0IG1MHc4Gt2CnVwR61NRCaI2K w==;
X-CSE-ConnectionGUID: XVs0kPekS6q1mTkSFiOF4A==
X-CSE-MsgGUID: eMLPTV/kQNCTLsWJAy5V0Q==
X-IronPort-AV: E=McAfee;i="6800,10657,11458"; a="68954987"
X-IronPort-AV: E=Sophos;i="6.16,221,1744095600"; d="scan'208";a="68954987"
Received: from orviesa005.jf.intel.com ([10.64.159.145])
 by orvoesa102.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 08 Jun 2025 20:06:31 -0700
X-CSE-ConnectionGUID: x3OzgspfRIO1kFERFqFO4Q==
X-CSE-MsgGUID: jyCFZmX6Sbumw8ucGE+Oyw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.16,221,1744095600"; d="scan'208";a="151625447"
Received: from orsmsx901.amr.corp.intel.com ([10.22.229.23])
 by orviesa005.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 08 Jun 2025 20:06:26 -0700
Received: from ORSMSX901.amr.corp.intel.com (10.22.229.23) by
 ORSMSX901.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.25; Sun, 8 Jun 2025 20:06:22 -0700
Received: from ORSEDG902.ED.cps.intel.com (10.7.248.12) by
 ORSMSX901.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.25 via Frontend Transport; Sun, 8 Jun 2025 20:06:22 -0700
Received: from NAM11-DM6-obe.outbound.protection.outlook.com (40.107.223.56)
 by edgegateway.intel.com (134.134.137.112) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.25; Sun, 8 Jun 2025 20:06:22 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=BZiblpURB4HiANAEUGrGXw7bWWPNpvRV8pqhwnooAY/V50Fi0LHnU8q8Rn467NXXtjgdULaNeWJGMlXl9E+Wb+sxepyCk8AAoYi3atgjc4AYJZYd8oCy9I4ho8Q3CFusLqw8L/rB39xKOFJF4e3Ffon8Y1DAgy4zggQL+VPkJBVWG2ngev/q4TumKuFhoxSgeLtyh1st5xWI67UNG/Bg6JnnaHAZvbex+TZk9hHvSyl30R/f8AbqFg5k6+P9aXAk8L9xs6kKvVdUCOOQwAZaVXnkdwj1H9gRxTjDnVL6carRpsRxGhvFK4KmlOQazK2owcaN15WikfuaCG4f1BlZ3A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=QTnWuZs1gbwoTgjE5GUeNPknBZiMwXoTmnBcc+4jo0g=;
 b=pLIic3CzkALVVn17gGNsyeKYla2WWLtozzhh2cL8vUfkLmExo4yjHjZa1wkDgqVVsO7pohwS93CkNGIm0kb6b4pAQT0i5qBGM3hM5SdhopgxAqFYEdByRTFkIPGr6/WuwzLS65q4FcwsppxXqo/t6FRG5l9ZBEjYjaWsMEP/Amr4TWTQ0tfDtMCwC2mZcoR/O2Ox4JPeNoP5ajS1D5acngiXzLmDucqpKwXzHDsN3sSlFS7U0wVpcGM42kxujKj6C04RgpCDoQDcBENZ/9IDREeNFeEopwSbmphIgRacbN99pVn0qt6i3oVhL96NgSbUM3CDZDwymCgDbKpYsp18uQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Received: from IA3PR11MB9136.namprd11.prod.outlook.com (2603:10b6:208:574::12)
 by BN9PR11MB5291.namprd11.prod.outlook.com (2603:10b6:408:118::10)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8813.27; Mon, 9 Jun
 2025 03:06:01 +0000
Received: from IA3PR11MB9136.namprd11.prod.outlook.com
 ([fe80::604b:77a4:b1be:3f13]) by IA3PR11MB9136.namprd11.prod.outlook.com
 ([fe80::604b:77a4:b1be:3f13%4]) with mapi id 15.20.8813.021; Mon, 9 Jun 2025
 03:06:00 +0000
From: "Duan, Zhenzhong" <zhenzhong.duan@intel.com>
To: =?utf-8?B?UGhpbGlwcGUgTWF0aGlldS1EYXVkw6k=?= <philmd@linaro.org>,
 "qemu-devel@nongnu.org" <qemu-devel@nongnu.org>
CC: "Peng, Chao P" <chao.p.peng@intel.com>, "david@redhat.com"
 <david@redhat.com>, "armbru@redhat.com" <armbru@redhat.com>, Yoshinori Sato
 <ysato@users.sourceforge.jp>, Magnus Damm <magnus.damm@gmail.com>,
 =?utf-8?B?TWFyYy1BbmRyw6kgTHVyZWF1?= <marcandre.lureau@redhat.com>, "Paolo
 Bonzini" <pbonzini@redhat.com>, Peter Maydell <peter.maydell@linaro.org>
Subject: RE: [PATCH v4 4/5] hw/char/sh_serial: Remove dummy definition of
 SH_SERIAL class
Thread-Topic: [PATCH v4 4/5] hw/char/sh_serial: Remove dummy definition of
 SH_SERIAL class
Thread-Index: AQHb1sVT39mcgWnFu0S233Fx2tsQW7P18TEAgAACdQCABCUBUA==
Date: Mon, 9 Jun 2025 03:06:00 +0000
Message-ID: <IA3PR11MB91369147EE755DBD984539CA926BA@IA3PR11MB9136.namprd11.prod.outlook.com>
References: <20250606092406.229833-1-zhenzhong.duan@intel.com>
 <20250606092406.229833-5-zhenzhong.duan@intel.com>
 <22f73acc-bc5e-4cf5-bbd9-c2c94bec9d33@linaro.org>
 <10e43884-d147-4031-bcec-0a7c528e3103@linaro.org>
In-Reply-To: <10e43884-d147-4031-bcec-0a7c528e3103@linaro.org>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: IA3PR11MB9136:EE_|BN9PR11MB5291:EE_
x-ms-office365-filtering-correlation-id: b4a9f7b5-6681-4c07-d3c7-08dda7029038
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
 ARA:13230040|1800799024|376014|366016|7053199007|38070700018; 
x-microsoft-antispam-message-info: =?utf-8?B?d2F5dDBjVXpqcGZrWGIxWFN5MmIxOW1WSC9EcSsyWnlYekRadUlGUnpvcU5h?=
 =?utf-8?B?WmNnYkRGK0pyTlpPR0R4a04vRDJxVFBnRTJRS2RvUkNXOHRRVzVrUXR3TkY2?=
 =?utf-8?B?d3d0SjE0N1hKUXcvajhnUXc3bVRTY0dBNHdoNHgyVmVsemY2QmdqSkl0d0Rk?=
 =?utf-8?B?S2VSb3J0czZzTUFWbkFWcFVUbkxWUFJlMlZYeGdTd0UxU1JLWkx6akdwOUVu?=
 =?utf-8?B?Wnpzd2dDdkFoS2lwR2R3SE4xR3dJSlVUNFRGcTd0ZUJSVHAwYmw5cVBxc05a?=
 =?utf-8?B?U05DYTVCZjVEbitpQkg2S29na3h0cHVEZCtjcTVTODl5YU1QajAvc0hvL2dZ?=
 =?utf-8?B?TEY4U2t0Y0lHOEx4bTFKbEM1MFQ2dG1ZRXpzNTJDUDV3NGM2ZUtrNXh5eThu?=
 =?utf-8?B?UUoxWDVEV1BRSWdjR0RyajI1VlVOZ0hqM05QeWw0MmNvWnk3Q2ZTYnFMT1ow?=
 =?utf-8?B?MGZhcjROdVpJcXB6VUFSUGJUU2RXUVIxYzd2TTVSSHBrWWY2dE9qVTVEczNz?=
 =?utf-8?B?SGFxS0FRVmVuRXZsNUkxU2dWZktxamFISzhsQ1RlMEdUQkNURnIzeHN2R2g2?=
 =?utf-8?B?NVJLSUFZYTBDeEsyRmwzTy9neDBEV3pFdUsxTnJRZ3diQWpwWmQ5N09UWnpF?=
 =?utf-8?B?UCt3TmFsdHl4bHZaZ1h1ZUVuSENxRGtpRG04WmVRM2VibjE3VGJ3MzZtZk9u?=
 =?utf-8?B?bEJ4VGVDdkk2Q2pQN3dWREszM2d1N1Z5QnlETTBDNEFtdHZhM2Z3WGRIaTgx?=
 =?utf-8?B?TjlFektRSWx6UGVYV1FSRkxLbDZEUVZVdm0rYTdvSS96Ym8vZ0hPU2xhN2lY?=
 =?utf-8?B?NlRkS3IzcGU3YVdOcmgzenNvQm9CQ0krd212M3BONExNZjAzbGNZODBSVEgv?=
 =?utf-8?B?TUttMGNnSGtRaUFlZU4xSjVKU0tRT3NqcXE4N0huK1dFTW9zTm5tZTJ4V3NT?=
 =?utf-8?B?ZkFrSDVoQ2dWS25IbERhMkdLWnZ6c3l2bTdYN1QvbERuV21CTGlHMFVBaWhv?=
 =?utf-8?B?a09iaTJjK0ZqYVZyUXVoTmE5anFXTlNSVytncUhzeFZMdzZWdDJkQjV5aDdD?=
 =?utf-8?B?QmVHL0RXYmVUbHBTcjlJejFiS3I4SldFL05PRTNHODg1MXprdUI4NUo2V09q?=
 =?utf-8?B?SUJRc2E3WFhrZEh3MzZyeFBaZVpaek9LOFlqMTFLMS8zcmpCV2xWcjU3bldv?=
 =?utf-8?B?UVcvNGZMc0lUcWprS1pIenJJSDl5a0RVQWJZQTY5c042TGdnZHplZEZDZkJx?=
 =?utf-8?B?ZEZmWE94SXdyL0pzNTBJMmxwaDA3ZklqY2VYWnZpSXJNRENpVXFIcWpNVmtn?=
 =?utf-8?B?MENqSkdkRTNvcWpsN1hSRGRLTjNQM1ovNDBtVS95ZTQ2ck1hVGxjdm5Rd0VQ?=
 =?utf-8?B?ZmFzZWRGUHkzVEtFMDFqdGVkMWM1Q0xOYXBUdXJZRG56ck5iaXNOTlFwei84?=
 =?utf-8?B?WWZNL3dwM2dyS1F5RURQVEFDNEpsM2ZjWS9XWFlVNFVXakd0WHhpQ1JKcXIz?=
 =?utf-8?B?S2duemlYWi9nRWdSdmR4aFNxSDNGcHpXL1FyRC9ZeURzS053dzdBc1I3N29W?=
 =?utf-8?B?cDZUTVdGTWRJMXJrcmpFVnl3dWNQdEtJSmxxWGljODNOUVE1LzhsWm1NcmpR?=
 =?utf-8?B?NVl0RTIrRmtITldhajZrSUhGY1pZYVoxQlhCbUx6ZzlSckJmWDgwUEpLNXJX?=
 =?utf-8?B?RUo4VEUzcEVRKzVZTGxGYk9RdG91c29TOUlvMVh4MjQ4Q0pDbmJOUmsvZnhL?=
 =?utf-8?B?MHAxbElXdzZWZ2c2dkUxbjlYWjNQQTRmZ3kzM3VNR1lMVWVYNys2WWxsRkY0?=
 =?utf-8?B?ZzdDc3pOL1Urai9qdytCeVJNUXFBQngwOU04c0NVVVFkb1hlQWJrUWJ0SUpw?=
 =?utf-8?B?Y0pmak5WT1FIVWZrekt3K3BSN0s4ODNNZ3JRVlphK0RiVlE4UWNSQWdPaUty?=
 =?utf-8?B?S29hMUlyS3RRTklRbDhKZHRpUUpTQnpQd08xWjJxT3hnWDlhbjhhUjFybnUx?=
 =?utf-8?Q?681rXiSUPQqQ/xR+6x2MDO6N2HPKqU=3D?=
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:IA3PR11MB9136.namprd11.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(1800799024)(376014)(366016)(7053199007)(38070700018); DIR:OUT;
 SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?UXV5WjZoK05HbDVkWjVnQVhGeGFTZVRaYTZBZ2RsaE8vZDJOQ1JjekR4Vmd3?=
 =?utf-8?B?eSt6VkxpVXdPSFNpMno0bVdpZDBEbFNwWWx3WWY3RjhuSVpwVk1yYzNBc20x?=
 =?utf-8?B?YnBCQnoxNEtmbjZoRks0YTRqajhFRFJBU1RWUzlXNkM4MWNGWXhVaHZKM0t1?=
 =?utf-8?B?NjNjL3p3NllFME5Qdi9jT25tYkovZTdkbkxkYk8wRTlpYkRneFM0bHhwMWhW?=
 =?utf-8?B?V01QMTVWK2xLb1lTQ3hMSGxiVk5ZSEViOGU3Sm9uTktjNVY2RzN6bjNZUW5j?=
 =?utf-8?B?MFBnNEZMVkJsRWlZOE9FU0p2cCszUVdDQlFTMFlZcDhPemZmVDhNRDNqMFhK?=
 =?utf-8?B?dDRlUlJuODJMbVFqTzZFa2psWlk1RVpRZk4xaUhlWG1pK2ZoT3ZWMEFqY1pV?=
 =?utf-8?B?K2U0ZjJidDV6SUFkRng4SmNaT1RkTThpTXVGV1FLcXhoM2F4bkVuN3ZHL2RR?=
 =?utf-8?B?SStSQVp0MVV1STNySFZvc0dZcE1tTHNQMzJZeWVoTkVCVGNyQXdsMW9RU2pq?=
 =?utf-8?B?QzBjYlhuZzkwTzR4RGsxa0MxcVVkTjAzSUE4eHBCVXpuODhwK1NvYmgvWTRY?=
 =?utf-8?B?L2RUNDZIQm1DVDZVZHRUNEdkOFB1alZJck5ZZ01hOE9DaldaSTUyT2FoZkor?=
 =?utf-8?B?V0t2T095TktCSHF6bXQrMGRCS1Ixc1U4VnI4UDhUNit5Yzg5MkJJV3NUdGpF?=
 =?utf-8?B?VFhWTEZMdVF3ejNiVUhnM2o0QmR6Yk85Q1FlTjZmVlNibGk4Qkl2ZXpyK2xw?=
 =?utf-8?B?L01WcUlYYUdRMGVobllEMHU4eGtqb3NIemgvbkZQQ1gzdGhNdVlwUnBtVjlx?=
 =?utf-8?B?Qi80RitxWHFtdWZ0UDJvd2UxL2ExUDlvVkh4bWttU2pXTlRpSE9KYWNYZklY?=
 =?utf-8?B?a3ZCZ2ZQUitJM1dSUHJNTlVUQnBlaWlwekhocDk3OFN0RS9zQ2FHekhZbXEw?=
 =?utf-8?B?RnhJb3d3U1NXVWNUeS9sVjhEUHc2TGRQbGhwR004N1pWRnBpU0ZRcy8rZFRJ?=
 =?utf-8?B?YXd1MWNyNzRMaklabTBnZ3RSejdOWkc5V2Fqc24yNDBSeUI5NjR4ci9jMDJx?=
 =?utf-8?B?NEw0VFhIZTk0RVVieUx5R0dWWFJ4RGthZmYrVHVvTitCNGt6cldQeGhUS2RM?=
 =?utf-8?B?OUZpcEdJLzZ3NmpiTkZWVDVqZ3N5bERObUZoL1lOendUR281bDVhSDljS00z?=
 =?utf-8?B?RW5wM3lNWFpkYkRYL3hSaTJJNXllM0pQbVRqaWNJMGZNLzZYUW1WVTlieGhv?=
 =?utf-8?B?Zi8xUEdKR0RxR0JXa09kYzRVcmpLWGcxbUVTMGwzVTJUNStITktyUFFpR0gx?=
 =?utf-8?B?cFdubXZXYS8xVXVuUy9uT05jTm1Kc09MQlJJOERpckg5dXBzQTZwTzlCNGIw?=
 =?utf-8?B?aWV5eG8vdnlvekpnZnREbkU1NUQvMUIwVXgwejJBS1NVa0R0VURpN1FIOWN0?=
 =?utf-8?B?cFNPVGhwRlB1YVdVUFZtOEV3Rmt1c0c1NHo1d3cxS3llMkNUeGI0OWFHNFB4?=
 =?utf-8?B?R3ZXZVp3alBtT2t6aU5INlJZYlNaKzk3M21zWnMwL2xjdWt2bTk5M0l2R0hm?=
 =?utf-8?B?KytQelI4SGIwUFQyaTlEZkRHM2w2dkNJZFl2eGIwNE5JRE13K3BsMGdCV20z?=
 =?utf-8?B?eWw2dHpLbXMyQVlQNlNBZmFUc05yc2t1b3IwNXdSNU5qSnFFcFRxM0FaUGdy?=
 =?utf-8?B?S2NiYnhyMUVNWXg3QWNhb2t5UlJDaDIvaDZtdmRtVW82UG1PbWhDd0pVN0dI?=
 =?utf-8?B?M2FIR014YWNEMzlFM2FCVjduMUJ2ZTNFbkthMVBRNVloOHlJTmlVQmJuOXla?=
 =?utf-8?B?YVhicDhlRWpnMi9LZjE1clM2SlpSREp4Z3I5NXNDcHdDM3g4T2ljSVY0YU4x?=
 =?utf-8?B?ajgxTFZtTkNJTnZkeUs0L3NGMDRQdGpiSHlMT1ZONU9Ib3VmWnBET3ZhN1ZE?=
 =?utf-8?B?bDEyUitmdDI4NnZ1TDh0VmxicTA1NkpJM0p0c1JpMlloanp0dU00MlY3c0dM?=
 =?utf-8?B?czBCMUV0VkZhWTA4Nm5iQUE1dHBzR0dCVTdlcERnWll6MU9hZkRtaVZ0eWpJ?=
 =?utf-8?B?UEd0RlE4b3dMNHhqS2VBWFladDJQNFpxS1MxNU02bnloS3Fhd3VGOU01b3R6?=
 =?utf-8?Q?Uekt5UJJlG+U5fmzZ6hCLrHzC?=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: IA3PR11MB9136.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: b4a9f7b5-6681-4c07-d3c7-08dda7029038
X-MS-Exchange-CrossTenant-originalarrivaltime: 09 Jun 2025 03:06:00.7791 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: tubWeXZJRjN5PK8s3faO66VKaCj6wLp5Z1a1oMLTGQ7olR5e+23j4J+qxRXk4E9MDaMrM3hz/fn6SaEYu1RtYd0LOdCbFDTUIjp/b3EhsR8=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BN9PR11MB5291
X-OriginatorOrg: intel.com
Received-SPF: pass client-ip=198.175.65.10;
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

DQoNCj4tLS0tLU9yaWdpbmFsIE1lc3NhZ2UtLS0tLQ0KPkZyb206IFBoaWxpcHBlIE1hdGhpZXUt
RGF1ZMOpIDxwaGlsbWRAbGluYXJvLm9yZz4NCj5TdWJqZWN0OiBSZTogW1BBVENIIHY0IDQvNV0g
aHcvY2hhci9zaF9zZXJpYWw6IFJlbW92ZSBkdW1teSBkZWZpbml0aW9uIG9mDQo+U0hfU0VSSUFM
IGNsYXNzDQo+DQo+T24gNi82LzI1IDEyOjQwLCBQaGlsaXBwZSBNYXRoaWV1LURhdWTDqSB3cm90
ZToNCj4+IE9uIDYvNi8yNSAxMToyNCwgWmhlbnpob25nIER1YW4gd3JvdGU6DQo+Pj4gU0hfU0VS
SUFMIGlzIGRlY2xhcmVkIHdpdGggT0JKRUNUX0RFQ0xBUkVfU0lNUExFX1RZUEUgYnV0IGRlZmlu
ZWQgd2l0aA0KPj4+IE9CSkVDVF9ERUZJTkVfVFlQRSwgU0hTZXJpYWxTdGF0ZUNsYXNzIGlzIGFs
c28gYSBkdW1teSBjbGFzcyB3aGljaA0KPj4+IG1pc3NlZCBpdHMgcGFyZW50Lg0KPj4+DQo+Pj4g
Q2hhbmdlIHRvIHVzZSBPQkpFQ1RfREVGSU5FX1NJTVBMRV9UWVBFIGFuZCByZW1vdmUgU0hTZXJp
YWxTdGF0ZUNsYXNzLg0KPj4+DQo+Pj4gQ2xvc2VzOiBodHRwczovL2xpc3RzLmdudS5vcmcvYXJj
aGl2ZS9odG1sL3FlbXUtZGV2ZWwvMjAyNS0wNi8NCj4+PiBtc2cwMDU4Ni5odG1sDQo+Pj4gU3Vn
Z2VzdGVkLWJ5OiBEYXZpZCBIaWxkZW5icmFuZCA8ZGF2aWRAcmVkaGF0LmNvbT4NCj4+PiBTaWdu
ZWQtb2ZmLWJ5OiBaaGVuemhvbmcgRHVhbiA8emhlbnpob25nLmR1YW5AaW50ZWwuY29tPg0KPj4+
IC0tLQ0KPj4+IMKgIGh3L2NoYXIvc2hfc2VyaWFsLmMgfCA0ICstLS0NCj4+PiDCoCAxIGZpbGUg
Y2hhbmdlZCwgMSBpbnNlcnRpb24oKyksIDMgZGVsZXRpb25zKC0pDQo+Pj4NCj4+PiBkaWZmIC0t
Z2l0IGEvaHcvY2hhci9zaF9zZXJpYWwuYyBiL2h3L2NoYXIvc2hfc2VyaWFsLmMNCj4+PiBpbmRl
eCA2YWJkODAzODZmLi44Y2NjMjIzNGJhIDEwMDY0NA0KPj4+IC0tLSBhL2h3L2NoYXIvc2hfc2Vy
aWFsLmMNCj4+PiArKysgYi9ody9jaGFyL3NoX3NlcmlhbC5jDQo+Pj4gQEAgLTc4LDkgKzc4LDcg
QEAgc3RydWN0IFNIU2VyaWFsU3RhdGUgew0KPj4+IMKgwqDCoMKgwqAgcWVtdV9pcnEgYnJpOw0K
Pj4+IMKgIH07DQo+Pj4gLXR5cGVkZWYgc3RydWN0IHt9IFNIU2VyaWFsU3RhdGVDbGFzczsNCj4+
PiAtDQo+Pj4gLU9CSkVDVF9ERUZJTkVfVFlQRShTSFNlcmlhbFN0YXRlLCBzaF9zZXJpYWwsIFNI
X1NFUklBTCwgU1lTX0JVU19ERVZJQ0UpDQo+Pj4gK09CSkVDVF9ERUZJTkVfU0lNUExFX1RZUEUo
U0hTZXJpYWxTdGF0ZSwgc2hfc2VyaWFsLCBTSF9TRVJJQUwsDQo+Pj4gU1lTX0JVU19ERVZJQ0Up
DQo+Pg0KPj4gSSdtIHN1cnByaXNlZCB0aGlzIGlzIHRoZSBmaXJzdCB0aW1lIHdlIHVzZSBPQkpF
Q1RfREVGSU5FX1NJTVBMRV9UWVBFLg0KDQpBaCwgeWVzLg0KDQo+DQo+QWN0dWFsbHkgSSBhbHJl
YWR5IHBvc3RlZCBhIHBhdGNoIGNsZWFuaW5nIHRoYXQuLi46DQo+DQo+aHR0cHM6Ly9sb3JlLmtl
cm5lbC5vcmcvcWVtdS1kZXZlbC8yMDI1MDEyNDE3NTA1My43NDQ2MS0xLQ0KPnBoaWxtZEBsaW5h
cm8ub3JnLw0KDQpHb29kIHRvIHNlZS4NCg0KPg0KPkFsc28gSSBub3cgbm90aWNlIEkgbmV2ZXIg
cmVwbGllZCB0byBQZXRlcidzIHF1ZXN0aW9ucy4gSSdsbCBhbmQNCj5xdWV1ZSB0aGUgc2VyaWVz
LCBhbG9uZyB3aXRoIHlvdXJzLg0KVGhhbmtzLg0KDQpCUnMsDQpaaGVuemhvbmcNCg==

