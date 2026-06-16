Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id DC026CD98E1
	for <qemu-devel@archiver.kernel.org>; Tue, 16 Jun 2026 15:04:40 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wZVKm-00086g-K1; Tue, 16 Jun 2026 11:04:12 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1wZVKk-000863-Ld
 for qemu-devel@nongnu.org; Tue, 16 Jun 2026 11:04:10 -0400
Received: from mail-yx1-xb12c.google.com ([2607:f8b0:4864:20::b12c])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1wZVKj-0002aL-2l
 for qemu-devel@nongnu.org; Tue, 16 Jun 2026 11:04:10 -0400
Received: by mail-yx1-xb12c.google.com with SMTP id
 956f58d0204a3-660e9fef1d4so5034528d50.1
 for <qemu-devel@nongnu.org>; Tue, 16 Jun 2026 08:04:08 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1781622248; cv=none;
 d=google.com; s=arc-20240605;
 b=cjkmtlLcBsmBLX7J3CIIpcbMOz5MzIqcqrHPZpL4s80yCvFeNcfxqa1vbFrQ32aOYy
 HAyblCRcvPvJyUtGZaOHyY0Gb33R/W3lX/BuGTgHEm6zS2jJY1xlvrYhIsNXnw79tKUp
 t2cnUHVF7mHg31j+S2TjtVsvN7nhce3tP+o8eTZmysQFuZvw/4RG+4ffTwsaYqKD8byX
 zdfKFdLSvNij/vNY0BlT+/jhMsrMD+UZMie8Nyevxdm+PHfESZTjIHrGkHV1xyoRElur
 3GkzfVImwA+rZIfH8jpZN8cQhVY7CuyP+TIMGb80Jy4kftTQpOwrTgQE33xo30HoE559
 6qdA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20240605; 
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:dkim-signature;
 bh=Qc37mOnJ6NP0Da6Jmo2Tol2sFJDfI2JDHyuPKZJfqN8=;
 fh=U9rdp55di24dWIQIe/OXegJS2V84jwgPiQpnHf0WeCA=;
 b=aHGQsPzyYA//44r2WIGEtMOhmZPqLn4uG/uN7xFd2GYGmtM4B/qgx5dU1TTgKf22/v
 8fykVCCUJT3kpzZU6qWA/SHWUoNk3MMvev1lIAtIN3/CbvjqnQ1TgeCVu/MOdO+pZwa2
 3q7Es/CpfPx/z0RbDNA8q31pGUyGNxDGwuPJI8yNIEr9JCFvO395m1xNhNRo+6zxFk3i
 Gl67RchsrRnllPqsCU5s48AcliD3NPprxF101rZbwov3lV/U0yB8C/EZTR5wgmskpnhj
 20rbOg3Mw91Jg/9KTwPgCle3IZcvUWZCu42X7Y1bJvjdDzOyB58SfS22NMpanYUZWzSS
 nVLQ==; darn=nongnu.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1781622248; x=1782227048; darn=nongnu.org;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=Qc37mOnJ6NP0Da6Jmo2Tol2sFJDfI2JDHyuPKZJfqN8=;
 b=whejmiiDxjbPrudV68b+eEdKFEStsEQlGK/q9C107+2M1Dd5GNa4t+YXE1OV60+3J5
 lvtD3tH7kHAbp+d2fovVMKXnt679XpdQ+N4HR/rrWjBt/9ld52x+ishB+tMajkvYL4i6
 3UZZfLeTF7i2F3B+aoNvN9oF/2Dh4RWjqF7nNIQi4JNtTyYDQWKfOBq2+v2zzwuTDt3n
 IkkGnX2k7vdpCnatUfx6bRspiDYAJigv2mIcnwM1lrSkX7OLmAacsjngxnRHLjBD2DMx
 axSVIOw69RutI2540r2KG4giGR1zWkTiMW6zRqKvWeTkGDYPFGFqO02HCcg7hDM1BKEZ
 nXhA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1781622248; x=1782227048;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=Qc37mOnJ6NP0Da6Jmo2Tol2sFJDfI2JDHyuPKZJfqN8=;
 b=gvz/ZiUU7/L9PF2nqHejYnqWrMbx9V7sNHuexgUyCi1GW2WbJu3YSim2boT4yc1Wdo
 ppUYj4FcIqv6vbBpSR2EXoGYK5mP+2/bPg+ek4R5p6Vo8YzYgWRR7qp5fsdtYlf+TP81
 iTLE/E4cSaMoZFNVf8Q4NfA3AUKtNnJ9Ude7klQIQQxXtb/Eg9lmFMmaGIOLm58hedvy
 pO9ZVCHYCeiEG31a1Yz9Qglo16mJEfV2amikCa4Ue2WWCCWC3tpxTUJvguEErMzn8Px8
 22bErSY/caxclf7fLCTzPuR0uz0RhqAGQa2TZXx2188Z1SMJg23qQKbiSPvGSEQx8LEz
 BqeA==
X-Forwarded-Encrypted: i=1;
 AFNElJ/8aMEa1O94B0DPFWpbybdILZCU14IM5dUyiBlveq80G4wQ+WHm2JTdRfbkYpHNl0IQu+wrYT3dRKQi@nongnu.org
X-Gm-Message-State: AOJu0Yx8OdVUlRlsEcyrKYE3jqoEF6NINGWDUMCECGpgtpqjegS5iKow
 oORDak2WlpHOSp2hlHi+4NUq1pMTfDMXshGBPM8LWjx0mybVXAKGIfdhWjArf7diJd6taAbTrvn
 XYH4aIL//LOpRNsWC7gOjlupeF6zNpyRcKRbEEVcBZw==
X-Gm-Gg: Acq92OEqM/Efk6hrVccOc1LdKFg1t8j8hTDIQoOd1cP+4g6KVeT/ic5+w7aT6NoTd9h
 hyBOXovUq8ObyRHVkFA5jg0yeWxQlGAZglaXSIL+ku0Du/xIW5B/GIF/yEvALtZ01VyVKasd2TU
 VkVtegp7wY4fxjd7hAM1C/XavzOF4/ph83pVmfcEzNRgSdh5sz3Tq6okjs427ttDMvi25BpMPw5
 ucJh9W9w6LPW2lEB/yPrQsttJ0idLNxNZXisKThKs5XXtbWSHXyBsg/h1S359L/2NlIdYgayN6Z
 zPl+3yucBnfZdxrc09Fv1s1g0YA3Jgxd99QSEWMkAucLKLQCasQD/73YzyQ2VEymVlw=
X-Received: by 2002:a05:690e:484d:b0:660:5694:9e4d with SMTP id
 956f58d0204a3-66284f8c462mr10594077d50.20.1781622246143; Tue, 16 Jun 2026
 08:04:06 -0700 (PDT)
MIME-Version: 1.0
References: <20260609024027.22140-1-nicholasrighi@gmail.com>
 <CAFEAcA-YSacshreh4z0Ld7pYdqjECsGxHmkfBrKgQdVPqHVPXg@mail.gmail.com>
 <b246751e-da58-46c2-9ddd-dc48b9b1284f@oss.qualcomm.com>
In-Reply-To: <b246751e-da58-46c2-9ddd-dc48b9b1284f@oss.qualcomm.com>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Tue, 16 Jun 2026 16:03:51 +0100
X-Gm-Features: AVVi8CcrlM6gqKh8FVBffKX1gWEScvo0BOgAK19E9CsAMnU-Ei_m1S4-J0mpnvc
Message-ID: <CAFEAcA9PObTXRKQEzh=KtRQtYzY8wan-3ROOkOg7PBfc+Z75bQ@mail.gmail.com>
Subject: Re: [PATCH v2] hw/arm/bcm2838: Route I2C interrupts to GIC
To: =?UTF-8?Q?Philippe_Mathieu=2DDaud=C3=A9?= <philmd@oss.qualcomm.com>
Cc: Nicholas Righi <nicholasrighi@gmail.com>, qemu-devel@nongnu.org,
 qemu-arm@nongnu.org, 
 =?UTF-8?Q?Philippe_Mathieu=2DDaud=C3=A9?= <philmd@linaro.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
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

On Tue, 16 Jun 2026 at 15:59, Philippe Mathieu-Daud=C3=A9
<philmd@oss.qualcomm.com> wrote:
>
> On 16/6/26 13:10, Peter Maydell wrote:
> > On Tue, 9 Jun 2026 at 03:40, Nicholas Righi <nicholasrighi@gmail.com> w=
rote:
> >>
> >> The I2C interrupts are only routed to the legacy interrupt controller.=
 This means
> >> that for modern device trees that use the GIC, the interrupts don't wo=
rk. This patch
> >> adds a splitter to route the I2C interrupt to both the legacy interrup=
t controller and the G

> > Applied to target-arm.next, thanks.
>
> Too late but still it was in my review queue:
> Reviewed-by: Philippe Mathieu-Daud=C3=A9 <philmd@oss.qualcomm.com>

I haven't done anything with my queue yet, so I've added your R-by tag;
thanks!

-- PMM

