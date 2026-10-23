Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1C1B7606A31B
	for <qemu-devel@archiver.kernel.org>; Fri, 23 Oct 2026 09:54:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=mimecast20190719 header.b=bOu8pzkW
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xKBy3-0003ng-AN; Fri, 23 Oct 2026 05:53:43 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <berrange@redhat.com>)
 id 1xKBxt-0003nC-A0
 for qemu-devel@nongnu.org; Fri, 23 Oct 2026 05:53:35 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <berrange@redhat.com>)
 id 1xKBxr-00011R-6i
 for qemu-devel@nongnu.org; Fri, 23 Oct 2026 05:53:33 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1792749207;
 h=from:from:reply-to:reply-to:subject:subject:date:date:
 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
 content-type:content-type:in-reply-to:in-reply-to:  references:references;
 bh=UhrVOJP5wWtgY2VHAU8DCc9mtppvaiYU2pt+PnJLXf8=;
 b=bOu8pzkWQBidBIZPaSuRFIy6+a5Yio5iw9UNMnGdWVoZ8mdtOTKDAD7ltu+dArAVqvxM0N
 WxUAYjXe+5kGP6vQpDtnfZKry0Ydr5tmwUnlT9AeqkzzJsJZfJgD2EXHFfMt/O61mxqR4s
 deyy49mEgTiucD5w0SWaOGWDBtOkxMI=
Received: from mx-prod-mc-05.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-126-K-o5wqeDOxSB_uHPOQOgJA-1; Fri,
 23 Oct 2026 05:53:25 -0400
X-MC-Unique: K-o5wqeDOxSB_uHPOQOgJA-1
X-Mimecast-MFC-AGG-ID: K-o5wqeDOxSB_uHPOQOgJA_1792749204
Received: from mx-prod-int-10.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-10.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.95])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-05.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 2DDB01955DAB; Fri, 23 Oct 2026 09:53:24 +0000 (UTC)
Received: from redhat.com (headnet04.pony-001.prod.iad2.dc.redhat.com
 [10.2.32.116])
 by mx-prod-int-10.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id F0BA57DA; Fri, 23 Oct 2026 09:53:21 +0000 (UTC)
Date: Fri, 23 Oct 2026 10:53:18 +0100
From: Daniel =?utf-8?B?UC4gQmVycmFuZ8Op?= <berrange@redhat.com>
To: Stefan Hajnoczi <stefanha@redhat.com>
Cc: Eric Blake <eblake@redhat.com>, qemu-devel@nongnu.org,
 Paolo Bonzini <pbonzini@redhat.com>, qemu-block@nongnu.org,
 Fam Zheng <fam@euphon.net>,
 Benjamin Marzinski <bmarzins@redhat.com>, kwolf@redhat.com
Subject: Re: [PATCH] qemu-pr-helper: do not free reply when
 multipath_process_cmd() fails
Message-ID: <atsujuqwo49tVwnC@redhat.com>
References: <20261019153353.105505-1-stefanha@redhat.com>
 <atZCSQwSBweiek0-@redhat.com>
 <20261019205710.GB159294@shajnocz.csb>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20261019205710.GB159294@shajnocz.csb>
User-Agent: Mutt/2.4.2 (2026-08-30)
X-Scanned-By: MIMEDefang 3.6 on 10.30.177.95
Received-SPF: pass client-ip=170.10.133.124; envelope-from=berrange@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: 2
X-Spam_score: 0.2
X-Spam_bar: /
X-Spam_report: (0.2 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.339,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_LOW=-0.7, RCVD_IN_MSPIKE_H3=0.001, RCVD_IN_MSPIKE_WL=0.001,
 RCVD_IN_SBL_CSS=3.335, SPF_HELO_PASS=-0.001,
 SPF_PASS=-0.001 autolearn=no autolearn_force=no
X-Spam_action: no action
X-BeenThere: qemu-devel@nongnu.org
X-Mailman-Version: 2.1.29
Precedence: list
List-Id: qemu development <qemu-devel.nongnu.org>
List-Archive: <https://lists.nongnu.org/archive/html/qemu-devel>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=subscribe>
Reply-To: Daniel =?utf-8?B?UC4gQmVycmFuZ8Op?= <berrange@redhat.com>
Sender: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
X-Spam-Status: No, score=-12.6 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_CR_TRAILER,MAILING_LIST_MULTI,SPF_HELO_PASS,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

On Mon, Oct 19, 2026 at 04:57:10PM -0400, Stefan Hajnoczi wrote:
> On Mon, Oct 19, 2026 at 11:19:29AM -0500, Eric Blake wrote:
> > On Mon, Oct 19, 2026 at 11:33:53AM -0400, Stefan Hajnoczi wrote:
> > > Kevin Wolf pointed out that the multipath_process_cmd() documentation
> > > only defines the value of reply on success. Don't touch it when the
> > > function returns -1.
> > > 
> > > The libmpathcmd implementation as of c78cf64a9e8e does not set *reply to
> > > NULL when its internal mpath_send_cmd() call fails, so I think Kevin's
> > > interpretation is correct.
> > > 
> > > As it stands, there is no observable bug in the QEMU code though because
> > > reply is initialized to NULL before calling multipath_process_cmd().
> > > This patch is just a cleanup.
> > > 
> > > Cc: Benjamin Marzinski <bmarzins@redhat.com>
> > > Cc: kwolf@redhat.com
> > > Cc: eblake@redhat.com
> > > Signed-off-by: Stefan Hajnoczi <stefanha@redhat.com>
> > > ---
> > > Eric pointed out that g_autofree could eliminate the manual free(3)
> > > calls. In this case we cannot use it since g_autofree calls glib's
> > > g_free() rather than the standard library's free(3).
> > 
> > I know glib encourages g_free() in case malloc was interposed, but
> > aren't we guaranteed that we are not exploiting glib's malloc
> > overrides, and therefore g_free() calls into free(3)?  But I'm fine
> > with your decision to not use g_autofree here.
> 
> g_mem_set_vtable() is deprecated and a nop. Interposing no longer works.
> g_mem_is_system_malloc() always returns TRUE.
> 
> If we take advantage of glib internals, then you can call g_free() on
> malloc() memory AFAIK. But I don't think the API documentation
> guarantees this will always be the case and I'm not sure it's worth
> baking in this assumption.

Glib has public guaranteed this for years now, since I personally added
this guarantee to their API docs :-)

  "Since GLib 2.46, g_malloc() is hardcoded to always use the system
   malloc implementation."

   https://docs.gtk.org/glib/memory.html

QEMU has equally relied on this guarantee for years.

The only things we have to be wary of are other non-glib based 3rd
party libraries QEMU uses that may allow malloc overrides.

With regards,
Daniel
-- 
|: https://berrange.com       ~~        https://hachyderm.io/@berrange :|
|: https://libvirt.org          ~~          https://entangle-photo.org :|
|: https://pixelfed.art/berrange   ~~    https://fstop138.berrange.com :|


