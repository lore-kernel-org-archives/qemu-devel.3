Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id F365DCCF2D6
	for <qemu-devel@archiver.kernel.org>; Mon, 19 Oct 2026 10:02:23 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xIkBY-0008JD-97; Mon, 19 Oct 2026 06:01:40 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1xIkBX-0008Ig-8c
 for qemu-devel@nongnu.org; Mon, 19 Oct 2026 06:01:39 -0400
Received: from mail-yw1-x112f.google.com ([2607:f8b0:4864:20::112f])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1xIkBV-0006ag-7h
 for qemu-devel@nongnu.org; Mon, 19 Oct 2026 06:01:38 -0400
Received: by mail-yw1-x112f.google.com with SMTP id
 00721157ae682-8b0c5a64de8so21944077b3.0
 for <qemu-devel@nongnu.org>; Mon, 19 Oct 2026 03:01:36 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1792404096; cv=none;
 d=google.com; s=arc-20260327;
 b=G/p4TsUTDUa6iGX4aAIWQ5xqZlBfqT4gCYIMd/ttSQYBidbTVtT//hD4SzQe6zi+SO
 rrrGGupYV7HHWo+E0KKc2WO5vOAh9AA0PFjaDeHyGdDwi12ymuDwL5xNqeHJHFwKsIzU
 whBUp6J2uTdFyTpAnCDeZEQUdhYXzKt7TcfkFHqgeTS3mpIk/p9GK8keb+4BDDJwdkBa
 jEck3YJEsFs0u0/sTqZgM+tPze8v9gsqzhc0qkggi53sylX/t1oQzJMzjESsX6CwRBGQ
 FD/5VOLaoxyDLt30wB0rUd9pR5n8Nn4m5EKIfGJW2Vtiw47V53gp3sxp2lLf4H4W7Vyz
 lx7w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20260327; 
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:dkim-signature;
 bh=4xAsyGg8IhtuWbgNPNz8kypMHgYRyH3jOtBC8Us4qGE=;
 fh=VobgdUTDMXxTWFH3vLKklrMlZpjVSYbJzaQz6wiyAVI=;
 b=JoZpuHJWfZyJ1lhgPfWoyT44209/QKfsExE/GwSzYu7MyHRG0WANuS59IgltjkCQUM
 ET86RvI4PlShU7uekjchdlzRedjFt7Jylnd7yiGDhJ1ufTbY/gJHJajvfyF7U5TkGpOR
 mafcx09BxifLETWmRYSFt2k6KC5g41BGcsKKOIfzs3rS7Ns/Z9X2gim1W++dOIQunRyN
 4sCNU+UvxJa0SOySltE6CyH3i/muXkTlo1cR5eB3LzEwaWcYyEnxJJxS1hzt4Czva0Go
 YaEeXl8/58qSOTJAod0qca4wKgrN6+oyNzMKCPqxbpKoGucAraVepnIMuSN26YsK/FsV
 he0w==; darn=nongnu.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1792404096; x=1793008896; darn=nongnu.org;
 h=content-type:cc:to:subject:message-id:date:from:in-reply-to
 :references:mime-version:from:to:cc:subject:date:message-id:reply-to
 :content-type; bh=4xAsyGg8IhtuWbgNPNz8kypMHgYRyH3jOtBC8Us4qGE=;
 b=Vp62O8mucIHa+zEUoA4PjUpcg6VgOJMcao7zDJ29/46rgH7U8FQpF9qmP3m0vg1GZO
 MOAKQOivfP2tcl8J8nI0+qnEJrH+ObWmLczt6nviD5ksTDNausHsfHRQWHuSmJLBJ7Go
 5YV7Xp1Co0b783VzV+KIb67Kwdp8AdXJeV6Qj5DzJgCbkNMu1RWE6SYFlMz0f7Vflx2c
 u0UQ7UBkzNAcZ5NjfiskGLK+rn3qgwFa4hS2fzhWLdF+IHZwrzyoo8TgQaeXXIBmfC+k
 ZfxOw5xbIg8Pza2/xqiX20AqwXCvNBMA8otGqH2V8uT3c4HaursTl+nT6dFuDuWs49f0
 IaKg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1792404096; x=1793008896;
 h=content-type:cc:to:subject:message-id:date:from:in-reply-to
 :references:mime-version:x-gm-gg:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to:content-type;
 bh=4xAsyGg8IhtuWbgNPNz8kypMHgYRyH3jOtBC8Us4qGE=;
 b=kY2UomdK+DXs3dAkHkWxvVinTC6c2VnEHZhuRW3/GsZ5T31gBRAIF/n/NHwSeaBMAd
 bduAoRViOFISmXHZ52LeOMQjBd620JdXvuQHT1fq+wHoYI51fwSZv6CxHWBUEWJGkwKu
 RfwDLkaICwkJxIrG9LTZdCvjxg7dGbfXFHFz9rq1R1X0O3L/5vdyxefTx0ggW5BKThHI
 Joepx1/nMRw7FXKyeGP40Ox7QGwWt8JLDggP95nDXP4QYoKizyQdMFqLYwK4aMCrbahV
 b/0ntMS5n97O6Oxh96oZJNASUZ9rIcTsNuXkFVQFHAXMk/qPSShklWWOEBaqRsEl4z/2
 +zYg==
X-Gm-Message-State: AFq9FYIVqyZW0l2PZCsVjYSHJNCROGFT9J+jPGetQV5qwK3VrU8WY1z/
 tX5G+CJSLbGH6oKyNinEGCYP0K5dshePOsXfY14QVQM3+gQjM2inRYIULrpnqTEXb5dbpMPRh7M
 UWVA7oXE2ISMwmHGfw+DthsgSY8j8gj5DdhmzWbT/sA==
X-Gm-Gg: AYBFou11k6/3CZOztl6LHQ/ZIPUc4GulPpU/G+l3jhG7yOh3l1mQGwa/vBa9FVtkpq9
 1z3Q5MLSnvPx0q8hBJ3eveerS3pQmPyMlsqk2SE45g+iRZ513//kjN4/vcTTWFN+EZfZzCr9JWy
 QjruwJeYucexyQWf9iopb1c3jmfAhjGSXs3dPJOuVuEGDSWYHcNkibk23H1rLnD4Wbxp4I9elis
 eZoETxz58zJuQuuzFbCwT6+VZ6yT4TVEOdNidVG4otq9+4RE3A9S13LTzeh0sBu9C05ouitCRjr
 M4mbqLZKnR/D/8aeMucvmRaWArRMCpkN8/3wHj07k46MGQ9ufXyNKpUiziUwI1+hneObb/W3+oH
 6WNnKnnpEIBMEi7uiQEsDU/JCPytSb9YO51eshF8=
X-Received: by 2002:a05:690c:4902:b0:8a9:8744:c07d with SMTP id
 00721157ae682-8b0e2dbee67mr34300267b3.18.1792404090738; Mon, 19 Oct 2026
 03:01:30 -0700 (PDT)
MIME-Version: 1.0
References: <20261012041722.1159355-1-brian.cain@oss.qualcomm.com>
 <20261012041722.1159355-16-brian.cain@oss.qualcomm.com>
In-Reply-To: <20261012041722.1159355-16-brian.cain@oss.qualcomm.com>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Mon, 19 Oct 2026 11:01:19 +0100
X-Gm-Features: AclHuK-sdybCidZbw8Oa_07Td5CTQA9VeN02-9ox7upEL36wBe5672GvGKask_s
Message-ID: <CAFEAcA_WJ-PYCfiiu44uTQiDoc58_9Ky3uEd-9g14nPgDPT__g@mail.gmail.com>
Subject: Re: [PULL 15/25] target/hexagon: add the QFloat logic
To: Brian Cain <brian.cain@oss.qualcomm.com>
Cc: qemu-devel@nongnu.org, richard.henderson@linaro.org, 
 Marco Liebel <marco.liebel@oss.qualcomm.com>, 
 Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>
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

On Mon, 12 Oct 2026 at 05:17, Brian Cain <brian.cain@oss.qualcomm.com> wrote:
>
> Add routines to handle QFloat/HVX floating point values.
>
> Also: add documentation to describe the feature.
>
> Reviewed-by: Marco Liebel <marco.liebel@oss.qualcomm.com>
> Signed-off-by: Brian Cain <brian.cain@oss.qualcomm.com>

> +/*
> + * Return the legacy rounded significand numerator.  The result is N where
> + * the rounded value is normally N * 2^-(frac + 1).  `half` selects the
> + * legacy arm which uses N * 2^-(frac + 2) and increments the exponent.
> + */
> +static int64_t legacy_round_n(FloatParts64 parts, int exp, int frac, int adj,
> +                              bool midpoint, bool *half)

Hi; Coverity complains about a possible undefined behaviour
in this function (CID 1688240):

> +{
> +    int shift = 65 + exp - parts.exp - frac + adj;
> +    uint64_t mask, low, threshold;
> +    int64_t base;
> +
> +    g_assert(parts.cls == float_class_normal);
> +    if (shift >= 64) {
> +        return parts.sign ? -1 : 1;
> +    }
> +    if (shift <= 0) {
> +        uint64_t magnitude = parts.frac << -shift;
> +        int64_t value = parts.sign ? -(int64_t)magnitude : magnitude;
> +
> +        return value;
> +    }

These checks mean that shift is in [1..63]...

> +
> +    mask = (UINT64_C(1) << shift) - 1;
> +    if (parts.sign) {
> +        uint64_t twos = -parts.frac;
> +
> +        low = twos & mask;
> +        base = -(int64_t)((parts.frac + mask) >> shift) * 4;
> +    } else {
> +        low = parts.frac & mask;
> +        base = (parts.frac >> shift) * 4;
> +    }
> +
> +    if (midpoint) {
> +        threshold = UINT64_C(3) << (shift - 3);

...but in this code path we implicitly assume that shift is
at least 3.

If this is a "can't happen because the caller guarantees to
pass us arguments that don't get here" case it would be
helpful to assert and document why in a comment.

> +        if (low <= threshold) {
> +            return base + 1;
> +        }
> +        threshold = UINT64_C(5) << (shift - 3);
> +        if (low <= threshold) {
> +            *half = true;
> +            return base + 2;
> +        }
> +    } else {
> +        threshold = UINT64_C(1) << (shift - 1);
> +        if (low <= threshold) {
> +            return base + 1;
> +        }
> +    }
> +    return base + 3;
> +}

thanks
-- PMM

