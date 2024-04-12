Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0BCD9C4345F
	for <qemu-devel@archiver.kernel.org>; Fri, 12 Apr 2024 14:57:15 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rvIKl-0008FP-K9; Fri, 12 Apr 2024 10:56:55 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <eblake@redhat.com>) id 1rvIKk-0008FA-27
 for qemu-devel@nongnu.org; Fri, 12 Apr 2024 10:56:54 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <eblake@redhat.com>) id 1rvIKi-0000Fm-Gm
 for qemu-devel@nongnu.org; Fri, 12 Apr 2024 10:56:53 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1712933811;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=QtvpYcxs46xucWkwjyfLDsyOServLHRcfz3UgnxKiRk=;
 b=cNV0npqvXzsNCuYOo5LbeVH7/EiRe5vcmMKn93KJ/n/m2fHzvcEU1ajtxEgljwwL88ZnCC
 Ua5syd6clNysMK8ia1lqVvjrsUEe/QOn2UfgQrQWPVHPh8QUIVM2FuOPpJi2T9V4bdDqmW
 N7jlfrv78QNIRFbJ8pLtjCIKKz6R9vw=
Received: from mimecast-mx02.redhat.com (mx-ext.redhat.com [66.187.233.73])
 by relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-647-pgWlwWdVO6-ij8Yt0sEyPg-1; Fri,
 12 Apr 2024 10:56:48 -0400
X-MC-Unique: pgWlwWdVO6-ij8Yt0sEyPg-1
Received: from smtp.corp.redhat.com (int-mx08.intmail.prod.int.rdu2.redhat.com
 [10.11.54.8])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mimecast-mx02.redhat.com (Postfix) with ESMTPS id F12811C0AF58;
 Fri, 12 Apr 2024 14:56:47 +0000 (UTC)
Received: from redhat.com (unknown [10.2.16.15])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id 317E1C13FA0;
 Fri, 12 Apr 2024 14:56:46 +0000 (UTC)
Date: Fri, 12 Apr 2024 09:56:40 -0500
From: Eric Blake <eblake@redhat.com>
To: Thomas Huth <thuth@redhat.com>
Cc: Alex =?utf-8?Q?Benn=C3=A9e?= <alex.bennee@linaro.org>, 
 Philippe =?utf-8?Q?Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Vladimir Sementsov-Ogievskiy <vsementsov@yandex-team.ru>, 
 Peter Lieven <pl@kamp.de>, "Richard W.M. Jones" <rjones@redhat.com>, 
 Paolo Bonzini <pbonzini@redhat.com>, qemu-devel@nongnu.org,
 Kevin Wolf <kwolf@redhat.com>, Hanna Reitz <hreitz@redhat.com>,
 Daniel =?utf-8?B?UC4gQmVycmFuZ8Op?= <berrange@redhat.com>, 
 Konstantin Kostiuk <kkostiuk@redhat.com>, qemu-block@nongnu.org
Subject: Re: [PATCH v2 12/13] block/ssh: Use URI parsing code from glib
Message-ID: <fxncshsyb5bnknswy2wkpr6l32adiy5hz6smd42o5eyomezz2k@twgbjztfubps>
References: <20240412132415.282354-1-thuth@redhat.com>
 <20240412132415.282354-13-thuth@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240412132415.282354-13-thuth@redhat.com>
User-Agent: NeoMutt/20240201
X-Scanned-By: MIMEDefang 3.4.1 on 10.11.54.8
Received-SPF: pass client-ip=170.10.129.124; envelope-from=eblake@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -41
X-Spam_score: -4.2
X-Spam_bar: ----
X-Spam_report: (-4.2 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-2.103,
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

On Fri, Apr 12, 2024 at 03:24:14PM +0200, Thomas Huth wrote:
> Since version 2.66, glib has useful URI parsing functions, too.
> Use those instead of the QEMU-internal ones to be finally able
> to get rid of the latter.
> 
> Reviewed-by: Richard W.M. Jones <rjones@redhat.com>
> Signed-off-by: Thomas Huth <thuth@redhat.com>
> ---
>  block/ssh.c | 75 ++++++++++++++++++++++++++++-------------------------
>  1 file changed, 40 insertions(+), 35 deletions(-)
> 

>  
> -    if (g_strcmp0(uri->scheme, "ssh") != 0) {
> +    if (g_strcmp0(g_uri_get_scheme(uri), "ssh") != 0) {

Yet another case-sensitive spot to consider.

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

Do we want the trailing '.' in warn_report?

The warning is new; it was not in the old code, nor mentioned in the
commit message.  It seems like a good idea, but we should be more
intentional if we intend to make that change.

-- 
Eric Blake, Principal Software Engineer
Red Hat, Inc.
Virtualization:  qemu.org | libguestfs.org


