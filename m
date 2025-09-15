Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E931FCAC592
	for <qemu-devel@archiver.kernel.org>; Mon, 15 Sep 2025 13:19:53 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uy96S-0007wi-1R; Mon, 15 Sep 2025 09:18:44 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <kwolf@redhat.com>) id 1uy96K-0007w6-U8
 for qemu-devel@nongnu.org; Mon, 15 Sep 2025 09:18:38 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <kwolf@redhat.com>) id 1uy969-0006QP-Ur
 for qemu-devel@nongnu.org; Mon, 15 Sep 2025 09:18:36 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1757942298;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=cxDpM3oOshrkkfAL4w7nNaLQXDDb34A2zn6jblc5LU8=;
 b=VmBxjbUf968UF0q2MSax3QHWP/HRlXIHRUl+muqtb5jZqvJF4tdsiz1lC2+njKrcH1ZeIH
 ELvzpL0mvWFZJNLyYbmO4M/XCGvZQYC2RnC+uLe/On2296wRxpQnfg7Bj/45s2vTUJmvyf
 G0PA5eM3tF5HFEnlX6QmAB/aQwdbAnI=
Received: from mx-prod-mc-02.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-303-kF-GgS1uMiyfXkyvVvlzDA-1; Mon,
 15 Sep 2025 09:18:14 -0400
X-MC-Unique: kF-GgS1uMiyfXkyvVvlzDA-1
X-Mimecast-MFC-AGG-ID: kF-GgS1uMiyfXkyvVvlzDA_1757942293
Received: from mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.93])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-02.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 56035195608E; Mon, 15 Sep 2025 13:18:13 +0000 (UTC)
Received: from redhat.com (unknown [10.44.33.139])
 by mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 047BE18003FC; Mon, 15 Sep 2025 13:18:10 +0000 (UTC)
Date: Mon, 15 Sep 2025 15:18:00 +0200
From: Kevin Wolf <kwolf@redhat.com>
To: Daniel =?iso-8859-1?Q?P=2E_Berrang=E9?= <berrange@redhat.com>
Cc: Yong Huang <yong.huang@smartx.com>, Thomas Huth <thuth@redhat.com>,
 QEMU Developers <qemu-devel@nongnu.org>, hreitz@redhat.com,
 Maxim Levitsky <mlevitsk@redhat.com>, armbru@redhat.com
Subject: Re: Some iotests are failing with -luks
Message-ID: <aMgSCKrnbAcJAwId@redhat.com>
References: <425ef990-85cb-4c02-bb41-2f88f939d147@redhat.com>
 <aMGijXg9XIpbbn-v@redhat.com> <aMHFrDEW8cbnXajG@redhat.com>
 <CAK9dgmYY-193Nom=DteAp2mDCNCMdA-fUMi8PH5iAoVVZ59cKQ@mail.gmail.com>
 <aMKeqBDvzEM0682l@redhat.com> <aMKmvQ1IyBzK93lD@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <aMKmvQ1IyBzK93lD@redhat.com>
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.93
Received-SPF: pass client-ip=170.10.129.124; envelope-from=kwolf@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.035,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H5=0.001, RCVD_IN_MSPIKE_WL=0.001,
 RCVD_IN_VALIDITY_CERTIFIED_BLOCKED=0.001, RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001,
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

Am 11.09.2025 um 12:38 hat Daniel P. Berrangé geschrieben:
> On Thu, Sep 11, 2025 at 12:04:24PM +0200, Kevin Wolf wrote:
> > Am 11.09.2025 um 04:33 hat Yong Huang geschrieben:
> > > On Thu, Sep 11, 2025 at 2:38 AM Kevin Wolf <kwolf@redhat.com> wrote:
> > > 
> > > > Am 10.09.2025 um 18:08 hat Kevin Wolf geschrieben:
> > > > > Am 10.09.2025 um 17:16 hat Thomas Huth geschrieben:
> > > > > > luks-detached-header   fail       [17:15:26] [17:15:38]   12.2s
> > > >         failed, exit status 1
> > > > > > ---
> > > > /home/thuth/devel/qemu/tests/qemu-iotests/tests/luks-detached-header.out
> > > > > > +++
> > > > /home/thuth/tmp/qemu-build/tests/qemu-iotests/scratch/luks-file-luks-detached-header/luks-detached-header.out.bad
> > > > > > @@ -1,5 +1,55 @@
> > > > > > -..
> > > > > > +EE
> > > > > > +======================================================================
> > > > > > +ERROR: test_detached_luks_header
> > > > (__main__.TestDetachedLUKSHeader.test_detached_luks_header)
> > > > > > +----------------------------------------------------------------------
> > > > > > +Traceback (most recent call last):
> > > > > > +  File
> > > > "/home/thuth/devel/qemu/tests/qemu-iotests/tests/luks-detached-header",
> > > > line 139, in setUp
> > > > > > +    res = qemu_img_create(
> > > > > > +          ^^^^^^^^^^^^^^^^
> > > > > > +  File "/home/thuth/devel/qemu/tests/qemu-iotests/iotests.py", line
> > > > 278, in qemu_img_create
> > > > > > +    return qemu_img('create', *args)
> > > > > > +           ^^^^^^^^^^^^^^^^^^^^^^^^^
> > > > > > +  File "/home/thuth/devel/qemu/tests/qemu-iotests/iotests.py", line
> > > > 261, in qemu_img
> > > > > > +    return qemu_tool(*full_args, check=check,
> > > > combine_stdio=combine_stdio)
> > > > > > +
> > > >  ^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^
> > > > > > +  File "/home/thuth/devel/qemu/tests/qemu-iotests/iotests.py", line
> > > > 241, in qemu_tool
> > > > > > +    raise VerboseProcessError(
> > > > > > +qemu.utils.VerboseProcessError: Command
> > > > '('/home/thuth/tmp/qemu-build/qemu-img', 'create', '-f', 'luks', '-o',
> > > > 'iter-time=10', '-o', 'key-secret=sec0', '-o', 'detached-header=true',
> > > > '--object', 'secret,id=sec0,data=foo',
> > > > '/home/thuth/tmp/qemu-build/tests/qemu-iotests/scratch/luks-file-luks-detached-header/detached_header.img2')'
> > > > returned non-zero exit status 1.
> > > > > > +  ┏━ output
> > > > ━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━
> > > > > > +  ┃ Formatting
> > > > '/home/thuth/tmp/qemu-build/tests/qemu-iotests/scratch/l
> > > > > > +  ┃ uks-file-luks-detached-header/detached_header.img2', fmt=luks
> > > > > > +  ┃ size=-1 key-secret=sec0 iter-time=10 detached-header=true
> > > > > > +  ┃ qemu-img:
> > > > /home/thuth/tmp/qemu-build/tests/qemu-iotests/scratch/luk
> > > > > > +  ┃ s-file-luks-detached-header/detached_header.img2: Parameter
> > > > > > +  ┃ 'detached-header' is unexpected
> > > > > > +
> > > > ┗━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━
> > > > >
> > > > > This one is surprising. I don't think anything relevant in the luks
> > > > > driver has changed since the test was introduced. At the same time, the
> > > > > code clearly has a problem when it tries to convert a QemuOpts
> > > > > containing a "detached-header" option into a QAPI object when the schema
> > > > > doesn't even have this option. Was this broken from the beginning? Would
> > > > > have been for a year and half.
> > > >
> > > > I bisected this one because I was curious how this could happen, and it
> > > > was broken quite explicitly by commit e818c01a:
> > > >
> > > > commit e818c01ae6e7c54c7019baaf307be59d99ce80b9 (HEAD)
> > > > Author: Daniel P. Berrangé <berrange@redhat.com>
> > > > Date:   Mon Feb 19 15:12:59 2024 +0000
> > > >
> > > >     qapi: drop unused QCryptoBlockCreateOptionsLUKS.detached-header
> > > >
> > > >     The 'detached-header' field in QCryptoBlockCreateOptionsLUKS
> > > >     was left over from earlier patch iterations.
> > > >
> > > >     Acked-by: Markus Armbruster <armbru@redhat.com>
> > > >     Signed-off-by: Daniel P. Berrangé <berrange@redhat.com>
> > > >
> > > > The test case demonstrates that it actually wasn't unused.
> > > >
> > > > If we don't want to reintroduce the field in QAPI, we need to explicitly
> > > >
> > > 
> > > Keeping the detached-header option is more convenient for users when
> > > creating a detached-header image.
> > > 
> > > My inclination is to bring this optionback.  Any suggestions? cc @Daniel P.
> > > Berrangé <berrange@redhat.com>
> > 
> > Having it available for users in qemu-img is different from having it in
> > QAPI. Arguably there is no use for it in QAPI, as long as you make sure
> > that it's taken out of the QemuOpts before going to QAPI.
> 
> Ah so what we actually need to fix is
> 
> diff --git a/block/crypto.c b/block/crypto.c
> index 4eed3ffa6a..8b60510c61 100644
> --- a/block/crypto.c
> +++ b/block/crypto.c
> @@ -792,7 +792,7 @@ block_crypto_co_create_opts_luks(BlockDriver *drv, const char *filename,
>      char *buf = NULL;
>      int64_t size;
>      bool detached_hdr =
> -        qemu_opt_get_bool(opts, "detached-header", false);
> +        qemu_opt_get_bool_del(opts, "detached-header", false);
>      unsigned int cflags = 0;
>      int ret;
>      Error *local_err = NULL;

That's what I had in mind, but we need to verify that we don't get a
scenario like what you hinted at where converting the options back to
some non-QAPI data structure (QemuOpts or QDict) would still use it
later.

Kevin


