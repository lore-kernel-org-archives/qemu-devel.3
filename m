Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 881B3C6FD1F
	for <qemu-devel@archiver.kernel.org>; Fri, 29 Mar 2024 03:33:42 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rq2zg-0006CL-26; Thu, 28 Mar 2024 23:33:28 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <yuan1.liu@intel.com>)
 id 1rq2ze-0006CC-Ln
 for qemu-devel@nongnu.org; Thu, 28 Mar 2024 23:33:26 -0400
Received: from mgamail.intel.com ([198.175.65.18])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <yuan1.liu@intel.com>)
 id 1rq2zc-0004Zr-Mj
 for qemu-devel@nongnu.org; Thu, 28 Mar 2024 23:33:26 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1711683204; x=1743219204;
 h=from:to:cc:subject:date:message-id:references:
 in-reply-to:content-transfer-encoding:mime-version;
 bh=DcftQ+2Onb3u+6rdLD/aLRvsG6mEfaG6OHllEitMHeA=;
 b=cO7LHMuKcap3sH8ty+YuvjeBxhhO8Yrhaj+6pHBSeYL/5a6bd4FPKale
 DXng6jCbu7Do34+8p4jx1UoJbNcrFlcv6sdS5mxfItOCccia8AYmVX5Pv
 xcbEkktknJ5+XtrAxIFOWsmntD0aBvPoOBpTKlmOa13thF1KVPjaUOx9w
 W7u1TAe76JqWl7EvmkTaGuimUcdxP9ePKOF6ibJCxgQ9akvWX8JIaUMR8
 KybWrge/F26bJTHAm1qPm0qn9mfliFLht/yLigK8bfVjIeGqJcq2/FBMK
 zWg46UDcy2nVKV/AjztKJzPOrcwAcpR9yQENu43ScCEVtPUVSdfX576xT w==;
X-CSE-ConnectionGUID: uYgSGbx0SeCAmY6g1sIZYQ==
X-CSE-MsgGUID: o2JU+A69Rn+NyIMCVj7D7g==
X-IronPort-AV: E=McAfee;i="6600,9927,11027"; a="6996162"
X-IronPort-AV: E=Sophos;i="6.07,162,1708416000"; 
   d="scan'208";a="6996162"
Received: from orviesa001.jf.intel.com ([10.64.159.141])
 by orvoesa110.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 28 Mar 2024 20:33:20 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.07,162,1708416000"; d="scan'208";a="54319874"
Received: from fmsmsx601.amr.corp.intel.com ([10.18.126.81])
 by orviesa001.jf.intel.com with ESMTP/TLS/AES256-GCM-SHA384;
 28 Mar 2024 20:33:21 -0700
Received: from fmsmsx611.amr.corp.intel.com (10.18.126.91) by
 fmsmsx601.amr.corp.intel.com (10.18.126.81) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35; Thu, 28 Mar 2024 20:33:20 -0700
Received: from fmsedg602.ED.cps.intel.com (10.1.192.136) by
 fmsmsx611.amr.corp.intel.com (10.18.126.91) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35 via Frontend Transport; Thu, 28 Mar 2024 20:33:20 -0700
Received: from NAM11-DM6-obe.outbound.protection.outlook.com (104.47.57.168)
 by edgegateway.intel.com (192.55.55.71) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.35; Thu, 28 Mar 2024 20:33:15 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=NWZW0GAk3kl6w+uQDZmrjFGIa1JW2YVgTAC/haWeRYmTop0TjSd4cRz20IqwAWAFbB+BPaauDUQbRQS7dYLl1a/oRf8T1edjIgWttSHNgYTQsv74Cp5i4tscBldUGnwj6ESKJIE4rb3xc+GIphXVfkn/aigdClDcA+HGjnjY81hXeO6OWsHdTOOys+/BuYf9vZY9w2CRcn+i3pNXofNrWZhAp6xGSLvA6ZDKqEKnqz4MN6GZvj2Ek1w01/KcuDHOuL6U4k1DVSO3CgnVan+3vz3Mch72vlsGWQzZ3YFwT1ZrKc3B4eJXRwU9+jHlYi8pHAxsOBojL2CsXAsVoVIt/A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=DcftQ+2Onb3u+6rdLD/aLRvsG6mEfaG6OHllEitMHeA=;
 b=ZXLZ5zBGOT+0FAFlihnEHPlIJacDBnY+x2xed1tGQATqEc4YnvUIHzA9v/VbHZz6g5LA9cqcsaPKnN3cY/ahnoDLjc1uyOVIKjKy0Kv1a2slnkj4HN2AQzqi34BT7stmDaDX/PRKlWwIZ/JS+2NeqWEWObrWqf/4SufXlUpU4xHjBZdSbBNghm3GLONYQNydKEOiDVdLtr2y0TQeAMhvUTdB3AiD0BaIs6jfeAsXXi53mScJDDoscgpyRpVAWVG+tG5Ji8/6WVf/NWE1VPq2d3T8T7wra/AoJiuxR8aMYB88qX3PK6RuU/02yLOQkdAXczGt1kGLp9pgk5qUf2l8aQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Received: from PH7PR11MB5941.namprd11.prod.outlook.com (2603:10b6:510:13d::20)
 by PH0PR11MB4950.namprd11.prod.outlook.com (2603:10b6:510:33::20)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7409.33; Fri, 29 Mar
 2024 03:33:08 +0000
Received: from PH7PR11MB5941.namprd11.prod.outlook.com
 ([fe80::f926:1804:73ce:ca52]) by PH7PR11MB5941.namprd11.prod.outlook.com
 ([fe80::f926:1804:73ce:ca52%4]) with mapi id 15.20.7409.010; Fri, 29 Mar 2024
 03:33:08 +0000
From: "Liu, Yuan1" <yuan1.liu@intel.com>
To: Peter Xu <peterx@redhat.com>
CC: "farosas@suse.de" <farosas@suse.de>, "qemu-devel@nongnu.org"
 <qemu-devel@nongnu.org>, "hao.xiang@bytedance.com" <hao.xiang@bytedance.com>, 
 "bryan.zhang@bytedance.com" <bryan.zhang@bytedance.com>, "Zou, Nanhai"
 <nanhai.zou@intel.com>
Subject: RE: [PATCH v5 0/7] Live Migration With IAA
Thread-Topic: [PATCH v5 0/7] Live Migration With IAA
Thread-Index: AQHaeqE4PHYZidoXUEu5dKcgevqwZ7FKg30AgABhS5CAASTVgIAAcn2ggADWCACAALUTcA==
Date: Fri, 29 Mar 2024 03:33:08 +0000
Message-ID: <PH7PR11MB5941EFE15486AFCD3B1EB7AEA33A2@PH7PR11MB5941.namprd11.prod.outlook.com>
References: <20240319164527.1873891-1-yuan1.liu@intel.com>
 <ZgMwSO_eRIgXZ24L@x1n>
 <PH7PR11MB5941A91AC1E514BCC32896A6A3342@PH7PR11MB5941.namprd11.prod.outlook.com>
 <ZgR3i5-jc3n2eQA_@x1n>
 <PH7PR11MB59411F5377A4E087D5FEA719A33B2@PH7PR11MB5941.namprd11.prod.outlook.com>
 <ZgWLIJ0U1c0WySio@x1n>
In-Reply-To: <ZgWLIJ0U1c0WySio@x1n>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: PH7PR11MB5941:EE_|PH0PR11MB4950:EE_
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: RlIWDdDy4qFNckchWGv/BSXhStWyciK3nQX2h6H4uDpXGZ8drCLpHM45AShTqMkn8N5vf6jzNvgIefUdRz2i12WyOMSfoXoBNvAEZtPT2XqXjsstwnAbgQYa2H2Zt259ujznIMZ6HAbYkMTv0OqcGt/Ztmk+/b/1T+QOTvlAC0LqyRiydKeJxwb0X8p1sQA4hRT49PBxAqDdXwcRnrxNLNqvtgHEJ5YgSHKcMwxaCMF8BsTYU1p27pDkX5m4LpMV4OBVAPLrRiigc1g1FS3UI/J0Gu4oPS5jNtnHwM54tBxFynO+D1IJKhIbuA63X/uqokReToJzrfCc4UBkjDdC2pR+Cl32Tjn0jep5uGIXm6l1sNTz8HdIkXryMZKeqVLh4ufKltYLfjYdKafJw9C6lBI+e4HbORU9SV1dk9lZ8UMrfRqAOo/WLJlAneM/eVuWdRTFvbb8XihxzmKkJIjtyHRQWtYj16Zwg9UXL/L8xRkjdxm6IAd/ICKaLG2ZyokEITIpiqzverKAkvuL9fUR6lZQNYCjXlW3FyoifCr/Uh1ytu4V22qpmq9HLpSuIPWQ/+8hGu4Grn3j2Y6vG6LJ1WnAWDPC0Ee5VlCtPy/WDFY=
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:PH7PR11MB5941.namprd11.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230031)(366007)(376005)(1800799015); DIR:OUT; SFP:1102; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?QndaalhwNzI1S2IxeVBwbHhXTlJDb3Mvb0hHMXMrVENJTGN3emFPTUMxSTcz?=
 =?utf-8?B?Nmd4MUJGNExFY0hnV3l6cGgvTDFrUVdyOXFGeXFYK04vVEJvMEp5L1Jrenp1?=
 =?utf-8?B?Z0svc2JtNEhvVzZkeElZTm5rcU82NVZxTXpEdTd2K3RJN2pRVkMvTzl0NEpN?=
 =?utf-8?B?R0xwdVlFZCtxcWhRNnFZNTVzdmFSRHZKUnl1U2JIcnJLelc2bit1MkhjWk8w?=
 =?utf-8?B?S241dG96QkZhcU5ZM3F2TURDcVkxNElaTDB3ejd3RDRCQTBGQUFGckdhTThZ?=
 =?utf-8?B?QVh5bXZIMkswSXpvT0k1bXorVDhCZDlXTWxSanRXakJPT1JtWjdwNnc1OXZI?=
 =?utf-8?B?RDdmWVpRUDZzY3ZybmNHRHYrWEppUTJPbzBFQWVvbVRnb0l5NHppRlB0cHpQ?=
 =?utf-8?B?VW1TV2hMd3VjOWVWNlVxc2UxUm9jYVB5cks5dWR0VGN1dVdRQzJjL2g3NlZT?=
 =?utf-8?B?QTZ3ck1tS0RLb3IzNVFvSEdlUzNZYnlFVjZGOGpFMDE0VkxyUjlQWWdRNU1S?=
 =?utf-8?B?bmVvN1hGK1k3Mk1Vait1MGtPcjNxcmNKVUd5MVJBVFVuSERMSHlQSUdzL3Y3?=
 =?utf-8?B?cW0walVrenBCWXZ2ZG93VjZFamFVdHZJaUNwWWR5eldKZE01RW5sZjJNMkt3?=
 =?utf-8?B?M256cFVaS0VobkdUSUwySXh3emQwQml0a2NyVWhFdXFDNng0MDJON21pSWoy?=
 =?utf-8?B?eWFCQkQwY3crWldmZXk1YjVndi91NWV4MEt3MERUSk9YOTgrdFZTaWpkNENG?=
 =?utf-8?B?bG1wQTFnbUlkMU9aSS9SOWhnRzJnRk9lMWpSaXNyRUlkbFAzd1RQbjhFdjhG?=
 =?utf-8?B?aUgzV082dStmNnVvd3JTZWUwSWVReitkcUhha3krbXFyZ25GZXRBVE9mVlVV?=
 =?utf-8?B?N0xYN0RLWjBndzV2MVlmeWY5aktmYkJtTGRGZU8vL1ZlVFRQTGpBTUhCUmY4?=
 =?utf-8?B?Q0hVaStzZjR0WVhqQ2M1dE9nUHRWRkdmWDNMeHpHZk96eEloS0Z4RVVId2VU?=
 =?utf-8?B?YlpXQ2Q4SnRBdm9YajRCMjVVR3BlQmVmY0lKRit4MzdzQXg4dDAxTFhrUHFp?=
 =?utf-8?B?alk4L0VvaW1mZzlYRzVrM3d5SnNzTEFUUmdiQjVEeXZRallSR0Z6MmNsTHhI?=
 =?utf-8?B?R04zdld5Sm1SNDg5ZVk1T3M1SUpIYVNBNTVMNUdpMVdRWEtKNTB1T1ozQUlr?=
 =?utf-8?B?bWNKYVpjYUVpdm1IQ3FDQ280TkdNZkhpZ0xwczQwQ1dtNjJtLzJwMTdpb3cz?=
 =?utf-8?B?S0RlWU5OVURaUmxRV0VvK2VuSnk4SWEzWlpMc2RKSDVhU2FWUkJLN0o5d1ZH?=
 =?utf-8?B?MzYwZGV0dWNpUXJKWUthMTZRU01VMVhLNDdTZTMyVS94TUFET2lFdWtQVGFy?=
 =?utf-8?B?c0xxZmFVT0JTY2VXN3pQWEVWaXpVOUVidGJVK01JZEIxckhwbXRYVFQxYWxP?=
 =?utf-8?B?RW1yU0podjdtL0wrcGN1ZVZhMjBDVHBiODJYOUdvWGlINHZqVFRSb2I2NjZw?=
 =?utf-8?B?Nk9PVnpVeHhCUU5oQjNlRWVhOEg4c2QyQmcxbGJiMGc2ajBXSXBiZ1prNE4z?=
 =?utf-8?B?TWFRVTIzdlJRUEJBam1yK1FDdndyYzFiMnZ3b3NhQ3FhRjZFdzFvclB2M3gv?=
 =?utf-8?B?T0tQOGF3YzBqU29HLzQwNE9ueFNWTEFqUUpuNDM2Qk9WMlRUSVN6Z3RDL0J4?=
 =?utf-8?B?S29oeUh6bEFTanRtNUxVZlg0VGR6bHlrbDNFSGtNU2FUVVdRVm5xYkZMSzhw?=
 =?utf-8?B?a2tDM1FLQ3F6S3FmOGY2QnFsVk1PSS92UTBQMXhJRUc5enk3bzN6dytZa2Zr?=
 =?utf-8?B?dHpra1Z6MmI4T3NaSDE0cEVpVzlTV0tJZCttUVNOLzZEeUpnUDFLVktjcFZu?=
 =?utf-8?B?eE1hdFBibno0UWpZYTZYb3JudCtoZU1sc0hVQVZYVU4vVlNwckR2SjkyMlpn?=
 =?utf-8?B?YUhzRVhqazR6MjczSW9ySEk1TmJBWHgxZTNIN1NGb2lycUZxcEpOZkgvN3dD?=
 =?utf-8?B?OU5GQ3N3eU82dEE1L2dPaGVkTUZmMUZJV1ZOcEFoN2NpR2FNRGl0QjVQM3JN?=
 =?utf-8?B?dFdIdFhUUkdkT051Z1pBejFJdHpnclFqQ2dOUVJ4Q25JU2x3MENLQ283aGg0?=
 =?utf-8?Q?koaTuc0km5sFp1RewBSfbsrqE?=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: PH7PR11MB5941.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: a3a9d109-7bbd-4462-4630-08dc4fa0f3c3
X-MS-Exchange-CrossTenant-originalarrivaltime: 29 Mar 2024 03:33:08.2769 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: rpktjSiI9PfTUdZ3nRTDCCT8OUdHXq3uFNHY7w6RSoeTkw390Xu85PsmlNj/gCDFI/a+in3obVVG0f9uZfk40g==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH0PR11MB4950
X-OriginatorOrg: intel.com
Received-SPF: pass client-ip=198.175.65.18; envelope-from=yuan1.liu@intel.com;
 helo=mgamail.intel.com
X-Spam_score_int: -28
X-Spam_score: -2.9
X-Spam_bar: --
X-Spam_report: (-2.9 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.08,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_LOW=-0.7, SPF_HELO_NONE=0.001,
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

PiAtLS0tLU9yaWdpbmFsIE1lc3NhZ2UtLS0tLQ0KPiBGcm9tOiBQZXRlciBYdSA8cGV0ZXJ4QHJl
ZGhhdC5jb20+DQo+IFNlbnQ6IFRodXJzZGF5LCBNYXJjaCAyOCwgMjAyNCAxMToyMiBQTQ0KPiBU
bzogTGl1LCBZdWFuMSA8eXVhbjEubGl1QGludGVsLmNvbT4NCj4gQ2M6IGZhcm9zYXNAc3VzZS5k
ZTsgcWVtdS1kZXZlbEBub25nbnUub3JnOyBoYW8ueGlhbmdAYnl0ZWRhbmNlLmNvbTsNCj4gYnJ5
YW4uemhhbmdAYnl0ZWRhbmNlLmNvbTsgWm91LCBOYW5oYWkgPG5hbmhhaS56b3VAaW50ZWwuY29t
Pg0KPiBTdWJqZWN0OiBSZTogW1BBVENIIHY1IDAvN10gTGl2ZSBNaWdyYXRpb24gV2l0aCBJQUEN
Cj4gDQo+IE9uIFRodSwgTWFyIDI4LCAyMDI0IGF0IDAzOjAyOjMwQU0gKzAwMDAsIExpdSwgWXVh
bjEgd3JvdGU6DQo+ID4gWWVzLCBJIHdpbGwgc3VwcG9ydCBzb2Z0d2FyZSBmYWxsYmFjayB0byBl
bnN1cmUgQ0kgdGVzdGluZyBhbmQgdXNlcnMgY2FuDQo+ID4gc3RpbGwgdXNlIHFwbCBjb21wcmVz
c2lvbiB3aXRob3V0IElBQSBoYXJkd2FyZS4NCj4gPg0KPiA+IEFsdGhvdWdoIHRoZSBxcGwgc29m
dHdhcmUgc29sdXRpb24gd2lsbCBoYXZlIGJldHRlciBwZXJmb3JtYW5jZSB0aGFuDQo+IHpsaWIs
DQo+ID4gSSBzdGlsbCBkb24ndCB0aGluayBpdCBoYXMgYSBncmVhdGVyIGFkdmFudGFnZSB0aGFu
IHpzdGQuIEkgZG9uJ3QgdGhpbmsNCj4gdGhlcmUNCj4gPiBpcyBhIG5lZWQgdG8gYWRkIGEgbWln
cmF0aW9uIG9wdGlvbiB0byBjb25maWd1cmUgdGhlIHFwbCBzb2Z0d2FyZSBvcg0KPiBoYXJkd2Fy
ZSBwYXRoLg0KPiA+IFNvIEkgd2lsbCBzdGlsbCBvbmx5IHVzZSBRUEwgYXMgYW4gaW5kZXBlbmRl
bnQgY29tcHJlc3Npb24gaW4gdGhlIG5leHQNCj4gdmVyc2lvbiwgYW5kDQo+ID4gbm8gb3RoZXIg
bWlncmF0aW9uIG9wdGlvbnMgYXJlIG5lZWRlZC4NCj4gDQo+IFRoYXQgc2hvdWxkIGJlIGZpbmUu
DQo+IA0KPiA+DQo+ID4gSSB3aWxsIGFsc28gYWRkIGEgZ3VpZGUgdG8gcXBsLWNvbXByZXNzaW9u
LnJzdCBhYm91dCBJQUEgcGVybWlzc2lvbg0KPiBpc3N1ZXMgYW5kIGhvdyB0bw0KPiA+IGRldGVy
bWluZSB3aGV0aGVyIHRoZSBoYXJkd2FyZSBwYXRoIGlzIGF2YWlsYWJsZS4NCj4gDQo+IE9LLg0K
PiANCj4gWy4uLl0NCj4gDQo+ID4gPiA+IFllcywgSSB1c2UgaXBlcmYzIHRvIGNoZWNrIHRoZSBi
YW5kd2lkdGggZm9yIG9uZSBjb3JlLCB0aGUgYmFuZHdpdGgNCj4gaXMNCj4gPiA+IDYwR2Jwcy4N
Cj4gPiA+ID4gWyBJRF0gSW50ZXJ2YWwgICAgICAgICAgIFRyYW5zZmVyICAgICBCaXRyYXRlICAg
ICAgICAgUmV0ciAgQ3duZA0KPiA+ID4gPiBbICA1XSAgIDAuMDAtMS4wMCAgIHNlYyAgNy4wMCBH
Qnl0ZXMgIDYwLjEgR2JpdHMvc2VjICAgIDAgICAyLjg3DQo+IE1CeXRlcw0KPiA+ID4gPiBbICA1
XSAgIDEuMDAtMi4wMCAgIHNlYyAgNy4wNSBHQnl0ZXMgIDYwLjYgR2JpdHMvc2VjICAgIDAgICAy
Ljg3DQo+IE1ieXRlcw0KPiA+ID4gPg0KPiA+ID4gPiBBbmQgaW4gdGhlIGxpdmUgbWlncmF0aW9u
IHRlc3QsIGEgbXVsdGlmZCB0aHJlYWQncyBDUFUgdXRpbGl6YXRpb24NCj4gaXMNCj4gPiA+IGFs
bW9zdCAxMDAlDQo+ID4gPg0KPiA+ID4gVGhpcyA2MEdwYnMgcGVyLWNoYW5uZWwgaXMgZGVmaW5p
dGVseSBpbXByZXNzaXZlLi4NCj4gPiA+DQo+ID4gPiBIYXZlIHlvdSB0cmllZCBtaWdyYXRpb24g
d2l0aG91dCBtdWx0aWZkIG9uIHlvdXIgc3lzdGVtPyBXb3VsZCB0aGF0DQo+IGFsc28NCj4gPiA+
IHBlcmZvcm0gc2ltaWxhcmx5IHYucy4gMiBjaGFubmVscyBtdWx0aWZkPw0KPiA+DQo+ID4gU2lt
cGxlIFRlc3QgcmVzdWx0IGJlbG93Og0KPiA+IFZNIFR5cGU6IDE2dkNQVSwgNjRHIG1lbW9yeQ0K
PiA+IFdvcmtsb2FkIGluIFZNOiBmaWxsIDU2RyBtZW1vcnkgd2l0aCBTaWxlc2lhIGRhdGEgYW5k
IHZDUFVzIGFyZSBpZGxlDQo+ID4gTWlncmF0aW9uIENvbmZpZ3VyYXRpb25zOg0KPiA+IDEuIG1p
Z3JhdGVfc2V0X3BhcmFtZXRlciBtYXgtYmFuZHdpZHRoIDEwMEcNCj4gPiAyLiBtaWdyYXRlX3Nl
dF9wYXJhbWV0ZXIgZG93bnRpbWUtbGltaXQgMzAwDQo+ID4gMy4gbWlncmF0ZV9zZXRfY2FwYWJp
bGl0eSBtdWx0aWZkIG9uIChtdWx0aUZEIHRlc3QgY2FzZSkNCj4gPiA0LiBtaWdyYXRlX3NldF9w
YXJhbWV0ZXIgbXVsdGlmZC1jaGFubmVscyAyIChtdWx0aUZEIHRlc3QgY2FzZSkNCj4gPg0KPiA+
ICAgICAgICAgICAgICAgICAgIFRvdGFsdGltZSAobXMpIERvd250aW1lIChtcykgVGhyb3VnaHB1
dCAobWJwcykgUGFnZXMtDQo+IHBlci1zZWNvbmQNCj4gPiB3aXRob3V0IE11bHRpZmQJMjM1ODAJ
ICAgICAgICAgICAgMzA3CSAgICAgICAgIDIxMjIxCSAgICAgICA2ODk1ODgNCj4gPiBNdWx0aWZk
IDIJICAgICAgIDc2NTcJICAgICAgICAgICAgMTk4CSAgICAgICAgIDY1NDEwCSAgICAgIDIyMjEx
NzYNCj4gDQo+IFRoYW5rcyBmb3IgdGhlIHRlc3QgcmVzdWx0cy4NCj4gDQo+IFNvIEkgYW0gZ3Vl
c3NpbmcgdGhlIG1pZ3JhdGlvbiBvdmVyaGVhZHMgYmVzaWRlcyBwdXNoaW5nIHRoZSBzb2NrZXQg
aXMNCj4gaGlnaA0KPiBlbm91Z2ggdG8gbWFrZSBpdCBkcm9wIGRyYXN0aWNhbGx5LCBldmVuIGlm
IGluIHRoaXMgY2FzZSB6ZXJvIGRldGVjdGlvbg0KPiBzaG91bGRuJ3QgcGxheSBhIG1ham9yIHJv
bGUgY29uc2lkZXJpbmcgbW9zdCBvZiBndWVzdCBtZW0gaXMgcHJlLWZpbGxlZC4NCg0KWWVzLCBm
b3Igbm8gbXVsdGlmZCBtaWdyYXRpb24sIGJlc2lkZXMgdGhlIG5ldHdvcmsgc3RhY2sgb3Zlcmhl
YWQsIHRoZSB6ZXJvDQpwYWdlIGRldGVjdGlvbiBvdmVyaGVhZCAoYm90aCBvZiBzb3VyY2UgYW5k
IGRlc3RpbmF0aW9uKSBpcyBpbmRlZWQgdmVyeSBoaWdoLg0KUGxhY2luZyB0aGUgemVybyBwYWdl
IGRldGVjdGlvbiBpbiBtdWx0aS10aHJlYWRzIGNhbiByZWR1Y2UgdGhlIHBlcmZvcm1hbmNlIA0K
ZGVncmFkYXRpb24gY2F1c2VkIGJ5IHRoZSBvdmVyaGVhZCBvZiB6ZXJvIHBhZ2UgZGV0ZWN0aW9u
Lg0KDQpJIGFsc28gdGhpbmsgbWlncmF0aW9uIGRvZXNuJ3QgbmVlZCB0byBkZXRlY3QgemVybyBw
YWdlIGJ5IG1lbWNtcCBpbiBhbGwgY2FzZXMuDQpUaGUgYmVuZWZpdCBvZiB6ZXJvIHBhZ2UgZGV0
ZWN0aW9uIG1heSBiZSB0aGF0IHRoZSBWTSdzIG1lbW9yeSBkZXRlcm1pbmVzIHRoYXQNCnRoZXJl
IGFyZSBhIGxhcmdlIG51bWJlciBvZiAwIHBhZ2VzLiANCg0KTXkgZXhwZXJpZW5jZSBpbiB0aGlz
IGFyZWEgbWF5IGJlIGluc3VmZmljaWVudCwgSSBhbSB0cnlpbmcgd2l0aCBIYW8gYW5kIEJyeWFu
IHRvDQpzZWUgaWYgaXQgaXMgcG9zc2libGUgdG8gdXNlIERTQSBoYXJkd2FyZSB0byBhY2NlbGVy
YXRlIHRoaXMgcGFydCAoaW5jbHVkaW5nIHBhZ2UgMA0KZGV0ZWN0aW9uIGFuZCB3cml0aW5nIHBh
Z2UgMCkuIA0KDQpEU0EgaXMgYW4gYWNjZWxlcmF0b3IgZm9yIGRldGVjdGluZyBtZW1vcnksIHdy
aXRpbmcgbWVtb3J5LCBhbmQgY29tcGFyaW5nIG1lbW9yeQ0KaHR0cHM6Ly9jZHJkdjItcHVibGlj
LmludGVsLmNvbS82NzExMTYvMzQxMjA0LWludGVsLWRhdGEtc3RyZWFtaW5nLWFjY2VsZXJhdG9y
LXNwZWMucGRmDQo=

