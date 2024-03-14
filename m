Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C70E1C54E5D
	for <qemu-devel@archiver.kernel.org>; Thu, 14 Mar 2024 16:51:21 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rkoHf-0003uj-Li; Thu, 14 Mar 2024 12:50:23 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <farosas@suse.de>) id 1rkoHe-0003tr-Pz
 for qemu-devel@nongnu.org; Thu, 14 Mar 2024 12:50:22 -0400
Received: from smtp-out1.suse.de ([2a07:de40:b251:101:10:150:64:1])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <farosas@suse.de>) id 1rkoHb-0002FX-Kp
 for qemu-devel@nongnu.org; Thu, 14 Mar 2024 12:50:22 -0400
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org [10.150.64.97])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by smtp-out1.suse.de (Postfix) with ESMTPS id 8BDCC21CE8;
 Thu, 14 Mar 2024 16:50:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
 t=1710435010; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=mon/R/0ujW9x+cxDN0VH5AW91KheoY9TYM1d9QBb/48=;
 b=cmo8QdSwz77E98k/YWybpMcX0ymig+uaIod4468O077l1h6UJSqHCqiNZOl+J4CqIGl2ix
 fYk55KqTZSTr7GtneD+ydspQHUxFD6Iug/OiXfw9gokd4SXC6LD7aHW1efotNtigX9gekc
 2IT3NwGjUMlny0EvqnN3OpjkDXENfBE=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
 s=susede2_ed25519; t=1710435010;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=mon/R/0ujW9x+cxDN0VH5AW91KheoY9TYM1d9QBb/48=;
 b=71lheqmdop63KIsjamLoYPor6HmeN71omqFq4NPIt78X9feefRHHwVqyf6/V1p4Ya8p27w
 YE/NytAPAoC9F+BA==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
 t=1710435010; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=mon/R/0ujW9x+cxDN0VH5AW91KheoY9TYM1d9QBb/48=;
 b=cmo8QdSwz77E98k/YWybpMcX0ymig+uaIod4468O077l1h6UJSqHCqiNZOl+J4CqIGl2ix
 fYk55KqTZSTr7GtneD+ydspQHUxFD6Iug/OiXfw9gokd4SXC6LD7aHW1efotNtigX9gekc
 2IT3NwGjUMlny0EvqnN3OpjkDXENfBE=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
 s=susede2_ed25519; t=1710435010;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=mon/R/0ujW9x+cxDN0VH5AW91KheoY9TYM1d9QBb/48=;
 b=71lheqmdop63KIsjamLoYPor6HmeN71omqFq4NPIt78X9feefRHHwVqyf6/V1p4Ya8p27w
 YE/NytAPAoC9F+BA==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 163F21368E;
 Thu, 14 Mar 2024 16:50:09 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
 by imap1.dmz-prg2.suse.org with ESMTPSA id 0jqoM8Eq82UHRQAAD6G6ig
 (envelope-from <farosas@suse.de>); Thu, 14 Mar 2024 16:50:09 +0000
From: Fabiano Rosas <farosas@suse.de>
To: Peter Xu <peterx@redhat.com>
Cc: qemu-devel@nongnu.org, =?utf-8?Q?Daniel_P_=2E_Berrang=C3=A9?=
 <berrange@redhat.com>
Subject: Re: [PATCH v2 2/2] migration/multifd: Ensure we're not given a
 socket for file migration
In-Reply-To: <ZfMbJnC96vUXnPTJ@x1n>
References: <20240313212824.16974-1-farosas@suse.de>
 <20240313212824.16974-3-farosas@suse.de> <ZfMTVApNl01-yS_v@x1n>
 <ZfMbJnC96vUXnPTJ@x1n>
Date: Thu, 14 Mar 2024 13:50:07 -0300
Message-ID: <87sf0svjuo.fsf@suse.de>
MIME-Version: 1.0
Content-Type: text/plain
X-Spamd-Result: default: False [-3.30 / 50.00]; ARC_NA(0.00)[];
 RCVD_VIA_SMTP_AUTH(0.00)[]; BAYES_HAM(-3.00)[100.00%];
 FROM_HAS_DN(0.00)[]; RCPT_COUNT_THREE(0.00)[3];
 TO_DN_SOME(0.00)[]; TO_MATCH_ENVRCPT_ALL(0.00)[];
 MIME_GOOD(-0.10)[text/plain]; RCVD_COUNT_THREE(0.00)[3];
 DKIM_SIGNED(0.00)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
 NEURAL_HAM_SHORT(-0.20)[-0.995];
 DBL_BLOCKED_OPENRESOLVER(0.00)[suse.de:email];
 FUZZY_BLOCKED(0.00)[rspamd.com]; FROM_EQ_ENVFROM(0.00)[];
 MIME_TRACE(0.00)[0:+]; RCVD_TLS_ALL(0.00)[];
 MID_RHS_MATCH_FROM(0.00)[]
Authentication-Results: smtp-out1.suse.de;
	none
Received-SPF: pass client-ip=2a07:de40:b251:101:10:150:64:1;
 envelope-from=farosas@suse.de; helo=smtp-out1.suse.de
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

> On Thu, Mar 14, 2024 at 11:10:12AM -0400, Peter Xu wrote:
>> On Wed, Mar 13, 2024 at 06:28:24PM -0300, Fabiano Rosas wrote:
>> > When doing migration using the fd: URI, the incoming migration starts
>> > before the user has passed the file descriptor to QEMU. This means
>> > that the checks at migration_channels_and_transport_compatible()
>> > happen too soon and we need to allow a migration channel of type
>> > SOCKET_ADDRESS_TYPE_FD even though socket migration is not supported
>> > with multifd.
>> 
>> Hmm, bare with me if this is a stupid one.. why the incoming migration can
>> start _before_ the user passed in the fd?
>> 
>> IOW, why can't we rely on a single fd_is_socket() check for
>> SOCKET_ADDRESS_TYPE_FD in transport_supports_multi_channels()?
>> 
>> > 
>> > The commit decdc76772 ("migration/multifd: Add mapped-ram support to
>> > fd: URI") was supposed to add a second check prior to starting
>> > migration to make sure a socket fd is not passed instead of a file fd,
>> > but failed to do so.
>> > 
>> > Add the missing verification.
>> > 
>> > Fixes: decdc76772 ("migration/multifd: Add mapped-ram support to fd: URI")
>> > Signed-off-by: Fabiano Rosas <farosas@suse.de>
>> > ---
>> >  migration/fd.c   | 8 ++++++++
>> >  migration/file.c | 7 +++++++
>> >  2 files changed, 15 insertions(+)
>> > 
>> > diff --git a/migration/fd.c b/migration/fd.c
>> > index 39a52e5c90..c07030f715 100644
>> > --- a/migration/fd.c
>> > +++ b/migration/fd.c
>> > @@ -22,6 +22,7 @@
>> >  #include "migration.h"
>> >  #include "monitor/monitor.h"
>> >  #include "io/channel-file.h"
>> > +#include "io/channel-socket.h"
>> >  #include "io/channel-util.h"
>> >  #include "options.h"
>> >  #include "trace.h"
>> > @@ -95,6 +96,13 @@ void fd_start_incoming_migration(const char *fdname, Error **errp)
>> >      }
>> >  
>> >      if (migrate_multifd()) {
>> > +        if (fd_is_socket(fd)) {
>> > +            error_setg(errp,
>> > +                       "Multifd migration to a socket FD is not supported");
>> > +            object_unref(ioc);
>> > +            return;
>> > +        }
>
> And... I just noticed this is forbiding multifd+socket+fd in general?  But
> isn't that the majority of multifd usage when with libvirt over sockets?

I didn't think multifd supported socket fds, does it? I don't see code
to create the multiple channels anywhere. How would that work? Multiple
threads writing to a single socket fd? I'm a bit confused.

>
> Shouldn't it about fd's seekable-or-not instead when mapped-ram enabled
> (IOW, migration_needs_seekable_channel() only)?

Yes, that could be a validation to be done if we actually get the fd at
the right moment.

>
>> > +
>> >          file_create_incoming_channels(ioc, errp);
>> >      } else {
>> >          qio_channel_set_name(ioc, "migration-fd-incoming");
>> > diff --git a/migration/file.c b/migration/file.c
>> > index ddde0ca818..b6e8ba13f2 100644
>> > --- a/migration/file.c
>> > +++ b/migration/file.c
>> > @@ -15,6 +15,7 @@
>> >  #include "file.h"
>> >  #include "migration.h"
>> >  #include "io/channel-file.h"
>> > +#include "io/channel-socket.h"
>> >  #include "io/channel-util.h"
>> >  #include "options.h"
>> >  #include "trace.h"
>> > @@ -58,6 +59,12 @@ bool file_send_channel_create(gpointer opaque, Error **errp)
>> >      int fd = fd_args_get_fd();
>> >  
>> >      if (fd && fd != -1) {
>> > +        if (fd_is_socket(fd)) {
>> > +            error_setg(errp,
>> > +                       "Multifd migration to a socket FD is not supported");
>> > +            goto out;
>> > +        }
>> > +
>> >          ioc = qio_channel_file_new_dupfd(fd, errp);
>> >      } else {
>> >          ioc = qio_channel_file_new_path(outgoing_args.fname, flags, 0, errp);
>> > -- 
>> > 2.35.3
>> > 
>> 
>> -- 
>> Peter Xu

