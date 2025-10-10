Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8E208CCA476
	for <qemu-devel@archiver.kernel.org>; Fri, 10 Oct 2025 10:09:58 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1v7A3y-0001YY-Kk; Fri, 10 Oct 2025 06:09:28 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <berrange@redhat.com>)
 id 1v7A3x-0001YQ-NC
 for qemu-devel@nongnu.org; Fri, 10 Oct 2025 06:09:25 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <berrange@redhat.com>)
 id 1v7A3p-0004EH-UU
 for qemu-devel@nongnu.org; Fri, 10 Oct 2025 06:09:25 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1760090955;
 h=from:from:reply-to:reply-to:subject:subject:date:date:
 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
 content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=y48iJxJyL97VXcPqgRH2ScMv/vaYDTYBVhwB4sOjtis=;
 b=A+dfX2JIZjUVGrgecfIZTFVH+ClFO+EQMZHSM7PI1n3e9PTwxQkrkTN0+l8ekbaQOAlU0m
 DZD3HEgCqkZ4WlMOYabA8TeHZ0rf+j2yO2mgxYDJVSp/znvr5aPLn716RRwED2EXEllrVO
 DGDSX0i4GHcGKeJB9PGhE1E7Jha76/A=
Received: from mx-prod-mc-06.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-35-165-154-97.us-west-2.compute.amazonaws.com [35.165.154.97]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-509-YhQDgVY-M7yZ2TUDzHsfrg-1; Fri,
 10 Oct 2025 06:09:14 -0400
X-MC-Unique: YhQDgVY-M7yZ2TUDzHsfrg-1
X-Mimecast-MFC-AGG-ID: YhQDgVY-M7yZ2TUDzHsfrg_1760090953
Received: from mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.93])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-06.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 59D781800562; Fri, 10 Oct 2025 10:09:13 +0000 (UTC)
Received: from redhat.com (unknown [10.42.28.177])
 by mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 75E641800447; Fri, 10 Oct 2025 10:09:10 +0000 (UTC)
Date: Fri, 10 Oct 2025 11:09:04 +0100
From: Daniel =?utf-8?B?UC4gQmVycmFuZ8Op?= <berrange@redhat.com>
To: "Richard W.M. Jones" <rjones@redhat.com>
Cc: qemu-devel@nongnu.org, lvivier@redhat.com, farosas@suse.de,
 pbonzini@redhat.com
Subject: Re: [PATCH v2 1/2] Implement -run-with exit-with-parent=on
Message-ID: <aOjbQITMTLHSXEYo@redhat.com>
References: <20251009161526.140497-1-rjones@redhat.com>
 <20251009161526.140497-2-rjones@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20251009161526.140497-2-rjones@redhat.com>
User-Agent: Mutt/2.2.14 (2025-02-20)
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.93
Received-SPF: pass client-ip=170.10.129.124; envelope-from=berrange@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -24
X-Spam_score: -2.5
X-Spam_bar: --
X-Spam_report: (-2.5 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.438,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H3=0.001, RCVD_IN_MSPIKE_WL=0.001,
 RCVD_IN_VALIDITY_CERTIFIED_BLOCKED=0.001, RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001,
 SPF_HELO_PASS=-0.001, SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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
Reply-To: Daniel =?utf-8?B?UC4gQmVycmFuZ8Op?= <berrange@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org

On Thu, Oct 09, 2025 at 05:12:46PM +0100, Richard W.M. Jones wrote:
> Libguestfs wants to use qemu to run a captive appliance.  When the
> program linked to libguestfs exits, we want qemu to be cleaned up.
> Libguestfs goes to great lengths to do this at the moment: it either
> forks a separate process to ensure clean-up is done, or it asks
> libvirt to clean up the qemu process.  However this is complicated and
> not totally reliable.
> 
> On Linux, FreeBSD and macOS, there are mechanisms to ensure a signal
> or message is delivered to a process when its parent process goes
> away.  The qemu test suite even uses this mechanism on Linux (see
> PR_SET_PDEATHSIG in tests/qtest/libqtest.c).
> 
> In nbdkit we have long had the concept of running nbdkit captively,
> and we have the nbdkit --exit-with-parent flag to help
> (https://libguestfs.org/nbdkit-captive.1.html#EXIT-WITH-PARENT)
> 
> This commit adds the same mechanism.  The syntax is:
> 
>   qemu -run-with exit-with-parent=on [...]
> 
> This is not a feature that most typical users of qemu (for running
> general purpose, long-lived VMs) should use, so it defaults to off.
> 
> The exit-with-parent.[ch] files are copied from nbdkit, where they
> have a 3-clause BSD license which is compatible with qemu:
> 
> https://gitlab.com/nbdkit/nbdkit/-/tree/master/common/utils?ref_type=heads
> 
> Thanks: Daniel P. Berrangé <berrange@redhat.com>
> Signed-off-by: Richard W.M. Jones <rjones@redhat.com>
> ---
>  include/qemu/exit-with-parent.h |  57 +++++++++++++
>  qemu-options.hx                 |  13 ++-
>  system/exit-with-parent.c       | 140 ++++++++++++++++++++++++++++++++
>  system/meson.build              |   1 +
>  system/vl.c                     |  13 +++
>  5 files changed, 222 insertions(+), 2 deletions(-)
> 
> diff --git a/include/qemu/exit-with-parent.h b/include/qemu/exit-with-parent.h
> new file mode 100644
> index 0000000000..c00b863fe9
> --- /dev/null
> +++ b/include/qemu/exit-with-parent.h
> @@ -0,0 +1,57 @@

snip

> +
> +#ifndef NBDKIT_EXIT_WITH_PARENT_H
> +#define NBDKIT_EXIT_WITH_PARENT_H

I'd suggest s/NBDKIT/QEMU/ here & at the end

> +
> +/* Test if the feature is available on the platform. */
> +static inline bool can_exit_with_parent(void)
> +{
> +#if defined(__linux__) || defined(__FreeBSD__) || defined(__APPLE__)
> +    return true;
> +#else
> +    return false;
> +#endif
> +}
> +
> +/*
> + * --exit-with-parent: kill the current process if the parent exits.
> + * This may return -1 on error.
> + *
> + * Note this will abort on platforms where can_exit_with_parent()
> + * returned false.
> + */
> +extern int set_exit_with_parent(void);
> +
> +#endif /* NBDKIT_EXIT_WITH_PARENT_H */



With that minor change

 Reviewed-by: Daniel P. Berrangé <berrange@redhat.com>
 

With regards,
Daniel
-- 
|: https://berrange.com      -o-    https://www.flickr.com/photos/dberrange :|
|: https://libvirt.org         -o-            https://fstop138.berrange.com :|
|: https://entangle-photo.org    -o-    https://www.instagram.com/dberrange :|


