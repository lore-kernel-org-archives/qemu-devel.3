Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 038EFCAC5B8
	for <qemu-devel@archiver.kernel.org>; Mon,  6 Oct 2025 10:45:57 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1v5iid-0005jd-Uy; Mon, 06 Oct 2025 06:45:27 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1v5iib-0005jV-Kh
 for qemu-devel@nongnu.org; Mon, 06 Oct 2025 06:45:26 -0400
Received: from mail-yw1-x1136.google.com ([2607:f8b0:4864:20::1136])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1v5iiZ-0001tw-Sz
 for qemu-devel@nongnu.org; Mon, 06 Oct 2025 06:45:25 -0400
Received: by mail-yw1-x1136.google.com with SMTP id
 00721157ae682-71d6083cc69so52041317b3.2
 for <qemu-devel@nongnu.org>; Mon, 06 Oct 2025 03:45:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1759747522; x=1760352322; darn=nongnu.org;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=eMaGnUsZCpqokauiFQ22fkXOuWUzUHSGajexyteOvIg=;
 b=YOtFkoP8eNtw71Rn/KtNmy+Su515FeFBCbD6fOJa40jO6VA6dCK35oJmaRfBBK4ukX
 dOFlVphWo6BH3V8MY0Dbvzi/UtmDDuZlwVWtKDam8U/o09ecBMbYTm35wFldmucn4Swm
 N6eSg4JuMyBk6r5dM0/IcHmRMe9wIY6VH82ZzMEnQxpH+Vdq7V8J2uH5ElnBfddBoh/w
 l8mcHBgI1H3KTdoPuJ0tNwK58hEk/jnKelzaB0OmT5BbSwh9e1foOGthiHfcHew9RjcV
 XkkxzuboNQ2DKxmVF4WkLb4y3CEdM0iw8O/BTI84GrMSLe+aSMnpX46PnVJGnaRGCNPm
 CzYw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1759747522; x=1760352322;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=eMaGnUsZCpqokauiFQ22fkXOuWUzUHSGajexyteOvIg=;
 b=JmDGO/Th0Vv2jHXfbFzOIz0o48OzhZwQfd7z+2G2CKwuWJtOmoz9TYn2+qe/yxOwXS
 OXvAzgAEpz3gm8tuz71N2IRNEX5w555c5JaBOanVfWtRX3XcuQDgbdUyBFwGvj9FyQ0w
 VInkKxUKCuT7n8v/nD/mJkbFFd3J5BoqRRI1O2vplVJcY4tr3PWJBeH3OuZKlW4IUcyE
 UJ7egsT5RKvqGHPF37ypJC25sftXiSj0trDzpqfXpYDHW4V8QOjaotiPtsh8viAjnwfO
 NNLBZjgGIOyPyUFuEIqN6XDWzIWyl7FZGtAMrtpwDWX6jqpYk/uKt4I3OeOG23kbYFpO
 +kmw==
X-Gm-Message-State: AOJu0YzKbbuJxyeVGmohJJLzmUjTMPFUNY9z84WzH0mTBjtxRSffOOaT
 bgBPMCpWUiu5i9AZUvs0R7JXiqVy3wgUbKLaBAFDeIcBUXZPgt8FrGKSfmAVuvavKs7evzPBNB5
 dpcdeTAdhrnC6QQt5yFTBweIbAA4DBqqeQsTBQQ6Kuo1TeQKQf9cH
X-Gm-Gg: ASbGncsWuyjo/J/RrbdvHomaqJFufz+MVektqvAh8+f3JVPU+DmQ5ddhYPnXeWnPS3E
 Yrhz2NqOI2nO24nrI+hrghiM4TIxoCH8pZyQsP6wSS7jIlO1niZNao6zFyR7mtwYlolDEGebMv/
 o8liHl2r3EBEa8P2vkqaSDf7jQykq9L5hEuSt5bC5bb7FxPpb002++4r7hWC+KmltnVGx7N0s7U
 +dkd19PZ76bCLdAfFrOcOaf5VHDz6WSL8FpMAZI8/HWGxE=
X-Google-Smtp-Source: AGHT+IEyyalpiGapznVq6AKtMwu9Aj7oKmWJQDmRVajTXrNYnc0mH4sRUcYFXIGObJJbvj8EAUSlkiSFdEYDU355YWo=
X-Received: by 2002:a53:c80e:0:b0:627:bded:b976 with SMTP id
 956f58d0204a3-63b9a071409mr9113419d50.22.1759747522405; Mon, 06 Oct 2025
 03:45:22 -0700 (PDT)
MIME-Version: 1.0
References: <9EF1806D-4C25-4980-B1CA-16616FA8E32F@livius.net>
 <CAFEAcA_h3-iWubDg++jcO6_S_o_Z1-Xm4RMHqLYq8T=1naADug@mail.gmail.com>
 <84A761E5-6FF2-45AC-883B-AB441E3894A0@livius.net>
In-Reply-To: <84A761E5-6FF2-45AC-883B-AB441E3894A0@livius.net>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Mon, 6 Oct 2025 11:45:10 +0100
X-Gm-Features: AS18NWCbEo3nBIkkiG6fRjsH6g6MA0p7bCanMhVwz914poV3tcdyHzJroZLKGbE
Message-ID: <CAFEAcA8DvpFmCPQJNNKkA-K8piRZ_m=FWDmHGF5bGb0uAM4JrA@mail.gmail.com>
Subject: Re: qemu-system-aarch64 hangs in a cortex-a72 test
To: Liviu Ionescu <ilg@livius.net>
Cc: QEMU Developers <qemu-devel@nongnu.org>
Content-Type: text/plain; charset="UTF-8"
Received-SPF: pass client-ip=2607:f8b0:4864:20::1136;
 envelope-from=peter.maydell@linaro.org; helo=mail-yw1-x1136.google.com
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

On Mon, 6 Oct 2025 at 11:05, Liviu Ionescu <ilg@livius.net> wrote:
>
>
>
> > On 6 Oct 2025, at 12:55, Peter Maydell <peter.maydell@linaro.org> wrote:
> >
> > Notably 9.0 is the first release which included
> > commit 59754f85ed, which enforces the architectural
> > requirement that when the MMU is disabled unaligned
> > loads and stores must fault.
>
> Ok, this is a good hint, a loop in an exception handler is a very likely cause of the program hanging.
>
> > ... (You should be able
> > to see that in the -d debug logs if it's happening,
> > or via gdbstub if you put a breakpoint on the exception
> > entry point.)
>
> I'll try to run a debug session and see if this is the case, and fix it.

Note that depending on your compiler's config it might assume
unaligned accesses are OK by default (because they are when
the MMU is on for v7 and later CPUs). If that's the case, it's
possible the fix might be as simple as "recompile with the
-mno-unaligned-access option in CFLAGS".

-- PMM

