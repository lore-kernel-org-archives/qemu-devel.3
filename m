Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 51618CA5FC1
	for <qemu-devel@archiver.kernel.org>; Wed, 30 Sep 2026 08:27:39 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xBpen-00088W-E8; Wed, 30 Sep 2026 04:27:17 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <berrange@redhat.com>)
 id 1xBpel-00088B-HP
 for qemu-devel@nongnu.org; Wed, 30 Sep 2026 04:27:15 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <berrange@redhat.com>)
 id 1xBpej-0000Cz-Vj
 for qemu-devel@nongnu.org; Wed, 30 Sep 2026 04:27:15 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1790756833;
 h=from:from:reply-to:reply-to:subject:subject:date:date:
 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
 content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=KWbaI9yZVE1WhhVS5gcJ6isS+pm6e7qNQ5XjjPluRpc=;
 b=IVFjvZrpNg2wSZ6HG4jPS2TUSZiXVIb8syZcsWPDG8h8lKhlkfqVxOzcZ2AuXg79zsO3KT
 Xyw1xLAMpYvs74hMSFH2aRewcC+2zfxtUlHr88C6z5DiymVNWkFlLZgUp14SyWQHl61eQ5
 fd8suqmlklv/YvrD6jGkurqlJARiVF0=
Received: from mx-prod-mc-01.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-678-i8XjggetNba-3m5kukDgEQ-1; Wed,
 30 Sep 2026 04:27:11 -0400
X-MC-Unique: i8XjggetNba-3m5kukDgEQ-1
X-Mimecast-MFC-AGG-ID: i8XjggetNba-3m5kukDgEQ_1790756830
Received: from mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.12])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-01.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id AC17B19540CB
 for <qemu-devel@nongnu.org>; Wed, 30 Sep 2026 08:27:10 +0000 (UTC)
Received: from redhat.com (headnet05.pony-001.prod.iad2.dc.redhat.com
 [10.2.32.117])
 by mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id CD74C195604D; Wed, 30 Sep 2026 08:27:09 +0000 (UTC)
Date: Wed, 30 Sep 2026 09:27:06 +0100
From: Daniel =?utf-8?B?UC4gQmVycmFuZ8Op?= <berrange@redhat.com>
To: =?utf-8?Q?Marc-Andr=C3=A9?= Lureau <marcandre.lureau@redhat.com>
Cc: qemu-devel@nongnu.org
Subject: Re: [PATCH] io: prevent unbounded read of websocket data from client
Message-ID: <arzH2idk9MDVbSKx@redhat.com>
References: <20260928130904.3921495-1-berrange@redhat.com>
 <CAJ+F1C+CqVB45HLPNaiwJJjbnrmwNAkDu=kGN=Ut8OsBW4VdYA@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAJ+F1C+CqVB45HLPNaiwJJjbnrmwNAkDu=kGN=Ut8OsBW4VdYA@mail.gmail.com>
User-Agent: Mutt/2.4.2 (2026-08-30)
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.12
Received-SPF: pass client-ip=170.10.133.124; envelope-from=berrange@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: 9
X-Spam_score: 0.9
X-Spam_bar: /
X-Spam_report: (0.9 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.341,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H3=0.001, RCVD_IN_MSPIKE_WL=0.001,
 RCVD_IN_SBL_CSS=3.335, SPF_HELO_PASS=-0.001,
 SPF_PASS=-0.001 autolearn=no autolearn_force=no
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

On Tue, Sep 29, 2026 at 12:09:35AM +0400, Marc-André Lureau wrote:
> On Mon, Sep 28, 2026 at 5:09 PM Daniel P. Berrangé <berrange@redhat.com> wrote:
> >
> > The QIOChannelWebsock class wraps an underlying QIOChannel instance,
> > providing a websocket server handshake and packet encoding/decoding.
> >
> > When a watch is added to QIOChannelWebsock, this in turn creates a watch
> > on the underlying QIOChannel that is always monitoring G_IO_IN, as long
> > as the 'encinput' buffer has space.
> >
> > When this watch fires, it reads data off the wire into 'encinput' and
> > then decodes as much of 'encinput' as possible into the 'rawinput'
> > buffer.
> >
> > The qio_channel_websock_set_watch method checks to see that 'encinput'
> > does not exceed a max limit, but fails to check that 'rawinput' size.
> > Since any data read into 'encinput', can usually be immediately decoded
> > into 'rawinput', the 'encinput' size check is largely a no-op, and so
> > 'rawinput' will grow without bound.
> >
> > This is readily seen with the chardev socket backend if enabling
> > websockets, connecting a client that sends data, while not running any
> > guest OS to consume data from the chardev via a virtual serial port.
> >
> > The qio_channel_websock_read_wire() method will also unconditionally
> > read more data into 'encinput' if it has less than 4k present, which
> > is then decoded into 'rawinput'.
> >
> > IOW, if qio_channel_websock_read_wire() is triggered for lots of small
> > reads, it will be reading and decoding more data to 'rawinput' than is
> > consumed. Skip reading more data if 'rawinput' is already at its max
> > size.
> >
> > Reported-by: Aisle Research
> > Fixes: CVE-2026-101291
> > Signed-off-by: Daniel P. Berrangé <berrange@redhat.com>
> 
> Reviewed-by: Marc-André Lureau <marcandre.lureau@redhat.com>
> 
> not sure if it's worth to add:
> Fixes: 2d1d0e70cf3e ("io: add QIOChannelWebsock class")

Doesn't hurt, so might as well.

With regards,
Daniel
-- 
|: https://berrange.com       ~~        https://hachyderm.io/@berrange :|
|: https://libvirt.org          ~~          https://entangle-photo.org :|
|: https://pixelfed.art/berrange   ~~    https://fstop138.berrange.com :|


