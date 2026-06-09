Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 83740CD8CB9
	for <qemu-devel@archiver.kernel.org>; Tue,  9 Jun 2026 16:23:44 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wWzEl-0003oX-UW; Tue, 09 Jun 2026 12:23:35 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1wWzEh-0003gd-Ah
 for qemu-devel@nongnu.org; Tue, 09 Jun 2026 12:23:31 -0400
Received: from mail-ej1-x62f.google.com ([2a00:1450:4864:20::62f])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1wWzEf-0004X9-P8
 for qemu-devel@nongnu.org; Tue, 09 Jun 2026 12:23:31 -0400
Received: by mail-ej1-x62f.google.com with SMTP id
 a640c23a62f3a-bec3f69d343so859419566b.0
 for <qemu-devel@nongnu.org>; Tue, 09 Jun 2026 09:23:29 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1781022208; cv=none;
 d=google.com; s=arc-20240605;
 b=RoHm0uohv6VaYtB4Zlgf9gwyjxQPAUtEVTCztl+x8EltPzfo0dga/sXrENWf0Aya9f
 v/FgvRX5nA18g+rNdTVlnBiAdx8FnCfC/tAs9dyq9wGKR2XXXfUeCBGZGlIHrqInGXep
 NLwgr80WubpKLhRpcd9z6TMeNYqt6lWXUguFjQAxVwk15et3VR2kUp/1M8GMdTNBPy2W
 39njErpaLwUy8Ej5iaQJAycdlRqKo2Df9JPd9cVObSjsizUxgm7WPmN5p3B6TN2NelnZ
 iYCjveFE0fIGtmzBzXJ3lGu7SZiOn8NWb/PWCG5LQxIfbQ1TgpgpJGFmurYF9ksqG/qa
 y1Eg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20240605; 
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:dkim-signature;
 bh=SxiYm5raegKEbr4MLYobMfLonVsnFECSi8isGZ2K6E8=;
 fh=/ftcwOPYeEIhzseC7WF42kR+xVR/IJiWpLC1+A7SOWQ=;
 b=H7oPl8RNOPPE7W/6LVKZCxGQwPHk33fMgPDK842+HJpZKSJCX+lmOrNtxBXaib1pqI
 MGibXNSxi/YlQ+ZKwt+PkjeePHtyrCnCY4/nfpEoenBO0+L4loHXrMsvVUR5LuDAmSat
 Ieu9PYNsg/gg7nRV6xkItFI4jbTWIrmu08RGRxgfkQX4oZxTmG4apmfchTd/wOZv0Luy
 TpWw3z/cFHfyBEjvDGH2DJxXh839yF12ojT61jOTejSYYEa30H2yr5e0tBlrHWz/FKDW
 JZXeRso7TwVXDrUj2rM24dL8CyUTq7IHB4pOT7iAyrY8Aws7+GaG+kz6DLcvGFrIjl2U
 QKDA==; darn=nongnu.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1781022208; x=1781627008; darn=nongnu.org;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=SxiYm5raegKEbr4MLYobMfLonVsnFECSi8isGZ2K6E8=;
 b=KDhn1p/90F6PdOGBWBPhqTlvkuMO5I3EJsRQnmqiFxyFktbKfVgwl4EJIiI/QBwYiM
 Uj4lGumKa+SbFFGoBF2hQVM98kuhqSR/DsWR/eUnpud36pcNvNmqlnhHe/C/0ho5jJPE
 RtzOd8iE/WA5FVRNDO/O4eFjCtcFYDuz+EuYoqfX40JJpAJwkP1t9/+ZUJZEEgRxHC9p
 3atlgP2pB23Z8xeJIzDsWDo4w3vuvt4OYhIMrBm68JGWKivx89hgTAsylobhoC7MfKic
 QR9bhjEzvHx7O4OffXHP7nFXYwXSeWiTMMelGx/BrnzpQ1u/93182BaZIaeGpe0YipHi
 nQfA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1781022208; x=1781627008;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=SxiYm5raegKEbr4MLYobMfLonVsnFECSi8isGZ2K6E8=;
 b=YUsAWVLfF4WdUvIcH0yr27C+QOtLuCVqAUNldmQCzoqaoUnisMzFiDJFHIDl/dSfIs
 ug+xtbjEBkR5eh8XGoQzXcVObVfPKFqZqnJLvF9S5QO+VMnHlUMJLcJfZ6v66xwlI9k8
 x6xop+2xUVRq3OfdQVlWhBw6nL0aoz1A48xxPSYaXDvhUiOVgjZFpIH7dZMGk4iYOCJY
 cCX7y2YTyge34WCHjeFqDZHokmnzNDSo9TKHSA3Snn4sUNa+fhRmkwsGQdkNzFygsoAV
 OWtaSs/3tpwFEsBTs0RMMiMj/BBWhF2lVNVZc0ZSRBQoNHxdTbsgpqaGQyzMpFQb46/I
 my1g==
X-Gm-Message-State: AOJu0YyJvmBPvv/gtAWdoFcAFReygkASCHN8MTXQuzv1BhaGGeVBEbD7
 DAdt44YK2tC+8LakivqoH+AO32oHhnCqBH6nyjazvic0MTdo81yjsNqiVVzFdF4NFBd4+L40DU/
 xFp+MgptkbGy+98ejmC8azjUWEU3VXDfQTur6vtSDUg==
X-Gm-Gg: Acq92OExpZzNvTR/H3oWUc3WP3FhuZvOgIeBnIdxIVxLEfn0N7P9aANtPL6lVZ7FxfZ
 GxUZZQu+Pz2EowXe4/+KPjrBhSr6R+DeSBiqQgnNgb9O+KZp+Zl2vH21c3xu4VuT6FmKipWPbyC
 zDhI6p7A34lERII8koRX0kD/JkgdSBedmkfF6R+nBJrtkSYkp4+s/+1bzHwrQ/C4oRuPoCEv7KY
 AdrTkoa3oHbSBfdRCp9+aW+wruwct0+Pz9u+mb/grxtpgncqWo8OKG60nmsbmjPOVVs/cB2T/e3
 Xw+bpeas3qeNb8lkHLYoH6257aZ+B+D75a7Bdvtiw78QXgEtX3Pkf6++jHbDwJa2FH3D7pYCKy1
 Big==
X-Received: by 2002:a17:907:986:b0:bee:c13f:7ec0 with SMTP id
 a640c23a62f3a-bf370180feamr1028239766b.8.1781022207629; Tue, 09 Jun 2026
 09:23:27 -0700 (PDT)
MIME-Version: 1.0
References: <20260603032855.106930-1-richard.henderson@linaro.org>
 <20260603032855.106930-44-richard.henderson@linaro.org>
In-Reply-To: <20260603032855.106930-44-richard.henderson@linaro.org>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Tue, 9 Jun 2026 17:23:13 +0100
X-Gm-Features: AVVi8Ceae9djzM7oAORLhHlHX6Qhio10ibmiMJa21M7KKWTshm0u9Ct5Da9nLNg
Message-ID: <CAFEAcA_i3mPpv32u7T2YxUiZTU8sjN+pPp4BTomHA02PNvu-HA@mail.gmail.com>
Subject: Re: [PATCH v9 43/45] target/arm: Implement FMMLA (FP8 to FP16) for
 AdvSIMD
To: Richard Henderson <richard.henderson@linaro.org>
Cc: qemu-devel@nongnu.org, qemu-arm@nongnu.org
Content-Type: text/plain; charset="UTF-8"
Received-SPF: pass client-ip=2a00:1450:4864:20::62f;
 envelope-from=peter.maydell@linaro.org; helo=mail-ej1-x62f.google.com
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

On Wed, 3 Jun 2026 at 04:33, Richard Henderson
<richard.henderson@linaro.org> wrote:
>
> Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
> ---
>  target/arm/cpu-features.h        |  5 +++++
>  target/arm/tcg/helper-fp8-defs.h |  1 +
>  target/arm/tcg/fp8_helper.c      | 25 +++++++++++++++++++++++++
>  target/arm/tcg/translate-a64.c   |  1 +
>  target/arm/tcg/a64.decode        |  1 +
>  5 files changed, 33 insertions(+)
>

Reviewed-by: Peter Maydell <peter.maydell@linaro.org>

thanks
-- PMM

