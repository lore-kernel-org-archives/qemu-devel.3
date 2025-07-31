Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6090FC83F17
	for <qemu-devel@archiver.kernel.org>; Thu, 31 Jul 2025 03:30:59 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uhK07-0003xw-5l; Wed, 30 Jul 2025 23:30:39 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <zhenzhong.duan@intel.com>)
 id 1uhJzv-0003tI-Ew
 for qemu-devel@nongnu.org; Wed, 30 Jul 2025 23:30:29 -0400
Received: from mgamail.intel.com ([198.175.65.13])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <zhenzhong.duan@intel.com>)
 id 1uhJzs-0005nH-Aq
 for qemu-devel@nongnu.org; Wed, 30 Jul 2025 23:30:27 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1753932625; x=1785468625;
 h=from:to:cc:subject:date:message-id:references:
 in-reply-to:content-transfer-encoding:mime-version;
 bh=/vC5A9+hWLSNm0875Zi/GgRQelPdlU39r4WzDgTeAy4=;
 b=VmDcTgHCnTLCMPDHbAW8FjZMUFKAHas8XRHJcaaV/tPrnFx7iVED+1RX
 DAAmw2hILzbFNEDheMoLZO5E1dPrAohOSL3086zNWVyOL9yPrI2jlkSLh
 Al72iOdxHVkM66LawejT9WNegL2wvP+sBAJg+nZgia/EMUq+0alE/p5Gq
 jyPdlEgygJyWNfrVmlYyqPy1hHr697/XGxIN5noCJYWFhxBcmtAr329B9
 +/5MYJ1evRpkBHcnwheX27S3YE0BFbJn3dzprvIJ8yAvKpaX9kl7BhcI9
 AOzu/93m7UFDRfbNVWOVanJ6aKtitB7CInsYv/me391TSbf+Ocigotpu0 w==;
X-CSE-ConnectionGUID: 3qzbzTZrTN2kjea1rCJBKA==
X-CSE-MsgGUID: rq6unWiZQSyNUf6iS+c7gQ==
X-IronPort-AV: E=McAfee;i="6800,10657,11507"; a="67326292"
X-IronPort-AV: E=Sophos;i="6.16,353,1744095600"; d="scan'208";a="67326292"
Received: from fmviesa006.fm.intel.com ([10.60.135.146])
 by orvoesa105.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 30 Jul 2025 20:30:22 -0700
X-CSE-ConnectionGUID: 234Xg10TQlOLpb7ZpGnfZQ==
X-CSE-MsgGUID: vbTP017STJeKNfwIbvbg7g==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.16,353,1744095600"; d="scan'208";a="163028994"
Received: from orsmsx902.amr.corp.intel.com ([10.22.229.24])
 by fmviesa006.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 30 Jul 2025 20:30:21 -0700
Received: from ORSMSX901.amr.corp.intel.com (10.22.229.23) by
 ORSMSX902.amr.corp.intel.com (10.22.229.24) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1748.26; Wed, 30 Jul 2025 20:30:20 -0700
Received: from ORSEDG903.ED.cps.intel.com (10.7.248.13) by
 ORSMSX901.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1748.26 via Frontend Transport; Wed, 30 Jul 2025 20:30:20 -0700
Received: from NAM11-CO1-obe.outbound.protection.outlook.com (40.107.220.80)
 by edgegateway.intel.com (134.134.137.113) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1748.26; Wed, 30 Jul 2025 20:30:20 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=wUgf3Adv7ue7wvIGksGDTRT+7m/gG2+BCwY80Sw/l37EFUWiCYmAmlRb7hFUHnAU6zySaQxvOlg3ueKVPuIf6pDDCZlhHS4C4/w5S8J+TdsN6UcJ2tQpPSDzoLJK3nQQT2EpN3L92DEhLRuJGNtMhCR3s3MsRt0Aw88ML0viTMl7PaCmNeT4VlcWYUlucwwEhHkHbn2DaRNabzZlHb9g4yIgZvR0X2QAm0vbxBnFVsDF9gR9j6stH46bngeuWI/RFUENtjDfRX3VDlVzCG6sFXGHG4dS7h8Gl24nSf0H8JG3JfTjbQIoq486klC9+iZtmE9KCkehpUlF6d38Y55qOA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=/vC5A9+hWLSNm0875Zi/GgRQelPdlU39r4WzDgTeAy4=;
 b=yQX5I1suXG3T2lthpg1aj0Kv+ndgkUxu6qTc4gsz6SJiRWqrazRWSt5xHEmLc1s33Z96S4NlQTgdVMPN4CvozBd4BJ/Q5IJSZlziN8ZKPukTCiFzufzKBz7iIa0tU7tO18xaqLr1/3sdGf+LYHvivJ3B6kRMnSYsF0ToLmyYRFKS+Mi/+6ZTI88FKSUnXu8t4q10ZBELyZIXTJ5ukgXmr91mNQCeKrcFrTkbGyUT6AWgu+ruJ533ytS5ywt9WIHyo113dc9MGZxoHcGqqpX4lf1kGNNUhCgk4Vq2FRht+ASWb8h86W7YQU7vXBjzdszOj6kIKMIzNtfwjKAmDOGm+Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Received: from DS4PPF93A1BBECD.namprd11.prod.outlook.com
 (2603:10b6:f:fc02::3c) by SA2PR11MB5147.namprd11.prod.outlook.com
 (2603:10b6:806:118::19) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8989.11; Thu, 31 Jul
 2025 03:30:18 +0000
Received: from DS4PPF93A1BBECD.namprd11.prod.outlook.com
 ([fe80::e495:c424:3fc7:e18]) by DS4PPF93A1BBECD.namprd11.prod.outlook.com
 ([fe80::e495:c424:3fc7:e18%6]) with mapi id 15.20.8989.010; Thu, 31 Jul 2025
 03:30:18 +0000
From: "Duan, Zhenzhong" <zhenzhong.duan@intel.com>
To: =?utf-8?B?Q8OpZHJpYyBMZSBHb2F0ZXI=?= <clg@redhat.com>,
 "qemu-devel@nongnu.org" <qemu-devel@nongnu.org>
CC: "alex.williamson@redhat.com" <alex.williamson@redhat.com>,
 "eric.auger@redhat.com" <eric.auger@redhat.com>, "mst@redhat.com"
 <mst@redhat.com>, "jasowang@redhat.com" <jasowang@redhat.com>,
 "peterx@redhat.com" <peterx@redhat.com>, "ddutile@redhat.com"
 <ddutile@redhat.com>, "jgg@nvidia.com" <jgg@nvidia.com>,
 "nicolinc@nvidia.com" <nicolinc@nvidia.com>,
 "shameerali.kolothum.thodi@huawei.com"
 <shameerali.kolothum.thodi@huawei.com>, "joao.m.martins@oracle.com"
 <joao.m.martins@oracle.com>, "clement.mathieu--drif@eviden.com"
 <clement.mathieu--drif@eviden.com>, "Tian, Kevin" <kevin.tian@intel.com>,
 "Liu, Yi L" <yi.l.liu@intel.com>, "Peng, Chao P" <chao.p.peng@intel.com>
Subject: RE: [PATCH v4 18/20] vfio: Add a new element bypass_ro in
 VFIOContainerBase
Thread-Topic: [PATCH v4 18/20] vfio: Add a new element bypass_ro in
 VFIOContainerBase
Thread-Index: AQHcAGpS8Ce/Qx+eyUKg1lh8rD0F/LRJIBKAgAFgIkCAADikAIAA3QGw
Date: Thu, 31 Jul 2025 03:30:18 +0000
Message-ID: <DS4PPF93A1BBECD61D7DD8DE959BD43AA569227A@DS4PPF93A1BBECD.namprd11.prod.outlook.com>
References: <20250729092043.785836-1-zhenzhong.duan@intel.com>
 <20250729092043.785836-19-zhenzhong.duan@intel.com>
 <1ec1ad68-d6fc-41b1-8f62-5d1f9bdf3655@redhat.com>
 <IA3PR11MB9136F831BDBB3379EB3D86D49224A@IA3PR11MB9136.namprd11.prod.outlook.com>
 <fc9c0197-e824-4bcc-b2ce-2855f3f9ee1d@redhat.com>
In-Reply-To: <fc9c0197-e824-4bcc-b2ce-2855f3f9ee1d@redhat.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: DS4PPF93A1BBECD:EE_|SA2PR11MB5147:EE_
x-ms-office365-filtering-correlation-id: 2baa8fd7-cd9d-49bb-5ac0-08ddcfe2926f
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
 ARA:13230040|1800799024|376014|366016|7416014|38070700018; 
x-microsoft-antispam-message-info: =?utf-8?B?dFFBKzNOVjRNdGtrL0l2clNwdzVNV1NPKzk0MXQ4Mng5RElubnhHbkxValRu?=
 =?utf-8?B?eHNKYVNvTkoyL0ZQakFpdWVVNVFlRWg5ZUQ3MXpNWFdPY1ZpSFh2VUt4Y21C?=
 =?utf-8?B?QWVPVzJ2L0ZHU29lRzZhWDluaU0xdURNMWNHWFlXeGNjV0VKOXhGSGxBMUFj?=
 =?utf-8?B?SzZaYmxzWTdzTHdWcmJZbWpNQ09GYWRTUjBPajRDR09BY25vQXc3WlpWS2I3?=
 =?utf-8?B?WVF2Z1k3eitKUGVwSEFNeTUyYWFMYjNxT2drMWsvYzI2aVFOZ1NLNFUxRzk0?=
 =?utf-8?B?T3MxSWtUa3hNL2tTdGY5ejdnN3E0MDliakFNZmNSNlhjek9oTUlKM0hSL0M0?=
 =?utf-8?B?RjRzSTU4cGo3b0t2eU02ZFFNcUN4UWFuMW9zbHNvK3VpMW5UQ01UYWRYZnpw?=
 =?utf-8?B?cHpWRFpYUXhpcHBRK0x1STVEUHVkY3Buekg2eTl5WlUrdXZYbDdSS0NDWUdz?=
 =?utf-8?B?TXAxaFhnWld5ZmUvTkRQV2RKb0dySGdocUdQNnhPbXR5UEtaMzRkSEhXenpB?=
 =?utf-8?B?L2hBTkZKMlNGT3VzUThheHJMRnRKWDlFOVZaUWFaWHRPYUJaK3VtNldVQ0lt?=
 =?utf-8?B?YTU5VVpsMGZiNnRQd0U5MmV1T09xN0VuRExxTURZYk83ZnpyNHhwbWJkNXlR?=
 =?utf-8?B?YkdjRjBQbFpEMUtyazVoSDA4QnBXWXZ2S0VPMGZudVdhNU1lUk5MT29vRW5P?=
 =?utf-8?B?bkJhWU1IS0xKektwc2p0NXdKdU0rQit5SkhGKzZ2RDc1djN3TnNTTWsyRENh?=
 =?utf-8?B?bVlxdFA5WmxiTmpXQ2s3SHl0Sm5nVVFhUGd6NDF3Qm1YU2xMUUlXMXNsbzlI?=
 =?utf-8?B?MGdHTjV1cnZoSWFYRitZUk1JV2xiOVIvUXVnKzZOS0dudk9zdlhvdmtlMG52?=
 =?utf-8?B?Vkl0RlVEUVByaWZmcXd5VWRpQUxrcHMrTVpkMzB2N3VvTmNVMkE4RlZrcWUz?=
 =?utf-8?B?bmF0eURram1LN1VpSHpTRWR5cHVUeStGMndUVG1pZ1lYaXYrTjNaMEV1VERH?=
 =?utf-8?B?QkhmdEgzd05ldEhCSGJ3ZEh4SmJxd1NRRjA2Vmo5R2FleTMyM1R0Wlk1T2kv?=
 =?utf-8?B?SnZnSWF5cXpqSjFvL3BDSzFidFY3T0hyaU9nWEYrUjVVRW1RZENBUGwrUEt2?=
 =?utf-8?B?dzFpZ3ZOWFJWM0txMGN0MlJDTDZlZkY1blFhYnR2SXRCOGprckhDcjNyOHVZ?=
 =?utf-8?B?QXd0WXRpV3VUUUhxZWdIS3BHclZUbUlydjhEcXB0M0MxMTRBTzBFYTVYL3Qr?=
 =?utf-8?B?T0VVVnptczRFNzdETTdWeTEyRjJnZ21LMmRsZnRpb0p6aTQzRWtwM1krWFVF?=
 =?utf-8?B?b21WeWw5cEwrN1ZrWCtIWndxYU50QnJTOE53bVdzcnF4eU9LOVpmTENaUnFi?=
 =?utf-8?B?SVdxbjdFMUdpTDgySWZLMDNsQmFlNjlyampyNFQ4VVhHVWlyd29BMnNMZHh5?=
 =?utf-8?B?MFlpamVPZlhqdjFjLzV5WDhZZDBZOVlDdlZDRmIyOWwzbXZJb1ZQZXVjeWhK?=
 =?utf-8?B?cTIwdk9Cdjg0MjgzYU02QWZybmt4bEIvTlRaaituYmtKRjV0dlJqd3doWHpY?=
 =?utf-8?B?ZHJwdk4zTDFjMHl2Ym85Qy9POEJMS2Jhd1NGd2E3RXlsL1k4RG5yWnhIVE95?=
 =?utf-8?B?ZEdMNG5UeXR6cUp0TWY3QmsvWHNUSTc2SmN4WHBLM0RqWVRCUnhBdFY3T1hS?=
 =?utf-8?B?cVdjQmZpZWpDUFlDZHBBZEJ6MXlkYlJ0M3lFUll3SHJYVFE3U3ppWFRlZ0xy?=
 =?utf-8?B?a2hCY1NhS21HOEhSaEgvdkEvcXUrdi9EQzJSS3lDU0ZBTmtmN2NvSEtSN0tD?=
 =?utf-8?B?MFYyNnArVjkvNlBQQVZVZTRBUU8zVjJYL2YxL0NyVWFQaVRWQW9XQzlzbng1?=
 =?utf-8?B?WnhLcnJ2S3J5Nkh3TEtjeHFJeDNMdXBFVmtJUjBoTUdMTVIrQ3hMd05ZM0hT?=
 =?utf-8?B?eC9Hb1F2QTN5ZWlYMkNwVi9EVEtwcGJZL3RBcG5IeHpEMXk4RHlMcGRqaDB0?=
 =?utf-8?Q?tNi7s/lYhj4sFvvkmGZ5igegaNIb88=3D?=
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DS4PPF93A1BBECD.namprd11.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(1800799024)(376014)(366016)(7416014)(38070700018); DIR:OUT;
 SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?V1praXVsYXZPTlJxa2o3dlhkeVB5dXJwVXJTMGs5R2M2bTVKSnRaTUZkdUNV?=
 =?utf-8?B?YXRqM05lbzVCeDdhaTU3K0txSUpWYnVRVnpCUFRyZlR6Y1I5bEVTbzFoa2hJ?=
 =?utf-8?B?MklBUFJuclhuS1ZuOU1VejF2U3NnakhaY092Vi9VMS9qTjRtWUs1VzFNZjNJ?=
 =?utf-8?B?NjVibitIZ01BeTRwMDRHNUk4N1pVZ0RNLzlISmhxdzVxdHZWZVBDcUtYcGFS?=
 =?utf-8?B?OVFHeVZiUGVkeWFBckVTWU1aY1lnWDE5aEFVQUhjbmttRE1lYzU2QzFtcVFw?=
 =?utf-8?B?UEdxVWQ5eG9zUFZVUTlwS0I0MGtoeUUyT1RIRmNXcDhvd081bEJPdWhtbWlt?=
 =?utf-8?B?SFQ1bEtRZE5oM3FHUWV6MmtWM1FQQkU1R1ZBRzdsTURKd3NiZGdCakluV0Jn?=
 =?utf-8?B?WjlHOStFbms0ejBuOHRzUTZWazJGZG84YkF4eVdpV1lDejZKNUFONEtYK1N6?=
 =?utf-8?B?am9lN3lkQnBEeWFiL29ER0dSQUI0c295SUwwa0R3cUN4aFdWUHVBOHhTTHZQ?=
 =?utf-8?B?TGlLV0xBY09sM0JrMlUrelV0Y2prUEI5c2tIdnMvVldjS3VReWtYcGxqTlpT?=
 =?utf-8?B?bzdTWlpiWmFYM2FENnljckVQa1V3SmZ3emM4MUpSb3lWVStFZ3VJUnJtTTND?=
 =?utf-8?B?RkxDaHNSQUl2ZldPdXJhcEJ1VnBwU3RMRy85NUJCM1p4TlkwZ1E2RndQNEhs?=
 =?utf-8?B?VGRCaDlrT013ZlFpcElhL3FaMzZjaGlmeWF6ZlMzdDBrQmNkbGZFcThYTzAw?=
 =?utf-8?B?SUtjZ0dKcmlKbldxemVNODZmbEZjcjZLcnZHYjZXYndPQ05LY2N6MnlVQ2Jx?=
 =?utf-8?B?K0o1U2FQaTI2WlR3MlIyOE1OeVpNMGZZRlFtWjM2bUIzcEFiL05CYTBkdEkz?=
 =?utf-8?B?NTRQVjUrSFV0bEpLMkVudzBxc3haVmhBOExMbzJjaDU4cU1TQ3U5RkQwN2xK?=
 =?utf-8?B?a25PdXpIYWxTM3d4cUlJZ2s3OVFzc3p5SlZsSkcwTS83WG9YT1BlOFJpQlI5?=
 =?utf-8?B?YmgvNjNWR0xBa1pTTno3ME9TY0lMUnR1YXJWZlcxbUlCeUxveEpTbkJBSnk0?=
 =?utf-8?B?aml1ekprUkpxSC9zZTRFR1hkSisxamt4N0VtazhVazBoQS83aUw2V0lmdGNV?=
 =?utf-8?B?d2R1djhVOTErU1U4NHMvTjZXdmlwZW9NV1NCbTVFbUoybFRTK0hMc2FCMENh?=
 =?utf-8?B?MjZ5S0p4a2ZPUHJsM3M5eVVzRE55UkpyRks4di9FU25QWFgxUnl6QWtNd0NZ?=
 =?utf-8?B?RHVpMkVSNEdiZk92L1Q3Zjh1TmlQSXFhSWV6T0l1VjFSc24wOC9JL3RNaHl6?=
 =?utf-8?B?MlVUK3BlSzBpWDR5YVRuYVFSMjZmWjROcVpUeEtEU0llSTEzVVMvY1pTMWk5?=
 =?utf-8?B?MGswWXN3V2VxQ1JJY05wZmxGNHV2bHg3Y2R5Um83TVR6OWMyQ21FbUx6ZEJZ?=
 =?utf-8?B?MUhJNzhIZmF0T05iNnJTeXdFaVc5VGlKK0xwSkk2Y2xTZ3JsOUJSVGJSV0p3?=
 =?utf-8?B?YmFKcFBGTk9McHo3QVJkRXhvUmh1RlhCTDVDcTZobHBzV3hxTUR2MHF0REFr?=
 =?utf-8?B?Y0JNckxhSGFOU2o5ZUVyVVgxQnJDWmxRcWZoMGlteFh5Y1Y4YU5qN3l4TTZ5?=
 =?utf-8?B?Rk15YUFzNis3OUZUSzZXTktia3ZQRk1kckVkTS9PY08vSG9lTy9JekdycEdZ?=
 =?utf-8?B?WEF2b0FsM3o5Ulg2WldxWm5yRHJuaVBDdFZsMTFIUkd5aDVtd1c4RjRBcUJH?=
 =?utf-8?B?ZWtYQVdna3ZBK3lhRG4rRFlvVEdVclVVOVdIajJpaWJvQVU2aTZsdXdsTlV1?=
 =?utf-8?B?R3g2N0NxdXB3K3FYQnBFbGdndzMzOTg5VnhwaWJmVkYrYW9KTlRrTTB1SlF0?=
 =?utf-8?B?OWFmbkV2dEpkYW5jQVEzQWxJQlQvYWY1d254WG1iekE5dk5NUENDRlhkaWp3?=
 =?utf-8?B?VXpleEJNVVd1QjR5M2diWTlZbUdtZzJwSTh0Uy9LV2tZdnVXTDcxakRSWnor?=
 =?utf-8?B?T3lkbGdwSG0rMnBqcnNMbkRMMnRWV3FXblFwbUptSUZTWCtFTlZTUGRoRGtj?=
 =?utf-8?B?MnpESnU4RktqZlRrbnhhZEdpQUdVdGJBcm9nNmxpSmh5ZE13bzJBK1paWlUx?=
 =?utf-8?Q?NCpovf+apvD9eO7/WI2qoAPTx?=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: DS4PPF93A1BBECD.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 2baa8fd7-cd9d-49bb-5ac0-08ddcfe2926f
X-MS-Exchange-CrossTenant-originalarrivaltime: 31 Jul 2025 03:30:18.1959 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: +Q5RqTeHAV7zTzbw78hrpntYi3P2qnya+Qo2AFGUFPKFOK0bh9S+f25nN4AjgE2sI46tSV8KG8zgu//fFOn8sbIeJ0tAQWSLZtWdnmbJAuQ=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA2PR11MB5147
X-OriginatorOrg: intel.com
Received-SPF: pass client-ip=198.175.65.13;
 envelope-from=zhenzhong.duan@intel.com; helo=mgamail.intel.com
X-Spam_score_int: -43
X-Spam_score: -4.4
X-Spam_bar: ----
X-Spam_report: (-4.4 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_MED=-2.3, RCVD_IN_MSPIKE_H2=0.001,
 RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001, RCVD_IN_VALIDITY_SAFE_BLOCKED=0.001,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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
IDxjbGdAcmVkaGF0LmNvbT4NCj5TdWJqZWN0OiBSZTogW1BBVENIIHY0IDE4LzIwXSB2ZmlvOiBB
ZGQgYSBuZXcgZWxlbWVudCBieXBhc3Nfcm8gaW4NCj5WRklPQ29udGFpbmVyQmFzZQ0KPg0KPk9u
IDcvMzAvMjUgMTI6NTgsIER1YW4sIFpoZW56aG9uZyB3cm90ZToNCj4+DQo+Pg0KPj4+IC0tLS0t
T3JpZ2luYWwgTWVzc2FnZS0tLS0tDQo+Pj4gRnJvbTogQ8OpZHJpYyBMZSBHb2F0ZXIgPGNsZ0By
ZWRoYXQuY29tPg0KPj4+IFN1YmplY3Q6IFJlOiBbUEFUQ0ggdjQgMTgvMjBdIHZmaW86IEFkZCBh
IG5ldyBlbGVtZW50IGJ5cGFzc19ybyBpbg0KPj4+IFZGSU9Db250YWluZXJCYXNlDQo+Pj4NCj4+
PiBPbiA3LzI5LzI1IDExOjIwLCBaaGVuemhvbmcgRHVhbiB3cm90ZToNCj4+Pj4gV2hlbiBieXBh
c3Nfcm8gaXMgdHJ1ZSwgcmVhZCBvbmx5IG1lbW9yeSBzZWN0aW9uIGlzIGJ5cGFzc2VkIGZyb20N
Cj4+Pj4gbWFwcGluZyBpbiB0aGUgY29udGFpbmVyLg0KPj4+Pg0KPj4+PiBUaGlzIGlzIGEgcHJl
cGFyaW5nIHBhdGNoIHRvIHdvcmthcm91bmQgSW50ZWwgRVJSQVRBXzc3MjQxNS4NCj4+Pj4NCj4+
Pj4gU2lnbmVkLW9mZi1ieTogWmhlbnpob25nIER1YW4gPHpoZW56aG9uZy5kdWFuQGludGVsLmNv
bT4NCj4+Pj4gLS0tDQo+Pj4+ICAgIGluY2x1ZGUvaHcvdmZpby92ZmlvLWNvbnRhaW5lci1iYXNl
LmggfCAgMSArDQo+Pj4+ICAgIGh3L3ZmaW8vbGlzdGVuZXIuYyAgICAgICAgICAgICAgICAgICAg
fCAxMyArKysrKysrKystLS0tDQo+Pj4+ICAgIDIgZmlsZXMgY2hhbmdlZCwgMTAgaW5zZXJ0aW9u
cygrKSwgNCBkZWxldGlvbnMoLSkNCj4+Pj4NCj4+Pj4gZGlmZiAtLWdpdCBhL2luY2x1ZGUvaHcv
dmZpby92ZmlvLWNvbnRhaW5lci1iYXNlLmgNCj4+PiBiL2luY2x1ZGUvaHcvdmZpby92ZmlvLWNv
bnRhaW5lci1iYXNlLmgNCj4+Pj4gaW5kZXggYmRlZDZlOTkzZi4uMzFmZDc4NGQ3NiAxMDA2NDQN
Cj4+Pj4gLS0tIGEvaW5jbHVkZS9ody92ZmlvL3ZmaW8tY29udGFpbmVyLWJhc2UuaA0KPj4+PiAr
KysgYi9pbmNsdWRlL2h3L3ZmaW8vdmZpby1jb250YWluZXItYmFzZS5oDQo+Pj4+IEBAIC01MSw2
ICs1MSw3IEBAIHR5cGVkZWYgc3RydWN0IFZGSU9Db250YWluZXJCYXNlIHsNCj4+Pj4gICAgICAg
IFFMSVNUX0hFQUQoLCBWRklPRGV2aWNlKSBkZXZpY2VfbGlzdDsNCj4+Pj4gICAgICAgIEdMaXN0
ICppb3ZhX3JhbmdlczsNCj4+Pj4gICAgICAgIE5vdGlmaWVyV2l0aFJldHVybiBjcHJfcmVib290
X25vdGlmaWVyOw0KPj4+PiArICAgIGJvb2wgYnlwYXNzX3JvOw0KPj4+PiAgICB9IFZGSU9Db250
YWluZXJCYXNlOw0KPj4+Pg0KPj4+PiAgICB0eXBlZGVmIHN0cnVjdCBWRklPR3Vlc3RJT01NVSB7
DQo+Pj4+IGRpZmYgLS1naXQgYS9ody92ZmlvL2xpc3RlbmVyLmMgYi9ody92ZmlvL2xpc3RlbmVy
LmMNCj4+Pj4gaW5kZXggZjQ5OGUyM2E5My4uYzY0YWE0NTM5ZSAxMDA2NDQNCj4+Pj4gLS0tIGEv
aHcvdmZpby9saXN0ZW5lci5jDQo+Pj4+ICsrKyBiL2h3L3ZmaW8vbGlzdGVuZXIuYw0KPj4+PiBA
QCAtMzY0LDcgKzM2NCw4IEBAIHN0YXRpYyBib29sDQo+Pj4gdmZpb19rbm93bl9zYWZlX21pc2Fs
aWdubWVudChNZW1vcnlSZWdpb25TZWN0aW9uICpzZWN0aW9uKQ0KPj4+PiAgICAgICAgcmV0dXJu
IHRydWU7DQo+Pj4+ICAgIH0NCj4+Pj4NCj4+Pj4gLXN0YXRpYyBib29sIHZmaW9fbGlzdGVuZXJf
dmFsaWRfc2VjdGlvbihNZW1vcnlSZWdpb25TZWN0aW9uICpzZWN0aW9uLA0KPj4+PiArc3RhdGlj
IGJvb2wgdmZpb19saXN0ZW5lcl92YWxpZF9zZWN0aW9uKFZGSU9Db250YWluZXJCYXNlICpiY29u
dGFpbmVyLA0KPj4+PiArICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgIE1l
bW9yeVJlZ2lvblNlY3Rpb24NCj4+PiAqc2VjdGlvbiwNCj4+Pj4gICAgICAgICAgICAgICAgICAg
ICAgICAgICAgICAgICAgICAgICAgICAgIGNvbnN0IGNoYXIgKm5hbWUpDQo+Pj4NCj4+PiBJbnN0
ZWFkIG9mIGFkZGluZyBhICdWRklPQ29udGFpbmVyQmFzZSAqJyBhcmd1bWVudCwgSSB3b3VsZCBh
ZGQgYW4NCj4+PiBleHRyYSAnYm9vbCBieXBhc3Nfcm8nIGFyZ3VtZW50Lg0KPj4NCj4+IERvbmUs
IHNlZQ0KPmh0dHBzOi8vZ2l0aHViLmNvbS95aWxpdTE3NjUvcWVtdS9jb21taXQvYjBiZThiZmM5
YTg5OTMzNDgxOWYzZjRmMDcwNA0KPmU0NzExNjk0NGE1Mw0KPg0KPkkgZG9uJ3QgdGhpbmsgdGhl
IGV4dHJhICdib29sIGJ5cGFzc19ybycgYXJlIHVzZWZ1bC4gQSBwYXJ0IGZyb20gdGhhdCwNCj5s
b29rcyBnb29kLg0KDQpHdWVzcyB5b3UgbWVhbiAiIGJ5cGFzc19ybyA9IGJjb250YWluZXItPmJ5
cGFzc19ybyIsIEknbGwgdXNlIGJjb250YWluZXItPmJ5cGFzc19ybyBkaXJlY3RseS4NCg0KVGhh
bmtzDQpaaGVuemhvbmcNCg0KPg0KPg0KPlRoYW5rcywNCj4NCj5DLg0KPg0KPg0KPj4gT3Bwb3J0
dW5pc3RpY2FsbHksIEkgYWxzbyBpbnRyb2R1Y2VkIGFub3RoZXIgcGF0Y2ggdG8gYnlwYXNzIGRp
cnR5IHRyYWNraW5nDQo+Zm9yIHJlYWRvbmx5IHJlZ2lvbiwgc2VlDQo+aHR0cHM6Ly9naXRodWIu
Y29tL3lpbGl1MTc2NS9xZW11L2NvbW1pdC9hMjFjZTBhZmQ4YWVjNWQ1YTllNmRlNDZjZjQNCj42
NzU3NTMwY2I3ZDlmDQo+DQoNCg==

