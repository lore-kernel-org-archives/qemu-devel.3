Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D52E610F92F2
	for <qemu-devel@archiver.kernel.org>; Tue, 31 Mar 2026 19:44:19 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1w7ezy-0005jO-F5; Tue, 31 Mar 2026 15:43:38 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1w7ezw-0005j5-NO
 for qemu-devel@nongnu.org; Tue, 31 Mar 2026 15:43:36 -0400
Received: from mail-yx1-xb12b.google.com ([2607:f8b0:4864:20::b12b])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1w7ezv-0000Oe-5D
 for qemu-devel@nongnu.org; Tue, 31 Mar 2026 15:43:36 -0400
Received: by mail-yx1-xb12b.google.com with SMTP id
 956f58d0204a3-6501c0399c4so5011146d50.2
 for <qemu-devel@nongnu.org>; Tue, 31 Mar 2026 12:43:34 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1774986214; cv=none;
 d=google.com; s=arc-20240605;
 b=Fb3q1igzuIOFYzVP+CVbeFIvkNYNZHoGv0iKj1AQMGoVXuuC1eeMSRPmN0DdAc+Z/t
 YFeHRB3z+eWjyBOnpOjGpg3cOhXi4J306MlXmawF+vkVuSCAVFuF1wtNPbEejqY8q0Wx
 kAIL2TQvxTzrILnZ6TknRZc15Aj+8ahmAImLzvqEGBYbauyjBPwuD4Y291ol0pmPZkAr
 tIXs/9jkwEyVd3AFjs2EzBR/VUHqFgkBgdXi4RzPtUdd7NxQHXjnbJT/NGtx5NddMo8B
 P2JUdfYIohJ/zRsvc4E2XXRibsnlkrl0OuC70Abfofja6ijjDdr9NY7D5/ig+kzPqYhy
 Fw7A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20240605; 
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:dkim-signature;
 bh=LJfhvqOb6QaUZImqawhRFQSZYNsWaXyemE/YZ9ISxO0=;
 fh=j0m/KHqzOQ6CKKktQSBLLiVo/M7SZnjHIyl4bugXt+Y=;
 b=Y5DvwVoA7Qf7asSXZbySl+XaYvGiFYBkk5HudVVTWiNfh/1vs+fGwPSpIcEZc/6Pvk
 ECn1ZNV8pZYX5jQuGFOBGTw0ez6qjDqwGA5Tomo0oUyKL/tun60BA6tAG0Y0ZJNi9Y8n
 vIu0xcYyb6cIKWQ39ntpA7VyWAoNAf6uRYjYlzktawn2xzdUvxbx6UI7qvt7rkuOGWur
 VPLKFPJa2g6OQp6CeFqVHiLdIdmaha9NXHbJy4PzivjlrwzAeTWXvBFqBzixJakiloDN
 lKmk8SxHGNGqPPCFPBJlu3x7t17pGUd0vg89LueHveNI0L0KqKCfaMBa+n0gTxxcCQrk
 Ircg==; darn=nongnu.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1774986214; x=1775591014; darn=nongnu.org;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=LJfhvqOb6QaUZImqawhRFQSZYNsWaXyemE/YZ9ISxO0=;
 b=Dwcok22bVcdWGKi1b8FzDNG/eQswNVZDYNVhH3nYK5yOrwmZj2iHspH36nEb4BFHN2
 IpC/5/ZPyHMC3ddhyESGZh50pmQgQ1i/00fXzCFI4vhVKvrI3d8cZBRZsWww7qtvlagB
 LM03gvoIN4FGu1PVD4nIC2V2Ei5SyINRyZmI9A2nbdVhRRgt2MTAQ+ML85aQl132Y4C8
 6AIW5kCsIudPCbeR3ofH+7tkjo6Ft+hxXKVyjhCz+KFFCMMluBmiWjvvr4pNTs2c8y+n
 6FK6W0jDTMeQAifbau7o6vk00KQVaypySjwfwwZzSsDt0SPfA8qOil8JevGtHNwqocld
 eOug==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1774986214; x=1775591014;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=LJfhvqOb6QaUZImqawhRFQSZYNsWaXyemE/YZ9ISxO0=;
 b=ifNSK9cQ6FR3KmHdp798nU5+LWeRBnbZtRWTORzacO+DLfVX+eI1XSge0swKWfSbsu
 taZ5A0QW6fJnU+U/fQLB/UP45bP4o8xzksqv+jFmV2bsUw3veQCLl1YNyRTJHlx3jkeF
 H33yp4nKzA29p+d5LFS6xCRk/tvK4fJxrv3vJOrQQ7YKN1ULGT7RvVTiWy6zs76kPIMt
 rVgb7WRVlv44NKCQwfy8AyBCgByPOx1mCzffmky+SXrg/LLKNataH50GfLg+hf9a44i/
 gct9beKMl84gAOeTi2g8opeuYqN+A5Il4K85lzcItpI/+4G7QVXANLXO556FIp8Jhf8N
 ArnA==
X-Gm-Message-State: AOJu0Yxsfbcu4fxItcvnp9iD/OLhq2YTjy2GrGaxOoKVDXAeTTlLBrBU
 eSXL42axA7MMrzRIJ/xnJTD6806QsKVolw6ekQdXwKcQbTSJOyl7Ve9l1Y8aXTn8One11GLkMEd
 6M5InziKzSbjVyGXK1QI1AcUm/U/+PmHIqwF+6k6ODw==
X-Gm-Gg: ATEYQzw+8CVz8FUAOBBipwypwTqpQ3RkiSRbHWnAHQ1jz3bka/VRE+iOggMZCbOGa2O
 OZfxlNBkXPDRXm6B42rMQGDsI5TgFPC0s1tFGv7iUy1ijbyJATiot2p7ix+g11bE1a9VJG6QTKz
 vnEQLTfnQViaJ3lZpKYyAGdfR2ZW/DdizU1u9C9iMEs4mlJ56STe0MuAw1VJvbZ6hTfqgT0hMI3
 y+aAg2FoXEuBNM9PjclCndkDzmPpib+QTHN3WloXU4KU50SzJTMOBNZTF108GUEMF+Ejx4x81hR
 sBgzE9kOkLzRKvR9iTdEPe4G1/L+Lwkothttk1MGgncyutcpjIBqafk9VnhP3wJQn5I=
X-Received: by 2002:a05:690e:1341:b0:650:3064:4d1f with SMTP id
 956f58d0204a3-6503064515dmr236835d50.15.1774986213689; Tue, 31 Mar 2026
 12:43:33 -0700 (PDT)
MIME-Version: 1.0
References: <20260321135624.581398-1-npiggin@gmail.com>
 <CAFEAcA_iwWDmZf1hojzZ8+N5RTRC4WXDSSK7SugNNRd6kdk8Gw@mail.gmail.com>
 <CAFEAcA_+_tDJstKjQVENprAa-37tX6Ta9Ay7i-nK3Hp8v7BGyQ@mail.gmail.com>
 <CAFEAcA-aWSeBaFUigBHJSKis04on4wcjAgv4Y1R5SXP5LQLy5A@mail.gmail.com>
In-Reply-To: <CAFEAcA-aWSeBaFUigBHJSKis04on4wcjAgv4Y1R5SXP5LQLy5A@mail.gmail.com>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Tue, 31 Mar 2026 20:43:22 +0100
X-Gm-Features: AQROBzD22cizGLYYIkAS4f4yl6w6C0mr6vMPHJotWURF0zgtQTGNJ-v8nCJcARQ
Message-ID: <CAFEAcA_pkMT7wdONYWdfOeHNOv7tp4SnSvWV0XUgx8kf9VpsEw@mail.gmail.com>
Subject: Re: [PATCH 0/3] user: recursive signal delivery fix and test
To: Nicholas Piggin <npiggin@gmail.com>
Cc: qemu-devel@nongnu.org, Warner Losh <imp@bsdimp.com>,
 Kyle Evans <kevans@freebsd.org>, Laurent Vivier <laurent@vivier.eu>,
 Pierrick Bouvier <pierrick.bouvier@linaro.org>, 
 =?UTF-8?B?QWxleCBCZW5uw6ll?= <alex.bennee@linaro.org>
Content-Type: text/plain; charset="UTF-8"
Received-SPF: pass client-ip=2607:f8b0:4864:20::b12b;
 envelope-from=peter.maydell@linaro.org; helo=mail-yx1-xb12b.google.com
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

On Tue, 31 Mar 2026 at 19:03, Peter Maydell <peter.maydell@linaro.org> wrote:
>
> On Tue, 31 Mar 2026 at 18:28, Peter Maydell <peter.maydell@linaro.org> wrote:
> >
> > On Tue, 31 Mar 2026 at 17:59, Peter Maydell <peter.maydell@linaro.org> wrote:
> > >
> > > On Sat, 21 Mar 2026 at 13:56, Nicholas Piggin <npiggin@gmail.com> wrote:
> > > >
> > > > I found this recursive delivery problem when testing new riscv vector
> > > > state support patches (plus a minor lock user balance bug).
> > > >
> > > > This or similar type of issue was fixed with 8bd3773cce1 but I couldn't
> > > > see exactly what scenario that was addressing. Is there any other way a
> > > > signal can be generated during handle_pending_signal()? The SIGTTIN
> > > > case, perhaps?
> > > >
> > > > Thanks,
> > > > Nick
> > > >
> > > > Nicholas Piggin (3):
> > > >   linux-user: sigaltstack lock_user_struct missing unlock
> > > >   bsd-user, linux-user: signal: recursive signal delivery fix
> > > >   tests/tcg: add recursive signal delivery tests
> > >
> > > I'm going to take patches 2 and 3 into a pullreq I'm doing for
> > > linux-user fixes for rc2, so we can get the fix into 11.0.
> > > (I've made a s/__chk_error/do_chk_error/ adjustment to patch 3.)
> >
> > Patch 3 also has a missing "#include <stdbool.h>" in the test
> > program; otherwise it fails to compile in 'make check-tcg'.
>
> ...and also my mail client somehow ate this other part I meant to say:
>
> I had to suppress the running of the test for hexagon, hppa,
> microblaze and sh4, because it fails there. My guess is this
> is bugs in the signal frame handling on those targets, though
> for hppa it might be related to the upward-growing stack.

PPC failed too. I'm dropping the test-case patch, I don't have
more time to spend trying to flush out the other targets it
doesn't work on right now...

-- PMM

