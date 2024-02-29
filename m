Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 765AEC48BF6
	for <qemu-devel@archiver.kernel.org>; Thu, 29 Feb 2024 13:19:45 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rfgJn-0006dI-6s; Thu, 29 Feb 2024 08:19:23 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <farosas@suse.de>) id 1rfgJl-0006ca-Ad
 for qemu-devel@nongnu.org; Thu, 29 Feb 2024 08:19:21 -0500
Received: from smtp-out1.suse.de ([195.135.223.130])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <farosas@suse.de>) id 1rfgJi-0003nt-TL
 for qemu-devel@nongnu.org; Thu, 29 Feb 2024 08:19:21 -0500
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org [10.150.64.97])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by smtp-out1.suse.de (Postfix) with ESMTPS id 0A68122868;
 Thu, 29 Feb 2024 13:19:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
 t=1709212757; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=yNNAnUc9QV5fumPC0hfBb9cb3IkOcIBHsZlH6T7uArs=;
 b=Go/qdKrjKC3ytg152Nfe10wMAcJgIYxqvMH6cbj760LIOU0nD/Ix9oV3ql6DRVGKGa1o9H
 a1r1jnnhiH3q9pnjCxU6ZQuqo3YDs/80HBhks4KH/Q2lgkbi6AYNUPyaMggfyCMyaE2/4e
 JHOgmNLGjclUbyBuVMDNs8Djfo1l5BY=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
 s=susede2_ed25519; t=1709212757;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=yNNAnUc9QV5fumPC0hfBb9cb3IkOcIBHsZlH6T7uArs=;
 b=qYlKWLjU0GfcdVg9/Mv/iMIpSJdHdrbNpBbyq9hx94V/Kce0ANWPK1aFef1SiQA/Snt8tF
 M5n6kSPoq9QkbEAA==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
 t=1709212755; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=yNNAnUc9QV5fumPC0hfBb9cb3IkOcIBHsZlH6T7uArs=;
 b=cHmQPd2wHnaYQOBtkXDfbg9BJcJe0D7NRz7b76a9QvtNsVZypbiZhof9oo2PC6GfhY4xwO
 bnLTbw11f5oojfmgk5XC0sq61jdIihImjUfXIhsgFk1W7cegKEt/OlBaSEmbTdf+PH8FFW
 +NtH0cgS09MelWVTsHwjKQRppUKSZms=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
 s=susede2_ed25519; t=1709212755;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=yNNAnUc9QV5fumPC0hfBb9cb3IkOcIBHsZlH6T7uArs=;
 b=gPt/KXOOJ5UhlOkgAsOXXPmYY4R4dxgkZO6+4CWpzL54bGo4XeG4nExwfBgTQNUWdDukX5
 aozfEthfWGiyudBw==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 8669D13A4B;
 Thu, 29 Feb 2024 13:19:14 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
 by imap1.dmz-prg2.suse.org with ESMTPSA id KzsjE1KE4GUtEAAAD6G6ig
 (envelope-from <farosas@suse.de>); Thu, 29 Feb 2024 13:19:14 +0000
From: Fabiano Rosas <farosas@suse.de>
To: Peter Xu <peterx@redhat.com>
Cc: qemu-devel@nongnu.org, berrange@redhat.com, armbru@redhat.com, Claudio
 Fontana <cfontana@suse.de>
Subject: Re: [PATCH v5 19/23] migration/multifd: Prepare multifd sync for
 mapped-ram migration
In-Reply-To: <Zd_28lPa5Uq9Kaw2@x1n>
References: <20240228152127.18769-1-farosas@suse.de>
 <20240228152127.18769-20-farosas@suse.de> <Zd_28lPa5Uq9Kaw2@x1n>
Date: Thu, 29 Feb 2024 10:19:12 -0300
Message-ID: <87plwfz9v3.fsf@suse.de>
MIME-Version: 1.0
Content-Type: text/plain
Authentication-Results: smtp-out1.suse.de;
	none
X-Spamd-Result: default: False [-3.10 / 50.00]; ARC_NA(0.00)[];
 RCVD_VIA_SMTP_AUTH(0.00)[]; BAYES_HAM(-3.00)[100.00%];
 FROM_HAS_DN(0.00)[]; TO_DN_SOME(0.00)[];
 TO_MATCH_ENVRCPT_ALL(0.00)[]; MIME_GOOD(-0.10)[text/plain];
 RCPT_COUNT_FIVE(0.00)[5]; RCVD_COUNT_THREE(0.00)[3];
 DKIM_SIGNED(0.00)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
 DBL_BLOCKED_OPENRESOLVER(0.00)[suse.de:email];
 FUZZY_BLOCKED(0.00)[rspamd.com]; FROM_EQ_ENVFROM(0.00)[];
 MIME_TRACE(0.00)[0:+]; RCVD_TLS_ALL(0.00)[];
 MID_RHS_MATCH_FROM(0.00)[]
Received-SPF: pass client-ip=195.135.223.130; envelope-from=farosas@suse.de;
 helo=smtp-out1.suse.de
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

> On Wed, Feb 28, 2024 at 12:21:23PM -0300, Fabiano Rosas wrote:
>> The mapped-ram migration can be performed live or non-live, but it is
>> always asynchronous, i.e. the source machine and the destination
>> machine are not migrating at the same time. We only need some pieces
>> of the multifd sync operations.
>> 
>> multifd_send_sync_main()
>> ------------------------
>>   Issued by the ram migration code on the migration thread, causes the
>>   multifd send channels to synchronize with the migration thread and
>>   makes the sending side emit a packet with the MULTIFD_FLUSH flag.
>> 
>>   With mapped-ram we want to maintain the sync on the sending side
>>   because that provides ordering between the rounds of dirty pages when
>>   migrating live.
>
> IIUC as I used to comment, we should probably only need that sync after
> each full iteration, which is find_dirty_block().
>
> I think keeping the setup/complete sync is fine, and that can be discussed
> separately.  However IMHO we should still avoid the sync in
> ram_save_iterate() always, or on new qemu + old machine types (where
> flush_after_each_section=true) fixed-ram could suffer perf issues, IIUC.
>
> So I assume at a minimum below would still be preferred?
>
> @@ -3257,7 +3257,8 @@ static int ram_save_iterate(QEMUFile *f, void *opaque)
>  out:
>      if (ret >= 0
>          && migration_is_setup_or_active(migrate_get_current()->state)) {
> -        if (migrate_multifd() && migrate_multifd_flush_after_each_section()) {
> +        if (migrate_multifd() && migrate_multifd_flush_after_each_section() &&
> +            !migrate_mapped_ram()) {
>              ret = multifd_send_sync_main();
>              if (ret < 0) {
>                  return ret;
>

I think I forgot this. I'll amend it.

>> 
>> MULTIFD_FLUSH
>> -------------
>>   On the receiving side, the presence of the MULTIFD_FLUSH flag on a
>>   packet causes the receiving channels to start synchronizing with the
>>   main thread.
>> 
>>   We're not using packets with mapped-ram, so there's no MULTIFD_FLUSH
>>   flag and therefore no channel sync on the receiving side.
>> 
>> multifd_recv_sync_main()
>> ------------------------
>>   Issued by the migration thread when the ram migration flag
>>   RAM_SAVE_FLAG_MULTIFD_FLUSH is received, causes the migration thread
>>   on the receiving side to start synchronizing with the recv
>>   channels. Due to compatibility, this is also issued when
>>   RAM_SAVE_FLAG_EOS is received.
>> 
>>   For mapped-ram we only need to synchronize the channels at the end of
>>   migration to avoid doing cleanup before the channels have finished
>>   their IO.
>
> Did you forget to add the sync at parse_ramblocks() for mapped-ram?
>

Ugh, I messed it up. I'll fix it.

>> 
>> Make sure the multifd syncs are only issued at the appropriate times.
>> 
>> Note that due to pre-existing backward compatibility issues, we have
>> the multifd_flush_after_each_section property that can cause a sync to
>> happen at EOS. Since the EOS flag is needed on the stream, allow
>> mapped-ram to just ignore it.
>
> Skipping EOS makes sense, but I suggest do that without invalid_flags.  See
> below.
>
>> 
>> Also emit an error if any other unexpected flags are found on the
>> stream.
>> 
>> Signed-off-by: Fabiano Rosas <farosas@suse.de>
>> ---
>> - skipped all FLUSH flags
>> - added invalid flags
>> - skipped EOS
>> ---
>>  migration/ram.c | 26 ++++++++++++++++++++++----
>>  1 file changed, 22 insertions(+), 4 deletions(-)
>> 
>> diff --git a/migration/ram.c b/migration/ram.c
>> index 18620784c6..250dcd110c 100644
>> --- a/migration/ram.c
>> +++ b/migration/ram.c
>> @@ -1368,8 +1368,11 @@ static int find_dirty_block(RAMState *rs, PageSearchStatus *pss)
>>                  if (ret < 0) {
>>                      return ret;
>>                  }
>> -                qemu_put_be64(f, RAM_SAVE_FLAG_MULTIFD_FLUSH);
>> -                qemu_fflush(f);
>> +
>> +                if (!migrate_mapped_ram()) {
>> +                    qemu_put_be64(f, RAM_SAVE_FLAG_MULTIFD_FLUSH);
>> +                    qemu_fflush(f);
>> +                }
>>              }
>>              /*
>>               * If memory migration starts over, we will meet a dirtied page
>> @@ -3111,7 +3114,8 @@ static int ram_save_setup(QEMUFile *f, void *opaque)
>>          return ret;
>>      }
>>  
>> -    if (migrate_multifd() && !migrate_multifd_flush_after_each_section()) {
>> +    if (migrate_multifd() && !migrate_multifd_flush_after_each_section()
>> +        && !migrate_mapped_ram()) {
>>          qemu_put_be64(f, RAM_SAVE_FLAG_MULTIFD_FLUSH);
>>      }
>>  
>> @@ -3334,7 +3338,8 @@ static int ram_save_complete(QEMUFile *f, void *opaque)
>>          }
>>      }
>>  
>> -    if (migrate_multifd() && !migrate_multifd_flush_after_each_section()) {
>> +    if (migrate_multifd() && !migrate_multifd_flush_after_each_section() &&
>> +        !migrate_mapped_ram()) {
>>          qemu_put_be64(f, RAM_SAVE_FLAG_MULTIFD_FLUSH);
>>      }
>>      qemu_put_be64(f, RAM_SAVE_FLAG_EOS);
>> @@ -4137,6 +4142,12 @@ static int ram_load_precopy(QEMUFile *f)
>>          invalid_flags |= RAM_SAVE_FLAG_COMPRESS_PAGE;
>>      }
>>  
>> +    if (migrate_mapped_ram()) {
>> +        invalid_flags |= (RAM_SAVE_FLAG_EOS | RAM_SAVE_FLAG_HOOK |
>> +                          RAM_SAVE_FLAG_MULTIFD_FLUSH | RAM_SAVE_FLAG_PAGE |
>> +                          RAM_SAVE_FLAG_XBZRLE | RAM_SAVE_FLAG_ZERO);
>
> IMHO EOS cannot be accounted as "invalid" here because it always exists.
> Rather than this trick (then explicitly ignore it below... which is even
> hackier, IMHO), we can avoid setting EOS in invalid_flags, but explicitly
> ignore EOS in below code to bypass it for mapped-ram:
>
> @@ -4301,7 +4302,12 @@ static int ram_load_precopy(QEMUFile *f)
>          case RAM_SAVE_FLAG_EOS:
>              /* normal exit */
>              if (migrate_multifd() &&
> -                migrate_multifd_flush_after_each_section()) {
> +                migrate_multifd_flush_after_each_section() &&
> +                /*
> +                 * Mapped-ram migration flushes once and for all after
> +                 * parsing ramblocks.  Always ignore EOS for it.
> +                 */
> +                !migrate_mapped_ram()) {
>                  multifd_recv_sync_main();
>              }
>              break;

I thought we were already spraying too many migrate_mapped_ram() checks
all over the code. But wat you said makes sense, I'll change it.

>> +    }
>> +
>>      while (!ret && !(flags & RAM_SAVE_FLAG_EOS)) {
>>          ram_addr_t addr;
>>          void *host = NULL, *host_bak = NULL;
>> @@ -4158,6 +4169,13 @@ static int ram_load_precopy(QEMUFile *f)
>>          addr &= TARGET_PAGE_MASK;
>>  
>>          if (flags & invalid_flags) {
>> +            if (invalid_flags & RAM_SAVE_FLAG_EOS) {
>> +                /* EOS is always present, just ignore it */
>> +                continue;
>> +            }
>> +
>> +            error_report("Unexpected RAM flags: %d", flags & invalid_flags);
>> +
>>              if (flags & invalid_flags & RAM_SAVE_FLAG_COMPRESS_PAGE) {
>>                  error_report("Received an unexpected compressed page");
>>              }
>> -- 
>> 2.35.3
>> 

