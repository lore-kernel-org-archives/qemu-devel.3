Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 48952104C001
	for <qemu-devel@archiver.kernel.org>; Wed, 11 Mar 2026 10:45:08 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1w0H3J-0000t7-S1; Wed, 11 Mar 2026 06:44:37 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1w0H2w-0000rz-PK
 for qemu-devel@nongnu.org; Wed, 11 Mar 2026 06:44:11 -0400
Received: from mail-yx1-xb12b.google.com ([2607:f8b0:4864:20::b12b])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1w0H2v-0000gv-8L
 for qemu-devel@nongnu.org; Wed, 11 Mar 2026 06:44:10 -0400
Received: by mail-yx1-xb12b.google.com with SMTP id
 956f58d0204a3-64c9a6d68e5so10407793d50.3
 for <qemu-devel@nongnu.org>; Wed, 11 Mar 2026 03:44:07 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1773225847; cv=none;
 d=google.com; s=arc-20240605;
 b=Lw/XFEFqHQONl5YYSRLZGT1CZ6agz/dOoIh8yxagNfB6K0x3c3yO9dGJRJDqG4hkcT
 K5WggLOn84f1HjG5swwcojWuIVRjkYtc48+nS5O8Hnhi9mICzZ8oqGG+aD3/GbTvvYLR
 +jLRYErZbJGZzU158hlSEWLXxtG1h111rzpEjbtcT2ioGB365QO9wRfD1lpxVts6y5/B
 HT8s4J9Tt/g28q2jxUeReUTwz1l6xwswRxvnj4doGNIiFKsSpty4eqx+2nqXX2pfCbhz
 1QJecGZUw5N8spHIYijrjlGRHIjwARhQRHWn7DQmcw7+sGI3A57b9Sp/ykXD/0E4/JtW
 tibQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20240605; 
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:dkim-signature;
 bh=yN00jzed+EBT6llW4FBriizhAtBOKXpjd3EOPrX13cA=;
 fh=WYJLbp15PdFKX7iYzIiPNfmlkxlDiZ1oceQSBbDfTwc=;
 b=MNeN3roIRR1Z05myRUfNKVYyPQtkUH0UbwQr9TjHwEaKv2xnUej9rYO6ESywxOQA2f
 IYkqVddVFDiePJqhi2pvhnKz9g+lsqwg4iZXmRhRruNK3/s8LmLiEDZB5QhMH86KLjf/
 VNxWVN8b5HUjU46EA/gfu0zgV5C3jSJGA8K6MZ49n4Lc5gcHVhrhE7YRuQDE+pOfxcqZ
 c8y881TA67gKTtRxA2g3bKWFK2fkhDcJ1X7oV0GNezhKzfGinuV58cyFGlJ1CuZ4u8Rn
 ohZYCaw0BvI7BSaQzFjp+yyaTAhALx7pcjW8htzg5WqAzYYPrGSILKzoI3VpttC5xJ0H
 exFA==; darn=nongnu.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1773225847; x=1773830647; darn=nongnu.org;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=yN00jzed+EBT6llW4FBriizhAtBOKXpjd3EOPrX13cA=;
 b=aMNUTlF8mXknW7nRrG187XQ9TUC5tk7fX92OQNEMQg8rIuW/VEwx6hG8IzRt85ODfU
 vcwpkSFy3k5GWCcRF4dS6ZHc1ZmxiBcON9uc0HfauBCjB/5vJcA7VjUJfqF8/4OcBJ4u
 fPi82KGp4q710dI2QXg/uWgWY13ArVvrr0lDXjTC5ERAwYXPZugT2Dj+siO96SUJ3inH
 lrbXSQxyGurroFJ/5EjroGlekN3y8nMwOnilhLtDsLd1uUZqG3ZvAA6Ba6LOqqO4rNUs
 nOSZmLNqFo5djycTCDT4w28ROColNSI6L52eIKEHrqMFEg177R/c5neKvHMyBMFGcQ0I
 hfyg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1773225847; x=1773830647;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=yN00jzed+EBT6llW4FBriizhAtBOKXpjd3EOPrX13cA=;
 b=EqnXJGi9N0fiJfy1LfEKGgdDps42SMmaS4BQB2RXWQXITjfu5NtqzStk48AbtcUiNJ
 pDsUgzoaHK3HBHbGFLblad/Sg4Y/ZJDOYyKwhkG+gu4g6dBfBSP59lzev5xs6KQdptau
 pc7u6yOqcZFdJM7NTZTJPAsI9JgxGCx0cTdAJN/xscowJs2HuTiRULOjgnZKlx/wHSik
 kzrCYPg2ZN2zeNPIYRAM3xALhEQLwKvJowBdKG8krQNoz6yIcSeqxY6OybjOPcb2Jymb
 FuVFOeN0xwFNeqr4inU/tVTPcjdGF+a5sOJxE3+cmOu8RvNkTEmiNZGgnUuPeZQgHpFa
 HR3w==
X-Forwarded-Encrypted: i=1;
 AJvYcCUgA8SiT/WwBl/u2Wg0nQ7TkpGWaHF3CH9moctqqmdsZg79WJxwfFxyxrZtikbsWuQZAHTh0HiE9pIk@nongnu.org
X-Gm-Message-State: AOJu0YwetDyQccRY+sZhIvZDAy1PQvrfZs9z49NKu0Mx6b/7r2MkfN4h
 WmYj9zPFzP+ezzwBGd/uIHkEsU8d4Oo+6feol702+qN0n6XAsasJyCO0M2YzNmiV0XJjwHc2AQu
 6pMFgWU3PdmHhc3zfFtlJh5xhL4vRt7nUGUC8Ol3pXQ==
X-Gm-Gg: ATEYQzwsC2hw9z+dqj484wwigWlvspiDUxYJTewD98iuyXBN9zy7AKK/0WpgOzDhlyN
 CN9OYacHWJRk+w0JNZYTCc2aN10OsjJclMqe1zx0YhdY9V04lmx8r1Uhfu2/+fhaQ2WmKjFn9Ku
 ynLrvFdTdnKF5QEX9WR7+KYI7C07RcPAwW4cTQjulTLcdac8s6xXb9E66+suAVdPjFZY5fWIhgK
 0JvbaqweXLodYwTELMVN+KukcfVwL+ZDoLgDj1Voap8/0KP6Qp1N+PNba/kdQ9PXUd9T4rMilbs
 VdmzWgozdpn/Ev8yJrYDitFWjo2D6IOL3YFhUvV2tw/MyeT7sRdD901JjZwo6+FVDyk=
X-Received: by 2002:a53:c041:0:20b0:64d:568b:bcb9 with SMTP id
 956f58d0204a3-64d656a4f9bmr1360289d50.16.1773225846995; Wed, 11 Mar 2026
 03:44:06 -0700 (PDT)
MIME-Version: 1.0
References: <20260310162622.333137-1-kwolf@redhat.com>
In-Reply-To: <20260310162622.333137-1-kwolf@redhat.com>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Wed, 11 Mar 2026 10:43:55 +0000
X-Gm-Features: AaiRm52oZL5sTq-ZNRKlISqvE28o_YgJilKjoPhLd9YaF1miSVzORHgmFz_VQ_E
Message-ID: <CAFEAcA8XD4KVRQWU1BSyCkqoUWuBO5Kq-s4fnJk07gNq6BG4FQ@mail.gmail.com>
Subject: Re: [PULL 00/28] Block layer patches
To: Kevin Wolf <kwolf@redhat.com>
Cc: qemu-block@nongnu.org, qemu-devel@nongnu.org
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

On Tue, 10 Mar 2026 at 16:28, Kevin Wolf <kwolf@redhat.com> wrote:
>
> The following changes since commit 31ee190665dd50054c39cef5ad740680aabda382:
>
>   Merge tag 'hw-misc-20260309' of https://github.com/philmd/qemu into staging (2026-03-09 17:19:26 +0000)
>
> are available in the Git repository at:
>
>   https://gitlab.com/kmwolf/qemu.git tags/for-upstream
>
> for you to fetch changes up to 7b13fc97d7235006d2ccc7a132ecb70802ba258f:
>
>   block/curl: add support for S3 presigned URLs (2026-03-10 15:48:48 +0100)
>
> ----------------------------------------------------------------
> Block layer patches
>
> - export/fuse: Use coroutines and multi-threading
> - curl: Add force-range option
> - nfs: add support for libnfs v6
>



Applied, thanks.

Please update the changelog at https://wiki.qemu.org/ChangeLog/11.0
for any user-visible changes.

-- PMM

