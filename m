Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 681B9C54E67
	for <qemu-devel@archiver.kernel.org>; Thu, 28 Mar 2024 15:01:24 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rprFh-00036k-Mg; Thu, 28 Mar 2024 11:01:13 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <berrange@redhat.com>)
 id 1rprFf-00036T-QN
 for qemu-devel@nongnu.org; Thu, 28 Mar 2024 11:01:12 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <berrange@redhat.com>)
 id 1rprFb-0008Fr-3z
 for qemu-devel@nongnu.org; Thu, 28 Mar 2024 11:01:11 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1711638061;
 h=from:from:reply-to:reply-to:subject:subject:date:date:
 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
 content-type:content-type:in-reply-to:in-reply-to:  references:references;
 bh=xwCdaP4wZdgidcMmnJd3oRE8RThuhR+dQZAda1Jl3kc=;
 b=IwL7oj9U1Mk77fInrXxR/CQwq49goZSMDDbk2Ldc3n47C3JlEjMOGJGQewP93MGVMu/e4D
 gNiu1Qvxj9BLGUIBZ4qD872DhKob398gZTk4O6RsJOT5+QjzS6UiHdwmgb2NWbwwTyMxWc
 hJgIFcl3A8nrbBB4gFRaEunSSvK1QrM=
Received: from mimecast-mx02.redhat.com (mx-ext.redhat.com [66.187.233.73])
 by relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-662-9edsVm3KMYG7GR_6jYqzmg-1; Thu,
 28 Mar 2024 11:00:41 -0400
X-MC-Unique: 9edsVm3KMYG7GR_6jYqzmg-1
Received: from smtp.corp.redhat.com (int-mx08.intmail.prod.int.rdu2.redhat.com
 [10.11.54.8])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 093EF1C0172F;
 Thu, 28 Mar 2024 15:00:31 +0000 (UTC)
Received: from redhat.com (unknown [10.42.28.135])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id 391E8C585A2;
 Thu, 28 Mar 2024 15:00:29 +0000 (UTC)
Date: Thu, 28 Mar 2024 14:59:56 +0000
From: Daniel =?utf-8?B?UC4gQmVycmFuZ8Op?= <berrange@redhat.com>
To: Eric Blake <eblake@redhat.com>
Cc: Thomas Huth <thuth@redhat.com>,
 Alex =?utf-8?Q?Benn=C3=A9e?= <alex.bennee@linaro.org>,
 Philippe =?utf-8?Q?Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Vladimir Sementsov-Ogievskiy <vsementsov@yandex-team.ru>,
 Peter Lieven <pl@kamp.de>, "Richard W.M. Jones" <rjones@redhat.com>,
 qemu-devel@nongnu.org, Kevin Wolf <kwolf@redhat.com>,
 Hanna Reitz <hreitz@redhat.com>, Paolo Bonzini <pbonzini@redhat.com>,
 Konstantin Kostiuk <kkostiuk@redhat.com>, qemu-block@nongnu.org
Subject: Re: [PATCH for-9.1 6/9] block/nbd: Use URI parsing code from glib
Message-ID: <ZgWF7MGNAlMb_WvY@redhat.com>
References: <20240328140607.2433889-1-thuth@redhat.com>
 <20240328140607.2433889-7-thuth@redhat.com>
 <sv4rp7w2cnjy5xykp4t3w5gf3zwnohe5eso422whl2ux2ofixa@xwjphousol77>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <sv4rp7w2cnjy5xykp4t3w5gf3zwnohe5eso422whl2ux2ofixa@xwjphousol77>
User-Agent: Mutt/2.2.12 (2023-09-09)
X-Scanned-By: MIMEDefang 3.4.1 on 10.11.54.8
Received-SPF: pass client-ip=170.10.133.124; envelope-from=berrange@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -21
X-Spam_score: -2.2
X-Spam_bar: --
X-Spam_report: (-2.2 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.08,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H4=0.001, RCVD_IN_MSPIKE_WL=0.001,
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

On Thu, Mar 28, 2024 at 09:54:49AM -0500, Eric Blake wrote:
> On Thu, Mar 28, 2024 at 03:06:03PM +0100, Thomas Huth wrote:
> > Since version 2.66, glib has useful URI parsing functions, too.
> > Use those instead of the QEMU-internal ones to be finally able
> > to get rid of the latter. The g_uri_get_host() also takes care
> > of removing the square brackets from IPv6 addresses, so we can
> > drop that part of the QEMU code now, too.
> > 
> > Signed-off-by: Thomas Huth <thuth@redhat.com>
> > ---
> >  block/nbd.c | 66 ++++++++++++++++++++++++++++++-----------------------
> >  1 file changed, 38 insertions(+), 28 deletions(-)
> > 
> > diff --git a/block/nbd.c b/block/nbd.c
> > index ef05f7cdfd..95b507f872 100644
> > --- a/block/nbd.c
> > +++ b/block/nbd.c
> > @@ -31,7 +31,6 @@
> >  #include "qemu/osdep.h"
> >  
> >  #include "trace.h"
> > -#include "qemu/uri.h"
> >  #include "qemu/option.h"
> >  #include "qemu/cutils.h"
> >  #include "qemu/main-loop.h"
> > @@ -1514,30 +1513,34 @@ static void nbd_client_close(BlockDriverState *bs)
> >  
> >  static int nbd_parse_uri(const char *filename, QDict *options)
> >  {
> > -    URI *uri;
> > +    GUri *uri;
> 
> Is it worth using 'g_autoptr(GUri) uri = NULL;' here, to simplify cleanup later?
> 
> >      const char *p;
> > -    QueryParams *qp = NULL;
> > +    GHashTable *qp = NULL;
> 
> Presumably would be easier if qp is also auto-free.
> 
> > +    int qp_n;
> >      int ret = 0;
> >      bool is_unix;
> > +    const char *uri_scheme, *uri_query, *uri_server;
> > +    int uri_port;
> >  
> > -    uri = uri_parse(filename);
> > +    uri = g_uri_parse(filename, G_URI_FLAGS_NONE, NULL);
> 
> The glib API is fairly close to what we have in qemu, making this a
> nice switchover.
> 
> >          /* nbd[+tcp]://host[:port]/export */
> > -        if (!uri->server) {
> > +        if (!uri_server) {
> >              ret = -EINVAL;
> >              goto out;
> >          }
> >  
> > -        /* strip braces from literal IPv6 address */
> > -        if (uri->server[0] == '[') {
> > -            host = qstring_from_substr(uri->server, 1,
> > -                                       strlen(uri->server) - 1);
> > -        } else {
> > -            host = qstring_from_str(uri->server);
> > -        }
> > -
> >          qdict_put_str(options, "server.type", "inet");
> > -        qdict_put(options, "server.host", host);
> > +        qdict_put_str(options, "server.host", uri_server);
> >  
> > -        port_str = g_strdup_printf("%d", uri->port ?: NBD_DEFAULT_PORT);
> > +        port_str = g_strdup_printf("%d", uri_port != -1 ? uri_port
> > +                                                        : NBD_DEFAULT_PORT);
> >          qdict_put_str(options, "server.port", port_str);
> 
> If a user requests nbd://hostname:0/export, this now sets server.port
> to "0" instead of "10809".  Is that an intentional change?  No one
> actually passes an explicit ":0" port on purpose, but we do have to
> worry about malicious URIs.

Passing '0' will cause the kernel to allocate a random free
port, so that is potentially introducing new semantics ?


With regards,
Daniel
-- 
|: https://berrange.com      -o-    https://www.flickr.com/photos/dberrange :|
|: https://libvirt.org         -o-            https://fstop138.berrange.com :|
|: https://entangle-photo.org    -o-    https://www.instagram.com/dberrange :|


