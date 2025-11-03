Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2CF2FCCF9FE
	for <qemu-devel@archiver.kernel.org>; Mon,  3 Nov 2025 14:24:42 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vFvTM-0002vZ-Jq; Mon, 03 Nov 2025 09:23:52 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1vFvTH-0002ut-59
 for qemu-devel@nongnu.org; Mon, 03 Nov 2025 09:23:47 -0500
Received: from mail-yx1-xb12d.google.com ([2607:f8b0:4864:20::b12d])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1vFvTB-0000zC-5H
 for qemu-devel@nongnu.org; Mon, 03 Nov 2025 09:23:44 -0500
Received: by mail-yx1-xb12d.google.com with SMTP id
 956f58d0204a3-63f8719aa14so3593586d50.2
 for <qemu-devel@nongnu.org>; Mon, 03 Nov 2025 06:23:38 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1762179817; x=1762784617; darn=nongnu.org;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=XKkcGZ+HcJYN+K5fbdqQyz1EKbOFodBvAgo1YcbuDd8=;
 b=rN9sDi1daLhuhYH7LpaE9nfcOlvVdqK+knnK+siVGV4zh0HombHXJr0Ef2041h7w+0
 58jnfrrciCetkcff2ZSAsatvyxgzDMKSkRdx1VFGlEoIvmQWQgYN6tS3H+ao82XYRLNp
 uMtGI3ZZcckAm5VnHEJ0gS3oMpRbkBqo6e5QXOPL6oSBaxY+labPPcoF6ET/d7ND7mQ0
 QeGrmlrRuAnVkbMl/tINmTAbr0ARGS5iFd+56LVqgaFBjhDVKCS7uuThenpbMmxf8o+g
 2c26DPwy3Swf0tkSW3CVbncqTesYwHYIIUB0azLR4H6MnvQa4knuzLE5AeEP9bR3/D1w
 /YEg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1762179817; x=1762784617;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=XKkcGZ+HcJYN+K5fbdqQyz1EKbOFodBvAgo1YcbuDd8=;
 b=AXgOnt51GHsDlfBOJwQDuG+eJjHZtSLnsuQkO3ojCgFcxWh04YO9LSXC/kksHvXLro
 9r8EVetakUcvWTrz8PxUn3iiFx+UzgoKbNLLNzgVxcrKXNaDdL2LzrAXhj78j6A7OA/y
 SkOoATF5zVxrETfcE3VwziA4qEzOr5mdScsIRp2nHSN25oJzQ2mhxloS98b10UIDJ89s
 j3/5MAKcFbRsXde/cuvNUNk6FCmf8yu+NpuVdeJqxKywoLxQ/RbGfbemzK9dPzpwC58d
 o9LnQH4KIUU4/Z0PEa8MGwhWNJ6Koq/d29AnTrF4leUQvvhbd8RuMU9slx3bORKqVNOW
 mRMw==
X-Gm-Message-State: AOJu0Yy2Pp+bOpvOPYIs+JE7TaFXGgATVZHAg73BTuhl9pmEb+8sopSy
 gx4uRMEKCC/cTTB3IHNRCuPckKbJj/GxTWm1n+gYhHHoFZRz4iNcz1g+s3xPZCzsrf0WZ8qW1Hu
 xsUgKPE9m17dQbIFmFv9Uz9OcOXAYoqBBIMPGhQrh5w==
X-Gm-Gg: ASbGncv9I9PY0pqr/KRZDt2Ft14Mrsy5kpghPq2QANNHc6Xxo2Q2gmjGewsqb9Yf+Fy
 eFAwdJkT4UxA5F83oaTtm/LXU5zAjLsNjRGQmMip7jaPFsgdkpLljDmjdp9yUwguQX5trpTXF7i
 P6yEiLtXiirWwRLYXTV/zbPdFFp5tlQ603pBg8Yt9SkY5O48CuFQQVgCRjtGJv1dehGN4p2hbsM
 bP2z10O9oYFyLiPGga+rgNitQnFghHt5p63JhEq8ElYd7PV6hzixeZ3Z3kbdQ==
X-Google-Smtp-Source: AGHT+IERkGdeRonvjU5STPiPISKMyat5lQXpo2iyKdG5TCCvSjINh5AQxtpgUR8Ow+aXVu5OorX+Zc49sVubmPl+hgY=
X-Received: by 2002:a05:690e:dc4:b0:63e:3352:4eef with SMTP id
 956f58d0204a3-63f92364597mr9832950d50.69.1762179816705; Mon, 03 Nov 2025
 06:23:36 -0800 (PST)
MIME-Version: 1.0
References: <20251014200718.422022-1-richard.henderson@linaro.org>
 <20251014200718.422022-21-richard.henderson@linaro.org>
 <CAFEAcA-tVBn3g185gzs2uOCnYLeqWN_zwfeQ0DccLf0n8BN5PQ@mail.gmail.com>
 <686b4a77-cf53-45e8-9b75-2b8dd9c4a67f@linaro.org>
 <CAFEAcA_gczP+RbKUx_p28AWN=s279rPLYaZCXjy0Bpr0NqPnPw@mail.gmail.com>
 <b72c66dd-11a1-47e3-b909-9c4641e4d361@linaro.org>
In-Reply-To: <b72c66dd-11a1-47e3-b909-9c4641e4d361@linaro.org>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Mon, 3 Nov 2025 14:23:24 +0000
X-Gm-Features: AWmQ_bkY0OxQnlNePSzwruaWeDBHi2zO18OMvr6vsJQjoPoo494CGsWQ7xJ13Kc
Message-ID: <CAFEAcA-t+wXnRJK2tms03Jer64yaFgj0EacJHHM=f+0GDJa0bw@mail.gmail.com>
Subject: Re: [PATCH v2 20/37] target/arm: Consolidate definitions of PAR
To: Richard Henderson <richard.henderson@linaro.org>
Cc: qemu-devel@nongnu.org, qemu-arm@nongnu.org, 
 Eric Auger <eric.auger@redhat.com>
Content-Type: text/plain; charset="UTF-8"
Received-SPF: pass client-ip=2607:f8b0:4864:20::b12d;
 envelope-from=peter.maydell@linaro.org; helo=mail-yx1-xb12d.google.com
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

On Tue, 28 Oct 2025 at 15:05, Richard Henderson
<richard.henderson@linaro.org> wrote:
>
> On 10/28/25 15:41, Peter Maydell wrote:
> > On Tue, 28 Oct 2025 at 14:39, Richard Henderson
> > <richard.henderson@linaro.org> wrote:
> >>
> >> On 10/20/25 15:31, Peter Maydell wrote:
> >>> On Tue, 14 Oct 2025 at 21:11, Richard Henderson
> >>> <richard.henderson@linaro.org> wrote:
> >>>>
> >>>> Create a function define_par_register which handles the 3
> >>>> distinct cases for PAR.  It is easier to understand with
> >>>> the definitions all in one place.
> >>>>
> >>>> Make the aarch64 to be the primary definition, when present,
> >>>> rather than being an alias of the 64-bit non-secure aa32 reg.
> >>>
> >>> Doesn't that break tcg-to-tcg migration across this commit?
> >>
> >> I don't know... possibly?
> >> I guess we have a test for this somewhere, but it needs setup?
> >
> > I don't have a test specifically -- I tend to use one
> > of my usual lying-around "boot linux" setups that has
> > a qcow2 disk file, and then connect the monitor and
> > use 'savevm foo' to save, and then check that -loadvm foo
> > with the new QEMU works.
>
> You're right, it doesn't work.  It'll make the 128-bit version more complicated, but I
> guess there's no avoiding it.

We in general do not have a good story for handling
migration compat for sysregs. See also the
"BOGUS_DBGDTR_EL0" sysreg which is an ad-hoc way to
deal with "if this is in the incoming data then ignore it",
and Eric Auger's series that tries to deal with the KVM
situations where the host kernel might remove sysregs and
break migration for us.

It's possible that there might be some unified way to
permit the sysreg migration code to handle "the underlying
way we represent the data has changed, we need to fix
things up on migration input" so that (like the VMState
handling) we have a mechanism for changing the representation
the rest of QEMU uses at runtime without breaking compat,
keeping the impedance-matching code confined to migration.

But that would be a big pile of work, so for the sake of
FEAT_SYS128 it's probably better to work around it...

thanks
-- PMM

