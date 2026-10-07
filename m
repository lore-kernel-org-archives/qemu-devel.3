Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 555AFCA5FF1
	for <qemu-devel@archiver.kernel.org>; Wed,  7 Oct 2026 12:43:52 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xEQzN-0006ia-9Q; Wed, 07 Oct 2026 08:43:18 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <farosas@suse.de>) id 1xEQzI-0006hy-2x
 for qemu-devel@nongnu.org; Wed, 07 Oct 2026 08:43:12 -0400
Received: from smtp-out2.suse.de ([195.135.223.131])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <farosas@suse.de>) id 1xEQzG-0005Ol-8Q
 for qemu-devel@nongnu.org; Wed, 07 Oct 2026 08:43:11 -0400
Received: from imap1.dmz-prg2.suse.org (unknown [10.150.64.97])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by smtp-out2.suse.de (Postfix) with ESMTPS id 8E05A1F38E;
 Wed,  7 Oct 2026 12:43:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
 t=1791376986; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=ZQZup9UgVzjpoQkV0yffHq8xS8YNnOc7nDG9mYSlwR8=;
 b=EwLcNNZ0r3uy/YKX5Vh3Bl310Ppx3EQPs/TKnhG79wpLXV1EOhekStu0lcfwGO3jbM4IDk
 TlTTKxN96AQsSeKrH4C6T6uUSUmdSbg6RrqFI/OXf2f6e5BcfCnU1gKziKhgU/HMBeLw8P
 kegej+jhcsBZ7h8IYpkFsviiybMxULg=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
 s=susede2_ed25519; t=1791376986;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=ZQZup9UgVzjpoQkV0yffHq8xS8YNnOc7nDG9mYSlwR8=;
 b=EVNdNCFPK8hDRyTgLcViRvEnsGsB8WlJhGrIBM97T/JnX1SruE3yV7kd7WWRGVSNPRmuZB
 waHsBB59vveaAwCQ==
Authentication-Results: smtp-out2.suse.de;
	none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
 t=1791376986; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=ZQZup9UgVzjpoQkV0yffHq8xS8YNnOc7nDG9mYSlwR8=;
 b=EwLcNNZ0r3uy/YKX5Vh3Bl310Ppx3EQPs/TKnhG79wpLXV1EOhekStu0lcfwGO3jbM4IDk
 TlTTKxN96AQsSeKrH4C6T6uUSUmdSbg6RrqFI/OXf2f6e5BcfCnU1gKziKhgU/HMBeLw8P
 kegej+jhcsBZ7h8IYpkFsviiybMxULg=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
 s=susede2_ed25519; t=1791376986;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=ZQZup9UgVzjpoQkV0yffHq8xS8YNnOc7nDG9mYSlwR8=;
 b=EVNdNCFPK8hDRyTgLcViRvEnsGsB8WlJhGrIBM97T/JnX1SruE3yV7kd7WWRGVSNPRmuZB
 waHsBB59vveaAwCQ==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id DEF2213354;
 Wed,  7 Oct 2026 12:43:05 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
 by imap1.dmz-prg2.suse.org with ESMTPSA id z5sDH1k+xmpxWQAAD6G6ig
 (envelope-from <farosas@suse.de>); Wed, 07 Oct 2026 12:43:05 +0000
From: Fabiano Rosas <farosas@suse.de>
To: Markus Armbruster <armbru@redhat.com>
Cc: qemu-devel@nongnu.org, =?utf-8?Q?Daniel_P_=2E_Berrang=C3=A9?=
 <berrange@redhat.com>,
 Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>, Kevin Wolf
 <kwolf@redhat.com>, Hanna Reitz <hreitz@redhat.com>
Subject: Re: [PATCH v2 03/11] qemu-option: Remove short form options support
In-Reply-To: <87h5iyasxn.fsf@pond.sub.org>
References: <20260930221105.2262063-1-farosas@suse.de>
 <20260930221105.2262063-4-farosas@suse.de> <87h5iyasxn.fsf@pond.sub.org>
Date: Wed, 07 Oct 2026 09:43:03 -0300
Message-ID: <87y0c97kbs.fsf@suse.de>
MIME-Version: 1.0
Content-Type: text/plain
X-Spamd-Result: default: False [-4.30 / 50.00]; BAYES_HAM(-3.00)[100.00%];
 NEURAL_HAM_LONG(-1.00)[-1.000];
 NEURAL_HAM_SHORT(-0.20)[-1.000]; MIME_GOOD(-0.10)[text/plain];
 RCVD_VIA_SMTP_AUTH(0.00)[]; ARC_NA(0.00)[];
 MIME_TRACE(0.00)[0:+]; MISSING_XM_UA(0.00)[];
 TO_DN_SOME(0.00)[]; MID_RHS_MATCH_FROM(0.00)[];
 RCVD_TLS_ALL(0.00)[];
 DKIM_SIGNED(0.00)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
 FROM_HAS_DN(0.00)[]; RCPT_COUNT_FIVE(0.00)[6];
 FROM_EQ_ENVFROM(0.00)[]; TO_MATCH_ENVRCPT_ALL(0.00)[];
 RCVD_COUNT_TWO(0.00)[2];
 DBL_BLOCKED_OPENRESOLVER(0.00)[suse.de:email]
Received-SPF: pass client-ip=195.135.223.131; envelope-from=farosas@suse.de;
 helo=smtp-out2.suse.de
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
>> Option parameters without a value (i.e. key vs. key=val) are
>> deprecated. The missing value is currently implied to be either "on"
>> or "off" depending on whether the parameter name starts with "no".
>
> Commit ccd3b3b811 (qemu-option: warn for short-form boolean options,
> 2020-11-09).  Six years of warnings should suffice.
>
>> Remove the implied behavior and start rejecting option parameters
>> without values by emitting the error message:
>>
>>  "Parameter 'foo' without a value."
>>
>> Two special cases remain:
>>
>> 1) The 'help' parameter is special and still supported. Keep a
>>    positive value attached to it ("on").
>>
>>    Note that currently there is no validation for the value (if any)
>>    attached to the help parameter. help, help=on, help=off, help=foo
>>    all result in the help text being emitted. This is not changed by
>>    this patch.
>
> Really?
>
>     $ qemu-system-x86_64 -chardev help=foo
>     qemu-system-x86_64: -chardev help=foo: Invalid parameter 'help'
>

Ah, ok, it depends on whether the option accepts any parameter
(i.e. opts_accepts_any()). Here's -object failing to reject the bogus
value:

$ qemu-system-x86_64 -object memory-backend-ram,id=m1,help=foo
memory-backend-ram options:
  dump=<bool>            - Set to 'off' to exclude from core dump
  host-nodes=<[uint16]>  - Binds memory to the list of NUMA host nodes
  merge=<bool>           - Mark memory as mergeable
  policy=<HostMemPolicy> - Set the NUMA policy
  prealloc-context=<link<thread-context>> - Context to use for creating CPU threads for preallocation
  prealloc-threads=<int> - Number of CPU threads to use for prealloc
  prealloc=<bool>        - Preallocate memory
  reserve=<bool>         - Reserve swap space (or huge pages) if applicable
  share=<bool>           - Mark the memory as private to QEMU or shared
  size=<size>            - Size of the memory region (ex: 500M)
  x-use-canonical-path-for-ramblock-id=<bool>

>> 2) The empty value is allowed if the key is also empty. This can be
>>    achieved in the command line by adding commas.
>>    E.g.: share=on,, is parsed as:
>>      key:"share" value:"on" and
>>      key:"" value:"on"
>
> I don't think so:
>
>     $ qemu-system-x86_64 -object memory-backend-ram,id=mem0,share=on,,
>     qemu-system-x86_64: -object memory-backend-ram,id=mem0,share=on,,: Parameter 'share' expects 'on' or 'off'
>

Bah, I wrote the example for the commit message but haven't tried
it. I'm trying to refer to the single leading comma scenario, we have a
test for it:

    /* Except when it isn't */
    opts = qemu_opts_parse(&opts_list_03, ",", false, &error_abort);
    g_assert_cmpuint(opts_count(opts), ==, 1);
    g_assert_cmpstr(qemu_opt_get(opts, ""), ==, "on");

The following are parsed as valid and only reject the empty key further
down the line:

$ qemu-system-x86_64 -drive ,
qemu-system-x86_64: -drive ,: warning: short-form boolean option '' deprecated
Please use =on instead
qemu-system-x86_64: -drive ,: Must specify either driver or file

$ qemu-system-x86_64 -drive ,file=dummy
qemu-system-x86_64: -drive ,file=dummy: warning: short-form boolean option '' deprecated
Please use =on instead
WARNING: Image format was not specified for 'dummy' and probing guessed raw.
         Automatically detecting the format is dangerous for raw images, write operations on block 0 will be restricted.
         Specify the 'raw' format explicitly to remove the restrictions.
qemu-system-x86_64: -drive ,file=dummy: Block format 'raw' does not support the option ''


> Set a breakpoint on qapi_bool_parse() to see the actual value.  It's
> "on,".  In QemuOpts syntax, double comma is an escape, so you can put
> comma in values.
>
>> One effect of this change that might not be obvious is that parameter
>> combinations of the form:
>>
>>  id=mem0,share,help
>>
>> no longer produce the help output. The lack of value for the 'share'
>> parameter is reported with precedence. Users will need to either use a
>> valid value or omit the parameter entirely:
>>
>>  id=mem0,share=on,help
>>  id=mem0,help
>
> That's unfortunate.
>
> [...]

