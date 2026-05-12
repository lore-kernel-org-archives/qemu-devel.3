Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 159D3CD4855
	for <qemu-devel@archiver.kernel.org>; Tue, 12 May 2026 08:40:07 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wMieT-0004aB-Qt; Tue, 12 May 2026 04:39:41 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1wMieS-0004Zh-Du
 for qemu-devel@nongnu.org; Tue, 12 May 2026 04:39:40 -0400
Received: from mail-yx1-xb129.google.com ([2607:f8b0:4864:20::b129])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1wMieC-0003MG-NT
 for qemu-devel@nongnu.org; Tue, 12 May 2026 04:39:40 -0400
Received: by mail-yx1-xb129.google.com with SMTP id
 956f58d0204a3-65d071aac6eso4753782d50.0
 for <qemu-devel@nongnu.org>; Tue, 12 May 2026 01:39:24 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1778575163; cv=none;
 d=google.com; s=arc-20240605;
 b=HK7aOZfHwZ+GlzBq+uQJZhhp+ZOfW/twa4ccaIySpShwSwyIq1LONcGJPUon2SJddL
 iG5l6QA5RSJvPWlUj6ML8mat7srIOwWzuY91OHALA6LAtP4wijKaDs8RMCB8nBWcvvoT
 JIjK6nSajLTDx8QIylkv9VwMFxRMJEpZXrjstA2JyYEXqXsmDx2mfYTuCJFUeEBjhvIS
 V7UJF9ohmZ8jEf3WICvqkjCO4JlaTEEzjVTBzZ19I/QBv7svZS4toR0flhQDMKbPzp7o
 /uL9k7n4kTYIYLxmEGNjSHVybYE2t/M4LZya8oTnisG9OjBgftaqbwnj0sbXcFrvPwOi
 uglQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20240605; 
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:dkim-signature;
 bh=IlCmIxH4VWslKKHrA3V11wDCzRMZna3Vn5Zjnz0Lto4=;
 fh=C0d6MoelyxnyEnZgqQ38cA+Tdf2UUaAoHDpAxiJFa0o=;
 b=MXGjkYo150+NC6br/LtRjuyMql8nVLXoy162MI/IsFzR3h1xc0RxvLdn64fhQOD2uC
 HkDbUZr/nGT8Ejg8CzXFX2sZ5brNFo5F7ntJTMCRsORqkAEP5l7CXxl3urTl5WWdGOv6
 jp6pEZEjp6pIJz5gYBQD75KYJgCTj6qkzqMcL/YTpyGm2A+O9Wo1+8Y4pTOxioaiNPRq
 aNTvlKkYvYp2volvgmzxvwc+oBnXO9t/jIRgExDjUj1N/CmIfiU0mQkVTZhC8D+m0EFp
 eouwdxvMtlCs1b2+VTPtck0lF6lA4/FByAjjqNv/zcfOSBnqAfaLK6GIG0nBk9/hDTmw
 wrIg==; darn=nongnu.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1778575163; x=1779179963; darn=nongnu.org;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=IlCmIxH4VWslKKHrA3V11wDCzRMZna3Vn5Zjnz0Lto4=;
 b=SEbt/IGXgj9FeiYeuzcpTtu1YvaPo12oZJQhsUy1q7m7oT1M2EjHhzByZRWli+0VEm
 V6v7OFjLlgMeApK19FxG9wqlTPDhMkiDezXj15aqarnjBPAnSxqocCe/BqHdVyOgQqfu
 d+oKcFMFLbgk6gP+kzsWuAf/bYBWG1k/XydmZzhz+esRI2m2EyfgZ+2GRtV0vJn4Pojz
 xddl09nOfDTa1H79BU3Bx6n0yNEfoobHMaSV9ApbxgKj0lRt00wHoeYiUGuJLmRKErhB
 hTf4pt8nvxPjhWkHrREHfhqI4nur99hE13Urh/0MbR7M9edoHaWY7tu3mujEHNFtQGze
 8a/A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1778575163; x=1779179963;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=IlCmIxH4VWslKKHrA3V11wDCzRMZna3Vn5Zjnz0Lto4=;
 b=k/1YlzhUVPJrpXjglkmRMiX/pieZy6s7P/YCY4J0zCqFD/sf4LvKQaIcP2XJdom9VT
 4hqwTnpRP+tGdYr+xNV0f2kCnx8LeO3QrGsqOZNYHgFiiNo/zGTe+IGvcyFIsUgped13
 9/f8kaAAVQqtjJsePFjvTsi4FIRmP7MBKFSUNrxxHimnjc+6mjFyrF2YVzGxPcEtdC83
 QZddtmgYtm1FrzK1vbhVUQcM9BEdDRmLLnDGRXbilOZakLzyqMMPxA4NEcGp38btp1sX
 Ze0DF4WS+muZ0POLsoq31EclKQ2vkiOirwViANxFZiJu9CNgVv8m/f8kwrv34NF5GTcy
 e7Zw==
X-Gm-Message-State: AOJu0YyEhOLqgbMW9u08z+CMRAz06zrJa47IYghM+E2V6C/2xWzAMDeA
 opmEOE6XyIIbye9waHEhVeA7+IlmWQ1eEex1xlcZNLVQIvUgDYeEziqz0Vs2TefkhHBbbj6HLyM
 /32foOGP+62Jl1/o0V4Rd5QMLlIuVrcCny6B4DbXxgQ==
X-Gm-Gg: Acq92OEensKcwSo/j+CnBrKS8PQyoEUG75LKZQEJR30kbhJGHeFpUGqdBRz3RX5ECYs
 EG4NH8bHGfbA31gS4ro+8mQCax70Q7Iaqhwh9yWC3j93NE1DXyFHlQr1EnDV/79vfJFvIbulLkf
 wP7NCkSGXmLdlHB5kPplQcDtqV/1cheApkmgwS8IebDmOhXHK/zAjy1W0lbXSrVevFyOvZLEqSO
 fRqYJAy+DW3JLBnEulQ1AUSh98hfA2zsVLJ4wut2SQnvPuMvnYJiMXb7Iax2TyRxChfOoi2JTVi
 ks12f+39SpSOSSUh2QSpG3KrviTLcWmoe12CRmAE+E0IJCUvQVr4nqN26CAwXNFT048=
X-Received: by 2002:a05:690e:2592:b0:654:45be:85ad with SMTP id
 956f58d0204a3-65c79d2b354mr18325712d50.52.1778575163394; Tue, 12 May 2026
 01:39:23 -0700 (PDT)
MIME-Version: 1.0
References: <20260511170500.124211-1-alex.bennee@linaro.org>
 <20260511170500.124211-2-alex.bennee@linaro.org>
 <CAFEAcA_tTR0dXKGp2y3YanS3wASrMSgcNQAiET3ff-c7HfBLBw@mail.gmail.com>
 <87mry5daod.fsf@draig.linaro.org>
In-Reply-To: <87mry5daod.fsf@draig.linaro.org>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Tue, 12 May 2026 09:39:09 +0100
X-Gm-Features: AVHnY4JpsZGK7GSB7z9hWzel8xE1F_6gUl7CTG5zswDVo8L4_HJHudwSST-iocI
Message-ID: <CAFEAcA8SGHfAqhzd=3b4AdyPVBr1gFJ-Hr3XtgWEPNdYDg65-g@mail.gmail.com>
Subject: Re: [RFC PATCH v2 01/10] AGENTS.md: add basic AGENTS.md for QEMU
To: =?UTF-8?B?QWxleCBCZW5uw6ll?= <alex.bennee@linaro.org>
Cc: qemu-devel@nongnu.org, John Snow <jsnow@redhat.com>,
 Cleber Rosa <crosa@redhat.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=2607:f8b0:4864:20::b129;
 envelope-from=peter.maydell@linaro.org; helo=mail-yx1-xb129.google.com
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

On Mon, 11 May 2026 at 20:10, Alex Benn=C3=A9e <alex.bennee@linaro.org> wro=
te:
>
> Peter Maydell <peter.maydell@linaro.org> writes:
>
> > On Mon, 11 May 2026 at 18:06, Alex Benn=C3=A9e <alex.bennee@linaro.org>=
 wrote:
> >>
> >> This was written initially written by ECA based on its understanding o=
f the
> >> code base. I then expanded it with links to the various documents and
> >> the general coding style.
> >>
> >> Signed-off-by: Alex Benn=C3=A9e <alex.bennee@linaro.org>
> >
> >> +## Security Policy
> >> +You MUST NOT report potential security vulnerabilities in public trac=
kers
> >> +(like GitLab issues). Refer to `docs/system/security.rst` for the pro=
ject's
> >> +security stance. In brief:
> >> +- **Virtualization Use Case**: (with KVM/HVF and specific machine typ=
es) is
> >> +  the focus of security support.
> >> +- **Non-virtualization Use Case**: (TCG) does not currently provide g=
uest
> >> +  isolation guarantees.
> >> +- **Reporting**: Report vulnerabilities privately to `qemu-security@n=
ongnu.org`.
> >
> > I feel like the important thing we want to point out to agents is
> > that not all "this crashes / asserts / overruns a buffer" bugs
> > are security issues. As it stands I feel like this text is
> > going to steer them pretty strongly towards throwing anything
> > and everything at qemu-security@, including bugs which we
> > don't consider security issues. What we want ideally is to
> > give instructions that will make the LLM itself do the
> > initial "is this covered by the security policy" triage.
>
> I think for that we should augment the triage skill itself.

I still think we have a few things we definitely want to communicate
to an LLM ("don't generate code for upstream", "these aren't
security issues") and those should go in the top level agents.MD
and go in sooner rather than later. All the other stuff about
skills I'm much less sure about and tend to feel we should
add them slowly as and when multiple people say they're useful.
So I'd rather see the two or three key messages go in AGENTS.md.

Also, even if you have a triage skill, if you say
"Report vulnerabilities privately to `qemu-security@nongnu.org`"
and "You MUST NOT report potential security vulnerabilities in
public trackers" then you're really strongly steering everything
to that security email. We should get this text right, not
have it say the wrong thing and hope that the triage skill
overrides it.

thanks
-- PMM

