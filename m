Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0A845CD11BF
	for <qemu-devel@archiver.kernel.org>; Wed, 20 Mar 2024 16:05:26 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rmyQb-0008MS-88; Wed, 20 Mar 2024 12:04:33 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <yuan1.liu@intel.com>)
 id 1rmyQZ-0008KZ-5J
 for qemu-devel@nongnu.org; Wed, 20 Mar 2024 12:04:31 -0400
Received: from mgamail.intel.com ([198.175.65.19])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <yuan1.liu@intel.com>)
 id 1rmyQV-0001Il-IH
 for qemu-devel@nongnu.org; Wed, 20 Mar 2024 12:04:30 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1710950667; x=1742486667;
 h=from:to:cc:subject:date:message-id:references:
 in-reply-to:content-transfer-encoding:mime-version;
 bh=cGzlIF4LBIvm8uQePOKF2eZAtkSjgBaFjKNEq+7OWn4=;
 b=Z3Pa4X9cq0XaRCDT7qjR/Q9K33OL9nmicmoc52ZDzGXKy3iEjev2FhAN
 hEiJewcDOHOVfuCTW++s3jYY1ZUw5ulhjsuDGYsq1P9gstRbt9LuRhcBw
 0zrTIO/22Lth+Sl7hWb4ew1Zg89n44++GijMpVczdbhncTYWuIVzomyhU
 uATYL0zDpgQebMc/1VU/5aklszD6Uvx4UB38oSljTA18ompav1XhJloeX
 4tl7yygSSyr0QH16eQ0uCNFgC7vjwfEQcGuNLSzTaPoe8OqcCJrBPVgDE
 scktGsQxNXfhCphGHhtZFylJrE7o2jh+/wF7E9gSwRut6Ve4shblzhkCq w==;
X-IronPort-AV: E=McAfee;i="6600,9927,11019"; a="5758667"
X-IronPort-AV: E=Sophos;i="6.07,140,1708416000"; 
   d="scan'208";a="5758667"
Received: from orviesa005.jf.intel.com ([10.64.159.145])
 by orvoesa111.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 20 Mar 2024 09:04:24 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.07,140,1708416000"; d="scan'208";a="18927498"
Received: from fmsmsx601.amr.corp.intel.com ([10.18.126.81])
 by orviesa005.jf.intel.com with ESMTP/TLS/AES256-GCM-SHA384;
 20 Mar 2024 09:04:24 -0700
Received: from fmsmsx612.amr.corp.intel.com (10.18.126.92) by
 fmsmsx601.amr.corp.intel.com (10.18.126.81) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35; Wed, 20 Mar 2024 09:04:24 -0700
Received: from FMSEDG603.ED.cps.intel.com (10.1.192.133) by
 fmsmsx612.amr.corp.intel.com (10.18.126.92) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35 via Frontend Transport; Wed, 20 Mar 2024 09:04:24 -0700
Received: from NAM12-BN8-obe.outbound.protection.outlook.com (104.47.55.169)
 by edgegateway.intel.com (192.55.55.68) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.35; Wed, 20 Mar 2024 09:04:23 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=j6c7sZqLj3BLdFys30Ik+PURJciWPgg2n9VY1yEDIrsxqMcYPGf+8PkKIGEvojYaxBKxGyVOA0jwT8VspSODIHwbLiEBefnwdl2JUVNJxQwiCMHj8DrP1HMcNxL6SyWNm7mHUR211Ec0gJyIdET632AlmOGdX0rexxC/5GOo0SoJGjxYqb44YbSTTKtpJBqQ+3ZAOBa6BLzaWPwlYQ1PbH6GT4Kct52x9MT2ZVifSc8gk2O2Bjyty5ZAPJZkhXww+dP46c/zNrHWT/YZeynImBpvXT9VUNI4Cud6Cqqhdbu7M8Y012JD1XdvnEe+o+VMEgag2bHFQWyHQC5T7UWEoA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=cGzlIF4LBIvm8uQePOKF2eZAtkSjgBaFjKNEq+7OWn4=;
 b=LB60XS9D0xgIu1nqNL0YJ53Qq711n2qzQREbprn39Xhi8mdy66aENcJtFWjnls1ZipTTh+6uar2avZl23VBRc3tQ/DRTMYggfPck3nVahO/+BjhZLfYWmC4eoi+xD+80LTaOvmJvTH2PRYkNubOhf/3skyIQbrGEcp8XwNsEEUdl3jQX6Fl3Wfcw5sfBdX9lTHSPustIs+Sjov/FH8FS3EdiV96WHpdHnC1cFGrXEamwQ160gMMXQv+/UAKcgpH5Ulx9cvzuiyneonFet1JM1pp0+ykaRi5yE+xA7VOaMDMKpBgqA+1xyl5qu/PSDqmpBA2ITQqkHWyNkOvht59SNg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Received: from PH7PR11MB5941.namprd11.prod.outlook.com (2603:10b6:510:13d::20)
 by CY8PR11MB6913.namprd11.prod.outlook.com (2603:10b6:930:5b::9) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7409.11; Wed, 20 Mar
 2024 16:04:15 +0000
Received: from PH7PR11MB5941.namprd11.prod.outlook.com
 ([fe80::f926:1804:73ce:ca52]) by PH7PR11MB5941.namprd11.prod.outlook.com
 ([fe80::f926:1804:73ce:ca52%4]) with mapi id 15.20.7409.010; Wed, 20 Mar 2024
 16:04:15 +0000
From: "Liu, Yuan1" <yuan1.liu@intel.com>
To: =?utf-8?B?RGFuaWVsIFAuIEJlcnJhbmfDqQ==?= <berrange@redhat.com>
CC: "peterx@redhat.com" <peterx@redhat.com>, "farosas@suse.de"
 <farosas@suse.de>, "qemu-devel@nongnu.org" <qemu-devel@nongnu.org>,
 "hao.xiang@bytedance.com" <hao.xiang@bytedance.com>,
 "bryan.zhang@bytedance.com" <bryan.zhang@bytedance.com>, "Zou, Nanhai"
 <nanhai.zou@intel.com>
Subject: RE: [PATCH v5 5/7] migration/multifd: implement initialization of qpl
 compression
Thread-Topic: [PATCH v5 5/7] migration/multifd: implement initialization of
 qpl compression
Thread-Index: AQHaeqFFcriI4s02jkWbmxh5d6Bh27FAcVgAgABDk6CAAAotgIAACQKw
Date: Wed, 20 Mar 2024 16:04:15 +0000
Message-ID: <PH7PR11MB5941EBFEC3E6831753894A5BA3332@PH7PR11MB5941.namprd11.prod.outlook.com>
References: <20240319164527.1873891-1-yuan1.liu@intel.com>
 <20240319164527.1873891-6-yuan1.liu@intel.com> <Zfq9lBXZWcy3Alhw@redhat.com>
 <PH7PR11MB59410E02C6C7CECD7E30AA4FA3332@PH7PR11MB5941.namprd11.prod.outlook.com>
 <Zfr-zT4eTi64TwiV@redhat.com>
In-Reply-To: <Zfr-zT4eTi64TwiV@redhat.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: PH7PR11MB5941:EE_|CY8PR11MB6913:EE_
x-ms-office365-filtering-correlation-id: 5d68e5e6-0862-48ef-bfa9-08dc48f76413
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: pnE6GIXrbYUUn+dGDsF3I8jEvS/RVJUFTkN4YATSn8qMRG5B6eK521V9M5KZQvI0TbG1qSFugYiL7g7S2rPbMX3jFVXcHBUCWB69IAcalHVTmNEnYv8Fv9kQs1yCPRTzZariMPmR5wr5Mh0k/thAMpLzK//za/QTkMFKVEXTL/U45rhPPgL18NHOdxibEDDxF7Xv6U5VJrzu1ZOvbLtBXLh/JRHjJFMMIcFaVD0P7nKJRsBYuMNaX4QBgoH9zhlD+2vIF+ScBfCakx538PJIX+kWNPSIc6p3XuAyqB2myHTtTgvHVr3q4wpz/aX9jeqEnz98KqjvHYmPZ7IeeBNNZE66nLbb4svSUFW8b5eXDh+cNUvGkM7pS+O3qswouZEvWMzE1FQ/a4qugzDvCwGL0QF+6swNLmU4e0OEWQzaU2V1MnM9AaLCWpSaxXWmS6vwV2e+UGhzwHFNekTfEs6Eh9AwUh6/j/40Ttpw7yB2ToVd5q8SHSaEe5G+OOZbEjF/NY+IVuNc33fh5WJ4Pn8oPJTRcFU98NYnk6r1ohWcQL25Z7kJih+IbgcGWqc4jZ/k0dVvTUHaJDZr03VwRWoA+rnkUhPn/5cJvxeD1YJ1hcTTFkLqO+F8grNWgqV6F/m12ClDIreReRbylDbdb4JpqL9ySD01WQIGD4fwwXAUYSi4sFPj25ga3QuCb0+ZSjTb
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:PH7PR11MB5941.namprd11.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230031)(366007)(1800799015)(376005)(38070700009); DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?NVZQNzd6bmVnV0dscXZJNWkyTmYzamNub3Z2MWVOQ2x6TXlyY3llVVRrUGI1?=
 =?utf-8?B?cTZCUk9UUlFobEZuSTdXMytoT1BnSDNER3BDOFlaTmlsMVd6RkZsUkVUSWlx?=
 =?utf-8?B?dEkyT1phdU5JUXJjK2pXM2d6MnpKdm5mMjhZMDZZWEpiejIxcmZjbVZyQS9O?=
 =?utf-8?B?QmFqQWtlZUdCbHVHcFU4L3N6WThDL2U4enRUWFkrZHBWbnFLL1poRzNQMUhR?=
 =?utf-8?B?NGcrT1Q2d1lnMWh2RWJ5VEkzdDdRS0lRN0hsazZDa2tCVGtjNXpYa3hxS1l6?=
 =?utf-8?B?N3lEYjhVbWUvdmhCRjlVRFppWHl6aHd4OURoK25kRmd2Vk8zdTN5b3ZoMHdM?=
 =?utf-8?B?aFVoVnd4K0RRbUFFdXA1MXJBS1FvQTRNdjRTVHo1T2xoaDloTHo5VVUxdE5U?=
 =?utf-8?B?QjhEZWV5U29PbFNEY3Btb1JUNmQ1MHZHQ1dZdWNvU0VQZzFQaUtsNWJnTlJE?=
 =?utf-8?B?NXpDTjdOOTVkeStud1IzY1g0U1NaWFVNVjJpZlpOQ3pHR3Fsb3ZqQTJFRWlH?=
 =?utf-8?B?MDZTeWZWOVdUdmx4N2tMc21UZE9DSW00VVhWb1g2VWlZWUo1aWp4ZEFUaXEw?=
 =?utf-8?B?ZE15WDM0cWNMWW1xNmRQS2VuTFIrbm84SThkdDJoRm5FeStjQW1haDgrdmNo?=
 =?utf-8?B?S0tlZUtRaEQydHRZZllBUEZpS1JiOWEwblRBTmNpSzJYY0VNaXZkbDdQQlN3?=
 =?utf-8?B?Z3hPRmtPSlJDNHdELzhTTVBEazdaaS9ISlhqSVEvWVdWUmRJOTFwblhkYm9v?=
 =?utf-8?B?RnJIczlmRkdvUkIrMnZHdXc3UTh1bnVXNExLNElUeEVtZFlXeG1uTjVQajlU?=
 =?utf-8?B?ZnVyZDYvdzZzMHc3QkdtNTg1S0FKUk1yelpYclJ1OVJPWXV6QVNQcFdCbHdF?=
 =?utf-8?B?WXJ5MTZ4RXJwY1EvRFlxVlZPcjU0c2RKYnlUclE4Q01vZi9vdjlCRS9NZzdG?=
 =?utf-8?B?S3oxaWFoenFlenFBODBXWnRHajhEUTNXUlRXVW9qbjRmeWVJVVBWdG1haUFC?=
 =?utf-8?B?Wk1nSEZER1BOYmFkaisxYVRHaWk1OWFlZTE4eSs5ci9Lb3E2aThGa0tKdVBF?=
 =?utf-8?B?LzQzSUFXOFVDQVJOS3JxeFkveGZ1ajBqV2h6SUVRVWxCRTVSMWRoYnNtQUI3?=
 =?utf-8?B?cEFlV3JmVllLUzZoaWtuaDJrdzFMRWlWK0FJLzlpOEpxRzg1ckpUN0VzMlZO?=
 =?utf-8?B?bEJ4SmR5V0k5bng0eHNTcXpZeXQ2WVdhOEVzNC91UTZIdHlvdytrRkxCdmFO?=
 =?utf-8?B?bzkxOVNLclJRRFYvdllqek5TSTd4SDdoZkhIZzlpWUtQRGtkNXI1R09QOGlF?=
 =?utf-8?B?dEZKWWIzazJiZndtMXZ4YVRqWFc5T09TTTRGa2VYZGw5Z0xqRVZJS0J5VHVW?=
 =?utf-8?B?enRJanZQQ0Z2MUk2b3BOb2QzcEhUL0laQ1lMbVN1S1VwdG5kQUtQTWw1VlNv?=
 =?utf-8?B?WEhPdjJUN0hIcnUyUkRmYzBOblNydUY0ZFNIbE8vazN0UG9TeXJmNWJlb1BI?=
 =?utf-8?B?V21jN2IwMkEyMU9oZ3BQY2t2MCt5L1VoMGpZSkxjNndqQWJrYU5UM0orTUx2?=
 =?utf-8?B?MjQ0dVRtYnZIUlhKN0gvNEc5QTVnRk1VYW9LYVp1MzhQOG5GRXU5bEtwUE9Y?=
 =?utf-8?B?K3liQjRKZTFiV3lRRk9TM3FuTExjeEo0eG44UzBkenRHRFd2QzhtbVZnNzda?=
 =?utf-8?B?TnFUMXVONlVabm12NHpCZ3dMSVJNT3ROdHBOdjBEeDRLUSt0NlJPQU5xTjZn?=
 =?utf-8?B?RXBvOStjQjZPNGx5aXl1a1RxWE1XRzcrcGxOOEczNkZOb2c5WjVzc1BvZC9y?=
 =?utf-8?B?OUZnSm9qNmFEdTRueVFLZklDQmpta0NiQzFCQS9XV0cvYWdsV1FWMkVsSG9i?=
 =?utf-8?B?K1VkUzJJNEQ3bS91a3dvTDdKRzZ1NnNuYUlaeWpBKzNlSHNQQU9Dc2hud2ds?=
 =?utf-8?B?UW9tL21nYWtXM1FVOVJNSitiZ1phOXJTcjFGbFJ3TlFIa3pwU3IyUmdyNTdC?=
 =?utf-8?B?Mys1YkhVK2RZZ2NMakRCY0owODdXVE9JM3Z0SmY5R0ZrblpnYWtnVXZpNS83?=
 =?utf-8?B?YnBHcEluTitMclI2TmQ0cmhET0hmZjQ0M0dQanFHNXJVTHhEeE9CYjBlSDFX?=
 =?utf-8?Q?LkXVjY5Ktud+LE2p4z4QN6/Nv?=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: PH7PR11MB5941.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 5d68e5e6-0862-48ef-bfa9-08dc48f76413
X-MS-Exchange-CrossTenant-originalarrivaltime: 20 Mar 2024 16:04:15.2741 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: rcVQBbP5WEiSqI/+W9VJZJ5s++bckf0heeKePfC2+ZSZqNRvw/bgPFJEBUcNiBpJ5/o8A6YFiE13s2lNEL8uKQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY8PR11MB6913
X-OriginatorOrg: intel.com
Received-SPF: pass client-ip=198.175.65.19; envelope-from=yuan1.liu@intel.com;
 helo=mgamail.intel.com
X-Spam_score_int: -24
X-Spam_score: -2.5
X-Spam_bar: --
X-Spam_report: (-2.5 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.417,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
 T_SCC_BODY_TEXT_LINE=-0.01 autolearn=ham autolearn_force=no
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

PiAtLS0tLU9yaWdpbmFsIE1lc3NhZ2UtLS0tLQ0KPiBGcm9tOiBEYW5pZWwgUC4gQmVycmFuZ8Op
IDxiZXJyYW5nZUByZWRoYXQuY29tPg0KPiBTZW50OiBXZWRuZXNkYXksIE1hcmNoIDIwLCAyMDI0
IDExOjIxIFBNDQo+IFRvOiBMaXUsIFl1YW4xIDx5dWFuMS5saXVAaW50ZWwuY29tPg0KPiBDYzog
cGV0ZXJ4QHJlZGhhdC5jb207IGZhcm9zYXNAc3VzZS5kZTsgcWVtdS1kZXZlbEBub25nbnUub3Jn
Ow0KPiBoYW8ueGlhbmdAYnl0ZWRhbmNlLmNvbTsgYnJ5YW4uemhhbmdAYnl0ZWRhbmNlLmNvbTsg
Wm91LCBOYW5oYWkNCj4gPG5hbmhhaS56b3VAaW50ZWwuY29tPg0KPiBTdWJqZWN0OiBSZTogW1BB
VENIIHY1IDUvN10gbWlncmF0aW9uL211bHRpZmQ6IGltcGxlbWVudCBpbml0aWFsaXphdGlvbiBv
Zg0KPiBxcGwgY29tcHJlc3Npb24NCj4gDQo+IE9uIFdlZCwgTWFyIDIwLCAyMDI0IGF0IDAzOjAy
OjU5UE0gKzAwMDAsIExpdSwgWXVhbjEgd3JvdGU6DQo+ID4gPiAtLS0tLU9yaWdpbmFsIE1lc3Nh
Z2UtLS0tLQ0KPiA+ID4gRnJvbTogRGFuaWVsIFAuIEJlcnJhbmfDqSA8YmVycmFuZ2VAcmVkaGF0
LmNvbT4NCj4gPiA+IFNlbnQ6IFdlZG5lc2RheSwgTWFyY2ggMjAsIDIwMjQgNjo0MiBQTQ0KPiA+
ID4gVG86IExpdSwgWXVhbjEgPHl1YW4xLmxpdUBpbnRlbC5jb20+DQo+ID4gPiBDYzogcGV0ZXJ4
QHJlZGhhdC5jb207IGZhcm9zYXNAc3VzZS5kZTsgcWVtdS1kZXZlbEBub25nbnUub3JnOw0KPiA+
ID4gaGFvLnhpYW5nQGJ5dGVkYW5jZS5jb207IGJyeWFuLnpoYW5nQGJ5dGVkYW5jZS5jb207IFpv
dSwgTmFuaGFpDQo+ID4gPiA8bmFuaGFpLnpvdUBpbnRlbC5jb20+DQo+ID4gPiBTdWJqZWN0OiBS
ZTogW1BBVENIIHY1IDUvN10gbWlncmF0aW9uL211bHRpZmQ6IGltcGxlbWVudA0KPiBpbml0aWFs
aXphdGlvbiBvZg0KPiA+ID4gcXBsIGNvbXByZXNzaW9uDQo+ID4gPg0KPiA+ID4gT24gV2VkLCBN
YXIgMjAsIDIwMjQgYXQgMTI6NDU6MjVBTSArMDgwMCwgWXVhbiBMaXUgd3JvdGU6DQo+ID4gPiA+
IHRoZSBxcGwgaW5pdGlhbGl6YXRpb24gaW5jbHVkZXMgbWVtb3J5IGFsbG9jYXRpb24gZm9yIGNv
bXByZXNzZWQNCj4gPiA+ID4gZGF0YSBhbmQgdGhlIHFwbCBqb2IgaW5pdGlhbGl6YXRpb24uDQo+
ID4gPiA+DQo+ID4gPiA+IHRoZSBxcGwgaW5pdGlhbGl6YXRpb24gd2lsbCBjaGVjayB3aGV0aGVy
IHRoZSBJbi1NZW1vcnkgQW5hbHl0aWNzDQo+ID4gPiA+IEFjY2VsZXJhdG9yKElBQSkgaGFyZHdh
cmUgaXMgYXZhaWxhYmxlLCBpZiB0aGUgcGxhdGZvcm0gZG9lcyBub3QNCj4gPiA+ID4gaGF2ZSBJ
QUEgaGFyZHdhcmUgb3IgdGhlIElBQSBoYXJkd2FyZSBpcyBub3QgYXZhaWxhYmxlLCB0aGUgUVBM
DQo+ID4gPiA+IGNvbXByZXNzaW9uIGluaXRpYWxpemF0aW9uIHdpbGwgZmFpbC4NCj4gPiA+ID4N
Cj4gPiA+ID4gU2lnbmVkLW9mZi1ieTogWXVhbiBMaXUgPHl1YW4xLmxpdUBpbnRlbC5jb20+DQo+
ID4gPiA+IFJldmlld2VkLWJ5OiBOYW5oYWkgWm91IDxuYW5oYWkuem91QGludGVsLmNvbT4NCj4g
PiA+ID4gLS0tDQo+ID4gPiA+ICBtaWdyYXRpb24vbXVsdGlmZC1xcGwuYyB8IDI0Mw0KPiArKysr
KysrKysrKysrKysrKysrKysrKysrKysrKysrKysrKysrKystDQo+ID4gPiA+ICAxIGZpbGUgY2hh
bmdlZCwgMjQyIGluc2VydGlvbnMoKyksIDEgZGVsZXRpb24oLSkNCj4gPiA+ID4NCj4gPiA+ID4g
ZGlmZiAtLWdpdCBhL21pZ3JhdGlvbi9tdWx0aWZkLXFwbC5jIGIvbWlncmF0aW9uL211bHRpZmQt
cXBsLmMNCj4gPiA+ID4gaW5kZXggMDU2YTY4YTA2MC4uNmRlNjVlOWRhNyAxMDA2NDQNCj4gPiA+
ID4gLS0tIGEvbWlncmF0aW9uL211bHRpZmQtcXBsLmMNCj4gPiA+ID4gKysrIGIvbWlncmF0aW9u
L211bHRpZmQtcXBsLmMNCj4gPiA+ID4gQEAgLTksMTIgKzksMjUzIEBADQo+ID4gPiA+ICAgKiBU
aGlzIHdvcmsgaXMgbGljZW5zZWQgdW5kZXIgdGhlIHRlcm1zIG9mIHRoZSBHTlUgR1BMLCB2ZXJz
aW9uIDINCj4gb3INCj4gPiA+IGxhdGVyLg0KPiA+ID4gPiAgICogU2VlIHRoZSBDT1BZSU5HIGZp
bGUgaW4gdGhlIHRvcC1sZXZlbCBkaXJlY3RvcnkuDQo+ID4gPiA+ICAgKi8NCj4gPiA+ID4gKw0K
PiA+ID4gPiAgI2luY2x1ZGUgInFlbXUvb3NkZXAuaCINCj4gPiA+ID4gICNpbmNsdWRlICJxZW11
L21vZHVsZS5oIg0KPiA+ID4gPiArI2luY2x1ZGUgInFhcGkvZXJyb3IuaCINCj4gPiA+ID4gKyNp
bmNsdWRlICJtaWdyYXRpb24uaCINCj4gPiA+ID4gKyNpbmNsdWRlICJtdWx0aWZkLmgiDQo+ID4g
PiA+ICsjaW5jbHVkZSAicXBsL3FwbC5oIg0KPiA+ID4gPiArDQo+ID4gPiA+ICt0eXBlZGVmIHN0
cnVjdCB7DQo+ID4gPiA+ICsgICAgcXBsX2pvYiAqKmpvYl9hcnJheTsNCj4gPiA+ID4gKyAgICAv
KiB0aGUgbnVtYmVyIG9mIGFsbG9jYXRlZCBqb2JzICovDQo+ID4gPiA+ICsgICAgdWludDMyX3Qg
am9iX251bTsNCj4gPiA+ID4gKyAgICAvKiB0aGUgc2l6ZSBvZiBkYXRhIHByb2Nlc3NlZCBieSBh
IHFwbCBqb2IgKi8NCj4gPiA+ID4gKyAgICB1aW50MzJfdCBkYXRhX3NpemU7DQo+ID4gPiA+ICsg
ICAgLyogY29tcHJlc3NlZCBkYXRhIGJ1ZmZlciAqLw0KPiA+ID4gPiArICAgIHVpbnQ4X3QgKnpi
dWY7DQo+ID4gPiA+ICsgICAgLyogdGhlIGxlbmd0aCBvZiBjb21wcmVzc2VkIGRhdGEgKi8NCj4g
PiA+ID4gKyAgICB1aW50MzJfdCAqemJ1Zl9oZHI7DQo+ID4gPiA+ICt9IFFwbERhdGE7DQo+ID4g
PiA+ICsNCj4gPiA+ID4gK3N0YXRpYyB2b2lkIGZyZWVfemJ1ZihRcGxEYXRhICpxcGwpDQo+ID4g
PiA+ICt7DQo+ID4gPiA+ICsgICAgaWYgKHFwbC0+emJ1ZiAhPSBOVUxMKSB7DQo+ID4gPiA+ICsg
ICAgICAgIG11bm1hcChxcGwtPnpidWYsIHFwbC0+am9iX251bSAqIHFwbC0+ZGF0YV9zaXplKTsN
Cj4gPiA+ID4gKyAgICAgICAgcXBsLT56YnVmID0gTlVMTDsNCj4gPiA+ID4gKyAgICB9DQo+ID4g
PiA+ICsgICAgaWYgKHFwbC0+emJ1Zl9oZHIgIT0gTlVMTCkgew0KPiA+ID4gPiArICAgICAgICBn
X2ZyZWUocXBsLT56YnVmX2hkcik7DQo+ID4gPiA+ICsgICAgICAgIHFwbC0+emJ1Zl9oZHIgPSBO
VUxMOw0KPiA+ID4gPiArICAgIH0NCj4gPiA+ID4gK30NCj4gPiA+ID4gKw0KPiA+ID4gPiArc3Rh
dGljIGludCBhbGxvY196YnVmKFFwbERhdGEgKnFwbCwgdWludDhfdCBjaGFuX2lkLCBFcnJvciAq
KmVycnApDQo+ID4gPiA+ICt7DQo+ID4gPiA+ICsgICAgaW50IGZsYWdzID0gTUFQX1BSSVZBVEUg
fCBNQVBfUE9QVUxBVEUgfCBNQVBfQU5PTllNT1VTOw0KPiA+ID4gPiArICAgIHVpbnQzMl90IHNp
emUgPSBxcGwtPmpvYl9udW0gKiBxcGwtPmRhdGFfc2l6ZTsNCj4gPiA+ID4gKyAgICB1aW50OF90
ICpidWY7DQo+ID4gPiA+ICsNCj4gPiA+ID4gKyAgICBidWYgPSAodWludDhfdCAqKSBtbWFwKE5V
TEwsIHNpemUsIFBST1RfUkVBRCB8IFBST1RfV1JJVEUsDQo+IGZsYWdzLCAtDQo+ID4gPiAxLCAw
KTsNCj4gPiA+ID4gKyAgICBpZiAoYnVmID09IE1BUF9GQUlMRUQpIHsNCj4gPiA+ID4gKyAgICAg
ICAgZXJyb3Jfc2V0ZyhlcnJwLCAibXVsdGlmZDogJXU6IGFsbG9jX3pidWYgZmFpbGVkLCBqb2IN
Cj4gbnVtICV1LA0KPiA+ID4gc2l6ZSAldSIsDQo+ID4gPiA+ICsgICAgICAgICAgICAgICAgICAg
Y2hhbl9pZCwgcXBsLT5qb2JfbnVtLCBxcGwtPmRhdGFfc2l6ZSk7DQo+ID4gPiA+ICsgICAgICAg
IHJldHVybiAtMTsNCj4gPiA+ID4gKyAgICB9DQo+ID4gPg0KPiA+ID4gV2hhdCdzIHRoZSByZWFz
b24gZm9yIHVzaW5nIG1tYXAgaGVyZSwgcmF0aGVyIHRoYW4gYSBub3JtYWwNCj4gPiA+IG1hbGxv
YyA/DQo+ID4NCj4gPiBJIHdhbnQgdG8gcG9wdWxhdGUgdGhlIG1lbW9yeSBhY2Nlc3NlZCBieSB0
aGUgSUFBIGRldmljZSBpbiB0aGUNCj4gaW5pdGlhbGl6YXRpb24NCj4gPiBwaGFzZSwgYW5kIHRo
ZW4gYXZvaWQgaW5pdGlhdGluZyBJL08gcGFnZSBmYXVsdHMgdGhyb3VnaCB0aGUgSUFBIGRldmlj
ZQ0KPiBkdXJpbmcNCj4gPiBtaWdyYXRpb24sIGEgbGFyZ2UgbnVtYmVyIG9mIEkvTyBwYWdlIGZh
dWx0cyBhcmUgbm90IGdvb2QgZm9yDQo+IHBlcmZvcm1hbmNlLg0KPiANCj4gRG9lcyB0aGlzIG1t
YXAgYWN0dWFsbHkgbWFrZSBhIG1lYXN1cmFibGUgZGlmZmVyZW5jZSA/DQo+IA0KPiBJZiBJJ3Zl
IGZvbGxvd2VkIHRoZSBjb2RlIHBhdGhzIGNvcnJlY3RseSwgSSB0aGluayB0aGlzDQo+IGFsbG9j
X3pidWYgbWV0aG9kIG9ubHkgZ2V0cyBjYWxsZWQgZHVyaW5nIGluaXRpYWwgc2V0dXANCj4gb2Yg
ZWFjaCBtaWdyYXRpb24gdGhyZWFkLg0KPiANCj4gU28gdGhpcyB1c2Ugb2YgTUFQX1BPUFVMQVRF
IHNlZW1zIHRvIG9ubHkgbWFrZSBhIGRpZmZlcmVuY2UNCj4gYmV0d2VlbiBmYXVsdGluZyBpbiBi
ZWZvcmUgc3RhcnRpbmcgc2VuZGluZyBkYXRhLCBhbmQgZmF1bHRpbmcNCj4gaW4gb24gZmlyc3Qg
Yml0IG9mIGRhdGEgdGhhdCdzIHNlbnQuIEknbSBzdXJwcmlzZWQgaWYgdGhhdCdzDQo+IG5vdGlj
YWJsZSBhcyBhIGRpZmZlcmVuY2UuDQoNCllvdSBhcmUgcmlnaHQsIHRoZSBwZXJmb3JtYW5jZSBp
bXBhY3QgaXMgb25seSBvbiB0aGUgZmlyc3QgcGFnZSBmYXVsdCANCnByb2Nlc3NpbmcsIGFuZCBo
YXMgbGl0dGxlIGltcGFjdCBvbiB0aGUgb3ZlcmFsbCBsaXZlIG1pZ3JhdGlvbiBwZXJmb3JtYW5j
ZS4NCg0KSSBqdXN0IGRpZCBhIHNpbXBsZSB0ZXN0LiBUaGUgdG90YWwgdGltZSBvZiBsaXZlIG1p
Z3JhdGlvbiB1c2luZyBnX21hbGxvYyBpcw0KMjMyMW1zLCBhbmQgaXQgdGFrZXMgMjA5OG1zIHVz
aW5nIG1tYXAuIEkgbmVlZCBtb3JlIHRlc3RzIHRvIGNoZWNrIGlmIA0KZ19tYWxsb2MvZ19tYWxs
b2MwIGlzIGZlYXNpYmxlLg0KDQo+ID4gVGhpcyBwcm9ibGVtIGFsc28gb2NjdXJzIGF0IHRoZSBk
ZXN0aW5hdGlvbiwgdGhlcmVmb3JlLCBJIHJlY29tbWVuZCB0aGF0DQo+ID4gY3VzdG9tZXJzIG5l
ZWQgdG8gYWRkIC1tZW0tcHJlYWxsb2MgZm9yIGRlc3RpbmF0aW9uIGJvb3QgcGFyYW1ldGVycy4N
Cj4gDQo+IEkgY2FuIHVuZGVyc3RhbmQgbWVtLXByZWxsb2MgbWFraW5nIGEgZGlmZmVyZW5jZSBh
cyB0aGF0IGd1YXJhbnRlZXMNCj4gYWxsIG9mIGd1ZXN0IFJBTSBpcyBmYXVsdGVkIGluLg0KPiAN
Cj4gDQo+IFdpdGggcmVnYXJkcywNCj4gRGFuaWVsDQo+IC0tDQo+IHw6IGh0dHBzOi8vYmVycmFu
Z2UuY29tICAgICAgLW8tDQo+IGh0dHBzOi8vd3d3LmZsaWNrci5jb20vcGhvdG9zL2RiZXJyYW5n
ZSA6fA0KPiB8OiBodHRwczovL2xpYnZpcnQub3JnICAgICAgICAgLW8tDQo+IGh0dHBzOi8vZnN0
b3AxMzguYmVycmFuZ2UuY29tIDp8DQo+IHw6IGh0dHBzOi8vZW50YW5nbGUtcGhvdG8ub3JnICAg
IC1vLQ0KPiBodHRwczovL3d3dy5pbnN0YWdyYW0uY29tL2RiZXJyYW5nZSA6fA0KDQo=

