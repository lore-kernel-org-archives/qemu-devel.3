Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C7F56C61DD6
	for <qemu-devel@archiver.kernel.org>; Wed,  2 Sep 2026 11:54:06 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1x1jX9-0007Bj-0d; Wed, 02 Sep 2026 07:53:39 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <berrange@redhat.com>)
 id 1x1jX7-0007Ba-CR
 for qemu-devel@nongnu.org; Wed, 02 Sep 2026 07:53:37 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <berrange@redhat.com>)
 id 1x1jX5-000413-NR
 for qemu-devel@nongnu.org; Wed, 02 Sep 2026 07:53:37 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1788350013;
 h=from:from:reply-to:reply-to:subject:subject:date:date:
 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
 content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=r/Y5xJHqUyXc7Bpc7iE3eZMPmDcHnm6fxST+zd/0gWU=;
 b=Z7F8K/lBfFNLabGY27gjyxaXrq23zVALCGJI0m2xv6qrm+isHMyz5n35eYo4jxxI8SVxdt
 1X31Bn/Itc7vHtGRa1zbeCVoO7DGy333VR7RZpltTpAavEeGsMc5OBITX1TKGIhulKUyh7
 WGgh8jmGYHEAGTx5a87S3I0N5jO3adM=
Received: from mx-prod-mc-05.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-57-ygI9dZX6Ma25GpzXLGlAbg-1; Wed,
 02 Sept 2026 07:53:32 -0400
X-MC-Unique: ygI9dZX6Ma25GpzXLGlAbg-1
X-Mimecast-MFC-AGG-ID: ygI9dZX6Ma25GpzXLGlAbg_1788350011
Received: from mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.93])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-05.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 6CC1E19539B9; Wed,  2 Sep 2026 11:53:31 +0000 (UTC)
Received: from redhat.com (headnet03.pony-001.prod.iad2.dc.redhat.com
 [10.2.32.114])
 by mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id E919A1800577; Wed,  2 Sep 2026 11:53:28 +0000 (UTC)
Date: Wed, 2 Sep 2026 12:53:26 +0100
From: Daniel =?utf-8?B?UC4gQmVycmFuZ8Op?= <berrange@redhat.com>
To: Markus Armbruster <armbru@redhat.com>
Cc: Zhang Chen <zhangckid@gmail.com>, qemu-devel <qemu-devel@nongnu.org>,
 Eric Blake <eblake@redhat.com>, "Michael S . Tsirkin" <mst@redhat.com>,
 Stefan Hajnoczi <stefanha@redhat.com>, Paolo Bonzini <pbonzini@redhat.com>,
 Jason Wang <jasowangio@gmail.com>
Subject: Re: [PATCH V14 06/15] monitor: track IOThread users with QOM paths
Message-ID: <apgONqZ4sWaenjVG@redhat.com>
References: <20260831160038.221776-1-zhangckid@gmail.com>
 <20260831160038.221776-7-zhangckid@gmail.com>
 <8733vtbk16.fsf@pond.sub.org>
 <CAK3tnvLbaJ4b+gRhXC678cye-cHv+aP3FFwRvhPNjyfSHxL6MA@mail.gmail.com>
 <87qzjb3nf6.fsf@pond.sub.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <87qzjb3nf6.fsf@pond.sub.org>
User-Agent: Mutt/2.4.0 (2026-06-19)
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.93
Received-SPF: pass client-ip=170.10.129.124; envelope-from=berrange@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: 12
X-Spam_score: 1.2
X-Spam_bar: +
X-Spam_report: (1.2 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H2=0.001, RCVD_IN_SBL_CSS=3.335,
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
Reply-To: Daniel =?utf-8?B?UC4gQmVycmFuZ8Op?= <berrange@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org

On Wed, Sep 02, 2026 at 01:25:33PM +0200, Markus Armbruster wrote:
> Zhang Chen <zhangckid@gmail.com> writes:
> 
> > On Tue, Sep 1, 2026 at 1:47 PM Markus Armbruster <armbru@redhat.com> wrote:
> >>
> >> Zhang Chen <zhangckid@gmail.com> writes:
> >>
> >> > Monitors that require an IOThread share the internal mon_iothread.
> >> > Account for each monitor explicitly in IOThread holder tracking, using
> >> > the monitor's canonical QOM path to distinguish holders.
> >> >
> >> > Acquire the shared monitor IOThread AioContext once, using the monitor
> >> > QOM path as the holder, and reuse the stored context for later
> >> > operations.
> >> >
> >> > Release the holder from the Monitor ObjectClass::unparent callback,
> >> > while the canonical QOM path is still available. This covers every
> >> > object_unparent() path and avoids duplicating the cleanup in
> >> > monitor_cleanup() and monitor_qmp_prepare_delete().
> >> >
> >> > The internal mon_iothread remains hidden from query-iothreads, as before.
> >> > Management applications therefore cannot use it to determine which
> >> > monitors are using the IOThread. Nevertheless, track the monitor
> >> > holders so that they follow the same explicit holder and
> >> > IOThread reference lifecycle as other AioContext users.
> >> >
> >> > Signed-off-by: Zhang Chen <zhangckid@gmail.com>
> >>
> >> I have a question for our QOM experts (Paolo and Daniel).
> >>
> >> This patch takes a reference in its UserCreatableClass method
> >> complete(), and relinquishes it in its ObjectClass unparent() method.
> >> Is that correct and clean?  Or should complete() pair with
> >> prepare_delete()?
> >
> >
> > Add some background information in previous reviews for here:
> > https://lists.gnu.org/archive/html/qemu-devel/2026-08/msg05318.html
> 
> Aha, Stefan asked for monitor_finalize(), which doesn't exist.  You then
> moved it to the unparent() method.

monitor_finalize() does exist as of about a month ago. It was
introduced as part of my series that turned Monitor into a QOM
object.

> My question for the QOM maintainers remains: is it okay to pair
> complete() with unparent(), or should it pair with prepare_delete()?

In general most things done in complete() can/should be undone in the
finalize() callback IMHO.

prepare_delete() offers the opportunity to block deletion (ie prevent
QMP  object_del from continuing), or (very rarely) to initiate some
cleanup that needs to take place before object properties start getting
deleted in the execution of finalize().

I don't think 

With regards,
Daniel
-- 
|: https://berrange.com       ~~        https://hachyderm.io/@berrange :|
|: https://libvirt.org          ~~          https://entangle-photo.org :|
|: https://pixelfed.art/berrange   ~~    https://fstop138.berrange.com :|


