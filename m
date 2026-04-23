Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7B41CFDEE45
	for <qemu-devel@archiver.kernel.org>; Thu, 23 Apr 2026 19:03:42 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wFzKg-0005Yz-CH; Thu, 23 Apr 2026 15:03:26 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1wFzKA-0005T1-94
 for qemu-devel@nongnu.org; Thu, 23 Apr 2026 15:02:55 -0400
Received: from mail-yx1-xb129.google.com ([2607:f8b0:4864:20::b129])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1wFzK8-0003Xm-Kw
 for qemu-devel@nongnu.org; Thu, 23 Apr 2026 15:02:53 -0400
Received: by mail-yx1-xb129.google.com with SMTP id
 956f58d0204a3-650775f427eso7639571d50.2
 for <qemu-devel@nongnu.org>; Thu, 23 Apr 2026 12:02:52 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1776970971; cv=none;
 d=google.com; s=arc-20240605;
 b=ImvJcI10WkaZ7En+x4GqS6ZKRKFKGLaPU6dfLlfrAaRII9zRQHmezjUCd4nfECvFBk
 cSEPZc0VnMQFftRMF+GDMqlYt/buY8JCUgN2fb1DUyS3nj2VfEc4gnOKRtlJtxUrNjc7
 9j7BhRJwWQFkg28UJOP0NvzFmeO7QKQHTUm0NhVwwrX+BJjNLLgHl4F4J16fHqIZQpS9
 xFPztlIbV+ThaS7RMl192k72NY73KyxZanAt5aLUISUznERxa2YdHlMWsxvmXf6pJzwg
 kQO2paCgwVT72G3FMX+mchSVs144e4OXbgejYpCxpxFhywO8q+W5sw5e9fT16XcGSyHe
 uuIA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20240605; 
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:dkim-signature;
 bh=CZp4zRIVLXMleEdRu4MXSsWwj+dE7/TBoBP8GARImKQ=;
 fh=GdGH+INzp36R+2qBxm5kSbrNIVDu+9BpevXdZPOV4VY=;
 b=H4IYA614UyyFRzc4YMAKw9CwPWZQqPwvft2kXGVsO9zHwjMfW+xRfEnWx/fnBjUhra
 rVw/+AaBoT7XZqiHTv4mHlRr1kCMAEep1/n0eDTWunCokCz0O4rGUaIHu8h/bA89sW3p
 x/106Fgs0TygJc9ijMz+CcMsFdL+DLnbnJWv+k4bjmC4CEmoywRZZ8Vj5RsUcNRUlRnD
 +v/i16v0euYWRAmD9DMcH9HA6giQdZz5rLWBH1qlUPLWb0QqDGxNll1i9YksniuNzEUM
 wgrSPrbFR9nbUUxisgHKQoQGuI99nOYxVqTEtW3Y1a8Iw8SBCDGTS8G2Qh9Oms/woY0n
 rkWg==; darn=nongnu.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1776970971; x=1777575771; darn=nongnu.org;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=CZp4zRIVLXMleEdRu4MXSsWwj+dE7/TBoBP8GARImKQ=;
 b=k2owe53v85vu2yruJjrF7UGGHU0WKhXJiZxWzlE8leMMJ1M3RqIbQzlmtiVGodaj2s
 l2NDX7JBibbLPPB4zfLnfgf/2OPgGJJBBKqUh3FiKzxVjv9eXkj2aTb3clhbk5ZSFcYM
 azbhRNOvqi6HngappYn1EG20cEupR/izEk435LCOiCbHum5xzxnhAt9hjzdslFiKYRKc
 yrJ3rajoTOyBVBoLCvBP5UaA5MG924HfE6GjlVS82ig5W94sPNoBhx30HICcm452ogo0
 61LPatH3/g4tHT2cnbh9MXaCwhGibpElV6o5AAM7CCCXb/qEPTvvwL9tcIBOpedoZKWE
 MsyA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1776970971; x=1777575771;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=CZp4zRIVLXMleEdRu4MXSsWwj+dE7/TBoBP8GARImKQ=;
 b=Wu4Tvt8KopGLJUL02XTV7GG+HM/4BGg/nlYjXoQPRnpT2cep1l7ZCE9S+qEgV1LiMP
 7nwkFW8RMINH/IilaIzUHZfBECd+4zz2nnmEmUxILra9CU+Dx0dkOZDaIWSm/9AL20gN
 cwkiP3gPvaiCAvAH22K+yXeZLxdhU8DqaPqS32bDV/74pMcHxCzlME7MWrDBWF03exMu
 Xac9kl8bduSO9L0Z2KjpN/FnpnfbzJNCr6oT0imd+W8pmQ3HP+DoFvGgKUblwKyUEa8C
 uvaM7NFCwXpuGgzCmgSVgEDU22E3sdBUEtq/UWbBe2QQjKODqyfxK5gPw4lB4tMG7oe2
 ZycA==
X-Forwarded-Encrypted: i=1;
 AFNElJ92aHLdsA7ylNAy2RcamLNYURExDZ7ZowfMp+HCVNlOwt1WLZQrl2QkLJZYg3Jn7Ey00EmFG+QSf0aG@nongnu.org
X-Gm-Message-State: AOJu0YzyvjGInpfb4i0MoJGYgzuDfjdtycLs477BExDP7V/Is3vOeC4P
 gnxz8TO7u9iVLy/gXVdd23rE+9b+5Ew3Q9ch8lSWpR8XOi8dw7wjK0A97nserQZ7XXNXkch/10x
 ZrvgtjkGufUEjdZ47nrA6Crl5lbNr/A5bXLP5wHiozg==
X-Gm-Gg: AeBDievtJC2ENgXucCnZFwEHuPn3e8HikeCP71FEripW7q3uvDyd49btSf1kGTSe7xP
 eX9KiqcHsLEeIdpo2zl6xwiIum29OXkV7tk3djZNDqIysaMcuI+gnKoTWNrBTWd9LH9OVpCq6R9
 KGHQGhZUKiwhzDsiuIAY6KI9Fv8DMsn7/d0dwgrFn+ANyuqMQZUl3F6e+IgxVxjLGV/CODdt57Z
 tc3Agx8XujNof9RoPfHUb87vuNjFVm4i8JSReGUmsi8uo7IUqkSmogxV6MwgBi5RIk058RnMsUJ
 3Q+HbB5bQP3PtK4nhp/moE37uqvohRocXlWkQMBNm8YaFAwLZbOvI22xucBgzqm+KauDQ2sAGWk
 8TQ==
X-Received: by 2002:a05:690e:204f:b0:64a:e222:d3fa with SMTP id
 956f58d0204a3-65310b4ff1cmr20149822d50.58.1776970971431; Thu, 23 Apr 2026
 12:02:51 -0700 (PDT)
MIME-Version: 1.0
References: <20260413230251.22537-1-richard.henderson@linaro.org>
 <9136e278-f553-4ebb-aed0-ce2e0a2e2a4f@gmx.de>
In-Reply-To: <9136e278-f553-4ebb-aed0-ce2e0a2e2a4f@gmx.de>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Thu, 23 Apr 2026 20:02:39 +0100
X-Gm-Features: AQROBzDNqkFWLQhiyNX9UP89OABXWLAoXKncRyxB66jSobtM7ckf7eqKY1B4yYs
Message-ID: <CAFEAcA-7PbOLT=SeMeMeUVbBfv3EEbzBuDWiLyOAgCK6jRWUkw@mail.gmail.com>
Subject: Re: [PATCH for-11.0? 0/3] linux-user/arm: Deprecate nwfpe
To: Helge Deller <deller@gmx.de>
Cc: Richard Henderson <richard.henderson@linaro.org>, qemu-devel@nongnu.org, 
 qemu-arm@nongnu.org
Content-Type: text/plain; charset="UTF-8"
Received-SPF: pass client-ip=2607:f8b0:4864:20::b129;
 envelope-from=peter.maydell@linaro.org; helo=mail-yx1-xb129.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=unavailable autolearn_force=no
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

On Thu, 23 Apr 2026 at 19:54, Helge Deller <deller@gmx.de> wrote:
>
> On 4/14/26 01:02, Richard Henderson wrote:
> > Deprecate nwfpe emulation.
> > But while it still exists, fix thread safety.
> >
> > r~
> >
> > Richard Henderson (3):
> >    docs: Deprecate linux-user/arm/nwfpe
> >    linux-user/arm/nwfpe: Replace user_registers with current_cpu
> >    linux-user/arm/nwfpe: Use thread-local storage for qemufpa
> >
> >   linux-user/arm/nwfpe/fpa11.h | 25 ++++++++-----------------
> >   linux-user/arm/cpu_loop.c    |  2 +-
> >   linux-user/arm/nwfpe/fpa11.c | 12 ++----------
> >   docs/about/deprecated.rst    | 12 ++++++++++++
> >   4 files changed, 23 insertions(+), 28 deletions(-)
>
> I've applied this series to the linux-user for-next git tree:
> https://gitlab.com/hdeller/qemu/-/commits/linux-user-next?ref_type=heads

Please don't take patch 1 -- we put a different version of
that into git already before 11.0 was released.

thanks
-- PMM

