Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 21209C3DA4A
	for <qemu-devel@archiver.kernel.org>; Thu, 22 Aug 2024 13:47:55 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sh89z-0008WC-0t; Thu, 22 Aug 2024 09:47:32 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <farosas@suse.de>)
 id 1sh89p-0008So-97; Thu, 22 Aug 2024 09:47:21 -0400
Received: from smtp-out1.suse.de ([2a07:de40:b251:101:10:150:64:1])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <farosas@suse.de>)
 id 1sh89m-0001ah-Hx; Thu, 22 Aug 2024 09:47:20 -0400
Received: from imap1.dmz-prg2.suse.org (unknown [10.150.64.97])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by smtp-out1.suse.de (Postfix) with ESMTPS id D1B1B2248D;
 Thu, 22 Aug 2024 13:47:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
 t=1724334436; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=rp8smDOYGg1BPF7hFc106XPWD8EKvrNgA9WQTq39BlY=;
 b=ZG2iYe7S3UqGiO6KRABU5Orbq2YljiES4Hn26iOVl/AWMgKQJO8Ncgz+z2wJ7g/nj4010s
 cX0PJgPRY+hRDHy3xXvps6Nq0MpHoWO0b7Pb2l8Tm4HRUz0HlVcXopJUEjutdwYaLqy4T5
 9rttD7T0D728OlRPlpJFCM/n9HezZXw=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
 s=susede2_ed25519; t=1724334436;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=rp8smDOYGg1BPF7hFc106XPWD8EKvrNgA9WQTq39BlY=;
 b=g3mXCzHYuwrZPxf8lx0h4jBWnmqYVbvmqVXUGasx2kQhy4c4I7O2lFcZp/fMaPhwtkgL5W
 E6cPLiYMn7p0MVDw==
Authentication-Results: smtp-out1.suse.de;
	none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
 t=1724334435; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=rp8smDOYGg1BPF7hFc106XPWD8EKvrNgA9WQTq39BlY=;
 b=Ke0jRqDlNS2FRqxrZZNiOdnjF5X+TgU0k1y94Jd+8g464HOaBVjjWZvFAOWMXSsqwpVsoe
 uXE5o9EJBkSlj/mFoZPP42NWzJ4tYzRE2XghKFJPxYNW0fKDN7q2+2lMQz6Mq6Pism45dB
 tpT8jEpFskSKzcgPamGKSL4uO66O45Y=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
 s=susede2_ed25519; t=1724334435;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=rp8smDOYGg1BPF7hFc106XPWD8EKvrNgA9WQTq39BlY=;
 b=1rbcKJtFxOcBPg23rPWAU03i/rLumkoMD3+JytLeUjHLWqSFFI74H+HOB84n9DKIiQmjgD
 xezLfclQ2PIoKpDg==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 595E913297;
 Thu, 22 Aug 2024 13:47:15 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
 by imap1.dmz-prg2.suse.org with ESMTPSA id IHgSCGNBx2abUwAAD6G6ig
 (envelope-from <farosas@suse.de>); Thu, 22 Aug 2024 13:47:15 +0000
From: Fabiano Rosas <farosas@suse.de>
To: "Arisetty, Chakri" <carisett@akamai.com>, "qemu-devel@nongnu.org"
 <qemu-devel@nongnu.org>, "qemu-block@nongnu.org" <qemu-block@nongnu.org>
Cc: "Peter Xu" <peterx@redhat.com>, "Kevin Wolf" <kwolf@redhat.com>, "Eric
 Blake" <eblake@redhat.com>, "Blew III, Will" <wblewiii@akamai.com>,
 "Massry, Abraham" <amassry@akamai.com>, "Tottenham, Max"
 <mtottenh@akamai.com>, "Greve, Mark" <mgreve@akamai.com>
Subject: Re: Issue with QEMU Live Migration
In-Reply-To: <ACB0E3E9-BA69-4EC7-A4EB-3AF2F21D4C8A@akamai.com>
References: <1ABDAA2B-8582-4B98-81D3-8F71DE62718C@akamai.com>
 <874j7e0yjt.fsf@suse.de> <ACB0E3E9-BA69-4EC7-A4EB-3AF2F21D4C8A@akamai.com>
Date: Thu, 22 Aug 2024 10:47:12 -0300
Message-ID: <874j7czn33.fsf@suse.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
X-Spamd-Result: default: False [-4.30 / 50.00]; BAYES_HAM(-3.00)[100.00%];
 NEURAL_HAM_LONG(-1.00)[-1.000];
 NEURAL_HAM_SHORT(-0.20)[-1.000]; MIME_GOOD(-0.10)[text/plain];
 RCVD_VIA_SMTP_AUTH(0.00)[]; ARC_NA(0.00)[];
 TO_DN_EQ_ADDR_SOME(0.00)[]; RCVD_TLS_ALL(0.00)[];
 MIME_TRACE(0.00)[0:+]; MISSING_XM_UA(0.00)[];
 TO_DN_SOME(0.00)[]; REDIRECTOR_URL(0.00)[urldefense.com];
 MID_RHS_MATCH_FROM(0.00)[];
 DKIM_SIGNED(0.00)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
 FROM_EQ_ENVFROM(0.00)[]; FROM_HAS_DN(0.00)[];
 RCPT_COUNT_SEVEN(0.00)[10]; RCVD_COUNT_TWO(0.00)[2];
 FUZZY_BLOCKED(0.00)[rspamd.com]; TO_MATCH_ENVRCPT_ALL(0.00)[];
 DBL_BLOCKED_OPENRESOLVER(0.00)[suse.de:mid, suse.de:email,
 imap1.dmz-prg2.suse.org:helo]
Received-SPF: pass client-ip=2a07:de40:b251:101:10:150:64:1;
 envelope-from=farosas@suse.de; helo=smtp-out1.suse.de
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

"Arisetty, Chakri" <carisett@akamai.com> writes:

Ugh, it seems I messed up the CC addresses, let's see if this time they
go out right. For those new to the thread, we're discussing this bug:

https://gitlab.com/qemu-project/qemu/-/issues/2482

> Hi,
>
> Thank you for getting back to me.
>
> Yes, I have opened the ticket https://urldefense.com/v3/__https://gitlab.=
com/qemu-project/qemu/-/issues/2482__;!!GjvTz_vk!SCg-a5LiuAGlWyQ6Opd9urNAW4=
_Z-tUtzPZARWB1d3Ulg_ws87yL3iJcxuZPktLeHNNtPztJTJZNJdE$ <https://urldefense.=
com/v3/__https://gitlab.com/qemu-project/qemu/-/issues/2482__;!!GjvTz_vk!SC=
g-a5LiuAGlWyQ6Opd9urNAW4_Z-tUtzPZARWB1d3Ulg_ws87yL3iJcxuZPktLeHNNtPztJTJZNJ=
dE$>
>
>> So the core of the issue here is that the block job is transitioning to
>> ready while the migration is still ongoing so there's still dirtying
>> happening.
>
> Yes, this is the problem I have. RAM migration state is already moved to =
pre-switchover and mirror block job is moved to "READY" state assuming that=
 there are no more dirty blocks.
> But there are still dirty blocks and these dirty block blocks are being t=
ransferred to destination host.
>
> I've created a small patch(attached) in mirror.c to put the mirror job ba=
ck into the "RUNNING" state if there are any dirty pages.
> But I still would like to prevent RAM migration state to be moved to pre-=
switchover when there are dirty blocks.

It's still not entirely clear to me what the situation is here. When the
migration reaches pre-switchover state the VM is stopped, so there would
be no more IO happening. Is this a matter of a race condition (of sorts)
because pre-switchover happens while the block mirror job is still
transferring the final blocks? Or is it instead about the data being in
traffic over the netword and not yet reaching the destination machine?

Is the disk inactivation after the pre-switchover affecting this at all?

>
>> docs/interop/live-block-operations.rst? Section "QMP invocation for live
>> storage migration with ``drive-mirror`` + NBD", point 4 says that a
>> block-job-cancel should be issues after BLOCK_JOB_READY is
>> reached. Although there is mention of when the migration should be
>> performed.
>
> Thanks for the pointer, I've looked at this part (block-job-cancel). The =
problem is that QEMU on the source host is still transferring the dirty blo=
cks.
> That is the reason I am trying to avoid moving RAM migration state to pre=
-switchover when there are any dirty pages.
>
> is there a way in QEMU to know if the disk transfer is completed and stop=
 dirty pages being transferred?

Sorry, I can't help here. We have block layer people in CC, they might
be able to advise.

>
> Thanks
> Chakri
>
>
> =EF=BB=BFOn 8/21/24, 6:56 AM, "Fabiano Rosas" <farosas@suse.de <mailto:fa=
rosas@suse.de>> wrote:
>
>
> !-------------------------------------------------------------------|
> This Message Is From an External Sender
> This message came from outside your organization.
> |-------------------------------------------------------------------!
>
>
> "Arisetty, Chakri" <carisett@akamai.com <mailto:carisett@akamai.com>> wri=
tes:
>
>
>> Hello,
>>
>> I=E2=80=99m having trouble with live migration and I=E2=80=99m using QEM=
U 7.2.0 on Debian 11.
>>
>> Migration state switches to pre-switchover state during the RAM migratio=
n.
>>
>> My assumption is that disks are already migrated and there are no furthe=
r dirty pages to be transferred from source host to destination host. There=
fore, NBD client on the source host closes the connection to the NBD server=
 on the destination host. But we observe that there are still some dirty pa=
ges being transferred.
>> Closing prematurely NBD connection results in BLOCK JOB error.
>> In the RAM migration code (migration/migration.c), I=E2=80=99d like to c=
heck for block mirror job=E2=80=99s status before RAM migration state is mo=
ved to pre-switchover. I=E2=80=99m unable to find any block job related cod=
e in RAM migration code.
>>
>> Could someone help me figuring out what might be going wrong or suggest =
any troubleshooting steps or advice to get around the issue?
>>
>> Thanks
>> Chakri
>
>
> Hi, I believe it was you who opened this bug as well?=20
>
>
> https://urldefense.com/v3/__https://gitlab.com/qemu-project/qemu/-/issues=
/2482__;!!GjvTz_vk!SCg-a5LiuAGlWyQ6Opd9urNAW4_Z-tUtzPZARWB1d3Ulg_ws87yL3iJc=
xuZPktLeHNNtPztJTJZNJdE$ <https://urldefense.com/v3/__https://gitlab.com/qe=
mu-project/qemu/-/issues/2482__;!!GjvTz_vk!SCg-a5LiuAGlWyQ6Opd9urNAW4_Z-tUt=
zPZARWB1d3Ulg_ws87yL3iJcxuZPktLeHNNtPztJTJZNJdE$>=20
>
>
> So the core of the issue here is that the block job is transitioning to
> ready while the migration is still ongoing so there's still dirtying
> happening.
>
>
> Have you looked at the documentation at
> docs/interop/live-block-operations.rst? Section "QMP invocation for live
> storage migration with ``drive-mirror`` + NBD", point 4 says that a
> block-job-cancel should be issues after BLOCK_JOB_READY is
> reached. Although there is mention of when the migration should be
> performed.
>
>
>
> diff --git a/block/mirror.c b/block/mirror.c
> index 251adc5ae..3457afe1d 100644
> --- a/block/mirror.c
> +++ b/block/mirror.c
> @@ -1089,6 +1089,10 @@ static int coroutine_fn mirror_run(Job *job, Error=
 **errp)
>              break;
>          }
>=20=20
> +	if (cnt !=3D 0 && job_is_ready(&s->common.job)) {
> +            job_transition_to_running(&s->common.job);
> +        }
> +
>          if (job_is_ready(&s->common.job) && !should_complete) {
>              delay_ns =3D (s->in_flight =3D=3D 0 &&
>                          cnt =3D=3D 0 ? BLOCK_JOB_SLICE_TIME : 0);
> diff --git a/include/qemu/job.h b/include/qemu/job.h
> index e502787dd..87dbef0d2 100644
> --- a/include/qemu/job.h
> +++ b/include/qemu/job.h
> @@ -641,6 +641,12 @@ int job_apply_verb_locked(Job *job, JobVerb verb, Er=
ror **errp);
>   */
>  void job_early_fail(Job *job);
>=20=20
> +/**
> + * Moves the @job from RUNNING to READY.
> + * Called with job_mutex *not* held.
> + */
> +void job_transition_to_running(Job *job);
> +
>  /**
>   * Moves the @job from RUNNING to READY.
>   * Called with job_mutex *not* held.
> diff --git a/job.c b/job.c
> index 72d57f093..298d90817 100644
> --- a/job.c
> +++ b/job.c
> @@ -62,7 +62,7 @@ bool JobSTT[JOB_STATUS__MAX][JOB_STATUS__MAX] =3D {
>      /* C: */ [JOB_STATUS_CREATED]   =3D {0, 0, 1, 0, 0, 0, 0, 0, 1, 0, 1=
},
>      /* R: */ [JOB_STATUS_RUNNING]   =3D {0, 0, 0, 1, 1, 0, 1, 0, 1, 0, 0=
},
>      /* P: */ [JOB_STATUS_PAUSED]    =3D {0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 0=
},
> -    /* Y: */ [JOB_STATUS_READY]     =3D {0, 0, 0, 0, 0, 1, 1, 0, 1, 0, 0=
},
> +    /* Y: */ [JOB_STATUS_READY]     =3D {0, 0, 1, 0, 0, 1, 1, 0, 1, 0, 0=
},
>      /* S: */ [JOB_STATUS_STANDBY]   =3D {0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0=
},
>      /* W: */ [JOB_STATUS_WAITING]   =3D {0, 0, 0, 0, 0, 0, 0, 1, 1, 0, 0=
},
>      /* D: */ [JOB_STATUS_PENDING]   =3D {0, 0, 0, 0, 0, 0, 0, 0, 1, 1, 0=
},
> @@ -1035,6 +1035,12 @@ static int job_transition_to_pending_locked(Job *j=
ob)
>      return 0;
>  }
>=20=20
> +void job_transition_to_running(Job *job)
> +{
> +    JOB_LOCK_GUARD();
> +    job_state_transition_locked(job, JOB_STATUS_RUNNING);
> +}
> +
>  void job_transition_to_ready(Job *job)
>  {
>      JOB_LOCK_GUARD();

