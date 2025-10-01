Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 449D1CCA470
	for <qemu-devel@archiver.kernel.org>; Wed,  1 Oct 2025 12:18:29 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1v3vlv-0003Ba-QR; Wed, 01 Oct 2025 08:17:28 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <farosas@suse.de>) id 1v3vlX-0002yj-Mc
 for qemu-devel@nongnu.org; Wed, 01 Oct 2025 08:17:06 -0400
Received: from smtp-out1.suse.de ([195.135.223.130])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <farosas@suse.de>) id 1v3vlK-0006z0-Eg
 for qemu-devel@nongnu.org; Wed, 01 Oct 2025 08:17:03 -0400
Received: from imap1.dmz-prg2.suse.org (unknown [10.150.64.97])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by smtp-out1.suse.de (Postfix) with ESMTPS id 4F094336C4;
 Wed,  1 Oct 2025 12:16:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
 t=1759321000; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=MQBPs6RzRMkiJdYAUwck/Cq+EqMJGp5aqRN9BM+b7UQ=;
 b=0qpcx/4QZp/eDBKm0+Lu85SBFwDsRmadz/nvDLkFxGW5t3TtQL2QHO+eJK1706Y8azi425
 CykvbSYCy1UNhXyaiy5opN2S41bIKNr+qkhDeMjqlbCkrLZBjIug0STq6xjNKpTCKVWPnC
 zFT+4/47VlHJyHbI3p9Z6/g+jDe+9k4=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
 s=susede2_ed25519; t=1759321000;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=MQBPs6RzRMkiJdYAUwck/Cq+EqMJGp5aqRN9BM+b7UQ=;
 b=J+0Po7CVENxKhUw6nkbkmzedIoEHIwjLefigqYI0xQ2Z1tvzMBGB/HtlsGu9DFZc+TU6ZY
 ITWlbueiYRqjZqAA==
Authentication-Results: smtp-out1.suse.de;
	none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
 t=1759321000; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=MQBPs6RzRMkiJdYAUwck/Cq+EqMJGp5aqRN9BM+b7UQ=;
 b=0qpcx/4QZp/eDBKm0+Lu85SBFwDsRmadz/nvDLkFxGW5t3TtQL2QHO+eJK1706Y8azi425
 CykvbSYCy1UNhXyaiy5opN2S41bIKNr+qkhDeMjqlbCkrLZBjIug0STq6xjNKpTCKVWPnC
 zFT+4/47VlHJyHbI3p9Z6/g+jDe+9k4=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
 s=susede2_ed25519; t=1759321000;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=MQBPs6RzRMkiJdYAUwck/Cq+EqMJGp5aqRN9BM+b7UQ=;
 b=J+0Po7CVENxKhUw6nkbkmzedIoEHIwjLefigqYI0xQ2Z1tvzMBGB/HtlsGu9DFZc+TU6ZY
 ITWlbueiYRqjZqAA==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id CA6D413A42;
 Wed,  1 Oct 2025 12:16:39 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
 by imap1.dmz-prg2.suse.org with ESMTPSA id 6+7wIqcb3WhqegAAD6G6ig
 (envelope-from <farosas@suse.de>); Wed, 01 Oct 2025 12:16:39 +0000
From: Fabiano Rosas <farosas@suse.de>
To: Steven Sistare <steven.sistare@oracle.com>, qemu-devel@nongnu.org
Cc: Laurent Vivier <lvivier@redhat.com>, Paolo Bonzini
 <pbonzini@redhat.com>, Peter Xu <peterx@redhat.com>
Subject: Re: [PATCH V1 09/11] migration-test: migrate_args
In-Reply-To: <4e6a3f1c-8fd4-486f-bc0f-fe0673988240@oracle.com>
References: <1758291153-349744-1-git-send-email-steven.sistare@oracle.com>
 <1758291153-349744-10-git-send-email-steven.sistare@oracle.com>
 <87a52bvhw0.fsf@suse.de> <0f4caf91-4ad5-4e1e-91d0-12959f1a89a1@oracle.com>
 <4e6a3f1c-8fd4-486f-bc0f-fe0673988240@oracle.com>
Date: Wed, 01 Oct 2025 09:16:37 -0300
Message-ID: <874isivmu2.fsf@suse.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
X-Spamd-Result: default: False [-4.30 / 50.00]; BAYES_HAM(-3.00)[100.00%];
 NEURAL_HAM_LONG(-1.00)[-1.000];
 NEURAL_HAM_SHORT(-0.20)[-0.999]; MIME_GOOD(-0.10)[text/plain];
 ARC_NA(0.00)[]; MISSING_XM_UA(0.00)[]; RCVD_TLS_ALL(0.00)[];
 MIME_TRACE(0.00)[0:+]; RCVD_VIA_SMTP_AUTH(0.00)[];
 TO_DN_SOME(0.00)[]; FUZZY_RATELIMITED(0.00)[rspamd.com];
 MID_RHS_MATCH_FROM(0.00)[];
 DKIM_SIGNED(0.00)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
 FROM_HAS_DN(0.00)[]; RCPT_COUNT_FIVE(0.00)[5];
 FROM_EQ_ENVFROM(0.00)[]; TO_MATCH_ENVRCPT_ALL(0.00)[];
 RCVD_COUNT_TWO(0.00)[2];
 DBL_BLOCKED_OPENRESOLVER(0.00)[imap1.dmz-prg2.suse.org:helo]
Received-SPF: pass client-ip=195.135.223.130; envelope-from=farosas@suse.de;
 helo=smtp-out1.suse.de
X-Spam_score_int: -43
X-Spam_score: -4.4
X-Spam_bar: ----
X-Spam_report: (-4.4 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_MED=-2.3, RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001,
 RCVD_IN_VALIDITY_SAFE_BLOCKED=0.001, SPF_HELO_NONE=0.001,
 T_SPF_TEMPERROR=0.01 autolearn=ham autolearn_force=no
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

Steven Sistare <steven.sistare@oracle.com> writes:

> On 9/30/2025 3:59 PM, Steven Sistare wrote:
>> On 9/30/2025 3:51 PM, Fabiano Rosas wrote:
>>> Steve Sistare <steven.sistare@oracle.com> writes:
>>>
>>>> Define the subroutine migrate_args to return the arguments that are
>>>> used to exec the source or target qemu process.
>>>>
>>>> Signed-off-by: Steve Sistare <steven.sistare@oracle.com>
>>>> ---
>>>> =C2=A0 tests/qtest/migration/framework.h |=C2=A0 2 ++
>>>> =C2=A0 tests/qtest/migration/framework.c | 64 ++++++++++++++++++++++++=
---------------
>>>> =C2=A0 2 files changed, 41 insertions(+), 25 deletions(-)
>>>>
>>>> diff --git a/tests/qtest/migration/framework.h b/tests/qtest/migration=
/framework.h
>>>> index 7ff3187..51a8a7e 100644
>>>> --- a/tests/qtest/migration/framework.h
>>>> +++ b/tests/qtest/migration/framework.h
>>>> @@ -226,6 +226,8 @@ typedef struct {
>>>> =C2=A0 void wait_for_serial(const char *side);
>>>> =C2=A0 void migrate_prepare_for_dirty_mem(QTestState *from);
>>>> =C2=A0 void migrate_wait_for_dirty_mem(QTestState *from, QTestState *t=
o);
>>>> +
>>>> +void migrate_args(char **from, char **to, const char *uri, MigrateSta=
rt *args);
>>>> =C2=A0 int migrate_start(QTestState **from, QTestState **to, const cha=
r *uri,
>>>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 MigrateStart *args);
>>>> =C2=A0 void migrate_end(QTestState *from, QTestState *to, bool test_de=
st);
>>>> diff --git a/tests/qtest/migration/framework.c b/tests/qtest/migration=
/framework.c
>>>> index 8f9e359..2dfb1ee 100644
>>>> --- a/tests/qtest/migration/framework.c
>>>> +++ b/tests/qtest/migration/framework.c
>>>> @@ -258,13 +258,12 @@ static char *test_shmem_path(void)
>>>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 return g_strdup_printf("/dev/shm/qemu-%=
d", getpid());
>>>> =C2=A0 }
>>>> -int migrate_start(QTestState **from, QTestState **to, const char *uri,
>>>> -=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 MigrateStart *args)
>>>> +void migrate_args(char **from, char **to, const char *uri, MigrateSta=
rt *args)
>>>> =C2=A0 {
>>>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 /* options for source and target */
>>>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 g_autofree gchar *arch_opts =3D NULL;
>>>> -=C2=A0=C2=A0=C2=A0 g_autofree gchar *cmd_source =3D NULL;
>>>> -=C2=A0=C2=A0=C2=A0 g_autofree gchar *cmd_target =3D NULL;
>>>> +=C2=A0=C2=A0=C2=A0 gchar *cmd_source =3D NULL;
>>>> +=C2=A0=C2=A0=C2=A0 gchar *cmd_target =3D NULL;
>>>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 const gchar *ignore_stderr;
>>>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 g_autofree char *shmem_opts =3D NULL;
>>>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 g_autofree char *shmem_path =3D NULL;
>>>> @@ -273,23 +272,10 @@ int migrate_start(QTestState **from, QTestState =
**to, const char *uri,
>>>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 const char *memory_size;
>>>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 const char *machine_alias, *machine_opt=
s =3D "";
>>>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 g_autofree char *machine =3D NULL;
>>>> -=C2=A0=C2=A0=C2=A0 const char *bootpath;
>>>> -=C2=A0=C2=A0=C2=A0 g_autoptr(QList) capabilities =3D migrate_start_ge=
t_qmp_capabilities(args);
>>>> +=C2=A0=C2=A0=C2=A0 const char *bootpath =3D bootfile_get();
>>>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 g_autofree char *memory_backend =3D NUL=
L;
>>>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 const char *events;
>>>> -=C2=A0=C2=A0=C2=A0 if (args->use_shmem) {
>>>> -=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 if (!g_file_test("/dev/shm=
", G_FILE_TEST_IS_DIR)) {
>>>> -=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 g_=
test_skip("/dev/shm is not supported");
>>>> -=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 re=
turn -1;
>>>> -=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 }
>>>> -=C2=A0=C2=A0=C2=A0 }
>>>> -
>>>> -=C2=A0=C2=A0=C2=A0 dst_state =3D (QTestMigrationState) { };
>>>> -=C2=A0=C2=A0=C2=A0 src_state =3D (QTestMigrationState) { };
>>>> -=C2=A0=C2=A0=C2=A0 bootpath =3D bootfile_create(arch, tmpfs, args->su=
spend_me);
>>>> -=C2=A0=C2=A0=C2=A0 src_state.suspend_me =3D args->suspend_me;
>>>> -
>>>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 if (strcmp(arch, "i386") =3D=3D 0 || st=
rcmp(arch, "x86_64") =3D=3D 0) {
>>>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 memory_size =3D=
 "150M";
>>>> @@ -365,7 +351,7 @@ int migrate_start(QTestState **from, QTestState **=
to, const char *uri,
>>>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 if (!qtest_has_machine(machine_alias)) {
>>>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 g_autofree char=
 *msg =3D g_strdup_printf("machine %s not supported", machine_alias);
>>>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 g_test_skip(msg=
);
>>>> -=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 return -1;
>>>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 return;
>>>
>>> A common pitfall is that g_test_skip() doesn't actually ends the
>>> test. The -1 needs to be propagated up, otherwise the test will proceed
>>> with the unsupported machine.
>>=20
>> Thanks.
>> migrate_args() will return an error code.
>> I'll send a V2 of this patch,=20
>
> Do you prefer I send a patch with just the fix, if you have already
> pulled the patches into your tree?
>

Yeah, could be.

> - Steve
>
>> and fix the call to migrate_args in patch
>> "cpr-exec test".
>>=20
>> - Steve
>>=20
>>>
>>>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 }
>>>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 machine =3D resolve_machine_version(mac=
hine_alias, QEMU_ENV_SRC,
>>>> @@ -386,12 +372,6 @@ int migrate_start(QTestState **from, QTestState *=
*to, const char *uri,
>>>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 shmem_opts ? s=
hmem_opts : "",
>>>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 args->opts_sou=
rce ? args->opts_source : "",
>>>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 ignore_stderr);
>>>> -=C2=A0=C2=A0=C2=A0 if (!args->only_target) {
>>>> -=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 *from =3D qtest_init_ext(Q=
EMU_ENV_SRC, cmd_source, capabilities, true);
>>>> -=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 qtest_qmp_set_event_callba=
ck(*from,
>>>> -=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 mi=
grate_watch_for_events,
>>>> -=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 &s=
rc_state);
>>>> -=C2=A0=C2=A0=C2=A0 }
>>>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 /*
>>>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 * If the monitor connection is de=
ferred, enable events on the command line
>>>> @@ -415,6 +395,39 @@ int migrate_start(QTestState **from, QTestState *=
*to, const char *uri,
>>>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 shmem_opts ? s=
hmem_opts : "",
>>>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 args->opts_tar=
get ? args->opts_target : "",
>>>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 ignore_stderr);
>>>> +
>>>> +=C2=A0=C2=A0=C2=A0 *from =3D cmd_source;
>>>> +=C2=A0=C2=A0=C2=A0 *to =3D cmd_target;
>>>> +}
>>>> +
>>>> +int migrate_start(QTestState **from, QTestState **to, const char *uri,
>>>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 MigrateStart *args)
>>>> +{
>>>> +=C2=A0=C2=A0=C2=A0 g_autofree gchar *cmd_source =3D NULL;
>>>> +=C2=A0=C2=A0=C2=A0 g_autofree gchar *cmd_target =3D NULL;
>>>> +=C2=A0=C2=A0=C2=A0 g_autoptr(QList) capabilities =3D migrate_start_ge=
t_qmp_capabilities(args);
>>>> +
>>>> +=C2=A0=C2=A0=C2=A0 if (args->use_shmem) {
>>>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 if (!g_file_test("/dev/shm=
", G_FILE_TEST_IS_DIR)) {
>>>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 g_=
test_skip("/dev/shm is not supported");
>>>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 re=
turn -1;
>>>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 }
>>>> +=C2=A0=C2=A0=C2=A0 }
>>>> +
>>>> +=C2=A0=C2=A0=C2=A0 dst_state =3D (QTestMigrationState) { };
>>>> +=C2=A0=C2=A0=C2=A0 src_state =3D (QTestMigrationState) { };
>>>> +=C2=A0=C2=A0=C2=A0 bootfile_create(qtest_get_arch(), tmpfs, args->sus=
pend_me);
>>>> +=C2=A0=C2=A0=C2=A0 src_state.suspend_me =3D args->suspend_me;
>>>> +
>>>> +=C2=A0=C2=A0=C2=A0 migrate_args(&cmd_source, &cmd_target, uri, args);
>>>> +
>>>> +=C2=A0=C2=A0=C2=A0 if (!args->only_target) {
>>>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 *from =3D qtest_init_ext(Q=
EMU_ENV_SRC, cmd_source, capabilities, true);
>>>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 qtest_qmp_set_event_callba=
ck(*from,
>>>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 mi=
grate_watch_for_events,
>>>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 &s=
rc_state);
>>>> +=C2=A0=C2=A0=C2=A0 }
>>>> +
>>>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 if (!args->only_source) {
>>>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 *to =3D qtest_i=
nit_ext(QEMU_ENV_DST, cmd_target, capabilities,
>>>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 !args->defer_target_connect);
>>>> @@ -428,6 +441,7 @@ int migrate_start(QTestState **from, QTestState **=
to, const char *uri,
>>>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 * It's valid because QEMU has alr=
eady opened this file
>>>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 */
>>>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 if (args->use_shmem) {
>>>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 g_autofree char *shmem_pat=
h =3D test_shmem_path();
>>>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 unlink(shmem_pa=
th);
>>>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 }
>>=20

