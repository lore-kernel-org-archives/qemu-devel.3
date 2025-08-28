Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1F83CCA0EED
	for <qemu-devel@archiver.kernel.org>; Thu, 28 Aug 2025 17:50:02 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1urgGY-0003yL-Oi; Thu, 28 Aug 2025 13:18:27 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1ureNn-0008U5-Lh
 for qemu-devel@nongnu.org; Thu, 28 Aug 2025 11:17:47 -0400
Received: from mail-yw1-x1133.google.com ([2607:f8b0:4864:20::1133])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1ureNi-0006hQ-S9
 for qemu-devel@nongnu.org; Thu, 28 Aug 2025 11:17:47 -0400
Received: by mail-yw1-x1133.google.com with SMTP id
 00721157ae682-71e6f84b77eso7724867b3.2
 for <qemu-devel@nongnu.org>; Thu, 28 Aug 2025 08:17:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1756394259; x=1756999059; darn=nongnu.org;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=4Uu3EFZkNH2F5WmF0qq/kp2M8jdcpiIHDjfmFgCTkQQ=;
 b=bFKfreXTf6wNKt3crtaEqltZGF5s9YDHeiCibuCyulznEkuCq7llwPZuNNmiYaO65L
 xkw2534xeeNF9e0frQpmToEGagt7bnpw1iOq9gyo3rBh7isVmxvZEZ1kbOD0lrsZFEva
 RT0PZjNvxoiu3h9nCOILzQi8+VnmbeHUYir6mt2rCZIbvExaRwtcGhkdi+uJ70r1ylyw
 3dIGiz3GmAGjEsJATfAjqrNytJFcqw0Jv7QRQDgNbVDhl3F4ebupd1OplNBtlgQ8wXv8
 L/jsyfGZBXugCodghy7TCtXPoz9reu6myiN2qw2QjMgKBKXQ6Vl2PVsrpoUorL54R5/+
 t8wQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1756394259; x=1756999059;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=4Uu3EFZkNH2F5WmF0qq/kp2M8jdcpiIHDjfmFgCTkQQ=;
 b=gofL47/rWvgt5fx3HUpzY3cZs7Q8G5gjiBGTItNInZsRFqvO3N+hekbFqisHI8o2tj
 XygfdD7211F52TcZR2rMbqLFoxPuyqsSf4yDQTqKPtmLVI8j0hSYWehrQpYB06C9rxkp
 DQqgFyLVF+s1ZZEcyBB9omNq4UUBAF7Jobg1ElUsuFMj4jBDZGzJVUzZAkwbNfCacU0X
 OCAiHEldF1s3knryTMxVfMmn/n2Hu+RWYyjZz9ZYoKaggANH8plqXrYWpNUllAjYaLMY
 g+UXKH+OW90rP1mZb5cke1Ho1QQKcGsLUlAJZi9xmzpDppRFke1i8ec4HTHkLpGekOIH
 0VBQ==
X-Gm-Message-State: AOJu0YxawWHHJe6JehGdKTb83NYSrVAOEbYgcR16gKbGLzMsNh7qENtr
 HxXh/5qlI2FyFEZyDQkksIb5kLcJSClI8ZAv8lXhxAYWW+Ea+DOj2h/m8AoDiL/TV8CxHtzGvQs
 2tzl9xrbJ2pU+vSTy6xsNWsN38+GdRkMqegTA2M8QTEFnoDGhRKb+
X-Gm-Gg: ASbGncvbHgkJkeMDU3gewO/q/DkUSM+q/q8AdytE847J50HGpOx6TgPkjudIkYtXBqZ
 XryjFjsG+UEcQZtII7h2VZkab7AsYk4f7o1XvqvUpWeoHG5EiwNlGNTHKTnIavQIf1CR5lVmZW7
 jgTKGtzb9LkyERcWdPMI03uOIH/jkSatFI8ycFmi4lLjvo+/ytW/ts3InxqMd0+63sMxDLvOca0
 otwsi2I
X-Google-Smtp-Source: AGHT+IE/IfNueiYoRqMkWJqRVLLd5k+ECmGgduOmeMrMSAVsWxRyn4eo/7b0vuaDjlnoTVCFyZFLayMr4JD9/nI3q4Y=
X-Received: by 2002:a05:690c:6d0d:b0:71a:17fa:bf06 with SMTP id
 00721157ae682-71fdc2e25efmr315724667b3.12.1756394259230; Thu, 28 Aug 2025
 08:17:39 -0700 (PDT)
MIME-Version: 1.0
References: <20250828120836.195358-1-richard.henderson@linaro.org>
 <20250828120836.195358-55-richard.henderson@linaro.org>
In-Reply-To: <20250828120836.195358-55-richard.henderson@linaro.org>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Thu, 28 Aug 2025 16:17:27 +0100
X-Gm-Features: Ac12FXw323IMXPrcVYVd_PdlhpWksnQkCXD6ahFp7Ziax-H-f-KStFjol3IbrZ8
Message-ID: <CAFEAcA-K9gxV700SQ_t9d=+OgnnyH_kEaS+gB+Vr+TZpPkJDJQ@mail.gmail.com>
Subject: Re: [PATCH v3 54/87] linux-user/sh4: Expand target_elf_gregset_t
To: Richard Henderson <richard.henderson@linaro.org>
Cc: qemu-devel@nongnu.org
Content-Type: text/plain; charset="UTF-8"
Received-SPF: pass client-ip=2607:f8b0:4864:20::1133;
 envelope-from=peter.maydell@linaro.org; helo=mail-yw1-x1133.google.com
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

On Thu, 28 Aug 2025 at 13:14, Richard Henderson
<richard.henderson@linaro.org> wrote:
>
> Make use of the fact that target_elf_gregset_t is a proper structure.
> Drop ELF_NREG, target_elf_greg_t, and tswapreg.
>
> Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
> ---

Reviewed-by: Peter Maydell <peter.maydell@linaro.org>

thanks
-- PMM

