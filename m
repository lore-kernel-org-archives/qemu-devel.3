Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8FD2EC531F9
	for <qemu-devel@archiver.kernel.org>; Tue, 28 Jul 2026 16:22:33 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wokZP-0001dq-8L; Tue, 28 Jul 2026 12:22:19 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1wokZO-0001dG-7R
 for qemu-devel@nongnu.org; Tue, 28 Jul 2026 12:22:18 -0400
Received: from mail-yx1-xb12e.google.com ([2607:f8b0:4864:20::b12e])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1wokZM-0002de-Th
 for qemu-devel@nongnu.org; Tue, 28 Jul 2026 12:22:17 -0400
Received: by mail-yx1-xb12e.google.com with SMTP id
 956f58d0204a3-6611669cd16so5388232d50.0
 for <qemu-devel@nongnu.org>; Tue, 28 Jul 2026 09:22:16 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1785255736; cv=none;
 d=google.com; s=arc-20260327;
 b=DS6dLdJDAR1BKyLB/SdFgEasD2lZ1HfMmE5pLxb+2K/z9BMwFCfL9EHJkXEfovbGDs
 Gq2hxv2nCktC64dzWeKhFUDhabSVpskeSzcUsazN5t95gS41li2LxAzHOs2J2tur46rK
 L0yldVigo5SPUxRm5bRbUyD+fYCnckkoE2vRZd0YdDOgonPM12WWUdpE3O1WK96AQSn5
 kWfyAWUF6SBg2HnTFHY79cbGFJGZiCOcfRXnkff9WoFg6LYlz+zXc0F0xovM0kejwPD/
 NDaELN/xFzwyxAIEEW7yugwzMm/B2Ib+BgqQpo7x/t2fnrgQjagNveo70U8bA7uIIEtK
 7Jnw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20260327; 
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:dkim-signature;
 bh=VR1Lb87bVmmYvhXItynZeV41l0KJ6/d0FMR5njUAFtA=;
 fh=/ftcwOPYeEIhzseC7WF42kR+xVR/IJiWpLC1+A7SOWQ=;
 b=YPZF3jWWTEdxQQSB8ND8cvJkHTloVt+5hpKoEsOnOK8AdC5lVUOSjBCPIQPAa5tjU1
 39ZTv2A5Ndc58FRQCTese29voQjQ5bWo5+i5lwihYRVqiLBxKvCYJ/Cj1/05sGB9DcHR
 lpY2c1N+6M3hZVFq4DTjgJUKBYK1AlXuVVdKRr1+xEvdrZBEtX7uy+2ECFuJU305ZdOI
 S1T8auFHFxnZ55oYXB6ZAaudEWbVFLWE+herynVuGAASOaOp2vLPCBdE/+VQhvqAS9Bb
 hCJnbzX8e+s8zV12ueJNO9aGAcQzZMj1d2jb5hLqly4G1Tk9N+m9TYGv8dug6b1IPhIl
 Lbdg==; darn=nongnu.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1785255736; x=1785860536; darn=nongnu.org;
 h=content-type:cc:to:subject:message-id:date:from:in-reply-to
 :references:mime-version:from:to:cc:subject:date:message-id:reply-to
 :content-type; bh=VR1Lb87bVmmYvhXItynZeV41l0KJ6/d0FMR5njUAFtA=;
 b=ruLnAJ5kZrYehBjpGWIZcno7w1OlXZgMdKIPFKfW96/pB/KxjVv67qzYo9k0FoQ3yS
 s+sOthnFCF52TzJY4Jrj+MZjcbVAo0cKjmOJKwP7AAM/igodl1GyOWT4yN51aB+rC7Zy
 42xqlqHzsC8SYnfefx8+j/oeykC+m73glXEW+t32h3BdgfQYvdzszp1AbdtDHs6V98lx
 gGk1w2cYjH3AXL/OVaxSECVNZdicRbpGPcc7aaxb6Qs4Hoh45YMMJwTOuu6l79vnVMDT
 zIVbbrMcwQsHYv5sLg/OcUc9aob4GAlFchF8fQtNC+f1LyBOb5QD29NuJ9a1M43sEFBn
 zq0A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1785255736; x=1785860536;
 h=content-type:cc:to:subject:message-id:date:from:in-reply-to
 :references:mime-version:x-gm-gg:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to:content-type;
 bh=VR1Lb87bVmmYvhXItynZeV41l0KJ6/d0FMR5njUAFtA=;
 b=WmGfE5clWfX7RMarmrq2KIGg7/xWxzAI+5NCYjsECBGdNO2bQUn9VYfAbECw31D+6q
 4jjVyqeX9qNyEZ1VtDBkG/ZM1BQnxI0LOlHCBvebDrcWpJVsQXC2/GPD8cVGHEZgmnVY
 IxD8o1W9RCkcSomMyaPtS5egdD5JDDL8ySC4wfRCJ7hot/WU1zhshXMlFE1sQCER8E6h
 +czQKTYCXGMe6pITHeZigU3/jBmGiiYkSEne5DPEDTm0ETtIdl/9dw/RGQRFYa6DWMix
 v2MbP36bZhWkAur6uwerrMXA6R7ShIblGW1+DHmCBPtQ9DNwvHpUDry4Sk79jSNoUgk6
 1yAw==
X-Gm-Message-State: AOJu0YxvtK8cwoEmZBRGV7lDD5/fY+5W1EODGtcJ4thv+CD5fQpRatpm
 dq3zPuODpoNjLFOQ3zwUm/7gq8nWAcAhwI5jtD2h/x9y72FM5Z+xduFYkrF42tLt/JpFPHn+ZwZ
 OmBLe3/ZZbFte6WbrtRunIbzw8ARqsxr7nuGMGldchA==
X-Gm-Gg: AR+sD11+3vr7d0A6iuZa637GvCms2oq5/6jY8Zi2FhHhPBzZiXF4zei7+ZeyMzq5or+
 beDfze238nRpBeKjmGzwEy7PUdQH8szSFsz0Dft8uKMitJNTGqmnKpL/n8PtFiGfiYkQXAegsh4
 xsgGq4BFUuGKfGtJ7E7XcWEp0cRNH6cHd/mximao5DgDr+1Towr3dRKmc1il//P93FXcMa92jX8
 mBYlP+QCMX1LPhLOrf4FUB1JX8yA+3vCDCuen959Wu3/EZ2rywck6DBF/1FhWlgbAfi05yErhNE
 idNl772owvBLH27j33nkIq3qxUQiqdipGqUF+PTH+4A3CGPJJxfrGJH7S/fYn/tCvNjTdhQXYp2
 9hGcAQr8O/KeVvJpEKBf78a3iQ+3R
X-Received: by 2002:a05:690e:4847:b0:665:1fb0:5546 with SMTP id
 956f58d0204a3-669056d0ce6mr1007042d50.29.1785255735822; Tue, 28 Jul 2026
 09:22:15 -0700 (PDT)
MIME-Version: 1.0
References: <20260721184656.530230-1-richard.henderson@linaro.org>
 <20260721184656.530230-19-richard.henderson@linaro.org>
In-Reply-To: <20260721184656.530230-19-richard.henderson@linaro.org>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Tue, 28 Jul 2026 17:22:04 +0100
X-Gm-Features: AUfX_mykGddhOaQWeon_t-OaFxjS_WzqJISVoCT1Bbefl3zJxeWueEkNm9nDhtA
Message-ID: <CAFEAcA9jO4nCMCzEB_gJJYoJGihzmDJYOzKsdOMMQDfeKPSXQw@mail.gmail.com>
Subject: Re: [PATCH 18/20] target/arm: Implement AESDIMC
To: Richard Henderson <richard.henderson@linaro.org>
Cc: qemu-devel@nongnu.org, qemu-arm@nongnu.org
Content-Type: text/plain; charset="UTF-8"
Received-SPF: pass client-ip=2607:f8b0:4864:20::b12e;
 envelope-from=peter.maydell@linaro.org; helo=mail-yx1-xb12e.google.com
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

On Tue, 21 Jul 2026 at 19:50, Richard Henderson
<richard.henderson@linaro.org> wrote:
>
> Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
> ---
>  target/arm/tcg/helper-defs.h   |  1 +
>  target/arm/tcg/crypto_helper.c | 31 +++++++++++++++++++++++++++++++
>  target/arm/tcg/translate-sve.c |  2 ++
>  target/arm/tcg/sve.decode      |  3 +++
>  4 files changed, 37 insertions(+)

Reviewed-by: Peter Maydell <peter.maydell@linaro.org>

thanks
-- PMM

