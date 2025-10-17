Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 30F98CCD195
	for <qemu-devel@archiver.kernel.org>; Fri, 17 Oct 2025 13:09:00 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1v9kBr-0002gX-FE; Fri, 17 Oct 2025 09:08:15 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1v9kBp-0002fZ-BZ
 for qemu-devel@nongnu.org; Fri, 17 Oct 2025 09:08:13 -0400
Received: from mail-yx1-xb129.google.com ([2607:f8b0:4864:20::b129])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1v9kBm-0004K7-9v
 for qemu-devel@nongnu.org; Fri, 17 Oct 2025 09:08:12 -0400
Received: by mail-yx1-xb129.google.com with SMTP id
 956f58d0204a3-635355713d9so2084363d50.3
 for <qemu-devel@nongnu.org>; Fri, 17 Oct 2025 06:08:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1760706487; x=1761311287; darn=nongnu.org;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=EOX/WQzjT3o9PGNahJE4722CtdJpXS5IBHnPBT0VUDM=;
 b=UdkHh2gacpFisYOPvtwBlPl2LlLJYoIZ9l1icWx7yJfkk2UAU3V26Y+JNVxF7OapMy
 5/tuU360qrzlY6dYNCG6QqXf5pFEkt+V8T6Fft9/5B+2PQaCSIIz2Fzx4rGlYDcdTUHB
 iq7LdGYP22/x3N941aZIyo/R0QK1rOPQgfEftBzsdEfp2bYUbSl6aXTatJodBzeupAvK
 ipPwTTk7fpVWpm+XUPAKXwcuDAUA+No2l8ir6zG0PgKbojBbuSWoPUDzfi7fdFgh0QqU
 Ez1cOVR+bFw7XGbfBO0HiHe0Me/oPUzDc7OE3yMWb5RD7wG0ODP/d5hGfHdlMtvO4RJy
 cF8Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1760706487; x=1761311287;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=EOX/WQzjT3o9PGNahJE4722CtdJpXS5IBHnPBT0VUDM=;
 b=o+fjJsJOAD9AufWZ1SHmrwtgc0XX1ymRRbC9dAO2sSSFfuRs5RpTKYqKQR00z090Tt
 0bDFYEsUlJ3cJp4njPPFRyewMwFbgTT6p0UjNTe7/75MlZqAGPGegB+msXy/9uGk5uCI
 Yn8HZv6v+meskyLnIHNAbuZY7CbiVNzFik+/84EeyQi08xKOSPHI0ot+2xH3voFSrgCd
 OCmnysOtlvqMU0J8FBELJL6YMahK/1k8V3Tc6ewkxUdhbefZ1XOKSSeKf58fH6r2x6XL
 ZvTdT6VuGyHgZCVpjv7Z5IMQbW4ogPHbf0UKfpH87ZRC7Gst7GuIuPP49HOwM91nEKy1
 bM/g==
X-Gm-Message-State: AOJu0Yw0lQVe3FwK94mqkaaWQCMs7uY72Z+1azDwTc8I41bAaaSdAkAX
 hxmPdaF9ulppuYpk0CdPRhRzYATjvKKRgRSEEjD+pQPcZljoFVrMbGwPKKHBmibHeWBEWrsa0Ng
 KunEIQDnxlaKyn4Uo4huItXZbqycTypJ8xbh8KyB6Ew==
X-Gm-Gg: ASbGncu9oJpLDjezq0435a+MSIEuGCFyGL4fpuMmblW4/FBOWW7KjbRv3ZzsA7oMw9T
 n2N2ESRqrjJ14Ap4Q3qSuBJ7roWnC/wvD6cDrTOw+hvsDHuDNQWIa1bUxQ8TpJ5/2/TAidcsrm2
 tr6nWIViUnJQhpOT3h2y+5NM/wEqFcheZeYZuY9/LPZiGlslTLf3xNXnav6SsfF/34CwPbNSJ+R
 OQlwG31TukQLkWUJh0NBvRmwI+lkg9ligrHPktU4XNkB5+QZwHFhZf2snJcBg==
X-Google-Smtp-Source: AGHT+IEFbB606H3WvX0IzjfN8a597azWq+klDlZ7sxXgfG/SUzB6I+NBNevaACbSMczjwGlWLfMMSO5lpIjK3ZrplK4=
X-Received: by 2002:a05:690e:1244:b0:635:4ecd:75a3 with SMTP id
 956f58d0204a3-63e1625a89fmr2698520d50.49.1760706487046; Fri, 17 Oct 2025
 06:08:07 -0700 (PDT)
MIME-Version: 1.0
References: <20251014200718.422022-1-richard.henderson@linaro.org>
 <20251014200718.422022-7-richard.henderson@linaro.org>
In-Reply-To: <20251014200718.422022-7-richard.henderson@linaro.org>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Fri, 17 Oct 2025 14:07:55 +0100
X-Gm-Features: AS18NWBxzU_bVcjTrG4rD959H0fu-VKTlD1ZIXpJyduFZZNSMo5bKAQzicReWVc
Message-ID: <CAFEAcA--zMJxjLmivDCjRoGfQp5gVMLe8J0_RSZom3Esz=OE0g@mail.gmail.com>
Subject: Re: [PATCH v2 06/37] target/arm: Add raw_read128, raw_write128
To: Richard Henderson <richard.henderson@linaro.org>
Cc: qemu-devel@nongnu.org, qemu-arm@nongnu.org
Content-Type: text/plain; charset="UTF-8"
Received-SPF: pass client-ip=2607:f8b0:4864:20::b129;
 envelope-from=peter.maydell@linaro.org; helo=mail-yx1-xb129.google.com
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

On Tue, 14 Oct 2025 at 21:17, Richard Henderson
<richard.henderson@linaro.org> wrote:
>
> Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
> ---
>  target/arm/cpregs.h |  6 ++++++
>  target/arm/helper.c | 21 +++++++++++++++++++++
>  2 files changed, 27 insertions(+)
>

Reviewed-by: Peter Maydell <peter.maydell@linaro.org>

thanks
-- PMM

