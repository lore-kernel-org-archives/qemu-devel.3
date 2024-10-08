Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id DA4F3CF0427
	for <qemu-devel@archiver.kernel.org>; Tue,  8 Oct 2024 21:37:30 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1syHtE-0008Bn-T2; Tue, 08 Oct 2024 17:37:08 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <farosas@suse.de>)
 id 1syHt9-0008B2-Bq; Tue, 08 Oct 2024 17:37:03 -0400
Received: from smtp-out2.suse.de ([195.135.223.131])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <farosas@suse.de>)
 id 1syHt4-0002Fc-JQ; Tue, 08 Oct 2024 17:37:00 -0400
Received: from imap1.dmz-prg2.suse.org (unknown [10.150.64.97])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by smtp-out2.suse.de (Postfix) with ESMTPS id 164CD1FE12;
 Tue,  8 Oct 2024 21:36:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
 t=1728423416; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=YGrCnPQEmtVsHEmeaPzkii9+ovV5ZjqFCUx6CudZ2dM=;
 b=W5B/zKxf1OmkstKdI8bDOp4ZqwiK/F4WuFsoECvNcvtTqu6YedcepBbdUeMtFn4qRVqtYa
 SRobQ439WHD/HgIAvTjvial8R+Q58zOpybbvLLzl0bMM3C+hjdOCCoPM7MF6dO0UcPcn6q
 z7w+BxkwvwcDh742yHjxzJe0dJBOIws=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
 s=susede2_ed25519; t=1728423416;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=YGrCnPQEmtVsHEmeaPzkii9+ovV5ZjqFCUx6CudZ2dM=;
 b=Wgd08e0keYpFpMN4MkxWAzuMM23LZJn06CBIorPocM7Ls3IZ+IdwHxHFvtY4H9SD7KIXkI
 8gJZ9XgmV/3tedCg==
Authentication-Results: smtp-out2.suse.de;
	none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
 t=1728423416; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=YGrCnPQEmtVsHEmeaPzkii9+ovV5ZjqFCUx6CudZ2dM=;
 b=W5B/zKxf1OmkstKdI8bDOp4ZqwiK/F4WuFsoECvNcvtTqu6YedcepBbdUeMtFn4qRVqtYa
 SRobQ439WHD/HgIAvTjvial8R+Q58zOpybbvLLzl0bMM3C+hjdOCCoPM7MF6dO0UcPcn6q
 z7w+BxkwvwcDh742yHjxzJe0dJBOIws=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
 s=susede2_ed25519; t=1728423416;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=YGrCnPQEmtVsHEmeaPzkii9+ovV5ZjqFCUx6CudZ2dM=;
 b=Wgd08e0keYpFpMN4MkxWAzuMM23LZJn06CBIorPocM7Ls3IZ+IdwHxHFvtY4H9SD7KIXkI
 8gJZ9XgmV/3tedCg==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 8D20013A6E;
 Tue,  8 Oct 2024 21:36:55 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
 by imap1.dmz-prg2.suse.org with ESMTPSA id ZFwQFfelBWcrHAAAD6G6ig
 (envelope-from <farosas@suse.de>); Tue, 08 Oct 2024 21:36:55 +0000
From: Fabiano Rosas <farosas@suse.de>
To: Elena Ufimtseva <ufimtseva@gmail.com>
Cc: qemu-devel@nongnu.org, Peter Xu <peterx@redhat.com>, Peter Maydell
 <peter.maydell@linaro.org>, qemu-stable@nongnu.org
Subject: Re: [PATCH 2/2] migration/multifd: Fix rb->receivedmap cleanup race
In-Reply-To: <CAEr7rXgZiH-cBaoQEUqFb45Ajn78iMboMxLa1jGQJGTXNvrCGw@mail.gmail.com>
References: <20240913220542.18305-1-farosas@suse.de>
 <20240913220542.18305-3-farosas@suse.de>
 <CAEr7rXgZiH-cBaoQEUqFb45Ajn78iMboMxLa1jGQJGTXNvrCGw@mail.gmail.com>
Date: Tue, 08 Oct 2024 18:36:53 -0300
Message-ID: <874j5mtgy2.fsf@suse.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
X-Spamd-Result: default: False [-4.30 / 50.00]; BAYES_HAM(-3.00)[100.00%];
 NEURAL_HAM_LONG(-1.00)[-0.999];
 NEURAL_HAM_SHORT(-0.20)[-1.000]; MIME_GOOD(-0.10)[text/plain];
 ARC_NA(0.00)[]; TO_MATCH_ENVRCPT_ALL(0.00)[];
 MIME_TRACE(0.00)[0:+];
 DKIM_SIGNED(0.00)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
 TO_DN_SOME(0.00)[]; FREEMAIL_TO(0.00)[gmail.com];
 RCVD_TLS_ALL(0.00)[]; FREEMAIL_ENVRCPT(0.00)[gmail.com];
 MISSING_XM_UA(0.00)[]; FROM_EQ_ENVFROM(0.00)[];
 FROM_HAS_DN(0.00)[]; RCPT_COUNT_FIVE(0.00)[5];
 RCVD_COUNT_TWO(0.00)[2]; RCVD_VIA_SMTP_AUTH(0.00)[];
 MID_RHS_MATCH_FROM(0.00)[];
 DBL_BLOCKED_OPENRESOLVER(0.00)[suse.de:email,suse.de:mid]
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

Elena Ufimtseva <ufimtseva@gmail.com> writes:

> On Fri, Sep 13, 2024 at 3:07=E2=80=AFPM Fabiano Rosas <farosas@suse.de> w=
rote:
>
>> Fix a segmentation fault in multifd when rb->receivedmap is cleared
>> too early.
>>
>> After commit 5ef7e26bdb ("migration/multifd: solve zero page causing
>> multiple page faults"), multifd started using the rb->receivedmap
>> bitmap, which belongs to ram.c and is initialized and *freed* from the
>> ram SaveVMHandlers.
>>
>> Multifd threads are live until migration_incoming_state_destroy(),
>> which is called after qemu_loadvm_state_cleanup(), leading to a crash
>> when accessing rb->receivedmap.
>>
>> process_incoming_migration_co()        ...
>>   qemu_loadvm_state()                  multifd_nocomp_recv()
>>     qemu_loadvm_state_cleanup()          ramblock_recv_bitmap_set_offset=
()
>>       rb->receivedmap =3D NULL               set_bit_atomic(...,
>> rb->receivedmap)
>>   ...
>>   migration_incoming_state_destroy()
>>     multifd_recv_cleanup()
>>       multifd_recv_terminate_threads(NULL)
>>
>> Move the loadvm cleanup into migration_incoming_state_destroy(), after
>> multifd_recv_cleanup() to ensure multifd thread have already exited
>> when rb->receivedmap is cleared.
>>
>> The have_listen_thread logic can now be removed because its purpose
>> was to delay cleanup until postcopy_ram_listen_thread() had finished.
>>
>> CC: qemu-stable@nongnu.org
>> Fixes: 5ef7e26bdb ("migration/multifd: solve zero page causing multiple
>> page faults")
>> Signed-off-by: Fabiano Rosas <farosas@suse.de>
>> ---
>>  migration/migration.c | 1 +
>>  migration/migration.h | 1 -
>>  migration/savevm.c    | 9 ---------
>>  3 files changed, 1 insertion(+), 10 deletions(-)
>>
>> diff --git a/migration/migration.c b/migration/migration.c
>> index 3dea06d577..b190a574b1 100644
>> --- a/migration/migration.c
>> +++ b/migration/migration.c
>> @@ -378,6 +378,7 @@ void migration_incoming_state_destroy(void)
>>      struct MigrationIncomingState *mis =3D migration_incoming_get_curre=
nt();
>>
>>      multifd_recv_cleanup();
>> +    qemu_loadvm_state_cleanup();
>>
>>      if (mis->to_src_file) {
>>          /* Tell source that we are done */
>> diff --git a/migration/migration.h b/migration/migration.h
>> index 38aa1402d5..20b0a5b66e 100644
>> --- a/migration/migration.h
>> +++ b/migration/migration.h
>> @@ -101,7 +101,6 @@ struct MigrationIncomingState {
>>      /* Set this when we want the fault thread to quit */
>>      bool           fault_thread_quit;
>>
>> -    bool           have_listen_thread;
>>      QemuThread     listen_thread;
>>
>>      /* For the kernel to send us notifications */
>> diff --git a/migration/savevm.c b/migration/savevm.c
>> index d0759694fd..532ee5e4b0 100644
>> --- a/migration/savevm.c
>> +++ b/migration/savevm.c
>> @@ -2076,10 +2076,8 @@ static void *postcopy_ram_listen_thread(void
>> *opaque)
>>       * got a bad migration state).
>>       */
>>      migration_incoming_state_destroy();
>> -    qemu_loadvm_state_cleanup();
>>
>>      rcu_unregister_thread();
>> -    mis->have_listen_thread =3D false;
>>      postcopy_state_set(POSTCOPY_INCOMING_END);
>>
>>      object_unref(OBJECT(migr));
>> @@ -2130,7 +2128,6 @@ static int
>> loadvm_postcopy_handle_listen(MigrationIncomingState *mis)
>>          return -1;
>>      }
>>
>> -    mis->have_listen_thread =3D true;
>>      postcopy_thread_create(mis, &mis->listen_thread, "mig/dst/listen",
>>                             postcopy_ram_listen_thread,
>> QEMU_THREAD_DETACHED);
>>      trace_loadvm_postcopy_handle_listen("return");
>> @@ -2978,11 +2975,6 @@ int qemu_loadvm_state(QEMUFile *f)
>>
>>      trace_qemu_loadvm_state_post_main(ret);
>>
>> -    if (mis->have_listen_thread) {
>> -        /* Listen thread still going, can't clean up yet */
>> -        return ret;
>> -    }
>> -
>>      if (ret =3D=3D 0) {
>>          ret =3D qemu_file_get_error(f);
>>      }
>> @@ -3022,7 +3014,6 @@ int qemu_loadvm_state(QEMUFile *f)
>>          }
>>      }
>>
>> -    qemu_loadvm_state_cleanup();
>>      cpu_synchronize_all_post_init();
>>
>
>
> Hi Fabiano

Hi, sorry for the delay.

>
> I have a question. By removing  qemu_loadvm_state_cleanup() here, the
> failure path that ends up with exit(EXIT_FAILURE)
> in process_incoming_migration_co() end up not calling the
> qemu_loadvm_state_cleanup(). I am not sure how this is important since
> there is exit, but the
> vfio, for example, will not call the VF reset.

In the fail label, migration_incoming_state_destroy() is called right
before the exit block.

>
> Another more general question is why destination Qemu has to terminate
> there if there was an error detected during live migration?
> Could just failing the migration and leave destination running be a more
> expected scenario?

After failure to load, the destination VM is not really usable, so
terminating it seems ok. This was changed with the addition of
mis->exit_on_error in dbea1c89da ("qapi: introduce exit-on-error
parameter for migrate-incoming"). We still exit on error by default, but
allow the user to modify the behavior to allow management applications
to collect the error or inspect the VM.

>
> Thank you!
>
>      return ret;
>> --
>> 2.35.3
>>
>>
>>

