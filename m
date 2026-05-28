Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 16E8ECD6E44
	for <qemu-devel@archiver.kernel.org>; Thu, 28 May 2026 09:34:35 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wSX87-0007y3-1n; Thu, 28 May 2026 05:34:19 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1wSX85-0007xU-I1
 for qemu-devel@nongnu.org; Thu, 28 May 2026 05:34:17 -0400
Received: from mail-yx1-xb134.google.com ([2607:f8b0:4864:20::b134])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1wSX83-0001TU-An
 for qemu-devel@nongnu.org; Thu, 28 May 2026 05:34:17 -0400
Received: by mail-yx1-xb134.google.com with SMTP id
 956f58d0204a3-651c5d525f6so12752638d50.3
 for <qemu-devel@nongnu.org>; Thu, 28 May 2026 02:34:14 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1779960854; cv=none;
 d=google.com; s=arc-20240605;
 b=Dc85Bz4j4Lq999khIvNeekfvJnGPm3UOS6U6oILzW+X7LCDcfREdEzcifjb3NknmVf
 qyl9FqRQ2aGqCr/lbGP2z46cEKR6s6LUY0hGYJOnvh8Vc8xrd7PDqQuI3PSwwHLQw5eK
 SNmXNnGGGME96ZzZa1ocLriT2oOjDpvrHVZbajz8AS3H3dT4BRTTXxR/3aVvvd+cmQ4D
 ++W7E1KqeW697zJHy6CR5cf+5yNZjOwUMviSkgdIXYYSNGlz4YIE0ArpUiThIE4KGQUG
 QF5JH36jx1YGUoa80LdeHAky8x8YxYJztHn3uQ4T44xI9T+VEl5rx14WA/MZGA6GCn9y
 YuHQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20240605; 
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:dkim-signature;
 bh=flneZco2VhUbFZjyWPcundk2HJMZGLAmVXpGA/heQZY=;
 fh=GRGAhYIRyJLIexm/SQeD/ONQMnKo+TSDqNowgo15cfY=;
 b=CDtqmHIfKDxivUi+oZ+5tCu8vWmrFt4qJNj838cN45Nuj/31I/rewZt3XvFcMhXPIr
 SUBZhP/2CmSpbsP+gfF2Tk+kQPgaA/DQcfYvk1MBTOro6v4jmOtzwuEpneFSzkLf55aC
 ScRJDlLii2LuEeE5osxrg1JmQ+UVbZkKtslCV4QEpi5q+TcNX6mogyn9Wr9aBILwsv+8
 MAfjBnV0TNhT1YeGed9SOHVnoAKLNGux4AtV7wPhPbc/AKztvklQFblH9f8/HcGTzdFI
 4KIMNRRj8iWFoHXf3aG/m9bVr8Hotqd1fM3LBSbyQypfqiuABK2AJpEAlF1QWn9AN12f
 sX7A==; darn=nongnu.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1779960854; x=1780565654; darn=nongnu.org;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=flneZco2VhUbFZjyWPcundk2HJMZGLAmVXpGA/heQZY=;
 b=ExhjNOdrKqJVGzJ1Kd8B7vke1RJJpOxya2g8WbEes/iplTgPCTHgzgePipWrPyMVpr
 qDimyQB2a/uG1LzZTHkrriTYSd3U06j9Rw9buLsLJbqu+zXN2eGSXT5SL6ZnI1mDzVMu
 20Z3CdAtTyuGrk1asWX88bYO/pp2s2HIOSHvt9/WHfEL3+wQpcMrnCkfDoKtpAV2m2lI
 RP8vlOwua4Siry6dk8Yqh1IhXwDESq/4jmQ9g4AJPMWuEekj/Qs5sohFIQjyDxa/50Wj
 LWsexuSIMbG2ICpTSrCH9eSGlYposI/FMztYqSp0VfjZLb1H3vkfvaXqgoojiS9XhFqp
 2fYA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1779960854; x=1780565654;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=flneZco2VhUbFZjyWPcundk2HJMZGLAmVXpGA/heQZY=;
 b=qJSr2Dy9xbHtixtLiaIQuGi/BmRtG1gEhZcTUPC8r4Ke0pKcptdP6X0aFdVohfErFV
 gB12A5wzztydmwsgAsqIUozwzL8C0ACjp05ht24umZPiko0CGCyfZnGPDXD5KMCf2XH2
 +BmQFf/u7TL/od7qRPxO+LemZAPq3t+Wrm/GF8rtUpggvNSdYvDDCPlYnWmLGgYWa8rC
 FW5ZVRwATGs3H6ZWvaj/92NxTiEwq7f8ENKTv7ZcKRovIjdqRA7VVCZTXTwLn2IBFjO3
 QxzwMJuAhNy2vKovq2+XjKs5wzdXd56Ac0RKjWOuzipExTyl1SMMF7XXT9t+ltKiElOi
 XIOg==
X-Gm-Message-State: AOJu0Yz7wA2QoodS2exJ7fSdujDr7nKKNgf/LOSx46VhtRSuPwQUR0sn
 OMti1WpfTDE+gAtArzbkjgQcYmbd4nUzhinKWc8allAxA8jlisQsYCAdAveT6A7EVElcPbAQez3
 X5DFCoyCD8UVDq5fhXGxd6wN7lrBD0LXu+OKkZ75y2A==
X-Gm-Gg: Acq92OFqIr/0aObJUJLk3hRiD5iEdeTPMKTMtgVeqHH12xBAI34d+bYGCI6UpSPj1a7
 u3ZPQl+kymzfG9+GALb/8YsiSiEZvwNYrONXTqpwejl2A0YME+8ygFBZ8C8NueQS+Is3gL0ikf2
 nBX7hnFWS0UmC+ANEQwsRWOIqCJIjA2MgwxP6ec5N5Wakqe5efLwzYjsnUt4VKPnXDTUHqtu3La
 EmZjd2gNPxYtIrbZBW/kptr14l434Y/pLp4z4WxfRf+BrclN1XwpOFy3LmgtACWEjDDEGNUwc7y
 97z7/YN62vtMpASD3JWDPpdL6UdL5Ge5Xoe4Je52b6qeHfDTaoQ1qec8yrS7ODLAw0gJU/Q7H4K
 k2w==
X-Received: by 2002:a05:690e:4186:b0:65e:1bf6:1386 with SMTP id
 956f58d0204a3-65ec97b904amr21464174d50.17.1779960853850; Thu, 28 May 2026
 02:34:13 -0700 (PDT)
MIME-Version: 1.0
References: <20260522220408.235438-1-richard.henderson@linaro.org>
In-Reply-To: <20260522220408.235438-1-richard.henderson@linaro.org>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Thu, 28 May 2026 10:34:01 +0100
X-Gm-Features: AVHnY4KRE8l0zjwbPuNsbzG6Og0pifgpBVC_TBgNfDLBSzb2d64qwj_BM2lRwRs
Message-ID: <CAFEAcA9A45z1rmDqDC4DzC2rPErwLEgk0EFk-Qdsd1kGWfvp3w@mail.gmail.com>
Subject: Re: [PATCH] target/arm: Enable REVD for SVE2.1
To: Richard Henderson <richard.henderson@linaro.org>
Cc: qemu-devel@nongnu.org, qemu-arm@nongnu.org, qemu-stable@nongnu.org
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

On Fri, 22 May 2026 at 23:06, Richard Henderson
<richard.henderson@linaro.org> wrote:
>
> Cc: qemu-stable@nongnu.org
> Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
> ---
>  target/arm/tcg/translate-sve.c | 3 ++-
>  1 file changed, 2 insertions(+), 1 deletion(-)



Applied to target-arm.next, thanks.

-- PMM

