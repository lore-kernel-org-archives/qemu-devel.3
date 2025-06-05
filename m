Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 16EB1C5B543
	for <qemu-devel@archiver.kernel.org>; Thu,  5 Jun 2025 11:55:04 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uN9BP-0001Dq-Of; Thu, 05 Jun 2025 07:54:55 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <armbru@redhat.com>) id 1uN9BK-0001Cl-AX
 for qemu-devel@nongnu.org; Thu, 05 Jun 2025 07:54:50 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <armbru@redhat.com>) id 1uN9BH-0002XP-Mp
 for qemu-devel@nongnu.org; Thu, 05 Jun 2025 07:54:48 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1749124485;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=XbTwA2XDwQCmpFRnsp1i9Gg2vM+jgWyISIwW68MnhHU=;
 b=VQC291iT1vK1eF29txXQ52/sQwhs8kgtJrzFT4CecoQyhm7dEFiyc5PkXV3P9/KIkC8+8P
 63aGfOHcPm3Dwx5ELf/9BUBrWJ8Nh+JYqeHVGvs25psKnVIHM4uNOMRirEbYLPoZcdtJI/
 PIGtaDWnD4FjAYzyV8EzpWAE0zAfs6c=
Received: from mx-prod-mc-06.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-35-165-154-97.us-west-2.compute.amazonaws.com [35.165.154.97]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-302-5i3hnXjQOaCuEMR1AxiZQA-1; Thu,
 05 Jun 2025 07:54:44 -0400
X-MC-Unique: 5i3hnXjQOaCuEMR1AxiZQA-1
X-Mimecast-MFC-AGG-ID: 5i3hnXjQOaCuEMR1AxiZQA_1749124483
Received: from mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.17])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-06.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 21AA018002B3; Thu,  5 Jun 2025 11:54:43 +0000 (UTC)
Received: from blackfin.pond.sub.org (unknown [10.45.242.38])
 by mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 80C4B1956094; Thu,  5 Jun 2025 11:54:42 +0000 (UTC)
Received: by blackfin.pond.sub.org (Postfix, from userid 1000)
 id DC4E521E6757; Thu, 05 Jun 2025 13:54:39 +0200 (CEST)
From: Markus Armbruster <armbru@redhat.com>
To: Paolo Bonzini <pbonzini@redhat.com>
Cc: qemu-devel@nongnu.org,  armbru@redhat.com,  zhao1.liu@intel.com,
 qemu-rust@nongnu.org
Subject: Re: [PATCH 04/14] util/error: allow non-NUL-terminated err->src
In-Reply-To: <20250605101544.368953-5-pbonzini@redhat.com> (Paolo Bonzini's
 message of "Thu, 5 Jun 2025 12:15:33 +0200")
References: <20250605101544.368953-1-pbonzini@redhat.com>
 <20250605101544.368953-5-pbonzini@redhat.com>
Date: Thu, 05 Jun 2025 13:54:39 +0200
Message-ID: <87a56mh08w.fsf@pond.sub.org>
User-Agent: Gnus/5.13 (Gnus v5.13)
MIME-Version: 1.0
Content-Type: text/plain
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.17
Received-SPF: pass client-ip=170.10.133.124; envelope-from=armbru@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -21
X-Spam_score: -2.2
X-Spam_bar: --
X-Spam_report: (-2.2 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.132,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H5=0.001, RCVD_IN_MSPIKE_WL=0.001,
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

Paolo Bonzini <pbonzini@redhat.com> writes:

> Rust makes the current file available as a statically-allocated string,
> but without a NUL terminator.  Allow this by storing an optional maximum
> length in the Error.
>
> Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>
> ---
>  include/qapi/error-internal.h | 9 ++++++++-
>  util/error.c                  | 5 +++--
>  2 files changed, 11 insertions(+), 3 deletions(-)
>
> diff --git a/include/qapi/error-internal.h b/include/qapi/error-internal.h
> index d5c3904adec..1ec3ceb40f0 100644
> --- a/include/qapi/error-internal.h
> +++ b/include/qapi/error-internal.h
> @@ -18,7 +18,14 @@ struct Error
>  {
>      char *msg;
>      ErrorClass err_class;
> -    const char *src, *func;
> +    const char *func;
> +
> +    /*
> +     * src might be NUL-terminated or not.  If it is, src_len is negative.
> +     * If it is not, src_len is the length.
> +     */

I habitually prefix identifiers with @ in comments, like this:

       /*
        * @src might be NUL-terminated or not.  If it is, @src_len is
        * negative.  If it is not, @src_len is the length.
        */

Can really help readability when identifiers are also common English
words.  Not much of a difference here.  Still nice for consistency with
error.h.

> +    const char *src;
> +    int src_len;
>      int line;
>      GString *hint;
>  };
> diff --git a/util/error.c b/util/error.c
> index e5bcb7c0225..3449ecc0b92 100644
> --- a/util/error.c
> +++ b/util/error.c
> @@ -24,8 +24,8 @@ Error *error_warn;
>  static void error_handle(Error **errp, Error *err)
>  {
>      if (errp == &error_abort) {
> -        fprintf(stderr, "Unexpected error in %s() at %s:%d:\n",
> -                err->func, err->src, err->line);
> +        fprintf(stderr, "Unexpected error in %s() at %.*s:%d:\n",
> +                err->func, err->src_len, err->src, err->line);
>          error_report("%s", error_get_pretty(err));
>          if (err->hint) {
>              error_printf("%s", err->hint->str);
> @@ -67,6 +67,7 @@ static void error_setv(Error **errp,
>          g_free(msg);
>      }
>      err->err_class = err_class;
> +    err->src_len = -1;
>      err->src = src;
>      err->line = line;
>      err->func = func;


