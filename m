Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 80A62C54F30
	for <qemu-devel@archiver.kernel.org>; Tue, 27 May 2025 13:43:21 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uJuZg-0002T4-TD; Tue, 27 May 2025 09:42:36 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <armbru@redhat.com>) id 1uJuZd-0002Sl-VO
 for qemu-devel@nongnu.org; Tue, 27 May 2025 09:42:34 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <armbru@redhat.com>) id 1uJuZY-0003bD-U7
 for qemu-devel@nongnu.org; Tue, 27 May 2025 09:42:32 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1748353345;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=CumUhn7aR01x5Sy9sVxBT484Uq17U2NwR2iWgSwKD1s=;
 b=N0eEjgxx7L7isyg4ERXmUyU+mv88DFOdafnpFj8iaBrh7J3vgDBDUw9ct8uxiu6VfWAFrT
 WxwPfw/nARlxyPglDIeXUC4DmIXiFHL9zUBX4NEoV4mKd1rWKMm4brjjA5M9j6LdKCUhhB
 TJSvM0O1kcXZ7x+4XfzIhdIfeQwgMyY=
Received: from mx-prod-mc-06.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-35-165-154-97.us-west-2.compute.amazonaws.com [35.165.154.97]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-42-j9DZ2DrgMGG3rspjKISiqQ-1; Tue,
 27 May 2025 09:42:21 -0400
X-MC-Unique: j9DZ2DrgMGG3rspjKISiqQ-1
X-Mimecast-MFC-AGG-ID: j9DZ2DrgMGG3rspjKISiqQ_1748353341
Received: from mx-prod-int-02.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-02.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.15])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-06.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id D51DB18003FC; Tue, 27 May 2025 13:42:20 +0000 (UTC)
Received: from blackfin.pond.sub.org (unknown [10.45.242.2])
 by mx-prod-int-02.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 71C631956095; Tue, 27 May 2025 13:42:20 +0000 (UTC)
Received: by blackfin.pond.sub.org (Postfix, from userid 1000)
 id 95FE921E66C3; Tue, 27 May 2025 15:42:17 +0200 (CEST)
From: Markus Armbruster <armbru@redhat.com>
To: Paolo Bonzini <pbonzini@redhat.com>
Cc: qemu-devel@nongnu.org,  qemu-rust@nongnu.org
Subject: Re: [PATCH 05/12] util/error: allow non-NUL-terminated err->src
In-Reply-To: <20250526142455.1061519-5-pbonzini@redhat.com> (Paolo Bonzini's
 message of "Mon, 26 May 2025 16:24:48 +0200")
References: <20250526142254.1061009-1-pbonzini@redhat.com>
 <20250526142455.1061519-5-pbonzini@redhat.com>
Date: Tue, 27 May 2025 15:42:17 +0200
Message-ID: <87sekqmapy.fsf@pond.sub.org>
User-Agent: Gnus/5.13 (Gnus v5.13)
MIME-Version: 1.0
Content-Type: text/plain
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.15
Received-SPF: pass client-ip=170.10.133.124; envelope-from=armbru@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -49
X-Spam_score: -5.0
X-Spam_bar: -----
X-Spam_report: (-5.0 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-2.907,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H5=0.001, RCVD_IN_MSPIKE_WL=0.001,
 RCVD_IN_VALIDITY_CERTIFIED_BLOCKED=0.001, RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001,
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

Paolo Bonzini <pbonzini@redhat.com> writes:

> Rust makes the current file available as a statically-allocated string,
> but without a NUL terminator.  Allow this by storing an optional maximum
> length in the Error.
>
> Note that for portability I am not relying on fprintf's precision
> specifier not accessing memory beyond what will be printed.

Can you elaborate on the portability problem?  I figure ...

> Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>
> ---
>  include/qapi/error-internal.h | 1 +
>  util/error.c                  | 8 +++++++-
>  2 files changed, 8 insertions(+), 1 deletion(-)
>
> diff --git a/include/qapi/error-internal.h b/include/qapi/error-internal.h
> index d5c3904adec..6178ce4a63d 100644
> --- a/include/qapi/error-internal.h
> +++ b/include/qapi/error-internal.h
> @@ -19,6 +19,7 @@ struct Error
>      char *msg;
>      ErrorClass err_class;
>      const char *src, *func;
> +    ssize_t src_len;
>      int line;
>      GString *hint;
>  };
> diff --git a/util/error.c b/util/error.c
> index e5bcb7c0225..6c1033eaba5 100644
> --- a/util/error.c
> +++ b/util/error.c
> @@ -24,8 +24,13 @@ Error *error_warn;
>  static void error_handle(Error **errp, Error *err)
>  {
>      if (errp == &error_abort) {
> +        const char *src = err->src;
> +        if (err->src_len >= 0) {
> +            /* No need to free it, the program will abort very soon...  */
> +            src = g_strndup(err->src, err->src_len);
> +        }
>          fprintf(stderr, "Unexpected error in %s() at %s:%d:\n",
> -                err->func, err->src, err->line);
> +                err->func, src, err->line);

... you're avoiding the simpler

           fprintf(stderr, "Unexpected error in %s() at %.*s:%d:\n",
                   err->func, err->src_len, err->src, err->line);

because of it.

(@src_len needs to be int then, and its default value below INT_MAX)

>          error_report("%s", error_get_pretty(err));
>          if (err->hint) {
>              error_printf("%s", err->hint->str);
> @@ -67,6 +72,7 @@ static void error_setv(Error **errp,
>          g_free(msg);
>      }
>      err->err_class = err_class;
> +    err->src_len = -1;
>      err->src = src;
>      err->line = line;
>      err->func = func;


