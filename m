Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 766C6CD4F54
	for <qemu-devel@archiver.kernel.org>; Sun, 24 May 2026 06:32:42 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wR2NJ-0007JT-98; Sun, 24 May 2026 02:31:49 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1wR2NH-0007JK-Vk
 for qemu-devel@nongnu.org; Sun, 24 May 2026 02:31:47 -0400
Received: from mail-wm1-x332.google.com ([2a00:1450:4864:20::332])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1wR2NG-0001em-1y
 for qemu-devel@nongnu.org; Sun, 24 May 2026 02:31:47 -0400
Received: by mail-wm1-x332.google.com with SMTP id
 5b1f17b1804b1-48984d29fe3so89728995e9.0
 for <qemu-devel@nongnu.org>; Sat, 23 May 2026 23:31:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1779604301; x=1780209101; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:message-id:date:user-agent
 :references:in-reply-to:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=sAmpfgR1pjFqsWmOx5LxG0WHu8bnS6ca/Nka3ZnLDfI=;
 b=Nr3UCdFZMWTMJQDJc/ILZyarK+chf7Go53dLSw1b2JCZ4YbL9glEeMYWYkRp4oVrPg
 Oojtjf19r9DccgHZC7lZDN7xVeHj+Z+ucb2wvLpmO/gBXLe+WUmTaV9XSHq9jEoB0q+c
 ry7S/uW/5WJeiOs4u/WP3drGQcNYmbOX0mWdt6IUyoB6CG6lPWyMtitBr9dbi+u91I+S
 JWCiYOJFIcwjSfwdWtc+Umu1I3VBGElzO0+gfiS0sVAyggZSsjC46tEKQnCw5a/4LhBC
 dUsG3zWkefVTGCShJxMMvyFQBos+UDXZWpw1G2J4TrcjeHhNnq9bszmzAqkG+zMbiyfy
 rtwA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1779604301; x=1780209101;
 h=content-transfer-encoding:mime-version:message-id:date:user-agent
 :references:in-reply-to:subject:cc:to:from:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=sAmpfgR1pjFqsWmOx5LxG0WHu8bnS6ca/Nka3ZnLDfI=;
 b=cCkOtR+s6RPoesunsWv8l+oG3bqFSw1VvQUpFJi8Hgu7IhtS+8q9nC8zoDMf7DsMYa
 SAOWBKdXKsjkaZp7DKU5hexnRvxFyR1sPAohBLH/2rGyoZUzT9Tn4LhGlJlGcEzDEJ+G
 VZMvp4FloHeTji/1YH6o9rcSIKUCs3jo4eUuQ1ohS1YOxviyMbFMamH1CbwKuALFeB42
 qs6YNUyQ4cj8aQTLLz8VhGfAFy/TQXKCI9al6ih8Tc6kNwbF+HrqiC7gIjse7samWSR+
 2zXpL2uf1THh1eQPZRb6Z9Cu0DgxZyOMQDKlcXlztptom2gmrTtXYTXswuF3RD6iKkjL
 tXnw==
X-Forwarded-Encrypted: i=1;
 AFNElJ+g8Z69bWguqzKEZjMOTMkhQyc+OAKJ5gCOLl5qWreXynrPBfoe2m1chvHVm6aP7IgK47A4cbxbMk60@nongnu.org
X-Gm-Message-State: AOJu0YxgJzoYwSfLAPRGTVK4p80Y05Q2yrfHdnpLN7a+dnKddexa+6qE
 S/WB1iahI5g+qWqA9w8C3/h00jDuz8T/NdwfBWZL1pbeONLTgJarTRefiLKE0FyuDYw=
X-Gm-Gg: Acq92OFX1ktxWjr0v/72kegejDDukDlaGzzNCh16Hia89WPk3R3faQD67Qm904EJodx
 oO2T1RczonB2BhzurIgX//RM62cZjKQnfcIoDAgSgeK3YVWPsANWaqZdEWQETLa9s47bdl/MrN4
 LCy3VXV8eonNIM4oZx34+D2dqpcVrUs+s3oUFMniR1c935jLgPpWr1wMUpGNZFXu3XenFhvnWOO
 nC3i3ecvo6cyJBSa9x83JJJPXH1BzAHITJiLtBF3A0mU7DOPjlC18U0KcOnaSc0kxI4FcSMZenw
 gqkuimiLRA5T7h6hi9xPlBHy1/SbFSmEJHjVM6vBKMGs3D9Q7EH9H3CQmC3fkBv3fNPu3XbaIAu
 RC3Jc2msy2bC1Xjg1CcLeUsj670B5mNBz2v9FQaJ0efNRUuma7DE6ppvWy2G6AJ/PyUJ08ri7Xx
 Jur/SHseLRmpacLlbmjnKkDhg=
X-Received: by 2002:a05:600c:3b0a:b0:490:60cb:560b with SMTP id
 5b1f17b1804b1-49060cb57b1mr9667805e9.28.1779604301099; 
 Sat, 23 May 2026 23:31:41 -0700 (PDT)
Received: from draig.lan ([185.124.0.195]) by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-4904d239184sm55538385e9.2.2026.05.23.23.31.40
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sat, 23 May 2026 23:31:40 -0700 (PDT)
Received: from draig (localhost [IPv6:::1])
 by draig.lan (Postfix) with ESMTP id 1FBEA5F7E4;
 Sun, 24 May 2026 07:31:39 +0100 (BST)
From: =?utf-8?Q?Alex_Benn=C3=A9e?= <alex.bennee@linaro.org>
To: Manos Pitsidianakis <manos.pitsidianakis@linaro.org>
Cc: Akihiko Odaki <odaki@rsg.ci.i.u-tokyo.ac.jp>,  Philippe =?utf-8?Q?Math?=
 =?utf-8?Q?ieu-Daud=C3=A9?=
 <philmd@linaro.org>,  Markus Armbruster <armbru@redhat.com>,
 qemu-devel@nongnu.org,  Stefan Hajnoczi <stefanha@redhat.com>,  Thomas
 Huth <huth@tuxfamily.org>
Subject: Re: [PATCH] MAINTAINERS: Replace my amsat.org email address
In-Reply-To: <CAAjaMXYCt=3G4yzNNtGWa1gSDW=kCRtXO4TQt41hN-N32DnBJA@mail.gmail.com>
 (Manos Pitsidianakis's message of "Thu, 21 May 2026 09:16:14 +0300")
References: <20221017182005.43015-1-philmd@linaro.org>
 <87pmeohtj1.fsf@pond.sub.org>
 <3104a00e-4c13-4bf7-95a0-1f2840bec50d@linaro.org>
 <5de52cde-3872-4b5f-acbf-28ca300b7724@rsg.ci.i.u-tokyo.ac.jp>
 <CAAjaMXYCt=3G4yzNNtGWa1gSDW=kCRtXO4TQt41hN-N32DnBJA@mail.gmail.com>
User-Agent: mu4e 1.14.1; emacs 30.1
Date: Sun, 24 May 2026 07:31:39 +0100
Message-ID: <871pf1e2t0.fsf@draig.linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=2a00:1450:4864:20::332;
 envelope-from=alex.bennee@linaro.org; helo=mail-wm1-x332.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
 T_FILL_THIS_FORM_SHORT=0.01 autolearn=ham autolearn_force=no
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

Manos Pitsidianakis <manos.pitsidianakis@linaro.org> writes:

> On Thu, May 21, 2026 at 7:41=E2=80=AFAM Akihiko Odaki
> <odaki@rsg.ci.i.u-tokyo.ac.jp> wrote:
>>
>> On 2026/05/21 4:37, Philippe Mathieu-Daud=C3=A9 wrote:
>> > On 19/10/22 14:44, Markus Armbruster wrote:
>> >> Philippe Mathieu-Daud=C3=A9 <philmd@linaro.org> writes:
>> >>
>> >>> The amsat.org domain is having issues with DMARC / SPF / DKIM:
>> >>> https://lore.kernel.org/qemu-devel/
>> >>> CAMVc7JUy5NeEN0q=3D4zfZvn_rppgqn9wicV1z=3DTsLuHKS3RY3Sw@mail.gmail.c=
om/
>> >>>
>> >>> Consolidate all of my MAINTAINERS entries on my work address.
>> >>>
>> >>> Signed-off-by: Philippe Mathieu-Daud=C3=A9 <philmd@linaro.org>
>> >>> ---
>> >>>   .mailmap    |  4 +++-
>> >>>   MAINTAINERS | 62 ++++++++++++++++++++++++++-----------------------=
----
>> >>>   2 files changed, 34 insertions(+), 32 deletions(-)
>> >>>
>> >>> diff --git a/.mailmap b/.mailmap
>> >>> index 1f7319b70b..35dddbe27b 100644
>> >>> --- a/.mailmap
>> >>> +++ b/.mailmap
>> >>> @@ -70,7 +70,9 @@ Paul Burton <paulburton@kernel.org>
>> >>> <paul.burton@mips.com>
>> >>>   Paul Burton <paulburton@kernel.org> <paul.burton@imgtec.com>
>> >>>   Paul Burton <paulburton@kernel.org> <paul@archlinuxmips.org>
>> >>>   Paul Burton <paulburton@kernel.org> <pburton@wavecomp.com>
>> >>> -Philippe Mathieu-Daud=C3=A9 <f4bug@amsat.org> <philmd@redhat.com>
>> >>> +Philippe Mathieu-Daud=C3=A9 <philmd@linaro.org> <f4bug@amsat.org>
>> >>> +Philippe Mathieu-Daud=C3=A9 <philmd@linaro.org> <philmd@redhat.com>
>> >>
>> >> I think this retroactively credits all your contributions to Linaro.
>> >> Intentional?
>> >
>> > Certainly not intentional. I was seeing this as a git limitation, but
>> > Alex pointed to me we are doing an invalid use of git-mailmap, since
>> > it is described as:
>> >
>> >    ... the file .mailmap [...] is used to map author and committer
>> >    names and email addresses to canonical real names and email address=
es.
>> >
>> > so more for typos, not developers changing email addresses. So our
>> > "replace old addresses by a more recent one" section might not be
>> > the best use. I think it was useful for the get_maintainer.pl fallback
>> > option: when a file is not cover in MAINTAINERS then the script look
>> > at git history. If all files are well covered, then we shouldn't need
>> > this fallback anymore, nor this .mailmap translation.
>>
>> Git's own .mailmap contains multiple "replace old addresses by a more
>> recent one" entries. For example, the latest commit for that file is
>> exactly for that purpose:
>> https://github.com/git/git/commit/4aa72ea1f64e8ddcd1865c76b24591c0916c0b=
5d
>>
>> The situation looks same for .mailmap of Linux kernel too:
>> https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/commi=
t/.mailmap?id=3D1bb54043ff309795c90ccadd8a6e6b13ac40ec4e
>>
>> My understanding is that Git's handling of .mailmap is designed to find
>> out email addresses to be used to reach out. For example, someone may
>> git-blame and find I wrote some buggy commit, and ask me to review a fix
>> for it; in that case it is nicer if git-blame displays my latest contact
>> point (@rsg.ci.i.u-tokyo.ac.jp) instead of one for my previous employer
>> (@daynix.com), even though I authored the commit for Daynix.
>>
>
> This is my understanding as well, it's not for employer attribution,
> it's for name change and/or email change.
>
> People who wish to use git log for employer attribution reasons must
> use --no-mailmap. The original commit author in the tree does not go
> away!

Shame there is no way to split the mailmap - because it is useful for
identifying people with corrupted Author/email fields. I've fairly sure
a bunch of entries were added in one of my clean-up passes while
updating the giddm metadata.

>
>> >
>> >>
>> >>> +Philippe Mathieu-Daud=C3=A9 <philmd@linaro.org> <philmd@fungible.co=
m>
>> >>>   Stefan Brankovic <stefan.brankovic@syrmia.com>
>> >>> <stefan.brankovic@rt-rk.com.com>
>> >>>   Yongbok Kim <yongbok.kim@mips.com> <yongbok.kim@imgtec.com>
>> >>
>> >> [...]
>> >>
>> >
>>
>>

--=20
Alex Benn=C3=A9e
Virtualisation Tech Lead @ Linaro

