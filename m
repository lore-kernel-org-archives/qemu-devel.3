Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C5BF7C54E5D
	for <qemu-devel@archiver.kernel.org>; Tue, 19 Mar 2024 03:47:34 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rmQR1-0006Fs-2S; Mon, 18 Mar 2024 23:46:43 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <zhenzhong.duan@intel.com>)
 id 1rmQQz-0006Fk-Ab
 for qemu-devel@nongnu.org; Mon, 18 Mar 2024 23:46:41 -0400
Received: from mgamail.intel.com ([198.175.65.13])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <zhenzhong.duan@intel.com>)
 id 1rmQQw-0007B6-5d
 for qemu-devel@nongnu.org; Mon, 18 Mar 2024 23:46:40 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1710819998; x=1742355998;
 h=from:to:cc:subject:date:message-id:references:
 in-reply-to:content-transfer-encoding:mime-version;
 bh=isARAq05O3rQjJrZYrSZDkwyAdrz57v2HEBj3yliUgs=;
 b=TCY52loAL8JMvi/LQ6opKR9QlXLlGxXgdbUKxo3SiK7ieCiIR6WWavQn
 A+FhoOm7jolGkiSJJrB9iXaHt0J3OX5OWcJcdXtJm4lBAmSrm4PwLq3xZ
 Za8LcPXOUpcRq3HE4ymgGxi45lydve3VNEq1akWa/gDH286nZ73CemUAJ
 9iAoFVaqKM/B+2bnWDMN+ahudeL3RPCCSbqxfTfm1NQ9z1hUoP7pe2F7+
 eLpJwJhf+BEq7tvLBPhHFmxjbIWQtA3614/pv0LJUfRasxY/YXfehD0ZP
 zC+t9+UoZljsX9bhZb93HxtN7QeKkE9XD9GK6pvFVTku4wxmoGNY4iPbI w==;
X-IronPort-AV: E=McAfee;i="6600,9927,11017"; a="16811347"
X-IronPort-AV: E=Sophos;i="6.07,135,1708416000"; d="scan'208";a="16811347"
Received: from orviesa006.jf.intel.com ([10.64.159.146])
 by orvoesa105.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 18 Mar 2024 20:46:34 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.07,135,1708416000"; d="scan'208";a="14058424"
Received: from fmsmsx601.amr.corp.intel.com ([10.18.126.81])
 by orviesa006.jf.intel.com with ESMTP/TLS/AES256-GCM-SHA384;
 18 Mar 2024 20:46:34 -0700
Received: from fmsmsx612.amr.corp.intel.com (10.18.126.92) by
 fmsmsx601.amr.corp.intel.com (10.18.126.81) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35; Mon, 18 Mar 2024 20:46:33 -0700
Received: from fmsedg601.ED.cps.intel.com (10.1.192.135) by
 fmsmsx612.amr.corp.intel.com (10.18.126.92) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35 via Frontend Transport; Mon, 18 Mar 2024 20:46:33 -0700
Received: from NAM12-MW2-obe.outbound.protection.outlook.com (104.47.66.41) by
 edgegateway.intel.com (192.55.55.70) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.35; Mon, 18 Mar 2024 20:46:32 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=n4j5o5DGDfxKfYvttBJ36TZCcbW1NG2ihY8p1vLoU16XKAD4JH5oYScgn5VPABLdPE8PNovqvjlJ4uBD9EBpZ84zoglJ+g/6PMTSLZc8Z9LkhzoWUpRwqOv1jhrjjUbVbeUJzRa6Gv/bzJJcJgeKbuaFlLedYZQHS0QRIleoZCuP+1HKoSVVx5hO3CfMcxoqhkoq7iiktiSA+q8c6680YQiwoYljXRSGuQ4Oj1tpSujcNeBimf5cpWlAdj2KIp+RZOr9Q+djbVX2v7HXw13oF02UspwxbSsDWy8m6A+0+E/qJQ+u15F8KtX/ZrV4pJZTun1jExefF0wseCqMHYVx0w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=isARAq05O3rQjJrZYrSZDkwyAdrz57v2HEBj3yliUgs=;
 b=OKQhm5tl3J2qGMZsPp6hhKc7GAc6t6XAWjnEIFufxa2nIF8SQVxQ02chgXxHbbq1pCsy8XMeyRonO4TYp86ivqAjJQQU5YTYYqLd9XvjVM52PVWFkIzdWDg66oAvfvgXsseArEp5Wqee4a1FMYeKdCxCWby3xpJG4d7LZD2ClWinK2vhEnHPZy9OhvafqVPlpiOmBzU/nej1EvaqYyHxRY3s5mtO1yoGloqXEdQUARxx7QDkNLhaVDbsv9JqqzfIGqVwT4jomDVG54Mt8bhinJ8tKoWIekio1PhxZbkWL7grJZ9xtkL3nlz0Q7EW2uPmvYzoNgqiYTjAAk1De4kKyw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Received: from SJ0PR11MB6744.namprd11.prod.outlook.com (2603:10b6:a03:47d::10)
 by PH0PR11MB5142.namprd11.prod.outlook.com (2603:10b6:510:39::20)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7409.11; Tue, 19 Mar
 2024 03:46:31 +0000
Received: from SJ0PR11MB6744.namprd11.prod.outlook.com
 ([fe80::e4a3:76ce:879:9129]) by SJ0PR11MB6744.namprd11.prod.outlook.com
 ([fe80::e4a3:76ce:879:9129%7]) with mapi id 15.20.7409.010; Tue, 19 Mar 2024
 03:46:31 +0000
From: "Duan, Zhenzhong" <zhenzhong.duan@intel.com>
To: "eric.auger@redhat.com" <eric.auger@redhat.com>, "qemu-devel@nongnu.org"
 <qemu-devel@nongnu.org>
CC: "alex.williamson@redhat.com" <alex.williamson@redhat.com>,
 "clg@redhat.com" <clg@redhat.com>, "peterx@redhat.com" <peterx@redhat.com>,
 "jasowang@redhat.com" <jasowang@redhat.com>, "mst@redhat.com"
 <mst@redhat.com>, "jgg@nvidia.com" <jgg@nvidia.com>, "nicolinc@nvidia.com"
 <nicolinc@nvidia.com>, "joao.m.martins@oracle.com"
 <joao.m.martins@oracle.com>, "Tian, Kevin" <kevin.tian@intel.com>, "Liu, Yi
 L" <yi.l.liu@intel.com>, "Sun, Yi Y" <yi.y.sun@intel.com>, "Peng, Chao P"
 <chao.p.peng@intel.com>
Subject: RE: [PATCH v1 08/11] vfio/pci: Allocate and initialize
 HostIOMMUDevice after attachment
Thread-Topic: [PATCH v1 08/11] vfio/pci: Allocate and initialize
 HostIOMMUDevice after attachment
Thread-Index: AQHaafrdLuFJ6T8wnkOkwPy9BdQb2rE9rPgAgADXIjA=
Date: Tue, 19 Mar 2024 03:46:31 +0000
Message-ID: <SJ0PR11MB6744FC5D025D73D474838F90922C2@SJ0PR11MB6744.namprd11.prod.outlook.com>
References: <20240228035900.1085727-1-zhenzhong.duan@intel.com>
 <20240228035900.1085727-9-zhenzhong.duan@intel.com>
 <750d1d70-37cd-4e00-a092-204f0dbbe61c@redhat.com>
In-Reply-To: <750d1d70-37cd-4e00-a092-204f0dbbe61c@redhat.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: SJ0PR11MB6744:EE_|PH0PR11MB5142:EE_
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: pWC3W5LfiUtiAlUUACYMMF+GJgiwzx+7jAdd0KOCuZzTvz4Kiin5cnXYFJHHtaBdiu5lPGSQLx6dOpErq8CoNSqGKsQWJPFP67+8mZePxl4LO4awEtvvkTGKyDOkBbXrplO4Nz2SIf2XnUj07UibzN/CwSEG+FU14L1v6WRTkMJIwBMmjTrQiQi2p3rRXW9hx0838UNDG1sNAF1DtQPmv05EVjTHf6pIVYRt8p+fhiWoLlFEl0wWXL6UAPU2EecU9WYGsa83HtVN9l6FNzQo+9dhGfjhgc7TVtwY5aZZn0tt+WjC88dhSui/5Tg/bYyjA47VPXiX/FG1DMtE7GRBYM+ifWJEBO8J2R0xKPbbOWaUTHrYUPApKJEy4WTRbhxYLQSBKAknaup4zRiUaQRxyk8mlLqlNznMes7BTW0kDXl6teK/fXJVjnfJqx4FDFHWsNrnybEBYQfN7b15MmzQXPhoiLWt60HtKFu53QfMLW+MEyXMrZRu7vgFEZ4uaYihyzenbglIj3tr8V0AKSP86VFxkPQczVWh2BVlsolSAcShaQLfXFkElmfiF+drSjgdk4FIcJ9J6JydsKsNDARAw0FMPXc1+rbtchVhQ1lH9EE32Kec5Gzd8rYKfu4lowCuoBI8L/wpXsPYl3O6Jj11xYyMLfHEzllFWVkbZ6iQL00=
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:SJ0PR11MB6744.namprd11.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230031)(7416005)(366007)(1800799015)(376005); DIR:OUT; SFP:1102; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?QVBGTzVnWWRuMnV1Z20vb3FTdy9aVHV0YWxLaE8zTE5DYzFEWmg1QXBVZlF1?=
 =?utf-8?B?YnFmY2ZiWTh1UDF6RjlMU01nNm1FOXRSZnl4YmRrcXpMWlh2MklJUy9IbFQ1?=
 =?utf-8?B?Y2gxaFQ4SEdSQytNanlkSWtTbVJsTnQ0UWhFTFQxWmRoVHJWbnMzcjFkdyt5?=
 =?utf-8?B?bnFVdkNkM1NxSjgzUDF4V1kwRTc1SEgzSkJSOVBiUVJvUG9kNHNOS3BnLzZq?=
 =?utf-8?B?NHZnNVJTb1Z1Tm9VWmtCSnprK2gyOFArcmdaR3dVdVpkVXpWeEVESkVnQTlz?=
 =?utf-8?B?MDllNFdZWUkwbjMvWGlFZ05OMU9WYmx0ZEJlM3crTklBNTFtUklKY1FEOWIx?=
 =?utf-8?B?ZVFjRHFBRGpvN0sreVJjVHk3bVVSck40VWZXS0ZsZjREQjN2ak9iNmJkbkpu?=
 =?utf-8?B?T0NEb1FFVHZmc05VL3IwUHU3VG9sdUJhejNXSG1lTVdPTG1CcStrSU93UFlS?=
 =?utf-8?B?Ylc3aWYwMU4yU3pudjN1R1M3VlBwK2NZUWN0M2U3WHN5MkF2QkhOZUx3Q3VK?=
 =?utf-8?B?dGNESXdIVWZ2ZW9Sai9aRVN1TjRVNHRGcnA4SzQxbHVWNjZWczVlNmhQWGhs?=
 =?utf-8?B?QnlXeFdTdjA4cGVaZVF5M3hCZHJha2tMUmIya1F6TGRobXNaVHlaWklVZllM?=
 =?utf-8?B?SHduOFh0R1dtcW1kd2FCYjZjSGphVE1EOHJ0QVFPbEFVbU1tdm1nRnhzMk5B?=
 =?utf-8?B?RDlqc09wRzlTNFdCcEZZZ21GOUFZQ2VnR1hiOXZxY29xTjVuMUoyVE55NDBi?=
 =?utf-8?B?aGlLUDdKZWQyd0FEaHZHRXRkVlhqVC9WWDBvOERzbUVVK1crRUdFVXhnd3Nw?=
 =?utf-8?B?UXNDcjRXMmhLckY0eDAwMmVCZmFTQVpyTVFnOVhrU0hwRGhNbGk2TUhlc3Bz?=
 =?utf-8?B?MkJDTzhmV0dQdkpkb3VQUlZOcWorS3ZRMHZHSTFDQmlvbHovMnlaNU9XRDR6?=
 =?utf-8?B?NlRPeUlXeUZNbk5xYzAxYTY5ZVlpQUpmVGY4QjZlcDE3UllnTVQzV2VDSlBD?=
 =?utf-8?B?NVVCdW91R3JlUVduNTZWM1ZmdXMvMnI3R2RzaERRZFpWVnNnUklGUThING83?=
 =?utf-8?B?Y0UzbU54VWtCMXNMTnZlQlRPSCt0M25JOExoMVBzYXB2VURGLzl5N1FnQm51?=
 =?utf-8?B?L21heWpHR3lGeDFkbzBUdU1zRmN6bzhMSzZxdzdJdU5WeE1Xb0ltcUJMaVNH?=
 =?utf-8?B?ZktaMzBmSFprb0Y4UmRCUGVDSWlNSlZvZUhJYVNxQXMzUG1McHlxY3pBdmM5?=
 =?utf-8?B?SUtCOVA3b2gzR29nWHNrZWRnU0N3UGpaUXd0N2piczdtalJBMVZMMWtlMy94?=
 =?utf-8?B?K3ZhdGZIdmUySjNOOG9naGhiTVh3bnF0UDRxQTBHWGwyQnVzUzgyL085dEJM?=
 =?utf-8?B?Z3VxdEF1QU1mVFBlLzJxV280dGsydnlkUWRHUkhBZ3h1OXR6cnhHdzNMWG1U?=
 =?utf-8?B?UFNSWkJmc1lMT2dybnFvYXI0YXpCZzVnZkkzY29rYnBnMmJmSDNKYXFVZFUw?=
 =?utf-8?B?YjlWcmtXNVhUMG5TcEJXbHVsZmc0eG91UUN6SHQzaHAwTTJxT3NrQkdmZW9Q?=
 =?utf-8?B?VTFCYTBYaDR5aWFCMWJZb0dIYnpIeE4zM0JNU2Y5NGtsMWsxZHF3YWs5K1Bx?=
 =?utf-8?B?ejhjVjF1Zlh5ZlVFSDNUaWVWemYzSnFRSmdpMTUvN0szY3V5L2xURktxTmZt?=
 =?utf-8?B?dVZLZWxQY0tRL0krUE84Q2FYVGFUYzJmN25UTkUwVHNVOGR2MTRtdFNFRkdN?=
 =?utf-8?B?bFU1eGs4VUQ5Zng4d3hMK1BISThLZ1RWRCtUc1RwLzlOMWpIL0srWjh1RDU4?=
 =?utf-8?B?VTJndWhYVlUyQXh2bk1hWnJDQVpwZVlRMytmYlM4bmY5SElJZzBFNDdkczFk?=
 =?utf-8?B?TVFxVFU1ejlxa0l3SWdhV0JhVzR5K0VxeVZsMngrc1I3RnlYODFPNytPVkR2?=
 =?utf-8?B?Zkx6VjhPQWV2ZWVNMXFFeERVS0lRLzNRazcxLzVPSnpvSkc1L1llenc3NDdt?=
 =?utf-8?B?cUNGOXh6ZlZXTHd2VmdzbDkvME1YN3I5ZkJmR2ptL0RWM2liYkluYTZNV2J3?=
 =?utf-8?B?SW11L1lmVHVhWlhLK3RhVXZ4WHlrSDlNZDViZHJReWdlbVc0RGRURlJLWVdy?=
 =?utf-8?Q?rnzzk5nLPzfuWR0wf0JHu1e3R?=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: SJ0PR11MB6744.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: f0ba62e5-32c7-4a2d-b264-08dc47c72a52
X-MS-Exchange-CrossTenant-originalarrivaltime: 19 Mar 2024 03:46:31.3727 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 0TILGIUFO+iFdEBqWJJxZ6up6LJlzsVz9+686b9t99ZGRbqW818rAahYsWxuAviW0KqdtF4tIogT6NBnIcw2zGzhxBPBiRrZeYWsr3wy01k=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH0PR11MB5142
X-OriginatorOrg: intel.com
Received-SPF: pass client-ip=198.175.65.13;
 envelope-from=zhenzhong.duan@intel.com; helo=mgamail.intel.com
X-Spam_score_int: -24
X-Spam_score: -2.5
X-Spam_bar: --
X-Spam_report: (-2.5 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.374,
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

DQoNCj4tLS0tLU9yaWdpbmFsIE1lc3NhZ2UtLS0tLQ0KPkZyb206IEVyaWMgQXVnZXIgPGVyaWMu
YXVnZXJAcmVkaGF0LmNvbT4NCj5TdWJqZWN0OiBSZTogW1BBVENIIHYxIDA4LzExXSB2ZmlvL3Bj
aTogQWxsb2NhdGUgYW5kIGluaXRpYWxpemUNCj5Ib3N0SU9NTVVEZXZpY2UgYWZ0ZXIgYXR0YWNo
bWVudA0KPg0KPg0KPg0KPk9uIDIvMjgvMjQgMDQ6NTgsIFpoZW56aG9uZyBEdWFuIHdyb3RlOg0K
Pj4gU2lnbmVkLW9mZi1ieTogWmhlbnpob25nIER1YW4gPHpoZW56aG9uZy5kdWFuQGludGVsLmNv
bT4NCj4+IC0tLQ0KPj4gIGh3L3ZmaW8vcGNpLmMgfCA0ICsrKysNCj4+ICAxIGZpbGUgY2hhbmdl
ZCwgNCBpbnNlcnRpb25zKCspDQo+Pg0KPj4gZGlmZiAtLWdpdCBhL2h3L3ZmaW8vcGNpLmMgYi9o
dy92ZmlvL3BjaS5jDQo+PiBpbmRleCA0ZmEzODdmMDQzLi42Y2M3ZGU1ZDEwIDEwMDY0NA0KPj4g
LS0tIGEvaHcvdmZpby9wY2kuYw0KPj4gKysrIGIvaHcvdmZpby9wY2kuYw0KPj4gQEAgLTMwMDYs
NiArMzAwNiw5IEBAIHN0YXRpYyB2b2lkIHZmaW9fcmVhbGl6ZShQQ0lEZXZpY2UgKnBkZXYsIEVy
cm9yDQo+KiplcnJwKQ0KPj4gICAgICAgICAgZ290byBlcnJvcjsNCj4+ICAgICAgfQ0KPj4NCj4+
ICsgICAgLyogQWxsb2NhdGUgYW5kIGluaXRpYWxpemUgSG9zdElPTU1VRGV2aWNlIGFmdGVyIGF0
dGFjaG1lbnQgc3VjY2VlZA0KPiovDQo+YWZ0ZXIgc3VjY2Vzc2Z1bCBhdHRhY2htZW50Pw0KPj4g
KyAgICBob3N0X2lvbW11X2RldmljZV9jcmVhdGUodmJhc2VkZXYpOw0KPj4gKw0KPnlvdSBzaGFs
bCBmcmVlIG9uIGVycm9yOiBhcyB3ZWxsDQoNCkkgZnJlZSBpdCBpbiB2ZmlvX2luc3RhbmNlX2Zp
bmFsaXplKCkuDQpWZmlvLXBjaSdzIGRlc2lnbiBpcyBzcGVjaWFsLCBpdCBkaWRuJ3QgZnJlZSBh
bGwgYWxsb2NhdGVkIHJlc291cmNlcyBpbiByZWFsaXplJ3MgZXJyb3IgcGF0aCwNClRoZXkgYXJl
IGZyZWVkIGluIF9maW5hbGl6ZSgpLiBlLmcuLCB2ZGV2LT5lbXVsYXRlZF9jb25maWdfYml0cywg
dmRldi0+cm9tLCBkZXZpY2VzIGFuZCBncm91cCByZXNvdXJjZXModmZpb19kZXRhY2hfZGV2aWNl
KS4NCkknbSBmb2xsb3dpbmcgdGhlIHNhbWUgd2F5LiBJJ20gZmluZSB0byBmcmVlIGl0IGFzIHlv
dSBzdWdnZXN0ZWQgc29tZXRoaW5nIGxpa2UgYmVsb3c6DQoNCi0tLSBhL2h3L3ZmaW8vcGNpLmMN
CisrKyBiL2h3L3ZmaW8vcGNpLmMNCkBAIC0zMjQ2LDYgKzMyNDYsNyBAQCBvdXRfdGVhcmRvd246
DQogICAgIHZmaW9fdGVhcmRvd25fbXNpKHZkZXYpOw0KICAgICB2ZmlvX2JhcnNfZXhpdCh2ZGV2
KTsNCiBlcnJvcjoNCisgICAgZ19mcmVlKHZkZXYtPnZiYXNlZGV2LmJhc2VfaGRldik7DQogICAg
IGVycm9yX3ByZXBlbmQoZXJycCwgVkZJT19NU0dfUFJFRklYLCB2YmFzZWRldi0+bmFtZSk7DQog
fQ0KDQpAQCAtMzI4OCw2ICszMjg5LDcgQEAgc3RhdGljIHZvaWQgdmZpb19leGl0Zm4oUENJRGV2
aWNlICpwZGV2KQ0KICAgICB2ZmlvX2JhcnNfZXhpdCh2ZGV2KTsNCiAgICAgdmZpb19taWdyYXRp
b25fZXhpdCh2YmFzZWRldik7DQogICAgIHBjaV9kZXZpY2VfdW5zZXRfaW9tbXVfZGV2aWNlKHBk
ZXYpOw0KKyAgICBnX2ZyZWUodmRldi0+dmJhc2VkZXYuYmFzZV9oZGV2KTsNCiB9DQoNCj4NCj5F
cmljDQo+PiAgICAgIHZmaW9fcG9wdWxhdGVfZGV2aWNlKHZkZXYsICZlcnIpOw0KPj4gICAgICBp
ZiAoZXJyKSB7DQo+PiAgICAgICAgICBlcnJvcl9wcm9wYWdhdGUoZXJycCwgZXJyKTsNCj4+IEBA
IC0zMjQ0LDYgKzMyNDcsNyBAQCBzdGF0aWMgdm9pZCB2ZmlvX2luc3RhbmNlX2ZpbmFsaXplKE9i
amVjdCAqb2JqKQ0KPj4NCj4+ICAgICAgdmZpb19kaXNwbGF5X2ZpbmFsaXplKHZkZXYpOw0KPj4g
ICAgICB2ZmlvX2JhcnNfZmluYWxpemUodmRldik7DQo+PiArICAgIGdfZnJlZSh2ZGV2LT52YmFz
ZWRldi5iYXNlX2hkZXYpOw0KDQpJIGZyZWUgaXQgaGVyZS4NCg0KVGhhbmtzDQpaaGVuemhvbmcN
Cg0KPj4gICAgICBnX2ZyZWUodmRldi0+ZW11bGF0ZWRfY29uZmlnX2JpdHMpOw0KPj4gICAgICBn
X2ZyZWUodmRldi0+cm9tKTsNCj4+ICAgICAgLyoNCg0K

