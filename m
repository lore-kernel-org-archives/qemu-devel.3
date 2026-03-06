Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6556FF513E9
	for <qemu-devel@archiver.kernel.org>; Fri,  6 Mar 2026 02:21:14 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vyKnn-0003nM-N5; Thu, 05 Mar 2026 21:20:31 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <zhenzhong.duan@intel.com>)
 id 1vyKnk-0003mh-Je
 for qemu-devel@nongnu.org; Thu, 05 Mar 2026 21:20:29 -0500
Received: from mgamail.intel.com ([198.175.65.14])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <zhenzhong.duan@intel.com>)
 id 1vyKni-00036n-N3
 for qemu-devel@nongnu.org; Thu, 05 Mar 2026 21:20:28 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1772763626; x=1804299626;
 h=from:to:cc:subject:date:message-id:references:
 in-reply-to:content-transfer-encoding:mime-version;
 bh=6yoQedNcZ7kvpHcn/FmvMV4kuhzIyyuCX+Grc4m5rf0=;
 b=Rw+S8NXcVd9QLP0027K26Jk07RAUPuM7hu6gruE+5RseB5lEG4T6KpZL
 0IGOy+njfEha2tiWFrwl7NstJtpho8E2xQjkVXFNj5saGgV0L3e8Q9pXr
 OkvIzrngtSXhDSCJN0ztfxWJHeh0iLUTTCZH71kE1s0bCA7kl55z75Um5
 HV+3oVGQshVe8/6+hw/ildjG45MECXcrrwgKLkAmgX00shfcx3jAa1BPZ
 81+Ru56Zr1ay0HzYIY5AR4n9OQgY816v3L1O22VRxe5ScsHMXiYyPh6NB
 xK94hVGSoZDJVsjVdqTX29MpFvmNPI4U71m/0im3FgL64cxUA4vmw/y1K w==;
X-CSE-ConnectionGUID: hHb3+2oaQ26tYU50QCmv+Q==
X-CSE-MsgGUID: u4fXHx5NRfm9PjI0DB/paw==
X-IronPort-AV: E=McAfee;i="6800,10657,11720"; a="77713190"
X-IronPort-AV: E=Sophos;i="6.23,104,1770624000"; d="scan'208";a="77713190"
Received: from orviesa001.jf.intel.com ([10.64.159.141])
 by orvoesa106.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 05 Mar 2026 18:20:22 -0800
X-CSE-ConnectionGUID: RrwT06jcQuuA+DiKatY9fg==
X-CSE-MsgGUID: UvL7zzLgSsOOMFXiJa+JTg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.23,104,1770624000"; d="scan'208";a="256773909"
Received: from orsmsx902.amr.corp.intel.com ([10.22.229.24])
 by orviesa001.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 05 Mar 2026 18:20:22 -0800
Received: from ORSMSX901.amr.corp.intel.com (10.22.229.23) by
 ORSMSX902.amr.corp.intel.com (10.22.229.24) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.37; Thu, 5 Mar 2026 18:20:22 -0800
Received: from ORSEDG903.ED.cps.intel.com (10.7.248.13) by
 ORSMSX901.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.37 via Frontend Transport; Thu, 5 Mar 2026 18:20:22 -0800
Received: from CH4PR04CU002.outbound.protection.outlook.com (40.107.201.43) by
 edgegateway.intel.com (134.134.137.113) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.37; Thu, 5 Mar 2026 18:20:21 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=bGWRJTpBl+UyfQwg0RY6Ei5bpsQ29WyeB9X2oHsbPTWu8JUgRubJsFGiok/tAswQOSRprHAFKH8EZYPfFFOpvWkjBEJNhScFhNLa1UYrBiutc/bhi1FUv4AgyamNpqFSejXdfGWbc2RsHRHk///cEfj72Ar7thBLEVTIQfEb44m6HmHvWcjS6wyxL/S1OJHvS5gp9cLIhTWqiJbGD/vEtrN1a9/3Io2LN/w1OEE1ovc1f+GBuZcmlB51qqHMe+4iHWMsFlTQMB1CXb7fyGngtoPjsbYuQlH4Ys/HK+hovlSnQwV1saqGj7hYk0BuQAQlJKScCMEXSzvFL3wC4tTLoQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=6yoQedNcZ7kvpHcn/FmvMV4kuhzIyyuCX+Grc4m5rf0=;
 b=WWwtsb4vyDCMB81Z9SvaVGxH9KGE8Fb77FZFTOEohYaU6ntW60mb8lc0dsoaM+R+96oqixN6MoCGtK7FIpUCyahcjJ3wmaKiXJLBp3ndKWlyP9V2m+lblmUlteXzCcTH12TgNZW8w+A8tpjBOfOROZIeNht8QOj+3SGepvbz1YUs9SartiIarXdewPQY8x0oO4D+of+gAVF7dE40qlJvItA2y6cNqs0yZmVtlxmMKYbs6i19N+0YNtYoiXeU8lnks+ksdKggrD6GJs3Fnoyj53CgC2VP+Ora46fU6vS79JLKhnUZ59/d014cvnlXBaOrfkVWddIP9JJrdVP6sKzXgw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Received: from IA3PR11MB9136.namprd11.prod.outlook.com (2603:10b6:208:574::12)
 by DM6PR11MB4514.namprd11.prod.outlook.com (2603:10b6:5:2a3::17) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9700.5; Fri, 6 Mar
 2026 02:20:19 +0000
Received: from IA3PR11MB9136.namprd11.prod.outlook.com
 ([fe80::37b4:37a9:4f3:518b]) by IA3PR11MB9136.namprd11.prod.outlook.com
 ([fe80::37b4:37a9:4f3:518b%5]) with mapi id 15.20.9678.016; Fri, 6 Mar 2026
 02:20:18 +0000
From: "Duan, Zhenzhong" <zhenzhong.duan@intel.com>
To: =?utf-8?B?RGFuaWVsIFAuIEJlcnJhbmfDqQ==?= <berrange@redhat.com>
CC: "devel@lists.libvirt.org" <devel@lists.libvirt.org>, "nathanc@nvidia.com"
 <nathanc@nvidia.com>, "clg@redhat.com" <clg@redhat.com>, "Michael S .
 Tsirkin" <mst@redhat.com>, Jason Wang <jasowang@redhat.com>, "Liu, Yi L"
 <yi.l.liu@intel.com>, =?utf-8?B?Q2zDqW1lbnQgTWF0aGlldS0tRHJpZg==?=
 <clement.mathieu--drif@eviden.com>, QEMU Developers <qemu-devel@nongnu.org>
Subject: RE: [PATCH 2/3] conf: add support for 'scalable_mode' and
 'first_stage' attributes to intel IOMMU
Thread-Topic: [PATCH 2/3] conf: add support for 'scalable_mode' and
 'first_stage' attributes to intel IOMMU
Thread-Index: AQHccA47qXi9zJWsN0mX4CQPdSE8gbUnQj8AgAxQ3XCAbawPgA==
Date: Fri, 6 Mar 2026 02:20:18 +0000
Message-ID: <IA3PR11MB9136A7DF7A2EF4CD567DAAC7927AA@IA3PR11MB9136.namprd11.prod.outlook.com>
References: <20251218110449.53658-1-zhenzhong.duan@intel.com>
 <20251218110449.53658-3-zhenzhong.duan@intel.com>
 <aUPk4f8PU1uenVN-@redhat.com>
 <IA3PR11MB9136424958A27E048C9CFF0D92B0A@IA3PR11MB9136.namprd11.prod.outlook.com>
In-Reply-To: <IA3PR11MB9136424958A27E048C9CFF0D92B0A@IA3PR11MB9136.namprd11.prod.outlook.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: IA3PR11MB9136:EE_|DM6PR11MB4514:EE_
x-ms-office365-filtering-correlation-id: 21c9c64b-3c05-4814-fd35-08de7b26e97c
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0; ARA:13230040|366016|376014|1800799024|38070700021;
x-microsoft-antispam-message-info: vuup3tykgeyp8BG1FkoeskXAk7J4zwGbyjMcIHXb9xYR95p6K7AGnnwAfxvWdq+xr5KfnzZxuxvF0mw01XlBqf31ucp1RXOMBNzKylAqiptuPVcuImEXlhr3zJ0eIlDY0OC+L1R/HSnFriLfgr1f4wvebzcc8koD34lcaJxQgf7sI7gLjl4i0/Y2qM8x3Jb+AQoYFtkYijKVKylhSWOp0qVqpWcUaiRnnwUWiWVKAwSKz5diADD8n+/C5fKHgtUqyeJhw09QsZchdvmhf4TDHZ7BBZNR5EC5UIjcW8S5Q2M0VXNnjNoPBIz7ZUoY/1vs336JGS6y/DyQYM0twMxotV5PKh3a0WhJ1vzAzex/VyCDHysfTWBK/svcYtbW5deGBikn/0XpcHJ1lKJeujQrpSuqH8sU9a97dQ5qeObVctglD57cbjwEliHb4kOsEAo2WF+d3ysOGbmd3r0uQdnH/lorFRKa/JF2MH+L3A30TInUp0ZvrTRiQ9FZ9/jDLFMXv+//Fe0vxCBcdZCeostLQ30E/XKxVuz9TO9lQzyBKXWW55ssVgvF4ytXP1PbOk+bT7IpnmxLgZPT5ECvZ00HTvvYogAWRfqqxwBzJ4mNk1jQKIFTbd+Y2Ie5bcU6W6iS+sd9xp54vo04/nQdPzyNBeTj3zgHnwMKQb/8JTBre4Ihm1cOO5yL0qheFJuyEDyN2hJeksEo1otbba/EQXFUojFx2ywKLv6mIPsZNPO+GQRjALy+Kdp5UP/cUcRG3fdmXOGA3kLSUaacZU5M+gtkg0aRCy1T+wFLdrxrsTt8xzQ=
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:IA3PR11MB9136.namprd11.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(366016)(376014)(1800799024)(38070700021); DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?VWQvckN6a0w5SS9oMUlCVnkyaTVxWHVzaDRvVHRzQ3pPWjZqWlFMVjBTdzlV?=
 =?utf-8?B?eHhGNk1jNjJlZml4ZU1EMmlqNVJRSHdMYzA3bVdUeTJNRVZxdGF3US9ybGxn?=
 =?utf-8?B?SUlBVjdjVVVuOXo5eVpVNzJYMXdOc01Xbjh5VXIwODRrcDFoMnUvbGgreElu?=
 =?utf-8?B?WWZvTHJYSmpBWWgycjFvaVlFM0hmYWN4N043dnpFekkyOHNLeklxT2ZESzRK?=
 =?utf-8?B?RGVEWW9uSzN4RWZ0em56M1lRUjdzNmtBWlUxaEI4cTAzc2x5SWUxQkRoMzNz?=
 =?utf-8?B?KzNRSTQ1aXpYUjRMTzArUFRubEdZSk1ZNnBGeldJbnFwb0ErOGUwZnlGbVph?=
 =?utf-8?B?THhVYldheWNMWFhaSXRXSzVwTStkZ0dIQzQzelJ6aFgvL2x4V1FhaFppOCtk?=
 =?utf-8?B?NkluT2VReHl4a3phbEFkSThoV0lhVTNZZUNocHZqT3FNellFNDB2Y3BWa3U0?=
 =?utf-8?B?NlF4NUcyVGc0cHg1LzBwV0o3b0NHT2lxTGVvaGxmWlpweGtGQXZyZlJwUFFS?=
 =?utf-8?B?Vjk2ZFJNY05tQ3JrTTl5N3VrMTdQSHFJdDdqRW1wbGl1WVdSNU9XbDZReVZa?=
 =?utf-8?B?YUc1QnFWYUtPZ3B3M2tMdklyUFgzb2VPdnR1aUNNbUY1MmI0R0Y5TEYyRHMy?=
 =?utf-8?B?VU82NW14cW9LZ2w4dDduWHBkYTMwSXlWZUFiOGZIQkNtcTZsMlFVbVZqanYz?=
 =?utf-8?B?N3VFTCszbEVjbGpYMlJWa2QvbnBJejJRN0FBNWJLQS9TYlovM2dFLzZob0Vz?=
 =?utf-8?B?RHJsY3ZxU2p0SDBZdlhMRmk4Zjl6VjU4Tk43S3M2cWRYSktrTlFLYU9CRmJL?=
 =?utf-8?B?QjQ1MHpySVZjV0FVVVMvTTcyODZKdFVVdWtQTkpMVFZLSit0Ym1XSDJKeTdu?=
 =?utf-8?B?NHRsZFdTYmFiVXp4WjIzKzhwMEV3VDg2c0lHWnJpSFdjT2VCb3VuWGQ4TGFD?=
 =?utf-8?B?cnRjMHIxTzZHanRxSWZ6SUVkM2laS0FUQTd6OHdacWVlT2Y5OU1oTGxENUFw?=
 =?utf-8?B?bjNSVDAyZFY1MUxZOFRHMkZFSm9tRlNRS2swNUFzZWhyKy8zWExZTVBXb0s2?=
 =?utf-8?B?K0ZzZkZWaDA0OEs0eVVwSFNVWlZacm9wTlVoNUd4d2hZNkI0TlNCM0t5OXpE?=
 =?utf-8?B?TFNDVy9HYWppVm9ueVNVb0RtK3htVlB1UjlHNHVmaVhtbXplQzd6WU9JOGl4?=
 =?utf-8?B?ZStmWWdZTnFXeG01QUEzTHB3c0xsanhrMjMvRlFpTmwycGM3YmhLQVVuN09p?=
 =?utf-8?B?M2xiSFR4aDIxZ0tBT0NzZzJ4Z0JMcSs4ZmJmcUswYXBaSDhQOUk2Qy9YaVdi?=
 =?utf-8?B?aHhGRSs5VkpUUlQ5V2txaWpHR2k1T3o5UmtVRW9qZkdtYTljN3JyL2hFZkhi?=
 =?utf-8?B?TXZYUWczTllKMWlFQXZHK2tVNXorQjZtdEZ3WFZUdDFGdEFKRkJRWnN1ZHhX?=
 =?utf-8?B?emVzRndRYWdzY3RjalpnZ1hoR0k0MjRTRnljeXJlVk1ZdGZ3c1E0MWFYbFRk?=
 =?utf-8?B?aERIeVU3R1UxTlJrWmJVTkhkUXNsQU5lQ0UwdnJoOEQwZTRMS1lRWUIyS0pR?=
 =?utf-8?B?R1BGdEFoM0pxRlpTQ3gyeXloU01UZXFRekd6MFdSaHJIdXJaYmlwZUlySTBO?=
 =?utf-8?B?T0lrTE1aVG1hejYwTlVKQ0xoUVlEdWZRdHYzREVDVm1rd0N4S3VybWllNEhL?=
 =?utf-8?B?VUdIcXZrWTczb1JmR3RDV3ZxbTZvV3hSeEJHUDVZWWRVVENIeHVya2FaNzZ6?=
 =?utf-8?B?bmlWOEJHRkljVmp5TmZaNE5kbFhIY29ldXBxbWQ4cTZ4SVVoTktxbGhjOXFl?=
 =?utf-8?B?MFRIN3U4azYxR2NWVmpkeUhOOU1DUkUrVjBQV0EzVEJDS3VnVHZ4bjM0MmFD?=
 =?utf-8?B?V2gvMEJkcnkydWtERHV5eFZPR1cySnIzbHpQUDZuM2NFNFBubUx0NnBqaXhi?=
 =?utf-8?B?b1RvUlh0eXJTNTNDRUZTSHR2bDJOR0FpWldYbUI5NDh5SG5DWEV2RGl0Rk5y?=
 =?utf-8?B?Tlp6Wmt5cENVa05KWW8ydGJObTV2U0QrSjBmeExVYTRBQ25Lc0hWdFA3N1ds?=
 =?utf-8?B?Wll1bWJsc1pyZ0lPT3VSa2pBcklxRCswNXNhOGpvem9VR1hNWXBjVG00ZGoy?=
 =?utf-8?B?R2x1U3dHbDRWb2s5T3ZzdktjWmJOLy81eitXT0syRGpjZ2ptdGVDaWVlYkMy?=
 =?utf-8?B?c0p5NFFsdFhBdm1kUE5MbkpUYVBCOHdaTlJyS3F4eThobVhCU01tZDVUZEMw?=
 =?utf-8?B?VCs0K05BaHdGUEd1T0RFL3hLcEVHQktRMnZWSDhuNWQ5QkJMUFp3NmRhVkdm?=
 =?utf-8?B?cHRZN0I1TjZqK3ZoUW0rVlMrMXpMdlV4NzBZZTEvSUNUSHVhK0dodz09?=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-Exchange-RoutingPolicyChecked: r09FfWAt2jKZqKj6QCnlPXmI3snIJKJd4OEsIrncLl/4f6/CftLDG8nbM+uAU9RDKeKZhAOunUtnnpFgJykhXIC6EZRsODWEWM4Eoi96JQktXOld+T36x390ijg3Dci8HcMimRIAsox3mbyFPXvSqdF6FpVOirxGomC3Nu9aVv8G+tL+3sWLMSSL1uTu5NIrutoBv1pT+DDoaOXUDYdsdvQrnFLx+r6QOr4igy5NctHgiW99WcMT6Dq/kv5q/boPYg/k59qGrbLoP5c/4N3aWGaznjCIkov7niwa5BFP9Qc351nOMts224rMxnaOk55FufKkNeiiSLQ5LNO+tEQ9rg==
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: IA3PR11MB9136.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 21c9c64b-3c05-4814-fd35-08de7b26e97c
X-MS-Exchange-CrossTenant-originalarrivaltime: 06 Mar 2026 02:20:18.8926 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: jd8/Tez4FIRUat4OQdR+Smc1ETQxW9N4QncbfSgcZXHKcuEgWg20jTO1IN/GKEvCYRkJs5jiMzBn7vHeO1Xx7CRLtZeqQ01oKtA8vMY7LP0=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR11MB4514
X-OriginatorOrg: intel.com
Received-SPF: pass client-ip=198.175.65.14;
 envelope-from=zhenzhong.duan@intel.com; helo=mgamail.intel.com
X-Spam_score_int: -28
X-Spam_score: -2.9
X-Spam_bar: --
X-Spam_report: (-2.9 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_MED=-2.3, RCVD_IN_VALIDITY_RPBL_BLOCKED=0.892,
 RCVD_IN_VALIDITY_SAFE_BLOCKED=0.622, SPF_HELO_NONE=0.001,
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

DQoNCj4tLS0tLU9yaWdpbmFsIE1lc3NhZ2UtLS0tLQ0KPkZyb206IER1YW4sIFpoZW56aG9uZw0K
PlN1YmplY3Q6IFJFOiBbUEFUQ0ggMi8zXSBjb25mOiBhZGQgc3VwcG9ydCBmb3IgJ3NjYWxhYmxl
X21vZGUnIGFuZCAnZmlyc3Rfc3RhZ2UnDQo+YXR0cmlidXRlcyB0byBpbnRlbCBJT01NVQ0KPg0K
Pj4tLS0tLU9yaWdpbmFsIE1lc3NhZ2UtLS0tLQ0KPj5Gcm9tOiBEYW5pZWwgUC4gQmVycmFuZ8Op
IDxiZXJyYW5nZUByZWRoYXQuY29tPg0KPj5TdWJqZWN0OiBSZTogW1BBVENIIDIvM10gY29uZjog
YWRkIHN1cHBvcnQgZm9yICdzY2FsYWJsZV9tb2RlJyBhbmQNCj4+J2ZpcnN0X3N0YWdlJyBhdHRy
aWJ1dGVzIHRvIGludGVsIElPTU1VDQo+Pg0KPj5PbiBUaHUsIERlYyAxOCwgMjAyNSBhdCAwNjow
NDo0OEFNIC0wNTAwLCBaaGVuemhvbmcgRHVhbiB3cm90ZToNCj4+PiBDb3JyZXNwb25kIHRvICd4
LXNjYWxhYmxlLW1vZGUnIGFuZCAneC1mbHRzJyBwcm9wZXJ0aWVzIGluIFFFTVUuDQo+Pg0KPj5U
aGUgJ3gtJyBwcmVmaXggb24gdGhlc2UgcHJvcGVydHkgbmFtZXMgaW5kaWNhdGVzIFFFTVUgY29u
c2lkZXJzDQo+PnRoZW0gZXhwZXJpbWVudGFsIC8gdW5zdGFibGUsIHdoaWNoIG1ha2VzIHRoZW0g
dW5zdWl0YWJsZSBmb3INCj4+ZXhwb3NpbmcgZnJvbSBsaWJ2aXJ0LiAgV2UgbmVlZCB0aGUgUUVN
VSBpbXBsZW1lbnRhdGlvbiB0byBiZWNvbWUNCj4+ZnVsbHkgc3VwcG9ydGVkIGZpcnN0Lg0KPg0K
Pkkgc2VlLCB0aGFua3MuIEkgZGlkbid0IGtub3cgdGhpcyBydWxlIGJlZm9yZS4NCj4NCj5DQ2lu
ZyBxZW11IHZ0ZCBtYWludGFpbmVyL3Jldmlld2VycyBhbmQgcWVtdS1kZXZlbDoNCj4NCj5EbyB5
b3UgdGhpbmsgd2UgY2FuIGRyb3AgJ3gtJyBhcyB3ZSBoYWQgIngtc2NhbGFibGUtbW9kZSIgbW9y
ZSB0aGFuIDUgeWVhcnMgYW5kDQo+IngtZmx0cyIgbW9yZSB0aGFuIDEgeWVhcj8NCg0KS2luZGx5
IHBpbmcsIGFueSBjb21tZW50cz8NCg0KVGhhbmtzDQpaaGVuemhvbmcNCg==

