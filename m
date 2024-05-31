Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5AA19C25B75
	for <qemu-devel@archiver.kernel.org>; Fri, 31 May 2024 15:28:13 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sD4Ab-0007mG-OB; Fri, 31 May 2024 11:27:53 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <farosas@suse.de>) id 1sD4Aa-0007m3-QF
 for qemu-devel@nongnu.org; Fri, 31 May 2024 11:27:52 -0400
Received: from smtp-out2.suse.de ([2a07:de40:b251:101:10:150:64:2])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <farosas@suse.de>) id 1sD4AX-0000Aa-U3
 for qemu-devel@nongnu.org; Fri, 31 May 2024 11:27:52 -0400
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org
 [IPv6:2a07:de40:b281:104:10:150:64:97])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by smtp-out2.suse.de (Postfix) with ESMTPS id B8D931FB82;
 Fri, 31 May 2024 15:27:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
 t=1717169266; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=eEaYomzP3BF9uVdTwa4gQWq6xAjTwA1nfvQhwQvZTZg=;
 b=qrUbBm6YNV/0mm9MfTfE6vL1jojVdMWYnXVlXuupqb4DMVOcFAJIItR0hACCr7sg+HfFjs
 KNAp+uBK4WWZuQHZTGSSX1AA/pXYyRk+NpT/n4a3WmRbCqg86G/w3mCcRc2Nq0wSiXuL3e
 kMNXS3fu/hWOr+Lr+OB4I2+L75TQEv0=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
 s=susede2_ed25519; t=1717169266;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=eEaYomzP3BF9uVdTwa4gQWq6xAjTwA1nfvQhwQvZTZg=;
 b=7tRy2O4+d2DmqQblWlM1jf2N2EidHIxeNy3ywRFSzqv/ZFrPeYJYtzzcLt9mWN/EXlNInP
 if8HHbMi+ArljpCw==
Authentication-Results: smtp-out2.suse.de;
 dkim=pass header.d=suse.de header.s=susede2_rsa header.b=qrUbBm6Y;
 dkim=pass header.d=suse.de header.s=susede2_ed25519 header.b=7tRy2O4+
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
 t=1717169266; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=eEaYomzP3BF9uVdTwa4gQWq6xAjTwA1nfvQhwQvZTZg=;
 b=qrUbBm6YNV/0mm9MfTfE6vL1jojVdMWYnXVlXuupqb4DMVOcFAJIItR0hACCr7sg+HfFjs
 KNAp+uBK4WWZuQHZTGSSX1AA/pXYyRk+NpT/n4a3WmRbCqg86G/w3mCcRc2Nq0wSiXuL3e
 kMNXS3fu/hWOr+Lr+OB4I2+L75TQEv0=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
 s=susede2_ed25519; t=1717169266;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=eEaYomzP3BF9uVdTwa4gQWq6xAjTwA1nfvQhwQvZTZg=;
 b=7tRy2O4+d2DmqQblWlM1jf2N2EidHIxeNy3ywRFSzqv/ZFrPeYJYtzzcLt9mWN/EXlNInP
 if8HHbMi+ArljpCw==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 3E848132C2;
 Fri, 31 May 2024 15:27:46 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
 by imap1.dmz-prg2.suse.org with ESMTPSA id XpQfAXLsWWYeCwAAD6G6ig
 (envelope-from <farosas@suse.de>); Fri, 31 May 2024 15:27:46 +0000
From: Fabiano Rosas <farosas@suse.de>
To: Peter Xu <peterx@redhat.com>
Cc: qemu-devel@nongnu.org, berrange@redhat.com, armbru@redhat.com, Claudio
 Fontana <cfontana@suse.de>, Jim Fehlig <jfehlig@suse.com>
Subject: Re: [PATCH v2 11/18] migration/multifd: Add direct-io support
In-Reply-To: <ZljxGhSFhMFKt584@x1n>
References: <20240523190548.23977-1-farosas@suse.de>
 <20240523190548.23977-12-farosas@suse.de> <ZljxGhSFhMFKt584@x1n>
Date: Fri, 31 May 2024 12:27:43 -0300
Message-ID: <87le3qknm8.fsf@suse.de>
MIME-Version: 1.0
Content-Type: text/plain
X-Rspamd-Action: no action
X-Rspamd-Queue-Id: B8D931FB82
X-Rspamd-Server: rspamd2.dmz-prg2.suse.org
X-Spamd-Result: default: False [-4.51 / 50.00]; BAYES_HAM(-3.00)[100.00%];
 NEURAL_HAM_LONG(-1.00)[-1.000];
 R_DKIM_ALLOW(-0.20)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
 NEURAL_HAM_SHORT(-0.20)[-1.000]; MIME_GOOD(-0.10)[text/plain];
 MX_GOOD(-0.01)[];
 DKIM_SIGNED(0.00)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
 FROM_HAS_DN(0.00)[]; FUZZY_BLOCKED(0.00)[rspamd.com];
 RBL_SPAMHAUS_BLOCKED_OPENRESOLVER(0.00)[2a07:de40:b281:104:10:150:64:97:from]; 
 MIME_TRACE(0.00)[0:+]; ARC_NA(0.00)[];
 SPAMHAUS_XBL(0.00)[2a07:de40:b281:104:10:150:64:97:from];
 TO_DN_SOME(0.00)[]; TO_MATCH_ENVRCPT_ALL(0.00)[];
 RCVD_TLS_ALL(0.00)[]; DKIM_TRACE(0.00)[suse.de:+];
 MID_RHS_MATCH_FROM(0.00)[]; RCVD_COUNT_TWO(0.00)[2];
 FROM_EQ_ENVFROM(0.00)[]; RCPT_COUNT_FIVE(0.00)[6];
 DWL_DNSWL_BLOCKED(0.00)[suse.de:dkim];
 RCVD_VIA_SMTP_AUTH(0.00)[];
 RECEIVED_SPAMHAUS_BLOCKED_OPENRESOLVER(0.00)[2a07:de40:b281:106:10:150:64:167:received];
 MISSING_XM_UA(0.00)[];
 DBL_BLOCKED_OPENRESOLVER(0.00)[suse.de:dkim, suse.de:email,
 imap1.dmz-prg2.suse.org:helo, imap1.dmz-prg2.suse.org:rdns]
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

> On Thu, May 23, 2024 at 04:05:41PM -0300, Fabiano Rosas wrote:
>> When multifd is used along with mapped-ram, we can take benefit of a
>> filesystem that supports the O_DIRECT flag and perform direct I/O in
>> the multifd threads. This brings a significant performance improvement
>> because direct-io writes bypass the page cache which would otherwise
>> be thrashed by the multifd data which is unlikely to be needed again
>> in a short period of time.
>> 
>> To be able to use a multifd channel opened with O_DIRECT, we must
>> ensure that a certain aligment is used. Filesystems usually require a
>> block-size alignment for direct I/O. The way to achieve this is by
>> enabling the mapped-ram feature, which already aligns its I/O properly
>> (see MAPPED_RAM_FILE_OFFSET_ALIGNMENT at ram.c).
>> 
>> By setting O_DIRECT on the multifd channels, all writes to the same
>> file descriptor need to be aligned as well, even the ones that come
>> from outside multifd, such as the QEMUFile I/O from the main migration
>> code. This makes it impossible to use the same file descriptor for the
>> QEMUFile and for the multifd channels. The various flags and metadata
>> written by the main migration code will always be unaligned by virtue
>> of their small size. To workaround this issue, we'll require a second
>> file descriptor to be used exclusively for direct I/O.
>> 
>> The second file descriptor can be obtained by QEMU by re-opening the
>> migration file (already possible), or by being provided by the user or
>> management application (support to be added in future patches).
>> 
>> Signed-off-by: Fabiano Rosas <farosas@suse.de>
>> ---
>>  migration/file.c      | 31 ++++++++++++++++++++++++++-----
>>  migration/file.h      |  1 -
>>  migration/migration.c | 23 +++++++++++++++++++++++
>>  3 files changed, 49 insertions(+), 6 deletions(-)
>> 
>> diff --git a/migration/file.c b/migration/file.c
>> index ba5b5c44ff..ac4d206492 100644
>> --- a/migration/file.c
>> +++ b/migration/file.c
>> @@ -50,12 +50,31 @@ void file_cleanup_outgoing_migration(void)
>>      outgoing_args.fname = NULL;
>>  }
>>  
>> +static void file_enable_direct_io(int *flags)
>> +{
>> +#ifdef O_DIRECT
>> +    if (migrate_direct_io()) {
>> +        *flags |= O_DIRECT;
>> +    }
>> +#else
>> +    /* it should have been rejected when setting the parameter */
>> +    g_assert_not_reached();
>> +#endif
>> +}
>> +
>>  bool file_send_channel_create(gpointer opaque, Error **errp)
>>  {
>>      QIOChannelFile *ioc;
>>      int flags = O_WRONLY;
>>      bool ret = true;
>>  
>> +    /*
>> +     * Attempt to enable O_DIRECT for the secondary channels. These
>> +     * are used for sending ram pages and writes should be guaranteed
>> +     * to be aligned to at least page size.
>> +     */
>> +    file_enable_direct_io(&flags);
>
> Call this only if enabled?  That looks clearer, IMHO:
>
>        if (migrate_direct_io()) {
>            file_enable_direct_io(&flags);
>        }

Sure


