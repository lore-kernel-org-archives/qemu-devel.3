Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6C4DDE77187
	for <qemu-devel@archiver.kernel.org>; Wed, 18 Dec 2024 19:21:24 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tNzbW-0004Xt-Kf; Wed, 18 Dec 2024 14:21:06 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <farosas@suse.de>) id 1tNzbH-0004UG-FS
 for qemu-devel@nongnu.org; Wed, 18 Dec 2024 14:20:53 -0500
Received: from smtp-out2.suse.de ([2a07:de40:b251:101:10:150:64:2])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <farosas@suse.de>) id 1tNzbD-00029N-Ay
 for qemu-devel@nongnu.org; Wed, 18 Dec 2024 14:20:49 -0500
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org
 [IPv6:2a07:de40:b281:104:10:150:64:97])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by smtp-out2.suse.de (Postfix) with ESMTPS id EFD7E1F397;
 Wed, 18 Dec 2024 19:20:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
 t=1734549644; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=ZmjRKjrq0iLTZMOjaTLY6Zw8s5+hMK1EHoP4LxiHpYQ=;
 b=z5J3RTjYJbbYc38ViMKueUtnm4R4IAdFVcsmr01hfyH5BzWhsp5fCONecfC4zEKDZ7zlBT
 LONab+0uTtEqYY5TaugUtGm0Vav2ynB/SEB8RJVTJf91vmbw+V9kLGNZIpe4z/0saXvAL2
 QspXfVBWoZS7TKZRgbwepTZYiQVz8eI=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
 s=susede2_ed25519; t=1734549644;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=ZmjRKjrq0iLTZMOjaTLY6Zw8s5+hMK1EHoP4LxiHpYQ=;
 b=ah97UfYTjUEUecOSnCg1LyaDyNheCsMFEHl7/P19mtYPnhkAKnmv1fdM5PE06RerF+cnTc
 3fwyVVsDmTI3QvBw==
Authentication-Results: smtp-out2.suse.de;
 dkim=pass header.d=suse.de header.s=susede2_rsa header.b=j0u+3vlU;
 dkim=pass header.d=suse.de header.s=susede2_ed25519 header.b=uBs6WHRX
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
 t=1734549643; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=ZmjRKjrq0iLTZMOjaTLY6Zw8s5+hMK1EHoP4LxiHpYQ=;
 b=j0u+3vlUAgJ07zqnG1mOgpmpdvjKsYgGg0Db+DEcx+5yi3ocs3fGw/4TYApgzGEwRHJCB+
 x1XRS8Se/TiiWVZVT9DgFFpYbeb4cqmGEjD7e3YfhR2/faySGDtKMAyGV5R7ql9otoJsit
 olWVlkRChke8LDus2KRe6BqA00zdq4Q=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
 s=susede2_ed25519; t=1734549643;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=ZmjRKjrq0iLTZMOjaTLY6Zw8s5+hMK1EHoP4LxiHpYQ=;
 b=uBs6WHRXl/zTWQVBcnqjIyNkgTnzfnSIyzKwe8XIgiW6v9eJ3x0vT81x1dyJ038U+LxJN0
 /ZISLzGxG6/EwIBA==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 6E6CC132EA;
 Wed, 18 Dec 2024 19:20:43 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
 by imap1.dmz-prg2.suse.org with ESMTPSA id gOFwDYsgY2eAewAAD6G6ig
 (envelope-from <farosas@suse.de>); Wed, 18 Dec 2024 19:20:43 +0000
From: Fabiano Rosas <farosas@suse.de>
To: =?utf-8?Q?Daniel_P=2E_Berrang=C3=A9?= <berrange@redhat.com>
Cc: Peter Xu <peterx@redhat.com>, qemu-devel@nongnu.org
Subject: Re: [PATCH] tests/qtest/migration: Restore include for postcopy
In-Reply-To: <Z2L2syGHfm923PRP@redhat.com>
References: <20241217212201.23376-1-farosas@suse.de> <Z2Hxe0PyVACaKIlZ@x1n>
 <Z2KGUnQIcxZNohzi@redhat.com> <87ldwduit0.fsf@suse.de>
 <Z2L2syGHfm923PRP@redhat.com>
Date: Wed, 18 Dec 2024 16:20:40 -0300
Message-ID: <87bjx8vlvb.fsf@suse.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
X-Rspamd-Queue-Id: EFD7E1F397
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-4.51 / 50.00]; BAYES_HAM(-3.00)[100.00%];
 NEURAL_HAM_LONG(-1.00)[-1.000];
 R_DKIM_ALLOW(-0.20)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
 NEURAL_HAM_SHORT(-0.20)[-1.000]; MIME_GOOD(-0.10)[text/plain];
 MX_GOOD(-0.01)[]; RCVD_VIA_SMTP_AUTH(0.00)[]; ARC_NA(0.00)[];
 RBL_SPAMHAUS_BLOCKED_OPENRESOLVER(0.00)[2a07:de40:b281:104:10:150:64:97:from]; 
 RCVD_TLS_ALL(0.00)[]; MIME_TRACE(0.00)[0:+];
 MISSING_XM_UA(0.00)[];
 SPAMHAUS_XBL(0.00)[2a07:de40:b281:104:10:150:64:97:from];
 TO_DN_SOME(0.00)[];
 RECEIVED_SPAMHAUS_BLOCKED_OPENRESOLVER(0.00)[2a07:de40:b281:106:10:150:64:167:received];
 MID_RHS_MATCH_FROM(0.00)[]; FUZZY_BLOCKED(0.00)[rspamd.com];
 FROM_EQ_ENVFROM(0.00)[]; FROM_HAS_DN(0.00)[];
 RCPT_COUNT_THREE(0.00)[3]; RCVD_COUNT_TWO(0.00)[2];
 TO_MATCH_ENVRCPT_ALL(0.00)[];
 DBL_BLOCKED_OPENRESOLVER(0.00)[suse.de:dkim,suse.de:mid,suse.de:email,imap1.dmz-prg2.suse.org:rdns,imap1.dmz-prg2.suse.org:helo];
 DKIM_SIGNED(0.00)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
 DKIM_TRACE(0.00)[suse.de:+]
X-Rspamd-Server: rspamd1.dmz-prg2.suse.org
Received-SPF: pass client-ip=2a07:de40:b251:101:10:150:64:2;
 envelope-from=farosas@suse.de; helo=smtp-out2.suse.de
X-Spam_score_int: -27
X-Spam_score: -2.8
X-Spam_bar: --
X-Spam_report: (-2.8 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_LOW=-0.7, SPF_HELO_NONE=0.001,
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

Daniel P. Berrang=C3=A9 <berrange@redhat.com> writes:

> On Wed, Dec 18, 2024 at 12:12:11PM -0300, Fabiano Rosas wrote:
>> Daniel P. Berrang=C3=A9 <berrange@redhat.com> writes:
>>=20
>> > On Tue, Dec 17, 2024 at 04:47:39PM -0500, Peter Xu wrote:
>> >> On Tue, Dec 17, 2024 at 06:22:01PM -0300, Fabiano Rosas wrote:
>> >> > Commit 124a3c58b8 ("tests/qtest/migration: Move ufd_version_check to
>> >> > utils") moved the ufd_version_check() function to another file but
>> >> > failed to bring along the <sys/syscall> include, which is necessary=
 to
>> >> > pull in <asm/unistd.h> for __NR_userfaultd.
>> >> >=20
>> >> > Restore the missing include.
>> >>=20
>> >> Ohhhhhhh.. so postcopy tests will always be skipped as of now?  Maybe=
 worth
>> >> explicit mention that in the commit message if so, only when you merg=
e.
>> >>=20
>> >> >=20
>> >> > While here, remove the ifdef __linux__ that's redundant and fix a
>> >> > couple of typos.
>> >> >=20
>> >> > Fixes: 124a3c58b8 ("tests/qtest/migration: Move ufd_version_check t=
o utils")
>> >> > Signed-off-by: Fabiano Rosas <farosas@suse.de>
>> >>=20
>> >> Reviewed-by: Peter Xu <peterx@redhat.com>
>> >>=20
>> >> Maybe we don't need to be as careful on old kernels anymore especiall=
y in
>> >> tests, because userfaultfd syscall existed for ~10 years. So if we wa=
nt we
>> >> can start requiring __NR_userfaultfd present for __linux__, then no w=
ay to
>> >> miss such spot next time.
>> >
>> > Yes, I think that check is obsolete, based on our supported platforms
>> > list. It would suffice to just check __linux__.
>>=20
>> This breaks the cross builds. It seems the __NR_userfaultfd was actually
>> stopping several archs from reaching ufd_version_check(). Since
>> <sys/ioctl.h> is under HOST_X86_64, these new instances now fail to find
>> the 'ioctl' symbol:
>>=20
>> https://gitlab.com/farosas/qemu/-/pipelines/1594332399
>>=20
>> Of course I could just include <sys/ioctl.h> unconditionally, but the
>> fact that new code is not being built means the assumption that we can
>> imply __NR_userfaultfd from __linux__ alone is not correct.
>
> I think removing __NR_userfaultfd is still correct. The problem is that
> the ufd_version_check code is wrapped in a conditional that is not the
> same as the conditional that pulls in ioctl.h. That pre-existing bug
> should be fixed regardless, and once that's done, removing __NR_userfault=
fd
> wouldn't be an issue.

Ah, the <sys/ioctl.h> include used to be under the userfaultfd ifdefs. I
got confused because kvm_dirty_ring_supported() also needs the ioctl and
it was introduced without moving the ioctl to a common ifdef.

>
> With regards,
> Daniel

