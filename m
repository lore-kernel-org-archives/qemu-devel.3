Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 16C44C3600B
	for <qemu-devel@archiver.kernel.org>; Thu, 27 Mar 2025 10:01:07 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1txk2X-0001xa-Je; Thu, 27 Mar 2025 06:00:45 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <zhenzhong.duan@intel.com>)
 id 1txk2K-0001vs-Qo
 for qemu-devel@nongnu.org; Thu, 27 Mar 2025 06:00:34 -0400
Received: from mgamail.intel.com ([198.175.65.9])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <zhenzhong.duan@intel.com>)
 id 1txk2I-00031A-F8
 for qemu-devel@nongnu.org; Thu, 27 Mar 2025 06:00:32 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1743069631; x=1774605631;
 h=from:to:cc:subject:date:message-id:references:
 in-reply-to:content-transfer-encoding:mime-version;
 bh=YX8QFwTxTwHNGQ34y42b+1t826slIan41GUO010ZCAs=;
 b=e8i6/diaoS7SIbp7p5f+ifukX1wMCu3hCdJnk5EkVzwIwvrZYlxB4vOS
 gTlulQT+CqiSz8dhMfBDk4I4XuWa7u4TvsV95kwypPQvrMnoAYO/a4Ypq
 1uLtFCar45MpMfEQrPgn6vPRMIdM3PjUUmCmKlrGjCgHudTaOb4gjpX3E
 4yOa5tYb2YK1TBdoogqMr//DLFrWuQhR1skrhevpXPna7AlAiKulF8iFW
 QAC9+N8xEGNeF+TD5fMZB4v44duLiUZSPBqwvK/ldUPyiaAVhIVZm487e
 7ExEw6WZNllAkTlpPuE6UKLZyprFfGrTUkbFENsOP+A8jyS2lwkaWQlAZ g==;
X-CSE-ConnectionGUID: OBqCgSgoTgasAdvh9zGtZg==
X-CSE-MsgGUID: hmOHXy38QmmBbv6cZYee0Q==
X-IronPort-AV: E=McAfee;i="6700,10204,11385"; a="66862263"
X-IronPort-AV: E=Sophos;i="6.14,280,1736841600"; d="scan'208";a="66862263"
Received: from fmviesa005.fm.intel.com ([10.60.135.145])
 by orvoesa101.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 27 Mar 2025 03:00:26 -0700
X-CSE-ConnectionGUID: KlQXa2z/RLSDYVll/Gm6bw==
X-CSE-MsgGUID: C54q4+PFRNy/GqLbqvwPdw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.14,280,1736841600"; d="scan'208";a="129773456"
Received: from orsmsx603.amr.corp.intel.com ([10.22.229.16])
 by fmviesa005.fm.intel.com with ESMTP/TLS/AES256-GCM-SHA384;
 27 Mar 2025 03:00:25 -0700
Received: from ORSMSX901.amr.corp.intel.com (10.22.229.23) by
 ORSMSX603.amr.corp.intel.com (10.22.229.16) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.44; Thu, 27 Mar 2025 03:00:24 -0700
Received: from orsedg603.ED.cps.intel.com (10.7.248.4) by
 ORSMSX901.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.14 via Frontend Transport; Thu, 27 Mar 2025 03:00:24 -0700
Received: from NAM12-MW2-obe.outbound.protection.outlook.com (104.47.66.49) by
 edgegateway.intel.com (134.134.137.100) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.44; Thu, 27 Mar 2025 03:00:23 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=h/eAxUB/MD9/ZsNaV9UsZr2N/lceIEqSXgWm2fznVf31HBb8W7/GmWs6yNMTKho6lAtua9Dx+nfh9mUxh89moaDdZleHTuMARucHbpbYrPcpr4juyHCIAKnNkWiXhDG5+qyMAkoTkuUgYZqKXPS8YM+6id/ZQqtYdjLINaICZHLP1oUHUrCJIfiFut5NObe0Pl1uMDKIupUA8z5fEBJlTJB8CD4AQDqd3gLUGFKeOqLoiG0V0ozzQOM/T+oqrwhNpBHWgbp9b6dxc05dhh3llG3POzzrA2HJtVV24EhoxQH+Lsf6wHLKSyhJfey9G28ah4/Y5vDpaaLlRHGvpC3btQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=YX8QFwTxTwHNGQ34y42b+1t826slIan41GUO010ZCAs=;
 b=gpJwNMm8WfI5Hubt8aPb+JhBHDLxM/Hz2ZkHdEuu8u5GXJwW+69IWkOSbPpJ3H+0PpXuu2svaoT3vM0mj4WnckDTsTSE1qo7XwWQPOtiyMmW6JHnF61GEPqZlvt+mN8cnj+qOGY2t/CIDrT5XGYVSG+MmwM07k3ErGTBjfY1Kn982n2uyLqtCntXLDdYPJTlxth9s8aCPnJE13AJ6Ml9m5eBCkuFp563cQqrmpSS6t7JFN/BSgTIxI0ml/wcK239Qhf1T13e4yHavCkdyp/k2OEHFNfIOLpe2gw9gfqkZeDNM+tDL17iR0ypyJ2VsOuMikQ7FZpmPsulyckugCSDaA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Received: from SJ0PR11MB6744.namprd11.prod.outlook.com (2603:10b6:a03:47d::10)
 by PH7PR11MB8011.namprd11.prod.outlook.com (2603:10b6:510:24a::22)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8534.43; Thu, 27 Mar
 2025 10:00:22 +0000
Received: from SJ0PR11MB6744.namprd11.prod.outlook.com
 ([fe80::fe49:d628:48b1:6091]) by SJ0PR11MB6744.namprd11.prod.outlook.com
 ([fe80::fe49:d628:48b1:6091%6]) with mapi id 15.20.8534.043; Thu, 27 Mar 2025
 10:00:22 +0000
From: "Duan, Zhenzhong" <zhenzhong.duan@intel.com>
To: =?utf-8?B?Q8OpZHJpYyBMZSBHb2F0ZXI=?= <clg@redhat.com>,
 "qemu-devel@nongnu.org" <qemu-devel@nongnu.org>, Alex Williamson
 <alex.williamson@redhat.com>
CC: Avihai Horon <avihaih@nvidia.com>, Eric Auger <eric.auger@redhat.com>,
 John Levon <john.levon@nutanix.com>, Joao Martins <joao.m.martins@oracle.com>
Subject: RE: [PATCH for-10.1 v2 23/37] vfio: Move vfio_device_list into
 device.c
Thread-Topic: [PATCH for-10.1 v2 23/37] vfio: Move vfio_device_list into
 device.c
Thread-Index: AQHbniQhyODHOZ39BUG+sKVYKK9GJ7OGwaQw
Date: Thu, 27 Mar 2025 10:00:22 +0000
Message-ID: <SJ0PR11MB67440AF4F7306EB041EA3F2992A12@SJ0PR11MB6744.namprd11.prod.outlook.com>
References: <20250326075122.1299361-1-clg@redhat.com>
 <20250326075122.1299361-24-clg@redhat.com>
In-Reply-To: <20250326075122.1299361-24-clg@redhat.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: SJ0PR11MB6744:EE_|PH7PR11MB8011:EE_
x-ms-office365-filtering-correlation-id: 4f72c7f9-f68e-421e-5799-08dd6d163020
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
 ARA:13230040|376014|366016|1800799024|38070700018|7053199007; 
x-microsoft-antispam-message-info: =?utf-8?B?b2ZROXJ6UDdBL1YxSzEwUElvQ2FJSkFJMnlEL0pYZ01GQ2VNc0lYZ2tFWGJW?=
 =?utf-8?B?cEJhZjVvZUJDcllYS3lvR2FKd1dNRllVMFdwYzhKcW5CclJTaUpBbzRjeEps?=
 =?utf-8?B?YXB3MTU4Z0cvMVROT3BsUUlVZ3ErY1hHQkIrdTJvWUVOWTc5YS80SSs2Q0xo?=
 =?utf-8?B?N1owa0Z6SWdUMHBWNi9uVW1ESllIazcva1lKU3N0dWZ0di93empzZ05TaVJP?=
 =?utf-8?B?TThPd3RzSVQ2eW4zSVZUaFJibm1xWTJod29EOXBRWVVOSEZuSnZsbm5kNlBR?=
 =?utf-8?B?ZUZsT2thNWZFQUhDNmpwV3ozOVRMQ3FpOUM5MWUvRitIK2VQNC9lekRuVXlQ?=
 =?utf-8?B?UkZvQTFXYjVCR1BKa1RwdVlpYVR3SkRvK216QXhaR0pVdEZLcGxIOHZOdXl6?=
 =?utf-8?B?TkJ5c3FIUHBnWjhLRmhQZWxxMUN3S3psTmJOd0NMRGoya0VCR28zcW95a215?=
 =?utf-8?B?UWNUU1p5TEVQVHJGOWZHWHUwc2ZuN3ZWd2FJY0RZTnIvUEJtcXBKUUhiSEk3?=
 =?utf-8?B?L1dpek96TnBXSDJ4V3FreU5RUy9rWWh3TWdyNFB0TlNhSXRNUFpFVTJ4a3JI?=
 =?utf-8?B?RnNSQ2NCN1Q4dlNWclVxSGNhWlpUSG43L2Y4TWZVOWsxendvNWZWNkN2M0xm?=
 =?utf-8?B?bnJhNnkvK2o2blpPbHZDaHFSVmN6YkhjV1ZFd3laUkVac01RN3ZaUmRybTFF?=
 =?utf-8?B?M0V0SmRDS3JTT1pKWkhsZ0lHbzg4K2FqSEdGUzFZUGdURmxQTHRacmFEM3g5?=
 =?utf-8?B?MVpLS29IUzNzcndnQXVEOHhEK0NJSWlaUlhlVjM2dDREdnhRK1N0UzJJSE4v?=
 =?utf-8?B?Z0RJaHNoZ2JOWURaM3VmMWNGUlM0Y2FBelV4TGdFNStDcmFjdGx2aHBid2xD?=
 =?utf-8?B?UktKeWVLVXBGYnczV2NNcmh1MXVmaW9NZk1Nd29YaHpLTUpzYzY1VmZIbDUw?=
 =?utf-8?B?MkorVHFpMC8rOGNwcXowRzFQRnJ5MGNxUjlOOFEzU2pqZEgwK3YvWExSZWxk?=
 =?utf-8?B?bGc0c003dkJhTGJuQ2VIcjBQdHZING9MdW1WVEJZTWpienN4TEo2em8xZEJG?=
 =?utf-8?B?U0czaVp3Qk1zbmtzVS8zMldkalAzSUJUM1BzRWJFbDlDSG1COUtobjlQajVv?=
 =?utf-8?B?dUpzdkR3OWhDeHFoby9GTnppN3BIaWJDSG91Y0U5ay9vbThiYSswMGVDVTFJ?=
 =?utf-8?B?R3lvYU9NOXNmcHZaMGJ2QWFpNlpmYWxKdHQ1L2lzc0tXbWUyUUJPYkxTTll5?=
 =?utf-8?B?UjMxM0hpRmh0TWIyOGtVSXNTVEs5d2VWQ3ZwclFVWEFDRStNY0F4R1pKMEtx?=
 =?utf-8?B?NWdQMHllSTlSbG4reENLQm1HR0ppL0lkaUZ5NUJ5SVhpOVF4UlpsclVsOGd6?=
 =?utf-8?B?SVJiUDkzdWhKKzMzT1FmZGQxSVJCZXZQaXJrdnpWSW1ZVE1VUVF2WGl3cmds?=
 =?utf-8?B?ZzJYeFZrZ2t6Q3V4WVpoclM1TUNLNGd4U0U4L2N6b0lHdjd3aXA3b3JneENh?=
 =?utf-8?B?dUJQbXdqYzQxNlpla0VXQ3JhQ0JTV0R3RjZHbTRHUm52VGdLM1k3TWlzVFNo?=
 =?utf-8?B?Q2YzUEppRGphUmk0TzVja0N2S3lqM2J0SnpmNFI0YjkrWm1zaFJNaGdJQzJq?=
 =?utf-8?B?aGpGbmpIT3VxVUlUbXZ5ZnF1aFRrOXoyVWNSTVUwTXpDd3NmdGtiNEw2amtl?=
 =?utf-8?B?K0ZjWjk5M2s3TzdhZzBJS1FnS1dqUzhRQkhweDVkVU80MWhPZ2poNU9CRjMv?=
 =?utf-8?B?akJkeW1QWVJOOHhjUHFvSFdMM2pydHZFeXhkYk91NFpkVVkzTmhGdVpSVlB5?=
 =?utf-8?B?dWsyTVc2aEl5d2YxWElMODJ1WXp3TUJXbmJuZGFnOHdocjFRSGc1SFNCYVhO?=
 =?utf-8?B?VzQyUUVvVk9FUFJIUDZxbGNOcWMyYWVaRXkxbVFiSjhuS1RUNDVWd01jamlL?=
 =?utf-8?Q?ryAeY0JVYzFzdyEwdC+IqX7Iq+xLwt6m?=
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:SJ0PR11MB6744.namprd11.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(376014)(366016)(1800799024)(38070700018)(7053199007); DIR:OUT;
 SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?YlRtUkUreTMxWHE2QTBWNWVVM1VqSnpwbVNJQzBRWFczYjBSVzVrR0JReExm?=
 =?utf-8?B?c3pvQVZMNW9PWmwwSlZJbG9NaEVKM2s2UEFwbitzV2V5QlhSSHFpOUhoTmE2?=
 =?utf-8?B?cjg0RWhOU3c5NzlGcVMweHhoNHV5YmlGNEEySWJlaEtTRHc2ZkhrNHF1RHlV?=
 =?utf-8?B?ZE82UXhETE9XWXR3eDF2NTh3TDFWQTV4LzVHUDZOcUtDQk5GTi9BVksyQUlm?=
 =?utf-8?B?NkRQZkpNWGI2QjY0REpHclVPNkE2MXU4Qm5rbmNxZjljQ0d1Ky95bXdGV2Fj?=
 =?utf-8?B?N0NROGZuYWVNNEdNM2x3U3g1OWUxTGJEYUlYdVA5bWZCano5aFE5ZkxBekl0?=
 =?utf-8?B?S2dwTGRLNFYwc05vS0g5RXRJOEhNZGtPdm0yN01LZUU2YkNBRjV0SzYzdGdW?=
 =?utf-8?B?TkRLVlp2UW5TNUJIS3dpVTRUc2tHZHZnMXgwNEYzOFpQVDFuR1Nld3g2U1gw?=
 =?utf-8?B?WDRqLy9JY0lvcGJva1pxVG9aVnFwRUZpUE1DMlhFTC9QRU81S2dhMXJ0d1Iz?=
 =?utf-8?B?czhycFlzWks1Nk80OUl2OFdoTkF6cHh4U2psMlJ3ajdKRUx0Tm5sTXVIYmtR?=
 =?utf-8?B?YVVnOGVhN09QQnF3VzdXR0NndXdGcmJXQVUxTWFRR1RoeXpmSmUxQU5WS2gz?=
 =?utf-8?B?T1JVcE92c25kU1lMNDh5WnlLTHJLWkVwanphWnFabEJGU0MrdFpoT2JadHNM?=
 =?utf-8?B?U0Nyckh2UlZtZzF4S3NQakZVT21NREZZU1JJRHdFdEppQXpSQ1NpeFM4QkhC?=
 =?utf-8?B?RFViaW85aWRCWUl4NmJtdi9Wd0Z4UlhGY3BzRW9GV0R5SHVxWDF6RlUxbmFP?=
 =?utf-8?B?UU56dkdPS0QwVVVxNVcrRGZLYllHWWJabzNEalZrWktEcHpnbHJaRTJsVVFR?=
 =?utf-8?B?MTRqTXpDYjN5b0toV21KVFdMbjhhVklqMTR3UUJ6MWxNRHBuZ0w4QnZHV2xR?=
 =?utf-8?B?ZlE5WDRXQmRLK0pDVkdWbEMrRnFNRWdhRDNaUW5MREpZV2p2c0ZXNG9TY2VT?=
 =?utf-8?B?cjZzUlNSTlYza0xDK2NibkR4UGxVWHc1OFhUa0tXWk5DcVJiLzdrNjZTK3By?=
 =?utf-8?B?a2RubnFVZnRTOEhZbTJNbHVQNWlVckxVWlRJWWdkUE1YOHlJNkJsUnJYRE9k?=
 =?utf-8?B?emxGWmVtVXJYVDRYU2hXOWkrczRFbFo3M2pHZkVVUHFOaXBaclpzN0MyS0hu?=
 =?utf-8?B?a3ErMWkvZjBOMjllWFM3UzdwSE1MVnVmK3BGT0poS0VDeUlQSk40d1ozT2pt?=
 =?utf-8?B?SjFaaUY4dTdPNkd0emI1Q3FUeExRSkMzNkhzWUJxaFpPRUI5T2lXU2pXcm9E?=
 =?utf-8?B?MzdIUkZKSFQrdDU4eTFSb29udHFRRTY4OWhoRmJTZVRBdlZ6WmtmM21vY0Y2?=
 =?utf-8?B?VzhXd1Y4MGxCeU8rbllnYk1jM05iWVN1b0d1emtRK3Yybjh2eE15NVBqVncv?=
 =?utf-8?B?ZU5kY2tQTk5ncEZndmRqeHNIKy8vUCtHVmVsSnU4cE1Da09BRkpaRXpmbk85?=
 =?utf-8?B?UnlWMDNYYjFmSk44bk1sTzR2NUdvd2Y3ZTFVQUF6UTVxTUJWZXlBWmNvYUdY?=
 =?utf-8?B?Y3NUMUtielVYMU1wUktJV3FkMVBqVFFydURqL0FiR0dIcWpWRGxJNGpBVFlx?=
 =?utf-8?B?RUtZMXllL1pYc2pLdzB4RUZsU080dEloM1k0VzBTMXd3M2E4UDYzU0NkZ3Jv?=
 =?utf-8?B?eFlDbDNpcHhQN3dFdXA5Y1hmUVBoUThpOHZhVkNSK3F1anpzVkptVElIQktW?=
 =?utf-8?B?L1pPQnF4RS9jcGdmMlZOam5Nais0MXNFY3A0VXQyUVN3d3dsWnEweHZ4U1FM?=
 =?utf-8?B?elA4NHNtNTBPWUVGeU10K0NOU3o1ZDVZUXlnbUhqdm9IS005bVZGbFdMTW5h?=
 =?utf-8?B?TGFJdHZQWnBCZjVPTWtLQzJKSVpiTUk3L1hvUFFYdXhaejBzWnFOUXkzWmVi?=
 =?utf-8?B?U2Q5OFJkYk5FQjJlZ3E0bW0vcmpZdk5JdTZRNTNDRjFRenhtTjJidWNMWXc0?=
 =?utf-8?B?RkJKMXhEZDVhMlZ6OXY5VlV3Qkw2elZTRnJ1NFBoeFZ6alk5anNPZ1Q3OWpI?=
 =?utf-8?B?SjRTVXdQRFdtNjhYUi91UU9BUTEvRURBdGRkSGxzZjAyL1Qvc1FBeU9jZ055?=
 =?utf-8?Q?te2qw36BsgbXD8ecNvwcbHs8p?=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: SJ0PR11MB6744.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 4f72c7f9-f68e-421e-5799-08dd6d163020
X-MS-Exchange-CrossTenant-originalarrivaltime: 27 Mar 2025 10:00:22.0399 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: z9owWyyPNtFP/JUhpGFOCXusITd4+P9BkTERbNQ/nEh9VY+1gYzukqc+R2hYvp0M5OW1BPor6oQ2vWBb7vMMUoJhQ1GRd7LfFRpwFZoBZuA=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH7PR11MB8011
X-OriginatorOrg: intel.com
Received-SPF: pass client-ip=198.175.65.9;
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
IDxjbGdAcmVkaGF0LmNvbT4NCj5TdWJqZWN0OiBbUEFUQ0ggZm9yLTEwLjEgdjIgMjMvMzddIHZm
aW86IE1vdmUgdmZpb19kZXZpY2VfbGlzdCBpbnRvIGRldmljZS5jDQo+DQo+J3ZmaW9fZGV2aWNl
X2xpc3QnIGlzIFZGSU9EZXZpY2UgcmVsYXRlZC4gTW92ZSBpdHMgZGVmaW5pdGlvbnMgaW50bw0K
PiJkZXZpY2UuYyIuDQo+DQo+UmV2aWV3ZWQtYnk6IEpvaG4gTGV2b24gPGpvaG4ubGV2b25AbnV0
YW5peC5jb20+DQo+TGluazogaHR0cHM6Ly9sb3JlLmtlcm5lbC5vcmcvcWVtdS1kZXZlbC8yMDI1
MDMxODA5NTQxNS42NzAzMTktMjMtDQo+Y2xnQHJlZGhhdC5jb20NCj5TaWduZWQtb2ZmLWJ5OiBD
w6lkcmljIExlIEdvYXRlciA8Y2xnQHJlZGhhdC5jb20+DQoNClJldmlld2VkLWJ5OiBaaGVuemhv
bmcgRHVhbiA8emhlbnpob25nLmR1YW5AaW50ZWwuY29tPg0KDQpUaGFua3MNClpoZW56aG9uZw0K

