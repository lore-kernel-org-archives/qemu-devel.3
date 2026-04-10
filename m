Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 42692E99052
	for <qemu-devel@archiver.kernel.org>; Fri, 10 Apr 2026 08:14:44 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wB705-00088c-4j; Fri, 10 Apr 2026 04:14:01 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1wB703-00088N-MX
 for qemu-devel@nongnu.org; Fri, 10 Apr 2026 04:13:59 -0400
Received: from mail-yx1-xb133.google.com ([2607:f8b0:4864:20::b133])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1wB701-00005w-Vs
 for qemu-devel@nongnu.org; Fri, 10 Apr 2026 04:13:59 -0400
Received: by mail-yx1-xb133.google.com with SMTP id
 956f58d0204a3-6505ef94043so1795203d50.2
 for <qemu-devel@nongnu.org>; Fri, 10 Apr 2026 01:13:57 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1775808836; cv=none;
 d=google.com; s=arc-20240605;
 b=ZCaj4yvCQM6FDuTwsIek1yRB4x0QsogbdV+diINavON49G3WDhl4Ndk23yeQmfQCaF
 Ii9JQZr7QVFO0KQaSK/pTmA7OEWY74gGNEf/LLqcx8bp1DDFT2eenFgiombIFkT6h1aL
 /x29BCO/J3f4GOZDlyMW72FqLEFnTExZFsal9qe3UqX9+57/mSmcMoGUJAymG2elj30o
 R6W1t3cZjIub8hgmf2lXmY0uGvNAJeykcyWedpyL+jhVx346SVNuL8xOF3cX0pbku9AH
 EIUUzI2V/tte34mwJfLp/pYW/VPDQcSNtR+z+ri2TOuZXtQeQXnB84v55P30EAxm7mpQ
 LfEg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20240605; 
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:dkim-signature;
 bh=RvFO6UByEpB5iQ8gep8vaTkLyi+ZU0xgSFREu2ZZbP8=;
 fh=VQTX0KcHLYp0W1xh5qMyMVzUksc/bNzicpit96Uxm2w=;
 b=dx3fiOPXkFsofOrUv+1mqYAhOelxP0QXuzZoE5kMQTNVKhRjHqh98VU1a4v11bA4UZ
 4QwikexhtNCCgZIunONu2ad9nmPM9Tdnq15WZGJ4GxvwBAuW1pfTCwDVJcjY+mIyIy+o
 OoroUzQFs5E/u3fzgCXNvL5vHPjwvfdTylSH+4KbbpolnqAFP/+A4YX0Yj3wrMI6rN1i
 E3aoA23V62FE/QQ9tukZ9Zj9Irm6TBzrLNtkc6eG+jaGjaPBX4eqlS9mY5EASr+vIJiw
 MPnZyZxOBNpvwrQiN9YNfySnNoxadhD+NczLFE77zze8qumnolLoEh/O/JCsQFV6gmqZ
 I30g==; darn=nongnu.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1775808836; x=1776413636; darn=nongnu.org;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=RvFO6UByEpB5iQ8gep8vaTkLyi+ZU0xgSFREu2ZZbP8=;
 b=lMf39ox0ba33dlLSzpFlhV8t+7T1oIjHkQZY5RrggR1i68uO9QbHAIS6mptGJCIfXw
 dy4y2+Ie+5TmnyYKcLUGiDNRBJV0lgvhcsMuOZn541KTs8vvQc+QeG26dRbYrmHzCa4W
 lWKpetZNUcrmNZ5hTPZhIQsqm3u4FL+IHsrsrheX3z6k7qIFDw9uSODcXG22I4oOJNDF
 xjcNxyW3NHuoo229eI0RM7dQ3YFhruqTWhgICL9KCFUhV1q5UhHqK/49KbJDk389BIgG
 BtqFOtcq9MK92fkgDzVtrgrDXp318tkVtLGhJBtqdkF6g6ywGuE2+NztnfEryTMaB0VO
 mzYQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1775808836; x=1776413636;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=RvFO6UByEpB5iQ8gep8vaTkLyi+ZU0xgSFREu2ZZbP8=;
 b=kM2tT9nHfiLU/t+qXjVGIZtV5wDj384NdKp/HHbkrh00Fj5iFYHIZgJMgYf3st0Eds
 Ofl4WKVUhrASdUae2d5WIERP/uxhvcREIIqYcNliyb5C9yghsDoEbCnf5SdIBYKwnSYV
 vXQJ2Zcn6VgrlMj0Ob4tUlBFJxK5M73UjfWWx+FJ7joTEayMMZtwpFcbmnbDWxCwZFSo
 gdQZA6ITPWIqM24ANfRPIR4H7rpQBJOH5hrR1EKzQe1bpBkcptIlfXMQ8ZVUwTu3R0yy
 aM8W1aLk/CoJDnFenWF50ONTIP8J7xC0EvgtCpBsH65GmNMvRPtsLbGBUaTkcxPG7DCP
 /Ljg==
X-Gm-Message-State: AOJu0Yzn4c6pdKHhmfqNWAJNbhzWqS4P/uYSg1qR8+aAFG+J0DWNy9+5
 cQqX9j/V4AeAV5T3PCyDAVAZA45yio9aPufqMH1eI0Ich/vRuVbq24mAi5qpD4YyUSEeVBxKEcE
 jpRwxpQtpKJAJmQuNT70le1k/JNJ0jUEMcxK4wI4JLw==
X-Gm-Gg: AeBDieu4uYQiAq69C3oF88WZSR/3fmLMVmp/TNeJe0W4VJzujMojwBwRflENtT7u4uq
 vy0TLUK4d5zS6uX+tN0cAQ3KwJYnmqaawtvB0dDZXefgWs1sU5P1ChGNKw30NdRBHorrc1BnByF
 MA/2P+epEMorYF+AmVKBcNFBIyj+K85XafSurYRTCzGYNKZ+ehiCEXU3ZVgWA4ZNmfjYMkHNKoC
 aQX9jtXaECnCIMdkpo/1PEkA+wx/1OZ8bl3R/Kqx9ikQ5ItUB1askGerT4fjHOp+xTyIVIzOIL/
 uit4SylVVCiaaxENyWBCID6VPf5U0BAG4EUnvOh4111+txXduUOu5s6aQNHcfvH0C/A=
X-Received: by 2002:a05:690e:484e:b0:651:8ba3:8787 with SMTP id
 956f58d0204a3-65198bdd966mr1306929d50.61.1775808836506; Fri, 10 Apr 2026
 01:13:56 -0700 (PDT)
MIME-Version: 1.0
References: <20260408184228.44242-1-james.hilliard1@gmail.com>
 <CAFEAcA_Jt3SmuTiLWxuVQuktAG=M5C-Ux7OYKcGwPUBSETegew@mail.gmail.com>
 <CADvTj4rMoQi-ic=q=TJ5Dz6_GhHhR=JNhMoRhfKCFAuZzhUpzw@mail.gmail.com>
 <CAFEAcA_JPnWh22zhb+ajr76oKtFRoCZSZpsVW51m08eWrMZS5w@mail.gmail.com>
 <CADvTj4qUY6=b56LeHb+fZBEdvFPPR9dMFkYEjNhtN=BipOaEog@mail.gmail.com>
In-Reply-To: <CADvTj4qUY6=b56LeHb+fZBEdvFPPR9dMFkYEjNhtN=BipOaEog@mail.gmail.com>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Fri, 10 Apr 2026 09:13:44 +0100
X-Gm-Features: AQROBzBJ4JUIqcoLxp4Lg9Hta65TMVJrK5xyLcFa0sD8gDrLAisSgXDqLhkHStU
Message-ID: <CAFEAcA9CT9KeO1qmNg6YaCnjmvDG3-jeSwTjP4EnUqg4Hh8fSg@mail.gmail.com>
Subject: Re: [PATCH] linux-user/mips: keep k0 in sync with CP0_UserLocal
To: James Hilliard <james.hilliard1@gmail.com>
Cc: qemu-devel@nongnu.org, Laurent Vivier <laurent@vivier.eu>, 
 Pierrick Bouvier <pierrick.bouvier@linaro.org>,
 =?UTF-8?Q?Philippe_Mathieu=2DDaud=C3=A9?= <philmd@linaro.org>, 
 Jiaxun Yang <jiaxun.yang@flygoat.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=2607:f8b0:4864:20::b133;
 envelope-from=peter.maydell@linaro.org; helo=mail-yx1-xb133.google.com
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

On Thu, 9 Apr 2026 at 22:00, James Hilliard <james.hilliard1@gmail.com> wro=
te:
>
> On Thu, Apr 9, 2026 at 2:17=E2=80=AFPM Peter Maydell <peter.maydell@linar=
o.org> wrote:
> >
> > On Thu, 9 Apr 2026 at 20:47, James Hilliard <james.hilliard1@gmail.com>=
 wrote:
> > > So this seems to be something used by the vendor SDK for Octeon1
> > > but not Octeon2 and Octeon3 targets, kinda strange/annoying.
> > >
> > > I also found this:
> > > https://lists.gnu.org/archive/html/qemu-devel/2011-08/msg02026.html
> >
> > Ah, nice find.
> >
> > > It's in the Octeon vendor kernel here looks like:
> > > https://github.com/MarvellEmbeddedProcessors/Octeon-Linux-kernel-4.14=
/blob/5c48e5031fbd86361e8185f6c530ffcfa5c9a60d/arch/mips/kernel/syscall.c#L=
94-L96
> >
> > Mmm. We emulate the upstream kernel, not vendor forks, so
> > we wouldn't want to set k0 here I think.
>
> Yeah, I was trying to see if there was some sort of way to trivially
> identify binaries that require this k0 support and autoenable a quirk
> but I didn't find anything, maybe it would make sense to have a
> separate runtime target for enabling this k0 quirk since it seems a
> lot of octeon binaries require it?

We didn't add this 15 years ago, and my feeling is we still don't
want to, because we track the mainline kernel. If an actual host
kernel doesn't have a quirk to let these binaries run, we don't
need one either.

-- PMM

