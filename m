Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4CC00C5475B
	for <qemu-devel@archiver.kernel.org>; Fri,  8 Mar 2024 14:12:26 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1riax1-00005f-Sa; Fri, 08 Mar 2024 09:11:55 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <farosas@suse.de>) id 1riawz-0008Tg-37
 for qemu-devel@nongnu.org; Fri, 08 Mar 2024 09:11:53 -0500
Received: from smtp-out2.suse.de ([2a07:de40:b251:101:10:150:64:2])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <farosas@suse.de>) id 1riawr-0000ib-Mc
 for qemu-devel@nongnu.org; Fri, 08 Mar 2024 09:11:52 -0500
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org [10.150.64.97])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by smtp-out2.suse.de (Postfix) with ESMTPS id 62FAF5D723;
 Fri,  8 Mar 2024 14:11:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
 t=1709907098; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=gR3lwN1s+FMiYgbbP4OShKoHknlmxPjKiSUgMDNBzuc=;
 b=CZbZ9MzWEGXRrZM5/eYjNMXpVVPhbPKofRwO1wOrwcifbKPmdQhIKlZjLsVqRFW+xZ8/Gl
 BbeB8/aoT37uLtrMdY6HyfM5NWggvV/uNkFsYpnOSfjHa7W69VTp/n/5Yzzf2BTlpRLwOS
 Lo9meVT7A1jqxaky7e0Af7iDUxf0ZmM=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
 s=susede2_ed25519; t=1709907098;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=gR3lwN1s+FMiYgbbP4OShKoHknlmxPjKiSUgMDNBzuc=;
 b=z0+N2DrGPMYsF8fHBBf3h2PW9lEzEVsiF8oYctDUgHiTC9mFhHTfkHT6Cv5n+gGeH/ZCZR
 NZuqVvSzP0Z5txCQ==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
 t=1709907098; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=gR3lwN1s+FMiYgbbP4OShKoHknlmxPjKiSUgMDNBzuc=;
 b=CZbZ9MzWEGXRrZM5/eYjNMXpVVPhbPKofRwO1wOrwcifbKPmdQhIKlZjLsVqRFW+xZ8/Gl
 BbeB8/aoT37uLtrMdY6HyfM5NWggvV/uNkFsYpnOSfjHa7W69VTp/n/5Yzzf2BTlpRLwOS
 Lo9meVT7A1jqxaky7e0Af7iDUxf0ZmM=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
 s=susede2_ed25519; t=1709907098;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=gR3lwN1s+FMiYgbbP4OShKoHknlmxPjKiSUgMDNBzuc=;
 b=z0+N2DrGPMYsF8fHBBf3h2PW9lEzEVsiF8oYctDUgHiTC9mFhHTfkHT6Cv5n+gGeH/ZCZR
 NZuqVvSzP0Z5txCQ==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id E1FC113310;
 Fri,  8 Mar 2024 14:11:37 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
 by imap1.dmz-prg2.suse.org with ESMTPSA id 9xWbKZkc62WJKwAAD6G6ig
 (envelope-from <farosas@suse.de>); Fri, 08 Mar 2024 14:11:37 +0000
From: Fabiano Rosas <farosas@suse.de>
To: Peter Xu <peterx@redhat.com>, =?utf-8?Q?C=C3=A9dric?= Le Goater
 <clg@redhat.com>, Laurent Vivier <lvivier@redhat.com>
Cc: qemu-devel@nongnu.org, Alex Williamson <alex.williamson@redhat.com>,
 Avihai Horon <avihaih@nvidia.com>, Philippe =?utf-8?Q?Mathieu-Daud=C3=A9?=
 <philmd@linaro.org>, Markus Armbruster <armbru@redhat.com>, Prasad Pandit
 <pjp@fedoraproject.org>
Subject: Re: [PATCH v4 10/25] migration: Add Error** argument to
 qemu_savevm_state_setup()
In-Reply-To: <ZesLDCwh3r_pV2r3@x1n>
References: <20240306133441.2351700-1-clg@redhat.com>
 <20240306133441.2351700-11-clg@redhat.com> <ZesLDCwh3r_pV2r3@x1n>
Date: Fri, 08 Mar 2024 11:11:35 -0300
Message-ID: <87sf104xuw.fsf@suse.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Authentication-Results: smtp-out2.suse.de;
	none
X-Spamd-Result: default: False [-4.30 / 50.00]; ARC_NA(0.00)[];
 RCVD_VIA_SMTP_AUTH(0.00)[]; BAYES_HAM(-3.00)[100.00%];
 FROM_HAS_DN(0.00)[]; TO_DN_SOME(0.00)[];
 TO_MATCH_ENVRCPT_ALL(0.00)[]; NEURAL_HAM_LONG(-1.00)[-1.000];
 MIME_GOOD(-0.10)[text/plain]; RCVD_COUNT_THREE(0.00)[3];
 DKIM_SIGNED(0.00)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
 NEURAL_HAM_SHORT(-0.20)[-1.000]; RCPT_COUNT_SEVEN(0.00)[9];
 FUZZY_BLOCKED(0.00)[rspamd.com]; FROM_EQ_ENVFROM(0.00)[];
 MIME_TRACE(0.00)[0:+]; RCVD_TLS_ALL(0.00)[];
 MID_RHS_MATCH_FROM(0.00)[]
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

Peter Xu <peterx@redhat.com> writes:

> On Wed, Mar 06, 2024 at 02:34:25PM +0100, C=C3=A9dric Le Goater wrote:
>> This prepares ground for the changes coming next which add an Error**
>> argument to the .save_setup() handler. Callers of qemu_savevm_state_setu=
p()
>> now handle the error and fail earlier setting the migration state from
>> MIGRATION_STATUS_SETUP to MIGRATION_STATUS_FAILED.
>>=20
>> In qemu_savevm_state(), move the cleanup to preserve the error
>> reported by .save_setup() handlers.
>>=20
>> Since the previous behavior was to ignore errors at this step of
>> migration, this change should be examined closely to check that
>> cleanups are still correctly done.
>>=20
>> Signed-off-by: C=C3=A9dric Le Goater <clg@redhat.com>
>> ---
>>=20
>>  Changes in v4:
>>=20=20
>>  - Merged cleanup change in qemu_savevm_state()
>>=20=20=20=20
>>  Changes in v3:
>>=20=20
>>  - Set migration state to MIGRATION_STATUS_FAILED=20
>>  - Fixed error handling to be done under lock in bg_migration_thread()
>>  - Made sure an error is always set in case of failure in
>>    qemu_savevm_state_setup()
>>=20=20=20=20
>>  migration/savevm.h    |  2 +-
>>  migration/migration.c | 27 ++++++++++++++++++++++++---
>>  migration/savevm.c    | 26 +++++++++++++++-----------
>>  3 files changed, 40 insertions(+), 15 deletions(-)
>>=20
>> diff --git a/migration/savevm.h b/migration/savevm.h
>> index 74669733dd63a080b765866c703234a5c4939223..9ec96a995c93a42aad621595=
f0ed58596c532328 100644
>> --- a/migration/savevm.h
>> +++ b/migration/savevm.h
>> @@ -32,7 +32,7 @@
>>  bool qemu_savevm_state_blocked(Error **errp);
>>  void qemu_savevm_non_migratable_list(strList **reasons);
>>  int qemu_savevm_state_prepare(Error **errp);
>> -void qemu_savevm_state_setup(QEMUFile *f);
>> +int qemu_savevm_state_setup(QEMUFile *f, Error **errp);
>>  bool qemu_savevm_state_guest_unplug_pending(void);
>>  int qemu_savevm_state_resume_prepare(MigrationState *s);
>>  void qemu_savevm_state_header(QEMUFile *f);
>> diff --git a/migration/migration.c b/migration/migration.c
>> index a49fcd53ee19df1ce0182bc99d7e064968f0317b..6d1544224e96f5edfe56939a=
9c8395d88ef29581 100644
>> --- a/migration/migration.c
>> +++ b/migration/migration.c
>> @@ -3408,6 +3408,8 @@ static void *migration_thread(void *opaque)
>>      int64_t setup_start =3D qemu_clock_get_ms(QEMU_CLOCK_HOST);
>>      MigThrError thr_error;
>>      bool urgent =3D false;
>> +    Error *local_err =3D NULL;
>> +    int ret;
>>=20=20
>>      thread =3D migration_threads_add("live_migration", qemu_get_thread_=
id());
>>=20=20
>> @@ -3451,9 +3453,17 @@ static void *migration_thread(void *opaque)
>>      }
>>=20=20
>>      bql_lock();
>> -    qemu_savevm_state_setup(s->to_dst_file);
>> +    ret =3D qemu_savevm_state_setup(s->to_dst_file, &local_err);
>>      bql_unlock();
>>=20=20
>> +    if (ret) {
>> +        migrate_set_error(s, local_err);
>> +        error_free(local_err);
>> +        migrate_set_state(&s->state, MIGRATION_STATUS_SETUP,
>> +                          MIGRATION_STATUS_FAILED);
>> +        goto out;
>> +     }
>
> There's a small indent issue, I can fix it.
>
> The bigger problem is I _think_ this will trigger a ci failure in the
> virtio-net-failover test:
>
> =E2=96=B6 121/464 ERROR:../tests/qtest/virtio-net-failover.c:1203:test_mi=
grate_abort_wait_unplug: assertion failed (status =3D=3D "cancelling"): ("c=
ancelled" =3D=3D "cancelling") ERROR=20=20=20=20=20=20=20=20=20
> 121/464 qemu:qtest+qtest-x86_64 / qtest-x86_64/virtio-net-failover    ERR=
OR            4.77s   killed by signal 6 SIGABRT
>>>> PYTHON=3D/builds/peterx/qemu/build/pyvenv/bin/python3.8 G_TEST_DBUS_DA=
EMON=3D/builds/peterx/qemu/tests/dbus-vmstate-daemon.sh MALLOC_PERTURB_=3D1=
61 QTEST_QEMU_IMG=3D./qemu-img QTEST_QEMU_STORAGE_DAEMON_BINARY=3D./storage=
-daemon/qemu-storage-daemon QTEST_QEMU_BINARY=3D./qemu-system-x86_64 /build=
s/peterx/qemu/build/tests/qtest/virtio-net-failover --tap -k
> =E2=80=95=E2=80=95=E2=80=95=E2=80=95=E2=80=95=E2=80=95=E2=80=95=E2=80=95=
=E2=80=95=E2=80=95=E2=80=95=E2=80=95=E2=80=95=E2=80=95=E2=80=95=E2=80=95=E2=
=80=95=E2=80=95=E2=80=95=E2=80=95=E2=80=95=E2=80=95=E2=80=95=E2=80=95=E2=80=
=95=E2=80=95=E2=80=95=E2=80=95=E2=80=95=E2=80=95=E2=80=95=E2=80=95=E2=80=95=
=E2=80=95=E2=80=95=E2=80=95=E2=80=95 =E2=9C=80  =E2=80=95=E2=80=95=E2=80=95=
=E2=80=95=E2=80=95=E2=80=95=E2=80=95=E2=80=95=E2=80=95=E2=80=95=E2=80=95=E2=
=80=95=E2=80=95=E2=80=95=E2=80=95=E2=80=95=E2=80=95=E2=80=95=E2=80=95=E2=80=
=95=E2=80=95=E2=80=95=E2=80=95=E2=80=95=E2=80=95=E2=80=95=E2=80=95=E2=80=95=
=E2=80=95=E2=80=95=E2=80=95=E2=80=95=E2=80=95=E2=80=95=E2=80=95=E2=80=95=E2=
=80=95
> stderr:
> qemu-system-x86_64: ram_save_setup failed: Input/output error
> **
> ERROR:../tests/qtest/virtio-net-failover.c:1203:test_migrate_abort_wait_u=
nplug: assertion failed (status =3D=3D "cancelling"): ("cancelled" =3D=3D "=
cancelling")

I would say testing for the CANCELLING state is unreliable, there's even
code a few lines below in the test that does the proper thing of testing
for CANCELLED in a loop.

However, the comment:=20

 /* while the card is not ejected, we must be in "cancelling" state */

seems to imply that after migrate_fd_cancel (state=3D=3DCANCELLING), the
migrate_fd_cleanup (state=3D=3DCANCELLED) would only be executed after
"unplugging the card". So there must be "some logic" that has the effect
of preventing cleanup.

> (test program exited with status code -6)
> =E2=80=95=E2=80=95=E2=80=95=E2=80=95=E2=80=95=E2=80=95=E2=80=95=E2=80=95=
=E2=80=95=E2=80=95=E2=80=95=E2=80=95=E2=80=95=E2=80=95=E2=80=95=E2=80=95=E2=
=80=95=E2=80=95=E2=80=95=E2=80=95=E2=80=95=E2=80=95=E2=80=95=E2=80=95=E2=80=
=95=E2=80=95=E2=80=95=E2=80=95=E2=80=95=E2=80=95=E2=80=95=E2=80=95=E2=80=95=
=E2=80=95=E2=80=95=E2=80=95=E2=80=95=E2=80=95=E2=80=95=E2=80=95=E2=80=95=E2=
=80=95=E2=80=95=E2=80=95=E2=80=95=E2=80=95=E2=80=95=E2=80=95=E2=80=95=E2=80=
=95=E2=80=95=E2=80=95=E2=80=95=E2=80=95=E2=80=95=E2=80=95=E2=80=95=E2=80=95=
=E2=80=95=E2=80=95=E2=80=95=E2=80=95=E2=80=95=E2=80=95=E2=80=95=E2=80=95=E2=
=80=95=E2=80=95=E2=80=95=E2=80=95=E2=80=95=E2=80=95=E2=80=95=E2=80=95=E2=80=
=95=E2=80=95=E2=80=95=E2=80=95
>
> I am not familiar enough with the failover code, and may not have time
> today to follow this up, copy Laurent.  Cedric, if you have time, please
> have a look.  I'll give it a shot on Monday to find a solution, otherwise
> we may need to postpone some of the patches to 9.1.
>
> Thanks,
>
>> +
>>      qemu_savevm_wait_unplug(s, MIGRATION_STATUS_SETUP,
>>                                 MIGRATION_STATUS_ACTIVE);
>>=20=20
>> @@ -3530,6 +3540,9 @@ static void *bg_migration_thread(void *opaque)
>>      MigThrError thr_error;
>>      QEMUFile *fb;
>>      bool early_fail =3D true;
>> +    bool setup_fail =3D true;
>> +    Error *local_err =3D NULL;
>> +    int ret;
>>=20=20
>>      rcu_register_thread();
>>      object_ref(OBJECT(s));
>> @@ -3563,9 +3576,16 @@ static void *bg_migration_thread(void *opaque)
>>=20=20
>>      bql_lock();
>>      qemu_savevm_state_header(s->to_dst_file);
>> -    qemu_savevm_state_setup(s->to_dst_file);
>> +    ret =3D qemu_savevm_state_setup(s->to_dst_file, &local_err);
>> +    if (ret) {
>> +        migrate_set_error(s, local_err);
>> +        error_free(local_err);
>> +        goto fail;
>> +    }
>>      bql_unlock();
>>=20=20
>> +    setup_fail =3D false;
>> +
>>      qemu_savevm_wait_unplug(s, MIGRATION_STATUS_SETUP,
>>                                 MIGRATION_STATUS_ACTIVE);
>>=20=20
>> @@ -3632,7 +3652,8 @@ static void *bg_migration_thread(void *opaque)
>>=20=20
>>  fail:
>>      if (early_fail) {
>> -        migrate_set_state(&s->state, MIGRATION_STATUS_ACTIVE,
>> +        migrate_set_state(&s->state,
>> +                setup_fail ? MIGRATION_STATUS_SETUP : MIGRATION_STATUS_=
ACTIVE,
>>                  MIGRATION_STATUS_FAILED);
>>          bql_unlock();
>>      }
>> diff --git a/migration/savevm.c b/migration/savevm.c
>> index ee31ffb5e88cea723039c754c30ce2c8a0ef35f3..63fdbb5ad7d4dbfaef1d2094=
350bf302cc677602 100644
>> --- a/migration/savevm.c
>> +++ b/migration/savevm.c
>> @@ -1310,11 +1310,11 @@ int qemu_savevm_state_prepare(Error **errp)
>>      return 0;
>>  }
>>=20=20
>> -void qemu_savevm_state_setup(QEMUFile *f)
>> +int qemu_savevm_state_setup(QEMUFile *f, Error **errp)
>>  {
>> +    ERRP_GUARD();
>>      MigrationState *ms =3D migrate_get_current();
>>      SaveStateEntry *se;
>> -    Error *local_err =3D NULL;
>>      int ret =3D 0;
>>=20=20
>>      json_writer_int64(ms->vmdesc, "page_size", qemu_target_page_size());
>> @@ -1323,10 +1323,9 @@ void qemu_savevm_state_setup(QEMUFile *f)
>>      trace_savevm_state_setup();
>>      QTAILQ_FOREACH(se, &savevm_state.handlers, entry) {
>>          if (se->vmsd && se->vmsd->early_setup) {
>> -            ret =3D vmstate_save(f, se, ms->vmdesc, &local_err);
>> +            ret =3D vmstate_save(f, se, ms->vmdesc, errp);
>>              if (ret) {
>> -                migrate_set_error(ms, local_err);
>> -                error_report_err(local_err);
>> +                migrate_set_error(ms, *errp);
>>                  qemu_file_set_error(f, ret);
>>                  break;
>>              }
>> @@ -1346,18 +1345,19 @@ void qemu_savevm_state_setup(QEMUFile *f)
>>          ret =3D se->ops->save_setup(f, se->opaque);
>>          save_section_footer(f, se);
>>          if (ret < 0) {
>> +            error_setg(errp, "failed to setup SaveStateEntry with id(na=
me): "
>> +                       "%d(%s): %d", se->section_id, se->idstr, ret);
>>              qemu_file_set_error(f, ret);
>>              break;
>>          }
>>      }
>>=20=20
>>      if (ret) {
>> -        return;
>> +        return ret;
>>      }
>>=20=20
>> -    if (precopy_notify(PRECOPY_NOTIFY_SETUP, &local_err)) {
>> -        error_report_err(local_err);
>> -    }
>> +    /* TODO: Should we check that errp is set in case of failure ? */
>> +    return precopy_notify(PRECOPY_NOTIFY_SETUP, errp);
>>  }
>>=20=20
>>  int qemu_savevm_state_resume_prepare(MigrationState *s)
>> @@ -1728,7 +1728,10 @@ static int qemu_savevm_state(QEMUFile *f, Error *=
*errp)
>>      ms->to_dst_file =3D f;
>>=20=20
>>      qemu_savevm_state_header(f);
>> -    qemu_savevm_state_setup(f);
>> +    ret =3D qemu_savevm_state_setup(f, errp);
>> +    if (ret) {
>> +        goto cleanup;
>> +    }
>>=20=20
>>      while (qemu_file_get_error(f) =3D=3D 0) {
>>          if (qemu_savevm_state_iterate(f, false) > 0) {
>> @@ -1741,10 +1744,11 @@ static int qemu_savevm_state(QEMUFile *f, Error =
**errp)
>>          qemu_savevm_state_complete_precopy(f, false, false);
>>          ret =3D qemu_file_get_error(f);
>>      }
>> -    qemu_savevm_state_cleanup();
>>      if (ret !=3D 0) {
>>          error_setg_errno(errp, -ret, "Error while writing VM state");
>>      }
>> +cleanup:
>> +    qemu_savevm_state_cleanup();
>>=20=20
>>      if (ret !=3D 0) {
>>          status =3D MIGRATION_STATUS_FAILED;
>> --=20
>> 2.44.0
>>=20

