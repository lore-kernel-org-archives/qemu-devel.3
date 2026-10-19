Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C28C7606A319
	for <qemu-devel@archiver.kernel.org>; Mon, 19 Oct 2026 20:57:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=mimecast20190719 header.b=ERenKsEv
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xIuQB-0006R5-4X; Mon, 19 Oct 2026 16:57:27 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <stefanha@redhat.com>)
 id 1xIuQ4-0006QN-H3
 for qemu-devel@nongnu.org; Mon, 19 Oct 2026 16:57:21 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <stefanha@redhat.com>)
 id 1xIuQ2-0003Vj-DD
 for qemu-devel@nongnu.org; Mon, 19 Oct 2026 16:57:20 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1792443437;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=6FHJmDp+JCH0qm8XtM1Q6TR+AAH+An5u94u+1CZALao=;
 b=ERenKsEv4JZKfzDDLv+LeroCr8DnYFPMcj9/iylYqMRHEfnuyvVJpTM9Q9o9s+yTayYDo5
 IYNDB1//uK4IFXM0iz+8hpDVzCBM2+n0Lt1L6njXDnF4ywynogrzYTFDFkjcFEjvAukTlA
 YNRmsu88qnzELagxO09kCDQvNvM1zbY=
Received: from mx-prod-mc-06.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-35-165-154-97.us-west-2.compute.amazonaws.com [35.165.154.97]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-681-XezBNaoeO7a1Ffuxyb7cvg-1; Mon,
 19 Oct 2026 20:57:14 +0000
X-MC-Unique: XezBNaoeO7a1Ffuxyb7cvg-1
X-Mimecast-MFC-AGG-ID: XezBNaoeO7a1Ffuxyb7cvg_1792443433
Received: from mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.93])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-06.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id CB9B7180063B; Mon, 19 Oct 2026 20:57:12 +0000 (UTC)
Received: from localhost (headnet04.pony-001.prod.iad2.dc.redhat.com
 [10.2.32.116])
 by mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP
 id 036F31800480; Mon, 19 Oct 2026 20:57:11 +0000 (UTC)
Date: Mon, 19 Oct 2026 16:57:10 -0400
From: Stefan Hajnoczi <stefanha@redhat.com>
To: Eric Blake <eblake@redhat.com>
Cc: qemu-devel@nongnu.org, Paolo Bonzini <pbonzini@redhat.com>,
 qemu-block@nongnu.org, Fam Zheng <fam@euphon.net>,
 Benjamin Marzinski <bmarzins@redhat.com>, kwolf@redhat.com,
 Dan Berrange <berrange@redhat.com>
Subject: Re: [PATCH] qemu-pr-helper: do not free reply when
 multipath_process_cmd() fails
Message-ID: <20261019205710.GB159294@shajnocz.csb>
References: <20261019153353.105505-1-stefanha@redhat.com>
 <atZCSQwSBweiek0-@redhat.com>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <atZCSQwSBweiek0-@redhat.com>
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.93
Received-SPF: pass client-ip=170.10.129.124; envelope-from=stefanha@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -23
X-Spam_score: -2.4
X-Spam_bar: --
X-Spam_report: (-2.4 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.329,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_PASS=-0.001,
 SPF_PASS=-0.001 autolearn=unavailable autolearn_force=no
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
X-Spam-Status: No, score=-16.1 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_CR_TRAILER,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_PASS,
	SPF_PASS autolearn=ham autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

On Mon, Oct 19, 2026 at 11:19:29AM -0500, Eric Blake wrote:
> On Mon, Oct 19, 2026 at 11:33:53AM -0400, Stefan Hajnoczi wrote:
> > Kevin Wolf pointed out that the multipath_process_cmd() documentation
> > only defines the value of reply on success. Don't touch it when the
> > function returns -1.
> > 
> > The libmpathcmd implementation as of c78cf64a9e8e does not set *reply to
> > NULL when its internal mpath_send_cmd() call fails, so I think Kevin's
> > interpretation is correct.
> > 
> > As it stands, there is no observable bug in the QEMU code though because
> > reply is initialized to NULL before calling multipath_process_cmd().
> > This patch is just a cleanup.
> > 
> > Cc: Benjamin Marzinski <bmarzins@redhat.com>
> > Cc: kwolf@redhat.com
> > Cc: eblake@redhat.com
> > Signed-off-by: Stefan Hajnoczi <stefanha@redhat.com>
> > ---
> > Eric pointed out that g_autofree could eliminate the manual free(3)
> > calls. In this case we cannot use it since g_autofree calls glib's
> > g_free() rather than the standard library's free(3).
> 
> I know glib encourages g_free() in case malloc was interposed, but
> aren't we guaranteed that we are not exploiting glib's malloc
> overrides, and therefore g_free() calls into free(3)?  But I'm fine
> with your decision to not use g_autofree here.

g_mem_set_vtable() is deprecated and a nop. Interposing no longer works.
g_mem_is_system_malloc() always returns TRUE.

If we take advantage of glib internals, then you can call g_free() on
malloc() memory AFAIK. But I don't think the API documentation
guarantees this will always be the case and I'm not sure it's worth
baking in this assumption.

Maybe there is a clean way to do this with the glib API: define a type
called SystemMallocPtr and then use g_autoptr(SystemMallocPtr)?

If someone with more glib knowledge has a clean solution, we could start
using it. IMO if you need to think too much about it, it's probably best
to do the simple thing instead.

> 
> > ---
> >  scsi/qemu-pr-helper.c | 6 +++++-
> >  1 file changed, 5 insertions(+), 1 deletion(-)
> > 
> > diff --git a/scsi/qemu-pr-helper.c b/scsi/qemu-pr-helper.c
> > index 54d196a503f..d52109cab25 100644
> > --- a/scsi/qemu-pr-helper.c
> > +++ b/scsi/qemu-pr-helper.c
> > @@ -571,13 +571,17 @@ static bool multipathd_cmd(int fd, const char *cmd, Error **errp)
> >          free(reply);
> >          return false;
> >      }
> > -    free(reply);
> >      if (ret == -1) {
> > +        /*
> > +         * reply is not freed because the documentation only defines it when
> > +         * the function returns success.
> > +         */
> >          error_setg_errno(errp, last_errno,
> >                           "mpath_process_cmd(%d, \"%s\") failed",
> >                           fd, cmd);
> >          return false;
> >      }
> > +    free(reply);
> 
> Reviewed-by: Eric Blake <eblake@redhat.com>
> 
> -- 
> Eric Blake, Principal Software Engineer
> Red Hat, Inc.
> Virtualization:  qemu.org | libguestfs.org
> 


