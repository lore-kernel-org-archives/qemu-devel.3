Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E2AB6FEFB7F
	for <qemu-devel@archiver.kernel.org>; Fri, 27 Feb 2026 19:10:34 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vw3EC-0006uX-9a; Fri, 27 Feb 2026 14:10:20 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1vw3EA-0006tA-Gv
 for qemu-devel@nongnu.org; Fri, 27 Feb 2026 14:10:18 -0500
Received: from mail-yx1-xb12f.google.com ([2607:f8b0:4864:20::b12f])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1vw3E8-0006vO-SS
 for qemu-devel@nongnu.org; Fri, 27 Feb 2026 14:10:18 -0500
Received: by mail-yx1-xb12f.google.com with SMTP id
 956f58d0204a3-64ad9fabd08so2405521d50.2
 for <qemu-devel@nongnu.org>; Fri, 27 Feb 2026 11:10:16 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; t=1772219415; cv=none;
 d=google.com; s=arc-20240605;
 b=E6ABsBbdRI/LBUSXar6pFZvLTQ2PCACCmpYDJ41na2Koyu4IXnnBIHLn19n45PiQZv
 Mqz8npU8EjsxN/1gayBWc1nMKEhXkdGrU17LdBKEnVJcBTcptxP5vEQBotKoHeAkzrXP
 T0T+e1cW7LQCpE49ctoxUPyh4mtEHxMBv/Us6XGTEJMDicW3LXm6PPFlBWF6rJmx0BdG
 wHy0yVX4jRHN3Wps6jfyP9le7XlUBNHl/JWsT+7NCnRcOdcJ9Dh9FTMGX3eQPUfFy7E1
 As25t5SPQ5TTIhNbIjBmQdaHxyc2J4vhcFuEkNCFAwsVNHwoT7DiD7mNbaS/tZw9LMfI
 H4kQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20240605; 
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:dkim-signature;
 bh=DD6yn6NzzigaBPzH+pNo8V6nWbXpvcqKj8f3rHF3t5Y=;
 fh=xQG8uiXGUjz9U/L9KA35K1Scf5x993W/5GXeT9JTA/4=;
 b=iH/Pqsu5zgDKUN545Ij70yY2q3GYRgv2N/pz/9Do6VnHCgKOxEqDOWTTcQXYQsU7Hr
 p60pGmGO9/f+exraLnUsG3AM7jAxUYa3DoI4Yhjr2QKWeeErgzNOiQa6bHt/O5W1Xphz
 RkS0hdUXPONP6ypnkG7uOIrGP0D06MSEaJzlp6/l2MZnQ8foSHZPSY0bd3tCRE3OWb/8
 kXQnQkzAgzY9Nj5itbcNiNW+Xm66ocGTKDJnjA15GxV11nuWf96L/25ms4p7UAyhd8iA
 dWWcOySuDlN6JwpJ1qxOXjlFMlrbt1TFm4c/Czwr+k4YsjHCIjpqgjg3pAt0zjLX0G4t
 fP4Q==; darn=nongnu.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1772219415; x=1772824215; darn=nongnu.org;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=DD6yn6NzzigaBPzH+pNo8V6nWbXpvcqKj8f3rHF3t5Y=;
 b=eJi2Hu4eQj9T9RCRPB2lX55mcwHfc7naNowyidKdU1juo7N5DvfvTIBdEEKzfHi/Rj
 ay5jOSmhT/9rJzXq9/jMyyMzKeT4kYDZ3vRibrGsuoWO7E/8/Z82hRnp0xNFzRMDTF8y
 9TvGlasDFtjVNXROaug0FzM34K0MemoXYVUuyrcJy8dmrcBrIBHhTchHr4iTfxIcBKnY
 gAZ6lmOkPZUziW+hZcjflky5To3LmIGSREHxEy7cByYMXKjSFHq3OZhDO27S1mVihKDp
 O3+dpA3vtA2G/N4WkY/xIxUF7ak2WRrehHjPtyJFPc8D2lxbjoLCPnArt0ihI31J2mXD
 pM0w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1772219415; x=1772824215;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=DD6yn6NzzigaBPzH+pNo8V6nWbXpvcqKj8f3rHF3t5Y=;
 b=J4mcf7qU+eeCdc0g6zuBaLfu5B4oQoSgpeZRhD8hcyJWyqb5pbgrIkZaOt6LkiBR/2
 z6KVj3xUI9B+01OzV0z2u5Q6tdPGKmEhSyWCgCNc0H81HDB9alcyYHtAVUQCH+ohEnLb
 XpFXYwqFbitDkC7KroRLIr8vNh4o+4sm9OJj7C7sG7q1cYqdQhnnxswA29qJ0jKy4Msa
 SbqqfAc5UjrCfh0TPsRyUN50czx9RjCLwpZQkdVkOeL1DqjN4Lrrwm5dDyZaPR9CMt/W
 hHJaZwakhWG0impANBB+gpfIjaadCW4RYByK9q9Xz0gv8f+v5eT/IvgLQ4v4fuw2Rupu
 Iq8Q==
X-Forwarded-Encrypted: i=1;
 AJvYcCXJbDf6Xfku2LeA9fn20oXYr188XJfTtaBS0TqclzrthZr7A4oQbiyOBzNh/wxoTo+nG31z9LavVSf1@nongnu.org
X-Gm-Message-State: AOJu0YyN7D66ijf3OfY5gx47ncjhNF1hHQ0TJhJBuRmQQheIfOOGC3xe
 DhClioFC7qKhXyV6Ds77A/V/Z3lMnEn1+kk1dU47+AOwZ0nrUTNeujvE8qH93048zv9Vbs4sw3g
 F3eMWxtKi2XLd+9Z314cib2R60YSI+BVehjddPzHRvw==
X-Gm-Gg: ATEYQzzSNq2kqOkdzADw46/fFJmyzxuxvTEDr9TY4YFIhCfS+U93Jdrew8xfXeJ42pB
 zMRdJwQhsw//cdA9EN/XqRlJNUCJQWB6+8p7dHnBzcRtEIXcILL7gkabjMzIHbdPxcxysl0LfV+
 uhIR8egxHedCERzkG2dmnKUVWGLHpvf/BWS8ZIE9z6cZYg9aWwLXhYTUt6KhRbk7teg81BhKm86
 g6pTqNPwaQXqjZ5i6Oqw9oL5s38L4Zen5g0ulTZJ5OHWFfhs0uquN5Uv7OQN1+LwMQfDvaPFj64
 6mOO5ItpxHYyV2WnsV9WKeMUmGsTo70faaInYEQ/HGzkAaSQj2SCjHCuZ4Rtu/CMHqg=
X-Received: by 2002:a53:ee49:0:b0:649:4bbf:9a18 with SMTP id
 956f58d0204a3-64cc20c893emr2458993d50.23.1772219415292; Fri, 27 Feb 2026
 11:10:15 -0800 (PST)
MIME-Version: 1.0
References: <20260227135736.2280161-1-peter.maydell@linaro.org>
 <20260227135736.2280161-3-peter.maydell@linaro.org> <87ikbi580c.fsf@suse.de>
In-Reply-To: <87ikbi580c.fsf@suse.de>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Fri, 27 Feb 2026 19:10:04 +0000
X-Gm-Features: AaiRm53K4eaqXv8397D5JpyU92Zcz5VEA-gpekHzUjaaBRpXxdr3XZooB5V9WaE
Message-ID: <CAFEAcA9+GzKxWKLcWvT5e2voO0mRR5jaKfXk4JrhWU6jFGXpNA@mail.gmail.com>
Subject: Re: [PATCH 2/4] scripts/lsan_suppressions.txt: Add more leaks
To: Fabiano Rosas <farosas@suse.de>
Cc: qemu-arm@nongnu.org, qemu-devel@nongnu.org, 
 =?UTF-8?B?QWxleCBCZW5uw6ll?= <alex.bennee@linaro.org>, 
 =?UTF-8?Q?Philippe_Mathieu=2DDaud=C3=A9?= <philmd@linaro.org>, 
 =?UTF-8?Q?C=C3=A9dric_Le_Goater?= <clg@kaod.org>
Content-Type: text/plain; charset="UTF-8"
Received-SPF: pass client-ip=2607:f8b0:4864:20::b12f;
 envelope-from=peter.maydell@linaro.org; helo=mail-yx1-xb12f.google.com
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

On Fri, 27 Feb 2026 at 18:57, Fabiano Rosas <farosas@suse.de> wrote:
>
> Peter Maydell <peter.maydell@linaro.org> writes:
>
> > Running "make check" with the clang leak sanitizer reveals some
> > leak reports which are either not our problem or else not
> > a leak which is worth our time to fix. Add some suppressions
> > for these.
> >
> > Signed-off-by: Peter Maydell <peter.maydell@linaro.org>
>
> Reviewed-by: Fabiano Rosas <farosas@suse.de>
>
> FYI, mine has these. The first one is on my list to fix once I find some
> time. The last two seem to be part of the stack for the ones you added
> here.
>
> leak:qcrypto_tls_session_push
> leak:gnutls_handshake
> leak:memory_region_do_init
> leak:qos_traverse_graph
> leak:qdev_get_named_gpio_list

qdev_get_named_gpio_list is definitely used in paths other than
the qemu_irq_intercept_in one we want to hit.

I think that recent memory region fixes ought to have fixed the
ones you're suppressing with memory_region_do_init.

I couldn't make any sense of the qos_traverse_graph/walk_path one:
it seems to be related to the qtest "subprocess" functionality
somehow and doesn't repro without that.

thanks
-- PMM

