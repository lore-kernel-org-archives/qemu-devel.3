Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5B1D8E9271B
	for <qemu-devel@archiver.kernel.org>; Mon, 29 Dec 2025 19:52:13 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vaJHV-0000fV-1B; Mon, 29 Dec 2025 14:51:53 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <farosas@suse.de>) id 1vaJHT-0000dP-01
 for qemu-devel@nongnu.org; Mon, 29 Dec 2025 14:51:51 -0500
Received: from smtp-out2.suse.de ([2a07:de40:b251:101:10:150:64:2])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <farosas@suse.de>) id 1vaJHQ-00025D-O5
 for qemu-devel@nongnu.org; Mon, 29 Dec 2025 14:51:50 -0500
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org
 [IPv6:2a07:de40:b281:104:10:150:64:97])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by smtp-out2.suse.de (Postfix) with ESMTPS id 018295BCE2;
 Mon, 29 Dec 2025 19:51:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
 t=1767037907; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=JcjTPBWK0RmOEAEoPN4Fq9MWCiqHV71xMMmWKXhivlA=;
 b=XoB4WLaFG4qfBDZkthtE1b0O7LoK5JTby6Ms8Hy6TrIuSMdELm4uEpIcQp3Y3+3RUws3/z
 j7ehY4W8xHbotF55ikyzbFMaDXbVlvxx/2lI6VfE7zRCaVuDi9CNjDv6NhGkZsEUm+nJW/
 qrDLcJVMYcTMsLhoZL7EhavJ8IAsJN8=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
 s=susede2_ed25519; t=1767037907;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=JcjTPBWK0RmOEAEoPN4Fq9MWCiqHV71xMMmWKXhivlA=;
 b=VubipLiinyCWP5hwDz9wjnT6odyFOrun8pLJH4IY88mxcd9ejvZ7oJP5SPNM1nO1yAabjz
 DSZp+uxz+E4S89BQ==
Authentication-Results: smtp-out2.suse.de;
 dkim=pass header.d=suse.de header.s=susede2_rsa header.b=MO47XcR7;
 dkim=pass header.d=suse.de header.s=susede2_ed25519 header.b=3vBuywWL
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
 t=1767037906; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=JcjTPBWK0RmOEAEoPN4Fq9MWCiqHV71xMMmWKXhivlA=;
 b=MO47XcR7VCgxW5FAz5u3iGw7oiSi1KZkEEFeN1U9V5HOJK2N4PRX6yYQ0yt/kWfj0CYosT
 nPUTgBYjxtxNXWjDhh/K8nRCuSA/ZE+91c3H43yNGVZtteHW7o+8yN06iBbDLfK6EMamaM
 u0dC2SqcLq3URnlDT2Xo65TrqCBJiho=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
 s=susede2_ed25519; t=1767037906;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=JcjTPBWK0RmOEAEoPN4Fq9MWCiqHV71xMMmWKXhivlA=;
 b=3vBuywWLtVPF25aqQBbP3tE7C+aLKS6I4lliLsy6fSwYAuT6uThABoIZhAaLhiB7E3nuea
 DyfJPNrrFpNAk0DA==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 6FBE7137C3;
 Mon, 29 Dec 2025 19:51:45 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
 by imap1.dmz-prg2.suse.org with ESMTPSA id xQxCDNHbUmmxWAAAD6G6ig
 (envelope-from <farosas@suse.de>); Mon, 29 Dec 2025 19:51:45 +0000
From: Fabiano Rosas <farosas@suse.de>
To: Peter Xu <peterx@redhat.com>
Cc: qemu-devel@nongnu.org, Li Zhijian <lizhijian@fujitsu.com>
Subject: Re: [RFC PATCH 14/25] migration: Remove QEMUFile from channel.c
In-Reply-To: <aVLYQGQo2gSRs7Xm@x1.local>
References: <20251226211930.27565-1-farosas@suse.de>
 <20251226211930.27565-15-farosas@suse.de> <aVLYQGQo2gSRs7Xm@x1.local>
Date: Mon, 29 Dec 2025 16:51:42 -0300
Message-ID: <87a4z183sh.fsf@suse.de>
MIME-Version: 1.0
Content-Type: text/plain
X-Rspamd-Queue-Id: 018295BCE2
X-Spamd-Result: default: False [-5.51 / 50.00]; BAYES_HAM(-3.00)[100.00%];
 NEURAL_HAM_LONG(-1.00)[-1.000];
 DWL_DNSWL_LOW(-1.00)[suse.de:dkim];
 R_DKIM_ALLOW(-0.20)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
 NEURAL_HAM_SHORT(-0.20)[-1.000]; MIME_GOOD(-0.10)[text/plain];
 MX_GOOD(-0.01)[];
 URIBL_BLOCKED(0.00)[imap1.dmz-prg2.suse.org:rdns,imap1.dmz-prg2.suse.org:helo,suse.de:mid,suse.de:dkim,suse.de:email];
 DKIM_SIGNED(0.00)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
 MIME_TRACE(0.00)[0:+]; TO_MATCH_ENVRCPT_ALL(0.00)[];
 TO_DN_SOME(0.00)[]; ARC_NA(0.00)[];
 FUZZY_RATELIMITED(0.00)[rspamd.com]; FROM_HAS_DN(0.00)[];
 DKIM_TRACE(0.00)[suse.de:+];
 SPAMHAUS_XBL(0.00)[2a07:de40:b281:104:10:150:64:97:from];
 DNSWL_BLOCKED(0.00)[2a07:de40:b281:106:10:150:64:167:received];
 RCVD_COUNT_TWO(0.00)[2]; FROM_EQ_ENVFROM(0.00)[];
 RCVD_TLS_ALL(0.00)[]; MID_RHS_MATCH_FROM(0.00)[];
 MISSING_XM_UA(0.00)[]; RCVD_VIA_SMTP_AUTH(0.00)[];
 RCPT_COUNT_THREE(0.00)[3];
 DBL_BLOCKED_OPENRESOLVER(0.00)[imap1.dmz-prg2.suse.org:rdns,
 imap1.dmz-prg2.suse.org:helo]
X-Rspamd-Server: rspamd1.dmz-prg2.suse.org
X-Rspamd-Action: no action
Received-SPF: pass client-ip=2a07:de40:b251:101:10:150:64:2;
 envelope-from=farosas@suse.de; helo=smtp-out2.suse.de
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, SPF_HELO_NONE=0.001,
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

> On Fri, Dec 26, 2025 at 06:19:16PM -0300, Fabiano Rosas wrote:
>> Make channel.c deal only with QIOChannel objects. Move any handling of
>> QEMUFile into migration.c. To achieve this in a clean way:
>> 
>> 1) Define a migration_outgoing_setup, analogous to
>> migration_incoming_setup, responsible for creating the QEMUFile from
>> the QIOChannel.
>> 
>> 2) Increase the scope of migration_incoming_setup to create not only
>> the main channel, but all the others as well. That is currently being
>> done at migration_ioc_process, so move the code.
>> 
>> 3) Adjust RDMA code to pass in the QIOChannel and remove some of the
>> usage of QEMUFile.
>> 
>> Signed-off-by: Fabiano Rosas <farosas@suse.de>
>> ---
>>  migration/channel.c   | 21 ++++++-----
>>  migration/migration.c | 88 ++++++++++++++++++++++---------------------
>>  migration/migration.h |  6 ++-
>>  migration/multifd.c   |  7 ++--
>>  migration/multifd.h   |  2 +-
>>  migration/rdma.c      | 28 ++++----------
>>  6 files changed, 73 insertions(+), 79 deletions(-)
>> 
>> diff --git a/migration/channel.c b/migration/channel.c
>> index 7243b99108..af6c2cc76e 100644
>> --- a/migration/channel.c
>> +++ b/migration/channel.c
>> @@ -14,7 +14,6 @@
>>  #include "channel.h"
>>  #include "tls.h"
>>  #include "migration.h"
>> -#include "qemu-file.h"
>>  #include "trace.h"
>>  #include "qapi/error.h"
>>  #include "io/channel-tls.h"
>> @@ -34,6 +33,7 @@ void migration_channel_process_incoming(QIOChannel *ioc)
>>  {
>>      MigrationIncomingState *mis = migration_incoming_get_current();
>>      Error *local_err = NULL;
>> +    uint8_t ch;
>>  
>>      trace_migration_set_incoming_channel(
>>          ioc, object_get_typename(OBJECT(ioc)));
>> @@ -42,9 +42,16 @@ void migration_channel_process_incoming(QIOChannel *ioc)
>>          migration_tls_channel_process_incoming(ioc, &local_err);
>>      } else {
>>          migration_ioc_register_yank(ioc);
>> -        migration_ioc_process_incoming(ioc, &local_err);
>> -    }
>> +        ch = migration_ioc_process_incoming(ioc, &local_err);
>> +        if (!ch) {
>> +            goto out;
>> +        }
>>  
>> +        if (migration_incoming_setup(ioc, ch, &local_err)) {
>> +            migration_incoming_process();
>> +        }
>> +    }
>> +out:
>>      if (local_err) {
>>          error_report_err(local_err);
>>          migrate_set_state(&mis->state, mis->state, MIGRATION_STATUS_FAILED);
>> @@ -75,14 +82,8 @@ void migration_channel_connect(MigrationState *s, QIOChannel *ioc)
>>          return;
>>      }
>>  
>> -    QEMUFile *f = qemu_file_new_output(ioc);
>> -
>>      migration_ioc_register_yank(ioc);
>> -
>> -    qemu_mutex_lock(&s->qemu_file_lock);
>> -    s->to_dst_file = f;
>> -    qemu_mutex_unlock(&s->qemu_file_lock);
>> -
>> +    migration_outgoing_setup(ioc);
>>      migration_connect(s);
>>  }
>>  
>> diff --git a/migration/migration.c b/migration/migration.c
>> index 5c6c76f110..677581b5a5 100644
>> --- a/migration/migration.c
>> +++ b/migration/migration.c
>> @@ -92,7 +92,7 @@ enum mig_rp_message_type {
>>  };
>>  
>>  /* Migration channel types */
>> -enum { CH_MAIN, CH_MULTIFD, CH_POSTCOPY };
>> +enum { CH_NONE, CH_MAIN, CH_MULTIFD, CH_POSTCOPY };
>>  
>>  /* When we add fault tolerance, we could have several
>>     migrations at once.  For now we don't need to add
>> @@ -934,17 +934,48 @@ out:
>>      migrate_incoming_unref_outgoing_state();
>>  }
>>  
>> -/**
>> - * migration_incoming_setup: Setup incoming migration
>> - * @f: file for main migration channel
>> - */
>> -static void migration_incoming_setup(QEMUFile *f)
>> +static bool migration_has_main_and_multifd_channels(void);
>> +
>> +bool migration_incoming_setup(QIOChannel *ioc, uint8_t channel, Error **errp)
>>  {
>>      MigrationIncomingState *mis = migration_incoming_get_current();
>> +    QEMUFile *f;
>>  
>> -    assert(!mis->from_src_file);
>> -    mis->from_src_file = f;
>> -    qemu_file_set_blocking(f, false, &error_abort);
>> +    switch (channel) {
>> +    case CH_MAIN:
>> +        f = qemu_file_new_input(ioc);
>> +        assert(!mis->from_src_file);
>> +        mis->from_src_file = f;
>> +        qemu_file_set_blocking(f, false, &error_abort);
>> +        break;
>> +
>> +    case CH_MULTIFD:
>> +        if (!multifd_recv_new_channel(ioc, errp)) {
>> +            return false;
>> +        }
>> +        break;
>> +
>> +    case CH_POSTCOPY:
>> +        assert(!mis->postcopy_qemufile_dst);
>> +        f = qemu_file_new_input(ioc);
>> +        postcopy_preempt_new_channel(mis, f);
>> +        return false;
>> +
>> +    default:
>> +        g_assert_not_reached();
>> +    }
>> +
>> +    return migration_has_main_and_multifd_channels();
>> +}
>> +
>> +void migration_outgoing_setup(QIOChannel *ioc)
>> +{
>> +    MigrationState *s = migrate_get_current();
>> +    QEMUFile *f = qemu_file_new_output(ioc);
>> +
>> +    qemu_mutex_lock(&s->qemu_file_lock);
>> +    s->to_dst_file = f;
>> +    qemu_mutex_unlock(&s->qemu_file_lock);
>>  }
>>  
>>  /* Returns true if recovered from a paused migration, otherwise false */
>> @@ -990,12 +1021,6 @@ void migration_incoming_process(void)
>>      qemu_coroutine_enter(co);
>>  }
>>  
>> -void migration_fd_process_incoming(QEMUFile *f)
>> -{
>> -    migration_incoming_setup(f);
>> -    migration_incoming_process();
>> -}
>> -
>>  static bool migration_has_main_and_multifd_channels(void)
>>  {
>>      MigrationIncomingState *mis = migration_incoming_get_current();
>> @@ -1012,12 +1037,10 @@ static bool migration_has_main_and_multifd_channels(void)
>>      return true;
>>  }
>>  
>> -void migration_ioc_process_incoming(QIOChannel *ioc, Error **errp)
>> +uint8_t migration_ioc_process_incoming(QIOChannel *ioc, Error **errp)
>>  {
>>      MigrationIncomingState *mis = migration_incoming_get_current();
>> -    Error *local_err = NULL;
>> -    QEMUFile *f;
>> -    uint8_t channel;
>> +    uint8_t channel = CH_NONE;
>>      uint32_t channel_magic = 0;
>>      int ret = 0;
>>  
>> @@ -1036,7 +1059,7 @@ void migration_ioc_process_incoming(QIOChannel *ioc, Error **errp)
>>              ret = migration_channel_read_peek(ioc, (void *)&channel_magic,
>>                                                sizeof(channel_magic), errp);
>>              if (ret != 0) {
>> -                return;
>> +                goto out;
>>              }
>>  
>>              channel_magic = be32_to_cpu(channel_magic);
>> @@ -1051,7 +1074,6 @@ void migration_ioc_process_incoming(QIOChannel *ioc, Error **errp)
>>                  channel = CH_MAIN;
>>              } else {
>>                  error_setg(errp, "unknown channel magic: %u", channel_magic);
>> -                return;
>>              }
>>          } else if (mis->from_src_file && migrate_multifd()) {
>>              /*
>> @@ -1063,33 +1085,13 @@ void migration_ioc_process_incoming(QIOChannel *ioc, Error **errp)
>>              channel = CH_MAIN;
>>          } else {
>>              error_setg(errp, "non-peekable channel used without multifd");
>> -            return;
>>          }
>>      } else {
>>          assert(migrate_postcopy_preempt());
>>          channel = CH_POSTCOPY;
>>      }
>> -
>> -    if (channel == CH_MAIN) {
>> -        f = qemu_file_new_input(ioc);
>> -        migration_incoming_setup(f);
>> -    } else if (channel == CH_MULTIFD) {
>> -        /* Multiple connections */
>> -        multifd_recv_new_channel(ioc, &local_err);
>> -        if (local_err) {
>> -            error_propagate(errp, local_err);
>> -            return;
>> -        }
>> -    } else if (channel == CH_POSTCOPY) {
>> -        assert(!mis->postcopy_qemufile_dst);
>> -        f = qemu_file_new_input(ioc);
>> -        postcopy_preempt_new_channel(mis, f);
>> -        return;
>> -    }
>> -
>> -    if (migration_has_main_and_multifd_channels()) {
>> -        migration_incoming_process();
>> -    }
>> +out:
>> +    return channel;
>>  }
>>  
>>  /**
>> diff --git a/migration/migration.h b/migration/migration.h
>> index f340cd518d..d2b82cf54f 100644
>> --- a/migration/migration.h
>> +++ b/migration/migration.h
>> @@ -526,8 +526,10 @@ struct MigrationState {
>>  void migrate_set_state(MigrationStatus *state, MigrationStatus old_state,
>>                         MigrationStatus new_state);
>>  
>> -void migration_fd_process_incoming(QEMUFile *f);
>> -void migration_ioc_process_incoming(QIOChannel *ioc, Error **errp);
>> +void migration_outgoing_setup(QIOChannel *ioc);
>> +bool migration_incoming_setup(QIOChannel *ioc, uint8_t channel, Error **errp);
>> +
>> +uint8_t migration_ioc_process_incoming(QIOChannel *ioc, Error **errp);
>>  void migration_incoming_process(void);
>>  
>>  bool  migration_has_all_channels(void);
>> diff --git a/migration/multifd.c b/migration/multifd.c
>> index 3fb1a07ba9..c6639dbab5 100644
>> --- a/migration/multifd.c
>> +++ b/migration/multifd.c
>> @@ -1521,7 +1521,7 @@ bool multifd_recv_all_channels_created(void)
>>   * Try to receive all multifd channels to get ready for the migration.
>>   * Sets @errp when failing to receive the current channel.
>>   */
>> -void multifd_recv_new_channel(QIOChannel *ioc, Error **errp)
>> +bool multifd_recv_new_channel(QIOChannel *ioc, Error **errp)
>>  {
>>      MultiFDRecvParams *p;
>>      Error *local_err = NULL;
>> @@ -1536,7 +1536,7 @@ void multifd_recv_new_channel(QIOChannel *ioc, Error **errp)
>>                                      "failed to receive packet"
>>                                      " via multifd channel %d: ",
>>                                      qatomic_read(&multifd_recv_state->count));
>> -            return;
>> +            return false;
>>          }
>>          trace_multifd_recv_new_channel(id);
>>      } else {
>> @@ -1549,7 +1549,7 @@ void multifd_recv_new_channel(QIOChannel *ioc, Error **errp)
>>                     id);
>>          multifd_recv_terminate_threads(error_copy(local_err));
>>          error_propagate(errp, local_err);
>> -        return;
>> +        return false;
>>      }
>>      p->c = ioc;
>>      object_ref(OBJECT(ioc));
>> @@ -1558,4 +1558,5 @@ void multifd_recv_new_channel(QIOChannel *ioc, Error **errp)
>>      qemu_thread_create(&p->thread, p->name, multifd_recv_thread, p,
>>                         QEMU_THREAD_JOINABLE);
>>      qatomic_inc(&multifd_recv_state->count);
>> +    return true;
>>  }
>> diff --git a/migration/multifd.h b/migration/multifd.h
>> index 9b6d81e7ed..89a395aef2 100644
>> --- a/migration/multifd.h
>> +++ b/migration/multifd.h
>> @@ -42,7 +42,7 @@ int multifd_recv_setup(Error **errp);
>>  void multifd_recv_cleanup(void);
>>  void multifd_recv_shutdown(void);
>>  bool multifd_recv_all_channels_created(void);
>> -void multifd_recv_new_channel(QIOChannel *ioc, Error **errp);
>> +bool multifd_recv_new_channel(QIOChannel *ioc, Error **errp);
>>  void multifd_recv_sync_main(void);
>>  int multifd_send_sync_main(MultiFDSyncReq req);
>>  bool multifd_queue_page(RAMBlock *block, ram_addr_t offset);
>> diff --git a/migration/rdma.c b/migration/rdma.c
>> index 596a1aba0b..7bee871e2b 100644
>> --- a/migration/rdma.c
>> +++ b/migration/rdma.c
>> @@ -384,7 +384,6 @@ struct QIOChannelRDMA {
>>      QIOChannel parent;
>>      RDMAContext *rdmain;
>>      RDMAContext *rdmaout;
>> -    QEMUFile *file;
>>      bool blocking; /* XXX we don't actually honour this yet */
>>  };
>>  
>> @@ -3836,32 +3835,20 @@ static void qio_channel_rdma_register_types(void)
>>  
>>  type_init(qio_channel_rdma_register_types);
>>  
>> -static QEMUFile *rdma_new_input(RDMAContext *rdma)
>> +static QIOChannel *rdma_new_ioc(RDMAContext *rdma)
>>  {
>>      QIOChannelRDMA *rioc = QIO_CHANNEL_RDMA(object_new(TYPE_QIO_CHANNEL_RDMA));
>>  
>> -    rioc->file = qemu_file_new_input(QIO_CHANNEL(rioc));
>> -    rioc->rdmain = rdma;
>> -    rioc->rdmaout = rdma->return_path;
>> -
>> -    return rioc->file;
>> -}
>> -
>> -static QEMUFile *rdma_new_output(RDMAContext *rdma)
>> -{
>> -    QIOChannelRDMA *rioc = QIO_CHANNEL_RDMA(object_new(TYPE_QIO_CHANNEL_RDMA));
>> -
>> -    rioc->file = qemu_file_new_output(QIO_CHANNEL(rioc));
>>      rioc->rdmaout = rdma;
>>      rioc->rdmain = rdma->return_path;
>
> Likely it was overlooked rdmaout/rdmain was set in reverse order in these
> two functions.  I gave it a quick run on rdma and it was indeed broken
> starting from this patch.
>

I'll remember to test rdma next time, thanks for catching this.

> The goal of the change looks reasonable in general otherwise, said that,
> maybe there's way to split the patch somehow?
>

Yes, no problem.

