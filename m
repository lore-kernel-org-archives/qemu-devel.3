Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D2C50CA0FED
	for <qemu-devel@archiver.kernel.org>; Tue,  9 Sep 2025 13:23:38 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uvyIk-0002FZ-BU; Tue, 09 Sep 2025 09:22:26 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1uvyIi-0002Ey-8O
 for qemu-devel@nongnu.org; Tue, 09 Sep 2025 09:22:24 -0400
Received: from mail-ed1-x536.google.com ([2a00:1450:4864:20::536])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1uvyIb-0006hs-Ks
 for qemu-devel@nongnu.org; Tue, 09 Sep 2025 09:22:23 -0400
Received: by mail-ed1-x536.google.com with SMTP id
 4fb4d7f45d1cf-620724883e6so9415246a12.2
 for <qemu-devel@nongnu.org>; Tue, 09 Sep 2025 06:22:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1757424132; x=1758028932; darn=nongnu.org;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=4TYaLpbJWh8rhq9OPhSimGa7FvXK7jqaJQsRgzRiYZU=;
 b=y/WOmvnM0ubMYCmLm6F/WIyxHDYZXekR/GVBUIbC0tiZIcQtzLCFZy6EV1EIvVJjzW
 ExfBzemrWq0/N98MxL2XCexOCT6eKJAbVdORmkhhE+ndyOiGMa7wcohi50vrh0WmEdnz
 CxSmG1BzwZe8P70GGth9tK84igwOzZwhwZHyxaLHzSbHwdy5800Fzn/9jEsyOP6ojdu9
 lmK8zicI4CPj8vHC3OtzEjxSEBgEQBp3mklJFhek6IwD643M9VWCPt/kAIh2N2Bjh3UT
 d7CRYaoWpGIamuO00H3+qrVYOluq2iGWAS8qNs7tjQ2hM+vOQ5IM80GrOBU1PqPVX8Rh
 ElRA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1757424132; x=1758028932;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=4TYaLpbJWh8rhq9OPhSimGa7FvXK7jqaJQsRgzRiYZU=;
 b=UoBADVvBzdjvuqc5BL8lxa/zMUcMZaIKvjQxVX8f84N6JZV3JlR+2iuyV80s3iw0hZ
 yibGJM0nV1vkzXLpZQVarqSLxIRyb7XzBdmSdFp39VSIO8Rx6acs8eqAxSinXrQXTvRz
 vJDkBaSJ3W8uO6LwCuEytX+Yb4e5C5zEfUt6LmmbTtvSm2lCchV2/EoZYMfMc5hZTp29
 xuWGVgbKSoa2+MhvwoV+3sRCAR0GSyKomuQmqtEKSayikaDVirE2F95akPBCYAyxSufR
 W3RS0OBX6SYGy4+flaeMMlaOr/2cI+vAd1onj8G1mU65DNtYrzAwy/lDj/d3MZAXa7t4
 ezxA==
X-Gm-Message-State: AOJu0YxY3NafKahRDFZCI9IvIrjLxE1MlArY4OCdM+zTdROoYwGsdVxW
 zWgq1EsDfxn5ZWMJ/0wr/i/oDIGotHWj4wkLt61nv9coQ/KIJ0qyKM2porvasYgHMrQPbysjK09
 vRDxX+EjDJvZ4gI/EY3p0no9EU/PeD9j+4fv4JN1glw==
X-Gm-Gg: ASbGncuEJ0vywG3mgPBLAG6EfkaxfSZOj8lRfxRIGUngvem/8Lru+av9i+SWYWxjL1O
 iRhtLepeX2lIEGVPehOCE7il7qR+46Rub5ulaD75s65+Nb2JEqgjCUiQOBVTRLITgE1X83WR4yj
 cTFgiSSjXDIDeGHXSC5czXaEeDunxMVfCiI0G8y9uP308qbj1YOT2tua3DQjS5N/pOp8X8Ldj+d
 HMFDeZd
X-Google-Smtp-Source: AGHT+IHk6xFRFA5GEOfQEfBPpUSoyyYfEnkrnzZlQXQMFL9MTsUnreLnBbuktp33tbQFqZjgyCgmd49DqWBHaCuxbhs=
X-Received: by 2002:a05:6402:4557:b0:61d:3dad:228d with SMTP id
 4fb4d7f45d1cf-6237c235cd0mr9892184a12.13.1757424131614; Tue, 09 Sep 2025
 06:22:11 -0700 (PDT)
MIME-Version: 1.0
References: <20250830054128.448363-1-richard.henderson@linaro.org>
 <20250830054128.448363-54-richard.henderson@linaro.org>
In-Reply-To: <20250830054128.448363-54-richard.henderson@linaro.org>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Tue, 9 Sep 2025 14:21:58 +0100
X-Gm-Features: AS18NWDoZ9Fv7-Ue2UU1ea_fC1MPRE_92x3kfdm6hZAv478OloazzvhbYYyfP1s
Message-ID: <CAFEAcA9QKunkHRKSHMmqdrT-_amq4JpeOnjUakjjxrQP5edtEQ@mail.gmail.com>
Subject: Re: [PATCH v4 53/84] target/arm: Split {arm,core}_user_mem_index
To: Richard Henderson <richard.henderson@linaro.org>
Cc: qemu-devel@nongnu.org, qemu-arm@nongnu.org, 
 Pierrick Bouvier <pierrick.bouvier@linaro.org>
Content-Type: text/plain; charset="UTF-8"
Received-SPF: pass client-ip=2a00:1450:4864:20::536;
 envelope-from=peter.maydell@linaro.org; helo=mail-ed1-x536.google.com
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

On Sat, 30 Aug 2025 at 17:27, Richard Henderson
<richard.henderson@linaro.org> wrote:
>
> Separate current to unpriv and arm to core mmu conversions
> into two separate functions.
>
> Reviewed-by: Pierrick Bouvier <pierrick.bouvier@linaro.org>
> Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
> ---
>  target/arm/tcg/translate-a64.c | 24 +++++++++++++++---------
>  1 file changed, 15 insertions(+), 9 deletions(-)
>
> diff --git a/target/arm/tcg/translate-a64.c b/target/arm/tcg/translate-a64.c
> index 8c73f54e9a..ca1633540f 100644
> --- a/target/arm/tcg/translate-a64.c
> +++ b/target/arm/tcg/translate-a64.c
> @@ -93,7 +93,7 @@ void a64_translate_init(void)
>  }
>
>  /*
> - * Return the core mmu_idx to use for A64 load/store insns which
> + * Return the full arm mmu_idx to use for A64 load/store insns which
>   * have a "unprivileged load/store" variant. Those insns access
>   * EL0 if executed from an EL which has control over EL0 (usually
>   * EL1) but behave like normal loads and stores if executed from
> @@ -103,7 +103,7 @@ void a64_translate_init(void)
>   *           normal encoding (in which case we will return the same
>   *           thing as get_mem_index().
>   */
> -static int get_a64_user_mem_index(DisasContext *s, bool unpriv)
> +static ARMMMUIdx arm_user_mem_index(DisasContext *s, bool unpriv)

This function is named get_a64_user_mem_index() to indicate
that it's the A64 logic, compared to get_a32_user_mem_index()
in translate.c for the A32 logic. It seems a shame to lose
the parallelism in the naming.

-- PMM

