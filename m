Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 15F3FC3DA4A
	for <qemu-devel@archiver.kernel.org>; Thu,  8 Aug 2024 08:48:57 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sbyow-0007B3-Gs; Thu, 08 Aug 2024 04:48:30 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1sbyov-00079u-Jl
 for qemu-devel@nongnu.org; Thu, 08 Aug 2024 04:48:29 -0400
Received: from mail-ed1-x531.google.com ([2a00:1450:4864:20::531])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1sbyot-0007EZ-TG
 for qemu-devel@nongnu.org; Thu, 08 Aug 2024 04:48:29 -0400
Received: by mail-ed1-x531.google.com with SMTP id
 4fb4d7f45d1cf-5a108354819so920933a12.0
 for <qemu-devel@nongnu.org>; Thu, 08 Aug 2024 01:48:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1723106906; x=1723711706; darn=nongnu.org;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=eHQJLfzTNPDA1/pQTZpx4Byq4XPizN/2E9nRXaGdCGM=;
 b=JqZoV4Rt7/99JH4jdvjUVv4vHjXoj1nDbTW4AI9sWWYKOd/mSKQ7CQChyHorLgHUAX
 Iyc7Xc8AWMvLN9WgK577k+8GtNLhIid2UmH0MCkPA28KAX9pv/D7sC5cGkKLXHbv/FpP
 lMR2JRwSdPcArHus/aiIADFpaBWvYe10roCVt2BGSgDJOjreh7fSIbscVnVIdh+l1GPA
 ajoQd8/EiUfErwlw84HkE2eI1oIYOf2ZUjFWVx/aGaijaQymkQTZ/+fBBMwj1AIU1PJK
 vE3Q4V8quNfkD9xnICUBlC/DlCAJaG0Zg45XrqJWyDgttdkMqcJZDnQOs1D9KD0rFjrG
 QAuA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1723106906; x=1723711706;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=eHQJLfzTNPDA1/pQTZpx4Byq4XPizN/2E9nRXaGdCGM=;
 b=EhBAqOU0xy7pMTftSxnbMSlvaZzYoNML88mYw+1oskEGuM+DsG/4hs6C7kVclgN7TJ
 5EOepv8iozIIFVcxvLC8e2zkpOWYwQ5lGjtysa3Rwh7tHN7sRxANTqhGXjAkv0Y3arOu
 qIcae0fRKviewkdGK6wLzqZ/qv7g1aQotT37jgi0nISiNvsWUDzoVjfSq+27mUjrFNNQ
 btZ+p1pj1yidz6YTwl2pM6pB+f/8aiH4wX1NClKk5nOEJI1BPs/zP+RpKfFQBMQLzbrw
 R8UOll4JCP/PRBFYy89s+UQRzg7dmGz4giaH3FZB+qePqD1nu0YLdKyUK2HejcsiReQ0
 qKYg==
X-Forwarded-Encrypted: i=1;
 AJvYcCWJz2SME0X2WnoEiCX43PVHFC7m0HJmWnC5nu479GEIHr9WLGYBiO0VKcenV6/8VehKMO8tIP4kkY42xczHxCycD9E55d8=
X-Gm-Message-State: AOJu0Yzl3SQS6SoNGAyZHWjDJ+6xxCeljpWmsBnLkrZ1PfLP7HbagVBn
 W11aEG8bjsiW3ltY9WjvjMzXPAv2SgibrhWU4DK+jbgPJTv1JZEcwu0N09aZURo2/sx/lbRkAzJ
 yC4loucKZUzKFE/5Mp1XUX2iZtjqNhhZ7s6xywg==
X-Google-Smtp-Source: AGHT+IHJrLjXZQmfKth+OlU2ziTtkspi2VOGcD0qKJpLnFVA3YItS7TQjGRWlaaaTmDL3uYredbjjHDQEXrD7ZYKoY8=
X-Received: by 2002:a05:6402:234c:b0:5a1:7362:91d9 with SMTP id
 4fb4d7f45d1cf-5bbb233eefcmr1132986a12.22.1723106905820; Thu, 08 Aug 2024
 01:48:25 -0700 (PDT)
MIME-Version: 1.0
References: <20240806141940.22095-1-philmd@linaro.org>
 <20240806141940.22095-3-philmd@linaro.org>
 <87o764yce3.fsf@pond.sub.org>
 <a8eb43d8-3714-447b-ab1b-c96ff05cf14a@linaro.org>
 <87h6bwwpu4.fsf@pond.sub.org>
 <CAFEAcA_2pJA47K72qJQX9bc8sBcA+0wJGaf3KAaYJaRurjQD7w@mail.gmail.com>
 <871q2zshk6.fsf@pond.sub.org>
In-Reply-To: <871q2zshk6.fsf@pond.sub.org>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Thu, 8 Aug 2024 09:48:14 +0100
Message-ID: <CAFEAcA_xbdrjR87bttUxw0V=J=sS_Le+X=CJhPGqio7-CkYo+Q@mail.gmail.com>
Subject: Re: [RFC PATCH-for-9.1? 2/2] hw/intc/arm_gic: Only provide
 query-gic-capabilities when GIC built-in
To: Markus Armbruster <armbru@redhat.com>
Cc: =?UTF-8?Q?Philippe_Mathieu=2DDaud=C3=A9?= <philmd@linaro.org>, 
 qemu-devel@nongnu.org, Eric Blake <eblake@redhat.com>, qemu-arm@nongnu.org, 
 Thomas Huth <thuth@redhat.com>
Content-Type: text/plain; charset="UTF-8"
Received-SPF: pass client-ip=2a00:1450:4864:20::531;
 envelope-from=peter.maydell@linaro.org; helo=mail-ed1-x531.google.com
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

On Thu, 8 Aug 2024 at 06:35, Markus Armbruster <armbru@redhat.com> wrote:
> Options:
>
> 1. Approximate symbols from CONFIG_DEVICES with symbols from
>    CONFIG_TARGET.  This is what we do now.
>
> 2. Use symbols from CONFIG_DEVICES.  Generated headers are no longer
>    self-contained.  Strong dislike.
>
> 3. Define device-specific stuff unconditionally.  We get to fool around
>    with stubs, binaries carry more useless code, and introspection
>    becomes less useful.  Meh.

I think that 3 is the way to go. With a single-QEMU-executable
there are going to be lots and lots of cases where a QAPI
command needs to be present in the binary but won't be
applicable for the particular machine type / target architecture
currently being emulated. So "the commands always exist but they
might give you a suitable error if they're not relevant for
the config you're currently running" is more consistent.

Regarding introspection, doing it based on "we didn't put this
in at compile time" is going to give you inaccurate results:
even if a command was compiled in doesn't mean it's going to
be relevant to what you want to run.

-- PMM

