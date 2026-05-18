Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B45B4CD4F52
	for <qemu-devel@archiver.kernel.org>; Mon, 18 May 2026 08:48:35 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wOte9-0001MJ-PL; Mon, 18 May 2026 04:48:21 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1wOtds-0001Ce-AR
 for qemu-devel@nongnu.org; Mon, 18 May 2026 04:48:04 -0400
Received: from mail-yx1-xb12f.google.com ([2607:f8b0:4864:20::b12f])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1wOtdq-0005e3-6O
 for qemu-devel@nongnu.org; Mon, 18 May 2026 04:48:04 -0400
Received: by mail-yx1-xb12f.google.com with SMTP id
 956f58d0204a3-65e15fb394bso1465386d50.2
 for <qemu-devel@nongnu.org>; Mon, 18 May 2026 01:48:01 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1779094081; cv=none;
 d=google.com; s=arc-20240605;
 b=Kgvzx26B4QB5AdX31s5T00lbjrZSQN4AkvBh8ly/Xkw82sHS39Kj/PyCph7vK6hORM
 IbrY9BNWBw66q+fGcy4tGsnW2PtIrkSLVrqggNJgF46QAuLOwaS/jJGKQ8EGjYGWtgDa
 NTPIIZ4ai4ymjTk+s0gegSQ8Ocq0k8osrKY+0g2KhfpXoUAC9f8EEY4ptNOGGU225Trk
 r9rRJeg99PtdW2wvF70qiFn/I5NenBYRLB1fCFe31oZSkc29BQdnwEHUFimcYEDCtk5U
 FiiT4f0WQxZiCitRVDc8rNOg7sNYvu8QkBxa9Tdd/jkNrpPcfLPUm90lD/Puz8X58k2W
 Nh6A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20240605; 
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:dkim-signature;
 bh=nq37c4BIe3NGikFm23gPRVpL7LmnoxhCBB66HlFCe5U=;
 fh=w+TdsQ0QXyoZbPmlwTpqCP9IS5BrDV/zIi0MsrLlMXc=;
 b=gnzRwXutPm+YwdkMds7L8AmDu0AgCxwX6crB7ccqHul7s1AEt2Qg8lXU2GIXuXwcYt
 W8Ik5qZ3Dvh3k7UnsoUXaMuDSr8A9As23nL17PsYVI6PVh/SygHlUHRSrVmFlwWVMWFl
 YiZtoR0MsrK+kd3ERNXLJoXH9pYXn2yj9JziTM3nvZ2foPn+cExcPz1vY4BAPkchI0f2
 +6YGwJAMskpGbWcbK2AERZdi7MXyC1ZKxmHUyX4x/Cb5mTu7UpaiNJcDWzw5sasCLild
 s2Ju5Wzn/Viya3SJg6bWSjwmifdh8NFyD3E3AEVKpSBCvjUZorwQ4lQAqxn5nRKavmRX
 O8yQ==; darn=nongnu.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1779094081; x=1779698881; darn=nongnu.org;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=nq37c4BIe3NGikFm23gPRVpL7LmnoxhCBB66HlFCe5U=;
 b=prO7hvAUYN0PbHPftduaYU+tTWNuBd7qc8yavof5bvnOeSWYzAwJF06MOW4K9RhSu2
 0u3KkswXOZFhI1mmzZYiPD/d2GHY3eAG6M8SfdiMuhAp5ZqUOtTVNb/GXy+mXygz8HIU
 3laS73RjrrzZuvXCPOvbSL4kYMltSgzVWdIObeP19oFNYtSXHlc4Gd6sukoKuOeLj5HO
 7DzwZuaqaAcKTVbbaDV5jW4MmZpBrqHgLEb32AuB1zvU+lR0HrbxhqCdR4sFSkBrsC3t
 1FAEtfD0aPps30NFvbxo2mv2reXKxeH9et21GZS90viptqP6EVpBtdziZ8GrNN4LiWSb
 AVKg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1779094081; x=1779698881;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=nq37c4BIe3NGikFm23gPRVpL7LmnoxhCBB66HlFCe5U=;
 b=OdyRugXq8oMeKCuXCQdaFGmobOqDO5vfeIivkTEp4ZhAYs34Jx+eTrX4OYeR+8Yw01
 +UbNSw/ySqv/X4klVh9yBtEpH2WWlDh/EdbrQ/HXlJdNurE4wdf9vdUmzlfh3O2bOHnO
 f3rkStRbrt87psiHOhuuZlicIchrQATk0oT7GMXXHbfMtc/LwgJ/aOrYsDj4IUkhClCc
 L1XHAmngAu4dJAVt8cxYgUrQyC2heESo1CFjyeLIGUahX/sBphP+XNLAnewfw9wNtTAH
 whH2VnYeNAH77iUWyVdc7/9k7ViKJtU8AApAH7THUutdpHDeTheYb+QkZuFUWw1ANOgS
 NumA==
X-Forwarded-Encrypted: i=1;
 AFNElJ9SR4ZcDagNZJg0hBvnb+cZpgOWSdpy+pauiOYSN3ao69hlyQSxTN4c9GVRyTRPewJO4WvsJAVf76L1@nongnu.org
X-Gm-Message-State: AOJu0YyXgBps6mJzoYRW5B2W7TiySjJIHGvJxneGCoVC0qAV1nuIaYB1
 zZBeZ9Y7cZ/Hj/5XZOGeiMCd2ss7KURFE8nmDnu2HxcB3p6Z06/GMHY9P48IiJSHKleh6FlfBT2
 XSquFQ7VpFCp/0ElyP7FXQKBM5c7RPYEgd7Sas2dzbg==
X-Gm-Gg: Acq92OFexWQXQUB6RQ1XjGXxGbfUaovjsxYy4Hd43lKbyC3YkvjIW/XiZ3So/nIj3Qn
 exUxRKVLu8ou06hvGzD+Mee4hEf7bNzENo+0Fk3azQDCTni50rQt8GHi5MJpEtFyAmVgE7PVBg+
 Szu84ULC3xmNy9+kYoq/N+671NnWmfbwouCjn1WrsZLFGrVkpndPu00MFIGSmW/q5vh2W9mkQrg
 yr4d6EV27ChtfjUuM+8i9oR8pjkvJuWWi+gs/8AztP6Nni3ca5Af/9N495VlyKrBoqr5yumb7qj
 uUo9T8wCm63E96C+kv8XjRXHITUmgWk/+zQsI3VQ9LVjDcPgNZLkdgbntsaoVtdZ6WQ=
X-Received: by 2002:a05:690e:d47:b0:651:be50:af09 with SMTP id
 956f58d0204a3-65e2267428cmr12381743d50.3.1779094080722; Mon, 18 May 2026
 01:48:00 -0700 (PDT)
MIME-Version: 1.0
References: <20260515163055.1792262-1-alex.bennee@linaro.org>
 <20260515163055.1792262-2-alex.bennee@linaro.org>
 <a6b904bb-6ddc-4c39-84f9-3b7c91f7e611@linaro.org>
In-Reply-To: <a6b904bb-6ddc-4c39-84f9-3b7c91f7e611@linaro.org>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Mon, 18 May 2026 09:47:48 +0100
X-Gm-Features: AVHnY4Lf9I6ZN7vScbLnE2MCP7UPX1JDgTDBqoYJyCdFKev-q0RcDyS8wLhCB6c
Message-ID: <CAFEAcA-DS3k-7SEFMASa4ncpuZmX07A2n66quSEG4R_VYq+AHg@mail.gmail.com>
Subject: Re: [RFC PATCH v3 01/11] AGENTS.md: introduce a very basic guide for
 AI agents
To: =?UTF-8?Q?Philippe_Mathieu=2DDaud=C3=A9?= <philmd@linaro.org>
Cc: =?UTF-8?B?QWxleCBCZW5uw6ll?= <alex.bennee@linaro.org>, 
 qemu-devel@nongnu.org, Cleber Rosa <crosa@redhat.com>,
 John Snow <jsnow@redhat.com>, 
 =?UTF-8?Q?Daniel_P=2E_Berrang=C3=A9?= <berrange@redhat.com>, 
 Alexander Graf <graf@amazon.com>, Pedro Barbuda <pbarbuda@microsoft.com>, 
 Mohamed Mediouni <mohamed@unpredictable.fr>,
 Reinoud Zandijk <reinoud@netbsd.org>, 
 Magnus Kulke <magnuskulke@linux.microsoft.com>, 
 =?UTF-8?Q?Doru_Bl=C3=A2nzeanu?= <dblanzeanu@linux.microsoft.com>, 
 Wei Liu <wei.liu@kernel.org>, Paul Durrant <paul@xen.org>, 
 Anthony PERARD <anthony@xenproject.org>,
 Stefano Stabellini <sstabellini@kernel.org>, 
 Roman Bolshakov <rbolshakov@ddn.com>, Phil Dennis-Jordan <phil@philjordan.eu>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=2607:f8b0:4864:20::b12f;
 envelope-from=peter.maydell@linaro.org; helo=mail-yx1-xb12f.google.com
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

On Sat, 16 May 2026 at 11:09, Philippe Mathieu-Daud=C3=A9 <philmd@linaro.or=
g> wrote:
>
> On 15/5/26 18:30, Alex Benn=C3=A9e wrote:
> > AGENTS.md is the agent agnostic place for placing instructions for
> > agents. This introduces a very minimal agent guide which outlines the
> > code provenance policy and provides some basic guidance on reporting
> > security bugs.
> >
> > As Gemini doesn't look at AGENTS.md even as a fallback option I've
> > included a symlink.
> >
> > Signed-off-by: Alex Benn=C3=A9e <alex.bennee@linaro.org>

> > +## Security Policy (see `docs/system/security.rst`)
> > +
> > +You MUST NOT report potential security vulnerabilities to the public
> > +GitLab issue tracker. They should be reported privately to
> > +`qemu-security@nongnu.org`.
> > +
> > +**Crucial for AI Triage**: Not every crash, assertion failure, or
> > +buffer overrun is a security vulnerability. Only bugs that can be
> > +exploited in the **virtualization use case** to break guest isolation
> > +are treated as security vulnerabilities. In brief these are:
> > +- **Hardware Accelerators**: e.g. KVM, HVF and others, TCG is explicit=
ly excluded.
>
> HVF isn't withing security boundary:
> https://lore.kernel.org/qemu-devel/abAcaahy_FsBonZ7@redhat.com/
>
> For the "other accelerators" we should ask confirmation for respective
> maintainers. AFAICT only KVM and Xen are expected to be secure;
> MSHV, WHPX, nvmm and nitro didn't opted in yet (Cc'ing respective
> maintainers).
>
> Wouldn't it be better to have a document describing the security code
> boundary and have the AGENT.md refer to it?

We do have such a document:
https://qemu-project.gitlab.io/qemu/system/security.html
and the AGENTS.md does tell the LLM about it.

It puts all the virtualization accelerators within the
security use case boundary. Personally I think this is
reasonable -- the main reasons for having TCG outside it are
(1) the TCG emulation itself is a lot of code and
(2) it is a convenient way to rule out an enormous amount
of old board and device model code in one go.
This applies much less to the hvf, whpx, etc cases as they are
using almost exactly the same board/device/core code as KVM.

The idea as I understand it here is that by giving a very
brief summary of the other document you make sure that the
important parts we want to emphasize are in the agent's context
and clearly stated. But I'm no expert on how to craft these
files...

thanks
-- PMM

