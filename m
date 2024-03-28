Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A55BFC54E67
	for <qemu-devel@archiver.kernel.org>; Thu, 28 Mar 2024 14:15:52 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rpqXD-0004Tx-OY; Thu, 28 Mar 2024 10:15:15 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <rjones@redhat.com>) id 1rpqXC-0004TF-10
 for qemu-devel@nongnu.org; Thu, 28 Mar 2024 10:15:14 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <rjones@redhat.com>) id 1rpqXA-0006bV-50
 for qemu-devel@nongnu.org; Thu, 28 Mar 2024 10:15:13 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1711635311;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=E7xgjmBepeGrdIT7bUu2r3sXn+Q8uxkiryuqlev9UPc=;
 b=PORPtF05AP1ohVIqDwZlUPNJBqymCKrR+N6NJ2JagO8Cg0ubvD60o24ZdDgK/PFl3LCMMi
 BKg9gZaJb3WYSWNHLRuWR0j/I0lhIeBq4beMOb04Ly63TyZmjlVdPbAWCEBZsIlYDpUxCE
 B2iSYv+mWRBN9TrJgeevziturJLwnOI=
Received: from mimecast-mx02.redhat.com (mimecast-mx02.redhat.com
 [66.187.233.88]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-647-D64XcC7AOOOj6-uQ7DKcrg-1; Thu, 28 Mar 2024 10:15:06 -0400
X-MC-Unique: D64XcC7AOOOj6-uQ7DKcrg-1
Received: from smtp.corp.redhat.com (int-mx04.intmail.prod.int.rdu2.redhat.com
 [10.11.54.4])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 37F1A101A526;
 Thu, 28 Mar 2024 14:15:06 +0000 (UTC)
Received: from localhost (unknown [10.42.28.11])
 by smtp.corp.redhat.com (Postfix) with ESMTP id 027402024517;
 Thu, 28 Mar 2024 14:15:05 +0000 (UTC)
Date: Thu, 28 Mar 2024 14:15:01 +0000
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
Subject: Re: [PATCH for-9.1 8/9] block/ssh: Use URI parsing code from glib
Message-ID: <20240328141501.GL7636@redhat.com>
References: <20240328140607.2433889-1-thuth@redhat.com>
 <20240328140607.2433889-9-thuth@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240328140607.2433889-9-thuth@redhat.com>
User-Agent: Mutt/1.5.21 (2010-09-15)
X-Scanned-By: MIMEDefang 3.4.1 on 10.11.54.4
Received-SPF: pass client-ip=170.10.129.124; envelope-from=rjones@redhat.com;
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
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org

On Thu, Mar 28, 2024 at 03:06:05PM +0100, Thomas Huth wrote:
> Since version 2.66, glib has useful URI parsing functions, too.
> Use those instead of the QEMU-internal ones to be finally able
> to get rid of the latter.
> 
> Signed-off-by: Thomas Huth <thuth@redhat.com>
> ---
>  block/ssh.c | 69 +++++++++++++++++++++++++++++++----------------------
>  1 file changed, 40 insertions(+), 29 deletions(-)
> 
> diff --git a/block/ssh.c b/block/ssh.c
> index 2748253d4a..c0caf59793 100644
> --- a/block/ssh.c
> +++ b/block/ssh.c
> @@ -37,7 +37,6 @@
>  #include "qemu/ctype.h"
>  #include "qemu/cutils.h"
>  #include "qemu/sockets.h"
> -#include "qemu/uri.h"
>  #include "qapi/qapi-visit-sockets.h"
>  #include "qapi/qapi-visit-block-core.h"
>  #include "qapi/qmp/qdict.h"
> @@ -181,64 +180,76 @@ static void sftp_error_trace(BDRVSSHState *s, const char *op)
>  
>  static int parse_uri(const char *filename, QDict *options, Error **errp)
>  {
> -    URI *uri = NULL;
> -    QueryParams *qp;
> +    GUri *uri;
> +    const char *uri_host, *uri_path, *uri_user, *uri_query;
>      char *port_str;
> -    int i;
> +    int port;
> +    g_autoptr(GError) gerror = NULL;
> +    char *qp_name, *qp_value;
> +    GUriParamsIter qp;
>  
> -    uri = uri_parse(filename);
> +    uri = g_uri_parse(filename, G_URI_FLAGS_NONE, NULL);
>      if (!uri) {
>          return -EINVAL;
>      }
>  
> -    if (g_strcmp0(uri->scheme, "ssh") != 0) {
> +    if (g_strcmp0(g_uri_get_scheme(uri), "ssh") != 0) {
>          error_setg(errp, "URI scheme must be 'ssh'");
>          goto err;
>      }
>  
> -    if (!uri->server || strcmp(uri->server, "") == 0) {
> +    uri_host = g_uri_get_host(uri);
> +    if (!uri_host || g_str_equal(uri_host, "")) {
>          error_setg(errp, "missing hostname in URI");
>          goto err;
>      }
>  
> -    if (!uri->path || strcmp(uri->path, "") == 0) {
> +    uri_path = g_uri_get_path(uri);
> +    if (!uri_path || g_str_equal(uri_path, "")) {
>          error_setg(errp, "missing remote path in URI");
>          goto err;
>      }
>  
> -    qp = query_params_parse(uri->query);
> -    if (!qp) {
> -        error_setg(errp, "could not parse query parameters");
> -        goto err;
> -    }
> -
> -    if(uri->user && strcmp(uri->user, "") != 0) {
> -        qdict_put_str(options, "user", uri->user);
> +    uri_user = g_uri_get_user(uri);
> +    if (uri_user && !g_str_equal(uri_user, "")) {
> +        qdict_put_str(options, "user", uri_user);
>      }
>  
> -    qdict_put_str(options, "server.host", uri->server);
> +    qdict_put_str(options, "server.host", uri_host);
>  
> -    port_str = g_strdup_printf("%d", uri->port ?: 22);
> +    port = g_uri_get_port(uri);
> +    port_str = g_strdup_printf("%d", port != -1 ? port : 22);
>      qdict_put_str(options, "server.port", port_str);
>      g_free(port_str);
>  
> -    qdict_put_str(options, "path", uri->path);
> -
> -    /* Pick out any query parameters that we understand, and ignore
> -     * the rest.
> -     */
> -    for (i = 0; i < qp->n; ++i) {
> -        if (strcmp(qp->p[i].name, "host_key_check") == 0) {
> -            qdict_put_str(options, "host_key_check", qp->p[i].value);
> +    qdict_put_str(options, "path", uri_path);
> +
> +    uri_query = g_uri_get_query(uri);
> +    if (uri_query) {
> +        g_uri_params_iter_init(&qp, uri_query, -1, "&", G_URI_PARAMS_NONE);
> +        while (g_uri_params_iter_next(&qp, &qp_name, &qp_value, &gerror)) {
> +            if (!qp_name || !qp_value || gerror) {
> +                warn_report("Failed to parse SSH URI parameters '%s'.",
> +                            uri_query);
> +                break;
> +            }
> +            /*
> +             * Pick out the query parameters that we understand, and ignore
> +             * (or rather warn about) the rest.
> +             */
> +            if (g_str_equal(qp_name, "host_key_check")) {
> +                qdict_put_str(options, "host_key_check", qp_value);
> +            } else {
> +                warn_report("Unsupported parameter '%s' in URI.", qp_name);
> +            }
>          }
>      }
>  
> -    query_params_free(qp);
> -    uri_free(uri);
> +    g_uri_unref(uri);
>      return 0;
>  
>   err:
> -    uri_free(uri);
> +    g_uri_unref(uri);
>      return -EINVAL;
>  }

Seems reasonable too,

Reviewed-by: Richard W.M. Jones <rjones@redhat.com>


-- 
Richard Jones, Virtualization Group, Red Hat http://people.redhat.com/~rjones
Read my programming and virtualization blog: http://rwmj.wordpress.com
virt-p2v converts physical machines to virtual machines.  Boot with a
live CD or over the network (PXE) and turn machines into KVM guests.
http://libguestfs.org/virt-v2v


