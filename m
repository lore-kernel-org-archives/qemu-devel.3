Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 04B26F483E5
	for <qemu-devel@archiver.kernel.org>; Mon, 23 Mar 2026 19:10:41 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1w4kfT-0008P4-Mb; Mon, 23 Mar 2026 15:10:27 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <kwolf@redhat.com>) id 1w4kfO-0008OK-Vz
 for qemu-devel@nongnu.org; Mon, 23 Mar 2026 15:10:24 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <kwolf@redhat.com>) id 1w4kfG-0000v9-Dg
 for qemu-devel@nongnu.org; Mon, 23 Mar 2026 15:10:16 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1774293012;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=SbXisrQ82avMVPmxPshDec5aS3ASXUsMERJNQ6BKVNk=;
 b=T9T5J+iqSUY8nvT/MQyb2ZbSQGPeQ8mOaVVCzWOPp83QVx8sP+WoD9CtgcQ2u3f8FFM+Xn
 HwQVAw8T5jw/jWw4E6+528x2+A08PCkEviabrTWsmcegjvaY5lZ8QGKMD0+yuRlJpLtUBY
 xNOC3y1GXEH03IcoiB3Xrw+Dza9MjDM=
Received: from mx-prod-mc-01.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-606-49kBatQANROgZVdtaztbZg-1; Mon,
 23 Mar 2026 15:10:08 -0400
X-MC-Unique: 49kBatQANROgZVdtaztbZg-1
X-Mimecast-MFC-AGG-ID: 49kBatQANROgZVdtaztbZg_1774293007
Received: from mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.111])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-01.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 76C25195609D; Mon, 23 Mar 2026 19:10:07 +0000 (UTC)
Received: from redhat.com (unknown [10.45.225.184])
 by mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 6C6951800594; Mon, 23 Mar 2026 19:10:05 +0000 (UTC)
Date: Mon, 23 Mar 2026 20:10:03 +0100
From: Kevin Wolf <kwolf@redhat.com>
To: Hanna Czenczek <hreitz@redhat.com>
Cc: qemu-block@nongnu.org, qemu-devel@nongnu.org,
 Aarushi Mehta <mehta.aaru20@gmail.com>,
 Stefan Hajnoczi <stefanha@redhat.com>,
 Stefano Garzarella <sgarzare@redhat.com>
Subject: Re: [PATCH for-11.0 1/3] linux-aio: Put all parameters into
 qemu_laiocb
Message-ID: <acGQC5NkHCMcCIWz@redhat.com>
References: <20260318153206.171494-1-hreitz@redhat.com>
 <20260318153206.171494-2-hreitz@redhat.com>
 <acFqulONusPdbQHY@redhat.com>
 <d6622d0b-9198-47cf-8f80-42c4384a8883@redhat.com>
 <236ef551-05c3-4bf4-8b0e-6e52106ca7ff@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <236ef551-05c3-4bf4-8b0e-6e52106ca7ff@redhat.com>
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.111
Received-SPF: pass client-ip=170.10.133.124; envelope-from=kwolf@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H5=0.001, RCVD_IN_MSPIKE_WL=0.001,
 RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001, RCVD_IN_VALIDITY_SAFE_BLOCKED=0.001,
 SPF_HELO_PASS=-0.001, SPF_PASS=-0.001 autolearn=unavailable autolearn_force=no
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

Am 23.03.2026 um 18:04 hat Hanna Czenczek geschrieben:
> On 23.03.26 18:02, Hanna Czenczek wrote:
> > On 23.03.26 17:36, Kevin Wolf wrote:
> > > Am 18.03.2026 um 16:32 hat Hanna Czenczek geschrieben:
> > > > Put all request parameters into the qemu_laiocb struct, which
> > > > will allow
> > > > re-submitting the tail of short reads/writes.
> > > > 
> > > > Signed-off-by: Hanna Czenczek <hreitz@redhat.com>
> > > > ---
> > > >   block/linux-aio.c | 35 ++++++++++++++++++++++-------------
> > > >   1 file changed, 22 insertions(+), 13 deletions(-)
> > > > 
> > > > diff --git a/block/linux-aio.c b/block/linux-aio.c
> > > > index 53c3e9af8a..1f25339dc9 100644
> > > > --- a/block/linux-aio.c
> > > > +++ b/block/linux-aio.c
> > > > @@ -40,10 +40,15 @@ struct qemu_laiocb {
> > > >       Coroutine *co;
> > > >       LinuxAioState *ctx;
> > > >       struct iocb iocb;
> > > > +    int fd;
> > > >       ssize_t ret;
> > > > +    off_t offset;
> > > >       size_t nbytes;
> > > >       QEMUIOVector *qiov;
> > > > -    bool is_read;
> > > > +
> > > > +    int type;
> > > If you put fd and type next to each other, you'd avoid a hole in the
> > > struct.
> > 
> > And I assume pulling dev_max_batch forward, after qiov, yes.
> 
> Noticed while sending: I missed `.next` for some reason. So no reason to
> pull dev_max_batch forward, and I guess there will always be a hole, but I
> suppose it is still best to put all 32-bit ints next to each other (fd,
> type, flags) so filling that up in the future is more likely.

Ah, yes, I missed that flags is only 32 bits, too.

I'm sure that things could still be rearranged to be more optimal, and
I'm also sure it's premature optimisation. Sorry for the noise.

Kevin


