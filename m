Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 43553C54E64
	for <qemu-devel@archiver.kernel.org>; Thu, 28 Mar 2024 14:15:37 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rpqX9-0004St-P8; Thu, 28 Mar 2024 10:15:11 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <rjones@redhat.com>) id 1rpqX5-0004SE-SX
 for qemu-devel@nongnu.org; Thu, 28 Mar 2024 10:15:07 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <rjones@redhat.com>) id 1rpqX3-0006N6-NB
 for qemu-devel@nongnu.org; Thu, 28 Mar 2024 10:15:07 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1711635301;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=ssMdxe1PH6J45QRdAFkqR8C00tEds9hxP4uhOvnXS0s=;
 b=IbaRZqDbXPSprHuD1uzA3OHmkcELJDsszYXZS0m4Wn28dMVvn8SmiLcL3vF7UyAXyP6ufc
 m0JOLokVyRqs8neLPYf5UHDAehm8tTKj3dNc+LL644DK5XJxGB1TA+Fi65ZRldDOQ1N2E3
 PBW/Na2CbZkOkEKKXzXKUQnjUWs0ehE=
Received: from mimecast-mx02.redhat.com (mimecast-mx02.redhat.com
 [66.187.233.88]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-190-sl0YDYT5PvaDna4dnvfsKg-1; Thu, 28 Mar 2024 10:13:47 -0400
X-MC-Unique: sl0YDYT5PvaDna4dnvfsKg-1
Received: from smtp.corp.redhat.com (int-mx06.intmail.prod.int.rdu2.redhat.com
 [10.11.54.6])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 0B853101A586;
 Thu, 28 Mar 2024 14:13:47 +0000 (UTC)
Received: from localhost (unknown [10.42.28.11])
 by smtp.corp.redhat.com (Postfix) with ESMTP id A74E52166B36;
 Thu, 28 Mar 2024 14:13:46 +0000 (UTC)
Date: Thu, 28 Mar 2024 14:13:42 +0000
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
Message-ID: <20240328141342.GK7636@redhat.com>
References: <20240328140607.2433889-1-thuth@redhat.com>
 <20240328140607.2433889-7-thuth@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240328140607.2433889-7-thuth@redhat.com>
User-Agent: Mutt/1.5.21 (2010-09-15)
X-Scanned-By: MIMEDefang 3.4.1 on 10.11.54.6
Received-SPF: pass client-ip=170.10.129.124; envelope-from=rjones@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -21
X-Spam_score: -2.2
X-Spam_bar: --
X-Spam_report: (-2.2 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.08,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H4=0.001, RCVD_IN_MSPIKE_WL=0.001,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001 autolearn=unavailable autolearn_force=no
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

On Thu, Mar 28, 2024 at 03:06:03PM +0100, Thomas Huth wrote:
> Since version 2.66, glib has useful URI parsing functions, too.
> Use those instead of the QEMU-internal ones to be finally able
> to get rid of the latter. The g_uri_get_host() also takes care
> of removing the square brackets from IPv6 addresses, so we can
> drop that part of the QEMU code now, too.
> 
> Signed-off-by: Thomas Huth <thuth@redhat.com>
> ---
>  block/nbd.c | 66 ++++++++++++++++++++++++++++++-----------------------
>  1 file changed, 38 insertions(+), 28 deletions(-)
> 
> diff --git a/block/nbd.c b/block/nbd.c
> index ef05f7cdfd..95b507f872 100644
> --- a/block/nbd.c
> +++ b/block/nbd.c
> @@ -31,7 +31,6 @@
>  #include "qemu/osdep.h"
>  
>  #include "trace.h"
> -#include "qemu/uri.h"
>  #include "qemu/option.h"
>  #include "qemu/cutils.h"
>  #include "qemu/main-loop.h"
> @@ -1514,30 +1513,34 @@ static void nbd_client_close(BlockDriverState *bs)
>  
>  static int nbd_parse_uri(const char *filename, QDict *options)
>  {
> -    URI *uri;
> +    GUri *uri;
>      const char *p;
> -    QueryParams *qp = NULL;
> +    GHashTable *qp = NULL;
> +    int qp_n;
>      int ret = 0;
>      bool is_unix;
> +    const char *uri_scheme, *uri_query, *uri_server;
> +    int uri_port;
>  
> -    uri = uri_parse(filename);
> +    uri = g_uri_parse(filename, G_URI_FLAGS_NONE, NULL);
>      if (!uri) {
>          return -EINVAL;
>      }
>  
>      /* transport */
> -    if (!g_strcmp0(uri->scheme, "nbd")) {
> +    uri_scheme = g_uri_get_scheme(uri);
> +    if (!g_strcmp0(uri_scheme, "nbd")) {
>          is_unix = false;
> -    } else if (!g_strcmp0(uri->scheme, "nbd+tcp")) {
> +    } else if (!g_strcmp0(uri_scheme, "nbd+tcp")) {
>          is_unix = false;
> -    } else if (!g_strcmp0(uri->scheme, "nbd+unix")) {
> +    } else if (!g_strcmp0(uri_scheme, "nbd+unix")) {
>          is_unix = true;
>      } else {
>          ret = -EINVAL;
>          goto out;
>      }
>  
> -    p = uri->path ? uri->path : "";
> +    p = g_uri_get_path(uri) ?: "";
>      if (p[0] == '/') {
>          p++;
>      }
> @@ -1545,51 +1548,58 @@ static int nbd_parse_uri(const char *filename, QDict *options)
>          qdict_put_str(options, "export", p);
>      }
>  
> -    qp = query_params_parse(uri->query);
> -    if (qp->n > 1 || (is_unix && !qp->n) || (!is_unix && qp->n)) {
> -        ret = -EINVAL;
> -        goto out;
> +    uri_query = g_uri_get_query(uri);
> +    if (uri_query) {
> +        qp = g_uri_parse_params(uri_query, -1, "&", G_URI_PARAMS_NONE, NULL);
> +        if (!qp) {
> +            ret = -EINVAL;
> +            goto out;
> +        }
> +        qp_n = g_hash_table_size(qp);
> +        if (qp_n > 1 || (is_unix && !qp_n) || (!is_unix && qp_n)) {
> +            ret = -EINVAL;
> +            goto out;
> +        }
> +     }
> +
> +    uri_server = g_uri_get_host(uri);
> +    if (uri_server && !uri_server[0]) {
> +        uri_server = NULL;
>      }
> +    uri_port = g_uri_get_port(uri);
>  
>      if (is_unix) {
>          /* nbd+unix:///export?socket=path */
> -        if (uri->server || uri->port || strcmp(qp->p[0].name, "socket")) {
> +        const char *uri_socket = g_hash_table_lookup(qp, "socket");
> +        if (uri_server || uri_port != -1 || !uri_socket) {
>              ret = -EINVAL;
>              goto out;
>          }
>          qdict_put_str(options, "server.type", "unix");
> -        qdict_put_str(options, "server.path", qp->p[0].value);
> +        qdict_put_str(options, "server.path", uri_socket);
>      } else {
> -        QString *host;
>          char *port_str;
>  
>          /* nbd[+tcp]://host[:port]/export */
> -        if (!uri->server) {
> +        if (!uri_server) {
>              ret = -EINVAL;
>              goto out;
>          }
>  
> -        /* strip braces from literal IPv6 address */
> -        if (uri->server[0] == '[') {
> -            host = qstring_from_substr(uri->server, 1,
> -                                       strlen(uri->server) - 1);
> -        } else {
> -            host = qstring_from_str(uri->server);
> -        }
> -
>          qdict_put_str(options, "server.type", "inet");
> -        qdict_put(options, "server.host", host);
> +        qdict_put_str(options, "server.host", uri_server);
>  
> -        port_str = g_strdup_printf("%d", uri->port ?: NBD_DEFAULT_PORT);
> +        port_str = g_strdup_printf("%d", uri_port != -1 ? uri_port
> +                                                        : NBD_DEFAULT_PORT);
>          qdict_put_str(options, "server.port", port_str);
>          g_free(port_str);
>      }
>  
>  out:
>      if (qp) {
> -        query_params_free(qp);
> +        g_hash_table_destroy(qp);
>      }
> -    uri_free(uri);
> +    g_uri_unref(uri);
>      return ret;
>  }

Looks ok,

Reviewed-by: Richard W.M. Jones <rjones@redhat.com>

-- 
Richard Jones, Virtualization Group, Red Hat http://people.redhat.com/~rjones
Read my programming and virtualization blog: http://rwmj.wordpress.com
libguestfs lets you edit virtual machines.  Supports shell scripting,
bindings from many languages.  http://libguestfs.org


