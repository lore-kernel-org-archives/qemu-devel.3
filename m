Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E6656CE7B0B
	for <qemu-devel@archiver.kernel.org>; Fri, 14 Nov 2025 13:22:39 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vJtkg-0003PT-K1; Fri, 14 Nov 2025 08:22:10 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1vJtk4-0002VX-Tj
 for qemu-devel@nongnu.org; Fri, 14 Nov 2025 08:21:34 -0500
Received: from mail-yw1-x112d.google.com ([2607:f8b0:4864:20::112d])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1vJtk3-000305-8u
 for qemu-devel@nongnu.org; Fri, 14 Nov 2025 08:21:32 -0500
Received: by mail-yw1-x112d.google.com with SMTP id
 00721157ae682-787f28f89faso20754517b3.1
 for <qemu-devel@nongnu.org>; Fri, 14 Nov 2025 05:21:30 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1763126489; x=1763731289; darn=nongnu.org;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=9M/QamdtXqcxY+VfwHXlALR9X1NcSU3LD1wH3inr1xk=;
 b=tfWujToqw0HofOXQFKZLhR7KO4AvE5fy7Pghg8Lr8FsnbuSvXdviNwfnqool4DSpiV
 13wOL6CMk47W9DC6PozVlEP//iSkDRjB/M3/CLzolM7Zau0iDGtSUov3tlk00OroTjgb
 lhRvkGFbT+5Ow84IcQUlqmQPdH55scAjZSY/qJaUPQ7W8fE0t/Lb4gh9OMu3tSH7fMe8
 OrmX2fb4iPW/GkiahHftoc8+uRP55Q21aSdy0ubIohlZEM6PBMmLrR8UUllpMqfmjGkK
 L/+B3lbMPGnlQW8nn+6qjcCWE6Vomu7utP68k59uVtZhKnVuPcwCzFL0Obz9SGmcotN7
 t1uQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1763126489; x=1763731289;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=9M/QamdtXqcxY+VfwHXlALR9X1NcSU3LD1wH3inr1xk=;
 b=XEbcyMMkqPLPRmP9nsL1ShTPoRuy+ZlUvbu66ajb/iLcCShDMdZACkKyXzM9PBbLhY
 SNM3hPtF47nH4P8NO1K1S6Oz5WtsYaAntXcE01o7/DQAnCkesY3ZTmYpJrIgSWmWwixj
 7DBKTXqs8SIptP3prI7ORS3ZXqjtrVwil9lcxQqCdg1URYtAobpcWPz4GYjy9/y2gzPz
 Quo5aaZrgRyQELFSABHE1/xk6ARgT2abWyWObjWIGOEzOe+ZRiDpi32RL1JOJmu0UDX2
 MjWKK0wjiE7NhP8cOj89O4iRC21567j6EDySdJQWSNzHHAPozatZeDp6q75MfrHMycYD
 Mx5Q==
X-Gm-Message-State: AOJu0Yw+OEKuAko4zZVCNY/4L2l8/phqZIxwuo2wgAIfhPnvv8xTLi2h
 CDElxjDfTKFLS4XStpFM+fD6rVTQRCPblf+WHnZhRsaWSh+NM1lccPS7u15E3+TgWkdrnohUmS4
 vhrEkrMhBm7UKjoV14bOrgvkQe7mRbiQ2c3JSBUNFaGR3yrMxo6tM/ic=
X-Gm-Gg: ASbGncu5Ei2S0drm4RubNJKND+84LEHv9Hih2mrPLcFK06VHMJ9CvbPy18MuqH4/D/6
 zc/fYNcXkt92iSJtGcYmHTTB/R8KopucHVe4Yi0/Yo20ZJaSTDdL5kuGSN9TD6TKH+5BUV1k4Xy
 PjYnkCneIyEQR/FGBvxVS0u1huky7nQWMM8CamiaX4fWmkIsBwlnVPDWl8VfyXLFUytLmfJw6z6
 cXhdWvrnN8XonOzaRC/Qby+wFSxLRoxYnV+uWDrYcldqB6YsekZlhjzPpEnEpJYdf8Ec0k6G2iY
 8xK69p4=
X-Google-Smtp-Source: AGHT+IFzr9Um8PQEoyRK7yqlFHJLBanEemwlERyKgwrX4KTOQbeoRmuY9WUpzBD8gBl9nGE/Z04VynsYcgeuqjydJXU=
X-Received: by 2002:a05:690c:a1d4:b0:788:166a:d007 with SMTP id
 00721157ae682-78929e3e69cmr22832377b3.4.1763126489439; Fri, 14 Nov 2025
 05:21:29 -0800 (PST)
MIME-Version: 1.0
References: <20251107174306.1408139-1-peter.maydell@linaro.org>
In-Reply-To: <20251107174306.1408139-1-peter.maydell@linaro.org>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Fri, 14 Nov 2025 13:21:17 +0000
X-Gm-Features: AWmQ_bm1eD9ziiEGFCqdrEAES8D-AoApgVW-rktKc0Q0U2ueTLs3Bj9MoWmXluU
Message-ID: <CAFEAcA-ROzqrpb1Z9oR2LF5=YHhM95=Ae2RCsqPH7Yj3CRBwLA@mail.gmail.com>
Subject: Re: [PATCH] system/qtest.c: Allow for multiple CHR_EVENT_CLOSED events
To: qemu-devel@nongnu.org
Cc: Fabiano Rosas <farosas@suse.de>, Laurent Vivier <lvivier@redhat.com>, 
 Paolo Bonzini <pbonzini@redhat.com>
Content-Type: text/plain; charset="UTF-8"
Received-SPF: pass client-ip=2607:f8b0:4864:20::112d;
 envelope-from=peter.maydell@linaro.org; helo=mail-yw1-x112d.google.com
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

Ping for code review?

thanks
-- PMM

On Fri, 7 Nov 2025 at 17:43, Peter Maydell <peter.maydell@linaro.org> wrote:
>
> In the qtest_event() QEMUChrEvent handler, we create a timer
> and log OPENED on CHR_EVENT_OPENED, and we destroy the timer and
> log CLOSED on CHR_EVENT_CLOSED. However, the chardev subsystem
> can send us more than one CHR_EVENT_CLOSED if we're reading from
> a file chardev:
>  * the first one happens when we read the last data from the file
>  * the second one happens when the user hits ^C to exit QEMU
>    and the chardev is finalized: char_fd_finalize()
>
> This causes us to call g_timer_elapsed() with a NULL timer
> (which glib complains about) and print an extra CLOSED log line
> with a zero timestamp:
>
> [I +0.063829] CLOSED
> qemu-system-aarch64: GLib: g_timer_elapsed: assertion 'timer != NULL' failed
> [I +0.000000] CLOSED
>
> Avoid this by ignoring a CHR_EVENT_CLOSED if we have already
> processed one.
>
> Signed-off-by: Peter Maydell <peter.maydell@linaro.org>
> ---
>  system/qtest.c | 4 ++++
>  1 file changed, 4 insertions(+)
>
> diff --git a/system/qtest.c b/system/qtest.c
> index baef06d4d1b..67e2385f4b0 100644
> --- a/system/qtest.c
> +++ b/system/qtest.c
> @@ -815,6 +815,10 @@ static void qtest_event(void *opaque, QEMUChrEvent event)
>          }
>          break;
>      case CHR_EVENT_CLOSED:
> +        if (!qtest_opened) {
> +            /* Ignore CLOSED events if we have already closed the log */
> +            break;
> +        }
>          qtest_opened = false;
>          if (qtest_log_fp) {
>              fprintf(qtest_log_fp, "[I +" FMT_timeval "] CLOSED\n", g_timer_elapsed(timer, NULL));
> --
> 2.43.0

