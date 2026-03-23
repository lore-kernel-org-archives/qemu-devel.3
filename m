Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7013DEC01D4
	for <qemu-devel@archiver.kernel.org>; Mon, 23 Mar 2026 11:52:53 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1w4dpJ-0006kf-Nc; Mon, 23 Mar 2026 07:52:09 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1w4dpH-0006kM-FI
 for qemu-devel@nongnu.org; Mon, 23 Mar 2026 07:52:07 -0400
Received: from mail-yx1-xb134.google.com ([2607:f8b0:4864:20::b134])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1w4dpG-0002YW-17
 for qemu-devel@nongnu.org; Mon, 23 Mar 2026 07:52:07 -0400
Received: by mail-yx1-xb134.google.com with SMTP id
 956f58d0204a3-64e9f9226a7so3497108d50.2
 for <qemu-devel@nongnu.org>; Mon, 23 Mar 2026 04:52:05 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1774266725; cv=none;
 d=google.com; s=arc-20240605;
 b=MazLT3SoHgtp7uU/HBjRAN8eAaVIxvS/xVJvDqWb9wY3ylXAFyqp6ZNxS1jmcxrWMP
 vpIDbmSWZ7cc2csTu/Lk5p8WLyxZM5Fh5U1TZ/+iwJWuKyweeIzR4GfrVKo27dSGOifM
 fPFU3HGqwHt6EabrTGha+qG9NqXaEP8IvgkKc+CIoQQbn7xaQSs5ioDVfw7v4r/jjfRK
 /N/uGi5f3N8N60P+corb8T39NpyLiCZTAc1TmaD6P0dDKOtmWpzZ3eut3rLcTaogIk95
 7MsHsj+G9VCqAZrfg0t0pOKxdHMsh9frNJ7s5dKcKTT14PFut+/9+KVgHQr99d9X5MDy
 46nA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20240605; 
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:dkim-signature;
 bh=g1UvfSSZcwq3ztyFTcdZD9fAwXHnGs75XlDMAXCKIXk=;
 fh=gS8oh9EHdcTDcglskGyIv3/M5LtfI+jKdwGYJC227W4=;
 b=Zr7lz/Nk0JAiPxWlgKHTg2qF6VG4W9WzS6Qt2Epoyfkd4XO1XDpnOKm+PYEVEvgxEh
 Sp+FHUVFjvpbDHsiTO0X9snzbOgxk+PBOQcVwQ5aW9n3ZUuiQRZgomJqKfD7NqaVtkMu
 bNSNZV63SAK3xIAOUgConHxkLjDHfrNcEk5PF4180NB7xK4QfQGypP73N/o1Nx2FahaK
 QPNer9LlAtHZkOpEYbMoMqIVNJBtvBYDkCfxdEwRcz9k2SMb573sCLv24QnZ8PrTmmMV
 qmzPKETkBlVELySbRkqpFeXUc8PgdyoeSmbTvS8zBQZNcPv+S9IFAU+V9nf4PBH+nagt
 oUEA==; darn=nongnu.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1774266725; x=1774871525; darn=nongnu.org;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=g1UvfSSZcwq3ztyFTcdZD9fAwXHnGs75XlDMAXCKIXk=;
 b=NP50O/OTGL04GE/ahqU8VwCR5lSRar22/9Kult/hKmYYrurw907Tst6yIFQCVLpfxa
 iAr5zUN2xnlhj956XD+kOTzk+39JKGTiBJhqiXnt146vTdky9KkoNZrRJDYykGi8zemD
 X0SBccW/1vjpFR+XNLNtE6lr37Nb+sXguEO+bPvNoU9Ghr70R9DXVfx/+UwzN7SCudkY
 7cOsJq1L6i5fLFGkB20bnG12lhWz7z0u5zBUfd69TpXFOfxcTnc6SFB6McgvEsc+3HTj
 WEtuLRt+ShkDkCopbRFApJoaGSdA4ftSK1ZHjTTQ3/OTRrMlXNyWRIRZO18mNw1QfZ9A
 STZA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1774266725; x=1774871525;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=g1UvfSSZcwq3ztyFTcdZD9fAwXHnGs75XlDMAXCKIXk=;
 b=RlGNL4xO93HfYTyFQDw1l/zKP+IMFBBZlF04bHO5ZZhE9wOHUr2C32keO8iMO4ddOM
 Ls/+bGl92Mmdg1E9bS4QGzTOslWUoWsrLY8erElqNH7nmO/A0glgZhmBXlU6MM3ob6h+
 I/woRNA5MOu+85Fb82SSa///Xm8A2g0e/bUxhQJIjvP5LVtFsawXWKfFTQisBbbWP4Lh
 0Bn3CX6IRWZGVukSorR09xquQ1N87prIeKLwWt3M4ohjAhjg+YHeC1Dw+O7DdZMScYpm
 iVVmiH0rzhQosir8aKCyVnNAA9anqMJd4Qxwifp6EEgnZTHcDo749Oe7VgiIaiJuATKc
 PsCQ==
X-Gm-Message-State: AOJu0YzvMGQj7JxgyfUjxHl5Ofd9YGjARvJwsZJT6YMfqB/AfSeOPjFR
 jTv1uZjcQHgBCcJ2reh+MEnBjoWqXreGptYDLmnE6t1gw7yal5TpPW+A3cy43rVKb9xXbqCK6Pr
 NVPiEZ2+iDvSwlQBPU1mWJKqx5oGyl8iwMloQRVSx6KrZgyCrzQbnMcc=
X-Gm-Gg: ATEYQzxw0D4d+7+DLyfDJ0GqlH4YGvePkyQ5y+Y7Lwhz4l4nE3JOwUQP28cDXJ/B6Wn
 8XwVLTRHbc3lTMTj5ZduIW5bLCL+14hvklOMDSqcyCOhxT+v7OMkpDAI5kHs796hWPp+1PcZe8X
 +VSgg47N5kPBeXz++QSFVwtDRRY+9Lt7ExZu3F0Lov11ooVGy6CiAA/z6tyCtEvaRSE/IBR+4Pc
 sp/YsPkWM/JtFZRHryXUG7jngK+ACySuhaNZFW4DXRCLPJxFk/mB+VAXZwGZmFHivufUptUG4BM
 8ThR/dwrIFnIs8a/hoFvTXdrEs9zSzImqUNxkzHd5H9eikzEXhbzLbBW3CggYg8BPA8=
X-Received: by 2002:a05:690c:c4fa:b0:79a:b6f8:f9da with SMTP id
 00721157ae682-79ab6f8ff0emr27197837b3.58.1774266724698; Mon, 23 Mar 2026
 04:52:04 -0700 (PDT)
MIME-Version: 1.0
References: <cover.1774099044.git.dingtao0430@163.com>
 <6ade608e668d8fb9e720639333a48120bb814d41.1774099044.git.dingtao0430@163.com>
In-Reply-To: <6ade608e668d8fb9e720639333a48120bb814d41.1774099044.git.dingtao0430@163.com>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Mon, 23 Mar 2026 11:51:52 +0000
X-Gm-Features: AaiRm51sc1JlAWm3v47rkt73sZ9qd25ionVXSgcqxr5vhnq7jKHRQgyV_7tKF2U
Message-ID: <CAFEAcA97JFytdf1ZZfoMX-Rt92kfOgq304WahUWD2tQY6WsW+w@mail.gmail.com>
Subject: Re: [PATCH v1 5/5] PL080 add transfer memory and peripheral
To: Tao Ding <dingtao0430@163.com>
Cc: qemu-devel@nongnu.org, qemu-arm@nongnu.org
Content-Type: text/plain; charset="UTF-8"
Received-SPF: pass client-ip=2607:f8b0:4864:20::b134;
 envelope-from=peter.maydell@linaro.org; helo=mail-yx1-xb134.google.com
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

On Sat, 21 Mar 2026 at 15:47, Tao Ding <dingtao0430@163.com> wrote:
>
> On the interface, 0~15 represents single request, 16~31 represents burst request.
> Access peripheral data based on the validity of the request. For the convenience,
> we only respond to single requests. The number of data read from the source and written
> to the destination is always equal, with a value of max(swidth, dwidth).
>
> Due to the lack of data preparation by the peripheral, it is necessary to cache data separately
> for each channel until the peripheral is ready for processing.
>
> The width of peripherals perhaps not possible to process all data at once,
> so continuous processing is required. Read from source is achieved through "continue",
> while writing to destination is achieved through "goto".

This has tangled up the original bugs we were trying to fix
(that we weren't handling the "last transfer is short" case,
and we weren't decrementing the transfer size register by the
right amount) with the DMA transfer code.

Can you start the patch series with the bug fixes, and then
if you want the DMA transfer implementation do that second,
please?

thanks
-- PMM

