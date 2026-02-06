Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 53327EE2091
	for <qemu-devel@archiver.kernel.org>; Fri,  6 Feb 2026 12:26:00 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1voKuE-0001om-B7; Fri, 06 Feb 2026 07:25:50 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <farosas@suse.de>) id 1voKuC-0001oH-Ln
 for qemu-devel@nongnu.org; Fri, 06 Feb 2026 07:25:48 -0500
Received: from smtp-out2.suse.de ([195.135.223.131])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <farosas@suse.de>) id 1voKuB-0003oQ-06
 for qemu-devel@nongnu.org; Fri, 06 Feb 2026 07:25:48 -0500
Received: from imap1.dmz-prg2.suse.org (unknown [10.150.64.97])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by smtp-out2.suse.de (Postfix) with ESMTPS id 190825BCC5;
 Fri,  6 Feb 2026 12:25:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
 t=1770380745; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=wg/NyXx400BKEapVs6cXFlz+X9qII+JEplISvXvAXGA=;
 b=uJMIOB9cdjELdtVuoYqNfc5elnRqJkxfMShDnu/nmMK1ZoEC723o7giQ+APQw+9MqSlSEw
 wZPgW74o/DEZZJPbWrTAmt8UfaiEar7j2xC2qCfnSjqPBUoG1xn7krnddSHPjkrXlHI33Z
 ExD9tERLwEB1D3j86MCfl+UbfYIhr8g=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
 s=susede2_ed25519; t=1770380745;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=wg/NyXx400BKEapVs6cXFlz+X9qII+JEplISvXvAXGA=;
 b=d+4GBuSiT4yg4Uc3zRqOvdGQlj5Uc65aHfo9Eo5hicvUfWN+HJeI8u/m1avJZW51sMlA91
 EMKvhZBZc1YpwECw==
Authentication-Results: smtp-out2.suse.de;
	none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
 t=1770380745; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=wg/NyXx400BKEapVs6cXFlz+X9qII+JEplISvXvAXGA=;
 b=uJMIOB9cdjELdtVuoYqNfc5elnRqJkxfMShDnu/nmMK1ZoEC723o7giQ+APQw+9MqSlSEw
 wZPgW74o/DEZZJPbWrTAmt8UfaiEar7j2xC2qCfnSjqPBUoG1xn7krnddSHPjkrXlHI33Z
 ExD9tERLwEB1D3j86MCfl+UbfYIhr8g=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
 s=susede2_ed25519; t=1770380745;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=wg/NyXx400BKEapVs6cXFlz+X9qII+JEplISvXvAXGA=;
 b=d+4GBuSiT4yg4Uc3zRqOvdGQlj5Uc65aHfo9Eo5hicvUfWN+HJeI8u/m1avJZW51sMlA91
 EMKvhZBZc1YpwECw==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 836463EA63;
 Fri,  6 Feb 2026 12:25:44 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
 by imap1.dmz-prg2.suse.org with ESMTPSA id HHBCEcjdhWlQIAAAD6G6ig
 (envelope-from <farosas@suse.de>); Fri, 06 Feb 2026 12:25:44 +0000
From: Fabiano Rosas <farosas@suse.de>
To: Peter Xu <peterx@redhat.com>
Cc: qemu-devel@nongnu.org, armbru@redhat.com, ppandit@redhat.com
Subject: Re: [PATCH v2 7/9] migration/options: Open code migrate_params_apply
In-Reply-To: <aYUWOl9_w_m-TIqL@x1.local>
References: <20260202224101.20568-1-farosas@suse.de>
 <20260202224101.20568-8-farosas@suse.de> <aYUWOl9_w_m-TIqL@x1.local>
Date: Fri, 06 Feb 2026 09:25:41 -0300
Message-ID: <87cy2iqcsa.fsf@suse.de>
MIME-Version: 1.0
Content-Type: text/plain
X-Spamd-Result: default: False [-4.30 / 50.00]; BAYES_HAM(-3.00)[100.00%];
 NEURAL_HAM_LONG(-1.00)[-1.000];
 NEURAL_HAM_SHORT(-0.20)[-1.000]; MIME_GOOD(-0.10)[text/plain];
 ARC_NA(0.00)[]; MISSING_XM_UA(0.00)[]; RCVD_TLS_ALL(0.00)[];
 MIME_TRACE(0.00)[0:+]; RCVD_VIA_SMTP_AUTH(0.00)[];
 TO_DN_SOME(0.00)[]; FUZZY_RATELIMITED(0.00)[rspamd.com];
 MID_RHS_MATCH_FROM(0.00)[];
 DKIM_SIGNED(0.00)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
 FROM_HAS_DN(0.00)[]; RCPT_COUNT_THREE(0.00)[4];
 FROM_EQ_ENVFROM(0.00)[]; TO_MATCH_ENVRCPT_ALL(0.00)[];
 RCVD_COUNT_TWO(0.00)[2];
 DBL_BLOCKED_OPENRESOLVER(0.00)[suse.de:mid, suse.de:email,
 imap1.dmz-prg2.suse.org:helo]
Received-SPF: pass client-ip=195.135.223.131; envelope-from=farosas@suse.de;
 helo=smtp-out2.suse.de
X-Spam_score_int: -43
X-Spam_score: -4.4
X-Spam_bar: ----
X-Spam_report: (-4.4 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_MED=-2.3, RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001,
 RCVD_IN_VALIDITY_SAFE_BLOCKED=0.001, SPF_HELO_NONE=0.001,
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

Peter Xu <peterx@redhat.com> writes:

> On Mon, Feb 02, 2026 at 07:40:59PM -0300, Fabiano Rosas wrote:
>> Remove migrate_params_apply so the logic of setting migration
>> parameters is all in one spot.
>> 
>> Suggested-by: Prasad Pandit <ppandit@redhat.com>
>> Signed-off-by: Fabiano Rosas <farosas@suse.de>
>> ---
>>  migration/options.c | 33 ++++++++++++++-------------------
>>  1 file changed, 14 insertions(+), 19 deletions(-)
>> 
>> diff --git a/migration/options.c b/migration/options.c
>> index 180ebed51c..733aae51a8 100644
>> --- a/migration/options.c
>> +++ b/migration/options.c
>> @@ -1266,25 +1266,11 @@ bool migrate_params_check(MigrationParameters *params, Error **errp)
>>      return true;
>>  }
>>  
>> -static void migrate_params_apply(MigrationParameters *params)
>> -{
>> -    MigrationState *s = migrate_get_current();
>> -    MigrationParameters *cur = &s->parameters;
>> -
>> -    migrate_tls_opts_free(cur);
>> -    qapi_free_BitmapMigrationNodeAliasList(cur->block_bitmap_mapping);
>> -    qapi_free_strList(cur->cpr_exec_command);
>> -
>> -    /* mark all present, so they're all copied */
>> -    migrate_mark_all_params_present(params);
>> -    QAPI_CLONE_MEMBERS(MigrationParameters, cur, params);
>> -}
>
> I actually like these smaller functions when their name can represent what
> it does (so I read less but know what it is doing faster)..  But yeah if
> both of you like to drop it, I'm OK.
>

Yeah, I tend to agree with you. It's not a big deal anyway.

I want to eventually add a QMP-specific file to migration/ and move all
of the QMP command handlers in there. Having this all in one function
will be (_very slightly_) simpler to move later on.

> Reviewed-by: Peter Xu <peterx@redhat.com>

