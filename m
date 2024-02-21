Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2DB21C48BEB
	for <qemu-devel@archiver.kernel.org>; Wed, 21 Feb 2024 15:31:47 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rcoXC-0002a0-Jp; Wed, 21 Feb 2024 10:29:22 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <farosas@suse.de>) id 1rcoOr-0003tG-E3
 for qemu-devel@nongnu.org; Wed, 21 Feb 2024 10:20:45 -0500
Received: from smtp-out2.suse.de ([195.135.223.131])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <farosas@suse.de>) id 1rcoA5-0000Y2-Tl
 for qemu-devel@nongnu.org; Wed, 21 Feb 2024 10:05:43 -0500
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org
 [IPv6:2a07:de40:b281:104:10:150:64:97])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by smtp-out2.suse.de (Postfix) with ESMTPS id 4DB671FB64;
 Wed, 21 Feb 2024 15:05:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
 t=1708527926; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=UO66cwYhQTM8HgJbZkXIlmpdZwkIxMkwB8hVceE45s4=;
 b=zknOv/0VEMpB7S5R6KYTdDRHNUbywAz1I6+KBKftKt+hH+k5gMLVzTb72lXCdsO6SbokaX
 0+BDDIE1F4xQx2zw8he69Z3ZuBT590vLNPr9vjCel/LpiyyOA0uaKG9kApLgYpQY41i999
 8P6M8/c9cdDUoOUixFuQ9VaAHyOtRlc=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
 s=susede2_ed25519; t=1708527926;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=UO66cwYhQTM8HgJbZkXIlmpdZwkIxMkwB8hVceE45s4=;
 b=x55v8o9YvId/yYlJsIoA1tVC/z/aPH06E5Kr7QjAmOM2y4p+bHjy/f5YqgrXRw/gjAheQj
 vCpR0cugZ6SpQ9Cg==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
 t=1708527926; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=UO66cwYhQTM8HgJbZkXIlmpdZwkIxMkwB8hVceE45s4=;
 b=zknOv/0VEMpB7S5R6KYTdDRHNUbywAz1I6+KBKftKt+hH+k5gMLVzTb72lXCdsO6SbokaX
 0+BDDIE1F4xQx2zw8he69Z3ZuBT590vLNPr9vjCel/LpiyyOA0uaKG9kApLgYpQY41i999
 8P6M8/c9cdDUoOUixFuQ9VaAHyOtRlc=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
 s=susede2_ed25519; t=1708527926;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=UO66cwYhQTM8HgJbZkXIlmpdZwkIxMkwB8hVceE45s4=;
 b=x55v8o9YvId/yYlJsIoA1tVC/z/aPH06E5Kr7QjAmOM2y4p+bHjy/f5YqgrXRw/gjAheQj
 vCpR0cugZ6SpQ9Cg==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id CC234139D0;
 Wed, 21 Feb 2024 15:05:25 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
 by imap1.dmz-prg2.suse.org with ESMTPSA id ftd+JDUR1mUiDAAAD6G6ig
 (envelope-from <farosas@suse.de>); Wed, 21 Feb 2024 15:05:25 +0000
From: Fabiano Rosas <farosas@suse.de>
To: =?utf-8?Q?Daniel_P=2E_Berrang=C3=A9?= <berrange@redhat.com>
Cc: Markus Armbruster <armbru@redhat.com>, qemu-devel@nongnu.org, Peter Xu
 <peterx@redhat.com>, Claudio Fontana <cfontana@suse.de>, Eric Blake
 <eblake@redhat.com>
Subject: Re: [PATCH v4 11/34] migration/ram: Introduce 'fixed-ram' migration
 capability
In-Reply-To: <ZdX_qV6BfEmresiL@redhat.com>
References: <20240220224138.24759-1-farosas@suse.de>
 <20240220224138.24759-12-farosas@suse.de> <87o7caxl97.fsf@pond.sub.org>
 <87sf1mar2i.fsf@suse.de> <ZdX_qV6BfEmresiL@redhat.com>
Date: Wed, 21 Feb 2024 12:05:23 -0300
Message-ID: <87h6i1c0y4.fsf@suse.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Authentication-Results: smtp-out2.suse.de;
 dkim=pass header.d=suse.de header.s=susede2_rsa header.b="zknOv/0V";
 dkim=pass header.d=suse.de header.s=susede2_ed25519 header.b=x55v8o9Y
X-Spamd-Result: default: False [-3.31 / 50.00]; ARC_NA(0.00)[];
 RCVD_VIA_SMTP_AUTH(0.00)[];
 R_DKIM_ALLOW(-0.20)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
 SPAMHAUS_XBL(0.00)[2a07:de40:b281:104:10:150:64:97:from];
 FROM_HAS_DN(0.00)[]; TO_DN_SOME(0.00)[];
 TO_MATCH_ENVRCPT_ALL(0.00)[]; BAYES_HAM(-3.00)[100.00%];
 MIME_GOOD(-0.10)[text/plain]; RCPT_COUNT_FIVE(0.00)[6];
 RCVD_COUNT_THREE(0.00)[3];
 DKIM_SIGNED(0.00)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
 DKIM_TRACE(0.00)[suse.de:+]; MX_GOOD(-0.01)[];
 DBL_BLOCKED_OPENRESOLVER(0.00)[suse.de:dkim,suse.de:email];
 FUZZY_BLOCKED(0.00)[rspamd.com]; FROM_EQ_ENVFROM(0.00)[];
 MIME_TRACE(0.00)[0:+]; RCVD_TLS_ALL(0.00)[];
 MID_RHS_MATCH_FROM(0.00)[]
X-Rspamd-Server: rspamd1.dmz-prg2.suse.org
X-Rspamd-Queue-Id: 4DB671FB64
Received-SPF: pass client-ip=195.135.223.131; envelope-from=farosas@suse.de;
 helo=smtp-out2.suse.de
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001, T_SCC_BODY_TEXT_LINE=-0.01 autolearn=ham autolearn_force=no
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

Daniel P. Berrang=C3=A9 <berrange@redhat.com> writes:

> On Wed, Feb 21, 2024 at 10:24:05AM -0300, Fabiano Rosas wrote:
>> Markus Armbruster <armbru@redhat.com> writes:
>>=20
>> > Fabiano Rosas <farosas@suse.de> writes:
>> >
>> >> Add a new migration capability 'fixed-ram'.
>> >>
>> >> The core of the feature is to ensure that each RAM page has a specific
>> >> offset in the resulting migration stream. The reasons why we'd want
>> >> such behavior are:
>> >>
>> >>  - The resulting file will have a bounded size, since pages which are
>> >>    dirtied multiple times will always go to a fixed location in the
>> >>    file, rather than constantly being added to a sequential
>> >>    stream. This eliminates cases where a VM with, say, 1G of RAM can
>> >>    result in a migration file that's 10s of GBs, provided that the
>> >>    workload constantly redirties memory.
>> >>
>> >>  - It paves the way to implement O_DIRECT-enabled save/restore of the
>> >>    migration stream as the pages are ensured to be written at aligned
>> >>    offsets.
>> >>
>> >>  - It allows the usage of multifd so we can write RAM pages to the
>> >>    migration file in parallel.
>> >>
>> >> For now, enabling the capability has no effect. The next couple of
>> >> patches implement the core functionality.
>> >>
>> >> Signed-off-by: Fabiano Rosas <farosas@suse.de>
>> >
>> > [...]
>> >
>> >> diff --git a/qapi/migration.json b/qapi/migration.json
>> >> index 5a565d9b8d..3fce5fe53e 100644
>> >> --- a/qapi/migration.json
>> >> +++ b/qapi/migration.json
>> >> @@ -531,6 +531,10 @@
>> >>  #     and can result in more stable read performance.  Requires KVM
>> >>  #     with accelerator property "dirty-ring-size" set.  (Since 8.1)
>> >>  #
>> >> +# @fixed-ram: Migrate using fixed offsets in the migration file for
>> >> +#     each RAM page.  Requires a migration URI that supports seeking,
>> >> +#     such as a file.  (since 9.0)
>> >> +#
>> >>  # Features:
>> >>  #
>> >>  # @deprecated: Member @block is deprecated.  Use blockdev-mirror with
>> >> @@ -555,7 +559,7 @@
>> >>             { 'name': 'x-ignore-shared', 'features': [ 'unstable' ] },
>> >>             'validate-uuid', 'background-snapshot',
>> >>             'zero-copy-send', 'postcopy-preempt', 'switchover-ack',
>> >> -           'dirty-limit'] }
>> >> +           'dirty-limit', 'fixed-ram'] }
>> >>=20=20
>> >>  ##
>> >>  # @MigrationCapabilityStatus:
>> >
>> > Can we find a better name than @fixed-ram?  @fixed-ram-offsets?
>> > @use-seek?
>>=20
>> I have no idea how we came to fixed-ram. The archives don't provide any
>> clarification. I find it confusing at first glance as well.
>>=20
>> A little brainstorming on how fixed-ram is different from exiting
>> migration:
>>=20
>> Fixed-ram:
>>   uses a file, like the 'file:' migration;
>>=20
>>   needs a seeking medium, such as a file;
>>=20
>>   migrates ram by placing a page always in the same offset in the
>>   file, contrary to normal migration which streams the page changes
>>   continuously;
>>=20
>>   ensures a migration file of size bounded to VM RAM size, contrary to
>>   normal 'file:' migration which creates a file with unbounded size;
>>=20
>>   enables multi-threaded RAM migration, even though we only use it when
>>   multifd is enabled;
>>=20
>>   uses scatter-gatter APIs (pwritev, preadv);
>>=20
>> So a few options:
>>=20
>> (disconsidering use-seek, it might be even more generic/vague)
>>=20
>> - fixed-ram-offsets
>> - non-streaming (or streaming: false)
>> - ram-scatter-gather (ram-sg)
>> - parallel-ram (even with the slight inaccuracy that we sometimes do it =
single-threaded)
>
> I could add 'mapped-ram', as an alternative to 'fixed-ram'.
>
> The key distinguishing & motivating feature here is that
> RAM regions are mapped directly to file regions, instead
> of just being streamed at arbitrary points.

"map" is certainly a good shorthand for the various "placed at relative
offsets" that I used throughout this series.

