Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1903AC61DC2
	for <qemu-devel@archiver.kernel.org>; Thu, 27 Aug 2026 10:30:56 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wzXNJ-0001Al-IC; Thu, 27 Aug 2026 06:30:25 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <berrange@redhat.com>)
 id 1wzXNG-0001AI-U8
 for qemu-devel@nongnu.org; Thu, 27 Aug 2026 06:30:22 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <berrange@redhat.com>)
 id 1wzXNF-0005e5-5M
 for qemu-devel@nongnu.org; Thu, 27 Aug 2026 06:30:22 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1787826619;
 h=from:from:reply-to:reply-to:subject:subject:date:date:
 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
 content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=Ch+c0lIYIhs4oj0KT3rgvce0AE/PdcU0D0NmHIz2grc=;
 b=cYwXqnc3kA7nYSllFlihhJk8fq1P1LKCZff8wO9ANY4egDxtIbM0OYACTrAqu13UVFV8CV
 B30jRTPqg8YcM6aGNT4Bh3k5x2JC1Xkj/YxZpXVMfZpje3Hw5Hs4lf2JFQAK0akiTRBB+f
 YSPt/0svJ/OLKaJRVdvybnZ5FTw4beQ=
Received: from mx-prod-mc-03.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-146-haeoymO-PvqiTY9VuKSMHg-1; Thu,
 27 Aug 2026 06:30:16 -0400
X-MC-Unique: haeoymO-PvqiTY9VuKSMHg-1
X-Mimecast-MFC-AGG-ID: haeoymO-PvqiTY9VuKSMHg_1787826615
Received: from mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.12])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-03.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id AEE061955F1D; Thu, 27 Aug 2026 10:30:15 +0000 (UTC)
Received: from redhat.com (headnet05.pony-001.prod.iad2.dc.redhat.com
 [10.2.32.117])
 by mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 8B8411955F04; Thu, 27 Aug 2026 10:30:14 +0000 (UTC)
Date: Thu, 27 Aug 2026 11:30:11 +0100
From: Daniel =?utf-8?B?UC4gQmVycmFuZ8Op?= <berrange@redhat.com>
To: =?utf-8?Q?Marc-Andr=C3=A9?= Lureau <marcandre.lureau@redhat.com>
Cc: qemu-devel@nongnu.org, akihiko.odaki@gmail.com
Subject: Re: [PATCH] ui/console: fix use-after-free in qemu_console_set_cursor
Message-ID: <apARs-59eJramFr9@redhat.com>
References: <20260827070647.2872650-1-marcandre.lureau@redhat.com>
 <ao_5WNBxRiZycEeb@redhat.com>
 <CAJ+F1CL-4kx18mUC4Jk7-cARiVX0Cq3qSFt5Ct-qM2EBA9dyUw@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAJ+F1CL-4kx18mUC4Jk7-cARiVX0Cq3qSFt5Ct-qM2EBA9dyUw@mail.gmail.com>
User-Agent: Mutt/2.4.0 (2026-06-19)
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.12
Received-SPF: pass client-ip=170.10.133.124; envelope-from=berrange@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: 12
X-Spam_score: 1.2
X-Spam_bar: +
X-Spam_report: (1.2 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
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

On Thu, Aug 27, 2026 at 01:58:14PM +0400, Marc-André Lureau wrote:
> Hi
> 
> On Thu, Aug 27, 2026 at 12:47 PM Daniel P. Berrangé <berrange@redhat.com> wrote:
> >
> > On Thu, Aug 27, 2026 at 11:06:47AM +0400, marcandre.lureau@redhat.com wrote:
> > > From: Marc-André Lureau <marcandre.lureau@redhat.com>
> > >
> > > When the new cursor is the same object as the one already held by
> > > the console and the refcount is 1, cursor_unref frees it before
> > > cursor_ref can increment the count.
> > >
> > > Ref the incoming cursor before unreffing the old one so the
> > > refcount goes 1-2-1 instead of 1-0 (freed) then use-after-free.
> >
> > I don't see where/how this can happen.  The caller of
> > qemu_console_set_cursor should own its own reference
> > on 'cursor'. So on entry to this method, 'cursor'
> > should have a ref of 2 if it is the same as the
> > current con->cursor.
> >
> > if anything the behaviour you describe sounds like a
> > bug in a caller not holding its own reference.
> 
> You are right, I thought virtio-gpu kept a weak pointer, but it should
> have a strong ref, so we should never reach 0. I can't explain the
> crash I observed then.

Is there a bug report for this or crash scenario info ? 

Something wrong with the 'cursor' object stored in virtio_gpu_scanout ?
I notice in the VMState:

        VMSTATE_UINT32(cursor.resource_id, struct virtio_gpu_scanout),
        VMSTATE_UINT32(cursor.hot_x, struct virtio_gpu_scanout),
        VMSTATE_UINT32(cursor.hot_y, struct virtio_gpu_scanout),
        VMSTATE_UINT32(cursor.pos.x, struct virtio_gpu_scanout),
        VMSTATE_UINT32(cursor.pos.y, struct virtio_gpu_scanout),

what is restoring the "refcount" to "1" when vmstate is loaded ?

With regards,
Daniel
-- 
|: https://berrange.com       ~~        https://hachyderm.io/@berrange :|
|: https://libvirt.org          ~~          https://entangle-photo.org :|
|: https://pixelfed.art/berrange   ~~    https://fstop138.berrange.com :|


