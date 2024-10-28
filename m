Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id BABA8D13590
	for <qemu-devel@archiver.kernel.org>; Mon, 28 Oct 2024 02:22:58 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1t5FOY-0007vC-8a; Sun, 27 Oct 2024 22:22:14 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <zhenzhong.duan@intel.com>)
 id 1t5FOV-0007uq-OB
 for qemu-devel@nongnu.org; Sun, 27 Oct 2024 22:22:12 -0400
Received: from mgamail.intel.com ([192.198.163.8])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <zhenzhong.duan@intel.com>)
 id 1t5FOT-00017D-5E
 for qemu-devel@nongnu.org; Sun, 27 Oct 2024 22:22:11 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1730082129; x=1761618129;
 h=from:to:cc:subject:date:message-id:references:
 in-reply-to:content-transfer-encoding:mime-version;
 bh=EZ0dBswq8gMaChYEKhH9bX686v4fbehe0XfUkOhkAAA=;
 b=fCBugXn23+438vPdodjNIjhMZuZFIW60iJl/S4ApqLKc4ibcrDkwLfWR
 YYolXyfdOUdLpqCHkeVQ9036xuDhwfUxlog6uEMLho5qy/PhwZSTxy8hq
 rzHg1JqtZlWUO3yC4fNr8lGymh+NtCu2u8gFtqQoHh8IWfPK49R5Kk3R+
 eYTX/gfK8jnhzEsL9Yaw3WMKqeNbekHD3RV1g19TE0oA1IJKVgqQfEe8e
 KzompvsDReVgIr002fCR/4RObnaqHoC4Y3Lxs1TI3yi45jMchl1vDKoe2
 ac8xmdnq0eCJLgjjp5ZVi5uW/YgWn97zcpfHnmI+qiNG7z6s8j7pVKu3l A==;
X-CSE-ConnectionGUID: vdBUKac2RQe4lTwZt5+GPg==
X-CSE-MsgGUID: EQulMxQUT+K1lLsJwa/xSQ==
X-IronPort-AV: E=McAfee;i="6700,10204,11238"; a="47154841"
X-IronPort-AV: E=Sophos;i="6.11,238,1725346800"; d="scan'208";a="47154841"
Received: from fmviesa002.fm.intel.com ([10.60.135.142])
 by fmvoesa102.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 27 Oct 2024 19:22:05 -0700
X-CSE-ConnectionGUID: MrbxVL3tRqipqvgdN8vOQw==
X-CSE-MsgGUID: 9eQQafroTuOFCYwf08XAQw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.11,238,1725346800"; d="scan'208";a="104796371"
Received: from orsmsx602.amr.corp.intel.com ([10.22.229.15])
 by fmviesa002.fm.intel.com with ESMTP/TLS/AES256-GCM-SHA384;
 27 Oct 2024 19:22:04 -0700
Received: from orsmsx601.amr.corp.intel.com (10.22.229.14) by
 ORSMSX602.amr.corp.intel.com (10.22.229.15) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.39; Sun, 27 Oct 2024 19:22:04 -0700
Received: from orsedg603.ED.cps.intel.com (10.7.248.4) by
 orsmsx601.amr.corp.intel.com (10.22.229.14) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.39 via Frontend Transport; Sun, 27 Oct 2024 19:22:04 -0700
Received: from NAM02-SN1-obe.outbound.protection.outlook.com (104.47.57.49) by
 edgegateway.intel.com (134.134.137.100) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.39; Sun, 27 Oct 2024 19:22:03 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=pxI3rStuBiWzPfyB/PN3JudLH3Ab8zL20JX5KtlViYVd+7AmIu3vQP+b+O3k2/4hEQT2yVUsu2eLe5AgFg5cOufDk9Pkq6Ix25gV84TCawdWOElYTcdBAWpUAobE7Af9abqgPIKBgL/RK3FcCSOeXPoZOeAv0whBq2rqpO+F/nTzLByLhOhjHGy0VOdYGQ32lcV+6d3orf3kJqyYeN3qrC58je5Dk4mndX9nsOuHGbivAwMl7yGsLlpIY6eyCbH9+N+QeGeSWfplQY008+g6dY0n8GmsWTiLDVeAZAV3/c9n/b8HqU2AujIIy5wIr48X/Ym9lvZAVUKdAgZ18DdhoQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=EZ0dBswq8gMaChYEKhH9bX686v4fbehe0XfUkOhkAAA=;
 b=Z9D6VejirJ0n1cYRD8OdnYQoOPa8H4eWqjvFFX/bwHV1m0lhcTPM5X46RkIizFFTwBma5gcPb5CYtQy2QkkbgI2Yr0hbG54tCJ7hXR0L/Cn73E3Sn4j6x3aVwgYHS9zbagfVuNGHjXLm6WSffMKAdbdYjegR+NUdLvYKsGSw629aSD5JiSfeefQb7Dwuhl28UMerwk1EQdMH94CMi1CUhG36wMAyeqworHcaXlYGopsqNFcscFPRxT2tr0eO5Q8zyp98zjjh5He9Vgs/K3zkNQLh0FyKB44FDYiG4AEEt5mGYv3CgLwHR2mGs9XFdAtT8Gh5G7i2nOpKcY07BNIQdw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Received: from SJ0PR11MB6744.namprd11.prod.outlook.com (2603:10b6:a03:47d::10)
 by SA2PR11MB4891.namprd11.prod.outlook.com (2603:10b6:806:11e::18)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8093.24; Mon, 28 Oct
 2024 02:22:01 +0000
Received: from SJ0PR11MB6744.namprd11.prod.outlook.com
 ([fe80::fe49:d628:48b1:6091]) by SJ0PR11MB6744.namprd11.prod.outlook.com
 ([fe80::fe49:d628:48b1:6091%5]) with mapi id 15.20.8093.018; Mon, 28 Oct 2024
 02:22:01 +0000
From: "Duan, Zhenzhong" <zhenzhong.duan@intel.com>
To: "Liu, Yi L" <yi.l.liu@intel.com>, "qemu-devel@nongnu.org"
 <qemu-devel@nongnu.org>
CC: "Peng, Chao P" <chao.p.peng@intel.com>, Jason Wang <jasowang@redhat.com>, 
 "Michael S. Tsirkin" <mst@redhat.com>,
 =?utf-8?B?Q2zDqW1lbnQgTWF0aGlldS0tRHJpZg==?=
 <clement.mathieu--drif@eviden.com>, Paolo Bonzini <pbonzini@redhat.com>,
 Richard Henderson <richard.henderson@linaro.org>, Eduardo Habkost
 <eduardo@habkost.net>, Marcel Apfelbaum <marcel.apfelbaum@gmail.com>
Subject: RE: [PATCH v4] intel_iommu: Introduce property "stale-tm" to control
 Transient Mapping (TM) field
Thread-Topic: [PATCH v4] intel_iommu: Introduce property "stale-tm" to control
 Transient Mapping (TM) field
Thread-Index: AQHbJSHFlAMYjcJpo0Gg1Y30l7qfGbKXPG6AgAQ4+zA=
Date: Mon, 28 Oct 2024 02:22:01 +0000
Message-ID: <SJ0PR11MB6744B7976931E6BC08217AC5924A2@SJ0PR11MB6744.namprd11.prod.outlook.com>
References: <20241023075753.580534-1-zhenzhong.duan@intel.com>
 <edf51f3c-1fce-4869-935e-884790f1d66e@intel.com>
In-Reply-To: <edf51f3c-1fce-4869-935e-884790f1d66e@intel.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: SJ0PR11MB6744:EE_|SA2PR11MB4891:EE_
x-ms-office365-filtering-correlation-id: b42f7be9-a668-4793-a781-08dcf6f74e62
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0; ARA:13230040|1800799024|376014|366016|38070700018;
x-microsoft-antispam-message-info: =?utf-8?B?Y2VRazJjZzI4eGVlSnJrSjRROHg0cTV0czVZbGdKTjc4akNOaXgvWjIydmZY?=
 =?utf-8?B?cDRYQWhCeXZGZzhRVWNaVmVIVUI2S2loa2VNektCOW9pOFdDOVFjN1JVeTR3?=
 =?utf-8?B?OXJXQVFXUmR6cWlXSzJtTjJYZ3lCRnY5elFmZTJpbmI0UnhCRmFFYmZiS2tQ?=
 =?utf-8?B?TFI3aTUwc002VGFGa0FoNDAvc25nUjJteWR4d1p4Vi9IcGxHamlGNkZTcUlG?=
 =?utf-8?B?dlVXRmUyYWxpVjlSSFdod3hmWkZqRlZZeldnVm9rK08wT0RwVzdXK1VuSWg2?=
 =?utf-8?B?cFIzZEc0TERaMEdsL2ZFbjE1TlRZbTAxUXpsbjRQamgrT0h1ZmtCSlQveVpx?=
 =?utf-8?B?TGZLTFpCcUlyTmlsVjFYckN5UnRpTDJrbWMwMDBiZTRhdW5EcGs4ODRqSENG?=
 =?utf-8?B?T29LM1lyN2xJdmVPdVd5NmFVOTJldEp2b3FJZVJuOE9mR3E3VEhCNm1OT09Z?=
 =?utf-8?B?SFg0emM3UzhnVTFwM051UkVLTytsUWRUVnVtSFFJdktVMEsvK25pS2tvVVFD?=
 =?utf-8?B?NUlCLzE1bjNnY21uZDNMYm9XaVJMeEdVbkkxV0NEQ0lQNHpVYkJHZ0trZm5I?=
 =?utf-8?B?QzFRbU5JdVBReVlNMUt3OWJXMnNvUHE5NGhDcS8zaWs1OE9rSkwrejdUVVFS?=
 =?utf-8?B?cVFOcEVDQ0UvUjlBTUJwZU9QZXhQV3diTU1oRGx6Wmhsb2EzRHFhc29yWnh3?=
 =?utf-8?B?UWc5NjNEaHp3bWhOYTMvUTVtZE5ZMlV6L1ByRExUaGRLaERxMjlxY3RqNDdv?=
 =?utf-8?B?ajJ4U0h0cWtFQ3NSRlJOaGNMVVdwUDFXMHdYWU5nNER0NWVCc2M0NjhNeVlT?=
 =?utf-8?B?WGFSajREQnBGdTlubjQ3eVdoTkQxR0JkZ2xBdGJhWGkxMkZpdmJ2RDAxbUhu?=
 =?utf-8?B?V21qNnlUQVh6OVoySzNkbm1sQWFrSFlSc1hCTGNMN0dORmh0UTY5QWNsa0ov?=
 =?utf-8?B?OWQzbURaKzdVeWViZmRucDEvSFNBOEN6a3lnbS9wcjdVejhoRVp6ZVU5amRD?=
 =?utf-8?B?NzloU1pjZ05tbExDakUzTVBKUTdOTEFVcW14WFc5VWh5MzFodXhrTUM1aE9Y?=
 =?utf-8?B?RVl1OENiZ0lmZk14S0h1UDBQSlYzZ3A2RXViZFpmRjdra1IvZzFsQ1VXakNu?=
 =?utf-8?B?ME9jREZIYVdJa3UwQUkwM2xldTJubGRlUVI5WWxvNmtzNXRoUjlFMmV4a0Fx?=
 =?utf-8?B?YjF1V3NXdE9aVURVVWxYVEF6RkRXZnhjaFNNcXNRRExYK282L0lTeWUyZ0J3?=
 =?utf-8?B?eDlDZDJmSkY4eXNFRUl1NmN4TW5XaVNEMm1RblJ2VlVQMzU2bG5ubUt4Wjg3?=
 =?utf-8?B?V0RORzh3YmxHZ0hCcXZ5eXVIWDVaMmNrYnhKRGc0NE5FSjBGV3F6NkdaVmVR?=
 =?utf-8?B?bG5kVFVvcHM3V3h5ejJ5SG8rNSs3V2tuN1IycFRBTVBZaUk0NzNrR3N6V0Ny?=
 =?utf-8?B?Wi9YdXlkYm5sVjNTUW9WSlNhRjM5MnROS2QwVytNWXR2QTYvQ29xdlFJL2Vu?=
 =?utf-8?B?K245RlQ2eS9YUVpxZ0hUOUZrVzJMdHkwSzJRclpSSkNMU3k0UWVKamNkSjlT?=
 =?utf-8?B?eGZLQjdFK1BtQWVvTXU4YWUvOFhhZ2NreG1TYS93a3FBUitpOWFSOXlzOFV3?=
 =?utf-8?B?R0RXRmlXYzdRWXVEbFRkNDZ1RTlKSy82OXZndkZOalllTEd2Q0FqcUtXcVAr?=
 =?utf-8?B?V29jUGowbk1SczhCenpjNGVQOWcrSGwrMTN1ZlZRcEV2NEQvRFNNV250VWdh?=
 =?utf-8?B?SGEzZ0ZJSkQ3NjlCQWs1b21VZmhYSzRHRnh6eXJRZjc2ak5BU21PUXZIT2xl?=
 =?utf-8?Q?jvhrw1LSN8/sGTO/z8fm7QHdy8y2G10kjquyA=3D?=
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:SJ0PR11MB6744.namprd11.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(1800799024)(376014)(366016)(38070700018); DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?V1hpYVZvd1NkOVFvNXREVTZFRXdDM1QvcGt6UnhObStrR2lzRFgyV2FZQ2Fx?=
 =?utf-8?B?ODJqdngwMmkxWUF3NG9SWE1mSUx0OWNOTVpJOUlIa2ljaHovRnBpcndOejhn?=
 =?utf-8?B?dmN2cU9sRDQrUEIxc2dEVnhsK3Jjd0dmd3F0OWd5VTlKWlE2bWI1UWNxYzdP?=
 =?utf-8?B?cVRQZDBrWmh1QTZtcEdnUDJXenY0bElDWDNXU3k1bURhRDFQVHVyNzQ0QjA0?=
 =?utf-8?B?aVhyT1NQUFJZbUw0Y0JPeUZRWjRlWmlSRm5zSWx5OUdOWm10VWRzSnY3VHZ1?=
 =?utf-8?B?ZnI2SSt6VkRyZjFRRDY0T0ErbmplZTlJcjdwYzdPTWJSMmlPT0NmRUxGUzBv?=
 =?utf-8?B?SEZYVUV1eGdGaWdwWFd2WHVMT0owM0g0TlJmKzBMeHpWOUJnOWpYaG95TGVK?=
 =?utf-8?B?ZW9iOFZxQnpvRkxKRHhjYmVKSVVVSUNOa0hBUDZRMVJuanF0WnJFUGc3TGlz?=
 =?utf-8?B?ZlJRVzBiclJzcDdxRUgvZVZvVGtJVzFjM29SR3NVRzFpRjZQQWRaWXJPUmFj?=
 =?utf-8?B?TTI0VXExak52a3R0SFpxTnltQk1ia0R3alNyeUxIZERKQThLNkNJZHNvVm9U?=
 =?utf-8?B?SmdjM251UjdrUEpLRTU3ZGRtdmdxQ0FLWDlGSXFYSzV4OTcvV05iWlQ2cEF3?=
 =?utf-8?B?TjFqQzNJc1k4TzB1REhDTEZaeTZhbmpBUlk0UEQ3MTdYUS9tVUhUZENsV2d0?=
 =?utf-8?B?SW90NUpnUVN6czZOSFJyaHZjV3ZDU3VQc0tBSUpDNDFtM1lXaFlicWgyU1Jy?=
 =?utf-8?B?bEZrRDBSVHJ6V3dKakdDQytPZGRWVS9CQ0x2R2l0dzRRV2tQWFBSbThkeUpj?=
 =?utf-8?B?Q00zTXhXc2RxSStpcC8xaGVaWjJOaVV3RDMyMjhkMDFLcUZZVlIyNG9HL3Ix?=
 =?utf-8?B?MThQeEwwR1p3K2NjaXdCS1hyRzltcDNncUxnY1ppdFpicGUrdlFMVXQvRlRt?=
 =?utf-8?B?bVZPWUdncUowSzluTlhwbVA0RElYNVUwUHhrRS9URGZrdUNNaHUzd1psOXJK?=
 =?utf-8?B?YVFBNlJiUENWam1PY0RMTFQzd09DTnhxanRoVTZ6MEJqdkJRQ2pKckJ3Z3Q5?=
 =?utf-8?B?R201WHM5ZUUvUnEyV3ZrdzFQUWE0RFh1TGdCYVprUmsrVUl6ME9GMnNKUUQz?=
 =?utf-8?B?QjdJSTVBcWk3L2U3b0xmU2J2b1pXQWZtNnhNMWN0SkdoNjJyYTZPNHl2S0o3?=
 =?utf-8?B?R21uZU1TWGt6eWFHZEFidTEwb3FEZDhHRDBGdmhJQTJvVzZRMDVRN2FuSVNy?=
 =?utf-8?B?aTJaWmE4NkR5RUNLazFjMUdaYkdXQVhTQWtKaXZjZkpZelBreVo2QmJTN3c3?=
 =?utf-8?B?TEhCRzEzM1psVnlCSjdkZjdOeG1NcG1Wak1jQ3ZlSjJRdHhmOFhaNGo5T29l?=
 =?utf-8?B?SXFqWU9DUGlMRnU3Zy9aeWRmdy9pbERRY2luVkd4SHZwODB4MkpnL1FlOTJH?=
 =?utf-8?B?M2pYc2JrTkxrN3pSODdiWXhrazNGLzg2K1Fud0ZhYTdtbnZQeThKRFh4c1pD?=
 =?utf-8?B?Q3dEREhuVUh6V1I2N2I2WlQxc1R1dmlhMzQwMlJVU1MxN3BNeno4M2tja2Yw?=
 =?utf-8?B?ZGZ0Rm1SUEtXWWtGSnpyYlNlekkzY2pjYkRvSEZmUTdnWGxyc0pGRFhGUFlI?=
 =?utf-8?B?eXVubzJCMkdwSWt5R3Y4cVNIK3QyVC9IeWhKT3NYbStEWmQyZzRrdHVGUEpX?=
 =?utf-8?B?WnRHVjRSZytPK01OV3NwNVpjZ0kyQzc3OHIwV2k0R3FjMVBjOUthR1NBazli?=
 =?utf-8?B?WVZkZXlZWWdpVXdQWTZENnFNQktuNG1mU29hcDVCdU1TbGxUcUpRb3VhOWtS?=
 =?utf-8?B?cUcvaGxlVERkUThPbUFuYVpiNHhXSm9qN3VuYkJtOGFVbGxHTDZwQ2N0bU1n?=
 =?utf-8?B?aHJUUWhFeUVNc2dKcEh3OHlBZVZwSjBKaFdydHE4cUxBR2I1WEh6Sm5SUW9V?=
 =?utf-8?B?ek42S3Axemp6RndLVzVQVGxnOWw4MVdPVUM5MFVmT0hxZGl2cFFwZEhlSkV3?=
 =?utf-8?B?aW0vTTdaM2ZTSmxPWjhFVWRhQlZOU1YrbHMvUjB0dm1EZ0hyc2Fjc0hSdFBR?=
 =?utf-8?B?bHU3dGkvWVZNNkxUU0l4QjFJTGlsdTd3ejArSWtFdDVsdERTZE9sUmpzOU53?=
 =?utf-8?Q?3rsSproH+qm7EoPHS+HXOUBD1?=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: SJ0PR11MB6744.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: b42f7be9-a668-4793-a781-08dcf6f74e62
X-MS-Exchange-CrossTenant-originalarrivaltime: 28 Oct 2024 02:22:01.2166 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: yzgmFMSbS0Ctnakr/Vp4/sxxTMEdiREgTRLY2yF41fRD+9MtPX08CwIJV17TuPSb5yzmCjCV4XjtO0JXE8Z1aPUzN35+r5zaeXgEZZn4I84=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA2PR11MB4891
X-OriginatorOrg: intel.com
Received-SPF: pass client-ip=192.198.163.8;
 envelope-from=zhenzhong.duan@intel.com; helo=mgamail.intel.com
X-Spam_score_int: -46
X-Spam_score: -4.7
X-Spam_bar: ----
X-Spam_report: (-4.7 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.287,
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

DQoNCj4tLS0tLU9yaWdpbmFsIE1lc3NhZ2UtLS0tLQ0KPkZyb206IExpdSwgWWkgTCA8eWkubC5s
aXVAaW50ZWwuY29tPg0KPlNlbnQ6IEZyaWRheSwgT2N0b2JlciAyNSwgMjAyNCA1OjUxIFBNDQo+
U3ViamVjdDogUmU6IFtQQVRDSCB2NF0gaW50ZWxfaW9tbXU6IEludHJvZHVjZSBwcm9wZXJ0eSAi
c3RhbGUtdG0iIHRvIGNvbnRyb2wNCj5UcmFuc2llbnQgTWFwcGluZyAoVE0pIGZpZWxkDQo+DQo+
T24gMjAyNC8xMC8yMyAxNTo1NywgWmhlbnpob25nIER1YW4gd3JvdGU6DQo+PiBWVC1kIHNwZWMg
cmVtb3ZlZCBUcmFuc2llbnQgTWFwcGluZyAoVE0pIGZpZWxkIGZyb20gc2Vjb25kLWxldmVsIHBh
Z2UtdGFibGVzDQo+PiBhbmQgdHJlYXQgdGhlIGZpZWxkIGFzIFJlc2VydmVkKDApIHNpbmNlIHJl
dmlzaW9uIDMuMi4NCj4+DQo+PiBDaGFuZ2luZyB0aGUgZmllbGQgYXMgcmVzZXJ2ZWQoMCkgd2ls
bCBicmVhayBiYWNrd2FyZCBjb21wYXRpYmlsaXR5LCBzbw0KPj4gaW50cm9kdWNlIGEgcHJvcGVy
dHkgInN0YWxlLXRtIiB0byBhbGxvdyB1c2VyIHRvIGNvbnRyb2wgdGhlIHNldHRpbmcuDQo+Pg0K
Pj4gVXNlIGh3X2NvbXBhdF85XzEgdG8gaGFuZGxlIHRoZSBjb21wYXRpYmlsaXR5IGZvciBtYWNo
aW5lcyBiZWZvcmUgOS4yIHdoaWNoDQo+DQo+aXMgaHdfY29tcGF0XzlfMSBhIHR5cG8/IExvb2tz
IHRvIGJlIHBjX2NvbXBhdF85XzEuIDopDQoNCkdvb2QgY2F0Y2ghIFllcywgd2lsbCBmaXguDQoN
ClRoYW5rcw0KWmhlbnpob25nDQoNCj4NCj5PdGhlcndpc2UgSSB0aGluayBpdCBpcyBnb29kLg0K
Pg0KPlJldmlld2VkLWJ5OiBZaSBMaXUgPHlpLmwubGl1QGludGVsLmNvbT4NCj4NCj4+IGFsbG93
IGd1ZXN0IHRvIHNldCB0aGUgZmllbGQuIFN0YXJ0aW5nIGZyb20gOS4yLCB0aGlzIGZpZWxkIGlz
IHJlc2VydmVkKDApDQo+PiBieSBkZWZhdWx0IHRvIG1hdGNoIHNwZWMuIE9mIGNvdXJzZSwgdXNl
ciBjYW4gZm9yY2UgaXQgb24gY29tbWFuZCBsaW5lLg0KPj4NCj4+IFRoaXMgZG9lc24ndCBpbXBh
Y3QgZnVuY3Rpb24gb2YgdklPTU1VIGFzIHRoZXJlIHdhcyBubyBsb2dpYyB0byBlbXVsYXRlDQo+
PiBUcmFuc2llbnQgTWFwcGluZy4NCj4+DQo+PiBTdWdnZXN0ZWQtYnk6IFlpIExpdSA8eWkubC5s
aXVAaW50ZWwuY29tPg0KPj4gU3VnZ2VzdGVkLWJ5OiBKYXNvbiBXYW5nIDxqYXNvd2FuZ0ByZWRo
YXQuY29tPg0KPj4gU2lnbmVkLW9mZi1ieTogWmhlbnpob25nIER1YW4gPHpoZW56aG9uZy5kdWFu
QGludGVsLmNvbT4NCj4+IC0tLQ0KPj4gdjQ6IHMveC1zdGFsZS10bS9zdGFsZS10bSAoSmFzb24p
DQo+PiB2Mzogc3RpbGwgbmVlZCB0byBjaGVjayB4ODZfaW9tbXUtPmR0X3N1cHBvcnRlZA0KPj4g
djI6IGludHJvY3VkZSAieC1zdGFsZS10bSIgdG8gaGFuZGxlIG1pZ3JhdGlvbiBjb21wYXRpYmls
aXR5IChKYXNvbikNCj4+DQo+PiAgIGh3L2kzODYvaW50ZWxfaW9tbXVfaW50ZXJuYWwuaCB8IDEy
ICsrKysrKy0tLS0tLQ0KPj4gICBpbmNsdWRlL2h3L2kzODYvaW50ZWxfaW9tbXUuaCAgfCAgMyAr
KysNCj4+ICAgaHcvaTM4Ni9pbnRlbF9pb21tdS5jICAgICAgICAgIHwgIDcgKysrKy0tLQ0KPj4g
ICBody9pMzg2L3BjLmMgICAgICAgICAgICAgICAgICAgfCAgMSArDQo+PiAgIDQgZmlsZXMgY2hh
bmdlZCwgMTQgaW5zZXJ0aW9ucygrKSwgOSBkZWxldGlvbnMoLSkNCj4+DQo+PiBkaWZmIC0tZ2l0
IGEvaHcvaTM4Ni9pbnRlbF9pb21tdV9pbnRlcm5hbC5oIGIvaHcvaTM4Ni9pbnRlbF9pb21tdV9p
bnRlcm5hbC5oDQo+PiBpbmRleCAxM2Q1ZDEyOWFlLi4yZjliYzAxNDdkIDEwMDY0NA0KPj4gLS0t
IGEvaHcvaTM4Ni9pbnRlbF9pb21tdV9pbnRlcm5hbC5oDQo+PiArKysgYi9ody9pMzg2L2ludGVs
X2lvbW11X2ludGVybmFsLmgNCj4+IEBAIC00MTIsOCArNDEyLDggQEAgdHlwZWRlZiB1bmlvbiBW
VERJbnZEZXNjIFZUREludkRlc2M7DQo+PiAgIC8qIFJzdmQgZmllbGQgbWFza3MgZm9yIHNwdGUg
Ki8NCj4+ICAgI2RlZmluZSBWVERfU1BURV9TTlAgMHg4MDBVTEwNCj4+DQo+PiAtI2RlZmluZSBW
VERfU1BURV9QQUdFX0wxX1JTVkRfTUFTSyhhdywgZHRfc3VwcG9ydGVkKSBcDQo+PiAtICAgICAg
ICBkdF9zdXBwb3J0ZWQgPyBcDQo+PiArI2RlZmluZSBWVERfU1BURV9QQUdFX0wxX1JTVkRfTUFT
Syhhdywgc3RhbGVfdG0pIFwNCj4+ICsgICAgICAgIHN0YWxlX3RtID8gXA0KPj4gICAgICAgICAg
ICgweDgwMFVMTCB8IH4oVlREX0hBV19NQVNLKGF3KSB8IFZURF9TTF9JR05fQ09NIHwgVlREX1NM
X1RNKSkgOg0KPlwNCj4+ICAgICAgICAgICAoMHg4MDBVTEwgfCB+KFZURF9IQVdfTUFTSyhhdykg
fCBWVERfU0xfSUdOX0NPTSkpDQo+PiAgICNkZWZpbmUgVlREX1NQVEVfUEFHRV9MMl9SU1ZEX01B
U0soYXcpIFwNCj4+IEBAIC00MjMsMTIgKzQyMywxMiBAQCB0eXBlZGVmIHVuaW9uIFZUREludkRl
c2MgVlRESW52RGVzYzsNCj4+ICAgI2RlZmluZSBWVERfU1BURV9QQUdFX0w0X1JTVkRfTUFTSyhh
dykgXA0KPj4gICAgICAgICAgICgweDg4MFVMTCB8IH4oVlREX0hBV19NQVNLKGF3KSB8IFZURF9T
TF9JR05fQ09NKSkNCj4+DQo+PiAtI2RlZmluZSBWVERfU1BURV9MUEFHRV9MMl9SU1ZEX01BU0so
YXcsIGR0X3N1cHBvcnRlZCkgXA0KPj4gLSAgICAgICAgZHRfc3VwcG9ydGVkID8gXA0KPj4gKyNk
ZWZpbmUgVlREX1NQVEVfTFBBR0VfTDJfUlNWRF9NQVNLKGF3LCBzdGFsZV90bSkgXA0KPj4gKyAg
ICAgICAgc3RhbGVfdG0gPyBcDQo+PiAgICAgICAgICAgKDB4MWZmODAwVUxMIHwgfihWVERfSEFX
X01BU0soYXcpIHwgVlREX1NMX0lHTl9DT00gfA0KPlZURF9TTF9UTSkpIDogXA0KPj4gICAgICAg
ICAgICgweDFmZjgwMFVMTCB8IH4oVlREX0hBV19NQVNLKGF3KSB8IFZURF9TTF9JR05fQ09NKSkN
Cj4+IC0jZGVmaW5lIFZURF9TUFRFX0xQQUdFX0wzX1JTVkRfTUFTSyhhdywgZHRfc3VwcG9ydGVk
KSBcDQo+PiAtICAgICAgICBkdF9zdXBwb3J0ZWQgPyBcDQo+PiArI2RlZmluZSBWVERfU1BURV9M
UEFHRV9MM19SU1ZEX01BU0soYXcsIHN0YWxlX3RtKSBcDQo+PiArICAgICAgICBzdGFsZV90bSA/
IFwNCj4+ICAgICAgICAgICAoMHgzZmZmZjgwMFVMTCB8IH4oVlREX0hBV19NQVNLKGF3KSB8IFZU
RF9TTF9JR05fQ09NIHwNCj5WVERfU0xfVE0pKSA6IFwNCj4+ICAgICAgICAgICAoMHgzZmZmZjgw
MFVMTCB8IH4oVlREX0hBV19NQVNLKGF3KSB8IFZURF9TTF9JR05fQ09NKSkNCj4+DQo+PiBkaWZm
IC0tZ2l0IGEvaW5jbHVkZS9ody9pMzg2L2ludGVsX2lvbW11LmggYi9pbmNsdWRlL2h3L2kzODYv
aW50ZWxfaW9tbXUuaA0KPj4gaW5kZXggMWViMDVjMjlmYy4uZDM3MmNkMzk2YiAxMDA2NDQNCj4+
IC0tLSBhL2luY2x1ZGUvaHcvaTM4Ni9pbnRlbF9pb21tdS5oDQo+PiArKysgYi9pbmNsdWRlL2h3
L2kzODYvaW50ZWxfaW9tbXUuaA0KPj4gQEAgLTMwNiw2ICszMDYsOSBAQCBzdHJ1Y3QgSW50ZWxJ
T01NVVN0YXRlIHsNCj4+ICAgICAgIGJvb2wgZG1hX3RyYW5zbGF0aW9uOyAgICAgICAgICAgLyog
V2hldGhlciBETUEgdHJhbnNsYXRpb24gc3VwcG9ydGVkICovDQo+PiAgICAgICBib29sIHBhc2lk
OyAgICAgICAgICAgICAgICAgICAgIC8qIFdoZXRoZXIgdG8gc3VwcG9ydCBQQVNJRCAqLw0KPj4N
Cj4+ICsgICAgLyogVHJhbnNpZW50IE1hcHBpbmcsIFJlc2VydmVkKDApIHNpbmNlIFZURCBzcGVj
IHJldmlzaW9uIDMuMiAqLw0KPj4gKyAgICBib29sIHN0YWxlX3RtOw0KPj4gKw0KPj4gICAgICAg
LyoNCj4+ICAgICAgICAqIFByb3RlY3RzIElPTU1VIHN0YXRlcyBpbiBnZW5lcmFsLiAgQ3VycmVu
dGx5IGl0IHByb3RlY3RzIHRoZQ0KPj4gICAgICAgICogcGVyLUlPTU1VIElPVExCIGNhY2hlLCBh
bmQgY29udGV4dCBlbnRyeSBjYWNoZSBpbiBWVERBZGRyZXNzU3BhY2UuDQo+PiBkaWZmIC0tZ2l0
IGEvaHcvaTM4Ni9pbnRlbF9pb21tdS5jIGIvaHcvaTM4Ni9pbnRlbF9pb21tdS5jDQo+PiBpbmRl
eCAwOGZlMjE4OTM1Li44NjEyZDA5MTdiIDEwMDY0NA0KPj4gLS0tIGEvaHcvaTM4Ni9pbnRlbF9p
b21tdS5jDQo+PiArKysgYi9ody9pMzg2L2ludGVsX2lvbW11LmMNCj4+IEBAIC0zMzcyLDYgKzMz
NzIsNyBAQCBzdGF0aWMgUHJvcGVydHkgdnRkX3Byb3BlcnRpZXNbXSA9IHsNCj4+ICAgICAgIERF
RklORV9QUk9QX0JPT0woIngtcGFzaWQtbW9kZSIsIEludGVsSU9NTVVTdGF0ZSwgcGFzaWQsIGZh
bHNlKSwNCj4+ICAgICAgIERFRklORV9QUk9QX0JPT0woImRtYS1kcmFpbiIsIEludGVsSU9NTVVT
dGF0ZSwgZG1hX2RyYWluLCB0cnVlKSwNCj4+ICAgICAgIERFRklORV9QUk9QX0JPT0woImRtYS10
cmFuc2xhdGlvbiIsIEludGVsSU9NTVVTdGF0ZSwgZG1hX3RyYW5zbGF0aW9uLA0KPnRydWUpLA0K
Pj4gKyAgICBERUZJTkVfUFJPUF9CT09MKCJzdGFsZS10bSIsIEludGVsSU9NTVVTdGF0ZSwgc3Rh
bGVfdG0sIGZhbHNlKSwNCj4+ICAgICAgIERFRklORV9QUk9QX0VORF9PRl9MSVNUKCksDQo+PiAg
IH07DQo+Pg0KPj4gQEAgLTQxMzgsMTUgKzQxMzksMTUgQEAgc3RhdGljIHZvaWQgdnRkX2luaXQo
SW50ZWxJT01NVVN0YXRlICpzKQ0KPj4gICAgICAgICovDQo+PiAgICAgICB2dGRfc3B0ZV9yc3Zk
WzBdID0gfjBVTEw7DQo+PiAgICAgICB2dGRfc3B0ZV9yc3ZkWzFdID0gVlREX1NQVEVfUEFHRV9M
MV9SU1ZEX01BU0socy0+YXdfYml0cywNCj4+IC0gICAgICAgICAgICAgICAgICAgICAgICAgICAg
ICAgICAgICAgICAgICAgICAgICAgIHg4Nl9pb21tdS0+ZHRfc3VwcG9ydGVkKTsNCj4+ICsgICAg
ICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgeDg2X2lvbW11LT5kdF9zdXBwb3J0
ZWQgJiYgcy0+c3RhbGVfdG0pOw0KPj4gICAgICAgdnRkX3NwdGVfcnN2ZFsyXSA9IFZURF9TUFRF
X1BBR0VfTDJfUlNWRF9NQVNLKHMtPmF3X2JpdHMpOw0KPj4gICAgICAgdnRkX3NwdGVfcnN2ZFsz
XSA9IFZURF9TUFRFX1BBR0VfTDNfUlNWRF9NQVNLKHMtPmF3X2JpdHMpOw0KPj4gICAgICAgdnRk
X3NwdGVfcnN2ZFs0XSA9IFZURF9TUFRFX1BBR0VfTDRfUlNWRF9NQVNLKHMtPmF3X2JpdHMpOw0K
Pj4NCj4+ICAgICAgIHZ0ZF9zcHRlX3JzdmRfbGFyZ2VbMl0gPSBWVERfU1BURV9MUEFHRV9MMl9S
U1ZEX01BU0socy0+YXdfYml0cywNCj4+IC0gICAgICAgICAgICAgICAgICAgICAgICAgICAgICAg
ICAgICAgICAgICAgICAgICAgICAgeDg2X2lvbW11LT5kdF9zdXBwb3J0ZWQpOw0KPj4gKyAgICAg
ICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICB4ODZfaW9tbXUtPmR0X3N1cHBvcnRl
ZCAmJiBzLT5zdGFsZV90bSk7DQo+PiAgICAgICB2dGRfc3B0ZV9yc3ZkX2xhcmdlWzNdID0gVlRE
X1NQVEVfTFBBR0VfTDNfUlNWRF9NQVNLKHMtPmF3X2JpdHMsDQo+PiAtICAgICAgICAgICAgICAg
ICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgIHg4Nl9pb21tdS0+ZHRfc3VwcG9y
dGVkKTsNCj4+ICsgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgeDg2X2lv
bW11LT5kdF9zdXBwb3J0ZWQgJiYgcy0+c3RhbGVfdG0pOw0KPj4NCj4+ICAgICAgIGlmIChzLT5z
Y2FsYWJsZV9tb2RlIHx8IHMtPnNub29wX2NvbnRyb2wpIHsNCj4+ICAgICAgICAgICB2dGRfc3B0
ZV9yc3ZkWzFdICY9IH5WVERfU1BURV9TTlA7DQo+PiBkaWZmIC0tZ2l0IGEvaHcvaTM4Ni9wYy5j
IGIvaHcvaTM4Ni9wYy5jDQo+PiBpbmRleCAyMDQ3NjMzZTRjLi44MzA2MTRkOTMwIDEwMDY0NA0K
Pj4gLS0tIGEvaHcvaTM4Ni9wYy5jDQo+PiArKysgYi9ody9pMzg2L3BjLmMNCj4+IEBAIC04Miw2
ICs4Miw3IEBADQo+PiAgIEdsb2JhbFByb3BlcnR5IHBjX2NvbXBhdF85XzFbXSA9IHsNCj4+ICAg
ICAgIHsgIklDSDktTFBDIiwgIngtc21pLXN3c21pLXRpbWVyIiwgIm9mZiIgfSwNCj4+ICAgICAg
IHsgIklDSDktTFBDIiwgIngtc21pLXBlcmlvZGljLXRpbWVyIiwgIm9mZiIgfSwNCj4+ICsgICAg
eyBUWVBFX0lOVEVMX0lPTU1VX0RFVklDRSwgInN0YWxlLXRtIiwgIm9uIiB9LA0KPj4gICB9Ow0K
Pj4gICBjb25zdCBzaXplX3QgcGNfY29tcGF0XzlfMV9sZW4gPSBHX05fRUxFTUVOVFMocGNfY29t
cGF0XzlfMSk7DQo+Pg0KPg0KPi0tDQo+UmVnYXJkcywNCj5ZaSBMaXUNCg==

