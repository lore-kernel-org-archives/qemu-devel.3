Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2F77CCCF9F8
	for <qemu-devel@archiver.kernel.org>; Thu,  6 Nov 2025 15:58:41 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vH2NO-00017c-1o; Thu, 06 Nov 2025 10:58:18 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1vH2NK-00015s-7R
 for qemu-devel@nongnu.org; Thu, 06 Nov 2025 10:58:14 -0500
Received: from mail-yw1-x1131.google.com ([2607:f8b0:4864:20::1131])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1vH2NF-0004Fs-Ui
 for qemu-devel@nongnu.org; Thu, 06 Nov 2025 10:58:13 -0500
Received: by mail-yw1-x1131.google.com with SMTP id
 00721157ae682-7866dcf50b1so10467257b3.3
 for <qemu-devel@nongnu.org>; Thu, 06 Nov 2025 07:58:09 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1762444688; x=1763049488; darn=nongnu.org;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=rgWktmS5q1huT6oe4k17o70+9vTjaN8rRb1/H4J9qLs=;
 b=DzmiGSjYBGLBphMO/wc2ExN48xPYV0IXdeZ5qBWXS0gUZ9Y1f4gj+VWb67wZlndrsQ
 Y02KQenHwI6L2q1oPR6ZaPxqIK1KbvQY/si6y/JEuHPt6GfqWy+6xLkTOvmz+jHzSps5
 b5UIKZfNbJTbB4A72iZbA+mcHyf1VGl+SLCDFyaYXvz+A8hj96wL7NKqK04Rl0kZgzsh
 EofkLPqEnnLBt1w1N90GysNYl9iUkN2Tw8i2ABtMvxaTbAzZl8+SVnjBJqfMV0K6sKA2
 4N1GadGklLjU46WtfhwCsUm9rSJ3j6V/kVHP87ilgGL77bZZFRjrx2Imn/T2eUk22YhD
 BvIQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1762444688; x=1763049488;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=rgWktmS5q1huT6oe4k17o70+9vTjaN8rRb1/H4J9qLs=;
 b=tGGIDYU4YNr5CL0tUMkB9PyOZyy+PioO0tm+S3wX6MyRFHlGoyheVIZKA3FpT6i7UQ
 D+HpQDPuIBT5JLltnV/5439yARh0NTy7r0A+V5ZBxoAKTk+flvPLh8XU+UQDDZTX65Zd
 Nq2gnzV9Xzwxy8VttJQK44LiHMTq1hNzRdOtofZnf0nB2gJMUzVJL2CzyTun03xC2ECE
 hUdhf3PBljxNhDdPGw4RJQg6gZlA+rESsLTfEaQToaR2KG8KZIbeZbbtdmuuEGjwTT+k
 3DMYvDpllkI5yfPPDW2WSFpzZ/oTbAyJlD+1Q4sRORUC+OSyRUtIqgPB+tHA4disp1WS
 wRbg==
X-Forwarded-Encrypted: i=1;
 AJvYcCUgmZyzPGeOn9X7SCmcZ9IIhTzw681PtAp6mOBD4ufXJIxJOdc5Eme0jjNig68GPye8xoLzDTk4wyTQ@nongnu.org
X-Gm-Message-State: AOJu0Yyuuoyprx8pdB3c3BFsdJUpcvVm64dxD2Wx9BeDbVKUKdSo604l
 KareILmfz0SgSqAa67AQCwWq+MvFIwcJxfG6yefKf/fCYJzoZsNMPl6YZVzweJN9eV1fdfKrKGg
 JUynROBTAvetrgobAlHN0VFHfOLcGr437n0dikdRP6w==
X-Gm-Gg: ASbGnctDcXABG5dYjzp6n1jollNNweMhTyLydelUWZ05kq6bjk0m6QR+yEhu3HpskXV
 pX9OIPmZhmFBB9FC2jb5g0M4c66tzVJnxGUqP8qoZj8wlEwKmSp3D9/748oIiM3ag+sGw+jOhzY
 FnVHeYaP8AR4AAu6z9W0aQxzmsA2/l1+Me0pe+YA+6uSD5ysgHw/Q0y7Aut/zthKakpzh4i1qch
 F3hqQ2me+2JHyVibe/gQ6nIrdYVlJE/c6frnZDW9DAwEeK5OpRwRQ7WdbajRQ==
X-Google-Smtp-Source: AGHT+IE7eBz/i+/M0lq0vBQEM133eq744VSyNC3af/xbDcX2XChnVCmnpBhDnZXkQQpdoaMmVJ3nSMBABupFvcYF+Ts=
X-Received: by 2002:a05:690e:dc5:b0:63c:c4f4:53cc with SMTP id
 956f58d0204a3-63fd34c5101mr6226340d50.22.1762444688207; Thu, 06 Nov 2025
 07:58:08 -0800 (PST)
MIME-Version: 1.0
References: <20251106144909.533997-1-richard.henderson@linaro.org>
 <5ad511f4-eb36-4d49-90a6-fbb1e5f67c6c@linaro.org>
In-Reply-To: <5ad511f4-eb36-4d49-90a6-fbb1e5f67c6c@linaro.org>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Thu, 6 Nov 2025 15:57:56 +0000
X-Gm-Features: AWmQ_bkOdnkuBG7lJD7Jod0BIZKK8pKvKwGArC3Iv5qgU64faiyv6WX3gnoie1w
Message-ID: <CAFEAcA_gkyMTynt6ndVCDaq1RwwvpOUbYNm-=RjE17xuuTTCyw@mail.gmail.com>
Subject: Re: [PATCH] target/arm: Fix accidental write to TCG constant
To: Gustavo Romero <gustavo.romero@linaro.org>
Cc: Richard Henderson <richard.henderson@linaro.org>, qemu-devel@nongnu.org, 
 Anton Johansson <anjo@rev.ng>
Content-Type: text/plain; charset="UTF-8"
Received-SPF: pass client-ip=2607:f8b0:4864:20::1131;
 envelope-from=peter.maydell@linaro.org; helo=mail-yw1-x1131.google.com
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

On Thu, 6 Nov 2025 at 15:48, Gustavo Romero <gustavo.romero@linaro.org> wrote:
>
> Hi folks,
>
> On 11/6/25 15:49, Richard Henderson wrote:
> > Currently an unpredictable movw such as
> >
> >    movw pc, 0x123
>
> bah, how did you get this insn.? Are you using any fuzzer? :P
>
>
> > results in the tinycode
> >
> >     and_i32 $0x123,$0x123,$0xfffffffc
> >     mov_i32 pc,$0x123
> >     exit_tb $0x0
> >
> > which is clearly a bug, writing to a constant is incorrect and discards
> > the result of the mask.  Fix this by adding a temporary in store_reg().

> The difference between v1 and v2 is:
>
> v1:
>   mov_i32 tmp3,$0x123
>   and_i32 tmp3,tmp3,$0xfffffffc
>   mov_i32 pc,tmp3
>
> v2 (this version)
> and_i32 pc,$0x123,$0xfffffffc
>
>
> I think we need only a v3 that updates the commit message since we
> are not adding a temporary anymore.
>
> Interestingly, I was not able to crash the host when native code
> was generated from:
>
> and_i32 $0x123,$0x123,$0xfffffffc

The commit message doesn't say this crashes, it says it
discards the result of the mask. (That is, we intended to
clear the low bits of the guest PC but don't.)

Should there be a TCG debug assert for "TCGv for the
result of an operation is a constant" ?

thanks
-- PMM

