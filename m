Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9351BCD8CA7
	for <qemu-devel@archiver.kernel.org>; Tue,  9 Jun 2026 09:38:01 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wWstY-0002j6-I0; Tue, 09 Jun 2026 05:37:16 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1wWstR-0002i8-Ak
 for qemu-devel@nongnu.org; Tue, 09 Jun 2026 05:37:09 -0400
Received: from mail-yx1-xb130.google.com ([2607:f8b0:4864:20::b130])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1wWstN-0007Rm-56
 for qemu-devel@nongnu.org; Tue, 09 Jun 2026 05:37:08 -0400
Received: by mail-yx1-xb130.google.com with SMTP id
 956f58d0204a3-66039d3efcbso5409877d50.2
 for <qemu-devel@nongnu.org>; Tue, 09 Jun 2026 02:37:04 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1780997823; cv=none;
 d=google.com; s=arc-20240605;
 b=BpoCsM4QR+GjVeimJ4CrYnu928oIqZr0mZ1j6+zdVd0S3RWmBetyqrD7F3kAH4c75i
 wnf1EUa4YihbK7KRPER+J8ZvzfJmzqw1Qu1H+FrYSHgktGz+JUz291uhO07hqcTd3+P5
 NclJw0jJb9vIk0QMQPZFz5IX63qa4pUK6oYn2foKtN09h45NirnDxw+OtaN12VVvKtRz
 u/mVkFlW3FDYAQJYPe0ZaFIETaxJmJppusPeqcbMITlCIo0ULjGsq7LDxckUzi9ojS1p
 3n2KlFov3yK/Lilpurd5vUkykVS9iM2KaI2ut1Jcgrl9V687hXuia4b2uUgt/4PVJTWe
 JXzA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20240605; 
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:dkim-signature;
 bh=s+0BfXHM21QnV4863C6uImYyGFFQDfVOWFUWijIqoLk=;
 fh=/ftcwOPYeEIhzseC7WF42kR+xVR/IJiWpLC1+A7SOWQ=;
 b=PsYwuHwYhtEj3+b8AtF7OIBunJYGdJErwyarrPliu4my0To/FpJ2iTNxjoc8z4LeeF
 snpzkwKDu8SIFR3bUJtfvps8U5uT0WhQ3UI735wT8IJpkeizblOseVNNE2SaFd3EaIXs
 mVIYovs/I4MRRfoJscznXIKPxuy81SXD9H37YDGm5mbl4GXFfkk9Q6rTnLIgIPiprRB7
 EY18+PxX9UUOlc66m4HpVDi+zdL0BivqEMaXY2OWAGK48OlLVBI25DAjmOvwN8Krq2pS
 tuGmbXqPT2Vj/iI3aZcudv31u2/SBAiwEnttJtExe4u2/tAmWgkl9BcE8r1f6/pAWlPN
 qShg==; darn=nongnu.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1780997823; x=1781602623; darn=nongnu.org;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=s+0BfXHM21QnV4863C6uImYyGFFQDfVOWFUWijIqoLk=;
 b=QoL0og2/TVaIRv7pChTKVkmdpChH1X9REQ/KbsKKcuPwKALDG8G5lemF1CCbz9y2cd
 C/RI0wKqFhf/mfVqY4+/iLJvCdbLPkzeahjNEUCGgJwVnEFNutKVKKvcRhXAKGWNOOba
 vlSIUnuSEcGfyid4d7TYNlDqjvznBWcbzkgP16yeHdnT3nZSL3fsiQPc/OAcJF0eVN+z
 g+B6XTxXklKQFTei/6x9L+mKjvNtfpAQgRHuQMa7ETKtp5Vz5aQxJ9t5+t/zZ8QxmldQ
 Uhr3zYvwhD7ThXIzMLwIGWxZV5Tv5UMKNh/dmi0QqioHkxwpty7xKFtMU8OfsAqQq3I5
 68SQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1780997823; x=1781602623;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=s+0BfXHM21QnV4863C6uImYyGFFQDfVOWFUWijIqoLk=;
 b=qDW03YgzvXFF3/nbeXCAdXn99pmOFuuerBUKeC/2RTZEeu1ZV5NPSppA4fa+Mw04Ot
 kWDqJGZy50AvFeBKQUbvxH1Bk0NnUsEfMxCA+oNmMKk7wVs7/tUtjIZBZp0Yrhcv7Yr8
 EHjS2KuzQYkz76EGp47KNlqnFkPkv6rRcu2M5N7M9c6b/VogbdjuKm7K/yadZ61+94x5
 fhUvST+t5CN8Xcl/+qD/LkXjGmsPTtVU03F7zR8utau1tLFN81j99S3ztMeJxUvw1A3/
 aX4Zq+xMcFDrD6ki97M+pJoywXyCriO8rjYL90uzxhqBjK2ql0zw9juoxpXkQe2LBVyk
 vekQ==
X-Gm-Message-State: AOJu0YxNZaq5IChyV8PQoPjXOsYjLjihqGTIlJ47pwAk6BdPu5JU/lSp
 hHEK9JBLouC4BxAh9K4yH3xL3qvEcwNVvYyINKjEtacBmMwuYPChmdR/wTulcRnlP42yU3DBDJj
 yeZl6H1kngwWg9YdRWbvCxrO7fv1LlixAamJ0TqXIMzgAcO3D7o3H
X-Gm-Gg: Acq92OFa/jJegAMtN6TjIoCViPnamJNRTmhDmwC1yx1fiRv4U/xHZ/hUxtEBaXkzBHB
 Adb/HKkY3glhjnL8zH2ICP/IXvaQnewBnL+QZjCCNquk/QB9TVPK27RZHYR3H50gADS1QRNLJ7O
 D3EQMTaY3CF/7ig8gIvSgewWz9IP0+ssEWvIdRQYsprGSZpQVMwwnj6wuKhuslfhA5x5agI94cj
 D/Yx+H3VWOJRf6XDDGP5bLCB82y/sWNVjVs7fibxaRw7+lV8hac+zUjraWmauCrssfj5GnjysrH
 nnvmuh1N2yMdgF0NfxE4nZwaRF5anzF2o6OFbk34qnmXBIFLK3XRThiYfzI+aOwjGiDzVRDz/1L
 Xxg==
X-Received: by 2002:a05:690e:1762:b0:656:ad2e:9907 with SMTP id
 956f58d0204a3-66106f56450mr13771501d50.41.1780997823455; Tue, 09 Jun 2026
 02:37:03 -0700 (PDT)
MIME-Version: 1.0
References: <20260603032855.106930-1-richard.henderson@linaro.org>
 <20260603032855.106930-27-richard.henderson@linaro.org>
In-Reply-To: <20260603032855.106930-27-richard.henderson@linaro.org>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Tue, 9 Jun 2026 10:36:52 +0100
X-Gm-Features: AVVi8CdPcPU6FiiIyB-180ACkYuxcLT3XLwgrHQaxdiQ8vvI1i4p17Yqw6_I2lQ
Message-ID: <CAFEAcA-vzc2YgqJhKvbANafBT6NNChekJ30VTH7QJ+4gQX0j8g@mail.gmail.com>
Subject: Re: [PATCH v9 26/45] target/arm: Implement MOVT (vector to table)
To: Richard Henderson <richard.henderson@linaro.org>
Cc: qemu-devel@nongnu.org, qemu-arm@nongnu.org
Content-Type: text/plain; charset="UTF-8"
Received-SPF: pass client-ip=2607:f8b0:4864:20::b130;
 envelope-from=peter.maydell@linaro.org; helo=mail-yx1-xb130.google.com
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

On Wed, 3 Jun 2026 at 04:30, Richard Henderson
<richard.henderson@linaro.org> wrote:
>
> Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
> ---

Reviewed-by: Peter Maydell <peter.maydell@linaro.org>

thanks
-- PMM

