Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 577C1E64A85
	for <qemu-devel@archiver.kernel.org>; Tue,  3 Dec 2024 12:21:17 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tIRtd-0003Tl-QS; Tue, 03 Dec 2024 07:20:53 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <farosas@suse.de>) id 1tIRtc-0003TI-4r
 for qemu-devel@nongnu.org; Tue, 03 Dec 2024 07:20:52 -0500
Received: from smtp-out2.suse.de ([2a07:de40:b251:101:10:150:64:2])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <farosas@suse.de>) id 1tIRta-00077y-9c
 for qemu-devel@nongnu.org; Tue, 03 Dec 2024 07:20:51 -0500
Received: from imap1.dmz-prg2.suse.org (unknown [10.150.64.97])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by smtp-out2.suse.de (Postfix) with ESMTPS id DC3CC1F445;
 Tue,  3 Dec 2024 12:20:47 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
 t=1733228448; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=XPT0VQpyim30XrqbiJF5XjnfgfiRaPqibvHaxUJDHWQ=;
 b=DZLxYjExv7/TgDm5KJJrMp0Qr5TNKttOJMKuN6o1nkDVHYBKdz8vAet5v2uL9GzplTCUVN
 NHEJVH4+ckYaL4Q1IKrPcowRlyBnyAeB/KzsXfy/WBNcBTKRLD2OrzOF0sQF02hK9cCGsE
 AlcJE5Qb4xm3DvfFX9AphI8cs61vCIk=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
 s=susede2_ed25519; t=1733228448;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=XPT0VQpyim30XrqbiJF5XjnfgfiRaPqibvHaxUJDHWQ=;
 b=1obVTjHrMJtcUMxdcoWO4TVu308Dx91cqdHS/UlgyK852S5zwAiaplEgZsweLO7fKT7D1A
 d6JLsV54Ez8Uq9CA==
Authentication-Results: smtp-out2.suse.de;
	none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
 t=1733228447; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=XPT0VQpyim30XrqbiJF5XjnfgfiRaPqibvHaxUJDHWQ=;
 b=y+tKGiv7CIpxBEYTmhf9Q8Og7nDNRmIylvrKW8ShKuoHR6gR/YPzfR+m8em1vxsT3eNE8f
 eB+EE8poML3tZLgvfuB1nWbbMjsVOlRXhNFmjGUZg/pEVbXTFrhsvLPPzLE7tz6as46Ugv
 /BHNP5iTEv7Kd4udIEpbrXnvRotRCH0=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
 s=susede2_ed25519; t=1733228447;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=XPT0VQpyim30XrqbiJF5XjnfgfiRaPqibvHaxUJDHWQ=;
 b=S93MAcHJpHahj5RRa1tl/1O92W5G5JLQ35yNt/WvGcv2sU+wfh1zJ/X9uNne7dczgOsKcN
 9KFEopoy0+AXVCDw==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 61DA213A15;
 Tue,  3 Dec 2024 12:20:47 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
 by imap1.dmz-prg2.suse.org with ESMTPSA id f20zCp/3TmdPCQAAD6G6ig
 (envelope-from <farosas@suse.de>); Tue, 03 Dec 2024 12:20:47 +0000
From: Fabiano Rosas <farosas@suse.de>
To: =?utf-8?Q?Daniel_P=2E_Berrang=C3=A9?= <berrange@redhat.com>, Peter Xu
 <peterx@redhat.com>
Cc: Yong Huang <yong.huang@smartx.com>, qemu-devel@nongnu.org
Subject: Re: [PATCH v3 0/5] Guestperf: miscellaneous refinement and enrichment
In-Reply-To: <Z06866qR0z9n2BgP@redhat.com>
References: <cover.1729562974.git.yong.huang@smartx.com>
 <87sesmdfl4.fsf@suse.de>
 <CAK9dgmZvj4W2EBxp1_TcdYs3q2aqaRZGZCAk=FRJk-PaB9y_fw@mail.gmail.com>
 <87v7w6jkc9.fsf@suse.de> <87plmejgtb.fsf@suse.de>
 <CAK9dgmbHL+O34+E3ykDdAunap+Ruubm7ysisrMags6TN25BiNQ@mail.gmail.com>
 <Z04PTe4kCVWEQbPL@x1n> <Z06866qR0z9n2BgP@redhat.com>
Date: Tue, 03 Dec 2024 09:20:44 -0300
Message-ID: <875xo1j6ub.fsf@suse.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
X-Spamd-Result: default: False [-4.30 / 50.00]; BAYES_HAM(-3.00)[99.99%];
 NEURAL_HAM_LONG(-1.00)[-1.000];
 NEURAL_HAM_SHORT(-0.20)[-1.000]; MIME_GOOD(-0.10)[text/plain];
 ARC_NA(0.00)[]; RCVD_VIA_SMTP_AUTH(0.00)[];
 MISSING_XM_UA(0.00)[]; MIME_TRACE(0.00)[0:+];
 MID_RHS_MATCH_FROM(0.00)[]; RCVD_TLS_ALL(0.00)[];
 DKIM_SIGNED(0.00)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
 FUZZY_BLOCKED(0.00)[rspamd.com]; FROM_HAS_DN(0.00)[];
 TO_DN_SOME(0.00)[]; FROM_EQ_ENVFROM(0.00)[];
 TO_MATCH_ENVRCPT_ALL(0.00)[]; RCVD_COUNT_TWO(0.00)[2];
 RCPT_COUNT_THREE(0.00)[4]
Received-SPF: pass client-ip=2a07:de40:b251:101:10:150:64:2;
 envelope-from=farosas@suse.de; helo=smtp-out2.suse.de
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
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

> On Mon, Dec 02, 2024 at 02:49:33PM -0500, Peter Xu wrote:
>> On Sat, Nov 30, 2024 at 10:01:43PM +0800, Yong Huang wrote:
>> > On Fri, Nov 29, 2024 at 9:44=E2=80=AFPM Fabiano Rosas <farosas@suse.de=
> wrote:
>> For the stress.c warnings/error, I saw another one warning with gcc when
>> built it locally, then I found Fabiano's CI run also has it:
>>=20
>> https://gitlab.com/farosas/qemu/-/jobs/8504697347
>>=20
>> Which has:
>>=20
>> [3381/3611] Linking target tests/migration/stress
>> /usr/bin/ld: /usr/lib64/libglib-2.0.a(gutils.c.o): in function `g_get_us=
er_database_entry':
>> (.text+0xeb): warning: Using 'getpwnam_r' in statically linked applicati=
ons requires at runtime the shared libraries from the glibc version used fo=
r linkign
>> /usr/bin/ld: (.text+0x2be): warning: Using 'getpwuid' in statically link=
ed applications requires at runtime the shared libraries from the glibc ver=
sion used for linking
>> /usr/bin/ld: (.text+0x134): warning: Using 'getpwuid_r' in statically li=
nked applications requires at runtime the shared libraries from the glibc v=
ersion used for linking
>>=20
>> Feel free to look at it too if you like. Nothing should be relevant to y=
our
>> changes, so I think it could be there for a while when compilers upgrade.
>
> Those messages are mostly harmless, especially in the stress scenario, and
> can't practically be eliminated:
>
>   https://gitlab.gnome.org/GNOME/glib/-/issues/2019

Although harmless, we can't have them showing up during the
build. Should we go back to not building stress.c by default? Another
option (which I prefer) would be to stop using glib in stress.c, it
doesn't look like it would be much work to do that.=20


