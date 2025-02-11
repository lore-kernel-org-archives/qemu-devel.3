Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7E6F7C0219B
	for <qemu-devel@archiver.kernel.org>; Tue, 11 Feb 2025 15:44:33 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1thsQo-0001AJ-M9; Tue, 11 Feb 2025 10:44:14 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <qemu_oss@crudebyte.com>)
 id 1thsQl-00019t-ST
 for qemu-devel@nongnu.org; Tue, 11 Feb 2025 10:44:13 -0500
Received: from kylie.crudebyte.com ([5.189.157.229])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <qemu_oss@crudebyte.com>)
 id 1thsQi-00078e-KS
 for qemu-devel@nongnu.org; Tue, 11 Feb 2025 10:44:10 -0500
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=crudebyte.com; s=kylie; h=Content-Type:Content-Transfer-Encoding:
 MIME-Version:References:In-Reply-To:Message-ID:Date:Subject:Cc:To:From:
 Content-ID:Content-Description;
 bh=yexbiBUZPRfhmCjJk4Qcv0Nj0VhowSDHVLhqFibhOgE=; b=m25yhikmiFa2QB7xTPolIzqI2H
 CQxnVk6moD3o9gs88VV9KfjMC2i89dWhTaZ/Y78+q08bKtJrmsbKEWPD3DDfgCYy77oiU2KFUQzRi
 2ofkfCtg2RiimYn64gW/FWXWybTKv9B0t6jXBlE2WXnUvLqhl669CkuEwQvLa3snaeus6Cbuz+3TP
 tqWVrVRgPtH5CQ9n7Nanm3PVRaqMbry6iUmVq5JpqBKBKbNLhPvKRq05f4VcEpesJOmSdf1M7g+UL
 zE+Dk9+bz0a/epziCpL6wR59CamXxq8AcDQ4eKiRJwAWVJ8sU2Dfjks06tDILqriEdTTjKR+7gW8y
 p2zVJ6W6BVV1tRR6siZ/NeaLz6qq3zaM9zmWifI01nXDiNQeat2OPb5cSzRcJpNPLjnqRyuK98C91
 bDjMrDT+D4KuzwpnLgZutDofbhpXrKtJO3mTibK7RPv2YjrAGiWgKoHsEUrhAOiNiShDPlbMQQpnB
 VqGFwd4gOESqncLZQH5RkxFg5XhdZ4ucCSSvfh0WvbmlYcgwJSxqTcZ3jQ9rsDTHrHqWaILRale9e
 iexPpoJg4njXAvg7xP1Humbx7XzgikkP+jfJLVPJIdmz2lP2W7Syz5UCX6t2C1zNlVdJyeBeg7t3U
 D9maAo2M4TQrTYZuTM5Mf7//acJng/iDNTE3vT5zs=;
From: Christian Schoenebeck <qemu_oss@crudebyte.com>
To: qemu-devel@nongnu.org, Greg Kurz <groug@kaod.org>
Cc: Peter Maydell <peter.maydell@linaro.org>
Subject: Re: [PATCH] 9pfs: fix dead code in qemu_open_flags_tostr()
Date: Tue, 11 Feb 2025 16:44:04 +0100
Message-ID: <1767250.U33mVTmrZ7@silver>
In-Reply-To: <CAFEAcA-Gh18aqaOtw5aj2KVn75c+gVHWUUoFVRzcffc7DGKqQw@mail.gmail.com>
References: <E1thUwq-0020ux-5f@kylie.crudebyte.com>
 <CAFEAcA-Gh18aqaOtw5aj2KVn75c+gVHWUUoFVRzcffc7DGKqQw@mail.gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 7Bit
Content-Type: text/plain; charset="us-ascii"
Received-SPF: pass client-ip=5.189.157.229;
 envelope-from=qemu_oss@crudebyte.com; helo=kylie.crudebyte.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001, RCVD_IN_VALIDITY_SAFE_BLOCKED=0.001,
 SPF_HELO_PASS=-0.001, SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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

On Tuesday, February 11, 2025 3:47:33 PM CET Peter Maydell wrote:
> On Mon, 10 Feb 2025 at 14:40, Christian Schoenebeck
> <qemu_oss@crudebyte.com> wrote:
> >
> > Coverity scan complained about expression "|LARGEFILE" to be non reachable
> > and the detailed Coverity report claims O_LARGEFILE was zero. I can't
> > reproduce this here, but I assume that means there are at least some
> > system(s) which define O_LARGEFILE as zero.
> >
> > This is not really an issue, but to silence this Coverity warning, add a
> > preprocessor wrapper that checks for O_LARGEFILE being non-zero for this
> > overall expression. The 'defined(O_LARGEFILE)' check is not necessary,
> > but it makes it more clear that we really want to check for the value of
> > O_LARGEFILE, not just whether the macro was defined.
> >
> > Fixes: 9a0dd4b3
> > Resolves: Coverity CID 1591178
> > Reported-by: Coverity Scan
> > Signed-off-by: Christian Schoenebeck <qemu_oss@crudebyte.com>
> > ---
> >  hw/9pfs/9p-util-generic.c | 2 ++
> >  1 file changed, 2 insertions(+)
> >
> > diff --git a/hw/9pfs/9p-util-generic.c b/hw/9pfs/9p-util-generic.c
> > index 4c1e9c887d..02e359f17b 100644
> > --- a/hw/9pfs/9p-util-generic.c
> > +++ b/hw/9pfs/9p-util-generic.c
> > @@ -19,7 +19,9 @@ char *qemu_open_flags_tostr(int flags)
> >          #ifdef O_DIRECT
> >          (flags & O_DIRECT) ? "|DIRECT" : "",
> >          #endif
> > +        #if defined(O_LARGEFILE) && O_LARGEFILE != 0
> >          (flags & O_LARGEFILE) ? "|LARGEFILE" : "",
> > +        #endif
> >          (flags & O_DIRECTORY) ? "|DIRECTORY" : "",
> >          (flags & O_NOFOLLOW) ? "|NOFOLLOW" : "",
> >          #ifdef O_NOATIME
> 
> I don't think we need to make this change -- the code is
> correct, and osdep.h defines O_LARGEFILE if the system doesn't,
> exactly so that we don't need to put in extra ifdefs in the
> code itself. Coverity often fails to understand that some
> code is not dead in a different configuration or host OS
> than the one that got scanned. I've marked the issue as
> a false-positive in the Coverity UI.

Fine with me, thanks!

/Christian



