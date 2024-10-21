Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id DE242D0E6F4
	for <qemu-devel@archiver.kernel.org>; Mon, 21 Oct 2024 11:49:33 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1t2quJ-0003rq-Vt; Mon, 21 Oct 2024 07:49:08 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <berrange@redhat.com>)
 id 1t2quH-0003rQ-RB
 for qemu-devel@nongnu.org; Mon, 21 Oct 2024 07:49:05 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <berrange@redhat.com>)
 id 1t2quG-0002py-82
 for qemu-devel@nongnu.org; Mon, 21 Oct 2024 07:49:05 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1729511343;
 h=from:from:reply-to:reply-to:subject:subject:date:date:
 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
 content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=q1X6Yh5DXs54D5bShr3oFSYNe6KiDWYyzRqIWIu1Ybw=;
 b=QjTUb1+EGEXC9pej4r5CfVtGjeScqKECSVG6EeGxcawc84M5Qz8Na9Y5joTZwrHcF4cguM
 sNmI2XklYhtdP8GrHhemVwwvj0zzY7gfq1UT6PLLzQzmcXiexjpqYppAIBmofW32+Sf9oB
 KVW7h8rms213tuCUT91w2fXucreLwek=
Received: from mx-prod-mc-05.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-664-2Ftgk_55O4CDLO_PaF56Tg-1; Mon,
 21 Oct 2024 07:49:00 -0400
X-MC-Unique: 2Ftgk_55O4CDLO_PaF56Tg-1
Received: from mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.12])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-05.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id A3BDF1954AFE; Mon, 21 Oct 2024 11:48:57 +0000 (UTC)
Received: from redhat.com (unknown [10.42.28.27])
 by mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 0A56F19560A2; Mon, 21 Oct 2024 11:48:52 +0000 (UTC)
Date: Mon, 21 Oct 2024 12:48:49 +0100
From: Daniel =?utf-8?B?UC4gQmVycmFuZ8Op?= <berrange@redhat.com>
To: Kevin Wolf <kwolf@redhat.com>
Cc: Philippe =?utf-8?Q?Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Aleksandar Rakic <aleksandar.rakic@htecgroup.com>,
 "qemu-devel@nongnu.org" <qemu-devel@nongnu.org>,
 Djordje Todorovic <Djordje.Todorovic@htecgroup.com>,
 "cfu@mips.com" <cfu@mips.com>, "arikalo@gmail.com" <arikalo@gmail.com>,
 "peter.maydell@linaro.org" <peter.maydell@linaro.org>,
 Pierrick Bouvier <pierrick.bouvier@linaro.org>,
 qemu-block <qemu-block@nongnu.org>, Hanna Reitz <hreitz@redhat.com>,
 alex.bennee@linaro.org
Subject: Re: [PATCH v2 6/8] Revert use of clock_gettime for benchmarking
Message-ID: <ZxY_oZVKc4_tm-So@redhat.com>
References: <AM9PR09MB485113D76C5AE02516C08E8E84402@AM9PR09MB4851.eurprd09.prod.outlook.com>
 <5ae0d26e-d969-48e3-9bfd-8a07db727620@linaro.org>
 <ZxY-JRCHAZF-qQiW@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <ZxY-JRCHAZF-qQiW@redhat.com>
User-Agent: Mutt/2.2.12 (2023-09-09)
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.12
Received-SPF: pass client-ip=170.10.133.124; envelope-from=berrange@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -24
X-Spam_score: -2.5
X-Spam_bar: --
X-Spam_report: (-2.5 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.421,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H3=0.001, RCVD_IN_MSPIKE_WL=0.001,
 RCVD_IN_VALIDITY_CERTIFIED_BLOCKED=0.001, RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001 autolearn=unavailable autolearn_force=no
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
Reply-To: Daniel =?utf-8?B?UC4gQmVycmFuZ8Op?= <berrange@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org

On Mon, Oct 21, 2024 at 01:42:29PM +0200, Kevin Wolf wrote:
> Am 19.10.2024 um 21:35 hat Philippe Mathieu-Daudé geschrieben:
> > Hi,
> > 
> > On 18/10/24 10:20, Aleksandar Rakic wrote:
> > > This patch reverts the commit (with SHA
> > > 50290c002c045280f8defad911901e16bfb52884 from
> > > https://github.com/MIPS/gnutools-qemu) that breaks for mingw builds,
> > > where clock_gettime and CLOCK_MONOTONIC are not available.
> 
> What does "not available" mean? I'm sure that we have kept building QEMU
> with mingw in the past five years (the commit you want to revert is from
> 2019), so they must exist in some form?

They exist in the mingw headers

$ grep clock_gettime /usr/i686-w64-mingw32/sys-root/mingw/include/pthread_time.h
int __cdecl WINPTHREAD_API clock_gettime(clockid_t clock_id, struct timespec *tp);

$ grep CLOCK_MONOTONIC /usr/i686-w64-mingw32/sys-root/mingw/include/pthread_time.h
#ifndef CLOCK_MONOTONIC
#define CLOCK_MONOTONIC             1

So I think we need more clarity about what's broken before we can
consider merging this.

> 
> > Isn't get_clock() what we want here?
> > 
> > > Cherry-picked d57c735e1af1ca719dbd0c3a904ad70c9c31cbb7
> > > from https://github.com/MIPS/gnutools-qemu
> > > 
> > > Signed-off-by: Faraz Shahbazker <fshahbazker@wavecomp.com>
> > > Signed-off-by: Aleksandar Rakic <aleksandar.rakic@htecgroup.com>
> > > ---
> > >   qemu-io-cmds.c | 77 +++++++++++++++++++++++++-------------------------
> > >   1 file changed, 39 insertions(+), 38 deletions(-)
> > 
> > Please Cc maintainers (done now):
> > 
> > $ ./scripts/get_maintainer.pl -f qemu-io-cmds.c
> > Kevin Wolf <kwolf@redhat.com> (supporter:Block layer core)
> > Hanna Reitz <hreitz@redhat.com> (supporter:Block layer core)
> 
> Also Alex (CCed) who is the author of the patch you want to revert.
> 
> Kevin
> 
> > > @@ -904,7 +905,7 @@ static const cmdinfo_t readv_cmd = {
> > >   static int readv_f(BlockBackend *blk, int argc, char **argv)
> > >   {
> > > -    struct timespec t1, t2;
> > > +    struct timeval t1, t2;
> > >       bool Cflag = false, qflag = false, vflag = false;
> > >       int c, cnt, ret;
> > >       char *buf;
> > > @@ -964,9 +965,9 @@ static int readv_f(BlockBackend *blk, int argc, char **argv)
> > >           return -EINVAL;
> > >       }
> > > -    clock_gettime(CLOCK_MONOTONIC, &t1);
> > > +    gettimeofday(&t1, NULL);
> > >       ret = do_aio_readv(blk, &qiov, offset, flags, &total);
> > > -    clock_gettime(CLOCK_MONOTONIC, &t2);
> > > +    gettimeofday(&t2, NULL);
> > >       if (ret < 0) {
> > >           printf("readv failed: %s\n", strerror(-ret));
> > 
> 
> 

With regards,
Daniel
-- 
|: https://berrange.com      -o-    https://www.flickr.com/photos/dberrange :|
|: https://libvirt.org         -o-            https://fstop138.berrange.com :|
|: https://entangle-photo.org    -o-    https://www.instagram.com/dberrange :|


