Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id DFA44C43458
	for <qemu-devel@archiver.kernel.org>; Wed,  1 Jul 2026 17:24:26 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1weyfU-0006GV-53; Wed, 01 Jul 2026 13:24:12 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <stefanha@gmail.com>)
 id 1weyfS-0006GE-P3
 for qemu-devel@nongnu.org; Wed, 01 Jul 2026 13:24:10 -0400
Received: from mail-ed1-x531.google.com ([2a00:1450:4864:20::531])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <stefanha@gmail.com>)
 id 1weyfQ-0004Yy-Sl
 for qemu-devel@nongnu.org; Wed, 01 Jul 2026 13:24:10 -0400
Received: by mail-ed1-x531.google.com with SMTP id
 4fb4d7f45d1cf-697ce8cfe65so1704174a12.3
 for <qemu-devel@nongnu.org>; Wed, 01 Jul 2026 10:24:08 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1782926647; cv=none;
 d=google.com; s=arc-20260327;
 b=JdfOwH5qAgpa+X8WVE8kVAFNJeUFEKBqERFVlu2pufDcBV+fyhKNxldsuzOe5YAbeB
 q9NMtMagAkN9uExDQsuPPQQniuVKy389Cn/hdu07Ze4cDIPHK//BGacytZT3HlF9dQnw
 nELLUaMUl4es7Glu0vfTFS20QLv7LXQjtpb4W4o+bFTwP7fzlWHsW63bmXNj8ztHcJYT
 jmf2y3zyu0twKT6Kc0d5NsJLwy+mKnpMckQH3rBVu7novoJL7ikcSS6XhDQPnFt+aiZS
 WlQFSswaWRY8CN3FGS0XejCC69atQuWhvQWPIrXT59DT3Rlik1KNERKxurlvUWD4bN0y
 KvnA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20260327; 
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:dkim-signature;
 bh=MJt9EGfxWyjFIHm2OqjYz9gEhB+y0QZvi4dTtJPcYKA=;
 fh=4uHq49lDZXg+ZsqkK9v4L6IbMhknXgo/gi5AUSuDxT0=;
 b=G7zKKgMQyS0h7JvbuXJi3N0ZvhpZNHI4fJ5g7yJWwyNd3X0NGMCPEILDKWv7TEU+np
 TVJmukXKY9rMAEbvfkyee/x3e1CDaCCr0xf/PTM6Wu/OI5FAPudoTZby51vulw4guGYo
 FwgBtPteTJTVQf5HHA/pIziYNgIknqtBxy4bqcer37X5tkaMMMOJqBW8XTo8WJ6H+feg
 2YO/6xzkBRUlxoFJPxqmUL+DNFzph0xC2KaxBYEFdoBjUX9vUiynDiv6zvaCco7hIaBA
 NaqJg/TGRfiO1NTO1nJ6aHr9tcOk2HtCGWkgkErAHj+bopxHKJEI+3lLGGdWmtuSRcwu
 OeOw==; darn=nongnu.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1782926647; x=1783531447; darn=nongnu.org;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=MJt9EGfxWyjFIHm2OqjYz9gEhB+y0QZvi4dTtJPcYKA=;
 b=Gh7130I8oaaOPv+wx2dfiYDWwywEBdARPHeh3ZXbANNAHsQjyNyD4TzS0IQuKekjL2
 ivCAld69yoFlAOPHb2VITBQM5w3R1EuCauL+IF7DKtdjDAwgJqd8rXA5aM+oqIHHq1AE
 DC1Zi37z02pOaIfdXMNUOxz3i6s1oa5P8k9rU5SzSGkCKV+lpL3H6/qBUIStzINvXx27
 2Yb6tkoUtfcWzxpnewIqGz8mHc/FvF6b1+ZQ7Dvof2o6tzhLghQH+cAxMXZkJ9BegN88
 dcFbiCfgdLhFD7dcsZZZyyw2DFJ9vfyzbuRuGv6Xb166moPWGwz5ielqzAPUidWP8pc/
 QiCg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1782926647; x=1783531447;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=MJt9EGfxWyjFIHm2OqjYz9gEhB+y0QZvi4dTtJPcYKA=;
 b=TgBHZy0lLgi1poSTITPNQGoeonuqRklD17kcp7G3tGQ72q0KSFwPfQgxJw6mXnRr9E
 BXh9UVehAuFOxOwG9Z9SCMmpWOP2h7gr6xEcKXtYt8Mr8bYiszs5JmLKe8hzH162Yeny
 8whMLJyyiefiS1koU4DRSug2vKmOsyVcObHi11TiRD1WtX2xMex0MB17bY5a6SCA3a8k
 RQduCksHICGMkFSXo9LN8yxt0N+bBHYYu14bmEh5Ldfn5XqSPe7pL6IlRKBbri820uBX
 0BJ4VhDcEyJbFSpz8XMnmh89ZFSt5JPm12UJjeWDRrOTfotlmPzKrhe2E5xmU5usVZdC
 uBkg==
X-Forwarded-Encrypted: i=1;
 AHgh+RooTez4azbQWlIcxyzIpS/RrjmPGG0x1vWIeorbwnp/178z4US1ZJae2B6sYuWQeP9FOi/U9XFBsPmT@nongnu.org
X-Gm-Message-State: AOJu0YyOJ0SGc70emubrTDnRBm2sOoScGma1nZj8q6s/qjUVlj/nL1TM
 jD9Ynwy45Ho/HHmYAmD2kNXtuyCmKfYa0Dr0WoD2C1XmmVYo9LnsDtbPXbSuOZYz2gz5tXvI9hS
 u1y4Jqn5MTGoy5YSQ0LVD3JSaiS93gAg=
X-Gm-Gg: AfdE7cmtca8MIrW9isllNFCTt8qvleuPoYi3xlZs+vC2I5rvMo444H51UQKYPoiUxDL
 1qsFzbu4PBwK+oHqKwdMil996bD4qXwSGHxTzrXnvZ1NzES6ERc7kaCOSFopTA+rNqoC/ZS98vc
 jDTjBxPTA8DbpyD52XP4Y92EPPvaZNbGD446KevZlDXvB4IuDhCCCK8oO9X2U5SMS2k9Ez2hcTC
 jTuFVuQoyhiEgBe+ZYm3RWBaImgRFf5SzqxFMfr5F4cnAVVMEfNRKSuaaNOtNdtNmJPeNFXx5Yq
 RJwbeQ+1LVVPoU85PIaKiKupDXDO5QjwamEq7ayuULlmqJvaflHbCtz01Q==
X-Received: by 2002:a05:6402:524f:b0:697:6c28:66bc with SMTP id
 4fb4d7f45d1cf-6989f35307fmr1304635a12.20.1782926646341; Wed, 01 Jul 2026
 10:24:06 -0700 (PDT)
MIME-Version: 1.0
References: <CAJSP0QXRy1Dc_MwqtU_gS1+jOdrW=Vk6YynP75q5HP3Rz_CpTA@mail.gmail.com>
 <904444A5-0120-4BE6-8E11-C7167F2A3BDB@unpredictable.fr>
 <D91DC576-2462-4652-9E8C-5A7C96791622@unpredictable.fr>
 <CAJSP0QWBpXN-=iu_13y3k_4z4uZJX7NPTgFH16CSBn30EYTrAg@mail.gmail.com>
In-Reply-To: <CAJSP0QWBpXN-=iu_13y3k_4z4uZJX7NPTgFH16CSBn30EYTrAg@mail.gmail.com>
From: Stefan Hajnoczi <stefanha@gmail.com>
Date: Wed, 1 Jul 2026 19:23:52 +0200
X-Gm-Features: AVVi8CfBMYdKRu1qpwzVSrDs7nBluu2wUvAI_pz830BnhEXQfKNeXyDCeOqbAkk
Message-ID: <CAJSP0QWtZUKQC5d23+tJi896H6sndwL+bD2cvSkQhC67mBjbkw@mail.gmail.com>
Subject: Re: macOS builds broken in CI
To: Mohamed Mediouni <mohamed@unpredictable.fr>, Emmanuel Blot <eblot@meta.com>,
 =?UTF-8?Q?Philippe_Mathieu=2DDaud=C3=A9?= <philmd@linaro.org>
Cc: =?UTF-8?B?QWxleCBCZW5uw6ll?= <alex.bennee@linaro.org>, 
 qemu-devel <qemu-devel@nongnu.org>, Peter Maydell <peter.maydell@linaro.org>, 
 Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=2a00:1450:4864:20::531;
 envelope-from=stefanha@gmail.com; helo=mail-ed1-x531.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, FREEMAIL_FROM=0.001,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
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

On Thu, Jun 25, 2026 at 9:53=E2=80=AFPM Stefan Hajnoczi <stefanha@gmail.com=
> wrote:
>
> On Thu, Jun 25, 2026 at 3:15=E2=80=AFPM Mohamed Mediouni
> <mohamed@unpredictable.fr> wrote:
> >
> >
> >
> > > On 25. Jun 2026, at 21:11, Mohamed Mediouni <mohamed@unpredictable.fr=
> wrote:
> > >
> > >
> > >
> > >> On 25. Jun 2026, at 20:38, Stefan Hajnoczi <stefanha@gmail.com> wrot=
e:
> > >>
> > >> Hi Alex,
> > >> tests/tcg/multiarch/system/Makefile.softmmu-target's
> > >> run-gdbstub-interrupt seems to be broken on GitLab CI macOS runners.=
 5
> > >> days ago it still passed, but now rerunning the pipeline on the same
> > >> commit ID fails:
> > >>
> > >> - Good (5 days ago): https://gitlab.com/qemu-project/qemu/-/pipeline=
s/2615134022
> > >> - Bad (today): https://gitlab.com/qemu-project/qemu/-/pipelines/2629=
704018
> > >>
> > >> I've tried many CI runs with different pull requests applied on top =
of
> > >> qemu.git/master and they fail in the same way. Maybe it's an
> > >> environmental thing with the macOS runners?
> > >>
> > >> It's unclear where the SIGKILL (Error 137) comes from. Could it be a=
n
> > >> out-of-memory condition on macOS runners?
> > >
> > > Hi,
> > >
> > > SIGKILL is the known symptom for failure during signature verificatio=
n
> > > by AMFI.
> > >
> > > Now that we don=E2=80=99t have separate -unsigned binaries anymore bu=
t relying
> > > on in-place ad-hoc (w/o certificate) signing with entitlements we mig=
ht
> > > have issues linked to that.
> > >
> > > In the past file modification had issues with verification tied to th=
e
> > > inode and the workaround being a reboot or a cat binary > new_binary;
> > > chmod +x new_binary so that the old (now out of sync) signing state i=
s lost
> > >
> > This is highlighted in the software update context in: https://develope=
r.apple.com/documentation/security/updating-mac-software
> >
> > > This code is incorrect because it modifies the command-line tool=E2=
=80=99s executable file in place. macOS caches information about the code=
=E2=80=99s signature in the kernel. It doesn=E2=80=99t flush that cache whe=
n you modify the file=E2=80=99s contents. Modifying the file in place yield=
s a mismatch between the file=E2=80=99s contents and the in-kernel cache, w=
hich can cause a hard-to-reproduce code-signing crash the next time you run=
 the tool.
> > > While this example uses a command-line tool to demonstrate the issue,=
 updating any file that contains signed code might trigger this code-signin=
g crash. That includes executables, frameworks, dynamic libraries, and bund=
les.
> > > To update a file that contains signed code without risking this crash=
, write the updated code to a temporary file and replace the existing file =
with that temporary one:
> >
>
> Nice, thanks for sharing this! Do you want to send a patch to fix this?

The macOS CI jobs have been failing for a week. The QEMU 11.1 soft
freeze is on July 7th and I'm concerned that we will enter the 11.1
freeze without working macOS builds in the CI system.

Does anyone want to fix this macOS host issue?

Stefan

