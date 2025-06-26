Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1FEB1C7EE30
	for <qemu-devel@archiver.kernel.org>; Thu, 26 Jun 2025 01:44:46 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uUbeg-0006fR-JO; Wed, 25 Jun 2025 21:43:58 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <zhenzhong.duan@intel.com>)
 id 1uUbed-0006dU-Om
 for qemu-devel@nongnu.org; Wed, 25 Jun 2025 21:43:55 -0400
Received: from mgamail.intel.com ([192.198.163.7])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <zhenzhong.duan@intel.com>)
 id 1uUbeb-00039k-FN
 for qemu-devel@nongnu.org; Wed, 25 Jun 2025 21:43:55 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1750902233; x=1782438233;
 h=from:to:cc:subject:date:message-id:references:
 in-reply-to:content-transfer-encoding:mime-version;
 bh=NP+33l+HuE/5PDoEHmyqdIJ7d4CXyxbu+/gnxNNeMhI=;
 b=gVZQeigFC/k3J3QpOSQ+j3vGj3q0x7LWoEmJynIwgBzi6eHgBoH8kQr4
 eD6RQFHqN8WP7Mym2Edj6M3VfmyX80TEczfOrcYb6sW3S/Y+jva9CJSH1
 pYftb0gwXSJzf7Y+Z2AJyAiLF7WQVRy2TGDb8tYBOMAkLzdhNJFaiIVGL
 zyCnkIZ88cZwu5oz8yv7IKDgTf77vKaRVqkC9cpZJFVGXzBYYale8jFn3
 Ut+Q0QdtiXsjEpfqzXF1fFS2643reS22oIgzNZafqGZ2mSCrmRtrVd6UG
 8AnN84Y1BrFrsgLCQDn6KgEFysLZWSiXScNFfKnYDQVRyRoP3kwD3jBv5 Q==;
X-CSE-ConnectionGUID: F9TXURqNRBKXiw6Ss2qOMQ==
X-CSE-MsgGUID: +FOqFESQTJmjikxDq/cYHw==
X-IronPort-AV: E=McAfee;i="6800,10657,11475"; a="78622831"
X-IronPort-AV: E=Sophos;i="6.16,266,1744095600"; d="scan'208";a="78622831"
Received: from orviesa001.jf.intel.com ([10.64.159.141])
 by fmvoesa101.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 25 Jun 2025 18:43:48 -0700
X-CSE-ConnectionGUID: ZsvLrCz9TyikidQ9zP42oA==
X-CSE-MsgGUID: 5f0xLDlZTXinrTmvSKiq4Q==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.16,266,1744095600"; d="scan'208";a="189561640"
Received: from orsmsx903.amr.corp.intel.com ([10.22.229.25])
 by orviesa001.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 25 Jun 2025 18:43:48 -0700
Received: from ORSMSX902.amr.corp.intel.com (10.22.229.24) by
 ORSMSX903.amr.corp.intel.com (10.22.229.25) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.25; Wed, 25 Jun 2025 18:43:47 -0700
Received: from ORSEDG901.ED.cps.intel.com (10.7.248.11) by
 ORSMSX902.amr.corp.intel.com (10.22.229.24) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.25 via Frontend Transport; Wed, 25 Jun 2025 18:43:47 -0700
Received: from NAM04-MW2-obe.outbound.protection.outlook.com (40.107.101.53)
 by edgegateway.intel.com (134.134.137.111) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.25; Wed, 25 Jun 2025 18:43:47 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=y5jc+JMCxRjzDnnPOihkrkneGawQ99w0n8Ru7f8RG+zpbhKDDrq4JFOxMfYE5D/3LUMK7Vpknl6InosZhft8hvmKVjZJ4qaSP6k+HlQVQzn6orWMMoU9DK56ReVKJ4HV4GG5g+R68DiBmDZq0RSxfKqpNQ/cEBPhbvuo1i73ELDi5xSI/9lR5pnhnatgc/hy6vYceH1K4Xe5Z5acsa26GLHJ/LX4Wa+qlvSvi1glaqTMSuS4YoaSryOHu+/9WEFE8iynhBj7sT8rW9AVryc1lPfcsQk0pzgZaF4w3mOnBT+PjreUZn69DOO2J5Yio5sgVH42pIg8lZAnVSOOVanC1A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=NP+33l+HuE/5PDoEHmyqdIJ7d4CXyxbu+/gnxNNeMhI=;
 b=AAOTwZtN9zqgDdI7bKS7mwgOqNmCBeSezJ1G1S2iXKGVy31PU+O+IO6JhDH9ah9sPJKw56lG4/G8A+G3G8+GXbydDmAew+nRkHCo4otyYwAcrMikjkSLjDt6JbvIrJKZgKblSKyiEHmVE/b06WqbYhw0JsheUI9YDgpbhd92ev+5UJEHFCVPuihTUQMEV/RCzb6oB1WSy95AfZMVL2tZKBapcJZT+VRkzXioTE3lpE+hWgkMjm/eYEhUd3WXqGpdo8KaZ1CwoK0E2HPgcJtcGNMSWZplJ0n2rfyejCMYfHWnpXRyURrcT07uPss3HxK7NewvUcIZTbqEnZpOkgZLUQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Received: from IA3PR11MB9136.namprd11.prod.outlook.com (2603:10b6:208:574::12)
 by PH7PR11MB6929.namprd11.prod.outlook.com (2603:10b6:510:204::8)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8857.30; Thu, 26 Jun
 2025 01:43:32 +0000
Received: from IA3PR11MB9136.namprd11.prod.outlook.com
 ([fe80::604b:77a4:b1be:3f13]) by IA3PR11MB9136.namprd11.prod.outlook.com
 ([fe80::604b:77a4:b1be:3f13%4]) with mapi id 15.20.8835.023; Thu, 26 Jun 2025
 01:43:32 +0000
From: "Duan, Zhenzhong" <zhenzhong.duan@intel.com>
To: =?utf-8?B?Q8OpZHJpYyBMZSBHb2F0ZXI=?= <clg@redhat.com>,
 "qemu-devel@nongnu.org" <qemu-devel@nongnu.org>
CC: "alex.williamson@redhat.com" <alex.williamson@redhat.com>,
 "eric.auger@redhat.com" <eric.auger@redhat.com>, "steven.sistare@oracle.com"
 <steven.sistare@oracle.com>, "Peng, Chao P" <chao.p.peng@intel.com>
Subject: RE: [PATCH 2/4] vfio/container: fails mdev hotplug if add migration
 blocker failed
Thread-Topic: [PATCH 2/4] vfio/container: fails mdev hotplug if add migration
 blocker failed
Thread-Index: AQHb5ClP2t47oj3id0qr97FPi8XWFbQSClWAgAJX7QCAAEwnsA==
Date: Thu, 26 Jun 2025 01:43:32 +0000
Message-ID: <IA3PR11MB913663657785F666C156C5B2927AA@IA3PR11MB9136.namprd11.prod.outlook.com>
References: <20250623102235.94877-1-zhenzhong.duan@intel.com>
 <20250623102235.94877-3-zhenzhong.duan@intel.com>
 <afc6b039-4569-460f-a15e-ac000bd44d5f@redhat.com>
 <1e67c23c-6027-4fa2-bc9e-0bc9502265d2@redhat.com>
In-Reply-To: <1e67c23c-6027-4fa2-bc9e-0bc9502265d2@redhat.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: IA3PR11MB9136:EE_|PH7PR11MB6929:EE_
x-ms-office365-filtering-correlation-id: 352167f0-5afd-456a-b129-08ddb452dba5
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0; ARA:13230040|376014|366016|1800799024|38070700018;
x-microsoft-antispam-message-info: =?utf-8?B?YXlJU1RtWnVTWWtKQ3RjdU9PRTNXbDYvREFwaEg4clgrdWphSU9mNk1QNGdh?=
 =?utf-8?B?YlIvQ0ZFQmNIQUN3SWp1L0RubHY3RU9lNC9GMTlTUU1RVjdpSC9hVW9IWVk0?=
 =?utf-8?B?b2JzMXlLK080MGpQMTVQMFJnZG83ZU9wb2c4WS9wbjc3czlxeUdwVGFZN3RB?=
 =?utf-8?B?bjRxVmI1Tk1FbHpFQlhVUnd3ZDdlZ21xMmg5TDhXaVdaYTgwVlpVTWVFc1lE?=
 =?utf-8?B?cW5rYkdYSHNFb3kxRzQ4c3NWdHlqcVd0VjNQMUVsMm5sbUp6RC9RSmdkdHAr?=
 =?utf-8?B?ZFJBekxReTQyVDJqMUZac205UXVqb2t5Yk56a0dEZ2hqZG5KVjY2T2tuOW5P?=
 =?utf-8?B?Mk5XalFpNWhMbWF6NVc5eXlBMUx4NzVOd3dHemFvSlB4bE9WZ3F3L2Y3U1Bm?=
 =?utf-8?B?ZmMwNmQvN2t5ZEowQTVPeHFiRGN6c0tLRUp2dUd2aXplMTJsVCtralZ2UGcv?=
 =?utf-8?B?bk9EVmxObm0xSWs5ZXYzY3cwenNIZGJ2WFM4MHY2NUw1WWhXaUw2eFNyZW0w?=
 =?utf-8?B?WFdubGd5QzNoYWpUM2l0WU9CUGE4Mzd6cDNydjBXdmFMekdQeSsra0wyWmth?=
 =?utf-8?B?RytOaFp4czNsUGdLSC9CdFBwL2dROEc4SUJjVDBxL0VBVXNyL0dCVk9oRGlG?=
 =?utf-8?B?MFNxZEIwOENabGlwOVRRMTlZVm9oRHZnMlo1bnNmemNQcmNNV2NXNStQMHpJ?=
 =?utf-8?B?NWYxcW1RbXVQS2UxNGdETTFyMytKL0RjZzJoSDgwME1qQ2l5Zks0Y2I1Vm5F?=
 =?utf-8?B?Z1F1czV1K2JBU3AvNnRVZXNLUVM0LzUxemFNQ3R1aENkbVNJVXdVcWczb2dk?=
 =?utf-8?B?ZVFvSDk5RTM1QjJXWDRXYkY5RmhaT2p4RC8wWm1WV0wydGNneTBQdzV6WDZz?=
 =?utf-8?B?b1RxWFJuQSthcUdicG8zdENNZ1haVUpOYktlUERHamcvYThiQzRYbVdRQm9R?=
 =?utf-8?B?b0tocVhWS202aVJhdHVTaUFKbkF1Vll4eU10UkZmbTQ5UlpWOGpGQmZiMGYx?=
 =?utf-8?B?T25yd3I4SjFDZVQvNmZsMUtDUkREZkx0TzdOTjZCbFRFaURUWVRrQSt5aHVx?=
 =?utf-8?B?MFYvV0RzRitWT1hlUmpNU2VkZHNRZXRyYldaellqSkxpMlFjZzAxTGZhVmxt?=
 =?utf-8?B?WUdidzZGNTI5eE1UZG9VaytpOXF3NlREbjBmT09ibm5QM2xnSGtnL3A1NmNJ?=
 =?utf-8?B?ZDdqQTZLN1l4MWg3TzBBbkRSZ25kNHRLUzcxQVUwNnJGQnZJNk1jOWdRVEZo?=
 =?utf-8?B?NEhkYnNLQ0lqSWVsdTFvNUFHNjl6aDhGemlpc3BwdElrYjlzaHUwN2tMd1hv?=
 =?utf-8?B?NUZ4c1dqSVN5QnZTVkd2S0xIQUIrR28wdFlGWVhFNHA4YXhqNmlJR3I0OXBE?=
 =?utf-8?B?eXJzVTd6VFY3YWVuZVhxQm80UmJmN3FSRU9JclRyaGtlRmY3cUVTMGd6MkYy?=
 =?utf-8?B?cDJFSnZ0clZuS3ZqK1FDQ1lPaUZtQm9IeXZab3hwNVpYVEZrUTJwTkM2cFA0?=
 =?utf-8?B?Rk91em5LdlJZRG53UWhzLzVQMXdjV29pQzErMS9oc2RJcU9HRmxlSTBaTG9l?=
 =?utf-8?B?eU55RFRObkRyMzJxM1NZTkFMakRyS09NYklDUHpqU0s2ZHpKR25SVUc5S2tj?=
 =?utf-8?B?N3grdlVYMnN2WUp4MWZkTjZGU0oyby9TMEczUkRPRGE3V2tjcUJ3N0hjdE1r?=
 =?utf-8?B?RTF0UDl6UW9qMGY4dUw5UXRXU1QyYThPVlZ2L1hHVnFEdjgrelUydHRPYUxJ?=
 =?utf-8?B?MXR5NjBGSGhhUjg5dUhUTXFHNzNCNGl6ZE85c1lxU3k1UThlMkFYNjFkYVJm?=
 =?utf-8?B?SnFYZHBvMUNreDZqa2NxZ3hXRVowMmNCSTdwd0JYV0F5aUw1YXgyaEdLaW9a?=
 =?utf-8?B?T1J3NGZweU9kVHkzRTNTNDk2cmVWaWZ2N1RtbS9aUHlkVmNqQ0RBYVJSRDJM?=
 =?utf-8?B?dGlJaWg4bGlaQko3VklzUTlZSFBVN1JxcUN4VXkrTElBWDQ4eXZqSmxETGYr?=
 =?utf-8?B?YVlrSFl5bENRPT0=?=
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:IA3PR11MB9136.namprd11.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(376014)(366016)(1800799024)(38070700018); DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?VFRXZVIxSDlQeThuQUFvaFZXaEQ2TUFRb3k5VklGR3owanR1MVNTeWRMRmx4?=
 =?utf-8?B?RDJuZjduRnRJYkh3UGRnVEdtNnpJOWx6OWd0b2lvQitqNWZ5QjNRd0FxYlY3?=
 =?utf-8?B?U0ROdjhjZVkreWhQNHI1RXl0aGpCYW50UWl6SjFNdjNNZVp1cG9wbytLcFBM?=
 =?utf-8?B?TTYxaGRrL0o3VkJQM0NpM2ZTUlFGVCsyTWp5OGxjTS9ua1dlWnVTb05vZTVE?=
 =?utf-8?B?Vkkzd3NhbHpNUWt3QUN0UWF2c0pKMmc5TzN3WnphS0pSWGRjaSt4NG81dGVu?=
 =?utf-8?B?OUJ1U2dIazQ5NFFXMkdXMlNXT1FRcmRLNnlkOGNLNDhzdzllUlZNUitKOUlL?=
 =?utf-8?B?a1Y3NE80SkpUY3NtUmhPSVk4T2JlZjhHeUdqb2lPSDgrVWl4NDRaY1c2eDRm?=
 =?utf-8?B?dno4dlVqNm5kclg1OUZvbXhEOWFzRDZjK1RFdk96Uld5eWFuMzduaGN6ekJo?=
 =?utf-8?B?Z3hGSEM1K1V3L08rU3JTZVg4ZERTdTNJQnZKN0dndExGUFRQS0FCcnBFZDV3?=
 =?utf-8?B?UHdOYXN4M05BQ256YnREMUE4dUxNeC9URnV6cU1kUElCR2F2T0l3ZVBDUmFD?=
 =?utf-8?B?M2wrdDhUVmFjU3RkRm1IT24ycDZ3TGJqZEZleEtvUThLeEIwV2xoTnNIc2Ux?=
 =?utf-8?B?b2NFWGgralUvc0pBTGZUMWRjT0hnaHlhaVRTamNzbWNjeUdDUXFJODFERGVT?=
 =?utf-8?B?a29yMnlWTjFya1ZpTzRsVkp5aGcyVFVCZUdoTUpHZlF4QTkvZDQ5SmRLRGlj?=
 =?utf-8?B?WDlwRURITmlzUzdJcXVKN0JJZVpFTmNnTkhxS0VabjhZZVphbzd2SVhoZVNQ?=
 =?utf-8?B?ZEF1N28wNFRZeWtWY2Rzd2xSbzRKeXpNZ0JRYW1KUHd0S3dacjNqN1pqVEJH?=
 =?utf-8?B?YkJ5SDduSHZ2VE5KaThYbS9iaWZCUi9CUnFTbGNrbGd5dERJejYxa3pTV0pG?=
 =?utf-8?B?UXFadHZwNHdvT3I0aFNKMm1OVWtzbFlXZGhUTVVwaHYzbXRTckJoRWFUc3Yy?=
 =?utf-8?B?Yk90VDkwZjZzMHovVmh4Tng3MVN5Ym85dmZ1clUwQXArMzI4TW1WYnlvcTJY?=
 =?utf-8?B?c0Fwbnc0ZWRyeGdVYjk4RThNeEg0a296ODJZbkhadmhMZ0I2SVVYbEtFS1lF?=
 =?utf-8?B?QVc4QXhnbzdsdWZXU2tNWmJ4Ynh4bS9kR0FhblF1ZnIvS2pOc3BZTWtPRjVt?=
 =?utf-8?B?STdpeWNDU3RnWWxDMXlDRldlWDBWTVEyR0V5bGJWNTE2eGZKQ2xPbm03cysr?=
 =?utf-8?B?Q21jN2Vlc2NaOXZBL3VaVG5iS0VVLzVZM3dETlRodXVDNmtlMHdVakw4R3pi?=
 =?utf-8?B?Ti9IdTRKUGFoRjNIYkgwa3hoVmhTOGkzU1ZPbzZnRUJybVA0T0twOVg3TUFo?=
 =?utf-8?B?THlCSFVkWEo5MU1ZY1J4bXVKeG5laEpxVlZUeGNKczJEdmE1QWlYK1oxV0JS?=
 =?utf-8?B?YnQxbnIvcjFUOXdseXRnT3FVVlBaWWRVUnQ1SE9vVVBqeXBmZ3I5MkJSTTdm?=
 =?utf-8?B?d1JXUTdlMzlzTk9nd2MvWXRaUzUvR054YmprZFk3T2E1VGU3TmQ0YUF5Vmhq?=
 =?utf-8?B?VHRJRC9HeklaZXRSTlpXRGVYRWtEV0RoUTkyaHRWOW5Jd09rZ3RvSFd4Sy9M?=
 =?utf-8?B?RXp5TlZ2elVWbk1UVG5yYVl0UWFUNEFqWEtrSG1ZZkxpNGFHcnkrOWQvVk9x?=
 =?utf-8?B?dUtLU1dBK01sNlNmSnBIRGtRazJSY3R6bmtpSHpSYStlS1BTMmZtbmh1WTBx?=
 =?utf-8?B?QjlDT2xXeG1VMEdsTVc3RXFtSFlaNzExWlVhWjZUdXBVWjUwTTdGcG0ybXVy?=
 =?utf-8?B?cjUvWGVzeS8ydW5xQmdkZVJvdjdDL0FRcnhET0ZTMkcwM1NFTld5Q3dIdnAz?=
 =?utf-8?B?cW91TzNrTXd3WnF2ZWlvWEZwZExwcWMyTzhzMWRjM0pVbWZ4Qk00TWpvSjZp?=
 =?utf-8?B?emt0bGhRblJlMVczdDVsZWI5LzRYNFhJM1d2d0FUTkFPZmQxQzZNbGhTQUxU?=
 =?utf-8?B?UXVZV1M5RFhocE1VMGFYSGl5UDJwRC91Z3RjQllMU3hoaVpVZXFCSXR6YnJm?=
 =?utf-8?B?SVZPK1Bab1cwNDdYaHMzQjJudnVVcmR2Y1p2T3p3ZGh5RFJzZzBpUXFjWExR?=
 =?utf-8?Q?yyxvhwbWkoqWRWuui/trXOXCw?=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: IA3PR11MB9136.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 352167f0-5afd-456a-b129-08ddb452dba5
X-MS-Exchange-CrossTenant-originalarrivaltime: 26 Jun 2025 01:43:32.1450 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: XqwyJ+SZAyskvVEYKaEdKFw0zf1XcfBnXgLgOFAay0pViLRheAN0mlOjpC/okN4+GA9oFxv720OiCPauxw0evO9fNkezkvIDG970v4d0NG0=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH7PR11MB6929
X-OriginatorOrg: intel.com
Received-SPF: pass client-ip=192.198.163.7;
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

DQoNCj4tLS0tLU9yaWdpbmFsIE1lc3NhZ2UtLS0tLQ0KPkZyb206IEPDqWRyaWMgTGUgR29hdGVy
IDxjbGdAcmVkaGF0LmNvbT4NCj5TdWJqZWN0OiBSZTogW1BBVENIIDIvNF0gdmZpby9jb250YWlu
ZXI6IGZhaWxzIG1kZXYgaG90cGx1ZyBpZiBhZGQgbWlncmF0aW9uDQo+YmxvY2tlciBmYWlsZWQN
Cj4NCj5PbiA2LzI0LzI1IDExOjIxLCBDw6lkcmljIExlIEdvYXRlciB3cm90ZToNCj4+IE9uIDYv
MjMvMjUgMTI6MjIsIFpoZW56aG9uZyBEdWFuIHdyb3RlOg0KPj4+IEl0J3MgYWdncmVzc2l2ZSB0
byBhYm9ydCBhIHJ1bm5pbmcgUUVNVSBwcm9jZXNzIHdoZW4gaG90cGx1ZyBhIG1kZXYNCj4+PiBh
bmQgaXQgZmFpbHMgbWlncmF0aW9uIGJsb2NrZXIgYWRkaW5nLg0KPj4+DQo+Pj4gRml4IGJ5IGp1
c3QgZmFpbGluZyBtZGV2IGhvdHBsdWcgaXRzZWxmLg0KPj4+DQo+Pj4gU2lnbmVkLW9mZi1ieTog
Wmhlbnpob25nIER1YW4gPHpoZW56aG9uZy5kdWFuQGludGVsLmNvbT4NCj4+PiAtLS0NCj4+PiDC
oCBody92ZmlvL2NvbnRhaW5lci5jIHwgOCArKysrKystLQ0KPj4+IMKgIDEgZmlsZSBjaGFuZ2Vk
LCA2IGluc2VydGlvbnMoKyksIDIgZGVsZXRpb25zKC0pDQo+Pj4NCj4+PiBkaWZmIC0tZ2l0IGEv
aHcvdmZpby9jb250YWluZXIuYyBiL2h3L3ZmaW8vY29udGFpbmVyLmMNCj4+PiBpbmRleCAyODUz
ZjZmMDhiLi42OGI0ZmRiNDAxIDEwMDY0NA0KPj4+IC0tLSBhL2h3L3ZmaW8vY29udGFpbmVyLmMN
Cj4+PiArKysgYi9ody92ZmlvL2NvbnRhaW5lci5jDQo+Pj4gQEAgLTk5MiwxMiArOTkyLDE2IEBA
IHN0YXRpYyBib29sIHZmaW9fbGVnYWN5X2F0dGFjaF9kZXZpY2UoY29uc3QgY2hhcg0KPipuYW1l
LCBWRklPRGV2aWNlICp2YmFzZWRldiwNCj4+PiDCoMKgwqDCoMKgIGlmICh2YmFzZWRldi0+bWRl
dikgew0KPj4+IMKgwqDCoMKgwqDCoMKgwqDCoCBlcnJvcl9zZXRnKCZ2YmFzZWRldi0+Y3ByLm1k
ZXZfYmxvY2tlciwNCj4+PiDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKg
ICJDUFIgZG9lcyBub3Qgc3VwcG9ydCB2ZmlvIG1kZXYgJXMiLCB2YmFzZWRldi0+bmFtZSk7DQo+
Pj4gLcKgwqDCoMKgwqDCoMKgIG1pZ3JhdGVfYWRkX2Jsb2NrZXJfbW9kZXMoJnZiYXNlZGV2LT5j
cHIubWRldl9ibG9ja2VyLA0KPiZlcnJvcl9mYXRhbCwNCj4+PiAtwqDCoMKgwqDCoMKgwqDCoMKg
wqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgIE1JR19NT0RF
X0NQUl9UUkFOU0ZFUiwgLTEpOw0KPj4+ICvCoMKgwqDCoMKgwqDCoCBpZiAobWlncmF0ZV9hZGRf
YmxvY2tlcl9tb2RlcygmdmJhc2VkZXYtPmNwci5tZGV2X2Jsb2NrZXIsIGVycnAsDQo+Pj4gK8Kg
wqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDC
oMKgwqDCoMKgwqDCoMKgIE1JR19NT0RFX0NQUl9UUkFOU0ZFUiwgLTEpKSB7DQo+Pg0KPj4gbWln
cmF0ZV9hZGRfYmxvY2tlcl9tb2RlcygpIHJldHVybnMgLWVycm5vLiBUZXN0aW5nIHdpdGggJzwg
MCcgd291bGQgYmUNCj4+IGJldHRlci4NCj4+DQo+DQo+DQo+UmV2aWV3ZWQtYnk6IEPDqWRyaWMg
TGUgR29hdGVyIDxjbGdAcmVkaGF0LmNvbT4NCj4NCg0KVGhhbmtzIEPDqWRyaWMuDQpJIGV2ZXIg
cGxhbm5lZCB0byBzZW5kIGFuIHVwZGF0ZSBhZnRlciByZWNlaXZpbmcgY29tbWVudHMgZm9yIHBh
dGNoMyw0Lg0KDQpCUnMsDQpaaGVuemhvbmcNCg==

