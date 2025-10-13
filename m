Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9BB93CCD18D
	for <qemu-devel@archiver.kernel.org>; Mon, 13 Oct 2025 13:45:15 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1v8Ir0-0004G6-IW; Mon, 13 Oct 2025 09:44:46 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1v8Iqy-0004Em-J9
 for qemu-devel@nongnu.org; Mon, 13 Oct 2025 09:44:44 -0400
Received: from mail-yx1-xb12c.google.com ([2607:f8b0:4864:20::b12c])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1v8Iqw-0007Ka-HE
 for qemu-devel@nongnu.org; Mon, 13 Oct 2025 09:44:44 -0400
Received: by mail-yx1-xb12c.google.com with SMTP id
 956f58d0204a3-635fde9cd06so4337481d50.0
 for <qemu-devel@nongnu.org>; Mon, 13 Oct 2025 06:44:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1760363080; x=1760967880; darn=nongnu.org;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=lYlDaqGkSPIhQvE48PP9/3xCKe4hnwWSv1ls4SqIL0o=;
 b=cxMXvvlLtElnvA/mJj0L3lhxPmB/agsjSoIAWZtJiVKl02yviLUfsNoRx66g3RkOb+
 oPxGaVHbixNbF8y6fTc6AfriLcMA4FlFJUW7FoalCvLn0jNd/dFEMZDIf0GtrnczteD2
 DeoYC7cKx4rQADOxBG1QFzfsLG0FbNAnasNxZmwLQeyGnGSfkBCbhHrI7HkXIkEWoXWB
 2TAJ/Uq+HzZ8D4N3hX4M0RTfpiQIPxvc1Itm86g9FND3/o2VYXzjkyfxAg/ktXZxIsFI
 36g61I3iFVhdvKOWblreV1P+DIWNnyO/NcKTo4siPayBFlNkuTQi4NtIG4cdbHNALRO2
 tfIg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1760363080; x=1760967880;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=lYlDaqGkSPIhQvE48PP9/3xCKe4hnwWSv1ls4SqIL0o=;
 b=g9rdnbO4fMv+5CwdFe5+H8Q3rI3tMQwSlHej1V/skWOkjauxFeEvezPQZoZOyCGiEQ
 9lDAasZKqvke+8OzXkuMQMZm2jtmtwP6uYRRx14Dedcwg0ZvevOodGc5nsS0TSA3EjmU
 +BI7xLpwB07NMiaH36KV7RGnH9saN0bE+Cq4s4OaLtLSnKKjEY92GQY+peXJ9lhYoBFo
 PvIZlUCHuIEyMJ+N3AwLdVICljuG08KhiJE+EF7BxAVWqtG8xJJmZhIw78Bf4yE3Vi39
 hidmDXdsA0rD+u1zrLsMcCYiNTNr4vJ5NKicvFtTvxXu3xfys/Hhzol/WhpJATwJaesm
 daIA==
X-Gm-Message-State: AOJu0YyBMYbfPm4Zr8ZEopbteFYCinC+lWAvvbb04nOYF7QtFeYJu4kB
 JWxtafRLcWewLQ2fnj11M1z02wbUWWqa/UglEWlMb3Y4QtgyTL8wHu1OTjFc6756GPi/XitCDrr
 6Zx86J/+pUhOK1gC9qN68THxx8MGtr/HEXF+/NSNhVhFQISdz4Cq8
X-Gm-Gg: ASbGnctB/CqDg2Gkg99Sqe5h3IPv8xRc0KmQv9RwNIA0UvlVugbfQHtI4w5486elGNF
 whjMwFE5QzazGGmItQ9W7UcGr9aHtYF5Jlp7J44ClWuOtQRXlDgohDDlkg9ks5CVeUU2Mo5qnSJ
 Vxmu9yglaTgVMD55sNqJ+3JCOkB3hkk1UMoqdDDel9ecIqE1Zz873dnj8X/4GAHSu8+WAHJN2xh
 sABz4GVdhPwNAkSYIJlqxiVV3xHZx51J9UcGnhwLA==
X-Google-Smtp-Source: AGHT+IHGYCU+c6krGir17pJ4xMAlHuf4CFSdND9P5PawGmnWccPfCqPE0j8nTezrAsauTCE03k7IqF2Wsl2L2XKCc2Q=
X-Received: by 2002:a05:690e:2501:20b0:63c:ea9d:7437 with SMTP id
 956f58d0204a3-63cea9d7868mr10120174d50.31.1760363080400; Mon, 13 Oct 2025
 06:44:40 -0700 (PDT)
MIME-Version: 1.0
References: <20251010201917.685716-1-richard.henderson@linaro.org>
 <20251010201917.685716-8-richard.henderson@linaro.org>
In-Reply-To: <20251010201917.685716-8-richard.henderson@linaro.org>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Mon, 13 Oct 2025 14:44:26 +0100
X-Gm-Features: AS18NWArVHYMa-tnUG8-dBkzEGMf05SqivFMpyVzQOpDhl-xQRLltUzoSYe7P6c
Message-ID: <CAFEAcA-1ShkSaGkj=L7DghVzpJFGS==Oty4isPL9NxYLhiz_Lg@mail.gmail.com>
Subject: Re: [PATCH 7/7] target/arm: Enable FEAT_AIE for -cpu max
To: Richard Henderson <richard.henderson@linaro.org>
Cc: qemu-devel@nongnu.org, qemu-arm@nongnu.org
Content-Type: text/plain; charset="UTF-8"
Received-SPF: pass client-ip=2607:f8b0:4864:20::b12c;
 envelope-from=peter.maydell@linaro.org; helo=mail-yx1-xb12c.google.com
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

On Fri, 10 Oct 2025 at 21:20, Richard Henderson
<richard.henderson@linaro.org> wrote:
>
> Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
> ---
>  target/arm/tcg/cpu64.c        | 1 +
>  docs/system/arm/emulation.rst | 1 +
>  2 files changed, 2 insertions(+)
>

Reviewed-by: Peter Maydell <peter.maydell@linaro.org>

thanks
-- PMM

