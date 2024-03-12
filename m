Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 83252C54E58
	for <qemu-devel@archiver.kernel.org>; Tue, 12 Mar 2024 01:19:52 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rjqnA-00084z-Jy; Mon, 11 Mar 2024 21:18:56 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <chen.zhang@intel.com>)
 id 1rjqn8-00084Z-LP
 for qemu-devel@nongnu.org; Mon, 11 Mar 2024 21:18:54 -0400
Received: from mgamail.intel.com ([198.175.65.15])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <chen.zhang@intel.com>)
 id 1rjqn3-00055W-DT
 for qemu-devel@nongnu.org; Mon, 11 Mar 2024 21:18:53 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1710206330; x=1741742330;
 h=from:to:cc:subject:date:message-id:references:
 in-reply-to:content-transfer-encoding:mime-version;
 bh=lS0Qnff1ruG4K0HpnmneNUhg7aKKVdF8PkUZfz0jcPg=;
 b=TL2d6LduNt6sKbNJw++8sCUAogZjT+cAuE3/fqf3gfFugcOkGfRnwiec
 cBR8e+mu8JtRAgGlcx17ADLEfvNZN46sQu2MopiDLM3SvBp6/PgTfSoAC
 9rhcQ5mTX6T/Mvfby5fzfWCvU8D3Gcch+7ZVMnCu99juWXAZMeqgpj7/P
 2EZVCFMFZ8WSfg7P+y3WSIKW6oQseFbux+KZQy81D17J9kBh9gM337Eq+
 vMqggLRoSSR5OTqJbbPS9LeGBg28uOwAR2uXDydHJw7C6NOiqcIrwqC7n
 1r4onsoJUjkgANG2Hv8+TGdli3TZ1rmU5GEIEc6xnF55weH7hWUIpko/S Q==;
X-IronPort-AV: E=McAfee;i="6600,9927,11010"; a="8714958"
X-IronPort-AV: E=Sophos;i="6.07,118,1708416000"; 
   d="scan'208";a="8714958"
Received: from fmviesa006.fm.intel.com ([10.60.135.146])
 by orvoesa107.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 11 Mar 2024 18:18:44 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.07,118,1708416000"; d="scan'208";a="11429755"
Received: from orsmsx601.amr.corp.intel.com ([10.22.229.14])
 by fmviesa006.fm.intel.com with ESMTP/TLS/AES256-GCM-SHA384;
 11 Mar 2024 18:18:42 -0700
Received: from orsmsx612.amr.corp.intel.com (10.22.229.25) by
 ORSMSX601.amr.corp.intel.com (10.22.229.14) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35; Mon, 11 Mar 2024 18:18:42 -0700
Received: from orsmsx601.amr.corp.intel.com (10.22.229.14) by
 ORSMSX612.amr.corp.intel.com (10.22.229.25) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35; Mon, 11 Mar 2024 18:18:41 -0700
Received: from ORSEDG602.ED.cps.intel.com (10.7.248.7) by
 orsmsx601.amr.corp.intel.com (10.22.229.14) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35 via Frontend Transport; Mon, 11 Mar 2024 18:18:41 -0700
Received: from NAM12-BN8-obe.outbound.protection.outlook.com (104.47.55.168)
 by edgegateway.intel.com (134.134.137.103) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.35; Mon, 11 Mar 2024 18:18:41 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=MzmFekMWldZLhF65dtS6A6SNMtrERDufPr3R+00WW/3XRCktOuyhguQEPLi8aSkIYZ0FcK6IuVTdiviGkChbkIBEmQRrQy30ldIBbnxbkNL4amXjd6LQ1LIAjDIxq7s38gCwxV026n7/fUW6s2HvxZu0x2TLGldca78LY1O1GKBX2f3gixjeY5ewI69sHQG4bgaZpMR/yji4YNBiP96yqYazn5+k2aph1x7KQaDYMG9olwLNM1VxIkNppleKsmW7TmyU3JibyZIGo2g4oNLcyl69j/7L8UnDW6YsND6ClnocsUchg0HHGnSohTZ4WPS71ovXQ1QwxrpD3PodHVwPQA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=3w6y8MyCt8N+3gQRt6sTfzWJLIFOIlZ/WzBXtkMrMmA=;
 b=VRFWLanm5UIrHB01VK8EFZX5GQEq1+hq0rEac3U9R2j8fgdL5WwGHxGM2wJZEASLT50a1Aaunms3XS3eqDUBcEf3DkZXIvcbgieY+39yYUhm6mItSJQOHLQwOhfbWSXD0rC1/B3uAbXo0be9hiaPat0xqiDoYB1NS1LyBWHKLizp4Sre893n4SKFSng6+nCtfAAV5uZ1avvXCzZZYsNxldiIHwKMGW1yVOSDf6vSG0gUHuZA+a4BatJNCvDowyMVUZaPoNoJr7qWC1BAbmXzv0n+l6ogFb9p3FMqwIHKujGmbDmeyFysTrWSpZErEWj3kanWetbWa9yGhAjCH5BkTw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Received: from CYYPR11MB8432.namprd11.prod.outlook.com (2603:10b6:930:be::8)
 by IA0PR11MB7883.namprd11.prod.outlook.com (2603:10b6:208:3de::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7386.17; Tue, 12 Mar
 2024 01:18:37 +0000
Received: from CYYPR11MB8432.namprd11.prod.outlook.com
 ([fe80::49d9:9666:9cb9:68c7]) by CYYPR11MB8432.namprd11.prod.outlook.com
 ([fe80::49d9:9666:9cb9:68c7%7]) with mapi id 15.20.7386.016; Tue, 12 Mar 2024
 01:18:37 +0000
From: "Zhang, Chen" <chen.zhang@intel.com>
To: Steve Sistare <steven.sistare@oracle.com>, "qemu-devel@nongnu.org"
 <qemu-devel@nongnu.org>
CC: Alex Williamson <alex.williamson@redhat.com>, Cedric Le Goater
 <clg@redhat.com>, "Michael S. Tsirkin" <mst@redhat.com>, David Hildenbrand
 <david@redhat.com>, Peter Xu <peterx@redhat.com>, Fabiano Rosas
 <farosas@suse.de>, "Zhang, Hailiang" <zhanghailiang@xfusion.com>, Li Zhijian
 <lizhijian@fujitsu.com>, Jason Wang <jasowang@redhat.com>, Hyman Huang
 <yong.huang@smartx.com>, Song Gao <gaosong@loongson.cn>, Alistair Francis
 <alistair.francis@wdc.com>
Subject: RE: [PATCH V2 09/11] migration: privatize colo interfaces
Thread-Topic: [PATCH V2 09/11] migration: privatize colo interfaces
Thread-Index: AQHac9yApNy5Pf8OjE2tJkUUm8u2pLEzTiiw
Date: Tue, 12 Mar 2024 01:18:37 +0000
Message-ID: <CYYPR11MB84321C329E050BDD89365F459B2B2@CYYPR11MB8432.namprd11.prod.outlook.com>
References: <1710179338-294359-1-git-send-email-steven.sistare@oracle.com>
 <1710179338-294359-10-git-send-email-steven.sistare@oracle.com>
In-Reply-To: <1710179338-294359-10-git-send-email-steven.sistare@oracle.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: CYYPR11MB8432:EE_|IA0PR11MB7883:EE_
x-ms-office365-filtering-correlation-id: 58b61fa6-3852-4eac-c590-08dc42325831
x-ld-processed: 46c98d88-e344-4ed4-8496-4ed7712e255d,ExtAddr
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: vjCIzrvS3blv5fcqHhQIQgUg7bpPg5NKDTG5oxy0gdIPvSfJB9//EIi2S0M0mVVRCwc2nB1Lwth48CHWsZjvpBdVpzaY/yy13Nk+8EiMhrGzThEKZ6TWvyGlZ9uKKKlh4/TkIMfqkN1aZypbz3uxnlcL/GBcuY+X77CS5oo0/ArLGY2gEPj66lsITndF27Gw2llcV6eXLEKq79guO+R98pIG2CxFcZnmVAVwB5WK/pR+AH+mePFnlkJFbaKpAIYAZ2C5BQ+vLHjpIh53Avwu1OVcojEyxMLVZFfD2ZZatok9Ugr4oZhcXFQoIG+qmL/mgQMwhFVSYMa/P5DK9LzawPfPce/70LgG8KqBbTxYKLmyMm4q/AYRXdS/Q6V+lMu6jdAaAeHV/IdkSoQebflKPORlEPrfrnUct8MvbUrQdjB0x6Hx1lVUQGDM7VCa62R4LwZmogYnwrnRezB5Sad+qA9FOBlev+1wvGmm5GAc6TyhzzfgoBqsHBvQyjV6C+m1Ooh4XM/rzDopX/FMgpnaWTDuxLAeellvGfMqHfFYjPUOoctc+vmJWe9JqcS87otxEm5cMx+frjp+wBzeDE8q3w1tw48FtTbol2HTyvTzXEvs4zT643/cv+DFFon1MuO6IbJ6WHxDm2fVZG7pYp9C5ksc2HqvtiaWhTrIXyAy3r1TTIpeYKMjF5/MLdsYenEMjwEcZBfPe63cIWZsg9Y5bg==
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:CYYPR11MB8432.namprd11.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230031)(376005)(1800799015)(7416005)(38070700009); DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?lNLcP6CxmIlR2f1SWDWd4JtjwFofZ7pNAambQF4zlg246sBcB1mL1cOrkLFG?=
 =?us-ascii?Q?0rpXudW3VZbIvIoDxjGZiT9kjBXMlY4HAIApdxE+c/awTwpTFz0lOY0GTDbV?=
 =?us-ascii?Q?tFQvxrpxCe3Xx04QcE7HXTMBZIMKJiAYQsI2Kuk83Fl9UTCuGMrEM/c3yoY/?=
 =?us-ascii?Q?ZLKDAFD31G6Y/bf4+gLQ+Iij2rF153YvdgyfjFvHOzUs1kv+tjIksKsg5OZy?=
 =?us-ascii?Q?2Cz0bY7e0ByWsWjCOpYWiudcD3qTXAosvIdVLfxbWV0Al6RgG/YbK5EZrKTS?=
 =?us-ascii?Q?3HNoGKfsNeKPEeDCAysUb4CNw9F2LgEackdwPZCSQikCs8CcQ2KPK1fD49wq?=
 =?us-ascii?Q?y3iPUnmnbDwFa29mQdCnpyvUr33uT69MwYK79mX1crPtmpXLEJeAtdMaxPfg?=
 =?us-ascii?Q?6Nx08e94mNrdIJf6CF6+P5/yz0waEr/3D1IRncu5ihy1lb+RQpvkV+58knrG?=
 =?us-ascii?Q?4L/yjbjiCKcOAZw45G6nCNHJh/XRF1195UeZ6PKY77iug8h6El5jxjQYOfMK?=
 =?us-ascii?Q?JceJeh4FYe/KGQkDhvts0On2VstRtlw+IRAkaw1lf0KM276tyKNAdQiyLmxI?=
 =?us-ascii?Q?m79KkDDL8gks0TdS/jwQhxc1QhpnJKS8PLLRdR363928lhdeLuvpvDM37myI?=
 =?us-ascii?Q?ONfYTFtuLOlove8U59G4u4ApdRHXn1GBeAB80WhH7LiefeoBToMHDF4Ny/dX?=
 =?us-ascii?Q?OTT8gV6rJTNd4uzhiC+y0X63TICQRj4DHlsdA1S41Vw2Bzdz5NK+FkOwR+vW?=
 =?us-ascii?Q?7a8joOUJd6bI4u1DHrJGV8D6CuDjGyhpp3YDpxf5eIl8Pfxgh0GZGolXrHGB?=
 =?us-ascii?Q?cLZZfx8b/8kkZL+s5X6Bfd766YFb+oio9h8teNTBT1nIbUZBK0wTn7jg3obg?=
 =?us-ascii?Q?okI/HAaO4u7MJNxysIgItTzGecBtG0XjkpnKAVLBuXL/Yzxa1Ys8gagqiZTe?=
 =?us-ascii?Q?nE5jwRmHtsS0hf696q1Q88cKxLUYp8AWcfO1UY6tNF02trH3plLw/rKIBeSl?=
 =?us-ascii?Q?G4ZxscJHHyXBATBcRtjXqrUc1ACIZBQ3iw85Z41EMHkGtHZ8LJan+vLCTWp2?=
 =?us-ascii?Q?izMWle+xupZjyRlCVBZxzbYpYTrkfKOzLFX4O2Uf7dQHOyU258vXClYJPJmp?=
 =?us-ascii?Q?N5Ud3mnsBJ9D7emfx9j2gRclLsu1CwFi7NMsL4pKMZHx5y1WFd7Mf26dIPBq?=
 =?us-ascii?Q?iwLNeF9RhLdqDPEYHBmUywp3JeTv+t9/WMQwEimnCQOYCuWqenlBt8cn9iFU?=
 =?us-ascii?Q?oC83Ex1FbCiBdNx/NQoR1F0qSJT05FLkk8sSE8J7qKa5r88HTsONH6hvlXnf?=
 =?us-ascii?Q?//kic7SSFNEHP4XQFBtynmPVXaiODzaIh+evBQx3XqU+Lly34woYL6EKMyxm?=
 =?us-ascii?Q?5lVTiqVf301bLo00oKi3woCgbSwgyfNvCE24lmhCwr1nsldtDSjp2f5QAYUb?=
 =?us-ascii?Q?9HYzIG8V88wGbBsR5KzrSfIhTY8gzVj6YDtmdWLO4wgopErcu3cyodC09Qhs?=
 =?us-ascii?Q?W0+dRLmq9aFBfcbqTMqjslxjcOYWiRVTSF+QHdyF8gqmkJITi1il3BNG2834?=
 =?us-ascii?Q?F2QMJcT3U2IdKDH5ASPHOIoOkswpOR5thPqUO6HY?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: CYYPR11MB8432.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 58b61fa6-3852-4eac-c590-08dc42325831
X-MS-Exchange-CrossTenant-originalarrivaltime: 12 Mar 2024 01:18:37.4734 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: QPRtS0AGy/gw0MMWyJhr8yA1hlTwRllKfJfmp/gXGme+Ic5wDE7Lv3TsfB8IixeZMetMVr7hdc0VSquVa3sMYw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA0PR11MB7883
X-OriginatorOrg: intel.com
Received-SPF: pass client-ip=198.175.65.15; envelope-from=chen.zhang@intel.com;
 helo=mgamail.intel.com
X-Spam_score_int: -30
X-Spam_score: -3.1
X-Spam_bar: ---
X-Spam_report: (-3.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-1.029,
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



> -----Original Message-----
> From: Steve Sistare <steven.sistare@oracle.com>
> Sent: Tuesday, March 12, 2024 1:49 AM
> To: qemu-devel@nongnu.org
> Cc: Alex Williamson <alex.williamson@redhat.com>; Cedric Le Goater
> <clg@redhat.com>; Michael S. Tsirkin <mst@redhat.com>; David Hildenbrand
> <david@redhat.com>; Peter Xu <peterx@redhat.com>; Fabiano Rosas
> <farosas@suse.de>; Zhang, Hailiang <zhanghailiang@xfusion.com>; Zhang,
> Chen <chen.zhang@intel.com>; Li Zhijian <lizhijian@fujitsu.com>; Jason Wa=
ng
> <jasowang@redhat.com>; Hyman Huang <yong.huang@smartx.com>; Song
> Gao <gaosong@loongson.cn>; Alistair Francis <alistair.francis@wdc.com>;
> Steve Sistare <steven.sistare@oracle.com>
> Subject: [PATCH V2 09/11] migration: privatize colo interfaces
>=20
> Remove private migration interfaces from net/colo-compare.c and push them
> to migration/colo.c.
>=20
> Signed-off-by: Steve Sistare <steven.sistare@oracle.com>

Reviewed-by: Zhang Chen <chen.zhang@intel.com>

Thanks
Chen

> ---
>  migration/colo.c   | 17 +++++++++++------
>  net/colo-compare.c |  3 +--
>  stubs/colo.c       |  1 -
>  3 files changed, 12 insertions(+), 9 deletions(-)
>=20
> diff --git a/migration/colo.c b/migration/colo.c index 315e31f..84632a6
> 100644
> --- a/migration/colo.c
> +++ b/migration/colo.c
> @@ -63,9 +63,9 @@ static bool colo_runstate_is_stopped(void)
>      return runstate_check(RUN_STATE_COLO) || !runstate_is_running();  }
>=20
> -static void colo_checkpoint_notify(void *opaque)
> +static void colo_checkpoint_notify(void)
>  {
> -    MigrationState *s =3D opaque;
> +    MigrationState *s =3D migrate_get_current();
>      int64_t next_notify_time;
>=20
>      qemu_event_set(&s->colo_checkpoint_event);
> @@ -74,10 +74,15 @@ static void colo_checkpoint_notify(void *opaque)
>      timer_mod(s->colo_delay_timer, next_notify_time);  }
>=20
> +static void colo_checkpoint_notify_timer(void *opaque) {
> +    colo_checkpoint_notify();
> +}
> +
>  void colo_checkpoint_delay_set(void)
>  {
>      if (migration_in_colo_state()) {
> -        colo_checkpoint_notify(migrate_get_current());
> +        colo_checkpoint_notify();
>      }
>  }
>=20
> @@ -162,7 +167,7 @@ static void primary_vm_do_failover(void)
>       * kick COLO thread which might wait at
>       * qemu_sem_wait(&s->colo_checkpoint_sem).
>       */
> -    colo_checkpoint_notify(s);
> +    colo_checkpoint_notify();
>=20
>      /*
>       * Wake up COLO thread which may blocked in recv() or send(), @@ -51=
8,7
> +523,7 @@ out:
>=20
>  static void colo_compare_notify_checkpoint(Notifier *notifier, void *dat=
a)  {
> -    colo_checkpoint_notify(data);
> +    colo_checkpoint_notify();
>  }
>=20
>  static void colo_process_checkpoint(MigrationState *s) @@ -642,7 +647,7
> @@ void migrate_start_colo_process(MigrationState *s)
>      bql_unlock();
>      qemu_event_init(&s->colo_checkpoint_event, false);
>      s->colo_delay_timer =3D  timer_new_ms(QEMU_CLOCK_HOST,
> -                                colo_checkpoint_notify, s);
> +                                colo_checkpoint_notify_timer, NULL);
>=20
>      qemu_sem_init(&s->colo_exit_sem, 0);
>      colo_process_checkpoint(s);
> diff --git a/net/colo-compare.c b/net/colo-compare.c index f2dfc0e..c4ad0=
ab
> 100644
> --- a/net/colo-compare.c
> +++ b/net/colo-compare.c
> @@ -28,7 +28,6 @@
>  #include "sysemu/iothread.h"
>  #include "net/colo-compare.h"
>  #include "migration/colo.h"
> -#include "migration/migration.h"
>  #include "util.h"
>=20
>  #include "block/aio-wait.h"
> @@ -189,7 +188,7 @@ static void
> colo_compare_inconsistency_notify(CompareState *s)
>          notify_remote_frame(s);
>      } else {
>          notifier_list_notify(&colo_compare_notifiers,
> -                             migrate_get_current());
> +                             NULL);
>      }
>  }
>=20
> diff --git a/stubs/colo.c b/stubs/colo.c index 08c9f98..f8c069b 100644
> --- a/stubs/colo.c
> +++ b/stubs/colo.c
> @@ -2,7 +2,6 @@
>  #include "qemu/notify.h"
>  #include "net/colo-compare.h"
>  #include "migration/colo.h"
> -#include "migration/migration.h"
>  #include "qemu/error-report.h"
>  #include "qapi/qapi-commands-migration.h"
>=20
> --
> 1.8.3.1


