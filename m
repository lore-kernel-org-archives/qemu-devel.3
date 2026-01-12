Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 199D6D2502E
	for <qemu-devel@archiver.kernel.org>; Mon, 12 Jan 2026 02:39:35 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vf7pP-0001Em-I7; Sun, 11 Jan 2026 21:38:47 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <zhenzhong.duan@intel.com>)
 id 1vf7pN-0001EY-Ds; Sun, 11 Jan 2026 21:38:45 -0500
Received: from mgamail.intel.com ([192.198.163.16])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <zhenzhong.duan@intel.com>)
 id 1vf7pJ-0002hX-Bq; Sun, 11 Jan 2026 21:38:43 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1768185521; x=1799721521;
 h=from:to:cc:subject:date:message-id:references:
 in-reply-to:content-transfer-encoding:mime-version;
 bh=O0xgvauTGSyC5Qb/FmXYdeGwn3omkrMA1OUlsRhH5/0=;
 b=fHRvYyty/x/h+UCCluJ+/FCqBOM0SAZiwZgqARgYglMN/ySDaaAetV8r
 sj24ZFkEUT/4qW3OvDFfRcO+cdkvfXcXAXGDM7w0C5qBETll6ym+g6OWm
 VEousiJ8umG+rcqIfWzmDyJm4k30JgVLW6fowJEzzuSammExPaZnPljqA
 /k7krwKJT49v/NSWKoiwjCSpmfl0tu1rg0dxbyBZuJPh+SFpJ0IKJ15Ej
 4woyVrNXh7TV71SBdYpn92cideQjsC4pFZK5cm1+IOb/PZldII7YAumn4
 G4IHtZ7tqyLL9NxpV+KZUj3y490RJsSb1k1cZdpYYH9n8q+FeLcGtc+jp Q==;
X-CSE-ConnectionGUID: Hcp/w3rqRwi9J7wi+eqNjQ==
X-CSE-MsgGUID: vE8mkQKUT3CdGtK1sePTqQ==
X-IronPort-AV: E=McAfee;i="6800,10657,11668"; a="57010151"
X-IronPort-AV: E=Sophos;i="6.21,219,1763452800"; d="scan'208";a="57010151"
Received: from fmviesa004.fm.intel.com ([10.60.135.144])
 by fmvoesa110.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 11 Jan 2026 18:38:37 -0800
X-CSE-ConnectionGUID: NCNzVQfoRqq3rHvbZY4KTg==
X-CSE-MsgGUID: 5On4JmwURZCTI/t2W+CI+w==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.21,219,1763452800"; d="scan'208";a="208812769"
Received: from orsmsx902.amr.corp.intel.com ([10.22.229.24])
 by fmviesa004.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 11 Jan 2026 18:38:22 -0800
Received: from ORSMSX902.amr.corp.intel.com (10.22.229.24) by
 ORSMSX902.amr.corp.intel.com (10.22.229.24) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.29; Sun, 11 Jan 2026 18:38:22 -0800
Received: from ORSEDG901.ED.cps.intel.com (10.7.248.11) by
 ORSMSX902.amr.corp.intel.com (10.22.229.24) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.29 via Frontend Transport; Sun, 11 Jan 2026 18:38:22 -0800
Received: from CO1PR03CU002.outbound.protection.outlook.com (52.101.46.59) by
 edgegateway.intel.com (134.134.137.111) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.29; Sun, 11 Jan 2026 18:38:21 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=EqfUF8iJnkRPOve30mJO1P6II9ZZlK/KMgfvw1Q36Gr4eJ1r3YhCZpRZOeFkame2snedObSU/Pu6RuPb6SM4Ss70X20OdYADjPg0/ZuZGdmSKhKpDMelMbOeG7tAykLXVTFUXk3RvVJ0BWTxRnWL9MZC5Rtuim1dJo+qFVn/ooR+1QtVsEpp2dx3Ubc76f34frr1sxeU1uo+2asjHr5WnDMGFYunCll6sO299fjU442lSSAVC2ZvYi3Utk1qADJTcHJIroLKjsTOkFNt2kped6VdsuFrBDVuhEnNhlQwWAEx7DN3vJyFupPK6Zwqg0LcoS0sV1nRtO9SufSYmO8e1A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=QEK7FoaF7lBWudM/991GcuF8TalRnH804m5Q2/pbgg0=;
 b=fz0rylp5OWjeJmbyMKlZCd8mf1y+Dg5BdNyEkqPLI0drxsgxPM4gFD+lz2mkAk+QwE3HbuxQ2X+FFWVP2ShY9wniSMMNMsdmG6vxh9b0cefjGY8XluOYpVvAbWTcumdIy6iYqGtobZl4F6hBR2dt7pNSwEY+ldH67SgmmuJCY6Zn5kLWrJn9Bh0fEq6RBMLNr32gl2SRievHrVjlbCd+4cgvPaZvo59QRFy1nneDdpyqWsXl0oCDMqK/3h5k90PMfxQN5q6kwt4pCzjTyDIGgXdyJs+ILPA2IG7a9Ed4Uq8FYyeOgJ7c/D6PJewr61Gfs6xvr+JSgoosyl6G03/8Zg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Received: from IA3PR11MB9136.namprd11.prod.outlook.com (2603:10b6:208:574::12)
 by SN7PR11MB6897.namprd11.prod.outlook.com (2603:10b6:806:2a5::11)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9499.7; Mon, 12 Jan
 2026 02:38:19 +0000
Received: from IA3PR11MB9136.namprd11.prod.outlook.com
 ([fe80::604b:77a4:b1be:3f13]) by IA3PR11MB9136.namprd11.prod.outlook.com
 ([fe80::604b:77a4:b1be:3f13%7]) with mapi id 15.20.9499.005; Mon, 12 Jan 2026
 02:38:19 +0000
From: "Duan, Zhenzhong" <zhenzhong.duan@intel.com>
To: Shameer Kolothum <skolothumtho@nvidia.com>, "qemu-arm@nongnu.org"
 <qemu-arm@nongnu.org>, "qemu-devel@nongnu.org" <qemu-devel@nongnu.org>
CC: "eric.auger@redhat.com" <eric.auger@redhat.com>,
 "peter.maydell@linaro.org" <peter.maydell@linaro.org>, "jgg@nvidia.com"
 <jgg@nvidia.com>, "nicolinc@nvidia.com" <nicolinc@nvidia.com>,
 "ddutile@redhat.com" <ddutile@redhat.com>, "berrange@redhat.com"
 <berrange@redhat.com>, "clg@redhat.com" <clg@redhat.com>, "alex@shazbot.org"
 <alex@shazbot.org>, "nathanc@nvidia.com" <nathanc@nvidia.com>,
 "mochs@nvidia.com" <mochs@nvidia.com>, "smostafa@google.com"
 <smostafa@google.com>, "wangzhou1@hisilicon.com" <wangzhou1@hisilicon.com>,
 "jiangkunkun@huawei.com" <jiangkunkun@huawei.com>,
 "jonathan.cameron@huawei.com" <jonathan.cameron@huawei.com>,
 "zhangfei.gao@linaro.org" <zhangfei.gao@linaro.org>, "Liu, Yi L"
 <yi.l.liu@intel.com>, "kjaju@nvidia.com" <kjaju@nvidia.com>
Subject: RE: [PATCH v7 35/36] hw/vfio/pci: Synthesize PASID capability for
 vfio-pci devices
Thread-Topic: [PATCH v7 35/36] hw/vfio/pci: Synthesize PASID capability for
 vfio-pci devices
Thread-Index: AQHcgzTG3jo8a+wKEUiJWDVa5+dzprVN0g8Q
Date: Mon, 12 Jan 2026 02:38:19 +0000
Message-ID: <IA3PR11MB9136783F330F8F38E9EB986F9281A@IA3PR11MB9136.namprd11.prod.outlook.com>
References: <20260111195508.106943-1-skolothumtho@nvidia.com>
 <20260111195508.106943-36-skolothumtho@nvidia.com>
In-Reply-To: <20260111195508.106943-36-skolothumtho@nvidia.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: IA3PR11MB9136:EE_|SN7PR11MB6897:EE_
x-ms-office365-filtering-correlation-id: dd29d312-7d9d-40a0-d6f3-08de5183a587
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
 ARA:13230040|366016|376014|7416014|1800799024|38070700021; 
x-microsoft-antispam-message-info: =?us-ascii?Q?gktVAer1gJ1Aiqq39cn9w9VRLTmbqT9J9i9Apzjqj4n4O+mVIIqEQnVj2Fav?=
 =?us-ascii?Q?YKdEwjo3ZD0rk5ZqOE9UMUUC8lpCBMkXnrEk3FRjSRdNbtlsbRJ9Q0Mc5sru?=
 =?us-ascii?Q?ZuaV2zA6rESougZHnK0lnIUeC7hXhkca6hbKyH923D+hwAKHr8pyP0CxdIyg?=
 =?us-ascii?Q?b/G8HRedVJehHYsuFsdleFx95Na1xUO8JBTwCz9lN0qO9ZjPiX50/8kVBvK6?=
 =?us-ascii?Q?tx89VCwnYshVI1I/+5H3+Qe6VPmdnN9G/+bseD6SwAdRoyfJDP9sBqeTz4jN?=
 =?us-ascii?Q?OMVzpgyy3TrtSLV5IgJMEaMBuTlZjeFMQJmMkKoQPESs0oEEHnaEdBm89iEp?=
 =?us-ascii?Q?o6/diOv9LNGcXTguXkwLc/N9rRW//QKsAbSAHh9huEf+he5nTNTVZRJ7es+L?=
 =?us-ascii?Q?w5nt//WEd5B8AIyHC6xhwlMTOezdllefYYcSliMh2FwTjcqGDQLDnEmtvcyL?=
 =?us-ascii?Q?M4k5Jt1ONy+fNh5EFqwzfENhTmiQ4z6cFTT+TWguxCUAEkB6nyJ3yEIPXzBo?=
 =?us-ascii?Q?AomehFBUGeu6w8JbntjUmTziRf6U+qv6JjFTy3xRrFHxKEzBV9c69EdpQBmt?=
 =?us-ascii?Q?EeLxd2aRVNx8LlrVrjExTAvcBTfOSST47tnitc8peF7NTXsXpewK9DSDEhj2?=
 =?us-ascii?Q?aDohqQLlcFj6tQwjJ7pV/GXtdX/8Gn5yXh7WPG21+sRAlVYT8nW12T3IP1Ht?=
 =?us-ascii?Q?sBh8bxCxqj9bJZKmq1NiquPVeqh/sR4SjnvD1hVoE+KSHrxMrnjjYTsWuaRV?=
 =?us-ascii?Q?thbZK2Vp+OhHtBBXXndYRVeBcWhgrIMMcnDbtqs0QL4H2zkLd0J1yY4vDD/5?=
 =?us-ascii?Q?46NeaT0JKpjB6eC3Q8D4vwlvhhs8Udl0bV7Cp30jvZg94fjhgF3UQUXURprL?=
 =?us-ascii?Q?VPAAUc9VjT8934Jt8RgJYLOXlUhW4Zx0cNhCmrhC7lDnJjTw34nhlpdyN8em?=
 =?us-ascii?Q?+kIWTZi0dtTwTz+34BILDhtKFULgNBOrTX190WUoTwV1c4zpBfYaWq8yNhWi?=
 =?us-ascii?Q?YOHJI4nVB71K2R9zyuQEZcLiPWh/ay19TielYN8PkjxXCdVs7z2oxZeR28v9?=
 =?us-ascii?Q?fF6ipM3gek+GUiekwfnX+qzqIw4zhzXZAHCdp03BtI99WmDYx/30NPZzs6G8?=
 =?us-ascii?Q?26d9jbkCdKCzWzOWZz3sBRb5QOXurWsy5zEagDrJ3rPt9fDJQm5+755ds/JT?=
 =?us-ascii?Q?o57FGsn9zM5QdndXB7df4YFO8gVCzNKNPN/iNwqWxVs3+ecQHFhO0rPg2MRK?=
 =?us-ascii?Q?7udTlGSGeuSpVVNJqQ27ITYzYXBqPJELDUYIE8IZAYq0wruSoFGRnIMMKZn8?=
 =?us-ascii?Q?rbR1NSNdx4hnB3+TycxA9Q75s0XiEmNWp52+vixwHcw/NC7pSbq4cbmGODua?=
 =?us-ascii?Q?Od70jJOq/p55shJjOH2NdKDydfDDTS6j6Uu93axtCXU4m6hCpcaF3kBs+kZw?=
 =?us-ascii?Q?MlsdQBmfbA5zBneG1FeG90z4lRK/OZSOMIff5kEP6NJzN/pqAo0nJiDXK7oH?=
 =?us-ascii?Q?2Ognk+KjqusaO+rEe7xcVlMMW5QnQIMMY94U?=
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:IA3PR11MB9136.namprd11.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(366016)(376014)(7416014)(1800799024)(38070700021); DIR:OUT;
 SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?EvFF6WmZZSUSdaichMWBfZgcKBXEXGUbxAyhU3hxpRhMfmIiGhzN9Eb5lf2s?=
 =?us-ascii?Q?gzb2jCu6LryT/TSxTdKk/gCvmg1cRsy8ckERNiG7ft5nMgEXzx+Yegq3eUD0?=
 =?us-ascii?Q?NNa811+jejSKtiro5weGToi2RTRxcge2PrMlCRDwWHy/9dMq+O7DhS55CvTa?=
 =?us-ascii?Q?r2tsXvJ4AnulaZk7bftPlE9vUVPxrusAPquMAchLkbwstQ4ovNHF4LwqIPpz?=
 =?us-ascii?Q?FC31g92F104e7JWRXUwxZGuhMMMD+Mk3ZbFXW214r5fD9WY13R5cKzucS4he?=
 =?us-ascii?Q?Hl8NOQs7UE4FHyRqjc+bDY4TKjtvt8/JIhTlWJofB5JUEfnzL6lYmE705kr2?=
 =?us-ascii?Q?waRbL4JVVBSZhiwjIuBx7bBO2CHUByySJjzEdsOCxv2FLRwFEtCpFLH3ZNrc?=
 =?us-ascii?Q?SGkatm/tvFACgmL7ZBvT4a/i57vaVqNJsuO7Ll3gmHsQQyIsL5iMmC1N21j9?=
 =?us-ascii?Q?yc1Qb3UZwGHZVhJ/3VXviyEYshHmyKL8nS7O7fdqJeDswnVdlykzf/rZjqIV?=
 =?us-ascii?Q?Ctr4GbiUUx7HRmFIfaH4c4u3KKOY/WVEv3G/Z3UZpNx8pL7SnaHPBJW9snBl?=
 =?us-ascii?Q?TbZ1a1hlDixLbI/abMxS6WGTDUtDHpO3WJWgdhQHv0VMxiuOi98fq/5cYcPz?=
 =?us-ascii?Q?38GXk2QHXExN9RYirfiLKQ/WHGrt5VVFWxjdt6MM2vo0n5ffEi1AUOVkzDgE?=
 =?us-ascii?Q?7LrGnCDRtHuDpqlXLRQz6s9rZbahzGFXNmu5FZmdtUK7AwAlNaq4FMFWxnqJ?=
 =?us-ascii?Q?JgBAxIhrUXPvunuLFCIRGC7wbIskpuoar7FrQ/9Tszv7GsVwrXcDjjOeHzys?=
 =?us-ascii?Q?lS74+o5hgCqPYcqMEGj47kd3fA4iyWtMZgnhtP+ake469RL/3Pgvp2XYSRbj?=
 =?us-ascii?Q?dArIscuJZamPubcQSGkUL2+V7tPnSJwIAQkwigWK6IBfV9GeZjcfXnntH5Sk?=
 =?us-ascii?Q?pkfHG4qW/1uKMRF5Q9UqGoeQ2ldupUcv03tNomHA/sVn4Qkc2X0VU7T4W6zt?=
 =?us-ascii?Q?Kjmv8unww9VYXL+01SpBsSC/EDcl3vJpChvObWDKGScDMRweKqD5Y6Cqfe1b?=
 =?us-ascii?Q?F1n79SLoVq74yWxzWgOOgF/yzFwAQXQlEgK+6y3Fv57v2+fdpYPagGrFg25T?=
 =?us-ascii?Q?BmIzZvVUrE4KDZtG0DVvYFT3dmFqJiUyRF+ydqn8WhIA5iIEPWnRppsk2OsV?=
 =?us-ascii?Q?hlidBd1/p5C4HbrIJ9swtWEZVCW2D+hVsYJ7rCHl9QqSLHdwEAG7cY96FHJP?=
 =?us-ascii?Q?P0s77EPQE3TklsmNhIsLAMJH0JMu31URF7QhZKsSV2fdAm/S4m68qzOBdVnr?=
 =?us-ascii?Q?Eh51j/BUNOGRhKgf7XMHAFvlXkFD9Re8pjKNDn+wnfN2RIJAUKFUefwaQ+EO?=
 =?us-ascii?Q?nUTURvLIdnSLwkZ0tebHoC1ls/inxZJEHxAhmt91IDM9AYXxqZSP6zHiG0ag?=
 =?us-ascii?Q?mbNWxb9O65S5nPoNby56Ry0nEbzmfJpvhUhQxAqRbe310jOV+GibwuJXZUC2?=
 =?us-ascii?Q?67DtoJMrSaGaBGyst895bnRPQspKwZbYfjeyc5lrOTuJ9sSd7R/P1NaH64dS?=
 =?us-ascii?Q?thho3yv4rYfobLIMguiwetp/SmibpXtd4HCcZUmPr1NF9piA2l3+XAE0pF1a?=
 =?us-ascii?Q?phF3R/OFTbfNF89rvUgFAvQaiBq+IST9a+ZTJCdGn68p9YmMnqfr0/G0A7Rt?=
 =?us-ascii?Q?JoPx7eTllbcdJE+KUOOXFVWCuAvAMw4+P4vQvurJQSQrQN6hotYtHpN43BCy?=
 =?us-ascii?Q?3anKiMMJ8Q=3D=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: IA3PR11MB9136.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: dd29d312-7d9d-40a0-d6f3-08de5183a587
X-MS-Exchange-CrossTenant-originalarrivaltime: 12 Jan 2026 02:38:19.2362 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: M0DL44K70rlX5pWM8tXpiUzVUVBQ+RrZou2U/xxfwwnavskU6XArCTF5t+1quWLri+b9kdMOpWyuKu6WxHekm3RphQOFkLMMDECaq+IHD4g=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SN7PR11MB6897
X-OriginatorOrg: intel.com
Received-SPF: pass client-ip=192.198.163.16;
 envelope-from=zhenzhong.duan@intel.com; helo=mgamail.intel.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001, RCVD_IN_VALIDITY_SAFE_BLOCKED=0.001,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001 autolearn=ham autolearn_force=no
X-Spam_action: no action
X-BeenThere: qemu-devel@nongnu.org
X-Mailman-Version: 2.1.29
Precedence: list
List-Id: qemu development <qemu-devel.nongnu.org>
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
>From: Shameer Kolothum <skolothumtho@nvidia.com>
>Subject: [PATCH v7 35/36] hw/vfio/pci: Synthesize PASID capability for
>vfio-pci devices
>
>Add support for synthesizing a PCIe PASID extended capability for
>vfio-pci devices when PASID is enabled via a vIOMMU and supported by
>the host IOMMU backend.
>
>PASID capability parameters are retrieved via IOMMUFD APIs and the
>capability is inserted into the PCIe extended capability list using
>the insertion helper. A new x-vpasid-cap-offset property allows
>explicit control over the placement; by default the capability is
>placed at the end of the PCIe extended configuration space.
>
>If the kernel does not expose PASID information or insertion fails,
>the device continues without PASID support.
>
>Signed-off-by: Shameer Kolothum <skolothumtho@nvidia.com>
>---
> hw/vfio/pci.c           | 84
>+++++++++++++++++++++++++++++++++++++++++
> hw/vfio/pci.h           |  1 +
> include/hw/core/iommu.h |  1 +
> 3 files changed, 86 insertions(+)
>
>diff --git a/hw/vfio/pci.c b/hw/vfio/pci.c
>index c734472721..96990576ac 100644
>--- a/hw/vfio/pci.c
>+++ b/hw/vfio/pci.c
>@@ -24,6 +24,7 @@
> #include <sys/ioctl.h>
>
> #include "hw/core/hw-error.h"
>+#include "hw/core/iommu.h"
> #include "hw/pci/msi.h"
> #include "hw/pci/msix.h"
> #include "hw/pci/pci_bridge.h"
>@@ -2498,9 +2499,71 @@ static int vfio_setup_rebar_ecap(VFIOPCIDevice
>*vdev, uint16_t pos)
>     return 0;
> }
>
>+/*
>+ * Try to retrieve PASID capability information via IOMMUFD APIs and,
>+ * if supported, synthesize a PASID PCIe extended capability for the
>+ * VFIO device.
>+ *
>+ * Use user-specified PASID capability offset if provided, otherwise
>+ * place it at the end of the PCIe extended configuration space.
>+ */
>+static void vfio_pci_synthesize_pasid_cap(VFIOPCIDevice *vdev)
>+{
>+    HostIOMMUDevice *hiod =3D vdev->vbasedev.hiod;
>+    HostIOMMUDeviceClass *hiodc;
>+    PasidInfo pasid_info;
>+    PCIDevice *pdev =3D PCI_DEVICE(vdev);
>+    uint16_t pasid_offset;
>+
>+    if (vdev->vbasedev.mdev) {
>+        return;
>+    }

I'm not sure if checking hiod directly is more accurate, vdev->vbasedev.mde=
v can be false
for mdev device if fd passing is used.

Thanks
Zhenzhong

>+
>+    hiodc =3D HOST_IOMMU_DEVICE_GET_CLASS(hiod);
>+    if (!hiodc || !hiodc->get_pasid_info ||
>+        !hiodc->get_pasid_info(hiod, &pasid_info) ||
>+        !(pci_device_get_viommu_flags(pdev) &
>VIOMMU_FLAG_PASID_SUPPORTED)) {
>+        return;
>+    }
>+
>+    /*
>+     * Check if user has specified an offset to place PASID CAP,
>+     * else select the last offset as default
>+     */
>+    if (vdev->vpasid_cap_offset) {
>+        if (!QEMU_IS_ALIGNED(vdev->vpasid_cap_offset,
>PCI_EXT_CAP_ALIGN) ||
>+            vdev->vpasid_cap_offset < PCI_CONFIG_SPACE_SIZE ||
>+            vdev->vpasid_cap_offset + PCI_EXT_CAP_PASID_SIZEOF >
>+                PCIE_CONFIG_SPACE_SIZE) {
>+            error_report("vfio: invalid x-vpasid-cap-offset 0x%x, skippin=
g
>PASID",
>+                        vdev->vpasid_cap_offset);
>+            return;
>+        }
>+        pasid_offset =3D vdev->vpasid_cap_offset;
>+    } else {
>+        pasid_offset =3D PCIE_CONFIG_SPACE_SIZE -
>PCI_EXT_CAP_PASID_SIZEOF;
>+        warn_report("vfio: PASID capability offset(x-vpasid-cap-offset) n=
ot
>specified, "
>+                    "placing at the default offset 0x%x",
>+                    pasid_offset);
>+    }
>+
>+    if (!pcie_insert_capability(pdev, PCI_EXT_CAP_ID_PASID,
>PCI_PASID_VER,
>+                                pasid_offset,
>PCI_EXT_CAP_PASID_SIZEOF)) {
>+        error_report("vfio: Placing PASID capability at offset 0x%x faile=
d",
>+                     pasid_offset);
>+    }
>+    pcie_pasid_common_init(pdev, pasid_offset,
>pasid_info.max_pasid_log2,
>+                           pasid_info.exec_perm,
>pasid_info.priv_mod);
>+
>+    /* PASID capability is fully emulated by QEMU */
>+    memset(vdev->emulated_config_bits + pdev->exp.pasid_cap, 0xff,
>+           PCI_EXT_CAP_PASID_SIZEOF);
>+}
>+
> static void vfio_add_ext_cap(VFIOPCIDevice *vdev)
> {
>     PCIDevice *pdev =3D PCI_DEVICE(vdev);
>+    bool pasid_cap_added =3D false;
>     uint32_t header;
>     uint16_t cap_id, next, size;
>     uint8_t cap_ver;
>@@ -2578,12 +2641,24 @@ static void vfio_add_ext_cap(VFIOPCIDevice
>*vdev)
>                 pcie_add_capability(pdev, cap_id, cap_ver, next, size);
>             }
>             break;
>+        /*
>+         * VFIO kernel does not expose the PASID CAP today. We may
>synthesize
>+         * one later through IOMMUFD APIs. If VFIO ever starts exposing
>it,
>+         * record its presence here so we do not create a duplicate CAP.
>+         */
>+        case PCI_EXT_CAP_ID_PASID:
>+            pasid_cap_added =3D true;
>+            /* fallthrough */
>         default:
>             pcie_add_capability(pdev, cap_id, cap_ver, next, size);
>         }
>
>     }
>
>+    if (!pasid_cap_added) {
>+        vfio_pci_synthesize_pasid_cap(vdev);
>+    }
>+
>     /* Cleanup chain head ID if necessary */
>     if (pci_get_word(pdev->config + PCI_CONFIG_SPACE_SIZE) =3D=3D 0xFFFF)=
 {
>         pci_set_word(pdev->config + PCI_CONFIG_SPACE_SIZE, 0);
>@@ -3756,6 +3831,8 @@ static const Property vfio_pci_properties[] =3D {
>                      TYPE_IOMMUFD_BACKEND, IOMMUFDBackend
>*),
> #endif
>     DEFINE_PROP_BOOL("skip-vsc-check", VFIOPCIDevice, skip_vsc_check,
>true),
>+    DEFINE_PROP_UINT16("x-vpasid-cap-offset", VFIOPCIDevice,
>+                       vpasid_cap_offset, 0),
> };
>
> #ifdef CONFIG_IOMMUFD
>@@ -3913,6 +3990,13 @@ static void vfio_pci_class_init(ObjectClass *klass,
>const void *data)
>                                           "destination when doing
>live "
>                                           "migration of device
>state via "
>                                           "multifd channels");
>+   object_class_property_set_description(klass, /* 11.0 */
>+                                          "x-vpasid-cap-offset",
>+                                          "PCIe extended
>configuration space offset at which to place a "
>+                                          "synthetic PASID
>extended capability when PASID is enabled via "
>+                                          "a vIOMMU. A value of 0
>(default) places the capability at the "
>+                                          "end of the extended
>configuration space. The offset must be "
>+                                          "4-byte aligned and
>within the PCIe extended configuration space");
> }
>
> static const TypeInfo vfio_pci_info =3D {
>diff --git a/hw/vfio/pci.h b/hw/vfio/pci.h
>index 0f78cf9cdb..d6495d7f29 100644
>--- a/hw/vfio/pci.h
>+++ b/hw/vfio/pci.h
>@@ -187,6 +187,7 @@ struct VFIOPCIDevice {
>     bool defer_kvm_irq_routing;
>     bool clear_parent_atomics_on_exit;
>     bool skip_vsc_check;
>+    uint16_t vpasid_cap_offset;
>     VFIODisplay *dpy;
>     Notifier irqchip_change_notifier;
>     VFIOPCICPR cpr;
>diff --git a/include/hw/core/iommu.h b/include/hw/core/iommu.h
>index 9b8bb94fc2..9635770bee 100644
>--- a/include/hw/core/iommu.h
>+++ b/include/hw/core/iommu.h
>@@ -20,6 +20,7 @@
> enum viommu_flags {
>     /* vIOMMU needs nesting parent HWPT to create nested HWPT */
>     VIOMMU_FLAG_WANT_NESTING_PARENT =3D BIT_ULL(0),
>+    VIOMMU_FLAG_PASID_SUPPORTED =3D BIT_ULL(1),
> };
>
> #endif /* HW_IOMMU_H */
>--
>2.43.0


