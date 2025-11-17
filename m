Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 834E8CEACEF
	for <qemu-devel@archiver.kernel.org>; Mon, 17 Nov 2025 08:56:20 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vKv1l-0004SG-Is; Mon, 17 Nov 2025 03:56:10 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <berrange@redhat.com>)
 id 1vKv1K-0004L0-10
 for qemu-devel@nongnu.org; Mon, 17 Nov 2025 03:55:35 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <berrange@redhat.com>)
 id 1vKv1A-0007en-8d
 for qemu-devel@nongnu.org; Mon, 17 Nov 2025 03:55:30 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1763369723;
 h=from:from:reply-to:reply-to:subject:subject:date:date:
 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
 content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=CMMP9IyUlJjP/+f6GjhvM0IQdyi8Nsh9rivzL3M5V7A=;
 b=dki9Zf87Yi1BZ6JMO3M4+8jQYfLrUStQX4Nui0fb1HV308hCkEKs8Cf6egDLmvIr8WW/Ts
 E8Zyvww1igVCesHWfwrTQ71EAMUKhejB2LHmt5evLLY94emHL51vWc1WTD5/rJuaow9Cgz
 rJ4GrZKNDKaO4Qma/QPxcMvc2XYvTkU=
Received: from mx-prod-mc-01.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-685-s5A4l7vXOyeJYew9KK57tw-1; Mon,
 17 Nov 2025 03:55:19 -0500
X-MC-Unique: s5A4l7vXOyeJYew9KK57tw-1
X-Mimecast-MFC-AGG-ID: s5A4l7vXOyeJYew9KK57tw_1763369719
Received: from mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.4])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-01.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 258A71956068; Mon, 17 Nov 2025 08:55:18 +0000 (UTC)
Received: from redhat.com (unknown [10.42.28.112])
 by mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 3B6D53003754; Mon, 17 Nov 2025 08:55:13 +0000 (UTC)
Date: Mon, 17 Nov 2025 08:55:07 +0000
From: Daniel =?utf-8?B?UC4gQmVycmFuZ8Op?= <berrange@redhat.com>
To: Michael Tokarev <mjt@tls.msk.ru>
Cc: qemu-devel@nongnu.org, qemu-stable <qemu-stable@nongnu.org>,
 Grant Millar | Cylo <rid@cylo.io>,
 =?utf-8?Q?Marc-Andr=C3=A9?= Lureau <marcandre.lureau@gmail.com>,
 Eric Blake <eblake@redhat.com>
Subject: Re: [PATCH v2 1/3] io: release active GSource in TLS channel finalizer
Message-ID: <aRri1UWjwIu03FQp@redhat.com>
References: <20251003150245.3510069-1-berrange@redhat.com>
 <20251003150245.3510069-2-berrange@redhat.com>
 <3e38f235-c25f-4ec6-9650-84ba6977e81e@tls.msk.ru>
 <69002830-e7ce-4d52-b875-857a096e1a70@tls.msk.ru>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <69002830-e7ce-4d52-b875-857a096e1a70@tls.msk.ru>
User-Agent: Mutt/2.2.14 (2025-02-20)
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.4
Received-SPF: pass client-ip=170.10.129.124; envelope-from=berrange@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H3=-0.01, RCVD_IN_MSPIKE_WL=-0.01,
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
Reply-To: Daniel =?utf-8?B?UC4gQmVycmFuZ8Op?= <berrange@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org

On Sat, Nov 15, 2025 at 01:01:29AM +0300, Michael Tokarev wrote:
> On 11/14/25 22:12, Michael Tokarev wrote:
> > On 10/3/25 18:02, Daniel P. Berrangé wrote:
> > > While code is supposed to call qio_channel_close() before releasing the
> > > last reference on an QIOChannel, this is not guaranteed. QIOChannelFile
> > > and QIOChannelSocket both cleanup resources in their finalizer if the
> > > close operation was missed.
> > > 
> > > This ensures the TLS channel will do the same failsafe cleanup.
> > > 
> > > Signed-off-by: Daniel P. Berrangé <berrange@redhat.com>
> > > ---
> > >   io/channel-tls.c | 10 ++++++++++
> > >   1 file changed, 10 insertions(+)
> > > 
> > > diff --git a/io/channel-tls.c b/io/channel-tls.c
> > > index 7135896f79..bb460ca7e9 100644
> > > --- a/io/channel-tls.c
> > > +++ b/io/channel-tls.c
> > > @@ -342,6 +342,16 @@ static void qio_channel_tls_finalize(Object *obj)
> > >   {
> > >       QIOChannelTLS *ioc = QIO_CHANNEL_TLS(obj);
> > > +    if (ioc->hs_ioc_tag) {
> > > +        trace_qio_channel_tls_handshake_cancel(ioc);
> > > +        g_clear_handle_id(&ioc->hs_ioc_tag, g_source_remove);
> > > +    }
> > > +
> > > +    if (ioc->bye_ioc_tag) {
> > > +        trace_qio_channel_tls_bye_cancel(ioc);
> > > +        g_clear_handle_id(&ioc->bye_ioc_tag, g_source_remove);
> > > +    }
> > > +
> > >       object_unref(OBJECT(ioc->master));
> > >       qcrypto_tls_session_free(ioc->session);
> > >   }
> > 
> > This series should be relevant for 7.2.x qemu stable series too, it
> > looks like.  Except that 7.2 does not have ioc->bye_ioc_tag (which
> > comes from v9.2.0-1773-g30ee88622e "io: tls: Add qio_channel_tls_bye"),
> > and does not have trace_qio_channel_tls_handshake_cancel defined.
> 
> https://gitlab.com/mjt0k/qemu/-/commits/cebdbd038e44af56e74272924dc2bf595a51fd8f
> is what I did (4 commits from there).  I picked up a trivial change
> v8.2.0-1149-g003f15369d "io: add trace event when cancelling TLS
> handshake", and removed half of v10.1.0-1703-g2c147611cf56
> "io: release active GSource in TLS channel finalizer" (this one)
> which releases bye_ioc_tag.
> 
> The other (subsequent) two commits from this series are taken as-is.

Yep, that's all looking correct.

With regards,
Daniel
-- 
|: https://berrange.com      -o-    https://www.flickr.com/photos/dberrange :|
|: https://libvirt.org         -o-            https://fstop138.berrange.com :|
|: https://entangle-photo.org    -o-    https://www.instagram.com/dberrange :|


