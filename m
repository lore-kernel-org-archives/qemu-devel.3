Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id AE49AC3600B
	for <qemu-devel@archiver.kernel.org>; Thu, 27 Mar 2025 09:55:13 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1txjwV-0007WM-3Y; Thu, 27 Mar 2025 05:54:31 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <zhenzhong.duan@intel.com>)
 id 1txjwT-0007W0-1n
 for qemu-devel@nongnu.org; Thu, 27 Mar 2025 05:54:29 -0400
Received: from mgamail.intel.com ([192.198.163.14])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <zhenzhong.duan@intel.com>)
 id 1txjwQ-00029m-Qp
 for qemu-devel@nongnu.org; Thu, 27 Mar 2025 05:54:28 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1743069267; x=1774605267;
 h=from:to:cc:subject:date:message-id:references:
 in-reply-to:content-transfer-encoding:mime-version;
 bh=r4aAYh0vRGuHnHPGBmChC2aNDy9udo9kZHKxk/0j02M=;
 b=Y7eWHJdN6h0aeIn2ePVx8xUmOAxyDXZIRvVPeyH30aXhBnMTOtPotsNf
 Y0DBqD7W4dwxwTKCznsNrwCOqttTkm0Aj/46RWkr3YRodhH1vpTPLfBAY
 cS9cLRJM7F7bRq2JtnAV5dTBG9Hf5+Yr5bsAFhbsLcDDZ2Nlvdhfsreiy
 0u6YKKIfWdqVr+hD4ulaoBTFtjm4GErtFC1xK1OujDfvlkbP7gmkgkfvA
 USmlS+IjIYukXFazdh7JSAyljkrDoq/WrXdXxLxLAlY//9pCay4kZsOrX
 Dry6h+enQhjVZpfKgB2Px11H561hvTqpGHfa0hrvBiquEoibcyNFT7emR Q==;
X-CSE-ConnectionGUID: I8hhKg/oQBCBNPLd8vFSzg==
X-CSE-MsgGUID: bd/NA1kJReqWaMrhR2GTxw==
X-IronPort-AV: E=McAfee;i="6700,10204,11385"; a="44574690"
X-IronPort-AV: E=Sophos;i="6.14,280,1736841600"; d="scan'208";a="44574690"
Received: from orviesa008.jf.intel.com ([10.64.159.148])
 by fmvoesa108.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 27 Mar 2025 02:54:25 -0700
X-CSE-ConnectionGUID: X3jB4hmwRY2blJzR85fMtQ==
X-CSE-MsgGUID: vpsunBunQQ2fI+JDC4eB8g==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.14,280,1736841600"; d="scan'208";a="126017536"
Received: from orsmsx601.amr.corp.intel.com ([10.22.229.14])
 by orviesa008.jf.intel.com with ESMTP/TLS/AES256-GCM-SHA384;
 27 Mar 2025 02:54:24 -0700
Received: from ORSMSX901.amr.corp.intel.com (10.22.229.23) by
 ORSMSX601.amr.corp.intel.com (10.22.229.14) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.44; Thu, 27 Mar 2025 02:54:23 -0700
Received: from orsedg603.ED.cps.intel.com (10.7.248.4) by
 ORSMSX901.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.14 via Frontend Transport; Thu, 27 Mar 2025 02:54:23 -0700
Received: from NAM11-BN8-obe.outbound.protection.outlook.com (104.47.58.168)
 by edgegateway.intel.com (134.134.137.100) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.44; Thu, 27 Mar 2025 02:54:23 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=VddY9hPOEfNZF61Sd+CR+C/bGzdWPf1j57uUalS4N7PliSzqvqU0RqdnYZmQ7n4+zJ5lLX65bCzC1VOxHbwry8SGReiTcvQaf3xO+CABXUbZOaxV64FgkudaNf+ne60S3ltF6ILlRvbdsUpGqqjy6qFSN99UyCtKwY+DMHDtCgReB9oA/UD0O/Ls4ONG9GIPof0YjJqlpFBzsbOHoVyOCUDGqZqnqdXyC4a+vYI3r+lmPqA0gRTLlAefFnw5fcZKjIuLts63YZaIEprh/X538ieA2ONoBWEZaPoSk44UiDOyqwPCdCMVnKz3LGRDdEG95HzVIfU0RKCSvmGvIfT8yg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=r4aAYh0vRGuHnHPGBmChC2aNDy9udo9kZHKxk/0j02M=;
 b=OFWxrCUEAod4sD+AGYzMSmT6HRMXpw4MSIXEbtKbWycmaKygM/5u0qbhArM5w/Iq81PwTrf0PgL+MOYBWLrrbGV/du32NjzPWTYoL2a8XRSPiLxqIFegqMMaYl1XzEQFhj+AxUS/EGGZttH6T554VgYg0mTvhIUWf5K30ZmWpO+GQ6w+AiwFr7ExH/ABlBzyMpxdlCndD2WxKxPfldxXeuZII5bPyJrHaE/87OKFoR2I18JAphrw9m7A6IlDcgYNcFmMTLte8bNuV1LC5xaSEmg72QEWrTtHgQNBSAsqDeIS0SM+j8cPk65uPC3eEnr4YRhXBHRshrBy3WkOgi2uEA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Received: from SJ0PR11MB6744.namprd11.prod.outlook.com (2603:10b6:a03:47d::10)
 by PH7PR11MB8011.namprd11.prod.outlook.com (2603:10b6:510:24a::22)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8534.43; Thu, 27 Mar
 2025 09:54:07 +0000
Received: from SJ0PR11MB6744.namprd11.prod.outlook.com
 ([fe80::fe49:d628:48b1:6091]) by SJ0PR11MB6744.namprd11.prod.outlook.com
 ([fe80::fe49:d628:48b1:6091%6]) with mapi id 15.20.8534.043; Thu, 27 Mar 2025
 09:54:07 +0000
From: "Duan, Zhenzhong" <zhenzhong.duan@intel.com>
To: =?utf-8?B?Q8OpZHJpYyBMZSBHb2F0ZXI=?= <clg@redhat.com>,
 "qemu-devel@nongnu.org" <qemu-devel@nongnu.org>, Alex Williamson
 <alex.williamson@redhat.com>
CC: Avihai Horon <avihaih@nvidia.com>, Eric Auger <eric.auger@redhat.com>,
 John Levon <john.levon@nutanix.com>, Joao Martins <joao.m.martins@oracle.com>
Subject: RE: [PATCH for-10.1 v2 22/37] vfio: Move vfio_kvm_device_fd() into
 helpers.c
Thread-Topic: [PATCH for-10.1 v2 22/37] vfio: Move vfio_kvm_device_fd() into
 helpers.c
Thread-Index: AQHbniQn8dU1yuscAE2vVP8Bl1qNeLOGwALg
Date: Thu, 27 Mar 2025 09:54:07 +0000
Message-ID: <SJ0PR11MB6744E4A78ABE50686D120A0D92A12@SJ0PR11MB6744.namprd11.prod.outlook.com>
References: <20250326075122.1299361-1-clg@redhat.com>
 <20250326075122.1299361-23-clg@redhat.com>
In-Reply-To: <20250326075122.1299361-23-clg@redhat.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: SJ0PR11MB6744:EE_|PH7PR11MB8011:EE_
x-ms-office365-filtering-correlation-id: ea4e2f1b-534b-47cc-c5af-08dd6d1550f4
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
 ARA:13230040|1800799024|376014|366016|7053199007|38070700018; 
x-microsoft-antispam-message-info: =?utf-8?B?Q0xaK1JZaDg0UnZXTGVoUkl1MVpZTHl5a1o2SGZOU3lEcDNYT2ZjN2FCMzhi?=
 =?utf-8?B?N3h4VndmUC8xckFzWUhVa2JjbHFDOFFEM0xkVE9waFY3ZVVHN0JCOU9BT05E?=
 =?utf-8?B?dDBseW9pUWVLRDIybnRMczRYN0FZUXI3Z3RxN0lhQnVFN083dU1kL2cxeTdu?=
 =?utf-8?B?WjZjQ0RMMGtiR0h0WmtjdlBTMlYvdWJxbmxQMnJRMDh4aUVPaU9xOTFqKzA2?=
 =?utf-8?B?U1ZxTFN3R0Z1K24vR3RzQkRMTHpMY25XU0xWeFozK1k1ZGtMOXpjRzkrTjIv?=
 =?utf-8?B?QVJNZUlJU3E4QjFTVnl2bXFjKzRpVEFGRFVmcjZ0NGVrTCtwUDFUT3lZd0U2?=
 =?utf-8?B?TkNJUUk0MDQ4ZUJOTklNNWlpV1pveEFvdERLOFJWNStJd3RXOWFCRlNWdTVJ?=
 =?utf-8?B?aFoxekFsRVpPd0l6WEhSOUloWG1ieEdDMkpzWGJXVmJraVZNR2UrSFFHeWIx?=
 =?utf-8?B?UEpQQU91dnJXRXVWSmlnL2t5TkI4OEl0TUZFaXdGSEg2UE0xUjFoeDF1eE5s?=
 =?utf-8?B?L1YzMHd1eVFYSjF3bUxMZjFxdW80SFFsL3oycng1NHU1YXA5VWdRSURaOHJE?=
 =?utf-8?B?ZGhNMVMzd21MSUlpREZGanhjaFJnaG1ETm9JRjR4d2JIR3J4bXE2aGlpWHQ0?=
 =?utf-8?B?bTRSeldsY2E0QzNkSzJMU2VMVDNUQ284SkxwdWhic2JWQjkray9GbUwvUEtj?=
 =?utf-8?B?cDdqZWRNUHE1d3kxeGk4MXZUUCtTSURNaGU5QXpXdFIrQWhUU3dQS0FpMjl0?=
 =?utf-8?B?aUtXRjAxanpLYWN0ZWdQT1l1ZHZIU0JoNDdYbTBHc1AxOFBPRUl3Tnp1N0FZ?=
 =?utf-8?B?aHB5Qy8rYlJndEFIQmRUeUdKbkJva2JhMlZ4WXI1eld1Zkl4cm0zM01EdTJi?=
 =?utf-8?B?V2ZIdVczR3o3N09PU0ZjVjhhUHE4RkVpRzY5eWVPTy9XZmEwOGh0aGZTeSs4?=
 =?utf-8?B?RE40KzhnNkdONnYzeHRDOTI0M095RG9ldzRhRk8wWHM5V1pEVkljK2lpSFZo?=
 =?utf-8?B?Q3NZMWR0WVNTaUpWWnFwaDVQTlRIbU5ZNlVBQy9TazMyU3FMVmxkaml6OUNI?=
 =?utf-8?B?U29xcDBQSzZxeUFXYWhITENTcWt0dE9xMUh4eHZTNzlSU2JHaEkzMWRQZGFB?=
 =?utf-8?B?eW8zRFVCM0t4SlVNSjhuVWxuYkc3M1pPYUVqL3BNR1FhV0pZOW1xdEJDYXRx?=
 =?utf-8?B?dUcwMkIwOU51RjFDZE81NFFjSXJ2bVo5cG9xWUlTMjR4eWhMeDJ1SkFmRUxj?=
 =?utf-8?B?SzUrcmFlenhRVmRuVmhHY1dqdEhpYmFnL1ltekFXNmZhS0R4dHRyTWlBQlhU?=
 =?utf-8?B?YnJ6RmpUd2R3L1ZTQ2N0S3JPaHJ4ZVc2VHgwQkdSSTVRK2FuaEppT2dFNjBq?=
 =?utf-8?B?dklYNGhDcitIQVgyOUtVWk9UaWFVd0RLV0hOd1VRTkdOaFVqSFpMYXRxd21n?=
 =?utf-8?B?ckFvOEY0ZVRQTlBmb0lUNWt2c3BpdEp2b1VjR0NReHZtSTFLRnZCQTNnamJO?=
 =?utf-8?B?d1R2c015YmtKRklIVE1RbHlpT3I4QWpCUmFzQXZHN2ovQzExOC9wSEdrbGlq?=
 =?utf-8?B?eW1OMjJSRVdjWHBDVzZRU3ZjTjZ0RkJGcW1ISW0rS3hWaEdWKzUvRHEzbzNh?=
 =?utf-8?B?SG9GQm5RUVZPYjZDTWZaUUI3YzF5OFZWdEk4YUVTSlF1blR2UVdsRnVuWEpq?=
 =?utf-8?B?TjRYM2s5d1ZyUlpwNjZGTWtvcHg0d3lKTHVRbkZyOHl5a0QrN20rRmpCV2da?=
 =?utf-8?B?MUthQUN4aDFOUk9NMUhKbkc3dnFMUnRQOExmaVM0eWJ6cUk0NFlTSWVKTXBj?=
 =?utf-8?B?d2RvVjJ2dXNNd2N1S3dpWExRL3Q3NHpoUXpTQ2phMHEzQWZlNzBxQmtKaHpG?=
 =?utf-8?B?NytybGJXdHZISlVLbk1sYXdKV2YwTHM3LzRMdW1iNG96anZxcWVsL24zcTVh?=
 =?utf-8?Q?ftQkD51CU/d0XVmHA1iVeBTih3oD3llF?=
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:SJ0PR11MB6744.namprd11.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(1800799024)(376014)(366016)(7053199007)(38070700018); DIR:OUT;
 SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?UlliUVlybWJBaTZTS2ZPMEszR3kwZkxydkxyTzFHMFpQNm1kQ3Jhdldybzdu?=
 =?utf-8?B?ZUN2WmhnQlVKdVp0MGgxak5ocERFUG4rUnpjYmN3cVRjYzJ5SWVzSFpBL01G?=
 =?utf-8?B?ajNiZjFTWExkNWtjc3R0MDV6U2tWZFFnVzJTSUJhaXhhSnJzckZOOWk1Ymcz?=
 =?utf-8?B?aUdDbzRhMVB2MnlxZ0EwU3AwWXl5Q1lXVjVvcVdpVHVUQTdCZ3ZJWHFYQUhO?=
 =?utf-8?B?TXZBdW5sUGs4TXNlTnVvT1ByL2V4ZGlWVlZ4Mkdhdlp1dUk3TXRzR0tTR3Vx?=
 =?utf-8?B?b0JhWnIzdGF6ZzZqZk9yNTErZHlRVUdHUHRtNmtBcmk0RWs4UjgzWitFbGk1?=
 =?utf-8?B?R3hpL3pCNk5sK0NKVnlTTkJCdjVDZXJSUXV2ZDJ5c1o3MnA1NVgzRDhPNkRB?=
 =?utf-8?B?VS9hWVFGVDgzQllpZXhJc2hOMnhsWm5saWwwVElYUjY2SlpqMjlWT0ZDRmNv?=
 =?utf-8?B?RkU2QkRoNFM2UmdtaVBiQTdEN1gwYkYwL29hWkVzaTZnQW00TSttUmVVaXFE?=
 =?utf-8?B?azRZbDFDbzRlT1lSTHovTUZpL0lHY25xUnBuVGV1Tksvb1c4REZLZUgrV3RS?=
 =?utf-8?B?R0YyREpUTU53NkdUYlBmL0dSK01GRmtFS2t3SXhrdnFSNG5jVm5Nc1FpK2JE?=
 =?utf-8?B?enlOVlZzZlNBa2dzaXczNnc5NTVMejBBcUdMY09HV05qN05SSlNCZWxUdS92?=
 =?utf-8?B?ek5FV0RlWFV6RjhNTHRZdWZ3eDM5SVZ2WGFpcDd1QjJsV25mdUxHNXlYNFBG?=
 =?utf-8?B?K3pwejNlT0YreEo4bmZsNXR4blRCZUlWV3U2NnIxZU4zZEc3NXNrYWVSN1dr?=
 =?utf-8?B?TlN6aVRqaFFxb1cwZjV5aDh5ZlNqZEp5SlFCZ1VtNXBpYlhDekxkVllGNU54?=
 =?utf-8?B?YUhmNEtZckpzWkdDc3hSU3ovL2JQZjZ1T3NnTm9ETkdUUEcxTktMeUhHaWps?=
 =?utf-8?B?YWo0YktoTVRWYXBGcHk2Q285Yk8wc3FDL0ZYbkR1a2J2S3NIZG13YXRwTUxL?=
 =?utf-8?B?K2xPN1BhS2ZhR0pjQ3o3a3k0d2Z1M09TaHVGKzFLOHFmZWxSNno0Qm5PSkdB?=
 =?utf-8?B?V2g0bERoS1d4VlpLTEFzcnlJaHUzN3ZoTkFpY2wyQzJWcHFhcXk2S25QTVpM?=
 =?utf-8?B?V2dzbEJHNjEzVjgrZjBYR0JQdHFRcTVXVzl6UzJaYW16bVRXY1VNTnppV1Nn?=
 =?utf-8?B?N1lNSUtMd2puNkE3R3REMEkreDVkLzBKNzUwS3R5NGd5NnBJQ0VxTkplSjc0?=
 =?utf-8?B?dkxLMXB3cDltbFQ3WnB3WW1UU1dXZzVEYWs2WmgzMTQ2WTgrVGFSdmRFSWhr?=
 =?utf-8?B?NVliVk1qcWlnaTVwWXphNVRGMFlrNnpPTEJRaGFOMmlsQk1JQUxRSzZjdmYz?=
 =?utf-8?B?TlAxL2dyMUcwYnc4UVQyYnpSZ0lKOHN4UkR4eUFqKy9zQzhNbkc1V25xdUZ5?=
 =?utf-8?B?YUpjUDRiUlMyZ1BiRzJPbTBsYzdQR055OFlJK1R3QWRRVjFqVTlUZmlrdGE1?=
 =?utf-8?B?dW1SQ0RIU0FnclpGeHE3NmtmVmJ1RDBYbGxTSWRlU3pZT0krZGZCQXZrREkv?=
 =?utf-8?B?ZGh4THNOMm90SWtlNktPL3dSZXFZVU02NzMybU1iSk5EblFKMGEzU1ZTTXR3?=
 =?utf-8?B?b2RUYmU2b0pZeitScGYzd1NCcXpQWi9lKzB6MUhnbTFleEV0WTNNWDlqNU42?=
 =?utf-8?B?VGx1RWllLzU4YkNxWGp2OGY3ZWpoR3FUSHpBRE5heXBEY2Mrczl2bWIxekFI?=
 =?utf-8?B?VVdSSjVhWUJGaCtYc1FZSDBkMmFYcjYvWUkwcFR3NStUK21xL2NKbmNaZyt1?=
 =?utf-8?B?TWJwN2Jka0NWeTgrUlhxMlQ0SVNJZmZaa2wrNldxTGptV2Y5WXgyaXE4L3hk?=
 =?utf-8?B?Wmc2UmJ6b1FiSXoveDNpM3kyNlpaRUNiMTdScWxMN1U0bG5wVXRsUlBNcURz?=
 =?utf-8?B?VnJ2T0U5dnBFSTBDc1VHNk01azhhSkV4VnU5bWVpNnZZUHREeTZvUnUydlNw?=
 =?utf-8?B?eTJtaC9WS09NZjNIcTFlaXlKbGdtYm1tOW4yeXpXbDJGTjlCc3pvQThtZTVZ?=
 =?utf-8?B?RG9YM0w5N2tScXBCUFVzQ2tuR2gzMUF0YVIyMWVveXdsZks3NE1yUDJlZXdh?=
 =?utf-8?Q?kvcLpovq769muIGLTNs1I0X08?=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: SJ0PR11MB6744.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: ea4e2f1b-534b-47cc-c5af-08dd6d1550f4
X-MS-Exchange-CrossTenant-originalarrivaltime: 27 Mar 2025 09:54:07.5686 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: CRNMv+D/jE8+5wwZ/SWq+JtlxDm2yPoc98Ip/nNyb/l13uRDdQ4RVjfXo9ort51gNuazzljO0ZkrdWZW2B5G2TGoA/44Q7/ojdAOZaQoQ7g=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH7PR11MB8011
X-OriginatorOrg: intel.com
Received-SPF: pass client-ip=192.198.163.14;
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

DQoNCj4tLS0tLU9yaWdpbmFsIE1lc3NhZ2UtLS0tLQ0KPkZyb206IEPDqWRyaWMgTGUgR29hdGVy
IDxjbGdAcmVkaGF0LmNvbT4NCj5TdWJqZWN0OiBbUEFUQ0ggZm9yLTEwLjEgdjIgMjIvMzddIHZm
aW86IE1vdmUgdmZpb19rdm1fZGV2aWNlX2ZkKCkgaW50bw0KPmhlbHBlcnMuYw0KPg0KPlRoZSB2
ZmlvX2t2bV9kZXZpY2VfYWRkL2RlbF9mZCgpIHJvdXRpbmVzIG9wZW5pbmcgdGhlIFZGSU8gcHNl
dWRvDQo+ZGV2aWNlIGFyZSBkZWZpbmVkIGluICJoZWxwZXJzLmMiLiBNb3ZlICd2ZmlvX2t2bV9k
ZXZpY2VfZmQnDQo+ZGVmaW5pdGlvbiB0aGVyZSBhbmQgaXRzIGRlY2xhcmF0aW9uIGludG8gInZm
aW8taGVscGVycy5oIiB0byByZWR1Y2UNCj5leHBvc3VyZSBvZiBWRklPIGludGVybmFscyBpbiAi
aHcvdmZpby92ZmlvLWNvbW1vbi5oIi4NCj4NCj5SZXZpZXdlZC1ieTogSm9obiBMZXZvbiA8am9o
bi5sZXZvbkBudXRhbml4LmNvbT4NCj5MaW5rOiBodHRwczovL2xvcmUua2VybmVsLm9yZy9xZW11
LWRldmVsLzIwMjUwMzE4MDk1NDE1LjY3MDMxOS0yMi0NCj5jbGdAcmVkaGF0LmNvbQ0KPlNpZ25l
ZC1vZmYtYnk6IEPDqWRyaWMgTGUgR29hdGVyIDxjbGdAcmVkaGF0LmNvbT4NCg0KUmV2aWV3ZWQt
Ynk6IFpoZW56aG9uZyBEdWFuIDx6aGVuemhvbmcuZHVhbkBpbnRlbC5jb20+DQoNClRoYW5rcw0K
Wmhlbnpob25nDQo=

