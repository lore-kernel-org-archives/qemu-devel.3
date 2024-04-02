Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6D323C6FD1F
	for <qemu-devel@archiver.kernel.org>; Tue,  2 Apr 2024 07:21:06 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rrYRN-00077V-8s; Tue, 02 Apr 2024 03:20:17 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <wei.w.wang@intel.com>)
 id 1rrYRL-00077K-4C
 for qemu-devel@nongnu.org; Tue, 02 Apr 2024 03:20:15 -0400
Received: from mgamail.intel.com ([192.198.163.19])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <wei.w.wang@intel.com>)
 id 1rrYRG-0002Su-DZ
 for qemu-devel@nongnu.org; Tue, 02 Apr 2024 03:20:14 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1712042410; x=1743578410;
 h=from:to:cc:subject:date:message-id:references:
 in-reply-to:content-transfer-encoding:mime-version;
 bh=ZhBQciMzNJ5M9QGImaIRMNyC+WBzLU1JeaP2waqh9Gk=;
 b=VPdppbkNumqt+gy05uoLjSh62cO7GCYk00Tznc+sVgvfIRHECSX5tyfL
 fVMm4WpFmQFar+LPOPKoRMNaZK0SzBFWi8kvmNiKx3bsaov4oc0ccezuh
 EZUESWxoIECpYJ+xTlUsvQhkUmoQnri/Am5/aZymtLX16uPPdG/wyNi1F
 0O9ZDbTpg8zxtx5Pyp3GdfoV+XCeCafB2XiHK5Zfy6XS+ROIqXE3LnM6g
 sT66U2takrW+nCxwy2CLlSeylkx32/HevVbyoSBcmeB+ZiHMoS5JdQRbc
 XtCw5mmoCQD+2zPRt+19Bho4vPcpmL/YQXV/C7mEaf6cJOgb90CdRekST Q==;
X-CSE-ConnectionGUID: PKczMFtiQ1WVvIcHDNVZ/g==
X-CSE-MsgGUID: 1ndEFmpcSmizxmXuI7tvqw==
X-IronPort-AV: E=McAfee;i="6600,9927,11031"; a="7063103"
X-IronPort-AV: E=Sophos;i="6.07,174,1708416000"; 
   d="scan'208";a="7063103"
Received: from fmviesa008.fm.intel.com ([10.60.135.148])
 by fmvoesa113.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 02 Apr 2024 00:20:04 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.07,174,1708416000"; d="scan'208";a="18062084"
Received: from orsmsx602.amr.corp.intel.com ([10.22.229.15])
 by fmviesa008.fm.intel.com with ESMTP/TLS/AES256-GCM-SHA384;
 02 Apr 2024 00:20:04 -0700
Received: from orsmsx610.amr.corp.intel.com (10.22.229.23) by
 ORSMSX602.amr.corp.intel.com (10.22.229.15) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35; Tue, 2 Apr 2024 00:20:03 -0700
Received: from ORSEDG601.ED.cps.intel.com (10.7.248.6) by
 orsmsx610.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35 via Frontend Transport; Tue, 2 Apr 2024 00:20:03 -0700
Received: from NAM11-CO1-obe.outbound.protection.outlook.com (104.47.56.169)
 by edgegateway.intel.com (134.134.137.102) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.35; Tue, 2 Apr 2024 00:20:03 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=i8lMcS/e/feCl9uj6ETZ0Um7+KXtFIxYhxKeQoy/oS+DKodSxuqOA8MDbsvi7XTR0FFeqbMwXLin2tCX9aa+Mn+Ba4y4adh9o0vdItWeI0W2vuVkkmQLkm2JfjC/z94GoKT2/xCNBgsGWedQHimGU76UyMIDTrborJoDGJWKjaP4OLldYDMkMSKnUHV6uBRYBuSa4iwmdrQ2yTngBlUxJTS6fQyx3kEFMj2nDFZWQ6BMcT9PTK628C7cH92ksGviac9Cffiit5yhiENwGdD10bZF+csddQY+Kf/fPfMR/6bzWTnbQxoNs9SV/X6fJNiKwbOzPVt8qbfqA9HOSbgjFg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=uPxptNP5k8S7XWyTNAhn8PBCTr2+NWZhsbUi4rsKbxg=;
 b=JVUfW/ejh1Yo6Pfe0OSksawD9SnzfmjfBeB50ITm4tIw88DpPqgN2mTq5lhAoWTiL0UmwyUYgO8/p5qwy81B2VC89GxeMAc991SmRRXlO5OohFHMGrMUavrzh2p8GOKIJNHjKWLrWrkDjDRPLOnLdQKTyo35HG56Dkt+TH8CubaLYdqHtdfvNPB8g5PZedfJI68ZYP+ZPBUPnMA7VODW2KDKRzFyUOK3FcTGDoBZFAo5GQd4F+6iiJmxv/jnQ8if1Vz6vnbo+jGCl5kWroo8ouRuHSgBPciJxYHNWSJHABEc15QE/yLeWkA4zHqhgnR+fax9FtfxF9cLCDYkDqxt0w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Received: from DS0PR11MB6373.namprd11.prod.outlook.com (2603:10b6:8:cb::20) by
 DM4PR11MB6526.namprd11.prod.outlook.com (2603:10b6:8:8d::15) with
 Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.7452.25; Tue, 2 Apr 2024 07:20:01 +0000
Received: from DS0PR11MB6373.namprd11.prod.outlook.com
 ([fe80::55de:b95:2c83:7e6c]) by DS0PR11MB6373.namprd11.prod.outlook.com
 ([fe80::55de:b95:2c83:7e6c%7]) with mapi id 15.20.7452.019; Tue, 2 Apr 2024
 07:20:01 +0000
From: "Wang, Wei W" <wei.w.wang@intel.com>
To: Peter Xu <peterx@redhat.com>
CC: "Wang, Lei4" <lei4.wang@intel.com>, "qemu-devel@nongnu.org"
 <qemu-devel@nongnu.org>, "farosas@suse.de" <farosas@suse.de>
Subject: RE: [PATCH] migration: Yield coroutine when receiving
 MIG_CMD_POSTCOPY_LISTEN
Thread-Topic: [PATCH] migration: Yield coroutine when receiving
 MIG_CMD_POSTCOPY_LISTEN
Thread-Index: AQHagYmyxUL+r+eN+kO1eb/5c5VPirFOUHtQgAVLeACAALqo4A==
Date: Tue, 2 Apr 2024 07:20:01 +0000
Message-ID: <DS0PR11MB6373B342B3CFF787E3C2A5FFDC3E2@DS0PR11MB6373.namprd11.prod.outlook.com>
References: <20240329033205.26087-1-lei4.wang@intel.com>
 <DS0PR11MB6373254218DDBF279B13FD79DC3A2@DS0PR11MB6373.namprd11.prod.outlook.com>
 <ZgrdIDGe3aNcRu7o@x1n>
In-Reply-To: <ZgrdIDGe3aNcRu7o@x1n>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: DS0PR11MB6373:EE_|DM4PR11MB6526:EE_
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: 9dN9c2+7b1DCxYdbU56swQuGoaXCli0oNahZvws93HLTwTfBFq+nxK3ImD3uSzDdgMw15rjNaT9e+78vpm8s+xkevAVJfk3/gW6CBHF2P7EIMvOgfxCpxnSTMkM/JswqeKD5SxJFO/qraxKn13IP2acVYlDWWKsQNGW96k/13hVjvOJD1anc39Wr5d/yp1pdWocVvYOjA9jetNAIOH4tJJzx5u8St5xWoQ+aBdREDut7UQcl2EMDztUcrNl2WmmvhQCES3cJjCSSY/OVweFSk34xTPBu40jXsHQes99TkeJoDmDCGTRkueWjW5Xs1WWyBbW7ZcNgMeJULveNFH1W4/vaM101iEQg7YXEbd/oNQ8RDX4lYcPj2Kzao/YOYUxmT2VzH+L0cnKczp/He2U2y7dljaJ85Un7Uirg7ZksbOAfx0QzmnGHOe6X3YWt/G912xMPzzHAYRLrzBjdcfb0iVtBEZm76PQw5xc0gacCLhNqRYTBxtQBJDjGbt8CS+R9UCtAsJ4djDieZBzMqTu48Gr/df7iSPjz+RZGVQXnvZUrCwD02AjlaIPv2DYmeVfCMJHGP2Gv6rkL5KMx4QL6BgzYnl4yIl6hVvITkEtbjN8=
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DS0PR11MB6373.namprd11.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230031)(366007)(1800799015)(376005); DIR:OUT; SFP:1102; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?QAlDFkR3Af7EkdlipfCHSPyY7yXCiDKMNiQIaeSCn4stuBMKYMVpFa2Gjz/y?=
 =?us-ascii?Q?FaIkxnPImDuFS+caD1edR9NNVyVxqGY1f0F9KO5aTOQnFD/LhzvKDBNfm/PZ?=
 =?us-ascii?Q?NFdg9YEG5qCmPiA0US10m5SqyzFknVrlUAOoGIZwsNpubyhnUy5h27ftUcNr?=
 =?us-ascii?Q?B51QYC9aR/OCsdB1KxvmBPa0tbShN6TQMck6iqYbcVp/N57/BevTzKU5DAYy?=
 =?us-ascii?Q?JjvBJAMJnpQ0m3Zbhpn7tMRO96NNA/t3sqcNyUevIuR1D5okh/KGxjhu1Il5?=
 =?us-ascii?Q?CfoKNCQLtvRFFeV7wUNnfUcvQ4o9GR4Eskx0E3Mtmp0mEO5UaOcTL1WFQhdA?=
 =?us-ascii?Q?uO0S3f6+dXReVKMEPXpf79tQjzm7py5uLX/wBaBhDE1qShb/4IOFKmOv6EW9?=
 =?us-ascii?Q?ZYpLb/tzrRD9BTOVCxS1s5L3HEOlmnd7QuP10j+PHViy6scJtO3CeiEF1ZkQ?=
 =?us-ascii?Q?wTem1DP7Py+/WwlggF9QEsHIzPbdS8x+wDun7dYtVwBKKm4aqHSWbS+M3a5B?=
 =?us-ascii?Q?CraKvn/gmnefIeXuL8wA8NQVNw74AMw5+JFklc3FoSTjyegVpLo7asWVzg4o?=
 =?us-ascii?Q?ki0eXBHu9eqEAt700PY3hfvZySW/nGzsJJCg6KmR5wJc4PJEfCTVe1E7xkfU?=
 =?us-ascii?Q?PShLK4c6QMOL90EGG/y6XdsqIYk5FHzcflG58Co8PqrivGLrtbUrwncSvNfQ?=
 =?us-ascii?Q?WxhBqkcutRpj19P3LgNhNNIXHipBrznj5XApLGVJF1OAQgccTDRlasKN9w+c?=
 =?us-ascii?Q?oGfxCNA3y1cjKCxXh3mGY0B/FXusJbphed8nmrDfiasoL267aXqoOapSEcsb?=
 =?us-ascii?Q?JDzd179j4NvHuVkDk3+C2myjlQ3XB+kllFY/ZduuZhKDUQkM7W+m11B9jEJF?=
 =?us-ascii?Q?B0KeBeQy+F/NMZnQiUG39YE15xcCURUnQ+mrdPMZGpoQFmPjx3ocq7gqAAIQ?=
 =?us-ascii?Q?8rb+xCz4SUOgl0//WXR8yB0jWgGpcoQbDCednSy1JZwPEIo9as8DNLKqv2eH?=
 =?us-ascii?Q?B81YovVeFa/9aPdtF7oM+F/Dt2dHPZuDwi9fo07jbCVYPs16exoJ3IfVB0xM?=
 =?us-ascii?Q?PbYPWVx+2yw0J4KtUEKs1eBytL+lUVka9ExBbVoqSq1d9ORcDJy07QRo7cHn?=
 =?us-ascii?Q?jP+FR/eGCoOibc4rj63FwRGKgCjs77IyCWW4pbNbPM9UeybGghKzm8KLNahj?=
 =?us-ascii?Q?pQFdhrmNLaOq02gEmkYTc5eRfCi2yAEoxANPFdr45BKeL6Gypjqvev/sCkCM?=
 =?us-ascii?Q?shBji1hoxJa68/rvjxABL8UTvrGs1gKoKnacaCNQv2TLlLncxMW3QS/TVnGc?=
 =?us-ascii?Q?v6w5pWR/QW3jY6iVbd5mBpUtmq+G/RrvYGXy33l+kFLBSSUZE6MCdTcO/PNe?=
 =?us-ascii?Q?gawVQywFop6lbfyUUOdK6d+lDb+IWWmO7ohd850Xns3XBTmWOem2rWB9hUIF?=
 =?us-ascii?Q?+KXpas0NfAyztYzkfT58KO4oEeb26XprUeOaf6DCCkagbSjt7FXsGTYmdrnl?=
 =?us-ascii?Q?Sk0L3h9bFASZkyuvdT8R0LrNZBXik459XftIs+U84AKTuVpFiUHgqDDSDBPS?=
 =?us-ascii?Q?1uKhyALyj8bkoTbv/3031pOdD6Zx1Jl7lE0yyMV7?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: DS0PR11MB6373.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 28b5307d-d445-4815-76ff-08dc52e54f71
X-MS-Exchange-CrossTenant-originalarrivaltime: 02 Apr 2024 07:20:01.3243 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: G14cxQvXC1CPkF/ziU5oeUqghO4d4wgq0eKD02TL8moocaDsmJqwUHx9JGzskt+yqHk4Ao0RGW6gRaNlB0PYiQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM4PR11MB6526
X-OriginatorOrg: intel.com
Received-SPF: pass client-ip=192.198.163.19; envelope-from=wei.w.wang@intel.com;
 helo=mgamail.intel.com
X-Spam_score_int: -27
X-Spam_score: -2.8
X-Spam_bar: --
X-Spam_report: (-2.8 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
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

On Tuesday, April 2, 2024 12:13 AM, Peter Xu wrote:
> On Fri, Mar 29, 2024 at 08:54:07AM +0000, Wang, Wei W wrote:
> > On Friday, March 29, 2024 11:32 AM, Wang, Lei4 wrote:
> > > When using the post-copy preemption feature to perform post-copy
> > > live migration, the below scenario could lead to a deadlock and the
> > > migration will never finish:
> > >
> > >  - Source connect() the preemption channel in postcopy_start().
> > >  - Source and the destination side TCP stack finished the 3-way hands=
hake
> > >    thus the connection is successful.
> > >  - The destination side main thread is handling the loading of the bu=
lk RAM
> > >    pages thus it doesn't start to handle the pending connection event=
 in the
> > >    event loop. and doesn't post the semaphore
> postcopy_qemufile_dst_done for
> > >    the preemption thread.
> > >  - The source side sends non-iterative device states, such as the vir=
tio
> > >    states.
> > >  - The destination main thread starts to receive the virtio states, t=
his
> > >    process may lead to a page fault (e.g., virtio_load()->vring_avail=
_idx()
> > >    may trigger a page fault since the avail ring page may not be rece=
ived
> > >    yet).
>=20
> Ouch.  Yeah I think this part got overlooked when working on the preempt
> channel.
>=20
> > >  - The page request is sent back to the source side. Source sends the=
 page
> > >    content to the destination side preemption thread.
> > >  - Since the event is not arrived and the semaphore
> > >    postcopy_qemufile_dst_done is not posted, the preemption thread in
> > >    destination side is blocked, and cannot handle receiving the page.
> > >  - The QEMU main load thread on the destination side is stuck at the =
page
> > >    fault, and cannot yield and handle the connect() event for the
> > >    preemption channel to unblock the preemption thread.
> > >  - The postcopy will stuck there forever since this is a deadlock.
> > >
> > > The key point to reproduce this bug is that the source side is
> > > sending pages at a rate faster than the destination handling,
> > > otherwise, the qemu_get_be64() in
> > > ram_load_precopy() will have a chance to yield since at that time
> > > there are no pending data in the buffer to get. This will make this
> > > bug harder to be reproduced.
>=20
> How hard would this reproduce?

It seems 100% reproducible on my machine (with migration src and dst
on the same physical machine).

>=20
> I'm thinking whether this should be 9.0 material or 9.1.  It's pretty lat=
e for 9.0
> though, but we can still discuss.
>=20
> > >
> > > Fix this by yielding the load coroutine when receiving
> > > MIG_CMD_POSTCOPY_LISTEN so the main event loop can handle the
> > > connection event before loading the non-iterative devices state to
> > > avoid the deadlock condition.
> > >
> > > Signed-off-by: Lei Wang <lei4.wang@intel.com>
> >
> > This seems to be a regression issue caused by this commit:
> > 737840e2c6ea (migration: Use the number of transferred bytes directly)
> >
> > Adding qemu_fflush back to migration_rate_exceeded() or
> > ram_save_iterate seems to work (might not be a good fix though).
> >
> > > ---
> > >  migration/savevm.c | 5 +++++
> > >  1 file changed, 5 insertions(+)
> > >
> > > diff --git a/migration/savevm.c b/migration/savevm.c index
> > > e386c5267f..8fd4dc92f2 100644
> > > --- a/migration/savevm.c
> > > +++ b/migration/savevm.c
> > > @@ -2445,6 +2445,11 @@ static int loadvm_process_command(QEMUFile
> *f)
> > >          return loadvm_postcopy_handle_advise(mis, len);
> > >
> > >      case MIG_CMD_POSTCOPY_LISTEN:
> > > +        if (migrate_postcopy_preempt() && qemu_in_coroutine()) {
> > > +            aio_co_schedule(qemu_get_current_aio_context(),
> > > +                            qemu_coroutine_self());
> > > +            qemu_coroutine_yield();
> > > +        }
> >
> > The above could be moved to loadvm_postcopy_handle_listen().
>=20
> I'm not 100% sure such thing (no matter here or moved into it, which does=
 look
> cleaner) would work for us.
>=20
> The problem is I still don't yet see an ordering restricted on top of (1)
> accept() happens, and (2) receive LISTEN cmd here.  What happens if the
> accept() request is not yet received when reaching LISTEN?  Or is it alwa=
ys
> guaranteed the accept(fd) will always be polled here?
>=20
> For example, the source QEMU (no matter pre-7.2 or later) will always set=
up
> the preempt channel asynchrounously, then IIUC it can connect() after sen=
ding
> the whole chunk of packed data which should include this LISTEN.  I think=
 it
> means it's not guaranteed this will 100% work, but maybe further reduce t=
he
> possibility of the race.

When handling LISTEN, it seems guaranteed that connect() on the source has
returned (synchronized by postcopy_qemufile_src_sem) , but destination side
accept() might not be invoked yet (src connect() and dest accept() are asyn=
c).

For this approach, we would need to improve the fix with a loop to check if
accept() has been called to establish the new channel (yield if not):

if (migrate_postcopy_preempt() && qemu_in_coroutine()) {
    while (!mis->postcopy_qemufile_dst) {
        aio_co_schedule(qemu_get_current_aio_context(),
                                       qemu_coroutine_self());
        qemu_coroutine_yield();
    }
}

>=20
> One right fix that I can think of is moving the sem_wait(&done) into the =
main
> thread too, so we wait for the sem _before_ reading the packed data, so
> there's no chance of fault.  However I don't think sem_wait() will be sma=
rt
> enough to yield when in a coroutine..  In the long term run I think we sh=
ould
> really make migration loadvm to do work in the thread rather than the mai=
n
> thread.  I think it means we have one more example to be listed in this t=
odo so
> that's preferred..
>=20
> https://wiki.qemu.org/ToDo/LiveMigration#Create_a_thread_for_migration_
> destination
>=20
> I attached such draft patch below, but I'm not sure it'll work.  Let me k=
now how
> both of you think about it.
>=20
> >
> > Another option is to follow the old way (i.e. pre_7_2) to do
> > postcopy_preempt_setup in migrate_fd_connect. This can save the above
> > overhead of switching to the main thread during the downtime. Seems
> > Peter's previous patch already solved the channel disordering issue. Le=
t's see
> Peter and others' opinions.
>=20
> IIUC we still need that pre_7_2 stuff and keep the postponed connect() to
> make sure the ordering is done properly.  Wei, could you elaborate the pa=
tch
> you mentioned?  Maybe I missed some spots.

Sure. I saw your patch (5655aab079) ensures that the preempt channel to be
created when PONG is received from the destination, which indicates that
the main channel has been ready on the destination side.

Why was it decided to postpone the preempt channel's connect() for newer QE=
MU
only? The old QEMU (before 7.2) still performs preempt channel connect() in
migrate_fd_connect(), doesn't it have the disordering issue?

>=20
> You raised a good point that this may introduce higher downtime.  Did you=
 or
> Lei tried to measure how large it is?  If that is too high, we may need t=
o think
> another solution, e.g., wait the channel connection before vm stop happen=
s.
>=20
> Thanks,
>=20
> >
> > >          return loadvm_postcopy_handle_listen(mis);
> > >
> >
> > >      case MIG_CMD_POSTCOPY_RUN:
> > > --
> > > 2.39.3
> >
>=20
> =3D=3D=3D8<=3D=3D=3D
> diff --git a/migration/migration.c b/migration/migration.c index
> 696762bc64..bacd1328cf 100644
> --- a/migration/migration.c
> +++ b/migration/migration.c
> @@ -2593,6 +2593,12 @@ static int postcopy_start(MigrationState *ms, Erro=
r
> **errp)
>      /*
>       * Make sure the receiver can get incoming pages before we send the =
rest
>       * of the state
> +     *
> +     * When preempt mode enabled, this must be done after we initiate th=
e
> +     * preempt channel, as destination QEMU will wait for the channel wh=
en
> +     * processing the LISTEN request.  Currently it may not matter a hug=
e
> +     * deal if we always create the channel asynchrously with a qio task=
,
> +     * but we need to keep this in mind.
>       */
>      qemu_savevm_send_postcopy_listen(fb);
>=20
> diff --git a/migration/postcopy-ram.c b/migration/postcopy-ram.c index
> eccff499cb..4f26a89ac9 100644
> --- a/migration/postcopy-ram.c
> +++ b/migration/postcopy-ram.c
> @@ -1254,6 +1254,26 @@ int
> postcopy_ram_incoming_setup(MigrationIncomingState *mis)
>      }
>=20
>      if (migrate_postcopy_preempt()) {
> +        /*
> +         * The preempt channel is established in asynchronous way.  Wait
> +         * for its completion.
> +         */
> +        while (!qemu_sem_timedwait(&mis->postcopy_qemufile_dst_done, 100=
))

Why blocking the main thread on the semaphore for some amount of time?
I think we need to yield to the main thread as soon as possible (the accept=
() would be
right there waiting for a dispatch). Maybe replace the sem with
mis->postcopy_qemufile_dst?

> {
> +            /*
> +             * Note that to make sure the main thread can still schedule=
 an
> +             * accept() request we need to proactively yield for the mai=
n
> +             * loop to run for some duration (100ms in this case), which=
 is
> +             * pretty ugly.
> +             *
> +             * TODO: we should do this in a separate thread to load the =
VM
> +             * rather than in the main thread, just like the source side=
.
> +             */
> +            if (qemu_in_coroutine()) {
> +                aio_co_schedule(qemu_get_current_aio_context(),
> +                                qemu_coroutine_self());
> +                qemu_coroutine_yield();
> +            }
> +        }
>          /*
>           * This thread needs to be created after the temp pages because
>           * it'll fetch RAM_CHANNEL_POSTCOPY PostcopyTmpPage immediately.
> @@ -1743,12 +1763,6 @@ void *postcopy_preempt_thread(void *opaque)
>=20
>      qemu_sem_post(&mis->thread_sync_sem);
>=20
> -    /*
> -     * The preempt channel is established in asynchronous way.  Wait
> -     * for its completion.
> -     */
> -    qemu_sem_wait(&mis->postcopy_qemufile_dst_done);
> -
>      /* Sending RAM_SAVE_FLAG_EOS to terminate this thread */
>      qemu_mutex_lock(&mis->postcopy_prio_thread_mutex);
>      while (preempt_thread_should_run(mis)) {
> --
> 2.44.0
>=20
>=20
> --
> Peter Xu


