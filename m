Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 96B90C87FC5
	for <qemu-devel@archiver.kernel.org>; Mon, 21 Jul 2025 17:31:45 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uduME-00074e-4a; Mon, 21 Jul 2025 13:31:23 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1uduMB-00072Q-Uq
 for qemu-devel@nongnu.org; Mon, 21 Jul 2025 13:31:20 -0400
Received: from mail-yb1-xb35.google.com ([2607:f8b0:4864:20::b35])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1uduM9-0002ea-Mv
 for qemu-devel@nongnu.org; Mon, 21 Jul 2025 13:31:19 -0400
Received: by mail-yb1-xb35.google.com with SMTP id
 3f1490d57ef6-e8bbb02b887so3803402276.3
 for <qemu-devel@nongnu.org>; Mon, 21 Jul 2025 10:31:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1753119076; x=1753723876; darn=nongnu.org;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=s1S1oVJRSu8cA1yDkDBdcWoMZkp07Rs2H6Qz8UktHOw=;
 b=bCYcKgBUhEFllK/OPNfn8zvOLvJpL2oCZQ4M07em3hPxhsckD55iAYCnEoOICdkmz3
 oZOjEvqdFm+/iFcBnry9ZGIPfYxG+aQjkaq81lGtqnskoV9ozU28zc775t0W8/g+Ipix
 GsOI/tlYP6tUu8pGw6+/fTrbNYS0vg5IArjPzeJxxVJHuNb+2lSU7XnrtOyjdLK1oXS9
 wXs6FjUVarwY+6uoYYE9gE5hw2gw3T6CEs+liTK7njX2D6vEU0loXWHGFqz3X8xmwTXH
 AQjlk6H/z5cBv14AJuXa3p75FZtV4u/kRaPe6ApOqtHutx+0D1wjjHmx7wnyxHuwJ8R7
 vhRg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1753119076; x=1753723876;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=s1S1oVJRSu8cA1yDkDBdcWoMZkp07Rs2H6Qz8UktHOw=;
 b=HdYUYS5rQI6p/ZxsCVpBM4TktxIA29RNyBrvAOQGCab8J2uEMtsV3UNUfCicVgOWcP
 9vn8z1ZO0jMW2m0e/6fq5pI+ThuIXxdQs1Xa1wVDauYCdLOthzJ65UscxM0eEP3Z3UMT
 FaNp+RNom1Q9A+NNFyqTyJS05fkJoP8NbeC2GBhtnq/dOoT5R6puxSkDHPC7f7TUm/gc
 LNFvqx9J/I1wSrpi2BFNkiVWQ95VF16iQLbbA+Vb/9SCEmcy8eGKrSNy7I8oXc0Cci2J
 p5eMBeBiJNO3gM6NLBoEB1lIBtAqVsPgF17Gjjv87jn+m1pQSYVSg1cYJwr79vmTNJJC
 BGnw==
X-Forwarded-Encrypted: i=1;
 AJvYcCVFKG3rmmU/eQ+s2QUKrzvCcp78fYqCH03XetR14/7aQAPke1mHOQ7hwZxw+lV3fI3xVTh7pr3pQ5E7@nongnu.org
X-Gm-Message-State: AOJu0Yys6BLFWOWtpItHF2pIa+tEa03p8/772v09GmjENNLyYsx/20Oa
 Q98jbkMw+SVaXdzVLDrpdorzJrLBntiHzMUH2qQXrn9JmYaU9ZJzcwnhNshfoU35yhcRA8/cGAq
 w8qn4c1C2v230pmWpvw0UZijLdDb+4+9JHG1AID/ntA==
X-Gm-Gg: ASbGncvjfMcAC3dCqD9CGPgk5cXg0dCAEefA5zadraDhvwl3a04KCy4VqgqsmCb3fol
 8ZIclGfS56mZNTa8vVk2rxaJCFLKSILekvZ5vV1T0kfE5FEsQIkjkfBDXb6+hhGJaiX52h3RHLj
 YZqT9w4IBpMLKB7BYJGhjMXj2632068W0RQYhY8BvTyG8Igq49C0LVCssiYgG8Bf3CWYTDoUUEQ
 eZ+rJBL
X-Google-Smtp-Source: AGHT+IF60DYawDmSXQS8ILmv6iBa56zAUbBTqBTFnZgJ5UdYbKdBBdvOietg8V8PsqyGLb1Bo96kZlzE3WmH8fgTCMc=
X-Received: by 2002:a05:690c:d0d:b0:714:3e9:dd3 with SMTP id
 00721157ae682-7195216058bmr168473147b3.6.1753119076434; Mon, 21 Jul 2025
 10:31:16 -0700 (PDT)
MIME-Version: 1.0
References: <abe00af4-3af5-4c6b-8443-b7350a4d9349@tls.msk.ru>
 <96201a23-784b-4268-b011-a6912175d237@linaro.org>
 <c0878723-62e3-47cc-810e-6ba8a0bd30cd@linaro.org>
 <8a50f07d-ef0b-43b1-b49c-335ca6a7ff70@linaro.org>
 <bd3c403c-6aa2-4583-a50a-5cc5fcaca2b8@tls.msk.ru>
 <e1272431-f38d-46ee-8140-38e2c3418399@linaro.org>
In-Reply-To: <e1272431-f38d-46ee-8140-38e2c3418399@linaro.org>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Mon, 21 Jul 2025 18:31:05 +0100
X-Gm-Features: Ac12FXxbb5dwSl_ddM6Visu0YV8CY-i_4DT5KL475R7lNaOWU0XqDXxKtp5hpiE
Message-ID: <CAFEAcA9zM1+qWLhfErnokzzYWbnMizKLfBe_Be-AqrqG72c7jQ@mail.gmail.com>
Subject: Re: apparent race condition in mttcg memory handling
To: Pierrick Bouvier <pierrick.bouvier@linaro.org>
Cc: Michael Tokarev <mjt@tls.msk.ru>,
 =?UTF-8?Q?Philippe_Mathieu=2DDaud=C3=A9?= <philmd@linaro.org>, 
 QEMU Development <qemu-devel@nongnu.org>,
 Jonathan Cameron <Jonathan.Cameron@huawei.com>, 
 =?UTF-8?B?QWxleCBCZW5uw6ll?= <alex.bennee@linaro.org>, 
 Richard Henderson <richard.henderson@linaro.org>,
 Paolo Bonzini <pbonzini@redhat.com>, 
 Stefan Hajnoczi <stefanha@redhat.com>,
 Mark Cave-Ayland <mark.caveayland@nutanix.com>
Content-Type: text/plain; charset="UTF-8"
Received-SPF: pass client-ip=2607:f8b0:4864:20::b35;
 envelope-from=peter.maydell@linaro.org; helo=mail-yb1-xb35.google.com
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

On Mon, 21 Jul 2025 at 18:26, Pierrick Bouvier
<pierrick.bouvier@linaro.org> wrote:
>
> On 7/21/25 10:14 AM, Michael Tokarev wrote:
> > rr is the first thing I tried.  Nope, it's absolutely hopeless.   It
> > tried to boot just the kernel for over 30 minutes, after which I just
> > gave up.
> >
>
> I had a similar thing to debug recently, and with a simple loop, I
> couldn't expose it easily. The bug I had was triggered with 3%
> probability, which seems close from yours.
> As rr record -h is single threaded, I found useful to write a wrapper
> script [1] to run one instance, and then run it in parallel using:
> ./run_one.sh | head -n 10000 | parallel --bar -j$(nproc)
>
> With that, I could expose the bug in 2 minutes reliably (vs trying for
> more than one hour before). With your 64 cores, I'm sure it will quickly
> expose it.

I think the problem here is that the whole runtime to get to
point-of-potential failure is too long, not that it takes too
many runs to get a failure.

For that kind of thing I have had success in the past with
making a QEMU snapshot close to the point of failure so that
the actual runtime that it's necessary to record under rr is
reduced.

-- PMM

