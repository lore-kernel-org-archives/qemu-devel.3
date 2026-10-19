Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0BDED606A31C
	for <qemu-devel@archiver.kernel.org>; Mon, 19 Oct 2026 16:19:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=mimecast20190719 header.b=YN/nMrRR
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xIq5S-0006j5-Sz; Mon, 19 Oct 2026 12:19:46 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <eblake@redhat.com>) id 1xIq5R-0006ih-Aj
 for qemu-devel@nongnu.org; Mon, 19 Oct 2026 12:19:45 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <eblake@redhat.com>) id 1xIq5P-0000cM-6j
 for qemu-devel@nongnu.org; Mon, 19 Oct 2026 12:19:45 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1792426780;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=pxcuucpGqCFNoLT/SJgKWSZtElBD6o9rt72QwCCLwhE=;
 b=YN/nMrRRyfUQEqRQBDBLSCsvmNzwYvPajYBwcXEUi67gtoVahAAu8yLwq+e5guIHgCeyOg
 HQPTeHG1KZVokHIlbB4iy09Gb9ZnWImVGIj9UM7iH1aWiV7CP2T/vVG0/x85QQdFbJt2UY
 1StK6gW4ImJeLNGE10PCJdx9uZ+wwmA=
Received: from mx-prod-mc-06.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-35-165-154-97.us-west-2.compute.amazonaws.com [35.165.154.97]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-364-8Vxn1nvpOwyNDIuIyitF9w-1; Mon,
 19 Oct 2026 16:19:36 +0000
X-MC-Unique: 8Vxn1nvpOwyNDIuIyitF9w-1
X-Mimecast-MFC-AGG-ID: 8Vxn1nvpOwyNDIuIyitF9w_1792426775
Received: from mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.4])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-06.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id E89CE18005B8; Mon, 19 Oct 2026 16:19:34 +0000 (UTC)
Received: from redhat.com (headnet04.pony-001.prod.iad2.dc.redhat.com
 [10.2.32.116])
 by mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 7C07E30000E3; Mon, 19 Oct 2026 16:19:32 +0000 (UTC)
Date: Mon, 19 Oct 2026 11:19:29 -0500
From: Eric Blake <eblake@redhat.com>
To: Stefan Hajnoczi <stefanha@redhat.com>
Cc: qemu-devel@nongnu.org, Paolo Bonzini <pbonzini@redhat.com>, 
 qemu-block@nongnu.org, Fam Zheng <fam@euphon.net>, 
 Benjamin Marzinski <bmarzins@redhat.com>, kwolf@redhat.com,
 Dan Berrange <berrange@redhat.com>
Subject: Re: [PATCH] qemu-pr-helper: do not free reply when
 multipath_process_cmd() fails
Message-ID: <atZCSQwSBweiek0-@redhat.com>
References: <20261019153353.105505-1-stefanha@redhat.com>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20261019153353.105505-1-stefanha@redhat.com>
User-Agent: NeoMutt/20260616
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.4
Received-SPF: pass client-ip=170.10.133.124; envelope-from=eblake@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -23
X-Spam_score: -2.4
X-Spam_bar: --
X-Spam_report: (-2.4 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.329,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H3=0.001, RCVD_IN_MSPIKE_WL=0.001,
 SPF_HELO_PASS=-0.001, SPF_PASS=-0.001 autolearn=ham autolearn_force=no
X-Spam_action: no action
X-BeenThere: qemu-devel@nongnu.org
X-Mailman-Version: 2.1.29
Precedence: list
List-Id: qemu development <qemu-devel.nongnu.org>
List-Archive: <https://lists.nongnu.org/archive/html/qemu-devel>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=subscribe>
Sender: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
X-Spam-Status: No, score=-17.6 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_CR_TRAILER,INCLUDES_PATCH,MAILING_LIST_MULTI,
	RCVD_IN_DNSWL_BLOCKED,RCVD_IN_ZEN_BLOCKED_OPENDNS,SPF_HELO_PASS,
	SPF_PASS,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no
	version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

On Mon, Oct 19, 2026 at 11:33:53AM -0400, Stefan Hajnoczi wrote:
> Kevin Wolf pointed out that the multipath_process_cmd() documentation
> only defines the value of reply on success. Don't touch it when the
> function returns -1.
> 
> The libmpathcmd implementation as of c78cf64a9e8e does not set *reply to
> NULL when its internal mpath_send_cmd() call fails, so I think Kevin's
> interpretation is correct.
> 
> As it stands, there is no observable bug in the QEMU code though because
> reply is initialized to NULL before calling multipath_process_cmd().
> This patch is just a cleanup.
> 
> Cc: Benjamin Marzinski <bmarzins@redhat.com>
> Cc: kwolf@redhat.com
> Cc: eblake@redhat.com
> Signed-off-by: Stefan Hajnoczi <stefanha@redhat.com>
> ---
> Eric pointed out that g_autofree could eliminate the manual free(3)
> calls. In this case we cannot use it since g_autofree calls glib's
> g_free() rather than the standard library's free(3).

I know glib encourages g_free() in case malloc was interposed, but
aren't we guaranteed that we are not exploiting glib's malloc
overrides, and therefore g_free() calls into free(3)?  But I'm fine
with your decision to not use g_autofree here.

> ---
>  scsi/qemu-pr-helper.c | 6 +++++-
>  1 file changed, 5 insertions(+), 1 deletion(-)
> 
> diff --git a/scsi/qemu-pr-helper.c b/scsi/qemu-pr-helper.c
> index 54d196a503f..d52109cab25 100644
> --- a/scsi/qemu-pr-helper.c
> +++ b/scsi/qemu-pr-helper.c
> @@ -571,13 +571,17 @@ static bool multipathd_cmd(int fd, const char *cmd, Error **errp)
>          free(reply);
>          return false;
>      }
> -    free(reply);
>      if (ret == -1) {
> +        /*
> +         * reply is not freed because the documentation only defines it when
> +         * the function returns success.
> +         */
>          error_setg_errno(errp, last_errno,
>                           "mpath_process_cmd(%d, \"%s\") failed",
>                           fd, cmd);
>          return false;
>      }
> +    free(reply);

Reviewed-by: Eric Blake <eblake@redhat.com>

-- 
Eric Blake, Principal Software Engineer
Red Hat, Inc.
Virtualization:  qemu.org | libguestfs.org


