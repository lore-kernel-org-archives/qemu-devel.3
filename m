Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8543CCCD18D
	for <qemu-devel@archiver.kernel.org>; Mon, 13 Oct 2025 13:35:59 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1v8IiE-0004w8-OG; Mon, 13 Oct 2025 09:35:42 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1v8IiD-0004vC-7m
 for qemu-devel@nongnu.org; Mon, 13 Oct 2025 09:35:41 -0400
Received: from mail-yx1-xb136.google.com ([2607:f8b0:4864:20::b136])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1v8Ii9-0006LB-Ag
 for qemu-devel@nongnu.org; Mon, 13 Oct 2025 09:35:40 -0400
Received: by mail-yx1-xb136.google.com with SMTP id
 956f58d0204a3-63470a6f339so4096586d50.0
 for <qemu-devel@nongnu.org>; Mon, 13 Oct 2025 06:35:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1760362534; x=1760967334; darn=nongnu.org;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=BbGPzHO4D2+JbEkVm+sHzPDR4Z5KWXP3eIew5Y6DeQI=;
 b=t1b+Iq7P2X4a/ImQhpxv0ni1j8e/ffqD7qqzTu1CIIxzloANVrO/ar/AWiWBLpdbsb
 7UwRMnz0trXNi/Mzo3cxutzTD312YfKeyOaJSpUgDA0jqDr/I2rKiiYmumthDyVyJWXW
 Z3bMtNinMCAzFoemACWhGEUFR/Re+1vg6ZS3hLEqovcNA8p+tw1x+6OO5AsLLZqtzx/Q
 DohkimgQVXJ8TtVpyZ5AOG/OYs586TO6Z2hOz2npAzmF34YLqvY1kf2BEXTepreXbHgN
 /QYjdHBLrL2gm4sTi925cc2Z3UE+qKyOA1SG8fblEv71g62qbHf7v1Ta/izHZNJjixrk
 W8Sw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1760362534; x=1760967334;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=BbGPzHO4D2+JbEkVm+sHzPDR4Z5KWXP3eIew5Y6DeQI=;
 b=TvM5bA2OdB073rHmv6udkwG4ANFCmqbm9HIpkd1wLknwWy6lSO92V0cpErPwUhuoNU
 O9j3qucNz0aaalDeEv2fe0ifKyBa20nPs6O6B3knsTytLjGjirEbpJnIR0/MEmRzwG20
 ETHlT0CBfESUG2CMt38/IPmIc1XuNkq39PrF5Jjmzm/s00Ipc/dCmcDjEQYG+3hNdVMz
 nMMEjcPjMGw060EA9hMmFeiIKK/D8XGPhxfuWy/Y7YgH8XIdO1InLxNQ4vnz4vaLXZRb
 DUDMZXc3eQGsloWKHKmYYp9G9apupxJRqp5cy9tVBNqBpaoTha9osobU4Jr/aP5L0wnZ
 qrGg==
X-Gm-Message-State: AOJu0YxzITJJQYWS0dwMt5lYUq1uWOS+A5VTorNjWmhof0N/1dcQHGVi
 rNNf8Gz+b8GOyNgWblRhSe6jx5WqPi3yzqGl/Pl/BO5CsCTJ3dOVQC5Z56H//WXyhZkTiNv81Nl
 KRx2eUHywhAQACwgH15tIRVLM6awTdIJ3FLNyVtW2bQ==
X-Gm-Gg: ASbGncv4uAKwwVcrK46cL8fC5XYqq4Umcyfu/e11tlxJRnhY47TVxYI8tCzYrDgnkVv
 KVlfVMozkaPsJvuVPL9oUKpHxjb9I/D4XUY7bZ6iMGvHolnWx/Q9jYwIxrV/moSpIBU7uQ1/syL
 CpvjQwK75c8ZNop/swkM/qt76GsrA/cJ9YUCnkCobBImiSTzXpDs1Ypp4s+JFJyhRubLyBkVj4b
 IUPKd01nREm4p+gnJTdNqMnWb/ZkT8=
X-Google-Smtp-Source: AGHT+IHTOsARVZqb37VE0phudY4MW1lSyw3KxCAjhJvK4vggJm6E5BXrxTG7UZQyM+vOnKPVJWaoMDejNOEUjwpfZi4=
X-Received: by 2002:a05:690c:316:b0:721:6b2e:a08a with SMTP id
 00721157ae682-780e16d29f5mr347191427b3.37.1760362533826; Mon, 13 Oct 2025
 06:35:33 -0700 (PDT)
MIME-Version: 1.0
References: <20251010201917.685716-1-richard.henderson@linaro.org>
 <20251010201917.685716-2-richard.henderson@linaro.org>
In-Reply-To: <20251010201917.685716-2-richard.henderson@linaro.org>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Mon, 13 Oct 2025 14:35:22 +0100
X-Gm-Features: AS18NWC8mj_KiNvpg0_UFwT8VB_z802EXIg5h-ZtywS2vElYbowxv29q16aPwqs
Message-ID: <CAFEAcA_CmQ2w0Waa6K_vOPjibGhcE5oUG3GrhaC5r1t2-QXgYg@mail.gmail.com>
Subject: Re: [PATCH 1/7] target/arm: Add isar feature test for FEAT_AIE
To: Richard Henderson <richard.henderson@linaro.org>
Cc: qemu-devel@nongnu.org, qemu-arm@nongnu.org
Content-Type: text/plain; charset="UTF-8"
Received-SPF: pass client-ip=2607:f8b0:4864:20::b136;
 envelope-from=peter.maydell@linaro.org; helo=mail-yx1-xb136.google.com
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

On Fri, 10 Oct 2025 at 21:19, Richard Henderson
<richard.henderson@linaro.org> wrote:
>
> Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
> ---
>  target/arm/cpu-features.h | 5 +++++
>  1 file changed, 5 insertions(+)
>
> diff --git a/target/arm/cpu-features.h b/target/arm/cpu-features.h
> index 37f1eca3af..579fa8f8f4 100644
> --- a/target/arm/cpu-features.h
> +++ b/target/arm/cpu-features.h
> @@ -1364,6 +1364,11 @@ static inline bool isar_feature_aa64_s2pie(const ARMISARegisters *id)
>      return FIELD_EX64_IDREG(id, ID_AA64MMFR3, S2PIE) != 0;
>  }
>
> +static inline bool isar_feature_aa64_aie(const ARMISARegisters *id)
> +{
> +    return FIELD_EX64_IDREG(id, ID_AA64MMFR3, AIE) != 0;
> +}
> +
>  static inline bool isar_feature_aa64_mec(const ARMISARegisters *id)
>  {
>      return FIELD_EX64_IDREG(id, ID_AA64MMFR3, MEC) != 0;
> --
> 2.43.0
>

Reviewed-by: Peter Maydell <peter.maydell@linaro.org>

thanks
-- PMM

