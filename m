Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3B8AEC4345F
	for <qemu-devel@archiver.kernel.org>; Fri, 12 Apr 2024 14:51:04 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rvIEL-0005d2-7m; Fri, 12 Apr 2024 10:50:17 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <eblake@redhat.com>) id 1rvIEJ-0005cL-Kx
 for qemu-devel@nongnu.org; Fri, 12 Apr 2024 10:50:15 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <eblake@redhat.com>) id 1rvIEF-0007fy-1y
 for qemu-devel@nongnu.org; Fri, 12 Apr 2024 10:50:15 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1712933409;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=tlzaI3X+TCvek5bdpvQAsE8tR52w3uU36PZpuszVklk=;
 b=LyxD8p3PvXehznCETkgRfprdYFs7Y3XHi92j2x9W3VOJ8RaQyLXC/+XoxVzfk5w/xM5aKH
 t1zJEgliUnkBsMLBWiHm8MfOiTdZwFdSOFYKrbCiZJa6eyP9676xNqsLvFtqtW3kvshm1X
 sbdrOZI3ROtAG6mrdMMT32kCcLQP1F0=
Received: from mimecast-mx02.redhat.com (mx-ext.redhat.com [66.187.233.73])
 by relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-45--YppUKWSOsOJ_HLJFARRow-1; Fri,
 12 Apr 2024 10:50:07 -0400
X-MC-Unique: -YppUKWSOsOJ_HLJFARRow-1
Received: from smtp.corp.redhat.com (int-mx07.intmail.prod.int.rdu2.redhat.com
 [10.11.54.7])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 859A928EC11A;
 Fri, 12 Apr 2024 14:50:06 +0000 (UTC)
Received: from redhat.com (unknown [10.2.16.15])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id EA84E1C060D0;
 Fri, 12 Apr 2024 14:50:04 +0000 (UTC)
Date: Fri, 12 Apr 2024 09:49:59 -0500
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
Subject: Re: [PATCH v2 11/13] block/nfs: Use URI parsing code from glib
Message-ID: <sz2dc3vlpyz6mhqytunrqnq3clw6yhpymoqpfqtrlj4boshuhx@irddit7sx7in>
References: <20240412132415.282354-1-thuth@redhat.com>
 <20240412132415.282354-12-thuth@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240412132415.282354-12-thuth@redhat.com>
User-Agent: NeoMutt/20240201
X-Scanned-By: MIMEDefang 3.4.1 on 10.11.54.7
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

On Fri, Apr 12, 2024 at 03:24:13PM +0200, Thomas Huth wrote:
> Since version 2.66, glib has useful URI parsing functions, too.
> Use those instead of the QEMU-internal ones to be finally able
> to get rid of the latter.
> 
> Signed-off-by: Thomas Huth <thuth@redhat.com>
> ---
>  block/nfs.c | 110 ++++++++++++++++++++++++++--------------------------
>  1 file changed, 54 insertions(+), 56 deletions(-)
> 

>      }
> -    if (g_strcmp0(uri->scheme, "nfs") != 0) {
> +    if (!g_str_equal(g_uri_get_scheme(uri), "nfs")) {

Another case where we should be considering whether g_ascii_strcasecmp
is better, as a separate patch.

> -    for (i = 0; i < qp->n; i++) {
> -        uint64_t val;
> -        if (!qp->p[i].value) {
> -            error_setg(errp, "Value for NFS parameter expected: %s",
> -                       qp->p[i].name);
> -            goto out;
> -        }
> -        if (parse_uint_full(qp->p[i].value, 0, &val)) {
> -            error_setg(errp, "Illegal value for NFS parameter: %s",

Pre-existing,...

> +
> +    uri_query = g_uri_get_query(uri);
> +    if (uri_query) {
> +        g_uri_params_iter_init(&qp, uri_query, -1, "&", G_URI_PARAMS_NONE);
> +        while (g_uri_params_iter_next(&qp, &qp_name, &qp_value, &gerror)) {
> +            uint64_t val;
> +            if (!qp_name || gerror) {
> +                error_setg(errp, "Failed to parse NFS parameter");
> +                return -EINVAL;
> +            }
> +            if (!qp_value) {
> +                error_setg(errp, "Value for NFS parameter expected: %s",
> +                           qp_name);
> +                return -EINVAL;
> +            }
> +            if (parse_uint_full(qp_value, 0, &val)) {
> +                error_setg(errp, "Illegal value for NFS parameter: %s",

...but since we're touching it, I prefer 'Invalid' over 'Illegal' (any
error message implying that you broke a law when you passed in bad
data is a bit aggressive).  Not a show-stopper to leave it alone.

Reviewed-by: Eric Blake <eblake@redhat.com>

-- 
Eric Blake, Principal Software Engineer
Red Hat, Inc.
Virtualization:  qemu.org | libguestfs.org


