Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id CBF04C6FD1F
	for <qemu-devel@archiver.kernel.org>; Fri, 29 Mar 2024 08:55:26 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rq80O-0002S6-Qf; Fri, 29 Mar 2024 04:54:32 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <wei.w.wang@intel.com>)
 id 1rq80M-0002Ri-26
 for qemu-devel@nongnu.org; Fri, 29 Mar 2024 04:54:30 -0400
Received: from mgamail.intel.com ([192.198.163.8])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <wei.w.wang@intel.com>)
 id 1rq80J-0001bA-BB
 for qemu-devel@nongnu.org; Fri, 29 Mar 2024 04:54:29 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1711702467; x=1743238467;
 h=from:to:cc:subject:date:message-id:references:
 in-reply-to:content-transfer-encoding:mime-version;
 bh=7DxA88E0jFOaBFmYPd8edxO2axD1KXp7GDx+6deIByo=;
 b=OfSfSGO6pr/b0nF5s6md37XfI5qqCeEFepjqQjfbCUgapESAGGi7iciq
 6n4Y3+N2GcOGV2cIY+uDXWvq1hRwbdVw0BpRHu4VdYhAZNmiLIs3YnK3i
 HeEIBwKWUjl2J0Gnc22GLXNCpSpsTV+8que0UfeRUwhoZXqPNoOd2ttzH
 AqvXUMnI3KiQAeRjDGoUHuBSZH2Gm0ONpv8JjiekpnlMpaxHhvWTzLL/o
 VoBk/Umccg6Bt4dZZ6yHfnw91LfL3+cMZoGrEEUa1gyWj5bjhEF3nT3vb
 e1vA0+v09TvXyjfBh+zj6ris6waf69IF50izcDuSYheaLJFXBNmx3e3Gq Q==;
X-CSE-ConnectionGUID: SQGs2Bf/QE6fCzYtUqfDaA==
X-CSE-MsgGUID: JY49TgYlRySF546QZI2eog==
X-IronPort-AV: E=McAfee;i="6600,9927,11027"; a="24381253"
X-IronPort-AV: E=Sophos;i="6.07,164,1708416000"; d="scan'208";a="24381253"
Received: from fmviesa001.fm.intel.com ([10.60.135.141])
 by fmvoesa102.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 29 Mar 2024 01:54:10 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.07,164,1708416000"; d="scan'208";a="48127742"
Received: from fmsmsx602.amr.corp.intel.com ([10.18.126.82])
 by fmviesa001.fm.intel.com with ESMTP/TLS/AES256-GCM-SHA384;
 29 Mar 2024 01:54:10 -0700
Received: from fmsmsx611.amr.corp.intel.com (10.18.126.91) by
 fmsmsx602.amr.corp.intel.com (10.18.126.82) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35; Fri, 29 Mar 2024 01:54:10 -0700
Received: from fmsmsx611.amr.corp.intel.com (10.18.126.91) by
 fmsmsx611.amr.corp.intel.com (10.18.126.91) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35; Fri, 29 Mar 2024 01:54:10 -0700
Received: from fmsedg602.ED.cps.intel.com (10.1.192.136) by
 fmsmsx611.amr.corp.intel.com (10.18.126.91) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35 via Frontend Transport; Fri, 29 Mar 2024 01:54:10 -0700
Received: from NAM11-CO1-obe.outbound.protection.outlook.com (104.47.56.168)
 by edgegateway.intel.com (192.55.55.71) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.35; Fri, 29 Mar 2024 01:54:09 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=FHbGN0/X/4RJ2AGB2DQgfgMUqKaTT1UcW9ECx4TzBaoVJc5Gy8u801MKxKYIlC4BA+3xaS7ZKHWwy+w5HMXER3Jer5vJNDi1IQ4G+pJShAfJA3s4D0RePa9kn7Nn9DKcp/rLs1maTgnMNkToka59r48jNTWfRrk/8U96aA4UUDO8HC8Qtg0ZXwe0lzgunR3st5jGqSZnNxmVQRiwwuId2wGzdH7lvCsLtjiGLGJIGDRh8xdhU4Mo0qOVvr7R+nGOc8fmvTRDOUHTjmvPW5vGqrKjECM98/9OVaeU3VA277vfyJBHGaDmFDQ0yXbfmNx2jrip8YHsLfROfJHEmN/bVA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=5Msp8kZXKO8HlQy4hV2pHBy4sRcUv+fZd92UHpDRfR0=;
 b=InaJhlVjvhDIIwQFJahW/DXzgjPA9NwGEv/hYUFADQdlOleOwrdaBZfFaKiVtRRXfhOINKyG+xEpLgvswX0zq9sQ9ab+A1TMyG9TDExv0SD0GkHe3sSunqgZWrsQ8Sp6SVFLYHnQiLq81nkcUpwSMGEkw0BzIaS/HxilvtLrxRus7he5Q+H3lQ/Kyfo15mjxMVgcBh4iEXFBVQc4qr/g3lFqt7XzZbMH8es4yHZjArqcu64Yw/lgUOGdFAap6tWC0MiqSGJGD06+MPrzMJqo/kT4mZosl3ogLNQaS0+dwqAGULOdvGAEbmZfFsgwGdPhoEcqz2iPCyZtB5cyyqiluA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Received: from DS0PR11MB6373.namprd11.prod.outlook.com (2603:10b6:8:cb::20) by
 MW4PR11MB8289.namprd11.prod.outlook.com (2603:10b6:303:1e8::9) with
 Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.7409.24; Fri, 29 Mar 2024 08:54:07 +0000
Received: from DS0PR11MB6373.namprd11.prod.outlook.com
 ([fe80::55de:b95:2c83:7e6c]) by DS0PR11MB6373.namprd11.prod.outlook.com
 ([fe80::55de:b95:2c83:7e6c%7]) with mapi id 15.20.7409.031; Fri, 29 Mar 2024
 08:54:07 +0000
From: "Wang, Wei W" <wei.w.wang@intel.com>
To: "Wang, Lei4" <lei4.wang@intel.com>, "qemu-devel@nongnu.org"
 <qemu-devel@nongnu.org>
CC: "peterx@redhat.com" <peterx@redhat.com>, "farosas@suse.de"
 <farosas@suse.de>
Subject: RE: [PATCH] migration: Yield coroutine when receiving
 MIG_CMD_POSTCOPY_LISTEN
Thread-Topic: [PATCH] migration: Yield coroutine when receiving
 MIG_CMD_POSTCOPY_LISTEN
Thread-Index: AQHagYmyxUL+r+eN+kO1eb/5c5VPirFOUHtQ
Date: Fri, 29 Mar 2024 08:54:07 +0000
Message-ID: <DS0PR11MB6373254218DDBF279B13FD79DC3A2@DS0PR11MB6373.namprd11.prod.outlook.com>
References: <20240329033205.26087-1-lei4.wang@intel.com>
In-Reply-To: <20240329033205.26087-1-lei4.wang@intel.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: DS0PR11MB6373:EE_|MW4PR11MB8289:EE_
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: a2XcApa12MPLWGxRSzE3I0Jl675LdUJxwySIgtzg1eDCSHldRIO/z6C/JzJ+G5ueYSHOTsCv1dZDS9gEPwXxEq0Q9hGQxL66ueMuoep+60Z3RSkXzhvn6lnSgII+XWQDcEnkcQ+2Ibr0LU2juxoqJqEwjC+eVKUnoPyumzI3mmYWRPy5a3DzyiZRx3njw3kDh+DMEW8HlEkRMKVLaHg6G2WkM44sfa85aVP04n02n7i1QzjqIBNbLT8qanCbylLbG2HYdQOx/G7VyAQv0zyiZNQ+byNL7Z6hgxzTEKe8+8oOlE3v7rpYnXPvB6XyS/l/PgGLdvftB2hXjPMz4+IQQ4kIguFFtCBHXQOsIBZ/vc51tRprEoiZ+WjFw3FUQLYrzxWbrWdHeHQrSDBEC08j+DbGH+xKv0QDsF8NNq3tbQsHT1tJCg7WVGGYdautCjB4dyGa3l/s3r3Ncimj9GFyT/e2yJ+jQ0Tr90A4C8G+YYQRQ4PJRuAYOtNfSBkeUqLCiBFRHt9yf8N2DEx9DH+hopLb+5YAxbDIXXTRKkqtF5b1VwvmATMaucmNbkFTMfbSJZfwY5YHeSIJTrAYE0oM/KCSdc92Z4HF//WpKYP/z2f4zVr4co3C0vSWavv3b86D41ptgdFTz1sA4WTeXHN2/R/3Xhg+6ra/ArirT7QLBhw=
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DS0PR11MB6373.namprd11.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230031)(376005)(1800799015)(366007); DIR:OUT; SFP:1102; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?SCCNt6eGf9Jc4Dp+CXK6fIZUP+h+VFVziqETw9ZlGUh7xwQm0ZBqPHwl0ko5?=
 =?us-ascii?Q?b+bGWquTeE590HSNE1VW99mXxhmWGQa+WORXSwV9KMUnQ5gOyHJk/prv0dbR?=
 =?us-ascii?Q?19iDX/mRMxPWL3kvAs4sBAwVX+tjqWFRKY+Szp3CV+booxXNmckzMgLBOM+Y?=
 =?us-ascii?Q?UDQb95BvcJskPQ1gbLjwTtNP2vDCAmoItj2Y+Wdy7SvLoLju43FLjSLg8CU7?=
 =?us-ascii?Q?tRF/IYK33xWv2uHJwdaZ6r+glHRADJ98x1IMBqbs8sm8tVqmPo9KMmozqUWm?=
 =?us-ascii?Q?dIe6HXKBHg0d6FAmg7tGlXm4jCw3rnKuKJJj5PT+YguoVxJDLEtuH0IZml/x?=
 =?us-ascii?Q?lkIctz8kbFwoZ3SK8uCLlZ1fwjaxWcLbNz15oS24BBFXHXhrGKEsZYgfRd7d?=
 =?us-ascii?Q?Seqx+ssgt0zE/ZGDNftzcMfvDsghF4nutH4a57rfQekkhH5giOyhBzKINOVv?=
 =?us-ascii?Q?KNSMQ3ywtEuc+HcRNBh7NKzFohyKHfUvJp/djl/ppCx6+mRmO7paMfsXReu0?=
 =?us-ascii?Q?Y90MuIcbht19J2q/BcT8vR7xCCkYIjQgc+yr/aBOL3UTrDyYJXlbQVK6Al2T?=
 =?us-ascii?Q?qcmceRFTYeQk7lUt8aSH5l66kA42CuRF+Srf3aZSPgxcf1ye4IJSTAPi4gDa?=
 =?us-ascii?Q?cOTsh1SoV8voLB6AReCOBk7JZTUjOlm36W6SV44dojZthIT4En/Lu/ICGm+e?=
 =?us-ascii?Q?X57nnOkp6NiRooTL5zJ4nx+6smF3ASpkUzv674vhSh2gZzhyZwSHDKNJzmez?=
 =?us-ascii?Q?sH25bdx4kddFiDgYBx/SiYwGIFPeGfbDiIdOBUQRZgeFVpp+lX2NQj2+AJXc?=
 =?us-ascii?Q?rtieF2PuyLpCC8Ks5K8ewb6QCCCYozCZG94hf1vZaTZhY+9kxXMUknwiKV/t?=
 =?us-ascii?Q?TeUGXdEMxxqSQW0+R5Zoh/yQ1j3jJC3UQUORP6EEea0iG6sCE7g00n4oFRrf?=
 =?us-ascii?Q?rTy0SAMUrIsjQyQ47SrQBiAW0HL6PpeKeq59QpgO6FKgwCj9mG8sKb8aml9l?=
 =?us-ascii?Q?EYzzLnGXRmMWkHwPzsw5AMBBYxcI76Ug3xW3SaCjyCIN2xiAAcxAxCCYJaiZ?=
 =?us-ascii?Q?CJutotzUl7V+OpQxRD32SG89r7KNdZMTYpC5PIs5rJi119rT+ogfOGnggoux?=
 =?us-ascii?Q?OzlOODEqNuhRmMeA0c2jJ0Ox0QLLtnERnY8RNNAilwnNGDlcX6fIS/+7Qjzb?=
 =?us-ascii?Q?Jon7dOga6k7jo6dzSWN74Fq90lv0IT0zFN/VYQlB2Vh2gDVju0Mj3cyrZom1?=
 =?us-ascii?Q?SD7uyDXgBBGKnyRzKq2VNYtKEn/mKUvz+zoyGtKmGkMzx+p7ZyLUIX09k52w?=
 =?us-ascii?Q?shSeZI3iyvgJJ42pHnAx7InH3dn0z4KdPFmrVmPPjS6PHMotJ0cn+vL8qUVk?=
 =?us-ascii?Q?VqYN6LLiBO8qVkzNWRVT7KQEQvRHAaUNf64kYDrh1yafXiIiWWpjAObCwmeC?=
 =?us-ascii?Q?dkmaMSX61Kz7yNmpXJQBmauQtPz/uhdFOTimi9/+TWRRrgAlDKVGJkxeZKID?=
 =?us-ascii?Q?IOZV4wLE+jPkWXSvR3R+7aNNFSdCcjNPzsuhFlrlJ8cjX7idNUzyh+TwifdM?=
 =?us-ascii?Q?iXiJL2ZLSpiDxVrGdeaIGMxBXI2gZc4K+YpDyxMt?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: DS0PR11MB6373.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 8dce7f15-ebe7-4578-3b03-08dc4fcdcb40
X-MS-Exchange-CrossTenant-originalarrivaltime: 29 Mar 2024 08:54:07.6318 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: L+wzIsYwAsr1qlRmBLmv5UsHt6ZL3tUR77OzOLAJf9liQhEUuMph3WZZlsEdlDS6B0FKZ6v6ToyDAN6nBYq0Nw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MW4PR11MB8289
X-OriginatorOrg: intel.com
Received-SPF: pass client-ip=192.198.163.8; envelope-from=wei.w.wang@intel.com;
 helo=mgamail.intel.com
X-Spam_score_int: -28
X-Spam_score: -2.9
X-Spam_bar: --
X-Spam_report: (-2.9 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.08,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_LOW=-0.7, SPF_HELO_NONE=0.001,
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

On Friday, March 29, 2024 11:32 AM, Wang, Lei4 wrote:
> When using the post-copy preemption feature to perform post-copy live
> migration, the below scenario could lead to a deadlock and the migration =
will
> never finish:
>=20
>  - Source connect() the preemption channel in postcopy_start().
>  - Source and the destination side TCP stack finished the 3-way handshake
>    thus the connection is successful.
>  - The destination side main thread is handling the loading of the bulk R=
AM
>    pages thus it doesn't start to handle the pending connection event in =
the
>    event loop. and doesn't post the semaphore postcopy_qemufile_dst_done =
for
>    the preemption thread.
>  - The source side sends non-iterative device states, such as the virtio
>    states.
>  - The destination main thread starts to receive the virtio states, this
>    process may lead to a page fault (e.g., virtio_load()->vring_avail_idx=
()
>    may trigger a page fault since the avail ring page may not be received
>    yet).
>  - The page request is sent back to the source side. Source sends the pag=
e
>    content to the destination side preemption thread.
>  - Since the event is not arrived and the semaphore
>    postcopy_qemufile_dst_done is not posted, the preemption thread in
>    destination side is blocked, and cannot handle receiving the page.
>  - The QEMU main load thread on the destination side is stuck at the page
>    fault, and cannot yield and handle the connect() event for the
>    preemption channel to unblock the preemption thread.
>  - The postcopy will stuck there forever since this is a deadlock.
>=20
> The key point to reproduce this bug is that the source side is sending pa=
ges at a
> rate faster than the destination handling, otherwise, the qemu_get_be64()=
 in
> ram_load_precopy() will have a chance to yield since at that time there a=
re no
> pending data in the buffer to get. This will make this bug harder to be
> reproduced.
>=20
> Fix this by yielding the load coroutine when receiving
> MIG_CMD_POSTCOPY_LISTEN so the main event loop can handle the
> connection event before loading the non-iterative devices state to avoid =
the
> deadlock condition.
>=20
> Signed-off-by: Lei Wang <lei4.wang@intel.com>

This seems to be a regression issue caused by this commit:
737840e2c6ea (migration: Use the number of transferred bytes directly)

Adding qemu_fflush back to migration_rate_exceeded() or ram_save_iterate
seems to work (might not be a good fix though).

> ---
>  migration/savevm.c | 5 +++++
>  1 file changed, 5 insertions(+)
>=20
> diff --git a/migration/savevm.c b/migration/savevm.c index
> e386c5267f..8fd4dc92f2 100644
> --- a/migration/savevm.c
> +++ b/migration/savevm.c
> @@ -2445,6 +2445,11 @@ static int loadvm_process_command(QEMUFile *f)
>          return loadvm_postcopy_handle_advise(mis, len);
>=20
>      case MIG_CMD_POSTCOPY_LISTEN:
> +        if (migrate_postcopy_preempt() && qemu_in_coroutine()) {
> +            aio_co_schedule(qemu_get_current_aio_context(),
> +                            qemu_coroutine_self());
> +            qemu_coroutine_yield();
> +        }

The above could be moved to loadvm_postcopy_handle_listen().

Another option is to follow the old way (i.e. pre_7_2) to do postcopy_preem=
pt_setup
in migrate_fd_connect. This can save the above overhead of switching to the
main thread during the downtime. Seems Peter's previous patch already solve=
d the
channel disordering issue. Let's see Peter and others' opinions.

>          return loadvm_postcopy_handle_listen(mis);
>=20

>      case MIG_CMD_POSTCOPY_RUN:
> --
> 2.39.3


