Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 890BD1076360
	for <qemu-devel@archiver.kernel.org>; Wed,  1 Apr 2026 04:32:29 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1w7nFJ-0008U7-6X; Wed, 01 Apr 2026 00:32:01 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alistair23@gmail.com>)
 id 1w7nFG-0008TK-69
 for qemu-devel@nongnu.org; Wed, 01 Apr 2026 00:31:58 -0400
Received: from mail-ej1-x62b.google.com ([2a00:1450:4864:20::62b])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <alistair23@gmail.com>)
 id 1w7nFD-0004g3-L6
 for qemu-devel@nongnu.org; Wed, 01 Apr 2026 00:31:57 -0400
Received: by mail-ej1-x62b.google.com with SMTP id
 a640c23a62f3a-b9c280322e0so7873366b.0
 for <qemu-devel@nongnu.org>; Tue, 31 Mar 2026 21:31:55 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1775017914; cv=none;
 d=google.com; s=arc-20240605;
 b=UoFDcUClTf6K+8FHEV7mq+sz0HfYL1N7s5NJQ5eEHA8PizZ0yMW+It/CB8soLfgV3p
 xuO0VlcK40+yT60WPUdAJtGCU6xTw5ykV1AgYvjnydc5bCffSJ4xVwg//jNEvap2kBEj
 ZyBGqgTttbn+elzJd4G25aayQB6hXO2PYtPxN+iRDK30AmZX6p17BS1J3NIXAIRO+a5R
 x1Yn9AQjuCZDo6CFvdhhwpTp1dBSahuTorjtzAKdiwq7niH6GkkgDJYI52z76SKaR2ZN
 NXEObqUjauUqmYxwTkkl0bzztd0cOjlN3YkxY4AXOAGAq1jQM3Fc5c0HN/FKe3vZGpvY
 vB1A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20240605; 
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:dkim-signature;
 bh=lpKiUQGc3useu/lWqj4NbLBG99ui/Ypt8uzDYOwzLC0=;
 fh=rUVrfaE9FAVhUc2T6+7zSvQIMCmjEr3kZlPEwlNVviY=;
 b=UlPReF+VFsXRcFCZMleGgWYoPQ+rDrSRwZT8jN1umd2ATPR0KFa7oCqASAWHrICtCr
 //SobhwvNno9bR75hZONyfNJIdQaAVD9MxrSCa/AGFhlW5UJ0O8PI/Rsd738Nt5/oi/L
 e2vez0OTHQKHakAjGMXGXkqfU0rV8rzHNWvrgLt144ZQ5GEZckFmQBCUs6bJtWkJoR1B
 OonYOzEfPxbO2OxOfIN5+J2jAp5MPkZc1bTdYp9oTXiBfP4kusX0cr21YJMnfLJweOEX
 6Ripfoip18YITYEDvZ6JUFNpsqDDqQtxG0uq8nZlnHdOp82zdHuROXgwhUxMHzPzWeGd
 wB3g==; darn=nongnu.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1775017914; x=1775622714; darn=nongnu.org;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=lpKiUQGc3useu/lWqj4NbLBG99ui/Ypt8uzDYOwzLC0=;
 b=C4nQja4SUfNm7k3tVwMK91d93bN46okg86qhkTSmhIwF5TMRYAfRyfBu+S4d12Y1Ew
 pXxRxoy1ixjbCWHRsNiOXDai4U5/N6wKhQQugFYMj0Uv/nuN0yLmEdn6SMeH7iGoaYvD
 pM4Q6sHlZvjEzIR7KoWCNBbN4+N9sl+USiPUfK5tK3QQUljcv594rAZh3u+/uGImavIM
 n5NJCjJIOw9oGIvLoxEshtyLs8a7LMdtIxJ9w14epvcTtuJFZ13F+OFJGOBT5Z3k47dS
 1Gtl3iWcF88CAr1plsy+hXgNMyA7B2KGlY8HnjJN9shQsgHP93KQLpOHgMkPhtg7CKR2
 bPlQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1775017914; x=1775622714;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=lpKiUQGc3useu/lWqj4NbLBG99ui/Ypt8uzDYOwzLC0=;
 b=FEXK6WhfSRfWZJHpMflQ4n4ibEtTxG76AuPTXoLBNYzC0ESMYYCwpUr/kMKYHHVtKu
 OHD/l/DUzMFbUXzN3hEIxJbKBd08gLlZFO6sGJaqQLp9KBuoH1uvvkJJkRS6YjyedRf1
 eVP0p5AQkKEjTvClCUZc5lJ0Zczscyx99SrEh5euF77vziXeOMM3Q1Pqf4FVxAQYtz9j
 Iy+0Y45nG543R6Pbo9GdPHI6WtJU+MbNk5S8GmacZ0VUi+1NUtmKjmGZxZKrdoMg66eA
 HpuB9/bEWcGxsDicc/SsbErAkRRFp89b9gSDAjFct5FIiJJKIEPSTVyd9LVULLMPsZI5
 etoA==
X-Forwarded-Encrypted: i=1;
 AJvYcCVT5Vd7ztTtoj890+d3junBL3W06wtewrgUgSb5Ke0bG1WPn/h+I0XeFiONqsK7zChzOQnR2y+KzoOW@nongnu.org
X-Gm-Message-State: AOJu0YwwfXjXGrsZ7yg/en+3gdHs//XphPkhFMaqEyI+2EI2y/O2SelK
 lHHwpxF35B7Yfsn0PrY/kKJ5JWg/J/F/Z+Ip8rtL7e6p+dL9fk62q+hNqDO7onWPUk3a3cOXKHm
 fDvlHzT3wqYtvaE88vVB2Dii0hBEq4hM=
X-Gm-Gg: ATEYQzxyQCXTxBr3YKL/0rxsv1TaGr9vvfF9Nol63iI2sIZeT6hvi0Q5cZpJmyLWDzN
 Fk3Jhs9xgD8VyP2uWvQMSjb+C98/sCaJWT9rPhxhwW3yG2/Svjq8u4U8VVabk3ZplgE1MM4e37o
 cj+UjQ4mBrMLskKmOs0fGMR0cCQdOhAaWwflqQ3S72w1oVnfwCFmIPJv5zLPM/0geHYaje5L5Tt
 Qd3x5IOSkEj5h0UfLKAKdxeNjowihnf2m1sO98qGux1wtRMfp9dt06XS8fFMFklqxoq+EI/yaev
 Yp8xDXdrx9eEnegYiKv4Soizc01FnepQUrjpqg==
X-Received: by 2002:a17:907:e0d8:b0:b9b:1ea2:97d3 with SMTP id
 a640c23a62f3a-b9c13b7ad60mr92492066b.35.1775017913882; Tue, 31 Mar 2026
 21:31:53 -0700 (PDT)
MIME-Version: 1.0
References: <20260321141345.599105-1-npiggin@gmail.com>
 <2e752dc3-0ba5-4d38-9d38-d19b2b841b07@tls.msk.ru>
In-Reply-To: <2e752dc3-0ba5-4d38-9d38-d19b2b841b07@tls.msk.ru>
From: Alistair Francis <alistair23@gmail.com>
Date: Wed, 1 Apr 2026 14:31:27 +1000
X-Gm-Features: AQROBzAS6FW4DEbfh2nZAmBa0FEIEXWdVRQaRY6Xs5WQK3VY2Nk63tJAxQq0xn4
Message-ID: <CAKmqyKM2boFhCnnFOq85xK_sjrVbr3pye45tAUgueDcyR3eBdQ@mail.gmail.com>
Subject: Re: [PATCH v3 0/5] linux-user/riscv: add vector state to signal
 context
To: Michael Tokarev <mjt@tls.msk.ru>
Cc: Nicholas Piggin <npiggin@gmail.com>, qemu-riscv@nongnu.org,
 qemu-devel@nongnu.org, Laurent Vivier <laurent@vivier.eu>,
 Pierrick Bouvier <pierrick.bouvier@linaro.org>, 
 Palmer Dabbelt <palmer@dabbelt.com>,
 Alistair Francis <alistair.francis@wdc.com>, 
 Weiwei Li <liwei1518@gmail.com>,
 Daniel Henrique Barboza <dbarboza@ventanamicro.com>, 
 Liu Zhiwei <zhiwei_liu@linux.alibaba.com>, 
 Richard Henderson <richard.henderson@linaro.org>, Joel Stanley <joel@jms.id.au>,
 qemu-stable <qemu-stable@nongnu.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=2a00:1450:4864:20::62b;
 envelope-from=alistair23@gmail.com; helo=mail-ej1-x62b.google.com
X-Spam_score_int: -17
X-Spam_score: -1.8
X-Spam_bar: -
X-Spam_report: (-1.8 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 FREEMAIL_ENVFROM_END_DIGIT=0.25, FREEMAIL_FROM=0.001,
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

On Fri, Mar 27, 2026 at 9:13=E2=80=AFPM Michael Tokarev <mjt@tls.msk.ru> wr=
ote:
>
> 21.03.2026 17:13, Nicholas Piggin wrote:
> ..
> > This series adds vector state to the linux-user signal handler,
> > and adds a basic signal handling test case. As a sanity check, I
> > also verified the signal handling test works in the same way when
> > run under a real Linux kernel.
> >
> > Thanks,
> > Nick
> >
> > Nicholas Piggin (5):
> >    tests/tcg/riscv64: Add a user signal handling test
> >    linux-user/riscv: Allow restore_sigcontext to return error
> >    linux-user/riscv: Add extended state to sigcontext
> >    linux-user/riscv: Add vector state to signal context
> >    tests/tcg/riscv64: Add vector state to signal test
>
> While a bit large-ish, and being sort of new feature, but it feels this
> patchset should be picked up for currently active qemu stable releases,
> when applied to the master branch.  Back-porting possibility to older
> releases hasn't tested yet, though.

I don't think it's high priority to backport, as Vector support is
still few and far between

>
> Please let me know if it's not for stable series.

If you want to, that's fine as well :)

@Nick can you CC qemu-stable when you send the next version

Alistair

