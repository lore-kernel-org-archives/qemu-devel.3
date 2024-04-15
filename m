Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 18CB3C4345F
	for <qemu-devel@archiver.kernel.org>; Mon, 15 Apr 2024 09:57:40 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rwJ5X-00023q-It; Mon, 15 Apr 2024 05:57:26 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <zhenzhong.duan@intel.com>)
 id 1rwJ5T-00023F-Ag
 for qemu-devel@nongnu.org; Mon, 15 Apr 2024 05:57:19 -0400
Received: from mgamail.intel.com ([198.175.65.14])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <zhenzhong.duan@intel.com>)
 id 1rwJ5N-0000pE-Qh
 for qemu-devel@nongnu.org; Mon, 15 Apr 2024 05:57:19 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1713175034; x=1744711034;
 h=from:to:cc:subject:date:message-id:references:
 in-reply-to:content-transfer-encoding:mime-version;
 bh=pb+jUBobEZgnAhtcCNDErYLrJSogOoQLisZP4qLQzec=;
 b=PjHv0nUZ7Km89eWoTwzUF53YpP5HnLxwCSI/cQq+lfDxt27KzPj2mseT
 OkZxT9Og9g2Lshp5ma6G2KQgfjLd1nddZCPPIua87DleBJkaN6gEKGVBU
 FzAyLbFyn/8jL4sMpELo+JUO9a96uj2zE2Vb/OgErnZ/57q9vFJa1vrxH
 Rl+GaLF/1b1IrRVEc9x4Q48k4Rjm8C+036Z2PSlTJwlvkQKtcmWFW/ywZ
 y2WjZY9kgCPTDXkUZtxD+mCYaMxBiwXwVu0kLfc8bgdRERNXBwms3CAjz
 w5J2XxyxVXTE+q+AaOinVdjqcKfQqvkT7e3RrQVKEBbsJ26TE0xMAplnO A==;
X-CSE-ConnectionGUID: UoNXSBlcQRm/D5FJshz3xw==
X-CSE-MsgGUID: naBLzuBoRGOPY2hFFDL0MA==
X-IronPort-AV: E=McAfee;i="6600,9927,11044"; a="12401406"
X-IronPort-AV: E=Sophos;i="6.07,202,1708416000"; d="scan'208";a="12401406"
Received: from orviesa004.jf.intel.com ([10.64.159.144])
 by orvoesa106.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 15 Apr 2024 02:57:10 -0700
X-CSE-ConnectionGUID: d/0vx1kBTs2jb6PFeKB+og==
X-CSE-MsgGUID: hJpo66YeTJeFkSsS7TNxLw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.07,202,1708416000"; d="scan'208";a="26656683"
Received: from fmsmsx602.amr.corp.intel.com ([10.18.126.82])
 by orviesa004.jf.intel.com with ESMTP/TLS/AES256-GCM-SHA384;
 15 Apr 2024 02:57:08 -0700
Received: from fmsmsx612.amr.corp.intel.com (10.18.126.92) by
 fmsmsx602.amr.corp.intel.com (10.18.126.82) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35; Mon, 15 Apr 2024 02:57:08 -0700
Received: from FMSEDG603.ED.cps.intel.com (10.1.192.133) by
 fmsmsx612.amr.corp.intel.com (10.18.126.92) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35 via Frontend Transport; Mon, 15 Apr 2024 02:57:08 -0700
Received: from NAM11-CO1-obe.outbound.protection.outlook.com (104.47.56.168)
 by edgegateway.intel.com (192.55.55.68) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.35; Mon, 15 Apr 2024 02:57:07 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Pd5raHKrlZ9S12m1yOy+0B33S3cvFLW+JPNcdFMr+x6QR06CdIxswJM2Gr3exWmVuaUsg8qi8SdvhkltZilRFuUtFsg7IU7XdYyrQlwe1cjbxmWsl4aPF+C28KX3f3mBr7xqJmye47H7jxWjV9I57Hc3gMVdGb222dDs03T9mzAEE1Y/1gthgOeUkohrTupmcJiOkhj5DsjUVKdVr6lEPQ+3grPZHY9KA9lPAbGNLOg29dcH2zGyde92GyycvtJmcNhr0O+w46l2wCi+d09BQyxOztG3i+uArI6uFDBLOuxVGciXttnmSkp0g+X01Z3zf98k0+aVas93ORKVVwxxgw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=pb+jUBobEZgnAhtcCNDErYLrJSogOoQLisZP4qLQzec=;
 b=NGI36f8pWBdpoTylruu08NzgFioFyufMVc5lMwz/Uld9mE5Qf7SlsZ3pYzdTd0XbeuB+rFbzKqnULxWyZnBjtyGTnRrTkV5LAfBOwmTC0m8LjFsBHf9eS9Aw0ZfPiaBD8T8Ua5WhZ2BqPnPu8ozbLL15nE/NroM7eKp6zVzROgwTqE8EMFkHe3CUykmjVPJ75fFswNCtoXckIL0VW2RTdflQIy+42vmZmmXHsKyZOBAYbcYWNLKPbx9UItLkaiC6RA52yoPjtZsXAAWP2qfNY3AzhTqHVKFrANXDhG3YyNN57QxvzSj1B5jq8DmwFkgv2x2aMDp7jYLd3xB+iJSQtQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Received: from SJ0PR11MB6744.namprd11.prod.outlook.com (2603:10b6:a03:47d::10)
 by CYYPR11MB8430.namprd11.prod.outlook.com (2603:10b6:930:c6::19)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7472.25; Mon, 15 Apr
 2024 09:57:05 +0000
Received: from SJ0PR11MB6744.namprd11.prod.outlook.com
 ([fe80::e4a3:76ce:879:9129]) by SJ0PR11MB6744.namprd11.prod.outlook.com
 ([fe80::e4a3:76ce:879:9129%7]) with mapi id 15.20.7472.025; Mon, 15 Apr 2024
 09:57:05 +0000
From: "Duan, Zhenzhong" <zhenzhong.duan@intel.com>
To: =?utf-8?B?Q8OpZHJpYyBMZSBHb2F0ZXI=?= <clg@redhat.com>,
 "qemu-devel@nongnu.org" <qemu-devel@nongnu.org>
CC: "alex.williamson@redhat.com" <alex.williamson@redhat.com>,
 "eric.auger@redhat.com" <eric.auger@redhat.com>, "peterx@redhat.com"
 <peterx@redhat.com>, "jasowang@redhat.com" <jasowang@redhat.com>,
 "mst@redhat.com" <mst@redhat.com>, "jgg@nvidia.com" <jgg@nvidia.com>,
 "nicolinc@nvidia.com" <nicolinc@nvidia.com>, "joao.m.martins@oracle.com"
 <joao.m.martins@oracle.com>, "Tian, Kevin" <kevin.tian@intel.com>, "Liu, Yi
 L" <yi.l.liu@intel.com>, "Peng, Chao P" <chao.p.peng@intel.com>, "Paolo
 Bonzini" <pbonzini@redhat.com>
Subject: RE: [PATCH v2 01/10] backends: Introduce abstract HostIOMMUDevice
Thread-Topic: [PATCH v2 01/10] backends: Introduce abstract HostIOMMUDevice
Thread-Index: AQHaiYzk06tnPwLhp0Oyp2E1dvnOG7FpBVUAgAAdJVA=
Date: Mon, 15 Apr 2024 09:57:05 +0000
Message-ID: <SJ0PR11MB674416AF486B62DDF7354ED092092@SJ0PR11MB6744.namprd11.prod.outlook.com>
References: <20240408081230.1030078-1-zhenzhong.duan@intel.com>
 <20240408081230.1030078-2-zhenzhong.duan@intel.com>
 <677ab8a4-0d64-4a55-bb46-4ee5a5a1c543@redhat.com>
In-Reply-To: <677ab8a4-0d64-4a55-bb46-4ee5a5a1c543@redhat.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: SJ0PR11MB6744:EE_|CYYPR11MB8430:EE_
x-ms-office365-filtering-correlation-id: 7d199bb3-6b0e-43c6-c104-08dc5d32682f
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: z0xC98ojPr4MVQX+LqMJ8DkabS9sGfuLAshmMRhHjWDFSX77oHCwtJLfNNXUL+ilG/ZAR0a7atuQJBHYzA3zJd4Lp4u1GGPwzcvfRu0Th6D/MfzymqQM4wNW8sDK7rUF3joJjVdfIFYMQApVISmFhZvm5yur6XDyyiEz6fN7TsJL1bovA6jrDbiNGYBmDTbxSequAGRdIawFCMYLIgTG1MY0AuiNk9rM5cc0qbJ7v4FhstiE+WGHbjXA5AMhouuBtRCZcN3vU797gMigHabEsPMuZ9NS7TRTYXxFpso/Qp2Nn/YgKLuF7U2GsX6oyWXzP7cDAMnd3Vt+dEr+Ay7SAcp/q5LYkMt5hhsS86gWJIhtNon4ctnLyxyCcaRpsQOViNKZnBEXLiPwiEW9ALpvO0t5ClzhUnzOXkOiRu1zjtqrrc8HibAKEen41z9/4P1VJEyrjMF4QJFEouIDExuayEPv4LR4Y5lQ3BuUfsiC/q7SS01BtnzseanEKpFcCAXF0HGwOQWtB2oWhwv2AO9j4boixfmCYPuc57lHgZ8pI2asqxYDpGYUMHHm5lEXfDU00z2hZavi0A7R7xYeOgevO6ZzG1YzuXMWOtN+i3hkRsH5lf00Y+ioRi/hKbj84IsXNJbjoLAhr9ylWmrYdjXe/2gOGM/MpNJ+NYj0yXELT5LQxuKPnLjxPOK8r2Yn6xtETmpbBnTg0ddBHkewg907oAFSlrUHCnxhIjphOnZVYgs=
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:SJ0PR11MB6744.namprd11.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230031)(1800799015)(366007)(7416005)(376005)(38070700009); DIR:OUT;
 SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?aXRPMUpOeVF5U1N1K1pOdE1vUzdnYU5sdkFzbDRLZVhjcE1lem5wOFhNRUp1?=
 =?utf-8?B?TjlHWkY4eEVDU3ovbHpKNGZ6ZlRydTJVMHRHNEtUQkljNlBKcXRxaDVrd0E1?=
 =?utf-8?B?M3h5eHdVOXZFUkFuWkNsbHluN1I1THNZdnI3czJPUTF3cEM1dFJ4ZVphK0Jp?=
 =?utf-8?B?dTRsMitVVWIwRWlXUitCVERXUDZ0a2hyUVhaVDJibXdyMEhzalRERWpZMm1N?=
 =?utf-8?B?SEJCMUJSU25GOUlIVGwrL3dVN1lnT3I3aUVVMWdheFRhZEdYMGdyWldKRkxH?=
 =?utf-8?B?UEo2YVQxNFFOaGZieTdnRVdybDREc040TU8zb0pvcEVYdWg2Sm04Y1ZNbm1r?=
 =?utf-8?B?UHdnd2tIc25ibDl0U1AvTThzWFlrMDJFZTI3VUhmb044amdZWnNqaFBaTTQv?=
 =?utf-8?B?aHliV1p4TDFtZU15VzdQK3VmbTAyL0xhakNrQVphNGcvVi9ZTytTOGV2TW1N?=
 =?utf-8?B?TG0rYUVnblRoUERIV1B6L0d2aXN1d2k2MU53aXhxckg0bGcxM25pemgrZVBs?=
 =?utf-8?B?a3d6UmYxcjZCMHJGOEJJVzZhUm1HeHN2WmFxeitWY1RoY0pPWGVsT1Vac3Ev?=
 =?utf-8?B?c3oxSmc3Tm1GY1hqeEhENjd2TEZIaW1FVStaTFd1SDBBOWNKdkRzU05nN3Vi?=
 =?utf-8?B?eXBYdTJBaUkrL0FQSEh2ZGZySyszNGR6bDhIdXlDSVdLaldLOE11VlhHSzVi?=
 =?utf-8?B?d3hNeWxqVW5ZQWt6N2RJU0prSzdsVy9FNWp5QldKWGtOenJXUzgrRDA4NUdI?=
 =?utf-8?B?VHdDTk53MEQ1THNzL1Y3WWs0ZVF0TDRsSmlRc3BDTnNhYmJZa1ZnbDhJQ3Vj?=
 =?utf-8?B?U1NUMXBNdzdxWkMvaE12anZYbG9keFVmaVJIK1NJREpqRGxCOVg0OVBRWHpS?=
 =?utf-8?B?NkFMS3NvMy9OdGplRW9wU0VRaTJJVloxTThsOUFoNWxTa2NQU1EwbmxQSjll?=
 =?utf-8?B?ODBsTnRoSS9RNVFTV2c4T2F2R0NRdXVHSkRVeG9nck14Y0liMDZxaWQyZ0d5?=
 =?utf-8?B?V2NYeXNNMGNMeHpsMkJtSXdMYU1oS1ZWbGRnZC8rZWo3UjdLWUI2ZVk5S3N1?=
 =?utf-8?B?SldXNkc0NmY4L2swbzZRdWdtNWdsYXF1ZTF0UE5DNXN2eDV6OE5xOW5zZ1VP?=
 =?utf-8?B?c2lZQk53dElSV043Q3c1L29vV0ZHUVJEUDNlQkV0N1hBVFJQWWlmTC9tYUhB?=
 =?utf-8?B?ZmJ4YTFiMkpkRkxsczNtajFoZDB1Zzc4dW1LeTlnVjdXbmZrTEVpV3pNUVk2?=
 =?utf-8?B?d2k1WlVVTzFiTGtUS2tMQzBJK0EvOVpMTmFzQ1pCemsya1cxcTM3cXJTVzlT?=
 =?utf-8?B?REQwaExkU2h6L21Cd01yUE1VaHF4TGZPMlN4N20xdFdYYXhwQ1RvbWpGM2dE?=
 =?utf-8?B?am9Ydk5VZlc5OW1sZ1JPS2dLQ3JnUU52ZG1UR1N2Uk9pb3NOUVRJTS9aZEZU?=
 =?utf-8?B?czB0UXRvRWY1SHU2TWM1SWNESjVjaTlUZkkvVmczWG85WUU0VDJWWXc0NGV4?=
 =?utf-8?B?ZFhDR080OUJyRUlCajBBVFZpZzREOUFIb2RzVXFGU1NKWXZpQVp1bFFIdWp6?=
 =?utf-8?B?dmI0QnJtT3AwY2F2UmhjbEUrUFk2dGQzMzgzMjFMK1o1QW9RTWRvZmxFYksw?=
 =?utf-8?B?ZEd3SDdOeEhYNzJuY29EbSsvK1FxM3BtamNibmlDRWFuMDNFRkR0eGovdzNM?=
 =?utf-8?B?bFZWZ1Jnc204TDZ6NXVuTHlzSFErR2p0YmJRRWhzS1RJWk9JaDhBcmg3ZGFQ?=
 =?utf-8?B?T0dpS0puYVBiN3RqRWFZT1RuYXdJd1B1NDU3VEkvUndjM3IyeVFXQ3J1cFgz?=
 =?utf-8?B?RHVGcDZ2dDB3UERqbGN6TkdhQzlDdjBIWkF0VkZoQTRqc0VzelJVcjRYRFMx?=
 =?utf-8?B?RndGOTBzWG1YcXMwaUpVdFIyV25QM3NYa1NFTUo2Q1NoNjVadE5DczJ3MXdW?=
 =?utf-8?B?QWRqbWFMMlFYK2ZjdEFaRldReTZkaTVGM3ErZVAzU2tqUThFa05uYUMxZ002?=
 =?utf-8?B?NVR4amVBVE1ESWpPdGlsSVplK09vV2VpOUxka1ByRTN5U2ZCRTJDZ21pUUx2?=
 =?utf-8?B?NjVWWkhqNW9MRmkyNGhQTkF4QTBqSzI4eFVPYVhIQVZETmczdGtLTDFRTzFu?=
 =?utf-8?Q?LRdGe/aY1ze2lo0f4iuG6GOp5?=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: SJ0PR11MB6744.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 7d199bb3-6b0e-43c6-c104-08dc5d32682f
X-MS-Exchange-CrossTenant-originalarrivaltime: 15 Apr 2024 09:57:05.7071 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: FC2OpJzIgc8CfymTNe4/6hb0zg1juN3NLJQi9NKWnS2oUn8/1zQB8qNJg1UO6Qo2p4wMbSLYLHulUHwRgChMgbyFgeLDXPJQDCGIURJdPyQ=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CYYPR11MB8430
X-OriginatorOrg: intel.com
Received-SPF: pass client-ip=198.175.65.14;
 envelope-from=zhenzhong.duan@intel.com; helo=mgamail.intel.com
X-Spam_score_int: -48
X-Spam_score: -4.9
X-Spam_bar: ----
X-Spam_report: (-4.9 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-2.127,
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
IDxjbGdAcmVkaGF0LmNvbT4NCj5TdWJqZWN0OiBSZTogW1BBVENIIHYyIDAxLzEwXSBiYWNrZW5k
czogSW50cm9kdWNlIGFic3RyYWN0DQo+SG9zdElPTU1VRGV2aWNlDQo+DQo+T24gNC84LzI0IDEw
OjEyLCBaaGVuemhvbmcgRHVhbiB3cm90ZToNCj4+IEludHJvZHVjZSBIb3N0SU9NTVVEZXZpY2Ug
YXMgYW4gYWJzdHJhY3Rpb24gb2YgaG9zdCBJT01NVSBkZXZpY2UuDQo+Pg0KPj4gZ2V0X2hvc3Rf
aW9tbXVfaW5mbygpIGlzIHVzZWQgdG8gZ2V0IGhvc3QgSU9NTVUgaW5mbywgZGlmZmVyZW50DQo+
PiBiYWNrZW5kcyBjYW4gaGF2ZSBkaWZmZXJlbnQgaW1wbGVtZW50YXRpb25zIGFuZCByZXN1bHQg
Zm9ybWF0Lg0KPj4NCj4+IEludHJvZHVjZSBhIG1hY3JvIENPTkZJR19IT1NUX0lPTU1VX0RFVklD
RSB0byBkZWZpbmUgdGhlIHVzYWdlDQo+PiBmb3IgVkZJTywgYW5kIFZEUEEgaW4gdGhlIGZ1dHVy
ZS4NCj4+DQo+PiBTdWdnZXN0ZWQtYnk6IEPDqWRyaWMgTGUgR29hdGVyIDxjbGdAcmVkaGF0LmNv
bT4NCj4+IFNpZ25lZC1vZmYtYnk6IFpoZW56aG9uZyBEdWFuIDx6aGVuemhvbmcuZHVhbkBpbnRl
bC5jb20+DQo+DQo+TEdUTSwNCj4NCj4+IC0tLQ0KPj4gICBNQUlOVEFJTkVSUyAgICAgICAgICAg
ICAgICAgICAgICAgIHwgIDIgKysNCj4+ICAgaW5jbHVkZS9zeXNlbXUvaG9zdF9pb21tdV9kZXZp
Y2UuaCB8IDE5ICsrKysrKysrKysrKysrKysrKysNCj4+ICAgYmFja2VuZHMvaG9zdF9pb21tdV9k
ZXZpY2UuYyAgICAgICB8IDE5ICsrKysrKysrKysrKysrKysrKysNCj4+ICAgYmFja2VuZHMvS2Nv
bmZpZyAgICAgICAgICAgICAgICAgICB8ICA1ICsrKysrDQo+PiAgIGJhY2tlbmRzL21lc29uLmJ1
aWxkICAgICAgICAgICAgICAgfCAgMSArDQo+PiAgIDUgZmlsZXMgY2hhbmdlZCwgNDYgaW5zZXJ0
aW9ucygrKQ0KPj4gICBjcmVhdGUgbW9kZSAxMDA2NDQgaW5jbHVkZS9zeXNlbXUvaG9zdF9pb21t
dV9kZXZpY2UuaA0KPj4gICBjcmVhdGUgbW9kZSAxMDA2NDQgYmFja2VuZHMvaG9zdF9pb21tdV9k
ZXZpY2UuYw0KPj4NCj4+IGRpZmYgLS1naXQgYS9NQUlOVEFJTkVSUyBiL01BSU5UQUlORVJTDQo+
PiBpbmRleCBlNzExODNlZWY5Li4yMmY3MWNiZTAyIDEwMDY0NA0KPj4gLS0tIGEvTUFJTlRBSU5F
UlMNCj4+ICsrKyBiL01BSU5UQUlORVJTDQo+PiBAQCAtMjIwMiw2ICsyMjAyLDggQEAgTTogWmhl
bnpob25nIER1YW4NCj48emhlbnpob25nLmR1YW5AaW50ZWwuY29tPg0KPj4gICBTOiBTdXBwb3J0
ZWQNCj4+ICAgRjogYmFja2VuZHMvaW9tbXVmZC5jDQo+PiAgIEY6IGluY2x1ZGUvc3lzZW11L2lv
bW11ZmQuaA0KPj4gK0Y6IGJhY2tlbmRzL2hvc3RfaW9tbXVfZGV2aWNlLmMNCj4+ICtGOiBpbmNs
dWRlL3N5c2VtdS9ob3N0X2lvbW11X2RldmljZS5oDQo+PiAgIEY6IGluY2x1ZGUvcWVtdS9jaGFy
ZGV2X29wZW4uaA0KPj4gICBGOiB1dGlsL2NoYXJkZXZfb3Blbi5jDQo+PiAgIEY6IGRvY3MvZGV2
ZWwvdmZpby1pb21tdWZkLnJzdA0KPj4gZGlmZiAtLWdpdCBhL2luY2x1ZGUvc3lzZW11L2hvc3Rf
aW9tbXVfZGV2aWNlLmgNCj5iL2luY2x1ZGUvc3lzZW11L2hvc3RfaW9tbXVfZGV2aWNlLmgNCj4+
IG5ldyBmaWxlIG1vZGUgMTAwNjQ0DQo+PiBpbmRleCAwMDAwMDAwMDAwLi4yMmNjYmUzYTVkDQo+
PiAtLS0gL2Rldi9udWxsDQo+PiArKysgYi9pbmNsdWRlL3N5c2VtdS9ob3N0X2lvbW11X2Rldmlj
ZS5oDQo+PiBAQCAtMCwwICsxLDE5IEBADQo+PiArI2lmbmRlZiBIT1NUX0lPTU1VX0RFVklDRV9I
DQo+PiArI2RlZmluZSBIT1NUX0lPTU1VX0RFVklDRV9IDQo+PiArDQo+PiArI2luY2x1ZGUgInFv
bS9vYmplY3QuaCINCj4+ICsNCj4+ICsjZGVmaW5lIFRZUEVfSE9TVF9JT01NVV9ERVZJQ0UgImhv
c3QtaW9tbXUtZGV2aWNlIg0KPj4gK09CSkVDVF9ERUNMQVJFX1RZUEUoSG9zdElPTU1VRGV2aWNl
LCBIb3N0SU9NTVVEZXZpY2VDbGFzcywNCj5IT1NUX0lPTU1VX0RFVklDRSkNCj4+ICsNCj4+ICtz
dHJ1Y3QgSG9zdElPTU1VRGV2aWNlIHsNCj4+ICsgICAgT2JqZWN0IHBhcmVudDsNCj4+ICt9Ow0K
Pj4gKw0KPj4gK3N0cnVjdCBIb3N0SU9NTVVEZXZpY2VDbGFzcyB7DQo+PiArICAgIE9iamVjdENs
YXNzIHBhcmVudF9jbGFzczsNCj4NCj5Db3VsZCB5b3UgcGxlYXNlIGRvY3VtZW50IHRoZSBzdHJ1
Y3QgYW5kIGl0cyBoYW5kbGVycyA/IFRoaXMgaXMgbW9yZSBmb3INCj50aGUgZnV0dXJlIHJlYWRl
ciB0byB1bmRlcnN0YW5kIHRoZSBWRklPIGNvbmNlcHRzIHRoYW4gZm9yIHRoZSBnZW5lcmF0ZWQN
Cj5kb2NzLiBBbnlob3csIGl0IGNvdWxkIGJlIHVzZWZ1bCBmb3IgdGhlIGRvY3MgYWxzby4gT3Zl
cmFsbCwgdGhlIFFFTVUgVkZJTw0KPnN1c2JzeXRlbSBzdWZmZXJzIGZyb20gYSBsYWNrIG9mIGRv
Y3VtZW50YXRpb24gYW5kIHdlIHNob3VsZCB0cnkgdG8NCj5pbXByb3ZlIHRoYXQgaW4gdGhlIG5l
eHQgY3ljbGUuDQoNClN1cmUsIHdpbGwgZG9jIHN0cnVjdCBhbmQgaGFuZGxlcnMgaW4gdjMuDQoN
ClRoYW5rcw0KWmhlbnpob25nDQoNCj4NCj5UaGFua3MsDQo+DQo+Qy4NCj4NCj4NCj4NCj4+ICsg
ICAgaW50ICgqZ2V0X2hvc3RfaW9tbXVfaW5mbykoSG9zdElPTU1VRGV2aWNlICpoaW9kLCB2b2lk
ICpkYXRhLA0KPnVpbnQzMl90IGxlbiwNCj4+ICsgICAgICAgICAgICAgICAgICAgICAgICAgICAg
ICAgRXJyb3IgKiplcnJwKTsNCj4+ICt9Ow0KPj4gKyNlbmRpZg0KPj4gZGlmZiAtLWdpdCBhL2Jh
Y2tlbmRzL2hvc3RfaW9tbXVfZGV2aWNlLmMNCj5iL2JhY2tlbmRzL2hvc3RfaW9tbXVfZGV2aWNl
LmMNCj4+IG5ldyBmaWxlIG1vZGUgMTAwNjQ0DQo+PiBpbmRleCAwMDAwMDAwMDAwLi42Y2I2MDA3
ZDhjDQo+PiAtLS0gL2Rldi9udWxsDQo+PiArKysgYi9iYWNrZW5kcy9ob3N0X2lvbW11X2Rldmlj
ZS5jDQo+PiBAQCAtMCwwICsxLDE5IEBADQo+PiArI2luY2x1ZGUgInFlbXUvb3NkZXAuaCINCj4+
ICsjaW5jbHVkZSAic3lzZW11L2hvc3RfaW9tbXVfZGV2aWNlLmgiDQo+PiArDQo+PiArT0JKRUNU
X0RFRklORV9BQlNUUkFDVF9UWVBFKEhvc3RJT01NVURldmljZSwNCj4+ICsgICAgICAgICAgICAg
ICAgICAgICAgICAgICAgaG9zdF9pb21tdV9kZXZpY2UsDQo+PiArICAgICAgICAgICAgICAgICAg
ICAgICAgICAgIEhPU1RfSU9NTVVfREVWSUNFLA0KPj4gKyAgICAgICAgICAgICAgICAgICAgICAg
ICAgICBPQkpFQ1QpDQo+PiArDQo+PiArc3RhdGljIHZvaWQgaG9zdF9pb21tdV9kZXZpY2VfY2xh
c3NfaW5pdChPYmplY3RDbGFzcyAqb2MsIHZvaWQgKmRhdGEpDQo+PiArew0KPj4gK30NCj4+ICsN
Cj4+ICtzdGF0aWMgdm9pZCBob3N0X2lvbW11X2RldmljZV9pbml0KE9iamVjdCAqb2JqKQ0KPj4g
K3sNCj4+ICt9DQo+PiArDQo+PiArc3RhdGljIHZvaWQgaG9zdF9pb21tdV9kZXZpY2VfZmluYWxp
emUoT2JqZWN0ICpvYmopDQo+PiArew0KPj4gK30NCj4+IGRpZmYgLS1naXQgYS9iYWNrZW5kcy9L
Y29uZmlnIGIvYmFja2VuZHMvS2NvbmZpZw0KPj4gaW5kZXggMmNiMjNmNjJmYS4uMzRhYjI5ZTk5
NCAxMDA2NDQNCj4+IC0tLSBhL2JhY2tlbmRzL0tjb25maWcNCj4+ICsrKyBiL2JhY2tlbmRzL0tj
b25maWcNCj4+IEBAIC0zLDMgKzMsOCBAQCBzb3VyY2UgdHBtL0tjb25maWcNCj4+ICAgY29uZmln
IElPTU1VRkQNCj4+ICAgICAgIGJvb2wNCj4+ICAgICAgIGRlcGVuZHMgb24gVkZJTw0KPj4gKw0K
Pj4gK2NvbmZpZyBIT1NUX0lPTU1VX0RFVklDRQ0KPj4gKyAgICBib29sDQo+PiArICAgIGRlZmF1
bHQgeQ0KPj4gKyAgICBkZXBlbmRzIG9uIFZGSU8NCj4+IGRpZmYgLS1naXQgYS9iYWNrZW5kcy9t
ZXNvbi5idWlsZCBiL2JhY2tlbmRzL21lc29uLmJ1aWxkDQo+PiBpbmRleCA4YjJiMTExNDk3Li4y
ZTk3NWQ2NDFlIDEwMDY0NA0KPj4gLS0tIGEvYmFja2VuZHMvbWVzb24uYnVpbGQNCj4+ICsrKyBi
L2JhY2tlbmRzL21lc29uLmJ1aWxkDQo+PiBAQCAtMjUsNiArMjUsNyBAQCBpZiBoYXZlX3Zob3N0
X3VzZXINCj4+ICAgZW5kaWYNCj4+ICAgc3lzdGVtX3NzLmFkZCh3aGVuOiAnQ09ORklHX1ZJUlRJ
T19DUllQVE8nLCBpZl90cnVlOiBmaWxlcygnY3J5cHRvZGV2LQ0KPnZob3N0LmMnKSkNCj4+ICAg
c3lzdGVtX3NzLmFkZCh3aGVuOiAnQ09ORklHX0lPTU1VRkQnLCBpZl90cnVlOiBmaWxlcygnaW9t
bXVmZC5jJykpDQo+PiArc3lzdGVtX3NzLmFkZCh3aGVuOiAnQ09ORklHX0hPU1RfSU9NTVVfREVW
SUNFJywgaWZfdHJ1ZToNCj5maWxlcygnaG9zdF9pb21tdV9kZXZpY2UuYycpKQ0KPj4gICBpZiBo
YXZlX3Zob3N0X3VzZXJfY3J5cHRvDQo+PiAgICAgc3lzdGVtX3NzLmFkZCh3aGVuOiAnQ09ORklH
X1ZJUlRJT19DUllQVE8nLCBpZl90cnVlOg0KPmZpbGVzKCdjcnlwdG9kZXYtdmhvc3QtdXNlci5j
JykpDQo+PiAgIGVuZGlmDQoNCg==

