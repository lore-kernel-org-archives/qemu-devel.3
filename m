Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B0325C47422
	for <qemu-devel@archiver.kernel.org>; Fri, 26 Jan 2024 11:26:35 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rTKLj-0002AY-QA; Fri, 26 Jan 2024 06:26:19 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <kwolf@redhat.com>) id 1rTKLg-000287-Kl
 for qemu-devel@nongnu.org; Fri, 26 Jan 2024 06:26:17 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <kwolf@redhat.com>) id 1rTKLe-0006zh-3Y
 for qemu-devel@nongnu.org; Fri, 26 Jan 2024 06:26:15 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1706268373;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=bBCDwbOtHMvdqudUmdZy/iqWXxMFKR6TvkwM8Ndx9Zc=;
 b=CkSjlnCoDafnjVkxFsgUdRorogPvvqR0cLkE30gzenC6GiZQM80pNc7BIUCnSNnjSM3w8k
 yGy00omRgz9UDozYHSLwCo/+SGiTET5Z+VqCbb6RhkJIpZzotxT/X0BgMzp6W/1j3XemkZ
 cXCu34MgwG0yZEKp4I6s8ioNJCj8w3c=
Received: from mimecast-mx02.redhat.com (mimecast-mx02.redhat.com
 [66.187.233.88]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-28-CmOU7pbjOlmaYl7oWz6s2Q-1; Fri, 26 Jan 2024 06:26:11 -0500
X-MC-Unique: CmOU7pbjOlmaYl7oWz6s2Q-1
Received: from smtp.corp.redhat.com (int-mx09.intmail.prod.int.rdu2.redhat.com
 [10.11.54.9])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 694D087A9ED;
 Fri, 26 Jan 2024 11:26:11 +0000 (UTC)
Received: from redhat.com (unknown [10.39.193.108])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id 8502E492BC6;
 Fri, 26 Jan 2024 11:26:10 +0000 (UTC)
Date: Fri, 26 Jan 2024 12:26:09 +0100
From: Kevin Wolf <kwolf@redhat.com>
To: Andrey Drobyshev <andrey.drobyshev@virtuozzo.com>
Cc: qemu-block@nongnu.org, qemu-devel@nongnu.org, hreitz@redhat.com,
 den@virtuozzo.com, eblake@redhat.com
Subject: Re: [PATCH] iotests: don't run tests requiring cached writes in
 '-nocache' mode
Message-ID: <ZbOW0bDF2s9ndlGG@redhat.com>
References: <20231211133223.695048-1-andrey.drobyshev@virtuozzo.com>
 <ZbOIaoaOI1vc_-3F@redhat.com>
 <71305cf0-31e8-4d5e-beab-8854a0d1386a@virtuozzo.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <71305cf0-31e8-4d5e-beab-8854a0d1386a@virtuozzo.com>
X-Scanned-By: MIMEDefang 3.4.1 on 10.11.54.9
Received-SPF: pass client-ip=170.10.133.124; envelope-from=kwolf@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -35
X-Spam_score: -3.6
X-Spam_bar: ---
X-Spam_report: (-3.6 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-1.5,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H3=0.001, RCVD_IN_MSPIKE_WL=0.001,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
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

Am 26.01.2024 um 12:04 hat Andrey Drobyshev geschrieben:
> On 1/26/24 12:24, Kevin Wolf wrote:
> > Am 11.12.2023 um 14:32 hat Andrey Drobyshev geschrieben:
> >> There're tests whose logic implies running without O_DIRECT set,
> >> otherwise they fail when running iotests in '-nocache' mode.  For these
> >> tests let's add _require_no_o_direct() helper which can be put in the
> >> preabmle and which makes sure '-nocache' isn't set.  Use it to skip
> >> running the following tests:
> >>
> >>   * 271: creates files with unaligned sizes, thus producing multiple
> >>     errors like:
> >>
> >> qemu-io: can't open device /path/to/t.qcow2.raw: Cannot get 'write'
> >> permission without 'resize': Image size is not a multiple of request alignment
> >>
> >>   * 308, file-io-error: use fuse exports.  Though fuse does have
> >>     'direct-io' mode (see https://docs.kernel.org/filesystems/fuse-io.html)
> >>     we aren't using it yet, thus getting errors like:
> >>
> >> qemu-io: can't open device /path/to/t.qcow2.fuse: Could not open
> >> '/path/to/t.qcow2.fuse': filesystem does not support O_DIRECT
> >>
> >> Signed-off-by: Andrey Drobyshev <andrey.drobyshev@virtuozzo.com>
> > 
> > How are you running qemu-iotests to make these tests fail? I tried to
> > reproduce, but they just pass for me:
> > 
> > $ tests/qemu-iotests/check -qcow2 -nocache 271 308 file-io-error
> > [...]
> > 271             pass       [11:20:50] [11:21:11]   21.1s  (last: 20.4s) 
> > 308             pass       [11:21:11] [11:21:14]   3.3s   (last: 3.3s)  
> > file-io-error   pass       [11:21:14] [11:21:14]   0.3s   (last: 0.3s)  
> > Passed all 3 iotests
> > 
> > $ tests/qemu-iotests/check -raw -nocache 271 308 file-io-error
> > 271             not run    [11:21:20] [11:21:21]   ...                  not suitable for this image format: raw
> > 308             pass       [11:21:21] [11:21:24]   3.8s   (last: 2.8s)  
> > file-io-error   pass       [11:21:24] [11:21:25]   0.3s   (last: 0.3s)  
> > Not run: 271
> > Passed all 2 iotests
> > 
> > Kevin
> > 
> 
> As for the test 271, I imagine this might be caused by different request
> alignment.  The failure occurs in block.c, bdrv_node_refresh_perm().  If
> I print the alignment out explicitly, I get:
> 
> qemu-io: can't open device /path/to/t.qcow2.raw: Cannot get 'write'
> permission without 'resize': Image size is not a multiple of request
> alignment: 4096

Oh, do you have a 4k sector size? I think for me O_DIRECT only enforces
512 byte alignment. I can later try again on a 4k sector size loopback
device or something.

If so, I think that's worth mentioning in the commit message.

> For the record, I'm running tests on ext4.

I don't expect that this makes the difference, but xfs for me.

> I'm not sure about the fuse tests though.  Could it also have smth to do
> with the underlying fs?

Probably the same request alignment thing then.

Kevin


