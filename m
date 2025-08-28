Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1E0C9CA0EED
	for <qemu-devel@archiver.kernel.org>; Thu, 28 Aug 2025 17:32:00 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1urgFb-0001Ax-LX; Thu, 28 Aug 2025 13:17:27 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1urdVP-0001hw-U2
 for qemu-devel@nongnu.org; Thu, 28 Aug 2025 10:21:39 -0400
Received: from mail-yw1-x1134.google.com ([2607:f8b0:4864:20::1134])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1urdVF-0006Kk-0W
 for qemu-devel@nongnu.org; Thu, 28 Aug 2025 10:21:34 -0400
Received: by mail-yw1-x1134.google.com with SMTP id
 00721157ae682-71d60593000so6908417b3.3
 for <qemu-devel@nongnu.org>; Thu, 28 Aug 2025 07:21:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1756390879; x=1756995679; darn=nongnu.org;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=fRMEVrpqeSzxZ0mMzSGPBFCahy216xckP49PiuBafPQ=;
 b=pVDSRMQDpn525QZfbxEPZDemXYsptzj2XHhfuzgHROFLFAOVjMbEH00pb+3+ffOwxc
 KAqZHgREPka3Wglu2I2aEbf0e7enw24EYEuLHbcGhpfUjzEsWLGf6sdH/OPih46uWal7
 XEx0rnkyxx6loENOCmulFY1ZHa/I63yPHlPKuj52yK3CswU+YojHJ3lEn/niUrKkDwQh
 IUHpPn6EUl/q856pK4JHVBS2vke+al6tO9pS7N1rI1uFMffQeljDGoM/opaDmbdkSaBV
 kjo+g99tqwAl42SNfPojq7cKhGK5ZBoA4ppKyLy3PUywCgpAVZE0T7u04TlXYJnbOnjv
 ZM3Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1756390879; x=1756995679;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=fRMEVrpqeSzxZ0mMzSGPBFCahy216xckP49PiuBafPQ=;
 b=ZYPEk+5EUMZEC2xKWekA4kFsowirwE/X90S0cKeiraK2pEmc9pmowCm0VZWEpi66nG
 Pz86DhteMfINS7iDckGTXQH+8v70BMhAFk3FrSMXqpbwnrpQ3tk6GCsnRH4p0SjHfUOd
 vUCJPN9ix4JIrukuUebKo6unc8SByHr84HLCI97xhsEjs3fCwnwkrSCmXLAS1LHoBuVG
 RW1MLmTyb1YZC0GPJSnKwqIrN3ljefUgsbrIbkrO/FJhDVTVIx7yrJwUONQkoyWSnuN/
 ifz8TFPY8zGYQ6ofSUYjK1UvVwK6qwLnJRCWA9Tpu8llzHbhp1SQ7JAwjEy/tam/Rtyi
 lg8g==
X-Gm-Message-State: AOJu0YxoOFZQVg5KlGWO0C5vQGhcxCEJvHMrC/iMPKEyFwhMC5tn5vGS
 M9caviDvniaxEb0EXd7HbXOhTIIjckDqaaP44WUy7NqyC7Py4EWAMWNzs37z8yMYO1mlPZ9XlZq
 B6mOpb+sP7QZ0U0ii8mS6F89yFFi8/nnGldz2ZxmjNA==
X-Gm-Gg: ASbGncvi0IC7opBtHKncacf7fpOvR2i7RXvOmsX8i4uRIiFvjm9bLQxoo2vv4cU4LXq
 bzl7trY5sJHPLIvQIdDq2ZwFP7UN/IGNGgBa//Y/ZkmOjBZknsKCUDZYplG0LdMjQ3eCsKNZlPJ
 2TNPG7uzreIy2Y9TuivOWbDCRMBDYLmWSEbfX/g0U7+mhYyxRA02MmSoHl2eh/rd/iNhiELgNYv
 RzXWG/DqeUaXwUtXvI=
X-Google-Smtp-Source: AGHT+IFS6SSxk9xpUXiiksoZ37n/9f1uz8AtG/RJkIgcyTes78pE1FXCmqXIuHS3STrFZ5NJp4OwGY1PG6glBxY2sSQ=
X-Received: by 2002:a05:690c:f90:b0:721:80a:abce with SMTP id
 00721157ae682-721080ab0eamr175977057b3.9.1756390879565; Thu, 28 Aug 2025
 07:21:19 -0700 (PDT)
MIME-Version: 1.0
References: <20250828120836.195358-1-richard.henderson@linaro.org>
 <20250828120836.195358-10-richard.henderson@linaro.org>
In-Reply-To: <20250828120836.195358-10-richard.henderson@linaro.org>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Thu, 28 Aug 2025 15:21:07 +0100
X-Gm-Features: Ac12FXxD0SjdHV-fyG1vy5C2nKnjMX__E5zPBiI69FJTHTS1kNjDclHSvDIcfiY
Message-ID: <CAFEAcA9sL2czoTEc+fQ6CoHSy2-87SCZDPZg3aHeFHqa23pQZg@mail.gmail.com>
Subject: Re: [PATCH v3 09/87] linux-user/openrisc: Convert target_elf_gregset_t
 to a struct
To: Richard Henderson <richard.henderson@linaro.org>
Cc: qemu-devel@nongnu.org
Content-Type: text/plain; charset="UTF-8"
Received-SPF: pass client-ip=2607:f8b0:4864:20::1134;
 envelope-from=peter.maydell@linaro.org; helo=mail-yw1-x1134.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 T_SPF_TEMPERROR=0.01 autolearn=ham autolearn_force=no
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

On Thu, 28 Aug 2025 at 13:09, Richard Henderson
<richard.henderson@linaro.org> wrote:
>
> Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
> ---
>  linux-user/elfload.c | 16 ++++++++--------
>  1 file changed, 8 insertions(+), 8 deletions(-)

Reviewed-by: Peter Maydell <peter.maydell@linaro.org>

thanks
-- PMM

