Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6AB19C3ABC9
	for <qemu-devel@archiver.kernel.org>; Fri, 16 May 2025 08:40:27 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uFqc3-0001wU-7v; Fri, 16 May 2025 04:40:15 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <zhenzhong.duan@intel.com>)
 id 1uFqc1-0001v9-8k
 for qemu-devel@nongnu.org; Fri, 16 May 2025 04:40:13 -0400
Received: from mgamail.intel.com ([192.198.163.18])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <zhenzhong.duan@intel.com>)
 id 1uFqbz-0006IK-IL
 for qemu-devel@nongnu.org; Fri, 16 May 2025 04:40:13 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1747384812; x=1778920812;
 h=from:to:cc:subject:date:message-id:references:
 in-reply-to:content-transfer-encoding:mime-version;
 bh=WbveKIqMPmZUapg28t9Vlj0AEQJItOD0Is9Pgcskk1U=;
 b=FaDP5ROr2sNdlju64KvBu0FvHdHTRrCjqMBj9nFYttPizK56Oj2PXF0H
 xjNOEx9RdzbEVMHXzwHTxejjch40T8QYj10O4Q/Y8d1PQdAelXRy5S9qh
 5kTTku1BZBfYK0Pme5xWuX5R4l5U8Hg9yYhktdzrQRB+tEFmGY1xB5Xlx
 8yaNjNC90UXUQqpGra5mCXzd+wdEVh+laamWWpI1fyZrQo8xEhAZrexaG
 8ftPXK+F4I4gWl8u2wj+IsmpOgWaHTbPvmSwQwA+FVNV8maBacEDQe8zC
 MYy7Q2L3AA98CpM26wjZnFV5w9ewMHmEK7TBdLarXJp1bajfp5pnooUHH Q==;
X-CSE-ConnectionGUID: GCfh+RxkREGESdy4nVFM6w==
X-CSE-MsgGUID: c7Y70vegSS+0eEWNVI3LLw==
X-IronPort-AV: E=McAfee;i="6700,10204,11434"; a="48601289"
X-IronPort-AV: E=Sophos;i="6.15,293,1739865600"; d="scan'208";a="48601289"
Received: from orviesa002.jf.intel.com ([10.64.159.142])
 by fmvoesa112.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 16 May 2025 01:40:09 -0700
X-CSE-ConnectionGUID: g9edv07qQ06Ftf+dk9vbOA==
X-CSE-MsgGUID: 4RVvizfZQ9GunKBgBMe2Sw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.15,293,1739865600"; d="scan'208";a="169562313"
Received: from orsmsx903.amr.corp.intel.com ([10.22.229.25])
 by orviesa002.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 16 May 2025 01:40:08 -0700
Received: from ORSMSX901.amr.corp.intel.com (10.22.229.23) by
 ORSMSX903.amr.corp.intel.com (10.22.229.25) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.14; Fri, 16 May 2025 01:40:08 -0700
Received: from ORSEDG601.ED.cps.intel.com (10.7.248.6) by
 ORSMSX901.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.14 via Frontend Transport; Fri, 16 May 2025 01:40:08 -0700
Received: from NAM11-CO1-obe.outbound.protection.outlook.com (104.47.56.176)
 by edgegateway.intel.com (134.134.137.102) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.44; Fri, 16 May 2025 01:40:07 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=PxljLA5ccipEHAXnk0dJ25/lSAemMuMDB6Vh1e6P8IT3srESNhTUUoDxtNp9YIzT++6+op0Nnc69SLLBnvZM6EAVcl2LzFYtiTi68IT+IZLKGmsxiq5QasBJT6jHbOwibfmJ5/cQx+BH87YWwg800ifY+muuYENEmyIZRWAPkTLQJVc3inIk1cINXPKonytlS1dWQLbrlUCw3HJGWb5HLEK7sm0AxoLLaScaZ46eg/jP0pKNbiYZES1tuQTOALgV4/9cuIcTyu5DiugW6+tYhB2eFtz1JIWmgblfzff6Bg/VS79iIEHb12nncQo3k8hKLYKay3M9PiZLWnMsJPrTcA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=WbveKIqMPmZUapg28t9Vlj0AEQJItOD0Is9Pgcskk1U=;
 b=SDAXEvijwiaJsupGZe/1qJf+rLcvtCpGVYzaHqT0If6fd3q9YU7emZC2w0odDQxFyyXryazLTy3QQ/ZKbLToL2K+4pJoytihP3yFF7i30O6/xjhizoBjKh0ivgHEnT5aGY7fcr5GsfngCtj9HJlgl8SY+Bb75EBriMj1rsaB1Ft04UR6StgV0T5dHKX1/4sK180xqLCitUuyGPrf+1GKV4PyOfuARJhKOCzhd5iHn2mAEBQ4BEG9FYbreTk0wK8FUz2RdF79qjMaohYr2JWvu9tYhploRBmy/rU65paTa6vUXpbuW89UB1+Lgh4xZkwCYh1xMD1yVrjdGwab/9yeMQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Received: from SJ0PR11MB6744.namprd11.prod.outlook.com (2603:10b6:a03:47d::10)
 by SJ0PR11MB5769.namprd11.prod.outlook.com (2603:10b6:a03:420::8)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8722.25; Fri, 16 May
 2025 08:40:04 +0000
Received: from SJ0PR11MB6744.namprd11.prod.outlook.com
 ([fe80::fe49:d628:48b1:6091]) by SJ0PR11MB6744.namprd11.prod.outlook.com
 ([fe80::fe49:d628:48b1:6091%4]) with mapi id 15.20.8722.027; Fri, 16 May 2025
 08:40:04 +0000
From: "Duan, Zhenzhong" <zhenzhong.duan@intel.com>
To: Steve Sistare <steven.sistare@oracle.com>, "qemu-devel@nongnu.org"
 <qemu-devel@nongnu.org>
CC: Alex Williamson <alex.williamson@redhat.com>, Cedric Le Goater
 <clg@redhat.com>, "Liu, Yi L" <yi.l.liu@intel.com>, Eric Auger
 <eric.auger@redhat.com>, "Michael S. Tsirkin" <mst@redhat.com>, "Marcel
 Apfelbaum" <marcel.apfelbaum@gmail.com>, Peter Xu <peterx@redhat.com>,
 Fabiano Rosas <farosas@suse.de>
Subject: RE: [PATCH V3 30/42] physmem: qemu_ram_get_fd_offset
Thread-Topic: [PATCH V3 30/42] physmem: qemu_ram_get_fd_offset
Thread-Index: AQHbw1wv+ARtaJFeCkWu7kh7J2Z+Z7PU9XIw
Date: Fri, 16 May 2025 08:40:04 +0000
Message-ID: <SJ0PR11MB674419ED5F2D0A076BFB499B9293A@SJ0PR11MB6744.namprd11.prod.outlook.com>
References: <1747063973-124548-1-git-send-email-steven.sistare@oracle.com>
 <1747063973-124548-31-git-send-email-steven.sistare@oracle.com>
In-Reply-To: <1747063973-124548-31-git-send-email-steven.sistare@oracle.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: SJ0PR11MB6744:EE_|SJ0PR11MB5769:EE_
x-ms-office365-filtering-correlation-id: c32862c0-c121-4161-2a10-08dd94554116
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0; ARA:13230040|376014|1800799024|366016|38070700018;
x-microsoft-antispam-message-info: =?us-ascii?Q?j+USirvlllejw1fc+VAOW52qo3F4n/b5wdLBUSIi+HXt0DS0t6vuX4K9Veti?=
 =?us-ascii?Q?aaV5rSJH2I/qmz+dDmwBxyTOivMVXhxR/tQmYoUURgWNvgfyXuqMR0wywif2?=
 =?us-ascii?Q?HTUkLJglKn6uBtRs5WeN28cZk9dDIHUzZltfeM/imEPSreo0UExB3b2K4igp?=
 =?us-ascii?Q?xFaJvP6Qs0BHpXYWahzDNzb+nPnnS3v1KmuATprNiZzuIQ6GtGSOynMv8ceH?=
 =?us-ascii?Q?SYEESrowCV+B60RPOx7duGuYoimLbzZuZB95yWf/saVU04FINEqZM3ytRf+r?=
 =?us-ascii?Q?YoPv/zIeZ8BOP+hhN+b5HlMX0JtCOncFP1Yaj02SYsaLuPJghgtHNGnZCGyi?=
 =?us-ascii?Q?tazNHE0hgJX9MUdSDUQbDkjbl6dCgPHA4Y9ceYVhrcxgyesVf+B0nJJLsqop?=
 =?us-ascii?Q?azXZiI9RYr+JeGepPdrYz55Wlh8xrbJxlVgF4lp69hiH4HMwYKCZNyCHGtnc?=
 =?us-ascii?Q?IjhryobHndO+MDAa0wq7ng8BHSoQ+OnPY6NbFicPLQW5bSqUT3ID1SdiXnFM?=
 =?us-ascii?Q?AKZw/4tdt0r3yth9/L0ix5prOIi9jgpNv2uH6Ad5fHXuMJFAKwmD4qGIMwwP?=
 =?us-ascii?Q?hfbuIz6ntOPwcEzr8ZgTmWm0uGLfTIWa+ilwQlfhA9oxOgWOxxF/xcc5Cpdi?=
 =?us-ascii?Q?9B4rcI2cYFxL/zXboimwK4v1bsoq6oAKJYInXFFq7JMsDcz7lxSUUxu9Y7R0?=
 =?us-ascii?Q?74C/DjHKN0qsH04NsVOphXTtNZ/BpySUNaQRkuuPDjcgqiS/JoPgGxBZ0p+O?=
 =?us-ascii?Q?LxO4M4JbqO4MzDwNbpqR9pswtLvkpTWKRjjhjVbw2NVcMBWCxr32t9tZiOdE?=
 =?us-ascii?Q?VkOyBfvup6Exl+0bavkR+b5Exsgs1+nSHP731hj5+x9WpomIY6pjbiK5zC7A?=
 =?us-ascii?Q?JubSBRIeBuXc2v6L94HhTeNTwxxlvdFO3XunKkY0VJ+m2aoq8SldDuXbBsNE?=
 =?us-ascii?Q?+UE+ibY8CYcrPm5GgaRVSulolJbQm02Xx9nel+fHpIh5yzPho2dFC3m/OcXf?=
 =?us-ascii?Q?ZOKxeaZXzEMt/P2Ib5VYAaQNO7hSzre12jhUK8cuYLV09ArabPZz1nvyE3RT?=
 =?us-ascii?Q?eLJAziYNRIqEWUfpxfnhfEFbRkHa2d7B3+UPNc6xGG3zhQ68Aul2fIH8OamF?=
 =?us-ascii?Q?Qb6YGyoB1C6cYThk/qgjQf3DRDB/sKX+pMs1s7n4s+83+TmLWuJyxaktbQCv?=
 =?us-ascii?Q?5AoB/WveU+Vyw+HqiAkRmennPzBHcDhS/3zfrofnZqNr43eYou2mUTD8kFrU?=
 =?us-ascii?Q?QYtyGZa6+ax4sAqu0/Q92gjfwKd1WxCy5TEoJseVRcwWp6T7VzSF1ZKWFnBq?=
 =?us-ascii?Q?PvYJTQWZSNZvLXfFpKzrU6YgV87UbSbdOgTiQauHsG0KDwMra50FAW6jnIm5?=
 =?us-ascii?Q?SI5cXBEmOHDj9RKDYujSoYTPx5vavkg+0fMFGWq6nCFWTz/3oi7q71/OygIS?=
 =?us-ascii?Q?wiWETieFwCKIvwSHWwkFDnPHM1B4gOiNiAMGKJWYjpeel3uBr25ebndkFcvF?=
 =?us-ascii?Q?RSa44AV18siWZQ4=3D?=
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:SJ0PR11MB6744.namprd11.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(376014)(1800799024)(366016)(38070700018); DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?iO5QKMpz6+iYq3MHLg6sV3NJI6umVElNGXgEJgI3dl8D1tMW2W6oIvlbrL+c?=
 =?us-ascii?Q?BgytvrIWyKVIZH/cDGmX0sFW7D6UYAUJtQoxKA6TVdu75t79XI8MBpuXvE7s?=
 =?us-ascii?Q?mmT95JfmJhRTtevF+UfLbJJDNSmC9e4oEiOQAqUNzYk27/3Zqy/MRzwqUWsL?=
 =?us-ascii?Q?VG/pP/u2G+lWcbvf28sXcZNaK4/eUxnoFSNHFVAwM6Q44tyCnSkJMnWgsMZJ?=
 =?us-ascii?Q?Q1G9ahmANyfmTOO58+M7Yn9K0s/or8J7Dt3uTTLC59hOySwYDGIjT1xmU04s?=
 =?us-ascii?Q?HgTwESw8LBa2oFeWUb7BpGOh8uilkJdfhr/lrmFwfAcdVTBynsvZX640XrMz?=
 =?us-ascii?Q?8OLblR77NkH5DUPcsBCWPcvUIdiLndFwJJ4p5JJ7AWtFTfnoKy1bkxedrS1E?=
 =?us-ascii?Q?21XOjs1Mgq1k4mpSJSj/cKjcHjn7ME8WpjGF1cxd8CO3zvq+3SuxjVCAjE8k?=
 =?us-ascii?Q?jWrZKDEpfdJApmi/aYYb8pvdPTVTtUgy10nDfjwmn1EQxLLF6OdmfZgx3ro0?=
 =?us-ascii?Q?UjnJ4n1cIJCO0nCSMEy494tY9KnRtbgs4r+hGs0j1883lxlYIaYGWBNtKpNc?=
 =?us-ascii?Q?F0RobzNTh6zd4iO94suaRs04eR0761EnHlb59rNFXYMgKFM0lXdpapsyFOcT?=
 =?us-ascii?Q?gwhZZpdSJuZGEmYe9XmZLwWnbXTqq0VGsXi+6Bs9Xj8h8xFIoOd0ptO3IcQZ?=
 =?us-ascii?Q?h/O5jR5wHSRSY0daKIPt/UTXMq1b/RjmnU8l8j1TwoLnOxmcDOiVcJ84LNHQ?=
 =?us-ascii?Q?SwHlRUTnGgBlLoT2uE/8o5CKco3nC093AvBIULNmHveU9pyb0Mc62tucZWku?=
 =?us-ascii?Q?hOo+uXP4fWEFsgdvxtnove/xpFff9j5jyyKRbErB4B7fJ4uFJSkLxXduCn1I?=
 =?us-ascii?Q?k6EtUIShK77cEyKMZWmX31kxdb/AuZGUvtyC4qySJuXei123+CPauluyDJWd?=
 =?us-ascii?Q?PH1D3V9bm2bJSuQjzWqRhXGxv0JG6e7CRSC9Sm1NB8VWKomxuWDf63aQQ0cO?=
 =?us-ascii?Q?bSDI3/PEacqYZLtatassXRDwkQjOc9Dxg5oYflY2UkIjfSfqdbGJlx+7NJRT?=
 =?us-ascii?Q?iL2P4EPfyAvbjfatC6KD3T4hyCBIwk8JZH1HO343urG4eIuCrycNT+4m2L+Z?=
 =?us-ascii?Q?w0q42SzkRKXxuzKPcqK/lcjHOyEngLa2VY5yVubYE8gL6bnrwGx65QXBCu1/?=
 =?us-ascii?Q?6Iin8LUqtJhzzLEmHQ4T5y3/k5Xk/JWdqwGS0YrZwREKyrei3nKFlwDXSWpU?=
 =?us-ascii?Q?PSmTguWZ+LhI6OJxDaHVMypoibWd2VKRiNCY3OLczvmhYHHvt0bAY3JNG+1w?=
 =?us-ascii?Q?/zUuQ1VIxeZMoatrT/+iBgkXfEgOyAlE97jU/8hLGFWOmC9GKOoSjucYZpX1?=
 =?us-ascii?Q?4qM0FNW1mL+aGfknkAlMAvkqFRJDWk5vac+IDQAcbaaBv71JsDFV423H6GJI?=
 =?us-ascii?Q?w3KI12izBCFKwsi+TyArdN0S7fwFoWvI+fDTM2FC5pFjbsEVvbLmJ/Z1/D/k?=
 =?us-ascii?Q?er4DzHaXjak1GXMyT/XWHQlfXu2kkX9mJs1Mec1QTMj+NWmN/u2abP6rxr8+?=
 =?us-ascii?Q?WqvDjPZ8GihEACuK1Z1FjHb0RFYoimEGzxPssrgC?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: SJ0PR11MB6744.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: c32862c0-c121-4161-2a10-08dd94554116
X-MS-Exchange-CrossTenant-originalarrivaltime: 16 May 2025 08:40:04.1546 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 0aDLJH86hL5eAwXDONiUD0oQ+Q1Rmr9CPErY4abRqFJDh9vTXR2U8FOiH/uOa8MMoswFKnESAaMRlhgRRJTiSp+aE1JPnUlz/N22ZID/7eE=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ0PR11MB5769
X-OriginatorOrg: intel.com
Received-SPF: pass client-ip=192.198.163.18;
 envelope-from=zhenzhong.duan@intel.com; helo=mgamail.intel.com
X-Spam_score_int: -60
X-Spam_score: -6.1
X-Spam_bar: ------
X-Spam_report: (-6.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-1.686,
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
>From: Steve Sistare <steven.sistare@oracle.com>
>Subject: [PATCH V3 30/42] physmem: qemu_ram_get_fd_offset
>
>Define qemu_ram_get_fd_offset, so CPR can map a memory region using
>IOMMU_IOAS_MAP_FILE in a subsequent patch.
>
>Signed-off-by: Steve Sistare <steven.sistare@oracle.com>
>Reviewed-by: Peter Xu <peterx@redhat.com>

Reviewed-by: Zhenzhong Duan <zhenzhong.duan@intel.com>

Zhenzhong

