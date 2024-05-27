Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 303BBC25B74
	for <qemu-devel@archiver.kernel.org>; Mon, 27 May 2024 23:59:47 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sBkF9-0003NZ-Vd; Mon, 27 May 2024 19:59:08 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <farosas@suse.de>) id 1sBkF9-0003NQ-CZ
 for qemu-devel@nongnu.org; Mon, 27 May 2024 19:59:07 -0400
Received: from smtp-out2.suse.de ([2a07:de40:b251:101:10:150:64:2])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <farosas@suse.de>) id 1sBkF7-0003HB-Iv
 for qemu-devel@nongnu.org; Mon, 27 May 2024 19:59:07 -0400
Received: from imap1.dmz-prg2.suse.org (unknown [10.150.64.97])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by smtp-out2.suse.de (Postfix) with ESMTPS id DA86720011;
 Mon, 27 May 2024 23:59:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
 t=1716854344; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=s/SLF2CxEb/V1LwdSAYVxMqZNLYxjbwpGn30U5BYZOE=;
 b=CX8p3m0dHSDV06IlKFM0AV/BysL9Y+LXnzrTxLtqgyP70R0IaOQuVzeIM9r6fVwLj0CMw9
 A6U9nW4p79p1bD5HedLc66xL8B9yJmRCnhNCLs6Fx6AJOyEif8J+hLG12XYsD87pns8JM+
 sPD30eUjwxqVoCGc0mBDvbhVFumTelE=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
 s=susede2_ed25519; t=1716854344;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=s/SLF2CxEb/V1LwdSAYVxMqZNLYxjbwpGn30U5BYZOE=;
 b=rdu42DvGgFrpiUVMjuaqUYZW4MVnjYxJ1Lts6KbNpdGnOTE/YNZcvdtYqkuv7PJvh7qa9o
 ZaxcBQXGu+wsYoCA==
Authentication-Results: smtp-out2.suse.de;
	none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
 t=1716854343; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=s/SLF2CxEb/V1LwdSAYVxMqZNLYxjbwpGn30U5BYZOE=;
 b=KMRdCMMHZvQI5u81iyEanTSBwxQoO7hBvBGd9KnhAx4UGZPPWdan92H/qv0v2eb35iyC4f
 HjyOlGXPdkswExi+UU1xjxtbmCFVn/vBqDzdq1DyY8Gho4Q6AtXFxwfDIAuNsFntWi/vwK
 kmejuj54jodM4kQeK3UtVvdOxFvVSD0=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
 s=susede2_ed25519; t=1716854343;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=s/SLF2CxEb/V1LwdSAYVxMqZNLYxjbwpGn30U5BYZOE=;
 b=/FavSnSsursRtSyDBfOzXCoa5opUaqBtVwXhr0ONXf8wUsnGrLhNRvlzuC8AR1Li/KInwE
 Zqu/L/AlBBP/XTCQ==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 5A97713A56;
 Mon, 27 May 2024 23:59:03 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
 by imap1.dmz-prg2.suse.org with ESMTPSA id r6vHCEceVWb3JQAAD6G6ig
 (envelope-from <farosas@suse.de>); Mon, 27 May 2024 23:59:03 +0000
From: Fabiano Rosas <farosas@suse.de>
To: Peter Xu <peterx@redhat.com>
Cc: qemu-devel@nongnu.org, Thomas Huth <thuth@redhat.com>, =?utf-8?Q?Marc-?=
 =?utf-8?Q?Andr=C3=A9?= Lureau
 <marcandre.lureau@redhat.com>, Fiona Ebner <f.ebner@proxmox.com>, Het Gala
 <het.gala@nutanix.com>, Alex =?utf-8?Q?Benn=C3=A9e?=
 <alex.bennee@linaro.org>, Philippe
 =?utf-8?Q?Mathieu-Daud=C3=A9?= <philmd@linaro.org>, Wainer dos Santos
 Moschetta <wainersm@redhat.com>, Beraldo Leal <bleal@redhat.com>
Subject: Re: [RFC PATCH 4/4] ci: Add the new migration device tests
In-Reply-To: <ZlT4f368xO8fXsUY@x1n>
References: <20240523201922.28007-1-farosas@suse.de>
 <20240523201922.28007-5-farosas@suse.de> <ZlT4f368xO8fXsUY@x1n>
Date: Mon, 27 May 2024 20:59:00 -0300
Message-ID: <87ttiig62j.fsf@suse.de>
MIME-Version: 1.0
Content-Type: text/plain
X-Spamd-Result: default: False [-4.30 / 50.00]; BAYES_HAM(-3.00)[100.00%];
 NEURAL_HAM_LONG(-1.00)[-1.000];
 NEURAL_HAM_SHORT(-0.20)[-1.000]; MIME_GOOD(-0.10)[text/plain];
 ARC_NA(0.00)[]; RCVD_VIA_SMTP_AUTH(0.00)[];
 MISSING_XM_UA(0.00)[]; MIME_TRACE(0.00)[0:+];
 RCPT_COUNT_SEVEN(0.00)[10]; MID_RHS_MATCH_FROM(0.00)[];
 RCVD_TLS_ALL(0.00)[];
 DKIM_SIGNED(0.00)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
 FROM_EQ_ENVFROM(0.00)[]; FROM_HAS_DN(0.00)[];
 TO_DN_SOME(0.00)[]; RCVD_COUNT_TWO(0.00)[2];
 FUZZY_BLOCKED(0.00)[rspamd.com]; TO_MATCH_ENVRCPT_ALL(0.00)[];
 DBL_BLOCKED_OPENRESOLVER(0.00)[suse.de:email]
Received-SPF: pass client-ip=2a07:de40:b251:101:10:150:64:2;
 envelope-from=farosas@suse.de; helo=smtp-out2.suse.de
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

Peter Xu <peterx@redhat.com> writes:

> On Thu, May 23, 2024 at 05:19:22PM -0300, Fabiano Rosas wrote:
>> We have two new migration tests that check cross version
>> compatibility. One uses the vmstate-static-checker.py script to
>> compare the vmstate structures from two different QEMU versions. The
>> other runs a simple migration with a few devices present in the VM, to
>> catch obvious breakages.
>> 
>> Add both tests to the migration-compat-common job.
>> 
>> Signed-off-by: Fabiano Rosas <farosas@suse.de>
>> ---
>>  .gitlab-ci.d/buildtest.yml | 43 +++++++++++++++++++++++++++++++-------
>>  1 file changed, 36 insertions(+), 7 deletions(-)
>> 
>> diff --git a/.gitlab-ci.d/buildtest.yml b/.gitlab-ci.d/buildtest.yml
>> index 91c57efded..bc7ac35983 100644
>> --- a/.gitlab-ci.d/buildtest.yml
>> +++ b/.gitlab-ci.d/buildtest.yml
>> @@ -202,18 +202,47 @@ build-previous-qemu:
>>    needs:
>>      - job: build-previous-qemu
>>      - job: build-system-opensuse
>> -  # The old QEMU could have bugs unrelated to migration that are
>> -  # already fixed in the current development branch, so this test
>> -  # might fail.
>> +  # This test is allowed to fail because:
>> +  #
>> +  # - The old QEMU could have bugs unrelated to migration that are
>> +  #   already fixed in the current development branch.
>
> Did you ever hit a real failure with this?  I'm wondering whether we can
> remove this allow_failure thing.
>

I haven't. But when it fails we'll go through an entire release cycle
with this thing showing red for every person that runs the CI. Remember,
this is a CI failure to which there's no fix aside from waiting for the
release to happen. Even if we're quick to react and disable the job, I
feel it might create some confusion already.

>> +  #
>> +  # - The vmstate-static-checker script trips on renames and other
>> +  #   backward-compatible changes to the vmstate structs.
>
> I think I keep my preference per last time we talked on this. :)

Sorry, I'm not trying to force this in any way, I just wrote these to
use in the pull-request and thought I'd put it out there. At the very
least we can have your concerns documented. =)

> I still think it's too early to involve a test that can report false
> negative.

(1)
Well, we haven't seen any false negatives, we've seen fields being
renamed. If that happens, then we'll ask the person to update the
script. Is that not acceptable to you? Or are you thinking about other
sorts of issues?

> I'd still keep running this before soft-freeze like I used to
> do, throw issues to others and urge them to fix before release.

Having hidden procedures that maintainers run before a release is bad
IMHO, it just delays the catching of bugs and frustrates
contributors. Imagine working on a series, everything goes well with
reviews, CI passes, patch gets queued and merged and a month later you
get a ping about something you should have done to avoid breaking
migration. Right during freeze.

> Per my
> previous experience that doesn't consume me a lot of time, and it's not
> common to see issues either.
>
> So I want people to really pay attention when someone sees a migration CI
> test failed, rather than we help people form the habit in "oh migration CI
> failed again?  I think that's fine, it allows failing anyway".

That's a good point. I don't think it applies here though. See my point
in (1).

> So far I still don't see as much benefit to adding this if we need to pay
> for the other false negative issue.  I'll fully support it if e.g. we can
> fix the tool to avoid reporting false negatives, but that may take effort
> that I didn't check.
>

