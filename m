Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 83823E77170
	for <qemu-devel@archiver.kernel.org>; Wed,  4 Dec 2024 19:06:19 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tIuhA-0001ar-0a; Wed, 04 Dec 2024 14:05:56 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <farosas@suse.de>) id 1tIuh7-0001ag-HN
 for qemu-devel@nongnu.org; Wed, 04 Dec 2024 14:05:53 -0500
Received: from smtp-out2.suse.de ([195.135.223.131])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <farosas@suse.de>) id 1tIuh5-0004NN-Lz
 for qemu-devel@nongnu.org; Wed, 04 Dec 2024 14:05:53 -0500
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org
 [IPv6:2a07:de40:b281:104:10:150:64:97])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by smtp-out2.suse.de (Postfix) with ESMTPS id CD39A1F38E;
 Wed,  4 Dec 2024 19:05:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
 t=1733339150; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=7u47I7TnJuP0AKorMZwIFKvJJ4lCX8rcfzVwKBo+LX8=;
 b=Ck2hHP5t7ZFOm/t7vb+OXwL74BJNwuOgwAMS2Yer6+vQkk5YNvOlmzUYYmThpinqP14pL9
 y1TE2UMfmdJ39pdrbbffFRvO/DlcjoVvDkKUwSZpVfmxSPFNmO6v1R9H+vj+bDCem8KOH8
 koO2wxs4jzHp8GlQJUtKAf+174vUPxY=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
 s=susede2_ed25519; t=1733339150;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=7u47I7TnJuP0AKorMZwIFKvJJ4lCX8rcfzVwKBo+LX8=;
 b=4jHiSGCeyFiKEoS2mX7HTj2A1oSjCjwah8ZNvGlPWtwVhQnLOQKnJdpdTwE5JQSV8S2CK+
 YN7Kr7vcKlwRtABw==
Authentication-Results: smtp-out2.suse.de;
 dkim=pass header.d=suse.de header.s=susede2_rsa header.b=Y36om1bj;
 dkim=pass header.d=suse.de header.s=susede2_ed25519 header.b=zfUcBdCX
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
 t=1733339148; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=7u47I7TnJuP0AKorMZwIFKvJJ4lCX8rcfzVwKBo+LX8=;
 b=Y36om1bjdtBMmhBW2HbPvdI+HQIg5Lr3so9MKDalP7gDPVNt7gxTRa8riqIonG1RbqVS/C
 fgz9fptcqQuxA7O06rFLzMcAyY/AWTw+ktHu3647Rn4ln7cT6B7mQSJX435DwHRlwB1hwT
 pnck1zCVImXvb81GOKCAg0cpVzqzvAI=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
 s=susede2_ed25519; t=1733339148;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=7u47I7TnJuP0AKorMZwIFKvJJ4lCX8rcfzVwKBo+LX8=;
 b=zfUcBdCXjc1SIWzcJJqDAxeGEJc3r6LBLidDxRs9PiRMMXS+v+NE3sicSyCNDwC6i+UUv1
 KQ8UOJjN86dA+hDA==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 5627A13974;
 Wed,  4 Dec 2024 19:05:48 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
 by imap1.dmz-prg2.suse.org with ESMTPSA id RYgLBwyoUGchMQAAD6G6ig
 (envelope-from <farosas@suse.de>); Wed, 04 Dec 2024 19:05:48 +0000
From: Fabiano Rosas <farosas@suse.de>
To: Peter Xu <peterx@redhat.com>
Cc: qemu-devel@nongnu.org, =?utf-8?Q?Daniel_P_=2E_Berrang=C3=A9?=
 <berrange@redhat.com>, Thomas Huth <thuth@redhat.com>
Subject: Re: [PATCH 5/6] migration: Fix hang after error in destination
 setup phase
In-Reply-To: <Z1CjE2UYUECkRhJZ@x1n>
References: <20241202220137.32584-1-farosas@suse.de>
 <20241202220137.32584-6-farosas@suse.de> <Z1CjE2UYUECkRhJZ@x1n>
Date: Wed, 04 Dec 2024 16:05:45 -0300
Message-ID: <87o71ri7zq.fsf@suse.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
X-Rspamd-Queue-Id: CD39A1F38E
X-Spamd-Result: default: False [-4.51 / 50.00]; BAYES_HAM(-3.00)[99.99%];
 NEURAL_HAM_LONG(-1.00)[-1.000];
 R_DKIM_ALLOW(-0.20)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
 NEURAL_HAM_SHORT(-0.20)[-1.000]; MIME_GOOD(-0.10)[text/plain];
 MX_GOOD(-0.01)[]; RCVD_VIA_SMTP_AUTH(0.00)[];
 MISSING_XM_UA(0.00)[]; MIME_TRACE(0.00)[0:+]; ARC_NA(0.00)[];
 TO_DN_SOME(0.00)[]; MID_RHS_MATCH_FROM(0.00)[];
 RCVD_TLS_ALL(0.00)[]; RCPT_COUNT_THREE(0.00)[4];
 FROM_EQ_ENVFROM(0.00)[]; FROM_HAS_DN(0.00)[];
 FUZZY_BLOCKED(0.00)[rspamd.com]; RCVD_COUNT_TWO(0.00)[2];
 TO_MATCH_ENVRCPT_ALL(0.00)[];
 DBL_BLOCKED_OPENRESOLVER(0.00)[suse.de:email,suse.de:dkim,suse.de:mid,imap1.dmz-prg2.suse.org:helo,imap1.dmz-prg2.suse.org:rdns];
 DKIM_SIGNED(0.00)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
 DKIM_TRACE(0.00)[suse.de:+]
X-Rspamd-Server: rspamd2.dmz-prg2.suse.org
X-Rspamd-Action: no action
Received-SPF: pass client-ip=195.135.223.131; envelope-from=farosas@suse.de;
 helo=smtp-out2.suse.de
X-Spam_score_int: -43
X-Spam_score: -4.4
X-Spam_bar: ----
X-Spam_report: (-4.4 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_MED=-2.3, RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001,
 RCVD_IN_VALIDITY_SAFE_BLOCKED=0.001, SPF_HELO_NONE=0.001,
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

Peter Xu <peterx@redhat.com> writes:

> On Mon, Dec 02, 2024 at 07:01:36PM -0300, Fabiano Rosas wrote:
>> If the destination side fails at migration_ioc_process_incoming()
>> before starting the coroutine, it will report the error but QEMU will
>> not exit.
>>=20
>> Set the migration state to FAILED and exit the process if
>> exit-on-error allows.
>>=20
>> CC: Thomas Huth <thuth@redhat.com>
>> Resolves: https://gitlab.com/qemu-project/qemu/-/issues/2633
>> Reported-by: Daniel P. Berrang=C3=A9 <berrange@redhat.com>
>> Signed-off-by: Fabiano Rosas <farosas@suse.de>
>
> (I skipped the postcopy patches as of now, until we finish the discussion
>  in patch 2)
>
>> ---
>>  migration/channel.c   | 11 ++++++-----
>>  migration/migration.c | 31 ++++++++++++++++++-------------
>>  migration/migration.h |  2 +-
>>  3 files changed, 25 insertions(+), 19 deletions(-)
>>=20
>> diff --git a/migration/channel.c b/migration/channel.c
>> index f9de064f3b..6d7f9172d8 100644
>> --- a/migration/channel.c
>> +++ b/migration/channel.c
>> @@ -40,13 +40,14 @@ void migration_channel_process_incoming(QIOChannel *=
ioc)
>>=20=20
>>      if (migrate_channel_requires_tls_upgrade(ioc)) {
>>          migration_tls_channel_process_incoming(s, ioc, &local_err);
>> +
>> +        if (local_err) {
>> +            error_report_err(local_err);
>> +        }
>
> What if tls processing failed here, do we have similar issue that qemu wi=
ll
> stall?  Do we want to cover that too?
>

Hmm, I think I confused this with the multifd_channel_connect() stuff
where the code is reentrant and we take the "regular" path when called a
second time. I need to look closer into this part.

>> +
>>      } else {
>>          migration_ioc_register_yank(ioc);
>> -        migration_ioc_process_incoming(ioc, &local_err);
>> -    }
>> -
>> -    if (local_err) {
>> -        error_report_err(local_err);
>> +        migration_ioc_process_incoming(ioc);
>>      }
>>  }
>>=20=20
>> diff --git a/migration/migration.c b/migration/migration.c
>> index 8a61cc26d7..cd88ebc875 100644
>> --- a/migration/migration.c
>> +++ b/migration/migration.c
>> @@ -943,7 +943,7 @@ static bool migration_should_start_incoming(bool mai=
n_channel)
>>      return true;
>>  }
>>=20=20
>> -void migration_ioc_process_incoming(QIOChannel *ioc, Error **errp)
>> +void migration_ioc_process_incoming(QIOChannel *ioc)
>>  {
>>      MigrationIncomingState *mis =3D migration_incoming_get_current();
>>      Error *local_err =3D NULL;
>> @@ -966,10 +966,9 @@ void migration_ioc_process_incoming(QIOChannel *ioc=
, Error **errp)
>>           * issue is not possible.
>>           */
>>          ret =3D migration_channel_read_peek(ioc, (void *)&channel_magic,
>> -                                          sizeof(channel_magic), errp);
>> -
>> +                                          sizeof(channel_magic), &local=
_err);
>>          if (ret !=3D 0) {
>> -            return;
>> +            goto err;
>>          }
>>=20=20
>>          default_channel =3D (channel_magic =3D=3D cpu_to_be32(QEMU_VM_F=
ILE_MAGIC));
>> @@ -977,8 +976,8 @@ void migration_ioc_process_incoming(QIOChannel *ioc,=
 Error **errp)
>>          default_channel =3D !mis->from_src_file;
>>      }
>>=20=20
>> -    if (multifd_recv_setup(errp) !=3D 0) {
>> -        return;
>> +    if (multifd_recv_setup(&local_err) !=3D 0) {
>> +        goto err;
>>      }
>>=20=20
>>      if (default_channel) {
>> @@ -995,18 +994,24 @@ void migration_ioc_process_incoming(QIOChannel *io=
c, Error **errp)
>>              postcopy_preempt_new_channel(mis, f);
>>          }
>>          if (local_err) {
>> -            error_propagate(errp, local_err);
>> -            return;
>> +            goto err;
>>          }
>>      }
>>=20=20
>> -    if (migration_should_start_incoming(default_channel)) {
>> -        /* If it's a recovery, we're done */
>> -        if (postcopy_try_recover()) {
>> -            return;
>> -        }
>> +    if (migration_should_start_incoming(default_channel) &&
>> +        !postcopy_try_recover()) {
>>          migration_incoming_process();
>>      }
>> +
>> +    return;
>> +
>> +err:
>> +    error_report_err(local_err);
>> +    migrate_set_state(&mis->state, MIGRATION_STATUS_SETUP,
>> +                      MIGRATION_STATUS_FAILED);
>> +    if (mis->exit_on_error) {
>> +        exit(EXIT_FAILURE);
>> +    }
>>  }
>>=20=20
>>  /**
>> diff --git a/migration/migration.h b/migration/migration.h
>> index 0956e9274b..c367e5ea40 100644
>> --- a/migration/migration.h
>> +++ b/migration/migration.h
>> @@ -477,7 +477,7 @@ void migrate_set_state(MigrationStatus *state, Migra=
tionStatus old_state,
>>                         MigrationStatus new_state);
>>=20=20
>>  void migration_fd_process_incoming(QEMUFile *f);
>> -void migration_ioc_process_incoming(QIOChannel *ioc, Error **errp);
>> +void migration_ioc_process_incoming(QIOChannel *ioc);
>>  void migration_incoming_process(void);
>>=20=20
>>  bool  migration_has_all_channels(void);
>> --=20
>> 2.35.3
>>=20

