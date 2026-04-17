Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 96069F436B0
	for <qemu-devel@archiver.kernel.org>; Fri, 17 Apr 2026 14:40:15 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wDkMH-0003Oz-I4; Fri, 17 Apr 2026 10:39:49 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <armbru@redhat.com>) id 1wDkMG-0003Oo-7O
 for qemu-devel@nongnu.org; Fri, 17 Apr 2026 10:39:48 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <armbru@redhat.com>) id 1wDkME-0005cS-Eq
 for qemu-devel@nongnu.org; Fri, 17 Apr 2026 10:39:47 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1776436784;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=u2H6ont24s/tEJdHct1r+q8YkBP2G1W56q9PhJOwKjU=;
 b=NMJAkGDVcIJHrANbdot/YA+B93drbiimCQ/xoVIJ5SsRkvcP1Vr1nqilFHTYDj5JXdFOze
 Cp4lOJIdMpJrKeFXVS+oyaXSwGhm6g+PeFSXXLXgGveceSXiN6OOJcEHNLiiUeshhHWX7s
 WdBUwfP0gdVOGe36eDsAJSBmE39tYnw=
Received: from mx-prod-mc-06.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-35-165-154-97.us-west-2.compute.amazonaws.com [35.165.154.97]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-455-tcQrB4tHOCOigZ3R2kWP_g-1; Fri,
 17 Apr 2026 10:39:41 -0400
X-MC-Unique: tcQrB4tHOCOigZ3R2kWP_g-1
X-Mimecast-MFC-AGG-ID: tcQrB4tHOCOigZ3R2kWP_g_1776436780
Received: from mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.17])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-06.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 173DE1800464; Fri, 17 Apr 2026 14:39:40 +0000 (UTC)
Received: from blackfin.pond.sub.org (unknown [10.44.22.4])
 by mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 9CE93195608E; Fri, 17 Apr 2026 14:39:39 +0000 (UTC)
Received: by blackfin.pond.sub.org (Postfix, from userid 1000)
 id E74A821E6A28; Fri, 17 Apr 2026 16:39:36 +0200 (CEST)
From: Markus Armbruster <armbru@redhat.com>
To: Jun Yu <yujun@kylinos.cn>
Cc: pbonzini@redhat.com,  qemu-devel@nongnu.org
Subject: Re: [PATCH] system: Improve error handling and robustness
In-Reply-To: <20260408022507.27457-1-yujun@kylinos.cn> (Jun Yu's message of
 "Wed, 8 Apr 2026 10:25:07 +0800")
References: <20260408022507.27457-1-yujun@kylinos.cn>
Date: Fri, 17 Apr 2026 16:39:36 +0200
Message-ID: <87mrz1k5w7.fsf@pond.sub.org>
User-Agent: Gnus/5.13 (Gnus v5.13)
MIME-Version: 1.0
Content-Type: text/plain
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.17
Received-SPF: pass client-ip=170.10.129.124; envelope-from=armbru@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -25
X-Spam_score: -2.6
X-Spam_bar: --
X-Spam_report: (-2.6 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.54,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H4=0.001, RCVD_IN_MSPIKE_WL=0.001,
 RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001, RCVD_IN_VALIDITY_SAFE_BLOCKED=0.001,
 SPF_HELO_PASS=-0.001, SPF_PASS=-0.001 autolearn=ham autolearn_force=no
X-Spam_action: no action
X-BeenThere: qemu-devel@nongnu.org
X-Mailman-Version: 2.1.29
Precedence: list
List-Id: qemu development <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <https://lists.nongnu.org/archive/html/qemu-devel>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=subscribe>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org

Jun Yu <yujun@kylinos.cn> writes:

> This commit fixes two important issues:
>
> 1. In parse_name(), ensure qemu_name is never NULL by initializing it to
>    an empty string when the "guest" option is not provided. This prevents
>    potential null pointer dereferences.

Can you point to an actual null pointer dereference?

If you can't, there is no bug to fix.

If you can, then your fix needs work.  Here's why.

parse_name() runs when the user passes a -name option.  Your patch
ensures parse_name sets @qemu_name to a non-null string.

When it doesn't run, @qemu_name remains null.

The users of qemu_name check whether it is null.  For instance:

    const char *audio_application_name(void)
    {
        const char *vm_name;

        vm_name = qemu_get_vm_name();
        return vm_name ? vm_name : "qemu";
    }

Your patch breaks such code when -name is passed.

> 2. In parse_add_fd(), replace error_abort with proper error handling
>    using the provided errp parameter. This avoids immediate program
>    termination on failure and allows for more graceful error reporting.

This is insufficient rationale.

&error_abort is a fancy way to write assert().  It's is the appropriate
way to catch programming errors, i.e. errors that aren't supposed to
happen, and when they do happen, there is a bug that needs fixing.

You'd have to explain why this error is *not* a programming error.  As a
first step, explain how it could happen.

You can't, because it is in fact a programming error.
monitor_fdset_add_fd() only fails when passed a an @fdset_id < 0.
parse_add_fd() catches that itself a few lines above the call.

> These changes improve the robustness of the QEMU system emulator by
> providing more predictable error handling and preventing potential
> crashes.

This sounds like an AI to me.  Please note that current QEMU project
policy is to DECLINE any contributions which are believed to include or
derive from AI generated content.  See docs/devel/code-provenance.rst
section "Use of AI-generated content" for why.

> Signed-off-by: Jun Yu <yujun@kylinos.cn>
> ---
>  system/vl.c | 9 ++++++++-
>  1 file changed, 8 insertions(+), 1 deletion(-)
>
> diff --git a/system/vl.c b/system/vl.c
> index 246623b319..eb07b04044 100644
> --- a/system/vl.c
> +++ b/system/vl.c
> @@ -560,6 +560,9 @@ static int parse_name(void *opaque, QemuOpts *opts, Error **errp)
>      }
>  
>      qemu_name = qemu_opt_get(opts, "guest");
> +    if (!qemu_name) {
> +        qemu_name = "";
> +    }
>  
>      proc_name = qemu_opt_get(opts, "process");
>      if (proc_name) {
> @@ -626,7 +629,11 @@ static int parse_add_fd(void *opaque, QemuOpts *opts, Error **errp)
>  
>      /* add the duplicate fd, and optionally the opaque string, to the fd set */
>      fdinfo = monitor_fdset_add_fd(dupfd, true, fdset_id, fd_opaque,
> -                                  &error_abort);
> +                                  errp);
> +    if (!fdinfo) {
> +        close(dupfd);
> +        return -1;
> +    }
>      g_free(fdinfo);
>  
>      return 0;


