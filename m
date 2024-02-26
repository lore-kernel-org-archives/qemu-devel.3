Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 72970C48BF6
	for <qemu-devel@archiver.kernel.org>; Mon, 26 Feb 2024 09:15:26 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1reX4B-0003Ff-N7; Mon, 26 Feb 2024 04:14:31 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <zhenzhong.duan@intel.com>)
 id 1reX43-0003Ef-3E
 for qemu-devel@nongnu.org; Mon, 26 Feb 2024 04:14:24 -0500
Received: from mgamail.intel.com ([198.175.65.12])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <zhenzhong.duan@intel.com>)
 id 1reX3z-0004wK-QK
 for qemu-devel@nongnu.org; Mon, 26 Feb 2024 04:14:22 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1708938860; x=1740474860;
 h=from:to:cc:subject:date:message-id:references:
 in-reply-to:content-transfer-encoding:mime-version;
 bh=IhKTyFhbJzhwOm/ABScGJbZr73O78HWvqvX2m4iSrzk=;
 b=DDXkMstZStEfAvMMQ/oEm0dEg1NXeFw2n3NzJp/Fv+oSULf8amqMFG3e
 EAZXXSaQU8dFKqS/D12e7nirmAov484K+mLN0ZqUDxRl0EfPEMPpXQGJX
 rxZWoYHFRgCk0OTHJTgo9llgtA8x4naPvI5mf4ly+W7LUIuDhhnKKbQFj
 tRM/j9NXBwHReqY0k4Wezn9fmS4flxlx+Z111KgY9w9lciXDTTSq7LrwY
 mzV6ua4lnpwJ+Acz0q7KndLtHmyOJrzYX9xWjkvgf3rxi1VF+5QbQthVe
 DJ+9ZOLt6EqoHsBYF5INaZLILhL0oWNaGFPtazBywn0MNbc6354Cy0/zG g==;
X-IronPort-AV: E=McAfee;i="6600,9927,10995"; a="14646427"
X-IronPort-AV: E=Sophos;i="6.06,185,1705392000"; d="scan'208";a="14646427"
Received: from fmviesa001.fm.intel.com ([10.60.135.141])
 by orvoesa104.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 26 Feb 2024 01:14:17 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.06,185,1705392000"; d="scan'208";a="37606495"
Received: from orsmsx602.amr.corp.intel.com ([10.22.229.15])
 by fmviesa001.fm.intel.com with ESMTP/TLS/AES256-GCM-SHA384;
 26 Feb 2024 01:14:15 -0800
Received: from orsmsx610.amr.corp.intel.com (10.22.229.23) by
 ORSMSX602.amr.corp.intel.com (10.22.229.15) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35; Mon, 26 Feb 2024 01:14:14 -0800
Received: from orsmsx610.amr.corp.intel.com (10.22.229.23) by
 ORSMSX610.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35; Mon, 26 Feb 2024 01:14:14 -0800
Received: from orsedg603.ED.cps.intel.com (10.7.248.4) by
 orsmsx610.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35 via Frontend Transport; Mon, 26 Feb 2024 01:14:14 -0800
Received: from NAM04-MW2-obe.outbound.protection.outlook.com (104.47.73.168)
 by edgegateway.intel.com (134.134.137.100) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.35; Mon, 26 Feb 2024 01:14:14 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=PHnm3F8VhmXx5EIuwOq55wWWuAQ7WjVpwq2U4QX0xhC4hYEWza/2vXA2rDcXsCxyJOBSRw8SLx+ccApTS3Goih/mldG13rAU9LuZZHkXQ1oHqdoOAK2yVSWiwfZI5yBEda63fU1yfQMv7akWFRglvLqvGBfdbXL+eJyAS7+2ic9VCJWaKYDtf2LOt9QJmhWFa+ajpPJgFu8w/6IZXbnIAV4jTZkXU16qufLAiuvm6Hvh2bdNiAf7aQx6M9M8BU3taW1AgTIT5DosmZrEcILWxWUd+/EjnzK98Ydckg4KlPZxG8bIz+ZE+pp7wVyHzzTgIa//I9te7C3+tndT1VK8Xg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=IhKTyFhbJzhwOm/ABScGJbZr73O78HWvqvX2m4iSrzk=;
 b=BjG/T1MXhDQ23u7YYJIhs79Hf5nTkiMhEBGMCrlbxYeXb0bQsky9VBasOF0RgOIwYcDxo0OhgmnVhuWtM2/4yAapDMSK9CNVwc0RmXmx6qvxklkK6a7ko7dih2CAGNkKv+ljWWq8aoD71s4h5HO++MYBb6VKJajbyEq8oPGPq5R16/yPrDtg44H7mokdB3tgEBZHzLK5ez3G/5m/Dr+NMMaKUyU9LuqBK2S5t8imOhM6EWWpxWiUC+bibGwbE9m1xhX7BWEe4PXDrMXEZc3Msd6OIAEhc2+aHEyO9fe8cDTFHXnwtjxdUvKBrhKkK7rC28mpb/SDQQ/joVNU7Ludwg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Received: from SJ0PR11MB6744.namprd11.prod.outlook.com (2603:10b6:a03:47d::10)
 by CH3PR11MB8658.namprd11.prod.outlook.com (2603:10b6:610:1c5::17)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7339.22; Mon, 26 Feb
 2024 09:14:12 +0000
Received: from SJ0PR11MB6744.namprd11.prod.outlook.com
 ([fe80::c0f3:15d4:d7f6:a72a]) by SJ0PR11MB6744.namprd11.prod.outlook.com
 ([fe80::c0f3:15d4:d7f6:a72a%4]) with mapi id 15.20.7339.009; Mon, 26 Feb 2024
 09:14:12 +0000
From: "Duan, Zhenzhong" <zhenzhong.duan@intel.com>
To: Joao Martins <joao.m.martins@oracle.com>, Jason Gunthorpe <jgg@nvidia.com>
CC: "qemu-devel@nongnu.org" <qemu-devel@nongnu.org>, "Liu, Yi L"
 <yi.l.liu@intel.com>, Eric Auger <eric.auger@redhat.com>, Alex Williamson
 <alex.williamson@redhat.com>, Cedric Le Goater <clg@redhat.com>, "Paolo
 Bonzini" <pbonzini@redhat.com>, "Daniel P . Berrange" <berrange@redhat.com>,
 Eduardo Habkost <eduardo@habkost.net>, Eric Blake <eblake@redhat.com>,
 "Markus Armbruster" <armbru@redhat.com>, Avihai Horon <avihaih@nvidia.com>
Subject: RE: [PATCH RFCv2 2/8] vfio/iommufd: Introduce auto domain creation
Thread-Topic: [PATCH RFCv2 2/8] vfio/iommufd: Introduce auto domain creation
Thread-Index: AQHaXbtj/4vuXfZe3UWgZq/jPoutv7EG5WiAgAAcPYCAFWpoUA==
Date: Mon, 26 Feb 2024 09:14:12 +0000
Message-ID: <SJ0PR11MB6744CB291377BDD06FF5FFDA925A2@SJ0PR11MB6744.namprd11.prod.outlook.com>
References: <20240212135643.5858-1-joao.m.martins@oracle.com>
 <20240212135643.5858-3-joao.m.martins@oracle.com>
 <20240212162757.GC4048826@nvidia.com>
 <eb1167aa-e7f4-47bf-8d1f-8669399a16a8@oracle.com>
In-Reply-To: <eb1167aa-e7f4-47bf-8d1f-8669399a16a8@oracle.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: SJ0PR11MB6744:EE_|CH3PR11MB8658:EE_
x-ms-office365-filtering-correlation-id: 747c0bb2-0285-40d3-3913-08dc36ab4c11
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: bAEI1rpESmssJUWNjdf1lJUVpJG8rsps9cxWnRirJN7/9AT+WXmXIuNFjQLrSzZWRFYZHSDNcbENUnWvaYkX3M016C5b96O/qF3wC77hTl9XNaROfVHeiCG7Bvo/XnknKVH5SuyOWcibs4BjZy7ywNMP4S6qLV+99WT37BHMwA0ZuJPDh0uUHMIwrKhisuNbfPkGIOXckGFXg6jCGVPa3f+lJaC7c2oYgk3SyoVmsTPi5iESa+D4pA6lSlHUVGhsMlRJFNtpINH0YV6WCp5z5ACheIzm01nHa0he88HSDJG2mgSWaP4C4sjAXXUWBdCN4L/nsdIsDV9YUEWe6ahSTZsQpGVxAFb5Lf4djhOw/syKKdiCCs23UcvZPNyOIThw31t+v+GqiwR8kfWETcui5DrK3IFIfDgsQLFoCAivJ/H1hzHemHOJsBS5vztIJIMz7V3FxC8TfkQ/r/+4pFoFDykGyEHd/moboAFuL6zOyFmlD5Z7v/Xioggy12HwPuUCkQzpaysLv581I1M5kBoXnKbItNdhJp0+71FldlrW2vqPROIb3HAKgYnBJ1EvoOcIQku42OaPbJyN8RoqWBancU+esM34dPFQbeHDAR1rS81giRT29gorY5fouqEWyV8MxKYSY1Ug3rRFONZaNFhzpmiTxOCi1Tz8dHFj6UBkexweGmtj0vlLvYA1bB5xIciQdZHGpoS8nCqvu+HeG57phA==
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:SJ0PR11MB6744.namprd11.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230031)(38070700009); DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?enhkQVliMmk3dnlvUUhtVFlSZHpLKy9DbjBrMytHWkdPZThXTVducWJFazJz?=
 =?utf-8?B?YWNGL2lZMHNGVHl4TDZJdzNueU5tN3A1dlFVVkxEcVduRjhycjFGWE5LeGhq?=
 =?utf-8?B?VlgzV2tlYUcyTEZncW1aVXFhd3BpVE5nNWNBMlNvSVM5SElpMDMva24vNU1Q?=
 =?utf-8?B?SnRjSnUvZkpUY2k1NzlmMHdZL014aGVwS0FUTUd6TUJVQnltMjU1K0pzaUhI?=
 =?utf-8?B?eHBNQXZlTWVld2ZyK1lTUXhpVnBIaTk2MkVVZTZxNmxLSnRHV3N1Yzkrb0Vj?=
 =?utf-8?B?UnRHRjRXR0xUeHB5WWJyZ1R5Vk9WR3FVMkhnU0tzTHUxQ245OEpIVjNMNzRJ?=
 =?utf-8?B?aEZsR0VXQ0c4ay9UWTFCU21vVitxc1JzODJhMFNrUWVRbWcxK3BNZng1UjZl?=
 =?utf-8?B?YXhZd1M0ZEdxZTI2MXZjbHFiOXltUmJOVXdraEp4Rk9DMkFWSUdzbHNxMXVO?=
 =?utf-8?B?VEtpVGIvQnVuR2xiSE5yMGVjMng4R1RxQnplZWdsUnJERitySVo1NUVqVExF?=
 =?utf-8?B?SUpacjc4aWo0dTNjWWtLMStxdlFNTHM4VkhkMXdDOWNveHhzYmdySDBkcFFo?=
 =?utf-8?B?TGZMYUNlNGo5UmdBYXpTRnBISnhNZkdUYWdNUE9uSS9KOEdORXlqTDAwMXhm?=
 =?utf-8?B?RVNSeVRyN1FpUEY1TXgwaXdJbW5KNUFyOHg2c0JBRThJeUI5M21QL3FsemZE?=
 =?utf-8?B?bFRNL24vVnZRNzdOVGRSMXBhYUl4KzQzNlZqZEttS2NoK0taWFdwRkFrRHpn?=
 =?utf-8?B?SmxQSGs4dEJnbURoUndPTFpWTW5BckdEWVMrS2VGRmdVQ0o2K2V0eVkwZk1m?=
 =?utf-8?B?MnpkY2M5RzBTeXFHcEszcTlIRXhQcmdjaEVKQy9INkNzbkQxRW1jYkZHbDZF?=
 =?utf-8?B?Z3ZsK3hWb3phekxlVk5IUE1HbDVHM2UrLzE1d3I2UDRVKzc0dDQwN3EzdC9p?=
 =?utf-8?B?YWR5RkJJU1RaMTJUczMvL083dGtZOFBxL3dKRlhkSGpLanNYNEtLYUNHQ2Js?=
 =?utf-8?B?b1hhTHBzYkIva29LbVY1cTh6RGQvWGZ0b2JxU0txOTVTY2YvSnZYdXVNWUtG?=
 =?utf-8?B?RmhUNTFEVDY2OUxMdFpVcEtHT0QraUxQeDExNEZJQXduUnYweDZlQmVsNWlk?=
 =?utf-8?B?aTdRTWgrZ3BNd0dSeE56WE13amNPOG1nY2c5WWZaK0I3a05LVEx5bGpWKys0?=
 =?utf-8?B?VXFuaWsvWGRROTZhSkp0cDJxRFdvMnk4OXpITkJ3aC9zbXlPb0xjUTVDcjdF?=
 =?utf-8?B?ZEt0VEJIRld0Q1JkYWVhVUNpVGF0Qy9veUNoTEsycmYxM01DeHdGUjdnOUlU?=
 =?utf-8?B?TEszbC9hQVZ6bitBNUR0T1NyMEE5R0k3Wml3UHlVK3AwcytFVk5sQk5MQ2Nz?=
 =?utf-8?B?YjM4clYyVWd4VlA3bXRYV2ZUVVZISm1Ua0pydkhuU0pUQjlpbnNmbzFvSEJI?=
 =?utf-8?B?b08ybk1GYVI1VEM1cTlxUjJxQkE4VlZ1NmZOVkllaVlIZEkxR2NzbEhIK1Bu?=
 =?utf-8?B?QjRtNWp4Y3hKaWlXNUNsM1Z3bVFidUNKUWd5dlZoR2w5ZHlvblM1QTRjZHJX?=
 =?utf-8?B?a2plejVuUTRqZ0tqNDY2cjc3QzFFTVJURFBTSFc4S09USGlScHcrTlFUQStw?=
 =?utf-8?B?TE1ib09uWlliMjEyOENmbUd1Rkd2NWNvNUVsd1hBSkZQSm94citXOGtwQmp4?=
 =?utf-8?B?SjlQd2k0eVpLeHBmby9vTU9UNm1vNGxrSXoybWJac3hzUTFzRGpmZHZEVy9I?=
 =?utf-8?B?aDZTaWtCaDJYS0NiU2lYaFgxTmtWWmFYRW5GR2FObm5PKzlDSXpURi9OMlpt?=
 =?utf-8?B?ckd6ZDFFUWhKNG91bDZwNEFDaG9aZmwvQzQwUXVFNi8yeFpsQ0NYVjZzYTZh?=
 =?utf-8?B?VjlhQ29RYU4xV3VlZWFIeUhGcDRvWURpTGowU0xENmVCMm1JRnpobndSTG5z?=
 =?utf-8?B?TzcwZFNsUkxQNWZIQTYrbnpFOVp6TnlOL2ZtUzFYZHZPN1FNREs3VzFkVVI3?=
 =?utf-8?B?eWFmUFZnNVdQUFZROXFZdXd3Ymh0Q3M1QWc0UWNIb21ITUpUTXdjSFQrSHJp?=
 =?utf-8?B?cWFrbzhqV3BMaEY1ZXlzZlYrNU5tVXRETTgwa09ZYU5UOWRNbTd2bFp6c1RZ?=
 =?utf-8?Q?+M+ocXC1NmdGNnO5KFupZuK19?=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: SJ0PR11MB6744.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 747c0bb2-0285-40d3-3913-08dc36ab4c11
X-MS-Exchange-CrossTenant-originalarrivaltime: 26 Feb 2024 09:14:12.3030 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: XefM/zfHAnxHglv6Pj7v5Ew+r6E2PkXDI286F78DIyGXFpsLQ8bJ+Do2PCK3m3t1VJhK1XMD4hqTXHVpH7DDvPViUNxJAH/UYCeEggPygZ8=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH3PR11MB8658
X-OriginatorOrg: intel.com
Received-SPF: pass client-ip=198.175.65.12;
 envelope-from=zhenzhong.duan@intel.com; helo=mgamail.intel.com
X-Spam_score_int: -21
X-Spam_score: -2.2
X-Spam_bar: --
X-Spam_report: (-2.2 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.097,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
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

DQoNCj4tLS0tLU9yaWdpbmFsIE1lc3NhZ2UtLS0tLQ0KPkZyb206IEpvYW8gTWFydGlucyA8am9h
by5tLm1hcnRpbnNAb3JhY2xlLmNvbT4NCj5TdWJqZWN0OiBSZTogW1BBVENIIFJGQ3YyIDIvOF0g
dmZpby9pb21tdWZkOiBJbnRyb2R1Y2UgYXV0byBkb21haW4NCj5jcmVhdGlvbg0KPg0KPk9uIDEy
LzAyLzIwMjQgMTY6MjcsIEphc29uIEd1bnRob3JwZSB3cm90ZToNCj4+IE9uIE1vbiwgRmViIDEy
LCAyMDI0IGF0IDAxOjU2OjM3UE0gKzAwMDAsIEpvYW8gTWFydGlucyB3cm90ZToNCj4+PiBUaGVy
ZSdzIGdlbmVyYWxseSB0d28gbW9kZXMgb2Ygb3BlcmF0aW9uIGZvciBJT01NVUZEOg0KPj4+DQo+
Pj4gKiBUaGUgc2ltcGxlIHVzZXIgQVBJIHdoaWNoIGludGVuZHMgdG8gcGVyZm9ybSByZWxhdGl2
ZWx5IHNpbXBsZSB0aGluZ3MNCj4+PiB3aXRoIElPTU1VcyBlLmcuIERQREsuIEl0IGdlbmVyYWxs
eSBjcmVhdGVzIGFuIElPQVMgYW5kIGF0dGFjaCB0byBWRklPDQo+Pj4gYW5kIG1haW5seSBwZXJm
b3JtcyBJT0FTX01BUCBhbmQgVU5NQVAuDQo+Pj4NCj4+PiAqIFRoZSBuYXRpdmUgSU9NTVVGRCBB
UEkgd2hlcmUgeW91IGhhdmUgZmluZSBncmFpbmVkIGNvbnRyb2wgb2YgdGhlDQo+Pj4gSU9NTVUg
ZG9tYWluIGFuZCBtb2RlbCBpdCBhY2NvcmRpbmdseS4gVGhpcyBpcyB3aGVyZSBtb3N0IG5ldyBm
ZWF0dXJlDQo+Pj4gYXJlIGJlaW5nIHN0ZWVyZWQgdG8uDQo+Pj4NCj4+PiBGb3IgZGlydHkgdHJh
Y2tpbmcgMikgaXMgcmVxdWlyZWQsIGFzIGl0IG5lZWRzIHRvIGVuc3VyZSB0aGF0DQo+Pj4gdGhl
IHN0YWdlLTIvcGFyZW50IElPTU1VIGRvbWFpbiB3aWxsIG9ubHkgYXR0YWNoIGRldmljZXMNCj4+
PiB0aGF0IHN1cHBvcnQgZGlydHkgdHJhY2tpbmcgKHNvIGZhciBpdCBpcyBhbGwgaG9tb2dlbmVv
dXMgaW4geDg2LCBsaWtlbHkNCj4+PiBub3QgdGhlIGNhc2UgZm9yIHNtbXV2MykuIFN1Y2ggaW52
YXJpYW50IG9uIGRpcnR5IHRyYWNraW5nIHByb3ZpZGVzIGENCj4+PiB1c2VmdWwgZ3VhcmFudGVl
IHRvIFZNTXMgdGhhdCB3aWxsIHJlZnVzZSBpbmNvbXBhdGlibGUgZGV2aWNlDQo+Pj4gYXR0YWNo
bWVudHMgZm9yIElPTU1VIGRvbWFpbnMuDQo+Pj4NCj4+PiBGb3IgZGlydHkgdHJhY2tpbmcgc3Vj
aCBwcm9wZXJ0eSBpcyBlbmFibGVkL2VuZm9yY2VkIHZpYSBIV1BUX0FMTE9DLA0KPj4+IHdoaWNo
IGlzIHJlc3BvbnNpYmxlIGZvciBjcmVhdGluZyBhbiBJT01NVSBkb21haW4uIFRoaXMgaXMgY29u
dHJhc3QgdG8NCj4+PiB0aGUgJ3NpbXBsZSBBUEknIHdoZXJlIHRoZSBJT01NVSBkb21haW4gaXMg
Y3JlYXRlZCBieSBJT01NVUZEDQo+Pj4gYXV0b21hdGljYWxseSB3aGVuIGl0IGF0dGFjaGVzIHRv
IFZGSU8gKHVzdWFsbHkgcmVmZXJyZWQgYXMgYXV0b2RvbWFpbnMpDQo+Pj4NCj4+PiBUbyBzdXBw
b3J0IGRpcnR5IHRyYWNraW5nIHdpdGggdGhlIGFkdmFuY2VkIElPTU1VRkQgQVBJLCBpdCBuZWVk
cw0KPj4+IHNpbWlsYXIgbG9naWMsIHdoZXJlIElPTU1VIGRvbWFpbnMgYXJlIGNyZWF0ZWQgYW5k
IGRldmljZXMgYXR0YWNoZWQgdG8NCj4+PiBjb21wYXRpYmxlIGRvbWFpbnMuIEVzc2VudGlhbGx5
IG1pbW1pY2luZyBrZXJuZWwNCj4+PiBpb21tdWZkX2RldmljZV9hdXRvX2dldF9kb21haW4oKS4g
SWYgdGhpcyBmYWlscyAoaS5lLiBtZGV2cykgaXQgZmFsbHMgYmFjaw0KPj4+IHRvIElPQVMgYXR0
YWNoLg0KPj4+DQo+Pj4gU2lnbmVkLW9mZi1ieTogSm9hbyBNYXJ0aW5zIDxqb2FvLm0ubWFydGlu
c0BvcmFjbGUuY29tPg0KPj4+IC0tLQ0KPj4+IFJpZ2h0IG5vdyB0aGUgb25seSBhbHRlcm5hdGl2
ZSB0byBhIHVzZXJzcGFjZSBhdXRvZG9tYWlucw0KPmltcGxlbWVudGF0aW9uDQo+Pj4gaXMgdG8g
bWltbWljaW5nIGFsbCB0aGUgZmxhZ3MgYmVpbmcgYWRkZWQgdG8gSFdQVF9BTExPQyBidXQgaW50
byBWRklPDQo+Pj4gSU9BUyBhdHRhY2guDQo+Pg0KPj4gSXQgd2FzIG15IGV4cGVjdGF0aW9uIHRo
YXQgVk1NIHVzZXJzcGFjZSB3b3VsZCBpbXBsZW1lbnQgZGlyZWN0IGh3cHQNCj4+IHN1cHBvcnQu
IFRoaXMgaXMgbmVlZGVkIGluIGFsbCBraW5kcyBvZiBjYXNlcyBnb2luZyBmb3J3YXJkIGJlY2F1
c2UNCj4+IGh3cHQgYWxsb2NhdGlvbiBpcyBub3QgdW5pZm9ybSBhY3Jvc3MgaW9tbXUgaW5zdGFu
Y2VzIGFuZCBtYW5hZ2luZw0KPj4gdGhpcyBpbiB0aGUga2VybmVsIGlzIG9ubHkgZmVhc2libGUg
Zm9yIHNpbXBsZXIgY2FzZXMuIERpcnR5IHRyYWNraW5nDQo+PiB3b3VsZCBiZSBvbmUgb2YgdGhl
bS4NCj4+DQo+DQo+L21lIG5vZHMNCj4NCj4+PiAraW50IGlvbW11ZmRfYmFja2VuZF9hbGxvY19o
d3B0KGludCBpb21tdWZkLCB1aW50MzJfdCBkZXZfaWQsDQo+Pj4gKyAgICAgICAgICAgICAgICAg
ICAgICAgICAgICAgICB1aW50MzJfdCBwdF9pZCwgdWludDMyX3QgZmxhZ3MsDQo+Pj4gKyAgICAg
ICAgICAgICAgICAgICAgICAgICAgICAgICB1aW50MzJfdCBkYXRhX3R5cGUsIHVpbnQzMl90IGRh
dGFfbGVuLA0KPj4+ICsgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgdm9pZCAqZGF0YV9w
dHIsIHVpbnQzMl90ICpvdXRfaHdwdCkNCj4+PiArew0KPj4+ICsgICAgaW50IHJldDsNCj4+PiAr
ICAgIHN0cnVjdCBpb21tdV9od3B0X2FsbG9jIGFsbG9jX2h3cHQgPSB7DQo+Pj4gKyAgICAgICAg
LnNpemUgPSBzaXplb2Yoc3RydWN0IGlvbW11X2h3cHRfYWxsb2MpLA0KPj4+ICsgICAgICAgIC5m
bGFncyA9IGZsYWdzLA0KPj4+ICsgICAgICAgIC5kZXZfaWQgPSBkZXZfaWQsDQo+Pj4gKyAgICAg
ICAgLnB0X2lkID0gcHRfaWQsDQo+Pj4gKyAgICAgICAgLmRhdGFfdHlwZSA9IGRhdGFfdHlwZSwN
Cj4+PiArICAgICAgICAuZGF0YV9sZW4gPSBkYXRhX2xlbiwNCj4+PiArICAgICAgICAuZGF0YV91
cHRyID0gKHVpbnQ2NF90KWRhdGFfcHRyLA0KPj4+ICsgICAgICAgIC5fX3Jlc2VydmVkID0gMCwN
Cj4+DQo+PiBVbmxlc3MgdGhlIGNvZGluZyBzdHlsZSByZXF1aXJzIHRoaXMgaXQgaXMgbm90IG5l
Y2Vzc2FyeSB0byB6ZXJvIGluDQo+PiB0aGUgX19yZXNlcnZlZCB3aXRoaW4gYSBicmFja2V0ZWQg
aW4gaW5pdGlhbGl6ZXIuLg0KPj4NCj4NCj5BaCB5ZXM7IGFuZCBubyBvdGhlciBoZWxwZXIgaXMg
ZG9pbmcgdGhpcywgc28gZGVmaW5pdGVseSBkb2Vzbid0IGxvb2sgY29kZQ0KPnN0eWxlLiBJJ2xs
IHJlbW92ZSBpdC4NCj4NCj4+PiArc3RhdGljIGludCBpb21tdWZkX2NkZXZfYXV0b2RvbWFpbnNf
Z2V0KFZGSU9EZXZpY2UgKnZiYXNlZGV2LA0KPj4+ICsgICAgICAgICAgICAgICAgICAgICAgICAg
ICAgICAgICAgICAgICAgVkZJT0lPTU1VRkRDb250YWluZXIgKmNvbnRhaW5lciwNCj4+PiArICAg
ICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgIEVycm9yICoqZXJycCkNCj4+PiAr
ew0KPj4+ICsgICAgaW50IGlvbW11ZmQgPSB2YmFzZWRldi0+aW9tbXVmZF9kZXYuaW9tbXVmZC0+
ZmQ7DQo+Pj4gKyAgICBWRklPSU9BU0h3cHQgKmh3cHQ7DQo+Pj4gKyAgICBFcnJvciAqZXJyID0g
TlVMTDsNCj4+PiArICAgIGludCByZXQgPSAtRUlOVkFMOw0KPj4+ICsgICAgdWludDMyX3QgaHdw
dF9pZDsNCj4+PiArDQo+Pj4gKyAgICAvKiBUcnkgdG8gZmluZCBhIGRvbWFpbiAqLw0KPj4+ICsg
ICAgUUxJU1RfRk9SRUFDSChod3B0LCAmY29udGFpbmVyLT5od3B0X2xpc3QsIG5leHQpIHsNCj4+
PiArICAgICAgICByZXQgPSBpb21tdWZkX2NkZXZfYXR0YWNoX2lvYXNfaHdwdCh2YmFzZWRldiwg
aHdwdC0+aHdwdF9pZCwNCj4mZXJyKTsNCj4+PiArICAgICAgICBpZiAocmV0KSB7DQo+Pj4gKyAg
ICAgICAgICAgIC8qIC1FSU5WQUwgbWVhbnMgdGhlIGRvbWFpbiBpcyBpbmNvbXBhdGlibGUgd2l0
aCB0aGUgZGV2aWNlLiAqLw0KPj4+ICsgICAgICAgICAgICBpZiAocmV0ID09IC1FSU5WQUwpIHsN
Cj4+DQo+PiBQbGVhc2Ugc2VuZCBhIGtlcm5lbCBrZG9jIHBhdGNoIHRvIGRvY3VtZW50IHRoaXMu
Lg0KPj4NCj4NCj5BY2sNCj4NCj4+IFRoZSBhcHByb2FjaCBsb29rcyBnb29kIHRvIG1lDQo+Pg0K
Pj4gVGhlIG5lc3RpbmcgcGF0Y2hlcyBzdXJlbHkgbmVlZCB0aGlzIHRvbz8NCj4NCj5Gcm9tIHdo
YXQgSSB1bmRlcnN0YW5kLCB5ZXMsIGJ1dCB0aGV5IHNlZW0gdG8gYmUgYWJsZSB0byBoaWQgdGhp
cyBpbnNpZGUNCj5pbnRlbC1pb21tdSBmb3IgdGhlIHBhcmVudCBod3B0IGFsbG9jYXRpb24gc29t
ZWhvdy4gSSdsbCBsZXQgdGhlbSBjb21tZW50Ow0KDQpZZXMsIHdlIGhhdmUgc2ltaWxhciBpbXBs
ZW1lbnRhdGlvbiBpbiBuZXN0aW5nIHNlcmllcy4gU2VlIHZ0ZF9kZXZpY2VfYXR0YWNoX2NvbnRh
aW5lcigpIGluDQpodHRwczovL2xpc3RzLmdudS5vcmcvYXJjaGl2ZS9odG1sL3FlbXUtZGV2ZWwv
MjAyNC0wMS9tc2cwMjc1MC5odG1sDQoNClRoYW5rcw0KWmhlbnpob25nDQo=

