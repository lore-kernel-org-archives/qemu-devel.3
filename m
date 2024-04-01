Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 998FACD128D
	for <qemu-devel@archiver.kernel.org>; Mon,  1 Apr 2024 04:01:30 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rr8qf-0002f6-G7; Mon, 01 Apr 2024 00:00:43 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <zhenzhong.duan@intel.com>)
 id 1rr8q1-0002ck-7V
 for qemu-devel@nongnu.org; Mon, 01 Apr 2024 00:00:01 -0400
Received: from mgamail.intel.com ([198.175.65.13])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <zhenzhong.duan@intel.com>)
 id 1rr8py-0007a8-VS
 for qemu-devel@nongnu.org; Mon, 01 Apr 2024 00:00:00 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1711943999; x=1743479999;
 h=from:to:cc:subject:date:message-id:references:
 in-reply-to:content-transfer-encoding:mime-version;
 bh=YCz8XftVAlhv5wxifmzKTQwO9rfOjw1FkiVb2U4YGwk=;
 b=fU68fJJkCmzA7fyRrABYbnqlVLOSV4Wg7uQ81iXGp8eFrvaT43BUoLl3
 XuLPG/Jpbt/Gd6ZCtuvGwfuOhWMYQVwpGvl6hJFW6KVFxQODM3SqVxcLh
 x163LUC3r3m2eASRy3Qs1jfVcse0oOQnFy79uqW1SPdq8pdvCtX10vK72
 5pIw25jpdn6ncSgVu4TmWLwS2K6KemUziU7L1WYZPBZOEjiPjUpztnkD9
 PyxMea2JQmf5UaIg2nKd+vgtAC8Bcx5dSv9zNRdCbdFT1fP2fGLy/SDKR
 78Yvwq4Q9gXRlQJMSk5+WI9821nPD+wJblntTlJSFMMIFuEdgaJroIHeq Q==;
X-CSE-ConnectionGUID: 4ZDyq8XtRsyDvGwsnQTuIw==
X-CSE-MsgGUID: unRSIJa+QmyI7a3/px+zLg==
X-IronPort-AV: E=McAfee;i="6600,9927,11030"; a="18209445"
X-IronPort-AV: E=Sophos;i="6.07,171,1708416000"; d="scan'208";a="18209445"
Received: from fmviesa007.fm.intel.com ([10.60.135.147])
 by orvoesa105.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 31 Mar 2024 20:59:53 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.07,171,1708416000"; d="scan'208";a="17662888"
Received: from fmsmsx603.amr.corp.intel.com ([10.18.126.83])
 by fmviesa007.fm.intel.com with ESMTP/TLS/AES256-GCM-SHA384;
 31 Mar 2024 20:59:53 -0700
Received: from fmsmsx612.amr.corp.intel.com (10.18.126.92) by
 fmsmsx603.amr.corp.intel.com (10.18.126.83) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35; Sun, 31 Mar 2024 20:59:53 -0700
Received: from fmsmsx612.amr.corp.intel.com (10.18.126.92) by
 fmsmsx612.amr.corp.intel.com (10.18.126.92) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35; Sun, 31 Mar 2024 20:59:52 -0700
Received: from fmsedg601.ED.cps.intel.com (10.1.192.135) by
 fmsmsx612.amr.corp.intel.com (10.18.126.92) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35 via Frontend Transport; Sun, 31 Mar 2024 20:59:52 -0700
Received: from NAM04-DM6-obe.outbound.protection.outlook.com (104.47.73.40) by
 edgegateway.intel.com (192.55.55.70) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.35; Sun, 31 Mar 2024 20:59:48 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=i40dpLr+Ou+FJvnXg6Hr2so7/bnqF5QftkNjXaJlFB4GV5njR9KAMPDwxY9K4yIx6pEXqU6OPOKdkBnVLJ+oyLr3od/BCOX7ngereLhdsO6yOaJk7gI9So3s2MHNI1J9j6CezWlzPRbsZIQ/f1OsY0EVRVAwzfxUonp3lOYwf9b22XbJsIEqakw5h+DpRGrt6Sy/qEJySrHbLsKBspVvzLaJJTPfQXCJ1K+gpCFzqivxpq24wdwkxltumevI/OELh4qnORaGtTqpkiYm8UfGD8uOmSgnvtclO2h1hAVTWA2/x00DckqW76wbGVESwR6QlCJMFWbXhU6cLWxlVqYp6A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=YCz8XftVAlhv5wxifmzKTQwO9rfOjw1FkiVb2U4YGwk=;
 b=NKgdXEDC5jCur/Qh5kz+WQuSz3sp8+t682Eci7M9l7RzlhX+ggGw8C+0mA5L5culPaXkF7i6bCnc9uMLicKPK+q4WJrzGRzxGELfAHOBqe0q4nfdrjeRnDOcsQ5HkObUu4xzxZ7Ysd1OShUryoR5tpn+y4c24/kMhiGBUOxY+LsKU1ClUbMMsoJQRYtcnmXE0eUIzzLKlL5F11KNINy28/MHhxd0DJGY2RLuWokjNSfJiiJq5BzVIWXPLuk2IaxCDm3MBSQGWWvFDpklR2Tmt7gU8/NLXuI30Qo1DlDiBYQ/fCYRbwJl1a07yf9znMwtNW9JhU8KAIkLoSq+hP9LQA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Received: from SJ0PR11MB6744.namprd11.prod.outlook.com (2603:10b6:a03:47d::10)
 by DM4PR11MB6192.namprd11.prod.outlook.com (2603:10b6:8:a9::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7452.22; Mon, 1 Apr
 2024 03:59:42 +0000
Received: from SJ0PR11MB6744.namprd11.prod.outlook.com
 ([fe80::e4a3:76ce:879:9129]) by SJ0PR11MB6744.namprd11.prod.outlook.com
 ([fe80::e4a3:76ce:879:9129%7]) with mapi id 15.20.7452.019; Mon, 1 Apr 2024
 03:59:41 +0000
From: "Duan, Zhenzhong" <zhenzhong.duan@intel.com>
To: =?utf-8?B?Q8OpZHJpYyBMZSBHb2F0ZXI=?= <clg@redhat.com>,
 "qemu-devel@nongnu.org" <qemu-devel@nongnu.org>
CC: "alex.williamson@redhat.com" <alex.williamson@redhat.com>,
 "eric.auger@redhat.com" <eric.auger@redhat.com>, "peterx@redhat.com"
 <peterx@redhat.com>, "jasowang@redhat.com" <jasowang@redhat.com>,
 "mst@redhat.com" <mst@redhat.com>, "jgg@nvidia.com" <jgg@nvidia.com>,
 "nicolinc@nvidia.com" <nicolinc@nvidia.com>, "joao.m.martins@oracle.com"
 <joao.m.martins@oracle.com>, "Tian, Kevin" <kevin.tian@intel.com>, "Liu, Yi
 L" <yi.l.liu@intel.com>, "Sun, Yi Y" <yi.y.sun@intel.com>, "Peng, Chao P"
 <chao.p.peng@intel.com>
Subject: RE: [PATCH v1 01/11] Introduce a common abstract struct
 HostIOMMUDevice
Thread-Topic: [PATCH v1 01/11] Introduce a common abstract struct
 HostIOMMUDevice
Thread-Index: AQHaafrJT1f15ksRNUCyLoL+rga0E7E+15OAgAAJFUCADK2tgIABCXpggAJwN4CAA/XfkA==
Date: Mon, 1 Apr 2024 03:59:41 +0000
Message-ID: <SJ0PR11MB6744D2A5094CA90DB493FC92923F2@SJ0PR11MB6744.namprd11.prod.outlook.com>
References: <20240228035900.1085727-1-zhenzhong.duan@intel.com>
 <20240228035900.1085727-2-zhenzhong.duan@intel.com>
 <e6af68f4-f38d-413f-a63c-d1ae7254d802@redhat.com>
 <SJ0PR11MB674439E1DDE3DDE285571AEE922C2@SJ0PR11MB6744.namprd11.prod.outlook.com>
 <41d50645-9f81-40b1-9ca5-7bb2e73d90de@redhat.com>
 <SJ0PR11MB6744F798CF55CC8FF230CE7B923B2@SJ0PR11MB6744.namprd11.prod.outlook.com>
 <f23012d9-5b63-43c2-9530-31cddf484fcb@redhat.com>
In-Reply-To: <f23012d9-5b63-43c2-9530-31cddf484fcb@redhat.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: SJ0PR11MB6744:EE_|DM4PR11MB6192:EE_
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: NGRJJSQLb0qqAFkZq86mYjGEyu0IDT63kNB2PL524H7Wf+3Lle0XHALIUL/pv14OvqXbdHy6wvFqo+8aDvlg5QcvzNp7BAqpcEY6eKcFVqgBiXwI3rgqet75HwJ9I2QYT7ZkT/OtJo53zzlzfzx4ESZ+f4C7878St6p3HyaOo6CzmEbyQOwbDRpaQ2XaQWYop3Z7GABRs/vlP2KICGeEErKGy02ck3BM2htxHL3NqiZsueqnQ3HnQGhR8GBk5tOziaQvG9iiUYUXdCAb7o+ALMMA/cqAPPlr/+LOb1kDLNgmwyctByra10FVZllcELVQYPd65GpF8srp3y2VKpAa1jwfDkyOxzw/dm7oA0/j5eVGUnNrP9VtpXqrg/nl+6ds5R2D21BWeXFVdNqk527UVMJiQhrf3ZkmKU4JVDR7LfplV6DlFscWXK3ERFVh0xfi+wjLGfbG62OilbPkY6NkmhSCwXq/2XVF8AWSInAri+sMu7s/cAhxX0ll3HvFp+ItqbVYBQ+8mca/f4LuMw8JhoItPZ0J4/hHpM3sWD+k796XHPXr0dScUglGAO7qjLFyjHIo6gKL2t36knzzoH0O3I0xXWBoKV6tBEYtYj3QJWw=
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:SJ0PR11MB6744.namprd11.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230031)(376005)(7416005)(1800799015)(366007); DIR:OUT; SFP:1102; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?a1VPZWowSXRYd2w0cTBNa2VEQ0s4SDg5MHh5U3hyV3BpdjFHWWlnYmozOXg0?=
 =?utf-8?B?bVFBOEdLS0haOWpycmd0ZkFlSHUxNG5WOGM0VTA0TjhHUWs3cXliVmRpWUFa?=
 =?utf-8?B?QUpnN3VzRkVTTjNrcEVZOEhDR1RCUythNmIvTEQwYVFFbW9QdUNtbkUxdUp5?=
 =?utf-8?B?VHZITitNSXorQWFQcDY5eFh0VEZJeXdKMHN4TGFLK01vZzljcEZ3RXlYdXdj?=
 =?utf-8?B?ZU5UR2lFRklvQUYwM0lTTGVRb0JwaHEzbGtYN1luaUFCWlMyTnkrQTZQeXcy?=
 =?utf-8?B?SjNFL01TdmhKV0lYL29pMVpIdGlEQ2NOdVkvUFVQMEhlOGN6WFFoTTM0MEFz?=
 =?utf-8?B?cXFjRkV6UDJCYlRlc1BybklMTDJ0dlZkYkZVZVhWUmh0OTI2V2t4TFlOZDRi?=
 =?utf-8?B?b2RjTGVqSFFFaENQbGVQMndkQ3V5aEJ6bHIvQWIreVNvOWNXN29XdVpkQUZs?=
 =?utf-8?B?YXdlYVpma1lhNkE1NUFjNlFabDRXaVBHYzVoeWRUVjhYR2RnVGxTR24yMXNk?=
 =?utf-8?B?M2t2Ym9yaFZjK3J6TlFkaG5ZK3ZaaWVRU2hJQWpwRmVQY293NnY5QkxacWJR?=
 =?utf-8?B?UHBKcXBrck5BWGZpWDdndGZMNURsREU4ODhLRFRtZEFKelB4V1lRejlKQ05N?=
 =?utf-8?B?d2xwKzNHcFVMV3RRbThYOFc1M1krRTVlZ1pyVGJNOUk2RTkza0J6Skk5ZXdG?=
 =?utf-8?B?K3QrSlQwOW5ocCsrTmNRSldoYmVSQm5FWDByM0VDWDlOS1E0bFQvTGUyaFBJ?=
 =?utf-8?B?bnp4TzBzZDBaNllxSzJPMHlBZGJnTm5ZcktGNVM1L3kwYitUT25OSEZJY2l1?=
 =?utf-8?B?a3ZiSmNQWktQTEt1WXFBWXFwblVjS2swanlYNXBjcy9ReDQwT1ZscTFSektJ?=
 =?utf-8?B?b3o1VGwyb09CUk02VHVxOUxDaEcxOTR2UTg5aDN3dCs1N1dPbUd6eHhmVnRO?=
 =?utf-8?B?K0JaR2U0YWRTWThiQkRWV2FCNHkwWkkzOWlWY0srMWduYXJiaGNaRDg5aFhk?=
 =?utf-8?B?cFZFRjJaMG8vOU93Mk5pdmRhK25uMTVWK25XdWNrUzBBTDZGNGdGNzJ6clNm?=
 =?utf-8?B?WW5pVEJHZXZmd1haUzkxTVh5UEF6bXhieDUrZGtzTmNIRm9kR25DQXpxK1NC?=
 =?utf-8?B?R0xUZStLN3JRbEwzL1ByWVlQTmwvd2liZ04vZi84amlCdE1xaDdZM0VlT3pu?=
 =?utf-8?B?RHI2djRCZkhOR1JyaWNVV0NVOTRrZnFSUmtqQ0djQmdCT0lhWitMNGlMVjJy?=
 =?utf-8?B?clNLTnhSTnh3ZXd6WVRhQ1dkQXQ4Z0tyYm5CRUZpaVBnR1FCSzRSdW5iL0VZ?=
 =?utf-8?B?TkkvR3FzRHY0QzE4cnhWT2tqWE95UENhSEFXOG42biswMFloaGc2QkhPazFU?=
 =?utf-8?B?aXQ3V29QcXVxS0Y2S0NsdHRIc0QrdmQ0VFVCSUtKbkYrNXFMcEI2UEwxWWZT?=
 =?utf-8?B?a0tnRXBmYnd5cE4zSjZJcWJNVHBVS3NOV3hMa21MeGVKaUc3bjhkaHJUeGRt?=
 =?utf-8?B?cHg3MnYydnlNdWJuRFJaekNneTh2VzVxdVAyeWxUOU5GeWJGSmd0SmZCemZV?=
 =?utf-8?B?RmNndEZPRUNwdHNaL2pha2Zic0lzcWZOVE0rYUVYRXUrR1BYOUoweitGbUhP?=
 =?utf-8?B?RGtvNG81L0xqOU1sTDk1ck1KcmdsOWVvb1dPQjdIaFFmWEFoaUlDSzJVOGlj?=
 =?utf-8?B?bTVXOWJGOHlkSFl3VlJ3YmxCeGVkenBjYktqU2x0RUJHTjAva29IRXA3L0N1?=
 =?utf-8?B?bDREL29jSXhNT1BZUUQyRkFuSytIZnZ6ekVhYzFwNUliNTNGYUZpTzA2ZVNY?=
 =?utf-8?B?UCtmencwQ1RCdjRhZDBTQ2ZUK2tDMkJndmpMVS9wclpNYU9SQ2VaNzBpK05u?=
 =?utf-8?B?ZnZhallFK1diaEZwcmExc2Vya1dNMENJQ1ZQZitPMGRsTmZVeTI3eDdBNnUr?=
 =?utf-8?B?K3JCOUkwRk1vVEJKRkI0ZmZlYnc2dDErSVJ4OUdBVWJNMm5WbnhBUGtIeGNZ?=
 =?utf-8?B?RUZDTTlBd2FEQUZ3RnE5YTFmWVpGUlcyczd3ZHRWYklWamZMYmZXOXZHSFow?=
 =?utf-8?B?aGZQejF3Q3JPZVFzY2pqeGFLQy90R21pVlllb1BabHlIRFViRGJVdWFkbVZo?=
 =?utf-8?Q?IPrAMU+m+5RK6QPtwkwUOb96p?=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: SJ0PR11MB6744.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 6c67c3a7-75e6-4255-1175-08dc52002888
X-MS-Exchange-CrossTenant-originalarrivaltime: 01 Apr 2024 03:59:41.2783 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: +JoyQ5N0lm4M1GoaouIoeOMxfaaO8oVYHKEcl1LLK7QY2mWVNZx4caoFcs2oFt7rVyhpoAH9JWcbFyUJhyDCu8eznU/quDajHTLFXOaUhYU=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM4PR11MB6192
X-OriginatorOrg: intel.com
Received-SPF: pass client-ip=198.175.65.13;
 envelope-from=zhenzhong.duan@intel.com; helo=mgamail.intel.com
X-Spam_score_int: -27
X-Spam_score: -2.8
X-Spam_bar: --
X-Spam_report: (-2.8 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
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

DQoNCj4tLS0tLU9yaWdpbmFsIE1lc3NhZ2UtLS0tLQ0KPkZyb206IEPDqWRyaWMgTGUgR29hdGVy
IDxjbGdAcmVkaGF0LmNvbT4NCj5TdWJqZWN0OiBSZTogW1BBVENIIHYxIDAxLzExXSBJbnRyb2R1
Y2UgYSBjb21tb24gYWJzdHJhY3Qgc3RydWN0DQo+SG9zdElPTU1VRGV2aWNlDQo+DQo+SGVsbG8g
Wmhlbnpob25nLA0KPg0KPk9uIDMvMjgvMjQgMDQ6MDYsIER1YW4sIFpoZW56aG9uZyB3cm90ZToN
Cj4+IEhpIEPDqWRyaWMsDQo+Pg0KPj4+IC0tLS0tT3JpZ2luYWwgTWVzc2FnZS0tLS0tDQo+Pj4g
RnJvbTogQ8OpZHJpYyBMZSBHb2F0ZXIgPGNsZ0ByZWRoYXQuY29tPg0KPj4+IFN1YmplY3Q6IFJl
OiBbUEFUQ0ggdjEgMDEvMTFdIEludHJvZHVjZSBhIGNvbW1vbiBhYnN0cmFjdCBzdHJ1Y3QNCj4+
PiBIb3N0SU9NTVVEZXZpY2UNCj4+Pg0KPj4+IEhlbGxvIFpoZW56aG9uZywNCj4+Pg0KPj4+IE9u
IDMvMTkvMjQgMTI6NTgsIER1YW4sIFpoZW56aG9uZyB3cm90ZToNCj4+Pj4gSGkgQ8OpZHJpYywN
Cj4+Pj4NCj4+Pj4+IC0tLS0tT3JpZ2luYWwgTWVzc2FnZS0tLS0tDQo+Pj4+PiBGcm9tOiBDw6lk
cmljIExlIEdvYXRlciA8Y2xnQHJlZGhhdC5jb20+DQo+Pj4+PiBTZW50OiBUdWVzZGF5LCBNYXJj
aCAxOSwgMjAyNCA0OjE3IFBNDQo+Pj4+PiBUbzogRHVhbiwgWmhlbnpob25nIDx6aGVuemhvbmcu
ZHVhbkBpbnRlbC5jb20+OyBxZW11LQ0KPj4+Pj4gZGV2ZWxAbm9uZ251Lm9yZw0KPj4+Pj4gQ2M6
IGFsZXgud2lsbGlhbXNvbkByZWRoYXQuY29tOyBlcmljLmF1Z2VyQHJlZGhhdC5jb207DQo+Pj4+
PiBwZXRlcnhAcmVkaGF0LmNvbTsgamFzb3dhbmdAcmVkaGF0LmNvbTsgbXN0QHJlZGhhdC5jb207
DQo+Pj4+PiBqZ2dAbnZpZGlhLmNvbTsgbmljb2xpbmNAbnZpZGlhLmNvbTsgam9hby5tLm1hcnRp
bnNAb3JhY2xlLmNvbTsNCj5UaWFuLA0KPj4+Pj4gS2V2aW4gPGtldmluLnRpYW5AaW50ZWwuY29t
PjsgTGl1LCBZaSBMIDx5aS5sLmxpdUBpbnRlbC5jb20+OyBTdW4sIFlpIFkNCj4+Pj4+IDx5aS55
LnN1bkBpbnRlbC5jb20+OyBQZW5nLCBDaGFvIFAgPGNoYW8ucC5wZW5nQGludGVsLmNvbT4NCj4+
Pj4+IFN1YmplY3Q6IFJlOiBbUEFUQ0ggdjEgMDEvMTFdIEludHJvZHVjZSBhIGNvbW1vbiBhYnN0
cmFjdCBzdHJ1Y3QNCj4+Pj4+IEhvc3RJT01NVURldmljZQ0KPj4+Pj4NCj4+Pj4+IEhlbGxvIFpo
ZW56aG9uZywNCj4+Pj4+DQo+Pj4+PiBPbiAyLzI4LzI0IDA0OjU4LCBaaGVuemhvbmcgRHVhbiB3
cm90ZToNCj4+Pj4+PiBIb3N0SU9NTVVEZXZpY2Ugd2lsbCBiZSBpbmhlcml0ZWQgYnkgdHdvIHN1
YiBjbGFzc2VzLA0KPj4+Pj4+IGxlZ2FjeSBhbmQgaW9tbXVmZCBjdXJyZW50bHkuDQo+Pj4+Pj4N
Cj4+Pj4+PiBJbnRyb2R1Y2UgYSBoZWxwZXIgZnVuY3Rpb24gaG9zdF9pb21tdV9iYXNlX2Rldmlj
ZV9pbml0IHRvDQo+aW5pdGlhbGl6ZSBpdC4NCj4+Pj4+Pg0KPj4+Pj4+IFN1Z2dlc3RlZC1ieTog
RXJpYyBBdWdlciA8ZXJpYy5hdWdlckByZWRoYXQuY29tPg0KPj4+Pj4+IFNpZ25lZC1vZmYtYnk6
IFpoZW56aG9uZyBEdWFuIDx6aGVuemhvbmcuZHVhbkBpbnRlbC5jb20+DQo+Pj4+Pj4gLS0tDQo+
Pj4+Pj4gICAgIGluY2x1ZGUvc3lzZW11L2hvc3RfaW9tbXVfZGV2aWNlLmggfCAyMg0KPj4+ICsr
KysrKysrKysrKysrKysrKysrKysNCj4+Pj4+PiAgICAgMSBmaWxlIGNoYW5nZWQsIDIyIGluc2Vy
dGlvbnMoKykNCj4+Pj4+PiAgICAgY3JlYXRlIG1vZGUgMTAwNjQ0IGluY2x1ZGUvc3lzZW11L2hv
c3RfaW9tbXVfZGV2aWNlLmgNCj4+Pj4+Pg0KPj4+Pj4+IGRpZmYgLS1naXQgYS9pbmNsdWRlL3N5
c2VtdS9ob3N0X2lvbW11X2RldmljZS5oDQo+Pj4+PiBiL2luY2x1ZGUvc3lzZW11L2hvc3RfaW9t
bXVfZGV2aWNlLmgNCj4+Pj4+PiBuZXcgZmlsZSBtb2RlIDEwMDY0NA0KPj4+Pj4+IGluZGV4IDAw
MDAwMDAwMDAuLmZlODBhYjI1ZmINCj4+Pj4+PiAtLS0gL2Rldi9udWxsDQo+Pj4+Pj4gKysrIGIv
aW5jbHVkZS9zeXNlbXUvaG9zdF9pb21tdV9kZXZpY2UuaA0KPj4+Pj4+IEBAIC0wLDAgKzEsMjIg
QEANCj4+Pj4+PiArI2lmbmRlZiBIT1NUX0lPTU1VX0RFVklDRV9IDQo+Pj4+Pj4gKyNkZWZpbmUg
SE9TVF9JT01NVV9ERVZJQ0VfSA0KPj4+Pj4+ICsNCj4+Pj4+PiArdHlwZWRlZiBlbnVtIEhvc3RJ
T01NVURldmljZV9UeXBlIHsNCj4+Pj4+PiArICAgIEhJRF9MRUdBQ1ksDQo+Pj4+Pj4gKyAgICBI
SURfSU9NTVVGRCwNCj4+Pj4+PiArICAgIEhJRF9NQVgsDQo+Pj4+Pj4gK30gSG9zdElPTU1VRGV2
aWNlX1R5cGU7DQo+Pj4+Pj4gKw0KPj4+Pj4+ICt0eXBlZGVmIHN0cnVjdCBIb3N0SU9NTVVEZXZp
Y2Ugew0KPj4+Pj4+ICsgICAgSG9zdElPTU1VRGV2aWNlX1R5cGUgdHlwZTsNCj4+Pj4+DQo+Pj4+
PiBBIHR5cGUgZmllbGQgaXMgbm90IGEgZ29vZCBzaWduIGFuZCB0aGF0J3Mgd2hlcmUgUU9NIGlz
IHVzZWZ1bC4NCj4+Pj4NCj4+Pj4gWWVzLCBhZ3JlZS4NCj4+Pj4gSSBkaWRuJ3QgY2hvb3NlIFFP
TSBiZWNhdXNlIGluIGlvbW11ZmQtY2RldiBzZXJpZXMsIFZGSU9Db250YWluZXINCj4+PiBjaG9v
c2VzIG5vdCB1c2luZyBRT00gbW9kZWwuDQo+Pj4+IFNlZSB0aGUgZGlzY3Vzc2lvbjoNCj4+PiBo
dHRwczovL2xvcmUua2VybmVsLm9yZy9hbGwvWW11RnYyczVUUHV3N0slMkZ1QHlla2tvLw0KPj4+
PiBJIHRob3VnaHQgSG9zdElPTU1VRGV2aWNlIG5lZWQgdG8gZm9sbG93IHNhbWUgcnVsZS4NCj4+
Pj4NCj4+Pj4gQnV0IGFmdGVyIGZ1cnRoZXIgZGlnZ2luZyBpbnRvIHRoaXMsIEkgdGhpbmsgaXQg
bWF5IGJlIG9rIHRvIHVzZSBRT00NCj5tb2RlbA0KPj4+IGFzIGxvbmcgYXMgd2UgZG9uJ3QgZXhw
b3NlDQo+Pj4+IEhvc3RJT01NVURldmljZSBpbiBxYXBpL3FvbS5qc29uIGFuZCBub3QgdXNlIFVT
RVJfQ1JFQVRBQkxFDQo+Pj4gaW50ZXJmYWNlLiBZb3VyIHRob3VnaHRzPw0KPj4+DQo+Pj4geWVz
LiBDYW4gd2UgY2hhbmdlIGEgYml0IHRoaXMgc2VyaWVzIHRvIHVzZSBRT00gPyBzb21ldGhpbmcg
bGlrZSA6DQo+Pj4NCj4+PiAgICAgIHR5cGVkZWYgc3RydWN0IEhvc3RJT01NVURldmljZSB7DQo+
Pj4gICAgICAgICAgT2JqZWN0IHBhcmVudDsNCj4+PiAgICAgIH0gSG9zdElPTU1VRGV2aWNlOw0K
Pj4+DQo+Pj4gICAgICAjZGVmaW5lIFRZUEVfSE9TVF9JT01NVSAiaG9zdC5pb21tdSINCj4+PiAg
ICAgIE9CSkVDVF9ERUNMQVJFX1RZUEUoSG9zdElPTU1VRGV2aWNlLCBIb3N0SU9NTVVDbGFzcywN
Cj4+PiBIT1NUX0lPTU1VKQ0KPj4+DQo+Pj4gICAgICBzdHJ1Y3QgSG9zdElPTU1VQ2xhc3Mgew0K
Pj4+ICAgICAgICAgIE9iamVjdENsYXNzIHBhcmVudF9jbGFzczsNCj4+Pg0KPj4+ICAgICAgICAg
IGludCAoKmdldF90eXBlKShIb3N0SU9NTVVEZXZpY2UgKmhpb2QsIHVpbnQ2NF90ICp0eXBlLCBF
cnJvcg0KPioqZXJycCk7DQo+Pj4gICAgICAgICAgaW50ICgqZ2V0X2NhcCkoSG9zdElPTU1VRGV2
aWNlICpoaW9kLCB1aW50NjRfdCAqY2FwLCBFcnJvcg0KPioqZXJycCk7DQo+Pj4gICAgICB9Ow0K
Pj4+DQo+Pj4gSW5oZXJpdGVkIG9iamVjdHMgd291bGQgYmUgVFlQRV9IT1NUX0lPTU1VX0lPTU1V
RkQgYW5kDQo+Pj4gVFlQRV9IT1NUX0lPTU1VX0xFR0FDWS4NCj4+PiBFYWNoIGNsYXNzIGltcGxl
bWVudGluZyB0aGUgaGFuZGxlcnMgb3Igbm90IChsZWdhY3kgbW9kZSkuDQo+Pg0KPj4gVW5kZXJz
dG9vZCwgdGhhbmtzIGZvciB5b3VyIGd1aWRlLg0KPj4NCj4+Pg0KPj4+IFRoZSBjbGFzcyBoYW5k
bGVycyBhcmUgaW50cm9kdWNlZCBmb3IgdGhlIGludGVsLWlvbW11IGhlbHBlcg0KPj4+IHZ0ZF9j
aGVja19oZGV2KCkNCj4+PiBpbiBvcmRlciB0byBhdm9pZCB1c2luZyBpb21tdWZkIHJvdXRpbmVz
IGRpcmVjdGx5LiBIb3N0SU9NTVVEZXZpY2UgaXMNCj4+PiBzdXBwb3NlZA0KPj4+IHRvIGFic3Ry
YWN0IHRoZSBIb3N0IElPTU1VIGRldmljZSwgc28gd2UgbmVlZCB0byBhYnN0cmFjdCBhbHNvIGFs
bCB0aGUNCj4+PiBpbnRlcmZhY2VzIHRvIHRoaXMgb2JqZWN0Lg0KPj4NCj4+IEknZCBsaWtlIHRv
IGhhdmUgYSBtaW5pbWFsIGFkanVzdG1lbnQgdG8gY2xhc3MgaGFuZGVycy4gSnVzdCBsZXQgbWUg
a25vdyBpZg0KPnlvdSBoYXZlIHN0cm9uZw0KPj4gcHJlZmVyZW5jZS4NCj4+DQo+PiBDYXAvZWNh
cCBpcyBpbnRlbF9pb21tdSBzcGVjaWZpYywgSSdkIGxpa2UgdG8gbWFrZSBpdCBhIGJpdCBnZW5l
cmljIGFsc28gZm9yDQo+YXJtIHNtbXUgdXNhZ2UsDQo+PiBhbmQgbWVyZ2UgZ2V0X3R5cGUgYW5k
IGdldF9jYXAgaW50byBvbmUgZnVuY3Rpb24gYXMgdGhleSBib3RoIGNhbGxzDQo+aW9jdGwoSU9N
TVVfR0VUX0hXX0lORk8pLA0KPj4gc29tZXRoaW5nIGxpa2U6DQo+PiBnZXRfaW5mbyhIb3N0SU9N
TVVEZXZpY2UgKmhpb2QsIGVudW0gaW9tbXVfaHdfaW5mb190eXBlICp0eXBlLA0KPnZvaWQgKipk
YXRhLCB2b2lkICoqbGVuLCAgRXJyb3IgKiplcnJwKTsNCj4NCj5PSy4gTGV0J3Mgc2VlIGhvdyBp
dCBnb2VzLiBIYXZpbmcgbW9yZSB1c2VycyBvZiB0aGlzIG5ldyBvYmplY3QgSG9zdA0KPklPTU1V
IGRldmljZSBpcyBpbXBvcnRhbnQgdG8gZ2V0IGEgYmV0dGVyIGZlZWxpbmcgb2YgdGhlIGludGVy
ZmFjZS4NCj5BcyBvZiB0b2RheSwgaXQgZG9lc24ndCBoYXZlIG5vdCBtdWNoIHZhbHVlLiBUaGUg
aW9tbXVmZCBvYmplY3QgY291bGQNCj5iZSBRT00gbGlua2VkIHRvIHRoZSB2SU9NTVUgd2hlbiBh
dmFpbGFibGUgYW5kIHdlIGNvdWxkIGdldCB0aGUgYmluZA0KPmRldmlkIGluIHNvbWUgb3RoZXIg
d2F5cyBJIHN1cHBvc2UuIEFueWhvdywgcGxlYXNlIGtlZXAgaXQgc2ltcGxlIGFuZA0KPmxldCdz
IGV4cGxvcmUuDQoNCkdvdCBpdCwgdGhhbmtzIEPDqWRyaWMhDQoNCkJScy4NClpoZW56aG9uZw0K

