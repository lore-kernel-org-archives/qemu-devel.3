Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C7AB0C77B7C
	for <qemu-devel@archiver.kernel.org>; Wed, 25 Jun 2025 17:29:52 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uUTvw-000193-KW; Wed, 25 Jun 2025 13:29:17 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <farosas@suse.de>) id 1uUTvo-00018F-Nm
 for qemu-devel@nongnu.org; Wed, 25 Jun 2025 13:29:10 -0400
Received: from smtp-out2.suse.de ([2a07:de40:b251:101:10:150:64:2])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <farosas@suse.de>) id 1uUTvm-0000CL-Sn
 for qemu-devel@nongnu.org; Wed, 25 Jun 2025 13:29:08 -0400
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org
 [IPv6:2a07:de40:b281:104:10:150:64:97])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by smtp-out2.suse.de (Postfix) with ESMTPS id 978C51F745;
 Wed, 25 Jun 2025 17:29:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
 t=1750872544; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=gugLRHQ5Ud8x3nalDvqiaJogJYCpCP7RxetiKXL6CZA=;
 b=s34J7hIuN2FnPD04FOCZ+dW2uaKszDcE6uzgoDJxqg4QTzsrjAkjxVOqazs27nQLWwzc1q
 VYBl7p/E9C8Rvi/cZeN7msFN7tHrhkQp4i92z0pX+enoe4Pc4rGD7lR++7vMw8I0M09HDJ
 TIRyFl7VDsCCJbkh6T6m9jmRn9NMcrM=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
 s=susede2_ed25519; t=1750872544;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=gugLRHQ5Ud8x3nalDvqiaJogJYCpCP7RxetiKXL6CZA=;
 b=FY1EfEpHbq8v5Jvd/tgW4ElTjRxGHzzrrA0kLXmwNsg1dM61vMv3LOsNSHKzEGQUMuBK0G
 EF0joFYvno8k0xCQ==
Authentication-Results: smtp-out2.suse.de;
 dkim=pass header.d=suse.de header.s=susede2_rsa header.b=s34J7hIu;
 dkim=pass header.d=suse.de header.s=susede2_ed25519 header.b=FY1EfEpH
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
 t=1750872544; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=gugLRHQ5Ud8x3nalDvqiaJogJYCpCP7RxetiKXL6CZA=;
 b=s34J7hIuN2FnPD04FOCZ+dW2uaKszDcE6uzgoDJxqg4QTzsrjAkjxVOqazs27nQLWwzc1q
 VYBl7p/E9C8Rvi/cZeN7msFN7tHrhkQp4i92z0pX+enoe4Pc4rGD7lR++7vMw8I0M09HDJ
 TIRyFl7VDsCCJbkh6T6m9jmRn9NMcrM=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
 s=susede2_ed25519; t=1750872544;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=gugLRHQ5Ud8x3nalDvqiaJogJYCpCP7RxetiKXL6CZA=;
 b=FY1EfEpHbq8v5Jvd/tgW4ElTjRxGHzzrrA0kLXmwNsg1dM61vMv3LOsNSHKzEGQUMuBK0G
 EF0joFYvno8k0xCQ==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 16B6B13485;
 Wed, 25 Jun 2025 17:29:03 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
 by imap1.dmz-prg2.suse.org with ESMTPSA id /2rXMt8xXGgWSwAAD6G6ig
 (envelope-from <farosas@suse.de>); Wed, 25 Jun 2025 17:29:03 +0000
From: Fabiano Rosas <farosas@suse.de>
To: Markus Armbruster <armbru@redhat.com>
Cc: qemu-devel@nongnu.org, Peter Xu <peterx@redhat.com>, =?utf-8?Q?Daniel?=
 =?utf-8?Q?_P_=2E_Berrang=C3=A9?= <berrange@redhat.com>
Subject: Re: [PATCH 03/21] qapi/migration: Don't document MigrationParameter
In-Reply-To: <874iw457un.fsf@pond.sub.org>
References: <20250603013810.4772-1-farosas@suse.de>
 <20250603013810.4772-4-farosas@suse.de> <87ikkk58p4.fsf@pond.sub.org>
 <874iw457un.fsf@pond.sub.org>
Date: Wed, 25 Jun 2025 14:29:01 -0300
Message-ID: <8734bn7msi.fsf@suse.de>
MIME-Version: 1.0
Content-Type: text/plain
X-Spamd-Result: default: False [-4.51 / 50.00]; BAYES_HAM(-3.00)[99.99%];
 NEURAL_HAM_LONG(-1.00)[-1.000];
 R_DKIM_ALLOW(-0.20)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
 NEURAL_HAM_SHORT(-0.20)[-1.000]; MIME_GOOD(-0.10)[text/plain];
 MX_GOOD(-0.01)[]; FUZZY_BLOCKED(0.00)[rspamd.com];
 RCVD_VIA_SMTP_AUTH(0.00)[]; ARC_NA(0.00)[];
 MIME_TRACE(0.00)[0:+]; MISSING_XM_UA(0.00)[];
 TO_DN_SOME(0.00)[]; MID_RHS_MATCH_FROM(0.00)[];
 RCVD_TLS_ALL(0.00)[];
 DKIM_SIGNED(0.00)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
 FROM_EQ_ENVFROM(0.00)[]; FROM_HAS_DN(0.00)[];
 RCPT_COUNT_THREE(0.00)[4]; RCVD_COUNT_TWO(0.00)[2];
 TO_MATCH_ENVRCPT_ALL(0.00)[];
 DBL_BLOCKED_OPENRESOLVER(0.00)[suse.de:dkim,suse.de:mid,suse.de:email];
 DNSWL_BLOCKED(0.00)[2a07:de40:b281:104:10:150:64:97:from,2a07:de40:b281:106:10:150:64:167:received];
 DKIM_TRACE(0.00)[suse.de:+]
X-Rspamd-Queue-Id: 978C51F745
X-Rspamd-Action: no action
X-Rspamd-Server: rspamd1.dmz-prg2.suse.org
Received-SPF: pass client-ip=2a07:de40:b251:101:10:150:64:2;
 envelope-from=farosas@suse.de; helo=smtp-out2.suse.de
X-Spam_score_int: -43
X-Spam_score: -4.4
X-Spam_bar: ----
X-Spam_report: (-4.4 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_MED=-2.3, SPF_HELO_NONE=0.001,
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

Markus Armbruster <armbru@redhat.com> writes:

> Markus Armbruster <armbru@redhat.com> writes:
>
>> Fabiano Rosas <farosas@suse.de> writes:
>>
>>> The MigrationParameter (singular) enumeration is not part of the
>>> migration QMP API, it's only used for nicely converting HMP strings
>>> into MigrationParameters (plural) members and for providing readline
>>> completion.
>>
>>
>>
>>> Documenting this enum only serves to duplicate documentation between
>>> MigrationParameter and MigrationParameters.
>>>
>>> Add an exception to QAPIs pragma.json and stop documenting it.
>>>
>>> Signed-off-by: Fabiano Rosas <farosas@suse.de>
>>> ---
>>>  qapi/migration.json | 152 +-------------------------------------------
>>>  qapi/pragma.json    |   3 +-
>>>  2 files changed, 3 insertions(+), 152 deletions(-)
>>>
>>> diff --git a/qapi/migration.json b/qapi/migration.json
>>> index 080968993a..452e6dedaa 100644
>>> --- a/qapi/migration.json
>>> +++ b/qapi/migration.json
>>> @@ -734,157 +734,7 @@
>>>  ##
>>>  # @MigrationParameter:
>>>  #
>>> -# Migration parameters enumeration
>>> -#
>>> -# @announce-initial: Initial delay (in milliseconds) before sending
>>> -#     the first announce (Since 4.0)
>>
>> [...]
>>
>>> -# @direct-io: Open migration files with O_DIRECT when possible.  This
>>> -#     only has effect if the @mapped-ram capability is enabled.
>>> -#     (Since 9.1)
>>> +# Migration parameters enumeration. See @MigrationParameters for more info.
>>
>> Suggest something like
>>
>>    # The enumeration values mirror the members of MigrationParameters,
>>    # which see.
>>
>> I could compare the deleted docs with MigrationParameters docs, but I
>> doubt it's worthwhile: the type is only ever used internally.  That it
>> appears in the QEMU QMP Reference Manual anyway is a defect.  There are
>> quite a few more like it (list appended).
>>
>> If I remember correctly, John Snow's doc generator work will fix this
>> defect.
>
> Until then, this patch has a drawback: the manual now shows all the
> members as "Not documented" .  Ugly and a bit embarrassing.  Maybe even
> confusing.
>

I expect the part about checking @MigrationParameters to be clear enough
in explaining why the members are "Not documented".

I could live with the enum being documented still, but there's always
churn when people touch migration.json and get something wrong due to
the duplication. I'd rather not have it.

