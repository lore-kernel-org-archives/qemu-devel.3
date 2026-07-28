Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 90373C53219
	for <qemu-devel@archiver.kernel.org>; Tue, 28 Jul 2026 13:05:06 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wohUR-0004w3-P8; Tue, 28 Jul 2026 09:04:59 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1wohUK-0004uL-DZ
 for qemu-devel@nongnu.org; Tue, 28 Jul 2026 09:04:53 -0400
Received: from mail-yx1-xb130.google.com ([2607:f8b0:4864:20::b130])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1wohUI-0000gq-Me
 for qemu-devel@nongnu.org; Tue, 28 Jul 2026 09:04:51 -0400
Received: by mail-yx1-xb130.google.com with SMTP id
 956f58d0204a3-6689f36ae56so5217282d50.3
 for <qemu-devel@nongnu.org>; Tue, 28 Jul 2026 06:04:50 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1785243889; cv=none;
 d=google.com; s=arc-20260327;
 b=sdoLWPWb+6u399OkSpL6SW4eoGnQlh/FYntaDOqmSVrwjqXCdkOVrzq9iMUHU0G3ae
 IDgetBoQVoNYMKFJ4J0vTgFV0VwIomcNP0g8j+Y52bmkBiHLCzSvpgz6OMFLSeF9EAnu
 nrjronVA2bsu1iDWqHe4CSVkKARxXdz55owfg4t37bYkDJlOQAjoOnWBCSX7Qf4g51LN
 eIYhgStybKe3lXo1RCiF5ID9pr8sUHEsmVDNZ7JhTfXY62IO1STGfpWituqcLhWMMZyd
 l55JQCHqEo+97rGZynlAtH/APOWZzVv4okcfIKfl82GNVGAAnvdPRxUw5h3nfi41cgSY
 XErA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20260327; 
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:dkim-signature;
 bh=FQjgVTqecAYkIiqQU66qEDM2WlzndazYrbBiIlOiJ2w=;
 fh=/ftcwOPYeEIhzseC7WF42kR+xVR/IJiWpLC1+A7SOWQ=;
 b=WupOI4w+wuN1aXICrMBbA8ogfvgZ+sWmQ3pjvZWV4eCSM9Iy22fJvEPeEgNmGOhpas
 JeMN5/DypTG7xSeHPmAqGZ81TG3fTAOctvfmOx21vG425y3SPMCfC2wnMZ+lxlCr0qb0
 7+T+WsO1TnzI6M+uIPr79FqQ5SKFqGJ2C0JuM2bEya5EYSNm6e04w6rwfPaEY5I74rq7
 6FzWaK/sPYzTcCWiBhG60ynrQnCFc3JhGohrZT20uSLbUsnPelis9shlX+DJdK7IKu2+
 T55dCpzRcjyZzq/PBhiiUS4gOOzHJQ989WDB66M9MXPlfCuqFSzDfUjLvKkgxMtN0XZz
 4QVA==; darn=nongnu.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1785243889; x=1785848689; darn=nongnu.org;
 h=content-type:cc:to:subject:message-id:date:from:in-reply-to
 :references:mime-version:from:to:cc:subject:date:message-id:reply-to
 :content-type; bh=FQjgVTqecAYkIiqQU66qEDM2WlzndazYrbBiIlOiJ2w=;
 b=YcryKPxQvL4v2N52F2qzunvHhKiP2DW3v1J+64/C1clerL55dWjtNZCZdb8GsLa8cr
 A5Q4BZp2K7yt67mNIK/lSSDIFJ8miBJbcJU9Ii6Oov0yquFqq5Tap61mlAE4M2DHRJLI
 p1E45A+CXbRQWcKBzJYqAXMyc0z/tRVvJSQBoDJpSn+0b0n4V7MA7avygjFUqzG4UEvs
 vcY2VMZet7ufsRg38TLlKqvD9aCRSx3IO3rX/WUEFCO18JGXSJxteJuuMC+C7H6v+FUf
 GpX7DM6MZFf6mcpEkknrGVCFMdgNCs0zdvKlCSCqyqwqBNIr5u9YA5VcbG9apuuAMbIw
 xu5w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1785243889; x=1785848689;
 h=content-type:cc:to:subject:message-id:date:from:in-reply-to
 :references:mime-version:x-gm-gg:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to:content-type;
 bh=FQjgVTqecAYkIiqQU66qEDM2WlzndazYrbBiIlOiJ2w=;
 b=j58ljgG6n4Mykct57ZyShMizllc7asH4IeOwSwmhzu0QwWHQCoiUO988J2Kz4Pbd7t
 TwZuNI0gCaZoESj9iD917WyLmL5uP8l5tLg7oNTOlE1OiPi+j9OaF32qb77jVsFWlCof
 v4PxYu0JRX28eFnqRBZeMIRt+umtu/Mrng45+1jC5PI0IiIiBrjuwTcBdFNhgGlWdGYL
 CuwvrolOjHMtWbAvaEGlLltP6ZJ80Uwg8sbIVGj6uIn47YyhjVs54d3Ythcy1rtYFI+k
 DlLM4I7mzVxUn0fs2c1OO92dB52hsIU1SH3Z1tXUah48XRy1lAtc4VE59eA2iIyb00hz
 L1sg==
X-Gm-Message-State: AOJu0Yz2dr3t664+vLbyMJkBMf2sR7HCyY3RZQhLEROxaGvQFVbdfkSu
 K62uAo/vG1dJ2CZBxojOABfEtje0NWSzKWxNGFnEt15+dnWybgCB0GLy8VOEK5W3zV39n+DjUKo
 YtdlSLfJCNhwSMUfQ6fwxeS+TrryYk+z/fKxcsargoiwkZYI6gyCM
X-Gm-Gg: AR+sD11q9/dZj+e3q6G/sF9bH2SdEEupLt9VBUAH7HcvMMNQEKYNtcfb8qlxFDR6G83
 08oypPhgBCmgyE5E7ulTBwZf6uSGcdD8jEpEMOl91onpBfKDlREQ7tnUOK4WgoZKq1mXXptQxfL
 aa9daawMdbuiMpFBgElnLs6HX9Ann0rK72N45fsznOD8ly/EtBT7hT3zdDHs2yJJlAOE4WPsiqA
 lvpXwxcq62Cq/GF673I7HQR5OlJDnMqPOq5nulKtV1QvR5CwZ45OS4dnmW9OTzrZ/UaV8Tpy5XW
 5oladYSYac9P7DptvGUGXjh/7y5+zLkZEGImI+ALH+2XpA==
X-Received: by 2002:a53:d0c5:0:b0:667:8b90:2e60 with SMTP id
 956f58d0204a3-6690586c8e9mr510029d50.108.1785243889506; Tue, 28 Jul 2026
 06:04:49 -0700 (PDT)
MIME-Version: 1.0
References: <20260713230244.70174-1-richard.henderson@linaro.org>
 <20260713230244.70174-4-richard.henderson@linaro.org>
In-Reply-To: <20260713230244.70174-4-richard.henderson@linaro.org>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Tue, 28 Jul 2026 14:04:38 +0100
X-Gm-Features: AUfX_mxPZRu_v4146gWIWohdaxfFrkqRcMObn2f4qDcT2NWvncY5-0KjoDX-Owg
Message-ID: <CAFEAcA-GsMFQxd70i+mcybHaqPTxPTYhPCcH=6Saypygafu4Eg@mail.gmail.com>
Subject: Re: [PATCH 03/10] target/arm: Implement BFTMOPA (non-widening)
To: Richard Henderson <richard.henderson@linaro.org>
Cc: qemu-devel@nongnu.org, qemu-arm@nongnu.org
Content-Type: text/plain; charset="UTF-8"
Received-SPF: pass client-ip=2607:f8b0:4864:20::b130;
 envelope-from=peter.maydell@linaro.org; helo=mail-yx1-xb130.google.com
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

On Tue, 14 Jul 2026 at 00:04, Richard Henderson
<richard.henderson@linaro.org> wrote:
>
> Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
> ---

Reviewed-by: Peter Maydell <peter.maydell@linaro.org>

thanks
-- PMM

