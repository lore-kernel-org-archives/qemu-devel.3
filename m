Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id AFBD7C3ABC9
	for <qemu-devel@archiver.kernel.org>; Fri, 16 May 2025 08:27:51 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uFqPm-0007yO-O6; Fri, 16 May 2025 04:27:34 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <zhenzhong.duan@intel.com>)
 id 1uFqPi-0007wf-Ra
 for qemu-devel@nongnu.org; Fri, 16 May 2025 04:27:32 -0400
Received: from mgamail.intel.com ([198.175.65.17])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <zhenzhong.duan@intel.com>)
 id 1uFqPg-0004jI-Ex
 for qemu-devel@nongnu.org; Fri, 16 May 2025 04:27:30 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1747384049; x=1778920049;
 h=from:to:cc:subject:date:message-id:references:
 in-reply-to:content-transfer-encoding:mime-version;
 bh=nfwqaz+Z9f4s/JFdZ/2nBIicHLaXAZyhSkoguojE3Cc=;
 b=WxYkCSM11IVLPz+oVfOvRltRAnQUuVCGQNG2sTMI2a3ifQUOMxJQbnxo
 LK3xB0U+y5TzADIe5JrjqjzNkpOXNEWpU6zthGahmyvMvq4ryW5SEiSuY
 4ObPI7Dr52+xCeLi9PAXObTkYZkamBmh5ZkAdm6egGzFuwCmbh9+GDKTy
 wk9NFjXBdkarK6zd//ZZ73bLFLm6VF9Ufy0IClalzW5Lppav2fu2HUp5L
 khVPjl8SUaaznXShC9Jk6G+hm1j3OCIJeMuXM8G1ex+1VHPH2E6I5kQlb
 hb32hpICaVS9YvW7UezAh18tkMedRjSEwNNCswHWWzdtcAXmZV8KgqKJq Q==;
X-CSE-ConnectionGUID: Iycz3rs4QWq8RmrjMzbFsQ==
X-CSE-MsgGUID: D8yo4yKqRwiJjGd0uMUbNg==
X-IronPort-AV: E=McAfee;i="6700,10204,11434"; a="49332199"
X-IronPort-AV: E=Sophos;i="6.15,293,1739865600"; d="scan'208";a="49332199"
Received: from fmviesa008.fm.intel.com ([10.60.135.148])
 by orvoesa109.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 16 May 2025 01:27:24 -0700
X-CSE-ConnectionGUID: MvJHK0HrSxWRa2ALaH5WcA==
X-CSE-MsgGUID: iHYrtg69TE+lmZIeavC8oA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.15,293,1739865600"; d="scan'208";a="139016501"
Received: from orsmsx901.amr.corp.intel.com ([10.22.229.23])
 by fmviesa008.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 16 May 2025 01:27:20 -0700
Received: from ORSMSX901.amr.corp.intel.com (10.22.229.23) by
 ORSMSX901.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.14; Fri, 16 May 2025 01:27:18 -0700
Received: from orsedg603.ED.cps.intel.com (10.7.248.4) by
 ORSMSX901.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.14 via Frontend Transport; Fri, 16 May 2025 01:27:18 -0700
Received: from NAM11-CO1-obe.outbound.protection.outlook.com (104.47.56.173)
 by edgegateway.intel.com (134.134.137.100) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.44; Fri, 16 May 2025 01:27:16 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=pJS7Lr5MFEwvglptWZ20E/xYUfTpBrQCZLoT3cGnpLQMqY7uuN6UZy9xP41PHtUQpAIpSeUnclQl/eQ4yLgeGGJ4MYe7vTllG2NYDUBV2B7M6WkcLMcRAkdA72Vz55Ck0sO4uOuvRuxqULQDZ7UUi3aD+68aCH/jrkrj8m1Mq78JP7WNEALeX7JUmwI5GTnrysHZTE3aX/oKxf9w6+kH1mFCOS/tH9PuQrmVujsCchFaEsnad5zPtdSUqJHBK5giD83X+fTjkxpN9kmzUWk0lUd1MWZX/Ff8BDd6luoQ3RbnWsmtdpdnEjdF0SAkDv9WdoXAb8jTGo6YQJfnxd0ntQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=zQOFWmsusA7CaLi4exuy5LeiBeqjJtaIoc4mFIsXJio=;
 b=ZUbauz0JcOzUCjdH0vAnMwhMjhLfAY/Vri0stnjwGO6hj4scMZhbyASXpZJVVG+uF6g4BEi+tZDACG+xgMMV5dW5zU1EpVSGDIn6jyiyJ/mLwumHjnPRGw3K/ea05W0ULzFGaCa+pU9WnKoBHlCaFv+SYYgiCcqFytEs/wLEQ1OVpcU68hUpWYtb2S/o52UjE/gdlfD1I1lXe+rUVuYtZ8bZYMlYZKdUiv4Q72MMdct/72q88E3rP5/O3rkQYAEX73P5xeLKLtojbvg6o36XvgQF7q3ifAmmp0DT+Ub2RJRWEUKW5hUplaYsby7YXyWhQD2GbuRMQQLaVcWDiRuIdw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Received: from SJ0PR11MB6744.namprd11.prod.outlook.com (2603:10b6:a03:47d::10)
 by PH7PR11MB7720.namprd11.prod.outlook.com (2603:10b6:510:2b3::17)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8722.31; Fri, 16 May
 2025 08:26:41 +0000
Received: from SJ0PR11MB6744.namprd11.prod.outlook.com
 ([fe80::fe49:d628:48b1:6091]) by SJ0PR11MB6744.namprd11.prod.outlook.com
 ([fe80::fe49:d628:48b1:6091%4]) with mapi id 15.20.8722.027; Fri, 16 May 2025
 08:26:41 +0000
From: "Duan, Zhenzhong" <zhenzhong.duan@intel.com>
To: Steve Sistare <steven.sistare@oracle.com>, "qemu-devel@nongnu.org"
 <qemu-devel@nongnu.org>
CC: Alex Williamson <alex.williamson@redhat.com>, Cedric Le Goater
 <clg@redhat.com>, "Liu, Yi L" <yi.l.liu@intel.com>, Eric Auger
 <eric.auger@redhat.com>, "Michael S. Tsirkin" <mst@redhat.com>, "Marcel
 Apfelbaum" <marcel.apfelbaum@gmail.com>, Peter Xu <peterx@redhat.com>,
 Fabiano Rosas <farosas@suse.de>
Subject: RE: [PATCH V3 27/42] vfio: pass ramblock to vfio_container_dma_map
Thread-Topic: [PATCH V3 27/42] vfio: pass ramblock to vfio_container_dma_map
Thread-Index: AQHbw1M3BMj8f5EJwUCLd5qHBjdll7PU8RCQ
Date: Fri, 16 May 2025 08:26:41 +0000
Message-ID: <SJ0PR11MB67445171E42DCDBD02A1CCE19293A@SJ0PR11MB6744.namprd11.prod.outlook.com>
References: <1747063973-124548-1-git-send-email-steven.sistare@oracle.com>
 <1747063973-124548-28-git-send-email-steven.sistare@oracle.com>
In-Reply-To: <1747063973-124548-28-git-send-email-steven.sistare@oracle.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: SJ0PR11MB6744:EE_|PH7PR11MB7720:EE_
x-ms-office365-filtering-correlation-id: 610bf28b-a3f9-48f8-85fc-08dd945362c9
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0; ARA:13230040|366016|1800799024|376014|38070700018;
x-microsoft-antispam-message-info: =?us-ascii?Q?MkoVX+Vy0dOcplYcsGADBv60wSGZQldaBHExzmPzRN4hdEjoY8FmUpLkwMjz?=
 =?us-ascii?Q?kZdpJCfD1ohXx80oxJ74dGw/MH5WCgekkWsVU3MlEEwD82fMpe/Oj39oJXVh?=
 =?us-ascii?Q?CoylNE+H3sE5d4P5AiXBxXskIRlYiXqeR5d48wAWpW6BLEZKro5sOXLNHqTV?=
 =?us-ascii?Q?hzQQWlyrGLPS+TYwjOJPr92GaoNBx+i2RraM+2DtLVjk7ZazkQ9Jsl35gJR8?=
 =?us-ascii?Q?ba3RXVxqdEcJzx5f9HORKFKyfrgK2pwCDCdrh5/jCdf9Wexxv+BiTqgFT1rN?=
 =?us-ascii?Q?ZuSUYmG10hjHNixeZKptTVSrLRdOnZkyOdegwwLp60oGarVuUbI46iwMUJug?=
 =?us-ascii?Q?AftFpSpwdkGOyA1o1VrtTwS36KBZDoxuGJxmdVgsdZWTjZqqxC3XML9ZSzee?=
 =?us-ascii?Q?J7SuFKj0TdTXGSyc7sj/9ld+rzFjAMcg0Ujn63NH+y91g4vhCaD6wLGSSIrv?=
 =?us-ascii?Q?GkXRYrctdabdssGkcyf3FRHEb5FVKqlCOGahpIF3OrQisbKZh7/9sbHXOQk/?=
 =?us-ascii?Q?Rmuy4na5b/fcY2gQ6UsJvliK06hGEuWRwppkk5m+PRY3Horlh85c1CnolTew?=
 =?us-ascii?Q?MgIZUGkLZKDrt2c9xT4P4tJeeruC4Qrina4sXBh5rEFklNKdkHYoZB3pDMyn?=
 =?us-ascii?Q?cII8b6t6eZL3MWJ2UYwgJ2ggCalbFElBmcT2IHtXj76Cbtv1VRLMqBEteIea?=
 =?us-ascii?Q?Dw7vUiWoxF6LT24PLW3V9+mZrNEvRpHKWkG7fY4fJ3djbL0HaJO5jxNK45Hh?=
 =?us-ascii?Q?XGnbAE7A8j93wVAUuO5L56G3S8ShGk3j3vPVlvAL7vnU+GrRptFsXUqFOUJY?=
 =?us-ascii?Q?F6V1kjq8VDTeFdCeloNxGqLSQ2l79iMN2c+CLOv6ZXRrkyuu+IBHtdmS7ziB?=
 =?us-ascii?Q?a0LWoLr15x0uzjzWKk4UFueeKYDIKHe56R0nRtJauqH/7bB2PmGUwJ5i0iMS?=
 =?us-ascii?Q?KdfQ4kXx2iSSS+QS+fNP/SKY/fLBhGJdpPSSpq2oVEup3rZaCjhdjPOCLkWu?=
 =?us-ascii?Q?7KnIFj7qEW1lNUa6KrdH6FOY4zcarc1xnAgQHEQsh5oQy1s72AanrvfBrtLv?=
 =?us-ascii?Q?/mRC+kRcuy+6sQg8BOOExNuPPSIh7Bkvyz2S6HIODFQV3N5WRuWK4fw1ruxh?=
 =?us-ascii?Q?OM04KqCWjySfJcVZ/OKDwtOa1msK7kO8Ue8nJh3Q0thv2mLLX6vBPf+JTqZR?=
 =?us-ascii?Q?npdLj/zhpKUOcn0ZBG5SFsXuTclCIv+nfc/PfjgulgO9bM69kBh1H/s6KgFm?=
 =?us-ascii?Q?AShnQP1P51wu101Fuicmzi91BKszM4AkDFWOMQxKbuD4jILFYmhkkW3i+XK6?=
 =?us-ascii?Q?mhCq1+fnd2qQNGcvzfaIKBRis3kkFuxdm1V1EVIlPTdTyZRwn10ndCY30jgd?=
 =?us-ascii?Q?JV02KBx4d/NT4xPV+7ybbSh5vQzr5t4KeT8B9sJgXohxfbZU54U7Tt+iJFnF?=
 =?us-ascii?Q?9JnNCpC0kk0PiTad2QRaG9sss9qLa0W/c0JCQsxjpN4WATszAna94qrFhCS9?=
 =?us-ascii?Q?8PkdTgBoY0xInSw=3D?=
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:SJ0PR11MB6744.namprd11.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(366016)(1800799024)(376014)(38070700018); DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?msdH7hiknSYXCBoU+oFaOaU5cVdi5FzMo3aVwgvh6d8v5MhixcxQB8Bpvtkf?=
 =?us-ascii?Q?5M6kaO9l1ljk891cKh3kK34Es9rbEHBiTa87Bvv41vEyBUb486OJsv9GS235?=
 =?us-ascii?Q?lsxAt27wU4T8fb0FlBRd2PbP5EchPp0pf9Ym+dnizRNjiAwdd//Vgk0P8kUm?=
 =?us-ascii?Q?Rw2TWWB2cnyUCpdzNThP08mRBhfpfhieAW/8zuDaLroBEWFPC+WdMVrYESxW?=
 =?us-ascii?Q?sWaXV36Xay93Nmw5ii8l4JuOvBPc7s8RthX+xQDRMp856ds/tazZIqu+ZNNy?=
 =?us-ascii?Q?dePfFRI8vbaHfSsXmSVGKPvECRAZ/yOJCkIIo/2NvNI9gavKW4zf/3+KstW6?=
 =?us-ascii?Q?T33Tm1Xtf8IM7L3vywnfyA9nxDxhWrqOHa9KQXYP5hK0JnabF/0z2Al7LLu9?=
 =?us-ascii?Q?ZJsOfXp7U2G0otr2SMvoeiUgZTZpcoG2xdG4qIFHfsW6Cw5WBqTQHfYTy05X?=
 =?us-ascii?Q?GQfUw7EcM6j3NUB12TePjDD3Xoj2gOc7gY0s32FPDY8EjFyY/STQuCl0z7fE?=
 =?us-ascii?Q?+vIDHJFUOdc7gPs6zrfMhg6vywpGBWWKQZrEkskVev0Ch0znw37bxQbOhmwx?=
 =?us-ascii?Q?fdWywFjwdH88y5/YZ+0vAtWJPPzX+NHSZwO/qqv3EiO+WVVKMUq093sirkC7?=
 =?us-ascii?Q?BbkeDJUNHHdKaQMx4/1vQWeONaycxdU7ul0r7PE2wMGplHCRs/lFYlCXFxgR?=
 =?us-ascii?Q?FF6NMTmJAsSj50CNNxDHjPxMfSgNjQ0GCXUEr29jYwmU0ca51+driZcKbGlL?=
 =?us-ascii?Q?pJaGaDe6wEWdWu17PeDMzbDVEe8/UCpz0pXjpnzh8zLeZDeX6f4v8pL5EpAG?=
 =?us-ascii?Q?uUHX0sleEDjA1hvzmdryq7HcUa9M6EZPGzBg9Pc49Y7l4kyRtdLK8/OmtwIq?=
 =?us-ascii?Q?H2ZcipCKBSFLJ+CqKLKj82E+LkTrKIk90O/9vhgZZ8CiwDRP9v5RwmFfJ9lc?=
 =?us-ascii?Q?OybuXu6U8lJM9igNdAcs5F/D/7SjiDqT5L+w8D8B04UUzbX+p3cGd8tUr6N0?=
 =?us-ascii?Q?jhaEhStA9Hgv2o42KCylbEUmW9E7R88ug3apMXvOQ9dCWCkqyV8OTy7GfFe1?=
 =?us-ascii?Q?ULtcmrzYJKtXt7au6fbAq3v0t+Na1akGptrdojsn71EKBSbs4+jrTTLQ5fdP?=
 =?us-ascii?Q?Mgt7/wQDl7ZcSbBUGjFmQ3qzHyz0bCij/wvpSCTQ2Q+u2uCNdQ0dZzlfFJMn?=
 =?us-ascii?Q?kQ/+vOPrMNsKryM/UUaLomB/PRRcbHPkqhjCGSmm0QqQKsWl1BTPRNpCEkLW?=
 =?us-ascii?Q?3t+9c8ZNlQptLF4y+V850AZZ0B6hbWXJZfgEqhRId/R6x4Jsin3wGN+pjHC8?=
 =?us-ascii?Q?S6+oxKt7zj60GSPd8gbz21ezind08J5bZf/0H9o09hjIXrdLz7NHQYzVEFQ0?=
 =?us-ascii?Q?3hDul9j4b0XgEeMqoDp2b5nYhwAu5uby0MbiWql8Tws5V6KKB6EzQ294a7wn?=
 =?us-ascii?Q?ASl5sSc3/UmWIx/pwCk4fCIRYst85FAav8ghbic2Qo7nDwZlJebnXRR2Sl91?=
 =?us-ascii?Q?QRjW2YEMqjqpoCvY6WcBbFM/ueDZ/pPbKkIVBf2gE4rErrlQyg2tm1BgTCdt?=
 =?us-ascii?Q?yZ47ST+2fJQ75RWbVs9XJX+YwkDWw+Vs/4UdB2wn?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: SJ0PR11MB6744.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 610bf28b-a3f9-48f8-85fc-08dd945362c9
X-MS-Exchange-CrossTenant-originalarrivaltime: 16 May 2025 08:26:41.6420 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: kUwmvXdWkxfLkZklYO1reQTrG7ST0Zo1fyd/jeMI79F+WkWL8qiyE369bbKbVz1mmU2+NfFw6OpQdywuF9UByAOn9wjT6tPAHp1n8YvSaz8=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH7PR11MB7720
X-OriginatorOrg: intel.com
Received-SPF: pass client-ip=198.175.65.17;
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
>Subject: [PATCH V3 27/42] vfio: pass ramblock to vfio_container_dma_map
>
>Pass ramblock to vfio_container_dma_map for use in a subsequent patch.
>The ramblock's attributes will be needed to map the block using
>IOMMU_IOAS_MAP_FILE.  No functional change.
>
>Signed-off-by: Steve Sistare <steven.sistare@oracle.com>

Reviewed-by: Zhenzhong Duan <zhenzhong.duan@intel.com>

Zhenzhong

