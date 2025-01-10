Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id DF953E7719C
	for <qemu-devel@archiver.kernel.org>; Fri, 10 Jan 2025 15:52:48 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tWHJF-0002eM-0L; Fri, 10 Jan 2025 10:52:30 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1tWHIr-0002T0-Q8
 for qemu-devel@nongnu.org; Fri, 10 Jan 2025 10:52:08 -0500
Received: from mail-yb1-xb2a.google.com ([2607:f8b0:4864:20::b2a])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1tWHIo-0002fw-Sp
 for qemu-devel@nongnu.org; Fri, 10 Jan 2025 10:52:04 -0500
Received: by mail-yb1-xb2a.google.com with SMTP id
 3f1490d57ef6-e398484b60bso3416080276.1
 for <qemu-devel@nongnu.org>; Fri, 10 Jan 2025 07:52:02 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1736524321; x=1737129121; darn=nongnu.org;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=acshiMArm7srx5Pa2I2/Hx8sleuA/XkPYzxDNAwY+ME=;
 b=aHoZxRnShaE32BNnM6JOh/pOvz3nMIkLZCBhsBfGUib+ocr+oZkzFiNyr3oP4Spob2
 c5UGj5Muc+qF4dJS1NastSnRBcx+Jcs18gkZCDItL8tLGJIsBGhkkNjnvTxCCsChlPy2
 VjleY+CEYKVvvfVYilsUMbbiuSP1V80E+x3BcdLgwZ2xsIH7YPLqOxTZ3DoY3q1oLzL2
 v1P2+rYQKjKz9O1xos+oaf3gP87ltW9Q+VZEEyAeZlIH1o4UkHldkWKq7F1Bx6K+cHXM
 J6JxwbJhjSXFCAqzPqs2ZR6eohVa4NReLHtcxf9LJMwrMcnK5qSsVqetJzL31HWyOOq7
 HfiA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1736524321; x=1737129121;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=acshiMArm7srx5Pa2I2/Hx8sleuA/XkPYzxDNAwY+ME=;
 b=rNC2+W4zQw+M2FOXHZ0oC3j+EIiSNO360WchHAuVXbjmZ++SWsXWzxWLIfj0GLpSMm
 xhzjfBAvSD0miLS8vNJD5CZPyAXe7iIMDOOdCHuGnbInOUSkgd5zFtohrKuiP/VdiP9T
 nJZH3Kc6GUgjnvNWz1um8BP3/zJcbba6G/JUbR8Pb3jJ6etnsy6fSpaeLDXdTaZkM3CL
 ICY6XWTEk1Wbcrfru0EVpS3B3hG7pgZ2TR2OmmgnwXmf6tDJP3J0RKTL4XSqW+MAnv9I
 ebEjyFjo6LUvUdmNvtnyt+k4EPN1mD1IA6XhXobGZbUQSRcKXCqgQMlcTs9QLU4EU0Pk
 7bzg==
X-Forwarded-Encrypted: i=1;
 AJvYcCXxr9Wo4rHfh83eifUfJ8EjVBv7D6wO90+vh08sNhz+qJjRqwSIHmYz9x1BjLtnHgGjYBOOocOfh8Mz@nongnu.org
X-Gm-Message-State: AOJu0Yxo2R/oPRhP7XSskNzJPSZESR72tZe+icDtQLh3IWK4wfZ0B9Bg
 Y9Jl1vn5Fz4X6oOXfy1WQSuw/zseXWvoeCwulFomamXKs1Xg5SnvTfAYnixK0CxXSNd1t4JmOxq
 lQfHV324gaWsM3oss0HbLsKZ4RO/tkUXVUzWqQA==
X-Gm-Gg: ASbGnct5clkBdoggN2AukV5LzA9LkH3CSeM5h5QufMnJCLjM9XUbeCYUOHDBXU2Y/uj
 ZsqRjFYmly8TJUnstKqvNo21JnnEUi3gL+fNu2fo=
X-Google-Smtp-Source: AGHT+IEockeIEtarpkLBbSdsWp8DoSVNtEIj03oQ6c97crRmnEuxl6QeLIwkKMfAbapk5yMJwYDOtRACdNkUXJHFcNE=
X-Received: by 2002:a05:690c:6a12:b0:6ef:4696:f1d0 with SMTP id
 00721157ae682-6f531248bddmr95117747b3.12.1736524321691; Fri, 10 Jan 2025
 07:52:01 -0800 (PST)
MIME-Version: 1.0
References: <20250110131211.2546314-1-peter.maydell@linaro.org>
 <877c724rcu.fsf@draig.linaro.org>
In-Reply-To: <877c724rcu.fsf@draig.linaro.org>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Fri, 10 Jan 2025 15:51:50 +0000
X-Gm-Features: AbW1kvZu6nHPy9KBXVipDdmgKfqneFBZj-dzPOlzuAGKjushJT1y9R9R8ULphHw
Message-ID: <CAFEAcA9sK4GkQwdkQuPkQqSPUCaARN5edjAk6s_EeX-NHTQzxg@mail.gmail.com>
Subject: Re: [PATCH v2] target/arm: Move minor arithmetic helpers out of
 helper.c
To: =?UTF-8?B?QWxleCBCZW5uw6ll?= <alex.bennee@linaro.org>
Cc: qemu-arm@nongnu.org, qemu-devel@nongnu.org, 
 Richard Henderson <richard.henderson@linaro.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=2607:f8b0:4864:20::b2a;
 envelope-from=peter.maydell@linaro.org; helo=mail-yb1-xb2a.google.com
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

On Fri, 10 Jan 2025 at 15:32, Alex Benn=C3=A9e <alex.bennee@linaro.org> wro=
te:
>
> Peter Maydell <peter.maydell@linaro.org> writes:
>
> > helper.c includes some small TCG helper functions used for mostly
> > arithmetic instructions.  These are TCG only and there's no need for
> > them to be in the large and unwieldy helper.c.  Move them out to
> > their own source file in the tcg/ subdirectory, together with the
> > op_addsub.h multiply-included template header that they use.
> >
> > Since we are moving op_addsub.h, we take the opportunity to
> > give it a name which matches our convention for files which
> > are not true header files but which are #included from other
> > C files: op_addsub.c.inc.
> >
> > (Ironically, this means that helper.c no longer contains
> > any TCG helper function definitions at all.)
>
> What's left? It mostly looks like cpreg related stuff. I guess it could
> become cpreg.c?

It is mostly cpreg stuff by volume, but if I were going to try to
improve the situation I'd start by moving chunks of that out, e.g.
the PMU related cpregs and associated code could probably
going into their own file, similarly for the generic timer
cpregs and code.

helper.c also has code like the "take an interrupt" functions
for A-profile (arm_cpu_do_interrupt() and the things it calls).

-- PMM

