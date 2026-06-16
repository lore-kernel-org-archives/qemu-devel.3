Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id AA4ADCD98DA
	for <qemu-devel@archiver.kernel.org>; Tue, 16 Jun 2026 15:50:39 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wZW3c-0000YT-2f; Tue, 16 Jun 2026 11:50:32 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1wZW3G-0000OR-6p
 for qemu-devel@nongnu.org; Tue, 16 Jun 2026 11:50:10 -0400
Received: from mail-yw1-x1135.google.com ([2607:f8b0:4864:20::1135])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1wZW3C-0001BL-KD
 for qemu-devel@nongnu.org; Tue, 16 Jun 2026 11:50:07 -0400
Received: by mail-yw1-x1135.google.com with SMTP id
 00721157ae682-7dc2b658544so34141757b3.2
 for <qemu-devel@nongnu.org>; Tue, 16 Jun 2026 08:50:05 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1781625005; cv=none;
 d=google.com; s=arc-20240605;
 b=IhKaC9N//Cuc1DyY6986GuIbKHnS99O6ZFaB4i+Ya1dvh26xa+xc4o5qhDtJnrr2Qx
 x2Z9EsGj53/TCM+S94Fd6gbqQ0jAiPHmQ/d1sA1V2j5My/NzkFiEiEQMHCfq5830pMvE
 AQi/Q3P0dG29vxtF31GD1f3JhxHrXA5e6HBbvrtOX8N9PSKOITF6+IIr3le4AgTt6Gr6
 dNQsmjJ8uJH2PtJ9Lu862kcan8grRojGzP8PuMf2p5N/OxeHFVpf1x8IeD5dJot4T4R9
 mK13wPsZHaP+LG9SQIuda4nq3c7JjC+4zcd9LFfeiXqhoNKHrygOSQzR13xyzRYPSPSU
 oS8Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20240605; 
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:dkim-signature;
 bh=U7MzkeiFKXRvqU0JU0E4LhUXbdoql2dcd8OKOUYWI4w=;
 fh=MEqsX9fzFeacuRqQ7tkUAwoA6HleHOXoxUEgibkYVRQ=;
 b=gaQ6ksVy0YTY6aQiKaKX3Ro12qxkOKZu2iY6N5Srj/s4zHJJ8oXqctq2j0eTvuB3VO
 Ouyat9L3C7obApxGZbDQ8VYhQoyLxzD8eBm59HanNzlgGJryYXAFc7oRDEz4BnlNc0hy
 CgM1Ti7XE+Ro3B1ZgFW5xChXtTEcO3m0L79pUF6VpJCqbv1IucnVzDhAzyV6UYmt/eIK
 mvdvi0AIP2YVxviIJrh89ZdoJyW8+sgl+wnTQme9eLaCi4tvHEeENBbU94XNyps1HrKb
 YGEb3WaIN32w7n6A4DBEKWKFMXtO4TUfySH85/cW1mWzCEity9c00t+VDrh+e2BUkdXu
 pw8Q==; darn=nongnu.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1781625005; x=1782229805; darn=nongnu.org;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=U7MzkeiFKXRvqU0JU0E4LhUXbdoql2dcd8OKOUYWI4w=;
 b=fYjIlmfjIvADduGyDi6nWlSVQhOp1E4bsTJJrqVDoOmmbGsHMsshpy7uoIlNQhm1zv
 KkDYAdH7oBgn2TkOQFAf0MssPKafaUXUruFuYsx03zetPcjLvbBS0RUXk21JE9ITHJvb
 uLLDhp7KxZdmbe0sc2GVM6ZFLS8xlO1t3ZFQHQIVtBw7zEhBxBmbLoL6AgWySc6/f+ZE
 nUj61vHftnKQFm0d7FaYPsDAmNC8yfDll3ggRTLgWeoQ4WBxs/TP7OtFWNd2SWr4Fw5v
 AknxiOQsJ6PwXvEMf1yMoiUNRQjmaogIFl6ti+PE8qYjiK0qxFAb2o8jPhsbPqPDS1d1
 iXWA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1781625005; x=1782229805;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=U7MzkeiFKXRvqU0JU0E4LhUXbdoql2dcd8OKOUYWI4w=;
 b=s2dP8vP+/tc69an4MN8nvBbt+APKUAsTlyT6sf24nj8KoxmUN1yCUxEtOG+slQ3LbY
 LawiesHhr58ClNwO011JHn8JIoTcVkkK3L5pdf67XQQiNqVM65qFdFXTI/Kheh9HOUAD
 n2NZoW1195D5QDqBoS6zZlcEQaIPxEM/2hRPdo8RzIuvhXPERJHfWv7EftXlfb/UUSIS
 hLHybvRsW1M+FLtnPN2Bgr7QNt9Wxn0DDRXvWzQiUbPh/haCNyhg3YRifSighlkGB7PA
 NpX2OaxYguZ9xEewU6U0gzu//DRLoHu5jXQQRI2/A+ZW92xyhkNRCwbnyQIu4HlhJhXV
 fQ3A==
X-Gm-Message-State: AOJu0Yxk8YKyxMDgHbP4JUuOM5khBj11hZksiijfK7+GZYJ5rLGU6+kj
 ig8Y1pu4GymPL9SHTngniHs99OUH+rHeb7dAzAS6Nkn0BIANalEq4xxTnzBvbJIIzgx2mSbOPzf
 MFauzTlAlVVnt7J/p1wMpIUHYndciviVktxlpZL2R8A==
X-Gm-Gg: AfdE7cnPkqJEuSrPmHSaOeGTujktDZNYZOPMjuzMHEeDO/6nArkZuIa97T8xKB8cy9R
 kIwiSvnA/v4R2f5TUAqXxke8j8UiSvvRVtGxybQfpz5k9nIwDi+B8Czy8f6PKtnsGsDiJhWPyvn
 fuvfJ+qhRTnXpli64MS+d69Z4ODnWUdsl/K6m0N/xjvZc3whcQoXKkCoULtmGE3lK/YM7AmRxb3
 ZG4hBboVQf7KeZdAc/saZlLohyHT83FrY7yaFxw9st/Saqn7wAzx+iJN9bfTUdin2bP83L616qP
 xGOT5U1kIDaBdapnlb+LMAXgAf9d+O/k9A5EXIIY1yyD+WHOFUbV0r+bEI5a9j86vxs=
X-Received: by 2002:a05:690e:12c3:b0:662:c587:4351 with SMTP id
 956f58d0204a3-662c5874aabmr1287622d50.55.1781625004685; Tue, 16 Jun 2026
 08:50:04 -0700 (PDT)
MIME-Version: 1.0
References: <20260616153432.92939-1-philmd@oss.qualcomm.com>
 <20260616153432.92939-3-philmd@oss.qualcomm.com>
In-Reply-To: <20260616153432.92939-3-philmd@oss.qualcomm.com>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Tue, 16 Jun 2026 16:49:53 +0100
X-Gm-Features: AVVi8Cc76eWRUyvbsblTdZ6xTO3AlqMCN8hgJZlnjROWTfhXVIRo7I7Lu06dkQI
Message-ID: <CAFEAcA8BAm4dSPZYH6VroS2GmrBT-oPBaUdrtWJ=2_38y78PAg@mail.gmail.com>
Subject: Re: [PATCH 2/5] target/arm/ptw: Restrict PMSAv8 code to TCG
To: =?UTF-8?Q?Philippe_Mathieu=2DDaud=C3=A9?= <philmd@oss.qualcomm.com>
Cc: qemu-devel@nongnu.org, Paolo Bonzini <pbonzini@redhat.com>, 
 Richard Henderson <richard.henderson@linaro.org>, qemu-arm@nongnu.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=2607:f8b0:4864:20::1135;
 envelope-from=peter.maydell@linaro.org; helo=mail-yw1-x1135.google.com
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

On Tue, 16 Jun 2026 at 16:34, Philippe Mathieu-Daud=C3=A9
<philmd@oss.qualcomm.com> wrote:
>
> Armv8-M Protected Memory System Architecture can only be emulated,
> therefore restrict it to TCG to avoid compiling it on hardware
> accelerators.

True, but this is also true for pmsav5 and pmsav7. Could we move the
ifdef up to cover those as well, or does it get too awkward ?

> Signed-off-by: Philippe Mathieu-Daud=C3=A9 <philmd@oss.qualcomm.com>

Reviewed-by: Peter Maydell <peter.maydell@linaro.org>

thanks
-- PMM

