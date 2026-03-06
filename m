Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 09252F0180E
	for <qemu-devel@archiver.kernel.org>; Fri,  6 Mar 2026 09:13:51 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vyRFh-0004xm-It; Fri, 06 Mar 2026 04:13:45 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1vyRFf-0004xB-BY
 for qemu-devel@nongnu.org; Fri, 06 Mar 2026 04:13:43 -0500
Received: from mail-yw1-x1130.google.com ([2607:f8b0:4864:20::1130])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1vyRFd-0008Hw-S5
 for qemu-devel@nongnu.org; Fri, 06 Mar 2026 04:13:43 -0500
Received: by mail-yw1-x1130.google.com with SMTP id
 00721157ae682-7986d231b3cso117977607b3.1
 for <qemu-devel@nongnu.org>; Fri, 06 Mar 2026 01:13:41 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; t=1772788420; cv=none;
 d=google.com; s=arc-20240605;
 b=AH/3P5oULZTl9aSW5V64PuonjlisPjdLCa6DiVFDw/cXd2fpe55FWwZdv1x33mUisM
 zMCRRRF12MtNrQejgOvWhzo8jsqYGnvUjNm5txgBdAUz1VaoKE2B3VrWqD5tdOz1Ma+e
 0ABjIeyJ3PnIQud87q3Vq43O8qfsdYR3m7/6SyjtV05Kx/YYzo02AxWIu2bzLuy+CFtZ
 kVwbZ9Yiibr6sNYVdhvo4g9h0b1RPl9oapGxdp/AGXOPfxHr8lkcP+JbmnxQAMnk3XE1
 x/0oRdIr8z+ur/H7KqR+JapSWUB/ON0jMLKo33HqURWveyjSak6uSO81h6BROYANjkIf
 jHUQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20240605; 
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:dkim-signature;
 bh=+5hNQXNQU++ooqB//AGZRG0XjgG1eUksrOo6LlmjADI=;
 fh=jjZEu7rw45pNspIPqJIQrqSqcalXiWsfo2bfFRX5zu0=;
 b=fVcfo6VgKi+qPlY+dnpu2e+AsuBCJxtULFRnQMpQPjp0EmZ1VAtFfrBxG8fSiBgM0a
 kmZlD3LFhks9YO9i3uE/yuElGc6KrDdkN0SFgCRI65/789o4Brm7pxadxx8pLuc9VZHA
 ErZ7dIPfB+v1v9uYyom0SSN4lRUWYU+a0Ui5DKsP9uQ2erqV9qLREOPkvDKtpwbK8yTA
 oX9K6wYfjiLWnktUzL7j8szw76FG49lycpv8eJzl3s0YIq/1tD2PWcHY/BYmi9t6seVf
 dKCJFfYD+rt1lVTaJFgBlgmwD93eydNjCr2sK4GbwQENqrY0KSR7cbogWLyvWP/M68zx
 eoRw==; darn=nongnu.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1772788420; x=1773393220; darn=nongnu.org;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=+5hNQXNQU++ooqB//AGZRG0XjgG1eUksrOo6LlmjADI=;
 b=GNse3Rg7qhA5o8O0C31QI2+Lmt7JdsYg1WqgFlMwmoXDeENayLKbNBu7t1RhRaV0GD
 k8H8bkpVLy/K97LSLdfrwwfgtoO4JC/lANpiHYuvwC+NTjprTz2mGCV1li1bPiyLr8Hb
 jz9E3+oCVoB6yR5HWfjmNeuYu4LpYTQr4Kx7mqpY0ZSyZNeNhLcexauOI4qtPpaIt1fT
 ZWFUfpwl3M4t3Pkiuhu+JO4T5QraWTLumrn+BryzXyAtwgJbVIDz03I1AO41oNhKk3bh
 9K6/9u0OUiavscDIKI9ChFp/k7JZ5Wvz+wZdXc277vQubQZwQT6CKvSLwrzxqF0/zqi/
 sPkg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1772788420; x=1773393220;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=+5hNQXNQU++ooqB//AGZRG0XjgG1eUksrOo6LlmjADI=;
 b=INvE5n8fPXqR8tiF//JBrxeIbsBC7EeAABRQtOIcmQT6HbdcQdQGXUyVZC4K54nLT1
 NuOy2b9BXXWyX52gs0qnSP1cKQridd4cI/bJHmM2MENNBWKwOAapDSJsZOm7/CvwPZq3
 pkH079+E8a8FrDk8kQcA1digx+80YvJqyy12+/Jo+j5qFiYK1aPOJBbA63z+eZ8AYjdq
 +06fX0HbLfM2QyNf6aQHchdQhHqM7mNndGiIWfkPEBOJgriUo4nS+8dQ+PEbWkBro02C
 n/w0zq/P+sgxS0DKRFixiBfpqT+Q+glx0JGh1VpQp4jlNjnAiMkVqX1dCTP9s2f0dMHW
 aCbA==
X-Gm-Message-State: AOJu0YywBD4HKXczMC7EqTGlVMt/LNsZqzXaDB7oV6IdTt8zNsNNZZkr
 NubHrxxc5YeUbHIDG4x7Mi9IZ9D1FAS7eq9eICS5faJqrjLon0+Dn19+rHFyMOexaFiAzMeZyj0
 OvJCrjZI1/n+lfp+ZnisZIqZ5R26F6iLK9HmO7pnSPg==
X-Gm-Gg: ATEYQzx9czRgX4hogUqOUPfX5HJx0e4mAe3Ls+3vPvGWv0rDcylHhqZDxZ+pcKJIv4D
 00dFewa8jd4Pspzxb3oHLRaTDZ9dZlYp6n8d8dz+Td8FpAUOVZEYA3xtxxg9pJZZVj3X/ndu8pm
 IyG/3eSkGRw1ZhMHB9J37CrbC5esxpiqnmF7mAIpir9630hxsjpXk5L1FHgOCciivvtuHje5eA4
 70W2jFkhVUmHDDC2ISaTo+cRGndnv/EwKYUSc+iU4QL2cgWDlpfQm5N1+yyh3rTOs8hJk0vgRRT
 LI8oPYVKwwUaVUwnIDkPuRacPFf0ZseKNSqYR5Izh+9WyFp2cfVa758cHlYb8d59odnDC3kRxpi
 54A==
X-Received: by 2002:a05:690e:1443:b0:64c:ec30:9dd8 with SMTP id
 956f58d0204a3-64d0719c578mr3811846d50.47.1772788420593; Fri, 06 Mar 2026
 01:13:40 -0800 (PST)
MIME-Version: 1.0
References: <20260306083113.74177-1-mohamed@unpredictable.fr>
 <20260306083113.74177-4-mohamed@unpredictable.fr>
In-Reply-To: <20260306083113.74177-4-mohamed@unpredictable.fr>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Fri, 6 Mar 2026 09:13:28 +0000
X-Gm-Features: AaiRm51OgIje20Ki4-1bFqizkmg70Wlt7bP-H_xWBwZvyvtHUbpVDISXOaWW03A
Message-ID: <CAFEAcA9Y8e75ATpE1+w-dAP60oRwy84+8WyHmD9AYnKUjn7XFw@mail.gmail.com>
Subject: Re: [PATCH v14 03/19] hvf: hvf-all: stop including hvf_arm.h
To: Mohamed Mediouni <mohamed@unpredictable.fr>
Cc: qemu-devel@nongnu.org, Paolo Bonzini <pbonzini@redhat.com>, 
 Roman Bolshakov <rbolshakov@ddn.com>, Mads Ynddal <mads@ynddal.dk>,
 qemu-arm@nongnu.org, Cameron Esfahani <dirty@apple.com>,
 Manos Pitsidianakis <manos.pitsidianakis@linaro.org>, 
 Phil Dennis-Jordan <phil@philjordan.eu>,
 =?UTF-8?Q?Philippe_Mathieu=2DDaud=C3=A9?= <philmd@linaro.org>, 
 Alexander Graf <agraf@csgraf.de>
Content-Type: text/plain; charset="UTF-8"
Received-SPF: pass client-ip=2607:f8b0:4864:20::1130;
 envelope-from=peter.maydell@linaro.org; helo=mail-yw1-x1130.google.com
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

On Fri, 6 Mar 2026 at 08:31, Mohamed Mediouni <mohamed@unpredictable.fr> wrote:
>
> Signed-off-by: Mohamed Mediouni <mohamed@unpredictable.fr>
> ---
>  accel/hvf/hvf-all.c | 1 -
>  1 file changed, 1 deletion(-)
>
> diff --git a/accel/hvf/hvf-all.c b/accel/hvf/hvf-all.c
> index 033c677b6f..5f357c6d19 100644
> --- a/accel/hvf/hvf-all.c
> +++ b/accel/hvf/hvf-all.c
> @@ -18,7 +18,6 @@
>  #include "system/hvf_int.h"
>  #include "hw/core/cpu.h"
>  #include "hw/core/boards.h"
> -#include "target/arm/hvf_arm.h"
>  #include "trace.h"

As an unneeded include and especially one pulling in a target
specific header into a generic source file:

Reviewed-by: Peter Maydell <peter.maydell@linaro.org>

thanks
-- PMM

