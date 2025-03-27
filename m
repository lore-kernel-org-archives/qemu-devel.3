Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5A4FAC3600B
	for <qemu-devel@archiver.kernel.org>; Thu, 27 Mar 2025 08:46:23 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1txis9-0003DA-QY; Thu, 27 Mar 2025 04:45:57 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <zhenzhong.duan@intel.com>)
 id 1txis0-0003CF-8T
 for qemu-devel@nongnu.org; Thu, 27 Mar 2025 04:45:56 -0400
Received: from mgamail.intel.com ([198.175.65.21])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <zhenzhong.duan@intel.com>)
 id 1txiry-00033M-Ay
 for qemu-devel@nongnu.org; Thu, 27 Mar 2025 04:45:47 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1743065146; x=1774601146;
 h=from:to:cc:subject:date:message-id:references:
 in-reply-to:content-transfer-encoding:mime-version;
 bh=alkxYadaK8FaV/U+mmxmZP7Smk4y27EleZ2KsAJqp5U=;
 b=SBJB7Jr/xHjqpN6m7BWB7dYPzIABfuAq+NdDH4y5BcS6uYZmbl71JoMG
 TBpCcqnmCG4fx2nHvi7k5dMZdJi9QtH83jHIf3N6cQ4tWzh/IRrTzX7/Z
 cUZj86GKA5EgLIPyJeUZk0R/KU7JvWT2eSdJ6FPrRzuE9vhVcJ887iu80
 xMELukFncfPzOHf2u1qEUEjnbbYmEUOjws//Rotx5LMuz3oD692gmJIOG
 e6lG0E+/HILHGkVoyhDEJzSRfxWAoOm9oL3/vXzXJy9SqE6l4wxO9I0qZ
 yOAgZrcno0O1KJqbedhuTd79oOkQHNcs7Djngq/MIbjpe+VWorAAgngDw A==;
X-CSE-ConnectionGUID: 2pYniWfwTAaqOMSLOcJgnw==
X-CSE-MsgGUID: zRinP0czTDOFFnYvM4kqrg==
X-IronPort-AV: E=McAfee;i="6700,10204,11385"; a="44303454"
X-IronPort-AV: E=Sophos;i="6.14,280,1736841600"; d="scan'208";a="44303454"
Received: from orviesa007.jf.intel.com ([10.64.159.147])
 by orvoesa113.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 27 Mar 2025 01:45:43 -0700
X-CSE-ConnectionGUID: rKKD/xoSSDOLJHN8U6bAeg==
X-CSE-MsgGUID: vFBeCMMeRvm5jC/q8AWg3w==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.14,280,1736841600"; d="scan'208";a="125586774"
Received: from orsmsx903.amr.corp.intel.com ([10.22.229.25])
 by orviesa007.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 27 Mar 2025 01:45:44 -0700
Received: from ORSMSX903.amr.corp.intel.com (10.22.229.25) by
 ORSMSX903.amr.corp.intel.com (10.22.229.25) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.14; Thu, 27 Mar 2025 01:45:43 -0700
Received: from orsedg603.ED.cps.intel.com (10.7.248.4) by
 ORSMSX903.amr.corp.intel.com (10.22.229.25) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.14 via Frontend Transport; Thu, 27 Mar 2025 01:45:43 -0700
Received: from NAM11-BN8-obe.outbound.protection.outlook.com (104.47.58.172)
 by edgegateway.intel.com (134.134.137.100) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.44; Thu, 27 Mar 2025 01:45:40 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=EiBsv2PSiciRYZH5Wefrrf7xPFHUFENThX1Wjq0DHtiJ81N+fHRxEDKdRLw0bxCm87uQcnlpBa9Zfk2jS522+x+R4UXLwkQYwsNMiw3pdRzXLeyDFTYJSKK8fyrhlS9xTvqP2UyuJXR7n7Qjc5LKSuMKIpfDNypMs3+lGdJqd/zTEx3jxcVTmnPb+Z0ZI4+UjzyNQuezE2/Kc5lYawZMdgH5i4JSiQqu3sBRQnUWbZSNNnSTnf/Z25Fwqdp+zrQdVP+lJ9HWXkF6t08xVX+te3NlW9FmBdf5GtAxJZ0YTgsm1d9FZMBFTqx2Pn+8yLS7F5dj6OUiD6mVTEpwt3bggg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=alkxYadaK8FaV/U+mmxmZP7Smk4y27EleZ2KsAJqp5U=;
 b=BtB+OloqH7uZORaycaYhdV3vBXBZYj951KIKgmAqwQv1kwyYghWJK+y4RkFUXaGcM6dNXBdoFCAib0tZoDIBAw35uAkCFHcaqnRbKk9LBEaFIpif3ujkX4Bl+yXcnL/p4NKlxp7YkeTN3TwSmXTXxGVazFabZPT4d+XSTB+y7B4x88/JjFyHz6U8EDY9YkJu/RO+l03eP7mNGCV3e/eLcg5l/xmtphNWxfwkPr24PTazaco94ex+zOREpBHpwesy1Iyw1Sn6vRiGjEEf2q1E7oETXQWIbaFUQyXesdS5vvGFUKbepBn62eA9vIXWe/iywacLsC67SlkB8rTEXc/GgQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Received: from SJ0PR11MB6744.namprd11.prod.outlook.com (2603:10b6:a03:47d::10)
 by CY8PR11MB7729.namprd11.prod.outlook.com (2603:10b6:930:70::12)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8534.44; Thu, 27 Mar
 2025 08:45:38 +0000
Received: from SJ0PR11MB6744.namprd11.prod.outlook.com
 ([fe80::fe49:d628:48b1:6091]) by SJ0PR11MB6744.namprd11.prod.outlook.com
 ([fe80::fe49:d628:48b1:6091%6]) with mapi id 15.20.8534.043; Thu, 27 Mar 2025
 08:45:38 +0000
From: "Duan, Zhenzhong" <zhenzhong.duan@intel.com>
To: =?iso-8859-1?Q?C=E9dric_Le_Goater?= <clg@redhat.com>,
 "qemu-devel@nongnu.org" <qemu-devel@nongnu.org>, Alex Williamson
 <alex.williamson@redhat.com>
CC: Avihai Horon <avihaih@nvidia.com>, Eric Auger <eric.auger@redhat.com>,
 John Levon <john.levon@nutanix.com>, Joao Martins
 <joao.m.martins@oracle.com>, "Liu, Yi L" <yi.l.liu@intel.com>
Subject: RE: [PATCH for-10.1 v2 10/37] vfio: Introduce a new header file for
 VFIOIOMMUFD declarations
Thread-Topic: [PATCH for-10.1 v2 10/37] vfio: Introduce a new header file for
 VFIOIOMMUFD declarations
Thread-Index: AQHbniQK0tPZr9x+jECmDrPNS2LEI7OGqT4w
Date: Thu, 27 Mar 2025 08:45:38 +0000
Message-ID: <SJ0PR11MB67448CFEBBE06357F88B467E92A12@SJ0PR11MB6744.namprd11.prod.outlook.com>
References: <20250326075122.1299361-1-clg@redhat.com>
 <20250326075122.1299361-11-clg@redhat.com>
In-Reply-To: <20250326075122.1299361-11-clg@redhat.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: SJ0PR11MB6744:EE_|CY8PR11MB7729:EE_
x-ms-office365-filtering-correlation-id: 31659ce7-b1cc-4ea1-31db-08dd6d0bbfe9
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
 ARA:13230040|366016|1800799024|376014|38070700018|7053199007; 
x-microsoft-antispam-message-info: =?iso-8859-1?Q?Ko6CdQMR1EUkWpdKKLmEWlXuNfpn4mDC2Ev63YN7utiN2DFwVyQgTLMH5D?=
 =?iso-8859-1?Q?0SVr0HtPw8ue7rxwDuDWAD0dQ5QK3Zzq8BDzU2j2rTrt2a0VS4cgKJxK6z?=
 =?iso-8859-1?Q?qLJoObI/scgIQitIsEraEb2RXx7m/yKVQ0iwS14yJJTuAYr5z/NUCw+mZH?=
 =?iso-8859-1?Q?Hed9Fi43jO8Z1U0OEWP9xsEDOwM8YThU89SSOiwFq/XdpLMCsUVDshAd1k?=
 =?iso-8859-1?Q?3Tqib0/MKEBkNjc2sTX/YUPu9W3CONJMPITYVdpg66hmCApBTvUIuJCiuf?=
 =?iso-8859-1?Q?BtNPxg4p7wX6UBDnPFEIix1wvJG9eH4JvRybJ33D7etwzc0Pk2VRrFxUeF?=
 =?iso-8859-1?Q?cbBtWHfvThJd0fkmfL0GN24K9Ey5jG9UWG7DG8mc1iWSQCyYrijClKhZY+?=
 =?iso-8859-1?Q?A2wNXJi0SyAKBi+aeCvx7HYLitEL5ETPNHW971kP6AdJIU+x0gt2wPH25Y?=
 =?iso-8859-1?Q?9Kkx1LJwI8wT75rwwkJdGgLKEOSCb3LgkqzXJKHefw3kornqTsPG08L0mh?=
 =?iso-8859-1?Q?o9nybZoEnaMWWx6tV/3Vto8jou4MECA7dInLoklfoqf2svJVOMaAX5XW+C?=
 =?iso-8859-1?Q?edHi3sMW1A9NYDki2FZCQsC7wCruaJgFKL1IhnWnsfZXNdmESS9oPN1w5z?=
 =?iso-8859-1?Q?w79yxKF7AZswZEIT5/wxuepatUn115fDAwXItna3kFa2mBDkD/6TtB1ivP?=
 =?iso-8859-1?Q?rX1IDjGOeFoBQTqXgqOM06n5FEQphN9S/f//QZfOfPXkjVX89vK595wjYB?=
 =?iso-8859-1?Q?esjzD+zjvIj/kGFvx0nT3Ks548qe1V3L0J0GIdxiWGaQFbq6PmmKnXYxCm?=
 =?iso-8859-1?Q?AZH1rCNxrANuCfr7H9pkj975k/GnH1VJQP6j78oFq6HYmMWf9hvpZ3cme/?=
 =?iso-8859-1?Q?3QF4/m42jVn+gwPsaoEuXcBTvEVmRyteebjvtwtIzk79Zw9Kn3wAemEuQh?=
 =?iso-8859-1?Q?FgK1o918SDKJvs4LB656mRqOh0OGwrDujfcqAqPkUKE9lA0G3Zc+2NuZh/?=
 =?iso-8859-1?Q?PNACn5SYpBYxwFk0nWD5/O/J5MMhMQpBsIp4+OwKyWoBKstSwDgOTN4+nS?=
 =?iso-8859-1?Q?ct3LxAqS3c05HpQAiNAuU8G1Jd0+exL+CUHMV3OR5o9b79KyMUVHfJ3iRy?=
 =?iso-8859-1?Q?khWOFJDaytKD4QKgnIi+vLkejZnFswmdqu6EmsxyVRK8IyUSB1/U09MbMd?=
 =?iso-8859-1?Q?vhxKYzfK+iwg7sPtRDH4gAiaTOzphFaXcpTvJkeQMRUwQ6+//jNCXpwPPA?=
 =?iso-8859-1?Q?r5Pay9iL+lo9KUQqJ6+7KQZE2iIQn33jN5+X2T9Shg7Jp/sZ8ioJr8XIFh?=
 =?iso-8859-1?Q?ZSHL7HGQHa/K0qi8UYiflZBFQnMq9Hivp2skvO6Cj0hgf9+Fyr6J45etaN?=
 =?iso-8859-1?Q?Lc7Ng11uE3046zC/KyC64WyISCXMEfa7Ripn0JJ/bNrdosHihcNtkibST4?=
 =?iso-8859-1?Q?6swlxUTLpsazBd8PYO3vUxIJm86+T+xzDrwCfpv0uQu5zA8Vk6+Y7lctQI?=
 =?iso-8859-1?Q?IWTCBOMfWOwetEXZIfFS+3?=
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:SJ0PR11MB6744.namprd11.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(366016)(1800799024)(376014)(38070700018)(7053199007); DIR:OUT;
 SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?iso-8859-1?Q?EOY/dZwYgXOzFP1/UaTFljGB8OLt5IzAmXMsAcdlWiOSX2QbQ2aTYfdtjk?=
 =?iso-8859-1?Q?xB525ZJU0laVZlMm33tLla84p7qcX5DmCJT72ibCnRBLl4lto7b0f8pvrU?=
 =?iso-8859-1?Q?6WpzEhCXIKfMKP91vTQJWX3mAReqLxlPXAlP1oORcy/lgthtY3ie20ZlB7?=
 =?iso-8859-1?Q?v1y9FwInLni8A4UrGnv+eZINp4RrKLieHBWBStAa7uESmcFd/UnKT6QLTb?=
 =?iso-8859-1?Q?EBWRcDehfV7ekL1y0PzDYLZL26wfy2a4uFmVMaV9u2HZzNDH+drMFZXp9N?=
 =?iso-8859-1?Q?CXYEMkmzvmPwkEwYYKbXjxrpxNEb6rw3q4UBU8YbeBYDSdM5w5lml12h0q?=
 =?iso-8859-1?Q?lHUpWgGhpMnGZIS/MpwGfvGfQn6fi6dZeQWe8k4YGirGu12BmlLzkTgn2X?=
 =?iso-8859-1?Q?JfOOOtWPXk03xzIXU82ClK17jAoWONJAW7YvSQ6NKOg4TWhfxvQOXcMQzY?=
 =?iso-8859-1?Q?3jEn8/rmf8wPXR7BtVl9YIfR1NZe1ZtZL2qf5B16pkpCzR4MxiMb4ReUab?=
 =?iso-8859-1?Q?XDaqbI0/DDl4sQecUFks1Nk/vLRh68Sov3w0ylYeU4EQE6Q6PsGJW840+p?=
 =?iso-8859-1?Q?jAYoT8vYZtHBwnB1EJ1tblhFwNYNSdBMKG4lovC9R35Y56T64ukWm/zvvO?=
 =?iso-8859-1?Q?Bw4Npvvi8JGu7aGFApDDgRZWqcJ2WSKBEguEv2G67dzl3pSgwuL/l472tP?=
 =?iso-8859-1?Q?dwUXPY+GWTEfl3pRq0Wwn5JG5odWtCNPp5UWRxW8Pva0ZwKTW2lEQGlUM9?=
 =?iso-8859-1?Q?eWF8xhmS+Zk3n1zf8eMMX2LTn+3e0nYWlErIlLNyP3H/5o4cT2aGq7TwZg?=
 =?iso-8859-1?Q?ldnx6JOyWMNIU4l9YMnkC0LCj2sPN483gs9VDSDBQdXroOJESx7lc9inxg?=
 =?iso-8859-1?Q?BIJumIyUbVuXqe9ELQvrm7HoNhTRN7/91OWwcWNS4QnjQKD1hmo1djL2nR?=
 =?iso-8859-1?Q?gip732hjTQpUybhxlpg6aGqycvmU1OCKB+U5fGyp+zV8BMjIlIb5AfrWKw?=
 =?iso-8859-1?Q?1RWoxhKVJXw3A6ltjf8AJf8ZDDhU2guJy2N5cOeA7YYOq7QJ37QOUy+KQA?=
 =?iso-8859-1?Q?nYsXavDNlU310H5fEw8PIgkiJLXG+/xpPreZf+LFs8ctU6VdEqOYqVEhz1?=
 =?iso-8859-1?Q?aaW/AUmRGBVqrzYoX5fGQewAZFWDGBkCWUmwIBeYJvady09S7f6iCHYZlE?=
 =?iso-8859-1?Q?iUnuZ3JmPobCFUQJDzwuBwU+NyE/MySazhsKYaCDrn3H/pFCx6SQ26EHwI?=
 =?iso-8859-1?Q?pNec794An2tzKC7mmeJnRTMUghye2Kll/aHCWePS7+2TfyaoUiEELpEwO5?=
 =?iso-8859-1?Q?L7L9JtvToeJxDe8JRnLNtdTXQweDw8QvAmRzuBHIjFghLpvqmkFwoRMH3v?=
 =?iso-8859-1?Q?BcD9xaP7sIVfYo5VxxLLD94dhnnteiHaKzDbziA2JHiz6qGDO68S0qcUXX?=
 =?iso-8859-1?Q?2q6FzuLxjBGwVEc6E2XBEmpxW4vA7aTIm4A+bflDmEZ32Hu0bMEa8UY7n8?=
 =?iso-8859-1?Q?4PuzqzK06DWr1PqpZcwA63UPHAFPRQ3jdGel4AIZoGFNzIgMhmW84tepuI?=
 =?iso-8859-1?Q?z/vgZIVYA0w5EhgIawLhqD1sirpBWDlX+7WRc+oicVgdNfoV85z/GuGKoP?=
 =?iso-8859-1?Q?aAcqHAuhl31ovDfqgHR6csczachNj+4um9?=
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: SJ0PR11MB6744.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 31659ce7-b1cc-4ea1-31db-08dd6d0bbfe9
X-MS-Exchange-CrossTenant-originalarrivaltime: 27 Mar 2025 08:45:38.7766 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 7jA6TEpCJTYMVs8DI4uGzRcfW27lxmrerHNQxZtO3AKAPcs1woMaJP5GWhQZShZO6BFKQHlzUnLqp08NdCZL++aTFOf2x6/d47YxNwo8DvA=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY8PR11MB7729
X-OriginatorOrg: intel.com
Received-SPF: pass client-ip=198.175.65.21;
 envelope-from=zhenzhong.duan@intel.com; helo=mgamail.intel.com
X-Spam_score_int: -43
X-Spam_score: -4.4
X-Spam_bar: ----
X-Spam_report: (-4.4 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_MED=-2.3, RCVD_IN_VALIDITY_CERTIFIED_BLOCKED=0.001,
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
>From: C=E9dric Le Goater <clg@redhat.com>
>Subject: [PATCH for-10.1 v2 10/37] vfio: Introduce a new header file for
>VFIOIOMMUFD declarations
>
>Gather all VFIOIOMMUFD related declarations introduced by commits
>5ee3dc7af785 ("vfio/iommufd: Implement the iommufd backend") and
>5b1e96e65403 ("vfio/iommufd: Introduce auto domain creation") into
>"vfio-iommufd.h". This to reduce exposure of VFIO internals in
>"hw/vfio/vfio-common.h".
>
>Cc: Joao Martins <joao.m.martins@oracle.com>
>Cc: Yi Liu <yi.l.liu@intel.com>
>Reviewed-by: John Levon <john.levon@nutanix.com>
>Link: https://lore.kernel.org/qemu-devel/20250318095415.670319-10-
>clg@redhat.com
>Signed-off-by: C=E9dric Le Goater <clg@redhat.com>

Reviewed-by: Zhenzhong Duan <zhenzhong.duan@intel.com>

Thanks
Zhenzhong


