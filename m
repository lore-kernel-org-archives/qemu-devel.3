Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4684910F92E3
	for <qemu-devel@archiver.kernel.org>; Tue, 31 Mar 2026 17:29:00 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1w7ct5-0005SQ-0E; Tue, 31 Mar 2026 13:28:23 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1w7ct3-0005SF-HD
 for qemu-devel@nongnu.org; Tue, 31 Mar 2026 13:28:21 -0400
Received: from mail-yx1-xb12e.google.com ([2607:f8b0:4864:20::b12e])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1w7ct1-0005nf-SJ
 for qemu-devel@nongnu.org; Tue, 31 Mar 2026 13:28:21 -0400
Received: by mail-yx1-xb12e.google.com with SMTP id
 956f58d0204a3-6501d242e3fso4932296d50.0
 for <qemu-devel@nongnu.org>; Tue, 31 Mar 2026 10:28:19 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1774978098; cv=none;
 d=google.com; s=arc-20240605;
 b=IRaSypLzT/yL0rM/AXddgC5fLsMpm83IKWHijhHofdIlGemfT1F/kYNAf0x4lCengA
 c/9ZViUtNzpJp8EZv1ecD99s4kIm7HObfodKPA00buvFnpPeSIrDd5M+YI42hAVXLZbQ
 ihJ61ixf+u0Pkh9QS1cHo/WGW/D3x0ITPzF0HENZX6bXdyypVGXHrzSjQlQpmROOlb3w
 2iEXALO4F+50n83/1Txuh1CT9DA/N9h6zBXOEYVXhSSG+cwqxPu9OlLmmN8CRTVlSmOO
 PXCMR4flEEWTf68tOlLn0Ai8WPYX0HBFGAeDUcfj9gJEFUE3lBCm9py9neMjxfStg67D
 OjcA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20240605; 
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:dkim-signature;
 bh=IbUtHg43PNy2wWJuPoxX6sqPAXsoLXmFQxiPxYnZUIw=;
 fh=j0m/KHqzOQ6CKKktQSBLLiVo/M7SZnjHIyl4bugXt+Y=;
 b=dh53NXiWVkS0MnN/yy25qumm/k0/TNFe29VIrlcLvTzVzaVVOA23JVlJWDTpcaZIh/
 3Czih2aliuKYUf4L5YQgONZzIrb5yCqxsbk+I4KtfJYL4y40bsQcFObPFi2IM0lCWMoj
 qVnsKgWyCN2Uxu53IFiSlfwVUVzWrkgRyQPbgpqfz6IR4MooErxyta3bO514RwAkVcOX
 eft4f8OBALaql69Udz4rzxwLfd02X2MOW1Ed/j6E5mX7NEKhy9I7pzoY4pLFCJoKvRmM
 6A+V/LW3PPMnZX7sBdCXOVyM1C6LwGWSE8MUH/u5AEJcSi39ezGNU39pMuvUdj/qMjjV
 wnYQ==; darn=nongnu.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1774978098; x=1775582898; darn=nongnu.org;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=IbUtHg43PNy2wWJuPoxX6sqPAXsoLXmFQxiPxYnZUIw=;
 b=vcvShGi0JMmIkRGymFCN3B3ZDcjuVUg2GFc56uOYqxNuUwmTrz98/59Vy57IwSOFRa
 VgY2WmD1iVZJmtXeFt/6hSs2iSnKIUXx5k+Vb5v30n2NMz06YOVjAAgwQLFs+pICKuZU
 WMmvDYIrYariXj+1Q93L9hv4e5Bsk5jUfiG59Kckg5x5sYOSf1h2l+P7ONRm0qHcm+Ll
 itmxomyHL8xJcRpTravz/+AVA2JeqVoD6VsZo0CzB9cnCxq7FFGrTQcVMLJ0CsGo32tR
 mGj1EWjYhpweqan6xIMDVJKjiyudduPgvYrfRIqKSQI/dOh0XUqnYlSZ8zMGIKwRFn1N
 vXag==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1774978098; x=1775582898;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=IbUtHg43PNy2wWJuPoxX6sqPAXsoLXmFQxiPxYnZUIw=;
 b=kAjh6Y5RI+2GQEI0OTG0TlEUa0f5i415v+5uw9UwR4eQoKzUk2mOWqSuoR1NTwerq2
 Syg5iKceCOa1k9pIipEFw9qHFB7TyVqEZl1tWdpYPgaURBeqWa2Uv3JwBR5WB+FhEqxm
 l8ioFZI7y28WFP51ghpJt6Bq/Z6Hdgaa8HjRP9NQxB/VoyTyyQMpf517XdV+z/LNLnwo
 WJ9suokdf9jmHXfYJlxXJJW127qrwshzrvE1xZA3ZNQHHwgNE+64chLF4NPv4j55MgY3
 1uBdIB9sN4ZUyE7G+5wF5yS2HnwPBWTEhx8w/HJtuRzdJ+f8fkqI1feEeD9pMwcTdpNl
 naXg==
X-Gm-Message-State: AOJu0Yw/XfP41WNxmsktPbNRuf/oYYuwyojQYPWVypGMQb6G3mfrzz1t
 4Kj5rn/pqZsklevvGyvOyGtwYOeQ8uSl0MDJtU/0ntZZDLrNo8TxqVXeq7K9pxsD1/NNZp/vuBC
 ADEAsItxA1qkDeKYBzwSsGSem64AuacvpSAQnYJAgMQ==
X-Gm-Gg: ATEYQzxy6dk1nXWAWhiQiVAduJunq7JLdCIqWeHXypfvVDjjTtgUQdy50gtK10p3Bxc
 5GUJ6F83TMWGxQN1RnoavB+3+i8FsC/Z1K1WhECnXfjaGJLJ434QxQz1fy0HX9YVz5NQ4goqKKp
 wVL8gQXThMvBZncVuE9v0oD8JXwlAUCfrli1wqSUArsMpzaiTWcMaAaz5yc8pabQPU3ZMrqENaA
 QQhtdXHdG9IyQXuSO/mRD5wcmK7R4dc5TysriIrXL2RuDSv3V5WhjLLC+9+5n7ZlHgDzVeu+KiR
 7N1/uqX+M0k2mvtbzoGeuFD/rYwIcmx0gw3CL9nI+in3dJ/AK2dO7IP3LiyniBfUpKo=
X-Received: by 2002:a53:b2e3:0:b0:64c:f90c:740b with SMTP id
 956f58d0204a3-6502fdc1782mr95921d50.18.1774978098218; Tue, 31 Mar 2026
 10:28:18 -0700 (PDT)
MIME-Version: 1.0
References: <20260321135624.581398-1-npiggin@gmail.com>
 <CAFEAcA_iwWDmZf1hojzZ8+N5RTRC4WXDSSK7SugNNRd6kdk8Gw@mail.gmail.com>
In-Reply-To: <CAFEAcA_iwWDmZf1hojzZ8+N5RTRC4WXDSSK7SugNNRd6kdk8Gw@mail.gmail.com>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Tue, 31 Mar 2026 18:28:06 +0100
X-Gm-Features: AQROBzBc3BBDwdy8ofqVDw9j4p3rS1jiFKMJ801zB9SQQqiQbwYq2y4ASn2qLn0
Message-ID: <CAFEAcA_+_tDJstKjQVENprAa-37tX6Ta9Ay7i-nK3Hp8v7BGyQ@mail.gmail.com>
Subject: Re: [PATCH 0/3] user: recursive signal delivery fix and test
To: Nicholas Piggin <npiggin@gmail.com>
Cc: qemu-devel@nongnu.org, Warner Losh <imp@bsdimp.com>,
 Kyle Evans <kevans@freebsd.org>, Laurent Vivier <laurent@vivier.eu>,
 Pierrick Bouvier <pierrick.bouvier@linaro.org>, 
 =?UTF-8?B?QWxleCBCZW5uw6ll?= <alex.bennee@linaro.org>
Content-Type: text/plain; charset="UTF-8"
Received-SPF: pass client-ip=2607:f8b0:4864:20::b12e;
 envelope-from=peter.maydell@linaro.org; helo=mail-yx1-xb12e.google.com
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

On Tue, 31 Mar 2026 at 17:59, Peter Maydell <peter.maydell@linaro.org> wrote:
>
> On Sat, 21 Mar 2026 at 13:56, Nicholas Piggin <npiggin@gmail.com> wrote:
> >
> > I found this recursive delivery problem when testing new riscv vector
> > state support patches (plus a minor lock user balance bug).
> >
> > This or similar type of issue was fixed with 8bd3773cce1 but I couldn't
> > see exactly what scenario that was addressing. Is there any other way a
> > signal can be generated during handle_pending_signal()? The SIGTTIN
> > case, perhaps?
> >
> > Thanks,
> > Nick
> >
> > Nicholas Piggin (3):
> >   linux-user: sigaltstack lock_user_struct missing unlock
> >   bsd-user, linux-user: signal: recursive signal delivery fix
> >   tests/tcg: add recursive signal delivery tests
>
> I'm going to take patches 2 and 3 into a pullreq I'm doing for
> linux-user fixes for rc2, so we can get the fix into 11.0.
> (I've made a s/__chk_error/do_chk_error/ adjustment to patch 3.)

Patch 3 also has a missing "#include <stdbool.h>" in the test
program; otherwise it fails to compile in 'make check-tcg'.

-- PMM

