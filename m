Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0818CC83F04
	for <qemu-devel@archiver.kernel.org>; Wed,  2 Jul 2025 14:18:48 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uWyHu-0005P4-0G; Wed, 02 Jul 2025 10:18:15 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <zhenzhong.duan@intel.com>)
 id 1uWyHk-0005JD-EM
 for qemu-devel@nongnu.org; Wed, 02 Jul 2025 10:18:04 -0400
Received: from mgamail.intel.com ([198.175.65.16])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <zhenzhong.duan@intel.com>)
 id 1uWyHg-0001At-Fj
 for qemu-devel@nongnu.org; Wed, 02 Jul 2025 10:18:03 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1751465881; x=1783001881;
 h=from:to:cc:subject:date:message-id:references:
 in-reply-to:content-transfer-encoding:mime-version;
 bh=HR7t9f8KsCyZYwl/KwOUjPZdf732ZgirvfqpnBWUGRQ=;
 b=iYuTuez0QhttDRDqrUs+seR92tuYdUBN1ds2CwuQ+7qP/dNCd+8peDa8
 UF1XO5HLwUjtD3lIY8MX6tnRQdGG/G9fMfsjh8tTo1TiR3gpCJIWcIs3K
 EnYfR+Yt6VZYNZ/1SmWU+Msf3QPYipVfVMVSEzb/NU+o5vpDAdccfu2sj
 dRqbW0PQw7SDkt9bg5B3JTGok826PLssu97AqPoM2Md+ggCRS9AMAdJrg
 7V/zTbkUaTjMPKpHONenQx/FLve06oiZ5JtErZ+QCyCCn0I/FbTo4z1RE
 KdR06LnVikXuNghhGpcULXykguewLE9x+ViiKMkhzkxgSiYINEmFmxMjY g==;
X-CSE-ConnectionGUID: rTlCvho+QV2XbWIcpmtmSA==
X-CSE-MsgGUID: 2sn1cI0ERO+4Pta/vI9HQQ==
X-IronPort-AV: E=McAfee;i="6800,10657,11482"; a="53873521"
X-IronPort-AV: E=Sophos;i="6.16,281,1744095600"; d="scan'208";a="53873521"
Received: from orviesa002.jf.intel.com ([10.64.159.142])
 by orvoesa108.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 02 Jul 2025 07:17:50 -0700
X-CSE-ConnectionGUID: Ys3S+eX3QQ+v6gKVuHbbhg==
X-CSE-MsgGUID: 8e7FVMXCT4ONMFFShoblyA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.16,281,1744095600"; d="scan'208";a="185120160"
Received: from orsmsx901.amr.corp.intel.com ([10.22.229.23])
 by orviesa002.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 02 Jul 2025 07:17:50 -0700
Received: from ORSMSX902.amr.corp.intel.com (10.22.229.24) by
 ORSMSX901.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.25; Wed, 2 Jul 2025 07:17:49 -0700
Received: from ORSEDG902.ED.cps.intel.com (10.7.248.12) by
 ORSMSX902.amr.corp.intel.com (10.22.229.24) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.25 via Frontend Transport; Wed, 2 Jul 2025 07:17:49 -0700
Received: from NAM11-DM6-obe.outbound.protection.outlook.com (40.107.223.62)
 by edgegateway.intel.com (134.134.137.112) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.25; Wed, 2 Jul 2025 07:17:48 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=vbrQ9kwHrQFomD5H0mMqYhrS7+f8BRBRmpf/hNJHz1UvEZjvwPErSSFFb+0uvvzWPpHA1VI49SVE/fg9x3sCw/GMwAdAu4OTmSf6xXukfRjkYfUgsuzb9bOOwWUGbC1mkKGHtyXouXHLdqIbc0gRgkpP7LMTravKAjR3EAez9zGGTnoNTbYKS9I0bkt2tl+bH3bFo3GBYKMUpjIqn8ejzEO0C/7o4bGuAKNS012A32Lf0Xd4V6cM/WyFLmi62REpq6SSRCacWbigzyVjgZZlqcuIeq7Y5gRrxCx1kqsbGPmyOmttnv7CIjocxT6APks99Gx5ZExKYQyRdbnfLyCR7A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=P8RaALNrtAlX4/R0y8UgnRn1BroG4fVJax6ZCfNJ6XY=;
 b=HTbcBWK91yO80sIbT8eLZ2px5rTtxQ1L7Ic/MbfhsffqcuDHSRau0MEtvARinTBMfO+9vXlyb73hAPaSR6EWvPgw3YQDCl5nf42v6380cKaM8DjMivFMvq1YIfCcTlwenswQon8H/LV8kqGfcelild9tJh3RqO+aofciRhz2KgXPdx6x72zUfGp45q7i2LbqO1Q5Fif+gVmQGUm+vY1vyVE18n/yUKimFcDFYoxrxi0jNoG/a3UH7WyoXdcSrOFzQmegk3ed0fo7S6OC4d9NHqFBQSk0pfrQAfexJHYAKV45TPNAI1LULvN4hqtE02P70J/fzFN0Z/N7B/xiY3i6XA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Received: from IA3PR11MB9136.namprd11.prod.outlook.com (2603:10b6:208:574::12)
 by CH3PR11MB8341.namprd11.prod.outlook.com (2603:10b6:610:178::12)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8901.21; Wed, 2 Jul
 2025 14:17:46 +0000
Received: from IA3PR11MB9136.namprd11.prod.outlook.com
 ([fe80::604b:77a4:b1be:3f13]) by IA3PR11MB9136.namprd11.prod.outlook.com
 ([fe80::604b:77a4:b1be:3f13%4]) with mapi id 15.20.8835.023; Wed, 2 Jul 2025
 14:17:46 +0000
From: "Duan, Zhenzhong" <zhenzhong.duan@intel.com>
To: Steve Sistare <steven.sistare@oracle.com>, "qemu-devel@nongnu.org"
 <qemu-devel@nongnu.org>
CC: Alex Williamson <alex.williamson@redhat.com>, Cedric Le Goater
 <clg@redhat.com>, "Liu, Yi L" <yi.l.liu@intel.com>, Eric Auger
 <eric.auger@redhat.com>, "Michael S. Tsirkin" <mst@redhat.com>, "Marcel
 Apfelbaum" <marcel.apfelbaum@gmail.com>, Peter Xu <peterx@redhat.com>,
 Fabiano Rosas <farosas@suse.de>
Subject: RE: [PATCH V5 29/38] vfio/iommufd: register container for cpr
Thread-Topic: [PATCH V5 29/38] vfio/iommufd: register container for cpr
Thread-Index: AQHb2h4NUig8bHIwRkiWAfGbZCzL5bQfA0uw
Date: Wed, 2 Jul 2025 14:17:46 +0000
Message-ID: <IA3PR11MB9136CF09743001AFC31A93529240A@IA3PR11MB9136.namprd11.prod.outlook.com>
References: <1749569991-25171-1-git-send-email-steven.sistare@oracle.com>
 <1749569991-25171-30-git-send-email-steven.sistare@oracle.com>
In-Reply-To: <1749569991-25171-30-git-send-email-steven.sistare@oracle.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: IA3PR11MB9136:EE_|CH3PR11MB8341:EE_
x-ms-office365-filtering-correlation-id: 49659dcb-e472-4c18-dcdf-08ddb97337e6
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0; ARA:13230040|376014|366016|1800799024|38070700018;
x-microsoft-antispam-message-info: =?us-ascii?Q?uBOq5RO3quuWuGBC/M23ixnnhczHb68sik0If4WuXrPa41ncp1aiZFpKgQbB?=
 =?us-ascii?Q?xWtfO8nSpmg1JBb7rVDbcOXtAsig3/ek48u9AZIMcrxEcpAfAt2NNHXdrTqM?=
 =?us-ascii?Q?WTtwRnonP4pgwycEIxMZlP6oOdQckAwqp8CiDh4+4jvHsNXQtZd2M8iw0jcK?=
 =?us-ascii?Q?9cyJNu1MrWU14hS+KMpoPWFdC5LRsuZ93MI01idby0h1rGLaISxXJiNxFczN?=
 =?us-ascii?Q?elJP9yfYQDplrMzGObwv+cbU3X4neicDzir4ds/RDAorXQyspHR3046C8Axa?=
 =?us-ascii?Q?nrS8GmntHFuu0+7BCFnFsQrKVw4p0UVpTNHLG+MkGOOFgvAum7LJpVmTAsgh?=
 =?us-ascii?Q?N46oToNuLtQhrk37OkXaQM/HL0i5h1sARU81ZcTWAOMoXOGPgpk46Sua8t+z?=
 =?us-ascii?Q?Us72kpRuvWQtBW3WDKHPaAnYuYVh9B98oSHDZx+xamzRy0+MAbwjLsj7JtN4?=
 =?us-ascii?Q?LipHAiZfiM33aum+0i2FKTW8FE4+yqn05OV1GXTB4+yGbN+bIIabCWssfmso?=
 =?us-ascii?Q?6oZ/i77GEo5o++xXqvlz+XFfgdNL0abaf3Bv2Gn6t+dpvo3/lhVOHGFHoW5X?=
 =?us-ascii?Q?FryCWf8NYPF7ZOqZqQravoPEfhfBQtKzzjde2+9qYM1nvSDCUhpreyvd2sIt?=
 =?us-ascii?Q?aqiAUVNk+iu2EWyBOW2Gli4GxzBDgmhL4SfFa2x7G2tCgBvRnZ0aCRgfsI/w?=
 =?us-ascii?Q?4tyZTPUv2IVcIqfcfSlD8pA5TCzjQ1D3xIstv3OPEtaLuANOj/ekTnRjuFuo?=
 =?us-ascii?Q?ljxCNNGVFl6XSHnbn3rpsuaWv5wgTJHLldmZPLd5EH0XnzrJNcbMWMJ/hPwP?=
 =?us-ascii?Q?dy4qKwGIwOk/yd49rW/hVwZql3i7rveKmnX2ZB6FS3vV0BOSHxWOBStPW4kC?=
 =?us-ascii?Q?37+za4PmNeSsx6YcJibuKpBs4RVZxuzqI52nOR5820625FUqCYeK0lZbJ8bG?=
 =?us-ascii?Q?LgX+2c5W1Ulj7y/H2Zl9hDmIg5sd/W7TEm5taBrI7FeVXPfsgcZJMYqiCt4K?=
 =?us-ascii?Q?/RT5May4Zs+dbPoTJkTBzOnDFln3h7j0J0QekvQee13Sd9ANz1O4+pydj76f?=
 =?us-ascii?Q?QbUqaUbTaYrmZ8fi6Cu75hDBMFvibKNdFDwSomsSe4JvL1XM1ZKZaOS9nHsl?=
 =?us-ascii?Q?ba1twrYKCvRyv9+GEdwfYU12liFLaRCgTR9J1uyL/xnI/mfdiMwwQ25XER6r?=
 =?us-ascii?Q?mdvxl/wM7mQFJ1eEwQNwVomXn+LQ9EiXkF5otOtsl7eMOS1w/rIAWYmy0xVM?=
 =?us-ascii?Q?io5UZMJ5dZ/+yw7lX20oKLJNYjKKd3X3eaFrj1XwtNPLrKRaW/rJVBeC/xUy?=
 =?us-ascii?Q?LBwqJRfhbmRd3Zb4xuye6b1ASBaK2PuGoAEYIIV2pwtyTj1Qy3gJW2/jBN3S?=
 =?us-ascii?Q?Ja3u55iwdLmlWnCKmB/VOaryBJ4lMDE5bSfgkBjk5oqqkOAF9Jk/eyFeZt8q?=
 =?us-ascii?Q?UawbXK2o5go/bBjLbY2yzHZ+QtfUHoMC8E0M8GdZV6tKIvr+R/aAY9resg7G?=
 =?us-ascii?Q?h5bCbmC6lWFfDj0=3D?=
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:IA3PR11MB9136.namprd11.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(376014)(366016)(1800799024)(38070700018); DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?BUfzlJT4V4XE3XsO1fRa5ttlltq9mOwSsWlfznS5BvCgTx1CFWj2wydupQea?=
 =?us-ascii?Q?6D81WEWxZJ5nwiTZ3/wPqpH+K9uo0rreDqFi+VJ+CNb8OuF3/1OZkxfJwhBM?=
 =?us-ascii?Q?7wSB9hTUwVMMjF42q8YP9PL+cjvSuI0tumxYl+Wv3A4k7oSEONkofwvZ/E4c?=
 =?us-ascii?Q?0ByIcCsPstYfhZxzj3ruKwogKIUGGQRg5uPaUKushu09g9SRK4H2vYX8xqZ8?=
 =?us-ascii?Q?wjbWa4Hr4nn0eO8j344XYiok0k4KHALOPR7lWXpuxSd2YXkXqsyawIgFYrLY?=
 =?us-ascii?Q?zpeFgNstvPXWSeVqWnZS2K6qWERd/Vtv/CZTbItvpGI8Ra61EeR+tda3JldA?=
 =?us-ascii?Q?x7vT1HnmLVovP9cFSH6DsghGtCnE0vC+Oxf3Q4NU6aFL1MXxNyHdFamz55E0?=
 =?us-ascii?Q?0CIO/eh6jxuFFTDdvQr4MD2KB2XfAXLmDpW9PqHFoRORMfYAAhuomz5zvAf8?=
 =?us-ascii?Q?fiJLxLiq260/TIwT3MuYP7uBlw4AHwFp9a2UWpWB5Sg+Qje7e58YRN+i140d?=
 =?us-ascii?Q?qp3j6hcRpuEY89vGaZQMtfEer97Q+PraS5ZofqYZr4C9pQvtOkU+/fi5x8yU?=
 =?us-ascii?Q?baQE8mdFXbgwjAn2zFB1YLmQ3HE/MOHmuXT7rFyvvkaskzsF2m383sKIoNsR?=
 =?us-ascii?Q?HtcPZuQK0iBILtWZ+nLmXMqQfTWDThZe/R2yDcNOaUYbAetA/eiUtgiz0cPf?=
 =?us-ascii?Q?K2MXfxHhnODRTNTs4KlEUpiuDmz1mN+sAhEGn8/if5Qc2JNToj95cXs8AF/v?=
 =?us-ascii?Q?WVUsi7NzT8L3LSAqu7Vkz2+Qnj3eqlOJtagsS1VelRnGhXBICYxnMWZQOWiV?=
 =?us-ascii?Q?Ct2j36cVUYMBknJesF+zaWaSZNj3Awja1sQefF6ww6G6JR2IFhyvHZ6+374f?=
 =?us-ascii?Q?er2qoj358klpsr/IWJb0uB38jMUilI/5PNjiK1VLpFfBL1cVgbU2aBO2ctCn?=
 =?us-ascii?Q?jp50b+jIQvSdm35s5L9CZLGPHvAAI3CvS3QN8M/oL6+s7FggwVh4q8nAasyj?=
 =?us-ascii?Q?AyVhkqfwO6OlJK20OMgE23Ei1rHGf6nR/eGsmAW9Hltlk/f0apEhCo17jm/S?=
 =?us-ascii?Q?B/j38rJIK7A6nsERzDrRdA+46RpG7l/XwX1sUMkip47LwkVP1NXrIIjd05wb?=
 =?us-ascii?Q?BMU4XfllUDYnL5p4D98quFC4rRHaWQtju8SkjLaRLUNyuneo90ryRcKRt0Lu?=
 =?us-ascii?Q?4tPlu3V3Vs7RQKMaFe6aNAe2z4xUFwU3eLL1DLaBy7cWeNXy0xVAQlPnMlJl?=
 =?us-ascii?Q?sUsfcbcjDvPlQCNSj+OZETBC9xsz78DyR2G9QZioAPzPzrEVy3AYex2QWXDK?=
 =?us-ascii?Q?gSBW2Wyw5dDsACQ0k5ryor/DH5n7aj27VAzbEe7da4Gf7Z5AQaLV8QGfgqPx?=
 =?us-ascii?Q?0r76mqz3JaHHixDr1eIz+/Jz4s8sp3Xnys3tbGHenuWc1rZOAyUu2XXc+dZx?=
 =?us-ascii?Q?ctZEDD3xpwGKpX1BBsMn7lbDDt6hQ2MP7hhlRcw1ndU4vFMquAVBonDBSTf9?=
 =?us-ascii?Q?tem6aZk4D7RpDbEK65sWjlt1MLB5+xNxe9uVRNQU0XrS+7AYTRzpPNZCVK3y?=
 =?us-ascii?Q?Q6b6UTZt+KeO7mYLwHstCW+1gkX6LTvOy8NqAYJ9?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: IA3PR11MB9136.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 49659dcb-e472-4c18-dcdf-08ddb97337e6
X-MS-Exchange-CrossTenant-originalarrivaltime: 02 Jul 2025 14:17:46.6261 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: C+HSZILlrErxdmUL/SuONCr7cj2pByn6X8qg2R2NsCoM2tGnx0/UNEaa3uCdwlPjJIk8RCPci+dhFcz+TlILOYpmcRo+OLJCF2n/ysBsOT0=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH3PR11MB8341
X-OriginatorOrg: intel.com
Received-SPF: pass client-ip=198.175.65.16;
 envelope-from=zhenzhong.duan@intel.com; helo=mgamail.intel.com
X-Spam_score_int: -41
X-Spam_score: -4.2
X-Spam_bar: ----
X-Spam_report: (-4.2 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_MED=-2.3, RCVD_IN_VALIDITY_CERTIFIED_BLOCKED=0.237,
 RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001, SPF_HELO_NONE=0.001,
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
>From: Steve Sistare <steven.sistare@oracle.com>
>Subject: [PATCH V5 29/38] vfio/iommufd: register container for cpr
>
>Register a vfio iommufd container and device for CPR, replacing the generi=
c
>CPR register call with a more specific iommufd register call.  Add a
>blocker if the kernel does not support IOMMU_IOAS_CHANGE_PROCESS.
>
>This is mostly boiler plate.  The fields to to saved and restored are adde=
d
>in subsequent patches.
>
>Signed-off-by: Steve Sistare <steven.sistare@oracle.com>
>---
> include/hw/vfio/vfio-cpr.h | 12 +++++++
> include/system/iommufd.h   |  1 +
> backends/iommufd.c         | 10 ++++++
> hw/vfio/cpr-iommufd.c      | 84
>++++++++++++++++++++++++++++++++++++++++++++++
> hw/vfio/iommufd.c          |  6 ++--
> hw/vfio/meson.build        |  1 +
> 6 files changed, 112 insertions(+), 2 deletions(-)
> create mode 100644 hw/vfio/cpr-iommufd.c
>
>diff --git a/include/hw/vfio/vfio-cpr.h b/include/hw/vfio/vfio-cpr.h
>index 170a116..b9b77ae 100644
>--- a/include/hw/vfio/vfio-cpr.h
>+++ b/include/hw/vfio/vfio-cpr.h
>@@ -15,7 +15,10 @@
> struct VFIOContainer;
> struct VFIOContainerBase;
> struct VFIOGroup;
>+struct VFIODevice;
> struct VFIOPCIDevice;
>+struct VFIOIOMMUFDContainer;
>+struct IOMMUFDBackend;
>
> typedef struct VFIOContainerCPR {
>     Error *blocker;
>@@ -43,6 +46,15 @@ bool vfio_cpr_register_container(struct
>VFIOContainerBase *bcontainer,
>                                  Error **errp);
> void vfio_cpr_unregister_container(struct VFIOContainerBase *bcontainer);
>
>+bool vfio_iommufd_cpr_register_container(struct VFIOIOMMUFDContainer
>*container,
>+                                         Error **errp);
>+void vfio_iommufd_cpr_unregister_container(
>+    struct VFIOIOMMUFDContainer *container);
>+bool vfio_iommufd_cpr_register_iommufd(struct IOMMUFDBackend *be,
>Error **errp);
>+void vfio_iommufd_cpr_unregister_iommufd(struct IOMMUFDBackend *be);
>+void vfio_iommufd_cpr_register_device(struct VFIODevice *vbasedev);
>+void vfio_iommufd_cpr_unregister_device(struct VFIODevice *vbasedev);
>+
> int vfio_cpr_group_get_device_fd(int d, const char *name);
>
> bool vfio_cpr_container_match(struct VFIOContainer *container,
>diff --git a/include/system/iommufd.h b/include/system/iommufd.h
>index db5f2c7..c9c72ff 100644
>--- a/include/system/iommufd.h
>+++ b/include/system/iommufd.h
>@@ -32,6 +32,7 @@ struct IOMMUFDBackend {
>     /*< protected >*/
>     int fd;            /* /dev/iommu file descriptor */
>     bool owned;        /* is the /dev/iommu opened internally */
>+    Error *cpr_blocker;/* set if be does not support CPR */
>     uint32_t users;
>
>     /*< public >*/
>diff --git a/backends/iommufd.c b/backends/iommufd.c
>index 87f81a0..c554ce5 100644
>--- a/backends/iommufd.c
>+++ b/backends/iommufd.c
>@@ -108,6 +108,13 @@ bool
>iommufd_backend_connect(IOMMUFDBackend *be, Error **errp)
>         }
>         be->fd =3D fd;
>     }
>+    if (!be->users && !vfio_iommufd_cpr_register_iommufd(be, errp)) {
>+        if (be->owned) {
>+            close(be->fd);
>+            be->fd =3D -1;
>+        }
>+        return false;
>+    }
>     be->users++;
>
>     trace_iommufd_backend_connect(be->fd, be->owned, be->users);
>@@ -125,6 +132,9 @@ void
>iommufd_backend_disconnect(IOMMUFDBackend *be)
>         be->fd =3D -1;
>     }
> out:
>+    if (!be->users) {
>+        vfio_iommufd_cpr_unregister_iommufd(be);
>+    }
>     trace_iommufd_backend_disconnect(be->fd, be->users);
> }
>
>diff --git a/hw/vfio/cpr-iommufd.c b/hw/vfio/cpr-iommufd.c
>new file mode 100644
>index 0000000..60bd7e8
>--- /dev/null
>+++ b/hw/vfio/cpr-iommufd.c
>@@ -0,0 +1,84 @@
>+/*
>+ * Copyright (c) 2024-2025 Oracle and/or its affiliates.
>+ *
>+ * SPDX-License-Identifier: GPL-2.0-or-later
>+ */
>+
>+#include "qemu/osdep.h"
>+#include "qapi/error.h"
>+#include "hw/vfio/vfio-cpr.h"
>+#include "migration/blocker.h"
>+#include "migration/cpr.h"
>+#include "migration/migration.h"
>+#include "migration/vmstate.h"
>+#include "system/iommufd.h"
>+#include "vfio-iommufd.h"
>+
>+static bool vfio_cpr_supported(IOMMUFDBackend *be, Error **errp)
>+{
>+    if (!iommufd_change_process_capable(be)) {
>+        if (errp) {
>+            error_setg(errp, "vfio iommufd backend does not support "
>+                       "IOMMU_IOAS_CHANGE_PROCESS");
>+        }
>+        return false;
>+    }
>+    return true;
>+}
>+
>+static const VMStateDescription iommufd_cpr_vmstate =3D {
>+    .name =3D "iommufd",
>+    .version_id =3D 0,
>+    .minimum_version_id =3D 0,
>+    .needed =3D cpr_incoming_needed,
>+    .fields =3D (VMStateField[]) {
>+        VMSTATE_END_OF_LIST()
>+    }
>+};
>+
>+bool vfio_iommufd_cpr_register_iommufd(IOMMUFDBackend *be, Error
>**errp)
>+{
>+    Error **cpr_blocker =3D &be->cpr_blocker;
>+
>+    if (!vfio_cpr_supported(be, cpr_blocker)) {
>+        return migrate_add_blocker_modes(cpr_blocker, errp,
>+
>MIG_MODE_CPR_TRANSFER, -1) =3D=3D 0;
>+    }

I suspect that blocker is never installed. Because vfio_iommufd_cpr_registe=
r_iommufd() is called for first VFIO device and before memory listener is i=
nstalled. iommufd_change_process_capable() will always return true.

Thanks
Zhenzhong

