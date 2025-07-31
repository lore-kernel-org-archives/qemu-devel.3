Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4CE64C87FCA
	for <qemu-devel@archiver.kernel.org>; Thu, 31 Jul 2025 14:40:29 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uhURV-00065m-MX; Thu, 31 Jul 2025 10:39:37 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <farosas@suse.de>) id 1uhTOX-0001Cx-IL
 for qemu-devel@nongnu.org; Thu, 31 Jul 2025 09:32:29 -0400
Received: from smtp-out2.suse.de ([195.135.223.131])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <farosas@suse.de>) id 1uhTOV-00025Q-CY
 for qemu-devel@nongnu.org; Thu, 31 Jul 2025 09:32:29 -0400
Received: from imap1.dmz-prg2.suse.org (unknown [10.150.64.97])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by smtp-out2.suse.de (Postfix) with ESMTPS id A3EA01F807;
 Thu, 31 Jul 2025 13:32:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
 t=1753968743; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=w70Vtc0//9HesWKyntajr98jJM0n4/t1fd3ucq14yrA=;
 b=lBR1vycUMfLOlrG4N2VfssDU0NP5wM3I3woEOzjDpEb29bJU0uO1ZkiqBb9OKlyoQ1KU7V
 yt1ZpMEirPon08WxZFy35rjpb4qDTd5Qd4yVlEh6JuIpu+fQxhYF/oVUo6kuwiwfEBSGvR
 YByGVmeyzEJ2uTfn7BtuuqXWHoiHB5U=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
 s=susede2_ed25519; t=1753968743;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=w70Vtc0//9HesWKyntajr98jJM0n4/t1fd3ucq14yrA=;
 b=Ogx9lmDeR96zpdOyoGy8n2xejAg7Wd55OCDPWW2Jvb+qoXRdqFu5kFRq6Ltt2fMNLRVRwa
 vbPdxtJ5rGTxTwAw==
Authentication-Results: smtp-out2.suse.de;
	none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
 t=1753968743; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=w70Vtc0//9HesWKyntajr98jJM0n4/t1fd3ucq14yrA=;
 b=lBR1vycUMfLOlrG4N2VfssDU0NP5wM3I3woEOzjDpEb29bJU0uO1ZkiqBb9OKlyoQ1KU7V
 yt1ZpMEirPon08WxZFy35rjpb4qDTd5Qd4yVlEh6JuIpu+fQxhYF/oVUo6kuwiwfEBSGvR
 YByGVmeyzEJ2uTfn7BtuuqXWHoiHB5U=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
 s=susede2_ed25519; t=1753968743;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=w70Vtc0//9HesWKyntajr98jJM0n4/t1fd3ucq14yrA=;
 b=Ogx9lmDeR96zpdOyoGy8n2xejAg7Wd55OCDPWW2Jvb+qoXRdqFu5kFRq6Ltt2fMNLRVRwa
 vbPdxtJ5rGTxTwAw==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 269CE13A43;
 Thu, 31 Jul 2025 13:32:22 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
 by imap1.dmz-prg2.suse.org with ESMTPSA id hlKWNmZwi2hkbgAAD6G6ig
 (envelope-from <farosas@suse.de>); Thu, 31 Jul 2025 13:32:22 +0000
From: Fabiano Rosas <farosas@suse.de>
To: Peter Maydell <peter.maydell@linaro.org>
Cc: qemu-devel@nongnu.org, Thomas Huth <thuth@redhat.com>, Peter Xu
 <peterx@redhat.com>, qemu-arm <qemu-arm@nongnu.org>
Subject: Re: [PULL 02/20] target/arm: Correct encoding of Debug
 Communications Channel registers
In-Reply-To: <CAFEAcA9gK8EFBb2UyCv1B2d7TiK+V07Y9Bw0e_UoiUHP4MCDcw@mail.gmail.com>
References: <20250721132718.2835729-1-peter.maydell@linaro.org>
 <20250721132718.2835729-3-peter.maydell@linaro.org>
 <87ms8uh7ln.fsf@suse.de>
 <CAFEAcA9kxDdkEyLguTsEV_nDX9L5mAT+Rw_4Rmk68YQq50ee-A@mail.gmail.com>
 <87pldo3x3y.fsf@suse.de> <87ms8s3rpx.fsf@suse.de> <87bjp24iyk.fsf@suse.de>
 <CAFEAcA9gK8EFBb2UyCv1B2d7TiK+V07Y9Bw0e_UoiUHP4MCDcw@mail.gmail.com>
Date: Thu, 31 Jul 2025 10:32:20 -0300
Message-ID: <878qk44haz.fsf@suse.de>
MIME-Version: 1.0
Content-Type: text/plain
X-Spamd-Result: default: False [-4.30 / 50.00]; BAYES_HAM(-3.00)[99.99%];
 NEURAL_HAM_LONG(-1.00)[-1.000];
 NEURAL_HAM_SHORT(-0.20)[-0.999]; MIME_GOOD(-0.10)[text/plain];
 ARC_NA(0.00)[]; MISSING_XM_UA(0.00)[]; RCVD_TLS_ALL(0.00)[];
 MIME_TRACE(0.00)[0:+]; RCVD_VIA_SMTP_AUTH(0.00)[];
 TO_DN_SOME(0.00)[]; FUZZY_RATELIMITED(0.00)[rspamd.com];
 MID_RHS_MATCH_FROM(0.00)[];
 DKIM_SIGNED(0.00)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
 FROM_HAS_DN(0.00)[]; RCPT_COUNT_FIVE(0.00)[5];
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
 RCVD_IN_DNSWL_MED=-2.3, RCVD_IN_VALIDITY_CERTIFIED_BLOCKED=0.001,
 RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=unavailable autolearn_force=no
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

Peter Maydell <peter.maydell@linaro.org> writes:

> On Wed, 30 Jul 2025 at 01:32, Fabiano Rosas <farosas@suse.de> wrote:
>>
>> Fabiano Rosas <farosas@suse.de> writes:
>>
>> > Fabiano Rosas <farosas@suse.de> writes:
>> >
>> >> Peter Maydell <peter.maydell@linaro.org> writes:
>> >>> I'm not sure how to handle this, as we have no mechanism for
>> >>> "ignore this incoming register value, it is bogus". I'm surprised
>> >>> we've never run into this before...
>> >>>
>> >>
>> >> I was thinking the same.
>> >>
>> >> I actually don't understand what the encoding in cpu->cpreg_indexes is
>> >> supposed to represent. How does comparing the indexes implies "in our
>> >> list"/"in their list"? Is there some sort of ISA level assumption?
>> >>
>> >>        if (cpu->cpreg_vmstate_indexes[v] > cpu->cpreg_indexes[i]) {
>> >>             /* register in our list but not incoming : skip it */
>> >>             continue;
>> >>         }
>> >>         if (cpu->cpreg_vmstate_indexes[v] < cpu->cpreg_indexes[i]) {
>> >>             /* register in their list but not ours: fail migration */
>> >>             return -1;
>> >>         }
>> >>
>> >
>> > Ok, I spotted the sorting now.
>>
>> Turns out the backward migration is also broken because this patch adds
>> an extra register:
>>
>>   qemu-system-aarch64: Invalid value 292 expecting positive value <= 291
>>   qemu-system-aarch64: Failed to load cpu:cpreg_vmstate_array_len
>
> Backward migration is not a design goal for the TCG cpreg machinery:
> you will find that we add extra registers from time to time in
> over various releases.
>

Ok, I'll document this once we fix the compatibility tests for
aarch64. Only test in one direction.

>> We'll need to develop some proper compat machinery that takes the
>> machine version in consideration. For the 10.0 -> 10.1 migration,
>> something like (messy code, just a PoC):
>
> For 10.1 I was thinking about just putting back this specific
> incorrect register. We can do something a bit cleaner once the
> release is out.
>

Your call. I've put an RFC out, but it also requires re-work after
release.

> thanks
> -- PMM

