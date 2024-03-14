Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 51528C54E67
	for <qemu-devel@archiver.kernel.org>; Thu, 14 Mar 2024 16:45:11 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rkoBq-0001Z0-R2; Thu, 14 Mar 2024 12:44:22 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <farosas@suse.de>) id 1rkoBo-0001Yd-NW
 for qemu-devel@nongnu.org; Thu, 14 Mar 2024 12:44:20 -0400
Received: from smtp-out1.suse.de ([2a07:de40:b251:101:10:150:64:1])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <farosas@suse.de>) id 1rkoBn-0000ui-2H
 for qemu-devel@nongnu.org; Thu, 14 Mar 2024 12:44:20 -0400
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org
 [IPv6:2a07:de40:b281:104:10:150:64:97])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by smtp-out1.suse.de (Postfix) with ESMTPS id 1A2E421D46;
 Thu, 14 Mar 2024 16:44:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
 t=1710434657; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=UH61QL0GkokF/slcbMMKtJOUdcSFpvjmLVdflEkSJVk=;
 b=MFiQU1SEuq0aSVUHA4A+sBN3ITdxIHniR5BjFXAFcVwzgBfbYnsxrJ6OMxrPvCYSPszCHX
 ZRJa//rROERRHMYW9XGdD+QkYYLuFqf9w3OwPIgdp+Vxz3WjhLU4WKsGKd/CaHX1WkCzvF
 4sKHN2TA2nb75MYYrG5zf5VoxpwUJfY=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
 s=susede2_ed25519; t=1710434657;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=UH61QL0GkokF/slcbMMKtJOUdcSFpvjmLVdflEkSJVk=;
 b=iO1kH0IzVeaog5gbEADCa7plSUCBcm/qkpbu9z2nOcxm1eeWcUPA8AYVSr4OnsFiIWQsKj
 RpGkz0iW/YihatBA==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
 t=1710434656; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=UH61QL0GkokF/slcbMMKtJOUdcSFpvjmLVdflEkSJVk=;
 b=HDKcvCCidV9nEKBUC2tGmVXExUnB4cWUJxMRU37mAOcrZWuTfnJQfcw4xLwsV7XeLD4sgm
 /HwQ5tz34zaLUMMle0X5q3FMsltjfiSPcMt9jNCsa/bIkhPxSF3vgbC4HhyL09lZM5MQPN
 j5owjEre/gQVjipj3iZy2RCmL5HMroI=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
 s=susede2_ed25519; t=1710434656;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=UH61QL0GkokF/slcbMMKtJOUdcSFpvjmLVdflEkSJVk=;
 b=8CmT2MhaiJsRBtxPXLgsbvParZ0GTyPJrfFBoOLAlP7Z203uyJCPt1ai3ggBQv7VZvfI0Y
 CvZUGfJgv5y+UODQ==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 971111368C;
 Thu, 14 Mar 2024 16:44:15 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
 by imap1.dmz-prg2.suse.org with ESMTPSA id 5iBrF18p82UTQwAAD6G6ig
 (envelope-from <farosas@suse.de>); Thu, 14 Mar 2024 16:44:15 +0000
From: Fabiano Rosas <farosas@suse.de>
To: Peter Xu <peterx@redhat.com>
Cc: qemu-devel@nongnu.org, =?utf-8?Q?Daniel_P_=2E_Berrang=C3=A9?=
 <berrange@redhat.com>
Subject: Re: [PATCH v2 2/2] migration/multifd: Ensure we're not given a
 socket for file migration
In-Reply-To: <ZfMTVApNl01-yS_v@x1n>
References: <20240313212824.16974-1-farosas@suse.de>
 <20240313212824.16974-3-farosas@suse.de> <ZfMTVApNl01-yS_v@x1n>
Date: Thu, 14 Mar 2024 13:44:13 -0300
Message-ID: <87v85ovk4i.fsf@suse.de>
MIME-Version: 1.0
Content-Type: text/plain
X-Rspamd-Server: rspamd1.dmz-prg2.suse.org
X-Spamd-Result: default: False [-4.51 / 50.00]; ARC_NA(0.00)[];
 RCVD_VIA_SMTP_AUTH(0.00)[];
 R_DKIM_ALLOW(-0.20)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
 BAYES_HAM(-3.00)[100.00%]; FROM_HAS_DN(0.00)[];
 RCPT_COUNT_THREE(0.00)[3]; TO_DN_SOME(0.00)[];
 TO_MATCH_ENVRCPT_ALL(0.00)[]; MIME_GOOD(-0.10)[text/plain];
 RECEIVED_SPAMHAUS_BLOCKED_OPENRESOLVER(0.00)[2a07:de40:b281:106:10:150:64:167:received];
 DWL_DNSWL_LOW(-1.00)[suse.de:dkim]; RCVD_COUNT_THREE(0.00)[3];
 DKIM_SIGNED(0.00)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
 DKIM_TRACE(0.00)[suse.de:+]; MX_GOOD(-0.01)[];
 DBL_BLOCKED_OPENRESOLVER(0.00)[suse.de:dkim,suse.de:email];
 FUZZY_BLOCKED(0.00)[rspamd.com]; FROM_EQ_ENVFROM(0.00)[];
 MIME_TRACE(0.00)[0:+]; NEURAL_HAM_SHORT(-0.20)[-0.999];
 RCVD_TLS_ALL(0.00)[]; MID_RHS_MATCH_FROM(0.00)[];
 RBL_SPAMHAUS_BLOCKED_OPENRESOLVER(0.00)[2a07:de40:b281:104:10:150:64:97:from]
Authentication-Results: smtp-out1.suse.de;
 dkim=pass header.d=suse.de header.s=susede2_rsa header.b=HDKcvCCi;
 dkim=pass header.d=suse.de header.s=susede2_ed25519 header.b=8CmT2Mha
X-Rspamd-Queue-Id: 1A2E421D46
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

> On Wed, Mar 13, 2024 at 06:28:24PM -0300, Fabiano Rosas wrote:
>> When doing migration using the fd: URI, the incoming migration starts
>> before the user has passed the file descriptor to QEMU. This means
>> that the checks at migration_channels_and_transport_compatible()
>> happen too soon and we need to allow a migration channel of type
>> SOCKET_ADDRESS_TYPE_FD even though socket migration is not supported
>> with multifd.
>
> Hmm, bare with me if this is a stupid one.. why the incoming migration can
> start _before_ the user passed in the fd?

It's been a while since I looked at this. Looking into it once more
today, I think the issue is actually that we only fetch the fds from the
monitor at fd_start_outgoing|incoming_migration().

>
> IOW, why can't we rely on a single fd_is_socket() check for
> SOCKET_ADDRESS_TYPE_FD in transport_supports_multi_channels()?
>

There's no fd at that point. Just a string.

I think the right fix here would be to move the
monitor_fd_get/monitor_fd_param (why two different functions?) earlier
into migrate_uri_parse. And possibly also extend FileMigrationArgs to
contain an fd. Not sure how easy would that be.

>> 
>> The commit decdc76772 ("migration/multifd: Add mapped-ram support to
>> fd: URI") was supposed to add a second check prior to starting
>> migration to make sure a socket fd is not passed instead of a file fd,
>> but failed to do so.
>> 
>> Add the missing verification.
>> 
>> Fixes: decdc76772 ("migration/multifd: Add mapped-ram support to fd: URI")
>> Signed-off-by: Fabiano Rosas <farosas@suse.de>
>> ---
>>  migration/fd.c   | 8 ++++++++
>>  migration/file.c | 7 +++++++
>>  2 files changed, 15 insertions(+)
>> 
>> diff --git a/migration/fd.c b/migration/fd.c
>> index 39a52e5c90..c07030f715 100644
>> --- a/migration/fd.c
>> +++ b/migration/fd.c
>> @@ -22,6 +22,7 @@
>>  #include "migration.h"
>>  #include "monitor/monitor.h"
>>  #include "io/channel-file.h"
>> +#include "io/channel-socket.h"
>>  #include "io/channel-util.h"
>>  #include "options.h"
>>  #include "trace.h"
>> @@ -95,6 +96,13 @@ void fd_start_incoming_migration(const char *fdname, Error **errp)
>>      }
>>  
>>      if (migrate_multifd()) {
>> +        if (fd_is_socket(fd)) {
>> +            error_setg(errp,
>> +                       "Multifd migration to a socket FD is not supported");
>> +            object_unref(ioc);
>> +            return;
>> +        }
>> +
>>          file_create_incoming_channels(ioc, errp);
>>      } else {
>>          qio_channel_set_name(ioc, "migration-fd-incoming");
>> diff --git a/migration/file.c b/migration/file.c
>> index ddde0ca818..b6e8ba13f2 100644
>> --- a/migration/file.c
>> +++ b/migration/file.c
>> @@ -15,6 +15,7 @@
>>  #include "file.h"
>>  #include "migration.h"
>>  #include "io/channel-file.h"
>> +#include "io/channel-socket.h"
>>  #include "io/channel-util.h"
>>  #include "options.h"
>>  #include "trace.h"
>> @@ -58,6 +59,12 @@ bool file_send_channel_create(gpointer opaque, Error **errp)
>>      int fd = fd_args_get_fd();
>>  
>>      if (fd && fd != -1) {
>> +        if (fd_is_socket(fd)) {
>> +            error_setg(errp,
>> +                       "Multifd migration to a socket FD is not supported");
>> +            goto out;
>> +        }
>> +
>>          ioc = qio_channel_file_new_dupfd(fd, errp);
>>      } else {
>>          ioc = qio_channel_file_new_path(outgoing_args.fname, flags, 0, errp);
>> -- 
>> 2.35.3
>> 

