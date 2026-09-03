Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 47C2EC624DA
	for <qemu-devel@archiver.kernel.org>; Thu,  3 Sep 2026 18:36:40 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1x2CI1-00053q-3v; Thu, 03 Sep 2026 14:35:57 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <farosas@suse.de>) id 1x2CHz-00053e-46
 for qemu-devel@nongnu.org; Thu, 03 Sep 2026 14:35:55 -0400
Received: from smtp-out1.suse.de ([195.135.223.130])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <farosas@suse.de>) id 1x2CHx-0002fL-FX
 for qemu-devel@nongnu.org; Thu, 03 Sep 2026 14:35:54 -0400
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org
 [IPv6:2a07:de40:b281:104:10:150:64:97])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by smtp-out1.suse.de (Postfix) with ESMTPS id 6E4BC21EF2;
 Thu,  3 Sep 2026 18:35:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
 t=1788460547; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=nlSxG5iI0U4+Xdmh/VfZwsfgnnmuEGCitm9ltT6nopc=;
 b=uZ+iX3Rd7l550O7k4AVw5yxJJJvo90lv88OVohVnfV21sBfz3t77Sr02h3uYfaQ0TkBS58
 qtOlecMTuUTGJuBqTPoUY6sAFoZ3xhdLU53DZqLwxKR4LfCq0tnWVBU0mOCIPN4tMdQr0a
 R5kJFVuOBFOdl+drE6dfrQkSX6Io5Vg=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
 s=susede2_ed25519; t=1788460547;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=nlSxG5iI0U4+Xdmh/VfZwsfgnnmuEGCitm9ltT6nopc=;
 b=FywcvpXyvrrF4ZSOIdn3tPaxMJV0dlLpg08BVsfXuaUASwDo9at+pURnsYALQFwIym75tL
 9G1nR6nf0Rit0dAw==
Authentication-Results: smtp-out1.suse.de;
 dkim=pass header.d=suse.de header.s=susede2_rsa header.b="hg7gCA/d";
 dkim=pass header.d=suse.de header.s=susede2_ed25519 header.b=qFdbhwKG
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
 t=1788460543; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=nlSxG5iI0U4+Xdmh/VfZwsfgnnmuEGCitm9ltT6nopc=;
 b=hg7gCA/dnAqXU7htssjtj2wPNAbIM7m2B1hhH34P1Bh+D06X700OChxvbJmLlCdi6jHj4B
 PJeA9NGBDp3k+WJwU8jeo2u+8F1F2EBuvxdu7UFQmeBiMglKdx2MPfyRA8cLXbIH74lgDN
 zBBvBzNBndCxfkkQQBBClnpfbiFn1qk=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
 s=susede2_ed25519; t=1788460543;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=nlSxG5iI0U4+Xdmh/VfZwsfgnnmuEGCitm9ltT6nopc=;
 b=qFdbhwKGHDNgRXl8NX+J3GrEiBoH07qtLYX0Ihh5yW21cQnBhedPQgPCjGqfoVB2n35AGH
 IeEIFUX9tB6PqdBg==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id EC116136D9;
 Thu,  3 Sep 2026 18:35:42 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
 by imap1.dmz-prg2.suse.org with ESMTPSA id wOC7Lv69mWreCQAAD6G6ig
 (envelope-from <farosas@suse.de>); Thu, 03 Sep 2026 18:35:42 +0000
From: Fabiano Rosas <farosas@suse.de>
To: Peter Xu <peterx@redhat.com>
Cc: qemu-devel@nongnu.org, Chao Liu <chao.liu@processmission.com>
Subject: Re: [PATCH 01/18] checkpatch: Fix checking of newlines in error
 messages
In-Reply-To: <apm10EPO4vYlZLQZ@x1.local>
References: <20260902221547.1812481-1-farosas@suse.de>
 <20260902221547.1812481-2-farosas@suse.de> <apmwZbSLZ46yvGmT@x1.local>
 <87bjae8bya.fsf@suse.de> <apm10EPO4vYlZLQZ@x1.local>
Date: Thu, 03 Sep 2026 15:35:36 -0300
Message-ID: <878q5i89on.fsf@suse.de>
MIME-Version: 1.0
Content-Type: text/plain
X-Rspamd-Queue-Id: 6E4BC21EF2
X-Rspamd-Server: rspamd1.dmz-prg2.suse.org
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-4.51 / 50.00]; BAYES_HAM(-3.00)[99.99%];
 NEURAL_HAM_LONG(-1.00)[-1.000];
 R_DKIM_ALLOW(-0.20)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
 NEURAL_HAM_SHORT(-0.20)[-1.000]; MIME_GOOD(-0.10)[text/plain];
 MX_GOOD(-0.01)[];
 RBL_SPAMHAUS_BLOCKED_OPENRESOLVER(0.00)[2a07:de40:b281:104:10:150:64:97:from]; 
 RCVD_VIA_SMTP_AUTH(0.00)[]; RCVD_TLS_ALL(0.00)[];
 ARC_NA(0.00)[]; MIME_TRACE(0.00)[0:+]; MISSING_XM_UA(0.00)[];
 SPAMHAUS_XBL(0.00)[2a07:de40:b281:104:10:150:64:97:from];
 TO_DN_SOME(0.00)[];
 RECEIVED_SPAMHAUS_BLOCKED_OPENRESOLVER(0.00)[2a07:de40:b281:106:10:150:64:167:received];
 MID_RHS_MATCH_FROM(0.00)[];
 DKIM_SIGNED(0.00)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
 FROM_EQ_ENVFROM(0.00)[]; FROM_HAS_DN(0.00)[];
 RCPT_COUNT_THREE(0.00)[3]; RCVD_COUNT_TWO(0.00)[2];
 TO_MATCH_ENVRCPT_ALL(0.00)[];
 DBL_BLOCKED_OPENRESOLVER(0.00)[imap1.dmz-prg2.suse.org:helo,imap1.dmz-prg2.suse.org:rdns,suse.de:dkim,suse.de:mid];
 DNSWL_BLOCKED(0.00)[2a07:de40:b281:106:10:150:64:167:received];
 DKIM_TRACE(0.00)[suse.de:+]
Received-SPF: pass client-ip=195.135.223.130; envelope-from=farosas@suse.de;
 helo=smtp-out1.suse.de
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

Peter Xu <peterx@redhat.com> writes:

> On Thu, Sep 03, 2026 at 02:46:37PM -0300, Fabiano Rosas wrote:
>> Peter Xu <peterx@redhat.com> writes:
>> 
>> > On Wed, Sep 02, 2026 at 07:15:29PM -0300, Fabiano Rosas wrote:
>> >> Using newlines in the g_test_message is fine. It automatically adds
>> >> the '#' required by the TAP protocol to the start of each line.
>> >
>> > IIUC we have such check not because TAP, but because all these functions
>> > will append one newline at the end, hence it's not needed.  IOW, if it
>> > applies to g_test_message(), I don't see why it doesn't apply to the rest.
>> > But maybe there're other reasons?
>> >
>> > To make it simpler, maybe we just call a few times g_test_message()?
>> >
>> 
>> Not sure I understand your point, Peter. I want to be able to print nice
>> messages in patch 9:
>> 
>>  g_test_message("expected vs. found:\n\n%s\n---\n%s:%s", str, t2[match], t2[match + 1]);
>> 
>>  # HMP output mismatch for entry at line 55:
>>  # expected vs. found:
>>  #
>>  # max-bandwidth: 10356305952768 bytes/hour
>>  # ---
>>  # max-bandwidth: 10356305952768 bytes/second
>> 
>> What would be the issue of having newlines here?
>
> No issue here that I can see.  My question was, why you moved
> g_test_message() out only, but not all?
>

Ah, I see. I didn't want to touch the others because they are
considerably more important than the tests' messages.

> My gut feeling is we check this because people forget that all these
> functions includes a newline.
>
> So if your point stands here that "newlines can be in the middle", they
> should apply to all, not one.
>
> But still, I also don't see why we can't invoke g_test_message() a few
> times here too, if we want to avoid any global touch like this to land the
> whole thing faster..

Hopefully this patch is uncontroversial. Otherwise I can do what you
suggest.

