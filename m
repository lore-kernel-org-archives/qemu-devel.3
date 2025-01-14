Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 647B5C02183
	for <qemu-devel@archiver.kernel.org>; Tue, 14 Jan 2025 10:16:01 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tXdx3-0001PA-Ns; Tue, 14 Jan 2025 05:15:13 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1tXdx1-0001Oh-QS
 for qemu-devel@nongnu.org; Tue, 14 Jan 2025 05:15:11 -0500
Received: from mail-yb1-xb2f.google.com ([2607:f8b0:4864:20::b2f])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1tXdwz-0001ZW-NC
 for qemu-devel@nongnu.org; Tue, 14 Jan 2025 05:15:11 -0500
Received: by mail-yb1-xb2f.google.com with SMTP id
 3f1490d57ef6-e3a26de697fso8533829276.3
 for <qemu-devel@nongnu.org>; Tue, 14 Jan 2025 02:15:09 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1736849708; x=1737454508; darn=nongnu.org;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=MZOaVF4GnQtygz460sAKV15bsWFOvRQ7ood1S4NDLLA=;
 b=fkmcyfdZnM8nGnFvhaxsuggFHcl5qI3Ik8qvFspksZNIn9uEirWx1WWoY7/6+5BAuw
 CMko40yayyZunYXKc/QaLBYjQmt/lhVxVvvc86hI7DiUbttKBg8A4ERW9TCDXkrk/lCg
 q07MgD21+Or76utDptAlhWjYyshVuN4HnQ7rvdlPjw2neXTTq57B9Vnze2X3IGsEYIm7
 4YhmzZByn6mefmwnnxXgz2SaFzLKXb0eSc5EAHw1FD8+65PdGQL+6e5VBTZ74BcLQhew
 xMx24Hv5bq0QrJ7YguyDW2Shv/ADny669H3UE6O9UM76eEZTOhtQjn/o7QI9PtxC1nKL
 iLnQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1736849708; x=1737454508;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=MZOaVF4GnQtygz460sAKV15bsWFOvRQ7ood1S4NDLLA=;
 b=DUemKJ7MgNT5SyFtWcIQ8MADsk6JRPuXmKsc/7D4LTA3787zLMTp+WzSxiXR6y+cyh
 yq6BX3SX70tvUtSgcwXpcIPogT4pXy3gUOzDisJG3ld41aJfxSEDkgzJaPAHeOp8Je0W
 BdApgfQaLm4G1R6VVIomoFt2rceTAUxJboFSKdZWl5apfePou3aMoU8tmFY0ws+R/IMW
 duKxi1OQkXUqropoaM/tkF6TetyCjzHdnlk3x1qOlNQgarPkuJ3Gek8xNflKY1d/SjCh
 zrJVnn0v6L7rERGdbZDfiLpq+aWpKz0mLkcICXPgfxa+wHyKup56jYbov5E8oMxOK1Mo
 m6Bw==
X-Forwarded-Encrypted: i=1;
 AJvYcCVqOQMoexzRKsytK43nm35FPzTBcRyYGdN1awploZQSa2J2efcSmND6HWJWQscf9js2TVEgVhd1+IVF@nongnu.org
X-Gm-Message-State: AOJu0YxPKn9ZhYfO6zn03PxPO/Ht6eE6+CfdegpM3QQwZciDuNSb2dAU
 ZaYE24o9xULaOilpRINg6Qs6F1Tp0NqgRkREQUvrPg9PxFtPmG+ZG+FjdsJS+YKYrZXgpqiVd/j
 ut0R1obT/AUnMPmc6KIz1LcOtW/MjRf+EbnKCFrccyuuvYI39
X-Gm-Gg: ASbGncvrjYuAhF9Rug12WUHqU2j1Pf+ZStp3/mayEfRXxTFoxNrKStLWPgHOQ0lsj5u
 2VwGSJEEnffO1oKQq64JUEc+ZWxRaqEHgwltGmzc=
X-Google-Smtp-Source: AGHT+IH5VUYr5i5PbSKsTDdQ0D9/vGhaVTRBk068QG648MVJIwuVLQW2adFC3t1bNGinkG0extCubsrjqdIzETqKHmg=
X-Received: by 2002:a05:690c:304:b0:6ef:ac8b:529b with SMTP id
 00721157ae682-6f5312be406mr201275927b3.26.1736849708260; Tue, 14 Jan 2025
 02:15:08 -0800 (PST)
MIME-Version: 1.0
References: <20241106104041.624806-2-frolov@swemel.ru>
 <CAFEAcA-b+XcYEm1MASzedYchmy0TOpv2djqssJtQdu2CTw_jTw@mail.gmail.com>
 <7dd7787e-4eb3-47f9-bca6-2bfab69caf4a@swemel.ru>
In-Reply-To: <7dd7787e-4eb3-47f9-bca6-2bfab69caf4a@swemel.ru>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Tue, 14 Jan 2025 10:14:57 +0000
X-Gm-Features: AbW1kvawlj_SYYqjlEEOJkpessyQiInowNKZMUu5sZeLcrtw4454QiAl4i7NeoY
Message-ID: <CAFEAcA9gBph_CXnBBmrf=WfAuiLAhz=JF1ux0SZK2RGJwnK+Ug@mail.gmail.com>
Subject: Re: [PATCH] hw/timer: fix int underflow
To: =?UTF-8?B?0JTQvNC40YLRgNC40Lkg0KTRgNC+0LvQvtCy?= <frolov@swemel.ru>
Cc: sdl.qemu@linuxtesting.org, qemu-devel@nongnu.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=2607:f8b0:4864:20::b2f;
 envelope-from=peter.maydell@linaro.org; helo=mail-yb1-xb2f.google.com
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

On Tue, 14 Jan 2025 at 06:41, =D0=94=D0=BC=D0=B8=D1=82=D1=80=D0=B8=D0=B9 =
=D0=A4=D1=80=D0=BE=D0=BB=D0=BE=D0=B2 <frolov@swemel.ru> wrote:
>
> Hello, Peter.
> I beg a pardon, but I guess, we have a misunderstanding here.
>
> The problem is that comparison "if (limit < 0)" will never
> be true. Thus, "true" branch is unreachable. According to
> the comment below, it was assumed that "limit" may be
> negative, and this means, that "QEMU is running too slow...".
>
> "limit" is declared as "long long" and it is initialized
> with diff of two unsigned values:
> "timeout - imx_gpt_update_count(s)".
> Unsigned subtraction will never give a signed result!
> if timeout > imx_gpt_update_count(s), the result will be > 0.
> if timeout < imx_gpt_update_count(s), the result will also
> be > 0 (underflow). Then, actually, this (positive) result
> will be implicitly casted to "long long" and assigned to
> "limit". This makes no sense!
>
> So, to my opinion, explicit cast to "long long" is necessary
> here to get the expected behavior.

I wasn't saying the existing code was necessarily correct,
or that your proposed change was necessarily wrong.
I was saying your patch didn't come with any analysis of
what the actual hardware behaviour is, which is
how you would determine whether the fix you propose
is the correct one, or if it should be some other
change instead. (Some of my response was trying to
provide some of that analysis.)

thanks
-- PMM

