Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C25FAC8303D
	for <qemu-devel@archiver.kernel.org>; Fri,  4 Jul 2025 12:59:42 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uXg0f-0001eH-Sp; Fri, 04 Jul 2025 08:59:24 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1uXg0b-0001cK-N2
 for qemu-devel@nongnu.org; Fri, 04 Jul 2025 08:59:17 -0400
Received: from mail-yb1-xb35.google.com ([2607:f8b0:4864:20::b35])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1uXg0Z-0007tx-7C
 for qemu-devel@nongnu.org; Fri, 04 Jul 2025 08:59:17 -0400
Received: by mail-yb1-xb35.google.com with SMTP id
 3f1490d57ef6-e818a572828so595123276.1
 for <qemu-devel@nongnu.org>; Fri, 04 Jul 2025 05:59:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1751633953; x=1752238753; darn=nongnu.org;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=ep8RwMJ0M9i5BPjIgEJpfQPQz9oWccG3B4OGUcUZy5A=;
 b=NjJLyuBFXmUJTj9CG9xsXIOdtdBFxGBN9JjFrGZjZyT4ak0BIAg+ruzmpU7Vzyv+kF
 VDrKmTXDBRpUShZl6YMTKFRFF3B+oMfjA3gxDKzSbotRE4m79PiMcbAvZtObDHsxlRDb
 XrM7B7pCSWQtq+qifSqRB4dL1c5x5F9ZN/FkiBMgljsM3LQwD694V4I45Bz8lpirCKgX
 VTzrMSMjDPogFmUVmGLwW6Hkbq7AYmUNnEEk4lyD/sCr/zNbYefdjAc55L3yY+T1P4HH
 hwd7a6UOsOcwWAQLMulLs/szd1ZKiWeQNwdSjFlL8k4eyFzaOGnqenDJqv7nIZ8hwbbT
 rHrw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1751633953; x=1752238753;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=ep8RwMJ0M9i5BPjIgEJpfQPQz9oWccG3B4OGUcUZy5A=;
 b=S0DciVYXaoe+LeBo4r1wcS5xQiu4Oi+RjdwhjAu2HCdoR5zLZWYTbSGpVNI92ol08J
 IY9HJp+nHALMZi5zaTAkBpzqUc+VbnsmkLTFN5KdcnIPe4l/qnWRSdbaWe/Jn5Ni+EEn
 EB3nTrq6o3T14bKhaDRjlU1F+/xDJNswCcQ8VbOorYeK6DC9Vu0AOuU6Qgx6NmWlQ7sR
 +9TW3AZsudS1YVBb6ARhMHc7+MG/mEhiug6vauQbxprbE4EfoNV6WLo2EkyY5KITfkxc
 9u4DS28ehPzNO0bHh/RQbGRzzStSBoYduEA4Y1IfyVkrms4Dhb08CtdnuGoGhIJ0CN5P
 jdiw==
X-Gm-Message-State: AOJu0Yz7lO92DqAuaAHF7i+w6tOTYRETdLtlpxqxKhD31c88gHO+VKXC
 nwdML1BH4aZ2vBFXjNmg1D6H/5VVpr6tqTTigTmUY76pSaXgFHrDYTevIIzP6IeAr99DCMO9L0z
 DsNpSGxe/rKoJJDSJyy4EA5CU/N82ImbeYfFMqrU0Ng==
X-Gm-Gg: ASbGncsrIik7g5azvvv1PwJeNHjlGExnJbMiErcp8uOu1GnEOq5Avta45A6FRDcC497
 OrX5R6Tl5GVF/vAhuBdxXsD646PnUOtLvzc6up6c+1Gee8ZAgFzCdLaYgF9U4pPcWwEEixjtv3z
 V/XlgYBTu0H7V1dVU4xIxmOHrZT1GxNkFaJ6TlAL8Ht15b
X-Google-Smtp-Source: AGHT+IGMQGviKbzldM1FzPYcyVqko0XIZR+sqNGa1ZBLIq01DsKwGHUF7OUvIKEo1097WzreNcNSIbFjOCoBu9T+V34=
X-Received: by 2002:a05:690c:6:b0:70f:6ebb:b29a with SMTP id
 00721157ae682-71668d04e88mr29643897b3.29.1751633953648; Fri, 04 Jul 2025
 05:59:13 -0700 (PDT)
MIME-Version: 1.0
References: <20250703085604.154449-1-kosasihwilliam4@gmail.com>
In-Reply-To: <20250703085604.154449-1-kosasihwilliam4@gmail.com>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Fri, 4 Jul 2025 13:59:01 +0100
X-Gm-Features: Ac12FXwSac9Laj_vHcH-p-uxJpINs0H5g3o7vcUg3xomduQF3ebXgfUpIq6Bmnw
Message-ID: <CAFEAcA97cvAmtRYEr3hD-BG=LNjoaZFAThYWNKa2zok1MOxgGA@mail.gmail.com>
Subject: Re: [PATCH v4 00/11] target/arm: Fix M-profile helper loads/stores
 alignment checks
To: William Kosasih <kosasihwilliam4@gmail.com>
Cc: qemu-devel@nongnu.org, qemu-arm@nongnu.org, 
 Richard Henderson <richard.henderson@linaro.org>
Content-Type: text/plain; charset="UTF-8"
Received-SPF: pass client-ip=2607:f8b0:4864:20::b35;
 envelope-from=peter.maydell@linaro.org; helo=mail-yb1-xb35.google.com
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

On Thu, 3 Jul 2025 at 09:56, William Kosasih <kosasihwilliam4@gmail.com> wrote:
>
> Historically, M-profile helper functions in m_helper.c and mve_helper.c
> used the unaligned cpu_*_data_ra() routines to perform guest memory
> accesses. This meant we had no way to enforce alignment constraints
> when executing helper-based loads/stores. With the addition of the
> cpu_*_mmu() APIs, we can now combine the current MMU state with MO_ALIGN
> flags to build a MemOpIdx that enforces alignment at the helper level.
>
> This patch series:
> - Replaces all calls to cpu_ld*_data_ra(), cpu_st*_data_ra()
>   in the M-profile helpers (m_helper.c) and the MVE helpers
>   (mve_helper.c) with their cpu_*_mmu() equivalents.
> - Leaves SME and SVE helper code untouched, as those extensions
>   support unaligned accesses by design.
>
> With this change, all M-profile and MVE helper-based loads and stores
> will now correctly honor their alignment requirements.
>
> Resolves: https://gitlab.com/qemu-project/qemu/-/issues/1154
> Signed-off-by: William Kosasih <kosasihwilliam4@gmail.com>

Applied to target-arm.next. Thanks for these patches!

-- PMM

