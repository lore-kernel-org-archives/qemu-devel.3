Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4EF5EC8303D
	for <qemu-devel@archiver.kernel.org>; Fri,  4 Jul 2025 14:56:49 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uXhZ8-000393-Tg; Fri, 04 Jul 2025 10:39:03 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1uXhPL-0002i9-SZ
 for qemu-devel@nongnu.org; Fri, 04 Jul 2025 10:28:56 -0400
Received: from mail-yw1-x1129.google.com ([2607:f8b0:4864:20::1129])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1uXhPJ-0001bJ-Gv
 for qemu-devel@nongnu.org; Fri, 04 Jul 2025 10:28:55 -0400
Received: by mail-yw1-x1129.google.com with SMTP id
 00721157ae682-70e23e9aeefso7086667b3.2
 for <qemu-devel@nongnu.org>; Fri, 04 Jul 2025 07:28:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1751639332; x=1752244132; darn=nongnu.org;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=joESWnY5bJ8UksgfoDko2BOSAXcPRoGq36B5uo0O7JU=;
 b=Psl3DI0EWeQ6hlg/gUZkGgqlpUifOY/nKkbTvzyNSGb1j9cHHPdGUj5add2wP49k6c
 WcqYW9eR4Of9Dyee8d2kWLb4mq/VQMs7mkFn5dZTH8p7A7aCM3AwX0cuMNX3FgDejhVz
 ih0R3Am16emBKfeKVxAxunGD0gQTemt4SZlqCmCY3qDnMGegqubUj4AXPgPAVWSDL18Z
 TfWVsl5QCAwa66cPQNve4eKcOUDuKlc1/RuINBRRN7NUZL8PJbtUMGb6YDSOk+Qyynpx
 rUXEzuvbp+EYIrND4gCpAGdfCbzC6PMy0SqtwZzX/G+z8ZDPtichC0dVqvXX8MP9vVNi
 lx6g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1751639332; x=1752244132;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=joESWnY5bJ8UksgfoDko2BOSAXcPRoGq36B5uo0O7JU=;
 b=h1SB2EeHnelcCBKUga/dahWLYEMDenrT5ghdUXME9BrymojaSZ0DbpineHgUXLG9AJ
 zkQhPMWvfHSyw6bR+T8MFlD2co4y+MY2z7ayQCO+mvPXVVRMW2jVeXKRwFJYXUHIveM8
 Rij4BvNBkEkaDrNve6d2TZBVGt2K34TVaRmywxj7CbDE5Ryx0n0LlT/7VXIcdvy8XOvR
 hpqFGj3uT4TBcdB22YLpjQKvVTzTXuNSJYTtscxLKtmC+pf8x4Zq2z6dKQ8IeoWWEPUN
 dLhz+qOmVIpvcZzu64Q9BBDxxJ1GMtHfJDtIPcQiO1rs8QXJxaWO2h6GN3MsXdbuQKeG
 D2Ng==
X-Gm-Message-State: AOJu0YxQidnBJ//ykFKW//0XyvnuHM1h0SrOrzNpLmAQLED0qQAuRDfw
 khWesZ1iXRjG9qwzk2w1vfBVlo5kj4RWY4f2aq+xw67Qy8UX5k9AvsPxuTlFu3V1z92l0DjTwAU
 FOM0AD1mdCij8gHLdZ7byfaDUxSFNVJ52zv/JNXhPEXlBIPcYUme8
X-Gm-Gg: ASbGnctHlAo2pzyklnLkbP2M4EXHY2E3CljshM+NIp3I2eFomHper3aK7At3gJdmHGP
 PTUHsYFTD5QNYBgJHg3Hnonl+OO/wb4SVI+cUj/EYy7/COuovPODaOQP+QLH8abJc12xgdOWVqZ
 X4fZ9N+VQu1uj5RorF8YIFeKyYZ+jFe2/P2FMb9wjNXM29
X-Google-Smtp-Source: AGHT+IFRRfGlESRhtbSov1Mv42hdsUsBhJpdTTKI4wzxPaSh08IOqbnXP9j3lCudBcGaXMj05MbOCTOAURO/BsuDszM=
X-Received: by 2002:a05:690c:4c04:b0:70e:142d:9c6e with SMTP id
 00721157ae682-71668d0ee06mr38690167b3.32.1751639331948; Fri, 04 Jul 2025
 07:28:51 -0700 (PDT)
MIME-Version: 1.0
References: <20250704142112.1018902-1-richard.henderson@linaro.org>
 <20250704142112.1018902-62-richard.henderson@linaro.org>
In-Reply-To: <20250704142112.1018902-62-richard.henderson@linaro.org>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Fri, 4 Jul 2025 15:28:39 +0100
X-Gm-Features: Ac12FXwlUTLQ7G7oZWsruazCkXotjVGAn9kSNaMdF7GnYliW3CqyySkf6ncp_u0
Message-ID: <CAFEAcA8xKgak7VEHa_SqGkZpgUK3ZKAEN5JNj4dap9GDhO3+XQ@mail.gmail.com>
Subject: Re: [PATCH v4 061/108] target/arm: Implement SME2 SUNPK, UUNPK
To: Richard Henderson <richard.henderson@linaro.org>
Cc: qemu-devel@nongnu.org, qemu-arm@nongnu.org
Content-Type: text/plain; charset="UTF-8"
Received-SPF: pass client-ip=2607:f8b0:4864:20::1129;
 envelope-from=peter.maydell@linaro.org; helo=mail-yw1-x1129.google.com
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

On Fri, 4 Jul 2025 at 15:25, Richard Henderson
<richard.henderson@linaro.org> wrote:
>
> Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
> ---
>  target/arm/tcg/helper-sme.h    | 13 ++++++++++++
>  target/arm/tcg/sme_helper.c    | 38 ++++++++++++++++++++++++++++++++++
>  target/arm/tcg/translate-sme.c | 16 ++++++++++++++
>  target/arm/tcg/sme.decode      | 18 ++++++++++++++++
>  4 files changed, 85 insertions(+)
>

Reviewed-by: Peter Maydell <peter.maydell@linaro.org>

thanks
-- PMM

