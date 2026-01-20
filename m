Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D83E6CA5FD7
	for <qemu-devel@archiver.kernel.org>; Tue, 20 Jan 2026 18:19:15 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1viGJ2-0008GA-Ka; Tue, 20 Jan 2026 13:18:20 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <farosas@suse.de>) id 1viGIy-0008CP-1e
 for qemu-devel@nongnu.org; Tue, 20 Jan 2026 13:18:16 -0500
Received: from smtp-out2.suse.de ([2a07:de40:b251:101:10:150:64:2])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <farosas@suse.de>) id 1viGIv-0002Rg-O7
 for qemu-devel@nongnu.org; Tue, 20 Jan 2026 13:18:15 -0500
Received: from imap1.dmz-prg2.suse.org (unknown [10.150.64.97])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by smtp-out2.suse.de (Postfix) with ESMTPS id E08E65BCC3;
 Tue, 20 Jan 2026 18:18:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
 t=1768933091; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=YLNCGS/0C6dp1/9N/zIyIn0EirHAi2opVXHTWFw3RwE=;
 b=uj0KismVyA4PtPVg8k72vYcBUGYAyULkpQ/7gR/HXepTb+2Flt7cOmTqqqDeNvdmboCQ/w
 hz/9KG0lNbk6HJcC6cKJLmtnLrwegwcZmMsgvliZ/6GuIOfeFeisO932qat3KbtH+rF9lF
 Y91+pRk/3NH8cZMI5JAC4bfiSlKVZ8s=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
 s=susede2_ed25519; t=1768933091;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=YLNCGS/0C6dp1/9N/zIyIn0EirHAi2opVXHTWFw3RwE=;
 b=3lVaoKYHQ7uc6m+TnulT9hUq2KS7lErskGYWghstB5VTb+wt0rJA4zO8hEKu5iMk7Wbs/z
 lZD8EhlyYL0KHNDA==
Authentication-Results: smtp-out2.suse.de;
	none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
 t=1768933090; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=YLNCGS/0C6dp1/9N/zIyIn0EirHAi2opVXHTWFw3RwE=;
 b=fr3SgyT2bWh/Nb/i7OLHaI5WbljSO1J9DEb0TmVp4ed6Iq1FcUja101196cTRMEJb/KuTT
 20S/tM1a3Ov9unY5p5Epx1d4CkDmh5RZnu2sPkgq3U66HC2/jZN17u9VseyGNY2xt4SA0l
 +g/4XeZo86zCGsRxMX9ZOnjB4t1XsvE=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
 s=susede2_ed25519; t=1768933090;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=YLNCGS/0C6dp1/9N/zIyIn0EirHAi2opVXHTWFw3RwE=;
 b=Xk9HhSUKJOYbrxuz4R0JRxzx/nAyVj32C9jC6u2PQJHjiDG79aY52rLUXqUFiDUfAgF4VA
 ZeB1QvJ3iuIZeEBg==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 53A413EA63;
 Tue, 20 Jan 2026 18:18:10 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
 by imap1.dmz-prg2.suse.org with ESMTPSA id rotbBOLGb2lsQwAAD6G6ig
 (envelope-from <farosas@suse.de>); Tue, 20 Jan 2026 18:18:10 +0000
From: Fabiano Rosas <farosas@suse.de>
To: Prasad Pandit <ppandit@redhat.com>
Cc: qemu-devel@nongnu.org, peterx@redhat.com, berrange@redhat.com
Subject: Re: [PATCH v3 20/25] migration: Move channel parsing to channel.c
In-Reply-To: <CAE8KmOzKkF2M0c4yresB+Y87XTXssbmvGp77C640tt33dbj37g@mail.gmail.com>
References: <20260109124043.25019-1-farosas@suse.de>
 <20260109124043.25019-21-farosas@suse.de>
 <CAE8KmOzKkF2M0c4yresB+Y87XTXssbmvGp77C640tt33dbj37g@mail.gmail.com>
Date: Tue, 20 Jan 2026 15:18:07 -0300
Message-ID: <87ikcw87xc.fsf@suse.de>
MIME-Version: 1.0
Content-Type: text/plain
X-Spamd-Result: default: False [-4.30 / 50.00]; BAYES_HAM(-3.00)[100.00%];
 NEURAL_HAM_LONG(-1.00)[-1.000];
 NEURAL_HAM_SHORT(-0.20)[-0.999]; MIME_GOOD(-0.10)[text/plain];
 FROM_HAS_DN(0.00)[]; TO_MATCH_ENVRCPT_ALL(0.00)[];
 DKIM_SIGNED(0.00)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
 FUZZY_RATELIMITED(0.00)[rspamd.com]; MIME_TRACE(0.00)[0:+];
 ARC_NA(0.00)[]; RCVD_TLS_ALL(0.00)[];
 RCPT_COUNT_THREE(0.00)[4]; MISSING_XM_UA(0.00)[];
 FROM_EQ_ENVFROM(0.00)[]; TO_DN_SOME(0.00)[];
 RCVD_COUNT_TWO(0.00)[2]; RCVD_VIA_SMTP_AUTH(0.00)[];
 MID_RHS_MATCH_FROM(0.00)[];
 DBL_BLOCKED_OPENRESOLVER(0.00)[fedoraproject.org:email, suse.de:mid,
 suse.de:email, imap1.dmz-prg2.suse.org:helo]
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
List-Id: qemu development <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <https://lists.nongnu.org/archive/html/qemu-devel>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=subscribe>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org

Prasad Pandit <ppandit@redhat.com> writes:

> On Fri, 9 Jan 2026 at 18:14, Fabiano Rosas <farosas@suse.de> wrote:
>> Encapsulate the MigrationChannelList parsing in a new
>> migrate_channels_parse() located at channel.c.
>>
>> This also makes the memory management of the MigrationAddress more
>> uniform. Previously, half the parsing code (uri parsing) would
>> allocate memory for the address while the other half (channel parsing)
>> would instead pass the original QAPI object along. After this patch,
>> the MigrationAddress is always QAPI_CLONEd, so the callers can use
>> g_autoptr(MigrationAddress) in all cases.
>>
>> Reviewed-by: Peter Xu <peterx@redhat.com>
>> Signed-off-by: Fabiano Rosas <farosas@suse.de>
>> ---
>>  migration/channel.c   | 45 ++++++++++++++++++++++++++++++++++++++
>>  migration/channel.h   |  5 +++++
>>  migration/migration.c | 50 ++++++++++++-------------------------------
>>  3 files changed, 64 insertions(+), 36 deletions(-)
>>
>> diff --git a/migration/channel.c b/migration/channel.c
>> index 56c80b5cdf..8b71b3f430 100644
>> --- a/migration/channel.c
>> +++ b/migration/channel.c
>> @@ -11,6 +11,7 @@
>>   */
>>
>>  #include "qemu/osdep.h"
>> +#include "qemu/cutils.h"
>>  #include "channel.h"
>>  #include "exec.h"
>>  #include "fd.h"
>> @@ -20,7 +21,9 @@
>>  #include "migration.h"
>>  #include "multifd.h"
>>  #include "options.h"
>> +#include "qapi/clone-visitor.h"
>>  #include "qapi/qapi-types-migration.h"
>> +#include "qapi/qapi-visit-migration.h"
>>  #include "qapi/error.h"
>>  #include "qemu-file.h"
>>  #include "qemu/yank.h"
>> @@ -280,3 +283,45 @@ int migration_channel_read_peek(QIOChannel *ioc,
>>
>>      return 0;
>>  }
>> +
>> +bool migrate_channels_parse(MigrationChannelList *channels,
>> +                            MigrationChannel **main_channelp,
>> +                            MigrationChannel **cpr_channelp,
>> +                            Error **errp)
>> +{
>> +    MigrationChannel *channelv[MIGRATION_CHANNEL_TYPE__MAX] = { NULL };
>> +    bool single_channel = cpr_channelp ? false : true;
>> +
>> +    if (single_channel && channels->next) {
>> +        error_setg(errp, "Channel list must have only one entry, "
>> +                   "for type 'main'");
>> +        return false;
>> +    }
>
> * Instead of the single_channel variable above, we could say
> (!cpr_channelp && channels->next)? and avoid the single_channel
> variable.
>

ok

>> +    for ( ; channels; channels = channels->next) {
>> +        MigrationChannelType type;
>> +
>> +        type = channels->value->channel_type;
>> +        if (channelv[type]) {
>> +            error_setg(errp, "Channel list has more than one %s entry",
>> +                       MigrationChannelType_str(type));
>> +            return false;
>> +        }
>> +        channelv[type] = channels->value;
>> +    }
>> +
>> +    if (cpr_channelp) {
>> +        *cpr_channelp = QAPI_CLONE(MigrationChannel,
>> +                                   channelv[MIGRATION_CHANNEL_TYPE_CPR]);
>> +    }
>> +
>> +    *main_channelp = QAPI_CLONE(MigrationChannel,
>> +                                channelv[MIGRATION_CHANNEL_TYPE_MAIN]);
>> +
>> +    if (!(*main_channelp)->addr) {
>> +        error_setg(errp, "Channel list has no main entry");
>> +        return false;
>> +    }
>> +
>> +    return true;
>> +}
>> diff --git a/migration/channel.h b/migration/channel.h
>> index 8264fe327d..5110fb45a4 100644
>> --- a/migration/channel.h
>> +++ b/migration/channel.h
>> @@ -42,4 +42,9 @@ bool migration_has_all_channels(void);
>>  void migration_connect_outgoing(MigrationState *s, MigrationAddress *addr,
>>                                  Error **errp);
>>  void migration_connect_incoming(MigrationAddress *addr, Error **errp);
>> +
>> +bool migrate_channels_parse(MigrationChannelList *channels,
>> +                            MigrationChannel **main_channelp,
>> +                            MigrationChannel **cpr_channelp,
>> +                            Error **errp);
>>  #endif
>> diff --git a/migration/migration.c b/migration/migration.c
>> index 3c93fb23cc..98c1f38e8e 100644
>> --- a/migration/migration.c
>> +++ b/migration/migration.c
>> @@ -741,8 +741,7 @@ static void qemu_setup_incoming_migration(const char *uri, bool has_channels,
>>                                            MigrationChannelList *channels,
>>                                            Error **errp)
>>  {
>> -    g_autoptr(MigrationChannel) channel = NULL;
>> -    MigrationAddress *addr = NULL;
>> +    g_autoptr(MigrationChannel) main_ch = NULL;
>>      MigrationIncomingState *mis = migration_incoming_get_current();
>>
>>      /*
>> @@ -754,25 +753,20 @@ static void qemu_setup_incoming_migration(const char *uri, bool has_channels,
>>      }
>>
>>      if (channels) {
>> -        /* To verify that Migrate channel list has only item */
>> -        if (channels->next) {
>> -            error_setg(errp, "Channel list must have only one entry, "
>> -                             "for type 'main'");
>> +        if (!migrate_channels_parse(channels, &main_ch, NULL, errp)) {
>>              return;
>>          }
>> -        addr = channels->value->addr;
>>      }
>>
>>      if (uri) {
>>          /* caller uses the old URI syntax */
>> -        if (!migrate_uri_parse(uri, &channel, errp)) {
>> +        if (!migrate_uri_parse(uri, &main_ch, errp)) {
>>              return;
>>          }
>> -        addr = channel->addr;
>>      }
>>
>>      /* transport mechanism not suitable for migration? */
>> -    if (!migration_transport_compatible(addr, errp)) {
>> +    if (!migration_transport_compatible(main_ch->addr, errp)) {
>>          return;
>>      }
>>
>> @@ -780,7 +774,7 @@ static void qemu_setup_incoming_migration(const char *uri, bool has_channels,
>>          return;
>>      }
>>
>> -    migration_connect_incoming(addr, errp);
>> +    migration_connect_incoming(main_ch->addr, errp);
>>
>>      /* Close cpr socket to tell source that we are listening */
>>      cpr_state_close();
>> @@ -2116,10 +2110,8 @@ void qmp_migrate(const char *uri, bool has_channels,
>>                   bool has_resume, bool resume, Error **errp)
>>  {
>>      MigrationState *s = migrate_get_current();
>> -    g_autoptr(MigrationChannel) channel = NULL;
>> -    MigrationAddress *addr = NULL;
>> -    MigrationChannel *channelv[MIGRATION_CHANNEL_TYPE__MAX] = { NULL };
>> -    MigrationChannel *cpr_channel = NULL;
>> +    g_autoptr(MigrationChannel) main_ch = NULL;
>> +    g_autoptr(MigrationChannel) cpr_ch = NULL;
>>
>>      /*
>>       * Having preliminary checks for uri and channel
>> @@ -2130,38 +2122,24 @@ void qmp_migrate(const char *uri, bool has_channels,
>>      }
>>
>>      if (channels) {
>> -        for ( ; channels; channels = channels->next) {
>> -            MigrationChannelType type = channels->value->channel_type;
>> -
>> -            if (channelv[type]) {
>> -                error_setg(errp, "Channel list has more than one %s entry",
>> -                           MigrationChannelType_str(type));
>> -                return;
>> -            }
>> -            channelv[type] = channels->value;
>> -        }
>> -        cpr_channel = channelv[MIGRATION_CHANNEL_TYPE_CPR];
>> -        addr = channelv[MIGRATION_CHANNEL_TYPE_MAIN]->addr;
>> -        if (!addr) {
>> -            error_setg(errp, "Channel list has no main entry");
>> +        if (!migrate_channels_parse(channels, &main_ch, &cpr_ch, errp)) {
>>              return;
>>          }
>>      }
>>
>>      if (uri) {
>>          /* caller uses the old URI syntax */
>> -        if (!migrate_uri_parse(uri, &channel, errp)) {
>> +        if (!migrate_uri_parse(uri, &main_ch, errp)) {
>>              return;
>>          }
>> -        addr = channel->addr;
>>      }
>>
>>      /* transport mechanism not suitable for migration? */
>> -    if (!migration_transport_compatible(addr, errp)) {
>> +    if (!migration_transport_compatible(main_ch->addr, errp)) {
>>          return;
>>      }
>>
>> -    if (migrate_mode() == MIG_MODE_CPR_TRANSFER && !cpr_channel) {
>> +    if (migrate_mode() == MIG_MODE_CPR_TRANSFER && !cpr_ch) {
>>          error_setg(errp, "missing 'cpr' migration channel");
>>          return;
>>      }
>
> * This check for (_CPR_TRANSFER && !cpr_ch) and error could be moved
> to migrate_channels_parse() as is done for the main_ch.
>

Hm, it would then apply to the incoming side as well which can't set the
mode due to how cpr-transfer works. But I guess it's fine as the
invocation of migration_channel_parse_input is already different between
src and dst. I'll change it. Thanks

>> @@ -2178,7 +2156,7 @@ void qmp_migrate(const char *uri, bool has_channels,
>>       */
>>      Error *local_err = NULL;
>>
>> -    if (!cpr_state_save(cpr_channel, &local_err)) {
>> +    if (!cpr_state_save(cpr_ch, &local_err)) {
>>          goto out;
>>      }
>>
>> @@ -2194,10 +2172,10 @@ void qmp_migrate(const char *uri, bool has_channels,
>>       */
>>      if (migrate_mode() == MIG_MODE_CPR_TRANSFER) {
>>          migrate_hup_add(s, cpr_state_ioc(), (GSourceFunc)qmp_migrate_finish_cb,
>> -                        QAPI_CLONE(MigrationAddress, addr));
>> +                        QAPI_CLONE(MigrationAddress, main_ch->addr));
>>
>>      } else {
>> -        qmp_migrate_finish(addr, errp);
>> +        qmp_migrate_finish(main_ch->addr, errp);
>>      }
>>
>>  out:
>> --
>
> * Otherwise it looks okay.
> Reviewed-by: Prasad Pandit <pjp@fedoraproject.org>
>
> Thank you.
> ---
>   - Prasad

