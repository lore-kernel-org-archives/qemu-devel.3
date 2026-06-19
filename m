Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D76BDCD98F2
	for <qemu-devel@archiver.kernel.org>; Fri, 19 Jun 2026 13:26:42 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1waZEM-0004ya-B5; Fri, 19 Jun 2026 09:25:58 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1waZEL-0004yQ-Bk
 for qemu-devel@nongnu.org; Fri, 19 Jun 2026 09:25:57 -0400
Received: from mail-yx1-xb12a.google.com ([2607:f8b0:4864:20::b12a])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1waZEK-0001on-0t
 for qemu-devel@nongnu.org; Fri, 19 Jun 2026 09:25:57 -0400
Received: by mail-yx1-xb12a.google.com with SMTP id
 956f58d0204a3-662f479a22bso1864115d50.2
 for <qemu-devel@nongnu.org>; Fri, 19 Jun 2026 06:25:55 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1781875555; cv=none;
 d=google.com; s=arc-20240605;
 b=CanWXquLqvdSXICLW70gg5uyUcAY5JzP1qZV+DnuTrH4XUtRM4DIXIPfbUgZP7ZIE8
 ozy61QKP96uPin0QDCTurDKD0P7AM0R1n5lZ4ZpbxE0YXDEhItdamw4e+Dw4DpIewWSE
 BtL9xGevwAKBKHS+XO7tbc4V4Z+Y83A/4Zdsun/TA75cvyAjOtJeU+HbZrzSiqtxaaBo
 F5aZTl7rr0SQrKB4Y3gRyPdzoqnF/zOQVMAnb/3u2+1yBJz7tUDB5nZyX2nNj3n3Vqtd
 mEd549kPGG0+XtX6GUEO480VZHlbvrFjf+rMRkuf8bs0Rp0NH7Darc+TJQLag/d/JxRl
 npCg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20240605; 
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:dkim-signature;
 bh=MkJ267OZeBdiIwykRhDLF7o/+Qi8Dfh7EeAZvTrZv+I=;
 fh=/ftcwOPYeEIhzseC7WF42kR+xVR/IJiWpLC1+A7SOWQ=;
 b=JOT3SoszqV9BzzrKqtHF84wa+S6WYuGCuMHLsu7/aroTB2FKpb+JYHiJz7l1+qctF6
 gJ1BWUk1aH9ZhChOBFdV8y9wj50DjQooq7xv3HiVCZEAyi9KSizyzqTc7byoqo3p/BoU
 2sluoPquV1Bq6AxPTZ7crQSWUzMaBCxonEIFdDmfZ/5l1lNUs/P/tmDByTtRJSUNdPgH
 qfWchY/91v4dN75VkGYX0wHzMl9HHhCvTL1X7rEUbTp08wpMH1mFx8huWwT6hMnE3fW6
 cHr3V1cGdsvNekgIG18bTCVLgYtHQujuAf3zVV5f81RDCCB1shYwMq4CEOzENsPigL92
 Fh4w==; darn=nongnu.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1781875555; x=1782480355; darn=nongnu.org;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=MkJ267OZeBdiIwykRhDLF7o/+Qi8Dfh7EeAZvTrZv+I=;
 b=yZA+yj32DuOL4+/xGvjh4ANotvtGLdxVFGFfxUFEOKYpDZ63FMNw17081ERMYg6ly/
 JxuoW2gEtGGVN2+/a4EezDnuIC35oVXWibSVvIiiP5SgiqCzpiwCzGan97ejjK8IPbMY
 HUHbvv1wJ6ylAs04+nbGL3c5aaz1kJHzPDP/zuqRULLRwvDinQmE2JeU9HVCkzN+K+7f
 5F40DGDnzTtm6vf0kmlqPyLpw/jt4GNW6VMXyk8Jt0mgYfeuoX58YfMWwYLAVEQ/TMw1
 /Lr1hMPlaj8k+w3jpi6ijTVilIVRF+EAtnhB2OffYkNx9Fuc5HOJndoqVbMftopk4R8V
 W+NA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1781875555; x=1782480355;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=MkJ267OZeBdiIwykRhDLF7o/+Qi8Dfh7EeAZvTrZv+I=;
 b=P9u89iFj4cF5OSdnkGg3HVJ4ajjxO+onkzVAeeeJWC0hHyfkffFkGcZ1ySAxUucDjI
 ycm0yLse7jQP62ZNnPD0LFQjQXRuo9/OA/kGNNAxIhz8Rx0SJqa3DhtEBwDCQXpZUu9n
 5OSoy4Xj6sKDZ1SmzDxeiGJrl5oyP89/+mJ19qdqkfOh4ZWkgFX3kpx4VIJem4K3U3yP
 HE3bpDU2TNQ7+Eb2jR6AnLkBA+Y10Bma1RhWZi8/CFzobgiLw9tJQPIcUkfzk5F3YxyQ
 /fOMBdQyTZpXJI2dpDroeGtxweQBR9VDZDV1wHET8u2M+s1Vdz0ZxKIjUzUcdk3QtzXW
 UITw==
X-Gm-Message-State: AOJu0YwIs6aUFzM3PlaGJEypBBysmWONqkTAgsoEbzv06D6JP4sTur05
 IEKYAGiz/i1Rylwcua8yjSpaP9D1pV01CwA7r6Fxu0hzOIdMB7LhmgzaGW4DqsUPW3QwwRlBZVW
 MrHZWN65SwRkEjwmwFZGTbOP2Lekz9BBe57LtM58kJg==
X-Gm-Gg: AfdE7cm+cDvwwRi+vvPbTUUtnJUotf4APcZaGHnYZ6tCLvlWS28jjyV6ACwSXZmIGYJ
 WTwLLgKLDFjG/aT6ikW0ezXh61KhEkkPqOZCrJHuVVN1vi0WtEd4ZVoLx4g+DOP8TpwrpolyKd4
 NWuyEK50PlwV8lxNCso1qI44RpYRhCdAS7kPOiX+JhCmBLCAsPudiDfK3+PnaZAFG8jOnOMpMuT
 y5vEZAinSRWDjWUFBesvzPSkJj8JZJLExHRy/k2OovJnfV6Hq/gYkVs1HFOqq5zWvj5tm2Ysx9U
 n80q/6Hpbmgk9/DY0CazAr2EghIotJvACSCZ0hfndBDEMLIB55IheuNZ
X-Received: by 2002:a05:690e:12cd:b0:660:9c4e:a44d with SMTP id
 956f58d0204a3-662ffb9debbmr2806674d50.6.1781875554650; Fri, 19 Jun 2026
 06:25:54 -0700 (PDT)
MIME-Version: 1.0
References: <20260618041517.573469-1-richard.henderson@linaro.org>
 <20260618041517.573469-3-richard.henderson@linaro.org>
In-Reply-To: <20260618041517.573469-3-richard.henderson@linaro.org>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Fri, 19 Jun 2026 14:25:42 +0100
X-Gm-Features: AVVi8Cchnmh601OAB8Yq4L0hXPGNl_WpOAT-D5yr8087_3dmWKNZVgZyVVe6vmk
Message-ID: <CAFEAcA-eQ9Wrd=6t_t47AJ2WbW2MNm7dmrycyet-LBFF7zhfZA@mail.gmail.com>
Subject: Re: [PATCH 02/10] target/arm: Implement FMOPA (widening,
 4-way fp8 to fp32)
To: Richard Henderson <richard.henderson@linaro.org>
Cc: qemu-devel@nongnu.org, qemu-arm@nongnu.org
Content-Type: text/plain; charset="UTF-8"
Received-SPF: pass client-ip=2607:f8b0:4864:20::b12a;
 envelope-from=peter.maydell@linaro.org; helo=mail-yx1-xb12a.google.com
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

On Thu, 18 Jun 2026 at 05:16, Richard Henderson
<richard.henderson@linaro.org> wrote:
>
> Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
> ---

Reviewed-by: Peter Maydell <peter.maydell@linaro.org>

thanks
-- PMM

