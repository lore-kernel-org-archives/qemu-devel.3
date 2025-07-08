Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 56D6CC83F09
	for <qemu-devel@archiver.kernel.org>; Tue,  8 Jul 2025 20:52:52 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uZFDp-0004gc-Qp; Tue, 08 Jul 2025 16:47:25 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <zhenzhong.duan@intel.com>)
 id 1uZDtp-0002Hz-8q
 for qemu-devel@nongnu.org; Tue, 08 Jul 2025 15:22:43 -0400
Received: from mgamail.intel.com ([198.175.65.12])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <zhenzhong.duan@intel.com>)
 id 1uZDtk-00012P-Gy
 for qemu-devel@nongnu.org; Tue, 08 Jul 2025 15:22:39 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1752002556; x=1783538556;
 h=from:to:cc:subject:date:message-id:references:
 in-reply-to:content-transfer-encoding:mime-version;
 bh=a35imIVn5T5OTmFtP/Zq+PPPk/f6NOrPaD3/Cx66+rg=;
 b=jkf8bHcEZpfeXgS6gVQTbmdbYpmeunJv9XVo7iL0o4SGZLRq9y7a/BWb
 rWJ2SPw5LoFT9JB+LtQfNyi4OueXiIwSY9L8J7gj7SUAuO/82c3asQTbD
 yg/og5x9NIFInnxRWnLBO7cTETp8fqJGfxngEv6N/TxBGAQw+1Y2JCkB6
 lTD4/mWI1nOH5l54BdqAwRgDQ5x4h4gz84RtVKoFiW/LEqRf+i3WKDPWl
 y3GawGQrt31KyV3HmoqypbqY5RxbxMdD3UlNYVYjzAiceF+o5o7DY2nGV
 EYEtxapIJh/Rqia+lt3byCC26T1qPtVnxMxkjEBsPkA8DcB11BqxHlRq3 A==;
X-CSE-ConnectionGUID: 3RP0zz3bRVmO+jprgg9CPg==
X-CSE-MsgGUID: AleDMujLTwyjtI2AT7zXQA==
X-IronPort-AV: E=McAfee;i="6800,10657,11487"; a="65629846"
X-IronPort-AV: E=Sophos;i="6.16,296,1744095600"; d="scan'208";a="65629846"
Received: from fmviesa002.fm.intel.com ([10.60.135.142])
 by orvoesa104.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 07 Jul 2025 20:04:11 -0700
X-CSE-ConnectionGUID: yfusdistQqyNKYTDjWAHHA==
X-CSE-MsgGUID: UOHHtw3FQ/istkjqVpfxVQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.16,296,1744095600"; d="scan'208";a="179043694"
Received: from orsmsx903.amr.corp.intel.com ([10.22.229.25])
 by fmviesa002.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 07 Jul 2025 20:04:10 -0700
Received: from ORSMSX903.amr.corp.intel.com (10.22.229.25) by
 ORSMSX903.amr.corp.intel.com (10.22.229.25) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.25; Mon, 7 Jul 2025 20:04:09 -0700
Received: from ORSEDG902.ED.cps.intel.com (10.7.248.12) by
 ORSMSX903.amr.corp.intel.com (10.22.229.25) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.25 via Frontend Transport; Mon, 7 Jul 2025 20:04:09 -0700
Received: from NAM12-BN8-obe.outbound.protection.outlook.com (40.107.237.76)
 by edgegateway.intel.com (134.134.137.112) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.25; Mon, 7 Jul 2025 20:04:09 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=swrT0XSyz1uZIsqZuJ2NLzGT3QPA5zxJBQTaJ37oBbRqtD0JJMnmxb74CQPWGgeBvEQCTOfDcE+lgI9PEszsahH9Ul7UDy1gO0CYy6oIq3ixH2Uoj54TNs4Dtl/kDJ1mZn2EQ7ovsX7N/+BwHY1ylbWbsEILl54FJl7SlQSvvgtFjRV0T1xKRKnmAn9tVvjiKgYlABpUn6ro2rljQJi2SSr5+p1YE+lMMcZVH66yLFuRpL8n4VhvWtw+fGcKG5gP2RW0sHZt72gKrGNSD9wbWNNaFtefqfnksr+pfgAuJatKMKFbRq+DnW6b5IbzS/jaFeUkya4z8q6+uhPfzukVIg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=TMLhfh34aiuU/WxOOo5o5AJldTeIyt0187jxbOJwacY=;
 b=nHodSF9lOGVcQJpt8iYB5cGcVbsLhaC7U1pyp3IrQ8hOyE/MQpb0NcUBKT9kMva6qjtzIQ3TmjcwR5gRi2PcOTvAya8NxccIqvfhzWLbg0qhbmvY1O6EiljmDzooJ2xT0Davm8UJhbYus1cSJTElO/tEkKL9Jp6EbPEm2q/5zocaytWzsPKupKrFXbY7qwTYv1Uz+KCigCu3BT2MZyHoEdv356+oLTkXY87eIGfGH+LhThvEPlTjRifhP5PKJmpBgCv76mqDaIStNLhsuqdBMmLPpYCnIAbxJbwxo2le8ZxDbCMRn6lM1uWqz7gjg5fp2pHWRAcva2V2QD+hng2N2Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Received: from IA3PR11MB9136.namprd11.prod.outlook.com (2603:10b6:208:574::12)
 by PH0PR11MB7541.namprd11.prod.outlook.com (2603:10b6:510:26d::16)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8901.26; Tue, 8 Jul
 2025 03:04:05 +0000
Received: from IA3PR11MB9136.namprd11.prod.outlook.com
 ([fe80::604b:77a4:b1be:3f13]) by IA3PR11MB9136.namprd11.prod.outlook.com
 ([fe80::604b:77a4:b1be:3f13%4]) with mapi id 15.20.8835.023; Tue, 8 Jul 2025
 03:04:05 +0000
From: "Duan, Zhenzhong" <zhenzhong.duan@intel.com>
To: Steven Sistare <steven.sistare@oracle.com>
CC: Alex Williamson <alex.williamson@redhat.com>, Cedric Le Goater
 <clg@redhat.com>, "Liu, Yi L" <yi.l.liu@intel.com>, Eric Auger
 <eric.auger@redhat.com>, "Michael S. Tsirkin" <mst@redhat.com>, "Marcel
 Apfelbaum" <marcel.apfelbaum@gmail.com>, Peter Xu <peterx@redhat.com>,
 Fabiano Rosas <farosas@suse.de>, Paolo Bonzini <pbonzini@redhat.com>,
 "qemu-devel@nongnu.org" <qemu-devel@nongnu.org>
Subject: RE: [PATCH V6 03/21] migration: close kvm after cpr
Thread-Topic: [PATCH V6 03/21] migration: close kvm after cpr
Thread-Index: AQHb65yMsITnHNUgkkakwRoIjbSdCbQfY4wAgAJU1pCABPB3gIAAznAA
Date: Tue, 8 Jul 2025 03:04:05 +0000
Message-ID: <IA3PR11MB91367D05B1B990952F3EE7EA924EA@IA3PR11MB9136.namprd11.prod.outlook.com>
References: <1751493538-202042-1-git-send-email-steven.sistare@oracle.com>
 <1751493538-202042-4-git-send-email-steven.sistare@oracle.com>
 <e51734be-8949-4856-9107-16acdb6a80da@oracle.com>
 <IA3PR11MB9136B12D6587CB5C96D763A59242A@IA3PR11MB9136.namprd11.prod.outlook.com>
 <e59077f9-b39d-4eaa-8e16-9aeb37ec91ec@oracle.com>
In-Reply-To: <e59077f9-b39d-4eaa-8e16-9aeb37ec91ec@oracle.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: IA3PR11MB9136:EE_|PH0PR11MB7541:EE_
x-ms-office365-filtering-correlation-id: 5e796d13-9d88-4f9f-aa98-08ddbdcc19a3
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
 ARA:13230040|376014|7416014|366016|1800799024|38070700018; 
x-microsoft-antispam-message-info: =?us-ascii?Q?1hLvU7ijh7kan+S1UG3jD16LuBJ9mC3capoB3MqhC2BcqgxFD/BXrP2/Vnee?=
 =?us-ascii?Q?/mPZuzt+ushAn2r1NuoIxm64wpNSk2XszRHwTa5u9aUvVrFrhKA2BJJfCyhU?=
 =?us-ascii?Q?8yobo5AsA6W3AGPBKNo3pCn+aPxvg+qWLI/hMo8b4vhrMI5QIBqQYswYZgng?=
 =?us-ascii?Q?lyvlJwSEBs6GaAS4lFUy+dzLhqOFusw8O5u+gwIyDuVfBkgRlvWP7BWn9Nj2?=
 =?us-ascii?Q?x/P2nQqR08NGuRM0+j0sjF9cvi+v/Ebm1IWp3OgwGcNln7e0nExc82SKY9K6?=
 =?us-ascii?Q?eE22Qs/UoCgWiWCyJ8N4553/i6Zp5pnQtEVl4ed4WSXau088SUyivqtFHOIc?=
 =?us-ascii?Q?Fe6N5nleXMCbFSDPz5ooTx7wckEuKclrJrXoOrlgtFZBB7fYykiHIfXM2pTL?=
 =?us-ascii?Q?vHLOKVRMHM5ZE69BB9RuyuSIGMTvQD2K9inv4sa0Ye1/g9O/68LcVsoKU3WG?=
 =?us-ascii?Q?4B2b7E/SdrCi9tGWZu2DWK1ayJSazAhXZbhorpiKfB3izs7aAbmyPIQrCnxy?=
 =?us-ascii?Q?V3iIaZKSImsG6aRz0QdK9K+5N3IOD5sT6wx5ory3UPNnLCR9Cl6C43+JT4He?=
 =?us-ascii?Q?5qCWuEThqh3sVLSHALKYn8kWfbkfk8XQcQ6z+3ebHHXblK1TghzKZmWFBv1o?=
 =?us-ascii?Q?Zc8/a/KI6S1PQl5ZXzKb5qRqsJU8Hb72z1HZrnYTfR+PeTN+/HxPylFx+QIa?=
 =?us-ascii?Q?lVlHIoKEx6RqEgcpZrw+QuyCFX8o6EBLcK9KztqCn2XLoYhXylAbDQEqLge7?=
 =?us-ascii?Q?FqDKNjHIXOu+Z/TqeEbomEJq/JqwDS7xC7R7tHoxiVqk7ySZhhJqRfUy72w8?=
 =?us-ascii?Q?0WeQX4H1OdrxtnEatnojihUYco+Tfrtnc4kYXP7hhtnl8PVQAoOBva8gwElD?=
 =?us-ascii?Q?GVYwXUajtq3n6V47CiWr9HibHy1n5xfK/Xp2g1AGbuanLZBLAgird/rLZPbI?=
 =?us-ascii?Q?o2EJoUFIOLImlHsVTssZulY5PgukzGRG0FxTG8lAKAna6UnzJCraMn+ZzmzY?=
 =?us-ascii?Q?UGrTPvDaIye+JX4ee+V1iULefD6Ba5GjKQ0WuYbrEACX+mN9VrRPf5V0y1YV?=
 =?us-ascii?Q?qIGRqP2WcEnNgEJtVPguz5oFvaDvAh1NIFtEe4agK9kX6MWEOLRDekSvpLT+?=
 =?us-ascii?Q?UCIigX59XTtDxAD/rY0BQlZ/rkMuxC4gbYbgVcC35SQaPu3BvnVBhOpRGgC/?=
 =?us-ascii?Q?WhzVJcxKYwV/arBo8wh7xFyIoLtbNot+0I2RnHiMCMHOg8A60IZHuZH3kNns?=
 =?us-ascii?Q?8tHFj+d01tamOmJT7NOnbJXiAOKZQp0yHOO2ZxQN6TgEIOrAf2MmoMS0tyxl?=
 =?us-ascii?Q?D0g+K9O2dxaVoGM01ahMJhpWg/dYOvX4D/DDAANx/nfnXgPqDdGLc0tQDsMR?=
 =?us-ascii?Q?GEung8Q4FLVHsPeOOfJx1v0XWYqokXOoRF/iOn2u7nU323YfdOfRGlv/cWgI?=
 =?us-ascii?Q?b1oBq4Wg4IVH6+lPWIErRlD8bZ4B9of7rGyyGyduJQYxYn1voy6PRQ=3D=3D?=
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:IA3PR11MB9136.namprd11.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(376014)(7416014)(366016)(1800799024)(38070700018); DIR:OUT;
 SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?i/rziqs9HWvYabRQq+k7bteOuuuupAv0Dw1+KNh7+NzNqAQ9cBZzwzAJiAGB?=
 =?us-ascii?Q?dnV5pMqDKefo1GF+EJy/ZH+lQ6O0CNBkEtAWhQGCWH8e43GoirCXnF8+T5bt?=
 =?us-ascii?Q?5KKnFWEwnWvrbDXueWJ3Mqg6uvXe5+wWBPTulT1WBTA+2RYhEWxgpMNVXRwF?=
 =?us-ascii?Q?HwqaptK6HXJLpeuQKhAiVld8rgKbbSztZcAsMuHxoPEycD5B9ARtBv8k3PbR?=
 =?us-ascii?Q?x0jyePmgJXs3ApNeWShJvIhAP+dPq26pkA/HtGxvH8z51GqEv7Vi68DXj2qx?=
 =?us-ascii?Q?zQo+BUKB2plBmYXGeSqFUQSATcL7s5dOOeC7gL/WgY5ljUrc4yaMVv+9ZY+P?=
 =?us-ascii?Q?D8bGeQe5q8B9rx48S5FeUw0xrnLunrFiA1/xO80WFcZxeVIOz3NpEeyUrKfr?=
 =?us-ascii?Q?iQLWKzQCSs4L+J3kKCUUBQzqh4tRjVk4qXNIVzufbNPTG+m+W0Bg/Nibto9b?=
 =?us-ascii?Q?tTI/k9JOqzRBntS1LH7m2j6KZJLBEjJvPKatVlnKRTn8jugASYHGy3PqSws/?=
 =?us-ascii?Q?F8gYKbIB5RkqeJuh2XwZqJ5nbtYma0VCV3Uw+/L/FdFAuggTcJKt2kJ3vgl1?=
 =?us-ascii?Q?TVq5/6+Ab4k0fvWF+Pr8qaxTF9SSqd7E9uiHyOJFzONzm+l5rQTWjfO7X642?=
 =?us-ascii?Q?FTspKdhvADhdfAAG3if3Hb/VjAOC+sm6Sg2j81MxACyYghaMe6oUtDrk6smv?=
 =?us-ascii?Q?aP1L+HfuaDKMENQxxO7Mlo3Yj4TNdEH/Q0fviY7IDLf8c24vzU6h3hi1jC97?=
 =?us-ascii?Q?zXWUuo+bnRVyDBHCVnRQaIUXM9JOThHyenZRfOq+haZ8KRtCO5QRYH22FRY0?=
 =?us-ascii?Q?kudaFoA/uMWNO01FjvJC49OxeP99w1o4AanU3LyjD2qhqUEshPIx4TtDWtsO?=
 =?us-ascii?Q?eIonci0wV55bxJ+p/WkFSb62rLmMUG4ovhukgfQggl3Lea8NgbEPMQ94ughU?=
 =?us-ascii?Q?meW1FFg+9O2DK08HXMmKKPEAUcWVW5ozQJGe9llS+5FJy0st1+7teS8lruzi?=
 =?us-ascii?Q?JacGAx7cMse3m0kiZAKaycgJaqVsfcI1UlGHv88OSpTqPrwGTdE1C3Vqou1B?=
 =?us-ascii?Q?kkGyneEOe0KJ9r4sL7sY+9Urj3GKN5Yzyeg536N7xl3n4kp/s3uJqqIz8Lnj?=
 =?us-ascii?Q?4ZwjbL/dh8S/2wC1o5xWALdj+JENvvYaAy4EbGFBHHspYaHfxG6NqMfp1Qb6?=
 =?us-ascii?Q?ATxiixNUPCUfRG2WfvST1v69pnkF6C1M1YM/k7uV2dBiI7TZmEeEAPL9bicb?=
 =?us-ascii?Q?/78AYl7VdI4vqZ+Yl8IKalPjsCDJ9FTcNFyApvYXjyh9MHYJ+Y5iRvUZ39hC?=
 =?us-ascii?Q?WuYc6ugrXVr1lqb9tpmLULgkCDAvdn0Dhy1jyom1DmeTzCiir+6/Aebp3uLT?=
 =?us-ascii?Q?2S4qJvIACE36mMFgYnIoHkSXfz9EE1HMbTgft7L1E05V0uyJd3q1CUJnJQJS?=
 =?us-ascii?Q?DQnQlJeUCZVfYXFUjsls4uIjzTYpFCg7Y0WuHl3rYwOgd1Y6pxwyE27HvDmf?=
 =?us-ascii?Q?jkoXHXm47XGmcqf95mcH09yulCJbb3fU3VxmFeXox1C/YV45x+sG4jim9xCl?=
 =?us-ascii?Q?BFIXVV49xavoj+E/BrQb7EQirHTIJJefXiPJs41z?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: IA3PR11MB9136.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 5e796d13-9d88-4f9f-aa98-08ddbdcc19a3
X-MS-Exchange-CrossTenant-originalarrivaltime: 08 Jul 2025 03:04:05.7361 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: a1QGf/hZ3FbMAmhqVICDFeENLbqkzKaLER96c2OoClLqSlpwQnNmybEMWN9xnZ34tVmckoVkxit+UsKSH27/FXRZLmIZey0VT5lREl4p1z0=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH0PR11MB7541
X-OriginatorOrg: intel.com
Received-SPF: pass client-ip=198.175.65.12;
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
>From: Steven Sistare <steven.sistare@oracle.com>
>Subject: Re: [PATCH V6 03/21] migration: close kvm after cpr
>
>On 7/4/2025 5:50 AM, Duan, Zhenzhong wrote:
>>> -----Original Message-----
>>> From: Steven Sistare <steven.sistare@oracle.com>
>>> Subject: Re: [PATCH V6 03/21] migration: close kvm after cpr
>>>
>>> cc Paolo.
>>>
>>> After incorporating Peter's feedback, IMO this version reads well:
>>>    * kvm exports kvm_close
>>>    * vfio exports vfio_kvm_device_close
>>>    * vfio-cpr registers a notifier that calls vfio_kvm_device_close
>>>
>>> - Steve
>>>
>>> On 7/2/2025 5:58 PM, Steve Sistare wrote:
>>>> cpr-transfer breaks vfio network connectivity to and from the guest, a=
nd
>>>> the host system log shows:
>>>>     irq bypass consumer (token 00000000a03c32e5) registration fails:
>-16
>>>> which is EBUSY.  This occurs because KVM descriptors are still open in
>>>> the old QEMU process.  Close them.
>>>>
>>>> Cc: Paolo Bonzini <pbonzini@redhat.com>
>>>> Signed-off-by: Steve Sistare <steven.sistare@oracle.com>
>>>> Reviewed-by: Fabiano Rosas <farosas@suse.de>
>>>> ---
>>>>    include/hw/vfio/vfio-cpr.h    |  2 ++
>>>>    include/hw/vfio/vfio-device.h |  2 ++
>>>>    include/system/kvm.h          |  1 +
>>>>    accel/kvm/kvm-all.c           | 32
>>> ++++++++++++++++++++++++++++++++
>>>>    hw/vfio/cpr-legacy.c          |  2 ++
>>>>    hw/vfio/cpr.c                 | 21 +++++++++++++++++++++
>>>>    hw/vfio/helpers.c             | 11 +++++++++++
>>>>    7 files changed, 71 insertions(+)
>>>>
>>>> diff --git a/include/hw/vfio/vfio-cpr.h b/include/hw/vfio/vfio-cpr.h
>>>> index 25e74ee..099d54f 100644
>>>> --- a/include/hw/vfio/vfio-cpr.h
>>>> +++ b/include/hw/vfio/vfio-cpr.h
>>>> @@ -62,4 +62,6 @@ void vfio_cpr_delete_vector_fd(struct
>VFIOPCIDevice
>>> *vdev, const char *name,
>>>>
>>>>    extern const VMStateDescription vfio_cpr_pci_vmstate;
>>>>
>>>> +void vfio_cpr_add_kvm_notifier(void);
>>>> +
>>>>    #endif /* HW_VFIO_VFIO_CPR_H */
>>>> diff --git a/include/hw/vfio/vfio-device.h b/include/hw/vfio/vfio-devi=
ce.h
>>>> index c616652..f503837 100644
>>>> --- a/include/hw/vfio/vfio-device.h
>>>> +++ b/include/hw/vfio/vfio-device.h
>>>> @@ -283,4 +283,6 @@ void vfio_device_set_fd(VFIODevice *vbasedev,
>>> const char *str, Error **errp);
>>>>    void vfio_device_init(VFIODevice *vbasedev, int type, VFIODeviceOps
>>> *ops,
>>>>                          DeviceState *dev, bool ram_discard);
>>>>    int vfio_device_get_aw_bits(VFIODevice *vdev);
>>>> +
>>>> +void vfio_kvm_device_close(void);
>>>>    #endif /* HW_VFIO_VFIO_COMMON_H */
>>>> diff --git a/include/system/kvm.h b/include/system/kvm.h
>>>> index 7cc60d2..4896a3c 100644
>>>> --- a/include/system/kvm.h
>>>> +++ b/include/system/kvm.h
>>>> @@ -195,6 +195,7 @@ bool kvm_has_sync_mmu(void);
>>>>    int kvm_has_vcpu_events(void);
>>>>    int kvm_max_nested_state_length(void);
>>>>    int kvm_has_gsi_routing(void);
>>>> +void kvm_close(void);
>>>>
>>>>    /**
>>>>     * kvm_arm_supports_user_irq
>>>> diff --git a/accel/kvm/kvm-all.c b/accel/kvm/kvm-all.c
>>>> index d095d1b..8141854 100644
>>>> --- a/accel/kvm/kvm-all.c
>>>> +++ b/accel/kvm/kvm-all.c
>>>> @@ -515,16 +515,23 @@ static int do_kvm_destroy_vcpu(CPUState
>*cpu)
>>>>            goto err;
>>>>        }
>>>>
>>>> +    /* If I am the CPU that created coalesced_mmio_ring, then discard
>it
>>> */
>>>> +    if (s->coalesced_mmio_ring =3D=3D (void *)cpu->kvm_run + PAGE_SIZ=
E)
>{
>>>> +        s->coalesced_mmio_ring =3D NULL;
>>>> +    }
>>>> +
>>>>        ret =3D munmap(cpu->kvm_run, mmap_size);
>>>>        if (ret < 0) {
>>>>            goto err;
>>>>        }
>>>> +    cpu->kvm_run =3D NULL;
>>>>
>>>>        if (cpu->kvm_dirty_gfns) {
>>>>            ret =3D munmap(cpu->kvm_dirty_gfns,
>s->kvm_dirty_ring_bytes);
>>>>            if (ret < 0) {
>>>>                goto err;
>>>>            }
>>>> +        cpu->kvm_dirty_gfns =3D NULL;
>>>>        }
>>>>
>>>>        kvm_park_vcpu(cpu);
>>>> @@ -608,6 +615,31 @@ err:
>>>>        return ret;
>>>>    }
>>>>
>>>> +void kvm_close(void)
>>>> +{
>>>> +    CPUState *cpu;
>>>> +
>>>> +    if (!kvm_state || kvm_state->fd =3D=3D -1) {
>>>> +        return;
>>>> +    }
>>>> +
>>>> +    CPU_FOREACH(cpu) {
>>>> +        cpu_remove_sync(cpu);
>>>> +        close(cpu->kvm_fd);
>>>> +        cpu->kvm_fd =3D -1;
>>>> +        close(cpu->kvm_vcpu_stats_fd);
>>>> +        cpu->kvm_vcpu_stats_fd =3D -1;
>>>> +    }
>>>> +
>>>> +    if (kvm_state && kvm_state->fd !=3D -1) {
>>>> +        close(kvm_state->vmfd);
>>>> +        kvm_state->vmfd =3D -1;
>>>> +        close(kvm_state->fd);
>>>> +        kvm_state->fd =3D -1;
>>>> +    }
>>>> +    kvm_state =3D NULL;
>>>> +}
>>>> +
>>>>    /*
>>>>     * dirty pages logging control
>>>>     */
>>>> diff --git a/hw/vfio/cpr-legacy.c b/hw/vfio/cpr-legacy.c
>>>> index a84c324..daa3523 100644
>>>> --- a/hw/vfio/cpr-legacy.c
>>>> +++ b/hw/vfio/cpr-legacy.c
>>>> @@ -177,6 +177,8 @@ bool
>>> vfio_legacy_cpr_register_container(VFIOContainer *container, Error
>**errp)
>>>>
>>> MIG_MODE_CPR_TRANSFER, -1) =3D=3D 0;
>>>>        }
>>>>
>>>> +    vfio_cpr_add_kvm_notifier();
>>
>> Hi Steven, I just noticed this, do we need to do same for iommufd?
>
>Yes, and that call is added in patch
>   "vfio/iommufd: register container for cpr"
>
>> Do we need to delete notifier when all VFIO devices hot unplugged?
>
>No need.  The notifier will be called, and close the kvm descriptors and
>vfio_kvm_device_fd.  Not strictly necessary if vfio devices are no longer
>present, but not harmful either.

Clear, no problem.

Thanks
Zhenzhong

