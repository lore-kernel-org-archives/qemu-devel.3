Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 382F5CCA476
	for <qemu-devel@archiver.kernel.org>; Tue,  7 Oct 2025 14:34:43 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1v68k4-00031F-Ph; Tue, 07 Oct 2025 10:32:43 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1v68jn-0002o6-3g
 for qemu-devel@nongnu.org; Tue, 07 Oct 2025 10:32:25 -0400
Received: from mail-yw1-x112f.google.com ([2607:f8b0:4864:20::112f])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1v68jh-0005Qr-8h
 for qemu-devel@nongnu.org; Tue, 07 Oct 2025 10:32:22 -0400
Received: by mail-yw1-x112f.google.com with SMTP id
 00721157ae682-71d60528734so69627817b3.2
 for <qemu-devel@nongnu.org>; Tue, 07 Oct 2025 07:32:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1759847529; x=1760452329; darn=nongnu.org;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=sKOA9E9hfsHXu+quxVOiSehpvkuENVfLjD63D2OSoOc=;
 b=SLebCTzO3gP/ntA3Abkwy2DSa+XjlxtQbSNRnfOzJLhOuvWQne85it+Ackw021VT9l
 ZaGGaGybXDORib08rJMBaFMraZxoSJnVwH4+/Un9sxwjuIU8BLycXuojWFEL8FebiqMb
 I3QeAt4JEW+FdFNEC2Zi9jw4gIdGYwIaPxzhSIcnuP39A6LkIjRZNhpQYQqwVBwaNUHm
 YsrH1PkOMBYc05ZxIIeIpGRr3Z/ViLVKXpPj5ubX2fwd7yeCnz+UElq2jwZIvSN0atpa
 mYtoEhCxUXdonFzyrUJVD4ehY424NS2m6yAOZH3/fBu5QmjGt9lK3FyGJUacWnCBuV+W
 eeNw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1759847529; x=1760452329;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=sKOA9E9hfsHXu+quxVOiSehpvkuENVfLjD63D2OSoOc=;
 b=XiaSN/05PTrwpl//xp7hnwOS/iaAmp2oLkyvjZJwvJQSCMy49VnRUOCGFMSE1aT//i
 WdAu3ElUr4oV5pZ4H2UYu5ucBxEnkqpzyEZGJwDmx9sGx24VaoWx5orZTjJO2lWbQgMl
 SpZSQ1VeNeomuikK0qYJ1nblt1mgDxksZ8DkrzrSqtHkf6HuHNsBSbr7I724wQgwjCfj
 OyhWaw7fRlCLrOVGNdHOEOaWO5wJgTqxwy7MQjWH1emPe9fjArFawtPGwN2ZtEsk09D0
 yx1stbXGFUGpzltk3qpknjUxHuoypQfgnLh7Pzt0i6RkU+8rTSh328DgTgE5phv+DJqR
 LZ7w==
X-Gm-Message-State: AOJu0YypW4xT64YDWVpIN53HmMZrxivq6WNEjVTE7vHhJsOHs0tS8HcB
 ozCldBc6qYnyT9F6iWFTmg03HFeqjzi6ZKxLciPj1lWgCbLC3kIupZsoTOXts12Q93SBAUkQc/b
 858K1a7QHCPbPnnmYTiYuUHkNSd4DOthqCAHbfGPq0g==
X-Gm-Gg: ASbGncsu/H5Gjjr3hsVzBISc4Arq8vPV8ELV5h88z34Q2Mazi/hwwURl6iy3UF5WPYf
 6r7/kNLtnIzlz8MnbVB7AbJNrGWBgR2tREtl8955Z/eBi9SQ0bKKwsnBS4ivMYEyzysxvISfPos
 bdTHmTXwt9gB3fTr60pCSCwR3DU4JXmndPBTKU9o2ncY52vBAcz2Fys9gtMMppTbIqWQX0hfoMu
 gpxUfwFqtR8PvB3sT9/qpY38f9NcSYxpW+C
X-Google-Smtp-Source: AGHT+IF8d+SIM/kQ/TIW3zZsRUsKDEZ99kI4w91DmjgsNbZXSq3LbOK+2QxCcVWETpWY4xSS7wt2fIOJiVYejmVQyRM=
X-Received: by 2002:a05:690e:441:b0:635:4ece:240c with SMTP id
 956f58d0204a3-63b9a0f33a9mr14036083d50.44.1759847528613; Tue, 07 Oct 2025
 07:32:08 -0700 (PDT)
MIME-Version: 1.0
References: <20251006001018.219756-1-gustavo.romero@linaro.org>
 <20251006001018.219756-2-gustavo.romero@linaro.org>
In-Reply-To: <20251006001018.219756-2-gustavo.romero@linaro.org>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Tue, 7 Oct 2025 15:31:57 +0100
X-Gm-Features: AS18NWDBgJ0OoOhhuY0ttbt-awJv4OFLDnAztx3cvUk8zvtt8DvQkpPbPrnO7EQ
Message-ID: <CAFEAcA9Z4sw382fV9iKLMBpCF4O02q5=OiJtUKJtpkcy5GvMbw@mail.gmail.com>
Subject: Re: [PATCH v10 1/3] target/arm: Add a cpreg flag to indicate no trap
 in NV
To: Gustavo Romero <gustavo.romero@linaro.org>
Cc: qemu-devel@nongnu.org, qemu-arm@nongnu.org, richard.henderson@linaro.org, 
 alex.bennee@linaro.org
Content-Type: text/plain; charset="UTF-8"
Received-SPF: pass client-ip=2607:f8b0:4864:20::112f;
 envelope-from=peter.maydell@linaro.org; helo=mail-yw1-x112f.google.com
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

On Mon, 6 Oct 2025 at 01:10, Gustavo Romero <gustavo.romero@linaro.org> wrote:
>
> Add a new flag, ARM_CP_NV_NO_TRAP, to indicate that a CP register, even
> though it has opc1 == 4 or 5, does not trap when nested virtualization
> is enabled (FEAT_NV/FEAT_NV2).
>
> Signed-off-by: Gustavo Romero <gustavo.romero@linaro.org>
> ---
>  target/arm/cpregs.h | 11 ++++++++---
>  1 file changed, 8 insertions(+), 3 deletions(-)
>
> diff --git a/target/arm/cpregs.h b/target/arm/cpregs.h
> index 57fde5f57a..abee72c9bf 100644
> --- a/target/arm/cpregs.h
> +++ b/target/arm/cpregs.h
> @@ -136,6 +136,7 @@ enum {
>       * identically to the normal one, other than FGT trapping handling.)
>       */
>      ARM_CP_ADD_TLBI_NXS          = 1 << 21,

We should have a comment here documenting the flag:

/*
 * Flag: even though this sysreg has opc1 == 4 or 5, it
 * should not trap to EL2 when HCR_EL2.NV is set.
 */

> +    ARM_CP_NV_NO_TRAP            = 1 << 22,
>  };
>
>  /*
> @@ -1158,10 +1159,14 @@ static inline bool arm_cpreg_traps_in_nv(const ARMCPRegInfo *ri)
>       *
>       * In particular, note that the released sysreg XML defines that
>       * the FEAT_MEC sysregs and instructions do not follow this FEAT_NV
> -     * trapping rule, so we will need to add an ARM_CP_* flag to indicate
> -     * "register does not trap on NV" to handle those if/when we implement
> -     * FEAT_MEC.
> +     * trapping rule, so a register flagged as ARM_CP_NV_NO_TRAP indicates
> +     * the register does not trap on NV even if opc1 == 4 or 5.

FEAT_MEC is in the Arm ARM now, so we can drop the reference
to the sysreg XML while we're touching this comment:

    In particular, note that the FEAT_MEC sysregs and instructions
    are exceptions to this trapping rule, so they are marked as
    ARM_CP_NV_NO_TRAP to indicate that they should not be trapped
    to EL2.

>       */
> +
> +    if (ri->type & ARM_CP_NV_NO_TRAP) {
> +        return false;
> +    }
> +
>      return ri->opc1 == 4 || ri->opc1 == 5;
>  }

Code changes look good.

thanks
-- PMM

