Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id EE9D6C54F4C
	for <qemu-devel@archiver.kernel.org>; Tue, 28 Jul 2026 13:34:43 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wohwe-00011F-Fg; Tue, 28 Jul 2026 09:34:08 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1wohwc-000105-O5
 for qemu-devel@nongnu.org; Tue, 28 Jul 2026 09:34:06 -0400
Received: from mail-yw1-x112a.google.com ([2607:f8b0:4864:20::112a])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1wohwb-0006Tz-Co
 for qemu-devel@nongnu.org; Tue, 28 Jul 2026 09:34:06 -0400
Received: by mail-yw1-x112a.google.com with SMTP id
 00721157ae682-81eff3ddba4so50316837b3.3
 for <qemu-devel@nongnu.org>; Tue, 28 Jul 2026 06:34:04 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1785245644; cv=none;
 d=google.com; s=arc-20260327;
 b=RbfK11K/KGPmuuB7fNPeEY9pcFCWF5bTzJrSqqAFFHYwgl5AbnSgepe9w92NkrEggZ
 S9P5oZdlvJTDUIzViyIde6Etw1T13tfp3cit4KJ/r44z+o4X8dZWOuNK5DKkyc6F8aPo
 rgQ6Imi6JqcFyiGi9UO+HPnhObyUysoDhDRt69QKCp+5WscDcJqBY49ci73UBhuX9A6U
 T8LKiamBZbgqSTI/aAd9nzJejIgzJlGO5LzidEA8qwp1kUVYaFVvrsSYB74vPidh37df
 7835lF1k+WnnNvkOpigob9dug7RHjsiRrQyCXNbhJDKgIOi2fK9bLCRNEjeaNZ+pF+gE
 7U3A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20260327; 
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:dkim-signature;
 bh=5DS6zvuVw2wdZM29Z2230wF0+Xa0DkLmd3WoHG/TTZQ=;
 fh=/ftcwOPYeEIhzseC7WF42kR+xVR/IJiWpLC1+A7SOWQ=;
 b=O5fYCim2TvOtNeiuVCEqAif+rPUA/9qn1lyBCW1mLSrpnGM5RTZR0eX0QsSm6q6eOh
 pgmnlNwKMy39h8Hees16PG7sOSqEBBIiQYsq668xNtL/fj8E+hE990MKkc2/iuCv/dRt
 /4cvd8buRKUR7X6vN/IQKhCIo0qHIspFKidktH3ej5O6Bn9YhspNpLAK2BIA7T53480C
 kH7u4FNMeY/F10uSxS8iyW3ZOf7ZtK7xVJDJ3YQRHz0CsE+Upa7INx7fhSEJWKZBTQqi
 Vvl9FtpmtCTlOTOGd8V0kVGxAOKd9MzCfQ3iTMKriAqjhouMZY1iGlP0LAnmaKkBkxop
 5w+g==; darn=nongnu.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1785245644; x=1785850444; darn=nongnu.org;
 h=content-type:cc:to:subject:message-id:date:from:in-reply-to
 :references:mime-version:from:to:cc:subject:date:message-id:reply-to
 :content-type; bh=5DS6zvuVw2wdZM29Z2230wF0+Xa0DkLmd3WoHG/TTZQ=;
 b=Tsfgd2CZH1LOXrqQ7cTmXcDw+XjYTPwxdy5UVCbsJjVLAeq8TRo1b5Lh4L/1qZR1TJ
 a/14aA3jpa3PoprW1LRknQx9DmO38uWgO0cUBKrX6J/C1IHTuhXNdtcX+UCOCPptidgR
 dPYVmTxCgVqwGNt0URPLxnnU+uNIZSvQBr55QJCWfrEkMnZhSfxhIXOIQqG09T4AvBlb
 4nasBG0ZN6jlYwXbYhKOdSw/RLXm9rLRzFX9izXvex4OcJgRNWa0Odw6JA6l6R5HZo0h
 ZyrW56sva34KfVjPej9ij37vvw8o2Q/M6n2kR3hN85AEjJURSqumuqTdYoyiF99y06lb
 B3yg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1785245644; x=1785850444;
 h=content-type:cc:to:subject:message-id:date:from:in-reply-to
 :references:mime-version:x-gm-gg:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to:content-type;
 bh=5DS6zvuVw2wdZM29Z2230wF0+Xa0DkLmd3WoHG/TTZQ=;
 b=JdB5sS0Bu3P6BzqblRAnkaswy6FSmaEJUaGjr9t44Ynk/SqLx+XSBYRuDn0qz8cI8d
 kHCMmTS//t54csnJi5R/zfEWCA2l054yID/7FxpMyOinCQgRIPOQPsn6A28bH10NHENN
 JrUh+tTeY2IMYm1ICepI+Mwa+hVl7Gs4x3Dm9qZaYCiOwL8ghdG4dz3+4AICKGEUqT1C
 0/0p2PKGwW1Lxus5Cn8sAI/SiP00tV4Rd+s94K9MLFJh2DRoSuT0DQhGIUydBbfM+aTY
 wMf1HVvJ56h2tFfZkcP1Fc5EPPHeMI/PDMh67T1wQHd4vZPW9LMLpXaOHJ2ZL+OrcK9G
 VkHA==
X-Gm-Message-State: AOJu0YzIaM4sREd/YLB0c2uBPKBiCnj50p0cgfxJ408PNoH1CUyCmPov
 sR4bvaNRfRQsWr2WZXgx+HZxwQEInkD0+I4LrZPFq0wvvCp50aLVLhYUZEw8yerGFs2bvN+OPaO
 2dePQNJVAeytyBoHXYVjKQzFOcav0NvOZ458tbLilAw==
X-Gm-Gg: AR+sD13LmmSwY7wBCpQzxiJWsOyU3oCL7mYIipbNWWnyx5uuvWLbSMtXQFtIxazB3MW
 YxDpvISg6ywvCO0KaBgZPZKLlFEVv1So5Fh3IDSG75nTmsrxZk3QvSic6pnJIm6VzSToxHCrCOz
 oMA3EyBskl4hMIQbV3+yZoKMVUi3c8dewpjRShL+MPi/ks9wX5sD2nDWxVQCLjLXFthOdRF7Lpx
 lf00aYRiWK647eZ6Aw2RlsEq8457LrEpHfUo4SKCNnx93ey8hBMWm2++7zqSuVv6nlgjEOxN/SN
 l/Owd/GwH1ljIbY++7cjhjoYiZp8p6vzpOXeks2dYS3n7w==
X-Received: by 2002:a05:690c:6e0e:b0:81e:c7d2:f26 with SMTP id
 00721157ae682-81f990e1022mr8192827b3.6.1785245643781; Tue, 28 Jul 2026
 06:34:03 -0700 (PDT)
MIME-Version: 1.0
References: <20260719174905.420725-1-richard.henderson@linaro.org>
 <20260719174905.420725-3-richard.henderson@linaro.org>
In-Reply-To: <20260719174905.420725-3-richard.henderson@linaro.org>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Tue, 28 Jul 2026 14:33:51 +0100
X-Gm-Features: AUfX_mws-RROaqgpSt_pWL3pGYinE7eXepv3kNogIcBtgxACIYAzLN-dN0Aymj0
Message-ID: <CAFEAcA8ytRX3C6rr0HZT38Tkq60gK_Yfqxq2j=8iRa_E=95z1A@mail.gmail.com>
Subject: Re: [PATCH 2/6] target/arm: Split zdn in do_z2z_nn and do_z2z_nn_fpst
To: Richard Henderson <richard.henderson@linaro.org>
Cc: qemu-devel@nongnu.org, qemu-arm@nongnu.org
Content-Type: text/plain; charset="UTF-8"
Received-SPF: pass client-ip=2607:f8b0:4864:20::112a;
 envelope-from=peter.maydell@linaro.org; helo=mail-yw1-x112a.google.com
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

On Sun, 19 Jul 2026 at 18:50, Richard Henderson
<richard.henderson@linaro.org> wrote:
>
> Rename from z2z to zzz to indicate zd and zn may not overlap.
> During decode, retain z2z name and duplicate the same field
> into zd and zn.
>
> Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
> ---


Reviewed-by: Peter Maydell <peter.maydell@linaro.org>

thanks
-- PMM

