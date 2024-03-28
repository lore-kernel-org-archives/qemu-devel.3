Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 281C2CD1284
	for <qemu-devel@archiver.kernel.org>; Thu, 28 Mar 2024 14:55:47 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rpr9m-00070c-2b; Thu, 28 Mar 2024 10:55:06 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <eblake@redhat.com>) id 1rpr9k-00070O-Dz
 for qemu-devel@nongnu.org; Thu, 28 Mar 2024 10:55:04 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <eblake@redhat.com>) id 1rpr9i-0006sA-Gw
 for qemu-devel@nongnu.org; Thu, 28 Mar 2024 10:55:04 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1711637701;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=jRMhNMqOPc1tie1NOrKJ0posFxA/reBMxJjV0VlyOo8=;
 b=Tsrl+i4oMTb48pOxMfBGvIwnF06JDfWo7A41CwNr+Pa8Vt60FjgJBDXYHpDR/iVAAxwW7g
 Qvis29BF/bzO0xFjGk5JcX3FmVcZ/XqjoQgL1ugcNqZ8juy3bGPctuUhu6V93MnyElaLWj
 JT2p8GDUMmQfQOo2Vx3KRCDZRFigx1I=
Received: from mimecast-mx02.redhat.com (mimecast-mx02.redhat.com
 [66.187.233.88]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-458-EUphBQEDMqqUPg7DNG6X3w-1; Thu, 28 Mar 2024 10:54:57 -0400
X-MC-Unique: EUphBQEDMqqUPg7DNG6X3w-1
Received: from smtp.corp.redhat.com (int-mx06.intmail.prod.int.rdu2.redhat.com
 [10.11.54.6])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mimecast-mx02.redhat.com (Postfix) with ESMTPS id C9DF588FA23;
 Thu, 28 Mar 2024 14:54:56 +0000 (UTC)
Received: from redhat.com (unknown [10.2.16.33])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id 1AE482166B36;
 Thu, 28 Mar 2024 14:54:55 +0000 (UTC)
Date: Thu, 28 Mar 2024 09:54:49 -0500
From: Eric Blake <eblake@redhat.com>
To: Thomas Huth <thuth@redhat.com>
Cc: Alex =?utf-8?Q?Benn=C3=A9e?= <alex.bennee@linaro.org>, 
 Philippe =?utf-8?Q?Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Vladimir Sementsov-Ogievskiy <vsementsov@yandex-team.ru>, 
 Peter Lieven <pl@kamp.de>, "Richard W.M. Jones" <rjones@redhat.com>,
 qemu-devel@nongnu.org, 
 Kevin Wolf <kwolf@redhat.com>, Hanna Reitz <hreitz@redhat.com>, 
 Paolo Bonzini <pbonzini@redhat.com>,
 Daniel =?utf-8?B?UC4gQmVycmFuZ8Op?= <berrange@redhat.com>, 
 Konstantin Kostiuk <kkostiuk@redhat.com>, qemu-block@nongnu.org
Subject: Re: [PATCH for-9.1 6/9] block/nbd: Use URI parsing code from glib
Message-ID: <sv4rp7w2cnjy5xykp4t3w5gf3zwnohe5eso422whl2ux2ofixa@xwjphousol77>
References: <20240328140607.2433889-1-thuth@redhat.com>
 <20240328140607.2433889-7-thuth@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240328140607.2433889-7-thuth@redhat.com>
User-Agent: NeoMutt/20240201
X-Scanned-By: MIMEDefang 3.4.1 on 10.11.54.6
Received-SPF: pass client-ip=170.10.133.124; envelope-from=eblake@redhat.com;
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

Is it worth using 'g_autoptr(GUri) uri = NULL;' here, to simplify cleanup later?

>      const char *p;
> -    QueryParams *qp = NULL;
> +    GHashTable *qp = NULL;

Presumably would be easier if qp is also auto-free.

> +    int qp_n;
>      int ret = 0;
>      bool is_unix;
> +    const char *uri_scheme, *uri_query, *uri_server;
> +    int uri_port;
>  
> -    uri = uri_parse(filename);
> +    uri = g_uri_parse(filename, G_URI_FLAGS_NONE, NULL);

The glib API is fairly close to what we have in qemu, making this a
nice switchover.

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

If a user requests nbd://hostname:0/export, this now sets server.port
to "0" instead of "10809".  Is that an intentional change?  No one
actually passes an explicit ":0" port on purpose, but we do have to
worry about malicious URIs.

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

It may be possible to eliminate the out label altogether, if
GHashTable has the appropriate auto-free magic.

-- 
Eric Blake, Principal Software Engineer
Red Hat, Inc.
Virtualization:  qemu.org | libguestfs.org


