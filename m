Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3A6FDC46CD2
	for <qemu-devel@archiver.kernel.org>; Tue, 30 Jan 2024 21:23:48 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rUvZi-0004IZ-3b; Tue, 30 Jan 2024 16:23:22 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <farosas@suse.de>) id 1rUvZg-0004IC-0i
 for qemu-devel@nongnu.org; Tue, 30 Jan 2024 16:23:20 -0500
Received: from smtp-out1.suse.de ([2a07:de40:b251:101:10:150:64:1])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <farosas@suse.de>) id 1rUvZe-0000hG-CD
 for qemu-devel@nongnu.org; Tue, 30 Jan 2024 16:23:19 -0500
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org
 [IPv6:2a07:de40:b281:104:10:150:64:97])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by smtp-out1.suse.de (Postfix) with ESMTPS id CB7CF21FF2;
 Tue, 30 Jan 2024 21:23:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
 t=1706649794; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=zHD70FwEK1mSunn8fvIj42vJ73Z+QkeAnnuVM5pMyAg=;
 b=SifIFYYmH717TL9xSJ2yviW2lUVECA+6Mk81JUK+LkQCIhUuuLm7F05Avx71qpTu9im3JS
 TGuGwRP461WVkf9i9d3RtUGFIL5Asjm0dOdMnXvH4qAKmZf+XzYPV7Pj1SKOT8w2IJIc5h
 obEgucxt1eBW3M9mqdUQe3IuA/N9NCY=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
 s=susede2_ed25519; t=1706649794;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=zHD70FwEK1mSunn8fvIj42vJ73Z+QkeAnnuVM5pMyAg=;
 b=camGePN5E27pbxEP+L5m5W686zO+F+TZaT7W+Nx3Gz/n//aNQK/AiLhT/R1AJs6yAwCfY9
 4NWrDN8De6pKJQDw==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
 t=1706649793; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=zHD70FwEK1mSunn8fvIj42vJ73Z+QkeAnnuVM5pMyAg=;
 b=po1Afzy3bArVKkdTl87WjhVYOJDcr1Nl9Ii6y8WXfoNgmYew6umLFYyIRU1xYFYrwTPr8H
 FX2cyyr/wT7MEgE4QBcvJGjN8jA+qx9l2/7mHTYs3AaiGoP4Pq3Pke2PEkWzDY5/Bp6MaW
 ir9Sv5xKFbW+WxnjWZpdE28CvgJhgnU=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
 s=susede2_ed25519; t=1706649793;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=zHD70FwEK1mSunn8fvIj42vJ73Z+QkeAnnuVM5pMyAg=;
 b=YQFhk1k4d4sD2k5e1mD4zy31wiSPf5wrVMTv6Za9+q3jZFu6xT41Ka0WlXJz9tvGphQs64
 a65vI+hknnWFTuAw==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 4C77812FF7;
 Tue, 30 Jan 2024 21:23:13 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
 by imap1.dmz-prg2.suse.org with ESMTPSA id a2dDBcFouWW9SAAAD6G6ig
 (envelope-from <farosas@suse.de>); Tue, 30 Jan 2024 21:23:13 +0000
From: Fabiano Rosas <farosas@suse.de>
To: Peter Xu <peterx@redhat.com>, Peter Maydell <peter.maydell@linaro.org>
Cc: qemu-devel@nongnu.org
Subject: Re: [PULL 06/15] tests/qtest/migration: Don't use -cpu max for aarch64
In-Reply-To: <ZbjT5OYpzNJjkMw9@x1n>
References: <20240126041725.124562-1-peterx@redhat.com>
 <20240126041725.124562-7-peterx@redhat.com> <87le8c6u1d.fsf@suse.de>
 <CAFEAcA-x4WqvPsN-KZOA3SPN0F=vvYi=NFZ2qom2iT7-CN0RSg@mail.gmail.com>
 <87il3g6t7b.fsf@suse.de> <ZbcSqyGNLGu7ugBb@x1n> <87sf2ge3qu.fsf@suse.de>
 <87y1c7ogze.fsf@suse.de>
 <CAFEAcA_BPf4LSh-JF1NVVVdaLoKgUcsnGeP7sHt-f73r4zyh7g@mail.gmail.com>
 <ZbjT5OYpzNJjkMw9@x1n>
Date: Tue, 30 Jan 2024 18:23:10 -0300
Message-ID: <87wmrqbjnl.fsf@suse.de>
MIME-Version: 1.0
Content-Type: text/plain
Authentication-Results: smtp-out1.suse.de;
 dkim=pass header.d=suse.de header.s=susede2_rsa header.b=po1Afzy3;
 dkim=pass header.d=suse.de header.s=susede2_ed25519 header.b=YQFhk1k4
X-Spamd-Result: default: False [-3.31 / 50.00]; ARC_NA(0.00)[];
 RCVD_VIA_SMTP_AUTH(0.00)[];
 R_DKIM_ALLOW(-0.20)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
 SPAMHAUS_XBL(0.00)[2a07:de40:b281:104:10:150:64:97:from];
 FROM_HAS_DN(0.00)[]; RCPT_COUNT_THREE(0.00)[3];
 TO_DN_SOME(0.00)[]; TO_MATCH_ENVRCPT_ALL(0.00)[];
 MIME_GOOD(-0.10)[text/plain]; BAYES_HAM(-3.00)[100.00%];
 RCVD_COUNT_THREE(0.00)[3];
 DKIM_SIGNED(0.00)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
 DKIM_TRACE(0.00)[suse.de:+]; MX_GOOD(-0.01)[];
 DBL_BLOCKED_OPENRESOLVER(0.00)[suse.de:dkim,suse.de:email];
 FUZZY_BLOCKED(0.00)[rspamd.com]; FROM_EQ_ENVFROM(0.00)[];
 MIME_TRACE(0.00)[0:+]; RCVD_TLS_ALL(0.00)[];
 MID_RHS_MATCH_FROM(0.00)[]
X-Rspamd-Server: rspamd1.dmz-prg2.suse.org
X-Rspamd-Queue-Id: CB7CF21FF2
Received-SPF: pass client-ip=2a07:de40:b251:101:10:150:64:1;
 envelope-from=farosas@suse.de; helo=smtp-out1.suse.de
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

> On Tue, Jan 30, 2024 at 10:18:07AM +0000, Peter Maydell wrote:
>> On Mon, 29 Jan 2024 at 23:31, Fabiano Rosas <farosas@suse.de> wrote:
>> >
>> > Fabiano Rosas <farosas@suse.de> writes:
>> >
>> > > Peter Xu <peterx@redhat.com> writes:
>> > >
>> > >> On Fri, Jan 26, 2024 at 11:54:32AM -0300, Fabiano Rosas wrote:
>> > > The issue that occurs to me now is that 'cpu host' will not work with
>> > > TCG. We might actually need to go poking /dev/kvm for this to work.
>> >
>> > Nevermind this last part. There's not going to be a scenario where we
>> > build with CONFIG_KVM, but run in an environment that does not support
>> > KVM.
>> 
>> Yes, there is. We'll build with CONFIG_KVM on any aarch64 host,
>> but that doesn't imply that the user running the build and
>> test has permissions for /dev/kvm.
>
> I'm actually pretty confused on why this would be a problem even for
> neoverse-n1: can we just try to use KVM, if it fails then use TCG?
> Something like:
>
>   (construct qemu cmdline)
>   ..
> #ifdef CONFIG_KVM

>   "-accel kvm "
> #endif
>   "-accel tcg "
>   ..
>
> ?
> IIUC if we specify two "-accel", we'll try the first, then if failed then
> the 2nd?

Aside from '-cpu max', there's no -accel and -cpu combination that works
on all of:

x86_64 host - TCG-only
aarch64 host - KVM & TCG
aarch64 host with --disable-tcg - KVM-only
aarch64 host without access to /dev/kvm - TCG-only

And the cpus are:
host - KVM-only
neoverse-n1 - TCG-only

We'll need something like:

/* covers aarch64 host with --disable-tcg */
if (qtest_has_accel("kvm") && !qtest_has_accel("tcg")) {
   if (open("/dev/kvm", O_RDONLY) < 0) {
       g_test_skip()
   } else {
       "-accel kvm -cpu host"
   }
}

/* covers x86_64 host */
if (!qtest_has_accel("kvm") && qtest_has_accel("tcg")) {
   "-accel tcg -cpu neoverse-n1"
}

/* covers aarch64 host */
if (qtest_has_accel("kvm") && qtest_has_accel("tcg")) {
   if (open("/dev/kvm", O_RDONLY) < 0) {
      "-accel tcg -cpu neoverse-n1"
   } else {
      "-accel kvm -cpu host"
   }
}

