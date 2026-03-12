Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7EE35106ACD0
	for <qemu-devel@archiver.kernel.org>; Thu, 12 Mar 2026 16:48:43 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1w0jCV-0004QM-Rh; Thu, 12 Mar 2026 12:47:55 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <kwolf@redhat.com>) id 1w0jCR-0004Pu-3X
 for qemu-devel@nongnu.org; Thu, 12 Mar 2026 12:47:51 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <kwolf@redhat.com>) id 1w0jCO-00031S-JW
 for qemu-devel@nongnu.org; Thu, 12 Mar 2026 12:47:50 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1773334066;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=Z5IEFaCw8kFAOsm8x2Pwnv9Yzptxh4ZEqTJD0wZZ3zM=;
 b=Hz//YYYeAajQ6Vaz8uFxnF6dgE3/9Dc6aI5YoHeIZ0cqR2MMeRyOI0FYNrc8y3zaOzUT0h
 1n2RnFDdwyRZfiJuUXOHJjJBfNn+jGxsQjPrWmsmnC+yxrEh59NWBmoWzOyhrOrk8KEziN
 5agAiDeNxz28sJxFiBwtg79oRdLOwOQ=
Received: from mx-prod-mc-05.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-687-lSs8DqSyNjyKwkwIw8ThPw-1; Thu,
 12 Mar 2026 12:47:44 -0400
X-MC-Unique: lSs8DqSyNjyKwkwIw8ThPw-1
X-Mimecast-MFC-AGG-ID: lSs8DqSyNjyKwkwIw8ThPw_1773334063
Received: from mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.17])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-05.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id A9D3219560A1; Thu, 12 Mar 2026 16:47:43 +0000 (UTC)
Received: from redhat.com (unknown [10.45.225.57])
 by mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 66FB719540C2; Thu, 12 Mar 2026 16:47:42 +0000 (UTC)
Date: Thu, 12 Mar 2026 17:47:39 +0100
From: Kevin Wolf <kwolf@redhat.com>
To: Peter Maydell <peter.maydell@linaro.org>
Cc: qemu-block@nongnu.org, qemu-devel@nongnu.org
Subject: Re: [PULL 26/28] block/nfs: add support for libnfs v6
Message-ID: <abLuKyQp20ZO1Rm-@redhat.com>
References: <20260310162622.333137-1-kwolf@redhat.com>
 <20260310162622.333137-27-kwolf@redhat.com>
 <CAFEAcA_c_LOZmeMc7PvcUK4PgyAbzvrcVt3VyALRLtY6ECbpEg@mail.gmail.com>
 <abLmCCB-Wjn-mqh1@redhat.com>
 <CAFEAcA9caqp+JP_cq7Q0P3EPgWywd8BJCrngAKEBh6i2G7uJ1w@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAFEAcA9caqp+JP_cq7Q0P3EPgWywd8BJCrngAKEBh6i2G7uJ1w@mail.gmail.com>
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.17
Received-SPF: pass client-ip=170.10.129.124; envelope-from=kwolf@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -3
X-Spam_score: -0.4
X-Spam_bar: /
X-Spam_report: (-0.4 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H3=0.001, RCVD_IN_MSPIKE_WL=0.001,
 RCVD_IN_VALIDITY_RPBL_BLOCKED=0.819, RCVD_IN_VALIDITY_SAFE_BLOCKED=0.903,
 SPF_HELO_PASS=-0.001, SPF_PASS=-0.001 autolearn=no autolearn_force=no
X-Spam_action: no action
X-BeenThere: qemu-devel@nongnu.org
X-Mailman-Version: 2.1.29
Precedence: list
List-Id: qemu development <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <https://lists.nongnu.org/archive/html/qemu-devel>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=subscribe>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org

Am 12.03.2026 um 17:19 hat Peter Maydell geschrieben:
> On Thu, 12 Mar 2026 at 16:13, Kevin Wolf <kwolf@redhat.com> wrote:
> >
> > Am 12.03.2026 um 10:41 hat Peter Maydell geschrieben:
> > > On Tue, 10 Mar 2026 at 16:30, Kevin Wolf <kwolf@redhat.com> wrote:
> > > >
> > > > From: Peter Lieven <pl@dlhnet.de>
> > > >
> > > > libnfs v6 added a new api structure for read and write requests.
> > > >
> > > > This effectively also adds zero copy read support for cases where
> > > > the qiov coming from the block layer has only one vector.
> > > >
> > > > The .brdv_refresh_limits implementation is needed because libnfs v6
> > > > silently dropped support for splitting large read/write request into
> > > > chunks.
> > > >
> > > > Signed-off-by: Ronnie Sahlberg <ronniesahlberg@gmail.com>
> > > > Signed-off-by: Peter Lieven <pl@dlhnet.de>
> > > > Message-ID: <20260306142840.72923-1-pl@dlhnet.de>
> > > > Reviewed-by: Kevin Wolf <kwolf@redhat.com>
> > > > Signed-off-by: Kevin Wolf <kwolf@redhat.com>
> > >
> > >
> > > Hi; Coverity reports a potential issue with this code
> > > (CID 1645631):
> > >
> > > > @@ -266,13 +270,36 @@ static int coroutine_fn nfs_co_preadv(BlockDriverState *bs, int64_t offset,
> > > >  {
> > > >      NFSClient *client = bs->opaque;
> > > >      NFSRPC task;
> > > > +    char *buf = NULL;
> > > > +    bool my_buffer = false;
> > > >
> > > >      nfs_co_init_task(bs, &task);
> > > > -    task.iov = iov;
> > > > +
> > > > +#ifdef LIBNFS_API_V2
> > > > +    if (iov->niov != 1) {
> > > > +        buf = g_try_malloc(bytes);
> > > > +        if (bytes && buf == NULL) {
> > > > +            return -ENOMEM;
> > > > +        }
> > > > +        my_buffer = true;
> > >
> > > Here we have code that takes the "read zero bytes" case, and
> > > still tries to malloc a 0-length buffer (which is of dubious
> > > portability). Then it will continue...
> >
> > g_try_malloc() always returns NULL for allocating 0 bytes, so I don't
> > think portability is a problem here.
> 
> Ah, so it does. The glib docs document this for g_malloc() but
> don't mention it for g_try_malloc(), so I missed it.
> 
> > > > +    if (my_buffer) {
> > > > +        if (task.ret > 0) {
> > > > +            qemu_iovec_from_buf(iov, 0, buf, task.ret);
> > >
> > > ...and down here we use 'buf', but Coverity thinks it might be NULL
> > > because we only returned -ENOMEM above for a NULL buffer if bytes == 0.
> > > So we might be here with bytes == 0 and buf == NULL.
> >
> > Yes, buf might be NULL, but copying 0 bytes from NULL isn't a problem
> > because you don't actually dereference the pointer then.
> >
> > I think the part that Coverity doesn't understand is probably that
> > task.ret is limited to bytes (i.e. 0 in this case).
> 
> Mmm. Let me know if you'd prefer me to mark this issue in
> Coverity as a false positive rather than changing the code.

I don't really mind either way. If someone posts a patch, I'll apply it
(though not sure if that would be only for 11.1 at this point).

Kevin


