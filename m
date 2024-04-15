Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0ED9DC4345F
	for <qemu-devel@archiver.kernel.org>; Mon, 15 Apr 2024 02:42:27 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rwCHY-0004EH-DD; Sun, 14 Apr 2024 22:41:20 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <chen.zhang@intel.com>)
 id 1rwCHX-0004Dq-2l
 for qemu-devel@nongnu.org; Sun, 14 Apr 2024 22:41:19 -0400
Received: from mgamail.intel.com ([192.198.163.14])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <chen.zhang@intel.com>)
 id 1rwCHU-00081j-4E
 for qemu-devel@nongnu.org; Sun, 14 Apr 2024 22:41:18 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1713148876; x=1744684876;
 h=from:to:cc:subject:date:message-id:references:
 in-reply-to:content-transfer-encoding:mime-version;
 bh=WTfWJJBhVZkDD9Cxu17k8PzMeHnQcXVjKpk0l8NV7tI=;
 b=jtF10K4er34cF4Gj8VgyU2d++wm4CYWHSxqXAQyYNAjAf0oXaC7RiNF4
 v5I9Z/YVPurzYHnazycEftyCHaX8SXeObF29DRn48d27Bcu+nKrVPeF3g
 4k34PclSA6gxolCBKbXrV1kGdCqOIyjzAQI7VR1Cq1vd99XuhaEUW2gI6
 9enUVwBlkXE8CUFvrDPKwpQxNRrQ8yAN1u2BW+ksCasPnb7zSjLGceBBG
 NPnPyMMYT7kzUHfKLDiuRlIk/oOxHxeOxPQ7ia++KetNsX8IxYgGgMvER
 2K3WcbZ9LlQdl8/iamy9O9OjnapvBrbnvkXnaI8KWJ7k4v0uzl1i9vT6T w==;
X-CSE-ConnectionGUID: Mo4ExrTZSFyWo/gk3IanGQ==
X-CSE-MsgGUID: yN3pg4WxShSf8UFBb0E3jQ==
X-IronPort-AV: E=McAfee;i="6600,9927,11044"; a="8738917"
X-IronPort-AV: E=Sophos;i="6.07,202,1708416000"; 
   d="scan'208";a="8738917"
Received: from orviesa003.jf.intel.com ([10.64.159.143])
 by fmvoesa108.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 14 Apr 2024 19:41:11 -0700
X-CSE-ConnectionGUID: mifVBubDT2awQm4OYC7veA==
X-CSE-MsgGUID: b0UIHHsaT8GE917iAugqHw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.07,202,1708416000"; d="scan'208";a="26442873"
Received: from orsmsx601.amr.corp.intel.com ([10.22.229.14])
 by orviesa003.jf.intel.com with ESMTP/TLS/AES256-GCM-SHA384;
 14 Apr 2024 19:41:10 -0700
Received: from orsmsx611.amr.corp.intel.com (10.22.229.24) by
 ORSMSX601.amr.corp.intel.com (10.22.229.14) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35; Sun, 14 Apr 2024 19:41:10 -0700
Received: from orsmsx610.amr.corp.intel.com (10.22.229.23) by
 ORSMSX611.amr.corp.intel.com (10.22.229.24) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35; Sun, 14 Apr 2024 19:41:09 -0700
Received: from ORSEDG601.ED.cps.intel.com (10.7.248.6) by
 orsmsx610.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35 via Frontend Transport; Sun, 14 Apr 2024 19:41:09 -0700
Received: from NAM11-CO1-obe.outbound.protection.outlook.com (104.47.56.169)
 by edgegateway.intel.com (134.134.137.102) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.35; Sun, 14 Apr 2024 19:41:09 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=CQJYylNZot+7z+iM8iyIolXuQzAN8a4iciLachvgpEaMQiky372TpzdBrpBgE1IS6yZDCrWwhDIKBy6td6unmxgUDTEPvtwDaC/Br3lC31Jo1bCjXbc2riYgwnJKm0m7bFRmRNLfjsz6482yQpBHGN5CTBgrsz4lD1jA012zly26Tk083tk5FJH8E0SVng2JE84J9JAiVwxbS8VE8l77a/FUFHfPDao6YHDbJC5Jvdol+xRHBFLNKkF/AeszZQEVaA77HLbYsi0/4QIjQ5sE9yO4OPOLn7yyUN/40KlYENcYbfXrkd/lBXdEJ3jHkyagPLXE0D+Bnyrb9zTpcLejkQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=WTfWJJBhVZkDD9Cxu17k8PzMeHnQcXVjKpk0l8NV7tI=;
 b=XzTybNqsWfa2Lo7yd3esS0/ZytyiSFkWXun30Qh03hgCVLbpcaVG6n22S4coJdD3iEyDy6F0ZObOc1bPCKjLsDiDi3n0hluTpyAEeh0X/t/O+i1aegceucvNuppIBNQ/HCWf3vbWa3YZNI2uxweZnKCsTFTEHuMloXhjuNCsuDzZnlt3oUCN1oHVTlutcEbNDC19IVFYHSpzScqD/sO4hRgrwPMJ5Zq3IMY+oWNjs0js2A9JsV9hLja3l3mFoVpAtSGdbFA0b9XqDtx1U0tyoQtqXG4FhCuHQwLZJTY04Focs6bGccIAzWvxoK98274GOPMOsvrGO+WJ0cJtP0XoJw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Received: from CYYPR11MB8432.namprd11.prod.outlook.com (2603:10b6:930:be::8)
 by MW4PR11MB5892.namprd11.prod.outlook.com (2603:10b6:303:16a::16) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7472.26; Mon, 15 Apr
 2024 02:41:07 +0000
Received: from CYYPR11MB8432.namprd11.prod.outlook.com
 ([fe80::60a7:2a84:f3d8:2828]) by CYYPR11MB8432.namprd11.prod.outlook.com
 ([fe80::60a7:2a84:f3d8:2828%6]) with mapi id 15.20.7472.027; Mon, 15 Apr 2024
 02:41:06 +0000
From: "Zhang, Chen" <chen.zhang@intel.com>
To: Fabiano Rosas <farosas@suse.de>, "Zhang, Hailiang"
 <zhanghailiang@xfusion.com>, Li Zhijian <lizhijian@fujitsu.com>
CC: "qemu-devel@nongnu.org" <qemu-devel@nongnu.org>, Peter Xu
 <peterx@redhat.com>, Jason Wang <jasowang@redhat.com>, "dave@treblig.org"
 <dave@treblig.org>, Wen Congyang <wencongyang2@huawei.com>, Xie Changlong
 <xiechanglong.d@gmail.com>
Subject: RE: COLO state?
Thread-Topic: COLO state?
Thread-Index: AQHajB4aIMpJiQ+dM0Gpejgp/BPv57FonsIg
Date: Mon, 15 Apr 2024 02:41:06 +0000
Message-ID: <CYYPR11MB8432C2BF07FECE505D1C63FD9B092@CYYPR11MB8432.namprd11.prod.outlook.com>
References: <87pluwarq2.fsf@suse.de>
In-Reply-To: <87pluwarq2.fsf@suse.de>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: CYYPR11MB8432:EE_|MW4PR11MB5892:EE_
x-ms-office365-filtering-correlation-id: 3bf89e7d-6269-4865-3270-08dc5cf58049
x-ld-processed: 46c98d88-e344-4ed4-8496-4ed7712e255d,ExtAddr
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: 7KgKBu0DeaiaGw8O4TvMo1cmiMkpHdjudi9CCTBHc1TeSCXnvjdGJ43qaGplnZYrGwfTFUFNabKEaXhA1nQVsNsc7pLHiNG5hZXYL4gBw9cNsGZj7F5u4RE8bNVWt2d+SuOvckCGYsJE4W14dt1iTUjH8SoQoVS1Qook9/COpBh4qI/WnJW3UKlnK+Lxs6p6c8HrPIMYnugRe6XbbES2DTVmg9jd60McfnpPrnFD9/w4KUBsGeFE0V4RehFQP4D6QQ/5jZBkXE+6Cl15niXLLrrmYQd358bRgawuxeQ8CxMEbyJoFxW1c2td2MJR3kRiYsjufCHIjj4Q6QFh2dsfyGq1qiTreKyNOlA6Src9yEmCavd2X67j0KbX3bcAnar+r4N4/IDcH3pZxn4HP3mkpxjdTGONyMhp+nRb7KTrE3BUA2zPmUQax5pgd5rKnQU2eoAHv/oJM2cY6CwDg5E5iAEVMIlay3+rlgFd0mUT8n+pcF0Su4otmeqgnIx+CYsEmNvp2q9leFLEggCFbrCbgfPyC9NFvFURQahwSa5W4TgGAqK0RWefcfXoMy/FncOCSIARoBtj2xyGYUM8wx4XrLEeF+KgAlGQjGnpJvjv4ztGrZ9yUpnr6V0rJgPELIACHnSy0N6iQm5uvpzw4MkNqKbWLwiYqVtn++EqBAe3pDat90hP5Y4BWoQkNx/v3VH+
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:CYYPR11MB8432.namprd11.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230031)(376005)(366007)(1800799015)(38070700009); DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?OHwrExZrSkEV/vdjQ72BuiXnrtiMgs1Vrd9xAxCiOwC8GwyPbbOeHoArT9KY?=
 =?us-ascii?Q?FdvLQ7hrKMWrwd5DimVyAF3lyG6Sqf1jSqywJ7IuanI+n3+uqvwB4nwFSKhf?=
 =?us-ascii?Q?JsehXcyF4eGcaQQidZrCCyEUnQRHN1gQmfdqYKjHKHBHfHJkeT3nKfpirnMy?=
 =?us-ascii?Q?S3E+N2qr22XGPWkSkOgFgH/kRyL2jTZPStQJrx6Z/SWqPWIIJVOA4uhE/lqx?=
 =?us-ascii?Q?2BynP/6VxO+W37sKF1fSQHcuElg3s9mJ7+LSfB/cHbep6DtiT/n4oJPMDU2R?=
 =?us-ascii?Q?MMy84xdD+qO4YVh2BSRDeAxC7KeXOpTX/KSlak1587Lzq/2h3vKYmEMWphG4?=
 =?us-ascii?Q?gch5uGcKFL+fGzOZNAiHYMqa8fP56Jn7i9bsl+dOGPqwxAKogrjk/7oymkC0?=
 =?us-ascii?Q?2vXDwWn8upfMuaZeGNzXrlIourZTWnNj36Yi1yRwVaPKKCDOPeFo7hUKeBn/?=
 =?us-ascii?Q?4TqN1jhtl5k7bzIq6Ku4OQkIdd2kJI1NLIuo6nuuLLyLybx8lj+SYsSDAxhd?=
 =?us-ascii?Q?UE64beeS43QxP0/c3lwew4YbyenZQfETYhZYbvUf/UWaMAPV6iWvMfDPw3Up?=
 =?us-ascii?Q?Nm/wdsaRLVqsFHbAnpU8eeHQNMdMX783jXdK+P//a7Q5HB4yYxjKt1RYyxgB?=
 =?us-ascii?Q?bKl1acorEmdN+WXrXMXe8PxtjDIiZ+EG6bdYLZ02bOrMUAYAI+dxDcQN0/5A?=
 =?us-ascii?Q?AdZXAS6jveZU8OU6WirBLq9nfSiV8K+Uokc+hXtorfFW6aPctdLRiFb7y1BQ?=
 =?us-ascii?Q?BRzyiwJIhWcBuCs7oNdPztRi1t04k/VPxaEc1IVMqQgPojoh2Wkjgg5n2n7H?=
 =?us-ascii?Q?eQvhgAfeaNtbcC1dbL84Ka0itwbT10fd80VPQRrXQi0khIgcZ2Tinz6LduNP?=
 =?us-ascii?Q?IWPMW3aVml2QVE2WWeurbLxqu4J/b7mbhwFa/iZK/R4n+AtawrolQhIVXra1?=
 =?us-ascii?Q?TpAgtBZBSpwbPxpt+H/XbQXVL1VEFTD8GJ4QJL4uQOv0Gff5+heViYaau0sv?=
 =?us-ascii?Q?D9H86sVjXe4PRT5qd+6xY8+g74JnN8gfpMnNghgg4ORBh1VgNPy27BfkkzaB?=
 =?us-ascii?Q?EGREJs5YYENwJOo/6qTYZ9GhpgPOIjJiGIeQtYA7Y+FjiIGbpVGfeDmd9z+G?=
 =?us-ascii?Q?1xQeFxQuQGP4UeCOn/ehYhWthU3usLn5O1pmjF1HdCVTJufUbXRiP/1w8jUg?=
 =?us-ascii?Q?AHCqM8VGm+i81jSxRgMhlTjDhn9xwcd3jg7/EBz4cChUeFwKy+WMSOi2EIvO?=
 =?us-ascii?Q?GyWDjob43aautWQuFcrP95Uw5GCZcQyS0yVljJ0e/yLGCxbIW4ISWBfcHXbv?=
 =?us-ascii?Q?Zpy/YWZnfsEOnMzB5epuyJajrH2wZ1Vdm5n4BK/+uCla9rSKWgV0twJxLIq1?=
 =?us-ascii?Q?DbfcVNmByeUaXVeRHesVd83zDTu4m7F+6lADNugyASwsb8mKPmDbY8004GKw?=
 =?us-ascii?Q?e/oQ7XDIizvpmTzapKiFWmphbSgpiXIZlnLPNxN3Ow9j+A7IHwvum5q9isyg?=
 =?us-ascii?Q?W/6UIzLFB5qnmvBJh//xdZs/RSKRLNS0IPKD1u3zDlrSqYx/j9yDXYNC1gqx?=
 =?us-ascii?Q?dQXLiwHOh66aEWeoWuyqk9u9ikCRYyK9ba0RjUtj?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: CYYPR11MB8432.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 3bf89e7d-6269-4865-3270-08dc5cf58049
X-MS-Exchange-CrossTenant-originalarrivaltime: 15 Apr 2024 02:41:06.8472 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 0xwNdfpIeABH9JTckfDsEWct+Fhj30gcmIQj+OzAcctycgHoFrlgZmqAAOXGNWeQQgw3GT4RKf1YfGEZDQadRQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MW4PR11MB5892
X-OriginatorOrg: intel.com
Received-SPF: pass client-ip=192.198.163.14; envelope-from=chen.zhang@intel.com;
 helo=mgamail.intel.com
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



> -----Original Message-----
> From: Fabiano Rosas <farosas@suse.de>
> Sent: Thursday, April 11, 2024 10:40 PM
> To: Zhang, Hailiang <zhanghailiang@xfusion.com>; Zhang, Chen
> <chen.zhang@intel.com>; Li Zhijian <lizhijian@fujitsu.com>
> Cc: qemu-devel@nongnu.org; Peter Xu <peterx@redhat.com>
> Subject: COLO state?
>=20
> Hi COLO maintainers,
>=20
> Would you please take a look at this issue?
>=20
> https://gitlab.com/qemu-project/qemu/-/issues/2277
>=20

Sure, please share more details in gitlab of your test. For example the pri=
mary/secondary VM boot scripts and the backtrace...etc...

> The reporter claims it affects from 9.0-rc2 all the way back to QEMU 7.2.=
 I
> don't have any kind of setup for COLO, so it will take me a while to be a=
ble to
> verify this.
>=20
> Could you also provide clarification on what is the state of COLO these d=
ays?
> Are any of you looking at it? Do we know of active users of the feature?

Currently, all the COLO code already merged by QEMU. But there is no suppor=
t for libvirt (Need to passthrough QMP command to QEMU for enable COLO).
Any users can use the WIKI page(https://wiki.qemu.org/Features/COLO) to set=
up COLO based on upstream code.(Maybe have issues? I will double check it..=
. ).
As we know, many cloud services provider build there HA/FT system or produc=
ts based on COLO project.

>=20
> Also, is the MAINTAINERS file reflecting the actual maintenance state
> according to you?

 I will check w/ Hailiang/Zhijian/Congyang/Changlong(Block replication) to =
see if he will keep working on COLO or not.

Thanks
Chen

>=20
> COLO Framework
> M: Hailiang Zhang <zhanghailiang@xfusion.com>
> S: Maintained
> F: migration/colo*
> F: include/migration/colo.h
> F: include/migration/failover.h
> F: docs/COLO-FT.txt
>=20
> COLO Proxy
> M: Zhang Chen <chen.zhang@intel.com>
> M: Li Zhijian <lizhijian@fujitsu.com>
> S: Supported
> F: docs/colo-proxy.txt
> F: net/colo*
> F: net/filter-rewriter.c
> F: net/filter-mirror.c
> F: tests/qtest/test-filter*
>=20
> Thanks

