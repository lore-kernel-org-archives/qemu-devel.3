Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 01C42CCD195
	for <qemu-devel@archiver.kernel.org>; Fri, 17 Oct 2025 13:21:40 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1v9kG5-00083b-Op; Fri, 17 Oct 2025 09:12:37 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1v9kFk-0007dR-IH
 for qemu-devel@nongnu.org; Fri, 17 Oct 2025 09:12:19 -0400
Received: from mail-yx1-xb12f.google.com ([2607:f8b0:4864:20::b12f])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1v9kFe-0005Kg-U2
 for qemu-devel@nongnu.org; Fri, 17 Oct 2025 09:12:16 -0400
Received: by mail-yx1-xb12f.google.com with SMTP id
 956f58d0204a3-63cf0df1abbso2119225d50.2
 for <qemu-devel@nongnu.org>; Fri, 17 Oct 2025 06:12:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1760706724; x=1761311524; darn=nongnu.org;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=D9xlQoRZeoR1UXPG1KXCkxosrjIsVdx7ZL3Vee6w0bQ=;
 b=O8TSKDSFEPC/bvWpl8qTUxz+E4ytuEkolgACQzUlU6dlLNVQERpX1B+LAUU33nedK+
 wMUOYnL7T44Zp8JOuakoHmd25T8RyfN0HzXsXR2TACUxOLQdoaf8JgwSjyoGTXzhc2o0
 UIETbzJJ+q4XMRd7NuO+XwCb7JyfBuy1Nm1thMUKIndv062dQkvMCD8ZGafCTra9YAZO
 E3haM7c2BZ/3w0jVfNeQHoAyl+4GPEWrxk9BLtqvd25Lv8ERheirRjTg2TO39bFK3vT7
 pghoUBlioLGH75KC5NtS/8MOkJQvBeHqZBa1HXKgUVqGlJSAth0K6GFHlOkyE2GPp+FA
 UDyw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1760706724; x=1761311524;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=D9xlQoRZeoR1UXPG1KXCkxosrjIsVdx7ZL3Vee6w0bQ=;
 b=P9L+GSWmZcNAmzmi5fVLqZwZEkIb5sTrFsryyMPGla9K5kwenO8afkNl16t8KhUKCN
 6e6ZKvLmePsecLNfO1UA9PacTh01u92ukvRzDsB9BdbgJlO0OaRqIuZNbatS4ivFV4GP
 YfW8JdwWxRJGmaSOaAFUy0chVi7Rkk92idlCjQ4Iej+1H99j9qIugjvOuh9naNMgvbCh
 KhkZ6+t1TlRpiOHA4H0cvmp8nhtDZuYB3PUPZJeyYMqH1or6GpzmtCsIMBuVVCq69E9V
 uU57pOo0gU7MJx9HKANnAkCcn1lSj8TV6STD/tDHCRBZZPbz2hw1PyM24obFk9c73sqE
 nYHw==
X-Gm-Message-State: AOJu0Yx11FkmgRPeYkTXoWe+qEsXBYm5Ni2iKef2zmshJtf4eNgmMpyG
 ttLnGzjbEqIJaWl7ho6WR74/TsLxmLanolAdeabglEEPd7250EVK3AyDTeM6sRfqFL9pL0Tf4aH
 xu5K+jb6DdWOwX3rgn40hcmEJesnOdbtZVu2gZXIY8Q==
X-Gm-Gg: ASbGncvuMYLPS3nMWfUn/EmfW9mKYaeeKeZzVig/E7PIpzl6smdZHVBztIaCpNtknZ/
 gtYIzKmUxYEROiERxePYyEhWg4XUzw9GeE0AVMC0ZB3v+2SLkFMWvK5HOdm583uZbfDPB8aajUG
 Wj8xXWChZo1Wp34rWEpwBLe1tatCgbJ0+2kE6NR6VsZHxo/zFrJ9OvHDR9PCSo6MG2gV3NFUoYh
 iWO23A/ZCk5FX9j8MLpxwNzvsm4kEAXe2+EyEi/kLTie17zEF6DgWM32IDct3F+DANv8i7m4lSU
 SsAlpF0=
X-Google-Smtp-Source: AGHT+IHj32EUe0DPXTrJw6gc1fccEkjFc08onpntnLN/ztdEO8OXcqaA+W0DC0ZIrICEFzGm47HEc5FCcdzBd9pzo/s=
X-Received: by 2002:a05:690e:4192:b0:636:1b01:63df with SMTP id
 956f58d0204a3-63e16168e5emr3252986d50.14.1760706724375; Fri, 17 Oct 2025
 06:12:04 -0700 (PDT)
MIME-Version: 1.0
References: <20251014200718.422022-1-richard.henderson@linaro.org>
 <20251014200718.422022-8-richard.henderson@linaro.org>
In-Reply-To: <20251014200718.422022-8-richard.henderson@linaro.org>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Fri, 17 Oct 2025 14:11:51 +0100
X-Gm-Features: AS18NWBjL6FzFSgT8OsWQa2THimdmBQGVf5uXcNEKR8NsFgWUidraGP6nLrsSMg
Message-ID: <CAFEAcA-OoeSq9iOrtf_23-x8tZBCyZJ2wQ2ckrYo6tY8e2w9FQ@mail.gmail.com>
Subject: Re: [PATCH v2 07/37] target/arm: Add read_raw_cp_reg128,
 write_raw_cp_reg128
To: Richard Henderson <richard.henderson@linaro.org>
Cc: qemu-devel@nongnu.org, qemu-arm@nongnu.org
Content-Type: text/plain; charset="UTF-8"
Received-SPF: pass client-ip=2607:f8b0:4864:20::b12f;
 envelope-from=peter.maydell@linaro.org; helo=mail-yx1-xb12f.google.com
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

On Tue, 14 Oct 2025 at 21:12, Richard Henderson
<richard.henderson@linaro.org> wrote:
>
> Add the functions and update raw_accessors_invalid to match.
> Add assertions for !ARM_CP_128BIT in read_raw_cp_reg and
> write_raw_cp_reg.
>

> +__attribute__((unused))
> +static void write_raw_cp_reg128(CPUARMState *env, const ARMCPRegInfo *ri,
> +                                Int128 v)

Why does this one take an Int128 rather than a lo/hi pair?

> +{
> +    uint64_t lo = int128_getlo(v);
> +    uint64_t hi = int128_gethi(v);
> +
> +    assert(ri->type & ARM_CP_128BIT);
> +    if (ri->raw_write128fn) {
> +        ri->raw_write128fn(env, ri, lo, hi);
> +    } else if (ri->write128fn) {
> +        ri->write128fn(env, ri, lo, hi);
> +    } else {
> +        raw_write128(env, ri, lo, hi);
> +    }
> +}

thanks
-- PMM

