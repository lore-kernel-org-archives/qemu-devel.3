Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E0208E64A8B
	for <qemu-devel@archiver.kernel.org>; Tue,  3 Dec 2024 13:17:05 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tISl6-0007Eu-4V; Tue, 03 Dec 2024 08:16:08 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <farosas@suse.de>) id 1tISl4-0007Eh-VL
 for qemu-devel@nongnu.org; Tue, 03 Dec 2024 08:16:06 -0500
Received: from smtp-out1.suse.de ([2a07:de40:b251:101:10:150:64:1])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <farosas@suse.de>) id 1tISl1-0006dH-9Y
 for qemu-devel@nongnu.org; Tue, 03 Dec 2024 08:16:06 -0500
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org
 [IPv6:2a07:de40:b281:104:10:150:64:97])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by smtp-out1.suse.de (Postfix) with ESMTPS id 8408221163;
 Tue,  3 Dec 2024 13:16:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
 t=1733231760; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=smkcyhocGxL/eHfKIZQX5fzPdkQfTROvgOtFerQ72E4=;
 b=qJRHf8hadk0s6dGvCkpcqCftRTeIeGbUpW9oWEQi1SXMFJWhIqfYXddLxJXdgc37EBnM8A
 ZyUTPTZZhna/2PuCuHmH+ZQo9xm6LQJ0X38RkkUxFWTWBZxWF+J7zz0NlzqfeoNDurYgH7
 3b2eEhpxqro844DYLbr1TAspb+r56e4=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
 s=susede2_ed25519; t=1733231760;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=smkcyhocGxL/eHfKIZQX5fzPdkQfTROvgOtFerQ72E4=;
 b=ZuOsqPjhpUeNCeSjXJA0t78ebEvv13akPnEsgPbutuQiXcFGLp4+lVCkIeRqsghskgwsb+
 nNMRanO/27DFZIBA==
Authentication-Results: smtp-out1.suse.de;
 dkim=pass header.d=suse.de header.s=susede2_rsa header.b=qJRHf8ha;
 dkim=pass header.d=suse.de header.s=susede2_ed25519 header.b=ZuOsqPjh
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
 t=1733231760; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=smkcyhocGxL/eHfKIZQX5fzPdkQfTROvgOtFerQ72E4=;
 b=qJRHf8hadk0s6dGvCkpcqCftRTeIeGbUpW9oWEQi1SXMFJWhIqfYXddLxJXdgc37EBnM8A
 ZyUTPTZZhna/2PuCuHmH+ZQo9xm6LQJ0X38RkkUxFWTWBZxWF+J7zz0NlzqfeoNDurYgH7
 3b2eEhpxqro844DYLbr1TAspb+r56e4=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
 s=susede2_ed25519; t=1733231760;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=smkcyhocGxL/eHfKIZQX5fzPdkQfTROvgOtFerQ72E4=;
 b=ZuOsqPjhpUeNCeSjXJA0t78ebEvv13akPnEsgPbutuQiXcFGLp4+lVCkIeRqsghskgwsb+
 nNMRanO/27DFZIBA==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 0BC80139C2;
 Tue,  3 Dec 2024 13:15:59 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
 by imap1.dmz-prg2.suse.org with ESMTPSA id qVsUMY8ET2c4HAAAD6G6ig
 (envelope-from <farosas@suse.de>); Tue, 03 Dec 2024 13:15:59 +0000
From: Fabiano Rosas <farosas@suse.de>
To: =?utf-8?Q?Daniel_P=2E_Berrang=C3=A9?= <berrange@redhat.com>
Cc: Peter Xu <peterx@redhat.com>, Yong Huang <yong.huang@smartx.com>,
 qemu-devel@nongnu.org
Subject: Re: [PATCH v3 0/5] Guestperf: miscellaneous refinement and enrichment
In-Reply-To: <Z075-ZPW9dzzCKJn@redhat.com>
References: <cover.1729562974.git.yong.huang@smartx.com>
 <87sesmdfl4.fsf@suse.de>
 <CAK9dgmZvj4W2EBxp1_TcdYs3q2aqaRZGZCAk=FRJk-PaB9y_fw@mail.gmail.com>
 <87v7w6jkc9.fsf@suse.de> <87plmejgtb.fsf@suse.de>
 <CAK9dgmbHL+O34+E3ykDdAunap+Ruubm7ysisrMags6TN25BiNQ@mail.gmail.com>
 <Z04PTe4kCVWEQbPL@x1n> <Z06866qR0z9n2BgP@redhat.com>
 <875xo1j6ub.fsf@suse.de> <Z075-ZPW9dzzCKJn@redhat.com>
Date: Tue, 03 Dec 2024 10:15:57 -0300
Message-ID: <8734j4kiuq.fsf@suse.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
X-Rspamd-Queue-Id: 8408221163
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-4.51 / 50.00]; BAYES_HAM(-3.00)[100.00%];
 NEURAL_HAM_LONG(-1.00)[-1.000];
 R_DKIM_ALLOW(-0.20)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
 NEURAL_HAM_SHORT(-0.20)[-1.000]; MIME_GOOD(-0.10)[text/plain];
 MX_GOOD(-0.01)[]; ARC_NA(0.00)[];
 ASN(0.00)[asn:25478, ipnet:::/0, country:RU];
 MISSING_XM_UA(0.00)[]; RCVD_VIA_SMTP_AUTH(0.00)[];
 TO_DN_SOME(0.00)[]; MIME_TRACE(0.00)[0:+];
 RCVD_TLS_ALL(0.00)[]; FUZZY_BLOCKED(0.00)[rspamd.com];
 RCPT_COUNT_THREE(0.00)[4]; FROM_EQ_ENVFROM(0.00)[];
 FROM_HAS_DN(0.00)[]; MID_RHS_MATCH_FROM(0.00)[];
 RCVD_COUNT_TWO(0.00)[2]; TO_MATCH_ENVRCPT_ALL(0.00)[];
 DBL_BLOCKED_OPENRESOLVER(0.00)[imap1.dmz-prg2.suse.org:rdns,imap1.dmz-prg2.suse.org:helo,suse.de:dkim,suse.de:mid,suse.de:email];
 DKIM_SIGNED(0.00)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
 DKIM_TRACE(0.00)[suse.de:+]
X-Rspamd-Server: rspamd1.dmz-prg2.suse.org
Received-SPF: pass client-ip=2a07:de40:b251:101:10:150:64:1;
 envelope-from=farosas@suse.de; helo=smtp-out1.suse.de
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

> On Tue, Dec 03, 2024 at 09:20:44AM -0300, Fabiano Rosas wrote:
>> Daniel P. Berrang=C3=A9 <berrange@redhat.com> writes:
>>=20
>> > On Mon, Dec 02, 2024 at 02:49:33PM -0500, Peter Xu wrote:
>> >> On Sat, Nov 30, 2024 at 10:01:43PM +0800, Yong Huang wrote:
>> >> > On Fri, Nov 29, 2024 at 9:44=E2=80=AFPM Fabiano Rosas <farosas@suse=
.de> wrote:
>> >> For the stress.c warnings/error, I saw another one warning with gcc w=
hen
>> >> built it locally, then I found Fabiano's CI run also has it:
>> >>=20
>> >> https://gitlab.com/farosas/qemu/-/jobs/8504697347
>> >>=20
>> >> Which has:
>> >>=20
>> >> [3381/3611] Linking target tests/migration/stress
>> >> /usr/bin/ld: /usr/lib64/libglib-2.0.a(gutils.c.o): in function `g_get=
_user_database_entry':
>> >> (.text+0xeb): warning: Using 'getpwnam_r' in statically linked applic=
ations requires at runtime the shared libraries from the glibc version used=
 for linkign
>> >> /usr/bin/ld: (.text+0x2be): warning: Using 'getpwuid' in statically l=
inked applications requires at runtime the shared libraries from the glibc =
version used for linking
>> >> /usr/bin/ld: (.text+0x134): warning: Using 'getpwuid_r' in statically=
 linked applications requires at runtime the shared libraries from the glib=
c version used for linking
>> >>=20
>> >> Feel free to look at it too if you like. Nothing should be relevant t=
o your
>> >> changes, so I think it could be there for a while when compilers upgr=
ade.
>> >
>> > Those messages are mostly harmless, especially in the stress scenario,=
 and
>> > can't practically be eliminated:
>> >
>> >   https://gitlab.gnome.org/GNOME/glib/-/issues/2019
>>=20
>> Although harmless, we can't have them showing up during the
>> build. Should we go back to not building stress.c by default? Another
>> option (which I prefer) would be to stop using glib in stress.c, it
>> doesn't look like it would be much work to do that.=20
>
> FYI they already show up in QEMU builds if you are building qemu-user as
> static binaries, which is what you want for binfmt usage.  The main
> diff is that in this case they'll show up by default for anyone who has
> glib-static available.  Is that a big problem ?

We shouldn't be adding warnings to the build like that. When building
static binaries, I'd assume the person at least knows there's a -static
in there somewhere. If you're just building the system binaries and
warnings start to show up, that's not good. Since this is just a side
script that's very infrequently used, I don't think it justifies the
extra warning.

Maybe let's see what the other build issues were, I'm guessing it will
be more work to fix them than to disable stress.c build again.

>
>
> With regards,
> Daniel

