Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3DDC1E92FDE
	for <qemu-devel@archiver.kernel.org>; Mon, 29 Dec 2025 21:15:25 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vaKa0-0001mq-Gp; Mon, 29 Dec 2025 16:15:04 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <farosas@suse.de>) id 1vaKZz-0001mJ-Jo
 for qemu-devel@nongnu.org; Mon, 29 Dec 2025 16:15:03 -0500
Received: from smtp-out2.suse.de ([2a07:de40:b251:101:10:150:64:2])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <farosas@suse.de>) id 1vaKZx-00089J-Fk
 for qemu-devel@nongnu.org; Mon, 29 Dec 2025 16:15:03 -0500
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org
 [IPv6:2a07:de40:b281:104:10:150:64:97])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by smtp-out2.suse.de (Postfix) with ESMTPS id 2BE9D5BCD9;
 Mon, 29 Dec 2025 21:14:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
 t=1767042897; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=tKsyT7tbp7WuqZuoaJlBJ8qywR2mV3VRst23hULT+2E=;
 b=RYNPsOduMAtUQVt5pU+BVqO+XY7bl89mXD8Gg7W6QBuX99pG5bODxbXzy1vDaerTmKElKA
 MfliDt/Q1uodRDv2H8PgOcT/moxHptHpt7uvht8lPAyVNyKFF7x9buL+n/xsjlHO8V1f2D
 sdE9KoVZnV8Bs+vlQjVfr0Bcwpuy51k=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
 s=susede2_ed25519; t=1767042897;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=tKsyT7tbp7WuqZuoaJlBJ8qywR2mV3VRst23hULT+2E=;
 b=XC4yGGwFlnWSuuvSm8eki9oqG9eO7leLD7L4d4w871RxnEGWg6ZendASVKpXW8qEytDTju
 jz7sbcZlkXgiXnBg==
Authentication-Results: smtp-out2.suse.de;
 dkim=pass header.d=suse.de header.s=susede2_rsa header.b=q6QP+dRA;
 dkim=pass header.d=suse.de header.s=susede2_ed25519 header.b=ODi4GEoT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
 t=1767042896; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=tKsyT7tbp7WuqZuoaJlBJ8qywR2mV3VRst23hULT+2E=;
 b=q6QP+dRAHIk0nXXBtqf8WCq+NbTB8iSr3VnPp32adgmo16CK5Md3fZ9Kam6x9pibiVyYn4
 7krYdY/GmVkM/b6+PyRn+TxxMLRqNdQg2wkga7DSlcINB9xAIkvxjuu37grEYraj6TrgPB
 T9VblWXqV57XGhQFmc1IRDLqj1s7wqU=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
 s=susede2_ed25519; t=1767042896;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=tKsyT7tbp7WuqZuoaJlBJ8qywR2mV3VRst23hULT+2E=;
 b=ODi4GEoT1Hjxf0lrSJF+Fn3c42RF3cDC4AU7sD7T8+NwaDBklgKgHcnXBQ+FGXwaZzJwFO
 fYGdXWSN2OMfgbAA==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 9CA0F137C3;
 Mon, 29 Dec 2025 21:14:55 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
 by imap1.dmz-prg2.suse.org with ESMTPSA id NuhGF0/vUmmhZAAAD6G6ig
 (envelope-from <farosas@suse.de>); Mon, 29 Dec 2025 21:14:55 +0000
From: Fabiano Rosas <farosas@suse.de>
To: Peter Xu <peterx@redhat.com>
Cc: qemu-devel@nongnu.org
Subject: Re: [RFC PATCH 22/25] migration/channel: Merge both sides of the
 connection initiation code
In-Reply-To: <aVLfYlEwDu3rL3wj@x1.local>
References: <20251226211930.27565-1-farosas@suse.de>
 <20251226211930.27565-23-farosas@suse.de> <aVLfYlEwDu3rL3wj@x1.local>
Date: Mon, 29 Dec 2025 18:14:52 -0300
Message-ID: <875x9p7zxv.fsf@suse.de>
MIME-Version: 1.0
Content-Type: text/plain
X-Rspamd-Queue-Id: 2BE9D5BCD9
X-Spamd-Result: default: False [-4.51 / 50.00]; BAYES_HAM(-3.00)[100.00%];
 NEURAL_HAM_LONG(-1.00)[-1.000];
 R_DKIM_ALLOW(-0.20)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
 NEURAL_HAM_SHORT(-0.20)[-1.000]; MIME_GOOD(-0.10)[text/plain];
 MX_GOOD(-0.01)[];
 DKIM_SIGNED(0.00)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
 URIBL_BLOCKED(0.00)[suse.de:mid,suse.de:dkim,suse.de:email,imap1.dmz-prg2.suse.org:rdns,imap1.dmz-prg2.suse.org:helo];
 RCPT_COUNT_TWO(0.00)[2]; FROM_HAS_DN(0.00)[]; ARC_NA(0.00)[];
 FUZZY_RATELIMITED(0.00)[rspamd.com]; TO_DN_SOME(0.00)[];
 MIME_TRACE(0.00)[0:+]; TO_MATCH_ENVRCPT_ALL(0.00)[];
 RCVD_TLS_ALL(0.00)[]; DKIM_TRACE(0.00)[suse.de:+];
 DNSWL_BLOCKED(0.00)[2a07:de40:b281:106:10:150:64:167:received];
 RCVD_COUNT_TWO(0.00)[2]; FROM_EQ_ENVFROM(0.00)[];
 SPAMHAUS_XBL(0.00)[2a07:de40:b281:104:10:150:64:97:from];
 MID_RHS_MATCH_FROM(0.00)[]; RCVD_VIA_SMTP_AUTH(0.00)[];
 DWL_DNSWL_BLOCKED(0.00)[suse.de:dkim]; MISSING_XM_UA(0.00)[];
 DBL_BLOCKED_OPENRESOLVER(0.00)[suse.de:mid, suse.de:dkim, suse.de:email,
 imap1.dmz-prg2.suse.org:rdns, imap1.dmz-prg2.suse.org:helo]
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

> On Fri, Dec 26, 2025 at 06:19:24PM -0300, Fabiano Rosas wrote:
>> Now that everything is in channel.c, it's easier to browse this code
>> if it's all in the same place. It's also easier to grasp what the
>> connection flow is if both sides of the connection are close together.
>> 
>> Signed-off-by: Fabiano Rosas <farosas@suse.de>
>> ---
>>  migration/channel.c | 86 +++++++++++++++++++++++----------------------
>>  migration/channel.h | 14 ++++++--
>>  2 files changed, 56 insertions(+), 44 deletions(-)
>> 
>> diff --git a/migration/channel.c b/migration/channel.c
>> index 042e01b224..ba9aa1c58b 100644
>> --- a/migration/channel.c
>> +++ b/migration/channel.c
>> @@ -31,10 +31,11 @@
>>  #include "trace.h"
>>  #include "yank_functions.h"
>>  
>> -bool migration_connect_outgoing(MigrationAddress *addr, Error **errp)
>> +bool migration_connect(MigrationAddress *addr, bool out, Error **errp)
>>  {
>>      g_autoptr(QIOChannel) ioc = NULL;
>>      SocketAddress *saddr;
>> +    ERRP_GUARD();
>>  
>>      switch (addr->transport) {
>>      case MIGRATION_ADDRESS_TYPE_SOCKET:
>> @@ -44,15 +45,24 @@ bool migration_connect_outgoing(MigrationAddress *addr, Error **errp)
>>          case SOCKET_ADDRESS_TYPE_INET:
>>          case SOCKET_ADDRESS_TYPE_UNIX:
>>          case SOCKET_ADDRESS_TYPE_VSOCK:
>> -            socket_connect_outgoing(saddr, errp);
>> -            /*
>> -             * async: after the socket is connected, calls
>> -             * migration_channel_connect_outgoing() directly.
>> -             */
>> -            return true;
>> +            if (out) {
>
> Personally I wouldn't suggest we merge the outgoing / incoming with
> migration_connect() then split paths once more in this exact function.
>
> I got this conclusion when I started to count how many "if (out)" are
> there..  When there're too much, it may imply we need to think more..
>

Well, compared to before, there 50% less "if (addr->transport == ...)",
this is top level programming! =D

This part of the series is highly subjective, if there's a patch you
don't like it we can drop it, let's not dwell on it.. Just read my words
below on the previous patch, which I think you may be mistaken about.

> This also answers part of my confusion when reading the previous patch - if
> that was only paving way for this one, IMHO it may not be as worthwhile,
> and I would tend to avoid both.
>

Patch 21 is just a cleanup after patch 19 moves the call to
migration_channel_connect_outgoing from being inside the transport
routines to this top level here at migration_connect(), which moves the
places where MigrationState is used as well. So it removes unused
passing of MigrationState along with the SocketConnectionData.

> Thoughts?
>
>> +                socket_connect_outgoing(saddr, errp);
>> +                /*
>> +                 * async: after the socket is connected, calls
>> +                 * migration_channel_connect_outgoing() directly.
>> +                 */
>> +                return true;
>> +            } else {
>> +                socket_connect_incoming(saddr, errp);
>> +            }
>> +
>>              break;
>>          case SOCKET_ADDRESS_TYPE_FD:
>> -            ioc = fd_connect_outgoing(saddr->u.fd.str, errp);
>> +            if (out) {
>> +                ioc = fd_connect_outgoing(saddr->u.fd.str, errp);
>> +            } else {
>> +                fd_connect_incoming(saddr->u.fd.str, errp);
>> +            }
>>              break;
>>          default:
>>              g_assert_not_reached();
>> @@ -62,16 +72,28 @@ bool migration_connect_outgoing(MigrationAddress *addr, Error **errp)
>>  
>>  #ifdef CONFIG_RDMA
>>      case MIGRATION_ADDRESS_TYPE_RDMA:
>> -        ioc = rdma_connect_outgoing(&addr->u.rdma, errp);
>> +        if (out) {
>> +            ioc = rdma_connect_outgoing(&addr->u.rdma, errp);
>> +        } else {
>> +            rdma_connect_incoming(&addr->u.rdma, errp);
>> +        }
>>          break;
>>  #endif
>>  
>>      case MIGRATION_ADDRESS_TYPE_EXEC:
>> -        ioc = exec_connect_outgoing(addr->u.exec.args, errp);
>> +        if (out) {
>> +            ioc = exec_connect_outgoing(addr->u.exec.args, errp);
>> +        } else {
>> +            exec_connect_incoming(addr->u.exec.args, errp);
>> +        }
>>          break;
>>  
>>      case MIGRATION_ADDRESS_TYPE_FILE:
>> -        ioc = file_connect_outgoing(&addr->u.file, errp);
>> +        if (out) {
>> +            ioc = file_connect_outgoing(&addr->u.file, errp);
>> +        } else {
>> +            file_connect_incoming(&addr->u.file, errp);
>> +        }
>>          break;
>>  
>>      default:
>> @@ -79,42 +101,22 @@ bool migration_connect_outgoing(MigrationAddress *addr, Error **errp)
>>          break;
>>      }
>>  
>> -    if (!ioc) {
>> -        return false;
>> -    }
>> -
>> -    migration_channel_connect_outgoing(ioc);
>> -    return true;
>> -}
>> -
>> -void migration_connect_incoming(MigrationAddress *addr, Error **errp)
>> -{
>> -    if (addr->transport == MIGRATION_ADDRESS_TYPE_SOCKET) {
>> -        SocketAddress *saddr = &addr->u.socket;
>> -        if (saddr->type == SOCKET_ADDRESS_TYPE_INET ||
>> -            saddr->type == SOCKET_ADDRESS_TYPE_UNIX ||
>> -            saddr->type == SOCKET_ADDRESS_TYPE_VSOCK) {
>> -            socket_connect_incoming(saddr, errp);
>> -        } else if (saddr->type == SOCKET_ADDRESS_TYPE_FD) {
>> -            fd_connect_incoming(saddr->u.fd.str, errp);
>> +    if (out) {
>> +        if (!ioc) {
>> +            return false;
>>          }
>> -#ifdef CONFIG_RDMA
>> -    } else if (addr->transport == MIGRATION_ADDRESS_TYPE_RDMA) {
>> -        rdma_connect_incoming(&addr->u.rdma, errp);
>> -#endif
>> -    } else if (addr->transport == MIGRATION_ADDRESS_TYPE_EXEC) {
>> -        exec_connect_incoming(addr->u.exec.args, errp);
>> -    } else if (addr->transport == MIGRATION_ADDRESS_TYPE_FILE) {
>> -        file_connect_incoming(&addr->u.file, errp);
>> -    } else {
>> -        error_setg(errp, "unknown migration protocol");
>> +
>> +        migration_channel_connect_outgoing(ioc);
>> +        return true;
>>      }
>>  
>>      /*
>> -     * async: the above routines all wait for the incoming connection
>> -     * and call back to migration_channel_process_incoming() to start
>> -     * the migration.
>> +     * async: on the incoming side all of the transport routines above
>> +     * wait for the incoming connection and call back to
>> +     * migration_channel_process_incoming() to start the migration.
>>       */
>> +
>> +    return !*errp;
>>  }
>>  
>>  bool migration_has_main_and_multifd_channels(void)
>> diff --git a/migration/channel.h b/migration/channel.h
>> index 8cf16bfda9..86934fee38 100644
>> --- a/migration/channel.h
>> +++ b/migration/channel.h
>> @@ -39,6 +39,16 @@ int migration_channel_read_peek(QIOChannel *ioc,
>>  bool migration_has_main_and_multifd_channels(void);
>>  bool migration_has_all_channels(void);
>>  
>> -bool migration_connect_outgoing(MigrationAddress *addr, Error **errp);
>> -void migration_connect_incoming(MigrationAddress *addr, Error **errp);
>> +bool migration_connect(MigrationAddress *addr, bool out, Error **errp);
>> +static inline bool migration_connect_outgoing(MigrationAddress *addr,
>> +                                              Error **errp)
>> +{
>> +    return migration_connect(addr, true, errp);
>> +}
>> +
>> +static inline bool migration_connect_incoming(MigrationAddress *addr,
>> +                                              Error **errp)
>> +{
>> +    return migration_connect(addr, false, errp);
>> +}
>>  #endif
>> -- 
>> 2.51.0
>> 

