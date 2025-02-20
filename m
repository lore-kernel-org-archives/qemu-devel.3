Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B769DC021B0
	for <qemu-devel@archiver.kernel.org>; Thu, 20 Feb 2025 04:25:28 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tky6u-0006uh-Ii; Wed, 19 Feb 2025 23:24:29 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <zhenzhong.duan@intel.com>)
 id 1tky6p-0006uO-55
 for qemu-devel@nongnu.org; Wed, 19 Feb 2025 23:24:23 -0500
Received: from mgamail.intel.com ([198.175.65.10])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <zhenzhong.duan@intel.com>)
 id 1tky6l-0003TO-Uz
 for qemu-devel@nongnu.org; Wed, 19 Feb 2025 23:24:22 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1740025460; x=1771561460;
 h=from:to:cc:subject:date:message-id:references:
 in-reply-to:content-transfer-encoding:mime-version;
 bh=q9N5hoRpVrwcrhlkE4SMMdil/bS3EvEDAydoz5Ar538=;
 b=VNDTKog8rYv9rlgugMbKiwtgeq1WSbIa7bgDUee7ark916RM1dpOrQ++
 qBEQDYpaBPmz6wzzz/G8ZNR4BwdrkSLzphMT1cLl3Bt/8392F0Vk5bjOj
 3i+xwIHtMRziSzXJJKngrQkABIpAwCcgpRUMU2OXkMRmzMPh+/bv1mTmh
 pYYdwa7xrg2jNu31eQfZYb5PRd3CK8B8ow/RzUvKx2yOouMq+TozSX4Vl
 V9OHa4EIU2ZNnmQCSbrHQSksmOQ65/yp2TVt2XoL0GEaMB3TBmjspuBXQ
 bZHY/pAmXymSpRGQojclYLY3/62FFoZmQ+Nr74lbs6xk0Er8A1xmsGLok A==;
X-CSE-ConnectionGUID: JpIriLIKTPuchYpcSZIZMg==
X-CSE-MsgGUID: OpyXkL38Qq6QV8Jrtt8klQ==
X-IronPort-AV: E=McAfee;i="6700,10204,11350"; a="58197024"
X-IronPort-AV: E=Sophos;i="6.13,300,1732608000"; d="scan'208";a="58197024"
Received: from orviesa006.jf.intel.com ([10.64.159.146])
 by orvoesa102.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 19 Feb 2025 20:24:16 -0800
X-CSE-ConnectionGUID: QaEeVt16QSyLgsoq3RZqxg==
X-CSE-MsgGUID: zbmG9FspTHmsW0gasf3I6g==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.13,300,1732608000"; d="scan'208";a="114870403"
Received: from orsmsx901.amr.corp.intel.com ([10.22.229.23])
 by orviesa006.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 19 Feb 2025 20:24:16 -0800
Received: from ORSMSX901.amr.corp.intel.com (10.22.229.23) by
 ORSMSX901.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.14; Wed, 19 Feb 2025 20:24:15 -0800
Received: from ORSEDG601.ED.cps.intel.com (10.7.248.6) by
 ORSMSX901.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.14 via Frontend Transport; Wed, 19 Feb 2025 20:24:15 -0800
Received: from NAM11-CO1-obe.outbound.protection.outlook.com (104.47.56.171)
 by edgegateway.intel.com (134.134.137.102) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.44; Wed, 19 Feb 2025 20:24:15 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=mvg/AET877wfjga+yhBuZA6t84jt1YKBJncdeScT2B+X9GeaqpN8qDLh/uvg4ldEUEdUqbTN+k0qApBU/Uyh4PN7GnqY6/EbIOzS8Gqmqv3yRPqzHo3ZlXG0Cg+APvmAM1whYXU48kCFeHa3n4TBy29KeTxy+r0AdFzVW1u5+79osSgAw7nt8wLk1F9hmh4YNAhWWP1kPjWbRDwAo8GY1fPTSAuLy1N1Wqyrli5z5p1PEVftc0SHNz1SYEboKO++3GRycy5XPxfyGdFIrQ8KAKjyY0BLQmQAGO0mldRP8gJprMdUGBAsGwkUraZs1yYHoae0sg4/ZrcRF8zXtqZgmQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=p1qVoDcLYazaVGLfssUAaOt3VBXFKtoRN2gFf+Pp5ko=;
 b=PaOO5erEmUwE08Fo4jR1v3wKCKMd5v/aNvjbY/rch3KUFTy/fiTWlvuCetubAJMYiwdE6dcYr12812QmFQELZ/HbbWYZQQiUWeexgxZZderjjrMIZiWh3UPLxsOuaqjz37yj4dv89WDXRUma8WKLC5RpwwxPuhD87ugcU79moiLglmvRjw2lRQzWVHC4Jx+D40xa9WwlfMNPEkofhnF6V42udD6tYLradUTbfi8p5455kQyWq25I3swMAsMZ6XQ0Kg6nVhWKNmzkQOJo+ik+PH6pxgvBTocfFfypNpXththdCMYrE3DtmzJ5tR5bj7rz7ySYi+nQf+BjyJfpIgM5yA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Received: from SJ0PR11MB6744.namprd11.prod.outlook.com (2603:10b6:a03:47d::10)
 by PH7PR11MB7122.namprd11.prod.outlook.com (2603:10b6:510:20d::16)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8466.14; Thu, 20 Feb
 2025 04:24:13 +0000
Received: from SJ0PR11MB6744.namprd11.prod.outlook.com
 ([fe80::fe49:d628:48b1:6091]) by SJ0PR11MB6744.namprd11.prod.outlook.com
 ([fe80::fe49:d628:48b1:6091%6]) with mapi id 15.20.8466.013; Thu, 20 Feb 2025
 04:24:13 +0000
From: "Duan, Zhenzhong" <zhenzhong.duan@intel.com>
To: Alex Williamson <alex.williamson@redhat.com>, Eric Auger
 <eric.auger@redhat.com>
CC: "eric.auger.pro@gmail.com" <eric.auger.pro@gmail.com>,
 "qemu-devel@nongnu.org" <qemu-devel@nongnu.org>, "clg@redhat.com"
 <clg@redhat.com>
Subject: RE: [RFC 0/2] hw/vfio/pci: Prevent BARs from being dma mapped in
 d3hot state
Thread-Topic: [RFC 0/2] hw/vfio/pci: Prevent BARs from being dma mapped in
 d3hot state
Thread-Index: AQHbgvuwzAAYetEsY0mcGqcnVFi6xLNO+qEAgACZYFA=
Date: Thu, 20 Feb 2025 04:24:13 +0000
Message-ID: <SJ0PR11MB674418674B2374371F2AA24692C42@SJ0PR11MB6744.namprd11.prod.outlook.com>
References: <20250219175941.135390-1-eric.auger@redhat.com>
 <20250219115844.062c5513.alex.williamson@redhat.com>
In-Reply-To: <20250219115844.062c5513.alex.williamson@redhat.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: SJ0PR11MB6744:EE_|PH7PR11MB7122:EE_
x-ms-office365-filtering-correlation-id: 4c2b6d52-130d-4692-3449-08dd51666e69
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0; ARA:13230040|1800799024|366016|376014|38070700018;
x-microsoft-antispam-message-info: =?us-ascii?Q?rAkbQAWE/MNUcIDYm4ZYEypcfbzKuCA4OhalMIYP1ezezsxxmA14YE1r8G8X?=
 =?us-ascii?Q?bp0HPINYogdmxSFIw4W21d6zfE+I9txI2xWAFP8yglcWUQwFWp4A9YJrE6LM?=
 =?us-ascii?Q?ucnU0npzu7eKG9ZJjC+9Usv/hqZaW255orV0cwH1A0WtibpzdFVaFMeQJYXO?=
 =?us-ascii?Q?j6NyA5ajq7J6u1m03CIW/ui/XWZCTQ0D4pGZJPcQj15Zg86NG03uSKnM18OH?=
 =?us-ascii?Q?OwJbznv38u0k3bMcBw1bFYg9H/tUA2zkM9ze0zfn8cY3v1Yrbdoe33XIjWVF?=
 =?us-ascii?Q?Ts+ilnCkCVlVCb4Bgvy3ukapGypzTeyTU5cIRcrFjgBZg/sRmsw/Y+0J/bXs?=
 =?us-ascii?Q?DgiiZvlnaeLid3JjFXLx1TNwWJbeXSupom8HFeJ1CVl3pCRgIhAKlS71NfhL?=
 =?us-ascii?Q?rZ8azaEw4h3l5hPSauTgm18w0niTXxcJPD54GnBmcALuwmkFOrHVji3R8KrX?=
 =?us-ascii?Q?xyZtkY6JKdquqpvZztI5jCw4OjAmI/UJSvT+DbpLAenacESxYP3cyU8oDI9+?=
 =?us-ascii?Q?gvfZcwoxbCno/ISLuh1UfCfi0i+Lyb0QhUapUiNU59g6dFGRqpf6hHANx/4M?=
 =?us-ascii?Q?1PxV16LkrTXdJfMRaTbtAtg00pEJstpGsh97DgFYNp4ESIviczboXG/favBI?=
 =?us-ascii?Q?u+TZg3HPmkIa5IrivtndfkQanmG2Oid+IiDB/do3kcGMHWhtPax5Y/gT1Mx+?=
 =?us-ascii?Q?DUyTq+c++le6Td9QKICofb0A8nalrc8oaS3vwa5lSxJrihH0YUbyH3KlV5cs?=
 =?us-ascii?Q?DY9mz/FJzeVTpZ5ya8aMtUrMdUxDxHYpjsr/xOc+ArEgi60/sUyxm9RDo0Hp?=
 =?us-ascii?Q?hXyih+zsG4VgirqUlB6rcVWIFNPHxo5EATNcBNADpl5iA2OKjNFBUC2Wwav6?=
 =?us-ascii?Q?HiiFy2w6O4aoT/wEPh7JVZMDQ9K8LkesKtFm7Al3FxbCnvRTg/o3sSjC1kQ2?=
 =?us-ascii?Q?o3MTkbf+nNLJa7ldR97zFIK+ZhQFN/F5i/WSN7/INl35i+Y9zgqWUADwsx6O?=
 =?us-ascii?Q?b3zmsM8grPffUxsqOwM3NFczCtPrir5caKsQ38H3QJUZErslnrRUpv4y7+7T?=
 =?us-ascii?Q?9u1uzwttQ0kzHV9Q3AGjy5H1ClSjuSAnegVlwtfG6GMxlWNBkx0Tudl7jPTg?=
 =?us-ascii?Q?fZmZVmb3isPQRH1rMDkIndaljlZNRfT21GXXdY8B5/Fmar5MQtbCqIkCFeG8?=
 =?us-ascii?Q?PTSw/FnieBSmC3/iXTCSGmSVHJYeqppKg70uy15J2ucWNh2TB+tKghjkHmUm?=
 =?us-ascii?Q?GBujuh1AOys0Vto+ICFsLlpHjncQ9HurcIRTGJcV3dmbUom/Y5XEHPRvEmgg?=
 =?us-ascii?Q?LsK5Fg49pPbpQGLWKtzJnjB0qQz5xUIi4+rWl+0bWt1wCwM1aHtl4Fi+cN0N?=
 =?us-ascii?Q?D8JcPyzHB4HoOcpqWX2/QBg+VkF29kMABCCbWUa63Q3o/5MDtxC1P3wxeQmK?=
 =?us-ascii?Q?WHFLjO69STpxvinLe2VRZhu5klHmOnRO?=
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:SJ0PR11MB6744.namprd11.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(1800799024)(366016)(376014)(38070700018); DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?uR2mMLWXQ5GPhHd3wmZRyM2Np1mud5TpIAodthtzEIl2l48ily3R2puldDzb?=
 =?us-ascii?Q?BFB6H3WltclPXCH92BvoiJK28mBhivKFhkbRgiMVhD81bYBS9o33/4fNZ6hh?=
 =?us-ascii?Q?9dsjH4pTo5am6v9UPb+beW8afStoUudndUBgqk8cSswZmTznBzuePW1hul7f?=
 =?us-ascii?Q?wIXrRFAtzeqOtXV+eYhAFu0MVLmZkLnI7jnidIOQIb8x2jPbuy+hAg8EqjPD?=
 =?us-ascii?Q?yOFfTgVANrhsDS2MENdIAlrCDwa+uXSBhVWn5HgBYwf1cwIwsjdctSlfgGue?=
 =?us-ascii?Q?hZnaGom0XuPg/KnVrp7tMDqTXuc7Z/8sbrfjdNW2UbBiReV0DVsmM59EbUwC?=
 =?us-ascii?Q?wggCJCWl6xhqMGjWw0I4Hc9cpKdL8wSeUOqDdefHejY0Vm3l6ILW1QssO+wB?=
 =?us-ascii?Q?Ya3lFr3P+3bh+KfOfeA42I1Gjun0HfP5seUVHnxg4o0AfZZyGXHWc1Q0lHwd?=
 =?us-ascii?Q?2Q1aHfJItaaaI4KmmqmuHsLqRNkNstf5aKpfXusiAmbJcnyVDHqeLdAqDHDs?=
 =?us-ascii?Q?bjMr1807UsPoNiNUDSBBwWmPzFtz6dvkb6wSYm0IlKMqsaHSNDoucjnW9qh7?=
 =?us-ascii?Q?0RnwIql8TS86DilmSokivDrxO4SLGxWGxBCSdxrmBfkgoqVIgS9/9zXQeJ3D?=
 =?us-ascii?Q?dTYLjzo+9yg80MSY1Bj6p1k2GrZ3wEpL6BH/MKV8krlrkrxGU+3C9Jl5RIa8?=
 =?us-ascii?Q?50XFriQLGCH/FgSCfQHTID51hkXyrN7tDLkhHhv4ydMGH4M4CxX1Rf3tYxex?=
 =?us-ascii?Q?Ze7dLNgin87tfchX28j30h0wJmAYzI6mdNycp/bixRcKg0XSwXGUbna1ZyIT?=
 =?us-ascii?Q?RHQNbafIYq+itBl1e1JeQfe9P1iIowlJrz1fKDzS9XjDF+viCYVdwUoPA4Ls?=
 =?us-ascii?Q?Zqv67lhpLSFsyC6BQAZa2JutkiZzMNHyaE1NGks/ofBI83CkLHfTpZSt0ID3?=
 =?us-ascii?Q?Ptd1jBQDEki6CXaelUawoZbs/JcD/BzTyfJqxfe9rfgBfDvHJyq0KS/5NbI/?=
 =?us-ascii?Q?E+ax7FO/uKBBA2KsvXspsUoSNwojdYR9UUacHwlXjMgxY+xh8OsfusH2fV6r?=
 =?us-ascii?Q?N6493bbp6QO7chvSjOYIVnK5O0WBwxc4pP8b7fLbsd9o5gYtlKEJWK+yVeQ2?=
 =?us-ascii?Q?DreqAQ1BtEDnV3DdMVu3Pa0mOMWah+jFexqDZtfeItNsbij7rnk5a67RJfus?=
 =?us-ascii?Q?GQ+wcYgFu1/U3RZwREEF3YEEesG7SFD0Ty0st6PrqyYWxrVF42Wx+8SAR3uY?=
 =?us-ascii?Q?VztBmxJyf08k+PJmHhmE2Y4Y5Q/K1RifgiBV+S+c8neLvIO6dDy3IaTcDULn?=
 =?us-ascii?Q?uuSyAJSgX//v1eOX78csOns3KTYSwI949XFrUAliEuZjcZkRfTfJZpkDUIPY?=
 =?us-ascii?Q?S4SJNUJK2z5EekeUDr5QYvdpUN64LY0Vo8x/r/sBcDgrC+wkpxbTZa8OxcKG?=
 =?us-ascii?Q?bO8cFFFLH+D02SLpr4C5+zL2Q/+k5dZJlNKorMRNPFUNsjbq/yPwJY9TskZL?=
 =?us-ascii?Q?8rus+wKawPQViAJGaPIebu8pPU+kJySNADTYcAJeykxfwECRYLQs7jMka1oM?=
 =?us-ascii?Q?1h8tPXSkptsYwvy3FAJMn5na0CHOrOzr+iNcXIw+?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: SJ0PR11MB6744.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 4c2b6d52-130d-4692-3449-08dd51666e69
X-MS-Exchange-CrossTenant-originalarrivaltime: 20 Feb 2025 04:24:13.6923 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: n/CA4Mgdv2fDcDz4ov1SXS/C7yVbqSNQ5qdvlc2gSBiGaYXIeunCX1p8+ys09wZgzh4Ltnla7BiN9I0aUo2j+anRPVE7WbN8O2Hi7rX9PZk=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH7PR11MB7122
X-OriginatorOrg: intel.com
Received-SPF: pass client-ip=198.175.65.10;
 envelope-from=zhenzhong.duan@intel.com; helo=mgamail.intel.com
X-Spam_score_int: -45
X-Spam_score: -4.6
X-Spam_bar: ----
X-Spam_report: (-4.6 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.191,
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



>-----Original Message-----
>From: Alex Williamson <alex.williamson@redhat.com>
>Subject: Re: [RFC 0/2] hw/vfio/pci: Prevent BARs from being dma mapped in
>d3hot state
>
>On Wed, 19 Feb 2025 18:58:58 +0100
>Eric Auger <eric.auger@redhat.com> wrote:
>
>> Since kernel commit:
>> 2b2c651baf1c ("vfio/pci: Invalidate mmaps and block the access
>> in D3hot power state")
>> any attempt to do an mmap access to a BAR when the device is in d3hot
>> state will generate a fault.
>>
>> On system_powerdown, if the VFIO device is translated by an IOMMU,
>> the device is moved to D3hot state and then the vIOMMU gets disabled
>> by the guest. As a result of this later operation, the address space is
>> swapped from translated to untranslated. When re-enabling the aliased
>> regions, the RAM regions are dma-mapped again and this causes DMA_MAP
>> faults when attempting the operation on BARs.
>>
>> To avoid doing the remap on those BARs, we compute whether the
>> device is in D3hot state and if so, skip the DMA MAP.
>
>Thinking on this some more, QEMU PCI code already manages the device
>BARs appearing in the address space based on the memory enable bit in
>the command register.  Should we do the same for PM state?
>
>IOW, the device going into low power state should remove the BARs from
>the AddressSpace and waking the device should re-add them.  The BAR DMA
>mapping should then always be consistent, whereas here nothing would
>remap the BARs when the device is woken.

If BARs should be disabled before D3hot transition, isn't it guest's respon=
sibility to do that itself?
Just like what have been done for FLR which calls pci_dev_save_and_disable(=
).

Thanks
Zhenzhong

>
>I imagine we'd need an interface to register the PM capability with the
>core QEMU PCI code, where address space updates are performed relative
>to both memory enable and power status.  There might be a way to
>implement this just for vfio-pci devices by toggling the enable state
>of the BAR mmaps relative to PM state, but doing it at the PCI core
>level seems like it'd provide behavior more true to physical hardware.
>Thanks,
>
>Alex


