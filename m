Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id AC6ECC3600B
	for <qemu-devel@archiver.kernel.org>; Thu, 27 Mar 2025 09:55:40 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1txjxS-0000Z7-IK; Thu, 27 Mar 2025 05:55:30 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <zhenzhong.duan@intel.com>)
 id 1txjxR-0000Yu-Ou
 for qemu-devel@nongnu.org; Thu, 27 Mar 2025 05:55:29 -0400
Received: from mgamail.intel.com ([192.198.163.13])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <zhenzhong.duan@intel.com>)
 id 1txjxP-0002PH-Tl
 for qemu-devel@nongnu.org; Thu, 27 Mar 2025 05:55:29 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1743069328; x=1774605328;
 h=from:to:cc:subject:date:message-id:references:
 in-reply-to:content-transfer-encoding:mime-version;
 bh=GH3pAkVQ0euQMuUxcXXbIlTuZVkhXrZwXaOOVdZK0IU=;
 b=lnYer/HC5Ulean0JZPCo/qL876hwnumLr6LcK2tQtNG4qAzepRUEEIzF
 1nhMkSS9di+kdE8NtJz3RiQ2KwCLhGFECjyc5Y2S1/sCWwuQFTZ6izaa5
 yxhkaWaUWKxeUdCC46G8O2OlqTuyw4BaLDFoz2vVhdYIqWcVjfQZb0OZA
 FWhBYJimwjGVnf/bwLrI+5atdiJGOB5xkbWxpJsX6dTAfwPfWVtQKgjb+
 h/qsw5Z+21EvP/zvY1NZHtwFHREEuZWygqzY6qvzYCRpMQyd8FKcnwbTQ
 raioHxfvZHXB5ekf2OKm4A3z1hAfjLF+5o3sHltNweg6fgLenSUYuVMFC A==;
X-CSE-ConnectionGUID: 38uh9rWRQrCvIRFNOK8UHg==
X-CSE-MsgGUID: xszakRP8THKZgTuot0o0nA==
X-IronPort-AV: E=McAfee;i="6700,10204,11385"; a="47127690"
X-IronPort-AV: E=Sophos;i="6.14,280,1736841600"; d="scan'208";a="47127690"
Received: from fmviesa002.fm.intel.com ([10.60.135.142])
 by fmvoesa107.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 27 Mar 2025 02:55:26 -0700
X-CSE-ConnectionGUID: DOCE2L2aSqmSm6LSXKhxqQ==
X-CSE-MsgGUID: LWZhnwqoS5mrogINLQPwoQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.14,280,1736841600"; d="scan'208";a="148284887"
Received: from orsmsx903.amr.corp.intel.com ([10.22.229.25])
 by fmviesa002.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 27 Mar 2025 02:55:26 -0700
Received: from ORSMSX901.amr.corp.intel.com (10.22.229.23) by
 ORSMSX903.amr.corp.intel.com (10.22.229.25) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.14; Thu, 27 Mar 2025 02:55:25 -0700
Received: from ORSEDG602.ED.cps.intel.com (10.7.248.7) by
 ORSMSX901.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.14 via Frontend Transport; Thu, 27 Mar 2025 02:55:25 -0700
Received: from NAM02-SN1-obe.outbound.protection.outlook.com (104.47.57.42) by
 edgegateway.intel.com (134.134.137.103) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.44; Thu, 27 Mar 2025 02:55:25 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=gI+QH6TEa4WlJiTHcDDhV8r4LzGpY5KTW4Fk2JQFeiRyW9fTnyGyUeabeSCuG2ax6Bup3yepGxaCgX/bklTfy7FGVmKG5la519RxITQ5L6LULlc+82tqUosYbQH8xUvhGZtRUNBez/gYI2WyR1VpnO6AZ+jnus1nW0o40KCE/9xJofTRm/Gk6mDOhxINgSIgUn/dxu7ykR6aSI++uIdB0k40FG2STs+6TUyuFfSH/3JYTIA5vC7XWFYnAruzIZJht1Dwvm1aiPeEidlp3I6chyjaXnkNcSbHAiaTjJkTsjLr/dsP6B/NhWbAf3OrM9SQx7M0AsXFYV4bE/LtdBy9fw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=GH3pAkVQ0euQMuUxcXXbIlTuZVkhXrZwXaOOVdZK0IU=;
 b=CX/A+SdgChveiam2P2O1uk445NrrmXGn3C5NaqeyY8+DhPDE9GjTANv+Jzr6nEypY2bHU9Uph514jaDbZ7IBxys590r3gsTfwa6b8I8iyCNrawjWxAOseS4a+KOC2ag6iPAnNr9M/LUMfoje5kFJfvN6XRgrtbLwgxuuDjkYRQIXQgIhp9FrcRDz29zVZbUTyfVRBYSIgvHvO/QiJRIgGDNf22+CPf54OUdIMAgChjo7PqUeNlQzTqBit6B5qrX8WngKe+RBvt+sHMh0NT8XU+drohAWi01OD0qG23zVd8TLBtFKr7YgRLrmTfFCV/REqygoNaB3C8TIOSVCFKDnww==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Received: from SJ0PR11MB6744.namprd11.prod.outlook.com (2603:10b6:a03:47d::10)
 by PH7PR11MB8011.namprd11.prod.outlook.com (2603:10b6:510:24a::22)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8534.43; Thu, 27 Mar
 2025 09:55:23 +0000
Received: from SJ0PR11MB6744.namprd11.prod.outlook.com
 ([fe80::fe49:d628:48b1:6091]) by SJ0PR11MB6744.namprd11.prod.outlook.com
 ([fe80::fe49:d628:48b1:6091%6]) with mapi id 15.20.8534.043; Thu, 27 Mar 2025
 09:55:23 +0000
From: "Duan, Zhenzhong" <zhenzhong.duan@intel.com>
To: =?utf-8?B?Q8OpZHJpYyBMZSBHb2F0ZXI=?= <clg@redhat.com>,
 "qemu-devel@nongnu.org" <qemu-devel@nongnu.org>, Alex Williamson
 <alex.williamson@redhat.com>
CC: Avihai Horon <avihaih@nvidia.com>, Eric Auger <eric.auger@redhat.com>,
 John Levon <john.levon@nutanix.com>, Joao Martins <joao.m.martins@oracle.com>
Subject: RE: [PATCH for-10.1 v2 20/37] vfio: Introduce a new file for
 VFIODevice definitions
Thread-Topic: [PATCH for-10.1 v2 20/37] vfio: Introduce a new file for
 VFIODevice definitions
Thread-Index: AQHbniQi3MRnkXL3ckKhDTPN+9BsLLOGwFxQ
Date: Thu, 27 Mar 2025 09:55:22 +0000
Message-ID: <SJ0PR11MB6744A876CE6DBC21E90CE72092A12@SJ0PR11MB6744.namprd11.prod.outlook.com>
References: <20250326075122.1299361-1-clg@redhat.com>
 <20250326075122.1299361-21-clg@redhat.com>
In-Reply-To: <20250326075122.1299361-21-clg@redhat.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: SJ0PR11MB6744:EE_|PH7PR11MB8011:EE_
x-ms-office365-filtering-correlation-id: 63a0d9f1-e2c7-4695-39f6-08dd6d157dd9
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0; ARA:13230040|1800799024|376014|366016|38070700018;
x-microsoft-antispam-message-info: =?utf-8?B?ODZLMjhTTXN2SC8wczZoV0U4cUFhRGU1eXRGUFF3UUJpa1BsN1ZEZnBpdWc5?=
 =?utf-8?B?WE9JL3ZoZndWWnFGcjQxRDBKTEZQL01tWitWeUoxN2w3b3BQTkFMRXBqMTdR?=
 =?utf-8?B?TU42T1dMTE9VSWFyVi9DQkRDcFRlaFNxb1hoSjVYT09OVXdnazNOY0dKVVlL?=
 =?utf-8?B?ZjIwTGFGYmgwSEgvYWRxOEtJc080ZjA1RDhWNkZCLzc2d1h5NDhUK3lJaDVK?=
 =?utf-8?B?L0lVR1lUVDgzYVc0a2hweEtSMzc4SVFhSm9sR0ZOOVAxK29vZlJCYXJXUndJ?=
 =?utf-8?B?NE5ybnUrNXFhVGUyTEwzQkhQOW1hdXVibEs2b3l1bHh2bXFMa3dWREY4ekFE?=
 =?utf-8?B?Z0t3ay9yd3ZKUjFXNmpNTWFxMm82TThXeTlxN1hyeURNZncxbktaWmdLSXdO?=
 =?utf-8?B?S3kwL2NUREFqY3pGKzhkaHJFWVVrSDNuTEYrU01TQmc1MWxCbG5UUll0VzM4?=
 =?utf-8?B?QVZXOWE0cG5wNzd0VTlHc3l2K25HM2ZFUzgxdUZHV2w4MnRmYmhwZVAyUjJ6?=
 =?utf-8?B?cGZmaTFWM0tiQUZObThBblY4QzJFRUE0Qit1RVhabnJnRTNaY1JPVklTZktD?=
 =?utf-8?B?cm96ajR3WG14K01SUlRoNFBFZUFCMnYwTVVkRDkwalptVURSMkxUcS9JS1dy?=
 =?utf-8?B?ZWtSWGIrRTBNK1NGRWpxR08vRmVkNFRWblp5U21FSGVqejRLRDIwVElqTTZK?=
 =?utf-8?B?VlFHTkx5N1Bib3ZycEZ0UHUrVmtCOC9JUysxYW03WVBSVU4zTkNOUEd6dTV5?=
 =?utf-8?B?SWhZWEdnWk9TUXVXczJ0U2N5em9ZNE11UWRyVVpuZm5NS2lhT202SXEwM2Jk?=
 =?utf-8?B?bWNPTCtDT2YyRXlhdGlYSDY3NVhydzNhak1yUTdPN0ZYby80R0FWdGJ0ZThz?=
 =?utf-8?B?Ym1ZSGNIdy93SkcrbEwwS2tIdGFpSTNYYjFZM0hZWEw2ME4yNjhDNFloM2Vv?=
 =?utf-8?B?bjZjQ0VDdTRMUkRxRFhvY3B3UGRtNHNIc25VVWd3Vi9wOXVvcGtPcldoWHBB?=
 =?utf-8?B?T21EdDZ6cjI1TTkrTjducjlDZERGQUtMc2NIUjF0a0N2cGdHQlNUZEVpMDVF?=
 =?utf-8?B?czR6N2VETVFIQTBLdVl0VDR1TS9qUjBYay9VVXpCY1JYUlBGQU5oUFlSOGYr?=
 =?utf-8?B?RXFJWWJwMFVobHo0UmtncTVBRGp1dXNFRUM4TVgwVk9VZTQ0SWg0Mjl3NWlL?=
 =?utf-8?B?Y2JETy9RVmVIQ3ViMkZaMXpiK1dCbVdCMkw0dlpzUlpyZndhRWlUQmlteXVW?=
 =?utf-8?B?bG5ac1M2blZCMGJ3ckh4RFVHeS9UNVk1NVFHU3hINm9CODA5RmU1MGJUVDNv?=
 =?utf-8?B?ZW5nSTZrNHRoNU9ZK2pBK0FjOUVIeUZPSDZIMXRlTUMzdENnOUtNbTNqdEhJ?=
 =?utf-8?B?RTRYL3QzM3dneURucnN1VVdpRHpiUW41UVlRczFSSGxURldiTGppMzBzTVhs?=
 =?utf-8?B?ZUM1VUhNcHN3NjVocmV3NnFMR3p6M0lxeEJMU1hxdFg2T3cwTFRSOGNYQWJZ?=
 =?utf-8?B?ejU4MkJIUnZuaEFRUVM1bjdGT3JVU2V2ZmxtQVBYSjNCTTVDL1BMNjkxLzI1?=
 =?utf-8?B?WUlseEdKWEpYdmw4SXpPaEJrbjF1WGZpQmlQN3FiMjN6Q3lLQ3BhbzdvUnVO?=
 =?utf-8?B?YzYvcFNzWFhVb3cyU2xkYkVCOXJLNkFYSUhBOTlqYkpUYUIyZUo5SEkzTjRW?=
 =?utf-8?B?YStuQjduRndPcTBWYm1uYllDMUN5OXovbC9UbVVxN3FxaEYzcEYzbHRTbDVC?=
 =?utf-8?B?a0k3alc1dXZzTm1HaWI1QU0rbzBSN01yZDFlSTFkYW1zYkZRUWpkazVmMk1q?=
 =?utf-8?B?dm1FdUxsWE9pUGFyQ3JUNUVOTmR3bEx5citoZTREZWRZTGgwNU5LMUFvL25K?=
 =?utf-8?B?SzRReWhrSkNvRUpUd1hvME1ZTTBVOXNGM3Y0c3FycXZvMUVkc3p4Q296Qm1o?=
 =?utf-8?Q?5jwC1mzVofjK46XJZFleDlOY+WSQuxJe?=
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:SJ0PR11MB6744.namprd11.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(1800799024)(376014)(366016)(38070700018); DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?ZUJJVnUrMk5Qbk5oZXFzYVByc2Rrc2tZN0liMHhaSjFlSi9KazRsTUpjdU96?=
 =?utf-8?B?UTlhcXRDSmw5Qm83M29GakROS0NwT2pLZjliWkhpYnJYd2EvVEJsVkVvRlRI?=
 =?utf-8?B?bE00YlVwNmplbmdrazdaWTAyRnZPSndkQzNVMkRrRnhSL2tzSW9LV1RMT0hM?=
 =?utf-8?B?STV0MFFmV0thRWdEMFUzS1RJNjRGVlFRZ2QrRThCZ0hBVWkvcTQrRFRBaHVK?=
 =?utf-8?B?RHdpOXJrM1VxdWF2Mkp1WnFMbGVTaEg5WEIwaHRIN0d4VVZYYmFSUkdxWEVZ?=
 =?utf-8?B?K21JdndmTVd4djFNWUhhRWs3L3dDNXh3Q3NqbDVsemtPSHUvUy91S1o1Z0Yv?=
 =?utf-8?B?VnJwYTF1VW0xNnFiU28xV1B3UmxWbFhsbXFCVTlNTGFpQU4rQ0VoSC9TYlM0?=
 =?utf-8?B?K3J1RFlvcUxOWk1sNjNmM2dsdmk2SnZZWDBrTmVJT01hR3lyNzY3dTNzV3RZ?=
 =?utf-8?B?WThYNGlTczBlV1psVnZBZXN6ZW1PaGVodXRSUVVYcG1ZL0ZCc0o1dGFCR3ly?=
 =?utf-8?B?NXJBR2RNbzR1WEJ5WWEwUVFTcUFaSzlrajFvSW9QSW0zNWV0dEhwTWIrTmlX?=
 =?utf-8?B?WkJlUnZVaFZCK0x1cGwwRWlhL0RDQWFnWk15Y3A1cEIyNTlsUjJtbi9jZUhO?=
 =?utf-8?B?Mmt0OVA0SEFwTVJpUGRsUW5DWlRRNVczVTJZM1lGWm5Ga00vUkZLeHp3ZkpS?=
 =?utf-8?B?MGFCRDZiSUdYSjk4ZG5mZ2tiR2M5OEs4OVNrYVI0MmJzbERhL1RGVjhEVUU3?=
 =?utf-8?B?dDlRNmRNZDU3bW5JK1RUT1ZLaTZHTlovS28vcnMxeTByY1VneXFqNXROMmxq?=
 =?utf-8?B?cG55OEVnaFRQRlRnYmIvTStMTlMvY2UwQXNBZ2hZV1U2bmYyaEN1aXNTK3Fo?=
 =?utf-8?B?ejdpR0IvLzBxLzkxUFBtaUF3YmRSV0ZyOW40YTJ1bk11VkNINFVNdDBITWJn?=
 =?utf-8?B?Y1hPenRyUkIraFY0STFPdWwyQUROTE9DTVZvZTNhMlRxS1J0OUk3c2NhOVEy?=
 =?utf-8?B?WWFGZGRpaEZxM1VlS0tkVkNCU3FqbE1NZXBxWThXVmJUb1hFamREUnJYL0lT?=
 =?utf-8?B?L2t4Mml4TU9yTCtzbkpkTjAvZ0NDQVIwVGkrcWt4NzNaYzNjVC9vQmxIZzdY?=
 =?utf-8?B?NEkzL0E0ZVo4Ykpxc3NqaFluSU03aVYvMFgrdEgxaHhQcFdvSys4VGpYRnI2?=
 =?utf-8?B?MnYvdHFnTWRkYllzY3lnVmZqUG41eGd3SHdJQ3FJcW9EeENZb0dJeHA4YzZ4?=
 =?utf-8?B?TFlreGJTNXI2bHNORVUvZzMrQXhUSmN2L2ExbCtBNGRwcm1FUGdRb0wzVXY0?=
 =?utf-8?B?ek1TbitZcHQ0Z1V3Q3cxOG9Td2JuK2E2NXpaT2d2bGJLVlZrZ2IwQmZvOHZk?=
 =?utf-8?B?OWpCNk1QTXVpQUR3VUFaZ0oxZmFQbm5rejdkb3VkeW5WOVJzVHFYemErajRz?=
 =?utf-8?B?blBJZ0JIWHp2cS9GSGx0bUF5T3hTMG83clBpZ3NDMU1wVlRsU0luQ09yZlpE?=
 =?utf-8?B?bzBZNkVZa0V4ejZTNWlweTdTejV4aTB6Y2dlTS9xSHozamM0N0JuMXN0Ym5k?=
 =?utf-8?B?cG9rU1BhcVp1WUZRanVzT1lsdDY0K05nV2V6ZGJzeHRqVnowNVZtNjdMdW11?=
 =?utf-8?B?bnBqREljdWZubTJZYWNQUHYzZWVwZXhIbEpBTjFkeGNSbVE3VThRTzRqZUpD?=
 =?utf-8?B?dFNJMm1vcUk5ZHQxOTRqTm9hTytKWnk1R0RhTTlQZ3FybGFXQ3JjUWYzRzdr?=
 =?utf-8?B?RnZmYWhSYkdUSUlXVXRpNDYzMUF4ZXhoc2FZYWM0dzJGeUQ4QWpPMXpFRVp1?=
 =?utf-8?B?ay9YYWNoeXVsYmhQOHkyc3BvVjlsd2dpSUhpNTRBNEEwVGZ5d1hjRmE2b0pM?=
 =?utf-8?B?SlRlZ3U4alFxbWJMM3JmRkoxRW41NCsrbFZxek1pWmZyNjNaUGlGcGhTMlM2?=
 =?utf-8?B?R3k2MmhIdHNyVWpaNHhFNnlDZW5JdkpOdERub1RTZ014VThpKy9EZytNaVp1?=
 =?utf-8?B?aFlrOXZ2MTlEWnkrTC9HdVBTWEttYU50QklCTUlaOHo2R01QQjRyS3ozUDJj?=
 =?utf-8?B?SnYwTWdlWGdSNEFmWE8rQ2J1ZmhUNHh1U2Y2SzRCN2ovUERBbUFSRXphZVVW?=
 =?utf-8?Q?7QoHE1xRWO4KwplXa438mdPeP?=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: SJ0PR11MB6744.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 63a0d9f1-e2c7-4695-39f6-08dd6d157dd9
X-MS-Exchange-CrossTenant-originalarrivaltime: 27 Mar 2025 09:55:22.9265 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: UdM46wcgfXwINiZvdEcQB0BXAOx1cRsPa8CRpmkebhb/BWLeyA0zF3JXKVuyydPU5UPvBOzxuNUm+aw8sMFYJPt/f2PtYP6gvZeZlJ1orX0=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH7PR11MB8011
X-OriginatorOrg: intel.com
Received-SPF: pass client-ip=192.198.163.13;
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
IDxjbGdAcmVkaGF0LmNvbT4NCj5TdWJqZWN0OiBbUEFUQ0ggZm9yLTEwLjEgdjIgMjAvMzddIHZm
aW86IEludHJvZHVjZSBhIG5ldyBmaWxlIGZvciBWRklPRGV2aWNlDQo+ZGVmaW5pdGlvbnMNCj4N
Cj5Nb3ZlIGFsbCBWRklPRGV2aWNlIHJlbGF0ZWQgcm91dGluZXMgb2YgImhlbHBlcnMuYyIgaW50
byBhIG5ldyAiZGV2aWNlLmMiDQo+ZmlsZS4NCj4NCj5TaWduZWQtb2ZmLWJ5OiBDw6lkcmljIExl
IEdvYXRlciA8Y2xnQHJlZGhhdC5jb20+DQoNClJldmlld2VkLWJ5OiBaaGVuemhvbmcgRHVhbiA8
emhlbnpob25nLmR1YW5AaW50ZWwuY29tPg0KDQpUaGFua3MNClpoZW56aG9uZw0K

