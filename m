Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 99599C25B74
	for <qemu-devel@archiver.kernel.org>; Thu, 16 May 2024 21:49:35 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1s7iyI-0000NV-OJ; Thu, 16 May 2024 17:49:06 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <farosas@suse.de>) id 1s7iyG-0000NG-HE
 for qemu-devel@nongnu.org; Thu, 16 May 2024 17:49:04 -0400
Received: from smtp-out1.suse.de ([195.135.223.130])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <farosas@suse.de>) id 1s7iyD-0003yG-MQ
 for qemu-devel@nongnu.org; Thu, 16 May 2024 17:49:04 -0400
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org
 [IPv6:2a07:de40:b281:104:10:150:64:97])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by smtp-out1.suse.de (Postfix) with ESMTPS id D757035011;
 Thu, 16 May 2024 21:48:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
 t=1715896139; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=EzYNMucPnhmxmAtp5346YnovFmLDtVrAhBXmG9D8MZE=;
 b=A6daOQV/X7t+gzoOPjubNql6PAenb8ykcaOKFjPUM5IBC4YqVFcgEW8yYiN9mTEhgITlZW
 MsSvtmSK1em92OV9okaQwPZ9kpOA9AmokShwZLoJoufoA2H6GTJUXw9B+Eky/+UkKk0H0U
 NDnK59SxA97y5Xie7X4WK0i/JDFVrGI=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
 s=susede2_ed25519; t=1715896139;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=EzYNMucPnhmxmAtp5346YnovFmLDtVrAhBXmG9D8MZE=;
 b=i93K/TZ8REco5qL4OK+uQYvN2fcgmuCHjaxcV01EpeWmcy90qcAIKpa3oeFDi7ZVJwf6qO
 4L9A6dwpu3aAzkAg==
Authentication-Results: smtp-out1.suse.de;
 dkim=pass header.d=suse.de header.s=susede2_rsa header.b=nyFZ27PK;
 dkim=pass header.d=suse.de header.s=susede2_ed25519 header.b=AOM2VygF
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
 t=1715896138; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=EzYNMucPnhmxmAtp5346YnovFmLDtVrAhBXmG9D8MZE=;
 b=nyFZ27PKlDi49RDAmSvDqAGYtuC0LlX2tYQXxLMKPQwgAKNkoOj4Hkkei/XjmXW2DbaTXm
 2PtQ80UJlMBaX2NFRUXDMA5ufoR1slHIAXOOULkTN3SF3wokevme0/yn4RZvbwvUj0HScX
 kWJkXoOahVqFi2DmmNj/sRGkyHuYTLk=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
 s=susede2_ed25519; t=1715896138;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=EzYNMucPnhmxmAtp5346YnovFmLDtVrAhBXmG9D8MZE=;
 b=AOM2VygFMwzFa+gnz3bCUXMnnTexPoLf4J2YUvN/mJSFkGKWUcbN2TaKpb5RdBSuDgwf7i
 ++oGb81iCGQkCYBQ==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 55620137C3;
 Thu, 16 May 2024 21:48:58 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
 by imap1.dmz-prg2.suse.org with ESMTPSA id udNBBkp/RmY5KAAAD6G6ig
 (envelope-from <farosas@suse.de>); Thu, 16 May 2024 21:48:58 +0000
From: Fabiano Rosas <farosas@suse.de>
To: Peter Xu <peterx@redhat.com>
Cc: qemu-devel@nongnu.org, berrange@redhat.com, armbru@redhat.com, Claudio
 Fontana <cfontana@suse.de>, Jim Fehlig <jfehlig@suse.com>, Corey Bryant
 <coreyb@linux.vnet.ibm.com>, Eric Blake <eblake@redhat.com>, Kevin Wolf
 <kwolf@redhat.com>
Subject: Re: [PATCH 1/9] monitor: Honor QMP request for fd removal immediately
In-Reply-To: <ZjUKk3cNVzAH6IPQ@x1n>
References: <20240426142042.14573-1-farosas@suse.de>
 <20240426142042.14573-2-farosas@suse.de> <ZjUKk3cNVzAH6IPQ@x1n>
Date: Thu, 16 May 2024 18:46:41 -0300
Message-ID: <87h6exe8fy.fsf@suse.de>
MIME-Version: 1.0
Content-Type: text/plain
X-Spamd-Result: default: False [-4.51 / 50.00]; BAYES_HAM(-3.00)[100.00%];
 NEURAL_HAM_LONG(-1.00)[-1.000];
 R_DKIM_ALLOW(-0.20)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
 NEURAL_HAM_SHORT(-0.20)[-1.000]; MIME_GOOD(-0.10)[text/plain];
 MX_GOOD(-0.01)[]; RCVD_VIA_SMTP_AUTH(0.00)[]; ARC_NA(0.00)[];
 MISSING_XM_UA(0.00)[]; RCPT_COUNT_SEVEN(0.00)[9];
 MIME_TRACE(0.00)[0:+]; MID_RHS_MATCH_FROM(0.00)[];
 RCVD_TLS_ALL(0.00)[]; TO_DN_SOME(0.00)[];
 FROM_EQ_ENVFROM(0.00)[]; FROM_HAS_DN(0.00)[];
 FUZZY_BLOCKED(0.00)[rspamd.com]; RCVD_COUNT_TWO(0.00)[2];
 TO_MATCH_ENVRCPT_ALL(0.00)[];
 DBL_BLOCKED_OPENRESOLVER(0.00)[suse.de:dkim];
 DKIM_SIGNED(0.00)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
 DKIM_TRACE(0.00)[suse.de:+]
X-Rspamd-Action: no action
X-Rspamd-Queue-Id: D757035011
X-Rspamd-Server: rspamd1.dmz-prg2.suse.org
Received-SPF: pass client-ip=195.135.223.130; envelope-from=farosas@suse.de;
 helo=smtp-out1.suse.de
X-Spam_score_int: -43
X-Spam_score: -4.4
X-Spam_bar: ----
X-Spam_report: (-4.4 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_MED=-2.3, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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

Hi all, sorry to have been away from this thread for a while, I was
trying to catch up on my reviews queue.

Peter Xu <peterx@redhat.com> writes:

> On Fri, Apr 26, 2024 at 11:20:34AM -0300, Fabiano Rosas wrote:
>> We're enabling using the fdset interface to pass file descriptors for
>> use in the migration code. Since migrations can happen more than once
>> during the VMs lifetime, we need a way to remove an fd from the fdset
>> at the end of migration.
>> 
>> The current code only removes an fd from the fdset if the VM is
>> running. This causes a QMP call to "remove-fd" to not actually remove
>> the fd if the VM happens to be stopped.
>> 
>> While the fd would eventually be removed when monitor_fdset_cleanup()
>> is called again, the user request should be honored and the fd
>> actually removed. Calling remove-fd + query-fdset shows a recently
>> removed fd still present.
>> 
>> The runstate_is_running() check was introduced by commit ebe52b592d
>> ("monitor: Prevent removing fd from set during init"), which by the
>> shortlog indicates that they were trying to avoid removing an
>> yet-unduplicated fd too early.
>> 
>> I don't see why an fd explicitly removed with qmp_remove_fd() should
>> be under runstate_is_running(). I'm assuming this was a mistake when
>> adding the parenthesis around the expression.
>> 
>> Move the runstate_is_running() check to apply only to the
>> QLIST_EMPTY(dup_fds) side of the expression and ignore it when
>> mon_fdset_fd->removed has been explicitly set.
>
> I am confused on why the fdset removal is as complicated.  I'm also
> wondering here whether it's dropped because we checked against
> "mon_refcount == 0", and maybe monitor_fdset_cleanup() is simply called
> _before_ a monitor is created?  Why do we need such check on the first
> place?
>

It seems the intention was to reuse monitor_fdset_cleanup() to do
cleanup when all monitors connections are closed:

efb87c1697 ("monitor: Clean up fd sets on monitor disconnect")
Author: Corey Bryant <coreyb@linux.vnet.ibm.com>
Date:   Tue Aug 14 16:43:48 2012 -0400

    monitor: Clean up fd sets on monitor disconnect
    
    Fd sets are shared by all monitor connections.  Fd sets are considered
    to be in use while at least one monitor is connected.  When the last
    monitor disconnects, all fds that are members of an fd set with no
    outstanding dup references are closed.  This prevents any fd leakage
    associated with a client disconnect prior to using a passed fd.
    
    Signed-off-by: Corey Bryant <coreyb@linux.vnet.ibm.com>
    Signed-off-by: Kevin Wolf <kwolf@redhat.com>

This could have been done differently at monitor_qmp_event():

    case CHR_EVENT_CLOSED:
        ...
        mon_refcount--;
        if (mon_refcount == 0) {
            monitor_fdsets_cleanup();
        }

But maybe there was a concern about making sure the empty fdsets (last
block in monitor_fdset_cleanup) were removed at every refcount decrement
and not only when mon_refcount == 0 for some reason.

> I'm thinking one case where the only QMP monitor got (for some reason)
> disconnected, and reconnected again during VM running.  Won't current code
> already lead to unwanted removal of mostly all fds due to mon_refcount==0?

I think that's the case that the patch in question was trying to
avoid. If the last monitor connects and disconnects while fds have not
been dup'ed yet, the mon_fdset->dup_fds list will be empty and what you
say will happen. There seems to be an assumption that after the guest
starts running all fds that need to be dup'ed will already have been
dup'ed.

So I think we cannot simply revert the patch as Daniel suggested,
because that might regress the original block layer use-case if a
monitor open->close causes the removal of all the yet undup'ed fds[1].

For the migration use-case, the dup() only happens after the migrate
command has been issued, so the runstate_is_running() check doesn't help
us. But it also doesn't hurt. However, we're still exposed to a monitor
disconnection removing the undup'ed fds. So AFAICS, we either stop
calling monitor_fdset_cleanup() at monitor close or declare that this
issue is unlikely to occur (because it is) and leave a comment in the
code.

===========
1- I ran a quick test:

connect()         // monitor opened: refcnt: 1

{"execute": "add-fd", "arguments": {"fdset-id": 1}}
{"return": {"fd": 9, "fdset-id": 1}}

{"execute": "add-fd", "arguments": {"fdset-id": 1}}
{"return": {"fd": 21, "fdset-id": 1}}

close()           // monitor closed: refcnt: 0

connect()         // monitor opened: refcnt: 1

{"execute": "migrate", "arguments": {"uri": "file:/dev/fdset/1,offset=4096"}}
{
    "error": {
        "class": "GenericError",
        "desc": "Outgoing migration needs two fds in the fdset, got 0"
    }
}

>
> I also am confused why ->removed flags is ever needed, and why we can't
> already remove the fdsets fds if found matching.
>

Prior to commit efb87c1697 ("monitor: Clean up fd sets on monitor
disconnect") we only called monitor_fdset_cleanup() from
qmp_remove_fd(), so we effectively always removed immediately after
setting ->removed = true. I don't see a reason to have the flag either.


