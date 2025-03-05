Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5CDBCC19F32
	for <qemu-devel@archiver.kernel.org>; Wed,  5 Mar 2025 13:57:45 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tppF5-0006kD-0c; Wed, 05 Mar 2025 08:56:59 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <farosas@suse.de>) id 1tppF1-0006jK-6Y
 for qemu-devel@nongnu.org; Wed, 05 Mar 2025 08:56:55 -0500
Received: from smtp-out2.suse.de ([2a07:de40:b251:101:10:150:64:2])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <farosas@suse.de>) id 1tppEv-000148-0b
 for qemu-devel@nongnu.org; Wed, 05 Mar 2025 08:56:54 -0500
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org
 [IPv6:2a07:de40:b281:104:10:150:64:97])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by smtp-out2.suse.de (Postfix) with ESMTPS id D09FF1F745;
 Wed,  5 Mar 2025 13:56:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
 t=1741183006; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=vJiS2ez1EOEWG4wn3k3LiDZRUurYo33OYL7V8mdP9ik=;
 b=TSW14RDZCvC9PZvRrX7dvUi+z4YJxm/iXTsehjmikq/3soXniYWMFv4zHp70eZ89XTDfZb
 cQDxIsY2ZVgPWZJOLa1ujFVxdN6XzxB9kRF5TYbpsv+mV1iXy5H3OMTrfbL34wL2NivoN1
 eY2x6bbF+kQa9XJI7rgQ5yVVgCs81Z4=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
 s=susede2_ed25519; t=1741183006;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=vJiS2ez1EOEWG4wn3k3LiDZRUurYo33OYL7V8mdP9ik=;
 b=0u7kjjyLw+rxdZ6hgLJRUmBzaoEjyB6oXzDcXLiDUzteVEwWhfilxWUR9l5eKnPTpmfCZ1
 //B98KW3fL+GWGBw==
Authentication-Results: smtp-out2.suse.de;
 dkim=pass header.d=suse.de header.s=susede2_rsa header.b=LZO03rOk;
 dkim=pass header.d=suse.de header.s=susede2_ed25519 header.b=5egi3lbR
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
 t=1741183005; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=vJiS2ez1EOEWG4wn3k3LiDZRUurYo33OYL7V8mdP9ik=;
 b=LZO03rOkz2q4CqbKuivrvuGhdc2s3QK8v+B8fAKvRqfGANQ19EOhXDzn3BFBvNaBklLRAY
 2+xBykrwnP0s0VrazHyn0ZtUhmQq5nqPUHwdiMqh/9mGtkACcNpwVeC+jeAi/d7eCeXHeB
 6RWJ1Kf/jlNB3qia2lebiiq8AArkdvc=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
 s=susede2_ed25519; t=1741183005;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=vJiS2ez1EOEWG4wn3k3LiDZRUurYo33OYL7V8mdP9ik=;
 b=5egi3lbRTTOD6xBL/0BaWQTrftGLVXHdnmxPrWkvtolGSbc69KTthWbkCzTJCr86OYgK5L
 YIUL9ToOgp6oy5Ag==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 4DC421366F;
 Wed,  5 Mar 2025 13:56:45 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
 by imap1.dmz-prg2.suse.org with ESMTPSA id iKH9Ax1YyGf1RgAAD6G6ig
 (envelope-from <farosas@suse.de>); Wed, 05 Mar 2025 13:56:45 +0000
From: Fabiano Rosas <farosas@suse.de>
To: Prasad Pandit <ppandit@redhat.com>, Peter Xu <peterx@redhat.com>
Cc: qemu-devel@nongnu.org, berrange@redhat.com, Prasad Pandit
 <pjp@fedoraproject.org>
Subject: Re: [PATCH v7 0/5] Allow to enable multifd and postcopy migration
 together
In-Reply-To: <CAE8KmOyrSidELiHAtegX16gYbW6jWKL7m9YGJKzfmLbZ9x8Xaw@mail.gmail.com>
References: <20250228121749.553184-1-ppandit@redhat.com>
 <87frjy2k8z.fsf@suse.de>
 <CAE8KmOwVoGJ2frVCY76W7UxSr90wAL2EMj5Nmtcrdc+BE1e9=g@mail.gmail.com>
 <Z8W4xVOLLAD1wXjC@x1.local>
 <CAE8KmOzkVpG5iUqwShWWMF4+96-cbNm1AU8b=s3187EyWXXT4g@mail.gmail.com>
 <Z8cRYO1Kacl7vl-I@x1.local>
 <CAE8KmOyrSidELiHAtegX16gYbW6jWKL7m9YGJKzfmLbZ9x8Xaw@mail.gmail.com>
Date: Wed, 05 Mar 2025 10:56:42 -0300
Message-ID: <878qpjvaw5.fsf@suse.de>
MIME-Version: 1.0
Content-Type: text/plain
X-Rspamd-Queue-Id: D09FF1F745
X-Spamd-Result: default: False [-4.51 / 50.00]; BAYES_HAM(-3.00)[100.00%];
 NEURAL_HAM_LONG(-1.00)[-1.000];
 R_DKIM_ALLOW(-0.20)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
 NEURAL_HAM_SHORT(-0.20)[-1.000]; MIME_GOOD(-0.10)[text/plain];
 MX_GOOD(-0.01)[]; FROM_HAS_DN(0.00)[];
 DKIM_SIGNED(0.00)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
 FUZZY_BLOCKED(0.00)[rspamd.com]; MIME_TRACE(0.00)[0:+];
 ARC_NA(0.00)[]; TO_DN_SOME(0.00)[];
 TO_MATCH_ENVRCPT_ALL(0.00)[]; RCVD_TLS_ALL(0.00)[];
 DKIM_TRACE(0.00)[suse.de:+]; RCVD_COUNT_TWO(0.00)[2];
 FROM_EQ_ENVFROM(0.00)[]; RCPT_COUNT_FIVE(0.00)[5];
 MID_RHS_MATCH_FROM(0.00)[]; MISSING_XM_UA(0.00)[];
 RCVD_VIA_SMTP_AUTH(0.00)[];
 DBL_BLOCKED_OPENRESOLVER(0.00)[suse.de:dkim,suse.de:mid]
X-Rspamd-Server: rspamd2.dmz-prg2.suse.org
X-Rspamd-Action: no action
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

Prasad Pandit <ppandit@redhat.com> writes:

> Hi,
>
> On Tue, 4 Mar 2025 at 20:12, Peter Xu <peterx@redhat.com> wrote:
>> IIUC Fabiano is not asking you to drop them, but split them.  Split still
>> "requires" them to be present, as long as before the enablement patch.
>
> * Yes, same here; Even I am not suggesting to drop anything. Fabiano
> mentioned the following about the changes being done:
>
>     1.  _in preparation for_ the feature  (multifd+postcopy enablement)
>     2.  _as part of_ the feature (multifd+postcopy enablement)

The "channel discovery" part can be considered as a separate patch
because in order to integrate it with the new feature you had to
introduce a new concept of enum CH_* which is not a trivially verifiable
change. That change has the potential to break other use-cases of
migration and although the tests are passing we must be cautions about
it. Simply having that part as a patch is enough separation that an
issue there won't be conflated with the multifd+postcopy feature in
general.

I also called it "in preparation" for the feature because the channel
discovery part is clearly a preexisting issue, in the sense that had we
had proper magic numbers in all channels or some other mechanism to
diffrentiate channels, we wouldn't need this patch. That's a cleanup
you're doing beforehand in order to make the subsequent patches simpler.

Changing that code makes sense regardless of whether there is a new
feature being introduced.

Note that none of this is out of the ordinary, you'll find such
discussions in any thread on this community. It may feel arbitrary to
you because that's tacit knowledge we gathered along the years.

>     3. Concerns about git bisect and backporting of patches, not
> missing patches when backporting.

Yes, whenever you can frame a code change as a pure refactoring, you
should do that. If, say, you had to change 100 lines in order to
implement your feature, but 90 of those lines are just preserving the
existing behavior, that is a good candidate to be a separate patch.

Reviewers will be more inclined to approve the patch, since reading code
and making sure it doesn't change behavior is easier than also
accounting for the new behavior simultaneously.

Maintainers moving patches around, merging, testing, etc will have an
easier time when solving git conflicts because the separate code is more
easily compared with the old one.

Backporters have similar issues with git, but also face questions about
the safety of bringing a patch as a prerequisite into older QEMU
versions. Imagine someone wants to enable multifd+postcopy in QEMU 9.2,
it'll be easier for them to have code more clearly defined as
patches. Another scenario could be if the changes to the channel
discovery actually fix a bug that we're currently not aware of. That
would show up in a bisect session and we wouldn't want to apply a patch
that fixes a bug if the same patch also enables a feature.

>
> * I am thinking:
>     1. The _required_ changes are the _as part of_  the feature changes.
>     2. The refactoring of ram_save_target_page and moving of
> MULTIFD_MAGIC/VERSION macros to multifd.h patch can be termed as _in
> preparation for_ the feature. Of these
>         - Refactoring of 'ram_save_target_page' function patch is
> already pulled upstream.
>             -> https://gitlab.com/qemu-project/qemu/-/commit/bc38dc2f5f350310724fd7d4f0a09f8c3a4811fa
>         - Similarly moving of MULTIFD_ macros patch can be pulled. It
> has not changed for many revisions.
>     3. The _essential_ changes are further refinement of the feature
> (multifd+postcopy enablement).
>
> * IMO, we can split patches as:
>      - One patch for -> _required_ OR _as part of_ the feature changes
>      - One patch for -> MULTIFD_ macros as _in preparation for_ the
> feature change
>      - One patch for -> _essential_  changes : flush and sync related
>      - Two patches for qtest cases related changes.
> This division also seems helpful for git bisect and backporting
> related concerns.
>
> * Currently we are divided over what constitutes:  _required_  OR  _as
> part of_ the feature changes.
>     - Hence the request for individual opinions towards that.
>
> * If we want to merge _required_/_as part of_ the feature  and
> _essential_  changes together in one patch - I'm okay.
> * If we want to split the _required_ / _as part of_ the feature patch
> further into two, we need to define exactly how we do that division. -
> [???]
>

We need an extra patch that reads:

 migration: Refactor channel discovery mechanism
 
 The various logical migration channels don't have a standardized way of
 advertising themselves and their connections may be seen out of order
 by the migration destination. When a new connection arrives, the
 incoming migration currently make use of heuristics to determine which
 channel it belongs to.
 
 The next few patches will need to change how the multifd and postcopy
 capabilities interact and that affects the channel discovery heuristic.
 
 Refactor the channel discovery heuristic to make it less opaque and
 simplify the subsequent patches.
 
 <some description of the new code which might be pertinent>
 ---

You'd move all of the channel discovery code into this patch. Some of it
will be unreacheable because multifd is not yet allowed with postcopy,
but that's fine. You can mention it on the commit message.

About moving the code out of migration.c, it was a suggestion that
you're free to push back. Ideally, doing the work would be faster than
arguing against it on the mailing list. But that's fine.

About the hang in the test. It doesn't reproduce often, but once it
does, it hangs forever (although I haven't waited that long).

> * I have shared my thoughts above, I won't hold on to it unduly.  We
> need to find a way to move forward. I'm willing to go with either way
> we decide.
>
> Thank you.
> ---
>   - Prasad

