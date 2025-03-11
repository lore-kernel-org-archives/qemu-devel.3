Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 07A35C282EC
	for <qemu-devel@archiver.kernel.org>; Tue, 11 Mar 2025 18:38:35 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1ts4Ts-0004Ls-Gf; Tue, 11 Mar 2025 14:37:32 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1ts4Tf-0004EK-Fl
 for qemu-devel@nongnu.org; Tue, 11 Mar 2025 14:37:21 -0400
Received: from mail-yb1-xb2e.google.com ([2607:f8b0:4864:20::b2e])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1ts4TX-0004Z8-HT
 for qemu-devel@nongnu.org; Tue, 11 Mar 2025 14:37:18 -0400
Received: by mail-yb1-xb2e.google.com with SMTP id
 3f1490d57ef6-e3978c00a5aso4716840276.1
 for <qemu-devel@nongnu.org>; Tue, 11 Mar 2025 11:37:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1741718227; x=1742323027; darn=nongnu.org;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=wayN4RoaoenIpriSr88NoZR+64V8zFecBLi1Mteb1h4=;
 b=LNenYRVkkdbvbj155e4O6+xUAqUNWDBnpN1DbX8G56g6jmiztbavNIUPXMIxhV/ftl
 EDOVwKojqpsCvYyzScln8GnffAZV802/0rXDEOa1dkALseRqdKmY7CEImdKCP4NEUwxt
 O0ya6VycORdT9OcvAJ8ZCnbToxDY/eyQgi05/F4wQ4yqMigjt2Uhoe93PGXasX5BhgfX
 7cvFhtd7L9gNZLM9uo9crlFCcvBmaU45yrWgwsOyvO2KnF54AhvM0KeFsdD4DAiqHlel
 pou9ue0wv+arvYOmNwSFi6MO1cuZtGPw2LLSGlVCHh+0ae+vViiHp4TtPnBQ6YnogYbg
 Ax3A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1741718227; x=1742323027;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=wayN4RoaoenIpriSr88NoZR+64V8zFecBLi1Mteb1h4=;
 b=bN+xpB1kPdDZTN2MJB839w/O1rtdiEldTZC4lWsqcBtnYzjTBrrKhRyJUbqBTTw3B5
 0yf8Y0WwFKdd8akjzaCvjezYANYtuZHTsX53dQJlJnfF2X4PsWa5s7dvkVAGtU1CN+mT
 bMaDvqUuFyjV6sCupCA7hu96nw0sjk5ca5daA7J6C5AZGiPlsxcXQkXcJErOGzQrfQLA
 q0UexZ1lzJidJsuXph0+ojX3ZrYDsGylHYJl0wUmYC8NtlL6dhWyaNc/1npEqbw8BFna
 0HShBJ6o0GBmjlXSQOdkVXTz+RmE4M8GPT1lVBREs7XnKIum1rpauA3qULb95OA3rlIQ
 TivA==
X-Forwarded-Encrypted: i=1;
 AJvYcCV75y9TekYoZoyqn73LzsDQ3fD5aL24CsvEmxpU2sfgDLiU7+tiuiSmHrZzbYwUZkCM7cBFEU1pFNNn@nongnu.org
X-Gm-Message-State: AOJu0YxWhZe9TZMl8Cb7buhHeXLjrPRJGLpW4DkXWmdBF+EUI1ZTtRH6
 hfHJpXi8EgXDeXLE+YenNxWu3JjlJyyzSE1rqVteKDmQQhZ+dW3bFYJ7AIqRPb+uBLZkujqqfV5
 y17SRpyMCFF6dU6RzOd7JXT1TB3FZAZty+hThew==
X-Gm-Gg: ASbGncvALk9o7Euz3teCilciZxdbETS98Mn0E5sExEOEDOuJvZlkIRpEP9DUfZAQqBd
 1+ps5o+OQucU4iv7P5MLI/33iSlp+nCKVaTiUmQznXHqTmEotrXgUBQXrA06hhDF5+5vWCDDu4/
 QuJ7k01mqEI4IYOh35bkxTo6ElsFM=
X-Google-Smtp-Source: AGHT+IF/5Z50eBBrV2TrE7YsRKS/qUtD0B5qOOn/yDurn2aOxkMF1P3zHWfzVvFPoJcJx0TcR68GTaEtqI8G9XKn8s8=
X-Received: by 2002:a05:6902:2086:b0:e60:a068:a14b with SMTP id
 3f1490d57ef6-e635c0f9b05mr22983993276.4.1741718227112; Tue, 11 Mar 2025
 11:37:07 -0700 (PDT)
MIME-Version: 1.0
References: <20250310012825.79614-1-philmd@linaro.org>
 <CAFEAcA_fRWgntwbiFiDJqAkthR8vBzrkLOLkp5GeHD9O8xTMCA@mail.gmail.com>
 <CAFEAcA_kEndvNtw4EHySXWwQPoGs029yAzZGGBcV=zGHaj7KUQ@mail.gmail.com>
 <6f4a3582-f3e2-4f0c-8ab6-eeddd1064793@linaro.org>
In-Reply-To: <6f4a3582-f3e2-4f0c-8ab6-eeddd1064793@linaro.org>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Tue, 11 Mar 2025 18:36:55 +0000
X-Gm-Features: AQ5f1JqytoFakCllyYae0_YaX-PbqFdorB8TUeotHeg0V71ppFWFo44bbBjv82U
Message-ID: <CAFEAcA8j-JAVC=VK0YHoyB9dBH6Rj7aGpmZtCGPbc5Usdy6yhA@mail.gmail.com>
Subject: Re: [PATCH v7 0/7] hw/char/pl011: Implement TX (async) FIFO to avoid
 blocking the main loop
To: =?UTF-8?Q?Philippe_Mathieu=2DDaud=C3=A9?= <philmd@linaro.org>
Cc: =?UTF-8?B?TWFyYy1BbmRyw6kgTHVyZWF1?= <marcandre.lureau@redhat.com>, 
 Paolo Bonzini <pbonzini@redhat.com>, qemu-devel@nongnu.org, 
 =?UTF-8?B?QWxleCBCZW5uw6ll?= <alex.bennee@linaro.org>, 
 Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>, qemu-arm@nongnu.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=2607:f8b0:4864:20::b2e;
 envelope-from=peter.maydell@linaro.org; helo=mail-yb1-xb2e.google.com
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

On Tue, 11 Mar 2025 at 10:33, Philippe Mathieu-Daud=C3=A9 <philmd@linaro.or=
g> wrote:
> On 10/3/25 18:28, Peter Maydell wrote:
> > This seems to be because the pl011 code and the chardev
> > code disagree about how "couldn't write anything" is
> > reported. pl011 here is looking for "0 means wrote nothing",
> > but the chardev code reports it as "-1 and errno is EAGAIN".
> >
> > I think the chardev code is actually what we need to fix here,
> > because it makes basically no effort to guarantee that the
> > errno from the underlying write is still in 'errno' by the
> > time qemu_chr_fe_write() returns. In particular it may
> > call qemu_chr_write_log() or replay_char_write_event_save(),
> > both of which will happily trash errno if something fails
> > during their execution.
>
> IIUC when retrying qemu_chr_write_buffer(s, buf, len, ofs) could
> write less than @len (but still writing few bytes, that information
> is stored in @offset) and return -errno, discarding @offset partial
> write len.

I thought that too when I first read the code, because it's
been written in a way that didn't match what I was expecting
for a "write until you would block, then stop" loop, but on
second reading I decided it could not, at least in the case
where write_all is false. If we write any data at all on the
first cc->chr_write call, we will then break out of the loop
without trying to send any more, so there's no code path
that will then set res to a negative number. (If write_all
is true, then yeah I think we can return an errno rather
than a partial-write count if chr_write fails on the second
time through the loop, but all the callers of that version
of the function ignore errors of any kind anyway, and
certainly don't have any means to handle "only wrote half
the data", otherwise they'd be using the non-blocking
version.)

-- PMM

