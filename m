Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6216EC5475B
	for <qemu-devel@archiver.kernel.org>; Mon, 11 Mar 2024 19:04:55 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rjkw4-00048R-HO; Mon, 11 Mar 2024 15:03:47 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <farosas@suse.de>) id 1rjkw0-00046C-DF
 for qemu-devel@nongnu.org; Mon, 11 Mar 2024 15:03:40 -0400
Received: from smtp-out1.suse.de ([2a07:de40:b251:101:10:150:64:1])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <farosas@suse.de>) id 1rjkvt-0006iL-JM
 for qemu-devel@nongnu.org; Mon, 11 Mar 2024 15:03:40 -0400
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org
 [IPv6:2a07:de40:b281:104:10:150:64:97])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by smtp-out1.suse.de (Postfix) with ESMTPS id 8E63234FA6;
 Mon, 11 Mar 2024 19:03:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
 t=1710183809; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=sp9X9Yf0QtFaRRMtzfXBmSIFZpytHd7jrlhmbkJ2xeo=;
 b=rJcAvero5mWLO3WMg6NFeLWDmoX3EuiuRlNEP/aQKhfQGCSm12pmWvtlCSe+xBeLz6szSU
 B3dcCPxoxPViuQwiMrCSmdP0/xfku4Lal0/oy6BJ8ckOQjr6r/3V3+Az548o4iTOnp41Lg
 ehYI1bxL0TDEgQtfgEbrlEPKns0IUak=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
 s=susede2_ed25519; t=1710183809;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=sp9X9Yf0QtFaRRMtzfXBmSIFZpytHd7jrlhmbkJ2xeo=;
 b=sni563FGtNC6tLd+lu8zyiVZzNJKpCJdbozx3Rvma8ECHv+YXZO6nOSg7CZJC+dUEVRpuH
 e56IefNXSV4LlKBA==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
 t=1710183809; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=sp9X9Yf0QtFaRRMtzfXBmSIFZpytHd7jrlhmbkJ2xeo=;
 b=rJcAvero5mWLO3WMg6NFeLWDmoX3EuiuRlNEP/aQKhfQGCSm12pmWvtlCSe+xBeLz6szSU
 B3dcCPxoxPViuQwiMrCSmdP0/xfku4Lal0/oy6BJ8ckOQjr6r/3V3+Az548o4iTOnp41Lg
 ehYI1bxL0TDEgQtfgEbrlEPKns0IUak=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
 s=susede2_ed25519; t=1710183809;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=sp9X9Yf0QtFaRRMtzfXBmSIFZpytHd7jrlhmbkJ2xeo=;
 b=sni563FGtNC6tLd+lu8zyiVZzNJKpCJdbozx3Rvma8ECHv+YXZO6nOSg7CZJC+dUEVRpuH
 e56IefNXSV4LlKBA==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 3E86213695;
 Mon, 11 Mar 2024 19:03:27 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
 by imap1.dmz-prg2.suse.org with ESMTPSA id N12bM39V72XiRgAAD6G6ig
 (envelope-from <farosas@suse.de>); Mon, 11 Mar 2024 19:03:27 +0000
From: Fabiano Rosas <farosas@suse.de>
To: =?utf-8?Q?C=C3=A9dric?= Le Goater <clg@redhat.com>, qemu-devel@nongnu.org
Cc: Peter Xu <peterx@redhat.com>, Alex Williamson
 <alex.williamson@redhat.com>, Avihai Horon <avihaih@nvidia.com>, Philippe
 =?utf-8?Q?Mathieu-Daud=C3=A9?= <philmd@linaro.org>, Markus Armbruster
 <armbru@redhat.com>, Prasad Pandit <pjp@fedoraproject.org>
Subject: Re: [PATCH v4 10/25] migration: Add Error** argument to
 qemu_savevm_state_setup()
In-Reply-To: <1566715b-a9a5-4df6-8e64-f4f912e2ea2f@redhat.com>
References: <20240306133441.2351700-1-clg@redhat.com>
 <20240306133441.2351700-11-clg@redhat.com> <87plw44wps.fsf@suse.de>
 <1566715b-a9a5-4df6-8e64-f4f912e2ea2f@redhat.com>
Date: Mon, 11 Mar 2024 16:03:14 -0300
Message-ID: <87le6omw0d.fsf@suse.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Authentication-Results: smtp-out1.suse.de;
 dkim=pass header.d=suse.de header.s=susede2_rsa header.b=rJcAvero;
 dkim=pass header.d=suse.de header.s=susede2_ed25519 header.b=sni563FG
X-Spamd-Result: default: False [-3.31 / 50.00]; ARC_NA(0.00)[];
 RCVD_VIA_SMTP_AUTH(0.00)[];
 R_DKIM_ALLOW(-0.20)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
 URIBL_BLOCKED(0.00)[suse.de:dkim]; FROM_HAS_DN(0.00)[];
 TO_DN_SOME(0.00)[]; TO_MATCH_ENVRCPT_ALL(0.00)[];
 RECEIVED_SPAMHAUS_BLOCKED_OPENRESOLVER(0.00)[2a07:de40:b281:106:10:150:64:167:received];
 MIME_GOOD(-0.10)[text/plain]; BAYES_HAM(-3.00)[100.00%];
 RCVD_COUNT_THREE(0.00)[3];
 DKIM_SIGNED(0.00)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
 DKIM_TRACE(0.00)[suse.de:+]; MX_GOOD(-0.01)[];
 RCPT_COUNT_SEVEN(0.00)[8];
 DBL_BLOCKED_OPENRESOLVER(0.00)[suse.de:dkim];
 FUZZY_BLOCKED(0.00)[rspamd.com]; FROM_EQ_ENVFROM(0.00)[];
 MIME_TRACE(0.00)[0:+]; RCVD_TLS_ALL(0.00)[];
 MID_RHS_MATCH_FROM(0.00)[];
 RBL_SPAMHAUS_BLOCKED_OPENRESOLVER(0.00)[2a07:de40:b281:104:10:150:64:97:from]
X-Rspamd-Queue-Id: 8E63234FA6
X-Rspamd-Server: rspamd1.dmz-prg2.suse.org
Received-SPF: pass client-ip=2a07:de40:b251:101:10:150:64:1;
 envelope-from=farosas@suse.de; helo=smtp-out1.suse.de
X-Spam_score_int: -43
X-Spam_score: -4.4
X-Spam_bar: ----
X-Spam_report: (-4.4 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_MED=-2.3, SPF_PASS=-0.001, T_SCC_BODY_TEXT_LINE=-0.01,
 T_SPF_HELO_TEMPERROR=0.01 autolearn=ham autolearn_force=no
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

C=C3=A9dric Le Goater <clg@redhat.com> writes:

> On 3/8/24 15:36, Fabiano Rosas wrote:
>> C=C3=A9dric Le Goater <clg@redhat.com> writes:
>>=20
>>> This prepares ground for the changes coming next which add an Error**
>>> argument to the .save_setup() handler. Callers of qemu_savevm_state_set=
up()
>>> now handle the error and fail earlier setting the migration state from
>>> MIGRATION_STATUS_SETUP to MIGRATION_STATUS_FAILED.
>>>
>>> In qemu_savevm_state(), move the cleanup to preserve the error
>>> reported by .save_setup() handlers.
>>>
>>> Since the previous behavior was to ignore errors at this step of
>>> migration, this change should be examined closely to check that
>>> cleanups are still correctly done.
>>>
>>> Signed-off-by: C=C3=A9dric Le Goater <clg@redhat.com>
>>> ---
>>>
>>>   Changes in v4:
>>>=20=20=20
>>>   - Merged cleanup change in qemu_savevm_state()
>>>=20=20=20=20=20
>>>   Changes in v3:
>>>=20=20=20
>>>   - Set migration state to MIGRATION_STATUS_FAILED
>>>   - Fixed error handling to be done under lock in bg_migration_thread()
>>>   - Made sure an error is always set in case of failure in
>>>     qemu_savevm_state_setup()
>>>=20=20=20=20=20
>>>   migration/savevm.h    |  2 +-
>>>   migration/migration.c | 27 ++++++++++++++++++++++++---
>>>   migration/savevm.c    | 26 +++++++++++++++-----------
>>>   3 files changed, 40 insertions(+), 15 deletions(-)
>>>
>>> diff --git a/migration/savevm.h b/migration/savevm.h
>>> index 74669733dd63a080b765866c703234a5c4939223..9ec96a995c93a42aad62159=
5f0ed58596c532328 100644
>>> --- a/migration/savevm.h
>>> +++ b/migration/savevm.h
>>> @@ -32,7 +32,7 @@
>>>   bool qemu_savevm_state_blocked(Error **errp);
>>>   void qemu_savevm_non_migratable_list(strList **reasons);
>>>   int qemu_savevm_state_prepare(Error **errp);
>>> -void qemu_savevm_state_setup(QEMUFile *f);
>>> +int qemu_savevm_state_setup(QEMUFile *f, Error **errp);
>>>   bool qemu_savevm_state_guest_unplug_pending(void);
>>>   int qemu_savevm_state_resume_prepare(MigrationState *s);
>>>   void qemu_savevm_state_header(QEMUFile *f);
>>> diff --git a/migration/migration.c b/migration/migration.c
>>> index a49fcd53ee19df1ce0182bc99d7e064968f0317b..6d1544224e96f5edfe56939=
a9c8395d88ef29581 100644
>>> --- a/migration/migration.c
>>> +++ b/migration/migration.c
>>> @@ -3408,6 +3408,8 @@ static void *migration_thread(void *opaque)
>>>       int64_t setup_start =3D qemu_clock_get_ms(QEMU_CLOCK_HOST);
>>>       MigThrError thr_error;
>>>       bool urgent =3D false;
>>> +    Error *local_err =3D NULL;
>>> +    int ret;
>>>=20=20=20
>>>       thread =3D migration_threads_add("live_migration", qemu_get_threa=
d_id());
>>>=20=20=20
>>> @@ -3451,9 +3453,17 @@ static void *migration_thread(void *opaque)
>>>       }
>>>=20=20=20
>>>       bql_lock();
>>> -    qemu_savevm_state_setup(s->to_dst_file);
>>> +    ret =3D qemu_savevm_state_setup(s->to_dst_file, &local_err);
>>>       bql_unlock();
>>>=20=20=20
>>> +    if (ret) {
>>> +        migrate_set_error(s, local_err);
>>> +        error_free(local_err);
>>> +        migrate_set_state(&s->state, MIGRATION_STATUS_SETUP,
>>> +                          MIGRATION_STATUS_FAILED);
>>> +        goto out;
>>> +     }
>>> +
>>>       qemu_savevm_wait_unplug(s, MIGRATION_STATUS_SETUP,
>>>                                  MIGRATION_STATUS_ACTIVE);
>>=20
>> This^ should be before the new block it seems:
>>=20
>> GOOD:
>> migrate_set_state new state setup
>> migrate_set_state new state wait-unplug
>> migrate_fd_cancel
>> migrate_set_state new state cancelling
>> migrate_fd_cleanup
>> migrate_set_state new state cancelled
>> migrate_fd_cancel
>> ok 1 /x86_64/failover-virtio-net/migrate/abort/wait-unplug
>>=20
>> BAD:
>> migrate_set_state new state setup
>> migrate_fd_cancel
>> migrate_set_state new state cancelling
>> migrate_fd_cleanup
>> migrate_set_state new state cancelled
>> qemu-system-x86_64: ram_save_setup failed: Input/output error
>> **
>> ERROR:../tests/qtest/virtio-net-failover.c:1203:test_migrate_abort_wait_=
unplug:
>> assertion failed (status =3D=3D "cancelling"): ("cancelled" =3D=3D "canc=
elling")
>>=20
>> Otherwise migration_iteration_finish() will schedule the cleanup BH and
>> that will run concurrently with migrate_fd_cancel() issued by the test
>> and bad things happens.
>
> This hack makes things work :
>
> @@ -3452,6 +3452,9 @@ static void *migration_thread(void *opaq
>           qemu_savevm_send_colo_enable(s->to_dst_file);
>       }
>=20=20=20
> +    qemu_savevm_wait_unplug(s, MIGRATION_STATUS_SETUP,
> +                            MIGRATION_STATUS_SETUP);
> +

Why move it all the way up here? Has moving the wait_unplug before the
'if (ret)' block not worked for you?

>       bql_lock();
>       ret =3D qemu_savevm_state_setup(s->to_dst_file, &local_err);
>       bql_unlock();
>
> We should fix the test instead :) Unless waiting for failover devices
> to unplug before the save_setup handlers and not after is ok.
>
> commit c7e0acd5a3f8 ("migration: add new migration state wait-unplug")
> is not clear about the justification.:
>
>      This patch adds a new migration state called wait-unplug.  It is ent=
ered
>      after the SETUP state if failover devices are present. It will trans=
ition
>      into ACTIVE once all devices were succesfully unplugged from the gue=
st.

This is not clear indeed, but to me it seems having the wait-unplug
after setup was important.

>
>
>> =3D=3D=3D=3D=3D
>> PS: I guess the next level in our Freestyle Concurrency video-game is to
>> make migrate_fd_cancel() stop setting state and poking files and only
>> set a flag that's tested in the other parts of the code.
>
> Is that a new item on the TODO list?

Yep, I'll add it to the wiki.


