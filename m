Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8503AD36113
	for <qemu-devel@archiver.kernel.org>; Tue,  5 Nov 2024 19:29:33 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1t8PEw-00058k-5k; Tue, 05 Nov 2024 14:29:22 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <kwolf@redhat.com>) id 1t8PEv-00058F-4K
 for qemu-devel@nongnu.org; Tue, 05 Nov 2024 14:29:21 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <kwolf@redhat.com>) id 1t8PEt-0004pM-O8
 for qemu-devel@nongnu.org; Tue, 05 Nov 2024 14:29:20 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1730834959;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=HvDPgs4Ek+sMedBq7KdcFXDh01SEWq4J7KgUq6RgrI4=;
 b=iA2vywPywaKfaG5dEi+8g5r0hjbg7ZrEPnz13TvaabhmbIVzM1Jk2aWut0u3UIc4tqxU8M
 MXTQD4mYcb2xHGV5lyJrIkA8QnMBWx7ENvkBUcgBb2MCGDchXKA971mjn468k4mclxaQoz
 p2srGsbAdEG1RvaEisUItWNv8sY7W54=
Received: from mx-prod-mc-01.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-489-eHjAlWn4Ns-Z2DldwgCCTQ-1; Tue,
 05 Nov 2024 14:29:15 -0500
X-MC-Unique: eHjAlWn4Ns-Z2DldwgCCTQ-1
Received: from mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.4])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-01.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 079331955BCE; Tue,  5 Nov 2024 19:29:14 +0000 (UTC)
Received: from redhat.com (unknown [10.39.194.127])
 by mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id D98BE300018D; Tue,  5 Nov 2024 19:29:11 +0000 (UTC)
Date: Tue, 5 Nov 2024 20:29:04 +0100
From: Kevin Wolf <kwolf@redhat.com>
To: Michael Tokarev <mjt@tls.msk.ru>
Cc: qemu-devel@nongnu.org, qemu-block@nongnu.org
Subject: Re: [PATCH 03/27] qemu-img: global option processing and error
 printing
Message-ID: <ZypyAOakh3cM9KDz@redhat.com>
References: <20240927061121.573271-1-mjt@tls.msk.ru>
 <20240927061121.573271-4-mjt@tls.msk.ru>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240927061121.573271-4-mjt@tls.msk.ru>
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.4
Received-SPF: pass client-ip=170.10.129.124; envelope-from=kwolf@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -23
X-Spam_score: -2.4
X-Spam_bar: --
X-Spam_report: (-2.4 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.34,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H2=-0.001,
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

Am 27.09.2024 um 08:10 hat Michael Tokarev geschrieben:
> In order to correctly print executable name in various
> error messages, pass argv[0] to error_exit() function.
> This way, error messages will refer to actual executable
> name, which may be different from 'qemu-img'.
> 
> For subcommands, pass original command name from the
> qemu-img argv[0], plus the subcommand name, as its own
> argv[0] element, so error messages can be more useful.
> Also don't require at least 3 options on the command
> line: it makes no sense with options before subcommand.
> 
> Introduce tryhelp() function which just prints
> 
>  try 'command-name --help' for more info
> 
> and exits.  When tryhelp() is called from within a subcommand
> handler, the message will look like:
> 
>  try 'command-name subcommand --help' for more info
> 
> qemu-img uses getopt_long() with ':' as the first char in
> optstring parameter, which means it doesn't print error
> messages but return ':' or '?' instead, and qemu-img uses
> unrecognized_option() or missing_argument() function to
> print error messages.  But it doesn't quite work:
> 
>  $ ./qemu-img -xx
>  qemu-img: unrecognized option './qemu-img'
> 
> so the aim is to let getopt_long() to print regular error
> messages instead (removing ':' prefix from optstring) and
> remove handling of '?' and ':' "options" entirely.  With
> concatenated argv[0] and the subcommand, it all finally
> does the right thing in all cases.  This will be done in
> subsequent changes command by command, with main() done
> last.
> 
> unrecognized_option() and missing_argument() functions
> prototypes aren't changed by this patch, since they're
> called from many places and will be removed a few patches
> later.  Only artifical "qemu-img" argv0 is provided in
> there for now.
> 
> Signed-off-by: Michael Tokarev <mjt@tls.msk.ru>
> ---
>  qemu-img.c | 80 +++++++++++++++++++++++++++++-------------------------
>  1 file changed, 43 insertions(+), 37 deletions(-)
> 
> diff --git a/qemu-img.c b/qemu-img.c
> index fe22986931..130188e287 100644
> --- a/qemu-img.c
> +++ b/qemu-img.c
> @@ -101,8 +101,15 @@ static void format_print(void *opaque, const char *name)
>      printf(" %s", name);
>  }
>  
> -static G_NORETURN G_GNUC_PRINTF(1, 2)
> -void error_exit(const char *fmt, ...)
> +static G_NORETURN
> +void tryhelp(const char *argv0)
> +{
> +    error_printf("Try '%s --help' for more info\n", argv0);
> +    exit(EXIT_FAILURE);
> +}
> +
> +static G_NORETURN G_GNUC_PRINTF(2, 3)
> +void error_exit(const char *argv0, const char *fmt, ...)
>  {
>      va_list ap;
>  
> @@ -110,20 +117,19 @@ void error_exit(const char *fmt, ...)
>      error_vreport(fmt, ap);
>      va_end(ap);
>  
> -    error_printf("Try 'qemu-img --help' for more information\n");
> -    exit(EXIT_FAILURE);
> +    tryhelp(argv0);
>  }

No reason to change "information" into the more colloquial "info". I
would leave it as it is.

Apart from that:
Reviewed-by: Kevin Wolf <kwolf@redhat.com>


