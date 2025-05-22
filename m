Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C79D1C54ED0
	for <qemu-devel@archiver.kernel.org>; Thu, 22 May 2025 16:40:27 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uI8wz-00071n-2i; Thu, 22 May 2025 12:39:21 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <farosas@suse.de>) id 1uI8wx-00071R-Fr
 for qemu-devel@nongnu.org; Thu, 22 May 2025 12:39:19 -0400
Received: from smtp-out1.suse.de ([195.135.223.130])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <farosas@suse.de>) id 1uI8wv-0004UY-GT
 for qemu-devel@nongnu.org; Thu, 22 May 2025 12:39:19 -0400
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org
 [IPv6:2a07:de40:b281:104:10:150:64:97])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by smtp-out1.suse.de (Postfix) with ESMTPS id 4D90E21A54;
 Thu, 22 May 2025 16:39:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
 t=1747931954; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=gUXh3sHeH+QWe34SFKyrhLNN2nugjFBHJu/Uk9kFCEk=;
 b=emLLRgLBAJ2NobOE3uiFTmenwyFVjP/5l6eLlxoPYQvOU55Vb+/dVxisEgrkr2skxZnUyh
 DHNDVovqlQXGF7CD31FiC6DypeRzN/+3wlxDybCBX9v1rf4nD+rUG+n0mwYtiIndrYg5ml
 vjHx+tpNiRc/3ZDNrNZFgJ6PeIWRJwM=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
 s=susede2_ed25519; t=1747931954;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=gUXh3sHeH+QWe34SFKyrhLNN2nugjFBHJu/Uk9kFCEk=;
 b=kB+3Mccy1t7KDniNKFpEhDt8DNjVcAvbq0U6iBc3xfanDbTibWL7ni/Xfc2xOJaEJLLbl3
 qNfSQgtrZcUPmwAg==
Authentication-Results: smtp-out1.suse.de;
 dkim=pass header.d=suse.de header.s=susede2_rsa header.b=emLLRgLB;
 dkim=pass header.d=suse.de header.s=susede2_ed25519 header.b=kB+3Mccy
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
 t=1747931954; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=gUXh3sHeH+QWe34SFKyrhLNN2nugjFBHJu/Uk9kFCEk=;
 b=emLLRgLBAJ2NobOE3uiFTmenwyFVjP/5l6eLlxoPYQvOU55Vb+/dVxisEgrkr2skxZnUyh
 DHNDVovqlQXGF7CD31FiC6DypeRzN/+3wlxDybCBX9v1rf4nD+rUG+n0mwYtiIndrYg5ml
 vjHx+tpNiRc/3ZDNrNZFgJ6PeIWRJwM=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
 s=susede2_ed25519; t=1747931954;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=gUXh3sHeH+QWe34SFKyrhLNN2nugjFBHJu/Uk9kFCEk=;
 b=kB+3Mccy1t7KDniNKFpEhDt8DNjVcAvbq0U6iBc3xfanDbTibWL7ni/Xfc2xOJaEJLLbl3
 qNfSQgtrZcUPmwAg==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id B79DE137B8;
 Thu, 22 May 2025 16:39:13 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
 by imap1.dmz-prg2.suse.org with ESMTPSA id 80c2HTFTL2iOOwAAD6G6ig
 (envelope-from <farosas@suse.de>); Thu, 22 May 2025 16:39:13 +0000
From: Fabiano Rosas <farosas@suse.de>
To: Peter Xu <peterx@redhat.com>
Cc: qemu-devel@nongnu.org, Markus Armbruster <armbru@redhat.com>,
 =?utf-8?Q?Daniel_P_=2E_Berrang=C3=A9?= <berrange@redhat.com>
Subject: Re: [RFC PATCH 04/13] migration: Fix parameter validation
In-Reply-To: <aCZVolkNMBZb5KvC@x1.local>
References: <20250411191443.22565-1-farosas@suse.de>
 <20250411191443.22565-5-farosas@suse.de> <aCZVolkNMBZb5KvC@x1.local>
Date: Thu, 22 May 2025 13:39:10 -0300
Message-ID: <87r00g61n5.fsf@suse.de>
MIME-Version: 1.0
Content-Type: text/plain
X-Rspamd-Action: no action
X-Rspamd-Queue-Id: 4D90E21A54
X-Rspamd-Server: rspamd2.dmz-prg2.suse.org
X-Spamd-Result: default: False [-1.51 / 50.00]; NEURAL_HAM_LONG(-1.00)[-1.000];
 R_DKIM_ALLOW(-0.20)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
 NEURAL_HAM_SHORT(-0.20)[-0.999]; MIME_GOOD(-0.10)[text/plain];
 MX_GOOD(-0.01)[]; RCVD_VIA_SMTP_AUTH(0.00)[]; ARC_NA(0.00)[];
 RCVD_TLS_ALL(0.00)[]; MISSING_XM_UA(0.00)[];
 MIME_TRACE(0.00)[0:+];
 RBL_SPAMHAUS_BLOCKED_OPENRESOLVER(0.00)[2a07:de40:b281:104:10:150:64:97:from]; 
 SPAMHAUS_XBL(0.00)[2a07:de40:b281:104:10:150:64:97:from];
 TO_DN_SOME(0.00)[];
 RECEIVED_SPAMHAUS_BLOCKED_OPENRESOLVER(0.00)[2a07:de40:b281:106:10:150:64:167:received];
 FUZZY_BLOCKED(0.00)[rspamd.com]; RCPT_COUNT_THREE(0.00)[4];
 FROM_EQ_ENVFROM(0.00)[]; FROM_HAS_DN(0.00)[];
 MID_RHS_MATCH_FROM(0.00)[]; RCVD_COUNT_TWO(0.00)[2];
 TO_MATCH_ENVRCPT_ALL(0.00)[];
 DBL_BLOCKED_OPENRESOLVER(0.00)[suse.de:email,suse.de:mid,suse.de:dkim,imap1.dmz-prg2.suse.org:rdns,imap1.dmz-prg2.suse.org:helo];
 DKIM_SIGNED(0.00)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
 DKIM_TRACE(0.00)[suse.de:+]
Received-SPF: pass client-ip=195.135.223.130; envelope-from=farosas@suse.de;
 helo=smtp-out1.suse.de
X-Spam_score_int: -43
X-Spam_score: -4.4
X-Spam_bar: ----
X-Spam_report: (-4.4 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_MED=-2.3, RCVD_IN_VALIDITY_CERTIFIED_BLOCKED=0.001,
 RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001, SPF_HELO_NONE=0.001,
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

> On Fri, Apr 11, 2025 at 04:14:34PM -0300, Fabiano Rosas wrote:
>> The migration parameters validation involves producing a temporary
>> structure which merges the current parameter values with the new
>> parameters set by the user.
>> 
>> The has_ boolean fields of MigrateSetParameter are taken into
>> consideration when writing the temporary structure, however the copy
>> of the current parameters also copies all the has_ fields of
>> s->parameters and those are (almost) all true due to being initialized
>> by migrate_params_init().
>> 
>> Since the temporary structure copy does not carry over the has_ fields
>> from MigrateSetParameters, only the values which were initialized in
>> migrate_params_init() will end up being validated. This causes
>> (almost) all of the migration parameters to be validated again every
>> time a parameter is set, which could be considered a bug. But it also
>> skips validation of those values which are not set in
>> migrate_params_init(), which is a worse issue.
>
> IMHO it's ok to double check all parameters in slow path.  Definitely not
> ok to skip them.. So now the question is, if migrate_params_test_apply() so
> far should check all params anyway...
>

Well, either way is fine by me. In the current code, I can't tell what
the intention was, unfortunately.

We could check all params, but then we need to make sure they never
change in between calls to migrate-set-params. Looking at the code I
don't see any place where we allow s->parameters to change.

But then I worry about checks that:
- might be too costly
- only make sense the first time
- depend on the order of setting (a param/cap that should only be set
before/after some other param/cap)

> Shall we drop the checking for all has_ there, then IIUC we also don't need
> any initializations for has_* in migrate_params_init() here?
>

It'd be nice to not have to touch the has_ fields, yes. I'll experiment
with it.

> So, admittedly s->parameters.has_* is still ugly to be present.. we declare
> all of them not used and ignore them always at least in s->parameters.
>
>> 
>> Fix by initializing the missing values in migrate_params_init().
>> Currently 'avail_switchover_bandwidth' and 'block_bitmap_mapping' are
>> affected.
>> 
>> Signed-off-by: Fabiano Rosas <farosas@suse.de>
>> ---
>>  migration/options.c | 2 ++
>>  1 file changed, 2 insertions(+)
>> 
>> diff --git a/migration/options.c b/migration/options.c
>> index cac28540dd..625d597a85 100644
>> --- a/migration/options.c
>> +++ b/migration/options.c
>> @@ -987,6 +987,8 @@ void migrate_params_init(MigrationParameters *params)
>>      params->has_mode = true;
>>      params->has_zero_page_detection = true;
>>      params->has_direct_io = true;
>> +    params->has_avail_switchover_bandwidth = true;
>> +    params->has_block_bitmap_mapping = true;
>>  }
>>  
>>  /*
>> -- 
>> 2.35.3
>> 

