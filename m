Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E4FDEC48BF6
	for <qemu-devel@archiver.kernel.org>; Wed, 21 Feb 2024 15:32:16 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rcoXa-00042P-Pw; Wed, 21 Feb 2024 10:29:46 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <farosas@suse.de>) id 1rcoNL-0003Rf-D9
 for qemu-devel@nongnu.org; Wed, 21 Feb 2024 10:19:11 -0500
Received: from smtp-out1.suse.de ([195.135.223.130])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <farosas@suse.de>) id 1rcma2-0007N3-S0
 for qemu-devel@nongnu.org; Wed, 21 Feb 2024 08:24:13 -0500
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org
 [IPv6:2a07:de40:b281:104:10:150:64:97])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by smtp-out1.suse.de (Postfix) with ESMTPS id 2AB4221EF9;
 Wed, 21 Feb 2024 13:24:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
 t=1708521849; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=dUthbAJxyMk41bKipdxC3j5UI5ZZ7T3/a9qsLwI/CEk=;
 b=DTQn1wBW1fvNWR3UiKaONQLGKtuolP5HKhYPsejvggxKbw+rvnX6x/iae/dRwYrp+CZROV
 TpiIRQumnOso5f2TFRiZf93ReQlkleQalxgBrylw4CoWlZ/xJNf4ixXjwRa5DYeyZOeTX/
 H5lYPfScEnchE9AkRcI7P2dRroqbCKA=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
 s=susede2_ed25519; t=1708521849;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=dUthbAJxyMk41bKipdxC3j5UI5ZZ7T3/a9qsLwI/CEk=;
 b=d+4nAevdb5oCoNdn9stsNzmMFyyxKCYlQf++hymyRj/GoK3bOMg94GHn/71QJVQyysXDP2
 PGvA0PQe4vqLGBCw==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
 t=1708521849; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=dUthbAJxyMk41bKipdxC3j5UI5ZZ7T3/a9qsLwI/CEk=;
 b=DTQn1wBW1fvNWR3UiKaONQLGKtuolP5HKhYPsejvggxKbw+rvnX6x/iae/dRwYrp+CZROV
 TpiIRQumnOso5f2TFRiZf93ReQlkleQalxgBrylw4CoWlZ/xJNf4ixXjwRa5DYeyZOeTX/
 H5lYPfScEnchE9AkRcI7P2dRroqbCKA=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
 s=susede2_ed25519; t=1708521849;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=dUthbAJxyMk41bKipdxC3j5UI5ZZ7T3/a9qsLwI/CEk=;
 b=d+4nAevdb5oCoNdn9stsNzmMFyyxKCYlQf++hymyRj/GoK3bOMg94GHn/71QJVQyysXDP2
 PGvA0PQe4vqLGBCw==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 9E3C1139D0;
 Wed, 21 Feb 2024 13:24:08 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
 by imap1.dmz-prg2.suse.org with ESMTPSA id AzYWGXj51WWrcgAAD6G6ig
 (envelope-from <farosas@suse.de>); Wed, 21 Feb 2024 13:24:08 +0000
From: Fabiano Rosas <farosas@suse.de>
To: Markus Armbruster <armbru@redhat.com>
Cc: qemu-devel@nongnu.org, berrange@redhat.com, Peter Xu
 <peterx@redhat.com>, Claudio Fontana <cfontana@suse.de>, Eric Blake
 <eblake@redhat.com>
Subject: Re: [PATCH v4 11/34] migration/ram: Introduce 'fixed-ram' migration
 capability
In-Reply-To: <87o7caxl97.fsf@pond.sub.org>
References: <20240220224138.24759-1-farosas@suse.de>
 <20240220224138.24759-12-farosas@suse.de> <87o7caxl97.fsf@pond.sub.org>
Date: Wed, 21 Feb 2024 10:24:05 -0300
Message-ID: <87sf1mar2i.fsf@suse.de>
MIME-Version: 1.0
Content-Type: text/plain
Authentication-Results: smtp-out1.suse.de;
 dkim=pass header.d=suse.de header.s=susede2_rsa header.b=DTQn1wBW;
 dkim=pass header.d=suse.de header.s=susede2_ed25519 header.b=d+4nAevd
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
X-Rspamd-Queue-Id: 2AB4221EF9
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

Markus Armbruster <armbru@redhat.com> writes:

> Fabiano Rosas <farosas@suse.de> writes:
>
>> Add a new migration capability 'fixed-ram'.
>>
>> The core of the feature is to ensure that each RAM page has a specific
>> offset in the resulting migration stream. The reasons why we'd want
>> such behavior are:
>>
>>  - The resulting file will have a bounded size, since pages which are
>>    dirtied multiple times will always go to a fixed location in the
>>    file, rather than constantly being added to a sequential
>>    stream. This eliminates cases where a VM with, say, 1G of RAM can
>>    result in a migration file that's 10s of GBs, provided that the
>>    workload constantly redirties memory.
>>
>>  - It paves the way to implement O_DIRECT-enabled save/restore of the
>>    migration stream as the pages are ensured to be written at aligned
>>    offsets.
>>
>>  - It allows the usage of multifd so we can write RAM pages to the
>>    migration file in parallel.
>>
>> For now, enabling the capability has no effect. The next couple of
>> patches implement the core functionality.
>>
>> Signed-off-by: Fabiano Rosas <farosas@suse.de>
>
> [...]
>
>> diff --git a/qapi/migration.json b/qapi/migration.json
>> index 5a565d9b8d..3fce5fe53e 100644
>> --- a/qapi/migration.json
>> +++ b/qapi/migration.json
>> @@ -531,6 +531,10 @@
>>  #     and can result in more stable read performance.  Requires KVM
>>  #     with accelerator property "dirty-ring-size" set.  (Since 8.1)
>>  #
>> +# @fixed-ram: Migrate using fixed offsets in the migration file for
>> +#     each RAM page.  Requires a migration URI that supports seeking,
>> +#     such as a file.  (since 9.0)
>> +#
>>  # Features:
>>  #
>>  # @deprecated: Member @block is deprecated.  Use blockdev-mirror with
>> @@ -555,7 +559,7 @@
>>             { 'name': 'x-ignore-shared', 'features': [ 'unstable' ] },
>>             'validate-uuid', 'background-snapshot',
>>             'zero-copy-send', 'postcopy-preempt', 'switchover-ack',
>> -           'dirty-limit'] }
>> +           'dirty-limit', 'fixed-ram'] }
>>  
>>  ##
>>  # @MigrationCapabilityStatus:
>
> Can we find a better name than @fixed-ram?  @fixed-ram-offsets?
> @use-seek?

I have no idea how we came to fixed-ram. The archives don't provide any
clarification. I find it confusing at first glance as well.

A little brainstorming on how fixed-ram is different from exiting
migration:

Fixed-ram:
  uses a file, like the 'file:' migration;

  needs a seeking medium, such as a file;

  migrates ram by placing a page always in the same offset in the
  file, contrary to normal migration which streams the page changes
  continuously;

  ensures a migration file of size bounded to VM RAM size, contrary to
  normal 'file:' migration which creates a file with unbounded size;

  enables multi-threaded RAM migration, even though we only use it when
  multifd is enabled;

  uses scatter-gatter APIs (pwritev, preadv);

So a few options:

(disconsidering use-seek, it might be even more generic/vague)

- fixed-ram-offsets
- non-streaming (or streaming: false)
- ram-scatter-gather (ram-sg)
- parallel-ram (even with the slight inaccuracy that we sometimes do it single-threaded)

Remember we also use this name internally, so I think a broader
"feature" name is better that a super specific one.

Does anyone have a strong preference? Other suggestions?

> Apart from that, QAPI schema
> Acked-by: Markus Armbruster <armbru@redhat.com>

Thanks!

