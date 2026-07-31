Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 710EEC5516F
	for <qemu-devel@archiver.kernel.org>; Fri, 31 Jul 2026 17:35:21 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wpr8a-0000K0-GK; Fri, 31 Jul 2026 13:35:12 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1wpr8S-0000G0-9P
 for qemu-devel@nongnu.org; Fri, 31 Jul 2026 13:35:04 -0400
Received: from mail-yx1-xb12e.google.com ([2607:f8b0:4864:20::b12e])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1wpr8Q-0006JZ-Fy
 for qemu-devel@nongnu.org; Fri, 31 Jul 2026 13:35:03 -0400
Received: by mail-yx1-xb12e.google.com with SMTP id
 956f58d0204a3-668c1b780e5so1811608d50.2
 for <qemu-devel@nongnu.org>; Fri, 31 Jul 2026 10:35:00 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1785519300; cv=none;
 d=google.com; s=arc-20260327;
 b=fO7Gk+c4zJ2BmWarkplw9ZQRac6fHYxjQOkHHQbJq0HALxmCJVe5tMHzG1sjE9Oip6
 DtFmjvfUlcKYQVa73ea4bJXlwFqIXeSsI1c2AZXnnZj5l/pT1Oor+l43o3jLh9VZ6uva
 lYcA/JAhKkedM4MJRunfs/MEHPdBT7vm/FdexMwXPtMF8Gk/A+EZe3xIvCTDnwjixoqS
 5xYliZmgYblhNA6PGiPGdsPiaErD6rMyaQZvNtW6Dhp2JPA1nFrKJTpmVtNAXMiFgYs8
 TryqqrJ3oO+C8KWdmom25h9Z6o5WbLx5LoLQNqZNnRMXgMYCG0/3DwGedAOUpB0wKSZJ
 MhNg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20260327; 
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:dkim-signature;
 bh=lpGFXL4zpppFmspHMM4JCVku3tmOtHiMqL8nH00KZtI=;
 fh=/ftcwOPYeEIhzseC7WF42kR+xVR/IJiWpLC1+A7SOWQ=;
 b=aADU9PPoQ4VYd/sciUOZNTVMxObrxQzXEA5opOkz/aXCk+vFnB1hqVbGXW5mmE/xhn
 5zV6c8pcAda2CANnRNZwu8XC+boagGl7L+eTqGG0VJE+nMcGpv+fKRVQ/QJBAEw8ABr7
 qXdb9BQGIVqmQUihJ4uKZye04RljnYGSODafmg7lBQJe4JjaL/js8Jbr+9rfOAtjMsBH
 A5dlkmHFgsq/3PIzBrsPE4yCkS1OSdnPCbhsn/wL1hlfdycUxhxThuYI1ZvirR/dpRjF
 p2Urx4KD2zNVEnPGGU/aMekNHWHjcz1EtkmMHgbsNuQeG11wrYq2LENxD4HOhx7MB5U+
 iOWQ==; darn=nongnu.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1785519300; x=1786124100; darn=nongnu.org;
 h=content-type:cc:to:subject:message-id:date:from:in-reply-to
 :references:mime-version:from:to:cc:subject:date:message-id:reply-to
 :content-type; bh=lpGFXL4zpppFmspHMM4JCVku3tmOtHiMqL8nH00KZtI=;
 b=A5dJLWjQ66oi0TLYKQjv/2/nCJWbnyjcpWDXcqenQUAyw1vST/NsuHnw9fVs3RfjNI
 R7DRYIFwDehp6qxwlWGrqG77emELH7kkZAbfSMZBYlwD0Zfxx8guw4ZIDzlNWVjaPVf1
 wL/dMu58iaicOsWhkJtKpeZPHZ17nvztIpWwJ+00fNuMAqfFs0SKS1UxhF3E9+oh/+EU
 lqTS5vbLiwsNKVFcxx9ZsFWKsIpZ4VMsjOKqKbLprvC4OLt73lBChJn/l6w8bSNUAtxI
 9y4Mmjib/T2v8oK+jd9dTTakAeEixg6cwYktx4NnXgCGdGWQpnlIK1c/WiGvV627BxvY
 4wZg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1785519300; x=1786124100;
 h=content-type:cc:to:subject:message-id:date:from:in-reply-to
 :references:mime-version:x-gm-gg:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to:content-type;
 bh=lpGFXL4zpppFmspHMM4JCVku3tmOtHiMqL8nH00KZtI=;
 b=jhl0AObKcGM/Fu0tR/K+RsVinMzJIcz3RHDEzlucfLmy6LMY5Vr13xBgOx4XHaodms
 78Jbpx6a8Iq+GaeZpnpHysQnrXAYXJ8DKkFKVW2QHfHgdRFi8DUT6PCsBt4JZEz+nEdA
 viHrP5CtW9PQhxH99Mo+EMR6ukBR7n3GVqb/P3Vo8kdnIvsYFFafib1k3mrmvCroPE+r
 /2xaHEKBBmQ8bizhWc0nulY0jzVsB7SpPcjW/w3iP+TVpMw9JIIDLbewJ+OldPTHHqak
 stCI5zCkWPL+0MxfJvKZB+Bt7xErrY28RjWeJsMz/lSzi+W/i/cBGicmXTFJVQ4Wzrnz
 3BRA==
X-Gm-Message-State: AOJu0Yzib4mRtTdR3nRN1Pn7N+y34H9akWHallYIT2mNglNI8PfyQ6+o
 hF+9qzDmQMawSDy8BGkrl+3JmG+mPtHh63GE2IWPGY0lBF+3PVYH3W2kn/0Gn79T2wtck0+Wru3
 NQczC9orsATI2m0V49DiGcUPfyHtfTXvFiKs6sXMstCLPh+LAhGGL
X-Gm-Gg: AR+sD134G4OFM8Wvs4qqajcIVjUlnm7n+Z8xRM4kfR9PCRq3Ip1cUfwfVj7zStMum6q
 iPTxW7bxMTwuEg4IpG1OBrGbTQBmN9rGuopi91CHCUsav5lecdMKSGAOdBQzapvkyHlFZYmBa6L
 Woy15pw+gur1dzDRYPqsgK0tDNDsGpaqLWBV3Vpiu+5EJiGeIkMKAAOvkOiQ3VUssTSWfaWsWoO
 +FkXCiqXKjH25CexweMQeysue4NB14NhmdUFSyyu/K3AVB6omStCONjk18kefsV5lHemG8ly65J
 aUrzJvQ5R2QIUM2NjD/uaYBebrXc67PYcSUqv1j+Ms8jPnMNJxf6u44CN1C9S2X82sL99CXUb0M
 ztUAcVs8orM4GsuWZHpqsVMRPHHee
X-Received: by 2002:a53:d683:0:b0:667:bb60:78a5 with SMTP id
 956f58d0204a3-6694f26964fmr807480d50.52.1785519299978; Fri, 31 Jul 2026
 10:34:59 -0700 (PDT)
MIME-Version: 1.0
References: <20260724031123.76597-1-richard.henderson@linaro.org>
 <20260724031123.76597-3-richard.henderson@linaro.org>
In-Reply-To: <20260724031123.76597-3-richard.henderson@linaro.org>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Fri, 31 Jul 2026 18:34:46 +0100
X-Gm-Features: AUfX_mzhHTKt8XWwrt62Mo1VoM4odOPBNmu18-6VG5gyoTFs7mWf2F5IvPRgBws
Message-ID: <CAFEAcA-rG6Q=oNCw07u1pojxHF74AA1xXE6ej_u6zZeBBeHySQ@mail.gmail.com>
Subject: Re: [PATCH 2/6] target/arm: Enable writes to SCR_EL3.TID{3,5}
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

On Fri, 24 Jul 2026 at 04:12, Richard Henderson
<richard.henderson@linaro.org> wrote:
>
> Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
> ---

Reviewed-by: Peter Maydell <peter.maydell@linaro.org>

thanks
-- PMM

