Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E06B1C3600B
	for <qemu-devel@archiver.kernel.org>; Thu, 27 Mar 2025 10:08:56 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1txk9g-0004hn-0K; Thu, 27 Mar 2025 06:08:08 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <zhenzhong.duan@intel.com>)
 id 1txk9U-0004gd-3m
 for qemu-devel@nongnu.org; Thu, 27 Mar 2025 06:07:57 -0400
Received: from mgamail.intel.com ([198.175.65.20])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <zhenzhong.duan@intel.com>)
 id 1txk9Q-000494-Pf
 for qemu-devel@nongnu.org; Thu, 27 Mar 2025 06:07:55 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1743070073; x=1774606073;
 h=from:to:cc:subject:date:message-id:references:
 in-reply-to:content-transfer-encoding:mime-version;
 bh=QIWnnOuxuKuP+OxoCiy/Ciqce/QtZ8paN5CIDfi08/4=;
 b=XqbF1jKwVTyXXr8uwfPne5TCazMvxVVzduH0ur7LmdwLSGDNOjtSd1eZ
 lXhtCYMk/ojW6L8o1zPG4S0d976jSq6TQPt6qCWDsAFMzSJ/dUvd4zMwN
 OBeHkBZ9OeuMpGGNJcYYwdAyFQHfzCiA0fEclTeByAkMSe0qox7I5Fig8
 jkpGoOGzwEa+ScaCa3o2W2ctGVH1C+yVkx+ihxzi2l0ELSJs8wvRpGX5n
 DDCzEJGCTOpl/Uisi1fyl4uBhE6a0DK0ee+YajOah+WT5Tt2D6b/r0TSE
 cL3ABUS+WSbNMVn/+wnqPX/2zYkO2TMOiDpKzYPJuEoRjcRNRZBq9Ilo9 w==;
X-CSE-ConnectionGUID: PB64g9FhTWeSfDlRCeL+pQ==
X-CSE-MsgGUID: gAGNicELQIq+R2P7nWrsIQ==
X-IronPort-AV: E=McAfee;i="6700,10204,11385"; a="44113306"
X-IronPort-AV: E=Sophos;i="6.14,280,1736841600"; d="scan'208";a="44113306"
Received: from fmviesa008.fm.intel.com ([10.60.135.148])
 by orvoesa112.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 27 Mar 2025 03:07:49 -0700
X-CSE-ConnectionGUID: 8NxLNexGQA+w8G0Phcxvig==
X-CSE-MsgGUID: eBdMyoX3RqSUqOvg+LLXOA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.14,280,1736841600"; d="scan'208";a="125308053"
Received: from orsmsx603.amr.corp.intel.com ([10.22.229.16])
 by fmviesa008.fm.intel.com with ESMTP/TLS/AES256-GCM-SHA384;
 27 Mar 2025 03:07:49 -0700
Received: from ORSMSX903.amr.corp.intel.com (10.22.229.25) by
 ORSMSX603.amr.corp.intel.com (10.22.229.16) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.44; Thu, 27 Mar 2025 03:07:48 -0700
Received: from orsedg603.ED.cps.intel.com (10.7.248.4) by
 ORSMSX903.amr.corp.intel.com (10.22.229.25) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.14 via Frontend Transport; Thu, 27 Mar 2025 03:07:48 -0700
Received: from NAM11-BN8-obe.outbound.protection.outlook.com (104.47.58.170)
 by edgegateway.intel.com (134.134.137.100) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.44; Thu, 27 Mar 2025 03:07:48 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=Igf/hkPBDj2oswhCNJ+JEKsdb7DC3IkWAskRCkllfbFhFwmcNNfsAtIhtoS7YhWZFG3Iirl/rxrKuz26tzYGNwjNqiduzHUlF0KLt0G7jb1sbaZFND9BlZyhNHrit1rmeZLhM9XHXP6on0keXpElXtbGE1lUC7PONLaXc3Z7sF4n4NkxW63sl6cJ3Cu+qd4zwT4NIcO3j3O313GQ0vgdWv+2d2UFfq311MK7SSSvLD4QrM1Wj380k8UTeE56noKDWAmDhwoiFaMoa+u9pYmuTV3PxHxGIB6bw+wRT2+ZU5vET1dR6HuvjZxszJlOUXQme5twMzfFeSI67yBhQZjhRA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=QIWnnOuxuKuP+OxoCiy/Ciqce/QtZ8paN5CIDfi08/4=;
 b=XyMaU+fvOaPJkamNz5PCfytSTzBtGCWJnPzuTvlHtzZf84NnIrQSDk0FBVPiwvVqRBUt2Li0WQZo02rHmhzgheHwApTwJbPWuor0Eu2iLq8z66BkrgSaCCjulcXZJ10lv1sQE8rZgFy9VJ4SDxsaTsu4H37VaTo2C6YQq6mFrzMLFjORoW3ZFXVruNpUIbOLXqwYjb7hS1Ripn0txyWOwPZSFSkfi7vnQEgFNo07l2MqcYGiy4LpCt1rB1lTxc/eWIwxC12K/tcb8khQnipYpog9gyisJtBY5P4bqV3SMgPab5QVjzGqvebOWeBshngKW/svPpwrAQ3TLg3iE05TdQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Received: from SJ0PR11MB6744.namprd11.prod.outlook.com (2603:10b6:a03:47d::10)
 by PH0PR11MB5029.namprd11.prod.outlook.com (2603:10b6:510:30::15)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8534.44; Thu, 27 Mar
 2025 10:07:46 +0000
Received: from SJ0PR11MB6744.namprd11.prod.outlook.com
 ([fe80::fe49:d628:48b1:6091]) by SJ0PR11MB6744.namprd11.prod.outlook.com
 ([fe80::fe49:d628:48b1:6091%6]) with mapi id 15.20.8534.043; Thu, 27 Mar 2025
 10:07:46 +0000
From: "Duan, Zhenzhong" <zhenzhong.duan@intel.com>
To: =?utf-8?B?Q8OpZHJpYyBMZSBHb2F0ZXI=?= <clg@redhat.com>,
 "qemu-devel@nongnu.org" <qemu-devel@nongnu.org>, Alex Williamson
 <alex.williamson@redhat.com>
CC: Avihai Horon <avihaih@nvidia.com>, Eric Auger <eric.auger@redhat.com>,
 John Levon <john.levon@nutanix.com>, Joao Martins <joao.m.martins@oracle.com>
Subject: RE: [PATCH for-10.1 v2 35/37] vfio: Rename vfio-common.h to
 vfio-device.h
Thread-Topic: [PATCH for-10.1 v2 35/37] vfio: Rename vfio-common.h to
 vfio-device.h
Thread-Index: AQHbniQ6xC8JDYziBk6KMU1DcJ1gfbOGw2ow
Date: Thu, 27 Mar 2025 10:07:46 +0000
Message-ID: <SJ0PR11MB6744907FAF3E145E4C73DB3A92A12@SJ0PR11MB6744.namprd11.prod.outlook.com>
References: <20250326075122.1299361-1-clg@redhat.com>
 <20250326075122.1299361-36-clg@redhat.com>
In-Reply-To: <20250326075122.1299361-36-clg@redhat.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: SJ0PR11MB6744:EE_|PH0PR11MB5029:EE_
x-ms-office365-filtering-correlation-id: bd82fe99-2d2f-4c2a-e374-08dd6d1738d6
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0; ARA:13230040|366016|1800799024|376014|38070700018;
x-microsoft-antispam-message-info: =?utf-8?B?VjBjYW82S2pUbElVTVZBL1RncjZ0QTh5cGhDc2swMVBMcEVPUG5VVkpHWUNi?=
 =?utf-8?B?K3VDR0dqakZLVmVWYzhhaUZhNU0yWUNXWlJIRDkvSlFSZ0I2NlRTMkNXYWpB?=
 =?utf-8?B?bDcxU1N3MUh6RnJvWlNJRVN3b091T1R1U1RHMTBqWGFONHBCc2NkT1RTdi9j?=
 =?utf-8?B?djBMQ3Nqd3BlTW5qVUo3cHlnb3hYWGY0bGFMcDVjclptUE1YWnhEUkY4SE91?=
 =?utf-8?B?T1d5YU1HN2JhYStQK2V1Q1VHa0cvb3owc0MyN1FhL2RObFV5N0owTnljOGJV?=
 =?utf-8?B?YlRzOXlnVmRxUGhhSnNyeWJvVkxLbzlRN0xiN2NYYUxqNEl0MnphTTJ6TnF3?=
 =?utf-8?B?NzluMlpwYlV1NGpJUW5FZU5XZStmQWh5WFMxOThHbUVEYjNnUkJxSnRDQ0NH?=
 =?utf-8?B?ZmtTQm5CbHdCZDBJaUtuUEZzOHlmbUdJdnpzRDVETURDZHI0TW5Oc0QvcFl5?=
 =?utf-8?B?dSt4SUtJMHF1bW5haEx3bThlTitTMys2bHJSY0Z4SnRqWHZoSzdzbG1jY1NI?=
 =?utf-8?B?bkdBQkppeExtWlIvTEpONkRNUFcwcnhISklkRkYyNFc5WkZ3MCtTRE83Q1Yz?=
 =?utf-8?B?NnhDTytBQmEvelQ5TEtnOWN3a1pNYmdkdGgrbG9jdkNnVzZrODVUUEs4R3pT?=
 =?utf-8?B?eTRoQ1Y3Ylk1eU1QeTJRVFRENm5wNFlvN3dES0owTUZrWWJkT1gxaC9tWHh6?=
 =?utf-8?B?TjE1YXBWTEM4aTlMVnNtRldUUkFqR2hUaXhXS0ptNUhXRFF0NlNtNEtzWFNB?=
 =?utf-8?B?TnNCRHg4T2N3eVgwM0owVnlFbWtmcno3cEdvdTNRemorYTk1SnB1anZoamtS?=
 =?utf-8?B?anhzb0NqaWlxeU41ZUI0NitTNjZYUEVDUWpEeG1UdmorMHNvZnR3d3M4cGR6?=
 =?utf-8?B?S0R6VHR6K1psalZRWjkybWZob3RWM29rc240dHdHL3R4QVpINGVmRVpUMkdZ?=
 =?utf-8?B?bUgyci8xYitmSkRxRnlYcUdsQWxLMTlxQmFtL2xvbjZ5c3NnK1ZUa2p1N3FG?=
 =?utf-8?B?UDk0c1JVWWVqSnkzZjVhMFNocVgrdGlGU1BxeVZDMVNURW5YdDl4VWtTV2x6?=
 =?utf-8?B?a1ZhSFh3TDZ1RDR1VXlCQXBlUlBPTW43aGFhalB6K09Bb3JwMlNHeitRUU0x?=
 =?utf-8?B?VmZMbm56ZlIvK1ZZd1lLV0p4OTRQMERVRC9PQVBnNTdIRmJjY0xwSG5HUndX?=
 =?utf-8?B?WHBkQ2dUMDM4Nk55ZCtNa2J4VGJvRnVlL2ZZcmZpeWY4NnRRSG5qMS9mTkEz?=
 =?utf-8?B?N0JjZURPN3U4N2NaRXh5bURKQUdLZ2xkM1JxdkYwcUZFVWlqdzdhN3Y3MGxG?=
 =?utf-8?B?bWcra2RlMEtRUkg0cEdlRFFneDNYYzVONkFMbVd5U0MzYytCM25NZjJFbWta?=
 =?utf-8?B?cTc0SmZDNUF4NWdON0hjTnFaTmxSL2JVMmVaMFRKYWpvN0U2QkQ0STVCakJm?=
 =?utf-8?B?YUdLRnB3ZG5wWkdPYVduSXJLWlNscWV6MWo0V2t4b24zTUQ5TUh4ZWVFMFJE?=
 =?utf-8?B?dFpWZ2VGcDQrNnBRb2htVHo1Z2d1NDNGTEovbUVBV3ZIUE1HVW9NSVQzQ1BP?=
 =?utf-8?B?YzJmL1FIemhOci9Id1lCS3VrbjA3bWtzNFQvb3FPMWl5Tk1maXN6bUlBa1VG?=
 =?utf-8?B?OTVQaWtoNlQ1azRiMlgwOSs4Q1lseWJEbzRNRmltMHhtS1RQelFBYng3MW9i?=
 =?utf-8?B?djBkN3NncVhBUVMydVNka3V1SDlDbWovTnBIeEx6dnIxUDV0UWxqaDdQS3BZ?=
 =?utf-8?B?RlloWGp2ZFVicmdjL3ozNjc1emx5TjRKMkxuM3R5dzFtSEc0MnZCRDN4YXBl?=
 =?utf-8?B?dHB6OWliM2tDWVllZGtidzh4bGgxS0lZS2RDdXFBZS9xaGd6VVdKSlVDV0Vj?=
 =?utf-8?B?TlhFVlJVL1dNdDV2NHQ2S0NlS2EzTVRNUWs2QXl0b0dLSzMrTzd5MDdncXBN?=
 =?utf-8?Q?VZpC3YSmjXuws6Exg10O0NFHqYtFlXJT?=
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:SJ0PR11MB6744.namprd11.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(366016)(1800799024)(376014)(38070700018); DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?UVFaSFFnQUdIbjhMWjY1RnNKWVRPeXJEM05tNW1OL2ZjYWMwTnFlRXNBNk4z?=
 =?utf-8?B?Q3ZFZWloWUZJQXFJYi9melpIUWpjUGhDNDF3Rkg4QnpYQWl4MGlWbDFFajZO?=
 =?utf-8?B?RVFXWWVIdGJ3WUJWazNEbFBUeUV6TkE2Vjl6LzNiQ2RmclFuaXZCNC9lOGY0?=
 =?utf-8?B?SkI3cloyaUxZdWtxa0hiRUtTYTFMYzRYbmN2TmZhT253THI0REI5R3pKTHVx?=
 =?utf-8?B?Mm9RTmlRYndIQjBnYzhySzNMaWR0UHRmRkJLSE1tcHNnUXBlVVdsdE1QamJK?=
 =?utf-8?B?OVdjZ01CNlNaek1YS0RocXlVc1haRm9FSnNPT2lqb0R5SWs5UXJtak5yRHRW?=
 =?utf-8?B?dGp1b1R2YkJyQ051cFhVTVVkSWVKYThMMWlWZi9vU0ZRUy9IOGZUWVczcEtL?=
 =?utf-8?B?ZVd4RExMd0taWEtJaE9ub3l1UTZVem1nN3BrS2xaOExOZHZEK2FMaXdBRDM5?=
 =?utf-8?B?WUJQK3pzVjR2cCtRV0FkajU1WVpmN1JVM0E0QVMzUndGOWszVGQvMmYxY1FI?=
 =?utf-8?B?dEVnNWgzTDRTdmUvYmtISmdWK0JMWWRWTC9mMldsMDhHWm0wYmtuKzNMRko3?=
 =?utf-8?B?Q2gyVWljVmhXbVlESUxKWDMyVWFHaUROcHFraFNUbzNUbTlTN1Q0TFgvUUt3?=
 =?utf-8?B?M3NaaW93emhEREdwZ1RJcTNGRGFDZDRzVzF1VXNldUI2dkQ1SzdXSzNaVEh2?=
 =?utf-8?B?cE03SEFBVjVmS3p6SXVCVzQ4YW11OEI0amp5ejNwTGJhUS9uQ0dtU3NqMndP?=
 =?utf-8?B?QXlvR2FaYld2Y05JSDJHNUNrQ0xlZjdQUkZ3WmxmY0NFZW5yeHNLRmdQa3N5?=
 =?utf-8?B?aW1ibitlelhZZjA0ckxEbVUxdEpmbEhGWnZRcFlkd2dXUUcvLzV0Qms4MEhE?=
 =?utf-8?B?WTBMaUtWSXpmQ3QwVGhnVVNZMG9zcEZqdnF4ZWhFRUlSQjMxZmwyZ2g5aDZj?=
 =?utf-8?B?QjdwMDdOajN3bm0rM3A1cGV0OWdYTkVtWFNPd3Y5ZnJNM2NjWDIyRWlCU2dZ?=
 =?utf-8?B?UEJkWnh2a2NLV0FaSXlCamlLOUdJbWZTT3p2bXJqY1NYbE0xRldtZVJjMjl3?=
 =?utf-8?B?alIzcDhTK25JMFc4cVFrc3NRRms5TDJLMVBDU21vbGRwR1Y4Y01VSDE2a0Fi?=
 =?utf-8?B?eDN2eGh5bGFPb1p5L3lxWjc4L2J1QWhPL0lIVUo4UUxJeEsxbm5ldU4wSlZC?=
 =?utf-8?B?MWRMQ3NhaXd4WFRVL2lONGN4NHQzR3YvOWltUFh5UXNKY1lLS2h3SnBPSFRi?=
 =?utf-8?B?Umk0VkVxZFY0NkxJVU5MNG5FSGRLTE5LMURmc2pNUlRla3dnYXJONG9DMGp4?=
 =?utf-8?B?cFhoSDc0dUlrM0FiZUU3QWp3dnVmc0NrMnZUcVV6TGJDMUp5ZTJ2TWJXMzFI?=
 =?utf-8?B?Y2FVSW1kNHBLMTZaME1mREpsRzBndmdmckZ0SlRHWXhYelROU0RVQzlHanZX?=
 =?utf-8?B?b3cwRmJzRkpMa0pMRUpIcVk5RkM1eFhESkpudWFvenZJVkZxNk1kN0pBeWRH?=
 =?utf-8?B?YUpoelVxbTN5c29VbE9xNFd0Uk5DUmQ1M1dxMVZtNG5DdGNmKy8zaEtvaWlL?=
 =?utf-8?B?a3plV2pIL1A3WTFBMnZDd1NWKzVISG1jU3h2RTc1ZTdTT3BrMEdrUU5kSnJn?=
 =?utf-8?B?bFFXN08xZGd4WW00TDlBaWZRL2Z5TnVYcE90MEJVUU12WHNFbGRvRVpLempD?=
 =?utf-8?B?eDdaR0NQSU9jUWp1eXJwaFI5S3R1bTdhQkFHaFFxaUxIVGNza1RlSk1QeGpJ?=
 =?utf-8?B?S0Q2SjFhM0hMZ2FGNDVlVjR1MkdBTGNmdk1QRFJBelNVMkd5ays3dXVjUDZr?=
 =?utf-8?B?K21WZGE2V2doZTBHS2V6MjJvNUw0M3BtUmZRaStPV1ZCTjRCRHFCWFZGS0Jp?=
 =?utf-8?B?eDZEZHdmNVlkdmRIYnJzcEo3RzJCb3RVSkVtSys4WWVkNDdlaVhaZEd2ckJz?=
 =?utf-8?B?Z0dIb1ArTlJvRTI1WU53bGlTMnQ4Q01CaFEraUhEaElnRGtGbjJJcWJ1Tzly?=
 =?utf-8?B?L0VuZGM2STZzU20xMjdFRmV4ODBPRGYwbTQwS29uNlR1S3g0WTlyc3VlRkkv?=
 =?utf-8?B?czJvWHVVOVdwQVFyYnRkNGdTL0N5M0NVSU1TYmZVY3ZiVDJYSXVhVkNGR1BJ?=
 =?utf-8?Q?2wJ3NLmOkB/nNn7DB5W94pdux?=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: SJ0PR11MB6744.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: bd82fe99-2d2f-4c2a-e374-08dd6d1738d6
X-MS-Exchange-CrossTenant-originalarrivaltime: 27 Mar 2025 10:07:46.1345 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 6x2Ifwrt2548cGgZZrFFBinrm46bMZKmInc63LcIV6b3TR82TOzXz+iLFfZdSFyFtQlKnv2xIu5wg4r0e/RWIdNoPNGlwfUHVH/rTm6cVBk=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH0PR11MB5029
X-OriginatorOrg: intel.com
Received-SPF: pass client-ip=198.175.65.20;
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
IDxjbGdAcmVkaGF0LmNvbT4NCj5TdWJqZWN0OiBbUEFUQ0ggZm9yLTEwLjEgdjIgMzUvMzddIHZm
aW86IFJlbmFtZSB2ZmlvLWNvbW1vbi5oIHRvIHZmaW8tZGV2aWNlLmgNCj4NCj4iaHcvdmZpby92
ZmlvLWNvbW1vbi5oIiBoYXMgYmVlbiBlbXB0aWVkIG9mIG1vc3Qgb2YgaXRzIGRlY2xhcmF0aW9u
cw0KPmJ5IHRoZSBwcmV2aW91cyBjaGFuZ2VzIGFuZCB0aGUgb25seSBkZWNsYXJhdGlvbnMgbGVm
dCBhcmUgcmVsYXRlZCB0bw0KPlZGSU9EZXZpY2UuIFJlbmFtZSBpdCB0byAiaHcvdmZpby92Zmlv
LWRldmljZS5oIiBhbmQgbWFrZSB0aGUNCj5uZWNlc3NhcnkgYWRqdXN0bWVudHMuDQo+DQo+U2ln
bmVkLW9mZi1ieTogQ8OpZHJpYyBMZSBHb2F0ZXIgPGNsZ0ByZWRoYXQuY29tPg0KDQpSZXZpZXdl
ZC1ieTogWmhlbnpob25nIER1YW4gPHpoZW56aG9uZy5kdWFuQGludGVsLmNvbT4NCg0KVGhhbmtz
DQpaaGVuemhvbmcNCg==

