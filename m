Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 415F1C25B78
	for <qemu-devel@archiver.kernel.org>; Tue,  4 Jun 2024 23:41:18 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sEdlE-0001ys-Pw; Tue, 04 Jun 2024 19:40:12 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <dg@treblig.org>) id 1sEdlC-0001y4-GW
 for qemu-devel@nongnu.org; Tue, 04 Jun 2024 19:40:10 -0400
Received: from mx.treblig.org ([2a00:1098:5b::1])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <dg@treblig.org>) id 1sEdl9-00048l-Kd
 for qemu-devel@nongnu.org; Tue, 04 Jun 2024 19:40:09 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=treblig.org
 ; s=bytemarkmx;
 h=Content-Type:MIME-Version:Message-ID:Subject:From:Date:From
 :Subject; bh=rqfxnwFf2L7kB9JZHRSSJR6MuNWpQOMgV+n1qyCa0NA=; b=pWSQvDCI7xcKnYXG
 8HrPtDkmKazFpqc1rvmCHUoz544bs9a7zFf4MugnoYX4ks0/Tz4WEpE4Ya1Bkep1VIGjhM4OX53ax
 81m7ZHPYL03QV6S49gUlel66oATC2HzYZLufYnztaiav8AAgE7SQVShIXDjDTuxQYmSag80eSWijS
 YhN9sQvhxJufVf5RGPKZdgjarrc9y+/8o/p3aWiyRxq+suN+9AVhcMrMR/YkDQELv0GMBanMqhrGg
 sDrlDNh/TvARs3Y9Fh51TQicVMLFIKTpscDljUzljC6ewbFZM5WMK6+B3kiGwqUPyMvnjYvHK2/bF
 VPGUt7btZP/giPNLGQ==;
Received: from dg by mx.treblig.org with local (Exim 4.96)
 (envelope-from <dg@treblig.org>) id 1sEdl3-004JQ4-2U;
 Tue, 04 Jun 2024 23:40:01 +0000
Date: Tue, 4 Jun 2024 23:40:01 +0000
From: "Dr. David Alan Gilbert" <dave@treblig.org>
To: Fabiano Rosas <farosas@suse.de>
Cc: Peter Xu <peterx@redhat.com>, qemu-devel@nongnu.org,
 berrange@redhat.com, armbru@redhat.com,
 Claudio Fontana <cfontana@suse.de>, Jim Fehlig <jfehlig@suse.com>
Subject: Re: [PATCH v2 06/18] monitor: Stop removing non-duplicated fds
Message-ID: <Zl-l0U0Azz8lgIw2@gallifrey>
References: <20240523190548.23977-1-farosas@suse.de>
 <20240523190548.23977-7-farosas@suse.de> <ZljqGitCeG9-Fi9l@x1n>
 <87o78mknpb.fsf@suse.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
In-Reply-To: <87o78mknpb.fsf@suse.de>
X-Chocolate: 70 percent or better cocoa solids preferably
X-Operating-System: Linux/6.1.0-21-amd64 (x86_64)
X-Uptime: 23:32:19 up 27 days, 10:46, 1 user, load average: 0.01, 0.02, 0.00
User-Agent: Mutt/2.2.12 (2023-09-09)
Received-SPF: pass client-ip=2a00:1098:5b::1; envelope-from=dg@treblig.org;
 helo=mx.treblig.org
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001, T_SCC_BODY_TEXT_LINE=-0.01 autolearn=ham autolearn_force=no
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

* Fabiano Rosas (farosas@suse.de) wrote:
> Peter Xu <peterx@redhat.com> writes:
> 
> > On Thu, May 23, 2024 at 04:05:36PM -0300, Fabiano Rosas wrote:
> >> We've been up until now cleaning up any file descriptors that have
> >> been passed into QEMU and never duplicated[1,2]. A file descriptor
> >> without duplicates indicates that no part of QEMU has made use of
> >> it. This approach is starting to show some cracks now that we're
> >> starting to consume fds from the migration code:
> >> 
> >> - Doing cleanup every time the last monitor connection closes works to
> >>   reap unused fds, but also has the side effect of forcing the
> >>   management layer to pass the file descriptors again in case of a
> >>   disconnect/re-connect, if that happened to be the only monitor
> >>   connection.
> >> 
> >>   Another side effect is that removing an fd with qmp_remove_fd() is
> >>   effectively delayed until the last monitor connection closes.
> >> 
> >>   The reliance on mon_refcount is also problematic because it's racy.
> >> 
> >> - Checking runstate_is_running() skips the cleanup unless the VM is
> >>   running and avoids premature cleanup of the fds, but also has the
> >>   side effect of blocking the legitimate removal of an fd via
> >>   qmp_remove_fd() if the VM happens to be in another state.
> >> 
> >>   This affects qmp_remove_fd() and qmp_query_fdsets() in particular
> >>   because requesting a removal at a bad time (guest stopped) might
> >>   cause an fd to never be removed, or to be removed at a much later
> >>   point in time, causing the query command to continue showing the
> >>   supposedly removed fd/fdset.
> >> 
> >> Note that file descriptors that *have* been duplicated are owned by
> >> the code that uses them and will be removed after qemu_close() is
> >> called. Therefore we've decided that the best course of action to
> >> avoid the undesired side-effects is to stop managing non-duplicated
> >> file descriptors.
> >> 
> >> 1- efb87c1697 ("monitor: Clean up fd sets on monitor disconnect")
> >> 2- ebe52b592d ("monitor: Prevent removing fd from set during init")
> >> 
> >> Signed-off-by: Fabiano Rosas <farosas@suse.de>
> >> ---
> >>  monitor/fds.c              | 15 ++++++++-------
> >>  monitor/hmp.c              |  2 --
> >>  monitor/monitor-internal.h |  1 -
> >>  monitor/qmp.c              |  2 --
> >>  4 files changed, 8 insertions(+), 12 deletions(-)
> >> 
> >> diff --git a/monitor/fds.c b/monitor/fds.c
> >> index 101e21720d..f7b98814fa 100644
> >> --- a/monitor/fds.c
> >> +++ b/monitor/fds.c
> >> @@ -169,6 +169,11 @@ int monitor_get_fd(Monitor *mon, const char *fdname, Error **errp)
> >>  
> >>  static void monitor_fdset_free(MonFdset *mon_fdset)
> >>  {
> >> +    /*
> >> +     * Only remove an empty fdset. The fds are owned by the user and
> >> +     * should have been removed with qmp_remove_fd(). The dup_fds are
> >> +     * owned by QEMU and should have been removed with qemu_close().
> >> +     */
> >>      if (QLIST_EMPTY(&mon_fdset->fds) && QLIST_EMPTY(&mon_fdset->dup_fds)) {
> >>          QLIST_REMOVE(mon_fdset, next);
> >>          g_free(mon_fdset);
> >> @@ -189,9 +194,7 @@ static void monitor_fdset_cleanup(MonFdset *mon_fdset)
> >>      MonFdsetFd *mon_fdset_fd_next;
> >>  
> >>      QLIST_FOREACH_SAFE(mon_fdset_fd, &mon_fdset->fds, next, mon_fdset_fd_next) {
> >> -        if ((mon_fdset_fd->removed ||
> >> -                (QLIST_EMPTY(&mon_fdset->dup_fds) && mon_refcount == 0)) &&
> >> -                runstate_is_running()) {
> >> +        if (mon_fdset_fd->removed) {
> >
> > I don't know the code well, but I like it.
> >
> >>              monitor_fdset_fd_free(mon_fdset_fd);
> >>          }
> >>      }
> >> @@ -206,7 +209,7 @@ void monitor_fdsets_cleanup(void)
> >>  
> >>      QEMU_LOCK_GUARD(&mon_fdsets_lock);
> >>      QLIST_FOREACH_SAFE(mon_fdset, &mon_fdsets, next, mon_fdset_next) {
> >> -        monitor_fdset_cleanup(mon_fdset);
> >> +        monitor_fdset_free(mon_fdset);
> >>      }
> >>  }
> >>  
> >> @@ -479,9 +482,7 @@ void monitor_fdset_dup_fd_remove(int dup_fd)
> >>              if (mon_fdset_fd_dup->fd == dup_fd) {
> >>                  QLIST_REMOVE(mon_fdset_fd_dup, next);
> >>                  g_free(mon_fdset_fd_dup);
> >> -                if (QLIST_EMPTY(&mon_fdset->dup_fds)) {
> >> -                    monitor_fdset_cleanup(mon_fdset);
> >> -                }
> >> +                monitor_fdset_free(mon_fdset);
> >
> > This and above changes are not crystal clear to me where the _cleanup()
> > does extra check "removed" and clean those fds.
> >
> > I think it'll make it easier for me to understand if this one and the next
> > are squashed together.  But maybe it's simply because I didn't fully
> > understand.
> 
> monitor_fdsets_cleanup() was doing three things previously:
> 
> 1- Remove the removed=true fds. This is weird, but ok.
> 
> 2- Remove fds from an fdset that has an empty dup_fds list, but only if
> the guest is not running and the monitor is closed. This is problematic.
> 
> 3- Remove/free fdsets that have become empty due to the above
> removals. This is ok.
> 
> This patch covers (2), because that is the only change that has a
> complex reasoning behind it and we need to document that without
> conflating it with the rest of the changes.

The ebe52b592d you reference, makes me think that the only reason for the
'is not running' was as a way to detect when init had finished; and there
are certainly better ways to do that (now?).

However, the efb87c1697 talks about cleaning up non-dup's on all monitors
closed, to stop getting left-over fd's that were added but then not used
(because a disconnect happened between adding and being used).
In your world when do these get cleaned up?

Dave

> Since (3) is still a reasonable thing to do, this patch merely keeps it
> around, but using the helpers introduced in the previous patch.
> 
> The next patch removed the need for (1), making the removal immediate
> instead of delayed. It has it's own much less complex reasoning, which
> is: "we don't need to wait to remove the fd".
> 
> I hope this clarifies a bit. I would prefer if we kept this and the next
> patch separate to avoid having a single patch that does too many
> things. I hope to be as explicit as possible with the reason behind
> these changes to avoid putting future people in the situation that we
> are in now, i.e. having to guess at the reasons behind this code.
> 
> If you still think we should squash or if you have more questions, let
> me know.
> 
> >>                  return;
> >>              }
> >>          }
> >> diff --git a/monitor/hmp.c b/monitor/hmp.c
> >> index 69c1b7e98a..460e8832f6 100644
> >> --- a/monitor/hmp.c
> >> +++ b/monitor/hmp.c
> >> @@ -1437,11 +1437,9 @@ static void monitor_event(void *opaque, QEMUChrEvent event)
> >>              monitor_resume(mon);
> >>          }
> >>          qemu_mutex_unlock(&mon->mon_lock);
> >> -        mon_refcount++;
> >>          break;
> >>  
> >>      case CHR_EVENT_CLOSED:
> >> -        mon_refcount--;
> >>          monitor_fdsets_cleanup();
> >>          break;
> >>  
> >> diff --git a/monitor/monitor-internal.h b/monitor/monitor-internal.h
> >> index 252de85681..cb628f681d 100644
> >> --- a/monitor/monitor-internal.h
> >> +++ b/monitor/monitor-internal.h
> >> @@ -168,7 +168,6 @@ extern bool qmp_dispatcher_co_shutdown;
> >>  extern QmpCommandList qmp_commands, qmp_cap_negotiation_commands;
> >>  extern QemuMutex monitor_lock;
> >>  extern MonitorList mon_list;
> >> -extern int mon_refcount;
> >>  
> >>  extern HMPCommand hmp_cmds[];
> >>  
> >> diff --git a/monitor/qmp.c b/monitor/qmp.c
> >> index a239945e8d..5e538f34c0 100644
> >> --- a/monitor/qmp.c
> >> +++ b/monitor/qmp.c
> >> @@ -466,7 +466,6 @@ static void monitor_qmp_event(void *opaque, QEMUChrEvent event)
> >>          data = qmp_greeting(mon);
> >>          qmp_send_response(mon, data);
> >>          qobject_unref(data);
> >> -        mon_refcount++;
> >>          break;
> >>      case CHR_EVENT_CLOSED:
> >>          /*
> >> @@ -479,7 +478,6 @@ static void monitor_qmp_event(void *opaque, QEMUChrEvent event)
> >>          json_message_parser_destroy(&mon->parser);
> >>          json_message_parser_init(&mon->parser, handle_qmp_command,
> >>                                   mon, NULL);
> >> -        mon_refcount--;
> >>          monitor_fdsets_cleanup();
> >>          break;
> >>      case CHR_EVENT_BREAK:
> >
> > I like this too when mon_refcount can be dropped.  It turns out I like this
> > patch and the next a lot, and I hope nothing will break.
> >
> > Aside, you seem to have forgot removal of the "int mon_refcount" in
> > monitor.c.
> 
> Yes, I'll fix that. Thanks.
-- 
 -----Open up your eyes, open up your mind, open up your code -------   
/ Dr. David Alan Gilbert    |       Running GNU/Linux       | Happy  \ 
\        dave @ treblig.org |                               | In Hex /
 \ _________________________|_____ http://www.treblig.org   |_______/

