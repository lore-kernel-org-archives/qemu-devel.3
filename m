Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id CAFFCC021B2
	for <qemu-devel@archiver.kernel.org>; Thu, 20 Feb 2025 14:16:41 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tl7LX-00071B-KC; Thu, 20 Feb 2025 09:16:13 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1tl7Ky-0006t7-Ez
 for qemu-devel@nongnu.org; Thu, 20 Feb 2025 09:15:37 -0500
Received: from mail-yb1-xb2d.google.com ([2607:f8b0:4864:20::b2d])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1tl7Kw-0005ER-Dw
 for qemu-devel@nongnu.org; Thu, 20 Feb 2025 09:15:36 -0500
Received: by mail-yb1-xb2d.google.com with SMTP id
 3f1490d57ef6-e5dc299deb4so919486276.1
 for <qemu-devel@nongnu.org>; Thu, 20 Feb 2025 06:15:32 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1740060931; x=1740665731; darn=nongnu.org;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=oLF7hMM87dLQpph4+jiQW+iMxLICwPdupdQt6MqEqvo=;
 b=qlRzwGliWLBVeLIW0Bz4FPjgh5Tst2dI8D5NzU/U3y/y3dXsNtrBURx0FOy/1wl57a
 +g0g/Hcbr0Bcc4xkBzF2+eR93W5r7Q6+oQfd4a4rTwDaZZEoi24N6aUPdSaoGiRxxVLB
 /6zz8KiIIReBr2lziua86wqX+PJP/3Y4yntpX/EFqoMv1WeTDA/9QGD/R6aLaDmi1lC5
 6ym7jCPqPFn2W/4inqnL9/cIM4XyiOvAXY8/LaIKDsxlFupPXeEC3zL1WvZzPOixjuKi
 SybpJoe8eGSWMjGlj5nkvoSKhrvkmoCD8vWgZPRG5IbvZOhJTFLQWyLi/XAuPcDQ9Cfp
 Of8w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1740060931; x=1740665731;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=oLF7hMM87dLQpph4+jiQW+iMxLICwPdupdQt6MqEqvo=;
 b=RJlKKH0hZXHGYb6lCJoTHZ7uPDJSmD1otvu8ikFntOKcjGA6MYYk87nuoUWwmZG/lc
 wq1bGoUiVbyeL+CIr8EwQeyvTk6sxFiDrgYy0ev4vyi99K7WW1BQRFZMaz4aK/DDUuFK
 U4RfGGab+IENHf/Ct7gHFPxDvfbRuVi7CIK4Jw23B44Un07gzRyyYxx0s8yas1+FD+cm
 jxBmyRxqlcx2V8xWr9lIVUPe1ReYC1Mb2NYBOM4bS5KaOGfvaeNXTeUvRQlz6m46jkq8
 AQgWU6SggbBQn51Cs3mm+nI4Y7xu6redtyOxc0lVXDLjCXATSQuOCQ82hzcxd9GR7F9u
 TVRw==
X-Forwarded-Encrypted: i=1;
 AJvYcCWNWyLETwvPGGNmXM7T+TaoV7bm1KEdyGvkMyWdDIBMlIw/BH9HHFFtnXaDxy32/6NpGLeScpI1Laew@nongnu.org
X-Gm-Message-State: AOJu0YyzWEiCbtaeYFRKHXlDQ7uBYx5g68abde9h9vkB5OK4oLeP6CkU
 4by2Oqoa0P2r6U6Nftib+U3eWFmR6KUc2V8sagv9xPpyTGSV6FHKU40pZU1HV9rLkowRhXFQBeh
 ZTwRyPjQZ/dYJaX/WM/99Llwx5ZIFjf4qywspUw==
X-Gm-Gg: ASbGncsqt6PoDdbcflEklZtsvPpHCM3r7TJPcXR0NAYXhE3Yu4MXt5pB1JhgUMMuXgo
 xZkgif3TQjmxhuPHVjd6R9okduupop3Sj8ga+rDGUkJ1dOz7GqpywoXIxFfv7UoSO12RZ3cL8qg
 ==
X-Google-Smtp-Source: AGHT+IFQyI3LQ9PQnuQMcVxcF/3wteayb3xw1KfTu/TztKXNxl6COiEyqZEmkpASzPIa9kf7kbsQRdIGXv1qtfNgGow=
X-Received: by 2002:a05:6902:108d:b0:e5d:cd08:12f0 with SMTP id
 3f1490d57ef6-e5e0a183a4bmr6632570276.44.1740060931138; Thu, 20 Feb 2025
 06:15:31 -0800 (PST)
MIME-Version: 1.0
References: <20250219165534.3387376-1-slongfield@google.com>
In-Reply-To: <20250219165534.3387376-1-slongfield@google.com>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Thu, 20 Feb 2025 14:15:17 +0000
X-Gm-Features: AWEUYZmj86MscSbyuSGCk_WUZypFPJqox-xar27df7kPoz6QkDceCnjZ4spQM9I
Message-ID: <CAFEAcA-ZCQ9e1=TimLQTU2OKsqs2-BFX9pV+0Va7=d19E+P9=A@mail.gmail.com>
Subject: Re: [PATCH v2] target/arm: Fix signed integer overflow undefined
 behavior.
To: Stephen Longfield <slongfield@google.com>
Cc: qemu-arm@nongnu.org, qemu-devel@nongnu.org, roqueh@google.com
Content-Type: text/plain; charset="UTF-8"
Received-SPF: pass client-ip=2607:f8b0:4864:20::b2d;
 envelope-from=peter.maydell@linaro.org; helo=mail-yb1-xb2d.google.com
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

On Wed, 19 Feb 2025 at 16:55, Stephen Longfield <slongfield@google.com> wrote:
>
> The problem is internal to t32_expandimm_imm, the imm intermediate
> immediate value.
>
> It's extracted via: int imm = extract32(x, 0, 8);, so the value will be
> between 0-255
>
> It is then multiplied by one of 1, 0x00010001, 0x01000100, 0x01010101,
> or 0x80.
>
> Values between 128-255 multiplied by 0x01000100 or 0x01010101 will cause
> the upper bit to get set, which is a signed integer overflow. From
> Chapter 6.5, paragraph 5 of the C11 spec:
> https://www.open-std.org/jtc1/sc22/wg14/www/docs/n1548.pdf this is
> undefined behavior.
>
> Though this is a minor undefined behavior, I'd like to see this fixed,
> since the error is showing up when I enable clang's sanitizers while
> looking for other issues.
>
> Changes from v1: From peter.maydell@linaro.org's review, only changing
> the internal representation from int to uint32_t, and leaving the API
> types the same.
>
> Signed-off-by: Stephen Longfield <slongfield@google.com>
> Signed-off-by: Roque Arcudia Hernandez <roqueh@google.com>
> ---
>  target/arm/tcg/translate.c | 2 +-

Thanks; I've applied this to target-arm.next, with a rewritten
commit message:

    target/arm: Use uint32_t in t32_expandimm_imm()

    In t32_expandimm_imm(), we take an 8 bit value XY and construct a
    32-bit value which might be of the form XY, 00XY00XY, XY00XY00, or
    XYXYXYXY.  We do this with multiplications, and we use an 'int' type.
    For the cases where we're setting the high byte of the 32-bit value
    to XY, this means that we do an integer multiplication that might
    overflow, and rely on the -fwrapv semantics to keep this from being
    undefined behaviour.

    It's clearer to use an unsigned type here, because we're really
    doing operations on the value considered as a set of bits. The
    result is the same.

    The return value from the function remains 'int', because this
    is a decodetree !function function, and follows the API for those
    functions.

-- PMM

