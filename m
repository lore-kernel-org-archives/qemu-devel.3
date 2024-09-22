Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3D892CF9C64
	for <qemu-devel@archiver.kernel.org>; Sun, 22 Sep 2024 19:52:39 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1ssScK-0002Z9-NV; Sun, 22 Sep 2024 15:51:36 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <rjones@redhat.com>) id 1ssScJ-0002YB-8t
 for qemu-devel@nongnu.org; Sun, 22 Sep 2024 15:51:35 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <rjones@redhat.com>) id 1ssScG-0002bz-O5
 for qemu-devel@nongnu.org; Sun, 22 Sep 2024 15:51:35 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1727034691;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=PZwO3B8a0SJJkCjSItdsWZeHKBOFw8q0OGwn4/9kxLc=;
 b=T8VL+M9aE3wvXCqyy4QNHHFLRXnuS5/4Vzb7tl/fMJ2ZP83D7EdwC4JmBxXS2hl0SVDTUJ
 uXEgjY1xyNdQJHAtRbutFLolugM4jhEv4kTCG4I+H+jGWbSx12W9dbFvTSL2ztXYzdWuKn
 RJjcythNjNtU18yw+Frgi1up1FpVjeM=
Received: from mx-prod-mc-01.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-683-j5x3pjPUNPyw1g89feSGyQ-1; Sun,
 22 Sep 2024 15:51:27 -0400
X-MC-Unique: j5x3pjPUNPyw1g89feSGyQ-1
Received: from mx-prod-int-02.mail-002.prod.us-west-2.aws.redhat.com (unknown
 [10.30.177.15])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-01.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id AAB9019CC955; Sun, 22 Sep 2024 19:51:26 +0000 (UTC)
Received: from localhost (unknown [10.42.28.3])
 by mx-prod-int-02.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP
 id B84C0195608A; Sun, 22 Sep 2024 19:51:23 +0000 (UTC)
Date: Sun, 22 Sep 2024 20:51:22 +0100
From: "Richard W.M. Jones" <rjones@redhat.com>
To: Thomas Huth <thuth@redhat.com>
Cc: Alex =?iso-8859-1?Q?Benn=E9e?= <alex.bennee@linaro.org>,
 Philippe =?iso-8859-1?Q?Mathieu-Daud=E9?= <philmd@linaro.org>,
 Eric Blake <eblake@redhat.com>,
 Vladimir Sementsov-Ogievskiy <vsementsov@yandex-team.ru>,
 Peter Lieven <pl@kamp.de>, qemu-devel@nongnu.org,
 Kevin Wolf <kwolf@redhat.com>, Hanna Reitz <hreitz@redhat.com>,
 Paolo Bonzini <pbonzini@redhat.com>,
 Daniel =?iso-8859-1?Q?P=2E_Berrang=E9?= <berrange@redhat.com>,
 Konstantin Kostiuk <kkostiuk@redhat.com>, qemu-block@nongnu.org
Subject: Re: [PATCH for-9.1 6/9] block/nbd: Use URI parsing code from glib
Message-ID: <20240922195122.GK5140@redhat.com>
References: <20240328140607.2433889-1-thuth@redhat.com>
 <20240328140607.2433889-7-thuth@redhat.com>
 <20240328141342.GK7636@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240328141342.GK7636@redhat.com>
User-Agent: Mutt/1.5.21 (2010-09-15)
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.15
Received-SPF: pass client-ip=170.10.129.124; envelope-from=rjones@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -21
X-Spam_score: -2.2
X-Spam_bar: --
X-Spam_report: (-2.2 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.129,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H3=-0.01, RCVD_IN_MSPIKE_WL=-0.01,
 RCVD_IN_VALIDITY_CERTIFIED_BLOCKED=0.001, RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001,
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
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org

On Thu, Mar 28, 2024 at 02:13:42PM +0000, Richard W.M. Jones wrote:
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
> >      const char *p;
> > -    QueryParams *qp = NULL;
> > +    GHashTable *qp = NULL;
> > +    int qp_n;
> >      int ret = 0;
> >      bool is_unix;
> > +    const char *uri_scheme, *uri_query, *uri_server;
> > +    int uri_port;
> >  
> > -    uri = uri_parse(filename);
> > +    uri = g_uri_parse(filename, G_URI_FLAGS_NONE, NULL);
> >      if (!uri) {
> >          return -EINVAL;
> >      }
> >  
> >      /* transport */
> > -    if (!g_strcmp0(uri->scheme, "nbd")) {
> > +    uri_scheme = g_uri_get_scheme(uri);
> > +    if (!g_strcmp0(uri_scheme, "nbd")) {
> >          is_unix = false;
> > -    } else if (!g_strcmp0(uri->scheme, "nbd+tcp")) {
> > +    } else if (!g_strcmp0(uri_scheme, "nbd+tcp")) {
> >          is_unix = false;
> > -    } else if (!g_strcmp0(uri->scheme, "nbd+unix")) {
> > +    } else if (!g_strcmp0(uri_scheme, "nbd+unix")) {
> >          is_unix = true;
> >      } else {
> >          ret = -EINVAL;
> >          goto out;
> >      }
> >  
> > -    p = uri->path ? uri->path : "";
> > +    p = g_uri_get_path(uri) ?: "";
> >      if (p[0] == '/') {
> >          p++;
> >      }
> > @@ -1545,51 +1548,58 @@ static int nbd_parse_uri(const char *filename, QDict *options)
> >          qdict_put_str(options, "export", p);
> >      }
> >  
> > -    qp = query_params_parse(uri->query);
> > -    if (qp->n > 1 || (is_unix && !qp->n) || (!is_unix && qp->n)) {
> > -        ret = -EINVAL;
> > -        goto out;
> > +    uri_query = g_uri_get_query(uri);
> > +    if (uri_query) {
> > +        qp = g_uri_parse_params(uri_query, -1, "&", G_URI_PARAMS_NONE, NULL);
> > +        if (!qp) {
> > +            ret = -EINVAL;
> > +            goto out;
> > +        }
> > +        qp_n = g_hash_table_size(qp);
> > +        if (qp_n > 1 || (is_unix && !qp_n) || (!is_unix && qp_n)) {
> > +            ret = -EINVAL;
> > +            goto out;
> > +        }
> > +     }
> > +
> > +    uri_server = g_uri_get_host(uri);
> > +    if (uri_server && !uri_server[0]) {
> > +        uri_server = NULL;
> >      }
> > +    uri_port = g_uri_get_port(uri);
> >  
> >      if (is_unix) {
> >          /* nbd+unix:///export?socket=path */
> > -        if (uri->server || uri->port || strcmp(qp->p[0].name, "socket")) {
> > +        const char *uri_socket = g_hash_table_lookup(qp, "socket");
> > +        if (uri_server || uri_port != -1 || !uri_socket) {
> >              ret = -EINVAL;
> >              goto out;
> >          }
> >          qdict_put_str(options, "server.type", "unix");
> > -        qdict_put_str(options, "server.path", qp->p[0].value);
> > +        qdict_put_str(options, "server.path", uri_socket);
> >      } else {
> > -        QString *host;
> >          char *port_str;
> >  
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
> >          g_free(port_str);
> >      }
> >  
> >  out:
> >      if (qp) {
> > -        query_params_free(qp);
> > +        g_hash_table_destroy(qp);
> >      }
> > -    uri_free(uri);
> > +    g_uri_unref(uri);
> >      return ret;
> >  }
> 
> Looks ok,
>
> Reviewed-by: Richard W.M. Jones <rjones@redhat.com>

Or maybe not.  This caused a regression in the nbdkit test suite (when
we use qemu-img from 9.1).  It seems the exportname part of the NBD
URI gets munged:

https://gitlab.com/qemu-project/qemu/-/issues/2584

Rich.

-- 
Richard Jones, Virtualization Group, Red Hat http://people.redhat.com/~rjones
Read my programming and virtualization blog: http://rwmj.wordpress.com
virt-builder quickly builds VMs from scratch
http://libguestfs.org/virt-builder.1.html


