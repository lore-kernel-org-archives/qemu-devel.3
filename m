Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id ADF9CC25B74
	for <qemu-devel@archiver.kernel.org>; Thu, 16 May 2024 22:01:20 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1s7j9A-0004UU-9n; Thu, 16 May 2024 18:00:20 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <farosas@suse.de>) id 1s7j99-0004UL-4h
 for qemu-devel@nongnu.org; Thu, 16 May 2024 18:00:19 -0400
Received: from smtp-out2.suse.de ([195.135.223.131])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <farosas@suse.de>) id 1s7j97-0006eJ-3n
 for qemu-devel@nongnu.org; Thu, 16 May 2024 18:00:18 -0400
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org
 [IPv6:2a07:de40:b281:104:10:150:64:97])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by smtp-out2.suse.de (Postfix) with ESMTPS id BC8155CBA0;
 Thu, 16 May 2024 22:00:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
 t=1715896815; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=ePVHGu/nf+YQwFA2Cqn3a4qco95oycTtPTJKyllVi3Y=;
 b=FzI3/btujeyXXQJGxVVm/68iZY7Rt6lrpuUe9NVzylKUym7WSGXE8k/Mb9QnyfwOPBQsWm
 PEp7tHnSTcExZUeenK99HrmNhvbHrvEAKoaLIJoMsKxjtMsjCWIcRQcR0UxFeSsvwSSAOF
 Nhyo91rajP8DzCauWWSeXQqS1jxCM4A=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
 s=susede2_ed25519; t=1715896815;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=ePVHGu/nf+YQwFA2Cqn3a4qco95oycTtPTJKyllVi3Y=;
 b=XNDH3pn9BMTMcqpm91jn29LtqhJhwbi22ztvhmtxHZ3/1MJyF2K6VpRcgf86L4erByDIJj
 bPdSjoNoUm7aRKDQ==
Authentication-Results: smtp-out2.suse.de;
 dkim=pass header.d=suse.de header.s=susede2_rsa header.b="KN/GwaZO";
 dkim=pass header.d=suse.de header.s=susede2_ed25519 header.b=klvS5W5r
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
 t=1715896814; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=ePVHGu/nf+YQwFA2Cqn3a4qco95oycTtPTJKyllVi3Y=;
 b=KN/GwaZO9dbjNVjk916aj7McahLT4byhVPwTeOFCxYAc4B2fbztTVTmK6AoZLxLcWdya+k
 /yWsGK7ki073UHZI1pTlJ2AZrEAjNvGnX25pNNdzgmnEqks7dW16tRB0YJ3a2uWPr+/vz1
 l5FghCnSPuDWm3OSDPJM8r7vCeUewEY=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
 s=susede2_ed25519; t=1715896814;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=ePVHGu/nf+YQwFA2Cqn3a4qco95oycTtPTJKyllVi3Y=;
 b=klvS5W5riH6HD2oX/MKuKUrXMcHddD+T0aN1GnrmJry0sA/hiSDvtkgau/MheHGXYqlMYj
 U91nP+rsLnCGP/CQ==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 43666137C3;
 Thu, 16 May 2024 22:00:14 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
 by imap1.dmz-prg2.suse.org with ESMTPSA id /vbSAu6BRmYVewAAD6G6ig
 (envelope-from <farosas@suse.de>); Thu, 16 May 2024 22:00:14 +0000
From: Fabiano Rosas <farosas@suse.de>
To: =?utf-8?Q?Daniel_P=2E_Berrang=C3=A9?= <berrange@redhat.com>
Cc: qemu-devel@nongnu.org, armbru@redhat.com, Peter Xu <peterx@redhat.com>,
 Claudio Fontana <cfontana@suse.de>, Jim Fehlig <jfehlig@suse.com>
Subject: Re: [PATCH 1/9] monitor: Honor QMP request for fd removal immediately
In-Reply-To: <ZjsnJj0mxW-rdAg_@redhat.com>
References: <20240426142042.14573-1-farosas@suse.de>
 <20240426142042.14573-2-farosas@suse.de> <ZjsnJj0mxW-rdAg_@redhat.com>
Date: Thu, 16 May 2024 19:00:11 -0300
Message-ID: <87ttixto2c.fsf@suse.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
X-Spamd-Result: default: False [-4.51 / 50.00]; BAYES_HAM(-3.00)[100.00%];
 NEURAL_HAM_LONG(-1.00)[-1.000];
 R_DKIM_ALLOW(-0.20)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
 NEURAL_HAM_SHORT(-0.20)[-1.000]; MIME_GOOD(-0.10)[text/plain];
 MX_GOOD(-0.01)[]; RCVD_VIA_SMTP_AUTH(0.00)[]; ARC_NA(0.00)[];
 MIME_TRACE(0.00)[0:+]; TO_DN_SOME(0.00)[];
 MISSING_XM_UA(0.00)[]; MID_RHS_MATCH_FROM(0.00)[];
 RCVD_TLS_ALL(0.00)[]; RCPT_COUNT_FIVE(0.00)[6];
 FROM_EQ_ENVFROM(0.00)[]; FROM_HAS_DN(0.00)[];
 FUZZY_BLOCKED(0.00)[rspamd.com]; RCVD_COUNT_TWO(0.00)[2];
 DKIM_SIGNED(0.00)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
 TO_MATCH_ENVRCPT_ALL(0.00)[]; DKIM_TRACE(0.00)[suse.de:+]
X-Rspamd-Action: no action
X-Rspamd-Queue-Id: BC8155CBA0
X-Rspamd-Server: rspamd1.dmz-prg2.suse.org
Received-SPF: pass client-ip=195.135.223.131; envelope-from=farosas@suse.de;
 helo=smtp-out2.suse.de
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

Daniel P. Berrang=C3=A9 <berrange@redhat.com> writes:

> On Fri, Apr 26, 2024 at 11:20:34AM -0300, Fabiano Rosas wrote:
>> We're enabling using the fdset interface to pass file descriptors for
>> use in the migration code. Since migrations can happen more than once
>> during the VMs lifetime, we need a way to remove an fd from the fdset
>> at the end of migration.
>>=20
>> The current code only removes an fd from the fdset if the VM is
>> running. This causes a QMP call to "remove-fd" to not actually remove
>> the fd if the VM happens to be stopped.
>>=20
>> While the fd would eventually be removed when monitor_fdset_cleanup()
>> is called again, the user request should be honored and the fd
>> actually removed. Calling remove-fd + query-fdset shows a recently
>> removed fd still present.
>>=20
>> The runstate_is_running() check was introduced by commit ebe52b592d
>> ("monitor: Prevent removing fd from set during init"), which by the
>> shortlog indicates that they were trying to avoid removing an
>> yet-unduplicated fd too early.
>
> IMHO that should be reverted. The justification says
>
>   "If an fd is added to an fd set via the command line, and it is not
>    referenced by another command line option (ie. -drive), then clean
>    it up after QEMU initialization is complete"
>
> which I think is pretty weak. Why should QEMU forceably stop an app
> from passing in an FD to be used by a QMP command issued just after
> the VM starts running ?  While it could just use QMP to pass in the
> FD set, the mgmt app might have its own reason for wanting QEMU to
> own the passed FD from the very start of the process execve().

I don't think that's what that patch does. That description is
misleading. I read it as:

   "If an fd is added to an fd set via the command line, and it is not
    referenced by another command line option (ie. -drive), then clean
    it up ONLY after QEMU initialization is complete"
          ^

By the subject ("monitor: Prevent removing fd from set during init") and
the fact that this function is only called when the monitor connection
closes, I believe the idea was to *save* the fds until after the VM
starts running, i.e. some fd was being lost because
monitor_fdset_cleanup() was being called before the dup().

See my reply to Peter in this same patch (PATCH 1/9).

>
> Implicitly this cleanup is attempting to "fix" a bug where the mgmt
> app passes in an FD that it never needed. If any such bug were ever
> found, then the mgmt app should just be fixed to not pass it in. I
> don't think QEMU needs to be trying to fix mgmt app bugs.
>
> IOW, this commit is imposing an arbitrary & unecessary usage policy
> on passed in FD sets, and as your commit explains has further
> unhelpful (& undocumented) side effects on the 'remove-fd' QMP command.
>
> Just revert it IMHO.
>
>>=20
>> I don't see why an fd explicitly removed with qmp_remove_fd() should
>> be under runstate_is_running(). I'm assuming this was a mistake when
>> adding the parenthesis around the expression.
>>=20
>> Move the runstate_is_running() check to apply only to the
>> QLIST_EMPTY(dup_fds) side of the expression and ignore it when
>> mon_fdset_fd->removed has been explicitly set.
>>=20
>> Signed-off-by: Fabiano Rosas <farosas@suse.de>
>> ---
>>  monitor/fds.c | 6 +++---
>>  1 file changed, 3 insertions(+), 3 deletions(-)
>>=20
>> diff --git a/monitor/fds.c b/monitor/fds.c
>> index d86c2c674c..4ec3b7eea9 100644
>> --- a/monitor/fds.c
>> +++ b/monitor/fds.c
>> @@ -173,9 +173,9 @@ static void monitor_fdset_cleanup(MonFdset *mon_fdse=
t)
>>      MonFdsetFd *mon_fdset_fd_next;
>>=20=20
>>      QLIST_FOREACH_SAFE(mon_fdset_fd, &mon_fdset->fds, next, mon_fdset_f=
d_next) {
>> -        if ((mon_fdset_fd->removed ||
>> -                (QLIST_EMPTY(&mon_fdset->dup_fds) && mon_refcount =3D=
=3D 0)) &&
>> -                runstate_is_running()) {
>> +        if (mon_fdset_fd->removed ||
>> +            (QLIST_EMPTY(&mon_fdset->dup_fds) && mon_refcount =3D=3D 0 =
&&
>> +             runstate_is_running())) {
>>              close(mon_fdset_fd->fd);
>>              g_free(mon_fdset_fd->opaque);
>>              QLIST_REMOVE(mon_fdset_fd, next);
>> --=20
>> 2.35.3
>>=20
>
> With regards,
> Daniel

