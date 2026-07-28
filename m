Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id EB4B7C53219
	for <qemu-devel@archiver.kernel.org>; Tue, 28 Jul 2026 13:03:18 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wohSW-0004De-Su; Tue, 28 Jul 2026 09:03:00 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1wohSV-0004D8-Td
 for qemu-devel@nongnu.org; Tue, 28 Jul 2026 09:02:59 -0400
Received: from mail-yx1-xb133.google.com ([2607:f8b0:4864:20::b133])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1wohST-0000Wf-2d
 for qemu-devel@nongnu.org; Tue, 28 Jul 2026 09:02:58 -0400
Received: by mail-yx1-xb133.google.com with SMTP id
 956f58d0204a3-668005ba03cso4887671d50.2
 for <qemu-devel@nongnu.org>; Tue, 28 Jul 2026 06:02:56 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1785243775; cv=none;
 d=google.com; s=arc-20260327;
 b=iHM5u227IcgU2EjFZeawDAS7+iPUNrZHzuSyd+ictTXpIL4kY5hcgw2ugbkyYyWqsb
 isLn1fxE1mkkwNOm3Jj3pcGZ/R6tyj/0DmpJkalA4nq6HPMgSOiN4Km5LOpVnyr6UsMK
 SbyKc0fED2eminQbmFOL5FOODeV88rh3Lv7y4zYrWhclhP9rnDRo/MmcumKmHNr3YlEl
 It3EqUpd1bJyTM03XmzLUmZJNqCv7ATJ1oUzC5OzHiGtfFV6bDE6ivdh06u9raLNcr0n
 VaXx1j8jwwMcIGTbdhZ7/7/jTPRA9eJf5filMf6p4o93+GWke4uN4sxx5DUO6GdqgViY
 jTKg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20260327; 
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:dkim-signature;
 bh=92d6TDnM0T6Xk1fttE7A1YNiFfPbLs+kxkNozXcZSVc=;
 fh=/ftcwOPYeEIhzseC7WF42kR+xVR/IJiWpLC1+A7SOWQ=;
 b=Zv0fs9ZOaDO7KPiHtMFRanJtzt7WBfx2Bl1+BKnypf1pTnZBhOK4/fgQLvY0Z0U3WN
 8qj12pN5Y98iyHsR0kPog/pIVIDLzBmObt+nLTRRMaSvSBY6B8/K3SB117zGEwWI5uex
 CZz1L2tgZeNl1LTBlJORYShvQ3etcQeyns/TS4y2rrL4v3PIn7y3P+u5I0HY7WfA9PMz
 dhmyiXmsu2glBaFh9Hs9svwi3wFV9c/WHFL7oqi1v+3JUjH8Ka5SxflTqB1Ac3JHRrY7
 deuhMikGeC2ZVm9fdVHQ11sFD8a1VrCHZvxtx9u0VuRl4KzurDve983ZkB53XR+qKPCO
 4bKQ==; darn=nongnu.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1785243775; x=1785848575; darn=nongnu.org;
 h=content-type:cc:to:subject:message-id:date:from:in-reply-to
 :references:mime-version:from:to:cc:subject:date:message-id:reply-to
 :content-type; bh=92d6TDnM0T6Xk1fttE7A1YNiFfPbLs+kxkNozXcZSVc=;
 b=TuCZHXHVupnjBB6WDINug51UQchRFMkqIID7j3rYTbBVBWL1CeU8mVMbqQmxg+QLNA
 dhQRpZ/cgsmkzVGXt+a2yKwWRGAgCLkGAbV2hchEsn1DywmaWsIhaC4txcSujz3yoldv
 2EI/oLi03oBhGH7Z1n6RDygW2cSH70/yRoQqQN671oP/6rOS9/QBAUtlJCsQmKwbMx7X
 Om6nhpFoWvqQQoS57aCpGWrSS/hx3H6bBbTS/Tb7QGZYwS1lxEAfZW/8bbjokKwg6lMe
 t10pjPyAfrG59AuHWhhWEqpFocrdLaSm/4bQKfOZNtb4d7wW7X+y13k+o0tZ3ydiub8E
 dTOA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1785243775; x=1785848575;
 h=content-type:cc:to:subject:message-id:date:from:in-reply-to
 :references:mime-version:x-gm-gg:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to:content-type;
 bh=92d6TDnM0T6Xk1fttE7A1YNiFfPbLs+kxkNozXcZSVc=;
 b=RXYaPna42e0FYZX0gUSSUBowJ1OIwGbBv7EgMmWe6l1iPcHQPs/U8UNDNR/GyHc374
 OO7kfVVuHGCjSfgo44qCfxHOSYS6vE0KyxuK2ZhhB7vfYumZYLAlnCdSAR0sv3zYcrOZ
 zLA1QAf5PfmUjvtfuTAZKiA1tViAtVdxL6TQhDQ98OQPzs6brlX9kb+BpO6yXIHfwhqZ
 Gg5EweQiOWGxMz/DNKtTiRDH2pXJBFpv+KKNAcTlhnSW+juLCPFpfh81lNGgPX8wViPR
 Nl0LO6HDXkNPzKpZSlmeSZDlYU0ut/2xix03BzoLZoMb8cbN9cYMQBIk+o4el7g5aOVn
 slWw==
X-Gm-Message-State: AOJu0YxMIDJFwrMLVBdtMDXaTMdK0o9KiCc7RGkAaibICJ2fLrhAKNgq
 u9KjLtHxn6LXjFeuXqUFO4Zfq51HYHA290Ax5/I15NUHWggSAExcON3EnIfn5y4I0vEFCzf10Yi
 XzZTVk747HwGfujmziznQK9qSOfpEZp+8FHjImYsG+g==
X-Gm-Gg: AR+sD13Crx4pnxvGO3n8WrT+5Q8PNTVo4SMn5uxq4P4QKY13U4KwCukgh4OSTGfbfXa
 KLM4Xd6VcK6ItB6SZZo5/CtNX09gaoeb5R0/WdRmK7R1JuC/B+rgo8lzEGmp3uPk6fVPmesgvNi
 YXxfiidJIObTl3KJUI+2R1Kbd2c2DUzThhhpN9i83PXGLRPKCAfIaBzJ742WqblEL839XgvWgSK
 ji1DrVO6Y7v0OSdPcFaYuO6lPSaUZBreGriAWbL38ggZzqWPbHy5WBxn8RagWgoIqJK2HIr5cdA
 xo8katz+bfK8QqUqJPm1IszvHh5oTurd6TQAJ6ZvILrb1OeDC2j0DPo1
X-Received: by 2002:a05:690e:4091:b0:667:911c:54eb with SMTP id
 956f58d0204a3-66905822048mr743138d50.74.1785243775236; Tue, 28 Jul 2026
 06:02:55 -0700 (PDT)
MIME-Version: 1.0
References: <20260713230244.70174-1-richard.henderson@linaro.org>
 <20260713230244.70174-3-richard.henderson@linaro.org>
In-Reply-To: <20260713230244.70174-3-richard.henderson@linaro.org>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Tue, 28 Jul 2026 14:02:43 +0100
X-Gm-Features: AUfX_myPczF3v7ca2fHMma94uowCAgdOeraJqwlYTmBoUc9sjoKYpjIAHR497tY
Message-ID: <CAFEAcA_g_7oqTVb=9ThdDY49Q4r78dAMQK1v-Cxuykmv4KTFKg@mail.gmail.com>
Subject: Re: [PATCH 02/10] target/arm: Implement FTMOPA (non-widening, FP16)
To: Richard Henderson <richard.henderson@linaro.org>
Cc: qemu-devel@nongnu.org, qemu-arm@nongnu.org
Content-Type: text/plain; charset="UTF-8"
Received-SPF: pass client-ip=2607:f8b0:4864:20::b133;
 envelope-from=peter.maydell@linaro.org; helo=mail-yx1-xb133.google.com
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

On Tue, 14 Jul 2026 at 00:04, Richard Henderson
<richard.henderson@linaro.org> wrote:
>
> Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
> ---
>  target/arm/cpu-features.h        | 5 +++++
>  target/arm/tcg/helper-sme-defs.h | 1 +
>  target/arm/tcg/sme_helper.c      | 6 ++++++
>  target/arm/tcg/translate-sme.c   | 2 ++
>  target/arm/tcg/sme.decode        | 3 +++
>  5 files changed, 17 insertions(+)

Reviewed-by: Peter Maydell <peter.maydell@linaro.org>

thanks
-- PMM

