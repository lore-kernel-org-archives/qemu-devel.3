Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 26602C61DC2
	for <qemu-devel@archiver.kernel.org>; Thu, 27 Aug 2026 08:47:52 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wzVli-0006A9-K1; Thu, 27 Aug 2026 04:47:30 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <berrange@redhat.com>)
 id 1wzVlh-00069x-LY
 for qemu-devel@nongnu.org; Thu, 27 Aug 2026 04:47:29 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <berrange@redhat.com>)
 id 1wzVlf-0007hp-N4
 for qemu-devel@nongnu.org; Thu, 27 Aug 2026 04:47:29 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1787820446;
 h=from:from:reply-to:reply-to:subject:subject:date:date:
 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
 content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=TU7Q6ITlTnHGBzj6+4uPM5lYbNojytOfaYjLxq4LLHw=;
 b=AplRofZaFJtlh6jLFM5LvjCIzbR8SKvmcgS3GVleIvHOiGFUSYWWsRIBSizaSH09w1Bp2N
 n2KKU7IecbNXIz8rAB6Kiz8j2kzUXa5LFD4dBhZJzMiXbwKKxU2DbTUV8gFqgR3u/qWi9b
 JC4laJVf5HyVin05XlmBWbH3JlkrBPE=
Received: from mx-prod-mc-03.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-634-Ea4MAeMcPuOEC_4kIcmSPA-1; Thu,
 27 Aug 2026 04:47:24 -0400
X-MC-Unique: Ea4MAeMcPuOEC_4kIcmSPA-1
X-Mimecast-MFC-AGG-ID: Ea4MAeMcPuOEC_4kIcmSPA_1787820443
Received: from mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.111])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-03.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 278721955DA6; Thu, 27 Aug 2026 08:47:23 +0000 (UTC)
Received: from redhat.com (headnet05.pony-001.prod.iad2.dc.redhat.com
 [10.2.32.117])
 by mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id E980318005BC; Thu, 27 Aug 2026 08:47:21 +0000 (UTC)
Date: Thu, 27 Aug 2026 09:47:18 +0100
From: Daniel =?utf-8?B?UC4gQmVycmFuZ8Op?= <berrange@redhat.com>
To: marcandre.lureau@redhat.com
Cc: qemu-devel@nongnu.org, akihiko.odaki@gmail.com
Subject: Re: [PATCH] ui/console: fix use-after-free in qemu_console_set_cursor
Message-ID: <ao_5WNBxRiZycEeb@redhat.com>
References: <20260827070647.2872650-1-marcandre.lureau@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20260827070647.2872650-1-marcandre.lureau@redhat.com>
User-Agent: Mutt/2.4.0 (2026-06-19)
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.111
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

On Thu, Aug 27, 2026 at 11:06:47AM +0400, marcandre.lureau@redhat.com wrote:
> From: Marc-André Lureau <marcandre.lureau@redhat.com>
> 
> When the new cursor is the same object as the one already held by
> the console and the refcount is 1, cursor_unref frees it before
> cursor_ref can increment the count.
> 
> Ref the incoming cursor before unreffing the old one so the
> refcount goes 1-2-1 instead of 1-0 (freed) then use-after-free.

I don't see where/how this can happen.  The caller of
qemu_console_set_cursor should own its own reference
on 'cursor'. So on entry to this method, 'cursor'
should have a ref of 2 if it is the same as the
current con->cursor.

if anything the behaviour you describe sounds like a
bug in a caller not holding its own reference.

> 
> This is related to 385ac97f8fad ("ui: keep current cursor with
> QemuConsole"), but could have happened earlier with VNC too.
> 
> Signed-off-by: Marc-André Lureau <marcandre.lureau@redhat.com>
> ---
>  ui/console.c | 3 ++-
>  1 file changed, 2 insertions(+), 1 deletion(-)
> 
> diff --git a/ui/console.c b/ui/console.c
> index a8a2a247d8f4..4db8f1cb431f 100644
> --- a/ui/console.c
> +++ b/ui/console.c
> @@ -904,8 +904,9 @@ void qemu_console_set_cursor(QemuConsole *c, QEMUCursor *cursor)
>      DisplayState *s = c->ds;
>      DisplayChangeListener *dcl;
>  
> +    cursor_ref(cursor);
>      cursor_unref(con->cursor);
> -    con->cursor = cursor_ref(cursor);
> +    con->cursor = cursor;
>      QLIST_FOREACH(dcl, &s->listeners, next) {
>          if (c != dcl->con) {
>              continue;
> -- 
> 2.55.0.543.g5ebe2ebe4ea8
> 
> 

With regards,
Daniel
-- 
|: https://berrange.com       ~~        https://hachyderm.io/@berrange :|
|: https://libvirt.org          ~~          https://entangle-photo.org :|
|: https://pixelfed.art/berrange   ~~    https://fstop138.berrange.com :|


