Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7A4C3CD5BAF
	for <qemu-devel@archiver.kernel.org>; Thu, 21 May 2026 16:41:48 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wQ6Se-0001nx-Iq; Thu, 21 May 2026 12:41:28 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1wQ6Sd-0001nX-HG
 for qemu-devel@nongnu.org; Thu, 21 May 2026 12:41:27 -0400
Received: from mail-yx1-xb12f.google.com ([2607:f8b0:4864:20::b12f])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1wQ6Sc-0002ig-4c
 for qemu-devel@nongnu.org; Thu, 21 May 2026 12:41:27 -0400
Received: by mail-yx1-xb12f.google.com with SMTP id
 956f58d0204a3-65dbe04fc1bso6746759d50.1
 for <qemu-devel@nongnu.org>; Thu, 21 May 2026 09:41:25 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1779381685; cv=none;
 d=google.com; s=arc-20240605;
 b=bCxsxYUa4bHL571cfx+8mGXmS1/AaqTm04DkxMFFUewowkOYn8GJvAVIH92vVJUp9R
 4pczDea8c3K1yJ16joSWdTHAclRshG56Oe/NZC5PMh3kSjCjHznYrfvwaLfC/jgSzH6r
 +MSPNytw7SKmXAtMc/PpwELrj9sF9t7PTqS6qirZovWMfiNqvm3uIhgFPXuWY8Fh6ID+
 EdhfCvLo2SMul5GiuODHHEewfR3xDpdrcgoxeMlXhCWzLBUvqb4iHeVd/3vlc8dkN/VA
 cshT5X6BvsFwtt13Hekn8zxqXci+tb5xCwsXI2q1asBEfBEmnBxoLL8EU1ufjSlvuvwh
 9nVQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20240605; 
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:dkim-signature;
 bh=WZGcVxrAD8TQcq4nZQsOrHA/qVqTF0GTWDQgd61XImY=;
 fh=/ftcwOPYeEIhzseC7WF42kR+xVR/IJiWpLC1+A7SOWQ=;
 b=SxhwQ6fCSX7yPc2oyoX8WlV14fEioj5yLvBF3qrAmbfH84j3d5FLq7n7Mnu7AfMcLH
 Zc5rVNg0y1dT/KlheJ99YaZsFswBMPKhhvQjNaAbB/gUhbJwB7xZKTWkWZ1Cqhw8a38i
 hlnS+1EHvm4gGsFcDQT/leC2X+A52+TXWAjyUaXiFdylhExeen3/fUxSJnF3MQExxeuo
 ikRdJwcMArhEOWAiGxDAWvU+1CVHYO4jsZ3M3ePkEcbculRRcaFYihGJAgwWzz1pAZ+E
 XHOWjXJ8TKp+MNSYseLjCW1uJFqCKfRF5OrSi4xovl/oih/6K5jYbDj+f4y4iP8bCCre
 c/rw==; darn=nongnu.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1779381685; x=1779986485; darn=nongnu.org;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=WZGcVxrAD8TQcq4nZQsOrHA/qVqTF0GTWDQgd61XImY=;
 b=K1ht0MLF1VHOPOG4UHuR+jJ743TI1T7yMJfv6l6tcRF4DavxXa9XVr61V4hrLckwPd
 TeF6AX98ikQnnJNiRWc6YANvl4wk2BELbTRfb5NDff3YnLLsi+57pnvuwXOcQK05EDfl
 JXJJ6N4VT7FSFodkUw7aTXab+XKRzF3g8M4VkzjgQ4dslBE/MixER/jfh2RZjncyOx1C
 4WycRfQ/jPQny6/3yLhd0EBW8AXbg2Mt5Q/0YnoAEOrCUc/EoUM7qVtuSBqutQCxDR2F
 xnWUtbepgnzxpwWa7BdHI/p17gczS9EVwDzJ6pX/NjCDO2LIZDPA4Ulec110VPbr8mIf
 MJlQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1779381685; x=1779986485;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=WZGcVxrAD8TQcq4nZQsOrHA/qVqTF0GTWDQgd61XImY=;
 b=AziWN0a0W8dV3c7DcTzDsuQCPtXRL0mdBDcBeeo0aLNW91QajtSSeJvjViDkg8wlvs
 U+QXJ90cl075Gv8boZuUu6mFGVVxFdmAgvvz5ewj6a6ZBlJvqDAoX0Y1JsKNbS3CwZ6e
 64Amf1+ma6IBKG2rcdErnIx8ZPtQU3kpYAqHLWPwscaYwaTl8Wu+dW72YaTSPRHnArN1
 tVtd08u0YN54S8aJRG2eNCwajRRY4ObVg1uZdPAtzY7UBS2Z0MNQKrvaRfWj+T60GR24
 Qt6vQo0uir13k8zFS8A1a4055d9sOEHXlqMZrymz/ohBSxOobsG0/X7T3SaEA/zuK3or
 ac5Q==
X-Gm-Message-State: AOJu0YyECkPmOaqTrJROFXgVg5ePp6v/GBipisBPeFCKhl3TtlY1ilGc
 aqL99iPsoZ8VGULf7xz8jB+j/GPID9pUseOlXZqDmi7GNew3flsi2yMDyYJBQMRYE9zy5YQQ7RK
 xkDu11wIxrYUkQn53xcYUz5VlifUGQdT+dGlMRTebj5tThvkSwTs+
X-Gm-Gg: Acq92OGffmGrOgG1Q1Qj8y2oYbj3/CmZmt8OTAVH7FfhYNjgEv/7ibaXa2zh2gewn+C
 p93aTP5IyE3rO/ecbGkNOCj1fAOIvBT2dpEO/ZSk0obEDAl4R+1t01bd6HaJr1heYO1pjYsYDHb
 28XLsWnDUqcumCEwJrwcGK/anrgmVZwOl09LVJqZZtCj/+2eoDBkF5LbK0h8KIFvRaMF5/WvUun
 WexqaBAM1rrKyODLnubJR1P2k/uCyb5NlgF5+4DFb3f0b3pc+1+SNw47dXJyDxjmkBjO4QW4gQx
 q5ilAMlpS9QRO6T0Fnhzla21ay9CwL0MazmhecY/uOD5P19zr+Y8HFFPJwEqGUyfMbo=
X-Received: by 2002:a05:690e:4196:b0:651:ba22:fcc3 with SMTP id
 956f58d0204a3-65eae23512dmr2648495d50.61.1779381684792; Thu, 21 May 2026
 09:41:24 -0700 (PDT)
MIME-Version: 1.0
References: <20260520182213.872945-1-richard.henderson@linaro.org>
 <20260520182213.872945-43-richard.henderson@linaro.org>
In-Reply-To: <20260520182213.872945-43-richard.henderson@linaro.org>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Thu, 21 May 2026 17:41:13 +0100
X-Gm-Features: AVHnY4JDj1mWacxTuxY8UeafFviEqaeZy6qc2oTWTUMM5HRxn9cV_M8LG9BBKus
Message-ID: <CAFEAcA-fc9uKtfdt_Xq6xfXuxFSRF-Jm4=Rgus4VGiBxJVejdA@mail.gmail.com>
Subject: Re: [PATCH v6 42/64] target/arm: Update ID_AA64SMFR0_EL1 fields to
 ARM M.b
To: Richard Henderson <richard.henderson@linaro.org>
Cc: qemu-devel@nongnu.org, qemu-arm@nongnu.org
Content-Type: text/plain; charset="UTF-8"
Received-SPF: pass client-ip=2607:f8b0:4864:20::b12f;
 envelope-from=peter.maydell@linaro.org; helo=mail-yx1-xb12f.google.com
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

On Wed, 20 May 2026 at 19:29, Richard Henderson
<richard.henderson@linaro.org> wrote:
>
> Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
> ---
>  target/arm/cpu-features.h | 11 +++++++++++
>  1 file changed, 11 insertions(+)

Reviewed-by: Peter Maydell <peter.maydell@linaro.org>

thanks
-- PMM

