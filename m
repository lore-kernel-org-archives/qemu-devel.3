Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 49542D19510
	for <qemu-devel@archiver.kernel.org>; Mon, 26 Jan 2026 19:16:37 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vkS4a-00088n-7j; Mon, 26 Jan 2026 14:16:28 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <farosas@suse.de>) id 1vkS4R-000881-5d
 for qemu-devel@nongnu.org; Mon, 26 Jan 2026 14:16:20 -0500
Received: from smtp-out1.suse.de ([2a07:de40:b251:101:10:150:64:1])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <farosas@suse.de>) id 1vkS4P-0000nt-BQ
 for qemu-devel@nongnu.org; Mon, 26 Jan 2026 14:16:18 -0500
Received: from imap1.dmz-prg2.suse.org (unknown [10.150.64.97])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by smtp-out1.suse.de (Postfix) with ESMTPS id 18F263374C;
 Mon, 26 Jan 2026 19:16:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
 t=1769454975; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=317mv1rgkjcrHO4IMO/JOlf+/Qy6TF/sjiqQxZGWVEQ=;
 b=ZHpeslcLZIbEf7RqNtHJ/U6U3IJG57Ji6BjecrS3fW2MtvmUYj5IHC82tl3sgrHD8JcGuZ
 UlmLjFy8AKpZnEEe72dtJkGxNg1dv7XCIU8KRTkawvwZz8pf+5GesBfN75CC6rYw4SBybQ
 J4aEhCSl9WnhkBryFTFCW008AFy8EGc=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
 s=susede2_ed25519; t=1769454975;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=317mv1rgkjcrHO4IMO/JOlf+/Qy6TF/sjiqQxZGWVEQ=;
 b=wqKPvmiW8XOajhV4wQOyBUpq8MBQ6roFObA1/m7uYAXYfVwFFbPt6igg8KCg3Rn8s2QA2+
 2/DGbfPHBcsh/UBQ==
Authentication-Results: smtp-out1.suse.de;
	none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
 t=1769454975; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=317mv1rgkjcrHO4IMO/JOlf+/Qy6TF/sjiqQxZGWVEQ=;
 b=ZHpeslcLZIbEf7RqNtHJ/U6U3IJG57Ji6BjecrS3fW2MtvmUYj5IHC82tl3sgrHD8JcGuZ
 UlmLjFy8AKpZnEEe72dtJkGxNg1dv7XCIU8KRTkawvwZz8pf+5GesBfN75CC6rYw4SBybQ
 J4aEhCSl9WnhkBryFTFCW008AFy8EGc=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
 s=susede2_ed25519; t=1769454975;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=317mv1rgkjcrHO4IMO/JOlf+/Qy6TF/sjiqQxZGWVEQ=;
 b=wqKPvmiW8XOajhV4wQOyBUpq8MBQ6roFObA1/m7uYAXYfVwFFbPt6igg8KCg3Rn8s2QA2+
 2/DGbfPHBcsh/UBQ==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 82E8C139E9;
 Mon, 26 Jan 2026 19:16:14 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
 by imap1.dmz-prg2.suse.org with ESMTPSA id cE0PEX69d2nPPgAAD6G6ig
 (envelope-from <farosas@suse.de>); Mon, 26 Jan 2026 19:16:14 +0000
From: Fabiano Rosas <farosas@suse.de>
To: Peter Xu <peterx@redhat.com>
Cc: qemu-devel@nongnu.org, armbru@redhat.com, Peter Maydell
 <peter.maydell@linaro.org>
Subject: Re: [PATCH] migration/options: Fix leaks in StrOrNull accessors
In-Reply-To: <aXeV9fpBm_kKNi6t@x1.local>
References: <20260122232456.12722-1-farosas@suse.de>
 <aXeV9fpBm_kKNi6t@x1.local>
Date: Mon, 26 Jan 2026 16:16:11 -0300
Message-ID: <87ecncgp6s.fsf@suse.de>
MIME-Version: 1.0
Content-Type: text/plain
X-Spamd-Result: default: False [-4.30 / 50.00]; BAYES_HAM(-3.00)[99.99%];
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
Received-SPF: pass client-ip=2a07:de40:b251:101:10:150:64:1;
 envelope-from=farosas@suse.de; helo=smtp-out1.suse.de
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

> On Thu, Jan 22, 2026 at 08:24:56PM -0300, Fabiano Rosas wrote:
>> Fix a couple of leaks detected by Coverity. Both are currently
>> harmless because the visitor in the setter can never fail and the
>> whole of the getter is unused, it's only purpose at the moment is to
>> provide a complete implementation of the StrOrNull property.
>> 
>> Fixes: CID 1643919
>> Fixes: CID 1643920
>> Reported-by: Peter Maydell <peter.maydell@linaro.org>
>> Signed-off-by: Fabiano Rosas <farosas@suse.de>
>> ---
>> CI run: https://gitlab.com/farosas/qemu/-/pipelines/2280325023
>> ---
>>  migration/options.c | 2 ++
>>  1 file changed, 2 insertions(+)
>> 
>> diff --git a/migration/options.c b/migration/options.c
>> index 9a5a39c886..9dc44a3736 100644
>> --- a/migration/options.c
>> +++ b/migration/options.c
>> @@ -225,6 +225,7 @@ static void get_StrOrNull(Object *obj, Visitor *v, const char *name,
>>          str_or_null = g_new0(StrOrNull, 1);
>>          str_or_null->type = QTYPE_QSTRING;
>>          str_or_null->u.s = g_strdup("");
>> +        *ptr = str_or_null;
>
> Yep, fixes the leak.
>
> However does it then mean a get() can internally update this Property?  It
> used to be NULL, now it's QTYPE_STRING "".
>
> It may make slightly more sense to me to have zero side effect on a get()
> call. Say, keeping *ptr==NULL after get() returns (as before), while we can
> use a temp string ("") for the visitor.
>
> I randomly checked another get() provider, e.g. get_drive() does that.
> Should we follow?
>

Hmm, I'm actually inclined to assert. This is code for the very specific
purpose of allowing compatibility of -global tls-* options which are
properties of the s->parameters object.

The only way the property could be NULL in the getter is if the setter
has failed. Is there a way we could make the setter fail without it
being a programming error? I don't see it.

- the default for the property is an empty string.

- setting via set-parameters bypasses the qdev code entirely.

- device_add is not reachable because of dc->user_creatable = false.

- object_set_propv and qom_set use a string visitor, so no type mismatch
  to trigger the qobject_to(QString, qobj) cast.

>>      } else {
>>          /* the setter doesn't allow QNULL */
>>          assert(str_or_null->type != QTYPE_QNULL);
>> @@ -245,6 +246,7 @@ static void set_StrOrNull(Object *obj, Visitor *v, const char *name,
>>       */
>>      str_or_null->type = QTYPE_QSTRING;
>>      if (!visit_type_str(v, name, &str_or_null->u.s, errp)) {
>> +        qapi_free_StrOrNull(str_or_null);
>
> This looks correct.  Or, simpler way is we only do g_new0() after the
> visit_type_str() successfully returned (and pass a temp char* into it).
>

I'll update it.

>>          return;
>>      }
>>  
>> -- 
>> 2.51.0
>> 

