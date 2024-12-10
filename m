Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 68263E7717F
	for <qemu-devel@archiver.kernel.org>; Tue, 10 Dec 2024 18:46:43 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tL5FF-0002Z1-LU; Tue, 10 Dec 2024 13:46:07 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <berrange@redhat.com>)
 id 1tL5FC-0002Yp-3R
 for qemu-devel@nongnu.org; Tue, 10 Dec 2024 13:46:02 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <berrange@redhat.com>)
 id 1tL5F9-0006T8-04
 for qemu-devel@nongnu.org; Tue, 10 Dec 2024 13:46:01 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1733856356;
 h=from:from:reply-to:reply-to:subject:subject:date:date:
 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
 content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=b4ptb0ccDOWSKZk5zdYYZ1wYMNBp3LZvCUdSrBHIxDU=;
 b=MyEzKiBzzVEW+jqJAYgK19tpMErIcog8rq5jlbprrFwviyPZIIJmm6U8tdQmIbcjzXX3U/
 C1apQ/mhowFGYxcA6/a+wIKh6cDHoPxjpfdSoZEfqcvbrtOXK4xntyVfyNGIM6kMYWY3t1
 ydAmtDZOUKHPiFNQQEGlcZfWFB2a1QA=
Received: from mx-prod-mc-03.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-628-i3GEfFlhMvC2PpmuSQgZ5w-1; Tue,
 10 Dec 2024 13:45:53 -0500
X-MC-Unique: i3GEfFlhMvC2PpmuSQgZ5w-1
X-Mimecast-MFC-AGG-ID: i3GEfFlhMvC2PpmuSQgZ5w
Received: from mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.12])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-03.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id D07AE1955DBB; Tue, 10 Dec 2024 18:45:51 +0000 (UTC)
Received: from redhat.com (unknown [10.42.28.69])
 by mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 9376D19560A2; Tue, 10 Dec 2024 18:45:49 +0000 (UTC)
Date: Tue, 10 Dec 2024 18:45:46 +0000
From: Daniel =?utf-8?B?UC4gQmVycmFuZ8Op?= <berrange@redhat.com>
To: Thomas Huth <thuth@redhat.com>
Cc: Tiago Pasqualini <tiago.pasqualini@canonical.com>,
	qemu-devel@nongnu.org
Subject: Re: [PATCH v2] crypto: run qcrypto_pbkdf2_count_iters in a new thread
Message-ID: <Z1iMWrKH_DBUJLfa@redhat.com>
References: <20240904235230.199672-1-tiago.pasqualini@canonical.com>
 <ffe542bb-310c-4616-b0ca-13182f849fd1@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <ffe542bb-310c-4616-b0ca-13182f849fd1@redhat.com>
User-Agent: Mutt/2.2.13 (2024-03-09)
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.12
Received-SPF: pass client-ip=170.10.133.124; envelope-from=berrange@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -25
X-Spam_score: -2.6
X-Spam_bar: --
X-Spam_report: (-2.6 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.52,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H2=-0.001,
 RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001, RCVD_IN_VALIDITY_SAFE_BLOCKED=0.001,
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
Reply-To: Daniel =?utf-8?B?UC4gQmVycmFuZ8Op?= <berrange@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org

On Tue, Dec 10, 2024 at 06:29:49PM +0100, Thomas Huth wrote:
> On 05/09/2024 01.52, Tiago Pasqualini wrote:
> > CPU time accounting in the kernel has been demonstrated to have a
> > sawtooth pattern[1][2]. This can cause the getrusage system call to
> > not be as accurate as we are expecting, which can cause this calculation
> > to stall.
> > 
> > The kernel discussions shows that this inaccuracy happens when CPU time
> > gets big enough, so this patch changes qcrypto_pbkdf2_count_iters to run
> > in a fresh thread to avoid this inaccuracy. It also adds a sanity check
> > to fail the process if CPU time is not accounted.
> > 
> > [1] https://lore.kernel.org/lkml/159231011694.16989.16351419333851309713.tip-bot2@tip-bot2/
> > [2] https://lore.kernel.org/lkml/20221226031010.4079885-1-maxing.lan@bytedance.com/t/#m1c7f2fdc0ea742776a70fd1aa2a2e414c437f534
> > 
> > Resolves: #2398
> > Signed-off-by: Tiago Pasqualini <tiago.pasqualini@canonical.com>
> > ---
> >   crypto/pbkdf.c | 53 +++++++++++++++++++++++++++++++++++++++++++-------
> >   1 file changed, 46 insertions(+), 7 deletions(-)

> > +static void *threaded_qcrypto_pbkdf2_count_iters(void *data)
> >   {
> > +    CountItersData *iters_data = (CountItersData *) data;
> > +    QCryptoHashAlgorithm hash = iters_data->hash;
> > +    const uint8_t *key = iters_data->key;
> > +    size_t nkey = iters_data->nkey;
> > +    const uint8_t *salt = iters_data->salt;
> > +    size_t nsalt = iters_data->nsalt;
> > +    size_t nout = iters_data->nout;
> > +    Error **errp = iters_data->errp;
> > +
> >       uint64_t ret = -1;
> >       g_autofree uint8_t *out = g_new(uint8_t, nout);
> >       uint64_t iterations = (1 << 15);
> > @@ -114,7 +131,10 @@ uint64_t qcrypto_pbkdf2_count_iters(QCryptoHashAlgorithm hash,
> >           delta_ms = end_ms - start_ms;
> > -        if (delta_ms > 500) {
> > +        if (delta_ms == 0) { /* sanity check */
> > +            error_setg(errp, "Unable to get accurate CPU usage");
> 
>  Hi!
> 
> While running "make check -j12 SPEED=slow" on a s390x host, I got:
> 
>   3/657 qemu:unit / test-crypto-block          ERROR            0.27s
> killed by signal 6 SIGABRT
> >>> G_TEST_SLOW=1 UBSAN_OPTIONS=halt_on_error=1:abort_on_error=1:print_summary=1:print_stacktrace=1
> MALLOC_PERTURB_=150 G_TEST_BUILDDIR=/home/thuth/s390x/qemu/tests/unit
> MESON_TEST_ITERATION=1 MSAN_OPTIONS=halt_on_error=1:abort_on_error=1:print_summary=1:print_stacktrace=1
> ASAN_OPTIONS=halt_on_error=1:abort_on_error=1:print_summary=1
> G_TEST_SRCDIR=/home/thuth/devel/qemu/tests/unit
> /home/thuth/s390x/qemu/tests/unit/test-crypto-block --tap -k
> ―――――――――――――――――――――――――――――――――――――――――――――――――――――――――――――――――――――――――――――――――――
> ✀ ―――――――――――――――――――――――――――――――――――――――――――――――――――――――――――――――――――――――――――――――――――
> stderr:
> Unexpected error in threaded_qcrypto_pbkdf2_count_iters() at
> ../../devel/qemu/crypto/pbkdf.c:135:
> /home/thuth/s390x/qemu/tests/unit/test-crypto-block: Unable to get accurate
> CPU usage
> 
> (test program exited with status code -6)
> 
> TAP parsing error: Too few tests run (expected 27, got 1)
> ――――――――――――――――――――――――――――――――――――――――――――――――――――――――――――――――――――――――――――――――――――
> 
> Could we handle this more gracefully, please? I don't think that this should
> fail the unit tests, should it?

This is a scenario that is not supposed to ever happen. It means
we've had two calls to getrusage which returns exactly the same
CPU time. This should be impossible, as we've definitely burnt
lots of CPU between these two calls. Is this reliably reproducable
only on s390x ?

With regards,
Daniel
-- 
|: https://berrange.com      -o-    https://www.flickr.com/photos/dberrange :|
|: https://libvirt.org         -o-            https://fstop138.berrange.com :|
|: https://entangle-photo.org    -o-    https://www.instagram.com/dberrange :|


