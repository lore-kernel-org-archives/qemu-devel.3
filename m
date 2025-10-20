Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A2EB0CCD1A5
	for <qemu-devel@archiver.kernel.org>; Mon, 20 Oct 2025 10:08:25 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vAmny-0006zP-Jx; Mon, 20 Oct 2025 06:07:54 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <zhenzhong.duan@intel.com>)
 id 1vAmnw-0006zG-Vv
 for qemu-devel@nongnu.org; Mon, 20 Oct 2025 06:07:53 -0400
Received: from mgamail.intel.com ([192.198.163.12])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <zhenzhong.duan@intel.com>)
 id 1vAmnu-0004Km-Kc
 for qemu-devel@nongnu.org; Mon, 20 Oct 2025 06:07:52 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1760954870; x=1792490870;
 h=from:to:cc:subject:date:message-id:references:
 in-reply-to:content-transfer-encoding:mime-version;
 bh=WJV0B+fnapPon0a1oTCiw4h/N/+3/unHZVynfhid3IM=;
 b=HtvbAGo84r9S3pXGV7SFELx55dzA4Mztzp8mjBi9JUihVNq3rh9JIeZL
 tUZhgQrm14JHIWhPa4C7R5NAMXxsTm0kYe315s57pR+wNjIqi95H/54Md
 tBzP999lRUZb2hhlCxVpIBbEi2b+GKexp74nWCgdl230GFxvaHBaaYNR9
 BQsPKBkIcZupi04oPcgTNppjAqy+yRaaUmAKPQDXcazwrb6XJ64YNtC8K
 xMqLFIq/9huMhPUV6ePX6H+NyU35myCusKa2vtcc/laQy71ChUFMtfGsz
 80EwQLniBqF649+EmyrMtU5LxwI0dmS0kZUhURqX9OEoNsJtmXXN6PT3y Q==;
X-CSE-ConnectionGUID: 2aTAgyA7QwifSQGGaW3PKw==
X-CSE-MsgGUID: MT6WAE3nSia/WD79uvZOBQ==
X-IronPort-AV: E=McAfee;i="6800,10657,11587"; a="66932306"
X-IronPort-AV: E=Sophos;i="6.19,242,1754982000"; d="scan'208";a="66932306"
Received: from fmviesa007.fm.intel.com ([10.60.135.147])
 by fmvoesa106.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 20 Oct 2025 03:07:47 -0700
X-CSE-ConnectionGUID: GVr6kxVDSv6NNjSLRJDaHQ==
X-CSE-MsgGUID: yp2keILaQsKvepMkQkMrmg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.19,242,1754982000"; d="scan'208";a="182993878"
Received: from orsmsx903.amr.corp.intel.com ([10.22.229.25])
 by fmviesa007.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 20 Oct 2025 03:07:47 -0700
Received: from ORSMSX901.amr.corp.intel.com (10.22.229.23) by
 ORSMSX903.amr.corp.intel.com (10.22.229.25) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.27; Mon, 20 Oct 2025 03:07:47 -0700
Received: from ORSEDG901.ED.cps.intel.com (10.7.248.11) by
 ORSMSX901.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.27 via Frontend Transport; Mon, 20 Oct 2025 03:07:47 -0700
Received: from CH1PR05CU001.outbound.protection.outlook.com (52.101.193.25) by
 edgegateway.intel.com (134.134.137.111) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.27; Mon, 20 Oct 2025 03:07:47 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=CmJiSZmFsypIyzcllWvpn3kUM+SOrf/51VRty4JKVkUEhvu6hjDwP5jqCOX1XsYFRG8biOxTY6R7h9zg0XanWkcNN9rgTmAx7lRqnNzkYoD+PL9riYGFv58whMSjPQKFD44PDuJfI5GJntwZDXc/vZUeZZtnYuIhJXJdcAgQBwEVhka4cbho6bo2+Xd0SJR5vAicT7wk/lyZHoE322insewB4C9xaSLxSYC9O4ybl/MTLDwy4b6wfM50zxWRU+EBGdcQU5SO12O1e91QkfZ/mqGWo3ufqDW/7tax/JSGxRU4N98LFp6uKJ7RdGPnr9xMOMr3fOLiSqDsKJnUV9RseQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=WJV0B+fnapPon0a1oTCiw4h/N/+3/unHZVynfhid3IM=;
 b=W1mZ9SLrRTiC/dZd/BjqnLiV3kcD3Bx7bYF5TRU+ueVj9qrDk92s4ViJaXcDvFVHG5F82W/bD07DkZrdBvTBsGdfXYOkkRhoPD3eDX1vV9yqMIBnlAEWDPcK1uE/i/fkwAeY8dxBqYThxrpc9j10ToMc97VO/sQdlR7JHTUQy3DBP50nAPfAPELHs9zO8QLT+QtCXwU5gK67vtovu8oS9k9dguVb4YbuCB5oaSa6tu+6qO41cYYFkPv0WFNsKLwKYeG19+HGBhJIfM9XIV038MYmqUc6jyp6HJNhDO5061aPi9id/L4o4o3CJgJEWoSBeJeEBsfa/Nl7dFB/9m6j+g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Received: from IA3PR11MB9136.namprd11.prod.outlook.com (2603:10b6:208:574::12)
 by MW4PR11MB6763.namprd11.prod.outlook.com (2603:10b6:303:20b::7)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9228.16; Mon, 20 Oct
 2025 10:07:44 +0000
Received: from IA3PR11MB9136.namprd11.prod.outlook.com
 ([fe80::604b:77a4:b1be:3f13]) by IA3PR11MB9136.namprd11.prod.outlook.com
 ([fe80::604b:77a4:b1be:3f13%7]) with mapi id 15.20.9228.015; Mon, 20 Oct 2025
 10:07:44 +0000
From: "Duan, Zhenzhong" <zhenzhong.duan@intel.com>
To: =?utf-8?B?Q8OpZHJpYyBMZSBHb2F0ZXI=?= <clg@redhat.com>,
 "qemu-devel@nongnu.org" <qemu-devel@nongnu.org>
CC: "alex.williamson@redhat.com" <alex.williamson@redhat.com>,
 "mst@redhat.com" <mst@redhat.com>, "jasowang@redhat.com"
 <jasowang@redhat.com>, "Liu, Yi L" <yi.l.liu@intel.com>,
 "clement.mathieu--drif@eviden.com" <clement.mathieu--drif@eviden.com>,
 "eric.auger@redhat.com" <eric.auger@redhat.com>, "joao.m.martins@oracle.com"
 <joao.m.martins@oracle.com>, "avihaih@nvidia.com" <avihaih@nvidia.com>, "Hao, 
 Xudong" <xudong.hao@intel.com>, "Cabiddu, Giovanni"
 <giovanni.cabiddu@intel.com>, "Gross, Mark" <mark.gross@intel.com>, "Van De
 Ven, Arjan" <arjan.van.de.ven@intel.com>
Subject: RE: [PATCH v2 7/8] vfio/migration: Add migration blocker if VM memory
 is too large to cause unmap_bitmap failure
Thread-Topic: [PATCH v2 7/8] vfio/migration: Add migration blocker if VM
 memory is too large to cause unmap_bitmap failure
Thread-Index: AQHcPz9SC8XcAJsaGECSqxaSSWzx7bTKu3mAgAAYobA=
Date: Mon, 20 Oct 2025 10:07:43 +0000
Message-ID: <IA3PR11MB9136C909917EB008F22AA2B892F5A@IA3PR11MB9136.namprd11.prod.outlook.com>
References: <20251017082234.517827-1-zhenzhong.duan@intel.com>
 <20251017082234.517827-8-zhenzhong.duan@intel.com>
 <46047169-739f-4045-a7c0-91d377dfff6e@redhat.com>
In-Reply-To: <46047169-739f-4045-a7c0-91d377dfff6e@redhat.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: IA3PR11MB9136:EE_|MW4PR11MB6763:EE_
x-ms-office365-filtering-correlation-id: 4a7d1271-c3aa-4f98-361f-08de0fc0830c
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0; ARA:13230040|366016|1800799024|376014|38070700021;
x-microsoft-antispam-message-info: =?utf-8?B?WWN3WDlUWVF6ODNqUnlrb1VuUW1TN2N4OUZ1ZVBTYXJKK1BsWVBobG1BSnU0?=
 =?utf-8?B?OFdGVUtPZ2lqdmFDL3dHUmN3aUxoTUNOWXUvTXh3UlREcFNEbE1ueWtzUnJj?=
 =?utf-8?B?VU5IM200N0hKYnJJZC94cEVHaUZxZDZUbUt5ZjlvMmlqS3QwbGh5Qy9RQ0k4?=
 =?utf-8?B?UlB6cUg5TWt2d2R3TlZoTmFHTFA1UlJVTUZVM3hjNi8zREd2MFFnQko4LzBm?=
 =?utf-8?B?YXBYblUvbzN2ZjY4YndiRHlPdWFURTlJRDdoanpxeEVFT2ZGTEJXU2tYL29l?=
 =?utf-8?B?T2VjMmRPc3hhSEhkaVdLM0xUZGZDdDJ2QXN5NDhTMWgzanlWcEhDMEFBVXls?=
 =?utf-8?B?S052aXVVNnFJSERIODRMVjIyaGVsUFlyZGZhelpONmVOSXVKSTlPZ1pVLzBQ?=
 =?utf-8?B?S2k4T3o5RXVVTUljQ2hJVDdiUDlXQXpLaDl1MElXS1JPNnNCTFJTYWVneUxk?=
 =?utf-8?B?ek9iOUJ3YlNhaVllbDdiamJMSlJnaFRPNWovN3pLRG83SWh5K2JwbHJXRXI4?=
 =?utf-8?B?cDJhZE00ZFdlRDFUaC9LcXlSYktkb1VFZlBtTm85UjdiRGdjUTdnU3ozTHFv?=
 =?utf-8?B?L2d0L3Y2Nm90VlRKTkxqa2oweVpOaERxY0d6Y1gveWtTTnc4cHA0YWFkVU9I?=
 =?utf-8?B?d2dpQkVYMmZPZTN3ZzJRMEpld0xvUWxEU295b2x4TldCSTNuN3J0SzQ4YU90?=
 =?utf-8?B?UHZnUm80V3ZkSGZGbkFCUTEwQUdCK05TOFJTenpWNzFrM29Lemg3YUdOa2M5?=
 =?utf-8?B?L3hUYUQzWVhJR2x3bDYwdXhDNm9aRENiVS9kNWlkNDdCQlRjR2k0eXB5czU4?=
 =?utf-8?B?ZEhvSDN2TXRlNm1Ed2c2RG1MN2RuZ0dnUHZuSGdMVG1NWXE5N0FEb0Y5T1Zq?=
 =?utf-8?B?TmVMY2xCdC80TmN5dCttUmJmdUJ3TDc3c1FSc2pLdnpXT0NQWm9VT0hodGZi?=
 =?utf-8?B?dDgza2xVd0RxYjkvS3QzS0sxSWVQWUNidi9JMTUzdjk3MUJrQmFJY3BUcWph?=
 =?utf-8?B?OGY0V2xFeGY2T29Eb1hmOTRrZmcwVXFQR1ZPbFB1QzE5aUJCTjJqMmJOcUF2?=
 =?utf-8?B?K2tXR0t1c0lETHoyc21HOUl0aW5ZN1A5RzJTN1l4dHhGTGQzeTdJaHBUM1dx?=
 =?utf-8?B?d0VZYlFybGJtSnU2eTZoREx2dlVMUjN6dloxZUtxNEt6MHBoWUlMeFc1RVky?=
 =?utf-8?B?VjlMZXE1T3luZVYxeUpNTU1Cekh0cXg0YW9MTmtLR0RFT2Z1dTFHTE5wb2Rr?=
 =?utf-8?B?T1p3R2wzOG44YmVJYnJ6VStGQ1M3VWRpcXQxeEpLMWpTU3ZMRjZISmREekQw?=
 =?utf-8?B?UDFnYi8zd1FRR25FelF5MGZwUmFMMUpBS242dzMrVERTN2FMd0ZPbi9nWFdL?=
 =?utf-8?B?eDAxeURHWTErVWMxZHBxbENSbEZMdFRXcXUrRnJLVFpHNFZHUDB0dnFwMXpE?=
 =?utf-8?B?aHg3TVNYc2dadUtneGJidkhvc3RQTUtiTDgzODNSdjl0SkFZRjZtbWRscThB?=
 =?utf-8?B?TCtWNmhGMWhUQ24xR0dWOTJoU0dHZjBhQkxQcmdmbW0weVQ5bFlOUzdqNTJo?=
 =?utf-8?B?K01QMFZiNUhyazg0cHhQZmpoSUZodlNLL1FtYVdqa0JoaEFRRVhEYlZmSTBw?=
 =?utf-8?B?ZmVQZExkWUtpd1kyek9ybC9WQ3lMYyt1RzQyeXd1Z0xZbk1ubytuMDFia2J4?=
 =?utf-8?B?M3dZbVRvTGFLRkVDQmRZWG9XTHUwZ1QyVko3TzlkVHFDQnFVU3I5SFBram91?=
 =?utf-8?B?Njk1RXFkeFhwUFByOFMrZFRJQlk5c1FjUXZ3VC83dXI0b01VMjdTb1JzWDhT?=
 =?utf-8?B?YVhsWFVHUEJzNGwzeWs1MHZLeVdraTBtODlrSnB1a0hQUXk5YjVoWFY1TXdi?=
 =?utf-8?B?RVJRRElYcUw5OFRrTmt4cnZsckNxSlk3RGducU1NZ0ZHbVNNQ2JObm5jaytU?=
 =?utf-8?B?TGhaR0ZWTVBCNTg0cGM5NFhuSGYyYXpISGdFZTg0RXZQbkJpMCtvU09qTG5M?=
 =?utf-8?B?RDBNQXBKN2xoTzNENkNIRVdFRy96M25qWkdSOVBacmVIc0tqd094S3F4eXpG?=
 =?utf-8?Q?PmDq30?=
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:IA3PR11MB9136.namprd11.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(366016)(1800799024)(376014)(38070700021); DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?emROVEhsdWphYUdudDlsTlQxOERuSkJNL0RWRUN4ci9HZ1I5eExaN1NXOXR3?=
 =?utf-8?B?WjdWZ01EWXhMRVRNZ0tmRi8xaVhpbWwxOVN5R3JtODBtNWNicnBrMkMydHdp?=
 =?utf-8?B?ckhlZ0xaU1RlSlJjUjhlOHpoS1IwU1hhSkRtNTRBU0ZRU1l6RmhJdFE5aVVB?=
 =?utf-8?B?aUpkYzB6TW9ZU3RhSEcrRTlGaVgzeFcxZ3RlcmdQd2xudlVlNHc1cE9vOC9q?=
 =?utf-8?B?SnJIY2w5bXc3ZnhHSkVqeWJCUG96MXlpak8xNGN4UTIvYUF6SzNwMFViV3M1?=
 =?utf-8?B?MFBvcjltcU9BckNDWnNoMjNOOXB1eXdIdE1ub3hZd2hvc1M4S21ZVisyaWVk?=
 =?utf-8?B?WjVUK1NLcHhXNDl0SEF3WUlsM0xVMXJnV3E1VWZmQTh2d2xnTk1zVU9JYWFN?=
 =?utf-8?B?dVkwYTBQYmd4UGVSOTVDRXJXMFBWWDU5SktEYWVNd3lML1hsOTFZUjF1M0Fi?=
 =?utf-8?B?YkFLZDNRWDdleTNkNHVKYmVaRCt5ZmVPelRZdHBPYjNyZWMvZzBLTFBKM3JO?=
 =?utf-8?B?NjRaQXpLUmFVMGNUL3BNQjBTbFZEeWh2ZU5jOVlQaEJwdXJJbWFIOEx5bXJR?=
 =?utf-8?B?N0NvU0VJK0xtOVNHWlh4THN1Mkx3ZDB3MCtWaVpVSmx5ZkxON1JwYmJBdFZx?=
 =?utf-8?B?QWhRd3NQTDhFdnVZQ1ltc3FMQ1RGWG1CZ0dhRFdTM0FhM25sdzloOW9GTW5R?=
 =?utf-8?B?cUdacStHdGNOWG5ZM0s0VDN4UkZLZmR6bG5aUXlzQWFsTm8rUXhXRGJieWtm?=
 =?utf-8?B?R2pDZ2pEL0xYZWtPN2l6NnhMKzJhWXZtaWNaSW5rWm1pZzY5RUFEN3VOVis4?=
 =?utf-8?B?ZytlZWJYSXE1R0RESFh0d3pGdjZhUnBhL3dBU1QrZU5Wa3YweUZEbVJ0UzFr?=
 =?utf-8?B?TXprRE44RmkwSjljYnhoeXM2RTk2QTUxbDlyNkxnOEh1SWIrZUFaZWZHWmlt?=
 =?utf-8?B?a3psU0ROeStsbW10T3M1dFhacEpveWhiWjhrNVJGTTg5ck5SQlBnYTFVbGN3?=
 =?utf-8?B?VHhmdWdrMmwvUVEzTE96ZXRuTncyQzNqVWtMYlE1Zml6bStqN1l5YUEyNWNW?=
 =?utf-8?B?VElscUMyaVF5TkdHOTBNMWdFWU9uaW1nYjZaRmp2N1lSakVFcFRaTC8xN1Bx?=
 =?utf-8?B?MXBWR1hlUnlVRE8yNVh2RzVLeEpHQUNaUllIRG5MbFZUenVHcmY1OXBFQWZN?=
 =?utf-8?B?YWdZZFFqbXRyWThsT0ViRElJTTE1dnZzdnJLSTRBdE53N1lGcWZ0NlAyWkZH?=
 =?utf-8?B?SzhuNUJBcU1aYmNNcDQxNm9BVjlJeU5LazhhZkxCMFZKSlZZeHpzY21CS3hQ?=
 =?utf-8?B?aTF0cytYelV0TXpBbTFlM0NFbmppSEhKSlVuYW5rL3dSV2l6VHJqWTZvVmJ6?=
 =?utf-8?B?bURZSkx1Szdkc0J0NzVVOEtUdllGTGpqZDBscnBBQVdmODhENmFZRUhGNWZS?=
 =?utf-8?B?d1BMKyt6aVJuY1FCSm04ZW4vQnBHWWo4RlVZL3BuS1prQ1NFemVGZGEyU3ZZ?=
 =?utf-8?B?a0pacmR3T3h6TWFCbU9GWHFiaytNM1RsaWJYMFZyZFErNzI2Rm0xWGtmVWZ0?=
 =?utf-8?B?cjhRQjlMaGs3OURjV21DMmFDQXdqWUVZSzUrcStFdUVuNHdwNDJrU2xyc0NV?=
 =?utf-8?B?Nm5JdGdvZGtjZ2RJTUJoWVNyayt6L2NtYjR2dHVSTVpEV3Nia0Zxd1RrY3dz?=
 =?utf-8?B?ZnNwd1orQzROUS9jMXMxRnZMVkRxKzI1bWNtRWNNVTRpZk9CRTRWZTh6bmFG?=
 =?utf-8?B?Y1hlQU9sU3VJSXZvejQ2R0t4TndGNFpaS241TytwVnlEc3VoSjFkWW9PQmRX?=
 =?utf-8?B?ZlVkQXQvbUVOTUZXb09LUFZhRE5NbjdyNFRiSlg5K01naHhMTWgvd1ljNHd4?=
 =?utf-8?B?Q21RNk43ZUx5QlVnZklnYUdTUnFhOGx3Z2J2MlNvem03V1dyNGtkZmE0R0dU?=
 =?utf-8?B?TXB0MlpwVGppb1JvQW1hRUpVVDNWaXMwaFlwUSsrZTRYNG8rN1dYQ3B6aGpy?=
 =?utf-8?B?cVF2Q2JTcVNJMExpd1p6dnNiNURtTDZTL1V1ODI1N1FuQys0dy9VNHhrMzZu?=
 =?utf-8?B?MjZpZ1FaYzZLNFhhUmFDN0p3TWVFVmIvSytUZEpIQkRIKzR5QkM0Z01SeEYx?=
 =?utf-8?Q?eleUx1a8bWrZQNNrKBqUFxKDc?=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: IA3PR11MB9136.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 4a7d1271-c3aa-4f98-361f-08de0fc0830c
X-MS-Exchange-CrossTenant-originalarrivaltime: 20 Oct 2025 10:07:43.9879 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: creFL4oxXLAJnJuushJV+B5jmW+3KnaTNnNqfP78ykY6bBgcAx/K/bx0IaE3pLAXEcXkT/a6uXXFLO0A7a6s2pww/GmZYoD4GcHfET/3YVA=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MW4PR11MB6763
X-OriginatorOrg: intel.com
Received-SPF: pass client-ip=192.198.163.12;
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
IDxjbGdAcmVkaGF0LmNvbT4NCj5TdWJqZWN0OiBSZTogW1BBVENIIHYyIDcvOF0gdmZpby9taWdy
YXRpb246IEFkZCBtaWdyYXRpb24gYmxvY2tlciBpZiBWTQ0KPm1lbW9yeSBpcyB0b28gbGFyZ2Ug
dG8gY2F1c2UgdW5tYXBfYml0bWFwIGZhaWx1cmUNCj4NCj5PbiAxMC8xNy8yNSAxMDoyMiwgWmhl
bnpob25nIER1YW4gd3JvdGU6DQo+PiBXaXRoIGRlZmF1bHQgY29uZmlnLCBrZXJuZWwgVkZJTyB0
eXBlMSBkcml2ZXIgbGltaXRzIGRpcnR5IGJpdG1hcCB0byAyNTZNQg0KPg0KPg0KPi4uLiBWRklP
IElPTU1VIFR5cGUxIC4uLg0KDQpPSw0KDQo+DQo+PiBmb3IgdW5tYXBfYml0bWFwIGlvY3RsIHNv
IHRoZSBtYXhpbXVtIGd1ZXN0IG1lbW9yeSByZWdpb24gaXMgbm8gbW9yZQ0KPnRoYW4NCj4+IDhU
QiBzaXplIGZvciB0aGUgaW9jdGwgdG8gc3VjY2VlZC4NCj4+DQo+PiBCZSBjb25zZXJ2YXRpdmUg
aGVyZSB0byBsaW1pdCB0b3RhbCBndWVzdCBtZW1vcnkgdG8gOFRCIG9yIGVsc2UgYWRkIGENCj4+
IG1pZ3JhdGlvbiBibG9ja2VyLiBJT01NVUZEIGJhY2tlbmQgZG9lc24ndCBoYXZlIHN1Y2ggbGlt
aXQsIG9uZSBjYW4gdXNlDQo+PiBJT01NVUZEIGJhY2tlZCBkZXZpY2UgaWYgdGhlcmUgaXMgYSBu
ZWVkIHRvIG1pZ3JhdGlvbiBzdWNoIGxhcmdlIFZNLg0KPj4NCj4+IFN1Z2dlc3RlZC1ieTogWWkg
TGl1IDx5aS5sLmxpdUBpbnRlbC5jb20+DQo+PiBTaWduZWQtb2ZmLWJ5OiBaaGVuemhvbmcgRHVh
biA8emhlbnpob25nLmR1YW5AaW50ZWwuY29tPg0KPj4gLS0tDQo+PiAgIGh3L3ZmaW8vbWlncmF0
aW9uLmMgfCAzNyArKysrKysrKysrKysrKysrKysrKysrKysrKysrKysrKysrKysrDQo+PiAgIDEg
ZmlsZSBjaGFuZ2VkLCAzNyBpbnNlcnRpb25zKCspDQo+Pg0KPj4gZGlmZiAtLWdpdCBhL2h3L3Zm
aW8vbWlncmF0aW9uLmMgYi9ody92ZmlvL21pZ3JhdGlvbi5jDQo+PiBpbmRleCA0YzA2ZTNkYjkz
Li4xMTA2Y2E3ODU3IDEwMDY0NA0KPj4gLS0tIGEvaHcvdmZpby9taWdyYXRpb24uYw0KPj4gKysr
IGIvaHcvdmZpby9taWdyYXRpb24uYw0KPj4gQEAgLTE2LDYgKzE2LDcgQEANCj4+ICAgI2luY2x1
ZGUgPHN5cy9pb2N0bC5oPg0KPj4NCj4+ICAgI2luY2x1ZGUgInN5c3RlbS9ydW5zdGF0ZS5oIg0K
Pj4gKyNpbmNsdWRlICJody9ib2FyZHMuaCINCj4+ICAgI2luY2x1ZGUgImh3L3ZmaW8vdmZpby1k
ZXZpY2UuaCINCj4+ICAgI2luY2x1ZGUgImh3L3ZmaW8vdmZpby1taWdyYXRpb24uaCINCj4+ICAg
I2luY2x1ZGUgIm1pZ3JhdGlvbi9taXNjLmgiDQo+PiBAQCAtMTE1Miw2ICsxMTUzLDM1IEBAIHN0
YXRpYyBib29sIHZmaW9fdmlvbW11X3ByZXNldChWRklPRGV2aWNlDQo+KnZiYXNlZGV2KQ0KPj4g
ICAgICAgcmV0dXJuIHZiYXNlZGV2LT5iY29udGFpbmVyLT5zcGFjZS0+YXMgIT0NCj4mYWRkcmVz
c19zcGFjZV9tZW1vcnk7DQo+PiAgIH0NCj4+DQo+PiArc3RhdGljIGJvb2wgdmZpb19kaXJ0eV90
cmFja2luZ19leGNlZWRfbGltaXQoVkZJT0RldmljZSAqdmJhc2VkZXYpDQo+PiArew0KPj4gKyAg
ICBWRklPQ29udGFpbmVyICpiY29udGFpbmVyID0gdmJhc2VkZXYtPmJjb250YWluZXI7DQo+PiAr
ICAgIHVpbnQ2NF90IG1heF9zaXplLCBwYWdlX3NpemU7DQo+PiArDQo+PiArICAgIGlmICghb2Jq
ZWN0X2R5bmFtaWNfY2FzdChPQkpFQ1QoYmNvbnRhaW5lciksDQo+VFlQRV9WRklPX0lPTU1VX0xF
R0FDWSkpIHsNCj4+ICsgICAgICAgIHJldHVybiBmYWxzZTsNCj4+ICsgICAgfQ0KPg0KPg0KPkNv
dWxkIHdlIHNldCBpbiB0aGUgSU9NTVVGRCBiYWNrZW5kICdkaXJ0eV9wZ3NpemVzJyBhbmQNCj4n
bWF4X2RpcnR5X2JpdG1hcF9zaXplJ3RvIGF2b2lkIHRoZSBvYmplY3RfZHluYW1pY19jYXN0KCkg
Pw0KDQpTdXJlLCB3aWxsIGRvLg0KDQpUaGFua3MNClpoZW56aG9uZw0K

