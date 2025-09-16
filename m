Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B758DCAC598
	for <qemu-devel@archiver.kernel.org>; Tue, 16 Sep 2025 15:16:43 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uyXPY-0002V3-1d; Tue, 16 Sep 2025 11:16:04 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <berrange@redhat.com>)
 id 1uyXPT-0002U1-59
 for qemu-devel@nongnu.org; Tue, 16 Sep 2025 11:15:59 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <berrange@redhat.com>)
 id 1uyXPR-0000QQ-7e
 for qemu-devel@nongnu.org; Tue, 16 Sep 2025 11:15:58 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1758035755;
 h=from:from:reply-to:reply-to:subject:subject:date:date:
 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
 content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=MONAaZZO41wdF632ZLve9buv6pOSE1QoX5M0RwpUPmU=;
 b=iN8Qyq5zsSsmY51YDIpbiWrVMnTM8vdTXI9qvzvWe9nj/TJWia0ll747Nq88XNowLuyKhP
 9q8LJLzjS2dYUJgxMWK6EQRQFIWgIj/wRMqjm9WGlO3eC+KKyVi4iwOjaOArQAoeGf7bM4
 IOUGy7cmBsH5iLwW5YAr0egmXGXHA8s=
Received: from mx-prod-mc-02.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-647-YjsoP5mePomCmq--z1XrUg-1; Tue,
 16 Sep 2025 11:15:51 -0400
X-MC-Unique: YjsoP5mePomCmq--z1XrUg-1
X-Mimecast-MFC-AGG-ID: YjsoP5mePomCmq--z1XrUg_1758035750
Received: from mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.4])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-02.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id C93CE1956087; Tue, 16 Sep 2025 15:15:49 +0000 (UTC)
Received: from redhat.com (unknown [10.42.28.153])
 by mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 6221D300018D; Tue, 16 Sep 2025 15:15:45 +0000 (UTC)
Date: Tue, 16 Sep 2025 16:15:42 +0100
From: Daniel =?utf-8?B?UC4gQmVycmFuZ8Op?= <berrange@redhat.com>
To: Peter Xu <peterx@redhat.com>
Cc: Vladimir Sementsov-Ogievskiy <vsementsov@yandex-team.ru>,
 qemu-devel@nongnu.org, qemu-block@nongnu.org, leiyang@redhat.com,
 marcandre.lureau@redhat.com, Hailiang Zhang <zhanghailiang@xfusion.com>,
 Fabiano Rosas <farosas@suse.de>
Subject: Re: [PATCH v4 05/12] migration: qemu_file_set_blocking(): add errp
 parameter
Message-ID: <aMl_HrsUuasNT_z6@redhat.com>
References: <20250915193105.230085-1-vsementsov@yandex-team.ru>
 <20250915193105.230085-6-vsementsov@yandex-team.ru>
 <aMh0sjXkQ9IYo_SB@x1.local> <aMkfn2_GBUDlUB6O@redhat.com>
 <7f6b159e-6d97-4b0e-a825-7b8042c27e99@yandex-team.ru>
 <aMlrVHYxhuj1TYYL@x1.local>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <aMlrVHYxhuj1TYYL@x1.local>
User-Agent: Mutt/2.2.14 (2025-02-20)
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.4
Received-SPF: pass client-ip=170.10.129.124; envelope-from=berrange@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.009,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H5=0.001, RCVD_IN_MSPIKE_WL=0.001,
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
Reply-To: Daniel =?utf-8?B?UC4gQmVycmFuZ8Op?= <berrange@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org

On Tue, Sep 16, 2025 at 09:51:16AM -0400, Peter Xu wrote:
> On Tue, Sep 16, 2025 at 04:01:57PM +0300, Vladimir Sementsov-Ogievskiy wrote:
> > On 16.09.25 11:28, Daniel P. Berrangé wrote:
> > > On Mon, Sep 15, 2025 at 04:18:58PM -0400, Peter Xu wrote:
> > > > On Mon, Sep 15, 2025 at 10:30:57PM +0300, Vladimir Sementsov-Ogievskiy wrote:
> > > > > qemu_file_set_blocking() is a wrapper on qio_channel_set_blocking(),
> > > > > so let's passthrough the errp.
> > > > This looks all reasonable in general.
> > > > 
> > > > Said that, using error_abort in migration code normally are not suggested
> > > > because it's too strong.
> > > Note, that prior to this series, the existing qemu_socket_set_nonblock
> > > method that migration is calling will assert on failure. This series
> > > removes that assert and propagates it back to the callers to let them
> > > decide what to do. Ideally they would gracefully handle it, but if
> > > they assert that is no worse than current behaviour.
> > > 
> > 
> > In details, prior to series:
> > 
> > posix + set_nonblock -> crash on failure
> > 
> > other variants (posix/win32 + set_block, win32 + set_nonblock) -> ignore failure
> 
> Correct, but IIUC that's for sockets only.

True, that'd be the QIOChannelSocket class

> Major channel types that migration cares the most should also include file
> now.  qio_channel_file_set_blocking() also doesn't assert but return a
> failure.

Yep, you're correct that QIOChannelFile won't currently abort.

> > > > I did check all of below should be on the incoming side which is not as
> > > > severe (because killing dest qemu before switchover is normally
> > > > benign). Still, can we switch all below users to error_warn (including the
> > > > one below that may want to error_report_err(), IMHO a warn report is fine
> > > > even for such error)?
> > > IMHO ignoring a failure to change the blocking flag status is not
> > > a warnnig, it is unrecoverable for the migration operation. It
> > > should be possible to propagate the error in some way, but it will
> > > potentially require changes across multiple migration methods to
> > > handle this.
> 
> In most cases I agree.  But still, using error_abort doesn't mean to fail
> migration, but to crash the VM.  We still at least doesn't want to do it on
> src..

Yep, I do agree that it is dangerous to have the error_abort lurking
in there, as it is a trap-door for the future.

> Meanwhile, this could violate things like newly introduced exit-on-error,
> but I agree we used to ignore those, so even if it fails before and didn't
> crash, we could have ignored those errors.. and not reportable to libvirt.
> 
> The ideal way to do is to always fail either src/dst when set blocking
> failed for sure, but yes, it's slightly involved on some paths this patch
> touched.
> 
> So.. I think we can go with this patch, with a sincere wish that it'll
> simply almost never fail.  But then, let's mention that in the commit
> message, (1) this patch only asserts on the dest qemu and only before
> switchover (hence src can still fallback), never src, (2) state the facts
> that it so far is a slight violation to exit-on-error, but it's extremely
> unlikely to happen anyway (NOTE: this is not a programming error that
> normal assertions would do, so it falls into exit-on-error category).

With regards,
Daniel
-- 
|: https://berrange.com      -o-    https://www.flickr.com/photos/dberrange :|
|: https://libvirt.org         -o-            https://fstop138.berrange.com :|
|: https://entangle-photo.org    -o-    https://www.instagram.com/dberrange :|


