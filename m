Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B7576FF8867
	for <qemu-devel@archiver.kernel.org>; Wed, 29 Apr 2026 14:25:53 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wI5qp-00051Z-3s; Wed, 29 Apr 2026 10:25:19 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <farosas@suse.de>) id 1wI5qi-0004uu-A9
 for qemu-devel@nongnu.org; Wed, 29 Apr 2026 10:25:12 -0400
Received: from smtp-out2.suse.de ([2a07:de40:b251:101:10:150:64:2])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <farosas@suse.de>) id 1wI5qg-00033v-K1
 for qemu-devel@nongnu.org; Wed, 29 Apr 2026 10:25:12 -0400
Received: from imap1.dmz-prg2.suse.org (unknown [10.150.64.97])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by smtp-out2.suse.de (Postfix) with ESMTPS id CFCD25BD3F;
 Wed, 29 Apr 2026 14:24:59 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
 t=1777472704; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=cByEM7H3/xnnlZUUW4nhxI1bSEiOfP12JbY79kzq9/k=;
 b=S91iuoSffoL+ZieuMP8aoyFbuYT3zoLxG7YevgZnNwZoJPfEK3nwxHNZrYK7UosEI27STu
 zvSmllAZ/QTTL3Dot/kiyOYn5wQVvvwnzc9gNJr4QVQ4CSGZUMMidMEVI/sRKP0KsHxjjn
 hQWw/S1+AtCk8V9+sjl524jiu4Jt+xk=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
 s=susede2_ed25519; t=1777472704;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=cByEM7H3/xnnlZUUW4nhxI1bSEiOfP12JbY79kzq9/k=;
 b=zMfgD7X8s4VgMPjn9qARyozWOZjrU19a6DbFMzsWQonhdwWpbMd10LjWJgYJmLC+Ag7sLI
 Fw572lxzSlP+BwCw==
Authentication-Results: smtp-out2.suse.de;
	none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
 t=1777472699; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=cByEM7H3/xnnlZUUW4nhxI1bSEiOfP12JbY79kzq9/k=;
 b=p73IWnQ214YiByYFv37wm9Urt96A8NHkDJjJL7y/nXGqlYapJwCQ+dlSZZY8S4eWeTY+9c
 mxoSqrBx8hXzhPU9gh9kW+nCIavwJ+e8NiXmSwwyZ/5PUOobri6trAFRq+RVyk52XPjM4N
 ysK3e9nSCt6RaBGuBH/GLm68gMF4hOk=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
 s=susede2_ed25519; t=1777472699;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=cByEM7H3/xnnlZUUW4nhxI1bSEiOfP12JbY79kzq9/k=;
 b=EQppfa7J23Z9hvSs2LfGN1EUxOenEdExQccsTT4HcOQyRZ3qabixJ4w4l2WwISFpDGcIh/
 Arw9etNl+f/CLSBg==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 6CB8B593B0;
 Wed, 29 Apr 2026 14:24:59 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
 by imap1.dmz-prg2.suse.org with ESMTPSA id KcVGD7sU8mkBYwAAD6G6ig
 (envelope-from <farosas@suse.de>); Wed, 29 Apr 2026 14:24:59 +0000
From: Fabiano Rosas <farosas@suse.de>
To: Michael Tokarev <mjt@tls.msk.ru>, Junjie Cao <junjie.cao@intel.com>,
 qemu-devel@nongnu.org
Cc: berrange@redhat.com, peterx@redhat.com, qemu-stable
 <qemu-stable@nongnu.org>
Subject: Re: [PATCH v3 0/4] io/channel: complete pread/pwrite_all API and
 fix multifd_file_recv_data
In-Reply-To: <e893c0f8-1826-4f30-b4ed-ee2932bf5dfd@tls.msk.ru>
References: <20260413214549.926435-1-junjie.cao@intel.com>
 <c164cb5f-27e5-412d-ad28-70a6fc050722@tls.msk.ru>
 <e893c0f8-1826-4f30-b4ed-ee2932bf5dfd@tls.msk.ru>
Date: Wed, 29 Apr 2026 11:24:53 -0300
Message-ID: <877bpprgi2.fsf@suse.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
X-Spamd-Result: default: False [-4.30 / 50.00]; BAYES_HAM(-3.00)[99.99%];
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
 DBL_BLOCKED_OPENRESOLVER(0.00)[imap1.dmz-prg2.suse.org:helo,suse.de:mid]
Received-SPF: pass client-ip=2a07:de40:b251:101:10:150:64:2;
 envelope-from=farosas@suse.de; helo=smtp-out2.suse.de
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=unavailable autolearn_force=no
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

Michael Tokarev <mjt@tls.msk.ru> writes:

> On 26.04.2026 11:15, Michael Tokarev wrote:
>> On 14.04.2026 00:45, Junjie Cao wrote:
>>> This series fixes two bugs in multifd_file_recv_data() and completes
>>> the positioned read/write "all" API set for QIO channels.
>>>
>>> Bug summary:
>>> =C2=A0=C2=A0 - size_t variable storing ssize_t return: -1 wraps to SIZE=
_MAX
>>> =C2=A0=C2=A0 - error_prepend() called without ERRP_GUARD(): NULL deref =
on short=20
>>> read
>>> Junjie Cao (4):
>>> =C2=A0=C2=A0 io/channel: introduce qio_channel_pread{v,}_all{,_eof}()
>>> =C2=A0=C2=A0 io/channel: introduce qio_channel_pwrite{v,}_all()
>>> =C2=A0=C2=A0 migration/file: fix type mismatch and NULL deref in
>>> =C2=A0=C2=A0=C2=A0=C2=A0 multifd_file_recv_data
>>> =C2=A0=C2=A0 tests/unit: add pread/pwrite _all tests for io channel file
>>>
>>> =C2=A0 include/io/channel.h=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 | 133 +++++++++++++++++++
>>> =C2=A0 io/channel.c=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
 | 139 ++++++++++++++++++++
>>> =C2=A0 migration/file.c=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 |=C2=A0 13 +-
>>> =C2=A0 tests/unit/test-io-channel-file.c | 207 ++++++++++++++++++++++++=
++++++
>>> =C2=A0 4 files changed, 486 insertions(+), 6 deletions(-)
>>=20
>> Hi!
>>=20
>> Is this a qemu-stable material?=C2=A0 The amount of new code this series
>> introduces is somewhat large, but it fixes real bugs in the end.=C2=A0 On
>> the other hand, these bugs doesn't seem to be very serious, so.. I'm
>> not sure :)
>>=20
>> How do you think, should we pick this up for the current stable releases?
>> It applies cleanly to 10.0.x (the earliest stable series currently
>> supported).
>
> For 10.0.x, it also needs two more changes to work:
>
> a5bc1ccca95 migration: simplify error reporting after channel read
> 1edf0df2840 io: Add qio_channel_wait_cond() helper
>
> Thanks,

Hi! Sorry for the delay. I don't think we need this series for
stable. It's a fairly unlikely issue.

