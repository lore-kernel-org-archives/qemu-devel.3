Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id ABC6BCC6B12
	for <qemu-devel@archiver.kernel.org>; Tue, 13 Oct 2026 19:12:53 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xGhvD-0006F5-2r; Tue, 13 Oct 2026 15:12:23 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <eblake@redhat.com>) id 1xGhvA-0006EI-Ng
 for qemu-devel@nongnu.org; Tue, 13 Oct 2026 15:12:20 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <eblake@redhat.com>) id 1xGhv9-0006XU-A5
 for qemu-devel@nongnu.org; Tue, 13 Oct 2026 15:12:20 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1791918738;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=+r4+7195G7YXCO2ZtXMhkRDe342UyjejQWk/j46RBno=;
 b=DIA3l4pVi/LVLf3jaXIriYv9EOxqnKbaOTsYu9Bu+eW2bV1Sgo7RDGqDqYAkakMHMVx4wd
 TBMXBDclVSYFQ6YkQqEMvA3rKW7YTkmz0bWX41wSyv4PHUPdq7betNJfyUXdWPwmQJQ8AR
 3zV7VyvKp7gIfxhPkxFmd1sihhfHL+Y=
Received: from mx-prod-mc-08.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-35-165-154-97.us-west-2.compute.amazonaws.com [35.165.154.97]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-53-IlZItXA6M6SB09GN9zRF9w-1; Tue,
 13 Oct 2026 19:12:15 +0000
X-MC-Unique: IlZItXA6M6SB09GN9zRF9w-1
X-Mimecast-MFC-AGG-ID: IlZItXA6M6SB09GN9zRF9w_1791918734
Received: from mx-prod-int-10.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-10.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.95])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-08.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 393C81844BD2; Tue, 13 Oct 2026 19:12:14 +0000 (UTC)
Received: from redhat.com (headnet04.pony-001.prod.iad2.dc.redhat.com
 [10.2.32.116])
 by mx-prod-int-10.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 985AC76A; Tue, 13 Oct 2026 19:12:09 +0000 (UTC)
Date: Tue, 13 Oct 2026 14:12:06 -0500
From: Eric Blake <eblake@redhat.com>
To: Stefan Hajnoczi <stefanha@redhat.com>
Cc: qemu-devel@nongnu.org, akalenyu@redhat.com, qemu-block@nongnu.org, 
 Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>,
 Daniel =?utf-8?B?UC4gQmVycmFuZ8Op?= <berrange@redhat.com>, 
 Paolo Bonzini <pbonzini@redhat.com>, Benjamin Marzinski <bmarzins@redhat.com>, 
 Hanna Reitz <hreitz@redhat.com>, Kevin Wolf <kwolf@redhat.com>, 
 =?utf-8?Q?Marc-Andr=C3=A9?= Lureau <marcandre.lureau@redhat.com>,
 Fam Zheng <fam@euphon.net>
Subject: Re: [PATCH 3/8] hw/scsi-disk: move MIG_EVENT_FAILED into a new
 function
Message-ID: <as6CZCY2Dx69aMgT@redhat.com>
References: <20261009153058.1089786-1-stefanha@redhat.com>
 <20261009153058.1089786-4-stefanha@redhat.com>
 <as5GAVRGvlPBykdC@redhat.com>
 <20261013180527.GC1193846@shajnocz.csb>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20261013180527.GC1193846@shajnocz.csb>
User-Agent: NeoMutt/20260616
X-Scanned-By: MIMEDefang 3.6 on 10.30.177.95
Received-SPF: pass client-ip=170.10.129.124; envelope-from=eblake@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -22
X-Spam_score: -2.3
X-Spam_bar: --
X-Spam_report: (-2.3 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.24,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_PASS=-0.001,
 SPF_PASS=-0.001 autolearn=unavailable autolearn_force=no
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

On Tue, Oct 13, 2026 at 02:05:27PM -0400, Stefan Hajnoczi wrote:
> On Tue, Oct 13, 2026 at 10:00:15AM -0500, Eric Blake wrote:
> > On Fri, Oct 09, 2026 at 11:30:53AM -0400, Stefan Hajnoczi wrote:
> > > Move the MIG_EVENT_FAILED logic from scsi_block_migration_notifier()
> > > into its own new scsi_block_migration_failed() function. The next commit
> > > adds logic for handling another event, so doing that in dedicated
> > > functions makes the code easier to read.
> > > 
> > > Signed-off-by: Stefan Hajnoczi <stefanha@redhat.com>
> > > ---
> > >  hw/scsi/scsi-disk.c | 26 ++++++++++++++++----------
> > >  1 file changed, 16 insertions(+), 10 deletions(-)
> > 
> > > 
> > > diff --git a/hw/scsi/scsi-disk.c b/hw/scsi/scsi-disk.c
> > > index deb33ac1dda..3d88e57eded 100644
> > > --- a/hw/scsi/scsi-disk.c
> > > +++ b/hw/scsi/scsi-disk.c
> > > @@ -2761,20 +2761,26 @@ static SCSIRequest *scsi_new_request(SCSIDevice *d, uint32_t tag, uint32_t lun,
> > >   * fails because the destination may have already preempted and we need to get
> > >   * the reservation back.
> > >   */
> > 
> > I think this comment...
> > 
> > > +static void scsi_block_migration_failed(SCSIDiskState *s)
> > > +{
> > > +    SCSIDevice *d = &s->qdev;
> > > +    Error *local_err = NULL;
> > > +
> > > +    if (!scsi_generic_pr_state_preempt(d, &local_err)) {
> > > +        /* MIG_EVENT_FAILED cannot fail, so just warn */
> > > +        error_prepend(&local_err, "scsi-block migration rollback: ");
> > > +        warn_report_err(local_err);
> > > +    }
> > > +}
> > > +
> > >  static int scsi_block_migration_notifier(NotifierWithReturn *notifier,
> > 
> > ...belongs better with the function it was originally introducing.
> 
> I think it's clearer to explain scsi_block_migration_failed()'s purpose
> in its doc comment rather than in scsi_block_migration_notifier(), which
> this patch series turns into just a dispatch function that doesn't do
> anything itself.
> 
> scsi_block_migration_notifier() will dispatch MIG_EVENT_DONE in a later
> commit, so it's more general and no longer does the MIG_EVENT_FAILED
> work itself.
> 
> What do you think?

Okay, that explanation makes sense. I'll take a look at your v2 now.

-- 
Eric Blake, Principal Software Engineer
Red Hat, Inc.
Virtualization:  qemu.org | libguestfs.org


