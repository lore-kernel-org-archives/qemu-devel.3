Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6D1A5C5AE49
	for <qemu-devel@archiver.kernel.org>; Mon, 10 Aug 2026 13:16:34 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wtPr0-0001cw-0O; Mon, 10 Aug 2026 09:15:46 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <berrange@redhat.com>)
 id 1wtPqw-0001cO-2Z
 for qemu-devel@nongnu.org; Mon, 10 Aug 2026 09:15:43 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <berrange@redhat.com>)
 id 1wtPqu-0003Km-6V
 for qemu-devel@nongnu.org; Mon, 10 Aug 2026 09:15:41 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1786367738;
 h=from:from:reply-to:reply-to:subject:subject:date:date:
 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
 content-type:content-type:in-reply-to:in-reply-to:  references:references;
 bh=GFwQEigmQpv30RLsFnfz7dZeZf2oJ6FAvtHfAWVcGZk=;
 b=dnG5qxUchN8Cp+vsVvcAwW7TuBSz/htV5cdEYAj7z3J9GD3rgLY3qei77YkAiGqWy6GOjr
 9Jpw9Yztn7O3chMzDmAwlNmIzXqE2XEnJycBk9/0mBwDyFqDVaoMl+1XegEsx0d6o9srzd
 CjGG1cSrHjKxgeOWxoX9/bC/k/RzFvE=
Received: from mx-prod-mc-03.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-453-itzXDp3eMo--qjkqUzEufA-1; Mon,
 10 Aug 2026 09:15:35 -0400
X-MC-Unique: itzXDp3eMo--qjkqUzEufA-1
X-Mimecast-MFC-AGG-ID: itzXDp3eMo--qjkqUzEufA_1786367734
Received: from mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.111])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-03.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 074851956041; Mon, 10 Aug 2026 13:15:34 +0000 (UTC)
Received: from redhat.com (headnet03.pony-001.prod.iad2.dc.redhat.com
 [10.2.32.114])
 by mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 777D418005BB; Mon, 10 Aug 2026 13:15:32 +0000 (UTC)
Date: Mon, 10 Aug 2026 14:15:29 +0100
From: Daniel =?utf-8?B?UC4gQmVycmFuZ8Op?= <berrange@redhat.com>
To: Peter Maydell <peter.maydell@linaro.org>
Cc: Kostiantyn Kostiuk <kkostiuk@redhat.com>, qemu-devel@nongnu.org,
 Valentino Paulon <valentino.paulon88@gmail.com>,
 Yan Vugenfirer <yvugenfi@redhat.com>, Michael Roth <michael.roth@amd.com>
Subject: Re: [PATCH v2] qga: Change effective user/group ID in guest-ssh-*
 commands
Message-ID: <annO8S5K3d5bazUY@redhat.com>
References: <20260810104659.82320-1-kkostiuk@redhat.com>
 <CAFEAcA_XugKUBOnfw4t1DKWYrE7B364HimYtBdLJ6CeEj1JW5A@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <CAFEAcA_XugKUBOnfw4t1DKWYrE7B364HimYtBdLJ6CeEj1JW5A@mail.gmail.com>
User-Agent: Mutt/2.4.0 (2026-06-19)
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.111
Received-SPF: pass client-ip=170.10.129.124; envelope-from=berrange@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: 5
X-Spam_score: 0.5
X-Spam_bar: /
X-Spam_report: (0.5 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.746,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H2=0.001, RCVD_IN_SBL_CSS=3.335,
 SPF_HELO_PASS=-0.001, SPF_PASS=-0.001 autolearn=no autolearn_force=no
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
Reply-To: Daniel =?utf-8?B?UC4gQmVycmFuZ8Op?= <berrange@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org

On Mon, Aug 10, 2026 at 02:01:53PM +0100, Peter Maydell wrote:
> On Mon, 10 Aug 2026 at 11:47, Kostiantyn Kostiuk <kkostiuk@redhat.com> wrote:
> >
> > Before this commit, when qmp_guest_ssh_add_authorized_keys adds an
> > SSH key for an existing local user, the agent (running as root) decides
> > whether to create the user's .ssh directory with a symlink-following
> > directory test, and then writes and chowns the authorized_keys file.
> > A local unprivileged user who owns their home directory can pre-stage
> > their .ssh directory (or the authorized_keys file) as a symbolic link
> > so that, when the host or operator triggers a key add for that user,
> > the root agent follows the link and transfers ownership of an arbitrary
> > root-owned file or directory to the unprivileged user, who can then rewrite
> > it to obtain root.
> >
> > Fixes: CVE-2026-12080
> > Fixes: https://gitlab.com/qemu-project/qemu/-/work_items/3929
> >
> > v1: https://patchew.org/QEMU/20260709105707.91209-1-kkostiuk@redhat.com/
> > v2 -> v1:
> > Change effective user/group ID instead of checking for symlinks and
> > changing ownership of the file.
> >
> > Reported-by: Valentino Paulon <valentino.paulon88@gmail.com>
> > Signed-off-by: Kostiantyn Kostiuk <kkostiuk@redhat.com>
> 
> 
> 
> > @@ -135,6 +139,29 @@ qmp_guest_ssh_add_authorized_keys(const char *username, strList *keys,
> >          return;
> >      }
> >
> > +    euid = geteuid();
> > +    egid = getegid();
> > +#ifndef QGA_BUILD_UNIT_TEST
> > +    /* The initgroups requires CAP_SETGID. During build time unit tests, we can't do this. */
> > +    if (initgroups(p->pw_name, p->pw_gid) == -1) {
> > +        error_setg_errno(errp, errno, "failed to set group for user '%s'",
> > +                         p->pw_name);
> > +        return;
> > +    }
> > +#endif
> > +    if (setegid(p->pw_gid) == -1) {
> > +        error_setg_errno(errp, errno, "failed to set effective group ID for user '%s'",
> > +                         p->pw_name);
> > +        return;
> > +    }
> > +    if (seteuid(p->pw_uid) == -1) {
> > +        error_setg_errno(errp, errno, "failed to set effective user ID for user '%s'",
> > +                         p->pw_name);
> > +        /* Ignore errors, we can't do anything in this case */
> > +        unused_egid = setegid(egid);
> > +        return;
> > +    }
> > +
> 
> This identical bit of logic appears in three different places in this
> patch, plus we need to do the "clean it up" logic at every place we
> could return from each of the three functions. (Incidentally I think
> you've missed some of those in the remove function.)
> 
> I think it would be helpful to at least abstract out the duplicate logic
> for setup and cleanup. Maybe we should also consider using the glib
> autoptr-cleanup macros so that a set_privs_to_user() function can
> return a struct that has the old euid/egid, and then the cleanup of
> that struct enforces the "return to those IDs on function exit".

Perhaps do it as a callback, so all privs handling is isolated in
a single helper

 int run_as_user(uid_t uid, gid_t gid, int(*callback)(void *opaque));




With regards,
Daniel
-- 
|: https://berrange.com       ~~        https://hachyderm.io/@berrange :|
|: https://libvirt.org          ~~          https://entangle-photo.org :|
|: https://pixelfed.art/berrange   ~~    https://fstop138.berrange.com :|


