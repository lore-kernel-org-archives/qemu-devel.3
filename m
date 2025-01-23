Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B9BF4C02182
	for <qemu-devel@archiver.kernel.org>; Thu, 23 Jan 2025 16:28:25 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tb03G-0003sD-Pb; Thu, 23 Jan 2025 11:27:30 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peterx@redhat.com>) id 1tb03E-0003rb-Im
 for qemu-devel@nongnu.org; Thu, 23 Jan 2025 11:27:28 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peterx@redhat.com>) id 1tb03B-0002im-I3
 for qemu-devel@nongnu.org; Thu, 23 Jan 2025 11:27:28 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1737649643;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=jiHaSi8IYXTFN/JmWBChIdVCOvJJCBl84FgXImtE/2U=;
 b=eIWWroLjAtsw62741UAAXpSWiuw+A1cL82DzcBvbJkJD6g3RpH7zTXxp5Lq8G/8BsWzQvU
 63FFf4Qculz296pAi0tyaYqgdqEHUn/FnDHztuVvnjVPw8RYlUoGYi2nTKPoy0yQp7AsCK
 wyBZuCXadU4Vv1SXgcYJoJTqSxzzfMQ=
Received: from mail-vs1-f69.google.com (mail-vs1-f69.google.com
 [209.85.217.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-600-PJJDKwncOreIQMbX7q5o2A-1; Thu, 23 Jan 2025 11:27:22 -0500
X-MC-Unique: PJJDKwncOreIQMbX7q5o2A-1
X-Mimecast-MFC-AGG-ID: PJJDKwncOreIQMbX7q5o2A
Received: by mail-vs1-f69.google.com with SMTP id
 ada2fe7eead31-4b2be0369bfso101307137.3
 for <qemu-devel@nongnu.org>; Thu, 23 Jan 2025 08:27:22 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1737649642; x=1738254442;
 h=in-reply-to:content-transfer-encoding:content-disposition
 :mime-version:references:message-id:subject:cc:to:from:date
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=jiHaSi8IYXTFN/JmWBChIdVCOvJJCBl84FgXImtE/2U=;
 b=E+4V7R/DSEBSG85s9FRD16hV8zNnZLSpGfiMSjXv56a4KtF6VwlxiouKfHtlbprEXN
 Jgoj9qVexONw6iDV3acGKsVz/77MTnI+cImf1SYuTcn9nyzsIWXjQe8vwuwQ5qgZFFs3
 OmBDUYEjWPc8P+5tvZAYD/QtSR1efNb72Y0tYwtk+m+SKgNORj/rJLdmq5RFTun6FRJc
 UlFmaZieYR2ucwuzfszZlJk6IZqnQ/yQ9BqCnvNmHcndJXZ3BjKOsiz659n0q5nRxnJO
 yR42/ydbOyNLfZTXOMshMOf3vFXbGKEwLKzIkqiHDM48yA6TwYn/SQMLc3He9CweSwzD
 v9gg==
X-Forwarded-Encrypted: i=1;
 AJvYcCWdNHGeNUt4Z1MjRP+B5+3MPkxJk8rqZTub9qIlZ2bHIUgCe988KzRcymPmRcQXwLyS5Rd1uPtOH6ub@nongnu.org
X-Gm-Message-State: AOJu0Yy+dMFspvXCv40OJKx+4Hdbza+9zOnOf+dqb/qvrXKyXbYWsfKO
 ZXc55JICFjleXaMgIWWfrEPzhNOeXLakK+7cxOtr/OqRB98MC+NKvG7dQALxDBrf5kCVo/nGAvx
 Dgl3O3RgBGjtFfu7SthK8wqxSZIfDilVCgN+0WUd3vzUit4dkxpxu
X-Gm-Gg: ASbGnctUbVEkcL4ip172VKEtFoOxUxWFo8b5FwgxD1bckzbEgpCEEiJHdR81i2slJNr
 TOFi3n/yVCWBaF0I2Zndv9F7ny/1KnUWyTFXLFcGoyIhkE48ikcfr107QI0PGV/WhG0yvBkVL03
 9X0XN5WT4H5zH8CSpCRnoKYyHArKsSO122U7PG01G3ltmGpAODZB23cCxam6OTrzlp+rY8kQVIR
 PokJitO8nTw8FkUOU+nhjy41Nw85aMvwxaj+M3fiF9L5safHO+oUjn+YdR6wYaLMMqk9h0wmbdS
 WSShfu0YFQHj5v3sGcs3YKEzyN+fZpw=
X-Received: by 2002:a05:6102:2928:b0:4b1:1abe:6131 with SMTP id
 ada2fe7eead31-4b690d65924mr21749914137.25.1737649641851; 
 Thu, 23 Jan 2025 08:27:21 -0800 (PST)
X-Google-Smtp-Source: AGHT+IHee0qHkNRG6mP4qYXi3mAvnBFgeLFokmESZQWltd/8vA48hIi4p/nJYOYk7wmxXEM3QgqXew==
X-Received: by 2002:a05:6102:2928:b0:4b1:1abe:6131 with SMTP id
 ada2fe7eead31-4b690d65924mr21749849137.25.1737649641376; 
 Thu, 23 Jan 2025 08:27:21 -0800 (PST)
Received: from x1n (pool-99-254-114-190.cpe.net.cable.rogers.com.
 [99.254.114.190]) by smtp.gmail.com with ESMTPSA id
 a1e0cc1a2514c-8642cb0982dsm3492944241.17.2025.01.23.08.27.18
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 23 Jan 2025 08:27:19 -0800 (PST)
Date: Thu, 23 Jan 2025 11:27:15 -0500
From: Peter Xu <peterx@redhat.com>
To: Shivam Kumar <shivam.kumar1@nutanix.com>
Cc: Fabiano Rosas <farosas@suse.de>,
 "qemu-devel@nongnu.org" <qemu-devel@nongnu.org>
Subject: Re: [RFC PATCH] Fix race in live migration failure path
Message-ID: <Z5Jt434QBy92NnBM@x1n>
References: <20250110100707.4805-1-shivam.kumar1@nutanix.com>
 <87frlqerxp.fsf@suse.de> <Z4U_emPVDfTb1VmF@x1n>
 <0C92F4E5-56EE-4036-927C-2F06F9F29252@nutanix.com>
 <Z5EfapuXuV7oFL7A@x1n>
 <35F19D15-7FD0-43D1-B6A0-2FBB5FD9313B@nutanix.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <35F19D15-7FD0-43D1-B6A0-2FBB5FD9313B@nutanix.com>
Received-SPF: pass client-ip=170.10.133.124; envelope-from=peterx@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -50
X-Spam_score: -5.1
X-Spam_bar: -----
X-Spam_report: (-5.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-2.996,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H2=-0.043,
 RCVD_IN_VALIDITY_CERTIFIED_BLOCKED=0.001, RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001,
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

On Thu, Jan 23, 2025 at 09:53:16AM +0000, Shivam Kumar wrote:
> 
> 
> > On 22 Jan 2025, at 10:10 PM, Peter Xu <peterx@redhat.com> wrote:
> > 
> > !-------------------------------------------------------------------|
> >  CAUTION: External Email
> > 
> > |-------------------------------------------------------------------!
> > 
> > Hi, Shivam,
> > 
> > On Wed, Jan 22, 2025 at 10:54:17AM +0000, Shivam Kumar wrote:
> >> There is one place where we set the migration status to FAILED but we don’t set
> >> s->error, i.e. in save_snapshot workflow, please check qemu_savevm_state but
> >> not sure setting s->error in this case is possible (or required), as it seems a
> >> different workflow to me.
> > 
> > Yes it's very different indeed.  I may not yet fully get the challenge on
> > how switching to s->error (implies FAILING) would affect this one, though.
> > I mean, in qemu_savevm_state() it tries to fetch qemufile errors with:
> > 
> >    ret = qemu_file_get_error(f);
> > 
> > IIUC we could also try to fetch s->error just like what migration thread
> > does, and if it sets means it's failing?
> Yes, I can just set s->error in qemu_savevm_state.
> @@ -1686,7 +1686,6 @@ static int qemu_savevm_state(QEMUFile *f, Error **errp)
> -        status = MIGRATION_STATUS_FAILED;
> +       s->error = *errp;
> But my question was: is migrate_fd_cleanup called (where we will set the status
> to FAILED if s->error is set) in the snapshot workflow? 

I see what you meant.  It's not called indeed. We may need to process it
the same as what migrate_fd_cleanup() does.

So far the snapshot code reuses migration code in a partial way, so it's
not crystal clear where the line is, e.g., obviously it still moves the
migration state machine but it never shows "active" phase at all (even if
it has a major chunk of duration that it's actively migrating the data to
the snapshot files).  Here the state machine only goes from SETUP to either
FAILED or COMPLETED.

From that POV looks like we should duplicate such s->error detection logic
here on deciding whether to switch to FAILED, if we treat s->error as the
internal "single failure point" for migration.

> > 
> >> 
> >> In addition, one potentially real problem that I see is this comment in
> >> migration_detect_error:
> >> /*
> >> * For postcopy, we allow the network to be down for a
> >> * while. After that, it can be continued by a
> >> * recovery phase.
> >> */
> >> Let's say if we set s->error at some place and there was a file error on either
> >> source or destination (qemu_file_get_error_obj_any returns a positive value
> > 
> > This is trivial, but I suppose you meant s/positive/negative/ here.. as
> > qemufile's last_error should always be negative, iiuc.
> > 
> >> when called by migration_detect_error). We expect migration to fail in this
> >> case but migration will continue to run since post-copy migration is tolerant
> >> to file errors?
> > 
> > Yes it can halt at postcopy_pause().  I'm not yet understand why it's an
> > issue to using s->error, though.
> > 
> > In general, I'm thinking whether we could also check s->error in detect
> > error path like this:
> > 
> > ===8<===
> > diff --git a/migration/migration.c b/migration/migration.c
> > index 2d1da917c7..fbd97395e0 100644
> > --- a/migration/migration.c
> > +++ b/migration/migration.c
> > @@ -3015,17 +3015,17 @@ static MigThrError migration_detect_error(MigrationState *s)
> >     ret = qemu_file_get_error_obj_any(s->to_dst_file,
> >                                       s->postcopy_qemufile_src,
> >                                       &local_error);
> > -    if (!ret) {
> > -        /* Everything is fine */
> > -        assert(!local_error);
> > -        return MIG_THR_ERR_NONE;
> > -    }
> > -
> > -    if (local_error) {
> > +    if (ret) {
> > +        /* Passover qemufile errors to s->error */
> > +        assert(local_error);
> >         migrate_set_error(s, local_error);
> >         error_free(local_error);
> >     }
> > 
> > +    if (!migrate_has_error(s)) {
> > +        return MIG_THR_ERR_NONE;
> > +    }
> > +
> >     if (state == MIGRATION_STATUS_POSTCOPY_ACTIVE && ret) {
> >         /*
> >          * For postcopy, we allow the network to be down for a
> > @@ -3037,6 +3037,8 @@ static MigThrError migration_detect_error(MigrationState *s)
> >         /*
> >          * For precopy (or postcopy with error outside IO), we fail
> >          * with no time.
> > +         *
> > +         * TODO: update FAILED only until the end of migration in BH.
> >          */
> >         migrate_set_state(&s->state, state, MIGRATION_STATUS_FAILED);
> >         trace_migration_thread_file_err();
> > ===8<===
> > 
> > I kept a TODO above, I would hope if you reworked everything to route
> > errors to s->error, then we can move this to the cleanup BH to avoid the
> > race.
> > 
> > Do you think that could work?
> 
> I meant: in case of post-copy, what if we have another error somewhere and
> s->error was set, but then we also saw a file error when we called
> qemu_file_get_error_obj_any. In this case, migration should fail IMO but it
> would be paused instead, right?

Yeah you got a point, but I see no good reason to cancel any postcopy
migration, no matter which error it is - either a qemufile error or another
- simply because postcopy cancel means VM crash.  There's nothing worse
that that..

So IMHO we could treat it the same as EIO errors in this case as of now,
and we always pause postcopy no matter which kind of error it hits.  At
least for non-recoverable errors we can have some active process to look
at on src QEMU instance, OTOH there's no direct benefit for us to
differenciate different error cases to crash VM earlier.

Thanks,

-- 
Peter Xu


