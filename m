Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3338DC3DA4A
	for <qemu-devel@archiver.kernel.org>; Fri,  2 Aug 2024 21:03:32 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sZzQh-0004uy-T0; Fri, 02 Aug 2024 17:03:16 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <rjones@redhat.com>) id 1sZzQf-0004sp-Hu
 for qemu-devel@nongnu.org; Fri, 02 Aug 2024 17:03:13 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <rjones@redhat.com>) id 1sZzQd-0000IU-RV
 for qemu-devel@nongnu.org; Fri, 02 Aug 2024 17:03:13 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1722632591;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=ipwF7cvTS655MUkRwrwzTFWPUlKb6aDId/vFEfgKTXw=;
 b=Ka0OlCn7QUdOxamvZ4Cfcs5gIp6zCqgArDQVBCYN+Snb4S2MEOUQ9L7d4BcsvaStq2pspH
 +4G0cZr+RRel0rIWAiG1vPGAMNldA272Lt30FlnCzi0SfSwGmaa8niJuxMOfEbOWfzHr47
 jRSCB08HmQoiocFHe/0lDZIfgyT9gq4=
Received: from mx-prod-mc-03.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-650-xB9qAFvIM6qNK3RKengrmQ-1; Fri,
 02 Aug 2024 17:03:08 -0400
X-MC-Unique: xB9qAFvIM6qNK3RKengrmQ-1
Received: from mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.17])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-03.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 27DFC1944A90; Fri,  2 Aug 2024 21:03:07 +0000 (UTC)
Received: from localhost (unknown [10.42.28.4])
 by mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP
 id 97CF71955E80; Fri,  2 Aug 2024 21:03:06 +0000 (UTC)
Date: Fri, 2 Aug 2024 22:03:05 +0100
From: "Richard W.M. Jones" <rjones@redhat.com>
To: Eric Blake <eblake@redhat.com>
Cc: qemu-devel@nongnu.org, qemu-block@nongnu.org,
 Vladimir Sementsov-Ogievskiy <vsementsov@yandex-team.ru>
Subject: Re: [PATCH 2/2] qemu-img: CVE-XXX Sanitize untrusted output from NBD
 server
Message-ID: <20240802210305.GX1450@redhat.com>
References: <20240802194156.2131519-4-eblake@redhat.com>
 <20240802194156.2131519-6-eblake@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240802194156.2131519-6-eblake@redhat.com>
User-Agent: Mutt/1.5.21 (2010-09-15)
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.17
Received-SPF: pass client-ip=170.10.133.124; envelope-from=rjones@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -21
X-Spam_score: -2.2
X-Spam_bar: --
X-Spam_report: (-2.2 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.124,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H4=0.001, RCVD_IN_MSPIKE_WL=0.001,
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

On Fri, Aug 02, 2024 at 02:26:06PM -0500, Eric Blake wrote:
> Error messages from an NBD server must be treated as untrusted; a
> malicious server can inject escape sequences to try and trigger RCE
> flaws via escape sequences to whatever terminal happens to be running
> qemu-img.  The easiest solution is to sanitize the output with the
> same code we use to produce sanitized (pseudo-)JSON over QMP.
> 
> Rich Jones originally pointed this flaw out at:
> https://lists.libguestfs.org/archives/list/guestfs@lists.libguestfs.org/thread/2NXA23G2V3HPWJYAO726PLNBEAAEUJAU/
> 
> With this patch, and a malicious server run with nbdkit 1.40 as:
> 
> $ nbdkit --log=null eval open=' printf \
>   "EPERM x\\r mess up the output \e[31mmess up the output\e[m mess up" >&2; \
>   exit 1 ' get_size=' echo 0 ' --run 'qemu-img info "$uri"'
> 
> we now get:
> 
> qemu-img: Could not open 'nbd://localhost': Requested export not available
> server reported: /tmp/nbdkitOZHOKB/open: x\r mess up the output \u001B[31mmess up the output\u001B[m mess up
> 
> instead of an attempt to hide the name of the Unix socket and forcing
> the terminal to render part of the text red.
> 
> Note that I did _not_ sanitize the string being sent through
> trace-events in trace_nbd_server_error_msg; this is because I assume
> that our trace engines already treat all string strings as untrusted
> input and apply their own escaping as needed.
> 
> Reported-by: "Richard W.M. Jones" <rjones@redhat.com>
> Signed-off-by: Eric Blake <eblake@redhat.com>
> 
> ---
> 
> If my assumption about allowing raw escape bytes through to trace_
> calls is wrong (such as when tracing to stderr), let me know.  That's
> a much bigger audit to determine which trace points, if any, should
> sanitize data before tracing, and/or change the trace engines to
> sanitize all strings (with possible knock-on effects if trace output
> changes unexpectedly for a tool expecting something unsanitized).
> ---
>  nbd/client.c | 5 ++++-
>  1 file changed, 4 insertions(+), 1 deletion(-)
> 
> diff --git a/nbd/client.c b/nbd/client.c
> index c89c7504673..baa20d10d69 100644
> --- a/nbd/client.c
> +++ b/nbd/client.c
> @@ -23,6 +23,7 @@
>  #include "trace.h"
>  #include "nbd-internal.h"
>  #include "qemu/cutils.h"
> +#include "qemu/unicode.h"
> 
>  /* Definitions for opaque data types */
> 
> @@ -230,7 +231,9 @@ static int nbd_handle_reply_err(QIOChannel *ioc, NBDOptionReply *reply,
>      }
> 
>      if (msg) {
> -        error_append_hint(errp, "server reported: %s\n", msg);
> +        g_autoptr(GString) buf = g_string_sized_new(reply->length);
> +        mod_utf8_sanitize(buf, msg);
> +        error_append_hint(errp, "server reported: %s\n", buf->str);
>      }

Reviewed-by: Richard W.M. Jones <rjones@redhat.com>

-- 
Richard Jones, Virtualization Group, Red Hat http://people.redhat.com/~rjones
Read my programming and virtualization blog: http://rwmj.wordpress.com
nbdkit - Flexible, fast NBD server with plugins
https://gitlab.com/nbdkit/nbdkit


