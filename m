Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2320AC54E5D
	for <qemu-devel@archiver.kernel.org>; Tue, 12 Mar 2024 14:25:23 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rk33y-0003Uh-Ra; Tue, 12 Mar 2024 10:25:06 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <farosas@suse.de>) id 1rk33h-0003Ss-2f
 for qemu-devel@nongnu.org; Tue, 12 Mar 2024 10:24:51 -0400
Received: from smtp-out2.suse.de ([2a07:de40:b251:101:10:150:64:2])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <farosas@suse.de>) id 1rk33e-0004cr-Nw
 for qemu-devel@nongnu.org; Tue, 12 Mar 2024 10:24:48 -0400
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org [10.150.64.97])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by smtp-out2.suse.de (Postfix) with ESMTPS id C108A5D5EE;
 Tue, 12 Mar 2024 14:24:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
 t=1710253482; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=nHjQF+TdCFN0n6us4ZUxG4y9iNkDIXLEZQLNoJnTKjg=;
 b=SoQg6EkgeSh1L13OGVTztwpjHPXlwI43zNbSo11Ve6E3W9gqQS2fqg+YGi5OtjHtjGtGY5
 QBZofLjt+7M+hZNBuBAmPCT5gPzNiyIBqtyA3kmXux/qNQ+kOx5R1Q4X887qaY0gG+kgkT
 wJ+lhUsSHPphU/ooIqagWdzUh5IBSjQ=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
 s=susede2_ed25519; t=1710253482;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=nHjQF+TdCFN0n6us4ZUxG4y9iNkDIXLEZQLNoJnTKjg=;
 b=p8lzZTo4fnbwZXlKN4qnu06/OR1f7TvY9TuyxCPKTEwak/Gaac5ddcwkyB3OBomdsDredT
 /0bAyheWPXvkbHDQ==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
 t=1710253482; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=nHjQF+TdCFN0n6us4ZUxG4y9iNkDIXLEZQLNoJnTKjg=;
 b=SoQg6EkgeSh1L13OGVTztwpjHPXlwI43zNbSo11Ve6E3W9gqQS2fqg+YGi5OtjHtjGtGY5
 QBZofLjt+7M+hZNBuBAmPCT5gPzNiyIBqtyA3kmXux/qNQ+kOx5R1Q4X887qaY0gG+kgkT
 wJ+lhUsSHPphU/ooIqagWdzUh5IBSjQ=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
 s=susede2_ed25519; t=1710253482;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=nHjQF+TdCFN0n6us4ZUxG4y9iNkDIXLEZQLNoJnTKjg=;
 b=p8lzZTo4fnbwZXlKN4qnu06/OR1f7TvY9TuyxCPKTEwak/Gaac5ddcwkyB3OBomdsDredT
 /0bAyheWPXvkbHDQ==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 4C46413795;
 Tue, 12 Mar 2024 14:24:42 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
 by imap1.dmz-prg2.suse.org with ESMTPSA id 6lo9Bapl8GUbIAAAD6G6ig
 (envelope-from <farosas@suse.de>); Tue, 12 Mar 2024 14:24:42 +0000
From: Fabiano Rosas <farosas@suse.de>
To: =?utf-8?Q?C=C3=A9dric?= Le Goater <clg@redhat.com>, qemu-devel@nongnu.org
Cc: Peter Xu <peterx@redhat.com>, Alex Williamson
 <alex.williamson@redhat.com>, Avihai Horon <avihaih@nvidia.com>, Philippe
 =?utf-8?Q?Mathieu-Daud=C3=A9?= <philmd@linaro.org>, Markus Armbruster
 <armbru@redhat.com>, Prasad Pandit <pjp@fedoraproject.org>
Subject: Re: [PATCH v4 10/25] migration: Add Error** argument to
 qemu_savevm_state_setup()
In-Reply-To: <b2b52017-c4cd-43e9-a67b-2ccbb92ad99e@redhat.com>
References: <20240306133441.2351700-1-clg@redhat.com>
 <20240306133441.2351700-11-clg@redhat.com> <87plw44wps.fsf@suse.de>
 <1566715b-a9a5-4df6-8e64-f4f912e2ea2f@redhat.com> <87le6omw0d.fsf@suse.de>
 <9071affc-ffb5-435a-99d1-ca829703e31b@redhat.com>
 <8ba5dba7-1849-46ff-b708-a9caac66be27@redhat.com>
 <b2b52017-c4cd-43e9-a67b-2ccbb92ad99e@redhat.com>
Date: Tue, 12 Mar 2024 11:24:39 -0300
Message-ID: <874jdbmst4.fsf@suse.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Authentication-Results: smtp-out2.suse.de;
	none
X-Spamd-Result: default: False [-3.10 / 50.00]; ARC_NA(0.00)[];
 RCVD_VIA_SMTP_AUTH(0.00)[];
 URIBL_BLOCKED(0.00)[mail-archive.com:url,ozlabs.org:url];
 FROM_HAS_DN(0.00)[]; TO_DN_SOME(0.00)[];
 TO_MATCH_ENVRCPT_ALL(0.00)[]; BAYES_HAM(-3.00)[100.00%];
 MIME_GOOD(-0.10)[text/plain]; RCVD_COUNT_THREE(0.00)[3];
 DKIM_SIGNED(0.00)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
 RCPT_COUNT_SEVEN(0.00)[8]; FUZZY_BLOCKED(0.00)[rspamd.com];
 FROM_EQ_ENVFROM(0.00)[]; MIME_TRACE(0.00)[0:+];
 RCVD_TLS_ALL(0.00)[]; MID_RHS_MATCH_FROM(0.00)[]
Received-SPF: pass client-ip=2a07:de40:b251:101:10:150:64:2;
 envelope-from=farosas@suse.de; helo=smtp-out2.suse.de
X-Spam_score_int: -43
X-Spam_score: -4.4
X-Spam_bar: ----
X-Spam_report: (-4.4 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_MED=-2.3, SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
 T_SCC_BODY_TEXT_LINE=-0.01 autolearn=ham autolearn_force=no
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

> On 3/12/24 14:34, C=C3=A9dric Le Goater wrote:
>> On 3/12/24 13:32, C=C3=A9dric Le Goater wrote:
>>> On 3/11/24 20:03, Fabiano Rosas wrote:
>>>> C=C3=A9dric Le Goater <clg@redhat.com> writes:
>>>>
>>>>> On 3/8/24 15:36, Fabiano Rosas wrote:
>>>>>> C=C3=A9dric Le Goater <clg@redhat.com> writes:
>>>>>>
>>>>>>> This prepares ground for the changes coming next which add an Error=
**
>>>>>>> argument to the .save_setup() handler. Callers of qemu_savevm_state=
_setup()
>>>>>>> now handle the error and fail earlier setting the migration state f=
rom
>>>>>>> MIGRATION_STATUS_SETUP to MIGRATION_STATUS_FAILED.
>>>>>>>
>>>>>>> In qemu_savevm_state(), move the cleanup to preserve the error
>>>>>>> reported by .save_setup() handlers.
>>>>>>>
>>>>>>> Since the previous behavior was to ignore errors at this step of
>>>>>>> migration, this change should be examined closely to check that
>>>>>>> cleanups are still correctly done.
>>>>>>>
>>>>>>> Signed-off-by: C=C3=A9dric Le Goater <clg@redhat.com>
>>>>>>> ---
>>>>>>>
>>>>>>> =C2=A0=C2=A0 Changes in v4:
>>>>>>> =C2=A0=C2=A0 - Merged cleanup change in qemu_savevm_state()
>>>>>>> =C2=A0=C2=A0 Changes in v3:
>>>>>>> =C2=A0=C2=A0 - Set migration state to MIGRATION_STATUS_FAILED
>>>>>>> =C2=A0=C2=A0 - Fixed error handling to be done under lock in bg_mig=
ration_thread()
>>>>>>> =C2=A0=C2=A0 - Made sure an error is always set in case of failure =
in
>>>>>>> =C2=A0=C2=A0=C2=A0=C2=A0 qemu_savevm_state_setup()
>>>>>>> =C2=A0=C2=A0 migration/savevm.h=C2=A0=C2=A0=C2=A0 |=C2=A0 2 +-
>>>>>>> =C2=A0=C2=A0 migration/migration.c | 27 ++++++++++++++++++++++++---
>>>>>>> =C2=A0=C2=A0 migration/savevm.c=C2=A0=C2=A0=C2=A0 | 26 ++++++++++++=
+++-----------
>>>>>>> =C2=A0=C2=A0 3 files changed, 40 insertions(+), 15 deletions(-)
>>>>>>>
>>>>>>> diff --git a/migration/savevm.h b/migration/savevm.h
>>>>>>> index 74669733dd63a080b765866c703234a5c4939223..9ec96a995c93a42aad6=
21595f0ed58596c532328 100644
>>>>>>> --- a/migration/savevm.h
>>>>>>> +++ b/migration/savevm.h
>>>>>>> @@ -32,7 +32,7 @@
>>>>>>> =C2=A0=C2=A0 bool qemu_savevm_state_blocked(Error **errp);
>>>>>>> =C2=A0=C2=A0 void qemu_savevm_non_migratable_list(strList **reasons=
);
>>>>>>> =C2=A0=C2=A0 int qemu_savevm_state_prepare(Error **errp);
>>>>>>> -void qemu_savevm_state_setup(QEMUFile *f);
>>>>>>> +int qemu_savevm_state_setup(QEMUFile *f, Error **errp);
>>>>>>> =C2=A0=C2=A0 bool qemu_savevm_state_guest_unplug_pending(void);
>>>>>>> =C2=A0=C2=A0 int qemu_savevm_state_resume_prepare(MigrationState *s=
);
>>>>>>> =C2=A0=C2=A0 void qemu_savevm_state_header(QEMUFile *f);
>>>>>>> diff --git a/migration/migration.c b/migration/migration.c
>>>>>>> index a49fcd53ee19df1ce0182bc99d7e064968f0317b..6d1544224e96f5edfe5=
6939a9c8395d88ef29581 100644
>>>>>>> --- a/migration/migration.c
>>>>>>> +++ b/migration/migration.c
>>>>>>> @@ -3408,6 +3408,8 @@ static void *migration_thread(void *opaque)
>>>>>>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 int64_t setup_start =3D qemu_c=
lock_get_ms(QEMU_CLOCK_HOST);
>>>>>>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 MigThrError thr_error;
>>>>>>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 bool urgent =3D false;
>>>>>>> +=C2=A0=C2=A0=C2=A0 Error *local_err =3D NULL;
>>>>>>> +=C2=A0=C2=A0=C2=A0 int ret;
>>>>>>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 thread =3D migration_threads_a=
dd("live_migration", qemu_get_thread_id());
>>>>>>> @@ -3451,9 +3453,17 @@ static void *migration_thread(void *opaque)
>>>>>>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 }
>>>>>>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 bql_lock();
>>>>>>> -=C2=A0=C2=A0=C2=A0 qemu_savevm_state_setup(s->to_dst_file);
>>>>>>> +=C2=A0=C2=A0=C2=A0 ret =3D qemu_savevm_state_setup(s->to_dst_file,=
 &local_err);
>>>>>>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 bql_unlock();
>>>>>>> +=C2=A0=C2=A0=C2=A0 if (ret) {
>>>>>>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 migrate_set_error(s, lo=
cal_err);
>>>>>>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 error_free(local_err);
>>>>>>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 migrate_set_state(&s->s=
tate, MIGRATION_STATUS_SETUP,
>>>>>>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0 MIGRATION_STATUS_FAILED);
>>>>>>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 goto out;
>>>>>>> +=C2=A0=C2=A0=C2=A0=C2=A0 }
>>>>>>> +
>>>>>>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 qemu_savevm_wait_unplug(s, MIG=
RATION_STATUS_SETUP,
>>>>>>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 MIGRATION_STATUS_=
ACTIVE);
>>>>>>
>>>>>> This^ should be before the new block it seems:
>>>>>>
>>>>>> GOOD:
>>>>>> migrate_set_state new state setup
>>>>>> migrate_set_state new state wait-unplug
>>>>>> migrate_fd_cancel
>>>>>> migrate_set_state new state cancelling
>>>>>> migrate_fd_cleanup
>>>>>> migrate_set_state new state cancelled
>>>>>> migrate_fd_cancel
>>>>>> ok 1 /x86_64/failover-virtio-net/migrate/abort/wait-unplug
>>>>>>
>>>>>> BAD:
>>>>>> migrate_set_state new state setup
>>>>>> migrate_fd_cancel
>>>>>> migrate_set_state new state cancelling
>>>>>> migrate_fd_cleanup
>>>>>> migrate_set_state new state cancelled
>>>>>> qemu-system-x86_64: ram_save_setup failed: Input/output error
>>>>>> **
>>>>>> ERROR:../tests/qtest/virtio-net-failover.c:1203:test_migrate_abort_w=
ait_unplug:
>>>>>> assertion failed (status =3D=3D "cancelling"): ("cancelled" =3D=3D "=
cancelling")
>>>>>>
>>>>>> Otherwise migration_iteration_finish() will schedule the cleanup BH =
and
>>>>>> that will run concurrently with migrate_fd_cancel() issued by the te=
st
>>>>>> and bad things happens.
>>>>>
>>>>> This hack makes things work :
>>>>>
>>>>> @@ -3452,6 +3452,9 @@ static void *migration_thread(void *opaq
>>>>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 qemu_sav=
evm_send_colo_enable(s->to_dst_file);
>>>>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 }
>>>>> +=C2=A0=C2=A0=C2=A0 qemu_savevm_wait_unplug(s, MIGRATION_STATUS_SETUP,
>>>>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0 MIGRATION_STATUS_SETUP);
>>>>> +
>>>>
>>>> Why move it all the way up here? Has moving the wait_unplug before the
>>>> 'if (ret)' block not worked for you?
>>>
>>> We could be sleeping while holding the BQL. It looked wrong.
>>=20
>> Sorry wrong answer. Yes I can try moving it before the 'if (ret)' block.
>> I can reproduce easily with an x86 guest running on PPC64.
>
> That works just the same.
>
> Peter, Fabiano,
>
> What would you prefer  ?
>
> 1. move qemu_savevm_wait_unplug() before qemu_savevm_state_setup(),
>     means one new patch.

Is there a point to this except "because we can"? Honest question, I
might have missed the motivation.

Also a couple of points:

- The current version of this proposal seems it will lose the transition
from SETUP->ACTIVE no? As in, after qemu_savevm_state_setup, there's
nothing changing the state to ACTIVE anymore.

- You also need to change the bg migration path.

>
> 2. leave qemu_savevm_wait_unplug() after qemu_savevm_state_setup()
>     and handle state_setup() errors after waiting. means an update
>     of this patch.

I vote for this. This failover feature is a pretty complex one, let's
not risk changing the behavior for no good reason. Just look at the
amount of head-banging going on in these threads:

https://patchwork.ozlabs.org/project/qemu-devel/cover/20181025140631.634922=
-1-sameeh@daynix.com/
https://www.mail-archive.com/qemu-devel@nongnu.org/msg609296.html

>
>
> Thanks,
>
> C.
>
>
>=20=20=20

