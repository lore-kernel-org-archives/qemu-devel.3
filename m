Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4985BC4345F
	for <qemu-devel@archiver.kernel.org>; Mon, 15 Apr 2024 12:13:13 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rwLCH-0002bv-RP; Mon, 15 Apr 2024 08:12:30 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <zhenzhong.duan@intel.com>)
 id 1rwLCE-0002ay-FI
 for qemu-devel@nongnu.org; Mon, 15 Apr 2024 08:12:26 -0400
Received: from mgamail.intel.com ([198.175.65.19])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <zhenzhong.duan@intel.com>)
 id 1rwLCB-0002u6-Bi
 for qemu-devel@nongnu.org; Mon, 15 Apr 2024 08:12:26 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1713183144; x=1744719144;
 h=from:to:cc:subject:date:message-id:references:
 in-reply-to:content-transfer-encoding:mime-version;
 bh=1X1cT1RI+ZgbWCix6IOm4i+smcYT4dgK5DDSy04IpK8=;
 b=hQHqMIB+5f7KCKHIEM5NH76cQOJaQnW5NS3OF88Saeo+kdgXP962Qc+c
 OmPEB8/bBN+nlh4tcBbzUmNR1EkQw1JkRYdX1r9DXrxxTr+hBh+nllgpV
 CZ1kjEOh4P3FYrcSN6pdnPX/TqYjt3giMz4MNS594rJQF/q7xeTRr4j++
 t11mwRIlTmk3+pypSC+W1FWi/6fzZHrzIxUjDf6vzBa+GiOeSa42Sl0mq
 CwwdUERT5VlSL3aSYG0v7hhs4bpEXBqfz/cpyvZuOioYiGq3wLwreBjKx
 DpyseiLHmffkBs8Mpx4ahf7BMf8i5BbLGOlZTosCtLsWSltkN0VKcum9+ w==;
X-CSE-ConnectionGUID: YEuToE5aRAOmALvp9ENoiw==
X-CSE-MsgGUID: zZZ0hLCESh6bZWJFe7/D3w==
X-IronPort-AV: E=McAfee;i="6600,9927,11044"; a="8438927"
X-IronPort-AV: E=Sophos;i="6.07,203,1708416000"; 
   d="scan'208";a="8438927"
Received: from fmviesa001.fm.intel.com ([10.60.135.141])
 by orvoesa111.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 15 Apr 2024 05:12:20 -0700
X-CSE-ConnectionGUID: TZz7aSB/Qfa0nF8+n52QKw==
X-CSE-MsgGUID: EY6hLX7hTSmkDOxwagP7NA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.07,203,1708416000"; d="scan'208";a="53099159"
Received: from orsmsx602.amr.corp.intel.com ([10.22.229.15])
 by fmviesa001.fm.intel.com with ESMTP/TLS/AES256-GCM-SHA384;
 15 Apr 2024 05:12:19 -0700
Received: from orsmsx612.amr.corp.intel.com (10.22.229.25) by
 ORSMSX602.amr.corp.intel.com (10.22.229.15) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35; Mon, 15 Apr 2024 05:12:19 -0700
Received: from orsmsx610.amr.corp.intel.com (10.22.229.23) by
 ORSMSX612.amr.corp.intel.com (10.22.229.25) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35; Mon, 15 Apr 2024 05:12:18 -0700
Received: from orsedg603.ED.cps.intel.com (10.7.248.4) by
 orsmsx610.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35 via Frontend Transport; Mon, 15 Apr 2024 05:12:18 -0700
Received: from NAM10-DM6-obe.outbound.protection.outlook.com (104.47.58.100)
 by edgegateway.intel.com (134.134.137.100) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.35; Mon, 15 Apr 2024 05:12:18 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=aA/+C8tI05Re6Du3HU8Dr0rSuEetYXXVVt4oJq/sgN83Ry5/vxj+Qxh+vtJxqTZl3wUtxDywaWprMcdVfkqtKjstqFLwGPjnUDQgb6iQMtbLbX8bz5yhYuru1hpEq0LWyG0BsroOwehDalebdbVavqcON2m3tB00Ou8f4QcMstR8/M0uqtq+XgA0PtvsUaBzGV9xhvOjWMlUkfKdQLbX4VBDdSh2X7H4QkH7mUIWa9KaoyphrOz3e3UDqUYVXia3nCJfrGXiq4msVWPKdBOubSPUOyrtoTwW/vvl3ffVKjZgDelEK1AvW4flM9hzq1psWUVKiYraGOTZ1dgoGWxA3g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=1X1cT1RI+ZgbWCix6IOm4i+smcYT4dgK5DDSy04IpK8=;
 b=U2nZ8ByZxN3nEmvfCWbPaj5pWbvUBVGGolOHSJdN1oOSNQ7WSR2AhyKmrpU1CpiyxY5GNPWU7dg9zyFC/k0RidxuLKeXDS/XhckX/zRBoYlA78GOOK274Lu2JpCVRpcBmwAL2umYVKB+dMH3cN97GuNSlbRkBlJ2SOfpgQ/rWOkMFcVuMtLBsnW5vHYTkyOR3hNfeQ4rTfnJFNlnekwSbbiKbSYIFXI3VBaTpyz/S0ySH8lvlFt0+ka+Fn1E2eja8zEvH6wiQFH8AvwrzPJOx9gAt4+ThcAFMOae/RjVoldh+1JS9QsYhAQb4OpSmvoqRbo9r4d4C3R6GUdqqVkPug==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Received: from SJ0PR11MB6744.namprd11.prod.outlook.com (2603:10b6:a03:47d::10)
 by SA1PR11MB8278.namprd11.prod.outlook.com (2603:10b6:806:25b::19)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7452.50; Mon, 15 Apr
 2024 12:12:15 +0000
Received: from SJ0PR11MB6744.namprd11.prod.outlook.com
 ([fe80::e4a3:76ce:879:9129]) by SJ0PR11MB6744.namprd11.prod.outlook.com
 ([fe80::e4a3:76ce:879:9129%7]) with mapi id 15.20.7472.025; Mon, 15 Apr 2024
 12:12:15 +0000
From: "Duan, Zhenzhong" <zhenzhong.duan@intel.com>
To: =?utf-8?B?UGhpbGlwcGUgTWF0aGlldS1EYXVkw6k=?= <philmd@linaro.org>,
 "qemu-devel@nongnu.org" <qemu-devel@nongnu.org>
CC: "alex.williamson@redhat.com" <alex.williamson@redhat.com>,
 "clg@redhat.com" <clg@redhat.com>, "eric.auger@redhat.com"
 <eric.auger@redhat.com>, "peterx@redhat.com" <peterx@redhat.com>,
 "jasowang@redhat.com" <jasowang@redhat.com>, "mst@redhat.com"
 <mst@redhat.com>, "jgg@nvidia.com" <jgg@nvidia.com>, "nicolinc@nvidia.com"
 <nicolinc@nvidia.com>, "joao.m.martins@oracle.com"
 <joao.m.martins@oracle.com>, "Tian, Kevin" <kevin.tian@intel.com>, "Liu, Yi
 L" <yi.l.liu@intel.com>, "Peng, Chao P" <chao.p.peng@intel.com>
Subject: RE: [PATCH v2 02/10] vfio: Introduce HIODLegacyVFIO device
Thread-Topic: [PATCH v2 02/10] vfio: Introduce HIODLegacyVFIO device
Thread-Index: AQHaiYzptKOfpLfFEUmXEx9ocl3VJrFpGQmAgAAK6ZCAABSUgIAAECsA
Date: Mon, 15 Apr 2024 12:12:14 +0000
Message-ID: <SJ0PR11MB67441840B39380FB8C712C7792092@SJ0PR11MB6744.namprd11.prod.outlook.com>
References: <20240408081230.1030078-1-zhenzhong.duan@intel.com>
 <20240408081230.1030078-3-zhenzhong.duan@intel.com>
 <9e71a87e-ad23-4048-bc9a-c26dfafa646c@linaro.org>
 <SJ0PR11MB67448B10E7E9C052417D6C0392092@SJ0PR11MB6744.namprd11.prod.outlook.com>
 <7ffb8e3d-d02e-452f-9ed7-d977b5870a70@linaro.org>
In-Reply-To: <7ffb8e3d-d02e-452f-9ed7-d977b5870a70@linaro.org>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: SJ0PR11MB6744:EE_|SA1PR11MB8278:EE_
x-ms-office365-filtering-correlation-id: 38025aa3-dc20-4a8e-cdaa-08dc5d4549cb
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: xYhYPf5/UnulKpKMg50SdOWCgKaDA8sYPa9ds6ZpSeuYd7EmNwzuhZHswPwtbqHTl94opxxlQXt8hWTQie6NnhyL9kJ/jAhrXnf5h2sC1kMrEmhz1cryRu58k/jkfwd/6MZ8Slo8Ssywx4M/Rdti3EEeDBdHRXE2aCvbKknwLVNLvgMSi0yFB3Lq9fbOprbWpsg8KccFY8iEo5gBx7ux7YEdBN0xvJHdsYaaD3U5/UNXYoI+y7oU2oy1zAu309qfDROGhidlhKsUpfID2Pdob/YqT/+SRZH8Aps84NY2LsAr5wtUMAjnFbb7vBGc23HuIJ93z+JuZNkl24Tj0HFNVjfgdyXu2G+ImkNagH3qe7IVuxBFGfN9TznC1rSSXPrZuEaiWEbGNBg3Bj6G68Crg+rD+unvXEW014eB/D5s01zyqrQAmr7v4ME1L3rGyYHvfXS+AmCzG/x3kMgsSlJB4vu67iF2VbAvxDCIs1eOdbFonKZus7wnYzm1OTb2TBouBrxZlm3lIOzvohHjGyUcSfuSPJXxNCJUTIzFKMtCrWDCwH9t1pWq9qNRxUDE9e+JdzcgrU7LFAxRV56WcyoGakjj9dQ2Hi/dNM5aTVBeNIigIw2jjBjNsSZOgl5Az2B+3xZJ1eQh412XDYjieocSwtG/Mv/qABoKvYufgN/cWAw=
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:SJ0PR11MB6744.namprd11.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230031)(366007)(7416005)(376005)(1800799015)(38070700009); DIR:OUT;
 SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?dldWdTRkL0F6UWVOVTRsYzlFQ0k0b3Zmc2p4dXB4MCtjQm1CTks5cnRZMmho?=
 =?utf-8?B?WmwvZXBrdExWMTErRmZBb01NR2l3ditqdFlTTVdvajRQUEsvZng5ZWtqN2JK?=
 =?utf-8?B?VmwyejljTHBYcXBuOFdTczl0cmtLU1NQVzM3dUhuT09ieWlJR2p2RWFYUTNu?=
 =?utf-8?B?NlBqdmsxaU01aHVtNjJLcHd4czFGdUd0WDErNU10d2l5K2pHdjl6WGlubFR5?=
 =?utf-8?B?eDk1WFpzZzRnNjZsTlBPR0NhWGY4VjJaZEpPUkI1MjIwNmR0V2ZGb1dhUGVV?=
 =?utf-8?B?cWJ5em0xc2swekswRk50Ykd5SVdWRlNvaEo3cDc1WVZZWFZnblVHckNHcXVs?=
 =?utf-8?B?NkFNdGZ2UW9sT0xNSUtwWUFjNjdTNXBmbm5vanN2MkF0NGh1bUgrUVFLWnJ3?=
 =?utf-8?B?bk5DeTFNZENJWndsdXJNeGg0U3hiSFJLVU1lRWJHb2pzbDV6dk93T3RmeUpa?=
 =?utf-8?B?ZEV2RzFpbVJrdWZlekU5UUZmdWlOV3M4Zk5ocGxPUG1yNmwzR0p0NlBCWmFZ?=
 =?utf-8?B?bGZSN2E3bjQya1BQbFZHTUhCR3VQelBVbnNUMm5yMHI2NU93MkdpRUw4UkRF?=
 =?utf-8?B?WEdRV25zUTdHc2YxV1M3YXpIOUlac3ZJUnZqWENMWmlqK2JmQVVYblRiZzNM?=
 =?utf-8?B?c1FGTmNSS2FUZFVCZFdFTUFtYy9sQlVGays5L2xKK3hYQldPUGdDVVI0bC8x?=
 =?utf-8?B?MzFPclVqR2pkcnNYWm1xbEpLekRsSkNaZDhqMVl0Rk9WaTVxdlUyWUZkTWJy?=
 =?utf-8?B?Qm5Kd0xJVGwyK21tUURKOWZIRkRHdkJpVWlGSTJmaTJjQTlURVg0a3htNlV5?=
 =?utf-8?B?cEhiaDRBVGQwOTJxU2hpVmdjeHZLdnBCWUV5SlVwd2V3TGg1aTJGNkVNc0gr?=
 =?utf-8?B?enBCNmlPR3pjUlB6eXc1QjQrNUNsRHBHZUU0M25CNVNWenhhbGF5d3BFR3Vz?=
 =?utf-8?B?Ky9UbmhSSmJEQ1ArUmhNbmIxVEtYWGtjK295ckZ6N0wzMDVidnJuT0MxVVJQ?=
 =?utf-8?B?WDZ1L092NkdRaG1ubzdJQWJZZ25ueGxxdnVyL25oOE4zeGd0ajYyV2RlTU5E?=
 =?utf-8?B?MUg5dENwV1hLcklMOEJHL05Ra3pMbUxIU1Q2M25QSDMwaE5CM0FHR0NCS2pT?=
 =?utf-8?B?UlRWcy9FL1AxK3o3N1g5R21Wa0RFaThRRmdMVEUrdkc0cDhnMEJEQTh0dHlq?=
 =?utf-8?B?am9yUkowOC9SMTNyN0V0N3BrK2owNU1SYW15bUoybnJIYUl0VmM1VjRpZ0h2?=
 =?utf-8?B?U2VTSE9BTHVGeENFdjd6MEFFcldrODE3UWt1ejNyK0RpZXNXaGh3MFhJY1Ix?=
 =?utf-8?B?QlI1UjlhZGJpWlh6bmhKaG95aDNQZHQ4dmd0Y2ZjamoxNWN2SWk5d2xFTlE0?=
 =?utf-8?B?SXhGUkN5UnRYQllzMVlCbkFTOUVqTlIvQklFY0JsaThybHFjOHczSmNETkVJ?=
 =?utf-8?B?MVQrNzNzN3B0WWFFTmxMQU42c00xVGl2MU4rZjVUcTd4ZkF6YTJCTG0vTEJZ?=
 =?utf-8?B?QUs1ZnNpbXpuVHRNeHhtdGxGc0dLdE9Lb2drWlFjeDZXYm14cjl1UDc1YjhJ?=
 =?utf-8?B?QUlVTjdvQUZmUGkyMjF4bEJGUk1xS2xRbGc2OWJxY0NjY3hOUlcrWW5RYld6?=
 =?utf-8?B?YWhYdzBpWElKNWEzbkRWa2RTbUd2ZTZhQkRlUU42N3YvajZtbTNqNFdCd3BR?=
 =?utf-8?B?VXVHWTgxcEt5R0lEU0NXK0I0Ty9iVGRSYktqL2d2YVN2NnVBdFVJRzIrNHhS?=
 =?utf-8?B?M1c5bXB4eE9Bb2lMZkVuWVlrVDVEd1RwU0g3cHhIWkkwdmJMZEhoaEk2OWxF?=
 =?utf-8?B?U1pFV0xXZmkrUDRnbDhWQUN0TmhEVEFjZFd6a0NQeVZWd283RzI3TEE5c2Jy?=
 =?utf-8?B?eG5mZi9NalNjN05LdnlaaXExbW93ZGpkUnVJUmxVeDBrMDBUYlZjbDBEcHZO?=
 =?utf-8?B?d2ZhelU5RkQyMU1uUlN1Z2pkcDY5cDlqY2ZxeElxMUVWNnUrcWpycTc4Z24v?=
 =?utf-8?B?WUFsNElDNkpweW1ibU9IMGNOOWJZa2FEOGNrYkhLVkpLSlBYa1pxTEU4alA4?=
 =?utf-8?B?YlBWbGdwdlcySXh5c3BVZ042NDZVQ00xVExpaG45NXpwallRTS9RbENjZ05i?=
 =?utf-8?Q?mX/Kds4Ow16RfS9s05WovT/iU?=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: SJ0PR11MB6744.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 38025aa3-dc20-4a8e-cdaa-08dc5d4549cb
X-MS-Exchange-CrossTenant-originalarrivaltime: 15 Apr 2024 12:12:14.7491 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 8ktp+odJIJUYLTl5Rjtq90rDWVx1oUrXn2BoOZiGAZKpQKIbCL0cyWAb/jkclszIK309eLsmy6MR8oxOlTsZp4e9nhJ5RMFE1K3GzNyBnLE=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA1PR11MB8278
X-OriginatorOrg: intel.com
Received-SPF: pass client-ip=198.175.65.19;
 envelope-from=zhenzhong.duan@intel.com; helo=mgamail.intel.com
X-Spam_score_int: -49
X-Spam_score: -5.0
X-Spam_bar: -----
X-Spam_report: (-5.0 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-2.185,
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

DQoNCj4tLS0tLU9yaWdpbmFsIE1lc3NhZ2UtLS0tLQ0KPkZyb206IFBoaWxpcHBlIE1hdGhpZXUt
RGF1ZMOpIDxwaGlsbWRAbGluYXJvLm9yZz4NCj5TdWJqZWN0OiBSZTogW1BBVENIIHYyIDAyLzEw
XSB2ZmlvOiBJbnRyb2R1Y2UgSElPRExlZ2FjeVZGSU8gZGV2aWNlDQo+DQo+T24gMTUvNC8yNCAx
MjoxMCwgRHVhbiwgWmhlbnpob25nIHdyb3RlOg0KPj4gSGkgUGhpbGlwcGUsDQo+Pg0KPj4+IC0t
LS0tT3JpZ2luYWwgTWVzc2FnZS0tLS0tDQo+Pj4gRnJvbTogUGhpbGlwcGUgTWF0aGlldS1EYXVk
w6kgPHBoaWxtZEBsaW5hcm8ub3JnPg0KPj4+IFNlbnQ6IE1vbmRheSwgQXByaWwgMTUsIDIwMjQg
NToyMCBQTQ0KPj4+IFRvOiBEdWFuLCBaaGVuemhvbmcgPHpoZW56aG9uZy5kdWFuQGludGVsLmNv
bT47IHFlbXUtDQo+Pj4gZGV2ZWxAbm9uZ251Lm9yZw0KPj4+IENjOiBhbGV4LndpbGxpYW1zb25A
cmVkaGF0LmNvbTsgY2xnQHJlZGhhdC5jb207DQo+ZXJpYy5hdWdlckByZWRoYXQuY29tOw0KPj4+
IHBldGVyeEByZWRoYXQuY29tOyBqYXNvd2FuZ0ByZWRoYXQuY29tOyBtc3RAcmVkaGF0LmNvbTsN
Cj4+PiBqZ2dAbnZpZGlhLmNvbTsgbmljb2xpbmNAbnZpZGlhLmNvbTsgam9hby5tLm1hcnRpbnNA
b3JhY2xlLmNvbTsgVGlhbiwNCj4+PiBLZXZpbiA8a2V2aW4udGlhbkBpbnRlbC5jb20+OyBMaXUs
IFlpIEwgPHlpLmwubGl1QGludGVsLmNvbT47IFBlbmcsIENoYW8gUA0KPj4+IDxjaGFvLnAucGVu
Z0BpbnRlbC5jb20+DQo+Pj4gU3ViamVjdDogUmU6IFtQQVRDSCB2MiAwMi8xMF0gdmZpbzogSW50
cm9kdWNlIEhJT0RMZWdhY3lWRklPIGRldmljZQ0KPj4+DQo+Pj4gT24gOC80LzI0IDEwOjEyLCBa
aGVuemhvbmcgRHVhbiB3cm90ZToNCj4+Pj4gSElPRExlZ2FjeVZGSU8gcmVwcmVzZW50cyBhIGhv
c3QgSU9NTVUgZGV2aWNlIHVuZGVyIFZGSU8gbGVnYWN5DQo+Pj4+IGNvbnRhaW5lciBiYWNrZW5k
Lg0KPj4+Pg0KPj4+PiBJdCBpbmNsdWRlcyBhIGxpbmsgdG8gVkZJT0RldmljZS4NCj4+Pj4NCj4+
Pj4gU3VnZ2VzdGVkLWJ5OiBFcmljIEF1Z2VyIDxlcmljLmF1Z2VyQHJlZGhhdC5jb20+DQo+Pj4+
IFN1Z2dlc3RlZC1ieTogQ8OpZHJpYyBMZSBHb2F0ZXIgPGNsZ0ByZWRoYXQuY29tPg0KPj4+PiBT
aWduZWQtb2ZmLWJ5OiBaaGVuemhvbmcgRHVhbiA8emhlbnpob25nLmR1YW5AaW50ZWwuY29tPg0K
Pj4+PiAtLS0NCj4+Pj4gICAgaW5jbHVkZS9ody92ZmlvL3ZmaW8tY29tbW9uLmggfCAxMSArKysr
KysrKysrKw0KPj4+PiAgICBody92ZmlvL2NvbnRhaW5lci5jICAgICAgICAgICB8IDExICsrKysr
KysrKystDQo+Pj4+ICAgIDIgZmlsZXMgY2hhbmdlZCwgMjEgaW5zZXJ0aW9ucygrKSwgMSBkZWxl
dGlvbigtKQ0KPj4+Pg0KPj4+PiBkaWZmIC0tZ2l0IGEvaW5jbHVkZS9ody92ZmlvL3ZmaW8tY29t
bW9uLmggYi9pbmNsdWRlL2h3L3ZmaW8vdmZpby0NCj4+PiBjb21tb24uaA0KPj4+PiBpbmRleCBi
OWRhNmMwOGVmLi5mMzA3NzJmNTM0IDEwMDY0NA0KPj4+PiAtLS0gYS9pbmNsdWRlL2h3L3ZmaW8v
dmZpby1jb21tb24uaA0KPj4+PiArKysgYi9pbmNsdWRlL2h3L3ZmaW8vdmZpby1jb21tb24uaA0K
Pj4+PiBAQCAtMzEsNiArMzEsNyBAQA0KPj4+PiAgICAjZW5kaWYNCj4+Pj4gICAgI2luY2x1ZGUg
InN5c2VtdS9zeXNlbXUuaCINCj4+Pj4gICAgI2luY2x1ZGUgImh3L3ZmaW8vdmZpby1jb250YWlu
ZXItYmFzZS5oIg0KPj4+PiArI2luY2x1ZGUgInN5c2VtdS9ob3N0X2lvbW11X2RldmljZS5oIg0K
Pj4+Pg0KPj4+PiAgICAjZGVmaW5lIFZGSU9fTVNHX1BSRUZJWCAidmZpbyAlczogIg0KPj4+Pg0K
Pj4+PiBAQCAtMTQ3LDYgKzE0OCwxNiBAQCB0eXBlZGVmIHN0cnVjdCBWRklPR3JvdXAgew0KPj4+
PiAgICAgICAgYm9vbCByYW1fYmxvY2tfZGlzY2FyZF9hbGxvd2VkOw0KPj4+PiAgICB9IFZGSU9H
cm91cDsNCj4+Pj4NCj4+Pj4gKyNkZWZpbmUgVFlQRV9ISU9EX0xFR0FDWV9WRklPIFRZUEVfSE9T
VF9JT01NVV9ERVZJQ0UgIi0NCj5sZWdhY3ktDQo+Pj4gdmZpbyINCj4+Pj4gK09CSkVDVF9ERUNM
QVJFX1NJTVBMRV9UWVBFKEhJT0RMZWdhY3lWRklPLCBISU9EX0xFR0FDWV9WRklPKQ0KPj4+PiAr
DQo+Pj4+ICsvKiBBYnN0cmFjdGlvbiBvZiBWRklPIGxlZ2FjeSBob3N0IElPTU1VIGRldmljZSAq
Lw0KPj4+PiArc3RydWN0IEhJT0RMZWdhY3lWRklPIHsNCj4+Pj4gKyAgICAvKjwgcHJpdmF0ZSA+
Ki8NCj4+Pg0KPj4+IFBsZWFzZSBkcm9wIHRoaXMgY29tbWVudC4NCj4+DQo+PiBXaWxsIGRvLiBC
dXQgbWF5IEkgYXNrIHRoZSBydWxlcyB3aGVuIHRvIHVzZSB0aGF0IGNvbW1lbnQgYW5kIHdoZW4g
bm90Pw0KPg0KPlN1cmUsIHNlZQ0KPmh0dHBzOi8vd3d3LnFlbXUub3JnL2RvY3MvbWFzdGVyL2Rl
dmVsL3N0eWxlLmh0bWwjcWVtdS1vYmplY3QtbW9kZWwtDQo+ZGVjbGFyYXRpb25zDQoNCkxlYXJu
ZWQsIHRoYW5rcyBQaGlsaXBwZS4NCg0KQlJzLg0KWmhlbnpob25nDQo=

