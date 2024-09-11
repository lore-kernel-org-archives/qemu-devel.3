Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 35593EE57C1
	for <qemu-devel@archiver.kernel.org>; Wed, 11 Sep 2024 16:12:23 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1soPwj-00010v-Fb; Wed, 11 Sep 2024 12:11:57 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <farosas@suse.de>) id 1soPwi-00010J-00
 for qemu-devel@nongnu.org; Wed, 11 Sep 2024 12:11:56 -0400
Received: from smtp-out1.suse.de ([195.135.223.130])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <farosas@suse.de>) id 1soPwg-0007k6-5P
 for qemu-devel@nongnu.org; Wed, 11 Sep 2024 12:11:55 -0400
Received: from imap1.dmz-prg2.suse.org (unknown [10.150.64.97])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by smtp-out1.suse.de (Postfix) with ESMTPS id 897A8219FF;
 Wed, 11 Sep 2024 16:11:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
 t=1726071112; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=QZqt7IBzBfanB+qvtqS2tYcghbK/wY02GS1YLaoD4TQ=;
 b=tPVHliXjQeBIA/rIqvevxbMmNVAcPMT57Y8hEmCer62a15gX0CC46Rh+7PwqfVR09FAajY
 bqFqf79YJp9G9BvY+aQLuHSmUb4OcdwZTVgBbFzz92cknxIvVtt6tsYGKsNhdwrLWYIqdH
 1QhKdWSO4WjcdztqnuRw79o0ssZwxnc=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
 s=susede2_ed25519; t=1726071112;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=QZqt7IBzBfanB+qvtqS2tYcghbK/wY02GS1YLaoD4TQ=;
 b=WetZVQigF1X7045dELeaotpDcw18ITfUL2+Q3HqE1hBhbtkXtOM7fFBwaM40qOZOdLDTH0
 fHCFZvjgk6wL+GAA==
Authentication-Results: smtp-out1.suse.de;
	none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
 t=1726071112; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=QZqt7IBzBfanB+qvtqS2tYcghbK/wY02GS1YLaoD4TQ=;
 b=tPVHliXjQeBIA/rIqvevxbMmNVAcPMT57Y8hEmCer62a15gX0CC46Rh+7PwqfVR09FAajY
 bqFqf79YJp9G9BvY+aQLuHSmUb4OcdwZTVgBbFzz92cknxIvVtt6tsYGKsNhdwrLWYIqdH
 1QhKdWSO4WjcdztqnuRw79o0ssZwxnc=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
 s=susede2_ed25519; t=1726071112;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=QZqt7IBzBfanB+qvtqS2tYcghbK/wY02GS1YLaoD4TQ=;
 b=WetZVQigF1X7045dELeaotpDcw18ITfUL2+Q3HqE1hBhbtkXtOM7fFBwaM40qOZOdLDTH0
 fHCFZvjgk6wL+GAA==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 1359013A7C;
 Wed, 11 Sep 2024 16:11:51 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
 by imap1.dmz-prg2.suse.org with ESMTPSA id n2DeMkfB4WYnfAAAD6G6ig
 (envelope-from <farosas@suse.de>); Wed, 11 Sep 2024 16:11:51 +0000
From: Fabiano Rosas <farosas@suse.de>
To: Peter Xu <peterx@redhat.com>
Cc: qemu-devel@nongnu.org, Prasad Pandit <ppandit@redhat.com>, Yichen Wang
 <yichen.wang@bytedance.com>, Bryan Zhang <bryan.zhang@bytedance.com>, Hao
 Xiang <hao.xiang@linux.dev>, Yuan Liu <yuan1.liu@intel.com>
Subject: Re: [PATCH] migration/multifd: Fix build for qatzip
In-Reply-To: <ZuG1FWeek3TEpgAK@x1n>
References: <20240910210450.3835123-1-peterx@redhat.com>
 <87v7z3qjih.fsf@suse.de> <ZuDBUSC2hVaWv6dE@x1n> <87jzfjqgwc.fsf@suse.de>
 <ZuG1FWeek3TEpgAK@x1n>
Date: Wed, 11 Sep 2024 13:11:48 -0300
Message-ID: <87h6amqiez.fsf@suse.de>
MIME-Version: 1.0
Content-Type: text/plain
X-Spamd-Result: default: False [-4.30 / 50.00]; BAYES_HAM(-3.00)[99.99%];
 NEURAL_HAM_LONG(-1.00)[-1.000];
 NEURAL_HAM_SHORT(-0.20)[-1.000]; MIME_GOOD(-0.10)[text/plain];
 ARC_NA(0.00)[]; RCVD_VIA_SMTP_AUTH(0.00)[];
 MISSING_XM_UA(0.00)[]; MIME_TRACE(0.00)[0:+];
 RCPT_COUNT_SEVEN(0.00)[7]; MID_RHS_MATCH_FROM(0.00)[];
 RCVD_TLS_ALL(0.00)[];
 DKIM_SIGNED(0.00)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
 FROM_EQ_ENVFROM(0.00)[]; FROM_HAS_DN(0.00)[];
 TO_DN_SOME(0.00)[]; RCVD_COUNT_TWO(0.00)[2];
 FUZZY_BLOCKED(0.00)[rspamd.com]; TO_MATCH_ENVRCPT_ALL(0.00)[];
 DBL_BLOCKED_OPENRESOLVER(0.00)[imap1.dmz-prg2.suse.org:helo]
Received-SPF: pass client-ip=195.135.223.130; envelope-from=farosas@suse.de;
 helo=smtp-out1.suse.de
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

> On Tue, Sep 10, 2024 at 07:32:19PM -0300, Fabiano Rosas wrote:
>> I'm trying to find a way of having more code compiled by default and
>> only a minimal amount of code put under the CONFIG_FOO options. So if
>> some multifd code depends on a library call, say deflateInit, we make
>> that a multifd_deflate_init and add a stub for when !ZLIB (just an
>> example). I'm not sure it's feasible though, I'm just bouncing the idea
>> off of you.
>
> Not sure how much it helps.  It adds more work, add slightly more code to
> maintain (then we will then need to maintain the shim layer, and that's
> per-compressor), while I am not sure it'll be good enough either..  For
> example, even if it compiles it can still run into constant failure when
> with the real library / hardware underneath.
>
> This not so bad to me yet: do you still remember or aware of the "joke" on
> how people remove a feature in Linux?  One can introduce a bug that can
> directly crash when some feature enabled, then after two years the
> developer can say "see, this feature is not used by anyone, let's remove
> it".
>
> I think it's a joke (which might come from reality..) but it's kind of a
> way that how we should treat these compressors as a start, IMHO.  AFAIU
> many of these compressors start with PoC-type projects where it's used to
> justify the hardware features.  The next step is in production use but that
> requires software vendors to involve, IIUC.  I think that's what we're
> waiting for, on company use it in more serious way that sign these features
> off.
>
> I don't think all such compressors will reach that point.  Meanwhile I
> don't think we (as qemu migration maintainers) can maintain that code well,
> if we don't get sponsored by people with hardwares to test.
>
> I think it means it's not our job to maintain it at 100%, yet so far.  We
> will still try our best, but that's always limited.  As we discussed
> before, we always need to rely on vendors so far for most of them.
>
> If after a few releases we found it's broken so bad, it may mean it
> finished its job as PoC or whatever purpose it services.  It means we could
> choose to move on, with no joking.
>
> That's why I think it's not so urgent, and maybe we don't need extra effort
> to make it harder for us to notice nobody is using it - we keep everything
> we know productions are actively using seriously (like multifd, postcopy,
> etc.).  Either some compressors become part of the serious use case, or we
> move on.  I recently do find more that the only way to make QEMU keep
> living well is to sometimes throw things away..

Ok, that's all fair. I agree we can continue with that policy. Thanks
for sharing your thoughts.

