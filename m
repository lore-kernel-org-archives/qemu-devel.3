Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5DAEDC54FB3
	for <qemu-devel@archiver.kernel.org>; Mon,  2 Jun 2025 10:47:46 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uM2hP-0003Bh-As; Mon, 02 Jun 2025 06:47:23 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <armbru@redhat.com>) id 1uM2hM-00039q-MG
 for qemu-devel@nongnu.org; Mon, 02 Jun 2025 06:47:20 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <armbru@redhat.com>) id 1uM2hK-00004r-T3
 for qemu-devel@nongnu.org; Mon, 02 Jun 2025 06:47:20 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1748861237;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=ZNOZV4SF2jwGyHGdvtD7zvzaKkwIXZBSN8hM7F2iFiY=;
 b=F1znnKg/oRYNxUL0UDaYsRAbzTTfm9vz7SYGje0ToPRkugKMQJUpOF+3bqCXDE94CLtHRm
 6W+IeNfRm/TxRLv4Th4mBJMV7g6p0HVNhJ4KzGzD/B65X0fe9qdMBaE+ElhWZE7BTeOEre
 zfRlawQtI7W7VR7e3pUrch6A0w3ZAT8=
Received: from mx-prod-mc-02.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-35-KUW24mnZOqasi0PY5TVNJQ-1; Mon,
 02 Jun 2025 06:47:16 -0400
X-MC-Unique: KUW24mnZOqasi0PY5TVNJQ-1
X-Mimecast-MFC-AGG-ID: KUW24mnZOqasi0PY5TVNJQ_1748861235
Received: from mx-prod-int-04.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-04.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.40])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-02.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 15374195609E; Mon,  2 Jun 2025 10:47:15 +0000 (UTC)
Received: from blackfin.pond.sub.org (unknown [10.45.242.38])
 by mx-prod-int-04.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 92B6D1955F2C; Mon,  2 Jun 2025 10:47:14 +0000 (UTC)
Received: by blackfin.pond.sub.org (Postfix, from userid 1000)
 id F342521E66C3; Mon, 02 Jun 2025 12:47:11 +0200 (CEST)
From: Markus Armbruster <armbru@redhat.com>
To: Paolo Bonzini <pbonzini@redhat.com>
Cc: qemu-devel@nongnu.org,  qemu-rust@nongnu.org
Subject: Re: [PATCH 04/14] util/error: allow non-NUL-terminated err->src
In-Reply-To: <20250530080307.2055502-5-pbonzini@redhat.com> (Paolo Bonzini's
 message of "Fri, 30 May 2025 10:02:56 +0200")
References: <20250530080307.2055502-1-pbonzini@redhat.com>
 <20250530080307.2055502-5-pbonzini@redhat.com>
Date: Mon, 02 Jun 2025 12:47:11 +0200
Message-ID: <87zfeqifo0.fsf@pond.sub.org>
User-Agent: Gnus/5.13 (Gnus v5.13)
MIME-Version: 1.0
Content-Type: text/plain
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.40
Received-SPF: pass client-ip=170.10.129.124; envelope-from=armbru@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -31
X-Spam_score: -3.2
X-Spam_bar: ---
X-Spam_report: (-3.2 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.071,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H5=-1, RCVD_IN_MSPIKE_WL=-0.01,
 RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001, RCVD_IN_VALIDITY_SAFE_BLOCKED=0.001,
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
> Note that for portability I am not relying on fprintf's precision
> specifier not accessing memory beyond what will be printed.

Stale paragraph :)

> Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>
> ---
>  include/qapi/error-internal.h | 1 +
>  util/error.c                  | 5 +++--
>  2 files changed, 4 insertions(+), 2 deletions(-)
>
> diff --git a/include/qapi/error-internal.h b/include/qapi/error-internal.h
> index d5c3904adec..f5eb8ad2379 100644
> --- a/include/qapi/error-internal.h
> +++ b/include/qapi/error-internal.h
> @@ -19,6 +19,7 @@ struct Error
>      char *msg;
>      ErrorClass err_class;
>      const char *src, *func;
> +    int src_len;

In actual usage, we have two cases:

* @src_len is -1 and @src is null-terminated

* @src_len is non-negative and @src is an array of at least that many
  characters, not necessarily null-terminated

This is locally unobvious, and therefore deserves a comment.

Unterminated char * pretty much always deserve one :)

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

This part looks fine to me.


