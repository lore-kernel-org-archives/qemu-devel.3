Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 79A3DC021AF
	for <qemu-devel@archiver.kernel.org>; Tue, 18 Feb 2025 16:26:52 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tkQQX-0004oh-SM; Tue, 18 Feb 2025 11:26:29 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peterx@redhat.com>) id 1tkQQU-0004nm-AF
 for qemu-devel@nongnu.org; Tue, 18 Feb 2025 11:26:27 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peterx@redhat.com>) id 1tkQQO-0000g6-BE
 for qemu-devel@nongnu.org; Tue, 18 Feb 2025 11:26:23 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1739895970;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=uavT6ke0J/Cha3gANcNa3suBK9qxNe2HKl0rgsg+kBo=;
 b=jWmIEWEK/1P2UZWhf3AVZfYdL4Vnl0zPXRWFxP1s1u1qmv4LsZecfEICdLiA6pgUEZ/r2q
 o7zlzH/O8HuytfHoGObt0DUwPq4QDdnnjZL5e3ZityAnJ9LS44S8WXDgn1Q0QfT94pcUPe
 EZpQHQUAq6AX+ezT1InDh+Pj1W9uGBI=
Received: from mail-oi1-f198.google.com (mail-oi1-f198.google.com
 [209.85.167.198]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-288-auFYr9xaNIWK5edXmjSmFg-1; Tue, 18 Feb 2025 11:26:09 -0500
X-MC-Unique: auFYr9xaNIWK5edXmjSmFg-1
X-Mimecast-MFC-AGG-ID: auFYr9xaNIWK5edXmjSmFg_1739895968
Received: by mail-oi1-f198.google.com with SMTP id
 5614622812f47-3f40e8dabdbso63791b6e.2
 for <qemu-devel@nongnu.org>; Tue, 18 Feb 2025 08:26:08 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1739895968; x=1740500768;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=uavT6ke0J/Cha3gANcNa3suBK9qxNe2HKl0rgsg+kBo=;
 b=C4sZq1pb0qds6WKNlaAtGalASnjeSzq/duaaEcWnbzv7mGsLGVX8GZYKxXVq97UBn2
 njDRgYE0GRN8mFK3Lx56qMyARNwSqtQKDBTkztbeHUCrW6ob6lHrWIUoZA7tgFMx8eVq
 p2RZPDjRfYkv+zQSfNu4pP6SszFws21F98HNA0o216qH/+O2U0rrXab/cgDnfJxlEXsA
 9F41weYhb45Som9J74o+icKAbmLCB+Aq4gkvDZNpZpxmjoCCvEIwP01cpQ8aJo1Ge792
 T05R9SB73NK/0Vt/Rug9d/szytksxIIOz+nZQKZRIH9YUnsRKzFKBg253gj2c1bqKVbi
 dAUQ==
X-Gm-Message-State: AOJu0YyV8CnpPAnsG982tgwNqJ7iGdao9GtRZsVlKWLjxtu+l+PjbfXR
 /VITr3SD+24y4gISyp2s7w6vxY7MXQ4FY6DGgLs/qIiBdnWXForNtMbDj9HFMqBdxLYtxy2PstO
 HdE4YN1F+2rbiqtoJ58F3/CmbPJ7bIZ86MKAPKN90328POVWFE3zE
X-Gm-Gg: ASbGnctO5PH6/pvnNs2aC09L2lfh58cC+tkME7mEwZT5u75xEqCGm8wIzwqq0JlmFu6
 ovz0S1bN31B7wzt2zVIzOcutBf/pO/kei0G1IIFNUrOE2oYRW8wdmpZo8BmuRuFVOyZHyyF8qzJ
 6YT1XttsivTBUMi0B4jWWXZbzlqytLsammphO7e4OcGW7YQW/PsCSVEA8G4/fc9513bgrft6GZA
 iLS5jqdIiTx3SCWQB8HituhLT52dBNhWnrN9mJ54sO7W4dyicd5G19CAI8=
X-Received: by 2002:a05:6808:1b08:b0:3f4:ad3:d666 with SMTP id
 5614622812f47-3f40ad3d850mr1902125b6e.21.1739895968265; 
 Tue, 18 Feb 2025 08:26:08 -0800 (PST)
X-Google-Smtp-Source: AGHT+IHA2EUJP2VAnOKsJeknxOF8RtMHYdINLCw8IrWZucbm9qF11cMEO9eWUd+sc2YHn/yWbGbc6g==
X-Received: by 2002:a05:6808:1b08:b0:3f4:ad3:d666 with SMTP id
 5614622812f47-3f40ad3d850mr1902098b6e.21.1739895967906; 
 Tue, 18 Feb 2025 08:26:07 -0800 (PST)
Received: from x1.local ([2604:7a40:2041:2b00::1000])
 by smtp.gmail.com with ESMTPSA id
 006d021491bc7-5fcb16e0458sm3609565eaf.20.2025.02.18.08.26.06
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 18 Feb 2025 08:26:07 -0800 (PST)
Date: Tue, 18 Feb 2025 11:26:03 -0500
From: Peter Xu <peterx@redhat.com>
To: Steven Sistare <steven.sistare@oracle.com>
Cc: qemu-devel@nongnu.org, Alex Williamson <alex.williamson@redhat.com>,
 Cedric Le Goater <clg@redhat.com>, Yi Liu <yi.l.liu@intel.com>,
 Eric Auger <eric.auger@redhat.com>,
 Zhenzhong Duan <zhenzhong.duan@intel.com>,
 "Michael S. Tsirkin" <mst@redhat.com>,
 Marcel Apfelbaum <marcel.apfelbaum@gmail.com>,
 Fabiano Rosas <farosas@suse.de>
Subject: Re: [PATCH V2 02/45] migration: cpr helpers
Message-ID: <Z7S0m1dnIv674huu@x1.local>
References: <1739542467-226739-1-git-send-email-steven.sistare@oracle.com>
 <1739542467-226739-3-git-send-email-steven.sistare@oracle.com>
 <Z69xPYAJcOjlSpff@x1.local>
 <ee12d6ec-13fa-4e66-ba27-97fdb1f49f74@oracle.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <ee12d6ec-13fa-4e66-ba27-97fdb1f49f74@oracle.com>
Received-SPF: pass client-ip=170.10.133.124; envelope-from=peterx@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -24
X-Spam_score: -2.5
X-Spam_bar: --
X-Spam_report: (-2.5 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.423,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H2=0.001,
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

On Fri, Feb 14, 2025 at 03:31:29PM -0500, Steven Sistare wrote:
> On 2/14/2025 11:37 AM, Peter Xu wrote:
> > On Fri, Feb 14, 2025 at 06:13:44AM -0800, Steve Sistare wrote:
> > > Add cpr_needed_for_reuse, cpr_resave_fd helpers, cpr_is_incoming, and
> > > cpr_open_fd, for use when adding cpr support for vfio and iommufd.
> > > 
> > > Signed-off-by: Steve Sistare <steven.sistare@oracle.com>
> > > ---
> > >   include/migration/cpr.h |  6 ++++++
> > >   migration/cpr.c         | 44 ++++++++++++++++++++++++++++++++++++++++++++
> > >   2 files changed, 50 insertions(+)
> > > 
> > > diff --git a/include/migration/cpr.h b/include/migration/cpr.h
> > > index 3a6deb7..6ad04d4 100644
> > > --- a/include/migration/cpr.h
> > > +++ b/include/migration/cpr.h
> > > @@ -18,15 +18,21 @@
> > >   void cpr_save_fd(const char *name, int id, int fd);
> > >   void cpr_delete_fd(const char *name, int id);
> > >   int cpr_find_fd(const char *name, int id);
> > > +void cpr_resave_fd(const char *name, int id, int fd);
> > > +int cpr_open_fd(const char *path, int flags, const char *name, int id,
> > > +                bool *reused, Error **errp);
> > >   MigMode cpr_get_incoming_mode(void);
> > >   void cpr_set_incoming_mode(MigMode mode);
> > > +bool cpr_is_incoming(void);
> > >   int cpr_state_save(MigrationChannel *channel, Error **errp);
> > >   int cpr_state_load(MigrationChannel *channel, Error **errp);
> > >   void cpr_state_close(void);
> > >   struct QIOChannel *cpr_state_ioc(void);
> > > +bool cpr_needed_for_reuse(void *opaque);
> > > +
> > >   QEMUFile *cpr_transfer_output(MigrationChannel *channel, Error **errp);
> > >   QEMUFile *cpr_transfer_input(MigrationChannel *channel, Error **errp);
> > > diff --git a/migration/cpr.c b/migration/cpr.c
> > > index 584b0b9..12c489b 100644
> > > --- a/migration/cpr.c
> > > +++ b/migration/cpr.c
> > > @@ -95,6 +95,39 @@ int cpr_find_fd(const char *name, int id)
> > >       trace_cpr_find_fd(name, id, fd);
> > >       return fd;
> > >   }
> > > +
> > > +void cpr_resave_fd(const char *name, int id, int fd)
> > > +{
> > > +    CprFd *elem = find_fd(&cpr_state.fds, name, id);
> > > +    int old_fd = elem ? elem->fd : -1;
> > > +
> > > +    if (old_fd < 0) {
> > > +        cpr_save_fd(name, id, fd);
> > > +    } else if (old_fd != fd) {
> > > +        error_setg(&error_fatal,
> > > +                   "internal error: cpr fd '%s' id %d value %d "
> > > +                   "already saved with a different value %d",
> > > +                   name, id, fd, old_fd);
> > 
> > How bad it is to trigger this?
> 
> Bad, cpr will likely fail the next time it is used.
> I suppose I could add a blocker instead of using error_fatal.
> But, fundamentally something unknown has gone wrong, like for
> any assertion failure, so continuing to run in an uncertain
> state seems unwise.
> 
> I have only ever seen this during development after adding buggy code.
> 
> > I wonder if cpr_save_fd() should have checked this already on duplicated
> > entries; it looks risky there too if this happens to existing cpr_save_fd()
> > callers.
> 
> Yes, I could check for dups in cpr_save_fd, though it would cost O(N) instead
> of O(1).  That seems like overkill for a bug that should only bite during new
> code development.
> 
> cpr_resave_fd is O(N), but not for error checking.  Callers use it when they
> know the fd was (or may have been) already created.  It is a programming
> convenience that simplifies the call sites.

If the caller know the fd was created, then IIUC the caller shouldn't
invoke the call.

For the other case, could you give an example when the caller may have been
created, but maybe not?  I'm a bit surprised we have such use case.

-- 
Peter Xu


