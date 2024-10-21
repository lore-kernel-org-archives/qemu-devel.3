Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id BBCC8D0E6F4
	for <qemu-devel@archiver.kernel.org>; Mon, 21 Oct 2024 11:43:03 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1t2qoL-0007c8-EB; Mon, 21 Oct 2024 07:42:57 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <kwolf@redhat.com>) id 1t2qo8-00074n-1S
 for qemu-devel@nongnu.org; Mon, 21 Oct 2024 07:42:46 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <kwolf@redhat.com>) id 1t2qo6-0002O9-BC
 for qemu-devel@nongnu.org; Mon, 21 Oct 2024 07:42:43 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1729510961;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=iNGMyzjiFGt9fgmqu4qHvlDy1AUtLIDR6d0UlcU7HNA=;
 b=VI/T6LH6/CQYbrtwjPtzQamE5UcXqEV5tfvcUPVgibTaPb6OA1zMUZGTb6tCl4Yd/JtJou
 qCRdBw+Sq6P8v4LDVvAsYPq9W+ySPEpGaU4+C1scPo0RPSpVH6bJfp0gw8B16G60u8ZVxw
 0+V8is3iissFV4URgDyXmLOo69aiHzM=
Received: from mx-prod-mc-05.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-684-1F8shVe3PnyBvrLYbwlcQA-1; Mon,
 21 Oct 2024 07:42:37 -0400
X-MC-Unique: 1F8shVe3PnyBvrLYbwlcQA-1
Received: from mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.4])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-05.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id AFA881956088; Mon, 21 Oct 2024 11:42:35 +0000 (UTC)
Received: from redhat.com (unknown [10.39.194.209])
 by mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 1B321300019D; Mon, 21 Oct 2024 11:42:31 +0000 (UTC)
Date: Mon, 21 Oct 2024 13:42:29 +0200
From: Kevin Wolf <kwolf@redhat.com>
To: Philippe =?iso-8859-1?Q?Mathieu-Daud=E9?= <philmd@linaro.org>
Cc: Aleksandar Rakic <aleksandar.rakic@htecgroup.com>,
 "qemu-devel@nongnu.org" <qemu-devel@nongnu.org>,
 Djordje Todorovic <Djordje.Todorovic@htecgroup.com>,
 "cfu@mips.com" <cfu@mips.com>, "arikalo@gmail.com" <arikalo@gmail.com>,
 "peter.maydell@linaro.org" <peter.maydell@linaro.org>,
 Pierrick Bouvier <pierrick.bouvier@linaro.org>,
 qemu-block <qemu-block@nongnu.org>, Hanna Reitz <hreitz@redhat.com>,
 alex.bennee@linaro.org
Subject: Re: [PATCH v2 6/8] Revert use of clock_gettime for benchmarking
Message-ID: <ZxY-JRCHAZF-qQiW@redhat.com>
References: <AM9PR09MB485113D76C5AE02516C08E8E84402@AM9PR09MB4851.eurprd09.prod.outlook.com>
 <5ae0d26e-d969-48e3-9bfd-8a07db727620@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <5ae0d26e-d969-48e3-9bfd-8a07db727620@linaro.org>
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.4
Received-SPF: pass client-ip=170.10.133.124; envelope-from=kwolf@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -24
X-Spam_score: -2.5
X-Spam_bar: --
X-Spam_report: (-2.5 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.421,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H3=0.001, RCVD_IN_MSPIKE_WL=0.001,
 RCVD_IN_VALIDITY_CERTIFIED_BLOCKED=0.001, RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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

Am 19.10.2024 um 21:35 hat Philippe Mathieu-Daudé geschrieben:
> Hi,
> 
> On 18/10/24 10:20, Aleksandar Rakic wrote:
> > This patch reverts the commit (with SHA
> > 50290c002c045280f8defad911901e16bfb52884 from
> > https://github.com/MIPS/gnutools-qemu) that breaks for mingw builds,
> > where clock_gettime and CLOCK_MONOTONIC are not available.

What does "not available" mean? I'm sure that we have kept building QEMU
with mingw in the past five years (the commit you want to revert is from
2019), so they must exist in some form?

> Isn't get_clock() what we want here?
> 
> > Cherry-picked d57c735e1af1ca719dbd0c3a904ad70c9c31cbb7
> > from https://github.com/MIPS/gnutools-qemu
> > 
> > Signed-off-by: Faraz Shahbazker <fshahbazker@wavecomp.com>
> > Signed-off-by: Aleksandar Rakic <aleksandar.rakic@htecgroup.com>
> > ---
> >   qemu-io-cmds.c | 77 +++++++++++++++++++++++++-------------------------
> >   1 file changed, 39 insertions(+), 38 deletions(-)
> 
> Please Cc maintainers (done now):
> 
> $ ./scripts/get_maintainer.pl -f qemu-io-cmds.c
> Kevin Wolf <kwolf@redhat.com> (supporter:Block layer core)
> Hanna Reitz <hreitz@redhat.com> (supporter:Block layer core)

Also Alex (CCed) who is the author of the patch you want to revert.

Kevin

> > @@ -904,7 +905,7 @@ static const cmdinfo_t readv_cmd = {
> >   static int readv_f(BlockBackend *blk, int argc, char **argv)
> >   {
> > -    struct timespec t1, t2;
> > +    struct timeval t1, t2;
> >       bool Cflag = false, qflag = false, vflag = false;
> >       int c, cnt, ret;
> >       char *buf;
> > @@ -964,9 +965,9 @@ static int readv_f(BlockBackend *blk, int argc, char **argv)
> >           return -EINVAL;
> >       }
> > -    clock_gettime(CLOCK_MONOTONIC, &t1);
> > +    gettimeofday(&t1, NULL);
> >       ret = do_aio_readv(blk, &qiov, offset, flags, &total);
> > -    clock_gettime(CLOCK_MONOTONIC, &t2);
> > +    gettimeofday(&t2, NULL);
> >       if (ret < 0) {
> >           printf("readv failed: %s\n", strerror(-ret));
> 


