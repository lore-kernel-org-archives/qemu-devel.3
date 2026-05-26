Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7993CCD5BC8
	for <qemu-devel@archiver.kernel.org>; Tue, 26 May 2026 10:24:42 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wRoxH-0000Il-3d; Tue, 26 May 2026 06:24:11 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1wRoxG-0000I3-2L
 for qemu-devel@nongnu.org; Tue, 26 May 2026 06:24:10 -0400
Received: from mail-yx1-xb132.google.com ([2607:f8b0:4864:20::b132])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1wRoxD-0005vH-S6
 for qemu-devel@nongnu.org; Tue, 26 May 2026 06:24:09 -0400
Received: by mail-yx1-xb132.google.com with SMTP id
 956f58d0204a3-6587cee8b57so11352818d50.2
 for <qemu-devel@nongnu.org>; Tue, 26 May 2026 03:24:07 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1779791046; cv=none;
 d=google.com; s=arc-20240605;
 b=LZS6esjOL5KBP7C+CGPQjAQgKsVQQNrublVfU3nrCS2RmGGoO0BDnhstNyGb41AuNv
 N20dgEHQfoSyAutMk/8+B38irr3BWghtc2JfCXoeRdzlvqWk6bSSsSugnHc4EiNYX41h
 rP761pRpu0It5AKfjsuF95qZKZMUUAjTqq2jDQlZISl+f1xOOFuYarIhCIz8ChKj70Wk
 qxS4Nmmdz6JEC80G2jcsJqATCk5uE9zGnduC9XZ6FOIEWjk3uY4UxzvMmpJlebeLcKUB
 pbmbqiidvLPi1vPqEFk/pOPpNJYgUpTRDOtvyYRjjkkl5LVCA+Aib8PIeJZdGImVHiV7
 +9eQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20240605; 
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:dkim-signature;
 bh=34Y4pAYFvPs8YZdut3z6fQqp01RDv7dzKitJwtZEozg=;
 fh=/ftcwOPYeEIhzseC7WF42kR+xVR/IJiWpLC1+A7SOWQ=;
 b=VaBRItIpVVRK+rppGRQ3D/PdCXKfZbfpzxdnHqdyK5NrP0rnzCKuBABKpBTU9ga+Z8
 7rQfL3ThOMF/lEFbmGLJyiykKw6GNJDrU1SxaQlHzPra+75CeDz7bD4G+PyPPoN7uWw4
 7QfPUegTOsXzCa6M7FJ3Vgheuc45sMUWqb41v51iukMHetxHQv6UDyMuNdqNapoSjmzH
 0fT/m6E9daBqcPfX1eCCQNVUv65KMc13awy8Rq0sZY/RGgKwmHvifZRBkLgkp4frx+S9
 pP5brASxzmT2sMuapIhiQDP3Sj3jgk2+YTuNEbwK3m1fhYtWFoDVsbFliRAuLcNGcBV1
 sSNw==; darn=nongnu.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1779791046; x=1780395846; darn=nongnu.org;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=34Y4pAYFvPs8YZdut3z6fQqp01RDv7dzKitJwtZEozg=;
 b=mdoWuigloGYbkfxkhED2G9M74h/VpFQh8p2PQvgHlLwBbBpQRFdy9KMCx5Dq6ho8de
 87LuDt+0pw7R9lAphP7L/B0IUH5UQUwDs7GZyK7YFOO4Yw3/+qTbF+bpL/AlRNN8mQWf
 CtEeiOdaVfdDb4AX3iurAokDGJ2MKAQYVwGD1rGPUIHkd8aiefgFikeI2RtmyoCcDWdx
 s8jYbBRzq+6qHf3cwvNgQmnQdK2EHTLx6/wSCeN3OwB7IlWXWyXi+dSWyiVOPpiqSMiR
 Ein1dNBRgicu/6SGRRSgJV5dxJ9MdL4Jy3vQM8yBULhSlEpecAJ4dyOb02kU6HIZ22nM
 IgBA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1779791046; x=1780395846;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=34Y4pAYFvPs8YZdut3z6fQqp01RDv7dzKitJwtZEozg=;
 b=arQU+ozQl5VehxWtSAbxG33zN+KwrGHtq0DohwaXog6VMF6xQ/hKyEjKZgTjCG0+nE
 mdIeZjH0Cmum61hNj2T/mSWR1pGJzn5J2bIdQ/UcxliT1bW4lNql+mtZGE+FdA8hKqkg
 sIUSTzKANt+No698IJGvsA7X+ePKUFQdK3A/CwL/zQOAUqrMgJGYmKf+M3ldzskxjdXm
 NyA1U6BGasa2RjZKT6UqFrSl/K3NAtFglmQCHCICUiExfHZaHulGihhzquT7QYaLuvzW
 4pA7/xHFilhDPale3uZhoFLhtyx/4nhuyCjn/OEYif+NQUSDPWuRl6n9FzIFeD5Yum7W
 Apeg==
X-Gm-Message-State: AOJu0YxO+0QQBcoxAtGQ8uYR4bmOEyHnuRKmmHqVrEGy261AgkiiA4mT
 hUU2mEm3D+Onl7Xu/Nw1RK+JGQkteX5aDmzmyJGDCQqFZ/cn022P7JOeWjN/tBG90Cx+vbMTDNN
 QI1dMBYLsxKZVnUvDG5H5OnEZWnQQig1ZSEDATr3h3e7zaI6qRaZJ
X-Gm-Gg: Acq92OHdPTeL3UwSEDMwfKZHu37XDshBXwT4kmG0SHbVaEv0KmG7qNCP9jj1nk/iO3/
 iau9mm2bwRj+f9IOkjBSDDSoyHGZJVoJEH4/YzHvj8znZuSU5Svdni5MXK+4x3aoueVuNJ+OpA6
 EqkUKdmOTlvqmOdV2WQx+9f96nMSoGYnFoOxOJx40CgvgxeYFLjOmfRkarewfThakO7vkpxVmmd
 vBHtnsPBvIEXa6nBvmTdbOa0Fcw0oM7OFrA6U7+zHPnunO54N7rkvq2zmum1Y0gOG9ycO/slSUi
 Ndmc9QvPaAMuBc3goEnxVdOrFdhk0LRfhJVc9BAEKKSjUawnpNKrzmhtJlooIe6RP+0=
X-Received: by 2002:a53:acd0:0:10b0:65e:b074:c6f5 with SMTP id
 956f58d0204a3-65ec981e217mr14502032d50.29.1779791046580; Tue, 26 May 2026
 03:24:06 -0700 (PDT)
MIME-Version: 1.0
References: <20260522220306.235200-1-richard.henderson@linaro.org>
 <20260522220306.235200-3-richard.henderson@linaro.org>
In-Reply-To: <20260522220306.235200-3-richard.henderson@linaro.org>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Tue, 26 May 2026 11:23:54 +0100
X-Gm-Features: AVHnY4Ia7EXYE5qS6KcQhHyXzBSUAdY0TysiIstZ_kpHVTwNfqrLKXkw08uKzAQ
Message-ID: <CAFEAcA_8brxiM8tCT4-jU77bfy45e=EL=sggU+jmJ_zL+Bc5aw@mail.gmail.com>
Subject: Re: [PATCH v7 02/64] target/arm: Implement FEAT_FAMINMAX for AdvSIMD
To: Richard Henderson <richard.henderson@linaro.org>
Cc: qemu-devel@nongnu.org, qemu-arm@nongnu.org
Content-Type: text/plain; charset="UTF-8"
Received-SPF: pass client-ip=2607:f8b0:4864:20::b132;
 envelope-from=peter.maydell@linaro.org; helo=mail-yx1-xb132.google.com
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

On Fri, 22 May 2026 at 23:04, Richard Henderson
<richard.henderson@linaro.org> wrote:
>
> Signed-off-by: Richard Henderson <richard.henderson@linaro.org>

Reviewed-by: Peter Maydell <peter.maydell@linaro.org>

thanks
-- PMM

