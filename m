Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B0F6CCD5BAC
	for <qemu-devel@archiver.kernel.org>; Thu, 21 May 2026 13:58:14 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wQ3uD-00016l-CI; Thu, 21 May 2026 09:57:45 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1wQ3tv-0008IR-37
 for qemu-devel@nongnu.org; Thu, 21 May 2026 09:57:30 -0400
Received: from mail-yx1-xb133.google.com ([2607:f8b0:4864:20::b133])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1wQ3ts-0000xq-Br
 for qemu-devel@nongnu.org; Thu, 21 May 2026 09:57:26 -0400
Received: by mail-yx1-xb133.google.com with SMTP id
 956f58d0204a3-651bc83e74aso6424932d50.2
 for <qemu-devel@nongnu.org>; Thu, 21 May 2026 06:57:23 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1779371842; cv=none;
 d=google.com; s=arc-20240605;
 b=hu5u22iGdJL0F+OmgGgutEjJxgwVvX3o0GbXsB0PTHq1JlGS+74hy6zDMxR5VXgUKu
 8kYu0OPZO/pzpIi1/EpjW3GnCjHlqT88JBwbmhF+UkvsOtDpsSPFkIwD6d2qYQyUmC7r
 AV2tVJ+OD1CEGfnUZzZRIP1o9AUCchVFLGYqorKzvfvvMxEorCHl8RPNauhIKf+1lS39
 CFWQ/4RNpScj+JMp1s74feJ79st14WptYARV9Eh3olvtPn/gLZDfptND4+HvZ2RQ6d6c
 kBjHeacrYOhiJXHgISarqqWLxQg9j2SSj0fw3SOXfKwc4MoFX9wX/9vBIPWcCMMS/I6a
 HJ0A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20240605; 
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:dkim-signature;
 bh=e+9v4n/h0v0fvZvcCQ7SjM1IakuPAtpdG2C6HfBk1hI=;
 fh=/ftcwOPYeEIhzseC7WF42kR+xVR/IJiWpLC1+A7SOWQ=;
 b=AqP2dt6z83dTAU2tie/S3hZo1oJccWd/MUDxlJULcT+nuyMrwKRtBfqSKk0D6sGIoq
 Oka/8fE7GT1VbhPkBZzF+iHuaKvZZoTrMKUTRhF7afEyzDm1L83XK2rkPH3rZFAwxvny
 dGglNLWarm3HAdPpSGfWnEmJBazV2H+zp0UuZCUOoPRUm/qjC1PDp+M+EyJpMvJ9Wf7J
 c8Fymyg1UbpGGp6aq5oxbSyvq5XvGQtAqoNnKMgQwPYbv2TDPwone2Kna66Ikb/pZFk6
 TOPpehq7riGJPQuzy3yOQ74vokTxfr2Y7fNGp8PzVQdu9ZC6BGFc64Y/thtG3gEK7B5x
 eCiA==; darn=nongnu.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1779371842; x=1779976642; darn=nongnu.org;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=e+9v4n/h0v0fvZvcCQ7SjM1IakuPAtpdG2C6HfBk1hI=;
 b=cx+E660VjjRZi1Ycn3ET0MjshL0R9Id9EiyMJqnbCGQa8SaIIRkxm848Zui6Hh2lFN
 TcqhfO7sSGssgjUW0wCLxmIDso2mIDzTfZiTmhBcTvedvHSfnnAiiUSjpf5BDdi39RSm
 Bol3w9txLXsZ8Aa5y2rY11CIQ/9v5KlxkL7gb7vJAVKEyC1th+ESxFI5UD7TiED02RXt
 OA43ArsCgsc9pRsi92bSsDb6NnzNaxvYBv8dZupgaChXf8lQPd6fyYVRLmWjmLqLcJWz
 KHhovMswBMERJ3Idyt2LAcK+2OyX8eOtNeQi9dk72IoLgoosRj8MzpIqSWut4+/ML9Ib
 T/7A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1779371842; x=1779976642;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=e+9v4n/h0v0fvZvcCQ7SjM1IakuPAtpdG2C6HfBk1hI=;
 b=Kerddxny+i0X4h9284XQoiE4eQuYK7L6R/lxN+CSzNB2raRhlxU0pckAxMIbB5PP51
 U23H/dzWFxcijTFqT8LSXzxH4uCBrk8WoOJs59sdH21bs+TEL3HY5r/cdwvhinBx5K1L
 zqoARsaFPJtnZA6JA2SozFo7M+YOeW92BYRPM5+C34JP6FewMwOsqgmuccSEdUopaRah
 BwgoBtpAngkHGvORJJ652o7d4vSbTWx+4Bw7sEXdKRgplC0Mpv8YDZTPrbybGoXMiLb9
 n0zuxp1AFxJqZW6ItZt+SBYVPbkbb2DvscPzBLkFM/4D6p+88Ys0SN1laigE3mJHl/71
 wP4w==
X-Gm-Message-State: AOJu0YzLzp0A/UZsU4CvB6vXQi/xLakFLvd5BjuFZUCX/7h9fXJaxJDs
 TGr030eigNt555Pts5QSrGWN+F+BLF+xwunbXTJC1xBpiDXbpoVym3aoWfdS91yw8vZ8dE5KY4I
 Tmf6xufWXxCuvVWi0i9NvdIycj76STjksnVKWKOHRkg==
X-Gm-Gg: Acq92OHknQIeYFWDt6QU7sRkoDQLDOTqN6cIJAhJHBQHx42cgB2YmNZ0AxBmcaChFud
 4a5mTqJBmr31KJvV4CAV6GNd1e6QXj9q4BrUZOovIfqmvP4lXdpUKnNH2PjY7HibJFqEG/DtSun
 jk0C//xWPWzPwr1l+uqMKL4+/Pr0tlahLI2cyMx8A8z9saYBv612IU9cjKSNbXf7mDSv3EP4bcx
 5lhTgWX2PKkeYUVkR8VEvaWxFaDhD7Own1EwGFFB08ZQxf7I1orrhiPA7nWXd2X+PQZeJW7NLRl
 /pydQSEgtPh6hUKGydHRiCqBMtK5i5D4MsLzKnyZ3FDhQDMPRv95SEdAUS2QwE90/ec=
X-Received: by 2002:a05:690e:1510:b0:651:b86f:3657 with SMTP id
 956f58d0204a3-65eae2ed599mr2254385d50.36.1779371842331; Thu, 21 May 2026
 06:57:22 -0700 (PDT)
MIME-Version: 1.0
References: <20260520182213.872945-1-richard.henderson@linaro.org>
 <20260520182213.872945-6-richard.henderson@linaro.org>
In-Reply-To: <20260520182213.872945-6-richard.henderson@linaro.org>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Thu, 21 May 2026 14:57:11 +0100
X-Gm-Features: AVHnY4JH3aKAqlQYarF13-f7r3KbRw8yRH-mvD7xmBKZDCHafnOIiWr6ndff_Hk
Message-ID: <CAFEAcA-cBgyNjJ=-D__fjwP_jVDuxH-1z1QaZbOXua7Sb+inWg@mail.gmail.com>
Subject: Re: [PATCH v6 05/64] target/arm: Enable FEAT_FAMINMAX for -cpu max
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

On Wed, 20 May 2026 at 19:24, Richard Henderson
<richard.henderson@linaro.org> wrote:
>
> Signed-off-by: Richard Henderson <richard.henderson@linaro.org>

Reviewed-by: Peter Maydell <peter.maydell@linaro.org>

thanks
-- PMM

