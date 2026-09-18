Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 066FCC982D7
	for <qemu-devel@archiver.kernel.org>; Fri, 18 Sep 2026 22:46:19 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1x7hLA-0006nA-BT; Fri, 18 Sep 2026 18:45:56 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <farosas@suse.de>) id 1x7hL7-0006mX-Hz
 for qemu-devel@nongnu.org; Fri, 18 Sep 2026 18:45:53 -0400
Received: from smtp-out1.suse.de ([2a07:de40:b251:101:10:150:64:1])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <farosas@suse.de>) id 1x7hL3-0003NG-MQ
 for qemu-devel@nongnu.org; Fri, 18 Sep 2026 18:45:52 -0400
Received: from imap1.dmz-prg2.suse.org (unknown [10.150.64.97])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by smtp-out1.suse.de (Postfix) with ESMTPS id 67F9B21EDB;
 Fri, 18 Sep 2026 22:45:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
 t=1789771543; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=DjNSpNRWQirzEVoVABmFvkPNvctZIQTzuCeDq/2SCo8=;
 b=Mh88qQZZ1w0aQRSQxsr6UU8uogzSyO/KC8d4KazyX0MESz9KnEmUMMTk+VrQ++0Q6OySYE
 QtfOgDL1GbiOuYXuh3I1aZm9fvLzhNRTc3N7EBMLSxsVuL2NGfyCm8pKkQP0i0oYz77XaG
 yqRX226IB4sjts8OWyWyq7XCH/8oMC8=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
 s=susede2_ed25519; t=1789771543;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=DjNSpNRWQirzEVoVABmFvkPNvctZIQTzuCeDq/2SCo8=;
 b=OrpJcm4RLLPENrfa5BuIhv6QW3A15nnZODt2Q0fWc0UKbtw3SQYoOPwpMkxzPHMx7BxLmy
 sRUoaoaYBlr7EHCg==
Authentication-Results: smtp-out1.suse.de;
	none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
 t=1789771539; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=DjNSpNRWQirzEVoVABmFvkPNvctZIQTzuCeDq/2SCo8=;
 b=FucszC4hbN7J0lXXOK4er3ETMeuvSpjgizHKBRLwkIUugezElbIHNo9aWTd1hmYh2/FXPi
 SGuixxkciy4tEmqHHQN11ZAuWpzArC4HCa+CWaQjNbU3LyXSNeyxZwBmkEEPKKEShtC3TE
 caBp9jLj0LrdGTlhhG8mSrL6N1zHSpM=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
 s=susede2_ed25519; t=1789771539;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=DjNSpNRWQirzEVoVABmFvkPNvctZIQTzuCeDq/2SCo8=;
 b=j6yt7SQMeG9jyDIQrq4SYUZ+pN5rmISWQOC1idcHk5N8ArbLYNl9Zf8AYTVAu9TBsN3tJn
 Mhp9uraSgSqFiqCw==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id B8624133CF;
 Fri, 18 Sep 2026 22:45:38 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
 by imap1.dmz-prg2.suse.org with ESMTPSA id Zf51FhK/rWrZBgAAD6G6ig
 (envelope-from <farosas@suse.de>); Fri, 18 Sep 2026 22:45:38 +0000
From: Fabiano Rosas <farosas@suse.de>
To: Markus Armbruster <armbru@redhat.com>
Cc: qemu-devel@nongnu.org, =?utf-8?Q?Marc-Andr=C3=A9?= Lureau
 <marcandre.lureau@redhat.com>
Subject: Re: [PATCH] qemu-option: Cope with a missing QemuOptsList
In-Reply-To: <87wlsmfu1t.fsf@pond.sub.org>
References: <20260915134412.4187164-1-farosas@suse.de>
 <87wlsmfu1t.fsf@pond.sub.org>
Date: Fri, 18 Sep 2026 19:45:32 -0300
Message-ID: <87eceqrxf7.fsf@suse.de>
MIME-Version: 1.0
Content-Type: text/plain
X-Spamd-Result: default: False [-4.30 / 50.00]; BAYES_HAM(-3.00)[99.99%];
 NEURAL_HAM_LONG(-1.00)[-1.000];
 NEURAL_HAM_SHORT(-0.20)[-0.999]; MIME_GOOD(-0.10)[text/plain];
 RCVD_VIA_SMTP_AUTH(0.00)[]; ARC_NA(0.00)[];
 MIME_TRACE(0.00)[0:+]; MISSING_XM_UA(0.00)[];
 TO_DN_SOME(0.00)[]; MID_RHS_MATCH_FROM(0.00)[];
 RCVD_TLS_ALL(0.00)[];
 DKIM_SIGNED(0.00)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
 FROM_HAS_DN(0.00)[]; RCPT_COUNT_THREE(0.00)[3];
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

Markus Armbruster <armbru@redhat.com> writes:

> Fabiano Rosas <farosas@suse.de> writes:
>
>> It's a common pattern in vl.c to chain the qemu_find_opts() output
>> into the first argument of qemu_opts_parse_noisily():
>>
>> opts = qemu_opts_parse_noisily(qemu_find_opts("spice"), optarg, false);
>> if (!opts) {
>>     exit(1);
>> }
>>
>> In cases such as spice that have the group defined in the module file,
>> it's possible to reach qemu_opts_parse_noisily() with a NULL QemuOptsList if
>> the module is not present in the host filesystem.
>>
>>   $ ../configure --enable-modules --enable-spice
>>   $ make
>>   $ mv qemu-bundle/usr/local/lib64/qemu/ui-spice-core.so{,.not}
>>   $ ./qemu-system-x86_64 -spice a
>>   qemu-system-x86_64: -spice a: There is no option group 'spice'
>>   Segmentation fault (core dumped)
>>
>> Return NULL from qemu_opts_parse_noisily() if there is no list.
>>
>> Signed-off-by: Fabiano Rosas <farosas@suse.de>
>> ---
>>  util/qemu-option.c | 4 ++++
>>  1 file changed, 4 insertions(+)
>>
>> diff --git a/util/qemu-option.c b/util/qemu-option.c
>> index 9fbf425f86..0ec12d252c 100644
>> --- a/util/qemu-option.c
>> +++ b/util/qemu-option.c
>> @@ -945,6 +945,10 @@ QemuOpts *qemu_opts_parse_noisily(QemuOptsList *list, const char *params,
>>      QemuOpts *opts;
>>      bool help_wanted = false;
>>  
>> +    if (!list) {
>> +        return NULL;
>> +    }
>> +
>>      opts = opts_parse(list, params, permit_abbrev, true,
>>                        opts_accepts_any(list) ? NULL : &help_wanted,
>>                        &err);
>
> Before the patch, qemu_opts_parse_noisily() either
>
> * Succeeds and returns non-null
>
> * Fails, reports an error, and returns null
>
> * Prints help and returns null
>
> Your patch adds a fourth case:
>
> * Fails silently and returns null
>
> I dislike this case.  Functions should either always print something
> whent they fail, or never.
>
> Are all callers prepared for silent failure?
>
> The pattern you quoted in the commit message is, because
> qemu_find_opts() reports an error.
>
> Here's a cleaner solution for this pattern.  Replace
>
>     opts = qemu_opts_parse_noisily(qemu_find_opts(...), ...)
>
> by a call of a new helper function that does
>
>     list = qemu_find_opts(...);
>     if (!list) {
>         return NULL;
>     }
>     return qemu_opts_parse_noisily(list, ...);
>
> Thoughts?

I agree, but I didn't want to add another helper on top of
qemu_opts_parse_noisily() so I did some further cleanup, see whether you
hate it:

https://lore.kernel.org/r/20260918223002.1892021-1-farosas@suse.de

