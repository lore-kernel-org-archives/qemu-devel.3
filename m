Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 14B6FC04FFE
	for <qemu-devel@archiver.kernel.org>; Wed,  8 May 2024 07:18:43 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1s4bZB-0003zc-8U; Wed, 08 May 2024 03:18:17 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <berrange@redhat.com>)
 id 1s4bZ0-0003y3-SZ
 for qemu-devel@nongnu.org; Wed, 08 May 2024 03:18:07 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <berrange@redhat.com>)
 id 1s4bYz-0008SZ-1P
 for qemu-devel@nongnu.org; Wed, 08 May 2024 03:18:06 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1715152684;
 h=from:from:reply-to:reply-to:subject:subject:date:date:
 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
 content-type:content-type:in-reply-to:in-reply-to:  references:references;
 bh=UxytiMw6Mms0BexpP2KHsKO0Ey2NDxCMQAtV2+hvy98=;
 b=fzpfgW9UAC3bVvzOkDqrvAP6qbF6LjfZvNFByKSztPzbvsMlM8Difuif4AUXsbhr4uJtyP
 /dCBqkFXMuf/gWAXXh/jjdUHnA54CyPbZ5F/lHTRhC3KZInbriGxbAeCiTaZnBCWaPRkLL
 GtmU8NPMKIT825l+P0ByZ4Jacvmws+Y=
Received: from mimecast-mx02.redhat.com (mimecast-mx02.redhat.com
 [66.187.233.88]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-45-xZdauqzOOd6ef6qa85PJAQ-1; Wed, 08 May 2024 03:18:02 -0400
X-MC-Unique: xZdauqzOOd6ef6qa85PJAQ-1
Received: from smtp.corp.redhat.com (int-mx03.intmail.prod.int.rdu2.redhat.com
 [10.11.54.3])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mimecast-mx02.redhat.com (Postfix) with ESMTPS id C682C800A15;
 Wed,  8 May 2024 07:18:01 +0000 (UTC)
Received: from redhat.com (unknown [10.42.28.29])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id A9EA71000DB7;
 Wed,  8 May 2024 07:18:00 +0000 (UTC)
Date: Wed, 8 May 2024 08:17:58 +0100
From: Daniel =?utf-8?B?UC4gQmVycmFuZ8Op?= <berrange@redhat.com>
To: Fabiano Rosas <farosas@suse.de>
Cc: qemu-devel@nongnu.org, armbru@redhat.com, Peter Xu <peterx@redhat.com>,
 Claudio Fontana <cfontana@suse.de>, Jim Fehlig <jfehlig@suse.com>
Subject: Re: [PATCH 1/9] monitor: Honor QMP request for fd removal immediately
Message-ID: <ZjsnJj0mxW-rdAg_@redhat.com>
References: <20240426142042.14573-1-farosas@suse.de>
 <20240426142042.14573-2-farosas@suse.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20240426142042.14573-2-farosas@suse.de>
User-Agent: Mutt/2.2.12 (2023-09-09)
X-Scanned-By: MIMEDefang 3.4.1 on 10.11.54.3
Received-SPF: pass client-ip=170.10.129.124; envelope-from=berrange@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -26
X-Spam_score: -2.7
X-Spam_bar: --
X-Spam_report: (-2.7 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.581,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H4=0.001, RCVD_IN_MSPIKE_WL=0.001,
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
Reply-To: Daniel =?utf-8?B?UC4gQmVycmFuZ8Op?= <berrange@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org

On Fri, Apr 26, 2024 at 11:20:34AM -0300, Fabiano Rosas wrote:
> We're enabling using the fdset interface to pass file descriptors for
> use in the migration code. Since migrations can happen more than once
> during the VMs lifetime, we need a way to remove an fd from the fdset
> at the end of migration.
> 
> The current code only removes an fd from the fdset if the VM is
> running. This causes a QMP call to "remove-fd" to not actually remove
> the fd if the VM happens to be stopped.
> 
> While the fd would eventually be removed when monitor_fdset_cleanup()
> is called again, the user request should be honored and the fd
> actually removed. Calling remove-fd + query-fdset shows a recently
> removed fd still present.
> 
> The runstate_is_running() check was introduced by commit ebe52b592d
> ("monitor: Prevent removing fd from set during init"), which by the
> shortlog indicates that they were trying to avoid removing an
> yet-unduplicated fd too early.

IMHO that should be reverted. The justification says

  "If an fd is added to an fd set via the command line, and it is not
   referenced by another command line option (ie. -drive), then clean
   it up after QEMU initialization is complete"

which I think is pretty weak. Why should QEMU forceably stop an app
from passing in an FD to be used by a QMP command issued just after
the VM starts running ?  While it could just use QMP to pass in the
FD set, the mgmt app might have its own reason for wanting QEMU to
own the passed FD from the very start of the process execve().

Implicitly this cleanup is attempting to "fix" a bug where the mgmt
app passes in an FD that it never needed. If any such bug were ever
found, then the mgmt app should just be fixed to not pass it in. I
don't think QEMU needs to be trying to fix mgmt app bugs.

IOW, this commit is imposing an arbitrary & unecessary usage policy
on passed in FD sets, and as your commit explains has further
unhelpful (& undocumented) side effects on the 'remove-fd' QMP command.

Just revert it IMHO.

> 
> I don't see why an fd explicitly removed with qmp_remove_fd() should
> be under runstate_is_running(). I'm assuming this was a mistake when
> adding the parenthesis around the expression.
> 
> Move the runstate_is_running() check to apply only to the
> QLIST_EMPTY(dup_fds) side of the expression and ignore it when
> mon_fdset_fd->removed has been explicitly set.
> 
> Signed-off-by: Fabiano Rosas <farosas@suse.de>
> ---
>  monitor/fds.c | 6 +++---
>  1 file changed, 3 insertions(+), 3 deletions(-)
> 
> diff --git a/monitor/fds.c b/monitor/fds.c
> index d86c2c674c..4ec3b7eea9 100644
> --- a/monitor/fds.c
> +++ b/monitor/fds.c
> @@ -173,9 +173,9 @@ static void monitor_fdset_cleanup(MonFdset *mon_fdset)
>      MonFdsetFd *mon_fdset_fd_next;
>  
>      QLIST_FOREACH_SAFE(mon_fdset_fd, &mon_fdset->fds, next, mon_fdset_fd_next) {
> -        if ((mon_fdset_fd->removed ||
> -                (QLIST_EMPTY(&mon_fdset->dup_fds) && mon_refcount == 0)) &&
> -                runstate_is_running()) {
> +        if (mon_fdset_fd->removed ||
> +            (QLIST_EMPTY(&mon_fdset->dup_fds) && mon_refcount == 0 &&
> +             runstate_is_running())) {
>              close(mon_fdset_fd->fd);
>              g_free(mon_fdset_fd->opaque);
>              QLIST_REMOVE(mon_fdset_fd, next);
> -- 
> 2.35.3
> 

With regards,
Daniel
-- 
|: https://berrange.com      -o-    https://www.flickr.com/photos/dberrange :|
|: https://libvirt.org         -o-            https://fstop138.berrange.com :|
|: https://entangle-photo.org    -o-    https://www.instagram.com/dberrange :|


