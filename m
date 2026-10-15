Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D7F1ACC6B34
	for <qemu-devel@archiver.kernel.org>; Thu, 15 Oct 2026 12:46:17 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xHKq6-0001kJ-Ei; Thu, 15 Oct 2026 08:45:43 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <farosas@suse.de>) id 1xHKpz-0001h2-8F
 for qemu-devel@nongnu.org; Thu, 15 Oct 2026 08:45:35 -0400
Received: from smtp-out1.suse.de ([195.135.223.130])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <farosas@suse.de>) id 1xHKpx-0000O6-7t
 for qemu-devel@nongnu.org; Thu, 15 Oct 2026 08:45:34 -0400
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org
 [IPv6:2a07:de40:b281:104:10:150:64:97])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by smtp-out1.suse.de (Postfix) with ESMTPS id 149F922174;
 Thu, 15 Oct 2026 12:45:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
 t=1792068331; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=N8UIXYh2APNWKa0hxXqKkwzVr6EnRgkKENtmOD16Jtw=;
 b=wHa1d+3oCj8wXlMc4eFcTROPju2FqcsV1YqtmQjieOYtV+XQBCU+zq5GXq/PACCMMVJbXh
 aeiIwucDtQriSeIDVO+ed1KgONbd/3iHw1W19DmVsuowaZtBQes8VEpuzDMZJzt3JU177I
 xiTq42etIQwIjNcJZccq7LrCDMYFckw=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
 s=susede2_ed25519; t=1792068331;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=N8UIXYh2APNWKa0hxXqKkwzVr6EnRgkKENtmOD16Jtw=;
 b=vtcI95fJSkLHBWvtprGFjfy02buJnCuaUi0HcnWy0r339yIoUyRQLYzaVNWRneZy3oxlrq
 HqSv7qcJT+13W2Bg==
Authentication-Results: smtp-out1.suse.de;
 dkim=pass header.d=suse.de header.s=susede2_rsa header.b=wHa1d+3o;
 dkim=pass header.d=suse.de header.s=susede2_ed25519 header.b=vtcI95fJ
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
 t=1792068331; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=N8UIXYh2APNWKa0hxXqKkwzVr6EnRgkKENtmOD16Jtw=;
 b=wHa1d+3oCj8wXlMc4eFcTROPju2FqcsV1YqtmQjieOYtV+XQBCU+zq5GXq/PACCMMVJbXh
 aeiIwucDtQriSeIDVO+ed1KgONbd/3iHw1W19DmVsuowaZtBQes8VEpuzDMZJzt3JU177I
 xiTq42etIQwIjNcJZccq7LrCDMYFckw=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
 s=susede2_ed25519; t=1792068331;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=N8UIXYh2APNWKa0hxXqKkwzVr6EnRgkKENtmOD16Jtw=;
 b=vtcI95fJSkLHBWvtprGFjfy02buJnCuaUi0HcnWy0r339yIoUyRQLYzaVNWRneZy3oxlrq
 HqSv7qcJT+13W2Bg==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id D4E9D1373D;
 Thu, 15 Oct 2026 12:45:29 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
 by imap1.dmz-prg2.suse.org with ESMTPSA id ekoTA+nK0GpZKQAAD6G6ig
 (envelope-from <farosas@suse.de>); Thu, 15 Oct 2026 12:45:29 +0000
From: Fabiano Rosas <farosas@suse.de>
To: =?utf-8?Q?Daniel_P=2E_Berrang=C3=A9?= <berrange@redhat.com>
Cc: qemu-devel@nongnu.org, peterx@redhat.com, mjt@tls.msk.ru
Subject: Re: [RFC] container images for migration-test
In-Reply-To: <atB-A09ZuRod1Qvo@redhat.com>
References: <8733vbtmge.fsf@suse.de> <asyX0JccFfG0ZMDp@redhat.com>
 <87jynkmaht.fsf@suse.de> <atB-A09ZuRod1Qvo@redhat.com>
Date: Thu, 15 Oct 2026 09:45:26 -0300
Message-ID: <871p9rm8t5.fsf@suse.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
X-Rspamd-Server: rspamd1.dmz-prg2.suse.org
X-Rspamd-Queue-Id: 149F922174
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-4.51 / 50.00]; BAYES_HAM(-3.00)[100.00%];
 NEURAL_HAM_LONG(-1.00)[-1.000];
 R_DKIM_ALLOW(-0.20)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
 NEURAL_HAM_SHORT(-0.20)[-1.000]; MIME_GOOD(-0.10)[text/plain];
 MX_GOOD(-0.01)[];
 RBL_SPAMHAUS_BLOCKED_OPENRESOLVER(0.00)[2a07:de40:b281:104:10:150:64:97:from]; 
 RCVD_VIA_SMTP_AUTH(0.00)[]; RCVD_TLS_ALL(0.00)[];
 ARC_NA(0.00)[]; MIME_TRACE(0.00)[0:+]; MISSING_XM_UA(0.00)[];
 TO_DN_SOME(0.00)[];
 RECEIVED_SPAMHAUS_BLOCKED_OPENRESOLVER(0.00)[2a07:de40:b281:106:10:150:64:167:received];
 MID_RHS_MATCH_FROM(0.00)[];
 DKIM_SIGNED(0.00)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
 FROM_EQ_ENVFROM(0.00)[]; FROM_HAS_DN(0.00)[];
 RCPT_COUNT_THREE(0.00)[4]; RCVD_COUNT_TWO(0.00)[2];
 TO_MATCH_ENVRCPT_ALL(0.00)[];
 DBL_BLOCKED_OPENRESOLVER(0.00)[suse.de:dkim,imap1.dmz-prg2.suse.org:helo,imap1.dmz-prg2.suse.org:rdns];
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

Daniel P. Berrang=C3=A9 <berrange@redhat.com> writes:

> On Wed, Oct 14, 2026 at 02:56:46PM -0300, Fabiano Rosas wrote:
>> Daniel P. Berrang=C3=A9 <berrange@redhat.com> writes:
>>=20
>> > On Mon, Sep 14, 2026 at 08:58:09PM -0300, Fabiano Rosas wrote:
>> >> Hi, I just wanted to share and ask for feedback on some container ima=
ges
>> >> I've been building as part of my testing of migration pull-requests.
>> >>=20
>> >> From a Dockerfile from ./tests/docker/dockerfiles/ I'm producing the
>> >> following:
>> >>=20
>> >> $ docker images
>> >> qemu-build-base:11.0.0                        b6efa198e93a        5.8=
GB
>> >> qemu-rootfs-base:11.0.0                       72bcb5418f4d       4.08=
GB
>> >> qemu:11.0.0                                   018a3f0f4dcc          2=
GB
>> >
>> > snip
>> >
>> >> 2) Neither the QEMU build nor the distro repos are reliable enough to
>> >> allow me to just "go back in time" and rebuild at any moment, I need =
to
>> >> keep the artifacts cached to avoid rebuilding. Otherwise it comes time
>> >> to send a PR and I discover that some python piece has changed or the
>> >> distro messed up the older repository.
>> >
>> > Yes, in general building old QEMU on new distros periodically
>> > hits trouble.  If building old QEMU, better reliability is
>> > achieved by using a distro release that was from the same
>> > timeframe as QEMU.  Is using containers targetting such old
>> > distro versions not an option ? The tests/docker/dockerfiles
>> > from the old QEMU branch ought to work ?
>> >
>>=20
>> Yes, I'm doing just that. Some tweaks are needed still. For instance, my
>> script has something like this:
>>=20
>>   dockerfile=3D"tests/docker/dockerfiles/opensuse-leap.docker"
>>=20
>>   sed -i 's/ncurses-devel//' $dockerfile
>>=20
>>   if [ "$tag" =3D "10.1.0" ]; then
>>       sed -i 's/libLLVM19//' $dockerfile
>>   fi
>
> If that's needed, shouldn't we patch the QEMU stable branch ? I
> would have thought that would be a problem for doing releases on
> stable if the containers have bugs ?
>

Right, but that's not simply regular development work touching the
dockerfiles and they sitting there just working. I see the overall
benefits of having the dependencies listed in a dockerfile under our
control, but for this particular use-case it's a bit of a pain point.

To be clear, this is not an issue I'm particularly concerned with, we
can fix it in stable or hack away in a script like I did. And issues
like this should be on the rarer side.

I'm more interested in the other part, which is having some infra that
can take whatever base image and produce a container that's standin for
the actual qemu binary. This allows quick switching of QEMU release
versions for testing and debugging and keeps the migration testing
concerns separate.

>> > How far back in time do you need/want to go for migration
>> > testing ?  Is it sufficient to merely target versions for
>> > which mjt is still doing active maint work, so we can
>> > expect the containers to still work.
>> >
>>=20
>> I'm currently testing against the previous 3 releases. I think 2
>> releases is probably enough.
>
> I guess if we test   X -> Y and then later test Y -> Z, then
> we have transitively validated X -> Z. So in theory only 1
> historical release is enough, but it makes sense to test one
> or two more variants just in case.
>

Yes, but sometimes we have weird compatibility knobs, I feel more
comfortable with more testing. They're quick tests, it's not too much
work. I usually run migration-test (small set) for every PR with:

x86_64: dev -> X, dev -> X-1, dev -> X-2
        dev <- X, dev <- X-1, dev <- X-2

s390x: dev -> X, dev -> X-1
       dev <- X, dev <- X-1

pcc64le: dev -> X
         dev <- X

But there's also testing in the sense of working with bug reports,
debugging and development in general. So having a few versions available
improves productivity.

> With regards,
> Daniel

