Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0C521D767F2
	for <qemu-devel@archiver.kernel.org>; Thu, 31 Oct 2024 17:41:10 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1t6Z9v-0004iA-Uq; Thu, 31 Oct 2024 13:40:35 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1t6Z9r-0004he-Hw
 for qemu-devel@nongnu.org; Thu, 31 Oct 2024 13:40:31 -0400
Received: from mail-lj1-x22a.google.com ([2a00:1450:4864:20::22a])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1t6Z9p-0005Xz-MX
 for qemu-devel@nongnu.org; Thu, 31 Oct 2024 13:40:31 -0400
Received: by mail-lj1-x22a.google.com with SMTP id
 38308e7fff4ca-2fb5014e2daso11008791fa.0
 for <qemu-devel@nongnu.org>; Thu, 31 Oct 2024 10:40:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1730396427; x=1731001227; darn=nongnu.org;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=z6y3FOO8OcqNeygX9RAKdp+RqY8wKyvhx/vH9nFmekM=;
 b=KmC/6psYSU5FsOCbU5NcNfN8E6HO4KCQUp3fZcU0vSdlGyhDzBkkzTZ7zNs9IRkR8j
 pBc8PflAMpQy9AesVptCXJdKrGX1yMPxWzaBcowl1fLZBoAzRlAwDH8kknvPN922rovn
 Ms5xAcPbf9fA2aYC6AvJVy43Wpp0/dG/yXRQ1kzRZcD/fU7gj1mzTTHcV1m4yPIWyads
 2KXY/I8YJXrAWQWJovEN0pkb2OYZsA5sQhBRPIQJaiF2pCm2/ZNJ36Dl3EdtW7bMr8eb
 fbjiZDAFrGqWUA0LmihXUVRFqNvoLRC3RB1qACStcUxbvtcle8ouW1W4fvYEV0llf2Yx
 6ZOw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1730396427; x=1731001227;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=z6y3FOO8OcqNeygX9RAKdp+RqY8wKyvhx/vH9nFmekM=;
 b=aL2NenDGg9FHL7hWV8D8ChrCTaIo8sZLeDexLWFOEGZqC0oqVDwlZ/zNRrK16AWyrk
 0LGHESiH35bWjXFUA9DM9psN7HN7XJTYZcKVQwk3tu9ee6GMunFQpg9nNXPSjQcKnhkK
 uh8ODbifKHpzAMSnLL4RCxSSiXJd2nvY9vgFnDHfXU0LI6m/oJXCsmfp+dq9vRhtEkmS
 7kko1RhuQ9op+8PLR6PT+/DWY3Ufmp02cagl7DXh1o5G56hJQEQgD4LgYOIFlR1gIE3C
 /cLfUMrbYNzw6omUvmEe9E66X0NftsBz+0WcwYNWto/x5C6haTs/4AvdAriSgHxllsKr
 HqEQ==
X-Forwarded-Encrypted: i=1;
 AJvYcCU7msep0khMaYt7nBgl3+hS6nU+A9fYgwCKvy5pKBh2U2fEMYlrh9xxVaa3sQDCzJrrE3b+5a7Cpjog@nongnu.org
X-Gm-Message-State: AOJu0YwKzyeI+iwsIlVWC8TrAoRo+tBCAYPm9IK/YtX9FucsvDDIaDnF
 Mha+PDE353g2N5Brm48agWIpX03fQidExYy5XV/8ey8t+qWbNMEIonUZbH6zmd3pkFfADVqHUQF
 O17jhNUK5ReHLXiA0z8br9ZLrJJ5hTY9mFSYKRw==
X-Google-Smtp-Source: AGHT+IFhYmInG+NEIn4+wv2vrRL1x39o4rSRge880z9C7zm57WYzl6ku7xnaIZFrnZxCVuR74IB7ZKoWljcEZsC7TDc=
X-Received: by 2002:a2e:9fc2:0:b0:2fb:4ca9:8f4 with SMTP id
 38308e7fff4ca-2fedb796712mr4958311fa.23.1730396427399; Thu, 31 Oct 2024
 10:40:27 -0700 (PDT)
MIME-Version: 1.0
References: <20241029151048.1047247-1-peter.maydell@linaro.org>
 <20241029151048.1047247-4-peter.maydell@linaro.org>
 <95086c66-9e1c-4013-86d6-373d68d55441@tls.msk.ru>
 <CAFEAcA_xoSkhk-dGUXw3-0hQyb1NF+6qRP-+6TpoQkFPOBs8Jg@mail.gmail.com>
 <1a18a816-ba21-4838-a9c0-fb8362ee5e17@tls.msk.ru>
In-Reply-To: <1a18a816-ba21-4838-a9c0-fb8362ee5e17@tls.msk.ru>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Thu, 31 Oct 2024 17:40:16 +0000
Message-ID: <CAFEAcA8YC82WdP_cesZVM_Luf3WBdQH8dpJHrRThE-DLzaAqng@mail.gmail.com>
Subject: Re: [PULL 03/18] target/arm: Store FPSR cumulative exception bits in
 env->vfp.fpsr
To: Michael Tokarev <mjt@tls.msk.ru>
Cc: qemu-arm@nongnu.org, qemu-devel@nongnu.org, 
 qemu-stable <qemu-stable@nongnu.org>
Content-Type: text/plain; charset="UTF-8"
Received-SPF: pass client-ip=2a00:1450:4864:20::22a;
 envelope-from=peter.maydell@linaro.org; helo=mail-lj1-x22a.google.com
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

On Thu, 31 Oct 2024 at 17:31, Michael Tokarev <mjt@tls.msk.ru> wrote:
> What I see is that the whole thing - plus one more commit right
> before the mentioned refactoring, ea8618382aba, "target/arm: Correct
> comments about M-profile FPSCR" - applies cleanly to 9.0 and 8.2.
> For 7.2 though, this is definitely too much because there, tcg code
> has different rules for the temps, - in particular, it frees all
> temps explicitly, so new code wont fit there anyway, resulting in
> leaks and requiring major re-review.
>
> Being niche, I'd not bother with that even in 8.2, but the fact
> this refactoring applies nicely.. :)
>
> It's probably the first time when the difference between many
> changes but tested in master, vs smaller possible change, is quite
> significant.  I prefer for it to just work ;))
>
> 8.2 is in ubuntu noble (LTS), so it might be with us a bit longer
> than some other series, but in ubuntu they build with KVM support,
> so the bug isn't there.

Note that the bug is not in "TCG + KVM" or "TCG only"
configs, but specifically "KVM without TCG" (i.e
you configured with '--disable-tcg' on an aarch64 host).

-- PMM

